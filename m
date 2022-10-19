Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57512603981
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 08:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJSGE2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 02:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJSGE1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 02:04:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41EC627A
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 23:04:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 128so15349242pga.1
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 23:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9kiCerri0xuX8Y3v8uCducAT1nxtHXCfv4sqTnLw9I=;
        b=NLRcgEao91t2aXQpy+lhlYcTFu6BQ0gDSBDfvVYaf6SmnFDWLqLySQhwpGZRYBmLDs
         He5jWPC3cTtmP/S/Iqn9NPOQxW0Zx3Y60ALGVLRAZasHkOik32jRtiC7ZofQxgTB0G1O
         2e63Ac5RkmGIMw68PIUIvNT5axMjCRXc9VqkyPcAv4p94id73WchMGb8GD23dDDDmK0Q
         Qsl05+UME859rzOqh3iH1OZoyGzVIBrWjeCZivHwz4URU3rI0Gu3EvchV7MkR6D4Z3cv
         ZzrpyllEJ2HxM0xiKXdz2m3o/nlYgFOvQGDZ8JHCyin90tBWysZFDiDWs3QHwOUtzS3c
         oZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9kiCerri0xuX8Y3v8uCducAT1nxtHXCfv4sqTnLw9I=;
        b=sEcxYmfr6jKYvv2GvTDEWLwwhm2t7Hhy9/tv6j+GwSDAq8EJ3tl80Ts3S7Zbxe4idK
         Mg3T/juWBocPOQdH7U/DAD72Juvc89xCaF3VKvzuLOM6CFVfNebQMOvAOtKotYVuHGi3
         jzQQjYUIly8SKKwFetW+ZI7IWQ/vwOukgNVU5cKUO4nZbzNczYYanGkC4zjFdOxRON24
         3Qg/h2Xg0iG0FFv1LlXR3rftCxSt7P/Oq2diQQt5C37RS/P58203hfdVfw+yCUfCBrfl
         eA+z0/4DkK8TGVKIVMMrPS96EUuVVKEcxjkiVsX0OAF2UyzC90syUav/0NU2C1z00LD7
         GDpQ==
X-Gm-Message-State: ACrzQf2si/lGfF9zZ7pzW5v48zQ5zjBjqBGHuwcGsXc1rT+Hm3YoBYEs
        QysFdy10z2RhHNMZw34joOQ0NEx4xRLLWg==
X-Google-Smtp-Source: AMsMyM614yF7AJPy/SS2TO9ZAow7HXBNS0YfnoGUTvqy/auKQSV12cMj7Eq261QSlbndj5UB13dATw==
X-Received: by 2002:a05:6a00:b95:b0:565:9cbd:a7e5 with SMTP id g21-20020a056a000b9500b005659cbda7e5mr6927382pfj.74.1666159464588;
        Tue, 18 Oct 2022 23:04:24 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b001754064ac31sm9753518pla.280.2022.10.18.23.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 23:04:24 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:34:12 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Refactor ARG_PTR_TO_DYNPTR checks
 into process_dynptr_func
Message-ID: <20221019060412.dqvq2e23cuh3jw52@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-2-memxor@gmail.com>
 <Y08CYWzGTvKHQXvy@maniforge.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08CYWzGTvKHQXvy@maniforge.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 01:15:37AM IST, David Vernet wrote:
> On Tue, Oct 18, 2022 at 07:29:08PM +0530, Kumar Kartikeya Dwivedi wrote:
>
> Hey Kumar, thanks for looking at this stuff.
>
> > ARG_PTR_TO_DYNPTR is akin to ARG_PTR_TO_TIMER, ARG_PTR_TO_KPTR, where
> > the underlying register type is subjected to more special checks to
> > determine the type of object represented by the pointer and its state
> > consistency.
> >
> > Move dynptr checks to their own 'process_dynptr_func' function so that
> > is consistent and in-line with existing code. This also makes it easier
> > to reuse this code for kfunc handling.
>
> Just out of curiosity, do you have a specific use case for when you'd envision
> a kfunc taking a dynptr? I'm not saying there are none, just curious if you
> have any specifically that you've considered.
>

There is already a kfunc that takes dynptrs, bpf_verify_pkcs7_signature. I am
sure we'll get more in the future.

