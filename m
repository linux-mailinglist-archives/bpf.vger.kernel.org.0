Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7648A6AA087
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 21:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjCCUVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 15:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCCUVK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 15:21:10 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1875525BB3
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 12:21:09 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id cp12so2324866pfb.5
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 12:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6LR8zKVHdv39ciDrlWvZ6o/k9La77WgtVpTthe0OVw=;
        b=R5xsORYq/elfaj/4qjOHgzggOFs85hC1w/fiNQLIxpBers0FLQ8qZ8oaHFYxJpvLpc
         bXMj12UrxM0+bnZqXjfJgPKYPc1ukKYOrbriJOsIjOjTt64r4RHPHyAs2Ektw5lIE9pA
         hu+ZngPHFAg/z7TZCFxOTrLoq1aQlGKyDsKGWeelk1rvdngEYC/Z5NrpR8Jftvp0NNfy
         fZAZ+xXIlETeaHcKzAk1G525WT985Q0X8AEShwetfQWPPWyeSPgpRj0ZjvC21x6cvxs5
         /xBsaPXybzX4WMGOMb7gHwaZW4RZ8QiscA63t2VkFo+B4f4hpTLp1JmIDnziDThAnD40
         tnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6LR8zKVHdv39ciDrlWvZ6o/k9La77WgtVpTthe0OVw=;
        b=5kXtJODQlx5aUEWfYveL+oe1WUAddg0zEzTioTJZzEjkZsdEQf7nu9cXGxOjq80I0r
         /QIQh2qnspyPag7/yR346NJlPRx/jw3O6uVZYV0XHpsbKacJr8702qYeuMJoF1quP//2
         4kQGYdzru4dWxrRIAAC0NJ69r7ccBcTU6f51c7ft+lCp28G2oO/LpvIvDfvpSbS5/RTX
         VKHa2/PKlq5LRneaZXYhdAfxhj8Rhmtnr3onivut/hUAmwdcwXr5ttBJF4YOlQdVsm8m
         cjJALxrZ9W+3urhBrftS4RKSN9QcZuRgD1VB6QEKklPT3tvnYytVU2j1kKrufznISt3I
         UYqA==
X-Gm-Message-State: AO0yUKXSY24BvAh/s25XDJGKQyU1BIH3xJEXezO1jtLOwbd5G5yj29Wk
        xUpNPXRsriMGIHYkucuQ2n8=
X-Google-Smtp-Source: AK7set/OqJiR4hW2IvsPbJWjpLDTxuWMTUeffVMUbKKuM15PQjsNsqC2/idNWHIRMizAW6QYB1/AOg==
X-Received: by 2002:a62:3205:0:b0:5df:9809:2e95 with SMTP id y5-20020a623205000000b005df98092e95mr2993015pfy.11.1677874868377;
        Fri, 03 Mar 2023 12:21:08 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:c3d9])
        by smtp.gmail.com with ESMTPSA id h16-20020aa786d0000000b005921c46cbadsm2062166pfo.99.2023.03.03.12.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:21:07 -0800 (PST)
Date:   Fri, 3 Mar 2023 12:21:04 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com, jose.marchesi@oracle.com
Subject: Re: [PATCH bpf-next 1/3] bpf: allow ctx writes using BPF_ST_MEM
 instruction
Message-ID: <20230303202104.zoldj5z3m35ikkv2@MacBook-Pro-6.local>
References: <20230302225507.3413720-1-eddyz87@gmail.com>
 <20230302225507.3413720-2-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302225507.3413720-2-eddyz87@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 03, 2023 at 12:55:05AM +0200, Eduard Zingerman wrote:
> -			prev_src_type = &env->insn_aux_data[env->insn_idx].ptr_type;
> -
> -			if (*prev_src_type == NOT_INIT) {
> -				/* saw a valid insn
> -				 * dst_reg = *(u32 *)(src_reg + off)
> -				 * save type to validate intersecting paths
> -				 */
> -				*prev_src_type = src_reg_type;
> -
> -			} else if (reg_type_mismatch(src_reg_type, *prev_src_type)) {
> -				/* ABuser program is trying to use the same insn
> -				 * dst_reg = *(u32*) (src_reg + off)
> -				 * with different pointer types:
> -				 * src_reg == ctx in one branch and
> -				 * src_reg == stack|map in some other branch.
> -				 * Reject it.
> -				 */
> -				verbose(env, "same insn cannot be used with different pointers\n");
> -				return -EINVAL;

There is a merge conflict with this part.
LDX is now handled slightly differently comparing to STX.

> -			}
> -
> +			err = save_aux_ptr_type(env, src_reg_type);
> +			if (err)
> +				return err;
>  		} else if (class == BPF_STX) {
> -			enum bpf_reg_type *prev_dst_type, dst_reg_type;
> +			enum bpf_reg_type dst_reg_type;
>  
>  			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
>  				err = check_atomic(env, env->insn_idx, insn);
> @@ -14712,16 +14719,12 @@ static int do_check(struct bpf_verifier_env *env)
>  			if (err)
>  				return err;
>  
> -			prev_dst_type = &env->insn_aux_data[env->insn_idx].ptr_type;
> -
> -			if (*prev_dst_type == NOT_INIT) {
> -				*prev_dst_type = dst_reg_type;
> -			} else if (reg_type_mismatch(dst_reg_type, *prev_dst_type)) {
> -				verbose(env, "same insn cannot be used with different pointers\n");
> -				return -EINVAL;
> -			}
> -
> +			err = save_aux_ptr_type(env, dst_reg_type);
> +			if (err)
> +				return err;
>  		} else if (class == BPF_ST) {
> +			enum bpf_reg_type dst_reg_type;
> +
>  			if (BPF_MODE(insn->code) != BPF_MEM ||
>  			    insn->src_reg != BPF_REG_0) {
>  				verbose(env, "BPF_ST uses reserved fields\n");
> @@ -14732,12 +14735,7 @@ static int do_check(struct bpf_verifier_env *env)
>  			if (err)
>  				return err;
>  
> -			if (is_ctx_reg(env, insn->dst_reg)) {
> -				verbose(env, "BPF_ST stores into R%d %s is not allowed\n",
> -					insn->dst_reg,
> -					reg_type_str(env, reg_state(env, insn->dst_reg)->type));
> -				return -EACCES;
> -			}
> +			dst_reg_type = regs[insn->dst_reg].type;
>  
>  			/* check that memory (dst_reg + off) is writeable */
>  			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
> @@ -14746,6 +14744,9 @@ static int do_check(struct bpf_verifier_env *env)
>  			if (err)
>  				return err;
>  
> +			err = save_aux_ptr_type(env, dst_reg_type);
> +			if (err)
> +				return err;
>  		} else if (class == BPF_JMP || class == BPF_JMP32) {
>  			u8 opcode = BPF_OP(insn->code);
>  
> @@ -15871,7 +15872,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  			   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
>  			   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
>  			type = BPF_WRITE;
> -			ctx_access = BPF_CLASS(insn->code) == BPF_STX;
> +			ctx_access = true;

I think 'ctx_access' variable can be removed, since it will be always true.

>  		} else {
>  			continue;
>  		}
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1d6f165923bf..8e819b8464e8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9264,11 +9264,15 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
>  #endif
>  
>  	/* <store>: skb->tstamp = tstamp */
> -	*insn++ = BPF_STX_MEM(BPF_DW, skb_reg, value_reg,
> -			      offsetof(struct sk_buff, tstamp));
> +	*insn++ = BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_DW | BPF_MEM,
> +			       skb_reg, value_reg, offsetof(struct sk_buff, tstamp), si->imm);
>  	return insn;
>  }
>  
> +#define BPF_COPY_STORE(size, si, off)					\
> +	BPF_RAW_INSN((si)->code | (size) | BPF_MEM,			\
> +		     (si)->dst_reg, (si)->src_reg, (off), (si)->imm)
> +

Could you explain the "copy store" name?
I don't understand what it means.
It emits either STX or ST insn, right?
Maybe BPF_EMIT_STORE ?

