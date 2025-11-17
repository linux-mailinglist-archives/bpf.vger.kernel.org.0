Return-Path: <bpf+bounces-74712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B77C6321A
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 10:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD19E3A9C8E
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E0B326947;
	Mon, 17 Nov 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vYccNuXM"
X-Original-To: bpf@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46A9324B1C;
	Mon, 17 Nov 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371168; cv=fail; b=hSh3oaWQhOwRZtgcFbsU/Qrnh0WsQStiuxch1dKJPSmjtcmZUB2mgXgG9Pa5Re3qo7XU8bDqIwT3g7T2JpjT4R8Zli1FqZS0mhfAMlt+PB0XLAMijuvB/NjD9XUw2WC9PGSpDn/wdUZ9MFvR/wfDCdjVZXnBlNNy1XS6hLfcP94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371168; c=relaxed/simple;
	bh=sSwAimri53ZpqaxGMofsug+mGOlCKaqv1drZ6Kq1Qq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lRkA3PZPuhconuKA3ilRisVxdm7J5Ra/LPn8kN2rFfjb39lJwgGAw0BWMMVj21YteFgYRucBZnCOdXv2QN2pUNZy8SsCU683QNOMuBOKBZtEx3O95C1UrKW3IwmXRrBFhRlO83V5kyVZzaM29IQCIY6ZpUcFDoVA3wDtQ+urmPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vYccNuXM; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1xho5q6gK6nLoM26l+75eOBMu7tFMNcUdnsViOMem1mrViu1Ox/HR1BumuKjH2Kzpdk7tJtp1cYVoH1e313EVyLDME6jhs/jZ14L6k1ZXLopaI/cKxsfvFXMy1Zw0jeHWwIcEh5MUdQLnjAmn5KehChA+qe4z2bGxn66A03eTvzJBQ55YAAf62nn0Vud6F4Nv+/En6MZRt4EFKyYGztxjJ6/ULHpRMSl3fvc1Xg4qxEzMvu/e/AZd5nEfrEkDXFsWckhzaqVWwstC4le9TwpHfcTE9u/+VJ4uxvgudv5QxhYLbmoefLFJ+tb3OFeXG9pjFqzqzze4HaiGFUncSx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vXWvCvUE0dOVfLT8XLz/Xwe5MDyHfj8CzkR4lEGFMI=;
 b=kY9LXlJm8g2kDkkqpCQxpbe+Lx2gDvs0v48QZS30eppmyItE3LOKrpd03t3u+Y9cDe+iqo0W/vwmrT8MA1wytBQJc3nevrO6tKbcV5BP4ZS76+AYmIqgFXxrK9rSztvd7Zi4C022cGXonXdMMiidwkcyHU8aFeGHmT+FK/C0+GdDm0WEeSGXrh9HtqPI9ajS3iG5+ZdnFqX3SBDav3gw+z0pjMV4pvi+YVmxcx283jJXOgXOpiSqDdvcmrpfN857IO6TFnVkM7cgfWeX5JPMedbdAlkEUyz6O5R/jTDDBlztzP3No7MwtPuBglwexBYE3e26KAchBFNr1QsOG6QlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vXWvCvUE0dOVfLT8XLz/Xwe5MDyHfj8CzkR4lEGFMI=;
 b=vYccNuXM5PJC2uBCDdtWlpTvUKNzTVSwcqYbpy8maMmGUFE9F+hiDggk9O4orqHg98a80yA8e18nQ8KYdcuPwze8f09BqfDIO5um1uUin4f1MLlwlDYFJve3xHhXUq2aOj38/w+kmOZOwpA1riXlRqqnpagW8RDAFaTijU6q82Y=
Received: from SJ2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:a03:505::25)
 by DS7PR10MB4878.namprd10.prod.outlook.com (2603:10b6:5:3a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Mon, 17 Nov
 2025 09:19:21 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::14) by SJ2PR07CA0002.outlook.office365.com
 (2603:10b6:a03:505::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 09:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 09:19:21 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 03:19:18 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 03:19:18 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 17 Nov 2025 03:19:18 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AH9J89Y2242206;
	Mon, 17 Nov 2025 03:19:09 -0600
Message-ID: <b547779d-8dad-4e01-b9f4-a291d70ba6be@ti.com>
Date: Mon, 17 Nov 2025 14:49:07 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/6] net: ti: icssg-prueth: Add AF_XDP zero
 copy for RX
