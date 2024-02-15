Return-Path: <bpf+bounces-22102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92824856D87
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 20:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D000285577
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D3E139589;
	Thu, 15 Feb 2024 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALKgjFHE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6A1386C6
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024828; cv=none; b=kgdX+ttZqIVYlLIxaB9TlSiBpCjo/RyyO+QGFx1WwroxhO/fDgu991jDXZwuOcrfeILWj0qwrbnywLEfr+0B7cEBQ53ekezxLL/I67t/YKqj8Kqg2ELEmG5mDqZOCqz3+R69guS3A1cWVgD8YP5Qm2j8sJmaX5emdQgKQq1DkRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024828; c=relaxed/simple;
	bh=kWI7nJCEmMGi4bjxYm+Zw9WO2kt05oN/fZVxZzccYTg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hgLYKU3tlwove+A90VquEs6df8wgEDTYHwjJDsfys7iXr4P5ua3HWjlMvtYoSq/mOA+Se+YWdJikUa/mZwv6coYNxR7VznB6r04dg/K16TUNaF48rD3d4lM+WHrxv4+vl0xbarDGc+3+ST69pWRj7MvLk7BlQB36ocA+ZOpepkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALKgjFHE; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607e41efcf1so6609947b3.1
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 11:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708024826; x=1708629626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FrwuOS7glUSmTuDGfmKP0xy/k475IeAhAU/UzJsvLrA=;
        b=ALKgjFHELKeMTy9w7V+mCk/UqqzeOSbe8y33TQUuiJkjHuNRSbhF3w7NQltU1HziDX
         IcBmG9TJ1G29AZaUTbcv5PV7mIEtwFGj1VfXDsp99MSlkfP2vq+xKcLFn/lCpMSxLzE7
         aN0eYqIYkVtF1/HGk/opwyf5FWR4FEBo0fiZMcJZU58P6d2oHzbNXMvw8QebWJVjFsl0
         HuEM5trmIKyvctLMyQmcNsZu/o1FYZ+LW8U3F+eysU7suijGcR/67d4yRNxl9IDHrmoE
         1O039ddS5xkKNr3wtS7O/9gD3xF4u1D+Lqf48at3xqlCEmOBF1cgy5scLtoR3xo4K9PT
         dblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708024826; x=1708629626;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrwuOS7glUSmTuDGfmKP0xy/k475IeAhAU/UzJsvLrA=;
        b=gqLCK3BIGAkEOHmsnNOvIpDRPgR88MLk96grVR0lzr8oDBFjuiyYvFAEwcRiC4Akoy
         um2NmpgjJ8wXZliX+DQRw7/G2xQGKypXpKPE0cqYErA6mp/Nq+L8552krn07Vx7lGE8K
         jw3ufhJEpMF6R1LRZK8hR2zzRMUu0KMF11Eha4YPdnuD6qQLw52RzWT5BGxMRkozDQgm
         T3HWF9p0Vra6LAEg9hxPh+Kb0lPp+wTq7tzpZpOoVnWc0ZD3qPTed9og1Ligts7Or+Rx
         +r6Waojhj2kimY4jCCzwqT6Bd1arMWvG02uV+nn3Ty8D5pCSeTKN+jKZzPruV3vYaNnC
         RDNw==
X-Forwarded-Encrypted: i=1; AJvYcCWuqVeTyMnFAsitjJM3zkXoa+QvLf5RtIAdZp1up9ujTr0hqBiCiLmsX/D50b5ClUCIfxcc7dbCETPLl56VjgNu4UuY
X-Gm-Message-State: AOJu0Ywsanh/EPNwDD6no5oZDFQFn+95dE0erU6lVpiVYc7e7hqh2Qbt
	RId42qWktzhBgljA88P062sZ/43pxUI0zL8gspjdYsX1+nZ7GR/H43iMDzUM
X-Google-Smtp-Source: AGHT+IEjiqBcO5CA3TeyuAV4SRjLOLAEh7YvL6/Xw2vYGkHnGopnPnGPrLjb/4IdFIAHahCn+tkfsg==
X-Received: by 2002:a81:ac43:0:b0:607:a0e6:b3ad with SMTP id z3-20020a81ac43000000b00607a0e6b3admr2351620ywj.1.1708024826192;
        Thu, 15 Feb 2024 11:20:26 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:121a:9239:6a3e:3f96? ([2600:1700:6cf8:1240:121a:9239:6a3e:3f96])
        by smtp.gmail.com with ESMTPSA id r76-20020a0de84f000000b0060784f1fadbsm3503ywe.109.2024.02.15.11.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 11:20:25 -0800 (PST)
Message-ID: <71d592b8-0749-457c-91a1-2fb46d917be4@gmail.com>
Date: Thu, 15 Feb 2024 11:20:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Check cfi_stubs before registering a
 struct_ops type.
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240215022401.1882010-1-thinker.li@gmail.com>
 <32dd0715-1f36-4de2-ab69-0e21019eade5@linux.dev>
 <6b75ba79-dfc8-4681-b8d5-3f63e0b6706a@gmail.com>
In-Reply-To: <6b75ba79-dfc8-4681-b8d5-3f63e0b6706a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/15/24 11:19, Kui-Feng Lee wrote:
> 
> 
> On 2/15/24 10:23, Martin KaFai Lau wrote:
>> On 2/14/24 6:24 PM, thinker.li@gmail.com wrote:
>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>
>>> Recently, cfi_stubs were introduced. However, existing struct_ops types
>>> that are not in the upstream may not be aware of this, resulting in 
>>> kernel
>>> crashes. By rejecting struct_ops types that do not provide cfi_stubs 
>>> during
>>> registration, these crashes can be avoided.
>>>
>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>> ---
>>>   kernel/bpf/bpf_struct_ops.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>>> index 0d7be97a2411..e35958142dce 100644
>>> --- a/kernel/bpf/bpf_struct_ops.c
>>> +++ b/kernel/bpf/bpf_struct_ops.c
>>> @@ -302,6 +302,11 @@ int bpf_struct_ops_desc_init(struct 
>>> bpf_struct_ops_desc *st_ops_desc,
>>>       }
>>>       sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
>>> +    if (!st_ops->cfi_stubs) {
>>
>> How about *(void **)(st_ops->cfi_stubs + moff) ? Does it need a NULL 
>> check?
> 
> This NULL check is necessary to prevent the crash but good to have.
                     ^^^ I mean "not necessary"
> 
>>
>> Please add a test.
> 
> Got it!
> 
>>
>>> +        pr_warn("The struct_ops %s has no cfi_stubs\n", st_ops->name);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>       type_id = btf_find_by_name_kind(btf, st_ops->name,
>>>                       BTF_KIND_STRUCT);
>>>       if (type_id < 0) {
>>

