Return-Path: <bpf+bounces-79291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 501EED33060
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 16:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E426831475D9
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325F39524A;
	Fri, 16 Jan 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qO6oHptE"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B823EA85
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575068; cv=none; b=o1jvhB/jw+ytCQhqsGjLw+nDbWGvbfjMd+cIWR2VT6G/fPKB9P2Bi16F3iONfYHu655w/djctommkxNThG7kE9rb2AXQnX1cMP2GpiO+NpZN/3Z8DiEUzcoqLrWM3ThryL/zvCb2L98Jm6tCYjI2vPfNN5IWg1rFUGirfZFrQyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575068; c=relaxed/simple;
	bh=6dGk2zEhRea6Q2TDm8mONjbI3QoDktGVNx9FN1lZpvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiQtXlho2cjZTe+GiND4QgnU+l2ryEWAHVMdJ9/GbTcEVNenR6E5ChMrnf7e/3hRNbPqFhcY93MZEEmBporOLoCNY6B/SVZhI/kAlOUN2H48D35DA13H4ndVYub6C8OSlRUDx8LT8YZ3sbKR9XwDDcBGWbXnI7wxS9XC6Nc+nlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qO6oHptE; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768575064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xdn3VvN72T4vso2/2jDjWl7b9n9YQr49DkJId78Yofk=;
	b=qO6oHptEuJ3QcsSSYw/Fxd7Q3ln6QtNEo0+PkOw1Mc4XA/6N5XZvQ/bk8S7ZBeDE0DcCFV
	FDqSq4Tm+uO4Ch7fx+9dit5GvXygN1RrJf5Yksx66RLybQM0M8QbPjYYcBvMx4d0bacm6l
	+9WGx+TuXSHoqbuN1VCG6u/SJzPPGHU=
From: Menglong Dong <menglong.dong@linux.dev>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: memxor@gmail.com, andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, realwujing@qq.com,
 sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev,
 yuanql9@chinatelecom.cn, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Qiliang Yuan <realwujing@gmail.com>
Subject:
 Re: [PATCH v2] bpf/verifier: implement slab cache for verifier state list
Date: Fri, 16 Jan 2026 22:50:36 +0800
Message-ID: <14011562.uLZWGnKmhe@7950hx>
In-Reply-To: <20260116132953.40636-1-realwujing@gmail.com>
References:
 <CAP01T76JECHPV4Fdvm2bds=Eb36UYhQswd7oAJ+fRzW_1ZtnVw@mail.gmail.com>
 <20260116132953.40636-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/16 21:29, Qiliang Yuan wrote:
> The BPF verifier's state exploration logic in is_state_visited() frequently
> allocates and deallocates 'struct bpf_verifier_state_list' nodes. Currently,
> these allocations use generic kzalloc(), which leads to significant memory
> management overhead and page faults during high-complexity verification,
> especially in multi-core parallel scenarios.
> 
> This patch introduces a dedicated 'bpf_verifier_state_list' slab cache to
> optimize these allocations, providing better speed, reduced fragmentation,
> and improved cache locality. All allocation and deallocation paths are
> migrated to use kmem_cache_zalloc() and kmem_cache_free().
> 
> Performance evaluation using a stress test (1000 conditional branches)
> executed in parallel on 32 CPU cores for 60 seconds shows significant
> improvements:

This patch is a little mess. First, don't send a new version by replying to
your previous version.

> 
> Metric              | Baseline      | Patched       | Delta (%)
> --------------------|---------------|---------------|----------
> Page Faults         | 12,377,064    | 8,534,044     | -31.05%
> IPC                 | 1.17          | 1.22          | +4.27%
> CPU Cycles          | 1,795.37B     | 1,700.33B     | -5.29%
> Instructions        | 2,102.99B     | 2,074.27B     | -1.37%

And the test case is odd too. What performance improvement do we
get from this testing result? You run the veristat infinitely and record the
performance with perf for 60s, so what can we get? Shouldn't you
run the veristat for certain times and see the performance, such as
the duration or the CPU cycles?

You optimize the verifier to reduce the verifying duration in your case,
which seems to be a complex BPF program and consume much time
in verifier. So what performance increasing do you get in your case?

> 
> Detailed Benchmark Report:
> ==========================
> 1. Test Case Compilation (verifier_state_stress.c):
> clang -O2 -target bpf -D__TARGET_ARCH_x86 -I. -I./tools/include \
>       -I./tools/lib/bpf -I./tools/testing/selftests/bpf -c \
>       verifier_state_stress.c -o verifier_state_stress.bpf.o
> 
[...]
> 
>       60.036630614 seconds time elapsed
> 
> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>

You don't need to add all the reviewers here, unless big changes is
made.

> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
> On Mon, 2026-01-12 at 19:15 +0100, Kumar Kartikeya Dwivedi wrote:
> > Did you run any numbers on whether this improves verification performance?
> > Without any compelling evidence, I would leave things as-is.

This is not how we write change logs, please see how other people
do.

> 
> This version addresses the feedback by providing detailed 'perf stat' 
> benchmarks and reproducible stress test code to demonstrate the 
> compelling performance gains.
> 






