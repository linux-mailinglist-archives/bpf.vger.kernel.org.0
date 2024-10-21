Return-Path: <bpf+bounces-42618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3139A69D1
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFDB1C21C3F
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA2C1F708D;
	Mon, 21 Oct 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF5QUNjW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB81E906C;
	Mon, 21 Oct 2024 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516465; cv=none; b=HgazJ/u07m5m09wmPnrV9duYqsBtCp7JXRDfGtKlBN4sMpu3mibx69Zlil1fxkSp+7+S7PzRyWG3Ogkd+V6PyRbBuqSL0s6pvJhbjwqkHfAzISSmaK6TvwQfHu1GXVOWgGPy4fvtwUezvsjk4fQI57r1Apw7osg++dXanrfdGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516465; c=relaxed/simple;
	bh=OPT5AbxfJYRmwQf7O59ti/U6BN1gWoe3PBxjcsD4Oy8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YX+qF1u9jGoOo7XR8yGiaM9Kq3g6u452q5H2fe3LbKkBdGOrDbcTRR5gAzJe6wbydM2TJhrgANlk18BEwR4NtbNGnA4OEV4OwZP3vPqo4t58mZG9zYiv1XKQz4OFubKws8b/WPDSLcfllviI0CZVs29fjYczs8usc9INJSC+C5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF5QUNjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79886C4CEC3;
	Mon, 21 Oct 2024 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729516464;
	bh=OPT5AbxfJYRmwQf7O59ti/U6BN1gWoe3PBxjcsD4Oy8=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=mF5QUNjWAyemP13yIZEigUjZDcIaiI5NUuT9BJZruFdXivO7jvXVXWO7agFbF6RFJ
	 rQQK7CtjCfUwj38GJUU+V900DEyszmzR1UgexjDtiaEOKWjTi2U2BjkBSd8PQ6mB23
	 wrQzlhhV4c6+VcF2JDS0nrAEN6ZuLcHwTE3lKJRof57QqDUK4Z7AVvPfeTsNQBP723
	 ZDFTSeF0uPpwYy1rU4HGJUkV8pimDA2THaRbHtKLZTEo9bNiv+7NM14s+gKA6o/vdQ
	 p0qGd2jAO4y6Hbs7ST9aewCMth3kCSXlnH9ZDEsmcLFBh31VadoyqtvFdgI8XRRxLa
	 0CZfZfoHFY5lQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Helge Deller <deller@gmx.de>, Albert Ou <aou@eecs.berkeley.edu>, Alexei
 Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Eduard
 Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, Hao Luo
 <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, Martin
 KaFai Lau <martin.lau@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 netdev@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Paolo Abeni
 <pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan
 <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: don't mask result of
 bpf_csum_diff() in test_verifier
In-Reply-To: <31b8ea3b-f765-43c0-9cee-49bc13064f04@gmx.de>
References: <20241021122112.101513-1-puranjay@kernel.org>
 <20241021122112.101513-4-puranjay@kernel.org>
 <31b8ea3b-f765-43c0-9cee-49bc13064f04@gmx.de>
Date: Mon, 21 Oct 2024 13:14:04 +0000
Message-ID: <mb61p1q09d2eb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Helge Deller <deller@gmx.de> writes:

> On 10/21/24 14:21, Puranjay Mohan wrote:
>> The bpf_csum_diff() helper has been fixed to return a 16-bit value for
>> all archs, so now we don't need to mask the result.
>>
>> ...
>> --- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
>> @@ -368,8 +368,7 @@ __naked void a_read_only_array_2_1(void)
>>   	r4 = 0;						\
>>   	r5 = 0;						\
>>   	call %[bpf_csum_diff];				\
>> -l0_%=:	r0 &= 0xffff;					\
>> -	exit;						\
>> +l0_%=:	exit;						\
>
> Instead of dropping the masking, would it make sense to
> check here if (r0 >> 16) == 0 ?

We define the expected value in R0 to be 65507(0xffe3) in the line at the top:
__success __retval(65507)

So, we should just not do anything to R0 and it should contain this value
after returning from bpf_csum_diff()

This masking hack was added in:

6185266c5a853 ("selftests/bpf: Mask bpf_csum_diff() return value to 16 bits in test_verifier")

because without the fix in patch 2 bpf_csum_diff() would return the
following for this test:

x86                    :    -29 : 0xffffffe3
generic (arm64, riscv) :  65507 : 0x0000ffe3


Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZxZTnRQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2ndk3AP0XXZde0lRtwFVwJrCkF/VkxqH1qoIW
YzgfJHIpSZzNAAEA0eN6ggg1/3zV3pUq6bqFbBaa+ah8TtqqUbVVefg8aAI=
=vDn9
-----END PGP SIGNATURE-----
--=-=-=--

