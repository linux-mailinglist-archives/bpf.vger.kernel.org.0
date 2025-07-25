Return-Path: <bpf+bounces-64378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C70B1216F
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960931896A7F
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764142EE971;
	Fri, 25 Jul 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MVHx51AG"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE52BB17
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753459543; cv=none; b=oqHd7vCukDzHWjXbj8TY91CUr1mflNDAF3EWZJU5SP3qZprccDUyT1u3dfBI/eBDJ6gVURq9UkMbqIvT1FY4HXMlv+mIg594/y2fdbH0XL3dz5aXeKBww7ehi1S9sHlVB9uogWHuqEWWZPmPsrWlJsWNZxgW+PWp1ZVUoiw/Kws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753459543; c=relaxed/simple;
	bh=YgPAnx9vFCwOx9iFj2kTW3xM7JALaN+r1UZ4mK4q20g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnoIUvRaF8PM3HPbv/2SOx2K7iAlureCVYxfSMywAfLtrBtFspy58EafksSygsThUtcDIW+KWSzxgpu8FyMzDow/hK/xxqOKqUVeCQv4CnNc1g1ZGVqDK4yj4PRx9MDv2xMl/aaooN6+vYNvfJVBCbhCfrbrrFNQzNlXsL8yGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MVHx51AG; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c7241cc9-2b20-4f32-8ae2-93f40d12fc85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753459538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3g87AqOwyJOiheBSqVuAlI8MtvTXH78Z8e5bHHseWHY=;
	b=MVHx51AGl+3SbE3RFIiWpv1PxlGsaOafEwYgmp3ig5tdja/tjCdzHveO9mLfKnEH7O/yUy
	mFgJ1jvmGvH0iQRAKqGYOK/16t3rYgdgVXYqDGF3jo2+UIViufvlLh6mfD0Gk2eEQPF2rJ
	4RG5WA/L41c8YRSuxajkw/Ui4DEbCQQ=
Date: Fri, 25 Jul 2025 09:05:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] Use correct destructor kfunc types
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
References: <20250724223225.1481960-6-samitolvanen@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250724223225.1481960-6-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/24/25 3:32 PM, Sami Tolvanen wrote:
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

I tried your patch set on top of latest bpf-next. The problem
still exists with the following error:

[   71.976265] CFI failure at bpf_obj_free_fields+0x298/0x620 (target: __bpf_crypto_ctx_release+0x0/0x10; expected type: 0xc1113566)
[   71.980134] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
...


The following is the CFI related config items:

$ grep CFI .config
CONFIG_CFI_AUTO_DEFAULT=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_ARCH_USES_CFI_TRAPS=y
CONFIG_CFI_CLANG=y
# CONFIG_CFI_ICALL_NORMALIZE_INTEGERS is not set
CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG=y
CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC=y
# CONFIG_CFI_PERMISSIVE is not set

Did I miss anything?

>
> Sami
>
> ---
>
> Sami Tolvanen (4):
>    bpf: crypto: Use the correct destructor kfunc type
>    bpf: net_sched: Use the correct destructor kfunc type
>    selftests/bpf: Use the correct destructor kfunc type
>    bpf, btf: Enforce destructor kfunc type with CFI
>
>   kernel/bpf/btf.c                                     | 7 +++++++
>   kernel/bpf/crypto.c                                  | 7 ++++++-
>   net/sched/bpf_qdisc.c                                | 7 ++++++-
>   tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 7 ++++++-
>   4 files changed, 25 insertions(+), 3 deletions(-)
>
>
> base-commit: 95993dc3039e29dabb9a50d074145d4cb757b08b


