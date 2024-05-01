Return-Path: <bpf+bounces-28372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAFE8B8E21
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 18:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42B41F2115D
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1BD130484;
	Wed,  1 May 2024 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="o6UMsQ6s"
X-Original-To: bpf@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FD53368;
	Wed,  1 May 2024 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580642; cv=none; b=aJpWKXoYm4ovVVO8va1gNlJIYqmmCeH9lSUesEWstztrSFCu7G/s1GPcP1rtCrnrarEoSqwaSVLcu1xjfFqnKWKqnX0fn6wE/Al1/OoTfnUz2/p9MPE9mN32JVTH3R1l6JfZVrk0qQBaLSHLptppNL90VNLhqQ3aKfW4AoqGyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580642; c=relaxed/simple;
	bh=l0V5HGu95kO5qgq2XS1KnTgZewpsITQF5ij/V9NUhTw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jTtRTtXPRihxfHNzt4jS2VUcSBFlDMUzYc4t1SjSS1PoKrl+TidFRXtaOz69UEXm76DbA6Ywh0pK969+rIEB53nSsUWThsGGQtrHJd/BzXryql76JClkVMz72nvyzOgs+vofr0lhsDWVj79uJkshApzgm9KmLzp6pnrz5PLFHFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=o6UMsQ6s; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1714580634;
	bh=l0V5HGu95kO5qgq2XS1KnTgZewpsITQF5ij/V9NUhTw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=o6UMsQ6sBVUOoaOZnWF/sGLQ06jDahYjn1yG58Zj8f/sPqM5EJTE9PDq3TGyGZAkB
	 4ExEHxc61W8I9dRB9Yu1n3z9lyHxsPGppi3d/EpzUDIOhdq102bFnCitDvQduLhHn1
	 RSA9/CYJ17jtmjE1lShn5dDPPc04sU+HYfBOl6eU=
Received: by gentwo.org (Postfix, from userid 1003)
	id 85081401D5; Wed,  1 May 2024 09:23:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 829A5401C3;
	Wed,  1 May 2024 09:23:54 -0700 (PDT)
Date: Wed, 1 May 2024 09:23:54 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Puranjay Mohan <puranjay@kernel.org>
cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Sumit Garg <sumit.garg@linaro.org>, Stephen Boyd <swboyd@chromium.org>, 
    Douglas Anderson <dianders@chromium.org>, 
    "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
    Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    bpf@vger.kernel.org, puranjay12@gmail.com, 
    Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] arm64: implement raw_smp_processor_id() using
 thread_info
In-Reply-To: <20240501154236.10236-1-puranjay@kernel.org>
Message-ID: <76b26dc9-af60-ee7f-6be5-dc17937b4a51@gentwo.org>
References: <20240501154236.10236-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 1 May 2024, Puranjay Mohan wrote:

> Dump of assembler code for function bpf_get_smp_processor_id:
>   0xffff8000802cd608 <+0>:     nop
>   0xffff8000802cd60c <+4>:     nop
>   0xffff8000802cd610 <+8>:     adrp    x0, 0xffff800082138000
>   0xffff8000802cd614 <+12>:    mrs     x1, tpidr_el1
>   0xffff8000802cd618 <+16>:    add     x0, x0, #0x8
>   0xffff8000802cd61c <+20>:    ldrsw   x0, [x0, x1]
>   0xffff8000802cd620 <+24>:    ret

In general arm64 has inefficient per cpu variable access. On x86 it is 
possible to access the processor id via a segment register relative 
access with a single instruction.

Arm64 calculates the address of a percpu variable for each access. This 
result in inefficiencies because:

1. The address calculation is processor specific. Therefore preemption 
needs to be disabled during the calculation of the address and while it is 
in use.

2. Additional registers are used causing the compiler to potentially 
generate less efficient code.

3. Even RMV instructions on percpu variables require the disabling of 
preemption due to the address calculation.

Russel King has a patchset for NUMA text replication and as part of that 
he introduces per cpu kernel page tables.

https://lwn.net/Articles/957023/

If we had per cpu page tables then we could create a mapping for a fixed 
address virtual memory range to the physical per cpu area for each cpu.

With that the address calculation would no longer be necessary for per 
cpu variable access and workarounds like this would not be necessary 
anymore.

The retrieval of the cpu id would be a single instruction that 
performs a load from a fixed virtual address. No preemption etc would be 
required.

