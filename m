Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C964CDF42
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 22:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiCDUzK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 15:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiCDUzJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 15:55:09 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D3A6D4E6
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 12:54:20 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d187so8571956pfa.10
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 12:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sZrDosS7pRXt/cs2EQrTA92XCdwfWOP/7Ano39QGz8o=;
        b=qNTFxVrUM+eWKFVBBOTlGWv/p2JVpq9lfgzCTpUeXA9YbD3CcWtPvTvpozcjphRGh1
         snPKI0+SvqCbPhRM4iScRrDomDETp7RVVPmt5cUeLZMFALJDiYTLNjdpPIdWWiztVoZG
         MPVjoauzsKqZtjTa6U5+632SsMqzpzKXryhk+bew11M7EkFuh3cRD2PurW8HmDHI1NPU
         xsdnUVpcG/mMq87dbspluYiOEAZ5/W75xQsHOdAtSzepk7OqiZA1YCghGxidtKv3QDbY
         VasfDPHBquJ1PuO1cCEAKGW2PAc06pZYawyngovqH76ZvTZCco+ikdYhOJPs9gm1jH2J
         6phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sZrDosS7pRXt/cs2EQrTA92XCdwfWOP/7Ano39QGz8o=;
        b=DcAQSm1VsyouQxSsN00ZKDXxTM306MqhuHJ6gzlI2IrTajZPxinrF6Cm+kyQv1tr1Y
         2U5Z4LZk4KvRSYCmeMoF1PyVKmCreN8DeJLHxaezwmhSbOk/hpb58GTCCga6RoYYiNDJ
         Sy/nI/vMnOrZ+yS9w/4h+/xKZEsqRGI5eN8jD3WRw6IZBR9UBrvrhS7Gi17e0Bi5hF4w
         cS+QAnQVqdmoHyA4B3vo1tPWaBlVZCXKmw0DOddCswGhU6chq4mOhV9aiXuqYjXNzaNF
         q/8XYzkaRuJSEDV3pOxtf23tA4t7lKAUD1FBTr2jou8/jCVJz7Fh+LFAXheYN2450B5R
         plnA==
X-Gm-Message-State: AOAM53382kqHDfieES1mvKJMyjmb3MJFfvTyC8fqNd2yN8VKtfN56bG0
        EX0DSH0wXWWuv+h/FytqiTk=
X-Google-Smtp-Source: ABdhPJxrmDYcwGSLJ4WDQh5GzsbbCsfWuMD5HWn/ThYBjimSs9pAtFHEOuguPlnaZClX7UFAlaLS4A==
X-Received: by 2002:a05:6a00:2341:b0:4e1:5aa4:9aff with SMTP id j1-20020a056a00234100b004e15aa49affmr479849pfj.8.1646427259805;
        Fri, 04 Mar 2022 12:54:19 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id j16-20020a63e750000000b00373598b8cbfsm5138753pgk.74.2022.03.04.12.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:54:19 -0800 (PST)
Date:   Sat, 5 Mar 2022 02:24:17 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Add check_func_arg_reg_off function
Message-ID: <20220304205417.7n7auwf6ziywnhmm@apollo.legion>
References: <20220304000508.2904128-1-memxor@gmail.com>
 <20220304000508.2904128-2-memxor@gmail.com>
 <20220304201539.hr5xzg7c5tlx4xvl@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304201539.hr5xzg7c5tlx4xvl@kafai-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 05, 2022 at 01:45:39AM IST, Martin KaFai Lau wrote:
> On Fri, Mar 04, 2022 at 05:35:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Lift the list of register types allowed for having fixed and variable
> > offsets when passed as helper function arguments into a common helper,
> > so that they can be reused for kfunc checks in later commits. Keeping a
> > common helper aids maintainability and allows us to follow the same
> > consistent rules across helpers and kfuncs. Also, convert check_func_arg
> > to use this function.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  3 ++
> >  kernel/bpf/verifier.c        | 69 +++++++++++++++++++++---------------
> >  2 files changed, 44 insertions(+), 28 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 7a7be8c057f2..38b24ee8d8c2 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -521,6 +521,9 @@ bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
> >
> >  int check_ptr_off_reg(struct bpf_verifier_env *env,
> >  		      const struct bpf_reg_state *reg, int regno);
> > +int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > +			   const struct bpf_reg_state *reg, int regno,
> > +			   enum bpf_arg_type arg_type);
> >  int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> >  			     u32 regno);
> >  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a57db4b2803c..c85f4b2458f4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5359,6 +5359,44 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >  	return 0;
> >  }
> >
> > +int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > +			   const struct bpf_reg_state *reg, int regno,
> > +			   enum bpf_arg_type arg_type)
> > +{
> > +	enum bpf_reg_type type = reg->type;
> > +	int err;
> > +
> > +	switch ((u32)type) {
> > +	case SCALAR_VALUE:
> > +	/* Pointer types where reg offset is explicitly allowed: */
> > +	case PTR_TO_PACKET:
> > +	case PTR_TO_PACKET_META:
> > +	case PTR_TO_MAP_KEY:
> > +	case PTR_TO_MAP_VALUE:
> > +	case PTR_TO_MEM:
> > +	case PTR_TO_MEM | MEM_RDONLY:
> > +	case PTR_TO_MEM | MEM_ALLOC:
> > +	case PTR_TO_BUF:
> > +	case PTR_TO_BUF | MEM_RDONLY:
> > +	case PTR_TO_STACK:
> > +		/* Some of the argument types nevertheless require a
> > +		 * zero register offset.
> > +		 */
> > +		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
> > +			goto force_off_check;
> > +		break;
> > +	/* All the rest must be rejected: */
> > +	default:
> > +force_off_check:
> > +		err = __check_ptr_off_reg(env, reg, regno,
> > +					  type == PTR_TO_BTF_ID);
> > +		if (err < 0)
> > +			return err;
> Nit. Since it is refactoring to a new function now,
> it can directly return __check_ptr_off_reg().
>
>
> > +		break;
> > +	}
> > +	return 0;
> > +}
> May as well flip the arg_type check and leave calling
> the __check_ptr_off_reg at the end.
>
> Uncompiled code:
>
> int check_func_arg_reg_off(struct bpf_verifier_env *env,
> 			   const struct bpf_reg_state *reg, int regno,
> 			   enum bpf_arg_type arg_type)
> {
> 	enum bpf_reg_type type = reg->type;
> 	bool fixed_off_ok = false;
>
> 	switch ((u32)type) {
> 	case SCALAR_VALUE:
> 	/* Pointer types where reg offset is explicitly allowed: */
> 	case PTR_TO_PACKET:
> 	case PTR_TO_PACKET_META:
> 	case PTR_TO_MAP_KEY:
> 	case PTR_TO_MAP_VALUE:
> 	case PTR_TO_MEM:
> 	case PTR_TO_MEM | MEM_RDONLY:
> 	case PTR_TO_MEM | MEM_ALLOC:
> 	case PTR_TO_BUF:
> 	case PTR_TO_BUF | MEM_RDONLY:
> 	case PTR_TO_STACK:
> 		/* Some of the argument types nevertheless require a
> 		 * zero register offset.
> 		 */
> 		if (arg_type != ARG_PTR_TO_ALLOC_MEM)
> 			return 0;
> 		break;
> 	case PTR_TO_BTF_ID:
> 		fixed_off_ok = true;
> 		break;
> 	}
>
> 	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> }
>
> Then 'case PTR_TO_BTF_ID' can then be reused in patch 4 instead
> of adding a special 'if (type == PTR_TO_BTF_ID)' just
> before the 'switch ((u32)type)'
>
> Both are nits. can be ignored.
>

Both suggestions are good, will wait for discussion to conclude and respin.

> > +
> >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >  			  struct bpf_call_arg_meta *meta,
> >  			  const struct bpf_func_proto *fn)
> > @@ -5408,34 +5446,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >  	if (err)
> >  		return err;
> >
> > -	switch ((u32)type) {
> > -	case SCALAR_VALUE:
> > -	/* Pointer types where reg offset is explicitly allowed: */
> > -	case PTR_TO_PACKET:
> > -	case PTR_TO_PACKET_META:
> > -	case PTR_TO_MAP_KEY:
> > -	case PTR_TO_MAP_VALUE:
> > -	case PTR_TO_MEM:
> > -	case PTR_TO_MEM | MEM_RDONLY:
> > -	case PTR_TO_MEM | MEM_ALLOC:
> > -	case PTR_TO_BUF:
> > -	case PTR_TO_BUF | MEM_RDONLY:
> > -	case PTR_TO_STACK:
> > -		/* Some of the argument types nevertheless require a
> > -		 * zero register offset.
> > -		 */
> > -		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
> > -			goto force_off_check;
> > -		break;
> > -	/* All the rest must be rejected: */
> > -	default:
> > -force_off_check:
> > -		err = __check_ptr_off_reg(env, reg, regno,
> > -					  type == PTR_TO_BTF_ID);
> > -		if (err < 0)
> > -			return err;
> > -		break;
> > -	}
> > +	err = check_func_arg_reg_off(env, reg, regno, arg_type);
> > +	if (err)
> > +		return err;
> >
> >  skip_type_check:
> >  	if (reg->ref_obj_id) {
> > --
> > 2.35.1
> >

--
Kartikeya
