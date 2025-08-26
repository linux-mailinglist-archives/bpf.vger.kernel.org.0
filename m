Return-Path: <bpf+bounces-66553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77EB36DE7
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 17:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D4C1BA7AC8
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 15:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267362C1584;
	Tue, 26 Aug 2025 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BgDyuEV0"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1FB2836F
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222544; cv=none; b=IIdl8nE3joC9XPXXEmWr3+9+eF6g0NzMzWK1679b7YKkbhsBQ5xaGecx/tnJn2uQvexU4DhNd5Q7qBi6T487ZAXxsiHoXH+SbNw4ySwrD/CJjIJwe5nnh0J1p3X9dFbOYl1Twqisea4XGk1rIZx7zqhyBlMM218eKWTSm052cf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222544; c=relaxed/simple;
	bh=1IZKhw6Rm0ezfGlbhTyMbH8clFslTIymkmIRafxE6Ss=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SPT4rvX6aEye4zSmfoV/x3sl6I3Vts/wLytwOQIUbfIYqVa6hHLalflO6wlfmnmc4CrkmRReJ5nFSa6AeJp67Dz6BHKBY+kbvx2fig6Y1ynpZ7plERwreR1rmeaZYvGfC0BpgmebubrVxRwb/NTt/FaLialIYtJL1YDwRJ3xDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BgDyuEV0; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756222539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQa+1g061RVwWiwmAkQ0X26AR17iYbbUy+l2kcP/jSs=;
	b=BgDyuEV0TDtKiueAusc85j2h7vcPRBLWz4x3wctDv7fsGQhLfYKJxSrS7E7vafndULQatK
	6NXF2dqV7Kn8+9axl2vBcxDTlm6IsIi5DzerzM9euWMiyrNoBSUXLPr9OHxtnUPjf1OUaw
	6roHKMQXDl8Yeh4EuHnDn0c/LUNC5o8=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 23:35:27 +0800
Message-Id: <DCCGXF27DYLC.1J21FLM3YZZ1A@linux.dev>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <olsajiri@gmail.com>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v3 5/6] libbpf: Support BPF_F_CPU for percpu
 maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
References: <20250821160817.70285-1-leon.hwang@linux.dev>
 <20250821160817.70285-6-leon.hwang@linux.dev>
 <CAEf4BzbcAnmHd42gVXJHPJWczYPQ3Vq6t9E+VT-m7UNLzLmidQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbcAnmHd42gVXJHPJWczYPQ3Vq6t9E+VT-m7UNLzLmidQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat Aug 23, 2025 at 6:20 AM +08, Andrii Nakryiko wrote:
> On Thu, Aug 21, 2025 at 9:09=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>

[...]

>> @@ -10630,6 +10630,19 @@ static int validate_map_op(const struct bpf_map=
 *map, size_t key_sz,
>>                 int num_cpu =3D libbpf_num_possible_cpus();
>>                 size_t elem_sz =3D roundup(map->def.value_size, 8);
>>
>> +               if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
>> +                       if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CP=
US))
>> +                               return -EINVAL;
>> +                       if ((flags >> 32) >=3D num_cpu)
>> +                               return -ERANGE;
>
> The idea of validate_map_op() is to make it easier for users to
> understand what's wrong with how they deal with the map, rather than
> just getting indiscriminate -EINVAL from the kernel.
>
> Point being: add human-readable pr_warn() explanations for all the new
> conditions you are detecting, otherwise it's just meaningless.
>

Ack.

I'll add these pr_warn() explanations in next revision.

