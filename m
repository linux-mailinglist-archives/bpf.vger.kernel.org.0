Return-Path: <bpf+bounces-68866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9AB872A9
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 23:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEAF2A88EB
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 21:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D42F3601;
	Thu, 18 Sep 2025 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBnwc3vm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBA1F4181
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758231488; cv=none; b=hWsh/8KJQSiNAMVJRJc9iRS5DQC0Q51SpMXh40aSEB9IItxhkh+uzZlkzgxNhF+ejtCtK2MKyqt4XEmO4EbY/t1dyFTY2wCJXCZhwakxfixdQuw7b5CSNijCzHnmdevJf67NaUN6a3Pm0Sj0pDbK6pUKt2L32B7wkUyzEis+aAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758231488; c=relaxed/simple;
	bh=aLRIj83J3nZOYtGnFYIE1Mdff31X4sn+sRAaTHSaA2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMKcPtYyR2QKziS+h9vh3EI4Sq4xeNrSCV0g3yzbCoT0pgaj0TLWVv77CjcItua37haFnJoOphO9cRCw1NPcCXGJ5VWBqTUOjbbxzmk5qCp0bfuMiN9AwlCg5XH31URcbYHDaJ1tRY7ecMl53TTNVhxosSQw/b4JDYnlc3EXb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBnwc3vm; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so214958266b.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758231485; x=1758836285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3OFQ1V3H1P4XT4IRMp4KnVxz0HMzUAvUltBhtdE75Ds=;
        b=SBnwc3vmt5gmvxEqlH7hnmi/RTROdkhMJ4qSIRH+X44rVo3rezOsNxLwGz2Nszq0u/
         ealhjNaYEtAk33329rTF3ZFoLq0uaL9KC8QYakmrVRehSyrC11hylYxL+/UNO+AEqc60
         NJVs3p/e8qO2PH69RGOj4CBRDHGjZQQ38DH8dWxFk6SWa6+1GXpCrQM/D1UuksTPx8pQ
         N51CAhJrxa0rfFfFqIpo1IDjCzH502ivtYIJgVR59IvPerQ7KlblFoqq4o9E+Yu1AO+o
         +7dLkeLczyFAt+M/Z6czX08Z6TE28uAzH8emoudxEvgKMMHuZou15T8/MriVYsB+NNQe
         EMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758231485; x=1758836285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OFQ1V3H1P4XT4IRMp4KnVxz0HMzUAvUltBhtdE75Ds=;
        b=t7B2oduiji7HfIibDebCuTyESZfs59HNtciMPfUVTS3IXL49WYLF8m3VI9nzFUk9bV
         WfXzBGVyt/QBooVVDgUMhHZbD23AMvHGInKpEzrOdpS/G+CXzgaVPsSRofkWdTJf+POl
         h7JWlbZKnQlLozIutYFgFV994EorDkSywgZ7TaHdGmb/8Ngl7sAqruINdZWmzOBeBKjE
         et9HmdF+Ux/A3yu89dnL83m4PrLzbAwUSl+sfzJtTr3YLyVZl7SBvYZ4Fg+mMQuGqkfk
         tNLeZtBZtudphPGzlGKC+ojc1TX/RWgbaIwqBrgDfGDiQ4C8FTAGkKu+2WFgUDb/xf3e
         P0fw==
X-Gm-Message-State: AOJu0Yxnf8drUiSLigyGmFhwKh1R8ehuGNUZfrmmQc2AeWa8IYRSJ88P
	HfRQj4Lzngqsjdw21VqnNI4DK5/xXSwS1JeyfI1OqiKnVtHtIHC6V0t98UW7K/eGa/CJ7e27iIG
	c7nlqv7cskjmQSOgz2tqRyRZt4eWu3nA=
X-Gm-Gg: ASbGnctuVc8TPzU+F67lWFv0/bNNEr4Dvw2zVO7X+rxUtYExLB39mvVb2ZZeYLFiXDD
	TcUhlakHjZ9d1Me6766xSwGUr3eulTHCcF+4J0bXgQOkm81jfPC3ilTq+BeAoighfg/UzgRhhho
	02A6nGQPGciNFmYtoN3JZKwWxnSpuyzXzqWTVep0atoYvuUVL+DxdTTSCqmkZ39kWsmt/CVbDo/
	UbABkFavfXxQQRD+4MDPmDoAgaPFnsJzlLPEIlaR0lkKK5zyyYQ8IO6oR8=
