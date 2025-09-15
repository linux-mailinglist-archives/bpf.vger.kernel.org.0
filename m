Return-Path: <bpf+bounces-68435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3539B585FB
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C332A42F8
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3104E28DB46;
	Mon, 15 Sep 2025 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qmg6Z6fN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141AC1D618E
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967653; cv=none; b=hgUlM6+LEpTDYYVS1thw5OLvNPsl5ai5IpFEHdyEtFt5j1tDg69Kg79lLN/3Um0HoQBjQdTUn+CUq/GXnbHNmS5q6J1r2WZcn2QZt9L2kOij85/E78sT6ERp6MvgjXwwxIAIBZo3xGTo2qq6kmTC1WMv9bNrZ2II1Yt5DmybJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967653; c=relaxed/simple;
	bh=oVhSz5AMbjXa9tTLyj9zNm+F/ODayBsS1cR3q2+c2No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkP1SOwFSG/SCZJg+Et8/9oLNiS6KdyxwBP3rV1xSZZB/DtDNRqJC3ve9gjEbDCTzLclMY5o+CzAmHF4HWcTByprlcI1YeTVt0rbRuXWL7ce/azrN8Lr74arrWC6QfJaMTDJt1fOWf1UXUVUV0qsJHBLsiU99Ci0QSlnufuZcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qmg6Z6fN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so41344765e9.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967649; x=1758572449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+aihuX6ocCUq7pXgQKKGif5UZhBIWRm8URJg7StB/pA=;
        b=Qmg6Z6fN3SY+DZWr8J+8dTKDu5s6irhHG4JUIUSdeosqICrjhzpL8V7iG/op5RKulK
         GJ+6TXpNNg+I36UtZJCvhE5XtMW4aHbULB20vGTOGBsek9sVLMYePaKGcsjHNqYXCh1r
         +o8fduI89IUP27Wl701KQIArhLkxvtR39N50CO57QUhab3ogpdy6rxBV5Bqt+WfQevRb
         fc8hakKi5Vd1r6kIQewnzOuIaJ8APXowrIRDW/8TjndjaH97xaWUNQiBCGcT/GRJl/lC
         exqDDYAio+x59BmgMxbE1yECX6gkKtIfjfEEbuSALcIYdmYGH6g555nK+EjJzYPGC9V3
         i3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967649; x=1758572449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+aihuX6ocCUq7pXgQKKGif5UZhBIWRm8URJg7StB/pA=;
        b=X8CfvLrM3JQ91jZfvBJkbA/0gNLzy0rU2oMYaoorj04thB1coVckicEa5c0H7ULgOF
         PZ0b6f9f26uZGol+0vfzyFZGfuNraNoeXk7MvwNf7/59SXjNW9L1ILK2DLxjJsSX72yY
         cKn8JY44vWXjg2WHxoRYU5nLh4w3NKi30i+MJFCEuToja97eymh6RPF9T0SwOhIdC0H/
         K+ON+0pOnk4Nht/cBN5q7EgYaefkpLAVg/ZiTnIR/Wc8NTX0C92CDSD8+NjpUibzzHZs
         LZAxj4qFx+CERQmZqjMZKICr8sWx/Myk162uCJn5jaEGJ5CTji/rGbiq6IAje9FxdtQ/
         5cQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9L00HGmekfk1j98IniCVdWrVZvrSZcOgICh0/IPyo55J9GUFOlcbfYl5bL7pfwjlHpNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfDSnIcUhzFxOsQcgi9+BQT0QOpFsYeoDku35PIFueXD4Lylr
	Ck9+oi+sHbVDVUmMhE2+2AA+28bawa/mxz9Ot4UCk0TGJerb4i6Wz43K
