Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187BB262CC6
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 12:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIIKCi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 06:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgIIKCg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 06:02:36 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731AC061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 03:02:36 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g96so1755555otb.12
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 03:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRtKp7QC+YB5u8HTnpR2R+YBfSIQAK3FwGjwQja3fd0=;
        b=DFlyq783l79qka3ijYGQEPXnS/9sCYsb2Ixm1zEa1wH+yL5kDFmDDbLpEotlAskrfD
         LiR3clKnE38Y8A1BOZ0mZyO/PlF3ps3X1VFeOV9CcocqDHr8TbX4O1VXPD4g8N/svRat
         5855zAm4HXmcDxfN66vw7+ow1QS3cyDQwD/3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRtKp7QC+YB5u8HTnpR2R+YBfSIQAK3FwGjwQja3fd0=;
        b=KLbrtmgf8jAtt6WQ3GQwrx2IokZO/fKjo1LAQvp261ICm7cuYRQSTR8SrPPYdIzx26
         9VGXMXUltxsIsu0Yz3DEcbChBDFcU1mvV2/oWUhb+y3DsH/6qvW5jer5QntSGrUAecDA
         trH9GhsJmqo0dgGQ1qmgOtgxpLiV9H1ZC6XSUgaGA4TWCA4H2piME+M+JIF/xaf8N8EB
         kKOCQ+Y3Px9NRRVZKvxsNXY0m1dq+iiOl3tWfo+jPcsirZk0i9m13NC2o9lmVH6vN+Fg
         NkijdNaE/sUpPkbowxk3LO9ug4k85VHaFmjeZWkpc/7y2gILKGedpxBrbBZsNKwK2ZxM
         u6pA==
X-Gm-Message-State: AOAM533DvSD/bZiLpasxHVtEtUwjQ/VIs3X1ZHOvuAjXRLhLJ0oi7hXz
        VqGVCf5qOqtfXdSCBvVreUnKaRE2nf06cQSKrzHz1bGwJhMnEg==
X-Google-Smtp-Source: ABdhPJyXFkHar8ENX+hfjavP3x3StuDqTEi+do7ZT25+TlVxR1W6wFgZZ7zRiE+v4UXdUzYIb8FF/+qtwqOjcjCx7sU=
X-Received: by 2002:a9d:7e93:: with SMTP id m19mr151095otp.132.1599645755831;
 Wed, 09 Sep 2020 03:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-5-lmb@cloudflare.com>
 <CAEf4BzaSDWCjCCFQ4mvU2ORVN8CQVHHL4doKipcjo4EC+vm_5A@mail.gmail.com>
In-Reply-To: <CAEf4BzaSDWCjCCFQ4mvU2ORVN8CQVHHL4doKipcjo4EC+vm_5A@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 9 Sep 2020 11:02:24 +0100
Message-ID: <CACAyw9_JsAGse9Uq=Lc+_f-4kHLmddwRztsEcxgR6TLj2B7hdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/11] bpf: check scalar or invalid register in check_helper_mem_access
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Sep 2020 at 05:22, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 4, 2020 at 4:29 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > Move the check for a NULL or zero register to check_helper_mem_access. This
> > makes check_stack_boundary easier to understand.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
>
> Looks good as is, but I'm curious about the question below.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
>
> >  kernel/bpf/verifier.c | 24 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 509754c3aa7d..649bcfb4535e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3594,18 +3594,6 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
> >         struct bpf_func_state *state = func(env, reg);
> >         int err, min_off, max_off, i, j, slot, spi;
> >
> > -       if (reg->type != PTR_TO_STACK) {
> > -               /* Allow zero-byte read from NULL, regardless of pointer type */
> > -               if (zero_size_allowed && access_size == 0 &&
> > -                   register_is_null(reg))
> > -                       return 0;
> > -
> > -               verbose(env, "R%d type=%s expected=%s\n", regno,
> > -                       reg_type_str[reg->type],
> > -                       reg_type_str[PTR_TO_STACK]);
> > -               return -EACCES;
> > -       }
> > -
> >         if (tnum_is_const(reg->var_off)) {
> >                 min_off = max_off = reg->var_off.value + reg->off;
> >                 err = __check_stack_boundary(env, regno, min_off, access_size,
> > @@ -3750,9 +3738,19 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
> >                                            access_size, zero_size_allowed,
> >                                            "rdwr",
> >                                            &env->prog->aux->max_rdwr_access);
> > -       default: /* scalar_value|ptr_to_stack or invalid ptr */
> > +       case PTR_TO_STACK:
> >                 return check_stack_boundary(env, regno, access_size,
> >                                             zero_size_allowed, meta);
> > +       default: /* scalar_value or invalid ptr */
> > +               /* Allow zero-byte read from NULL, regardless of pointer type */
> > +               if (zero_size_allowed && access_size == 0 &&
> > +                   register_is_null(reg))
> > +                       return 0;
>
> Given comment explicitly states "regardless of pointer type",
> shouldn't this be checked before we do pointer type-specific checks?

That's a good question. As I understand it, this the check that the
various comments in check_func_arg refer to:

    /* final test in check_stack_boundary() */

I think "regardless of pointer type" here means: we don't care what
enum arg_type we're dealing with, since all NULL
pointers are represented as SCALAR_VALUE with value 0.

>
> > +
> > +               verbose(env, "R%d type=%s expected=%s\n", regno,
> > +                       reg_type_str[reg->type],
> > +                       reg_type_str[PTR_TO_STACK]);
> > +               return -EACCES;
> >         }
> >  }
> >
> > --
> > 2.25.1
> >



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
