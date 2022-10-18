Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAB260354A
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 23:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJRVzZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 17:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJRVzY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 17:55:24 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBB374E02
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 14:55:23 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i17-20020a170902cf1100b00183e2a963f5so10389742plg.5
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bbSt1FjeO41pYtNZSp4Y2UUS54XrFy+A2kAlWwJwi68=;
        b=SX9WzOdk/fA26MCV8MIe0haOLFXYSiBoHJHdayIghLf/8rSgxs2Lo3mB+AdRL6t0bQ
         6rXgcl++YBaOC7Fh9krfYxm/8MqBWvrLHsxpcMuiLl0EWuw8R2Phe5ugBVtjID62vRmv
         QddzuI02gCpWr+YgSdjZOksKbk0GTt9eetoE8iBCIMwq+SQQdmYCsFVXIGc6n+QvXg/K
         mwKCPLaFrTTerLyRzp0bHtXZ/OapOJclkyW1dQVbcrMo9euxftxDSyLxRYAyMY7978gN
         0qzGw4etKD8V8+RWAjpyBfexRQHZwlyzUNajdodYRHE1j09PKF71fgae0jfhsiCNadFw
         tZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbSt1FjeO41pYtNZSp4Y2UUS54XrFy+A2kAlWwJwi68=;
        b=U1KjmkWOALU3HegPc6qPTF+73WIPf5ttN1AR6beF6CR/sLwgsdB0oa9xU7um/LzKBQ
         ea9YyTnMd38ModEcpTr/UhhlkuC+T0slIzIHNAJmgSAAvy/b3uHV5oiuezOjbQ4irBd7
         BdFOlANbRz8QqXkT0Z+XSnax9HyvPfaLswBYfJCgyxR22aM1k+0PFBT0G4esN1zbfU/p
         1Y/Am9W6Po8kSkXM09YovgJIAfdl7OAGT1qza51nfR/NbcvaDuFr+JK8DPCEdJLkRrAn
         JIn23QkFVvYAvEw+kgnmGmzeL1Cgz+C7Ppwz8eGmBa3hrEmCbeayER6UncFNhfOgKGh8
         kAMA==
X-Gm-Message-State: ACrzQf1IMmX1eVP6QvGfu/ecejL0+H/6Kc2tNwdanPFwlo15eUKlGlSX
        H7yBPr1AgzyQj3+c3c3zX8yOldA=
X-Google-Smtp-Source: AMsMyM6BelTQ8N6JOPe2V+eQkVOS+Mln+gKFHVl9sJdTb0p50/MghgOAwTqhkywDfmidQQj/21WYGfM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:23c5:b0:563:a0f0:e4d1 with SMTP id
 g5-20020a056a0023c500b00563a0f0e4d1mr5130954pfc.62.1666130122983; Tue, 18 Oct
 2022 14:55:22 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:55:21 -0700
In-Reply-To: <20221018135920.726360-5-memxor@gmail.com>
Mime-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-5-memxor@gmail.com>
Message-ID: <Y08gyUs+HCBYw0Q5@google.com>
Subject: Re: [PATCH bpf-next v1 04/13] bpf: Rework check_func_arg_reg_off
From:   sdf@google.com
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/18, Kumar Kartikeya Dwivedi wrote:
> While check_func_arg_reg_off is the place which performs generic checks
> needed by various candidates of reg->type, there is some handling for
> special cases, like ARG_PTR_TO_DYNPTR, OBJ_RELEASE, and
> ARG_PTR_TO_ALLOC_MEM.

> This commit aims to streamline these special cases and instead leave
> other things up to argument type specific code to handle.

> This is done primarily for two reasons: associating back reg->type to
> its argument leaves room for the list getting out of sync when a new
> reg->type is supported by an arg_type.

> The other case is ARG_PTR_TO_ALLOC_MEM. The problem there is something
> we already handle, whenever a release argument is expected, it should
> be passed as the pointer that was received from the acquire function.
> Hence zero fixed and variable offset.

> There is nothing special about ARG_PTR_TO_ALLOC_MEM, where technically
> its target register type PTR_TO_MEM | MEM_ALLOC can already be passed
> with non-zero offset to other helper functions, which makes sense.

> Hence, lift the arg_type_is_release check for reg->off and cover all
> possible register types, instead of duplicating the same kind of check
> twice for current OBJ_RELEASE arg_types (alloc_mem and ptr_to_btf_id).

> Finally, for the release argument, arg_type_is_dynptr is the special
> case, where we go to actual object being freed through the dynptr, so
> the offset of the pointer still needs to allow fixed and variable offset
> and process_dynptr_func will verify them later for the release argument
> case as well.

> Finally, since check_func_arg_reg_off is meant to be generic, move
> dynptr specific check into process_dynptr_func.

> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   kernel/bpf/verifier.c                         | 55 +++++++++++++++----
>   .../testing/selftests/bpf/verifier/ringbuf.c  |  2 +-
>   2 files changed, 44 insertions(+), 13 deletions(-)

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a49b95c1af1b..a8c277e51d63 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5654,6 +5654,14 @@ int process_dynptr_func(struct bpf_verifier_env  
> *env, int regno,
>   		return -EFAULT;
>   	}

> +	/* CONST_PTR_TO_DYNPTR has fixed and variable offset as zero, ensured by
> +	 * check_func_arg_reg_off, so this is only needed for PTR_TO_STACK.
> +	 */
> +	if (reg->off % BPF_REG_SIZE) {
> +		verbose(env, "cannot pass in dynptr at an offset\n");
> +		return -EINVAL;
> +	}

This is what I'm missing here and in the original code as well, maybe you
can clarify?

"if (reg->off & BPF_REG_SIZE)" here vs "if (reg->off)" below. What's the
difference?

> +
>   	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
>   	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
>   	 *
> @@ -5672,6 +5680,7 @@ int process_dynptr_func(struct bpf_verifier_env  
> *env, int regno,
>   	 *		 destroyed, including mutation of the memory it points
>   	 *		 to.
>   	 */
> +
>   	if (arg_type & MEM_UNINIT) {
>   		if (!is_dynptr_reg_valid_uninit(env, reg)) {
>   			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> @@ -5983,14 +5992,37 @@ int check_func_arg_reg_off(struct  
> bpf_verifier_env *env,
>   	enum bpf_reg_type type = reg->type;
>   	bool fixed_off_ok = false;

> -	switch ((u32)type) {
> -	/* Pointer types where reg offset is explicitly allowed: */
> -	case PTR_TO_STACK:
> -		if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
> -			verbose(env, "cannot pass in dynptr at an offset\n");
> +	/* When referenced register is passed to release function, it's fixed
> +	 * offset must be 0.
> +	 *
> +	 * We will check arg_type_is_release reg has ref_obj_id when storing
> +	 * meta->release_regno.
> +	 */
> +	if (arg_type_is_release(arg_type)) {
> +		/* ARG_PTR_TO_DYNPTR is a bit special, as it may not directly
> +		 * point to the object being released, but to dynptr pointing
> +		 * to such object, which might be at some offset on the stack.
> +		 *
> +		 * In that case, we simply to fallback to the default handling.
> +		 */
> +		if (arg_type_is_dynptr(arg_type) && type == PTR_TO_STACK)
> +			goto check_type;
> +		/* Going straight to check will catch this because fixed_off_ok
> +		 * is false, but checking here allows us to give the user a
> +		 * better error message.
> +		 */
> +		if (reg->off) {
> +			verbose(env, "R%d must have zero offset when passed to release  
> func\n",
> +				regno);
>   			return -EINVAL;
>   		}
> -		fallthrough;
> +		goto check;
> +	}
> +check_type:
> +	switch ((u32)type) {
> +	/* Pointer types where both fixed and variable reg offset is explicitly
> +	 * allowed: */
> +	case PTR_TO_STACK:
>   	case PTR_TO_PACKET:
>   	case PTR_TO_PACKET_META:
>   	case PTR_TO_MAP_KEY:
> @@ -6001,12 +6033,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env  
> *env,
>   	case PTR_TO_BUF:
>   	case PTR_TO_BUF | MEM_RDONLY:
>   	case SCALAR_VALUE:
> -		/* Some of the argument types nevertheless require a
> -		 * zero register offset.
> -		 */
> -		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
> -			return 0;
> -		break;
> +		return 0;
>   	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
>   	 * fixed offset.
>   	 */
> @@ -6023,12 +6050,16 @@ int check_func_arg_reg_off(struct  
> bpf_verifier_env *env,
>   		/* For arg is release pointer, fixed_off_ok must be false, but
>   		 * we already checked and rejected reg->off != 0 above, so set
>   		 * to true to allow fixed offset for all other cases.
> +		 *
> +		 * var_off always must be 0 for PTR_TO_BTF_ID, hence we still
> +		 * need to do checks instead of returning.
>   		 */
>   		fixed_off_ok = true;
>   		break;
>   	default:
>   		break;
>   	}
> +check:
>   	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>   }

> diff --git a/tools/testing/selftests/bpf/verifier/ringbuf.c  
> b/tools/testing/selftests/bpf/verifier/ringbuf.c
> index b64d33e4833c..92e3f6a61a79 100644
> --- a/tools/testing/selftests/bpf/verifier/ringbuf.c
> +++ b/tools/testing/selftests/bpf/verifier/ringbuf.c
> @@ -28,7 +28,7 @@
>   	},
>   	.fixup_map_ringbuf = { 1 },
>   	.result = REJECT,
> -	.errstr = "dereference of modified alloc_mem ptr R1",
> +	.errstr = "R1 must have zero offset when passed to release func",
>   },
>   {
>   	"ringbuf: invalid reservation offset 2",
> --
> 2.38.0

