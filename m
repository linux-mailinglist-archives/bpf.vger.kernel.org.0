Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056D150A957
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 21:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392017AbiDUTkr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 15:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiDUTkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 15:40:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274B14D610
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 12:37:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b7so6005190plh.2
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xbKcP2n+KKHe0KuXM+MHTiO3aMd+ibCJYpv3/sidTXs=;
        b=GlDZASRsTYubOHS2fVsr6caAhWt6Fr3gO5KhEzVhQBBBL+X5tBxKZOnZWF3wzrmE38
         g75XEijJxs9upEJCeQ6KHH/JWYb7DrMTJnJdfPT+OKUeNcgTfRR20wbDjoRXfVnkXJn+
         Mh3MUeBd9P+qaVCCxvha3AUyl9WFOnihYJY/4lSxlZWPyT/iu0Wbr4t5J1VcDewEBMQK
         HmkjhquNPEnYWmBYyNf6hu3G3c+q2GiYwa31sX0gbwVG+0QFAeJpG07valfa2LkubEkI
         gIK47VSoan5wC0gDaaBO49soTKodKc+WsAgE/FGkjVTUl40iIBzPq2hd9gSPIOzc5bp1
         Le0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xbKcP2n+KKHe0KuXM+MHTiO3aMd+ibCJYpv3/sidTXs=;
        b=eE5cdUxj/SnpICOyQwIPDO9U9IQl5saxJgGLUlrFCmKtOjdEnEKG6T1vp3GWKwQO4P
         DFFeu3URLfVf5V3kfwBURbUSUjoFAT2ejRsQdQIqJlFVruae6DRt92zL4Z3iQ8xI0erD
         IbJyd5nHprgnEXcI40oNktRi0znH41emkBEi4LBMYONMgkiSKhVm62spVdwWg4nr6NA1
         5UMscKqqOnQhwLqabau10Hin9XX8ozC+1/83XeA1qHIch2ANVAI0dAOIsYKRe6RLDUlK
         8Fx5uj9CD7P30gFO4mbUcSCpDEBZTfCzcd/4iZbCvuvj1rGegvOBEN+ws4mVTZkylbUj
         wZgg==
X-Gm-Message-State: AOAM533tczo6Dyay7TZSsmi+x6q5rmybyFM4z0y+GHK3ns6IOb+RcCKs
        mk5kYQEPMJLG6oDYen4pYXc=
X-Google-Smtp-Source: ABdhPJxkZuW0svRe82wB+leOHA9DorktMjE4ZVXPaUKOPoaXo0xfomXtgz41xRxEstPnkjWTiZZqCw==
X-Received: by 2002:a17:902:a585:b0:14d:58ef:65 with SMTP id az5-20020a170902a58500b0014d58ef0065mr998461plb.139.1650569875493;
        Thu, 21 Apr 2022 12:37:55 -0700 (PDT)
Received: from localhost ([157.49.241.21])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a710900b001cd4989fecdsm3563263pjk.25.2022.04.21.12.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:37:54 -0700 (PDT)
Date:   Fri, 22 Apr 2022 01:08:08 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v5 04/13] bpf: Tag argument to be released in
 bpf_func_proto
Message-ID: <20220421193808.iojehohmhvrcssjb@apollo.legion>
References: <20220415160354.1050687-1-memxor@gmail.com>
 <20220415160354.1050687-5-memxor@gmail.com>
 <20220421041954.3hdxqu7zcxfhiecs@MBP-98dd607d3435.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421041954.3hdxqu7zcxfhiecs@MBP-98dd607d3435.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 09:49:54AM IST, Alexei Starovoitov wrote:
> On Fri, Apr 15, 2022 at 09:33:45PM +0530, Kumar Kartikeya Dwivedi wrote:
> > Add a new type flag for bpf_arg_type that when set tells verifier that
> > for a release function, that argument's register will be the one for
> > which meta.ref_obj_id will be set, and which will then be released
> > using release_reference. To capture the regno, introduce a new field
> > release_regno in bpf_call_arg_meta.
> >
> > This would be required in the next patch, where we may either pass NULL
> > or a refcounted pointer as an argument to the release function
> > bpf_kptr_xchg. Just releasing only when meta.ref_obj_id is set is not
> > enough, as there is a case where the type of argument needed matches,
> > but the ref_obj_id is set to 0. Hence, we must enforce that whenever
> > meta.ref_obj_id is zero, the register that is to be released can only
> > be NULL for a release function.
> >
> > Since we now indicate whether an argument is to be released in
> > bpf_func_proto itself, is_release_function helper has lost its utitlity,
> > hence refactor code to work without it, and just rely on
> > meta.release_regno to know when to release state for a ref_obj_id.
> > Still, the restriction of one release argument and only one ref_obj_id
> > passed to BPF helper or kfunc remains. This may be lifted in the future.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h                           |  5 +-
> >  include/linux/bpf_verifier.h                  |  3 +-
> >  kernel/bpf/btf.c                              |  9 ++-
> >  kernel/bpf/ringbuf.c                          |  4 +-
> >  kernel/bpf/verifier.c                         | 76 +++++++++++--------
> >  net/core/filter.c                             |  2 +-
> >  .../selftests/bpf/verifier/ref_tracking.c     |  2 +-
> >  tools/testing/selftests/bpf/verifier/sock.c   |  6 +-
> >  8 files changed, 60 insertions(+), 47 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index ab86f4675db2..f73a3f10e654 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -366,7 +366,10 @@ enum bpf_type_flag {
> >  	 */
> >  	MEM_PERCPU		= BIT(4 + BPF_BASE_TYPE_BITS),
> >
> > -	__BPF_TYPE_LAST_FLAG	= MEM_PERCPU,
> > +	/* Indicates that the pointer argument will be released. */
> > +	PTR_RELEASE		= BIT(5 + BPF_BASE_TYPE_BITS),
>
> I think OBJ_RELEASE as Joanne did it in her patch is a better name.
>
> "pointer release" is not quite correct.
> It's an object that pointer is pointing to will be released.
>

Ok, will rename.

> > +
> > +	__BPF_TYPE_LAST_FLAG	= PTR_RELEASE,
> >  };
> >
> >  /* Max number of base types. */
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 3a9d2d7cc6b7..1f1e7f2ea967 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -523,8 +523,7 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
> >  		      const struct bpf_reg_state *reg, int regno);
> >  int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  			   const struct bpf_reg_state *reg, int regno,
> > -			   enum bpf_arg_type arg_type,
> > -			   bool is_release_func);
> > +			   enum bpf_arg_type arg_type);
> >  int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> >  			     u32 regno);
> >  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index be191df76ea4..7227a77a02f7 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5993,6 +5993,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  	 * verifier sees.
> >  	 */
> >  	for (i = 0; i < nargs; i++) {
> > +		enum bpf_arg_type arg_type = ARG_DONTCARE;
> >  		u32 regno = i + 1;
> >  		struct bpf_reg_state *reg = &regs[regno];
> >
> > @@ -6013,7 +6014,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
> >  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
> >
> > -		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE, rel);
> > +		if (rel && reg->ref_obj_id)
> > +			arg_type |= PTR_RELEASE;
>
> Don't get it. Why ?
>

It uses arg_type_is_release_ptr, so to indicate this is release argument we set
this flag.

