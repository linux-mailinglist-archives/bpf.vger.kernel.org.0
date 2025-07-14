Return-Path: <bpf+bounces-63153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2727FB03B4B
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 11:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7978B3A25AA
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 09:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0E242913;
	Mon, 14 Jul 2025 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BeWA0E5X"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264311E47A8;
	Mon, 14 Jul 2025 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486516; cv=none; b=UF8ya5VVgdgzdIYBlN0CxD7Q0X51CB3zT7b0RTDncPj2Jm38zctwKbPfwZ015Jbk02nmpWGnhlSlPIlxzzPI2XtKVq4AqYx59BNwWHXYsANE/R+hQgbcgSU7iPYFXsDGooY5KdueCln9LtAFRDBSElnpWndZU35L6CtzLoMJduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486516; c=relaxed/simple;
	bh=Pqhjlt7Xe4QZEQNw9loSdR5L7feW5hzre3d9xP9ALNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvn7BtCLIZV9VlGN6NuEhvJpC+R4WxE7QAprLCyXSSjnijVMCYOCoeN/FXMTwxS3FOR6XcWWq08dDRGycs+sjoadbEEaJHzvGpygLJGJH5N2m7+QyY+ooDhQT9+I/1EIywIT0oZyAbdu/4pBysPQtnNRQzEJZMxSy/fsKJ2tqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BeWA0E5X; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0BQrc84RUIgCrBwltnNpR1JpwRq1C4cmxPtCU54YBc0=; b=BeWA0E5XyP48nCmsFvJIJs73aS
	8gVWLdq+voR0crClgGWWRv1JrT9+htkSYntujcpCiu+awuHnsNjyRmC+fHkKqSrYvJsMGykhBY2Hh
	6lgBVzbJIw3NM86AtzG7efTn9wTVj8JgX8TzXpIQG/B0CGmRBkoaIYUmLRY+Am9bSorRvidnMIkji
	q+E8v9L3rYRkfxS0Np2Q4Nhpjaw22IZHl43VPtmejI/vB0wjtvQETBjZrNdCkm5iTbYc0IIE7OgTu
	Z/4BvKl/HdHioId1SNJsmTJ2n9d9EVpYz6quXrmaqN0d/U4IluC4fBcKm0u/uROsMG9h7TZhxIcAC
	shSWd9Jg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFnM-00000009k4R-3bMv;
	Mon, 14 Jul 2025 09:48:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 54682300186; Mon, 14 Jul 2025 11:48:24 +0200 (CEST)
Date: Mon, 14 Jul 2025 11:48:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20250714094824.GQ905792@noisy.programming.kicks-ass.net>
References: <20250711082931.3398027-1-jolsa@kernel.org>
 <20250711082931.3398027-11-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711082931.3398027-11-jolsa@kernel.org>

On Fri, Jul 11, 2025 at 10:29:18AM +0200, Jiri Olsa wrote:
> +enum {
> +	OPT_PART,
> +	OPT_INSN,
> +	UNOPT_INT3,
> +	UNOPT_PART,
> +};
> +
> +struct write_opcode_ctx {
> +	unsigned long base;
> +	int update;
> +};
> +
> +static int is_call_insn(uprobe_opcode_t *insn)
> +{
> +	return *insn == CALL_INSN_OPCODE;
> +}
> +
> +static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode,
> +		       int nbytes, void *data)
> +{
> +	struct write_opcode_ctx *ctx = data;
> +	uprobe_opcode_t old_opcode[5];
> +
> +	uprobe_copy_from_page(page, ctx->base, (uprobe_opcode_t *) &old_opcode, 5);
> +
> +	switch (ctx->update) {
> +	case OPT_PART:
> +	case OPT_INSN:
> +		if (is_swbp_insn(&old_opcode[0]))
> +			return 1;
> +		break;
> +	case UNOPT_INT3:
> +		if (is_call_insn(&old_opcode[0]))
> +			return 1;
> +		break;
> +	case UNOPT_PART:
> +		if (is_swbp_insn(&old_opcode[0]))
> +			return 1;
> +		break;
> +	}
> +
> +	return -1;
> +}
> +
> +static int write_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr,
> +		      uprobe_opcode_t *insn, int nbytes, void *ctx)
> +{
> +	return uprobe_write(auprobe, vma, vaddr, insn, nbytes, verify_insn,
> +			    true /* is_register */, false /* do_update_ref_ctr */, ctx);
> +}
> +
> +static void relative_call(void *dest, long from, long to)
> +{
> +	struct __packed __arch_relative_insn {
> +		u8 op;
> +		s32 raddr;
> +	} *insn;
> +
> +	insn = (struct __arch_relative_insn *)dest;
> +	insn->raddr = (s32)(to - (from + 5));
> +	insn->op = CALL_INSN_OPCODE;
> +}

We already have this in asm/text-patching.h, its called
__text_gen_insn().

> +
> +static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> +			 unsigned long vaddr, unsigned long tramp)
> +{
> +	struct write_opcode_ctx ctx = {
> +		.base = vaddr,
> +	};
> +	char call[5];
> +	int err;
> +
> +	relative_call(call, vaddr, tramp);

	__text_gen_insn(call, CALL_INSN_OPCODE, vaddr, tramp, CALL_INSN_SIZE);

> +
> +	/*
> +	 * We are in state where breakpoint (int3) is installed on top of first
> +	 * byte of the nop5 instruction. We will do following steps to overwrite
> +	 * this to call instruction:
> +	 *
> +	 * - sync cores
> +	 * - write last 4 bytes of the call instruction
> +	 * - sync cores
> +	 * - update the call instruction opcode

The sanctioned text poke sequence has another sync-core at the end.
Please also do this.

> +	 */
> +
> +	smp_text_poke_sync_each_cpu();
> +
> +	ctx.update = OPT_PART;
> +	err = write_insn(auprobe, vma, vaddr + 1, call + 1, 4, &ctx);
> +	if (err)
> +		return err;
> +
> +	smp_text_poke_sync_each_cpu();
> +
> +	ctx.update = OPT_INSN;
> +	return write_insn(auprobe, vma, vaddr, call, 1, &ctx);
> +}
> +
> +static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> +			   unsigned long vaddr)
> +{
> +	uprobe_opcode_t int3 = UPROBE_SWBP_INSN;
> +	struct write_opcode_ctx ctx = {
> +		.base = vaddr,
> +	};
> +	int err;
> +
> +	/*
> +	 * We need to overwrite call instruction into nop5 instruction with
> +	 * breakpoint (int3) installed on top of its first byte. We will:
> +	 *
> +	 * - overwrite call opcode with breakpoint (int3)
> +	 * - sync cores
> +	 * - write last 4 bytes of the nop5 instruction
> +	 * - sync cores
> +	 */
> +
> +	ctx.update = UNOPT_INT3;
> +	err = write_insn(auprobe, vma, vaddr, &int3, 1, &ctx);
> +	if (err)
> +		return err;
> +
> +	smp_text_poke_sync_each_cpu();
> +
> +	ctx.update = UNOPT_PART;
> +	err = write_insn(auprobe, vma, vaddr + 1, (uprobe_opcode_t *) auprobe->insn + 1, 4, &ctx);
> +
> +	smp_text_poke_sync_each_cpu();
> +	return err;
> +}

Please unify these two functions; it makes absolutely no sense to have
two copies of this logic around.


