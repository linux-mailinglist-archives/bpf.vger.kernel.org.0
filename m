Return-Path: <bpf+bounces-7673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374C377A50A
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 07:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0612F1C208D0
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 05:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA0F15D4;
	Sun, 13 Aug 2023 05:43:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8396F15BF
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 05:43:49 +0000 (UTC)
Received: from out-106.mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A099110FC
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 22:43:46 -0700 (PDT)
Message-ID: <ef4935f1-9908-6606-eff0-d77b2252b5d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691905424; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lA/9Vrm/ip0akPZeNsxMv9EC75InQlpce9XIIX+ya4c=;
	b=kw+DvXbA8JYsfutSIjTdtonSIjh2mlRmPm4yG0MIXO09daaXjOaPbpWZBlgBH1FuVsvzro
	24I+7vem50RNbMs33kb40TwW59Yc3cx4Mu+3DfV1gPC3JKlbT99qYVMA0qfe8ICP4+1jh0
	QepMuDmyU4i+vF2c5gTPpgjpYoHR8TE=
Date: Sat, 12 Aug 2023 22:43:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add CO-RE relocs kfunc
 flavors tests
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Tejun Heo <tj@kernel.org>, dvernet@meta.com
References: <20230811201346.3240403-1-davemarchevsky@fb.com>
 <20230811201346.3240403-2-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230811201346.3240403-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 1:13 PM, Dave Marchevsky wrote:
> This patch adds selftests that exercise kfunc flavor relocation
> functionality added in the previous patch. The actual kfunc defined in
> kernel/bpf/helpers.c is
> 
>    struct task_struct *bpf_task_acquire(struct task_struct *p)
> 
> The following relocation behaviors are checked:
> 
>    struct task_struct *bpf_task_acquire___one(struct task_struct *name)
>      * Should succeed despite differing param name
> 
>    struct task_struct *bpf_task_acquire___two(struct task_struct *p, void *ctx)
>      * Should fail because there is no two-param bpf_task_acquire
> 
>    struct task_struct *bpf_task_acquire___three(void *ctx)
>      * Should fail because, despite vmlinux's bpf_task_acquire having one param,
>        the types don't match
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   .../selftests/bpf/prog_tests/task_kfunc.c     |  1 +
>   .../selftests/bpf/progs/task_kfunc_success.c  | 41 +++++++++++++++++++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> index 740d5f644b40..99abb0350154 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
> @@ -79,6 +79,7 @@ static const char * const success_tests[] = {
>   	"test_task_from_pid_current",
>   	"test_task_from_pid_invalid",
>   	"task_kfunc_acquire_trusted_walked",
> +	"test_task_kfunc_flavor_relo",
>   };
>   
>   void test_task_kfunc(void)
> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> index b09371bba204..33e1eb88874f 100644
> --- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
> @@ -18,6 +18,13 @@ int err, pid;
>    */
>   
>   struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __weak;
> +
> +struct task_struct *bpf_task_acquire___one(struct task_struct *task) __ksym __weak;
> +/* The two-param bpf_task_acquire doesn't exist */
> +struct task_struct *bpf_task_acquire___two(struct task_struct *p, void *ctx) __ksym __weak;
> +/* Incorrect type for first param */
> +struct task_struct *bpf_task_acquire___three(void *ctx) __ksym __weak;
> +
>   void invalid_kfunc(void) __ksym __weak;
>   void bpf_testmod_test_mod_kfunc(int i) __ksym __weak;
>   
> @@ -55,6 +62,40 @@ static int test_acquire_release(struct task_struct *task)
>   	return 0;
>   }
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
> +		/* if verifier's dead code elimination doesn't remove this,
> +		 * verification should fail due to return w/o bpf_task_release
> +		 */
> +		acquired = bpf_task_acquire___two(task, &fake_ctx);
> +		err = 3;
> +		return 0;
> +	} else if (bpf_ksym_exists(bpf_task_acquire___three)) {
> +		/* Here, bpf_object__resolve_ksym_func_btf_id's find_ksym_btf_id
> +		 * call will find vmlinux's bpf_task_acquire, but subsequent
> +		 * bpf_core_types_are_compat will fail
> +		 *
> +		 * Should be removed by dead code elimination similar to ___two
> +		 */
> +		acquired = bpf_task_acquire___three(&fake_ctx);
> +		err = 4;
> +		return 0;
> +	}

The comments for the above 'bpf_task_acquire___two' and 
'bpf_task_acquire___three' a little confusing. For example, for
'bpf_task_acquire___two', libbpf incorrectly made
'bpf_ksym_exists(bpf_task_acquire___two)' non-NULL, hence
dead code elimination cannot happen and verification will
fail due to missing bpf_task_release. But if libbpf correctly
made ''bpf_ksym_exists(bpf_task_acquire___two)' NULL, but
verifier didn't remove dead code, we should be fine.

I think both 'bpf_task_acquire___two' and 'bpf_task_acquire___three'
can use the same comment as in 'bpf_task_acquire___three'.
There is no need to mention dead code elimination which is
not important for this patch set.

> +
> +	if (acquired)
> +		bpf_task_release(acquired);
> +	else
> +		err = 5;
> +	return 0;
> +}
> +
>   SEC("tp_btf/task_newtask")
>   int BPF_PROG(test_task_acquire_release_argument, struct task_struct *task, u64 clone_flags)
>   {

