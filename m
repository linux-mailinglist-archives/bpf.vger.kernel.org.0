Return-Path: <bpf+bounces-79580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED664D3C419
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2184544367
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF33DA7F9;
	Tue, 20 Jan 2026 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvdYur0w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n70Iagmj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771963D3308
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901369; cv=none; b=lZoxFY9uuky83W1aqfgJWJ1X8ZTO67ggRtGTNetNSCgJEvzQJIgjeI8oGhxV97w3fwmZE35LyQs4fUbFy1XeKAd5RJyeI1uDzE/9eoaElzWvPyH1DFoEBjS354msjnACrimnmTisWejx+EU9SSqB3iM87XHbE+TjPtxWTBFlKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901369; c=relaxed/simple;
	bh=u0t9utE1VdYIkNusZOPhLh6iE752x+q8qfWRm/zBNvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpO9DwBeOzvsUGONrO1BazJeryjTzmIrDb3caj8/p0cBn651nln79zj90tCIMWLDuwUUZrYSNRwqqeyiRQ4rScEVqhjE0MPhreZ8haD3xBk8N1Mosb/NxhUIOvJp4ALdOOBXF78Ab3sauCFSNwjSwR3laYR+Caqlvy1LtL4Oc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IvdYur0w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n70Iagmj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768901366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytdce+lmnQxHdCLoiOHjM1xD0pxCoz9ZC4Ra5w4KFBs=;
	b=IvdYur0wizkOMaaPZ2R5sMuWhnv4RCvxzz71CbKTorot9bsVEX9Cc7qUsq8cYkGav0bFDv
	HSbsmg6ZGHZ+IqQT6hE+lrb+HsPQltrIFJRMaaHonKk0nV7XYMG2vk0vPJi/+wZQbVGl2P
	d83mL23opt3Xw7OYl4TcHtGNvs6+Cto=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-otEcSX6KO0avTIBSCecKwA-1; Tue, 20 Jan 2026 04:29:24 -0500
X-MC-Unique: otEcSX6KO0avTIBSCecKwA-1
X-Mimecast-MFC-AGG-ID: otEcSX6KO0avTIBSCecKwA_1768901363
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso53473635e9.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768901363; x=1769506163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytdce+lmnQxHdCLoiOHjM1xD0pxCoz9ZC4Ra5w4KFBs=;
        b=n70IagmjGcrXfd3BRevxjEWErsqUvLl7S5vVuMrYKTZxc0vZjVCpTiUE9dTKocCCxC
         1UY3V32INQUrgPZ4s63j0lq5H8Z398ZQcl0Ani5b9xWwFURVw4btmiKvKbSDLrPOzAat
         BEgXw7WCc7Wlqp9trBhw+GhJzrxsBUIiEXFPUVUJnOgPMWYs7iO3BFvOantXkZJhJM7G
         6Ql1FcH2IZUVyCc34kzSpzzn5SE/YTnu8cEl3Gze4ROz/FKrhveljH8zi8ntzmdRdSnT
         x4HwelucSYlENJd15gswkXoJEG5uWlaMs+0xfgTJzOswl/DqYFy7yfGaKCOJPFurWf/u
         AsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901363; x=1769506163;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytdce+lmnQxHdCLoiOHjM1xD0pxCoz9ZC4Ra5w4KFBs=;
        b=wDXEegYk5mzWWm79XQB+ayaDeYlMLZnV7AYaEfh+ZA9sOC+LzQ4g58PAvgIEKEXIeY
         6V9DFxIqQVxDtGt8jDfXbdQHtcyWHz1ECwqSR+JwS4dVUD9DkaZ5PlCfPF6OrlGZR8wT
         7a3CLa+OpJ9Lnf3Cl7lvbE164rdAvYuky1uwcZZsvSL7P1nmGA2Yk+Foi4YKW4qXIopw
         wD7MyVkOIJ/rRVcrpgf0EoX+vvk/XORfaKyLTThExrWnF6qn0k9LwaGUKAFvHvjjR3Ts
         xDBpMJKYQwytZzfOJuE+g3yAhYw27E4zlMGpXmKlFy/P3+HNWSYhSTDafNh0Yc1tL7vv
         vU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWF9E/2Qdju0gXVZirG06HmVD1I6UPHC0QFRGyqNnoti074ZETooRRmF6g0lo0+IH5a1eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMeBgkvYKQsrWkWu/wKwpIISm/fRW8Peus5ZQA7ENvgkFmIZQ6
	E8Wx7BX/nrUiwcWU0kos+Xcqg74QFRPjBq/dX7k2JdQ8JWMl+VDjoKgtsZd0BB9ttNrRD/3YGMj
	tVyVu4q2oHztac9NgHN9cpHTRD+BDBgcC2Ram8WTUN2gR59yKXnHb
