Return-Path: <bpf+bounces-39626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3F59756D6
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9701F21B1E
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517DF1AC434;
	Wed, 11 Sep 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NgSGjmWG"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F981ABEDB;
	Wed, 11 Sep 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067989; cv=fail; b=GRqj/r9uvcOnGdwD1MCR0upj7ASiaVtlZOZRkMgPFq9iEAqGe+W2QDjgEwa7wLUGEDW4J0oetJku7nx0onhgAjMKlrbwe/idA5rq4AYlWwkKsXNU0v9ox9AA1ZWmcYP7F+CbWAHnE2VoTnenGpUCwsTYyzE3xAHQw2DBKg4pjo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067989; c=relaxed/simple;
	bh=VZe7tSJz3zhZMcpLydWKpu7yNZql2od2rK8/4K+Yiwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=drzChqUIDdQnd7dLfSjZbc80BVU/XSrU2hPtkk7H10Lpwu8cojBNcp7Kga9WCkpnNVkqmd1nnlftowiTaeLCF/DfhgyVyKW8To5MbckLorJjPT0u84/Sf3hyREzUoBpx7SwxeaE14chqkmcPEqhRu+jgBSJeaFMecKStnoW/72w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NgSGjmWG; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TG6OOamh9OR/4KnJxK+g0cqm0j48HXJYvzd2qs96CZQRxu5mb5rxLxYIu8T3TU8+h5PRZNF3uoXd1EWkuzc3/XQbvMzMsKqs1r02gUZvNSxtExGzdHN6va661SlMQWtC9hiS2Wx47cdmKo4M3VWLifoUkmdXHTIMAjwx3skEgK5QTQ6ZLQuyZpd/3Nc4sB6QpGDRt5oLFMtnedUd2MbSY6GRA2pBoiVd78KizIGTek4D3W7gOM2XZ+9fEJLotfdaxThKNKf51BV/Tf0Ckcq1r4lm7F4ptj9TF8tIulC8e7ZDx63ronxc0d8IO26Vg6DyITJWLi2TWjCUbK2v9w8R5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16+qU5jFdN409qtqiIAP1k6GGj8jaQq8cqF+KhOWz5c=;
 b=DFW+xe8uEHFNiOjmLRTMaHmA8FEBbqpJsdmS+jRmG+PGWljpRMV1t7Z1Y48+tRqQf1u8Do57tLVzFTfBnIgjQFfvv+AB/SJKEvJEiuKIv3+wJreDRioUhrt7yb313Iy/ErRHq6Y9v0BFQSy1kmaBF12L0dExZwUtxSJHEJzAKAWW60OV7yZiVromYK8eKSs06E8RpYBLD+1kAkQLQ1JLqywWUWx4HhyfDhcRJ59dOAhpymqPWbxaIzygoBsebBbKZTb+50q0ioHtndMR6ydneajudbrq7KjWjqpkW/RF8zW33L8o7IlLyQvIy6CtRdDYVSKWULh4IDto2pgwzXcrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16+qU5jFdN409qtqiIAP1k6GGj8jaQq8cqF+KhOWz5c=;
 b=NgSGjmWGc9Pj5mDmTgB2HfFWfH3JB+ysQDRD0nCDdUbvFtM8FO7R9oOB630Ma14VZW4MYI9J3QV5/IXXKpQ2vYAMgPN64CcCEcmtSumYuqXx+WaWBTBIILDdLD+gLcGJG09p6F0L+YMdUGc0DBq41ZD7Mq+SN4tjEq4UvcUvuT0BXRpbvZC8vELTAb75fulEvNstX7EL8HAVWNpa0LP4CU4F2Ozz7JCN5H3u6N8TMed3PRCyPS1v/vsAfuBcpSnn3D9GKzz3DGlgqS7AS2zKMRzJOXDgxJkvBASvheCWUCozIOkP++LsMS/z7dmswsGDZothGkhRvyeGtEnOlY40Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10888.eurprd04.prod.outlook.com (2603:10a6:10:585::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Wed, 11 Sep
 2024 15:19:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 15:19:44 +0000
Date: Wed, 11 Sep 2024 11:19:33 -0400
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
	devicetree@vger.kernel.org, Qianqiang Liu <qianqiang.liu@163.com>
Subject: Re: [PATCH v8 11/11] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Message-ID: <ZuG1BfhQpd9GajNH@lizhi-Precision-Tower-5810>
References: <20240729-pci2_upstream-v8-11-b68ee5ef2b4d@nxp.com>
 <20240911140721.GA630378@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911140721.GA630378@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10888:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc557b1-895b-4b1e-c574-08dcd2752a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MyaJ/esSDWNTjw/qzL5Q8e/DnUjeA96jnxU2zTdYEdMc/CqTEj31mjq6dBVa?=
 =?us-ascii?Q?o7FqJki6ROd54ErE8ebyhp+d8oOUWbMs5zZ/ejdCDkxsPt6mz1un+dQ6uBpy?=
 =?us-ascii?Q?y8d6ugKScxte4v7ONAEMzPvZ464JllBlaJkJdPjYchQlkr0tqiMJQMgKM+A2?=
 =?us-ascii?Q?y1ZjC1sypmOT25k+YqMtlss9hyNo15IjGRJcffW6mSeP40azRB8dkjWeNZcB?=
 =?us-ascii?Q?CKUjeKolA/YzDXiTBxu/OYMHU3l0uT07kvu+LNqmrWUNrSOT7+2YFNFUdI4l?=
 =?us-ascii?Q?0dy6MbnNHx5PQnV1imcHicDK+bxcIWEqC9qZziByqQ9cOkUXx7/T85W3axBn?=
 =?us-ascii?Q?Cwg9XO2Q+gmyXgk13boyx9Bkyb19iV2fr5V7dd5arodUqGbShuiVg7lL1MJS?=
 =?us-ascii?Q?L91Xs0iNPmJerg0R2LqTziQAeDs1sxRhhDSJdZOBu2Rc8DLCMqBhaKu5yb5q?=
 =?us-ascii?Q?aN1fAykU76OYUKjs2CeFlRRAR+p41bBBv/zM/Cny/+cvMLR4zIjf91DSpj1b?=
 =?us-ascii?Q?OwCQjKMkkUIByH3TFGHQBB7dBTuFz83b1R6aAKD6jiaASHC43/Ow99YQCP1D?=
 =?us-ascii?Q?a37xf+/B5ivtVkKMrhESjizMVju1Wc2txOU5ASjFhoizJRRmk3cHVIkpB5or?=
 =?us-ascii?Q?RSFsninxYoqaoef8heS+IA+IscBFCWraEFtSNyeDYoMcC++P0vfKiCLq1dkk?=
 =?us-ascii?Q?LS0oe2D8uQ8yu3MzT4k7rEVOsStjwiybZmhSRuJ4xwl8Q87A+wdnPtmR6z7D?=
 =?us-ascii?Q?oMIaFWMzeCOUKplkmMq3hTpuG0QLI8F9RI4uXbNh9RuIGgVzpsi7eO+rID/0?=
 =?us-ascii?Q?trkKhMh5YZjBOpxx+6xM1ODpJrH+nW2Xru6QnXipso1ObYhzzyFvS/ONEhGc?=
 =?us-ascii?Q?T5XkBVOJ6+xfcQHUS346m/3Lh+hXKJePP4x2mWvaCWETKw+bFOOAxifX7wsJ?=
 =?us-ascii?Q?KCouLDijrBvm79Q9wetfII6fmg+PH0JfZTftGUgjxcHTpB/ZBhM8wktjGArx?=
 =?us-ascii?Q?pA+ZNkreh6FB36YonmIxoqT7oTNYjJel2ISZTwsWmSEL5H52PHvqQU+jwYxb?=
 =?us-ascii?Q?yitUGPDjgE0+xK/uzLxRzmVE3PEndlFX0mif/EMds/tqabJS+e48obok4cty?=
 =?us-ascii?Q?KIfW/kIhPUeMlCgqMUsFRukxjw2m7x0+xnl4uUrHPRpFaIVwg68ZXpxgEg64?=
 =?us-ascii?Q?thnV+tIYe4GposTUcvOiGvQI//EnFPfjyJgMIVaG0gwep5zV+MLSyN7scOxf?=
 =?us-ascii?Q?6AMscdek1K/8QTKGgDWLc2UHyVcapKbfQcQDqUSgMGmT1x2FMOVOQfcEakVJ?=
 =?us-ascii?Q?/xsA1jDUPKAmC1eY9oKfacutz+to9Key/tGK9cnGmkgQPzhjRnOXO7i354Zh?=
 =?us-ascii?Q?TeQcWyhw+hgOEvzf1rcaf7eCcd82pRzjXwvDoubGdlBbz2qx0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4eJLZ4hxg9DPw+1qOLmn3e5S9V+fqg+OHQyqjen7tEFGkGCjjKLONC3efac9?=
 =?us-ascii?Q?5nkQXlZPa9zecFwgvgpQSshVyohzAUHIXsHBT+ZaUN8aHAeh9NLu9wIv2FFV?=
 =?us-ascii?Q?XxjQURYvJNiUnK8U5n5Gh0MXJnqPWpoVQEo0MEzsqyKOaox1GxCFVK14sFiF?=
 =?us-ascii?Q?BZJmv4M/lGmX46HCK1R3YskgCumf+BlAistayW5DHquq0+nHPsqvelGsqOQx?=
 =?us-ascii?Q?ihjuTfSMdFd0uoHaiNvDU+UA9SaIOOZrGTaT0rObwRLnrVV3E3MjSZmTj3dt?=
 =?us-ascii?Q?vy2mfOE8Ap7oaOkka3AATH1GdcTHq5YmfkyRkeyZnv0RcHS6oO5vrILiDwQM?=
 =?us-ascii?Q?kLvh6wtSzMPeHz4r7j0bcZyMzPu6+1KpzQLp3ra7ibSRn92WR8c3w18RVTTi?=
 =?us-ascii?Q?+oT3mnbedtT6msd2klqUisu930Q/TNLYr2GkbfXviW18+vIp9D8ZNV1UgCoM?=
 =?us-ascii?Q?6kp4eFQB+1Lwikw3MkgcvNEp7tURcE1xQCLRZtuTrQPBF6wFvgNo+ApIYaRJ?=
 =?us-ascii?Q?RDtvfMGaD6fjb4GuEwoppQyLhZZ11V39lZ7KY0YQBOur+PCFCcaFQDJqjVsL?=
 =?us-ascii?Q?fipMXOrFtduN4NZyCiar2JwbfiQiuZ8a/LkBCg3fVWkzVgyHhTjHnsYgb6cv?=
 =?us-ascii?Q?oMMPkzdXrzASpD4A95xWuQYPgJAS8Il/xyfr/ZI01Z04C+vBQaylQueSbUnV?=
 =?us-ascii?Q?FUbqUe0mnNpQbtOyA+j8++PLgtBLvzzcMI8wAodsUmRPDNEMO5aTUGtrqN2i?=
 =?us-ascii?Q?aV7Ueyxfbn/LNwFkbkH9A+aCRDHifFBinZiTvfm3AubEyS63ovNWWWhZWH39?=
 =?us-ascii?Q?VTx8Zms/+T8K2Jhr6dG45cl8xw7Pyq8XAtc1E7SdpeKk98EQVlCJyt/MX9G6?=
 =?us-ascii?Q?x98IKFJ3hO934wETyjl/hNGB8eXJ5ZcgvX7Esq4WP5ng/Bfm54P2sQAdALfk?=
 =?us-ascii?Q?gH1a3HKpNMGxU7M9tpfwZSkVuufOh+GU8xBjYKo44Xk22SHjmKf1KcQPGNHa?=
 =?us-ascii?Q?cZmARU/ODL1BF+suHynbN3KbQgBOoswfFTUhzMdWuPbWBCiUJ5NbB9bIQBlr?=
 =?us-ascii?Q?MAxSJZLsOo4f+74MOfTDApkc1UTOVrJi3P0XcHmWXiVpe5/Q0UEYDOpNa1tn?=
 =?us-ascii?Q?CqgmtnAFgFP2tuJ7p7ReoQpT7u0hQnXahaaXoUiZQjmJ6yzKaJGG0y1ez21/?=
 =?us-ascii?Q?2RjU18/kJlxwWovEyDxTMwltVVP+/6GaLsM4MvOywu7cMwTnDyYkPf3V9REn?=
 =?us-ascii?Q?sO/OW+hQzLHl/9IdSb/6CY5uq1Le0StHkKOKtwBUxT0CWnlGmJ0dfATLIjd7?=
 =?us-ascii?Q?VFNjooTuktGY6wghfGEC8he8u0gBUFnuMkyzaEd1ZamBcNKhWjWHugVpmZ18?=
 =?us-ascii?Q?mO2DVma/a6OU6G1vzFX4GxWS5AaGfk5OI6/aH6p99sunX5WN3V6fCWf/qHI6?=
 =?us-ascii?Q?0i5PihU3hR4MfDQ5JiISGpVXtSBAygnz+CljrlKZTAFff3Npjs6Fi/Gmx/lL?=
 =?us-ascii?Q?kUda/qO4ptJ1Sl9pvaftkiZHwOGQpULApw+5nj/OcfW4wGzxyqzaYApyud6l?=
 =?us-ascii?Q?BehST0M690M72qWS3AQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc557b1-895b-4b1e-c574-08dcd2752a28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:19:44.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+btUQ87fzf2hSduZp73hnOTIIEafFi0/NLjYjXHKz3o/wHtoaWGR0deOZ75zkifM0HemwMYx76VUnZNWdQ1Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10888

On Wed, Sep 11, 2024 at 09:07:21AM -0500, Bjorn Helgaas wrote:
> [+cc Qianqiang]
>
> On Mon, Jul 29, 2024 at 04:18:18PM -0400, Frank Li wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
> > the controller resembles that of iMX8MP, the PHY differs significantly.
> > Notably, there's a distinction between PCI bus addresses and CPU addresses.
> >
> > Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
> > need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
> > address conversion according to "ranges" property.
>
> > +static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> > +{
> > +	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> > +	struct dw_pcie_rp *pp = &pcie->pp;
> > +	struct resource_entry *entry;
> > +	unsigned int offset;
> > +
> > +	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
> > +		return cpu_addr;
> > +
> > +	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > +	offset = entry->offset;
> > +	return (cpu_addr - offset);
> > +}
>
> I'm sure that with enough effort, we could prove "entry" cannot be
> NULL here, but I'm not sure I want to spend the effort, and we're
> going to end up with more patches like this:
>
>   https://lore.kernel.org/r/20240911125055.58555-1-qianqiang.liu@163.com
>
> I propose this minor change:
>
>   entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
>   if (!entry)
>     return cpu_addr;
>
>   return cpu_addr - entry->offset;
>
> I still think we should get rid of the .cpu_addr_fixup() callback if
> possible.  But that's a discussion for another day.

Stop these fake alarm from some tools's scan. entry never be NULL here.
I am working on EP side by involve a "ranges" support like RC side.

Or just omit this kinds of patches.

Frank

>
> Bjorn

