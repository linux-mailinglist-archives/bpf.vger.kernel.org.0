Return-Path: <bpf+bounces-27132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 558AB8A9810
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 13:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D36CEB217C0
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDEB15E217;
	Thu, 18 Apr 2024 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QxZGlHNu"
X-Original-To: bpf@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB9256464;
	Thu, 18 Apr 2024 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438076; cv=none; b=nmK1x/UAj3DB6IFBsLkExfhqCE1hZsNdgIII9ohgbZv1QAMm8ebhKRUjXD7w4JRDrRM1qZW0+Gz4yBZ3r2h3ZamLdJJZIK/6MxxlKqL0wfB4nBniEJkhxN0MPBlEY0o/G+HblG+kLuRF5sKgAF00azq+9UneMO430byz9hNYu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438076; c=relaxed/simple;
	bh=3zJU5bgxcWmtkNz86EQPd0gLB0h4nbvQXxqDcg0/kvk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AFFD3vpUg5JyjX8NmE/yFQJl0hQticuFcrs9wgUVDlip3I5Bgv0anL4wVthjQawO8tN9CixFsYCdWoqCT8Noa5UbxHCBJ9pqoMNfzUL7zwxb27qPF4IQzxO8xuyVRNw4yw0IEUKwEOwCpj1KNxpA0fxuJQ33Xbk8/F7G7qV14Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QxZGlHNu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IB0Nta078283;
	Thu, 18 Apr 2024 06:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713438023;
	bh=at/Dt6MSNlVNPyZjMygOEL5FNpd0NMfncK9CjfBmIac=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=QxZGlHNu5wFp9UtqUY7hG11xXZySfQsvIQRSN5rcgjLYP9jUu7AtOj5CG3MWaymXV
	 3ofJ/MT3wFpFVjGC2l+qrvCXfWlKC0DBoJ8GwN8C0LqlmdusYWtacsG4ePa2cnjy+o
	 OxAZqRvaUBfbqxYl0CuKxxYzNsgOw/PCHrNnajm4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IB0Nq3068002
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Apr 2024 06:00:23 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 06:00:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 06:00:23 -0500
Received: from [172.24.21.253] (lt5cd112gssc.dhcp.ti.com [172.24.21.253])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IB0E3B059919;
	Thu, 18 Apr 2024 06:00:15 -0500
Message-ID: <260d258f-87a1-4aac-8883-aab4746b32d8@ti.com>
Date: Thu, 18 Apr 2024 16:30:13 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <danishanwar@ti.com>, <yuehaibing@huawei.com>, <rogerq@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH net-next v9 0/3] Add minimal XDP support to TI AM65 CPSW
 Ethernet driver
Content-Language: en-US
To: Julien Panis <jpanis@baylibre.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John
 Fastabend <john.fastabend@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>,
        Jacob
 Keller <jacob.e.keller@intel.com>
References: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12-04-2024 21:08, Julien Panis wrote:
> This patch adds XDP support to TI AM65 CPSW Ethernet driver.
> 
> The following features are implemented: NETDEV_XDP_ACT_BASIC,
> NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.
> 
> Zero-copy and non-linear XDP buffer supports are NOT implemented.
> 
> Besides, the page pool memory model is used to get better performance.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Hello Julien,

This series crashes Linux on AM62ax SoC which also uses the
AM65-CPSW-NUSS driver:
https://gist.github.com/Siddharth-Vadapalli-at-TI/5ed0e436606001c247a7da664f75edee

Regards,
Siddharth.

