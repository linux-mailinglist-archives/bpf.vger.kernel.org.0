Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE31F41090E
	for <lists+bpf@lfdr.de>; Sun, 19 Sep 2021 03:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhISBsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Sep 2021 21:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhISBsD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Sep 2021 21:48:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74144C061574
        for <bpf@vger.kernel.org>; Sat, 18 Sep 2021 18:46:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eg28so22806902edb.1
        for <bpf@vger.kernel.org>; Sat, 18 Sep 2021 18:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJEZ06bjYLoyedco4uzVMz2WNbzxKahqFY169ygO2B4=;
        b=ITWEY4nqVkzzwF4+T52QQhk9ns/Vc7RIBYWnIRNqlG33jut+cW40Xr0oxO3FYHMPE8
         bSWBBkJ3Hfvz9qj758wqEqDdzlYYcihaDJmHv5vq57o+wz2GkdxJkciytPRaAGp8DMXy
         E1zY4MTTb7KsSjXBsMxlWGfsEs6nC8x2yJmDuLSmhwh+QPizr8xhW5JvrFEeig1JKF2S
         3AsTr5gMDNcfVTtWBzd6OVz8Q7YWTFDU1M/vQ1E+eKqzswJblm0TnZCdCYqcaLSY7RNt
         q8A6qDN7votJ6rlZyu8C2EDSlBT6xAnGZoRzvy6KK9alUz5AgZiGK2frNGENRtvayybs
         8ZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJEZ06bjYLoyedco4uzVMz2WNbzxKahqFY169ygO2B4=;
        b=GbByJYe5conIcN8beMjNaIMOcUoQKQBSRx33mpeN4S2Hl9RNgazsyEe3E+V0kZz05S
         3jZ6Hn29FldbfS7nvma1kyplBeiQPwTbjrWI2QpYSc43XIogc6DuxQ7jNQ6WUQHozSh8
         J443IEQtpvQPxlZKiIYpy3QrAOJ+kEA3HKPQfSgJ+xYDZfx5iNVWBVLd+AQ9s7DWvgnb
         lgpgTxk7DS7YFLSBT2iXB0DAWCOD668N9lq6EyuVeB+HKt/uedWCztios9rwHo4Vc0L+
         xsggMxQlo0NPoUgwpaQulxUZi6rc2asGBCHXhqeHjHf9+2+M0r1cEMECp8dyZeXkoTzA
         Y7xQ==
X-Gm-Message-State: AOAM5303NWxX1BQgEIvAJQESS6xs7wKxRxkr9HNyqhPi39hXYcm8SMf+
        +lYfg9nayfOwVoNiKbqGc5ldrneyDo919m3+w748juxx0gQ=
X-Google-Smtp-Source: ABdhPJxn7rsQ0qVB1R8khHIiyMhZlzVqVoVTxCFKDHzfyDnfxfABBA0DpeHf7cJC1Tbdw4VIK5AsBsTAkXC7PpzKJrs=
X-Received: by 2002:a17:906:85d8:: with SMTP id i24mr20672167ejy.451.1632015996952;
 Sat, 18 Sep 2021 18:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <c43bc0a9-9eca-44df-d0c7-7865f448cc24@gmail.com>
 <92121d33-4a45-b27a-e3cd-e54232924583@fb.com> <79e4924c-e581-47dd-875c-6fd72e85dfac@gmail.com>
 <6c6b765d-1d8e-671c-c0a9-97b44c04862c@fb.com> <85caf3b3-868-7085-f4df-89df7930ad9b@gmail.com>
 <ce2ea7e8-0443-3e78-6cf8-d3105f729646@fb.com> <64cd3e3e-3b6-52b2-f176-9075f4804b7a@gmail.com>
 <497fc0fe-8036-8b79-2c6e-495f2a7b0ae@gmail.com> <CAK3+h2xv-EZH9afEymGqKdwHozHHu=XHJYKispFSixYxz7YVLQ@mail.gmail.com>
 <CAK3+h2zW5ZgnXu0_iMHUMLxmgVd2EAoRFuwAEKVkJwOnxSp56g@mail.gmail.com>
 <efbbc4bc-5513-82d4-4f00-28c690653509@fb.com> <CAK3+h2xP0_9WgqDbfRC-rzkOSv2FKKsNjHmPvTFy9xALwgw3AA@mail.gmail.com>
