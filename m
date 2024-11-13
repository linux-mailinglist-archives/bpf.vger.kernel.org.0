Return-Path: <bpf+bounces-44796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83B49C7B65
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 19:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E3FB263AA
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F38202652;
	Wed, 13 Nov 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SM6UlOUz"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC25D1FAC4F;
	Wed, 13 Nov 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521417; cv=fail; b=c+Q0KeVPQ6S++wGeYTmoITG/zMPxiafgpdTv5KEJMta8Gyq44d0EcAczVr0lIF6IvbCIDooDl9F6o+ffDl1rg/rUPNusBv5syDgloJW+uqtcue8cSFj16cqpyBu3qVbkfo7x+2vszR1An96+ZE2FIabsqHqF/uZR6p85mDDwwHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521417; c=relaxed/simple;
	bh=2r7WKMk6vGbTEizywnMEOpWGV0fhiu5+dlgVDv5+LGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W2iU5G4Peer4Jfqmc92edCW+gQOLoML8XLlQ5IQ8+7hy9RIR/0+gW3F/9KzLucTDZ4Jok+txbxIfRBw6A8epA328JMzXlIoiccauHUrJwPXtK1qm5F4uJ/oBTChhxpY4tXoiavKSFh/CjjyCp3WsKEsps2jxP3HZwk5295V9zL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SM6UlOUz; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sICDMF8ltCpgyCavLPCWMViU04Pg3tiWtZccUG/oJw88HyXvKG5NixjHTqi1P0+6b3tveqcMvwvlB7gIV9uPu0RW5JL/8XBTYkrcirxqStpBYy4O6fOY7Z8AaXBgI3kbymr+5M7CFsyfHMMsjGyzTyru6HC9Xjng5oIBxT5JcZx0YzZKUgWDaTLfg8N3LhQimqTkUMgRAHXglRRYr397wqqe3yjszdyTzYodBVIFJQBhBCOjbAgHYIE6wBUTPVPOwHGXKF14dI9gYjRxMaVcWZTw2wzUpS1wEmbCpEqUQLcRgNf5wJtKvrYWMWGvBmonsJqGlHkorAd7rebDmGcwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eFqxGhBIoymFPi4CO2LDUVTosP4+QRLTpqBT/fGjkk=;
 b=Un8jcEb5CHKpR0Qgw+7czjHREZ8wvtZk4ej/7YXUSe3fs8RYG0DI3lcar1LHk55/sTojIfRSxjsp2lLi/CsG2qwMg3oxUQCIMrEqdjnrqxS/t6Iij2QKTeQLVpAE4M26/OWRyD0WiStBR00uwNN9ieD1balrnK96NNN/H+QfDBsCZPomu9UWzdhPPiG/mZsobeKEH9TZL1K6x88B13GkzL7Nl2dtPdYrsUuG6TvnLqU+FUOMzN86ee+pwzkNDmPlz42FMy72gzKR/ZWGbJmmc/1+pFS4QDOqVvaQQ9F5S8dMjMpMupj8LiAZeiiBiNMUMjKLrGiJ35yrueWWHBwweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eFqxGhBIoymFPi4CO2LDUVTosP4+QRLTpqBT/fGjkk=;
 b=SM6UlOUzTvSd8fhct/XEjuh9WFlZXT7z6yr3WEGvlvJORM9W0tE8zRYezvHNLprC7dJA7JjiXREOQlJVNMk9BIrYEMUeLV9GzeWbYheOTzHV05e56CY8P1ovWkFPtPr2tkdEfdyYz3+z1BtJ3CUxa4yavp6r5NOFA/JMmzvoB8zctKMt7QcQpoBVFc04eX+BlzS0U8CGyV8nO4D0XRazyqGcJi9SKOxooSLjw/0nENB6A/cleFoz24Z38DrmKUBQ4HbqZrNTX+GEgM3ZcPKJ9QK5pTMnOPOcoDdrFOeC+rW8dA/mQcrSYTtoWy/HKzTHGqIeKqb5GkTip8QP73enoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 18:10:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 18:10:07 +0000
