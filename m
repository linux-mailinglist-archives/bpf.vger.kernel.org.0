Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0BB41474D
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 13:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhIVLJS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 07:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhIVLJR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 07:09:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FACC061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 04:07:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so10351893lfu.5
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 04:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W053b4RWaE3EMxiLFccx8qmIzwMmkF7carMB+OeLG4E=;
        b=rHuTNhy55kUY+uKFcg4euHTJObj7n8PSqsKIDwq0HXGmY2lyKHrnUIClVoNMEyA7HX
         QJeQfciRefxweDNae2RwEbRRNT9F5sftQ15EZG8316/vJ6m7UQzshuICjqufnAkoG5Kl
         7U8iKjA+Gp7hDRjPAdLbjhnsxhFJYx0IM1Bwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W053b4RWaE3EMxiLFccx8qmIzwMmkF7carMB+OeLG4E=;
        b=7j8A/oqtqvxXv6Cx8/FhZO99aYziO2KrpFE7smzicylr60JXmC2xMGF61gouXfROyM
         Gp+u3qnmTD9cd09/dkpr58n7ZUd6ky0Pglb64xEiO4GqFoy5m4Gm1DJsCV9jvKqo73El
         TrY/ukRw4dqu8ZNFamcSokC0UTHewtSXMxX1QwpTwYIkszvF/5BXVgso3nCJJTysujDY
         JFLR4OZR1hSpS4/jKWvbc7MR1VT1AyN8QHZT6yz93pIFx03trHF8Lkp8edbj2JcdPYvJ
         Z8pIKoRlXxXyyZ5Gx+fZSEl0Xwd+VAHnvPsMC/fBDzxLf3bftf4R2yKMx23vhCxeaKL2
         tMLQ==
X-Gm-Message-State: AOAM532Pk6XVKOr4nv8ZyVwWhizUGo/L5w+3lAlRX+kCs36C4CX3o+kH
        P5tTTX0sU7pDXLWY7gVxl9Ds/sX2LL0r9NJkMI8oyg==
X-Google-Smtp-Source: ABdhPJzq+/+dMKBzJosuTnLNcDfOOxjmWC/EbDc5FlaUxkgEu5spNuFmCUveT4OMY+Q4gfL3Czve87+uBrlN+KFbHFA=
X-Received: by 2002:a05:6512:38a8:: with SMTP id o8mr28965758lft.97.1632308866352;
 Wed, 22 Sep 2021 04:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_TjUMu1s46X3jE3ubcszAW3yoj39ADADOFseL0x96MeQ@mail.gmail.com>
 <CAADnVQKxmNDET97wfi-k7L_ot9WXDX7CnqPNe=wK=rXpQJDcyg@mail.gmail.com>
 <CACAyw9_1s2ZCBWTHvT-rGufW+-m3F722GvhHb_rSR3mEr2gfGA@mail.gmail.com>
 <CABEBQi=WfdJ-h+5+fgFXOptDWSk2Oe_V85gR90G2V+PQh9ME0A@mail.gmail.com>
 <CAADnVQKX+ngPV=ZD9+Mm-odr=g-Neqm21TtxZ_rHpt+ybs-8RQ@mail.gmail.com> <CABEBQi=aZNfOdPH1999sfpD_dvSiOnhnudH3d=XEuQ=0q_bBCA@mail.gmail.com>
In-Reply-To: <CABEBQi=aZNfOdPH1999sfpD_dvSiOnhnudH3d=XEuQ=0q_bBCA@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 22 Sep 2021 12:07:35 +0100
Message-ID: <CACAyw99oxFvPFCvN5HovoOnJxdKzqbRvfSMCm0Ds-jh3A4XT5Q@mail.gmail.com>
Subject: Re: bpf_jit_limit close shave
To:     Frank Hofmann <fhofmann@cloudflare.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Sept 2021 at 09:20, Frank Hofmann <fhofmann@cloudflare.com> wrote:
>
> > That jit limit is not there on older kernels and doesn't apply to root.
> > How would you notice such a kernel bug in such conditions?
>
> I'm talking about bpf_jit_current - it's an "overall gauge" for
> allocation, priv and unpriv. I understood Lorenz' note as "change it
> so it only tracks unpriv BPF mem usage - since we'll never act on
> privileged usage anyway"
>
> FrankH.

Yes, that was my suggestion indeed. What Frank is saying: it looks
like our leak of JIT memory is due to a privileged process. By
exempting privileged processes it would be even harder to notice /
debug. That's true, and brings me back to my question: what is
different about JIT memory that we can't do a better limit?

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
