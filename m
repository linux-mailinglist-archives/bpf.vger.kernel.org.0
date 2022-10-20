Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F75605745
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 08:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJTGWp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 02:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJTGWn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 02:22:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199D02339F;
        Wed, 19 Oct 2022 23:22:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y4so546892plb.2;
        Wed, 19 Oct 2022 23:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J71kKCMX3J6hO10lMUh4yzRJjU280w3xxRAPcIYzIg0=;
        b=NZ84MRpYvdW9dnw92EeSkt5sJtkQJinkgSaFTWHPkxCMmhpdiYcD3WHbJLTtk6x/h/
         4g0ksM6Mf8Owu30YQRS7SJF8eSY/3AEQR9bgZbAdAA2G063d04NWoEsBK6AyQD+xqC1/
         RR3WcX9inDJ+bionV60oWq0OGwJU03WODH1061szFThWiJWOooQa8+Yz5yzQyAD0ou1W
         jbgeCXI0GHtFdIr+ZjPl/gGl8DG9bc8HLnI4vgpfLsIUbgIwGt5FVbjK0VVFNLtMToPe
         9muUpX7a1yq+MaLF2onfHgk/yGCwmFEg1c4QwVNab7qRrgMYmv7ryFE2zmARHhE62+Kb
         XqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J71kKCMX3J6hO10lMUh4yzRJjU280w3xxRAPcIYzIg0=;
        b=yZVGWnA2/KHH5qCV3+agXW5UzYj4Gi3hbCAvuj0Izg9yF8na+y6uGEVKPVIxGcD5li
         P9X7QDoe1FYcgv5pt1iJ/VC5Zz4jS4i+djArhWhUDGXUQvwdyNY1rgKmy7yp4K9/qHIQ
         BvDBk8PbS90alpGcLT2cyo0RLIXzzAO+V1JLrxQV2TmSYsEoayJetXdHxiHO/QqoOc72
         SjemRn7KEMgS4KayIi5wUUJBuL4Q0WklDpjWMJU2FiGcbLPeWvcJ5sNpTAVSV+Rpmf3u
         PBjiw8wrxj7XCDpb3s1jox2LR0/wU4n+OWFToZfTIak9tt/YR4ybTI3TmgBV4sjYVvrG
         gC0w==
X-Gm-Message-State: ACrzQf3RxWn2qUIruk1RTzTEehgIVgD8PQIasFyzWRxkIb/PAnKVW9pw
        IEtWwBcDhUz6o7kz5n2D5Ck=
X-Google-Smtp-Source: AMsMyM6XJXaEF98htIkUy/k8RBRQ8JjxHgXAMROaJ/rDWaq1oMfE/TuwD/EcT9VrD/gZ4Q5BON1BWw==
X-Received: by 2002:a17:90a:6484:b0:210:f17b:f465 with SMTP id h4-20020a17090a648400b00210f17bf465mr4402823pjj.241.1666246962494;
        Wed, 19 Oct 2022 23:22:42 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id ij4-20020a170902ab4400b0017f8edd3d8asm11848589plb.177.2022.10.19.23.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 23:22:42 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:52:29 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org
Subject: Re: [PATCH v5 1/3] bpf: Allow trusted pointers to be passed to
 KF_TRUSTED_ARGS kfuncs
Message-ID: <20221020062229.b7e7r7lrnkszjoiy@apollo>
References: <20221014212133.2520531-1-void@manifault.com>
 <20221014212133.2520531-2-void@manifault.com>
 <CAP01T75FGW7F=Ho+oqoC6WgxK5uUir2=CUgiW_HwqNxmzmthBg@mail.gmail.com>
 <Y1BR5c6W4tgljA8q@maniforge.dhcp.thefacebook.com>
 <20221020055749.33lfipxtaubhnqbv@apollo>
 <Y1DmnQE0xuj1RDp7@maniforge.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1DmnQE0xuj1RDp7@maniforge.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 11:41:41AM IST, David Vernet wrote:
> [...]
> Apologies, as mentioned below I pasted the wrong if-check on accident.
> If I had actually meant to paste that one, then saying I "misunderstand
> this a bit" would have been a very generous understatment :-)
>
> > When you have task from tracing ctx arg:
> > r1 = ctx;
> > r1 = *(r1 + ...); // PTR_TO_BTF_ID, task_struct, off=0
> > // r1 = task->next
> > r1 = *(r1 + offsetof(task_struct, next)); // PTR_TO_BTF_ID | PTR_WALKED, task_struct, off = 0
> >
> > We loaded a pointer from task_struct into r1.
> > Now r1 still points to a task_struct, so that check above won't fail for r1.
>
> I meant to paste the if-condition _above_ that one. This is the if-check
> we'll fail due to the presence of a type modifier (PTR_WALKED):
>
> 	} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
> 		   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
> 		const struct btf_type *reg_ref_t;
> 		const struct btf *reg_btf;
> 		const char *reg_ref_tname;
> 		u32 reg_ref_id;
>
> So we'll never even get to the if check I originally pasted because
> reg->type == PTR_TO_BTF_ID will fail for a PTR_WALKED reg. And then
> below we'll eventually fail later on here:
>
> 	/* Permit pointer to mem, but only when argument
> 	 * type is pointer to scalar, or struct composed
> 	 * (recursively) of scalars.
> 	 * When arg_mem_size is true, the pointer can be
> 	 * void *.
> 	 * Also permit initialized local dynamic pointers.
> 	 */
> 	if (!btf_type_is_scalar(ref_t) &&
> 	    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
> 	    !arg_dynptr &&
> 	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> 		bpf_log(log,
> 			"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
> 			i, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
> 		return -EINVAL;
> 	}
>
> Appreciate the explanation, sorry to have made you type it.
>

Ah, I see. Your analysis is right, but the error in CI comes from
check_func_arg_reg_off invocation in check_helper_call, this code is for kfuncs.

Since you have this to preserve backwards compat:
+static const struct bpf_reg_types btf_ptr_types = {
+	.types = {
+		PTR_TO_BTF_ID,
+		PTR_TO_BTF_ID | PTR_NESTED
+	},
+};

It allows passing those with PTR_NESTED to stable helpers.
