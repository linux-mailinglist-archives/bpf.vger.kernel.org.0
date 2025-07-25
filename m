Return-Path: <bpf+bounces-64420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0B3B1277B
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 01:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B577BBBB7
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 23:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041A125F97E;
	Fri, 25 Jul 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YKGHnROh"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810E2580CB
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753486194; cv=none; b=D4Pz0Rgny8TH+frHsVgJAugOaSaY25x1/BgPDRvadPA1radwcAimvwO4NlQpEgi0i8Ad6VHEgNM4Xo7J4hvJOlM7YSj0H43YMMkk5rxBrXBQrHgmldOWRNZkozlFlL0L8Zg1Ekzk5C+9hepiH087xZe9+3ZysN4373xFXPi5IGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753486194; c=relaxed/simple;
	bh=MSnwXae7PvSbdrSd8BTyH5IoGtxlk9BOVOOLem9FNMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7laNJUxmdlf22Aa3lDymcYOyJiOIqMtesyXqJ5l5qvlVTQVKSoc7XDkA/4LfXmO2MRyQQuOTBFyrQPhCf3J7HhZsJndY9Dgx94vRlKPfPkXTP3aP0jJwdVkKNr8Fh1K6ofbnhNCzc0dsywVRBP/zIx1gYm3NvYGx1rI3gN64x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YKGHnROh; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c145192-122d-46fc-8567-be30a2694a4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753486190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrSfoK72C3hoJ9bWqoMm3Qmta43jY20IJhfJ91SpOy0=;
	b=YKGHnROhJXM86ZOpGmyIAyZiGzspZIM5zUM+I+sTR5lPnZbp7la55+/u0FMr3QSyKn1utJ
	aC9mGjG2zOnrzilM7Tav6n70YBofLUFwfUMKJfYZLorHiVL7LDzTNVWVYrui5dF7mIJdCd
	2rFE2U50h42tv8qZk/3PGXnR3RWrNiQ=
Date: Fri, 25 Jul 2025 16:29:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Fix test
 dynptr/test_dynptr_memset_xdp_chunks failure
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20250725043425.208128-1-yonghong.song@linux.dev>
 <20250725043440.209266-1-yonghong.song@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250725043440.209266-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/24/25 9:34 PM, Yonghong Song wrote:
> For arm64 64K page size, the xdp data size was set to be more than 64K
> in one of previous patches. This will cause failure for bpf_dynptr_memset().
> Since the failure of bpf_dynptr_memset() is expected with 64K page size,
> return success.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   tools/testing/selftests/bpf/progs/dynptr_success.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
> index 3094a1e4ee91..8315273cb900 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -9,6 +9,8 @@
>   #include "bpf_misc.h"
>   #include "errno.h"
>   
> +#define PAGE_SIZE_64K 65536
> +
>   char _license[] SEC("license") = "GPL";
>   
>   int pid, err, val;
> @@ -821,8 +823,17 @@ int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
>   	data_sz = bpf_dynptr_size(&ptr_xdp);
>   
>   	err = bpf_dynptr_memset(&ptr_xdp, 0, data_sz, DYNPTR_MEMSET_VAL);
> -	if (err)
> +	if (err) {
> +		/* bpf_dynptr_memset() eventually called bpf_xdp_pointer()

I don't think I understand why the test fixed in patch 1 (e.g. 
test_probe_read_user_dynptr) can pass the bpf_xdp_pointer test on 0xffff. I 
thought the bpf_probe_read_user_str_dynptr will eventually call the 
__bpf_xdp_store_bytes which also does a bpf_xdp_pointer?

> +		 * where if data_sz is greater than 0xffff, -EFAULT will be
> +		 * returned. For 64K page size, data_sz is greater than
> +		 * 64K, so error is expected and let us zero out error and
> +		 * return success.
> +		 */
> +		if (data_sz >= PAGE_SIZE_64K)
> +			err = 0;
>   		goto out;
> +	}
>   
>   	bpf_for(i, 0, max_chunks) {
>   		offset = i * sizeof(buf);


