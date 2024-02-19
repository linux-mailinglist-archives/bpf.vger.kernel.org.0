Return-Path: <bpf+bounces-22260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122EC85A729
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 16:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B486C284670
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213BD38389;
	Mon, 19 Feb 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmsOnAFN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39D38384;
	Mon, 19 Feb 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355725; cv=none; b=Avk2ZMX+Ahxj49vTtx+QxmOiWIdsB4uBJlug2mKzDfE8ad4oAqUHA6uTir1Z3zSmYjLiSDgz4Za9LQ2obKneMIAyZf0GIO0xg/QE5x5j0vvtAJGX39EBJuxdiHIAXvyqmFuHFlDzOZS1+Uwoh0t1rq0Td7QFWLc/J/bmRvMg/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355725; c=relaxed/simple;
	bh=aJvikAeIgXMvlPz4lvrIgTsZaCV2Z527m3bSofD38vE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kTccW26TkvConYW+wSZAj2bMmquzJjuRBH78fSXHnyFDYBtuTZfUCBnRHGU8vGprE7IQvUz9YN5g6qw4wU0U6fvgtJC+LNPNNyMUJrN8m+0Lr2Lp+5Ws5Ep893CHIEcUEAwEVLK2JCX4J6pBcwNFSkLj6TZwVWvunHlxqReDy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmsOnAFN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41265e39b8bso7574835e9.2;
        Mon, 19 Feb 2024 07:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708355722; x=1708960522; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUQoKtz44vOOVJo62FPP78n4Nrne/6aGsoTt/S82hxo=;
        b=ZmsOnAFNA+cxlZwxoSdCAFtFsslm8HpQQE6kZVmbCo5HGVDt4diJbInBNwW65DqHi1
         oiYI9SNvMC99yVoIp0VJ/AaB++Z9Blr9jDi6zE+OGvkB20YVvjB1GBbKapmQzivGhLqa
         PnD3pxE8nLcwQJQBZIuUMGlsAU64v7ElkiZnTTmzCMHGDhuiBpNNTX6pYnzcgL+cW5DI
         W/KEpZm42lQiWUFKhGar3etw7LhN1jjJbfFCI0hKmeFb9Usq/5o8Zj4jleIDN6MBAJj6
         ZvhwEZeY7M1OZELUH5Bl+3WXa++tStZX+yvcXqPb50/F+Agm4p5yf03W9Uk7QiPAUNux
         oPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708355722; x=1708960522;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUQoKtz44vOOVJo62FPP78n4Nrne/6aGsoTt/S82hxo=;
        b=J5gYjzPU0GYCpVYmuHrIZr8/9gB77aGHRjnC27Y46zMEwAIJDEAKg5ZJ9Uy0JNqd4s
         6/ZaQjG0shd1DhMg7JNwGBb5NZ4iHcWjakwPrIqIpxYQZayl2rCPIAtgIsiuib1H4sju
         +XrGIdF3EVtCQtB9ihxMQkk9tnjc+3zMAJpKtUx58skFpcsZHhnd7fa4gak87mV2OhJU
         M0mWm6B8f5G8MdJJBOpXexJB009A8ODKBNZ0eZZ79gGa4XpX33t1GNdzdW+M+J+uBnZq
         duKIDjFaZnwE2zDeCWgS3GBcdWVGf5PTq4zXnFqd0293Mzsj3OE8ZbDGaY8/+fpiP9Yj
         0Row==
X-Forwarded-Encrypted: i=1; AJvYcCVSYqjX8RFE049Y9gTFeXJNG3G/ywU2FKP4e3Vi9CbaQ19QcEuiXDCgLwQgqVjG6DNJGObj73I8R1Bf1BctXvnkDIKJ2AdrTeauaZNLUzAJokgZ/wIIiSpdNOAyR7jNuQHn
X-Gm-Message-State: AOJu0Yxxu887jHPnipkCpouttWhoKwuNF5bU7WTGbkfPkRlodA2g6ANQ
	zbVZU2uOq85SgvnAw5YKOQxjtGvX/5DgASbTv2A9E1JiX+d1S9f0
