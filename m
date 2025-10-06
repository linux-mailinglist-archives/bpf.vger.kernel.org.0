Return-Path: <bpf+bounces-70423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE2EBBE99D
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 18:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80388189A203
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D32D7814;
	Mon,  6 Oct 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="osT01Nj2"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CAC35898
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767183; cv=none; b=hEuAG4ozqCLo8WvV+DygTryfHvb7qbYl9bQR84lbJnPUCYebyF2a4gBzXcw9AM4ummeAUea8lP846fxVPfVKG30GW/AKzTnnsoxVmtyujAtpIsFcRnkXVOomMMRUQ8U16Wu/ymVzjyr6Q/wzsaKxTfurnX162D4Q80I8iB7WeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767183; c=relaxed/simple;
	bh=kX9VBylIGJpYvBDnUiL+Fb+kqCZLulhM1IJDRxYyvRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9p3m+m2bwx4pKges2hbX2p4b8jD0CtysUArlRPvR1o5nIewJGlu35lQlLzlmmRqA7fBqkzhBkQ6BNOZCs8oekyqiBjTwqZz2vgttXENzmGOtLxLlzjX67BzqcyJpQ3z3NlBtBju6kx8ZeH3Cpoy26rsk0foCakIee4GUlWmxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=osT01Nj2; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fc03414f-7b9d-4222-a66f-67be4ea32fb7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759767176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GY1ZUttONL8aCVQ5ugUyMacQT5GaTfK2RGsIj1Yv9U=;
	b=osT01Nj2lCm7c4mcUuGHfAHmCl5ZYtZLlyqex9If5Jvxz7fl9M/KlyvFb4y0nvSnp9LfVE
	NMwhvJcHx6q+4+29NdC7j9QVMJJkokVGW4/UBYLoRmYUwfHUAs60oLzetIVyCrij1y2ZD0
	xYxD6Zue1JfD0MPEdUpjmEsiLcI3YWk=
Date: Mon, 6 Oct 2025 09:12:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] libbpf: Fix undefined behavior in
 {get,put}_unaligned_be32()
To: Eric Biggers <ebiggers@kernel.org>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Tony Ambardar <tony.ambardar@gmail.com>
References: <20251006012037.159295-1-ebiggers@kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251006012037.159295-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/5/25 6:20 PM, Eric Biggers wrote:
> These violate aliasing rules and may be miscompiled unless
> -fno-strict-aliasing is used.  Replace them with the standard memcpy()
> solution.  Note that compilers know how to optimize this properly.

For clang, -fstrict-aliasing is on by default. For gcc, -fstrict-aliasing
is on by default for >= O2. So indeed, with macro based implementation below,
it is *possible* that the compiler may explore strict-aliasing rule and may
generate incorrect code.

>
> Fixes: 4a1c9e544b8d ("libbpf: remove linux/unaligned.h dependency for libbpf_sha256()")
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Ack with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/lib/bpf/libbpf_utils.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.c
> index 5d66bc6ff0982..ac3beae54cf67 100644
> --- a/tools/lib/bpf/libbpf_utils.c
> +++ b/tools/lib/bpf/libbpf_utils.c
> @@ -146,20 +146,24 @@ const char *libbpf_errstr(int err)
>   		snprintf(buf, sizeof(buf), "%d", err);
>   		return buf;
>   	}
>   }
>   
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wpacked"
> -#pragma GCC diagnostic ignored "-Wattributes"
> -struct __packed_u32 { __u32 __val; } __attribute__((packed));
> -#pragma GCC diagnostic pop
> -
> -#define get_unaligned_be32(p) be32_to_cpu((((struct __packed_u32 *)(p))->__val))
> -#define put_unaligned_be32(v, p) do {							\
> -	((struct __packed_u32 *)(p))->__val = cpu_to_be32(v);				\
> -} while (0)
> +static inline __u32 get_unaligned_be32(const void *p)
> +{
> +	__be32 val;

To be consistent with put_unaligned_be32(), rename the above 'val'
to 'be_val'?

> +
> +	memcpy(&val, p, sizeof(val));
> +	return be32_to_cpu(val);
> +}
> +
> +static inline void put_unaligned_be32(__u32 val, void *p)
> +{
> +	__be32 be_val = cpu_to_be32(val);
> +
> +	memcpy(p, &be_val, sizeof(be_val));
> +}
>   
>   #define SHA256_BLOCK_LENGTH 64
>   #define Ch(x, y, z) (((x) & (y)) ^ (~(x) & (z)))
>   #define Maj(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
>   #define Sigma_0(x) (ror32((x), 2) ^ ror32((x), 13) ^ ror32((x), 22))
>
> base-commit: de7342228b7343774d6a9981c2ddbfb5e201044b