> > To this end, remove the dependency on bpf_call_arg_meta parameter by
> > instead taking the uninit_dynptr_regno by pointer. This is only needed
> > to be set to a valid pointer when arg_type has MEM_UNINIT.
> >
> > Then, reuse this consolidated function in kfunc dynptr handling too.
> > Note that for kfuncs, the arg_type constraint of DYNPTR_TYPE_LOCAL has
> > been lifted.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h                  |   8 +-
> >  kernel/bpf/btf.c                              |  17 +--
> >  kernel/bpf/verifier.c                         | 115 ++++++++++--------
> >  .../bpf/prog_tests/kfunc_dynptr_param.c       |   5 +-
> >  .../bpf/progs/test_kfunc_dynptr_param.c       |  12 --
> >  5 files changed, 69 insertions(+), 88 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 9e1e6965f407..a33683e0618b 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -593,11 +593,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
> >  			     u32 regno);
> >  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> >  		   u32 regno, u32 mem_size);
> > -bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> > -			      struct bpf_reg_state *reg);
> > -bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > -			     struct bpf_reg_state *reg,
> > -			     enum bpf_arg_type arg_type);
> > +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> > +			enum bpf_arg_type arg_type, int argno,
> > +			u8 *uninit_dynptr_regno);
> >
> >  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> >  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index eba603cec2c5..1827d889e08a 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6486,23 +6486,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >  						return -EINVAL;
> >  					}
> >
> > -					if (!is_dynptr_reg_valid_init(env, reg)) {
> > -						bpf_log(log,
> > -							"arg#%d pointer type %s %s must be valid and initialized\n",
> > -							i, btf_type_str(ref_t),
> > -							ref_tname);
> > +					if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, i, NULL))
> >  						return -EINVAL;
> > -					}
>
> Could you please clarify why you're removing the DYNPTR_TYPE_LOCAL constraint
> for kfuncs?
>
> You seemed to have removed the following negative selftest:
>
> > -SEC("?lsm.s/bpf")
> > -int BPF_PROG(dynptr_type_not_supp, int cmd, union bpf_attr *attr,
> > -	     unsigned int size)
> > -{
> > -	char write_data[64] = "hello there, world!!";
> > -	struct bpf_dynptr ptr;
> > -
> > -	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0, &ptr);
> > -
> > -	return bpf_verify_pkcs7_signature(&ptr, &ptr, NULL);
> > -}
> > -
>
> But it was clearly the intention of the test validate that we can't pass a
> dynptr to a ringbuf region to this kfunc, so I'm curious what's changed since
> that test was added.
>

There was no inherent limitation for just accepting local dynptrs, it's that
when this was added I suggested sticking to one kind back then, because of the
code divergence between kfunc argument checking and helper argument checking.

Now that both share the same code, it's easier to handle everything one place
and make it work everywhere the same way.

Also, next patch adds a very clear distinction between argument type which only
operates on the dynamically sized memory slice and ones which may also modify
dynptr, which also makes it easier to support things for kfuncs by setting
MEM_RDONLY.

> > -
> > -					if (!is_dynptr_type_expected(env, reg,
> > -							ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
> > -						bpf_log(log,
> > -							"arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
> > -							i, btf_type_str(ref_t),
> > -							ref_tname);
> > -						return -EINVAL;
> > -					}
> > -
> >  					continue;
> >  				}
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6f6d2d511c06..31c0c999448e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -782,8 +782,7 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
> >  	return true;
> >  }
> >
> > -bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> > -			      struct bpf_reg_state *reg)
> > +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> >  {
> >  	struct bpf_func_state *state = func(env, reg);
> >  	int spi = get_spi(reg->off);
> > @@ -802,9 +801,8 @@ bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> >  	return true;
> >  }
> >
> > -bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > -			     struct bpf_reg_state *reg,
> > -			     enum bpf_arg_type arg_type)
> > +static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +				    enum bpf_arg_type arg_type)
> >  {
> >  	struct bpf_func_state *state = func(env, reg);
> >  	enum bpf_dynptr_type dynptr_type;
> > @@ -5573,6 +5571,65 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
> >  	return 0;
> >  }
> >
> > +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> > +			enum bpf_arg_type arg_type, int argno,
> > +			u8 *uninit_dynptr_regno)
> > +{
>
> IMO 'process' is a bit too generic of a term. If we decide to go with this,
> what do you think about changing the name to check_func_dynptr_arg(), or just
> check_dynptr_arg()?
>

While I agree, then it would be different from the existing ones and look a bit
odd in the list (e.g. process_spin_lock, process_kptr_func, etc.). So I am not
very sure, but if you still feel it's better I don't mind.

> [...]
