Return-Path: <bpf+bounces-31258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04AC8D8B41
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5DA6B2657F
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A7413B59B;
	Mon,  3 Jun 2024 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d3YtS3RG"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90DE2E414;
	Mon,  3 Jun 2024 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448681; cv=fail; b=SPxk5VFQsliaLruMMWiZjg4g1qfZPC+WCboy5aFFTIyL2EI6dqbjANXmw4uPlTKRVkNhkxSVJVf6+5rRwNMA8HnLJpdZUwXxeMTlBIcJvLh+QHygSgRj7h0VBpDZrqIdIXnlSOL2DXH1MfOFOWLKPYS0ph8908eqeyY5Of1sV+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448681; c=relaxed/simple;
	bh=9fc76j+VV9p54TMqkYYgVheqDgBpRd7Cd9isD4p61OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UVJSaJnUtbxTCkN2aoNblgJAPNRHlmYoVVWjUDpK5vJZX4uisqI3Lg3ahbS26oFBeUu1xxuMKd1wcb4G9kU7NIXbLewPOcZ+jGCDfUsctZOVGoO8jYo/EJPBTDs3A5RSGsNUl2+4bWykQ/V/ss6xrchpiosLw69vUplA1PEw4Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d3YtS3RG; arc=fail smtp.client-ip=40.107.247.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEIcYdAQrV4h+76ndeYRlR0b+wy5Ztckp25V7/FXGtYtxL11We/KEbYlvtIHLQ9QJhb3kOnp0ZOOXl0OTdfZgdBcDXRffRx9MmZvetDKYaoRgoldumnH5atkOorJ2rpacCwt5nzjkHkdlUNdfs2j8e8ZvPUGMfux+OPXaaWfnUt5S2ItK6xEsjjlqMnQp7AURIK8HhSd7uUywx/OyQM1XZZM37DzLN/YX07eqd+75Qbx1CBYLTeXtTCfjhthyWS82Wr//aa1lwMNRJiORJ5f4C6+M/xdppgodw6IgMMN3bt3LQo8W989L3vhyc2IXAs4ZUWFkyHRjV4v7EtqT0gPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/LVtvBw8S4djGr4p3hqXbB1Jx0iU9Z1FuBeFD82KPM=;
 b=X1iR66OPzwSGsOTbNM6E8Nt60SsIgAkQKxipYZiNzSFyryD7v05HhySxXmQvAc0yDJaAEU7f8ud97zGwpWcfLIh9WM3NG81oQGS8+iWR7oAlSl4G6PmL/Oxxp0IuCXt0bUV9D3bJE9bGyPLvFkAU3PJILlodb7YcVhz7SIIGlvMj/aCxlkzgZmJ5DFLYajSBKFpjGQ9HnkbnmA5a/cA4mj8KJfQOnKN89rv1ikCkhqLxRTjcnCTrl41Wih5r7eHQVuRcHL1nKdAo5oAjQGn3sSmZ6R0uB0qMDKmFaMOgWMA/IMSnYSjf81SQ57PFVPqz7lTKa6rTYKelcGdIAGkQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/LVtvBw8S4djGr4p3hqXbB1Jx0iU9Z1FuBeFD82KPM=;
 b=d3YtS3RGTHSw4LkvWzcvNxuOKwvhml3NQZabrps+c15K0lYD6mNZgPVFIrXn+EWjRuIba4le3TaSCsr0BHDvsEMef6I8enlSnGPj+B/qbrKf+g7/Tm0LebODTYajGizpBYv/UDVOZWfry5iLasB7Oab2AewumZFL6qaFhLAaTgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 21:04:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 21:04:35 +0000
