Return-Path: <bpf+bounces-61496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B6AAE76D0
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 08:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC54517655B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44FC1EEA4D;
	Wed, 25 Jun 2025 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tee03rVd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F3800;
	Wed, 25 Jun 2025 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750832001; cv=none; b=d4df8ou0gKM3DDvQoM8SUG6kq8DrhPRtNy291mvKP9f4F5ZcozzqfGXTpzTvbhh0sjODaVuGa1aD/xupLZsdgDmhOBkd+fYz9pRGGGVjvNTaCH9OGwve7+RAa2HiJCCSuaIgWyPtC6qhKpUCrshS3ROfedxgZmqcbewjZK0TNGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750832001; c=relaxed/simple;
	bh=Qnpw/UpFWAxsc8LwtwAtEOU0j9IQZ58Hz71mDZMl+Sg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AVy0SpZq/4nTfQODvKcTQvjzfLrxV7mk5jNFBO19uXHGT6cCUalnWI8BvZu0aRB+iIKZeEEIjbXIWiMdz0PV38/u9Msq72aufjHF1L4EWVYeKgx0ojX3wSz8mL278z/XaRHwqNndq6JoqD066qy8E+QAaapRXFWq8iPB424We3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tee03rVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B99C4CEEA;
	Wed, 25 Jun 2025 06:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750832000;
	bh=Qnpw/UpFWAxsc8LwtwAtEOU0j9IQZ58Hz71mDZMl+Sg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tee03rVdLVMXZKq+Z+1bHVHSurjZC4BLWV57S39Cy+0HmPHuW4yI08Q/WVl+e/bYG
	 e0VS3GWnEoxP4xDm3kDQAsJN5kTax5gQy+5aS7JfRWtJ/f0Jn5J2g/n6NH/LFFs3Rd
	 D/c2FDs5jlQDngFnFqzg463YnT5SIMfJMQCFIZoToLitdUbeb0EXBn5SDK6jbM465g
	 /V+kDmtOsVAE4VR4gBxYcJc5ZI92x7VpOThXAT3PM6q3gqzAhP1XpiWHrFTcR8K6VQ
	 3nFvVyTGAwKwIYP7et4zNuFGiOenimqR4iEEb/kxcZ2A3N4cNnqaevQ4PUcDQ9VW77
	 WqpzKe1k4w5xg==
Date: Wed, 25 Jun 2025 15:13:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
 <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, David Laight
 <David.Laight@ACULAB.COM>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas@t-8ch.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 05/22] uprobes: Add nbytes argument to
 uprobe_write
Message-Id: <20250625151317.f90251f9f893297a3b3345c4@kernel.org>
In-Reply-To: <20250605132350.1488129-6-jolsa@kernel.org>
References: <20250605132350.1488129-1-jolsa@kernel.org>
	<20250605132350.1488129-6-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Jun 2025 15:23:32 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding nbytes argument to uprobe_write and related functions as
> preparation for writing whole instructions in following changes.
> 
> Also renaming opcode arguments to insn, which seems to fit better.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  4 ++--
>  kernel/events/uprobes.c | 26 ++++++++++++++------------
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index e13382054435..147c4a0a1af9 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -188,7 +188,7 @@ struct uprobes_state {
>  };
>  
>  typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
> -				     uprobe_opcode_t *opcode);
> +				     uprobe_opcode_t *insn, int nbytes);
>  
>  extern void __init uprobes_init(void);
>  extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
> @@ -199,7 +199,7 @@ extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t);
>  extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
> -			uprobe_opcode_t opcode, uprobe_write_verify_t verify);
> +			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
>  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
>  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 777de9b95dd7..f7feb7417a2c 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -191,7 +191,8 @@ static void copy_to_page(struct page *page, unsigned long vaddr, const void *src
>  	kunmap_atomic(kaddr);
>  }
>  
> -static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
> +static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *insn,
> +			 int nbytes)
>  {
>  	uprobe_opcode_t old_opcode;
>  	bool is_swbp;
> @@ -208,7 +209,7 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
>  	uprobe_copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
>  	is_swbp = is_swbp_insn(&old_opcode);
>  
> -	if (is_swbp_insn(new_opcode)) {
> +	if (is_swbp_insn(insn)) {
>  		if (is_swbp)		/* register: already installed? */
>  			return 0;
>  	} else {
> @@ -401,10 +402,10 @@ static bool orig_page_is_identical(struct vm_area_struct *vma,
>  
>  static int __uprobe_write(struct vm_area_struct *vma,
>  		struct folio_walk *fw, struct folio *folio,
> -		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
> +		unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes)
>  {
> -	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
> -	const bool is_register = !!is_swbp_insn(&opcode);
> +	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
> +	const bool is_register = !!is_swbp_insn(insn);
>  	bool pmd_mappable;
>  
>  	/* For now, we'll only handle PTE-mapped folios. */
> @@ -429,7 +430,7 @@ static int __uprobe_write(struct vm_area_struct *vma,
>  	 */
>  	flush_cache_page(vma, vaddr, pte_pfn(fw->pte));
>  	fw->pte = ptep_clear_flush(vma, vaddr, fw->ptep);
> -	copy_to_page(fw->page, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
> +	copy_to_page(fw->page, insn_vaddr, insn, nbytes);
>  
>  	/*
>  	 * When unregistering, we may only zap a PTE if uffd is disabled and
> @@ -489,13 +490,14 @@ static int __uprobe_write(struct vm_area_struct *vma,
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
>  {
> -	return uprobe_write(auprobe, vma, opcode_vaddr, opcode, verify_opcode);
> +	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode);
>  }
>  
>  int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> -		 const unsigned long opcode_vaddr, uprobe_opcode_t opcode, uprobe_write_verify_t verify)
> +		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
> +		 uprobe_write_verify_t verify)
>  {
> -	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
> +	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct uprobe *uprobe;
>  	int ret, is_register, ref_ctr_updated = 0;
> @@ -505,7 +507,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  	struct folio *folio;
>  	struct page *page;
>  
> -	is_register = is_swbp_insn(&opcode);
> +	is_register = is_swbp_insn(insn);
>  	uprobe = container_of(auprobe, struct uprobe, arch);
>  
>  	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
> @@ -528,7 +530,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		goto out;
>  	folio = page_folio(page);
>  
> -	ret = verify(page, opcode_vaddr, &opcode);
> +	ret = verify(page, insn_vaddr, insn, nbytes);
>  	if (ret <= 0) {
>  		folio_put(folio);
>  		goto out;
> @@ -567,7 +569,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  	/* Walk the page tables again, to perform the actual update. */
>  	if (folio_walk_start(&fw, vma, vaddr, 0)) {
>  		if (fw.page == page)
> -			ret = __uprobe_write(vma, &fw, folio, opcode_vaddr, opcode);
> +			ret = __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes);
>  		folio_walk_end(&fw, vma);
>  	}
>  
> -- 
> 2.49.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

