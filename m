Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE6B661B06
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 00:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjAHXSI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 Jan 2023 18:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjAHXSH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 Jan 2023 18:18:07 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F3C75E;
        Sun,  8 Jan 2023 15:18:06 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gh17so16139639ejb.6;
        Sun, 08 Jan 2023 15:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=swAeOSxPoqd6eOEXYrgkE8zquyIImkg2oEpvR8IJQyA=;
        b=ShrGtiNep+6LyTsCgXKVo6KcvpUZqu4Hy3mDP+Ce3PcsNy798Z1x4EADEMk2ZfWP4h
         z/p3gUIHWKwYY1Plm4SejVbEXRyH/JaqL4DjX0+llaw/zYOq3RzrojWC63E/APqzKaaS
         rxJRq8QtNdmk/1pjoz2OJ6Kz6H3EQsjq0o6q2flaEDQejG3b1aDN32Mn1sWleQF6xm0T
         Gc+Q4BLWEl/r/FZ/vIYvQ9Yc0e9HxN/yESXsSz8oA7SzqvRVJJL/9qUR+m+NTHSTOLfE
         Fx2HlrfOskRcucNSHb/l/51MII4Z1E7gHAX3Z0/AaCWwOJATZxXhKJaUqNsT65IB9Ryp
         VxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swAeOSxPoqd6eOEXYrgkE8zquyIImkg2oEpvR8IJQyA=;
        b=jHrCsQtRX/WBTRKQ83DOiqfh1iT+mg7c2/O+wca1OhBweOr37CLU6HeiMFU3bE6TrM
         o+OL4971Ze91c4Ac0L14VBaLt5iRTUZma2Z+ROQfshwQHpgrJChuu4FLs7OVRUnmmdvs
         6fKeHuL08icgmNiodA2SjxLkYHEwU26ww78FGHcIluTg2vuVo2trg1Ri/AQYmnnqctGn
         vFZ3k8cQh/UQXTYthjetq80SRtgqQmPtjnp6sJ7J6Bj4qDpNKzxl008EbgeL5UUjM7bE
         tznXVF8iIbYouFpXzGSh5vfF52+Gn/OX9oDazXl8ABg2jjZ+KGdCu3HuRo+EKsqXUsBR
         DrdQ==
X-Gm-Message-State: AFqh2kr3frV1t9OG4HMYm5ZxtXrg7MNM97LTHKMCb3zEfTDIyGI68KQn
        AFmE6nHbavE732QpTGrsT9HJeUVXsAKgPIjkFzk=
X-Google-Smtp-Source: AMrXdXuLm5u2S6WL5f8d1BHoWibYOpUPjSpm4RCAFYJ8IlG4MO4si2rR2Ofrdv+bZAU8cw8svFNNsUDBax+LiLy8z0s=
X-Received: by 2002:a17:907:3a97:b0:84d:3601:4910 with SMTP id
 fh23-20020a1709073a9700b0084d36014910mr252558ejc.633.1673219885266; Sun, 08
 Jan 2023 15:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20230106195130.1216841-1-void@manifault.com> <20230106195130.1216841-2-void@manifault.com>
 <CAADnVQLpK7WXTjF6GS1hcfPXf=8iERJmEeVFfvmG75mJj0DdaA@mail.gmail.com> <Y7jUaDD9V556Px3b@maniforge.lan>
In-Reply-To: <Y7jUaDD9V556Px3b@maniforge.lan>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 8 Jan 2023 15:17:54 -0800
Message-ID: <CAADnVQJJaTXa8Y-aGctrBTjasKzsMDq4nW7Na5X3i8oobpT9NQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add __bpf_kfunc tag for marking kernel
 functions as kfuncs
To:     David Vernet <void@manifault.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 6, 2023 at 6:09 PM David Vernet <void@manifault.com> wrote:
>
> On Fri, Jan 06, 2023 at 05:04:02PM -0800, Alexei Starovoitov wrote:
> > On Fri, Jan 6, 2023 at 11:51 AM David Vernet <void@manifault.com> wrote:
> > >
> > > kfuncs are functions defined in the kernel, which may be invoked by BPF
> > > programs. They may or may not also be used as regular kernel functions,
> > > implying that they may be static (in which case the compiler could e.g.
> > > inline it away), or it could have external linkage, but potentially be
> > > elided in an LTO build if a function is observed to never be used, and
> > > is stripped from the final kernel binary.
> > >
> > > We therefore require some convenience macro that kfunc developers can
> > > use just add to their kfuncs, and which will prevent all of the above
> > > issues from happening. This is in contrast with what we have today,
> > > where some kfunc definitions have "noinline", some have "__used", and
> > > others are static and have neither.
> > >
> > > In addition to providing the obvious correctness benefits, having such a
> > > macro / tag also provides the following advantages:
> > >
> > > - Giving an easy and intuitive thing to query for if people are looking
> > >   for kfuncs, as Christoph suggested at the kernel maintainers summit
> > >   (https://lwn.net/Articles/908464/). This is currently possible by
> > >   grepping for BTF_ID_FLAGS(func, but having something more self
> > >   describing would be useful as well.
> > >
> > > - In the future, the tag can be expanded with other useful things such
> > >   as the ability to suppress -Wmissing-prototype for the kfuncs rather
> > >   than requiring developers to surround the kfunc with __diags to
> > >   suppress the warning (this requires compiler support that as far as I
> > >   know currently does not exist).
> >
> > Have you considered doing bpf_kfunc_start/bpf_kfunc_end ?
> > The former would include:
> > __diag_push(); __diag_ignore_all(); __used noinline
>
> Yeah that's certainly an option. The downside is that all functions
> within scope of the __diag_push() will be affected, and sometimes we mix
> kfuncs with non-kfuncs (including e.g. static helper functions that are
> used by the kfuncs themselves). -Wmissing-prototypes isn't a big deal,
> but __used and noinline are kind of unfortunate. Not a big deal though,
> it'll just result in a few extra __bpf_kfuncs_start() and
> __bpf_kfuncs_end() sprinkled throughout to avoid them being included.
> The upside is of course that we can get rid of the __diag_push()'es we
> currently have to prevent -Wmissing-prototypes.

I meant to use bpf_kfunc_start/bpf_kfunc_end around every kfunc.
Ideally bpf_kfunc_start would be on the same line as func proto
for nice grepping.
Maybe it's an overkill.
Maybe 3 macroses then?
bpf_kfunc_start to hide __diag
bpf_kfunc on the proto line
bpf_kfunc_end to finish __diag_pop

> Wdyt? I do like the idea of getting rid of those ugly __diag_push()'es.
> And we could always go back to using a __bpf_kfunc macro if and when
> compilers ever support using attributes to ignore warnings for specific
> functions.
>
> >
> > Also how about using bpf_kfunc on the same line ?
> > Then 'git grep' will be easier.
>
> Sure, if we keep this approach I'll do this in v2.
