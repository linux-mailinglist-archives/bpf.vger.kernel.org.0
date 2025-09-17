Return-Path: <bpf+bounces-68671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FCDB805B0
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 17:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11E094E31B4
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60807335922;
	Wed, 17 Sep 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j0Qm89mB"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84891F9F70
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121459; cv=none; b=G7xsb9vScNlqZP3Tt5UFsJwQ4sk5PfkvLmpMHgXMlPJ8wuJhYiiDX+javRcZpaxqIkZr/1RRCKEYi6nYtiBUl/D2HxYSy7lh8v5kv/1mp6Fy2ohXtRtWkiSQhW7ljtDHEJj1FwzdV1LFLHOzEAGK2jQDN6+puLHZTOTROVlEMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121459; c=relaxed/simple;
	bh=GX5NrIfIAOUmZ/eOlfovSF1AUAW61m4HMC6Vvs6750E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Me33rKCZsjwTz0r+jESE6zdOM4xka9p+gUdvE9h5jFz1XV3GwXTHW7G8rLNK3JE2e3SMeEBw8pu7fUVPoSjMPf4ZQVwhOLu2CZCUvSe7ZAOh0BHcwHiHkYz6Irx1LJiq61pgtxFDeubEsyWaT+PkJILW5ceU2cOtqHNmvKKqOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j0Qm89mB; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758121451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYrz7Ak/1t1R9m4IRV6IKtUlLyVTLmx5gwMJlsySbO8=;
	b=j0Qm89mB5kkGZDmxUNAPrA5jYyKqFDTBZKqhzLxmdbGBMBFHBFvP5RIl7XNxVE+ByLx3Un
	1fyXAQI5E0T1SQ1EEb0fjNpdL1Jp5er08LpTp6SJisBD2hqlnBNffE2t0PdbuEPvJy9Br1
	NvDaet2fD5LKnfg2ijeaO+ZE7u9aVm8=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Sep 2025 23:04:03 +0800
Message-Id: <DCV61D159UAO.1Q81016E9ENBL@linux.dev>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <jolsa@kernel.org>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v7 3/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_array maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
References: <20250910162733.82534-1-leon.hwang@linux.dev>
 <20250910162733.82534-4-leon.hwang@linux.dev>
 <CAEf4Bzb2WMEbw0x7RQQh6v43_OUcXGX-W_uDPGc6zO6nO5ZdXQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb2WMEbw0x7RQQh6v43_OUcXGX-W_uDPGc6zO6nO5ZdXQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed Sep 17, 2025 at 7:44 AM +08, Andrii Nakryiko wrote:
> On Wed, Sep 10, 2025 at 9:28=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>
>> Introduce support for the BPF_F_ALL_CPUS flag in percpu_array maps to
>> allow updating values for all CPUs with a single value for both
>> update_elem and update_batch APIs.
>>
>> Introduce support for the BPF_F_CPU flag in percpu_array maps to allow:
>>
>> * update value for specified CPU for both update_elem and update_batch
>> APIs.
>> * lookup value for specified CPU for both lookup_elem and lookup_batch
>> APIs.
>>
>> The BPF_F_CPU flag is passed via:
>>
>> * map_flags of lookup_elem and update_elem APIs along with embedded cpu
>> info.
>> * elem_flags of lookup_batch and update_batch APIs along with embedded
>> cpu info.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h   |  9 +++++++--
>>  kernel/bpf/arraymap.c | 24 +++++++++++++++++++++---
>>  kernel/bpf/syscall.c  |  2 +-
>>  3 files changed, 29 insertions(+), 6 deletions(-)
>>
>
> [...]
>
>>
>> -int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
>> +int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, =
u64 map_flags)
>>  {
>>         struct bpf_array *array =3D container_of(map, struct bpf_array, =
map);
>>         u32 index =3D *(u32 *)key;
>> @@ -313,11 +313,18 @@ int bpf_percpu_array_copy(struct bpf_map *map, voi=
d *key, void *value)
>>         size =3D array->elem_size;
>>         rcu_read_lock();
>>         pptr =3D array->pptrs[index & array->index_mask];
>> +       if (map_flags & BPF_F_CPU) {
>> +               cpu =3D map_flags >> 32;
>> +               copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
>> +               check_and_init_map_value(map, value);
>> +               goto unlock;
>
> goto is not how I'd structure this logic, I think if/else is a more
> logical structure here, but this works, I suppose...
>

My intention is to avoid putting the existing code inside a new 'else'
block, even if it would only affect indentation.

This way, the original code block stays intact, and git-blame will still
point to the commit that introduced it.

>> +       }
>>         for_each_possible_cpu(cpu) {
>>                 copy_map_value_long(map, value + off, per_cpu_ptr(pptr, =
cpu));
>>                 check_and_init_map_value(map, value + off);
>>                 off +=3D size;
>>         }
>> +unlock:
>>         rcu_read_unlock();
>>         return 0;
>>  }
>> @@ -390,7 +397,7 @@ int bpf_percpu_array_update(struct bpf_map *map, voi=
d *key, void *value,
>>         int cpu, off =3D 0;
>>         u32 size;
>>
>> -       if (unlikely(map_flags > BPF_EXIST))
>> +       if (unlikely((u32)map_flags > BPF_F_ALL_CPUS))
>
> this will let through BPF_F_LOCK, no? which is not what you intended,
> right? So you need to check for
>
> (map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS
>

Right.

I'll update it in next revision.

Thanks,
Leon

