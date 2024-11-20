Return-Path: <bpf+bounces-45302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF899D43A9
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 22:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF33B24067
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 21:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D51BD9FC;
	Wed, 20 Nov 2024 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="qI/NuPOg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rmDemweV"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B516130B;
	Wed, 20 Nov 2024 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732139678; cv=none; b=rzZ8mvgmTmY81NATop96AedHhD4OL9tG7eyu57fSS1vlHcbsXzidSIEKaif5JsAxZDpP5XkHjmeAhMLDqW6HFkBBBxY6lXkyrUmQqlUcL++w9I9y7FaMctEEmRUJ05vuCNKnftSkea+Iqlj6i4ZLyjMeNysrPXK4ca/nZkKt7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732139678; c=relaxed/simple;
	bh=BHMpf0cVyl5CAzI0kw/SRq5lsrzKo0uunowvoB1/rGg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GRevFeucjzZYcoHscY9lEUTIi54TuvXIEI4/K9c+zU/+i7gSsmdK6ThOg7cRZr8WGTX99XzrJoOxe6A2NxUVTJRExA9sLm6FjX8PH+2Br9MaBEKozdDdMMC64JONKNS1DlJr+kXOb78duF281YwT9OUf8eoH3aJ4NZTocGJbktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=qI/NuPOg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rmDemweV; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FB6125400DB;
	Wed, 20 Nov 2024 16:54:32 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Wed, 20 Nov 2024 16:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732139672;
	 x=1732226072; bh=BHMpf0cVyl5CAzI0kw/SRq5lsrzKo0uunowvoB1/rGg=; b=
	qI/NuPOgWJa0nW8Amf1CWjfzzN1YhOwDNsDHfFmCwnvm8f6Z9pQq9Xnjez8fiyLp
	rvkFGAYuUBD2D7ClHMa47QuVOTH+dvHFp8DYb4EnNaD7JMrlDUwErsivJBz0ULBB
	seJosy3N5WUnjuyTDayXGqH65lG8ce2hzuzvVRRghsubDgHkWeEkiXmaHkKgurpr
	fDi4MCAugrdpdoqG1UXUnryyDkjyyYUUoWk8CkgOAQw3Tuc48fJsnMHHlcfzzdHW
	JCP6ZshKzDoCJqtemlZGoaNW8r4u/JRNWc+tL0ApOlLbEeXUf+lD7JztHHsad6xA
	H4cz8/lTROoRX+lrZ8Z3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732139672; x=
	1732226072; bh=BHMpf0cVyl5CAzI0kw/SRq5lsrzKo0uunowvoB1/rGg=; b=r
	mDemweVeMIzpgjFv8p7SRaysb12MCFDgU9OlB44ojtM/fSVEIlAAMdEMPJVJAzGJ
	Jmqs7Jfx1RZHXDjX/JZ6zDkSA4oGMLgqfxR0bHZ1Q28vCuvdyYNBnJ9wYsFP839P
	6o6F3eLa5eDeqCAIOey72XVV8ofHeoWP/yDjiUc54DAc75IS/mLy+2s4pG+4KUJ6
	mlaKqTtmvk1m83gONwMmlEcQDN9jNSHvjYrtegAEPObZzPMfuyGIl8x/grn4Nr56
	WVLXitdecOM2x52hODGLLHmCwf1vuTKS1OxlHmAAKYk3rg92HBlUYp2gY5SPre5p
	ci+7OiEZVPXZjdxJ3Httw==
