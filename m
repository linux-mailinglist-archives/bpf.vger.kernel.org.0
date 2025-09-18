Return-Path: <bpf+bounces-68869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB7DB8731E
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 00:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19B12A661F
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 22:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D32FE049;
	Thu, 18 Sep 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxMkkimw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9EE2FD7A0
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232811; cv=none; b=vDF4hoYRKhV8JQKn34UZ4wDDRwmfP/IEAOdlkxzopSA2BniGzrsVLOgyJuuggtztfRCOAviFqUhQo5i0qTVl3CMH0q35sDPvvRmgLmPtuzh6ZDlJqpdXfhzH2+tv909+WPBsHGtZUGVsfhpeb7K8pkmOWFB4XsaiwMMgbdpNY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232811; c=relaxed/simple;
	bh=3imBiQksv7j89o2sLnxF7icGaxO/hORFUQ3LsmLxE+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2fUSS5T25B7BiE0fM6wgiysKZePOSayVNa3OQFNarvIYxhtT2mzYno2AwtmmHJyClIvP7i16UZPzIj8DboHmGL4/Sso1YHagOH56oWxNccZZzCbuloQvYUYzOJU1djiZnixtx1pM8dtzZcC1DPRiAtaZ2T1sLD6tE1vgBOR1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxMkkimw; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b2391596dcfso112803266b.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758232808; x=1758837608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YWxW9UzxEmm9rs1tQ9FvNtHt6/q9u3yeiGR9/7yXXwY=;
        b=HxMkkimwOeuAXQNplQ+NA18QdF9dmJwx8xy/FhyxKD/Nuj/npJlX4sfr5AFcJVmg0e
         r8YcYVxcxr14rY7vTlM0mlrmaqaLGjG8Jnted3WiZ1pBKSNXXHwf82hzaoQxXrZWsBo9
         rID162SD/6IgqQx+K3ox1xF2lZ3S/0C0egTqjD0KVg7AWsJwWtJNdNJG0t/hiX2I1Rom
         Stxt0agimpvj/Xq7rQbSb1nbguSnHfPQIeUbXNPEexJw9INGPA8IRJgk4onaHjmV3lvV
         ZJ5dv+jFZlpgEDfhZLLPCBl24524KyKCFvCNL3czNuAZP5PSvP8fuiIPN+fiYuMVqSNv
         Suzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758232808; x=1758837608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWxW9UzxEmm9rs1tQ9FvNtHt6/q9u3yeiGR9/7yXXwY=;
        b=g024zykkqiNM9wZJl0VRK3GdqNyaPV/PcBW9hUGIrGZzWIbTNSBgFSESxcXjAlQCfD
         sCE7CF3gqK2ZTSON4wXrSM7CldKZIevglJXhL/KBJVJo8n4arbkfwRzzlNdICCV4Ihs/
         c3ms5cKt+gJ8ij9B4HWG3p269CPWRVbuzsk7otQUeIH6jnFoIRQlRh8grSU25Hc2/CYZ
         gGSFPBkKntVaa9ala4SsljfDXRVxCZRYM3G64XBVW4RG17Xgucupa/0VOgDlm7ITw++7
         dA0oAe9OuftIVlNayJ7u2X14cY+G49NH7yG5lEVA9NSv0dsNo89oW8JI8lMjkZPPuQ8k
         rNJA==
X-Gm-Message-State: AOJu0Yy8hwb+OG8o5upEykIW3yORlcrI+mQKgb2F+RksdmwigEAakMAD
	ES0YMOI9ZIMfLIwq73AV6+aIOFvjf3WXTq2fUVPD+Ptl7lMynJzV3m0Y2JmqAh3sJIPoGhvPFDd
	h6+t3wu6QX01RvEKyW3VFm9yqf02MaJOMnCMs
X-Gm-Gg: ASbGncvpQGb456JK6FMefXF1jzFoHcyU6d2jcXXrHrXMpZWrCYVClGoK+dZxv49vQwB
	TayEEwCm8I1bdkSAAFfPfTRRQ7EFcK92NMWiebOBa4i2XIbiXu1TJJyFfuCKqbyyEgab9BXxWmj
	Qy3MJiE4fLMX4d/nOElggkoEHbLmVwBo2joINlPKalU0wqTI8hALPBo9OXtMEmCYgoSQSmqo7pk
	JLV8C0rfu3/aApcSZ5fC6niqFjZPyY08A0Ust/3NGBmQ+1jG/EgzjFYUle6qfQijs4qtw==
X-Google-Smtp-Source: AGHT+IG9zQF4sjYFKlgmJXcWfLadAbXnwRU2p5R4+POTGod0Rn/fbODjKhIJ9m+IEFArRGEZrTnAi/xgzFRTdgCGgm4=
X-Received: by 2002:a17:907:3f96:b0:b07:891d:7198 with SMTP id
 a640c23a62f3a-b24f2ed781fmr78972166b.30.1758232807496; Thu, 18 Sep 2025
 15:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917032755.4068726-1-memxor@gmail.com> <20250917032755.4068726-2-memxor@gmail.com>
 <412f49fa12de7c7f5d0461b56fd4e0b6882fa0ad.camel@gmail.com>
 <CAP01T77Nmwq1ZYpk2rJGLmOZezSBFOa0n8zyZn2gdj3UcE7XvA@mail.gmail.com> <fc6c5494b076a70354b5f45f4e108bb109a092df.camel@gmail.com>
