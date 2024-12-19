Return-Path: <bpf+bounces-47297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97369F7370
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 04:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E32188F892
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 03:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256713D509;
	Thu, 19 Dec 2024 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MBdXz1Th"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6886337
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 03:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734579671; cv=none; b=IZOjShUId4n9FO7Y47n2yLwaEqtqBV7714iwyB9yFMdGaP8/CZXjqz8Wkgi7AmtZJu4OXXEzHNNy+2BC+zdSMy/f6b15SFyHMGRF66GZ1IcooLf8zJMjc4yxGWpO9bImkkcnjNLcUjGQNUyJrdDXeeQjL6ylNwj0I6eXiUwNrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734579671; c=relaxed/simple;
	bh=VZRts9yyQq6ij4+1qIruyGY1+vL31NNj1hph0bckLts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwKfV3J4wzmXIxGYlMc/Acbum0sI6rClt7Nuzw7yxFjvGaJBiXYjw2uia0qir7a/AyEHYLq2OhkykDwkADjR9C0FHB/KsP/SbALzYPFn6mjr9xEyVeAyFeRxuGG0IN+effvnHkfdSl7dGWM7/e2KiJBwlK/7HA4LcAtLEztSQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MBdXz1Th; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd5e82d1-d00a-4bda-be4b-802204167352@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734579666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1dyiVQFPt/vxI27RZODI7f1RB9NabSPouj9PjgiRsg=;
	b=MBdXz1ThlfVCd5+58arCTBwUPD2PMn/o0s9dTK+xCk/BHKv6vmhuKT47/SVHIdVrFcrbow
	g7wRMOj8QK5MLuGjo0wYqGA7r7Qxh6vtpdmuBrqSTQmfL+6GL+HucitcfdSG9u+Wbfm70b
	0Ry9n570AkqbneOQTukJ0pPvVVxrafQ=
