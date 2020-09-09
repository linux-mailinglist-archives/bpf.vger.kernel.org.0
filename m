Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4E262C85
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgIIJvh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 05:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIJvg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 05:51:36 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D6EC061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 02:51:36 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id r4so431326ooq.7
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4WUXHDWFZvJy1/7jXKeiLjWh2fowCbZTO1qyW7ffHA=;
        b=x8tFfju7N9SPFJQIRlyMKIgWPTGwr/ckd5QsUxiymr2tT7kjeo9p2n8CB0iy6ssTT9
         /OuNHVLjPgrR+Opc7ELkuQYJYUDWBpJ7u/Qr0QYvq4yUE0W+A6cMlmgXFiI3kJYM+bFi
         5jqfjvthqLAn870OM1oWD15E0nuFrDQXOKMDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4WUXHDWFZvJy1/7jXKeiLjWh2fowCbZTO1qyW7ffHA=;
        b=oGYuBPoYdjALadPeKpn95N4reODxYfnj2WKUKgv0VadwLeSTFhryLOMx5wy75gvxU1
         IGAhp3RKa1aqKmYUR0I7rqVny42lzyRmIENJp1fC/uATtHt3fZqJ1RRTYzwbTCVBiHj5
         b7m5jnTK3Qfp3dneZPzuhB0FqnDd4TD4Nk454wUyYPev+BCoXDakHUrSE0wzwmsyUlDJ
         D86WaoDL8HplVpT3E86lV4R6Tmgg6e5wbJfHtEcFdLiGonF26JISOVXjuC2X8TtP32rO
         8vIyWaEWeM3YUKE3Nq6z9NAS32OBvubVC+LZcDlRRVHEfozYWafTIMNMTspruPpluMeY
         oAtw==
X-Gm-Message-State: AOAM5334W9rW1vFIjcCq05o5FjQA5hM3TkeQYcNL4PiL0mkmMc5WfW2i
        o0bNqrdr+3i4qhFujhHf7beidNSj15w2KVs7iKbDTA==
X-Google-Smtp-Source: ABdhPJyxwFuHg09QETQJPjKf+5YBfkECm2EDRA0nTCFbo38bZz0Yog1ECCNEd1nuFDk1uzV/19N099b1CKWh1WZpZXA=
X-Received: by 2002:a4a:3516:: with SMTP id l22mr161854ooa.6.1599645095530;
 Wed, 09 Sep 2020 02:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-2-lmb@cloudflare.com>
 <CAEf4BzbyRGR0zcxcKU3qudgoJnm7gB7qgfOj-5g7u68LyHqxvQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbyRGR0zcxcKU3qudgoJnm7gB7qgfOj-5g7u68LyHqxvQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 9 Sep 2020 10:51:24 +0100
Message-ID: <CACAyw9-8cnMq-Ya0-aEq540mJy8CrgB5FZbtBcJmLSRfzk8vJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] btf: Fix BTF_SET_START_GLOBAL macro
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

On Wed, 9 Sep 2020 at 05:04, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 4, 2020 at 4:30 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > The extern symbol declaration should be on the BTF_SET_START macro, not
> > on BTF_SET_START_GLOBAL, since in the global case the symbol will be
> > declared in a header somewhere.
>
> See below about my confusion. But besides that, is there any problem
> to have this extern in both BTF_SET_START and BTF_SET_START_GLOBAL?
> Are there any problems caused by this? This commit message doesn't
> explain what problem it's trying to solve.

I was getting compilation errors, and moving the extern to match what
the BTF_ID_LIST did fixed it. Of course I now can't reproduce it when
dropping the patch, so the mistake was on my side.

>
> >
> > Fixes: eae2e83e6263 ("bpf: Add BTF_SET_START/END macros")
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >  include/linux/btf_ids.h       | 6 +++---
> >  tools/include/linux/btf_ids.h | 6 +++---
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > index 210b086188a3..42aa667d4433 100644
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
> > @@ -121,7 +121,8 @@ asm(                                                        \
> >
> >  #define BTF_SET_START(name)                            \
> >  __BTF_ID_LIST(name, local)                             \
> > -__BTF_SET_START(name, local)
> > +__BTF_SET_START(name, local)                           \
> > +extern struct btf_id_set name;
> >
> >  #define BTF_SET_START_GLOBAL(name)                     \
> >  __BTF_ID_LIST(name, globl)                             \
> > @@ -131,8 +132,7 @@ __BTF_SET_START(name, globl)
> >  asm(                                                   \
> >  ".pushsection " BTF_IDS_SECTION ",\"a\";      \n"      \
> >  ".size __BTF_ID__set__" #name ", .-" #name "  \n"      \
> > -".popsection;                                 \n");    \
> > -extern struct btf_id_set name;
> > +".popsection;                                 \n");
> >
> >  #else
> >
> > diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> > index 210b086188a3..42aa667d4433 100644
> > --- a/tools/include/linux/btf_ids.h
> > +++ b/tools/include/linux/btf_ids.h
> > @@ -121,7 +121,8 @@ asm(                                                        \
> >
> >  #define BTF_SET_START(name)                            \
> >  __BTF_ID_LIST(name, local)                             \
> > -__BTF_SET_START(name, local)
> > +__BTF_SET_START(name, local)                           \
> > +extern struct btf_id_set name;
> >
> >  #define BTF_SET_START_GLOBAL(name)                     \
> >  __BTF_ID_LIST(name, globl)                             \
> > @@ -131,8 +132,7 @@ __BTF_SET_START(name, globl)
> >  asm(                                                   \
> >  ".pushsection " BTF_IDS_SECTION ",\"a\";      \n"      \
> >  ".size __BTF_ID__set__" #name ", .-" #name "  \n"      \
> > -".popsection;                                 \n");    \
> > -extern struct btf_id_set name;
> > +".popsection;                                 \n");
> >
>
> This diff is extremely misleading. It's actually BTF_SET_END macro.
> Coupled with your commit message, it's double-misleading, because you
> are moving extern declaration from BTF_SET_END (which is used with
> both BTF_SET_START and BTF_SET_START_GLOBAL) to BTF_SET_START. Not
> from BTF_SET_START_GLOBAL to BTF_SET_START (as your commit message
> implies, at least that's how I read it).

Yeah, that's true. Probably that's why I got the commit message wrong
as well. I think this is because the diff heuristics think
__BTF_SET_START() is a function like thing? Adding some indentation
might fix this, but I couldn't find details on what diff does with a
quick search.

>
> >  #else
> >
> > --
> > 2.25.1
> >




--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
