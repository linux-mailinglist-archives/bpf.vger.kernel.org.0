Return-Path: <bpf+bounces-76837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4134CC6A26
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 375C9309B34C
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABAC338912;
	Wed, 17 Dec 2025 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThEIaek3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910623358BF
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765960822; cv=none; b=N0rC1e6cSB/aQPkje2FWDfzM4vcpwPAcNv67P36Phn9JW3S8hGDOTxBwB8afXvzJW4P4To3yjIGC2XMP9oD7juoigDjK7wa8QX65qC43j9Tg5O7vjO4d32AgHvNnWVq7HEJXxO8bkSOk2wiKSxE1tXHAwBIk+ODOmk248kx9ki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765960822; c=relaxed/simple;
	bh=mdjEHEEPLujhO8mEKW8YB3oPGh1bwWoJcPHXtpbySKU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLbxR/Unnd+0NyjUlTdBkoNpZYkTYWML/w6SNDEKyYh95p1t+yPaN/RJOZIsdv5OlFnbf8rO5mDxi9Jvomc1IRE7Y97yZ5Jwqt7VePwm34JhW3/UUizvZhoEbv0OOzFGBRH4D9M3lAaCPT4czOxaGkk1NojKv5PaE8LBx2gHpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThEIaek3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2e628f8aso2345279f8f.1
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 00:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765960819; x=1766565619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WyEicKDWvbOdhrtnqhenW6ok8Fe3+pewjhCT1n7IggM=;
        b=ThEIaek3qs670NMoXFfNLMBP8MIKjIvv+QJnmIAf02cVLRln7GQmswR0e9J+MYa+XA
         7RAgEkdMjJziSkFFV2SQtpkJDAKUtULKyL/6JCUcFLVTxyCroQwOvRJnTESROPs07f+7
         EXflPviKMy9rrteLwi/N0M4fZ3/lb5mecSOUAryP2UEd2R9dJoerh7Zh55xhB/fQ64y6
         8d6skOrSBcimXkeEF5CfUjfmApN82k0A9OZfeQS7PpX0pF9GtmL6K+WS5tkv2a3gXgrJ
         sH7DpIL89z234P95c355ol3EA6Z5vF/Kl9T+azdZBlbCfCekDzpcqB61ENhqK33BtQqO
         5lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765960819; x=1766565619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyEicKDWvbOdhrtnqhenW6ok8Fe3+pewjhCT1n7IggM=;
        b=SfMrCteZ1Bz8Z9Udq9719Q+TpqxqthiPB9ZQ1XINu3lzBP8x+XyGzy/RElTqhfnffu
         yCeD5S2l/Gq9fF10e8fW8gVsCgK6XGnvrbk0Dy1dKCkngwNQNg69y/0jEhVZjOJwbbF6
         12UFGW/rVcGoBKrQEHdV2V5seb862bqNoNeklnFSRNqKWyQhNFW7Mbt0Q9IYLqoCbhHo
         06Jkf8HrT2vt8T8M9g0krtle30a/9FrzE1X3dVI1YG90LA/D396gH7H6uMA5tCV+oUsr
         gQCuBCL6NR29SQWLV5reVifLtZYK0m+BhKI2/9vnT3ECrSVCyrwQGYttn5Ho2x1XlrpA
         +l7w==
X-Forwarded-Encrypted: i=1; AJvYcCWFqzNfKWy/0ng3MaYhEUiMC8kRGIVj9ZHh6iwEhNdNV+4FwTJrS+7SZ9qmLmrjAH66Ew8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBtECnioLH65teDT76bZ+rv2Bn9P7eCFY3N/OtLSDNq//dN0N
	q7fH38XcloCiDJA4YBLpjU/06WuQ6QDuIoNdQ7mtPYzQkwfftTc6YKN6
X-Gm-Gg: AY/fxX5HoApOW2MTLXqGfuhW0T/8LwzTbqVghU0VqBHhUu4kvskLkKX0gjPe427bVsq
	7kEnDTi6mHUoIrJeT5dSTvUbxb+T1in7rNEBDu/8rGiLdNwWJ0rQkU0DsWUv7t57MLZLW06wxaW
	tFH2J7tNrWgCmY7WHlAWSs+l88iVTVQe+Ob79DzW9MxRWtE0LgKywgINNx/RzHm08CVtMCzWXnb
	KPwXhB02GXHnGga6IOeo6SaYGkqrz4NOnfVj+60tpYrKyuvSj2V/9KsfPYXgrOyY4EfzZsPA/G5
	tA8Z5efCG+B0hOArKLVN+/pYqJm2pARc5n/9+JJdQocWzE9/DVTrLT3yRQmC4x2aj7375u0S8BG
	BA1qS8avDBSawJY/zxxDaOmCMet2GcxM7I3iMS++5kSD7B7kUA55AuvuZNAfahpASKp01B2qjjs
	hC1lE4o83fpw==
