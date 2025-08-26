Return-Path: <bpf+bounces-66550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E78AB36CEE
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 17:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840231C261D9
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012B211712;
	Tue, 26 Aug 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiQaRbw9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF381D63C7
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220089; cv=none; b=sj7JRnIasf9UXwmGFgNkRe1PzMtMVyQNeCe/L0JJSvXALyxkXVfNvhEiX8jpuYb7EslDCKnFhEJxeEHmxuWhzY6Xg5yczKahy0bPXxFBUIgZBdCeY5BULRa6U6+DDtl9awRIIJiMKSp4T5xCFq7RVfZxWIwcmXZMndxT+2t4vxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220089; c=relaxed/simple;
	bh=gznv7jTO/dXmXWK7Z1a49OO+38sK4Z9a0184zrqg55k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFAFF27TFGDLLTozn2pASk6KNVhTwYR8g/j0CrVo/3lZ/nqAEW4YdZXqP4rMmlJnjYP/2RAMmI7QaFtQuaestytykLtYldsFcqKyVBmcirdXZ2a3uxruRN8oNYiBmmBSBa2jTr8oCOS3UqDQIKaYpKId0lgN5UwctG65mvvRmBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiQaRbw9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c6ae25978bso2764718f8f.0
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756220085; x=1756824885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/+Vd/dLSKOiir7+3xpP05PdJWcnienu68FlO/hC5zw=;
        b=AiQaRbw9Lx0gN2dwBPrlG7oVDWP9qYuoU0mG74nEYK+XxPCkl3xi8dZ13EWU21fAm0
         MDz26+pd+O9ksxmfuCTZM89P0oKL+R3wZnCrZCPA7PFHn2aV8T1x0NAifRzizsnkaOWl
         YlZfR8Xoy3VgSBx5wZNxJxR/E+EzD8tR8lLO0CzPzDQ1DvvwJCo3YWiSDy+NUDynuVQe
         MGrHYOZGwBIXfF2CG0Zqh4DgCMgl6mblsSVw7tmMr96x190LekdLoj1BbxF+PhzUEFz0
         A6OWYdOt2chmi10pjEAwUaVryMKABhPmC4LLNgb8TsJ9aJ7M/Y0VyKwd2rvZYjKbzhbc
         oFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220085; x=1756824885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/+Vd/dLSKOiir7+3xpP05PdJWcnienu68FlO/hC5zw=;
        b=v+47o7BeDrU/dyU7F0fGguHqrDotA/QpGzV4ZSud6H2KdA85S2JIzRsIDe9r1zUlw6
         Kv02IvifWRo/5g0ZpZLSGy0upURFLePbWu+wXhjETokG4JTe8Fkd2F5BNpdTD/lSvzLV
         QRnSDIAmgRsh+V1iqeFmK4weOGcWYlV1hd6mniPfJ50LDlF/TCizE+n1QZKZvbRmrp1/
         g4v7vGBk3p+pZl/giuzdQTVGLjzP+xCtbXusQaAk2K+WPDQY/jGJbUHjTBtr/v3dSuDJ
         NZMF0OjJQu7WTM2vyyox6WD10dGGTvbq7WzyrU2qxFNePgUTNBRQ1R4UxOqyXxv8Rj2A
         jS0w==
X-Gm-Message-State: AOJu0YzAZUDqCrG5FiBl0mzyeXSsDwxCm9wa6fUl/1zrddVNHaJ/XEVx
	PLhwZepO6xPeBgG+5ydxeAffoIn+jrtfcOoxCgyl9PK+w+PFNdnfVurL
X-Gm-Gg: ASbGncsiuCVXItPkHJi7LbLnTyqPfymKQCAAOpTCvuF+u9+7TxhrsNWl57Mgb62JUog
	h+3luSRPqM2pXLOk8ty759pGCd41bq9XLxh4+4L+zBzWnOCAfCi9YZzncJ/z9tOPlLXaszOXZGS
	4P6cnawfwhH1henCMpYmCg9xScZLcGEnbkXhBqHmRduaAdFXEkTKPhk3CrHG9oOe9/2+GxozK5J
	bdkOONK/jMD1MjNc586isN/SohyXJa9PmrOwv305ojQHgHJfgIK5B+um1MWuF8veB8aN0XWXg8h
	2w57LPZuvduMvCWmxISVrCgR2O2HUuZ+Lsipfab7QSjbMV5/kFkzf1SroWzuWQp4vP66Jgo4lWk
	vwZb/lscCYkjuWTRCZ8mAPyGCj8wpVZBBEA==
