Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007F9674CAA
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjATFjP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjATFiz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:38:55 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33CF2D45;
        Thu, 19 Jan 2023 21:36:49 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d16so3404056qtw.8;
        Thu, 19 Jan 2023 21:36:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NUdW2Emc9lDAF3Vieazkgagq1/SlvkgNZaOSQnTrp0=;
        b=SPYDYnrf9Yc+YM0aAluct74gSSxEToF/mbdvNIwpxOvGzd76Fl72hp/Gy8PviiwIH8
         fy3EZlAWXlIOSyqu1el5uItHYMCiGjlHJGz9MWZ1IgHhTQ6+vuFQuasaiEomjb+0M+jY
         hFJFaw16gGX9Wf5ANpMWZ7pNqNVFBE6o0t7U8NyAGuhK6eNsDvBT2oo67d5k+hJRecBv
         sxSnCujBmbX8Ln4fnWEH/JKUXeNFQPO3aRSIbHuwH+vIbd4mr7s/4jx/EmJYC4D6cOgd
         W9I/3DDg1gcxG7a1OoVUx3VoQ5fAbq/7jiRWR8gpCKGLpJHIYQE2br1b3mZdRadWkslX
         guww==
X-Gm-Message-State: AFqh2kr1inHrYc3u4f3cI66JIJEFFlrayrVVCMGq8EuG+b7Z8Vyb+dfc
        VeSfWi/NGUzgf2d+Tv0wpeE=
X-Google-Smtp-Source: AMrXdXseeG//UzEtobQHWEW3HiGnrL1t2lO5NQR/ZSKrBPr0sOEkRfioVm7M5ONgB5x1KB77JdIFLg==
X-Received: by 2002:ac8:7511:0:b0:3ae:7b4b:fb32 with SMTP id u17-20020ac87511000000b003ae7b4bfb32mr17588698qtq.48.1674192708625;
        Thu, 19 Jan 2023 21:31:48 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id c6-20020ac84e06000000b003a97a71c906sm4939364qtw.78.2023.01.19.21.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:31:48 -0800 (PST)
Date:   Thu, 19 Jan 2023 23:31:51 -0600
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 3/8] bpf: Disallow NULL PTR_TO_MEM for trusted
 kfuncs
Message-ID: <Y8onR2T2zmMU6MmH@maniforge.lan>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-4-void@manifault.com>
 <20230120052101.sevhc4jybcm6onu2@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120052101.sevhc4jybcm6onu2@apollo>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 10:51:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Fri, Jan 20, 2023 at 05:28:28AM IST, David Vernet wrote:
> > KF_TRUSTED_ARGS kfuncs currently have a subtle and insidious bug in
> > validating pointers to scalars. Say that you have a kfunc like the
> > following, which takes an array as the first argument:
> >
> > bool bpf_cpumask_empty(const struct cpumask *cpumask)
> > {
> > 	return cpumask_empty(cpumask);
> > }
> >
> > ...
> > BTF_ID_FLAGS(func, bpf_cpumask_empty, KF_TRUSTED_ARGS)
> > ...
> >
> 
> This is known and expected.

Expected? So kfuncs are expected to always check whether any pointer to
a scalar is non-NULL? Seems like a poor UX. I like your suggestion below
to address it so it's opt-in.

> > If a BPF program were to invoke the kfunc with a NULL argument, it would
> > crash the kernel. The reason is that struct cpumask is defined as a
> > bitmap, which is itself defined as an array, and is accessed as a memory
> > address memory by bitmap operations. So when the verifier analyzes the
> > register, it interprets it as a pointer to a scalar struct, which is an
> > array of size 8. check_mem_reg() then sees that the register is NULL,
> > and returns 0, and the kfunc crashes when it passes it down to the
> > cpumask wrappers.
> >
> > To fix this, this patch adds a check for KF_ARG_PTR_TO_MEM which
> > verifies that the register doesn't contain a NULL pointer if the kfunc
> > is KF_TRUSTED_ARGS.
> >
> > This may or may not be desired behavior. Some kfuncs may want to
> > allow callers to pass NULL-able pointers. An alternative would be adding
> > a KF_NOT_NULL flag and leaving KF_TRUSTED_ARGS alone, though given that
> > a kfunc is saying it wants to "trust" an argument, it seems reasonable
> > to prevent NULL.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> >  kernel/bpf/verifier.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9fa101420046..28ccb92ebe65 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9092,6 +9092,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >  					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
> >  				return -EINVAL;
> >  			}
> > +			if (is_kfunc_trusted_args(meta) && register_is_null(reg)) {
> > +				verbose(env, "NULL pointer passed to trusted arg%d\n", i);
> > +				return -EACCES;
> > +			}
> > +
> 
> Current patch looks like a stop gap solution. Just checking for register_is_null
> is not enough, what about PTR_MAYBE_NULL? That can also be passed. Some
> arguments can be both PTR_TO_BTF_ID and PTR_TO_MEM, so it will be bypassed in
> the other case because this check is limited to KF_ARG_PTR_TO_MEM. It would

This wouldn't happen if you had a PTR_TO_BTF_ID, would it? In that case
you could just rely on PTR_TRUSTED. IMO that really should be the
default for any pointer argument. If you have KF_ARGS_TRUSTED, the kfunc
should just be able to assume that the pointers have been verified.

Regardless, you're right that this isn't a complete solution because of
PTR_MAYBE_NULL. I'm fine with adding an __or_null suffix that allows
NULL, and we disallow NULL or PTR_MAYBE_NULL from any KF_TRUSTED_ARGS
argument otherwise. Or we just also disallow PTR_MAYBE_NULL and try to
hold off on adding yet another suffix until we have proper per-arg kfunc
definitions.

> probably be better to disallow NULL by default and explicitly tag the argument
> with __or_null to indicate that NULL is accepted. Seems like a much better
> default to me.