X-Google-Smtp-Source: AGHT+IFNc2bddpDmHF5WMNwyiQh2ePqca0WdGeTGxcJa8okEtUtxcrk9VhcgJd0YK5ODCJ7PA6yzxQ==
X-Received: by 2002:a05:600c:1f8d:b0:410:c5a9:a24a with SMTP id je13-20020a05600c1f8d00b00410c5a9a24amr9785269wmb.20.1708355722344;
        Mon, 19 Feb 2024 07:15:22 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c4f0500b0041253692606sm9913320wmq.17.2024.02.19.07.15.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Feb 2024 07:15:21 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 bpf@vger.kernel.org, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/2] arm64: patching: implement text_poke API
In-Reply-To: <79088869-a5ba-4335-b3ab-8a2a26d8be74@huaweicloud.com>
References: <20240125133159.85086-1-puranjay12@gmail.com>
 <20240125133159.85086-2-puranjay12@gmail.com>
 <79088869-a5ba-4335-b3ab-8a2a26d8be74@huaweicloud.com>
Date: Mon, 19 Feb 2024 15:15:20 +0000
Message-ID: <mb61p34topjsn.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> On 1/25/2024 9:31 PM, Puranjay Mohan wrote:
>> The text_poke API is used to implement functions like memcpy() and
>> memset() for instruction memory (RO+X). The implementation is similar to
>> the x86 version.
>> 
>> This will be used by the BPF JIT to write and modify BPF programs. There
>> could be more users of this in the future.
>> 
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>>   arch/arm64/include/asm/patching.h |  2 +
>>   arch/arm64/kernel/patching.c      | 80 +++++++++++++++++++++++++++++++
>>   2 files changed, 82 insertions(+)
>> 
>> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
>> index 68908b82b168..587bdb91ab7a 100644
>> --- a/arch/arm64/include/asm/patching.h
>> +++ b/arch/arm64/include/asm/patching.h
>> @@ -8,6 +8,8 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>>   int aarch64_insn_write(void *addr, u32 insn);
>>   
>>   int aarch64_insn_write_literal_u64(void *addr, u64 val);
>> +void *aarch64_insn_set(void *dst, u32 insn, size_t len);
>> +void *aarch64_insn_copy(void *dst, void *src, size_t len);
>>   
>>   int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>>   int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
>> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
>> index b4835f6d594b..5c2d34d890cf 100644
>> --- a/arch/arm64/kernel/patching.c
>> +++ b/arch/arm64/kernel/patching.c
>> @@ -105,6 +105,86 @@ noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
>>   	return ret;
>>   }
>>   
>> +typedef void text_poke_f(void *dst, void *src, size_t patched, size_t len);
>> +
>
> How about removing the argument 'patched' and passing 'src + patched' as the
> second argument?
>

The memcpy() function needs 'src + patched' but the memset() needs only the 'src' and
will ignore the 'patched'. To make these implementations generic, I pass
both src and patched separately and allow the implementation of
text_poke_f() to use them.

If you think there is a better way to implement this then I would love
to use that.

>> +static void *__text_poke(text_poke_f func, void *addr, void *src, size_t len)
>> +{
>> +	unsigned long flags;
>> +	size_t patched = 0;
>> +	size_t size;
>> +	void *waddr;
>> +	void *ptr;
>> +	int ret;
>> +
>> +	raw_spin_lock_irqsave(&patch_lock, flags);
>> +
>> +	while (patched < len) {
>> +		ptr = addr + patched;
>> +		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
>> +			     len - patched);
>> +
>> +		waddr = patch_map(ptr, FIX_TEXT_POKE0);
>> +		func(waddr, src, patched, size);
>> +		patch_unmap(FIX_TEXT_POKE0);
>> +
>> +		if (ret < 0) {
>
> Where is 'ret' assigned?
>

Will remove the error check in next version as func() is of type void
and this error check was left from the previous version.

Thanks,
Puranjay

