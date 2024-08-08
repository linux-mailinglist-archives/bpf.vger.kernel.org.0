Return-Path: <bpf+bounces-36720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3461994C5EA
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 22:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4991F25F28
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6EA15A848;
	Thu,  8 Aug 2024 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="kPZYYpC+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n2TbSaWU"
X-Original-To: bpf@vger.kernel.org
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F52AD14;
	Thu,  8 Aug 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149875; cv=none; b=VCPsNmNYFRCbnWm23a+xSgDFQT+ilrmz+iOM7ez69hmkhOk687I0H9zrD5knO2m1WIdl2vp1AJSIfMlYRodhr0W1OSSYDpzo7ss39ArKjFJl2bujV2+C6ktpFA3OqaG+fjc/Kq33XJgLd8ZI36QsorfM5Ev8x80pKcQo7699UL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149875; c=relaxed/simple;
	bh=mGOulp7vpnr4rSEgyKpXiVSVw3NrYYYwsCcK+pPUj1w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K/h6tvCUWCDR4rGEf666RzGjIyr2wGypsRoeUMfwpwGHXmnHCGABTm7wUqRHEs2gRQbUoXi5dyPY6ItH1ysx2tmvuNWltRSbcBbbFialJQ6tDcKTtwagjeAxs4zekRB5VFWEfiTZIPzI2zGiTXta4iG8NAYAJynWrmxkhVDh3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=kPZYYpC+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n2TbSaWU; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailflow.nyi.internal (Postfix) with ESMTP id 9CA7F200CE1;
	Thu,  8 Aug 2024 16:44:31 -0400 (EDT)
Received: from wimap24 ([10.202.2.84])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 16:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723149871;
	 x=1723157071; bh=v+W3a7SXw8EMXoGeWpGy5gfB1VuUlziJvetZYk3mEQA=; b=
	kPZYYpC+iJ7h6Ov2ysI0xNU0NyCRpPo1i6/bsOJw7R4KKe7U26YrDA9IFaTWPgqM
	qWWN7j6TnZkhTJKoNqNQVkdW5+OpXQKjNGBs4DnoOwU8Z/tQwDpHNTu75muNN4ci
	J5o3/7sP0yWfqOChFt+IiX3tpFhYyPqHCV0Jm2ioHXJPPcrMUXYh4/G+qcsvfPq9
	ypTM0vsfJybRXZejLvr/TZ77Wy/DWXUqqY8y8K1CqhyZc3rrJ4plja80KSJ/kvSj
	98Tq6m3lZ+g6ar72VDabOXdMHk5Cu3xl++toIJ4im4Rc3PdB+iOwJpZ4MNyeyxB3
	o8VXqzO6XDF2jbi8w4YPeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723149871; x=
	1723157071; bh=v+W3a7SXw8EMXoGeWpGy5gfB1VuUlziJvetZYk3mEQA=; b=n
	2TbSaWU61Gw1f3Rq7b2gW8ppq2Fwd5ZGhEKU6O38kbm0xoDY5i1k5VUq6apgfkLq
	c+1id2J7txtfC2mUIB2V5IXfsOKB4rrcmYw5r4G+J31k2OKgHR83czNPVviLjBBY
	4iwzUY++fc9hDkgCbKRtN3Shdk4A6durovSZTK5zYXfwymlP8wvW2/Nmzr9HuHZg
	RAGXVva177d5xLI2VTRVsVg4bPK911Ekj+3hcSlOj97x0zWPt2kP5z5f67HyAlax
	XUodSmzY8ml9jSoZqRFx1lFpDwYf5EbgxJsOMWJSkgFezK0Nzt6jlbaGPWtksSfT
	VzIuEaU4Oo0Md+AIMrMOg==
X-ME-Sender: <xms:Ly61ZvUeTapafB7trSBtpLwrSf56cIl_sVUXKz9vmTr6KYn9OINKng>
    <xme:Ly61ZnloeBQK3j778FFpRfFmD9gwkr5g13NuTOdNaSNyUndBGBjqsF2VCQnAlviCa
    jZqul_LGkb8nRbqWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeduveeiffekveffieeh
    hfdtffdtveetjeefieevveffveevudetkeffffelleenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepvdeipdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhr
    tghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhonhgrthhhrghnrdhlvghmohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopeifihhllhgvmhgsse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhdrlhhosggrkhhinhes
    ihhnthgvlhdrtghomhdprhgtphhtthhopehjvghsshgvrdgsrhgrnhguvggsuhhrghesih
    hnthgvlhdrtghomhdprhgtphhtthhopehlrghrhihsrgdriigrrhgvmhgsrgesihhnthgv
    lhdrtghomhdprhgtphhtthhopehmrggtihgvjhdrfhhijhgrlhhkohifshhkihesihhnth
    gvlhdrtghomh
