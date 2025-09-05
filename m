Return-Path: <bpf+bounces-67537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A31B45146
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 10:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07FB1C21CE0
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 08:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9131B304BB4;
	Fri,  5 Sep 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EtcEA84B"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311A2797A3;
	Fri,  5 Sep 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060703; cv=none; b=qNiVUqFKLNRH/D1hLjaDAJi11Gl6C3Am795UX4P3kmuVyU1ujDkGX+TfGBBbPy2ei4QsseRVUkChiZZYx/D8LwRhKnwtKi8BtGloedVwP5mCGvK2GN5SqMiPp5VKqUVJkBGomzycxBIO+WMsQLeeFdE1ENKI0NxdzJdlpWZVWEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060703; c=relaxed/simple;
	bh=sSHBpf5gNZD4zUBkCscC6KgcuBcDuYpB76W99xRjE10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLv9NowjRQjqSavPrG80DQ/giugmg0REDYjsBQOiqJz37qapd1Q5zEQJxPTYrNtWs7Oh/QYoKN7jz61YhtFcFV/H9Ql4+ZsPU0OBGBgnRDSFzAnRh+yW3uIdzC16GpJ6GgawAKvdOBxF5gguYoYRrT9hj9YBcavuwIvkORUxZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EtcEA84B; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PwfmZGqP6JvTcDVciyiLJhdNhb7filjP+mJ4Kpx4Mec=; b=EtcEA84BoJ6U63x+A0GH7p1XmI
	aBQdAwoukV6CX0BCcRZ7xYHoinwVh7BTLYbpYXwcOSTOz+UzjXd7V3Onomsd1hNedbbjiYncjo0jq
	krK48/tgu4YUQVZCHxpxjl5GptEr/vdNEVq+ysZAworBR3eABLzxy2LIVXb9l0nmvnMvUVznazN8t
	SrnFlR4bSlp5zd4+GlY4wGyvWp62YpnUT5wcBinAFazczaeNt84wN/39pGJc1VrGU5AonqUK+Ewcf
	YuaLurmKjROeGJ7Tj9SYqBQv5bsmCsKqLMorRcJex2cy7gR/ig4WRmCvs/a6WrYUpfjXO5Yusxt9B
	QEfYgqFA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuRkW-00000004Ujy-2XJw;
	Fri, 05 Sep 2025 08:24:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6A4E330034B; Fri, 05 Sep 2025 10:24:47 +0200 (CEST)
Date: Fri, 5 Sep 2025 10:24:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: nop5-optimized USDTs WAS: Re: [PATCHv6 perf/core 09/22]
 uprobes/x86: Add uprobe syscall to speed up uprobe
Message-ID: <20250905082447.GQ4068168@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLlKJWRs5etuvFuK@krava>
 <CAEf4BzYUyOP_ziQjXshVeKmiocLjtWH+8LVHSaFNN1p=sp2rNg@mail.gmail.com>
 <20250904203511.GB4067720@noisy.programming.kicks-ass.net>
 <CAEf4BzZ6xSc7cFy7rF=G2+gPAfK+5cvZ0eDhnd5eP5m1t9EK-A@mail.gmail.com>
 <20250904205210.GQ3245006@noisy.programming.kicks-ass.net>
 <CAEf4BzY216jgetzA_TBY7_jSkcw-TGCj64s96ijoi3iAhcyHuw@mail.gmail.com>
 <20250904215617.GR3245006@noisy.programming.kicks-ass.net>
 <20250904215826.GP4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904215826.GP4068168@noisy.programming.kicks-ass.net>

On Thu, Sep 04, 2025 at 11:58:26PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 04, 2025 at 11:56:17PM +0200, Peter Zijlstra wrote:
> 
> > Ooh, that suggests we do something like so:
> 
> N/m, I need to go sleep, that doesn't work right for the 32bit nops that
> use lea instead of nopl. I'll see if I can come up with something more
> sensible.

Something like this. Can someone please look very critical at this fancy
insn_is_nop()?

---
 arch/x86/include/asm/insn-eval.h |  2 +
 arch/x86/kernel/alternative.c    | 20 +--------
 arch/x86/kernel/uprobes.c        | 32 ++------------
 arch/x86/lib/insn-eval.c         | 92 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 54368a43abf6..4733e9064ee5 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -44,4 +44,6 @@ enum insn_mmio_type {
 
 enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
 
+bool insn_is_nop(struct insn *insn);
+
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7bde68247b5f..e1f98189fe77 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -9,6 +9,7 @@
 
 #include <asm/text-patching.h>
 #include <asm/insn.h>
+#include <asm/insn-eval.h>
 #include <asm/ibt.h>
 #include <asm/set_memory.h>
 #include <asm/nmi.h>
@@ -345,25 +346,6 @@ static void add_nop(u8 *buf, unsigned int len)
 		*buf = INT3_INSN_OPCODE;
 }
 
