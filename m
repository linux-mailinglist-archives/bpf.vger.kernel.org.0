Return-Path: <bpf+bounces-79302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E34D33613
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A501630638A1
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A233B6E1;
	Fri, 16 Jan 2026 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ert6xMu2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s7LVFbnh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548333B95A
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579396; cv=none; b=ZB9b7x4yrjvXLLl7Cg6ucwb2esFRBf402BYIhq9bE7MB7i1F6Y7BfcTCruLiZehwKuEaKAz4xQW+e6EC+RRIFgw/GmhKCXvZGfj1y+vGoGas0KtACQhyGmWsxhoZ1i/inExr4UDZwF+DnbxL3BumXRhXWKEFeQOpCiAC/NKvC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579396; c=relaxed/simple;
	bh=FRl9Kpcfch1+ySdZYwv/SC+ulCXNtnzcVofSmKCtGQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyNsxz725n4U+EiSJ75KidKEwC6Kmr5DZL8VuWCRE63iBSq5dgcNd2vO87zTEdkdWgZAXyZ+gF4O7hCUCfDm0B2doTysqo2mB320tUJ/yr3aDqECPeZhG3UnnuGTfi5nwa8eqD/u7dgNpOLL41WmJ8MkgHEeNEUUJxeregwtfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ert6xMu2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s7LVFbnh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768579394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjFX/bykGBBHThUhcm6tfBPaAUsB3yRUC8oPazeSzBM=;
	b=Ert6xMu2/a4FzxCjEbB+SqCPDA0lQmdiYKTjlzuaBYSbhvuDgQYjixcJtMzv/Ri/XUG+ji
	0t27EZ7BFSAZNMFQDJu9s98ldDgPGZySVRiNNxMMy9KfCb5wNdW276fiFwa8fkbkVMesDD
	8vBApOlqeQkslF9wEe23h65J0zWfrlw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-oDhlw24SPUS1eoPnyLPw_A-1; Fri, 16 Jan 2026 11:03:11 -0500
X-MC-Unique: oDhlw24SPUS1eoPnyLPw_A-1
X-Mimecast-MFC-AGG-ID: oDhlw24SPUS1eoPnyLPw_A_1768579390
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b871d37b203so287869566b.0
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 08:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768579390; x=1769184190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjFX/bykGBBHThUhcm6tfBPaAUsB3yRUC8oPazeSzBM=;
        b=s7LVFbnhl7wW6HJSZ3YgbIRAQvd5hOK6p3H1pG9D0KmgMLg0HsbZ+86rPTI74EmXSH
         XRLMSi2/U2c/fgPqpbBbVdnEz7idqAu36OxBgSm0ZuQI+/8IZyteEnoGgxURAYI7v6iA
         IstwuPIJ9BVWONn/HkJclSGnGDYVyPap1G8VV/k0hChV7wimG3KxaczlQlmfDTojeJg0
         6p9S7PlUSv98wF6LEh7h+9rWDtvb+qyCaXtqdkA9/Raqgs8z3ViFTU54G+A2pGnxqJ56
         0E940FnezLMPurQ4Ah9JBkzutMMfPu0JGoF9UiNNKOgpXCRpsURRoxmh8gDDOH+qg9Wc
         NRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768579390; x=1769184190;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjFX/bykGBBHThUhcm6tfBPaAUsB3yRUC8oPazeSzBM=;
        b=HwFTdJNkH7KNmNafsrTe2hcAe4RoMgstKx1oYzk2ZuyBJPJN1TFv8BwYAsZLzSmyNS
         3OO/l+eAqBAOBWaqpCYS94fsDpvnxhkCFq6ssp7BWMQgECrEleG4XJlgXdHImC3VsQf0
         78wn7hHUQtoezCsxY62IcEBCe4S3cbkk/vTtJdX7I0P9Zo1K87NZcR0EmjprtmFVZi14
         yr1tE/gDzF5H+7NkEeVk2NOAYjMPNGAnpaM7LcBxcjWq7WjtEPj9LFnIyoRvukjFDVIc
         komvFZeT9gWfM1U2kZx1YpAj6NjjD4ZVDYusGl6WzWW9+4sGLs2VAE80QvRVIM8k3IIC
         KF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSJddro+oc8yVRZ10RX5TTfUWx/bwm7m1lyZp1pzwXLGmnzoTCmE8SUsQsLZe3KK7YDxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDh5T8l2oc4BYflEeqp6X6nd8OsZ3k5tvEJ5fvcorm2ziCN7ab
	xYtap6WSw5cuBauN4gkES1dT6BdZxTvgRPxSmYGlcl4hPV9Bl9pNe/2biQcBGg20ZO4vP7LVX6+
	Ey4TcYGYz6zK5LFdMGJgWwQyn6LdHHUHFG0pCUrjoSJ5im7ZwMT1t