Date: Mon, 3 Jun 2024 17:04:23 -0400
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
Message-ID: <Zl4v10Od99et+tLX@lizhi-Precision-Tower-5810>
References: <20240603171921.GA685838@bhelgaas>
 <3d24fecf-1fdb-4804-9a51-d6c34a9d65c6@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d24fecf-1fdb-4804-9a51-d6c34a9d65c6@arm.com>
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ae940a-1c12-489a-0556-08dc8410c5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q4wL8r1Soh+rI7BtGWXQY+ca24DinBNHcjY3F2AMpO+9qrrhnEW2RSLOZC56?=
 =?us-ascii?Q?lX8GlLjeadAzI4EBATk4l7igq5PMpu1Zne4KemnTI4DzmohHmcH5g96udDHb?=
 =?us-ascii?Q?veiwqXu2p1QmaxrQbCEjzJsAwSec+bH26uFDzualembfc+aPVOxGf7rCSogL?=
 =?us-ascii?Q?BqtcIYAGCotztRMiQztnsdgqUVZRnXkEIN66vhqT2kfTbrTgSy1vAbB/T1Qv?=
 =?us-ascii?Q?DpWQkZDNqc/BrWHV1HW6Ygd25zWDGt383UKSmNOKKXkerHehMwENX3HxbWtk?=
 =?us-ascii?Q?Vvl7GVCi5Le+P9B424M/TeK9sTfbqMz3sY/xYCAJ1NfanpGQp75dYN0xZOxx?=
 =?us-ascii?Q?lT53B7AVQag+3TwevTMev8iYFZ95LkikUSDcVCaIyvkkrZMj0IFucSBegKCp?=
 =?us-ascii?Q?pb6duOTXw1vL4baG2HYF1Evt0NZISSho1PLBIhtDTzgg2Cb5ICK7BYTtWksk?=
 =?us-ascii?Q?T3XYvBTpZ3esnVgJSPOr7HeNJPqqUS8WwIAJRmJhIZMizN7v/mLkx92A4kRi?=
 =?us-ascii?Q?9oYAYYe3YysfISeIGAdK1ylkCXGHjAcG0U7T85bZZONQoN7X/tHTuJIUO0wm?=
 =?us-ascii?Q?o/gW5BpV49MwGgnjnAwJSI7FKpYS5YImX/EsrTrcUdMBMiDZKuEiJQva6R59?=
 =?us-ascii?Q?QTeQFm5CiZYhgWHHns9GBRJtSmDBGwLTbt8SCQXJ2hmk5FB+JQkEG/wcthwK?=
 =?us-ascii?Q?eXYnislZMkPCyJu3Yir6B+ReM17CwJA31mvRLsRl8srn8jYYgHyYAZ6/oZaj?=
 =?us-ascii?Q?J4LgTw//clArs0Kf0nq1BcPwun1L9FaFwr3f+uWOI1AA2WN3/cyVQ/Uyup+0?=
 =?us-ascii?Q?o5ZLZxK+lo41SUIOqALfGQGFYhUiOuuyFIhGD3p3ZWg68b8ShGCQQmfKQMLR?=
 =?us-ascii?Q?4lBMgz7M3NQOv3ZTyEVTUAnnDbsrfuyGnwSyB9aoRilkl4MB6jYlTlA2HdUc?=
 =?us-ascii?Q?7elJsC82awlPrIEMKd3OUssiRiLeaIjIPhkyTkKt9UaUSrYxggjMRUUmIyDj?=
 =?us-ascii?Q?YkR8jX+KBVXOvveYjfgjNM+u1aaJnmrNXyHBj7piPEN0RmzkXj+b0Bv/I2DR?=
 =?us-ascii?Q?flDJ9zwUGJ+mVRbJvr9SOAx0yg6hvAQMIgkeDfyR0nYDHzJFwHqZgSxywEWl?=
 =?us-ascii?Q?X/jevoc9yMHlFzk7TIEWwTOJWbCb/RNSZ20jcUYInpTwtz7CHJvICEhe8z0q?=
 =?us-ascii?Q?lbVtZN/e5ZQ2PmYE6EtWjGiNq0M2g7Ug8cZQezMdVTPxeIFFnJ8H3jdVStb8?=
 =?us-ascii?Q?L5PC/rn1dvfgG1I625XisBXqtChicU3Azf/jW2/pyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2kGxLojdLpFSe4C4HI/68D43PyJz+LB4jz/lKuDao0REaBxHFU0zFxTBe93H?=
 =?us-ascii?Q?vFFjHuixDKgCJMl4kVeo0nQjb+Bun83086n9L03tUIsCEtFDzomQjTmq/yQP?=
 =?us-ascii?Q?jYSVu5Wuo7aeZv6VzHm9z7Oi6wYk31u83RsNnPaSVAb24o5uPVNCDR27swXo?=
 =?us-ascii?Q?56+oYcJAzmJFnkp655wkTwvWF4RgvM8cVbOr/u9xkgZQ/eSI7RKlyuI6k7u+?=
 =?us-ascii?Q?7E6OeghYxYCP3ZYTsjNW52yJRaLBOEZ90sRFht7DiMCWBryto8MLk0idunBv?=
 =?us-ascii?Q?k3nulIsyLujJ1QGAqXXc4WD54iGeVgSAB+aR9Xcyo59Vap/kvNZyJM5NPIgG?=
 =?us-ascii?Q?WYylFJq72nTDaso82IXaLwRlQiY8cvKkUNQQapdEKPcXZCo0wHd4VmVAmAxZ?=
 =?us-ascii?Q?dackmAEShDI7nlT+QtqxPjo2ZsjqyRzQWTpljIBhUO7JmleDPSucOpCI9Oty?=
 =?us-ascii?Q?1dVuOG0UxdPdx36+fmJpF5NKxNzlpUWJgaFzMBf6MWXYj2wmwNcESahh45kf?=
 =?us-ascii?Q?uNsCekbawEMZlOAizWjJHAbP81Ksts/Z0SSDCVMd9zdlQ+LIUzpBcFDQ29SK?=
 =?us-ascii?Q?Ic9N8WBXoI8tI6k4LlhganTjAg1o/SKosfSeX/QZ27gYtnSg/ACHsO6naeCE?=
 =?us-ascii?Q?ZtDlA4Vt8cEYAK/nJ66ZDOEF96czh4uPKAneMsVE6nLiFZVz2gTmCJDVXl1I?=
 =?us-ascii?Q?jxnGbXTTHwOUy2v7rYvdT+P72NPnJgPDuEU6XJLnFWiJ0QxZ5rU5HK2vJe/l?=
 =?us-ascii?Q?hUsIRn2uCpeeprN+ry9S/3x6zFn7y2boVeZnsMFfJVYN/nLbzwnj8JUJoYJh?=
 =?us-ascii?Q?7r2wm016D8chitUCGTwIynlM5mZZWTaBS57gIxKTDY+YngA/weg5tdYGwL0I?=
 =?us-ascii?Q?7JUdhmgzvwJA3cd39B2smr7HF0hPaE9+XnhDpX0usqIcMnD28/t11MtE1u0g?=
 =?us-ascii?Q?Phltf/tTQlF1upZR8yrwlFmAdaMOTJ59dpYMNc/ZTyKRK3ApCFnFUQMxWBLD?=
 =?us-ascii?Q?j1GEFu967EsCMROew0BL0ba50R2E/+7jofEdcvrL0IzmBDzsxFN8ovtEVvUa?=
 =?us-ascii?Q?j1TTCYIue+KSB0b5p8JAAG8KE86GaXwtZFOZkTQnUbeorhzUuEzZfyFofD3S?=
 =?us-ascii?Q?UWvlTmd+akniu3cOxWBpxnifO5aCwTWsKTyZ6Da1F++Ijez3B/lH62gKo5Fw?=
 =?us-ascii?Q?CKke8ez917vU2+uPgaRjPGUFhKNANaWAGGLMHKRk4lLQ5kJUJQAgoQiozEKJ?=
 =?us-ascii?Q?kF4M1vxVHwy/W0czqYOpwblxs/n7jwAJbAmPOArDHyq+07THFvwQw25RBajR?=
 =?us-ascii?Q?y7Y5GvwEWkdGDCa2iiP8+JF6dG8Jj03MJFdAm0CpDsWCDMkVTfKVtHn/ZOsD?=
 =?us-ascii?Q?w4K0t0OJ0HT53OWUHlQENMBpOGgNk6FC9ltnA55Y2msyY+by2rg1VS+ye7G/?=
 =?us-ascii?Q?sTlWiukOLu7/w3Lp+7aGtlKNvIfyNlJyaG/J8T8DZ1ghf3HDDq8JnUxUdjha?=
 =?us-ascii?Q?q+VSda8PY7jl/meXtH9nDBkArqFU7ado/VVqdbQpOqoVzzoaRrVBpqYgjT+e?=
 =?us-ascii?Q?hPl0TuOnCWEwRfalYnpy3NnFXMB5fAKabZQDpTGf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ae940a-1c12-489a-0556-08dc8410c5ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:04:35.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trdia4jcSzRB36n8nf/BFBP3HzoO2d7bUAG09lkWB42VQ/7HrfdMSSk2ebuNci2vG2WpHaxf+uHzzwRV0XFGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

