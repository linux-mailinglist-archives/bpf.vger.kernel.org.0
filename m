Return-Path: <bpf+bounces-59231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BDEAC75DB
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375394E7F35
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC0244674;
	Thu, 29 May 2025 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FoZi+ViF"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E319E968
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 02:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748485510; cv=none; b=Jba41u28sjGywteJzALJuxrB3Zbpai8RQwCQ591l35CkHVAKev6hPUx7gNhDoeOk9tZyWGBgmYQ0z3YTkOOZLGe0jCoQQT8ghxVXwm6CLr1jD5iCt6oiWXXOOM8eskIyOxdO0FcwLuZyzliBYZfD4VB8C88IXzUmswClCR2s1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748485510; c=relaxed/simple;
	bh=mfibpYKPNpxMlISXBqDjuBfnEsRr7EcygK9eoYQWXQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gj2IJkRBTT32zYuFkcD7yht6p/F6xnQeyGT3VmvHOCw6BpdD6Kfe2aFUwXEIEKa6OMr6F5vg2AcP/lSvc/KhiOEO0N6cW0oQz46RqIeqhUn7BBTFzfd0vMhUKSap9p2gHrbS7CieC+tF3rVQq2mRGkZ/T7MmzDaOUhmiIZUKw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FoZi+ViF; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f722152f-b364-4e36-bd50-7dcc8a8279df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748485505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIoejoPvgN0i2N1GUbRjRt6lgl7A6sB9qYsaLzxpASo=;
	b=FoZi+ViFG0gmSkrf3qrxtIJdO1DI2exJPji2U5ZXjeZGRMrWzyZ/2rvsMAdPEM1bo13GHp
	KuBQntKL3GJrdJf0nXL1bLdlOWp32ZxI31rSxR+fxGhK8qvY9jEB1fQhT4zO9VbdJwhDHL
	zObIdrruS8zElfJe9v2ozZbx8By3EyI=
Date: Thu, 29 May 2025 10:24:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf, libbpf: Support global percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250526162146.24429-1-leon.hwang@linux.dev>
 <20250526162146.24429-3-leon.hwang@linux.dev>
 <CAEf4BzY7MB9h-xAnPbheUgBhcqOMNaf1=HH=8V-HmC8k4VPgwQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzY7MB9h-xAnPbheUgBhcqOMNaf1=HH=8V-HmC8k4VPgwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 28/5/25 06:31, Andrii Nakryiko wrote:
> On Mon, May 26, 2025 at 9:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch introduces support for global percpu data in libbpf by adding a
>> new ".data..percpu" section, similar to ".data". It enables efficient
>> handling of percpu global variables in bpf programs.
>>
>> This enhancement improves performance for workloads that benefit from
>> percpu storage.
>>
>> Meanwhile, add bpf_map__is_internal_percpu() API to check whether the map
>> is an internal map used for global percpu variables.
> 
> I'm not a big fan of this super specific API. We do have
> bpf_map__is_internal() to let customer know that map is special in
> some way, but I'd like to avoid making this fine distinction between
> per-CPU internal map vs non-per-CPU (and then why stop there, why not
> have kconfig-specific API, ksym-specific check, etc)?
> 
> All this is mostly useful just for bpftool for skeleton codegen, and
> bpftool already has to know about .percpu prefix, so it doesn't need
> this API to make all these decisions. Let's try to drop this
> bpf_map__is_internal_percpu() API?
> 

To remove bpf_map__is_internal_percpu(), it can be replaced with:

static bool bpf_map_is_internal_percpu(const struct bpf_map *map)
{
	return bpf_map__is_internal(map) &&
	       bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY;
}

This should be functionally equivalent to checking:

map->libbpf_type == LIBBPF_MAP_PERCPU;

