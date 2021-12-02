Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CB2466B73
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 22:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376997AbhLBVQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 16:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376289AbhLBVQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 16:16:38 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B4C061759
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 13:13:15 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i12so797261pfd.6
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 13:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=radURqAXc5Z+OWkEi9dBMVvVT6PvibiDYoD0gU2sXUE=;
        b=jlfZU5kPKy/3A1IsEhxVJE3SEudXvkI/0md80cZ2HAEXp7a/gMrGAm4BeP0tm/kFNV
         nK7yfjCmgFxu7uZVNQbZ89L9Ku8nFzS5hHcI4VZ72Y5Lotdqt9dPi/ebbCYP50xVjDEc
         EwlSYuwKST6Sa7gtSqvpE1WQEMpF7ZxlOH8yejJq+ocVzIEjvWAdEfzCZw/F154lvHCW
         kXNJu7ysDdBpI0IvkGntr0cMcsW1QM5zM6+JINeTRvDfwHvdkNd4rb29NJkoo2Uayfi+
         0LbJGK2z2aI6EUWWkMqQ4TVooyi7x6keM+qwNUdbu2X5JAMfTGFBcwzeSFqaK5hTZexi
         YwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=radURqAXc5Z+OWkEi9dBMVvVT6PvibiDYoD0gU2sXUE=;
        b=Xs3z5wrWsLWf6MRA1qOnmg4KAJ7TRt7nZjiOG2Wd9Bh0NfIJYVl8JED/H4nKJNYqkW
         VP3sb/tjfvsaGc77CqUWk2g5YfLgRIj7ibJa9tnSdc6V4FVIZ711d5EKt3y4KBFEcktw
         fDwuAaBA15x5sokFlxFM/F5nCGEKHmliLGhb0d21cAKSCXgqYizEcuFCbjoWgMNDcIkN
         nxvg5Jg6lk6LBKiiANUU+fTRKJlH9S4b4jET7bUGpxpYZ4dHfWUddpunuJjN6GwPJAVq
         rF3kubPHwY5TLyrP1jmtcbli7pl2u0JBE4VEi+nS/7eLonSbTJ/GI/4s+RVVBve/ujow
         8P1w==
X-Gm-Message-State: AOAM531+XaRvqUGQsPQ8WtbSWgpQQFpN0tNT0l9iRWpPkzvzi6AsyUGe
        g+w1svGliKEnVmC6PqPPEZvJskgYLxfen5QM048irxyHC70=
X-Google-Smtp-Source: ABdhPJyQ/0uayiBjOsLan6Vn5gt39YgRjADx8ttZnyVxXGL6aHM09qND26GRHo8VPcqjTeK9X1wDzKxNlsIXtYki+/k=
X-Received: by 2002:a63:6881:: with SMTP id d123mr1242560pgc.497.1638479594359;
 Thu, 02 Dec 2021 13:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com> <20211130012948.380602-9-haoluo@google.com>
 <20211201203433.ioj3jsksaw3aoie2@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7ggwH-kwZYk48xnb1akYcTjK5itWu1eLCjmpb36=NLBbA@mail.gmail.com>
 <CAADnVQLy9XTP6A5kaEu0eKmmR0mAmFe1JyC4QrfQmLxNBoTjFw@mail.gmail.com> <CA+khW7hG5Z0JJFMhW6_iaEDsZNOGBQr-Xx7A-cYbkDB6Fw-hdg@mail.gmail.com>
In-Reply-To: <CA+khW7hG5Z0JJFMhW6_iaEDsZNOGBQr-Xx7A-cYbkDB6Fw-hdg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Dec 2021 13:13:03 -0800
Message-ID: <CAADnVQJf+bCx8NKpk275LXz_eU0XSvFy6OD-b3mZ_+AX-VhZmQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 8/9] bpf: Add MEM_RDONLY for helper args
 that are pointers to rdonly mem.
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

On Thu, Dec 2, 2021 at 10:42 AM Hao Luo <haoluo@google.com> wrote:
>
> On Wed, Dec 1, 2021 at 7:53 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Dec 1, 2021 at 2:21 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Wed, Dec 1, 2021 at 12:34 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Nov 29, 2021 at 05:29:47PM -0800, Hao Luo wrote:
> > > > >
> > > > > +
> > > > >  struct bpf_reg_types {
> > > > >       const enum bpf_reg_type types[10];
> > > > >       u32 *btf_id;
> > > > > +
> > > > > +     /* Certain types require customized type matching function. */
> > > > > +     bool (*type_match_fn)(enum bpf_arg_type arg_type,
> > > > > +                           enum bpf_reg_type type,
> > > > > +                           enum bpf_reg_type expected);
> > > > >  };
> > > > >
> > > > >  static const struct bpf_reg_types map_key_value_types = {
> > > > > @@ -5013,6 +5019,19 @@ static const struct bpf_reg_types btf_id_sock_common_types = {
> > > > >  };
> > > > >  #endif
> > > > >
> > > > > +static bool mem_type_match(enum bpf_arg_type arg_type,
> > > > > +                        enum bpf_reg_type type, enum bpf_reg_type expected)
> > > > > +{
> > > > > +     /* If arg_type is tagged with MEM_RDONLY, type is compatible with both
> > > > > +      * RDONLY and RDWR mem, fold the MEM_RDONLY flag in 'type' before
> > > > > +      * comparison.
> > > > > +      */
> > > > > +     if ((arg_type & MEM_RDONLY) != 0)
> > > > > +             type &= ~MEM_RDONLY;
> > > > > +
> > > > > +     return type == expected;
> > > > > +}
> > > > > +
> > > > >  static const struct bpf_reg_types mem_types = {
> > > > >       .types = {
> > > > >               PTR_TO_STACK,
> > > > > @@ -5022,8 +5041,8 @@ static const struct bpf_reg_types mem_types = {
> > > > >               PTR_TO_MAP_VALUE,
> > > > >               PTR_TO_MEM,
> > > > >               PTR_TO_BUF,
> > > > > -             PTR_TO_BUF | MEM_RDONLY,
> > > > >       },
> > > > > +     .type_match_fn = mem_type_match,
> > > >
> > > > why add a callback for this logic?
> > > > Isn't it a universal rule for MEM_RDONLY?
> > >
> > > Ah, good point, I didn't realize that. Maybe, not only MEM_RDONLY, but
> > > all flags can be checked in the same way? Like the following
> > >
> > >  static const struct bpf_reg_types int_ptr_types = {
> > > @@ -5097,6 +5116,13 @@ static int check_reg_type(struct
> > > bpf_verifier_env *env, u32 regno,
> > >                 if (expected == NOT_INIT)
> > >                         break;
> > >
> > > +               flag = bpf_type_flag(arg_type);
> > >
> > > -               if (type == expected)
> > > +               if ((type & ~flag) == expected)
> > >                         goto found;
> > >         }
> >
> > I think for MAYBE_NULL and MEM_RDONLY that would be correct,
> > but not necessarily apply to future flags.
> > I would open code it for these specific flags.
>
> ack.
>
> > Also what do you think about dropping bpf_ prefix from type_flag()?
> > It won't conflict with anything and less verbose.
>
> Sounds good as long as it won't conflict. IMO it would be good to have
> an internal header in kernel/bpf. It appears to me that we put
> everything in linux/bpf.h now. In sched, there is a
> kernel/sched/sched.h used internally in kernel/sched and a
> linux/sched.h that is public to other subsystems.

yeah. That's long overdue. We have include/linux/bpf_verifier.h
that might work for this case too.
Or even directly in verifier.c (if possible).
