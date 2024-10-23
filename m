Return-Path: <bpf+bounces-42907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E27F9ACEF7
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F42D285C54
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB491C4606;
	Wed, 23 Oct 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ima94U6J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ADF1BFE0D;
	Wed, 23 Oct 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697850; cv=none; b=M86eTUBuCw8pdPrqiFZDT9QUv/wkXJSOXXotKrbYEnQLIm9UxYHXskRL+n0SbaOS6g1DteltHnHY2DqKFTxMiC/CgbjVQStUd6qXH5CEKl43UIP9IDr+qb+IIaYFo8uuIiDqtcZynt8r2iv0qADhLjGujqjeUZgH/wuhE6c+9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697850; c=relaxed/simple;
	bh=fS3eJ8P+ux9S0OqEOhIia1lXSwXNpwLliBMdv3pspAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kma7qhCNatFIFzEwltcKrJQHNFCfZTjbKXi/89Z2Xgs4IxRTGSiKTyEh+LJ5DGarAVZHNUdyzDI1CatACc4a7fjQbs2wdZVFi+EgGACoj4fkF/Ub2DVYP+PnmxYcxqm+02QjhaU88rQ2IKg3Ymc9eaUmhGlhRaSGg7IjQ1U+atE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ima94U6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994C9C4CEC6;
	Wed, 23 Oct 2024 15:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729697850;
	bh=fS3eJ8P+ux9S0OqEOhIia1lXSwXNpwLliBMdv3pspAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ima94U6JgLfMy6s+cI3f0gVuBeruARRjleGmf80bjUWfJlQ1ythLCxLloTRSwob5D
	 aJhF4xCCVD1f92vdHfdtnqeSg3n+JvahF2Y4OWP37JTDwMk0mRp3tW9YkmKCZIozcH
	 47ZOYU2xTqPI4VoY3aepCTe3TDZ/qKosjWwViJyxYqscWHUbiyAQNltp5CG9O0S0wz
	 jMkcJWDR+XMOQegavNF9+HP7hUbCx/cp7hbh7TV2rge8nY4eyFBCfQyzo6NLhBPmgg
	 XhTnNxs27VlEMgvU0ynXSbZXi3QvR4CiH1IlIhAa1mJSwE36n7XcazpUSKuANf2Sv4
	 x8yldypMS3AJA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko
 <andrii@kernel.org>, bpf@vger.kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, Hao Luo
 <haoluo@google.com>, Helge Deller <deller@gmx.de>, Jakub Kicinski
 <kuba@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, netdev@vger.kernel.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Song Liu
 <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add benchmark for
 bpf_csum_diff() helper
In-Reply-To: <mb61p8qugc955.fsf@kernel.org>
References: <20241021122112.101513-1-puranjay@kernel.org>
 <20241021122112.101513-5-puranjay@kernel.org>
 <CAEf4BzY1LgCF1VOoAQkMdDTx87C0mfyftMvhvVU4GpsFc6fw5g@mail.gmail.com>
 <mb61pa5ewbfpk.fsf@kernel.org>
 <CAEf4BzZ-gfBqez-QJCSRVOPnvz-inaiVdNGOFRCdc2KQbnmeZQ@mail.gmail.com>
 <mb61p8qugc955.fsf@kernel.org>
Date: Wed, 23 Oct 2024 15:37:07 +0000
Message-ID: <mb61pttd2bzks.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay@kernel.org> writes:

> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
>> On Tue, Oct 22, 2024 at 3:21=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
>>>
>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>>
>>> > On Mon, Oct 21, 2024 at 5:22=E2=80=AFAM Puranjay Mohan <puranjay@kern=
el.org> wrote:
>>> >>
>>> >> Add a microbenchmark for bpf_csum_diff() helper. This benchmark work=
s by
>>> >> filling a 4KB buffer with random data and calculating the internet
>>> >> checksum on different parts of this buffer using bpf_csum_diff().
>>> >>
>>> >> Example run using ./benchs/run_bench_csum_diff.sh on x86_64:
>>> >>
>>> >> [bpf]$ ./benchs/run_bench_csum_diff.sh
>>> >> 4                    2.296 =C2=B1 0.066M/s (drops 0.000 =C2=B1 0.000=
M/s)
>>> >> 8                    2.320 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000=
M/s)
>>> >> 16                   2.315 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000=
M/s)
>>> >> 20                   2.318 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000=
M/s)
>>> >> 32                   2.308 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000=
M/s)
>>> >> 40                   2.300 =C2=B1 0.029M/s (drops 0.000 =C2=B1 0.000=
M/s)
>>> >> 64                   2.286 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000=
M/s)
>>> >> 128                  2.250 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000=
M/s)
>>> >> 256                  2.173 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000=
M/s)
>>> >> 512                  2.023 =C2=B1 0.055M/s (drops 0.000 =C2=B1 0.000=
M/s)
>>> >
>>> > you are not benchmarking bpf_csum_diff(), you are benchmarking how
>>> > often you can call bpf_prog_test_run(). Add some batching on the BPF
>>> > side, these numbers tell you that there is no difference between
>>> > calculating checksum for 4 bytes and for 512, that didn't seem strange
>>> > to you?
>>>
>>> This didn't seem strange to me because if you see the tables I added to
>>> the cover letter, there is a clear improvement after optimizing the
>>> helper and arm64 even shows a linear drop going from 4 bytes to 512
>>> bytes, even after the optimization.
>>>
>>
>> Regardless of optimization, it's strange that throughput barely
>> differs when you vary the amount of work by more than 100x. This
>> wouldn't be strange if this checksum calculation was some sort of
>> cryptographic hash, where it's intentional to have the same timing
>> regardless of amount of work, or something along those lines. But I
>> don't think that's the case here.
>>
>> But as it is right now, this benchmark is benchmarking
>> bpf_prog_test_run(), as I mentioned, which seems to be bottlenecking
>> at about 2mln/s throughput for your machine. bpf_csum_diff()'s
>> overhead is trivial compared to bpf_prog_test_run() overhead and
>> syscall/context switch overhead.
>>
>> We shouldn't add the benchmark that doesn't benchmark the right thing.
>> So just add a bpf_for(i, 0, 100) loop doing bpf_csum_diff(), and then
>> do atomic increment *after* the loop (to minimize atomics overhead).
>
> Thanks, now I undestand what you meant. Will add the bpf_for() in the
> next version.

I have decided to drop this patch as even after adding bpf_for() the
difference between 4B and 512B is not that much. So, benchmarking
bpf_csum_diff() using this triggering based framework is not useful.

So, v2 will not have this patch but the cover letter will still have the
tables to show the difference before/after the optimization.

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZxkYJBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nZcNAP9LuNyLHGuE8urrunhTq/wpaMGlCwOS
BXyQadJTABXgvgEAvD4mhW6uC3odQDgdGxBrVV/Q1eBzFf4WxzCGVME9lAw=
=u12U
-----END PGP SIGNATURE-----
--=-=-=--

