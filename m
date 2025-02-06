Return-Path: <bpf+bounces-50577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46011A29E00
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A877A3AC2
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 00:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CDC175AB;
	Thu,  6 Feb 2025 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0ITLsj9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B92A1BA;
	Thu,  6 Feb 2025 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802561; cv=none; b=iDpTSI6Qj5JpWCFlxzVrYCu99Z6VniDAgvc+Cw72hpX8xPggWBUbk0gLqnrAK4PwTjKY6kU/sU131owMv+ukIj9NtBmGESmoA27yOquG5UcS9/GZvT4YNxP+KrLJ0/9WA69Q9xrei1o1mdQFuYG2whJNPvDnpuJDOU+SwREh4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802561; c=relaxed/simple;
	bh=Mdz/n4nUze4iJxZwaohJztAs/iNYhR9y6s1YCmCuJxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWVmDaurCi86eFNNL6v+tt+X+WDnE5nno9mJW7npD75OttEHiWXbhifHavpUtQrNo1/C8jYJ3bXI6ChP2dRgNu76U3Fmx6nNKwjW7SE82DiQF10bqivjsc4gvTVL/VgI1zL2RNGgj5+Td5vkehnYuUvFKHRkciPrPYRoiaMTGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0ITLsj9; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d04fc1ea14so3145345ab.2;
        Wed, 05 Feb 2025 16:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738802558; x=1739407358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcVWkDWLJ9xt+1gcfEi4IIQVl8ktFif7cOeidiyaokQ=;
        b=I0ITLsj9QsCkVu4zdlxX9LwRodynLV4Hmrw8EnZo6nSDR2G+ZeKm91K7S5GuSwjIaS
         ypCkZ4mwp1RqziaKyKnI7/rIchWi0SfejrEakRV/V4i5Lh1J+zL6uI4IAdB4g0hwc5gJ
         elsyzBoE2ZMQMCaXxWxPSO0CCCEGe2TDfXIVGgaDud3YM+QPV8JpcJFO0ld/9ckIsEBN
         z7WN97fXgQtrX1DMT11zkztDX4kjpBXoHdmEA0csjtgUkGaUM0C5Hczqi3pt9aFOHxkh
         4IiXNFEw+gRkt/X+uVXChmxv2jpkXK4ClXY3QyCsgz/Il8w//tPRyo0l+J02ptE7tBAf
         BvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738802558; x=1739407358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcVWkDWLJ9xt+1gcfEi4IIQVl8ktFif7cOeidiyaokQ=;
        b=CQn5CGZRlMUXvvNuRHhp7akWrrd6jEiFCGQfWXCTUo9PQ+h6q7mLY8qtaULbX0oTNB
         Y0lj4u71JVZ6INAYnVV8k5G/rNJOl/T+r3CcS+5a1i11aK1x6HzavzglorxvEhO8dCFk
         5khnrVT7glqngXyqi3HRV3tjPJ4wiykoAljagBVep3WxOh4cfauHexBW2V812tuupLCb
         zKGiKRZszqRlhuS6zsm6Uem14gxzm1Lqs2+pTBN2BdnljcAci2f3w6d1qfvkmlSJBHYG
         6L0nYLwi1BDN2TVoEFsFmV7Giv8Fx6MRQ4nfghKjyjen04lW+d8Dz63ZkAXQM8qD3ghM
         6VzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWGbjRsUdu9HEnUNhnxzRcFFv0Z1dXvkTKD2BqVJlGBq6f8jdXOkH1QkGQT5/MR2nLeuTKdjDZ@vger.kernel.org, AJvYcCVkyKex+U9+0byADVPGqkX1D7BB2LL1KpXW/+l5FszxQE/Py1xp/foZIPwctk/sfOxj4GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrkH78bi534Lr6spKiBlLz+nrTUirndHytIvZEJyQn9Rz2Z12r
	mJbrSMf6fwRiXIw2T+242gGtXA+mTLejqKYidGnBzTeyMI3fywRsHzY3urBcu0FvjgP/mIua+zQ
	HTQAccd9d4D1PERe5GkhCDxRQn/o=
X-Gm-Gg: ASbGnctwVWcgB3tIdJSjkCSkT+qlBopBcpcr/6UwlNP+44H9cSLk2eyVdwI03Dy1HM1
	mnXm9QkM9rornAjifyH6Du+jCZKAtWB2kzM40zRs0Zf30NJvY4+TsXyCI0Y0iwQ6r7qnx2vY=
