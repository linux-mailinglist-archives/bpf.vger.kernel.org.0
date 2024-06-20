Return-Path: <bpf+bounces-32621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E3091119C
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 20:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51981C20C30
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 18:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442881B4C43;
	Thu, 20 Jun 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syNgJ/dA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70D51B47DF;
	Thu, 20 Jun 2024 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909860; cv=none; b=WGGUSCzbP/Bweg5fN6swCPApqGbz8jJvHSbMF6WILun03BKUuaEa7ReYIdZWc2zqKfbuoKzZb1bCWRzaVmdg0PGjhsREVVGlt2iGhcwmYCj/l7nfq+ruSDbAlkpJ0+3BH5sCCeTnXZhIw1SRSC+W7fegU6pPff6KRSJGksr3mtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909860; c=relaxed/simple;
	bh=jilLpVDj/3h9gfX70lBfexH7o8aOKdUw5Q/6HmAGVao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWiTp+vkBeLY5eq/AB5SS6mdhb/rPS8LczhE3E3WUYC9YoyQ284te+Qcvrk9b91pXJ/fNoDdfjM9bqr1Lo10xlwp7GH2ROPPc+npvYpuB9qDlvkmF0VsXUE1Ddv4JnkZOnpl5Wj8VvFZQToDQmep8SWb3EpHvWTo9PPHGzRBIag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syNgJ/dA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4483EC2BD10;
	Thu, 20 Jun 2024 18:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718909860;
	bh=jilLpVDj/3h9gfX70lBfexH7o8aOKdUw5Q/6HmAGVao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=syNgJ/dAd7u0IlB5r2IviQfXhFKNnOdzwUGzxrvbZkOU20o/xKUU4+1y1uaDSTLM9
	 tBpjv/2Hy2rTS3I86p0fD7tCicAQ+Dbcyvjya85/jwe46Likjq43pCQw3N2TpVqEPs
	 OeFGe4xmUDeNhuV7mTFrHe+z1TfZaBxwPQD4YzJhiy1i3cefXlb1CaDmKwpRUrCRO0
	 K9QeZ5enz8fRiZsEJtgJel/ZvHKGBo9pGcsENvkFOfxuEAHsmLlQf1AuJSN4JRUGJd
	 /79tM3sOAxfqYeofcD6EIQPkBFZe+29cqeTM2djhoZWJ+9L83ZUUeol3aR2QkxEazV
	 nprz3122N9K5A==
From: Naveen N Rao <naveen@kernel.org>
To: <linuxppc-dev@lists.ozlabs.org>,
	<linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [RFC PATCH v3 05/11] kbuild: Add generic hook for architectures to use before the final vmlinux link
Date: Fri, 21 Jun 2024 00:24:08 +0530
Message-ID: <8b296f09aa8a702095f8be04e9f0e167db5b4d77.1718908016.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718908016.git.naveen@kernel.org>
References: <cover.1718908016.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On powerpc, we would like to be able to make a pass on vmlinux.o and
generate a new object file to be linked into vmlinux. Add a generic pass
in Makefile.vmlinux that architectures can use for this purpose.

Architectures need to select CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX and must
provide arch/<arch>/tools/Makefile with .arch.vmlinux.o target, which
will be invoked prior to the final vmlinux link step.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/Kconfig             |  3 +++
 scripts/Makefile.vmlinux |  8 ++++++++
 scripts/link-vmlinux.sh  | 11 ++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..649f0903e7ef 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1643,4 +1643,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
 config ARCH_NEED_CMPXCHG_1_EMU
 	bool
 
+config ARCH_WANTS_PRE_LINK_VMLINUX
+	def_bool n
+
 endmenu
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 49946cb96844..6410e0be7f52 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -22,6 +22,14 @@ targets += .vmlinux.export.o
 vmlinux: .vmlinux.export.o
 endif
 
+ifdef CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX
+targets += .arch.vmlinux.o
+.arch.vmlinux.o: vmlinux.o FORCE
+	$(Q)$(MAKE) $(build)=arch/$(SRCARCH)/tools .arch.vmlinux.o
+
+vmlinux: .arch.vmlinux.o
+endif
+
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 518c70b8db50..aafaed1412ea 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -122,7 +122,7 @@ gen_btf()
 		return 1
 	fi
 
-	vmlinux_link ${1}
+	vmlinux_link ${1} ${arch_vmlinux_o}
 
 	info "BTF" ${2}
 	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
@@ -178,7 +178,7 @@ kallsyms_step()
 	kallsymso=${kallsyms_vmlinux}.o
 	kallsyms_S=${kallsyms_vmlinux}.S
 
-	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_o}
+	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_o} ${arch_vmlinux_o}
 	mksysmap ${kallsyms_vmlinux} ${kallsyms_vmlinux}.syms
 	kallsyms ${kallsyms_vmlinux}.syms ${kallsyms_S}
 
@@ -223,6 +223,11 @@ fi
 
 ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init init/version-timestamp.o
 
+arch_vmlinux_o=""
+if is_enabled CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX; then
+	arch_vmlinux_o=.arch.vmlinux.o
+fi
+
 btf_vmlinux_bin_o=""
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	btf_vmlinux_bin_o=.btf.vmlinux.bin.o
@@ -273,7 +278,7 @@ if is_enabled CONFIG_KALLSYMS; then
 	fi
 fi
 
-vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
+vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o} ${arch_vmlinux_o}
 
 # fill in BTF IDs
 if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then
-- 
2.45.2


