Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A66F447A5F
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 07:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhKHGQP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 8 Nov 2021 01:16:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33590 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237670AbhKHGQO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 01:16:14 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A7LqSDW001651
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 22:13:30 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3c6962wmdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 22:13:30 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 22:13:29 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8BE2B84C4989; Sun,  7 Nov 2021 22:13:25 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 04/11] selftests/bpf: add test_progs flavor using libbpf as a shared lib
Date:   Sun, 7 Nov 2021 22:13:09 -0800
Message-ID: <20211108061316.203217-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108061316.203217-1-andrii@kernel.org>
References: <20211108061316.203217-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: ClykLjTRkxIzLLqv9E4T34pxeHoF4VrT
X-Proofpoint-GUID: ClykLjTRkxIzLLqv9E4T34pxeHoF4VrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test_progs-shared flavor to compile against libbpf as a shared
library. This is useful to make sure that libbpf's backwards/forward
compatibility guarantees are upheld. Currently this has to be checked
locally, but in the future we'll automate at least some scenarios as
part of libbpf CI runs.

Biggest change is how either libbpf.a or libbpf.so is passed to the
compiler, which is controled on per-flavor through a new TRUNNER_LIBBPF
parameter. All the places that depend on libbpf artifacts (headers,
library itself, etc) to be built are moved to order-only dependency on
$(BPFOBJ). rpath is used to specify relative location to where libbpf.so
should be so that when test_progs-shared is run under QEMU, libbpf.so is
still going to be discovered correctly.

Few selftests are using or testing internal libbpf APIs, so are not
compatible with shared library use of libbpf. Filter them out for shared
flavor.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore |  2 ++
 tools/testing/selftests/bpf/Makefile   | 36 +++++++++++++++++++-------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index b6bc56c8127a..5adfac44c478 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -32,8 +32,10 @@ test_cpp
 *.tests.h
 /test_progs
 /test_progs-no_alu32
+/test_progs-shared
 /test_progs-bpf_gcc
 /no_alu32
+/shared
 /bpf_gcc
 /tools
 /runqslower
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 33f153a9de4c..42bc7913cc1a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -32,16 +32,19 @@ ifneq ($(LLVM),)
 CFLAGS += -Wno-unused-command-line-argument
 endif
 
+TEST_RUNNERS = test_maps test_progs test_progs-no_alu32 test_progs-shared
+
 # Order correspond to 'make run_tests' order
-TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
+TEST_GEN_PROGS = test_verifier test_tag test_lru_map test_lpm_map \
 	test_verifier_log test_dev_cgroup \
 	test_sock test_sockmap get_cgroup_id_user \
 	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
-	test_progs-no_alu32
+	$(TEST_RUNNERS)
 
 # Also test bpf-gcc, if present
 ifneq ($(BPF_GCC),)
+TEST_RUNNERS += test_progs-bpf_gcc
 TEST_GEN_PROGS += test_progs-bpf_gcc
 endif
 
@@ -190,7 +193,9 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
 
 TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
 
-$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
+# Add libbpf.a dependency to all the test binaries but those in $(TEST_RUNNERS)
+$(filter-out $(addprefix %,$(TEST_RUNNERS)),$(TEST_GEN_PROGS)): $(BPFOBJ)
+$(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
 
 $(OUTPUT)/test_dev_cgroup: cgroup_helpers.c testing_helpers.o
 $(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c testing_helpers.o
@@ -436,7 +441,7 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_BPF_SKELS)				\
 		      $(TRUNNER_BPF_LSKELS)				\
 		      $(TRUNNER_BPF_SKELS_LINKED)			\
-		      $$(BPFOBJ) | $(TRUNNER_OUTPUT)
+		      | $$(BPFOBJ) $(TRUNNER_OUTPUT)
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
 
@@ -444,7 +449,7 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 		       %.c						\
 		       $(TRUNNER_EXTRA_HDRS)				\
 		       $(TRUNNER_TESTS_HDR)				\
-		       $$(BPFOBJ) | $(TRUNNER_OUTPUT)
+		       | $$(BPFOBJ) $(TRUNNER_OUTPUT)
 	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(CC) $$(CFLAGS) -DTESTS_HDR=\"$(TRUNNER_TESTS_HDR)\" -c $$< $$(LDLIBS) -o $$@
 
@@ -457,11 +462,11 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
 endif
 
 $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
-			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
+			     $(TRUNNER_EXTRA_OBJS)			\
 			     $(RESOLVE_BTFIDS)				\
-			     | $(TRUNNER_BINARY)-extras
+			     | $$(BPF_OBJ) $(TRUNNER_BINARY)-extras
 	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $(TRUNNER_LIBBPF) $$(LDLIBS) $(TRUNNER_EXTRA_CFLAGS) -o $$@
 	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
 
 endef
@@ -477,17 +482,29 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
+TRUNNER_LIBBPF := $(BPFOBJ)
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 
 # Define test_progs-no_alu32 test runner.
 TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
+TRUNNER_LIBBPF := $(BPFOBJ)
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
 
+# Define test_progs-shared test runner.
+TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
+TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
+TRUNNER_EXTRA_CFLAGS := -Wl,-rpath=$(subst $(CURDIR)/,,$(dir $(BPFOBJ)))
+TRUNNER_LIBBPF := $(patsubst %libbpf.a,%libbpf.so,$(BPFOBJ))
+TRUNNER_TESTS_BLACKLIST := cpu_mask.c hashmap.c perf_buffer.c raw_tp_test_run.c
+$(eval $(call DEFINE_TEST_RUNNER,test_progs,shared))
+TRUNNER_TESTS_BLACKLIST :=
+
 # Define test_progs BPF-GCC-flavored test runner.
 ifneq ($(BPF_GCC),)
 TRUNNER_BPF_BUILD_RULE := GCC_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(call get_sys_includes,gcc)
+TRUNNER_LIBBPF := $(BPFOBJ)
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,bpf_gcc))
 endif
 
@@ -542,6 +559,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	*.tests.h verifier/tests.h					\
-	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h no_alu32 bpf_gcc bpf_testmod.ko)
+	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h)			\
+	$(addprefix $(OUTPUT)/,no_alu32 shared bpf_gcc bpf_testmod.ko)
 
 .PHONY: docs docs-clean
-- 
2.30.2

