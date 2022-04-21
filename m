Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0075095FA
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 06:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384107AbiDUE3q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 00:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384103AbiDUE3p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 00:29:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7704B12600
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 21:26:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s14so3708214plk.8
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 21:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HNwHx8lNmo88rNPMnQJovD1FyQp/19q7G0QyEjiTU/Q=;
        b=CJIAlkF39KGXG2KkEDro6HvMPoc1PHy8ttKVAUMhYruPhHxS5eRCbHguhACBOvTD8c
         O1yy/FHgrXFyRHrGQcfyR5OKuPO/sMdjXcRMPlaibOZpNuzwuBK/Ti7NrAHZROld9GpJ
         VgAvBkpOChWKiKRanA+5SB4sozahLkjrtfaAtYjYtqpJbmEMDwodlZ2FugtD4bwxbV3/
         OM/goey9g8paBGnfcIWRVO1ebRTK3IEYkeIboX8hiIiGjRSyoKUoHo5+JzSF/4TaNzF1
         SrbELi2QEgiuRAkS2A443QgxRb+nx1ladskKiJ+uNTrGITYV9bwZSX7Fe11v91OySR47
         weAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HNwHx8lNmo88rNPMnQJovD1FyQp/19q7G0QyEjiTU/Q=;
        b=aQGlTCLazRbWi8mFFDkQFfFPrK6S7GFnSpxtSkcR660Xwrg/sXR6PSe1Oh3alOoZFZ
         qK+JSjse0sxU/44INm1lwJenLRwSfGEwAw35ZL6JwZS1b8TUtG3B4PaQFEhAwydRO5fB
         wqX4TmoyviVxkF1DYgqeJybWtmep5cs3bfA/YtEI5dyefq91y+xX5fbaYUssoiiXjAKE
         D/1DldwMW1TDbOxJr3JwRIzEFBuYmv1LgMweexkfVzQAcPICpeAgqH/pzY/aFjP77B2l
         KlXsftc85IFHuqvkzvZZa+9A1XApDGuPdq5UIgNmWRbERqUSj+oJfUSKkwi3UX/ckm0Z
         uTCg==
X-Gm-Message-State: AOAM532IIIbMQfOFTzKEubzC3gh1JleXeSMQ2dFNzkKl3VXFU6J12DK5
        hNigD+1cOTaQCArLl7H8Kag=
X-Google-Smtp-Source: ABdhPJysvafEzdHMGw37yH1VdH3CICRtNwibQSbJY7L/E9oV93quAZ62mqt+Ueyd9SnSBWRy3ACdQw==
X-Received: by 2002:a17:90b:1e0e:b0:1d2:8906:cffe with SMTP id pg14-20020a17090b1e0e00b001d28906cffemr8305343pjb.220.1650515215820;
        Wed, 20 Apr 2022 21:26:55 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:4399])
        by smtp.gmail.com with ESMTPSA id v34-20020a634662000000b0039d3ce2e465sm20674537pgk.93.2022.04.20.21.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 21:26:54 -0700 (PDT)
Date:   Wed, 20 Apr 2022 21:26:51 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v5 09/13] bpf: Wire up freeing of referenced kptr
Message-ID: <20220421042651.sp45dcdzhyrbxbbg@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
 <20220415160354.1050687-10-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415160354.1050687-10-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 09:33:50PM +0530, Kumar Kartikeya Dwivedi wrote:
>  	return 0;
>  }
> @@ -386,6 +388,7 @@ static void array_map_free_timers(struct bpf_map *map)
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
>  	int i;
>  
> +	/* We don't reset or free kptr on uref dropping to zero. */
>  	if (likely(!map_value_has_timer(map)))

It was a copy paste mistake of mine to use likely() here in a cold
function. Let's not repeat it.

