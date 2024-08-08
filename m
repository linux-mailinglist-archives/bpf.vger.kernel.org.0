Return-Path: <bpf+bounces-36721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAF894C5FE
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 22:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F851C21DCF
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C68158D8B;
	Thu,  8 Aug 2024 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="jNfr2AXX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0NxuDLT"
X-Original-To: bpf@vger.kernel.org
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE808827;
	Thu,  8 Aug 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150412; cv=none; b=I11VJBhr6bnKD8WsXTiS4Yg1Otxaz+p+avCn4i4/B8Db3xPGRdaiVgq2u/vyrQRH1h19/XtbmAfBivueowlaguF/GFRxl0qzd9bRObH/3cVxcK557RnzVlGABgK3rJ23a84g9lYYTZBpOb51hjZs8uf5zCWLiI0MxYZoJ4ACn6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150412; c=relaxed/simple;
	bh=uZuJGGYVN31IMvcC6VlUdIolOXU3M5vdtnqz+UhDGgs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BKA/fbPMnBsvTrsXb/lmYAdUKzYL833GOEgKBHgtjFDTeIjJpuLt7qMjAPVSQaJCud8nFK+rDoNGGYXLn+k+0aeByRO3ULxNQdzCSjRy8MGZPDhQt+WrGytLPNRkcF/0+gaQBuSa4+sIi7dkjyiMlInxWaKloUdtEcqtlDXoRe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=jNfr2AXX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P0NxuDLT; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailflow.nyi.internal (Postfix) with ESMTP id B35F5200B5F;
	Thu,  8 Aug 2024 16:53:29 -0400 (EDT)
Received: from wimap24 ([10.202.2.84])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 16:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723150409;
	 x=1723157609; bh=a35vUxoQ9wKa+F4xH4FKyHhirnOC7Y9QMGL7QbeLZUU=; b=
	jNfr2AXXgsUzk0vESnqzmX6t6lN8oQstoMJbqcSGVlpnm414NjLEF/wsvzVYZj8Z
	s+yRdEasn4RybuZipbDE7uw0OQrlcfisuGjHUn0r9Z7YKylAOHQ5HrCSckeZeYar
	OalvM5T89IbA7yRt/9nxNw83oNwf0cShREjRY8DjY8VuBLpoXtR7wTnGrxqeCkDK
	zyilf47NcEQ1j7Sfev/Vxm5AZ5Suja+EuSVg4NUuo2ongtvti6J/vaExO076ulF1
	qHRaPu/FaiHG3LBfS7kL/OjWwFKPC9+wfPfoKCPvNUjOdIu6Z91w1epbMSnypOBE
	/T+A8pNg0SVLWLLEseqPlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723150409; x=
	1723157609; bh=a35vUxoQ9wKa+F4xH4FKyHhirnOC7Y9QMGL7QbeLZUU=; b=P
	0NxuDLT6Z4R82PXx5kTM6VFXWhCILEiG8wfCjL5X325HRKBAy+ZGUGHX8eVGumFi
	rTk5m8RQ/PjS9lxU+lgkFFsWWg5DmIzxIUO4clFpp4X03TM3JqcZmrcpnyBpshYk
	oHTKZCwJgGyi0qGlUDETZYBemG0L/06kOeBp4jxxb6aRmOOfJFHGDe2UMjlYJEFF
	lwQL0Tdw/rrfALw+8/8L94jBn+xBnK4YxipR+wQ/wNEfhwCuQ9bL8gSki8rB9R/I
	1SZc0z1oBt7FoHYuL+qVumvZkqL0aXeXsH/fmebYhyNztdCfOn7FbBaS6f+FCXTP
	WAldrQKEOgcVsxNIPieww==
X-ME-Sender: <xms:STC1ZoL00A3vRdN_VkkUF17rO11RIfMpBalRdxYxjAuAW2J2XIlKyw>
    <xme:STC1ZoIDcwlM8i5Thv1uVMnrRRwXEzTyMggNJzDkeBYl6eUGR86s4mwAtmk__iJ2m
    xfeahe0-cT6Uvb0Ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeduveeiffekveffieeh
    hfdtffdtveetjeefieevveffveevudetkeffffelleenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepvdejpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhr
    tghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhonhgrthhhrghnrdhlvghmohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopeifihhllhgvmhgsse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhgvkhhsrghnuggvrhdrlhhosggrkhhi
    nhesihhnthgvlhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhdrlhhosggrkhhinh
    esihhnthgvlhdrtghomhdprhgtphhtthhopehjvghsshgvrdgsrhgrnhguvggsuhhrghes
    ihhnthgvlhdrtghomhdprhgtphhtthhopehlrghrhihsrgdriigrrhgvmhgsrgesihhnth
    gvlhdrtghomh
