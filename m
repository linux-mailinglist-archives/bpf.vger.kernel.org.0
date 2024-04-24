Return-Path: <bpf+bounces-27757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B58B1655
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA280284E4A
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA3616E886;
	Wed, 24 Apr 2024 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d+EDqjrR"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF2316E86A
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998591; cv=none; b=pRhdORY8rWd2flhO2cZKtgXYvsd1m5oHXDYvl1Fi8D9StkdZdvfimH82FB4sY2E0pkrjmoyibMFXzi/ZWhkDoNXJS9lBrLMlJxlQr8UoExIomVsvpVcFWrloDcAJNpMLFDdR3meoIKpPzXNm2vTySPs582xPFW2avcaGOb12otA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998591; c=relaxed/simple;
	bh=M23gJzNUTmMvVNaqhzxa8gBavIGbqQgeIsGN9gbvjeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqbSHoW4CP6xcTZ+LysTchIPgOiLFfdakfvJAT2pBCQhMfpKvg27kAXJF1ATCSVQQdx099MDF7UFeFGO2+PZhH/gAUkHvqgQUylTIy8qR+uHdhm0yUux9MR30VEWGSY5ImWyodTaJY3GbXHEzZ3zThPQV2iwZqa/H63DSwfbb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d+EDqjrR; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <54ff0e5d-1089-4370-913a-d4fdf2fd8ad1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713998588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/InxbHrRpw2QBg/mB3CHlp5dXRfQxr9b0B/XEmYf3I=;
	b=d+EDqjrRvi1/ELoNF5vFetZGs3SWhHFzsNfrsZRpU5caAfxx6vYzLLjBdGXCr3TwHtG7+c
	7u4w/mG6NyQxqGKdGxNz7KJQPVTKn8pnhiz0+JQ0BfULWKQHVlPuSrpDholfPtSGellh9K
	ehVMURlLkpelxYvEpmJ074bpDsDC7PE=
Date: Wed, 24 Apr 2024 15:43:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 4/4] selftests: bpf: crypto: add benchmark
 for crypto functions
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org
References: <20240422225024.2847039-1-vadfed@meta.com>
 <20240422225024.2847039-5-vadfed@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240422225024.2847039-5-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/22/24 3:50 PM, Vadim Fedorenko wrote:
> diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c b/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
> new file mode 100644
> index 000000000000..0b8c1f2fe7e6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include <argp.h>
> +#include "bench.h"
> +#include "crypto_bench.skel.h"
> +
> +#define MAX_CIPHER_LEN 32
> +static char *input;

[ ... ]

> +static void *crypto_producer(void *input)

The bench result has all 0s in the output:

$> ./bench -p 4 crypto-decrypt
Setting up benchmark 'crypto-decrypt'...
Benchmark 'crypto-decrypt' started.
Iter   0 (209.082us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
Iter   1 (154.618us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
Iter   2 (-36.658us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s

This "void *input" arg shadowed the global variable.

> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		.repeat = 64,
> +		.data_in = input,
> +		.data_size_in = args.crypto_len,
> +	);
> +
> +	while (true)
> +		(void)bpf_prog_test_run_opts(ctx.pfd, &opts);
> +	return NULL;
> +}


