Return-Path: <bpf+bounces-17199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9BF80AA08
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A312628168D
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA3381CD;
	Fri,  8 Dec 2023 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LlxTNayf"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [IPv6:2001:41d0:203:375::b1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B72F19A4
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 09:07:24 -0800 (PST)
Message-ID: <0e657fc3-d932-4bd6-9d74-54eff22d3641@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702055241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sh7b/BLt4v+A8WqSZlTZ81a6oJLI6tyBwQwj5m2zKg=;
	b=LlxTNayfOfkLek70FuGcaB6xOrSE8MQUiFOXLCiHBKZxeDNpNKPXFEaVIRfb106k3oI2s8
	bhqwBKBpF5KKG7dvqVvKwqvSJfW3o4OtkiHiMq0D8i5vFq3gjmXIg0f6RVjMVDXg5sTuMM
	AyPkd980l6kHU24+WYQ7rgzaKqcFt0E=
Date: Fri, 8 Dec 2023 09:07:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4] bpf: Fix a race condition between btf_put()
 and map_free()
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20231206210959.1035724-1-yonghong.song@linux.dev>
 <d1c0232c-a41c-4cce-9bdf-3a1e8850ed05@linux.dev>
 <969852f3-34f8-45d9-bf2d-f6a4d5167e55@linux.dev>
 <ad71a99d-8b5f-44b4-99ee-5afb31c60bff@linux.dev>
 <0b3a96bd-4dfc-6d23-d473-f4351fbe84c2@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0b3a96bd-4dfc-6d23-d473-f4351fbe84c2@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/8/23 12:30 AM, Hou Tao wrote:
> Hi,
>
> On 12/8/2023 12:02 PM, Yonghong Song wrote:
>> On 12/7/23 7:59 PM, Yonghong Song wrote:
>>> On 12/7/23 5:23 PM, Martin KaFai Lau wrote:
>>>> On 12/6/23 1:09 PM, Yonghong Song wrote:
>>>>> When running `./test_progs -j` in my local vm with latest kernel,
>>>>> I once hit a kasan error like below:
>>>>>
>>>>>   
> SNIP
>>>>> Here, 'value_rec' is assigned in btf_check_and_fixup_fields() with
>>>>> following code:
>>>>>
>>>>>     meta = btf_find_struct_meta(btf, btf_id);
>>>>>     if (!meta)
>>>>>       return -EFAULT;
>>>>>     rec->fields[i].graph_root.value_rec = meta->record;
>>>>>
>>>>> So basically, 'value_rec' is a pointer to the record in
>>>>> struct_metas_tab.
>>>>> And it is possible that that particular record has been freed by
>>>>> btf_struct_metas_free() and hence we have a kasan error here.
>>>>>
>>>>> Actually it is very hard to reproduce the failure with current
>>>>> bpf/bpf-next
>>>>> code, I only got the above error once. To increase reproducibility,
>>>>> I added
>>>>> a delay in bpf_map_free_deferred() to delay map->ops->map_free(),
>>>>> which
>>>>> significantly increased reproducibility.
>>>>>
>>>>>     diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>>>     index 5e43ddd1b83f..aae5b5213e93 100644
>>>>>     --- a/kernel/bpf/syscall.c
>>>>>     +++ b/kernel/bpf/syscall.c
>>>>>     @@ -695,6 +695,7 @@ static void bpf_map_free_deferred(struct
>>>>> work_struct *work)
>>>>>           struct bpf_map *map = container_of(work, struct bpf_map,
>>>>> work);
>>>>>           struct btf_record *rec = map->record;
>>>>>
>>>>>     +     mdelay(100);
>>>>>           security_bpf_map_free(map);
>>>>>           bpf_map_release_memcg(map);
>>>>>           /* implementation dependent freeing */
>>>>>
>>>>> To fix the problem, we need to have a reference on btf in order to
>>>>> safeguard accessing field->graph_root.value_rec in
>>>>> map->ops->map_free().
>>>>> The function btf_parse_graph_root() is the place to get a btf
>>>>> reference.
>>>>> The following are rough call stacks reaching bpf_parse_graph_root():
>>>>>
>>>>>      btf_parse
>>>>>        ...
>>>>>          btf_parse_fields
>>>>>            ...
>>>>>              btf_parse_graph_root
>>>>>
>>>>>      map_check_btf
>>>>>        btf_parse_fields
>>>>>          ...
>>>>>            btf_parse_graph_root
>>>>>
>>>>> Looking at the above call stack, the btf_parse_graph_root() is
>>>>> indirectly
>>>>> called from btf_parse() or map_check_btf().
>>>>>
>>>>> We cannot take a reference in btf_parse() case since at that moment,
>>>>> btf is still in the middle to self-validation and initial reference
>>>>> (refcount_set(&btf->refcnt, 1)) has not been triggered yet.
>>>> Thanks for the details analysis and clear explanation. It helps a lot.
>>>>
>>>> Sorry for jumping in late.
>>>>
>>>> I am trying to avoid making a special case for "bool has_btf_ref;"
>>>> and "bool from_map_check". It seems to a bit too much to deal with
>>>> the error path for btf_parse().
> Maybe we could move the common btf used by kptr and graph_root into
> bpf_record and let the callers of btf_parse_fields()  and
> btf_record_free() to decide the life cycle of btf in btf_record, so
> there will be less intrusive and less special case. The following is the

I didn't fully check the code but looks like we took a
btf reference at map_check_btf() and free it at the end
of bpf_map_free_deferred(). This is similar to my v1 patch,
not exactly the same but similar since they all do
btf_put() at the end of bpf_map_free_deferred().

