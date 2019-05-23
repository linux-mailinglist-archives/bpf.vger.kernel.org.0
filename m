Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93D28AC4
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 21:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbfEWTqd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 May 2019 15:46:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52030 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388955AbfEWTqP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 May 2019 15:46:15 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4NJbjdJ003916
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 12:46:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=QQiS0Ec1c0IdH4uQub/iylmmyoLnQRDNT9RhJZZHNRU=;
 b=esCI981y+85aqemW0WXPtvUq1G3zEHwcKEGsexPTEAZpvMtEczpJ9R7f9wPX/LFWmf6n
 oigrPe+Kd6yhkHeCrPUJe/fVzS2tMZUnf+jbIuQEqI8yDZJp1y9JGbGtsxilJVLd74U3
 v7RU9FvVeeUWjkG2wmtGCEI315AFDzy7laE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2snt3p9sjs-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 12:46:14 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 May 2019 12:46:10 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 4EFFA125B0481; Thu, 23 May 2019 12:45:33 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Yonghong Song <yhs@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 2/4] selftests/bpf: convert test_cgrp2_attach2 example into kselftest
Date:   Thu, 23 May 2019 12:45:30 -0700
Message-ID: <20190523194532.2376233-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523194532.2376233-1-guro@fb.com>
References: <20190523194532.2376233-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230127
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert test_cgrp2_attach2 example into a proper test_cgroup_attach
kselftest. It's better because we do run kselftest on a constant
basis, so there are better chances to spot a potential regression.

Also make it slightly less verbose to conform kselftests output style.

Output example:
  $ ./test_cgroup_attach
  #override:PASS
  #multi:PASS
  test_cgroup_attach:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 samples/bpf/Makefile                          |  2 -
 tools/testing/selftests/bpf/Makefile          |  4 +-
 .../selftests/bpf/test_cgroup_attach.c        | 50 ++++++++++++-------
 3 files changed, 36 insertions(+), 20 deletions(-)
 rename samples/bpf/test_cgrp2_attach2.c => tools/testing/selftests/bpf/test_cgroup_attach.c (91%)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4f0a1cdbfe7c..253e5a2856be 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -26,7 +26,6 @@ hostprogs-y += map_perf_test
 hostprogs-y += test_overhead
 hostprogs-y += test_cgrp2_array_pin
 hostprogs-y += test_cgrp2_attach
-hostprogs-y += test_cgrp2_attach2
 hostprogs-y += test_cgrp2_sock
 hostprogs-y += test_cgrp2_sock2
 hostprogs-y += xdp1
@@ -81,7 +80,6 @@ map_perf_test-objs := bpf_load.o map_perf_test_user.o
 test_overhead-objs := bpf_load.o test_overhead_user.o
 test_cgrp2_array_pin-objs := test_cgrp2_array_pin.o
 test_cgrp2_attach-objs := test_cgrp2_attach.o
-test_cgrp2_attach2-objs := test_cgrp2_attach2.o $(CGROUP_HELPERS)
 test_cgrp2_sock-objs := test_cgrp2_sock.o
 test_cgrp2_sock2-objs := bpf_load.o test_cgrp2_sock2.o
 xdp1-objs := xdp1_user.o
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 66f2dca1dee1..e09f419f4d7e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -23,7 +23,8 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
 	test_socket_cookie test_cgroup_storage test_select_reuseport test_section_names \
