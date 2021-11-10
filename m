Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7426C44BAE2
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 05:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhKJEoD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 23:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhKJEoC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 23:44:02 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96012C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 20:41:15 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id r130so1532882pfc.1
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 20:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLKddjP2vQxUpx41/rsIrDaBVxQZJyJ+dWxWRzQe+nY=;
        b=pqfytzeXYbw6lCDEdsMIN2A14PUQwanMN6MpkIoC0CCXWeKHaBJ2aUpwM/cOyCNWnp
         yNx5SFOB9XK9/LHS3RomK1c1O1niIDDANCE/4ubOCAv6H/A6VKoYunZSa60s+2gaF+lN
         HZA3W+o86ln+yFCPpK2qCJUm79NbYqTpp/Eo18kzlSlPoNXSFZVIC3OzBBQUiABMiVOE
         DbNQQiRvYFlVtWI5aRhZyLGC1i15Utt7eRwWyaMKmC81GMyCAzyr0hW7VPiUeeh5MF/t
         MIZLrqRVC1N14gG20ve2u+OwNcC6rDgCgLzpP2uY/5zozdL7CAjDY8gXJRuYpRDxThBS
         fVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLKddjP2vQxUpx41/rsIrDaBVxQZJyJ+dWxWRzQe+nY=;
        b=aZz6nFAalhRBUpdP5ON/S+Wo7w+ri4ji22T1yvw64IvUIvIZEui9hSTiu1wqANevip
         5f4ACT1qxLyHbHW/RFyY5pPnkN/B5lY+OAbhHXo4wsTzx60LWKAm13DMcHOm6YlnlQEV
         n8s9D9Tr6+mInrAzdj/iOGCYV//Ib+JGkBtTLGfWZLgwf+qFUGhj5QHNe/KTfJjuGSeZ
         MhjyXPYqgfB2eXw9dI7cBf5YYbXGnGy00yvJ8fi2Y17wk2V1BI89OuMQfbaY91v/1SCI
         GsDfd35PCSuHh6sBHI3cmA/QCtMJL8wca2Dl2Ray1tKXSIVoJwmzo/ePvmspT6+7iMP1
         BbPQ==
X-Gm-Message-State: AOAM530sqLUfY5tv/6QP8X2fOHanX0vBP8JbgZME6iNj0SU2o7J2682Q
        oMJ0FjbttNfBwy6qQBK8AZV1cBp4pkOyFf6oNUg=
X-Google-Smtp-Source: ABdhPJyslaa5Ukxsci/4J5jMMSKmH7h9JWTDuoqwe1RV6h5Qc7KKHCS+Eby5B6OMXqrZi8V2Er0tB2gPgt2ynFw8zrs=
X-Received: by 2002:aa7:9203:0:b0:481:30ff:cffb with SMTP id
 3-20020aa79203000000b0048130ffcffbmr13526401pfo.59.1636519275095; Tue, 09 Nov
 2021 20:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com> <20211109182128.hhbaqv3j52fddayq@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7hZC43ZrCSRL9SqffDPeDyxObzXtcvGneaEiW37=X11hA@mail.gmail.com>
 <CAEf4BzachpsSefRmoyLOdD3wY_+oihiB4uv=M9Yz5neNiOtLEA@mail.gmail.com> <CAEf4Bzav5H4cFjoa4Q=9XvgAghY7VXm5X-pMeGRNgLxAKEzRfw@mail.gmail.com>
