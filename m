Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349403CB074
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 03:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhGPBgy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 21:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhGPBgy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 21:36:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8754C06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 18:33:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x17so10768318edd.12
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 18:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqfPm7n9mmtUNCMqhLdtt5OcRXG3sToNZqhH1obngdI=;
        b=HfFKCzZJxKfJZE8FqNCvFimsxJrisrrjPU1E6VOoFN6mBzBEaiG48d10/BpEM+/0EB
         bgu3X59JpgajFyzxyprGoQPZkVA+UYJvTjRfWraGPPLoBM01VpNFTtV1fAekO5eMP+qb
         AWCbCp+zaVMJw43XcWGK7WasLq4bxyVwsvtaLa0qArfhn5FtFjZFt87pA64NAh1lB+0v
         NoxsXvvmlXbHWmyQXM3huyEXDGhe8MYb/p/R+HDEaOlWoUCDDaVkIu05Vx+aIb7n/4AZ
         9aKH34idSuDEFPDChqCjK0YgnDOJ1t9G1yp3htZ7EXXS+8sSJKgWdpfJ8tpCb+dDIgBd
         Jg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqfPm7n9mmtUNCMqhLdtt5OcRXG3sToNZqhH1obngdI=;
        b=pRoM27xSfyQU2ciQnW+Zczxt6Wz+cgEfCiJjIN3xrUHS7JjV3faSBGwdGybU/RGOmf
         0KXtDAWOZ4gj7sL/C68qDq2csf0uvS65F24Gx5fnj++4HR53veipnVX4uP4KmVcRIsSk
         IrH2QaMSR/JCL+0IKNRNhSeAn/0Q935yFy4uSi8xku1M70pVzK61KP6j3F4yPok8Zlza
         xWvjXkJeniFvtrA2MH1Yv2ZnERwntgyYC0CQM4kvEz6gfrACigrO+rCOh3Wpj9W6NDGF
         20SM8vaF+xOX7gsNZAqxDOnBX/4GyA3NpWKbrtNAd4biPHYAFwSoCRl3l6WD+OXkNKaH
         XH/g==
X-Gm-Message-State: AOAM5306RvOV278lZqCdZaq2v3LKg78E/tgcAtzNv7U/rDuAinZV7ItP
        DzPLxqP0a5XOUCOllLF3QLNJ4qAl3pxTjrpOKmY=
X-Google-Smtp-Source: ABdhPJxwF5VdZbAb68dJQqfpxobBGE11zqB3bR2+oUFnfOO//D1vxYzZU+MIJkIwC1GBoXbVBDybPNJd/FulvskL3qs=
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr11181468eds.166.1626399237409;
 Thu, 15 Jul 2021 18:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <c43bc0a9-9eca-44df-d0c7-7865f448cc24@gmail.com>
 <92121d33-4a45-b27a-e3cd-e54232924583@fb.com> <79e4924c-e581-47dd-875c-6fd72e85dfac@gmail.com>
 <6c6b765d-1d8e-671c-c0a9-97b44c04862c@fb.com> <85caf3b3-868-7085-f4df-89df7930ad9b@gmail.com>
 <ce2ea7e8-0443-3e78-6cf8-d3105f729646@fb.com> <64cd3e3e-3b6-52b2-f176-9075f4804b7a@gmail.com>
 <497fc0fe-8036-8b79-2c6e-495f2a7b0ae@gmail.com> <CAK3+h2xv-EZH9afEymGqKdwHozHHu=XHJYKispFSixYxz7YVLQ@mail.gmail.com>
 <CAK3+h2zW5ZgnXu0_iMHUMLxmgVd2EAoRFuwAEKVkJwOnxSp56g@mail.gmail.com> <efbbc4bc-5513-82d4-4f00-28c690653509@fb.com>
In-Reply-To: <efbbc4bc-5513-82d4-4f00-28c690653509@fb.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Thu, 15 Jul 2021 18:33:46 -0700
Message-ID: <CAK3+h2xP0_9WgqDbfRC-rzkOSv2FKKsNjHmPvTFy9xALwgw3AA@mail.gmail.com>
Subject: Re: R1 invalid mem access 'inv'
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks Yonghong for looking into this.

