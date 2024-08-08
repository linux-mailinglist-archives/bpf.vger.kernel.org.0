Return-Path: <bpf+bounces-36717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7516894C5D2
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 22:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D00B1C2227A
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96BC157484;
	Thu,  8 Aug 2024 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a24lEQcL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEF144D27
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149533; cv=none; b=AOTcIW53hCaCVbrSKED23t7AjsY9wftjVE0mJQT8HbNmEj0QJQJMU4dh1eJFtX2URYb3lBbzzJVYpGbUTrhA8VRaKtStZ9UFO4MRAeKsMha4FtbWLjdcm5SbY2UYne4S8oxRR6VFfeSclQTzR6jjYCBI3AUirkrq9tosc611OhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149533; c=relaxed/simple;
	bh=9Vtb1YzVHhA8pxHMepcUJ/rX0dGi83C5TeOdlulV+9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdYBfk59nRrucqrjr6cKQ26BFzCRqcRTZsC97Daf5SkJtVqmfI6vJ6XIrvn9Ex0KVtfunSmck1qL4eOMMHbPEqZa3CUn7JsfVCnrPQB24X2kVoFqXAfUUB+AJ7IO56ekYqzhPikZjy7aVQObkqqIt+DN0ABnpIVSWoz8wYeudqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a24lEQcL; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e026a2238d8so1271925276.0
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723149531; x=1723754331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvgBZN/dAEuOwYVjHeunxy+/KGHBIJbyhtyj/vdaGGg=;
        b=a24lEQcLWvqbL+5b/aX4KRnQ9bEafohVGnhNn2jhzdZxgSc2L/z4s70xjANraE1Gvh
         SRLLdRwa2mk+LPo/d9tyvLDxpzfcmdGrCczIOQkbijblhTk2V8Qt70EMg0nMEJFayKD/
         BUOivPF/84PHwW4ey09c6Cs5LNKYGC98xC0bT+oCAY4aSSb2Dh7uobY/aF9suIyUYNI1
         a4Oy+G7E7wwPqVfxKHfz/0M3jNCw0CUCSAPTW4rQhBSljhdtV8nIT7hunJbr1R1kMaj5
         H7cqgxQLs3xoF1Yk0jF/uDo1exfDU3z65+qBtYeDFQNkW0FTCNberjF0G08pt/l3wlz6
         LYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723149531; x=1723754331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvgBZN/dAEuOwYVjHeunxy+/KGHBIJbyhtyj/vdaGGg=;
        b=CQBswoC9Sl13nzER+auj1K9MMEugtzMS4mO7yxBPTp9l80Q4cLJJCAmstUTKjwN0ci
         7YDl8RtWAplwTWpU97jnSa0OtCGvhQDeDxJBrJhHe9Z93AWS9DzYdrXg9bDOMTbPMzmP
         7bP6sLKLtawjLsam4B5ETBeqA9f9eSb9PcGg+PTWsevANbSwMIOc8SJ1QMlBxC+Pgukp
         Sa/MgPlaOmyIOyd9su3o6DKN7PRNNO+fN+fFhwUw89r8FdweNEesHHqP3cq63zOpJfVH
         hZ3SQJiST2+KTSy+7CYwa78sxB/CRZkb3W/0IGbty/y1ngStobO5yL/H547l2va+GRyQ
         RQ3A==
X-Gm-Message-State: AOJu0YxFk0oP/Crvd63Kaxe4GfTsOLnoDnaCTyHkqQa32dTzH6shw8L4
	1qhmV1MpvEvMy0p6ZaLmfIMr3YJ37JCS2+xl0qMduSBwl7ialFWf
X-Google-Smtp-Source: AGHT+IFHmWNO3WtnWC2QXGeIb7Q08zM4ByUlstQ5tpv8k0DzwmdYvk6YljCj57xhxaQMzCVxsiqAwQ==
X-Received: by 2002:a05:6902:120f:b0:e08:62e5:8d6a with SMTP id 3f1490d57ef6-e0e9dcbce23mr3928762276.52.1723149530607;
        Thu, 08 Aug 2024 13:38:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:fa3a:53c6:c704:2cc7? ([2600:1700:6cf8:1240:fa3a:53c6:c704:2cc7])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be5563adesm2666334276.42.2024.08.08.13.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 13:38:50 -0700 (PDT)
