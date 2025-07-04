Return-Path: <bpf+bounces-62394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB21AF8D90
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4751CA6675
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03F32EBDE5;
	Fri,  4 Jul 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OZuluILo"
X-Original-To: bpf@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690428AAFD;
	Fri,  4 Jul 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619707; cv=none; b=m2/Lo9DgW+20KFa+7paduiSQGStMEqhWyF44D51DU7Gs35dopFmjeMqdcBWHa9f5lEloDBEBP2mCcBfCE8yjXrjPRK34vkfKsmZjm8wiOmZKN7h3RxNGYNbQ6voAX3KIdGt+7YAHlAqYoTDm+pOtlO+BPcsn8AyN42sogC4YMZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619707; c=relaxed/simple;
	bh=RKpxdQz12HSmR1s34q22IsTMSuY02Ibawb5AVHSBitU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ohgs5/loY+XnVrQozppdwatIajQyJw2b9FLWLG0ss6EB3Yh464pyCdkM5ZhDLCPOyYe9LZEkpZh+rseGBoeXOSTEUo6jVL/Y5J//wWIo9AqnoPvD3jCaHGYYDLT36G5n4jIk7oY/+9UxyYDz7P8k0HcB5YhS7bRZN/e5y/8kWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OZuluILo; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2A6442E80;
	Fri,  4 Jul 2025 09:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751619703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63juCEDToCfU4/4jKNZ4QhLNug1t6BClZLQgmtBU6JI=;
	b=OZuluILoNkoyqtshrUz70rkcpMuF8ocXNhnGd4wZOq7sD6MOho8DYNfxTqAp5ztFU1ffqa
	cCvpHNNNkwLlel3I/irsVjmABR9Fmcx75wBc14S16X/83OQSzEqtmpmUymZ2L8yENyNoqZ
	ML0o6Af40wlK2m2c9esq2IC7DMhXACLBUSTfJPPgQhtys6PC6Itlrkm+0QmLe6yCgQA+ms
	Wmibi6xfEqsfGbytDChXhyHt9+mohCXGZj+C/wFHWqxej85+TW2fDZRduF45hKurLcBCkh
	+BWJ1E5KXoDVSPRu/M4oqxCTiAiPX/KhChOBUVy6fimVpybp8+QsGNObEJP+4Q==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 11:01:42 +0200
Message-Id: <DB35D2MDSOGN.1X8PB5AF5M3KN@bootlin.com>
Cc: <bpf@vger.kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Alexei Starovoitov"
 <ast@fb.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, <ebpf@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] btf_encoder: skip functions consuming packed
 structs passed by value on stack
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com> <20250703-btf_skip_structs_on_stack-v2-1-4767e3ba10c9@bootlin.com> <8923cd39-a242-4f61-b99e-b5fe5678ee84@linux.dev>
In-Reply-To: <8923cd39-a242-4f61-b99e-b5fe5678ee84@linux.dev>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleekheeihfefheevhfdtgeeuleekheffffffuedvkeekkeduvdeugeeugfeiueeknecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepihhhohhrrdhsohhlohgurhgriheslhhinhhugidruggvvhdprhgtphhtthhopegufigrrhhvvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepr
 ggtmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehfsgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Ihor,

thanks for the prompt feedback and testing !

On Thu Jul 3, 2025 at 8:17 PM CEST, Ihor Solodrai wrote:
> On 7/3/25 2:02 AM, Alexis Lothor=C3=83=C2=A9 (eBPF Foundation) wrote:

[...]

>>   		/* do not exclude functions with optimized-out parameters; they
>>   		 * may still be _called_ with the right parameter values, they
>>   		 * just do not _use_ them.  Only exclude functions with
>> -		 * unexpected register use or multiple inconsistent prototypes.
>> +		 * unexpected register use, multiple inconsistent prototypes or
>> +		 * uncertain parameters location
>>   		 */
>> -		add_to_btf |=3D !state->unexpected_reg && !state->inconsistent_proto;
>> +		add_to_btf |=3D !state->unexpected_reg && !state->inconsistent_proto =
&& !state->uncertain_parm_loc;
>
>
> Is it possible for a function to have uncertain_parm_loc in one CU,
> but not in another?
>
> If yes, we still don't want the function in BTF, right?

TBH, my understanding about those discrepancies between CUs about the same
functions and how pahole handle them is still a bit fragile. Have you got
any example about how it could be the case ?

If it _can_ happen, I guess you are suggesting to make sure that copies are
compared in saved_functions_combine and their uncertain_loc_parm flag are
aligned. Something like this:

uncertain_parm_loc =3D a->uncertain_parm_loc | b->uncertain_parm_loc;
[...]
a->uncertain_parm_loc =3D b->uncertain_parm_loc =3D uncertain_parm_loc;

>> @@ -2693,6 +2736,9 @@ int btf_encoder__encode_cu(struct btf_encoder *enc=
oder, struct cu *cu, struct co
>>   		if (!func)
>>   			continue;
>>  =20
>> +		if (ftype__has_uncertain_arg_loc(cu, &fn->proto))
>> +			fn->proto.uncertain_parm_loc =3D 1;
>> +
>>   		err =3D btf_encoder__save_func(encoder, fn, func);
>
> I think checking and setting uncertain_parm_loc flag should be done
> inside btf_encoder__save_func(), because that's where we inspect DWARF
> function prototype and add a new btf_encoder_func_state.

ACK, it can be moved there

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


