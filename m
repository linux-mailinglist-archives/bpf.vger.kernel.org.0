Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB8AF36F
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2019 01:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfIJXlu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 19:41:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfIJXlu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Sep 2019 19:41:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8ANbBjh117722
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 19:41:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxjdfdbdx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 19:41:49 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 11 Sep 2019 00:41:47 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Sep 2019 00:41:45 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8ANfhcr58327084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 23:41:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 825334C040;
        Tue, 10 Sep 2019 23:41:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16B664C04A;
        Tue, 10 Sep 2019 23:41:43 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.145.40.124])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Sep 2019 23:41:43 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: add bpf-gcc support
Date:   Wed, 11 Sep 2019 00:41:40 +0100
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091023-0016-0000-0000-000002A9C4AD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091023-0017-0000-0000-0000330A4E1A
Message-Id: <20190910234140.53363-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-10_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100222
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that binutils and gcc support for BPF is upstream, make use of it in
BPF selftests using alu32-like approach. Share as much as possible of
CFLAGS calculation with clang.

In order to activate the new bpf-gcc support, one needs to configure
binutils and gcc with --target=bpf and make them available in $PATH. In
particular, gcc must be installed as `bpf-gcc`, which is the default.

Right now with binutils 25a2915e8dba and gcc r275589 only a handful of
tests work:

	# ./test_progs_bpf_gcc
	Summary: 5/39 PASSED, 1 SKIPPED, 100 FAILED

The reason is that a lot of progs fail to build with the following
errors:

	error: indirect call in function, which are not supported by eBPF
	error: too many function arguments for eBPF

The next step is to understand those issues and fix them.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/Makefile | 61 +++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7f3196af1ae4..5493882fc19b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -17,6 +17,7 @@ LLC		?= llc
 LLVM_OBJCOPY	?= llvm-objcopy
 LLVM_READELF	?= llvm-readelf
 BTF_PAHOLE	?= pahole
+BPF_GCC		?= $(shell command -v bpf-gcc;)
 CFLAGS += -g -Wall -O2 -I$(APIDIR) -I$(LIBDIR) -I$(BPFDIR) -I$(GENDIR) $(GENFLAGS) -I../../../include \
 	  -Dbpf_prog_load=bpf_prog_test_load \
 	  -Dbpf_load_program=bpf_test_load_program
@@ -46,6 +47,10 @@ ifneq ($(SUBREG_CODEGEN),)
 TEST_GEN_FILES += $(patsubst %.o,alu32/%.o, $(BPF_OBJ_FILES))
 endif
 
+ifneq ($(BPF_GCC),)
+TEST_GEN_FILES += $(patsubst %.o,bpf_gcc/%.o, $(BPF_OBJ_FILES))
+endif
+
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
 	test_libbpf.sh \
@@ -137,16 +142,19 @@ endif
 #
 # Use '-idirafter': Don't interfere with include mechanics except where the
 # build would have failed anyways.
