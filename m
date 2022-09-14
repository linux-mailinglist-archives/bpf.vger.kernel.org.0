Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A5D5B85DB
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiINKBJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 06:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiINKBC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 06:01:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771DA6717D;
        Wed, 14 Sep 2022 03:00:47 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSG2h3b2LzmVKy;
        Wed, 14 Sep 2022 17:57:00 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 18:00:44 +0800
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
Subject: [PATCH net-next,v2 7/9] selftests/tc-testings: add selftests for rsvp filter
Date:   Wed, 14 Sep 2022 18:02:19 +0800
Message-ID: <20220914100221.386855-8-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914100221.386855-1-shaozhengchao@huawei.com>
References: <20220914100221.386855-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Test 2141: Add rsvp filter with tcp proto and specific IP address
Test 5267: Add rsvp filter with udp proto and specific IP address
Test 2819: Add rsvp filter with src ip and src port
Test c967: Add rsvp filter with tunnelid and continue action
Test 5463: Add rsvp filter with tunnel and pipe action
Test 2332: Add rsvp filter with miltiple actions
Test 8879: Add rsvp filter with tunnel and skp flag
Test 8261: List rsvp filters
Test 8989: Delete rsvp filter

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 .../tc-testing/tc-tests/filters/rsvp.json     | 203 ++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/filters/rsvp.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/rsvp.json b/tools/testing/selftests/tc-testing/tc-tests/filters/rsvp.json
new file mode 100644
index 000000000000..08ec9932a2e5
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/rsvp.json
@@ -0,0 +1,203 @@
+[
+    {
+        "id": "2141",
+        "name": "Add rsvp filter with tcp proto and specific IP address",
+        "category": [
+            "filter",
+            "rsvp"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: protocol ip prio 1 rsvp ipproto tcp session 198.168.10.64",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "^filter protocol ip pref [0-9]+ rsvp chain [0-9]+ fh 0x.*session 198.168.10.64 ipproto tcp",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "5267",
+        "name": "Add rsvp filter with udp proto and specific IP address",
+        "category": [
+            "filter",
+            "rsvp"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: protocol ip prio 1 rsvp ipproto udp session 1.1.1.1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "^filter protocol ip pref [0-9]+ rsvp chain [0-9]+ fh 0x.*session 1.1.1.1 ipproto udp",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "2819",
+        "name": "Add rsvp filter with src ip and src port",
+        "category": [
+            "filter",
+            "rsvp"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: protocol ip prio 1 rsvp ipproto udp session 1.1.1.1 sender 2.2.2.2/5021 classid 1:1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "^filter protocol ip pref [0-9]+ rsvp chain [0-9]+ fh 0x.*flowid 1:1 session 1.1.1.1 ipproto udp sender  2.2.2.2/5021",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "c967",
+        "name": "Add rsvp filter with tunnelid and continue action",
+        "category": [
+            "filter",
+            "rsvp"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: protocol ip prio 1 rsvp ipproto udp session 1.1.1.1 tunnelid 2 classid 1:1 action continue",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "^filter protocol ip pref [0-9]+ rsvp chain [0-9]+ fh 0x.*flowid 1:1 session 1.1.1.1 ipproto udp tunnelid 2.*action order [0-9]+: gact action continue",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "5463",
+        "name": "Add rsvp filter with tunnel and pipe action",
+        "category": [
+            "filter",
+            "rsvp"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: protocol ip prio 1 rsvp ipproto udp session 1.1.1.1 tunnel 2 skip 1 action pipe",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "^filter protocol ip pref [0-9]+ rsvp chain [0-9]+ fh 0x.*tunnel 2 skip 1 session 1.1.1.1 ipproto udp.*action order [0-9]+: gact action pipe",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "2332",
+        "name": "Add rsvp filter with miltiple actions",
+        "category": [
+            "filter",
+            "rsvp"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: protocol ip prio 7 rsvp ipproto udp session 1.1.1.1 classid 1:1 action skbedit mark 7 pipe action gact drop",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "^filter protocol ip pref [0-9]+ rsvp chain [0-9]+ fh 0x.*flowid 1:1 session 1.1.1.1 ipproto udp.*action order [0-9]+: skbedit  mark 7 pipe.*action order [0-9]+: gact action drop",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "8879",
+        "name": "Add rsvp filter with tunnel and skp flag",
+        "category": [
+            "filter",
+            "rsvp"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: protocol ip prio 1 rsvp ipproto udp session 1.1.1.1 tunnel 2 skip 1 action pipe",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "^filter protocol ip pref [0-9]+ rsvp chain [0-9]+ fh 0x.*tunnel 2 skip 1 session 1.1.1.1 ipproto udp.*action order [0-9]+: gact action pipe",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "8261",
+        "name": "List rsvp filters",
+        "category": [
+            "filter",
+            "rsvp"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 1 rsvp ipproto udp session 1.1.1.1/1234 classid 1:1",
+	    "$TC filter add dev $DEV1 parent ffff: protocol ip prio 1 rsvp ipproto tcp session 2.2.2.2/1234 classid 2:1"
+        ],
+        "cmdUnderTest": "$TC filter show dev $DEV1 parent ffff:",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "^filter protocol ip pref [0-9]+ rsvp chain [0-9]+ fh",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    },
+    {
+        "id": "8989",
+        "name": "Delete rsvp filter",
+        "category": [
+            "filter",
+            "rsvp"
+        ],
+	"plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress",
+            "$TC filter add dev $DEV1 parent ffff: protocol ip prio 1 rsvp ipproto udp session 1.1.1.1/1234 tunnelid 9 classid 2:1"
+        ],
+        "cmdUnderTest": "$TC filter del dev $DEV1 parent ffff: protocol ip prio 1 rsvp ipproto udp session 1.1.1.1/1234 tunnelid 9 classid 2:1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 parent ffff:",
+        "matchPattern": "filter protocol ip pref [0-9]+ rsvp chain [0-9]+ fh 0x.*flowid 2:1 session 1.1.1.1/1234 ipproto udp tunnelid 9",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 ingress"
+        ]
+    }
+]
-- 
2.17.1