>  		return;
>  
> @@ -398,6 +401,13 @@ static void array_map_free_timers(struct bpf_map *map)
>  static void array_map_free(struct bpf_map *map)
>  {
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
> +	int i;
> +
> +	if (unlikely(map_value_has_kptrs(map))) {

Don't add unlikely() here.

> +		for (i = 0; i < array->map.max_entries; i++)
> +			bpf_map_free_kptrs(map, array->value + array->elem_size * i);
> +		bpf_map_free_kptr_off_tab(map);
> +	}
>  
>  	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
>  		bpf_array_free_percpu(array);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index fdb4d4971a2a..062a751c1595 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3415,6 +3415,8 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
>  {
>  	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
>  	struct bpf_map_value_off *tab;
> +	struct btf *off_btf = NULL;
> +	struct module *mod = NULL;
>  	int ret, i, nr_off;
>  
>  	/* Revisit stack usage when bumping BPF_MAP_VALUE_OFF_MAX */
> @@ -3433,7 +3435,6 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
>  
>  	for (i = 0; i < nr_off; i++) {
>  		const struct btf_type *t;
> -		struct btf *off_btf;
>  		s32 id;
>  
>  		t = btf_type_by_id(btf, info_arr[i].type_id);
> @@ -3444,16 +3445,69 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
>  			goto end;
>  		}
>  
> +		/* Find and stash the function pointer for the destruction function that
> +		 * needs to be eventually invoked from the map free path.
> +		 */
> +		if (info_arr[i].type == BPF_MAP_OFF_DESC_TYPE_REF_KPTR) {
> +			const struct btf_type *dtor_func;
> +			const char *dtor_func_name;
> +			unsigned long addr;
> +			s32 dtor_btf_id;
> +
> +			/* This call also serves as a whitelist of allowed objects that
> +			 * can be used as a referenced pointer and be stored in a map at
> +			 * the same time.
> +			 */
> +			dtor_btf_id = btf_find_dtor_kfunc(off_btf, id);
> +			if (dtor_btf_id < 0) {
> +				ret = dtor_btf_id;
> +				goto end_btf;
> +			}
> +
> +			dtor_func = btf_type_by_id(off_btf, dtor_btf_id);
> +			if (!dtor_func) {
> +				ret = -ENOENT;
> +				goto end_btf;
> +			}
> +
> +			if (btf_is_module(btf)) {
> +				mod = btf_try_get_module(off_btf);
> +				if (!mod) {
> +					ret = -ENXIO;
> +					goto end_btf;
> +				}
> +			}
> +
> +			/* We already verified dtor_func to be btf_type_is_func
> +			 * in register_btf_id_dtor_kfuncs.
> +			 */
> +			dtor_func_name = __btf_name_by_offset(off_btf, dtor_func->name_off);
> +			addr = kallsyms_lookup_name(dtor_func_name);
> +			if (!addr) {
> +				ret = -EINVAL;
> +				goto end_mod;
> +			}
> +			tab->off[i].kptr.dtor = (void *)addr;
> +		}
> +
>  		tab->off[i].offset = info_arr[i].off;
>  		tab->off[i].type = info_arr[i].type;
>  		tab->off[i].kptr.btf_id = id;
>  		tab->off[i].kptr.btf = off_btf;
> +		tab->off[i].kptr.module = mod;
>  	}
>  	tab->nr_off = nr_off;
>  	return tab;
> +end_mod:
> +	module_put(mod);
> +end_btf:
> +	btf_put(off_btf);
>  end:
> -	while (i--)
> +	while (i--) {
>  		btf_put(tab->off[i].kptr.btf);
> +		if (tab->off[i].kptr.module)
> +			module_put(tab->off[i].kptr.module);
> +	}
>  	kfree(tab);
>  	return ERR_PTR(ret);
>  }
> @@ -7059,6 +7113,43 @@ s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id)
>  	return dtor->kfunc_btf_id;
>  }
>  
> +static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc *dtors, u32 cnt)
> +{
> +	const struct btf_type *dtor_func, *dtor_func_proto, *t;
> +	const struct btf_param *args;
> +	s32 dtor_btf_id;
> +	u32 nr_args, i;
> +
> +	for (i = 0; i < cnt; i++) {
> +		dtor_btf_id = dtors[i].kfunc_btf_id;
> +
> +		dtor_func = btf_type_by_id(btf, dtor_btf_id);
> +		if (!dtor_func || !btf_type_is_func(dtor_func))
> +			return -EINVAL;
> +
> +		dtor_func_proto = btf_type_by_id(btf, dtor_func->type);
> +		if (!dtor_func_proto || !btf_type_is_func_proto(dtor_func_proto))
> +			return -EINVAL;
> +
> +		/* Make sure the prototype of the destructor kfunc is 'void func(type *)' */
> +		t = btf_type_by_id(btf, dtor_func_proto->type);
> +		if (!t || !btf_type_is_void(t))
> +			return -EINVAL;
> +
> +		nr_args = btf_type_vlen(dtor_func_proto);
> +		if (nr_args != 1)
> +			return -EINVAL;
> +		args = btf_params(dtor_func_proto);
> +		t = btf_type_by_id(btf, args[0].type);
> +		/* Allow any pointer type, as width on targets Linux supports
> +		 * will be same for all pointer types (i.e. sizeof(void *))
> +		 */
> +		if (!t || !btf_type_is_ptr(t))
> +			return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  /* This function must be invoked only from initcalls/module init functions */
>  int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
>  				struct module *owner)
> @@ -7089,6 +7180,11 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
>  		goto end;
>  	}
>  
> +	/* Ensure that the prototype of dtor kfuncs being registered is sane */
> +	ret = btf_check_dtor_kfuncs(btf, dtors, add_cnt);
> +	if (ret < 0)
> +		goto end;
> +
>  	tab = btf->dtor_kfunc_tab;
>  	/* Only one call allowed for modules */
>  	if (WARN_ON_ONCE(tab && btf_is_module(btf))) {
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index c68fbebc8c00..2bc9416096ca 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -254,6 +254,25 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
>  	}
>  }
>  
> +static void htab_free_prealloced_kptrs(struct bpf_htab *htab)
> +{
> +	u32 num_entries = htab->map.max_entries;
> +	int i;
> +
> +	if (likely(!map_value_has_kptrs(&htab->map)))

drop it here too.

> +		return;
> +	if (htab_has_extra_elems(htab))
> +		num_entries += num_possible_cpus();
> +
> +	for (i = 0; i < num_entries; i++) {
> +		struct htab_elem *elem;
> +
> +		elem = get_htab_elem(htab, i);
> +		bpf_map_free_kptrs(&htab->map, elem->key + round_up(htab->map.key_size, 8));
> +		cond_resched();
> +	}
> +}
> +
>  static void htab_free_elems(struct bpf_htab *htab)
>  {
>  	int i;
> @@ -725,12 +744,15 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
>  	return insn - insn_buf;
>  }
>  
> -static void check_and_free_timer(struct bpf_htab *htab, struct htab_elem *elem)
> +static void check_and_free_fields(struct bpf_htab *htab,
> +				  struct htab_elem *elem)
>  {
> +	void *map_value = elem->key + round_up(htab->map.key_size, 8);
> +
>  	if (unlikely(map_value_has_timer(&htab->map)))

remove my copy-paste error pls.

> -		bpf_timer_cancel_and_free(elem->key +
> -					  round_up(htab->map.key_size, 8) +
> -					  htab->map.timer_off);
> +		bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
> +	if (unlikely(map_value_has_kptrs(&htab->map)))

don't add it.

> +		bpf_map_free_kptrs(&htab->map, map_value);
>  }
>  
>  /* It is called from the bpf_lru_list when the LRU needs to delete
> @@ -757,7 +779,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
>  	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
>  		if (l == tgt_l) {
>  			hlist_nulls_del_rcu(&l->hash_node);
> -			check_and_free_timer(htab, l);
> +			check_and_free_fields(htab, l);
>  			break;
>  		}
>  
> @@ -829,7 +851,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
>  {
>  	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
>  		free_percpu(htab_elem_get_ptr(l, htab->map.key_size));
> -	check_and_free_timer(htab, l);
> +	check_and_free_fields(htab, l);
>  	kfree(l);
>  }
>  
> @@ -857,7 +879,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
>  	htab_put_fd_value(htab, l);
>  
>  	if (htab_is_prealloc(htab)) {
> -		check_and_free_timer(htab, l);
> +		check_and_free_fields(htab, l);
>  		__pcpu_freelist_push(&htab->freelist, &l->fnode);
>  	} else {
>  		atomic_dec(&htab->count);
> @@ -1104,7 +1126,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>  		if (!htab_is_prealloc(htab))
>  			free_htab_elem(htab, l_old);
>  		else
> -			check_and_free_timer(htab, l_old);
> +			check_and_free_fields(htab, l_old);
>  	}
>  	ret = 0;
>  err:
> @@ -1114,7 +1136,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>  
>  static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
>  {
> -	check_and_free_timer(htab, elem);
> +	check_and_free_fields(htab, elem);
>  	bpf_lru_push_free(&htab->lru, &elem->lru_node);
>  }
>  
> @@ -1419,8 +1441,14 @@ static void htab_free_malloced_timers(struct bpf_htab *htab)
>  		struct hlist_nulls_node *n;
>  		struct htab_elem *l;
>  
> -		hlist_nulls_for_each_entry(l, n, head, hash_node)
> -			check_and_free_timer(htab, l);
> +		hlist_nulls_for_each_entry(l, n, head, hash_node) {
> +			/* We don't reset or free kptr on uref dropping to zero,
> +			 * hence just free timer.
> +			 */
> +			bpf_timer_cancel_and_free(l->key +
> +						  round_up(htab->map.key_size, 8) +
> +						  htab->map.timer_off);
> +		}
>  		cond_resched_rcu();
>  	}
>  	rcu_read_unlock();
> @@ -1430,6 +1458,7 @@ static void htab_map_free_timers(struct bpf_map *map)
>  {
>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>  
> +	/* We don't reset or free kptr on uref dropping to zero. */
>  	if (likely(!map_value_has_timer(&htab->map)))

pls remove.

>  		return;
>  	if (!htab_is_prealloc(htab))
> @@ -1453,11 +1482,14 @@ static void htab_map_free(struct bpf_map *map)
>  	 * not have executed. Wait for them.
>  	 */
>  	rcu_barrier();
> -	if (!htab_is_prealloc(htab))
> +	if (!htab_is_prealloc(htab)) {
>  		delete_all_elements(htab);
> -	else
> +	} else {
> +		htab_free_prealloced_kptrs(htab);
>  		prealloc_destroy(htab);
> +	}
>  
> +	bpf_map_free_kptr_off_tab(map);
>  	free_percpu(htab->extra_elems);
>  	bpf_map_area_free(htab->buckets);
>  	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 1b1497b94303..518acf39b40c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -508,8 +508,11 @@ void bpf_map_free_kptr_off_tab(struct bpf_map *map)
>  	if (!map_value_has_kptrs(map))
>  		return;
>  	for (i = 0; i < tab->nr_off; i++) {
> +		struct module *mod = tab->off[i].kptr.module;
>  		struct btf *btf = tab->off[i].kptr.btf;
>  
> +		if (mod)
> +			module_put(mod);
>  		btf_put(btf);
>  	}
>  	kfree(tab);
> @@ -524,8 +527,16 @@ struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
>  	if (!map_value_has_kptrs(map))
>  		return ERR_PTR(-ENOENT);
>  	/* Do a deep copy of the kptr_off_tab */
> -	for (i = 0; i < tab->nr_off; i++)
> -		btf_get(tab->off[i].kptr.btf);
> +	for (i = 0; i < tab->nr_off; i++) {
> +		struct module *mod = tab->off[i].kptr.module;
> +		struct btf *btf = tab->off[i].kptr.btf;
> +
> +		if (mod && !try_module_get(mod)) {
> +			ret = -ENXIO;
> +			goto end;
> +		}
> +		btf_get(btf);
> +	}
>  
>  	size = offsetof(struct bpf_map_value_off, off[tab->nr_off]);
>  	new_tab = kmemdup(tab, size, GFP_KERNEL | __GFP_NOWARN);
> @@ -535,8 +546,14 @@ struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
>  	}
>  	return new_tab;
>  end:
> -	while (i--)
> -		btf_put(tab->off[i].kptr.btf);
> +	while (i--) {
> +		struct module *mod = tab->off[i].kptr.module;
> +		struct btf *btf = tab->off[i].kptr.btf;
> +
> +		if (mod)
> +			module_put(mod);
> +		btf_put(btf);
> +	}
>  	return ERR_PTR(ret);
>  }
>  
> @@ -556,6 +573,33 @@ bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_ma
>  	return !memcmp(tab_a, tab_b, size);
>  }
>  
> +/* Caller must ensure map_value_has_kptrs is true. Note that this function can
> + * be called on a map value while the map_value is visible to BPF programs, as
> + * it ensures the correct synchronization, and we already enforce the same using
> + * the bpf_kptr_xchg helper on the BPF program side for referenced kptrs.
> + */
> +void bpf_map_free_kptrs(struct bpf_map *map, void *map_value)
> +{
> +	struct bpf_map_value_off *tab = map->kptr_off_tab;
> +	unsigned long *btf_id_ptr;
> +	int i;
> +
> +	for (i = 0; i < tab->nr_off; i++) {
> +		struct bpf_map_value_off_desc *off_desc = &tab->off[i];
> +		unsigned long old_ptr;
> +
> +		btf_id_ptr = map_value + off_desc->offset;
> +		if (off_desc->type == BPF_MAP_OFF_DESC_TYPE_UNREF_KPTR) {
> +			u64 *p = (u64 *)btf_id_ptr;
> +
> +			WRITE_ONCE(p, 0);
> +			continue;
> +		}
> +		old_ptr = xchg(btf_id_ptr, 0);
> +		off_desc->kptr.dtor((void *)old_ptr);
> +	}
> +}
> +
>  /* called from workqueue */
>  static void bpf_map_free_deferred(struct work_struct *work)
>  {
> @@ -563,9 +607,10 @@ static void bpf_map_free_deferred(struct work_struct *work)
>  
>  	security_bpf_map_free(map);
>  	kfree(map->off_arr);
> -	bpf_map_free_kptr_off_tab(map);
>  	bpf_map_release_memcg(map);
> -	/* implementation dependent freeing */
> +	/* implementation dependent freeing, map_free callback also does
> +	 * bpf_map_free_kptr_off_tab, if needed.
> +	 */
>  	map->ops->map_free(map);
>  }
>  
> -- 
> 2.35.1
> 
