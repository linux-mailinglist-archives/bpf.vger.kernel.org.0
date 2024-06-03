Return-Path: <bpf+bounces-31254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA28D8AB7
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 22:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782131F264B8
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 20:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D7213B58C;
	Mon,  3 Jun 2024 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="avqNIsU6"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E55B46A4;
	Mon,  3 Jun 2024 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445291; cv=fail; b=IzAco2qyU0mP/GjejNTOpOsPlKy5GFdELRWWVuai9fW/Nrygp/lz8KQ4tnrvZ+Cs/HR8WqTX7ozIOsgRdOlHj/Kv/WviUV83YjaRv7ZC42U5evnKqDOzrR9GQSVQcByV96542ECSEzQNdkpcIfp6wAWQzpWbQbm8ysa7B3p6jYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445291; c=relaxed/simple;
	bh=FILfFTy57PkpNgIqPT1/62+ls3SfV5E21ZlnfaTtWNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MYg5Ub5ubHN5DX+20i88RlDp7pXjC4tP4SdWHffxFCuuj1ycVM5Ar/m1w6mtc1U3IC63n5BIkhTGRX/52LfvdvXwDB4Iw4JkgUiYHQCrjYE+E67LfpXY1R4qGC8/fa/qbwgFH5dFViDKMCSbhrBLucfUaF0N7LwDI+N669YF8H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=avqNIsU6; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIKV8aV+t3uB1R0z3yjpBuL+kzwww7gQh1B3SGh6lDf6ObXivhZfyIjddFeGmwQUytLV7f6Q8313fPXDX5f9jWQK2WUO5tiWNh891JKHz0nU+C1MPordSZ+IcnmXSDiCuJcru4YMimjY160cLV1Mp7H0uiCnzZfwywxtut8BgGmsC2GOlUJh3tmEaDICIFxU+1j5gONKpWt2VQBIhUOjMWDLn04HlWK97/9mNrIuvgBxATAMvF0lbUNczKdjYhaYDaHXt2uUTcfoPZnRHUQn95xrDrEw4WuAjTv2sXtmB7QrdmaDMIFytSCrjqPiQqTJ244qxRwnuuktFGHinkVKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oso9jpW2O91tJb6+1dlrFlUBVDbER7h6xnfBxcsg4F8=;
 b=O2X3ru/HQD1GRc2riReINkWGqH03vgwHG9Jm5Czly3QSP35kvtBDNbGNHPId7hDZAU6547J21H6jM6W/N6ZhpKJP6b6w3ZptmkCRu6OexnXbxtv+HHNNfkV3KFMEULgn27Gms3tzBdqKn8bGtcqMJGlDuBu+2Y8lw/Ivq+qcSX8qrQl6477eIZ7PJnp6BAIbbtlt8E9uNyObwUZ8VVrSgzk+HL22epIQ86FXrqlfVgtQp0HMoW7rWhiXqdjuPqUBWrfdHi3UhZ6Vie+UHS96gJ3SNXnX5tBJOO5CopA9S4tpZnA3YDyeD3/RMy4X2SSqfEcC/OHMzUfcnOkqq4lEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oso9jpW2O91tJb6+1dlrFlUBVDbER7h6xnfBxcsg4F8=;
 b=avqNIsU6Y2GbD5et+sm2uZ8pv3AGnJu6X8YbW3WlcaL8T7czLlWlDQ61Bb2jDs4CccORFinZ6UFUOkLwZVPW/OwUCFCz2Gu/qyH3r0bCroOiVl/W1nudYWlfGFsx3hrFYlsWHFPvBEIxV/iEN5L/SimizgThm2unMyDk+EgJXH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Mon, 3 Jun
 2024 20:08:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 20:08:06 +0000
