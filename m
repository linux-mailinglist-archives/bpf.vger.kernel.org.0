Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E2C4CDFF6
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 22:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiCDV4t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 16:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiCDV4t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 16:56:49 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4C27400C
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 13:56:00 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t19so5352876plr.5
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=++5drLyjXzxMgtn5GKb/TMjDRWjeFSuaRKFeFtUh8jY=;
        b=PSNBntM2ow2blvNELX7eNdDtV7x8EHAhNpu+VQFbj2ea5+h6Gqk4QsxhYzgP2NA1pk
         RRqD2S68FUCAQSHWalViFpwaYKDMt64d38Hf8CEcj2+VJdzixQE0fPsg29inBlcFROi7
         6vAlo4kEUEhODdDzOk69q7ZkbcSqjoZPNMAdua3+W1hjZeSS3Pp42sK3jNQkyRq2Rtsc
         2pDR6pLyPFPZXldB0l355smOE3n/laFxaR0r4zj94GP4kE7wJP8KT9ny62w0c+pecKlR
         05dbGfYVpOfUdom/rvJbwYCMJmTBK/UzzG78iKeA42x2RTBjZV2W0nOhM8YFZF2+/TM+
         NaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=++5drLyjXzxMgtn5GKb/TMjDRWjeFSuaRKFeFtUh8jY=;
        b=Dsl+pJegXbYO7WCrt6gaR6dIINIKdiA53ndHr7UwjDzDrvV3PXksT+ESqdO4rLsTZs
         jM4z4xwofuWL2Opu6jElLMOP3BH8axFEqRpciKhyuazqWAlLZQyh4u55LUoE5/ZsnT5i
         zWoC5kAoh+WBkeVeJ3JxHU4WsyKcvrdnXhSdDx1tdqQud6RaeIG9fYjK9PoXxo4ewUs5
         dV8Sm4F3ubRPtgL/fHQsq/W14RJP8zN39aJUcxOnr6oFsXIP18pb1pCYH7M8OhaLe/LO
         3bIGH0QIuiF1NhkxwYz0xnFKga84sLgkImOO1FfbVLWWIzhtgaxZs9rfN4lDTJ0xsurM
         SyUw==
X-Gm-Message-State: AOAM530Uy+ecsTAxMgQfs1xpiBFbeJCfyRjndoyb8liDuJkHGdqHa0ul
        rBUzvNh6xCsJx0ShVPsndSI=
X-Google-Smtp-Source: ABdhPJxg+txz/irdFyZV8uQ9NxFMdn5RnOYyrMG5HG+hjOZd/4NaBCiOaWkhauzdN9Ka+aoQaO8DCg==
X-Received: by 2002:a17:90a:4286:b0:1b8:8ba1:730c with SMTP id p6-20020a17090a428600b001b88ba1730cmr660633pjg.181.1646430959472;
        Fri, 04 Mar 2022 13:55:59 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id k13-20020a056a00134d00b004f35ee59a9dsm7230159pfu.106.2022.03.04.13.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 13:55:59 -0800 (PST)
Date:   Sat, 5 Mar 2022 03:25:56 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/8] bpf: Harden register offset checks for
 release helpers and kfuncs
Message-ID: <20220304215556.2x2frcep5bebe7ch@apollo.legion>
References: <20220304000508.2904128-1-memxor@gmail.com>
 <20220304000508.2904128-5-memxor@gmail.com>
 <20220304202830.4zgw6h5ulddx3zns@kafai-mbp.dhcp.thefacebook.com>
 <20220304204856.7pplkvhl57sxtnwz@apollo.legion>
 <20220304214333.5f3yzrhghmqf7rkd@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304214333.5f3yzrhghmqf7rkd@kafai-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 05, 2022 at 03:13:33AM IST, Martin KaFai Lau wrote:
> On Sat, Mar 05, 2022 at 02:18:56AM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Sat, Mar 05, 2022 at 01:58:30AM IST, Martin KaFai Lau wrote:
> > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > > index 38b24ee8d8c2..7a684050495a 100644
> > > > --- a/include/linux/bpf_verifier.h
> > > > +++ b/include/linux/bpf_verifier.h
> > > > @@ -523,7 +523,8 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
> > > >  		      const struct bpf_reg_state *reg, int regno);
> > > >  int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > > >  			   const struct bpf_reg_state *reg, int regno,
> > > > -			   enum bpf_arg_type arg_type);
> > > > +			   enum bpf_arg_type arg_type,
> > > > +			   bool is_release_function);
> > > >  int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > >  			     u32 regno);
> > > >  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 7f6a0ae5028b..c9a1019dc60d 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -5753,6 +5753,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >  		return -EINVAL;
> > > >  	}
> > > >
> > > > +	if (is_kfunc)
> > > > +		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> > > > +						BTF_KFUNC_TYPE_RELEASE, func_id);
> > > >  	/* check that BTF function arguments match actual types that the
> > > >  	 * verifier sees.
> > > >  	 */
> > > > @@ -5777,7 +5780,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >  		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
> > > >  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
> > > >
> > > > -		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
> > > > +		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE, rel);
> > > >  		if (ret < 0)
> > > >  			return ret;
> > > >
> > > > @@ -5809,7 +5812,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >  			if (reg->type == PTR_TO_BTF_ID) {
> > > >  				reg_btf = reg->btf;
> > > >  				reg_ref_id = reg->btf_id;
> > > > -				/* Ensure only one argument is referenced PTR_TO_BTF_ID */
> > > > +				/* Ensure only one argument is referenced
> > > > +				 * PTR_TO_BTF_ID, check_func_arg_reg_off relies
> > > > +				 * on only one referenced register being allowed
> > > > +				 * for kfuncs.
> > > > +				 */
> > > >  				if (reg->ref_obj_id) {
> > > >  					if (ref_obj_id) {
> > > >  						bpf_log(log, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> > > > @@ -5892,8 +5899,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >  	/* Either both are set, or neither */
> > > >  	WARN_ON_ONCE((ref_obj_id && !ref_regno) || (!ref_obj_id && ref_regno));
> > > >  	if (is_kfunc) {
> > > This test is no longer needed?
> > >
> >
> > If you mean the rel && !ref_obj_id below (which is guarded by this check), I do
> > think it is needed, why do you think so? Because of the check in
> > check_func_arg_reg_off? That only checks reg->off when it sees that both
> > release_func and ref_obj_id are true, but ref_obj_id may not be set for any
> > argument(s) passed to a release function, so we need to reject when we don't get
> > atleast one referenced register for release function.
> >
> > Or were you referring to the WARN_ON_ONCE above it?
> I meant the "if (is_kfunc)" test.  rel can only be true
> anyway when it is_kfunc.
>

Ah, indeed. I will remove it, but add a comment as well.

> > > > -		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> > > > -						BTF_KFUNC_TYPE_RELEASE, func_id);
> > > >  		/* We already made sure ref_obj_id is set only for one argument */
> > > >  		if (rel && !ref_obj_id) {
> > > >  			bpf_log(log, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index e55bfd23e81b..c31407d156e7 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -5367,11 +5367,28 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > > >
> > > >  int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > > >  			   const struct bpf_reg_state *reg, int regno,
> > > > -			   enum bpf_arg_type arg_type)
> > > > +			   enum bpf_arg_type arg_type,
> > > > +			   bool is_release_func)
> > > >  {
> > > >  	enum bpf_reg_type type = reg->type;
> > > > +	bool fixed_off_ok = false;
> > > >  	int err;
> > > >
> > > > +	/* When referenced PTR_TO_BTF_ID is passed to release function, it's
> > > > +	 * fixed offset must be 0. We rely on the property that only one
> > > > +	 * referenced register can be passed to BPF helpers and kfuncs.
> > > > +	 */
> > > > +	if (type == PTR_TO_BTF_ID) {
> > > > +		bool release_reg = is_release_func && reg->ref_obj_id;
> > > > +
> > > > +		if (release_reg && reg->off) {
> > > iiuc, the reason for not going through __check_ptr_off_reg() is
> > > because it prefers a different verifier log message for release_reg
> > > case for fixed off.  How about var_off?
> > >
> >
> > If reg->off is zero, we still call __check_ptr_off_reg with fixed_off_ok =
> > false, which should handle non-zero var_off.
> Understood that __check_ptr_off_reg handles both fixed_off and var_off case.
>
> The question was why only single out reg->off case to have a special message
> but not the var_off case.  The var_off case does not need a special message?
>

So my reasoning was, var_off is already disallowed even for normal case (it is
rejected in check_ptr_to_btf_access as well), so we don't need a special message
for that, just the existing one is fine. But reg->off is allowed, except in this
case, so we can return a helpful message on why verifier is returning an error.

> >
> > > > +			verbose(env, "R%d must have zero offset when passed to release func\n",
> > > > +				regno);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +		fixed_off_ok = release_reg ? false : true;
> > > nit.
> > > 		fixed_off_ok = !release_reg;
> > >
> > > but this is a bit moot here considering the reg->off
> > > check has already been done for the release_reg case.
> > >
> >
> > Yes, it would be a redundant check inside __check_ptr_off_reg, but we still need
> > to call it for checking bad var_off.
> Redundant check is fine.
>
> The intention and the net effect here is fixed_off is always
> allowed for the remaining case, so may as well directly set
> fixed_off_ok to true.  "fixed_off_ok = !release_reg;"
> made me go back to re-read what else has not been handled
> for the release_reg case but it could be just me being
> slow here.
>

Right, I can see why that may be confusing. I just set it to !release_reg to
disable any other code that may be added using that bool later in the future.

> It will be useful to at least leave a comment here
> on the redundant check and the remaining cases for
> PTR_TO_BTF_ID actually always allow fixed_off.
>

Yes, I will add a comment to make it clearer.

Thank you for your review.

> >
> > > > +	}
> > > > +
> > > >  	switch ((u32)type) {
> > > >  	case SCALAR_VALUE:
> > > >  	/* Pointer types where reg offset is explicitly allowed: */
> > > > @@ -5394,8 +5411,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > > >  	/* All the rest must be rejected: */
> > > >  	default:
> > > >  force_off_check:
> > > > -		err = __check_ptr_off_reg(env, reg, regno,
> > > > -					  type == PTR_TO_BTF_ID);
> > > > +		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> > > >  		if (err < 0)
> > > >  			return err;
> > > >  		break;
> > > > @@ -5452,11 +5468,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > >  	if (err)
> > > >  		return err;
> > > >
> > > > -	err = check_func_arg_reg_off(env, reg, regno, arg_type);
> > > > +	err = check_func_arg_reg_off(env, reg, regno, arg_type, is_release_function(meta->func_id));
> > > >  	if (err)
> > > >  		return err;
> > > >
> > > >  skip_type_check:
> > > > +	/* check_func_arg_reg_off relies on only one referenced register being
> > > > +	 * allowed for BPF helpers.
> > > > +	 */
> > > >  	if (reg->ref_obj_id) {
> > > >  		if (meta->ref_obj_id) {
> > > >  			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> > > > --
> > > > 2.35.1
> > > >
> >
> > --
> > Kartikeya

--
Kartikeya
