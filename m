Return-Path: <bpf+bounces-28502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206BE8BA993
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 11:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E58C1F221CF
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 09:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE42014F127;
	Fri,  3 May 2024 09:14:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9744414F113;
	Fri,  3 May 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727667; cv=none; b=NyVSRZUGE9Jh6WTT7g10ya1xie/Qw+qIG/OAfcPdgJog1nyyfjf4i+PVtNAWoJr7cC4jjY4ppEYDP6RmHViSb+I/3wdkMMw97SINTIyXgORdXr+dwltIVj45SUrRzi66OwPZ/6l0ARF5giSIR7MQ2C2JTxiCWa3COj9gnrslX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727667; c=relaxed/simple;
	bh=4ra0slbfvRchcptOPIK9YRDh4kjzt5cthlclRiu0G1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFEGrJuXKbzZYEYw5hncgn5Q3x5Kh59nnIzr+V8FxNWP5tdr6WMCk9j5jHX6Hs8m2zkG8SQADx/y93VHO/O/OgFjcRn4Of+ABSstmzMz02/poYpVMYF7fCeVERGzIT+BQY2PKTLtZmKYH/W+O8nLungBtect+GrZw02KV9UG5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 361482F4;
	Fri,  3 May 2024 02:14:50 -0700 (PDT)
