Return-Path: <bpf+bounces-7923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2F277E7D9
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 19:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8963A281B6D
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08E174E9;
	Wed, 16 Aug 2023 17:45:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596DC168B9
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 17:45:00 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A467710C7
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 10:44:58 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7672303c831so466991285a.2
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 10:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207898; x=1692812698;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVuMzcO8qxS/KGFfXP3CK8nO4bvMkbF6t2ox2KwPB5Y=;
        b=aP5sjWPFPViRLXEhDcOMq4b1r9f0LoJod/gPIc2ELdNZtw+6GDfdyXyMMP/QNREHwL
         Z140xCSqjQ4Ah7YN/7XIaGWX4xQU78FG/5dj1ohMRBTPjyXhoE/A+Fx2DzgECtaLO5FV
         mY2MuNhQYkpG/q8P3/BBzMfC5NzlW3Mqzh3x3ClLk4D+afr8+9QADve1cwH8XpPGtscw
         ajwn6HNFXZQJslUhkcw7rv0tm2hplO3HGOVnvB3E1w3zYCUMZwMHio1f8I70u9bDa90K
         EZN0QZnB2XnyYiqOB36MlTYFAIrnXzaxIdrRQXEV3KtMw4U5sZulc/utsbRJHsD1edoc
         NFGw==
X-Gm-Message-State: AOJu0Yxfp8jG/K7z1ogkm6CI1QSF7eGnLJYpZBnSArzVHPlK0yzqUCVr
	554vcSphjwXqFpJkIoJd+YQ=
X-Google-Smtp-Source: AGHT+IEaWeOU+zFCucx4fba9b9zQaO98DysThWv2PWJMupH4Cq3/cZBdN66f50IaQqjWj7+ZbcuboQ==
X-Received: by 2002:a05:620a:2986:b0:76c:b8b0:769d with SMTP id r6-20020a05620a298600b0076cb8b0769dmr3557650qkp.39.1692207897587;
        Wed, 16 Aug 2023 10:44:57 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:6eb])
        by smtp.gmail.com with ESMTPSA id j7-20020a05620a000700b00767cfb1e859sm4569775qki.47.2023.08.16.10.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 10:44:57 -0700 (PDT)
Date: Wed, 16 Aug 2023 12:44:55 -0500
From: David Vernet <void@manifault.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add CO-RE relocs kfunc
 flavors tests
Message-ID: <20230816174455.GB814797@maniforge>
References: <20230816165813.3718580-1-davemarchevsky@fb.com>
 <20230816165813.3718580-2-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816165813.3718580-2-davemarchevsky@fb.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 09:58:13AM -0700, Dave Marchevsky wrote:
> This patch adds selftests that exercise kfunc flavor relocation
> functionality added in the previous patch. The actual kfunc defined in
> kernel/bpf/helpers.c is
> 
>   struct task_struct *bpf_task_acquire(struct task_struct *p)
> 
> The following relocation behaviors are checked:
> 
>   struct task_struct *bpf_task_acquire___one(struct task_struct *name)
>     * Should succeed despite differing param name
> 
>   struct task_struct *bpf_task_acquire___two(struct task_struct *p, void *ctx)
>     * Should fail because there is no two-param bpf_task_acquire
> 
>   struct task_struct *bpf_task_acquire___three(void *ctx)
>     * Should fail because, despite vmlinux's bpf_task_acquire having one param,
>       the types don't match
> 
> Changelog:
> v1 -> v2: https://lore.kernel.org/bpf/20230811201346.3240403-2-davemarchevsky@fb.com/
>   * Change comment on bpf_task_acquire___two to more accurately reflect
>     that it fails in same codepath as bpf_task_acquire___three, and to
>     not mention dead code elimination as thats an implementation detail
>     (Yonghong)
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
>  .../selftests/bpf/progs/task_kfunc_success.c  | 37 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> index 740d5f644b40..99abb0350154 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> @@ -79,6 +79,7 @@ static const char * const success_tests[] = {
>  	"test_task_from_pid_current",
>  	"test_task_from_pid_invalid",
>  	"task_kfunc_acquire_trusted_walked",
> +	"test_task_kfunc_flavor_relo",
>  };
>  
>  void test_task_kfunc(void)
> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> index b09371bba204..ffbe3ff72639 100644
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c

Do you think it's worth it to also add a failure case for if there's no
correct bpf_taks_acquire___one(), to verify e.g. that we can't resolve
bpf_task_acquire___three(void *ctx) __ksym __weak?

> @@ -18,6 +18,13 @@ int err, pid;
>   */
>  
>  struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __weak;
> +
> +struct task_struct *bpf_task_acquire___one(struct task_struct *task) __ksym __weak;
> +/* The two-param bpf_task_acquire doesn't exist */
> +struct task_struct *bpf_task_acquire___two(struct task_struct *p, void *ctx) __ksym __weak;
> +/* Incorrect type for first param */
> +struct task_struct *bpf_task_acquire___three(void *ctx) __ksym __weak;
> +
>  void invalid_kfunc(void) __ksym __weak;
>  void bpf_testmod_test_mod_kfunc(int i) __ksym __weak;
>  
> @@ -55,6 +62,36 @@ static int test_acquire_release(struct task_struct *task)
>  	return 0;
>  }
>  
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(test_task_kfunc_flavor_relo, struct task_struct *task, u64 clone_flags)
> +{
> +	struct task_struct *acquired = NULL;
> +	int fake_ctx = 42;
> +
> +	if (bpf_ksym_exists(bpf_task_acquire___one)) {
> +		acquired = bpf_task_acquire___one(task);
> +	} else if (bpf_ksym_exists(bpf_task_acquire___two)) {
> +		/* Here, bpf_object__resolve_ksym_func_btf_id's find_ksym_btf_id
> +		 * call will find vmlinux's bpf_task_acquire, but subsequent
> +		 * bpf_core_types_are_compat will fail
> +		 */
> +		acquired = bpf_task_acquire___two(task, &fake_ctx);
> +		err = 3;
> +		return 0;
> +	} else if (bpf_ksym_exists(bpf_task_acquire___three)) {
> +		/* bpf_core_types_are_compat will fail similarly to above case */
> +		acquired = bpf_task_acquire___three(&fake_ctx);
> +		err = 4;
> +		return 0;
> +	}
> +
> +	if (acquired)
> +		bpf_task_release(acquired);

Might be slightly simpler to do the release + return immediately in the
bpf_task_acquire___one branch, and then to just do the following here
without the if / else:

err = 5;
return 0;

What do you think?

> +	else
> +		err = 5;
> +	return 0;
> +}
> +
>  SEC("tp_btf/task_newtask")
>  int BPF_PROG(test_task_acquire_release_argument, struct task_struct *task, u64 clone_flags)
>  {
> -- 
> 2.34.1
> 
> 

