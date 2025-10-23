Return-Path: <bpf+bounces-71879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D2C00463
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 11:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505693AA352
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2B3090EB;
	Thu, 23 Oct 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ycYUtHe8"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E638305958;
	Thu, 23 Oct 2025 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212170; cv=none; b=Uc1o37BB29C8DAax/o25J+1gncZtV/hwOKSVFF/qqXSkz76T1wuKD6TBQlZGtUikk5G8VU0KdeEFigdTUCaYKFYjnqKZFmEKLFp4L+67s06jn5q1+A7/575QdYgQBWnhtMPoxTkYaxklD22P8nodxD/2QZvMIU+Hxp3GD8ytEsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212170; c=relaxed/simple;
	bh=uaaZDfd4Say4JVMfDA27XBtucXGfQ5q02IxKNSXE4SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S7Bn4ZpUyq2emoDZkFId96o6Xf+/CQR0ibJ4L+QPnm3ARx8G/7Y/bXyn1VZWS6DmstUxGhhkGaPIMCCPF2AbPxUa6RUHn5LXLjKgBaMYncJtdnbOZuQKP33IwjFR2HFZ2tVE0k1kp+XDQmfovlp0EUtjWu8pVycG0aT6av/E3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ycYUtHe8; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59N9Z46O495866;
	Thu, 23 Oct 2025 04:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761212104;
	bh=3BZ/Pw5p7gUSP7C6Gq7z9L0Pemml3h4TZLYNOzw8Qhc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ycYUtHe89cFtfiNd7ey6DVVPRMDmkAs6MWCSrsgUsC95kjqQ1Khj/QoZYRMzlQWYe
	 OWBSfTgF9r5QvQwXvviTsfqfLg7U6o6gw+owt9LvLNNdtcr+oQrgQbBkA7RijWbS4d
	 aCGVdMICWD7lKZblaBDoxtFInUJUIgiRNwUB+1Uc=
Received: from DFLE203.ent.ti.com (dfle203.ent.ti.com [10.64.6.61])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59N9Z3XD2614512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 04:35:03 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 04:35:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 04:35:03 -0500
Received: from [172.24.18.185] (lt9560gk3.dhcp.ti.com [172.24.18.185])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59N9Yua52645085;
	Thu, 23 Oct 2025 04:34:56 -0500
Message-ID: <f8285b3a-fe38-4f7b-aada-abbae105ab98@ti.com>
Date: Thu, 23 Oct 2025 15:04:55 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/6] Add AF_XDP zero copy support
To: Jakub Kicinski <kuba@kernel.org>
CC: <horms@kernel.org>, <namcao@linutronix.de>, <jacob.e.keller@intel.com>,
        <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
        <sdf@fomichev.me>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
        <linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20251014105613.2808674-1-m-malladi@ti.com>
 <20251020174308.59b87130@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20251020174308.59b87130@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 10/21/2025 6:13 AM, Jakub Kicinski wrote:
> On Tue, 14 Oct 2025 16:26:06 +0530 Meghana Malladi wrote:
>> This series adds AF_XDP zero coppy support to icssg driver.
>>
>> Tests were performed on AM64x-EVM with xdpsock application [1].
>>
>> A clear improvement is seen Transmit (txonly) and receive (rxdrop)
>> for 64 byte packets. 1500 byte test seems to be limited by line
>> rate (1G link) so no improvement seen there in packet rate
>>
>> Having some issue with l2fwd as the benchmarking numbers show 0
>> for 64 byte packets after forwading first batch packets and I am
>> currently looking into it.
> 
> This series stopped applying, could you please respin?

Yes, Thanks for the heads up.

-- 
Thanks,
Meghana Malladi