X-Google-Smtp-Source: AGHT+IFm4zSPW3FKTmVFLCoCeRo/kv6BJFib/F1LFL4TrOw2TUvAG6o2f94+tXSjOE/zclGAiNjmUw==
X-Received: by 2002:a05:6000:24c3:b0:3b2:fe46:9812 with SMTP id ffacd0b85a97d-3c5db0ef2c5mr11571330f8f.19.1756220084627;
        Tue, 26 Aug 2025 07:54:44 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711212566sm16019835f8f.41.2025.08.26.07.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:54:43 -0700 (PDT)
Date: Tue, 26 Aug 2025 15:00:50 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 01/11] bpf: fix the return value of push_stack
Message-ID: <aK3MIpvcpbzhVGJF@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
 <20250816180631.952085-2-a.s.protopopov@gmail.com>
 <e485c7411db1661d181c238cfb5380b65a3c3ad7.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e485c7411db1661d181c238cfb5380b65a3c3ad7.camel@gmail.com>

On 25/08/25 11:12AM, Eduard Zingerman wrote:
> On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:
> 
> The change makes sense to me, please see a few comments below.
> 
> [...]
> 
> > @@ -2111,12 +2111,12 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
> >  	env->stack_size++;
> >  	err = copy_verifier_state(&elem->st, cur);
> >  	if (err)
> > -		return NULL;
> > +		return ERR_PTR(-ENOMEM);
> >  	elem->st.speculative |= speculative;
> >  	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
> >  		verbose(env, "The sequence of %d jumps is too complex.\n",
> >  			env->stack_size);
> > -		return NULL;
> > +		return ERR_PTR(-EFAULT);
> 
> Nit: this should be -E2BIG, I think.

I didn't want to change the set of return values. Agree that the
-E2BIG error looks better here, plus there's a corresponding verifier
message, so I will resend with -E2BIG.

Also agree with all your comments below, will address them in v2.

> >  	}
> >  	if (elem->st.parent) {
> >  		++elem->st.parent->branches;
> > @@ -2912,7 +2912,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
> >  
> >  	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
> >  	if (!elem)
> > -		return NULL;
> > +		return ERR_PTR(-ENOMEM);
> >  
> >  	elem->insn_idx = insn_idx;
> >  	elem->prev_insn_idx = prev_insn_idx;
> > @@ -2924,7 +2924,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
> >  		verbose(env,
> >  			"The sequence of %d jumps is too complex for async cb.\n",
> >  			env->stack_size);
> > -		return NULL;
> > +		return ERR_PTR(-EFAULT);
> 
> (and here too)
> 
> >  	}
> >  	/* Unlike push_stack() do not copy_verifier_state().
> >  	 * The caller state doesn't matter.
> 
> [...]
> 
> > @@ -14217,7 +14217,7 @@ sanitize_speculative_path(struct bpf_verifier_env *env,
> >  	struct bpf_reg_state *regs;
> >  
> >  	branch = push_stack(env, next_idx, curr_idx, true);
> > -	if (branch && insn) {
> > +	if (!IS_ERR(branch) && insn) {
> 
> Note: branch returned by `sanitize_speculative_path` is never used.
>       Maybe change the function to return `int` and do the regular
> 
>         err = sanitize_speculative_path()
>         if (err)
>       	   return err;
> 
>       thing here?
> 
> >  		regs = branch->frame[branch->curframe]->regs;
> >  		if (BPF_SRC(insn->code) == BPF_K) {
> >  			mark_reg_unknown(env, regs, insn->dst_reg);
> 
> [...]
> 
> > @@ -16721,8 +16720,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
> >  		 * execution.
> >  		 */
> >  		if (!env->bypass_spec_v1 &&
> > -		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
> > -					       *insn_idx))
> > +		    IS_ERR(sanitize_speculative_path(env, insn, *insn_idx + 1, *insn_idx)))
> >  			return -EFAULT;
> 
> I think the error code should be taken from the return value of the
> sanitize_speculative_path().
> 
> >  		if (env->log.level & BPF_LOG_LEVEL)
> >  			print_insn_state(env, this_branch, this_branch->curframe);
> > @@ -16734,9 +16732,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
> >  		 * simulation under speculative execution.
> >  		 */
> >  		if (!env->bypass_spec_v1 &&
> > -		    !sanitize_speculative_path(env, insn,
> > -					       *insn_idx + insn->off + 1,
> > -					       *insn_idx))
> > +		    IS_ERR(sanitize_speculative_path(env, insn,
> > +						     *insn_idx + insn->off + 1,
> > +						     *insn_idx)))
> 
> Same here.
> 
> >  			return -EFAULT;
> >  		if (env->log.level & BPF_LOG_LEVEL)
> >  			print_insn_state(env, this_branch, this_branch->curframe);
> 
> [...]