X-ME-Proxy: <xmx:Ly61ZraJDRqTj-7ZX-LR_5V8__wJm2PKKfKLvi23mRD8IB_Uw2mivA>
    <xmx:Ly61ZqWSKE6TQWSeN6Q1jsOUV5gdL1PSS9D-pThgyuPvpnBzi8VGLg>
    <xmx:Ly61ZplyZj0WNPV6Ys1STlyu8yzojTJkYw0h625yFdYNgfoPSLnAiA>
    <xmx:Ly61ZnfdhgMJNPf5lJ3qmLJFW2FYaOXb--WXdvzFgq7t9tBR5_Mv9g>
    <xmx:Ly61ZrXXDV4JQdflZEz3gidigHiwjEjsRUOa21eTliNro41iGOYSQIF->
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4088825E0064; Thu,  8 Aug 2024 16:44:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Aug 2024 16:44:08 -0400
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>
Cc: "Alexander Lobakin" <alexandr.lobakin@intel.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Larysa Zaremba" <larysa.zaremba@intel.com>,
 "Michal Swiatkowski" <michal.swiatkowski@linux.intel.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 "Magnus Karlsson" <magnus.karlsson@intel.com>,
 "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
 "Jonathan Lemon" <jonathan.lemon@gmail.com>,
 "toke@redhat.com" <toke@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "David Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Yajun Deng" <yajun.deng@linux.dev>,
 "Willem de Bruijn" <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
Message-Id: <7e6c0c0d-886e-4144-a0f4-d0d6f0faa1e6@app.fastmail.com>
In-Reply-To: <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
Subject: Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to GRO from
 netif_receive_skb_list()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Thu, Aug 8, 2024, at 12:54 AM, Lorenzo Bianconi wrote:
>> Hi Alexander,
>>=20
>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>> > cpumap has its own BH context based on kthread. It has a sane batch
>> > size of 8 frames per one cycle.
>> > GRO can be used on its own, adjust cpumap calls to the
>> > upper stack to use GRO API instead of netif_receive_skb_list() which
>> > processes skbs by batches, but doesn't involve GRO layer at all.
>> > It is most beneficial when a NIC which frame come from is XDP
>> > generic metadata-enabled, but in plenty of tests GRO performs better
>> > than listed receiving even given that it has to calculate full frame
>> > checksums on CPU.
>> > As GRO passes the skbs to the upper stack in the batches of
>> > @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>> > device where the frame comes from, it is enough to disable GRO
>> > netdev feature on it to completely restore the original behaviour:
>> > untouched frames will be being bulked and passed to the upper stack
>> > by 8, as it was with netif_receive_skb_list().
>> >
>> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>> > ---
>> >  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++---=
--
>> >  1 file changed, 38 insertions(+), 5 deletions(-)
>> >
>>=20
>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>> cpumap is still missing this.
>>=20
>> I have a production use case for this now. We want to do some intelli=
gent
>> RX steering and I think GRO would help over list-ified receive in som=
e cases.
>> We would prefer steer in HW (and thus get existing GRO support) but n=
ot all
>> our NICs support it. So we need a software fallback.
>>=20
>> Are you still interested in merging the cpumap + GRO patches?
>
> Hi Daniel and Alex,
>
> Recently I worked on a PoC to add GRO support to cpumap codebase:
> -=20
> https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016d=
a5a2dd9ac302deaf38b3e
>   Here I added GRO support to cpumap through gro-cells.
> -=20
> https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa72401=
c7414c9a8a0775ef41a55
>   Here I added GRO support to cpumap trough napi-threaded APIs (with a=20
> some
>   changes to them).

Cool!=20

>
> Please note I have not run any performance tests so far, just verified=
 it does
> not crash (I was planning to resume this work soon). Please let me kno=
w if it
> works for you.

I=E2=80=99ll try to run an A/B test on your two approaches as well as Al=
ex=E2=80=99s. I=E2=80=99ve still
got some testbeds with production traffic going thru them.

Thanks,
Daniel

