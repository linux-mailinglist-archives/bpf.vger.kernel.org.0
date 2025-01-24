Return-Path: <bpf+bounces-49701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D78FA1BC76
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C773716FB08
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB02253E6;
	Fri, 24 Jan 2025 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYl7SLWe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B189D224B0E
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744702; cv=none; b=CAMzVhe/zl0oGYkPiv5xIFpiR/HWUBTPYAZCJss/CLQ+hiruIZwwLBHE7EIaeaIaz17SGs8L7Gz/TWDarjs5k67vODIbPdb90i92k0pu/eYbCWi4VBydqTvfPaxIFBwPl6ffKQkElpt3m9AgPPAFmZSnl2Ad2OOgBAefAaioc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744702; c=relaxed/simple;
	bh=fDdkmfCCvdBVH6L5BLC6/7ennq1G2HESzBduxQPVxw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+LaT0ZFXzEFPT2E01wVAn37ea2+oB6h+g5ej/TWfiLwVphUJJVESpW6842u9SCmMoentVmeWCUBR/j61FYGDTwOjAlLCFit669LqCUqb87srdBeIQxsUFqeiQy6dacgVLWaodrB1QgawbWQw85Foy4HpDhBVEf3KPWU6X1VSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYl7SLWe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so747a12.0
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 10:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737744698; x=1738349498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw/hjejM3ch7CQVj+0QYv4YbXgyC5i5Q+BA5aHuSxsY=;
        b=xYl7SLWesBUucPFZFNFmo30rQrN92E3CiruDWx730zeC4uNaru93KJ+jlPsqejoQOt
         0QOfJ1GhwFTiEQWJbXzXWspnENTCA6kesiWAbCEll1QtmyIrENzsqAabfpAZvV2Pjtpc
         9vuLZDYpIegCut7boZpk8R/9XKZPLH0ERHexDPv8RaY+wZvX63VZGkSm/WqTb3/b9qKq
         IMMKcx98vXSIsIBEZTV5ddO8Ax8Ft+I7J0CiGbgVQSd8fYunuOvGrvpTDxmqYjP68LpP
         HY0Tfx8mBuQGacaKrQgPdexfqbo1DcrIIBDvF4mnw3GcdaYDpVNuwBpBzokQ/Ti+79tK
         CvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737744698; x=1738349498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aw/hjejM3ch7CQVj+0QYv4YbXgyC5i5Q+BA5aHuSxsY=;
        b=py0Qqhe17a69UvqImx1H4/2kWolJbnIfcF9SzfpaWUpKDqW5KI4W5bgRP8cNq0ZMFA
         H4RKBq5kCKYnWYVp3V+m84qORXGcC2C2PK7OUaIPG66CsVg3TwFxcDEQnOUWdrSgLE2H
         fbTlL0ahO1g7r/0quuV5PvuadEUlg5aDTG1ZH1N+S+SbYAxnZkJqK88HEIHxgofZFlrL
         U0VqcaXsali4ZRKR58Ib7cq/y762EgovetNq+5dlsW8XQ2HKAhbOqch1mtfpY39FRTvo
         8IUzteANw1I98Bx0lq0vx5RBKIC0fbu0yMxeosNeYm8HxB8LgcND12A1bFS8Vs8Cg5la
         2mmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsCP94DYuxYVi7bOIXAr2IDVID19H/g+XMth5G3LUATkcNur28WbDKNzwZFmLfpzCawSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zbtVLJ07tS+25R4nMdBYWfVWEe3SXAa/gAbdxnT+TPVLAQtg
	q1vcLpMoYtblP8hiuN25j6x7JPFN9W87VVQzTICOrLOlNf+bF+wQv2dtqAqHUQDhg9Btv0efLDw
	1TA+YzWLTBMlco+rss3gAOhPJr495WSoI5Hq8
X-Gm-Gg: ASbGncsRT2/gFayY+Y04wjg5FNe4x57N+dWzi0hnn9DO7NFqkrPzn5SdH+SIwWHlYH2
	4bLbCrz2kMlVJpFB3LN1/0JCU6YvX705yVsgQ/12Ef3Ea2NyoGGGqtORW2g7RCNxUgWuO5D4w50
	sSp8JKQo549xJFoc0=