Date: Wed, 13 Nov 2024 13:09:57 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v5 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <ZzTrdUX0NUsHQLvd@lizhi-Precision-Tower-5810>
References: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
 <20241104-imx95_lut-v5-2-feb972f3f13b@nxp.com>
 <20241113174841.olnyu5l6rbmr3tqh@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113174841.olnyu5l6rbmr3tqh@thinkpad>
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 3057cfce-b694-475b-7763-08dd040e67cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djFrT1dHMWRnNVQrbDhpS2NoTW9HTGwrWFEwMUFaMExENzBmM2hiQXBxM0pS?=
 =?utf-8?B?ZFhlSGh4dTJUYW5ZMEVRZ2NkWjVxN3JvUDFUQUs1NXpubHRmVjhNVzFpQzZE?=
 =?utf-8?B?RlNiZHlIdGJZYnFHNk5wZGRObDNITnNGRjFCeitzZFhGb2RhUjcwQUx6Z2J6?=
 =?utf-8?B?WTdWSE1BcDNiSlFCZE9nWlJ5YU01TjUzRHdRU3lGRGJQN2VsejNwd2RzZGZ5?=
 =?utf-8?B?dFRvOUNkTWhpYkRSdlR4OHQrbzlHNVhYUkJXdHh6VTR0MHp2QlhPOWN6M0Uy?=
 =?utf-8?B?MTlsNUdyZjBOSWl6aEpGdTNNMnllNlk3b0J4YzMzNW8va1drS1VQU3lpMk1U?=
 =?utf-8?B?aWcrTHRGalhBdGxxelJ6ZFZIVzBhS3pWelg4eGcwVUFBSFZ5MDdPRTZTUFJn?=
 =?utf-8?B?bDJ4aERsakJrNkVOaTVrUWYxLy9TYWo0WGRSbm42amZSNmtDT2hwQ3JKaUY5?=
 =?utf-8?B?WTRVKzRBSjlDRHhadjRtY3lSZzNOam1CNnRBUVdLVGg5VmxOTHB1U2lFODhv?=
 =?utf-8?B?aVJrUU9tc3I2T25lY2JyQ0hhUURBK2w1S1NtY0w4K21zRllrM2N2aEZHWDhz?=
 =?utf-8?B?aUtPZnA4R0lKdk1XdEl5MnIwcS9nd0h2UlhIK1BWMDQ1T0VJS3RoY3JCRFl1?=
 =?utf-8?B?NFZJYzdGMVFVVzRQTXk4OVpIazZ6akFGYlRxeWVsSm1YYUM5d2p0NGhXY055?=
 =?utf-8?B?bWhjYUtzY3QwQzc1RlVzUUVkWUpNNU9BcmhCTklwMDM0OTd6QzlpYm44bHhW?=
 =?utf-8?B?c040QzA5VlZQOEF1YUZwU0tnZXBvWjNna0dNU0pPbXNEdjJ5WlFRSTJvZkJF?=
 =?utf-8?B?VEVFTU9SVlB5S012WFlHY0tGTzhKSjBORmYvZXcza2VXR3pCb2wyR1g0ZlQv?=
 =?utf-8?B?Z29LK0t4WFNiaGdzWWtqUXhLejFvNitudXlWV0ZoTkYwOGFacVorcHJoaURG?=
 =?utf-8?B?Vm9kUnUvblhtMGdxV3NhMzFFQ0hNc3h3UnhOMkRoZWVQQTFzVDJHbUdpa2NC?=
 =?utf-8?B?ZTQwQ3kyVDAyMmwzZzJsMzFUTmNSckxFTVpsK1MyL1cvdFBQOUk1d21oTUI3?=
 =?utf-8?B?VlpLK1VsbTVlZVVXWExobmVUZzd2SUxMUDlac1ljL3hJOWVNbDdnQloybGJG?=
 =?utf-8?B?ZWxLQU9XeTdSUlJxK2Jwdk1sZXEyNnVSV1AwRHphWFljaGdNTjZhWDlyQUxN?=
 =?utf-8?B?eUR3aE1wazE4S2prMW1yYm1WWDhZL0dESTdXUXZyVG4wdTRPRGZ1a1owVGRu?=
 =?utf-8?B?QkVqbW9OdTRwVEZsU3JZMmdZRTE5TXVveWlMTFJaUzNIb3l3THFSQk53YkJl?=
 =?utf-8?B?NGVTT014clFVUUkycW5wQjNvemxRS0pXMGZWVDdsczhKcUxrZW5VdWdSb3Qy?=
 =?utf-8?B?b0laVFU1c0pKcEJzb3cvVzJKZU1hcldGb1ViaHRjMy8vRjVUUjRSUlF2a1Az?=
 =?utf-8?B?MEFkRzR4OWI2RkFDODBYejNFdjZZSEhMdThoc3JjbG80Nit3L29LOU5vZUVI?=
 =?utf-8?B?V2xNbytOWEc0dDk4TGQxTUhXeU1lUnFqTHBWVzZuTGxsVGlBMW02N0VKWFU3?=
 =?utf-8?B?MldiYWVkcGhldklMeWxKTXZlTWlodkc1TkVycmVUQVJ2ZjZuQW5BWlM5N2dr?=
 =?utf-8?B?Ylk5cFJuNDdvUlVuaEhtS2g4Vk9uS1U5VkRMMmtDdG5QSGRWZ2Y3dkpYRkI0?=
 =?utf-8?B?MmNlaktROGxZT0l5QUViM2dNMEVwak80Z0FkK0FrWGZNb3RzcjZNUHhuVHZ3?=
 =?utf-8?B?SXFGcS8ybzFxRDdONk1aOGFEMDVtVDIrWjJFdi9JRklueXBZZHovdTJlbjdw?=
 =?utf-8?Q?cINnOA+s19+wHsDJcVfnVIIWWcoDtcHlU1l3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXJKbGoyYm9hZ3R2RVNDMWh4RmFoQk1UL2FlNjRLRVRtWlI0cC9hd2wyMSt4?=
 =?utf-8?B?TFRmOXp2d244aXlRVVFjeGg1S01ad3V5OWVzMXZ3bXBWY1IxaXN1Q2cydVhQ?=
 =?utf-8?B?aVVmdVVxVktrdklhdHFtWHFHYzRnY0ExVGhoMmhORGlFSWp0ekhQL2lDL2pq?=
 =?utf-8?B?bmtYU3NDTzZJa3llU0hGQmRPbjZSV2hRdDRXZEhsd1Eyb1Y3MTllM3RqOWJa?=
 =?utf-8?B?Zy9YNHdoSTF6RWQyR0RjN0Mvcmw5cm8zNzJ5VHJMYnFTSXdoMWRyS3VEdmRo?=
 =?utf-8?B?RHFucEJXbGtXdG1TS0xtR0I0Z2RPcThhTUZkQmZ0YjByUHVaWUwzeUx1K0RJ?=
 =?utf-8?B?SitCaDl6bmZXQU91MkUyUW1Nd1UwR3NYdS96UWxLVlZValhPUHFhS2xuRGFk?=
 =?utf-8?B?SUt4NytIV1AzdUpZNWVmV01GQW5TTkQ3d240Ri84WmNGTjhzMFBoUVBOeXdw?=
 =?utf-8?B?bUlaVGhrOVdPb2pQaDVNRERpaVp2RXdpMnpwK1pWU0MweitFdG9NeDVxTmRM?=
 =?utf-8?B?M2MycXc0akg3Z3Z3YzV6NUpRTFV5dVRlRjVPTEV3K1BQS01SS0NVaVpOR0xx?=
 =?utf-8?B?Q004cVRXN1ZINEZJMTE2OEErSFZDc1V0eUNmeVRrUERsZ0Y4OVJTSFQ2bVFU?=
 =?utf-8?B?Nnk2b1VwSEVqWDc1SFd3VVoycDlacGRyb2FGLzFCQUl4UEcxbTBnNFJDUkZ6?=
 =?utf-8?B?d1RjaXdXK1JJd05nZW9PNWcwMWRzc1k5L3VXaFNPVkNTdFFWeXVEb2ZJZXEr?=
 =?utf-8?B?eEV4cFhXYkNrRlBmNmhWYitJK2xSUWx2clZyVE43emhIdmNnblpBVUE2ek1P?=
 =?utf-8?B?UDU1TjdMMUpia1MrVmYyS0Q2OUdyb1hMYldHc3FiWjk4MGd1NGcxNnoyd01u?=
 =?utf-8?B?S09UVmE4Rk5icEM1K1M4R0YrTkRJUFhyc1FQY0dCZTQ4MkVtUGpiWFNTYnJr?=
 =?utf-8?B?SUx2bDgxZ29aOUs0dWZUV0JJaUdUdWNEVFoyMDhYT0x2bWpaT3VyY1ZKbUtw?=
 =?utf-8?B?bHI3QVk3amRuYWRHVFZSRThBa2ZIb2Z0MGtYaDczSjZpaWQyZTJkdkc0N0lw?=
 =?utf-8?B?MWh0OTBZenp0QTZwSUJsTUI5UTRneGFYbGlKWjh4ZXk0SndlNnNYanU4ZlNE?=
 =?utf-8?B?UENsL2tQbmFxSkZNR05TQzl5bUxzU1B5aCtRUHRLd2N2bzA4Vys1Rkx2K3ZD?=
 =?utf-8?B?MXhyeTYzWFIyMFREM28zdXR1aExWMTNWYzQzNTdzMVQ4dTNtTUR1NndKWmhN?=
 =?utf-8?B?Tzd2VE1uY1JaUXA4WU9zOGcwVjFyOHdoQjlvaUdST2pqSGJiOC9YSEVzNmd3?=
 =?utf-8?B?eWVHWm9lNlRDanZFSUw0eVIxK2NqL01TT1NkN2QxSE9qTVVBZ2poKzJuNUx4?=
 =?utf-8?B?ZlhpZHRRWkJpaGI4V1VnQVZSbkphSHY5NU1tQ3RickVjK3MxcVpudSs2NnVt?=
 =?utf-8?B?TnVMSi9kNTJWZUZyNkhZUEhlQVpHd1NUbWl0YXFjZlJJOEV5cXMxZWlQRVJX?=
 =?utf-8?B?b3JXamkrNGIzYUNZendtN1ZpbUpXbkFwSiszMzhnYjlWSlorRXA1R29pczl2?=
 =?utf-8?B?bmdvMUJhazNKS3NJVms0LzRFS3RKTkpDNTgwNHFWSitHdE5tcnNkbkg3eWZM?=
 =?utf-8?B?dzZ5bWtQNm5kSkpSSDZMemZCNnl1bUZ1TUtrK1dIMlFoT0JQZnBSZWdvY3BD?=
 =?utf-8?B?THc0bG1wMW9MalJ2eHJWUDFWdnZEVE5WQ0p1aThSdWU3WVhWbXdDVTREYk1D?=
 =?utf-8?B?a1lrU1VxOFdWYTFWS1dmMys3N0tzWDV4RnNXRHovZGI4Njg1QXJ2ZUtJL3d4?=
 =?utf-8?B?WlN3T0ZMc3FETDY2TTBkcEJYZjRJYnlaeklVVFI5eXYzSFlWUU5EYXB4d3Nt?=
 =?utf-8?B?OVAxYUFjckZMK0tnTmNTbHhFWmJCVlNvVElpbnY2TjMrdDRJT3k3U05qUENT?=
 =?utf-8?B?bHdGK3Q5M1JmdXd4Wlp3R1JIU3FVZXZuMHhDM0I0VkxHbXRic1NiTzZ5ejdw?=
 =?utf-8?B?M1hzVE1DZzBrQWdrRHlabWFRSnJZSFlxMU9pa242SzNlM0dOVXpjTkpqZVJa?=
 =?utf-8?B?QTJuZmFKUGVLd2VrS2cwTHJhcGMzS1lrdjI1KzlUb2RiSUlkQkppMjd6ZDhj?=
 =?utf-8?Q?qXHY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3057cfce-b694-475b-7763-08dd040e67cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:10:07.6665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1j/JqEF84OAwvum3KrJqNeYr6UEVvEGYm/PcCFBeUSHcsnyjoKx7VIZKhtlNA+uqfiOe7KO541l9JLNKT7MZaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

