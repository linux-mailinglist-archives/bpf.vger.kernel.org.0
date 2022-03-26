Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDF4E7E52
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 02:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiCZBDj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCZBDi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 21:03:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7191A70923
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 18:02:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id v4so9051299pjh.2
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 18:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FLrvnmgFS4Kt95QEaia5CfUSzH2uOfnvl7mkCfWyvGI=;
        b=LRahnxDFjxHGIabKDOh6GVEBUWP4XjX2jdzckC16fswn1643SNfU3YmYG41j1lLjiG
         MsSh1z3ofrUV5kkx2ZZAtLO1nzILP61HLXiu9w1gMK/MtDGTzmAB4S1KBjhnor/WwT5t
         3vcEGlKiOC9/A2U1Ug9x8N4TB01J/atHpVy2CVCGd2hHaJ2j/aYS0aCV2Ovy0DL/ydV+
         ka4Rf+cHrtcv1YOeQXBlFYF0207vUCG0ysUDem8OcaZYU5jb1xT37afLOmn9pwWtYnJ2
         DRvhvE9OD1uO8pEh8DzdmxFiGgJK0WnsaXGfIpazj61x5Tda92kiPR/WGKyOGaXxqwMj
         ng7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FLrvnmgFS4Kt95QEaia5CfUSzH2uOfnvl7mkCfWyvGI=;
        b=1U0wLoyIUmj6/Eg8q/6j7M3nTN0aWC+GdAgJyAcDq0xqTv5fxJZI/S3dVgog3OmYhv
         Vm8PAU+VZUS5UvCDSW7pBd2Xv+1Al47/c8oe5/ts1Z1ykIwTBucnQ/MU/x5SxxS8RyUn
         GjsdUp+6EudxLRH0aB2l01RNbqA85YY7oKGRrg6gOIVRTpCm4oGRzOifaUKue82O9LL8
         u4GNAZIzLof1x+2wMW5shK2xnaLfcjhbJf4HYPoQHV0/EtfzmXgkdx4+mknJ/hDa98qn
         9Evv0h+iHY4pNvlJDW5RG+WjT9ts8k1EC613jkvwEC1Ik1fsq82Emtss2AcMK+6jBq4M
         VkQw==
X-Gm-Message-State: AOAM532agsckTVm2+lF8tP6BPWtzkyJ81oYa1e4COw3jrGN5n5DtSVfZ
        doPsMzNlptU8DjHpkNLi2BEwC1f2CaE=
X-Google-Smtp-Source: ABdhPJxLKZDuVCuhCwZ19Alj0xNbdlx7ikEtOYzmWYQmcnJazZhheZ+s2lZd3IT7hTvO5AulbmGa+w==
X-Received: by 2002:a17:90a:1d05:b0:1bf:6a85:fbf5 with SMTP id c5-20020a17090a1d0500b001bf6a85fbf5mr15389881pjd.205.1648256522729;
        Fri, 25 Mar 2022 18:02:02 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id c9-20020a056a00248900b004fb05c0f32bsm4530483pfv.185.2022.03.25.18.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 18:02:02 -0700 (PDT)
Date:   Sat, 26 Mar 2022 06:31:59 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 05/13] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220326010159.sw3qxtdnaiq4bm6y@apollo>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-6-memxor@gmail.com>
 <20220322205912.h3pd4qc36zn2uepp@kafai-mbp.dhcp.thefacebook.com>
 <20220325145700.li3ap2nii52qeyr6@apollo>
 <20220325233952.y4qdfivjlfgrx3x7@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325233952.y4qdfivjlfgrx3x7@kafai-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 26, 2022 at 05:09:52AM IST, Martin KaFai Lau wrote:
> On Fri, Mar 25, 2022 at 08:27:00PM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Wed, Mar 23, 2022 at 02:29:12AM IST, Martin KaFai Lau wrote:
> > > On Sun, Mar 20, 2022 at 09:25:02PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > >  static int map_kptr_match_type(struct bpf_verifier_env *env,
> > > >  			       struct bpf_map_value_off_desc *off_desc,
> > > > -			       struct bpf_reg_state *reg, u32 regno)
> > > > +			       struct bpf_reg_state *reg, u32 regno,
> > > > +			       bool ref_ptr)
> > > >  {
> > > >  	const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
> > > >  	const char *reg_name = "";
> > > > +	bool fixed_off_ok = true;
> > > >
> > > >  	if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
> > > >  		goto bad_type;
> > > > @@ -3525,7 +3530,26 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
> > > >  	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
> > > >  	reg_name = kernel_type_name(reg->btf, reg->btf_id);
> > > >
> > > > -	if (__check_ptr_off_reg(env, reg, regno, true))
> > > > +	if (ref_ptr) {
> > > > +		if (!reg->ref_obj_id) {
> > > > +			verbose(env, "R%d must be referenced %s%s\n", regno,
> > > > +				reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> > > > +			return -EACCES;
> > > > +		}
> > > The is_release_function() checkings under check_helper_call() is
> > > not the same?
> > >
> > > > +		/* reg->off can be used to store pointer to a certain type formed by
> > > > +		 * incrementing pointer of a parent structure the object is embedded in,
> > > > +		 * e.g. map may expect unreferenced struct path *, and user should be
> > > > +		 * allowed a store using &file->f_path. However, in the case of
> > > > +		 * referenced pointer, we cannot do this, because the reference is only
> > > > +		 * for the parent structure, not its embedded object(s), and because
> > > > +		 * the transfer of ownership happens for the original pointer to and
> > > > +		 * from the map (before its eventual release).
> > > > +		 */
> > > > +		if (reg->off)
> > > > +			fixed_off_ok = false;
> > > I thought the new check_func_arg_reg_off() is supposed to handle the
> > > is_release_function() case.  The check_func_arg_reg_off() called
> > > in check_func_arg() can not handle this case?
> > >
> >
> > The difference there is, it wouldn't check for reg->off == 0 if reg->ref_obj_id
> > is 0.
> If ref_obj_id is not 0, check_func_arg_reg_off() will reject reg->off.
> check_func_arg_reg_off is called after check_reg_type().
>
> If ref_obj_id is 0, the is_release_function() check in the
> check_helper_call() should complain:
> 	verbose(env, "func %s#%d reference has not been acquired before\n",
> 		func_id_name(func_id), func_id);
>
> I am quite confused why it needs special reg->off and
> reg->ref_obj_id checking here for the map_kptr helper taking
> PTR_TO_BTF_ID arg but not other helper taking PTR_TO_BTF_ID arg.
> The existing checks for the other helper taking PTR_TO_BTF_ID
> arg is not enough?
>

Yes, you're right, it should be enough. We just need to check for the normal
case here, with fixed_off_ok = true, since that can come from BPF_STX. In the
referenced case, earlier it was also possible to store using BPF_XCHG, but not
anymore, so now the checks for the helper should be enough, and complain.

Will drop this in v4, and just keep __check_ptr_off_reg(env, reg, regno, false).

> > So in that case, I should probably check reg->ref_obj_id to be non-zero
> > when ref_ptr is true, and then call check_func_arg_reg_off, with the comment
> > that this would eventually be an argument to the release function, so the
> > argument should be checked with check_func_arg_reg_off.
>
>
>
> >
> > > > +	}
> > > > +	/* var_off is rejected by __check_ptr_off_reg for PTR_TO_BTF_ID */
> > > > +	if (__check_ptr_off_reg(env, reg, regno, fixed_off_ok))
> > > >  		return -EACCES;
> > > >
> > > >  	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > >
> > > [ ... ]
> > >
> > > > @@ -5390,6 +5473,7 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> > > >  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> > > >  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> > > >  static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
> > > > +static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
> > > >
> > > >  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> > > >  	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
> > > > @@ -5417,11 +5501,13 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> > > >  	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
> > > >  	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
> > > >  	[ARG_PTR_TO_TIMER]		= &timer_types,
> > > > +	[ARG_PTR_TO_KPTR]		= &kptr_types,
> > > >  };
> > > >
> > > >  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > > >  			  enum bpf_arg_type arg_type,
> > > > -			  const u32 *arg_btf_id)
> > > > +			  const u32 *arg_btf_id,
> > > > +			  struct bpf_call_arg_meta *meta)
> > > >  {
> > > >  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > > >  	enum bpf_reg_type expected, type = reg->type;
> > > > @@ -5474,8 +5560,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > > >  			arg_btf_id = compatible->btf_id;
> > > >  		}
> > > >
> > > > -		if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > > > -					  btf_vmlinux, *arg_btf_id)) {
> > > > +		if (meta->func_id == BPF_FUNC_kptr_xchg) {
> > > > +			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno, true))
> > > > +				return -EACCES;
> > > > +		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > > > +						 btf_vmlinux, *arg_btf_id)) {
> > > >  			verbose(env, "R%d is of type %s but %s is expected\n",
> > > >  				regno, kernel_type_name(reg->btf, reg->btf_id),
> > > >  				kernel_type_name(btf_vmlinux, *arg_btf_id));
> >
> > --
> > Kartikeya

--
Kartikeya
