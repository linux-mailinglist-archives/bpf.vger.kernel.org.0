Return-Path: <bpf+bounces-51739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4A6A38576
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 15:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5B71745A1
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB3E21D587;
	Mon, 17 Feb 2025 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kaTR/S/j"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F9A21CC7B
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801027; cv=none; b=Pi8CvjIpLtgVHLuBh64xwbu8ou18ZJhbOa7285qLeaEr0eT9weFoswFPEwUMLUSxXEnE3rY19jCYOoGx4ptxPjPKMYRTUwjKzdqDbgie5N2CoTQvvz7Le2D/v6Km39Og0sBKqd84aibjjTPrxLR3w6DQ1V6ALW0B6umKlJcD21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801027; c=relaxed/simple;
	bh=7oZ9P/mSayH2YvOgoPsdAp7K+sHh9HuAmb2ZJbdyC4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAzNGl1R3I2Tv6G3NO/nsz+jgW/muAmXB/wW/n5j0tyZeimV9EMMq018qSD+wuFI4eME7lzhQDR6jHYzTeZkOSEC8Klx9AJM9nKYyvErtrqAAXXEemA6FjGZxr+GdZgBle0Nal9GXpMh7p4MLT8G0q0eggBoskBciFikDZqFAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kaTR/S/j; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <43fa75f9-e6e3-4d80-b3b0-a97387fb2a07@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739801012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYrIjHN3bDUdNdxr8x/b61vyO4g+se/BxMY16UM3TFI=;
	b=kaTR/S/j0cJ+sB3YHCx8KUwbtoYaG9GYB52hz4/cZW96pvX+ubr/u2tcTD2ZMdB1jgS/MP
	3vB22SV1q6/GSpluKacXG+pWtuOc4i4n5WudY4ryAzoGWrETvs0ZkZxRJR+p6pNv7hG718
	W8MivihF0RxYH0FXmXx2jbdEmzMM53E=
Date: Mon, 17 Feb 2025 14:03:27 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] crypto: bpf - Add MODULE_DESCRIPTION for skcipher
To: Arnd Bergmann <arnd@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, bpf@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217125601.3408746-1-arnd@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250217125601.3408746-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/02/2025 12:55, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All modules should have a description, building with extra warnings
> enabled prints this outfor the for bpf_crypto_skcipher module:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/bpf_crypto_skcipher.o
> 
> Add a description line.
> 
> Fixes: fda4f71282b2 ("bpf: crypto: add skcipher to bpf crypto")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   crypto/bpf_crypto_skcipher.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/crypto/bpf_crypto_skcipher.c b/crypto/bpf_crypto_skcipher.c
> index b5e657415770..a88798d3e8c8 100644
> --- a/crypto/bpf_crypto_skcipher.c
> +++ b/crypto/bpf_crypto_skcipher.c
> @@ -80,3 +80,4 @@ static void __exit bpf_crypto_skcipher_exit(void)
>   module_init(bpf_crypto_skcipher_init);
>   module_exit(bpf_crypto_skcipher_exit);
>   MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Symmetric key cipher support for BPF");

Thanks for fixing!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

