Return-Path: <bpf+bounces-34754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAF7930910
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493201F21635
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453464965F;
	Sun, 14 Jul 2024 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3FJrbjL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88471F94C;
	Sun, 14 Jul 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720945747; cv=none; b=jN9+gvlMNxAiPWxBo0/51MTQfeCVWKTLNDePobyt6pEFh5XrUVllSKMGYHY5B2wwyRQ6BLYSvARON9NG1dtiG1J0RH4mv2cXKo+tEVg/5qCQRd0frepp/hMVBgnMw9sot8bqaOACPPnPFs2HBBiz2cqnWOCWueh65FckZNwiqFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720945747; c=relaxed/simple;
	bh=xWhgEBXMpuHzX4bP2wz6NbJAdg0K/TnaR2I0FkU8uYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB/lsQBfwpgj5Oiu+RrRdHdRQZNNItMHXL4UI2WOaSpHhnrKZCIe6UD5SROhhAaoK4k0pP+vsotS+b3fYrML6KCQDx9jQjycnOL6QTSCgQAh/Mt/uA9sl7tq8uhUWsc9yWBNjN3JNHOf0tVsJVbvTemHx4j3Ne0cJ6gZFDL3Iks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3FJrbjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BBAC116B1;
	Sun, 14 Jul 2024 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720945747;
	bh=xWhgEBXMpuHzX4bP2wz6NbJAdg0K/TnaR2I0FkU8uYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3FJrbjLJ8QL2Bi96EsUfVgQL/UxK78P+a2e08yZOj77S+XIa2ilGGUtm37+u55t/
	 z1/XeNTC/UlRP7EyLMXhqSkquLwNosbqMn+Oi7Y66wa4HG0WrMyzgygnMnQyXmzu4V
	 OjBuB3Y/EgAga51wEiAFMHX7A4dn7IldDnq+dqUjGyxWNW+0kwV5sp6YvirsAUQz0A
	 PZQD6pClmxoI4U7bC+HdHKyiHQ6iwLEFd5MQr7wcGNWezI99UcQRyv/VviiXDyNB8D
	 F4tgIf+Jw2y06TR2BIseCxJXAwu94IPvZJyUF37izOT+asa6cyr6VtqLop+1hekeAn
	 2t8aAH97U5JzQ==
From: Naveen N Rao <naveen@kernel.org>
To: <linuxppc-dev@lists.ozlabs.org>,
	<linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>,
	linux-kbuild@vger.kernel.org,
	<linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [RFC PATCH v4 13/17] powerpc64/ftrace: Support .text larger than 32MB with out-of-line stubs
Date: Sun, 14 Jul 2024 13:57:49 +0530
Message-ID: <f4faee243f85eec691f2d72133fcb8e4aa9912d0.1720942106.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720942106.git.naveen@kernel.org>
References: <cover.1720942106.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are restricted to a .text size of ~32MB when using out-of-line
function profile sequence. Allow this to be extended up to the previous
limit of ~64MB by reserving space in the middle of .text.

A new config option CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE is
introduced to specify the number of function stubs that are reserved in
.text. On boot, ftrace utilizes stubs from this area first before using
the stub area at the end of .text.

A ppc64le defconfig has ~44k functions that can be traced. A more
conservative value of 32k functions is chosen as the default value of
PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE so that we do not allot more space
than necessary by default. If building a kernel that only has 32k
trace-able functions, we won't allot any more space at the end of .text
during the pass on vmlinux.o. Otherwise, only the remaining functions
get space for stubs at the end of .text. This default value should help
cover a .text size of ~48MB in total (including space reserved at the
end of .text which can cover up to 32MB), which should be sufficient for
most common builds. For a very small kernel build, this can be set to 0.
Or, this can be bumped up to a larger value to support vmlinux .text
size up to ~64MB.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/Kconfig                       | 12 ++++++++++++
 arch/powerpc/include/asm/ftrace.h          |  6 ++++--
 arch/powerpc/kernel/trace/ftrace.c         | 21 +++++++++++++++++----
 arch/powerpc/kernel/trace/ftrace_entry.S   |  8 ++++++++
 arch/powerpc/tools/Makefile                |  2 +-
 arch/powerpc/tools/ftrace-gen-ool-stubs.sh | 11 +++++++----
 6 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f50cfd15bb73..a4dff8624510 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -573,6 +573,18 @@ config PPC_FTRACE_OUT_OF_LINE
 	depends on PPC64
 	select ARCH_WANTS_PRE_LINK_VMLINUX
 
