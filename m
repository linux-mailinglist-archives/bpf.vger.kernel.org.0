Return-Path: <bpf+bounces-31222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CEA8D88CC
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 20:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32141F2206F
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 18:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B3A13A86D;
	Mon,  3 Jun 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N0Rafj8o"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464741CD38;
	Mon,  3 Jun 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440182; cv=fail; b=PvJoorQf8mW3Mjp55Qha+fhmvHquslis5FyEPkVcaxN0HX70CpRmxB1LYdqUEexdG52faaXFSTNbGwBEE8Q0B/XbYGKZXm1YH6FChMtixmCTo0l0dQxOj3M2ugo3FfJpP/PD/UEYYmguXADrGWRFQ25S4++VnsOdH6flKG3PMnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440182; c=relaxed/simple;
	bh=4BJLdjG1VfGVRq6KXCpi7lkzPahqsURTS+JH9V3GwUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=akg52y5gKlG9RwPXf5R2jiPfdtqCe/eJqDVEhvK+oH2HffKeOljpzrSJDa9sfXN40D0lZx0+aRnpD/VT49H3ClJUBBLBm6aSRWnphXXIFCuGM0d/KsnsJoekBwsCpvcFKn00twyXde/AdBxZ5swGkLq1AwsmDMoSWbnRwrfco3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N0Rafj8o; arc=fail smtp.client-ip=40.107.249.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STWbqBaHlU04W6ORPmAByKTDHw+m8Al7RUDGYVELJb7a3stviuAZLCWLj+IEmNoC6U1ZhEYO0113k19I5h2fcrkemYxIectiJrTuR3EtNLn6FrEsDjXlW7B6G2t+Ywt1c/9uo0EYsxPa0FLb6GISgXbELrOE2W8mHH1wRjGcWOTu9wf47owZY5Ve7WooWdv7Zk+idF5/EQOYf9pbCSWUNz9Mx5D18NtQoidx/fMxgbbW13lSAosAkjcxWGitDDdfai2O9MbtlYWl3jv785Axhx+lU/CExLmuKQAaDooaFjup40yH2zfrR6FOTQSeTKTAU7KXQi8ngM3qKPBvX9JVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k+NhpAZetyK2y77M55H50XU3hweW1bJw2k9mNTS57c=;
 b=aapXk/5oiwvoakSibp4zVAjiuumWxpGp00+89DnpB5zUV+p+d58zqtHC9K/jNLPPv4l512db2kvRTLTeBQ9ScUD+cEd7c+FRkNNktZ+lDd3miPObKz167WoaqgIAiJTN+MaRRpV1DTKs5w6QlRpPKUW1suJOwqgnl8gvHjUsvre3M/dP/4TwjE1lcp/4qLNL2qqj/Yu0D//NSKA679mNJK2XPS6NgK9kAiYQGYBr7BNsVFWBdbgGlbS/mGcf+Q8KRq1l/X8j9T3OOfCcNQROJMU16vlLJDK/mRR6SRKPLy8mBGDy9CFdNFkM5PSuo9G3metiJhAgmNlq3JhteVel/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k+NhpAZetyK2y77M55H50XU3hweW1bJw2k9mNTS57c=;
 b=N0Rafj8o8xZwlVcLwqbbcdg150vxVZhoXqMr7kl+V93+P095fdOWINAvIvK6XPnfBnfQ6xUsDKjSSzB1RU76lHDERpSH9xYfSwixYrFr7fiJMDvtxYL94CZC4yUODFD+etpcjOckDMhkGwlOz0jNUVnvrMd8BJhegoVZa9Uu9I4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 18:42:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 18:42:57 +0000
