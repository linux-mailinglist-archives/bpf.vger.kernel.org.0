Return-Path: <bpf+bounces-28652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A332A8BC75C
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 08:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29E91C21109
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B14AEF7;
	Mon,  6 May 2024 06:10:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ACC48CCD;
	Mon,  6 May 2024 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714975825; cv=none; b=tJ+cG2z+POUUIgOoFjeEH88Bi1enDAZ6cB3SQtm8/TS7rmVZ7J9496v3Fo4lyLEpr1Qi7BdZCOydLt07k+brrGdDkWLLD+odwONsYPnXILwFfsM4mKWutp14+o7eYH0gJKwk7pAqMfOj/wqLgUTdDLwQ3KjSzyejXI0sk4dVhl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714975825; c=relaxed/simple;
	bh=d9WvYebWfy7ti2lzrEEL3q0vMZgI9PwJYjd0o/nAgD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K9x0bUb7vjQOStgwW/OVhLogUOakMgswQirTyPg5CwYSOPvka9+uxzonai5MoUL+gWUEkN1L7eGrxnCBCtNAafbAPdrH/s3GPGyrrFGvrtObppjw4KN74wI6akzhNgJPqBgWb9er6HQiyA0lPar4Z1Xh3MUBvIjh4rHffvfy+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BC8C1007;
	Sun,  5 May 2024 23:10:47 -0700 (PDT)
Received: from [10.163.35.238] (unknown [10.163.35.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B5173F762;
	Sun,  5 May 2024 23:10:17 -0700 (PDT)
Message-ID: <cbcd29ab-2f8f-443e-96e4-0f2d134964db@arm.com>
Date: Mon, 6 May 2024 11:40:17 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64/arch_timer: include <linux/percpu.h>
To: Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>, Stephen Boyd <swboyd@chromium.org>,
 Douglas Anderson <dianders@chromium.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240502123449.2690-1-puranjay@kernel.org>
 <7008cd0c-5b65-4289-9015-434cbe3d7e21@arm.com> <mb61p4jbf8c29.fsf@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <mb61p4jbf8c29.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 15:14, Puranjay Mohan wrote:
> Anshuman Khandual <anshuman.khandual@arm.com> writes:
> 
>> On 5/2/24 18:04, Puranjay Mohan wrote:
>>> arch_timer.h includes linux/smp.h to use DEFINE_PER_CPU() and it works
>>> because smp.h includes percpu.h. The next commit will remove percpu.h
>>> from smp.h and it will break this usage.
>>>
>>> Explicitly include percpu.h and remove smp.h
>>
>> But this particular change does not seem to be necessary for changing
>> raw_smp_processor_id() as current_thread_info()->cpu being done in the
>> later patch ? You might still leave header <asm/percpu.h> inclusion in
>> arch/arm64/include/asm/smp.h while dropping the per cpu cpu_number ?
> 
> commit 57c82954e77f ("arm64: make cpu number a percpu variable")
> created this percpu variable and included <asm/percpu.h> in <asm/smp.h>
> 
> Now we are removing the percpu variable cpu_number from smp.h, so there
> is no need to keep percpu.h in smp.h

Fair enough.

> 
> I feel users of DECLARE_PER_CPU_[...], etc. should include percpu.h and
> not smp.h as it makes reading the code more easier and can thwart build
> issues in the future, when headers are changed. 
Right, makes sense, hope there is no more such cases using smp.h to pull
in DECLARE_PER_CPU_[...]. A quick build on defconfig is successful after
this patch.