Through discussion, doing on-demand btf_get()/btf_put()
approach, similar to kptr approach, seems more favored.
This also has advantage to free btf at its earlist possible
point.

> code snippets for the idea (only simply tested):
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1ad0ed623f50..a0c4d696a231 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -230,6 +230,7 @@ struct btf_record {
>          int spin_lock_off;
>          int timer_off;
>          int refcount_off;
> +       struct btf *btf;
>          struct btf_field fields[];
>   };
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 966dace27fae..08b4a2784ee4 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3598,7 +3598,6 @@ static int btf_parse_kptr(struct btf *btf, struct
> btf_field *field,
>                  field->kptr.dtor = NULL;
>                  id = info->kptr.type_id;
>                  kptr_btf = btf;
> -               btf_get(kptr_btf);
>                  goto found_dtor;
>          }
>          if (id < 0)
> @@ -3753,6 +3752,7 @@ struct btf_record *btf_parse_fields(struct btf
> *btf, const struct btf_type *t,
>          if (!rec)
>                  return ERR_PTR(-ENOMEM);
>
> +       rec->btf = btf;
>          rec->spin_lock_off = -EINVAL;
>          rec->timer_off = -EINVAL;
>          rec->refcount_off = -EINVAL;
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 8ef269e66ba5..d9f4198158b6 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -56,6 +56,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>                  ret = PTR_ERR(inner_map_meta->record);
>                  goto free;
>          }
> +       if (inner_map_meta->record)
> +               btf_get(inner_map_meta->record->btf);
> +
>          /* Note: We must use the same BTF, as we also used
> btf_record_dup above
>           * which relies on BTF being same for both maps, as some members
> like
>           * record->fields.list_head have pointers like value_rec
> pointing into
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 30ed7756fc71..d2641e51a1a7 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -516,7 +516,8 @@ void btf_record_free(struct btf_record *rec)
>                  case BPF_KPTR_PERCPU:
>                          if (rec->fields[i].kptr.module)
>                                  module_put(rec->fields[i].kptr.module);
> -                       btf_put(rec->fields[i].kptr.btf);
> +                       if (rec->fields[i].kptr.btf != rec->btf)
> +                               btf_put(rec->fields[i].kptr.btf);
>                          break;
>                  case BPF_LIST_HEAD:
>                  case BPF_LIST_NODE:
> @@ -537,8 +538,13 @@ void btf_record_free(struct btf_record *rec)
>
>   void bpf_map_free_record(struct bpf_map *map)
>   {
> +       struct btf *btf = NULL;
> +
> +       if (!IS_ERR_OR_NULL(map->record))
> +               btf = map->record->btf;
>          btf_record_free(map->record);
>          map->record = NULL;
> +       btf_put(btf);
>   }
>
>   struct btf_record *btf_record_dup(const struct btf_record *rec)
> @@ -561,7 +567,8 @@ struct btf_record *btf_record_dup(const struct
> btf_record *rec)
>                  case BPF_KPTR_UNREF:
>                  case BPF_KPTR_REF:
>                  case BPF_KPTR_PERCPU:
> -                       btf_get(fields[i].kptr.btf);
> +                       if (fields[i].kptr.btf != rec->btf)
> +                               btf_get(fields[i].kptr.btf);
>                          if (fields[i].kptr.module &&
> !try_module_get(fields[i].kptr.module)) {
>                                  ret = -ENXIO;
>                                  goto free;
> @@ -692,7 +699,10 @@ static void bpf_map_free_deferred(struct
> work_struct *work)
>   {
>          struct bpf_map *map = container_of(work, struct bpf_map, work);
>          struct btf_record *rec = map->record;
> +       struct btf *btf = NULL;
>
> +       if (!IS_ERR_OR_NULL(rec))
> +               btf = rec->btf;
>          security_bpf_map_free(map);
>          bpf_map_release_memcg(map);
>          /* implementation dependent freeing */
> @@ -707,6 +717,7 @@ static void bpf_map_free_deferred(struct work_struct
> *work)
>           * template bpf_map struct used during verification.
>           */
>          btf_record_free(rec);
> +       btf_put(btf);
>   }
>
>   static void bpf_map_put_uref(struct bpf_map *map)
> @@ -1036,6 +1047,8 @@ static int map_check_btf(struct bpf_map *map,
> struct btf *btf,
>          if (!IS_ERR_OR_NULL(map->record)) {
>                  int i;
>
> +               btf_get(map->record->btf);
> +
>                  if (!bpf_capable()) {
>                          ret = -EPERM;
>                          goto free_map_tab;
>
>
>
> WDYT ?
>
>>>> Would doing the refcount_set(&btf->refcnt, 1) earlier in btf_parse
>>>> help?
>>> No, it does not. The core reason is what Hao is mentioned in
>>> https://lore.kernel.org/bpf/47ee3265-23f7-2130-ff28-27bfaf3f7877@huaweicloud.com/
>>>
>>> We simply cannot take btf reference if called from btf_parse().
>>> Let us say we move refcount_set(&btf->refcnt, 1) earlier in btf_parse()
>>> so we take ref for btf during btf_parse_fields(), then we have
>>>       btf_put <=== expect refcount == 0 to start the destruction process
>>>         ...
>>>           btf_record_free <=== in which if graph_root, a btf reference
>>> will be hold
>>> so btf_put will never be able to actually free btf data.
>>> Yes, the kasan problem will be resolved but we leak memory.
>> Let me send another version with better commit message.
>
>> [...]

