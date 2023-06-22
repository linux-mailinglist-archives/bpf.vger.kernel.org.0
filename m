Return-Path: <bpf+bounces-3191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A37773A967
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439A8281AEC
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 20:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C7E21097;
	Thu, 22 Jun 2023 20:18:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C92107D
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 20:18:16 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F6B1FEF
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 13:18:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b50e309602so59760355ad.0
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687465085; x=1690057085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L6/YDhEIp4+RI9VYYWywVl/qUiLgJ26f2ce51Z3V3fk=;
        b=ZMbxZEndM+Njpoo0V/wQQrAu5Us/bWGR1xcJCca5FTG4INdHo5tgg1N70dhsTjXLND
         55iCAOvb20JyaIttYI3Qh+QnGjqLfOA8Ge7bZtkwt89MNlSRFhQqkSIj3EA30nlF9Hhy
         bnUz2dtBf5XvaTwDNCmHPegF0gdFyY+9QnIJSJESa7iStLu3gfZuKQUujhf+W+HiIItV
         Y89iVPj/n8Wc8NjrSb8J1EjD7mNTKPTQ0KMnc/iFWTUTlTrW5yug3Tl7tZRZfHEGMz9h
         oLz3WM3FCjj4fys6BqAwDUwgfKow8/FXzNj8ECebl6ehnuIVvILZmDkQ+Q4Wdt39yY+m
         P/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687465085; x=1690057085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6/YDhEIp4+RI9VYYWywVl/qUiLgJ26f2ce51Z3V3fk=;
        b=f063kIZYLIUj4VcES7K0GKbXfhwTtlkIAiCcA6mJFmuXR+T4yG3c5QpJbDLq8Wwb72
         er+CQOt1p9Sq11/xRpvNHNRA76Xr0fU7OyCWcy3AIQHczUxE7qBYkUaYDrL4RnMnDinh
         3SvidTyoq1Eb8S5eapahX2pHd4rcKcS10dVttPRZaehD31+P+9sfYG8nM7aRGRG31n6N
         2+aq1jylQc4V8VD6z/UkVn5xOd4vu/Jh5LJOrDuZdhcEpeLVJzF5Yk2PPqPnqzP4Trg+
         acAgdfqfx6logO1k5aAF7AxZZBzAJA+RPgwh6Nm6ivalbfG9FzN4FEJdT8qnKdxkIbwD
         KWjA==
X-Gm-Message-State: AC+VfDwBa5mJ0RklpA4UGjDraApA8+q9AK0SqZq4EYBDn0mbkP1GwNlf
	BcgFtJ6tSMCblgw6oii+BHkuu7QG9v4=
X-Google-Smtp-Source: ACHHUZ7X6nbFc8BY9sVATzXy2sJKddFrIZ0yBHU+VenaONvCRDapODPK7hg96RdQG89l2xHd9OcUzA==
X-Received: by 2002:a17:902:8489:b0:1b3:d357:5ea6 with SMTP id c9-20020a170902848900b001b3d3575ea6mr16807656plo.53.1687465084947;
        Thu, 22 Jun 2023 13:18:04 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::4:95b5])
        by smtp.gmail.com with ESMTPSA id ja4-20020a170902efc400b001b55fe1b471sm5755845plb.302.2023.06.22.13.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:18:04 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:18:01 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [RFC v2 PATCH bpf-next 2/4] bpf: populate the per-cpu
 insertions/deletions counters for hashmaps
Message-ID: <20230622201801.4vjk3bu2kcywocy7@macbook-pro-8.dhcp.thefacebook.com>
References: <20230622095330.1023453-1-aspsk@isovalent.com>
 <20230622095330.1023453-3-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622095330.1023453-3-aspsk@isovalent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 09:53:28AM +0000, Anton Protopopov wrote:
> Initialize and utilize the per-cpu insertions/deletions counters for hash-based
> maps. The non-trivial changes only apply to the preallocated maps for which the
> inc_elem_count/dec_elem_count functions were not called before.
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  kernel/bpf/hashtab.c | 102 +++++++++++++++++++++++++------------------
>  1 file changed, 60 insertions(+), 42 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9901efee4339..0b4a2d61afa9 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -217,6 +217,49 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
>  	return !htab_is_percpu(htab) && !htab_is_lru(htab);
>  }
>  
> +/* compute_batch_value() computes batch value as num_online_cpus() * 2
> + * and __percpu_counter_compare() needs
> + * htab->max_entries - cur_number_of_elems to be more than batch * num_online_cpus()
> + * for percpu_counter to be faster than atomic_t. In practice the average bpf
> + * hash map size is 10k, which means that a system with 64 cpus will fill
> + * hashmap to 20% of 10k before percpu_counter becomes ineffective. Therefore
> + * define our own batch count as 32 then 10k hash map can be filled up to 80%:
> + * 10k - 8k > 32 _batch_ * 64 _cpus_
> + * and __percpu_counter_compare() will still be fast. At that point hash map
> + * collisions will dominate its performance anyway. Assume that hash map filled
> + * to 50+% isn't going to be O(1) and use the following formula to choose
> + * between percpu_counter and atomic_t.
> + */

please split moving of helpers into separate patch.