X-Google-Smtp-Source: AGHT+IFHMPLLqT+3zpcBz8i/CxFtBttiM2EVDcbBZBQEUwD8A95HzYc0Qz51WLstnQ28q6a8NZC60psDI350h3OsexU=
X-Received: by 2002:a17:907:3d86:b0:b04:8ed3:9e81 with SMTP id
 a640c23a62f3a-b24f442b590mr82116466b.31.1758231485236; Thu, 18 Sep 2025
 14:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917032755.4068726-1-memxor@gmail.com> <20250917032755.4068726-2-memxor@gmail.com>
 <412f49fa12de7c7f5d0461b56fd4e0b6882fa0ad.camel@gmail.com>
In-Reply-To: <412f49fa12de7c7f5d0461b56fd4e0b6882fa0ad.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 18 Sep 2025 23:37:27 +0200
X-Gm-Features: AS18NWBVIpfyYBw5o7xi5A9JqVWQvUCWCfNq-qwbQpgmHU8MExnX2rhyJDX8cck
Message-ID: <CAP01T77Nmwq1ZYpk2rJGLmOZezSBFOa0n8zyZn2gdj3UcE7XvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Enforce RCU protection for KF_RCU_PROTECTED
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Andrea Righi <arighi@nvidia.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, 
	kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 23:00, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2025-09-17 at 03:27 +0000, Kumar Kartikeya Dwivedi wrote:
> > Currently, KF_RCU_PROTECTED only applies to iterator APIs and that too
> > in a convoluted fashion: the presence of this flag on the kfunc is used
> > to set MEM_RCU in iterator type, and the lack of RCU protection results
> > in an error only later, once next() or destroy() methods are invoked on
> > the iterator. While there is no bug, this is certainly a bit
> > unintuitive, and makes the enforcement of the flag iterator specific.
> >
> > In the interest of making this flag useful for other upcoming kfuncs,
> > e.g. scx_bpf_cpu_curr() [0][1], add enforcement for invoking the kfunc
> > in an RCU critical section in general.
> >
> > This would also mean that iterator APIs using KF_RCU_PROTECTED will
> > error out earlier, instead of throwing an error for lack of RCU CS
> > protection when next() or destroy() methods are invoked.
> >
> > In addition to this, if the kfuncs tagged KF_RCU_PROTECTED return a
> > pointer value, ensure that this pointer value is only usable in an RCU
> > critical section. There might be edge cases where the return value is
> > special and doesn't need to imply MEM_RCU semantics, but in general, the
> > assumption should hold for the majority of kfuncs, and we can revisit
> > things if necessary later.
> >
> >   [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loehle@arm.com
> >   [1]: https://lore.kernel.org/all/20250909195709.92669-1-arighi@nvidia.com
> >
> > Tested-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > @@ -14037,6 +14045,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >
> >                       if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
> >                               regs[BPF_REG_0].type |= PTR_UNTRUSTED;
> > +                     else if (is_kfunc_rcu_protected(&meta))
> > +                             regs[BPF_REG_0].type |= MEM_RCU;
> >
> >                       if (is_iter_next_kfunc(&meta)) {
> >                               struct bpf_reg_state *cur_iter;
>
> The code below this hunk looks as follows:
>
>                         if (is_iter_next_kfunc(&meta)) {
>                                 struct bpf_reg_state *cur_iter;
>
>                                 cur_iter = get_iter_from_state(env->cur_state, &meta);
>
>                                 if (cur_iter->type & MEM_RCU) /* KF_RCU_PROTECTED */
>                                         regs[BPF_REG_0].type |= MEM_RCU;
>                                 else
>                                         regs[BPF_REG_0].type |= PTR_TRUSTED;
>                         }
>
> Do we want to reduce it to:
>
>                         if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
>                                 regs[BPF_REG_0].type |= PTR_UNTRUSTED;
>                         else if (is_kfunc_rcu_protected(&meta))
>                                 regs[BPF_REG_0].type |= MEM_RCU;
>                         else if (is_iter_next_kfunc(&meta))
>                                 regs[BPF_REG_0].type |= PTR_TRUSTED;

I thought so too but we cannot do this. Suppose that the RCU read lock
is dropped and reacquired between new() and next(). Right now, we rely
on MEM_RCU in iter->type stack object that gets invalidated properly.
With such a change we'd lose the ability to track continued protection
using RCU while the iterator is alive on the stack, and continue to
mark returned pointers as MEM_RCU.

>
> And mark relevant iterator next (and destroy?) functions as KF_RCU_PROTECTED?
> (bpf_iter_css_next, bpf_iter_task_next, bpf_iter_scx_dsq_next).
>
> I ask, because setting |= MEM_RCU in two places of this if branch
> looks a bit iffy.
>
> [...]

