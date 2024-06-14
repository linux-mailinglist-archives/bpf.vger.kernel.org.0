Return-Path: <bpf+bounces-32196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC843909200
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 19:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4F3B23EA0
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84CB19DF55;
	Fri, 14 Jun 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRzKMURf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A08719D8B7;
	Fri, 14 Jun 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718387306; cv=none; b=HwUh4M0pMmjOKJrEZwmUMqE4axqvk1r9ray8eT7UXgHDdTW/niPi9AYteOZKDZtIRh4kF0pt+2YiNZ0OpRDYpHuYgFezDlLjJ/7tECbfriWG0ZHFdzTZk5Na2UkdDNyfN2xMz5UJWbSBxA2Sj/gN133MxPd4AjreT3qcNLjGHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718387306; c=relaxed/simple;
	bh=kdioDkX1AS0ZacOm577/Bq/Mk3c/jw5avXaWrRVP09I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gkfeyz7tLsZ3AIQT+UdmN91B/PwZxiQirpioFnezjvwKyvZVNBrC73v+OVRtz0A+mL9KjzAR4ZIqmLwlrPHDWCwXo2+E7u93ieKMRKDgVcI48YOfrahYEh66lJsxcvC19682m65+eTnypX7m6w6Cm22LanPTMXM8s9gCG38Qfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRzKMURf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C01FC2BD10;
	Fri, 14 Jun 2024 17:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718387306;
	bh=kdioDkX1AS0ZacOm577/Bq/Mk3c/jw5avXaWrRVP09I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRzKMURfx3699Ers/mBC17k9lC7l2PTU25jHIqx/w3EIokujRe01eXxCYnOeDJnsB
	 yN2QslLeldA8xblLL50UetOwnLisGXVgtBrE54guc/Cj6SYqUafcez4HgHjxmfOCUn
	 YkNqGwT8H4dd61l1NxGmPDnM73l6AdB1QCas/5D0VtqRESu0MY9kA7fLmrFm52ZPLb
	 F6lFoUmQfhGtgV4x/xlU9zUz3ZOBcPW9LLGG74qkXF0ddzpbZ6BTcBxF4DHx84fGAp
	 csYpCcMKe9J8q1DB+7EzjNBUrDgGKLS6eUhZxMwSUVzOYwIpALfl4CV8ca4NlyfexP
	 qvcVV5z0kGXhQ==
Date: Fri, 14 Jun 2024 10:48:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev
Subject: Re: [PATCHv8 bpf-next 3/9] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <20240614174822.GA1185149@thelio-3990X>
References: <20240611112158.40795-1-jolsa@kernel.org>
 <20240611112158.40795-4-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611112158.40795-4-jolsa@kernel.org>

Hi Jiri,

On Tue, Jun 11, 2024 at 01:21:52PM +0200, Jiri Olsa wrote:
> Adding uretprobe syscall instead of trap to speed up return probe.
...
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2c83ba776fc7..2816e65729ac 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1474,11 +1474,20 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
>  	return ret;
>  }
>  
> +void * __weak arch_uprobe_trampoline(unsigned long *psize)
> +{
> +	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;

This change as commit ff474a78cef5 ("uprobe: Add uretprobe syscall to
speed up return probe") in -next causes the following build error for
ARCH=loongarch allmodconfig:

  In file included from include/linux/uprobes.h:49,
                   from include/linux/mm_types.h:16,
                   from include/linux/mmzone.h:22,
                   from include/linux/gfp.h:7,
                   from include/linux/xarray.h:16,
                   from include/linux/list_lru.h:14,
                   from include/linux/fs.h:13,
                   from include/linux/highmem.h:5,
                   from kernel/events/uprobes.c:13:
  kernel/events/uprobes.c: In function 'arch_uprobe_trampoline':
  arch/loongarch/include/asm/uprobes.h:12:33: error: initializer element is not constant
     12 | #define UPROBE_SWBP_INSN        larch_insn_gen_break(BRK_UPROBE_BP)
        |                                 ^~~~~~~~~~~~~~~~~~~~
  kernel/events/uprobes.c:1479:39: note: in expansion of macro 'UPROBE_SWBP_INSN'
   1479 |         static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
        |                                       ^~~~~~~~~~~~~~~~

> +	*psize = UPROBE_SWBP_INSN_SIZE;
> +	return &insn;
> +}
> +
>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>  {
>  	struct mm_struct *mm = current->mm;
> -	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
> +	unsigned long insns_size;
>  	struct xol_area *area;
> +	void *insns;
>  
>  	area = kmalloc(sizeof(*area), GFP_KERNEL);
>  	if (unlikely(!area))
> @@ -1502,7 +1511,8 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  	/* Reserve the 1st slot for get_trampoline_vaddr() */
>  	set_bit(0, area->bitmap);
>  	atomic_set(&area->slot_count, 1);
> -	arch_uprobe_copy_ixol(area->pages[0], 0, &insn, UPROBE_SWBP_INSN_SIZE);
> +	insns = arch_uprobe_trampoline(&insns_size);
> +	arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
>  
>  	if (!xol_add_vma(mm, area))
>  		return area;
> @@ -1827,7 +1837,7 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
>   *
>   * Returns -1 in case the xol_area is not allocated.
>   */
> -static unsigned long get_trampoline_vaddr(void)
> +unsigned long uprobe_get_trampoline_vaddr(void)
>  {
>  	struct xol_area *area;
>  	unsigned long trampoline_vaddr = -1;
> @@ -1878,7 +1888,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
>  	if (!ri)
>  		return;
>  
> -	trampoline_vaddr = get_trampoline_vaddr();
> +	trampoline_vaddr = uprobe_get_trampoline_vaddr();
>  	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
>  	if (orig_ret_vaddr == -1)
>  		goto fail;
> @@ -2123,7 +2133,7 @@ static struct return_instance *find_next_ret_chain(struct return_instance *ri)
>  	return ri;
>  }
>  
> -static void handle_trampoline(struct pt_regs *regs)
> +void uprobe_handle_trampoline(struct pt_regs *regs)
>  {
>  	struct uprobe_task *utask;
>  	struct return_instance *ri, *next;
> @@ -2187,8 +2197,8 @@ static void handle_swbp(struct pt_regs *regs)
>  	int is_swbp;
>  
>  	bp_vaddr = uprobe_get_swbp_addr(regs);
> -	if (bp_vaddr == get_trampoline_vaddr())
> -		return handle_trampoline(regs);
> +	if (bp_vaddr == uprobe_get_trampoline_vaddr())
> +		return uprobe_handle_trampoline(regs);
>  
>  	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
>  	if (!uprobe) {
> -- 
> 2.45.1
> 

Cheers,
Nathan

