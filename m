Return-Path: <bpf+bounces-68376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DC2B570FB
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 09:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A41189D076
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 07:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444982D24BF;
	Mon, 15 Sep 2025 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtpV2Yml"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF13FBB3
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920435; cv=none; b=k/8V1WSdjmEoBPRd9OlVBXF0SoT4bbAcT36x1aCTBnkIDFfv/Ld5uUe/bqlShB0BKmiB0BRR4TMi/6x76B4PiXKgF4MfjVobAcshXUG36Pp6h9gEydtchHdyO1/tNuvuO4N7a7KbuZO009z+xkNZ+NHgY/i6gZxcLbMoHL6HuyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920435; c=relaxed/simple;
	bh=nkwhqbz5HzneRD2aXzYOw8hL+cZU2yc8POAU5xeyfTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/OVX7aalOsv4RCKlBLqZq4SFlw5lrnSwLWcFG0PvUFWYl9IO6ERGGpH/phByHuDxwwhsvhXz5u7nrYkzSfUjoB2Gl8KRbrtmChmRsGacbjTaEk9OBQY3UTBGFGs8MFBT2VQgnlJKwueU1ejf1T1g9/VeCrXz3jTfcBxh9qCI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtpV2Yml; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-62f1987d53aso1541695a12.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 00:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757920432; x=1758525232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1cQG0wO6AwBznY0F59CrW70T4A4vri8eSbTLTcwREI=;
        b=CtpV2Yml0qFluL7d3Kt93K5AV7UJzyEdLoeCq+eg1+X3JB55QqHBocEWddkl8HjNda
         pvU6w7u5cUInLh+qYFpkRD4E4ISIEi3SKWQjG2MSIDKTgV8GiYiUJGh0atwzfZBoWlLf
         WmLMks7spSNOJhmPGXE1kjQPq3gKGu2AdZvFyBLHRAPvuS5fAIgPCsjSuDB40qW6r7c4
         B5OYO4Mv9wRAxSPh7yXWtpC3gC5egJek6XtOnRAmAAiHMNhysyK7GMfKEvOHeLYBcQSx
         qkRQWMn90rrCADfKCbx18zoPDUX0KZTQUFp81rS2s4GBOz5KVOoOEbGuPEJ6fUGur+te
         hpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757920432; x=1758525232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1cQG0wO6AwBznY0F59CrW70T4A4vri8eSbTLTcwREI=;
        b=My26uJ5jB3mc2+yLqbFTKokMUh+qikOZLWjHkjOVaRBmRbfd8bWzbC9irWbSFbCMqU
         0DZOQCk5QZiJzMbOF+N4TO22eOkYE15lJdbdrkNn7bUEqtWHj81FulPMtCriTdGO5RN7
         a9kE9+DKrAVQr69kM/S4ok2KAkrxrlmpzrHQmoIXZNkkTGXL++IONVLileuwJZo/SGOY
         9/Z9eqiT4ONIzxc96DZV8mTvm1VLwOsLOZPAjlvSva4+vPnJgpMPv6czp8zHBlB6BOrx
         UxlrKfDqWzj7QHZz2pgOqSxKGdA5Vp6x5mzYYXi4QsVuNbAefFXzDF5YIArxBXyIOVDx
         h4fA==
X-Gm-Message-State: AOJu0YxbRXgBwnaaVLfWgoa1AdbMoAVQd6ThpyMIcOeasc37pKjbK4Wd
	kDjS5g/Oib4Xw1mUgusJPtpZKXxO7c7GTnzKqyNMkHlP/8vbLqVvfhBDJMfnCHovHvhEUKBdqGm
	9Xstlv2nAeyGnJvWA7F7FFLpRMxpuyRw=
X-Gm-Gg: ASbGncvcgrUd7xNRd24lvdfKPQiGr5GpXHqncU4B5F0Mzg/qVkAHmeGSYw+iYNvCwce
	AyaULTa8W1oEhUqmRTxUIzKsM671IIsydQeOKnALaS4bZCotnHMI0L6NuuKJoRrbEw9g1fE0ReN
	pBkmK66WuRlahzaPGmet+ofiB2PSTqQ8euzcBMLWzcC0Eb1m1W20uZdJSag7yFK2FoJe8MEVcHV
	/T0TQN0VpsbhvXYPO4ntfO9Co4vzgwDi7jpRBM=
X-Google-Smtp-Source: AGHT+IElT4FKPME1nd6N+fRQ0XyYIqIBnsA1mD8V52tdFGU4lpsZNG7786/c0vnQfzejrvzicHsR+KofBvV1Av6DxDA=
X-Received: by 2002:a05:6402:42cc:b0:62c:34ed:bbed with SMTP id
 4fb4d7f45d1cf-62ed827176bmr11703604a12.19.1757920431983; Mon, 15 Sep 2025
 00:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915024731.1494251-1-memxor@gmail.com> <20250915024731.1494251-3-memxor@gmail.com>
 <aMeuunTYM8c6jp1m@gpd4>
