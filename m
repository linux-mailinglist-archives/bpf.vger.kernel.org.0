Return-Path: <bpf+bounces-58374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15024AB93D7
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 03:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC93B9E2D3B
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 01:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34BE226D1E;
	Fri, 16 May 2025 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="HyB3yr7j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U0JllwPP"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3223AD;
	Fri, 16 May 2025 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747360619; cv=none; b=uMwqCQev/qfX6y8mPuUha0M4xGXtp85RkefsiV6uaEuCDaWEhqZGdtXS7gM1kjp7933x3l8Y62pnHfkiRKCnkpDWENS3tqwkgxxM+ssqcGs3/Zw2pSTFPLSdXXxwnFiEzzUZ9qvLCphReoh8VS+qLXuSwitW6QZRU//ThvcRNUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747360619; c=relaxed/simple;
	bh=lg2RswOoCVT4JrW3TwQs/AOKgg/d8/NK9CoRbhd7LRI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Dk3swGQhwkTV/xn8y/Eh/3QK/ds4rUoKZ9XNnxdHD7hYNfHtDYhhC8nLRx0UsO0CjgPmi5pIh7N1mbEx4tMiLvs6l+2ls8mBuzXBAwjL0e1zSoHKlhhuOieteXVx32crjIduQwGdKQLN0tTl3g7NWcMH3ICxoJzM3Q+tmtCnTwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=HyB3yr7j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U0JllwPP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 243F0254011B;
	Thu, 15 May 2025 21:56:55 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-02.internal (MEProxy); Thu, 15 May 2025 21:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747360614;
	 x=1747447014; bh=jorEOfVhRuwZqY7DZl1lH+R2d25d21QYNH3JcMu4gfw=; b=
	HyB3yr7jxSvggdH3/vXZ2f89Y7OpJrA9xeRRbR87IWa8KKbhDw6a9QK0OclaVvmP
	fv879vYMXAKehKCc3aPR89aruoQ15G5NogwDSvxVD5dWOHD1xyqG6kRFutqzwDDo
	ITfmSX8DM7Dg+r9NYb8mx7m1E2Bcj3ASlLdeh5arf4ldqX/+/u3JO2LyNtmBfR+b
	+0aD9Wsb/JL4pQp/4Qs/EeInSq/qNRIa8RYLdWh+JX667NCAKYu1iUSO7D1C+z2m
	5IRUZSh8NmmZjQ2we4c2pcc06s4ApTLQ1144gaO1ZjQKgOjhFZYuYw8fjyUnob+Z
	Z4cfUEMWKqI8VJSTSyBKkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747360614; x=
	1747447014; bh=jorEOfVhRuwZqY7DZl1lH+R2d25d21QYNH3JcMu4gfw=; b=U
	0JllwPPAhlmQMj4mHYhMFmIxvYqBPeX76bZ94SjfBRdJfIfpLSD+CfXtE4fsM/OH
	NhgB9nEKdsV9/6bnriormhwryFvsn/6U77uN9wal61WX2VbbkH3/pxW+ajCYvEEZ
	zhe691xwS2kALSNRUS6PBhewhfaIc5EN47a5UWHzSqkk/hVxwLEVTdCWsAwbh5zw
	uUUIfw+SlWgGjiClAe5eS8j5/5BPihe9SBymCJLC/c/jnKyd6xCw8brajfd6hBVW
	G0uJXrCQ8I5+t6p0QQ2Jjl+Y0nYp3U0cVQ/LDC8fkVl1jqaGhVjNqOwPX+n3tyVU
	ua5B3fCi4UbFGj44bc5Dg==
