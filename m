Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B3C44BADC
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 05:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhKJEjS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 23:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhKJEjR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 23:39:17 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0DFC061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 20:36:31 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id y3so3248832ybf.2
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 20:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=focxKEBrQANbQE1CiET15oDj5kmNZsZWaIh2bn7U0yg=;
        b=lvuKb865lJnjxt4al138peiQMvYLkViuh97rcA1iNNIYBIcjIF3Z7gApITKDoxobHZ
         yGfhJGAbaosTkg0C536lrAUgEbcg9frp/nfwSiqJ2uAKRvEDUHfMM2s/z+sqQzeMur+Z
         p8A8nb5upILlVdGSxCUqkwc4mu+L2bsgGA3z5vuPbXkzZkBBvoL0KKFkLPSW+3VrPRrN
         uiDWPvJoHT66aQ+4sRnniLUq43uyJnK8zxuP37QKicJz5H+HOpMTSlN73JUfheFqYObO
         8wYP06dnEIKEshN9WLamc+zNiAGldTjo3pXfBSp7fpn7tTG2r+khcjm3NGL4y4blquM1
         ImLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=focxKEBrQANbQE1CiET15oDj5kmNZsZWaIh2bn7U0yg=;
        b=ym5IyvBgF8Rl2U0mUc3Oa+DgfuYZJWJIKdxOTAlIaMSIJAx4NiY1KxzBsDICyziRUI
         YtSajj1uxM/BpNBX5/4TQgFmqo9JyJGf9xZaNzQftoz1vzB2xV6oGZvfPaBIsCm3ElsK
         cKEWzZ3T1bHNfHTKtAukopGvEPU2JzKXxisZeENHEZ7O4chimYcq6rz+n0oobtRErE7p
         /Hars6mDtT7wbilcClp36yQ7W27f+z7pjMkcmIwbIslGRcMp21c6/dNx2hzWlTCKNUEk
         afbwN3M8AbZVpQAjj9tBR23/IKyJsR41gGBylT3dJgGgqFautdXz1XSAdman5lEVlO1H
         dneg==
X-Gm-Message-State: AOAM532gbCMW6sEzYtLYWYenUuAgzeaA6TMShyuwWzm3jP01/1oyDRmK
        gu/Gel34Eacb/xFO2GI9p2nM5rlxJpZ8jGYhTzhZeV0aSNE=
X-Google-Smtp-Source: ABdhPJxUPqovuh4u80uZpPl4wG1ajegB8HdBYub6ZsxmOn7wnA2hwwgjOPLwq32ONaE2/5hNlPP3d3Clxl+cGkFWnHo=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr14778433ybe.455.1636518990351;
 Tue, 09 Nov 2021 20:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com> <20211109182128.hhbaqv3j52fddayq@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7hZC43ZrCSRL9SqffDPeDyxObzXtcvGneaEiW37=X11hA@mail.gmail.com> <CAEf4BzachpsSefRmoyLOdD3wY_+oihiB4uv=M9Yz5neNiOtLEA@mail.gmail.com>
In-Reply-To: <CAEf4BzachpsSefRmoyLOdD3wY_+oihiB4uv=M9Yz5neNiOtLEA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 20:36:19 -0800
Message-ID: <CAEf4Bzav5H4cFjoa4Q=9XvgAghY7VXm5X-pMeGRNgLxAKEzRfw@mail.gmail.com>
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

