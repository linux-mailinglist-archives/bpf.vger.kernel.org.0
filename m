Return-Path: <bpf+bounces-67106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884C2B3E253
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A0B3BF271
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2D2765ED;
	Mon,  1 Sep 2025 12:10:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B8273D6B;
	Mon,  1 Sep 2025 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728622; cv=none; b=uaTGymoOuaFRAWn8ttFpeMZg1xBxTZ6NG7rug89BeUUJCElegPDQMpiI7oLElDruYEhOzC6KyN7yF2KCd/FOlKDtGK/tL3xiIDGkbI0bVSMhIp1Qo0ewDmXG467r1X765DHf6BI6XerI6APiS3vMTK7RNiV41UMwI81h6GnQxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728622; c=relaxed/simple;
	bh=56pZPi78jRC/P44yfTNkxPsHPP0xCRIGVPevrmx6g18=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Lp4IfF6tfv4Wx4K7Lc9PGkAiG65QeeLNol7bddHuq4nLUWPM7Nowfpz79mwOMQNLoWtTW+6262jYb8OCYYmC5FTGih969tF4GPsQuDy0OtkexD2RdGVXOnoQVVguKsXZYW83agtRL6bSheLrHDcN/x1UHGjKnRFFaLu0yF/tdpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cFng12cMNz2VRdZ;
	Mon,  1 Sep 2025 20:07:09 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E36991800B2;
	Mon,  1 Sep 2025 20:10:13 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 20:10:12 +0800
Subject: Re: [PATCH] ACPI/IORT: Fix memory leak in iort_rmr_alloc_sids()
To: Miaoqian Lin <linmq006@gmail.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Joerg Roedel
	<jroedel@suse.de>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
CC: <stable@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>
References: <20250828112243.61460-1-linmq006@gmail.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <a2ac5b97-ea63-3187-164c-9568d7810a0a@huawei.com>
Date: Mon, 1 Sep 2025 20:10:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250828112243.61460-1-linmq006@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

+Cc Catalin, Will

On 2025/8/28 19:22, Miaoqian Lin wrote:
> If krealloc_array() fails in iort_rmr_alloc_sids(), the function returns
> NULL but does not free the original 'sids' allocation. This results in a
> memory leak since the caller overwrites the original pointer with the
> NULL return value.
> 
> Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> This follows the same pattern as the fix in commit 06615967d488
> ("bpf, verifier: Fix memory leak in array reallocation for stack state").
> ---
>   drivers/acpi/arm64/iort.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 98759d6199d3..65f0f56ad753 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -937,8 +937,10 @@ static u32 *iort_rmr_alloc_sids(u32 *sids, u32 count, u32 id_start,
>   
>   	new_sids = krealloc_array(sids, count + new_count,
>   				  sizeof(*new_sids), GFP_KERNEL);
> -	if (!new_sids)
> +	if (!new_sids) {
> +		kfree(sids);
>   		return NULL;
> +	}
>   
>   	for (i = count; i < total_count; i++)
>   		new_sids[i] = id_start++;

Good catch!

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

