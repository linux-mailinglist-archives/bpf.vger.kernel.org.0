Return-Path: <bpf+bounces-27217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA69B8AADC5
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 13:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B71B21DEC
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4423A83CD9;
	Fri, 19 Apr 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI9pphsJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66291F5F5;
	Fri, 19 Apr 2024 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713526305; cv=none; b=vFTZ0vW4a3pgnogwUXyXh03oZrtdYJBGDP3s1HI6y3jHmILl9swrujdy7h1xB0gqwa7QmPgfgCpqK6Jp1mByBB9slIRFEZlWCJna3VQoI+SpxjhK+sfEurDGrg5jv45zaD/ur48bjbNeX0W1AUDg7tKY9fRXl51ioYUBU3inJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713526305; c=relaxed/simple;
	bh=E8GQZ30IgEfs2553uTgpC3VI6FZP4BY+8jCXkE4DTL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlhG5j0SO9QbWg0AZTjN9zFvYCyGiq4n5Xsv0VDIC6iDyi3N1p0X66icob0c7YDrHh376dZrVuqafiCXUXr6Z0YceX8xvUM0R3vBvapQitaTcfHbzC0iG5YDMC6Yrf4Cwk9OAW6zkuCJ/8cdx76fpLQZ3oxsrj4xj59e9ZXv70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI9pphsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFB3C072AA;
	Fri, 19 Apr 2024 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713526303;
	bh=E8GQZ30IgEfs2553uTgpC3VI6FZP4BY+8jCXkE4DTL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dI9pphsJgUI3ZaPbzwPgArztc1emHtKBW27UPNklZXQCi320J7nX0+x2uz4/+ofxt
	 dzf2Ni1LmysBiKgK2MqM6uMf7IR7rsuGSoWGmTTDVhmiTGdOj1uhvVrHr7HA0Ye/2z
	 ynYo1ppTvPGL4nS+Ef2RzSpwwA3S8E1ZBcyc1Aemqhsej+YBOq/5+hZwCSssQo6IVP
	 Pixc3RFFZwID9PiElgBpHHgFXR66dbGh+EFsrf2rV8zVI3YsPkgYykemIZ3Yxbjk8O
	 Wu1v/PxnnNg8kFMa00eTq6MByd0pXKV2qMT8tgwQWMpbPqBfx+mY913LyMmojYMaoE
	 3ESGxZCvurS3g==
Date: Fri, 19 Apr 2024 12:31:38 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 4/4] selftests: bpf: crypto: add benchmark
 for crypto functions
Message-ID: <20240419113138.GV3975545@kernel.org>
References: <20240416204004.3942393-1-vadfed@meta.com>
 <20240416204004.3942393-5-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416204004.3942393-5-vadfed@meta.com>

On Tue, Apr 16, 2024 at 01:40:04PM -0700, Vadim Fedorenko wrote:
> Some simple benchmarks are added to understand the baseline of
> performance.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

...

> diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c b/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
> new file mode 100644
> index 000000000000..86048f02e6ac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_bpf_crypto.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include <argp.h>
> +#include "bench.h"
> +#include "crypto_bench.skel.h"
> +#include "../progs/crypto_share.h"
> +
> +#define MAX_CIPHER_LEN 32
> +static char *input;
> +static struct crypto_ctx {
> +	struct crypto_bench *skel;
> +	int pfd;
> +} ctx;
> +
> +static struct crypto_args {
> +	u32 crypto_len;
> +	char *crypto_cipher;
> +} args = {
> +	.crypto_len = 16,
> +	.crypto_cipher = "ecb(aes)",
> +};
> +
> +enum {
> +	ARG_CRYPTO_LEN = 5000,
> +	ARG_CRYPTO_CIPHER = 5001,
> +};
> +
> +static const struct argp_option opts[] = {
> +	{ "crypto-len", ARG_CRYPTO_LEN, "CRYPTO_LEN", 0,
> +	  "Set the length of crypto buffer" },
> +	{ "crypto-cipher", ARG_CRYPTO_CIPHER, "CRYPTO_CIPHER", 0,
> +	  "Set the cipher to use (defaul:ecb(aes))" },

nit: should this be 'default' ?

Flagged by checkpatch.pl --codespell

> +	{},
> +};

...

