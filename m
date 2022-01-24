Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593C1498492
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbiAXQV7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 11:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243642AbiAXQV6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 11:21:58 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DBBC06173B
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 08:21:58 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i62so4456256ioa.1
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 08:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nm1qwEi8bHEN6BRmyZX7p8WAjWAuqT/uxFxvafemUko=;
        b=CnSRzPdEkADFaLFY8FIJslaQYwpd/FrH16Yfk2i8wNL06p6p02ADXr4MEGkwhBowfd
         6Z6D0RIeXVMv/pSDPiWzDogNor046WOkFvso7Wc28gb2sNRmLqzKQun6YckqKV39q2bx
         YpYjd6SUSQ+7kAMrRulNvF8pS4F/6MvenZOSKIzKX1GO7iH6WAom10yQdRApXy68ldXo
         9vvBjIO5QNOKAa40qPJDlbBG8lFF4g94o4fcKI59XURCN79mAkAZpA4yFvmmL3yBqiC1
         XoyKy7W2rltN32EynPtOIKSPhxmKlTQ0L85JYIndo2I3h3/jipSUXnm4piGGV811VyfR
         AUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nm1qwEi8bHEN6BRmyZX7p8WAjWAuqT/uxFxvafemUko=;
        b=26NHw+0puB0CcoNwJc0/okQf3RVljCpjuL9yWfn04IClN2stl1kYm6wHoa4AAXQp31
         Zx7xLx2gEiA7KOQTO4Np9yGAeLC/vQ9zTsUgdflGvxkLsu5m1AjC7nPyIs0G5EcejlmF
         Tf61hDGW6aFB+uCdocS/xl3aRAfYFg+mzq8vY3WSZef4hN9emohMRJ9FhenWNkQDRXC2
         IZJ98+hI6szugRNoLpJzf4yicfKdxaxUyZp0p9EkYwQmhNsOMq8GHYeETZ8u/hYrY8NY
         xBD9KBeujf+s1xZXM4dbDiQ7trgXZHD5SLtZmBpylO/hC8Y3HJMJrnfBt/f6Ejvc4Odr
         0ihg==
X-Gm-Message-State: AOAM530UUpGW8hpu/KkV0NjEco6vUiqJDSL4JAxAOMsKmgtJiGSKpPjY
        fhn+tfAg+VMH2aovNWwdU9LfVavK+e76Mmkevktw5zMp
X-Google-Smtp-Source: ABdhPJyPTscrvD1jKAkfiWNaoSAgvjr8yZiqfywbXHmGujjVQCPfn++S9Il+QfNykL7ap5YS+twQOmruyNzRmP6XhWg=
X-Received: by 2002:a6b:ee16:: with SMTP id i22mr2725277ioh.63.1643041317523;
 Mon, 24 Jan 2022 08:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20220120060529.1890907-1-andrii@kernel.org> <20220120060529.1890907-4-andrii@kernel.org>
 <87wniu7hss.fsf@toke.dk> <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
 <87lez87rbm.fsf@toke.dk> <e58aabf9-af55-8eac-1047-b18801141d80@gmail.com>
In-Reply-To: <e58aabf9-af55-8eac-1047-b18801141d80@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jan 2022 08:21:46 -0800
Message-ID: <CAEf4BzaiZz3mW97qXX=Ee5nQS=oRk8zOcv7LMw9r-P4w9k5RPA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map definitions
To:     David Ahern <dsahern@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 2:04 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 1/21/22 1:43 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >
> >> On Thu, Jan 20, 2022 at 3:44 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
> >>>
> >>> Andrii Nakryiko <andrii@kernel.org> writes:
> >>>
> >>>> Enact deprecation of legacy BPF map definition in SEC("maps") ([0]).=
 For
> >>>> the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITIONS f=
lag
> >>>> for libbpf strict mode. If it is set, error out on any struct
> >>>> bpf_map_def-based map definition. If not set, libbpf will print out
> >>>> a warning for each legacy BPF map to raise awareness that it goes
> >>>> away.
> >>>
> >>> We've touched upon this subject before, but I (still) don't think it'=
s a
> >>> good idea to remove this support entirely: It makes it impossible to
> >>> write a loader that can handle both new and old BPF objects.
> >>>
> >>> So discourage the use of the old map definitions, sure, but please do=
n't
> >>> make it completely impossible to load such objects.
> >>
> >> BTF-defined maps have been around for quite a long time now and only
> >> have benefits on top of the bpf_map_def way. The source code
> >> translation is also very straightforward. If someone didn't get around
> >> to update their BPF program in 2 years, I don't think we can do much
> >> about that.
> >>
> >> Maybe instead of trying to please everyone (especially those that
> >> refuse to do anything to their BPF programs), let's work together to
> >> nudge laggards to actually modernize their source code a little bit
> >> and gain some benefits from that along the way?
> >
> > I'm completely fine with nudging people towards the newer features, and
> > I think the compile-time deprecation warning when someone is using the
> > old-style map definitions in their BPF programs is an excellent way to
> > do that.
> >
> > I'm also fine with libbpf *by default* refusing to load programs that
> > use the old-style map definitions, but if the code is removed completel=
y
> > it becomes impossible to write general-purpose loaders that can handle
> > both old and new programs. The obvious example of such a loader is
> > iproute2, the loader in xdp-tools is another.
> >
>
> I agree with Toke's response.
>
> 2 years is a very small amount of time when it comes to OS and kernel
> versions. Many companies base products on enterprise distributions and
> run them for 10+ years. During that time there will be needs to update
> some components - like kernel version or some tool but that is done with
> the least amount of churn possible. Every update has the potential to
> bring in unknown behavior changes. Requiring updates to entire tool
> chains, multiple tool sets and libraries to accommodate some deprecation
> will only hinder being able to update anything.
>
> Further, programs (e.g., debugging as just one example) can and will
> need to be used across many OS and kernel versions.

Which is why all the things that are being deprecated have better
alternatives that work *right now* with libbpf v0.x and will keep
working with v1.x.
