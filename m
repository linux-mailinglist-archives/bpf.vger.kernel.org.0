Return-Path: <bpf+bounces-42358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E89A3277
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 04:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533841F23F93
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 02:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8387014885E;
	Fri, 18 Oct 2024 02:14:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAB33B1B5;
	Fri, 18 Oct 2024 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729217684; cv=none; b=YWzcGd0VarSUinwZC3YX1R5UePAOsbQTixKb0nvKxbdXW5phsP4g5RgR5XK2ppUeSzxBrviPAxVT+XyyUdZBdmLrt+E2h/z/C4gXVPN9JyncmjxZqzzqPUkLql2k3rAnecQcLx2SZHDjF2Df2e5QBPsDyRbcrnjYz3O2n/bqBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729217684; c=relaxed/simple;
	bh=pA/idpT20pncGndNCyI8QyEBEKOg7Tqwq1qcN1p/HzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pLJDS/UdpDfKv3vdSlDNB+wEtTXMae+JkiRY+9oqc1SRIL68oSTwD3mP1ZCA247Z+Ckm1kiS8wKKGELH7IUjz14BS5tPUKCkuKdpuizAw5mlqPiljqWyztH77IlNxPzJ3r0nerLerAeg7p2QYvmWGO198NrpUOKPlarrOX+6xIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XV7XT0QJGzyQcj;
	Fri, 18 Oct 2024 10:13:13 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id BC32E1402CF;
	Fri, 18 Oct 2024 10:14:38 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 10:14:37 +0800
Message-ID: <8831250e-dc90-a1f5-7490-d6e59d5aa778@huawei.com>
Date: Fri, 18 Oct 2024 10:14:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH -next 0/4] Fix passing 0 to ERR_PTR in intel ether drivers
Content-Language: en-US
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>,
	<maciej.fijalkowski@intel.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20241018022926.1911257-1-yuehaibing@huawei.com>
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20241018022926.1911257-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Pls ignore this corrupt patch, sorry for noise.

On 2024/10/18 10:29, Yue Haibing wrote:
> Fixing sparse error in xdp run code by introducing new variable xdp_res
> instead of overloading this into the skb pointer as i40e drivers done
> in commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c") and
> commit ae4393dfd472 ("i40e: fix broken XDP support").
> 
> Yue Haibing (4):
>   igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
>   igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
>   ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()
>   ixgbevf: Fix passing 0 to ERR_PTR in ixgbevf_run_xdp()
> 
>  drivers/net/ethernet/intel/igb/igb_main.c     | 22 +++++++-----------
>  drivers/net/ethernet/intel/igc/igc_main.c     | 20 ++++++----------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 23 ++++++++-----------
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 23 ++++++++-----------
>  4 files changed, 34 insertions(+), 54 deletions(-)
> 