X-ME-Sender: <xms:mFo-ZzB_ThV0BX6xmgbQjNGC3PwhHIVz2U6XK4r-6GqIu2thdTt68Q>
    <xme:mFo-Z5hj58D4JAUPPdAknjinkVGC6F2eF1-l7lbOm71dhv4MaA_jACU-OCttU3FW5
    qdA0h7K7ow1Ka57mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgleeitefgvefffedufefh
    ffdtieetgeetgeegheeufeeufeekgfefueffvefhffenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhgvgigvih
    drshhtrghrohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegurghnihgv
    lhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:mFo-Z-lPgJ1Z6e7DlEnvT_Iab3vWIAmhP4v1P2yschmUYvY4vakbug>
    <xmx:mFo-Z1zIHFXFDgrJM65lLxQ7AfzI5M3WzKlDjJ7Ix2Bovcik4YX9-Q>
    <xmx:mFo-Z4S7V9LtwLjhnBcgL_g5wmyR6PC9hc76eq4Z-vPhRJT3-FCTGw>
    <xmx:mFo-Z4YLajjwNobHYwCs7pyFBa6d0Lde-Fo0aatlz_CGRSKJ6Dxb0g>
    <xmx:mFo-Z-MKd7FEKAPrmn80Q5x2JCC22sYMGPGeCM6ed_ZztqDerZcvsNYe>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0E7CF18A0068; Wed, 20 Nov 2024 16:54:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Nov 2024 13:54:11 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Network Development" <netdev@vger.kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>
Message-Id: <6eb74343-54a4-4725-97e8-e762ab3adfbc@app.fastmail.com>
In-Reply-To: 
 <CAADnVQJ5NnDqx_TMbwHOPySUaJRE-N5K7L_whDsfeyMRBNOFkA@mail.gmail.com>
References: <cover.1692748902.git.dxu@dxuuu.xyz>
 <eb20fd2c-0fb7-48f7-9fd0-4d654363f4da@app.fastmail.com>
 <CAADnVQ+T2nSCA8Tcddh8eD27CnvD1E3vPK0zutDt8Boz7MURQA@mail.gmail.com>
 <7ec1a922-30c5-4899-a23f-11e3ef9d6fef@app.fastmail.com>
 <CAADnVQJ5NnDqx_TMbwHOPySUaJRE-N5K7L_whDsfeyMRBNOFkA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/2] Improve prog array uref semantics
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Nov 20, 2024, at 8:07 AM, Alexei Starovoitov wrote:
> On Wed, Nov 20, 2024 at 7:55=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrot=
e:
>>
>>
>>
>> On Sat, Nov 16, 2024, at 2:17 PM, Alexei Starovoitov wrote:
>> > On Tue, Oct 29, 2024 at 11:36=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> =
wrote:
>> >>
>> >> Hey Daniel,
>> >>
>> >> On Wed, Aug 23, 2023, at 9:08 AM, Daniel Xu wrote:
>> >> > This patchset changes the behavior of TC and XDP hooks during at=
tachment
>> >> > such that any BPF_MAP_TYPE_PROG_ARRAY that the prog uses has an =
extra
>> >> > uref taken.
>> >> >
>> >> > The goal behind this change is to try and prevent confusion for =
the
>> >> > majority of use cases. The current behavior where when the last =
uref is
>> >> > dropped the prog array map is emptied is quite confusing. Confus=
ing
>> >> > enough for there to be multiple references to it in ebpf-go [0][=
1].
>> >> >
>> >> > Completely solving the problem is difficult. As stated in c9da16=
1c6517
>> >> > ("bpf: fix clearing on persistent program array maps"), it is
>> >> > difficult-to-impossible to walk the full dependency graph b/c it=
 is too
>> >> > dynamic.
>> >> >
>> >> > However in practice, I've found that all progs in a tailcall cha=
in
>> >> > share the same prog array map. Knowing that, if we take a uref o=
n any
>> >> > used prog array map when the program is attached, we can simplif=
y the
>> >> > majority use case and make it more ergonomic.
>> >
>> > Are you proposing to inc map uref when prog is attached?
>> >
>> > But that re-adds the circular dependency that uref concept is solvi=
ng.
>> > When prog is inserted into prog array prog refcnt is incremented.
>> > So if prog also incremented uref. The user space can exit
>> > but prog array and progs will stay there though nothing is using th=
em.
>> > I guess I'm missing the idea.
>>
>> IIRC the old-style tc/xdp attachment is the one incrementing the uref.
>
> uref is incremented when FD is given to user space and
> file->release() callback decrements uref.
>
> I don't think any of the attach operations mess with uref.
> At least they shouldn't.

None yet. My patch was adding it. It's fine if it's too much of a hack -
was just an idea.

