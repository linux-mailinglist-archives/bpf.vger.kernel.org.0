Return-Path: <bpf+bounces-31221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150C78D8889
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 20:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94EB61F229CF
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A791384B1;
	Mon,  3 Jun 2024 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ND/jK1fF"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2069.outbound.protection.outlook.com [40.107.8.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126C12F373;
	Mon,  3 Jun 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438906; cv=fail; b=Bx/PjbrFAsa1YwghgDftgJuvfVPVn9YT19pwkkxH/1LgO0dDgbbL9y9l7RJMAuT8eRifYlpQPfncdNQK2uDGpoU6rOAWUToS/iru0mOkRyM6kbCPGC5fz3A6lziF6cnjh6FdZUq30IIkST7ENLbHekf/MDiU83+Rec3grwd6kfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438906; c=relaxed/simple;
	bh=AZfUQDd/BrY+t+8i6oGAnsRqajVLd4dbWiYNkmgn0Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rOD+X0nL8Lvf+pWxTxB3AnM2ZTB87+oT2FOy2PYEsd2hsdTNqkuSlJxbQLOirzlN9CHyk6azK+ph2lBlA4T5kt2K+DCfAZnfAyWmpPQ9WzOpEjXaVwABQ2OlCrKe4q/GlEb8lJgRY9MlegevquwfamLNKED6XloliMitR0WTNeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ND/jK1fF; arc=fail smtp.client-ip=40.107.8.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InVbNEhJujwBfKQvcWB0blCg2Z88UeTO4FTWhttG7ZVq28tpHmnahneL/BHXsTBeA9WCBtkCQWzohmfp7H16Lo1noNuaPb/xaidMj6baxsb3BMmdGuszbDRyh91YLT3SxtEvYHtIoptCh6tktDPTOrRgGcY2yjeht/hYhrxiesgcVtMNpHhUNPTkh+/GFHHVSan0m6jbRpvLzVOs5k9CPDbYmy/041/x0HKA5PIPXftJLW1U1jlHRSlYbAbZd5t60lonKF1W90QemWDPciiElSgXsuopBlmPBul/OOipjyiKQde6AKUGnp4pMfavJ1a5v9cuYmY7v5Gq938hhGu54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH/unmk0dE4FdvzV+F+MMF9nlm977QDqf28l6h2+SnQ=;
 b=i7wuFAw758nER3pFQzA3Y00C3N8UZfohuv/HSAHRLkluEBZhrg6vpBr8L4icDYN3Sb9TmpDJqXcxYbvElj0WofbuxLs0Ko7o6oWWIuBlre3bC3NlLZHfayQbUFJi4AqmLmuRNm0tyBTMp0DYsddv/WgJX4LJn0057fMWMSxZwxTTUiXFSR+NICYCrZvKta2Gh+Kz3gn5wl//xgNIn+dbmLVhdbZgXIZEaOEbxsf05c4mStPwD7az8TJsTmUvQWagTTdA0mkqZfkH31nU7A6QKvk/QHEGn9mc/d7i2HvjuDGP+PGUXHtNWazgaGKYFVpP1IKOu9uL3t8FAy+mugPzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH/unmk0dE4FdvzV+F+MMF9nlm977QDqf28l6h2+SnQ=;
 b=ND/jK1fF5Rf2hdoGKd+gzdwrMrlUBpkBJbwEphrmmccBap2Skgon7sAv82t1yRvJ605a2VtfPqj4KMRfp35UnoafYz2l7KXnLgDZUDkubvEjXesQRcQDvS6xddhGm0p4fxhvye2yita5dOPJMRSfH6JWjckO+9sWPaKZFR736v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10704.eurprd04.prod.outlook.com (2603:10a6:150:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 18:21:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 18:21:39 +0000
Date: Mon, 3 Jun 2024 14:21:27 -0400
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
Message-ID: <Zl4Jp7YWDHyFSax4@lizhi-Precision-Tower-5810>
References: <Zln3WkiHC3AUPocL@lizhi-Precision-Tower-5810>
 <20240603171149.GA685507@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603171149.GA685507@bhelgaas>
X-ClientProxiedBy: BY5PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10704:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8ff925-b581-4d94-b270-08dc83fa02fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+H2o8+BumgBL2kecaNIgXLszu9w7HedOX0uoXYsXmkufY1urM3cqPwMm4zo?=
 =?us-ascii?Q?MFBbMGXtD/AjCpObJxuMF9N4J2oC1UeikY0cxNxRff2/yjv/KWpgF+ThKVgs?=
 =?us-ascii?Q?gM+gnJ9+8CGlsuF+Rqxg623xAawsdq792M6y9vvcZgc2B7LGcgS7gYsF6tjg?=
 =?us-ascii?Q?VUP9DfVaWe+dnzu3SNgGgkkaaken6V6qQw7dX2m28B8n3iidnFjxf+BrLA8r?=
 =?us-ascii?Q?ChfzmR+eWm9cK8eve0qSjGC+hpQg7/HUDwgTCkiItdErdnZ/x+cLEnn9MXAt?=
 =?us-ascii?Q?h+6MnlAQr4IWwXf05Zni9w7g7GeY+kG0N4hdX3Ip3JDeyrwBBQEcGdCfRC+C?=
 =?us-ascii?Q?dza44VdwK8L++Hm5+f9QBkK7PXqeOey29zfLOhtTHak/njSRLtKZdQL3fF8B?=
 =?us-ascii?Q?Dh2YVGIzcF4dqKpvQ/yLrJ3006eDbibjKu5KVaIB29nCph82lJD5npWDZ65x?=
 =?us-ascii?Q?6lBEBBWI3kD1dqFwOXjb0ju0+R2LZHKyYZ1riq/rc/0u9P73SuJpDu97N4ja?=
 =?us-ascii?Q?6qdnwJcHR95lvBawdcdqK9JPbwMfQ5OJO+K4QjrVPJUZJlr0w6fdP6vvHu1J?=
 =?us-ascii?Q?em3RpSDu5uWDr0l60cQljkMY0f+GdF1d7XDJuqsW4OBLBbLsqbaBGyFDyV2a?=
 =?us-ascii?Q?Er1vL9CELgLYrMeaPk6ry885ZwEo8C77DF88gqExbYj4yGpLsWXFjXrkgVvA?=
 =?us-ascii?Q?0pSxVnNM9zlRp26LzJZseM+5G3j3R4Dfi+2ZezUvO3/ac0dbm+V9yGCZ+dr2?=
 =?us-ascii?Q?nbM9wsLub1tHszn4avpJAMWUXkdlIlgNJKFFVh00t/uFLD9WmxD7MNy3v8/9?=
 =?us-ascii?Q?sEh96O8WgbiF6XTEErZ+d4AZMIRJ+vI8OxQS+zBPClaINrUoEl/9ab0NC7tv?=
 =?us-ascii?Q?zpVYq0OKRS3dQvvxO4x/xZWM7WY8O0iPSEKLrCIwrEXwIsiXN2pJcyVP00Sd?=
 =?us-ascii?Q?vNeyGvqMrZwwv10jjGQwNfyG4eCKWpw9BJyR8MGKFYkwcyg5U/rDMqwCoFeN?=
 =?us-ascii?Q?npSUT34Iwlp0jg2dUGlpWNkY8RnMcQdfsAGPdJtvID3o5XMDAl8xq907qixH?=
 =?us-ascii?Q?TRtc8rkq7LNCiedxQCQcf1BiMMzCtmhzSfcwiewbMjYnnsQuHCJss+AvIBQv?=
 =?us-ascii?Q?OOjwWDqdhrTb07agmERZ+B8Kxg5aTaiHAXRZjGiWKHta/aOspla0lqV89J+a?=
 =?us-ascii?Q?5VYhHtDxeulInjnQjjSRR5PHG6Id//fpgaU5Fo+l40031gnxfMu3bIW2jezw?=
 =?us-ascii?Q?ahHlg9/phPLTyKKLNZ2a6h5A9E7JBbv9OGAoIRA9BvjsPJnbTVYpeOYGuzoE?=
 =?us-ascii?Q?yX8lUJm9XaJU6efm64Vzoj9uGUEeUCAdBp1i0uW5fFSIdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w3HmdY6mb5gI2qrctTIBUVTwYGYBQG/Kl0l0iAF2zG9tAB5nN5idYoZGLQy3?=
 =?us-ascii?Q?75P+ZMXST9WmzNQm6d9zq2BEELInQT2u/p5ndht37gm6PooudOteMM1jCUgL?=
 =?us-ascii?Q?JbOnA0Xib9lgfOgys9OUZTnrw1NlUPv56+OIrVo4MMxRoQcG0pc/YFJfHx+M?=
 =?us-ascii?Q?5+T7TE5caL4qEEAC2+wYm75HSQZlYqVT20sE+m4UYlfhCnOXqgBtSP4BL4FB?=
 =?us-ascii?Q?Kz5TkQKZlNvfiRpJkgEE6xb08rWnPkEPWtPQ8MOJxCNPv3wyelZctBBBi1x9?=
 =?us-ascii?Q?8gF2Nc+7mEt1zFbfmx4TNf61ILdsv2NCJUq0rQFHJiejCvrptAyc/zRQ2Sin?=
 =?us-ascii?Q?v18hU7nHSUvkiM9uNc+sxvh9StjU1I72DL+65ObkMPFmhKltk5CzyAcHGBdw?=
 =?us-ascii?Q?GapVDZY9C4K+eAYHB159F+aMUkCwQYjaH9B2Rly7lOkYo3/1qjVHquVRm7Vn?=
 =?us-ascii?Q?UkQdFTDwCpwcxmxorLyZv2RPob2BzBcP0erwAhj7nTz6S2GVKD966y77cxgi?=
 =?us-ascii?Q?CbxZOkKgItKeiYYwi6yaIidOasUYaXwncAcq0jt6xlj2a0tINy1EPDXdNsvo?=
 =?us-ascii?Q?3ZFKkRX2Zb44UWUG7hEkxkR/emQduz0VQSX4edCG7gnc1keOFVdOn5ss90/y?=
 =?us-ascii?Q?xP4zBulk5QzaNm3hWFAn4KvWUUa4F/7GpqvqmnSXYdxd7+EXBldlfVSD8h0h?=
 =?us-ascii?Q?mSSQkZAYEcSFSqiOzzbMa/S5Nszo/ex/UYrZMAIAzqXWvrvk0ZY9ioPsw8eE?=
 =?us-ascii?Q?2Hjq0LkOunOb3ydEXMRtWSkoxL8y2TgVtoIjSh21+jlS69idvtWBNlFJ5FBN?=
 =?us-ascii?Q?ENsjECuP39NOBuAE9+K2flBXkba8/Ktt5PwJALwSyoICKlFUZ9LG6MrXcWOy?=
 =?us-ascii?Q?HO8Fd/keax1FWk4uD6hQuOqAQ7LShD/BxynHO3AeUEOdMWhRzIYIaVHREZK9?=
 =?us-ascii?Q?shrS7pVpPyJG09yuK1BPwRUPGLBHeOnCG2MdQvY9962+BViAkwrycIfa6n/X?=
 =?us-ascii?Q?7nJoXEbkHjHAbqX7lK/aXipvZimHt6ruyO6/5sf5fszgoZYG+BZ5sYG51ft9?=
 =?us-ascii?Q?vZW0tLmAvwks/timUrASaOfuHStvxIvrpPHiftuDMJ/+hbw3il0/IKhSZ9f0?=
 =?us-ascii?Q?rgb/7qzccXpnfICX65W1Oa1AB4GFDwP09CzwDFkWtG+4vKcDpB1WAQsm3yTa?=
 =?us-ascii?Q?At+sJOqKUUrU64fxWexSuRXkvCO3zm8YILeTGgbBECuCFpddY9wDwp7RavTj?=
 =?us-ascii?Q?uHTr0qLP9h5/9LrGV2bSTWQJ/+IpI49VXPHgkShHbXjrfoN9K20+f/D4A1pg?=
 =?us-ascii?Q?SfyyOyCvBNafxkCtwCOf5yGHwttMkj8+YNxW7jOWy6dFyw5TpU59IIh6uI7a?=
 =?us-ascii?Q?y2AxrJpFpdhjeTZ+Mc1tmSJOPpLHT3G1F7+4mI/SLzY6vRjINr/1uTx+R6PF?=
 =?us-ascii?Q?6LKp7UbiTkE7/qpu5gvlaZOtN/4jv4Zm6B1UcegnbOHnnIg0d04h+RvK95SH?=
 =?us-ascii?Q?OyLwjJzYXicdc/B7g3TkDmL7buJRXmu6tOmCZEGY8J6qaChSd2LIGqNgPMoe?=
 =?us-ascii?Q?89aZs9M4ssBJ12ols22NeiqYpaTaHKweiyBck8Yv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8ff925-b581-4d94-b270-08dc83fa02fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 18:21:39.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NitoS2m/LAgumKsmc0OGJrGWip0EfonmBY4fkmjadqv6L4oLH1VkBrqOOb56ueqjf0udhO0kXzUC6uh5dZMong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10704

On Mon, Jun 03, 2024 at 12:11:49PM -0500, Bjorn Helgaas wrote:
> On Fri, May 31, 2024 at 12:14:18PM -0400, Frank Li wrote:
> > On Thu, May 30, 2024 at 06:08:32PM -0500, Bjorn Helgaas wrote:
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
> > 
> > Actually, I refer apple_pcie_bus_notifier(). I can't direct use apple's
> > implement because in imx95 have difference PCI host controller, another one
> > is PCI ECAM netc controller. At lease function name should be similar with
> > apple. 
> 
> I know it's different hardware, so obviously it can't be exactly the
> same.  These are the differences that looked possibly unnecessary:
> 
>   - registering from initcall instead of .probe():
> 
>       apple_pcie_probe                  # .probe() method
>         bus_register_notifier(&pci_bus_type, &apple_pcie_nb)
> 
>       imx_pcie_init                     # device_initcall()
>         bus_register_notifier(&pci_bus_type, &imx_pcie_nb)

Maybe apple only one PCIe controller with multi ports. One nb just register
once.

If there are multi PCIe controller instance, second bus_register_notifier()
report error.

Of course, if you like, I can use global reference counter to handle this.

> 
>   - naming BUS_NOTIFY_DEL_DEVICE function:
> 
>       apple_pcie_release_device()
>       imx_pcie_del_device()

Okay, I can change to release_device().

> 
>   - tracking entries in use via bitmap vs scanning hardware for
>     invalid entries:
> 
>       bitmap_find_free_region           # apple
> 
>       imx_pcie_config_lut               # imx
>         for (i = 0; i < IMX95_MAX_LUT; i++)
>           regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1)
>           if (data1 & IMX95_PE0_LUT_VLD)
>             continue

Okay, I can change to use bitmap.

> 
> When we fix a bug in one driver, it's easier to check whether other
> drivers also need the fix if they use the same structure and names.
> 
> Bjorn