On Tue, Nov 9, 2021 at 8:34 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 9, 2021 at 11:42 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Tue, Nov 9, 2021 at 10:21 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Nov 08, 2021 at 06:16:15PM -0800, Hao Luo wrote:
> > > > This is a pure cleanup patchset that tries to use flag to mark whether
> > > > an arg may be null. It replaces enum bpf_arg_type with a struct. Doing
> > > > so allows us to embed the properties of arguments in the struct, which
> > > > is a more scalable solution than introducing a new enum. This patchset
> > > > performs this transformation only on arg_type. If it looks good,
> > > > follow-up patches will do the same on reg_type and ret_type.
> > > >
> > > > The first patch replaces 'enum bpf_arg_type' with 'struct bpf_arg_type'
> > > > and each of the rest patches transforms one type of ARG_XXX_OR_NULLs.
> > >
> > > Nice. Thank you for working on it!
> >
> > No problem. :)
> >
> > >
> > > The enum->struct conversion works for bpf_arg_type, but applying
> > > the same technique to bpf_reg_type could be problematic.
> > > Since it's part of bpf_reg_state which in turn is multiplied by a large factor.
> > > Growing enum from 4 bytes to 8 byte struct will consume quite
> > > a lot of extra memory.
> > >
> > > >  19 files changed, 932 insertions(+), 780 deletions(-)
> > >
> > > Just bpf_arg_type refactoring adds a lot of churn which could make
> > > backports of future fixes not automatic anymore.
> > > Similar converstion for bpf_reg_type and bpf_return_type will
> > > be even more churn.
> >
> > Acknowledged.
> >
> > > Have you considered using upper bits to represent flags?
> >
> > Yes, I thought about that. Some of my thoughts are:
> >
> > - I wasn't sure how many bits should be reserved. Maybe 16 bits is good enough?
> > - What if we run out of flag bits in future?
> > - We could fold btf_id in the structure in this patchset. And new
> > fields could be easily added if needed.
> >
> > So with these questions, I didn't pursue that approach in the first
> > place. But I admit that it does look better by writing
> >
> > +      .arg3_type      = ARG_PTR_TO_STACK | MAYBE_NULL,
> >
> > Instead of
> >
> > +       .arg3    = {
> > +               .type = ARG_PTR_TO_MAP_VALUE,
> > +               .flag = ARG_FLAG_MAYBE_NULL,
> > +       },
> >
> > Let's see if there is any further comment. I can go take a look and
> > prepare for that approach in the next revision.
> >
>
> +1 on staying within a single enum and using upper bits
>
> >
> >
> > >
> > > Instead of diff:
> > > -       .arg1_type      = ARG_CONST_MAP_PTR,
> > > -       .arg2_type      = ARG_PTR_TO_FUNC,
> > > -       .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
> > > -       .arg4_type      = ARG_ANYTHING,
> > > +       .arg1           = { .type = ARG_CONST_MAP_PTR },
> > > +       .arg2           = { .type = ARG_PTR_TO_FUNC },
> > > +       .arg3           = { .type = ARG_PTR_TO_STACK_OR_NULL },
> > > +       .arg4           = { .type = ARG_ANYTHING },
> > >
> > > can we make it look like:
> > >        .arg1_type      = ARG_CONST_MAP_PTR,
> > >        .arg2_type      = ARG_PTR_TO_FUNC,
> > > -      .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
> > > +      .arg3_type      = ARG_PTR_TO_STACK | MAYBE_NULL,
> > >        .arg4_type      = ARG_ANYTHING,
> > >
> > > Ideally all three (bpf_reg_type, bpf_return_type, and bpf_arg_type)
> > > would share the same flag bit: MAYBE_NULL.
>
> I support using the same bit value, but should we use the exact same
> enum name for three different enums? Like MAYBE_NULL, which enum is it
> defined in? Wouldn't RET_MAYBE_NULL and RET_MAYBE_NULL, in addition to
> REG_MAYBE_NULL be more explicit about what they apply to?

argh, I meant to write "RET_MAYBE_NULL and ARG_MAYBE_NULL, in addition
to REG_MAYBE_NULL".

>
> BTW (see my comment on another patch), _OR_NULL and _OR_ZERO are not
> the same thing, are they? Is the plan to use two different bits for
> them or pretend that CONST_OR_ZERO "may be null"?
>
> > > Then static bool arg_type_may_be_null() will be comparing only single bit ?
> > >
> > > While
> > >         if (arg_type == ARG_PTR_TO_MAP_VALUE ||
> > >             arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
> > >             arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
> > > will become:
> > >         arg_type &= FLAG_MASK;
> > >         if (arg_type == ARG_PTR_TO_MAP_VALUE ||
> > >             arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE) {
> > >
> > > Most of the time I would prefer explicit .type and .flag structure,
> > > but saving memory is important for bpf_reg_type, so explicit bit
> > > operations are probably justified.