X-Google-Smtp-Source: AGHT+IGoh419rwOYueEWLJrPRU9q7UxlpRrhqIOwtlvWqYF627uT3OFlm5Gvl02pYhi1ZP6rxwR5NA==
X-Received: by 2002:a05:6000:26cd:b0:431:35a:4a97 with SMTP id ffacd0b85a97d-431035a4dcdmr5954508f8f.59.1765960818614;
        Wed, 17 Dec 2025 00:40:18 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adacfbbsm3637780f8f.12.2025.12.17.00.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 00:40:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 17 Dec 2025 09:40:15 +0100
To: bot+bpf-ci@kernel.org
Cc: rostedt@kernel.org, revest@google.com, mark.rutland@arm.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, menglong8.dong@gmail.com,
	song@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 1/9] ftrace,bpf: Remove FTRACE_OPS_FL_JMP
 ftrace_ops flag
Message-ID: <aUJsb2up5zHDfIpC@krava>
References: <20251215211402.353056-2-jolsa@kernel.org>
 <95c13c0b793604796037ca67c191e1bfce22770dd020107c7179a698c5d49b91@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95c13c0b793604796037ca67c191e1bfce22770dd020107c7179a698c5d49b91@mail.kernel.org>

On Mon, Dec 15, 2025 at 09:31:51PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 015dd1049bea..505b7d3f5641 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 976d89011b15..b9a358d7a78f 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -214,10 +214,15 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
> >  	int ret;
> >
> >  	if (tr->func.ftrace_managed) {
> > +		unsigned long addr = (unsigned long) new_addr;
> > +
> > +		if (bpf_trampoline_use_jmp(tr->flags))
> > +			addr = ftrace_jmp_set(addr);
> > +
> >  		if (lock_direct_mutex)
> > -			ret = modify_ftrace_direct(tr->fops, (long)new_addr);
> > +			ret = modify_ftrace_direct(tr->fops, addr);
> >  		else
> > -			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
> > +			ret = modify_ftrace_direct_nolock(tr->fops, addr);
> >  	} else {
> >  		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
> >  						   new_addr);
> > @@ -240,10 +245,15 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
> >  	}
> >
> >  	if (tr->func.ftrace_managed) {
> > +		unsigned long addr = (unsigned long) new_addr;
> > +
> > +		if (bpf_trampoline_use_jmp(tr->flags))
> > +			addr = ftrace_jmp_set(addr);
> > +
> >  		ret = ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
> >  		if (ret)
> >  			return ret;
> > -		ret = register_ftrace_direct(tr->fops, (long)new_addr);
> > +		ret = register_ftrace_direct(tr->fops, addr);
> >  	} else {
> >  		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
> >  	}
> 
> After this change, register_ftrace_direct() receives an address with
> the LSB bit already set (via ftrace_jmp_set) and stores it as-is in
> entry->direct. This address then flows through to ftrace_find_rec_direct()
> which returns entry->direct unchanged.
> 
> In available_filter_functions_show():

hum, there's no such function.. AFAICS it's t_show called through
ftrace_avail_fops->ftrace_avail_open->show_ftrace_seq_ops

> 
>     direct = ftrace_find_rec_direct(rec->ip);
>     if (direct)
>         seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
> 

but yep, it's related problem, that Menglong said he will address in
separate patch

thanks,
jirka

> Can the debug output show misleading symbol offsets? When the LSB is
> set, %pS will resolve addresses like "function+0x1" instead of just
> "function". This makes ftrace debug output harder to read for users
> trying to understand direct call attachments.
> 
> The fix would be to strip the LSB bit before printing:
>     seq_printf(m, "\n\tdirect-->%pS", (void *)ftrace_jmp_get(direct));
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index bbb37c0f8c6c..b0dc911411f1 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6017,15 +6017,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  	if (ftrace_hash_empty(hash))
> >  		return -EINVAL;
> >
> > -	/* This is a "raw" address, and this should never happen. */
> > -	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
> > -		return -EINVAL;
> > -
> >  	mutex_lock(&direct_mutex);
> >
> > -	if (ops->flags & FTRACE_OPS_FL_JMP)
> > -		addr = ftrace_jmp_set(addr);
> > -
> >  	/* Make sure requested entries are not already registered.. */
> >  	size = 1 << hash->size_bits;
> >  	for (i = 0; i < size; i++) {
> 
> [ ... ]
> 
> > @@ -6146,13 +6139,6 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >
> >  	lockdep_assert_held_once(&direct_mutex);
> >
> > -	/* This is a "raw" address, and this should never happen. */
> > -	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
> > -		return -EINVAL;
> > -
> > -	if (ops->flags & FTRACE_OPS_FL_JMP)
> > -		addr = ftrace_jmp_set(addr);
> > -
> >  	/* Enable the tmp_ops to have the same functions as the direct ops */
> >  	ftrace_ops_init(&tmp_ops);
> >  	tmp_ops.func_hash = ops->func_hash;
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20247816064


