Return-Path: <bpf+bounces-62445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1943EAF9BDC
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AF87A961C
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 21:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D03218827;
	Fri,  4 Jul 2025 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iB4f0WyX"
X-Original-To: bpf@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F8B86329;
	Fri,  4 Jul 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751663413; cv=none; b=R9Q0ic/frhvIXRZbzWyMuYuSB3uSuauDbJERMsqzPKKjdPExtxt73n2KmPJODeEg/Vl7dOnPgvBSvkfJrnt8c4ODBO2n7abd20gus4kn0SNhSCJq0JfHp+7hYDcd4HoTwXT9eEom7+G3UDE3po1tCGb2w4GLFwoNWmUmveCulhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751663413; c=relaxed/simple;
	bh=iOlVGYXIaHdx9FU2jfM2U5YECB3mmKKuqVUVbRsDbrQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LQn14lDeAC7yGeM5BB8y3xW/ER8+u8i+Iuo1pRN8Vy5E3XC1U8JraJYL4nBWujT7NtFfGcFYxiFZfba+Knae7ujVeqXKenH3Nh3DFV9SK3qPiqeMGtr0E8W0fXdmTJZplRS147Q4a96njeASIe5yR0TgUFjtx5xrjBuFyT3X3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iB4f0WyX; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B6D3442D7;
	Fri,  4 Jul 2025 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751663408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwiUZSVURQgKc/avE+J57gMa/HpkFfMh4jEvN/BZ29U=;
	b=iB4f0WyXAbAkQy5m6W5lXAiqHYnomQ2q3AnCUIs+xJ/RF8nk5SBjNzQPq1YCAAogJvs1h4
	lCThBRp7sjv1eQFWZTJftfww/jc/QRN8cA5UyvQqQdrTZ5yz4W2nIqya7+Z5qG2Z1DtItr
	Gm2Yu3uJpIKwFvU35UZz3wbgePfhqmqlkBwCvyEBXh7Axq4h/OKdhUJ4gbpMwjPULY7jNL
	OEatCSEzflPcwgL65C14MJc0oEU9v6cFn/Wvq2NDFUS33B1VcOaUn0HynNss2NTeuZ9SoR
	xLs+Y0JuY5yY9/fs0JBS0fs8Btm+ZQvJLkPZS0Dprp0D9vDFmQ6ppWd5tbr/Jg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 23:10:07 +0200
Message-Id: <DB3KUSI90IPO.1AR35OTXH2Y8M@bootlin.com>
Cc: <bpf@vger.kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Alexei Starovoitov"
 <ast@fb.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, <ebpf@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] btf_encoder: skip functions consuming packed
 structs passed by value on stack
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com> <20250703-btf_skip_structs_on_stack-v2-1-4767e3ba10c9@bootlin.com> <8923cd39-a242-4f61-b99e-b5fe5678ee84@linux.dev> <DB35D2MDSOGN.1X8PB5AF5M3KN@bootlin.com> <a9a3cc94-7ce2-4993-96ab-500f250e6e25@linux.dev>
In-Reply-To: <a9a3cc94-7ce2-4993-96ab-500f250e6e25@linux.dev>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvgedvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudfgjeejkedugeekgeeftdffvdeiieetkedtffetudeuueegtedugfefkeejffehnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmegshegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemsgehvgdphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepihhhohhrrdhsohhlohgurhgriheslhhinhhugidruggvvhdprhgtphhtthhopegufigrrhhvvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepr
 ggtmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehfsgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhm

On Fri Jul 4, 2025 at 9:59 PM CEST, Ihor Solodrai wrote:
> On 7/4/25 2:01 AM, Alexis Lothor=C3=A9 wrote:
>> Hello Ihor,
>>=20
>> thanks for the prompt feedback and testing !
>>=20
>> On Thu Jul 3, 2025 at 8:17 PM CEST, Ihor Solodrai wrote:
>>> On 7/3/25 2:02 AM, Alexis Lothor=C3=83=C2=A9 (eBPF Foundation) wrote:
>>=20
>> [...]
>>=20
>>>>    		/* do not exclude functions with optimized-out parameters; they
>>>>    		 * may still be _called_ with the right parameter values, they
>>>>    		 * just do not _use_ them.  Only exclude functions with
>>>> -		 * unexpected register use or multiple inconsistent prototypes.
>>>> +		 * unexpected register use, multiple inconsistent prototypes or
>>>> +		 * uncertain parameters location
>>>>    		 */
>>>> -		add_to_btf |=3D !state->unexpected_reg && !state->inconsistent_prot=
o;
>>>> +		add_to_btf |=3D !state->unexpected_reg && !state->inconsistent_prot=
o && !state->uncertain_parm_loc;
>>>
>>>
>>> Is it possible for a function to have uncertain_parm_loc in one CU,
>>> but not in another?
>>>
>>> If yes, we still don't want the function in BTF, right?
>>=20
>> TBH, my understanding about those discrepancies between CUs about the sa=
me
>> functions and how pahole handle them is still a bit fragile. Have you go=
t
>> any example about how it could be the case ?
>
> I would hope stuff like this doesn't happen often in the real
> world, but in principle you could have the following situation:
>
> #ifdef ENABLE_PACKING
> struct some_data {
>      char header;
>      int payload;
>      short footer;
> } __attribute__((packed));
> #else
> struct some_data {
>      char header;
>      int payload;
>      short footer;
> };
> #endif
>
> void read_data(/* lots of args */, struct some_data data) { ... }
>
> And then one user has #define ENABLE_PACKING and the other doesn't,
> for example:
>
> #define ENABLE_PACKING // or not
> #include "some_data.h"
>
> void user() {
>       struct some_data =3D get_some_data();
>       ...
>       read_data(/* args */, some_data);
> }
>
> And then you compile a binary with both users:
>
> $ gcc -g -O0 user1.c user2.c
>
> DWARF will contain both packed and not packed instances of struct
> some_data and two corresponding read_data() funcs.

Got it, thanks for the clarification !