X-Google-Smtp-Source: AGHT+IHy2qOAjc2g89RIHQ1Ph0fZ3qahOk5LuwhuPnCexqQtW7QUAfR5ZBPMtJ/IqD5mz9ytT5S+92P+roC83MXr1yw=
X-Received: by 2002:a05:6402:28a0:b0:5d0:d935:457b with SMTP id
 4fb4d7f45d1cf-5dc23a582e4mr5855a12.0.1737744697674; Fri, 24 Jan 2025 10:51:37
 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122200402.3461154-1-maze@google.com> <4a6be957-f932-426a-99bf-7209620f8fa9@iogearbox.net>
In-Reply-To: <4a6be957-f932-426a-99bf-7209620f8fa9@iogearbox.net>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 24 Jan 2025 10:51:25 -0800
X-Gm-Features: AWEUYZkF3JCKPZNGn_sTqPHMeDvCGDSz_h-1xZRsueiwq6c0SA0-CHv7rGMWcXE
Message-ID: <CANP3RGcxE4pv1Dqi65O4KMP8B=7rcX9Hyd4RRMLGRtiC9L1E2Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix classic bpf reads from negative offset
 outside of linear skb portion
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Matt Moeller <moeller.matt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 2:36=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 1/22/25 9:04 PM, Maciej =C5=BBenczykowski wrote:
> > We're received reports of cBPF code failing to accept DHCP packets.
> > "BPF filter for DHCP not working (android14-6.1-lts + android-14.0.0_r7=
4)"
>
> I presume this is cBPF on AF_PACKET, right?
>
> > The relevant Android code is at:
> >    https://cs.android.com/android/platform/superproject/main/+/main:pac=
kages/modules/NetworkStack/jni/network_stack_utils_jni.cpp;l=3D95;drc=3D9df=
50aef1fd163215dcba759045706253a5624f5
> > which uses a lot of macros from:
> >    https://cs.android.com/android/platform/superproject/main/+/main:pac=
kages/modules/Connectivity/bpf/headers/include/bpf/BpfClassic.h;drc=3Dc58cf=
b7c7da257010346bd2d6dcca1c0acdc8321
> >
> > This is widely used and does work on the vast majority of drivers,
> > but is exposing a core kernel cBPF bug related to driver skb layout.
> >
> > Root cause is iwlwifi driver, specifically on (at least):
> >    Dell 7212: Intel Dual Band Wireless AC 8265
> >    Dell 7220: Intel Wireless AC 9560
> >    Dell 7230: Intel Wi-Fi 6E AX211
> > delivers frames where the UDP destination port is not in the skb linear
> > portion, while the cBPF code is using SKF_NET_OFF relative addressing.
> >
> > simplified from above, effectively:
> >    BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_NET_OFF)
> >    BPF_STMT(BPF_LD  | BPF_H | BPF_IND, SKF_NET_OFF + 2)
> >    BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 68, 1, 0)
> >    BPF_STMT(BPF_RET | BPF_K, 0)
> >    BPF_STMT(BPF_RET | BPF_K, 0xFFFFFFFF)
> > fails to match udp dport=3D68 packets.
> >
> > Specifically the 3rd cBPF instruction fails to match the condition:
> >    if (ptr >=3D skb->head && ptr + size <=3D skb_tail_pointer(skb))
> > within bpf_internal_load_pointer_neg_helper() and thus returns NULL,
> > which results in reading -EFAULT.
> >
> > This is because bpf_skb_load_helper_{8,16,32} don't include the
> > "data past headlen do skb_copy_bits()" logic from the non-negative
> > offset branch in the negative offset branch.
> >
> > Note: I don't know sparc assembly, so this doesn't fix sparc...
> > ideally we should just delete bpf_internal_load_pointer_neg_helper()
> > This seems to have always been broken (but not pre-git era, since
> > obviously there was no eBPF helpers back then), but stuff older
> > than 5.4 is no longer LTS supported anyway, so using 5.4 as fixes tag.
> >
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Reported-by: Matt Moeller <moeller.matt@gmail.com>
> > Closes: https://issuetracker.google.com/384636719 [Treble - GKI partner=
 internal]
> > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > Fixes: 219d54332a09 ("Linux 5.4")
>
> Hm, so not strictly broken, just that using relative SKF_NET_OFF offset
> is limited in that it requires the data to be in linear section. Some
> potential workarounds that come to mind:

I'd consider that to be broken... this is *ancient* functionality of
classic bpf, and it far predates both eBPF and drivers creating weird
split packet layouts.
The breakage is very much userspace visible.