-CLANG_SYS_INCLUDES := $(shell $(CLANG) -v -E - </dev/null 2>&1 \
+define get_sys_includes
+$(shell $(1) -v -E - </dev/null 2>&1 \
 	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }')
+endef
+CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
+BPF_CFLAGS = -I. -I./include/uapi -I../../../include/uapi \
+	     -D__TARGET_ARCH_$(SRCARCH)
 
-CLANG_FLAGS = -I. -I./include/uapi -I../../../include/uapi \
-	      $(CLANG_SYS_INCLUDES) \
-	      -Wno-compare-distinct-pointer-types \
-	      -D__TARGET_ARCH_$(SRCARCH)
+CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
+	       -Wno-compare-distinct-pointer-types
 
-$(OUTPUT)/test_l4lb_noinline.o: CLANG_FLAGS += -fno-inline
-$(OUTPUT)/test_xdp_noinline.o: CLANG_FLAGS += -fno-inline
+$(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
+$(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
 
 $(OUTPUT)/test_queue_map.o: test_queue_stack_map.h
 $(OUTPUT)/test_stack_map.o: test_queue_stack_map.h
@@ -163,12 +171,12 @@ BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
 			  /bin/rm -f ./llvm_btf_verify.o)
 
 ifneq ($(BTF_LLVM_PROBE),)
-	CLANG_FLAGS += -g
+	BPF_CFLAGS += -g
 else
 ifneq ($(BTF_LLC_PROBE),)
 ifneq ($(BTF_PAHOLE_PROBE),)
 ifneq ($(BTF_OBJCOPY_PROBE),)
-	CLANG_FLAGS += -g
+	BPF_CFLAGS += -g
 	LLC_FLAGS += -mattr=dwarfris
 	DWARF2BTF = y
 endif
@@ -202,8 +210,8 @@ $(ALU32_BUILD_DIR)/test_progs_32: prog_tests/*.c
 
 $(ALU32_BUILD_DIR)/%.o: progs/%.c $(ALU32_BUILD_DIR)/test_progs_32 \
 					| $(ALU32_BUILD_DIR)
-	($(CLANG) $(CLANG_FLAGS) -O2 -target bpf -emit-llvm -c $< -o - || \
-		echo "clang failed") | \
+	($(CLANG) $(BPF_CFLAGS) $(CLANG_CFLAGS) -O2 -target bpf -emit-llvm \
+		-c $< -o - || echo "clang failed") | \
 	$(LLC) -march=bpf -mattr=+alu32 -mcpu=$(CPU) $(LLC_FLAGS) \
 		-filetype=obj -o $@
 ifeq ($(DWARF2BTF),y)
@@ -211,10 +219,33 @@ ifeq ($(DWARF2BTF),y)
 endif
 endif
 
+ifneq ($(BPF_GCC),)
+GCC_SYS_INCLUDES = $(call get_sys_includes,gcc)
+BPF_GCC_CFLAGS = $(GCC_SYS_INCLUDES)
+BPF_GCC_BUILD_DIR = $(OUTPUT)/bpf_gcc
+TEST_CUSTOM_PROGS += $(BPF_GCC_BUILD_DIR)/test_progs_bpf_gcc
+$(BPF_GCC_BUILD_DIR):
+	mkdir -p $@
+
+$(BPF_GCC_BUILD_DIR)/urandom_read: $(OUTPUT)/urandom_read | $(BPF_GCC_BUILD_DIR)
+	cp $< $@
+
+$(BPF_GCC_BUILD_DIR)/test_progs_bpf_gcc: $(OUTPUT)/test_progs \
+					 | $(BPF_GCC_BUILD_DIR)
+	cp $< $@
+
+$(BPF_GCC_BUILD_DIR)/%.o: progs/%.c $(BPF_GCC_BUILD_DIR)/test_progs_bpf_gcc \
+			  | $(BPF_GCC_BUILD_DIR)
+	$(BPF_GCC) $(BPF_CFLAGS) $(BPF_GCC_CFLAGS) -O2 -c $< -o $@
+ifeq ($(DWARF2BTF),y)
+	$(BTF_PAHOLE) -J $@
+endif
+endif
+
 # Have one program compiled without "-target bpf" to test whether libbpf loads
 # it successfully
 $(OUTPUT)/test_xdp.o: progs/test_xdp.c
-	($(CLANG) $(CLANG_FLAGS) -O2 -emit-llvm -c $< -o - || \
+	($(CLANG) $(BPF_CFLAGS) $(CLANG_CFLAGS) -O2 -emit-llvm -c $< -o - || \
 		echo "clang failed") | \
 	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
 ifeq ($(DWARF2BTF),y)
@@ -222,8 +253,8 @@ ifeq ($(DWARF2BTF),y)
 endif
 
 $(OUTPUT)/%.o: progs/%.c
-	($(CLANG) $(CLANG_FLAGS) -O2 -target bpf -emit-llvm -c $< -o - || \
-		echo "clang failed") | \
+	($(CLANG) $(BPF_CFLAGS) $(CLANG_CFLAGS) -O2 -target bpf -emit-llvm \
+		-c $< -o - || echo "clang failed") | \
 	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
 ifeq ($(DWARF2BTF),y)
 	$(BTF_PAHOLE) -J $@
@@ -282,6 +313,6 @@ $(VERIFIER_TESTS_H): $(VERIFIER_TEST_FILES) | $(VERIFIER_TESTS_DIR)
 		  echo '#endif' \
 		 ) > $(VERIFIER_TESTS_H))
 
-EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(ALU32_BUILD_DIR) \
+EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(ALU32_BUILD_DIR) $(BPF_GCC_BUILD_DIR) \
 	$(VERIFIER_TESTS_H) $(PROG_TESTS_H) $(MAP_TESTS_H) \
 	feature
-- 
2.21.0