X-ME-Proxy: <xmx:STC1ZouiV0o5Wrmvu5TSKDqZ_onjnHWLw-xHbbHo72ne_jlNXwQbCA>
    <xmx:STC1ZlaDYAotzQdd-Nu55rcTDOnZ-fpYD34FA4nJRWd9AQnQpzWe4w>
    <xmx:STC1ZvbzogSNYzVilGRXdY8ndfEE2Q4doVTOc8dzbPCT9yx-cT3AvQ>
    <xmx:STC1ZhCAPxzAsxmSgkfN9kTG3JUahkMQCC-jk-4iexsri4PLKh86QA>
    <xmx:STC1ZnrcWZd0wIw0jRZpRfg1DzApXvxZi2YoP56iIyBDX3A93zVpIU2V>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7AEB625E0064; Thu,  8 Aug 2024 16:53:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Aug 2024 16:52:51 -0400
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>
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
Message-Id: <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
In-Reply-To: <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to GRO from
 netif_receive_skb_list()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 8, 2024, at 7:57 AM, Alexander Lobakin wrote:
> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> Date: Thu, 8 Aug 2024 06:54:06 +0200
>
>>> Hi Alexander,
>>>
>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>>>> cpumap has its own BH context based on kthread. It has a sane batch
>>>> size of 8 frames per one cycle.
>>>> GRO can be used on its own, adjust cpumap calls to the
>>>> upper stack to use GRO API instead of netif_receive_skb_list() which
>>>> processes skbs by batches, but doesn't involve GRO layer at all.
>>>> It is most beneficial when a NIC which frame come from is XDP
>>>> generic metadata-enabled, but in plenty of tests GRO performs better
>>>> than listed receiving even given that it has to calculate full frame
>>>> checksums on CPU.
>>>> As GRO passes the skbs to the upper stack in the batches of
>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>>>> device where the frame comes from, it is enough to disable GRO
>>>> netdev feature on it to completely restore the original behaviour:
>>>> untouched frames will be being bulked and passed to the upper stack
>>>> by 8, as it was with netif_receive_skb_list().
>>>>
>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>> ---
>>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++---=
--
>>>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>>>
>>>
>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>>> cpumap is still missing this.
>
> The only concern for having GRO in cpumap without metadata from the NIC
> descriptor was that when the checksum status is missing, GRO calculates
> the checksum on CPU, which is not really fast.
> But I remember sometimes GRO was faster despite that.

Good to know, thanks. IIUC some kind of XDP hint support landed already?

My use case could also use HW RSS hash to avoid a rehash in XDP prog.
And HW RX timestamp to not break SO_TIMESTAMPING. These two
are on one of my TODO lists. But I can=E2=80=99t get to them for at least
a few weeks. So free to take it if you=E2=80=99d like.

>
>>>
>>> I have a production use case for this now. We want to do some intell=
igent
>>> RX steering and I think GRO would help over list-ified receive in so=
me cases.
>>> We would prefer steer in HW (and thus get existing GRO support) but =
not all
>>> our NICs support it. So we need a software fallback.
>>>
>>> Are you still interested in merging the cpumap + GRO patches?
>
> For sure I can revive this part. I was planning to get back to this
> branch and pick patches which were not related to XDP hints and send
> them separately.
>
>>=20
>> Hi Daniel and Alex,
>>=20
>> Recently I worked on a PoC to add GRO support to cpumap codebase:
>> - https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf0=
16da5a2dd9ac302deaf38b3e
>>   Here I added GRO support to cpumap through gro-cells.
>> - https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa72=
401c7414c9a8a0775ef41a55
>>   Here I added GRO support to cpumap trough napi-threaded APIs (with =
a some
>>   changes to them).
>
> Hmm, when I was testing it, adding a whole NAPI to cpumap was sorta
> overkill, that's why I separated GRO structure from &napi_struct.
>
> Let me maybe find some free time, I would then test all 3 solutions
> (mine, gro_cells, threaded NAPI) and pick/send the best?

Sounds good. Would be good to compare results.

[=E2=80=A6]

Thanks,
Daniel

