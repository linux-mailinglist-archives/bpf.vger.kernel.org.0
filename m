Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194C64708F7
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 19:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245465AbhLJSkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 13:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245466AbhLJSkf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 13:40:35 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D160C0617A1
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 10:36:59 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso7706357wmh.0
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 10:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cxcfpAnzMKumz6aKHRLWzHDTvL2PzrtqBScRlCLL4ME=;
        b=JBnwHVPmELZq0KQYnydp1hqhIy7jA4INjeCfOuUL7kdC/b4MMgW0clko9PV8NLHqMy
         Y42MyE6eLhySGAfuMmoVJmYgWGiIzPi5CyWypTUd3XtkLez+rnDuANOpALOC0Wc/ipRE
         UUJ128WOfLYNCiWWCuw1d/5w0QcfoQXIO01bXbMCfcWAh/eWFWS+hrhzTwzzcxZrlXDX
         BmPGDDMKcFpQ+8nYMYd8Y4X7KtW8S2sIWT2qzyIkMJHMNp77jedLZQ9AAcMG3Z/6oHB8
         h3dz68VlIh1P3KHFxAfrk982Sbzu7UE3PIoHPxksksc/2wabCH6i2oHwsLiT99xwqDws
         RR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cxcfpAnzMKumz6aKHRLWzHDTvL2PzrtqBScRlCLL4ME=;
        b=flGm9Q5v3KEHVyAmpCUyinv2UBY4SFxNpPPmwm7UiO7yoX9bWyVjK+CRt0zdUoTzR8
         QJUM7sMz5hrIncsow0gtRYrLACEI2zVJu1I3UXk5gcSNll/Eqep/Aek+JRhFxfZVf09W
         /Smkjdpsxg3uOKbJ2vz3+xIXjEoptwnndPhBMKJ1/r/a1sCMnip06IjaZvdECu/gCuIy
         /AdKUa8OyZ4EsR9nBe55ewMuIxmUb+rQfPO2UklDSCHC8k56MQDomMv6uPJmOhinsFgh
         ZpMamXHlIcVlM5Uw6FkcPQwlJ1286dm4XVs3f5eyGLwJ92Xq425NEisbMfg1f9V9084V
         iZqA==
X-Gm-Message-State: AOAM530dZwvXk3SO9eZzPZVpiGUyO+CiXgqhepQKpxvFl8OZw9JwYLyU
        GcR0hCc/rOaVon325B3o4YhIGVH41YjRoG1pH2D4lg==
X-Google-Smtp-Source: ABdhPJzkjVrtORmapLyn3B9RuFcJHpq2VVchZhy+0eZSVFOcbRxXUQv+5gXoBGJSdjifs+IwLDKCWLV6HpINeHIwSNs=
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr18472564wmq.164.1639161417462;
 Fri, 10 Dec 2021 10:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-8-haoluo@google.com>
 <CAEf4BzbSA1+vE4vA6FSbJfUZDyYvyHJbiK1j5yD=vGbGA5EEhg@mail.gmail.com>
 <CA+khW7jtOweO4it68=ggqbe7QbdhPukE+FkgmAiTs-PeR28AiQ@mail.gmail.com> <CAEf4BzbEQ5+iCuXk-gS133ignWZXB08tPrQmt8W3t3hz8B8B+w@mail.gmail.com>
In-Reply-To: <CAEf4BzbEQ5+iCuXk-gS133ignWZXB08tPrQmt8W3t3hz8B8B+w@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 10 Dec 2021 10:36:46 -0800
Message-ID: <CA+khW7iWaKQJOAZQJ_uGQg2NY3JKOhms9kDAPiYWYTn6tgh3Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/9] bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 10, 2021 at 9:42 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 7, 2021 at 7:54 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Dec 6, 2021 at 10:18 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > Tag the return type of {per, this}_cpu_ptr with RDONLY_MEM. The
> > > > returned value of this pair of helpers is kernel object, which
> > > > can not be updated by bpf programs. Previously these two helpers
> > > > return PTR_OT_MEM for kernel objects of scalar type, which allows
> > > > one to directly modify the memory. Now with RDONLY_MEM tagging,
> > > > the verifier will reject programs that writes into RDONLY_MEM.
> > > >
> > > > Fixes: 63d9b80dcf2c ("bpf: Introduce bpf_this_cpu_ptr()")
>
> BTW, our tooling complained about this one because in reality the
> subject of the patch has a typo: "bpf: Introducte bpf_this_cpu_ptr()",
> please fix as well (that is, re-introduce the typo :) )
>

