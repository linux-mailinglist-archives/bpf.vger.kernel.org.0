Return-Path: <bpf+bounces-40871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91398F8B3
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 23:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1AD1F221F9
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 21:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A71E1BFDFC;
	Thu,  3 Oct 2024 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JABzhNSe"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395E1B85F3;
	Thu,  3 Oct 2024 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989977; cv=fail; b=GLPyPWZxTUWlwhFOCerNK2bsiKucNZ1S62B4YDeawWPtXNErAd6o+xjKT/Com2SnP5iqEF6oA2QOyi5kndYvThm1Ij7p8Jx3wnHnjuV8yiVuujy5WWWtHqWFsX+3bq9olSdkIQRrI/6558bgQ/eLyTt5Fw/Em2KsMfFYkMmRM0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989977; c=relaxed/simple;
	bh=18U3XrrdiMz9Dv2b7XwE1IgL9Cj1tQg3O0pgzAMIbzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n9yEW+AIszNK9Y4Vo4rsHPi8Vrpm5WjKIusrr4rYex64ZksmjKa9SKU4KcDK+Tgy34VIzl0S+cfAzbU/hP+UF9cBVB+sb+98V0HTjKWY7mBBtX0PMLHVkzPwWTTvKeRecCvdq1asEp6tk0KUrLteiG1y87AdItM2xlqpSfpu5pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JABzhNSe; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/emwT1IgvrDnmameXbUtM8MCbq+SiRMx7GwkeJhIbmrPx/kKjKQTVGhhGhCJ49JtYsa3lV1kZLqV8uxqWtbKYDTd3De8U83+iWe1ZZLoFABuMTRRM6MbAsBSXVXhFIWAzErKTqqFjz5UiusDkNEdMJUsnuBqVyGl+48l4XvKEqQOmfhWGGaWzV3DGpksjHAPSw5VX5NBheizXPJK2XHFtuS/RCixC3X292OKShE4rY1oprGtWfxeEHLQPd6kYsFpGCJNYO7VVl670LtB8+7noH4w8/QGBbPAck5IUa5k2HoeSlzl2EYCP+2ANvmh+lm0rTrbxDHUW44V5Xd3INeaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+IlFSFIqNRKkimcuRBIfOgXfFUBgdpYyvYItQbD6rE=;
 b=Df9vO7QrBAYQ33pDdWqmHq07FuTDQaUMSLy2c6esiJEiSih5HCN4KQ3yWCwp9FEAOGiG2M7rDiSnB3bCrlDFYNvxRCtf0lx+ePNfcVOjZEisuY0+gnUgz/Z25+U2YsIJIlcPVgu8LJlc+qELcRJV6U1mi7/3yyt0nIaYk3VYmsIaaF2sp6o0fKLVXvp4RhmDVW0fNydQDBa2WUKVAT0EJsKqmOEa0YDSh/Q4vya+iYnp6sHRAHw2b8XJh91WMGLy+ELBrmWRO3igKp8bdRaKXVC9qYrSBWGGjl4ic6NPhuc5PebyP6xJlDVZBXLi/WGPr1CcckJXl+n0WEcdKjfQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+IlFSFIqNRKkimcuRBIfOgXfFUBgdpYyvYItQbD6rE=;
 b=JABzhNSeZKahT1lKjROB0K5FL4NRS/BTLhZrpdQ2m0VlXyAaQ7d1dHn78yLDpb9T9YcbwDwbLULLgfY3VNyTfhwodoDqWd1I/c2lBQJxJNzs+8m/2Q+rB674m4ABq4YBJ53YUQ9kVNUNdde9aA2Dv0/CZwuKyu7NvbEDuZ5vh2MTIFqHG/UJOxzuHcMTBxATlFkYIWJKRvN5/eJKAXlDnj4cXhz3BdK7HntW87TWmNocPldZcnxCZbnvP+qCAjvwNksCjCsHWhunRcImDkj7aKL+X1HYpVT5DNAPJGKVLn5k5rGU+/zr+J17Jnn/Criu+8ptb/FLWqJ8JRXrEw86qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9737.eurprd04.prod.outlook.com (2603:10a6:800:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 21:12:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 21:12:38 +0000
Date: Thu, 3 Oct 2024 17:12:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	N Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	will@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <Zv8IviyeSDf7HtbG@lizhi-Precision-Tower-5810>
References: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
 <20240930-imx95_lut-v2-2-3b6467ba539a@nxp.com>
 <b479cad6-e0c5-48fb-bb8f-a70f7582cfd5@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b479cad6-e0c5-48fb-bb8f-a70f7582cfd5@arm.com>
X-ClientProxiedBy: SN4PR0501CA0054.namprd05.prod.outlook.com
 (2603:10b6:803:41::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 435ba735-6d3b-42cd-b256-08dce3f01bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3tKZGdP75s9yz+Z5P4vjijBm/ecJSyAjiJZ/rH5wI/83r8vbRsfFF2zzIA9L?=
 =?us-ascii?Q?eKfxQCQYs7BdlnbzNmgTK/JtSQKSDA3N5cOJs4vXDEVF57UV+DJIc9nx50di?=
 =?us-ascii?Q?uKeHd3BUrsjKptrezm52ONBPeGCLDDxGP5GKVz2r0zXdqT36mPW50NY3jt6e?=
 =?us-ascii?Q?6mC41HMLaQpZuBlsDv1HNlKnQrHZw+1tgeYIumEJ1Z4ZhqfY431vmNR4nF/V?=
 =?us-ascii?Q?QKgM+0x/ZU5Z5ldqOWUva6gwrWs6DQWbz91NNqhKEn/ixfkdxX6n+NPUtNy0?=
 =?us-ascii?Q?NQNjcZs1/CVNVP3c1Xzp3oKrSyK1TIDf1VTxWuazBQf+Ikkq5n9+gGdAwBJO?=
 =?us-ascii?Q?mEL6J6Oo9iRvwPlw6c/6d+kCv+oroG8UUukDFLi3xcB6Vn1vXcxXchyCCKrp?=
 =?us-ascii?Q?n9H7587wKe4ptIH444V0ZuZUUPJ7uNYNyZmb9J/a0zl/bwihZjECzvQZw5xq?=
 =?us-ascii?Q?MuGhBOWmmt3RsAiWR71pDbfgOhhhUHFdpItiUM2R2VqFzcDSfmYytF+IrdGZ?=
 =?us-ascii?Q?+PrQCXAU8I2tS3mBqJ+EBL5q9mNJD4f4uk6r2D4zCFJIKK2U6nq9Ny1VtQRu?=
 =?us-ascii?Q?J8XS5DhRUzH7IjvzGKAKXKC6OBRAIXwn8Ezeolrov9sfDSuxvRIgGZS8Lh/u?=
 =?us-ascii?Q?PuKOHjIVlB4PdH/gfZeAXRhqCfvp1YiOAVJG6wBEHKZcnVzo++vtCpbUhzMm?=
 =?us-ascii?Q?TpKtu+nr4N1EELnIuAbF4nS1Ftz2g/TmTkbOl4ZNVRkOZ1fbHuq1AFFOSGDS?=
 =?us-ascii?Q?YdkaZzWegAfGCDw7GaS1Wnhth6YJEkQku4N2mYA/EBQ3AjnE2IzTeMDSANH7?=
 =?us-ascii?Q?34L25WiQj7nz34uxFyLECNhf/8drUx6gW3p7IQwWP8OS3oovbOMkJOrV95yo?=
 =?us-ascii?Q?UiviW+IBXsa49fGQ++Q2vvAzwA+H/RaFssVYpBJQcNjNGinOrGiUeQvkVAtp?=
 =?us-ascii?Q?2020qtBCr+OBx4UduuXAJP9ofrOrTj8BB4TLgjJeaAcdRFXp0hohFex2MWxr?=
 =?us-ascii?Q?4rR4oAuZfckL31NSay/QVShtLEgm4E9QS/MNnIqI3iKTsnrjtJgmA3o47l95?=
 =?us-ascii?Q?05502eR1T64kO1+2rGHPPSNhhhehNjPyMjaVlN5CkLKoGJXeq8i2G3W6an8B?=
 =?us-ascii?Q?0nuZMVPsBH22exFX1ntIxZRokaYqEzJKxMvH/7lSfehtxm+OYLNKCoTihntC?=
 =?us-ascii?Q?uLJxS0g1izKt9jHQNQcd/PGwiZWcX7bvsGjqnFTYJWfHnYwcPq9+9e1oWHbE?=
 =?us-ascii?Q?Zp5N/G3twkiW190rp0zu2Bck8RM0+VXO0AsP9Kc2N5qySA0oqqH1acwfmyIS?=
 =?us-ascii?Q?KppkNXdtDKhY/iYSW82nVKSMlIfKfQ2oekhahXNChBcR1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D097Ej0xUFIxe5wqJ9XgFCHdkEMHQYdWo/vS9FAL2mJ94hwdCbDFz1yFkrVA?=
 =?us-ascii?Q?R9274m9ycTkoPtlGTTEUw2Q6ur6u4kRPHvaOhXzlzCXp6OPDAY6h4EJItuXz?=
 =?us-ascii?Q?KOTXzYgVcW69c6TYZiXmvGUhQmSfMiVyduJRCm33WIGuGuddj/o+M3DFooNv?=
 =?us-ascii?Q?wpsEd6JfjxcPExoe504pUoxw488OYhfp+ivLcOgnXGnq8uM8WSpeC+eb+B0/?=
 =?us-ascii?Q?xVBKLvymxVkMaj77KWTha2eDDlDhHiIlnSe/ark2LNWVBuQ0/Btj1jC0DbWI?=
 =?us-ascii?Q?tQjAyAcq2VEc56Koak5+HlfoLIgZYvB4VwktpRDq48wdLM7Fh4M/Zns1R7k7?=
 =?us-ascii?Q?tDxIowtHXM3Hg2i3qQygY2r7wcFuaMbIfF5HqgD2TrIqmWtIthF6eQyVwUs/?=
 =?us-ascii?Q?GF20eg680twhuRBvnrDf32QaZDaWKfvPCxd/QyvFsBYuDpQs7C+VQBafI9r9?=
 =?us-ascii?Q?Mmo3SL/YE7/Ax3ctJ+ipDKUpTdvUSbwzgWwk5nOrWG1FZc56uqrb2NAbJeYN?=
 =?us-ascii?Q?h4JsfXyQa7ED2xPAUUzFqlj7SOIxkewy5kBt2dFhTuiwzVb5PTwFQhKomY6A?=
 =?us-ascii?Q?Z8Yy9ZebSXE9hmonBf2AH2wFKkx5kwEDmHqjQr2kbdjT96qeFj1WYa67zFBp?=
 =?us-ascii?Q?VPH3HfYi2JBHQM0Y6IY3WWbbvW63JkSSTVx9Sr5Evq8RHiAjkYbX98ZP08q2?=
 =?us-ascii?Q?PquVy7EWyNgveog1NRSo8M80y0dciKppTvMwBnCCr9csc2MHT7iuZohM276u?=
 =?us-ascii?Q?FnOeH4lsc8w4U2Nj8YhMmQyk3P2dXu+xzQ9uVJoR9RlZv/t+IutNAXOxSSlH?=
 =?us-ascii?Q?bf43CjKn/CXWpoWL0s0NDSsg/Xq2dS44Xra551ny7FDJpyDtllkpi1K+x8fK?=
 =?us-ascii?Q?WEIxP4bQlQFICgUoEgX/nDGzCVipBBXNcX2SuHp+Ox4/vyuJg2EGeaxH6+rH?=
 =?us-ascii?Q?aNj184XIqVlRIx87ItyD83xl2yBOALes1Kb6MbvUGxtMdV4Xe7XbKGYzom8O?=
 =?us-ascii?Q?zKrFVk+1EoropST3reyzJGZATdGgt6Hxcs+QfymHwk+WDHs+Q5w8nFdyC48M?=
 =?us-ascii?Q?xys2NnvvVDCDY/F9b8BA6K8WUDLnxYKlBzwrA+S57zSL4k4iY+Zn4CaJT4EI?=
 =?us-ascii?Q?ww1oLHeGT8uftS0rt6NbuhLg9sne56rIeg0/XX5IZlPJcEjKmR6zYb4Dw/lJ?=
 =?us-ascii?Q?IWPmSTq4SQgYWbQc3lCqqutaxx7ShZG+M1m/1DraUQATvmUMpk2MSauSCS/l?=
 =?us-ascii?Q?tK81nP9tQrCn+n/ZQE9sB6QRZnETQs9GMomfC16BeCqHbr9pPnMv+nC0k14u?=
 =?us-ascii?Q?axxi+cs2rL49w4D0xKwRJNY8lcT52iVdK/w/6qgOMo3vcEuupS9RRSUr8DmX?=
 =?us-ascii?Q?K0cVOC9sd/B9OPT8ABOTnsBZF5fFS3NjC2FNPNkpGJoP6A3CZGkkK856nssK?=
 =?us-ascii?Q?DJAphgNINIdcFSI5F6MhMrlKNkyeAD5FxNbIodCp6YBW0wa+mdgcPmx8j/Mu?=
 =?us-ascii?Q?PBsXGZEub0sRkoswJz8gS04KUTpq2R1oEvXFsvQTNboKOr14+2KzCi8woRCK?=
 =?us-ascii?Q?p5dNFkaMmDa2RaYO5D8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435ba735-6d3b-42cd-b256-08dce3f01bdc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:12:38.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7amQv9ewC0FbI/PlKuuqhFnE8gs/Jn1YcnSvuwvfhQblEJvlC001QCV665Qf3gNPs3SDCBWxWpiU1anKQjWaaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9737

On Thu, Oct 03, 2024 at 12:16:42PM +0100, Robin Murphy wrote:
> On 2024-09-30 8:42 pm, Frank Li wrote:
> > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > This involves examining the msi-map and smmu-map to ensure consistent
> > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > registers are configured. In the absence of an msi-map, the built-in MSI
> > controller is utilized as a fallback.
> >
> > Additionally, register a PCI bus callback function enable_device() and
> > disable_device() to config LUT when enable a new PCI device.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v1 to v2
> > - set callback to pci_host_bridge instead pci->ops.
> > ---
> >   drivers/pci/controller/dwc/pci-imx6.c | 133 +++++++++++++++++++++++++++++++++-
> >   1 file changed, 132 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 94f3411352bf0..29186058ba256 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -55,6 +55,22 @@
> >   #define IMX95_PE0_GEN_CTRL_3			0x1058
> >   #define IMX95_PCIE_LTSSM_EN			BIT(0)
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
> >   #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
> >   enum imx_pcie_variants {
> > @@ -82,6 +98,7 @@ enum imx_pcie_variants {
> >   #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> >   #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
> >   #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> > +#define IMX_PCIE_FLAG_HAS_LUT			BIT(8)
> >   #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
> > @@ -134,6 +151,7 @@ struct imx_pcie {
> >   	struct device		*pd_pcie_phy;
> >   	struct phy		*phy;
> >   	const struct imx_pcie_drvdata *drvdata;
> > +	struct mutex		lock;
> >   };
> >   /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > @@ -925,6 +943,111 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
> >   	imx_pcie_ltssm_disable(dev);
> >   }
> > +static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)
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
>
> Maybe check if an existing entry already exists for the given RID?
>
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
>
> ...plus then you could safely return early here.
>
> > +		}
> > +	}
> > +}
> > +
> > +static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> > +{
> > +	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
> > +	struct imx_pcie *imx_pcie;
> > +	struct device *dev;
> > +	int err;
> > +
> > +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> > +	dev = imx_pcie->pci->dev;
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
>
> Perhaps it is reasonable to assume that i.MX95 will never have SMMU/ITS
> mappings for low-numbered devices on bus 0, but in general this isn't very
> robust, and either way it's certainly not all that clear at first glance
> what assmuption is actually being made here. If it's significant whether a
> mapping actually exists or not for the given ID then you should really use
> the "target" argument of of_map_id() to determine that.


let me do more research on this.
The key part is patch 1.

Frank

>
> > +		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
> > +			dev_err(dev, "its and iommu stream id miss match, please check dts file\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +	/* if iommu-map is not existed then use msi-map's stream id*/
> > +	if (sid_i == rid)
> > +		sid_i = sid_m;
> > +
> > +	sid_i &= IMX95_SID_MASK;
>
> AFAICS this means that:
> a) the check in imx_pcie_add_lut() is useless, since if a mapping had an
> output ID larger than 63, then we've now just silently truncated the LUT
> entry to not match what the SMMU/ITS will still expect.
> b) if no mapping existed, then we're going to needlessly allocate a LUT
> entry anyway since the truncated RID now won't match the original.

