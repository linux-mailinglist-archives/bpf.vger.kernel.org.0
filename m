Return-Path: <bpf+bounces-68674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC841B808F3
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 17:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EE9622855
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE2633AEA8;
	Wed, 17 Sep 2025 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ejj2l5xm"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706D33AE93
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122757; cv=none; b=ATe4MEkhme1US+ehLPK06N8iD59JVyZQbO9deL6P+0iV0p3PZI5rozx62ABMTaOdcUu1oAu7l5Jm8Ktd1kx/FjjIpKo1SCcrkW4XWnexsETQIgxSbt9fQsK7jY7d6zr1vpG3jgdgO/ZPmYhl2bxYMk7LiQ1T/fMTm9In41E7W20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122757; c=relaxed/simple;
	bh=JS6n88Gjlw+0hAHyaiEd1R9/OIw+Z0IUZLlhEt5eIEU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LeO9yJptMFyFx3MlL5ulT18Ei55fE8oCp/sZ0nD1xupKNT7QsDZJWk1daO6EzQo3ff0kxFeQmUroeG7oMCAkhq2IzY73b+jjGRO51/1P7wsyDJ9Zv+w90cbJSA565H9JAjv0tvNK4LLdxlCxtA42To1//auQmQ9YvqCdteVthwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ejj2l5xm; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758122753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzOL0IL7BVdrgyvf9CDCBK+2m6YLTwA7M6/E7kMYqLg=;
	b=Ejj2l5xmAr3zbchrnyTaB9OT/5tmXM7xkG7XQJOrd5bkax6DdWDbtgsaXcpJxELRB15z5J
	JFnqFp2eWOYDUjMgsdUii3AbbZm2gc0O68VFT6y+cJCjn07ytw4RjOCfEaBbil3YxbwyFU
	GFoII4jbX80A3J/v0Y1x1kn+7VDNi14=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Sep 2025 23:25:43 +0800
Message-Id: <DCV6HY7IRYKG.3JZS8NZ9YZTBZ@linux.dev>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <jolsa@kernel.org>, <yonghong.song@linux.dev>,
 <song@kernel.org>, <eddyz87@gmail.com>, <dxu@dxuuu.xyz>, <deso@posteo.net>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v7 6/7] libbpf: Add BPF_F_CPU and
 BPF_F_ALL_CPUS flags support for percpu maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
References: <20250910162733.82534-1-leon.hwang@linux.dev>
 <20250910162733.82534-7-leon.hwang@linux.dev>
 <CAEf4BzYfg8Xvukcnvja7U=AXoGr=8tZYbZWydo9MZjWhviY==Q@mail.gmail.com>
In-Reply-To: <CAEf4BzYfg8Xvukcnvja7U=AXoGr=8tZYbZWydo9MZjWhviY==Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed Sep 17, 2025 at 7:44 AM +08, Andrii Nakryiko wrote:
> On Wed, Sep 10, 2025 at 9:28=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>
>> Add libbpf support for the BPF_F_CPU flag for percpu maps by embedding t=
he
>> cpu info into the high 32 bits of:
>>
>> 1. **flags**: bpf_map_lookup_elem_flags(), bpf_map__lookup_elem(),
>>    bpf_map_update_elem() and bpf_map__update_elem()
>> 2. **opts->elem_flags**: bpf_map_lookup_batch() and
>>    bpf_map_update_batch()
>>
>> And the flag can be BPF_F_ALL_CPUS, but cannot be
>> 'BPF_F_CPU | BPF_F_ALL_CPUS'.
>>
>> Behavior:
>>
>> * If the flag is BPF_F_ALL_CPUS, the update is applied across all CPUs.
>> * If the flag is BPF_F_CPU, it updates value only to the specified CPU.
>> * If the flag is BPF_F_CPU, lookup value only from the specified CPU.
>> * lookup does not support BPF_F_ALL_CPUS.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/bpf.h    |  8 ++++++++
>>  tools/lib/bpf/libbpf.c | 26 ++++++++++++++++++++------
>>  tools/lib/bpf/libbpf.h | 21 ++++++++-------------
>>  3 files changed, 36 insertions(+), 19 deletions(-)
>>
>
> LGTM, but see some wording nits below
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>

Thanks.

>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 7252150e7ad35..28acb15e982b3 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -286,6 +286,14 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(int =
fd, void *in_batch,
>>   *    Update spin_lock-ed map elements. This must be
>>   *    specified if the map value contains a spinlock.
>>   *
>> + * **BPF_F_CPU**
>> + *    As for percpu maps, update value on the specified CPU. And the cp=
u
>> + *    info is embedded into the high 32 bits of **opts->elem_flags**.
>> + *
>> + * **BPF_F_ALL_CPUS**
>> + *    As for percpu maps, update value across all CPUs. This flag canno=
t
>> + *    be used with BPF_F_CPU at the same time.
>> + *
>>   * @param fd BPF map file descriptor
>>   * @param keys pointer to an array of *count* keys
>>   * @param values pointer to an array of *count* values
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index fe4fc5438678c..3d60e7a713518 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -10603,7 +10603,7 @@ bpf_object__find_map_fd_by_name(const struct bpf=
_object *obj, const char *name)
>>  }
>>
>>  static int validate_map_op(const struct bpf_map *map, size_t key_sz,
>> -                          size_t value_sz, bool check_value_sz)
>> +                          size_t value_sz, bool check_value_sz, __u64 f=
lags)
>>  {
>>         if (!map_is_created(map)) /* map is not yet created */
>>                 return -ENOENT;
>> @@ -10630,6 +10630,20 @@ static int validate_map_op(const struct bpf_map=
 *map, size_t key_sz,
>>                 int num_cpu =3D libbpf_num_possible_cpus();
>>                 size_t elem_sz =3D roundup(map->def.value_size, 8);
>>
>> +               if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
>> +                       if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CP=
US)) {
>> +                               pr_warn("map '%s': can't use BPF_F_CPU a=
nd BPF_F_ALL_CPUS at the same time\n",
>
> "BPF_F_CPU and BPF_F_ALL_CPUS are mutually exclusive" ?
>

Ack.

>> +                                       map->name);
>> +                               return -EINVAL;
>> +                       }
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
>
> [...]
>
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 2e91148d9b44d..f221dc5c6ba41 100644
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
>> + * `round_up(value_size, 8)` if **BPF_F_CPU** or **BPF_F_ALL_CPUS** is
>
> nit: if either BPF_F_CPU or BPF_F_ALL_CPUS
>

Ack.

>> + * specified in **flags**, otherwise a product of BPF map value size an=
d number
>> + * of possible CPUs in the system (could be fetched with
>> + * **libbpf_num_possible_cpus()**). Note else that for per-CPU values v=
alue
>
> Note *also*? Is that what you were trying to say?
>

My mistake.

I=E2=80=99ll change it back to *also* in the next revision.

Thanks,
Leon

[...]

