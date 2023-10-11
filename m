Return-Path: <bpf+bounces-11848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7518C7C45FF
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 02:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB46281E8D
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 00:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A133A37C;
	Wed, 11 Oct 2023 00:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EO0IHhDk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708E6198
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 00:22:44 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E799B
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 17:22:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690ba63891dso4733110b3a.2
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696983762; x=1697588562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/rALABEczzNST8WZ4aRlp2uiCIevJ/Xw+UzrDvDEZ4=;
        b=EO0IHhDk+sontdNHt5wvzspR1k15GI/lBJg+imNyHUaw2WY8M9TOiSZR6zbJRcaQv6
         z1EVeYz5gAbpaIlXvzaqtzaSNoCc2HgfovOXzblsNwgW6iuURxj6rQIJdHqaxmaThgLJ
         xcFGv+o1LIVvWOJE3Htv0vJuKiwjb6JG+Mtpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696983762; x=1697588562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/rALABEczzNST8WZ4aRlp2uiCIevJ/Xw+UzrDvDEZ4=;
        b=a0DTkIzvKs0oUhrJPKJtlKPx7ybHGyMAklIQ43VJGMRtq9JGQDVF06v8R60QN9774F
         Ee7ndtlJdC5tBgDE4IIHHIl1RjcU0X170bnMXGYy3I92ivciBlArUo1P4lJBOIMzwh13
         /+q3OyVMXJTmoDHmYfM8bbxPsHiviMesHkrTubHcbs4tZZPKEuxDa0HgRjmj92r2x1Wk
         s6J6F6sdxzNkSCW5Q21wEDum9lGx39A5NK5DruqdRKCfZ4+ILmcLNYyM+pPsel/TjSfv
         aB+NOI5zvowlDSQVbV4DePFGgPY7+sRjTdlZztCnv2US3xma0tXQsy3bvxMN5Ma/XG97
         V1Cw==
X-Gm-Message-State: AOJu0YxICg1xS3gkgAqbtZVTGIr4e3l9gxaDqnjuvD8hWDLsVI1QkoiL
	Qs4mC0WosYpAGfnNp8ZW3t8LdQ==
X-Google-Smtp-Source: AGHT+IEakwlzUI5SboubUfKw6Cl95VtCM0/lU0VCTjtlNNeZXSXZGPrb8HOFw9mKPGjdYeV8Z/dF1w==
X-Received: by 2002:a05:6a00:b82:b0:68f:e810:e894 with SMTP id g2-20020a056a000b8200b0068fe810e894mr21672693pfj.33.1696983761829;
        Tue, 10 Oct 2023 17:22:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y4-20020aa78544000000b006878cc942f1sm8821650pfn.54.2023.10.10.17.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:22:41 -0700 (PDT)
Date: Tue, 10 Oct 2023 17:22:40 -0700
From: Kees Cook <keescook@chromium.org>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, luto@amacapital.net,
	wad@chromium.org, alexyonghe@tencent.com
Subject: Re: [PATCH 3/4] seccomp: Introduce SECCOMP_ATTACH_FILTER operation
Message-ID: <202310101719.2E6AA3E@keescook>
References: <20231009124046.74710-1-hengqi.chen@gmail.com>
 <20231009124046.74710-4-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009124046.74710-4-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 12:40:45PM +0000, Hengqi Chen wrote:
> The SECCOMP_ATTACH_FILTER operation is used to attach
> a loaded filter to the current process. The loaded filter
> is represented by a fd which is either returned by the
> SECCOMP_LOAD_FILTER operation or obtained from bpffs using
> bpf syscall.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  include/uapi/linux/seccomp.h |  1 +
>  kernel/seccomp.c             | 68 +++++++++++++++++++++++++++++++++---
>  2 files changed, 64 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index ee2c83697810..fbe30262fdfc 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -17,6 +17,7 @@
>  #define SECCOMP_GET_ACTION_AVAIL	2
>  #define SECCOMP_GET_NOTIF_SIZES		3
>  #define SECCOMP_LOAD_FILTER		4
> +#define SECCOMP_ATTACH_FILTER		5
>  
>  /* Valid flags for SECCOMP_SET_MODE_FILTER */
>  #define SECCOMP_FILTER_FLAG_TSYNC		(1UL << 0)
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 3ae43db3b642..9f9d8a7a1d6e 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -523,7 +523,10 @@ static inline pid_t seccomp_can_sync_threads(void)
>  static inline void seccomp_filter_free(struct seccomp_filter *filter)
>  {
>  	if (filter) {
> -		bpf_prog_destroy(filter->prog);
> +		if (filter->prog->type == BPF_PROG_TYPE_SECCOMP)
> +			bpf_prog_put(filter->prog);
> +		else
> +			bpf_prog_destroy(filter->prog);
>  		kfree(filter);
>  	}
>  }
> @@ -894,7 +897,7 @@ static void seccomp_cache_prepare(struct seccomp_filter *sfilter)
>  #endif /* SECCOMP_ARCH_NATIVE */
>  
>  /**
> - * seccomp_attach_filter: validate and attach filter
> + * seccomp_do_attach_filter: validate and attach filter
>   * @flags:  flags to change filter behavior
>   * @filter: seccomp filter to add to the current process
>   *
> @@ -905,8 +908,8 @@ static void seccomp_cache_prepare(struct seccomp_filter *sfilter)
>   *     seccomp mode or did not have an ancestral seccomp filter
>   *   - in NEW_LISTENER mode: the fd of the new listener
>   */
> -static long seccomp_attach_filter(unsigned int flags,
> -				  struct seccomp_filter *filter)
> +static long seccomp_do_attach_filter(unsigned int flags,
> +				     struct seccomp_filter *filter)
>  {
>  	unsigned long total_insns;
>  	struct seccomp_filter *walker;
> @@ -2001,7 +2004,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  		goto out;
>  	}
>  
> -	ret = seccomp_attach_filter(flags, prepared);
> +	ret = seccomp_do_attach_filter(flags, prepared);
>  	if (ret)
>  		goto out;
>  	/* Do not free the successfully attached filter. */
> @@ -2058,6 +2061,51 @@ static long seccomp_load_filter(const char __user *filter)
>  		bpf_prog_put(prog);
>  	return ret;
>  }
> +
> +static long seccomp_attach_filter(const char __user *ufd)
> +{
> +	const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
> +	struct seccomp_filter *sfilter;
> +	struct bpf_prog *prog;
> +	int flags = 0;
> +	int fd, ret;
> +
> +	if (copy_from_user(&fd, ufd, sizeof(fd)))
> +		return -EFAULT;
> +
> +	prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SECCOMP);
> +	if (IS_ERR(prog))
> +		return PTR_ERR(prog);
> +
> +	sfilter = kzalloc(sizeof(*sfilter), GFP_KERNEL | __GFP_NOWARN);
> +	if (!sfilter) {
> +		bpf_prog_put(prog);
> +		return -ENOMEM;
> +	}
> +
> +	sfilter->prog = prog;
> +	refcount_set(&sfilter->refs, 1);
> +	refcount_set(&sfilter->users, 1);
> +	mutex_init(&sfilter->notify_lock);
> +	init_waitqueue_head(&sfilter->wqh);
> +
> +	spin_lock_irq(&current->sighand->siglock);
> +
> +	ret = -EINVAL;
> +	if (!seccomp_may_assign_mode(seccomp_mode))
> +		goto out;
> +
> +	ret = seccomp_do_attach_filter(flags, sfilter);
> +	if (ret)
> +		goto out;
> +
> +	sfilter = NULL;
> +	seccomp_assign_mode(current, seccomp_mode, flags);
> +out:
> +	spin_unlock_irq(&current->sighand->siglock);
> +	seccomp_filter_free(sfilter);
> +	return ret;
> +}

This is duplicating part of seccomp_set_mode_filter() but without
handling flags at all. This isn't really workable, since we need things
like TSYNC, etc. I think it would be better to adjust
SECCOMP_SET_MODE_FILTER to take a new flag that indicates that the user
arg is an fd, not a filter. Then the middle of seccomp_set_mode_filter()
can choosen between seccomp_prepare_user_filter() and a wrapped call to
bpf_prog_get_type() on the fd, etc.

-- 
Kees Cook