On Wed, Nov 13, 2024 at 11:18:41PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 04, 2024 at 02:23:00PM -0500, Frank Li wrote:
> > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > This involves examining the msi-map and smmu-map to ensure consistent
> > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > registers are configured. In the absence of an msi-map, the built-in MSI
> > controller is utilized as a fallback.
> >
> > Register a PCI bus callback function to handle enable_device() and
> > disable_device() operations, setting up the LUT whenever a new PCI device
> > is enabled.
> >
> > Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> Some minor comments below. It'd be good to get Robin's Ack for this patch.
>
> > ---
> > Change from v4 to v5
> > - rework commt message
> > - add comment for mutex
> > - s/reqid/rid/
> > - keep only one loop when enable lut
> > - add warning when try to add duplicate rid
> > - Replace hardcode 0xffff with IMX95_PE0_LUT_MASK
> > - Fix some error message
> >
> > Change from v3 to v4
> > - Check target value at of_map_id().
> > - of_node_put() for target.
> > - add case for msi-map exist, but rid entry is not exist.
> >
> > Change from v2 to v3
> > - Use the "target" argument of of_map_id()
> > - Check if rid already in lut table when enable device
> >
> > change from v1 to v2
> > - set callback to pci_host_bridge instead pci->ops.
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 176 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 175 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 94f3411352bf0..e75dc361e284e 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -55,6 +55,22 @@
> >  #define IMX95_PE0_GEN_CTRL_3			0x1058
> >  #define IMX95_PCIE_LTSSM_EN			BIT(0)
> >
> > +#define IMX95_PE0_LUT_ACSCTRL			0x1008
> > +#define IMX95_PEO_LUT_RWA			BIT(16)
> > +#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
> > +
> > +#define IMX95_PE0_LUT_DATA1			0x100c
> > +#define IMX95_PE0_LUT_VLD			BIT(31)
> > +#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
> > +#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
> > +
> > +#define IMX95_PE0_LUT_DATA2			0x1010
> > +#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
> > +#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
> > +
> > +#define IMX95_SID_MASK				GENMASK(5, 0)
> > +#define IMX95_MAX_LUT				32
> > +
> >  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
> >
> >  enum imx_pcie_variants {
> > @@ -82,6 +98,7 @@ enum imx_pcie_variants {
> >  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> >  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
> >  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> > +#define IMX_PCIE_FLAG_HAS_LUT			BIT(8)
> >
> >  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
> >
> > @@ -134,6 +151,9 @@ struct imx_pcie {
> >  	struct device		*pd_pcie_phy;
> >  	struct phy		*phy;
> >  	const struct imx_pcie_drvdata *drvdata;
> > +
> > +	/* Ensure that only one device's LUT is configured at any given time */
> > +	struct mutex		lock;
> >  };
> >
> >  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > @@ -925,6 +945,152 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
> >  	imx_pcie_ltssm_disable(dev);
> >  }
> >
> > +static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
> > +{
> > +	struct dw_pcie *pci = imx_pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	u32 data1, data2;
> > +	int free = -1;
> > +	int i;
> > +
> > +	if (sid >= 64) {
> > +		dev_err(dev, "Invalid SID for index %d\n", sid);
> > +		return -EINVAL;
> > +	}
> > +
> > +	guard(mutex)(&imx_pcie->lock);
> > +
> > +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> > +
> > +		if (!(data1 & IMX95_PE0_LUT_VLD)) {
> > +			if (free < 0)
> > +				free = i;
>
> So you don't increment 'free' once it becomes >=0? Why can't you use the loop
> iterator 'i' itself instead of 'free'?

It is used to find first free slot. This loop check if there are duplicated
entry. If no duplicated rid entry, then use first free slot.

Frank

>
> > +			continue;
> > +		}
> > +
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> > +
> > +		/* Needn't add duplicated Request ID */
>
> "Do not add duplicate RID"
>
> > +		if (rid == FIELD_GET(IMX95_PE0_LUT_REQID, data2)) {
> > +			dev_warn(dev, "Try to enable rid(%d) twice without disable it\n", rid);
>
> "Existing LUT entry available for RID (%d)\n"
>
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	if (free < 0) {
> > +		dev_err(dev, "LUT entry is not available\n");
> > +		return -EINVAL;
>
> ENOSPC?
>
> > +	}
> > +
> > +	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
> > +	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
> > +	data1 |= IMX95_PE0_LUT_VLD;
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
> > +
> > +	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of rid */
>
> Please use 'RID' in comments everywhere.
>
> > +	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
> > +
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, free);
> > +
> > +	return 0;
> > +}
> > +
> > +static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
> > +{
> > +	u32 data2;
> > +	int i;
> > +
> > +	guard(mutex)(&imx_pcie->lock);
> > +
> > +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> > +
>
> Remove newline.
>
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> > +		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == rid) {
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> > +
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> > +static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> > +{
> > +	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> > +	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
>
> No need to initialize sid_{i/m}.
>
> > +	struct device_node *target;
> > +	struct device *dev;
> > +	int err_i, err_m;
> > +
> > +	dev = imx_pcie->pci->dev;
> > +
> > +	target = NULL;
> > +	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
> > +	if (target)
> > +		of_node_put(target);
> > +	else
> > +		err_i = -EINVAL;
> > +
> > +	target = NULL;
> > +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
> > +
> > +	/*
> > +	 * Return failure if msi-map exist and no entry for rid because dwc common
> > +	 * driver will skip setting up built-in MSI controller if msi-map existed.
> > +	 *
> > +	 *   err_m      target
> > +	 *	0	NULL		Return failure, function not work.
> > +	 *      !0      NULL		msi-map not exist, use built-in MSI.
> > +	 *	0	!NULL		Find one entry.
> > +	 *	!0	!NULL		Invalidate case.
> > +	 */
> > +	if (!err_m && !target)
> > +		return -EINVAL;
> > +	else if (target)
> > +		of_node_put(target); /* Find entry for rid in msi-map */
> > +
> > +	/*
> > +	 * msi-map        iommu-map
> > +	 *   Y                Y            ITS + SMMU, require the same sid
> > +	 *   Y                N            ITS
> > +	 *   N                Y            DWC MSI Ctrl + SMMU
> > +	 *   N                N            DWC MSI Ctrl
> > +	 */
> > +	if (!err_i && !err_m)
> > +		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
> > +			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +	/*
> > +	 * Both iommu-map and msi-map not exist, use dwc built-in MSI
> > +	 * controller, do nothing here.
> > +	 */
> > +	if (err_i && err_m)
> > +		return 0;
> > +
> > +	if (!err_i)
> > +		return imx_pcie_add_lut(imx_pcie, rid, sid_i);
> > +	else if (!err_m)
> > +		/* Hardware auto add 2 bit controller id ahead of stream ID */
>
> What is this comment for? I don't find it relevant here.

The comment for why need mask 2bits before config lut. for example, dts
set stream id is 0xC4, but lut only need 0x4.

Frank
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

