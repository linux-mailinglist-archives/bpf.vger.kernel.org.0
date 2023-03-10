Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A56B5172
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 21:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjCJUIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 15:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjCJUII (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 15:08:08 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE37212970B
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 12:07:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y11so6855232plg.1
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 12:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678478869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r13f+saYrzI5jRoWWboWqUFQ5pUfPMtBVCljrkRZ02I=;
        b=IGU74J2t0o/ohUbTNt8VhgfYH6nKCKHaSe5uC+sxwBZALooWLFuSCM/1OgFbbkIMOa
         2/5oQywTQl66N3mL/Zh4vgcHJZ3v5QAU5GvKw1pzK2ftxpn7u7DCmXzmW7O0yawcla2l
         Avr3QRG9QhLVK6Toc6YHIUY4cYHm/n0ql9OSYicIRrnG6bV/ZSjcljMpDWduyNi/JTCU
         nXKyNsk5WEbU3SS1grV0bg+XhMPk24LBgFx7ZRRYQi+3MX2I5vhbP8ltYIws3nWJtVJ7
         pYOir9Fj+0UW1/c0uS826fcGh77ujTMEjMt0qZ11v3YH0v2mkqNeTg1LXjWwLvOyOGGe
         xcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678478869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r13f+saYrzI5jRoWWboWqUFQ5pUfPMtBVCljrkRZ02I=;
        b=ZwEuF3aLEoZETLyIPjKgNv7LI90I79+1cpzu8X7LYGrxLU4S/sYqllRIrBjmvFnlnS
         zLtzaqD52KblVPlF0K3oO97lqzW82+AKB6emsBxvMCleW9lIaqQ4Gk093Ls4MJS/DEqA
         qbISK9+D2xpy5uYbiKzLiFsZ2YYfNrYr1xHQKinPlTnz/MuqdklzBjezOEj/nCoxCjWs
         8N9D7AaLnoQLZTSIoMzhQQtlgYHWdfb/xvKKUrEmNreU9xVOy8DhiskCXQtz23+vZf0f
         eVRu5VTZJS5Xl7e+P7c9z9aYs1xoUTRdzFAaJzQCooArSykzrtxOzf2rZ3DVfMW9LIQb
         bTIQ==
X-Gm-Message-State: AO0yUKXIi3AgI/svzk1ipRi6RP8Lywh9ynbAnfT2mYyyJOCyFgBLA+jO
        k9k6x05VeD6mg+3Bty8nhBQ=
X-Google-Smtp-Source: AK7set8edgLq2Jz/H4C3Y7vmf5YiJSwDSXTobjlgWISozI6aDc8Id4F65rKvf2oe5pKBkccDHhoTew==
X-Received: by 2002:a17:902:ec81:b0:19c:f888:ad52 with SMTP id x1-20020a170902ec8100b0019cf888ad52mr33391150plg.49.1678478869159;
        Fri, 10 Mar 2023 12:07:49 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:5c0c])
        by smtp.gmail.com with ESMTPSA id km13-20020a17090327cd00b00194c2f78581sm358081plb.199.2023.03.10.12.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:07:48 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:07:45 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, tj@kernel.org
Subject: Re: [PATCH v1 bpf-next 4/6] bpf: Support __kptr to local kptrs
Message-ID: <20230310200745.v6vr2e4peg6wxtt5@macbook-pro-6.dhcp.thefacebook.com>
References: <20230309180111.1618459-1-davemarchevsky@fb.com>
 <20230309180111.1618459-5-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309180111.1618459-5-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 09, 2023 at 10:01:09AM -0800, Dave Marchevsky wrote:
