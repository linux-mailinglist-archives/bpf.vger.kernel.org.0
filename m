Return-Path: <bpf+bounces-70575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 170C5BC3622
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 07:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 796B234FB48
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 05:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE522E8B82;
	Wed,  8 Oct 2025 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="feSfsfl1"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D82E8B9F
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759901476; cv=none; b=Jdz1mA6iGUsBK3nTxlJmwM3UaEfIxLFPaaPyuCnDTVhue3KlKJjQY4MUJTRxaD8yTkeRkT/CU6rWoFlK30hMnVYIUFcrOjBI7CsPzhb2uKBu8lVZ7y2Q1E+OBu03kNN8rup78wcIt+j9zC//jYuA3gKr7niw2L26Ya+ArEUAz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759901476; c=relaxed/simple;
	bh=nkGvsnIZdkqdxRzyjrXnI2+Z/hS3tCuuiWKmtNpayMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHQv4WVyAwatJHx57GEAL+YkeGZe5G3jZCsQnUQJk0D6kFuIwFsDGAqlDYiZFWPs8DYI5LKALOkkv0aoshk5rd1apj4AasGdzW17nYlHkxTebJo9IBEpOBOv9XbndUSXTSHAEtWfQ5PpIwJHAQKWgYUP3In2VJZQKunCm+ite0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=feSfsfl1; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4b64447b-bacd-4f96-bd33-999802d824f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759901471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYQKwN8Dcl7atgKMKojVqKClm36jWsbZgaej3yfl5VQ=;
	b=feSfsfl1iOKPKtZBBLmjvT2+LvlxkbehHLPav+Lxr0HLx7lDbBxf+yLyPqYOFC+uS87Puk
	XA8HAJHcuOZRxX9PO6ASSADeLi8wPp5Opo8WXk/2ewsuYrm8LmaS+vO0+AxVuV5diey8xV
	6jyqSeuyT143M46DW6F/LQ7HRfv7seI=
Date: Wed, 8 Oct 2025 13:31:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_cgroup_storage maps
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net,
 kernel-patches-bot@fb.com
References: <20250930153942.41781-1-leon.hwang@linux.dev>
 <20250930153942.41781-6-leon.hwang@linux.dev>
 <CAEf4BzaVmJ83q5DxKkeJEhNeQ87HDQ7yZjg_PNFWpNEUvAFOnw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzaVmJ83q5DxKkeJEhNeQ87HDQ7yZjg_PNFWpNEUvAFOnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/10/25 06:33, Andrii Nakryiko wrote:
> On Tue, Sep 30, 2025 at 8:40 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Introduce BPF_F_ALL_CPUS flag support for percpu_cgroup_storage maps to
>> allow updating values for all CPUs with a single value for update_elem
>> API.
>>
>> Introduce BPF_F_CPU flag support for percpu_cgroup_storage maps to
>> allow:
>>
>> * update value for specified CPU for update_elem API.
>> * lookup value for specified CPU for lookup_elem API.
>>
>> The BPF_F_CPU flag is passed via map_flags along with embedded cpu info.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---

[...]

>>  int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
>> -                                  void *value)
>> +                                  void *value, u64 map_flags)
>>  {
>>         struct bpf_cgroup_storage_map *map = map_to_storage(_map);
>>         struct bpf_cgroup_storage *storage;
>> @@ -198,12 +198,18 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
>>          * access 'value_size' of them, so copying rounded areas
>>          * will not leak any kernel data
>>          */
>> +       if (map_flags & BPF_F_CPU) {
>> +               cpu = map_flags >> 32;
>> +               memcpy(value, per_cpu_ptr(storage->percpu_buf, cpu), _map->value_size);
> 
> this is so far ok, because we don't seem to allow special fields for
> PERCPU_CGROUP_STORAGE, but it's best to switch this one to
> copy_map_value()
> 

Agreed to use copy_map_value() here.

>> +               goto unlock;
>> +       }
>>         size = round_up(_map->value_size, 8);
>>         for_each_possible_cpu(cpu) {
>>                 bpf_long_memcpy(value + off,
>>                                 per_cpu_ptr(storage->percpu_buf, cpu), size);
> 
> and let's switch this to copy_map_value_long() to future-proof this:
> copy_map_value[_long]() should work correctly with any type of map and
> will take care of all existing and future special fields
> 
> (but maybe have it as a separate patch with just that change to make it obvious)
> 

Ack.

>>                 off += size;
>>         }
>> +unlock:
>>         rcu_read_unlock();
>>         return 0;
>>  }
>> @@ -213,10 +219,11 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
>>  {
>>         struct bpf_cgroup_storage_map *map = map_to_storage(_map);
>>         struct bpf_cgroup_storage *storage;
>> -       int cpu, off = 0;
>> +       void *ptr;
>>         u32 size;
>> +       int cpu;
>>
>> -       if (map_flags != BPF_ANY && map_flags != BPF_EXIST)
>> +       if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_ALL_CPUS))
>>                 return -EINVAL;
>>
>>         rcu_read_lock();
>> @@ -232,12 +239,18 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
>>          * returned or zeros which were zero-filled by percpu_alloc,
>>          * so no kernel data leaks possible
>>          */
>> -       size = round_up(_map->value_size, 8);
>> +       size = (map_flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) ? _map->value_size :
>> +               round_up(_map->value_size, 8);
>> +       if (map_flags & BPF_F_CPU) {
>> +               cpu = map_flags >> 32;
>> +               memcpy(per_cpu_ptr(storage->percpu_buf, cpu), value, size);
>> +               goto unlock;
>> +       }
>>         for_each_possible_cpu(cpu) {
>> -               bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
>> -                               value + off, size);
>> -               off += size;
>> +               ptr = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
>> +               memcpy(per_cpu_ptr(storage->percpu_buf, cpu), ptr, size);
Switch memcpy() to copy_map_value[_long](), too.

Thanks,
Leon

[...]

