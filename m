Return-Path: <bpf+bounces-3980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A324B74735F
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 15:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F247280EC4
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6A5613A;
	Tue,  4 Jul 2023 13:56:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E735A2575
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 13:56:47 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1076ABE
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 06:56:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QwPTz6P89z4f3m8k
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 21:56:39 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAnuDIUJaRkFLrrMQ--.60773S2;
	Tue, 04 Jul 2023 21:56:40 +0800 (CST)
Subject: Re: [v3 PATCH bpf-next 3/6] bpf: populate the per-cpu
 insertions/deletions counters for hashmaps
To: Anton Protopopov <aspsk@isovalent.com>
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-4-aspsk@isovalent.com>
From: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Message-ID: <05a3c521-3c6f-79c2-a5a8-1f8ab35eb759@huaweicloud.com>
Date: Tue, 4 Jul 2023 21:56:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230630082516.16286-4-aspsk@isovalent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAnuDIUJaRkFLrrMQ--.60773S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4xtr4DCF15WFyktw13urg_yoWrtryUpF
	W8Gw4jkw1rZrsrK3yfXw4rKrW3Xw1Fq3W5Kay5Ka4FkF98Wrnagw1UAF17KFn8CrW8ZFn5
	Xrs09w4rCay2krJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/30/2023 4:25 PM, Anton Protopopov wrote:
> Initialize and utilize the per-cpu insertions/deletions counters for hash-based
> maps. Non-trivial changes only apply to the preallocated maps for which the
> {inc,dec}_elem_count functions are not called, as there's no need in counting
> elements to sustain proper map operations.
>
> To increase/decrease percpu counters for preallocated maps we add raw calls to
> the bpf_map_{inc,dec}_elem_count functions so that the impact is minimal. For
> dynamically allocated maps we add corresponding calls to the existing
> {inc,dec}_elem_count functions.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 56d3da7d0bc6..faaef4fd3df0 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -581,8 +581,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  		}
>  	}
>  
> +	err = bpf_map_init_elem_count(&htab->map);
> +	if (err)
> +		goto free_extra_elements;
Considering the per-cpu counter is not always needed, is it a good idea
to make the elem_count being optional by introducing a new map flag ?
> +
>  	return &htab->map;
>  
> +free_extra_elements:
> +	free_percpu(htab->extra_elems);
>  free_prealloc:
>  	prealloc_destroy(htab);
Need to check prealloc before calling prealloc_destroy(htab), otherwise
for non-preallocated percpu htab prealloc_destroy() will trigger invalid
memory dereference.
>  free_map_locked:
> @@ -804,6 +810,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
>  		if (l == tgt_l) {
>  			hlist_nulls_del_rcu(&l->hash_node);
>  			check_and_free_fields(htab, l);
> +			bpf_map_dec_elem_count(&htab->map);
>  			break;
>  		}
>  
> @@ -900,6 +907,8 @@ static bool is_map_full(struct bpf_htab *htab)
>  
>  static void inc_elem_count(struct bpf_htab *htab)
>  {
> +	bpf_map_inc_elem_count(&htab->map);
> +
>  	if (htab->use_percpu_counter)
>  		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
>  	else
> @@ -908,6 +917,8 @@ static void inc_elem_count(struct bpf_htab *htab)
>  
>  static void dec_elem_count(struct bpf_htab *htab)
>  {
> +	bpf_map_dec_elem_count(&htab->map);
> +
>  	if (htab->use_percpu_counter)
>  		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
>  	else
> @@ -920,6 +931,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
>  	htab_put_fd_value(htab, l);
>  
>  	if (htab_is_prealloc(htab)) {
> +		bpf_map_dec_elem_count(&htab->map);
>  		check_and_free_fields(htab, l);
>  		__pcpu_freelist_push(&htab->freelist, &l->fnode);
>  	} else {
> @@ -1000,6 +1012,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>  			if (!l)
>  				return ERR_PTR(-E2BIG);
>  			l_new = container_of(l, struct htab_elem, fnode);
> +			bpf_map_inc_elem_count(&htab->map);
>  		}
>  	} else {
>  		if (is_map_full(htab))
> @@ -1224,7 +1237,8 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
>  	if (l_old) {
>  		bpf_lru_node_set_ref(&l_new->lru_node);
>  		hlist_nulls_del_rcu(&l_old->hash_node);
> -	}
> +	} else
> +		bpf_map_inc_elem_count(&htab->map);
>  	ret = 0;
>  
>  err:
> @@ -1351,6 +1365,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>  		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
>  				value, onallcpus);
>  		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> +		bpf_map_inc_elem_count(&htab->map);
>  		l_new = NULL;
>  	}
>  	ret = 0;
> @@ -1437,9 +1452,10 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
>  
>  	l = lookup_elem_raw(head, hash, key, key_size);
>  
> -	if (l)
> +	if (l) {
> +		bpf_map_dec_elem_count(&htab->map);
>  		hlist_nulls_del_rcu(&l->hash_node);
> -	else
> +	} else
>  		ret = -ENOENT;
Also need to decrease elem_count for
__htab_map_lookup_and_delete_batch() and
__htab_map_lookup_and_delete_elem() when is_lru_map is true. Maybe for
LRU map, we could just do bpf_map_dec_elem_count() in
htab_lru_push_free() and do bpf_map_inc_elem_count() in prealloc_lru_pop().
>  
>  	htab_unlock_bucket(htab, b, hash, flags);
> @@ -1523,6 +1539,7 @@ static void htab_map_free(struct bpf_map *map)
>  		prealloc_destroy(htab);
>  	}
>  
> +	bpf_map_free_elem_count(map);
>  	free_percpu(htab->extra_elems);
>  	bpf_map_area_free(htab->buckets);
>  	bpf_mem_alloc_destroy(&htab->pcpu_ma);


