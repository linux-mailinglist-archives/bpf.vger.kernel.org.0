Return-Path: <bpf+bounces-34768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B120893093F
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C212281F58
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C34142624;
	Sun, 14 Jul 2024 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJqJsGGi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B2282FD;
	Sun, 14 Jul 2024 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720945807; cv=none; b=mgElkWqMAazC/aJzECL/CMHk18mcM3IRYUfEP+rvdJtoNNJDMM/QiLKoaVZq6kZ8SX++L5qyfelP4Nl17/lqp1BNH0aKVaR3n7QXmWgwcdUlCJZMo/3ERr9Oi3h4K+xfT53PwqYigWTbULv9htP3r4bg0iJJRPWj5g3gwuES7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720945807; c=relaxed/simple;
	bh=LpYS83WLCwfoYEIrkASmAZU4pJqGiVpUR3z2uaU37Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMEnKFvP4v8gkWN70nhAw9H2/pzec/E4dsFcUs/InyBM6jhtapMyv6Bb519Dsm5pgRD0X+OQJ+HoYoED+VBpT7DHTAV6lwvQhWrEiYdnLsPZHEifjww7Dcesdq4mPUbIXXBBXrz6mPsedlqK2IxfeFf7GJ2PUyEN16tV4F1qPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJqJsGGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA1EC116B1;
	Sun, 14 Jul 2024 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720945807;
	bh=LpYS83WLCwfoYEIrkASmAZU4pJqGiVpUR3z2uaU37Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJqJsGGit09XBqOHB5LEw6ZRLHjyamWhzZwHwa7PgA8oYEFGYK2DUyoetxnyZpgOr
	 EvFtbYl/fTNqBnpu7kb3xvD2KQ7l41z97Wkixno4IFocFyufkxyulnYEBjTWLyQ8Lu
	 2iFj4qhy7hsFZtZYg4Mt0TI5eNwPG8NfEdxz4LMoUup9f9QiJHaGIdQSvZKKordgI6
	 rgJ1fjgHkaz0brF9NSj8Z8el0w1iU+gvPDiaTgjUcxzjfPE+r6xscrBjER1EegqwMo
	 OPTzQ+qXjavbeVMYXZvMl8xBUqNgRCl9YmXRIFXfqbCaS+gMRAaL0472Q6SC4jWAEa
	 rU1TmANJEvDZA==
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
Subject: [RFC PATCH v4 01/17] powerpc/trace: Account for -fpatchable-function-entry support by toolchain
Date: Sun, 14 Jul 2024 13:57:37 +0530
Message-ID: <12d7c105aea999faa4bcdac8587b3a2899da3461.1720942106.git.naveen@kernel.org>
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

So far, we have relied on the fact that gcc supports both
-mprofile-kernel, as well as -fpatchable-function-entry, and clang
supports neither. Our Makefile only checks for CONFIG_MPROFILE_KERNEL to
decide which files to build. Clang has a feature request out [*] to
implement -fpatchable-function-entry, and is unlikely to support
-mprofile-kernel.

Update our Makefile checks so that we pick up the correct files to build
once clang picks up support for -fpatchable-function-entry.

[*] https://github.com/llvm/llvm-project/issues/57031

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/trace/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/trace/Makefile b/arch/powerpc/kernel/trace/Makefile
index 125f4ca588b9..d6c3885453bd 100644
--- a/arch/powerpc/kernel/trace/Makefile
+++ b/arch/powerpc/kernel/trace/Makefile
@@ -9,12 +9,15 @@ CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_ftrace_64_pg.o = $(CC_FLAGS_FTRACE)
 endif
 
-obj32-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o ftrace_entry.o
-ifdef CONFIG_MPROFILE_KERNEL
-obj64-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o ftrace_entry.o
+ifdef CONFIG_FUNCTION_TRACER
+obj32-y					+= ftrace.o ftrace_entry.o
+ifeq ($(CONFIG_MPROFILE_KERNEL)$(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY),)
+obj64-y					+= ftrace_64_pg.o ftrace_64_pg_entry.o
 else
-obj64-$(CONFIG_FUNCTION_TRACER)		+= ftrace_64_pg.o ftrace_64_pg_entry.o
+obj64-y					+= ftrace.o ftrace_entry.o
 endif
+endif
+
 obj-$(CONFIG_TRACING)			+= trace_clock.o
 
 obj-$(CONFIG_PPC64)			+= $(obj64-y)
-- 
2.45.2


