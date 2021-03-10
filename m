Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9733342D
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 05:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhCJEFb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 9 Mar 2021 23:05:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232282AbhCJEFG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Mar 2021 23:05:06 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12A43G09028755
        for <bpf@vger.kernel.org>; Tue, 9 Mar 2021 20:05:06 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 376mhb8gp5-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Mar 2021 20:05:05 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Mar 2021 20:05:02 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 72E4B2ED1C92; Tue,  9 Mar 2021 20:04:55 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 10/10] selftests/bpf: add multi-file statically linked BPF object file test
Date:   Tue, 9 Mar 2021 20:04:31 -0800
Message-ID: <20210310040431.916483-11-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210310040431.916483-1-andrii@kernel.org>
References: <20210310040431.916483-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_03:2021-03-09,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add Makefile infra to specify multi-file BPF object files (and derivative
skeletons). Add first selftest validating BPF static linker can merge together
successfully two independent BPF object files and resulting object and
skeleton are correct and usable.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          | 12 ++++++
 .../selftests/bpf/prog_tests/static_linked.c  | 40 +++++++++++++++++++
 .../selftests/bpf/progs/test_static_linked1.c | 30 ++++++++++++++
 .../selftests/bpf/progs/test_static_linked2.c | 31 ++++++++++++++
 4 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/static_linked.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_static_linked1.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_static_linked2.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 45a2ae1916ed..4d2f189d69dc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -303,6 +303,10 @@ endef
 
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 
+LINKED_SKELS := test_static_linked.skel.h
+
+test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
+
 # Set up extra TRUNNER_XXX "temporary" variables in the environment (relies on
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
 # Parameters:
@@ -323,6 +327,7 @@ TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS)
 TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
 				 $$(filter-out $(SKEL_BLACKLIST),	\
 					       $$(TRUNNER_BPF_SRCS)))
+TRUNNER_BPF_SKELS_LINKED := $$(addprefix $$(TRUNNER_OUTPUT)/,$(LINKED_SKELS))
 TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
 
 # Evaluate rules now with extra TRUNNER_XXX variables above already defined
@@ -359,6 +364,12 @@ $(TRUNNER_BPF_SKELS): %.skel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(BPFTOOL) gen bpfo $$(<:.o=.bpfo) $$<
 	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.bpfo) > $$@
+
+$(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFTOOL) | $(TRUNNER_OUTPUT)
+	$$(call msg,LINK-BPF,$(TRUNNER_BINARY),$$(@:.skel.h=.bpfo))
+	$(Q)$$(BPFTOOL) gen bpfo $$(@:.skel.h=.bpfo) $$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps))
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
+	$(Q)$$(BPFTOOL) gen skeleton $$(@:.skel.h=.bpfo) > $$@
 endif
 
 # ensure we set up tests.h header generation rule just once
@@ -380,6 +391,7 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_EXTRA_HDRS)				\
 		      $(TRUNNER_BPF_OBJS)				\
 		      $(TRUNNER_BPF_SKELS)				\
+		      $(TRUNNER_BPF_SKELS_LINKED)			\
 		      $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
diff --git a/tools/testing/selftests/bpf/prog_tests/static_linked.c b/tools/testing/selftests/bpf/prog_tests/static_linked.c
new file mode 100644
index 000000000000..46556976dccc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/static_linked.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook */
+
+#include <test_progs.h>
+#include "test_static_linked.skel.h"
+
+void test_static_linked(void)
+{
+	int err;
+	struct test_static_linked* skel;
+
+	skel = test_static_linked__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->rodata->rovar1 = 1;
+	skel->bss->static_var1 = 2;
+	skel->bss->static_var11 = 3;
+
+	skel->rodata->rovar2 = 4;
+	skel->bss->static_var2 = 5;
+	skel->bss->static_var22 = 6;
+
+	err = test_static_linked__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	err = test_static_linked__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* trigger */
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->var1, 1 * 2 + 2 + 3, "var1");
+	ASSERT_EQ(skel->bss->var2, 4 * 3 + 5 + 6, "var2");
+
+cleanup:
+	test_static_linked__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_static_linked1.c b/tools/testing/selftests/bpf/progs/test_static_linked1.c
new file mode 100644
index 000000000000..ea1a6c4c7172
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_static_linked1.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* 8-byte aligned .bss */
+static volatile long static_var1;
+static volatile int static_var11;
+int var1 = 0;
+/* 4-byte aligned .rodata */
+const volatile int rovar1;
+
+/* same "subprog" name in both files */
+static __noinline int subprog(int x)
+{
+	/* but different formula */
+	return x * 2;
+}
+
+SEC("raw_tp/sys_enter")
+int handler1(const void *ctx)
+{
+	var1 = subprog(rovar1) + static_var1 + static_var11;
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
+int VERSION SEC("version") = 1;
diff --git a/tools/testing/selftests/bpf/progs/test_static_linked2.c b/tools/testing/selftests/bpf/progs/test_static_linked2.c
new file mode 100644
index 000000000000..54d8d1ab577c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_static_linked2.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* 4-byte aligned .bss */
+static volatile int static_var2;
+static volatile int static_var22;
+int var2 = 0;
+/* 8-byte aligned .rodata */
+const volatile long rovar2;
+
+/* same "subprog" name in both files */
+static __noinline int subprog(int x)
+{
+	/* but different formula */
+	return x * 3;
+}
+
+SEC("raw_tp/sys_enter")
+int handler2(const void *ctx)
+{
+	var2 = subprog(rovar2) + static_var2 + static_var22;
+
+	return 0;
+}
+
+/* different name and/or type of the variable doesn't matter */
+char _license[] SEC("license") = "GPL";
+int _version SEC("version") = 1;
-- 
2.24.1

