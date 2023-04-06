Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292936D932E
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 11:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbjDFJry (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 05:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbjDFJqr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 05:46:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FD0A277
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 02:44:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l12so38864439wrm.10
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 02:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680774276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2/Dd3ygoBq/9ZwFRULP8J1nk3C4JaaVQK6Exbv17lwM=;
        b=LsgN/gHRqmt+6758QBRcYlo9dWAJvd15t0T3A4dxRiyQ1S6NjRnxCjYL6GJzSqaKmu
         ciz0HaByLHHYHLSpsUHyY1M3L6/f9AstoS/ORx8WhW/GRm4/XcVux7XMgF55iQo9/qme
         qBCEMeuT77qwi956esP45ZPeXfXlJq9Ae+72KO9QTVf+b2qtqOSodpVVT8IclD+fbFcp
         V0mMdGoJk8Ctgu/jvmRpPkrbSyxDut7UnW/VZIjU4eZwJ9gWG2DSKGTyBtKMJzBn9OJa
         CMV+nDW9QHb9S2TVBuEtYeQI/l0BX0A0CuSHZxL2DfxjLVbZ7yONgJc90pBbSXj6tfFS
         5DNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680774276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/Dd3ygoBq/9ZwFRULP8J1nk3C4JaaVQK6Exbv17lwM=;
        b=VZBVEjvDFlJGRXyQ3IF3goCM0kjxYrVT1owfeTY/kAy89XvdvW2UW2yGETGAfMzFQW
         cLD7dSMDjuYV5ArAbWbU2l1JN69/t+sYYl12ixVRCCUZdNoKlw+w05sCUc0LhLSqxROf
         jQirxD8bMD1K6EZNGeI5okNDVlHsZgXJSJKr+xhpNpxXo8tH/vhvcdSzKjgNd6xvx104
         FdzW5XfrbVmNEtOcmzMYTtgkXwHh76MGgBAqdSUr/V+RuNI10FQpjz0WGnoj8ZPu7i8U
         krHyUNsyt89TCdGxaU+vkCzvaZTf4rm323s8A4y7TKcSY2kYHXnBuJamdwn9SQIFl+Ky
         fRyA==
X-Gm-Message-State: AAQBX9d2bIKcWRNbkFcmtC1y8jdEU92+1b44FCv8vAvKWWKJtlGjOGWz
        2JjCQcxjsBWlTvkwWiumj44=
X-Google-Smtp-Source: AKy350ZRX2ZHfL4fxgCmi8TFu+ZL3JKiTcpmI95qPIM5cK0uh/2WCFHQN/uH22dE2Sg9dBICd6GyAg==
X-Received: by 2002:a5d:644d:0:b0:2d5:e84d:d270 with SMTP id d13-20020a5d644d000000b002d5e84dd270mr5980297wrw.19.1680774275649;
        Thu, 06 Apr 2023 02:44:35 -0700 (PDT)
Received: from krava (cpc137424-wilm3-2-0-cust276.1-4.cable.virginm.net. [82.23.5.21])
        by smtp.gmail.com with ESMTPSA id f4-20020adff8c4000000b002cff06039d7sm1285688wrq.39.2023.04.06.02.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 02:44:35 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Apr 2023 11:44:33 +0200
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next v6] bpf: Support 64-bit pointers to kfuncs
Message-ID: <ZC6UgfMdSZJ8BCT8@krava>
References: <20230405213453.49756-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405213453.49756-1-iii@linux.ibm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 05, 2023 at 11:34:53PM +0200, Ilya Leoshkevich wrote:

SNIP