Message-ID: <ebf9d37a-ce27-44ab-a4da-312c73f8b6d7@gmail.com>
Date: Thu, 8 Aug 2024 13:38:48 -0700
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
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <da9922b7-c5f3-4a33-a707-14672a8a30dd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/8/24 13:27, Martin KaFai Lau wrote:
> On 8/7/24 11:31 AM, Kui-Feng Lee wrote:
>> +struct netns_obj *netns_new(const char *nsname, bool open)
>> +{
>> +    struct netns_obj *netns_obj = malloc(sizeof(*netns_obj));
>> +    const char *test_name, *subtest_name;
>> +    int r;
>> +
>> +    if (!netns_obj)
>> +        return NULL;
>> +    memset(netns_obj, 0, sizeof(*netns_obj));
>> +
>> +    netns_obj->nsname = strdup(nsname);
>> +    if (!netns_obj->nsname)
>> +        goto fail;
>> +
>> +    /* Create the network namespace */
>> +    r = make_netns(nsname);
>> +    if (r)
>> +        goto fail;
>> +
>> +    /* Set the network namespace of the current process */
>> +    if (open) {
>> +        netns_obj->nstoken = open_netns(nsname);
>> +        if (!netns_obj->nstoken)
>> +            goto fail;
>> +    }
>> +
>> +    /* Start traffic monitor */
>> +    if (env.test->should_tmon ||
>> +        (env.subtest_state && env.subtest_state->should_tmon)) {
>> +        test_name = env.test->test_name;
>> +        subtest_name = env.subtest_state ? env.subtest_state->name : 
>> NULL;
>> +        netns_obj->tmon = traffic_monitor_start(nsname, test_name, 
>> subtest_name);
> 
> The traffic_monitor_start() does open/close_netns(). close_netns() will 
> restore to the previous netns. Is it better to do 
> traffic_monitor_start() before the above open_netns() such that we don't 
> have to worry about the stacking open_netns and which netns the 
> close_netns will restore?

Do you mean to open_netns() in another thread at the same time and
interleave with the open_netns()/close_netns() pairs in the current thread?

> 
> 
>> +        if (!netns_obj->tmon)
>> +            fprintf(stderr, "Failed to start traffic monitor for 
>> %s\n", nsname);
>> +    } else {
>> +        netns_obj->tmon = NULL;
>> +    }
>> +
>> +    system("ip link set lo up");
> 
> The "bool open" could be false here. This command could be acted on the > init_netns and the intention is to set lo up at the newly created netns.
> 

You are right! I should enclose this call in-between a pair of
open_netns() & close_netns().

>> +
>> +    return netns_obj;
>> +fail:
>> +    close_netns(netns_obj->nstoken);
>> +    remove_netns(nsname);
>> +    free(netns_obj->nsname);
>> +    free(netns_obj);
>> +    return NULL;
>> +}
>> +
>> +/* Delete the network namespace.
>> + *
>> + * This function should be paired with netns_new() to delete the 
>> namespace
>> + * created by netns_new().
>> + */
>> +void netns_free(struct netns_obj *netns_obj)
>> +{
>> +    if (!netns_obj)
>> +        return;
>> +    if (netns_obj->tmon)
>> +        traffic_monitor_stop(netns_obj->tmon);
>> +    close_netns(netns_obj->nstoken);
>> +    remove_netns(netns_obj->nsname);
>> +    free(netns_obj->nsname);
>> +    free(netns_obj);
>> +}
>> +
>>   /* extern declarations for test funcs */
>>   #define DEFINE_TEST(name)                \
>>       extern void test_##name(void) __weak;        \
>> diff --git a/tools/testing/selftests/bpf/test_progs.h 
>> b/tools/testing/selftests/bpf/test_progs.h
>> index 966011eb7ec8..3ad131de14c6 100644
>> --- a/tools/testing/selftests/bpf/test_progs.h
>> +++ b/tools/testing/selftests/bpf/test_progs.h
>> @@ -430,6 +430,10 @@ int write_sysctl(const char *sysctl, const char 
>> *value);
>>   int get_bpf_max_tramp_links_from(struct btf *btf);
>>   int get_bpf_max_tramp_links(void);
>> +struct netns_obj;
>> +struct netns_obj *netns_new(const char *name, bool open);
>> +void netns_free(struct netns_obj *netns);
>> +
>>   #ifdef __x86_64__
>>   #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
>>   #elif defined(__s390x__)
> 