Received: from [10.163.34.188] (unknown [10.163.34.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD2CE3F73F;
	Fri,  3 May 2024 02:14:18 -0700 (PDT)
Message-ID: <312ae9b3-e328-410e-9f2f-02e6dccadff2@arm.com>
Date: Fri, 3 May 2024 14:44:10 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: implement raw_smp_processor_id() using
 thread_info
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>, Stephen Boyd <swboyd@chromium.org>,
 Douglas Anderson <dianders@chromium.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: puranjay12@gmail.com
References: <20240502123449.2690-1-puranjay@kernel.org>
 <20240502123449.2690-2-puranjay@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240502123449.2690-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/2/24 18:04, Puranjay Mohan wrote:
> Historically, arm64 implemented raw_smp_processor_id() as a read of
> current_thread_info()->cpu. This changed when arm64 moved thread_info
> into task struct, as at the time CONFIG_THREAD_INFO_IN_TASK made core
> code use thread_struct::cpu for the cpu number, and due to header
> dependencies prevented using this in raw_smp_processor_id(). As a
> workaround, we moved to using a percpu variable in commit:
> 
> commit 57c82954e77f ("arm64: make cpu number a percpu variable")
> 
> Since then, thread_info::cpu was reintroduced, and core code was made to
> use this in commits:
> 
> commit 001430c1910d ("arm64: add CPU field to struct thread_info")
> commit bcf9033e5449 ("sched: move CPU field back into thread_info if
> THREAD_INFO_IN_TASK=y")
> 
> Consequently it is possible to use current_thread_info()->cpu again.

This captures Mark's earlier suggestion on the commit message.


> 
> This decreases the number of emitted instructions like in the following
> example:
> 
> Dump of assembler code for function bpf_get_smp_processor_id:
>    0xffff8000802cd608 <+0>:     nop
>    0xffff8000802cd60c <+4>:     nop
>    0xffff8000802cd610 <+8>:     adrp    x0, 0xffff800082138000
>    0xffff8000802cd614 <+12>:    mrs     x1, tpidr_el1
>    0xffff8000802cd618 <+16>:    add     x0, x0, #0x8
>    0xffff8000802cd61c <+20>:    ldrsw   x0, [x0, x1]
>    0xffff8000802cd620 <+24>:    ret
> 
> After this patch:
> 
> Dump of assembler code for function bpf_get_smp_processor_id:
>    0xffff8000802c9130 <+0>:     nop
>    0xffff8000802c9134 <+4>:     nop
>    0xffff8000802c9138 <+8>:     mrs     x0, sp_el0
>    0xffff8000802c913c <+12>:    ldr     w0, [x0, #24]
>    0xffff8000802c9140 <+16>:    ret
> 
> A microbenchmark[1] was built to measure the performance improvement
> provided by this change. It calls the following function given number of
> times and finds the runtime overhead:
> 
> static noinline int get_cpu_id(void)
> {
> 	return smp_processor_id();
> }
> 
> Run the benchmark like:
>  modprobe smp_processor_id nr_function_calls=1000000000
> 
>       +--------------------------+------------------------+
>       |        | Number of Calls |    Time taken          |
>       +--------+-----------------+------------------------+
>       | Before |   1000000000    |   1602888401ns         |
>       +--------+-----------------+------------------------+
>       | After  |   1000000000    |   1206212658ns         |
>       +--------+-----------------+------------------------+
>       |  Difference (decrease)   |   396675743ns (24.74%) |
>       +---------------------------------------------------+
> 
> Remove the percpu variable cpu_number as it is used only in
> set_smp_ipi_range() as a dummy variable to be passed to ipi_handler().
> Use irq_stat in place of cpu_number here.
> 
> [1] https://github.com/puranjaymohan/linux/commit/77d3fdd
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
> Changes in v1 -> v2:
> v1: https://lore.kernel.org/all/20240501154236.10236-1-puranjay@kernel.org/
> - Remove the percpu variable cpu_number
> - Add more information to the commit message.
> ---
>  arch/arm64/include/asm/smp.h | 13 +------------
>  arch/arm64/kernel/smp.c      |  9 ++-------
>  2 files changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index efb13112b408..2510eec026f7 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -25,22 +25,11 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#include <asm/percpu.h>
> -
>  #include <linux/threads.h>
>  #include <linux/cpumask.h>
>  #include <linux/thread_info.h>
>  
> -DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
> -
> -/*
> - * We don't use this_cpu_read(cpu_number) as that has implicit writes to
> - * preempt_count, and associated (compiler) barriers, that we'd like to avoid
> - * the expense of. If we're preemptible, the value can be stale at use anyway.
> - * And we can't use this_cpu_ptr() either, as that winds up recursing back
> - * here under CONFIG_DEBUG_PREEMPT=y.
> - */
> -#define raw_smp_processor_id() (*raw_cpu_ptr(&cpu_number))
> +#define raw_smp_processor_id() (current_thread_info()->cpu)
>  
>  /*
>   * Logical CPU mapping.
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4ced34f62dab..98d4e352c3d0 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -55,9 +55,6 @@
>  
>  #include <trace/events/ipi.h>
>  
> -DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
> -EXPORT_PER_CPU_SYMBOL(cpu_number);
> -
>  /*
>   * as from 2.5, kernels no longer have an init_tasks structure
>   * so we need some other way of telling a new secondary core
> @@ -742,8 +739,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	 */
>  	for_each_possible_cpu(cpu) {
>  
> -		per_cpu(cpu_number, cpu) = cpu;
> -
>  		if (cpu == smp_processor_id())
>  			continue;
>  
> @@ -1021,12 +1016,12 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>  
>  		if (ipi_should_be_nmi(i)) {
>  			err = request_percpu_nmi(ipi_base + i, ipi_handler,
> -						 "IPI", &cpu_number);
> +						 "IPI", &irq_stat);
>  			WARN(err, "Could not request IPI %d as NMI, err=%d\n",
>  			     i, err);
>  		} else {
>  			err = request_percpu_irq(ipi_base + i, ipi_handler,
> -						 "IPI", &cpu_number);
> +						 "IPI", &irq_stat);
>  			WARN(err, "Could not request IPI %d as IRQ, err=%d\n",
>  			     i, err);
>  		}

set_smp_ipi_range() now looks similar to what we have on arm32 platform.

Besides the arch/arm64/include/asm/smp.h changes (not sure if is just a
clean up, then might be a stand alone patch on its own) this patch LGTM.

