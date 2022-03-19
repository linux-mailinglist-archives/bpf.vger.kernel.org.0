Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6397D4DE9FA
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 19:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiCSSRG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 14:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiCSSRF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 14:17:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7762A1B3089
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:15:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so7294961pjm.0
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JxhqNZfSxw0PQ4PG6KhbGorRa9FtoE4SoYu1Wt0fLRw=;
        b=XnaEMeCelqN/MpT9sZ37tmdjRK/R+aAlBEFAX63AxfymIb6WYDhj4ZlvKIUJAnqyn2
         sAgpe+Q6OHJWip/pk2rW/wi1qtJwae7e6SRsPz8KIOWzSZHpVoKYvlSS2GnXLYPS/vkQ
         XQU4yFZ8QMhH3OartfYwHZlkq4NvmV78TGJyBdVURoEkycCDj9WE+dmclYLEkLZwUX0l
         fL9RsJL2RUEpektOtKoDW+nAhUccC0XARFelO6EHQo1+Jbwe8+b5IGObIWUKdwbr/Bfx
         aOVbSfrUZOjjHboImfA2Klg+zZqTXZPjQ2o5zYV+lv5a0UtD2LhrW0cOtwr5WJXD5lak
         hWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JxhqNZfSxw0PQ4PG6KhbGorRa9FtoE4SoYu1Wt0fLRw=;
        b=kSfCspHdBcHKPrhpuFuxG3GwdtGVlB0a5XzBoL+hWltdaU+cvwWAxXYFUmH11aku0W
         EAtuetJqoGwhlUFqO/ABb76hgSDWgQGDZOa1LB/jXtfk/mHg6W810y9mm4ZFGygvIKU9
         A1O/hsBQpkmXNKHdqYWd8W1X38qqPDVuu1ExHE6ULnc3Kg/kJyUPux0bpCurKNXCfXKC
         XPHNI/w/fYmxsZGWmlaOnHtXJt8+R8qnSWuczxPy/MfHNfVmJvGQjtqQHupkBISG3PZk
         FFSNacLGh8kBXedmFUDebJcbd1LpM1nc2VqWYbu6vLNqU4A5wJ1Ds2e1ml14Z4D+p66J
         ggyA==
X-Gm-Message-State: AOAM532W2GmmH4gabIECtpDqA9zr1GLLn3oQre/hyiF1PIbadTtotlY7
        FyU+YVNv1ySRlqcnwuhDQ4U=
X-Google-Smtp-Source: ABdhPJwatX7uOZX4Ni2dGdxP8aos4GRRmtakddorEglZsaXdXf/IBlKh8SDRybaJXvsT7XPc2n//AA==
X-Received: by 2002:a17:903:1210:b0:151:fa59:95ef with SMTP id l16-20020a170903121000b00151fa5995efmr5358883plh.57.1647713741586;
        Sat, 19 Mar 2022 11:15:41 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a65d])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm14116091pfc.190.2022.03.19.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:15:41 -0700 (PDT)
Date:   Sat, 19 Mar 2022 11:15:38 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 03/15] bpf: Allow storing unreferenced kptr
 in map
