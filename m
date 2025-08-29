Return-Path: <bpf+bounces-66985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35376B3BE8A
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF678168E6B
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 14:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B633043A2;
	Fri, 29 Aug 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pESSpT9i"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A851C84DE
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479054; cv=none; b=RwtZPl6tdDWMHXQpr2r4Pv2gf8EuWX/NrBazzNjiebpZOLNx1xuky7DQ+JtRVsoFfRuKVB7cT5p05a9uAgiJ5AlMdAARpdRIW18QTz/Uayobpuo2XDI5YveaK1naBVNkHsPVkGeBWgv66tdIfKXyWGhMPVz6SKy+q+JzYSZPXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479054; c=relaxed/simple;
	bh=NhdDxBm2jhbyz4Wr1MCZ+yoIjfsszqbg/diAAd4I7Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqbyZ5ZTsAlPfRVY+IPwoFaSz4VB3vItzs59B92HZ/XYO+PXuvWFVgLS1C8527A5b1DXQr2TDS2wQRs81nUWjRTXHGJn08no8peN9nwN55u18LsrDtGkEgMSTHUkZZ6hAHzZ32oU6i2CFMRSGgfbsyZEOKn9B45i12L5esnONjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pESSpT9i; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c4e28d41-ee1f-4167-a07d-25c499c496ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756479050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uqvcg5AF+oMYAyXyW0K2szZHyJBgoGugPeAgMBnL5kc=;
	b=pESSpT9iRSBAoGTIL3BL2s/pNfkUNuDmEHDcNIf3XcJ1bY7eTSuxIg8OI5yDMGqd3Oy3b8
	j+tHQXsKKlUZ/RpZeH073Fk/3KQu1KQ+nv/FZ8alh57/EiPQwM5Kpnkhj1hSrtaTh587Gz
	49gjRhKzyrkFdtWuQatQnM09/GYiHz0=
Date: Fri, 29 Aug 2025 15:50:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Fix out-of-bounds dynptr write in
 bpf_crypto_crypt
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: andrii@kernel.org, bpf@vger.kernel.org,
 Stanislav Fort <disclosure@aisle.com>
References: <20250829143657.318524-1-daniel@iogearbox.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250829143657.318524-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/08/2025 15:36, Daniel Borkmann wrote:
> Stanislav reported that in bpf_crypto_crypt() the destination dynptr's
> size is not validated to be at least as large as the source dynptr's
> size before calling into the crypto backend with 'len = src_len'. This
> can result in an OOB write when the destination is smaller than the
> source.
> 
> Concretely, in mentioned function, psrc and pdst are both linear
> buffers fetched from each dynptr:
> 
>    psrc = __bpf_dynptr_data(src, src_len);
>    [...]
>    pdst = __bpf_dynptr_data_rw(dst, dst_len);
>    [...]
>    err = decrypt ?
>          ctx->type->decrypt(ctx->tfm, psrc, pdst, src_len, piv) :
>          ctx->type->encrypt(ctx->tfm, psrc, pdst, src_len, piv);
> 
> The crypto backend expects pdst to be large enough with a src_len length
> that can be written. Add an additional src_len > dst_len check and bail
> out if it's the case. Note that these kfuncs are accessible under root
> privileges only.
> 
> Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
> Reported-by: Stanislav Fort <disclosure@aisle.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>   kernel/bpf/crypto.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> index 94854cd9c4cc..83c4d9943084 100644
> --- a/kernel/bpf/crypto.c
> +++ b/kernel/bpf/crypto.c
> @@ -278,7 +278,7 @@ static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
>   	siv_len = siv ? __bpf_dynptr_size(siv) : 0;
>   	src_len = __bpf_dynptr_size(src);
>   	dst_len = __bpf_dynptr_size(dst);
> -	if (!src_len || !dst_len)
> +	if (!src_len || !dst_len || src_len > dst_len)

I think it would make sense to have less restrictive check. I mean it's
ok to have dst_len equal to src_len.

>   		return -EINVAL;
>   
>   	if (siv_len != ctx->siv_len)


