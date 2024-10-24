Return-Path: <bpf+bounces-43077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FAC9AEEF4
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A71628183D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2694520102B;
	Thu, 24 Oct 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZB9H3L5C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DECD200109
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792703; cv=none; b=DpS1mtDr/4lULPJRBmAVRHCdIkMmRpYE1FzN85GeTd3Vg5GxsrzUVSQoQCR91iD5E2iqnFir2fMMyI17k2nYYColTpmz0gZN0TXsHWdtolBI2NVYyOxKgk86N8ygYK+Itt3r+PkXz9JAX7TNv0lqJBGTOtZcZ2n0gFfvWIBlaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792703; c=relaxed/simple;
	bh=Tz+TYnkIIvvQFZxJXocJ/1Xjs+i7EyQ6ol3RLGTBNgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNa0oV8LHN94Oak7YPKRqS6JFDkr4Y0gOpsemg4tIt8TCssO7KNKglkH2hBrlP7OMCJGBvieRjiTGP17vuf73nQmEqyyDqVL6dx/Oc2NgTq3MgggaOd8rVRjbFiln0xGDGariGtCyDH6uQKCA7O6whpwjDPS2bSJwAzytt6t3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZB9H3L5C; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbe700dcc3so6693006d6.3
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729792700; x=1730397500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hdgcL1ucFFy+nzvoOayay0MMPz8QSN6E1pTWl4Cyxk=;
        b=ZB9H3L5CGs4nYN3S4z+UTHcx/hnjkMePMaDc6EvAQOfnIG/h247HK/UTONHvg56ERN
         Xv/DOblbu+HyU9WMQsL0ySAgwRPVHo1qOcBQil+OwAyud7WE3omyJJUg92vZ0NuPT5BW
         sro7iuzrvyDXIcPEUuz1+n0sedtwJKVU4kt25kW0E6VhB7xYxhalupsJiKArcCQ6eo6x
         Y6/VFmNTOBopcThqFrEkcF3s7bODgu10s229YnCXywItNc33hf0hwiSzEwDcUXyMP0Ig
         Qm2DMPZeKJi1Jh7rf5oa8reI2vlb3uDqm+lDMZ15sabPQQ9OOxEPOElMEfcIm82QZrh3
         xFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792700; x=1730397500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hdgcL1ucFFy+nzvoOayay0MMPz8QSN6E1pTWl4Cyxk=;
        b=MotfSzAiH31aQqfILc1h0xg+x5NJ/u4cQ/8pWt8cE0fW5YJdMQOmf8HdfyE+/E1GVq
         /3qpRwWnBqEI52yBUZ83ZdRAs7zgaG0CaiW2X5n3FVHawLAamupOkoEvcFtGEW/t1lw2
         7AGJ6XpQFuRHi4foSLF1UkqfRV7YQnZSDh1JmwmponfqpNAweu55BPkapOlNWZfMWh2n
         L4dhYkV8Ar21BF4sJmEblGykCtShK4EejMKtrKtq0xul9UbYgEfwRe71KOHgx2OfhGxR
         9RDvvwKtJTjIYIKsPT82jEVLAUMdRv0pVTlBuIUQR0H6ILqt6dChM4akJQPrzd9hEiK1
         +oSw==
X-Forwarded-Encrypted: i=1; AJvYcCUfG8A6qgRibkYDJQFz6cf8TjOtcbAMU1crktnSwp1YNdECSRNNKrrCvWw/ldlmkS0GESk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOc059494yjsnYyY/RAL4h9Egufg4W2qDLlXY9Qmi/7RTBvMZW
	ys87FxEdehehIvVCR+RyXXgyh13BUI8fYcq++Cf5iDwPlZUzKv0rPvrMfp0aqVw=
X-Google-Smtp-Source: AGHT+IHPcibdiY+9i1rDTxx4UD5RHEiS/II5BX0tKVkJ263toxJWAe4Sh7m1MSTRB5o6QUVwFE2Y4A==
X-Received: by 2002:a05:6214:448f:b0:6cb:f7c7:803a with SMTP id 6a1803df08f44-6d0939b9dcemr26607106d6.46.1729792700285;
        Thu, 24 Oct 2024 10:58:20 -0700 (PDT)
Received: from [10.200.180.69] ([130.44.212.152])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009e32f9sm52362576d6.112.2024.10.24.10.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 10:58:19 -0700 (PDT)
Message-ID: <148ce32b-b17e-4612-a30b-baa2c249eeb2@bytedance.com>
Date: Thu, 24 Oct 2024 10:56:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 0/8] Fixes to bpf_msg_push/pop_data and test_sockmap
To: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org, jakub@cloudflare.com,
 liujian56@huawei.com, cong.wang@bytedance.com
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
 <6719c7aede141_1cb2208a6@john.notmuch>
 <fe0ac5b2-f662-4635-92db-081fadb5e375@iogearbox.net>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <fe0ac5b2-f662-4635-92db-081fadb5e375@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 7:43 AM, Daniel Borkmann wrote:
> Hi Zijian,
> 
> On 10/24/24 6:06 AM, John Fastabend wrote:
>> zijianzhang@ wrote:
>>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>>
>>> Several fixes to test_sockmap and added push/pop logic for 
>>> msg_verify_data
>>> Before the fixes, some of the tests in test_sockmap are problematic,
>>> resulting in pseudo-correct result.
>>>
>>> 1. txmsg_pass is not set in some tests, as a result, no eBPF program is
>>> attached to the sockmap.
>>> 2. In SENDPAGE, a wrong iov_length in test_send_large may result in some
>>> test skippings and failures.
>>> 3. The calculation of total_bytes in msg_loop_rx is wrong, which may 
>>> cause
>>> msg_loop_rx end early and skip some data tests.
>>>
>>> Besides, for msg_verify_data, I added push/pop checking logic to 
>>> function
>>> msg_verify_data and added more tests for different cases.
>>
>> Thanks! Yep I think push/pop are not widely used anywhere unfortunately.
>> There are some interesting uses for push/pop to add/edit headers, but
>> I've not gotten there yet clearly.
>>

Thanks for the reviewing :)

>>> After that, I found that there are some bugs in bpf_msg_push_data,
>>> bpf_msg_pop_data and sk_msg_reset_curr, and fix them. I guess the reason
>>> why they have not been exposed is that because of the above problems, 
>>> they
>>> will not be triggered.
>>
>> Good. I'll review these quickly tonight/tomorrow and run some testing.
>> We don't currently have any longer running tests with push/pop.
> 
> Looks like the series needs a rebase to latest bpf tree.
> 
> Thanks,
> Daniel

This series depends on my previous fixes to test_sockmap("Two fixes for
test_sockmap"), and they were merged to bpf/bpf-next.git (net branch) a
week ago. Shall I wait for merging of them to the latest bpf, and then
rebase?

Thanks,
Zijian

