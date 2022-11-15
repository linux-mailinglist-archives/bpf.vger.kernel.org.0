Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E6C629F96
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKOQva (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiKOQv3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:51:29 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF6DF83
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:51:28 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id v28so14621607pfi.12
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TxROK9895ZD3EboRYQ4AzHB4Y9AEC2hzY45wemJLSA8=;
        b=IN4F7LmBFd6WMwFn3CMpT3ynkRTdpE6lQRE8QihV6x00UQ83qTWhkNlk+1MOYJ8HCX
         Y9TBMu5FPXV2eJdhtDh3Obhv1pOJBTDp36U2qp3ky8n9Flb04HZa8sgiioierVL5YotY
         hZkVpWH0BAKxu5qAm8ZTF4szYa/5HxwSlLLA5jWUOKyOz5UA2bI9vMCZWVHEmg7nUF3C
         usxHbNgucluhiLSd5faIrvhH64hkJig+Ut3W11Z2EXv9NMR6ie2FqC5LR8YTs//RGH92
         gxtSqDj1WZtNtoyMZyU5JRzO6WjPIQABYq0DFZzM81NUd9L6DGy2ErnvPM4kWqNnfJzh
         FT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxROK9895ZD3EboRYQ4AzHB4Y9AEC2hzY45wemJLSA8=;
        b=Mu6KGMHdpjqstEhKcNW1ZeC+8wXWENphvSQDh5m59v+9JLsuEGSvvN0xXjdYNiP08e
         maZGwUQOEGhQN38mTY8RfQrlaAjlrxOIgYDtPB91LOC2HBnqYATbmO6kOLLuD9k4k8tt
         +OLbwHrkhpAAyYt/GCI5UNLREYw4vb0iYBZBSzq5cxFaPguVhIFqVDAmuoxuQAGNUAfp
         JMmkvDMiJWOpfwqKQ0RCtgjHu9MKQ3z95EkWaEMCqTPc/U3LOxbuR/ZKcpchgOkHacLI
         XSYM298MZwFG12PHiUNEPBTVlBYr3pt1I12KRRmzv29kjlzy/9EnGaHLDpu5h99t5RCC
         aMIw==
X-Gm-Message-State: ANoB5pm9Jld9pWobH8qgJtWf7WfbZR0YrILWHi8x6vtzcJVsmkfq1tjj
        i/UtTWv82o0NQA4tiJtm0Vc=
X-Google-Smtp-Source: AA0mqf7B3/KqQsNpDr7A244ydMpSqwImWi3C+VO4s8/LCxpSa5nSRml7QphByKjI4YKb6XgNqQNOdA==
X-Received: by 2002:a63:4a06:0:b0:434:bb42:b07d with SMTP id x6-20020a634a06000000b00434bb42b07dmr16610554pga.496.1668531087488;
        Tue, 15 Nov 2022 08:51:27 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id 23-20020a621417000000b00563ce1905f4sm9022255pfu.5.2022.11.15.08.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:51:27 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:21:22 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 14/26] bpf: Rewrite kfunc argument handling
Message-ID: <20221115165122.4qp7dn26notjekwt@apollo>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-15-memxor@gmail.com>
 <20221115061050.4f4i6dhqlfievr7p@macbook-pro-5.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115061050.4f4i6dhqlfievr7p@macbook-pro-5.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 11:40:50AM IST, Alexei Starovoitov wrote:
> On Tue, Nov 15, 2022 at 12:45:35AM +0530, Kumar Kartikeya Dwivedi wrote:
> > As we continue to add more features, argument types, kfunc flags, and
> > different extensions to kfuncs, the code to verify the correctness of
> > the kfunc prototype wrt the passed in registers has become ad-hoc and
> > ugly to read. To make life easier, and make a very clear split between
> > different stages of argument processing, move all the code into
> > verifier.c and refactor into easier to read helpers and functions.
> >
> > This also makes sharing code within the verifier easier with kfunc
> > argument processing. This will be more and more useful in later patches
> > as we are now moving to implement very core BPF helpers as kfuncs, to
> > keep them experimental before baking into UAPI.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> > [...]
> > +/* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
> > +static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
> > +					const struct btf *btf,
> > +					const struct btf_type *t, int rec)
> > +{
> > +	const struct btf_type *member_type;
> > +	const struct btf_member *member;
> > +	u32 i;
> > +
> > +	if (!btf_type_is_struct(t))
> > +		return false;
> > +
> > +	for_each_member(i, t, member) {
> > +		const struct btf_array *array;
> > +
> > +		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
> > +		if (btf_type_is_struct(member_type)) {
> > +			if (rec >= 3) {
> > +				verbose(env, "max struct nesting depth exceeded\n");
> > +				return false;
> > +			}
> > +			if (!__btf_type_is_scalar_struct(env, btf, member_type, rec + 1))
> > +				return false;
> > +			continue;
> > +		}
> > +		if (btf_type_is_array(member_type)) {
> > +			array = btf_array(member_type);
> > +			if (!array->nelems)
> > +				return false;
> > +			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
> > +			if (!btf_type_is_scalar(member_type))
> > +				return false;
> > +			continue;
> > +		}
> > +		if (!btf_type_is_scalar(member_type))
> > +			return false;
> > +	}
> > +	return true;
> > +}
>
> Deleting the code from the next patch can be combined with this patch,
> since it's a pure code move?
>
> Similar to few funcs that do pure code move... it's better to have them
> in a single patch.
>
> Not sure about 2 patch split strategy in general.
> Not clear whether it helps or hurts the code review.
>

No problem, I can squash both into a single patch.

> > +
> > +
> > +static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
> > +#ifdef CONFIG_NET
> > +	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> > +	[PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> > +	[PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
> > +#endif
> > +};
> > +
> > +enum kfunc_ptr_arg_type {
> > +	KF_ARG_PTR_TO_CTX,
> > +	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
>
> What does the STRONG suffix signify?
>
> PTR_TO_KPTR should always be safe.
> Just to make it different from ARG_PTR_TO_KPTR in kptr_xchg that
> has 'void *' arg and "auto converts" the type?
>

Yes.

> Here STRONG means that the type of the arg should match?

Yes.

>
> I think it's too verbose.
> Just KF_ARG_PTR_TO_KPTR would be clear enough.
> If we ever have another kptr_xchg that is done as kfunc
> we can add KF_ARG_PTR_TO_KPTR_AUTO or some other name that we can bikeshed later.
>

Ack, I'll drop the _STRONG suffix and simply call it ARG_PTR_TO_KPTR.

> > +	KF_ARG_PTR_TO_DYNPTR,
> > +	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
> > +	KF_ARG_PTR_TO_MEM,
> > +	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
> > +};
> > +
> > +static enum kfunc_ptr_arg_type
> > +get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
> > +		       struct bpf_kfunc_call_arg_meta *meta,
> > +		       const struct btf_type *t, const struct btf_type *ref_t,
> > +		       const char *ref_tname, const struct btf_param *args,
> > +		       int argno, int nargs)
> > +{
> > +	u32 regno = argno + 1;
> > +	struct bpf_reg_state *regs = cur_regs(env);
> > +	struct bpf_reg_state *reg = &regs[regno];
> > +	bool arg_mem_size = false;
> > +
> > +	/* In this function, we verify the kfunc's BTF as per the argument type,
> > +	 * leaving the rest of the verification with respect to the register
> > +	 * type to our caller. When a set of conditions hold in the BTF type of
> > +	 * arguments, we resolve it to a known kfunc_ptr_arg_type.
> > +	 */
> > +	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
> > +		return KF_ARG_PTR_TO_CTX;
> > +
> > +	if (is_kfunc_arg_kptr_get(meta, argno)) {
> > +		if (!btf_type_is_ptr(ref_t)) {
> > +			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kfunc\n");
> > +			return -EINVAL;
> > +		}
> > +		ref_t = btf_type_by_id(meta->btf, ref_t->type);
> > +		ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
> > +		if (!btf_type_is_struct(ref_t)) {
> > +			verbose(env, "kernel function %s args#0 pointer type %s %s is not supported\n",
> > +				meta->func_name, btf_type_str(ref_t), ref_tname);
> > +			return -EINVAL;
> > +		}
> > +		return KF_ARG_PTR_TO_KPTR_STRONG;
> > +	}
> > +
> > +	if (is_kfunc_arg_dynptr(meta->btf, &args[argno]))
> > +		return KF_ARG_PTR_TO_DYNPTR;
> > +
> > +	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
> > +		if (!btf_type_is_struct(ref_t)) {
> > +			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
> > +				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
> > +			return -EINVAL;
> > +		}
> > +		return KF_ARG_PTR_TO_BTF_ID;
> > +	}
> > +
> > +	if (argno + 1 < nargs && is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]))
> > +		arg_mem_size = true;
> > +
> > +	/* This is the catch all argument type of register types supported by
> > +	 * check_helper_mem_access. However, we only allow when argument type is
> > +	 * pointer to scalar, or struct composed (recursively) of scalars. When
> > +	 * arg_mem_size is true, the pointer can be void *.
> > +	 */
> > +	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
> > +	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> > +		verbose(env, "arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
> > +			argno, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
> > +		return -EINVAL;
> > +	}
> > +	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
> > +}
> > +
> > +static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
> > +					struct bpf_reg_state *reg,
> > +					const struct btf_type *ref_t,
> > +					const char *ref_tname, u32 ref_id,
> > +					struct bpf_kfunc_call_arg_meta *meta,
> > +					int argno)
> > +{
> > +	const struct btf_type *reg_ref_t;
> > +	bool strict_type_match = false;
> > +	const struct btf *reg_btf;
> > +	const char *reg_ref_tname;
> > +	u32 reg_ref_id;
> > +
> > +	if (reg->type == PTR_TO_BTF_ID) {
> > +		reg_btf = reg->btf;
> > +		reg_ref_id = reg->btf_id;
> > +	} else {
> > +		reg_btf = btf_vmlinux;
> > +		reg_ref_id = *reg2btf_ids[base_type(reg->type)];
> > +	}
> > +
> > +	if (is_kfunc_trusted_args(meta) || (is_kfunc_release(meta) && reg->ref_obj_id))
> > +		strict_type_match = true;
> > +
> > +	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
> > +	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
> > +	if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match)) {
> > +		verbose(env, "kernel function %s args#%d expected pointer to %s %s but R%d has a pointer to %s %s\n",
> > +			meta->func_name, argno, btf_type_str(ref_t), ref_tname, argno + 1,
> > +			btf_type_str(reg_ref_t), reg_ref_tname);
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
> > +					     struct bpf_reg_state *reg,
> > +					     const struct btf_type *ref_t,
> > +					     const char *ref_tname,
> > +					     struct bpf_kfunc_call_arg_meta *meta,
> > +					     int argno)
> > +{
> > +	struct btf_field *kptr_field;
> > +
> > +	/* check_func_arg_reg_off allows var_off for
> > +	 * PTR_TO_MAP_VALUE, but we need fixed offset to find
> > +	 * off_desc.
> > +	 */
> > +	if (!tnum_is_const(reg->var_off)) {
> > +		verbose(env, "arg#0 must have constant offset\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	kptr_field = btf_record_find(reg->map_ptr->record, reg->off + reg->var_off.value, BPF_KPTR);
> > +	if (!kptr_field || kptr_field->type != BPF_KPTR_REF) {
> > +		verbose(env, "arg#0 no referenced kptr at map value offset=%llu\n",
> > +			reg->off + reg->var_off.value);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!btf_struct_ids_match(&env->log, meta->btf, ref_t->type, 0, kptr_field->kptr.btf,
> > +				  kptr_field->kptr.btf_id, true)) {
> > +		verbose(env, "kernel function %s args#%d expected pointer to %s %s\n",
> > +			meta->func_name, argno, btf_type_str(ref_t), ref_tname);
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
> > +{
> > +	const char *func_name = meta->func_name, *ref_tname;
> > +	const struct btf *btf = meta->btf;
> > +	const struct btf_param *args;
> > +	u32 i, nargs;
> > +	int ret;
> > +
> > +	args = (const struct btf_param *)(meta->func_proto + 1);
> > +	nargs = btf_type_vlen(meta->func_proto);
> > +	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> > +		verbose(env, "Function %s has %d > %d args\n", func_name, nargs,
> > +			MAX_BPF_FUNC_REG_ARGS);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Check that BTF function arguments match actual types that the
> > +	 * verifier sees.
> > +	 */
> > +	for (i = 0; i < nargs; i++) {
> > +		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
> > +		const struct btf_type *t, *ref_t, *resolve_ret;
> > +		enum bpf_arg_type arg_type = ARG_DONTCARE;
> > +		u32 regno = i + 1, ref_id, type_size;
> > +		bool is_ret_buf_sz = false;
> > +		int kf_arg_type;
> > +
> > +		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
> > +		if (btf_type_is_scalar(t)) {
> > +			if (reg->type != SCALAR_VALUE) {
> > +				verbose(env, "R%d is not a scalar\n", regno);
> > +				return -EINVAL;
> > +			}
> > +			if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdonly_buf_size")) {
> > +					meta->r0_rdonly = true;
> > +					is_ret_buf_sz = true;
> > +			} else if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdwr_buf_size")) {
> > +					is_ret_buf_sz = true;
> > +			}
>
> is_kfunc_arg_ret_buf_size() is more generic than its name says so.
> Maybe is_scalar_arg_with_name() ?
>

I named it is_kfunc_scalar_arg_with_name for consistency.

> Also looks wrong to triple check inside it:
>  +	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
>  +		return false;
> when there was a check above.
>

Right, this was in the original code that I copied over, but it's no longer
needed given where it's called now.
