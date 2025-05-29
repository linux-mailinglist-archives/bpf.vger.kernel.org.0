Return-Path: <bpf+bounces-59319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4FCAC827E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 21:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F531C02AF1
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 19:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25345136347;
	Thu, 29 May 2025 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="saOQuajq"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D5723182C
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748545885; cv=none; b=Bx3WaUWc3hget/5O5eZrq/EhouDBEqG55QVzFvi1X7ILEmMn87GYG2nVA45CGrkNGR1TPWnzAT4XuUUWR4z4BkgYs0C92XSScTCBZCzDryDijpHS/Jj7xq/Baqd0FPFDo0qpsPF2M4S0gtai3GyAvYhS3w99BaX80YTV165i8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748545885; c=relaxed/simple;
	bh=2GfZWnG2Z9jmk7IVPvdqOZKTBamXSAvEzhnT6ZVuIog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cP1daJAABzgQaUHIqmwzA3WIRJQWCw84f6ehKmING+rJEA8WDyO4IiRdSTOP7wC7S/ux3yKzMF4kAWUYv5waJSKje2b/XlKSwdkv6VGDKGOWiVnm4znlsSu9R7fCwSLstZg2vNjE3SHIgEH52EVUQV3Wo10Ktco5d9JXir5ckeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=saOQuajq; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <99d3b3ef-44f7-4f93-a8e8-ec303dd6d750@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748545878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsLNV8w5Mk5SRqqTg1+3C9oZjlD06gLMBrLL9uNprEU=;
	b=saOQuajqoTkxw/CTjSJ5QTYXkA1wa5YMrGDGrX455yd9mnEV32eM5Ul+RCw8NPGs1xV66x
	dZ0VhI0JOjZr4vuwtRguud1YYPDAVvqMa96JVQLC65s4drPC5Ch5A8BY78fqHacvICuu1j
	612gdrzzD4QySu6dJvJKhhK2BbGur90=
Date: Thu, 29 May 2025 12:11:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/5] cgroup: move rstat base stat objects into their
 own struct
Content-Language: en-GB
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org, shakeel.butt@linux.dev,
 yosryahmed@google.com, mkoutny@suse.com, hannes@cmpxchg.org,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com,
 bpf@vger.kernel.org
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-2-inwardvessel@gmail.com>
 <6f688f2e-7d26-423a-9029-d1b1ef1c938a@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6f688f2e-7d26-423a-9029-d1b1ef1c938a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/29/25 11:58 AM, Ihor Solodrai wrote:
> On 4/3/25 6:10 PM, JP Kobryn wrote:
>> This non-functional change serves as preparation for moving to
>> subsystem-based rstat trees. The base stats are not an actual subsystem,
>> but in future commits they will have exclusive rstat trees just as other
>> subsystems will.
>>
>> Moving the base stat objects into a new struct allows the 
>> cgroup_rstat_cpu
>> struct to become more compact since it now only contains the minimum 
>> amount
>> of pointers needed for rstat participation. Subsystems will (in future
>> commits) make use of the compact cgroup_rstat_cpu struct while 
>> avoiding the
>> memory overhead of the base stat objects which they will not use.
>>
>> An instance of the new struct cgroup_rstat_base_cpu was placed on the
>> cgroup struct so it can retain ownership of these base stats common 
>> to all
>> cgroups. A helper function was added for looking up the cpu-specific 
>> base
>> stats of a given cgroup. Finally, initialization and variable names were
>> adjusted where applicable.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> ---
>>   include/linux/cgroup-defs.h | 38 ++++++++++-------
>>   kernel/cgroup/cgroup.c      |  8 +++-
>>   kernel/cgroup/rstat.c       | 84 ++++++++++++++++++++++---------------
>>   3 files changed, 79 insertions(+), 51 deletions(-)
>>
>
> Hi everyone.
>
> BPF CI started failing after recent upstream merges (tip: 90b83efa6701).
> I bisected the issue to this patch, see a log snippet below [1]:
>
>     ##[error]#44/9 btf_tag/btf_type_tag_percpu_vmlinux_helper
>     load_btfs:PASS:could not load vmlinux BTF 0 nsec
>     test_btf_type_tag_vmlinux_percpu:PASS:btf_type_tag_percpu 0 nsec
>     libbpf: prog 'test_percpu_helper': BPF program load failed: -EACCES
>     libbpf: prog 'test_percpu_helper': -- BEGIN PROG LOAD LOG --
>     0: R1=ctx() R10=fp0
>     ; int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char 
> *path) @ btf_type_tag_percpu.c:58
>     0: (79) r1 = *(u64 *)(r1 +0)
>     func 'cgroup_mkdir' arg0 has btf_id 437 type STRUCT 'cgroup'
>     1: R1_w=trusted_ptr_cgroup()
>     ; cpu = bpf_get_smp_processor_id(); @ btf_type_tag_percpu.c:63
>     1: (7b) *(u64 *)(r10 -8) = r1         ; R1_w=trusted_ptr_cgroup() 
> R10=fp0 fp-8_w=trusted_ptr_cgroup()
>     2: (85) call bpf_get_smp_processor_id#8       ; 
> R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>     3: (79) r1 = *(u64 *)(r10 -8)         ; R1_w=trusted_ptr_cgroup() 
> R10=fp0 fp-8_w=trusted_ptr_cgroup()
>     ; cgrp->self.rstat_cpu, cpu); @ btf_type_tag_percpu.c:65
>     4: (79) r1 = *(u64 *)(r1 +32)         ; 
> R1_w=percpu_ptr_css_rstat_cpu()
>     ; rstat = (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr( @ 
> btf_type_tag_percpu.c:64
>     5: (bc) w2 = w0                       ; 
> R0_w=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 
> 0x1)) 
> R2_w=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 
> 0x1))
>     6: (85) call bpf_per_cpu_ptr#153      ; 
> R0=ptr_or_null_css_rstat_cpu(id=2)
>     ; if (rstat) { @ btf_type_tag_percpu.c:66
>     7: (15) if r0 == 0x0 goto pc+1        ; R0=ptr_css_rstat_cpu()
>     ; *(volatile int *)rstat; @ btf_type_tag_percpu.c:68
>     8: (61) r1 = *(u32 *)(r0 +0)
>     cannot access ptr member updated_children with moff 0 in struct 
> css_rstat_cpu with off 0 size 4
>     processed 9 insns (limit 1000000) max_states_per_insn 0 
> total_states 1 peak_states 1 mark_read 1
>     -- END PROG LOAD LOG --
>     libbpf: prog 'test_percpu_helper': failed to load: -EACCES
>     libbpf: failed to load object 'btf_type_tag_percpu'
>     libbpf: failed to load BPF skeleton 'btf_type_tag_percpu': -EACCES
> test_btf_type_tag_vmlinux_percpu:FAIL:btf_type_tag_percpu_helper 
> unexpected error: -13 (errno 13)
>
> The test in question [2]:
>
> SEC("tp_btf/cgroup_mkdir")
> int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char *path)
> {
>     struct cgroup_rstat_cpu *rstat;
>     __u32 cpu;
>
>     cpu = bpf_get_smp_processor_id();
>     rstat = (struct cgroup_rstat_cpu 
> *)bpf_per_cpu_ptr(cgrp->rstat_cpu, cpu);
>     if (rstat) {
>         /* READ_ONCE */
>         *(volatile int *)rstat; // BPF verification fails here
>     }
>
>     return 0;
> }
>
> Any ideas about how to properly fix this?

The struct cgroup_rstat_cpu is renamed to css_rstat_cpu. Most likely the test needs
change. I will take a look.

>
> Thanks.
>
> [1] 
> https://github.com/kernel-patches/bpf/actions/runs/15316839796/job/43125242673
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c#n68

[...]


