Return-Path: <bpf+bounces-16220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 974407FE685
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 03:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96621B210B6
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 02:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2411F9CE;
	Thu, 30 Nov 2023 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4971D1B3;
	Wed, 29 Nov 2023 18:12:10 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8WWp-0057on-4e; Thu, 30 Nov 2023 10:11:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Nov 2023 10:11:56 +0800
Date: Thu, 30 Nov 2023 10:11:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 2/3] bpf: crypto: add skcipher to bpf crypto
Message-ID: <ZWfvbHHXPMlddnGN@gondor.apana.org.au>
References: <20231129173312.31008-1-vadfed@meta.com>
 <20231129173312.31008-2-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129173312.31008-2-vadfed@meta.com>

On Wed, Nov 29, 2023 at 09:33:11AM -0800, Vadim Fedorenko wrote:
> Implement skcipher crypto in BPF crypto framework.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v6:
> - make skcipher implementation in separate patch
> ---
>  kernel/bpf/Makefile          |  3 ++
>  kernel/bpf/crypto_skcipher.c | 76 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 kernel/bpf/crypto_skcipher.c

I just made some adjustments to the lskcipher API so you may want
to hold off for a bit:

https://lore.kernel.org/linux-crypto/20231129210421.GD1174@sol.localdomain/T/#u

Basically it adds the ability to process more than one piece of
data for stream ciphers such as chacha.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

