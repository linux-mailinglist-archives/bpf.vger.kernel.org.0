Return-Path: <bpf+bounces-67507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC50B448DC
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 23:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293FA17825E
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 21:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594822D0C88;
	Thu,  4 Sep 2025 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IJfGXiuP"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF81FF1C4;
	Thu,  4 Sep 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022989; cv=none; b=OnsUTqXxmob+FgYVFbWBOfIzG61nuQavtOzsINMbbkQfgjRhSEfoCxIO5QQYrs59aTMddAr5DZhrDUpg0u2dsZ+N4jtQ+o62r2ca0+SorN66AX9BVLqfSv+HnCNdMEB8SnpdYcnaYCbTI8UcorP5Y/LcpZohz0UQeDuV96KFZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022989; c=relaxed/simple;
	bh=L/P5mw1/tc0gdUyAQQ+lBPQ6BxMzsjBLoolFiNatBaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHVPwNmTWuJ0WBxZznmrbBFHobKZiwlniDIWSkQzqEQJTUuIF3+EpPKU0hd1tM7rFtEOhCKrcp50b9qU5VXHhiXWBO0nmwYg32jbJ3luDsay60VubsDqVaYW3G2ztFUHN7Fo8+vmmNYi55YBmjQ6UEz+OVErWEioyjH6BtTSrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IJfGXiuP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=lzhyIwjwWywttDaGiy4pz/S4UDwmvvFMEO+MHVhj9eQ=; b=IJfGXiuPPmLvDobdJlenXnt04Q
	Qt5i/cGzTZHmrq5oLf1Pua+bRItuL2A9xm2SP+8vY2m1FQZ0rLJJqbgt1AIjKX443bYoxQ6ABV/oO
	aKBWSvhE29u5J331TGASb/EsHOoDTx+5VIqGoKGckptu28IdvE9mkOIiB+iPw0SPW/hKLv5FQv5Dz
	qjKDPz+IpsM3GNO1/rFmxoklNbUPPgdM8kYhsMHqV63ivXo2Qc63u54NAllrgVEMIyzPchevzxosJ
	isPZGsBEHDd/+GfToVpznFjfHnjeQjCUDzIWBL/PMZyzdpVd5E4DinWHvpBeKiXrqV/nuc6XS9mvl
	vvtvcAbg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuHwI-00000007bSj-2i3v;
	Thu, 04 Sep 2025 21:56:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DD24C300220; Thu, 04 Sep 2025 23:56:17 +0200 (CEST)
Date: Thu, 4 Sep 2025 23:56:17 +0200
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
Message-ID: <20250904215617.GR3245006@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLlKJWRs5etuvFuK@krava>
 <CAEf4BzYUyOP_ziQjXshVeKmiocLjtWH+8LVHSaFNN1p=sp2rNg@mail.gmail.com>
 <20250904203511.GB4067720@noisy.programming.kicks-ass.net>
 <CAEf4BzZ6xSc7cFy7rF=G2+gPAfK+5cvZ0eDhnd5eP5m1t9EK-A@mail.gmail.com>
 <20250904205210.GQ3245006@noisy.programming.kicks-ass.net>
 <CAEf4BzY216jgetzA_TBY7_jSkcw-TGCj64s96ijoi3iAhcyHuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY216jgetzA_TBY7_jSkcw-TGCj64s96ijoi3iAhcyHuw@mail.gmail.com>

On Thu, Sep 04, 2025 at 02:44:03PM -0700, Andrii Nakryiko wrote:
> On Thu, Sep 4, 2025 at 1:52 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Sep 04, 2025 at 01:49:49PM -0700, Andrii Nakryiko wrote:
> > > On Thu, Sep 4, 2025 at 1:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Thu, Sep 04, 2025 at 11:27:45AM -0700, Andrii Nakryiko wrote:
> > > >
> > > > > > > So I've been thinking what's the simplest and most reliable way to
> > > > > > > feature-detect support for this sys_uprobe (e.g., for libbpf to know
> > > > > > > whether we should attach at nop5 vs nop1), and clearly that would be
> > > > > >
> > > > > > wrt nop5/nop1.. so the idea is to have USDT macro emit both nop1,nop5
> > > > > > and store some info about that in the usdt's elf note, right?
> > > >
> > > > Wait, what? You're doing to emit 6 bytes and two nops? Why? Surely the
> > > > old kernel can INT3 on top of a NOP5?
> > > >
> > >
> > > Yes it can, but it's 2x slower in terms of uprobe triggering compared
> > > to nop1.
> >
> > Why? That doesn't really make sense.
> >
> 
> Of course it's silly... It's because nop5 wasn't recognized as one of
> the emulated instructions, so was handled through single-stepping.

*groan*

> > I realize its probably to late to fix the old kernel not to be stupid --
> > this must be something stupid, right? But now I need to know.
> 
> Jiri fixed this, but as you said, too late for old kernels. See [0]
> for the patch that landed not so long ago.
> 
>   [0] https://lore.kernel.org/all/20250414083647.1234007-1-jolsa@kernel.org/

Ooh, that suggests we do something like so:


diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0a8c0a4a5423..223f8925097b 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -309,6 +309,29 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 	return -ENOTSUPP;
 }
 
+static bool insn_is_nop(struct insn *insn)
+{
+	return insn->opcode.nbytes == 1 && insn->opcode.bytes[0] == 0x90;
+}
+
+static bool insn_is_nopl(struct insn *insn)
+{
+	if (insn->opcode.nbytes != 2)
+		return false;
+
+	if (insn->opcode.bytes[0] != 0x0f || insn->opcode.bytes[1] != 0x1f)
+		return false;
+
+	if (!insn->modrm.nbytes)
+		return false;
+
+	if (X86_MODRM_REG(insn->modrm.bytes[0]) != 0)
+		return false;
+
+	/* 0f 1f /0 - NOPL */
+	return true;
+}
+
 #ifdef CONFIG_X86_64
 
 struct uretprobe_syscall_args {
@@ -1158,29 +1181,6 @@ void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
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
@@ -1428,17 +1428,13 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	insn_byte_t p;
 	int i;
 
-	/* x86_nops[insn->length]; same as jmp with .offs = 0 */
-	if (insn->length <= ASM_NOP_MAX &&
-	    !memcmp(insn->kaddr, x86_nops[insn->length], insn->length))
+	if (insn_is_nop(insn) || insn_is_nopl(insn))
 		goto setup;
 
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
 		break;
-	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
-		goto setup;
 
 	case 0xe8:	/* call relative */
 		branch_clear_offset(auprobe, insn);

