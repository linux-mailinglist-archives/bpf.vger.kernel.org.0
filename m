Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE787447A5D
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 07:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbhKHGQM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 8 Nov 2021 01:16:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40880 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237677AbhKHGQK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 01:16:10 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A7Jw9eN018091
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 22:13:27 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c698wdk5t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 22:13:26 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 22:13:24 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7B70F84C4986; Sun,  7 Nov 2021 22:13:23 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 03/11] selftests/bpf: allow to generate per-flavor list of tests
Date:   Sun, 7 Nov 2021 22:13:08 -0800
Message-ID: <20211108061316.203217-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108061316.203217-1-andrii@kernel.org>
References: <20211108061316.203217-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: tyl-Schu-NJpZMC-Dy6rZhEqFbjuPKpi
X-Proofpoint-ORIG-GUID: tyl-Schu-NJpZMC-Dy6rZhEqFbjuPKpi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111080041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add per-flavor list of tests to test_progs/test_maps test runners. Allow
to filter out some tests. This is going to be used in the next patch to
filter out tests that are using internal libbpf APIs and thus are not
compatible with test_progs built with libbpf as a shared library.

The way this is achieved is by generating test headers with test
binary-specific name and passing it explicitly to compiled test runners
through TESTS_HDR compiler define.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore   |  7 ++++---
 tools/testing/selftests/bpf/Makefile     | 25 +++++++++++-------------
 tools/testing/selftests/bpf/test_maps.c  |  4 ++--
 tools/testing/selftests/bpf/test_progs.c |  6 +++---
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 1dad8d617da8..b6bc56c8127a 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -9,9 +9,6 @@ test_tag
 FEATURE-DUMP.libbpf
 fixdep
 test_dev_cgroup
-/test_progs
-/test_progs-no_alu32
-/test_progs-bpf_gcc
 test_verifier_log
 feature
 test_sock
@@ -32,6 +29,10 @@ xdping
 test_cpp
 *.skel.h
 *.lskel.h
+*.tests.h
+/test_progs
+/test_progs-no_alu32
+/test_progs-bpf_gcc
 /no_alu32
 /bpf_gcc
 /tools
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0470802c907c..33f153a9de4c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -344,14 +344,15 @@ LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-d
 # $2 - test runner extra "flavor" (e.g., no_alu32, gcc-bpf, etc)
 define DEFINE_TEST_RUNNER
 
-TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
+TRUNNER_OUTPUT := $(if $(OUTPUT),$(OUTPUT),.)$(if $2,/)$2
 TRUNNER_BINARY := $1$(if $2,-)$2
-TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
-				 $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/*.c)))
+TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	       \
+				 $$(filter-out $(TRUNNER_TESTS_BLACKLIST),     \
+					       $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/*.c))))
 TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
 				 $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
 TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
-TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
+TRUNNER_TESTS_HDR := $$(TRUNNER_OUTPUT)/$1.tests.h
 TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
 TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS))
 TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
@@ -418,16 +419,13 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$(Q)$$(BPFTOOL) gen skeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$@
 endif
 
-# ensure we set up tests.h header generation rule just once
-ifeq ($($(TRUNNER_TESTS_DIR)-tests-hdr),)
-$(TRUNNER_TESTS_DIR)-tests-hdr := y
-$(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c
+$(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c | $(TRUNNER_OUTPUT)
 	$$(call msg,TEST-HDR,$(TRUNNER_BINARY),$$@)
-	$$(shell (echo '/* Generated header, do not edit */';					\
+	$$(shell (echo '/* Generated header, do not edit */';						\
 		  sed -n -E 's/^void (serial_)?test_([a-zA-Z0-9_]+)\((void)?\).*/DEFINE_TEST(\2)/p'	\
-			$(TRUNNER_TESTS_DIR)/*.c | sort ;	\
+			$(filter-out $(addprefix $(TRUNNER_TESTS_DIR)/,$(TRUNNER_TESTS_BLACKLIST)),	\
+				     $(wildcard $(TRUNNER_TESTS_DIR)/*.c)) | sort ;			\
 		 ) > $$@)
-endif
 
 # compile individual test files
 # Note: we cd into output directory to ensure embedded BPF object is found
@@ -448,7 +446,7 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 		       $(TRUNNER_TESTS_HDR)				\
 		       $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) -DTESTS_HDR=\"$(TRUNNER_TESTS_HDR)\" -c $$< $$(LDLIBS) -o $$@
 
 # non-flavored in-srctree builds receive special treatment, in particular, we
 # do not need to copy extra resources (see e.g. test_btf_dump_case())
@@ -543,8 +541,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
 	$(Q)$(CC) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
-	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
-	feature								\
+	*.tests.h verifier/tests.h					\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h no_alu32 bpf_gcc bpf_testmod.ko)
 
 .PHONY: docs docs-clean
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 8b31bc1a801d..daddaf4f3e5a 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1887,7 +1887,7 @@ static void run_all_tests(void)
 }
 
 #define DEFINE_TEST(name) extern void test_##name(void);
-#include <map_tests/tests.h>
+#include TESTS_HDR
 #undef DEFINE_TEST
 
 int main(void)
@@ -1903,7 +1903,7 @@ int main(void)
 	run_all_tests();
 
 #define DEFINE_TEST(name) test_##name();
-#include <map_tests/tests.h>
+#include TESTS_HDR
 #undef DEFINE_TEST
 
 	printf("test_maps: OK, %d SKIPPED\n", skips);
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index c65986bd9d07..7c078565ee9d 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -461,7 +461,7 @@ static int load_bpf_testmod(void)
 #define DEFINE_TEST(name)				\
 	extern void test_##name(void) __weak;		\
 	extern void serial_test_##name(void) __weak;
-#include <prog_tests/tests.h>
+#include TESTS_HDR
 #undef DEFINE_TEST
 
 static struct prog_test_def prog_test_defs[] = {
@@ -470,7 +470,7 @@ static struct prog_test_def prog_test_defs[] = {
 	.run_test = &test_##name,		\
 	.run_serial_test = &serial_test_##name,	\
 },
-#include <prog_tests/tests.h>
+#include TESTS_HDR
 #undef DEFINE_TEST
 };
 const int prog_test_cnt = ARRAY_SIZE(prog_test_defs);
@@ -1377,7 +1377,7 @@ int main(int argc, char **argv)
 
 		if ((test->run_test == NULL && test->run_serial_test == NULL) ||
 		    (test->run_test != NULL && test->run_serial_test != NULL)) {
-			fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test_%sl() defined.\n",
+			fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test_%s() defined.\n",
 				test->test_num, test->test_name, test->test_name, test->test_name);
 			exit(EXIT_ERR_SETUP_INFRA);
 		}
-- 
2.30.2