To: Simon Horman <horms@kernel.org>
CC: <namcao@linutronix.de>, <vadim.fedorenko@linux.dev>,
	<jacob.e.keller@intel.com>, <christian.koenig@amd.com>,
	<sumit.semwal@linaro.org>, <sdf@fomichev.me>, <john.fastabend@gmail.com>,
	<hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
	<linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20251111101523.3160680-1-m-malladi@ti.com>
 <20251111101523.3160680-6-m-malladi@ti.com>
 <aRcFb-vsoLw24MbU@horms.kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <aRcFb-vsoLw24MbU@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS7PR10MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9abde0-0dc2-455c-dbaf-08de25ba645b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGxld001YmhKVFlsTDl5VmFpOGNvWFlrTlVtUG9qZVRMTTRoYXE2d2ZDMTA2?=
 =?utf-8?B?Qm9kTDdEMzlYdW1mMVhucmk2dkw2cjMrdjZDdjcwOWlWSmJ5Ky9peWFjeWhB?=
 =?utf-8?B?NnJ4NHdaS3ZidVYrSHdMRnMyeVVteUZ1eTFsejMxeUhwQjlIcmhyN01YaUZ6?=
 =?utf-8?B?VUNpSGRxdDNWa2s0KzVBNzUyZUlaam9FSVF1WFFnczl1T3hFUnNnNm4wNWMv?=
 =?utf-8?B?OXYzNUh2WXFWTFNJK0lVL1pQd2RpMWh3eFBkQXdsaDFpUjMxOEpJTk1YajVJ?=
 =?utf-8?B?OFBnUWU2WmJtd0k2Y2MxcW83cWpta2RDc2hPQXJLYTdzY211c255UWJPREx1?=
 =?utf-8?B?dVlYY3FJWmJDK3M3WWhXWXZ6QnhVdnd1cTYvd0R5SmQwODBhMTgwQlhVSC9Q?=
 =?utf-8?B?M1A2dFBnNTRCS1N6eDR0Tm9iMEFFZkp2Rk9mVFJOTm1Lc3NTV3RDanUzMWJo?=
 =?utf-8?B?TU1wMlk5aFNnMHFYS2NNa0xHVlhOMmNLNkhuUENGaUw0NzYvOFBVUDB1ZzZZ?=
 =?utf-8?B?YnQ5WXk4WmR4ekFLbzEvU2RYU3ZzZElxT2p3Y3FDNUhFVnZkdktGWWhBeEdH?=
 =?utf-8?B?QUxMLzBaYVlBaWdrd3p2TzhNRWdabkNhQ0hta0p4aUh5WVdNeG85ZjFQSmFE?=
 =?utf-8?B?cnlPTTVoMXNYdlFlK0R0a2czelhTT0hvUWcrMURvZmd3dlJhRC8zRnVyS2VV?=
 =?utf-8?B?L3VrN2k1OXhyL3l1WkdIdHhTL0x6SWs0V215YVkxc3AwZlNiOXJMdHhRaWFN?=
 =?utf-8?B?aDhKVXg3LzVTWm9BQnJCUldOYm82RTg3dXJ0UDhNN3hEZVJjV0p4elczcU13?=
 =?utf-8?B?THNEU3pkV1pkL2plU0ZUU0JYUUNBY2xDSjBwUm9HOUtOWlpCSWRGYnFINUFy?=
 =?utf-8?B?eXpFMHg5K3dOdUw1QjlkSzRWb245REhVc0hpSjJHb0R5UGZVbUszYmtTc2x6?=
 =?utf-8?B?dE9uRW9WYW9zbkNMd3ppblRZMVljbFIyUGE2eFk4dkpFTWFCM3ZaeU51Y1Mv?=
 =?utf-8?B?dTZUWWt3ZG5RUy9jWkV2dW5vQjkzZ1YzT2VndEN3UmV4ZmN6eElHTDEwYlkr?=
 =?utf-8?B?SlI2d1lrQ082U2RvN2Z5SWh3eXpLczdneU5CNzBKelNqdjduWWxSWGpRWFhP?=
 =?utf-8?B?SHYxRUZ2SzM4U0FkSlhhQXhxcFdVZjlpb1ZSaEdmVTVQNHo4amNlcURxaGJz?=
 =?utf-8?B?dTBTM0FqZ0VZQTR1eERnbmZBaHdBeVhRenR0M2wvaDNSdTMveTdjQ3hnNnQ2?=
 =?utf-8?B?eUNJYTViVTdqTTFUektuSTNYbFBmWEcydExWSlgxU0twMWRuRkxGQ21iTTlZ?=
 =?utf-8?B?bFEvWUFwY0ZGdFFCWW4wa1UwSUhIMEFMdk9qeFpkUCtZcVpBQitvYk1TaGYr?=
 =?utf-8?B?RTJtVXF0Qjd0MW5wZUR2ZmFiZEIwNUZWWTg1QVM4dEFxa3NBTURLNHA3MkVU?=
 =?utf-8?B?MVlxMG1MeUZ5ZnJHYTlxbFoxNTlCdEkxQXo5YU8xTDJXZTBXVlliUXBWZkgy?=
 =?utf-8?B?MStQbzZYVHN6aTJIN2crM0NVOTh3SjRYZGMzN2RlSTd4N2dDUTkrci9xSGJm?=
 =?utf-8?B?OUZHdkkrSDlDd1Q4c0JKdTBXTUxOOHZMYXNwNzYzSm15K0w2WmxhdEZSWGZh?=
 =?utf-8?B?L3N4UUJwVFEvb3MycXhINU5pTFZ3UzY1dklvWG1IY1Mvd0xBeFZFUWo4Znlr?=
 =?utf-8?B?eTBYNzRyUXFTc2NFalF2SGw2c1djTUh4d0hic0hSakpSVmN1bzNpMDZud3ph?=
 =?utf-8?B?enlCNGpta1U4dEVoaGFSSmN5Tkc1WXg2NmVoM2JDZ0tJMlJrMXRmMTZDbmpj?=
 =?utf-8?B?d2tidFRpVDNNSElTelkwZy96R2pkUEFRWjFJOXN5NGV0M0piYkJOWnBzUjBQ?=
 =?utf-8?B?VzFrUGg2ZUZGVmVuSkQ2TUp1aUdhT2RObE1QSFcvTlZldTdXRWlVSjFFNDBM?=
 =?utf-8?B?VTVzNnNNeDJkSitkdlh1RXpBZ2hzWHdsWUJXbi9NcHhjUHplVkdnR3hZdUp1?=
 =?utf-8?B?TS95eGlyQlN3VlJlb05vam9OMTZHZENOS0ZDRVp2dXoxNE9ObTZXZmVJbXRa?=
 =?utf-8?B?VEx6Smd5Si9OQk0yL3FqL3FlQ0xTbHhITVNoL0pwc2x4QWtwTDNNdjZRL0Yr?=
 =?utf-8?Q?RIw4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:19:21.0396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9abde0-0dc2-455c-dbaf-08de25ba645b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4878

