Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5B3604B94
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 17:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJSPeX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 11:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiJSPdz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 11:33:55 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4140A60C8D
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 08:28:48 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id i9so11613516qvo.0
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 08:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++knzQ4UBso1RXfUVSphGHJnc3GKpefx+olu7qzfel4=;
        b=ZUsyqx5c5SYppUz92se3m/8Yu2in6zECL9V7/0pO8+9bpH5iAOHTcWvyimulMVuOCv
         HYncw6SDJAEV/AZAeRFP4C7JnLWPDe3zwZAEdw+xoJd4JrkztJTxHTcTMdehoHtejT70
         UEU0gsC91wBcD9tMlPVnCgbHCuy5q54CWMlPL+iN6Wh+tKPYSJ/NqrjMbYhKNVqpXo8q
         ZytiNtVERm1FiiEtzC9S0FeNwti7EGvZkvj0XnmcGVpnnidj9Qr3xtpSHsNd3wLWaKr8
         UxKeVdgGL32ENW93Falmxo7Rb6eJXree1OczzuQ/z8aRpmgdYWPsOo4Bmptxq5X80fat
         P/7A==
X-Gm-Message-State: ACrzQf2mW/SXGjxTiH2LYWQ10C18te3RXZG9vx2de3SwrzHc8ofDPGOl
        KY5L9pRjuLrjhJQb57NVcU0=
X-Google-Smtp-Source: AMsMyM58b/+eCU+T78yCUIzq5xsD3nFASRaPeyPhskAcoJn8DqyCK3BdtfpS5R63v2NyKeLpNqRp7A==
X-Received: by 2002:a05:6214:5006:b0:4b4:9a51:f811 with SMTP id jo6-20020a056214500600b004b49a51f811mr7074987qvb.44.1666193188327;
        Wed, 19 Oct 2022 08:26:28 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::e12b])
        by smtp.gmail.com with ESMTPSA id m11-20020a05620a290b00b006b929a56a2bsm5306553qkp.3.2022.10.19.08.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 08:26:27 -0700 (PDT)
Date:   Wed, 19 Oct 2022 10:26:29 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Refactor ARG_PTR_TO_DYNPTR checks
 into process_dynptr_func
Message-ID: <Y1AXJdisetkYvwpB@maniforge.dhcp.thefacebook.com>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-2-memxor@gmail.com>
 <Y08CYWzGTvKHQXvy@maniforge.dhcp.thefacebook.com>
 <20221019060412.dqvq2e23cuh3jw52@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019060412.dqvq2e23cuh3jw52@apollo>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 11:34:12AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Wed, Oct 19, 2022 at 01:15:37AM IST, David Vernet wrote:
> > On Tue, Oct 18, 2022 at 07:29:08PM +0530, Kumar Kartikeya Dwivedi wrote:
> >
> > Hey Kumar, thanks for looking at this stuff.
> >
> > > ARG_PTR_TO_DYNPTR is akin to ARG_PTR_TO_TIMER, ARG_PTR_TO_KPTR, where
> > > the underlying register type is subjected to more special checks to
> > > determine the type of object represented by the pointer and its state
> > > consistency.
> > >
> > > Move dynptr checks to their own 'process_dynptr_func' function so that
> > > is consistent and in-line with existing code. This also makes it easier
> > > to reuse this code for kfunc handling.
> >
> > Just out of curiosity, do you have a specific use case for when you'd envision
> > a kfunc taking a dynptr? I'm not saying there are none, just curious if you
> > have any specifically that you've considered.
> >
> 
> There is already a kfunc that takes dynptrs, bpf_verify_pkcs7_signature. I am
> sure we'll get more in the future.

Ah, ok, hence why the negative-selftest you removed called that kfunc
with a ringbuf dynptr.

