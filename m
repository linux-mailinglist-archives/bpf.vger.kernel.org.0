Return-Path: <bpf+bounces-49031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E69A133A9
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 08:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068611672A8
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 07:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A6A192B96;
	Thu, 16 Jan 2025 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RC/KwwJC"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28108155308
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012157; cv=none; b=UhMeexO+21D6YwAHruZqcdr566FY5RCKemZv7rcvAsy/9wHnXDp73fxisAF3p53cx9v95CZBfvnxCcQh/+tBH9a13XVi65ac8gdxU36uW0JurWfowYi2bBhNZ1xhN287d4ROQPR74dCGW3+XaxqJB0C+yYtggr80ygObMrAGrzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012157; c=relaxed/simple;
	bh=4bvuiFuHcU/67klGiX3zkAJl8S5UHUyAuUyeTlRQN0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzhh4jRGTIu9YFYxnMBSpxYCt+wronMt2V8APZUTX3kZj7xGgxNzB5YcdBRTvfM7yXEvA7oqBe4/OjptKE2Tc4OthBAzPlM+dklCfmDmdCDJuTx9iQRuGJaMUOZPoBN1SGrGlPMDaGWdZxSpYlHouXRsLXpBFrkGQG94pqeHcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RC/KwwJC; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9872244c-0e3b-4e83-be1d-1503f7b086e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737012147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKbcVDJoBLJs9Ij4aPOB2VVjea2HkZVgxEFs6iCuA7I=;
	b=RC/KwwJCwY3qIpwRQOAV6inW4QrMgUmSFY5t9YB9bXkBF2/0+pa4OvQQWSl50Wu+B0JKJ6
	P7qTdBINF7267tlq4N2pFwoBlm3c+V8uQqeQpYW7VGJwDzEOdBaqKQMP6tywCCxdHtAG/8
	yc8TP0/W3Utxgp/KCFErhQ91uyryuho=
Date: Thu, 16 Jan 2025 15:22:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Introduce global percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, kernel-patches-bot@fb.com
References: <20250113152437.67196-1-leon.hwang@linux.dev>
 <20250113152437.67196-2-leon.hwang@linux.dev>
 <CAEf4BzahZ04K5LDaqaToJnQ9yvRZ48yh-2+ywsKRgcj8whMheA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzahZ04K5LDaqaToJnQ9yvRZ48yh-2+ywsKRgcj8whMheA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 15/1/25 07:10, Andrii Nakryiko wrote:
