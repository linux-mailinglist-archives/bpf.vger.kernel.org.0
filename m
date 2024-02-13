Return-Path: <bpf+bounces-21845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D04A8531A4
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 14:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277A21C24234
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697555794;
	Tue, 13 Feb 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b="NaKDsDi4"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D651C34
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830434; cv=none; b=Va7z5BQIIvMYYGyLFSLY4P1m1gkxnYRzQxxiCDD7Pj7osaF4KWyrVop7VJTw7NCPus8p5Gc2ocXV5MY00tSEiIJkZAcd/GCPlBYNehA0g2g/6rBnTbEO8/foWjow/P1JcBtz4RijOXLOto2fKqIpOTUy9IFdEi41WhgyTSZT5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830434; c=relaxed/simple;
	bh=HGM83QvvNYyCZOEeT9SGyuKWVZVHEveqejHxLL+2uDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=feUew16vBWmmUz3vME8q3HTC/1NOXJ4YYpMqzdqd1UXkIAppDiNZoem66LoR9iUoy3vjin75hdCvcsFS9VpxmcGKI6BzuJ/QxpxP9a6iQSnBujmj09IpOs002XpqerwMy5VsDpty7xo+faxHAMq5qmykC0ZXT6wYpbpaDHP9N6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org; spf=pass smtp.mailfrom=vahedi.org; dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b=NaKDsDi4; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vahedi.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vahedi.org; s=key1;
	t=1707830417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yKwcAyYXu8ZbnFBP5mrY6iQxL40ZofUVid/zpBk9TDY=;
	b=NaKDsDi40qaL0cUo/1JpSTxQ6wJeF0JTf7n8vryaI8mQcMfKmoraXxFXkqwDYaCI2UI9vb
	3vqF5AsXTW6HOYKBVvdm8Larei0WwMkF5LtcwPQPE+Qd/ZnckmQ1U07rZpUwKItB3bHjaF
	/+Y09BkHm7fPPoWGib5LLww8otGKhmCeS18xpTlb0nzhbvLj9Hir8LRxFRDFaLYMyQfHvQ
	9Hvv3pNy8qgLADw5AeDjjyKiEfQvyJbqJD57XCIMyqoO8gNEdt4fdgo8lWAGCP4n+xaWBi
	U/5ufkHxTnBkVC75ywzqZq4kjK9j1bON6QeFkxGdT0aYI7xUaMoW/bMQLENZEw==
From: Shahab Vahedi <list+bpf@vahedi.org>
To: bpf@vger.kernel.org
Cc: Shahab Vahedi <shahab@synopsys.com>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH bpf-next v1] ARC: Add eBPF JIT support
Date: Tue, 13 Feb 2024 14:19:46 +0100
Message-Id: <20240213131946.32068-1-list+bpf@vahedi.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Shahab Vahedi <shahab@synopsys.com>

This will add eBPF JIT support to the 32-bit ARCv2 processors. The
implementation is qualified by running the BPF tests on a Synopsys HSDK
board with "ARC HS38 v2.1c at 500 MHz" as the 4-core CPU.

Deployment and structure
------------------------
The related codes are added to "arch/arc/net":

- bpf_jit.h       -- The interface that a back-end translator must provide
- bpf_jit_core.c  -- Knows how to handle the input eBPF byte stream
- bpf_jit_arcv2.c -- The back-end code that knows the translation logic

The bpf_int_jit_compile() at the end of bpf_jit_core.c is the entrance
to the whole process. Normally, the translation is done in one pass,
namely the "normal pass". In case some relocations are not known during
this pass, some data (arc_jit_data) is allocated for the next pass to
come. This possible next (and last) pass is called the "extra pass".

1. Normal pass       # The necessary pass
     1a. Dry run       # Get the whole JIT length, epilogue offset, etc.
     1b. Emit phase    # Allocate memory and start emitting instructions
2. Extra pass        # Only needed if there are relocations to be fixed
     2a. Patch relocations

Support status
------------------------
This JIT compiler does NOT yet provide support for:

- Tail calls
- Atomic operations
- 64-bit division/remainder
- BPF_PROBE_MEM* (exception table)

The result of "test_bpf" test suite on an HSDK board is:

