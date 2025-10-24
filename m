Return-Path: <bpf+bounces-72005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C761C05229
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 10:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B1E6352A0D
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 08:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2857B307ADA;
	Fri, 24 Oct 2025 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PIAWQ+3k"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC333074AF;
	Fri, 24 Oct 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295488; cv=none; b=KRPEM8hYcWXQbr4sZ152Ox4u8VabUOnSVlHmZKHeDS9YJSn49RY+Xr9k5QNv1otsm/0amBT/b1aV/ajhSo+zfONFLMAtL46fGP+vFAlco29efEkFT76W6WlnDtrZMBlxbG5L05p8tc9D/hSPAYqzuZiWUvqPnEbgXboKZK8k0wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295488; c=relaxed/simple;
	bh=RUBNPB3AtMD0d3mNB+/CT5Me4yU+FU3u7SnGmbBeVas=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=peVoLt2OAU8wpE0NcbM26rRY5jTUKfLcx0sYX6ugTyfsSD9GiY1EER9lsxbVy1oa5RHQnQ7SDsOmBZ56wFIu90OepZ1KwJFZQLQKu7wk9A2ABdW/dYYkvCkuXiPWgLDVionwLcOQAHuygntKAzR4PA/f4UARFvZWS5sk4a6N9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PIAWQ+3k; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59O8hquH723152;
	Fri, 24 Oct 2025 03:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761295432;
	bh=ZvFR30qFwvZDHVGLed7EJCdp64TbpYruso0PUk2iDPA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PIAWQ+3ks1HLabNDuXtiE78yWF1Uy6I+QQ2OkdKTByw0Uee5iZvpFkK5lpy/M/Srk
	 sfQiJnsMDw0SokScbRv4/s79+iin2u0XXE3AYVHEMwHjQn1aIbysLrxcOh/9OT+7UR
	 eJKocEi9lwikTjSAbuD3jH+NKsbwJPuRqrYR5Hi0=
Received: from DFLE201.ent.ti.com (dfle201.ent.ti.com [10.64.6.59])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59O8hq7m3046177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Oct 2025 03:43:52 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 03:43:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 03:43:51 -0500
Received: from [172.24.18.185] (lt9560gk3.dhcp.ti.com [172.24.18.185])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59O8hipM077707;
	Fri, 24 Oct 2025 03:43:45 -0500
Message-ID: <dc82e53c-c565-460d-b268-26d0d5a9ed68@ti.com>
Date: Fri, 24 Oct 2025 14:13:43 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/6] Add AF_XDP zero copy support
To: Jacob Keller <jacob.e.keller@intel.com>, <horms@kernel.org>,
        <namcao@linutronix.de>, <vadim.fedorenko@linux.dev>,
        <christian.koenig@amd.com>, <sumit.semwal@linaro.org>,
        <sdf@fomichev.me>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
        <linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20251023093927.1878411-1-m-malladi@ti.com>
 <def1cb92-c0cd-440f-933a-55a5be71251b@intel.com>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <def1cb92-c0cd-440f-933a-55a5be71251b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Jacob,

On 10/24/2025 6:26 AM, Jacob Keller wrote:
> 
> 
> On 10/23/2025 2:39 AM, Meghana Malladi wrote:
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
>>
> 
> Do you think this means there is an issue with the patches or your test
> setup?
> 
> I didn't see anything stand out as a problem to me when reading the series:
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 

The setup is quite simple. I send broadcast traffic to the dut on which 
I run l2fwd (with xdpsock) and expect the stats to increase. But after 
4096 packets, the stats stop incrementing. And I see this issue only 
with 64 byte packet and not with 1500 byte packets. I am suspecting 
could be some race condition or some bug in our dma controller. I am 
tracking this issue and post a fix for this separately.

-- 
Thanks,
Meghana Malladi


