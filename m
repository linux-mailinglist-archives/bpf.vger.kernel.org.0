Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092B84DEA13
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 19:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiCSSZe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiCSSZd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 14:25:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399942689AF
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:24:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id o8so7409094pgf.9
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mVa3rrj30VvzYDtRHwukekA9i8em5UlbfMBVZpyI9WE=;
        b=aICtwaWqMm0k9DPWrn3AkUYWI/8c6xhbkaAoMgwO5NSNQEVC6Rhz8XqGR4FvhnbHwR
         xkFOjnpPcfALhOQRaZaoNzfaKkC3/aHbpP3AqPuWTG2ZqONphsC4P7i3SLgOiVgHFnqf
         SZ6fOYcmGOOE5/upMAlxNakvdFoCh+xDUSva2IuQ+R2bfTnRVMQXxa9m9kYoM0Tkgcr0
         SGHdIlPfo7ZdL2rRrIMW5GYE3g5ak88a7iidOSOfQm2KUpCVyJtcDxQFnqFcsmdCJXNK
         zi8Gx9HvOFbCdCEVMvKKFbuLGLFDDPQ/ggZsmIiayOKzO2dcZnNo7HCcrjNIg/bwadbZ
         WLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mVa3rrj30VvzYDtRHwukekA9i8em5UlbfMBVZpyI9WE=;
        b=C+Qtcu/VxmB7nxQ2CYjKjusIjbfFDMhpEL2tPUym8kH8NZIMZA4OgrHJoL89WYcUzD
         2jm8zpWgipP5/6/9HRRUflItHxRMd9vDL/P2eX42MNQ7WP9V2aQvYEDBZWfGG0CnzT9b
         U40PKxl/XSi3peSSn/SHcKw0YkKdwVBm5Nyxnxpc+vu8bpiIxRYpNvCmdGXIbOrkvQpb
         JfambStVtRnEUGlnW72nZtUBE4fhMSoLUKzNdurujp7u8NCrXXF7miUTX4n5mwpWVNDn
         wc1uq4yBWqb/6YIWI4kHXKWr73LsoC0vxC6yoB7Z78wsWqCBkZxiBdjF8rBFeJf8VS4M
         atdw==
X-Gm-Message-State: AOAM532lB7Ffo1Ln3TYMeyvIDZlXrKjAJUTKQL5Xhe1w/EXVY3fIP2Ka
        cfMDTrhLCAtMb9zb+xWX9qo=
X-Google-Smtp-Source: ABdhPJx7hoiMCoAx4pkzrVouwNbyrlVyUvC1/smXY7HwRYgDUbjJQo8UGXJY5tIQrF8qBeY2qVyEIA==
X-Received: by 2002:a63:db53:0:b0:380:cf1d:4401 with SMTP id x19-20020a63db53000000b00380cf1d4401mr12222453pgi.504.1647714250403;
        Sat, 19 Mar 2022 11:24:10 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a65d])
        by smtp.gmail.com with ESMTPSA id z2-20020aa79902000000b004f75842c97csm14463935pff.209.2022.03.19.11.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:24:10 -0700 (PDT)
