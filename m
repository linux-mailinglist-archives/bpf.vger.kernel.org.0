Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F134CDF1E
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiCDUtt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 15:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiCDUts (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 15:49:48 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F6571EEF
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 12:49:00 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id kx1-20020a17090b228100b001bf2dd26729so1803529pjb.1
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5/0oi3nhBuvJejfi5KUUG5FNQk4Mt+HLDy0g+nz1VQk=;
        b=SSkpA0BmiRIJ13FRJVtTA286kMwZ5NETYzP2iHhZKhOJ2jDSzsEH27rKpjG1nNFLzy
         x7RUgx+4qqKoZSLTb6mOAmB7lhpwWBeubMFCSBYtXpPJlbMphrGgyoygzDpr2OhXrBxD
         TSXQ+ymQswPvrPNGKufTszeDqA8mkiOYPGSkdvIppV5HI95/oqkB0NE89FBZrJxozJcC
         RGVKlgRs+N0tyTmKEFBxDUKhC7Z4zLTKoiKE5So7eonjJtfFXlUADaXJWatpuDrYFWe2
         wYchoFIV13LqCUOWX37KVRivhsB9hWejLNQP1uIcg8ldFll6LhScmYRutHve5TjxYD+K
         jwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5/0oi3nhBuvJejfi5KUUG5FNQk4Mt+HLDy0g+nz1VQk=;
        b=en9P25PatZ8miqx3UjxU+ked0WArcZUES2FROyR+7ddj4x1MacxXZ8DbNcvEVWSjQ3
         BGnzt8oVYkmEjkqkAiWgDoyBgFr5Ja62rifi3bjWsQvYKv9/KQ/FIzGbf52x738TL2wV
         Oi85INioNqjnemJEpMdtZM44N0wKu3DwG+7ObWISKFPOSHDPHMF8uCwZ39ooKOGU0dhK
         qeY4Fr+HKlqmDIuoEe7B4DwAYaT7Gw31XaXP12qW3ImZiASKy+F6495yj6cMxXo7lO11
         Mw49pHRQT+01Bbv0pNRARMW0kuNSRSjCU7Vv5uvoLUtJX5rvrpiS0/l6cR6CsO7rE3Bd
         B8Zg==
X-Gm-Message-State: AOAM533cnbFvZnriKPHc9zGJBPcKyZnwnZtdyAXl/uDKbIokb9PIaJQ5
        i02Uk5SeBxdWkAirR91HwyI=
X-Google-Smtp-Source: ABdhPJz5JUgg4qSqvAwHhqLYwvi75qk/LgnQ0y/YoAV85a6MiiElLqEv7XKESfIx3dR3vKAV/8gKWg==
X-Received: by 2002:a17:90b:1c8e:b0:1bf:364c:dd7a with SMTP id oo14-20020a17090b1c8e00b001bf364cdd7amr437898pjb.103.1646426939521;
        Fri, 04 Mar 2022 12:48:59 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id s2-20020a056a001c4200b004f41e1196fasm6577543pfw.17.2022.03.04.12.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:48:59 -0800 (PST)
Date:   Sat, 5 Mar 2022 02:18:56 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/8] bpf: Harden register offset checks for
 release helpers and kfuncs
Message-ID: <20220304204856.7pplkvhl57sxtnwz@apollo.legion>
References: <20220304000508.2904128-1-memxor@gmail.com>
 <20220304000508.2904128-5-memxor@gmail.com>
 <20220304202830.4zgw6h5ulddx3zns@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304202830.4zgw6h5ulddx3zns@kafai-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 05, 2022 at 01:58:30AM IST, Martin KaFai Lau wrote:
> On Fri, Mar 04, 2022 at 05:35:04AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Let's ensure that the PTR_TO_BTF_ID reg being passed in to release BPF
> > helpers and kfuncs always has its offset set to 0. While not a real
> > problem now, there's a very real possibility this will become a problem
> > when more and more kfuncs are exposed, and more BPF helpers are added
> > which can release PTR_TO_BTF_ID.
> >
> > Previous commits already protected against non-zero var_off. One of the
> > case we are concerned about now is when we have a type that can be
> > returned by e.g. an acquire kfunc:
> >
> > struct foo {
> > 	int a;
> > 	int b;
> > 	struct bar b;
> > };
> >
> > ... and struct bar is also a type that can be returned by another
> > acquire kfunc.
> >
> > Then, doing the following sequence:
> >
> > 	struct foo *f = bpf_get_foo(); // acquire kfunc
> > 	if (!f)
> > 		return 0;
> > 	bpf_put_bar(&f->b); // release kfunc
> >
> > ... would work with the current code, since the btf_struct_ids_match
> > takes reg->off into account for matching pointer type with release kfunc
> > argument type, but would obviously be incorrect, and most likely lead to
> > a kernel crash. A test has been included later to prevent regressions in
> > this area.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  3 ++-
> >  kernel/bpf/btf.c             | 13 +++++++++----
> >  kernel/bpf/verifier.c        | 27 +++++++++++++++++++++++----
> >  3 files changed, 34 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 38b24ee8d8c2..7a684050495a 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -523,7 +523,8 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
> >  		      const struct bpf_reg_state *reg, int regno);
> >  int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  			   const struct bpf_reg_state *reg, int regno,
> > -			   enum bpf_arg_type arg_type);
> > +			   enum bpf_arg_type arg_type,
> > +			   bool is_release_function);
> >  int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> >  			     u32 regno);
> >  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 7f6a0ae5028b..c9a1019dc60d 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5753,6 +5753,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  		return -EINVAL;
> >  	}
> >
> > +	if (is_kfunc)
> > +		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> > +						BTF_KFUNC_TYPE_RELEASE, func_id);
> >  	/* check that BTF function arguments match actual types that the
> >  	 * verifier sees.
> >  	 */
> > @@ -5777,7 +5780,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
> >  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
> >
> > -		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
> > +		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE, rel);
> >  		if (ret < 0)
> >  			return ret;
> >
> > @@ -5809,7 +5812,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  			if (reg->type == PTR_TO_BTF_ID) {
> >  				reg_btf = reg->btf;
> >  				reg_ref_id = reg->btf_id;
> > -				/* Ensure only one argument is referenced PTR_TO_BTF_ID */
> > +				/* Ensure only one argument is referenced
> > +				 * PTR_TO_BTF_ID, check_func_arg_reg_off relies
> > +				 * on only one referenced register being allowed
> > +				 * for kfuncs.
> > +				 */
> >  				if (reg->ref_obj_id) {
> >  					if (ref_obj_id) {
> >  						bpf_log(log, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> > @@ -5892,8 +5899,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  	/* Either both are set, or neither */
> >  	WARN_ON_ONCE((ref_obj_id && !ref_regno) || (!ref_obj_id && ref_regno));
> >  	if (is_kfunc) {
> This test is no longer needed?
>

If you mean the rel && !ref_obj_id below (which is guarded by this check), I do
think it is needed, why do you think so? Because of the check in
check_func_arg_reg_off? That only checks reg->off when it sees that both
release_func and ref_obj_id are true, but ref_obj_id may not be set for any
argument(s) passed to a release function, so we need to reject when we don't get
atleast one referenced register for release function.

Or were you referring to the WARN_ON_ONCE above it?

> > -		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
> > -						BTF_KFUNC_TYPE_RELEASE, func_id);
> >  		/* We already made sure ref_obj_id is set only for one argument */
> >  		if (rel && !ref_obj_id) {
> >  			bpf_log(log, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e55bfd23e81b..c31407d156e7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5367,11 +5367,28 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >
> >  int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  			   const struct bpf_reg_state *reg, int regno,
> > -			   enum bpf_arg_type arg_type)
> > +			   enum bpf_arg_type arg_type,
> > +			   bool is_release_func)
> >  {
> >  	enum bpf_reg_type type = reg->type;
> > +	bool fixed_off_ok = false;
> >  	int err;
> >
> > +	/* When referenced PTR_TO_BTF_ID is passed to release function, it's
> > +	 * fixed offset must be 0. We rely on the property that only one
> > +	 * referenced register can be passed to BPF helpers and kfuncs.
> > +	 */
> > +	if (type == PTR_TO_BTF_ID) {
> > +		bool release_reg = is_release_func && reg->ref_obj_id;
> > +
> > +		if (release_reg && reg->off) {
> iiuc, the reason for not going through __check_ptr_off_reg() is
> because it prefers a different verifier log message for release_reg
> case for fixed off.  How about var_off?
>

If reg->off is zero, we still call __check_ptr_off_reg with fixed_off_ok =
false, which should handle non-zero var_off.

> > +			verbose(env, "R%d must have zero offset when passed to release func\n",
> > +				regno);
> > +			return -EINVAL;
> > +		}
> > +		fixed_off_ok = release_reg ? false : true;
> nit.
> 		fixed_off_ok = !release_reg;
>
> but this is a bit moot here considering the reg->off
> check has already been done for the release_reg case.
>

Yes, it would be a redundant check inside __check_ptr_off_reg, but we still need
to call it for checking bad var_off.

> > +	}
> > +
> >  	switch ((u32)type) {
> >  	case SCALAR_VALUE:
> >  	/* Pointer types where reg offset is explicitly allowed: */
> > @@ -5394,8 +5411,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  	/* All the rest must be rejected: */
> >  	default:
> >  force_off_check:
> > -		err = __check_ptr_off_reg(env, reg, regno,
> > -					  type == PTR_TO_BTF_ID);
> > +		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> >  		if (err < 0)
> >  			return err;
> >  		break;
> > @@ -5452,11 +5468,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >  	if (err)
> >  		return err;
> >
> > -	err = check_func_arg_reg_off(env, reg, regno, arg_type);
> > +	err = check_func_arg_reg_off(env, reg, regno, arg_type, is_release_function(meta->func_id));
> >  	if (err)
> >  		return err;
> >
> >  skip_type_check:
> > +	/* check_func_arg_reg_off relies on only one referenced register being
> > +	 * allowed for BPF helpers.
> > +	 */
> >  	if (reg->ref_obj_id) {
> >  		if (meta->ref_obj_id) {
> >  			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> > --
> > 2.35.1
> >

--
Kartikeya
