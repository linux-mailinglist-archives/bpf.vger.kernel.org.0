Return-Path: <bpf+bounces-69319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E649BB940AB
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C19DA4E117D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 02:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCB91D63C7;
	Tue, 23 Sep 2025 02:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NFsPMb+Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF72749C1
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758595539; cv=none; b=IYgUzihaUvJTz6SO2fNPuRcKgkd1w+ntuc/9t9eMyRUa979dOWUAd6HIOX5hOLtaJJzulIsNf8XhayuYfpnQSofc/cCkGzoBPka9vXjkdOMxpQsi3YyLMKscJP9lHDI5a1UAtwjlSDyt+GfZM0g3KqtGs4ss+sroFdxuO2JFTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758595539; c=relaxed/simple;
	bh=cJTf7lc4nCDyuUaHb26TvqZmzHAhvnEuMqwoXVkpvgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCnndPXLpojeayL1c71H7MgQXvf1HbXsfE5qXR8jL/QLCrIm4YUhhJiSDM9TcnWxy9Nuqb4sjtbt4wedeIjCTmlmOkHXt8C9m4NVTBzrd9MbpGnMDe4GZ5V6gfV0wR9kEc4X3e+kogPAZhvZyn8oZM7hzCUJh/QMraOZ9nl4be0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NFsPMb+Q; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1229077e-ad10-4e38-8312-936bf8bc5222@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758595533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXsMI+cqJnEI8vpZdqTxeQ2cZL72MXqP4mbiT6uyk0s=;
	b=NFsPMb+QSxgPu4UPYMP2z8yygPR/MQQ1BbGVpPbghCXsI4IUclmWDrLp5KQQv6uH/JXrw0
	MmEfVLGZ4KZSuRNgW6tRMcV+r7SXHJQeVpfeq1jJIjaT5yEG2hLwch13F1wI5ncTHYZNY4
	OaABRh4zvbO8ND7ptgsPtrR5aIw9q9s=
Date: Tue, 23 Sep 2025 10:45:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net,
 kernel-patches-bot@fb.com
References: <20250910162733.82534-1-leon.hwang@linux.dev>
 <20250910162733.82534-5-leon.hwang@linux.dev>
 <CAEf4BzZJ3fEd6EaBV5M8QX=bTtL7bx0OM1E3o5HAgCemfuFQEQ@mail.gmail.com>
 <40840553-6c0a-494d-8429-863c4a6608f9@linux.dev>
 <CAEf4BzYTse1=pAYcM6y_vKbm74ZDtSu2Daj3sLewvKz16WF9NA@mail.gmail.com>
 <DCZEVCZLG1IW.2MPQVMF4L3D91@linux.dev>
 <CAEf4BzY8zPBbmjP6ooihyeqeJGdfgdh9KiW3XQGqv1qYWcefXg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzY8zPBbmjP6ooihyeqeJGdfgdh9KiW3XQGqv1qYWcefXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 23/9/25 00:13, Andrii Nakryiko wrote:
> On Mon, Sep 22, 2025 at 7:50 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On Sat Sep 20, 2025 at 6:31 AM +08, Andrii Nakryiko wrote:
>>> On Thu, Sep 18, 2025 at 10:25 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>>
>>>>
>>>>>> @@ -1724,7 +1742,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>>>>>>         value_size = htab->map.value_size;
>>>>>>         size = round_up(value_size, 8);
>>>>>>         if (is_percpu)
>>>>>> -               value_size = size * num_possible_cpus();
>>>>>> +               value_size = (elem_map_flags & BPF_F_CPU) ? size : size * num_possible_cpus();
>>>>>
>>>>> if (is_percpu && !(elem_map_flags & BPF_F_CPU))
>>>>>     value_size = size * num_possible_cpus();
>>>>>
>>>>> ?
>>>>>
>>>>
>>>> After looking at it again, I’d like to keep my approach.
>>>>
>>>> When 'elem_map_flags & BPF_F_CPU' is set, 'value_size' has to be
>>>> assigned to 'size' ('round_up(value_size, 8)') instead of keeping
>>>> 'htab->map.value_size'.
>>>>
>>>
>>> isn't that what will happen here as well? There is
>>>
>>> size = round_up(value_size, 8);
>>>
>>> right before that if
>>>
>>
>> As for percpu maps, both 'size' and 'value_size' need to be 8-byte
>> aligned here, because 'map.value_size' itself is not guarenteed to be
>> aligned.
>>
>> In 'htab_map_alloc_check()', there is no alignment check for percpu
>> maps.
>>
>> So 'map.value_size' can be unaligned.
>>
>> Let's look at how 'value_size' is used:
>>
>> values = kvmalloc_array(value_size, bucket_size, GFP_USER | __GFP_NOWARN);
>> dst_val = values;
>> hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
>>         if (is_percpu) {
>>                 if (elem_map_flags & BPF_F_CPU) {
>>                         copy_map_value_long(&htab->map, dst_val, per_cpu_ptr(pptr, cpu));
>>                 }
>>         }
>>         dst_val += value_size;
>> }
>> copy_to_user(uvalues + total * value_size, values,
>>              value_size * bucket_cnt)
>>
>> Here, 'value_size' determines how values are laid out and copied.
>>
>
> So in my mind (and maybe it's wrong, tell me), BPF_F_CPU turns a
> per-CPU map lookup into an effectively non-per-cpu one. So I'm not
> sure we need to do 8 byte alignment of value/key sizes when BPF_F_CPU
> is specified.
>
> But if people would like to keep 8 byte alignment anyways for
> BPF_F_CPU, that's fine too, I guess.
>

'value_size' should be 8-byte aligned here.

For example, if 'value_size' is *1* when BPF_F_CPU is specified:

values = kvmalloc_array();  /* 5 bytes (value_size * bucket_size) memory */
copy_map_value_long();      /* copies 8 bytes, writing past the
                               allocated 5 bytes of memory */

To stay consistent with 'copy_map_value_long()', 'value_size' itself
needs to be 8-byte aligned.

That leaves us with two options:

1. Keep 'value_size' unaligned, switch 'copy_map_value_long()' to
   'copy_map_value()'.
2. Require 'value_size' to be 8-byte aligned.

WDYT?

Thanks,
Leon

