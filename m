Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35D85095BC
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 06:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384063AbiDUESY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 00:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350136AbiDUESX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 00:18:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876BDFD31
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 21:15:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j17so3841996pfi.9
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 21:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1msSjO46qPVerpVzvZPXru6IxOHsnxRpLKDhd5LnKLU=;
        b=TfimOyaVFuh8jqYdyGeb4jCb3l8/G1ZMsxR4IhsDC11bZQvPo55Fc1AX6xAM0IjSFN
         C/VF/gL0CisuUUbmHdcmw+RDVzAtTAHYnS/RycslX1wim7SXlTqsigImsnxm6FDxPkzk
         PV1j7jM5Pc2evkhOAbBEf530XjdainXBn8uwuKp1g6PZ1c/L/ZXl1vXKjGeQbviEsf5p
         ezoVAOYB6sZrXZb24ObIWgeFv2/TQjsXS0bwJwbdg5oiDAL6H7PyPXCJsXH+Lm2lho7V
         d9qge/tzQ+XrVZ9CJ3O367389AHucWMvECO42aXjDYUGHUQVDNBdg+ggz/67ZsVk5w3m
         ZBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1msSjO46qPVerpVzvZPXru6IxOHsnxRpLKDhd5LnKLU=;
        b=cSlZKd1NgaauDCMl5ZLWHznkWLpehwDe2lmM5gUYyi0+EQ7ehatLUnTMQA80znK8Ro
         Oy26RiH2gSSlEqNAVOoYrFXbH+lt3VdLPaHGDL5swBgor/S8ZwyRaRp9MjfdQAIqGx8V
         ZhGhWfBRmCUSpQjwbqUebHXalEEkpnOWtq3neKqMpVGyDg9LWyI1SsI5f4/jnrdrkXZv
         2TGFh9/yPfBPmfjqaZ+oDa/KxoB1YeB9Uap393b4xel9LbrBOVk7CHwtiU99njjnLczi
         vrBmrNLDXXTTmMi6qVoOky1tFyiLtyC2Yffg53DFtjSPmetAq6mf4RtpKZ/gmO3gpYZo
         6yCQ==
X-Gm-Message-State: AOAM5316v9H04hQhRS9J4QuILpZ3GM6fj7yplzRCJAx3JrfZ3l2k6HhV
        VyXPQpfPpI7xUE4hSL6XGPQ=
X-Google-Smtp-Source: ABdhPJz/+3fQlXi/DN5NBrJ6/N6GdXmBsUCihhqn2SpvQ5RHSFTwl9kuc9GF6BBVXMyWLFbWzzUxNg==
X-Received: by 2002:a63:2a45:0:b0:3a9:f71e:a63d with SMTP id q66-20020a632a45000000b003a9f71ea63dmr16590833pgq.69.1650514532194;
        Wed, 20 Apr 2022 21:15:32 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:4399])
        by smtp.gmail.com with ESMTPSA id w22-20020a056a0014d600b0050a97172c4fsm8854487pfu.67.2022.04.20.21.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 21:15:31 -0700 (PDT)
Date:   Wed, 20 Apr 2022 21:15:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v5 03/13] bpf: Allow storing unreferenced kptr
 in map
Message-ID: <20220421041528.eez5euhgsm5dvjwz@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
 <20220415160354.1050687-4-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415160354.1050687-4-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 09:33:44PM +0530, Kumar Kartikeya Dwivedi wrote:
> +struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
> +					  const struct btf_type *t)
> +{
> +	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
> +	struct bpf_map_value_off *tab;
> +	int ret, i, nr_off;
> +
> +	/* Revisit stack usage when bumping BPF_MAP_VALUE_OFF_MAX */
> +	BUILD_BUG_ON(BPF_MAP_VALUE_OFF_MAX != 8);

Pls drop this line and comment. It's establishing a false sense of safety
that this is the place to worry about when enum is changing.
Any time an enum or #define is changed all code that uses it has to be audited.
This stack increase is a minor concern comparing to all other side effects
the increase of BPF_MAP_VALUE_OFF_MAX would do.

> +
> +	ret = btf_find_field(btf, t, BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +	if (!ret)
> +		return NULL;
> +
> +	nr_off = ret;
> +	tab = kzalloc(offsetof(struct bpf_map_value_off, off[nr_off]), GFP_KERNEL | __GFP_NOWARN);
> +	if (!tab)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < nr_off; i++) {
> +		const struct btf_type *t;
> +		struct btf *off_btf;

off_btf is an odd name here. Call it kernel_btf ?

> +		s32 id;
> +
> +		t = btf_type_by_id(btf, info_arr[i].type_id);

pls add a comment here to make it clear that above 'btf' is a prog's btf
and below search is trying to find it in kernel or module btf-s.

> +		id = bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO_KIND(t->info),
> +				     &off_btf);
> +		if (id < 0) {
> +			ret = id;
> +			goto end;
> +		}
> +
> +		tab->off[i].offset = info_arr[i].off;
> +		tab->off[i].kptr.btf_id = id;
> +		tab->off[i].kptr.btf = off_btf;
> +	}
> +	tab->nr_off = nr_off;
> +	return tab;
> +end:
> +	while (i--)
> +		btf_put(tab->off[i].kptr.btf);
> +	kfree(tab);
> +	return ERR_PTR(ret);
> +}
> +
>  static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
>  			      u32 type_id, void *data, u8 bits_offset,
>  			      struct btf_show *show)
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 5cd8f5277279..135205d0d560 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -52,6 +52,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>  	inner_map_meta->max_entries = inner_map->max_entries;
>  	inner_map_meta->spin_lock_off = inner_map->spin_lock_off;
>  	inner_map_meta->timer_off = inner_map->timer_off;
> +	inner_map_meta->kptr_off_tab = bpf_map_copy_kptr_off_tab(inner_map);
>  	if (inner_map->btf) {
>  		btf_get(inner_map->btf);
>  		inner_map_meta->btf = inner_map->btf;
> @@ -71,6 +72,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>  
>  void bpf_map_meta_free(struct bpf_map *map_meta)
>  {
> +	bpf_map_free_kptr_off_tab(map_meta);
>  	btf_put(map_meta->btf);
>  	kfree(map_meta);
>  }
> @@ -83,7 +85,8 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
>  		meta0->key_size == meta1->key_size &&
>  		meta0->value_size == meta1->value_size &&
>  		meta0->timer_off == meta1->timer_off &&
> -		meta0->map_flags == meta1->map_flags;
> +		meta0->map_flags == meta1->map_flags &&
> +		bpf_map_equal_kptr_off_tab(meta0, meta1);
>  }
>  
>  void *bpf_map_fd_get_ptr(struct bpf_map *map,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e9621cfa09f2..fba49f390ed5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6,6 +6,7 @@
>  #include <linux/bpf_trace.h>
>  #include <linux/bpf_lirc.h>
>  #include <linux/bpf_verifier.h>
> +#include <linux/bsearch.h>
>  #include <linux/btf.h>
>  #include <linux/syscalls.h>
>  #include <linux/slab.h>
> @@ -473,12 +474,94 @@ static void bpf_map_release_memcg(struct bpf_map *map)
>  }
>  #endif
>  
> +static int bpf_map_kptr_off_cmp(const void *a, const void *b)
> +{
> +	const struct bpf_map_value_off_desc *off_desc1 = a, *off_desc2 = b;
> +
> +	if (off_desc1->offset < off_desc2->offset)
> +		return -1;
> +	else if (off_desc1->offset > off_desc2->offset)
> +		return 1;
> +	return 0;
> +}
> +
> +struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset)
> +{
> +	/* Since members are iterated in btf_find_field in increasing order,
> +	 * offsets appended to kptr_off_tab are in increasing order, so we can
> +	 * do bsearch to find exact match.
> +	 */
> +	struct bpf_map_value_off *tab;
> +
> +	if (!map_value_has_kptrs(map))
> +		return NULL;
> +	tab = map->kptr_off_tab;
> +	return bsearch(&offset, tab->off, tab->nr_off, sizeof(tab->off[0]), bpf_map_kptr_off_cmp);
> +}
> +
> +void bpf_map_free_kptr_off_tab(struct bpf_map *map)
> +{
> +	struct bpf_map_value_off *tab = map->kptr_off_tab;
> +	int i;
> +
> +	if (!map_value_has_kptrs(map))
> +		return;
> +	for (i = 0; i < tab->nr_off; i++) {
> +		struct btf *btf = tab->off[i].kptr.btf;
> +
> +		btf_put(btf);

why not to do: btf_put(tab->off[i].kptr.btf);

> +	}
> +	kfree(tab);
> +	map->kptr_off_tab = NULL;
> +}
> +
> +struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
> +{
> +	struct bpf_map_value_off *tab = map->kptr_off_tab, *new_tab;
> +	int size, i, ret;
> +
> +	if (!map_value_has_kptrs(map))
> +		return ERR_PTR(-ENOENT);
> +	/* Do a deep copy of the kptr_off_tab */
> +	for (i = 0; i < tab->nr_off; i++)
> +		btf_get(tab->off[i].kptr.btf);
> +
> +	size = offsetof(struct bpf_map_value_off, off[tab->nr_off]);
> +	new_tab = kmemdup(tab, size, GFP_KERNEL | __GFP_NOWARN);
> +	if (!new_tab) {
> +		ret = -ENOMEM;
> +		goto end;
> +	}
> +	return new_tab;
> +end:
> +	while (i--)
> +		btf_put(tab->off[i].kptr.btf);

Why do this get/put dance?
Isn't it equivalent to do kmemdup first and then for() btf_get?
kptr_off_tab is not going away and btfs are not going away either.
There is no race.

> +	return ERR_PTR(ret);
> +}
> +
> +bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b)
> +{
> +	struct bpf_map_value_off *tab_a = map_a->kptr_off_tab, *tab_b = map_b->kptr_off_tab;
> +	bool a_has_kptr = map_value_has_kptrs(map_a), b_has_kptr = map_value_has_kptrs(map_b);
> +	int size;
> +
> +	if (!a_has_kptr && !b_has_kptr)
> +		return true;
> +	if (a_has_kptr != b_has_kptr)
> +		return false;
> +	if (tab_a->nr_off != tab_b->nr_off)
> +		return false;
> +	size = offsetof(struct bpf_map_value_off, off[tab_a->nr_off]);
> +	return !memcmp(tab_a, tab_b, size);
> +}
> +
>  /* called from workqueue */
>  static void bpf_map_free_deferred(struct work_struct *work)
>  {
>  	struct bpf_map *map = container_of(work, struct bpf_map, work);
>  
>  	security_bpf_map_free(map);
> +	bpf_map_free_kptr_off_tab(map);
>  	bpf_map_release_memcg(map);
>  	/* implementation dependent freeing */
>  	map->ops->map_free(map);
> @@ -640,7 +723,7 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
>  	int err;
>  
>  	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
> -	    map_value_has_timer(map))
> +	    map_value_has_timer(map) || map_value_has_kptrs(map))
>  		return -ENOTSUPP;
>  
>  	if (!(vma->vm_flags & VM_SHARED))
> @@ -820,9 +903,33 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>  			return -EOPNOTSUPP;
>  	}
>  
> -	if (map->ops->map_check_btf)
> +	map->kptr_off_tab = btf_parse_kptrs(btf, value_type);
> +	if (map_value_has_kptrs(map)) {
> +		if (!bpf_capable()) {
> +			ret = -EPERM;
> +			goto free_map_tab;
> +		}
> +		if (map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG)) {
> +			ret = -EACCES;
> +			goto free_map_tab;
> +		}
> +		if (map->map_type != BPF_MAP_TYPE_HASH &&
> +		    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> +		    map->map_type != BPF_MAP_TYPE_ARRAY) {
> +			ret = -EOPNOTSUPP;
> +			goto free_map_tab;
> +		}
> +	}
> +
> +	if (map->ops->map_check_btf) {
>  		ret = map->ops->map_check_btf(map, btf, key_type, value_type);
> +		if (ret < 0)
> +			goto free_map_tab;
> +	}
>  
> +	return ret;
> +free_map_tab:
> +	bpf_map_free_kptr_off_tab(map);
>  	return ret;
>  }
>  
> @@ -1639,7 +1746,7 @@ static int map_freeze(const union bpf_attr *attr)
>  		return PTR_ERR(map);
>  
>  	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
> -	    map_value_has_timer(map)) {
> +	    map_value_has_timer(map) || map_value_has_kptrs(map)) {
>  		fdput(f);
>  		return -ENOTSUPP;
>  	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 71827d14724a..c802e51c4e18 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3211,7 +3211,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> -enum stack_access_src {
> +enum bpf_access_src {
>  	ACCESS_DIRECT = 1,  /* the access is performed by an instruction */
>  	ACCESS_HELPER = 2,  /* the access is performed by a helper */
>  };
> @@ -3219,7 +3219,7 @@ enum stack_access_src {
>  static int check_stack_range_initialized(struct bpf_verifier_env *env,
>  					 int regno, int off, int access_size,
>  					 bool zero_size_allowed,
> -					 enum stack_access_src type,
> +					 enum bpf_access_src type,
>  					 struct bpf_call_arg_meta *meta);
>  
>  static struct bpf_reg_state *reg_state(struct bpf_verifier_env *env, int regno)
> @@ -3507,9 +3507,87 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
>  	return __check_ptr_off_reg(env, reg, regno, false);
>  }
>  
> +static int map_kptr_match_type(struct bpf_verifier_env *env,
> +			       struct bpf_map_value_off_desc *off_desc,
> +			       struct bpf_reg_state *reg, u32 regno)
> +{
> +	const char *targ_name = kernel_type_name(off_desc->kptr.btf, off_desc->kptr.btf_id);
> +	const char *reg_name = "";
> +
> +	if (base_type(reg->type) != PTR_TO_BTF_ID || type_flag(reg->type) != PTR_MAYBE_NULL)
> +		goto bad_type;
> +
> +	if (!btf_is_kernel(reg->btf)) {
> +		verbose(env, "R%d must point to kernel BTF\n", regno);
> +		return -EINVAL;
> +	}
> +	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
> +	reg_name = kernel_type_name(reg->btf, reg->btf_id);
> +
> +	if (__check_ptr_off_reg(env, reg, regno, true))
> +		return -EACCES;
> +
> +	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> +				  off_desc->kptr.btf, off_desc->kptr.btf_id))
> +		goto bad_type;

Is full type comparison really needed?
reg->btf should be the same pointer as off_desc->kptr.btf
and btf_id should match exactly.
Is this a feature proofing for some day when registers with PTR_TO_BTF_ID type
will start pointing to prog's btf?

> +	return 0;
> +bad_type:
> +	verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
> +		reg_type_str(env, reg->type), reg_name);
> +	verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> +	return -EINVAL;
> +}
> +
> +static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> +				 int value_regno, int insn_idx,
> +				 struct bpf_map_value_off_desc *off_desc)
> +{
> +	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
> +	int class = BPF_CLASS(insn->code);
> +	struct bpf_reg_state *val_reg;
> +
> +	/* Things we already checked for in check_map_access and caller:
> +	 *  - Reject cases where variable offset may touch kptr
> +	 *  - size of access (must be BPF_DW)
> +	 *  - tnum_is_const(reg->var_off)
> +	 *  - off_desc->offset == off + reg->var_off.value
> +	 */
> +	/* Only BPF_[LDX,STX,ST] | BPF_MEM | BPF_DW is supported */
> +	if (BPF_MODE(insn->code) != BPF_MEM) {
> +		verbose(env, "kptr in map can only be accessed using BPF_MEM instruction mode\n");
> +		return -EACCES;
> +	}
> +
> +	if (class == BPF_LDX) {
> +		val_reg = reg_state(env, value_regno);
> +		/* We can simply mark the value_regno receiving the pointer
> +		 * value from map as PTR_TO_BTF_ID, with the correct type.
> +		 */
> +		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->kptr.btf,
> +				off_desc->kptr.btf_id, PTR_MAYBE_NULL);
> +		val_reg->id = ++env->id_gen;

why non zero id this needed?