Ah, yes, thanks for the notice :). I do see that typo after sending
out this version. I have it fixed in my local repo already.

> > > > Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
> > > > Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
> > > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > > ---
> > > >  kernel/bpf/helpers.c  |  4 ++--
> > > >  kernel/bpf/verifier.c | 33 ++++++++++++++++++++++++++++-----
> > > >  2 files changed, 30 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > index 293d9314ec7f..a5e349c9d3e3 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > > @@ -667,7 +667,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
> > > >  const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
> > > >         .func           = bpf_per_cpu_ptr,
> > > >         .gpl_only       = false,
> > > > -       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL,
> > > > +       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
> > > >         .arg1_type      = ARG_PTR_TO_PERCPU_BTF_ID,
> > > >         .arg2_type      = ARG_ANYTHING,
> > > >  };
> > > > @@ -680,7 +680,7 @@ BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
> > > >  const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
> > > >         .func           = bpf_this_cpu_ptr,
> > > >         .gpl_only       = false,
> > > > -       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID,
> > > > +       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | MEM_RDONLY,
> > > >         .arg1_type      = ARG_PTR_TO_PERCPU_BTF_ID,
> > > >  };
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index f8b804918c35..44af65f07a82 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -4296,16 +4296,32 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> > > >                                 mark_reg_unknown(env, regs, value_regno);
> > > >                         }
> > > >                 }
> > > > -       } else if (reg->type == PTR_TO_MEM) {
> > > > +       } else if (base_type(reg->type) == PTR_TO_MEM) {
> > > > +               bool rdonly_mem = type_is_rdonly_mem(reg->type);
> > > > +
> > > > +               if (type_may_be_null(reg->type)) {
> > > > +                       verbose(env, "R%d invalid mem access '%s'\n", regno,
> > > > +                               reg_type_str(reg->type));
> > >
> > > see, here you'll get "invalid mem access 'ptr_to_mem'" while it's
> > > actually ptr_to_mem_or_null. Like verifier logs are not hard enough to
> > > follow, now they will be also misleading.
> > >
> >
> > I think formatting string inside reg_type_str() can have this problem
> > solved, preserving the previous behavior. I'll try that in v2.
> >
> > > > +                       return -EACCES;
> > > > +               }
> > > > +
> > > > +               if (t == BPF_WRITE && rdonly_mem) {
> > > > +                       verbose(env, "R%d cannot write into rdonly %s\n",
> > > > +                               regno, reg_type_str(reg->type));
> > > > +                       return -EACCES;
> > > > +               }
> > > > +
> > > >                 if (t == BPF_WRITE && value_regno >= 0 &&
> > > >                     is_pointer_value(env, value_regno)) {
> > > >                         verbose(env, "R%d leaks addr into mem\n", value_regno);
> > > >                         return -EACCES;
> > > >                 }
> > > > +
> > > >                 err = check_mem_region_access(env, regno, off, size,
> > > >                                               reg->mem_size, false);
> > > > -               if (!err && t == BPF_READ && value_regno >= 0)
> > > > -                       mark_reg_unknown(env, regs, value_regno);
> > > > +               if (!err && value_regno >= 0)
> > > > +                       if (t == BPF_READ || rdonly_mem)
> > >
> > > why two nested ifs for one condition?
> > >
> >
> > No particular reason. I think it helped me understand the logic
> > better. But I'm fine with combining them into one 'if'.
>
> Personally two nested ifs are way harder to follow as it implies that
> there is some other sub-condition, while in reality it's one longer
> condition.
>
>
> >
> > > > +                               mark_reg_unknown(env, regs, value_regno);
> > > >         } else if (reg->type == PTR_TO_CTX) {
> > > >                 enum bpf_reg_type reg_type = SCALAR_VALUE;
> > > >                 struct btf *btf = NULL;
> > >
> > > [...]
