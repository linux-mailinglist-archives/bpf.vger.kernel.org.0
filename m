Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C610C605729
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 08:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJTGLn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 02:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJTGLm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 02:11:42 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9D9143A7A;
        Wed, 19 Oct 2022 23:11:40 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id s17so11031493qkj.12;
        Wed, 19 Oct 2022 23:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRaHxB95mCTKZ1Cj/t/7YI2L8HYOy0+Xpb7Ll3T7l1Y=;
        b=DBg33gsbV/Qp3zy13uKUHfTFnnNQUQrX44h0AAyX7rHpuM43OeT0B/tNcs4dLw7ycy
         B70SvJM+y/BONTOmIqE3DUq2TNJ/oZtcwg/R6FT2crWL7AkSYSEdyH0dLgBFcz5+Rl6d
         cuw3UCs/UHcGzVH/6G1gMxfYAE245i7joT2I42ONjDxlp+cSfZpl6acspsgAMxu2yZY5
         MyPWSBtvP9L5ZM0BSYXs9tbMuAiOnY1cUJ3qwHpPtZI6dUCO3nOjKYqJF86/v5of5ZSm
         X29vlM9ekCwTn5ZR9KJr0IJvcdqiE2rLGsGJq7f/yGftXZ09AwrdlFZOq/jQNLGtIhd2
         oDIQ==
X-Gm-Message-State: ACrzQf3fFp1xGsT6SJ6NTFkRv/yPu/8NUhejr8GfZtV3XuI8mt2pKl+W
        YMqcC+Hrr+nQN/lQ30tsLZ75OldwJXRCNw==
X-Google-Smtp-Source: AMsMyM6tgzLTDptTNdwuFtOLIVwM5FVqC2Y33+EDZJLXGuWjWC+fhehxfYWpsR7yQ4kzukPaRH3psQ==
X-Received: by 2002:a05:620a:4626:b0:6ee:b43:d2bc with SMTP id br38-20020a05620a462600b006ee0b43d2bcmr7853418qkb.764.1666246299676;
        Wed, 19 Oct 2022 23:11:39 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::9f20])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a288600b006ced196a73fsm6583026qkp.135.2022.10.19.23.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 23:11:38 -0700 (PDT)
Date:   Thu, 20 Oct 2022 01:11:41 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org
Subject: Re: [PATCH v5 1/3] bpf: Allow trusted pointers to be passed to
 KF_TRUSTED_ARGS kfuncs
Message-ID: <Y1DmnQE0xuj1RDp7@maniforge.dhcp.thefacebook.com>
References: <20221014212133.2520531-1-void@manifault.com>
 <20221014212133.2520531-2-void@manifault.com>
 <CAP01T75FGW7F=Ho+oqoC6WgxK5uUir2=CUgiW_HwqNxmzmthBg@mail.gmail.com>
 <Y1BR5c6W4tgljA8q@maniforge.dhcp.thefacebook.com>
 <20221020055749.33lfipxtaubhnqbv@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020055749.33lfipxtaubhnqbv@apollo>
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

On Thu, Oct 20, 2022 at 11:27:49AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Sure, I can make that change. We'll have to increase the size of the
> > prefix string on the stack, but that's hardly problematic as these
> > strings are not terribly large.
> >
> > > > @@ -4558,6 +4560,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> > > >         if (type_flag(reg->type) & PTR_UNTRUSTED)
> > > >                 flag |= PTR_UNTRUSTED;
> > > >
> > > > +       /* All pointers obtained by walking a struct are nested. */
> > > > +       flag |= PTR_NESTED;
> > > > +
> > >
> > > Instead of PTR_NESTED, how about PTR_WALK?
> >
> > I don't have a strong preference between either, though I would prefer
> > PTR_WALKED if we go with the latter. Does that work for you?
> >
> 
> Yes, I just think PTR_NESTED is a bit misleading, it's not nested within the old
> object, we loaded a pointer from it, it should just indicate that the pointer
> came from a walk of a trusted PTR_TO_BTF_ID.

Ok, we'll go with PTR_WALKED.

> > > > [...]
> > > > @@ -5694,7 +5699,12 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
> > > >  static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
> > > >  static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
> > > >  static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
> > > > -static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
> > > > +static const struct bpf_reg_types btf_ptr_types = {
> > > > +       .types = {
> > > > +               PTR_TO_BTF_ID,
> > > > +               PTR_TO_BTF_ID | PTR_NESTED
> > > > +       },
> > > > +};
> > >
> > > CI fails, two of those failures are from not updating
> > > check_func_arg_reg_off for PTR_TO_BTF_ID | PTR_WALK, and the other one
> >
> > Gah, I didn't think it was necessary for this case as it's not required
> > for btf_check_func_arg_match(), which will eventually just fail in the
> > following check:
> >
> > 	if (!btf_type_is_struct(ref_t)) {
> > 		bpf_log(log, "kernel function %s args#%d pointer type %s %s is not support
> > 			func_name, i, btf_type_str(ref_t),
> > 			ref_tname);
> > 		return -EINVAL;
> > 	}
> 
> Why would it fail there? It will still be a struct type.
> I think you misunderstand this a bit.

Apologies, as mentioned below I pasted the wrong if-check on accident.
If I had actually meant to paste that one, then saying I "misunderstand
this a bit" would have been a very generous understatment :-)

> When you have task from tracing ctx arg:
> r1 = ctx;
> r1 = *(r1 + ...); // PTR_TO_BTF_ID, task_struct, off=0
> // r1 = task->next
> r1 = *(r1 + offsetof(task_struct, next)); // PTR_TO_BTF_ID | PTR_WALKED, task_struct, off = 0
> 
> We loaded a pointer from task_struct into r1.
> Now r1 still points to a task_struct, so that check above won't fail for r1.

I meant to paste the if-condition _above_ that one. This is the if-check
we'll fail due to the presence of a type modifier (PTR_WALKED):

	} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
		   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
		const struct btf_type *reg_ref_t;
		const struct btf *reg_btf;
		const char *reg_ref_tname;
		u32 reg_ref_id;

So we'll never even get to the if check I originally pasted because
reg->type == PTR_TO_BTF_ID will fail for a PTR_WALKED reg. And then
below we'll eventually fail later on here:

	/* Permit pointer to mem, but only when argument
	 * type is pointer to scalar, or struct composed
	 * (recursively) of scalars.
	 * When arg_mem_size is true, the pointer can be
	 * void *.
	 * Also permit initialized local dynamic pointers.
	 */
	if (!btf_type_is_scalar(ref_t) &&
	    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
	    !arg_dynptr &&
	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
		bpf_log(log,
			"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
			i, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
		return -EINVAL;
	}

Appreciate the explanation, sorry to have made you type it.

> > Note that we also don't include PTR_TO_BTF_ID | PTR_UNTRUSTED here. The
> > difference for PTR_TO_BTF_ID | PTR_WALK(ED) is of course that we also need to
> > allow it to work properly for normal helper calls, so I'll make that change.
> > Thanks for pointing it out. In general, the whole dance between register base
> > types + modifiers sometimes feels like a mine field...
> >
> 
> Yes, I don't like how it's growing and being mixed either. Eventually I think we
> should document what combinations are allowed and reject everything else when
> initializing reg->type to prevent bugs, but IDK whether something like this
> would be accepted.

That seems like a pretty sane idea. A project for another day...
