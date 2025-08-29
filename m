Return-Path: <bpf+bounces-66989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B7B3BF38
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936F61CC088D
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0E91DFD8F;
	Fri, 29 Aug 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OsYAVv03"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8ED2FB
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481459; cv=none; b=VvUNjOrzKmb9COTOllZhjOakDQONB8J6l/FJpHVeT9pudlXnGBBwGveMnAm5hGGMVXMZQEx6udXdJf2RiAWlNY5VFWfdeZroJQtrJy3pltkFmzBpZl1dr/5QqdQltHy+CkHbZhvv0Vjf4xLA1RUk4Dyv0RnLePJ1m90uZFmDTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481459; c=relaxed/simple;
	bh=ApyvdeZ+X8Xd5EGl+Oar3X/qVDo21181z67eYctwsfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbD+aJo2gWeXbMvug01d9B98tm+0daKymPredQ/JvZVdsIvaMOkh/Mp1MT5ZBOfnIYgIiAsHtKDL0SjEuV6AsrRzKXZaKX/w1zU8bfikTh8Q+mohifaXZgBkMZ9RD1IrQ7TM/h5PM1NrIQZGDeS5etvDuIHXHYdFaPXOAqL6VNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OsYAVv03; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7nQhvyX2JxeUzePgwaRGKCet+EO24WKCR9e8WcN3thU=; b=OsYAVv03492CZRBbd7I7JGEtkg
	gsXNsX4DdeCZYtmkUaxFIcLElKwl+OVdSYOxVBAxR6k/tp/a39FjL66cBFiRQrT1Zswcz06ZYvRDe
	8/enQ+LokHEszpgOfxJDuJHsy64LyntKe0Z/xNSwSU75OcjP4Ge1LHuWSSYW1U1HAWLF4qkKJKD19
	2/d44kxC69RREq7ww31T1Io2d8km5TSJ4wyO8r/CF0AQhin0CYXeh+vtvg1/epZ3XnQJRTIIjCU0J
	HktoTLyWRplkBAoiEP+jnrrujiQpY3GUoUHi55TvNzupC3PSO2GM+7p1TsdqBW/nyPAJvUpUSI9tY
	SxbeqUqQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1us143-000JSl-0r;
	Fri, 29 Aug 2025 17:30:55 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1us143-0006SZ-0m;
	Fri, 29 Aug 2025 17:30:54 +0200
Message-ID: <cacb4948-fb97-4bb4-8147-f38245ec3826@iogearbox.net>
Date: Fri, 29 Aug 2025 17:30:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: Fix out-of-bounds dynptr write in
 bpf_crypto_crypt
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, ast@kernel.org
Cc: andrii@kernel.org, bpf@vger.kernel.org,
 Stanislav Fort <disclosure@aisle.com>
References: <20250829143657.318524-1-daniel@iogearbox.net>
 <c4e28d41-ee1f-4167-a07d-25c499c496ea@linux.dev>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <c4e28d41-ee1f-4167-a07d-25c499c496ea@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27747/Fri Aug 29 10:27:03 2025)

On 8/29/25 4:50 PM, Vadim Fedorenko wrote:
> On 29/08/2025 15:36, Daniel Borkmann wrote:
>> Stanislav reported that in bpf_crypto_crypt() the destination dynptr's
>> size is not validated to be at least as large as the source dynptr's
>> size before calling into the crypto backend with 'len = src_len'. This
>> can result in an OOB write when the destination is smaller than the
>> source.
>>
>> Concretely, in mentioned function, psrc and pdst are both linear
>> buffers fetched from each dynptr:
>>
>>    psrc = __bpf_dynptr_data(src, src_len);
>>    [...]
>>    pdst = __bpf_dynptr_data_rw(dst, dst_len);
>>    [...]
>>    err = decrypt ?
>>          ctx->type->decrypt(ctx->tfm, psrc, pdst, src_len, piv) :
>>          ctx->type->encrypt(ctx->tfm, psrc, pdst, src_len, piv);
>>
>> The crypto backend expects pdst to be large enough with a src_len length
>> that can be written. Add an additional src_len > dst_len check and bail
>> out if it's the case. Note that these kfuncs are accessible under root
>> privileges only.
>>
>> Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
>> Reported-by: Stanislav Fort <disclosure@aisle.com>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   kernel/bpf/crypto.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
>> index 94854cd9c4cc..83c4d9943084 100644
>> --- a/kernel/bpf/crypto.c
>> +++ b/kernel/bpf/crypto.c
>> @@ -278,7 +278,7 @@ static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
>>       siv_len = siv ? __bpf_dynptr_size(siv) : 0;
>>       src_len = __bpf_dynptr_size(src);
>>       dst_len = __bpf_dynptr_size(dst);
>> -    if (!src_len || !dst_len)
>> +    if (!src_len || !dst_len || src_len > dst_len)
> 
> I think it would make sense to have less restrictive check. I mean it's
> ok to have dst_len equal to src_len.

That scenario is/remains allowed and is also what the 'good' case is testing in
the BPF selftests (src_len 16 vs dst_len 16).

Thanks,
Daniel

