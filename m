Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D42F6315A6
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 19:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKTSda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 13:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKTSd3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 13:33:29 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A474E2188F
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:33:28 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id v28so9416902pfi.12
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=74lKyUh1yWKCd3IFpiZKNkWwwXTf/DwYeN5IOyQLyHg=;
        b=ShvorL5/HPB9M7x0ftEVFi28RF6sTvGRI7CypP0jo3gl4t7EcVPwrsotH3chW7Zogt
         /bso3C5ZBe+qkRvFtJd0VTu9+cfpP6qm/7uk69+k1WRuQttF2oUnTONGa2Ejoo5AVhoi
         ygMqWIt6RCXcrAr3f3x6jMd8YNdgPsQaDTdsIT5D/qQI5AxaZkX10gG9g6WWViUhkekc
         09VMZGYMIEMc3detHxFR3VuxTyFbZuUHpZJJRAFC7OlMBV2haEKsCFEFZ6TnuUxTMSp1
         vlm8WW/F5cNz2Ayxt9MlWc36ddDqeg9uv9qfDgRbjZLIwwYStdPLBH+nWqW95Tk6jiiQ
         BSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74lKyUh1yWKCd3IFpiZKNkWwwXTf/DwYeN5IOyQLyHg=;
        b=C0aPUpWq4Tg9o/YUgvihA34H+qIW/1RHqCuGVEYGygmuoIjLTjqKtVq5EuH1XF9UQm
         A7LDrDwyJ7vYvJVlIYcv2Gs7S1LmyZKBeVZhBbClfEKOBNT7yt+4Bpza/LW+byBW+NFA
         TeUCoAsclWUBrx49FU4hHZZtbnHQ167Uf3q+NBTBh7Hc5ykY/qv5bwYDuwNaH7kJqcmu
         g4Q+taPYeO6rm7gPU/fhgZNvGsI/TAQdpjs167tgfXfEmBiAlgldivknoHcKvuD1G1oG
         BU4Zd2sBUho4QfnGJ3Fb3cZVKK0dk88dgUvzpPJeLd4tkfZepTNWEUVm0P4qoQ3Y8Cny
         2Wfg==
X-Gm-Message-State: ANoB5pk4YdJKxDGpiu+XILFbRiRbqWcN3vloQAtPBUtFpykd4zq3Iug5
        9DKGELZ7xU5O+h55i+Qe32Y=
X-Google-Smtp-Source: AA0mqf4iMxEnWfRm4S5Izxh/lPTd9SSAim4McQ3cpfvoHcuf4KPWuC9R2NKGqS7b3z/CcJe5crxBhA==
X-Received: by 2002:a62:1b0b:0:b0:56d:384:e13a with SMTP id b11-20020a621b0b000000b0056d0384e13amr16960899pfb.75.1668969207847;
        Sun, 20 Nov 2022 10:33:27 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:7165])
        by smtp.gmail.com with ESMTPSA id z24-20020a62d118000000b0056cd54ac8a0sm6887795pfg.197.2022.11.20.10.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 10:33:27 -0800 (PST)
Date:   Sun, 20 Nov 2022 10:33:24 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Add a kfunc to type cast from bpf
 uapi ctx to kernel ctx
Message-ID: <20221120183324.vlgassj34isouosg@macbook-pro-5.dhcp.thefacebook.com>
References: <20221120161511.831691-1-yhs@fb.com>
 <20221120161522.833411-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120161522.833411-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 20, 2022 at 08:15:22AM -0800, Yonghong Song wrote:
> Implement bpf_cast_to_kern_ctx() kfunc which does a type cast
> of a uapi ctx object to the corresponding kernel ctx. Previously
> if users want to access some data available in kctx but not
> in uapi ctx, bpf_probe_read_kernel() helper is needed.
> The introduction of bpf_cast_to_kern_ctx() allows direct
> memory access which makes code simpler and easier to understand.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/btf.h   |  5 +++++
>  kernel/bpf/btf.c      | 25 +++++++++++++++++++++++++
>  kernel/bpf/helpers.c  |  6 ++++++
>  kernel/bpf/verifier.c | 21 +++++++++++++++++++++
>  4 files changed, 57 insertions(+)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index d5b26380a60f..4b5d799f5d02 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -470,6 +470,7 @@ const struct btf_member *
>  btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>  		      const struct btf_type *t, enum bpf_prog_type prog_type,
>  		      int arg);
> +int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
>  bool btf_types_are_same(const struct btf *btf1, u32 id1,
>  			const struct btf *btf2, u32 id2);
>  #else
> @@ -514,6 +515,10 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>  {
>  	return NULL;
>  }
> +static inline int get_kern_ctx_btf_id(struct bpf_verifier_log *log,
> +				      enum bpf_prog_type prog_type) {
> +	return -EINVAL;
> +}
>  static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
>  				      const struct btf *btf2, u32 id2)
>  {
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0a3abbe56c5d..bef1b6cfe6b8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5603,6 +5603,31 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
>  	return kern_ctx_type->type;
>  }
>  
> +int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type)
> +{
> +	const struct btf_member *kctx_member;
> +	const struct btf_type *conv_struct;
> +	const struct btf_type *kctx_type;
> +	u32 kctx_type_id;
> +
> +	conv_struct = bpf_ctx_convert.t;
> +	if (!conv_struct) {
> +		bpf_log(log, "btf_vmlinux is malformed\n");
> +		return -EINVAL;
> +	}

If we get to this point this internal pointer would be already checked.
No need to check it again. Just use it.

> +
> +	/* get member for kernel ctx type */
> +	kctx_member = btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_type] * 2 + 1;
> +	kctx_type_id = kctx_member->type;
> +	kctx_type = btf_type_by_id(btf_vmlinux, kctx_type_id);
> +	if (!btf_type_is_struct(kctx_type)) {
> +		bpf_log(log, "kern ctx type id %u is not a struct\n", kctx_type_id);
> +		return -EINVAL;
> +	}
> +
> +	return kctx_type_id;
> +}
> +
>  BTF_ID_LIST(bpf_ctx_convert_btf_id)
>  BTF_ID(struct, bpf_ctx_convert)
>  
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index eaae7f474eda..dc6e994feeb9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1824,6 +1824,11 @@ struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
>  	return __bpf_list_del(head, true);
>  }
>  
> +void *bpf_cast_to_kern_ctx(void *obj)
> +{
> +	return obj;
> +}
> +
>  __diag_pop();
>  
>  BTF_SET8_START(generic_btf_ids)
> @@ -1844,6 +1849,7 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
>  };
>  
>  BTF_SET8_START(common_btf_ids)
> +BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
>  BTF_SET8_END(common_btf_ids)
>  
>  static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 195d24316750..a18b519c5225 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8118,6 +8118,7 @@ enum special_kfunc_type {
>  	KF_bpf_list_push_back,
>  	KF_bpf_list_pop_front,
>  	KF_bpf_list_pop_back,
> +	KF_bpf_cast_to_kern_ctx,
>  };
>  
>  BTF_SET_START(special_kfunc_set)
> @@ -8127,6 +8128,7 @@ BTF_ID(func, bpf_list_push_front)
>  BTF_ID(func, bpf_list_push_back)
>  BTF_ID(func, bpf_list_pop_front)
>  BTF_ID(func, bpf_list_pop_back)
> +BTF_ID(func, bpf_cast_to_kern_ctx)
>  BTF_SET_END(special_kfunc_set)
>  
>  BTF_ID_LIST(special_kfunc_list)
> @@ -8136,6 +8138,7 @@ BTF_ID(func, bpf_list_push_front)
>  BTF_ID(func, bpf_list_push_back)
>  BTF_ID(func, bpf_list_pop_front)
>  BTF_ID(func, bpf_list_pop_back)
> +BTF_ID(func, bpf_cast_to_kern_ctx)
>  
>  static enum kfunc_ptr_arg_type
>  get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
> @@ -8149,6 +8152,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  	struct bpf_reg_state *reg = &regs[regno];
>  	bool arg_mem_size = false;
>  
> +	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
> +		return KF_ARG_PTR_TO_CTX;
> +
>  	/* In this function, we verify the kfunc's BTF as per the argument type,
>  	 * leaving the rest of the verification with respect to the register
>  	 * type to our caller. When a set of conditions hold in the BTF type of
> @@ -8633,6 +8639,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  				verbose(env, "arg#%d expected pointer to ctx, but got %s\n", i, btf_type_str(t));
>  				return -EINVAL;
>  			}
> +
> +			if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
> +				ret = get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog));
> +				if (ret < 0)
> +					return -EINVAL;
> +				meta->arg_constant.value = ret;

It's not an arg. So 'arg_constant' doesn't fit.
No need to save every byte in bpf_kfunc_call_arg_meta.
Let's add new filed like 'ret_btf_id'.

> +			}
>  			break;
>  		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>  			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
> @@ -8880,6 +8893,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				regs[BPF_REG_0].btf = field->list_head.btf;
>  				regs[BPF_REG_0].btf_id = field->list_head.value_btf_id;
>  				regs[BPF_REG_0].off = field->list_head.node_offset;
> +			} else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
> +				mark_reg_known_zero(env, regs, BPF_REG_0);
> +				regs[BPF_REG_0].type = PTR_TO_BTF_ID;

Let's use PTR_TO_BTF_ID | PTR_TRUSTED here.
PTR_TRUSTED was just recently added (hours ago :)
With that bpf_cast_to_kern_ctx() will return trusted pointer and we will be able
to pass it to kfuncs and helpers that expect valid args.

> +				regs[BPF_REG_0].btf = desc_btf;
> +				regs[BPF_REG_0].btf_id = meta.arg_constant.value;
>  			} else {
>  				verbose(env, "kernel function %s unhandled dynamic return type\n",
>  					meta.func_name);
> @@ -15130,6 +15148,9 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		insn_buf[1] = addr[1];
>  		insn_buf[2] = *insn;
>  		*cnt = 3;
> +	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
> +		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> +		*cnt = 1;

Nice! Important optimization.
I guess we still need:
 +void *bpf_cast_to_kern_ctx(void *obj)
 +{
 +     return obj;
 +}
otherwise resolve_btfids will be confused?
