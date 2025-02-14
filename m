Return-Path: <bpf+bounces-51551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70024A35A34
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 10:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDC13AE838
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E499A23027C;
	Fri, 14 Feb 2025 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nOeSA79P"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D323F422;
	Fri, 14 Feb 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525068; cv=none; b=rqPSRM1acZ2bHlS0gqrNiUmOW7ZuKO67kccwI4/MDBo5H6Mi3G3lQy7KKACMyMTMXl4MBarqLxiLSFki3zS+ecUjuAt6ulXl571BihvE+/KgLscYF/EWJKIpGVxrE4rbnWgjnjKoX9iIeOthhYIru7SUlbm2hJ1KTovd9tpn9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525068; c=relaxed/simple;
	bh=X/sa3uIY8vGLToJUOET8MPdnJJI3A248eVnXpWF62yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGgJNFNLBFPFffSVdgpbBbpiDSZXQj4YAbLorjdU3qK+Cnz30LF6tF4nONFI5vZxIG6q7vrF4wGZQjUUBlC2uJAdk8fU3uIzEpz2O3NFNn0WD8+nJOr6H8kLWJEOJbhMddRxlXVE52qjiA28mlOiRGPfXWS6l7L6qmDblV3krAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nOeSA79P; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e87K5BME7QYyxriMEQKz8vW/Cg+m3JIePxp/P/BX5Nk=; b=nOeSA79PVD64loBRv+KHuRaE7f
	haPG28cMGQU/jxO8oBRjV+BOKLcZstJeK782tbNpjmkpit9RE6ZltRHCa365vqh57N5KOeYb3QoVC
	PnRKhtt06J7H8Qrd8Q4WVmj2QBM/SKp6peQ4nLMmzBNAmfdcZoYlqf18pnrkLS91tsOHHcr6lm84j
	+f4Hl3hKEp2FjE+WfGLFSlIZXTtMqc2gKpy49bpW8S3UHx1VbcFYsU1Qx9eQJZt/iMlxIBtMUs8Q/
	fcjbvKR3YwEx49snD1rUxylwiD5xWsVmGEHDsSMUG/PukufXU0arBaAEoEm3IUuiaZVU/RtPz5oPR
	cmyfoRdg==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tirvV-00H6fn-Pn; Fri, 14 Feb 2025 10:24:08 +0100
Message-ID: <4fd39e4b-f2dc-4b7d-a3be-ec3eae8d592a@igalia.com>
Date: Fri, 14 Feb 2025 18:23:55 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Add a retry after refilling the free list
 when unit_alloc() fails
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Tejun Heo <tj@kernel.org>,
 Andrea Righi <arighi@nvidia.com>, kernel-dev@igalia.com,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250212084851.150169-1-changwoo@igalia.com>
 <CAADnVQLRrhyOHGPb1O0Ju=7YVCNexdhwtoJaGYrfU9Vh2cBbgw@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAADnVQLRrhyOHGPb1O0Ju=7YVCNexdhwtoJaGYrfU9Vh2cBbgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Alexei,

Thank you for the comments! I reordered your comments for ease of 
explanation.

On 25. 2. 14. 02:45, Alexei Starovoitov wrote:
> On Wed, Feb 12, 2025 at 12:49 AM Changwoo Min <changwoo@igalia.com> wrote:

> The commit log is too terse to understand what exactly is going on.
> Pls share the call stack. What is the allocation size?
> How many do you do in a sequence?

The symptom is that an scx scheduler (scx_lavd) fails to load on
an ARM64 platform on its first try. The second try succeeds. In
the failure case, the kernel spits the following messages:

[   27.431380] sched_ext: BPF scheduler "lavd" disabled (runtime error)
[   27.431396] sched_ext: lavd: ops.init() failed (-12)
[   27.431401]    scx_ops_enable.isra.0+0x838/0xe48
[   27.431413]    bpf_scx_reg+0x18/0x30
[   27.431418]    bpf_struct_ops_link_create+0x144/0x1a0
[   27.431427]    __sys_bpf+0x1560/0x1f98
[   27.431433]    __arm64_sys_bpf+0x2c/0x80
[   27.431439]    do_el0_svc+0x74/0x120
[   27.431446]    el0_svc+0x80/0xb0
[   27.431454]    el0t_64_sync_handler+0x120/0x138
[   27.431460]    el0t_64_sync+0x174/0x178

The ops.init() failed because the 5th bpf_cpumask_create() calls
failed during the initialization of the BPF scheduler. The exact
point where bpf_cpumask_create() failed is here [1]. That scx
scheduler allocates 5 CPU masks to aid its scheduling decision.

Also, it seems that there is no graceful way to handle the
allocation failure since it happens during the initialization of
the scx scheduler.

In my digging of the code, bpf_cpumask_create() relies on
bpf_mem_cache_alloc(), and bpf_mem_alloc_init() prefills only
4 entries per CPU (prefill_mem_cache), so the 5th allocation of
the cpumask failed.

Increasing the prefill entries would be a solution, but that
would cause unnecessary memory overhead in other cases, so
I avoided that approach.

> But we may do something.
> Draining free_by_rcu_ttrace and waiting_for_gp_ttrace can be done,
> but will it address your case?

Unfortunately, harvesting free_by_rcu_ttrace and
waiting_for_gp_ttrace does not help (I tested it). In my case,
the memory allocation fails when loading an scx scheduler, so
free_by_rcu_ttrace and waiting_for_gp_ttrace are empty, and there
is nothing to harvest.


> Why irq-s are disabled? Isn't this for scx ?

In this particular scenario, the IRQ is not disabled. I just
meant such allocation failure can happen easily with excessive
allocation when IRQ is disabled.

>> (e.g., bpf_cpumask_create), allocate the additional free entry in an atomic
>> manner (atomic = true in alloc_bulk).
> 
> ...
>> +       if (unlikely(!llnode && !retry)) {
>> +               int cpu = smp_processor_id();
>> +               alloc_bulk(c, 1, cpu_to_node(cpu), true);
> 
> This is broken.
> Passing atomic doesn't help.
> unit_alloc() can be called from any context
> including NMI/IRQ/kprobe deeply nested in slab internals.
> kmalloc() is not safe from there.
> The whole point of bpf_mem_alloc() is to be safe from
> unknown context. If we could do kmalloc(GFP_NOWAIT)
> everywhere bpf_mem_alloc() would be needed.

I didn't think about the NMI case, where GFP_NOWAIT and GFP_ATOMIC are 
not safe.

Hmm.. maybe, we can extend 'bpf_mem_alloc_init()' or 'struct
bpf_mem_alloc' to specify the (initial) prefill count. This way
we can set a bit larger prefill count (say 8) for bpf cpumask.
What do you think?

[1] 
https://github.com/sched-ext/scx/blob/f17985cac0a60ba0136bbafa3f546db2b966cec0/scheds/rust/scx_lavd/src/bpf/main.bpf.c#L1970

Regards,
Changwoo Min

