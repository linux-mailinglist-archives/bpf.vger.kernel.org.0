Return-Path: <bpf+bounces-28539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E798BB350
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144FA1F2332B
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D10158DCB;
	Fri,  3 May 2024 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSKBq3Pe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09942C6AE
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761247; cv=none; b=L5sMe/v3GErnL01RCnQ65feFtnPSKZtSCMeL0N5Mc7M2FUBEjMlcgKUQF9fFM8S2vKGWQjoEmW7K/BN2Gcwffq8DX44JGFy1R+aZH20rcSdyNtWM+ReFZZ2I84JIJ84Y7w+Y9Kis/NJSM9JdcgDjAhzp1RgOtVYojHh2IDZ3XcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761247; c=relaxed/simple;
	bh=UaHEqOh5pz1nmCBJoOCfXPRul/tSzph+6YSlrZMvRfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwRrcxyXSfnGCY+wF6MxOGgeDnyd5JOR4JdDu0vUvB2szCmK/BPdAdeKMPnmS9cel8S6vnfcK6fxlSvqWXbXkGdOjHEaN4NwsLbEOH3EvOBlP8gBgPRL3R3S3zJJuQlcqaHPqvje9K9GUFPI0yXcghr8XO1tYWPcJ2EThZJ1EO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSKBq3Pe; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ee1b203f30so3777817a34.0
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714761245; x=1715366045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mh3On1L7MkylgYv4ti3Y/DaXy4gk7oOwUldK4WXzhGs=;
        b=fSKBq3Pe8R9Fj3iKgqNu4wiZ9D6fhGwyhzgggkuitBY1zyej0WA5newEvYNtwD3+kr
         2joe6rnVoW3DqQnil0+DhaGmP/qMcoRkYncOBZaw2kFYP3J4yV3Y2OeR5jXxJhb+gAHw
         qvO29KaFm8SOc26vXqA3IfmPEAzHNeg3hGc0UFlJ14dufhiyp7tN9OySsIDAUB6vscqF
         9GGBn2ma9ShafUF3i0V1ot/jONGMaFihqQeRJ33giEu3wPaI0xCyIRBgBBWF2UaIxnyk
         fJaHLulTY5h5eDstYneylosw4lQP7N/5DCs5Xia4daV+HsRo6wTaUXyNb4GyKJVXY1cp
         jj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761245; x=1715366045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mh3On1L7MkylgYv4ti3Y/DaXy4gk7oOwUldK4WXzhGs=;
        b=isZHYoltjAVeP7Yvm52iSo7QBNP0V6CXT96YwVjJU01RNBx0mTjGd+6wOfZX6h1wlT
         BIkado/xdFWMae701BqeYAdU1lh+I576AFyZnDCCK/o3T4vFmpiC8VLgvfNwlar4geLD
         os8fMY4OswqE1iO2AFZa/laI0JwXZsyvwSEpTett3w9jDRkBfguRbo0W+US672lW81lj
         RCLpoSbIYNYPHMPCUE8d9lvniQceCvloE8GQuRo4WT4UfuCVbZZ6mvxXVOix4oFBDarx
         ffTiw2T2pi2QWJq0mz9BP1M+9MARCEn+T5LAXLa6zFJgHwGXuc6gbIz9bUQJRCvSBAQD
         1yDQ==
X-Gm-Message-State: AOJu0YwFKvCX1+NplZX3DeOkbVs69awe2MMpQqq7W7rffOTuAqupfSi1
	Jqsnzc4zgJbpq+lwZMPmiM0P99GpQpri351T8B3fFgPGLDk6l6eU
X-Google-Smtp-Source: AGHT+IHWj4Lu3iBkr7rBVdJK9MZyz4pqTkXcrTObUEODQ8kE7tv5S4k4KTrF52ptaFtT7VjddpbUow==
X-Received: by 2002:a05:6830:3a1a:b0:6eb:7ce8:3e72 with SMTP id di26-20020a0568303a1a00b006eb7ce83e72mr3805229otb.7.1714761244928;
        Fri, 03 May 2024 11:34:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:248:d6ee:f0ae:bd46? ([2600:1700:6cf8:1240:248:d6ee:f0ae:bd46])
        by smtp.gmail.com with ESMTPSA id v9-20020a4ab689000000b005aa7278fbc5sm727999ooo.47.2024.05.03.11.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 11:34:04 -0700 (PDT)
Message-ID: <4462086b-c01a-4733-8a15-7ef0d1f91c2f@gmail.com>
Date: Fri, 3 May 2024 11:34:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: test detaching struct_ops
 links.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-7-thinker.li@gmail.com>
 <d7d50210-bc21-4de4-9b2b-01b299a15bd0@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <d7d50210-bc21-4de4-9b2b-01b299a15bd0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/2/24 11:15, Martin KaFai Lau wrote:
> On 4/29/24 2:36 PM, Kui-Feng Lee wrote:
>> @@ -572,6 +576,12 @@ static int bpf_dummy_reg(void *kdata)
>>       if (ops->test_2)
>>           ops->test_2(4, ops->data);
>> +    if (ops->do_unreg) {
>> +        rcu_read_lock();
>> +        bpf_struct_ops_kvalue_unreg(kdata);
> 
> Instead of unreg() immediately before the reg() has returned, the test 
> should reflect more on how the subsystem can use it in practice. The 
> subsystem does not do unreg() during reg().
> 
> It also needs to test a case when the link is created and successfully 
> registered to the subsystem. The user space does BPF_LINK_DETACH first 
> and then the subsystem does link->ops->detach() by itself later.

agree

> 
> It can create a kfunc in bpf_testmod.c to trigger the subsystem to do 
> link->ops->detach(). The kfunc can be called by a SEC("syscall") bpf 
> prog which is run by bpf_prog_test_run_opts(). The test_progs can then 
> decide on the timing when to do link->ops->detach() to test different 
> cases.

What is the purpose of this part?
If it goes through link->ops->detach(), it should work just like to call
bpf_link_detach() twice on the same link from the user space. Do you
want to make sure detaching a link twice work?

> 
>> +        rcu_read_unlock();
>> +    }
>> +
>>       return 0;
>>   }
> 