Date: Mon, 3 Jun 2024 14:42:45 -0400
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
Message-ID: <Zl4OpTfcfqMHELiX@lizhi-Precision-Tower-5810>
References: <974f1d23-aba8-432e-85b5-0e4b1c2005e7@arm.com>
 <20240603171921.GA685838@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603171921.GA685838@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eba7151-4530-4ad8-876e-08dc83fcfc70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UfNABQ797ogeQMSFYDIIk/M9XKEVRHKhczle3lLaautoG189Xvrj31/uVY94?=
 =?us-ascii?Q?noAv/BXPgDztIoUYoda8WF/yCqHFgP+MYRnA50TaJPMt0Y9XYx5GHRnE6rU8?=
 =?us-ascii?Q?0Z9GMenJjqef6+HoWz4qBcmBpVdRbpEo3GLnZ0ilZ3Z5iV4BJd7fE7aMKKeE?=
 =?us-ascii?Q?iqE4R8LRsoLWtbfEFy1rn/7KPyu9WrLjFjmi7MTeIB8nNX9pPbJSEfEDlDjw?=
 =?us-ascii?Q?INhuEANWJNJ15NXuVOezrrvg1v8vOW275E4+PH3Qvm/HdkAyXKUpzDkkeGks?=
 =?us-ascii?Q?T7WeGZkLUrG/p3HfHymz3Wwhfqs7oGUy/IZYCEnjHZDnpLfc7o8ScCBvFg6g?=
 =?us-ascii?Q?HSlaOFCewHFgt1+uIJMTQwez8xsOx76lSmIky0UxUqvRjYAXgA7+WuZROi/9?=
 =?us-ascii?Q?LykSp0+essDjLG4ByHszYVUVax+nu8lw19EhUBG40VJ0P50bqL2UgvKkxNmw?=
 =?us-ascii?Q?1QD1IPxDSkS4yggrnPSgi5BhoSsHBJVIc098b2v5pnrF0ifTvGFid40qkdh/?=
 =?us-ascii?Q?dLKS5u8LciqMx+QC2mjAmoTgk0x1MERc98t2C6E7WVYq4LCetcCoLxud+duM?=
 =?us-ascii?Q?E/4b0p9xmcPGMULV1VULtGD1OX9iiJmUlQ96gADLZQHWnecI6TyG7EvD8/mU?=
 =?us-ascii?Q?4Z73s6RbxJE/501+NVATzgTKYLoU1kaSs5wn8Ud2Eiattfn1GH8M14bHm5KY?=
 =?us-ascii?Q?mn2IWjc786Yt5nk/WtNrs6KG6VFXBgu33N8ildt4+xSrR+tEWZuIXuFhADKx?=
 =?us-ascii?Q?zTdqM0vNeZDPDXClq1XFjLCSBED96Nz6Joo1Ci7UrAUoOQiiczcze4XJjQJ6?=
 =?us-ascii?Q?G6fEm/7qOIfz0vd/IgzX9Xh5a4P09JD8peT3g13M69THnk3nZC9Afv/oQGjX?=
 =?us-ascii?Q?djNQQCUoELrvV4+1hRkQQkMFkivc0DD4X4uavOZlPJI5sHQbnhuzs09WgZHU?=
 =?us-ascii?Q?A0JY+4adhOKUCFk70D0UDXv8X0ONH9aLammvz619fJlUQ9rUBb4ip9HsbhV+?=
 =?us-ascii?Q?tl+nOMQN3BN3t/zboZ7iMPmEQZwB0LRDR1NOvka64kYCtAo1yillQsmOMGo4?=
 =?us-ascii?Q?sDkQSzsEgAch5MIR5Op9AKQ0qAezHp2sU8EFoUp+6Cg+4aty/r7p2ge9iaNm?=
 =?us-ascii?Q?C5yOo3r0l0aiqV3UhrhwwpbhPxhKKZJxBGSZ53Cp5uaOmUdx5m9NQyO9XMEK?=
 =?us-ascii?Q?IaH/wY7KCIIX4O2WPIHuRoaZ8wmd5neq7Jfpxzu0on/fuBEMieqcgNTYpoiL?=
 =?us-ascii?Q?E8bm/w17Yb+vpT4O60kG0NHkxTJrOg7hd1dMhlwybP33e3u1mXksUG98uKgo?=
 =?us-ascii?Q?++N2P/OMNXq9LnxfGkvvgHWPSrpNVWhHqgjf34FCxOoWRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TPrN4D8KkBX2nNsAlq38ubSmiiPKkMGoawSg3mJIIar7uwL4ntBeDkj1lE0s?=
 =?us-ascii?Q?/apFyD5jH3bSvUWFuSbogjN3R4fRuPeW0rHVRHbZTb/dvIGPVHJ+Ku1jncWb?=
 =?us-ascii?Q?dh6+7Z7VSuYbmV5Se1vY2Vhl6fe/CRoq3YKirblHoCCb3w2NTqZRrapQnu++?=
 =?us-ascii?Q?6vmcgV0gI35JF+PdUJYK5Vmbt/r2XKY/19W8IuX0h5GtmufhV4daVxYFxq9p?=
 =?us-ascii?Q?nkm1onANUBtCTtXH1hBJKDSa3V8SZkEIS0MsSrudJoVgfgaKA1FfkPK3ZZL5?=
 =?us-ascii?Q?f4gH61tInqpk1v+A3K0FSei8wuIFpoLHZYVeJiySUWnIEaKzNAjOltzI/aOd?=
 =?us-ascii?Q?mm84pD1RArH71fW6mQCdee7bsUZxHMfjt2rF2SgbQig3cK6QSqJCQ7UXhUy/?=
 =?us-ascii?Q?0eDcOb/1s2COL5rzDzaNDJZDS+oNhxDE36EwVo3p61JCFsNyIoCgofFUCpxw?=
 =?us-ascii?Q?JWuggrZk6QU97wKngvsUHyHL4sPWG64iSAhB4FEtr7GKPpebLNHBl1JCrTfx?=
 =?us-ascii?Q?hNDauNQHxlLwirRdAzUZhLTzQS0Z/qupmBUjVOtTZFdajqpnLYheitHD3M8y?=
 =?us-ascii?Q?8r3szVZGlwYVLhTDGLdIuulXZM2URc1LYoLN5yZUCfRHbZtCLQLhPfXGr5/U?=
 =?us-ascii?Q?I3WZtKAN3wOiw6IrezCs30RbLNBk4lfkiAQrZKHvOuJfaiKdJMiVNABiMMRU?=
 =?us-ascii?Q?Hx2Anb3dz+eyFegpcpG39m+XbZPir1b/snCIL95AdckOvTXHUItfrf9/JKhy?=
 =?us-ascii?Q?lrbeqvo7zQtaAhnza8WXcrXrLIYMptletXEnuK0CCZKGhpJ3qawj3rwcAPF5?=
 =?us-ascii?Q?oxPjS5D6solWAmz3c6fiY6AwqMXgv/01ImGimBJlGsqZcFcSgEM1ve3pr4aF?=
 =?us-ascii?Q?+rNrWIZ/sAC/9ZFsCHXjOIl9ZqK31/1LpkmyVYCdjcEhEO+VHP47CDjVb0St?=
 =?us-ascii?Q?Chkif7clNIqg1q1CfdYWr9H39zO+CunD6OPXzGoyHucIMyeYO2dQiqRful0K?=
 =?us-ascii?Q?HdwnH6jNp4zIf0WSv5sfFUUaaaoZsW83u7qGCZphXEpSgoYMLOWlC9+wNgZ3?=
 =?us-ascii?Q?6W690r5vk4MopvQN5asglFO1jeap3jvYWZ9nEjsV+hsrFA+fVa3VZluNA1md?=
 =?us-ascii?Q?knvAN+SUkuf2vYxRsALNQD72YBSkIzrAl1i3sBdfjfeBfx4R8Edx4fopBnVr?=
 =?us-ascii?Q?1D3Mem8OOUajc3Bqsyd0b57ezYjp0MGDSeuyVi/Y24c+FIsXhzbAgnwJipjb?=
 =?us-ascii?Q?ytW1xPc5uknpiBl4Y/gvgf35l3RlD9aUoYd8VLhsqWsbiM8c7ADXhweYfRj/?=
 =?us-ascii?Q?RDXxqLcLpPIkl6B0r8oPbzZR92vFlBWpO6kZQJ1cWm535JmR+XCg0OSPNJT5?=
 =?us-ascii?Q?AC1irmKMgjsZ6sHzECX1f7WqPysG8Fgu9pZ0CP6ZVJOc95FojfUz69vUEId8?=
 =?us-ascii?Q?xZc4q3ic1VFFIaK5DvJ5t+n5mYlRVYvAASEVnzG7tPM3i3aWt3G76B8TyWrH?=
 =?us-ascii?Q?Kejk2P81DsWYzrOieX/loSESTlNNZPZZqcDUXq+xp6xDhsixMM7jEIgeyYA5?=
 =?us-ascii?Q?byqh2OVbFhmvIaz4c8pU7BBEXOo8RgYtany5xtxQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eba7151-4530-4ad8-876e-08dc83fcfc70
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 18:42:57.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hY8GjeCgk7GT2QSi6/R2KfeTrpzVmOuxc+giZA+PCOndobHYVB5o6TCW+uqzlv5cxUgRLPJA7ctrTGdVKqEOTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119

