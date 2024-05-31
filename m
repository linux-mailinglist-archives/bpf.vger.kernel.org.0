Return-Path: <bpf+bounces-31043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA568D668D
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 18:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00256286AAC
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F3D171E4A;
	Fri, 31 May 2024 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G4xIqJLe"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413954784;
	Fri, 31 May 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172076; cv=fail; b=Q9ubzzPzDF6gcKifTojug9tyaDWWKGn7763UFE99k8d0dM/hzfDN+xpZyJsQ46IebKe6ijH0AkVHRanyosoFfGsCAthP6Txq1flljwuzGVMP+hXOu1YSdDo1Sv5rejtdFSvOcXSYAIRM53I/2bGmgFs5//252FguhY6UoTGuRZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172076; c=relaxed/simple;
	bh=jdEEHkT2MC8VB7Uzs9pzw0KvmQorfK7ewoHQfqElwcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iMHOodjoSmc0DijkTt/bQkS8zLlblKafDEOkMliJTJEHbFIXtNJQcLrE5FuN/HTkDFLKqkzpoaLOtBn70vIApPcAukEaxQxzihQWVgMUXBtpK/YaEsup+pJhAtUmGalrd9OHGOsgoMywMk9SwjVLxeGPjjIAsCM739I0E12B+RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=G4xIqJLe; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLGwq7Po+s/WLXsSwlBO+URIt7SAkttRri3lIPwJnqXqIU/YjoWahVtTVpYKzsVOiq2xv3k8EGJDc/OL3zpkBURWSPZTxCQ17OU1E4Wy/X/jmK7+tG76ueEBtHL1TYpeqxBjwCDJ62TEMcz2ks2K8n3RdZ92mlhWxwDVdS9wNpOf+iihBZpcanokf1zaWvj6KfaQ/1ybrpayeILMCLgeUIxPKUDi8Bc6aMzftfzpzzHrxFidrfXYyWTn5onEY5rngb8q4IIseZ1ZcDl8NTYIGy5yVEV8Ri+9zs/OTTiq1yeGvxsKMjwOSERYgQmMWy2/nV4ktMTTkZXywzGG3xyiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkD+4JKYMvhjbFcKEWItu8iITnB4HsoOEVvPQwHxoe0=;
 b=T8NnJwDx+ppk1K1LAbwGal8p+WuTUJw3YOWT0FQ1CGbhdYytAWHrNXd8rjfpLQdm3GRgibvHcChytRUUEXoW8BngL+48xXknbYjmNFZLNau9qLEfSMbX8IgklIH/1H68CbMkY24DZx0qkZTcDmxubQd1/eIcSCuIsbZm01Za9WFrm9EM9ZverP9aD3Fnd3WWCqqwaxB/vUqGmimwuf6gZj/aN7dwYXdiYyMkeFilILAHx4NpoDReMsG7it2ECsgBuDlPYvOwOEbAf4FfO+OkvBtKJ4d3ETd4/W7Tg+Lr25YwFnrcfNjWf+GpG8rurrvt6/L8PBlXetieNtPqECmd7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkD+4JKYMvhjbFcKEWItu8iITnB4HsoOEVvPQwHxoe0=;
 b=G4xIqJLeI9FGkild7ZiBAoAPTyyT2EQ3Z/TQUmIvz/J6XvbugNYOqKWLVIyzPxj7dN1ja/HiWCFHaTGQgs1KByDmoJGCC52K5s6DgxepkrIJBZz6vaVWLGKN3VgUKgZvzid2So90vyOh6cCxZcpG80aUHglrlWtcUG+e1d05OYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6964.eurprd04.prod.outlook.com (2603:10a6:208:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 16:14:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 16:14:30 +0000
Date: Fri, 31 May 2024 12:14:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
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
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <Zln3WkiHC3AUPocL@lizhi-Precision-Tower-5810>
References: <20240528-pci2_upstream-v5-8-750aa7edb8e2@nxp.com>
 <20240530230832.GA474962@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530230832.GA474962@bhelgaas>
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f554137-48e1-44a0-f40a-08dc818cc058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|52116005|7416005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VWHDRDbsGDUdSO2yXLGQ1aL+9Mrw4fEQUA3Jd/oLperLx1ultGLMzyjVdCYx?=
 =?us-ascii?Q?g2h9Pp3PTXJabPzTxbU7hWuhiwX4fyrKY20wJed2aYBJcaXh2SdbNjMuqcWQ?=
 =?us-ascii?Q?4NmH72irVtWpGNDQNDhYZMxFRxQDfWj4kg9Up7pGccONK+qfSKxqgDCLPOlr?=
 =?us-ascii?Q?hOcDo661JkgprtzEu4/FTl1cG4jTTEObV2wfFD86CWZUhjDLMRChyrv5oT6y?=
 =?us-ascii?Q?6C8oKBCBmYPNXdWcQ0IqU3DuRn1fUsE7lrIGY9tg+L0PZuafS8JYJSgXGtwk?=
 =?us-ascii?Q?H2nTqFDnWb+Fp+zTfy7BaEyPMU4I2XN8ijbG5uUOs6N6CIt+xRFd+e9ZL5aI?=
 =?us-ascii?Q?G7Bsh+z+zLrTuYDIv0ZCPJUuXWQ1gAYzcyw2RPvE/VU1mDNzkkIMbUTjqe4w?=
 =?us-ascii?Q?ESi7vNKQv4+LBkHiUZr+SCNrNJwlg466/U63BFZhH+V17imvMi98SHn8HbrJ?=
 =?us-ascii?Q?mCPM+5ADYbERYpeFJjVlDQqIUTKq8VN7hk9XGiWmuVKqtEh78YgKjMaa7PuY?=
 =?us-ascii?Q?/RqFYFGUovEgTttlN503QRnZGtPXNU3kil+96hluTd4+Gvz98gfmchEPcbWZ?=
 =?us-ascii?Q?CY9uvNgcbtioGv79ozYg2JSf6EurTvF8XZ0ckASDF8+BWHPCymey5R7kQki0?=
 =?us-ascii?Q?YkvdkEsyFBNq24yY+P3L446ZqKXxigcU2kUIhXpImNN4tAS6cHa7aZgzUPvy?=
 =?us-ascii?Q?e6ij5Y5k38Y49iO1J8c+8TO2TbSUXvXmhojiY9IwV97RVAEo7RgerlJMjo4q?=
 =?us-ascii?Q?NOv/2dYqK0BKEFGRQVXK1acwieT+c75AnVetVpKJkXzcm+cNGZiQCAFFnMNe?=
 =?us-ascii?Q?+A5mjRAdBdvPSnc59zYgd7V4+rKVZmCV1RpneBJHOd2JMKcZBh6j8UMHfuuO?=
 =?us-ascii?Q?8/5ySyGrztDYDnK2yl94x+E7rY8Nobz6I/gcJPwS06Ikix0jC8GqMCWxyOYZ?=
 =?us-ascii?Q?qwaSsR4JgH307YjXQErfGHOOyZTp4DCK3jtTc/zq06gozBKAifewU9+dSF12?=
 =?us-ascii?Q?qqJpObs6avLrahDMAW218wF97adUAWPQ1uF/p4r+Ho8ThlHpzpDTR+z55GNl?=
 =?us-ascii?Q?2zD6n0k2TyRRgWaR3ohiBfkScD5lr9TCmdTT8eoCNiUUAxhsGBfEOylwgtnI?=
 =?us-ascii?Q?9rGbNl20w3Qrm2WQp6WobsiIPCS0KkfPJ31oM0tW+iUpROyFYpF8Rf4JzBBm?=
 =?us-ascii?Q?nX6o/BkmeTiOvbwcWmBlgN2iLS/DjKu/fLzZREH9Q6Ecz57iQN76sfxK+oPD?=
 =?us-ascii?Q?X5BjJhJ4JHHeZVpiE31qll1OPmGfYuYCaBn7iSjPjxHYzKJwsCiicjC+6TBo?=
 =?us-ascii?Q?5Bf/bfFu1CxYkp8M+wCi4ePLrqzsPL4CTmvpmy7dCQ5hbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?04LBbn2QkS6dooYRPiXSPMRjfTopd/Pnpw5MocIsaoo2KDdWKx0iHOv/RRk2?=
 =?us-ascii?Q?XefCqWz038reQrc5ipCmrQenMw7q5o5YQo1nWyHB8KInsFbU45S03N2u7CJK?=
 =?us-ascii?Q?ASEUDrGvc3dtL7uTjhnVxZs9Tm0wEyNFusyEev34c1oj/QXVIZg0Znn3ZUo5?=
 =?us-ascii?Q?GPVeSnlUbtEt/BfFONY/8cbcJqbYHTqFhzD/kmgnEcMqBHjsYgcN0+Grjqv4?=
 =?us-ascii?Q?43NLyHFdZHEn7r/wp5/D1ZhB24MvVRNHWkJ7fCB3rYwOGPuz46YEkdaV7TF4?=
 =?us-ascii?Q?3GqaRTk8msIJX+tybUnbL/BG90TwqzEtY2QNc14jOGTAvaCH0FDFHXAFyhX/?=
 =?us-ascii?Q?i57EpCmVrRCzjxXLcI5Iif2RcC72/4cl0w7nkEWOXRmdwzM7FKt+GXvyEpzP?=
 =?us-ascii?Q?DKgOw/6xLq9jwgNeMqpAtANsKYiH4gQYTqUSnXsi2yvHwHgl/AGf7FWLcuVX?=
 =?us-ascii?Q?jsJBMFyv7GUE1FmrK15I5OY5lijsw65DfQhhCDyQvsVggIETI/vzNz9+645v?=
 =?us-ascii?Q?Zk0iOqRLnYjoQTnape2JYZfvvrhrj19JwCqBU0TG82zyXyFWfJpcj36dvMAm?=
 =?us-ascii?Q?SeVC+nUznfgTYxj1PZWHgqFI0pc0Itk/qiLDzwtZ7dZSmtgq5Jdnn7Ix1f5l?=
 =?us-ascii?Q?FqQRxFvbZQPvAD/+T2pDm/J1+UBV8833H2Y2lxEUA5TaBypB6Jxujgr8bb65?=
 =?us-ascii?Q?KqW77VZJTl4fXa4vOPC8ziPpliBtzXECMK6BKF+44CtSVxSZw+H9whz1EZc9?=
 =?us-ascii?Q?lgptv0iF+i8ysbu6pLjRULBNAnkrqRKS47iRpaTqUHBCfpcLOORJErgrZDt/?=
 =?us-ascii?Q?GXO8gHMceQJFF0g1UcLSSltuVVn7S3Tjx2sJkYTYDJsm80P9BfDfZR9gaIrt?=
 =?us-ascii?Q?dyhv3drwH9o/0rrdBimDXXrWdrBSSSCjWx89M/hbkliyRanzPMZBgqpZgpaU?=
 =?us-ascii?Q?IB6J7q2iMgVQ/+Rdm/yU5X0nt5oA29SK4nfc4cDvrbXkl1D/5qyiHB4INZMS?=
 =?us-ascii?Q?y9pNEbMN8QvruCMsMBpO2bOkm8EH6JRdgAd/lkC4pl0ZoBr5Zy+9Krz2aLpL?=
 =?us-ascii?Q?F6Ypqft+AN6NOFu4xRU6y/ZGzUGJA1MtZ5eaonm1o1ZhUhaUkd+ktD1MsXJW?=
 =?us-ascii?Q?VSIFLv2ve+uwkeDFxMwg05eFQk/SRZcShBnwdJ+4xVNrZK12skVUtq2v5wob?=
 =?us-ascii?Q?nehc1PbF3TpRaLj52e1Gu95c263W77veW04vFj36U+4P2crh4qVmGt5BF/Pg?=
 =?us-ascii?Q?jxkCW77/alFOj4lgQbC32YwATMhSmSmxhfJr/uB3JiWOh2MhVogrR6sVh9YD?=
 =?us-ascii?Q?9ENp3huVHJmuuo3bGEc1/mtFLdBGAdV32s+2mjhFjaCVYx/2GI995b6p1gW4?=
 =?us-ascii?Q?0DapSqIZfQiiY/rcPPQVTvRt7P+Ydn0zvHt9eM34LCDb2LWi216ROMr+ZOT7?=
 =?us-ascii?Q?wJXBC9O2nGrW8QJsS8iIDSafO0iNw2fD+nCeD0MsdGXVy97c3UePCN99rQXT?=
 =?us-ascii?Q?60fdaSMFg1bOllAIVf2km9Tc9HaJPRxwkXf9tAdEz8uzbZUQ4c+hiREwm2ed?=
 =?us-ascii?Q?f7YmoiGzXO7gtNaEU5o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f554137-48e1-44a0-f40a-08dc818cc058
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:14:30.3033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZhpkOs4PM+X4LgwMYrfy5426KXLFPcpgGR5qKj6mR6LfGpXcKi8nJ9bD5Md8mXmW7dhD4u0SuLoPfBXptUksw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6964

On Thu, May 30, 2024 at 06:08:32PM -0500, Bjorn Helgaas wrote:
> [+cc IOMMU and pcie-apple.c folks for comment]
> 
> On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > This involves examining the msi-map and smmu-map to ensure consistent
> > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > registers are configured. In the absence of an msi-map, the built-in MSI
> > controller is utilized as a fallback.
> > 
> > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > controller. This function configures the correct LUT based on Device Tree
> > Settings (DTS).
> 
> This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> have to do this, I wish it were *more* similar, i.e., copy the
> function names, bitmap tracking, code structure, etc.

Actually, I refer apple_pcie_bus_notifier(). I can't direct use apple's
implement because in imx95 have difference PCI host controller, another one
is PCI ECAM netc controller. At lease function name should be similar with
apple. 

> 
> I don't really know how stream IDs work, but I assume they are used on
> most or all arm64 platforms, so I'm a little surprised that of all the
> PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> this notifier.  
> 
> There's this path, which is pretty generic and does at least the
> of_map_id() part of what you're doing in imx_pcie_add_device():
> 
>     __driver_probe_device
>       really_probe
>         pci_dma_configure                       # pci_bus_type.dma_configure
>           of_dma_configure
>             of_dma_configure_id
>               of_iommu_configure
>                 of_pci_iommu_init
>                   of_iommu_configure_dev_id
>                     of_map_id
>                     of_iommu_xlate
>                       ops = iommu_ops_from_fwnode
>                       iommu_fwspec_init
>                       ops->of_xlate(dev, iommu_spec)
> 
> Maybe this needs to be extended somehow with a hook to do the
> device-specific work like updating the LUT?  Just speculating here,
> the IOMMU folks will know how this is expected to work.

Let me do more study. But I think ITS also need stream ID, not sure if
only hook IOMMU can work. Some configuration, IOMMU have not enabled. but
ITS need it.

Ideally, pci system can provide a hook function to host bridge when new
device add and remove.

Frank

> 
> Some typos and minor comments below.
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 175 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 174 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 29309ad0e352b..8ecc00049e20b 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -54,6 +54,22 @@
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
> > @@ -79,6 +95,7 @@ enum imx_pcie_variants {
> >  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> >  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
> >  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> > +#define IMX_PCIE_FLAG_MONITOR_DEV		BIT(8)
> >  
> >  #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
> >  
> > @@ -132,6 +149,8 @@ struct imx_pcie {
> >  	struct device		*pd_pcie_phy;
> >  	struct phy		*phy;
> >  	const struct imx_pcie_drvdata *drvdata;
> > +
> > +	struct mutex		lock;
> >  };
> >  
> >  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > @@ -215,6 +234,66 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
> >  	return 0;
> >  }
> >  
> > +static int imx_pcie_config_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)
> > +{
> > +	struct dw_pcie *pci = imx_pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	u32 data1, data2;
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
> > +
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> > +		if (data1 & IMX95_PE0_LUT_VLD)
> > +			continue;
> > +
> > +		data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
> > +		data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
> > +		data1 |= IMX95_PE0_LUT_VLD;
> > +
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
> > +
> > +		data2 = 0xffff;
> > +		data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
> > +
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
> > +
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> > +
> > +		return 0;
> > +	}
> > +
> > +	dev_err(dev, "All lut already used\n");
> > +	return -EINVAL;
> > +}
> > +
> > +static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 reqid)
> > +{
> > +	u32 data2 = 0;
> > +	int i;
> > +
> > +	guard(mutex)(&imx_pcie->lock);
> > +
> > +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> > +
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> > +		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == reqid) {
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> > +		}
> > +	}
> > +}
> > +
> >  static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
> >  {
> >  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
> > @@ -1232,6 +1311,85 @@ static int imx_pcie_resume_noirq(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static bool imx_pcie_match_device(struct pci_bus *bus);
> 
> Can you add the imx_pcie_match_device() earlier in the file so we
> don't need this forward declaration?

imx_pcie_match_device() use global veriable imx_pcie_driver, which close to
end of the file. There will be bigger change if move imx_pcie_driver ahead.

> 
> > +static int imx_pcie_add_device(struct imx_pcie *imx_pcie, struct pci_dev *pdev)
> > +{
> > +	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
> > +	struct device *dev = imx_pcie->pci->dev;
> > +	int err;
> > +
> > +	err = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", NULL, &sid_i);
> > +	if (err)
> > +		return err;
> > +
> > +	err = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", NULL, &sid_m);
> > +	if (err)
> > +		return err;
> > +
> > +	if (sid_i != rid && sid_m != rid)
> > +		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
> > +			dev_err(dev, "its and iommu stream id miss match, please check dts file\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +	/* if iommu-map is not existed then use msi-map's stream id*/
> 
> Capitalize consistently, e.g., the most comments in this file start
> with a capital letter.
> 
> s/is not existed/does not exist/
> 
> Add space before closing */
> 
> > +	if (sid_i == rid)
> > +		sid_i = sid_m;
> > +
> > +	sid_i &= IMX95_SID_MASK;
> > +
> > +	if (sid_i != rid)
> > +		return imx_pcie_config_lut(imx_pcie, rid, sid_i);
> > +
> > +	/* Use dwc built-in MSI controller */
> > +	return 0;
> > +}
> > +
> > +static void imx_pcie_del_device(struct imx_pcie *imx_pcie, struct pci_dev *pdev)
> > +{
> > +	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
> > +}
> > +
> > +
> > +static int imx_pcie_bus_notifier(struct notifier_block *nb, unsigned long action, void *data)
> > +{
> > +	struct pci_host_bridge *host;
> > +	struct imx_pcie *imx_pcie;
> > +	struct pci_dev *pdev;
> > +	int err;
> > +
> > +	pdev = to_pci_dev(data);
> > +	host = pci_find_host_bridge(pdev->bus);
> > +
> > +	if (!imx_pcie_match_device(host->bus))
> > +		return NOTIFY_OK;
> > +
> > +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(host->sysdata));
> > +
> > +	if (!imx_check_flag(imx_pcie, IMX_PCIE_FLAG_MONITOR_DEV))
> > +		return NOTIFY_OK;
> > +
> > +	switch (action) {
> > +	case BUS_NOTIFY_ADD_DEVICE:
> > +		err = imx_pcie_add_device(imx_pcie, pdev);
> > +		if (err)
> > +			return notifier_from_errno(err);
> > +		break;
> > +	case BUS_NOTIFY_DEL_DEVICE:
> > +		imx_pcie_del_device(imx_pcie, pdev);
> > +		break;
> > +	default:
> > +		return NOTIFY_DONE;
> > +	}
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block imx_pcie_nb = {
> > +	.notifier_call = imx_pcie_bus_notifier,
> > +};
> > +
> >  static const struct dev_pm_ops imx_pcie_pm_ops = {
> >  	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_pcie_suspend_noirq,
> >  				  imx_pcie_resume_noirq)
> > @@ -1264,6 +1422,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  	imx_pcie->pci = pci;
> >  	imx_pcie->drvdata = of_device_get_match_data(dev);
> >  
> > +	mutex_init(&imx_pcie->lock);
> > +
> >  	/* Find the PHY if one is defined, only imx7d uses it */
> >  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> >  	if (np) {
> > @@ -1551,7 +1711,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX95] = {
> >  		.variant = IMX95,
> > -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> > +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> > +			 IMX_PCIE_FLAG_MONITOR_DEV,
> >  		.clk_names = imx8mq_clks,
> >  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> >  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> > @@ -1687,6 +1848,8 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
> >  
> >  static int __init imx_pcie_init(void)
> >  {
> > +	int ret;
> > +
> >  #ifdef CONFIG_ARM
> >  	struct device_node *np;
> >  
> > @@ -1705,7 +1868,17 @@ static int __init imx_pcie_init(void)
> >  	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
> >  			"external abort on non-linefetch");
> >  #endif
> > +	ret = bus_register_notifier(&pci_bus_type, &imx_pcie_nb);
> > +	if (ret)
> > +		return ret;
> 
> I think this should go in imx6_pcie_probe().

The same nb only register once. If move to probe, bus_register_notifier()
will return error and dump error message when second pci controller
instance probe.

> 
> >  	return platform_driver_register(&imx_pcie_driver);
> >  }
> > +
> > +static void __exit imx_pcie_exit(void)
> > +{
> > +	bus_unregister_notifier(&pci_bus_type, &imx_pcie_nb);
> 
> It looks like this driver is removable?

Actually, I think not. I am not sure how to prevent driver remove. There
are raise condition when driver remove and a pci device hot plug at the
same time although hot plug pci have not implement yet in imx platform.

> 
> What happens when an external abort occurs after the
> imx6q_pcie_abort_handler() text is removed?
> 
> > +}
> > +
> >  device_initcall(imx_pcie_init);
> > +__exitcall(imx_pcie_exit);
> > 
> > -- 
> > 2.34.1
> > 

