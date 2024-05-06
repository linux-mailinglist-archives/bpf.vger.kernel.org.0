Return-Path: <bpf+bounces-28654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103128BC7E3
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 08:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417261C211DA
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 06:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF244F5F9;
	Mon,  6 May 2024 06:55:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90D4EB30;
	Mon,  6 May 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978529; cv=none; b=A7NCfQwgOYeheHBzMaP9+AAq7K36+bElRzS9yPWoqqIzZHLuA2ORHsvvqIRbRuZhpvocC8l20nEBJHw57M5tkK8oChkbUpGbtsaFe3w+7AQeuiHtXV+x8Xhta8B6JJREfbFUF7vHHKmd8fM5HbOJugwb0yLrPc4InNo4fdixhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978529; c=relaxed/simple;
	bh=p4nKbGRSZUCUjTOjUIDt7mBKfX/PgBwqpw8RVvP1ldE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+cKaeOFOjAgbKyncwCjjg4jejFAQh+wRALGFdAT6GQ2S5KyUQpx69rZiFh3t6ycLcDMUIIp2spQd7ZziwJnuHH5cWVIcaitzSJbNu76mgrh5pZTUPzFU/HP99GH4Hizaq0vSNaLJA52s3qmzJvrzMaIbnjMujJxDZhC4QpZelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74D441007;
	Sun,  5 May 2024 23:55:52 -0700 (PDT)
Received: from [10.163.35.238] (unknown [10.163.35.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE3A53F762;
	Sun,  5 May 2024 23:55:21 -0700 (PDT)
Message-ID: <5832f0f9-7eb3-4294-a83f-ca423ba010e7@arm.com>
Date: Mon, 6 May 2024 12:25:21 +0530
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
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

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

