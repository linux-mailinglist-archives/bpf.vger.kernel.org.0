Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E414136AE
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhIUPxr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 11:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbhIUPxq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 11:53:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B117DC061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 08:52:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b20so24920892lfv.3
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ksngeam0Xf2lt6zbmcmQsyjfYbHt+0kmGquFy1tUzlI=;
        b=VPDTSHaxi3TsbVwWuceuSLk9aYTqZBIZUsmCbR+kQufFPSKF3LXXGG+B2pSDJ5sSAk
         FKiW6zIKSKWoIHfwnSEkLD2o76eD6NMuqf0mCqeYBi1wmDL7NK64OIiLFprOHFh4bhu0
         Ar9oCVQy7eM+V6x4AEEmkFBQCVQRifhfxnRq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ksngeam0Xf2lt6zbmcmQsyjfYbHt+0kmGquFy1tUzlI=;
        b=jwrovGJBsYKKXn4+XxFmNLm9+mbBeQj/xfNKVRE79gzbaBsQa4gjlAU2OPA6Sk1epu
         A6xVdSxHnyGJM/D079bwUx3klYz/Oa6h82lZYOLMomxWesYm7POjppmtvQ0/jE8pN199
         ynr1Vwvc8mnyQ5xlE8WZs9NSfnl7wcCLUSLWd8UFHF4YhtE0StGZpX/cy0IgYeNC/kUk
         KF0Sahb1/exGpAWD5kl++DzrhUIbaTUmonyw3GmRslwjVFDNOW9EVVH25UepTtDf7CPq
         12rWDn91jfJM7XNJObczP6bEPoKoUhGGM9CV0oeKzhbq3a/VaSc/1nfAVWh9kraFIW+p
         SGOg==
X-Gm-Message-State: AOAM530I7wSJsAHxZaT54vXZVWIAHSpycRzgww3x9eq1biknh34OFAtB
        0ofGFXP433pC+v3ZdKVIl6iG95uEtgm7DmdbLzpc2A==
X-Google-Smtp-Source: ABdhPJxqPBiZlmPvQNUtCGj7y27W1eFSuaDA7t8bzNlfSqNuTnVN+DTz7tU1+LntWKA4rkzB+kEvjoXGe/aR3dVt51A=
X-Received: by 2002:ac2:4c45:: with SMTP id o5mr24876482lfk.620.1632239534457;
 Tue, 21 Sep 2021 08:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_TjUMu1s46X3jE3ubcszAW3yoj39ADADOFseL0x96MeQ@mail.gmail.com>
 <CAADnVQKxmNDET97wfi-k7L_ot9WXDX7CnqPNe=wK=rXpQJDcyg@mail.gmail.com>
In-Reply-To: <CAADnVQKxmNDET97wfi-k7L_ot9WXDX7CnqPNe=wK=rXpQJDcyg@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 21 Sep 2021 16:52:03 +0100
Message-ID: <CACAyw9_1s2ZCBWTHvT-rGufW+-m3F722GvhHb_rSR3mEr2gfGA@mail.gmail.com>
Subject: Re: bpf_jit_limit close shave
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 21 Sept 2021 at 15:34, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 21, 2021 at 4:50 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > Does it make sense to include !capable(CAP_BPF) in the check?
>
> Good point. Makes sense to add CAP_BPF there.
> Taking down critical networking infrastructure because of this limit
> that supposed to apply to unpriv users only is scary indeed.

Ok, I'll send a patch. Can I add a Fixes: 2c78ee898d8f ("bpf:
Implement CAP_BPF")?

Another thought: move the check for bpf_capable before the
atomic_long_add_return? This means we only track JIT allocations from
unprivileged users. As it stands a privileged user can easily "lock
out" unprivileged users, which on our set up is a real concern. We
have several socket filters / SO_REUSEPORT programs which are
critical, and also use lots of XDP from privileged processes as you
know.

>
> > This limit reminds me a bit of the memlock issue, where a global limit
> > causes coupling between independent systems / processes. Can we remove
> > the limit in favour of something more fine grained?
>
> Right. Unfortunately memcg doesn't distinguish kernel module
> memory vs any other memory. All types of memory are memory.
> Regardless of whether its type is per-cpu, bpf map memory, bpf jit memory, etc.
> That's the main reason for the independent knob for JITed memory.
> Since it's a bit special. It's a crude knob. Certainly not perfect.

I'm missing context, how is JIT memory different from these other kinds of code?

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
