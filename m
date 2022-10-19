Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450CD603797
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 03:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJSBfd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 21:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJSBfc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 21:35:32 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD56BD4A
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 18:35:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 67so15785383pfz.12
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 18:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ON6qXdnMRvpX2z8fkhhwWQAByk0dVQF2XVlic0ilkM=;
        b=FhKmTMXXBuKGIPdjYsKUWT1IutCyytUF+GThTWhBhf8vwcjan3ug2fFoxluwgFukWm
         E8YhaL2kGlyXnXUu4mqtO8A3NTwJMJWEC0AhJOF/i4nh+4MBfi47fKmcCWuOpQvKPc9/
         yxWd2zXReq4CWxFHFELGjezSL/Zj83E1IjuP9iFMjbbNCNYvy0R0U0AlOPqviDR77DOR
         muTBm0aWjc7hbj20hmwt1WTvzhzuJQH9tEDB+0xyE32llY9AziEahHPBQFG4RhuLO0DZ
         +xvZQ6TIEEaAiMpMBmdsebT4QveM3Qmk8o09XR1vnFVaoBkEpIidxiF7SApuF3I8uPTU
         EqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ON6qXdnMRvpX2z8fkhhwWQAByk0dVQF2XVlic0ilkM=;
        b=4nlF1yCvOv8DXEfBSHOc6fgLeFncrD6C8O7DXWQUMlnMFgS46aoesJXHbvW2+zBFIs
         PCgPnzPXNDLRQLtzjiQYZvVZPelgEktoLKKNh6RMxJ5R3ddELs2eY3ik7dFYGQv2dvOz
         eb9YnEw0Rzw8ozwAcDmmDmpnos3T6435CPffTlx0+KB4/tP2QuiQPhBUHbrN/Nafv5C9
         Sp3WmZeIEGDWe4qUpcPl/1alu7W3Dhi4EpCDfN+tjcnw29d/R8Z9QvOqzRzHyxOMpDIp
         NGF+Bmcd+r4n0IzDbeHXJiyqOwL+TcJg7A8tnLqDQse8Q8bX9hgJ3uAqVJrEq7wYrrDl
         7uqQ==
X-Gm-Message-State: ACrzQf0cp3tEHvsBk6D9AVXhqPJrnu1YEhtRExMEAonEohfyo7LhzIdV
        rpA+Nk8UArE2gCKp4656fxFgoAVeA6M=
X-Google-Smtp-Source: AMsMyM6YURWoc/uNfSm2ToYdHKwsVmL9384MskU35SfWaPr8F2QlZ+jBGhgrcjURKJgpqbHCtJvouQ==
X-Received: by 2002:a63:c112:0:b0:443:94a1:f09 with SMTP id w18-20020a63c112000000b0044394a10f09mr5115771pgf.396.1666143329837;
        Tue, 18 Oct 2022 18:35:29 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:a07d])
        by smtp.gmail.com with ESMTPSA id d4-20020a62f804000000b005628a30a500sm9953580pfh.41.2022.10.18.18.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:35:29 -0700 (PDT)
Date:   Tue, 18 Oct 2022 18:35:26 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 06/25] bpf: Refactor kptr_off_tab into
 fields_tab