X-Gm-Gg: AY/fxX7PhMT0DRTxRJ/YNvkWgOM1hQnyemEbnKxxHHM1yjQtUlqQgkeeQv1U9dHl0Co
	chW52J5+Sc/Gd/zNUE/sfIY2p/iV9mxkEmS1mGPhggvoA0U6JEi/JCmCA7BT9Az9c5a8peuyZJb
	eWCapXQi0G0jLSem2pqXPq8l6Nx6W9GbOTQkDY9sKeYYHP9QqkOowOeKoGZmqTZvzxhYZlaZHvz
	TyZn7EupWD6ihDN3j1kXM5Nt40qAjMOtO+mmmzE5iEPEoM3SDM0ATWiF3gFEQBntPxr7x7LUxdi
	8oBWjV5rZIVuAfYpsY00mC63yYHPYhWH4CA0vE8tQUSh/ONjnrcnAN0uTWksTjwQIrY2bGrH
X-Received: by 2002:a05:600c:4e0f:b0:47e:e779:36e with SMTP id 5b1f17b1804b1-4801eb0375amr166993675e9.19.1768901363234;
        Tue, 20 Jan 2026 01:29:23 -0800 (PST)
X-Received: by 2002:a05:600c:4e0f:b0:47e:e779:36e with SMTP id 5b1f17b1804b1-4801eb0375amr166993365e9.19.1768901362773;
        Tue, 20 Jan 2026 01:29:22 -0800 (PST)
Received: from [10.43.17.17] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cecasm26411832f8f.26.2026.01.20.01.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:29:22 -0800 (PST)
Message-ID: <3d9e2ce9-3e47-4b10-aad2-93b37b235239@redhat.com>
Date: Tue, 20 Jan 2026 10:29:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strncasecmp kfunc
To: bot+bpf-ci@kernel.org, ishiyama@hpc.is.uec.ac.jp, bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260120070336.188850-2-ishiyama@hpc.is.uec.ac.jp>
 <cd994531bcbe33858623d135448bd0540c36bb739b894af5a99d009b617e08fb@mail.kernel.org>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <cd994531bcbe33858623d135448bd0540c36bb739b894af5a99d009b617e08fb@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/26 08:21, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 9eaa4185e0a7..753753f039ff 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
> 
> [ ... ]
> 
>> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
>>  {
>>  	char c1, c2;
>> -	int i;
>> +	int i, max_sz;
>>
>>  	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
>>  	    !copy_from_kernel_nofault_allowed(s2, 1)) {
>>  		return -ERANGE;
>>  	}
>>
>> +	max_sz = min_t(int, len, XATTR_SIZE_MAX);
>                    ^^^
> 
> Can this truncation cause incorrect results when len > INT_MAX? The len
> parameter is size_t, but min_t(int, ...) casts it to signed int before the
> comparison. When len is larger than INT_MAX, the cast produces a negative
> value, and min_t returns that negative value instead of XATTR_SIZE_MAX.
> 
> For example, if a BPF program calls bpf_strncasecmp(s1, s2, SIZE_MAX):
> - min_t(int, SIZE_MAX, 65536) evaluates to min_t(int, -1, 65536) = -1
> - max_sz becomes -1
> - The loop condition (i < max_sz) is (0 < -1), which is false
> - The loop never executes, and the function returns 0 without comparing
> 
> This would make bpf_strncasecmp("foo", "bar", SIZE_MAX) return 0 (equal)
> when the strings are clearly different.

This is a good point and we should IMO address it.

> 
> Would using min_t(size_t, len, XATTR_SIZE_MAX) avoid this issue?

Other string kfuncs use `i < len && i < XATTR_SIZE_MAX` in the loop
condition, I'd stick to that for consistency.

Viktor

> 
>> +
>>  	guard(pagefault)();
>> -	for (i = 0; i < XATTR_SIZE_MAX; i++) {
>> +	for (i = 0; i < max_sz; i++) {
> 
> [ ... ]
> 
>> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
>> +{
>> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
>>  }
> 
> The BPF verifier does not validate ranges for scalar kfunc parameters, so
> BPF programs can pass arbitrary size_t values to len, triggering the
> truncation issue described above.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21162711653


