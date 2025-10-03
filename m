Return-Path: <bpf+bounces-70278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3136BB6040
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 08:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72621AE0038
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 06:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34D621B9F5;
	Fri,  3 Oct 2025 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gglfRpHG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7B1F461D
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474700; cv=none; b=EAc1sVeOoBW+AZbtHEoEGzE27d/PKsn0RsmBZWcDrGBjz0ToIs/3dUDBrEpGhqd+bkpYhpGKpjVPlo3JG9/dQFb/0FVBnl+ZJxeNns695XSilpGqkT1esOIk6VZRJwhiQnC9njAGA0wRJZ9lJmEhE3G+ClQhlbZPlTddSoJif0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474700; c=relaxed/simple;
	bh=zfD/J3RrKsw0qXwYSjF9oWtzLDjffzOEQRj3wrblaOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJ1n1Pw/CPeoXiVl1ZDYEvoGpjzLiXkSinoHkc+sHOI7qpOGotIljXJQnwbx5lT2tw+pUYp15m+PXRa8QpioAZA2l0rEpEMAI5DPOIu6jh591aODNOaM71sHd1kZ4BK+8uZUvSC5ZEN0Rfda73gnO39ZvbQUoxXF3P8Fj7UcQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gglfRpHG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e5980471eso8845685e9.2
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 23:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759474697; x=1760079497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQAqvlY5+aYwfbmYe8jSHDkxNEgvXylUiP+ROeYmPVQ=;
        b=gglfRpHGPvphZb+gQ6j3uI7hta15sq2gZ5VQ1qjLcTVoRVsKl/9k2QC4cKTJUv5IqG
         hWiVGt2HcfnJLXW6SaOXIhHu2eN81WTfTzBt2d41/ZEZkZDgj58AveJN7fS85M58qR4e
         cexDrWXrm49UWjlUhQoZmJkJ/NSOJZX6WtGLtbOENF62UBTQwJptWFaQ1eU6FJweNekw
         MB4/N/p25KP4km3qhHa9Sg5d/jxsv66DlKXHUS4rJ4X25x8O7O5IZMsJQjvBG6w9yPzJ
         Hbzb/2/SijVPsbwBhKEqLjLEkGxzQAgdaAqmiyO26YymXGrnAB3yEaBD+1PbsX9XXuL4
         Wjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759474697; x=1760079497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQAqvlY5+aYwfbmYe8jSHDkxNEgvXylUiP+ROeYmPVQ=;
        b=lylan9XX6pXaxy9AdaZ7uYu1gScTTlT4P3JurpVwxuGEnH2l0yKAGZr6+Ki5SjqCkr
         367NoUbTsvUJT+JTI//hWdPXsbpidCyvhj08bmKDqmI8qIwq3PHZkjTPikAhjDmRxMzU
         l+qoDsbBvuEDpqDiy08o/cSUAtJw58NJ0+mkbWqr1zuhJknYGyoxqafLyLeaLHqsFOyB
         8h0srdJn0V7aGkdFHVkOl48JC/ev/lSb1C5OAQK7qLtNh0lGOVB5tYwVuHidtXShleXX
         cZNOc6fT/4m2MO82gfmre3xmZfHIi20p1aZ7SMDkjCJHHnegp9n0ZguJuOqZK1poTzev
         8aew==
X-Gm-Message-State: AOJu0Yx+PsAB1Q0xKNeEyRmaYQayt+KVXxMSSGfTALptbW9vhPEhKEwY
	u/IzV1FekQFn1+Jxv/JzR9zuKij4X5i5FFSB0R1P33SGXe5Q1prfUkfLIpZEEg==
