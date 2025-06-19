Return-Path: <bpf+bounces-61077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9758AE06A4
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 15:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72025169BDD
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C9424DCE3;
	Thu, 19 Jun 2025 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l0XgnY5P"
X-Original-To: bpf@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB08424BCE8;
	Thu, 19 Jun 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338779; cv=none; b=eJw1kOhJZR1H9g9HHb3Yi82Cf21iOOi53hZ2j525CjfXv7i8/U3ceq5S+GJqSHObN9jegzUcFh2LvAuOdFdAFvqHmcEUb8BkL+ASFwH8k1j/4dLNHLLAYnh0aVZqMXeyMtAKfDyW1YN6BCgyyI6BqhPPAh7pgi7d8otG4q12sk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338779; c=relaxed/simple;
	bh=EAEwLrNrZn89SJrZf6SoWUu9v34ompP4HfrQsDRwCZ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=G9bfkBfNWLi5A9KWUA82HQikZmltBQq72KVBdRz7y0HnfEJ3rAeFIa65To9sUoJhTH40kA7sS1Bb6/mj/w2hCzSEbsi8UgaptxOQlzzLjwny4M7j1/VcADz6YszSJMscGQ+SRG4Q9R8WypRNRajqVwVbeZDaLN6hRuGODbop1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l0XgnY5P; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F87E44409;
	Thu, 19 Jun 2025 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750338775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPkK/JmjHVHDwlaJB0UiPd7flLbze+6a9dRbeO8SSOs=;
	b=l0XgnY5PRdfPXtdLtkzrYegKR20q4cI0YxjNzx11XtI+vj3BsIOhUSefOlhpshdaw18thU
	Zm7Dni+IN91pGGOjv/ihI/MEIT4xFa4A6G+jpum1yDl0dSE21KrFkqn4YDb19yfQqLV7td
	DgOvdJAVgUolP3zNRE/8jkkjCwFb5Nk48fsI52PHr/nf5tL/89Btg+tHfexWeaA2al4vEV
	pUkGzsPl8Y8R3ypTkFpLTPdmnqUimqPXkiaXXYATKMKef5/8JLWdD8OdvXl9o3uwYzh+wF
	nbonUKWNzU7VUgjefAQQ2PJdCF4DrBoZ1NR0ZzWo+DzL3O+PCe3L6dNiIv2fKw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Jun 2025 15:12:54 +0200
Message-Id: <DAQJB898I4M9.2EE33TP8JV9X9@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "dwarves" <dwarves@vger.kernel.org>, "bpf" <bpf@vger.kernel.org>, "Alan
 Maguire" <alan.maguire@oracle.com>, "Arnaldo Carvalho de Melo"
 <acme@kernel.org>, "Alexei Starovoitov" <ast@fb.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH RFC] btf_encoder: skip functions consuming structs
 passed by value on stack
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250618-btf_skip_structs_on_stack-v1-1-e70be639cc53@bootlin.com> <CAADnVQJOiqCic664bPaBdwBwf1NGqfH-T6ZkQJOF7X4h7HuxBA@mail.gmail.com>
In-Reply-To: <CAADnVQJOiqCic664bPaBdwBwf1NGqfH-T6ZkQJOF7X4h7HuxBA@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfffhfehhfefgeekhfffudfhheekveffleeuhfelgfefueevhedvkeduhfehveenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrlhgvgigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegufigrrhhvvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgrnhdrmhgrg
 hhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprggtmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehfsgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

On Wed Jun 18, 2025 at 6:28 PM CEST, Alexei Starovoitov wrote:
> On Wed, Jun 18, 2025 at 8:02=E2=80=AFAM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:
>>
>> - those attributes are not reliably encoded by compilers in DWARF info
>
> What would be an example of unreliability?
> Maybe they're reliable enough for cases we're concerned about ?

The example I had in mind is around the fact that there is no explicit
dwarf attribute stating that a struct is packed. It may be deduced in some
cases by taking a look at the DW_TAG_byte_size and checking if it matches
the expected size of locations of all its members, but there are cases in
which the packed attribute does not change the struct size, while still
altering its alignment (but more below)
>
>> +
>> +               if (param_idx >=3D cu->nr_register_params) {
>> +                       if(dwarf_attr(die, DW_AT_type, &attr)){
>> +                               Dwarf_Die type_die;
>> +                               if (dwarf_formref_die(&attr, &type_die) =
&&
>> +                                               dwarf_tag(&type_die) =3D=
=3D DW_TAG_structure_type) {
>> +                                       parm->uncertain_loc =3D 1;
>> +                               }
>> +                       }
>> +                       return parm;
>
> This is too pessimistic.
> In
> bpf_testmod_test_struct_arg_9(u64 a, void *b, short c, int d, void *e, ch=
ar f,
>                               short g, struct bpf_testmod_struct_arg_5
> h, long i)
>
> struct bpf_testmod_struct_arg_5 {
>         char a;
>         short b;
>         int c;
>         long d;
> };
>
> though it's passed on the stack it fits into normal calling convention.
> It doesn't have align or packed attributes, so no need to exclude it ?

I went for the simplest solution, assuming that there were cases involving
packing/alignent customization that we would not be able to detect (eg: the
packed attr that does not change size but reduce alignment). But thinking
more about it, those cases need really specific conditions thay may not
exist currently in the kernel (eg: having some __int128 embedded in a
struct).

I see that pahole already has some logic to check if a struct is
altered (eg class__infer_packed_attributes), I'll check if I can come with
something more selective.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


