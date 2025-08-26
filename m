Return-Path: <bpf+bounces-66549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC8FB36CE7
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 17:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE451C238EC
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3201E223DEC;
	Tue, 26 Aug 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kv7gt8fd"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B61FC0EA
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219527; cv=none; b=JTNhZcuScK5T2mll3knNuEI6O4RdIQRamcyzutLpj0GdVMfbyg6c2tzsZA2MekEqjrvIND5fTc88k8GCdRDCVAD3Llg9KAmLV0m4Q9suA4RdrefXTawP5Tl69WbqdWFnGlmZBvPdmdwB4X5m8LqK/eHL0w4+6VxgZv+LoBmbQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219527; c=relaxed/simple;
	bh=5304WYEE3EDGSroh212J5y3xJCVy1yugquIYufTzoWM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=UW818wtj7rHO+q3GxaKaWZdAe2Dd496aSWjKpsI54mF4DumiiHs72uY7k7Qcv0Fn0PGp6P5NgzccKvVi9ySok1j+ypOoVLZR7PFPWZ/meZ5OO9FKmdFdtZGYGPa9xT3S+5h1Ols/HYSZYROJBEDYi18JqdxA82+tHsQgbJu2T1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kv7gt8fd; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756219523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEmpKQrDLOpW+nRlrJgP/FZ6BcrOI+NKqKZP8Mg9la0=;
	b=kv7gt8fd8VIbqE6BxztQwcK5rkPm0oQBLJ1sLsFJ6U4itdVUsMA5Ai8Hm6Vd+sVj/quvD7
	TFt1gaqlkst8NAGezgcCZe72xMoqa4zG3ZnE711AhvpzByNHsXaozT/RLkXAThZfJ+agJG
	2+wBllKmy7RpwvMMnmAG/+arX+22zzE=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 22:45:05 +0800
Message-Id: <DCCFUUONZ808.1VU6LKUV5EMDQ@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <olsajiri@gmail.com>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Introduce BPF_F_CPU flag for
 percpu_array maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
References: <20250821160817.70285-1-leon.hwang@linux.dev>
 <20250821160817.70285-3-leon.hwang@linux.dev>
 <CAEf4BzZnCudvoFd9WJ+sTJ63txxWi=h_0FmVz2HKPXCeqp6zbQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZnCudvoFd9WJ+sTJ63txxWi=h_0FmVz2HKPXCeqp6zbQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat Aug 23, 2025 at 6:14 AM +08, Andrii Nakryiko wrote:
> On Thu, Aug 21, 2025 at 9:08=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>
>> Introduce support for the BPF_F_ALL_CPUS flag in percpu_array maps to
>> allow updating values for all CPUs with a single value.
>>
>> Introduce support for the BPF_F_CPU flag in percpu_array maps to allow
>> updating value for specified CPU.
>>
>> This enhancement enables:
>>
>> * Efficient update values across all CPUs with a single value when
>>   BPF_F_ALL_CPUS is set for update_elem and update_batch APIs.
>> * Targeted update or lookup for a specified CPU when BPF_F_CPU is set.
>>
>> The BPF_F_CPU flag is passed via:
>>
>> * map_flags of lookup_elem and update_elem APIs along with embedded cpu
>>   field.
>> * elem_flags of lookup_batch and update_batch APIs along with embedded
>>   cpu field.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h            |  3 +-
>>  include/uapi/linux/bpf.h       |  2 ++
>>  kernel/bpf/arraymap.c          | 56 ++++++++++++++++++++++++++--------
>>  kernel/bpf/syscall.c           | 27 ++++++++++------
>>  tools/include/uapi/linux/bpf.h |  2 ++
>>  5 files changed, 67 insertions(+), 23 deletions(-)
>>
>
> [...]
>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 19f7f5de5e7dc..6251ac9bc7e42 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -131,9 +131,11 @@ bool bpf_map_write_active(const struct bpf_map *map=
)
>>         return atomic64_read(&map->writecnt) !=3D 0;
>>  }
>>
>> -static u32 bpf_map_value_size(const struct bpf_map *map)
>> +static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
>>  {
>> -       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
>> +       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY && (flags & (=
BPF_F_CPU | BPF_F_ALL_CPUS)))
>> +               return round_up(map->value_size, 8);
>
> this doesn't depend on the PERCPU_ARRAY map type, right? Any map for
> which we allowed BPF_F_CPU or BPF_F_ALL_CPUS would use this formula?
> (and if map doesn't support those flags, you should have filtered that
> out earlier, no?) So maybe add this is first separate condition before
> all this map type specific logic?
>

Right.

I will remove this map type specific logic in next revision.

>> +       else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
>>             map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
>>             map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
>>             map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
>> @@ -314,7 +316,7 @@ static int bpf_map_copy_value(struct bpf_map *map, v=
oid *key, void *value,
>>             map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH) {
>>                 err =3D bpf_percpu_hash_copy(map, key, value);
>>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
>> -               err =3D bpf_percpu_array_copy(map, key, value);
>> +               err =3D bpf_percpu_array_copy(map, key, value, flags);
>>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORA=
GE) {
>>                 err =3D bpf_percpu_cgroup_storage_copy(map, key, value);
>>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_STACK_TRACE) {
>> @@ -1656,12 +1658,19 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 =
key_size)
>>
>>  static int check_map_flags(struct bpf_map *map, u64 flags, bool check_f=
lag)
>
> you are later moving this into bpf.h header, so do it in previous
> patch early on, less unnecessary code churn and easier to review
> actual changes to that function in subsequent patches
>

Ack.

Thanks,
Leon

[...]