> +#define PERCPU_COUNTER_BATCH 32
> +
> +static bool is_map_full(struct bpf_htab *htab)
> +{
> +	if (htab->use_percpu_counter)
> +		return __percpu_counter_compare(&htab->pcount, htab->map.max_entries,
> +						PERCPU_COUNTER_BATCH) >= 0;
> +	return atomic_read(&htab->count) >= htab->map.max_entries;
> +}
> +
> +static void inc_elem_count(struct bpf_htab *htab)
> +{
> +	bpf_map_inc_elements_counter(&htab->map);

and add this in the next patch.

> +
> +	if (htab->use_percpu_counter)
> +		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
> +	else
> +		atomic_inc(&htab->count);
> +}
> +
> +static void dec_elem_count(struct bpf_htab *htab)
> +{
> +	bpf_map_dec_elements_counter(&htab->map);
> +
> +	if (htab->use_percpu_counter)
> +		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
> +	else
> +		atomic_dec(&htab->count);
> +}
> +
>  static void htab_free_prealloced_timers(struct bpf_htab *htab)
>  {
>  	u32 num_entries = htab->map.max_entries;
> @@ -539,20 +582,6 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  
>  	htab_init_buckets(htab);
>  
> -/* compute_batch_value() computes batch value as num_online_cpus() * 2
> - * and __percpu_counter_compare() needs
> - * htab->max_entries - cur_number_of_elems to be more than batch * num_online_cpus()
> - * for percpu_counter to be faster than atomic_t. In practice the average bpf
> - * hash map size is 10k, which means that a system with 64 cpus will fill
> - * hashmap to 20% of 10k before percpu_counter becomes ineffective. Therefore
> - * define our own batch count as 32 then 10k hash map can be filled up to 80%:
> - * 10k - 8k > 32 _batch_ * 64 _cpus_
> - * and __percpu_counter_compare() will still be fast. At that point hash map
> - * collisions will dominate its performance anyway. Assume that hash map filled
> - * to 50+% isn't going to be O(1) and use the following formula to choose
> - * between percpu_counter and atomic_t.
> - */
> -#define PERCPU_COUNTER_BATCH 32
>  	if (attr->max_entries / 2 > num_online_cpus() * PERCPU_COUNTER_BATCH)
>  		htab->use_percpu_counter = true;
>  
> @@ -587,8 +616,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  		}
>  	}
>  
> +	err = bpf_map_init_elements_counter(&htab->map);
> +	if (err)
> +		goto free_extra_elements;
> +
>  	return &htab->map;
>  
> +free_extra_elements:
> +	free_percpu(htab->extra_elems);
>  free_prealloc:
>  	prealloc_destroy(htab);
>  free_map_locked:
> @@ -810,6 +845,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
>  		if (l == tgt_l) {
>  			hlist_nulls_del_rcu(&l->hash_node);
>  			check_and_free_fields(htab, l);
> +			dec_elem_count(htab);
>  			break;
>  		}
>  
> @@ -896,40 +932,16 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
>  	}
>  }
>  
> -static bool is_map_full(struct bpf_htab *htab)
> -{
> -	if (htab->use_percpu_counter)
> -		return __percpu_counter_compare(&htab->pcount, htab->map.max_entries,
> -						PERCPU_COUNTER_BATCH) >= 0;
> -	return atomic_read(&htab->count) >= htab->map.max_entries;
> -}
> -
> -static void inc_elem_count(struct bpf_htab *htab)
> -{
> -	if (htab->use_percpu_counter)
> -		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
> -	else
> -		atomic_inc(&htab->count);
> -}
> -
> -static void dec_elem_count(struct bpf_htab *htab)
> -{
> -	if (htab->use_percpu_counter)
> -		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
> -	else
> -		atomic_dec(&htab->count);
> -}
> -
> -
>  static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
>  {
>  	htab_put_fd_value(htab, l);
>  
> +	dec_elem_count(htab);
> +
>  	if (htab_is_prealloc(htab)) {
>  		check_and_free_fields(htab, l);
>  		__pcpu_freelist_push(&htab->freelist, &l->fnode);
>  	} else {
> -		dec_elem_count(htab);
>  		htab_elem_free(htab, l);
>  	}
>  }
> @@ -1006,6 +1018,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>  			if (!l)
>  				return ERR_PTR(-E2BIG);
>  			l_new = container_of(l, struct htab_elem, fnode);
> +			inc_elem_count(htab);
>  		}
>  	} else {
>  		if (is_map_full(htab))
> @@ -1227,9 +1240,11 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
>  	 * concurrent search will find it before old elem
>  	 */
>  	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> +	inc_elem_count(htab);
>  	if (l_old) {
>  		bpf_lru_node_set_ref(&l_new->lru_node);
>  		hlist_nulls_del_rcu(&l_old->hash_node);
> +		dec_elem_count(htab);

instead of inc and instant dec.
Please do inc once.

>  	}
>  	ret = 0;
>  
> @@ -1357,6 +1372,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>  		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
>  				value, onallcpus);
>  		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> +		inc_elem_count(htab);
>  		l_new = NULL;
>  	}
>  	ret = 0;
> @@ -1443,9 +1459,10 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
>  
>  	l = lookup_elem_raw(head, hash, key, key_size);
>  
> -	if (l)
> +	if (l) {
> +		dec_elem_count(htab);
>  		hlist_nulls_del_rcu(&l->hash_node);
> -	else
> +	} else
>  		ret = -ENOENT;
>  
>  	htab_unlock_bucket(htab, b, hash, flags);
> @@ -1529,6 +1546,7 @@ static void htab_map_free(struct bpf_map *map)
>  		prealloc_destroy(htab);
>  	}
>  
> +	bpf_map_free_elements_counter(map);
>  	free_percpu(htab->extra_elems);
>  	bpf_map_area_free(htab->buckets);
>  	bpf_mem_alloc_destroy(&htab->pcpu_ma);
> -- 
> 2.34.1
> 