On Mon, Jun 03, 2024 at 12:19:21PM -0500, Bjorn Helgaas wrote:
> On Fri, May 31, 2024 at 03:58:49PM +0100, Robin Murphy wrote:
> > On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> > > [+cc IOMMU and pcie-apple.c folks for comment]
> > > 
> > > On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > > This involves examining the msi-map and smmu-map to ensure consistent
> > > > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > > > registers are configured. In the absence of an msi-map, the built-in MSI
> > > > controller is utilized as a fallback.
> > > > 
> > > > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > > > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > > > controller. This function configures the correct LUT based on Device Tree
> > > > Settings (DTS).
> > > 
> > > This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> > > have to do this, I wish it were *more* similar, i.e., copy the
> > > function names, bitmap tracking, code structure, etc.
> > > 
> > > I don't really know how stream IDs work, but I assume they are used on
> > > most or all arm64 platforms, so I'm a little surprised that of all the
> > > PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> > > this notifier.
> > 
> > This is one of those things that's mostly at the mercy of the PCIe root
> > complex implementation. Typically the SMMU StreamID and/or GIC ITS DeviceID
> > is derived directly from the PCI RID, sometimes with additional high-order
> > bits hard-wired to disambiguate PCI segments. I believe this RID-translation
> > LUT is a particular feature of the the Synopsys IP - I know there's also one
> > on the NXP Layerscape platforms, but on those it's programmed by the
> > bootloader, which also generates the appropriate "msi-map" and "iommu-map"
> > properties to match. Ideally that's what i.MX should do as well, but hey.
> 
> Maybe this RID-translation is a feature of i.MX, not of Synopsys?  I
> see that the LUT CSR accesses use IMX95_* definitions.

