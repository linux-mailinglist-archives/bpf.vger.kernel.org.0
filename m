Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB956057A8
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJTGqT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 02:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJTGqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 02:46:06 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90CBF987D;
        Wed, 19 Oct 2022 23:45:47 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id y10so12930511qvo.11;
        Wed, 19 Oct 2022 23:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvWiMJxsMMzlAV4KUnHA4w+CaUVO2kOyC0iXLhG6h/8=;
        b=drSuhIJU2hdzuy6S9p1NdRg9E/FLY4hGXkChnOBFMn9Iq13ZYt9ycGLuwndvsJaAH+
         tgwK0b83YMZzOCG17fvZLM304KRrbdYu8apMO/EA91cbjZEQ90PBW2tNu9dDZyZ2X+Jq
         0ObIKHGA8WccI9P3yO7uGGo5Ea73uYwkedfYPhKvLA5M3OsJWc1ZKk/YEI6/b/OuuEEE
         oIEIcSx1Wwe1K6QMvcZRQ3yhQvF096ze4bV96gV9d1DZxI3+26pEFPaRQmg+BuPNgRVC
         4EpAVwbzCBC8wjOczRPXM7i92w/sZjs7i6lECgU5/8u9180aLr6x51PuR1LteW114bCB
         CU5Q==
X-Gm-Message-State: ACrzQf38a0LzmTQE7nTgDOao91N00pykpLlclncLj3iBuEcaqh819FWN
        lLiqpLUbGBEXxK/RvQjSieo=
X-Google-Smtp-Source: AMsMyM4z60W+J8zSGqusk5uo0pipuulA4lzSqOJJdWOsXJ8M+Jd6n7IKI/325v69MCxqu8LwcZT/AA==
X-Received: by 2002:a05:6214:401a:b0:4b1:c215:3980 with SMTP id kd26-20020a056214401a00b004b1c2153980mr9900207qvb.4.1666248346530;
        Wed, 19 Oct 2022 23:45:46 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::9f20])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85846000000b0039a9b55b829sm5682171qth.29.2022.10.19.23.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 23:45:45 -0700 (PDT)
Date:   Thu, 20 Oct 2022 01:45:48 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org
Subject: Re: [PATCH v5 1/3] bpf: Allow trusted pointers to be passed to
 KF_TRUSTED_ARGS kfuncs
Message-ID: <Y1DunCgOuKXT8GOm@maniforge.dhcp.thefacebook.com>
References: <20221014212133.2520531-1-void@manifault.com>
 <20221014212133.2520531-2-void@manifault.com>
 <CAP01T75FGW7F=Ho+oqoC6WgxK5uUir2=CUgiW_HwqNxmzmthBg@mail.gmail.com>
 <Y1BR5c6W4tgljA8q@maniforge.dhcp.thefacebook.com>
 <20221020055749.33lfipxtaubhnqbv@apollo>
 <Y1DmnQE0xuj1RDp7@maniforge.dhcp.thefacebook.com>
 <20221020062229.b7e7r7lrnkszjoiy@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020062229.b7e7r7lrnkszjoiy@apollo>
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

On Thu, Oct 20, 2022 at 11:52:29AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Thu, Oct 20, 2022 at 11:41:41AM IST, David Vernet wrote:
> > [...]
> > Apologies, as mentioned below I pasted the wrong if-check on accident.
> > If I had actually meant to paste that one, then saying I "misunderstand
> > this a bit" would have been a very generous understatment :-)
> >
> > > When you have task from tracing ctx arg:
> > > r1 = ctx;
> > > r1 = *(r1 + ...); // PTR_TO_BTF_ID, task_struct, off=0
> > > // r1 = task->next
> > > r1 = *(r1 + offsetof(task_struct, next)); // PTR_TO_BTF_ID | PTR_WALKED, task_struct, off = 0
> > >
> > > We loaded a pointer from task_struct into r1.
> > > Now r1 still points to a task_struct, so that check above won't fail for r1.
> >
> > I meant to paste the if-condition _above_ that one. This is the if-check
> > we'll fail due to the presence of a type modifier (PTR_WALKED):
> >
> > 	} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
> > 		   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
> > 		const struct btf_type *reg_ref_t;
> > 		const struct btf *reg_btf;
> > 		const char *reg_ref_tname;
> > 		u32 reg_ref_id;
> >
> > So we'll never even get to the if check I originally pasted because
> > reg->type == PTR_TO_BTF_ID will fail for a PTR_WALKED reg. And then
> > below we'll eventually fail later on here:
> >
> > 	/* Permit pointer to mem, but only when argument
> > 	 * type is pointer to scalar, or struct composed
> > 	 * (recursively) of scalars.
> > 	 * When arg_mem_size is true, the pointer can be
> > 	 * void *.
> > 	 * Also permit initialized local dynamic pointers.
> > 	 */
> > 	if (!btf_type_is_scalar(ref_t) &&
> > 	    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
> > 	    !arg_dynptr &&
> > 	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> > 		bpf_log(log,
> > 			"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
> > 			i, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
> > 		return -EINVAL;
> > 	}
> >
> > Appreciate the explanation, sorry to have made you type it.
> >
> 
> Ah, I see. Your analysis is right, but the error in CI comes from
> check_func_arg_reg_off invocation in check_helper_call, this code is for kfuncs.

Yeah, in my defense, if you look back at [0] where I fat-fingered the
wrong if statement, I did say that I missed the case for helpers
specifically:

> Note that we also don't include PTR_TO_BTF_ID | PTR_UNTRUSTED here. The
> difference for PTR_TO_BTF_ID | PTR_WALK(ED) is of course that we also need to
> allow it to work properly for normal helper calls, so I'll make that change.

[0]: https://lore.kernel.org/all/Y1BR5c6W4tgljA8q@maniforge.dhcp.thefacebook.com/

Anyways, I think we're on the same page. I already have a local revision
that fixes this.

> Since you have this to preserve backwards compat:
> +static const struct bpf_reg_types btf_ptr_types = {
> +	.types = {
> +		PTR_TO_BTF_ID,
> +		PTR_TO_BTF_ID | PTR_NESTED
> +	},
> +};
> 
> It allows passing those with PTR_NESTED to stable helpers.

I'd need to look over all of this code again to give useful suggestions
here (it's very difficult to keep it all paged in, there's just so much
context), but it'd be nice if we could somehow refactor some of this so
that check_helper_call() and check_kfunc_call() shared more code.
Obviously out of scope for this patch set.
