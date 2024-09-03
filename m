Return-Path: <bpf+bounces-38832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E03B296A866
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 22:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A0DB22283
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920221D223D;
	Tue,  3 Sep 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="crm27xLA"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2048.outbound.protection.outlook.com [40.107.105.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A018E752;
	Tue,  3 Sep 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395783; cv=fail; b=ddttuCuo3M6VjotUnc92fMOQZTbO1Nswo3bLaOPBvnnPKyrFBKo/rrKrkko/Jd5g3+xQDoRkud3SLPfuASO4XQE7uE/Jg0pOMyuzrWC0gkvk9Mh8kzeAj2ljrI83Zw3ILXD8w6Zfz1D/bz8lcrp+oBwluwhBHsz0aeehmAxumiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395783; c=relaxed/simple;
	bh=ixaTnmI2/3N/VDO74V2NFoQft+tsHED9rQ/xqlNKFsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uZ0ebly/V4Xet0eQbE6v4HYuXtueo95GkpTF4sZ5GspV4HUO84TcwAjvy/8UQY7AIEPIOsOYBKKtxY+1uHxnJeWbhMJw8qrocuPQC/dBC7b2W0/bxvbXq5Afl0jAiFOlW8Y5oGusqJvDNCwBSf0zsN4HzwblZebpW15r79IdLAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=crm27xLA; arc=fail smtp.client-ip=40.107.105.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbL5beYqQ1tKu6Erff3AUjE1eaEViDRpEZnB7ZkRSaeqLqSA8dLFLyf45FL82t0KiMu1fKWUoTz/sq3w+8e+F4vElkj4y64Vs4ZH4XSGKAGswMSK3Cul6DLWPmVBBKSCowXqjYH4vyqB/KooJ83Wirg8Gh2euFcHGHveIY1kyiZLFCoo3ZSOR1gKmqL6JuiDVDMUeKAyFyZAndqCKsgMptBH8qrcNlduDFkU3HFobOgymuEioMm3TG6TeaoPnKsz0+w+PriwMgaoahruMXxgCdYl8A01q9xCmYpM6zrW5dUifgRnbiY+I3Yfv5VvCGO5/aXOajtyjeTe30sgT6gexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GHSwPeWJMRsnJRYxB11AkG6+vO1WJlvGIRpjuScGH8=;
 b=NiV85SSkHuvrG+TxPfZ8taHAohrr7wsCwHi+O6YM336MAONKKNP/EBpMtlRh4zAfPSmAzmek0fZTPUSED8cpkFUi6+aD6wiEeQ6q6yKfB/yAV43Iu7RQj40c66oHvOzdUOvNvBD+TUiLuzkyEdryM/Vfl4c6T0xtjosvkzkivUvaKeWz6k+elB/40ZakOtJlZJ0Ks/Hir+koqdaFr/5Tci3/8VGjsgaQtgT+Mq2nku+J7uL0iF0fwbrvFuUIyoEK00jKNtaYY02xeHxqzHRpH4vwDFBphWAR6J1TlJ7YpbxjUg2WgS77YCCKsmjtBZeAgCcvHdqlli8mwYNGhhBCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GHSwPeWJMRsnJRYxB11AkG6+vO1WJlvGIRpjuScGH8=;
 b=crm27xLA5q/PGee71KRLXPn76uB4xWzUhRsGBGdQLElTja25uInC0T2nIC6HuqJukUWqSs+VzfgsEuJ8+NYcM5FOuFJFeQd7hZctPM/DeN2BxsRXso/2qUnI5ADpngV0D6O7QSpUfDYbdWWbs5Cb9xlkKaWJI4cTkNGXlCVeyhnCbP9PGZP05H5dIu6NJhzfR85OCy1HIqwS8v0bUR9LTON136Jmjt5UdNUef5RDU2FBEQ/jdh4OxylLb3sLjem+1W8qxONzk/X7EMBS+wl57HjkeP0+tF6iIVOiLLHJRy5vozZlZDRpYVvldDoo443esW/Ovv/prAAKpKGocMFymw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10916.eurprd04.prod.outlook.com (2603:10a6:102:483::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 20:36:17 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 20:36:17 +0000
Date: Tue, 3 Sep 2024 16:35:47 -0400
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 11/11] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Message-ID: <ZtdzIxr3YnDAW5VY@lizhi-Precision-Tower-5810>
References: <20240729-pci2_upstream-v8-11-b68ee5ef2b4d@nxp.com>
 <20240903014927.GA230795@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903014927.GA230795@bhelgaas>
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: 134eb728-cdca-4b3e-0e3c-08dccc5807a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ghdZXFpv9EI3M0b4FEf/M5dw6++JPoVXIPwFz6kMMNttiNBCs6t8CHrgDoBT?=
 =?us-ascii?Q?8Md3geNpk3B1mVNOQLco3nXN8tDb0z6hV/uUnA2gzqjxXpCwo6KRgq0Vh0fX?=
 =?us-ascii?Q?qEbmKwLZ9ICOw7N2tEz0vsK6Inkdr7qYd5MQCJVJzrh9yNBQW/H+z6bZOtgq?=
 =?us-ascii?Q?dB4ZXOHU3s2WK8/xnfuWJ8jm5n3RhnhVgdNsA9ryPxnZK6gpcBV0ukol+B5q?=
 =?us-ascii?Q?yb4BjL4LoPv/z54RkLRzkpujDtO6PZbhNOxWe/q4G01vzBO8WHnMxnI90LZU?=
 =?us-ascii?Q?vS3QWxpgDfL9SfADLYA1f2T5z5gsdho1E21U1cRlZwAql9Vk5w1qCupwem8D?=
 =?us-ascii?Q?+/bK8F5S1FfoyTkd1O79Dj5TFmYAQ0xt5ZBlqjs+uazIq3f5MpoBDEoK8BwG?=
 =?us-ascii?Q?DqorbJoCuHEFAMgRh4RytU/f+9s2EI038WLSxPQ6MXdXzQvU/ZESNJQB4Qmv?=
 =?us-ascii?Q?8kPncrx7ZZne3lsR7HsdqDQfOoZQKKITAS8DGArtN36qoRORc6DhSuQt2eUP?=
 =?us-ascii?Q?dlvqQFp8U/6CQI9414/DoSkao0KVe4LzGp97FKg3ef9J7oRbGHDukCszIEK6?=
 =?us-ascii?Q?XJrqvDiaVXERtRpBtM2tgcVLVJqPR5xh4ErMIJpCVPjkSskNsgzyCUYY72z8?=
 =?us-ascii?Q?TZlhUrYZc+cQekKbnGC9pyxY5S3RGrMN61AG7VmCnE0VKOqq4NvRDa9TVQ6D?=
 =?us-ascii?Q?+aNxLHDM3yd+TatspGrnMmpQ2oKukrNBW30p+Nv9imAGMQDA+ap+3Q+bLer5?=
 =?us-ascii?Q?c31C+Oz6IDJr2i2OH7eCgrSKCRsUUvFlmq8dSFpY2DY/cj1WZhr54/wjJW0V?=
 =?us-ascii?Q?3VurRseot5e2+2dWEcXA716tihG/tUWLQYY5DdUfqGeiHnncpDQiRZzEahnE?=
 =?us-ascii?Q?6QmkbImzt77OAAHlwQuqz4qA/JnpIhsmYRzA7wCvdSvA/wH9STLsl4a/QzbE?=
 =?us-ascii?Q?8ebieevLrHGC5EG2SX/MULvcigcd/wKu65vktwyc1/giaqHZNvI2jZoCpyFz?=
 =?us-ascii?Q?lC9fzm3W4eD219UHxvmFT840JImeaHuQUD/FH8GoYAGbub1tUNTAKI0euWoc?=
 =?us-ascii?Q?x2p2AqyLprsieiXBTgbQzRHVkuqNaIwbFbu9xE/qZJ+ljKjhI+ff8XSQciXi?=
 =?us-ascii?Q?P7eq7wsnX4qZfTMacCScIxQwXcVUIOrm/4HiEejLQ8CJGy3azm0gUmbnUaEE?=
 =?us-ascii?Q?7HxMcAnsBwnYxsBD4eyCpLEjZFEOEvjrRvtJsmNl23yzelTINTX77Ey78D+s?=
 =?us-ascii?Q?TyBeil8wgBJ7EIhn+/qipGxOUFf3MQW3kz0nTo+k3km30CoSOomkwUd5hVKF?=
 =?us-ascii?Q?PT4Ma7UcBAfedMFtJx7+PDr8K18pvAXrrm1UZdXSzAB8DFSbkxoX/2aIO4fA?=
 =?us-ascii?Q?ltHq2D/XO8yBLkuV6CaqcgFZKZBWIrA+S0aR2Cnja2TxYYyxxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EtR9KJpZc0Pk/pJawDr/G4UO4OvSmFpzHWDMLjyCQYtOeFlPX0NpgJqAF3K2?=
 =?us-ascii?Q?bjUuZQLwy5kYzkiyx/QHthDO5BD0KgapfGKRQnHX1CYy9ux6R29SqpqV6snv?=
 =?us-ascii?Q?2G6yzF6/9sCsZB2gJ0afos9xafW4AISXcWhA2i0jbnde1Ir1p/HJnwk0g46W?=
 =?us-ascii?Q?wp46tn2be5Hk0GglV1jSUstsM1lHNb7wz2Eo/u9EnA21CKr4KliZq+61veee?=
 =?us-ascii?Q?URKQ8Und15QArLyNJmJ3LpgeCSt9j7vw4Wso3yk3IinH9g5UkuNeaOqx0FdZ?=
 =?us-ascii?Q?aL0x8bX/Qy0iD4hvx07AsfbDXjCYEVtnAfQro2HgJ4fZVgnkSwKGiG2Ettji?=
 =?us-ascii?Q?YQtnslqv2KYq0n176BbX5t1RQNMhjERUAfR8BDRJoD+6ziSUE+Ko9awoOXLm?=
 =?us-ascii?Q?d+2NaMvLCZPwtmb3VJIpVnj4DdUOeDt6v6qhZveZaNWdQphEM84zcjEMLCP7?=
 =?us-ascii?Q?VfK2+hm+4XWnMzXP/0NidF5j5q+9dTT6yIDaruwqEnbQgTdVAfc3vT8sw2xH?=
 =?us-ascii?Q?lkT1YRtSjEcT/M4XUzF3cDVBEtEatZMFrpEjxS0NmQgAcI0Yn9DZ6V6PKsRM?=
 =?us-ascii?Q?qfCKf8e6zFfwSMFCov2uisQOivXWl6NJRHoO3JhuYHa+WMhtWDoO1nGx8hE4?=
 =?us-ascii?Q?uMg28Z/1HR2ySGTgpN/r3Rax5J69crXasEGdq0BrnqrExplay99hayhnUr68?=
 =?us-ascii?Q?Ww6x1D37KYwVLcsmfiSHD0Im6WPQSRyI6kKDmNJZ9keG48PFKnSJuomQSscO?=
 =?us-ascii?Q?/OVLRwqYIBGkEp3Ttkul3DFgg06ukBx57xVYKr8W2ySk1sYQrB+RUhBgHGJe?=
 =?us-ascii?Q?vX+kzhi5h1MoGghncdPaIsj0V90Bc8u53zNZXU03LtvtKttI1M06pZ9C04QX?=
 =?us-ascii?Q?9Dwj/jEKXAmABL89GoOYdb15TMcpQuXFc0C0zAkNewPDbBlJVnjN0FkwrmC7?=
 =?us-ascii?Q?2fLVcP5l7cU190PF8Dv80GM59+hP5knuJ8s0QJNvcf7vzfWGnm3FcZet/m5N?=
 =?us-ascii?Q?QOnYUXeU/B0vZ0raBtbhfrVxroVUxLIcSjD+E7pDPUjQTT3DWQDiVctk9C37?=
 =?us-ascii?Q?oG6WUByVpb/ESHjwSdg6Gmf9NVx6aJXbj1lUIIgMDnyh1OHYurEXPRyy0lfB?=
 =?us-ascii?Q?H2Z/Hsd0RGA9LuaF+opH6gOfOyk4GRGdOPMHVIvxYhJMreTbVzbn0eN7X93i?=
 =?us-ascii?Q?3cPy8b3l2/fM2oJFRI5TgbbxEC2uFyyNnucqVlaJM97lYMdQthUD3KxqLVcr?=
 =?us-ascii?Q?8tiTrhNIL7gCbxIaS9eDhj/w5h5hqzwHuIlxeEHt/YRuvIvY2P0qenTYPV+B?=
 =?us-ascii?Q?7LlOU3A/p9EdDG8wP5mxv/kMxyD6un+JpfOfFEy2sBzo+S2hU9T17E0jTK1y?=
 =?us-ascii?Q?EFV9pqbdRUJPcx43j182aYdkm6MaO8gACSrAdFWP9q4HxzquLR7r/Mtd0ZHg?=
 =?us-ascii?Q?oXyAW98RQkoV9n3ZzbkbRlzQPsBzFZMVcicYe3xqlDwAdg7xgdb2K031j1mE?=
 =?us-ascii?Q?FZpDM8tYeKlUtSgEkZ9wBuwJg28emVWF6D/R6b2UxC11vwOKKXMssWGxZzjc?=
 =?us-ascii?Q?nxjTYTa0ccHVy3pl2OI++ZiUOUo2JquZRQRiVRDX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134eb728-cdca-4b3e-0e3c-08dccc5807a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 20:36:17.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKLKzg2VtqsvdVCRzV1CajlRjdKOzrH0nj9RG8cOkYz6lTFR5+nkbUBqizfNUzY1CZabDEA8zSKXrK3b2GcLAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10916

On Mon, Sep 02, 2024 at 08:49:27PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 29, 2024 at 04:18:18PM -0400, Frank Li wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
> > the controller resembles that of iMX8MP, the PHY differs significantly.
> > Notably, there's a distinction between PCI bus addresses and CPU addresses.
>
> This bus/CPU address distinction is unrelated to the PHY despite the
> fact that this phrasing suggests they might be related.

This just list two indepentent differences.

>
> > Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
> > need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
> > address conversion according to "ranges" property.
>
> I actually don't understand why the .cpu_addr_fixup() callback exists
> at all.  I guess this is my lack of understanding here, but on the
> ACPI side, if CPU addresses and PCI bus addresses are different, ACPI
> tells us how to convert them.  It seems like it should be analogous
> for DT.

DT can tell how to convert it by ranges. But dwc core use addr_fixup()

drivers/pci/controller/dwc/pcie-designware.c

int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
                              const struct dw_pcie_ob_atu_cfg *atu)
{

        ...
        if (pci->ops && pci->ops->cpu_addr_fixup)
                cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
                                     ^^^

        dwc driver should parser dt range BUT it use callback
        cpu_addr_fixup() to get pci space address, then config ATU.

        Ideally dwc driver can fetch such informaiton from dt to do that.
        But because some history reason, some driver hardcode by
        mask some higher bit instead of using dt's ranges.

        And another possible reason is that EP have not ranges property in
	DT, this code shared between RC and EP. So it use fixup functions.

        ...

}

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
>
> I would have assumed that if the DT is correct, "offset" will be zero
> for platforms where PCI bus addresses are identical to CPU addresses,
> so we could (and *should*) do this for all platforms, not just IMX8Q.
> But I must be missing something?

EP mode have not ranges property and pp->bridge is NULL in EP mode.

That's another reason why only add RC function in this patch series. we
need more time to figure out how to get such offset informaiton from dt
when work as EP mode.

Frank

}

>
> > +	return (cpu_addr - offset);
> > +}

