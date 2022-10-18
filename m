Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899086020A9
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 03:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJRB4f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 21:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJRB4e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 21:56:34 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3FF76966;
        Mon, 17 Oct 2022 18:56:28 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-136b5dd6655so15358300fac.3;
        Mon, 17 Oct 2022 18:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsOWludHMguvR58jxm4YGoRknUTgkRYO+96n1DUatLA=;
        b=B8Mfiwc613sZw+s2Iw9zQ2Q6/pU0U5qJ82H5uqsAa+JwtocohF3Rose5Ka0Qp4dYrn
         KVRl5lzJBrke9+mx4af5UP2kI1VWbvHIkQ1t2bd0EwZNIJPjFgWBdTU2ztf1HgN0/9oj
         VO/1Roc7yveNWOOdg42mxUaMyQMzWyzGv6tZoyd7OczK6TrefYlHVG4gZhUg8DzdfnFv
         2YlzxhG/zo6RcrHHS3X4Pu3ww66/7DFUmqs1eQReiJwnUA1EHV8mn7ibxI0kB5yXWn6B
         +nsKnI0gT9XoR5LuRtMYydqqNVyJvpm3kDd6qCNenxHKO7qyaSKTfivIi4PmCfcGzQuq
         TQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsOWludHMguvR58jxm4YGoRknUTgkRYO+96n1DUatLA=;
        b=3qgRw0OfM/6HXfT1IF87b/7InvoTdf/u62eoHwdC0EGXW5VRgP93DhxtqKj85ngmtt
         8N1y7k0KVnEw2+WXLAWqIdVn8/3dTCvhP4eJgCRuiv1RgmT0Jv/kZ6Hz/w3SvhYr3G12
         elMLQkYKOOuVsPU0qThfcNlSTJDwLnVz/tafMEViJxISTkR5H0w8Yq6CAp8Z7Uynah/r
         AmvkHnX2KnNsIRTXN7sskyA/9zVopvl8nPhymkryiig7Jnfe9IOMhRtfwv5GZYQOhltK
         KhdWIVDeybT+WXU3T7YZHJmCqtka9fMhNJfPm3yUa7stFsRnNBEOxO4D4WGAUX3eEdrv
         mFDw==
X-Gm-Message-State: ACrzQf32HY4+u5z5t1mvjjosp3T0FSaBfOEUFeLEAzG3P9/xVjUNRlCo
        DRQh89DVyVeiTYH6yIT3xNzGszltUKsswktCtJM=
X-Google-Smtp-Source: AMsMyM52HxcTfY6GSOSB82yfxz5kFXA0AKse2OKY+s7zy1c7toEkXiR1h/2nWXkh2hdNw9f7rmqKb69nWs/SXhxbXj4=
X-Received: by 2002:a05:6870:178e:b0:126:7055:fc78 with SMTP id
 r14-20020a056870178e00b001267055fc78mr410059oae.58.1666058187237; Mon, 17 Oct
 2022 18:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221014212133.2520531-1-void@manifault.com> <20221014212133.2520531-3-void@manifault.com>
In-Reply-To: <20221014212133.2520531-3-void@manifault.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 18 Oct 2022 07:25:46 +0530
Message-ID: <CAP01T77WVXqeZVBYP=Ur=74oTwvGaLOeryYo=HqeBQ9Db9A93g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: Add kfuncs for storing struct task_struct *
 as a kptr
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 15 Oct 2022 at 02:51, David Vernet <void@manifault.com> wrote:
>
> Now that BPF supports adding new kernel functions with kfuncs, and
> storing kernel objects in maps with kptrs, we can add a set of kfuncs
> which allow struct task_struct objects to be stored in maps as
> referenced kptrs. The possible use cases for doing this are plentiful.
> During tracing, for example, it would be useful to be able to collect
> some tasks that performed a certain operation, and then periodically
> summarize who they are, which cgroup they're in, how much CPU time
> they've utilized, etc.
>
> In order to enable this, this patch adds three new kfuncs:
>
> struct task_struct *bpf_task_acquire(struct task_struct *p);
> struct task_struct *bpf_task_kptr_get(struct task_struct **pp);
> void bpf_task_release(struct task_struct *p);
>
> A follow-on patch will add selftests validating these kfuncs.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  [...]
> +/**
> + * bpf_task_release - Release the reference acquired on a struct task_struct *.
> + * If this kfunc is invoked in an RCU read region, the task_struct is
> + * guaranteed to not be freed until the current grace period has ended, even if
> + * its refcount drops to 0.
> + * @p: The task on which a reference is being released.
> + */
> +__used noinline void bpf_task_release(struct task_struct *p)
> +{
> +       if (!p)
> +               return;
> +
> +       put_task_struct_rcu_user(p);
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(generic_kfunc_btf_ids)
>  #ifdef CONFIG_KEXEC_CORE
>  BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>  #endif
> -BTF_SET8_END(tracing_btf_ids)
> +BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE | KF_TRUSTED_ARGS)

You can remove KF_TRUSTED_ARGS here for bpf_task_release, if this is
required, it would be a bug.
