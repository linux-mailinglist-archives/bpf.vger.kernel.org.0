Return-Path: <bpf+bounces-45584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3AA9D8CD8
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 20:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E04528AFBA
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 19:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0111BCA07;
	Mon, 25 Nov 2024 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O343naaT"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E017C7CA;
	Mon, 25 Nov 2024 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732563011; cv=fail; b=OSvskMZFS4g86jsAdTNWocSvHoPazZJhpDT8RbMlz5sPvD0y3e2gM5yUIdcbMhlSpZtAfIaZWMAHGLz9NjtVaxCgxj4Ik1wtfmHGKq7ojSJBfgcpm/mqodkIjAdUZtI7uu65ZrugmHJklEL/WVZginzwgU2B5yuKlmj7cdDfypA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732563011; c=relaxed/simple;
	bh=TLAEsjNv0ngfovY/kAjtngeaW0ytXffY1AeOiic1TXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GVj5lXUwwv7Qlneg3VdtATPPkxcNiDawmNaYzaek03U/hkZAAxsHa0pfmn6Vi8gTrxR/pHIByjs2DwKFqsLd6ykH6dMeYbPJjmB4wIMLKMUdx6196i4AXrdVzWFJshZ4OS3Yk7LDUFxB3gMVks5oTDGmoUaULICWDWQBTDqz/EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O343naaT; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yG+6EOZKOQsGQ4lB+XKNXAcFi8ATxBWioXKHoG6nndKH+dAbq1KxELMwPaEU/H0czgtSn3lPZtfkxSQmrrGWIKynNg+CxtTB6mDtsvjDIPw2d/RdGVzWOGakcFS5tXtN7xgS0Kzzkp/PqEZ1vQ//UNbDYcIEi7Wtr7QDfCW8snptiEHOtasoU66s2hqDCx7nLB23O3qVzwEtgK2dwUVUGr9kH/PQpfaesP3A3PlRPtkoY8cyhaxFjIdh/5oeLyROSrPXKSUf5sYfjdinxBqy8lxBm5BdNbn0WQgR2+fFa3D63RrzxRi5ji3al+0ZLAjiOUYpnYHDb2n5CH7u91AKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvL2K8HtHiS2mkxAKaLwOL+QRdBph3La61cqErZKqRk=;
 b=G4N1pZPAGzlF7ZayLuWjFzmElHH0WZNwWQkx+IZBbhRHlS9puhvbah+ivaIGXzmNCdm4RGyzax1nXYIj/N3gM2CXOGvwvPB9EcPMxyK7iyaA9mRZKMgt/et42rKum07AnoifiIRO4iAI2E1/UH/sEeDN65JQ/43AlKQe65TXrCxxQWA5Y06zBKQGH034eQ4gKbQCtt0rd9BKySCPVRJNh5Bbbg/Po+PK30q3gsSqic5Y0SJVzP29X8qVobcRv+5AeMoEpQ482huHkIpNDpQWnzqLXfTddNHw5lj3dF5/ivLtlPfUsmRY2OnlXAkqGnrSBdmqeHH8zTk99QUdjlMddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvL2K8HtHiS2mkxAKaLwOL+QRdBph3La61cqErZKqRk=;
 b=O343naaTp+sbENb08wQYHuL+Q1z0uDt10zbcSePt+EnQ5+oX1jsXBs4bmw0mj/mPJEw8+3stH8tvUQ6WMX9GQP+hje8d5CJnradh0gDBAXaUtKz1HytZB6BkTkaoUHWMwFcie0ULSxDdtSz/75ihFbS0eIe2mzHgesNa4xoVZoS2YsLHhkhHSneCxYma/12Xcn9cWYUeZqDr3Q/klug4If0df3wuIBkRsCNMP4uQH/2hpj38Pvmgu0P5CJv9aAPjsgcs0Gz/NGGp6KEx0uM2K3R9boHuGGvemrFJM15M1JU+yb2oT8uLSLmWBIJwiGNk8iu067h7U+xjDipJ0/kInw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10982.eurprd04.prod.outlook.com (2603:10a6:10:589::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 19:30:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 19:30:06 +0000
Date: Mon, 25 Nov 2024 14:29:56 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org,
	jgg@ziepe.ca, joro@8bytes.org, lgirdwood@gmail.com, maz@kernel.org,
	p.zabel@pengutronix.de, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v6 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <Z0TQNOTeASXJWU8N@lizhi-Precision-Tower-5810>
References: <20241118-imx95_lut-v6-0-a2951ba13347@nxp.com>
 <20241118-imx95_lut-v6-1-a2951ba13347@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-imx95_lut-v6-1-a2951ba13347@nxp.com>
X-ClientProxiedBy: PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: e20b8f46-b191-44a9-59d1-08dd0d8790fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dTGYzS1U4QtMi0b22cGROPDoCek5InIDHMSAhzyaTuikHLMSkfHAxK9lriP2?=
 =?us-ascii?Q?IU6pUY4UWz6QzR5t3k5NgA6eiqfASruE+X0ulDc7x0ek2FixnL4WYZOlfn5a?=
 =?us-ascii?Q?NP4KllR6NYdMIsIvWYF1JI4RFaH8wzA0DlE3RHUC8EstsAQ6ehe/1i2+kGN2?=
 =?us-ascii?Q?Z/FUHZ/vQsBJVzFFPAkKyUW0W5cS2TPFDT4fKuleO4w4WE/xbY6/vAWY7Ui8?=
 =?us-ascii?Q?HESqnMoc/YRseJye6pX1EbOpgjZYaM3nAc+QNmoLNnsPRtUsz/wq9VjTYuuI?=
 =?us-ascii?Q?jvHoE3Z3rA4PRcAGGcJz7HmR3Uv9jUCNFUQZgge2YtKax/tjIrkyuXJPWkta?=
 =?us-ascii?Q?wy3iYc2UPC4Iit3vmFln68vEl7GRLhkdOVOt5j7WIVvroP2Nw8UbQqt+L4Ze?=
 =?us-ascii?Q?hRktB9dm3nLJFE94adc7lseH1WCv7unHm7qg0E2/Cyg7NDJCevnVsgghdRSN?=
 =?us-ascii?Q?+/IJMiIhLfqs9ysnP6PY7MY11g+iXkg3J7+YaNpUm66GVauT1Ip7FGXIftFH?=
 =?us-ascii?Q?UqPcv7m1hSz3OIOdGb1Ilga7Z9duRIMELhBXYr67blnccVsy87AAiS+020fA?=
 =?us-ascii?Q?MIVKVBSKPfUoqdQFZAHOCP1jqHd7n3vYOz9z9jpNJyPiBfBB4tNbex4x3M66?=
 =?us-ascii?Q?sP5QdJl35vYcMonl0AjJ2g9PvwHSAu5U+VRiS5ZZkwsRrgzf0qjcBnEXONDK?=
 =?us-ascii?Q?9Xr9q9JCdeZJhL+V1pjOPojkb0COIG9WjqpYhqpIjOKiZKByo1IPk0ytcOPf?=
 =?us-ascii?Q?SV4/vJVW95VHvdqYqZUQ2nAFJUQ8lia6vIT92rot+9AAi8ibAyaYDbQAhVWt?=
 =?us-ascii?Q?aXK9v0ZABF7jWK68Bv8+S38iXr3lIQq1Rw91M8wTGxRlk8asN100I0iFaxvW?=
 =?us-ascii?Q?nD/OFgn0Q0h4+SJh4XWu7AUapN8vj0R3BFrsI7zv7EjUOpFPCbt+dzdO3jDn?=
 =?us-ascii?Q?+xZwpuIluLjwCMIjgMxrhoxd805LEwi5U0mREWIWMgYg9FibCFaMno6U4VPb?=
 =?us-ascii?Q?fU205ZlozeW8OR6wqz01ok5wQOss/CBZOIvt6KwsNEkbhif+oYLW0Zj28sqh?=
 =?us-ascii?Q?VZ6HKJxkyrVhu0tVyT/g4RKYn/tWt6vN55ERT2+P3R7p6sGwTxrmrGKKXp4K?=
 =?us-ascii?Q?j7eU8bHgmJeJOOc86X53bD9USWE+hlxpIAKv6ShEOH2XdmNLkw9L50cXNJh2?=
 =?us-ascii?Q?bK1y228dvviO2BVmxd768X/hyP7DCu8UG9k+HYCJp/VVOO5M++v/s+Jxb4Kc?=
 =?us-ascii?Q?fa5c4NTanfPaIW9VuCcaS/1bdJo5WkuSlHaYDQhq3D/jwsAZLrbaW6cLi6mf?=
 =?us-ascii?Q?bryw6k9xuBTQOSt/x6j9f84GyCFB3RMRZtpQB7iTEbblrPZqLNvo3KtOhPCp?=
 =?us-ascii?Q?RxwDJ+GP1LUXQKKyCj3QBceU2epBXTOPjo3mP/fsMLK+2nHxXjrY7ZnWmaBu?=
 =?us-ascii?Q?rNrYG07/JaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44jXBry3235W51J/1VKjuuWcDgoOolr2FR2h2+XNfryjCRa2OUi6Ro4HX8Th?=
 =?us-ascii?Q?F2MJANlJcmmkWEkD5o2nAvgpFZ/oKWhVji0n3sWi8emEeog+z/zb6zigPkkc?=
 =?us-ascii?Q?0vC8nn8ITVSDuU5i/29jff3G7cAAoGhFthfxQ4GJ/1T4rJCDZQt4zM1P68eO?=
 =?us-ascii?Q?8fa25lljoNAoVBYxwlVSwtnjcaXLtZCWQag3CM++kdRwdI20JQ23BNpI3oNm?=
 =?us-ascii?Q?C2dlqtlkSY6Nl99Vun+BgwN7e2ULQs42+IYLgP+Mhnrt1jpEzw5n3QOzQN5f?=
 =?us-ascii?Q?5CenteCpDbN+OvJHTv5cWCFncZVgMZ1J3A91OfrpXmLeVJqdHncSq2jpWGW5?=
 =?us-ascii?Q?vINwMnE9syB6Zus181yNW5L3NmOCSuOVD6ubNj187jNy/E5BnyKegqAJYEno?=
 =?us-ascii?Q?aalYd7AIi91hlZf752pdgDqXTZNc0JhSz8R0ZcYb24Rp33py5fwC2Xx6hypw?=
 =?us-ascii?Q?xMw/GqOzKwwetFNN/I8ddKlBQCcbw/9Df5sl+E/CRqvEz2XVX44GseSTgsmc?=
 =?us-ascii?Q?1fVW4cMn6uKJPE91xp48goG/c5rH77oVdwO+IZ5s6gzfyi5yyWpq1VTuAipY?=
 =?us-ascii?Q?YdC3sDzmIhp7z3AZqlma0T6zTcn8l5qeJMIIljHPLB+3dEsoSyusRXTZ4PTK?=
 =?us-ascii?Q?gbN5lG2+pbNTWhnNzRKIOFeIU8xtm+8fZ9Zje1az2zhSJZwYxIjsZy0qAq9Y?=
 =?us-ascii?Q?lCIfB7bp7cQB+nmP58UCSSEc7XLTg8hJEOIoHMtXDifGJHM6bX6PybDA6Inu?=
 =?us-ascii?Q?nCBRrSDgUpT9HRYcDojY7gwfDeeGuGRxAoaG00U9E2N/h8dIrSBp2hr8GTSX?=
 =?us-ascii?Q?jQRN34g+LXrzusiUSl3GtVY7Scp8JRc0ZhtWqoulPYH6Kd0txMy5H8kuVd7Y?=
 =?us-ascii?Q?SLVpRehnAwLPm1URgHoP8jXEJDJ0FY7a1yL5k0dR4LhyagOHfGLxgULeQ0lA?=
 =?us-ascii?Q?DdMhOhlCVWwm8enSSx4VYQ7kFgqpte8xaZfPnq4Y3unMrEl9vMdtCuIfvOMR?=
 =?us-ascii?Q?RpjxE69gov+54+Q5KHqPpCxv+XxzwKXoXOdA5ZHQysZG7yqfpu5IixTHjqV2?=
 =?us-ascii?Q?L3yQM2GXyPTRB1RB1xx1haSKmZjzK9XUH7IiQWZm6PEMRJxspXMEtGYI5GUG?=
 =?us-ascii?Q?Utoxge4XOkzdsHkeLYocFs9x3X1nRFbkGRgoaecOYmci9npvB+qbmi4StsOX?=
 =?us-ascii?Q?lN5ews8oXBg3FIdgKvPfWOkXRHz+AJMoygopNTMnnhKe933IWhAnEEsE8Srs?=
 =?us-ascii?Q?W2/zZXFWURTai3lGIbs1aZmf+lsdS6RN68Ctf+/z0Nu9WR/G52FinUcESVBp?=
 =?us-ascii?Q?DcE5g4VBnKTkxFG3jHxtVSbk9h2moUnt58xT5dzSTVxHbY1IwWnWJVS7PErN?=
 =?us-ascii?Q?9vpspNQKveO30WhYSXXVHkqE0R59MDS1iRanSxavAAEBVFQLA235lfOe4zCQ?=
 =?us-ascii?Q?6dVlkU9XbaNFot+2o14Ztp/sOJ4NFXSlIQ+DK+ModgSbED0Ns2xgbrn02d2W?=
 =?us-ascii?Q?Eqo2cT0Fo1q9L7ad81VSBW3lKQCxbhTOpyYrh/cEzqqHLPek/Hu1TdtIGUrc?=
 =?us-ascii?Q?CYLbexfu6RGIoEH7r+l/GmA9pPkKG4A1NNWRtJik?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20b8f46-b191-44a9-59d1-08dd0d8790fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 19:30:06.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+ZS2cLbSpdbJk7AnwowbqeGcol54lE1/D0dn232cBcGmZMl87HGE4A+YsvutdflY3TeVF+IMnXD0zR/BgUDHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10982

On Mon, Nov 18, 2024 at 03:24:27PM -0500, Frank Li wrote:
> Some PCIe host bridges require special handling when enabling or disabling
> PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> to identify the source of DMA accesses.
>
> Without this mapping, DMA accesses may target unintended memory, which
> would corrupt memory or read the wrong data.
>
> Add a host bridge .enable_device() hook the imx6 driver can use to
> configure the Requester ID to StreamID mapping. The hardware table isn't
> big enough to map all possible Requester IDs, so this hook may fail if no
> table space is available. In that case, return failure from
> pci_enable_device().
>
> It might make more sense to make pci_set_master() decline to enable bus
> mastering and return failure, but it currently doesn't have a way to return
> failure.
>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Tested-by: Marc Zyngier <maz@kernel.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Bjon:

    I need fix some for patch 2.
    Can I keep your ack tag (v4)?

Frank

> ---
> Change from v5 to v6
> - Add Marc testedby and Reviewed-by tag
> - Add Mani's acked tag
>
> Change from v4 to v5
> - Add two static help functions
> int pci_host_bridge_enable_device(dev);
> void pci_host_bridge_disable_device(dev);
> - remove tags because big change
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Tested-by: Marc Zyngier <maz@kernel.org>
>
> Change from v3 to v4
> - Add Bjorn's ack tag
>
> Change from v2 to v3
> - use Bjorn suggest's commit message.
> - call disable_device() when error happen.
>
> Change from v1 to v2
> - move enable(disable)device ops to pci_host_bridge
> ---
>  drivers/pci/pci.c   | 36 +++++++++++++++++++++++++++++++++++-
>  include/linux/pci.h |  2 ++
>  2 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 67013df89a694..4735bc665ab3b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2055,6 +2055,28 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
>  	return pci_enable_resources(dev, bars);
>  }
>
> +static int pci_host_bridge_enable_device(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
> +	int err;
> +
> +	if (host_bridge && host_bridge->enable_device) {
> +		err = host_bridge->enable_device(host_bridge, dev);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void pci_host_bridge_disable_device(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
> +
> +	if (host_bridge && host_bridge->disable_device)
> +		host_bridge->disable_device(host_bridge, dev);
> +}
> +
>  static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  {
>  	int err;
> @@ -2070,9 +2092,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	if (bridge)
>  		pcie_aspm_powersave_config_link(bridge);
>
> +	err = pci_host_bridge_enable_device(dev);
> +	if (err)
> +		return err;
> +
>  	err = pcibios_enable_device(dev, bars);
>  	if (err < 0)
> -		return err;
> +		goto err_enable;
>  	pci_fixup_device(pci_fixup_enable, dev);
>
>  	if (dev->msi_enabled || dev->msix_enabled)
> @@ -2087,6 +2113,12 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	}
>
>  	return 0;
> +
> +err_enable:
> +	pci_host_bridge_disable_device(dev);
> +
> +	return err;
> +
>  }
>
>  /**
> @@ -2270,6 +2302,8 @@ void pci_disable_device(struct pci_dev *dev)
>  	if (atomic_dec_return(&dev->enable_cnt) != 0)
>  		return;
>
> +	pci_host_bridge_disable_device(dev);
> +
>  	do_pci_disable_device(dev);
>
>  	dev->is_busmaster = 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a17edc6c28fda..5f75c30f263be 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -596,6 +596,8 @@ struct pci_host_bridge {
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> +	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> +	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>  	void		*release_data;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
>
> --
> 2.34.1
>

