Return-Path: <bpf+bounces-54843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1783FA743B4
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 07:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24F83B003E
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 06:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03EE21146F;
	Fri, 28 Mar 2025 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F96GF6DW"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963479CF;
	Fri, 28 Mar 2025 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743142350; cv=none; b=mvjbJBOmWeSE4FTDGw1pKt0X+EWVf2aVQt4KhIvbNX5rDgEdLnQuTTkmRgJxGJD1SN7UGTPXWdrpdh0jBgnKHZftsbESHeCvom2TCi2ibkb2Bbap+plp4aLWFpGN9KkK2HLqURioUoK/GErs8plstn6B/JApWjcvO4NWqMCNNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743142350; c=relaxed/simple;
	bh=qrK0dPbVWUOk4PR7RgSLOyEhCBzwdV2UZk0QMH06ekY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iT8lsNSue4/NW/kStNWPv7gzLzEtXv8jcgbu0t+phzQ/pRu50jC5bVRbTvRFmmKy3482bmU/w0utVzMWOcpbR8VqSaIWs+OLF8PoYKC1Ll9UxoXxYOi2j5Ju8QwvUBjSXMRxeSq6DGnsTEpV6nywamX85hbUgVN3KckouzMmBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=F96GF6DW; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52S6BYoe2633129
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 01:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743142294;
	bh=j9GlTDbw/VGq+mpBKGBMYd7sWUnu8ZpsWmTLspYzU0Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=F96GF6DWBTDVRcJr5ixE81enuTD2bJKxrQu9uNtWNPBV7AgpX9CO3KIUOPMXzEI5L
	 Lc97WzllLq+PDeRMCBOWJA4F2D3iYaPQ+OWgVWlYAJvedPD6iUPcsqsuJHBxncnFev
	 HM6+I7RdJQclCjZdiN6ispcVwO9VFNUYRKGaAhD0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52S6BYt7024519
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Mar 2025 01:11:34 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Mar 2025 01:11:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Mar 2025 01:11:34 -0500
Received: from [10.249.140.156] ([10.249.140.156])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52S6BQTf038705;
	Fri, 28 Mar 2025 01:11:27 -0500
Message-ID: <d1abf39d-c452-4bf1-ab40-2fc1ebca6ff7@ti.com>
Date: Fri, 28 Mar 2025 11:41:26 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] Bug fixes from XDP and perout series
To: Jakub Kicinski <kuba@kernel.org>
CC: <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kory.maincent@bootlin.com>,
        <dan.carpenter@linaro.org>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <jacob.e.keller@intel.com>,
        <horms@kernel.org>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
        <daniel@iogearbox.net>, <ast@kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250321081313.37112-1-m-malladi@ti.com>
 <20250325104458.3363fb5d@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20250325104458.3363fb5d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 3/25/2025 11:14 PM, Jakub Kicinski wrote:
> On Fri, 21 Mar 2025 13:43:10 +0530 Meghana Malladi wrote:
>> This patch series consists of bug fixes from the features which recently
>> got merged into net-next, and haven't been merged to net tree yet.
>>
>> Patch 2/3 and 3/3 are bug fixes reported by Dan Carpenter
>> <dan.carpenter@linaro.org> using Smatch static checker.
> 
> Could you perhaps add the customary
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> tags, then?
> 
> Please also link to the reports.

Sure, I will add them and post to the v3 to net.

