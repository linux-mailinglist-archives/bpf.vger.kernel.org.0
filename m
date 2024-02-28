Return-Path: <bpf+bounces-22959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A0C86BC41
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8187CB2371A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18C07291F;
	Wed, 28 Feb 2024 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ixcyAYiR"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2C13D2E3;
	Wed, 28 Feb 2024 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163428; cv=fail; b=CbNlPIEhjaJyGQh0Y+FY+owhLRklWysmDGBkk+rRL1n7aknfBbQBSz70C3UDEuIfwDM5LxJz0Mja3A0aRCzbNvDQ9il85TLsjO7E3kztyd33Ee0ckASjfRY8XfTmsDY5gpbe/Oepn3oCLMQeSwAPsp2hX9KYGsm27k8bnxOeDo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163428; c=relaxed/simple;
	bh=7dfro3d1weE28kImcx976nWSWdSrq+Rcp+JhS/d3ZDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HxULFYGvCNuF3e9nPiv7lcZPPtPACAaezoFI6dQ2io9IJX6wljpcctzNAHpAkDoqTB06XcmYbYrTQwUjBRpi8u59CcNVIu/C2pavo3uWHHbqk0Ozero4uGm2doy1WZpatTFNsUJIa4Xu76GJxJ6z1CvtVkZggkkyDDxZGvoyg4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ixcyAYiR; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPqV7wausV8MJB1V/3xRhN0EziCr47sSensb5XGVR2I5hkLFZBGRH0pOYRTOnAwUshnjFBfcHC4nc27a4oLfmQhF+UKty2tXXjPu+9zxGcd7yEAJXUCPGMlE8rl1gGeE0DorP7tOGHeiRqDW2iG67NQ6uG6cqFscrDmpp8lOXEdlBPo+5QIuC/khOVdUKXgDMv/10xbrDPD9DZrMR7r/peLXi8Lw9SogPV1583ik/C0Jvq3EVK44EqeQCZ8kgN0EEdgPMDDPT7OFRCFOhK9w5Bw9MQ783zTsiR7DYAI+tWqtyBCX0czwNykvj3r+rKOYwZq94xXECzlmY+zi/Mbjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6ooSMnka9Ggj6LQm+575U+ETqzlYjoeoWQWkd5HnY8=;
 b=Ms1rw+dKobqpT8uzUD3oe+VwhPF7Pz3BKRMYv8CeDq3gf7xvVSGGE9t/VymAu8OLIQRMpETvBsTWVDfHw7LLF4IjDqn94BM9a9u+z0rWfIhepjYTSvrBtL03WjNVKflHaWYTS6ak6Gd2phW5U+1Xj9mDOCzvLEuTpHdLvXMl7ISqjraGhlm36rIuMpsGI5RkpoMyy4eUFaENBKbik7f0kNxuD45BoAxf/SJqen81VGe6W563El9Nc+JATUvyU+FRVO03VXwm/WXUwdzcAo78ylEQryRqbuEaEE0jx2rBOiQ2cBoR7s7FWrhBCQj1BZmjlmL+ZrjyYP0jVKNwtamcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6ooSMnka9Ggj6LQm+575U+ETqzlYjoeoWQWkd5HnY8=;
 b=ixcyAYiRJxyxrEDLky2/ndqvjbDS9j4ZhRW6dB08eKXP4vYcVUJLTXlnWLYEz3lkTWm2WzeFX3pMqgvauZvCK/bPkha9NJJiRQpOrT4FsIwJutpxupNH8XyvGT+f9FYVPdnXsuOApraeqc9iwBso7pOoZFS2PBfOtukCZkqqq+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 23:37:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 23:37:03 +0000
Date: Wed, 28 Feb 2024 18:36:54 -0500
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
	Mark Brown <broonie@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI: imx6: Rename pci-imx6.c and PCI_IMX6 config
Message-ID: <Zd/DlibuoSxvjPW5@lizhi-Precision-Tower-5810>
References: <20240227-pci2_upstream-v1-2-b952f8333606@nxp.com>
 <20240228230520.GA314710@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228230520.GA314710@bhelgaas>
