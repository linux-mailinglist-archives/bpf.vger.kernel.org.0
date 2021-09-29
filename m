Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077CF41CFA7
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 01:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347395AbhI2XCu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 19:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347408AbhI2XCr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 19:02:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A040BC06176D
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 16:01:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y1so2598549plk.10
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6OSyQV0vmmlLHPQ/4kHgFG+Zlc1SztloTZgc+/AxpPQ=;
        b=b6Y91s4GpmWUHS65iOdcCmPHPNZUbVVsTlF1yuDYHtZK2KYTvIPJcrgkDepHg0MpfX
         Uk9ndhXAgsciDemB1827Q4fwQTGJKOhHi6zP1HPvhlTaEtxE8wq2cw9VExYTyx2CsxQh
         ynmgrEKdcDcwL25MmY2qhzfF9GdX4m9CiudxSSFQiNXTNONtkGI+HlOG5aeMptLUFAmi
         nYIcmrhPqRz9BV341EiwU/18IcvcikUr7lIncjR3mKLBYHSUrqyrBxYmvPuYmjEi4GBP
         qJ49ydp1f8qErg9ScI2yVVeEISvUHeFBYUySNwxhHLq85yl3d4ea4kKrZrn0ID759atB
         TK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OSyQV0vmmlLHPQ/4kHgFG+Zlc1SztloTZgc+/AxpPQ=;
        b=sIpmZa60JK3xtD9XKcHgcU6TfbvcaxnP+fA7h5RuJ1uW05e4vzGNBEf8feblnSXlhO
         CjJ8l6K2r69rCHr8+mfqG8S5tcl/WR9CC/ZPEtez4yWRgdC9DJORsDP9sERs/GEw8ZDq
         vcVbmIPWTd4doA3Qcr0Fu2xT75gXBaMO/IrbcA51fP70e4GA9MNvPIsq3fpmdgUa8X8y
         ZRebN2fQerUAbvhNmkgBz7tINSV0xM/TooUoxXUyia/ZGL1/aatuhn8vSgUYHVVP/puV
         514DRyQQJeA2jW5ggSlKjRJ/vfjpS6+F1lJBx53Xm+TieNeOo+8+owrQ6tNRPK+1FrgM
         U+Fw==
X-Gm-Message-State: AOAM530/ipn/qXWJHcVok3OfdOLd6Ue3vMc4vIAWqfkC7S8odTPaKm/K
        m0RymVrZmBwIrCZBHz6Ij+tmd/rXX9MxtZnE529Ac0MS7oc=
X-Google-Smtp-Source: ABdhPJxlYi1ZagEIIfJuxtGt41F+yGgElSrrM+mS/xV0xuTHPEwbSGvClQizpM5PlDG47V1+/QJS+FrTfpD1nADW3Fk=
X-Received: by 2002:a17:902:7246:b0:138:a6ed:66cc with SMTP id
 c6-20020a170902724600b00138a6ed66ccmr2324434pll.22.1632956465145; Wed, 29 Sep
 2021 16:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <20210917215721.43491-2-alexei.starovoitov@gmail.com> <20210928164515.46fad888@linux.microsoft.com>
 <20210928163730.7v7ovjhk7kxputny@ast-mbp.dhcp.thefacebook.com>
 <20210928191103.193a9c62@linux.microsoft.com> <CAADnVQ+ajFPKfP+Q5WQFztfZ+05uGgbuQk3H8_9OTny=0vku=g@mail.gmail.com>
 <CAFnufp3hx0CaF=ukCXY3UJj0omVX+5WWk0=-QuENvTPGye_sKA@mail.gmail.com> <20210929193858.57ba3cd1@linux.microsoft.com>
In-Reply-To: <20210929193858.57ba3cd1@linux.microsoft.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Sep 2021 16:00:54 -0700
Message-ID: <CAADnVQJjHyB1CwquYx2X2uMGygEpFJhNh75gPcHnYkD2pLmcDA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel duty.
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Matteo Croce <mcroce@microsoft.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 29, 2021 at 10:39 AM Matteo Croce
<mcroce@linux.microsoft.com> wrote:
> > >
> > > I'll take a look. Could you provide the full .c file?
> >
> > Sure. I put everything in this repo:
> >
> > https://gist.github.com/teknoraver/2855e0f8770d1363b57d683fa32bccc3

This gist is not a reproducer. It doesn't have a single CO-RE relo.

But I've hacked it with dev->ifindex like in your email above
and managed to repro.
My error is different though:
[ 1127.634633] libbpf: prog 'prog_name': relo #0: trying to relocate
unrecognized insn #0, code:0x85, src:0x0, dst:0x0, off:0x0, imm:0x7
[ 1127.636003] libbpf: prog 'prog_name': relo #0: failed to patch insn #0: -22

But there is a bug. Debugging...
