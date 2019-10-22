Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D98DFCC2
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 06:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfJVEb0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 00:31:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48102 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725907AbfJVEb0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Oct 2019 00:31:26 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9M4UrkF029574
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2019 21:31:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=bV9URkldOALXlV5J70wqTrtFb9G8fhOx7xRULQYXeIA=;
 b=mA77wLI5Kpd20HrT46OqHSnASTWwacG6LYLMHS29+B/YEqxqF16G8gdHcbkGJED0uEtZ
 TuXL4zVti9FaLtkB/Hh+yNi969+R7wTsMgjAkvJnTP9NBbefQbJ0Jwne2Z0yGI0mYwT7
 vB0Sypi6H+Yj9bzWOhRjJhTm4mFMnuLVzCI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vst9704ey-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2019 21:31:25 -0700
Received: from 2401:db00:2120:80d4:face:0:39:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Oct 2019 21:31:23 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id CA3CC3702FC5; Mon, 21 Oct 2019 21:31:19 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Jiong Wang <jiong.wang@netronome.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2] tools/bpf: turn on llvm alu32 attribute by default
Date:   Mon, 21 Oct 2019 21:31:19 -0700
Message-ID: <20191022043119.2625263-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_02:2019-10-21,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=1 priorityscore=1501 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220045
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

llvm alu32 was introduced in llvm7:
  https://reviews.llvm.org/rL325987
  https://reviews.llvm.org/rL325989
Experiments showed that in general performance
is better with alu32 enabled:
  https://lwn.net/Articles/775316/

This patch turned on alu32 with no-flavor test_progs
which is tested most often. The flavor test at
no_alu32/test_progs can be used to test without
alu32 enabled. The Makefile check for whether
llvm supports '-mattr=+alu32 -mcpu=v3' is
removed as llvm7 should be available for recent
distributions and also latest llvm is preferred
to run bpf selftests.

Note that jmp32 is checked by -mcpu=probe and
will be enabled if the host kernel supports it.

Cc: Jiong Wang <jiong.wang@netronome.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

Changelogs:
 v1 -> v2:
   . add test_progs-no_alu32 to initial TEST_GEN_PROGS definition
     unconditionally.

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4ff5f4aada08..11ff34e7311b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -30,17 +30,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
 	test_cgroup_storage test_select_reuseport test_section_names \
 	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl test_hashmap \
-	test_cgroup_attach xdping
-
-# Also test sub-register code-gen if LLVM has eBPF v3 processor support which
-# contains both ALU32 and JMP32 instructions.
-SUBREG_CODEGEN := $(shell echo "int cal(int a) { return a > 0; }" | \
-			$(CLANG) -target bpf -O2 -emit-llvm -S -x c - -o - | \
-			$(LLC) -mattr=+alu32 -mcpu=v3 2>&1 | \
-			grep 'if w')
-ifneq ($(SUBREG_CODEGEN),)
-TEST_GEN_PROGS += test_progs-alu32
-endif
+	test_cgroup_attach xdping test_progs-no_alu32
 
 # Also test bpf-gcc, if present
 ifneq ($(BPF_GCC),)
@@ -179,7 +169,7 @@ endef
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
 # Parameters:
 # $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., alu32, gcc-bpf, etc)
+# $2 - test runner extra "flavor" (e.g., no_alu32, gcc-bpf, etc)
 define DEFINE_TEST_RUNNER
 
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
@@ -201,7 +191,7 @@ endef
 # Using TRUNNER_XXX variables, provided by callers of DEFINE_TEST_RUNNER and
 # set up by DEFINE_TEST_RUNNER itself, create test runner build rules with:
 # $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., alu32, gcc-bpf, etc)
+# $2 - test runner extra "flavor" (e.g., no_alu32, gcc-bpf, etc)
 define DEFINE_TEST_RUNNER_RULES
 
 ifeq ($($(TRUNNER_OUTPUT)-dir),)
@@ -272,14 +262,12 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := -I. -I$(OUTPUT) $(BPF_CFLAGS) $(CLANG_CFLAGS)
-TRUNNER_BPF_LDFLAGS :=
+TRUNNER_BPF_LDFLAGS := -mattr=+alu32
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 
-# Define test_progs-alu32 test runner.
-ifneq ($(SUBREG_CODEGEN),)
-TRUNNER_BPF_LDFLAGS += -mattr=+alu32
-$(eval $(call DEFINE_TEST_RUNNER,test_progs,alu32))
-endif
+# Define test_progs-no_alu32 test runner.
+TRUNNER_BPF_LDFLAGS :=
+$(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
 
 # Define test_progs BPF-GCC-flavored test runner.
 ifneq ($(BPF_GCC),)
@@ -319,4 +307,4 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS)					\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
-	feature $(OUTPUT)/*.o $(OUTPUT)/alu32 $(OUTPUT)/bpf_gcc
+	feature $(OUTPUT)/*.o $(OUTPUT)/no_alu32 $(OUTPUT)/bpf_gcc
-- 
2.17.1

