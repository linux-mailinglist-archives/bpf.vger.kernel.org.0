Return-Path: <bpf+bounces-8076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CF4780EFB
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1301C20E11
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2004918C34;
	Fri, 18 Aug 2023 15:20:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8E18C1E
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:20:46 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C522026BB
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:20:45 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-76d83954c40so65294485a.1
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372044; x=1692976844;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQoXaszgXNHt2owMkc8SAwAa6PGA1R7cXDpG3YgUdis=;
        b=i1eB1qOXKvx3pimfYhzWuPDYK2U4O8Cr3l7ltE4lzMKw5E5jlzdD/j6JfM5yd545eS
         3CO9EjCJ5eFCLjiTxegq2oI9RRzEG65sedv+dJx3ZPoiHouYHyEGlPy03/jNUYw1e3y5
         Xta4vs3TiGAMLoJW9HrJttCS91GEoSWf/SWr2Go7HDTBIggtWfDrOmV75d4U7maJbaYF
         xnV1ATb8fHc7T+broOR4xXGnEs3C9jrWk55FQhgey54dAkeAaNBv2LvYsdlzUAIyDrZU
         ssZvz4Yyd3I1szb+lRgD91UUK63Ha+QrQySiRJJMK6yCNY8hAQ/1uQw6ry2mNFi3f/tH
         tLbQ==
X-Gm-Message-State: AOJu0YxN+6Bb9cPUIyS+BlwMXsxHU/bfIlENNcKsgZq0QsDGWZcD5i2g
	TctwkbZ0MvCMz95UfXOdSMY=
X-Google-Smtp-Source: AGHT+IFIPnPBBG+mGseArgo/zti5URsZkps0wsdFoxu+N2i7ppuTQYN1v+kKSEFBRafZaXCpmZ017g==
X-Received: by 2002:a05:622a:1aa9:b0:405:4eec:6341 with SMTP id s41-20020a05622a1aa900b004054eec6341mr3562557qtc.56.1692372043958;
        Fri, 18 Aug 2023 08:20:43 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:766])
        by smtp.gmail.com with ESMTPSA id y10-20020ac8524a000000b0040ff2f2f172sm579550qtn.38.2023.08.18.08.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:20:43 -0700 (PDT)
Date: Fri, 18 Aug 2023 10:20:41 -0500
From: David Vernet <void@manifault.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Add CO-RE relocs kfunc
 flavors tests
Message-ID: <20230818152041.GB14411@maniforge>
References: <20230817225353.2570845-1-davemarchevsky@fb.com>
 <20230817225353.2570845-2-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817225353.2570845-2-davemarchevsky@fb.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 03:53:53PM -0700, Dave Marchevsky wrote:
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
> v2 -> v3: https://lore.kernel.org/bpf/20230816165813.3718580-2-davemarchevsky@fb.com/
>   * Add test demonstrating that resolution success / failure of
>     one flavor variant is independent from success / failure of others,
>     and that none need succeed (David Vernet)
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: David Vernet <void@manifault.com>

> ---
>  .../selftests/bpf/prog_tests/task_kfunc.c     |  2 +
>  .../selftests/bpf/progs/task_kfunc_success.c  | 51 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> index 740d5f644b40..d4579f735398 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> @@ -79,6 +79,8 @@ static const char * const success_tests[] = {
>  	"test_task_from_pid_current",
>  	"test_task_from_pid_invalid",
>  	"task_kfunc_acquire_trusted_walked",
> +	"test_task_kfunc_flavor_relo",
> +	"test_task_kfunc_flavor_relo_not_found",
>  };
>  
>  void test_task_kfunc(void)
> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> index b09371bba204..70df695312dc 100644
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
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
> @@ -55,6 +62,50 @@ static int test_acquire_release(struct task_struct *task)
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
> +	else
> +		err = 5;
> +	return 0;
> +}
> +
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(test_task_kfunc_flavor_relo_not_found, struct task_struct *task, u64 clone_flags)
> +{
> +	/* Neither symbol should successfully resolve.
> +	 * Success or failure of one ___flavor should not affect others
> +	 */
> +	if (bpf_ksym_exists(bpf_task_acquire___two))
> +		err = 1;
> +	else if (bpf_ksym_exists(bpf_task_acquire___three))
> +		err = 2;
> +
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

