Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9363D674CB2
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjATFor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjATFoq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:44:46 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56740D7;
        Thu, 19 Jan 2023 21:44:45 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z13so4433401plg.6;
        Thu, 19 Jan 2023 21:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nERCpWYfNGboMH6ktxTA1jxs96/Wwbv8oC42fwIyWRM=;
        b=copq2b8teUrjUxicfx2XltlZALg65zBEi19+dkpKL3oTuj9xxZkVbop5jyQHHZ5yBs
         mVC/IZ2v7ZUZRNPB3BP/+V1aO0JAbrNB3YzJoRYqfj800sPENYWsZYCh0/UFtX+VcJd2
         V9TCr3UBWkes8/dAlFQvdSPFFdPtgsJKiNMd+7LMvucw6ftLdVPMM2+v4uaSOhXgnjMn
         PZAjD6dmMxckovdWb1tiYEyaJlIm1LLhkHNl7Jh4HTqGUYTK6v7feuPcETnqhZNm80gL
         YJMP58EGEZov374O/eFVHWuWE6LFFlbQ1O0/lZSKThdGgiSnxOWoBceWQkyWj7Gfg8jl
         /uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nERCpWYfNGboMH6ktxTA1jxs96/Wwbv8oC42fwIyWRM=;
        b=h/G8EFfTISrl2RENCkEwmwqKAlLD74VsJ06cDipFf/B88AX02fBG5/M1fRFSw+BcKy
         rKQWjTpPfOF6kTL1QVkgv0bYC4ZQhvglRPFcGDP5rl7aGnUsPDxNCmzzHQxitnshGP5m
         kNkwgON2fXatkFSLYjCZk0MWW+8r41E2IJlYIXBFpHPbl7SicC2u5vOH5GowFj9S5P/a
         nGy04Qh0iO58pgOA+GdwwiJeDpsvOmWOAYZNOl/qjtTMyx6nhtQQ4kZzlDwVQVvFXxbV
         c3iZ1x7Cf/dT1QcFYlVcRKZY13ViKL16IllKq+VMIyShwQ5lrjXv9u06jDAfx4WAx078
         BMEA==
X-Gm-Message-State: AFqh2kpzd2Vak/ytQTEgfI0bRyYa7K3D2sDxRNgSlFadIaUb6CyDl4bM
        j6ODLNmIXCy1Np1EFOFNXPU=
X-Google-Smtp-Source: AMrXdXt8EbnGWXmqBhIONEGKe9nAvIiJctUS3xz4LckhFNlpf5KR/s3SzrrrkEX46SSfoecpN8e8HQ==
X-Received: by 2002:a17:902:8a8a:b0:194:480d:6afc with SMTP id p10-20020a1709028a8a00b00194480d6afcmr12507712plo.48.1674193484604;
        Thu, 19 Jan 2023 21:44:44 -0800 (PST)
Received: from MacBook-Pro-6.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:186c])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902654400b0018bde2250fcsm24566253pln.203.2023.01.19.21.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:44:43 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:44:41 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 3/8] bpf: Disallow NULL PTR_TO_MEM for trusted
 kfuncs
Message-ID: <20230120054441.arj5h6yrnh5jsrgr@MacBook-Pro-6.local.dhcp.thefacebook.com>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-4-void@manifault.com>
 <20230120052101.sevhc4jybcm6onu2@apollo>
 <Y8onR2T2zmMU6MmH@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8onR2T2zmMU6MmH@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 11:31:51PM -0600, David Vernet wrote:
> On Fri, Jan 20, 2023 at 10:51:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Fri, Jan 20, 2023 at 05:28:28AM IST, David Vernet wrote:
> > > KF_TRUSTED_ARGS kfuncs currently have a subtle and insidious bug in
> > > validating pointers to scalars. Say that you have a kfunc like the
> > > following, which takes an array as the first argument:
> > >
> > > bool bpf_cpumask_empty(const struct cpumask *cpumask)
> > > {
> > > 	return cpumask_empty(cpumask);
> > > }
> > >
> > > ...
> > > BTF_ID_FLAGS(func, bpf_cpumask_empty, KF_TRUSTED_ARGS)
> > > ...
> > >
> > 
> > This is known and expected.
> 
> Expected? So kfuncs are expected to always check whether any pointer to
> a scalar is non-NULL? Seems like a poor UX. I like your suggestion below
> to address it so it's opt-in.

I'm confused as well.
KF_TRUSTED_ARGS means that all arguments are valid and != NULL.
From our doc:
"
The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
indicates that the all pointer arguments are valid, and that all pointers to
BTF objects have been passed in their unmodified form (that is, at a zero
"

That includes that arguments are guaranted to be != NULL.

> > > If a BPF program were to invoke the kfunc with a NULL argument, it would
> > > crash the kernel. The reason is that struct cpumask is defined as a
> > > bitmap, which is itself defined as an array, and is accessed as a memory
> > > address memory by bitmap operations. So when the verifier analyzes the
> > > register, it interprets it as a pointer to a scalar struct, which is an
> > > array of size 8. check_mem_reg() then sees that the register is NULL,
> > > and returns 0, and the kfunc crashes when it passes it down to the
> > > cpumask wrappers.
> > >
> > > To fix this, this patch adds a check for KF_ARG_PTR_TO_MEM which
> > > verifies that the register doesn't contain a NULL pointer if the kfunc
> > > is KF_TRUSTED_ARGS.
> > >
> > > This may or may not be desired behavior. Some kfuncs may want to
> > > allow callers to pass NULL-able pointers. An alternative would be adding
> > > a KF_NOT_NULL flag and leaving KF_TRUSTED_ARGS alone, though given that
> > > a kfunc is saying it wants to "trust" an argument, it seems reasonable
> > > to prevent NULL.
> > >
> > > Signed-off-by: David Vernet <void@manifault.com>
> > > ---
> > >  kernel/bpf/verifier.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 9fa101420046..28ccb92ebe65 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -9092,6 +9092,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> > >  					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
> > >  				return -EINVAL;
> > >  			}
> > > +			if (is_kfunc_trusted_args(meta) && register_is_null(reg)) {
> > > +				verbose(env, "NULL pointer passed to trusted arg%d\n", i);
> > > +				return -EACCES;
> > > +			}
> > > +
> > 
> > Current patch looks like a stop gap solution. Just checking for register_is_null
> > is not enough, what about PTR_MAYBE_NULL? That can also be passed. Some
> > arguments can be both PTR_TO_BTF_ID and PTR_TO_MEM, so it will be bypassed in
> > the other case because this check is limited to KF_ARG_PTR_TO_MEM. It would
> 
> This wouldn't happen if you had a PTR_TO_BTF_ID, would it? In that case
> you could just rely on PTR_TRUSTED. IMO that really should be the
> default for any pointer argument. If you have KF_ARGS_TRUSTED, the kfunc
> should just be able to assume that the pointers have been verified.

+1

> Regardless, you're right that this isn't a complete solution because of
> PTR_MAYBE_NULL. I'm fine with adding an __or_null suffix that allows
> NULL, and we disallow NULL or PTR_MAYBE_NULL from any KF_TRUSTED_ARGS
> argument otherwise. Or we just also disallow PTR_MAYBE_NULL and try to
> hold off on adding yet another suffix until we have proper per-arg kfunc
> definitions.

PTR_MAYBE_NULL should not be allowed into kfunc with KF_TRUSTED_ARGS.