X-Google-Smtp-Source: AGHT+IFD/m3OvG8Acij95VJ8qU6A52ifNY42ZhABus/TljqVlEaLqIOkL8HcS+n4VuyCXM6fNL4w1qGG0Plr24rnio4=
X-Received: by 2002:a05:6e02:f:b0:3cf:b2b0:5d35 with SMTP id
 e9e14a558f8ab-3d04f41ad8amr60992025ab.7.1738802558464; Wed, 05 Feb 2025
 16:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com> <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev> <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
In-Reply-To: <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 08:42:02 +0800
X-Gm-Features: AWEUYZnY0_VIdu17xcwrlLWFGgh8PyJB8RYcOu-0ywNXe4qv1-oxJuAdS4gMpJ4
Message-ID: <CAL+tcoDPXyvaYFZHe6FBN_+HtMkY3s0hBfRH=o1m+4ZTiFGRJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 8:12=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Feb 6, 2025 at 5:57=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
> >
> > On 2/4/25 5:57 PM, Jakub Kicinski wrote:
> > > On Wed,  5 Feb 2025 02:30:22 +0800 Jason Xing wrote:
> > >> +    if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > >> +        SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) =
{
> > >> +            struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > >> +            struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> > >> +
> > >> +            tcb->txstamp_ack_bpf =3D 1;
> > >> +            shinfo->tx_flags |=3D SKBTX_BPF;
> > >> +            shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> > >> +    }
> > >
> > > If BPF program is attached we'll timestamp all skbs? Am I reading thi=
s
> > > right?
> >
> > If the attached bpf program explicitly turns on the SK_BPF_CB_TX_TIMEST=
AMPING
> > bit of a sock, then all skbs of this sock will be tx timestamp-ed.
>
> Martin, I'm afraid it's not like what you expect. Only the last
> portion of the sendmsg will enter the above function which means if
> the size of sendmsg is large, only the last skb will be set SKBTX_BPF
> and be timestamped.

Long time ago, SO_TIMESTAMPING was mostly used to distinguish which
layer the latency issue happens, especially to exclude many cases
caused by the application itself[1].

Thanks to bpf, we can pay more attention to the kernel behaviour, even
like the tiny delay brought by flow control, say, BQL or fair queue in
Qdisc which can be noticed by this bpf extension (for sure, it will
need more work, not now).

[1]
https://netdevconf.info/0x17/sessions/talk/so_timestamping-powering-fleetwi=
de-rpc-monitoring.html
quoting Willem: "With SO_TIMESTAMPING, bugs that are otherwise
incorrectly assumed to be network issues can be attributed to the
kernel. It can isolate transmission, reception and even scheduling
sources."

>
> >
> > >
> > > Wouldn't it be better to let BPF_SOCK_OPS_TS_SND_CB return whether it=
's
> > > interested in tracing current packet all the way thru the stack?
> >
> > I like this idea. It can give the BPF prog a chance to do skb sampling =
on a
> > particular socket.
> >
> > The return value of BPF_SOCK_OPS_TS_SND_CB (or any cgroup BPF prog retu=
rn value)
> > already has another usage, which its return value is currently enforced=
 by the
> > verifier. It is better not to convolute it further.
> >
> > I don't prefer to add more use cases to skops->reply either, which is a=
n union
> > of args[4], such that later progs (in the cgrp prog array) may lose the=
 args value.
> >
> > Jason, instead of always setting SKBTX_BPF and txstamp_ack_bpf in the k=
ernel, a
> > new BPF kfunc can be added so that the BPF prog can call it to selectiv=
ely set
> > SKBTX_BPF and txstamp_ack_bpf in some skb.
>
> Agreed because at netdev 0x19 I have an explicit plan to share the
> experience from our company about how to trace all the skbs which were
> completed through a kernel module. It's how we use in production
> especially for debug or diagnose use.

I'm not sure if you can see this link[2] because Jamal is still
working on publishing officially. We can wait if it's not accessible
to you temporarily.

[2]: https://0x19.netdevconf.info/paper/5?cap=3D05arRrN3AEg11M

Thanks,
Jason