> On Mon, Jan 13, 2025 at 7:25 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch introduces global per-CPU data, inspired by commit
>> 6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
>> definition of global per-CPU variables in BPF, similar to the
>> DEFINE_PER_CPU() macro in the kernel[0].
>>
>> For example, in BPF, it is able to define a global per-CPU variable like
>> this:
>>
>> int percpu_data SEC(".data..percpu");
>>
>> With this patch, tools like retsnoop[1] and bpflbr[2] can simplify their
>> BPF code for handling LBRs. The code can be updated from
>>
>> static struct perf_branch_entry lbrs[1][MAX_LBR_ENTRIES] SEC(".data.lbrs");
>>
>> to
>>
>> static struct perf_branch_entry lbrs[MAX_LBR_ENTRIES] SEC(".data..percpu.lbrs");
>>
>> This eliminates the need to retrieve the CPU ID using the
>> bpf_get_smp_processor_id() helper.
>>
>> Additionally, by reusing global per-CPU variables, sharing information
>> between tail callers and callees or freplace callers and callees becomes
>> simpler compared to using percpu_array maps.
>>
>> Links:
>> [0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe90be28c5a3/include/linux/percpu-defs.h#L114
>> [1] https://github.com/anakryiko/retsnoop
>> [2] https://github.com/Asphaltt/bpflbr
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  kernel/bpf/arraymap.c  |  39 +++++++++++++-
>>  kernel/bpf/verifier.c  |  45 +++++++++++++++++
>>  tools/lib/bpf/libbpf.c | 112 ++++++++++++++++++++++++++++++++---------
>>  3 files changed, 171 insertions(+), 25 deletions(-)
>>
> 
> So I think the feature overall makes sense, but we need to think
> through at least libbpf's side of things some more. Unlike .data,
> per-cpu .data section is not mmapable, and so that has implication on
> BPF skeleton and we should make sure all that makes sense on BPF
> skeleton side. In that sense, per-cpu global data is more akin to
> struct_ops initialization image, which can be accessed by user before
> skeleton is loaded to initialize the image.
> 
> There are a few things to consider. What's the BPF skeleton interface?
> Do we expose it as single struct and use that struct as initial image
> for each CPU (which means user won't be able to initialize different
> CPU data differently, at least not through BPF skeleton facilities)?
> Or do we expose this as an array of structs and let user set each CPU
> data independently?
> 
> I feel like keeping it simple and having one image for all CPUs would
> cover most cases. And users can still access the underlying
> PERCPU_ARRAY map if they need more control.

Agree. It is necessary to keep it simple.

> 
> But either way, we need tests for skeleton, making sure we NULL-out
> this per-cpu global data, but take it into account before the load.
> 
> Also, this huge calloc for possible CPUs, I'd like to avoid it
> altogether for the (probably very common) zero-initialized case.

Ack.

> 
> So in short, needs a bit of iteration to figure out all the
> interfacing issues, but makes sense overall. See some more low-level
> remarks below.
> 

It is challenging to figure out them. I'll do my best to achieve it.

> pw-bot: cr
> 
> 
> [...]
> 
>> @@ -815,6 +850,8 @@ const struct bpf_map_ops percpu_array_map_ops = {
>>         .map_get_next_key = array_map_get_next_key,
>>         .map_lookup_elem = percpu_array_map_lookup_elem,
>>         .map_gen_lookup = percpu_array_map_gen_lookup,
>> +       .map_direct_value_addr = percpu_array_map_direct_value_addr,
>> +       .map_direct_value_meta = percpu_array_map_direct_value_meta,
>>         .map_update_elem = array_map_update_elem,
>>         .map_delete_elem = array_map_delete_elem,
>>         .map_lookup_percpu_elem = percpu_array_map_lookup_percpu_elem,
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b8ca227c78af1..94ce02a48ddc1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6809,6 +6809,8 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
>>         u64 addr;
>>         int err;
>>
>> +       if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
>> +               return -EINVAL;
> 
> I'd invert the condition and reject anything by BPF_MAP_TYPE_ARRAY. I
> don't see how any other possible map type can support this magic that
> we do with ARRAY. So to be on the safe side, let's just reject
> everything that's non-ARRAY (here and elsewhere)?

Ack.

> 
>>         err = map->ops->map_direct_value_addr(map, &addr, off);
>>         if (err)
>>                 return err;
> 
> [...]
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6c262d0152f81..881174f4f90a4 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> definitely let's split out libbpf changes from kernel-side changes

Ack.

> 
>> @@ -516,6 +516,7 @@ struct bpf_struct_ops {
>>  };
>>
>>  #define DATA_SEC ".data"
>> +#define PERCPU_DATA_SEC ".data..percpu"
> 
> I don't like this prefix, even if that's what we have in the kernel.
> Something like just ".percpu" or ".percpu_data" or ".data_percpu" is
> better, IMO.

I tested ".percpu". It is OK to use it. But we have to update "bpftool
gen" too, which relies on these section names.

Is it better to keep ".data" prefix, like ".data.percpu", ".data_percpu"?
Can keeping ".data" prefix reduce some works on bpftool, go-ebpf and
akin bpf loaders?

> 
>>  #define BSS_SEC ".bss"
>>  #define RODATA_SEC ".rodata"
>>  #define KCONFIG_SEC ".kconfig"
>> @@ -562,6 +563,8 @@ struct bpf_map {
>>         __u32 btf_value_type_id;
>>         __u32 btf_vmlinux_value_type_id;
>>         enum libbpf_map_type libbpf_type;
>> +       int num_cpus;
>> +       void *data;
>>         void *mmaped;
>>         struct bpf_struct_ops *st_ops;
>>         struct bpf_map *inner_map;
>> @@ -1923,11 +1926,35 @@ static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
>>         return false;
>>  }
>>
>> +static bool map_is_percpu_data(struct bpf_map *map)
>> +{
>> +       return str_has_pfx(map->real_name, PERCPU_DATA_SEC);
>> +}
> 
> we have enum libbpf_map_type which is used to distinguish BSS vs
> RODATA vs DATA vs others, let's stick to that
> 

Ack.

>> +
>> +static void map_copy_data(struct bpf_map *map, const void *data)
>> +{
>> +       bool is_percpu_data = map_is_percpu_data(map);
>> +       size_t data_sz = map->def.value_size;
>> +       size_t elem_sz = roundup(data_sz, 8);
>> +       int i;
>> +
>> +       if (!data)
>> +               return;
>> +
>> +       if (!is_percpu_data)
>> +               memcpy(map->mmaped, data, data_sz);
>> +       else
>> +               for (i = 0; i < map->num_cpus; i++)
>> +                       memcpy(map->data + i*elem_sz, data, data_sz);
>> +}
>> +
>>  static int
>>  bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>>                               const char *real_name, int sec_idx, void *data, size_t data_sz)
>>  {
>> +       bool is_percpu_data = str_has_pfx(real_name, PERCPU_DATA_SEC);
>>         struct bpf_map_def *def;
>> +       const char *data_desc;
>>         struct bpf_map *map;
>>         size_t mmap_sz;
>>         int err;
>> @@ -1948,7 +1975,8 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>>         }
>>
>>         def = &map->def;
>> -       def->type = BPF_MAP_TYPE_ARRAY;
>> +       def->type = is_percpu_data ? BPF_MAP_TYPE_PERCPU_ARRAY
>> +                                  : BPF_MAP_TYPE_ARRAY;
>>         def->key_size = sizeof(int);
>>         def->value_size = data_sz;
>>         def->max_entries = 1;
>> @@ -1958,29 +1986,57 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>>         /* failures are fine because of maps like .rodata.str1.1 */
>>         (void) map_fill_btf_type_info(obj, map);
>>
>> -       if (map_is_mmapable(obj, map))
>> -               def->map_flags |= BPF_F_MMAPABLE;
>> +       data_desc = is_percpu_data ? "percpu " : "";
> 
> nit: just inline the logic in that single place you use it
> 

Ack.

>> +       pr_debug("map '%s' (global %sdata): at sec_idx %d, offset %zu, flags %x.\n",
>> +                map->name, data_desc, map->sec_idx, map->sec_offset,
>> +                def->map_flags);
>>
>> -       pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
>> -                map->name, map->sec_idx, map->sec_offset, def->map_flags);
>> +       if (is_percpu_data) {
>> +               map->num_cpus = libbpf_num_possible_cpus();
>> +               if (map->num_cpus < 0) {
>> +                       err = errno;
> 
> map->num_cpus should have actual error value already, avoid using
> errno unnecessarily
> 

Ack.

>> +                       pr_warn("failed to get possible cpus\n");
>> +                       goto free_name;
>> +               }
>>
>> -       mmap_sz = bpf_map_mmap_sz(map);
>> -       map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
>> -                          MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>> -       if (map->mmaped == MAP_FAILED) {
>> -               err = -errno;
>> -               map->mmaped = NULL;
>> -               pr_warn("failed to alloc map '%s' content buffer: %s\n", map->name, errstr(err));
>> -               zfree(&map->real_name);
>> -               zfree(&map->name);
>> -               return err;
>> -       }
>> +               map->data = calloc(map->num_cpus, roundup(data_sz, 8));
>> +               if (!map->data) {
>> +                       err = -ENOMEM;
>> +                       pr_warn("failed to alloc percpu map '%s' content buffer: %s\n",
>> +                               map->name, errstr(err));
> 
> please stick to establish reporting style (i.e., for map operations we
> always use "map '%s': " prefix)
> 

Ack.

>> +                       goto free_name;
>> +               }
> 
> [...]
> 
>> @@ -10370,7 +10434,7 @@ void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
>>                 return map->st_ops->data;
>>         }
>>
>> -       if (!map->mmaped)
>> +       if ((!map->mmaped && !map->data))
> 
> nit: why unnecessary extra () ?
> 

My bad. I'll remove it.

> 
>>                 return NULL;
>>
>>         if (map->def.type == BPF_MAP_TYPE_ARENA)
>> @@ -10378,7 +10442,7 @@ void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
>>         else
>>                 *psize = map->def.value_size;
>>
>> -       return map->mmaped;
>> +       return map->def.type == BPF_MAP_TYPE_PERCPU_ARRAY ? map->data : map->mmaped;
>>  }
>>
>>  bool bpf_map__is_internal(const struct bpf_map *map)
>> --
>> 2.47.1
>>

Thanks,
Leon