Message-ID: <20221019013526.ziiksjif63frt6nn@macbook-pro-4.dhcp.thefacebook.com>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-7-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013062303.896469-7-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 11:52:44AM +0530, Kumar Kartikeya Dwivedi wrote:
> To prepare the BPF verifier to handle special fields in both map values
> and program allocated types coming from program BTF, we need to refactor
> the kptr_off_tab handling code into something more generic and reusable
> across both cases to avoid code duplication.
> 
> Later patches also require passing this data to helpers at runtime, so
> that they can work on user defined types, initialize them, destruct
> them, etc.
> 
> The main observation is that both map values and such allocated types
> point to a type in program BTF, hence they can be handled similarly. We
> can prepare a field metadata table for both cases and store them in
> struct bpf_map or struct btf depending on the use case.
> 
> Hence, refactor the code into generic btf_type_fields and btf_field
> member structs. The btf_type_fields represents the fields of a specific
> btf_type in user BTF. The cnt indicates the number of special fields we
> successfully recognized, and field_mask is a bitmask of fields that were
> found, to enable quick determination of availability of a certain field.
> 
> Subsequently, refactor the rest of the code to work with these generic
> types, remove assumptions about kptr and kptr_off_tab, rename variables
> to more meaningful names, etc.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h     | 103 +++++++++++++-------
>  include/linux/btf.h     |   4 +-
>  kernel/bpf/arraymap.c   |  13 ++-
>  kernel/bpf/btf.c        |  64 ++++++-------
>  kernel/bpf/hashtab.c    |  14 ++-
>  kernel/bpf/map_in_map.c |  13 ++-
>  kernel/bpf/syscall.c    | 203 +++++++++++++++++++++++-----------------
>  kernel/bpf/verifier.c   |  96 ++++++++++---------
>  8 files changed, 289 insertions(+), 221 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9e7d46d16032..25e77a172d7c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -164,35 +164,41 @@ struct bpf_map_ops {
>  };
>  
>  enum {
> -	/* Support at most 8 pointers in a BPF map value */
> -	BPF_MAP_VALUE_OFF_MAX = 8,
> -	BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
> +	/* Support at most 8 pointers in a BTF type */
> +	BTF_FIELDS_MAX	      = 8,
> +	BPF_MAP_OFF_ARR_MAX   = BTF_FIELDS_MAX +
>  				1 + /* for bpf_spin_lock */
>  				1,  /* for bpf_timer */
>  };
>  
> -enum bpf_kptr_type {
> -	BPF_KPTR_UNREF,
> -	BPF_KPTR_REF,
> +enum btf_field_type {
> +	BPF_KPTR_UNREF = (1 << 2),
> +	BPF_KPTR_REF   = (1 << 3),
> +	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
>  };
>  
> -struct bpf_map_value_off_desc {
> +struct btf_field_kptr {
> +	struct btf *btf;
> +	struct module *module;
> +	btf_dtor_kfunc_t dtor;
> +	u32 btf_id;
> +};
> +
> +struct btf_field {
>  	u32 offset;
> -	enum bpf_kptr_type type;
> -	struct {
> -		struct btf *btf;
> -		struct module *module;
> -		btf_dtor_kfunc_t dtor;
> -		u32 btf_id;
> -	} kptr;
> +	enum btf_field_type type;
> +	union {
> +		struct btf_field_kptr kptr;
> +	};
>  };
>  
> -struct bpf_map_value_off {
> -	u32 nr_off;
> -	struct bpf_map_value_off_desc off[];
> +struct btf_type_fields {

How about btf_record instead ?
Then btf_type_fields_has_field() will become btf_record_has_field() ?

> +	u32 cnt;
> +	u32 field_mask;
> +	struct btf_field fields[];
>  };
>  
> -struct bpf_map_off_arr {
> +struct btf_type_fields_off {

struct btf_field_offs ?

>  	u32 cnt;
>  	u32 field_off[BPF_MAP_OFF_ARR_MAX];
>  	u8 field_sz[BPF_MAP_OFF_ARR_MAX];
> @@ -214,7 +220,7 @@ struct bpf_map {
>  	u64 map_extra; /* any per-map-type extra fields */
>  	u32 map_flags;
>  	int spin_lock_off; /* >=0 valid offset, <0 error */
> -	struct bpf_map_value_off *kptr_off_tab;
> +	struct btf_type_fields *fields_tab;

struct btf_record *record; ?
The '_tab' suffix suppose to mean 'fieldS table' ?
Just 'record' seems clear enough.
Or
struct btf_record *btf_record; ?
if just 'record' ambiguous.

>  	int timer_off; /* >=0 valid offset, <0 error */
>  	u32 id;
>  	int numa_node;
> @@ -226,7 +232,7 @@ struct bpf_map {
>  	struct obj_cgroup *objcg;
>  #endif
>  	char name[BPF_OBJ_NAME_LEN];
> -	struct bpf_map_off_arr *off_arr;
> +	struct btf_type_fields_off *off_arr;

'off_arr' should probably be renamed as well.
How about 'struct btf_field_offs *field_offs;' ?

>  static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
>  {
>  	if (unlikely(map_value_has_spin_lock(map)))
>  		memset(dst + map->spin_lock_off, 0, sizeof(struct bpf_spin_lock));
>  	if (unlikely(map_value_has_timer(map)))
>  		memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
> -	if (unlikely(map_value_has_kptrs(map))) {
> -		struct bpf_map_value_off *tab = map->kptr_off_tab;
> +	if (!IS_ERR_OR_NULL(map->fields_tab)) {
> +		struct btf_field *fields = map->fields_tab->fields;

will become
struct btf_field *fields = map->record->fields;

> +		u32 cnt = map->fields_tab->cnt;
>  		int i;
>  
> -		for (i = 0; i < tab->nr_off; i++)
> -			*(u64 *)(dst + tab->off[i].offset) = 0;
> +		for (i = 0; i < cnt; i++)
> +			memset(dst + fields[i].offset, 0, btf_field_type_size(fields[i].type));
>  	}
>  }
>  
> @@ -1691,11 +1724,13 @@ void bpf_prog_put(struct bpf_prog *prog);
>  void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock);
>  void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);
>  
> -struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset);
> -void bpf_map_free_kptr_off_tab(struct bpf_map *map);
> -struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map);
> -bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
> -void bpf_map_free_kptrs(struct bpf_map *map, void *map_value);
> +struct btf_field *btf_type_fields_find(const struct btf_type_fields *tab,
> +				       u32 offset, enum btf_field_type type);
> +void btf_type_fields_free(struct btf_type_fields *tab);

void btf_record_free(struct btf_record *r) ?

> +void bpf_map_free_fields_tab(struct bpf_map *map);

will become bpf_map_free_btf_record() ?

> +struct btf_type_fields *btf_type_fields_dup(const struct btf_type_fields *tab);
> +bool btf_type_fields_equal(const struct btf_type_fields *tab_a, const struct btf_type_fields *tab_b);
> +void bpf_obj_free_fields(const struct btf_type_fields *tab, void *obj);
>  
>  struct bpf_map *bpf_map_get(u32 ufd);
>  struct bpf_map *bpf_map_get_with_uref(u32 ufd);
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 86aad9b2ce02..0d47cbb11a59 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -163,8 +163,8 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>  			   u32 expected_offset, u32 expected_size);
>  int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
>  int btf_find_timer(const struct btf *btf, const struct btf_type *t);
> -struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
> -					  const struct btf_type *t);
> +struct btf_type_fields *btf_parse_fields(const struct btf *btf,
> +					 const struct btf_type *t);
>  bool btf_type_is_void(const struct btf_type *t);
>  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
>  const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 832b2659e96e..defe5c00049a 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -310,8 +310,7 @@ static void check_and_free_fields(struct bpf_array *arr, void *val)
>  {
>  	if (map_value_has_timer(&arr->map))
>  		bpf_timer_cancel_and_free(val + arr->map.timer_off);
> -	if (map_value_has_kptrs(&arr->map))
> -		bpf_map_free_kptrs(&arr->map, val);
> +	bpf_obj_free_fields(arr->map.fields_tab, val);
>  }
>  
>  /* Called from syscall or from eBPF program */
> @@ -409,7 +408,7 @@ static void array_map_free_timers(struct bpf_map *map)
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
>  	int i;
>  
> -	/* We don't reset or free kptr on uref dropping to zero. */
> +	/* We don't reset or free fields other than timer on uref dropping to zero. */
>  	if (!map_value_has_timer(map))
>  		return;
>  
> @@ -423,22 +422,22 @@ static void array_map_free(struct bpf_map *map)
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
>  	int i;
>  
> -	if (map_value_has_kptrs(map)) {
> +	if (!IS_ERR_OR_NULL(map->fields_tab)) {
>  		if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
>  			for (i = 0; i < array->map.max_entries; i++) {
>  				void __percpu *pptr = array->pptrs[i & array->index_mask];
>  				int cpu;
>  
>  				for_each_possible_cpu(cpu) {
> -					bpf_map_free_kptrs(map, per_cpu_ptr(pptr, cpu));
> +					bpf_obj_free_fields(map->fields_tab, per_cpu_ptr(pptr, cpu));
>  					cond_resched();
>  				}
>  			}
>  		} else {
>  			for (i = 0; i < array->map.max_entries; i++)
> -				bpf_map_free_kptrs(map, array_map_elem_ptr(array, i));
> +				bpf_obj_free_fields(map->fields_tab, array_map_elem_ptr(array, i));
>  		}
> -		bpf_map_free_kptr_off_tab(map);
> +		bpf_map_free_fields_tab(map);
>  	}
>  
>  	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index ad301e78f7ee..c8d267098b87 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3191,7 +3191,7 @@ static void btf_struct_log(struct btf_verifier_env *env,
>  	btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
>  }
>  
> -enum btf_field_type {
> +enum btf_field_info_type {
>  	BTF_FIELD_SPIN_LOCK,
>  	BTF_FIELD_TIMER,
>  	BTF_FIELD_KPTR,
> @@ -3203,9 +3203,9 @@ enum {
>  };
>  
>  struct btf_field_info {
> -	u32 type_id;
> +	enum btf_field_type type;
>  	u32 off;
> -	enum bpf_kptr_type type;
> +	u32 type_id;
>  };
>  
>  static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
> @@ -3222,7 +3222,7 @@ static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
>  static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
>  			 u32 off, int sz, struct btf_field_info *info)
>  {
> -	enum bpf_kptr_type type;
> +	enum btf_field_type type;
>  	u32 res_id;
>  
>  	/* Permit modifiers on the pointer itself */
> @@ -3259,7 +3259,7 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
>  
>  static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
>  				 const char *name, int sz, int align,
> -				 enum btf_field_type field_type,
> +				 enum btf_field_info_type field_type,
>  				 struct btf_field_info *info, int info_cnt)
>  {
>  	const struct btf_member *member;
> @@ -3311,7 +3311,7 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
>  
>  static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>  				const char *name, int sz, int align,
> -				enum btf_field_type field_type,
> +				enum btf_field_info_type field_type,
>  				struct btf_field_info *info, int info_cnt)
>  {
>  	const struct btf_var_secinfo *vsi;
> @@ -3360,7 +3360,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>  }
>  
>  static int btf_find_field(const struct btf *btf, const struct btf_type *t,
> -			  enum btf_field_type field_type,
> +			  enum btf_field_info_type field_type,
>  			  struct btf_field_info *info, int info_cnt)
>  {
>  	const char *name;
> @@ -3423,14 +3423,14 @@ int btf_find_timer(const struct btf *btf, const struct btf_type *t)
>  	return info.off;
>  }
>  
> -struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
> -					  const struct btf_type *t)
> +struct btf_type_fields *btf_parse_fields(const struct btf *btf,
> +					 const struct btf_type *t)
>  {
> -	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
> -	struct bpf_map_value_off *tab;
> +	struct btf_field_info info_arr[BTF_FIELDS_MAX];
>  	struct btf *kernel_btf = NULL;
> +	struct btf_type_fields *tab;

struct btf_record *r; ?

>  	struct module *mod = NULL;
> -	int ret, i, nr_off;
> +	int ret, i, cnt;
>  
>  	ret = btf_find_field(btf, t, BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
>  	if (ret < 0)
> @@ -3438,12 +3438,12 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
>  	if (!ret)
>  		return NULL;
>  
> -	nr_off = ret;
> -	tab = kzalloc(offsetof(struct bpf_map_value_off, off[nr_off]), GFP_KERNEL | __GFP_NOWARN);
> +	cnt = ret;
> +	tab = kzalloc(offsetof(struct btf_type_fields, fields[cnt]), GFP_KERNEL | __GFP_NOWARN);
>  	if (!tab)
>  		return ERR_PTR(-ENOMEM);
> -
> -	for (i = 0; i < nr_off; i++) {
> +	tab->cnt = 0;
> +	for (i = 0; i < cnt; i++) {
>  		const struct btf_type *t;
>  		s32 id;
>  
> @@ -3500,28 +3500,24 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
>  				ret = -EINVAL;
>  				goto end_mod;
>  			}
> -			tab->off[i].kptr.dtor = (void *)addr;
> +			tab->fields[i].kptr.dtor = (void *)addr;
>  		}
>  
> -		tab->off[i].offset = info_arr[i].off;
> -		tab->off[i].type = info_arr[i].type;
> -		tab->off[i].kptr.btf_id = id;
> -		tab->off[i].kptr.btf = kernel_btf;
> -		tab->off[i].kptr.module = mod;
> +		tab->fields[i].offset = info_arr[i].off;
> +		tab->fields[i].type = info_arr[i].type;
> +		tab->fields[i].kptr.btf_id = id;
> +		tab->fields[i].kptr.btf = kernel_btf;
> +		tab->fields[i].kptr.module = mod;
> +		tab->cnt++;
>  	}
> -	tab->nr_off = nr_off;
> +	tab->cnt = cnt;
>  	return tab;
>  end_mod:
>  	module_put(mod);
>  end_btf:
>  	btf_put(kernel_btf);
>  end:
> -	while (i--) {
> -		btf_put(tab->off[i].kptr.btf);
> -		if (tab->off[i].kptr.module)
> -			module_put(tab->off[i].kptr.module);
> -	}
> -	kfree(tab);
> +	btf_type_fields_free(tab);
>  	return ERR_PTR(ret);
>  }
>  
> @@ -6365,7 +6361,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  
>  		/* kptr_get is only true for kfunc */
>  		if (i == 0 && kptr_get) {
> -			struct bpf_map_value_off_desc *off_desc;
> +			struct btf_field *kptr_field;
>  
>  			if (reg->type != PTR_TO_MAP_VALUE) {
>  				bpf_log(log, "arg#0 expected pointer to map value\n");
> @@ -6381,8 +6377,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  				return -EINVAL;
>  			}
>  
> -			off_desc = bpf_map_kptr_off_contains(reg->map_ptr, reg->off + reg->var_off.value);
> -			if (!off_desc || off_desc->type != BPF_KPTR_REF) {
> +			kptr_field = btf_type_fields_find(reg->map_ptr->fields_tab, reg->off + reg->var_off.value, BPF_KPTR);
> +			if (!kptr_field || kptr_field->type != BPF_KPTR_REF) {
>  				bpf_log(log, "arg#0 no referenced kptr at map value offset=%llu\n",
>  					reg->off + reg->var_off.value);
>  				return -EINVAL;
> @@ -6401,8 +6397,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  					func_name, i, btf_type_str(ref_t), ref_tname);
>  				return -EINVAL;
>  			}
> -			if (!btf_struct_ids_match(log, btf, ref_id, 0, off_desc->kptr.btf,
> -						  off_desc->kptr.btf_id, true)) {
> +			if (!btf_struct_ids_match(log, btf, ref_id, 0, kptr_field->kptr.btf,
> +						  kptr_field->kptr.btf_id, true)) {
>  				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s\n",
>  					func_name, i, btf_type_str(ref_t), ref_tname);
>  				return -EINVAL;
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index ed3f8a53603b..59cdbea587c5 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -238,21 +238,20 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
>  	}
>  }
>  
> -static void htab_free_prealloced_kptrs(struct bpf_htab *htab)
> +static void htab_free_prealloced_fields(struct bpf_htab *htab)
>  {
>  	u32 num_entries = htab->map.max_entries;
>  	int i;
>  
> -	if (!map_value_has_kptrs(&htab->map))
> +	if (IS_ERR_OR_NULL(htab->map.fields_tab))
>  		return;
>  	if (htab_has_extra_elems(htab))
>  		num_entries += num_possible_cpus();
> -
>  	for (i = 0; i < num_entries; i++) {
>  		struct htab_elem *elem;
>  
>  		elem = get_htab_elem(htab, i);
> -		bpf_map_free_kptrs(&htab->map, elem->key + round_up(htab->map.key_size, 8));
> +		bpf_obj_free_fields(htab->map.fields_tab, elem->key + round_up(htab->map.key_size, 8));
>  		cond_resched();
>  	}
>  }
> @@ -766,8 +765,7 @@ static void check_and_free_fields(struct bpf_htab *htab,
>  
>  	if (map_value_has_timer(&htab->map))
>  		bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
> -	if (map_value_has_kptrs(&htab->map))
> -		bpf_map_free_kptrs(&htab->map, map_value);
> +	bpf_obj_free_fields(htab->map.fields_tab, map_value);
>  }
>  
>  /* It is called from the bpf_lru_list when the LRU needs to delete
> @@ -1517,11 +1515,11 @@ static void htab_map_free(struct bpf_map *map)
>  	if (!htab_is_prealloc(htab)) {
>  		delete_all_elements(htab);
>  	} else {
> -		htab_free_prealloced_kptrs(htab);
> +		htab_free_prealloced_fields(htab);
>  		prealloc_destroy(htab);
>  	}
>  
> -	bpf_map_free_kptr_off_tab(map);
> +	bpf_map_free_fields_tab(map);
>  	free_percpu(htab->extra_elems);
>  	bpf_map_area_free(htab->buckets);
>  	bpf_mem_alloc_destroy(&htab->pcpu_ma);
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 135205d0d560..2bff5f3a5efc 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -52,7 +52,14 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>  	inner_map_meta->max_entries = inner_map->max_entries;
>  	inner_map_meta->spin_lock_off = inner_map->spin_lock_off;
>  	inner_map_meta->timer_off = inner_map->timer_off;
> -	inner_map_meta->kptr_off_tab = bpf_map_copy_kptr_off_tab(inner_map);
> +	inner_map_meta->fields_tab = btf_type_fields_dup(inner_map->fields_tab);
> +	if (IS_ERR(inner_map_meta->fields_tab)) {
> +		/* btf_type_fields returns NULL or valid pointer in case of
> +		 * invalid/empty/valid, but ERR_PTR in case of errors.
> +		 */
> +		fdput(f);
> +		return ERR_CAST(inner_map_meta->fields_tab);
> +	}
>  	if (inner_map->btf) {
>  		btf_get(inner_map->btf);
>  		inner_map_meta->btf = inner_map->btf;
> @@ -72,7 +79,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>  
>  void bpf_map_meta_free(struct bpf_map *map_meta)
>  {
> -	bpf_map_free_kptr_off_tab(map_meta);
> +	bpf_map_free_fields_tab(map_meta);
>  	btf_put(map_meta->btf);
>  	kfree(map_meta);
>  }
> @@ -86,7 +93,7 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
>  		meta0->value_size == meta1->value_size &&
>  		meta0->timer_off == meta1->timer_off &&
>  		meta0->map_flags == meta1->map_flags &&
> -		bpf_map_equal_kptr_off_tab(meta0, meta1);
> +		btf_type_fields_equal(meta0->fields_tab, meta1->fields_tab);
>  }
>  
>  void *bpf_map_fd_get_ptr(struct bpf_map *map,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7b373a5e861f..83e7a290ad06 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -495,114 +495,134 @@ static void bpf_map_release_memcg(struct bpf_map *map)
>  }
>  #endif
>  
> -static int bpf_map_kptr_off_cmp(const void *a, const void *b)
> +static int btf_field_cmp(const void *a, const void *b)
>  {
> -	const struct bpf_map_value_off_desc *off_desc1 = a, *off_desc2 = b;
> +	const struct btf_field *f1 = a, *f2 = b;
>  
> -	if (off_desc1->offset < off_desc2->offset)
> +	if (f1->offset < f2->offset)
>  		return -1;
> -	else if (off_desc1->offset > off_desc2->offset)
> +	else if (f1->offset > f2->offset)
>  		return 1;
>  	return 0;
>  }
>  
> -struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset)
> +struct btf_field *btf_type_fields_find(const struct btf_type_fields *tab, u32 offset,
> +				       enum btf_field_type type)
>  {
> -	/* Since members are iterated in btf_find_field in increasing order,
> -	 * offsets appended to kptr_off_tab are in increasing order, so we can
> -	 * do bsearch to find exact match.
> -	 */
> -	struct bpf_map_value_off *tab;
> +	struct btf_field *field;
>  
> -	if (!map_value_has_kptrs(map))
> +	if (IS_ERR_OR_NULL(tab) || !(tab->field_mask & type))
> +		return NULL;
> +	field = bsearch(&offset, tab->fields, tab->cnt, sizeof(tab->fields[0]), btf_field_cmp);
> +	if (!field || !(field->type & type))
>  		return NULL;
> -	tab = map->kptr_off_tab;
> -	return bsearch(&offset, tab->off, tab->nr_off, sizeof(tab->off[0]), bpf_map_kptr_off_cmp);
> +	return field;
>  }
>  
> -void bpf_map_free_kptr_off_tab(struct bpf_map *map)
> +void btf_type_fields_free(struct btf_type_fields *tab)

