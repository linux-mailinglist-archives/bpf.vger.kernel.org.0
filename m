Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479A4588888
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 10:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiHCIPd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 04:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiHCIPc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 04:15:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FAE5FE2
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 01:15:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id tk8so30059929ejc.7
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=I7EXgXKt70nfCJSlRacteg8hrEWhTvt7sZ6ViIT6MZ0=;
        b=VZvq+xu4fSeDT4HlpbSYypVcAvhOuMLoCc1uRoPZ+mnRADPfvJPoawfzFfJJ5X6zQI
         VcOtLZRB3qUwpBF4E4kWvlV0SwvGRelcLvFnRYYUO1k05Kfo3qFgSxrydrOfEjq2zSsA
         /OE5NUtFqwZiDRSpW3lgIjBcASMhNLPJeFyFce/GClLBzoyGm49QNCcVd8PNsEJ0NMhh
         i9z5eXiIt5ixCCmvN9DD9GDgUYqCunLRGlOWTyVPelxvZ1IBJ6YTKunfHlCqoT3yN10F
         UpGdpW3swmTh+Gt9ZvxAV3kJWVFVFWI40hwhBm/0FZ0BQza6lLovBFL5pRZSlSKihExE
         YbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=I7EXgXKt70nfCJSlRacteg8hrEWhTvt7sZ6ViIT6MZ0=;
        b=Kmj2acFgsmw2MI428fz+XkFT/+rMWGenRcP/IpsVRi3Y0SXl2wYubUipKyR+/kniDC
         QDfWMhmooe7BP9Mx8y0W2ETksubtOicHvI/1gV/n3Ptj86SnUUjmIJPmaAWubzCqPjwt
         qJqMWsE6DJl5WifkXanEzNhbLQJ6My6MdZt6b6lOVtTa6uU1JXCImJLfrSgaY2SluKT3
         K/pdptfHbRb9lcjVcZ5wiqWhGKMI6QCo/sci9yGFUSQuImpbrNy7DAtHXlH1fiipe5lc
         l8fmlWlZGOniFepb+hZB4Vigas1EoCLGiyzcuSTnP/tQO/AYaFeF5qobeH5UnJnuL8LB
         UBBg==
X-Gm-Message-State: ACgBeo0kC+f1baJMLXxcZHlWGYefX/JSynZYpb6rvXP/KqdHwLB7L4VO
        yAyZG4PlP7KgulGIaiaqZnQ=
X-Google-Smtp-Source: AA6agR7yVTy8bRiLjJd2qTbNTXayVE1n4mbyVXNmQF33xF0N3BHLnQZH/EetsGIe/ZZaMjw0L+7nvA==
X-Received: by 2002:a17:907:a06f:b0:730:69c7:9a1d with SMTP id ia15-20020a170907a06f00b0073069c79a1dmr11485469ejc.685.1659514529391;
        Wed, 03 Aug 2022 01:15:29 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id q4-20020a056402040400b0043c92c44c53sm9102570edv.93.2022.08.03.01.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 01:15:28 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 3 Aug 2022 10:15:27 +0200
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Subject: Re: [PATCH bpf-next v1] bpf: verifier cleanups
Message-ID: <YuounwzH7ISYsrAN@krava>
References: <20220802214638.3643235-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802214638.3643235-1-joannelkoong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 02, 2022 at 02:46:38PM -0700, Joanne Koong wrote:
> This patch cleans up a few things in the verifier:
>   * type_is_pkt_pointer():
>     Future work (skb + xdp dynptrs [0]) will be using the reg type
>     PTR_TO_PACKET | PTR_MAYBE_NULL. type_is_pkt_pointer() should return
>     true for any type whose base type is PTR_TO_PACKET, regardless of
>     flags attached to it.
> 
>   * reg_type_may_be_refcounted_or_null():
>     Get the base type at the start of the function to avoid
>     having to recompute it / improve readability
> 
>   * check_func_proto(): remove unnecessary 'meta' arg
> 
>   * check_helper_call():
>     Use switch casing on the base type of return value instead of
>     nested ifs on the full type
> 
> There are no functional behavior changes.
> 
> [0] https://lore.kernel.org/bpf/20220726184706.954822-1-joannelkoong@gmail.com/
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