On Tue, Jul 13, 2021 at 8:46 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/12/21 4:38 PM, Vincent Li wrote:
> > Hi Yonghong,
> >
> >
> >
> > On Fri, Jun 18, 2021 at 12:58 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >>
> >> Hi Yonghong,
> >>
> >> I attached the full verifier log and BPF bytecode just in case it is
> >> obvious to you, if it is not, that is ok. I tried to make sense out of
> >> it and I failed due to my limited knowledge about BPF :)
> >>
> >
> > I followed your clue on investigating how fp-200=pkt changed to
> > fp-200=inv in https://github.com/cilium/cilium/issues/16517#issuecomment-873522146
> > with previous attached complete bpf verifier log and bpf bytecode, it
> > eventually comes to following
> >
> > 0000000000004948 :
> >      2345: bf a3 00 00 00 00 00 00 r3 = r10
> >      2346: 07 03 00 00 d0 ff ff ff r3 += -48
> >      2347: b7 08 00 00 06 00 00 00 r8 = 6
> > ; return ctx_store_bytes(ctx, off, mac, ETH_ALEN, 0);
> >      2348: bf 61 00 00 00 00 00 00 r1 = r6
> >      2349: b7 02 00 00 00 00 00 00 r2 = 0
> >      2350: b7 04 00 00 06 00 00 00 r4 = 6
> >      2351: b7 05 00 00 00 00 00 00 r5 = 0
> >      2352: 85 00 00 00 09 00 00 00 call 9
> >      2353: 67 00 00 00 20 00 00 00 r0 <<= 32
> >      2354: c7 00 00 00 20 00 00 00 r0 s>>= 32
> > ; if (eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0)
> >      2355: c5 00 54 00 00 00 00 00 if r0 s< 0 goto +84
> >
> > my new code is eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0;
> > that is what i copied from other part of cilium code, eth_store_daddr
> > is:
> >
> > static __always_inline int eth_store_daddr(struct __ctx_buff *ctx,
> >
> >                                             const __u8 *mac, int off)
> > {
> > #if !CTX_DIRECT_WRITE_OK
> >          return eth_store_daddr_aligned(ctx, mac, off);
> > #else
> > ......
> > }
> >
> > and eth_store_daddr_aligned is
> >
> > static __always_inline int eth_store_daddr_aligned(struct __ctx_buff *ctx,
> >
> >                                                     const __u8 *mac, int off)
> > {
> >          return ctx_store_bytes(ctx, off, mac, ETH_ALEN, 0);
> > }
> >
> > Joe  from Cilium raised an interesting question on why the compiler
> > put ctx_store_bytes() before  if (eth_store_daddr(ctx, (__u8 *)
> > &vtep_mac.addr, 0) < 0),
> > that seems to have  fp-200=pkt changed to fp-200=inv, and indeed if I
> > skip the eth_store_daddr_aligned call, the issue is resolved, do you
> > have clue on why compiler does that?
>
> This is expected. After inlining, you got
>     if (ctx_store_bytes(...) < 0) ...
>
> So you need to do
>     ctx_store_bytes(...)
> first and then do the if condition.
>

I got workaround which is not to use eth_store_daddr_aligned, but use
__builtin_memcpy() according to
cilium commit 9c857217834 (bpf: optimized memcpy/memzero with dw-wide copies)

> Looking at the issue at https://github.com/cilium/cilium/issues/16517,
> the reason seems due to xdp_store_bytes/skb_store_bytes.
> When these helpers write some data into the stack based buffer, they
> invalidate some stack contents. I don't know whether it is a false
> postive case or not, i.e., the verifier invalidates the wrong stack
> location conservatively. This needs further investigation.
>
glad to know it is not something silly that I am doing, hope it can be
figured out eventually someday :)

>
> >
> > I have more follow-up in https://github.com/cilium/cilium/issues/16517
> > if you are interested to know the full picture.
> >
> > Appreciate it very much if you have time to look at it :)
> >
> > Vincent
> >