X-Gm-Gg: ASbGncstyAQBH2N5n/ZHxnOr8qayNXWJv1ea/eaFWb6jx1vjU9O561DAiQrypQBxYKM
	nJtqHfZI6GEtLYdi+7vDLPj1Binxpz2YPnO5I40JBKnTE6GsuscGilCJMvQq8wRfH5GGeck8+wB
	AUymEulvoJhO2BJ7f7ICY7dq3EveRw8XwKW1LFehgImAGnHtUZ38mgcUOZuZ1sh/teEakT4/sAC
	KjE+l5kQ7/1dO1qLlrmtNNkwVXH2A5wi6ccFB5XNZ1JntUQ27fokXfHr0pixQzdLb1oPnUUK4Ue
	vQKH7enswjk1MhTE07JH5lRNiw7ECbhImF5oxSlHDDwmGJYD6oSkyVub5/WA2WrKZOrZ7+2Qatv
	LhEjVASSqSp8/W2hN5k9sSePaLlgoT+Nt+c9iqU4ElcFD0FnX2N9J4TH79o0SyHZif8E=
X-Google-Smtp-Source: AGHT+IEDOJ2ubq7gs9vb9vY2olkWJDIr0cPO8tsXOodl/EvpD9FOCKjpbXAH/3dd1nTPKmCqQXJTgQ==
X-Received: by 2002:a05:600c:8209:b0:46e:345d:dfde with SMTP id 5b1f17b1804b1-46e7110a000mr12854715e9.16.1759474696357;
        Thu, 02 Oct 2025 23:58:16 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b633afdsm72197915e9.2.2025.10.02.23.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 23:58:15 -0700 (PDT)
Date: Fri, 3 Oct 2025 07:04:33 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v5 bpf-next 10/15] bpf, x86: add support for indirect
 jumps
Message-ID: <aN91gcBNptvX6wQJ@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-11-a.s.protopopov@gmail.com>
 <8143e0481d68bb1793464c2d796fce7602695076.camel@gmail.com>
 <aN5FcYKFLMV44igw@mail.gmail.com>
 <f25e1970100d4d39572839e86bbed0fa819d7a05.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25e1970100d4d39572839e86bbed0fa819d7a05.camel@gmail.com>

