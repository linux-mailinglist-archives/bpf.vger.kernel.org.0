Return-Path: <bpf+bounces-64422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DD2B12798
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 01:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39E1588344
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 23:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D44260583;
	Fri, 25 Jul 2025 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u22ODKMx"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FD25D212
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753486975; cv=none; b=iSL9uVD/XFKMFjR1hGQPocwxbTbtQyYPhRmr8s9ncTV1PneYdLxAxkHMS0dlDM8rtfdjvh7aZE+Pf5/oNJ/hnHwo2aiJ2ae1uhd0tJ/RzNrHNWYvsXnXyur8styLtH3AsN25yt1lAeezjSSSELyO1vdSeGJ5aHwFvRc4RujbFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753486975; c=relaxed/simple;
	bh=KUe9FcrjMaejAdUmcnM2eRUMGnf9x+1Fz4c6VOO6z2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHmgf2cYWzpzUM0EOlLEFDWNKf64d7qnMqCzeib4Os0h6YMc7lsr8swFkkU0JQp2Fiv09egWSR0atLufs08/Y9skzRi8TEEVwify4WhB4S2hynT7E9u/7myahcv0jcNefXk9dyEbJHZlXJGL0UFkNoksP+nfIiBZOUyQYdyvWqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u22ODKMx; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d7d1ff3-14cd-4c18-a180-3c99e784bbeb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753486961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mJSyB47Hf1VSmZxpedRPHsm4zGk7oqWFstVKJE02/c=;
	b=u22ODKMxQaOkLMz1JJUOKh5tZGHKxkO3dqz9oSNy2GKcbFIdhoSPN8k4iJYhoR2RrzwCxp
	sl+dT7OLEAQS9OVdBuoL298oCdTx/XV5HE7eekIDJFZerzYoIFEMdr/qvd0cY0rFbQu/Rn
	o7y6VbUKL4RBhfSW7pNEQRIzd9BtFBA=
Date: Fri, 25 Jul 2025 16:42:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/4] Use correct destructor kfunc types
Content-Language: en-GB
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250725214401.1475224-6-samitolvanen@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250725214401.1475224-6-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/25/25 2:44 PM, Sami Tolvanen wrote:
> Hi folks,
>
> While running BPF self-tests with CONFIG_CFI_CLANG (Clang Control
> Flow Integrity) enabled, I ran into a couple of CFI failures
> in bpf_obj_free_fields() caused by type mismatches between
> the btf_dtor_kfunc_t function pointer type and the registered
> destructor functions.
>
> It looks like we can't change the argument type for these
> functions to match btf_dtor_kfunc_t because the verifier doesn't
> like void pointer arguments for functions used in BPF programs,
> so this series fixes the issue by adding stubs with correct types
> to use as destructors for each instance of this I found in the
> kernel tree.
>
> The last patch changes btf_check_dtor_kfuncs() to enforce the
> function type when CFI is enabled, so we don't end up registering
> destructors that panic the kernel. Perhaps this is something we
> could enforce even without CONFIG_CFI_CLANG?
>
> Sami
>
> ---
> v2:
> - Annotated the stubs with CFI_NOSEAL to fix issues with IBT
>    sealing on x86.
> - Changed __bpf_kfunc to explicit __used __retain.
>
> v1: https://lore.kernel.org/bpf/20250724223225.1481960-6-samitolvanen@google.com/
>
> ---
> Sami Tolvanen (4):
>    bpf: crypto: Use the correct destructor kfunc type
>    bpf: net_sched: Use the correct destructor kfunc type
>    selftests/bpf: Use the correct destructor kfunc type
>    bpf, btf: Enforce destructor kfunc type with CFI
>
>   kernel/bpf/btf.c                                     | 7 +++++++
>   kernel/bpf/crypto.c                                  | 9 ++++++++-
>   net/sched/bpf_qdisc.c                                | 9 ++++++++-
>   tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 9 ++++++++-
>   4 files changed, 31 insertions(+), 3 deletions(-)
>
>
> base-commit: 95993dc3039e29dabb9a50d074145d4cb757b08b

With this patch set and no CONFIG_CFI_CLANG in .config,
the bpf selftests work okay. In bpf ci, CONFIG_CFI_CLANG
is not enabled.

But if enabling CONFIG_CFI_CLANG, this patch set fixed
./test_progs run issue, but there are some test failures
like

===
test_get_linfo:FAIL:check jited_linfo[1]:ffffffffa000d581 - ffffffffa000d558 > 39
processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
#32/186  btf/line_info (No subprog):FAIL

test_get_linfo:FAIL:check jited_linfo[1]:ffffffffa000dee5 - ffffffffa000debc > 39
processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
#32/189  btf/line_info (No subprog. zero tailing line_info:FAIL

...

test_get_linfo:FAIL:check jited_linfo[1]:ffffffffa000e069 - ffffffffa000e040 > 38
processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 0
#32/202  btf/line_info (dead subprog + dead start w/ move):FAIL
#32      btf:FAIL
===

The failure probably not related to this patch, but rather related
to CONFIG_CFI_CLANG itself. I will debug this separately.


