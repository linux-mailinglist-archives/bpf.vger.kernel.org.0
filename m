Return-Path: <bpf+bounces-28383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D28B8ED4
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF2A1C21086
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BE518040;
	Wed,  1 May 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzDOwakc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C417C74;
	Wed,  1 May 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583579; cv=none; b=R5lWzQMZhCGHzcRxzRTrq3C/EPP90gDVzw/fYUsJXFSaGATDfej6eRs4B866gTDhU830WWf/HcRGMgCSFKe5nHy9+7hKG1qi8ED8c0lLP3K66NHi7BNG24840exGIGQpIq82D8b86b3gkgDLo8VMQ50FCFLiRto56Y2HXsXTDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583579; c=relaxed/simple;
	bh=zbcbIeexpIPCHZ07qIjb2xvy0LAIrIkIli7fZrlkkPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IhlxhjsnUcxQHZOF59WIXcpVYzvCeoaq4vi1OdY90g122z8X0WtAzAr4LmrOW//fsgbnqc+HCTT3JWgSW/2M04qYOc0BIRK/pn0jMZgbVMuNELTCNKgxJE2UUmCTY++OWa+EZ+QV7X1z/KWZIh3KcBS2bIudA7EHWNUx9dli/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzDOwakc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CF5C4AF18;
	Wed,  1 May 2024 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714583579;
	bh=zbcbIeexpIPCHZ07qIjb2xvy0LAIrIkIli7fZrlkkPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mzDOwakc6N/hsFge1akpD47JDrwLOLSaetMZZCmYVmWU9z77Y3smwP96XGF/jK7Lu
	 e7aAtkFjfydVufECpNDfIBHWdjYLU5hKhaz5RPKM9JwQsu6SdXL95X1b4aQVOD3NVk
	 J6hT+7VPC4XZG9m6xxKi1PErdm/GfALSq528wIRxRRg2MhxptlhXxxzxZWYjn9Q1L7
	 IBxowFFy6xHRYUuv6LOSXvKz+vVjFv9m4akDdidqK1TMxbjCx+3JXJ/qxTuqELRZ+B
	 FfRfP6x0R/RjQc3x9X+Or2FuHqCNDtMyeUB/TUedwngviJWWsqkwHygxDRteaXOtAb
	 Ukrj8mq6vgeHA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, Stephen Boyd
 <swboyd@chromium.org>, Douglas Anderson <dianders@chromium.org>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Ard Biesheuvel
 <ardb@kernel.org>
Subject: Re: [PATCH] arm64: implement raw_smp_processor_id() using thread_info
In-Reply-To: <ZjJwos7KpvzhoK_f@FVFF77S0Q05N.cambridge.arm.com>
References: <20240501154236.10236-1-puranjay@kernel.org>
 <ZjJwos7KpvzhoK_f@FVFF77S0Q05N.cambridge.arm.com>
Date: Wed, 01 May 2024 17:12:52 +0000
Message-ID: <mb61py18t78x7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Rutland <mark.rutland@arm.com> writes:

> Hi Puranjay,
>
> On Wed, May 01, 2024 at 03:42:36PM +0000, Puranjay Mohan wrote:
>> ARM64 defines THREAD_INFO_IN_TASK which means the cpu id can be found
>> from current_thread_info()->cpu.
>
> Nice!
>
> This is something that we'd wanted to do, but there were some historical
> reasons that prevented that. I think it'd be worth describing that in the
> commit message, e.g.
>
> | Historically, arm64 implemented raw_smp_processor_id() as a read of
> | current_thread_info()->cpu. This changed when arm64 moved thread_info into
> | task struct, as at the time CONFIG_THREAD_INFO_IN_TASK made core code use
> | thread_struct::cpu for the cpu number, and due to header dependencies
> | prevented using this in raw_smp_processor_id(). As a workaround, we moved to
> | using a percpu variable in commit:
> |
> |   57c82954e77fa12c ("arm64: make cpu number a percpu variable")
> |
> | Since then, thread_info::cpu was reintroduced, and core code was made to use
> | this in commits:
> |
> |   001430c1910df65a ("arm64: add CPU field to struct thread_info")
> |   bcf9033e5449bdca ("sched: move CPU field back into thread_info if THREAD_INFO_IN_TASK=y")
> |
> | Consequently it is possible to use current_thread_info()->cpu again.
>
>> Implement raw_smp_processor_id() using the above. This decreases the
>> number of emitted instructions like in the following example:
>> 
>> Dump of assembler code for function bpf_get_smp_processor_id:
>>    0xffff8000802cd608 <+0>:     nop
>>    0xffff8000802cd60c <+4>:     nop
>>    0xffff8000802cd610 <+8>:     adrp    x0, 0xffff800082138000
>>    0xffff8000802cd614 <+12>:    mrs     x1, tpidr_el1
>>    0xffff8000802cd618 <+16>:    add     x0, x0, #0x8
>>    0xffff8000802cd61c <+20>:    ldrsw   x0, [x0, x1]
>>    0xffff8000802cd620 <+24>:    ret
>> 
>> After this patch:
>> 
>> Dump of assembler code for function bpf_get_smp_processor_id:
>>    0xffff8000802c9130 <+0>:     nop
>>    0xffff8000802c9134 <+4>:     nop
>>    0xffff8000802c9138 <+8>:     mrs     x0, sp_el0
>>    0xffff8000802c913c <+12>:    ldr     w0, [x0, #24]
>>    0xffff8000802c9140 <+16>:    ret
>> 
>> A microbenchmark[1] was built to measure the performance improvement
>> provided by this change. It calls the following function given number of
>> times and finds the runtime overhead:
>> 
>> static noinline int get_cpu_id(void)
>> {
>> 	return smp_processor_id();
>> }
>> 
>> Run the benchmark like:
>>  modprobe smp_processor_id nr_function_calls=1000000000
>> 
>>       +--------------------------+------------------------+
>>       |        | Number of Calls |    Time taken          |
>>       +--------+-----------------+------------------------+
>>       | Before |   1000000000    |   1602888401ns         |
>>       +--------+-----------------+------------------------+
>>       | After  |   1000000000    |   1206212658ns         |
>>       +--------+-----------------+------------------------+
>>       |  Difference (decrease)   |   396675743ns (24.74%) |
>>       +---------------------------------------------------+
>> 
>> This improvement is in this very specific microbenchmark but it proves
>> the point.
>> 
>> The percpu variable cpu_number is left as it is because it is used in
>> set_smp_ipi_range()
>> 
>> [1] https://github.com/puranjaymohan/linux/commit/77d3fdd
>> 
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>  arch/arm64/include/asm/smp.h | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
>> index efb13112b408..88fd2ab805ec 100644
>> --- a/arch/arm64/include/asm/smp.h
>> +++ b/arch/arm64/include/asm/smp.h
>> @@ -34,13 +34,9 @@
>>  DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
>>  
>>  /*
>> - * We don't use this_cpu_read(cpu_number) as that has implicit writes to
>> - * preempt_count, and associated (compiler) barriers, that we'd like to avoid
>> - * the expense of. If we're preemptible, the value can be stale at use anyway.
>> - * And we can't use this_cpu_ptr() either, as that winds up recursing back
>> - * here under CONFIG_DEBUG_PREEMPT=y.
>> + * This relies on THREAD_INFO_IN_TASK, but arm64 defines that unconditionally.
>>   */
>> -#define raw_smp_processor_id() (*raw_cpu_ptr(&cpu_number))
>> +#define raw_smp_processor_id() (current_thread_info()->cpu)
>
> I think we can (and should) delete the comment entirely.

Sure,
I will add the information to the commit message and remove this comment
in the next version.

I think it would be useful to remove the cpu_number percpu variable as
well.

We can use &irq_stat in place of &cpu_number in set_smp_ipi_range() in
the calls to request_percpu_nmi/irq() as this is just a dummy value and
ipi_handler() doesn't use it.

There are no other users of cpu_number.

Thanks,
Puranjay

