Return-Path: <bpf+bounces-61498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A3AE7752
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 08:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103817B330C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 06:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9F21F4199;
	Wed, 25 Jun 2025 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md+iA8c4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B899130E58;
	Wed, 25 Jun 2025 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833784; cv=none; b=OhPodnwXgTBTOc6Rez2BBGrK54Od51+b5ZKdXgGaMMRmtxD005+ym+Rl+K136TMh4irdmhGihURqZn25y5vkz9bq5V1WTeT6hL8eauL/1mxnNm4fQTm8txljD98gdIvcLi2Mqe2IsQx79rdwQc3kMUTw86E7G6GsjokL66CX0+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833784; c=relaxed/simple;
	bh=PRlpk37/wc9ny9ve8FZTnggThRtsG0Xhz9V7yFY7eD0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Uec9bh6I/xFtVFfMgGRkVQFd6pqQH3v3ArnILzQfBau26NH1F12WLX1ItarIVHaUbqy2T5yCE9NVihiHbwcQZn0wTWq2Q6Pl4aAMkziUYHx1abGH4TtFpAtjEod9cXeYmPyi1tmyeE1r0SLhghdpTb/Et7whao1zq09qYtbVVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md+iA8c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A83C4CEEE;
	Wed, 25 Jun 2025 06:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750833783;
	bh=PRlpk37/wc9ny9ve8FZTnggThRtsG0Xhz9V7yFY7eD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=md+iA8c4659PKGJbiD0k4w8wWR2ca+p7bpj/ygvzR6boXMUtJVqbms2nJDKFiem0S
	 VPRoNlkOzCTmzr8zwZsG6TeeYjsJCPOA+uqKzS8Bz8G6akyA4D+HWPJ3gzoAKg5MMS
	 CGANDupbgKgn4XS5daBIxe3EJ03rPv6Wt1jrtXud5K95RAUocRbzM8r6ywbJ8F4m6y
	 /Bwyg5GQB2HdGyC1qkBJOY/VK5WwhDnIEQ/qYrRo1nJrGIEbZkDxdKmDe81552vIhX
	 xsH5PweOxLSbVpmf7hgo2U0k8bzXazppTjmnBx5xSopGXtWih37cg1bEvwj1mCqaQ5
	 PItrrWUnrIuPw==
Date: Wed, 25 Jun 2025 15:42:59 +0900
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
Subject: Re: [PATCHv3 perf/core 07/22] uprobes: Add do_ref_ctr argument to
 uprobe_write function
Message-Id: <20250625154259.4a092f0213739404a0e9b210@kernel.org>
In-Reply-To: <20250605132350.1488129-8-jolsa@kernel.org>
References: <20250605132350.1488129-1-jolsa@kernel.org>
	<20250605132350.1488129-8-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Jun 2025 15:23:34 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Making update_ref_ctr call in uprobe_write conditional based
> on do_ref_ctr argument. This way we can use uprobe_write for
> instruction update without doing ref_ctr_offset update.
> 

Can we just decouple this update from uprobe_write()?
If we do this exclusively, I think we can do something like;

lock()
update_ref_ctr(uprobe, mm, +1);
...
ret = uprobe_write();
...
if (ret < 0)
  update_ref_ctr(uprobe, mm, -1);
unlock()

Thank you,


> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h | 2 +-
>  kernel/events/uprobes.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 518b26756469..5080619560d4 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -200,7 +200,7 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t,
>  			       bool is_register);
>  extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
> -			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register);
> +			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr);
>  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
>  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 1e5dc3b30707..6795b8d82b9c 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -492,12 +492,12 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		bool is_register)
>  {
>  	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE,
> -			    verify_opcode, is_register);
> +			    verify_opcode, is_register, true /* do_update_ref_ctr */);
>  }
>  
>  int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
> -		 uprobe_write_verify_t verify, bool is_register)
> +		 uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr)
>  {
>  	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
>  	struct mm_struct *mm = vma->vm_mm;
> @@ -538,7 +538,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  	}
>  
>  	/* We are going to replace instruction, update ref_ctr. */
> -	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
> +	if (do_update_ref_ctr && !ref_ctr_updated && uprobe->ref_ctr_offset) {
>  		ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
>  		if (ret) {
>  			folio_put(folio);
> @@ -590,7 +590,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  
>  out:
>  	/* Revert back reference counter if instruction update failed. */
> -	if (ret < 0 && ref_ctr_updated)
> +	if (do_update_ref_ctr && ret < 0 && ref_ctr_updated)
>  		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
>  
>  	/* try collapse pmd for compound page */
> -- 
> 2.49.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

