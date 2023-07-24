Return-Path: <bpf+bounces-5738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 383F675FF36
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1775280A91
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353D9DDCD;
	Mon, 24 Jul 2023 18:37:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E3100C3
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 18:37:03 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB101BDD
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 11:36:39 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5634dbfb8b1so2096970a12.1
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690223793; x=1690828593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qfShs5zLw4LarksoGBXTE+xXf9F8mLlRPk2Uysvxuq0=;
        b=XqIoiIL8h6/pXa/kmA1rSi1JJl41zOIx6TvCLsymb+7FQX2B7qU+Zjv9n/DIUfqWwz
         8Mij+0SbAF1cDzVK4rvS6ZK/OHNvJBbScyX9NYq0X0m0sN+AwnQkP7M1/024uKLwat/h
         8Qd0BwLHS83hy+4zUA1Lse2dcXREFu3pCVHkbu08XHfW6qFML2+z2W4yXEJCivO8VeKd
         Y6mzOYA4HxWum2zLZZAQAgqWHojhoykXzM+HpizXVHURjQKk6XPvt9l9mKtM1s82QW8M
         wJ9KcMd7nf/uzYmhmfBURqtnR4nIyDA8flsvGq95RfkkCjrtN5Z+jcCTyvGc2vax73JQ
         b55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690223793; x=1690828593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfShs5zLw4LarksoGBXTE+xXf9F8mLlRPk2Uysvxuq0=;
        b=Ij+VAdLH9lCOWYAy3mI2BZxcLSBiZxsZWkpSgdw2WrZlQZ3hBH6Uu1Na7GrWiTuvO4
         CmMz2ilCUxjqNmD8UeF31+E5KA2JkwCG16dgfLpYYDngwzF4aKYun0c/e1CqVzs70nAS
         RAwC1egERi3oRGXMqQqLufVKH4TuvW05SzIbAF6zQKqRFrsWVb9Xjq+PnaiWbRIy19Zf
         8Fr7twekKB/I6nANNiGrfibxmrqmRZaO61bxd4axyaQaaA7/Fpwt4T6izguk3STouFMc
         c2Wv/29/Y/HgiYpzdhMcgzMbHedWRdHg/ghXpTWT0Wr6mEtoD0DA2igsI7g5f7ZxeEWt
         oJOw==
X-Gm-Message-State: ABy/qLbsKwC+pAjG1hJSipgR0yRPIDuftmondI3/0m+Gzz1hFtl6SmPy
	mVZ+HbwZDMeqtD3orcdZQTSrMtE=
X-Google-Smtp-Source: APBJJlG8g5e5LOBRuljTlm+V0DL5bbahctnJE2KklSROOT7kBAGu2Vy4OhJ2yvZDva/hGVCw0Ua1H9I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:935d:0:b0:557:6227:bf47 with SMTP id
 w29-20020a63935d000000b005576227bf47mr40422pgm.9.1690223793012; Mon, 24 Jul
 2023 11:36:33 -0700 (PDT)
Date: Mon, 24 Jul 2023 11:36:31 -0700
In-Reply-To: <20230722052248.1062582-2-kuifeng@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230722052248.1062582-1-kuifeng@meta.com> <20230722052248.1062582-2-kuifeng@meta.com>
Message-ID: <ZL7Ery1lzqj4as7N@google.com>
Subject: Re: [RFC bpf-next 1/5] bpf: enable sleepable BPF programs attached to cgroup/{get,set}sockopt.
From: Stanislav Fomichev <sdf@google.com>
To: kuifeng@meta.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/21, kuifeng@meta.com wrote:
> From: Kui-Feng Lee <kuifeng@meta.com>
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
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  include/linux/filter.h         |   3 +
>  include/uapi/linux/bpf.h       |   9 ++
>  kernel/bpf/cgroup.c            | 189 ++++++++++++++++++++++++++-------
>  kernel/bpf/verifier.c          |   7 +-
>  tools/include/uapi/linux/bpf.h |   9 ++
>  tools/lib/bpf/libbpf.c         |   2 +
>  6 files changed, 176 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f69114083ec7..301dd1ba0de1 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1345,6 +1345,9 @@ struct bpf_sockopt_kern {
>  	s32		level;
>  	s32		optname;
>  	s32		optlen;
> +	u32		flags;
> +	u8		*user_optval;
> +	u8		*user_optval_end;
>  	/* for retval in struct bpf_cg_run_ctx */
>  	struct task_struct *current_task;
>  	/* Temporary "register" for indirect stores to ppos. */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 739c15906a65..b2f81193f97b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7135,6 +7135,15 @@ struct bpf_sockopt {
>  	__s32	optname;
>  	__s32	optlen;
>  	__s32	retval;
> +
> +	__bpf_md_ptr(void *, user_optval);
> +	__bpf_md_ptr(void *, user_optval_end);

Can we re-purpose existing optval/optval_end pointers
for the sleepable programs? IOW, when the prog is sleepable,
pass user pointers via optval/optval_end and require the programs
to do copy_to/from on this buffer (even if the backing pointer might be
in kernel memory - we can handle that in the kfuncs?).

The fact that the program now needs to look at the flag
(BPF_SOCKOPT_FLAG_OPTVAL_USER) and decide which buffer to
use makes the handling even more complicated; and we already have a
bunch of hairy stuff in these hooks. (or I misreading the change?)

Also, regarding sleepable and non-sleepable co-existence: do we really need
that? Can we say that all the programs have to be sleepable
or non-sleepable? Mixing them complicates the sharing of that buffer.

