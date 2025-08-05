Return-Path: <bpf+bounces-65086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C3FB1BABA
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 21:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE70A18A5A8C
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ACB274FD5;
	Tue,  5 Aug 2025 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZTtrDN2l"
X-Original-To: bpf@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC41295DBE;
	Tue,  5 Aug 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420789; cv=none; b=OBTxXBqgXz0lgMV1U1j2/BISpYBuDndWBLgUsMbKxe+qUEjMLChy9ckm0ubo4sd3yt5i8w9du6KR7tteRUapyzFhWe892M4i7p+ZEdpwL9doskV8NHvU6lb4fWu2gRUIytEdT2bHSX/GwipSvNEXMirlGTQl0H3mDdulaBcW5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420789; c=relaxed/simple;
	bh=nrAvltDYbzBkxbVa6V/3Tw3DlFmX7Tq89RALXk/upTU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=s5uR6ubpDdQ5dx3ZkxZabR6FiD2t6MwbUKB/Y3SN2FVdswHQVyP4mn8KAHHg2gWtMm/rNtVVyWEeD/XVfDKZPp81oYu5GVOtL4aKKCjFw4hnZtoelorgQGaLe9cU02TXmnQNRpBxZB5FHp169pJ00D83mrLyFB7Nu8+9SVhzti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZTtrDN2l; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29AA344475;
	Tue,  5 Aug 2025 19:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754420784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmMUXGQraACpFWQnGleevRjMeW7mTnPC6+SvsPYG2qI=;
	b=ZTtrDN2lK4L3thiSZP4Pki3bQZiRJBmlfVU9SyoiCjsX04tGD4lKcHe8XywEsqo6XuDVWJ
	2ZOyfyd2LervVkmXQnIAYv4tYQHy8dy7J+4eNn92HO3Ycj4oVjniSvG0tqLpzgKBXbXO5t
	9SQ9tji2iniOf+VQvh0CvKBRq9/hgJ8g1wUCDTgb/Dshr6ElvX43TAboKS95CqKjIlFm+F
	Sk2wqAtGke4OaUEos4wYh/lKdHmHTNHpLRbBMrMigq4DtV2QZak18qP2vZ00j28+b0M8j4
	Hg7VHz3dvu3xOma33+GmvgfDFdNz3BoNglsje0xe4oacJBEhgbObDVZ8W70ubA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Aug 2025 21:06:23 +0200
Message-Id: <DBUQ9HK08HSW.182155MPSBZJM@bootlin.com>
Subject: Re: [PATCH v3 2/3] tests: add some tests validating skipped
 functions due to uncertain arg location
Cc: <bpf@vger.kernel.org>, "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Alexei Starovoitov" <ast@fb.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, <ebpf@linuxfoundation.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com> <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com> <7201b814-aeb1-4f1d-b5f8-3178be1e29bd@oracle.com>
In-Reply-To: <7201b814-aeb1-4f1d-b5f8-3178be1e29bd@oracle.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduveelieduffeklefghfekveekvdelvdevheejkeekkeejtdeludejuddugfehffenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggtmhgvsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegrshhtsehfsgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepvggsphhfsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Alan,

On Tue Aug 5, 2025 at 5:09 PM CEST, Alan Maguire wrote:
> On 07/07/2025 15:02, Alexis Lothor=C3=A9 (eBPF Foundation) wrote:
>> Add a small binary representing specific cases likely absent from
>> standard vmlinux or kernel modules files. As a starter, the introduced
>> binary exposes a few functions consuming structs passed by value, some
>> passed by register, some passed on the stack:
>>=20
>>   int main(void);
>>   int test_bin_func_struct_on_stack_ko(int, void *, char, short int, int=
, \
>>     void *, char, short int, struct test_bin_struct_packed);
>>   int test_bin_func_struct_on_stack_ok(int, void *, char, short int, int=
, \
>>     void *, char, short int, struct test_bin_struct);
>>   int test_bin_func_struct_ok(int, void *, char, struct test_bin_struct)=
;
>>   int test_bin_func_ok(int, void *, char, short int);
>>=20
>> Then enrich btf_functions.sh to make it perform the following steps:
>> - build the binary
>> - generate BTF info and pfunct listing, both with dwarf and the
>>   generated BTF
>> - check that any function encoded in BTF is found in DWARF
>> - check that any function announced as skipped is indeed absent from BTF
>> - check that any skipped function has been skipped due to uncertain
>>   parameter location
>>=20
>> Example of the new test execution:
>>   Encoding...Matched 4 functions exactly.
>>   Ok
>>   Validation of skipped function logic...
>>   Skipped encoding 1 functions in BTF.
>>   Ok
>>   Validating skipped functions have uncertain parameter location...
>>   pahole: /home/alexis/src/pahole/tests/bin/test_bin: Invalid argument
>>   Found 1 legitimately skipped function due to uncertain loc
>>   Ok
>>=20
>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>
> Thanks for the updated changes+test. I think it'd be good to have this
> be less verbose in successful case. Currently I see:
>
>   1: Validation of BTF encoding of functions; this may take some time: Ok
> Validation of BTF encoding corner cases with test_bin functions; this
> may take some time: make: Entering directory
> '/home/almagui/src/github/dwarves/tests/bin'
> gcc test_bin.c -Wall -Wextra -Werror -g -o test_bin
> make: Leaving directory '/home/almagui/src/github/dwarves/tests/bin'
> No skipped functions.  Done.
>
> Ideally we just want the "Ok" for success in non-vebose mode. I'd
> propose making the following changes in order to support that; if these
> are okay by you there's no need to send another revision.

I'm perfeclty fine with the idea, thanks for handling it. Just a
comment/question below

> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
> index f97bdf5..a4ab67e 100755
> --- a/tests/btf_functions.sh
> +++ b/tests/btf_functions.sh
> @@ -110,7 +110,6 @@ skipped_cnt=3D$(wc -l ${outdir}/skipped_fns | awk '{
> print $1}')
>
>  if [[ "$skipped_cnt" =3D=3D "0" ]]; then
>         echo "No skipped functions.  Done."
> -       exit 0
>  fi

Shouldn't we get rid of this whole if block then, similarly to what you
have done with the other one below ?

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