>  static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>  				  const struct bpf_insn *si,
>  				  struct bpf_insn *insn_buf,
> @@ -9298,9 +9302,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>  
>  	case offsetof(struct __sk_buff, priority):
>  		if (type == BPF_WRITE)
> -			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
> -					      bpf_target_off(struct sk_buff, priority, 4,
> -							     target_size));
> +			*insn++ = BPF_COPY_STORE(BPF_W, si,
> +						 bpf_target_off(struct sk_buff, priority, 4,
> +								target_size));
>  		else
>  			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
>  					      bpf_target_off(struct sk_buff, priority, 4,
> @@ -9331,9 +9335,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>  
>  	case offsetof(struct __sk_buff, mark):
>  		if (type == BPF_WRITE)
> -			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
> -					      bpf_target_off(struct sk_buff, mark, 4,
> -							     target_size));
> +			*insn++ = BPF_COPY_STORE(BPF_W, si,
> +						 bpf_target_off(struct sk_buff, mark, 4,
> +								target_size));
>  		else
>  			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
>  					      bpf_target_off(struct sk_buff, mark, 4,
> @@ -9352,11 +9356,16 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>  
>  	case offsetof(struct __sk_buff, queue_mapping):
>  		if (type == BPF_WRITE) {
> -			*insn++ = BPF_JMP_IMM(BPF_JGE, si->src_reg, NO_QUEUE_MAPPING, 1);
> -			*insn++ = BPF_STX_MEM(BPF_H, si->dst_reg, si->src_reg,
> -					      bpf_target_off(struct sk_buff,
> -							     queue_mapping,
> -							     2, target_size));
> +			u32 off = bpf_target_off(struct sk_buff, queue_mapping, 2, target_size);
> +
> +			if (BPF_CLASS(si->code) == BPF_ST && si->imm >= NO_QUEUE_MAPPING) {
> +				*insn++ = BPF_JMP_A(0); /* noop */
> +				break;
> +			}
> +
> +			if (BPF_CLASS(si->code) == BPF_STX)
> +				*insn++ = BPF_JMP_IMM(BPF_JGE, si->src_reg, NO_QUEUE_MAPPING, 1);
> +			*insn++ = BPF_COPY_STORE(BPF_H, si, off);
>  		} else {
>  			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
>  					      bpf_target_off(struct sk_buff,
> @@ -9392,8 +9401,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>  		off += offsetof(struct sk_buff, cb);
>  		off += offsetof(struct qdisc_skb_cb, data);
>  		if (type == BPF_WRITE)
> -			*insn++ = BPF_STX_MEM(BPF_SIZE(si->code), si->dst_reg,
> -					      si->src_reg, off);
> +			*insn++ = BPF_COPY_STORE(BPF_SIZE(si->code), si, off);
>  		else
>  			*insn++ = BPF_LDX_MEM(BPF_SIZE(si->code), si->dst_reg,
>  					      si->src_reg, off);
> @@ -9408,8 +9416,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>  		off += offsetof(struct qdisc_skb_cb, tc_classid);
>  		*target_size = 2;
>  		if (type == BPF_WRITE)
> -			*insn++ = BPF_STX_MEM(BPF_H, si->dst_reg,
> -					      si->src_reg, off);
> +			*insn++ = BPF_COPY_STORE(BPF_H, si, off);
>  		else
>  			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg,
>  					      si->src_reg, off);
> @@ -9442,9 +9449,9 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>  	case offsetof(struct __sk_buff, tc_index):
>  #ifdef CONFIG_NET_SCHED
>  		if (type == BPF_WRITE)
> -			*insn++ = BPF_STX_MEM(BPF_H, si->dst_reg, si->src_reg,
> -					      bpf_target_off(struct sk_buff, tc_index, 2,
> -							     target_size));
> +			*insn++ = BPF_COPY_STORE(BPF_H, si,
> +						 bpf_target_off(struct sk_buff, tc_index, 2,
> +								target_size));
>  		else
>  			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
>  					      bpf_target_off(struct sk_buff, tc_index, 2,
> @@ -9645,8 +9652,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
>  		BUILD_BUG_ON(sizeof_field(struct sock, sk_bound_dev_if) != 4);
>  
>  		if (type == BPF_WRITE)
> -			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
> -					offsetof(struct sock, sk_bound_dev_if));
> +			*insn++ = BPF_COPY_STORE(BPF_W, si,
> +						 offsetof(struct sock, sk_bound_dev_if));
>  		else
>  			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
>  				      offsetof(struct sock, sk_bound_dev_if));
> @@ -9656,8 +9663,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
>  		BUILD_BUG_ON(sizeof_field(struct sock, sk_mark) != 4);
>  
>  		if (type == BPF_WRITE)
> -			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
> -					offsetof(struct sock, sk_mark));
> +			*insn++ = BPF_COPY_STORE(BPF_W, si,
> +						 offsetof(struct sock, sk_mark));
>  		else
>  			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
>  				      offsetof(struct sock, sk_mark));
> @@ -9667,8 +9674,8 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
>  		BUILD_BUG_ON(sizeof_field(struct sock, sk_priority) != 4);
>  
>  		if (type == BPF_WRITE)
> -			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
> -					offsetof(struct sock, sk_priority));
> +			*insn++ = BPF_COPY_STORE(BPF_W, si,
> +						 offsetof(struct sock, sk_priority));
>  		else
>  			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
>  				      offsetof(struct sock, sk_priority));
> @@ -9933,10 +9940,12 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
>  				      offsetof(S, TF));			       \
>  		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(S, F), tmp_reg,	       \
>  				      si->dst_reg, offsetof(S, F));	       \
> -		*insn++ = BPF_STX_MEM(SIZE, tmp_reg, si->src_reg,	       \
> +		*insn++ = BPF_RAW_INSN(SIZE | BPF_MEM | BPF_CLASS(si->code),   \
> +				       tmp_reg, si->src_reg,		       \

the macro didn't work here because of 'tmp_reg' ?

>  			bpf_target_off(NS, NF, sizeof_field(NS, NF),	       \
>  				       target_size)			       \
> -				+ OFF);					       \
> +				       + OFF,				       \
> +				       si->imm);			       \
>  		*insn++ = BPF_LDX_MEM(BPF_DW, tmp_reg, si->dst_reg,	       \
