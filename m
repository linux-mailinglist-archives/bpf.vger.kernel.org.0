Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC6365903
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhDTMfz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Apr 2021 08:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbhDTMfz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Apr 2021 08:35:55 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B47C06138A
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 05:35:24 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e14so8160094ils.12
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P28NEtKGrus7iCaFCDC+6w2lb8tH4ieeIEUK4kLrfXA=;
        b=QUv3+aqdlb4XRlG2GHw2B7TtkI+RBPjYu48aRrXyeXSOeTB/xIK7PRY6O9vwaf8kjl
         sfA9jHF6RIE8zwKMnxa4KmwTJEen+6ffB7+wrfJTNy4TdHayPirM7JmsSUeCJEcBX/F5
         iyu8j/hX+HGCfkBj5k0nW0Zdi7tElpM3qELkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P28NEtKGrus7iCaFCDC+6w2lb8tH4ieeIEUK4kLrfXA=;
        b=YF+rDEch6YtgNnrU0l/ViHOoLkq97qPkv/o1+Fc19+XH5gNU1y8vXZ2grtYcMD2veM
         VH1tlkUnoFaTs+j3XG9s3hcZWQayulHhyaHca0juzgYxsZvl+E+a2ALc1oBjpu3UmaLe
         OLUdu+lRdnoIJuDkOPZGU03VpDGfD2TEm/cQstyGDYLqIEWZV0JN7UoDRkiloexi37yO
         g92jFPt4r3cfPtp62+cja3fQmFtiyEn+qcZGRWy2s6hKeVk/L4UCeF264OZapgJoiySZ
         ns41X2lNwkXsetlipfOQij1eB63Kn35StqpIBoWoa83+5aWwI0G/C7n6dC7PSTknhuGa
         Ot2A==
X-Gm-Message-State: AOAM531mNmBE4vkurxWDsemJRiU1lXijVXZohIU3jAmdJ286jFC9YcPi
        zwZmNgg1gzbvvkLKPTl3fWyp9TNz8cnQ7dV3+Gr8vg==
X-Google-Smtp-Source: ABdhPJy8y2m9CJbWLpXZPnSWRCgBF77zu21Iz5jz1+Fy6R3Q2JDmfvbxC0YDCG/XMsmCDR3Ms1zsgJc3/ZTA3feuK5I=
X-Received: by 2002:a05:6e02:5a2:: with SMTP id k2mr22150327ils.177.1618922123638;
 Tue, 20 Apr 2021 05:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org> <20210419155243.1632274-3-revest@chromium.org>
 <20210419225404.chlkiaku5vaxmmyh@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210419225404.chlkiaku5vaxmmyh@ast-mbp.dhcp.thefacebook.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 20 Apr 2021 14:35:12 +0200
Message-ID: <CABRcYmJO5+tFtGuL9pdtFqLnBV7fGugEjaPbNRtJ3iXpbs3kFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/6] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 20, 2021 at 12:54 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 19, 2021 at 05:52:39PM +0200, Florent Revest wrote:
> > This type provides the guarantee that an argument is going to be a const
> > pointer to somewhere in a read-only map value. It also checks that this
> > pointer is followed by a zero character before the end of the map value.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h   |  1 +
> >  kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 42 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 77d1d8c65b81..c160526fc8bf 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -309,6 +309,7 @@ enum bpf_arg_type {
> >       ARG_PTR_TO_PERCPU_BTF_ID,       /* pointer to in-kernel percpu type */
> >       ARG_PTR_TO_FUNC,        /* pointer to a bpf program function */
> >       ARG_PTR_TO_STACK_OR_NULL,       /* pointer to stack or NULL */
> > +     ARG_PTR_TO_CONST_STR,   /* pointer to a null terminated read-only string */
> >       __BPF_ARG_TYPE_MAX,
> >  };
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 852541a435ef..5f46dd6f3383 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4787,6 +4787,7 @@ static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALU
> >  static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_PERCPU_BTF_ID } };
> >  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> >  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> > +static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> >
> >  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> >       [ARG_PTR_TO_MAP_KEY]            = &map_key_value_types,
> > @@ -4817,6 +4818,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> >       [ARG_PTR_TO_PERCPU_BTF_ID]      = &percpu_btf_ptr_types,
> >       [ARG_PTR_TO_FUNC]               = &func_ptr_types,
> >       [ARG_PTR_TO_STACK_OR_NULL]      = &stack_ptr_types,
> > +     [ARG_PTR_TO_CONST_STR]          = &const_str_ptr_types,
> >  };
> >
> >  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > @@ -5067,6 +5069,45 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               if (err)
> >                       return err;
> >               err = check_ptr_alignment(env, reg, 0, size, true);
> > +     } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > +             struct bpf_map *map = reg->map_ptr;
> > +             int map_off;
> > +             u64 map_addr;
> > +             char *str_ptr;
> > +
> > +             if (reg->type != PTR_TO_MAP_VALUE || !map ||
>
> I think the 'type' check is redundant,
> since check_reg_type() did it via compatible_reg_types.
> If so it's probably better to remove it here ?
>
> '!map' looks unnecessary. Can it ever happen? If yes, it's a verifier bug.
> For example in check_mem_access() we just deref reg->map_ptr without checking
> which, I think, is correct.

I agree with all of the above. I only thought it's better to be safe
than sorry but if you'd like I could follow up with a patch that
removes some checks?

> > +                 !bpf_map_is_rdonly(map)) {
>
> This check is needed, of course.
>
> > +                     verbose(env, "R%d does not point to a readonly map'\n", regno);
> > +                     return -EACCES;
> > +             }
> > +
> > +             if (!tnum_is_const(reg->var_off)) {
> > +                     verbose(env, "R%d is not a constant address'\n", regno);
> > +                     return -EACCES;
> > +             }
> > +
> > +             if (!map->ops->map_direct_value_addr) {
> > +                     verbose(env, "no direct value access support for this map type\n");
> > +                     return -EACCES;
> > +             }
> > +
> > +             err = check_map_access(env, regno, reg->off,
> > +                                    map->value_size - reg->off, false);
> > +             if (err)
> > +                     return err;
> > +
> > +             map_off = reg->off + reg->var_off.value;
> > +             err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> > +             if (err) {
>
> since the code checks it here the same check in check_bpf_snprintf_call() should
> probably do:
>  if (err) {
>    verbose("verifier bug\n");
>    return -EFAULT;
>  }
>
> instead of just "return err;"
> ?

Sure, does not hurt. I can also follow up with a patch unless if you
prefer doing it yourself.

> > +                     verbose(env, "direct value access on string failed\n");
>
> I think the message doesn't tell users much, but they probably should never
> see it unless they try to do lookup from readonly array with
> more than one element.
> So I guess it's fine to keep this one as-is. Just flagging.

Ack

> Anyway the whole set looks great, so I've applied to bpf-next.
> Thanks!

Thank you :D
