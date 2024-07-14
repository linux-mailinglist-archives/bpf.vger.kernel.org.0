Return-Path: <bpf+bounces-34761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C09930927
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437CA28164F
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568913A86A;
	Sun, 14 Jul 2024 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toD/dL/e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4631D559;
	Sun, 14 Jul 2024 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720945778; cv=none; b=ggSlnGc5CD8Qnt060TNgyuN0AtPwx+TgPiOdl1i2xwzgzEFOyeBmor9iHUD4989yKb4aHWdJYIATjuHt5Bnz1cMQkdbQYnP53OvQRPWo/uH4qLTIoj0zMdmUjMM8no94Uc7sidvzs2t8l+diuEaHkqe3IypXUD8DXrpSgFFbZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720945778; c=relaxed/simple;
	bh=AHR4/JGyg5TPmVP3bzTkFu+vZK+lkm0Waf1/cjS2xT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFFil8bpIk9rS+iw7lfkDU9d5gAPR7Q2rneFblHEO7+fvl54VUqd/nXoFMdGrwsmgv0D4VmWUoTjL+ejuNH9if6i/QhborUzyMEkfKKTECe1TE7DOV4M4U1OZu0ujN4BeS0yF4e7cMnQSiQRLFuBMr0ZrcwuO8rCpoywmbr4/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toD/dL/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA87C4AF09;
	Sun, 14 Jul 2024 08:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720945777;
	bh=AHR4/JGyg5TPmVP3bzTkFu+vZK+lkm0Waf1/cjS2xT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toD/dL/eQEsUiyfYDoEK6XuBkkK+oUQPq1we50+G+jrKS87rWXlJJVpGpSEWphKHN
	 1aHX3ZqQWmtHtgyxNbiwMmGob2SLrPBuzZ6vM1SkGlb1J+MICOqyAOKWQwxMXCvEt9
	 9STw8D+S9mHx+r9P+Tp3g4AhUiZouQFylUcWI0FquSvBVCtS45KWG+/gAH1KqLe9Vh
	 or5UfGvDYhikdq6eDzq2H1EgdcAD+3p8crSFl3P4oFIUESKw9VsvHMNPgdW6GMPg2i
	 +hP2DxgIxikLfCA4bMVxF7e6SLg9jQijPQTlc3pMVZepPbbycLnwOJ8yzfL1ifDwHP
	 2d6UIrcgky2/A==
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
Subject: [RFC PATCH v4 04/17] powerpc32/ftrace: Unify 32-bit and 64-bit ftrace entry code
Date: Sun, 14 Jul 2024 13:57:40 +0530
Message-ID: <4bad5f42d5035f7262b0b770b5e61dc7bbafd25e.1720942106.git.naveen@kernel.org>
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

On 32-bit powerpc, gcc generates a three instruction sequence for
function profiling:
	mflr	r0
	stw	r0, 4(r1)
	bl	_mcount

On kernel boot, the call to _mcount() is nop-ed out, to be patched back
in when ftrace is actually enabled. The 'stw' instruction therefore is
not necessary unless ftrace is enabled. Nop it out during ftrace init.

When ftrace is enabled, we want the 'stw' so that stack unwinding works
properly. Perform the same within the ftrace handler, similar to 64-bit
powerpc.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/trace/ftrace.c       | 6 ++++--
 arch/powerpc/kernel/trace/ftrace_entry.S | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 2ef504700e8d..8c3e523e4f96 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -240,8 +240,10 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	} else if (IS_ENABLED(CONFIG_PPC32)) {
 		/* Expected sequence: 'mflr r0', 'stw r0,4(r1)', 'bl _mcount' */
 		ret = ftrace_validate_inst(ip - 8, ppc_inst(PPC_RAW_MFLR(_R0)));
-		if (!ret)
-			ret = ftrace_validate_inst(ip - 4, ppc_inst(PPC_RAW_STW(_R0, _R1, 4)));
+		if (ret)
+			return ret;
+		ret = ftrace_modify_code(ip - 4, ppc_inst(PPC_RAW_STW(_R0, _R1, 4)),
+					 ppc_inst(PPC_RAW_NOP()));
 	} else if (IS_ENABLED(CONFIG_MPROFILE_KERNEL)) {
 		/* Expected sequence: 'mflr r0', ['std r0,16(r1)'], 'bl _mcount' */
 		ret = ftrace_read_inst(ip - 4, &old);
diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index 76dbe9fd2c0f..244a1c7bb1e8 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -33,6 +33,8 @@
  * and then arrange for the ftrace function to be called.
  */
 .macro	ftrace_regs_entry allregs
+	/* Save the original return address in A's stack frame */
+	PPC_STL		r0, LRSAVE(r1)
 	/* Create a minimal stack frame for representing B */
 	PPC_STLU	r1, -STACK_FRAME_MIN_SIZE(r1)
 
@@ -44,8 +46,6 @@
 	SAVE_GPRS(3, 10, r1)
 
 #ifdef CONFIG_PPC64
-	/* Save the original return address in A's stack frame */
-	std	r0, LRSAVE+SWITCH_FRAME_SIZE+STACK_FRAME_MIN_SIZE(r1)
 	/* Ok to continue? */
 	lbz	r3, PACA_FTRACE_ENABLED(r13)
 	cmpdi	r3, 0
-- 
2.45.2