>  
> +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
> +		       u16 btf_fd_idx, u8 **func_addr)
> +{
> +	const struct bpf_kfunc_desc *desc;
> +
> +	desc = find_kfunc_desc(prog, func_id, btf_fd_idx);
> +	if (!desc)
> +		return -EFAULT;
> +
> +	*func_addr = (u8 *)desc->addr;
> +	return 0;
> +}
> +
>  static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>  					 s16 offset)
>  {
> @@ -2672,14 +2691,19 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>  		return -EINVAL;
>  	}
>  
> -	call_imm = BPF_CALL_IMM(addr);
> -	/* Check whether or not the relative offset overflows desc->imm */
> -	if ((unsigned long)(s32)call_imm != call_imm) {
> -		verbose(env, "address of kernel function %s is out of range\n",
> -			func_name);
> -		return -EINVAL;
> +	if (bpf_jit_supports_far_kfunc_call()) {
> +		call_imm = func_id;
> +	} else {
> +		call_imm = BPF_CALL_IMM(addr);

we compute call_imm again in fixup_kfunc_call, seems like we could store
the address and the func_id in desc and have fixup_kfunc_call do the
insn->imm setup


> +		/* Check whether the relative offset overflows desc->imm */
> +		if ((unsigned long)(s32)call_imm != call_imm) {
> +			verbose(env, "address of kernel function %s is out of range\n",
> +				func_name);
> +			return -EINVAL;
> +		}
>  	}
>  
> +

nit, extra line

>  	if (bpf_dev_bound_kfunc_id(func_id)) {
>  		err = bpf_dev_bound_kfunc_check(&env->log, prog_aux);
>  		if (err)
> @@ -2690,6 +2714,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>  	desc->func_id = func_id;
>  	desc->imm = call_imm;
>  	desc->offset = offset;
> +	desc->addr = addr;
>  	err = btf_distill_func_proto(&env->log, desc_btf,
>  				     func_proto, func_name,
>  				     &desc->func_model);
> @@ -2699,19 +2724,19 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>  	return err;
>  }
>  
> -static int kfunc_desc_cmp_by_imm(const void *a, const void *b)
> +static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
>  {
>  	const struct bpf_kfunc_desc *d0 = a;
>  	const struct bpf_kfunc_desc *d1 = b;
>  
> -	if (d0->imm > d1->imm)
> -		return 1;
> -	else if (d0->imm < d1->imm)
> -		return -1;
> +	if (d0->imm != d1->imm)
> +		return d0->imm < d1->imm ? -1 : 1;
> +	if (d0->offset != d1->offset)
> +		return d0->offset < d1->offset ? -1 : 1;
>  	return 0;
>  }
>  

SNIP

> +/* replace a generic kfunc with a specialized version if necessary */
> +static void fixup_kfunc_desc(struct bpf_verifier_env *env,
> +			     struct bpf_kfunc_desc *desc)
> +{
> +	struct bpf_prog *prog = env->prog;
> +	u32 func_id = desc->func_id;
> +	u16 offset = desc->offset;
> +	bool seen_direct_write;
> +	void *xdp_kfunc;
> +	bool is_rdonly;
> +
> +	if (bpf_dev_bound_kfunc_id(func_id)) {
> +		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
> +		if (xdp_kfunc) {
> +			desc->addr = (unsigned long)xdp_kfunc;
> +			return;
> +		}
> +		/* fallback to default kfunc when not supported by netdev */
> +	}
> +
> +	if (offset)
> +		return;
> +
> +	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
> +		seen_direct_write = env->seen_direct_write;
> +		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
> +
> +		if (is_rdonly)
> +			desc->addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
> +
> +		/* restore env->seen_direct_write to its original value, since
> +		 * may_access_direct_pkt_data mutates it
> +		 */
> +		env->seen_direct_write = seen_direct_write;
> +	}

could we do this directly in add_kfunc_call? 

thanks,
jirka


> +}
> +
> +static void fixup_kfunc_desc_tab(struct bpf_verifier_env *env)
> +{
> +	struct bpf_kfunc_desc_tab *tab = env->prog->aux->kfunc_tab;
> +	u32 i;
> +
> +	if (!tab)
> +		return;
> +
> +	for (i = 0; i < tab->nr_descs; i++)
> +		fixup_kfunc_desc(env, &tab->descs[i]);
> +}
> +
>  static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
>  	const struct bpf_kfunc_desc *desc;
> -	void *xdp_kfunc;
>  
>  	if (!insn->imm) {
>  		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
> @@ -17355,18 +17429,9 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  
>  	*cnt = 0;
>  
> -	if (bpf_dev_bound_kfunc_id(insn->imm)) {
> -		xdp_kfunc = bpf_dev_bound_resolve_kfunc(env->prog, insn->imm);
> -		if (xdp_kfunc) {
> -			insn->imm = BPF_CALL_IMM(xdp_kfunc);
> -			return 0;
> -		}
> -
> -		/* fallback to default kfunc when not supported by netdev */
> -	}
> -
> -	/* insn->imm has the btf func_id. Replace it with
> -	 * an address (relative to __bpf_call_base).
> +	/* insn->imm has the btf func_id. Replace it with an offset relative to
> +	 * __bpf_call_base, unless the JIT needs to call functions that are
> +	 * further than 32 bits away (bpf_jit_supports_far_kfunc_call()).
>  	 */
>  	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
>  	if (!desc) {
> @@ -17375,7 +17440,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		return -EFAULT;
>  	}
>  
> -	insn->imm = desc->imm;
> +	if (!bpf_jit_supports_far_kfunc_call())
> +		insn->imm = BPF_CALL_IMM(desc->addr);
>  	if (insn->off)
>  		return 0;
>  	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
> @@ -17400,17 +17466,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>  		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>  		*cnt = 1;
> -	} else if (desc->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
> -		bool seen_direct_write = env->seen_direct_write;
> -		bool is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
> -
> -		if (is_rdonly)
> -			insn->imm = BPF_CALL_IMM(bpf_dynptr_from_skb_rdonly);
> -
> -		/* restore env->seen_direct_write to its original value, since
> -		 * may_access_direct_pkt_data mutates it
> -		 */
> -		env->seen_direct_write = seen_direct_write;
>  	}
>  	return 0;
>  }
> @@ -17433,6 +17488,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  	struct bpf_map *map_ptr;
>  	int i, ret, cnt, delta = 0;
>  
> +	fixup_kfunc_desc_tab(env);
> +
>  	for (i = 0; i < insn_cnt; i++, insn++) {
>  		/* Make divide-by-zero exceptions impossible. */
>  		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
> @@ -17940,7 +17997,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  		}
>  	}
>  
> -	sort_kfunc_descs_by_imm(env->prog);
> +	sort_kfunc_descs_by_imm_off(env->prog);
>  
>  	return 0;
>  }
> -- 
> 2.39.2
> 