Date: Mon, 3 Jun 2024 16:07:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Richard Zhu <hongxing.zhu@nxp.com>,
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
Message-ID: <Zl4im579O3qjIzZ3@lizhi-Precision-Tower-5810>
References: <Zl4OpTfcfqMHELiX@lizhi-Precision-Tower-5810>
 <20240603185627.GA687746@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603185627.GA687746@bhelgaas>
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: f42ba446-b2be-4360-302a-08dc8408e1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TpXOItUVj1mbPrVpZjMm6OcGrHN2VYjxTNGSuW6hY5J2CtT4n2DTQ4jhiT0y?=
 =?us-ascii?Q?b9vSyx5xA5wyS2chBwnwZBrfLyv2s32gmKoCko6cxhkFQKcCZEzIn7TzZr+p?=
 =?us-ascii?Q?8BjX5FqCkwdOZhINQrI8FlIFUXdQiplgFyCyhIV7HXc/L1AfSuJU/INRvAsx?=
 =?us-ascii?Q?gdahXGZYWKMlQXUQmv/M3+FIOrEId7tr0/llM+bMQ6+JCuylHaa+oDyETOE7?=
 =?us-ascii?Q?dJm4vWchfl8Kz6mJ9EXt75Af04zGsQEOaOn3RFHtswF03sY/ebHccrOJ7tpR?=
 =?us-ascii?Q?q94EG7W4062zFtRf2b49pRfyTpgwdrUz7LWp9AH58wA1u8Tis+TVeCVoOiXx?=
 =?us-ascii?Q?1J2moJx943+7iiT1/hwd1QxzQyR3trYPv50KRLDwZov+qSlAQWqx3IZgJS9v?=
 =?us-ascii?Q?nf2Du1kXCm0KtyUYGxwPOB8mukkSI0b+AplIxSRbAuxrnm8awBI4KPb6b/9a?=
 =?us-ascii?Q?Gy2iDoL572lWDjKwxcbT1bGeX12FPW5igTKbmvL4+t0AsMz1xwHiMgghg5eO?=
 =?us-ascii?Q?eXsNG6xPWf61e42PHWkLAZrbmNkRkuunanhgs5sugDnPThf947iCP9ieCL0d?=
 =?us-ascii?Q?wVfas+5WyHEYXchdaOXfbdRUT5t8VU7GCnAFIfVOoELdUGxe9aDM93HAS96D?=
 =?us-ascii?Q?fLYRKQdavUdgVk5yev1WDJ6hKcbOTBabQLoVnxhzsai39qkUwAS3WPdPuL6G?=
 =?us-ascii?Q?JLenf+IAP55eFMKxL9PFKHiaRhCp/z1NJ2PCPIOKvo5n1cM6760vfkIr9iSK?=
 =?us-ascii?Q?RsS1Wn3QH+1rWiBIt8NoGwaGccb55CvRiWwZT8XLMAD4CQHPV7SPeCHqPDRA?=
 =?us-ascii?Q?k2uG8XRZdjsytWaogo+j4JerjGknNBWIG8koRvHWhlXccuMvo82UYWLfLFPG?=
 =?us-ascii?Q?M5gaXH+Qryc2kNUtWVtO2VJwKJzGzxjAuTf2GB5ldvq5gSj8NFtDYxdtgPkk?=
 =?us-ascii?Q?e4EegwGroCQLPImaOXlwVV/QAN1dOfDU626kxu/BFL0XrDYC5Ip7MW8kkKqh?=
 =?us-ascii?Q?JnPjZGpm0GrIkatRaHCWrqQVS71tqf53CmXeHRvN23zWUfGNO3ckFS51LkK1?=
 =?us-ascii?Q?lZUGqxPXyuhd0YedxaCLl1+e5q62GmqimkMBix4o9XmO5hbe3RqLMxvyPIp1?=
 =?us-ascii?Q?cADvvuvFIS0MBSYFIPmVmZvN3IVR42TnLiK/JMk/iBptoWIomx9+KAOmIiBc?=
 =?us-ascii?Q?y0EUTIuO9wc10AVcGBJOI4zcPRLKHUtX0jhOm0Gy32fW7INL6+qcX2X2hMt4?=
 =?us-ascii?Q?9kExErbcX+JmgOBJK1AoehZwOQ7+WOzVur8XMCxW6F9DNwNcKzL7ewJna3Xl?=
 =?us-ascii?Q?g8J9eQXQRzJ1kouIA4/zm7lfGjGIAC4WKhyWWqqL4OT8Ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BrSGZjDBLK9EYWntQnzr8aJSUB4HYjP20G1GfkoI7w+OxVW65mj03X8v2ASh?=
 =?us-ascii?Q?uhHkfkPBcHWUJC7wWwRGnfLCspLdHOnxhPvn+RKj335XOknQNCDa3iAsuUBp?=
 =?us-ascii?Q?3fJjID7NPyg17HRHiRqC5YG4+O6d/Ls+iUph2HxXI5FLKAaH/FjNzEfM9NCQ?=
 =?us-ascii?Q?aHY3LZgS7pg26TcJYc9WUdJhPFeu/al5J/8+cXdMD6bVaiYVx0Dt0pNEGslp?=
 =?us-ascii?Q?4WI3QvMIVV8fbEVIscKNJhvvozMb7CsqWs+Cc+jb/IRGLiUkdq+lGe9oeonX?=
 =?us-ascii?Q?KYVPPc88crRp0kKpGnVV1Rn0LQtqxfautDn/py2AWgYOK9dJBpHV6qsZ/lcZ?=
 =?us-ascii?Q?I4cQR+AtvRsUpkV7wMQUZdDVcvsrtR7jzr80R1v9duQzQ4ymcsJOB/122lD+?=
 =?us-ascii?Q?kmx/7cawKm+IbdjqsQf2dnTE7Prvl/NhMPg8nb47jbGJ6agjuGj0EuVTlZgY?=
 =?us-ascii?Q?AQBsep5EFgJGnd8QQYESjkYvIEDQaSSLCAGToLGiJPnw2D0i0131n3Le4Aqh?=
 =?us-ascii?Q?ZudExOXRe5SaRTFG0mYJQoOu66hYP8rDuOs+ufsz5ybGufEejhbE6LiwiR3R?=
 =?us-ascii?Q?86NUQpnGblteYCznRev861tVnGSd/aZPGb+pAaIV+urz5F5lKm2lOVjvFTpW?=
 =?us-ascii?Q?voLOgPM0DXHjE0dmmQoDGFxlQ6TOaL90It1tMRsi18/gXCey0YA7uz+7JgCR?=
 =?us-ascii?Q?lN0ABWKTn2UVie17iRIAGzKHguwy4REnCPwWvig05gG/M/4v0XJVe9ggAlyB?=
 =?us-ascii?Q?illJV2fpzKzAYtF1AX8Po+BpsJUVftrXnjU58bcr39MYUetccMifpnXVkGG/?=
 =?us-ascii?Q?pMaXBP7tJIDAjOuklG6QNO8q671u+RuLOfOLgGPtLvgaPlXNAwEqc9hhQJNc?=
 =?us-ascii?Q?xbHoU0UId10sglY/vqA74fYYgAhhZD8Zd9fuZbStHLcMyw8aKhxSHyA1CNTG?=
 =?us-ascii?Q?axkV/XyRWckJmy0t8ziEVFeoqztXlUaNVbviC/vo0eNCIFsCyiqaWem7wm4x?=
 =?us-ascii?Q?nqXx8JwASewDe5ZXdXhlM/9TwpQ14y5FNbN+luDkMfxJzm6ZTFXrN6u4amwz?=
 =?us-ascii?Q?Ji/wrJKyqL9w8kde0i0MR4xDfsw6R6A3Dosm4YEXq2pjTl3FdXxfuPxzerjY?=
 =?us-ascii?Q?Z7toaSw/M9gKvt7fSBeSfqQ6bE47sAa+Dptq9WtEsA3NITuUdUR0uTKyvvIo?=
 =?us-ascii?Q?NSEaFnUbsO7Oy9Sc8uU75tTHedw5/Sg/MSLy11UBgBWs2nsqNHXyM42qA9Ui?=
 =?us-ascii?Q?19N78oT1cm7kJGDbWo9QCbVj41SMaKZUTOYvJj/CWsbb9zopDE2KABnpb7wq?=
 =?us-ascii?Q?Gl0bPAJjTYzfmwpr0o1L17LrClZ2pJxOa4XDk6LPzhoJHWOGwSXzg//88IG4?=
 =?us-ascii?Q?S2RTqbOgvToZHO1+lJsNzZSdvP/Bl3BHT10RWa1VXMYzlIxncn3Kom9/7vIp?=
 =?us-ascii?Q?JBVIVzNaC3KbzeKBGZ9FWCYyrxt8IoBloUq4NgzoiHFkiszq+feVCY37pYgS?=
 =?us-ascii?Q?9AGO6ITQ+tS0d0OVGHG41qha9151lA/bTtGNIbtebC/kQEgaOrdtrtHn4bnG?=
 =?us-ascii?Q?voCCRM4MeV3ImB1DYqvlMN8nDdcw0e+E0hYozoMu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42ba446-b2be-4360-302a-08dc8408e1b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 20:08:06.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5sLWg4ekcbJrcGHIlx49P2M1oYZ3jwmBJ0zITSH248TqNloP2fHpAe8uWxUI3EP/fZK6RMLdPQZEB4kM2UWSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835