-/*
- * Matches NOP and NOPL, not any of the other possible NOPs.
- */
-static bool insn_is_nop(struct insn *insn)
-{
-	/* Anything NOP, but no REP NOP */
-	if (insn->opcode.bytes[0] == 0x90 &&
-	    (!insn->prefixes.nbytes || insn->prefixes.bytes[0] != 0xF3))
-		return true;
-
-	/* NOPL */
-	if (insn->opcode.bytes[0] == 0x0F && insn->opcode.bytes[1] == 0x1F)
-		return true;
-
-	/* TODO: more nops */
-
-	return false;
-}
-
 /*
  * Find the offset of the first non-NOP instruction starting at @offset
  * but no further than @len.
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0a8c0a4a5423..32bc583e6fd4 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -17,6 +17,7 @@
 #include <linux/kdebug.h>
 #include <asm/processor.h>
 #include <asm/insn.h>
+#include <asm/insn-eval.h>
 #include <asm/mmu_context.h>
 #include <asm/nops.h>
 
@@ -1158,35 +1159,12 @@ void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
 	mmap_write_unlock(mm);
 }
 
-static bool insn_is_nop(struct insn *insn)
-{
-	return insn->opcode.nbytes == 1 && insn->opcode.bytes[0] == 0x90;
-}
-
-static bool insn_is_nopl(struct insn *insn)
-{
-	if (insn->opcode.nbytes != 2)
-		return false;
-
-	if (insn->opcode.bytes[0] != 0x0f || insn->opcode.bytes[1] != 0x1f)
-		return false;
-
-	if (!insn->modrm.nbytes)
-		return false;
-
-	if (X86_MODRM_REG(insn->modrm.bytes[0]) != 0)
-		return false;
-
-	/* 0f 1f /0 - NOPL */
-	return true;
-}
-
 static bool can_optimize(struct insn *insn, unsigned long vaddr)
 {
 	if (!insn->x86_64 || insn->length != 5)
 		return false;
 
-	if (!insn_is_nop(insn) && !insn_is_nopl(insn))
+	if (!insn_is_nop(insn))
 		return false;
 
 	/* We can't do cross page atomic writes yet. */
@@ -1428,17 +1406,13 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	insn_byte_t p;
 	int i;
 
-	/* x86_nops[insn->length]; same as jmp with .offs = 0 */
-	if (insn->length <= ASM_NOP_MAX &&
-	    !memcmp(insn->kaddr, x86_nops[insn->length], insn->length))
+	if (insn_is_nop(insn))
 		goto setup;
 
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
 		break;
-	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
-		goto setup;
 
 	case 0xe8:	/* call relative */
 		branch_clear_offset(auprobe, insn);
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 4e385cbfd444..3a67f1c5582c 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1676,3 +1676,95 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 
 	return type;
 }
+
+bool insn_is_nop(struct insn *insn)
+{
+	u8 rex, rex_b = 0, rex_x = 0, rex_r = 0, rex_w = 0;
+	u8 modrm, modrm_mod, modrm_reg, modrm_rm;
+	u8 sib = 0, sib_scale, sib_index, sib_base;
+
+	if (insn->rex_prefix.nbytes) {
+		rex = insn->rex_prefix.bytes[0];
+		rex_w = !!X86_REX_W(rex);
+		rex_r = !!X86_REX_R(rex);
+		rex_x = !!X86_REX_X(rex);
+		rex_b = !!X86_REX_B(rex);
+	}
+
+	if (insn->modrm.nbytes) {
+		modrm = insn->modrm.bytes[0];
+		modrm_mod = X86_MODRM_MOD(modrm);
+		modrm_reg = X86_MODRM_REG(modrm) + 8*rex_r;
+		modrm_rm  = X86_MODRM_RM(modrm)  + 8*rex_b;
+	}
+
+	if (insn->sib.nbytes) {
+		sib = insn->sib.bytes[0];
+		sib_scale = X86_SIB_SCALE(sib);
+		sib_index = X86_SIB_INDEX(sib) + 8*rex_x;
+		sib_base  = X86_SIB_BASE(sib)  + 8*rex_b;
+
+		modrm_rm = sib_base;
+	}
+
+	switch (insn->opcode.bytes[0]) {
+	case 0x0f: /* 2nd byte */
+		break;
+
+	case 0x89: /* MOV */
+		if (modrm_mod != 3) /* register-direct */
+			return false;
+
+		if (insn->x86_64 && !rex_w) /* native size */
+			return false;
+
+		for (int i = 0; i < insn->prefixes.nbytes; i++) {
+			if (insn->prefixes.bytes[i] == 0x66) /* OSP */
+				return false;
+		}
+
+		return modrm_reg == modrm_rm; /* MOV %reg, %reg */
+
+	case 0x8d: /* LEA */
+		if (modrm_mod == 0 || modrm_mod == 3) /* register-indirect with disp */
+			return false;
+
+		if (insn->x86_64 && !rex_w) /* native size */
+			return false;
+
+		if (insn->displacement.value != 0)
+			return false;
+
+		if (sib & (sib_scale != 0 || sib_index != 4)) /* (%reg, %eiz, 1) */
+			return false;
+
+		for (int i = 0; i < insn->prefixes.nbytes; i++) {
+			if (insn->prefixes.bytes[i] != 0x3e) /* DS */
+				return false;
+		}
+
+		return modrm_reg == modrm_rm; /* LEA 0(%reg), %reg */
+
+	case 0x90: /* NOP */
+		for (int i = 0; i < insn->prefixes.nbytes; i++) {
+			if (insn->prefixes.bytes[i] == 0xf3) /* REP */
+				return false; /* REP NOP -- PAUSE */
+		}
+		return true;
+
+	case 0xe9: /* JMP.d32 */
+	case 0xeb: /* JMP.d8 */
+		return insn->immediate.value == 0; /* JMP +0 */
+
+	default:
+		return false;
+	}
+
+	switch (insn->opcode.bytes[1]) {
+	case 0x1f:
+		return modrm_reg == 0; /* 0f 1f /0 -- NOPL */
+
+	default:
+		return false;
+	}
+}

