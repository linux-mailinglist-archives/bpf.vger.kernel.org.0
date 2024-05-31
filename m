Return-Path: <bpf+bounces-31044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E38D66C4
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 18:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7871C23E07
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2215AAB6;
	Fri, 31 May 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="do6oGYXX"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083A156242;
	Fri, 31 May 2024 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172772; cv=fail; b=RU2fFaeJSTfDKNAXOSWXSozjas1y38443nyeDSY55tF4tZ4j2RKC5dFmLdiCKOxeTZIgJbN8f6tCW4f13Fd/INGXXsv1nLiEjTBNY6KGlOcSmAP6E7B/BESfIkLFI78+XtcxXp/g1hT7flldk4nICvznwCKeJhMsuGKFSP/R1r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172772; c=relaxed/simple;
	bh=W6pnZHIdUaitOzgiIBkoBP5Pj3IKow9Wy+kEEfZgr40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dCB4F9cLTOGT2Uv8s7yWSXd0I23u4bZaFHzL6qspFAeV43csL7uY92HLK6Qb8i0Y+BHlqF/JnXrWviDsj2XJFCIvnTOyhFvarGob34YJazJ1fFATNKnPDTa40z48ETAMmnxfDdCW+n8B/S7bPTSwF8fEKgjAiDhF3pih4N8myEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=do6oGYXX; arc=fail smtp.client-ip=40.107.8.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeVdoL1Ec0XdXZu3fH2dLVqcJ4filmB5dPuEmbUUqjVjFPSW2Y9mfEapxbFg2BV+54tP31OxnYlqHJ7Yemzfr9M6BxonJzhoNP3U6Yghrzoa5pujFZTFABuo6nubs3vPGKn1JGdumqgXTtRfPYY+dfK6Lgq1+OKB4mBPaZuqC6QRGrno9bWwVItC+qbdbuOmoXlW/8r3bFW0E53OqtmcrkK2DUpmybqqGgOKtDz9EazHXus7eJ0nYXyHn/xW5APUaKJlKdcTs7G4JsJr1h99INLTokM4g9OzAVWlS/TvvsX9OLc5Oaj3vmtgLLm6II+wPpV0tvmLJxnZg/8wT6BL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHcy+hLWgLVc11++X8j4ERGnb4iMwmPftJzR8v1mXC0=;
 b=d9YWMTf0eVesPIMMN922e1YctnYLcSbU4+AbUX1lHFo33JiSe9W7Eukf69TMHVGq+hoGMOOpA0TSqGJzPb9+8YYdJPj1Je8wgFHcDCPQ3jJV593dbmta8oo7X680msmEEnmDnzvANVhsyAtEaH0DcAnnaFa6ZV4qYc6pmKDnL2SN7RaFcs5b0RXpegeHsBJS09zDWm43D21c6xlT2zWb1pEKD7AS38vwAP4pv0lt7TyZNM1sVmEyzYH0klQfw15I0vjQz2IYozEBWA78X8nXqwmrIbR1uF3NVE5MPCWpZmMpmrk6EqfULPdF7mTZMYUAO8mKBCrJLJh5ZJ7199zlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHcy+hLWgLVc11++X8j4ERGnb4iMwmPftJzR8v1mXC0=;
 b=do6oGYXXV4BjE8yxzmxLDNjxrvKKxP091ZTTjG+OTvVOfB+esZIUQp+vo1pcS/p/IAt7x/MsUrNc6d3jRyfZZwUqlQNsWU7hAztDl5CkjoN6+FAVJwenLDoh32wXzJ6Jjk0aey/kyqDor7kohlvz1BadShU6ULkidCsUupBm4zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7758.eurprd04.prod.outlook.com (2603:10a6:102:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Fri, 31 May
 2024 16:26:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 16:26:07 +0000
Date: Fri, 31 May 2024 12:25:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <Zln6E8/KK+uEDbCt@lizhi-Precision-Tower-5810>
References: <20240530230832.GA474962@bhelgaas>
 <974f1d23-aba8-432e-85b5-0e4b1c2005e7@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974f1d23-aba8-432e-85b5-0e4b1c2005e7@arm.com>
X-ClientProxiedBy: SJ0PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef587a8-c75c-4eba-e89f-08dc818e5fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4k01RHBH3cT00b6WgCHi5YtlvAbtptZmWIPrFw7PFAoLvyTrln3hwwcgWKP?=
 =?us-ascii?Q?ePV/7glp+rE3eVuW8N4+g1zIpss3W1vD9DZerewnfF8S9xQ9P2wkuqJCe/Nr?=
 =?us-ascii?Q?7RSbfNH/oBkX/zZ2VbpoFW8VjrhIwrxZ70TqnPnwvEqjXTHTKjpKIq9f7VBP?=
 =?us-ascii?Q?UOZyWHxf9wb1tZmVYp0O13sWB8QtDnSsqZvypO4j8cVUQWpemejmvs+PT4zy?=
 =?us-ascii?Q?Tl/HFxlKVIbfPH5WaElIQH9zIpgEweeDBiixQbF2I3KV2vT5noIxnNJAgneg?=
 =?us-ascii?Q?28r1VLdoXQMac971xrUZbhTxMcBmJGArb6P53eKUhO2EZCAuEY4RQ/prIlnh?=
 =?us-ascii?Q?3Md/1+kFGE0rnSwaEIbxVyNu+6CARqwA4e4qVU8jtB7T1qSPii7Bia00JGCH?=
 =?us-ascii?Q?i58qkIduwmGByQnAn3apjkv8xkV7QxGhBsX3/nX+tmp2fV98PVZBc2m5QdcI?=
 =?us-ascii?Q?mF5DBnfprrdD75WirlmCzTe/QcuRqr+qr/5jUhB8RzAquwkdGsppOGdrcjl8?=
 =?us-ascii?Q?dSir5hsS0N2y+G1dOuIeLkAtskP1GYA5pUAXFeVR186QPrAWpuDtzX79fCSm?=
 =?us-ascii?Q?Rq8tlFmhu/QwAScCUUKDa2ccrsDorLyegK5uaEEQ66d3VF9PuDKrs9mohyzt?=
 =?us-ascii?Q?slcJp744uUsLvv1UjdAgNrIzJ2mr/wfKg8qPxPhkUrAcZ+5zgM/nCxLP7M4R?=
 =?us-ascii?Q?TczpXWySFBO9S+vB3jclPUv15fSchN5yu28w7e1lGoPvcWLBymaRqurDgeAj?=
 =?us-ascii?Q?bTJKHYWHEqQhj4+fUzgfHm5plpEGEGB+ZHS48tMN/RxVMYVGPpZSWrQFP5Pw?=
 =?us-ascii?Q?VoK+U0iKW/4hb6/gWtTji3NLmR7PK1RfoT0OpJ8ne9oTt7R5rSVjo0Z7C+gD?=
 =?us-ascii?Q?r/BhtAztyrZEAiPaPaYwgeNTZL+XD0Rhlt3U2Rg1j/uBdTF86YPoJSLMaFNS?=
 =?us-ascii?Q?9eoe1Nda8fwvJYgrWnFqNqyT/2W6oA1XJk52iztojk2T0avgf5VwhLWZLlNb?=
 =?us-ascii?Q?OmO9YrwddMkVJECWqK+6iIzfMnYVDrAJ9dMefDKE9wE1c9czx0Qi5WsSKUBh?=
 =?us-ascii?Q?Cu67B9M1H/ekNG+tm7AKyO1L7EoJYv4R+7uvu5czcXhrrpe5oqDIQE34umAU?=
 =?us-ascii?Q?NmeBkctXKUElcL3DNR0z2Wm3zZ2NGNFPB0/IsUK9lCLIc1lMq4WJ7FRe78N8?=
 =?us-ascii?Q?H/diVemEWyToBu8OCpWnthx6yhB3CnJHK5TCq0InBecBT8xKSqFXahJBX9y4?=
 =?us-ascii?Q?C0EoPllS3y48vEFJYO3UxknGQxaqcBVA2XGR6iZTWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KtWUY1RUaRROTRynSGH4C79FWHpWoMXZmX6lFb8Gchm9i0VEpJwB9VDzn2JO?=
 =?us-ascii?Q?Ol/xlH7J81WVTdmVRtCJ4+WK23xM9++WBc+0Q6TOf5sYWdvUMBlhVTWcmea7?=
 =?us-ascii?Q?3QravO+E42/TvrO9JA/1sPLMuw9kDBbDWkizMb50iNd+Yd+cI8S4bonLDInp?=
 =?us-ascii?Q?zcEaLdDviswFcnk1gRMjvmi5d33tsFakrYo3atNPWRMG/KCe+ye1oiyA0es1?=
 =?us-ascii?Q?YGOHGwGVtweTkTgzIB/qjNk2WjqXaWyartHiUClLmcPzJbV/ofPRyeMLbc8k?=
 =?us-ascii?Q?al2MVoMvaF4Gh9PLMSKdUuuP0RDFA4saSiCpvdkz1gYp/56E2EkpvDejnJZb?=
 =?us-ascii?Q?Si2WGTaTdRXJLzxhs8YpycgfXxDnhcMOUfLQZDl+AQsBj9Qy6n4BxjtBAWyn?=
 =?us-ascii?Q?NCjReyR+yGZ+77V47NfwfRoTv66c2lHEDVlk3UISnrLMtYw5tGZKD2tZjueZ?=
 =?us-ascii?Q?5FZ4yOVvSJiy/OjPG+L1CFPY6riQwXpWEy4bH2jtyOPCL3lpqdx9KOlP23Sd?=
 =?us-ascii?Q?2vKRLsrQBd2mft7gvUx5No9AaLx+iTq/lIqPOdoDAPkGu4GLt0Og8spIQoTu?=
 =?us-ascii?Q?NdmsJa3/VzQe/W/pjDBHJvAYock7tNvc/4CaZ9dIWztiRo00Zf86CvuUZB3z?=
 =?us-ascii?Q?D02aiBjUF5NC8NPnCKgdROYNT6tiea6rKd3ftgHDm75K1lLd/KKMdEWhG6LV?=
 =?us-ascii?Q?iFl2UWqTJ+O61U5ClgrZ6G1DrCW8p3/5zQd7WZb8rvJ32NVJsZklRIWSknq7?=
 =?us-ascii?Q?GnDF2utaNfJkPhw/g1xzhx5d5gqka0DrWhI1x8Ad/nV6/usStPtKLxkAF1vK?=
 =?us-ascii?Q?z9mEFjFQC2d/ZMLuowQ0IaPCPTjUQR30LIQBM2F+MIq0jiBb6kCIYo7aSQ89?=
 =?us-ascii?Q?2W4ENzCfYbkoulFuN7/M7mkrp4FmjzmQws3dlfJ4MPoMSBpJF6SPqb+/fQQ7?=
 =?us-ascii?Q?DePqUdKJpEs4kl3xeq0yoim1zjTPa6T774TkE90o/IZ2cpXfrMFFdPbYYWCT?=
 =?us-ascii?Q?kVF2Ahux7Rm+lP/LE5RbTDN8WjgtTIQ2xXQepLYi96XHHGjRhBsUmmVdARyx?=
 =?us-ascii?Q?ylRSTz9bxefY6KAsUyBd5S9LHj+TS4KHhDGhOozWrdpy0OOyRlxmfa+B8Nhz?=
 =?us-ascii?Q?G/NuRTBUoUzJA5+ED2pOZ+ye6QUiT0EfPO6ys4l9uR/oUWsJdqiaQdmaJswH?=
 =?us-ascii?Q?OUjMWdPYfjIQizvwQuXDc392xDu6hMlPd37HnCdeFInaXNDx43CAx693p578?=
 =?us-ascii?Q?g2BlbrbhQ6JOE/MC6LpXrRi7FNew0LY7fif8IQXVeZ6JuhXTjwvDh0XJvy5F?=
 =?us-ascii?Q?QUazUXTpFFdzpIFZ1ay1SxYzeFSQn6k+r/TLTC0gjcSlN4DTY4jyGZvNg8wU?=
 =?us-ascii?Q?1DrtrqyVZ/NORqc8kOe3kIXHdcgAqNSJy9Bl2uElMFt/g8NmOhvjm3Lb5MCT?=
 =?us-ascii?Q?dgLyZqpySlIrgdSdn1fr8exBjm9G0XXY8j7pXutJyaS92hWxF58v20YAKWsM?=
 =?us-ascii?Q?eMwTFKyhS1Q3ECAfpzi1tfaCkoDSTlosNBDhJcgmbmoYxN4WKzpDr9kQrCaF?=
 =?us-ascii?Q?7xsDHFJQ7qmiiRy1KhVztjM7ukW1MAYnAWRFcFNv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef587a8-c75c-4eba-e89f-08dc818e5fa5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:26:07.1067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EE2NqPzUSZNy9qEsn6fwMm6XRRZ/QmsSEv/EB2SlCaitwpkFZn0tVs0txyargKzZYuBT8ZTuLmUuDVnIT0NVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7758

On Fri, May 31, 2024 at 03:58:49PM +0100, Robin Murphy wrote:
> On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> > [+cc IOMMU and pcie-apple.c folks for comment]
> > 
> > On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > This involves examining the msi-map and smmu-map to ensure consistent
> > > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > > registers are configured. In the absence of an msi-map, the built-in MSI
> > > controller is utilized as a fallback.
> > > 
> > > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > > controller. This function configures the correct LUT based on Device Tree
> > > Settings (DTS).
> > 
> > This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> > have to do this, I wish it were *more* similar, i.e., copy the
> > function names, bitmap tracking, code structure, etc.
> > 
> > I don't really know how stream IDs work, but I assume they are used on
> > most or all arm64 platforms, so I'm a little surprised that of all the
> > PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> > this notifier.
> 
> This is one of those things that's mostly at the mercy of the PCIe root
> complex implementation. Typically the SMMU StreamID and/or GIC ITS DeviceID
> is derived directly from the PCI RID, sometimes with additional high-order
> bits hard-wired to disambiguate PCI segments. I believe this RID-translation
> LUT is a particular feature of the the Synopsys IP - I know there's also one
> on the NXP Layerscape platforms, but on those it's programmed by the
> bootloader, which also generates the appropriate "msi-map" and "iommu-map"
> properties to match. Ideally that's what i.MX should do as well, but hey.

Actually, I think it is not good for uboot config it because PCIe device is
hotplug, such as SD7.0.  SD7.0 card may plug after system boot. uboot miss
config it because uboot scan nothing when it run.

> 
> > There's this path, which is pretty generic and does at least the
> > of_map_id() part of what you're doing in imx_pcie_add_device():
> > 
> >      __driver_probe_device
> >        really_probe
> >          pci_dma_configure                       # pci_bus_type.dma_configure
> >            of_dma_configure
> >              of_dma_configure_id
> >                of_iommu_configure
> >                  of_pci_iommu_init
> >                    of_iommu_configure_dev_id
> >                      of_map_id
> >                      of_iommu_xlate
> >                        ops = iommu_ops_from_fwnode
> >                        iommu_fwspec_init
> >                        ops->of_xlate(dev, iommu_spec)
> > 
> > Maybe this needs to be extended somehow with a hook to do the
> > device-specific work like updating the LUT?  Just speculating here,
> > the IOMMU folks will know how this is expected to work.
> 
> Note that that particular code path has fundamental issues and much of it
> needs to go away (I'm working on it, but it's a rich ~8-year-old pile of
> technical debt...). IOMMU configuration needs to be happening at
> device_add() time via the IOMMU layer's own bus notifier.
> 
> If it's really necessary to do this programming from Linux, then there's
> still no point in it being dynamic - the mappings cannot ever change, since
> the rest of the kernel believes that what the DT said at boot time was
> already a property of the hardware. It would be a lot more logical, and
> likely simpler, for the driver to just read the relevant map property and
> program the entire LUT to match, all in one go at controller probe time.
> Rather like what's already commonly done with the parsing of "dma-ranges" to
> program address-translation LUTs for inbound windows.

Do you means prefer v3's method?
https://lore.kernel.org/imx/20240402-pci2_upstream-v3-8-803414bdb430@nxp.com/

> 
> Plus that would also give a chance of safely dealing with bad DTs specifying
> invalid ID mappings (by refusing to probe at all). As it is, returning an
> error from a child's BUS_NOTIFY_ADD_DEVICE does nothing except prevent any
> further notifiers from running at that point - the device will still be
> added, allowed to bind a driver, and able to start sending DMA/MSI traffic
> without the controller being correctly programmed, which at best won't work
> and at worst may break the whole system.
> 
> Thanks,
> Robin.