In-Reply-To: <CAEf4Bzav5H4cFjoa4Q=9XvgAghY7VXm5X-pMeGRNgLxAKEzRfw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Nov 2021 20:41:04 -0800
Message-ID: <CAADnVQKLWW_-HQ06SbZtWOZ0gE4bUun4CSD6eQxwfTRS7UfJ_A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/9] bpf: Clean up _OR_NULL arg types
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 8:36 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 9, 2021 at 8:34 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Nov 9, 2021 at 11:42 AM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Tue, Nov 9, 2021 at 10:21 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Nov 08, 2021 at 06:16:15PM -0800, Hao Luo wrote:
> > > > > This is a pure cleanup patchset that tries to use flag to mark whether
> > > > > an arg may be null. It replaces enum bpf_arg_type with a struct. Doing
> > > > > so allows us to embed the properties of arguments in the struct, which
> > > > > is a more scalable solution than introducing a new enum. This patchset
> > > > > performs this transformation only on arg_type. If it looks good,
> > > > > follow-up patches will do the same on reg_type and ret_type.
> > > > >
> > > > > The first patch replaces 'enum bpf_arg_type' with 'struct bpf_arg_type'
> > > > > and each of the rest patches transforms one type of ARG_XXX_OR_NULLs.
> > > >
> > > > Nice. Thank you for working on it!
> > >
> > > No problem. :)
> > >
> > > >
> > > > The enum->struct conversion works for bpf_arg_type, but applying
> > > > the same technique to bpf_reg_type could be problematic.
> > > > Since it's part of bpf_reg_state which in turn is multiplied by a large factor.
> > > > Growing enum from 4 bytes to 8 byte struct will consume quite
> > > > a lot of extra memory.
> > > >
> > > > >  19 files changed, 932 insertions(+), 780 deletions(-)
> > > >
> > > > Just bpf_arg_type refactoring adds a lot of churn which could make
> > > > backports of future fixes not automatic anymore.
> > > > Similar converstion for bpf_reg_type and bpf_return_type will
> > > > be even more churn.
> > >
> > > Acknowledged.
> > >
> > > > Have you considered using upper bits to represent flags?
> > >
> > > Yes, I thought about that. Some of my thoughts are:
> > >
> > > - I wasn't sure how many bits should be reserved. Maybe 16 bits is good enough?
> > > - What if we run out of flag bits in future?
> > > - We could fold btf_id in the structure in this patchset. And new
> > > fields could be easily added if needed.
> > >
> > > So with these questions, I didn't pursue that approach in the first
> > > place. But I admit that it does look better by writing
> > >
> > > +      .arg3_type      = ARG_PTR_TO_STACK | MAYBE_NULL,
> > >
> > > Instead of
> > >
> > > +       .arg3    = {
> > > +               .type = ARG_PTR_TO_MAP_VALUE,
> > > +               .flag = ARG_FLAG_MAYBE_NULL,
> > > +       },
> > >
> > > Let's see if there is any further comment. I can go take a look and
> > > prepare for that approach in the next revision.
> > >
> >
> > +1 on staying within a single enum and using upper bits
> >
> > >
> > >
> > > >
> > > > Instead of diff:
> > > > -       .arg1_type      = ARG_CONST_MAP_PTR,
> > > > -       .arg2_type      = ARG_PTR_TO_FUNC,
> > > > -       .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
> > > > -       .arg4_type      = ARG_ANYTHING,
> > > > +       .arg1           = { .type = ARG_CONST_MAP_PTR },
> > > > +       .arg2           = { .type = ARG_PTR_TO_FUNC },
> > > > +       .arg3           = { .type = ARG_PTR_TO_STACK_OR_NULL },
> > > > +       .arg4           = { .type = ARG_ANYTHING },
> > > >
> > > > can we make it look like:
> > > >        .arg1_type      = ARG_CONST_MAP_PTR,
> > > >        .arg2_type      = ARG_PTR_TO_FUNC,
> > > > -      .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
> > > > +      .arg3_type      = ARG_PTR_TO_STACK | MAYBE_NULL,
> > > >        .arg4_type      = ARG_ANYTHING,
> > > >
> > > > Ideally all three (bpf_reg_type, bpf_return_type, and bpf_arg_type)
> > > > would share the same flag bit: MAYBE_NULL.
> >
> > I support using the same bit value, but should we use the exact same
> > enum name for three different enums? Like MAYBE_NULL, which enum is it
> > defined in? Wouldn't RET_MAYBE_NULL and RET_MAYBE_NULL, in addition to
> > REG_MAYBE_NULL be more explicit about what they apply to?
>
> argh, I meant to write "RET_MAYBE_NULL and ARG_MAYBE_NULL, in addition
> to REG_MAYBE_NULL".

Why differentiate? What difference do you see?
The flag looks the same to me in return, reg and arg.

> >
> > BTW (see my comment on another patch), _OR_NULL and _OR_ZERO are not
> > the same thing, are they? Is the plan to use two different bits for
> > them or pretend that CONST_OR_ZERO "may be null"?

What's the difference ?
I think single MAYBE_NULL (or call it MAYBE_ZERO) can apply correctly
to both ARG_CONST_SIZE, ARG_CONST_ALLOC_SIZE, and [ARG_]PTR_TO_MEM.
