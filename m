Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA34417061
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhIXKgt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 06:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhIXKgr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 06:36:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC40C061574
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 03:35:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u18so37359391lfd.12
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 03:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwFS8WDBlz3NRZSvLaj01AFRMt3AHMjmTILkP1jgVPY=;
        b=OUsU8txczNjhF+xPHOMIWGe3vLIgXh5vhnv4B9jPejtJ/KUiMoQ/JvNoGES2RAVxWi
         Z712t8krkZBi8Ii0nAew7CHl399eN9VZA2s1orSLHX4dazRCdKduHehZ0cBGHGpTaZRc
         Ysqj0RYqJ5ZSHQ2LXJjMS4tN0G2oQDRX8y4sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwFS8WDBlz3NRZSvLaj01AFRMt3AHMjmTILkP1jgVPY=;
        b=P01BNZlQx3yqQrn98iAsPh1J5Zii9yYHb2eDLYGVxmSSK5BFiDCdJHm8Cm/zVhGo2X
         N0339QwigHgaiD+q9RpQhu2wkmRViNI9vNq470SXHuEnYKKwvLaY7pusOgl9HMNa6hxR
         hZp+Fb3UNVujdkd5tTS0kvO5JKV6dktSg3VUihEWptEQk7KcaxZgvJr14svmbHYyA0w+
         2Gm5FlOvUABx5CnaWob1YWHSsN2gIBfgIPpmIwoSiCxzASBT69T+bs/b6bitt7C/ynrH
         kCmrJDnjHVZDAiWGYzrBVZO+hcUypxe4fX48mwYW/5EhLnr5fXtTUMyM7CeIcvGWcfQx
         J+zg==
X-Gm-Message-State: AOAM530qWsWmV4sa7Ek7v9LfJsgxwG5K3x7wYNj2GWY4LwLF9aiVNUCS
        KsCfrGedk5jaSqfEsJYKFvGyzR7mPuMAL58IsQHg2z+mLwY=
X-Google-Smtp-Source: ABdhPJzmGvWBpyUjHth6A3Jmq/nN1mKPzyjAbsYPFQ6sCnFf8/vglpxTiJq4NfJfYlMYTEUvuND3dBxRm9Kc4IoBwrI=
X-Received: by 2002:a2e:8852:: with SMTP id z18mr10742235ljj.412.1632479712303;
 Fri, 24 Sep 2021 03:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_TjUMu1s46X3jE3ubcszAW3yoj39ADADOFseL0x96MeQ@mail.gmail.com>
 <CAADnVQKxmNDET97wfi-k7L_ot9WXDX7CnqPNe=wK=rXpQJDcyg@mail.gmail.com>
 <CACAyw9_1s2ZCBWTHvT-rGufW+-m3F722GvhHb_rSR3mEr2gfGA@mail.gmail.com>
 <CABEBQi=WfdJ-h+5+fgFXOptDWSk2Oe_V85gR90G2V+PQh9ME0A@mail.gmail.com>
 <CAADnVQKX+ngPV=ZD9+Mm-odr=g-Neqm21TtxZ_rHpt+ybs-8RQ@mail.gmail.com>
 <CABEBQi=aZNfOdPH1999sfpD_dvSiOnhnudH3d=XEuQ=0q_bBCA@mail.gmail.com>
 <CACAyw99oxFvPFCvN5HovoOnJxdKzqbRvfSMCm0Ds-jh3A4XT5Q@mail.gmail.com>
 <97d6e8ab-7a02-f317-81ed-6f45d26ad3c6@iogearbox.net> <CACAyw9-Ha9RQC_VijJAE02mCX3E09vmDji__Ts8YrsSH4cGiyg@mail.gmail.com>
 <53e09160-f30d-7d23-e3d0-8f636cd82117@iogearbox.net>
In-Reply-To: <53e09160-f30d-7d23-e3d0-8f636cd82117@iogearbox.net>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 24 Sep 2021 11:35:01 +0100
Message-ID: <CACAyw9-KSF2ZrFXfmKYY8rzy=zKUg6+9WkYTVG4YMNsr+uCuDg@mail.gmail.com>
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

On Thu, 23 Sept 2021 at 12:52, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> See bpf_jit_alloc_exec() which calls module_alloc() for the images' r+x memory
> holding the generated opcodes, and there's only one such pool for the system
> on the latter: on x86 in particular, the rationale for module_alloc() use is
> so that the image is guaranteed to be within +/- 2GB of where the kernel image
> resides. See the encoding of BPF_CALL with __bpf_call_base + imm32, for example.

Thanks, makes a lot more sense now. I sent some more clean up patches your way.

> > How does the knob solve the "can't load a new module" problem if our
> > suggestion / preference is to steer people towards CAP_BPF anyways
> > (since unpriv BPF is trouble)? Over time all BPF will be privileged
> > and we're in the same mess again?
>
> Keep in mind that the knob was added before CAP_BPF. In general, unprivileged
> cBPF->eBPF is also using the same bpf_jit_alloc_exec() for the JIT, so that
> needs to be taken into consideration as well, but if you grant an application
> CAP_BPF then you're essentially privileged. The knob's point was to prevent
> fully unprivileged users to play bad games.

You're right, it does help with that. Now, how do I solve the problem
of our privileged (but automated!) tooling eating up all the memory
anyways?

As an aside: it's _really_ hard (impossible?) to track down where this
memory is used. cbpf -> ebpf conversions don't show up in bpftool,
where does one go to look?

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
