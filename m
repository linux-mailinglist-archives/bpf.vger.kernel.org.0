Return-Path: <bpf+bounces-58424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2F0ABA4A4
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 22:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95997B2850
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618C928001B;
	Fri, 16 May 2025 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="K71XVToF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eJpqsqXy"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8CD1F956;
	Fri, 16 May 2025 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426921; cv=none; b=DNzQkE+eTqfOxzRdsWEwY2zMV+FjN+r44k3xvJi5VJT18eELPdr3qOmp5g6V6sCdDXLbx+nylSb2Kb2WwXiGlkTRcXZctBxCZjThzpMMs70HjLg5Tps//Hdg6mfkP/kXFPgZYxQPOk+64e7ooDmAvh5NyKiClXuIRjpsV1yESRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426921; c=relaxed/simple;
	bh=WJ8YeNryCSzH6Ui7JodUwBz580NMCQQnGARlq4uKk3A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=C+gkwjxo5q67jeqoJ+2o/ePebzzOks//Ii8Qi+KMcCN1Z66fgzsgrcyn/zCaKVPS8f1d9yjWkCZHCay/kmRXE7j/RH0T4suIHQ5kSBsBhPJ++cmXTU7/6f2IQQdT37vggqQB0rgw2inAhnii5B+kNOIKosg4godSD6XOj6cKUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=K71XVToF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eJpqsqXy; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EEB91254008E;
	Fri, 16 May 2025 16:21:56 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-02.internal (MEProxy); Fri, 16 May 2025 16:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747426916;
	 x=1747513316; bh=y44ryEmBs0W7W6qyiyoOfpaV4DqfaTmIbApjfW/mYM4=; b=
	K71XVToFZ+lNvc97Hv4dRpzHpSvQEeA9s01ftjVew3BUAr5HB05Mj2o/jfYGqG+D
	I0YJhhFCkc93E1TUGG8NAjxOzHMMz5a0sKkWLrlLGPwAwZnO4IoXpgbU9mUVmXQd
	7Q7Llah3hpZ9UokDeCCeBQva7ycBiY/GBMNlRWiv+B9AeSUvb8qEk1ZyT6gRFE9z
	qW93xZEI5e7Okjav8cHCdvnx+woJStrT9kmcPtLedxTkqFutSt16sGWEijKjq/5J
	kFZSZz3IVu8H6kLEBGbhokjOhdrSy5jIQ34sPd5SmU+SGayhxylyXGGRjiC2NTl5
	TLLUEpYjgxd/zKWxu1Ekqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747426916; x=
	1747513316; bh=y44ryEmBs0W7W6qyiyoOfpaV4DqfaTmIbApjfW/mYM4=; b=e
	JpqsqXyYO7gl5h1LsZIUbERsbuJFQ2X33y9639xXEcWOy/plyN2HkFLsmlRdtYEf
	BDb6groc7LbH2KDJ9ZPWHJHhR7muvUZTPjchbvZY6ihnJbhfM0aGLqa7ALcim1Ax
	aQPGhZJhiZv8mKLBUEp8Fhc6U9y09KZHApSKPx2sGwPH91Gv0TNMURZNZKG7x4R8
	tzh2PvjSvdYgIJKRR7zxF26Ri+pronfZJeoZHjwykFmLbaUDP7gOSkmVrkd/nWgG
	/l9BJxkibdZIX/SfvEw2mHNnWXLdL4UrqN819GgZzPYEuRZNEtLoFRXLKZSCgQVy
	ppSEGr1N7MQrylXyhWnhw==
X-ME-Sender: <xms:ZJ4naLz6SsDPHUSQaXvY4MO5W65DLJ4OmwD9SFR1hRQYZ13VCYzuVA>
    <xme:ZJ4naDTGd7Ij93sx8RgKlxtgArHv8jvHi9U3eFV5tMfdK0LKlYu3Omg_ZIFGZb6FE
    akNRPtp1NG262c57Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffv
    vefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoe
    gugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeduveeiffekveff
    ieehhfdtffdtveetjeefieevveffveevudetkeffffelleenucffohhmrghinhepghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepuddvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
    pdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilh
    drtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhn
    rdgthhdprhgtphhtthhopehjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphhfsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZJ4naFV0YmCUp-GHpwcdw6IsNTGk25FvYh5ugH6wBJfmu36HQcyNzg>
    <xmx:ZJ4naFhSr7eZfttx0vcc0aqo-fZyMFnUthtWMo032DOM1gI3AS3MrQ>
    <xmx:ZJ4naNDjBC80VuaxlnnXZSeUoe-aTDtRXzwA0a8QeZe0eMQXONtJXQ>
    <xmx:ZJ4naOJ7aE58bMNwAfQHkgLMHxoWGlj_RG0rEHDiBvjg29sZfoWE5g>
    <xmx:ZJ4naKqm8cnYibMvIdFvcYUJVpYjB1UujfMKiakolMEaPLpft0A_7Tc_>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E6D9115C006D; Fri, 16 May 2025 16:21:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T995aa454cfce42d7
