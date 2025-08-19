Return-Path: <bpf+bounces-66028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF7B2CCD1
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 21:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9AE5E3AE3
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CD52673AA;
	Tue, 19 Aug 2025 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qpenKYZE"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6C38F91;
	Tue, 19 Aug 2025 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630930; cv=none; b=qffUGmfb+YgLvjK32ZKY6a/DoaUSOM2SuKgGOGThST/Nd69kLHzg6E5LEF1vRd3GXaUbsMLZFjRUvKqOdq19/YGqe6TBbCWv29El2R4I9J4q59NttBU6I8G3fGr+e41duzhDsEk/nJjn5lSpOejdH9r8hkEw0L2xgXHlnP6QmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630930; c=relaxed/simple;
	bh=PUZdeGnRFsTuyNHfojrHWrLzNY8h7sktC9CzuuJMMGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NorNOhSf98+IpaJzChpIzVLfeFWJcG2+ACAEKriyXnDadjGJhpw1Ae1mT+ofvGWJ5WSJGYSY5ILm9/uZHyXEYvhkNORNJ+7USDJ3kpa4J8g8bNelT/8mXpPYmb2r3ZCpwtCGrG6GPFWAB/tmr2d6xa4rlLK/kIPzZ5hQRDKmUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qpenKYZE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yzBy5xGZO8xEeMDkcKh9IUr70uttd4I0McN2kTShxz8=; b=qpenKYZEkUwE3cC0+3m1ybjAkc
	0C0w9sAxkg/W6A12dcXXl+P3/6JcZUJxYbfD1NGT0Y5c1bzirS7RxuGS3CLinssXT4lC458VgF3G3
	65XdweZ0CHneOBTHPjoWfgz/jnK6HprZalDZeLtkD/R2H2LYrN3SdCalki1aQWLiG9FQE1tNBrGJK
	JH78+qXwUXUKL3S1TOwcUYsHYNM+7pzWTGQiQUaZ6QylZDb0jI+ptSJgtP0GhGgPDknJwPCEjQE9d
	yVkKdFhfSDVNeDMIa/8rYJLTwjqLgCnV9ACsRXq59CZTx8RaS21F/VdAuy3sDmfrQYKw684hZjLu/
	qcNoW9Gw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoRng-0000000AcyQ-0Kbu;
	Tue, 19 Aug 2025 19:15:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6982E30036F; Tue, 19 Aug 2025 21:15:15 +0200 (CEST)
Date: Tue, 19 Aug 2025 21:15:15 +0200
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
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20250819191515.GM3289052@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720112133.244369-11-jolsa@kernel.org>

On Sun, Jul 20, 2025 at 01:21:20PM +0200, Jiri Olsa wrote:

> +static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
> +{
> +	struct __packed __arch_relative_insn {
> +		u8 op;
> +		s32 raddr;
> +	} *call = (struct __arch_relative_insn *) insn;

Not something you need to clean up now I suppose, but we could do with
unifying this thing. we have a bunch of instances around.

> +
> +	if (!is_call_insn(insn))
> +		return false;
> +	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
> +}

> +void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	uprobe_opcode_t insn[5];
> +
> +	/*
> +	 * Do not optimize if shadow stack is enabled, the return address hijack
> +	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
> +	 * the entry uprobe is optimized and the shadow stack crashes the app.
> +	 */
> +	if (shstk_is_enabled())
> +		return;

Kernel should be able to fix up userspace shadow stack just fine.

> +	if (!should_optimize(auprobe))
> +		return;
> +
> +	mmap_write_lock(mm);
> +
> +	/*
> +	 * Check if some other thread already optimized the uprobe for us,
> +	 * if it's the case just go away silently.
> +	 */
> +	if (copy_from_vaddr(mm, vaddr, &insn, 5))
> +		goto unlock;
> +	if (!is_swbp_insn((uprobe_opcode_t*) &insn))
> +		goto unlock;
> +
> +	/*
> +	 * If we fail to optimize the uprobe we set the fail bit so the
> +	 * above should_optimize will fail from now on.
> +	 */
> +	if (__arch_uprobe_optimize(auprobe, mm, vaddr))
> +		set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &auprobe->flags);
> +
> +unlock:
> +	mmap_write_unlock(mm);
> +}
> +
> +static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
> +{
> +	if (memcmp(&auprobe->insn, x86_nops[5], 5))
> +		return false;
> +	/* We can't do cross page atomic writes yet. */
> +	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= 5;
> +}

This seems needlessly restrictive. Something like:

is_nop5(const char *buf)
{
	struct insn insn;

	ret = insn_decode_kernel(&insn, buf)
	if (ret < 0)
		return false;

	if (insn.length != 5)
		return false;

	if (insn.opcode[0] != 0x0f ||
	    insn.opcode[1] != 0x1f)
	    	return false;

	return true;
}

Should do I suppose. Anyway, I think something like:

  f0 0f 1f 44 00 00	lock nopl 0(%eax, %eax, 1)

is a valid NOP5 at +1 and will 'optimize' and result in:

  f0 e8 disp32		lock call disp32

which will #UD.

But this is nearly unfixable. Just doing my best to find weirdo cases
;-)

