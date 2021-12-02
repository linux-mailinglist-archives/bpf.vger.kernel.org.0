Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8094669FD
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 19:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhLBSpy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 13:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242538AbhLBSpx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 13:45:53 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC945C06174A
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 10:42:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so2044976edd.0
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 10:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4yJTeZbKudcVxKQRxGhhvdbcw7531dQmM1Yl7wPrdc=;
        b=tFZcvNtLhswa6Cj8R3BlZjvAsEDaeuUH4IhUShWMLBobx/637okib9ZGL5CyeHv2Lm
         Yot/NCYJFfGGDp75iDd9o2dIuEqvadgPYgdAzaETrlqixwnbRvOb8jCroc4jnbU3bqbK
         71YXXQ8uWsgxEwWyCaPhWe0N5I/zTKXbbRtiv//rx90UBEAuIE/Wu1JE5wgu/TqPYYzy
         ejTJFzognLNmYwb7suNY3YLW12gchWpFVGBnx0AKx4g5AE2cMWO9W/DmDc+Y265T+AM1
         9pV68//IRiljgsg+mOj765j5wE3hLuBsHOOpSb5H7imDz/Rt1t7biypylACtoH7oS36P
         Jr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4yJTeZbKudcVxKQRxGhhvdbcw7531dQmM1Yl7wPrdc=;
        b=3iKihqW3117l+bK8MCtO/vdoQd9RAv5jptqo+M1jt7EVaQpUGKzj9TLEd33qBYZbuF
         fRL0Voox1aFpPY7lONsiwmuw33fyGj+kFWANBQJU45+KgipllyINhFZDWaEXJTwdUdqn
         MSVDVtRR2QT9guMeKBzlsKWq1JZRmk4g6MJkTpcQs+eNILQb1EQFJpHjnEcmsDKpkqm9
         3BG9GAZ9fQnNJiM1UtF4eDD0Ws/jXzkxCWAU1159zT78KGUWWdMH8cP70tpqvZSAnIWL
         rg0Y7KHJcv04sCNYImb292M3TynbL72QYqNZ9nh3Hd33Qk9l94D0vE+RY2iGq9vvL+eA
         hd3A==
X-Gm-Message-State: AOAM530wfqwldeboW/Fy3qYxQj7WTdtgmCG1BFB7Z8faFMMssjX5v9In
        GJIxblk3u3cUfWiURLCkmiPjsPL2RHCtlBr8KSj2lw==
X-Google-Smtp-Source: ABdhPJxcg8KkyaDRlBhD3mjlCfT1+lAzJhd/ggSueFhpg90FWPik14fTO/WI28AyKdxFXiDmXNWhMXs2ccHqELyOBLk=
X-Received: by 2002:a17:906:9253:: with SMTP id c19mr17809475ejx.63.1638470549167;
 Thu, 02 Dec 2021 10:42:29 -0800 (PST)
MIME-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com> <20211130012948.380602-9-haoluo@google.com>
 <20211201203433.ioj3jsksaw3aoie2@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7ggwH-kwZYk48xnb1akYcTjK5itWu1eLCjmpb36=NLBbA@mail.gmail.com> <CAADnVQLy9XTP6A5kaEu0eKmmR0mAmFe1JyC4QrfQmLxNBoTjFw@mail.gmail.com>
In-Reply-To: <CAADnVQLy9XTP6A5kaEu0eKmmR0mAmFe1JyC4QrfQmLxNBoTjFw@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 2 Dec 2021 10:42:17 -0800
Message-ID: <CA+khW7hG5Z0JJFMhW6_iaEDsZNOGBQr-Xx7A-cYbkDB6Fw-hdg@mail.gmail.com>
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

On Wed, Dec 1, 2021 at 7:53 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 1, 2021 at 2:21 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Wed, Dec 1, 2021 at 12:34 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Nov 29, 2021 at 05:29:47PM -0800, Hao Luo wrote:
> > > >
> > > > +
> > > >  struct bpf_reg_types {
> > > >       const enum bpf_reg_type types[10];
> > > >       u32 *btf_id;
> > > > +
> > > > +     /* Certain types require customized type matching function. */
> > > > +     bool (*type_match_fn)(enum bpf_arg_type arg_type,
> > > > +                           enum bpf_reg_type type,
> > > > +                           enum bpf_reg_type expected);
> > > >  };
> > > >
> > > >  static const struct bpf_reg_types map_key_value_types = {
> > > > @@ -5013,6 +5019,19 @@ static const struct bpf_reg_types btf_id_sock_common_types = {
> > > >  };
> > > >  #endif
> > > >
> > > > +static bool mem_type_match(enum bpf_arg_type arg_type,
> > > > +                        enum bpf_reg_type type, enum bpf_reg_type expected)
> > > > +{
> > > > +     /* If arg_type is tagged with MEM_RDONLY, type is compatible with both
> > > > +      * RDONLY and RDWR mem, fold the MEM_RDONLY flag in 'type' before
> > > > +      * comparison.
> > > > +      */
> > > > +     if ((arg_type & MEM_RDONLY) != 0)
> > > > +             type &= ~MEM_RDONLY;
> > > > +
> > > > +     return type == expected;
> > > > +}
> > > > +
> > > >  static const struct bpf_reg_types mem_types = {
> > > >       .types = {
> > > >               PTR_TO_STACK,
> > > > @@ -5022,8 +5041,8 @@ static const struct bpf_reg_types mem_types = {
> > > >               PTR_TO_MAP_VALUE,
> > > >               PTR_TO_MEM,
> > > >               PTR_TO_BUF,
> > > > -             PTR_TO_BUF | MEM_RDONLY,
> > > >       },
> > > > +     .type_match_fn = mem_type_match,
> > >
> > > why add a callback for this logic?
> > > Isn't it a universal rule for MEM_RDONLY?
> >
> > Ah, good point, I didn't realize that. Maybe, not only MEM_RDONLY, but
> > all flags can be checked in the same way? Like the following
> >
> >  static const struct bpf_reg_types int_ptr_types = {
> > @@ -5097,6 +5116,13 @@ static int check_reg_type(struct
> > bpf_verifier_env *env, u32 regno,
> >                 if (expected == NOT_INIT)
> >                         break;
> >
> > +               flag = bpf_type_flag(arg_type);
> >
> > -               if (type == expected)
> > +               if ((type & ~flag) == expected)
> >                         goto found;
> >         }
>
> I think for MAYBE_NULL and MEM_RDONLY that would be correct,
> but not necessarily apply to future flags.
> I would open code it for these specific flags.

ack.

> Also what do you think about dropping bpf_ prefix from type_flag()?
> It won't conflict with anything and less verbose.

Sounds good as long as it won't conflict. IMO it would be good to have
an internal header in kernel/bpf. It appears to me that we put
everything in linux/bpf.h now. In sched, there is a
kernel/sched/sched.h used internally in kernel/sched and a
linux/sched.h that is public to other subsystems.