Date:   Sat, 19 Mar 2022 11:24:07 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 04/15] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220319182407.amdeiliph36zdwlg@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-5-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317115957.3193097-5-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 17, 2022 at 05:29:46PM +0530, Kumar Kartikeya Dwivedi wrote:
> Extending the code in previous commit, introduce referenced kptr
> support, which needs to be tagged using 'kptr_ref' tag instead. Unlike
> unreferenced kptr, referenced kptr have a lot more restrictions. In
> addition to the type matching, only a newly introduced bpf_kptr_xchg
> helper is allowed to modify the map value at that offset. This transfers
> the referenced pointer being stored into the map, releasing the
> references state for the program, and returning the old value and
> creating new reference state for the returned pointer.
> 
> Similar to unreferenced pointer case, return value for this case will
> also be PTR_TO_BTF_ID_OR_NULL. The reference for the returned pointer
> must either be eventually released by calling the corresponding release
> function, otherwise it must be transferred into another map.
> 
> It is also allowed to call bpf_kptr_xchg with a NULL pointer, to clear
> the value, and obtain the old value if any.
> 
> BPF_LDX, BPF_STX, and BPF_ST cannot access referenced kptr. A future
> commit will permit using BPF_LDX for such pointers, but attempt at
> making it safe, since the lifetime of object won't be guaranteed.
> 
> There are valid reasons to enforce the restriction of permitting only
> bpf_kptr_xchg to operate on referenced kptr. The pointer value must be
> consistent in face of concurrent modification, and any prior values
> contained in the map must also be released before a new one is moved
> into the map. To ensure proper transfer of this ownership, bpf_kptr_xchg
> returns the old value, which the verifier would require the user to
> either free or move into another map, and releases the reference held
> for the pointer being moved in.
> 
> In the future, direct BPF_XCHG instruction may also be permitted to work
> like bpf_kptr_xchg helper.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h            |   7 ++
>  include/uapi/linux/bpf.h       |  12 +++
>  kernel/bpf/btf.c               |  20 +++-
>  kernel/bpf/helpers.c           |  21 +++++
>  kernel/bpf/verifier.c          | 167 +++++++++++++++++++++++++++++----
>  tools/include/uapi/linux/bpf.h |  12 +++
>  6 files changed, 219 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f35920d279dd..702aa882e4a3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -160,10 +160,15 @@ enum {
>  	BPF_MAP_VALUE_OFF_MAX = 8,
>  };
>  
> +enum {
> +	BPF_MAP_VALUE_OFF_F_REF = (1U << 0),
> +};
> +
>  struct bpf_map_value_off_desc {
>  	u32 offset;
>  	u32 btf_id;
>  	struct btf *btf;
> +	int flags;
>  };
>  
>  struct bpf_map_value_off {
> @@ -413,6 +418,7 @@ enum bpf_arg_type {
>  	ARG_PTR_TO_STACK,	/* pointer to stack */
>  	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
>  	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
> +	ARG_PTR_TO_KPTR,	/* pointer to kptr */
>  	__BPF_ARG_TYPE_MAX,
>  
>  	/* Extended arg_types. */
> @@ -422,6 +428,7 @@ enum bpf_arg_type {
>  	ARG_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
>  	ARG_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
>  	ARG_PTR_TO_STACK_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
> +	ARG_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
>  
>  	/* This must be the last entry. Its purpose is to ensure the enum is
>  	 * wide enough to hold the higher bits reserved for bpf_type_flag.
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 99fab54ae9c0..d45568746e79 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5129,6 +5129,17 @@ union bpf_attr {
>   *		The **hash_algo** is returned on success,
>   *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
>   *		invalid arguments are passed.
> + *
> + * void *bpf_kptr_xchg(void *map_value, void *ptr)
> + *	Description
> + *		Exchange kptr at pointer *map_value* with *ptr*, and return the
> + *		old value. *ptr* can be NULL, otherwise it must be a referenced
> + *		pointer which will be released when this helper is called.
> + *	Return
> + *		The old value of kptr (which can be NULL). The returned pointer
> + *		if not NULL, is a reference which must be released using its
> + *		corresponding release function, or moved into a BPF map before
> + *		program exit.
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -5325,6 +5336,7 @@ union bpf_attr {
>  	FN(copy_from_user_task),	\
>  	FN(skb_set_tstamp),		\
>  	FN(ima_file_hash),		\
> +	FN(kptr_xchg),			\
>  	/* */
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9ac9364ef533..7b4179667bf1 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3175,6 +3175,7 @@ enum {
>  struct btf_field_info {
>  	const struct btf_type *type;
>  	u32 off;
> +	int flags;
>  };
>  
>  static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t,
> @@ -3196,7 +3197,8 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
>  			       u32 off, int sz, struct btf_field_info *info,
>  			       int info_cnt, int idx)
>  {
> -	bool kptr_tag = false;
> +	bool kptr_tag = false, kptr_ref_tag = false;
> +	int tags;
>  
>  	/* For PTR, sz is always == 8 */
>  	if (!btf_type_is_ptr(t))
> @@ -3209,12 +3211,21 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
>  			if (kptr_tag)
>  				return -EEXIST;
>  			kptr_tag = true;
> +		} else if (!strcmp("kptr_ref", __btf_name_by_offset(btf, t->name_off))) {
> +			/* repeated tag */
> +			if (kptr_ref_tag)
> +				return -EEXIST;
> +			kptr_ref_tag = true;
>  		}
>  		/* Look for next tag */
>  		t = btf_type_by_id(btf, t->type);
>  	}
> -	if (!kptr_tag)
> +
> +	tags = kptr_tag + kptr_ref_tag;
> +	if (!tags)
>  		return BTF_FIELD_IGNORE;
> +	else if (tags > 1)
> +		return -EINVAL;
>  
>  	/* Get the base type */
>  	if (btf_type_is_modifier(t))
> @@ -3225,6 +3236,10 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
>  
>  	if (idx >= info_cnt)
>  		return -E2BIG;
> +	if (kptr_ref_tag)
> +		info[idx].flags = BPF_MAP_VALUE_OFF_F_REF;
> +	else
> +		info[idx].flags = 0;
>  	info[idx].type = t;
>  	info[idx].off = off;
>  	return BTF_FIELD_FOUND;
> @@ -3402,6 +3417,7 @@ struct bpf_map_value_off *btf_find_kptr(const struct btf *btf,
>  		tab->off[i].offset = info_arr[i].off;
>  		tab->off[i].btf_id = id;
>  		tab->off[i].btf = off_btf;
> +		tab->off[i].flags = info_arr[i].flags;
>  		tab->nr_off = i + 1;
>  	}
>  	return tab;
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 315053ef6a75..cb717bfbda19 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1374,6 +1374,25 @@ void bpf_timer_cancel_and_free(void *val)
>  	kfree(t);
>  }
>  
> +BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
> +{
> +	unsigned long *kptr = map_value;
> +
> +	return xchg(kptr, (unsigned long)ptr);
> +}
> +
> +static u32 bpf_kptr_xchg_btf_id;
> +
> +const struct bpf_func_proto bpf_kptr_xchg_proto = {
> +	.func        = bpf_kptr_xchg,
> +	.gpl_only    = false,
> +	.ret_type    = RET_PTR_TO_BTF_ID_OR_NULL,
> +	.ret_btf_id  = &bpf_kptr_xchg_btf_id,
> +	.arg1_type   = ARG_PTR_TO_KPTR,
> +	.arg2_type   = ARG_PTR_TO_BTF_ID_OR_NULL,
> +	.arg2_btf_id = &bpf_kptr_xchg_btf_id,
> +};
> +
>  const struct bpf_func_proto bpf_get_current_task_proto __weak;
>  const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
>  const struct bpf_func_proto bpf_probe_read_user_proto __weak;
> @@ -1452,6 +1471,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>  		return &bpf_timer_start_proto;
>  	case BPF_FUNC_timer_cancel:
>  		return &bpf_timer_cancel_proto;
> +	case BPF_FUNC_kptr_xchg:
> +		return &bpf_kptr_xchg_proto;
>  	default:
>  		break;
>  	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 881d1381757b..f8738054aa52 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -257,6 +257,7 @@ struct bpf_call_arg_meta {
>  	struct btf *ret_btf;
>  	u32 ret_btf_id;
>  	u32 subprogno;
> +	struct bpf_map_value_off_desc *kptr_off_desc;
>  };
>  
>  struct btf *btf_vmlinux;
> @@ -479,7 +480,8 @@ static bool is_release_function(enum bpf_func_id func_id)
>  {
>  	return func_id == BPF_FUNC_sk_release ||
>  	       func_id == BPF_FUNC_ringbuf_submit ||
> -	       func_id == BPF_FUNC_ringbuf_discard;
> +	       func_id == BPF_FUNC_ringbuf_discard ||
> +	       func_id == BPF_FUNC_kptr_xchg;
>  }
>  
>  static bool may_be_acquire_function(enum bpf_func_id func_id)
> @@ -488,7 +490,8 @@ static bool may_be_acquire_function(enum bpf_func_id func_id)
>  		func_id == BPF_FUNC_sk_lookup_udp ||
>  		func_id == BPF_FUNC_skc_lookup_tcp ||
>  		func_id == BPF_FUNC_map_lookup_elem ||
> -	        func_id == BPF_FUNC_ringbuf_reserve;
> +		func_id == BPF_FUNC_ringbuf_reserve ||
> +		func_id == BPF_FUNC_kptr_xchg;
>  }
>  
>  static bool is_acquire_function(enum bpf_func_id func_id,
> @@ -499,7 +502,8 @@ static bool is_acquire_function(enum bpf_func_id func_id,
>  	if (func_id == BPF_FUNC_sk_lookup_tcp ||
>  	    func_id == BPF_FUNC_sk_lookup_udp ||
>  	    func_id == BPF_FUNC_skc_lookup_tcp ||
> -	    func_id == BPF_FUNC_ringbuf_reserve)
> +	    func_id == BPF_FUNC_ringbuf_reserve ||
> +	    func_id == BPF_FUNC_kptr_xchg)
>  		return true;
>  
>  	if (func_id == BPF_FUNC_map_lookup_elem &&
> @@ -3509,10 +3513,12 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
>  
>  static int map_kptr_match_type(struct bpf_verifier_env *env,
>  			       struct bpf_map_value_off_desc *off_desc,
> -			       struct bpf_reg_state *reg, u32 regno)
> +			       struct bpf_reg_state *reg, u32 regno,
> +			       bool ref_ptr)
>  {
>  	const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
>  	const char *reg_name = "";
> +	bool fixed_off_ok = true;
>  
>  	if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
>  		goto bad_type;
> @@ -3524,7 +3530,26 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
>  	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
>  	reg_name = kernel_type_name(reg->btf, reg->btf_id);
>  
> -	if (__check_ptr_off_reg(env, reg, regno, true))
> +	if (ref_ptr) {
> +		if (!reg->ref_obj_id) {
> +			verbose(env, "R%d must be referenced %s%s\n", regno,
> +				reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> +			return -EACCES;
> +		}
> +		/* reg->off can be used to store pointer to a certain type formed by
> +		 * incrementing pointer of a parent structure the object is embedded in,
> +		 * e.g. map may expect unreferenced struct path *, and user should be
> +		 * allowed a store using &file->f_path. However, in the case of
> +		 * referenced pointer, we cannot do this, because the reference is only
> +		 * for the parent structure, not its embedded object(s), and because
> +		 * the transfer of ownership happens for the original pointer to and
> +		 * from the map (before its eventual release).
> +		 */
> +		if (reg->off)
> +			fixed_off_ok = false;
> +	}
> +	/* var_off is rejected by __check_ptr_off_reg for PTR_TO_BTF_ID */
> +	if (__check_ptr_off_reg(env, reg, regno, fixed_off_ok))
>  		return -EACCES;
>  
>  	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> @@ -3550,6 +3575,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
>  	struct bpf_map_value_off_desc *off_desc;
>  	int insn_class = BPF_CLASS(insn->code);
>  	struct bpf_map *map = reg->map_ptr;
> +	bool ref_ptr = false;
>  
>  	/* Things we already checked for in check_map_access:
>  	 *  - Reject cases where variable offset may touch BTF ID pointer
> @@ -3574,9 +3600,15 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
>  		return -EPERM;
>  	}
>  
> +	ref_ptr = off_desc->flags & BPF_MAP_VALUE_OFF_F_REF;
> +
>  	if (insn_class == BPF_LDX) {
>  		if (WARN_ON_ONCE(value_regno < 0))
>  			return -EFAULT;
> +		if (ref_ptr) {
> +			verbose(env, "accessing referenced kptr disallowed\n");
> +			return -EACCES;
> +		}

Please do this warn once instead of copy paste 3 times.

>  		val_reg = reg_state(env, value_regno);
>  		/* We can simply mark the value_regno receiving the pointer
>  		 * value from map as PTR_TO_BTF_ID, with the correct type.
> @@ -3587,11 +3619,19 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
>  	} else if (insn_class == BPF_STX) {
>  		if (WARN_ON_ONCE(value_regno < 0))
>  			return -EFAULT;
> +		if (ref_ptr) {
> +			verbose(env, "accessing referenced kptr disallowed\n");
> +			return -EACCES;
> +		}
>  		val_reg = reg_state(env, value_regno);
>  		if (!register_is_null(val_reg) &&
> -		    map_kptr_match_type(env, off_desc, val_reg, value_regno))
> +		    map_kptr_match_type(env, off_desc, val_reg, value_regno, false))
>  			return -EACCES;
>  	} else if (insn_class == BPF_ST) {
> +		if (ref_ptr) {
> +			verbose(env, "accessing referenced kptr disallowed\n");
> +			return -EACCES;
> +		}
>  		if (insn->imm) {
>  			verbose(env, "BPF_ST imm must be 0 when storing to kptr at off=%u\n",
>  				off_desc->offset);
> @@ -5265,6 +5305,63 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
>  	return 0;
>  }
>  
> +static int process_kptr_func(struct bpf_verifier_env *env, int regno,
> +			     struct bpf_call_arg_meta *meta)
> +{
> +	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> +	struct bpf_map_value_off_desc *off_desc;
> +	struct bpf_map *map_ptr = reg->map_ptr;
> +	u32 kptr_off;
> +	int ret;
> +
> +	if (!env->bpf_capable) {
> +		verbose(env, "kptr access only allowed for CAP_BPF and CAP_SYS_ADMIN\n");
> +		return -EPERM;
> +	}

another check? pls drop.

> +	if (!tnum_is_const(reg->var_off)) {
> +		verbose(env,
> +			"R%d doesn't have constant offset. kptr has to be at the constant offset\n",
> +			regno);
> +		return -EINVAL;
> +	}
> +	if (!map_ptr->btf) {
> +		verbose(env, "map '%s' has to have BTF in order to use bpf_kptr_xchg\n",
> +			map_ptr->name);
> +		return -EINVAL;
> +	}
> +	if (!map_value_has_kptr(map_ptr)) {
> +		ret = PTR_ERR(map_ptr->kptr_off_tab);
> +		if (ret == -E2BIG)
> +			verbose(env, "map '%s' has more than %d kptr\n", map_ptr->name,
> +				BPF_MAP_VALUE_OFF_MAX);
> +		else if (ret == -EEXIST)
> +			verbose(env, "map '%s' has repeating kptr BTF tags\n", map_ptr->name);
> +		else
> +			verbose(env, "map '%s' has no valid kptr\n", map_ptr->name);
> +		return -EINVAL;
> +	}
> +
> +	meta->map_ptr = map_ptr;
> +	/* Check access for BPF_WRITE */
> +	meta->raw_mode = true;
> +	ret = check_helper_mem_access(env, regno, sizeof(u64), false, meta);
> +	if (ret < 0)
> +		return ret;
> +
> +	kptr_off = reg->off + reg->var_off.value;
> +	off_desc = bpf_map_kptr_off_contains(map_ptr, kptr_off);
> +	if (!off_desc) {
> +		verbose(env, "off=%d doesn't point to kptr\n", kptr_off);
> +		return -EACCES;
> +	}
> +	if (!(off_desc->flags & BPF_MAP_VALUE_OFF_F_REF)) {
> +		verbose(env, "off=%d kptr isn't referenced kptr\n", kptr_off);
> +		return -EACCES;
> +	}
> +	meta->kptr_off_desc = off_desc;
> +	return 0;
> +}
> +
>  static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
>  {
>  	return base_type(type) == ARG_PTR_TO_MEM ||
> @@ -5400,6 +5497,7 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
>  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
>  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
>  static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
> +static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
>  
>  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
> @@ -5427,11 +5525,13 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
>  	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
>  	[ARG_PTR_TO_TIMER]		= &timer_types,
> +	[ARG_PTR_TO_KPTR]		= &kptr_types,
>  };
>  
>  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  			  enum bpf_arg_type arg_type,
> -			  const u32 *arg_btf_id)
> +			  const u32 *arg_btf_id,
> +			  struct bpf_call_arg_meta *meta)
>  {
>  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
>  	enum bpf_reg_type expected, type = reg->type;
> @@ -5484,8 +5584,15 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  			arg_btf_id = compatible->btf_id;
>  		}
>  
> -		if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> -					  btf_vmlinux, *arg_btf_id)) {
> +		if (meta->func_id == BPF_FUNC_kptr_xchg) {
> +			if (!meta->kptr_off_desc) {
> +				verbose(env, "verifier internal error: meta.kptr_off_desc unset\n");
> +				return -EFAULT;
> +			}

please audit all patches and remove all instances of defensive programming.

> +			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno, true))
> +				return -EACCES;
> +		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> +						 btf_vmlinux, *arg_btf_id)) {
>  			verbose(env, "R%d is of type %s but %s is expected\n",
>  				regno, kernel_type_name(reg->btf, reg->btf_id),
>  				kernel_type_name(btf_vmlinux, *arg_btf_id));
> @@ -5595,7 +5702,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		 */
>  		goto skip_type_check;
>  
> -	err = check_reg_type(env, regno, arg_type, fn->arg_btf_id[arg]);
> +	err = check_reg_type(env, regno, arg_type, fn->arg_btf_id[arg], meta);
>  	if (err)
>  		return err;
>  
> @@ -5760,6 +5867,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			verbose(env, "string is not zero-terminated\n");
>  			return -EINVAL;
>  		}
> +	} else if (arg_type == ARG_PTR_TO_KPTR) {
> +		if (meta->func_id == BPF_FUNC_kptr_xchg) {
> +			if (process_kptr_func(env, regno, meta))
> +				return -EACCES;
> +		} else {
> +			verbose(env, "verifier internal error\n");
> +			return -EFAULT;

remove.

> +		}
>  	}
>  
>  	return err;
> @@ -6102,10 +6217,10 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
> -		if (fn->arg_type[i] == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
> +		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
>  			return false;
>  
> -		if (fn->arg_type[i] != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i])
> +		if (base_type(fn->arg_type[i]) != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i])
>  			return false;
>  	}
>  
> @@ -6830,7 +6945,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	}
>  
>  	if (is_release_function(func_id)) {
> -		err = release_reference(env, meta.ref_obj_id);
> +		err = -EINVAL;
> +		if (meta.ref_obj_id)
> +			err = release_reference(env, meta.ref_obj_id);
> +		/* Only bpf_kptr_xchg is a release function that accepts a
> +		 * possibly NULL reg, hence meta.ref_obj_id can only be unset
> +		 * for it.

Could you rephrase the comment? I'm not following what it's trying to convey.

> +		 */
> +		else if (func_id == BPF_FUNC_kptr_xchg)
> +			err = 0;
>  		if (err) {
>  			verbose(env, "func %s#%d reference has not been acquired before\n",
>  				func_id_name(func_id), func_id);
> @@ -6963,21 +7086,29 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
>  		}
>  	} else if (base_type(ret_type) == RET_PTR_TO_BTF_ID) {
> +		struct btf *ret_btf;
>  		int ret_btf_id;
>  
>  		mark_reg_known_zero(env, regs, BPF_REG_0);
>  		regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
> -		ret_btf_id = *fn->ret_btf_id;
> +		if (func_id == BPF_FUNC_kptr_xchg) {
> +			if (!meta.kptr_off_desc) {
> +				verbose(env, "verifier internal error: meta.kptr_off_desc unset\n");
> +				return -EFAULT;

remove.

> +			}
> +			ret_btf = meta.kptr_off_desc->btf;
> +			ret_btf_id = meta.kptr_off_desc->btf_id;
> +		} else {
> +			ret_btf = btf_vmlinux;
> +			ret_btf_id = *fn->ret_btf_id;
> +		}
>  		if (ret_btf_id == 0) {
>  			verbose(env, "invalid return type %u of func %s#%d\n",
>  				base_type(ret_type), func_id_name(func_id),
>  				func_id);
>  			return -EINVAL;
>  		}
> -		/* current BPF helper definitions are only coming from
> -		 * built-in code with type IDs from  vmlinux BTF
> -		 */
> -		regs[BPF_REG_0].btf = btf_vmlinux;
> +		regs[BPF_REG_0].btf = ret_btf;
>  		regs[BPF_REG_0].btf_id = ret_btf_id;
>  	} else {
>  		verbose(env, "unknown return type %u of func %s#%d\n",
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 99fab54ae9c0..d45568746e79 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5129,6 +5129,17 @@ union bpf_attr {
>   *		The **hash_algo** is returned on success,
>   *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
>   *		invalid arguments are passed.
> + *
> + * void *bpf_kptr_xchg(void *map_value, void *ptr)
> + *	Description
> + *		Exchange kptr at pointer *map_value* with *ptr*, and return the
> + *		old value. *ptr* can be NULL, otherwise it must be a referenced
> + *		pointer which will be released when this helper is called.
> + *	Return
> + *		The old value of kptr (which can be NULL). The returned pointer
> + *		if not NULL, is a reference which must be released using its
> + *		corresponding release function, or moved into a BPF map before
> + *		program exit.
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -5325,6 +5336,7 @@ union bpf_attr {
>  	FN(copy_from_user_task),	\
>  	FN(skb_set_tstamp),		\
>  	FN(ima_file_hash),		\
> +	FN(kptr_xchg),			\
>  	/* */
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> -- 
> 2.35.1
> 

-- 
