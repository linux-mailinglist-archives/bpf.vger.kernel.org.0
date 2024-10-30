Return-Path: <bpf+bounces-43610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B41A19B707F
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 00:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C721C203C0
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5D21745E;
	Wed, 30 Oct 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUVw5Cjm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7E1E47A0
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730330953; cv=none; b=rGwWN/PguUZ+yZ8pQt0Z5mPWqTIffyVOhl6EJ6Y6peN87e8mSOKloj4SfyXTU/6ju2405KiNpey/znb9g365Tyjzg5kYA1YB7qDo1ytidK2i2qc554AnQxRBODws40mRRXzt8+g7Ubi6lf7S05uI2ZEjjY5rrUxZnvsJn9Y51J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730330953; c=relaxed/simple;
	bh=2yPAS2kY843hjW0bNssQwXXUeof7n7UpsOasq6TlFSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCkjG0XUaLu3V8Ui+GfGwKtMb+k7psIHiy9UQHub7s5fQw2il+0ruPdtTs18cw2FRyv6kf3RIeglLwertNQXYbCzeIofu0im83W/K85uE1hAHq83ABVdbMRSglOgBLVxJnhK5JCQdmEUXMU4piTo1xQVPKZDH2HXtIf/iS6dxn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUVw5Cjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE9CC4CEFA;
	Wed, 30 Oct 2024 23:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730330953;
	bh=2yPAS2kY843hjW0bNssQwXXUeof7n7UpsOasq6TlFSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUVw5Cjmv+yy9QXuNnJ/CQA5n4msTnB2VwNUozVlq7duG2DczZiJeVQt/U2Q4yjKd
	 DM0dEfZ4EVJ3X+aPxGlnxMKiaL3DgXgOEjBaGizMAWV95zzP8K+9S+MaJW/m0iSuV0
	 3Sk0QKSSSujRCW/S4FKlVMwBD7wDPqVzBlk7Tma/c07PXNbI267ZjGezv0nYSBx3q3
	 nGjMRMUWWVEml016vCJfll9gqil/hay2bbSATdltVceRKR+/pLOvGV60Y2BqqI7To/
	 J6UgJX7EuLvBEROlNUnadKGY6E+7FoZjdrQieKRT4foo5kKfdMTZNtqPlTSv9QFIYV
	 9XsD+T54RsbLA==
Date: Wed, 30 Oct 2024 13:29:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v7 9/9] selftests/bpf: Add struct_ops prog
 private stack tests
Message-ID: <ZyLBR8cM_UhrFOBO@slm.duckdns.org>
References: <20241029221637.264348-1-yonghong.song@linux.dev>
 <20241029221723.268595-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029221723.268595-1-yonghong.song@linux.dev>

Hello,

On Tue, Oct 29, 2024 at 03:17:23PM -0700, Yonghong Song wrote:
> The third test is the same callback function recursing itself. At run time,
> the jit trampoline recursion check kicks in to prevent the recursion.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  94 ++++++++++++++++
>  .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
>  .../bpf/prog_tests/struct_ops_private_stack.c | 106 ++++++++++++++++++
>  .../bpf/progs/struct_ops_private_stack.c      |  62 ++++++++++
>  .../bpf/progs/struct_ops_private_stack_fail.c |  62 ++++++++++
>  .../progs/struct_ops_private_stack_recur.c    |  50 +++++++++
>  6 files changed, 379 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
>  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
>  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
>  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 8835761d9a12..eb761645551a 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
...
> +__bpf_kfunc void bpf_testmod_ops3_call_test_1(void)
> +{
> +	st_ops3->test_1();
> +}
...
> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> new file mode 100644
> index 000000000000..4006879ca3fe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
...
> +static void test_private_stack_recur(void)
> +{
> +	struct struct_ops_private_stack_recur *skel;
> +	struct bpf_link *link;
> +	int err;
> +
> +	skel = struct_ops_private_stack_recur__open();
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_recur__open"))
> +		return;
> +
> +	if (skel->data->skip) {
> +		test__skip();
> +		goto cleanup;
> +	}
> +
> +	err = struct_ops_private_stack_recur__load(skel);
> +	if (!ASSERT_OK(err, "struct_ops_private_stack_recur__load"))
> +		goto cleanup;
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
> +		goto cleanup;
> +
> +	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
> +
> +	ASSERT_EQ(skel->bss->val_j, 3, "val_j");
> +
> +	bpf_link__destroy(link);
> +
> +cleanup:
> +	struct_ops_private_stack_recur__destroy(skel);
> +}
...
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> new file mode 100644
> index 000000000000..15d4e914dc92
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#if defined(__TARGET_ARCH_x86)
> +bool skip __attribute((__section__(".data"))) = false;
> +#else
> +bool skip = true;
> +#endif
> +
> +void bpf_testmod_ops3_call_test_1(void) __ksym;
> +
> +int val_i, val_j;
> +
> +__noinline static int subprog2(int *a, int *b)
> +{
> +	return val_i + a[10] + b[20];
> +}
> +
> +__noinline static int subprog1(int *a)
> +{
> +	/* stack size 400 bytes */
> +	int b[100] = {};
> +
> +	b[20] = 2;
> +	return subprog2(a, b);
> +}
> +
> +
> +SEC("struct_ops")
> +int BPF_PROG(test_1)
> +{
> +	/* stack size 400 bytes */
> +	int a[100] = {};
> +
> +	a[10] = 1;
> +	val_j += subprog1(a);
> +	bpf_testmod_ops3_call_test_1();
> +	return 0;
> +}
> +
> +SEC(".struct_ops")
> +struct bpf_testmod_ops3 testmod_1 = {
> +	.test_1 = (void *)test_1,
> +};

This is delta, and, while this shouldn't happen for SCX, it'd be great if
SCX can tell BPF to call a function when recursion check triggers and
ignores a call, so that SCX can trigger error, report it and eject the
scheduler.

Thanks.

-- 
tejun

