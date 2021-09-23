Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4879E415AB6
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbhIWJS2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 05:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbhIWJS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 05:18:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A3DC061756
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 02:16:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t10so24050948lfd.8
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3z3fvFblHbwGyNeEifaiutquQQndab42p3+bEZbPaY=;
        b=ehYZ35FbL06/k33gaQlumer+Y2K7w4b/gsgRH+nLaLoAJ+RfIvIxoeqGixJ5ddCyJV
         EFArqVGJrVUMgBDanVzNwroPXrRRqJ8z50QkBda1aV4lsV2q71o3Go11h8qznW7MgGmW
         JTyx2v03oqMz/jpxDvVZunxlkTv8TBwgFM/v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3z3fvFblHbwGyNeEifaiutquQQndab42p3+bEZbPaY=;
        b=UL7/EToVNBQIJMXYB46+rpVteTnaEUZUTwNbX/JJxVEwKXEZnrtO83pHkYfc28BbxS
         ZYg1dpk2s3bsw5hHH4VMRX+CsyGw0GESKiTPxt6dbKbS8Sgq+FRo/ZU4Gl4fQLJ40oJB
         asqCeb/AcQ+O8qqExlTEY7fHq8Pct3yXTxYBjghuuZ+JgEHcbtW62j9B+XpwvUiVFuWY
         VTnfDkHbGKYDQas/Cr/vBsBRZ4qJe+X5sr+XG1lN8X7SaSOagIVzEppPKhy2787VjMk3
         pMr2ZT4uv2M6e5UQ9h369TDQzKOY4oXNISgM13B0bSMYvAEbPzIjxYq+xv7stgH7L98B
         xYLA==
X-Gm-Message-State: AOAM531uNqBEGKPZTcEpb7GeYJlp0CVf+kkl3i7FhbYby2s/8f0q08ld
        /TOFkfed7YmqO9+5nVR4vFFi1qWfFLYeEAL8fqLqEA==
X-Google-Smtp-Source: ABdhPJzqPeVApolQp+pqhbBjiqtmMN89VCPBxfINWN/SFzs8PHHKJz9EX1giY+md8Rj7nAR5+bkAHWWROOurBDH6bI0=
X-Received: by 2002:a2e:7c0b:: with SMTP id x11mr3973430ljc.298.1632388614819;
 Thu, 23 Sep 2021 02:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_TjUMu1s46X3jE3ubcszAW3yoj39ADADOFseL0x96MeQ@mail.gmail.com>
 <CAADnVQKxmNDET97wfi-k7L_ot9WXDX7CnqPNe=wK=rXpQJDcyg@mail.gmail.com>
 <CACAyw9_1s2ZCBWTHvT-rGufW+-m3F722GvhHb_rSR3mEr2gfGA@mail.gmail.com>
 <CABEBQi=WfdJ-h+5+fgFXOptDWSk2Oe_V85gR90G2V+PQh9ME0A@mail.gmail.com>
 <CAADnVQKX+ngPV=ZD9+Mm-odr=g-Neqm21TtxZ_rHpt+ybs-8RQ@mail.gmail.com>
 <CABEBQi=aZNfOdPH1999sfpD_dvSiOnhnudH3d=XEuQ=0q_bBCA@mail.gmail.com>
 <CACAyw99oxFvPFCvN5HovoOnJxdKzqbRvfSMCm0Ds-jh3A4XT5Q@mail.gmail.com> <97d6e8ab-7a02-f317-81ed-6f45d26ad3c6@iogearbox.net>
In-Reply-To: <97d6e8ab-7a02-f317-81ed-6f45d26ad3c6@iogearbox.net>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 23 Sep 2021 10:16:43 +0100
Message-ID: <CACAyw9-Ha9RQC_VijJAE02mCX3E09vmDji__Ts8YrsSH4cGiyg@mail.gmail.com>
Subject: Re: bpf_jit_limit close shave
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Frank Hofmann <fhofmann@cloudflare.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Sept 2021 at 22:51, Daniel Borkmann <daniel@iogearbox.net> wrote:
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
>
> The knob with the limit was basically added back then as a band-aid to avoid
> unprivileged BPF JIT (cBPF or eBPF) eating up all the module memory to the
> point where we cannot even load kernel modules anymore. Given that memory
> resource is global, we added the bpf_jit_limit / bpf_jit_current acounting
> as a fix/heuristic via ede95a63b5e8 ("bpf: add bpf_jit_limit knob to restrict
> unpriv allocations"). If we wouldn't account for root, how would such detection
> proposal work otherwise to block unprivileged? I don't think it's feasible to
> only account the latter given privileged progs might have occupied most of the
> budget already.

Thanks, that was the part I was missing. JITed BPF programs are
treated like modules (why?). There is a limited space reserved for
kernel modules.

How does the knob solve the "can't load a new module" problem if our
suggestion / preference is to steer people towards CAP_BPF anyways
(since unpriv BPF is trouble)? Over time all BPF will be privileged
and we're in the same mess again?

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