Date: Fri, 16 May 2025 13:21:30 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Alexander Shalimov" <alex-shalimov@yandex-team.ru>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "David Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>,
 "Jacob Keller" <jacob.e.keller@intel.com>, jasowang@redhat.com,
 "Jakub Kicinski" <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Paolo Abeni" <pabeni@redhat.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Message-Id: <81d6fb01-e914-4c04-875a-58e61b433a80@app.fastmail.com>
In-Reply-To: <68277463d4c43_2ba041294cf@willemb.c.googlers.com.notmuch>
References: <681a63e3c1a6c_18e44b2949d@willemb.c.googlers.com.notmuch>
 <20250514233931.56961-1-alex-shalimov@yandex-team.ru>
 <6825f65ae82b5_24bddc29422@willemb.c.googlers.com.notmuch>
 <0bcc08e4-9f22-431c-97f3-c7d5784d2652@app.fastmail.com>
 <68277463d4c43_2ba041294cf@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH] net/tun: expose queue utilization stats via ethtool
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, May 16, 2025, at 10:22 AM, Willem de Bruijn wrote:
> Daniel Xu wrote:
>> On Thu, May 15, 2025, at 7:12 AM, Willem de Bruijn wrote:
>> > Alexander Shalimov wrote:
>> >> 06.05.2025, 22:32, "Willem de Bruijn" <willemdebruijn.kernel@gmail=
.com>:
>> >> > Perhaps bpftrace with a kfunc at a suitable function entry point=
 to
>> >> > get access to these ring structures.
>> >>=20
>> >> Thank you for your responses!
>> >>=20
>> >> Initially, we implemented such monitoring using bpftrace but we we=
re
>> >> not satisfied with the need to double-check the structure definiti=
ons
>> >> in tun.c for each new kernel version.
>> >>=20
>> >> We attached kprobe to the "tun_net_xmit()" function. This function
>> >> gets a "struct net_device" as an argument, which is then explicitly
>> >> cast to a tun_struct - "struct tun_struct *tun =3D netdev_priv(dev=
)".
>> >> However, performing such a cast within bpftrace is difficult becau=
se
>> >> tun_struct is defined in tun.c - meaning the structure definition
>> >> cannot be included directly (not a header file). As a result, we w=
ere
>> >> forced to add fake "struct tun_struct" and "struct tun_file"
>> >> definitions, whose maintenance across kernel versions became
>> >> cumbersome (see below). The same problems exists even with kfunc a=
nd
>> >> btf - we are not able to cast properly netdev to tun_struct.
>> >>=20
>> >> That=E2=80=99s why we decided to add this functionality directly t=
o the kernel.
>> >
>> > Let's solve this in bpftrace instead. That's no reason to rever to
>> > hardcoded kernel APIs.
>> >
>> > It quite possibly already is. I'm no bpftrace expert. Cc:ing bpf@
>>=20
>> Yeah, should be possible. You haven't needed to include header
>> files to access type information available in BTF for a while now.
>> This seems to work for me - mind giving this a try?
>>=20
>> ```
>> fentry:tun:tun_net_xmit {
>>     $tun =3D (struct tun_struct *)args->dev->priv;
>>     print($tun->numqueues);  // or whatever else you want
>> }
>> ```
>>=20
>> fentry probes are better in general than kprobes if all you're doing
>> is attaching to the entry of a function.
>>=20
>> You could do the same with kprobes like this if you really want, thou=
gh:
>>=20
>> ```
>> kprobe:tun:tun_net_xmit {
>>     $dev =3D (struct net_device *)arg1;
>>     $tun =3D (struct tun_struct *)$dev->priv;
>>     print($tun->numqueues);  // or whatever else you want
>> }
>> ```
>>=20
>> Although it looks like there's a bug when you omit the module name
>> where bpftrace doesn't find the struct definition. I'll look into tha=
t.
>
> Minor: unless tun is built-in.

Ah, right.

>
> Thanks a lot for your response, Daniel. Good to know that we can get
> this information without kernel changes. And I learned something new
> :) Replicated your examples.

Nice! Feel free to CC me if you have other stuff in the future.

Bug fix for parsing implicit module BTF up here:
https://github.com/bpftrace/bpftrace/pull/4137

