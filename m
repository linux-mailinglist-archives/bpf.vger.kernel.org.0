Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D917B24BBD1
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 14:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgHTMeV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 08:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbgHTMeJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 08:34:09 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99689C061386
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 05:34:09 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id q9so1300917oth.5
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 05:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIs6d/jQFwGlnkZ5L4RtC3BBouLuQNHRbQqNyXKW5UA=;
        b=XPae7+krQuaIKLfqBwHPdeeqh4BCT2yAY1Kx/KY4xCqMP8r+sRNyl0bTAEA1mCUV/6
         W6JulKNVZzjnr/6wCrVOicF//Ednj9hvSSv9Y2pP3FVoJpWIRv3zJ9+vZCTYlPkLOo0W
         BtfK4tT9nkXPhvzon3pOhchSSBcJxqBNfiHZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIs6d/jQFwGlnkZ5L4RtC3BBouLuQNHRbQqNyXKW5UA=;
        b=pC1xr2p9rmcwFIS5tGEWmsbdPHnLAe5Sj1PrwaLaBydetsAe4kwZskRw1dgX5LrS6L
         fIkpjvq0lUdXlrNpF2gV5l7edQEcM1hYFMfWZlu59ilZlGre4v9GLa7Q1tRvSlc3EClS
         ZGsnTNvUgiKuVDL4IZM2GpWBy6xIR/sn7nK8qFGGAYqfTorwixPy9OFdKwgKcDdW0GS1
         56T4jOiP0gDyChgy1f0/b5j0fgXT27GmU4Kblj65ZvvUJ2vj91+MXr/pJ4dGA0zG24++
         8WSvynZok8NoXigNki3hYBKPgbLsSYfHUCFiTcoSGUW1TdTUp5dx/uc1kn+sbF91d7rQ
         euKg==
X-Gm-Message-State: AOAM530gvqgQ/YMTgV//sPLaufOuemI4Mr6sMFgeXZ04CvtVqiqWtqJ4
        tBLoLxZKv/x1IXskpxjvVavaRJP8DVUnoNVibI4T+Q==
X-Google-Smtp-Source: ABdhPJzN7dBfvBuuP0F4Tco7q0JAyPALhhyXQWprRuputnZqvXCVX5jNbqueDmKE8m8pQCaVCnop35OD4eN2Ba1w4w4=
X-Received: by 2002:a9d:6e18:: with SMTP id e24mr1890875otr.132.1597926848493;
 Thu, 20 Aug 2020 05:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200819092436.58232-1-lmb@cloudflare.com> <20200819092436.58232-5-lmb@cloudflare.com>
 <5d64158b-35ed-d28d-9857-6ee725d287f2@fb.com>
In-Reply-To: <5d64158b-35ed-d28d-9857-6ee725d287f2@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 20 Aug 2020 13:33:57 +0100
Message-ID: <CACAyw9_4_PZ1bHd0W-mAN5b0i-ZriTZSxWtoS59baXdRg6wk0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: override the meaning of
 ARG_PTR_TO_MAP_VALUE for sockmap and sockhash
To:     Yonghong Song <yhs@fb.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 19 Aug 2020 at 21:13, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/19/20 2:24 AM, Lorenz Bauer wrote:
> > The verifier assumes that map values are simple blobs of memory, and
> > therefore treats ARG_PTR_TO_MAP_VALUE, etc. as such. However, there are
> > map types where this isn't true. For example, sockmap and sockhash store
> > sockets. In general this isn't a big problem: we can just
> > write helpers that explicitly requests PTR_TO_SOCKET instead of
> > ARG_PTR_TO_MAP_VALUE.
> >
> > The one exception are the standard map helpers like map_update_elem,
> > map_lookup_elem, etc. Here it would be nice we could overload the
> > function prototype for different kinds of maps. Unfortunately, this
> > isn't entirely straight forward:
> > We only know the type of the map once we have resolved meta->map_ptr
> > in check_func_arg. This means we can't swap out the prototype
> > in check_helper_call until we're half way through the function.
> >
> > Instead, modify check_func_arg to treat ARG_PTR_TO_MAP_VALUE* to
> > mean "the native type for the map" instead of "pointer to memory"
> > for sockmap and sockhash. This means we don't have to modify the
> > function prototype at all
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >   kernel/bpf/verifier.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 40 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b6ccfce3bf4c..47f9b94bb9d4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3872,6 +3872,38 @@ static int int_ptr_type_to_size(enum bpf_arg_type type)
> >       return -EINVAL;
> >   }
> >
> > +static int override_map_arg_type(struct bpf_verifier_env *env,
> > +                              const struct bpf_call_arg_meta *meta,
> > +                              enum bpf_arg_type *arg_type)
> > +{
> > +     if (!meta->map_ptr) {
> > +             /* kernel subsystem misconfigured verifier */
> > +             verbose(env, "invalid map_ptr to access map->type\n");
> > +             return -EACCES;
> > +     }
> > +
> > +     switch (meta->map_ptr->map_type) {
> > +     case BPF_MAP_TYPE_SOCKMAP:
> > +     case BPF_MAP_TYPE_SOCKHASH:
> > +             switch (*arg_type) {
> > +             case ARG_PTR_TO_MAP_VALUE:
> > +                     *arg_type = ARG_PTR_TO_SOCKET;
> > +                     break;
> > +             case ARG_PTR_TO_MAP_VALUE_OR_NULL:
> > +                     *arg_type = ARG_PTR_TO_SOCKET_OR_NULL;
> > +                     break;
> > +             default:
> > +                     verbose(env, "invalid arg_type for sockmap/sockhash\n");
> > +                     return -EINVAL;
> > +             }
> > +             break;
> > +
> > +     default:
> > +             break;
> > +     }
> > +     return 0;
> > +}
> > +
> >   static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                         struct bpf_call_arg_meta *meta,
> >                         const struct bpf_func_proto *fn)
> > @@ -3904,6 +3936,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               return -EACCES;
> >       }
> >
> > +     if (arg_type == ARG_PTR_TO_MAP_VALUE ||
> > +         arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
> > +         arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
>
> We probably do not need ARG_PTR_TO_UNINIT_MAP_VALUE here.
>
> Do we need ARG_PTR_TO_MAP_VALUE_OR_NULL? bpf_map_update_elem arg type
> is ARG_PTR_TO_MAP_VALUE.

I did this to be consistent: in a single function definition you
either get the map specific
types or the regular semantics. You don't get to mix and match them.
For the same
reason I included ARG_PTR_TO_UNINIT_MAP_VALUE: the semantics don't make
sense for sockmap, so a function using this doesn't make sense either.

>
> > +             err = override_map_arg_type(env, meta, &arg_type);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> >       if (arg_type == ARG_PTR_TO_MAP_KEY ||
> >           arg_type == ARG_PTR_TO_MAP_VALUE ||
> >           arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
> >



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
