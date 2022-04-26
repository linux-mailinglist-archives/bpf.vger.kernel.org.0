Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7D550EF94
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 06:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbiDZEMD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 00:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbiDZEMC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 00:12:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C05417AA6;
        Mon, 25 Apr 2022 21:08:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id iq10so3763865pjb.0;
        Mon, 25 Apr 2022 21:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BmVF4EXcjcUNSi3DVcK9Nx6B3mnEaB3077X7MMFsCH0=;
        b=eY/v11/AzoUnmAE005pzA2+P2TPM4js1nQPVJGszMkmoo4LNR9A2TammgELKTEZVT4
         ALbCgTcTO1eTzNR0ztXNR85NtRWYDILNg0usTLT/o1PmmZdpURD8lYkebQJKQnb/0+W6
         aCEVygfzejrLQGYbcao+E+yWffYpYfElzW3D2vJ8ve/rEmMKbOcxtH2AwWjTWjSXVBpu
         SNDpIzKetnvROnk5Pq2WuGGXiajg5VuiRoMQH+CWtML90BZZJgmrAiJElbuP66KlxHVZ
         j819XajsW1T5gJ2xMWJWfMTqZwpOmoIBSc4t2XVWn9qKM5LytfggJ82rNyKcXR7ZLGdq
         /40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BmVF4EXcjcUNSi3DVcK9Nx6B3mnEaB3077X7MMFsCH0=;
        b=fx3Pk5iK7ls/d/YVp+wIfr06D8BWqGP1feJbVgFK50QpUFKJPhKzJAv1Fy/5z0JWmY
         Y5X9xqvCUsVzLcsj03W/5eOHCt4T8BbRDWHo7F21/hQniKyX6alZlAwBfv6QakoW3RVj
         E8Lwfga3Q+/iKEfMplc5c90S78liQWa4wi7GSgjoXvBQeD1Dx+fMRxrTddN+q4OONber
         nv4v8Oa1iMZwjKg75JEO30vfub92RPQOpgMRw2xFG1KEDiRO20RgEqNn76ZUbwskGVgx
         SUh41crdYKLwEyvMtq7Dy9TY36AX+vH4A4uEkaUNwFCpA2nf5L+T5Yq3S83xpnwrVe/a
         RZQw==
X-Gm-Message-State: AOAM530/c2AfQOH7kKV85vCNk7Y0IhGhg6OPEl7EC2eW4koN4ksVms20
        OWcsUykjdPpqwo/JFy2k1Qc=
X-Google-Smtp-Source: ABdhPJziWPZHyo1se5MZFri6fbpoteACq47aWljWlxBdHHwNQ27+HiAWveJKeYQmtyXaSVSgY82L3g==
X-Received: by 2002:a17:90a:aa8b:b0:1d9:868c:b4c5 with SMTP id l11-20020a17090aaa8b00b001d9868cb4c5mr6831705pjq.198.1650946134905;
        Mon, 25 Apr 2022 21:08:54 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:438a])
        by smtp.gmail.com with ESMTPSA id s4-20020a056a00194400b004fb358ffe84sm13128030pfk.104.2022.04.25.21.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 21:08:54 -0700 (PDT)
Date:   Mon, 25 Apr 2022 21:08:51 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [RFC bpf-next v4 2/7] bpf/verifier: allow kfunc to return an
 allocated mem
