Return-Path: <bpf+bounces-44671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4859C63A9
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 22:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABCE1F257CE
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865D3219E34;
	Tue, 12 Nov 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ByCXuI7s"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367343AA1
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447793; cv=none; b=HSxD1YISKp4Vvc+sfuYUJfm9EikCrS2z2KTHg7MaR4ot5iUnTJmL2+86hEmV5rVr0DeYgu3tfH39fMJj7X+pstnVyfBPNSef543m7+KA6oIjl/5rx6+FwtlirB+SQ5Q3wgO6L6bn4fxbYsN8/WNkyC2Eah+K6k+CLmoel7r5/gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447793; c=relaxed/simple;
	bh=86NjfET2uejBLh/NQF0Ra97kYqEVmkCQ4F38yMNfrz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5o9qVksiXrq6vm+z0i5WrAZW6xyqDIEmSCuA4JZgLPI04TBbaSfk1tKSVrIZIqHZpmXo3iCf+DTCNYgQN6Bd29mG65wpBR8Rgi5K2HrQ2nXJyad1/7e/dlJM3euamGd4O88FYfjEBpJF2SZZ/xBHA8W+W9+hzLoGfNi2z1xh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ByCXuI7s; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <946c61c2-ab1e-43cb-adfd-cc5b7716b915@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731447789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oz3lc4Dspu/SVXRnRvB9yEwrfZKMbCPAsuQlqHh2SRk=;
	b=ByCXuI7szeAn77trsvzVnzkwU7vrfH9cPJS7MB6/hE+b5oA7vrU+IHX5qq0TP/KBfPJI01
	LuItqHKfiKmM5SMg4LBBjehFfXIVHYPKa/i0ICJB8n3IF63jvt6bGQUwL3fyVfwJuZkv6R
	g+eGDheY03mMEevdr7MrJCacT3OfOmA=
Date: Tue, 12 Nov 2024 21:43:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241109004158.2259301-1-vadfed@meta.com>
 <CAEf4BzaRb+fUK17wrj4sWnYM5oKxTvwZC=U-GjvsdUtF94PqrA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAEf4BzaRb+fUK17wrj4sWnYM5oKxTvwZC=U-GjvsdUtF94PqrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/11/2024 05:50, Andrii Nakryiko wrote:
> On Fri, Nov 8, 2024 at 4:42 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
>> it into rdtsc ordered call. Other architectures will get JIT
>> implementation too if supported. The fallback is to
>> __arch_get_hw_counter().
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
> 
> nit: please add cover letter for the next revision, multi-patch sets
> generally should come with a cover letter, unless it's some set of
> trivial and mostly independent patches. Anyways...

Yeah, sure. This series has grown from the first small version...