X-ME-Sender: <xms:ZpsmaGBmP0qH6pBF1-7ua7RnEw8enrdlchNxu604BwcJZVPB0Ugmsg>
    <xme:ZpsmaAjzbns8BzoV5xfnEvWo0T1lgryF5cTPVhgbPeB0i6AY6Nzh8Dwow8nxnaJvu
    usVZWtPES108h7ZjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddugeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffv
    vefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoe
    gugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgleeitefgvefffedu
    fefhffdtieetgeetgeegheeufeeufeekgfefueffvefhffenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhn
    sggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvh
    gvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopeifihhllhgvmhguvggsrhhu
    ihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivg
    htsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhes
    ihhnthgvlhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepjhgrshhofigrnhhg
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZpsmaJkCVy_11Ajx9LuGyPyerWRlWJpvLckODbwrVdgLd0rZySZ7tA>
    <xmx:ZpsmaEz9UKzw_rGHOsRZLQMSSK3nUKVSQQ-F908mCr141b7JFLKexA>
    <xmx:ZpsmaLTlYchxHheIoaaDYGGRQKtGPCc5sNODgoo07DXknhL0nil6ug>
    <xmx:ZpsmaPYh5aDICpu5v0vdb67bM3PX7VefJqRTrKvQcyOTkY5MiUL07A>
    <xmx:ZpsmaH6Y8a49c2zq46SgonXYSE8L7qRXid5G4DiLRaKWKcWivzHCHYrV>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3CDDE15C0068; Thu, 15 May 2025 21:56:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T995aa454cfce42d7
Date: Thu, 15 May 2025 18:56:34 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Alexander Shalimov" <alex-shalimov@yandex-team.ru>
Cc: andrew@lunn.ch, "David Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, jacob.e.keller@intel.com,
 jasowang@redhat.com, "Jakub Kicinski" <kuba@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 "Paolo Abeni" <pabeni@redhat.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Message-Id: <0bcc08e4-9f22-431c-97f3-c7d5784d2652@app.fastmail.com>
In-Reply-To: <6825f65ae82b5_24bddc29422@willemb.c.googlers.com.notmuch>
References: <681a63e3c1a6c_18e44b2949d@willemb.c.googlers.com.notmuch>
 <20250514233931.56961-1-alex-shalimov@yandex-team.ru>
 <6825f65ae82b5_24bddc29422@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH] net/tun: expose queue utilization stats via ethtool
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025, at 7:12 AM, Willem de Bruijn wrote:
> Alexander Shalimov wrote:
>> 06.05.2025, 22:32, "Willem de Bruijn" <willemdebruijn.kernel@gmail.co=
m>:
>> > Perhaps bpftrace with a kfunc at a suitable function entry point to
>> > get access to these ring structures.
>>=20
>> Thank you for your responses!
>>=20
>> Initially, we implemented such monitoring using bpftrace but we were
>> not satisfied with the need to double-check the structure definitions
>> in tun.c for each new kernel version.
>>=20
>> We attached kprobe to the "tun_net_xmit()" function. This function
>> gets a "struct net_device" as an argument, which is then explicitly
>> cast to a tun_struct - "struct tun_struct *tun =3D netdev_priv(dev)".
>> However, performing such a cast within bpftrace is difficult because
>> tun_struct is defined in tun.c - meaning the structure definition
>> cannot be included directly (not a header file). As a result, we were
>> forced to add fake "struct tun_struct" and "struct tun_file"
>> definitions, whose maintenance across kernel versions became
>> cumbersome (see below). The same problems exists even with kfunc and
>> btf - we are not able to cast properly netdev to tun_struct.
>>=20
>> That=E2=80=99s why we decided to add this functionality directly to t=
he kernel.
>
> Let's solve this in bpftrace instead. That's no reason to rever to
> hardcoded kernel APIs.
>
> It quite possibly already is. I'm no bpftrace expert. Cc:ing bpf@

Yeah, should be possible. You haven't needed to include header
files to access type information available in BTF for a while now.
This seems to work for me - mind giving this a try?

```
fentry:tun:tun_net_xmit {
    $tun =3D (struct tun_struct *)args->dev->priv;
    print($tun->numqueues);  // or whatever else you want
}
```

fentry probes are better in general than kprobes if all you're doing
is attaching to the entry of a function.

You could do the same with kprobes like this if you really want, though:

```
kprobe:tun:tun_net_xmit {
    $dev =3D (struct net_device *)arg1;
    $tun =3D (struct tun_struct *)$dev->priv;
    print($tun->numqueues);  // or whatever else you want
}
```

Although it looks like there's a bug when you omit the module name
where bpftrace doesn't find the struct definition. I'll look into that.

Thanks,
Daniel