Message-ID: <20220426040851.q3ovelrlcldvwhv5@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220421140740.459558-3-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421140740.459558-3-benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 04:07:35PM +0200, Benjamin Tissoires wrote:
> When a kfunc is not returning a pointer to a struct but to a plain type,
> check if one of the arguments is called __sz and is a const from the
> caller, and use this as the size of the allocated memory.
> 
> For tracing programs, we consider the provided memory to be read only
> unless the program is BPF_MODIFY_RETURN.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> new in v4
> ---
>  include/linux/btf.h   |  6 ++++
>  kernel/bpf/btf.c      | 31 ++++++++++++++++----
>  kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++----------
>  3 files changed, 83 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 36bc09b8e890..76a3ff48ae2a 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -332,6 +332,12 @@ static inline struct btf_param *btf_params(const struct btf_type *t)
>  	return (struct btf_param *)(t + 1);
>  }
>  
> +struct bpf_reg_state;
> +
> +bool btf_is_kfunc_arg_mem_size(const struct btf *btf,
> +			       const struct btf_param *arg,
> +			       const struct bpf_reg_state *reg);
> +
>  #ifdef CONFIG_BPF_SYSCALL
>  struct bpf_prog;
>  
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 76318a4c2d0e..22e6e3cdc7ee 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5851,9 +5851,9 @@ static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
>  	return true;
>  }
>  
> -static bool is_kfunc_arg_mem_size(const struct btf *btf,
> -				  const struct btf_param *arg,
> -				  const struct bpf_reg_state *reg)
> +bool btf_is_kfunc_arg_mem_size(const struct btf *btf,
> +			       const struct btf_param *arg,
> +			       const struct bpf_reg_state *reg)
>  {
>  	int len, sfx_len = sizeof("__sz") - 1;
>  	const struct btf_type *t;
> @@ -5976,7 +5976,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  				reg_btf = reg->btf;
>  				reg_ref_id = reg->btf_id;
>  				/* Ensure only one argument is referenced
> -				 * PTR_TO_BTF_ID, check_func_arg_reg_off relies
> +				 * PTR_TO_BTF_ID or PTR_TO_MEM, check_func_arg_reg_off relies
>  				 * on only one referenced register being allowed
>  				 * for kfuncs.
>  				 */
> @@ -6012,7 +6012,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  			u32 type_size;
>  
>  			if (is_kfunc) {
> -				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> +				bool arg_mem_size = i + 1 < nargs &&
> +						    btf_is_kfunc_arg_mem_size(btf,
> +									      &args[i + 1],
> +									      &regs[regno + 1]);

bpf allows ~100 chars. No need to break the line so much.

>  
>  				/* Permit pointer to mem, but only when argument
>  				 * type is pointer to scalar, or struct composed
> @@ -6039,6 +6042,24 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  					i++;
>  					continue;
>  				}
> +
> +				if (rel && reg->ref_obj_id) {
> +					/* Ensure only one argument is referenced
> +					 * PTR_TO_BTF_ID or PTR_TO_MEM, check_func_arg_reg_off
> +					 * relies on only one referenced register being allowed
> +					 * for kfuncs.
> +					 */
> +					if (ref_obj_id) {
> +						bpf_log(log,
> +							"verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> +							regno,
> +							reg->ref_obj_id,
> +							ref_obj_id);
> +						return -EFAULT;
> +					}
> +					ref_regno = regno;
> +					ref_obj_id = reg->ref_obj_id;
> +				}
>  			}
>  
>  			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 71827d14724a..0f339f9058f3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6974,7 +6974,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	int err, insn_idx = *insn_idx_p;
>  	const struct btf_param *args;
>  	struct btf *desc_btf;
> +	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>  	bool acq;
> +	size_t reg_size = 0;
>  
>  	/* skip for now, but return error when we find this in fixup_kfunc_call */
>  	if (!insn->imm)
> @@ -7015,8 +7017,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		}
>  	}
>  
> -	for (i = 0; i < CALLER_SAVED_REGS; i++)
> -		mark_reg_not_init(env, regs, caller_saved[i]);
> +	/* reset REG_0 */
> +	mark_reg_not_init(env, regs, BPF_REG_0);
>  
>  	/* Check return type */
>  	t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
> @@ -7026,6 +7028,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		return -EINVAL;
>  	}
>  
> +	nargs = btf_type_vlen(func_proto);
> +	args = btf_params(func_proto);
> +
>  	if (btf_type_is_scalar(t)) {
>  		mark_reg_unknown(env, regs, BPF_REG_0);
>  		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
> @@ -7033,24 +7038,54 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		ptr_type = btf_type_skip_modifiers(desc_btf, t->type,
>  						   &ptr_type_id);
>  		if (!btf_type_is_struct(ptr_type)) {
> -			ptr_type_name = btf_name_by_offset(desc_btf,
> -							   ptr_type->name_off);
> -			verbose(env, "kernel function %s returns pointer type %s %s is not supported\n",
> -				func_name, btf_type_str(ptr_type),
> -				ptr_type_name);
> -			return -EINVAL;
> +			/* if we have an array, we must have a const argument named "__sz" */
> +			for (i = 0; i < nargs; i++) {
> +				u32 regno = i + BPF_REG_1;
> +				struct bpf_reg_state *reg = &regs[regno];
> +
> +				/* look for any const scalar parameter of name "__sz" */
> +				if (!check_reg_arg(env, regno, SRC_OP) &&
> +				    tnum_is_const(regs[regno].var_off) &&
> +				    btf_is_kfunc_arg_mem_size(desc_btf, &args[i], reg))
> +					reg_size = regs[regno].var_off.value;
> +			}
> +
> +			if (!reg_size) {
> +				ptr_type_name = btf_name_by_offset(desc_btf,
> +								   ptr_type->name_off);
> +				verbose(env,
> +					"kernel function %s returns pointer type %s %s is not supported\n",
> +					func_name,
> +					btf_type_str(ptr_type),
> +					ptr_type_name);
> +				return -EINVAL;
> +			}
> +
> +			mark_reg_known_zero(env, regs, BPF_REG_0);
> +			regs[BPF_REG_0].type = PTR_TO_MEM;
> +			regs[BPF_REG_0].mem_size = reg_size;
> +
> +			/* in case of tracing, only allow write access to
> +			 * BPF_MODIFY_RETURN programs
> +			 */
> +			if (prog_type == BPF_PROG_TYPE_TRACING &&
> +			    env->prog->expected_attach_type != BPF_MODIFY_RETURN)
> +				regs[BPF_REG_0].type |= MEM_RDONLY;

MOD_RET restriction looks artificial.
We can distinguish readonly vs writeable PTR_TO_MEM based on
another naming convention.
Currently arg_name__sz applies to the previous argument.
Matching suffix made sense there.
Reusing the same suffix matching for a different purpose could be confusing.
For this use case we may reserve a full argument name.
Like "rdonly_buf_size" and "rdwr_buf_size" ?
