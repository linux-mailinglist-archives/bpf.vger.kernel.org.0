Return-Path: <bpf+bounces-42640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D89A6B82
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B681C1F210BF
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08981F9422;
	Mon, 21 Oct 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="pdGRBy7X"
X-Original-To: bpf@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A01DF754;
	Mon, 21 Oct 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519505; cv=none; b=AHm20M+KxJ0088z/syDipwtANSs8tbX5zAUdVERMrWoO5u1SPyysZmmAc/X4CwZfd7gxhJsJNOrJ2QGxCy9SrTuhw6mOf9DpcO8sk1IVrOVSFfTyZH+uxScy+K/Z63jedzBBPoFYm91icdz0YDbQXlweD+3PgfVof9VfcdZNMDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519505; c=relaxed/simple;
	bh=C05g4q8NdYBCSJK1fcpzMahjm+yq9IbNNxfA3gK1GdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KcTGt9fNj06MLwiq9yG+GPoSY5LruHJfNIhmE2s6V37QNJAZ3b+TpVLwK5AjqjXE4LtXkmy9spXiq3WVB90rsxJvfHJbk7ALxMmtWJGjABw001aUruWn8Y9aSvUUAHYpBEoLJtLTbt3lKbFT79L9p9+XihtcVBGB+lPKzjXkukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=pdGRBy7X; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729519466; x=1730124266; i=deller@gmx.de;
	bh=KHEHhgl3vT2qa4XlTJ64Ck+WkTzRu0oSpPZLUl326jE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pdGRBy7XwsouqsLdYc7G5M1qa5UoGswFupmj2UQAxuH9EXyJcv/gkpHgXthvvrv+
	 2LelATXe8AQUx9w0qtwANm35+1wxOmLjclJ1RMhK/W4gI212eXYDYUgZWKwwG93wT
	 mLjaXJi3US4JsYwffySS/FrgSaE/X3uOmk9x7oi43dZlrIFmiDHA4xnjLK3mxwheC
	 uFSlCNvvtBsR9f30IuTsA3uzlZZC22aE27oK009fe5gd8Pz88UGH5nJOaKis+x0Xv
	 8Zz+dCpt31rR0fjgY6g0KRjXUgRWlkpLETnHg22ocjdHlIYtMQsEUTF1Bq9cZOMDK
	 dOix/CnkEr+jJ7tfQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lY1-1t2blp04OZ-004rkb; Mon, 21
 Oct 2024 16:04:26 +0200
Message-ID: <aef97e2b-f845-4b2e-bb35-cf89e4a7af6c@gmx.de>
Date: Mon, 21 Oct 2024 16:04:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: don't mask result of
 bpf_csum_diff() in test_verifier
To: Puranjay Mohan <puranjay@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eduard Zingerman <eddyz87@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 Martin KaFai Lau <martin.lau@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 netdev@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Abeni <pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song <yonghong.song@linux.dev>
References: <20241021122112.101513-1-puranjay@kernel.org>
 <20241021122112.101513-4-puranjay@kernel.org>
 <31b8ea3b-f765-43c0-9cee-49bc13064f04@gmx.de> <mb61p1q09d2eb.fsf@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <mb61p1q09d2eb.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uk4z+Tqi+SiUY+nEn2TK7BhJ0ZpV9jMDshA/W528bXZKEkkNaZ4
 JMf6Xd5p8sIfmm0L7rAKVRwVSVhtl7pa5iVTSrBl3GnC87Ntt6iq3mm6dfEIr2y6Xg4P88K
 xYEWaOPOOk1C9ckmm7/bKS/YRRCfbB7+0zs6RN229wxmZ0PoCLh+Dzn0kKkHvhMIxWtIDzY
 K5e9rOgqkCvYC5qThd6Tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wcd4v2NSwZw=;UtD5g5TLmzKEUxPdvj7ZFt7oKDD
 IGWXP+UcG1t6DSUGhW3EVgEYfaojtGkv77LssLRlsRuRBYPP4wlLq+Pd2ZLo/vy9h5pTkl8Ff
 Ivp3PnHsJJ/h/PqNWEWvAHToWOYeIqh0F5TWBNooPK4O8nOOweiMTrqubXfZ0Xl+eW0vwnXVN
 sBXsPUgiZ8ffSTTjek3vXQ1Yx7AaEDbZcqdXwzCbSaij4cB08EXsxC3SZhC94Kv6kFtr9pfif
 Fwy1oCgwuv6ptvD6ypc4tD1BduiXSWNXf0lyTZUyjn+bw3IQXLoambBXhbgjFGrSY5B1uvL+p
 0QTPfShfMrb42BBn6gk5hM/XyNUSD4klSYpa6sp7xRVQJ1l4ho3741Mpcl39CWVQn/zHDu6nx
 MWxcNZXlXaWloQY9qcnLatEC0lEeisq60RGZyJEpteN4TlmFktfyfER6EuHQZiXFFYuugHEOz
 JfLNDi15xWmN+qHfVmiXipV95hCY8xikSvJzDRny8enhOG5drVDhBsmzqK936we2kPp5IH7E4
 o4BQ9rkE4V+XK8ODIfrROaPDSbk078vFAIrTx0I8WbbzwOI2v+HRqujta3MJu5dLQjj4MC3MW
 18w7i/hhYtHXkp7LZxVj/a/eXLmPfAu7GouPWMLcQJ9//4MLRT9aAzhDiGB0yT43OVVJyqLhl
 AAdb872De7AD0mXWCaiFykeZeRRorT0AP65KRwECzAlOfuCKDJk5v+tVjZVIoFTZEUW0xpgZ/
 t25VbUyIr22rln/DPHMrfXuhNbK6sMY14p9sPS0Oze0w1w2+SZeUYGl+8s6AzrTws1d82uxP3
 CR+UQIiXd0roAPrshDWivJbg==

On 10/21/24 15:14, Puranjay Mohan wrote:
> Helge Deller <deller@gmx.de> writes:
>
>> On 10/21/24 14:21, Puranjay Mohan wrote:
>>> The bpf_csum_diff() helper has been fixed to return a 16-bit value for
>>> all archs, so now we don't need to mask the result.
>>>
>>> ...
>>> --- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
>>> +++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
>>> @@ -368,8 +368,7 @@ __naked void a_read_only_array_2_1(void)
>>>    	r4 =3D 0;						\
>>>    	r5 =3D 0;						\
>>>    	call %[bpf_csum_diff];				\
>>> -l0_%=3D:	r0 &=3D 0xffff;					\
>>> -	exit;						\
>>> +l0_%=3D:	exit;						\
>>
>> Instead of dropping the masking, would it make sense to
>> check here if (r0 >> 16) =3D=3D 0 ?
>
> We define the expected value in R0 to be 65507(0xffe3) in the line at th=
e top:
> __success __retval(65507)
>
> So, we should just not do anything to R0 and it should contain this valu=
e
> after returning from bpf_csum_diff()
>
> This masking hack was added in:
>
> 6185266c5a853 ("selftests/bpf: Mask bpf_csum_diff() return value to 16 b=
its in test_verifier")
>
> because without the fix in patch 2 bpf_csum_diff() would return the
> following for this test:
>
> x86                    :    -29 : 0xffffffe3
> generic (arm64, riscv) :  65507 : 0x0000ffe3

You're right.
Thanks for explaining.

Helge