> 
> I haven't yet looked through the code (yet), but I was curious to
> benchmark the perf benefit, so that's what I did for fun this evening.
> 
> (!!!) BTW, a complete aside, but I think it's interesting. It turned
> out that using bpf_test_prog_run() scales *VERY POORLY* with large
> number of CPUs, because we start spending tons of time in
> fdget()/fdput(), so I initially got pretty unscalable results,
> profiled a bit, and then switched to just doing
> syscall(syscall(__NR_getpgid); + SEC("raw_tp/sys_enter")). Anyways,
> the point is that microbenchmarking is tricky and we need to improve
> our existing bench setup for some benchmarks. Anyways, getting back to
> the main topic.
> 
> I wrote a quick two benchmarks testing what I see as intended use case
> for these kfuncs (batching amortizes the cost of triggering BPF
> program, batch_iters = 500 in my case):
> 
> SEC("?raw_tp/sys_enter")
> int trigger_driver_ktime(void *ctx)
> {
>          volatile __u64 total = 0;
>          int i;
> 
>          for (i = 0; i < batch_iters; i++) {
>                  __u64 start, end;
> 
>                  start = bpf_ktime_get_ns();
>                  end = bpf_ktime_get_ns();
>                  total += end - start;
>          }
>          inc_counter_batch(batch_iters);
> 
>          return 0;
> }
> 
> extern __u64 bpf_get_cpu_cycles(void) __weak __ksym;
> extern __u64 bpf_cpu_cycles_to_ns(__u64 cycles) __weak __ksym;
> 
> SEC("?raw_tp/sys_enter")
> int trigger_driver_cycles(void *ctx)
> {
>          volatile __u64 total = 0;
>          int i;
> 
>          for (i = 0; i < batch_iters; i++) {
>                  __u64 start, end;
> 
>                  start = bpf_get_cpu_cycles();
>                  end = bpf_get_cpu_cycles();
>                  total += bpf_cpu_cycles_to_ns(end - start);
>          }
>          inc_counter_batch(batch_iters);
> 
>          return 0;
> }
> 
> And here's what I got across multiple numbers of parallel CPUs on our
> production host.
> 
> # ./bench_timing.sh
> 
> ktime                 ( 1 cpus):   32.286 ± 0.309M/s  ( 32.286M/s/cpu)
> ktime                 ( 2 cpus):   63.021 ± 0.538M/s  ( 31.511M/s/cpu)
> ktime                 ( 3 cpus):   94.211 ± 0.686M/s  ( 31.404M/s/cpu)
> ktime                 ( 4 cpus):  124.757 ± 0.691M/s  ( 31.189M/s/cpu)
> ktime                 ( 5 cpus):  154.855 ± 0.693M/s  ( 30.971M/s/cpu)
> ktime                 ( 6 cpus):  185.551 ± 2.304M/s  ( 30.925M/s/cpu)
> ktime                 ( 7 cpus):  211.117 ± 4.755M/s  ( 30.160M/s/cpu)
> ktime                 ( 8 cpus):  236.454 ± 0.226M/s  ( 29.557M/s/cpu)
> ktime                 (10 cpus):  295.526 ± 0.126M/s  ( 29.553M/s/cpu)
> ktime                 (12 cpus):  322.282 ± 0.153M/s  ( 26.857M/s/cpu)
> ktime                 (14 cpus):  375.347 ± 0.087M/s  ( 26.811M/s/cpu)
> ktime                 (16 cpus):  399.813 ± 0.181M/s  ( 24.988M/s/cpu)
> ktime                 (24 cpus):  617.675 ± 7.053M/s  ( 25.736M/s/cpu)
> ktime                 (32 cpus):  819.695 ± 0.231M/s  ( 25.615M/s/cpu)
> ktime                 (40 cpus):  996.264 ± 0.290M/s  ( 24.907M/s/cpu)
> ktime                 (48 cpus): 1180.201 ± 0.160M/s  ( 24.588M/s/cpu)
> ktime                 (56 cpus): 1321.084 ± 0.099M/s  ( 23.591M/s/cpu)
> ktime                 (64 cpus): 1482.061 ± 0.121M/s  ( 23.157M/s/cpu)
> ktime                 (72 cpus): 1666.540 ± 0.460M/s  ( 23.146M/s/cpu)
> ktime                 (80 cpus): 1851.419 ± 0.439M/s  ( 23.143M/s/cpu)
> 
> cycles                ( 1 cpus):   45.815 ± 0.018M/s  ( 45.815M/s/cpu)
> cycles                ( 2 cpus):   86.706 ± 0.068M/s  ( 43.353M/s/cpu)
> cycles                ( 3 cpus):  129.899 ± 0.101M/s  ( 43.300M/s/cpu)
> cycles                ( 4 cpus):  168.435 ± 0.073M/s  ( 42.109M/s/cpu)
> cycles                ( 5 cpus):  210.520 ± 0.164M/s  ( 42.104M/s/cpu)
> cycles                ( 6 cpus):  252.596 ± 0.050M/s  ( 42.099M/s/cpu)
> cycles                ( 7 cpus):  294.356 ± 0.159M/s  ( 42.051M/s/cpu)
> cycles                ( 8 cpus):  317.167 ± 0.163M/s  ( 39.646M/s/cpu)
> cycles                (10 cpus):  396.141 ± 0.208M/s  ( 39.614M/s/cpu)
> cycles                (12 cpus):  431.938 ± 0.511M/s  ( 35.995M/s/cpu)
> cycles                (14 cpus):  503.055 ± 0.070M/s  ( 35.932M/s/cpu)
> cycles                (16 cpus):  534.261 ± 0.107M/s  ( 33.391M/s/cpu)
> cycles                (24 cpus):  836.838 ± 0.141M/s  ( 34.868M/s/cpu)
> cycles                (32 cpus): 1099.689 ± 0.314M/s  ( 34.365M/s/cpu)
> cycles                (40 cpus): 1336.573 ± 0.015M/s  ( 33.414M/s/cpu)
> cycles                (48 cpus): 1571.734 ± 11.151M/s  ( 32.744M/s/cpu)
> cycles                (56 cpus): 1819.242 ± 4.627M/s  ( 32.486M/s/cpu)
> cycles                (64 cpus): 2046.285 ± 5.169M/s  ( 31.973M/s/cpu)
> cycles                (72 cpus): 2287.683 ± 0.787M/s  ( 31.773M/s/cpu)
> cycles                (80 cpus): 2505.414 ± 0.626M/s  ( 31.318M/s/cpu)
> 
> So, from about +42% on a single CPU, to +36% at 80 CPUs. Not that bad.
> Scalability-wise, we still see some drop off in performance, but
> believe me, with bpf_prog_test_run() it was so much worse :) I also
> verified that now we spend cycles almost exclusively inside the BPF
> program (so presumably in those benchmarked kfuncs).

Am I right that the numbers show how many iterations were done during
the very same amount of time? It would be also great to understand if
we get more precise measurements - just in case you have your tests
ready...


