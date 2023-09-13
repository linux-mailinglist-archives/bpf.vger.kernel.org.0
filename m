Return-Path: <bpf+bounces-9880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1B79E3D5
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926122812E9
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AFE1DDDD;
	Wed, 13 Sep 2023 09:34:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2410F5
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:34:31 +0000 (UTC)
Received: from mail-m127207.xmail.ntesmail.com (mail-m127207.xmail.ntesmail.com [115.236.127.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E22196;
	Wed, 13 Sep 2023 02:34:30 -0700 (PDT)
Received: from [10.128.10.193] (unknown [123.120.52.233])
	by mail-m12739.qiye.163.com (Hmail) with ESMTPA id 346384A032D;
	Wed, 13 Sep 2023 17:33:54 +0800 (CST)
Message-ID: <9dd5520b-ae33-4783-a7df-1461c31bca20@sangfor.com.cn>
Date: Wed, 13 Sep 2023 17:33:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Eduard Zingerman <eddyz87@gmail.com>, martin.lau@linux.dev, ast@kernel.org
Cc: song@kernel.org, yhs@fb.com, rostedt@goodmis.org, mhiramat@kernel.org,
 dinghui@sangfor.com.cn, huangcun@sangfor.com.cn, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
 <20ef8441084c9d5fd54f84987afa77eed7fe148e.camel@gmail.com>
 <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
From: pengdonglin <pengdonglin@sangfor.com.cn>
In-Reply-To: <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEJJVhoaTU1LSB9PHxlLTVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpJSFVKSUtVTklVSUhIWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8a8de3da27b212kuuu346384a032d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oio6FDo5Vj1CNw8DCS8OLDwo
	TjZPCixVSlVKTUJPTkJMTUhOSU1CVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
	WRILWUFZSklIVUpJS1VOSVVJSEhZV1kIAVlBSk5PTkM3Bg++

On 2023/9/12 22:19, Eduard Zingerman wrote:
> On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
>> On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
>>> Currently, we are only using the linear search method to find the type id
>>> by the name, which has a time complexity of O(n). This change involves
>>> sorting the names of btf types in ascending order and using binary search,
>>> which has a time complexity of O(log(n)). This idea was inspired by the
>>> following patch:
>>>
>>> 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name()").
>>>
>>> At present, this improvement is only for searching in vmlinux's and
>>> module's BTFs, and the kind should only be BTF_KIND_FUNC or BTF_KIND_STRUCT.
>>>
>>> Another change is the search direction, where we search the BTF first and
>>> then its base, the type id of the first matched btf_type will be returned.
>>>
>>> Here is a time-consuming result that finding all the type ids of 67,819 kernel
>>> functions in vmlinux's BTF by their names:
>>>
>>> Before: 17000 ms
>>> After:     10 ms
>>>
>>> The average lookup performance has improved about 1700x at the above scenario.
>>>
>>> However, this change will consume more memory, for example, 67,819 kernel
>>> functions will allocate about 530KB memory.
>>
>> Hi Donglin,
>>
>> I think this is a good improvement. However, I wonder, why did you
>> choose to have a separate name map for each BTF kind?
>>
>> I did some analysis for my local testing kernel config and got such numbers:
>> - total number of BTF objects: 97350
>> - number of FUNC and STRUCT objects: 51597
>> - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC objects: 56817
>>    (these are all kinds for which lookup by name might make sense)
>> - number of named objects: 54246
>> - number of name collisions:
>>    - unique names: 53985 counts
>>    - 2 objects with the same name: 129 counts
>>    - 3 objects with the same name: 3 counts
>>
>> So, it appears that having a single map for all named objects makes
>> sense and would also simplify the implementation, what do you think?
> 
> Some more numbers for my config:
> - 13241 types (struct, union, typedef, enum), log2 13241 = 13.7
> - 43575 funcs, log2 43575 = 15.4
> Thus, having separate map for types vs functions might save ~1.7
> search iterations. Is this a significant slowdown in practice?
> 

Thank you, I haven't conducted such a comparative test yet, but I agree
with your point of view.

>>
>> Thanks,
>> Eduard
>>
>>>
>>> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
>>> ---
>>> Changes in RFC v2:
>>>   - Fix the build issue reported by kernel test robot <lkp@intel.com>
>>> ---
>>>   include/linux/btf.h |   1 +
>>>   kernel/bpf/btf.c    | 300 ++++++++++++++++++++++++++++++++++++++++++--
>>>   2 files changed, 291 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>> index cac9f304e27a..6260a0668773 100644
>>> --- a/include/linux/btf.h
>>> +++ b/include/linux/btf.h
>>> @@ -201,6 +201,7 @@ bool btf_is_kernel(const struct btf *btf);
>>>   bool btf_is_module(const struct btf *btf);
>>>   struct module *btf_try_get_module(const struct btf *btf);
>>>   u32 btf_nr_types(const struct btf *btf);
>>> +u32 btf_type_cnt(const struct btf *btf);
>>>   bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>>>   			   const struct btf_member *m,
>>>   			   u32 expected_offset, u32 expected_size);
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 817204d53372..51aa9f27853b 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -240,6 +240,26 @@ struct btf_id_dtor_kfunc_tab {
>>>   	struct btf_id_dtor_kfunc dtors[];
>>>   };
>>>   
>>> +enum {
>>> +	BTF_ID_NAME_FUNC,	/* function */
>>> +	BTF_ID_NAME_STRUCT,	/* struct */
>>> +	BTF_ID_NAME_MAX
>>> +};
>>> +
>>> +struct btf_id_name {
>>> +	int id;
>>> +	u32 name_off;
>>> +};
>>> +
>>> +struct btf_id_name_map {
>>> +	struct btf_id_name *id_name;
>>> +	u32 count;
>>> +};
>>> +
>>> +struct btf_id_name_maps {
>>> +	struct btf_id_name_map map[BTF_ID_NAME_MAX];
>>> +};
>>> +
>>>   struct btf {
>>>   	void *data;
>>>   	struct btf_type **types;
>>> @@ -257,6 +277,7 @@ struct btf {
>>>   	struct btf_kfunc_set_tab *kfunc_set_tab;
>>>   	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
>>>   	struct btf_struct_metas *struct_meta_tab;
>>> +	struct btf_id_name_maps *id_name_maps;
>>>   
>>>   	/* split BTF support */
>>>   	struct btf *base_btf;
>>> @@ -532,22 +553,142 @@ u32 btf_nr_types(const struct btf *btf)
>>>   	return total;
>>>   }
>>>   
>>> +u32 btf_type_cnt(const struct btf *btf)
>>> +{
>>> +	return btf->start_id + btf->nr_types;
>>> +}
>>> +
>>> +static inline u8 btf_id_name_idx_to_kind(int index)
>>> +{
>>> +	u8 kind;
>>> +
>>> +	switch (index) {
>>> +	case BTF_ID_NAME_FUNC:
>>> +		kind = BTF_KIND_FUNC;
>>> +		break;
>>> +	case BTF_ID_NAME_STRUCT:
>>> +		kind = BTF_KIND_STRUCT;
>>> +		break;
>>> +	default:
>>> +		kind = BTF_KIND_UNKN;
>>> +		break;
>>> +	}
>>> +
>>> +	return kind;
>>> +}
>>> +
>>> +static inline int btf_id_name_kind_to_idx(u8 kind)
>>> +{
>>> +	int index;
>>> +
>>> +	switch (kind) {
>>> +	case BTF_KIND_FUNC:
>>> +		index = BTF_ID_NAME_FUNC;
>>> +		break;
>>> +	case BTF_KIND_STRUCT:
>>> +		index = BTF_ID_NAME_STRUCT;
>>> +		break;
>>> +	default:
>>> +		index = -1;
>>> +		break;
>>> +	}
>>> +
>>> +	return index;
>>> +}
>>> +
>>> +static s32 btf_find_by_name_bsearch(struct btf_id_name *id_name,
>>> +				    u32 size, const char *name,
>>> +				    struct btf_id_name **start,
>>> +				    struct btf_id_name **end,
>>> +				    const struct btf *btf)
>>> +{
>>> +	int ret;
>>> +	int low, mid, high;
>>> +	const char *name_buf;
>>> +
>>> +	low = 0;
>>> +	high = size - 1;
>>> +
>>> +	while (low <= high) {
>>> +		mid = low + (high - low) / 2;
>>> +		name_buf = btf_name_by_offset(btf, id_name[mid].name_off);
>>> +		ret = strcmp(name, name_buf);
>>> +		if (ret > 0)
>>> +			low = mid + 1;
>>> +		else if (ret < 0)
>>> +			high = mid - 1;
>>> +		else
>>> +			break;
>>> +	}
>>> +
>>> +	if (low > high)
>>> +		return -ESRCH;
>>> +
>>> +	if (start) {
>>> +		low = mid;
>>> +		while (low) {
>>> +			name_buf = btf_name_by_offset(btf, id_name[low-1].name_off);
>>> +			if (strcmp(name, name_buf))
>>> +				break;
>>> +			low--;
>>> +		}
>>> +		*start = &id_name[low];
>>> +	}
>>> +
>>> +	if (end) {
>>> +		high = mid;
>>> +		while (high < size - 1) {
>>> +			name_buf = btf_name_by_offset(btf, id_name[high+1].name_off);
>>> +			if (strcmp(name, name_buf))
>>> +				break;
>>> +			high++;
>>> +		}
>>> +		*end = &id_name[high];
>>> +	}
>>> +
>>> +	return id_name[mid].id;
>>> +}
>>> +
>>>   s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
>>>   {
>>> +	const struct btf_id_name_maps *maps;
>>> +	const struct btf_id_name_map *map;
>>> +	struct btf_id_name *start;
>>>   	const struct btf_type *t;
>>>   	const char *tname;
>>> -	u32 i, total;
>>> +	int index = btf_id_name_kind_to_idx(kind);
>>> +	s32 id, total;
>>>   
>>> -	total = btf_nr_types(btf);
>>> -	for (i = 1; i < total; i++) {
>>> -		t = btf_type_by_id(btf, i);
>>> -		if (BTF_INFO_KIND(t->info) != kind)
>>> -			continue;
>>> +	do {
>>> +		maps = btf->id_name_maps;
>>> +		if (index >= 0 && maps && maps->map[index].id_name) {
>>> +			/* binary search */
>>> +			map = &maps->map[index];
>>> +			id = btf_find_by_name_bsearch(map->id_name,
>>> +				map->count, name, &start, NULL, btf);
>>> +			if (id > 0) {
>>> +				/*
>>> +				 * Return the first one that
>>> +				 * matched
>>> +				 */
>>> +				return start->id;
>>> +			}
>>> +		} else {
>>> +			/* linear search */
>>> +			total = btf_type_cnt(btf);
>>> +			for (id = btf->start_id; id < total; id++) {
>>> +				t = btf_type_by_id(btf, id);
>>> +				if (BTF_INFO_KIND(t->info) != kind)
>>> +					continue;
>>> +
>>> +				tname = btf_name_by_offset(btf, t->name_off);
>>> +				if (!strcmp(tname, name))
>>> +					return id;
>>> +			}
>>> +		}
>>>   
>>> -		tname = btf_name_by_offset(btf, t->name_off);
>>> -		if (!strcmp(tname, name))
>>> -			return i;
>>> -	}
>>> +		btf = btf->base_btf;
>>> +	} while (btf);
>>>   
>>>   	return -ENOENT;
>>>   }
>>> @@ -1639,6 +1780,32 @@ static void btf_free_id(struct btf *btf)
>>>   	spin_unlock_irqrestore(&btf_idr_lock, flags);
>>>   }
>>>   
>>> +static void btf_destroy_id_name(struct btf *btf, int index)
>>> +{
>>> +	struct btf_id_name_maps *maps = btf->id_name_maps;
>>> +	struct btf_id_name_map *map = &maps->map[index];
>>> +
>>> +	if (map->id_name) {
>>> +		kvfree(map->id_name);
>>> +		map->id_name = NULL;
>>> +		map->count = 0;
>>> +	}
>>> +}
>>> +
>>> +static void btf_destroy_id_name_map(struct btf *btf)
>>> +{
>>> +	int i;
>>> +
>>> +	if (!btf->id_name_maps)
>>> +		return;
>>> +
>>> +	for (i = 0; i < BTF_ID_NAME_MAX; i++)
>>> +		btf_destroy_id_name(btf, i);
>>> +
>>> +	kfree(btf->id_name_maps);
>>> +	btf->id_name_maps = NULL;
>>> +}
>>> +
>>>   static void btf_free_kfunc_set_tab(struct btf *btf)
>>>   {
>>>   	struct btf_kfunc_set_tab *tab = btf->kfunc_set_tab;
>>> @@ -1689,6 +1856,7 @@ static void btf_free_struct_meta_tab(struct btf *btf)
>>>   
>>>   static void btf_free(struct btf *btf)
>>>   {
>>> +	btf_destroy_id_name_map(btf);
>>>   	btf_free_struct_meta_tab(btf);
>>>   	btf_free_dtor_kfunc_tab(btf);
>>>   	btf_free_kfunc_set_tab(btf);
>>> @@ -5713,6 +5881,107 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
>>>   	return kctx_type_id;
>>>   }
>>>   
>>> +static int btf_compare_id_name(const void *a, const void *b, const void *priv)
>>> +{
>>> +	const struct btf_id_name *ia = (const struct btf_id_name *)a;
>>> +	const struct btf_id_name *ib = (const struct btf_id_name *)b;
>>> +	const struct btf *btf = priv;
>>> +	int ret;
>>> +
>>> +	/*
>>> +	 * Sort names in ascending order, if the name is same, sort ids in
>>> +	 * ascending order.
>>> +	 */
>>> +	ret = strcmp(btf_name_by_offset(btf, ia->name_off),
>>> +		     btf_name_by_offset(btf, ib->name_off));
>>> +	if (!ret)
>>> +		ret = ia->id - ib->id;
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int btf_create_id_name(struct btf *btf, int index)
>>> +{
>>> +	struct btf_id_name_maps *maps = btf->id_name_maps;
>>> +	struct btf_id_name_map *map = &maps->map[index];
>>> +	const struct btf_type *t;
>>> +	struct btf_id_name *id_name;
>>> +	const char *name;
>>> +	int i, j = 0;
>>> +	u32 total, count = 0;
>>> +	u8 kind;
>>> +
>>> +	kind = btf_id_name_idx_to_kind(index);
>>> +	if (kind == BTF_KIND_UNKN)
>>> +		return -EINVAL;
>>> +
>>> +	if (map->id_name || map->count != 0)
>>> +		return -EINVAL;
>>> +
>>> +	total = btf_type_cnt(btf);
>>> +	for (i = btf->start_id; i < total; i++) {
>>> +		t = btf_type_by_id(btf, i);
>>> +		if (BTF_INFO_KIND(t->info) != kind)
>>> +			continue;
>>> +		name = btf_name_by_offset(btf, t->name_off);
>>> +		if (str_is_empty(name))
>>> +			continue;
>>> +		count++;
>>> +	}
>>> +
>>> +	if (count == 0)
>>> +		return 0;
>>> +
>>> +	id_name = kvcalloc(count, sizeof(struct btf_id_name),
>>> +			   GFP_KERNEL);
>>> +	if (!id_name)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = btf->start_id; i < total; i++) {
>>> +		t = btf_type_by_id(btf, i);
>>> +		if (BTF_INFO_KIND(t->info) != kind)
>>> +			continue;
>>> +		name = btf_name_by_offset(btf, t->name_off);
>>> +		if (str_is_empty(name))
>>> +			continue;
>>> +
>>> +		id_name[j].id = i;
>>> +		id_name[j].name_off = t->name_off;
>>> +		j++;
>>> +	}
>>> +
>>> +	sort_r(id_name, count, sizeof(id_name[0]), btf_compare_id_name,
>>> +	       NULL, btf);
>>> +
>>> +	map->id_name = id_name;
>>> +	map->count = count;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int btf_create_id_name_map(struct btf *btf)
>>> +{
>>> +	int err, i;
>>> +	struct btf_id_name_maps *maps;
>>> +
>>> +	if (btf->id_name_maps)
>>> +		return -EBUSY;
>>> +
>>> +	maps = kzalloc(sizeof(struct btf_id_name_maps), GFP_KERNEL);
>>> +	if (!maps)
>>> +		return -ENOMEM;
>>> +
>>> +	btf->id_name_maps = maps;
>>> +
>>> +	for (i = 0; i < BTF_ID_NAME_MAX; i++) {
>>> +		err = btf_create_id_name(btf, i);
>>> +		if (err < 0)
>>> +			break;
>>> +	}
>>> +
>>> +	return err;
>>> +}
>>> +
>>>   BTF_ID_LIST(bpf_ctx_convert_btf_id)
>>>   BTF_ID(struct, bpf_ctx_convert)
>>>   
>>> @@ -5760,6 +6029,10 @@ struct btf *btf_parse_vmlinux(void)
>>>   	if (err)
>>>   		goto errout;
>>>   
>>> +	err = btf_create_id_name_map(btf);
>>> +	if (err)
>>> +		goto errout;
>>> +
>>>   	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
>>>   	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
>>>   
>>> @@ -5777,6 +6050,7 @@ struct btf *btf_parse_vmlinux(void)
>>>   errout:
>>>   	btf_verifier_env_free(env);
>>>   	if (btf) {
>>> +		btf_destroy_id_name_map(btf);
>>>   		kvfree(btf->types);
>>>   		kfree(btf);
>>>   	}
>>> @@ -5844,13 +6118,19 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
>>>   	if (err)
>>>   		goto errout;
>>>   
>>> +	err = btf_create_id_name_map(btf);
>>> +	if (err)
>>> +		goto errout;
>>> +
>>>   	btf_verifier_env_free(env);
>>>   	refcount_set(&btf->refcnt, 1);
>>> +
>>>   	return btf;
>>>   
>>>   errout:
>>>   	btf_verifier_env_free(env);
>>>   	if (btf) {
>>> +		btf_destroy_id_name_map(btf);
>>>   		kvfree(btf->data);
>>>   		kvfree(btf->types);
>>>   		kfree(btf);
>>
> 
> 


