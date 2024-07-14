Return-Path: <bpf+bounces-34767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 828E893093C
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE471C2011E
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B313D8A8;
	Sun, 14 Jul 2024 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt2BoB7W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6493513E04C;
	Sun, 14 Jul 2024 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720945803; cv=none; b=t4NW/PUByf74nADVq++mUpT4cK+KCEIrR9fR0dBQhLTmPqY+Dj2Pq4RwsOU/1ypRfrMSvlMIDaeVW3lB3GxCtld5PUsFqVNclh952PD31T0MQSixWIQZlM/ZMt+7NCYuOaM1kXKoInbPsF6TonfQD/IMH0pEHDZ23UCrkxPpvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720945803; c=relaxed/simple;
	bh=Ioka5XsUMFumHCOKG404RsMEfa4dS57u3guGUJVji54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJnQ2RPbDebaIDDgDNNVDJFmTMOGV0cbUFsZue/nalGiB2RX9FPjjxr8Q1R30zVOfOtZTtY6z2ckFMfcFpTtmxi0n5tibNIw1xTVs6HRg56w+/1Jzt0IdJyRQ3bwep7+3KTuqnbAiZMY3Lh7rP83Hk0fpT2oheuHnDHAVcKqASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt2BoB7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CD9C116B1;
	Sun, 14 Jul 2024 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720945803;
	bh=Ioka5XsUMFumHCOKG404RsMEfa4dS57u3guGUJVji54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zt2BoB7WmSNdxKHJLar2STWNDmvm7TCUzM6Uhx0zZWtC2oKyLQZj4RLu/7TjiNKCH
	 8TsXwBXRyIE5jymoJIYqlhPkNeNvqB+Fuvr4VVWKSBMsuYYd7w9SRW0Mtl3UiS9+8W
	 i8jEHMIRr0/9kMS9CFJJ1iizH7R+gjGSRLvKueKA/5KJhgjNf3grHiHrwaqPo12H0g
	 5qeVB6cDApxSZkxmDWLq0iRzJpwKqVX0nvrqtlawp9P1yhZXXWlJ3lfQ/Mh5yLJ0KE
	 jt4pHTN0gjcVmYI58HwrS0IIpkYY9BI0FHVxjVl+qPWO4Euswyvecc6RMG99ocVh0+
	 Rh9I6z+6YoUhA==
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
Subject: [RFC PATCH v4 10/17] powerpc/ftrace: Add a postlink script to validate function tracer
Date: Sun, 14 Jul 2024 13:57:46 +0530
Message-ID: <6eac5cc2848a08778dc8ebe6477f3b8ad98f7947.1720942106.git.naveen@kernel.org>
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

Function tracer on powerpc can only work with vmlinux having a .text
size of up to ~64MB due to powerpc branch instruction having a limited
relative branch range of 32MB. Today, this is only detected on kernel
boot when ftrace is init'ed. Add a post-link script to check the size of
.text so that we can detect this at build time, and break the build if
necessary.

We add a dependency on !COMPILE_TEST for CONFIG_HAVE_FUNCTION_TRACER so
that allyesconfig and other test builds can continue to work without
enabling ftrace.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/Kconfig               |  2 +-
 arch/powerpc/Makefile.postlink     |  8 ++++++
 arch/powerpc/tools/ftrace_check.sh | 45 ++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100755 arch/powerpc/tools/ftrace_check.sh

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f8891fbe7c16..68f0e7a5576f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -244,7 +244,7 @@ config PPC
 	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_TRACER		if PPC64 || (PPC32 && CC_IS_GCC)
+	select HAVE_FUNCTION_TRACER		if !COMPILE_TEST && (PPC64 || (PPC32 && CC_IS_GCC))
 	select HAVE_GCC_PLUGINS			if GCC_VERSION >= 50200   # plugin support on gcc <= 5.1 is buggy on PPC
 	select HAVE_GENERIC_VDSO
 	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
index ae5a4256b03d..bb601be36173 100644
--- a/arch/powerpc/Makefile.postlink
+++ b/arch/powerpc/Makefile.postlink
@@ -24,6 +24,9 @@ else
 	$(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/relocs_check.sh "$(OBJDUMP)" "$(NM)" "$@"
 endif
 
+quiet_cmd_ftrace_check = CHKFTRC $@
+      cmd_ftrace_check = $(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/ftrace_check.sh "$(NM)" "$@"
+
 # `@true` prevents complaint when there is nothing to be done
 
 vmlinux: FORCE
@@ -34,6 +37,11 @@ endif
 ifdef CONFIG_RELOCATABLE
 	$(call if_changed,relocs_check)
 endif
+ifdef CONFIG_FUNCTION_TRACER
+ifndef CONFIG_PPC64_ELF_ABI_V1
+	$(call cmd,ftrace_check)
+endif
+endif
 
 clean:
 	rm -f .tmp_symbols.txt
diff --git a/arch/powerpc/tools/ftrace_check.sh b/arch/powerpc/tools/ftrace_check.sh
new file mode 100755
index 000000000000..33f2fd45e54d
--- /dev/null
+++ b/arch/powerpc/tools/ftrace_check.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# This script checks vmlinux to ensure that all functions can call ftrace_caller() either directly,
+# or through the stub, ftrace_tramp_text, at the end of kernel text.
+
+# Error out if any command fails
+set -e
+
+# Allow for verbose output
+if [ "$V" = "1" ]; then
+	set -x
+fi
+
+if [ $# -lt 2 ]; then
+	echo "$0 [path to nm] [path to vmlinux]" 1>&2
+	exit 1
+fi
+
+# Have Kbuild supply the path to nm so we handle cross compilation.
+nm="$1"
+vmlinux="$2"
+
+stext_addr=$($nm "$vmlinux" | grep -e " [TA] _stext$" | cut -d' ' -f1 | tr '[[:lower:]]' '[[:upper:]]')
+ftrace_caller_addr=$($nm "$vmlinux" | grep -e " T ftrace_caller$" | cut -d' ' -f1 | tr '[[:lower:]]' '[[:upper:]]')
+ftrace_tramp_addr=$($nm "$vmlinux" | grep -e " T ftrace_tramp_text$" | cut -d' ' -f1 | tr '[[:lower:]]' '[[:upper:]]')
+
+ftrace_caller_offset=$(echo "ibase=16;$ftrace_caller_addr - $stext_addr" | bc)
+ftrace_tramp_offset=$(echo "ibase=16;$ftrace_tramp_addr - $ftrace_caller_addr" | bc)
+sz_32m=$(printf "%d" 0x2000000)
+sz_64m=$(printf "%d" 0x4000000)
+
+# ftrace_caller - _stext < 32M
+if [ $ftrace_caller_offset -ge $sz_32m ]; then
+	echo "ERROR: ftrace_caller (0x$ftrace_caller_addr) is beyond 32MiB of _stext" 1>&2
+	echo "ERROR: consider disabling CONFIG_FUNCTION_TRACER, or reducing the size of kernel text" 1>&2
+	exit 1
+fi
+
+# ftrace_tramp_text - ftrace_caller < 64M
+if [ $ftrace_tramp_offset -ge $sz_64m ]; then
+	echo "ERROR: kernel text extends beyond 64MiB from ftrace_caller" 1>&2
+	echo "ERROR: consider disabling CONFIG_FUNCTION_TRACER, or reducing the size of kernel text" 1>&2
+	exit 1
+fi
-- 
2.45.2