Yes, it convert 16bit RID to 6bit stream id.

> 
> > If it's really necessary to do this programming from Linux, then there's
> > still no point in it being dynamic - the mappings cannot ever change, since
> > the rest of the kernel believes that what the DT said at boot time was
> > already a property of the hardware. It would be a lot more logical, and
> > likely simpler, for the driver to just read the relevant map property and
> > program the entire LUT to match, all in one go at controller probe time.
> > Rather like what's already commonly done with the parsing of "dma-ranges" to
> > program address-translation LUTs for inbound windows.
> > 
> > Plus that would also give a chance of safely dealing with bad DTs specifying
> > invalid ID mappings (by refusing to probe at all). As it is, returning an
> > error from a child's BUS_NOTIFY_ADD_DEVICE does nothing except prevent any
> > further notifiers from running at that point - the device will still be
> > added, allowed to bind a driver, and able to start sending DMA/MSI traffic
> > without the controller being correctly programmed, which at best won't work
> > and at worst may break the whole system.
> 
> Frank, could the imx LUT be programmed once at boot-time instead of at
> device-add time?  I'm guessing maybe not because apparently there is a
> risk of running out of LUT entries?

It is not good idea to depend on boot loader so much. Some hot plug devics
(SD7.0) may plug after system boot. Two PCIe instances shared one set
of 6bits stream id (total 64). Assume total 16 assign to two PCIe
controllers. each have 8 stream id. If use uboot assign it static, each
PCIe controller have below 8 devices.  It will be failrue one controller
connect 7, another connect 9. but if dynamtic alloc when devices add, both
controller can work.

Although we have not so much devices now,  this way give us possility to
improve it in future.


> 
> It sounds like the consequences of running out of LUT entries are
> catastrophic, e.g., memory corruption from mis-directed DMA?  If
> that's possible, I think we need to figure out how to prevent the
> device from being used, not just dev_warn() about it.

Yes, but so far, we have not met such problem now. We can improve it when
we really face such problem.

> 
> Bjorn

