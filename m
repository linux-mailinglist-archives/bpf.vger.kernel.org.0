Return-Path: <bpf+bounces-62446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1B6AF9BDE
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DA354531E
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5C221930A;
	Fri,  4 Jul 2025 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FiDB4SCo"
X-Original-To: bpf@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FE57C9F;
	Fri,  4 Jul 2025 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751663539; cv=none; b=Fgs9KRiY45qbr2CQ2o1Mewjn4fbpIJWmUjmvm/U7UWNGAA5fpQciwICFEE3QyOxnayrlNz+yaX74JOy7X9RWFLGH6h53sUQTdRgWGvL65GZ5z/y1jvxb058+3HmOq9QIaEkDZ/8l53oCof6S4uKA3NYiLVm0qw4i3TD2WUlIpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751663539; c=relaxed/simple;
	bh=MgYC9qqAZAQNZkFf1BLgkNZGVA4HumXB4KjV5wQd2F0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OHr8PwQs1dK3tt4sTn6LHnbi4n5fGcxYicbyIt1+bIR9Vw6IGWflbNoJSY0m3cUM10J7fnowvr/m2HY8YoPI4wElga1DFRVJfOFD49o2Nt3nEfP2ivkhcly2xaxNuhtdAVrsVpbJ3rjO70USMZ4QwuBPD08ZlOrL97++8n4ui2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FiDB4SCo; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C13543890;
	Fri,  4 Jul 2025 21:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751663529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijcP2GejPAnbC48qS7uXsUWPEErxeSz+oaH5ShNVXPo=;
	b=FiDB4SCoU8EW9FIcXUE5S98e4lhMP+4VH6BossI9wrs0uPEd78NImv2V5TJC+ITBbCpcgs
	SX1SuWeIvs5493W2an+gcGCDfESZj+qo3LYbazKQilA1OgSIhAQ2/FNLOeKQUG4y2IR3c6
	EJ+4Kyn9EuXkjfWaNVSGJOQ9t11aoLeNZk8+8POaABOAgWkZhD+dOHUJ1hU1N4AC8z7a6b
	hzcTtiDLziOmzEnXc04kNVf5Alj8YzE7VKBCulPpypvEBeEFtSH8lCcW9JRt5QSNbxRkNL
	yZF14EkAZNbt/X8KGf33+9g55I7N/cumNnUB/MZOww1uxvktkIZzdttgxOq38w==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 23:12:08 +0200
Message-Id: <DB3KWBZ9BGN3.2DLBD6KHJ6ZZC@bootlin.com>
Cc: <bpf@vger.kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Alexei Starovoitov"
 <ast@fb.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, <ebpf@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] btf_encoder: skip functions consuming packed
 structs passed by value on stack
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com> <20250703-btf_skip_structs_on_stack-v2-1-4767e3ba10c9@bootlin.com> <5aadf682-3b1f-4769-a2c1-523085026ac8@linux.dev>
In-Reply-To: <5aadf682-3b1f-4769-a2c1-523085026ac8@linux.dev>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvgedvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptedtvdfggfetuedvueeuhfdvleetvdffudelveffiefggedvkedutddtffduhfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemsgehvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmegshegvpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehihhhorhdrshholhhoughrrghisehlihhnuhigrdguvghvpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlrghnrdhmrghguhhirhgvs
 ehorhgrtghlvgdrtghomhdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsthesfhgsrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomh

On Fri Jul 4, 2025 at 10:05 PM CEST, Ihor Solodrai wrote:
> On 7/3/25 2:02 AM, Alexis Lothor=C3=83=C2=A9 (eBPF Foundation) wrote:

[...]

>> +static bool ftype__has_uncertain_arg_loc(struct cu *cu, struct ftype *f=
type)
>> +{
>> +	struct parameter *param;
>> +	int param_idx =3D 0;
>> +
>> +	if (ftype->nr_parms < cu->nr_register_params)
>> +		return false;
>> +
>> +	ftype__for_each_parameter(ftype, param) {
>> +		if (param_idx++ < cu->nr_register_params)
>> +			continue;
>> +
>> +		struct tag *type =3D cu__type(cu, param->tag.type);
>> +
>> +		if (type =3D=3D NULL || !tag__is_struct(type))
>> +			continue;
>> +
>> +		struct type *ctype =3D tag__type(type);
>> +		if (ctype->namespace.name =3D=3D 0)
>> +			continue;
>> +
>> +		struct class *class =3D tag__class(type);
>> +
>> +		class__find_holes(class);
>> +		class__infer_packed_attributes(class, cu);
>
> I just noticed that class__infer_packed_attributes() already does call
> class__find_holes() [1], so calling it here is unnecessary. Although
> there is already a flag to detect repeated calls [2].
>
> [1] https://github.com/acmel/dwarves/blob/master/dwarves.c#L1859
> [2] https://github.com/acmel/dwarves/blob/master/dwarves.c#L1604-L1605

ACK, I'll remove the duplicate class__find_holes then.

