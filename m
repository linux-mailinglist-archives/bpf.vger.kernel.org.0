Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3467444D1B0
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 06:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhKKFjk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 11 Nov 2021 00:39:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39592 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhKKFjj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 00:39:39 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB53PFb002408
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:36:51 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c8qfusmb0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:36:51 -0800
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 10 Nov 2021 21:36:32 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A84F18B0E63C; Wed, 10 Nov 2021 21:36:29 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 2/9] selftests/bpf: minor cleanups and normalization of Makefile
Date:   Wed, 10 Nov 2021 21:36:17 -0800
Message-ID: <20211111053624.190580-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111053624.190580-1-andrii@kernel.org>
References: <20211111053624.190580-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: aAP_MnShuq3TQpv6B0ieEyOnAwSUtdeR
X-Proofpoint-ORIG-GUID: aAP_MnShuq3TQpv6B0ieEyOnAwSUtdeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Few clean ups and single-line simplifications. Also split CLEAN command
into multiple $(RM) invocations as it gets dangerously close to too long
argument list. Make sure that -o <output.o> is used always as the last
argument for saner verbose make output.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 32 ++++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0468ea57650d..0470802c907c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -45,10 +45,8 @@ ifneq ($(BPF_GCC),)
 TEST_GEN_PROGS += test_progs-bpf_gcc
 endif
 
-TEST_GEN_FILES = test_lwt_ip_encap.o \
-	test_tc_edt.o
-TEST_FILES = xsk_prereqs.sh \
-	$(wildcard progs/btf_dump_test_case_*.c)
+TEST_GEN_FILES = test_lwt_ip_encap.o test_tc_edt.o
+TEST_FILES = xsk_prereqs.sh $(wildcard progs/btf_dump_test_case_*.c)
 
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
@@ -107,7 +105,10 @@ endif
 OVERRIDE_TARGETS := 1
 override define CLEAN
 	$(call msg,CLEAN)
-	$(Q)$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
+	$(Q)$(RM) -r $(TEST_GEN_PROGS)
+	$(Q)$(RM) -r $(TEST_GEN_PROGS_EXTENDED)
+	$(Q)$(RM) -r $(TEST_GEN_FILES)
+	$(Q)$(RM) -r $(EXTRA_CLEAN)
 	$(Q)$(MAKE) -C bpf_testmod clean
 	$(Q)$(MAKE) docs-clean
 endef
@@ -169,7 +170,7 @@ $(OUTPUT)/%:%.c
 
 $(OUTPUT)/urandom_read: urandom_read.c
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(LDFLAGS) -o $@ $< $(LDLIBS) -Wl,--build-id=sha1
+	$(Q)$(CC) $(LDFLAGS) $< $(LDLIBS) -Wl,--build-id=sha1 -o $@
 
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
@@ -232,16 +233,16 @@ docs-clean:
 	            prefix= OUTPUT=$(OUTPUT)/ DESTDIR=$(OUTPUT)/ $@
 
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
-	   ../../../include/uapi/linux/bpf.h                                   \
+	   $(APIDIR)/linux/bpf.h					       \
 	   | $(BUILD_DIR)/libbpf
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
 		    EXTRA_CFLAGS='-g -O0'				       \
 		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
 
 ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
-$(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)                \
-	   ../../../include/uapi/linux/bpf.h                                   \
-	   | $(HOST_BUILD_DIR)/libbpf
+$(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
+		$(APIDIR)/linux/bpf.h					       \
+		| $(HOST_BUILD_DIR)/libbpf
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
 		    EXTRA_CFLAGS='-g -O0'				       \
 		    OUTPUT=$(HOST_BUILD_DIR)/libbpf/ CC=$(HOSTCC) LD=$(HOSTLD) \
@@ -305,12 +306,12 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
 # $3 - CFLAGS
 define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -mcpu=v3
+	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -mcpu=v3 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -o $2 -mcpu=v2
+	$(Q)$(CLANG) $3 -O2 -target bpf -c $1 -mcpu=v2 -o $2
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
@@ -472,13 +473,12 @@ TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
-			 btf_helpers.c	flow_dissector_load.h
+			 btf_helpers.c flow_dissector_load.h
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       ima_setup.sh					\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
-TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
-TRUNNER_BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
+TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 
 # Define test_progs-no_alu32 test runner.
@@ -540,7 +540,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
 		 $(OUTPUT)/bench_ringbufs.o \
 		 $(OUTPUT)/bench_bloom_filter_map.o
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(LDFLAGS) -o $@ $(filter %.a %.o,$^) $(LDLIBS)
+	$(Q)$(CC) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
-- 
2.30.2

