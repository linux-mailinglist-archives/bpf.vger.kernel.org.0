Return-Path: <bpf+bounces-46832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCC89F0A08
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 11:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C782A188A21F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 10:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463771C3BE7;
	Fri, 13 Dec 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pkXjcVTv"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687A1C07F1;
	Fri, 13 Dec 2024 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086957; cv=none; b=I2xZGqSqlc+rwNRdnSiZTWlivNSGEeHOgPCqHtVIM7TdAAPEY694W8DOabVtxvkc1WYzvMsiXKKZ6664NshH7dToVacase4bDLGl89kKX99shp/B/+DXixlcgvLBgzqwF/bZ7mudNUd2Yn+3Puyv3hmA7yttaNbBS/p2GTI5+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086957; c=relaxed/simple;
	bh=QTpFgbC0lMRIURIjL9XtOH2tvQzwa5Th2hdbKEH5i+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ode+ozF9ZbIpW4LLweRXS7GJ9fbNHkv6CU1lAYde95s5MnhYFklISs2nZ3wN/Rwsixug3yDAGkvuptENQf5QxK9s1zqf4SAIHZQp07U5OngF6EetmbUJZV6vrZmViz71QVOpdpQ62FieKytiZO/IMU6VBp3aCMosiRwQlvLDKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pkXjcVTv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qZcE4VAYVRjDeKcX4tFrH5Xyw4YkZtRwarxUiu6KUq4=; b=pkXjcVTvP/7ANwQatvK8RlIVl/
	oFSvU2a3RFPulTSVQ9iIHehLzT7Qro25M+T1dZy93nKKaya8Q76owmkLDRtVddz0xaMkjNBPJC5n7
	8DvqC1L1PmlbH+HM4uUGpF4AjIvIPMjMdESDwWqCZTn08zjVPAjbEU2W8kG68GphUpxwj9dqwneM0
	cW5GrBonciLnbZCoaPxEKfLnpQYVMVi2vCPD34cmogBkqy3ff34yXRfxdzfFr/PyaQ3/R9pulMqfP
	7htpykfrRHqmHuS7tWoIGFqrENgVeCCSeiP2PqzqcazaGbONl3k7SqxOI17RVHfeZEsInvK8SbW4a
	8qe8zpsQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM3EK-00000004Frn-1ewh;
	Fri, 13 Dec 2024 10:49:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AC02830049D; Fri, 13 Dec 2024 11:49:07 +0100 (CET)
Date: Fri, 13 Dec 2024 11:49:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20241213104907.GA35539@noisy.programming.kicks-ass.net>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-9-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211133403.208920-9-jolsa@kernel.org>

On Wed, Dec 11, 2024 at 02:33:57PM +0100, Jiri Olsa wrote:
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index cdea97f8cd39..b2420eeee23a 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c

> @@ -1306,3 +1339,132 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
>  	else
>  		return regs->sp <= ret->stack;
>  }
> +
> +int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct page *page,
> +			      unsigned long vaddr, uprobe_opcode_t *new_opcode,
> +			      int nbytes)
> +{
> +	uprobe_opcode_t old_opcode[5];
> +	bool is_call, is_swbp, is_nop5;
> +
> +	if (!test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
> +		return uprobe_verify_opcode(page, vaddr, new_opcode);
> +
> +	/*
> +	 * The ARCH_UPROBE_FLAG_CAN_OPTIMIZE flag guarantees the following
> +	 * 5 bytes read won't cross the page boundary.
> +	 */
> +	uprobe_copy_from_page(page, vaddr, (uprobe_opcode_t *) &old_opcode, 5);
> +	is_call = is_call_insn((uprobe_opcode_t *) &old_opcode);
> +	is_swbp = is_swbp_insn((uprobe_opcode_t *) &old_opcode);
> +	is_nop5 = is_nop5_insn((uprobe_opcode_t *) &old_opcode);
> +
> +	/*
> +	 * We allow following trasitions for optimized uprobes:
> +	 *
> +	 *   nop5 -> swbp -> call
> +	 *   ||      |       |
> +	 *   |'--<---'       |
> +	 *   '---<-----------'
> +	 *
> +	 * We return 1 to ack the write, 0 to do nothing, -1 to fail write.
> +	 *
> +	 * If the current opcode (old_opcode) has already desired value,
> +	 * we do nothing, because we are racing with another thread doing
> +	 * the update.
> +	 */
> +	switch (nbytes) {
> +	case 5:
> +		if (is_call_insn(new_opcode)) {
> +			if (is_swbp)
> +				return 1;
> +			if (is_call && !memcmp(new_opcode, &old_opcode, 5))
> +				return 0;
> +		} else {
> +			if (is_call || is_swbp)
> +				return 1;
> +			if (is_nop5)
> +				return 0;
> +		}
> +		break;
> +	case 1:
> +		if (is_swbp_insn(new_opcode)) {
> +			if (is_nop5)
> +				return 1;
> +			if (is_swbp || is_call)
> +				return 0;
> +		} else {
> +			if (is_swbp || is_call)
> +				return 1;
> +			if (is_nop5)
> +				return 0;
> +		}
> +	}
> +	return -1;
> +}
> +
> +bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes)
> +{
> +	return nbytes == 5 ? is_call_insn(insn) : is_swbp_insn(insn);
> +}
> +
> +static void __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
> +				   unsigned long vaddr)
> +{
> +	struct uprobe_trampoline *tramp;
> +	char call[5];
> +
> +	tramp = uprobe_trampoline_get(vaddr);
> +	if (!tramp)
> +		goto fail;
> +
> +	relative_call(call, (void *) vaddr, (void *) tramp->vaddr);
> +	if (uprobe_write_opcode(auprobe, mm, vaddr, call, 5))
> +		goto fail;
> +
> +	set_bit(ARCH_UPROBE_FLAG_OPTIMIZED, &auprobe->flags);
> +	return;
> +
> +fail:
> +	/* Once we fail we never try again. */
> +	clear_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
> +	uprobe_trampoline_put(tramp);
> +}
> +
> +static bool should_optimize(struct arch_uprobe *auprobe)
> +{
> +	if (!test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
> +		return false;
> +	if (test_bit(ARCH_UPROBE_FLAG_OPTIMIZED, &auprobe->flags))
> +		return false;
> +	return true;
> +}
> +
> +void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
> +{
> +	struct mm_struct *mm = current->mm;
> +
> +	if (!should_optimize(auprobe))
> +		return;
> +
> +	mmap_write_lock(mm);
> +	if (should_optimize(auprobe))
> +		__arch_uprobe_optimize(auprobe, mm, vaddr);
> +	mmap_write_unlock(mm);
> +}
> +
> +int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
> +{
> +	uprobe_opcode_t *insn = (uprobe_opcode_t *) auprobe->insn;
> +
> +	if (test_bit(ARCH_UPROBE_FLAG_OPTIMIZED, &auprobe->flags))
> +		return uprobe_write_opcode(auprobe, mm, vaddr, insn, 5);
> +
> +	return uprobe_write_opcode(auprobe, mm, vaddr, insn, UPROBE_SWBP_INSN_SIZE);
> +}
> +
> +bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr)
> +{
> +	long delta = (long)(vaddr + 5 - vtramp);
> +	return delta >= INT_MIN && delta <= INT_MAX;
> +}

All this code is useless on 32bit, right?

