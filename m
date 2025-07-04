Return-Path: <bpf+bounces-62395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6866BAF8E1D
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 11:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464A77664AB
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058C82D3A66;
	Fri,  4 Jul 2025 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U7Bv1av+"
X-Original-To: bpf@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709228B419;
	Fri,  4 Jul 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619976; cv=none; b=Om+cFOebR9odkqV03x/0gFlTsKK+HYkBB1DDuhYD6lyD28uRLFPqFc6SXOWFHnnoGZvSNE9Ss0p+Na3Scg3UXiYEKI5nTIdAKx0iC3FwceUBHM9ORF4pA5zksI0o3lcUoI+eyPJjFZTYDEBFOkelLzvG5pQ09KOxmP4JD5J3jlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619976; c=relaxed/simple;
	bh=TZo0K5Grsjuk/bWZy66aJ83CRLKvRDZ2Ui5//YSAigc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jxfh8FtX7F05GWsR9IsJHQ615RJheo2WKrfYiUB3KPaiI6Hjn5VEirzSFgW7BlyCgaxw1Q/Pp8aXndh7XDdBfuOkElH5rwpy1c0dZ9PSPaXCxAK1/uLumZNT1gyZy/jXK+7m9HrbQap3RapvSjZLLDUoveJc3sr9FfJt58xhXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U7Bv1av+; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E0F343122;
	Fri,  4 Jul 2025 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751619972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmgsGc2Ff+X+aNbCppR57L5wZkmiu/nGCxJkJK/nc0w=;
	b=U7Bv1av+SefnUDPXImDM4yXHlA9P+eq8MeMunEIYxVCNWoTdTQM46s/lbijx8cLiI/nSyJ
	qByAT2Qpbl2CIbhedlN2jQYg8yskFuTkDb+bQZgflQPuIUp0gAEyXG3ZzkX6lJXeWinAiD
	jpBZyzZYE9y26AoL8L4W4d7jHhpoyvDDbplq4jH+tGqH5VWaWNx1oIJ2y+3uE3WxT550Pd
	RvjExFA+DeWrvbsXuEEvkoud+pTs6KxBgSnd8YrNYIp9AlpW2NM86IEhtV6MHYGgYEtXxP
	wIKkGDNBRhXwSQPBQOFDE/IeKwxXb2rwGvkra/r/xdOcSjCowRABrN8L8d/46A==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 11:06:12 +0200
Message-Id: <DB35GID20CS5.3LRBJWIK4E1YU@bootlin.com>
Cc: <bpf@vger.kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Alexei Starovoitov"
 <ast@fb.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, <ebpf@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] tests: add some tests validating skipped
 functions due to uncertain arg location
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com> <20250703-btf_skip_structs_on_stack-v2-2-4767e3ba10c9@bootlin.com> <f696f834-bca6-4f9e-a81e-f7e45126e2eb@linux.dev>
In-Reply-To: <f696f834-bca6-4f9e-a81e-f7e45126e2eb@linux.dev>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleekheeihfefheevhfdtgeeuleekheffffffuedvkeekkeduvdeugeeugfeiueeknecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepihhhohhrrdhsohhlohgurhgriheslhhinhhugidruggvvhdprhgtphhtthhopegufigrrhhvvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepr
 ggtmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehfsgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

On Thu Jul 3, 2025 at 8:31 PM CEST, Ihor Solodrai wrote:
> On 7/3/25 2:02 AM, Alexis Lothor=C3=83=C2=A9 (eBPF Foundation) wrote:
>> Add a small kernel module representing specific cases likely absent from
>> standard vmlinux files. As a starter, the introduced module exposes a
>> few functions consuming structs passed by value, some passed by
>> register, some passed on the stack:
>>=20
>>    int kmod_test_init(void);
>>    int test_kmod_func_ok(int, void *, char, short int);
>>    int test_kmod_func_struct_ok(int, void *, char, struct kmod_struct);
>>    int test_kmod_func_struct_on_stack_ok(int, void *, char, short int, i=
nt, \
>>      void *, char, short int, struct kmod_struct);
>>    int test_kmod_func_struct_on_stack_ko(int, void *, char, short int, i=
nt, \
>>      void *, char, short int, struct kmod_struct_packed);
>>=20
>> Then enrich btf_functions.sh to make it perform the following steps:
>> - build the module
>> - generate BTF info and pfunct listing, both with dwarf and the
>>    generated BTF
>> - check that any function encoded in BTF is found in DWARF
>> - check that any function announced as skipped is indeed absent from BTF
>> - check that any skipped function has been skipped due to uncertain
>>    parameter location
>>=20
>> Those new tests are executed only if a kernel directory is provided as
>> script's second argument, they are otherwise skipped.
>
> While this shouldn't be a problem for CI, since it checks out a kernel
> tree to test vmlinux as input, I wonder if there is a way to do the
> same test without this dependency.
>
> We need to generate a binary with DWARF, containing function
> prototypes with packed/aligned attributes. Give it to pahole and see
> that those functions were skipped.
>
> Any reason it must be a kernel module? Am I missing something?

I guess I have no valid reason, I just focused too much on a specific use
case :) It would indeed be simpler with a bare userspace binary, I'll check
further and change it.

>> Example of the new test execution:
>>    Encoding...Matched 4 functions exactly.
>>    Ok
>>    Validation of skipped function logic...
>>    Skipped encoding 1 functions in BTF.
>>    Ok
>>    Validating skipped functions have uncertain parameter location...
>>    Found 1 legitimately skipped function due to uncertain loc
>>    Ok

> This part fails for me:
>
> isolodrai@isolodrai-fedora-PC2K40WQ:~/pahole/tests$=20
> KDIR=3D/home/isolodrai/kernels/bpf-next=20
> vmlinux=3D/home/isolodrai/kernels/bpf-next/vmlinux ./btf_functions.sh
> Validation of BTF encoding of functions; this may take some time: Ok
> Validation of BTF encoding corner cases with kmod functions; this may=20
> take some time: make: Entering directory '/home/isolodrai/kernels/bpf-nex=
t'
> Makefile:199: *** specified external module directory "./kmod" does not=
=20
> exist.  Stop.
> make: Leaving directory '/home/isolodrai/kernels/bpf-next'
> No skipped functions.  Done.
>
> Maybe:
>
> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
> index 64810b7..fcb1591 100755
> --- a/tests/btf_functions.sh
> +++ b/tests/btf_functions.sh
> @@ -208,7 +208,7 @@ fi
>   echo -n "Validation of BTF encoding corner cases with kmod functions;=
=20
> this may take some time: "
>
>   test -n "$VERBOSE" && printf "\nBuilding kmod..."
> -tests_dir=3D$(dirname $0)
> +tests_dir=3D$(realpath $(dirname $0))
>   make -C ${KDIR} M=3D${tests_dir}/kmod
>
>   test -n "$VERBOSE" && printf "\nEncoding..."
>
>
> Also, in case kernel is built with LLVM, one must set LLVM=3D1.
> Not sure if this is detectable by the test.

Yeah, the tests_dir computation is a bit fragile. I saw it in tests.sh, and
so I assumed use cases were simple enough to keep this simple logic. I'll
update it to make it more robust.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


