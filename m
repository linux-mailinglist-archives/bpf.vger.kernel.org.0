Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785F747078D
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 18:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242065AbhLJRqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 12:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbhLJRqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 12:46:12 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBD6C061746
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 09:42:36 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id g17so22905002ybe.13
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fo/g3U+jDR3lYa8rRpiXmBpU0jUh17USUa9/S5Wnr3s=;
        b=gVQf0DQwIxBHk6IA8/rxTWBuFSabDCyWCj8s7r5mSguBQo61BCtVJrXQN2o6WJ0Fz3
         f+TmlhBXbb3yublSy0An4Eu9uQLUJxOaVDnUt2/PWL2zMowhWte9T4mQ3nlWFC6mNwET
         DKvOR62aJIEql6Hd9S5diLgT19GyZbe8NnrOVoA4/92DQqrPC1ztMIsNIrIFBZfLHOgv
         5bJ4e0vVmOZ2Htne9lAlfycu10a2Z0yOypQD17sWDdH19OyTQdAw3/WARu/atlrXeLEe
         U+v4HacjomnY1MJzXnuzIF+QUzE7Ea8oSRLAqLZN9nEjBkKaKrQuKXXI+5ecAzsB4Efz
         1Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fo/g3U+jDR3lYa8rRpiXmBpU0jUh17USUa9/S5Wnr3s=;
        b=NdeVi7GpGbDuvMRe7xC1YVUvJiBCh9qaATylJUF9+ROv0m0GTnY6M7bxO+7wDWCmiq
         Apg4Sh0d/etjbDJmJTInd7tbpq1LUpkVw6XNNYmxX7Nom65bEcKGljY8ao2nj+GdYXvY
         /oNuYoANFjmdZpl40VS55dEuJJ91I/+t3KuKxZOG3nidMkBfZjd6m+8AkLQ9UsGfg1Ly
         tULKPjrCoHfA1LqqNOkQO5iLYZrdCyPL28aQDRFPjEw7oNG2qy+kdHcTJY7jG2O15veK
         1Cw+0/huv5XG7KXwUk29XV/uZs78bPEz+DBuGzLBHuqhLiDFrZz+AGbArPSl/Of0Ebrj
         ZUGw==
X-Gm-Message-State: AOAM530vIAGwBgwQPtpOUVO8YQJ7SpW8y0ceATAoWXsSxsuZXQMEtbBG
        gonL/e7l3LtfE/an6KjMvKZwsT+zk/+o15eHhnE=
X-Google-Smtp-Source: ABdhPJwF+AD6ODdUNlzbG91pahAp54sWYwrKleKwcZKRMuKyod7vLMF4fw+dvBcHl8vKZcfkVNbofexk4Nc1lpL/eas=
X-Received: by 2002:a25:4cc5:: with SMTP id z188mr15893697yba.248.1639158156199;
 Fri, 10 Dec 2021 09:42:36 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-8-haoluo@google.com>
 <CAEf4BzbSA1+vE4vA6FSbJfUZDyYvyHJbiK1j5yD=vGbGA5EEhg@mail.gmail.com> <CA+khW7jtOweO4it68=ggqbe7QbdhPukE+FkgmAiTs-PeR28AiQ@mail.gmail.com>
In-Reply-To: <CA+khW7jtOweO4it68=ggqbe7QbdhPukE+FkgmAiTs-PeR28AiQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Dec 2021 09:42:24 -0800
Message-ID: <CAEf4BzbEQ5+iCuXk-gS133ignWZXB08tPrQmt8W3t3hz8B8B+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/9] bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
To:     Hao Luo <haoluo@google.com>
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

On Tue, Dec 7, 2021 at 7:54 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Dec 6, 2021 at 10:18 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > Tag the return type of {per, this}_cpu_ptr with RDONLY_MEM. The
> > > returned value of this pair of helpers is kernel object, which
> > > can not be updated by bpf programs. Previously these two helpers
> > > return PTR_OT_MEM for kernel objects of scalar type, which allows
> > > one to directly modify the memory. Now with RDONLY_MEM tagging,
> > > the verifier will reject programs that writes into RDONLY_MEM.
> > >
> > > Fixes: 63d9b80dcf2c ("bpf: Introduce bpf_this_cpu_ptr()")

