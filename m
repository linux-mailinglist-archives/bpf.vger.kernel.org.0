Return-Path: <bpf+bounces-28551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB708BB5DA
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 23:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DB3B245F7
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 21:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF1B60BB6;
	Fri,  3 May 2024 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT+7roT0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BFD282E5
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772093; cv=none; b=Ab3SEgxhociic8ekwntgFbpMIBFzuJtb4DEJvN1lb/095ufyaNL3jWvAy5B8oZ1Hwr/d3rO7djn2z6LTDnqPIaC2RS9dPvTJw6LJL+PUpGSkF3ug2wXdYkBHrbnA5zMsKePwVA1d5xNUEzBNOuL4KJIC+XMWnKAfZatot3Flk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772093; c=relaxed/simple;
	bh=+cwRXud1nvvRG42gYnnZel2DSFDMMCa3uGuOOetjiQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvxEFAhpEadSuK6WhBIjveKfsKCOvHe+DU03mT7vTpes+z0JJxEQWFdNL8Qbp8hCmyi/JYcTlTj8LnUDrGf8IhBb/HV1Cx/sxjtAzHdNcy8GhVDzjjNNhr2p9P+R0PnUjWGxowmaoVaxZr8ZB9D/R48Jq5Pdz1vXwqy7BDAFn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT+7roT0; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ef94f1ce39so45074a34.3
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714772091; x=1715376891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpu+WqRUiNhgglvA21MezTIYkzySrClLbFpTPq/B6MI=;
        b=QT+7roT02pwn/8iheSLDWCYniksjMt+lq1aih5PnMLwLC0GDOLhPuvRVNS88prAU2T
         XvWBtQNFThVlZ5d49dnuCDxcman+uy8TjVVuZ/yijGqDZ52aLhM06Om8/TtcvwAVTANj
         UfdXJAt9wz3nG/1IULoZrGXLoiVA7P2215IzV5GYq92JEdTADJxET0TxUhnWQiLLbwKv
         FKvD4dXYHf+JGOe8Btw4CbB/tGNxuSpj8SYKi6R1sPECiSvWiwgapOjo2I2UKSC8y9fG
         b0O40amMzszJoRX57+Jbs+EWWwMZYTeqCIffoRWlNFFHCLRDhI58BLVKsnTRZdP87VvS
         E+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772091; x=1715376891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpu+WqRUiNhgglvA21MezTIYkzySrClLbFpTPq/B6MI=;
        b=PZkLq+UcWJywkXoP23eJCvPUDdivkRIZr37FdyMRnSiEmlwodrkilS94C5aRr7F3sH
         V8+AdAMlXJ+n9H6vCF4ljQQGE9CjPfDNPLtl4yedh1Z1OWxItVDRlJuQX7vkMoWANLWP
         7TL/Ut+JmcK8e8AP8SMMYSnDSkjyVVC9W+78d0y1WUQH087XsmEPB3AMsNL303rkW20T
         /pk4e5Os25zOvuI53LjHAVHuEabYgJdkQQLNJRMaGkcWtJ61DO0teT3JwWjTgAos1VHc
         xcm56QHUexu+wsQho7DF/CYOMvNNlF5EbTCtZh9UYihoDwNA7ryPeVt7kV96Em2ZTG/6
         ZdKw==
X-Gm-Message-State: AOJu0Yyu+vyM480e7X9UQBTWrkah9+/niNxHX7+6fVu/DUPmhbZRy9Br
	fI+8aoACSWtmnqnpMTj0/AvY+WiJgMTLit3oK5kxbSfiq32FIzh+
X-Google-Smtp-Source: AGHT+IElSk82XEpd9tTJa5W/Qkc7cmnj4DnAO8+70uovZ0/IS6i0x6KfWZ0EFeeo3/lYPzYWcSf3zQ==
X-Received: by 2002:a05:6830:cd:b0:6ee:3b4a:50a with SMTP id x13-20020a05683000cd00b006ee3b4a050amr4509791oto.30.1714772090624;
        Fri, 03 May 2024 14:34:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:e5f6:df83:4297:b62b? ([2600:1700:6cf8:1240:e5f6:df83:4297:b62b])
        by smtp.gmail.com with ESMTPSA id r21-20020a056830419500b006eb84466e68sm774804otu.55.2024.05.03.14.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:34:50 -0700 (PDT)
Message-ID: <33bded73-703d-443d-b428-48a03b3d395d@gmail.com>
Date: Fri, 3 May 2024 14:34:49 -0700
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
 <4462086b-c01a-4733-8a15-7ef0d1f91c2f@gmail.com>
 <4f54cc5e-6864-4ff8-b840-1f93000cb7a7@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <4f54cc5e-6864-4ff8-b840-1f93000cb7a7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/3/24 12:15, Martin KaFai Lau wrote:
> On 5/3/24 11:34 AM, Kui-Feng Lee wrote:
>>
>>
>> On 5/2/24 11:15, Martin KaFai Lau wrote:
>>> On 4/29/24 2:36 PM, Kui-Feng Lee wrote:
>>>> @@ -572,6 +576,12 @@ static int bpf_dummy_reg(void *kdata)
>>>>       if (ops->test_2)
>>>>           ops->test_2(4, ops->data);
>>>> +    if (ops->do_unreg) {
>>>> +        rcu_read_lock();
>>>> +        bpf_struct_ops_kvalue_unreg(kdata);
>>>
>>> Instead of unreg() immediately before the reg() has returned, the 
>>> test should reflect more on how the subsystem can use it in practice. 
>>> The subsystem does not do unreg() during reg().
>>>
>>> It also needs to test a case when the link is created and 
>>> successfully registered to the subsystem. The user space does 
>>> BPF_LINK_DETACH first and  >> then the subsystem does 
>>> link->ops->detach() by itself later.
> 
>>
>> agree
>>
>>>
>>> It can create a kfunc in bpf_testmod.c to trigger the subsystem to do 
>>> link->ops->detach(). The kfunc can be called by a SEC("syscall") bpf 
>>> prog which is run by bpf_prog_test_run_opts(). The test_progs can 
>>> then decide on the timing when to do link->ops->detach() to test 
>>> different cases.
>>
>> What is the purpose of this part?
>> If it goes through link->ops->detach(), it should work just like to call
>> bpf_link_detach() twice on the same link from the user space. Do you
>> want to make sure detaching a link twice work?
> 
> It is not quite what I meant and apparently link detach twice on the 
> same valid (i.e. refcnt non zero) link won't work.
> 
> Anyhow, the idea is to show how the racing case may work in patch 3 
> (when userspace tries to detach and the subsystem tries to detach/unreg 
> itself also). I was suggesting the kfunc idea such that the test_progs 
> can have better control on the timing on when to ask the subsystem to 
> unreg/detach itself instead of having to do the unreg() during the reg() 
> as in patch 6 here. If kfunc does not make sense and there is a better 
> way to do this, feel free to ignore.
> 

Ok! I think the case you are talking more like to happen when the link
is destroyed, but bpf_struct_ops_map_link_dealloc() has not finished
yet. Calling link->ops->detach() at this point may cause a racing since
bpf_struct_ops_map_link_dealloc() doesn't acquire update_mutex.

Calling link->ops->detach() immediately after BPF_LINK_DETACH would not
cause any racing since bpf_struct_ops_map_link_detach() always acquires
update_mutex. They will be executed sequentially, and call
st_map->ops->reg() sequentially as well.

I will add a test case to call link->ops->detach() after close the fd of
the link.