> If a PTR_TO_BTF_ID type comes from program BTF - not vmlinux or module
> BTF - it must have been allocated by bpf_obj_new and therefore must be
> free'd with bpf_obj_drop. Such a PTR_TO_BTF_ID is considered a "local
> kptr" and is tagged with MEM_ALLOC type tag by bpf_obj_new.
> 
> This patch adds support for treating __kptr-tagged pointers to "local
> kptrs" as having an implicit bpf_obj_drop destructor for referenced kptr
> acquire / release semantics. Consider the following example:
> 
>   struct node_data {
>           long key;
>           long data;
>           struct bpf_rb_node node;
>   };
> 
>   struct map_value {
>           struct node_data __kptr *node;
>   };
> 
>   struct {
>           __uint(type, BPF_MAP_TYPE_ARRAY);
>           __type(key, int);
>           __type(value, struct map_value);
>           __uint(max_entries, 1);
>   } some_nodes SEC(".maps");
> 
> If struct node_data had a matching definition in kernel BTF, the verifier would
> expect a destructor for the type to be registered. Since struct node_data does
> not match any type in kernel BTF, the verifier knows that there is no kfunc
> that provides a PTR_TO_BTF_ID to this type, and that such a PTR_TO_BTF_ID can
> only come from bpf_obj_new. So instead of searching for a registered dtor,
> a bpf_obj_drop dtor can be assumed.
> 
> This allows the runtime to properly destruct such kptrs in
> bpf_obj_free_fields, which enables maps to clean up map_vals w/ such
> kptrs when going away.
> 
> Implementation notes:
>   * "kernel_btf" variable is renamed to "kptr_btf" in btf_parse_kptr.
>     Before this patch, the variable would only ever point to vmlinux or
>     module BTFs, but now it can point to some program BTF for local kptr
>     type. It's later used to populate the (btf, btf_id) pair in kptr btf
>     field.
>   * It's necessary to btf_get the program BTF when populating btf_field
>     for local kptr. btf_record_free later does a btf_put.
>   * Behavior for non-local referenced kptrs is not modified, as
>     bpf_find_btf_id helper only searches vmlinux and module BTFs for
>     matching BTF type. If such a type is found, btf_field_kptr's btf will
>     pass btf_is_kernel check, and the associated release function is
>     some one-argument dtor. If btf_is_kernel check fails, associated
>     release function is two-arg bpf_obj_drop_impl. Before this patch
>     only btf_field_kptr's w/ kernel or module BTFs were created.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/bpf.h  | 11 ++++++++++-
>  include/linux/btf.h  |  2 --
>  kernel/bpf/btf.c     | 34 +++++++++++++++++++++++++---------
>  kernel/bpf/helpers.c | 11 ++++++++---
>  kernel/bpf/syscall.c | 14 +++++++++++++-
>  5 files changed, 56 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3a38db315f7f..756b85f0d0d3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -189,10 +189,19 @@ enum btf_field_type {
>  				 BPF_RB_NODE | BPF_RB_ROOT,
>  };
>  
> +typedef void (*btf_dtor_kfunc_t)(void *);
> +typedef void (*btf_dtor_obj_drop)(void *, const struct btf_record *);
> +
>  struct btf_field_kptr {
>  	struct btf *btf;
>  	struct module *module;
> -	btf_dtor_kfunc_t dtor;
> +	union {
> +		/* dtor used if btf_is_kernel(btf), otherwise the type
> +		 * is program-allocated and obj_drop is used
> +		 */
> +		btf_dtor_kfunc_t dtor;
> +		btf_dtor_obj_drop obj_drop;
> +	};
>  	u32 btf_id;
>  };
>  
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 1bba0827e8c4..d53b10cc55f2 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -121,8 +121,6 @@ struct btf_struct_metas {
>  	struct btf_struct_meta types[];
>  };
>  
> -typedef void (*btf_dtor_kfunc_t)(void *);
> -
>  extern const struct file_operations btf_fops;
>  
>  void btf_get(struct btf *btf);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 37779ceefd09..165a8ef038f5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3551,12 +3551,17 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
>  	return -EINVAL;
>  }
>  
> +extern void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
> +
>  static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
>  			  struct btf_field_info *info)
>  {
>  	struct module *mod = NULL;
>  	const struct btf_type *t;
> -	struct btf *kernel_btf;
> +	/* If a matching btf type is found in kernel or module BTFs, kptr_ref
> +	 * is that BTF, otherwise it's program BTF
> +	 */
> +	struct btf *kptr_btf;
>  	int ret;
>  	s32 id;
>  
> @@ -3565,7 +3570,17 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
>  	 */
>  	t = btf_type_by_id(btf, info->kptr.type_id);
>  	id = bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO_KIND(t->info),
> -			     &kernel_btf);
> +			     &kptr_btf);
> +	if (id == -ENOENT && !btf_is_kernel(btf)) {

btf_is_kernel(btf) is confusing.
btf_parse()->btf_parse_struct_metas()->btf_parse_fields() is only called for user loaded BTFs.
We can do WARN_ON_ONCE(btf_is_kernel(btf)); here as a way to document it,
but checking it looks wrong.

> +		/* Type exists only in program BTF. Assume that it's a MEM_ALLOC
> +		 * kptr allocated via bpf_obj_new
> +		 */
> +		field->kptr.dtor = (void *)&__bpf_obj_drop_impl;
> +		id = info->kptr.type_id;
> +		kptr_btf = (struct btf *)btf;
> +		btf_get(kptr_btf);
> +		goto found_dtor;
> +	}
>  	if (id < 0)
>  		return id;
>  
> @@ -3582,20 +3597,20 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
>  		 * can be used as a referenced pointer and be stored in a map at
>  		 * the same time.
>  		 */
> -		dtor_btf_id = btf_find_dtor_kfunc(kernel_btf, id);
> +		dtor_btf_id = btf_find_dtor_kfunc(kptr_btf, id);
>  		if (dtor_btf_id < 0) {
>  			ret = dtor_btf_id;
>  			goto end_btf;
>  		}
>  
> -		dtor_func = btf_type_by_id(kernel_btf, dtor_btf_id);
> +		dtor_func = btf_type_by_id(kptr_btf, dtor_btf_id);
>  		if (!dtor_func) {
>  			ret = -ENOENT;
>  			goto end_btf;
>  		}
>  
> -		if (btf_is_module(kernel_btf)) {
> -			mod = btf_try_get_module(kernel_btf);
> +		if (btf_is_module(kptr_btf)) {
> +			mod = btf_try_get_module(kptr_btf);
>  			if (!mod) {
>  				ret = -ENXIO;
>  				goto end_btf;
> @@ -3605,7 +3620,7 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
>  		/* We already verified dtor_func to be btf_type_is_func
>  		 * in register_btf_id_dtor_kfuncs.
>  		 */
> -		dtor_func_name = __btf_name_by_offset(kernel_btf, dtor_func->name_off);
> +		dtor_func_name = __btf_name_by_offset(kptr_btf, dtor_func->name_off);
>  		addr = kallsyms_lookup_name(dtor_func_name);
>  		if (!addr) {
>  			ret = -EINVAL;
> @@ -3614,14 +3629,15 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
>  		field->kptr.dtor = (void *)addr;
>  	}
>  
> +found_dtor:
>  	field->kptr.btf_id = id;
> -	field->kptr.btf = kernel_btf;
> +	field->kptr.btf = kptr_btf;
>  	field->kptr.module = mod;
>  	return 0;
>  end_mod:
>  	module_put(mod);
>  end_btf:
> -	btf_put(kernel_btf);
> +	btf_put(kptr_btf);
>  	return ret;
>  }
>  
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index f9b7eeedce08..77d64b6951b9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1896,14 +1896,19 @@ __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
>  	return p;
>  }
>  
> +void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
> +{
> +	if (rec)
> +		bpf_obj_free_fields(rec, p);
> +	bpf_mem_free(&bpf_global_ma, p);
> +}
> +
>  __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
>  {
>  	struct btf_struct_meta *meta = meta__ign;
>  	void *p = p__alloc;
>  
> -	if (meta)
> -		bpf_obj_free_fields(meta->record, p);
> -	bpf_mem_free(&bpf_global_ma, p);
> +	__bpf_obj_drop_impl(p, meta ? meta->record : NULL);
>  }
>  
>  static void __bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *head, bool tail)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index cc4b7684910c..0684febc447a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -659,8 +659,10 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  		return;
>  	fields = rec->fields;
>  	for (i = 0; i < rec->cnt; i++) {
> +		struct btf_struct_meta *pointee_struct_meta;
>  		const struct btf_field *field = &fields[i];
>  		void *field_ptr = obj + field->offset;
> +		void *xchgd_field;
>  
>  		switch (fields[i].type) {
>  		case BPF_SPIN_LOCK:
> @@ -672,7 +674,17 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  			WRITE_ONCE(*(u64 *)field_ptr, 0);
>  			break;
>  		case BPF_KPTR_REF:
> -			field->kptr.dtor((void *)xchg((unsigned long *)field_ptr, 0));
> +			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
> +			if (!btf_is_kernel(field->kptr.btf)) {
> +				pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
> +									   field->kptr.btf_id);
> +				WARN_ON_ONCE(!pointee_struct_meta);
> +				field->kptr.obj_drop(xchgd_field, pointee_struct_meta ?
> +								  pointee_struct_meta->record :
> +								  NULL);
> +			} else {
> +				field->kptr.dtor(xchgd_field);
> +			}
>  			break;
>  		case BPF_LIST_HEAD:
>  			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
> -- 
> 2.34.1
> 