Date: Wed, 18 Dec 2024 19:40:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 02/13] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
Content-Language: en-GB
To: Amery Hung <amery.hung@bytedance.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com,
 toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, ameryhung@gmail.com
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-3-amery.hung@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241213232958.2388301-3-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 12/13/24 3:29 PM, Amery Hung wrote:
> Test referenced kptr acquired through struct_ops argument tagged with
> "__ref". The success case checks whether 1) a reference to the correct
> type is acquired, and 2) the referenced kptr argument can be accessed in
> multiple paths as long as it hasn't been released. In the fail cases,
> we first confirm that a referenced kptr acquried through a struct_ops
> argument is not allowed to be leaked. Then, we make sure this new
> referenced kptr acquiring mechanism does not accidentally allow referenced
> kptrs to flow into global subprograms through their arguments.
>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  7 ++
>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  2 +
>   .../prog_tests/test_struct_ops_refcounted.c   | 58 ++++++++++++++++
>   .../bpf/progs/struct_ops_refcounted.c         | 67 +++++++++++++++++++
>   ...ruct_ops_refcounted_fail__global_subprog.c | 32 +++++++++
>   .../struct_ops_refcounted_fail__ref_leak.c    | 17 +++++
>   6 files changed, 183 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 987d41af71d2..244234546ae2 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -1135,10 +1135,17 @@ static int bpf_testmod_ops__test_maybe_null(int dummy,
>   	return 0;
>   }
>   
> +static int bpf_testmod_ops__test_refcounted(int dummy,
> +					    struct task_struct *task__ref)
> +{
> +	return 0;
> +}
> +
>   static struct bpf_testmod_ops __bpf_testmod_ops = {
>   	.test_1 = bpf_testmod_test_1,
>   	.test_2 = bpf_testmod_test_2,
>   	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
> +	.test_refcounted = bpf_testmod_ops__test_refcounted,
>   };
>   
>   struct bpf_struct_ops bpf_bpf_testmod_ops = {
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> index fb7dff47597a..0e31586c1353 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> @@ -36,6 +36,8 @@ struct bpf_testmod_ops {
>   	/* Used to test nullable arguments. */
>   	int (*test_maybe_null)(int dummy, struct task_struct *task);
>   	int (*unsupported_ops)(void);
> +	/* Used to test ref_acquired arguments. */
> +	int (*test_refcounted)(int dummy, struct task_struct *task);
>   
>   	/* The following fields are used to test shadow copies. */
>   	char onebyte;
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
> new file mode 100644
> index 000000000000..976df951b700
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
> @@ -0,0 +1,58 @@
> +#include <test_progs.h>
> +
> +#include "struct_ops_refcounted.skel.h"
> +#include "struct_ops_refcounted_fail__ref_leak.skel.h"
> +#include "struct_ops_refcounted_fail__global_subprog.skel.h"
> +
> +/* Test that the verifier accepts a program that first acquires a referenced
> + * kptr through context and then releases the reference
> + */
> +static void refcounted(void)
> +{
> +	struct struct_ops_refcounted *skel;
> +
> +	skel = struct_ops_refcounted__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
> +		return;
> +
> +	struct_ops_refcounted__destroy(skel);
> +}
> +
> +/* Test that the verifier rejects a program that acquires a referenced
> + * kptr through context without releasing the reference
> + */
> +static void refcounted_fail__ref_leak(void)
> +{
> +	struct struct_ops_refcounted_fail__ref_leak *skel;
> +
> +	skel = struct_ops_refcounted_fail__ref_leak__open_and_load();
> +	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
> +		return;
> +
> +	struct_ops_refcounted_fail__ref_leak__destroy(skel);
> +}
> +
> +/* Test that the verifier rejects a program that contains a global
> + * subprogram with referenced kptr arguments
> + */
> +static void refcounted_fail__global_subprog(void)
> +{
> +	struct struct_ops_refcounted_fail__global_subprog *skel;
> +
> +	skel = struct_ops_refcounted_fail__global_subprog__open_and_load();
> +	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
> +		return;
> +
> +	struct_ops_refcounted_fail__global_subprog__destroy(skel);
> +}
> +
> +void test_struct_ops_refcounted(void)
> +{
> +	if (test__start_subtest("refcounted"))
> +		refcounted();
> +	if (test__start_subtest("refcounted_fail__ref_leak"))
> +		refcounted_fail__ref_leak();
> +	if (test__start_subtest("refcounted_fail__global_subprog"))
> +		refcounted_fail__global_subprog();
> +}
> +
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
> new file mode 100644
> index 000000000000..2c1326668b92
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
> @@ -0,0 +1,67 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +extern void bpf_task_release(struct task_struct *p) __ksym;
> +
> +/* This is a test BPF program that uses struct_ops to access a referenced
> + * kptr argument. This is a test for the verifier to ensure that it
> + * 1) recongnizes the task as a referenced object (i.e., ref_obj_id > 0), and
> + * 2) the same reference can be acquired from multiple paths as long as it
> + *    has not been released.
> + *
> + * test_refcounted() is equivalent to the C code below. It is written in assembly
> + * to avoid reads from task (i.e., getting referenced kptrs to task) being merged
> + * into single path by the compiler.
> + *
> + * int test_refcounted(int dummy, struct task_struct *task)
> + * {
> + *         if (dummy % 2)
> + *                 bpf_task_release(task);
> + *         else
> + *                 bpf_task_release(task);
> + *         return 0;
> + * }
> + */
> +SEC("struct_ops/test_refcounted")
> +int test_refcounted(unsigned long long *ctx)
> +{
> +	asm volatile ("					\
> +	/* r6 = dummy */				\
> +	r6 = *(u64 *)(r1 + 0x0);			\
> +	/* if (r6 & 0x1 != 0) */			\
> +	r6 &= 0x1;					\
> +	if r6 == 0 goto l0_%=;				\
> +	/* r1 = task */					\
> +	r1 = *(u64 *)(r1 + 0x8);			\
> +	call %[bpf_task_release];			\
> +	goto l1_%=;					\
> +l0_%=:	/* r1 = task */					\
> +	r1 = *(u64 *)(r1 + 0x8);			\
> +	call %[bpf_task_release];			\
> +l1_%=:	/* return 0 */					\
> +"	:
> +	: __imm(bpf_task_release)
> +	: __clobber_all);
> +	return 0;
> +}

You can use clang nomerge attribute to prevent bpf_task_release(task) merging. For example,

$ cat t.c
struct task_struct {
         int a;
         int b;
         int d[20];
};


__attribute__((nomerge)) extern void bpf_task_release(struct task_struct *task);

int test_refcounted(int dummy, struct task_struct *task)
{
         if (dummy % 2)
                 bpf_task_release(task);
         else
                 bpf_task_release(task);
         return 0;
}

$ clang --version
clang version 19.1.5 (https://github.com/llvm/llvm-project.git ab4b5a2db582958af1ee308a790cfdb42bd24720)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/yhs/work/llvm-project/llvm/build.19/Release/bin
$ clang --target=bpf -O2 -mcpu=v3 -S t.c
$ cat t.s
         .text
         .file   "t.c"
         .globl  test_refcounted                 # -- Begin function test_refcounted
         .p2align        3
         .type   test_refcounted,@function
test_refcounted:                        # @test_refcounted
# %bb.0:
         w1 &= 1
         if w1 == 0 goto LBB0_2
# %bb.1:
         r1 = r2
         call bpf_task_release
         goto LBB0_3
LBB0_2:
         r1 = r2
         call bpf_task_release
LBB0_3:
         w0 = 0
         exit
.Lfunc_end0:
         .size   test_refcounted, .Lfunc_end0-test_refcounted
                                         # -- End function
         .addrsig

> +
> +/* BTF FUNC records are not generated for kfuncs referenced
> + * from inline assembly. These records are necessary for
> + * libbpf to link the program. The function below is a hack
> + * to ensure that BTF FUNC records are generated.
> + */
> +void __btf_root(void)
> +{
> +	bpf_task_release(NULL);
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_refcounted = {
> +	.test_refcounted = (void *)test_refcounted,
> +};
> +
> +
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
> new file mode 100644
> index 000000000000..c7e84e63b053
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
> @@ -0,0 +1,32 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +extern void bpf_task_release(struct task_struct *p) __ksym;
> +
> +__noinline int subprog_release(__u64 *ctx __arg_ctx)
> +{
> +	struct task_struct *task = (struct task_struct *)ctx[1];
> +	int dummy = (int)ctx[0];
> +
> +	bpf_task_release(task);
> +
> +	return dummy + 1;
> +}
> +
> +SEC("struct_ops/test_refcounted")
> +int test_refcounted(unsigned long long *ctx)
> +{
> +	struct task_struct *task = (struct task_struct *)ctx[1];
> +
> +	bpf_task_release(task);
> +
> +	return subprog_release(ctx);
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_ref_acquire = {
> +	.test_refcounted = (void *)test_refcounted,
> +};
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c
> new file mode 100644
> index 000000000000..6e82859eb187
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c
> @@ -0,0 +1,17 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("struct_ops/test_refcounted")
> +int BPF_PROG(test_refcounted, int dummy,
> +	     struct task_struct *task)
> +{
> +	return 0;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_ref_acquire = {
> +	.test_refcounted = (void *)test_refcounted,
> +};


