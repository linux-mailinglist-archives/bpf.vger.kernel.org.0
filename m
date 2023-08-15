Return-Path: <bpf+bounces-7844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7147D77D4B1
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 22:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F241C20E29
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 20:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE43518B0F;
	Tue, 15 Aug 2023 20:58:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685717FEA
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 20:58:34 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7642910EC
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 13:58:33 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bbb34b0abaso115009965ad.1
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692133113; x=1692737913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMM/GOHKskJe0J2OvKQqViDbFpFybuowjw08ADQN/sM=;
        b=x6LbCg2WqjdH+9diCoBrVvjfe/wKM4KWlZ7uEBCc/p4q4crX3be5mYAk6yXTWhJodp
         xFt8Lvr65qTI7+HWR2fj/pmNwWxDmZtrfnUNOxGi6Z4eyt7toaQBwZA9oq+r8eXKCffs
         6QE9TjoVurCXQVIHCOGyT+X4y52THiRGF4lcB6kkEOeg+YhBOa3I1QEvyd4p99eVeMIi
         JGZQmLQbAMjhUaoJcTVV0+aoPKVdcu8iBxjjw6b0RbmBVtgjq53guwJZjZlT59Ri46L4
         TsOzui5IK7SZZY441d+CoRvp0VVmilGWIJLZ6gIXQju2YrMDU+8KegJHw6DqGmgY13JS
         LNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133113; x=1692737913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMM/GOHKskJe0J2OvKQqViDbFpFybuowjw08ADQN/sM=;
        b=Ekf+TxYev4bUtg2xhQZbrScX+F9VTmt1W1PE63HRkMnZ/c2cXrhk572VDma+Is143S
         omycguJLquDaT//aH/nphd+URzEBcfUVzpbERxy7iamJta5NSLkMcBGsV+SlSba/J3H/
         7/8YkmCHdf1D0Y0MP4sDUi4X2NkEL8r6MMXhnuFZZtyZm5XBH6tuLRHy7vhfRMAAboi7
         oLd5xDSz9t6hm2evKmoqI9RTvbgQt51bfdURLUH5xXInQ8VGyzcGR10HYcznTRyZFLC4
         heEjLWaVozvEcSvuuKCcIK9fApbrD4zJvBNEJiZIm0VqaJBvIPSEJ2zcMU2QXphPPMWu
         Ntig==
X-Gm-Message-State: AOJu0YwrErRI165Avj9l8W+S/XGhXn8JF2fuHlLdD06kpt4wRGO+xrBu
	7LagfeTP5VRDVr/yiwul/UOadvY=
X-Google-Smtp-Source: AGHT+IGeLW+OoIxv5ifvL8XaRvSE2lUskIj+B9k4mqQkMVepztklZaHuRgYr9bNP4WUps8AdMMPayJ0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:bf94:b0:268:c310:a100 with SMTP id
 d20-20020a17090abf9400b00268c310a100mr3078086pjs.2.1692133112932; Tue, 15 Aug
 2023 13:58:32 -0700 (PDT)
Date: Tue, 15 Aug 2023 13:58:31 -0700
In-Reply-To: <20230815174712.660956-2-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230815174712.660956-1-thinker.li@gmail.com> <20230815174712.660956-2-thinker.li@gmail.com>
Message-ID: <ZNvm9/P1NJ6mecI7@google.com>
Subject: Re: [RFC bpf-next v3 1/5] bpf: enable sleepable BPF programs attached
 to cgroup/{get,set}sockopt.
