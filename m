Return-Path: <bpf+bounces-27141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006118A9CFD
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 16:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBE81C2220D
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736EA16C436;
	Thu, 18 Apr 2024 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oVn8UC/W"
X-Original-To: bpf@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36C16ABC2;
	Thu, 18 Apr 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450274; cv=none; b=QJcgmFhxDK+PDCvAa9XuwY0Ft96l3lkNjx2T5AjElVgBPccITINRJC1m6Nq0ZTPboctj6P7Qm+torpGnMWbeZJRE5SHBzwKHAuReUJJx06/HBe/rxeV/CRSQ5qP6mkrxVGS7qZ7L2EYuejPjBwOax3HdF0YVcvI4RUGBDjn2Skc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450274; c=relaxed/simple;
	bh=pH0PBRBEjyEaCCaHbzJ9ynfPi+tXKlFVFiy1Z9RjDgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq8/LbVSkpGm8sM4Y5XCyjvRCjcCH30dZGKedua6uQUDI63yAgAvGPL15lHCXrR1pD96ue3lmFGFrjx1DvwpDlJX9mRWxFM972NlTXJXTJyrEkp9AZX8ucwz3t0Wdw+fMjjn8AXljUfVUlYcmMssjLIsFTrJQrtU0wOAvY0qtgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oVn8UC/W; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IENhfk047904;
	Thu, 18 Apr 2024 09:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713450223;
	bh=d7W/YpTIZxIdyewzNIraH7hxkKMvrK+9RnPBHoiRgYU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=oVn8UC/WraJiR9DfhqgRAMmWCKRPIN5gA4g9LgtVfHyr9ZYa0wpT1D1L9eCfM7V0I
	 1kGeA3ACt202+YA8etLSCi4dNNilaO9oBQFFqcvrsUeQegCCSt1xx61Wj3XLbh5lUN
	 TOOZmxV7HXQassnk1lpdykUeIfQeyrSrA+F0zYJo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IENhFG118313
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Apr 2024 09:23:43 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 09:23:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 09:23:42 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IENfLj049819;
	Thu, 18 Apr 2024 09:23:42 -0500
Date: Thu, 18 Apr 2024 19:53:41 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Julien Panis <jpanis@baylibre.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>,
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
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>,
        Jacob
 Keller <jacob.e.keller@intel.com>, <danishanwar@ti.com>,
        <yuehaibing@huawei.com>, <rogerq@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH net-next v9 0/3] Add minimal XDP support to TI AM65 CPSW
 Ethernet driver
Message-ID: <b406c8bd-5d25-4516-8553-4041705b2211@ti.com>
References: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
 <260d258f-87a1-4aac-8883-aab4746b32d8@ti.com>
 <08319f88-36a9-445a-9920-ad1fba666b6a@baylibre.com>
 <1da48c7e-ba87-4f7a-b6d1-d35961005ab0@ti.com>
 <7f7fb71a-6d15-46f1-b63c-b569a2e230b7@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f7fb71a-6d15-46f1-b63c-b569a2e230b7@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu, Apr 18, 2024 at 04:03:15PM +0200, Julien Panis wrote:
> On 4/18/24 13:25, Siddharth Vadapalli wrote:
> > On Thu, Apr 18, 2024 at 01:17:47PM +0200, Julien Panis wrote:
> > > On 4/18/24 13:00, Siddharth Vadapalli wrote:
> > > > On 12-04-2024 21:08, Julien Panis wrote:
> > > > > This patch adds XDP support to TI AM65 CPSW Ethernet driver.
> > > > > 
> > > > > The following features are implemented: NETDEV_XDP_ACT_BASIC,
> > > > > NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.
> > > > > 
> > > > > Zero-copy and non-linear XDP buffer supports are NOT implemented.
> > > > > 
> > > > > Besides, the page pool memory model is used to get better performance.
> > > > > 
> > > > > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > > > Hello Julien,
> > > > 
> > > > This series crashes Linux on AM62ax SoC which also uses the
> > > > AM65-CPSW-NUSS driver:
> > > > https://gist.github.com/Siddharth-Vadapalli-at-TI/5ed0e436606001c247a7da664f75edee
> > > > 
> > > > Regards,
> > > > Siddharth.
> > > Hello Siddharth.
> > > 
> > > Thanks for the log. I can read:
> > > [    1.966094] Missing net_device from driver
> > > 
> > > Did you check that nodes exist in the device tree for the net devices ?
> > Yes it exists. The device-tree used was also built with linux-next
> > tagged next-20240417. The node corresponding to eth0 is cpsw_port1 which
> > is present and enabled in the device-tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts?h=next-20240417#n644
> > 
> > Regards,
> > Siddharth.
> 
> I could reproduce the bug by disabling 'cpsw_port2' in my device tree,
> which is 'k3-am625-sk.dts' for the board I use.
> 
> A condition is missing in am65_cpsw_create_xdp_rxqs() and
> am65_cpsw_destroy_xdp_rxqs() functions.
> 
> For these 2 functions, the code which is in the for loop should be
> run only when port ethX is enabled. That's why it crashes with
> your device tree (cpsw_port2 is disabled, which is not the case by
> default for the board I developed with).
> 
> I'll send a patch to fix the issue. Thanks for reporting it.

Thank you for root-causing and working on the fix for this issue.

Regards,
Siddharth.