> 1) When you say vast majority of drivers, have you checked how much they
>     typically pull into linear section and whether it would make sense al=
so
>     for iwlwifi to do the same? (It sounds like start of network header i=
s
>     already in non-linear part for iwlwifi?)

Well... when I say 'vast majority' what I mean is: this is rolled out
to *all* Android mainline capable devices (and has been for a while),
and this is the first bugreport we've got.  I would imagine if IPv4
DHCP discovery failed to work (and this appears to be a 100% failure
on affected drivers) we'd be hearing a *lot* more screaming...

Of course this doesn't mean this is the first time this has failed,
since this is certainly not something easy to debug...  But it has to
be mostly working on the ecosystem as a whole.

Of course most deployed devices tend to have old kernels and or old
drivers, so probably most of them simply don't do packet split (and
even if they do, they'd presumably be doing more normal header split,
and be splitting after the udp header)

> 2) Perhaps rework the filter to avoid relying on SKF_NET_OFF.. tradeoff
>     are more instructions, e.g.,
>
>    # tcpdump -dd udp dst port 68
>    { 0x28, 0, 0, 0x0000000c },
>    { 0x15, 0, 4, 0x000086dd },
>    { 0x30, 0, 0, 0x00000014 },
>    { 0x15, 0, 11, 0x00000011 },
>    { 0x28, 0, 0, 0x00000038 },
>    { 0x15, 8, 9, 0x00000044 },
>    { 0x15, 0, 8, 0x00000800 },
>    { 0x30, 0, 0, 0x00000017 },
>    { 0x15, 0, 6, 0x00000011 },
>    { 0x28, 0, 0, 0x00000014 },
>    { 0x45, 4, 0, 0x00001fff },
>    { 0xb1, 0, 0, 0x0000000e },
>    { 0x48, 0, 0, 0x00000010 },
>    { 0x15, 0, 1, 0x00000044 },
>    { 0x6, 0, 0, 0x00040000 },
>    { 0x6, 0, 0, 0x00000000 },

I don't think this works as is.
When I run this with -dd I get the (at first glance) same output as
you, but with a warning, here's the same thing with -d:

$ tcpdump -d udp dst port 68
Warning: assuming Ethernet
(000) ldh      [12]   <-- assumes ethernet header, loads ethertype
(001) jeq      #0x86dd          jt 2    jf 6
(002) ldb      [20]
(003) jeq      #0x11            jt 4    jf 15
(004) ldh      [56]
(005) jeq      #0x44            jt 14   jf 15
(006) jeq      #0x800           jt 7    jf 15
(007) ldb      [23]
(008) jeq      #0x11            jt 9    jf 15
(009) ldh      [20]
(010) jset     #0x1fff          jt 15   jf 11
(011) ldxb     4*([14]&0xf)
(012) ldh      [x + 16]
(013) jeq      #0x44            jt 14   jf 15
(014) ret      #262144
(015) ret      #0

Not assuming ethernet is the entire point of using SKF_NET_OFF.
(and SKF_AD_OFF + SKF_AD_PROTOCOL to check ethertype)

> 3) Use eBPF asm, e.g. you can pull in data into linear section via helper
>     bpf_skb_pull_data() if needed, or use bpf_skb_load_bytes() which work=
s
>     for linear & non-linear data.

Sure, we could (and possibly should) replace our existing cBPF filters
with eBPF.
I've been considering it, BUT... we shouldn't have to.
[The reason why I've been considering switching all our cBPF to eBPF
is related to the bpf jit hardening thread from a few months back]

Furthermore some devices running this code are quite likely still on
3.18 and 4.4 kernels (I would have to check, but 4.9 is guaranteed)...
which makes any such transition painful.

This is *clearly* a kernel bug/regression vs something like Linux 2.0
(or 1.0), and should thus be fixed in the kernel.

> 4) What about pulling in linear data in AF_PACKET code right before the
>     cBPF filter is run (perhaps usage of SKF_NET_OFF could be detected an=
d
>     then only done if really needed by the filter)?

I'm not sure how to do this cleanly without a kernel change.

And for a kernel change fixing the bpf helpers simply seems superior.

I guess I could 'hack' this by still doing a relative load, but then
considering -EFAULT to match...
But with the kernel bug present, it's hard to say in how many other
places our cBPF code can run into this same problem (just in other
filters and/or at different offsets).

Btw. we did get a working patch tested yesterday [it basically does an
extra  -=3D skb_headroom(skb) ], I'll try to clean it up (add comments)
and send in a v2.