Message-ID: <20220319181538.nbqdkprjrzkxk7v4@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-4-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317115957.3193097-4-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 17, 2022 at 05:29:45PM +0530, Kumar Kartikeya Dwivedi wrote:
> This commit introduces a new pointer type 'kptr' which can be embedded
> in a map value as holds a PTR_TO_BTF_ID stored by a BPF program during
> its invocation. Storing to such a kptr, BPF program's PTR_TO_BTF_ID
> register must have the same type as in the map value's BTF, and loading
> a kptr marks the destination register as PTR_TO_BTF_ID with the correct
> kernel BTF and BTF ID.
> 
> Such kptr are unreferenced, i.e. by the time another invocation of the
> BPF program loads this pointer, the object which the pointer points to
> may not longer exist. Since PTR_TO_BTF_ID loads (using BPF_LDX) are
> patched to PROBE_MEM loads by the verifier, it would safe to allow user
> to still access such invalid pointer, but passing such pointers into
> BPF helpers and kfuncs should not be permitted. A future patch in this
> series will close this gap.
> 
> The flexibility offered by allowing programs to dereference such invalid
> pointers while being safe at runtime frees the verifier from doing
> complex lifetime tracking. As long as the user may ensure that the
> object remains valid, it can ensure data read by it from the kernel
> object is valid.
> 
> The user indicates that a certain pointer must be treated as kptr
> capable of accepting stores of PTR_TO_BTF_ID of a certain type, by using
> a BTF type tag 'kptr' on the pointed to type of the pointer. Then, this
> information is recorded in the object BTF which will be passed into the
> kernel by way of map's BTF information. The name and kind from the map
> value BTF is used to look up the in-kernel type, and the actual BTF and
> BTF ID is recorded in the map struct in a new kptr_off_tab member. For
> now, only storing pointers to structs is permitted.
> 
> An example of this specification is shown below:
> 
> 	#define __kptr __attribute__((btf_type_tag("kptr")))
> 
> 	struct map_value {
> 		...
> 		struct task_struct __kptr *task;
> 		...
> 	};
> 
> Then, in a BPF program, user may store PTR_TO_BTF_ID with the type
> task_struct into the map, and then load it later.
> 
> Note that the destination register is marked PTR_TO_BTF_ID_OR_NULL, as
> the verifier cannot know whether the value is NULL or not statically, it
> must treat all potential loads at that map value offset as loading a
> possibly NULL pointer.
> 
> Only BPF_LDX, BPF_STX, and BPF_ST with insn->imm = 0 (to denote NULL)
> are allowed instructions that can access such a pointer. On BPF_LDX, the
> destination register is updated to be a PTR_TO_BTF_ID, and on BPF_STX,
> it is checked whether the source register type is a PTR_TO_BTF_ID with
> same BTF type as specified in the map BTF. The access size must always
> be BPF_DW.
> 
> For the map in map support, the kptr_off_tab for outer map is copied
> from the inner map's kptr_off_tab. It was chosen to do a deep copy
> instead of introducing a refcount to kptr_off_tab, because the copy only
> needs to be done when paramterizing using inner_map_fd in the map in map
> case, hence would be unnecessary for all other users.
> 
> It is not permitted to use MAP_FREEZE command and mmap for BPF map
> having kptr, similar to the bpf_timer case.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h     |  29 +++++-
>  include/linux/btf.h     |   2 +
>  kernel/bpf/btf.c        | 151 +++++++++++++++++++++++++----
>  kernel/bpf/map_in_map.c |   5 +-
>  kernel/bpf/syscall.c    | 110 ++++++++++++++++++++-
>  kernel/bpf/verifier.c   | 207 ++++++++++++++++++++++++++++++++--------
>  6 files changed, 442 insertions(+), 62 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 88449fbbe063..f35920d279dd 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -155,6 +155,22 @@ struct bpf_map_ops {
>  	const struct bpf_iter_seq_info *iter_seq_info;
>  };
>  
> +enum {
> +	/* Support at most 8 pointers in a BPF map value */
> +	BPF_MAP_VALUE_OFF_MAX = 8,
> +};
> +
> +struct bpf_map_value_off_desc {
> +	u32 offset;
> +	u32 btf_id;
> +	struct btf *btf;
> +};
> +
> +struct bpf_map_value_off {
> +	u32 nr_off;
> +	struct bpf_map_value_off_desc off[];
> +};
> +
>  struct bpf_map {
>  	/* The first two cachelines with read-mostly members of which some
>  	 * are also accessed in fast-path (e.g. ops, max_entries).
> @@ -171,6 +187,7 @@ struct bpf_map {
>  	u64 map_extra; /* any per-map-type extra fields */
>  	u32 map_flags;
>  	int spin_lock_off; /* >=0 valid offset, <0 error */
> +	struct bpf_map_value_off *kptr_off_tab;
>  	int timer_off; /* >=0 valid offset, <0 error */
>  	u32 id;
>  	int numa_node;
> @@ -184,7 +201,7 @@ struct bpf_map {
>  	char name[BPF_OBJ_NAME_LEN];
>  	bool bypass_spec_v1;
>  	bool frozen; /* write-once; write-protected by freeze_mutex */
> -	/* 14 bytes hole */
> +	/* 6 bytes hole */
>  
>  	/* The 3rd and 4th cacheline with misc members to avoid false sharing
>  	 * particularly with refcounting.
> @@ -217,6 +234,11 @@ static inline bool map_value_has_timer(const struct bpf_map *map)
>  	return map->timer_off >= 0;
>  }
>  
> +static inline bool map_value_has_kptr(const struct bpf_map *map)
> +{
> +	return !IS_ERR_OR_NULL(map->kptr_off_tab);
> +}
> +
>  static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
>  {
>  	if (unlikely(map_value_has_spin_lock(map)))
> @@ -1497,6 +1519,11 @@ void bpf_prog_put(struct bpf_prog *prog);
>  void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock);
>  void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);
>  
> +struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset);
> +void bpf_map_free_kptr_off_tab(struct bpf_map *map);
> +struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map);
> +bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
> +
>  struct bpf_map *bpf_map_get(u32 ufd);
>  struct bpf_map *bpf_map_get_with_uref(u32 ufd);
>  struct bpf_map *__bpf_map_get(struct fd f);
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 36bc09b8e890..5b578dc81c04 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -123,6 +123,8 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>  			   u32 expected_offset, u32 expected_size);
>  int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
>  int btf_find_timer(const struct btf *btf, const struct btf_type *t);
> +struct bpf_map_value_off *btf_find_kptr(const struct btf *btf,
> +					const struct btf_type *t);
>  bool btf_type_is_void(const struct btf_type *t);
>  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
>  const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 5b2824332880..9ac9364ef533 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3164,33 +3164,79 @@ static void btf_struct_log(struct btf_verifier_env *env,
>  enum {
>  	BTF_FIELD_SPIN_LOCK,
>  	BTF_FIELD_TIMER,
> +	BTF_FIELD_KPTR,
> +};
> +
> +enum {
> +	BTF_FIELD_IGNORE = 0,
> +	BTF_FIELD_FOUND  = 1,
>  };
>  
>  struct btf_field_info {
> +	const struct btf_type *type;
>  	u32 off;
>  };
>  
>  static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t,
> -				 u32 off, int sz, struct btf_field_info *info)
> +				 u32 off, int sz, struct btf_field_info *info,
> +				 int info_cnt, int idx)
>  {
>  	if (!__btf_type_is_struct(t))
> -		return 0;
> +		return BTF_FIELD_IGNORE;
>  	if (t->size != sz)
> -		return 0;
> -	if (info->off != -ENOENT)
> -		/* only one such field is allowed */
> +		return BTF_FIELD_IGNORE;
> +	if (idx >= info_cnt)

No need to pass info_cnt, idx into this function.
Move idx >= info_cnt check into the caller and let
caller do 'info++' and pass that.
This function will simply write into 'info'.

>  		return -E2BIG;
> +	info[idx].off = off;
>  	info->off = off;

This can't be right.

> -	return 0;
> +	return BTF_FIELD_FOUND;
> +}
> +
> +static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
> +			       u32 off, int sz, struct btf_field_info *info,
> +			       int info_cnt, int idx)
> +{
> +	bool kptr_tag = false;
> +
> +	/* For PTR, sz is always == 8 */
> +	if (!btf_type_is_ptr(t))
> +		return BTF_FIELD_IGNORE;
> +	t = btf_type_by_id(btf, t->type);
> +
> +	while (btf_type_is_type_tag(t)) {
> +		if (!strcmp("kptr", __btf_name_by_offset(btf, t->name_off))) {
> +			/* repeated tag */
> +			if (kptr_tag)
> +				return -EEXIST;
> +			kptr_tag = true;
> +		}
> +		/* Look for next tag */
> +		t = btf_type_by_id(btf, t->type);
> +	}

There is no need for while() loop and 4 bool kptr_*_tag checks.
Just do:
  if (!btf_type_is_type_tag(t))
     return BTF_FIELD_IGNORE;
  /* check next tag */
  if (btf_type_is_type_tag(btf_type_by_id(btf, t->type))
     return -EINVAL;
  if (!strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
     flag = 0;
  else if (!strcmp("kptr_ref", __btf_name_by_offset(btf, t->name_off)))
    flag = BPF_MAP_VALUE_OFF_F_REF;
  ...

> +	if (!kptr_tag)
> +		return BTF_FIELD_IGNORE;
> +
> +	/* Get the base type */
> +	if (btf_type_is_modifier(t))
> +		t = btf_type_skip_modifiers(btf, t->type, NULL);
> +	/* Only pointer to struct is allowed */
> +	if (!__btf_type_is_struct(t))
> +		return -EINVAL;
> +
> +	if (idx >= info_cnt)
> +		return -E2BIG;
> +	info[idx].type = t;
> +	info[idx].off = off;
> +	return BTF_FIELD_FOUND;
>  }
>  
>  static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
>  				 const char *name, int sz, int align, int field_type,
> -				 struct btf_field_info *info)
> +				 struct btf_field_info *info, int info_cnt)
>  {
>  	const struct btf_member *member;
> +	int ret, idx = 0;
>  	u32 i, off;
> -	int ret;
>  
>  	for_each_member(i, t, member) {
>  		const struct btf_type *member_type = btf_type_by_id(btf,
> @@ -3210,24 +3256,33 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
>  		switch (field_type) {
>  		case BTF_FIELD_SPIN_LOCK:
>  		case BTF_FIELD_TIMER:
> -			ret = btf_find_field_struct(btf, member_type, off, sz, info);
> +			ret = btf_find_field_struct(btf, member_type, off, sz, info, info_cnt, idx);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		case BTF_FIELD_KPTR:
> +			ret = btf_find_field_kptr(btf, member_type, off, sz, info, info_cnt, idx);
>  			if (ret < 0)
>  				return ret;
>  			break;
>  		default:
>  			return -EFAULT;
>  		}
> +
> +		if (ret == BTF_FIELD_IGNORE)
> +			continue;
> +		++idx;
>  	}
> -	return 0;
> +	return idx;
>  }
>  
>  static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>  				const char *name, int sz, int align, int field_type,
> -				struct btf_field_info *info)
> +				struct btf_field_info *info, int info_cnt)
>  {
>  	const struct btf_var_secinfo *vsi;
> +	int ret, idx = 0;
>  	u32 i, off;
> -	int ret;
>  
>  	for_each_vsi(i, t, vsi) {
>  		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
> @@ -3245,25 +3300,34 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>  		switch (field_type) {
>  		case BTF_FIELD_SPIN_LOCK:
>  		case BTF_FIELD_TIMER:
> -			ret = btf_find_field_struct(btf, var_type, off, sz, info);
> +			ret = btf_find_field_struct(btf, var_type, off, sz, info, info_cnt, idx);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		case BTF_FIELD_KPTR:
> +			ret = btf_find_field_kptr(btf, var_type, off, sz, info, info_cnt, idx);
>  			if (ret < 0)
>  				return ret;
>  			break;
>  		default:
>  			return -EFAULT;
>  		}
> +
> +		if (ret == BTF_FIELD_IGNORE)
> +			continue;
> +		++idx;
>  	}
> -	return 0;
> +	return idx;
>  }
>  
>  static int btf_find_field(const struct btf *btf, const struct btf_type *t,
>  			  const char *name, int sz, int align, int field_type,
> -			  struct btf_field_info *info)
> +			  struct btf_field_info *info, int info_cnt)
>  {
>  	if (__btf_type_is_struct(t))
> -		return btf_find_struct_field(btf, t, name, sz, align, field_type, info);
> +		return btf_find_struct_field(btf, t, name, sz, align, field_type, info, info_cnt);
>  	else if (btf_type_is_datasec(t))
> -		return btf_find_datasec_var(btf, t, name, sz, align, field_type, info);
> +		return btf_find_datasec_var(btf, t, name, sz, align, field_type, info, info_cnt);
>  	return -EINVAL;
>  }
>  
> @@ -3279,7 +3343,7 @@ int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
>  	ret = btf_find_field(btf, t, "bpf_spin_lock",
>  			     sizeof(struct bpf_spin_lock),
>  			     __alignof__(struct bpf_spin_lock),
> -			     BTF_FIELD_SPIN_LOCK, &info);
> +			     BTF_FIELD_SPIN_LOCK, &info, 1);
>  	if (ret < 0)
>  		return ret;
>  	return info.off;
> @@ -3293,12 +3357,61 @@ int btf_find_timer(const struct btf *btf, const struct btf_type *t)
>  	ret = btf_find_field(btf, t, "bpf_timer",
>  			     sizeof(struct bpf_timer),
>  			     __alignof__(struct bpf_timer),
> -			     BTF_FIELD_TIMER, &info);
> +			     BTF_FIELD_TIMER, &info, 1);
>  	if (ret < 0)
>  		return ret;
>  	return info.off;
>  }
>  
> +struct bpf_map_value_off *btf_find_kptr(const struct btf *btf,
> +					const struct btf_type *t)
> +{
> +	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
> +	struct bpf_map_value_off *tab;
> +	int ret, i, nr_off;
> +
> +	/* Revisit stack usage when bumping BPF_MAP_VALUE_OFF_MAX */
> +	BUILD_BUG_ON(BPF_MAP_VALUE_OFF_MAX != 8);
> +
> +	ret = btf_find_field(btf, t, NULL, sizeof(u64), __alignof__(u64),

these pointless args will be gone with suggestion in the previous patch.

> +			     BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +	if (!ret)
> +		return 0;
> +
> +	nr_off = ret;
> +	tab = kzalloc(offsetof(struct bpf_map_value_off, off[nr_off]), GFP_KERNEL | __GFP_NOWARN);
> +	if (!tab)
> +		return ERR_PTR(-ENOMEM);
> +
> +	tab->nr_off = 0;
> +	for (i = 0; i < nr_off; i++) {
> +		const struct btf_type *t;
> +		struct btf *off_btf;
> +		s32 id;
> +
> +		t = info_arr[i].type;
> +		id = bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO_KIND(t->info),
> +				     &off_btf);
> +		if (id < 0) {
> +			ret = id;
> +			goto end;
> +		}
> +
> +		tab->off[i].offset = info_arr[i].off;
> +		tab->off[i].btf_id = id;
> +		tab->off[i].btf = off_btf;
> +		tab->nr_off = i + 1;
> +	}
> +	return tab;
> +end:
> +	while (tab->nr_off--)
> +		btf_put(tab->off[tab->nr_off].btf);
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
> index 9beb585be5a6..87263b07f40b 100644
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
> @@ -472,12 +473,95 @@ static void bpf_map_release_memcg(struct bpf_map *map)
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
> +	if (!map_value_has_kptr(map))
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
> +	if (!map_value_has_kptr(map))
> +		return;
> +	for (i = 0; i < tab->nr_off; i++) {
> +		struct btf *btf = tab->off[i].btf;
> +
> +		btf_put(btf);
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
> +	if (!map_value_has_kptr(map))
> +		return ERR_PTR(-ENOENT);
> +	/* Do a deep copy of the kptr_off_tab */
> +	for (i = 0; i < tab->nr_off; i++)
> +		btf_get(tab->off[i].btf);
> +
> +	size = offsetof(struct bpf_map_value_off, off[tab->nr_off]);
> +	new_tab = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
> +	if (!new_tab) {
> +		ret = -ENOMEM;
> +		goto end;
> +	}
> +	memcpy(new_tab, tab, size);
> +	return new_tab;
> +end:
> +	while (i--)
> +		btf_put(tab->off[i].btf);
> +	return ERR_PTR(ret);
> +}
> +
> +bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b)
> +{
> +	struct bpf_map_value_off *tab_a = map_a->kptr_off_tab, *tab_b = map_b->kptr_off_tab;
> +	bool a_has_kptr = map_value_has_kptr(map_a), b_has_kptr = map_value_has_kptr(map_b);
> +	int size;
> +
> +	if (!a_has_kptr && !b_has_kptr)
> +		return true;
> +	if ((a_has_kptr && !b_has_kptr) || (!a_has_kptr && b_has_kptr))
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
> @@ -639,7 +723,7 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
>  	int err;
>  
>  	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
> -	    map_value_has_timer(map))
> +	    map_value_has_timer(map) || map_value_has_kptr(map))
>  		return -ENOTSUPP;
>  
>  	if (!(vma->vm_flags & VM_SHARED))
> @@ -819,9 +903,29 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>  			return -EOPNOTSUPP;
>  	}
>  
> -	if (map->ops->map_check_btf)
> +	map->kptr_off_tab = btf_find_kptr(btf, value_type);
> +	if (map_value_has_kptr(map)) {
> +		if (map->map_flags & BPF_F_RDONLY_PROG) {
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
> @@ -1638,7 +1742,7 @@ static int map_freeze(const union bpf_attr *attr)
>  		return PTR_ERR(map);
>  
>  	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
> -	    map_value_has_timer(map)) {
> +	    map_value_has_timer(map) || map_value_has_kptr(map)) {
>  		fdput(f);
>  		return -ENOTSUPP;
>  	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cf92f9c01556..881d1381757b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3469,6 +3469,143 @@ static int check_mem_region_access(struct bpf_verifier_env *env, u32 regno,
>  	return 0;
>  }
>  
> +static int __check_ptr_off_reg(struct bpf_verifier_env *env,
> +			       const struct bpf_reg_state *reg, int regno,
> +			       bool fixed_off_ok)
> +{
> +	/* Access to this pointer-typed register or passing it to a helper
> +	 * is only allowed in its original, unmodified form.
> +	 */
> +
> +	if (reg->off < 0) {
> +		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
> +			reg_type_str(env, reg->type), regno, reg->off);
> +		return -EACCES;
> +	}
> +
> +	if (!fixed_off_ok && reg->off) {
> +		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
> +			reg_type_str(env, reg->type), regno, reg->off);
> +		return -EACCES;
> +	}
> +
> +	if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
> +		char tn_buf[48];
> +
> +		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +		verbose(env, "variable %s access var_off=%s disallowed\n",
> +			reg_type_str(env, reg->type), tn_buf);
> +		return -EACCES;
> +	}
> +
> +	return 0;
> +}
> +
> +int check_ptr_off_reg(struct bpf_verifier_env *env,
> +		      const struct bpf_reg_state *reg, int regno)
> +{
> +	return __check_ptr_off_reg(env, reg, regno, false);
> +}
> +
> +static int map_kptr_match_type(struct bpf_verifier_env *env,
> +			       struct bpf_map_value_off_desc *off_desc,
> +			       struct bpf_reg_state *reg, u32 regno)
> +{
> +	const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
> +	const char *reg_name = "";
> +
> +	if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
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
> +				  off_desc->btf, off_desc->btf_id))
> +		goto bad_type;
> +	return 0;
> +bad_type:
> +	verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
> +		reg_type_str(env, reg->type), reg_name);
> +	verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> +	return -EINVAL;
> +}
> +
> +/* Returns an error, or 0 if ignoring the access, or 1 if register state was
> + * updated, in which case later updates must be skipped.
> + */
> +static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> +				 int off, int size, int value_regno,
> +				 enum bpf_access_type t, int insn_idx)
> +{
> +	struct bpf_reg_state *reg = reg_state(env, regno), *val_reg;
> +	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
> +	struct bpf_map_value_off_desc *off_desc;
> +	int insn_class = BPF_CLASS(insn->code);
> +	struct bpf_map *map = reg->map_ptr;
> +
> +	/* Things we already checked for in check_map_access:
> +	 *  - Reject cases where variable offset may touch BTF ID pointer
> +	 *  - size of access (must be BPF_DW)
> +	 *  - off_desc->offset == off + reg->var_off.value
> +	 */
> +	if (!tnum_is_const(reg->var_off))
> +		return 0;
> +
> +	off_desc = bpf_map_kptr_off_contains(map, off + reg->var_off.value);
> +	if (!off_desc)
> +		return 0;
> +
> +	if (WARN_ON_ONCE(size != bpf_size_to_bytes(BPF_DW)))

since the check was made, please avoid defensive progamming.

> +		return -EACCES;
> +
> +	if (BPF_MODE(insn->code) != BPF_MEM)

what is this? a fancy way to filter ldx/stx/st insns?
Pls add a comment if so.

> +		goto end;
> +
> +	if (!env->bpf_capable) {
> +		verbose(env, "kptr access only allowed for CAP_BPF and CAP_SYS_ADMIN\n");
> +		return -EPERM;

Please move this check into map_check_btf().
That's the earliest place we can issue such error.
Doing it here is so late and it doesn't help users, but makes run-time slower,
since this function is called a lot more times than map_check_btf.

> +	}
> +
> +	if (insn_class == BPF_LDX) {
> +		if (WARN_ON_ONCE(value_regno < 0))
> +			return -EFAULT;

defensive programming? Pls dont.

> +		val_reg = reg_state(env, value_regno);
> +		/* We can simply mark the value_regno receiving the pointer
> +		 * value from map as PTR_TO_BTF_ID, with the correct type.
> +		 */
> +		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->btf,
> +				off_desc->btf_id, PTR_MAYBE_NULL);
> +		val_reg->id = ++env->id_gen;
> +	} else if (insn_class == BPF_STX) {
> +		if (WARN_ON_ONCE(value_regno < 0))
> +			return -EFAULT;
> +		val_reg = reg_state(env, value_regno);
> +		if (!register_is_null(val_reg) &&
> +		    map_kptr_match_type(env, off_desc, val_reg, value_regno))
> +			return -EACCES;
> +	} else if (insn_class == BPF_ST) {
> +		if (insn->imm) {
> +			verbose(env, "BPF_ST imm must be 0 when storing to kptr at off=%u\n",
> +				off_desc->offset);
> +			return -EACCES;
> +		}
> +	} else {
> +		goto end;
> +	}
> +	return 1;
> +end:
> +	verbose(env, "kptr in map can only be accessed using BPF_LDX/BPF_STX/BPF_ST\n");
> +	return -EACCES;
> +}
> +
>  /* check read/write into a map element with possible variable offset */
>  static int check_map_access(struct bpf_verifier_env *env, u32 regno,
>  			    int off, int size, bool zero_size_allowed)
> @@ -3507,6 +3644,32 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
>  			return -EACCES;
>  		}
>  	}
> +	if (map_value_has_kptr(map)) {
> +		struct bpf_map_value_off *tab = map->kptr_off_tab;
> +		int i;
> +
> +		for (i = 0; i < tab->nr_off; i++) {
> +			u32 p = tab->off[i].offset;
> +
> +			if (reg->smin_value + off < p + sizeof(u64) &&
> +			    p < reg->umax_value + off + size) {
> +				if (!tnum_is_const(reg->var_off)) {
> +					verbose(env, "kptr access cannot have variable offset\n");
> +					return -EACCES;
> +				}
> +				if (p != off + reg->var_off.value) {
> +					verbose(env, "kptr access misaligned expected=%u off=%llu\n",
> +						p, off + reg->var_off.value);
> +					return -EACCES;
> +				}
> +				if (size != bpf_size_to_bytes(BPF_DW)) {
> +					verbose(env, "kptr access size must be BPF_DW\n");
> +					return -EACCES;
> +				}
> +				break;
> +			}
> +		}
> +	}
>  	return err;
>  }
>  
> @@ -3980,44 +4143,6 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
>  }
>  #endif
>  
> -static int __check_ptr_off_reg(struct bpf_verifier_env *env,
> -			       const struct bpf_reg_state *reg, int regno,
> -			       bool fixed_off_ok)
> -{
> -	/* Access to this pointer-typed register or passing it to a helper
> -	 * is only allowed in its original, unmodified form.
> -	 */
> -
> -	if (reg->off < 0) {
> -		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
> -			reg_type_str(env, reg->type), regno, reg->off);
> -		return -EACCES;
> -	}
> -
> -	if (!fixed_off_ok && reg->off) {
> -		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
> -			reg_type_str(env, reg->type), regno, reg->off);
> -		return -EACCES;
> -	}
> -
> -	if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
> -		char tn_buf[48];
> -
> -		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> -		verbose(env, "variable %s access var_off=%s disallowed\n",
> -			reg_type_str(env, reg->type), tn_buf);
> -		return -EACCES;
> -	}
> -
> -	return 0;
> -}
> -
> -int check_ptr_off_reg(struct bpf_verifier_env *env,
> -		      const struct bpf_reg_state *reg, int regno)
> -{
> -	return __check_ptr_off_reg(env, reg, regno, false);
> -}
> -

please split the hunk that moves code around into separate patch.
Don't mix it with actual changes.

>  static int __check_buffer_access(struct bpf_verifier_env *env,
>  				 const char *buf_info,
>  				 const struct bpf_reg_state *reg,
> @@ -4421,6 +4546,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  		if (err)
>  			return err;
>  		err = check_map_access(env, regno, off, size, false);
> +		err = err ?: check_map_kptr_access(env, regno, off, size, value_regno, t, insn_idx);
> +		if (err < 0)
> +			return err;
> +		/* if err == 0, check_map_kptr_access ignored the access */
>  		if (!err && t == BPF_READ && value_regno >= 0) {
>  			struct bpf_map *map = reg->map_ptr;
>  
> @@ -4442,6 +4571,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  				mark_reg_unknown(env, regs, value_regno);
>  			}
>  		}
> +		/* clear err == 1 */
> +		err = err < 0 ? err : 0;
>  	} else if (base_type(reg->type) == PTR_TO_MEM) {
>  		bool rdonly_mem = type_is_rdonly_mem(reg->type);
>  
> -- 
> 2.35.1
> 

-- 
