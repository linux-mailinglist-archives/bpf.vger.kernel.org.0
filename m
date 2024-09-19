Return-Path: <bpf+bounces-40100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F497C8DF
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 14:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904571C21E94
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA419D09A;
	Thu, 19 Sep 2024 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJqzhbKH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374619AD7D
	for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747731; cv=none; b=ZoO4orksEPKEjlf8BTK2OHC8GJSMbVk2443/QJmS7hHGZ86s4CtMweIeZ0R6I4WZ+IEtmkJMwcKdmyPBLtfFVTv6NtCdHaE/ZL4v3jOtlu/vGJ1sJ/Bxp5vgZC1vg45+7FOZMCcfuOrzKo4i6ZkobP4BX4rTjcq0q0FW+Gkn8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747731; c=relaxed/simple;
	bh=FUM3YRO7FmRGKrfyOO6iFdDq3eFcfT+Q8G7SOEWW6pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVs52UFqyZgHIGt88beug55n9QcO/8ZWqzweClbqV7ENjQZMjdqzBMxFTpyGDeraVC+zDm1EROvHRe5M3xtsxX6CJTbgq2BpXdfvFw2mrEngznIn1xfoPNYixJUMmAEgyPivR6rriILGPnFWg0JbcGrHevYo42oLSPviSaHEE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJqzhbKH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d4979b843so82804066b.3
        for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726747728; x=1727352528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ZE/2m9azwkCDTlAM/lV2N1rCuV7pzz7SBNhRCJxf2k=;
        b=aJqzhbKHkXaUtRZmshIQ8MLABpfNjG1lqCDv+mEYrc1iaEQnskX4IIVgDJ3tdB3lk+
         +CWd7+G3rz9zczlv0tAytnIPPOU/IRunDh4PPvNPVa/qySXuedyVsEoFEWbLZb0ix119
         Fvo9XxaXuVDloVNMYGR4N0X3Gfyp7fLgKMxEU9sAC39Zi1JQX7+UWA4kXVUhrFZiccs3
         gYrBeoysM8fTx+BlM7sK4ayBpYoXlyIsu9ZiLEih8Egy8pHAR0/k284O/bc7neR6s7Rv
         PoXT/dl+ggGuYj7Eb2WOxvYe7YIdwVr8kPrVLfWz6H20MLzOQNdIfMu6BltfxqP8tohW
         CJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726747728; x=1727352528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZE/2m9azwkCDTlAM/lV2N1rCuV7pzz7SBNhRCJxf2k=;
        b=nb1iuhHUTw5XBZyrFP1hrLL1uEhP1H0Qki1APFlWEqKyj65BHE4N2UwJVTh8VAgk9K
         dbrw7VIqFFnIULY73yf6XwJjVnNkqWw472Y/z5ohF+ldXa/A3KRGEuJIzvERq8Jv5cVG
         1EAILze4gibf3hE8y7/gF4pa6pYEMrrQPbIDPr21fvqvWgBUbmSW6AiVQo++lZ6KdPVz
         ofIzsYWRBBTbZpps0v4ux5ZwZ3um01GWIBiZNs13/ZYfW8E5GQRFlRwNrZj6fgMkleOJ
         ehnFwQ6UXhoBsRVfRqBU1qdw0GsEeA73Y8Iu9uq27NpekkXw+DqSvc2D6dHyACL56ID3
         N8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVrrZnnbc7cqU9CCDwlhfQzLAZEzPaPoNRueN4/B9NBXUPVBQRosIZaDzeBgtCEO6FY2vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLSwkDjCToLiu3lFT28CDjGdBqHGW7ZHemMTwFQG1a0ibD2yO
	BZ8wmw/R5eBF/qp2Rl2AJOMQE2aaCPAooh+FiGjDmBt6Yc9c9v6t
X-Google-Smtp-Source: AGHT+IGepjg6dhetyBljBbWcqcN2TwmUtpimHOzZ1cAnC1LTd5wK/Vv5spkYpsw3W6g6R42VpNKIKw==
X-Received: by 2002:a17:907:9484:b0:a8d:4b02:334c with SMTP id a640c23a62f3a-a9029679e74mr2695120766b.64.1726747727345;
        Thu, 19 Sep 2024 05:08:47 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:3:6315:9fa9:de57:9990? ([2620:10d:c092:500::6:f897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610966e2sm722726766b.16.2024.09.19.05.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 05:08:47 -0700 (PDT)
Message-ID: <2b838e54-4515-432c-b492-ccc16e000e7e@gmail.com>
Date: Thu, 19 Sep 2024 13:08:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: emit top frequent code lines
 in veristat
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Eduard Zingerman <eddyz87@gmail.com>
References: <20240918203925.150231-1-mykyta.yatsenko5@gmail.com>
 <2a5997cd-ef30-42e6-b89b-6a1841e0c822@linux.alibaba.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <2a5997cd-ef30-42e6-b89b-6a1841e0c822@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/09/2024 03:51, Philo Lu wrote:
>
> Hi Mykyta,
>
> On 2024/9/19 04:39, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Production BPF programs are increasing in number of instructions and 
>> states
>> to the point, where optimising verification process for them is 
>> necessary
>> to avoid running into instruction limit. Authors of those BPF programs
>> need to analyze verifier output, for example, collecting the most
>> frequent source code lines to understand which part of the program has
>> the biggest verification cost.
>>
>> This patch introduces `--top-src-lines` flag in veristat.
>> `--top-src-lines=N` makes veristat output N the most popular sorce code
>> lines, parsed from verification log.
>>
>> An example:
>> ```
>> $ sudo ./veristat --log-size=1000000000 --top-src-lines=4 
>> pyperf600.bpf.o
>> Processing 'pyperf600.bpf.o'...
>> Top source lines (on_event):
>>   4697: (pyperf.h:0)
>>   2334: (pyperf.h:326)    event->stack[i] = *symbol_id;
>>   2334: (pyperf.h:118)    pidData->offsets.String_data);
>>   1176: (pyperf.h:92) bpf_probe_read_user(&frame->f_back,
>> ...
>> ```
>
> I think this is useful and wonder how can I use it. In particular, is 
> it possible to know the corresponding instruction number contributed 
> by the source lines?
>
No, as far as I know, we don't have that info, so we just use number of 
source lines as a proxy for number of instructions. Eduard suggested to 
collect
instruction count per source line in verifier, maybe that actually what 
we should do.
> Assume a prog is rejected due to instruction limit. I can optimize the 
> prog with `--top-src-lines`, but have to check the result with another 
> "load" to see the total instruction number (because I don't know how 
> many instructions reduced with the optimized src lines).
>
> Am I right? or is there any better method?
Yes, you are right.
>
> Thanks.



