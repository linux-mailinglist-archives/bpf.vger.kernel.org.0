Return-Path: <bpf+bounces-51845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA85A3A4B7
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 18:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C4047A4E48
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 17:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48820270EC0;
	Tue, 18 Feb 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vo1/Dqic"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33F26F45E;
	Tue, 18 Feb 2025 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901394; cv=none; b=NUCC2G1RtlIzUTS1q9kLaxV3dAch7msiEbiy1y89P26/VqOtnYpQXHGH468fSqUf5RnS1g8vG/aFJQoxBw1Z574ZQxD7wUOFI5d14ASfWs4M7qIcu9QgdUxqdItbOlJJJ6XVFA8nvweQamMb/RZCOPZ/ls9gWRYB9iE7E0xLKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901394; c=relaxed/simple;
	bh=8/xeGIFMWIi4dm7oFuwYay00JIETRD/k+jULot2/mq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZPPDB5w0retg8yc447gns6hS/v9kvimhlh8PUkWuCvZ5hJrEikR+Y0+apAfAc8rWSLlDmY6t0oSYpRqJQU1YNGYTPityns95uQP0S2pvxV1ivld0XOUVjYaEPWiXkj+qh24t0oaNOGveNW9kWYek4urzR0aLc2p0kjWglSkAciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vo1/Dqic; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51IHtwWL052717
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 18 Feb 2025 11:55:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739901358;
	bh=ZxZPMPRqc2YVU3nXWwH2+2obTCBbW0fH/0Zd2nYlJcY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Vo1/Dqic6aBhdbEUDoG5pV4dOv9AL6C/o6819Wdi9txicvAyU07Afyk9eE2quGkWQ
	 sIDl04TcV4U+4liBmvLPb5rJUOQAb9CzUmHF3wUjQIu4qyVT+5TaJfhrPXitz6OhAE
	 6VCXzDUQtTXxl3OGhwHpb9Fd8R87iD1VNYu7ZSNY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51IHtwW1031510;
	Tue, 18 Feb 2025 11:55:58 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 11:55:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 11:55:57 -0600
Received: from [10.249.140.156] ([10.249.140.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51IHtn69060469;
	Tue, 18 Feb 2025 11:55:50 -0600
Message-ID: <e1800e66-9043-4add-bbc9-19a8121de2f2@ti.com>
Date: Tue, 18 Feb 2025 23:25:49 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] Add native mode XDP support
To: Jesper Dangaard Brouer <hawk@kernel.org>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <u.kleine-koenig@baylibre.com>, <krzysztof.kozlowski@linaro.org>,
        <dan.carpenter@linaro.org>, <schnelle@linux.ibm.com>,
        <glaroque@baylibre.com>, <rdunlap@infradead.org>,
        <diogo.ivo@siemens.com>, <jan.kiszka@siemens.com>,
        <john.fastabend@gmail.com>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20250210103352.541052-1-m-malladi@ti.com>
 <285d1541-6af4-4dc3-bdcd-720bfc1f9aa4@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <285d1541-6af4-4dc3-bdcd-720bfc1f9aa4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/18/2025 9:32 PM, Jesper Dangaard Brouer wrote:
> 
> On 10/02/2025 11.33, Meghana Malladi wrote:
>> This series adds native XDP support using page_pool.
> 
> Please also describe *what driver* to adds XDP support for.
> 
> This cover letter will (by netdev maintainers) be part of the merge
> commit text.  Thus, please mention the driver name in the text.
> 
> This also applies for the Subject line.  It should either be prefix with
> "net: ti: icssg-prueth:" like you did for other patches, or be renamed
> to e.g.: "Add native mode XDP support for driver ti/icssg-prueth".
> 

Oh ok got it. Will update the subject line accordingly in v3 and follow 
the same for my upcoming patches. Thanks.

> Thanks,
> --Jesper


