Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45324B1290
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2019 18:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfILQFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Sep 2019 12:05:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbfILQFz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Sep 2019 12:05:55 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8CG2NZj131351
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 12:05:54 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uyrnf9hvx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 12:05:53 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 12 Sep 2019 17:05:50 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Sep 2019 17:05:46 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8CG5jG952560084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 16:05:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 221C34203F;
        Thu, 12 Sep 2019 16:05:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C338C4204B;
        Thu, 12 Sep 2019 16:05:44 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.145.165.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Sep 2019 16:05:44 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2] selftests/bpf: add bpf-gcc support
Date:   Thu, 12 Sep 2019 18:05:43 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091216-0008-0000-0000-00000314D6B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091216-0009-0000-0000-00004A334753
Message-Id: <20190912160543.66653-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909120166
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that binutils and gcc support for BPF is upstream, make use of it in
BPF selftests using alu32-like approach. Share as much as possible of
CFLAGS calculation with clang.

Fixes only obvious issues, leaving more complex ones for later:
- Use gcc-provided bpf-helpers.h instead of manually defining the
  helpers, change bpf_helpers.h include guard to avoid conflict.
- Include <linux/stddef.h> for __always_inline.
- Add $(OUTPUT)/../usr/include to include path in order to use local
  kernel headers instead of system kernel headers when building with O=.

In order to activate the bpf-gcc support, one needs to configure
binutils and gcc with --target=bpf and make them available in $PATH. In
particular, gcc must be installed as `bpf-gcc`, which is the default.

Right now with binutils 25a2915e8dba and gcc r275589 only a handful of
tests work:

	# ./test_progs_bpf_gcc
	# Summary: 7/39 PASSED, 1 SKIPPED, 98 FAILED

The reason for those failures are as follows:

- Build errors:
  - `error: too many function arguments for eBPF` for __always_inline
    functions read_str_var and read_map_var - must be inlining issue,
    and for process_l3_headers_v6, which relies on optimizing away
    function arguments.
  - `error: indirect call in function, which are not supported by eBPF`
    where there are no obvious indirect calls in the source calls, e.g.
    in __encap_ipip_none.
  - `error: field 'lock' has incomplete type` for fields of `struct
    bpf_spin_lock` type - bpf_spin_lock is re#defined by bpf-helpers.h,
    so its usage is sensitive to order of #includes.
  - `error: eBPF stack limit exceeded` in sysctl_tcp_mem.
- Load errors:
  - Missing object files due to above build errors.
  - `libbpf: failed to create map (name: 'test_ver.bss')`.
  - `libbpf: object file doesn't contain bpf program`.
  - `libbpf: Program '.text' contains unrecognized relo data pointing to
    section 0`.
  - `libbpf: BTF is required, but is missing or corrupted` - no BTF
    support in gcc yet.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
v1->v2: Use bpf-helpers.h, fix a few obvious compatibility problems.

 tools/testing/selftests/bpf/Makefile          | 65 ++++++++++++++-----
 tools/testing/selftests/bpf/bpf_helpers.h     | 24 ++++---
 .../testing/selftests/bpf/progs/test_tc_edt.c |  1 +
 3 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7f3196af1ae4..6889c19a628c 100644
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
+	     -I$(OUTPUT)/../usr/include -D__TARGET_ARCH_$(SRCARCH)
 
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
@@ -211,10 +219,37 @@ ifeq ($(DWARF2BTF),y)
 endif
 endif
 
+ifneq ($(BPF_GCC),)
+GCC_SYS_INCLUDES = $(call get_sys_includes,gcc)
+IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+ifeq ($(IS_LITTLE_ENDIAN),)
+MENDIAN=-mbig-endian
+else
+MENDIAN=-mlittle-endian
+endif
+BPF_GCC_CFLAGS = $(GCC_SYS_INCLUDES) $(MENDIAN)
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
@@ -222,8 +257,8 @@ ifeq ($(DWARF2BTF),y)
 endif
 
 $(OUTPUT)/%.o: progs/%.c
-	($(CLANG) $(CLANG_FLAGS) -O2 -target bpf -emit-llvm -c $< -o - || \
-		echo "clang failed") | \
+	($(CLANG) $(BPF_CFLAGS) $(CLANG_CFLAGS) -O2 -target bpf -emit-llvm \
+		-c $< -o - || echo "clang failed") | \
 	$(LLC) -march=bpf -mcpu=$(CPU) $(LLC_FLAGS) -filetype=obj -o $@
 ifeq ($(DWARF2BTF),y)
 	$(BTF_PAHOLE) -J $@
@@ -282,6 +317,6 @@ $(VERIFIER_TESTS_H): $(VERIFIER_TEST_FILES) | $(VERIFIER_TESTS_DIR)
 		  echo '#endif' \
 		 ) > $(VERIFIER_TESTS_H))
 
-EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(ALU32_BUILD_DIR) \
+EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(ALU32_BUILD_DIR) $(BPF_GCC_BUILD_DIR) \
 	$(VERIFIER_TESTS_H) $(PROG_TESTS_H) $(MAP_TESTS_H) \
 	feature
diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index 6c4930bc6e2e..54a50699bbfd 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -1,12 +1,6 @@
 /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
-#ifndef __BPF_HELPERS_H
-#define __BPF_HELPERS_H
-
-/* helper macro to place programs, maps, license in
- * different sections in elf_bpf file. Section names
- * are interpreted by elf_bpf loader
- */
-#define SEC(NAME) __attribute__((section(NAME), used))
+#ifndef __BPF_HELPERS__
+#define __BPF_HELPERS__
 
 #define __uint(name, val) int (*name)[val]
 #define __type(name, val) val *name
@@ -19,6 +13,14 @@
 			 ##__VA_ARGS__);		\
 })
 
+#ifdef __clang__
+
+/* helper macro to place programs, maps, license in
+ * different sections in elf_bpf file. Section names
+ * are interpreted by elf_bpf loader
+ */
+#define SEC(NAME) __attribute__((section(NAME), used))
+
 /* helper functions called from eBPF programs written in C */
 static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
 	(void *) BPF_FUNC_map_lookup_elem;
@@ -256,6 +258,12 @@ struct bpf_map_def {
 	unsigned int numa_node;
 };
 
+#else
+
+#include <bpf-helpers.h>
+
+#endif
+
 #define BPF_ANNOTATE_KV_PAIR(name, type_key, type_val)		\
 	struct ____btf_map_##name {				\
 		type_key key;					\
diff --git a/tools/testing/selftests/bpf/progs/test_tc_edt.c b/tools/testing/selftests/bpf/progs/test_tc_edt.c
index 3af64c470d64..0961415ba477 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_edt.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_edt.c
@@ -2,6 +2,7 @@
 #include <stdint.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
+#include <linux/stddef.h>
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/pkt_cls.h>
-- 
2.21.0