void btf_record_free(struct btf_record *r)

>  {
> -	struct bpf_map_value_off *tab = map->kptr_off_tab;
>  	int i;
>  
> -	if (!map_value_has_kptrs(map))
> +	if (IS_ERR_OR_NULL(tab))
>  		return;
> -	for (i = 0; i < tab->nr_off; i++) {
> -		if (tab->off[i].kptr.module)
> -			module_put(tab->off[i].kptr.module);
> -		btf_put(tab->off[i].kptr.btf);
> +	for (i = 0; i < tab->cnt; i++) {
> +		switch (tab->fields[i].type) {
> +		case BPF_KPTR_UNREF:
> +		case BPF_KPTR_REF:
> +			if (tab->fields[i].kptr.module)
> +				module_put(tab->fields[i].kptr.module);
> +			btf_put(tab->fields[i].kptr.btf);
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			continue;
> +		}
>  	}
>  	kfree(tab);
> -	map->kptr_off_tab = NULL;
>  }
>  
> -struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
> +void bpf_map_free_fields_tab(struct bpf_map *map)

void bpf_map_free_btf_record(struct bpf_map *map) ?

> +{
> +	btf_type_fields_free(map->fields_tab);
> +	map->fields_tab = NULL;
> +}
> +
> +struct btf_type_fields *btf_type_fields_dup(const struct btf_type_fields *tab)
>  {
> -	struct bpf_map_value_off *tab = map->kptr_off_tab, *new_tab;
> -	int size, i;
> +	struct btf_type_fields *new_tab;
> +	const struct btf_field *fields;
> +	int ret, size, i;
>  
> -	if (!map_value_has_kptrs(map))
> -		return ERR_PTR(-ENOENT);
> -	size = offsetof(struct bpf_map_value_off, off[tab->nr_off]);
> +	if (IS_ERR_OR_NULL(tab))
> +		return NULL;
> +	size = offsetof(struct btf_type_fields, fields[tab->cnt]);
>  	new_tab = kmemdup(tab, size, GFP_KERNEL | __GFP_NOWARN);
>  	if (!new_tab)
>  		return ERR_PTR(-ENOMEM);
> -	/* Do a deep copy of the kptr_off_tab */
> -	for (i = 0; i < tab->nr_off; i++) {
> -		btf_get(tab->off[i].kptr.btf);
> -		if (tab->off[i].kptr.module && !try_module_get(tab->off[i].kptr.module)) {
> -			while (i--) {
> -				if (tab->off[i].kptr.module)
> -					module_put(tab->off[i].kptr.module);
> -				btf_put(tab->off[i].kptr.btf);
> +	/* Do a deep copy of the fields_tab */
> +	fields = tab->fields;
> +	new_tab->cnt = 0;
> +	for (i = 0; i < tab->cnt; i++) {
> +		switch (fields[i].type) {
> +		case BPF_KPTR_UNREF:
> +		case BPF_KPTR_REF:
> +			btf_get(fields[i].kptr.btf);
> +			if (fields[i].kptr.module && !try_module_get(fields[i].kptr.module)) {
> +				ret = -ENXIO;
> +				goto free;
>  			}
> -			kfree(new_tab);
> -			return ERR_PTR(-ENXIO);
> +			break;
> +		default:
> +			ret = -EFAULT;
> +			WARN_ON_ONCE(1);
> +			goto free;
>  		}
> +		new_tab->cnt++;
>  	}
>  	return new_tab;
> +free:
> +	btf_type_fields_free(new_tab);
> +	return ERR_PTR(ret);
>  }
>  
> -bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b)
> +bool btf_type_fields_equal(const struct btf_type_fields *tab_a, const struct btf_type_fields *tab_b)
>  {
> -	struct bpf_map_value_off *tab_a = map_a->kptr_off_tab, *tab_b = map_b->kptr_off_tab;
> -	bool a_has_kptr = map_value_has_kptrs(map_a), b_has_kptr = map_value_has_kptrs(map_b);
> +	bool a_has_fields = !IS_ERR_OR_NULL(tab_a), b_has_fields = !IS_ERR_OR_NULL(tab_b);
>  	int size;
>  
> -	if (!a_has_kptr && !b_has_kptr)
> +	if (!a_has_fields && !b_has_fields)
>  		return true;
> -	if (a_has_kptr != b_has_kptr)
> +	if (a_has_fields != b_has_fields)
>  		return false;
> -	if (tab_a->nr_off != tab_b->nr_off)
> +	if (tab_a->cnt != tab_b->cnt)
>  		return false;
> -	size = offsetof(struct bpf_map_value_off, off[tab_a->nr_off]);
> +	size = offsetof(struct btf_type_fields, fields[tab_a->cnt]);
>  	return !memcmp(tab_a, tab_b, size);
>  }
>  
> -/* Caller must ensure map_value_has_kptrs is true. Note that this function can
> - * be called on a map value while the map_value is visible to BPF programs, as
> - * it ensures the correct synchronization, and we already enforce the same using
> - * the bpf_kptr_xchg helper on the BPF program side for referenced kptrs.
> - */
> -void bpf_map_free_kptrs(struct bpf_map *map, void *map_value)
> +void bpf_obj_free_fields(const struct btf_type_fields *tab, void *obj)

Still thinking about this one. bpf_obj_free_fields() seems to fit fine.
