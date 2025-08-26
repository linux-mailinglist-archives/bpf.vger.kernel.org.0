Return-Path: <bpf+bounces-66480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEE8B34FF2
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471725E0DA4
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184E39FD9;
	Tue, 26 Aug 2025 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muVQpLT3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2EEEEBA;
	Tue, 26 Aug 2025 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166851; cv=none; b=Hyu9PcELAjbHE88d4b44n2ElC9E8IjSynRGEk2RDZhXvtCMRmBGl5i7Gq/wz+0N6su/Vg3KKRX0s8xFInM2edxpkFKxRZ9Sbh/NToMeJCQDoZkkAhz482Mvh7fUye2uDm38a3gD3GfVvVwVj4tedrgwtUw7q7GJq9tpzLTxBABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166851; c=relaxed/simple;
	bh=Y6gaNpfNuDRzUZAQiAlFVnkY/fGkjUty0HhGf0vkfEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQK94vS2f9BXpE+xR2aGYPp3PZTwrGVymNe7G8cvqoj+QYCFivrPdbx9JFLankCCw2G/Jw5VEL6OfKEQFsKXsFQocohvYoCuUW+/jYnS4m22N/k41j6LwliTPCip/W7UZwuKSnrU299R3cYJnrkF0t7XDA4U6S6SWdYamTenK6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muVQpLT3; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e571d40088so44728535ab.1;
        Mon, 25 Aug 2025 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756166848; x=1756771648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDnbcBKHwzf4YU7lb+X8La56cHhZAo1Sl2fAPTDozPE=;
        b=muVQpLT38MVhyHpcULZm5JZr+3kIpjQALaqOUoa1DBKVX8o5wIM8n2knQIVZ95MGh0
         hApWYFRm3ZRrsEHmbI+WT3LvJ8IUt/vVA9oblem5uZeSKL8NuJzhmhdIlL9A3nc+cO1+
         S6VgctkCXdoRlHFTTVYXrzTGHLe0tNvXfOgYnq+mlRXxSo70vfctI0kCiVWbhH+0X5Nc
         oTytFApkm7wF5ikKDJs4KxIDwZ1LofhN4KFD52QzhOnJoWHryfkRI6yTmKvdZhTac2sX
         VisyLmmnIhJ2BcI6T2+lp9w4byMPwwtw0+vDeud6MWAiY75vSsyYcUiz2U6mCV3Ps0YS
         jpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756166848; x=1756771648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDnbcBKHwzf4YU7lb+X8La56cHhZAo1Sl2fAPTDozPE=;
        b=w8XokLDbh3GCBKVBym2D2AHSMm1VSpJcd0iv3s54oe9b3pDLBF90U9uCxAltamkRzR
         8jisnIpD++cvBgazDrS/anOtwOuzT/EGZRJXEh7AZgl+gEAqGpUmKaLz3tbBrT0/5NJU
         DqFJC7l+Bwazpx4/wP5s/OUCpMhnKCRgAPuQtE+EtXb0r6jwjEf3hbo0xeRm/I7Pklco
         uV3qpq1cPBYkzPDel9SMK9fACFX7eg51zP1PzyU+j+lw44xhQTMZnrLNxCTjdYiZT6TJ
         kQBkbZOO48msNeroB+FHCDwPCKFJLFsAHkURsqwBMEkn75Ynrp21VqdmYvj0B2/4huey
         GR4A==
X-Forwarded-Encrypted: i=1; AJvYcCXfFBQOdaGaR61/J5quqZUS/vk/WXgp5zkEcwLfGvTmlstISj81HfhGG0z0k3jWSXeohSg=@vger.kernel.org, AJvYcCXsCSHUITcHn+nAb3mGhpxBGfY95iau9I3PkYAmuLW/B7Dn0GEGr1ujDWJDvV+rTGVEuZUnmV0Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2/eXP5xx7dRvjqjaQPxsYLFHZ/+KkpYfuM3WeJ26N7r+I8zx
	0CTc9phrxS2fKNk8PZAHnIS9Ws+FowWx+vRGT2/EkUCpmvLrntrYBZmyZBNUmK3cKb5CooLZAJR
	FaT19KCmM1MyMU+A/w5d4ZSMWLA6Qhps=
X-Gm-Gg: ASbGncu9Jrtk9zaRDOdsSBDUKMig6xbAvCpMdiMunSX/etwrgGyHeq5CQE28raj2K/o
	KAiK44wCWGg8cdhBwobJNsf6pEC9W61yhUylHYhv0HdIahZEqWgiZ0pBQFkSDhhSWy2XEshMvmg
	lvUK+Bs90G//V/l/x8OyZoO46ERQHBTjF3RVqJalCffQq0TFE0VsyaKOzPHnSIaKiNhNEWZllqG
	8v4fAK08g0aznhm6Q==
