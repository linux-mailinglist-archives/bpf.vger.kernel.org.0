Return-Path: <bpf+bounces-9881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD5279E3DC
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90551281B1B
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5E1DDDF;
	Wed, 13 Sep 2023 09:36:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664410F5
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:36:26 +0000 (UTC)
X-Greylist: delayed 500 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 02:36:25 PDT
Received: from mail-m49206.qiye.163.com (mail-m49206.qiye.163.com [45.254.49.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C964196;
	Wed, 13 Sep 2023 02:36:24 -0700 (PDT)
Received: from [10.128.10.193] (unknown [123.120.52.233])
	by mail-m12739.qiye.163.com (Hmail) with ESMTPA id 2C67A4A033D;
	Wed, 13 Sep 2023 17:27:28 +0800 (CST)
Message-ID: <f365a5b0-bf44-4c60-8214-5b66112cb42a@sangfor.com.cn>
Date: Wed, 13 Sep 2023 17:27:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: pengdonglin <pengdonglin@sangfor.com.cn>
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: martin.lau@linux.dev, ast@kernel.org, song@kernel.org, yhs@fb.com,
 rostedt@goodmis.org, dinghui@sangfor.com.cn, huangcun@sangfor.com.cn,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
 <20230909212933.1552f2842b06e50525a4daef@kernel.org>
 <33d64375-d672-49a8-bbc8-c31a67595403@sangfor.com.cn>
 <4c20dc33-8d10-45f3-a1f7-d8a872aaf5bd@sangfor.com.cn>
 <20230913170758.56098cb2d2eb2e9f4b17bf00@kernel.org>
In-Reply-To: <20230913170758.56098cb2d2eb2e9f4b17bf00@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEoeVkhJT05LGB9LTEkfS1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpJSFVKSUtVTklVSUhIWVdZFhoPEhUdFFlBWU9LSFVKSEpOTUlVSktLVUtZBg++
X-HM-Tid: 0a8a8dddf69fb212kuuu2c67a4a033d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pk06Qzo4Lj1KFQ8OT1E1LTgp
	TxkaFANVSlVKTUJPTkJMSU9CTkpIVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
	WRILWUFZSklIVUpJS1VOSVVJSEhZV1kIAVlBSUlMSEs3Bg++

On 2023/9/13 16:07, Masami Hiramatsu (Google) wrote:
> On Tue, 12 Sep 2023 11:35:16 +0800
> pengdonglin <pengdonglin@sangfor.com.cn> wrote:
> 
>> On 2023/9/12 10:06, pengdonglin wrote:
>>> 在 2023/9/9 20:29, Masami Hiramatsu (Google) 写道:
>>>> On Sat,  9 Sep 2023 02:16:46 -0700
>>>> Donglin Peng <pengdonglin@sangfor.com.cn> wrote:
>>>>
>>>>> Currently, we are only using the linear search method to find the
>>>>> type id
>>>>> by the name, which has a time complexity of O(n). This change involves
>>>>> sorting the names of btf types in ascending order and using binary
>>>>> search,
>>>>> which has a time complexity of O(log(n)). This idea was inspired by the
>>>>> following patch:
>>>>>
>>>>> 60443c88f3a8 ("kallsyms: Improve the performance of
>>>>> kallsyms_lookup_name()").
>>>>>
>>>>> At present, this improvement is only for searching in vmlinux's and
>>>>> module's BTFs, and the kind should only be BTF_KIND_FUNC or
>>>>> BTF_KIND_STRUCT.
>>>>>
>>>>> Another change is the search direction, where we search the BTF first
>>>>> and
>>>>> then its base, the type id of the first matched btf_type will be
>>>>> returned.
>>>>>
>>>>> Here is a time-consuming result that finding all the type ids of
>>>>> 67,819 kernel
>>>>> functions in vmlinux's BTF by their names:
>>>>>
>>>>> Before: 17000 ms
>>>>> After:     10 ms
>>>>
>>>> Nice work!
>>>
>>> Thank you
>>>
>>>>
>>>>>
>>>>> The average lookup performance has improved about 1700x at the above
>>>>> scenario.
>>>>>
>>>>> However, this change will consume more memory, for example, 67,819
>>>>> kernel
>>>>> functions will allocate about 530KB memory.
>>>>
>>>> I'm not so familier with how the BTF is generated, what about making this
>>>> list offline? Since BTF is static data, it is better to make the map when
>>>
>>> The BTF is generated by pahole during the building of the kernel or
>>> modules.
>>> Pahole is maintained in the project https://github.com/acmel/dwarves.
>>> The log
>>> printed by scripts/link-vmlinux.sh when generating BTF for vmlinux is as
>>> follows:
>>>
>>> LLVM_OBJCOPY=objcopy pahole -J --skip_encoding_btf_vars --btf_gen_floats
>>> .tmp_vmlinux.btf
>>>
>>> If making the list offline, the pahole needs to be modified or a new tool
>>> needs to be written and maintained in the kernel tree. Therefore, it may
>>> be simpler to make the list at runtime.
> 
> Hmm, I'm not convinced, since this push the sorting cost to the kernel
> boot process. To reduce the kernel boot time we need to drop this improvement.
> But if pahole just sort it offline, in any case we can use this.

Thank you, I agree. In a separate thread, Eduard and Alexei also proposed
modifying the pahole. I will analyze the pahole and conduct a test.

> 
>>>
>>>> it is built. And I also would like to suggest to make a new map to make
>>>> another new map which maps the BTF ID and the address of the function, so
>>>> that we can do binary search the BTF object from the function address.
>>>> (The latter map should be built when CONFIG_BTF_ADDR_MAP=y)
>>>
>>> It has been observed that two or more functions may have the same address
>>> but different IDs. For example:
>>>
>>>           ffffffff81218370 t __do_sys_getuid16
>>>           ffffffff81218370 T __ia32_sys_getuid16
>>>           ffffffff81218370 T __x64_sys_getuid16
>>>
>>>           {
>>>               "id": 27911,
>>>               "kind": "FUNC",
>>>               "name": "__do_sys_getuid16",
>>>               "type_id": 4455,
>>>               "linkage": "static"
>>>           },{
>>>               "id": 20303,
>>>               "kind": "FUNC",
>>>               "name": "__ia32_sys_getuid16",
>>>               "type_id": 4455,
>>>               "linkage": "static"
>>>           },{
>>>               "id": 20304,
>>>               "kind": "FUNC",
>>>               "name": "__x64_sys_getuid16",
>>>               "type_id": 4455,
>>>               "linkage": "static"
>>>           },
>>>
>>> It may be a issue to return which id. However, if only the FUNC_PROTO is
>>> of concern, any one of them can be returned.
> 
> In this case, since those have same type_id, returning either one is
> good enough. Since those have same address, we can not identify even
> if we use kallsyms ;)

Yeah.

> 
>>>
>>> It may not be necessary to create a new list for function addresses because
>>>    the id_name map can be reused for this purpose. Here is an idea:
>>>
>>> 1. Use the function address to get the name by calling the function
>>>    sprint_symbol_no_offset.
>>>
>>> 2. Then call the function btf_find_by_name_kind to get the BTF ID.
>>>
>>> Both sprint_symbol_no_offset and btf_find_by_name_kind use binary search.
>>>
>>
>> Here is a time-consuming test to compare two methods for finding all the
>> IDs of 67,823 kernel function by their addresses:
>>
>> 1. Using a new map for function addresses took 4 ms.
>>
>> 2. Using sprint_symbol_no_offset + btf_find_by_name_kind took 38 ms.
>>
>> However, the former method requires more memory. For example, if we use
>> the following structure to hold the function address and the BTF ID:
>>
>> struct btf_id_func {
>> 	void *addr;
>> 	int id;
>> };
>>
>> We would need to allocate 1059K (67823 * 16) of memory.
> 
> OK, then it can be optional. Anyway, currently only kprobe event will
> need it but in the cold path.

Yeah, it appears that we need to utilize method 2 or explore alternateive
approaches.

> 
> Thank you,
> 
>>
>>>>
>>>> Thank you,
>>>>
>>>>>
>>>>> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
>>>>> ---
>>>>> Changes in RFC v2:
>>>>>    - Fix the build issue reported by kernel test robot <lkp@intel.com>
>>>>> ---
>>>>>    include/linux/btf.h |   1 +
>>>>>    kernel/bpf/btf.c    | 300 ++++++++++++++++++++++++++++++++++++++++++--
>>>>>    2 files changed, 291 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>>>> index cac9f304e27a..6260a0668773 100644
>>>>> --- a/include/linux/btf.h
>>>>> +++ b/include/linux/btf.h
>>>>> @@ -201,6 +201,7 @@ bool btf_is_kernel(const struct btf *btf);
>>>>>    bool btf_is_module(const struct btf *btf);
>>>>>    struct module *btf_try_get_module(const struct btf *btf);
>>>>>    u32 btf_nr_types(const struct btf *btf);
>>>>> +u32 btf_type_cnt(const struct btf *btf);
>>>>>    bool btf_member_is_reg_int(const struct btf *btf, const struct
>>>>> btf_type *s,
>>>>>                   const struct btf_member *m,
>>>>>                   u32 expected_offset, u32 expected_size);
>>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>>> index 817204d53372..51aa9f27853b 100644
>>>>> --- a/kernel/bpf/btf.c
>>>>> +++ b/kernel/bpf/btf.c
>>>>> @@ -240,6 +240,26 @@ struct btf_id_dtor_kfunc_tab {
>>>>>        struct btf_id_dtor_kfunc dtors[];
>>>>>    };
>>>>> +enum {
>>>>> +    BTF_ID_NAME_FUNC,    /* function */
>>>>> +    BTF_ID_NAME_STRUCT,    /* struct */
>>>>> +    BTF_ID_NAME_MAX
>>>>> +};
>>>>> +
>>>>> +struct btf_id_name {
>>>>> +    int id;
>>>>> +    u32 name_off;
>>>>> +};
>>>>> +
>>>>> +struct btf_id_name_map {
>>>>> +    struct btf_id_name *id_name;
>>>>> +    u32 count;
>>>>> +};
>>>>> +
>>>>> +struct btf_id_name_maps {
>>>>> +    struct btf_id_name_map map[BTF_ID_NAME_MAX];
>>>>> +};
>>>>> +
>>>>>    struct btf {
>>>>>        void *data;
>>>>>        struct btf_type **types;
>>>>> @@ -257,6 +277,7 @@ struct btf {
>>>>>        struct btf_kfunc_set_tab *kfunc_set_tab;
>>>>>        struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
>>>>>        struct btf_struct_metas *struct_meta_tab;
>>>>> +    struct btf_id_name_maps *id_name_maps;
>>>>>        /* split BTF support */
>>>>>        struct btf *base_btf;
>>>>> @@ -532,22 +553,142 @@ u32 btf_nr_types(const struct btf *btf)
>>>>>        return total;
>>>>>    }
>>>>> +u32 btf_type_cnt(const struct btf *btf)
>>>>> +{
>>>>> +    return btf->start_id + btf->nr_types;
>>>>> +}
>>>>> +
>>>>> +static inline u8 btf_id_name_idx_to_kind(int index)
>>>>> +{
>>>>> +    u8 kind;
>>>>> +
>>>>> +    switch (index) {
>>>>> +    case BTF_ID_NAME_FUNC:
>>>>> +        kind = BTF_KIND_FUNC;
>>>>> +        break;
>>>>> +    case BTF_ID_NAME_STRUCT:
>>>>> +        kind = BTF_KIND_STRUCT;
>>>>> +        break;
>>>>> +    default:
>>>>> +        kind = BTF_KIND_UNKN;
>>>>> +        break;
>>>>> +    }
>>>>> +
>>>>> +    return kind;
>>>>> +}
>>>>> +
>>>>> +static inline int btf_id_name_kind_to_idx(u8 kind)
>>>>> +{
>>>>> +    int index;
>>>>> +
>>>>> +    switch (kind) {
>>>>> +    case BTF_KIND_FUNC:
>>>>> +        index = BTF_ID_NAME_FUNC;
>>>>> +        break;
>>>>> +    case BTF_KIND_STRUCT:
>>>>> +        index = BTF_ID_NAME_STRUCT;
>>>>> +        break;
>>>>> +    default:
>>>>> +        index = -1;
>>>>> +        break;
>>>>> +    }
>>>>> +
>>>>> +    return index;
>>>>> +}
>>>>> +
>>>>> +static s32 btf_find_by_name_bsearch(struct btf_id_name *id_name,
>>>>> +                    u32 size, const char *name,
>>>>> +                    struct btf_id_name **start,
>>>>> +                    struct btf_id_name **end,
>>>>> +                    const struct btf *btf)
>>>>> +{
>>>>> +    int ret;
>>>>> +    int low, mid, high;
>>>>> +    const char *name_buf;
>>>>> +
>>>>> +    low = 0;
>>>>> +    high = size - 1;
>>>>> +
>>>>> +    while (low <= high) {
>>>>> +        mid = low + (high - low) / 2;
>>>>> +        name_buf = btf_name_by_offset(btf, id_name[mid].name_off);
>>>>> +        ret = strcmp(name, name_buf);
>>>>> +        if (ret > 0)
>>>>> +            low = mid + 1;
>>>>> +        else if (ret < 0)
>>>>> +            high = mid - 1;
>>>>> +        else
>>>>> +            break;
>>>>> +    }
>>>>> +
>>>>> +    if (low > high)
>>>>> +        return -ESRCH;
>>>>> +
>>>>> +    if (start) {
>>>>> +        low = mid;
>>>>> +        while (low) {
>>>>> +            name_buf = btf_name_by_offset(btf,
>>>>> id_name[low-1].name_off);
>>>>> +            if (strcmp(name, name_buf))
>>>>> +                break;
>>>>> +            low--;
>>>>> +        }
>>>>> +        *start = &id_name[low];
>>>>> +    }
>>>>> +
>>>>> +    if (end) {
>>>>> +        high = mid;
>>>>> +        while (high < size - 1) {
>>>>> +            name_buf = btf_name_by_offset(btf,
>>>>> id_name[high+1].name_off);
>>>>> +            if (strcmp(name, name_buf))
>>>>> +                break;
>>>>> +            high++;
>>>>> +        }
>>>>> +        *end = &id_name[high];
>>>>> +    }
>>>>> +
>>>>> +    return id_name[mid].id;
>>>>> +}
>>>>> +
>>>>>    s32 btf_find_by_name_kind(const struct btf *btf, const char *name,
>>>>> u8 kind)
>>>>>    {
>>>>> +    const struct btf_id_name_maps *maps;
>>>>> +    const struct btf_id_name_map *map;
>>>>> +    struct btf_id_name *start;
>>>>>        const struct btf_type *t;
>>>>>        const char *tname;
>>>>> -    u32 i, total;
>>>>> +    int index = btf_id_name_kind_to_idx(kind);
>>>>> +    s32 id, total;
>>>>> -    total = btf_nr_types(btf);
>>>>> -    for (i = 1; i < total; i++) {
>>>>> -        t = btf_type_by_id(btf, i);
>>>>> -        if (BTF_INFO_KIND(t->info) != kind)
>>>>> -            continue;
>>>>> +    do {
>>>>> +        maps = btf->id_name_maps;
>>>>> +        if (index >= 0 && maps && maps->map[index].id_name) {
>>>>> +            /* binary search */
>>>>> +            map = &maps->map[index];
>>>>> +            id = btf_find_by_name_bsearch(map->id_name,
>>>>> +                map->count, name, &start, NULL, btf);
>>>>> +            if (id > 0) {
>>>>> +                /*
>>>>> +                 * Return the first one that
>>>>> +                 * matched
>>>>> +                 */
>>>>> +                return start->id;
>>>>> +            }
>>>>> +        } else {
>>>>> +            /* linear search */
>>>>> +            total = btf_type_cnt(btf);
>>>>> +            for (id = btf->start_id; id < total; id++) {
>>>>> +                t = btf_type_by_id(btf, id);
>>>>> +                if (BTF_INFO_KIND(t->info) != kind)
>>>>> +                    continue;
>>>>> +
>>>>> +                tname = btf_name_by_offset(btf, t->name_off);
>>>>> +                if (!strcmp(tname, name))
>>>>> +                    return id;
>>>>> +            }
>>>>> +        }
>>>>> -        tname = btf_name_by_offset(btf, t->name_off);
>>>>> -        if (!strcmp(tname, name))
>>>>> -            return i;
>>>>> -    }
>>>>> +        btf = btf->base_btf;
>>>>> +    } while (btf);
>>>>>        return -ENOENT;
>>>>>    }
>>>>> @@ -1639,6 +1780,32 @@ static void btf_free_id(struct btf *btf)
>>>>>        spin_unlock_irqrestore(&btf_idr_lock, flags);
>>>>>    }
>>>>> +static void btf_destroy_id_name(struct btf *btf, int index)
>>>>> +{
>>>>> +    struct btf_id_name_maps *maps = btf->id_name_maps;
>>>>> +    struct btf_id_name_map *map = &maps->map[index];
>>>>> +
>>>>> +    if (map->id_name) {
>>>>> +        kvfree(map->id_name);
>>>>> +        map->id_name = NULL;
>>>>> +        map->count = 0;
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +static void btf_destroy_id_name_map(struct btf *btf)
>>>>> +{
>>>>> +    int i;
>>>>> +
>>>>> +    if (!btf->id_name_maps)
>>>>> +        return;
>>>>> +
>>>>> +    for (i = 0; i < BTF_ID_NAME_MAX; i++)
>>>>> +        btf_destroy_id_name(btf, i);
>>>>> +
>>>>> +    kfree(btf->id_name_maps);
>>>>> +    btf->id_name_maps = NULL;
>>>>> +}
>>>>> +
>>>>>    static void btf_free_kfunc_set_tab(struct btf *btf)
>>>>>    {
>>>>>        struct btf_kfunc_set_tab *tab = btf->kfunc_set_tab;
>>>>> @@ -1689,6 +1856,7 @@ static void btf_free_struct_meta_tab(struct btf
>>>>> *btf)
>>>>>    static void btf_free(struct btf *btf)
>>>>>    {
>>>>> +    btf_destroy_id_name_map(btf);
>>>>>        btf_free_struct_meta_tab(btf);
>>>>>        btf_free_dtor_kfunc_tab(btf);
>>>>>        btf_free_kfunc_set_tab(btf);
>>>>> @@ -5713,6 +5881,107 @@ int get_kern_ctx_btf_id(struct
>>>>> bpf_verifier_log *log, enum bpf_prog_type prog_ty
>>>>>        return kctx_type_id;
>>>>>    }
>>>>> +static int btf_compare_id_name(const void *a, const void *b, const
>>>>> void *priv)
>>>>> +{
>>>>> +    const struct btf_id_name *ia = (const struct btf_id_name *)a;
>>>>> +    const struct btf_id_name *ib = (const struct btf_id_name *)b;
>>>>> +    const struct btf *btf = priv;
>>>>> +    int ret;
>>>>> +
>>>>> +    /*
>>>>> +     * Sort names in ascending order, if the name is same, sort ids in
>>>>> +     * ascending order.
>>>>> +     */
>>>>> +    ret = strcmp(btf_name_by_offset(btf, ia->name_off),
>>>>> +             btf_name_by_offset(btf, ib->name_off));
>>>>> +    if (!ret)
>>>>> +        ret = ia->id - ib->id;
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +static int btf_create_id_name(struct btf *btf, int index)
>>>>> +{
>>>>> +    struct btf_id_name_maps *maps = btf->id_name_maps;
>>>>> +    struct btf_id_name_map *map = &maps->map[index];
>>>>> +    const struct btf_type *t;
>>>>> +    struct btf_id_name *id_name;
>>>>> +    const char *name;
>>>>> +    int i, j = 0;
>>>>> +    u32 total, count = 0;
>>>>> +    u8 kind;
>>>>> +
>>>>> +    kind = btf_id_name_idx_to_kind(index);
>>>>> +    if (kind == BTF_KIND_UNKN)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (map->id_name || map->count != 0)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    total = btf_type_cnt(btf);
>>>>> +    for (i = btf->start_id; i < total; i++) {
>>>>> +        t = btf_type_by_id(btf, i);
>>>>> +        if (BTF_INFO_KIND(t->info) != kind)
>>>>> +            continue;
>>>>> +        name = btf_name_by_offset(btf, t->name_off);
>>>>> +        if (str_is_empty(name))
>>>>> +            continue;
>>>>> +        count++;
>>>>> +    }
>>>>> +
>>>>> +    if (count == 0)
>>>>> +        return 0;
>>>>> +
>>>>> +    id_name = kvcalloc(count, sizeof(struct btf_id_name),
>>>>> +               GFP_KERNEL);
>>>>> +    if (!id_name)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    for (i = btf->start_id; i < total; i++) {
>>>>> +        t = btf_type_by_id(btf, i);
>>>>> +        if (BTF_INFO_KIND(t->info) != kind)
>>>>> +            continue;
>>>>> +        name = btf_name_by_offset(btf, t->name_off);
>>>>> +        if (str_is_empty(name))
>>>>> +            continue;
>>>>> +
>>>>> +        id_name[j].id = i;
>>>>> +        id_name[j].name_off = t->name_off;
>>>>> +        j++;
>>>>> +    }
>>>>> +
>>>>> +    sort_r(id_name, count, sizeof(id_name[0]), btf_compare_id_name,
>>>>> +           NULL, btf);
>>>>> +
>>>>> +    map->id_name = id_name;
>>>>> +    map->count = count;
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int btf_create_id_name_map(struct btf *btf)
>>>>> +{
>>>>> +    int err, i;
>>>>> +    struct btf_id_name_maps *maps;
>>>>> +
>>>>> +    if (btf->id_name_maps)
>>>>> +        return -EBUSY;
>>>>> +
>>>>> +    maps = kzalloc(sizeof(struct btf_id_name_maps), GFP_KERNEL);
>>>>> +    if (!maps)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    btf->id_name_maps = maps;
>>>>> +
>>>>> +    for (i = 0; i < BTF_ID_NAME_MAX; i++) {
>>>>> +        err = btf_create_id_name(btf, i);
>>>>> +        if (err < 0)
>>>>> +            break;
>>>>> +    }
>>>>> +
>>>>> +    return err;
>>>>> +}
>>>>> +
>>>>>    BTF_ID_LIST(bpf_ctx_convert_btf_id)
>>>>>    BTF_ID(struct, bpf_ctx_convert)
>>>>> @@ -5760,6 +6029,10 @@ struct btf *btf_parse_vmlinux(void)
>>>>>        if (err)
>>>>>            goto errout;
>>>>> +    err = btf_create_id_name_map(btf);
>>>>> +    if (err)
>>>>> +        goto errout;
>>>>> +
>>>>>        /* btf_parse_vmlinux() runs under bpf_verifier_lock */
>>>>>        bpf_ctx_convert.t = btf_type_by_id(btf,
>>>>> bpf_ctx_convert_btf_id[0]);
>>>>> @@ -5777,6 +6050,7 @@ struct btf *btf_parse_vmlinux(void)
>>>>>    errout:
>>>>>        btf_verifier_env_free(env);
>>>>>        if (btf) {
>>>>> +        btf_destroy_id_name_map(btf);
>>>>>            kvfree(btf->types);
>>>>>            kfree(btf);
>>>>>        }
>>>>> @@ -5844,13 +6118,19 @@ static struct btf *btf_parse_module(const
>>>>> char *module_name, const void *data, u
>>>>>        if (err)
>>>>>            goto errout;
>>>>> +    err = btf_create_id_name_map(btf);
>>>>> +    if (err)
>>>>> +        goto errout;
>>>>> +
>>>>>        btf_verifier_env_free(env);
>>>>>        refcount_set(&btf->refcnt, 1);
>>>>> +
>>>>>        return btf;
>>>>>    errout:
>>>>>        btf_verifier_env_free(env);
>>>>>        if (btf) {
>>>>> +        btf_destroy_id_name_map(btf);
>>>>>            kvfree(btf->data);
>>>>>            kvfree(btf->types);
>>>>>            kfree(btf);
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>>>
>>>>
>>>
>>
> 
> 


