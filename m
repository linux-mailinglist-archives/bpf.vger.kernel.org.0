Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974B15B9469
	for <lists+bpf@lfdr.de>; Thu, 15 Sep 2022 08:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiIOG3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Sep 2022 02:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIOG3O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Sep 2022 02:29:14 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201F695ACC;
        Wed, 14 Sep 2022 23:29:03 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MSnKt4jlkzBsJy;
        Thu, 15 Sep 2022 14:26:58 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 15 Sep
 2022 14:28:59 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <shuah@kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next,v3 9/9] selftests/tc-testings: add list case for basic filter
Date:   Thu, 15 Sep 2022 14:30:38 +0800
Message-ID: <20220915063038.20010-10-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915063038.20010-1-shaozhengchao@huawei.com>
References: <20220915063038.20010-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test 0811: Add multiple basic filter with cmp ematch u8/link layer and
default action and dump them
Test 5129: List basic filters

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/basic.json    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json b/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json
index e788c114a484..d1278de8ebc3 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/basic.json
@@ -1274,5 +1274,52 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
         ]
+    },
+    {
+        "id": "0811",
+        "name": "Add multiple basic filter with cmp ematch u8/link layer and default action and dump them",
+        "category": [
+            "filter",
+            "basic"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 1 basic match 'cmp(u8 at 0 layer link mask 0xff gt 10)' classid 1:1"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 2 protocol ip prio 1 basic match 'cmp(u8 at 0 layer link mask 0xff gt 10)' classid 1:1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "^filter protocol ip pref 1 basic",
+        "matchCount": "3",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "5129",
+        "name": "List basic filters",
+        "category": [
+            "filter",
+            "basic"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: handle 1 protocol ip prio 1 basic match 'cmp(u8 at 0 layer link mask 0xff gt 10)' classid 1:1",
+            "$TC filter add dev $DEV1 parent ffff: handle 2 protocol ip prio 1 basic match 'cmp(u8 at 0 layer link mask 0xff gt 10)' classid 1:1"
+        ],
+        "cmdUnderTest": "$TC filter show dev $DEV1 parent ffff:",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "cmp\\(u8 at 0 layer 0 mask 0xff gt 10\\)",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
     }
 ]
-- 
2.17.1

