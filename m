Return-Path: <bpf+bounces-30354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D02858CCA64
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 03:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76272B214D5
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 01:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4028EC;
	Thu, 23 May 2024 01:43:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A717C2;
	Thu, 23 May 2024 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716428582; cv=none; b=YDNqWer5Z1y2N8BALvJCe1JlfuayY5rthOox/IZ/A4YF5+e/E+VygSq84hV4GBW77gyVU7d0P7IqUFQDmFQ70TPZ7Eo4lDZThEMzB549fhAZULIhJ7MsyK7bPicRUbKofaBnvFeOj3XFXCxQZYJL53Ks/s8xtEJ9vpEmdmUcNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716428582; c=relaxed/simple;
	bh=eeUvrJQaoEchYn+M2SIKzuf4GCNGNI557vCfeFKSwy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HsSAjUxeZHM2pPpMjA1iTUAYMmwPqRtX7gh2PfNBNUN2kDX8yW32Dxc5DBBw98Pk8ChXK0r0H1aJLAwrLiSkdYoybutDUqlhdJJEnUD+ds4CbCsGw8xrs5TNEvhPEv3QPEqC8NPMw7NAvyvFUCivlB8ZS3NFAcLlw8keF+SviuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Vl9np6vh4z2CjFs;
	Thu, 23 May 2024 09:39:26 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 7863D140153;
	Thu, 23 May 2024 09:42:56 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 23 May 2024 09:42:55 +0800
Message-ID: <e769b8a5-dd11-4cf5-95bb-4399dd836113@huawei.com>
Date: Thu, 23 May 2024 09:42:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv, bpf: Use STACK_ALIGN macro for size rounding up
Content-Language: en-US
To: Xiao Wang <xiao.w.wang@intel.com>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<luke.r.nels@gmail.com>, <xi.wang@gmail.com>, <bjorn@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <haicheng.li@intel.com>
References: <20240522054507.3941595-1-xiao.w.wang@intel.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240522054507.3941595-1-xiao.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2024/5/22 13:45, Xiao Wang wrote:
> Use the macro STACK_ALIGN that is defined in asm/processor.h for stack size
> rounding up, just like bpf_jit_comp32.c does.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

It met a patching conflict. I think you should target for the bpf-next tree.
https://github.com/kernel-patches/bpf/pull/7080

