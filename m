Return-Path: <bpf+bounces-36781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF3E94D519
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 18:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6299BB22B75
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E570288B1;
	Fri,  9 Aug 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhrtrfNG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7CF3D551
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222485; cv=none; b=glYgwV75d78ZGeJlbRf+0bIfMDIB9agP3R9NP0BeA36rcN835LZjg0gezRM4B9Wh904R/15NghIVq9mWjPUnpZRUMIAwsNVjCmV3PDi0rqeBO9FxZ7fuEiM2PPDl09Z+fu0CIR8WOzdrYUWVccrED9CB7PL6K0FJXbBbM1dIw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222485; c=relaxed/simple;
	bh=r1MLOoLx2WdVv2tIU8B+0epdjpYDrlio8MWop2JjW0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgMLkzrahlhcZWYkaAkVvC68YZQ0esK87s0AoFq5msVTDDhTtoIw/sfymXv2+7OVpgY1P9Bbv3vXi9FKP1Hv5wy2dNMWVCxuWDfP/N4XeD6uA1gXk3QeSa0LPID/kEL718SHPnF3RuFmnq0ic0z2sKjvv6Zo6n/rGfsyaG3745U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhrtrfNG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-65f9708c50dso23690777b3.2
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723222483; x=1723827283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x2CpTfVWx0LKXgRlm/seXvk62hmoUl8XkK+zlw0bxkE=;
        b=QhrtrfNGSOU7c0ntIeLYURXP2aM3peAx5zzDjqdd4xzk53vu/sT6isFHrBMka8mKBq
         vgBUz7M57AJpIWd7GZa0seg4CHmPuSLKBsl16a+zpyBowZU7z06T5yP8SHJZt1tUer9Y
         SkAvVN8wObRZhpxCfkopvK98aoxE7wlIik9poJmfJi27csvdzJBeqvQLovIJbCn4aGPv
         I14GazHCSXqg8otT72jQ2NEVmYbc7Rnz444uX/YnuXpnNKPQfLRwbC5B9Yu67s7cgU1h
         JnqY1mP0dC3K9R2m18UG6bDNn43EDftegwdMox0M7+XNYWBT0h/xn1PyGgja+IAfBYwN
         JaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222483; x=1723827283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2CpTfVWx0LKXgRlm/seXvk62hmoUl8XkK+zlw0bxkE=;
        b=QfG2B7u6SIyKwxLcfNfHTrJcddSGp+AG1vEYJjFsqKM+dOmt+IcKC5iiAaRAnqG4Nj
         lmzk7y0eNO35hVYOnOYudR+5Hkjet+MJHV0nIDiT+0QkVT0gRT4Hro7VVQ2/RsrJFix+
         dTAWGLPPlbWkPvmRioXQcDd88CdYNPBone6KuPVgaWVm/ujaS33nCRsV0GVc+nwQwtV5
         LfcTFD3HCASePIsD612H1ixKO1rNAuT6JG6tScJd0BwBJ4gIYugACI16NPzO4FVC/J8o
         siz/lq7lNHD5YA/C0DxcSJfPnhRukov4x+7HPdNYVZVpGmkA1YwmgIRQfMF/vOaTdnUH
         TOpQ==
X-Gm-Message-State: AOJu0YxW3vRBwxW2UMLC6pgYM36WZUJCvzaGuCna5wtDjBE3LOSWHgRs
	VKUssQBgKPa8HUc19VNFFFCLLdcou1hX3pu4WgVcdGHvZuZzPoKw
