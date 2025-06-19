Return-Path: <bpf+bounces-61097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C8BAE0B10
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 18:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D9E5A3F85
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB4427F166;
	Thu, 19 Jun 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="chyWAeo7"
X-Original-To: bpf@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88EE11712;
	Thu, 19 Jun 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750349176; cv=none; b=i1Lh4YkJiodWtndj0WIeYE3uLs4EwnuYcRqTQzHIFzVspXlhfYKvlUbb8ZFArJ61KXfw29Yb3hXIIDWs49Ab28wdzQhYHa3YpN5NkvyHnWHKAnFx/+3UzvJhVdULD6Rw/DrUuSvOLDNy+Fr/DT2fbVyX59RlqOn2YqM326tj0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750349176; c=relaxed/simple;
	bh=wTGGYfzud1PTlVr/t9Pp+nQQlZtKx8espO0QDOy/4Tw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UIagE0+UEk6SaCtsJ1VXGtdWD0RQuecy4hPLZioM2iEd97kClrjraWs/4n8r/Km4K6Mp5YiFa4d6K4SFSd7SXeeY/cl79OOtscq54IyQNScLZvNo2lNoxMkPkMnxCGS0dnHbkbcPRtQjB2mW7zydfDDJHoWNGxeS2vvb2OdIuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=chyWAeo7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB6D343920;
	Thu, 19 Jun 2025 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750349166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTGGYfzud1PTlVr/t9Pp+nQQlZtKx8espO0QDOy/4Tw=;
	b=chyWAeo72WlUAlMwjs4cy4jPI95xvM0QkFNafKYAL8MKaWZWrvWWIbqEnc32ACUz/APRSI
	cuZCSIZkGDhMww0x54fCGGP42TXNH4vQIa+jtgoxmvt4DFMVp8iTyoNbav1FAk5f2E49L5
	GvpJtJ+gHO+GVOqbqj/0NduwTkHEuJ/qbjh55/jRMVNT8q4fHEsvOg28kbS8BuSsjuKs5Q
	xKRfreIALSTwA33zGw2Lx+0VRN41hJ0ANTxhPqK2si9qLlWnoSOk56h7XG9NEhVMQFQe6L
	aFfVOflBjP4EJ9G/8hWtCboe9pW1YybGe7LNfW8FIsAAv37sOHMzzd3WSFyZmg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Jun 2025 18:06:05 +0200
Message-Id: <DAQMZTVLO2QH.2YXXTMEU8BQ4M@bootlin.com>
Cc: "dwarves" <dwarves@vger.kernel.org>, "bpf" <bpf@vger.kernel.org>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Alexei Starovoitov"
 <ast@fb.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH RFC] btf_encoder: skip functions consuming structs
 passed by value on stack
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250618-btf_skip_structs_on_stack-v1-1-e70be639cc53@bootlin.com> <CAADnVQJOiqCic664bPaBdwBwf1NGqfH-T6ZkQJOF7X4h7HuxBA@mail.gmail.com> <DAQJB898I4M9.2EE33TP8JV9X9@bootlin.com> <6fb578bd-8851-414e-bfea-dec2472c6ee4@oracle.com>
In-Reply-To: <6fb578bd-8851-414e-bfea-dec2472c6ee4@oracle.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehiefhfeehvefhtdegueelkeehffffffeuvdekkeekuddvueeguefgieeukeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghlvgigvghirdhsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfs
 ehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggtmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehfsgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Alan,

On Thu Jun 19, 2025 at 5:41 PM CEST, Alan Maguire wrote:
> On 19/06/2025 14:12, Alexis Lothor=C3=A9 wrote:
>> On Wed Jun 18, 2025 at 6:28 PM CEST, Alexei Starovoitov wrote:
>>> On Wed, Jun 18, 2025 at 8:02=E2=80=AFAM Alexis Lothor=C3=A9
>>> <alexis.lothore@bootlin.com> wrote:

[...]

>>> though it's passed on the stack it fits into normal calling convention.
>>> It doesn't have align or packed attributes, so no need to exclude it ?
>>=20
>> I went for the simplest solution, assuming that there were cases involvi=
ng
>> packing/alignent customization that we would not be able to detect (eg: =
the
>> packed attr that does not change size but reduce alignment). But thinkin=
g
>> more about it, those cases need really specific conditions thay may not
>> exist currently in the kernel (eg: having some __int128 embedded in a
>> struct).
>>=20
>> I see that pahole already has some logic to check if a struct is
>> altered (eg class__infer_packed_attributes), I'll check if I can come wi=
th
>> something more selective.
>>
>
> sounds good; one additional suggestion is given that these sorts of
> functions are rare to nonexistent in vmlinux, perhaps we could add some
> tests to the tests/ directory that compile C code and generate BTF from
> the associated DWARF, verifying that functions are (or are not) encoded
> as expected?
>
> I'm working on adding automatic comparison of vmlinux BTF function
> encoding for candidate patch series to pahole's CI (so we can see if
> functions appear/disappear), but in a case like this a few explicit
> tests would be great to have. Thanks!

Yes, sure. I did not consider at all tests while the series is in RFC, but
I had it in mind for the next steps. I'll take into account the need to
add and build automatically some custom C code exposing those "exotic"
functions and structs.

Alexis.

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