X-ClientProxiedBy: BY3PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:a03:255::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2bbc5f-5dbd-4656-b92b-08dc38b62b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VHNsuZZrHcoWoxlbI14D1hqL0wIvCEe8s43ECfKOYaufJI7eLeUZG2ZPz/AtEIikyTEMZkjCJvmbkWzS2ymdgPER1MnhYwez9zWOuXwjLporWSUxscVz1ESWKCwk/6w8ghKPvIO6GmveMMKI3OrUerkWNZibQkyrG+n43boPp+hLtfy6QyvEFFZS+YUP2n00iX6KWqFpQ9PVwlpTBR2Fw+7Lw7IoayJRgxqMbTeIg/xKfwCBBIvJGngA4+rdSv6o/PVcbzXdAE09r3kjbOH/WH/7E74NqKfRxkC7urR4i2C3oNC/yslC8XxC1OqB/IXuIx+02NbeEIjaPqprtUi0Y3i2ydr98cllk0xBbDv/RuSjFmWyWFkawU+lA+rLICOhT03bwcits8AfndsNC6DHkJkl0gkiQHzX+NV5YNrZyZyXkXkhhsYQ9DymTUehk6NFPyhq1AcOGM0SOqcUHgPnHtzIhMD0dE4u7SimC4aE2F1RBuQNxRHk33+bWIBHPQaiJHeGvD4wdkle6C/moRYWTr7R/yRrAKjmrI1ohTbCWmVdrTjsGeXnQ5IEgs8D6WwJSOoTBk7M0/xQPj4k8zoexsWUGfhD2dPA93m1wKap5tnw8WhhZPi7f2sjtvFjgphZKGkHesJH5pDOMKf8K4RqEES7/i0qSqbIuv+sHvY6H4+pE5htxvIymrULRBQ1zEGeZPv2KVV08lpfcEeJibTN40i0L+73F75PqkSNTDHVi18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C6f76EwO8zu88rIT9HezeJ9vkJANGv9WE6BwX2u+e9oYzJa9XqcEbC3l9jk4?=
 =?us-ascii?Q?8lnaioysHnYM9eyTxUqbLImSvlwlU6lF4Vhb1rwwJ94KZ0PFEYUCyaZnMRqZ?=
 =?us-ascii?Q?67AR/msvj26+ExpOwVLYg/y32BxuIvXJt8qFoZkgI0J2agy2rcNjxOZ7Ffwz?=
 =?us-ascii?Q?tSuGxrGZ9JInFTl1wH7VNfJmAwUm/sgX/xaOu/t7N7FqPS1N9aZsObK4UGd5?=
 =?us-ascii?Q?cmJtFWTaUhSvCbav+9qnE13Pxk3modtjcdibwX8VsQyYvnDCrdf1p0Z7qOr+?=
 =?us-ascii?Q?veJ0AJNjNU94YIOJngxX5Ov7JGSxz4sGa3fJ7OlHvVbS6KifWI5lZXW7MXeO?=
 =?us-ascii?Q?gIBvmx6yAKEZh8nBwENKsW7Ej9eGqcNtJ3EiZf6IGAFQAX3ehsEIcstwFG3l?=
 =?us-ascii?Q?E6uX41pt4OUseh3RyE5z7wnQZ5HSzWfDmO0izENMK8GZV+1n3jBZKAZSbVIQ?=
 =?us-ascii?Q?9uMFISigB9dfLnowRPkx9UJALqIfGseLZEoncDSbB3tQRr96MODJT52njdik?=
 =?us-ascii?Q?8OTuhAYeKMW59b8Kju2rpQI5Qxj818A0ZXGwMJrbgbQXoQaQgFppkoOowa3i?=
 =?us-ascii?Q?qtNDKF5WNDutjpP82TUDGuZi/ruCgf1k1DiSnoXgVknFBEK0q3jj9sZoo0zh?=
 =?us-ascii?Q?/csMEQZUHhjTg4nVi+OvEPHKKvJ0yzt6aOXl8uL226XDgLLiqb3R9x7FwwnM?=
 =?us-ascii?Q?EP4NGGxcFPhse2iHaTS1/Y+zmbmTcZCsRI25MEJFiWJVENHnolupcnqAdtp2?=
 =?us-ascii?Q?VAe9yw3oAHTipyuSp0y+PcVTYzIQYi7pgNKiPQvi02DIME2AhYmU22xiI9d7?=
 =?us-ascii?Q?9VoKKKTUHBonlfOpv5fNbTQkD0V1E0Q9MDX0mm+4EjAV11s++4BHesb3bfvc?=
 =?us-ascii?Q?Px2pmszqvwrCT+EwT1ogOJGA5NvsjrTg/sfZrWYmkFuRX4aQnaLZi9Dmtg2u?=
 =?us-ascii?Q?kNtsdNRQwatBqZUbJIJ7/TxGpq+UPPoduDkiDb1qYFLCFrHCXQoSvPm49/tP?=
 =?us-ascii?Q?lV/dOY99WE0iAjei7GjE6+PyDCs41rM47rI/T6o30OuxBTevAvEq/IymPypi?=
 =?us-ascii?Q?2uNoyF0WmAsA/0rQNvgfuxTy/arGOrJ6biR5VLkCL5nCLCn+qcClE3eKWsOM?=
 =?us-ascii?Q?oO/Hs6EyihBToNGtL2o2z+tWjNr+VjDeq+jZv+Qmotj+0DUe5jqomn57Ivpr?=
 =?us-ascii?Q?C5PZi1ycwafZX7cGd8zTJI/Dtmn83djlhXoOd+0JMDh79bSl6Hzkqued7HYI?=
 =?us-ascii?Q?IKsREfiGkW2eLX1w1cNCYPrRwVJPxzB1MlED4MxWojra3WkTucM2HhaaXmJ/?=
 =?us-ascii?Q?GuyiBYcAMnyNo8XFwJ4eRCQHUaVTIp442NufTpZJEG8isFu1/z0TUJdfircd?=
 =?us-ascii?Q?Mp51J17yedSi3VrQYuFH7dH4S5Ht7rWEYxQE9G09Pl3qQt149S3pqLWG4Pei?=
 =?us-ascii?Q?y+agLfaYbIzVg8QhLIQ7LO2w+5Mamn99SecHSNbvx752ovU90ErNT+v5KHnU?=
 =?us-ascii?Q?mkt3DgrDSIqMG97Ycdnz603NcnZB79gIwEjOJ6JQdwKAhqwbbeEuCA/6Q9Cl?=
 =?us-ascii?Q?uvJt0F2VznihEotehqtMzhPKXf5mH2mJhKL/Ic4Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2bbc5f-5dbd-4656-b92b-08dc38b62b05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 23:37:03.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6C/91ffRKrzlDl9HVxKim2MZytUODH0VH7misf6C4PxPSeYvYnx8A/BHCuF70RwGIzsGnmV4mpYIiiZB8IvK+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

On Wed, Feb 28, 2024 at 05:05:20PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 27, 2024 at 04:47:09PM -0500, Frank Li wrote:
> > pci-imx6.c and PCI_IMX6 actuall for all i.MX chips (i.MX6x, i.MX7x, i.MX8x,
> > i.MX9x). Remove '6' to avoid confuse.
> 
> s/actuall for all/cover all/
> s/confuse/confusion/
> 
> >  drivers/pci/controller/dwc/{pci-imx6.c => pci-imx.c} |  0
> 
> If we're going to rename it, we should rename it to "pcie-imx.c".

Good. I will update it.

> 
> It was my mistake long ago to use "pci-" instead of "pcie-".
> 
> > -config PCI_IMX6
> > +config PCI_IMX
> 
> What does this look like to users who carry an old .config file
> forward?

I don't think people will use old .config when update to new kernel. I can
keep PCI_IMX6 for config if have to.



