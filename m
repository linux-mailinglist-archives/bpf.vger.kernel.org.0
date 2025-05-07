Return-Path: <bpf+bounces-57716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A822AAEEAA
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 00:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9E79C38EE
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECC0219A7A;
	Wed,  7 May 2025 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HHidIfVq"
X-Original-To: bpf@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1567231A3B;
	Wed,  7 May 2025 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746656435; cv=none; b=StXUwDvkpr7sUeXgGof1Ipo0mMlMdSX0moZTH2DIOOYQDL3e36+etdAFyxz2MEujYhyyM8uSdoOIkT6jxryrKIpVLaiG26d8hoeAtTjhWWLBvfsKmGDdq3r0jPJo8dbqCHztNOnuTMd+QkAhYJntC6jD6ZSNfPyILgpdtnfkNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746656435; c=relaxed/simple;
	bh=mLymb9m1Aamh6w9wXRY8bm3iLfvFqm2zCOEODZIwCHY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=bgcLYSVQgq0t9XgI8k6FKenMRdwy/jiCHCTbTEidi+fM9LZlVVwcXzwFpl67XBuKVSj/wxuKsBcqIjqoEp9BDCShzsMTRDk/A2/YxmWFwo7ThCgQ3vGtVGN3163U3pwqqP0Z6HuAd/oLnR2H2NNPwFlRXlFfDAiNSKPBDiiyhIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HHidIfVq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5780B43969;
	Wed,  7 May 2025 22:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746656430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwXyFQMqk6Dz3xysP6Qan9loJGBSspmDNGXagmKMr7s=;
	b=HHidIfVqd1xpJy0qJEs8nlSaspY3IRVsFG3h9lSYVZHXdIGwQn+gS2dr+3617xZdMxAlUT
	GRjF8MsBo2Y50uUL9ciDRl2gzj540aG/uCo0j/lFdegmW1SWOp7jeE01yeHI1aNc81WntT
	dUPMd95WCerz7GQcfazBNPQXtqfZQ8GVTant2HGWs4WXfJ5e0Hw3JNQjYkYM/Oling4eK+
	awCYtgSUeh9TuoVE0dzcokv4bPJksErtxL3/NhScBHS+btf5ofdUhobc9Oqauw1zNc9RSH
	LpM2rPcB4KAR2f7J+hGZ3NA87/Un98NiQn5bCiYi8BGOV/DVdNVuL0Qs6EwVpw==
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 May 2025 00:20:30 +0200
Message-Id: <D9QA12O1IQU9.3AVBN6BI611LL@bootlin.com>
Cc: "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Alan Maguire"
 <alan.maguire@oracle.com>, <bpf@vger.kernel.org>, <dwarves@vger.kernel.org>
Subject: Re: Pahole/BTF issue with __int128
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Tony Ambardar" <tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <D9Q73OTLEOU4.LNAO9K4POETM@bootlin.com>
 <aBvE++cyskZTfAo5@kodidev-ubuntu>
In-Reply-To: <aBvE++cyskZTfAo5@kodidev-ubuntu>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeektdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtfffkvefuhffvggfgofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekveevvdekieeihffftefgieffvedvhfehgfehkeeuudfhveeufffgffejiefhueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmeguieehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemugeihedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepthhonhihrdgrmhgsrghruggrrhesghhmrghilhdrtghomhdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlrghnrdhmrghguhhirhgvsehorhgrtghlvgdrtghomhdprhgtphhtthhopegsphhfs
 ehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Tony,
thanks a lot for the prompt answer !

On Wed May 7, 2025 at 10:39 PM CEST, Tony Ambardar wrote:
> On Wed, May 07, 2025 at 10:02:51PM +0200, Alexis Lothor=C3=A9 wrote:
>> Hello,

[...]

> Hi Alexis,
>
>> Am I missing some constraint or limitation that would prevent the case 2
>> function from being described with BTF info ? If not, any advice about h=
ow
>> to debug this further ?
>>=20
>
> I suspect this might be related to an issue I ran into where pahole may
> mis-encode types larger than register-size [1]. Out of curiosity, could
> you try rebuilding and using a pahole with my latest patch [2]?
>
> 1: https://lore.kernel.org/dwarves/20250410083359.198724-1-tony.ambardar@=
gmail.com/
> 2: https://lore.kernel.org/dwarves/20250502070318.1561924-1-tony.ambardar=
@gmail.com/

I gave a try to your patch on top of pahole 1.30, and indeed it seems that
my issue is fixed with your solution. I now have some BTF info for my
bpf_testmod_test_struct_arg_11 func:

  [...]
  [370] FUNC_PROTO '(anon)' ret_type_id=3D6 vlen=3D6
          'a' type_id=3D10
          'b' type_id=3D10
          'c' type_id=3D10
          'd' type_id=3D10
          'e' type_id=3D5
          'f' type_id=3D10
  [371] FUNC 'bpf_testmod_test_struct_arg_11' type_id=3D370 linkage=3Dstati=
c
  [...]

I also did some quick tests around Alan's request in your series, I'll
report to your series' thread.

Thanks for the help !

Alexis


>
> Cheers,
> Tony
>
>> Thanks,
>>=20
>> Alexis
>>=20
>> --=20
>> Alexis Lothor=C3=A9, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


