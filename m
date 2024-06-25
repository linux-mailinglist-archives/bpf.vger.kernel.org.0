Return-Path: <bpf+bounces-32978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD65915B77
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11201B20314
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 01:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B158D2744A;
	Tue, 25 Jun 2024 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqhoR+/2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32378DDC3;
	Tue, 25 Jun 2024 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277361; cv=none; b=ndTk7MTeDRFbkubauoyGxmQgSUK+5/YCkNsC9Y7BUKpUOzjia4ToPdjjMi/uOJQFJBPlsYzmeoaOap0OvvWB1OEfzVzcFjppoe6dyr4uAghZqK3py84XL9xdIKdWE67KyzvVdc9zG34cKvHqGPwm3xJbQTaa7gSUfijrREtv3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277361; c=relaxed/simple;
	bh=cNul+CjnJxu3p3xp/0OzfRTbo9IvW9F4g1jY4fo1kbo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=spIJL9enMDTvicMt9VnERWzFtohIaPUcp/hYFCeCXgZyb9QuodkSZvd99hdcSTnXYJpry/wlKqOGmjuuqJsAEr2ZBf2MjBkS2uLb9TYkC2BQQ/et3vRZi4rfh0uYKJSBZb9dLltiwKnJV4wQFaH2Bz2G4/tiqER8X9CxSA3hFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqhoR+/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92978C2BBFC;
	Tue, 25 Jun 2024 01:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719277361;
	bh=cNul+CjnJxu3p3xp/0OzfRTbo9IvW9F4g1jY4fo1kbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UqhoR+/20BMq9LaSp6XFqCeZxDTtbqSbcPPKxxa5hVmdOiz1GVe50eNnE6vxvL6Pc
	 Zc5fUXT5iCti8oNmbc1OACdSTeg0rCNNVpLuPTo7O1eaHszmQf0bsOP/QNPCxJKi23
	 mHwtpRhauwSgwFGm1RycHC3KI017gMzNJYAPlixFnQgrR9DkDy0NO3H4/+dc6bP6gg
	 WOdHvlnewPBxeo8HBBlc/BNqbrBxugeUBO+C+RZXIT/hsj6qPnbM0ceoWouQ6DCgNR
	 R6okR5hZ/ffqzglPjauaw0uLQkBwyl0hl3MyoOzi9uXoutseq84xuoy3sqnxgbfr89
	 nZdjjSF9W6Xpw==
Date: Tue, 25 Jun 2024 10:02:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, x86@kernel.org,
 peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
 bpf@vger.kernel.org, rihams@fb.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/4] uprobes: rename get_trampoline_vaddr() and make
 it global
Message-Id: <20240625100236.75d923b42d1bcf5a2f15fb9b@kernel.org>
In-Reply-To: <20240522013845.1631305-2-andrii@kernel.org>
References: <20240522013845.1631305-1-andrii@kernel.org>
	<20240522013845.1631305-2-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 May 2024 18:38:42 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> This helper is needed in another file, so make it a bit more uniquely
> named and expose it internally.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Sorry, I think this conflicts with

https://lore.kernel.org/all/20240611112158.40795-4-jolsa@kernel.org/

And that is already picked.

Thanks,

> ---
>  include/linux/uprobes.h | 1 +
>  kernel/events/uprobes.c | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index f46e0ca0169c..0c57eec85339 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -138,6 +138,7 @@ extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
>  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
>  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>  					 void *src, unsigned long len);
> +extern unsigned long uprobe_get_trampoline_vaddr(void);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 8ae0eefc3a34..d60d24f0f2f4 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1827,7 +1827,7 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
>   *
>   * Returns -1 in case the xol_area is not allocated.
>   */
> -static unsigned long get_trampoline_vaddr(void)
> +unsigned long uprobe_get_trampoline_vaddr(void)
>  {
>  	struct xol_area *area;
>  	unsigned long trampoline_vaddr = -1;
> @@ -1878,7 +1878,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
>  	if (!ri)
>  		return;
>  
> -	trampoline_vaddr = get_trampoline_vaddr();
> +	trampoline_vaddr = uprobe_get_trampoline_vaddr();
>  	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
>  	if (orig_ret_vaddr == -1)
>  		goto fail;
> @@ -2187,7 +2187,7 @@ static void handle_swbp(struct pt_regs *regs)
>  	int is_swbp;
>  
>  	bp_vaddr = uprobe_get_swbp_addr(regs);
> -	if (bp_vaddr == get_trampoline_vaddr())
> +	if (bp_vaddr == uprobe_get_trampoline_vaddr())
>  		return handle_trampoline(regs);
>  
>  	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

