Return-Path: <bpf+bounces-16493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4A801A46
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 04:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BFE1F2113B
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 03:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA88C16;
	Sat,  2 Dec 2023 03:52:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD75E1B3;
	Fri,  1 Dec 2023 19:52:06 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r9H2m-006148-2O; Sat, 02 Dec 2023 11:51:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 02 Dec 2023 11:52:01 +0800
Date: Sat, 2 Dec 2023 11:52:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 2/3] bpf: crypto: add skcipher to bpf crypto
Message-ID: <ZWqp4VF+4rX/plpX@gondor.apana.org.au>
References: <20231202010604.1877561-1-vadfed@meta.com>
 <20231202010604.1877561-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202010604.1877561-2-vadfed@meta.com>

On Fri, Dec 01, 2023 at 05:06:03PM -0800, Vadim Fedorenko wrote:
>
> +static int bpf_crypto_lskcipher_encrypt(void *tfm, const u8 *src, u8 *dst,
> +					unsigned int len, u8 *iv)
> +{
> +	return crypto_lskcipher_encrypt(tfm, src, dst, len, iv);
> +}

Please note that the API has been updated and the iv field is now
the siv.  For algorithms with a non-zero statesize, that means that
the IV must be followed by enough memory to store the internal state,
i.e., crypto_lskcipher_statesize(tfm).

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

