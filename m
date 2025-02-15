Return-Path: <bpf+bounces-51630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D01A36AAF
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 02:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554B716A815
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C80A5103F;
	Sat, 15 Feb 2025 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SXcteWeV"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA080C02
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582062; cv=none; b=DTdnf3AfknjEge2BHEqVVP92UtUBhCRFbcfZxFVDKCoyNl3ebV9CU7y8ZED9WImBF+zfIlZxO6PXsucmL2ebuaouqXR0wtl4E1FHJHuMS1MbQDuExo9RvxJyerGNTMOguVzQ2uP9olX0DcmCOeb34wMtTc45wM2fb+q6JAHamUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582062; c=relaxed/simple;
	bh=QrMrCGGIHT+wO6TyV5fI6R0/lXA8lX87e4qkNC3Z+Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hs27j1vMWLtiOc5rfAVA8bgTyCz9vm+u1+4aND7yKh10R4798k1RlfQ+jEhQ7DgLixxSLUw0tHB/1yZQElT20xiv4BzZbBnROswgkcCq1sRZKwh/MWzUDzyJXRq3P5WSjheN3XZODj9vSImkBGt0SeldhoT7C9PUGp/AIhA643I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SXcteWeV; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <227f048e-402e-47c3-b989-27b8e88c83bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739582058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvaalGEPYZbZr7tgFPWSs3vNXA5pjOja0RNxpXClyak=;
	b=SXcteWeVMDxKpA1ANT9y/mSLi/Ug0t/KVrdlvUD1fE7hwfMUMZqrmrC/GkIOvHekxCeEFs
	C1Tl3QvTvVedPyuQmzs3aSIwVIBE5oqUKRFxRn+0g3a2T1OPH5U/fBXBHVgudZAZ1Yt7I9
	sQcFaRYDt6vg9Nblc4fyVQaGVRaNgOk=
Date: Fri, 14 Feb 2025 17:14:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 3/5] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, eddyz87@gmail.com,
 kernel-team@meta.com
References: <20250214164520.1001211-1-ameryhung@gmail.com>
 <20250214164520.1001211-4-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250214164520.1001211-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 8:45 AM, Amery Hung wrote:
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
> new file mode 100644
> index 000000000000..ae074aa62852
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
> @@ -0,0 +1,39 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../test_kmods/bpf_testmod.h"
> +#include "bpf_misc.h"
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
> +/* Test that the verifier rejects a program that contains a global
> + * subprogram with referenced kptr arguments
> + */
> +SEC("struct_ops/test_refcounted")
> +__failure __log_level(2)
> +__msg("Validating subprog_release() func#1...")
> +__msg("invalid bpf_context access off=8. Reference may already be released")
> +int refcounted_fail__global_subprog(unsigned long long *ctx)
> +{
> +	struct task_struct *task = (struct task_struct *)ctx[1];
> +
> +	bpf_task_release(task);
> +
> +	return subprog_release(ctx);

One question, swap the subprog_release and bpf_task_release order will still be 
the same failure, right?  Meaning:

	subprog_release(ctx);

	bpf_task_release(task);

	return 0;

which is fine based on the changes in the do_check_common() in patch 2. Just 
want to confirm my understanding.

Other than that,

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

