Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0246CBC9
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 04:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244017AbhLHD5o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 22:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhLHD5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 22:57:43 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92768C061574
        for <bpf@vger.kernel.org>; Tue,  7 Dec 2021 19:54:12 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id a11so885096qkh.13
        for <bpf@vger.kernel.org>; Tue, 07 Dec 2021 19:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I74IhHoezI19dJ17BNr7j8kiXYiwvXfUI6Xi5P6b4ho=;
        b=ble9B8SI74WXX9BnPUU8Aopl+3ah+3SbFetLKZxmIjDC83n0eCfV5r622DrFQdY1Ji
         eAWw8BB1MaiMMo12iyk2roCwjnABv8NlYq7qEXdOW3K0a744bZYa1hvuuTf2jv4sZuNx
         hA80D5RRCuPs/DjueoqJvmqBN8GkhB80vvhVVFS9U4ySR+8qERgPEPDi+OPNiBgOUwLc
         532osWbudn+ZLqAwr2e5uo8TE61dYsHT2FvfkyefRUrk2odUbUMGrE+e2QJkMk3CEdwU
         nZfXCRIrLhgraNFE1jlCKYs5TUF0sXOHcTTIoJ1lLS2dPtkILZR9Fqo2mZ6csS3z69Ed
         hvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I74IhHoezI19dJ17BNr7j8kiXYiwvXfUI6Xi5P6b4ho=;
        b=wEAcbkhBGqkEVj8AbY7nS3vZrf0mqo13I0diTqQEioHQjeTDzHzTgnieRgiyhq4veq
         sE3VHJmnoVQ3KcKSnp5iSMOJjPdHLcz6QK828p+wGbdrfw10XjlEI5NAuQW/utmKwWRk
         y2G/fmGMqMWc5/sHsuGLNgaLjQQqOIM/y+kqj3wCK1dcdeo1l3kwEJ+GD5tnpSAhNhBM
         JoGLZisM81sOXM18LHmpg+PCy71ri4tuJHfrAausLV/VNQd0LQ7v3TN3s+08uVhVdL7a
         7rhYfU7DTXfBcks6YZF9d2dm8SOJoJC8Ouc7DdedYr0mo5bbxArX9+W6mGtpyqaSZAHm
         kosw==
X-Gm-Message-State: AOAM530lk8Aq5g0V/D1pGZwU7hPLQQBA8LXpJapLQKFb7esoNvF/eOEQ
        4D/UsbrF01+hfOxL1lvcxarU8ocYbMGfKHAmIGV2DqdHSpA=
X-Google-Smtp-Source: ABdhPJwFNTGwdT5ZvBz5NE4tfg/MkqW1gqC31doOtFKWcabnJwM5TOuIGr0kqw6J62OPorQKXcY0ngIueg4wDt7e42w=
X-Received: by 2002:a05:620a:28c5:: with SMTP id l5mr3736160qkp.583.1638935651567;
 Tue, 07 Dec 2021 19:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-8-haoluo@google.com>
 <CAEf4BzbSA1+vE4vA6FSbJfUZDyYvyHJbiK1j5yD=vGbGA5EEhg@mail.gmail.com>
In-Reply-To: <CAEf4BzbSA1+vE4vA6FSbJfUZDyYvyHJbiK1j5yD=vGbGA5EEhg@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 7 Dec 2021 19:54:00 -0800
Message-ID: <CA+khW7jtOweO4it68=ggqbe7QbdhPukE+FkgmAiTs-PeR28AiQ@mail.gmail.com>
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

On Mon, Dec 6, 2021 at 10:18 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Tag the return type of {per, this}_cpu_ptr with RDONLY_MEM. The
> > returned value of this pair of helpers is kernel object, which
> > can not be updated by bpf programs. Previously these two helpers
> > return PTR_OT_MEM for kernel objects of scalar type, which allows
> > one to directly modify the memory. Now with RDONLY_MEM tagging,
> > the verifier will reject programs that writes into RDONLY_MEM.
> >
> > Fixes: 63d9b80dcf2c ("bpf: Introduce bpf_this_cpu_ptr()")
> > Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
> > Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  kernel/bpf/helpers.c  |  4 ++--
> >  kernel/bpf/verifier.c | 33 ++++++++++++++++++++++++++++-----
> >  2 files changed, 30 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 293d9314ec7f..a5e349c9d3e3 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -667,7 +667,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
> >  const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
> >         .func           = bpf_per_cpu_ptr,
> >         .gpl_only       = false,
> > -       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL,
> > +       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
> >         .arg1_type      = ARG_PTR_TO_PERCPU_BTF_ID,
> >         .arg2_type      = ARG_ANYTHING,
> >  };
> > @@ -680,7 +680,7 @@ BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
> >  const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
> >         .func           = bpf_this_cpu_ptr,
> >         .gpl_only       = false,
> > -       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID,
> > +       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | MEM_RDONLY,
> >         .arg1_type      = ARG_PTR_TO_PERCPU_BTF_ID,
> >  };
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f8b804918c35..44af65f07a82 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4296,16 +4296,32 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >                                 mark_reg_unknown(env, regs, value_regno);
> >                         }
> >                 }
> > -       } else if (reg->type == PTR_TO_MEM) {
> > +       } else if (base_type(reg->type) == PTR_TO_MEM) {
> > +               bool rdonly_mem = type_is_rdonly_mem(reg->type);
> > +
> > +               if (type_may_be_null(reg->type)) {
> > +                       verbose(env, "R%d invalid mem access '%s'\n", regno,
> > +                               reg_type_str(reg->type));
>
> see, here you'll get "invalid mem access 'ptr_to_mem'" while it's
> actually ptr_to_mem_or_null. Like verifier logs are not hard enough to
> follow, now they will be also misleading.
>

I think formatting string inside reg_type_str() can have this problem
solved, preserving the previous behavior. I'll try that in v2.

> > +                       return -EACCES;
> > +               }
> > +
> > +               if (t == BPF_WRITE && rdonly_mem) {
> > +                       verbose(env, "R%d cannot write into rdonly %s\n",
> > +                               regno, reg_type_str(reg->type));
> > +                       return -EACCES;
> > +               }
> > +
> >                 if (t == BPF_WRITE && value_regno >= 0 &&
> >                     is_pointer_value(env, value_regno)) {
> >                         verbose(env, "R%d leaks addr into mem\n", value_regno);
> >                         return -EACCES;
> >                 }
> > +
> >                 err = check_mem_region_access(env, regno, off, size,
> >                                               reg->mem_size, false);
> > -               if (!err && t == BPF_READ && value_regno >= 0)
> > -                       mark_reg_unknown(env, regs, value_regno);
> > +               if (!err && value_regno >= 0)
> > +                       if (t == BPF_READ || rdonly_mem)
>
> why two nested ifs for one condition?
>

No particular reason. I think it helped me understand the logic
better. But I'm fine with combining them into one 'if'.

> > +                               mark_reg_unknown(env, regs, value_regno);
> >         } else if (reg->type == PTR_TO_CTX) {
> >                 enum bpf_reg_type reg_type = SCALAR_VALUE;
> >                 struct btf *btf = NULL;
>
> [...]
