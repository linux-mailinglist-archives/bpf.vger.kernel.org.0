Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D376B17E7
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 01:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCIAdI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 19:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCIAdH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 19:33:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B49D1A973
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 16:33:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so540662pja.5
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 16:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678321984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NX69L/y4AvylfjHZlVGoJXMkTEsL+QP4IGqtRYKSS0=;
        b=mNY9mNONo56A6D7ojY2BrqryoFhUyIAQtfXJpJvmE2gs5w3cg1pAQoBdQNGNHF+QUS
         b0CLeiMR7kcrpwWTO30tUnGmYyvfsDOkVijxQNfDsIbjWtqGTVYzxiax9Uo+5cVXz2t2
         5icD3pOeHfMV7v8+s1+w4L4TJRBQZEsu0vtPI4PHIU3tzMgw0zq5UZ+1DK1+/IQ4Q6ma
         SHLR9+GFV6bm7vFVhXihCMrpW5Mu9lxK1WqgzEFbeAEUqC00aRlE1noJnr1VIMjQmhoD
         PpdXvr6SbwiCYHjYgbX7+ydIqXGAeApfPi1dX4fzHct/D4VxXrPNgdGZSJ+MDxIr78KN
         nCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678321984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NX69L/y4AvylfjHZlVGoJXMkTEsL+QP4IGqtRYKSS0=;
        b=7lZ23gmXjoIF/tFFSdoCxlizYHROR+8KQohBDp4LiKo5uyl7V5WK9GooYapElKW8sQ
         1j8ezyV3nJV5gPXC0X99fOuq0B7nR6MWAYBSKswachHvr2FGXz5j9zbOuahN1MCny82a
         0jU7pqYGfHJ2m5uXNpsXg1hCqCMbYEQOWF0auPISpIg6kcOcxTwUm3ggKbNqY2dHndal
         fFcVOP9s+35CsdWKkuVlRjYMo/CJ82xFInpWurHvwb7LpT0lyB6BTDhkYqQuwtAJ+2kq
         a+I7V22J9ROBujjmkqiZZpxY4Bta0WUVzl49F+YDyDnof59ALJMRIb8klo1aHsuO6QnW
         NKiw==
X-Gm-Message-State: AO0yUKUxV0RAD012Ry0lCTDRT7VljqeOPmlRU2exh2jf4KxrU7zVV0vh
        tChZsYMdRtp1tN03ewNbrAbs0Nb5yTh5w9n0ZNoSaQ==
X-Google-Smtp-Source: AK7set+yVTwl/Hj6Yzw5umIz4qWrd0uciAr8L27IGj2EfxXvJSf0wfrTrTYSmqZnqhMDEkdVNw4F3K4YQXUXA9UBY54=
X-Received: by 2002:a17:90a:c257:b0:233:bada:17b5 with SMTP id
 d23-20020a17090ac25700b00233bada17b5mr7427704pjx.4.1678321983734; Wed, 08 Mar
 2023 16:33:03 -0800 (PST)
MIME-Version: 1.0
References: <tencent_5695A257C4D16B4413036BA1DAACDECB0B07@qq.com>
 <Y7cbM1D2YvB9tdqg@google.com> <20230309003055.GA6586@zen>
In-Reply-To: <20230309003055.GA6586@zen>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 8 Mar 2023 16:32:52 -0800
Message-ID: <CAKH8qBudQgQO0CtGYJ+A-xyic0tooTWijQPrJnPVQAvZTFizrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: poison strlcpy()
To:     Boris Burkov <boris@bur.io>
Cc:     Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, rongtao@cestc.cn,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 8, 2023 at 4:30=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Jan 05, 2023 at 10:47:15AM -0800, sdf@google.com wrote:
> > On 01/05, Rong Tao wrote:
> > > From: Rong Tao <rongtao@cestc.cn>
> >
> > > Since commit 9fc205b413b3("libbpf: Add sane strncpy alternative and u=
se
> > > it internally") introduce libbpf_strlcpy(), thus add strlcpy() to a p=
oison
> > > list to prevent accidental use of it.
> >
> > > Signed-off-by: Rong Tao <rongtao@cestc.cn>
> >
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> >
> > > ---
> > >   tools/lib/bpf/libbpf_internal.h | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > > diff --git a/tools/lib/bpf/libbpf_internal.h
> > > b/tools/lib/bpf/libbpf_internal.h
> > > index 377642ff51fc..2d26ded383ca 100644
> > > --- a/tools/lib/bpf/libbpf_internal.h
> > > +++ b/tools/lib/bpf/libbpf_internal.h
> > > @@ -20,8 +20,8 @@
> > >   /* make sure libbpf doesn't use kernel-only integer typedefs */
> > >   #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
> >
> > > -/* prevent accidental re-addition of reallocarray() */
> > > -#pragma GCC poison reallocarray
> > > +/* prevent accidental re-addition of reallocarray()/strlcpy() */
> > > +#pragma GCC poison reallocarray strlcpy
>
> On my musl system, I believe this broke compilation, as string.h defines
> strlcpy, and is included after this poisoning when compiling strset.c
>
> FWIW, I could work around it by adding
> #include <string.h>
> above
> #include <libbpf_internal.h>
> in strset.c, since the poison doesn't apply to symbols that existed
> before it ran, but this feels like a kludge, and not in the spirit of
> the original poisoning patch..
>
> I'm curious what the proper workaround should be for a libc that defines
> strlcpy.

Let's move this discussion into [0]? There is a similar issue for
uclibc it seems.

0: https://lore.kernel.org/bpf/CAKH8qBshq-J2H+Bo1xA=3DFzAJ6x_mo5yfW6oYjQ_u1=
QwLJ5CDog@mail.gmail.com/T/#t

> Thanks,
> Boris
>
> >
> > >   #include "libbpf.h"
> > >   #include "btf.h"
> > > --
> > > 2.39.0
> >
