Return-Path: <bpf+bounces-62172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E80AF6010
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFF37B101B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149DE1F1921;
	Wed,  2 Jul 2025 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bhve2+/0"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AAE2F50B2
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477577; cv=none; b=NYo3/5Lc5LCUzZi3aEJvWvao9bkMlHI37C1zkUL+GTinDaJcaPBPFIcgdqnJCOrYWri+q2OKerf26ASZkFsLhhVTBfbHWIyCfBbX+RXPcNXMAnNuyFOQt2scd3qKo7GxWY7gxyYh+wfsGBPrIHXmgS47A2O92eid80GdVfTcG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477577; c=relaxed/simple;
	bh=K6jaDKe4zFxdh6EvhmI1iBvnyllXsoZsFHZvqES+664=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQVT6gpi4lWoto2js/TcqRARc5MQAdyiRTTER+5OTf7Z0o9Di/WWOgz36wLpKOLCzHtf3HZGWnWFYgKySVmyqOvlFNwqjwk4K+gD7kaXO2Yz1+47RYW0IbUCJKgKhI5gzJEVx2eG0zeFUgrHTmMNAkFBqm1i+DxP9rxyN4DpCUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bhve2+/0; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f69609ad-d277-46fd-933d-d8838353ff01@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751477573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfsk2qaxKdjlRNBkRJSti+nnqVf64Za6ALOOOT+Og4E=;
	b=Bhve2+/067MBANHAVrFObsuEWa/OkAYWDqKRotTyJGTFODzICCXIhU2WNoAb4fPdshyl/9
	sJ1JFkE+f6XGGslkvZoeqgzJNJPrqzs8FCGOWRlY9dyq2qc46q3qKSS4hqH9k4BE3cvnHS
	dQpZEr81RVwFpe/GSJjX+r/mw8O7ENI=
Date: Thu, 3 Jul 2025 01:32:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 2/3] bpf, libbpf: Support BPF_F_CPU for
 percpu_array map
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net
References: <20250624165354.27184-1-leon.hwang@linux.dev>
 <20250624165354.27184-3-leon.hwang@linux.dev>
 <CAEf4BzagyjD3LAc3s=w=TbVrqxKWJ=t6Enu6s6BN8cAu3Vmzyw@mail.gmail.com>
 <1135ef3d-1fec-40f6-b2c1-446325951b2d@linux.dev>
 <CAEf4BzbsN3E467efA3Wu1TMwW+J=6ZMgtF7H490_waec32Grgg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzbsN3E467efA3Wu1TMwW+J=6ZMgtF7H490_waec32Grgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/3 01:30, Andrii Nakryiko wrote:
> On Wed, Jul 2, 2025 at 10:28 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 2025/7/2 04:22, Andrii Nakryiko wrote:
>>> On Tue, Jun 24, 2025 at 9:55 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>> This patch adds libbpf support for the BPF_F_CPU flag in percpu_array maps,
>>>> introducing the following APIs:
>>>>
>>>> 1. bpf_map_update_elem_opts(): update with struct bpf_map_update_elem_opts
>>>> 2. bpf_map_lookup_elem_opts(): lookup with struct bpf_map_lookup_elem_opts
>>>> 3. bpf_map__update_elem_opts(): high-level wrapper with input validation
>>>> 4. bpf_map__lookup_elem_opts(): high-level wrapper with input validation
>>>>
>>>> Behavior:
>>>>
>>>> * If opts->cpu == 0xFFFFFFFF, the update is applied to all CPUs.
>>>> * Otherwise, it applies only to the specified CPU.
>>>> * Lookup APIs retrieve values from the target CPU when BPF_F_CPU is used.
>>>>
>>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>>> ---
>>>>  tools/lib/bpf/bpf.c           | 37 +++++++++++++++++++++++
>>>>  tools/lib/bpf/bpf.h           | 35 +++++++++++++++++++++-
>>>>  tools/lib/bpf/libbpf.c        | 56 +++++++++++++++++++++++++++++++++++
>>>>  tools/lib/bpf/libbpf.h        | 45 ++++++++++++++++++++++++++++
>>>>  tools/lib/bpf/libbpf.map      |  4 +++
>>>>  tools/lib/bpf/libbpf_common.h | 12 ++++++++
>>>>  6 files changed, 188 insertions(+), 1 deletion(-)
>>>>
> 
> [...]
> 
>>>>  };
>>>> -#define bpf_map_batch_opts__last_field flags
>>>> +#define bpf_map_batch_opts__last_field cpu
>>>>
>>>>
>>>>  /**
>>>> @@ -286,6 +315,10 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
>>>>   *    Update spin_lock-ed map elements. This must be
>>>>   *    specified if the map value contains a spinlock.
>>>>   *
>>>> + * **BPF_F_CPU**
>>>> + *    As for percpu map, update value on all CPUs if **opts->cpu** is
>>>> + *    0xFFFFFFFF, or on specified CPU otherwise.
>>>> + *
>>>>   * @param fd BPF map file descriptor
>>>>   * @param keys pointer to an array of *count* keys
>>>>   * @param values pointer to an array of *count* values
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index 6445165a24f2..30400bdc20d9 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -10636,6 +10636,34 @@ int bpf_map__lookup_elem(const struct bpf_map *map,
>>>>         return bpf_map_lookup_elem_flags(map->fd, key, value, flags);
>>>>  }
>>>>
>>>> +int bpf_map__lookup_elem_opts(const struct bpf_map *map, const void *key,
>>>> +                             size_t key_sz, void *value, size_t value_sz,
>>>> +                             const struct bpf_map_lookup_elem_opts *opts)
>>>> +{
>>>> +       int nr_cpus = libbpf_num_possible_cpus();
>>>> +       __u32 cpu = OPTS_GET(opts, cpu, nr_cpus);
>>>> +       __u64 flags = OPTS_GET(opts, flags, 0);
>>>> +       int err;
>>>> +
>>>> +       if (flags & BPF_F_CPU) {
>>>> +               if (map->def.type != BPF_MAP_TYPE_PERCPU_ARRAY)
>>>> +                       return -EINVAL;
>>>> +               if (cpu >= nr_cpus)
>>>> +                       return -E2BIG;
>>>> +               if (map->def.value_size != value_sz) {
>>>> +                       pr_warn("map '%s': unexpected value size %zu provided, expected %u\n",
>>>> +                               map->name, value_sz, map->def.value_size);
>>>> +                       return -EINVAL;
>>>> +               }
>>>
>>> shouldn't this go into validate_map_op?..
>>>
>>
>> It should.
>>
>> However, to avoid making validate_map_op really complicated, I'd like to
>> add validate_map_cpu_op to wrap checking cpu and validate_map_op.
> 
> validate_map_op is meant to handle all the different conditions, let's
> keep all that in one function
> 

Got it.

Thanks,
Leon



