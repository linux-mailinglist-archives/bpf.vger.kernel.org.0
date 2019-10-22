Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B61CDFBAA
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 04:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfJVCcb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Oct 2019 22:32:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10960 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727264AbfJVCcb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 21 Oct 2019 22:32:31 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9M2TcAN007538
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2019 19:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=C/gQtJcZSuat76qSD8iNoSYnyswFHPHtBg/eEJSKK9I=;
 b=CzS9/NGc5CawCjpRdpsHZkJNdFQLf8FaPhrVpTrbTaXoBCP03h/VlP+xffUlwGkRQydl
 i+2PWkuREZOr+fRUohG/QwF1x6g9SldE9+2ds/V5/NvTDEsR2xjYrUrpbUNP28ceCT22
 vihS0TOEeeP62guzLiaLn67ByX3ghxbDAa0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2vqwyyj4db-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2019 19:32:29 -0700
Received: from 2401:db00:30:6007:face:0:1:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 21 Oct 2019 19:32:28 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id E495D3702F02; Mon, 21 Oct 2019 19:32:26 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] tools/bpf: turn on llvm alu32 attribute by default
Date:   Mon, 21 Oct 2019 19:32:26 -0700
Message-ID: <20191022023226.2255076-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_01:2019-10-21,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=1 mlxlogscore=999 impostorscore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220023
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
Cc: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4ff5f4aada08..5a0bca2802fe 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -32,15 +32,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl test_hashmap \
 	test_cgroup_attach xdping
 
-# Also test sub-register code-gen if LLVM has eBPF v3 processor support which
-# contains both ALU32 and JMP32 instructions.
-SUBREG_CODEGEN := $(shell echo "int cal(int a) { return a > 0; }" | \
-			$(CLANG) -target bpf -O2 -emit-llvm -S -x c - -o - | \
-			$(LLC) -mattr=+alu32 -mcpu=v3 2>&1 | \
-			grep 'if w')
-ifneq ($(SUBREG_CODEGEN),)
-TEST_GEN_PROGS += test_progs-alu32
-endif
+TEST_GEN_PROGS += test_progs-no_alu32
 
 # Also test bpf-gcc, if present
 ifneq ($(BPF_GCC),)
@@ -179,7 +171,7 @@ endef
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
 # Parameters:
 # $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., alu32, gcc-bpf, etc)
+# $2 - test runner extra "flavor" (e.g., no_alu32, gcc-bpf, etc)
 define DEFINE_TEST_RUNNER
 
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
@@ -201,7 +193,7 @@ endef
 # Using TRUNNER_XXX variables, provided by callers of DEFINE_TEST_RUNNER and
 # set up by DEFINE_TEST_RUNNER itself, create test runner build rules with:
 # $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., alu32, gcc-bpf, etc)
+# $2 - test runner extra "flavor" (e.g., no_alu32, gcc-bpf, etc)
 define DEFINE_TEST_RUNNER_RULES
 
 ifeq ($($(TRUNNER_OUTPUT)-dir),)
@@ -272,14 +264,12 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
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
@@ -319,4 +309,4 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS)					\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
-	feature $(OUTPUT)/*.o $(OUTPUT)/alu32 $(OUTPUT)/bpf_gcc
+	feature $(OUTPUT)/*.o $(OUTPUT)/no_alu32 $(OUTPUT)/bpf_gcc
-- 
2.17.1