hsdk-lnx# insmod test_bpf.ko test_suite=test_bpf

  test_bpf: Summary: 863 PASSED, 186 FAILED, [851/851 JIT'ed]

All the failing test cases are due to the ones that were not JIT'ed.
Categorically, they can be represented as:

  .-----------.------------.-------------.
  | test type |   opcodes  | # of cases  |
  |-----------+------------+-------------|
  | atomic    | 0xC3, 0xDB |         149 |
  | div64     | 0x37, 0x3F |          22 |
  | mod64     | 0x97, 0x9F |          15 |
  `-----------^------------+-------------|
                           | (total) 186 |
                           `-------------'

Setup: build config
-------------------
The following configs must be set to have a working JIT test:

  CONFIG_BPF_JIT=y
  CONFIG_BPF_JIT_ALWAYS_ON=y
  CONFIG_TEST_BPF=m

The following options are not necessary for the tests module,
but are good to have:

  CONFIG_DEBUG_INFO=y             # prerequisite for below
  CONFIG_DEBUG_INFO_BTF=y         # so bpftool can generate vmlinux.h

  CONFIG_FTRACE=y                 #
  CONFIG_BPF_SYSCALL=y            # all these options lead to
  CONFIG_KPROBE_EVENTS=y          # having CONFIG_BPF_EVENTS=y
  CONFIG_PERF_EVENTS=y            #

Some BPF programs provide data through /sys/kernel/debug:
  CONFIG_DEBUG_FS=y
arc# mount -t debugfs debugfs /sys/kernel/debug

Setup: elfutils
---------------
The libdw.{so,a} library that is used by pahole for processing
the final binary must come from elfutils 0.189 or newer. The
support for ARCv2 [1] has been added since that version.

[1]
https://sourceware.org/git/?p=elfutils.git;a=commit;h=de3d46b3e7

Setup: pahole
-------------
The line below in linux/scripts/Makefile.btf must be commented out:

pahole-flags-$(call test-ge, $(pahole-ver), 121) += --btf_gen_floats

Or else, the build will fail:

$ make V=1
  ...
  BTF     .btf.vmlinux.bin.o
pahole -J --btf_gen_floats                    \
       -j --lang_exclude=rust                 \
       --skip_encoding_btf_inconsistent_proto \
       --btf_gen_optimized .tmp_vmlinux.btf
Complex, interval and imaginary float types are not supported
Encountered error while encoding BTF.
  ...
  BTFIDS  vmlinux
./tools/bpf/resolve_btfids/resolve_btfids vmlinux
libbpf: failed to find '.BTF' ELF section in vmlinux
FAILED: load BTF from vmlinux: No data available

This is due to the fact that the ARC toolchains generate
"complex float" DIE entries in libgcc and at the moment, pahole
can't handle such entries.

Running the tests
-----------------
host$ scp /bld/linux/lib/test_bpf.ko arc:
arc # sysctl net.core.bpf_jit_enable=1
arc # insmod test_bpf.ko test_suite=test_bpf
      ...
      test_bpf: #1048 Staggered jumps: JMP32_JSLE_X jited:1 697811 PASS
      test_bpf: Summary: 863 PASSED, 186 FAILED, [851/851 JIT'ed]

Acknowledgments
---------------
- Claudiu Zissulescu for his unwavering support
- Yuriy Kolerov for testing and troubleshooting
- Vladimir Isaev for the pahole workaround
- Sergey Matyukevich for paving the road by adding the interpretor support

Signed-off-by: Shahab Vahedi <shahab@synopsys.com>
---
 Documentation/admin-guide/sysctl/net.rst |    1 +
 Documentation/networking/filter.rst      |    4 +-
 arch/arc/Kbuild                          |    1 +
 arch/arc/Kconfig                         |    1 +
 arch/arc/net/Makefile                    |    6 +
 arch/arc/net/bpf_jit.h                   |  161 ++
 arch/arc/net/bpf_jit_arcv2.c             | 3001 ++++++++++++++++++++++
 arch/arc/net/bpf_jit_core.c              | 1425 ++++++++++
 8 files changed, 4598 insertions(+), 2 deletions(-)
 create mode 100644 arch/arc/net/Makefile
 create mode 100644 arch/arc/net/bpf_jit.h
 create mode 100644 arch/arc/net/bpf_jit_arcv2.c
 create mode 100644 arch/arc/net/bpf_jit_core.c

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 396091651955..0dae7544cdfb 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -72,6 +72,7 @@ two flavors of JITs, the newer eBPF JIT currently supported on:
   - riscv64
   - riscv32
   - loongarch64
+  - arc
 
 And the older cBPF JIT supported on the following archs:
 
diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 7d8c5380492f..8eb9a5d40f31 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -513,7 +513,7 @@ JIT compiler
 ------------
 
 The Linux kernel has a built-in BPF JIT compiler for x86_64, SPARC,
-PowerPC, ARM, ARM64, MIPS, RISC-V and s390 and can be enabled through
+PowerPC, ARM, ARM64, MIPS, RISC-V, s390, and ARC and can be enabled through
 CONFIG_BPF_JIT. The JIT compiler is transparently invoked for each
 attached filter from user space or for internal kernel users if it has
 been previously enabled by root::
@@ -650,7 +650,7 @@ before a conversion to the new layout is being done behind the scenes!
 
 Currently, the classic BPF format is being used for JITing on most
 32-bit architectures, whereas x86-64, aarch64, s390x, powerpc64,
-sparc64, arm32, riscv64, riscv32, loongarch64 perform JIT compilation
+sparc64, arm32, riscv64, riscv32, loongarch64, arc perform JIT compilation
 from eBPF instruction set.
 
 Testing
diff --git a/arch/arc/Kbuild b/arch/arc/Kbuild
index b94102fff68b..20ea7dd482d4 100644
--- a/arch/arc/Kbuild
+++ b/arch/arc/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += kernel/
 obj-y += mm/
+obj-y += net/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 1b0483c51cc1..fd8ca120dba5 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -51,6 +51,7 @@ config ARC
 	select PCI_SYSCALL if PCI
 	select HAVE_ARCH_JUMP_LABEL if ISA_ARCV2 && !CPU_ENDIAN_BE32
 	select TRACE_IRQFLAGS_SUPPORT
+	select HAVE_EBPF_JIT if ISA_ARCV2
 
 config LOCKDEP_SUPPORT
 	def_bool y
diff --git a/arch/arc/net/Makefile b/arch/arc/net/Makefile
new file mode 100644
index 000000000000..ea5790952e9a
--- /dev/null
+++ b/arch/arc/net/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+ifeq ($(CONFIG_ISA_ARCV2),y)
+	obj-$(CONFIG_BPF_JIT) += bpf_jit_core.o
+	obj-$(CONFIG_BPF_JIT) += bpf_jit_arcv2.o
+endif
diff --git a/arch/arc/net/bpf_jit.h b/arch/arc/net/bpf_jit.h
new file mode 100644
index 000000000000..5c8b9eb0ac81
--- /dev/null
+++ b/arch/arc/net/bpf_jit.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The interface that a back-end should provide to bpf_jit_core.c.
+ *
+ * Copyright (c) 2024 Synopsys Inc.
+ * Author: Shahab Vahedi <shahab@synopsys.com>
+ */
+
+#ifndef _ARC_BPF_JIT_H
+#define _ARC_BPF_JIT_H
+
+#include <linux/bpf.h>
+#include <linux/filter.h>
+
+/* Print debug info and assert. */
+//#define ARC_BPF_JIT_DEBUG
+
+/* Determine the address type of the target. */
+#ifdef CONFIG_ISA_ARCV2
+#define ARC_ADDR u32
+#endif
+
+/*
+ * For the translation of some BPF instructions, a temporary register
+ * might be needed for some interim data.
+ */
+#define JIT_REG_TMP MAX_BPF_JIT_REG
+
+/************* Globals that have effects on code generation ***********/
+/*
+ * If "emit" is true, the instructions are actually generated. Else, the
+ * generation part will be skipped and only the length of instruction is
+ * returned by the responsible functions.
+ */
+extern bool emit;
+
+/* An indicator if zero-extend must be done for the 32-bit operations. */
+extern bool zext_thyself;
+
+/************** Functions that the back-end must provide **************/
+/* Extension for 32-bit operations. */
+extern inline u8 zext(u8 *buf, u8 rd);
+/***** Moves *****/
+extern u8 mov_r32(u8 *buf, u8 rd, u8 rs, u8 sign_ext);
+extern u8 mov_r32_i32(u8 *buf, u8 reg, s32 imm);
+extern u8 mov_r64(u8 *buf, u8 rd, u8 rs, u8 sign_ext);
+extern u8 mov_r64_i32(u8 *buf, u8 reg, s32 imm);
+extern u8 mov_r64_i64(u8 *buf, u8 reg, u32 lo, u32 hi);
+/***** Loads and stores *****/
+extern u8 load_r(u8 *buf, u8 rd, u8 rs, s16 off, u8 size, bool sign_ext);
+extern u8 store_r(u8 *buf, u8 rd, u8 rs, s16 off, u8 size);
+extern u8 store_i(u8 *buf, s32 imm, u8 rd, s16 off, u8 size);
+/***** Addition *****/
+extern u8 add_r32(u8 *buf, u8 rd, u8 rs);
+extern u8 add_r32_i32(u8 *buf, u8 rd, s32 imm);
+extern u8 add_r64(u8 *buf, u8 rd, u8 rs);
+extern u8 add_r64_i32(u8 *buf, u8 rd, s32 imm);
+/***** Subtraction *****/
+extern u8 sub_r32(u8 *buf, u8 rd, u8 rs);
+extern u8 sub_r32_i32(u8 *buf, u8 rd, s32 imm);
+extern u8 sub_r64(u8 *buf, u8 rd, u8 rs);
+extern u8 sub_r64_i32(u8 *buf, u8 rd, s32 imm);
+/***** Multiplication *****/
+extern u8 mul_r32(u8 *buf, u8 rd, u8 rs);
+extern u8 mul_r32_i32(u8 *buf, u8 rd, s32 imm);
+extern u8 mul_r64(u8 *buf, u8 rd, u8 rs);
+extern u8 mul_r64_i32(u8 *buf, u8 rd, s32 imm);
+/***** Division *****/
+extern u8 div_r32(u8 *buf, u8 rd, u8 rs, bool sign_ext);
+extern u8 div_r32_i32(u8 *buf, u8 rd, s32 imm, bool sign_ext);
+/***** Remainder *****/
+extern u8 mod_r32(u8 *buf, u8 rd, u8 rs, bool sign_ext);
+extern u8 mod_r32_i32(u8 *buf, u8 rd, s32 imm, bool sign_ext);
+/***** Bitwise AND *****/
+extern u8 and_r32(u8 *buf, u8 rd, u8 rs);
+extern u8 and_r32_i32(u8 *buf, u8 rd, s32 imm);
+extern u8 and_r64(u8 *buf, u8 rd, u8 rs);
+extern u8 and_r64_i32(u8 *buf, u8 rd, s32 imm);
+/***** Bitwise OR *****/
+extern u8 or_r32(u8 *buf, u8 rd, u8 rs);
+extern u8 or_r32_i32(u8 *buf, u8 rd, s32 imm);
+extern u8 or_r64(u8 *buf, u8 rd, u8 rs);
+extern u8 or_r64_i32(u8 *buf, u8 rd, s32 imm);
+/***** Bitwise XOR *****/
+extern u8 xor_r32(u8 *buf, u8 rd, u8 rs);
+extern u8 xor_r32_i32(u8 *buf, u8 rd, s32 imm);
+extern u8 xor_r64(u8 *buf, u8 rd, u8 rs);
+extern u8 xor_r64_i32(u8 *buf, u8 rd, s32 imm);
+/***** Bitwise Negate *****/
+extern u8 neg_r32(u8 *buf, u8 r);
+extern u8 neg_r64(u8 *buf, u8 r);
+/***** Bitwise left shift *****/
+extern u8 lsh_r32(u8 *buf, u8 rd, u8 rs);
+extern u8 lsh_r32_i32(u8 *buf, u8 rd, u8 imm);
+extern u8 lsh_r64(u8 *buf, u8 rd, u8 rs);
+extern u8 lsh_r64_i32(u8 *buf, u8 rd, s32 imm);
+/***** Bitwise right shift (logical) *****/
+extern u8 rsh_r32(u8 *buf, u8 rd, u8 rs);
+extern u8 rsh_r32_i32(u8 *buf, u8 rd, u8 imm);
+extern u8 rsh_r64(u8 *buf, u8 rd, u8 rs);
+extern u8 rsh_r64_i32(u8 *buf, u8 rd, s32 imm);
+/***** Bitwise right shift (arithmetic) *****/
+extern u8 arsh_r32(u8 *buf, u8 rd, u8 rs);
+extern u8 arsh_r32_i32(u8 *buf, u8 rd, u8 imm);
+extern u8 arsh_r64(u8 *buf, u8 rd, u8 rs);
+extern u8 arsh_r64_i32(u8 *buf, u8 rd, s32 imm);
+/***** Frame related *****/
+extern u32 mask_for_used_regs(u8 bpf_reg, bool is_call);
+extern u8 arc_prologue(u8 *buf, u32 usage, u16 frame_size);
+extern u8 arc_epilogue(u8 *buf, u32 usage, u16 frame_size);
+/***** Jumps *****/
+/*
+ * Different sorts of conditions (ARC enum as opposed to BPF_*).
+ *
+ * Do not change the order of enums here. ARC_CC_SLE+1 is used
+ * to determine the number of JCCs.
+ */
+enum ARC_CC {
+	ARC_CC_UGT = 0,		/* unsigned >  */
+	ARC_CC_UGE,		/* unsigned >= */
+	ARC_CC_ULT,		/* unsigned <  */
+	ARC_CC_ULE,		/* unsigned <= */
+	ARC_CC_SGT,		/*   signed >  */
+	ARC_CC_SGE,		/*   signed >= */
+	ARC_CC_SLT,		/*   signed <  */
+	ARC_CC_SLE,		/*   signed <= */
+	ARC_CC_AL,		/* always      */
+	ARC_CC_EQ,		/*          == */
+	ARC_CC_NE,		/*          != */
+	ARC_CC_SET,		/* test        */
+	ARC_CC_LAST
+};
+/*
+ * A few notes:
+ *
+ * - check_jmp_*() are prerequisites before calling the gen_jmp_*().
+ *   They return "true" if the jump is possible and "false" otherwise.
+ *
+ * - The notion of "*_off" is to emphasize that these parameters are
+ *   merely offsets in the JIT stream and not absolute addresses. One
+ *   can look at them as addresses if the JIT code would start from
+ *   address 0x0000_0000. Nonetheless, since the buffer address for the
+ *   JIT is on a word-aligned address, this works and actually makes
+ *   things simpler (offsets are in the range of u32 which is more than
+ *   enough).
+ */
+extern bool check_jmp_32(u32 curr_off, u32 targ_off, u8 cond);
+extern bool check_jmp_64(u32 curr_off, u32 targ_off, u8 cond);
+extern u8 gen_jmp_32(u8 *buf, u8 rd, u8 rs, u8 cond, u32 c_off, u32 t_off);
+extern u8 gen_jmp_64(u8 *buf, u8 rd, u8 rs, u8 cond, u32 c_off, u32 t_off);
+/***** Miscellaneous *****/
+extern u8 gen_func_call(u8 *buf, ARC_ADDR func_addr, bool external_func);
+extern u8 arc_to_bpf_return(u8 *buf);
+/*
+ * Perform byte swaps on "rd" based on the "size". If "force" is
+ * set to "true", do it unconditionally. Otherwise, consider the
+ * desired "endian"ness and the host endianness.
+ */
+extern u8 gen_swap(u8 *buf, u8 rd, u8 size, u8 endian, bool force);
+
+#endif /* _ARC_BPF_JIT_H */
diff --git a/arch/arc/net/bpf_jit_arcv2.c b/arch/arc/net/bpf_jit_arcv2.c
new file mode 100644
index 000000000000..8de8fb19a8d0
--- /dev/null
+++ b/arch/arc/net/bpf_jit_arcv2.c
@@ -0,0 +1,3001 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The ARCv2 backend of Just-In-Time compiler for eBPF bytecode.
+ *
+ * Copyright (c) 2024 Synopsys Inc.
+ * Author: Shahab Vahedi <shahab@synopsys.com>
+ */
+#include <asm/bug.h>
+#include "bpf_jit.h"
+
+/* ARC core registers. */
+enum {
+	ARC_R_0,  ARC_R_1,  ARC_R_2,  ARC_R_3,  ARC_R_4,  ARC_R_5,
+	ARC_R_6,  ARC_R_7,  ARC_R_8,  ARC_R_9,  ARC_R_10, ARC_R_11,
+	ARC_R_12, ARC_R_13, ARC_R_14, ARC_R_15, ARC_R_16, ARC_R_17,
+	ARC_R_18, ARC_R_19, ARC_R_20, ARC_R_21, ARC_R_22, ARC_R_23,
+	ARC_R_24, ARC_R_25, ARC_R_26, ARC_R_FP, ARC_R_SP, ARC_R_ILINK,
+	ARC_R_30, ARC_R_BLINK,
+	/*
+	 * Having ARC_R_IMM encoded as source register means there is an
+	 * immediate that must be interpreted from the next 4 bytes. If
+	 * encoded as the destination register though, it implies that the
+	 * output of the operation is not assigned to any register. The
+	 * latter is helpful if we only care about updating the CPU status
+	 * flags.
+	 */
+	ARC_R_IMM = 62
+};
+
+/*
+ * Remarks about the rationale behind the chosen mapping:
+ *
+ * - BPF_REG_{1,2,3,4} are the argument registers and must be mapped to
+ *   argument registers in ARCv2 ABI: r0-r7. The r7 registers is the last
+ *   argument register in the ABI. Therefore BPF_REG_5, as the fifth
+ *   argument, must be pushed onto the stack. This is a must for calling
+ *   in-kernel functions.
+ *
+ * - In ARCv2 ABI, the return value is in r0 for 32-bit results and (r1,r0)
+ *   for 64-bit results. However, because they're already used for BPF_REG_1,
+ *   the next available scratch registers, r8 and r9, are the best candidates
+ *   for BPF_REG_0. After a "call" to a(n) (in-kernel) function, the result
+ *   is "mov"ed to these registers. At a BPF_EXIT, their value is "mov"ed to
+ *   (r1,r0).
+ *   It is worth mentioning that scratch registers are the best choice for
+ *   BPF_REG_0, because it is very popular in BPF instruction encoding.
+ *
+ * - JIT_REG_TMP is an artifact needed to translate some BPF instructions.
+ *   Its life span is one single BPF instruction. Since during the
+ *   analyze_reg_usage(), it is not known if temporary registers are used,
+ *   it is mapped to ARC's scratch registers: r10 and r11. Therefore, they
+ *   don't matter in analysing phase and don't need saving. This temporary
+ *   register is added as yet another index in the bpf2arc array, so it will
+ *   unfold like the rest of registers during the code generation process.
+ *
+ * - Mapping of callee-saved BPF registers, BPF_REG_{6,7,8,9}, starts from
+ *   (r15,r14) register pair. The (r13,r12) is not a good choice, because
+ *   in ARCv2 ABI, r12 is not a callee-saved register and this can cause
+ *   problem when calling an in-kernel function. Theoretically, the mapping
+ *   could start from (r14,r13), but it is not a conventional ARCv2 register
+ *   pair. To have a future proof design, I opted for this arrangement.
+ *   If/when we decide to add ARCv2 instructions that do use register pairs,
+ *   the mapping, hopefully, doesn't need to be revisited.
+ */
+const u8 bpf2arc[][2] = {
+	/* Return value from in-kernel function, and exit value from eBPF */
+	[BPF_REG_0] = {ARC_R_8, ARC_R_9},
+	/* Arguments from eBPF program to in-kernel function */
+	[BPF_REG_1] = {ARC_R_0, ARC_R_1},
+	[BPF_REG_2] = {ARC_R_2, ARC_R_3},
+	[BPF_REG_3] = {ARC_R_4, ARC_R_5},
+	[BPF_REG_4] = {ARC_R_6, ARC_R_7},
+	/* Remaining arguments, to be passed on the stack per 32-bit ABI */
+	[BPF_REG_5] = {ARC_R_22, ARC_R_23},
+	/* Callee-saved registers that in-kernel function will preserve */
+	[BPF_REG_6] = {ARC_R_14, ARC_R_15},
+	[BPF_REG_7] = {ARC_R_16, ARC_R_17},
+	[BPF_REG_8] = {ARC_R_18, ARC_R_19},
+	[BPF_REG_9] = {ARC_R_20, ARC_R_21},
+	/* Read-only frame pointer to access the eBPF stack. 32-bit only. */
+	[BPF_REG_FP] = {ARC_R_FP, },
+	/* Register for blinding constants */
+	[BPF_REG_AX] = {ARC_R_24, ARC_R_25},
+	/* Temporary registers for internal use */
+	[JIT_REG_TMP] = {ARC_R_10, ARC_R_11}
+};
+
+#define ARC_CALLEE_SAVED_REG_FIRST ARC_R_13
+#define ARC_CALLEE_SAVED_REG_LAST  ARC_R_25
+
+#define REG_LO(r) (bpf2arc[(r)][0])
+#define REG_HI(r) (bpf2arc[(r)][1])
+
+
+/*
+ * To comply with ARCv2 ABI, BPF's arg5 must be put on stack. After which,
+ * the stack needs to be restored by ARG5_SIZE.
+ */
+#define ARG5_SIZE 8
+
+/* Instruction lengths in bytes. */
+enum {
+	INSN_len_normal = 4,	/* Normal instructions length. */
+	INSN_len_imm = 4	/* Length of an extra 32-bit immediate. */
+};
+
+/* ZZ defines the size of operation in encodings that it is used. */
+enum {
+	ZZ_1_byte = 1,
+	ZZ_2_byte = 2,
+	ZZ_4_byte = 0,
+	ZZ_8_byte = 3
+};
+
+/*
+ * AA is mostly about address write back mode. It determines if the
+ * address in question should be updated before usage or after:
+ *   addr += offset; data = *addr;
+ *   data = *addr; addr += offset;
+ *
+ * In "scaling" mode, the effective address will become the sum
+ * of "address" + "index"*"size". The "size" is specified by the
+ * "ZZ" field. There is no write back when AA is set for scaling:
+ *   data = *(addr + offset<<zz)
+ */
+enum {
+	AA_none  = 0,
+	AA_pre   = 1,	/* in assembly known as "a/aw". */
+	AA_post  = 2,	/* in assembly known as "ab". */
+	AA_scale = 3	/* in assembly known as "as". */
+};
+
+/* X flag determines the mode of extension. */
+enum {
+	X_zero = 0,
+	X_sign = 1
+};
+
+/* Condition codes. */
+enum {
+	CC_always     = 0,	/* condition is true all the time */
+	CC_equal      = 1,	/* if status32.z flag is set */
+	CC_unequal    = 2,	/* if status32.z flag is clear */
+	CC_positive   = 3,	/* if status32.n flag is clear */
+	CC_negative   = 4,	/* if status32.n flag is set */
+	CC_less_u     = 5,	/* less than (unsigned) */
+	CC_less_eq_u  = 14,	/* less than or equal (unsigned) */
+	CC_great_eq_u = 6,	/* greater than or equal (unsigned) */
+	CC_great_u    = 13,	/* greater than (unsigned) */
+	CC_less_s     = 11,	/* less than (signed) */
+	CC_less_eq_s  = 12,	/* less than or equal (signed) */
+	CC_great_eq_s = 10,	/* greater than or equal (signed) */
+	CC_great_s    = 9	/* greater than (signed) */
+};
+
+#define IN_U6_RANGE(x)	((x) <= (0x40      - 1) && (x) >= 0)
+#define IN_S9_RANGE(x)	((x) <= (0x100     - 1) && (x) >= -0x100)
+#define IN_S12_RANGE(x)	((x) <= (0x800     - 1) && (x) >= -0x800)
+#define IN_S21_RANGE(x)	((x) <= (0x100000  - 1) && (x) >= -0x100000)
+#define IN_S25_RANGE(x)	((x) <= (0x1000000 - 1) && (x) >= -0x1000000)
+
+/* Operands in most of the encodings. */
+#define OP_A(x)	((x) & 0x03f)
+#define OP_B(x)	((((x) & 0x07) << 24) | (((x) & 0x38) <<  9))
+#define OP_C(x)	(((x) & 0x03f) << 6)
+#define OP_IMM	(OP_C(ARC_R_IMM))
+#define COND(x)	(OP_A((x) & 31))
+#define FLAG(x)	(((x) & 1) << 15)
+
+/*
+ * The 4-byte encoding of "mov b,c":
+ *
+ * 0010_0bbb 0000_1010 0BBB_cccc cc00_0000
+ *
+ * b:  BBBbbb		destination register
+ * c:  cccccc		source register
+ */
+#define OPC_MOV		0x200a0000
+
+/*
+ * The 4-byte encoding of "mov b,s12" (used for moving small immediates):
+ *
+ * 0010_0bbb 1000_1010 0BBB_ssss ssSS_SSSS
+ *
+ * b:  BBBbbb		destination register
+ * s:  SSSSSSssssss	source immediate (signed)
+ */
+#define OPC_MOVI	0x208a0000
+#define MOVI_S12(x)	((((x) & 0xfc0) >> 6) | (((x) & 0x3f) << 6))
+
+/*
+ * The 4-byte encoding of "mov[.qq] b,u6", used for conditional
+ * moving of even smaller immediates:
+ *
+ * 0010_0bbb 1100_1010 0BBB_cccc cciq_qqqq
+ *
+ * qq: qqqqq		condition code
+ * i:			If set, c is considered a 6-bit immediate, else a reg.
+ *
+ * b:  BBBbbb		destination register
+ * c:  cccccc		source
+ */
+#define OPC_MOV_CC	0x20ca0000
+#define MOV_CC_I	(1 << 5)
+#define OPC_MOVU_CC	(OPC_MOV_CC | MOV_CC_I)
+
+/*
+ * The 4-byte encoding of "sexb b,c" (8-bit sign extension):
+ *
+ * 0010_0bbb 0010_1111 0BBB_cccc cc00_0101
+ *
+ * b:  BBBbbb		destination register
+ * c:  cccccc		source register
+ */
+#define OPC_SEXB	0x202f0005
+
+/*
+ * The 4-byte encoding of "sexh b,c" (16-bit sign extension):
+ *
+ * 0010_0bbb 0010_1111 0BBB_cccc cc00_0110
+ *
+ * b:  BBBbbb		destination register
+ * c:  cccccc		source register
+ */
+#define OPC_SEXH	0x202f0006
+
+/*
+ * The 4-byte encoding of "ld[zz][.x][.aa] c,[b,s9]":
+ *
+ * 0001_0bbb ssss_ssss SBBB_0aaz zxcc_cccc
+ *
+ * zz:			size mode
+ * aa:			address write back mode
+ * x:			extension mode
+ *
+ * s9: S_ssss_ssss	9-bit signed number
+ * b:  BBBbbb		source reg for address
+ * c:  cccccc		destination register
+ */
+#define OPC_LOAD	0x10000000
+#define LOAD_X(x)	((x) << 6)
+#define LOAD_ZZ(x)	((x) << 7)
+#define LOAD_AA(x)	((x) << 9)
+#define LOAD_S9(x)	((((x) & 0x0ff) << 16) | (((x) & 0x100) <<  7))
+#define LOAD_C(x)	((x) & 0x03f)
+/* Unsigned and signed loads. */
+#define OPC_LDU		(OPC_LOAD | LOAD_X(X_zero))
+#define OPC_LDS		(OPC_LOAD | LOAD_X(X_sign))
+/* 32-bit load. */
+#define OPC_LD32	(OPC_LDU | LOAD_ZZ(ZZ_4_byte))
+/* "pop reg" is merely a "ld.ab reg,[sp,4]". */
+#define OPC_POP		\
+	(OPC_LD32 | LOAD_AA(AA_post) | LOAD_S9(4) | OP_B(ARC_R_SP))
+
+/*
+ * The 4-byte encoding of "st[zz][.aa] c,[b,s9]":
+ *
+ * 0001_1bbb ssss_ssss SBBB_cccc cc0a_azz0
+ *
+ * zz: zz		size mode
+ * aa: aa		address write back mode
+ *
+ * s9: S_ssss_ssss	9-bit signed number
+ * b:  BBBbbb		source reg for address
+ * c:  cccccc		source reg to be stored
+ */
+#define OPC_STORE	0x18000000
+#define STORE_ZZ(x)	((x) << 1)
+#define STORE_AA(x)	((x) << 3)
+#define STORE_S9(x)	((((x) & 0x0ff) << 16) | (((x) & 0x100) <<  7))
+/* 32-bit store. */
+#define OPC_ST32	(OPC_STORE | STORE_ZZ(ZZ_4_byte))
+/* "push reg" is merely a "st.aw reg,[sp,-4]". */
+#define OPC_PUSH	\
+	(OPC_ST32 | STORE_AA(AA_pre) | STORE_S9(-4) | OP_B(ARC_R_SP))
+
+/*
+ * The 4-byte encoding of "add a,b,c":
+ *
+ * 0010_0bbb 0i00_0000 fBBB_cccc ccaa_aaaa
+ *
+ * f:                   indicates if flags (carry, etc.) should be updated
+ * i:			If set, c is considered a 6-bit immediate, else a reg.
+ *
+ * a:  aaaaaa		result
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand
+ */
+#define OPC_ADD		0x20000000
+/* Addition with updating the pertinent flags in "status32" register. */
+#define OPC_ADDF	(OPC_ADD | FLAG(1))
+#define ADDI		(1 << 22)
+#define ADDI_U6(x)	OP_C(x)
+#define OPC_ADDI	(OPC_ADD | ADDI)
+#define OPC_ADDIF	(OPC_ADDI | FLAG(1))
+#define OPC_ADD_I	(OPC_ADD | OP_IMM)
+
+/*
+ * The 4-byte encoding of "adc a,b,c" (addition with carry):
+ *
+ * 0010_0bbb 0i00_0001 0BBB_cccc ccaa_aaaa
+ *
+ * i:			if set, c is considered a 6-bit immediate, else a reg.
+ *
+ * a:  aaaaaa		result
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand
+ */
+#define OPC_ADC		0x20010000
+#define ADCI		(1 << 22)
+#define ADCI_U6(x)	OP_C(x)
+#define OPC_ADCI	(OPC_ADC | ADCI)
+
+/*
+ * The 4-byte encoding of "sub a,b,c":
+ *
+ * 0010_0bbb 0i00_0010 fBBB_cccc ccaa_aaaa
+ *
+ * f:                   indicates if flags (carry, etc.) should be updated
+ * i:			if set, c is considered a 6-bit immediate, else a reg.
+ *
+ * a:  aaaaaa		result
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand
+ */
+#define OPC_SUB		0x20020000
+/* Subtraction with updating the pertinent flags in "status32" register. */
+#define OPC_SUBF	(OPC_SUB | FLAG(1))
+#define SUBI		(1 << 22)
+#define SUBI_U6(x)	OP_C(x)
+#define OPC_SUBI	(OPC_SUB | SUBI)
+#define OPC_SUB_I	(OPC_SUB | OP_IMM)
+
+/*
+ * The 4-byte encoding of "sbc a,b,c" (subtraction with carry):
+ *
+ * 0010_0bbb 0000_0011 fBBB_cccc ccaa_aaaa
+ *
+ * f:                   indicates if flags (carry, etc.) should be updated
+ *
+ * a:  aaaaaa		result
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand
+ */
+#define OPC_SBC		0x20030000
+
+/*
+ * The 4-byte encoding of "cmp[.qq] b,c":
+ *
+ * 0010_0bbb 1100_1100 1BBB_cccc cc0q_qqqq
+ *
+ * qq:	qqqqq		condition code
+ *
+ * b:  BBBbbb		the 1st operand
+ * c:  cccccc		the 2nd operand
+ */
+#define OPC_CMP		0x20cc8000
+
+/*
+ * The 4-byte encoding of "neg a,b":
+ *
+ * 0010_0bbb 0100_1110 0BBB_0000 00aa_aaaa
+ *
+ * a:  aaaaaa		result
+ * b:  BBBbbb		input
+ */
+#define OPC_NEG		0x204e0000
+
+/*
+ * The 4-byte encoding of "mpy a,b,c".
+ * mpy is the signed 32-bit multiplication with the lower 32-bit
+ * of the product as the result.
+ *
+ * 0010_0bbb 0001_1010 0BBB_cccc ccaa_aaaa
+ *
+ * a:  aaaaaa		result
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand
+ */
+#define OPC_MPY		0x201a0000
+#define OPC_MPYI	(OPC_MPY | OP_IMM)
+
+/*
+ * The 4-byte encoding of "mpydu a,b,c".
+ * mpydu is the unsigned 32-bit multiplication with the lower 32-bit of
+ * the product in register "a" and the higher 32-bit in register "a+1".
+ *
+ * 0010_1bbb 0001_1001 0BBB_cccc ccaa_aaaa
+ *
+ * a:  aaaaaa		64-bit result in registers (R_a+1,R_a)
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand
+ */
+#define OPC_MPYDU	0x28190000
+#define OPC_MPYDUI	(OPC_MPYDU | OP_IMM)
+
+/*
+ * The 4-byte encoding of "divu a,b,c" (unsigned division):
+ *
+ * 0010_1bbb 0000_0101 0BBB_cccc ccaa_aaaa
+ *
+ * a:  aaaaaa		result (quotient)
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand (divisor)
+ */
+#define OPC_DIVU	0x28050000
+#define OPC_DIVUI	(OPC_DIVU | OP_IMM)
+
+/*
+ * The 4-byte encoding of "div a,b,c" (signed division):
+ *
+ * 0010_1bbb 0000_0100 0BBB_cccc ccaa_aaaa
+ *
+ * a:  aaaaaa		result (quotient)
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand (divisor)
+ */
+#define OPC_DIVS	0x28040000
+#define OPC_DIVSI	(OPC_DIVS | OP_IMM)
+
+/*
+ * The 4-byte encoding of "remu a,b,c" (unsigned remainder):
+ *
+ * 0010_1bbb 0000_1001 0BBB_cccc ccaa_aaaa
+ *
+ * a:  aaaaaa		result (remainder)
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand (divisor)
+ */
+#define OPC_REMU	0x28090000
+#define OPC_REMUI	(OPC_REMU | OP_IMM)
+
+/*
+ * The 4-byte encoding of "rem a,b,c" (signed remainder):
+ *
+ * 0010_1bbb 0000_1000 0BBB_cccc ccaa_aaaa
+ *
+ * a:  aaaaaa		result (remainder)
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand (divisor)
+ */
+#define OPC_REMS	0x28080000
+#define OPC_REMSI	(OPC_REMS | OP_IMM)
+
+/*
+ * The 4-byte encoding of "and a,b,c":
+ *
+ * 0010_0bbb 0000_0100 fBBB_cccc ccaa_aaaa
+ *
+ * f:                   indicates if zero and negative flags should be updated
+ *
+ * a:  aaaaaa		result
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand
+ */
+#define OPC_AND		0x20040000
+#define OPC_ANDI	(OPC_AND | OP_IMM)
+
+/*
+ * The 4-byte encoding of "tst[.qq] b,c".
+ * Checks if the two input operands have any bit set at the same
+ * position.
+ *
+ * 0010_0bbb 1100_1011 1BBB_cccc cc0q_qqqq
+ *
+ * qq:	qqqqq		condition code
+ *
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand
+ */
+#define OPC_TST		0x20cb8000
+
+/*
+ * The 4-byte encoding of "or a,b,c":
+ *
+ * 0010_0bbb 0000_0101 0BBB_cccc ccaa_aaaa
+ *
+ * a:  aaaaaa		result
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand
+ */
+#define OPC_OR		0x20050000
+#define OPC_ORI		(OPC_OR | OP_IMM)
+
+/*
+ * The 4-byte encoding of "xor a,b,c":
+ *
+ * 0010_0bbb 0000_0111 0BBB_cccc ccaa_aaaa
+ *
+ * a:  aaaaaa		result
+ * b:  BBBbbb		the 1st input operand
+ * c:  cccccc		the 2nd input operand
+ */
+#define OPC_XOR		0x20070000
+#define OPC_XORI	(OPC_XOR | OP_IMM)
+
+/*
+ * The 4-byte encoding of "not b,c":
+ *
+ * 0010_0bbb 0010_1111 0BBB_cccc cc00_1010
+ *
+ * b:  BBBbbb		result
+ * c:  cccccc		input
+ */
+#define OPC_NOT		0x202f000a
+
+/*
+ * The 4-byte encoding of "btst b,u6":
+ *
+ * 0010_0bbb 0101_0001 1BBB_uuuu uu00_0000
+ *
+ * b:  BBBbbb		input number to check
+ * u6: uuuuuu		6-bit unsigned number specifying bit position to check
+ */
+#define OPC_BTSTU6	0x20518000
+#define BTST_U6(x)	(OP_C((x) & 63))
+
+/*
+ * The 4-byte encoding of "asl[.qq] b,b,c" (arithmetic shift left):
+ *
+ * 0010_1bbb 0i00_0000 0BBB_cccc ccaa_aaaa
+ *
+ * i:			if set, c is considered a 5-bit immediate, else a reg.
+ *
+ * b:  BBBbbb		result and the first operand (number to be shifted)
+ * c:  cccccc		amount to be shifted
+ */
+#define OPC_ASL		0x28000000
+#define ASL_I		(1 << 22)
+#define ASLI_U6(x)	OP_C((x) & 31)
+#define OPC_ASLI	(OPC_ASL | ASL_I)
+
+/*
+ * The 4-byte encoding of "asr a,b,c" (arithmetic shift right):
+ *
+ * 0010_1bbb 0i00_0010 0BBB_cccc ccaa_aaaa
+ *
+ * i:			if set, c is considered a 6-bit immediate, else a reg.
+ *
+ * a:  aaaaaa		result
+ * b:  BBBbbb		first input:  number to be shifted
+ * c:  cccccc		second input: amount to be shifted
+ */
+#define OPC_ASR		0x28020000
+#define ASR_I		ASL_I
+#define ASRI_U6(x)	ASLI_U6(x)
+#define OPC_ASRI	(OPC_ASR | ASR_I)
+
+/*
+ * The 4-byte encoding of "lsr a,b,c" (logical shift right):
+ *
+ * 0010_1bbb 0i00_0001 0BBB_cccc ccaa_aaaa
+ *
+ * i:			if set, c is considered a 6-bit immediate, else a reg.
+ *
+ * a:  aaaaaa		result
+ * b:  BBBbbb		first input:  number to be shifted
+ * c:  cccccc		second input: amount to be shifted
+ */
+#define OPC_LSR		0x28010000
+#define LSR_I		ASL_I
+#define LSRI_U6(x)	ASLI_U6(x)
+#define OPC_LSRI	(OPC_LSR | LSR_I)
+
+/*
+ * The 4-byte encoding of "swape b,c":
+ *
+ * 0010_1bbb 0010_1111 0bbb_cccc cc00_1001
+ *
+ * b:  BBBbbb		destination register
+ * c:  cccccc		source register
+ */
+#define OPC_SWAPE	0x282f0009
+
+/*
+ * Encoding for jump to an address in register:
+ * j reg_c
+ *
+ * 0010_0000 1110_0000 0000_cccc cc00_0000
+ *
+ * c:  cccccc		register holding the destination address
+ */
+#define OPC_JMP		0x20e00000
+/* Jump to "branch-and-link" register, which effectively is a "return". */
+#define OPC_J_BLINK	(OPC_JMP | OP_C(ARC_R_BLINK))
+
+/*
+ * Encoding for jump-and-link to an address in register:
+ * jl reg_c
+ *
+ * 0010_0000 0010_0010 0000_cccc cc00_0000
+ *
+ * c:  cccccc		register holding the destination address
+ */
+#define OPC_JL		0x20220000
+
+/*
+ * Encoding for (conditional) branch to an offset from the current location
+ * that is word aligned: (PC & 0xffff_fffc) + s21
+ * B[qq] s21
+ *
+ * 0000_0sss ssss_sss0 SSSS_SSSS SS0q_qqqq
+ *
+ * qq:	qqqqq				condition code
+ * s21:	SSSS SSSS_SSss ssss_ssss	The displacement (21-bit signed)
+ *
+ * The displacement is supposed to be 16-bit (2-byte) aligned. Therefore,
+ * it should be a multiple of 2. Hence, there is an implied '0' bit at its
+ * LSB: S_SSSS SSSS_Ssss ssss_sss0
+ */
+#define OPC_BCC		0x00000000
+#define BCC_S21(d)	((((d) & 0x7fe) << 16) | (((d) & 0x1ff800) >> 5))
+
+/*
+ * Encoding for unconditional branch to an offset from the current location
+ * that is word aligned: (PC & 0xffff_fffc) + s25
+ * B s25
+ *
+ * 0000_0sss ssss_sss1 SSSS_SSSS SS00_TTTT
+ *
+ * s25:	TTTT SSSS SSSS_SSss ssss_ssss	The displacement (25-bit signed)
+ *
+ * The displacement is supposed to be 16-bit (2-byte) aligned. Therefore,
+ * it should be a multiple of 2. Hence, there is an implied '0' bit at its
+ * LSB: T TTTS_SSSS SSSS_Ssss ssss_sss0
+ */
+#define OPC_B		0x00010000
+#define B_S25(d)	((((d) & 0x1e00000) >> 21) | BCC_S21(d))
+
+static inline void emit_2_bytes(u8 *buf, u16 bytes)
+{
+	*((u16 *) buf) = bytes;
+}
+
+static inline void emit_4_bytes(u8 *buf, u32 bytes)
+{
+	emit_2_bytes(buf+0, bytes >>     16);
+	emit_2_bytes(buf+2, bytes  & 0xffff);
+}
+
+static inline u8 bpf_to_arc_size(u8 size)
+{
+	switch (size) {
+	case BPF_B:
+		return ZZ_1_byte;
+	case BPF_H:
+		return ZZ_2_byte;
+	case BPF_W:
+		return ZZ_4_byte;
+	case BPF_DW:
+		return ZZ_8_byte;
+	default:
+		return ZZ_4_byte;
+	}
+}
+
+/************** Encoders (Deal with ARC regs) ************/
+
+/* Move an immediate to register with a 4-byte instruction. */
+static u8 arc_movi_r(u8 *buf, u8 reg, s16 imm)
+{
+	const u32 insn = OPC_MOVI | OP_B(reg) | MOVI_S12(imm);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* rd <- rs */
+static u8 arc_mov_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_MOV | OP_B(rd) | OP_C(rs);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* The emitted code may have different sizes based on "imm". */
+static u8 arc_mov_i(u8 *buf, u8 rd, s32 imm)
+{
+	const u32 insn = OPC_MOV | OP_B(rd) | OP_IMM;
+
+	if (IN_S12_RANGE(imm))
+		return arc_movi_r(buf, rd, imm);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+/* The emitted code will always have the same size (8). */
+static u8 arc_mov_i_fixed(u8 *buf, u8 rd, s32 imm)
+{
+	const u32 insn = OPC_MOV | OP_B(rd) | OP_IMM;
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+/* Conditional move. */
+static u8 arc_mov_cc_r(u8 *buf, u8 cc, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_MOV_CC | OP_B(rd) | OP_C(rs) | COND(cc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* Conditional move of a small immediate to rd. */
+static u8 arc_movu_cc_r(u8 *buf, u8 cc, u8 rd, u8 imm)
+{
+	const u32 insn = OPC_MOVU_CC | OP_B(rd) | OP_C(imm) | COND(cc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* Sign extension from a byte. */
+static u8 arc_sexb_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_SEXB | OP_B(rd) | OP_C(rs);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* Sign extension from two bytes. */
+static u8 arc_sexh_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_SEXH | OP_B(rd) | OP_C(rs);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* st reg, [reg_mem, off] */
+static u8 arc_st_r(u8 *buf, u8 reg, u8 reg_mem, s16 off, u8 zz)
+{
+	const u32 insn = OPC_STORE | STORE_ZZ(zz) | OP_C(reg) |
+		OP_B(reg_mem) | STORE_S9(off);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* st.aw reg, [sp, -4] */
+static u8 arc_push_r(u8 *buf, u8 reg)
+{
+	const u32 insn = OPC_PUSH | OP_C(reg);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* ld reg, [reg_mem, off] (unsigned) */
+static u8 arc_ld_r(u8 *buf, u8 reg, u8 reg_mem, s16 off, u8 zz)
+{
+	const u32 insn = OPC_LDU | LOAD_ZZ(zz) | LOAD_C(reg) |
+		OP_B(reg_mem) | LOAD_S9(off);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* ld.x reg, [reg_mem, off] (sign extend) */
+static u8 arc_ldx_r(u8 *buf, u8 reg, u8 reg_mem, s16 off, u8 zz)
+{
+	const u32 insn = OPC_LDS | LOAD_ZZ(zz) | LOAD_C(reg) |
+		OP_B(reg_mem) | LOAD_S9(off);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* ld.ab reg,[sp,4] */
+static u8 arc_pop_r(u8 *buf, u8 reg)
+{
+	const u32 insn = OPC_POP | LOAD_C(reg);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* add Ra,Ra,Rc */
+static u8 arc_add_r(u8 *buf, u8 ra, u8 rc)
+{
+	const u32 insn = OPC_ADD | OP_A(ra) | OP_B(ra) | OP_C(rc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* add.f Ra,Ra,Rc */
+static u8 arc_addf_r(u8 *buf, u8 ra, u8 rc)
+{
+	const u32 insn = OPC_ADDF | OP_A(ra) | OP_B(ra) | OP_C(rc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* add.f Ra,Ra,u6 */
+static u8 arc_addif_r(u8 *buf, u8 ra, u8 u6)
+{
+	const u32 insn = OPC_ADDIF | OP_A(ra) | OP_B(ra) | ADDI_U6(u6);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* add Ra,Ra,u6 */
+static u8 arc_addi_r(u8 *buf, u8 ra, u8 u6)
+{
+	const u32 insn = OPC_ADDI | OP_A(ra) | OP_B(ra) | ADDI_U6(u6);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* add Ra,Rb,imm */
+static u8 arc_add_i(u8 *buf, u8 ra, u8 rb, s32 imm)
+{
+	const u32 insn = OPC_ADD_I | OP_A(ra) | OP_B(rb);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+/* adc Ra,Ra,Rc */
+static u8 arc_adc_r(u8 *buf, u8 ra, u8 rc)
+{
+	const u32 insn = OPC_ADC | OP_A(ra) | OP_B(ra) | OP_C(rc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* adc Ra,Ra,u6 */
+static u8 arc_adci_r(u8 *buf, u8 ra, u8 u6)
+{
+	const u32 insn = OPC_ADCI | OP_A(ra) | OP_B(ra) | ADCI_U6(u6);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* sub Ra,Ra,Rc */
+static u8 arc_sub_r(u8 *buf, u8 ra, u8 rc)
+{
+	const u32 insn = OPC_SUB | OP_A(ra) | OP_B(ra) | OP_C(rc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* sub.f Ra,Ra,Rc */
+static u8 arc_subf_r(u8 *buf, u8 ra, u8 rc)
+{
+	const u32 insn = OPC_SUBF | OP_A(ra) | OP_B(ra) | OP_C(rc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* sub Ra,Ra,u6 */
+static u8 arc_subi_r(u8 *buf, u8 ra, u8 u6)
+{
+	const u32 insn = OPC_SUBI | OP_A(ra) | OP_B(ra) | SUBI_U6(u6);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* sub Ra,Ra,imm */
+static u8 arc_sub_i(u8 *buf, u8 ra, s32 imm)
+{
+	const u32 insn = OPC_SUB_I | OP_A(ra) | OP_B(ra);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+/* sbc Ra,Ra,Rc */
+static u8 arc_sbc_r(u8 *buf, u8 ra, u8 rc)
+{
+	const u32 insn = OPC_SBC | OP_A(ra) | OP_B(ra) | OP_C(rc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* cmp Rb,Rc */
+static u8 arc_cmp_r(u8 *buf, u8 rb, u8 rc)
+{
+	const u32 insn = OPC_CMP | OP_B(rb) | OP_C(rc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/*
+ * cmp.z Rb,Rc
+ *
+ * This "cmp.z" variant of compare instruction is used on lower
+ * 32-bits of register pairs after "cmp"ing their upper parts. If the
+ * upper parts are equal (z), then this one will proceed to check the
+ * rest.
+ */
+static u8 arc_cmpz_r(u8 *buf, u8 rb, u8 rc)
+{
+	const u32 insn = OPC_CMP | OP_B(rb) | OP_C(rc) | CC_equal;
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* neg Ra,Rb */
+static u8 arc_neg_r(u8 *buf, u8 ra, u8 rb)
+{
+	const u32 insn = OPC_NEG | OP_A(ra) | OP_B(rb);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* mpy Ra,Rb,Rc */
+static u8 arc_mpy_r(u8 *buf, u8 ra, u8 rb, u8 rc)
+{
+	const u32 insn = OPC_MPY | OP_A(ra) | OP_B(rb) | OP_C(rc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* mpy Ra,Rb,imm */
+static u8 arc_mpy_i(u8 *buf, u8 ra, u8 rb, s32 imm)
+{
+	const u32 insn = OPC_MPYI | OP_A(ra) | OP_B(rb);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+/* mpydu Ra,Ra,Rc */
+static u8 arc_mpydu_r(u8 *buf, u8 ra, u8 rc)
+{
+	const u32 insn = OPC_MPYDU | OP_A(ra) | OP_B(ra) | OP_C(rc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* mpydu Ra,Ra,imm */
+static u8 arc_mpydu_i(u8 *buf, u8 ra, s32 imm)
+{
+	const u32 insn = OPC_MPYDUI | OP_A(ra) | OP_B(ra);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+/* divu Rd,Rd,Rs */
+static u8 arc_divu_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_DIVU | OP_A(rd) | OP_B(rd) | OP_C(rs);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* divu Rd,Rd,imm */
+static u8 arc_divu_i(u8 *buf, u8 rd, s32 imm)
+{
+	const u32 insn = OPC_DIVUI | OP_A(rd) | OP_B(rd);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+/* div Rd,Rd,Rs */
+static u8 arc_divs_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_DIVS | OP_A(rd) | OP_B(rd) | OP_C(rs);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* div Rd,Rd,imm */
+static u8 arc_divs_i(u8 *buf, u8 rd, s32 imm)
+{
+	const u32 insn = OPC_DIVSI | OP_A(rd) | OP_B(rd);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+/* remu Rd,Rd,Rs */
+static u8 arc_remu_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_REMU | OP_A(rd) | OP_B(rd) | OP_C(rs);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* remu Rd,Rd,imm */
+static u8 arc_remu_i(u8 *buf, u8 rd, s32 imm)
+{
+	const u32 insn = OPC_REMUI | OP_A(rd) | OP_B(rd);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+/* rem Rd,Rd,Rs */
+static u8 arc_rems_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_REMS | OP_A(rd) | OP_B(rd) | OP_C(rs);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* rem Rd,Rd,imm */
+static u8 arc_rems_i(u8 *buf, u8 rd, s32 imm)
+{
+	const u32 insn = OPC_REMSI | OP_A(rd) | OP_B(rd);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+/* and Rd,Rd,Rs */
+static u8 arc_and_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_AND | OP_A(rd) | OP_B(rd) | OP_C(rs);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/* and Rd,Rd,limm */
+static u8 arc_and_i(u8 *buf, u8 rd, s32 imm)
+{
+	const u32 insn = OPC_ANDI | OP_A(rd) | OP_B(rd);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+/* tst Rd,Rs */
+static u8 arc_tst_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_TST | OP_B(rd) | OP_C(rs);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/*
+ * This particular version, "tst.z ...", is meant to be used after a
+ * "tst" on the low 32-bit of register pairs. If that "tst" is not
+ * zero, then we don't need to test the upper 32-bits lest it sets
+ * the zero flag.
+ */
+static u8 arc_tstz_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_TST | OP_B(rd) | OP_C(rs) | CC_equal;
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_or_r(u8 *buf, u8 rd, u8 rs1, u8 rs2)
+{
+	const u32 insn = OPC_OR | OP_A(rd) | OP_B(rs1) | OP_C(rs2);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_or_i(u8 *buf, u8 rd, s32 imm)
+{
+	const u32 insn = OPC_ORI | OP_A(rd) | OP_B(rd);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+static u8 arc_xor_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_XOR | OP_A(rd) | OP_B(rd) | OP_C(rs);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_xor_i(u8 *buf, u8 rd, s32 imm)
+{
+	const u32 insn = OPC_XORI | OP_A(rd) | OP_B(rd);
+
+	if (emit) {
+		emit_4_bytes(buf, insn);
+		emit_4_bytes(buf+INSN_len_normal, imm);
+	}
+	return INSN_len_normal + INSN_len_imm;
+}
+
+static u8 arc_not_r(u8 *buf, u8 rd, u8 rs)
+{
+	const u32 insn = OPC_NOT | OP_B(rd) | OP_C(rs);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_btst_i(u8 *buf, u8 rs, u8 imm)
+{
+	const u32 insn = OPC_BTSTU6 | OP_B(rs) | BTST_U6(imm);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_asl_r(u8 *buf, u8 rd, u8 rs1, u8 rs2)
+{
+	const u32 insn = OPC_ASL | OP_A(rd) | OP_B(rs1) | OP_C(rs2);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_asli_r(u8 *buf, u8 rd, u8 rs, u8 imm)
+{
+	const u32 insn = OPC_ASLI | OP_A(rd) | OP_B(rs) | ASLI_U6(imm);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_asr_r(u8 *buf, u8 rd, u8 rs1, u8 rs2)
+{
+	const u32 insn = OPC_ASR | OP_A(rd) | OP_B(rs1) | OP_C(rs2);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_asri_r(u8 *buf, u8 rd, u8 rs, u8 imm)
+{
+	const u32 insn = OPC_ASRI | OP_A(rd) | OP_B(rs) | ASRI_U6(imm);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_lsr_r(u8 *buf, u8 rd, u8 rs1, u8 rs2)
+{
+	const u32 insn = OPC_LSR | OP_A(rd) | OP_B(rs1) | OP_C(rs2);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_lsri_r(u8 *buf, u8 rd, u8 rs, u8 imm)
+{
+	const u32 insn = OPC_LSRI | OP_A(rd) | OP_B(rs) | LSRI_U6(imm);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_swape_r(u8 *buf, u8 r)
+{
+	const u32 insn = OPC_SWAPE | OP_B(r) | OP_C(r);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+static u8 arc_jmp_return(u8 *buf)
+{
+	if (emit)
+		emit_4_bytes(buf, OPC_J_BLINK);
+	return INSN_len_normal;
+}
+
+static u8 arc_jl(u8 *buf, u8 reg)
+{
+	const u32 insn = OPC_JL | OP_C(reg);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/*
+ * Conditional jump to an address that is max 21 bits away (signed).
+ *
+ * b<cc> s21
+ */
+static u8 arc_bcc(u8 *buf, u8 cc, int offset)
+{
+	const u32 insn = OPC_BCC | BCC_S21(offset) | COND(cc);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/*
+ * Unconditional jump to an address that is max 25 bits away (signed).
+ *
+ * b     s25
+ */
+static u8 arc_b(u8 *buf, s32 offset)
+{
+	const u32 insn = OPC_B | B_S25(offset);
+
+	if (emit)
+		emit_4_bytes(buf, insn);
+	return INSN_len_normal;
+}
+
+/************* Packers (Deal with BPF_REGs) **************/
+
+inline u8 zext(u8 *buf, u8 rd)
+{
+	if (zext_thyself && rd != BPF_REG_FP)
+		return arc_movi_r(buf, REG_HI(rd), 0);
+	else
+		return 0;
+}
+
+u8 mov_r32(u8 *buf, u8 rd, u8 rs, u8 sign_ext)
+{
+	u8 len = 0;
+
+	if (sign_ext) {
+		if (sign_ext == 8)
+			len = arc_sexb_r(buf, REG_LO(rd), REG_LO(rs));
+		else if (sign_ext == 16)
+			len = arc_sexh_r(buf, REG_LO(rd), REG_LO(rs));
+		else if (sign_ext == 32 && rd != rs)
+			len = arc_mov_r(buf, REG_LO(rd), REG_LO(rs));
+
+		return len;
+	}
+
+	/* Unsigned move. */
+
+	if (rd != rs)
+		len = arc_mov_r(buf, REG_LO(rd), REG_LO(rs));
+
+	return len;
+}
+
+u8 mov_r32_i32(u8 *buf, u8 reg, s32 imm)
+{
+	return arc_mov_i(buf, REG_LO(reg), imm);
+}
+
+u8 mov_r64(u8 *buf, u8 rd, u8 rs, u8 sign_ext)
+{
+	u8 len = 0;
+
+	if (sign_ext) {
+		/* First handle the low 32-bit part. */
+		len = mov_r32(buf, rd, rs, sign_ext);
+
+		/* Now propagate the sign bit of LO to HI. */
+		if (sign_ext == 8 || sign_ext == 16 || sign_ext == 32)
+			len += arc_asri_r(buf+len, REG_HI(rd), REG_LO(rd), 31);
+
+		return len;
+	}
+
+	/* Unsigned move. */
+
+	if (rd == rs)
+		return 0;
+
+	len = arc_mov_r(buf, REG_LO(rd), REG_LO(rs));
+
+	if (rs != BPF_REG_FP)
+		len += arc_mov_r(buf+len, REG_HI(rd), REG_HI(rs));
+	/* BPF_REG_FP is mapped to 32-bit "fp" register. */
+	else
+		len += arc_movi_r(buf+len, REG_HI(rd), 0);
+
+	return len;
+}
+
+/* Sign extend the 32-bit immediate into 64-bit register pair. */
+u8 mov_r64_i32(u8 *buf, u8 reg, s32 imm)
+{
+	u8 len = 0;
+
+	len = arc_mov_i(buf, REG_LO(reg), imm);
+
+	/* BPF_REG_FP is mapped to 32-bit "fp" register. */
+	if (reg != BPF_REG_FP) {
+		if (imm >= 0)
+			len += arc_movi_r(buf+len, REG_HI(reg), 0);
+		else
+			len += arc_movi_r(buf+len, REG_HI(reg), -1);
+	}
+
+	return len;
+}
+
+/*
+ * This is merely used for translation of "LD R, IMM64" instructions
+ * of the BPF. These sort of instructions are sometimes used for
+ * relocations. If during the normal pass, the relocation value is
+ * not known, the BPF instruction may look something like:
+ *
+ * LD R <- 0x0000_0001_0000_0001
+ *
+ * Which will nicely translate to two 4-byte ARC instructions:
+ *
+ * mov R_lo, 1               # imm is small enough to be s12
+ * mov R_hi, 1               # same
+ *
+ * However, during the extra pass, the IMM64 will have changed
+ * to the resolved address and looks something like:
+ *
+ * LD R <- 0x0000_0000_1234_5678
+ *
+ * Now, the translated code will require 12 bytes:
+ *
+ * mov R_lo, 0x12345678      # this is an 8-byte instruction
+ * mov R_hi, 0               # still 4 bytes
+ *
+ * Which in practice will result in overwriting the following
+ * instruction. To avoid such cases, we will always emit codes
+ * with fixed sizes.
+ */
+u8 mov_r64_i64(u8 *buf, u8 reg, u32 lo, u32 hi)
+{
+	u8 len;
+
+	len  = arc_mov_i_fixed(buf, REG_LO(reg), lo);
+	len += arc_mov_i_fixed(buf+len, REG_HI(reg), hi);
+
+	return len;
+}
+
+/*
+ * If the "off"set is too big (doesn't encode as S9) for:
+ *
+ *   {ld,st}  r, [rm, off]
+ *
+ * Then emit:
+ *
+ *   add r10, REG_LO(rm), off
+ *
+ * and make sure that r10 becomes the effective address:
+ *
+ *   {ld,st}  r, [r10, 0]
+ */
+static u8 adjust_mem_access(u8 *buf, s16 *off, u8 size,
+			    u8 rm, u8 *arc_reg_mem)
+{
+	u8 len = 0;
+	*arc_reg_mem = REG_LO(rm);
+
+	if (!IN_S9_RANGE(*off) ||
+	    (size == BPF_DW && !IN_S9_RANGE(*off + 4))) {
+		len += arc_add_i(buf+len,
+				 REG_LO(JIT_REG_TMP), REG_LO(rm), (u32) (*off));
+		*arc_reg_mem = REG_LO(JIT_REG_TMP);
+		*off = 0;
+	}
+
+	return len;
+}
+
+/* store rs, [rd, off] */
+u8 store_r(u8 *buf, u8 rs, u8 rd, s16 off, u8 size)
+{
+	u8 len, arc_reg_mem;
+
+	len = adjust_mem_access(buf, &off, size, rd, &arc_reg_mem);
+
+	if (size == BPF_DW) {
+		len += arc_st_r(buf+len, REG_LO(rs), arc_reg_mem, off,
+				ZZ_4_byte);
+		len += arc_st_r(buf+len, REG_HI(rs), arc_reg_mem, off+4,
+				ZZ_4_byte);
+	} else {
+		u8 zz = bpf_to_arc_size(size);
+
+		len += arc_st_r(buf+len, REG_LO(rs), arc_reg_mem, off, zz);
+	}
+
+	return len;
+}
+
+/*
+ * For {8,16,32}-bit stores:
+ *   mov r21, imm
+ *   st  r21, [...]
+ * For 64-bit stores:
+ *   mov r21, imm
+ *   st  r21, [...]
+ *   mov r21, {0,-1}
+ *   st  r21, [...+4]
+ */
+u8 store_i(u8 *buf, s32 imm, u8 rd, s16 off, u8 size)
+{
+	u8 len, arc_reg_mem;
+	/* REG_LO(JIT_REG_TMP) might be used by "adjust_mem_access()". */
+	const u8 arc_rs = REG_HI(JIT_REG_TMP);
+
+	len = adjust_mem_access(buf, &off, size, rd, &arc_reg_mem);
+
+	if (size == BPF_DW) {
+		len += arc_mov_i(buf+len, arc_rs, imm);
+		len += arc_st_r(buf+len, arc_rs, arc_reg_mem, off,
+				ZZ_4_byte);
+		imm = (imm >= 0 ? 0 : -1);
+		len += arc_mov_i(buf+len, arc_rs, imm);
+		len += arc_st_r(buf+len, arc_rs, arc_reg_mem, off+4,
+				ZZ_4_byte);
+	} else {
+		u8 zz = bpf_to_arc_size(size);
+
+		len += arc_mov_i(buf+len, arc_rs, imm);
+		len += arc_st_r(buf+len, arc_rs, arc_reg_mem, off, zz);
+	}
+
+	return len;
+}
+
+/*
+ * For the calling convention of a little endian machine, the LO part
+ * must be on top of the stack.
+ */
+static u8 push_r64(u8 *buf, u8 reg)
+{
+	u8 len = 0;
+
+#ifdef __LITTLE_ENDIAN
+	/* BPF_REG_FP is mapped to 32-bit "fp" register. */
+	if (reg != BPF_REG_FP)
+		len += arc_push_r(buf+len, REG_HI(reg));
+	len += arc_push_r(buf+len, REG_LO(reg));
+#else
+	len += arc_push_r(buf+len, REG_LO(reg));
+	if (reg != BPF_REG_FP)
+		len += arc_push_r(buf+len, REG_HI(reg));
+#endif
+
+	return len;
+}
+
+/* load rd, [rs, off] */
+u8 load_r(u8 *buf, u8 rd, u8 rs, s16 off, u8 size, bool sign_ext)
+{
+	u8 len, arc_reg_mem;
+
+	len = adjust_mem_access(buf, &off, size, rs, &arc_reg_mem);
+
+	if (size == BPF_B || size == BPF_H || size == BPF_W) {
+		const u8 zz = bpf_to_arc_size(size);
+
+		/* Use LD.X only if the data size is less than 32-bit. */
+		if (sign_ext && (zz == ZZ_1_byte || zz == ZZ_2_byte)) {
+			len += arc_ldx_r(buf+len, REG_LO(rd), arc_reg_mem,
+					 off, zz);
+		} else {
+			len += arc_ld_r(buf+len, REG_LO(rd), arc_reg_mem,
+					off, zz);
+		}
+
+		if (sign_ext) {
+			/* Propagate the sign bit to the higher reg. */
+			len += arc_asri_r(buf+len, REG_HI(rd), REG_LO(rd), 31);
+		} else {
+			len += arc_movi_r(buf+len, REG_HI(rd), 0);
+		}
+	} else if (size == BPF_DW) {
+		/*
+		 * We are about to issue 2 consecutive loads:
+		 *
+		 *   ld rx, [rb, off+0]
+		 *   ld ry, [rb, off+4]
+		 *
+		 * If "rx" and "rb" are the same registers, then the order
+		 * should change to guarantee that "rb" remains intact
+		 * during these 2 operations:
+		 *
+		 *   ld ry, [rb, off+4]
+		 *   ld rx, [rb, off+0]
+		 */
+		if (REG_LO(rd) != arc_reg_mem) {
+			len += arc_ld_r(buf+len, REG_LO(rd), arc_reg_mem,
+					off+0, ZZ_4_byte);
+			len += arc_ld_r(buf+len, REG_HI(rd), arc_reg_mem,
+					off+4, ZZ_4_byte);
+		} else {
+			len += arc_ld_r(buf+len, REG_HI(rd), arc_reg_mem,
+					off+4, ZZ_4_byte);
+			len += arc_ld_r(buf+len, REG_LO(rd), arc_reg_mem,
+					off+0, ZZ_4_byte);
+		}
+	}
+
+	return len;
+}
+
+u8 add_r32(u8 *buf, u8 rd, u8 rs)
+{
+	return arc_add_r(buf, REG_LO(rd), REG_LO(rs));
+}
+
+u8 add_r32_i32(u8 *buf, u8 rd, s32 imm)
+{
+	if (IN_U6_RANGE(imm))
+		return arc_addi_r(buf, REG_LO(rd), imm);
+	else
+		return arc_add_i(buf, REG_LO(rd), REG_LO(rd), imm);
+}
+
+u8 add_r64(u8 *buf, u8 rd, u8 rs)
+{
+	u8 len;
+
+	len  = arc_addf_r(buf, REG_LO(rd), REG_LO(rs));
+	len += arc_adc_r(buf+len, REG_HI(rd), REG_HI(rs));
+	return len;
+}
+
+u8 add_r64_i32(u8 *buf, u8 rd, s32 imm)
+{
+	u8 len;
+
+	if (IN_U6_RANGE(imm)) {
+		len  = arc_addif_r(buf, REG_LO(rd), imm);
+		len += arc_adci_r(buf+len, REG_HI(rd), 0);
+	} else {
+		len  = mov_r64_i32(buf, JIT_REG_TMP, imm);
+		len += add_r64(buf+len, rd, JIT_REG_TMP);
+	}
+	return len;
+}
+
+u8 sub_r32(u8 *buf, u8 rd, u8 rs)
+{
+	return arc_sub_r(buf, REG_LO(rd), REG_LO(rs));
+}
+
+u8 sub_r32_i32(u8 *buf, u8 rd, s32 imm)
+{
+	if (IN_U6_RANGE(imm))
+		return arc_subi_r(buf, REG_LO(rd), imm);
+	else
+		return arc_sub_i(buf, REG_LO(rd), imm);
+}
+
+u8 sub_r64(u8 *buf, u8 rd, u8 rs)
+{
+	u8 len;
+
+	len  = arc_subf_r(buf, REG_LO(rd), REG_LO(rs));
+	len += arc_sbc_r(buf+len, REG_HI(rd), REG_HI(rs));
+	return len;
+}
+
+u8 sub_r64_i32(u8 *buf, u8 rd, s32 imm)
+{
+	u8 len;
+
+	len  = mov_r64_i32(buf, JIT_REG_TMP, imm);
+	len += sub_r64(buf+len, rd, JIT_REG_TMP);
+	return len;
+}
+
+static u8 cmp_r32(u8 *buf, u8 rd, u8 rs)
+{
+	return arc_cmp_r(buf, REG_LO(rd), REG_LO(rs));
+}
+
+u8 neg_r32(u8 *buf, u8 r)
+{
+	return arc_neg_r(buf, REG_LO(r), REG_LO(r));
+}
+
+/* In a two's complement system, -r is (~r + 1). */
+u8 neg_r64(u8 *buf, u8 r)
+{
+	u8 len;
+
+	len  = arc_not_r(buf, REG_LO(r), REG_LO(r));
+	len += arc_not_r(buf+len, REG_HI(r), REG_HI(r));
+	len += add_r64_i32(buf+len, r, 1);
+	return len;
+}
+
+u8 mul_r32(u8 *buf, u8 rd, u8 rs)
+{
+	return arc_mpy_r(buf, REG_LO(rd), REG_LO(rd), REG_LO(rs));
+}
+
+u8 mul_r32_i32(u8 *buf, u8 rd, s32 imm)
+{
+	return arc_mpy_i(buf, REG_LO(rd), REG_LO(rd), imm);
+}
+
+/*
+ * MUL B, C
+ * --------
+ * mpy       t0, B_hi, C_lo
+ * mpy       t1, B_lo, C_hi
+ * mpydu   B_lo, B_lo, C_lo
+ * add     B_hi, B_hi,   t0
+ * add     B_hi, B_hi,   t1
+ */
+u8 mul_r64(u8 *buf, u8 rd, u8 rs)
+{
+	const u8 t0   = REG_LO(JIT_REG_TMP);
+	const u8 t1   = REG_HI(JIT_REG_TMP);
+	const u8 C_lo = REG_LO(rs);
+	const u8 C_hi = REG_HI(rs);
+	const u8 B_lo = REG_LO(rd);
+	const u8 B_hi = REG_HI(rd);
+	u8 len;
+
+	len  = arc_mpy_r(buf, t0, B_hi, C_lo);
+	len += arc_mpy_r(buf+len, t1, B_lo, C_hi);
+	len += arc_mpydu_r(buf+len, B_lo, C_lo);
+	len += arc_add_r(buf+len, B_hi, t0);
+	len += arc_add_r(buf+len, B_hi, t1);
+
+	return len;
+}
+
+/*
+ * MUL B, imm
+ * ----------
+ *
+ *  To get a 64-bit result from a signed 64x32 multiplication:
+ *
+ *         B_hi             B_lo   *
+ *         sign             imm
+ *  -----------------------------
+ *  HI(B_lo*imm)     LO(B_lo*imm)  +
+ *     B_hi*imm                    +
+ *     B_lo*sign
+ *  -----------------------------
+ *        res_hi           res_lo
+ *
+ * mpy     t1, B_lo, sign(imm)
+ * mpy     t0, B_hi, imm
+ * mpydu B_lo, B_lo, imm
+ * add   B_hi, B_hi,  t0
+ * add   B_hi, B_hi,  t1
+ *
+ * Note: We can't use signed double multiplication, "mpyd", instead of an
+ * unsigned version, "mpydu", and then get rid of the sign adjustments
+ * calculated in "t1". The signed multiplication, "mpyd", will consider
+ * both operands, "B_lo" and "imm", as signed inputs. However, for this
+ * 64x32 multiplication, "B_lo" must be treated as an unsigned number.
+ */
+u8 mul_r64_i32(u8 *buf, u8 rd, s32 imm)
+{
+	const u8 t0   = REG_LO(JIT_REG_TMP);
+	const u8 t1   = REG_HI(JIT_REG_TMP);
+	const u8 B_lo = REG_LO(rd);
+	const u8 B_hi = REG_HI(rd);
+	u8 len = 0;
+
+	if (imm == 1)
+		return 0;
+
+	/* Is the sign-extension of the immediate "-1"? */
+	if (imm < 0)
+		len += arc_neg_r(buf+len, t1, B_lo);
+
+	len += arc_mpy_i(buf+len, t0, B_hi, imm);
+	len += arc_mpydu_i(buf+len, B_lo, imm);
+	len += arc_add_r(buf+len, B_hi, t0);
+
+	/* Add the "sign*B_lo" part, if necessary. */
+	if (imm < 0)
+		len += arc_add_r(buf+len, B_hi, t1);
+
+	return len;
+}
+
+u8 div_r32(u8 *buf, u8 rd, u8 rs, bool sign_ext)
+{
+	if (sign_ext)
+		return arc_divs_r(buf, REG_LO(rd), REG_LO(rs));
+	else
+		return arc_divu_r(buf, REG_LO(rd), REG_LO(rs));
+}
+
+u8 div_r32_i32(u8 *buf, u8 rd, s32 imm, bool sign_ext)
+{
+	if (imm == 0)
+		return 0;
+
+	if (sign_ext)
+		return arc_divs_i(buf, REG_LO(rd), imm);
+	else
+		return arc_divu_i(buf, REG_LO(rd), imm);
+}
+
+u8 mod_r32(u8 *buf, u8 rd, u8 rs, bool sign_ext)
+{
+	if (sign_ext)
+		return arc_rems_r(buf, REG_LO(rd), REG_LO(rs));
+	else
+		return arc_remu_r(buf, REG_LO(rd), REG_LO(rs));
+}
+
+u8 mod_r32_i32(u8 *buf, u8 rd, s32 imm, bool sign_ext)
+{
+	if (imm == 0)
+		return 0;
+
+	if (sign_ext)
+		return arc_rems_i(buf, REG_LO(rd), imm);
+	else
+		return arc_remu_i(buf, REG_LO(rd), imm);
+}
+
+u8 and_r32(u8 *buf, u8 rd, u8 rs)
+{
+	return arc_and_r(buf, REG_LO(rd), REG_LO(rs));
+}
+
+u8 and_r32_i32(u8 *buf, u8 rd, s32 imm)
+{
+	return arc_and_i(buf, REG_LO(rd), imm);
+}
+
+u8 and_r64(u8 *buf, u8 rd, u8 rs)
+{
+	u8 len;
+
+	len  = arc_and_r(buf,     REG_LO(rd), REG_LO(rs));
+	len += arc_and_r(buf+len, REG_HI(rd), REG_HI(rs));
+	return len;
+}
+
+u8 and_r64_i32(u8 *buf, u8 rd, s32 imm)
+{
+	u8 len;
+
+	len  = mov_r64_i32(buf, JIT_REG_TMP, imm);
+	len += and_r64(buf+len, rd, JIT_REG_TMP);
+	return len;
+}
+
+static u8 tst_r32(u8 *buf, u8 rd, u8 rs)
+{
+	return arc_tst_r(buf, REG_LO(rd), REG_LO(rs));
+}
+
+u8 or_r32(u8 *buf, u8 rd, u8 rs)
+{
+	return arc_or_r(buf, REG_LO(rd), REG_LO(rd), REG_LO(rs));
+}
+
+u8 or_r32_i32(u8 *buf, u8 rd, s32 imm)
+{
+	return arc_or_i(buf, REG_LO(rd), imm);
+}
+
+u8 or_r64(u8 *buf, u8 rd, u8 rs)
+{
+	u8 len;
+
+	len  = arc_or_r(buf,     REG_LO(rd), REG_LO(rd), REG_LO(rs));
+	len += arc_or_r(buf+len, REG_HI(rd), REG_HI(rd), REG_HI(rs));
+	return len;
+}
+
+u8 or_r64_i32(u8 *buf, u8 rd, s32 imm)
+{
+	u8 len;
+
+	len  = mov_r64_i32(buf, JIT_REG_TMP, imm);
+	len += or_r64(buf+len, rd, JIT_REG_TMP);
+	return len;
+}
+
+u8 xor_r32(u8 *buf, u8 rd, u8 rs)
+{
+	return arc_xor_r(buf, REG_LO(rd), REG_LO(rs));
+}
+
+u8 xor_r32_i32(u8 *buf, u8 rd, s32 imm)
+{
+	return arc_xor_i(buf, REG_LO(rd), imm);
+}
+
+u8 xor_r64(u8 *buf, u8 rd, u8 rs)
+{
+	u8 len;
+
+	len  = arc_xor_r(buf,     REG_LO(rd), REG_LO(rs));
+	len += arc_xor_r(buf+len, REG_HI(rd), REG_HI(rs));
+	return len;
+}
+
+u8 xor_r64_i32(u8 *buf, u8 rd, s32 imm)
+{
+	u8 len;
+
+	len  = mov_r64_i32(buf, JIT_REG_TMP, imm);
+	len += xor_r64(buf+len, rd, JIT_REG_TMP);
+	return len;
+}
+
+/* "asl a,b,c" --> "a = (b << (c & 31))". */
+u8 lsh_r32(u8 *buf, u8 rd, u8 rs)
+{
+	return arc_asl_r(buf, REG_LO(rd), REG_LO(rd), REG_LO(rs));
+}
+
+u8 lsh_r32_i32(u8 *buf, u8 rd, u8 imm)
+{
+	return arc_asli_r(buf, REG_LO(rd), REG_LO(rd), imm);
+}
+
+/*
+ * algorithm
+ * ---------
+ * if (n <= 32)
+ *   to_hi = lo >> (32-n)   # (32-n) is the negate of "n" in a 5-bit width.
+ *   lo <<= n
+ *   hi <<= n
+ *   hi |= to_hi
+ * else
+ *   hi = lo << (n-32)
+ *   lo = 0
+ *
+ * assembly translation for "LSH B, C"
+ * (heavily influenced by ARC gcc)
+ * -----------------------------------
+ * not    t0, C_lo            # The first 3 lines are almost the same as:
+ * lsr    t1, B_lo, 1         #   neg   t0, C_lo
+ * lsr    t1, t1, t0          #   lsr   t1, B_lo, t0   --> t1 is "to_hi"
+ * mov    t0, C_lo*           # with one important difference. In "neg"
+ * asl    B_lo, B_lo, t0      # version, when C_lo=0, t1 becomes B_lo while
+ * asl    B_hi, B_hi, t0      # it should be 0. The "not" approach instead,
+ * or     B_hi, B_hi, t1      # "shift"s t1 once and 31 times, practically
+ * btst   t0, 5               # setting it to 0 when C_lo=0.
+ * mov.ne B_hi, B_lo**
+ * mov.ne B_lo, 0
+ *
+ * *The "mov t0, C_lo" is necessary to cover the cases that C is the same
+ * register as B.
+ *
+ * **ARC performs a shift in this manner: B <<= (C & 31)
+ * For 32<=n<64, "n-32" and "n&31" are the same. Therefore, "B << n" and
+ * "B << (n-32)" yield the same results. e.g. the results of "B << 35" and
+ * "B << 3" are the same.
+ *
+ * The behaviour is undefined for n >= 64.
+ */
+u8 lsh_r64(u8 *buf, u8 rd, u8 rs)
+{
+	const u8 t0   = REG_LO(JIT_REG_TMP);
+	const u8 t1   = REG_HI(JIT_REG_TMP);
+	const u8 C_lo = REG_LO(rs);
+	const u8 B_lo = REG_LO(rd);
+	const u8 B_hi = REG_HI(rd);
+	u8 len;
+
+	len  = arc_not_r(buf, t0, C_lo);
+	len += arc_lsri_r(buf+len, t1, B_lo, 1);
+	len += arc_lsr_r(buf+len, t1, t1, t0);
+	len += arc_mov_r(buf+len, t0, C_lo);
+	len += arc_asl_r(buf+len, B_lo, B_lo, t0);
+	len += arc_asl_r(buf+len, B_hi, B_hi, t0);
+	len += arc_or_r(buf+len, B_hi, B_hi, t1);
+	len += arc_btst_i(buf+len, t0, 5);
+	len += arc_mov_cc_r(buf+len, CC_unequal, B_hi, B_lo);
+	len += arc_movu_cc_r(buf+len, CC_unequal, B_lo, 0);
+
+	return len;
+}
+
+/*
+ * if (n < 32)
+ *   to_hi = B_lo >> 32-n          # extract upper n bits
+ *   lo <<= n
+ *   hi <<=n
+ *   hi |= to_hi
+ * else if (n < 64)
+ *   hi = lo << n-32
+ *   lo = 0
+ */
+u8 lsh_r64_i32(u8 *buf, u8 rd, s32 imm)
+{
+	const u8 t0   = REG_LO(JIT_REG_TMP);
+	const u8 B_lo = REG_LO(rd);
+	const u8 B_hi = REG_HI(rd);
+	const u8 n    = (u8) imm;
+	u8 len = 0;
+
+	if (n == 0) {
+		return 0;
+	} else if (n <= 31) {
+		len  = arc_lsri_r(buf, t0, B_lo, 32 - n);
+		len += arc_asli_r(buf+len, B_lo, B_lo, n);
+		len += arc_asli_r(buf+len, B_hi, B_hi, n);
+		len += arc_or_r(buf+len, B_hi, B_hi, t0);
+	} else if (n <= 63) {
+		len  = arc_asli_r(buf, B_hi, B_lo, n - 32);
+		len += arc_movi_r(buf+len, B_lo, 0);
+	}
+	/* n >= 64 is undefined behaviour. */
+
+	return len;
+}
+
+/* "lsr a,b,c" --> "a = (b >> (c & 31))". */
+u8 rsh_r32(u8 *buf, u8 rd, u8 rs)
+{
+	return arc_lsr_r(buf, REG_LO(rd), REG_LO(rd), REG_LO(rs));
+}
+
+u8 rsh_r32_i32(u8 *buf, u8 rd, u8 imm)
+{
+	return arc_lsri_r(buf, REG_LO(rd), REG_LO(rd), imm);
+}
+
+/*
+ * For better commentary, see lsh_r64().
+ *
+ * algorithm
+ * ---------
+ * if (n <= 32)
+ *   to_lo = hi << (32-n)
+ *   hi >>= n
+ *   lo >>= n
+ *   lo |= to_lo
+ * else
+ *   lo = hi >> (n-32)
+ *   hi = 0
+ *
+ * RSH    B,C
+ * ----------
+ * not    t0, C_lo
+ * asl    t1, B_hi, 1
+ * asl    t1, t1, t0
+ * mov    t0, C_lo
+ * lsr    B_hi, B_hi, t0
+ * lsr    B_lo, B_lo, t0
+ * or     B_lo, B_lo, t1
+ * btst   t0, 5
+ * mov.ne B_lo, B_hi
+ * mov.ne B_hi, 0
+ */
+u8 rsh_r64(u8 *buf, u8 rd, u8 rs)
+{
+	const u8 t0   = REG_LO(JIT_REG_TMP);
+	const u8 t1   = REG_HI(JIT_REG_TMP);
+	const u8 C_lo = REG_LO(rs);
+	const u8 B_lo = REG_LO(rd);
+	const u8 B_hi = REG_HI(rd);
+	u8 len;
+
+	len  = arc_not_r(buf, t0, C_lo);
+	len += arc_asli_r(buf+len, t1, B_hi, 1);
+	len += arc_asl_r(buf+len, t1, t1, t0);
+	len += arc_mov_r(buf+len, t0, C_lo);
+	len += arc_lsr_r(buf+len, B_hi, B_hi, t0);
+	len += arc_lsr_r(buf+len, B_lo, B_lo, t0);
+	len += arc_or_r(buf+len, B_lo, B_lo, t1);
+	len += arc_btst_i(buf+len, t0, 5);
+	len += arc_mov_cc_r(buf+len, CC_unequal, B_lo, B_hi);
+	len += arc_movu_cc_r(buf+len, CC_unequal, B_hi, 0);
+
+	return len;
+}
+
+/*
+ * if (n < 32)
+ *   to_lo = B_lo << 32-n     # extract lower n bits, right-padded with 32-n 0s
+ *   lo >>=n
+ *   hi >>=n
+ *   hi |= to_lo
+ * else if (n < 64)
+ *   lo = hi >> n-32
+ *   hi = 0
+ */
+u8 rsh_r64_i32(u8 *buf, u8 rd, s32 imm)
+{
+	const u8 t0   = REG_LO(JIT_REG_TMP);
+	const u8 B_lo = REG_LO(rd);
+	const u8 B_hi = REG_HI(rd);
+	const u8 n    = (u8) imm;
+	u8 len = 0;
+
+	if (n == 0) {
+		return 0;
+	} else if (n <= 31) {
+		len  = arc_asli_r(buf, t0, B_hi, 32 - n);
+		len += arc_lsri_r(buf+len, B_lo, B_lo, n);
+		len += arc_lsri_r(buf+len, B_hi, B_hi, n);
+		len += arc_or_r(buf+len, B_lo, B_lo, t0);
+	} else if (n <= 63) {
+		len  = arc_lsri_r(buf, B_lo, B_hi, n - 32);
+		len += arc_movi_r(buf+len, B_hi, 0);
+	}
+	/* n >= 64 is undefined behaviour. */
+
+	return len;
+}
+
+/* "asr a,b,c" --> "a = (b s>> (c & 31))". */
+u8 arsh_r32(u8 *buf, u8 rd, u8 rs)
+{
+	return arc_asr_r(buf, REG_LO(rd), REG_LO(rd), REG_LO(rs));
+}
+
+u8 arsh_r32_i32(u8 *buf, u8 rd, u8 imm)
+{
+	return arc_asri_r(buf, REG_LO(rd), REG_LO(rd), imm);
+}
+
+/*
+ * For comparison, see rsh_r64().
+ *
+ * algorithm
+ * ---------
+ * if (n <= 32)
+ *   to_lo = hi << (32-n)
+ *   hi s>>= n
+ *   lo  >>= n
+ *   lo |= to_lo
+ * else
+ *   hi_sign = hi s>>31
+ *   lo = hi s>> (n-32)
+ *   hi = hi_sign
+ *
+ * ARSH   B,C
+ * ----------
+ * not    t0, C_lo
+ * asl    t1, B_hi, 1
+ * asl    t1, t1, t0
+ * mov    t0, C_lo
+ * asr    B_hi, B_hi, t0
+ * lsr    B_lo, B_lo, t0
+ * or     B_lo, B_lo, t1
+ * btst   t0, 5
+ * asr    t0, B_hi, 31        # now, t0 = 0 or -1 based on B_hi's sign
+ * mov.ne B_lo, B_hi
+ * mov.ne B_hi, t0
+ */
+u8 arsh_r64(u8 *buf, u8 rd, u8 rs)
+{
+	const u8 t0   = REG_LO(JIT_REG_TMP);
+	const u8 t1   = REG_HI(JIT_REG_TMP);
+	const u8 C_lo = REG_LO(rs);
+	const u8 B_lo = REG_LO(rd);
+	const u8 B_hi = REG_HI(rd);
+	u8 len;
+
+	len  = arc_not_r(buf, t0, C_lo);
+	len += arc_asli_r(buf+len, t1, B_hi, 1);
+	len += arc_asl_r(buf+len, t1, t1, t0);
+	len += arc_mov_r(buf+len, t0, C_lo);
+	len += arc_asr_r(buf+len, B_hi, B_hi, t0);
+	len += arc_lsr_r(buf+len, B_lo, B_lo, t0);
+	len += arc_or_r(buf+len, B_lo, B_lo, t1);
+	len += arc_btst_i(buf+len, t0, 5);
+	len += arc_asri_r(buf+len, t0, B_hi, 31);
+	len += arc_mov_cc_r(buf+len, CC_unequal, B_lo, B_hi);
+	len += arc_mov_cc_r(buf+len, CC_unequal, B_hi, t0);
+
+	return len;
+}
+
+/*
+ * if (n < 32)
+ *   to_lo = lo << 32-n     # extract lower n bits, right-padded with 32-n 0s
+ *   lo >>=n
+ *   hi s>>=n
+ *   hi |= to_lo
+ * else if (n < 64)
+ *   lo = hi s>> n-32
+ *   hi = (lo[msb] ? -1 : 0)
+ */
+u8 arsh_r64_i32(u8 *buf, u8 rd, s32 imm)
+{
+	const u8 t0   = REG_LO(JIT_REG_TMP);
+	const u8 B_lo = REG_LO(rd);
+	const u8 B_hi = REG_HI(rd);
+	const u8 n    = (u8) imm;
+	u8 len = 0;
+
+	if (n == 0) {
+		return 0;
+	} else if (n <= 31) {
+		len  = arc_asli_r(buf, t0, B_hi, 32 - n);
+		len += arc_lsri_r(buf+len, B_lo, B_lo, n);
+		len += arc_asri_r(buf+len, B_hi, B_hi, n);
+		len += arc_or_r(buf+len, B_lo, B_lo, t0);
+	} else if (n <= 63) {
+		len  = arc_asri_r(buf, B_lo, B_hi, n - 32);
+		len += arc_movi_r(buf+len, B_hi, -1);
+		len += arc_btst_i(buf+len, B_lo, 31);
+		len += arc_movu_cc_r(buf+len, CC_equal, B_hi, 0);
+	}
+	/* n >= 64 is undefined behaviour. */
+
+	return len;
+}
+
+u8 gen_swap(u8 *buf, u8 rd, u8 size, u8 endian, bool force)
+{
+	u8 len = 0;
+#ifdef __BIG_ENDIAN
+	const u8 host_endian = BPF_FROM_BE;
+#else
+	const u8 host_endian = BPF_FROM_LE;
+#endif
+	/*
+	 * If the same endianness, there's not much to do other
+	 * than zeroing out the upper bytes based on the "size".
+	 */
+	if ((force == false) && (host_endian == endian)) {
+		switch (size) {
+		case 16:
+			len += arc_and_i(buf+len, REG_LO(rd), 0xffff);
+			fallthrough;
+		case 32:
+			len += zext(buf+len, rd);
+			fallthrough;
+		case 64:
+			break;
+		default:
+			/* The caller must have handled this. */
+		}
+	} else {
+		switch (size) {
+		case 16:
+			/*
+			 * r = B4B3_B2B1 << 16 --> r = B2B1_0000
+			 * swape(r) is 0000_B1B2
+			 */
+			len += arc_asli_r(buf+len, REG_LO(rd), REG_LO(rd), 16);
+			fallthrough;
+		case 32:
+			len += arc_swape_r(buf+len, REG_LO(rd));
+			len += zext(buf+len, rd);
+			break;
+		case 64:
+			/*
+			 * swap "hi" and "lo":
+			 *   hi ^= lo;
+			 *   lo ^= hi;
+			 *   hi ^= lo;
+			 * and then swap the bytes in "hi" and "lo".
+			 */
+			len += arc_xor_r(buf+len, REG_HI(rd), REG_LO(rd));
+			len += arc_xor_r(buf+len, REG_LO(rd), REG_HI(rd));
+			len += arc_xor_r(buf+len, REG_HI(rd), REG_LO(rd));
+			len += arc_swape_r(buf+len, REG_LO(rd));
+			len += arc_swape_r(buf+len, REG_HI(rd));
+			break;
+		default:
+			/* The caller must have handled this. */
+		}
+	}
+
+	return len;
+}
+
+/*
+ * To create a frame, all that is needed is:
+ *
+ *  push fp
+ *  mov  fp, sp
+ *  sub  sp, <frame_size>
+ *
+ * "push fp" is taken care of separately while saving the clobbered registers.
+ * All that remains is copying SP value to FP and shrinking SP's address space
+ * for any possible function call to come.
+ */
+static inline u8 frame_create(u8 *buf, u16 size)
+{
+	u8 len;
+
+	len = arc_mov_r(buf, ARC_R_FP, ARC_R_SP);
+	if (IN_U6_RANGE(size))
+		len += arc_subi_r(buf+len, ARC_R_SP, size);
+	else
+		len += arc_sub_i(buf+len, ARC_R_SP, size);
+	return len;
+}
+
+/*
+ * mov sp, fp
+ *
+ * The value of SP upon entering was copied to FP.
+ */
+static inline u8 frame_restore(u8 *buf)
+{
+	return arc_mov_r(buf, ARC_R_SP, ARC_R_FP);
+}
+
+/*
+ * Going from a JITed code to the native caller:
+ *
+ * mov ARC_ABI_RET_lo, BPF_REG_0_lo     # r0 <- r8
+ * mov ARC_ABI_RET_hi, BPF_REG_0_hi     # r1 <- r9
+ */
+static u8 bpf_to_arc_return(u8 *buf)
+{
+	u8 len;
+
+	len  = arc_mov_r(buf, ARC_R_0, REG_LO(BPF_REG_0));
+	len += arc_mov_r(buf+len, ARC_R_1, REG_HI(BPF_REG_0));
+	return len;
+}
+
+/*
+ * Coming back from an external (in-kernel) function to the JITed code:
+ *
+ * mov ARC_ABI_RET_lo, BPF_REG_0_lo     # r8 <- r0
+ * mov ARC_ABI_RET_hi, BPF_REG_0_hi     # r9 <- r1
+ */
+u8 arc_to_bpf_return(u8 *buf)
+{
+	u8 len;
+
+	len  = arc_mov_r(buf, REG_LO(BPF_REG_0), ARC_R_0);
+	len += arc_mov_r(buf+len, REG_HI(BPF_REG_0), ARC_R_1);
+	return len;
+}
+
+/*
+ * This translation leads to:
+ *
+ *   mov r10, addr                # always an 8-byte instruction
+ *   jl  [r10]
+ *
+ * The length of the "mov" must be fixed (8), otherwise it may diverge
+ * during the normal and extra passes:
+ *
+ *          normal pass                  extra pass
+ *
+ *   180:  mov     r10,0        |   180:  mov     r10,0x700578d8
+ *   184:  jl      [r10]        |   188:  jl      [r10]
+ *   188:  add.f   r16,r16,0x1  |   18c:  adc     r17,r17,0
+ *   18c:  adc     r17,r17,0    |
+ *
+ * In the above example, the change from "r10 <- 0" to "r10 <- 0x700578d8"
+ * has led to an increase in the length of the "mov" instruction.
+ * Inadvertently, that caused the loss of the "add.f" instruction.
+ */
+static u8 jump_and_link(u8 *buf, u32 addr)
+{
+	u8 len;
+
+	len  = arc_mov_i_fixed(buf, REG_LO(JIT_REG_TMP), addr);
+	len += arc_jl(buf+len, REG_LO(JIT_REG_TMP));
+	return len;
+}
+
+/*
+ * This function determines which ARC registers must be saved and restored.
+ * It does so by looking into:
+ *
+ * "bpf_reg": The clobbered (destination) BPF register
+ * "is_call": Indicator if the current instruction is a call
+ *
+ * When a register of interest is clobbered, its corresponding bit position
+ * in return value, "usage", is set to true.
+ */
+u32 mask_for_used_regs(u8 bpf_reg, bool is_call)
+{
+	u32 usage = 0;
+
+	/* BPF registers that must be saved. */
+	if (bpf_reg >= BPF_REG_6 && bpf_reg <= BPF_REG_9) {
+		usage |= BIT(REG_LO(bpf_reg));
+		usage |= BIT(REG_HI(bpf_reg));
+	/*
+	 * Using the frame pointer register implies that it should
+	 * be saved and reinitialised with the current frame data.
+	 */
+	} else if (bpf_reg == BPF_REG_FP) {
+		usage |= BIT(REG_LO(BPF_REG_FP));
+	/* Could there be some ARC registers that must to be saved? */
+	} else {
+		if (REG_LO(bpf_reg) >= ARC_CALLEE_SAVED_REG_FIRST &&
+		    REG_LO(bpf_reg) <= ARC_CALLEE_SAVED_REG_LAST)
+			usage |= BIT(REG_LO(bpf_reg));
+
+		if (REG_HI(bpf_reg) >= ARC_CALLEE_SAVED_REG_FIRST &&
+		    REG_HI(bpf_reg) <= ARC_CALLEE_SAVED_REG_LAST)
+			usage |= BIT(REG_HI(bpf_reg));
+	}
+
+	/* A "call" indicates that ARC's "blink" reg must be saved. */
+	usage |= is_call ? BIT(ARC_R_BLINK) : 0;
+
+	return usage;
+}
+
+/*
+ * push blink             # if blink is marked as clobbered
+ * push r[0-n]            # if r[i] is marked as clobbered
+ * push fp                # if fp is marked as clobbered
+ * mov  fp, sp            # if frame_size > 0 (clobbers fp)
+ * sub  sp, <frame_size>  # same as above
+ */
+u8 arc_prologue(u8 *buf, u32 usage, u16 frame_size)
+{
+	u8 len = 0;
+	u32 gp_regs = 0;
+
+	/* Deal with blink first. */
+	if (usage & BIT(ARC_R_BLINK))
+		len += arc_push_r(buf+len, ARC_R_BLINK);
+
+	gp_regs = usage & ~(BIT(ARC_R_BLINK) | BIT(ARC_R_FP));
+	while (gp_regs) {
+		u8 reg = __builtin_ffs(gp_regs) - 1;
+
+		len += arc_push_r(buf+len, reg);
+		gp_regs &= ~BIT(reg);
+	}
+
+	/* Deal with fp last. */
+	if ((usage & BIT(ARC_R_FP)) || (frame_size > 0))
+		len += arc_push_r(buf+len, ARC_R_FP);
+
+	if (frame_size > 0)
+		len += frame_create(buf+len, frame_size);
+
+#ifdef ARC_BPF_JIT_DEBUG
+	if ((usage & BIT(ARC_R_FP)) && (frame_size == 0)) {
+		pr_err("FP is being saved while there is no frame.");
+		BUG();
+	}
+#endif
+
+	return len;
+}
+
+/*
+ * mov  sp, fp            # if frame_size > 0
+ * pop  fp                # if fp is marked as clobbered
+ * pop  r[n-0]            # if r[i] is marked as clobbered
+ * pop  blink             # if blink is marked as clobbered
+ * mov  r0, r8            # always: ABI_return <- BPF_return
+ * mov  r1, r9            # continuation of above
+ * j    [blink]           # always
+ *
+ * "fp being marked as clobbered" and "frame_size > 0" are the two sides of
+ * the same coin.
+ */
+u8 arc_epilogue(u8 *buf, u32 usage, u16 frame_size)
+{
+	u32 len = 0;
+	u32 gp_regs = 0;
+
+#ifdef ARC_BPF_JIT_DEBUG
+	if ((usage & BIT(ARC_R_FP)) && (frame_size == 0)) {
+		pr_err("FP is being saved while there is no frame.");
+		BUG();
+	}
+#endif
+
+	if (frame_size > 0)
+		len += frame_restore(buf+len);
+
+	/* Deal with fp first. */
+	if ((usage & BIT(ARC_R_FP)) || (frame_size > 0))
+		len += arc_pop_r(buf+len, ARC_R_FP);
+
+	gp_regs = usage & ~(BIT(ARC_R_BLINK) | BIT(ARC_R_FP));
+	while (gp_regs) {
+		/* "usage" is 32-bit, each bit indicating an ARC register. */
+		u8 reg = 31 - __builtin_clz(gp_regs);
+
+		len += arc_pop_r(buf+len, reg);
+		gp_regs &= ~BIT(reg);
+	}
+
+	/* Deal with blink last. */
+	if (usage & BIT(ARC_R_BLINK))
+		len += arc_pop_r(buf+len, ARC_R_BLINK);
+
+	/* Wrap up the return value and jump back to the caller. */
+	len += bpf_to_arc_return(buf+len);
+	len += arc_jmp_return(buf+len);
+
+	return len;
+}
+
+/*
+ * For details on the algorithm, see the comments of "gen_jcc_64()".
+ *
+ * This data structure is holding information for jump translations.
+ *
+ * jit_off: How many bytes into the current JIT address, "b"ranch insn. occurs
+ * cond: The condition that the ARC branch instruction must use
+ *
+ * e.g.:
+ *
+ * BPF_JGE  R1, R0, @target
+ * ------------------------
+ *            |
+ *            v
+ * 0x1000: cmp  r3, r1     # 0x1000 is the JIT address for "BPF_JGE ..." insn
+ * 0x1004: bhi  @target    # first jump (branch higher)
+ * 0x1008: blo  @end       # second jump acting as a skip (end is 0x1014)
+ * 0x100C: cmp  r2, r0     # the lower 32 bits are evaluated
+ * 0x1010: bhs  @target    # third jump (branch higher or same)
+ * 0x1014: ...
+ *
+ * The jit_off(set) of the "bhi" is 4 bytes.
+ * The cond(ition) for the "bhi" is "CC_great_u".
+ *
+ * The jit_off(set) is necessary for calculating the exact displacement
+ * to the "target" address:
+ *
+ * jit_address + jit_off(set) - @target
+ * 0x1000      + 4            - @target
+ */
+#define JCC64_NR_OF_JMPS 3	/* Number of jumps in jcc64 template. */
+#define JCC64_INSNS_TO_END 3	/* Number of insn. inclusive the 2nd jmp to end. */
+#define JCC64_SKIP_JMP 1	/* Index of the "skip" jump to "end". */
+const struct {
+	/*
+	 * "jit_off" is common between all "jmp[]" and is coupled with
+	 * "cond" of each "jmp[]" instance. e.g.:
+	 *
+	 * arcv2_64_jccs.jit_off[1]
+	 * arcv2_64_jccs.jmp[ARC_CC_UGT].cond[1]
+	 *
+	 * Are indicating that the second jump in JITed code of "UGT"
+	 * is at offset "jit_off[1]" while its condition is "cond[1]".
+	 */
+	u8 jit_off[JCC64_NR_OF_JMPS];
+
+	struct {
+		u8 cond[JCC64_NR_OF_JMPS];
+	} jmp[ARC_CC_SLE+1];
+} arcv2_64_jccs = {
+	.jit_off = {
+		INSN_len_normal*1,
+		INSN_len_normal*2,
+		INSN_len_normal*4
+	},
+	/*
+	 *   cmp  rd_hi, rs_hi
+	 *   bhi  @target         # 1: u>
+	 *   blo  @end            # 2: u<
+	 *   cmp  rd_lo, rs_lo
+	 *   bhi  @target         # 3: u>
+	 * end:
+	 */
+	.jmp[ARC_CC_UGT] = {
+		.cond = {CC_great_u, CC_less_u, CC_great_u}
+	},
+	/*
+	 *   cmp  rd_hi, rs_hi
+	 *   bhi  @target         # 1: u>
+	 *   blo  @end            # 2: u<
+	 *   cmp  rd_lo, rs_lo
+	 *   bhs  @target         # 3: u>=
+	 * end:
+	 */
+	.jmp[ARC_CC_UGE] = {
+		.cond = {CC_great_u, CC_less_u, CC_great_eq_u}
+	},
+	/*
+	 *   cmp  rd_hi, rs_hi
+	 *   blo  @target         # 1: u<
+	 *   bhi  @end            # 2: u>
+	 *   cmp  rd_lo, rs_lo
+	 *   blo  @target         # 3: u<
+	 * end:
+	 */
+	.jmp[ARC_CC_ULT] = {
+		.cond = {CC_less_u, CC_great_u, CC_less_u}
+	},
+	/*
+	 *   cmp  rd_hi, rs_hi
+	 *   blo  @target         # 1: u<
+	 *   bhi  @end            # 2: u>
+	 *   cmp  rd_lo, rs_lo
+	 *   bls  @target         # 3: u<=
+	 * end:
+	 */
+	.jmp[ARC_CC_ULE] = {
+		.cond = {CC_less_u, CC_great_u, CC_less_eq_u}
+	},
+	/*
+	 *   cmp  rd_hi, rs_hi
+	 *   bgt  @target         # 1: s>
+	 *   blt  @end            # 2: s<
+	 *   cmp  rd_lo, rs_lo
+	 *   bhi  @target         # 3: u>
+	 * end:
+	 */
+	.jmp[ARC_CC_SGT] = {
+		.cond = {CC_great_s, CC_less_s, CC_great_u}
+	},
+	/*
+	 *   cmp  rd_hi, rs_hi
+	 *   bgt  @target         # 1: s>
+	 *   blt  @end            # 2: s<
+	 *   cmp  rd_lo, rs_lo
+	 *   bhs  @target         # 3: u>=
+	 * end:
+	 */
+	.jmp[ARC_CC_SGE] = {
+		.cond = {CC_great_s, CC_less_s, CC_great_eq_u}
+	},
+	/*
+	 *   cmp  rd_hi, rs_hi
+	 *   blt  @target         # 1: s<
+	 *   bgt  @end            # 2: s>
+	 *   cmp  rd_lo, rs_lo
+	 *   blo  @target         # 3: u<
+	 * end:
+	 */
+	.jmp[ARC_CC_SLT] = {
+		.cond = {CC_less_s, CC_great_s, CC_less_u}
+	},
+	/*
+	 *   cmp  rd_hi, rs_hi
+	 *   blt  @target         # 1: s<
+	 *   bgt  @end            # 2: s>
+	 *   cmp  rd_lo, rs_lo
+	 *   bls  @target         # 3: u<=
+	 * end:
+	 */
+	.jmp[ARC_CC_SLE] = {
+		.cond = {CC_less_s, CC_great_s, CC_less_eq_u}
+	}
+};
+
+/*
+ * The displacement (offset) for ARC's "b"ranch instruction is the distance
+ * from the aligned version of _current_ instruction (PCL) to the target
+ * instruction:
+ *
+ * DISP = TARGET - PCL          # PCL is the word aligned PC
+ */
+static inline s32 get_displacement(u32 curr_off, u32 targ_off)
+{
+	return (s32) (targ_off - (curr_off & ~3L));
+}
+
+/*
+ * "disp"lacement should be:
+ *
+ * 1. 16-bit aligned.
+ * 2. fit in S25, because no "condition code" is supposed to be encoded.
+ */
+static inline bool is_valid_far_disp(s32 disp)
+{
+	return (!(disp & 1) && IN_S25_RANGE(disp));
+}
+
+/*
+ * "disp"lacement should be:
+ *
+ * 1. 16-bit aligned.
+ * 2. fit in S21, because "condition code" is supposed to be encoded too.
+ */
+static inline bool is_valid_near_disp(s32 disp)
+{
+	return (!(disp & 1) && IN_S21_RANGE(disp));
+}
+
+/*
+ * cmp        rd_hi, rs_hi
+ * cmp.z      rd_lo, rs_lo
+ * b{eq,ne}   @target
+ *   |  |
+ *   |  `-->  "eq" param is false (JNE)
+ *   `----->  "eq" param is true  (JEQ)
+ */
+static int gen_j_eq_64(u8 *buf, u8 rd, u8 rs, bool eq,
+		       u32 curr_off, u32 targ_off)
+{
+	s32 disp;
+	u8 len = 0;
+
+	len += arc_cmp_r(buf+len, REG_HI(rd), REG_HI(rs));
+	len += arc_cmpz_r(buf+len, REG_LO(rd), REG_LO(rs));
+	disp = get_displacement(curr_off + len, targ_off);
+	len += arc_bcc(buf+len, eq ? CC_equal : CC_unequal, disp);
+
+	return len;
+}
+
+/*
+ * tst   rd_hi, rs_hi
+ * tst.z rd_lo, rs_lo
+ * bne   @target
+ */
+static u8 gen_jset_64(u8 *buf, u8 rd, u8 rs, u32 curr_off, u32 targ_off)
+{
+	u8 len = 0;
+	s32 disp;
+
+	len += arc_tst_r(buf+len, REG_HI(rd), REG_HI(rs));
+	len += arc_tstz_r(buf+len, REG_LO(rd), REG_LO(rs));
+	disp = get_displacement(curr_off + len, targ_off);
+	len += arc_bcc(buf+len, CC_unequal, disp);
+
+	return len;
+}
+
+
+/*
+ * Verify if all the jumps for a JITed jcc64 operation are valid,
+ * by consulting the data stored at "arcv2_64_jccs".
+ */
+static bool check_jcc_64(u32 curr_off, u32 targ_off, u8 cond)
+{
+	size_t i;
+
+	if (cond >= ARC_CC_LAST)
+		return false;
+
+	for (i = 0; i < JCC64_NR_OF_JMPS; i++) {
+		u32 from, to;
+
+		from = curr_off + arcv2_64_jccs.jit_off[i];
+		/* for the 2nd jump, we jump to the end of block. */
+		if (i != JCC64_SKIP_JMP)
+			to = targ_off;
+		else
+			to = from + (JCC64_INSNS_TO_END * INSN_len_normal);
+		/* There is a "cc" in the instruction, so a "near" jump. */
+		if (!is_valid_near_disp(get_displacement(from, to)))
+			return false;
+	}
+
+	return true;
+}
+
+/* Can the jump from "curr_off" to "targ_off" actually happen? */
+bool check_jmp_64(u32 curr_off, u32 targ_off, u8 cond)
+{
+	s32 disp;
+
+	switch (cond) {
+	case ARC_CC_UGT:
+	case ARC_CC_UGE:
+	case ARC_CC_ULT:
+	case ARC_CC_ULE:
+	case ARC_CC_SGT:
+	case ARC_CC_SGE:
+	case ARC_CC_SLT:
+	case ARC_CC_SLE:
+		return check_jcc_64(curr_off, targ_off, cond);
+	case ARC_CC_EQ:
+	case ARC_CC_NE:
+	case ARC_CC_SET:
+		/*
+		 * The "jump" for the JITed BPF_J{SET,EQ,NE} is actually the
+		 * 3rd instruction. See comments of "gen_j{set,_eq}_64()".
+		 */
+		curr_off += 2 * INSN_len_normal;
+		disp = get_displacement(curr_off, targ_off);
+		/* There is a "cc" field in the issued instruction. */
+		return is_valid_near_disp(disp);
+	case ARC_CC_AL:
+		disp = get_displacement(curr_off, targ_off);
+		return is_valid_far_disp(disp);
+	default:
+		return false;
+	}
+}
+
+/*
+ * The template for the 64-bit jumps with the following BPF conditions
+ *
+ * u< u<= u> u>= s< s<= s> s>=
+ *
+ * Looks like below:
+ *
+ *   cmp   rd_hi, rs_hi
+ *   b<c1> @target
+ *   b<c2> @end
+ *   cmp   rd_lo, rs_lo   # if execution reaches here, r{d,s}_hi are equal
+ *   b<c3> @target
+ * end:
+ *
+ * "c1" is the condition that JIT is handling minus the equality part.
+ * For instance if we have to translate an "unsigned greater or equal",
+ * then "c1" will be "unsigned greater". We won't know about equality
+ * until all 64-bits of data (higeher and lower registers) are processed.
+ *
+ * "c2" is the counter logic of "c1". For instance, if "c1" is originated
+ * from "s>", then "c2" would be "s<". Notice that equality doesn't play
+ * a role here either, because the lower 32 bits are not processed yet.
+ *
+ * "c3" is the unsigned version of "c1", no matter if the BPF condition
+ * was signed or unsigned. An unsigned version is necessary, because the
+ * MSB of the lower 32 bits does not reflect a sign in the whole 64-bit
+ * scheme. Otherwise, 64-bit comparisons like
+ * (0x0000_0000,0x8000_0000) s>= (0x0000_0000,0x0000_0000)
+ * would yield an incorrect result. Finally, if there is an equality
+ * check in the BPF condition, it will be reflected in "c3".
+ *
+ * You can find all the instances of this template where the
+ * "arcv2_64_jccs" is getting initialised.
+ */
+static u8 gen_jcc_64(u8 *buf, u8 rd, u8 rs, u8 cond,
+		     u32 curr_off, u32 targ_off)
+{
+	s32 disp;
+	u32 end_off;
+	const u8 *cc = arcv2_64_jccs.jmp[cond].cond;
+	u8 len = 0;
+
+	/* cmp rd_hi, rs_hi */
+	len += arc_cmp_r(buf, REG_HI(rd), REG_HI(rs));
+
+	/* b<c1> @target */
+	disp = get_displacement(curr_off + len, targ_off);
+	len += arc_bcc(buf+len, cc[0], disp);
+
+	/* b<c2> @end */
+	end_off = curr_off + len + (JCC64_INSNS_TO_END * INSN_len_normal);
+	disp = get_displacement(curr_off + len, end_off);
+	len += arc_bcc(buf+len, cc[1], disp);
+
+	/* cmp rd_lo, rs_lo */
+	len += arc_cmp_r(buf+len, REG_LO(rd), REG_LO(rs));
+
+	/* b<c3> @target */
+	disp = get_displacement(curr_off + len, targ_off);
+	len += arc_bcc(buf+len, cc[2], disp);
+
+	return len;
+}
+
+/*
+ * This function only applies the necessary logic to make the proper
+ * translations. All the sanity checks must have already been done
+ * by calling the check_jmp_64().
+ */
+u8 gen_jmp_64(u8 *buf, u8 rd, u8 rs, u8 cond, u32 curr_off, u32 targ_off)
+{
+	u8 len = 0;
+	bool eq = false;
+	s32 disp;
+
+	switch (cond) {
+	case ARC_CC_AL:
+		disp = get_displacement(curr_off, targ_off);
+		len = arc_b(buf, disp);
+		break;
+	case ARC_CC_UGT:
+	case ARC_CC_UGE:
+	case ARC_CC_ULT:
+	case ARC_CC_ULE:
+	case ARC_CC_SGT:
+	case ARC_CC_SGE:
+	case ARC_CC_SLT:
+	case ARC_CC_SLE:
+		len = gen_jcc_64(buf, rd, rs, cond, curr_off, targ_off);
+		break;
+	case ARC_CC_EQ:
+		eq = true;
+		fallthrough;
+	case ARC_CC_NE:
+		len = gen_j_eq_64(buf, rd, rs, eq, curr_off, targ_off);
+		break;
+	case ARC_CC_SET:
+		len = gen_jset_64(buf, rd, rs, curr_off, targ_off);
+		break;
+	default:
+#ifdef ARC_BPF_JIT_DEBUG
+		pr_err("64-bit jump condition is not known.");
+		BUG();
+#endif
+	}
+	return len;
+}
+
+/*
+ * The condition codes to use when generating JIT instructions
+ * for 32-bit jumps.
+ *
+ * The "ARC_CC_AL" index is not really used by the code, but it
+ * is here for the sake of completeness.
+ *
+ * The "ARC_CC_SET" becomes "CC_unequal" because of the "tst"
+ * instruction that precedes the conditional branch.
+ */
+const u8 arcv2_32_jmps[ARC_CC_LAST] = {
+	[ARC_CC_UGT] = CC_great_u,
+	[ARC_CC_UGE] = CC_great_eq_u,
+	[ARC_CC_ULT] = CC_less_u,
+	[ARC_CC_ULE] = CC_less_eq_u,
+	[ARC_CC_SGT] = CC_great_s,
+	[ARC_CC_SGE] = CC_great_eq_s,
+	[ARC_CC_SLT] = CC_less_s,
+	[ARC_CC_SLE] = CC_less_eq_s,
+	[ARC_CC_AL]  = CC_always,
+	[ARC_CC_EQ]  = CC_equal,
+	[ARC_CC_NE]  = CC_unequal,
+	[ARC_CC_SET] = CC_unequal
+};
+
+/* Can the jump from "curr_off" to "targ_off" actually happen? */
+bool check_jmp_32(u32 curr_off, u32 targ_off, u8 cond)
+{
+	u8 addendum;
+	s32 disp;
+
+	if (cond >= ARC_CC_LAST)
+		return false;
+
+	/*
+	 * The unconditional jump happens immediately, while the rest
+	 * are either preceded by a "cmp" or "tst" instruction.
+	 */
+	addendum = (cond == ARC_CC_AL) ? 0 : INSN_len_normal;
+	disp = get_displacement(curr_off + addendum, targ_off);
+
+	if (ARC_CC_AL)
+		return is_valid_far_disp(disp);
+	else
+		return is_valid_near_disp(disp);
+}
+
+/*
+ * The JITed code for 32-bit (conditional) branches:
+ *
+ * ARC_CC_AL  @target
+ *   b @jit_targ_addr
+ *
+ * ARC_CC_SET rd, rs, @target
+ *   tst rd, rs
+ *   bnz @jit_targ_addr
+ *
+ * ARC_CC_xx  rd, rs, @target
+ *   cmp rd, rs
+ *   b<cc> @jit_targ_addr            # cc = arcv2_32_jmps[xx]
+ */
+u8 gen_jmp_32(u8 *buf, u8 rd, u8 rs, u8 cond, u32 curr_off, u32 targ_off)
+{
+	s32 disp;
+	u8 len = 0;
+
+	/*
+	 * Although this must have already been checked by "check_jmp_32()",
+	 * we're not going to risk accessing "arcv2_32_jmps" array without
+	 * the boundary check.
+	 */
+	if (cond >= ARC_CC_LAST) {
+#ifdef ARC_BPF_JIT_DEBUG
+		pr_err("32-bit jump condition is not known.");
+		BUG();
+#endif
+		return 0;
+	}
+
+	/* If there is a "condition", issue the "cmp" or "tst" first. */
+	if (cond != ARC_CC_AL) {
+		if (cond == ARC_CC_SET)
+			len = tst_r32(buf, rd, rs);
+		else
+			len = cmp_r32(buf, rd, rs);
+		/*
+		 * The issued instruction affects the "disp"lacement as
+		 * it alters the "curr_off" by its "len"gth. The "curr_off"
+		 * should always point to the jump instruction.
+		 */
+		disp = get_displacement(curr_off + len, targ_off);
+		len += arc_bcc(buf+len, arcv2_32_jmps[cond], disp);
+	} else {
+		/* The straight forward unconditional jump. */
+		disp = get_displacement(curr_off, targ_off);
+		len = arc_b(buf, disp);
+	}
+
+	return len;
+}
+
+/*
+ * Generate code for functions calls. There can be two types of calls:
+ *
+ * - Calling another BPF function
+ * - Calling an in-kernel function which is compiled by ARC gcc
+ *
+ * In the later case, we must comply to ARCv2 ABI and handle arguments
+ * and return values accordingly.
+ */
+u8 gen_func_call(u8 *buf, ARC_ADDR func_addr, bool external_func)
+{
+	u8 len = 0;
+
+	/*
+	 * In case of an in-kernel function call, always push the 5th
+	 * argument onto the stack, because that's where the ABI dictates
+	 * it should be found. If the callee doesn't really use it, no harm
+	 * is done. The stack is readjusted either way after the call.
+	 */
+	if (external_func)
+		len += push_r64(buf+len, BPF_REG_5);
+
+	len += jump_and_link(buf+len, func_addr);
+
+	if (external_func)
+		len += arc_add_i(buf+len, ARC_R_SP, ARC_R_SP, ARG5_SIZE);
+
+	return len;
+}
diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
new file mode 100644
index 000000000000..730a715d324e
--- /dev/null
+++ b/arch/arc/net/bpf_jit_core.c
@@ -0,0 +1,1425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The back-end-agnostic part of Just-In-Time compiler for eBPF bytecode.
+ *
+ * Copyright (c) 2024 Synopsys Inc.
+ * Author: Shahab Vahedi <shahab@synopsys.com>
+ */
+#include <asm/bug.h>
+#include "bpf_jit.h"
+
+/* Sane initial values for the globals */
+bool emit = true;
+bool zext_thyself = true;
+
+/*
+ * Check for the return value. A pattern used oftenly in this file.
+ * There must be a "ret" variable of type "int" in the scope.
+ */
+#define CHECK_RET(cmd)			\
+	do {				\
+		ret = (cmd);		\
+		if (ret < 0)		\
+			return ret;	\
+	} while (0)
+
+#ifdef ARC_BPF_JIT_DEBUG
+/* Dumps bytes in /var/log/messages at KERN_INFO level (4). */
+static void dump_bytes(const u8 *buf, u32 len, const char *header)
+{
+	u8 line[64];
+	size_t i, j;
+
+	pr_info("-----------------[ %s ]-----------------\n", header);
+
+	for (i = 0, j = 0; i < len; i++) {
+		/* Last input byte? */
+		if (i == len-1) {
+			j += scnprintf(line+j, 64-j, "0x%02x", buf[i]);
+			pr_info("%s\n", line);
+			break;
+		}
+		/* End of line? */
+		else if (i % 8 == 7) {
+			j += scnprintf(line+j, 64-j, "0x%02x", buf[i]);
+			pr_info("%s\n", line);
+			j = 0;
+		} else {
+			j += scnprintf(line+j, 64-j, "0x%02x, ", buf[i]);
+		}
+	}
+}
+#endif /* ARC_BPF_JIT_DEBUG */
+
+/********************* JIT context ***********************/
+
+/*
+ * buf:		Translated instructions end up here.
+ * len:		The length of whole block in bytes.
+ * index:	The offset at which the _next_ instruction may be put.
+ */
+struct jit_buffer {
+	u8	*buf;
+	u32	len;
+	u32	index;
+};
+
+/*
+ * This is a subset of "struct jit_context" that its information is deemed
+ * necessary for the next extra pass to come.
+ *
+ * bpf_header:	Needed to finally lock the region.
+ * bpf2insn:	Used to find the translation for instructions of interest.
+ *
+ * Things like "jit.buf" and "jit.len" can be retrieved respectively from
+ * "prog->bpf_func" and "prog->jited_len".
+ */
+struct arc_jit_data {
+	struct bpf_binary_header *bpf_header;
+	u32                      *bpf2insn;
+};
+
+/*
+ * The JIT pertinent context that is used by different functions.
+ *
+ * prog:		The current eBPF program being handled.
+ * orig_prog:		The original eBPF program before any possible change.
+ * jit:			The JIT buffer and its length.
+ * bpf_header:		The JITed program header. "jit.buf" points inside it.
+ * bpf2insn:		Maps BPF insn indices to their counterparts in jit.buf.
+ * bpf2insn_valid:	Indicates if "bpf2ins" is populated with the mappings.
+ * jit_data:		A piece of memory to transfer data to the next pass.
+ * arc_regs_clobbered:	Each bit status determines if that arc reg is clobbered.
+ * save_blink:		Whether ARC's "blink" register needs to be saved.
+ * frame_size:		Derived from "prog->aux->stack_depth".
+ * epilogue_offset:	Used by early "return"s in the code to jump here.
+ * need_extra_pass:	A forecast if an "extra_pass" will occur.
+ * is_extra_pass:	Indicates if the current pass is an extra pass.
+ * user_bpf_prog:	True, if VM opcodes come from a real program.
+ * blinded:		True if "constant blinding" step returned a new "prog".
+ * success:		Indicates if the whole JIT went OK.
+ */
+struct jit_context {
+	struct bpf_prog			*prog;
+	struct bpf_prog			*orig_prog;
+	struct jit_buffer		jit;
+	struct bpf_binary_header	*bpf_header;
+	u32				*bpf2insn;
+	bool				bpf2insn_valid;
+	struct arc_jit_data		*jit_data;
+	u32				arc_regs_clobbered;
+	bool				save_blink;
+	u16				frame_size;
+	u32				epilogue_offset;
+	bool				need_extra_pass;
+	bool				is_extra_pass;
+	bool				user_bpf_prog;
+	bool				blinded;
+	bool				success;
+};
+
+/*
+ * If we're in ARC_BPF_JIT_DEBUG mode and the debug level is right, dump the
+ * input BPF stream. "bpf_jit_dump()" is not fully suited for this purpose.
+ */
+static void vm_dump(const struct bpf_prog *prog)
+{
+#ifdef ARC_BPF_JIT_DEBUG
+	if (bpf_jit_enable > 1)
+		dump_bytes((u8 *) prog->insns, 8*prog->len, " VM  ");
+#endif
+}
+
+/*
+ * If the right level of debug is set, dump the bytes. There are 2 variants
+ * of this function:
+ *
+ * 1. Use the standard bpf_jit_dump() which is meant only for JITed code.
+ * 2. Use the dump_bytes() to match its "vm_dump()" instance.
+ */
+static void jit_dump(const struct jit_context *ctx)
+{
+#ifdef ARC_BPF_JIT_DEBUG
+	u8 header[8];
+#endif
+	const int pass = ctx->is_extra_pass ? 2 : 1;
+
+	if (bpf_jit_enable <= 1 || !ctx->prog->jited)
+		return;
+
+#ifdef ARC_BPF_JIT_DEBUG
+	scnprintf(header, sizeof(header), "JIT:%d", pass);
+	dump_bytes(ctx->jit.buf, ctx->jit.len, header);
+	pr_info("\n");
+#else
+	bpf_jit_dump(ctx->prog->len, ctx->jit.len, pass, ctx->jit.buf);
+#endif
+}
+
+/* Initialise the context so there's no garbage. */
+static int jit_ctx_init(struct jit_context *ctx, struct bpf_prog *prog)
+{
+	ctx->orig_prog = prog;
+
+	/* If constant blinding was requested but failed, scram. */
+	ctx->prog = bpf_jit_blind_constants(prog);
+	if (IS_ERR(ctx->prog))
+		return PTR_ERR(ctx->prog);
+	ctx->blinded = (ctx->prog == ctx->orig_prog ? false : true);
+
+	ctx->jit.buf            = NULL;
+	ctx->jit.len            = 0;
+	ctx->jit.index          = 0;
+	ctx->bpf_header         = NULL;
+	ctx->bpf2insn           = NULL;
+	ctx->bpf2insn_valid     = false;
+	ctx->jit_data           = NULL;
+	ctx->arc_regs_clobbered = 0;
+	ctx->save_blink         = false;
+	ctx->frame_size         = 0;
+	ctx->epilogue_offset    = 0;
+	ctx->need_extra_pass    = false;
+	ctx->is_extra_pass	= ctx->prog->jited;
+	ctx->user_bpf_prog	= ctx->prog->is_func;
+	ctx->success            = false;
+
+	/* If the verifier doesn't zero-extend, then we have to do it. */
+	zext_thyself = !ctx->prog->aux->verifier_zext;
+
+	return 0;
+}
+
+/*
+ * Only after the first iteration of normal pass (the dry-run),
+ * there are valid offsets in ctx->bpf2insn array.
+ */
+static inline bool offsets_available(const struct jit_context *ctx)
+{
+	return ctx->bpf2insn_valid;
+}
+
+/*
+ * "*mem" should be freed when there is no "extra pass" to come,
+ * or the compilation terminated abruptly. A few of such memory
+ * allocations are: ctx->jit_data and ctx->bpf2insn.
+ */
+static inline void maybe_free(struct jit_context *ctx, void **mem)
+{
+	if (*mem) {
+		if (!ctx->success || !ctx->need_extra_pass) {
+			kfree(*mem);
+			*mem = NULL;
+		}
+	}
+}
+
+/*
+ * Free memories based on the status of the context.
+ *
+ * A note about "bpf_header": On successful runs, "bpf_header" is
+ * not freed, because "jit.buf", a sub-array of it, is returned as
+ * the "bpf_func". However, "bpf_header" is lost and nothing points
+ * to it. This should not cause a leakage, because apparently
+ * "bpf_header" can be revived by "bpf_jit_binary_hdr()". This is
+ * how "bpf_jit_free()" in "kernel/bpf/core.c" releases the memory.
+ */
+static void jit_ctx_cleanup(struct jit_context *ctx)
+{
+	if (ctx->blinded) {
+		/* if all went well, release the orig_prog. */
+		if (ctx->success)
+			bpf_jit_prog_release_other(ctx->prog, ctx->orig_prog);
+		else
+			bpf_jit_prog_release_other(ctx->orig_prog, ctx->prog);
+	}
+
+	maybe_free(ctx, (void **) &ctx->bpf2insn);
+	maybe_free(ctx, (void **) &ctx->jit_data);
+
+	if (!ctx->bpf2insn)
+		ctx->bpf2insn_valid = false;
+
+	/* Freeing "bpf_header" is enough. "jit.buf" is a sub-array of it. */
+	if (!ctx->success && ctx->bpf_header) {
+		bpf_jit_binary_free(ctx->bpf_header);
+		ctx->bpf_header = NULL;
+		ctx->jit.buf    = NULL;
+		ctx->jit.index  = 0;
+		ctx->jit.len    = 0;
+	}
+
+	/* Global booleans set to false. */
+	emit = false;
+	zext_thyself = false;
+}
+
+/*
+ * Analyse the register usage and record the frame size.
+ * The register usage is determined by consulting the back-end.
+ */
+static void analyze_reg_usage(struct jit_context *ctx)
+{
+	size_t i;
+	u32 usage = 0;
+	const struct bpf_insn *insn = ctx->prog->insnsi;
+
+	for (i = 0; i < ctx->prog->len; i++) {
+		u8 bpf_reg;
+		bool call;
+
+		bpf_reg = insn[i].dst_reg;
+		call = (insn[i].code == (BPF_JMP | BPF_CALL)) ? true : false;
+		usage |= mask_for_used_regs(bpf_reg, call);
+	}
+
+	ctx->arc_regs_clobbered = usage;
+	ctx->frame_size = ctx->prog->aux->stack_depth;
+}
+
+/* Verify that no instruction will be emitted when there is no buffer. */
+static inline int jit_buffer_check(const struct jit_buffer *jbuf)
+{
+	if (emit == true) {
+		if (jbuf->buf == NULL) {
+			pr_err("bpf-jit: inconsistence state; no "
+			       "buffer to emit instructions.\n");
+			return -EINVAL;
+		} else if (jbuf->index > jbuf->len) {
+			pr_err("bpf-jit: estimated JIT length is less "
+			       "than the emitted instructions.\n");
+			return -EFAULT;
+		}
+	}
+	return 0;
+}
+
+/* On a dry-run (emit=false), "jit.len" is growing gradually. */
+static inline void jit_buffer_update(struct jit_buffer *jbuf, u32 n)
+{
+	if (!emit)
+		jbuf->len += n;
+	else
+		jbuf->index += n;
+}
+
+/* Based on "emit", determine the address where instructions are emitted. */
+static inline u8 *effective_jit_buf(const struct jit_buffer *jbuf)
+{
+	return emit ? jbuf->buf + jbuf->index : NULL;
+}
+
+/* Prologue based on context variables set by "analyze_reg_usage()". */
+static int handle_prologue(struct jit_context *ctx)
+{
+	int ret;
+	u8 *buf = effective_jit_buf(&ctx->jit);
+	u32 len = 0;
+
+	CHECK_RET(jit_buffer_check(&ctx->jit));
+
+	len = arc_prologue(buf, ctx->arc_regs_clobbered, ctx->frame_size);
+	jit_buffer_update(&ctx->jit, len);
+
+	return 0;
+}
+
+/* The counter part for "handle_prologue()". */
+static int handle_epilogue(struct jit_context *ctx)
+{
+	int ret;
+	u8 *buf = effective_jit_buf(&ctx->jit);
+	u32 len = 0;
+
+	CHECK_RET(jit_buffer_check(&ctx->jit));
+
+	len = arc_epilogue(buf, ctx->arc_regs_clobbered, ctx->frame_size);
+	jit_buffer_update(&ctx->jit, len);
+
+	return 0;
+}
+
+/* Tell which number of the BPF instruction we are dealing with. */
+static inline s32 get_index_for_insn(const struct jit_context *ctx,
+				     const struct bpf_insn *insn)
+{
+	return (insn - ctx->prog->insnsi);
+}
+
+
+/*
+ * In most of the cases, the "offset" is read from "insn->off". However,
+ * if it is an unconditional BPF_JMP32, then it comes from "insn->imm".
+ *
+ * (Courtesy of "cpu=v4" support)
+ */
+static inline s32 get_offset(const struct bpf_insn *insn)
+{
+	if ((BPF_CLASS(insn->code) == BPF_JMP32) &&
+	    (BPF_OP(insn->code) == BPF_JA))
+		return insn->imm;
+	else
+		return insn->off;
+}
+
+/*
+ * Determine to which number of the BPF instruction we're jumping to.
+ *
+ * The "offset" is interpreted as the "number" of BPF instructions
+ * from the _next_ BPF instruction. e.g.:
+ *
+ *  4 means 4 instructions after  the next insn
+ *  0 means 0 instructions after  the next insn -> fallthrough.
+ * -1 means 1 instruction  before the next insn -> jmp to current insn.
+ *
+ *  Another way to look at this, "offset" is the number of instructions
+ *  that exist between the current instruction and the target instruction.
+ *
+ *  It is worth noting that a "mov r,i64", which is 16-byte long, is
+ *  treated as two instructions long, therefore "offset" needn't be
+ *  treated specially for those. Everything is uniform.
+ */
+static inline s32 get_target_index_for_insn(const struct jit_context *ctx,
+					    const struct bpf_insn *insn)
+{
+	return (get_index_for_insn(ctx, insn) + 1) + get_offset(insn);
+}
+
+/* Is there an immediate operand encoded in the "insn"? */
+static inline bool has_imm(const struct bpf_insn *insn)
+{
+	return BPF_SRC(insn->code) == BPF_K;
+}
+
+/* Is the last BPF instruction? */
+static inline bool is_last_insn(const struct bpf_prog *prog, u32 idx)
+{
+	return idx == (prog->len - 1);
+}
+
+/*
+ * Invocation of this function, conditionally signals the need for
+ * an extra pass. The conditions that must be met are:
+ *
+ * 1. The current pass itself shouldn't be an extra pass.
+ * 2. The stream of bytes being JITed must come from a user program.
+ */
+static inline void set_need_for_extra_pass(struct jit_context *ctx)
+{
+	if (!ctx->is_extra_pass)
+		ctx->need_extra_pass = ctx->user_bpf_prog;
+}
+
+/*
+ * Check if the "size" is valid and then transfer the control to
+ * the back-end for the swap.
+ */
+static int handle_swap(u8 *buf, u8 rd, u8 size, u8 endian,
+		       bool force, u8 *len)
+{
+	/* Sanity check on the size. */
+	switch (size) {
+	case 16:
+	case 32:
+	case 64:
+		break;
+	default:
+		pr_err("bpf-jit: invalid size for swap.\n");
+		return -EINVAL;
+	}
+
+	*len = gen_swap(buf, rd, size, endian, force);
+
+	return 0;
+}
+
+/* Checks if the (instruction) index is in valid range. */
+static inline bool check_insn_idx_valid(const struct jit_context *ctx,
+					const s32 idx)
+{
+	return (idx >= 0 && idx < ctx->prog->len);
+}
+
+/*
+ * Decouple the back-end from BPF by converting BPF conditions
+ * to internal enum. ARC_CC_* start from 0 and are used as index
+ * to an array. BPF_J* usage must end after this conversion.
+ */
+static int bpf_cond_to_arc(const u8 op, u8 *arc_cc)
+{
+	switch (op) {
+	case BPF_JA:
+		*arc_cc = ARC_CC_AL;
+		break;
+	case BPF_JEQ:
+		*arc_cc = ARC_CC_EQ;
+		break;
+	case BPF_JGT:
+		*arc_cc = ARC_CC_UGT;
+		break;
+	case BPF_JGE:
+		*arc_cc = ARC_CC_UGE;
+		break;
+	case BPF_JSET:
+		*arc_cc = ARC_CC_SET;
+		break;
+	case BPF_JNE:
+		*arc_cc = ARC_CC_NE;
+		break;
+	case BPF_JSGT:
+		*arc_cc = ARC_CC_SGT;
+		break;
+	case BPF_JSGE:
+		*arc_cc = ARC_CC_SGE;
+		break;
+	case BPF_JLT:
+		*arc_cc = ARC_CC_ULT;
+		break;
+	case BPF_JLE:
+		*arc_cc = ARC_CC_ULE;
+		break;
+	case BPF_JSLT:
+		*arc_cc = ARC_CC_SLT;
+		break;
+	case BPF_JSLE:
+		*arc_cc = ARC_CC_SLE;
+		break;
+	default:
+		pr_err("bpf-jit: can't handle condition 0x%02X\n", op);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * Check a few things for a supposedly "jump" instruction:
+ *
+ * 0. "insn" is a "jump" instruction, but not the "call/exit" variant.
+ * 1. The current "insn" index is in valid range.
+ * 2. The index of target instruction is in valid range.
+ */
+static int check_bpf_jump(const struct jit_context *ctx,
+			  const struct bpf_insn *insn)
+{
+	const u8 class = BPF_CLASS(insn->code);
+	const u8 op = BPF_OP(insn->code);
+
+	/* Must be a jmp(32) instruction that is not a "call/exit". */
+	if ((class != BPF_JMP && class != BPF_JMP32) ||
+	    (op == BPF_CALL || op == BPF_EXIT)) {
+		pr_err("bpf-jit: not a jump instruction.\n");
+		return -EINVAL;
+	}
+
+	if (!check_insn_idx_valid(ctx, get_index_for_insn(ctx, insn))) {
+		pr_err("bpf-jit: the bpf jump insn is not in prog.\n");
+		return -EINVAL;
+	}
+
+	if (!check_insn_idx_valid(ctx, get_target_index_for_insn(ctx, insn))) {
+		pr_err("bpf-jit: bpf jump label is out of range.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Based on input "insn", consult "ctx->bpf2insn" to get the
+ * related index (offset) of the translation in JIT stream.
+ */
+static u32 get_curr_jit_off(const struct jit_context *ctx,
+			    const struct bpf_insn *insn)
+{
+	const s32 idx = get_index_for_insn(ctx, insn);
+#ifdef ARC_BPF_JIT_DEBUG
+	BUG_ON(!offsets_available(ctx) || !check_insn_idx_valid(ctx, idx));
+#endif
+	return ctx->bpf2insn[idx];
+}
+
+/*
+ * The input "insn" must be a jump instruction.
+ *
+ * Based on input "insn", consult "ctx->bpf2insn" to get the
+ * related JIT index (offset) of "target instruction" that
+ * "insn" would jump to.
+ */
+static u32 get_targ_jit_off(const struct jit_context *ctx,
+			    const struct bpf_insn *insn)
+{
+	const s32 tidx = get_target_index_for_insn(ctx, insn);
+#ifdef ARC_BPF_JIT_DEBUG
+	BUG_ON(!offsets_available(ctx) || !check_insn_idx_valid(ctx, tidx));
+#endif
+	return ctx->bpf2insn[tidx];
+}
+
+/*
+ * This function will return 0 for a feasible jump.
+ *
+ * Consult the back-end to check if it finds it feasible to emit
+ * the necessary instructions based on "cond" and the displacement
+ * between the "from_off" and the "to_off".
+ */
+static int feasible_jit_jump(u32 from_off, u32 to_off, u8 cond, bool j32)
+{
+	int ret = 0;
+
+	if (j32) {
+		if (!check_jmp_32(from_off, to_off, cond))
+			ret = -EFAULT;
+	} else {
+		if (!check_jmp_64(from_off, to_off, cond))
+			ret = -EFAULT;
+	}
+
+	if (ret != 0)
+		pr_err("bpf-jit: the JIT displacement is not OK.\n");
+
+	return ret;
+}
+
+/*
+ * This jump handler performs the following steps:
+ *
+ * 1. Compute ARC's internal condition code from BPF's
+ * 2. Determine the bitness of the operation (32 vs. 64)
+ * 3. Sanity check on BPF stream
+ * 4. Sanity check on what is supposed to be JIT's displacement
+ * 5. And finally, emit the necessary instructions
+ *
+ * The last two steps are performed through the back-end.
+ * The value of steps 1 and 2 are necessary inputs for the back-end.
+ */
+static int handle_jumps(const struct jit_context *ctx,
+			const struct bpf_insn *insn,
+			u8 *len)
+{
+	u8 cond;
+	int ret = 0;
+	u8 *buf = effective_jit_buf(&ctx->jit);
+	const bool j32 = (BPF_CLASS(insn->code) == BPF_JMP32) ? true : false;
+	const u8 rd = insn->dst_reg;
+	u8 rs = insn->src_reg;
+	u32 curr_off = 0, targ_off = 0;
+
+	*len = 0;
+
+	/* Map the BPF condition to internal enum. */
+	CHECK_RET(bpf_cond_to_arc(BPF_OP(insn->code), &cond));
+
+	/* Sanity check on the BPF byte stream. */
+	CHECK_RET(check_bpf_jump(ctx, insn));
+
+	/*
+	 * Move the immediate into a temporary register _now_ for 2 reasons:
+	 *
+	 * 1. "gen_jmp_{32,64}()" deal with operands in registers.
+	 *
+	 * 2. The "len" parameter will grow so that the current jit offset
+	 *    (curr_off) will have increased to a point where the necessary
+	 *    instructions can be inserted by "gen_jmp_{32,64}()".
+	 */
+	if (has_imm(insn) && (cond != ARC_CC_AL)) {
+		if (j32) {
+			*len += mov_r32_i32(buf + *len, JIT_REG_TMP,
+					    insn->imm);
+		} else {
+			*len += mov_r64_i32(buf + *len, JIT_REG_TMP,
+					    insn->imm);
+		}
+		rs = JIT_REG_TMP;
+	}
+
+	/* If the offsets are known, check if the branch can occur. */
+	if (offsets_available(ctx)) {
+		curr_off = get_curr_jit_off(ctx, insn) + *len;
+		targ_off = get_targ_jit_off(ctx, insn);
+
+		/* Sanity check on the back-end side. */
+		CHECK_RET(feasible_jit_jump(curr_off, targ_off, cond, j32));
+	}
+
+	if (j32) {
+		*len += gen_jmp_32(buf + *len, rd, rs, cond,
+				   curr_off, targ_off);
+	} else {
+		*len += gen_jmp_64(buf + *len, rd, rs, cond,
+				   curr_off, targ_off);
+	}
+
+	return ret;
+}
+
+/* Jump to translated epilogue address. */
+static int handle_jmp_epilogue(struct jit_context *ctx,
+			       const struct bpf_insn *insn, u8 *len)
+{
+	u8 *buf = effective_jit_buf(&ctx->jit);
+	u32 curr_off = 0, epi_off = 0;
+
+	/* Check the offset only if the data is available. */
+	if (offsets_available(ctx)) {
+		curr_off = get_curr_jit_off(ctx, insn);
+		epi_off = ctx->epilogue_offset;
+
+		if (!check_jmp_64(curr_off, epi_off, ARC_CC_AL)) {
+			pr_err("bpf-jit: epilogue offset is not valid.\n");
+			return -EINVAL;
+		}
+	}
+
+	/* Jump to "epilogue offset" (rd and rs don't matter). */
+	*len = gen_jmp_64(buf, 0, 0, ARC_CC_AL, curr_off, epi_off);
+
+	return 0;
+}
+
+/* Try to get the resolved address and generate the instructions. */
+static int handle_call(struct jit_context *ctx,
+		       const struct bpf_insn *insn,
+		       u8 *len)
+{
+	int  ret;
+	bool in_kernel_func, fixed = false;
+	u64  addr = 0;
+	u8  *buf = effective_jit_buf(&ctx->jit);
+
+	ret = bpf_jit_get_func_addr(ctx->prog, insn, ctx->is_extra_pass,
+				    &addr, &fixed);
+	if (ret < 0) {
+		pr_err("bpf-jit: can't get the address for call.\n");
+		return ret;
+	}
+	in_kernel_func = (fixed ? true : false);
+
+	/* No valuable address retrieved (yet). */
+	if (!fixed && !addr)
+		set_need_for_extra_pass(ctx);
+
+	*len = gen_func_call(buf, (ARC_ADDR) addr, in_kernel_func);
+
+	if (insn->src_reg != BPF_PSEUDO_CALL) {
+		/* Assigning ABI's return reg to JIT's return reg. */
+		*len += arc_to_bpf_return(buf + *len);
+	}
+
+	return 0;
+}
+
+/*
+ * Try to generate instructions for loading a 64-bit immediate.
+ * These sort of instructions are usually associated with the 64-bit
+ * relocations: R_BPF_64_64. Therefore, signal the need for an extra
+ * pass if the circumstances are right.
+ */
+static int handle_ld_imm64(struct jit_context *ctx,
+			   const struct bpf_insn *insn,
+			   u8 *len)
+{
+	const s32 idx = get_index_for_insn(ctx, insn);
+	u8 *buf = effective_jit_buf(&ctx->jit);
+
+	/* We're about to consume 2 VM instructions. */
+	if (is_last_insn(ctx->prog, idx)) {
+		pr_err("bpf-jit: need more data for 64-bit immediate.\n");
+		return -EINVAL;
+	}
+
+	*len = mov_r64_i64(buf, insn->dst_reg, insn->imm, (insn+1)->imm);
+
+	if (bpf_pseudo_func(insn))
+		set_need_for_extra_pass(ctx);
+
+	return 0;
+}
+
+/*
+ * Handles one eBPF instruction at a time. To make this function faster,
+ * it does not call "jit_buffer_check()". Else, it would call it for every
+ * instruction. As a result, it should not be invoked directly. Only
+ * "handle_body()", that has already executed the "check", may call this
+ * function.
+ *
+ * If the "ret" value is negative, something has went wrong. Else,
+ * it mostly holds the value 0 and rarely 1. Number 1 signals
+ * the loop in "handle_body()" to skip the next instruction, because
+ * it has been consumed as part of a 64-bit immediate value.
+ */
+static int handle_insn(struct jit_context *ctx, u32 idx)
+{
+	const struct bpf_insn *insn = &ctx->prog->insnsi[idx];
+	const u8  code = insn->code;
+	const u8  dst  = insn->dst_reg;
+	const u8  src  = insn->src_reg;
+	const s16 off  = insn->off;
+	const s32 imm  = insn->imm;
+	u8 *buf = effective_jit_buf(&ctx->jit);
+	u8  len = 0;
+	int ret = 0;
+
+	switch (code) {
+	/* dst += src (32-bit) */
+	case BPF_ALU | BPF_ADD | BPF_X:
+		len = add_r32(buf, dst, src);
+		break;
+	/* dst += imm (32-bit) */
+	case BPF_ALU | BPF_ADD | BPF_K:
+		len = add_r32_i32(buf, dst, imm);
+		break;
+	/* dst -= src (32-bit) */
+	case BPF_ALU | BPF_SUB | BPF_X:
+		len = sub_r32(buf, dst, src);
+		break;
+	/* dst -= imm (32-bit) */
+	case BPF_ALU | BPF_SUB | BPF_K:
+		len = sub_r32_i32(buf, dst, imm);
+		break;
+	/* dst = -dst (32-bit) */
+	case BPF_ALU | BPF_NEG:
+		len = neg_r32(buf, dst);
+		break;
+	/* dst *= src (32-bit) */
+	case BPF_ALU | BPF_MUL | BPF_X:
+		len = mul_r32(buf, dst, src);
+		break;
+	/* dst *= imm (32-bit) */
+	case BPF_ALU | BPF_MUL | BPF_K:
+		len = mul_r32_i32(buf, dst, imm);
+		break;
+	/* dst /= src (32-bit) */
+	case BPF_ALU | BPF_DIV | BPF_X:
+		len = div_r32(buf, dst, src, off == 1);
+		break;
+	/* dst /= imm (32-bit) */
+	case BPF_ALU | BPF_DIV | BPF_K:
+		len = div_r32_i32(buf, dst, imm, off == 1);
+		break;
+	/* dst %= src (32-bit) */
+	case BPF_ALU | BPF_MOD | BPF_X:
+		len = mod_r32(buf, dst, src, off == 1);
+		break;
+	/* dst %= imm (32-bit) */
+	case BPF_ALU | BPF_MOD | BPF_K:
+		len = mod_r32_i32(buf, dst, imm, off == 1);
+		break;
+	/* dst &= src (32-bit) */
+	case BPF_ALU | BPF_AND | BPF_X:
+		len = and_r32(buf, dst, src);
+		break;
+	/* dst &= imm (32-bit) */
+	case BPF_ALU | BPF_AND | BPF_K:
+		len = and_r32_i32(buf, dst, imm);
+		break;
+	/* dst |= src (32-bit) */
+	case BPF_ALU | BPF_OR | BPF_X:
+		len = or_r32(buf, dst, src);
+		break;
+	/* dst |= imm (32-bit) */
+	case BPF_ALU | BPF_OR | BPF_K:
+		len = or_r32_i32(buf, dst, imm);
+		break;
+	/* dst ^= src (32-bit) */
+	case BPF_ALU | BPF_XOR | BPF_X:
+		len = xor_r32(buf, dst, src);
+		break;
+	/* dst ^= imm (32-bit) */
+	case BPF_ALU | BPF_XOR | BPF_K:
+		len = xor_r32_i32(buf, dst, imm);
+		break;
+	/* dst <<= src (32-bit) */
+	case BPF_ALU | BPF_LSH | BPF_X:
+		len = lsh_r32(buf, dst, src);
+		break;
+	/* dst <<= imm (32-bit) */
+	case BPF_ALU | BPF_LSH | BPF_K:
+		len = lsh_r32_i32(buf, dst, imm);
+		break;
+	/* dst >>= src (32-bit) [unsigned] */
+	case BPF_ALU | BPF_RSH | BPF_X:
+		len = rsh_r32(buf, dst, src);
+		break;
+	/* dst >>= imm (32-bit) [unsigned] */
+	case BPF_ALU | BPF_RSH | BPF_K:
+		len = rsh_r32_i32(buf, dst, imm);
+		break;
+	/* dst >>= src (32-bit) [signed] */
+	case BPF_ALU | BPF_ARSH | BPF_X:
+		len = arsh_r32(buf, dst, src);
+		break;
+	/* dst >>= imm (32-bit) [signed] */
+	case BPF_ALU | BPF_ARSH | BPF_K:
+		len = arsh_r32_i32(buf, dst, imm);
+		break;
+	/* dst = src (32-bit) */
+	case BPF_ALU | BPF_MOV | BPF_X:
+		len = mov_r32(buf, dst, src, (u8) off);
+		break;
+	/* dst = imm32 (32-bit) */
+	case BPF_ALU | BPF_MOV | BPF_K:
+		len = mov_r32_i32(buf, dst, imm);
+		break;
+	/* dst = swap(dst) */
+	case BPF_ALU   | BPF_END | BPF_FROM_LE:
+	case BPF_ALU   | BPF_END | BPF_FROM_BE:
+	case BPF_ALU64 | BPF_END | BPF_FROM_LE: {
+		CHECK_RET(handle_swap(buf, dst, imm, BPF_SRC(code),
+				      BPF_CLASS(code) == BPF_ALU64,
+				      &len));
+		break;
+	}
+	/* dst += src (64-bit) */
+	case BPF_ALU64 | BPF_ADD | BPF_X:
+		len = add_r64(buf, dst, src);
+		break;
+	/* dst += imm32 (64-bit) */
+	case BPF_ALU64 | BPF_ADD | BPF_K:
+		len = add_r64_i32(buf, dst, imm);
+		break;
+	/* dst -= src (64-bit) */
+	case BPF_ALU64 | BPF_SUB | BPF_X:
+		len = sub_r64(buf, dst, src);
+		break;
+	/* dst -= imm32 (64-bit) */
+	case BPF_ALU64 | BPF_SUB | BPF_K:
+		len = sub_r64_i32(buf, dst, imm);
+		break;
+	/* dst = -dst (64-bit) */
+	case BPF_ALU64 | BPF_NEG:
+		len = neg_r64(buf, dst);
+		break;
+	/* dst *= src (64-bit) */
+	case BPF_ALU64 | BPF_MUL | BPF_X:
+		len = mul_r64(buf, dst, src);
+		break;
+	/* dst *= imm32 (64-bit) */
+	case BPF_ALU64 | BPF_MUL | BPF_K:
+		len = mul_r64_i32(buf, dst, imm);
+		break;
+	/* dst &= src (64-bit) */
+	case BPF_ALU64 | BPF_AND | BPF_X:
+		len = and_r64(buf, dst, src);
+		break;
+	/* dst &= imm32 (64-bit) */
+	case BPF_ALU64 | BPF_AND | BPF_K:
+		len = and_r64_i32(buf, dst, imm);
+		break;
+	/* dst |= src (64-bit) */
+	case BPF_ALU64 | BPF_OR | BPF_X:
+		len = or_r64(buf, dst, src);
+		break;
+	/* dst |= imm32 (64-bit) */
+	case BPF_ALU64 | BPF_OR | BPF_K:
+		len = or_r64_i32(buf, dst, imm);
+		break;
+	/* dst ^= src (64-bit) */
+	case BPF_ALU64 | BPF_XOR | BPF_X:
+		len = xor_r64(buf, dst, src);
+		break;
+	/* dst ^= imm32 (64-bit) */
+	case BPF_ALU64 | BPF_XOR | BPF_K:
+		len = xor_r64_i32(buf, dst, imm);
+		break;
+	/* dst <<= src (64-bit) */
+	case BPF_ALU64 | BPF_LSH | BPF_X:
+		len = lsh_r64(buf, dst, src);
+		break;
+	/* dst <<= imm32 (64-bit) */
+	case BPF_ALU64 | BPF_LSH | BPF_K:
+		len = lsh_r64_i32(buf, dst, imm);
+		break;
+	/* dst >>= src (64-bit) [unsigned] */
+	case BPF_ALU64 | BPF_RSH | BPF_X:
+		len = rsh_r64(buf, dst, src);
+		break;
+	/* dst >>= imm32 (64-bit) [unsigned] */
+	case BPF_ALU64 | BPF_RSH | BPF_K:
+		len = rsh_r64_i32(buf, dst, imm);
+		break;
+	/* dst >>= src (64-bit) [signed] */
+	case BPF_ALU64 | BPF_ARSH | BPF_X:
+		len = arsh_r64(buf, dst, src);
+		break;
+	/* dst >>= imm32 (64-bit) [signed] */
+	case BPF_ALU64 | BPF_ARSH | BPF_K:
+		len = arsh_r64_i32(buf, dst, imm);
+		break;
+	/* dst = src (64-bit) */
+	case BPF_ALU64 | BPF_MOV | BPF_X:
+		len = mov_r64(buf, dst, src, (u8) off);
+		break;
+	/* dst = imm32 (sign extend to 64-bit) */
+	case BPF_ALU64 | BPF_MOV | BPF_K:
+		len = mov_r64_i32(buf, dst, imm);
+		break;
+	/* dst = imm64 */
+	case BPF_LD | BPF_DW | BPF_IMM:
+		CHECK_RET(handle_ld_imm64(ctx, insn, &len));
+		/* Tell the loop to skip the next instruction. */
+		ret = 1;
+		break;
+	/* dst = *(size *)(src + off) */
+	case BPF_LDX | BPF_MEM | BPF_W:
+	case BPF_LDX | BPF_MEM | BPF_H:
+	case BPF_LDX | BPF_MEM | BPF_B:
+	case BPF_LDX | BPF_MEM | BPF_DW:
+		len = load_r(buf, dst, src, off, BPF_SIZE(code), false);
+		break;
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+		len = load_r(buf, dst, src, off, BPF_SIZE(code), true);
+		break;
+	/* *(size *)(dst + off) = src */
+	case BPF_STX | BPF_MEM | BPF_W:
+	case BPF_STX | BPF_MEM | BPF_H:
+	case BPF_STX | BPF_MEM | BPF_B:
+	case BPF_STX | BPF_MEM | BPF_DW:
+		len = store_r(buf, src, dst, off, BPF_SIZE(code));
+		break;
+	case BPF_ST | BPF_MEM | BPF_W:
+	case BPF_ST | BPF_MEM | BPF_H:
+	case BPF_ST | BPF_MEM | BPF_B:
+	case BPF_ST | BPF_MEM | BPF_DW:
+		len = store_i(buf, imm, dst, off, BPF_SIZE(code));
+		break;
+	case BPF_JMP   | BPF_JA:
+	case BPF_JMP   | BPF_JEQ  | BPF_X:
+	case BPF_JMP   | BPF_JEQ  | BPF_K:
+	case BPF_JMP   | BPF_JNE  | BPF_X:
+	case BPF_JMP   | BPF_JNE  | BPF_K:
+	case BPF_JMP   | BPF_JSET | BPF_X:
+	case BPF_JMP   | BPF_JSET | BPF_K:
+	case BPF_JMP   | BPF_JGT  | BPF_X:
+	case BPF_JMP   | BPF_JGT  | BPF_K:
+	case BPF_JMP   | BPF_JGE  | BPF_X:
+	case BPF_JMP   | BPF_JGE  | BPF_K:
+	case BPF_JMP   | BPF_JSGT | BPF_X:
+	case BPF_JMP   | BPF_JSGT | BPF_K:
+	case BPF_JMP   | BPF_JSGE | BPF_X:
+	case BPF_JMP   | BPF_JSGE | BPF_K:
+	case BPF_JMP   | BPF_JLT  | BPF_X:
+	case BPF_JMP   | BPF_JLT  | BPF_K:
+	case BPF_JMP   | BPF_JLE  | BPF_X:
+	case BPF_JMP   | BPF_JLE  | BPF_K:
+	case BPF_JMP   | BPF_JSLT | BPF_X:
+	case BPF_JMP   | BPF_JSLT | BPF_K:
+	case BPF_JMP   | BPF_JSLE | BPF_X:
+	case BPF_JMP   | BPF_JSLE | BPF_K:
+	case BPF_JMP32 | BPF_JA:
+	case BPF_JMP32 | BPF_JEQ  | BPF_X:
+	case BPF_JMP32 | BPF_JEQ  | BPF_K:
+	case BPF_JMP32 | BPF_JNE  | BPF_X:
+	case BPF_JMP32 | BPF_JNE  | BPF_K:
+	case BPF_JMP32 | BPF_JSET | BPF_X:
+	case BPF_JMP32 | BPF_JSET | BPF_K:
+	case BPF_JMP32 | BPF_JGT  | BPF_X:
+	case BPF_JMP32 | BPF_JGT  | BPF_K:
+	case BPF_JMP32 | BPF_JGE  | BPF_X:
+	case BPF_JMP32 | BPF_JGE  | BPF_K:
+	case BPF_JMP32 | BPF_JSGT | BPF_X:
+	case BPF_JMP32 | BPF_JSGT | BPF_K:
+	case BPF_JMP32 | BPF_JSGE | BPF_X:
+	case BPF_JMP32 | BPF_JSGE | BPF_K:
+	case BPF_JMP32 | BPF_JLT  | BPF_X:
+	case BPF_JMP32 | BPF_JLT  | BPF_K:
+	case BPF_JMP32 | BPF_JLE  | BPF_X:
+	case BPF_JMP32 | BPF_JLE  | BPF_K:
+	case BPF_JMP32 | BPF_JSLT | BPF_X:
+	case BPF_JMP32 | BPF_JSLT | BPF_K:
+	case BPF_JMP32 | BPF_JSLE | BPF_X:
+	case BPF_JMP32 | BPF_JSLE | BPF_K:
+		CHECK_RET(handle_jumps(ctx, insn, &len));
+		break;
+	case BPF_JMP | BPF_CALL:
+		CHECK_RET(handle_call(ctx, insn, &len));
+		break;
+
+	case BPF_JMP | BPF_EXIT:
+		/* If this is the last instruction, epilogue will follow. */
+		if (is_last_insn(ctx->prog, idx))
+			break;
+		CHECK_RET(handle_jmp_epilogue(ctx, insn, &len));
+		break;
+	default:
+		pr_err("bpf-jit: can't handle instruction code 0x%02X\n", code);
+		return -EOPNOTSUPP;
+	}
+
+	if (BPF_CLASS(code) == BPF_ALU) {
+		/*
+		 * Even 64-bit swaps are of type BPF_ALU (and not BPF_ALU64).
+		 * Therefore, the routine responsible for "swap" specifically
+		 * takes care of calling "zext()" based on the input "size".
+		 */
+		if (BPF_OP(code) != BPF_END)
+			len += zext(buf+len, dst);
+	}
+
+	jit_buffer_update(&ctx->jit, len);
+
+	return ret;
+}
+
+static int handle_body(struct jit_context *ctx)
+{
+	int ret;
+	bool populate_bpf2insn = false;
+	const struct bpf_prog *prog = ctx->prog;
+
+	CHECK_RET(jit_buffer_check(&ctx->jit));
+
+	/*
+	 * Record the mapping for the instructions during the dry-run.
+	 * Doing it this way allows us to have the mapping ready for
+	 * the jump instructions during the real compilation phase.
+	 */
+	if (!emit)
+		populate_bpf2insn = true;
+
+	for (u32 i = 0; i < prog->len; i++) {
+		/* During the dry-run, jit.len grows gradually per BPF insn. */
+		if (populate_bpf2insn)
+			ctx->bpf2insn[i] = ctx->jit.len;
+
+		CHECK_RET(handle_insn(ctx, i));
+		if (ret > 0) {
+			/* "ret" is 1 if two (64-bit) chunks were consumed. */
+			ctx->bpf2insn[i+1] = ctx->bpf2insn[i];
+			i++;
+		}
+	}
+
+	/* If bpf2insn had to be populated, then it is done at this point. */
+	if (populate_bpf2insn)
+		ctx->bpf2insn_valid = true;
+
+	return 0;
+}
+
+/*
+ * Initialize the memory with "unimp_s" which is the mnemonic for
+ * "unimplemented" instruction and always raises an exception.
+ *
+ * The instruction is 2 bytes. If "size" is odd, there is not much
+ * that can be done about the last byte in "area". Because, the
+ * CPU always fetches instructions in two bytes. Therefore, the
+ * byte beyond the last one is going to accompany it during a
+ * possible fetch. In the most likely case of a little endian
+ * system, that beyond-byte will become the major opcode and
+ * we have no control over its initialisation.
+ */
+static void fill_ill_insn(void *area, unsigned int size)
+{
+	const u16 unimp_s = 0x79e0;
+
+	if (size & 1) {
+		*((u8 *) area + (size - 1)) = 0xff;
+		size -= 1;
+	}
+
+	memset16(area, unimp_s, size >> 1);
+}
+
+/* Piece of memory that can be allocated at the beginning of jit_prepare(). */
+static int jit_prepare_early_mem_alloc(struct jit_context *ctx)
+{
+	ctx->bpf2insn = kcalloc(ctx->prog->len, sizeof(ctx->jit.len),
+				GFP_KERNEL);
+
+	if (!ctx->bpf2insn) {
+		pr_err("bpf-jit: could not allocate memory for "
+		       "mapping of the instructions.\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * Memory allocations that rely on parameters known at the end of
+ * jit_prepare().
+ */
+static int jit_prepare_final_mem_alloc(struct jit_context *ctx)
+{
+	const size_t alignment = sizeof(u32);
+
+	ctx->bpf_header = bpf_jit_binary_alloc(ctx->jit.len, &ctx->jit.buf,
+					       alignment, fill_ill_insn);
+	if (!ctx->bpf_header) {
+		pr_err("bpf-jit: could not allocate memory for translation.\n");
+		return -ENOMEM;
+	}
+
+	if (ctx->need_extra_pass) {
+		ctx->jit_data = kzalloc(sizeof(struct arc_jit_data),
+					GFP_KERNEL);
+		if (!ctx->jit_data)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * The first phase of the translation without actually emitting any
+ * instruction. It helps in getting a forecast on some aspects, such
+ * as the length of the whole program or where the epilogue starts.
+ *
+ * Whenever the necessary parameters are known, memories are allocated.
+ */
+static int jit_prepare(struct jit_context *ctx)
+{
+	int ret;
+
+	/* Dry run. */
+	emit = false;
+
+	CHECK_RET(jit_prepare_early_mem_alloc(ctx));
+
+	/* Get the length of prologue section after some register analysis. */
+	analyze_reg_usage(ctx);
+	CHECK_RET(handle_prologue(ctx));
+
+	CHECK_RET(handle_body(ctx));
+
+	/* Record at which offset epilogue begins. */
+	ctx->epilogue_offset = ctx->jit.len;
+
+	/* Process the epilogue section now. */
+	CHECK_RET(handle_epilogue(ctx));
+
+	CHECK_RET(jit_prepare_final_mem_alloc(ctx));
+
+	return 0;
+}
+
+/*
+ * All the "handle_*()" functions have been called before by the
+ * "jit_prepare()". If there was an error, we would know by now.
+ * Therefore, no extra error checking at this point, other than
+ * a sanity check at the end that expects the calculated length
+ * (jit.len) to be equal to the length of generated instructions
+ * (jit.index).
+ */
+static int jit_compile(struct jit_context *ctx)
+{
+	int ret;
+
+	/* Let there be code. */
+	emit = true;
+
+	CHECK_RET(handle_prologue(ctx));
+
+	CHECK_RET(handle_body(ctx));
+
+	CHECK_RET(handle_epilogue(ctx));
+
+	if (ctx->jit.index != ctx->jit.len) {
+		pr_err("bpf-jit: divergence between the phases; "
+		       "%u vs. %u (bytes).\n",
+		       ctx->jit.len, ctx->jit.index);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+/*
+ * Calling this function implies a successful JIT. A successful
+ * translation is signaled by setting the right parameters:
+ *
+ * prog->jited=1, prog->jited_len=..., prog->bpf_func=...
+ */
+static void jit_finalize(struct jit_context *ctx)
+{
+	struct bpf_prog *prog = ctx->prog;
+
+	ctx->success    = true;
+	prog->bpf_func  = (void *) ctx->jit.buf;
+	prog->jited_len = ctx->jit.len;
+	prog->jited     = 1;
+
+	/* We're going to need this information for the "do_extra_pass()". */
+	if (ctx->need_extra_pass) {
+		ctx->jit_data->bpf_header = ctx->bpf_header;
+		ctx->jit_data->bpf2insn   = ctx->bpf2insn;
+		prog->aux->jit_data       = (void *) ctx->jit_data;
+	} else {
+		/*
+		 * If things seem finalised, then mark the JITed memory
+		 * as R-X and flush it.
+		 */
+		bpf_jit_binary_lock_ro(ctx->bpf_header);
+		flush_icache_range((unsigned long) ctx->bpf_header,
+				   (unsigned long) ctx->jit.buf + ctx->jit.len);
+		prog->aux->jit_data = NULL;
+		bpf_prog_fill_jited_linfo(prog, ctx->bpf2insn);
+	}
+
+	jit_ctx_cleanup(ctx);
+	jit_dump(ctx);
+}
+
+/*
+ * A lenient verification for the existence of JIT context in "prog".
+ * Apparently the JIT internals, namely jit_subprogs() in bpf/verifier.c,
+ * may request for a second compilation although nothing needs to be done.
+ */
+static inline int check_jit_context(const struct bpf_prog *prog)
+{
+	if (prog->aux->jit_data == NULL) {
+		pr_notice("bpf-jit: no jit data for the extra pass.\n");
+		return 1;
+	} else
+		return 0;
+}
+
+/* Reuse the previous pass's data. */
+static int jit_resume_context(struct jit_context *ctx)
+{
+	struct arc_jit_data *jdata =
+		(struct arc_jit_data *) ctx->prog->aux->jit_data;
+
+	if (!jdata) {
+		pr_err("bpf-jit: no jit data for the extra pass.\n");
+		return -EINVAL;
+	}
+
+	ctx->jit.buf        = (u8 *) ctx->prog->bpf_func;
+	ctx->jit.len        = ctx->prog->jited_len;
+	ctx->bpf_header     = jdata->bpf_header;
+	ctx->bpf2insn       = (u32 *) jdata->bpf2insn;
+	ctx->bpf2insn_valid = ctx->bpf2insn ? true : false;
+	ctx->jit_data       = jdata;
+
+	return 0;
+}
+
+/*
+ * Patch in the new addresses. The instructions of interest are:
+ *
+ * - call
+ * - ld r64, imm64
+ *
+ * For "call"s, it resolves the addresses one more time through the
+ * handle_call().
+ *
+ * For 64-bit immediate loads, it just retranslates them, because the BPF
+ * core in kernel might have changed the value since the normal pass.
+ */
+static int jit_patch_relocations(struct jit_context *ctx)
+{
+	const u8 bpf_opc_call = BPF_JMP | BPF_CALL;
+	const u8 bpf_opc_ldi64 = BPF_LD | BPF_DW | BPF_IMM;
+	const struct bpf_prog *prog = ctx->prog;
+	int ret;
+
+	emit = true;
+	for (u32 i = 0; i < prog->len; i++) {
+		const struct bpf_insn *insn = &prog->insnsi[i];
+		u8 dummy;
+		/*
+		 * Adjust "ctx.jit.index", so "gen_*()" functions below
+		 * can use it for their output addresses.
+		 */
+		ctx->jit.index = ctx->bpf2insn[i];
+
+		if (insn->code == bpf_opc_call) {
+			CHECK_RET(handle_call(ctx, insn, &dummy));
+		} else if (insn->code == bpf_opc_ldi64) {
+			CHECK_RET(handle_ld_imm64(ctx, insn, &dummy));
+			/* Skip the next instruction. */
+			++i;
+		}
+	}
+	return 0;
+}
+
+/*
+ * A normal pass that involves a "dry-run" phase, jit_prepare(),
+ * to get the necessary data for the real compilation phase,
+ * jit_compile().
+ */
+struct bpf_prog *do_normal_pass(struct bpf_prog *prog)
+{
+	struct jit_context ctx;
+
+	/* Bail out if JIT is disabled. */
+	if (!prog->jit_requested)
+		return prog;
+
+	if (jit_ctx_init(&ctx, prog)) {
+		jit_ctx_cleanup(&ctx);
+		return prog;
+	}
+
+	/* Get the lenghts and allocate buffer. */
+	if (jit_prepare(&ctx)) {
+		jit_ctx_cleanup(&ctx);
+		return prog;
+	}
+
+	if (jit_compile(&ctx)) {
+		jit_ctx_cleanup(&ctx);
+		return prog;
+	}
+
+	jit_finalize(&ctx);
+
+	return ctx.prog;
+}
+
+/*
+ * If there are multi-function BPF programs that call each other,
+ * their translated addresses are not known all at once. Therefore,
+ * an extra pass is needed to consult the bpf_jit_get_func_addr()
+ * again to get the newly translated addresses in order to resolve
+ * the "call"s.
+ */
+struct bpf_prog *do_extra_pass(struct bpf_prog *prog)
+{
+	struct jit_context ctx;
+
+	/* Skip if there's no context to resume from. */
+	if (check_jit_context(prog))
+		return prog;
+
+	if (jit_ctx_init(&ctx, prog)) {
+		jit_ctx_cleanup(&ctx);
+		return prog;
+	}
+
+	if (jit_resume_context(&ctx)) {
+		jit_ctx_cleanup(&ctx);
+		return prog;
+	}
+
+	if (jit_patch_relocations(&ctx)) {
+		jit_ctx_cleanup(&ctx);
+		return prog;
+	}
+
+	jit_finalize(&ctx);
+
+	return ctx.prog;
+}
+
+/*
+ * This function may be invoked twice for the same stream of BPF
+ * instructions. The "extra pass" happens, when there are "call"s
+ * involved that their addresses are not known during the first
+ * invocation.
+ */
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+{
+	vm_dump(prog);
+
+	/* Was this program already translated? */
+	if (!prog->jited)
+		return do_normal_pass(prog);
+	else
+		return do_extra_pass(prog);
+
+	return prog;
+}
-- 
2.35.8