On Mon, Jun 03, 2024 at 01:56:27PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 03, 2024 at 02:42:45PM -0400, Frank Li wrote:
> > On Mon, Jun 03, 2024 at 12:19:21PM -0500, Bjorn Helgaas wrote:
> > > On Fri, May 31, 2024 at 03:58:49PM +0100, Robin Murphy wrote:
> > > > On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> > > > > [+cc IOMMU and pcie-apple.c folks for comment]
> > > > > 
> > > > > On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > > > > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > > > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > > > > This involves examining the msi-map and smmu-map to ensure consistent
> > > > > > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > > > > > registers are configured. In the absence of an msi-map, the built-in MSI
> > > > > > controller is utilized as a fallback.
> > > > > > 
> > > > > > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > > > > > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > > > > > controller. This function configures the correct LUT based on Device Tree
> > > > > > Settings (DTS).
> > > > > 
> > > > > This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> > > > > have to do this, I wish it were *more* similar, i.e., copy the
> > > > > function names, bitmap tracking, code structure, etc.
> > > > > 
> > > > > I don't really know how stream IDs work, but I assume they are used on
> > > > > most or all arm64 platforms, so I'm a little surprised that of all the
> > > > > PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> > > > > this notifier.
> > > > 
> > > > This is one of those things that's mostly at the mercy of the PCIe root
> > > > complex implementation. Typically the SMMU StreamID and/or GIC ITS DeviceID
> > > > is derived directly from the PCI RID, sometimes with additional high-order
> > > > bits hard-wired to disambiguate PCI segments. I believe this RID-translation
> > > > LUT is a particular feature of the the Synopsys IP - I know there's also one
> > > > on the NXP Layerscape platforms, but on those it's programmed by the
> > > > bootloader, which also generates the appropriate "msi-map" and "iommu-map"
> > > > properties to match. Ideally that's what i.MX should do as well, but hey.
> > > 
> > > Maybe this RID-translation is a feature of i.MX, not of Synopsys?  I
> > > see that the LUT CSR accesses use IMX95_* definitions.
> > 
> > Yes, it convert 16bit RID to 6bit stream id.
> 
> IIUC, you're saying this is not a Synopsys feature, it's an i.MX
> feature.

