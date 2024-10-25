Return-Path: <bpf+bounces-43132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BD49AF82D
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 05:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14531F22EFC
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 03:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39E618BC2C;
	Fri, 25 Oct 2024 03:30:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F351BC5C;
	Fri, 25 Oct 2024 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827033; cv=none; b=adsi8azc3V1q7a9rZpPFG3pl/vgEBgqkxCpz7EbmEWBNXfpCRFcBYzfRvdWhC0bQ0yNf6GOFR33v2ONqu8S/kPMkDBcwEMdg+5/9oCUjn3YnD2lxXtPuzBDcbbUCfuhk4QdfyY9jRwt6CdsFdA7JefbM6v3L4xN9dXUDoq42rCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827033; c=relaxed/simple;
	bh=vur3pwlndW+oEzqW/c2CZy5UT3diALSOxTxh+OTd7DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PKu1qTIIjOkN2U0ZpaFQYDb13swyhpOdAN9LWimSuo8jIJnoM4UnjYMY/nefNBw/yhg70xn1mSR2VlvmJC6ItYkfpnPP6LzWuwMbwpQToCwgJQ7E+HP1AuGmHXllIyNhDjbPRaoYRCnvLaYomqaMUXMJXA6GS3PXQD28LdjzRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XZStk3cX3z1jvrM;
	Fri, 25 Oct 2024 11:29:02 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A70941400DC;
	Fri, 25 Oct 2024 11:30:27 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 11:30:26 +0800
Message-ID: <b4332982-2b57-9e54-8225-cd6bee7d2cf8@huawei.com>
Date: Fri, 25 Oct 2024 11:30:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 net 0/4] Fix passing 0 to ERR_PTR in intel ether
 drivers
Content-Language: en-US
To: Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>,
	<maciej.fijalkowski@intel.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>,
	<sven.auhagen@voleatech.de>, <alexander.h.duyck@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20241022065623.1282224-1-yuehaibing@huawei.com>
 <20241022073225.GO402847@kernel.org>
 <584b87a4-4a69-4119-bcd8-d4561f41ed53@intel.com>
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <584b87a4-4a69-4119-bcd8-d4561f41ed53@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/10/23 3:17, Jacob Keller wrote:
> 
> 
> On 10/22/2024 12:32 AM, Simon Horman wrote:
>> On Tue, Oct 22, 2024 at 02:56:19PM +0800, Yue Haibing wrote:
>>> Fixing sparse error in xdp run code by introducing new variable xdp_res
>>> instead of overloading this into the skb pointer as i40e drivers done
>>> in commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c") and
>>> commit ae4393dfd472 ("i40e: fix broken XDP support").
>>>
>>> v3: Fix uninitialized 'xdp_res' in patch 3 and 4 which Reported-by
>>>     kernel test robot
>>> v2: Fix this as i40e drivers done instead of return NULL in xdp run code
>>
>> Hi Yue Haibing, all,
>>
>> I like these changes a lot. But I do wonder if it would
>> be more appropriate to target them at net-next (or iwl-next)
>> rather than net, without Fixes tags. This is because they
>> don't seem to be fixing (user-visible) bugs. Am I missing something?
>>
>> ...
> 
> Yea, these do seem like next candidates.

Should I resend this serial target to iwl-next?
> 
> .