On Mon, Jun 03, 2024 at 09:20:03PM +0100, Robin Murphy wrote:
> On 2024-06-03 6:19 pm, Bjorn Helgaas wrote:
> > On Fri, May 31, 2024 at 03:58:49PM +0100, Robin Murphy wrote:
> > > On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> > > > [+cc IOMMU and pcie-apple.c folks for comment]
> > > > 
> > > > On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > > > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > > > This involves examining the msi-map and smmu-map to ensure consistent
> > > > > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > > > > registers are configured. In the absence of an msi-map, the built-in MSI
> > > > > controller is utilized as a fallback.
> > > > > 
> > > > > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > > > > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > > > > controller. This function configures the correct LUT based on Device Tree
> > > > > Settings (DTS).
> > > > 
> > > > This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> > > > have to do this, I wish it were *more* similar, i.e., copy the
> > > > function names, bitmap tracking, code structure, etc.
> > > > 
> > > > I don't really know how stream IDs work, but I assume they are used on
> > > > most or all arm64 platforms, so I'm a little surprised that of all the
> > > > PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> > > > this notifier.
> > > 
> > > This is one of those things that's mostly at the mercy of the PCIe root
> > > complex implementation. Typically the SMMU StreamID and/or GIC ITS DeviceID
> > > is derived directly from the PCI RID, sometimes with additional high-order
> > > bits hard-wired to disambiguate PCI segments. I believe this RID-translation
> > > LUT is a particular feature of the the Synopsys IP - I know there's also one
> > > on the NXP Layerscape platforms, but on those it's programmed by the
> > > bootloader, which also generates the appropriate "msi-map" and "iommu-map"
> > > properties to match. Ideally that's what i.MX should do as well, but hey.
> > 
> > Maybe this RID-translation is a feature of i.MX, not of Synopsys?  I
> > see that the LUT CSR accesses use IMX95_* definitions.
> 
> Well, it's not unreasonable to call things "IMX95" in this context if they
> are only relevant to the configuration used by i.MX95, and not to the other
> i.MX SoCs which this driver also supports. However the data register fields
> certainly look suspiciously similar to those used on Layerscape[1], although
> I guess that still doesn't rule out it being NXP's own widget either.
> Anyway, the exact details aren't really significant, the point was really
> just to say don't expect this to generalise much beyond what you've seen
> already, and that there's precedent for bootloaders doing this for us.

