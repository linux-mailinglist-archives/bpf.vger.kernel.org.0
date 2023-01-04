Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A465DC53
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 19:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjADSoX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 13:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjADSoW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 13:44:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41A21C407
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 10:44:20 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id u9so84961285ejo.0
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 10:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2DDAHDQSRyQ9PhvcU6ANfAbI20pNcujAgCys/4e/Bcs=;
        b=LcBUbZKpz1lALYOQJQdOvIFzEaFu4Imff+On3QqTn7GjqKNr7Eq9u5TNat3xb680oy
         39kS2ztG18FkhNJMeje6gAZO3XGsUXiN/3dA8bPCxZdN1H65nt5CjO1eho4kx1JtGVH0
         p3Nqfwaa3psch46WQl5+pHrgx8eyMFSj96xOwCKswJ5nDybwcWhlCNmlA8T5zXcY3me7
         m5B1pQZHmXVFGkmZwM+yeCdOio1lIRYGxZ9q7zaIu8s3fSDTNDKLdXenb1e1Km7K4EVg
         MGHol836zCO9VDRuXvZ/DgVpGZAbLvZjgDwdBNDlqIOt3g5K/0QcjzM27jnDg0qqoZ9d
         xDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DDAHDQSRyQ9PhvcU6ANfAbI20pNcujAgCys/4e/Bcs=;
        b=jn0C0CDZRUBaOrj2CWrjyMW+SaFfR9c+j47lUE0t2wFvm7ROi0L0223lNwQAPkjoZM
         VV4C2CYKgdKGobfGHjyNb3N0Xf1Lp1ao92UT0lt/nPNuHtObTOrI6qvrPkA6OAuAIeCc
         dAIIjQf3SGePr5KFSsiyJdRGSNx4CnvA6lBwI3MMO2AUZdDk4pm4DH9zUK1ZmMMh+oLB
         HQVK86WGTPjHZ4EivB3OuTtWnNk877ru7dzGhEG2tceHHkdB/8oejk8ofgTAdYj9HM9+
         8ztPAvWVmuvFHthexf7r5xvpfhp3bILEO8qCduxi92NBHyzrHzVs0x1pesc/FDHOCvoh
         q4hg==
X-Gm-Message-State: AFqh2kqd29kMv0myG1a4QdGaDYRcUKv5YuQl7zpJNNZda6qzzBclfW4V
        ht9+UHrjHWmI2+6HuhHje8dX07L0w912t8CTEWciDPP3V7A=
X-Google-Smtp-Source: AMrXdXvFxvcxuac6WAfrOyVIPxUBaHlbdeJncl3BgmxLVZ7JrNtzsYBhkrr1pfUtVoYS+0azsv6acF4GxF8auH5jxss=
X-Received: by 2002:a17:906:369b:b0:83d:2544:a11 with SMTP id
 a27-20020a170906369b00b0083d25440a11mr4294780ejc.226.1672857859258; Wed, 04
 Jan 2023 10:44:19 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local> <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan> <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 10:44:07 -0800
Message-ID: <CAEf4Bzb06r3bbkngJDYD-XjHJ1ibW_eqr5JwSBATEqJFM0umuQ@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
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

On Fri, Dec 30, 2022 at 4:42 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 30, 2022 at 03:00:21PM -0600, David Vernet wrote:
> > > >
> > > > Taking bpf_get_current_task() as an example, I think it's better to have
> > > > the debate be "should we keep supporting this / are users still using
> > > > it?" rather than, "it's UAPI, there's nothing to even discuss". The
> > > > point being that even if bpf_get_current_task() is still used, there may
> > > > (and inevitably will) be other UAPI helpers that are useless and that we
> > > > just can't remove.
>
> Sorry, missed this question in the previous reply.

[...]

> > Part of me was trying to find a compromise here to move forward, but
> > honestly, I do agree with you that we should aggressively make
> > everything a kfunc unless we have a good reason not to, dynptr functions
> > included. So I'm willing to walk this suggestion back as well -- let's
> > just make these kfuncs.
>
> Agree that any hard policy like 'only kfuncs from now on' gotta have its limits.
> Maybe there will be a strong reason to add a new helper one day,
> so we can keep the door open a tiny bit for an exception,
> but for dynptr...
> There are kfuncs with dynptr already (bpf_verify_pkcs7_signature)
> So precedent is already made.

bpf_verify_pkcs7_signature() is using dynptr as a pointer to memory.
It's a totally valid and intended use case, to pass memory area of
statically unknown size, yes.

But that's very different from having basic dynptr helpers like
is_null() and trim/advance as kfunc. Such helpers are stable, they
manipulate generic attributes of dynptr: size, offset, underlying
memory pointer. There is nothing unstable and potentially changing
about them.

>
> > Also a reasonable point. My point above was really just a response to
> > your claim in [0] that dynptrs are flawed. It wasn't related to kfuncs
> > vs. helpers.
> >
> > [0]: https://lore.kernel.org/all/20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local/
>
> The flawed part of dynptr I was explaining here:
> https://lore.kernel.org/all/20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com/
>
> It's not that the whole concept of dynptr is flawed,
> but using it as an abstraction on top of skb/xdp.

From original exchange:

> > > So just because there is no perfect way to
> > > handle all the SKB/XDP physical non-contiguity, doesn't mean that the
> > > dynptr concept itself is flawed or not well thought out. It's just
> >
> > I think that's exactly what it means. dynptr concept is flawed.

Must be a lot of typos in here ;) because as written it clearly states
that the whole concept of dynptr is flawed.

But I'm glad we are finally on the same page at least on this point now.


> I don't believe that the extreme performance demands of xdp users are
> compatible with 'lets verify in runtime' philosophy of dynptr.
> I could be wrong. That's why I'm fine adding dynptr_on_top_of_xdp as kfuncs
> and seeing it playing out, but certainly not as a stable helper.
> iirc Martin and Kuba had concerns about bits of dynptr(skb | xdp) too.
> With kfuncs we can iron out the issues while trying to use it whereas
> with helpers we will be stuck for long time in endless mailing list arguments.
> It's a win-win for everyone to switch everything to kfuncs.