X-Gm-Gg: ASbGncvub/6A36sLHvNSRPpdUkHKNUdjBry6fmiCVCIoEyhfqbMpvV4ia40RzTOOeOD
	EpclfiEbZhJNU+OaHyJ0vr6cL/TYgUWkyimwimHMl9oPWetDR60L0mUhkr6jpjkvea8N6tFRY6f
	0tdjaX5k0ba2dIs2tnv4rZs5hHoiS9+02D1Jn7e9QamiZfmZQr/AaiAXmGGRr20qIYiNA9h4BMk
	BegKUU9czp0UDcwdKY3SKMIVrU6to+L+8cm2IeHUJe/FwY1W1G7efcmeqPIc26jiJ6VD1bG+2M/
	+FKXcedR2f0ADTky8iVfNQG77IiQL9vKo+lvm0/ye1ksYu1/M4pyymBk3YQO0atZSIbfGXJMX/L
	yMou0HrzUTvxEDVrcefC4RqU8p2mvixaRrV7ERH9FMGE7vfzCQQYDW86OwmEd
X-Google-Smtp-Source: AGHT+IFyjwUZaMRcAYiJ8B0Pg9ElDPaFI1t9sKzigKeLdXkFfYSDVlCUlx7Is+iv8tasAeox/pX4Bw==
X-Received: by 2002:a05:600c:4755:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-45f212933ebmr118447025e9.15.1757967649329;
        Mon, 15 Sep 2025 13:20:49 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4eb3:9189:a7fd:1180? ([2620:10d:c092:500::6:388e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d638dsm185618125e9.22.2025.09.15.13.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 13:20:48 -0700 (PDT)
Message-ID: <bd078587-04a8-4573-bb5d-117196677468@gmail.com>
Date: Mon, 15 Sep 2025 21:20:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/7] bpf: bpf task work plumbing
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-5-mykyta.yatsenko5@gmail.com>
 <c67790c49ae9ce4e1f34df324ab0b217ab867f03.camel@gmail.com>
 <ac73378d-290c-4ab0-a604-6de693ce6c6f@gmail.com>
 <CAEf4BzZBRkqb0VQM1ejV=O=HKPi3NL4yK+=_PGeWezpgLb1vQw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzZBRkqb0VQM1ejV=O=HKPi3NL4yK+=_PGeWezpgLb1vQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/15/25 21:12, Andrii Nakryiko wrote:
> On Mon, Sep 15, 2025 at 8:59 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> On 9/6/25 00:09, Eduard Zingerman wrote:
>>> On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
>>>
>>> [...]
>>>
>>>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>>>> index 3d080916faf9..4130d8e76dff 100644
>>>> --- a/kernel/bpf/arraymap.c
>>>> +++ b/kernel/bpf/arraymap.c
>>> [...]
>>>
>>>> @@ -439,12 +439,14 @@ static void array_map_free_timers_wq(struct bpf_map *map)
>>>>       /* We don't reset or free fields other than timer and workqueue
>>>>        * on uref dropping to zero.
>>>>        */
>>>> -    if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE)) {
>>>> +    if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
>>> I think that hashtab.c:htab_free_internal_structs needs to be renamed
>>> and called here, thus avoiding code duplication.
>> Sorry for the delayed follow up on this, just was trying to do it. I'm
>> not sure if it is possible
>> to reuse anything from hashtab in arraymap at the moment, there is no
>> header file for hashtab.
>> If we are going to introduce a new file to facilitate code reuse between
>> maps, maybe we should go for
>> map_intern_helpers.c/h or something like that. WDYT?
> no need for new files, just use include/linux/bpf.h (internal header)
> and kernel/bpf/helpers.c or kernel/bpf/syscall.c (whichever makes more
> sense and contains other map-related helpers)
Thanks, I've just sent v4 without this. Will include in v5 or send 
refactoring in a separate patch.
>
>>>>               for (i = 0; i < array->map.max_entries; i++) {
>>>>                       if (btf_record_has_field(map->record, BPF_TIMER))
>>>>                               bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
>>>>                       if (btf_record_has_field(map->record, BPF_WORKQUEUE))
>>>>                               bpf_obj_free_workqueue(map->record, array_map_elem_ptr(array, i));
>>>> +                    if (btf_record_has_field(map->record, BPF_TASK_WORK))
>>>> +                            bpf_obj_free_task_work(map->record, array_map_elem_ptr(array, i));
>>>>               }
>>>>       }
>>>>    }
>>> [...]
>>>
> [...]


