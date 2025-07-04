Return-Path: <bpf+bounces-62403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507BAAF96D2
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 17:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1440648267C
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA31C07C4;
	Fri,  4 Jul 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sEYUYxW8"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1B2D29DF
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751643013; cv=none; b=R9EWo8c5ObYkTSF1vwsDqDNTvmsrybjp9iSnKwtwkRcfOmmD82XZVqRPg5vkcl03yDU93iQjgU7gYQNtFKQ7ggadD04cx7b6imcOIc6RZyLz2Hgp3NPzBTnnjI0OLU18Kz6gdvqOOZJd8fBZtH21zgYjfQfCxrUkeSlaOQbfzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751643013; c=relaxed/simple;
	bh=/sajMwdd6AmwW7iYEKnM7OJ9GcKib9Ul/DeyCwRIFu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6pdud9cT+DRXBU2hLtp42TbSaipDEyqK/EWnzro1XtZsCr2tigNDDWfON8Wy9RZz0XvjhaPJnRHQbX1c2A3pVOBj5ROMJO93c9fTNEncyJdD67cj7RumBabIUg9Sd3Zydn03dY3ewtFgoa/sagzhpAI8J10l7N8+WLQCfueFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sEYUYxW8; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8f8fb7b2-c580-4c6f-82a9-d0e7ce1afc52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751643008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJqYsK4vkvN5yKuz1zAEL2TePG8jfXxF4gkAqttl8P0=;
	b=sEYUYxW89cc/NXFyzc5znOEbNKJLrjjXKHmqp6C3xsHSpRCTyrInKyd8MWpI1bnfRUBpqf
	9zZj1duZtE1cc7C+4A+cpPDJ8MtLzS+4a6T5e+sezjCJVpmh+QKCj1pLxH/+yUownzoEFK
	Wva2XJISuJ30+SGPGoVU3C4vM/wfjBs=
Date: Fri, 4 Jul 2025 08:30:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Negative test case for tail
 call map
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>
References: <aGfRXNF7Ns5xV044@Tunnel>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aGfRXNF7Ns5xV044@Tunnel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/4/25 6:04 AM, Paul Chaignon wrote:
> This patch adds a negative test case for the following verifier error.
>
>      expected prog array map for tail call
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

LGTM with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
> Changes in v2:
>    - Moved the test to prog_tests format as suggested by Eduard.
>    - Rebased.
>    - v1: https://lore.kernel.org/bpf/7cec754c8d4cc2d93a50e9091d7ccc7f33d454d4.1751578055.git.paul.chaignon@gmail.com/
>
>   .../selftests/bpf/prog_tests/verifier.c       |  2 ++
>   .../selftests/bpf/progs/verifier_tailcall.c   | 32 +++++++++++++++++++
>   2 files changed, 34 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_tailcall.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index c9da06741104..77ec95d4ffaa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -85,6 +85,7 @@
>   #include "verifier_store_release.skel.h"
>   #include "verifier_subprog_precision.skel.h"
>   #include "verifier_subreg.skel.h"
> +#include "verifier_tailcall.skel.h"
>   #include "verifier_tailcall_jit.skel.h"
>   #include "verifier_typedef.skel.h"
>   #include "verifier_uninit.skel.h"
> @@ -219,6 +220,7 @@ void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
>   void test_verifier_store_release(void)        { RUN(verifier_store_release); }
>   void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
>   void test_verifier_subreg(void)               { RUN(verifier_subreg); }
> +void test_verifier_tailcall(void)             { RUN(verifier_tailcall); }
>   void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_jit); }
>   void test_verifier_typedef(void)              { RUN(verifier_typedef); }
>   void test_verifier_uninit(void)               { RUN(verifier_uninit); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall.c b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
> new file mode 100644
> index 000000000000..662a6528ce4f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +} map_array SEC(".maps");
> +
> +SEC("socket")
> +__description("invalid map type for tail call")
> +__failure __msg("expected prog array map for tail call")
> +__failure_unpriv
> +__flag(BPF_F_ANY_ALIGNMENT)

The __flag(BPF_F_ANY_ALIGNMENT) is not necessary as it is
for load/store insns in the bpf prog. In the below bpf prog,
there are no load/store insns.

> +__naked void invalid_map_for_tail_call(void)
> +{
> +	asm volatile ("		\
> +	r2 = %[map_array] ll;	\
> +	r3 = 0;			\
> +	call %[bpf_tail_call];	\
> +	exit;			\
> +"	:
> +	: __imm(bpf_tail_call),
> +	  __imm_addr(map_array)
> +	: __clobber_all);
> +}
> +
> +char _license[] SEC("license") = "GPL";


