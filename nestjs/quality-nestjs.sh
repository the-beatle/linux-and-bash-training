#!/usr/bin/env bash

ROOT_DIR="/c/Users/Mario_Cano/cloudx/shop-angular-cloudfront"
cd "$ROOT_DIR"
ng lint
ng test
npm audit