BTW, our tooling complained about this one because in reality the
subject of the patch has a typo: "bpf: Introducte bpf_this_cpu_ptr()",
please fix as well (that is, re-introduce the typo :) )

> > > Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
> > > Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
> > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > ---
> > >  kernel/bpf/helpers.c  |  4 ++--
> > >  kernel/bpf/verifier.c | 33 ++++++++++++++++++++++++++++-----
> > >  2 files changed, 30 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 293d9314ec7f..a5e349c9d3e3 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -667,7 +667,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
> > >  const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
> > >         .func           = bpf_per_cpu_ptr,
> > >         .gpl_only       = false,
> > > -       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL,
> > > +       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
> > >         .arg1_type      = ARG_PTR_TO_PERCPU_BTF_ID,
> > >         .arg2_type      = ARG_ANYTHING,
> > >  };
> > > @@ -680,7 +680,7 @@ BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
> > >  const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
> > >         .func           = bpf_this_cpu_ptr,
> > >         .gpl_only       = false,
> > > -       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID,
> > > +       .ret_type       = RET_PTR_TO_MEM_OR_BTF_ID | MEM_RDONLY,
> > >         .arg1_type      = ARG_PTR_TO_PERCPU_BTF_ID,
> > >  };
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index f8b804918c35..44af65f07a82 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -4296,16 +4296,32 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> > >                                 mark_reg_unknown(env, regs, value_regno);
> > >                         }
> > >                 }
> > > -       } else if (reg->type == PTR_TO_MEM) {
> > > +       } else if (base_type(reg->type) == PTR_TO_MEM) {
> > > +               bool rdonly_mem = type_is_rdonly_mem(reg->type);
> > > +
> > > +               if (type_may_be_null(reg->type)) {
> > > +                       verbose(env, "R%d invalid mem access '%s'\n", regno,
> > > +                               reg_type_str(reg->type));
> >
> > see, here you'll get "invalid mem access 'ptr_to_mem'" while it's
> > actually ptr_to_mem_or_null. Like verifier logs are not hard enough to
> > follow, now they will be also misleading.
> >
>
> I think formatting string inside reg_type_str() can have this problem
> solved, preserving the previous behavior. I'll try that in v2.
>
> > > +                       return -EACCES;
> > > +               }
> > > +
> > > +               if (t == BPF_WRITE && rdonly_mem) {
> > > +                       verbose(env, "R%d cannot write into rdonly %s\n",
> > > +                               regno, reg_type_str(reg->type));
> > > +                       return -EACCES;
> > > +               }
> > > +
> > >                 if (t == BPF_WRITE && value_regno >= 0 &&
> > >                     is_pointer_value(env, value_regno)) {
> > >                         verbose(env, "R%d leaks addr into mem\n", value_regno);
> > >                         return -EACCES;
> > >                 }
> > > +
> > >                 err = check_mem_region_access(env, regno, off, size,
> > >                                               reg->mem_size, false);
> > > -               if (!err && t == BPF_READ && value_regno >= 0)
> > > -                       mark_reg_unknown(env, regs, value_regno);
> > > +               if (!err && value_regno >= 0)
> > > +                       if (t == BPF_READ || rdonly_mem)
> >
> > why two nested ifs for one condition?
> >
>
> No particular reason. I think it helped me understand the logic
> better. But I'm fine with combining them into one 'if'.

Personally two nested ifs are way harder to follow as it implies that
there is some other sub-condition, while in reality it's one longer
condition.


>
> > > +                               mark_reg_unknown(env, regs, value_regno);
> > >         } else if (reg->type == PTR_TO_CTX) {
> > >                 enum bpf_reg_type reg_type = SCALAR_VALUE;
> > >                 struct btf *btf = NULL;
> >
> > [...]