> > > To this end, remove the dependency on bpf_call_arg_meta parameter by
> > > instead taking the uninit_dynptr_regno by pointer. This is only needed
> > > to be set to a valid pointer when arg_type has MEM_UNINIT.
> > >
> > > Then, reuse this consolidated function in kfunc dynptr handling too.
> > > Note that for kfuncs, the arg_type constraint of DYNPTR_TYPE_LOCAL has
> > > been lifted.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf_verifier.h                  |   8 +-
> > >  kernel/bpf/btf.c                              |  17 +--
> > >  kernel/bpf/verifier.c                         | 115 ++++++++++--------
> > >  .../bpf/prog_tests/kfunc_dynptr_param.c       |   5 +-
> > >  .../bpf/progs/test_kfunc_dynptr_param.c       |  12 --
> > >  5 files changed, 69 insertions(+), 88 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > index 9e1e6965f407..a33683e0618b 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -593,11 +593,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
> > >  			     u32 regno);
> > >  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > >  		   u32 regno, u32 mem_size);
> > > -bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> > > -			      struct bpf_reg_state *reg);
> > > -bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > > -			     struct bpf_reg_state *reg,
> > > -			     enum bpf_arg_type arg_type);
> > > +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> > > +			enum bpf_arg_type arg_type, int argno,
> > > +			u8 *uninit_dynptr_regno);
> > >
> > >  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> > >  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index eba603cec2c5..1827d889e08a 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -6486,23 +6486,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >  						return -EINVAL;
> > >  					}
> > >
> > > -					if (!is_dynptr_reg_valid_init(env, reg)) {
> > > -						bpf_log(log,
> > > -							"arg#%d pointer type %s %s must be valid and initialized\n",
> > > -							i, btf_type_str(ref_t),
> > > -							ref_tname);
> > > +					if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, i, NULL))
> > >  						return -EINVAL;
> > > -					}
> >
> > Could you please clarify why you're removing the DYNPTR_TYPE_LOCAL constraint
> > for kfuncs?
> >
> > You seemed to have removed the following negative selftest:
> >
> > > -SEC("?lsm.s/bpf")
> > > -int BPF_PROG(dynptr_type_not_supp, int cmd, union bpf_attr *attr,
> > > -	     unsigned int size)
> > > -{
> > > -	char write_data[64] = "hello there, world!!";
> > > -	struct bpf_dynptr ptr;
> > > -
> > > -	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0, &ptr);
> > > -
> > > -	return bpf_verify_pkcs7_signature(&ptr, &ptr, NULL);
> > > -}
> > > -
> >
> > But it was clearly the intention of the test validate that we can't pass a
> > dynptr to a ringbuf region to this kfunc, so I'm curious what's changed since
> > that test was added.
> >
> 
> There was no inherent limitation for just accepting local dynptrs, it's that
> when this was added I suggested sticking to one kind back then, because of the
> code divergence between kfunc argument checking and helper argument checking.
> 
> Now that both share the same code, it's easier to handle everything one place
> and make it work everywhere the same way.
> 
> Also, next patch adds a very clear distinction between argument type which only
> operates on the dynamically sized memory slice and ones which may also modify
> dynptr, which also makes it easier to support things for kfuncs by setting
> MEM_RDONLY.

Makes sense, thanks for clarifying.

> > > -
> > > -					if (!is_dynptr_type_expected(env, reg,
> > > -							ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
> > > -						bpf_log(log,
> > > -							"arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
> > > -							i, btf_type_str(ref_t),
> > > -							ref_tname);
> > > -						return -EINVAL;
> > > -					}
> > > -
> > >  					continue;
> > >  				}
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 6f6d2d511c06..31c0c999448e 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -782,8 +782,7 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
> > >  	return true;
> > >  }
> > >
> > > -bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> > > -			      struct bpf_reg_state *reg)
> > > +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > >  {
> > >  	struct bpf_func_state *state = func(env, reg);
> > >  	int spi = get_spi(reg->off);
> > > @@ -802,9 +801,8 @@ bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> > >  	return true;
> > >  }
> > >
> > > -bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > > -			     struct bpf_reg_state *reg,
> > > -			     enum bpf_arg_type arg_type)
> > > +static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > +				    enum bpf_arg_type arg_type)
> > >  {
> > >  	struct bpf_func_state *state = func(env, reg);
> > >  	enum bpf_dynptr_type dynptr_type;
> > > @@ -5573,6 +5571,65 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
> > >  	return 0;
> > >  }
> > >
> > > +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> > > +			enum bpf_arg_type arg_type, int argno,
> > > +			u8 *uninit_dynptr_regno)
> > > +{
> >
> > IMO 'process' is a bit too generic of a term. If we decide to go with this,
> > what do you think about changing the name to check_func_dynptr_arg(), or just
> > check_dynptr_arg()?
> >
> 
> While I agree, then it would be different from the existing ones and look a bit
> odd in the list (e.g. process_spin_lock, process_kptr_func, etc.). So I am not
> very sure, but if you still feel it's better I don't mind.

Uniformity should trump my own personal preferences. We can stick with
process_dynptr_func().

LGTM, thanks for answering my questions.

Acked-by: David Vernet <void@manifault.com>