-	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl
+	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl \
+	test_cgroup_attach
 
 BPF_OBJ_FILES = $(patsubst %.c,%.o, $(notdir $(wildcard progs/*.c)))
 TEST_GEN_FILES = $(BPF_OBJ_FILES)
@@ -96,6 +97,7 @@ $(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
 $(OUTPUT)/test_netcnt: cgroup_helpers.c
 $(OUTPUT)/test_sock_fields: cgroup_helpers.c
 $(OUTPUT)/test_sysctl: cgroup_helpers.c
+$(OUTPUT)/test_cgroup_attach: cgroup_helpers.c
 
 .PHONY: force
 
diff --git a/samples/bpf/test_cgrp2_attach2.c b/tools/testing/selftests/bpf/test_cgroup_attach.c
similarity index 91%
rename from samples/bpf/test_cgrp2_attach2.c
rename to tools/testing/selftests/bpf/test_cgroup_attach.c
index 0bb6507256b7..2d6d57f50e10 100644
--- a/samples/bpf/test_cgrp2_attach2.c
+++ b/tools/testing/selftests/bpf/test_cgroup_attach.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /* eBPF example program:
  *
  * - Creates arraymap in kernel with 4 bytes keys and 8 byte values
@@ -25,20 +27,27 @@
 #include <sys/resource.h>
 #include <sys/time.h>
 #include <unistd.h>
+#include <linux/filter.h>
 
 #include <linux/bpf.h>
 #include <bpf/bpf.h>
 
-#include "bpf_insn.h"
+#include "bpf_util.h"
 #include "bpf_rlimit.h"
 #include "cgroup_helpers.h"
 
 #define FOO		"/foo"
 #define BAR		"/foo/bar/"
-#define PING_CMD	"ping -c1 -w1 127.0.0.1 > /dev/null"
+#define PING_CMD	"ping -q -c1 -w1 127.0.0.1 > /dev/null"
 
 char bpf_log_buf[BPF_LOG_BUF_SIZE];
 
+#ifdef DEBUG
+#define debug(args...) printf(args)
+#else
+#define debug(args...)
+#endif
+
 static int prog_load(int verdict)
 {
 	int ret;
@@ -89,7 +98,7 @@ static int test_foo_bar(void)
 		goto err;
 	}
 
-	printf("Attached DROP prog. This ping in cgroup /foo should fail...\n");
+	debug("Attached DROP prog. This ping in cgroup /foo should fail...\n");
 	assert(system(PING_CMD) != 0);
 
 	/* Create cgroup /foo/bar, get fd, and join it */
@@ -100,7 +109,7 @@ static int test_foo_bar(void)
 	if (join_cgroup(BAR))
 		goto err;
 
-	printf("Attached DROP prog. This ping in cgroup /foo/bar should fail...\n");
+	debug("Attached DROP prog. This ping in cgroup /foo/bar should fail...\n");
 	assert(system(PING_CMD) != 0);
 
 	if (bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS,
@@ -109,7 +118,7 @@ static int test_foo_bar(void)
 		goto err;
 	}
 
-	printf("Attached PASS prog. This ping in cgroup /foo/bar should pass...\n");
+	debug("Attached PASS prog. This ping in cgroup /foo/bar should pass...\n");
 	assert(system(PING_CMD) == 0);
 
 	if (bpf_prog_detach(bar, BPF_CGROUP_INET_EGRESS)) {
@@ -117,7 +126,7 @@ static int test_foo_bar(void)
 		goto err;
 	}
 
-	printf("Detached PASS from /foo/bar while DROP is attached to /foo.\n"
+	debug("Detached PASS from /foo/bar while DROP is attached to /foo.\n"
 	       "This ping in cgroup /foo/bar should fail...\n");
 	assert(system(PING_CMD) != 0);
 
@@ -132,7 +141,7 @@ static int test_foo_bar(void)
 		goto err;
 	}
 
-	printf("Attached PASS from /foo/bar and detached DROP from /foo.\n"
+	debug("Attached PASS from /foo/bar and detached DROP from /foo.\n"
 	       "This ping in cgroup /foo/bar should pass...\n");
 	assert(system(PING_CMD) == 0);
 
@@ -199,9 +208,9 @@ static int test_foo_bar(void)
 	close(bar);
 	cleanup_cgroup_environment();
 	if (!rc)
-		printf("### override:PASS\n");
+		printf("#override:PASS\n");
 	else
-		printf("### override:FAIL\n");
+		printf("#override:FAIL\n");
 	return rc;
 }
 
@@ -441,19 +450,26 @@ static int test_multiprog(void)
 	close(cg5);
 	cleanup_cgroup_environment();
 	if (!rc)
-		printf("### multi:PASS\n");
+		printf("#multi:PASS\n");
 	else
-		printf("### multi:FAIL\n");
+		printf("#multi:FAIL\n");
 	return rc;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
-	int rc = 0;
+	int (*tests[])(void) = {test_foo_bar, test_multiprog};
+	int errors = 0;
+	int i;
 
-	rc = test_foo_bar();
-	if (rc)
-		return rc;
+	for (i = 0; i < ARRAY_SIZE(tests); i++)
+		if (tests[i]())
+			errors++;
+
+	if (errors)
+		printf("test_cgroup_attach:FAIL\n");
+	else
+		printf("test_cgroup_attach:PASS\n");
 
-	return test_multiprog();
+	return errors ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-- 
2.20.1

