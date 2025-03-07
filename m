Return-Path: <bpf+bounces-53568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1C1A56718
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 12:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE1547A7571
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA889218592;
	Fri,  7 Mar 2025 11:51:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A221218587
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348314; cv=none; b=Oe/fLnmmII323pnUGeBzCHUZdd3w1mp6rAepV7TCs8iHxo9VsDXHBZqcAaKsG1TmROSlMlKgEnxjVsd3N3WzU9mLp1LhnMn/Kw/tzyI83exzJNntHsn+uFb6Mhjthes99Tfs1K8RRly1V/h4pZ8M4wj1Cia3pTtHulVBpW0+M50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348314; c=relaxed/simple;
	bh=9zDpnJ/QCxBsgXxW2KKV5v+N/nLcR1t4N8TVQeXaVTs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F33Wo0LVBfc+m0CcxuJqARxfTnb7dWk93oJQXjYMJk03lO48oImNOFK42qrE3/8qOolE9ZdpOSkCQSXuvMSZoSqgv+zqOS5waNUS/o3REfOUfyZVP6hlTYpPZO6CZXJKqjwYJxgYVA/3RkcnAMPKmciMhgGAk3afk9lMX8t+Lao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z8Pl12g1Kz4f3jMy
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 19:51:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8F7551A1376
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 19:51:47 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDnS2DP3cpnCWM2Fw--.31278S2;
	Fri, 07 Mar 2025 19:51:47 +0800 (CST)
Subject: Re: [PATCH v5 4/4] selftests: bpf: add missing cpumask test to runner
 and annotate existing tests
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 tj@kernel.org, memxor@gmail.com
References: <20250307041738.6665-1-emil@etsalapatis.com>
 <20250307041738.6665-5-emil@etsalapatis.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <611d1891-f082-6743-efe1-bbbe1c83052d@huaweicloud.com>
Date: Fri, 7 Mar 2025 19:51:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250307041738.6665-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDnS2DP3cpnCWM2Fw--.31278S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1xCFykur4rur1xWrW3Wrg_yoW3XFWkpa
	97CayDKFZrJF4Fg34UZ39FkF1aqw1kAa1jkryrG3WayrW7tr48GF1jg3W7Ar1Ykr1v93Wf
	Z34qgr13Ww1UWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 3/7/2025 12:17 PM, Emil Tsalapatis wrote:
> The BPF cpumask selftests are supposed to be run twice, once to ensure
> that they load properly and once to actually test their behavior. The
> load test is triggered by annotating the tests with __success, while the
> run test needs adding to tools/testing/selftests/bpf/prog_tests/cpumask.c
> the name of the new test. However, most existing tests are missing the
> __success annotation, and test_refcount_null_tracking is missing from the
> main test file. Add the missing annotations and test name.

It seems I have misled you. There is no need to run these programs
twice. __success() is used to annotate the test cases which will be run
through RUN_TESTS() macros. RUN_TESTS() will run these programs directly
through bpf_prog_test_run_opts(). However only specific program types
support being run through bpf_prog_test_run_opts(), and tp_btf doesn't
support being run through bpf_prog_test_run_opts(). Considering that
multiple successful test cases use err to check whether there is any
error during the running of program, I suggest only add
test_refcount_null_tracking in cpumask_success_testcases and remove the
__success annotation.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  .../testing/selftests/bpf/prog_tests/cpumask.c |  1 +
>  .../selftests/bpf/progs/cpumask_success.c      | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
> index 9b09beba988b..447a6e362fcd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
> @@ -25,6 +25,7 @@ static const char * const cpumask_success_testcases[] = {
>  	"test_global_mask_nested_deep_rcu",
>  	"test_global_mask_nested_deep_array_rcu",
>  	"test_cpumask_weight",
> +	"test_refcount_null_tracking",
>  	"test_populate_reject_small_mask",
>  	"test_populate_reject_unaligned",
>  	"test_populate",
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
> index 51f3dcf8869f..8abae7a59f92 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> @@ -136,6 +136,7 @@ static bool create_cpumask_set(struct bpf_cpumask **out1,
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_alloc_free_cpumask, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *cpumask;
> @@ -152,6 +153,7 @@ int BPF_PROG(test_alloc_free_cpumask, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_set_clear_cpu, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *cpumask;
> @@ -181,6 +183,7 @@ int BPF_PROG(test_set_clear_cpu, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_setall_clear_cpu, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *cpumask;
> @@ -210,6 +213,7 @@ int BPF_PROG(test_setall_clear_cpu, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_first_firstzero_cpu, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *cpumask;
> @@ -249,6 +253,7 @@ int BPF_PROG(test_first_firstzero_cpu, struct task_struct *task, u64 clone_flags
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_firstand_nocpu, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *mask1, *mask2;
> @@ -281,6 +286,7 @@ int BPF_PROG(test_firstand_nocpu, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_test_and_set_clear, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *cpumask;
> @@ -313,6 +319,7 @@ int BPF_PROG(test_test_and_set_clear, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_and_or_xor, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *mask1, *mask2, *dst1, *dst2;
> @@ -360,6 +367,7 @@ int BPF_PROG(test_and_or_xor, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_intersects_subset, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *mask1, *mask2, *dst1, *dst2;
> @@ -402,6 +410,7 @@ int BPF_PROG(test_intersects_subset, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_copy_any_anyand, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *mask1, *mask2, *dst1, *dst2;
> @@ -456,6 +465,7 @@ int BPF_PROG(test_copy_any_anyand, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_insert_leave, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *cpumask;
> @@ -471,6 +481,7 @@ int BPF_PROG(test_insert_leave, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_insert_remove_release, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *cpumask;
> @@ -501,6 +512,7 @@ int BPF_PROG(test_insert_remove_release, struct task_struct *task, u64 clone_fla
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *local, *prev;
> @@ -534,6 +546,7 @@ int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_global_mask_array_one_rcu, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *local, *prev;
> @@ -632,12 +645,14 @@ static int _global_mask_array_rcu(struct bpf_cpumask **mask0,
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_global_mask_array_rcu, struct task_struct *task, u64 clone_flags)
>  {
>  	return _global_mask_array_rcu(&global_mask_array[0], &global_mask_array[1]);
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_global_mask_array_l2_rcu, struct task_struct *task, u64 clone_flags)
>  {
>  	return _global_mask_array_rcu(&global_mask_array_l2[0][0], &global_mask_array_l2[1][0]);
> @@ -670,6 +685,7 @@ int BPF_PROG(test_global_mask_nested_rcu, struct task_struct *task, u64 clone_fl
>   * incorrect offset.
>   */
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_global_mask_nested_deep_rcu, struct task_struct *task, u64 clone_flags)
>  {
>  	int r, i;
> @@ -689,6 +705,7 @@ int BPF_PROG(test_global_mask_nested_deep_rcu, struct task_struct *task, u64 clo
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_global_mask_nested_deep_array_rcu, struct task_struct *task, u64 clone_flags)
>  {
>  	int i;
> @@ -706,6 +723,7 @@ int BPF_PROG(test_global_mask_nested_deep_array_rcu, struct task_struct *task, u
>  }
>  
>  SEC("tp_btf/task_newtask")
> +__success
>  int BPF_PROG(test_cpumask_weight, struct task_struct *task, u64 clone_flags)
>  {
>  	struct bpf_cpumask *local;