LGTM

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 096fdac70165..843a966cd02b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -427,6 +427,7 @@ static void verbose_invalid_scalar(struct bpf_verifier_env *env,
>  
>  static bool type_is_pkt_pointer(enum bpf_reg_type type)
>  {
> +	type = base_type(type);
>  	return type == PTR_TO_PACKET ||
>  	       type == PTR_TO_PACKET_META;
>  }
> @@ -456,10 +457,9 @@ static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
>  
>  static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
>  {
> -	return base_type(type) == PTR_TO_SOCKET ||
> -		base_type(type) == PTR_TO_TCP_SOCK ||
> -		base_type(type) == PTR_TO_MEM ||
> -		base_type(type) == PTR_TO_BTF_ID;
> +	type = base_type(type);
> +	return type == PTR_TO_SOCKET || type == PTR_TO_TCP_SOCK ||
> +		type == PTR_TO_MEM || type == PTR_TO_BTF_ID;
>  }
>  
>  static bool type_is_rdonly_mem(u32 type)
> @@ -6498,8 +6498,7 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
>  	return true;
>  }
>  
> -static int check_func_proto(const struct bpf_func_proto *fn, int func_id,
> -			    struct bpf_call_arg_meta *meta)
> +static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
>  {
>  	return check_raw_mode_ok(fn) &&
>  	       check_arg_pair_ok(fn) &&
> @@ -7218,7 +7217,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	memset(&meta, 0, sizeof(meta));
>  	meta.pkt_access = fn->pkt_access;
>  
> -	err = check_func_proto(fn, func_id, &meta);
> +	err = check_func_proto(fn, func_id);
>  	if (err) {
>  		verbose(env, "kernel subsystem misconfigured func %s#%d\n",
>  			func_id_name(func_id), func_id);
> @@ -7359,13 +7358,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  
>  	/* update return register (already marked as written above) */
>  	ret_type = fn->ret_type;
> -	ret_flag = type_flag(fn->ret_type);
> -	if (ret_type == RET_INTEGER) {
> +	ret_flag = type_flag(ret_type);
> +
> +	switch (base_type(ret_type)) {
> +	case RET_INTEGER:
>  		/* sets type to SCALAR_VALUE */
>  		mark_reg_unknown(env, regs, BPF_REG_0);
> -	} else if (ret_type == RET_VOID) {
> +		break;
> +	case RET_VOID:
>  		regs[BPF_REG_0].type = NOT_INIT;
> -	} else if (base_type(ret_type) == RET_PTR_TO_MAP_VALUE) {
> +		break;
> +	case RET_PTR_TO_MAP_VALUE:
>  		/* There is no offset yet applied, variable or fixed */
>  		mark_reg_known_zero(env, regs, BPF_REG_0);
>  		/* remember map_ptr, so that check_map_access()
> @@ -7384,20 +7387,26 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		    map_value_has_spin_lock(meta.map_ptr)) {
>  			regs[BPF_REG_0].id = ++env->id_gen;
>  		}
> -	} else if (base_type(ret_type) == RET_PTR_TO_SOCKET) {
> +		break;
> +	case RET_PTR_TO_SOCKET:
>  		mark_reg_known_zero(env, regs, BPF_REG_0);
>  		regs[BPF_REG_0].type = PTR_TO_SOCKET | ret_flag;
> -	} else if (base_type(ret_type) == RET_PTR_TO_SOCK_COMMON) {
> +		break;
> +	case RET_PTR_TO_SOCK_COMMON:
>  		mark_reg_known_zero(env, regs, BPF_REG_0);
>  		regs[BPF_REG_0].type = PTR_TO_SOCK_COMMON | ret_flag;
> -	} else if (base_type(ret_type) == RET_PTR_TO_TCP_SOCK) {
> +		break;
> +	case RET_PTR_TO_TCP_SOCK:
>  		mark_reg_known_zero(env, regs, BPF_REG_0);
>  		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
> -	} else if (base_type(ret_type) == RET_PTR_TO_ALLOC_MEM) {
> +		break;
> +	case RET_PTR_TO_ALLOC_MEM:
>  		mark_reg_known_zero(env, regs, BPF_REG_0);
>  		regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
>  		regs[BPF_REG_0].mem_size = meta.mem_size;
> -	} else if (base_type(ret_type) == RET_PTR_TO_MEM_OR_BTF_ID) {
> +		break;
> +	case RET_PTR_TO_MEM_OR_BTF_ID:
> +	{
>  		const struct btf_type *t;
>  
>  		mark_reg_known_zero(env, regs, BPF_REG_0);
> @@ -7429,7 +7438,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  			regs[BPF_REG_0].btf = meta.ret_btf;
>  			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
>  		}
> -	} else if (base_type(ret_type) == RET_PTR_TO_BTF_ID) {
> +		break;
> +	}
> +	case RET_PTR_TO_BTF_ID:
> +	{
>  		struct btf *ret_btf;
>  		int ret_btf_id;
>  
> @@ -7450,7 +7462,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		}
>  		regs[BPF_REG_0].btf = ret_btf;
>  		regs[BPF_REG_0].btf_id = ret_btf_id;
> -	} else {
> +		break;
> +	}
> +	default:
>  		verbose(env, "unknown return type %u of func %s#%d\n",
>  			base_type(ret_type), func_id_name(func_id), func_id);
>  		return -EINVAL;
> -- 
> 2.30.2
> 
