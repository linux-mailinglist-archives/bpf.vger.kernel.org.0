Return-Path: <bpf+bounces-28375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6CD8B8E5E
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 18:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405971C2189F
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F245DDC9;
	Wed,  1 May 2024 16:41:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B86DDA1;
	Wed,  1 May 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581677; cv=none; b=KokEd9P4S9tdWFOkYQzgCORLhqlIGOFDMfSRUQzshc0yPln8DF3osH8pdV+EszYPYgydSksDs2pR9LG4lbVrelFJz6s9NEj2LKm/QydW5m697RApYd26muzSOhA2WHhYvXJSKPVrnt1jQDZahWHk4219bD44Mazuau5KLaecROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581677; c=relaxed/simple;
	bh=BQOQVhDGO9cPhZi4LM32TABd3WoSx8+2gBNiKq+LIlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdLdMi5IV9ZHPgOET76G+sPoxBQDwq/QOaYya3dsLTRYTP34pXnxoJPjNzdU/9dkwVQSfH9D7ZuOrijro2y5IaiyTx5QbgrvXIWsdNWKcw5wzwwVTRxMtaTVsDmgLjPnv/9kqxAS7pCpiE+oXbhmPJ+XPzucK8G5lMmYjrYVBjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B86402F4;
	Wed,  1 May 2024 09:41:39 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC2763F793;
	Wed,  1 May 2024 09:41:11 -0700 (PDT)
Date: Wed, 1 May 2024 17:41:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Sumit Garg <sumit.garg@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, puranjay12@gmail.com,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] arm64: implement raw_smp_processor_id() using thread_info
Message-ID: <ZjJwos7KpvzhoK_f@FVFF77S0Q05N.cambridge.arm.com>
References: <20240501154236.10236-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501154236.10236-1-puranjay@kernel.org>

Hi Puranjay,

On Wed, May 01, 2024 at 03:42:36PM +0000, Puranjay Mohan wrote:
> ARM64 defines THREAD_INFO_IN_TASK which means the cpu id can be found
> from current_thread_info()->cpu.

Nice!

This is something that we'd wanted to do, but there were some historical
reasons that prevented that. I think it'd be worth describing that in the
commit message, e.g.

| Historically, arm64 implemented raw_smp_processor_id() as a read of
| current_thread_info()->cpu. This changed when arm64 moved thread_info into
| task struct, as at the time CONFIG_THREAD_INFO_IN_TASK made core code use
| thread_struct::cpu for the cpu number, and due to header dependencies
| prevented using this in raw_smp_processor_id(). As a workaround, we moved to
| using a percpu variable in commit:
|
|   57c82954e77fa12c ("arm64: make cpu number a percpu variable")
|
| Since then, thread_info::cpu was reintroduced, and core code was made to use
| this in commits:
|
|   001430c1910df65a ("arm64: add CPU field to struct thread_info")
|   bcf9033e5449bdca ("sched: move CPU field back into thread_info if THREAD_INFO_IN_TASK=y")
|
| Consequently it is possible to use current_thread_info()->cpu again.

> Implement raw_smp_processor_id() using the above. This decreases the
> number of emitted instructions like in the following example:
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
> This improvement is in this very specific microbenchmark but it proves
> the point.
> 
> The percpu variable cpu_number is left as it is because it is used in
> set_smp_ipi_range()
> 
> [1] https://github.com/puranjaymohan/linux/commit/77d3fdd
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/include/asm/smp.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index efb13112b408..88fd2ab805ec 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -34,13 +34,9 @@
>  DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
>  
>  /*
> - * We don't use this_cpu_read(cpu_number) as that has implicit writes to
> - * preempt_count, and associated (compiler) barriers, that we'd like to avoid
> - * the expense of. If we're preemptible, the value can be stale at use anyway.
> - * And we can't use this_cpu_ptr() either, as that winds up recursing back
> - * here under CONFIG_DEBUG_PREEMPT=y.
> + * This relies on THREAD_INFO_IN_TASK, but arm64 defines that unconditionally.
>   */
> -#define raw_smp_processor_id() (*raw_cpu_ptr(&cpu_number))
> +#define raw_smp_processor_id() (current_thread_info()->cpu)

I think we can (and should) delete the comment entirely.

Mark.

