Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6AB55327F
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350955AbiFUMux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 08:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350867AbiFUMug (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 08:50:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AF12A713
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 05:50:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r66so7078744pgr.2
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AnH6foz/9L2K1HkMOv9KuHoLJziilna999OC/kvIeTs=;
        b=ZV9Z5YtxmaXjUKq+IN3cL4tc0LjA2YteAGuUrfjjvxA1bxxlB0uA9KzCSJTFDDdCvq
         94O/1ZwThkvMTC0z7/sVUey+ga3YUhXizfNLt4Q0qJpbE6ITKIw/B0+ePkd6m2goqYj0
         s0mZ9CxjZ5iNdUE804tKnKNKt8l/8FGXtWlo+fhpsi5+mxMZkaDifhdCaawMm3+nUcAd
         EzRg9ruw/QvGRpl+UnrxXnSlvTyXp1xDbkf5OYba6V2MScpJ3eWIctX1GWrcS+HXDN+L
         vgBXxQ/HGCT4xiN2d9m4udfmDzqG/cj+47y4dw/ti/e+NwDx4KvG/ySm8Kf5sFFsZ09A
         nAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AnH6foz/9L2K1HkMOv9KuHoLJziilna999OC/kvIeTs=;
        b=PKr0mQzb9V2tG+PBmK01XG+tq3U0n+l2MpgpPJUbJXblBMqXfxMOfJ/KAN2FpRDS/O
         TROvjd+ol+J8G2tsNA3l7PhN3E3SXMRjRcMJzF9u7JNEfXcpObgIERaP5kjjnMAS/kvo
         U09Ic2utZPXjDPddF9KR21lCgzrBZnqa6ayVqFBm9H1F6W9d790FJF2X53sz8sxAtEBh
         sWIU472vQ4cGEOf5cMISl3LPEwdCOc/Y/erUye8quP//Uj5iEoq4Rxea2I4myeO9Lkgf
         m8frJpLusUkh17aqOD4pOfAX0ZguBC9sBsnt8GrIm+9DCWJN35ZB9cD+Ju0eOxjPBKbr
         2kxw==
X-Gm-Message-State: AJIora/W5Jl5EEOW+KpYhmiHjDg5siS+5Zm8RO6xFD2vjn0RBz0S/b4a
        XymehslE7a4fckJbCQVRQds=
X-Google-Smtp-Source: AGRyM1uKlshil0W9Tow292V6VvhW2M5ZJpsoATRPmdIX1ccEJVT+Vm/IRkSuCKvbJC3waoZ3M42YmQ==
X-Received: by 2002:a05:6a00:1745:b0:51b:de90:aefb with SMTP id j5-20020a056a00174500b0051bde90aefbmr30379468pfc.11.1655815832483;
        Tue, 21 Jun 2022 05:50:32 -0700 (PDT)
Received: from localhost ([2405:201:6014:d0c0:79de:f3f4:353c:8616])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d48500b0015ea95948ebsm10673139plg.134.2022.06.21.05.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:50:32 -0700 (PDT)
Date:   Tue, 21 Jun 2022 18:20:21 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: kfunc support for
 ARG_PTR_TO_CONST_STR
Message-ID: <20220621125021.na2lctgyqs6ybto2@apollo.legion>
References: <20220621012811.2683313-1-kpsingh@kernel.org>
 <20220621012811.2683313-3-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621012811.2683313-3-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 06:58:08AM IST, KP Singh wrote:
> kfuncs can handle pointers to memory when the next argument is
> the size of the memory that can be read and verify these as
> ARG_CONST_SIZE_OR_ZERO
>
> Similarly add support for string constants (const char *) and
> verify it similar to ARG_PTR_TO_CONST_STR.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf_verifier.h |  2 +
>  kernel/bpf/btf.c             | 29 ++++++++++++
>  kernel/bpf/verifier.c        | 85 ++++++++++++++++++++----------------
>  3 files changed, 79 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 3930c963fa67..60d490354397 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -548,6 +548,8 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
>  			     u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  		   u32 regno, u32 mem_size);
> +int check_const_str(struct bpf_verifier_env *env,
> +		    const struct bpf_reg_state *reg, int regno);
>
>  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 668ecf61649b..02d7951591ae 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6162,6 +6162,26 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
>  	return true;
>  }
>
> +static bool btf_param_is_const_str_ptr(const struct btf *btf,
> +				       const struct btf_param *param)
> +{
> +	const struct btf_type *t;
> +
> +	t = btf_type_by_id(btf, param->type);
> +	if (!btf_type_is_ptr(t))
> +		return false;
> +
> +	t = btf_type_by_id(btf, t->type);
> +	if (!(BTF_INFO_KIND(t->info) == BTF_KIND_CONST))
> +		return false;
> +
> +	t = btf_type_skip_modifiers(btf, t->type, NULL);
> +	if (!strcmp(btf_name_by_offset(btf, t->name_off), "char"))
> +		return true;
> +
> +	return false;
> +}
> +
>  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  				    const struct btf *btf, u32 func_id,
>  				    struct bpf_reg_state *regs,
> @@ -6344,6 +6364,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  		} else if (ptr_to_mem_ok) {
>  			const struct btf_type *resolve_ret;
>  			u32 type_size;
> +			int err;
>
>  			if (is_kfunc) {
>  				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> @@ -6354,6 +6375,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  				 * When arg_mem_size is true, the pointer can be
>  				 * void *.
>  				 */
> +				if (btf_param_is_const_str_ptr(btf, &args[i])) {

Here, we need to check whether reg is a PTR_TO_MAP_VALUE, otherwise in
check_const_str, reg->map_ptr may be NULL. Probably best to do it in
btf_param_is_const_str_ptr itself.

> +					err = check_const_str(env, reg, regno);
> +					if (err < 0)
> +						return err;
> +					i++;
> +					continue;
> +				}
> +
>  				if (!btf_type_is_scalar(ref_t) &&
>  				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
>  				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2859901ffbe3..14a434792d7b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5840,6 +5840,52 @@ static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state
>  	return state->stack[spi].spilled_ptr.id;
>  }
>
> +int check_const_str(struct bpf_verifier_env *env,
> +		    const struct bpf_reg_state *reg, int regno)
> +{
> +	struct bpf_map *map = reg->map_ptr;
> +	int map_off;
> +	u64 map_addr;
> +	char *str_ptr;
> +	int err;
> +
> +	if (!bpf_map_is_rdonly(map)) {
> +		verbose(env, "R%d does not point to a readonly map'\n", regno);
> +		return -EACCES;
> +	}
> +
> +	if (!tnum_is_const(reg->var_off)) {
> +		verbose(env, "R%d is not a constant address'\n", regno);
> +		return -EACCES;
> +	}
> +
> +	if (!map->ops->map_direct_value_addr) {
> +		verbose(env,
> +			"no direct value access support for this map type\n");
> +		return -EACCES;
> +	}
> +
> +	err = check_map_access(env, regno, reg->off, map->value_size - reg->off,
> +			       false, ACCESS_HELPER);
> +	if (err)
> +		return err;
> +
> +	map_off = reg->off + reg->var_off.value;
> +	err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> +	if (err) {
> +		verbose(env, "direct value access on string failed\n");
> +		return err;
> +	}
> +
> +	str_ptr = (char *)(long)(map_addr);
> +	if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
> +		verbose(env, "string is not zero-terminated\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
>  			  const struct bpf_func_proto *fn)
> @@ -6074,44 +6120,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			return err;
>  		err = check_ptr_alignment(env, reg, 0, size, true);
>  	} else if (arg_type == ARG_PTR_TO_CONST_STR) {
> -		struct bpf_map *map = reg->map_ptr;
> -		int map_off;
> -		u64 map_addr;
> -		char *str_ptr;
> -
> -		if (!bpf_map_is_rdonly(map)) {
> -			verbose(env, "R%d does not point to a readonly map'\n", regno);
> -			return -EACCES;
> -		}
> -
> -		if (!tnum_is_const(reg->var_off)) {
> -			verbose(env, "R%d is not a constant address'\n", regno);
> -			return -EACCES;
> -		}
> -
> -		if (!map->ops->map_direct_value_addr) {
> -			verbose(env, "no direct value access support for this map type\n");
> -			return -EACCES;
> -		}
> -
> -		err = check_map_access(env, regno, reg->off,
> -				       map->value_size - reg->off, false,
> -				       ACCESS_HELPER);
> -		if (err)
> -			return err;
> -
> -		map_off = reg->off + reg->var_off.value;
> -		err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> -		if (err) {
> -			verbose(env, "direct value access on string failed\n");
> +		err = check_const_str(env, reg, regno);
> +		if (err < 0)
>  			return err;
> -		}
> -
> -		str_ptr = (char *)(long)(map_addr);
> -		if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
> -			verbose(env, "string is not zero-terminated\n");
> -			return -EINVAL;
> -		}
>  	} else if (arg_type == ARG_PTR_TO_KPTR) {
>  		if (process_kptr_func(env, regno, meta))
>  			return -EACCES;
> --
> 2.37.0.rc0.104.g0611611a94-goog
>

--
Kartikeya