+config PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE
+	int "Number of ftrace out-of-line stubs to reserve within .text"
+	default 32768 if PPC_FTRACE_OUT_OF_LINE
+	default 0
+	help
+	  Number of stubs to reserve for use by ftrace. This space is
+	  reserved within .text, and is distinct from any additional space
+	  added at the end of .text before the final vmlinux link. Set to
+	  zero to have stubs only be generated at the end of vmlinux (only
+	  if the size of vmlinux is less than 32MB). Set to a higher value
+	  if building vmlinux larger than 48MB.
+
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
 	depends on SMP && (PPC_PSERIES || \
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 0589bb252de7..dc870824359c 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -140,8 +140,10 @@ extern unsigned int ftrace_tramp_text[], ftrace_tramp_init[];
 struct ftrace_ool_stub {
 	u32	insn[4];
 };
-extern struct ftrace_ool_stub ftrace_ool_stub_text_end[], ftrace_ool_stub_inittext[];
-extern unsigned int ftrace_ool_stub_text_end_count, ftrace_ool_stub_inittext_count;
+extern struct ftrace_ool_stub ftrace_ool_stub_text_end[], ftrace_ool_stub_text[],
+			      ftrace_ool_stub_inittext[];
+extern unsigned int ftrace_ool_stub_text_end_count, ftrace_ool_stub_text_count,
+		    ftrace_ool_stub_inittext_count;
 #endif
 void ftrace_free_init_tramp(void);
 unsigned long ftrace_call_adjust(unsigned long addr);
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index c03336301bad..b4de8b8cbe3a 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -168,7 +168,7 @@ static int ftrace_get_call_inst(struct dyn_ftrace *rec, unsigned long addr, ppc_
 static int ftrace_init_ool_stub(struct module *mod, struct dyn_ftrace *rec)
 {
 #ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
-	static int ool_stub_text_end_index, ool_stub_inittext_index;
+	static int ool_stub_text_index, ool_stub_text_end_index, ool_stub_inittext_index;
 	int ret = 0, ool_stub_count, *ool_stub_index;
 	ppc_inst_t inst;
 	/*
@@ -191,9 +191,22 @@ static int ftrace_init_ool_stub(struct module *mod, struct dyn_ftrace *rec)
 		ool_stub_index = &ool_stub_inittext_index;
 		ool_stub_count = ftrace_ool_stub_inittext_count;
 	} else if (is_kernel_text(rec->ip)) {
-		ool_stub = ftrace_ool_stub_text_end;
-		ool_stub_index = &ool_stub_text_end_index;
-		ool_stub_count = ftrace_ool_stub_text_end_count;
+		/*
+		 * ftrace records are sorted, so we first use up the stub area within .text
+		 * (ftrace_ool_stub_text) before using the area at the end of .text
+		 * (ftrace_ool_stub_text_end), unless the stub is out of range of the record.
+		 */
+		if (ool_stub_text_index >= ftrace_ool_stub_text_count ||
+		    !is_offset_in_branch_range((long)rec->ip -
+					       (long)&ftrace_ool_stub_text[ool_stub_text_index])) {
+			ool_stub = ftrace_ool_stub_text_end;
+			ool_stub_index = &ool_stub_text_end_index;
+			ool_stub_count = ftrace_ool_stub_text_end_count;
+		} else {
+			ool_stub = ftrace_ool_stub_text;
+			ool_stub_index = &ool_stub_text_index;
+			ool_stub_count = ftrace_ool_stub_text_count;
+		}
 #ifdef CONFIG_MODULES
 	} else if (mod) {
 		ool_stub = mod->arch.ool_stubs;
diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index 71f6a63cd861..86dbaa87532a 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -374,6 +374,14 @@ _GLOBAL(return_to_handler)
 	blr
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
+#ifdef CONFIG_PPC_FTRACE_OUT_OF_LINE
+SYM_DATA(ftrace_ool_stub_text_count, .long CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE)
+
+SYM_CODE_START(ftrace_ool_stub_text)
+	.space CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE * FTRACE_OOL_STUB_SIZE
+SYM_CODE_END(ftrace_ool_stub_text)
+#endif
+
 .pushsection ".tramp.ftrace.text","aw",@progbits;
 .globl ftrace_tramp_text
 ftrace_tramp_text:
diff --git a/arch/powerpc/tools/Makefile b/arch/powerpc/tools/Makefile
index 31dd3151c272..0ade63981aea 100644
--- a/arch/powerpc/tools/Makefile
+++ b/arch/powerpc/tools/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 quiet_cmd_gen_ftrace_ool_stubs = FTRACE  $@
-      cmd_gen_ftrace_ool_stubs = $< $(objtree)/vmlinux.o $@
+      cmd_gen_ftrace_ool_stubs = $< $(CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE) $(objtree)/vmlinux.o $@
 
 targets += .arch.vmlinux.o
 .arch.vmlinux.o: $(srctree)/arch/powerpc/tools/ftrace-gen-ool-stubs.sh $(objtree)/vmlinux.o FORCE
diff --git a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
index 0b85cd5262ff..0d83adce4f23 100755
--- a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
+++ b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
@@ -8,8 +8,8 @@ is_enabled() {
 	grep -q "^$1=y" include/config/auto.conf
 }
 
-vmlinux_o=${1}
-arch_vmlinux_o=${2}
+vmlinux_o=${2}
+arch_vmlinux_o=${3}
 arch_vmlinux_S=$(dirname ${arch_vmlinux_o})/$(basename ${arch_vmlinux_o} .o).S
 
 RELOCATION=R_PPC64_ADDR64
@@ -22,15 +22,18 @@ num_ool_stubs_text=$(${CROSS_COMPILE}objdump -r -j __patchable_function_entries
 num_ool_stubs_inittext=$(${CROSS_COMPILE}objdump -r -j __patchable_function_entries ${vmlinux_o} |
 			 grep ".init.text" | grep "${RELOCATION}" | wc -l)
 
+num_ool_stubs_text_builtin=${1}
+num_ool_stubs_text_end=$(expr ${num_ool_stubs_text} - ${num_ool_stubs_text_builtin})
+
 cat > ${arch_vmlinux_S} <<EOF
 #include <asm/asm-offsets.h>
 #include <linux/linkage.h>
 
 .pushsection .tramp.ftrace.text,"aw"
-SYM_DATA(ftrace_ool_stub_text_end_count, .long ${num_ool_stubs_text})
+SYM_DATA(ftrace_ool_stub_text_end_count, .long ${num_ool_stubs_text_end})
 
 SYM_CODE_START(ftrace_ool_stub_text_end)
-	.space ${num_ool_stubs_text} * FTRACE_OOL_STUB_SIZE
+	.space ${num_ool_stubs_text_end} * FTRACE_OOL_STUB_SIZE
 SYM_CODE_END(ftrace_ool_stub_text_end)
 .popsection
 
-- 
2.45.2


