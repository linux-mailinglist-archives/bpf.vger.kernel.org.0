Return-Path: <bpf+bounces-61497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE85AE7711
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 08:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049DF1BC4512
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58701F4612;
	Wed, 25 Jun 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDQx1S1H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6818A6C4;
	Wed, 25 Jun 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833153; cv=none; b=oxbkoTtY8w/557eiiAsDyoARmex4sGEhFAVPxmLo+ElfXxEVBoJLuaOQ5s43KrRhAb6/fiyxqBTOwAh8/WNwaVOvgPeEwnsZlQvM5tIvzoEztWKVh0/thD4n855hg/M7zthj85CSLSv+tlNM/md8LWjEClNjjNi919X0ZHTfMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833153; c=relaxed/simple;
	bh=2fz72wdEOHN12Hrp4x5DN2tgOHb8xAEfLxxCTvKe0GI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UeeGEetFKpKBzUmoci5kxX1vNkM8V2hnXlYydoVxqZoI2y6LxMV9Pkulheo95tsfFANOnaTDmuTKVq9HOvXxpRJSekxWdIPh0kzjDoeARbfF65lIynMixc/73FDLgMneklxk2U4KIGmvF4r4w6FLaDb2ONsdPZaTPhwieaBmqWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDQx1S1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03B2C4CEEA;
	Wed, 25 Jun 2025 06:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750833152;
	bh=2fz72wdEOHN12Hrp4x5DN2tgOHb8xAEfLxxCTvKe0GI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BDQx1S1HFvbpSyi0OWj0BM2UU2EI3ELm2y4BQCLW7gQA3ZA5TFFmoCRaTsd2kTc4d
	 EbTUTS1c9XPpIhxgG6oaJi60M3VFVBVWNe0nBcVYN8KuOk/ic9e/niIzGoFqwESOaH
	 zFwpPTqID/wKO7RP5rJnW16KZXnKoF5vXJPnQ/6rbnW5VUmH78LRuEk0OUqBfKKssn
	 ZE+OVSHJEk0Oc5QFITY7cGQlCUWjX2jP3hesASrMYneiRH1P+kb5lKE35vDEPrKBz2
	 H9JdoWR0jqYBaGaAmB7o0ulCdoSv7r0ekeVWCMAFoRWiNUefJEKCn1s6/PEKD6g5rr
	 qjAq/bQgeOHuQ==
Date: Wed, 25 Jun 2025 15:32:29 +0900
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
Subject: Re: [PATCHv3 perf/core 06/22] uprobes: Add is_register argument to
 uprobe_write and uprobe_write_opcode
Message-Id: <20250625153229.f39c1a1a99ce986380769150@kernel.org>
In-Reply-To: <20250605132350.1488129-7-jolsa@kernel.org>
References: <20250605132350.1488129-1-jolsa@kernel.org>
	<20250605132350.1488129-7-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Jun 2025 15:23:33 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> The uprobe_write has special path to restore the original page when we
> write original instruction back. This happens when uprobe_write detects
> that we want to write anything else but breakpoint instruction.
> 
> Moving the detection away and passing it to uprobe_write as argument,
> so it's possible to write different instructions (other than just
> breakpoint and rest).

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,


> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/arm/probes/uprobes/core.c |  2 +-
>  include/linux/uprobes.h        |  5 +++--
>  kernel/events/uprobes.c        | 21 +++++++++++----------
>  3 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
> index 885e0c5e8c20..3d96fb41d624 100644
> --- a/arch/arm/probes/uprobes/core.c
> +++ b/arch/arm/probes/uprobes/core.c
> @@ -30,7 +30,7 @@ int set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  	     unsigned long vaddr)
>  {
>  	return uprobe_write_opcode(auprobe, vma, vaddr,
> -		   __opcode_to_mem_arm(auprobe->bpinsn));
> +		   __opcode_to_mem_arm(auprobe->bpinsn), true);
>  }
>  
>  bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 147c4a0a1af9..518b26756469 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -197,9 +197,10 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
>  extern bool is_trap_insn(uprobe_opcode_t *insn);
>  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> -extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t);
> +extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t,
> +			       bool is_register);
>  extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
> -			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
> +			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register);
>  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
>  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index f7feb7417a2c..1e5dc3b30707 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -402,10 +402,10 @@ static bool orig_page_is_identical(struct vm_area_struct *vma,
>  
>  static int __uprobe_write(struct vm_area_struct *vma,
>  		struct folio_walk *fw, struct folio *folio,
> -		unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes)
> +		unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
> +		bool is_register)
>  {
>  	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
> -	const bool is_register = !!is_swbp_insn(insn);
>  	bool pmd_mappable;
>  
>  	/* For now, we'll only handle PTE-mapped folios. */
> @@ -488,26 +488,27 @@ static int __uprobe_write(struct vm_area_struct *vma,
>   * Return 0 (success) or a negative errno.
>   */
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> -		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
> +		const unsigned long opcode_vaddr, uprobe_opcode_t opcode,
> +		bool is_register)
>  {
> -	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode);
> +	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE,
> +			    verify_opcode, is_register);
>  }
>  
>  int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
> -		 uprobe_write_verify_t verify)
> +		 uprobe_write_verify_t verify, bool is_register)
>  {
>  	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct uprobe *uprobe;
> -	int ret, is_register, ref_ctr_updated = 0;
> +	int ret, ref_ctr_updated = 0;
>  	unsigned int gup_flags = FOLL_FORCE;
>  	struct mmu_notifier_range range;
>  	struct folio_walk fw;
>  	struct folio *folio;
>  	struct page *page;
>  
> -	is_register = is_swbp_insn(insn);
>  	uprobe = container_of(auprobe, struct uprobe, arch);
>  
>  	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
> @@ -569,7 +570,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  	/* Walk the page tables again, to perform the actual update. */
>  	if (folio_walk_start(&fw, vma, vaddr, 0)) {
>  		if (fw.page == page)
> -			ret = __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes);
> +			ret = __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes, is_register);
>  		folio_walk_end(&fw, vma);
>  	}
>  
> @@ -611,7 +612,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  int __weak set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		unsigned long vaddr)
>  {
> -	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN);
> +	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN, true);
>  }
>  
>  /**
> @@ -627,7 +628,7 @@ int __weak set_orig_insn(struct arch_uprobe *auprobe,
>  		struct vm_area_struct *vma, unsigned long vaddr)
>  {
>  	return uprobe_write_opcode(auprobe, vma, vaddr,
> -			*(uprobe_opcode_t *)&auprobe->insn);
> +			*(uprobe_opcode_t *)&auprobe->insn, false);
>  }
>  
>  /* uprobe should have guaranteed positive refcount */
> -- 
> 2.49.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