In-Reply-To: <aMeuunTYM8c6jp1m@gpd4>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 15 Sep 2025 09:13:15 +0200
X-Gm-Features: AS18NWCtpvrPyV2R2rb65FiA4FRBfS4pWqUymmUwwFs0DMc7maNvVb3dp-63U4U
Message-ID: <CAP01T74DSRE96FYRCMLghkFJdNPgi-PhoOycQ2fXyYhUF5ngBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Add support for KF_RET_RCU flag
To: Andrea Righi <arighi@nvidia.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Sept 2025 at 08:14, Andrea Righi <arighi@nvidia.com> wrote:
>
> Hi Kumar,
>
> thanks for looking at this! Comment below.
>
> On Mon, Sep 15, 2025 at 02:47:30AM +0000, Kumar Kartikeya Dwivedi wrote:
> > Add a kfunc annotation 'KF_RET_RCU' to signal that the return type must
> > be marked MEM_RCU, to return objects that are RCU protected. Naturally,
> > this must imply that the kfunc is invoked in an RCU critical section,
> > and thus the presence of this flag implies the presence of the
> > KF_RCU_PROTECTED flag. Upcoming kfunc scx_bpf_cpu_curr() [0] will be
> > made to make use of this flag.
>
> I'm not sure we actually need two separate annotations, I can't think of a
> case where KF_RCU_PROTECTED would be useful without also having KF_RET_RCU.
>
> What I mean is: if the kfunc is only meant to be called inside an RCU
> critical section, but doesn't return an RCU-protected pointer, then we can
> simply add rcu_read_lock/unlock() internally in the kfunc. And for kfuncs
> that take RCU-protected arguments we already have KF_RCU.
>
> So it seems sufficient to have a single annotation that implements the
> semantic "this kfunc returns an RCU-protected pointer".

Yeah, that seems reasonable in general, but we already have iterator
APIs (bpf_iter_task_{new,next,destroy}()) that collectively require
RCU CS to be open throughout the three calls. That's why I just
cleaned up the internal logic for KF_RCU_PROTECTED and made KF_RET_RCU
as what you're suggesting (i.e., fold KF_RCU_PROTECTED into it), which
I assume will be most useful for the majority of kfuncs that are not
iterators.

>
> What do you think?
>
> Thanks,
> -Andrea
>
> >
> >   [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loehle@arm.com
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  Documentation/bpf/kfuncs.rst | 13 +++++++++++--
> >  include/linux/btf.h          |  1 +
> >  kernel/bpf/verifier.c        |  7 +++++++
> >  3 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> > index 18ba1f7c26b3..7d1b7009338b 100644
> > --- a/Documentation/bpf/kfuncs.rst
> > +++ b/Documentation/bpf/kfuncs.rst
> > @@ -346,10 +346,19 @@ arguments are at least RCU protected pointers. This may transitively imply that
> >  RCU protection is ensured, but it does not work in cases of kfuncs which require
> >  RCU protection but do not take RCU protected arguments.
> >
> > +2.4.9 KF_RET_RCU flag
> > +---------------------
> > +
> > +The KF_RET_RCU flag is used for kfuncs which return pointers to RCU protected
> > +objects. Since this only works when the invocation of the kfunc is made in an
> > +active RCU critical section, the usage of this flag implies ``KF_RCU_PROTECTED``
> > +flag automatically. This flag may be combined with other return value modifiers,
> > +such as ``KF_RET_NULL``.
> > +
> >  .. _KF_deprecated_flag:
> >
> > -2.4.9 KF_DEPRECATED flag
> > -------------------------
> > +2.4.10 KF_DEPRECATED flag
> > +-------------------------
> >
> >  The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
> >  changed or removed in a subsequent kernel release. A kfunc that is
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 9eda6b113f9b..97205b8a938c 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -79,6 +79,7 @@
> >  #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
> >  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
> >  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
> > +#define KF_RET_RCU      ((1 << 16) | KF_RCU_PROTECTED) /* kfunc returns an RCU protected pointer, implies KF_RCU_PROTECTED */
> >
> >  /*
> >   * Tag marking a kernel function as a kfunc. This is meant to minimize the
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index aa7c82ab50b9..f1cc602ed556 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12342,6 +12342,11 @@ static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
> >       return meta->kfunc_flags & KF_RET_NULL;
> >  }
> >
> > +static bool is_kfunc_ret_rcu(struct bpf_kfunc_call_arg_meta *meta)
> > +{
> > +     return meta->kfunc_flags & KF_RET_RCU;
> > +}
> > +
> >  static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
> >  {
> >       return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_lock];
> > @@ -14042,6 +14047,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >
> >                       if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
> >                               regs[BPF_REG_0].type |= PTR_UNTRUSTED;
> > +                     else if (is_kfunc_ret_rcu(&meta))
> > +                             regs[BPF_REG_0].type |= MEM_RCU;
> >
> >                       if (is_iter_next_kfunc(&meta)) {
> >                               struct bpf_reg_state *cur_iter;
> > --
> > 2.51.0
> >