>> +                       if (value_sz !=3D elem_sz) {
>> +                               pr_warn("map '%s': unexpected value size=
 %zu provided for per-CPU map, expected %zu\n",
>> +                                       map->name, value_sz, elem_sz);
>> +                               return -EINVAL;
>> +                       }
>> +                       break;
>> +               }
>> +
>>                 if (value_sz !=3D num_cpu * elem_sz) {
>>                         pr_warn("map '%s': unexpected value size %zu pro=
vided for per-CPU map, expected %d * %zu =3D %zd\n",
>>                                 map->name, value_sz, num_cpu, elem_sz, n=
um_cpu * elem_sz);
>> @@ -10654,7 +10667,7 @@ int bpf_map__lookup_elem(const struct bpf_map *m=
ap,
>>  {
>>         int err;
>>
>> -       err =3D validate_map_op(map, key_sz, value_sz, true);
>> +       err =3D validate_map_op(map, key_sz, value_sz, true, flags);
>>         if (err)
>>                 return libbpf_err(err);
>>
>> @@ -10667,7 +10680,7 @@ int bpf_map__update_elem(const struct bpf_map *m=
ap,
>>  {
>>         int err;
>>
>> -       err =3D validate_map_op(map, key_sz, value_sz, true);
>> +       err =3D validate_map_op(map, key_sz, value_sz, true, flags);
>>         if (err)
>>                 return libbpf_err(err);
>>
>> @@ -10679,7 +10692,7 @@ int bpf_map__delete_elem(const struct bpf_map *m=
ap,
>>  {
>>         int err;
>>
>> -       err =3D validate_map_op(map, key_sz, 0, false /* check_value_sz =
*/);
>> +       err =3D validate_map_op(map, key_sz, 0, false /* check_value_sz =
*/, 0);
>
> hard-coded 0 instead of flags, why?
>

It should be flags.

However, delete op does not support the introduced cpu flags.

I think it's OK to use 0 here.

>>         if (err)
>>                 return libbpf_err(err);
>>
>> @@ -10692,7 +10705,7 @@ int bpf_map__lookup_and_delete_elem(const struct=
 bpf_map *map,
>>  {
>>         int err;
>>
>> -       err =3D validate_map_op(map, key_sz, value_sz, true);
>> +       err =3D validate_map_op(map, key_sz, value_sz, true, 0);
>
> same about flags
>

Ack.

>>         if (err)
>>                 return libbpf_err(err);
>>
>> @@ -10704,7 +10717,7 @@ int bpf_map__get_next_key(const struct bpf_map *=
map,
>>  {
>>         int err;
>>
>> -       err =3D validate_map_op(map, key_sz, 0, false /* check_value_sz =
*/);
>> +       err =3D validate_map_op(map, key_sz, 0, false /* check_value_sz =
*/, 0);
>>         if (err)
>>                 return libbpf_err(err);
>>
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 2e91148d9b44d..6a972a8d060c3 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -1196,12 +1196,13 @@ LIBBPF_API struct bpf_map *bpf_map__inner_map(st=
ruct bpf_map *map);
>>   * @param key_sz size in bytes of key data, needs to match BPF map defi=
nition's **key_size**
>>   * @param value pointer to memory in which looked up value will be stor=
ed
>>   * @param value_sz size in byte of value data memory; it has to match B=
PF map
>> - * definition's **value_size**. For per-CPU BPF maps value size has to =
be
>> - * a product of BPF map value size and number of possible CPUs in the s=
ystem
>> - * (could be fetched with **libbpf_num_possible_cpus()**). Note also th=
at for
>> - * per-CPU values value size has to be aligned up to closest 8 bytes fo=
r
>> - * alignment reasons, so expected size is: `round_up(value_size, 8)
>> - * * libbpf_num_possible_cpus()`.
>> + * definition's **value_size**. For per-CPU BPF maps, value size can be
>> + * definition's **value_size** if **BPF_F_CPU** or **BPF_F_ALL_CPUS** i=
s
>> + * specified in **flags**, otherwise a product of BPF map value size an=
d number
>> + * of possible CPUs in the system (could be fetched with
>> + * **libbpf_num_possible_cpus()**). Note else that for per-CPU values v=
alue
>> + * size has to be aligned up to closest 8 bytes for alignment reasons, =
so
>
> nit: aligned up for alignment reasons... drop "for alignment reasons", I =
guess?
>

It is "for alignment reasons", because percpu maps use bpf_long_memcpy()
to copy data.

static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
{
        const long *lsrc =3D src;
        long *ldst =3D dst;

        size /=3D sizeof(long);
        while (size--)
                data_race(*ldst++ =3D *lsrc++);
}

Thanks,
Leon

[...]