>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/libbpf.c   | 102 +++++++++++++++++++++++++++++++--------
>>  tools/lib/bpf/libbpf.h   |   9 ++++
>>  tools/lib/bpf/libbpf.map |   1 +
>>  3 files changed, 91 insertions(+), 21 deletions(-)
>>

[...]

>>  struct elf_sec_desc {
>> @@ -1902,7 +1905,7 @@ static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
>>         struct btf_var_secinfo *vsi;
>>         int i, n;
>>
>> -       if (!map->btf_value_type_id)
>> +       if (!map->btf_value_type_id || map->libbpf_type == LIBBPF_MAP_PERCPU_DATA)
> 
> Not sure this is correct. We should have btf_value_type_id for PERCPU
> global data array, no?
> 

Yes, a PERCPU global data array should indeed have a valid
btf_value_type_id, which is required for seq_show.

This is evident in percpu_array_map_seq_show_elem(), where
btf_value_type_id is used to display the per-CPU values:

static void percpu_array_map_seq_show_elem(struct bpf_map *map, void *key,
					   struct seq_file *m)
{
	// ...

	rcu_read_lock();

	seq_printf(m, "%u: {\n", *(u32 *)key);
	pptr = array->pptrs[index & array->index_mask];
	for_each_possible_cpu(cpu) {
		seq_printf(m, "\tcpu%d: ", cpu);
		btf_type_seq_show(map->btf, map->btf_value_type_id,
				  per_cpu_ptr(pptr, cpu), m);
		seq_putc(m, '\n');
	}
	seq_puts(m, "}\n");

	rcu_read_unlock();
}

So the check for !map->btf_value_type_id in combination with
LIBBPF_MAP_PERCPU_DATA needs to be considered.

>>                 return false;
>>
>>         t = btf__type_by_id(obj->btf, map->btf_value_type_id);
>> @@ -1926,6 +1929,7 @@ static int
>>  bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>>                               const char *real_name, int sec_idx, void *data, size_t data_sz)

[...]

>>
>> +       /* .data..percpu DATASEC must have __aligned(8) size. */
> 
> please remind me why? similarly for def->value_size special casing?
> What will happen if we don't explicitly roundup() on libbpf side
> (kernel always does roundup(8) for ARRAY value_size anyways, which is
> why I am asking)
> 

t->size must match def->value_size.

That said, I believe it's acceptable to avoid using roundup() for both
values. I'll test this using seq_show to confirm.

>> +       if (strcmp(sec_name, PERCPU_DATA_SEC) == 0 || str_has_pfx(sec_name, PERCPU_DATA_SEC))
>> +               t->size = roundup(t->size, 8);
>> +
>>         for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
>>                 const struct btf_type *t_var;
>>                 struct btf_var *var;
>> @@ -3923,6 +3939,11 @@ static int bpf_object__elf_collect(struct bpf_object *obj)

[...]

>> +       data_sz = map->def.value_size;
>> +       if (is_percpu) {
>> +               num_cpus = libbpf_num_possible_cpus();
>> +               if (num_cpus < 0) {
>> +                       err = num_cpus;
>> +                       return err;
> 
> hm... why not `return num_cpus;`?
> 

Ack.

>> +               }
>> +
>> +               data_sz = data_sz * num_cpus;
>> +               data = malloc(data_sz);
>> +               if (!data) {
>> +                       err = -ENOMEM;
>> +                       return err;
>> +               }
> 
> [...]
> 
>>  /**
>>   * @brief **bpf_map__set_pin_path()** sets the path attribute that tells where the
>>   * BPF map should be pinned. This does not actually create the 'pin'.
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 1205f9a4fe048..1c239ac88c699 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -443,4 +443,5 @@ LIBBPF_1.6.0 {
>>                 bpf_program__line_info_cnt;
>>                 btf__add_decl_attr;
>>                 btf__add_type_attr;
>> +               bpf_map__is_internal_percpu;
> 
> alphabetically sorted
> 

bpf_map__is_internal_percpu will be dropped.

Thanks,
Leon


