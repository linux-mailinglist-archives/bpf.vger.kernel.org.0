Return-Path: <bpf+bounces-44116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A17949BE213
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 10:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF90B233BD
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2411D95A9;
	Wed,  6 Nov 2024 09:12:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C91D8A04;
	Wed,  6 Nov 2024 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884364; cv=none; b=Lq5IntFa7H0hnCY6oIMQs9TmWUfMigJFJY+kzRTJ3CP4kbGfxXbnbtb+hFyhObVWBxVCG2ZAUVCXYJKVOG52PPQSzGUCHdvlv7/IVbFlfvVasBqHN5zKpfVgQdpW6uKw02FPmh7y/gIAR+l4PlGQGfFDvCApivn4vxo4b+kpC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884364; c=relaxed/simple;
	bh=6YtzTxo27BLuqqybhSbmOu/ytxHDEfIPXSd/2vFzzVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=JCI0Pqwn27tjouCGBNvtiz8zhizGBLWcEHDxNF0q8gdZBonXudVWy4CR3bgcZVvU1nPpfKeE7ISrBHaCjoWMeAfKDyayYN6aaRu8/y/tGW/uO/tOIhSNo0Yzaw+lUHt25L1aBfFQr94Y8pqFJCNnBFaO9srozMptUUoJttXwDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xjzvb0s1Zz10V78;
	Wed,  6 Nov 2024 17:10:51 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id B723418010F;
	Wed,  6 Nov 2024 17:12:37 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 6 Nov 2024 17:12:37 +0800
Message-ID: <8bcc6d5b-08d6-48a8-99d2-d8bb2bef2d6c@huawei.com>
Date: Wed, 6 Nov 2024 17:12:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] uprobes: Improve the usage of xol slots for better
 scalability
From: "Liao, Chang" <liaochang1@huawei.com>
To: <andrii@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov
	<oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>
References: <20240927094549.3382916-1-liaochang1@huawei.com>
In-Reply-To: <20240927094549.3382916-1-liaochang1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/9/27 17:45, Liao Chang 写道:
>>  2 files changed, 139 insertions(+), 42 deletions(-)
>>
> Liao,
> 
> Assuming your ARM64 improvements go through, would you still need
> these changes? XOL case is a slow case and if possible should be
> avoided at all costs. If all common cases for ARM64 are covered
> through instruction emulation, would we need to add all this
> complexity to optimize slow case?

Andrii,

I've studied the optimizations merged over the past month, it seems
that part of the problem addressed in this patch has been resolved
by Oleg(uprobes: kill xol_area->slot_count). And I hope you've received
the email with the re-run results for -push using simulated STP on
the latest kernel (tag next-20241104). It show significant improvements,
althought there's still room to match the throughput of -nop and -ret.
So based on these results, I would prioritize the STP simulation patch.

-- 
BR
Liao, Chang