X-Gm-Gg: AY/fxX4ys7XuYzJUZdX+4960toH8D0I9Ufhe1pEqhtUcMsrUH9d9s/FCibsZOuielkL
	F4jSeofTvCzQmjZ/jFmG0+Jm6Ta6EbLiP35osr9T21wsHzZhrsdnrBEziWXeiGJIN4tZa+GUM+c
	5n8YgTVrfsrzEGJ8IP0dKowxOdyT4kexlAn5cXuH/5TcqUGYt3nJ8y/1NAE3vEgDsBH8bBfvWIc
	SasKpxFruX7V1KRYLiBPXtHMT69G2WZPm9CfhWgjK3PSVs8o1B9fs5Q3IHbhLpDpc+UG4oxOaZw
	p2/Ve9OYLwLhgwo/nd9K6qemxy06cHwkADi3bNNmcaBQwFck8B6pEivzXDtO+zADdGUYBdwyfq4
	JdVF7/yAJoB718soWg6CMmqeaNkgL1XQ0JoPThF56CyAOwQ==
X-Received: by 2002:a17:907:bd0:b0:b87:7430:d5e2 with SMTP id a640c23a62f3a-b8777a59432mr472704866b.12.1768579389781;
        Fri, 16 Jan 2026 08:03:09 -0800 (PST)
X-Received: by 2002:a17:907:bd0:b0:b87:7430:d5e2 with SMTP id a640c23a62f3a-b8777a59432mr472682266b.12.1768579385486;
        Fri, 16 Jan 2026 08:03:05 -0800 (PST)
Received: from [192.168.0.199] (bband-dyn169.95-103-216.t-com.sk. [95.103.216.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879ae74639sm225477266b.9.2026.01.16.08.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 08:03:04 -0800 (PST)
Message-ID: <bcce0d61-e7ae-4268-a6ec-a82f1329cc6d@redhat.com>
Date: Fri, 16 Jan 2026 17:03:03 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strncasecmp kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev
References: <20260115173717.2060746-1-ishiyama@hpc.is.uec.ac.jp>
 <20260115173717.2060746-2-ishiyama@hpc.is.uec.ac.jp>
 <46799ba9-d292-494e-b9b1-658448993538@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <46799ba9-d292-494e-b9b1-658448993538@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/26 13:28, Mykyta Yatsenko wrote:
> On 1/15/26 17:37, Yuzuki Ishiyama wrote:
>> bpf_strncasecmp() function performs same like bpf_strcasecmp() except
>> limiting the comparison to a specific length.
>>
>> Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
>> ---
>>   kernel/bpf/helpers.c | 31 ++++++++++++++++++++++++++++---
>>   1 file changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 9eaa4185e0a7..2b275eaa3cac 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3406,7 +3406,7 @@ __bpf_kfunc void __bpf_trap(void)
>>    * __get_kernel_nofault instead of plain dereference to make them safe.
>>    */
>>   
>> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
>>   {
>>   	char c1, c2;
>>   	int i;
>> @@ -3416,6 +3416,9 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>>   		return -ERANGE;
>>   	}
>>   
>> +	if (len == 0)
>> +		return 0;
>> +
>>   	guard(pagefault)();
>>   	for (i = 0; i < XATTR_SIZE_MAX; i++) {
>>   		__get_kernel_nofault(&c1, s1, char, err_out);
>> @@ -3428,6 +3431,8 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>>   			return c1 < c2 ? -1 : 1;
>>   		if (c1 == '\0')
>>   			return 0;
>> +		if (len < XATTR_SIZE_MAX && i == len - 1)
>> +			return 0;
> Maybe rewrite this loop next way: u32 max_sz = min_t(u32, 
> XATTR_SIZE_MAX, len); for (i=0; i < max_sz; i++) { ... } if (len < 
> XATTR_SIZE_MAX) return 0; return -E2BIG; This way we eliminate that 
> entire if statement from the loop body, which should be positive for 
> performance.
>>   		s1++;
>>   		s2++;
>>   	}
>> @@ -3451,7 +3456,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>>    */
>>   __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>>   {
>> -	return __bpf_strcasecmp(s1__ign, s2__ign, false);
>> +	return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX);
>>   }
>>   
>>   /**
>> @@ -3469,7 +3474,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>>    */
>>   __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
>>   {
>> -	return __bpf_strcasecmp(s1__ign, s2__ign, true);
>> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
>> +}
>> +
>> +/*
>> + * bpf_strncasecmp - Compare two length-limited strings, ignoring case
>> + * @s1__ign: One string
>> + * @s2__ign: Another string
>> + * @len: The maximum number of characters to compare
> Let's also add that len is limited by XATTR_SIZE_MAX

This applies for other string kfuncs, too, but we never mention it in
the docs comments. Does it make sense to have it just for one? Or should
we add it to the rest as well?

Viktor

>> +
>> + * Return:
>> + * * %0       - Strings are equal
>> + * * %-1      - @s1__ign is smaller
>> + * * %1       - @s2__ign is smaller
>> + * * %-EFAULT - Cannot read one of the strings
>> + * * %-E2BIG  - One of strings is too large
>> + * * %-ERANGE - One of strings is outside of kernel address space
>> + */
>> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
>> +{
>> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
>>   }
>>   
>>   /**
>> @@ -4521,6 +4545,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>>   BTF_ID_FLAGS(func, __bpf_trap)
>>   BTF_ID_FLAGS(func, bpf_strcmp);
>>   BTF_ID_FLAGS(func, bpf_strcasecmp);
>> +BTF_ID_FLAGS(func, bpf_strncasecmp);
>>   BTF_ID_FLAGS(func, bpf_strchr);
>>   BTF_ID_FLAGS(func, bpf_strchrnul);
>>   BTF_ID_FLAGS(func, bpf_strnchr);
> 
> 


