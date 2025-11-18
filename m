Return-Path: <bpf+bounces-74839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3707AC66D2A
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 02:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D19474E2328
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BC330C63B;
	Tue, 18 Nov 2025 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O69nt2gG"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C228C866;
	Tue, 18 Nov 2025 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428854; cv=none; b=tYMsKwIuTUzMM+lH+e8ETWa6fCugaACp5Mz15gBv+yyf7TR3CB/GlxA1FS9cmCHCge2bOqze9xE0EgTixtnzO67B7nwWW85DKhR9KSFt2rA0u4TvZhoIyeKe6zgaQqHFTh6tG/v7B4rEfSD7FU6CGB1iNHuENuT9G0Xx4KwFBUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428854; c=relaxed/simple;
	bh=ksPhFiYiWAS4Howtkeo3jSAl6Eyjb9vtA0YhuMynw8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVBggHUWb4jhSzyBDfMRlhZqcIr5+EsIxoNFrSn7Exg7v2JcTqz+A/p1H1xWz0Hqv3MTyB9wCOMHj6bf69uZnBgtHaPSD2B+L+HYbtGpAfbCvxNG9vyiZlOkpcA1qbyTYL87Whe0YDYDGqYKQeyrKIbprkqkTJ8JcfwS2GnCKLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O69nt2gG; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763428845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WLsdv85RrOb9Dlejp4arhbuTs7ghpPeNtpFV4Kv4wj8=;
	b=O69nt2gG+mFmtdnQbfYxYQUsgL2cpVE/3wz1NMKwcvhIzw392QdO0BMklx0TCL8uO18T6I
	IFQj7/sxxwnCzBIP7ILFiRm+BRu2zVORlbXwpNH57ru10WGVVMbzg7EKtAJM/or88KSAzR
	abNQD7zavFZHcd9PvGwfZ9UrqluY04Y=
From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org, rostedt@goodmis.org,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, jiang.biao@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 6/6] bpf: implement "jmp" mode for trampoline
Date: Tue, 18 Nov 2025 09:20:32 +0800
Message-ID: <12782324.O9o76ZdvQC@7950hx>
In-Reply-To: <20251117034906.32036-7-dongml2@chinatelecom.cn>
References:
 <20251117034906.32036-1-dongml2@chinatelecom.cn>
 <20251117034906.32036-7-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/17 11:49, Menglong Dong wrote:
> Implement the "jmp" mode for the bpf trampoline. For the ftrace_managed
> case, we need only to set the FTRACE_OPS_FL_JMP on the tr->fops if "jmp"
> is needed.
> 
> For the bpf poke case, we will check the origin poke type with the
> "origin_flags", and current poke type with "tr->flags". The function
> bpf_trampoline_update_fentry() is introduced to do the job.
> 
> The "jmp" mode will only be enabled with CONFIG_DYNAMIC_FTRACE_WITH_JMP
> enabled and BPF_TRAMP_F_SHARE_IPMODIFY is not set. With
> BPF_TRAMP_F_SHARE_IPMODIFY, we need to get the origin call ip from the
> stack, so we can't use the "jmp" mode.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - rename bpf_text_poke to bpf_trampoline_update_fentry
> - remove the BPF_TRAMP_F_JMPED and check the current mode with the origin
>   flags instead.
> ---
>  kernel/bpf/trampoline.c | 68 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 51 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 2dcc999a411f..80ab435d6e00 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -175,24 +175,42 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
>  	return tr;
>  }
>  
> -static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
> +static int bpf_trampoline_update_fentry(struct bpf_trampoline *tr, u32 orig_flags,
> +					void *old_addr, void *new_addr)
>  {
> +	enum bpf_text_poke_type new_t = BPF_MOD_CALL, old_t = BPF_MOD_CALL;
>  	void *ip = tr->func.addr;
> +
> +	if (!new_addr)
> +		new_t = BPF_MOD_NOP;
> +	else if (bpf_trampoline_use_jmp(tr->flags))
> +		new_t = BPF_MOD_JUMP;
> +
> +	if (!old_addr)
> +		old_t = BPF_MOD_NOP;
> +	else if (bpf_trampoline_use_jmp(orig_flags))
> +		old_t = BPF_MOD_JUMP;
> +
> +	return bpf_arch_text_poke(ip, old_t, new_t, old_addr, new_addr);
> +}
> +
> +static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
> +			     void *old_addr)
> +{
>  	int ret;
>  
>  	if (tr->func.ftrace_managed)
>  		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
>  	else
> -		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, BPF_MOD_NOP,
> -					 old_addr, NULL);
> +		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, NULL);
>  
>  	return ret;
>  }
>  
> -static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_addr,
> +static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
> +			 void *old_addr, void *new_addr,
>  			 bool lock_direct_mutex)
>  {
> -	void *ip = tr->func.addr;
>  	int ret;
>  
>  	if (tr->func.ftrace_managed) {
> @@ -201,10 +219,8 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
>  		else
>  			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
>  	} else {
> -		ret = bpf_arch_text_poke(ip,
> -					 old_addr ? BPF_MOD_CALL : BPF_MOD_NOP,
> -					 new_addr ? BPF_MOD_CALL : BPF_MOD_NOP,
> -					 old_addr, new_addr);
> +		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
> +						   new_addr);
>  	}
>  	return ret;
>  }
> @@ -229,8 +245,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>  			return ret;
>  		ret = register_ftrace_direct(tr->fops, (long)new_addr);
>  	} else {
> -		ret = bpf_arch_text_poke(ip, BPF_MOD_NOP, BPF_MOD_CALL,
> -					 NULL, new_addr);
> +		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
>  	}
>  
>  	return ret;
> @@ -416,7 +431,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  		return PTR_ERR(tlinks);
>  
>  	if (total == 0) {
> -		err = unregister_fentry(tr, tr->cur_image->image);
> +		err = unregister_fentry(tr, orig_flags, tr->cur_image->image);
>  		bpf_tramp_image_put(tr->cur_image);
>  		tr->cur_image = NULL;
>  		goto out;
> @@ -440,9 +455,17 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  again:
> -	if ((tr->flags & BPF_TRAMP_F_SHARE_IPMODIFY) &&
> -	    (tr->flags & BPF_TRAMP_F_CALL_ORIG))
> -		tr->flags |= BPF_TRAMP_F_ORIG_STACK;
> +	if (tr->flags & BPF_TRAMP_F_CALL_ORIG) {
> +		if (tr->flags & BPF_TRAMP_F_SHARE_IPMODIFY) {
> +			tr->flags |= BPF_TRAMP_F_ORIG_STACK;
> +		} else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_JMP)) {
> +			/* Use "jmp" instead of "call" for the trampoline
> +			 * in the origin call case, and we don't need to
> +			 * skip the frame.
> +			 */
> +			tr->flags &= ~BPF_TRAMP_F_SKIP_FRAME;
> +		}
> +	}
>  #endif
>  
>  	size = arch_bpf_trampoline_size(&tr->func.model, tr->flags,
> @@ -473,10 +496,16 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  	if (err)
>  		goto out_free;
>  
> +	if (bpf_trampoline_use_jmp(tr->flags))
> +		tr->fops->flags |= FTRACE_OPS_FL_JMP;
> +	else
> +		tr->fops->flags &= ~FTRACE_OPS_FL_JMP;

This should be wrapped by "#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP".
I'll change it in v3 after more human comments.

> +
>  	WARN_ON(tr->cur_image && total == 0);
>  	if (tr->cur_image)
>  		/* progs already running at this address */
> -		err = modify_fentry(tr, tr->cur_image->image, im->image, lock_direct_mutex);
> +		err = modify_fentry(tr, orig_flags, tr->cur_image->image,
> +				    im->image, lock_direct_mutex);
>  	else
>  		/* first time registering */
>  		err = register_fentry(tr, im->image);
> @@ -499,8 +528,13 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  	tr->cur_image = im;
>  out:
>  	/* If any error happens, restore previous flags */
> -	if (err)
> +	if (err) {
>  		tr->flags = orig_flags;
> +		if (bpf_trampoline_use_jmp(tr->flags))
> +			tr->fops->flags |= FTRACE_OPS_FL_JMP;
> +		else
> +			tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
> +	}
>  	kfree(tlinks);
>  	return err;
>  
> 





