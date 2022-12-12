Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4A64ABDD
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 00:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiLLX60 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 18:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiLLX6Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 18:58:24 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EC91B9F3
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 15:58:23 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id fu10so10548376qtb.0
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 15:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgYOhDTCzzL90B4uk1gGVpe3fH7icMR4dsnRdBBLi+Q=;
        b=c3AJwGBsMn1Qw826RdxDsppyhzh2Q7ymmT+G5y2frp10rAwgd07g5qdA7i9pyZoikJ
         EB8GsqkkIQiKJAL2o3PmUKwFAgbSCHIKZgiuvILDZn3filhq3H15YpQ+AuCcPyZ0VmqW
         u5AaHKyImhzpxmn6GB7wMcDwxnKaMwuVJjsQ5abhg6uyWCL9/siV6MFFXCTGirLBf495
         +ocKYUHJedBmLELG4u2uqsOroLTckxRL4d37X8rHm8rGeMAQ+E1/AeOxJ97KfSPfNuvj
         Bt4WVrKatWEYpWMflsyU7OaSvwqb4DbIR7F+OzHCPJ/DnitO4B+2wbt/pF+t0NfzmLie
         70wQ==
X-Gm-Message-State: ANoB5pmthvXRaatAbs92NivxvD1cvAiDbGTtw7FwdHvmHuSvAgxTD21G
        bOndhaMEOxOAKmBxawaGFcc=
X-Google-Smtp-Source: AA0mqf6BCziNt9giLEXEo7+riAhdnbDHjzjTlegEDV9mWUmYtwx1wx5wWDDC+chtxAyfZpFcn2BEoA==
X-Received: by 2002:a05:622a:1e17:b0:3a5:977e:9c77 with SMTP id br23-20020a05622a1e1700b003a5977e9c77mr21959946qtb.20.1670889502350;
        Mon, 12 Dec 2022 15:58:22 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:6a51])
        by smtp.gmail.com with ESMTPSA id bb12-20020a05622a1b0c00b003a530a32f67sm6550992qtb.65.2022.12.12.15.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:58:21 -0800 (PST)
Date:   Mon, 12 Dec 2022 17:58:20 -0600
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix a selftest compilation error with
 CONFIG_SMP=n
Message-ID: <Y5fAHJTI742+jte7@maniforge.lan>
References: <20221212234617.4058942-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212234617.4058942-1-yhs@fb.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 03:46:17PM -0800, Yonghong Song wrote:
> Kernel test robot reported bpf selftest build failure when CONFIG_SMP
> is not set. The error message looks below:
> 
>   >> progs/rcu_read_lock.c:256:34: error: no member named 'last_wakee' in 'struct task_struct'
>              last_wakee = task->real_parent->last_wakee;
>                           ~~~~~~~~~~~~~~~~~  ^
>      1 error generated.
> 
> When CONFIG_SMP is not set, the field 'last_wakee' is not available in struct
> 'task_struct'. Hence the above compilation failure. To fix the issue, let us
> choose another field 'group_leader' which is available regardless of
> CONDFIG_SMP set or not.

s/CONDFIG_SMP/CONFIG_SMP

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/progs/rcu_read_lock.c      | 8 ++++----
>  tools/testing/selftests/bpf/progs/task_kfunc_failure.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> index 125f908024d3..5cecbdbbb16e 100644
> --- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> @@ -288,13 +288,13 @@ int nested_rcu_region(void *ctx)
>  SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>  int task_untrusted_non_rcuptr(void *ctx)
>  {
> -	struct task_struct *task, *last_wakee;
> +	struct task_struct *task, *group_leader;
>  
>  	task = bpf_get_current_task_btf();
>  	bpf_rcu_read_lock();
> -	/* the pointer last_wakee marked as untrusted */
> -	last_wakee = task->real_parent->last_wakee;
> -	(void)bpf_task_storage_get(&map_a, last_wakee, 0, 0);
> +	/* the pointer group_leader marked as untrusted */
> +	group_leader = task->real_parent->group_leader;
> +	(void)bpf_task_storage_get(&map_a, group_leader, 0, 0);
>  	bpf_rcu_read_unlock();
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> index 87fa1db9d9b5..1b47b94dbca0 100644
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
> @@ -73,7 +73,7 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 cl
>  	struct task_struct *acquired;
>  
>  	/* Can't invoke bpf_task_acquire() on a trusted pointer obtained from walking a struct. */
> -	acquired = bpf_task_acquire(task->last_wakee);
> +	acquired = bpf_task_acquire(task->group_leader);

Ah, I missed that you'd sent this out before I sent out [0]. Thanks for
fixing this for me. I'm fine with just merging this patch and dropping
[0] if it's easier for the maintainers.

[0]: https://lore.kernel.org/all/20221212235344.1563280-1-void@manifault.com/

>  	bpf_task_release(acquired);
>  
>  	return 0;
> -- 
> 2.30.2
> 
