Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A16A417031
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 12:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhIXKUl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 06:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhIXKUk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 06:20:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB6AC061756
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 03:19:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so38388805lfu.5
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 03:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E7oKwrwtYxMEEhZOh0zE+8kX5pr5fhY03A1Bl+EUH6I=;
        b=dnrp+VDtboyOiOhKmk1Al/OD9agags9ctMZ9yC7wNU3AaKCMmzmyiDOJQ88eMQUyej
         p1dTsM5yK/tXdcTjM5oCp6bunzPrquRT3eEyu1+GvHmKJY6g/eiOaviwjZcGbn7tSFoJ
         MRfP5nYSr0sHq9hY4fnzzFnsU91od+StDQiBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E7oKwrwtYxMEEhZOh0zE+8kX5pr5fhY03A1Bl+EUH6I=;
        b=diFiXq56w6XWwbBcAsiFjA0U0PhSqZNJrGjuReoGj/PmYuIxv9jYVcFc7d3g7maL/1
         kujRBpckdSvquzjp+KCmbICK5ZgEzihq0Ov/cTGL/mGhxfKbkWjc9OG9wQM1qZZIY1e1
         3CXKze9RXunTBN9eGvlgatIr0XDlWJAWHZX0wWU2VHNc62LVdtPhDMAWuCpBtlruVKlM
         S12uNCX5kO74th8S7yt7BKmyBXhY6DLlNXyWeFHt6kvIEmpfY8RVRq0ehzDg2UmLRdYK
         Y1sjlR9AKiFuaW7HSneZrQPHDkZOyPytuKntrRYxB96CElbq77EXvf82CgMc83blL/7K
         EsMQ==
X-Gm-Message-State: AOAM533OnOxuuJ6mxS3ba4MVOg5qfp3BdD++x3nZ1lTHGJxBPcrR2dfA
        EHD/a0D8JVJZeHuXJyNfuiai/cnxMXJL55kMiu6lTQ==
X-Google-Smtp-Source: ABdhPJxiGAPx7JunDK0fXRDbJiZS/STJ6yPF0LbSheYR1rzZbtO5pCYXgmeVIPoOSlJwGQLfxGjf33vfe/5AlOQ/Qew=
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr8951215lfr.206.1632478745711;
 Fri, 24 Sep 2021 03:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <87o88l3oc4.fsf@toke.dk> <CACAyw99+KvsJGeqNE09VWHrZk9wKbQTg3h1h2LRmJADD5En2nQ@mail.gmail.com>
 <87tuibzbv2.fsf@toke.dk>
In-Reply-To: <87tuibzbv2.fsf@toke.dk>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 24 Sep 2021 11:18:54 +0100
Message-ID: <CACAyw9_N2Jh651hXL=P=cFM7O-n7Z0NXWy_D9j0ztVpEm+OgNA@mail.gmail.com>
Subject: Re: Redux: Backwards compatibility for XDP multi-buff
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Lorenzo Bianconi <lbianconi@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 23 Sept 2021 at 13:59, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> I don't think it has to be quite that bleak :)
>
> Specifically, there is no reason to block mb-aware programs from loading
> even when the multi-buffer mode is disabled. So a migration plan would
> look something like:

...

> 2. Start porting all your XDP programs to make them mb-aware, and switch
>    their program type as you do. In many cases this is just a matter of
>    checking that the programs don't care about packet length. [...]

Porting is only easy if we are guaranteed that the first PAGE_SIZE
bytes (or whatever the current limit is) are available via ->data
without trickery. Otherwise we have to convert all direct packet
access to the new API, whatever that ends up being. It seemed to me
like you were saying there is no such guarantee, and it could be
driver dependent, which is the worst possible outcome imo. This is the
status quo for TC classifiers, which is a great source of hard to
diagnose bugs.

> 3. Once all your programs have been ported and marked as such, flip the
>    sysctl. This will make the system start refusing to load any XDP
>    programs that are not mb-aware.

By this you mean reboot the system and early in boot change the
sysctl? That could work I guess.

> > 2. Add a compatibility shim for mb-unaware programs receiving an mb fra=
me.
> >
> > We'd still need a way to indicate "MB-OK", but it could be a piece of
> > metadata on a bpf_prog. Whatever code dispatches to an XDP program
> > would have to include a prologue that linearises the xdp_buff if
> > necessary which implies allocating memory. I don't know how hard it is
> > to implement this.
>
> I think it would be somewhat non-trivial, and more importantly would
> absolutely slaughter performance. And if you're using XDP, presumably
> you care about that, so I'm not sure we're doing anyone any favours by
> implementing such a compatibility layer?

I see your point: having a single non-mb-aware program trash
performance is bad for marketing. Better to not let people bump the
MTU in that case.

> > 3. Make non-linearity invisible to the BPF program
> >
> > Something I've wished for often is that I didn't have to deal with
> > nonlinearity at all, based on my experience with cls_redirect [2].
> > It's really hard to write a BPF program that handles non-linear skb,
> > especially when you have to call adjust_head, etc. which invalidates
> > packet buffers. This is probably impossible, but maybe someone has a
> > crazy idea? :)
>
> With the other helpers that we started discussing, I don't think you
> have to? I.e., with an xdp_load_bytes() or an xdp_data_pointer()-type
> helper that works across fragment boundaries I think you'd be fine, no?

I'll take a look!

Lorenz

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
