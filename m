Return-Path: <bpf+bounces-61495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D994AAE76CA
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 08:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9528C189A523
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD55B1EEA5D;
	Wed, 25 Jun 2025 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWVuzxJJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB471E1DEC;
	Wed, 25 Jun 2025 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750831953; cv=none; b=AZqSi1qIqxH/8iO1mm6Vgd9k3E+/zfhc/4jP3INgPj6jTJxqWPEUVBEbRBa2+cIpYf8YlX+LNYdwqDa+u4u8hw2S9oiCHXUN9Mfq5EBm7hv51HKhJ1mW87HnuWb7dUYCDkQE7JtWZF7q9DOFoAcAMOV9x7+7MdYyTTDW5fzjumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750831953; c=relaxed/simple;
	bh=WCjFzatrX19NYcsnTaDdkH0qAtyIin0QHtX5HV2H+cw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WaR0mrOUZQM2Osi3rkuLMDC2kHzeg+iMLo78KRVMZ5kcg2IEJxDgZ7ipPMF+oTDQDy4njuOmWSJwagcAVlC2Z/0qCDrtggGr+ubMc1OMIDb4XTJPHZvKQa+zDHVX6zub8aHg46VErjxIR7lNVIvEufQycuyo+pUMdOMYi+G6/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWVuzxJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B72C4CEEA;
	Wed, 25 Jun 2025 06:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750831952;
	bh=WCjFzatrX19NYcsnTaDdkH0qAtyIin0QHtX5HV2H+cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PWVuzxJJAfOYhXBqCIrYu9xfnRB6JcrYEbwWlFfcHWK2apJie/uX9ISChmq4zwbHA
	 TUZxXxbWe9XnSn8viuKpn7p/Bi4Zbn5ZJ4TPR0mYI1E8paJZuQiQFJCvTuOkjTcSW5
	 +2rHJHLv1n0EWkMWf4lA+imHe1mL2/9JpgF7exwjHAUy18h6BepQexCaciZkBFEydS
	 EyO+ntm+92ES4cPOqBbjQJoIZv4QUcvDDeG84+IZ7T77eRRzduP4gw9bcf6DmP3qXk
	 h5VW0rPPHsSX1ge2kfjIRYtiB0qQU9+Fe033OmWLH/4gjexoFoOvwO6g6O69Hu2oni
	 wDRP+mJj4f5uQ==
Date: Wed, 25 Jun 2025 15:12:29 +0900
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
Subject: Re: [PATCHv3 perf/core 04/22] uprobes: Add uprobe_write function
Message-Id: <20250625151229.d3f11622884fd6f4f09c4f62@kernel.org>
In-Reply-To: <20250605132350.1488129-5-jolsa@kernel.org>
References: <20250605132350.1488129-1-jolsa@kernel.org>
	<20250605132350.1488129-5-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Jun 2025 15:23:31 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding uprobe_write function that does what uprobe_write_opcode did
> so far, but allows to pass verify callback function that checks the
> memory location before writing the opcode.
> 
> It will be used in following changes to implement specific checking
> logic for instruction update.
> 
> The uprobe_write_opcode now calls uprobe_write with verify_opcode as
> the verify callback.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  5 +++++
>  kernel/events/uprobes.c | 14 ++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 7447e15559b8..e13382054435 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -187,6 +187,9 @@ struct uprobes_state {
>  	struct xol_area		*xol_area;
>  };
>  
> +typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
> +				     uprobe_opcode_t *opcode);
> +
>  extern void __init uprobes_init(void);
>  extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
>  extern int set_orig_insn(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
> @@ -195,6 +198,8 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
>  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t);
> +extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
> +			uprobe_opcode_t opcode, uprobe_write_verify_t verify);
>  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
>  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 37d3a3f6e48a..777de9b95dd7 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -399,7 +399,7 @@ static bool orig_page_is_identical(struct vm_area_struct *vma,
>  	return identical;
>  }
>  
> -static int __uprobe_write_opcode(struct vm_area_struct *vma,
> +static int __uprobe_write(struct vm_area_struct *vma,
>  		struct folio_walk *fw, struct folio *folio,
>  		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
>  {
> @@ -488,6 +488,12 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
>   */
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
> +{
> +	return uprobe_write(auprobe, vma, opcode_vaddr, opcode, verify_opcode);
> +}
> +
> +int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> +		 const unsigned long opcode_vaddr, uprobe_opcode_t opcode, uprobe_write_verify_t verify)
>  {
>  	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -510,7 +516,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  	 * page that we can safely modify. Use FOLL_WRITE to trigger a write
>  	 * fault if required. When unregistering, we might be lucky and the
>  	 * anon page is already gone. So defer write faults until really
> -	 * required. Use FOLL_SPLIT_PMD, because __uprobe_write_opcode()
> +	 * required. Use FOLL_SPLIT_PMD, because __uprobe_write()
>  	 * cannot deal with PMDs yet.
>  	 */
>  	if (is_register)
> @@ -522,7 +528,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		goto out;
>  	folio = page_folio(page);
>  
> -	ret = verify_opcode(page, opcode_vaddr, &opcode);
> +	ret = verify(page, opcode_vaddr, &opcode);
>  	if (ret <= 0) {
>  		folio_put(folio);
>  		goto out;
> @@ -561,7 +567,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  	/* Walk the page tables again, to perform the actual update. */
>  	if (folio_walk_start(&fw, vma, vaddr, 0)) {
>  		if (fw.page == page)
> -			ret = __uprobe_write_opcode(vma, &fw, folio, opcode_vaddr, opcode);
> +			ret = __uprobe_write(vma, &fw, folio, opcode_vaddr, opcode);
>  		folio_walk_end(&fw, vma);
>  	}
>  
> -- 
> 2.49.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

