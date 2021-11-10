Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D7E44BADB
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 05:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhKJEhs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 23:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhKJEhs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 23:37:48 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA0C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 20:35:01 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g17so3075258ybe.13
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 20:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t71OCEGYKp6exEMWdP9H+d/3q1cWHyJyCMdxcsRazG8=;
        b=qeVdUIC9AsFNyOOI2OQuHK77+aDLdpdza2fX5sAaODrSUJv1ZB5ukCgAZaPp18LgUt
         lU0WKnTcfHg4U6sJ+u+IijFVwmzRseyWs1+47HaJ40XtKMehSGr6DEKpeSbNyztt/+0y
         cayLJhbPVRYTF1c8vbPX6R2gM+cJz/I3m+NJrIXA0XkT6y2fC64dfsNnD/fdTRq7ZsZf
         MrBT0yX4qs1XTc6QHQpB3htL51IA7jIS7KMq/JHdtG1G3HUSeqXMbaFh6oQ2211KIKFR
         hSJETnbiPUoTmYNQKCF2+VJ/49An3Ms0+/W2+gcly3nYdOcjN1eORJ0mc3bfyk8gQmFb
         BqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t71OCEGYKp6exEMWdP9H+d/3q1cWHyJyCMdxcsRazG8=;
        b=dfx7rqjchABXyKFgypLZupYAoQdOQ4op2Ee5XSjua6NoOA454pAbD9Fpk3hLEK/UDk
         GV3okSxn0nDq4n1D5OOoS9cEYz8RXzDx5cxY3XR17XgXrCEQKLFKStCqyBqKYaH2Mf6n
         JBovYkKkzP9t3vwAESiFjkjVdhMDRKxVHww+Xdo5AfknV4JBQO+IojSMbukOO1RA5ztC
         SZjAJQJv/2Cf1ou5SLrR0tGN63SdZlZnIBPx4/dzgzUi/Js648sf7VQSmS7CQGYbAiAi
         lbkiqqJ6qH/6uzW2eFf3OzuN3Wes3FrjZKc9XrZBR4L1qSAURUwfg6nqaGKMOMJNXFB+
         K65g==
X-Gm-Message-State: AOAM5317hDOGyb1CkAa9vMH3jMHRjMKroUFtSzhn5XxNYYVPIiuZ0JTB
        f2x0qC4lGtgM/pdqaq2hd8I/OhcGme0Q95vM83Q=
X-Google-Smtp-Source: ABdhPJx7vhuKNATOTHYsqrWu9G2umzoexJaOLHKUoyPORY2+9MUxSbSPi3BcKkJc555MTynhRNAsk4tmlzxvsDC7O7k=
X-Received: by 2002:a25:d187:: with SMTP id i129mr14035342ybg.2.1636518900553;
 Tue, 09 Nov 2021 20:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com> <20211109182128.hhbaqv3j52fddayq@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7hZC43ZrCSRL9SqffDPeDyxObzXtcvGneaEiW37=X11hA@mail.gmail.com>
