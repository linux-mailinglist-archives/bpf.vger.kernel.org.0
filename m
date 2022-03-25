Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6384E7580
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351553AbiCYO6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbiCYO6i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 10:58:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0826C52E42
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:57:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c23so8304700plo.0
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ckddkhYGSwJjQQNyOevqezIBOoRFXRGmwAx6K/ttG5g=;
        b=GNIzjboYHCkYKZ5YxTNCp8+DSjqcS/l83h3uDUYegbhNjyg20GhoibXTtv1pbFCVhW
         Sq1w4jw/9s0vPwUt5itYBfp8d9Iaahw8bfoC35J8AKfuJsZ4qh9onEn6x81lT10REWn6
         d2kAV6uoMf3HbM7qgSJZbgBifzMSlFBbTm9I3npqFeofd9ms9L9DYSMDbvYK5ruUllt5
         PwVTPLX5/FL8q9y0N3JoaKrsW4PvVIOkuCfT1Ot9OEMlWI3SLSqAiv4E58K3Dm5qbt7J
         TupdlPaeNBCiYBtMpDAhLGe+ZaF6FlofcbiKa1ZvJ+EdgIXORIrxd9oXwNNa9Gc2Pzv5
         1spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ckddkhYGSwJjQQNyOevqezIBOoRFXRGmwAx6K/ttG5g=;
        b=69s5WPBttUeTuKmjgRXXynS3mdStIux6xizMP95yO3ilEgLWnvHv74v3CMZ3YhK11r
         Tq988Q0gJnpvb65iejdnIBNrWGo609TIR0JeIYZ+WNAimLAxJ5l9m+gv5WBOBq1m1bbH
         +z5acnND2oiiDYqSdw4PDsiIQBg6tV85MBTshQmZBHDmttcjhHzcKWRxuLiymQrRdqEF
         Vvvhu+Q5hHI0K/hMHoWV31yV6jxI/SWMac+X/mfv4hwQgXHMfXVEi47Gj61qzkildBU8
         plhxwM/lGZahiw25M0NvS0HH0kp3j+2DYQRaMbSG25RuoV1Fsc9BJKGSGptJ7zfdJyNa
         uOog==
X-Gm-Message-State: AOAM531949AiRya1LMeFcswzs9Iu1QAe0xSoUUWNRY36BS8CnGADRAId
        nNG0BnTaCfP6VFb6MX3fWWIU3h+ccmQ=
X-Google-Smtp-Source: ABdhPJwsJ7bk2PRXbU63sMa5gav8ZOeEyZLfCpl0q50vahkHkhspjA6YIwgp3dRCzPvaDn/f4CfrcA==
X-Received: by 2002:a17:90b:4b0d:b0:1bc:4cdb:ebe3 with SMTP id lx13-20020a17090b4b0d00b001bc4cdbebe3mr13039020pjb.176.1648220223512;
        Fri, 25 Mar 2022 07:57:03 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id rj13-20020a17090b3e8d00b001c77bc09541sm10231841pjb.51.2022.03.25.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 07:57:03 -0700 (PDT)
Date:   Fri, 25 Mar 2022 20:27:00 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 05/13] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220325145700.li3ap2nii52qeyr6@apollo>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-6-memxor@gmail.com>
 <20220322205912.h3pd4qc36zn2uepp@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322205912.h3pd4qc36zn2uepp@kafai-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 23, 2022 at 02:29:12AM IST, Martin KaFai Lau wrote:
> On Sun, Mar 20, 2022 at 09:25:02PM +0530, Kumar Kartikeya Dwivedi wrote:
> >  static int map_kptr_match_type(struct bpf_verifier_env *env,
> >  			       struct bpf_map_value_off_desc *off_desc,
> > -			       struct bpf_reg_state *reg, u32 regno)
> > +			       struct bpf_reg_state *reg, u32 regno,
> > +			       bool ref_ptr)
> >  {
> >  	const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
> >  	const char *reg_name = "";
> > +	bool fixed_off_ok = true;
> >
> >  	if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
> >  		goto bad_type;
> > @@ -3525,7 +3530,26 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
> >  	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
> >  	reg_name = kernel_type_name(reg->btf, reg->btf_id);
> >
> > -	if (__check_ptr_off_reg(env, reg, regno, true))
> > +	if (ref_ptr) {
> > +		if (!reg->ref_obj_id) {
> > +			verbose(env, "R%d must be referenced %s%s\n", regno,
> > +				reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> > +			return -EACCES;
> > +		}
> The is_release_function() checkings under check_helper_call() is
> not the same?
>
> > +		/* reg->off can be used to store pointer to a certain type formed by
> > +		 * incrementing pointer of a parent structure the object is embedded in,
> > +		 * e.g. map may expect unreferenced struct path *, and user should be
> > +		 * allowed a store using &file->f_path. However, in the case of
> > +		 * referenced pointer, we cannot do this, because the reference is only
> > +		 * for the parent structure, not its embedded object(s), and because
> > +		 * the transfer of ownership happens for the original pointer to and
> > +		 * from the map (before its eventual release).
> > +		 */
> > +		if (reg->off)
> > +			fixed_off_ok = false;
> I thought the new check_func_arg_reg_off() is supposed to handle the
> is_release_function() case.  The check_func_arg_reg_off() called
> in check_func_arg() can not handle this case?
>

The difference there is, it wouldn't check for reg->off == 0 if reg->ref_obj_id
is 0. So in that case, I should probably check reg->ref_obj_id to be non-zero
when ref_ptr is true, and then call check_func_arg_reg_off, with the comment
that this would eventually be an argument to the release function, so the
argument should be checked with check_func_arg_reg_off.

> > +	}
> > +	/* var_off is rejected by __check_ptr_off_reg for PTR_TO_BTF_ID */
> > +	if (__check_ptr_off_reg(env, reg, regno, fixed_off_ok))
> >  		return -EACCES;
> >
> >  	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
>
> [ ... ]
>
> > @@ -5390,6 +5473,7 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> >  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> >  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> >  static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
> > +static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
> >
> >  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> >  	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
> > @@ -5417,11 +5501,13 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> >  	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
> >  	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
> >  	[ARG_PTR_TO_TIMER]		= &timer_types,
> > +	[ARG_PTR_TO_KPTR]		= &kptr_types,
> >  };
> >
> >  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >  			  enum bpf_arg_type arg_type,
> > -			  const u32 *arg_btf_id)
> > +			  const u32 *arg_btf_id,
> > +			  struct bpf_call_arg_meta *meta)
> >  {
> >  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> >  	enum bpf_reg_type expected, type = reg->type;
> > @@ -5474,8 +5560,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >  			arg_btf_id = compatible->btf_id;
> >  		}
> >
> > -		if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > -					  btf_vmlinux, *arg_btf_id)) {
> > +		if (meta->func_id == BPF_FUNC_kptr_xchg) {
> > +			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno, true))
> > +				return -EACCES;
> > +		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > +						 btf_vmlinux, *arg_btf_id)) {
> >  			verbose(env, "R%d is of type %s but %s is expected\n",
> >  				regno, kernel_type_name(reg->btf, reg->btf_id),
> >  				kernel_type_name(btf_vmlinux, *arg_btf_id));

--
Kartikeya