In-Reply-To: <CAK3+h2xP0_9WgqDbfRC-rzkOSv2FKKsNjHmPvTFy9xALwgw3AA@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Sat, 18 Sep 2021 18:46:25 -0700
Message-ID: <CAK3+h2wy62A_BAKpuXOsz0Rv45vMwDLgbGaDVL6UQ1ZkDXNA8A@mail.gmail.com>
Subject: Re: R1 invalid mem access 'inv'
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 15, 2021 at 6:33 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> Thanks Yonghong for looking into this.
>
> On Tue, Jul 13, 2021 at 8:46 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 7/12/21 4:38 PM, Vincent Li wrote:
> > > Hi Yonghong,
> > >
> > >
> > >
> > > On Fri, Jun 18, 2021 at 12:58 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> > >>
> > >> Hi Yonghong,
> > >>
> > >> I attached the full verifier log and BPF bytecode just in case it is
> > >> obvious to you, if it is not, that is ok. I tried to make sense out of
> > >> it and I failed due to my limited knowledge about BPF :)
> > >>
> > >
> > > I followed your clue on investigating how fp-200=pkt changed to
> > > fp-200=inv in https://github.com/cilium/cilium/issues/16517#issuecomment-873522146
> > > with previous attached complete bpf verifier log and bpf bytecode, it
> > > eventually comes to following
> > >
> > > 0000000000004948 :
> > >      2345: bf a3 00 00 00 00 00 00 r3 = r10
> > >      2346: 07 03 00 00 d0 ff ff ff r3 += -48
> > >      2347: b7 08 00 00 06 00 00 00 r8 = 6
> > > ; return ctx_store_bytes(ctx, off, mac, ETH_ALEN, 0);
> > >      2348: bf 61 00 00 00 00 00 00 r1 = r6
> > >      2349: b7 02 00 00 00 00 00 00 r2 = 0
> > >      2350: b7 04 00 00 06 00 00 00 r4 = 6
> > >      2351: b7 05 00 00 00 00 00 00 r5 = 0
> > >      2352: 85 00 00 00 09 00 00 00 call 9
> > >      2353: 67 00 00 00 20 00 00 00 r0 <<= 32
> > >      2354: c7 00 00 00 20 00 00 00 r0 s>>= 32
> > > ; if (eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0)
> > >      2355: c5 00 54 00 00 00 00 00 if r0 s< 0 goto +84
> > >
> > > my new code is eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0;
> > > that is what i copied from other part of cilium code, eth_store_daddr
> > > is:
> > >
> > > static __always_inline int eth_store_daddr(struct __ctx_buff *ctx,
> > >
> > >                                             const __u8 *mac, int off)
> > > {
> > > #if !CTX_DIRECT_WRITE_OK
> > >          return eth_store_daddr_aligned(ctx, mac, off);
> > > #else
> > > ......
> > > }
> > >
> > > and eth_store_daddr_aligned is
> > >
> > > static __always_inline int eth_store_daddr_aligned(struct __ctx_buff *ctx,
> > >
> > >                                                     const __u8 *mac, int off)
> > > {
> > >          return ctx_store_bytes(ctx, off, mac, ETH_ALEN, 0);
> > > }
> > >
> > > Joe  from Cilium raised an interesting question on why the compiler
> > > put ctx_store_bytes() before  if (eth_store_daddr(ctx, (__u8 *)
> > > &vtep_mac.addr, 0) < 0),
> > > that seems to have  fp-200=pkt changed to fp-200=inv, and indeed if I
> > > skip the eth_store_daddr_aligned call, the issue is resolved, do you
> > > have clue on why compiler does that?
> >
> > This is expected. After inlining, you got
> >     if (ctx_store_bytes(...) < 0) ...
> >
> > So you need to do
> >     ctx_store_bytes(...)
> > first and then do the if condition.
> >
>
> I got workaround which is not to use eth_store_daddr_aligned, but use
> __builtin_memcpy() according to
> cilium commit 9c857217834 (bpf: optimized memcpy/memzero with dw-wide copies)
>
> > Looking at the issue at https://github.com/cilium/cilium/issues/16517,
> > the reason seems due to xdp_store_bytes/skb_store_bytes.
> > When these helpers write some data into the stack based buffer, they
> > invalidate some stack contents. I don't know whether it is a false
> > postive case or not, i.e., the verifier invalidates the wrong stack
> > location conservatively. This needs further investigation.
> >
> glad to know it is not something silly that I am doing, hope it can be
> figured out eventually someday :)
>
> >
> > >
> > > I have more follow-up in https://github.com/cilium/cilium/issues/16517
> > > if you are interested to know the full picture.
> > >
> > > Appreciate it very much if you have time to look at it :)
> > >
> > > Vincent
> > >

oops, I meant to this one, Finally bring an end to my long time
mystery issue of using
eth_store_daddr() result in "invalid mem access", I need to initialize
the mac address variable
with 0, uninitialized variable also cause "invalid read from stack
off" in kernel 4.9, but not
version above 4.9.
https://github.com/cilium/cilium/pull/17370#issuecomment-922396415