Yes, it is i.MX feature. But I think other vendor should have similar
situation if use old arm smmu.

> 
> > > > If it's really necessary to do this programming from Linux, then there's
> > > > still no point in it being dynamic - the mappings cannot ever change, since
> > > > the rest of the kernel believes that what the DT said at boot time was
> > > > already a property of the hardware. It would be a lot more logical, and
> > > > likely simpler, for the driver to just read the relevant map property and
> > > > program the entire LUT to match, all in one go at controller probe time.
> > > > Rather like what's already commonly done with the parsing of "dma-ranges" to
> > > > program address-translation LUTs for inbound windows.
> > > > 
> > > > Plus that would also give a chance of safely dealing with bad DTs specifying
> > > > invalid ID mappings (by refusing to probe at all). As it is, returning an
> > > > error from a child's BUS_NOTIFY_ADD_DEVICE does nothing except prevent any
> > > > further notifiers from running at that point - the device will still be
> > > > added, allowed to bind a driver, and able to start sending DMA/MSI traffic
> > > > without the controller being correctly programmed, which at best won't work
> > > > and at worst may break the whole system.
> > > 
> > > Frank, could the imx LUT be programmed once at boot-time instead of at
> > > device-add time?  I'm guessing maybe not because apparently there is a
> > > risk of running out of LUT entries?
> > 
> > It is not good idea to depend on boot loader so much.
> 
> I meant "could this be programmed once when the Linux imx host
> controller driver is probed?"  But from the below, it sounds like
> that's not possible in general because you don't have enough stream
> IDs to do that.

Oh! sorry miss understand what your means. It is possible like what I did
at v3 version. But I think it is not good enough. 

> 
> > Some hot plug devics
> > (SD7.0) may plug after system boot. Two PCIe instances shared one set
> > of 6bits stream id (total 64). Assume total 16 assign to two PCIe
> > controllers. each have 8 stream id. If use uboot assign it static, each
> > PCIe controller have below 8 devices.  It will be failrue one controller
> > connect 7, another connect 9. but if dynamtic alloc when devices add, both
> > controller can work.
> > 
> > Although we have not so much devices now,  this way give us possility to
> > improve it in future.
> > 
> > > It sounds like the consequences of running out of LUT entries are
> > > catastrophic, e.g., memory corruption from mis-directed DMA?  If
> > > that's possible, I think we need to figure out how to prevent the
> > > device from being used, not just dev_warn() about it.
> > 
> > Yes, but so far, we have not met such problem now. We can improve it when
> > we really face such problem.
> 
> If this controller can only support DMA from a limited number of
> endpoints below it, I think we should figure out how to enforce that
> directly.  Maybe we can prevent drivers from enabling bus mastering or
> something.  I'm not happy with the idea of waiting for and debugging a
> report of data corruption.

It may add a pre-add hook function to pci bridge. let me do more research.

Frank

> 
> Bjorn

