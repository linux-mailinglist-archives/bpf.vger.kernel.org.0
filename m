Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101FC466E5B
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 01:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhLCARv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 19:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhLCARv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 19:17:51 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C359EC06174A
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 16:14:27 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so4609954edc.6
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 16:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mT1f0SV0INzaKmzuxWm8jMWZd0dEqj6I+qG5xT8QpW0=;
        b=cyvPH8w7MxULv8tUEqVf7EZuvwcCe2rlbtOAe1aFuGJMtN/ZAwpqGQsLOprfbBo/ag
         neXmXzNnSxCy9X0KqxnAr0cbNgIwlW4YPDFsntQEzXJBVz6sCJVrNve6KEt1dHsav3vI
         Hcm2UKGB0MqihDkACm2fhERPRaSw83Tnv0GskKC6A+4CvW7Fx5XL+mZlJUxMuM7V8eBC
         ocTsOO3NZAXs7ZTgfClNaqgxTPQVj5YoA0B1W88iGikbD+D5E6HoKvHZpZVe7/Mflu25
         QXmpM4e+7Q8tGSQStfNAn9DXHit6H7M6Pas0YIBPpryi55PZ3VefBcG/ecuo3tFBH6gq
         RsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mT1f0SV0INzaKmzuxWm8jMWZd0dEqj6I+qG5xT8QpW0=;
        b=JnpBAn8cN0bVj48b0XNV0gWdkWouWOd1upBtNTCormFjrmqLcWeq+w/FiPLFvVh1Ws
         BVLBZyZ+vYKk6GHJ+btfVd+rMgXQAfHkn9zeTPECJQoktKjKrZgdHNqiGZiWP/5Su7o5
         xc47DDOS8zbYY+Cwe50kG6Pz21aYj4NUYx0FnyMJTY4eU/CR6Tyd/xd41vY/LRi1f7XW
         pC+5rT79PkD5Id6J5dRCII8Zl1IbMjVzH6nDt+dY2DKOkUyKxglBpxta24Lh+zZPYaup
         3NVlkXApHNr+DFGUD1p16BL5AML+Ia3Co5ozqHtPAEGDodhQlvrpHnT9YcALb4a3Yw0z
         tkaw==
X-Gm-Message-State: AOAM530krZ/vk228ryuW9aUfPaiXoxL9iuWTWCshQuOQTg+ffaJuKfeT
        VnSw2jixURqt334qeyHNpDVDgYVi5XdRhmMnUAEieg==
X-Google-Smtp-Source: ABdhPJzpGdIw+VfLBkjTmDngumVyWybAXg+QOXQrSxvSNsB6VYfmzrO8M7R4+qp73WFjKZ97iRx4DdrPEU5pszOtGoU=
X-Received: by 2002:a17:906:9253:: with SMTP id c19mr19681222ejx.63.1638490466017;
 Thu, 02 Dec 2021 16:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com> <20211130012948.380602-9-haoluo@google.com>
 <20211201203433.ioj3jsksaw3aoie2@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7ggwH-kwZYk48xnb1akYcTjK5itWu1eLCjmpb36=NLBbA@mail.gmail.com>
 <CAADnVQLy9XTP6A5kaEu0eKmmR0mAmFe1JyC4QrfQmLxNBoTjFw@mail.gmail.com>
 <CA+khW7hG5Z0JJFMhW6_iaEDsZNOGBQr-Xx7A-cYbkDB6Fw-hdg@mail.gmail.com> <CAADnVQJf+bCx8NKpk275LXz_eU0XSvFy6OD-b3mZ_+AX-VhZmQ@mail.gmail.com>
In-Reply-To: <CAADnVQJf+bCx8NKpk275LXz_eU0XSvFy6OD-b3mZ_+AX-VhZmQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 2 Dec 2021 16:14:14 -0800
Message-ID: <CA+khW7hvaNS+0xA+BJqyxrSzOCdTre-Qb+dnWPO1MUL2PQ_yRg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 8/9] bpf: Add MEM_RDONLY for helper args
 that are pointers to rdonly mem.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, Dec 2, 2021 at 1:13 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 2, 2021 at 10:42 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Wed, Dec 1, 2021 at 7:53 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Dec 1, 2021 at 2:21 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > On Wed, Dec 1, 2021 at 12:34 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Nov 29, 2021 at 05:29:47PM -0800, Hao Luo wrote:
> > > > > >
> > > > > > +
> > > > > >  struct bpf_reg_types {
> > > > > >       const enum bpf_reg_type types[10];
> > > > > >       u32 *btf_id;
> > > > > > +
> > > > > > +     /* Certain types require customized type matching function. */
> > > > > > +     bool (*type_match_fn)(enum bpf_arg_type arg_type,
> > > > > > +                           enum bpf_reg_type type,
> > > > > > +                           enum bpf_reg_type expected);
> > > > > >  };
> > > > > >
> > > > > >  static const struct bpf_reg_types map_key_value_types = {
> > > > > > @@ -5013,6 +5019,19 @@ static const struct bpf_reg_types btf_id_sock_common_types = {
> > > > > >  };
> > > > > >  #endif
> > > > > >
> > > > > > +static bool mem_type_match(enum bpf_arg_type arg_type,
> > > > > > +                        enum bpf_reg_type type, enum bpf_reg_type expected)
> > > > > > +{
> > > > > > +     /* If arg_type is tagged with MEM_RDONLY, type is compatible with both
> > > > > > +      * RDONLY and RDWR mem, fold the MEM_RDONLY flag in 'type' before
> > > > > > +      * comparison.
> > > > > > +      */
> > > > > > +     if ((arg_type & MEM_RDONLY) != 0)
> > > > > > +             type &= ~MEM_RDONLY;
> > > > > > +
> > > > > > +     return type == expected;
> > > > > > +}
> > > > > > +
> > > > > >  static const struct bpf_reg_types mem_types = {
> > > > > >       .types = {
> > > > > >               PTR_TO_STACK,
> > > > > > @@ -5022,8 +5041,8 @@ static const struct bpf_reg_types mem_types = {
> > > > > >               PTR_TO_MAP_VALUE,
> > > > > >               PTR_TO_MEM,
> > > > > >               PTR_TO_BUF,
> > > > > > -             PTR_TO_BUF | MEM_RDONLY,
> > > > > >       },
> > > > > > +     .type_match_fn = mem_type_match,
> > > > >
> > > > > why add a callback for this logic?
> > > > > Isn't it a universal rule for MEM_RDONLY?
> > > >
> > > > Ah, good point, I didn't realize that. Maybe, not only MEM_RDONLY, but
> > > > all flags can be checked in the same way? Like the following
> > > >
> > > >  static const struct bpf_reg_types int_ptr_types = {
> > > > @@ -5097,6 +5116,13 @@ static int check_reg_type(struct
> > > > bpf_verifier_env *env, u32 regno,
> > > >                 if (expected == NOT_INIT)
> > > >                         break;
> > > >
> > > > +               flag = bpf_type_flag(arg_type);
> > > >
> > > > -               if (type == expected)
> > > > +               if ((type & ~flag) == expected)
> > > >                         goto found;
> > > >         }
> > >
> > > I think for MAYBE_NULL and MEM_RDONLY that would be correct,
> > > but not necessarily apply to future flags.
> > > I would open code it for these specific flags.
> >
> > ack.
> >
> > > Also what do you think about dropping bpf_ prefix from type_flag()?
> > > It won't conflict with anything and less verbose.
> >
> > Sounds good as long as it won't conflict. IMO it would be good to have
> > an internal header in kernel/bpf. It appears to me that we put
> > everything in linux/bpf.h now. In sched, there is a
> > kernel/sched/sched.h used internally in kernel/sched and a
> > linux/sched.h that is public to other subsystems.
>
> yeah. That's long overdue. We have include/linux/bpf_verifier.h
> that might work for this case too.
> Or even directly in verifier.c (if possible).

Ack. Directly in verifier.c would be best, but bpf_verifier.h works.
There is only one place outside verifier.c (i.e. btf_ctx_access() in
btf.c) that needs base_type, the rest are all in verifier.c. Anyway, I
am going to put these functions in bpf_verifer.h for now.