In-Reply-To: <CA+khW7hZC43ZrCSRL9SqffDPeDyxObzXtcvGneaEiW37=X11hA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 20:34:49 -0800
Message-ID: <CAEf4BzachpsSefRmoyLOdD3wY_+oihiB4uv=M9Yz5neNiOtLEA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/9] bpf: Clean up _OR_NULL arg types
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 11:42 AM Hao Luo <haoluo@google.com> wrote:
>
> On Tue, Nov 9, 2021 at 10:21 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 08, 2021 at 06:16:15PM -0800, Hao Luo wrote:
> > > This is a pure cleanup patchset that tries to use flag to mark whether
> > > an arg may be null. It replaces enum bpf_arg_type with a struct. Doing
> > > so allows us to embed the properties of arguments in the struct, which
> > > is a more scalable solution than introducing a new enum. This patchset
> > > performs this transformation only on arg_type. If it looks good,
> > > follow-up patches will do the same on reg_type and ret_type.
> > >
> > > The first patch replaces 'enum bpf_arg_type' with 'struct bpf_arg_type'
> > > and each of the rest patches transforms one type of ARG_XXX_OR_NULLs.
> >
> > Nice. Thank you for working on it!
>
> No problem. :)
>
> >
> > The enum->struct conversion works for bpf_arg_type, but applying
> > the same technique to bpf_reg_type could be problematic.
> > Since it's part of bpf_reg_state which in turn is multiplied by a large factor.
> > Growing enum from 4 bytes to 8 byte struct will consume quite
> > a lot of extra memory.
> >
> > >  19 files changed, 932 insertions(+), 780 deletions(-)
> >
> > Just bpf_arg_type refactoring adds a lot of churn which could make
> > backports of future fixes not automatic anymore.
> > Similar converstion for bpf_reg_type and bpf_return_type will
> > be even more churn.
>
> Acknowledged.
>
> > Have you considered using upper bits to represent flags?
>
> Yes, I thought about that. Some of my thoughts are:
>
> - I wasn't sure how many bits should be reserved. Maybe 16 bits is good enough?
> - What if we run out of flag bits in future?
> - We could fold btf_id in the structure in this patchset. And new
> fields could be easily added if needed.
>
> So with these questions, I didn't pursue that approach in the first
> place. But I admit that it does look better by writing
>
> +      .arg3_type      = ARG_PTR_TO_STACK | MAYBE_NULL,
>
> Instead of
>
> +       .arg3    = {
> +               .type = ARG_PTR_TO_MAP_VALUE,
> +               .flag = ARG_FLAG_MAYBE_NULL,
> +       },
>
> Let's see if there is any further comment. I can go take a look and
> prepare for that approach in the next revision.
>

+1 on staying within a single enum and using upper bits

>
>
> >
> > Instead of diff:
> > -       .arg1_type      = ARG_CONST_MAP_PTR,
> > -       .arg2_type      = ARG_PTR_TO_FUNC,
> > -       .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
> > -       .arg4_type      = ARG_ANYTHING,
> > +       .arg1           = { .type = ARG_CONST_MAP_PTR },
> > +       .arg2           = { .type = ARG_PTR_TO_FUNC },
> > +       .arg3           = { .type = ARG_PTR_TO_STACK_OR_NULL },
> > +       .arg4           = { .type = ARG_ANYTHING },
> >
> > can we make it look like:
> >        .arg1_type      = ARG_CONST_MAP_PTR,
> >        .arg2_type      = ARG_PTR_TO_FUNC,
> > -      .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
> > +      .arg3_type      = ARG_PTR_TO_STACK | MAYBE_NULL,
> >        .arg4_type      = ARG_ANYTHING,
> >
> > Ideally all three (bpf_reg_type, bpf_return_type, and bpf_arg_type)
> > would share the same flag bit: MAYBE_NULL.

I support using the same bit value, but should we use the exact same
enum name for three different enums? Like MAYBE_NULL, which enum is it
defined in? Wouldn't RET_MAYBE_NULL and RET_MAYBE_NULL, in addition to
REG_MAYBE_NULL be more explicit about what they apply to?

BTW (see my comment on another patch), _OR_NULL and _OR_ZERO are not
the same thing, are they? Is the plan to use two different bits for
them or pretend that CONST_OR_ZERO "may be null"?

> > Then static bool arg_type_may_be_null() will be comparing only single bit ?
> >
> > While
> >         if (arg_type == ARG_PTR_TO_MAP_VALUE ||
> >             arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
> >             arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
> > will become:
> >         arg_type &= FLAG_MASK;
> >         if (arg_type == ARG_PTR_TO_MAP_VALUE ||
> >             arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE) {
> >
> > Most of the time I would prefer explicit .type and .flag structure,
> > but saving memory is important for bpf_reg_type, so explicit bit
> > operations are probably justified.