X-Google-Smtp-Source: AGHT+IEW03R3MSsgoxDAO6o+D0CQw6cBwujrJtqEsWV5xrVvWBZagNuJ8MJTNDaeaRcKvZdfVmf34w==
X-Received: by 2002:a05:690c:2d85:b0:645:8fb:71c8 with SMTP id 00721157ae682-69ec944a0dfmr22039927b3.37.1723222483220;
        Fri, 09 Aug 2024 09:54:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2? ([2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a136bf912sm27397417b3.115.2024.08.09.09.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 09:54:42 -0700 (PDT)
Message-ID: <d4d1b0b5-232c-45ed-bea1-c8628d9b0ed1@gmail.com>
Date: Fri, 9 Aug 2024 09:54:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 3/6] selftests/bpf: netns_new() and
 netns_free() helpers.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240807183149.764711-1-thinker.li@gmail.com>
 <20240807183149.764711-4-thinker.li@gmail.com>
 <da9922b7-c5f3-4a33-a707-14672a8a30dd@linux.dev>
 <ebf9d37a-ce27-44ab-a4da-312c73f8b6d7@gmail.com>
 <bd8ee84e-bc30-4635-a82a-f144e99ee345@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <bd8ee84e-bc30-4635-a82a-f144e99ee345@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/8/24 14:56, Martin KaFai Lau wrote:
> On 8/8/24 1:38 PM, Kui-Feng Lee wrote:
>>
>>
>> On 8/8/24 13:27, Martin KaFai Lau wrote:
>>> On 8/7/24 11:31 AM, Kui-Feng Lee wrote:
>>>> +struct netns_obj *netns_new(const char *nsname, bool open)
>>>> +{
>>>> +    struct netns_obj *netns_obj = malloc(sizeof(*netns_obj));
>>>> +    const char *test_name, *subtest_name;
>>>> +    int r;
>>>> +
>>>> +    if (!netns_obj)
>>>> +        return NULL;
>>>> +    memset(netns_obj, 0, sizeof(*netns_obj));
>>>> +
>>>> +    netns_obj->nsname = strdup(nsname);
>>>> +    if (!netns_obj->nsname)
>>>> +        goto fail;
>>>> +
>>>> +    /* Create the network namespace */
>>>> +    r = make_netns(nsname);
>>>> +    if (r)
>>>> +        goto fail;
>>>> +
>>>> +    /* Set the network namespace of the current process */
>>>> +    if (open) {
>>>> +        netns_obj->nstoken = open_netns(nsname);
>>>> +        if (!netns_obj->nstoken)
>>>> +            goto fail;
>>>> +    }
>>>> +
>>>> +    /* Start traffic monitor */
>>>> +    if (env.test->should_tmon ||
>>>> +        (env.subtest_state && env.subtest_state->should_tmon)) {
>>>> +        test_name = env.test->test_name;
>>>> +        subtest_name = env.subtest_state ? env.subtest_state->name 
>>>> : NULL;
>>>> +        netns_obj->tmon = traffic_monitor_start(nsname, test_name, 
>>>> subtest_name);
>>>
>>> The traffic_monitor_start() does open/close_netns(). close_netns() 
>>> will restore to the previous netns. Is it better to do 
>>> traffic_monitor_start() before the above open_netns() such that we 
>>> don't have to worry about the stacking open_netns and which netns the 
>>> close_netns will restore?
>>
>> Do you mean to open_netns() in another thread at the same time and
>> interleave with the open_netns()/close_netns() pairs in the current 
>> thread?
> 
> I didn't mean this case. I don't think there will be a test calling 
> open/close_nets() in different threads... but will it be an issue?
> 
> I was trying to say having the close_netns() restoring to the init_netns 
> for the common case. Easier for the brain to reason without too much 
> unnecessary open_netns stacking. Not saying there is an issue in the patch.

Got it!

> 
>>
>>>
>>>
>>>> +        if (!netns_obj->tmon)
>>>> +            fprintf(stderr, "Failed to start traffic monitor for 
>>>> %s\n", nsname);
>>>> +    } else {
>>>> +        netns_obj->tmon = NULL;
>>>> +    }
>>>> +
>>>> +    system("ip link set lo up");
>>>
>>> The "bool open" could be false here. This command could be acted on 
>>> the > init_netns and the intention is to set lo up at the newly 
>>> created netns.
>>>
>>
>> You are right! I should enclose this call in-between a pair of
>> open_netns() & close_netns().
> 
> I would just move it to make_netns() and do "ip -n nsname link set lo up".
> Yes, the traffic_monitor_start() is after the lo is up but I think it is 
> fine.
> 
> 

Ok!

