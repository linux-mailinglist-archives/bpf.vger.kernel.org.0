Return-Path: <bpf+bounces-42598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0119A64D8
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAFE1C21F3F
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE931E7C25;
	Mon, 21 Oct 2024 10:45:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF01E47B2;
	Mon, 21 Oct 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507532; cv=none; b=SMH56dJEOOCsUnWlXvzZINL5UYcP2mt0oRspNrZLR5T5LGaeCY1YCftLhKzFPd51moWBPJ99+biTGjVwSyU3N8LEn2tGleiU3w/COJf9VOMkgb7DFIPUkvmeN5zT+GSJpw/6JfsZRsq/ROoi6/6hVMV6vxdcth8Vt5LW/UdNGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507532; c=relaxed/simple;
	bh=vvXe8Z0w0Le7DSs3zokVIHd04LLEwNqimymWGLhsaaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p1d1n/KfK3UfWBHQhNIt45gtU2wYM83pF2s27zcW4rtaLXhStEjY+6IGQUEYiB8ViPgPVlZ9rdQlK7tdqks7fc0tl35NKkFvxy0CEtkgGzbWQt+iXL8bUKsVGLKdZFpuESEuEYIIpLmfFXcq20rsGRfm+7rIIPzwDmYAEYsDhmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XXBjk62slz1T8wt;
	Mon, 21 Oct 2024 18:43:22 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id DA1F114022E;
	Mon, 21 Oct 2024 18:45:21 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 21 Oct 2024 18:45:21 +0800
Message-ID: <91d19848-f5f4-4e0e-b3c7-77ac2befae3e@huawei.com>
Date: Mon, 21 Oct 2024 18:45:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: insn: Simulate nop instruction for better
 uprobe performance
To: Catalin Marinas <catalin.marinas@arm.com>, <will@kernel.org>,
	<ast@kernel.org>, <puranjay@kernel.org>, <andrii@kernel.org>,
	<mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240909071114.1150053-1-liaochang1@huawei.com>
 <172901867521.2735310.14333146229393737694.b4-ty@arm.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <172901867521.2735310.14333146229393737694.b4-ty@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/10/16 2:58, Catalin Marinas 写道:
> On Mon, 09 Sep 2024 07:11:14 +0000, Liao Chang wrote:
>> v2->v1:
>> 1. Remove the simuation of STP and the related bits.
>> 2. Use arm64_skip_faulting_instruction for single-stepping or FEAT_BTI
>>    scenario.
>>
>> As Andrii pointed out, the uprobe/uretprobe selftest bench run into a
>> counterintuitive result that nop and push variants are much slower than
>> ret variant [0]. The root cause lies in the arch_probe_analyse_insn(),
>> which excludes 'nop' and 'stp' from the emulatable instructions list.
>> This force the kernel returns to userspace and execute them out-of-line,
>> then trapping back to kernel for running uprobe callback functions. This
>> leads to a significant performance overhead compared to 'ret' variant,
>> which is already emulated.
>>
>> [...]
> 
> Applied to arm64 (for-next/probes), thanks! I fixed it up according to
> Mark's comments.
> 
> [1/1] arm64: insn: Simulate nop instruction for better uprobe performance
>       https://git.kernel.org/arm64/c/ac4ad5c09b34
> 

Mark, Catalin and Andrii,

I am just back from a long vacation, thanks for reviewing and involvement for
this patch.

I've sent a patch [1] that simulates STP at function entry, It maps user
stack pages to kernel address space, allowing kernel to use STP directly
to push fp/lr onto stack. Unfortunately, the profiling results below show
reveals this approach increases the uprobe-push throughput by 29.3% (from
0.868M/s/cpu to 1.1238M/s/cpu) and uretprobe-push by 15.9% (from 0.616M/s/cpu
to 0.714M/s/cpu). As Andrii pointed out, this approach is a bit complex and
overkill for STP simluation. So I look forward to more input about this patch,
is it possible to reach a better result? Or should I pause this work for now
and wait for Arm64 to add some instruction for storing pairs of registers to
unprivileged memory in privileged exception level? Thanks.

xol-stp
-------
uprobe-push     ( 1 cpus):    0.868 ± 0.001M/s  (  0.868M/s/cpu)
uretprobe-push  ( 1 cpus):    0.616 ± 0.001M/s  (  0.616M/s/cpu)

simulated-stp
-------------
uprobe-push     ( 1 cpus):    1.128 ± 0.002M/s  (  1.128M/s/cpu)
uretprobe-push  ( 1 cpus):    0.714 ± 0.001M/s  (  0.714M/s/cpu)

[1] https://lore.kernel.org/all/20240910060407.1427716-1-liaochang1@huawei.com/

-- 
BR
Liao, Chang


