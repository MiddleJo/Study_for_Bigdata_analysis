from sklearn.metrics import roc_auc_score
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import GridSearchCV
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

X_data = pd.read_csv('./X_train.csv', encoding='CP949')
y_data = pd.read_csv('./y_train.csv', encoding='CP949')

X_data = X_data.drop(['cust_id', '최대구매액'], axis=1)

# 환불금액으로 부터 고객의 환불 경향을 반영하는 파생변수 '환불' 도출
X_data['환불금액'].fillna(0, inplace=True)
X_data['환불'] = X_data.환불금액.apply(lambda x: 1 if x > 0 else 0)
X_data.drop('환불금액', axis=1, inplace=True)

le = LabelEncoder()
features = ['주구매상품', '주구매지점']
for feature in features:
    X_data[feature] = le.fit_transform(X_data[feature])

features = ['총구매액']
scaler = MinMaxScaler()
for feature in features:
    X_data[feature] = scaler.fit_transform(X_data[[feature]])

y_data = y_data['gender']

X_train, X_test, y_train, y_test = train_test_split(
    X_data, y_data, test_size=0.3, random_state=10)

rf_model = RandomForestClassifier()
rf_model.fit(X_train, y_train)
rf_pred_proba = rf_model.predict_proba(X_test)[:, 1]
roc_rf = roc_auc_score(y_test, rf_pred_proba)
print(roc_rf, '\n')

params = {'n_estimators': [50, 100, 200],
          'max_depth': [10, 12, 15, 20],
          'min_samples_leaf': [6, 8, 10],
          'min_samples_split': [6, 8, 10]}
rf_model = RandomForestClassifier(random_state=0, n_jobs=-1)
grid_cv = GridSearchCV(rf_model, param_grid=params, cv=3, n_jobs=-1)

grid_cv.fit(X_train, y_train)

print('최적 하이퍼 파라미터:\n', grid_cv.best_params_)

best_gr_clf = grid_cv.best_estimator_
pred_proba = best_gr_clf.predict_proba(X_test)[:, 1]
auc = roc_auc_score(y_test, pred_proba)
print('auc:{0:.4f}'.format(auc), '\n')


X_df = pd.read_csv('./X_test.csv', encoding='cp949')

X_test = X_df.drop(['cust_id', '최대구매액'], axis=1)

# 환불금액으로 부터 고객의 환불 경향을 반영하는 파생변수 '환불' 도출
X_test['환불금액'].fillna(0, inplace=True)
X_test['환불'] = X_test.환불금액.apply(lambda x: 1 if x > 0 else 0)
X_test.drop('환불금액', axis=1, inplace=True)

le = LabelEncoder()
features = ['주구매상품', '주구매지점']
for feature in features:
    X_test[feature] = le.fit_transform(X_test[feature])

# print(X_test.head())

features = ['총구매액']
scaler = MinMaxScaler()
for feature in features:
    X_test[feature] = scaler.fit_transform(X_test[[feature]])
# print(X_test.head())

y_pred = best_gr_clf.predict(X_test)

y_test = pd.DataFrame(y_pred, columns=['gender'], index=X_df.cust_id)
y_test.reset_index(inplace=True)
print(y_test, '\n')
print(len(y_test[y_test.gender > 0.5]))
y_test.to_csv('./수험번호.csv', index=None)