On 25/10/02 12:52PM, Eduard Zingerman wrote:
> On Thu, 2025-10-02 at 09:27 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> > > > @@ -14685,6 +14723,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
> > > >  				dst);
> > > >  			return -EACCES;
> > > >  		}
> > > > +		if (ptr_to_insn_array) {
> > > > +			verbose(env, "R%d subtraction from pointer to instruction prohibited\n",
> > > > +				dst);
> > > > +			return -EACCES;
> > > > +		}
> > > 
> > > Is anything going to break if subtraction is allowed?
> > > The bounds are still maintained, so seem to be ok.
> > 
> > Ok, I just haven't seen any reason to add because such code
> > is not generated on practice. I will add in the next version.
> 
> Just less code and less tests if there is no special case.
> 
> [...]
> 
> > > > @@ -17786,6 +17830,210 @@ static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
> > > >  	return new;
> > > >  }
> > > >  
> > > > +#define SET_HIGH(STATE, LAST)	STATE = (STATE & 0xffffU) | ((LAST) << 16)
> > > > +#define GET_HIGH(STATE)		((u16)((STATE) >> 16))
> > > > +
> > > > +static int push_gotox_edge(int t, struct bpf_verifier_env *env, struct bpf_iarray *jt)
> > > > +{
> > > > +	int *insn_stack = env->cfg.insn_stack;
> > > > +	int *insn_state = env->cfg.insn_state;
> > > > +	u16 prev;
> > > > +	int w;
> > > > +
> > > 
> > > push_insn() checks if `t` is in range [0, env->prog->len],
> > > is the same check needed here?
> > 
> > You wanted to say `w`? (I think `t` is guaranteed to be a valid one.)
> > In cas of push_gotox_edge `w` is taken from a jump table which is
> > guaranteed to have only correct instructions.
> 
> Yes, I meant `w`, sorry.
> So, the invalid offsets would be rejected at map construction time?
> I'd put a check here just to be consistent with push_insn, but skip it
> if you think it's not really necessary.

I will add a check for consistency.

> [...]
> 
> > > > +static struct bpf_iarray *
> > > > +create_jt(int t, struct bpf_verifier_env *env, int fd)
> > > > +{
> > > > +	static struct bpf_subprog_info *subprog;
> > > > +	int subprog_idx, subprog_start, subprog_end;
> > > > +	struct bpf_iarray *jt;
> > > > +	int i;
> > > > +
> > > > +	if (env->subprog_cnt == 0)
> > > > +		return ERR_PTR(-EFAULT);
> > > > +
> > > > +	subprog_idx = bpf_find_containing_subprog_idx(env, t);
> > > > +	if (subprog_idx < 0) {
> > > > +		verbose(env, "can't find subprog containing instruction %d\n", t);
> > > > +		return ERR_PTR(-EFAULT);
> > > > +	}
> > > 
> > > Nit: There is now verifier_bug() for such cases.
> > >      Also, it seems that all bpf_find_containing_subprog() users
> > >      assume that the function can't fail.
> > >      Like in this case, there is already access `jt = env->insn_aux_data[t].jt;`
> > >      in visit_gotox_insn() that will be an error if `t` is bogus.
> > 
> > Could you please explain this once again? The error from
> > bpf_find_containing_subprog* funcs is checked in this code.
> 
> Point being that there is no need to check if bpf_find_containing_subprog()
> returns error:
> - If we guarantee that `t` is within program bounds it can't fail
>   (which I think we do).  In other places where this function is
>   called it's return value is not checked for errors.
> - In case if we don't guarantee that `t` is within program bounds,
>   then just before call to create_jt() there is an access `jt =
>   env->insn_aux_data[t].jt;` which would read from some undefined
>   location. So, it's already too late to check here.

Ah, ok, I see, thanks.

> [...]
> 
> > >   /* "conditional jump with N edges" */
> > >   static int visit_gotox_insn(int t, struct bpf_verifier_env *env, int fd)
> > >   {
> > >         int *insn_stack = env->cfg.insn_stack;
> > >         int *insn_state = env->cfg.insn_state;
> > >         bool keep_exploring = false;
> > >         struct bpf_iarray *jt;
> > >         int i, w;
> > > 
> > >         jt = env->insn_aux_data[t].jt;
> > >         if (!jt) {
> > >                 jt = create_jt(t, env, fd);
> > >                 if (IS_ERR(ptr: jt))
> > 
> > (BTW, out of curiosity, do these "ptr: jt" type hints and alike
> > come from your environment? What is it, if this is not a secret?)
> 
> Oh... sorry about that, I'll suppress those moving forward.
> It's a copy-paste from tmux window.
> In tmux there is a terminal running emacs in console mode.
> Emacs uses eglot mode to integrate with clangd language server.
> Eglot displays these parameter name hints, provided by clangd.
> The whole thing ends up in copy-paste because in console mode all of
> this is just text. Had I run emacs in gui mode, it wouldn't be
> copy-pasted. But that's a remote machine, so here were are.

Thanks for the explanations. (Also, no problem if this appears.)

> [...]
> 
> > > > +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
> > > > +{
> 
> [...]
> 
> > > > +	n = copy_insn_array_uniq(map, min_index, max_index, env->gotox_tmp_buf);
> > > 
> > > I still think this might be a problem for big jump tables if gotox is
> > > in a loop body. Can you check a perf report for such scenario?
> > > E.g. 256 entries in the jump table, some duplicates, dispatched in a loop.
> > 
> > Well, for "big jump tables" I want to follow up with some changes in any case,
> > just didn't get there with this patchset yet. Namely, the `insn_inxed \mapto
> > jump table map` must be optimized, otherwise the JIT spends too much time on
> > this. So, this would require bin/serach or better a hash to optimize this. In
> > the latter case, this piece might also be optimized by caching a lookup
> > (by the "map[start,end]" key).
> 
> Ok, if follow-up is planned, we can stick with a simple implementation
> for this patch.
> 
> [...]