You are right. It is my mistake.

>
> > +
> > +	if (sid_i != rid)
> > +		return imx_pcie_add_lut(imx_pcie, rid, sid_i);
> > +
> > +	/* Use dwc built-in MSI controller */
>
> This comment seems out of place - how does returning 0 from here vs.
> returning 0 from imx_pcie_add_lut() achieve that? I don't see any obvious
> way for the LUT programming to influence the IRQ subsystem here :/

If msi-map is not existed. sid_i will equal to rid. imx_pcie_add_lut()
will be skipped. PCI controller still fallback to the dwc built-in's MSI
controller.

msi-map        iommu-map
Y                  Y            ITS + SMMU, require the same sid
Y                  N            ITS
N                  Y            DWC MSI Ctrl + SMMU
N                  N            DWC MSI Ctrl. (current upstream state)

Return 0 here, it is N-N case.

>
> Thanks,
> Robin.
>
> > +	return 0;
> > +}
> > +
> > +static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> > +{
> > +	struct imx_pcie *imx_pcie;
> > +
> > +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> > +	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
> > +}
> > +
> >   static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >   {
> >   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -941,6 +1064,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >   		}
> >   	}
> > +	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
> > +		pp->bridge->enable_device = imx_pcie_enable_device;
> > +		pp->bridge->disable_device = imx_pcie_disable_device;
> > +	}
> > +
> >   	imx_pcie_assert_core_reset(imx_pcie);
> >   	if (imx_pcie->drvdata->init_phy)
> > @@ -1292,6 +1420,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >   	imx_pcie->pci = pci;
> >   	imx_pcie->drvdata = of_device_get_match_data(dev);
> > +	mutex_init(&imx_pcie->lock);
> > +
> >   	/* Find the PHY if one is defined, only imx7d uses it */
> >   	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> >   	if (np) {
> > @@ -1587,7 +1717,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >   	},
> >   	[IMX95] = {
> >   		.variant = IMX95,
> > -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> > +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> > +			 IMX_PCIE_FLAG_HAS_LUT,
> >   		.clk_names = imx8mq_clks,
> >   		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> >   		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> >
>