In-Reply-To: <fc6c5494b076a70354b5f45f4e108bb109a092df.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 18 Sep 2025 23:59:30 +0200
X-Gm-Features: AS18NWAcj7DWeYChOFNJxKZhO5Bi-jkzM2xNT1pI5G_hMgf3KfKw6jANPC3bLBg
Message-ID: <CAP01T74K=s=QJDAxZFNY5LNHwEUq2y+vyVWvy34j65cQm_VJ2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Enforce RCU protection for KF_RCU_PROTECTED
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Andrea Righi <arighi@nvidia.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, 
	kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 23:47, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2025-09-18 at 23:37 +0200, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 18 Sept 2025 at 23:00, Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > On Wed, 2025-09-17 at 03:27 +0000, Kumar Kartikeya Dwivedi wrote:
> > > > Currently, KF_RCU_PROTECTED only applies to iterator APIs and that too
> > > > in a convoluted fashion: the presence of this flag on the kfunc is used
> > > > to set MEM_RCU in iterator type, and the lack of RCU protection results
> > > > in an error only later, once next() or destroy() methods are invoked on
> > > > the iterator. While there is no bug, this is certainly a bit
> > > > unintuitive, and makes the enforcement of the flag iterator specific.
> > > >
> > > > In the interest of making this flag useful for other upcoming kfuncs,
> > > > e.g. scx_bpf_cpu_curr() [0][1], add enforcement for invoking the kfunc
> > > > in an RCU critical section in general.
> > > >
> > > > This would also mean that iterator APIs using KF_RCU_PROTECTED will
> > > > error out earlier, instead of throwing an error for lack of RCU CS
> > > > protection when next() or destroy() methods are invoked.
> > > >
> > > > In addition to this, if the kfuncs tagged KF_RCU_PROTECTED return a
> > > > pointer value, ensure that this pointer value is only usable in an RCU
> > > > critical section. There might be edge cases where the return value is
> > > > special and doesn't need to imply MEM_RCU semantics, but in general, the
> > > > assumption should hold for the majority of kfuncs, and we can revisit
> > > > things if necessary later.
> > > >
> > > >   [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loehle@arm.com
> > > >   [1]: https://lore.kernel.org/all/20250909195709.92669-1-arighi@nvidia.com
> > > >
> > > > Tested-by: Andrea Righi <arighi@nvidia.com>
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > >
> > > [...]
> > >
> > > > @@ -14037,6 +14045,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> > > >
> > > >                       if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
> > > >                               regs[BPF_REG_0].type |= PTR_UNTRUSTED;
> > > > +                     else if (is_kfunc_rcu_protected(&meta))
> > > > +                             regs[BPF_REG_0].type |= MEM_RCU;
> > > >
> > > >                       if (is_iter_next_kfunc(&meta)) {
> > > >                               struct bpf_reg_state *cur_iter;
> > >
> > > The code below this hunk looks as follows:
> > >
> > >                         if (is_iter_next_kfunc(&meta)) {
> > >                                 struct bpf_reg_state *cur_iter;
> > >
> > >                                 cur_iter = get_iter_from_state(env->cur_state, &meta);
> > >
> > >                                 if (cur_iter->type & MEM_RCU) /* KF_RCU_PROTECTED */
> > >                                         regs[BPF_REG_0].type |= MEM_RCU;
> > >                                 else
> > >                                         regs[BPF_REG_0].type |= PTR_TRUSTED;
> > >                         }
> > >
> > > Do we want to reduce it to:
> > >
> > >                         if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
> > >                                 regs[BPF_REG_0].type |= PTR_UNTRUSTED;
> > >                         else if (is_kfunc_rcu_protected(&meta))
> > >                                 regs[BPF_REG_0].type |= MEM_RCU;
> > >                         else if (is_iter_next_kfunc(&meta))
> > >                                 regs[BPF_REG_0].type |= PTR_TRUSTED;
> >
> > I thought so too but we cannot do this. Suppose that the RCU read lock
> > is dropped and reacquired between new() and next(). Right now, we rely
> > on MEM_RCU in iter->type stack object that gets invalidated properly.
> > With such a change we'd lose the ability to track continued protection
> > using RCU while the iterator is alive on the stack, and continue to
> > mark returned pointers as MEM_RCU.
>
> The change I suggest does not invalidate this mechanics.
> The iterator is still marked with MEM_RCU and this mark is converted
> to PTR_UNTRUSTED when RCU section exits.
> The check for PTR_UNTRUSTED happens in process_iter_arg() called
> from check_kfunc_args().

Oh, I see. You mean is_iter_valid_reg_init etc. will complain on
seeing that PTR_UNTRUSTED?
Hmm, I guess that might work. I can respin or do it as a follow up,
whatever works best.

>
> >
> > >
> > > And mark relevant iterator next (and destroy?) functions as KF_RCU_PROTECTED?
> > > (bpf_iter_css_next, bpf_iter_task_next, bpf_iter_scx_dsq_next).
> > >
> > > I ask, because setting |= MEM_RCU in two places of this if branch
> > > looks a bit iffy.
> > >
> > > [...]

