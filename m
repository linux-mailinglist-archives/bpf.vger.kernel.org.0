Return-Path: <bpf+bounces-23-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B266F76E8
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082EB1C21653
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0528156FE;
	Thu,  4 May 2023 20:14:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD60156CB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 20:14:48 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9EF1E9BC
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 13:14:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64388cf3263so781191b3a.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683231212; x=1685823212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWu2OzIf/4j8p6j2UaD0P6CxNpNINGY3SlHxaIDd4Bs=;
        b=CfftJmH8MPsliTGBfvNzhU5/+sN0hoIFIQJNNAIIyI86/4Lw5wvfcIi8VBb7TEVVjw
         trw7bSiiDRP3wYmI9sPWLf9p+RkxqP4A2KP6VGdznhoFnfX74FXowJPDB21AQp4ZNVzI
         LsBltMkInjTya4HOR8GX1KTW2utY6oWIkYED4bk9vPUbRqnHnvYHmJlsD4bExdmzYycS
         5RsT0zsp3fcJbGja++tCyfiyEKnHWWNGh9BXjBZIuOEyPgaGvwsgxtDLlCGND/36UJL3
         MpQP2jdZgftS0gZQHVURxNiGHhNWHrZrJgbk+xDwIuDFpMMDPfkbPtOvoONlPSUv3vdq
         0bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683231212; x=1685823212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWu2OzIf/4j8p6j2UaD0P6CxNpNINGY3SlHxaIDd4Bs=;
        b=ZEo1x+YxLGjkIUHOAB5wNHU8XYLqjd0dBmMW13r5t1C81xNt4A0pEHT5QBoZVFOeMp
         l60uGqGAz8ZVY8AkLWLTgHESCZNzuuVUvAKkaB+SNO3hn0sYjp+we92yRoVWoBJoL2Dr
         sfWe4R8NoS+uXHnRoxX4gvl1MLMeCrbXcUuV/xlEQjS1hkGBu2cEAPQvyDU8EcjJBUn2
         EDDEDkXxSoxOQQoPiNLeAE2yoog7gorNe3sIYHqRjZJG2bpMxTxK1ukREYGzO8OvUP9N
         8TYxgaJFEdTgqvitpflMuU4lFxPIghXPMvWuDv1T1axd4OW3mJMv0NfmI76PpuiX0MP6
         a3eg==
X-Gm-Message-State: AC+VfDzQtaMyV8y8DBW5XEO88CZ2XtMtPntieZrq0LMZEKy+m4YJAJ6D
	sGSWewj3qMx1jEho+k6AMvc=
X-Google-Smtp-Source: ACHHUZ4pgg5D7auDLhE0AzlHdXLEhlDdSw7DVTh1Xwk0dqK+O4KIq+8MZnDpc0V0Ax1AHnwLPkK7ag==
X-Received: by 2002:a05:6a00:2186:b0:63b:6911:8928 with SMTP id h6-20020a056a00218600b0063b69118928mr3978847pfi.3.1683231211935;
        Thu, 04 May 2023 13:13:31 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::6:168f])
        by smtp.gmail.com with ESMTPSA id j23-20020aa79297000000b0063d3801d196sm93219pfa.23.2023.05.04.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 13:13:31 -0700 (PDT)
Date: Thu, 4 May 2023 13:12:58 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 06/10] bpf: keep BPF_PROG_LOAD permission checks
 clear of validations
Message-ID: <20230504201258.co6nej2iraprngrq@MacBook-Pro-6.local>
References: <20230502230619.2592406-1-andrii@kernel.org>
 <20230502230619.2592406-7-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502230619.2592406-7-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 02, 2023 at 04:06:15PM -0700, Andrii Nakryiko wrote:
> Move out flags validation and license checks out of the permission
> checks. They were intermingled, which makes subsequent changes harder.
> Clean this up: perform straightforward flag validation upfront, and
> fetch and check license later, right where we use it. Also consolidate
> capabilities check in one block, right after basic attribute sanity
> checks.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/syscall.c | 44 +++++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 2e5ca52c45c4..d960eb476754 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2573,18 +2573,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  	struct btf *attach_btf = NULL;
>  	int err;
>  	char license[128];
> -	bool is_gpl;
> -
> -	/* Intent here is for unprivileged_bpf_disabled to block key object
> -	 * creation commands for unprivileged users; other actions depend
> -	 * of fd availability and access to bpffs, so are dependent on
> -	 * object creation success.  Capabilities are later verified for
> -	 * operations such as load and map create, so even with unprivileged
> -	 * BPF disabled, capability checks are still carried out for these
> -	 * and other operations.
> -	 */
> -	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> -		return -EPERM;
>  
>  	if (CHECK_ATTR(BPF_PROG_LOAD))
>  		return -EINVAL;
> @@ -2598,21 +2586,22 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  				 BPF_F_XDP_DEV_BOUND_ONLY))
>  		return -EINVAL;
>  
> +	/* Intent here is for unprivileged_bpf_disabled to block key object
> +	 * creation commands for unprivileged users; other actions depend
> +	 * of fd availability and access to bpffs, so are dependent on
> +	 * object creation success.  Capabilities are later verified for
> +	 * operations such as load and map create, so even with unprivileged
> +	 * BPF disabled, capability checks are still carried out for these
> +	 * and other operations.
> +	 */
> +	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> +		return -EPERM;
> +

Since that part was done in patch 1. Move it into right spot in patch 1 right away?

>  	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
>  	    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
>  	    !bpf_capable())
>  		return -EPERM;
>  
> -	/* copy eBPF program license from user space */
> -	if (strncpy_from_bpfptr(license,
> -				make_bpfptr(attr->license, uattr.is_kernel),
> -				sizeof(license) - 1) < 0)
> -		return -EFAULT;
> -	license[sizeof(license) - 1] = 0;
> -
> -	/* eBPF programs must be GPL compatible to use GPL-ed functions */
> -	is_gpl = license_is_gpl_compatible(license);
> -
>  	if (attr->insn_cnt == 0 ||
>  	    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
>  		return -E2BIG;
> @@ -2700,7 +2689,16 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  	prog->jited = 0;
>  
>  	atomic64_set(&prog->aux->refcnt, 1);
> -	prog->gpl_compatible = is_gpl ? 1 : 0;
> +
> +	/* copy eBPF program license from user space */
> +	if (strncpy_from_bpfptr(license,
> +				make_bpfptr(attr->license, uattr.is_kernel),
> +				sizeof(license) - 1) < 0)
> +		return -EFAULT;

This 'return' is incorrect. It misses lots of cleanup.
Should probably be 'goto free_prog_sec', but pls double check. 
We don't have tests to check error handling. Just lucky code review.

> +	license[sizeof(license) - 1] = 0;
> +
> +	/* eBPF programs must be GPL compatible to use GPL-ed functions */
> +	prog->gpl_compatible = license_is_gpl_compatible(license) ? 1 : 0;
>  
>  	if (bpf_prog_is_dev_bound(prog->aux)) {
>  		err = bpf_prog_dev_bound_init(prog, attr);
> -- 
> 2.34.1
> 

