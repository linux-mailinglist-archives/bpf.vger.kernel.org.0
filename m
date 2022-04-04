Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0994F1008
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 09:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377692AbiDDHgi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 03:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbiDDHgh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 03:36:37 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCBA165BF
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 00:34:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so8201688pjk.4
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UNmoh432iI7zdFFfxA94SY01EjeQcXY92ttloQRmiE8=;
        b=PUSQSm3YoxI0YzU7lP1sabD+KB0IQ2bbSOnqhdbn/S2CA7r1Yy+C/B9VQmOMwzrSQl
         Wn0JwyIsdzvd1JPDJrGiJh/fRj5HP7JKUI9Yj31QlH86XAWL79PnHg25KKjit8RW9b4l
         GhMISKKrAejQIC2NrkHjOJITl01VHmKpP2bn/QadVulngUpc7UAO/E4jTZ6rKQbbwIES
         DVce9KYvaiM/5/aGyMKoCt1tNBlsgdXFf1UJ4r8tbD5jVaxgkRupG2gnDtHrKarwSXRp
         NRuhU4j9wLF0cFK2Gm+51TBcpJBoHww3xKMPh6sboPCATUkAL1dNkEu+8iR0UBHzR5+k
         xI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UNmoh432iI7zdFFfxA94SY01EjeQcXY92ttloQRmiE8=;
        b=4tHAWEMiHmwEI432PCvrLxs/BpmmhDH3zpychiilnysBlNm/1X2Degy01+X74xbPiq
         2uvpsbrSmSLNYG9+Vxml2rwBClg151lAw1oEkx3xg3ct8OnIhZjoQklbPjfgyaLTobGz
         bZWwgz0KRSWdCFXgt5/wGrduXOUyUu4X8/b49UeGMGtBzIhR/DqcP6uJLVGPhvimgMzP
         QmfewY/2SP61Gfij2LJ8NGKObViUrpts4pEsLz6Tno/IsMDHCD46oGOpU1R8FEYGclSn
         4MdOvGQl4xkzZDH1ScHwXRA2G59FiQt++lVgewJiiqRA6I9YeqakfNRUTx0+mNjFt3jG
         5EoQ==
X-Gm-Message-State: AOAM530NbDWn/f37UZ0WX5jXwUvdZ2NJzZmA5Igf2DLJzuV5eYh7Z73e
        dJ//+jsTYUxPB+PcxFjkjM8=
X-Google-Smtp-Source: ABdhPJxF1umUDTFcwpUe8W+MdQB2C9nk4iAmXJVex92OMvdOB+Qu6rWuxfxOE+NmLjcnaTiZ/chkmA==
X-Received: by 2002:a17:902:d4cc:b0:156:3f4d:e0a5 with SMTP id o12-20020a170902d4cc00b001563f4de0a5mr21558609plg.91.1649057681428;
        Mon, 04 Apr 2022 00:34:41 -0700 (PDT)
Received: from localhost ([112.79.164.138])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00229000b004fabe756ba6sm11863891pfe.54.2022.04.04.00.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 00:34:40 -0700 (PDT)
Date:   Mon, 4 Apr 2022 13:04:37 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/7] bpf: Add MEM_RELEASE as a bpf_type_flag
Message-ID: <20220404073437.htzs76gxcm6cpert@apollo.legion>
References: <20220402015826.3941317-1-joannekoong@fb.com>
 <20220402015826.3941317-3-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402015826.3941317-3-joannekoong@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 02, 2022 at 07:28:21AM IST, Joanne Koong wrote:
> From: Joanne Koong <joannelkoong@gmail.com>
>
> Currently, we hardcode in the verifier which functions are release
> functions. We have no way of differentiating which argument is the one
> to be released (we assume it will always be the first argument).
>
> This patch adds MEM_RELEASE as a bpf_type_flag. This allows us to
> determine which argument in the function needs to be released, and
> removes having to hardcode a list of release functions into the
> verifier.
>
> Please note that currently, we only support one release argument in a
> helper function. In the future, if/when we need to support several
> release arguments within the function, MEM_RELEASE is necessary
> since there needs to be a way of differentiating which arguments are the
> release ones.
>
> In the near future, MEM_RELEASE will be used by dynptr helper functions
> such as bpf_free.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h          |  4 +++-
>  include/linux/bpf_verifier.h |  3 +--
>  kernel/bpf/btf.c             |  3 ++-
>  kernel/bpf/ringbuf.c         |  4 ++--
>  kernel/bpf/verifier.c        | 42 ++++++++++++++++++------------------
>  net/core/filter.c            |  2 +-
>  6 files changed, 30 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6f2558da9d4a..cb9f42866cde 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -344,7 +344,9 @@ enum bpf_type_flag {
>
>  	MEM_UNINIT		= BIT(5 + BPF_BASE_TYPE_BITS),
>
> -	__BPF_TYPE_LAST_FLAG	= MEM_UNINIT,
> +	MEM_RELEASE		= BIT(6 + BPF_BASE_TYPE_BITS),
> +
> +	__BPF_TYPE_LAST_FLAG	= MEM_RELEASE,
>  };
>
>  /* Max number of base types. */
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c1fc4af47f69..7a01adc9e13f 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -523,8 +523,7 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
>  		      const struct bpf_reg_state *reg, int regno);
>  int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  			   const struct bpf_reg_state *reg, int regno,
> -			   enum bpf_arg_type arg_type,
> -			   bool is_release_func);
> +			   enum bpf_arg_type arg_type, bool arg_release);
>  int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  			     u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0918a39279f6..e5b765a84aec 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5830,7 +5830,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
>  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
>
> -		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE, rel);
> +		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE,
> +					     rel && reg->ref_obj_id);
>  		if (ret < 0)
>  			return ret;
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 710ba9de12ce..a723aa484ce4 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -404,7 +404,7 @@ BPF_CALL_2(bpf_ringbuf_submit, void *, sample, u64, flags)
>  const struct bpf_func_proto bpf_ringbuf_submit_proto = {
>  	.func		= bpf_ringbuf_submit,
>  	.ret_type	= RET_VOID,
> -	.arg1_type	= ARG_PTR_TO_ALLOC_MEM,
> +	.arg1_type	= ARG_PTR_TO_ALLOC_MEM | MEM_RELEASE,
>  	.arg2_type	= ARG_ANYTHING,
>  };
>
> @@ -417,7 +417,7 @@ BPF_CALL_2(bpf_ringbuf_discard, void *, sample, u64, flags)
>  const struct bpf_func_proto bpf_ringbuf_discard_proto = {
>  	.func		= bpf_ringbuf_discard,
>  	.ret_type	= RET_VOID,
> -	.arg1_type	= ARG_PTR_TO_ALLOC_MEM,
> +	.arg1_type	= ARG_PTR_TO_ALLOC_MEM | MEM_RELEASE,
>  	.arg2_type	= ARG_ANYTHING,
>  };
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 90280d5666be..80e53303713e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -471,15 +471,12 @@ static bool type_may_be_null(u32 type)
>  	return type & PTR_MAYBE_NULL;
>  }
>
> -/* Determine whether the function releases some resources allocated by another
> - * function call. The first reference type argument will be assumed to be
> - * released by release_reference().
> +/* Determine whether the type releases some resources allocated by a
> + * previous function call.
>   */
> -static bool is_release_function(enum bpf_func_id func_id)
> +static bool type_is_release_mem(u32 type)
>  {
> -	return func_id == BPF_FUNC_sk_release ||
> -	       func_id == BPF_FUNC_ringbuf_submit ||
> -	       func_id == BPF_FUNC_ringbuf_discard;
> +	return type & MEM_RELEASE;
>  }
>
>  static bool may_be_acquire_function(enum bpf_func_id func_id)
> @@ -5364,13 +5361,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>
>  int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  			   const struct bpf_reg_state *reg, int regno,
> -			   enum bpf_arg_type arg_type,
> -			   bool is_release_func)
> +			   enum bpf_arg_type arg_type, bool arg_release)
>  {
> -	bool fixed_off_ok = false, release_reg;
> -	enum bpf_reg_type type = reg->type;
> +	bool fixed_off_ok = false;
>
> -	switch ((u32)type) {
> +	switch ((u32)reg->type) {
>  	case SCALAR_VALUE:
>  	/* Pointer types where reg offset is explicitly allowed: */
>  	case PTR_TO_PACKET:
> @@ -5393,18 +5388,15 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	 * fixed offset.
>  	 */
>  	case PTR_TO_BTF_ID:
> -		/* When referenced PTR_TO_BTF_ID is passed to release function,
> -		 * it's fixed offset must be 0. We rely on the property that
> -		 * only one referenced register can be passed to BPF helpers and
> -		 * kfuncs. In the other cases, fixed offset can be non-zero.
> +		/* If a referenced PTR_TO_BTF_ID will be released, its fixed offset
> +		 * must be 0.
>  		 */
> -		release_reg = is_release_func && reg->ref_obj_id;
> -		if (release_reg && reg->off) {
> +		if (arg_release && reg->off) {
>  			verbose(env, "R%d must have zero offset when passed to release func\n",
>  				regno);
>  			return -EINVAL;
>  		}
> -		/* For release_reg == true, fixed_off_ok must be false, but we
> +		/* For arg_release == true, fixed_off_ok must be false, but we
>  		 * already checked and rejected reg->off != 0 above, so set to
>  		 * true to allow fixed offset for all other cases.
>  		 */
> @@ -5424,6 +5416,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
>  	enum bpf_arg_type arg_type = fn->arg_type[arg];
>  	enum bpf_reg_type type = reg->type;
> +	bool arg_release;
>  	int err = 0;
>
>  	if (arg_type == ARG_DONTCARE)
> @@ -5464,7 +5457,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  	if (err)
>  		return err;
>
> -	err = check_func_arg_reg_off(env, reg, regno, arg_type, is_release_function(meta->func_id));
> +	arg_release = type_is_release_mem(arg_type);
> +	if (arg_release && !reg->ref_obj_id) {
> +		verbose(env, "R%d arg #%d is an unacquired reference and hence cannot be released\n",
> +			regno, arg + 1);
> +		return -EINVAL;
> +	}
> +
> +	err = check_func_arg_reg_off(env, reg, regno, arg_type, arg_release);
>  	if (err)
>  		return err;
>
> @@ -6693,7 +6693,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  			return err;
>  	}
>
> -	if (is_release_function(func_id)) {
> +	if (meta.ref_obj_id) {

The meta.ref_obj_id field is set unconditionally whenever we see a
reg->ref_obj_id, e.g. when we pass a refcounted argument to non-release
function. Wouldn't making this conditional only on meta.ref_obj_id lead to
release of that register now? Or did I miss some change above which prevents
this case?

To make things clear, I'm talking of this sequence:

p = acquire();
helper_foo(p);   // meta.ref_obj_id would be set, and p is released
release(p);	 // error, as p.ref_obj_id has no reference state

Besides, in my series this PTR_RELEASE / MEM_RELEASE tagging is only needed
because the release function can take a NULL pointer, so we need to know the
register of the argument to be released, and then make sure it is refcounted,
otherwise it must be NULL (and whether NULL is permitted or not is checked
earlier during argument checks). That doesn't seem to be true for bpf_free in
your series, as it can only take ARG_PTR_TO_DYNPTR (but maybe it should also
set PTR_MAYBE_NULL).

>  		err = release_reference(env, meta.ref_obj_id);
>  		if (err) {
>  			verbose(env, "func %s#%d reference has not been acquired before\n",
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9aafec3a09ed..a935ce7a63bc 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6621,7 +6621,7 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
>  	.func		= bpf_sk_release,
>  	.gpl_only	= false,
>  	.ret_type	= RET_INTEGER,
> -	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> +	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON | MEM_RELEASE,
>  };
>
>  BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
> --
> 2.30.2
>

--
Kartikeya