X-Google-Smtp-Source: AGHT+IFnaemvY7xRqPsoM51/xdink5BfR4wOjRde1FQcTcQ8greAI/sK/dxbCHYqljkX83DIkltY7zjaiIsBe+c47wk=
X-Received: by 2002:a05:6e02:3c03:b0:3e5:4b2e:3aeb with SMTP id
 e9e14a558f8ab-3e91fc22de2mr212848045ab.5.1756166848519; Mon, 25 Aug 2025
 17:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825135342.53110-1-kerneljasonxing@gmail.com> <aKzSaA73Kq3mZ+Mp@boxer>
In-Reply-To: <aKzSaA73Kq3mZ+Mp@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Aug 2025 08:06:52 +0800
X-Gm-Features: Ac12FXzcRpzZOwldkyMh2_KYUR0eVk-ZIOiJRcG-vQv4Mj08cfLE9BLrrii6saU
Message-ID: <CAL+tcoBZN-k2pM1Dp65SGKMhkJm=7kQY+-97WguR-E=KW3Nhxg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/9] xsk: improvement performance in copy mode
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:15=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Aug 25, 2025 at 09:53:33PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Like in VM using virtio_net, there are not that many machines supportin=
g
> > advanced functions like multi buffer and zerocopy. Using xsk copy mode
> > becomes a default choice.
>
> Are you saying that lack of multi-buffer support in xsk zc virtio_net's
> support stops you from using zc in your setup? or is it something else?

In the VM env, if we want to use those advanced features, we need to
make sure the host provides related flags/features in turn. So it has
nothing to do with the guest kernel. In many big clouds, it's not easy
to upgrade the kernel which means there are many VMs that don't
support multi-buffer.

I will override the commit message with the above description.

>
> >
> > Zerocopy mode has a good feature named multi buffer while copy mode
> > has to transmit skb one by one like normal flows. The latter becomes a
> > half bypass mechanism to some extent compared to thorough bypass plan
> > like DPDK. To avoid much consumption in kernel as much as possible,
> > then bulk/batch xmit plan is proposed. The thought of batch xmit is
> > to aggregate packets in a certain small group like GSO/GRO and then
> > read/allocate/build/send them in different loops.
> >
> > Experiments:
> > 1) Tested on virtio_net on Tencent Cloud.
> > copy mode:     767,743 pps
> > batch mode:  1,055,201 pps (+37.4%)
> > xmit.more:     940,398 pps (+22.4%)
> > Side note:
> > 1) another interesting test is if we test with another thread
> > competing the same queue, a 28% increase (from 405,466 pps to 52,1076 p=
ps)
>
> wrong comma - 521,076

Will correct it.

>
> > can be observed.
> > 2) xmit 'more' item is built on top of batch mode. The number can sligh=
tly
> > decrease according to different implementations in host.
> >
> > 2) Tested on i40e at 10Gb/sec.
> > copy mode:   1,109,754 pps
> > batch mode:  2,393,498 pps (+115.6%)
> > xmit.more:   3,024,110 pps (+172.5%)
> > zc mode:    14,879,414 pps
> >
> > [2]: ./xdpsock -i eth1 -t  -S -s 64
>
> Have you tested jumbo frames? Did you run xskxceiver tests?

Not yet, I can test them in the following days.

>
> IMHO this should be sent as RFC. In some further patch you're saying you
> were not sure about some certain thing, so let us discuss it and overall
> approach.
>
> Besides, please work on top of the recent fix that got accepted:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?id=3Ddd9de524183a1ca0a3c0317a083e8892e0f0eaea

Got it :)

>
> >
> > It's worth mentioning batch process might bring high latency in certain
> > cases like shortage of memroy. So I didn't turn it as the default
>
> memory
>
> > feature for copy mode. The recommended value is 32.
> >
> > ---
> > V2
> > Link: https://lore.kernel.org/all/20250811131236.56206-1-kerneljasonxin=
g@gmail.com/
> > 1. add xmit.more sub-feature (Jesper)
> > 2. add kmem_cache_alloc_bulk (Jesper and Maciej)
> >
> > Jason Xing (9):
> >   xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
> >   xsk: add descs parameter in xskq_cons_read_desc_batch()
> >   xsk: introduce locked version of xskq_prod_write_addr_batch
> >   xsk: extend xsk_build_skb() to support passing an already allocated
> >     skb
> >   xsk: add xsk_alloc_batch_skb() to build skbs in batch
> >   xsk: add direct xmit in batch function
> >   xsk: support batch xmit main logic
> >   xsk: support generic batch xmit in copy mode
> >   xsk: support dynamic xmit.more control for batch xmit
> >
> >  Documentation/networking/af_xdp.rst |  11 ++
> >  include/linux/netdevice.h           |   3 +
> >  include/net/xdp_sock.h              |  10 ++
> >  include/uapi/linux/if_xdp.h         |   1 +
> >  net/core/dev.c                      |  21 +++
> >  net/core/skbuff.c                   | 103 ++++++++++++++
> >  net/xdp/xsk.c                       | 200 ++++++++++++++++++++++++++--
> >  net/xdp/xsk_queue.h                 |  29 +++-
> >  tools/include/uapi/linux/if_xdp.h   |   1 +
> >  9 files changed, 360 insertions(+), 19 deletions(-)
> >
> > --
> > 2.41.3
> >