It is re-used layerscape design at this point. I don't know the history,
why choose use bootloader to config it, supposed it should be done at
kernel. We found some problem by using bootloader to config LUT. Most
layserscape system PCI devices are fixed during boot.

During I debug layerscape PCI, I was trapped by uboot many times. It is
quite anoise, especially using difference version uboot.

> 
> > > If it's really necessary to do this programming from Linux, then there's
> > > still no point in it being dynamic - the mappings cannot ever change, since
> > > the rest of the kernel believes that what the DT said at boot time was
> > > already a property of the hardware. It would be a lot more logical, and
> > > likely simpler, for the driver to just read the relevant map property and
> > > program the entire LUT to match, all in one go at controller probe time.
> > > Rather like what's already commonly done with the parsing of "dma-ranges" to
> > > program address-translation LUTs for inbound windows.
> > > 
> > > Plus that would also give a chance of safely dealing with bad DTs specifying
> > > invalid ID mappings (by refusing to probe at all). As it is, returning an
> > > error from a child's BUS_NOTIFY_ADD_DEVICE does nothing except prevent any
> > > further notifiers from running at that point - the device will still be
> > > added, allowed to bind a driver, and able to start sending DMA/MSI traffic
> > > without the controller being correctly programmed, which at best won't work
> > > and at worst may break the whole system.
> > 
> > Frank, could the imx LUT be programmed once at boot-time instead of at
> > device-add time?  I'm guessing maybe not because apparently there is a
> > risk of running out of LUT entries?
> 
> The risk still exists just as much either way - if we have a bogus DT and/or
> just more PCI RIDs present than we can handle, we're going to have a bad
> time. There's no advantage to only finding that out once we try to add the
> 33rd device and it's too late to even do anything about it.
> 
> In fact if anything, this notifier approach exacerbates that risk the most
> by consuming one LUT entry per PCI RID regardless of whether an
> "iommu-map-mask" is involved. Assuming the IMX95_PE0_LUT_MASK field is the
> same as its Layerscape counterpart, we could support >32 RIDs if the map and
> mask are constructed to squash multiple RIDs onto each StreamID (the SMMU
> driver supports this), and we have the up-front information to easily
> configure hardware masking in the LUT itself. It's not necessarily possible
> to reconstruct such mappings from only seeing individual input and output
> values one-by-one.

iommu may share one stream id for multi-devices. but ITS MSI can't. each
device's MSI index start from 0. It needs difference stream id for each
device.

> 
> Thanks,
> Robin.
> 
> [1] https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_layerscape_fixup.c?ref_type=heads#L83

Thanks, but It can't resolve device hot-plug problem.

> 
> > It sounds like the consequences of running out of LUT entries are
> > catastrophic, e.g., memory corruption from mis-directed DMA?  If
> > that's possible, I think we need to figure out how to prevent the
> > device from being used, not just dev_warn() about it.
> > 
> > Bjorn

