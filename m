Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991C5415555
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 04:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbhIWCEr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 22:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbhIWCEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 22:04:46 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A6CC061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 19:03:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 17so4755417pgp.4
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 19:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7qiwpPOEdwX6enSg0zoWEvw2XmC2LUd5AMukx60YJw=;
        b=j+yyk6gCABWGjrF9+EYsYuN0hjrLWX8/MMyXtf3r0IxYE93qpmGTwmrSWeWh2F2ThT
         K5oBuyHli/MmjaRjjgt4CY2NYFLneVk62/T2ydVO8g09U3tGcHWEX6pbEWnC49ojk4+W
         5rcJpWV2W7FCCfpjy2upNvNd2zyt/CpXZ+4/mgJ8hsKSebj0zlANly4Ms+leNzBnT7me
         FmFITbzZQJ6ITD5v5XQOXyRtgQuN32X6d/PL/lmiHAx0oBgnZ9QndsqeJdSiB3kkoCHS
         2NJhq8rvfoA47azNqdVtlJssfjP9koj5DeM+WUU5B41aF2IZk/QLS7NJlZFYLliztRhm
         0hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7qiwpPOEdwX6enSg0zoWEvw2XmC2LUd5AMukx60YJw=;
        b=gU6ozB1kRV7vR5QPBL+eiKez+SKT0GQWX0ivlHOaWKJICemi3h4dA6DBkqhHG9z+k4
         pe6CNoVm1CiWbGMm8RYdFhhVxxzIRez/+OAYXxXGqMFfLQ6S5tyZF0KZM8cd7jKqw8uZ
         8JSFHjM1lc4TwM61vhDN/8tzE0AvPJpsVWXTsZluSU7iFZpfjmBZZbQze9kqgzqf5K4J
         kZ6ZOkftBaTWxlPOAMrX3SfRMqRI6H70QwH6WrbetePyz6mzIwnIm4VlEwnWsW9//QsE
         i8Jtqia8Ngeyl++HEIVVovGIW45J+EzWXILKCoO2zncYXN3MAUg8LQ74MwUTCGdH9RiW
         Nu5w==
X-Gm-Message-State: AOAM530wiaNXLsHGVhvx+bPco5NxCWXjL9i89AvzSW0fguObXuN4IafE
        Q5DLvWjgSgIyrd2SrtYMmNH8eT2aNpa9dicvqPc=
X-Google-Smtp-Source: ABdhPJwH1DXW3/RQCmDH64osli+JTmYyChVMuMF/HrQlLTsYh1xasGewUJ1jgyIUQ7oNgoooSx1PhHREs/EU+8YwEY0=
X-Received: by 2002:a63:5c51:: with SMTP id n17mr1922552pgm.376.1632362595428;
 Wed, 22 Sep 2021 19:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_TjUMu1s46X3jE3ubcszAW3yoj39ADADOFseL0x96MeQ@mail.gmail.com>
 <CAADnVQKxmNDET97wfi-k7L_ot9WXDX7CnqPNe=wK=rXpQJDcyg@mail.gmail.com>
 <CACAyw9_1s2ZCBWTHvT-rGufW+-m3F722GvhHb_rSR3mEr2gfGA@mail.gmail.com>
 <CABEBQi=WfdJ-h+5+fgFXOptDWSk2Oe_V85gR90G2V+PQh9ME0A@mail.gmail.com>
 <CAADnVQKX+ngPV=ZD9+Mm-odr=g-Neqm21TtxZ_rHpt+ybs-8RQ@mail.gmail.com>
 <CABEBQi=aZNfOdPH1999sfpD_dvSiOnhnudH3d=XEuQ=0q_bBCA@mail.gmail.com>
 <CACAyw99oxFvPFCvN5HovoOnJxdKzqbRvfSMCm0Ds-jh3A4XT5Q@mail.gmail.com> <97d6e8ab-7a02-f317-81ed-6f45d26ad3c6@iogearbox.net>
In-Reply-To: <97d6e8ab-7a02-f317-81ed-6f45d26ad3c6@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Sep 2021 19:03:04 -0700
Message-ID: <CAADnVQ+CEj-XTy7Jpk_hzEtsDByTuJjtWpbd_YL8XPcBnqVu2w@mail.gmail.com>
Subject: Re: bpf_jit_limit close shave
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Frank Hofmann <fhofmann@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 22, 2021 at 2:51 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 9/22/21 1:07 PM, Lorenz Bauer wrote:
> > On Wed, 22 Sept 2021 at 09:20, Frank Hofmann <fhofmann@cloudflare.com> wrote:
> >>
> >>> That jit limit is not there on older kernels and doesn't apply to root.
> >>> How would you notice such a kernel bug in such conditions?
> >>
> >> I'm talking about bpf_jit_current - it's an "overall gauge" for
> >> allocation, priv and unpriv. I understood Lorenz' note as "change it
> >> so it only tracks unpriv BPF mem usage - since we'll never act on
> >> privileged usage anyway"
> >
> > Yes, that was my suggestion indeed. What Frank is saying: it looks
> > like our leak of JIT memory is due to a privileged process. By
> > exempting privileged processes it would be even harder to notice /
> > debug. That's true, and brings me back to my question: what is
> > different about JIT memory that we can't do a better limit?

There is nothing special about JIT and kernel module memory.

> The knob with the limit was basically added back then as a band-aid to avoid
> unprivileged BPF JIT (cBPF or eBPF) eating up all the module memory to the
> point where we cannot even load kernel modules anymore. Given that memory
> resource is global, we added the bpf_jit_limit / bpf_jit_current acounting
> as a fix/heuristic via ede95a63b5e8 ("bpf: add bpf_jit_limit knob to restrict
> unpriv allocations"). If we wouldn't account for root, how would such detection
> proposal work otherwise to block unprivileged? I don't think it's feasible to
> only account the latter given privileged progs might have occupied most of the
> budget already.

Right.
At the end it boils down to module_alloc() is not using GFP_ACCOUNT.
It's indeed very similar to rlimit issue we had in the past.
I don't have a preference whether normal kernel mods should be memcg-ed,
but JITed memory certainly can be.
bpf progs memory is already covered.
I think we can do that and then can remove this limit. Just like rlimit.