> > +		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
> >  		if (ret < 0)
> >  			return ret;
> >
> > @@ -6046,9 +6049,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  				reg_btf = reg->btf;
> >  				reg_ref_id = reg->btf_id;
> >  				/* Ensure only one argument is referenced
> > -				 * PTR_TO_BTF_ID, check_func_arg_reg_off relies
> > -				 * on only one referenced register being allowed
> > -				 * for kfuncs.
> > +				 * PTR_TO_BTF_ID.
>
> /* Ensure only one argument is referenced PTR_TO_BTF_ID.
>

Ok.

> >  				 */
> >  				if (reg->ref_obj_id) {
> >  					if (ref_obj_id) {
> > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > index 710ba9de12ce..a22c21c0a7ef 100644
> > --- a/kernel/bpf/ringbuf.c
> > +++ b/kernel/bpf/ringbuf.c
> > @@ -404,7 +404,7 @@ BPF_CALL_2(bpf_ringbuf_submit, void *, sample, u64, flags)
> >  const struct bpf_func_proto bpf_ringbuf_submit_proto = {
> >  	.func		= bpf_ringbuf_submit,
> >  	.ret_type	= RET_VOID,
> > -	.arg1_type	= ARG_PTR_TO_ALLOC_MEM,
> > +	.arg1_type	= ARG_PTR_TO_ALLOC_MEM | PTR_RELEASE,
> >  	.arg2_type	= ARG_ANYTHING,
> >  };
> >
> > @@ -417,7 +417,7 @@ BPF_CALL_2(bpf_ringbuf_discard, void *, sample, u64, flags)
> >  const struct bpf_func_proto bpf_ringbuf_discard_proto = {
> >  	.func		= bpf_ringbuf_discard,
> >  	.ret_type	= RET_VOID,
> > -	.arg1_type	= ARG_PTR_TO_ALLOC_MEM,
> > +	.arg1_type	= ARG_PTR_TO_ALLOC_MEM | PTR_RELEASE,
> >  	.arg2_type	= ARG_ANYTHING,
> >  };
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c802e51c4e18..97f88d06f848 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -245,6 +245,7 @@ struct bpf_call_arg_meta {
> >  	struct bpf_map *map_ptr;
> >  	bool raw_mode;
> >  	bool pkt_access;
> > +	u8 release_regno;
> >  	int regno;
>
> release_regno and regno are always equal.
> Why go with u8 instead of bool flag?
>

Didn't realise that. I will change it.

> >  	int access_size;
> >  	int mem_size;
> > @@ -471,17 +472,6 @@ static bool type_may_be_null(u32 type)
> >  	return type & PTR_MAYBE_NULL;
> >  }
> >
> > -/* Determine whether the function releases some resources allocated by another
> > - * function call. The first reference type argument will be assumed to be
> > - * released by release_reference().
> > - */
> > -static bool is_release_function(enum bpf_func_id func_id)
> > -{
> > -	return func_id == BPF_FUNC_sk_release ||
> > -	       func_id == BPF_FUNC_ringbuf_submit ||
> > -	       func_id == BPF_FUNC_ringbuf_discard;
> > -}
> > -
> >  static bool may_be_acquire_function(enum bpf_func_id func_id)
> >  {
> >  	return func_id == BPF_FUNC_sk_lookup_tcp ||
> > @@ -5304,6 +5294,11 @@ static bool arg_type_is_int_ptr(enum bpf_arg_type type)
> >  	       type == ARG_PTR_TO_LONG;
> >  }
> >
> > +static bool arg_type_is_release_ptr(enum bpf_arg_type type)
>
> arg_type_is_relase() ?
>

Ok.

> > +{
> > +	return type & PTR_RELEASE;
> > +}
> > +
> >  static int int_ptr_type_to_size(enum bpf_arg_type type)
> >  {
> >  	if (type == ARG_PTR_TO_INT)
> > @@ -5514,11 +5509,10 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >
> >  int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  			   const struct bpf_reg_state *reg, int regno,
> > -			   enum bpf_arg_type arg_type,
> > -			   bool is_release_func)
> > +			   enum bpf_arg_type arg_type)
> >  {
> > -	bool fixed_off_ok = false, release_reg;
> >  	enum bpf_reg_type type = reg->type;
> > +	bool fixed_off_ok = false;
> >
> >  	switch ((u32)type) {
> >  	case SCALAR_VALUE:
> > @@ -5536,7 +5530,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  		/* Some of the argument types nevertheless require a
> >  		 * zero register offset.
> >  		 */
> > -		if (arg_type != ARG_PTR_TO_ALLOC_MEM)
> > +		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
> >  			return 0;
> >  		break;
> >  	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
> > @@ -5544,19 +5538,17 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  	 */
> >  	case PTR_TO_BTF_ID:
> >  		/* When referenced PTR_TO_BTF_ID is passed to release function,
> > -		 * it's fixed offset must be 0. We rely on the property that
> > -		 * only one referenced register can be passed to BPF helpers and
> > -		 * kfuncs. In the other cases, fixed offset can be non-zero.
> > +		 * it's fixed offset must be 0.	In the other cases, fixed offset
> > +		 * can be non-zero.
> >  		 */
> > -		release_reg = is_release_func && reg->ref_obj_id;
> > -		if (release_reg && reg->off) {
> > +		if (arg_type_is_release_ptr(arg_type) && reg->off) {
> >  			verbose(env, "R%d must have zero offset when passed to release func\n",
> >  				regno);
> >  			return -EINVAL;
> >  		}
> > -		/* For release_reg == true, fixed_off_ok must be false, but we
> > -		 * already checked and rejected reg->off != 0 above, so set to
> > -		 * true to allow fixed offset for all other cases.
> > +		/* For arg is release pointer, fixed_off_ok must be false, but
> > +		 * we already checked and rejected reg->off != 0 above, so set
> > +		 * to true to allow fixed offset for all other cases.
> >  		 */
> >  		fixed_off_ok = true;
> >  		break;
> > @@ -5615,14 +5607,24 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >  	if (err)
> >  		return err;
> >
> > -	err = check_func_arg_reg_off(env, reg, regno, arg_type, is_release_function(meta->func_id));
> > +	err = check_func_arg_reg_off(env, reg, regno, arg_type);
> >  	if (err)
> >  		return err;
> >
> >  skip_type_check:
> > -	/* check_func_arg_reg_off relies on only one referenced register being
> > -	 * allowed for BPF helpers.
> > -	 */
> > +	if (arg_type_is_release_ptr(arg_type)) {
> > +		if (!reg->ref_obj_id && !register_is_null(reg)) {
> > +			verbose(env, "R%d must be referenced when passed to release function\n",
> > +				regno);
> > +			return -EINVAL;
> > +		}
> > +		if (meta->release_regno) {
> > +			verbose(env, "verifier internal error: more than one release argument\n");
> > +			return -EFAULT;
> > +		}
> > +		meta->release_regno = regno;
> > +	}
> > +
> >  	if (reg->ref_obj_id) {
> >  		if (meta->ref_obj_id) {
> >  			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> > @@ -6129,7 +6131,8 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
> >  	return true;
> >  }
> >
> > -static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
> > +static int check_func_proto(const struct bpf_func_proto *fn, int func_id,
> > +			    struct bpf_call_arg_meta *meta)
> >  {
> >  	return check_raw_mode_ok(fn) &&
> >  	       check_arg_pair_ok(fn) &&
> > @@ -6813,7 +6816,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >  	memset(&meta, 0, sizeof(meta));
> >  	meta.pkt_access = fn->pkt_access;
> >
> > -	err = check_func_proto(fn, func_id);
> > +	err = check_func_proto(fn, func_id, &meta);
> >  	if (err) {
> >  		verbose(env, "kernel subsystem misconfigured func %s#%d\n",
> >  			func_id_name(func_id), func_id);
> > @@ -6846,8 +6849,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >  			return err;
> >  	}
> >
> > -	if (is_release_function(func_id)) {
> > -		err = release_reference(env, meta.ref_obj_id);
> > +	regs = cur_regs(env);
> > +
> > +	if (meta.release_regno) {
> > +		err = -EINVAL;
> > +		if (meta.ref_obj_id)
> > +			err = release_reference(env, meta.ref_obj_id);
> > +		/* meta.ref_obj_id can only be 0 if register that is meant to be
> > +		 * released is NULL, which must be > R0.
> > +		 */
> > +		else if (register_is_null(&regs[meta.release_regno]))
> > +			err = 0;
> >  		if (err) {
> >  			verbose(env, "func %s#%d reference has not been acquired before\n",
> >  				func_id_name(func_id), func_id);
> > @@ -6855,8 +6867,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >  		}
> >  	}
> >
> > -	regs = cur_regs(env);
> > -
> >  	switch (func_id) {
> >  	case BPF_FUNC_tail_call:
> >  		err = check_reference_leak(env);
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 143f442a9505..8eb01a997476 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -6621,7 +6621,7 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
> >  	.func		= bpf_sk_release,
> >  	.gpl_only	= false,
> >  	.ret_type	= RET_INTEGER,
> > -	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> > +	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON | PTR_RELEASE,
> >  };
> >
> >  BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
> > diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> > index fbd682520e47..57a83d763ec1 100644
> > --- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
> > +++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> > @@ -796,7 +796,7 @@
> >  	},
> >  	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> >  	.result = REJECT,
> > -	.errstr = "reference has not been acquired before",
> > +	.errstr = "R1 must be referenced when passed to release function",
> >  },
> >  {
> >  	/* !bpf_sk_fullsock(sk) is checked but !bpf_tcp_sock(sk) is not checked */
> > diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
> > index 86b24cad27a7..d11d0b28be41 100644
> > --- a/tools/testing/selftests/bpf/verifier/sock.c
> > +++ b/tools/testing/selftests/bpf/verifier/sock.c
> > @@ -417,7 +417,7 @@
> >  	},
> >  	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> >  	.result = REJECT,
> > -	.errstr = "reference has not been acquired before",
> > +	.errstr = "R1 must be referenced when passed to release function",
> >  },
> >  {
> >  	"bpf_sk_release(bpf_sk_fullsock(skb->sk))",
> > @@ -436,7 +436,7 @@
> >  	},
> >  	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> >  	.result = REJECT,
> > -	.errstr = "reference has not been acquired before",
> > +	.errstr = "R1 must be referenced when passed to release function",
> >  },
> >  {
> >  	"bpf_sk_release(bpf_tcp_sock(skb->sk))",
> > @@ -455,7 +455,7 @@
> >  	},
> >  	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> >  	.result = REJECT,
> > -	.errstr = "reference has not been acquired before",
> > +	.errstr = "R1 must be referenced when passed to release function",
> >  },
> >  {
> >  	"sk_storage_get(map, skb->sk, NULL, 0): value == NULL",
> > --
> > 2.35.1
> >

--
Kartikeya