From: Stanislav Fomichev <sdf@google.com>
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, yonghong.song@linux.dev, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/15, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Enable sleepable cgroup/{get,set}sockopt hooks.
> 
> The sleepable BPF programs attached to cgroup/{get,set}sockopt hooks may
> received a pointer to the optval in user space instead of a kernel
> copy. ctx->user_optval and ctx->user_optval_end are the pointers to the
> begin and end of the user space buffer if receiving a user space
> buffer. ctx->optval and ctx->optval_end will be a kernel copy if receiving
> a kernel space buffer.
> 
> A program receives a user space buffer if ctx->flags &
> BPF_SOCKOPT_FLAG_OPTVAL_USER is true, otherwise it receives a kernel space
> buffer.  The BPF programs should not read/write from/to a user space buffer
> dirrectly.  It should access the buffer through bpf_copy_from_user() and
> bpf_copy_to_user() provided in the following patches.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/linux/bpf.h    |   6 ++
>  include/linux/filter.h |   6 ++
>  kernel/bpf/cgroup.c    | 207 ++++++++++++++++++++++++++++++++---------
>  kernel/bpf/verifier.c  |   5 +-
>  4 files changed, 177 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cfabbcf47bdb..edb35bcfa548 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1769,9 +1769,15 @@ struct bpf_prog_array_item {
>  
>  struct bpf_prog_array {
>  	struct rcu_head rcu;
> +	u32 flags;
>  	struct bpf_prog_array_item items[];
>  };
>  
> +enum bpf_prog_array_flags {
> +	BPF_PROG_ARRAY_F_SLEEPABLE = 1 << 0,
> +	BPF_PROG_ARRAY_F_NON_SLEEPABLE = 1 << 1,
> +};
> +
>  struct bpf_empty_prog_array {
>  	struct bpf_prog_array hdr;
>  	struct bpf_prog *null_prog;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 761af6b3cf2b..2aa2a96526de 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1337,12 +1337,18 @@ struct bpf_sockopt_kern {
>  	s32		level;
>  	s32		optname;
>  	s32		optlen;
> +	u32		flags;
>  	/* for retval in struct bpf_cg_run_ctx */
>  	struct task_struct *current_task;
>  	/* Temporary "register" for indirect stores to ppos. */
>  	u64		tmp_reg;
>  };
>  
> +enum bpf_sockopt_kern_flags {
> +	/* optval is a pointer to user space memory */
> +	BPF_SOCKOPT_FLAG_OPTVAL_USER    = (1U << 0),
> +};
> +
>  int copy_bpf_fprog_from_user(struct sock_fprog *dst, sockptr_t src, int len);
>  
>  struct bpf_sk_lookup_kern {
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 5b2741aa0d9b..b977768a28e5 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -28,25 +28,46 @@ EXPORT_SYMBOL(cgroup_bpf_enabled_key);
>   * function pointer.
>   */
>  static __always_inline int
> -bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
> -		      enum cgroup_bpf_attach_type atype,
> -		      const void *ctx, bpf_prog_run_fn run_prog,
> -		      int retval, u32 *ret_flags)
> +bpf_prog_run_array_cg_cb(const struct cgroup_bpf *cgrp,
> +			 enum cgroup_bpf_attach_type atype,
> +			 const void *ctx, bpf_prog_run_fn run_prog,
> +			 int retval, u32 *ret_flags,
> +			 int (*progs_cb)(void *, const struct bpf_prog_array *),
> +			 void *progs_cb_arg)
>  {
>  	const struct bpf_prog_array_item *item;
>  	const struct bpf_prog *prog;
>  	const struct bpf_prog_array *array;
>  	struct bpf_run_ctx *old_run_ctx;
>  	struct bpf_cg_run_ctx run_ctx;
> +	bool do_sleepable;
>  	u32 func_ret;
> +	int err;
> +
> +	do_sleepable =
> +		atype == CGROUP_SETSOCKOPT || atype == CGROUP_GETSOCKOPT;
>  
>  	run_ctx.retval = retval;
>  	migrate_disable();
> -	rcu_read_lock();
> +	if (do_sleepable) {
> +		might_fault();
> +		rcu_read_lock_trace();
> +	} else
> +		rcu_read_lock();

nit: wrap 'else' branch with {} braces as well

