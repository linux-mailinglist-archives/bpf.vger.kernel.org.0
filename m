Return-Path: <bpf+bounces-15219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B027EEB85
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 04:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264FE1F23F4B
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 03:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAF5C8C4;
	Fri, 17 Nov 2023 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC41126;
	Thu, 16 Nov 2023 19:59:45 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r3q0q-000WhG-3F; Fri, 17 Nov 2023 11:59:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 11:59:31 +0800
Date: Fri, 17 Nov 2023 11:59:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, kuba@kernel.org, martin.lau@linux.dev,
	andrii@kernel.org, ast@kernel.org, mykolal@fb.com, vadfed@meta.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add skcipher API support to TC/XDP
 programs
Message-ID: <ZVblI/mbqFsdVI00@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110203500.2787316-1-vadfed@meta.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.netdev

Vadim Fedorenko <vadfed@meta.com> wrote:
> Add crypto API support to BPF to be able to decrypt or encrypt packets
> in TC/XDP BPF programs. Only symmetric key ciphers are supported for
> now. Special care should be taken for initialization part of crypto algo
> because crypto_alloc_sync_skcipher() doesn't work with preemtion
> disabled, it can be run only in sleepable BPF program. Also async crypto
> is not supported because of the very same issue - TC/XDP BPF programs
> are not sleepable.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

Please use the newly introduced lskcipher interface instead of
skcipher.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