Hi Simon,

On 11/14/25 16:03, Simon Horman wrote:
> On Tue, Nov 11, 2025 at 03:45:22PM +0530, Meghana Malladi wrote:
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> 
> ...
> 
>> +static int prueth_dma_rx_push_mapped_zc(struct prueth_emac *emac,
>> +					struct prueth_rx_chn *rx_chn,
>> +					struct xdp_buff *xdp)
>> +{
>> +	struct net_device *ndev = emac->ndev;
>> +	struct cppi5_host_desc_t *desc_rx;
>> +	struct prueth_swdata *swdata;
>> +	dma_addr_t desc_dma;
>> +	dma_addr_t buf_dma;
>> +	int buf_len;
>> +
>> +	buf_dma = xsk_buff_xdp_get_dma(xdp);
>> +	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
>> +	if (!desc_rx) {
>> +		netdev_err(ndev, "rx push: failed to allocate descriptor\n");
>> +		return -ENOMEM;
>> +	}
>> +	desc_dma = k3_cppi_desc_pool_virt2dma(rx_chn->desc_pool, desc_rx);
>> +
>> +	cppi5_hdesc_init(desc_rx, CPPI5_INFO0_HDESC_EPIB_PRESENT,
>> +			 PRUETH_NAV_PS_DATA_SIZE);
>> +	k3_udma_glue_rx_dma_to_cppi5_addr(rx_chn->rx_chn, &buf_dma);
>> +	buf_len = xsk_pool_get_rx_frame_size(rx_chn->xsk_pool);
>> +	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
>> +	swdata = cppi5_hdesc_get_swdata(desc_rx);
>> +	swdata->type = PRUETH_SWDATA_XSK;
>> +	swdata->data.xdp = xdp;
>> +
>> +	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
>> +					desc_rx, desc_dma);
>> +
>> +	return 0;
> 
> nit: The line above is dead code.
> 

Yes, this is a silly miss. Thanks for pointing this out. Will fix it for 
v6. Thanks.

>> +}
> 
> ...


