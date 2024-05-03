Return-Path: <bpf+bounces-28501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A6A8BA974
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 11:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890311F22FB4
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6030114F131;
	Fri,  3 May 2024 09:07:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E21367;
	Fri,  3 May 2024 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727277; cv=none; b=aOEAtjXR3csMtbZlj3puMgzATf2VEHC+woDtdaXadw9l8mGA162lkVYZ+HgywZZn7/P/y9rwqlz2jLJ9e7cc0DaF2uqnEflxvVmyc4MHL3+D67RT9ebD3zqdwrnNJTdqrqhsypT5KkbFNpMz9QpYGR61uRzoSibYyj13Mw1bwvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727277; c=relaxed/simple;
	bh=aNTy8TcgZ7Y19kzJ7boBqVizsW7L2J+7kUNs4xjDNXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdHPJLdS0Yk6z6iD1ho7m5x1gpwpstng1urlbde+UpgBtGbABo4+JvHO9xjEhtNV5UZR2jqldowsKmfCpvT0R/k6yW/K3aWAMiPPR7lnyD1W0XSNriU+TQXoeDihL3tRKTNBGvRmTEfWfA/OJZPbZCtdxlJiD8CHrGEuvFIamO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2200D2F4;
	Fri,  3 May 2024 02:08:19 -0700 (PDT)
Received: from [10.163.34.188] (unknown [10.163.34.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EE153F73F;
	Fri,  3 May 2024 02:07:48 -0700 (PDT)
Message-ID: <7008cd0c-5b65-4289-9015-434cbe3d7e21@arm.com>
Date: Fri, 3 May 2024 14:37:45 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64/arch_timer: include <linux/percpu.h>
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
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240502123449.2690-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/2/24 18:04, Puranjay Mohan wrote:
> arch_timer.h includes linux/smp.h to use DEFINE_PER_CPU() and it works
> because smp.h includes percpu.h. The next commit will remove percpu.h
> from smp.h and it will break this usage.
> 
> Explicitly include percpu.h and remove smp.h

But this particular change does not seem to be necessary for changing
raw_smp_processor_id() as current_thread_info()->cpu being done in the
later patch ? You might still leave header <asm/percpu.h> inclusion in
arch/arm64/include/asm/smp.h while dropping the per cpu cpu_number ?

> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/include/asm/arch_timer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 934c658ee947..f5794d50f51d 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -15,7 +15,7 @@
>  #include <linux/bug.h>
>  #include <linux/init.h>
>  #include <linux/jump_label.h>
> -#include <linux/smp.h>
> +#include <linux/percpu.h>
>  #include <linux/types.h>
>  
>  #include <clocksource/arm_arch_timer.h>

