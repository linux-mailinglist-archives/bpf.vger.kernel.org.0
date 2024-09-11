Return-Path: <bpf+bounces-39645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7191975A09
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 20:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F74B23C13
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D1D1BCA01;
	Wed, 11 Sep 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d0fOkIvt"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2B1B3734;
	Wed, 11 Sep 2024 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078042; cv=fail; b=L9mjnyC2G9GUEnwPxapERv0p8bcSP4o+54rnL9N0Qe/RtkNcGHANK0mHdyQ9Gf7UwyFjbo6mBMcuhQ6CWVQi5rpdcMiEl3LeiNHn03A0V3QX6YspCMOYnE2wQ9yR1G3d3wge0SLXoBYehWa2R9x7TVS4HWYQYqVmAL2kTFrZukw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078042; c=relaxed/simple;
	bh=UICrj/0ko1+fjbcRSvMpyLjn4JPMA9PwbgpW6cB/n4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kOpvKoVltQo3ErMbHCG+yc8Tp0At02AHzXCDFllLmx1was5D6JnRLfAM9COk+CximusoZLpim8doARhnBcSW0O227sBeDwVgd3TpVhrUo0Yn1qo7jwQY4aW9Jp6NWvWObv/+a6j5Hxwi5hoYyk7zp2eCUifLUi6eJ4QeoTShmHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d0fOkIvt; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdPHzs9WS9jcRy9hdFOfqg50i9GP9ESQ2jFErt9QU2IQRRzx/FeJq/lHGJgiVs1k9ihokZvkzCruC5i4185p8ayopfddynipJTiGC/05xva0p7peoHhjQJBtT/KmYRgcpBcuzUk8C34GArsEaT8E9iYFSsZT0v8giBilm6qWXp5ZCopZR8/kk/MzJbCklGhxoDymntDnN/TEJG4DNyZBHkJO4yr+utNjwpinXHeOpZM08sJfYQ3MLbxpSwudALgs/HV+WhI3k9nyYREl11Yhd8N4+75ZJ5MZvrTJ2Sv9BPtvEw68M690yA8ogEZ4eTYdmvyctNNFvXv1oBjp2IacBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfSueBf/G9gFhwtqUPax0sczCxN8cUIPs7ks2h2uhnM=;
 b=fnJ1z5g59KjdtLzkBP7BvaUU3gE4zyksCUCV8Vbq1L6sZnzo1eyChRtBnA9imWuq1811O7kl4+bgMaLDdEgK4jL4WrVZnXhNoSh5chLkkf4sO7EEmXBOlKfkQEBpH6me8RnVyAXSdF055b5wt+VB9tdBLXicpJfAL74T/SOoNzhveGm7Ux0Q7U2sRVXxM8AS//vVqtxP6oUX0ngSnBPcBujeXxsmtbi8eqRsuEqoQziXNmzquQ6QFH4tBhUzpToPqo1YlsitX83voyJEsqlGWxrR4FNIXfyzr7Wywtgfv/quJQqAnpbUizZeSI4gZs69UAGcDXXkFXK5OtSjsvLAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfSueBf/G9gFhwtqUPax0sczCxN8cUIPs7ks2h2uhnM=;
 b=d0fOkIvtcq6+objDVVHsAZOpppc7/Fj8kRVqZ+id/zdJew/ujddR0pWW8+xQUJwRj5KYXpGBbdTNCBdqSab3nqdrBY+ikov+dCYFSQkFwU1C9QXhUG8SKkk8VgyZLfXVRbgfZ1GJYQkHdW+kYQyeiE5Zx1uea+VIu5FfgJgb3+Bjl+GTvNNRVgIl3+GgGZwQZD/+aoAcDKxKDqgz/w55aVOEo6N5qPRRlsOARAmvBlk1KwQbTGEZoOvRiAYqnr9KtXOpqq/1IjIN+kuvHUSN7IaTYQvoxTOpZTkFCGojJhJ6DL4xsFMrDXhXkuhhkl1ihIN9ytphP5dAWBqc3xw6uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9052.eurprd04.prod.outlook.com (2603:10a6:10:2e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 18:07:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 18:07:16 +0000
Date: Wed, 11 Sep 2024 14:07:06 -0400
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
Message-ID: <ZuHcSjcP3Q3b7QPo@lizhi-Precision-Tower-5810>
References: <ZuG1BfhQpd9GajNH@lizhi-Precision-Tower-5810>
 <20240911163356.GA643833@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911163356.GA643833@bhelgaas>
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 39810096-28ef-4466-89a8-08dcd28c91fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ll1pStzIQ2B2/0eXRRw6SRdKDB4z6Fs91vvFNZMkmdB1EIcWSSUxPsgcKSe/?=
 =?us-ascii?Q?8iJ5mlRt5Fh1s1ffOPmzoF0d55WvaYjy8UCk+BCqFI9/NH42D7ZC03BnG33x?=
 =?us-ascii?Q?ZBZTR6tCRRQu0L6dUAfoDXcTi74sgP/hcWUeym9AFZqX75T8JYlo+F1QV4aW?=
 =?us-ascii?Q?sh/l/jsbzjaYX3IA0Zdqrcb+ihoKo64jPCKLRN6Zs5f+lddYaA9w5ZnN4/ZR?=
 =?us-ascii?Q?CghwMWOE+6UxU9UdC/FjBiNHQdUZWjb78NqxwtNnLl0lI7zGUbibK84EekAD?=
 =?us-ascii?Q?+9/CVXJPM+82Zfp4RVBfsqPr3f/sh6z3CcFzbPzvUU7dX3d6r5xu+YTHZcgK?=
 =?us-ascii?Q?9/Hl7GudaIre+FqNGzeR+0J1KQGWFnbilG9yFvkIDdTS4d6Jh0Og0Tg/Enka?=
 =?us-ascii?Q?QJWMdFfuUjV71MOnO6WEhbtCSfSA7Yuyjj9vEy7sfm/z2CEUPCIr+Yp9E93J?=
 =?us-ascii?Q?WtRZ83aBQYJHHkWpijZ17O1Nqu5WZNgJ6SQrv1ubqyOYzps5Mluxp5LNUYuC?=
 =?us-ascii?Q?OnMUOfEmZxr6frho3x0OgmEfJElGnp9W4qVweQhN6tXueP6ZXgbngn1oJQQS?=
 =?us-ascii?Q?7YbHgSQZZmJjYZ3aJcIgBsgQ9f3tEC7oA9RJQLr78h1UGJh9i2vb6NIDjKcp?=
 =?us-ascii?Q?2T6fFOjunlCszMZgNPpwWNj80EUc+0SbLEl8GoohQgL/lb9pTu/LkbEUAVXh?=
 =?us-ascii?Q?mee6bTadN9jFLU3UGxTJxLQ2mfJi9QnluNrI/JoL2zy3UyVHybU+7jybWnoV?=
 =?us-ascii?Q?AnHZQjQaFFgCVa8FD3hb4Ty4+4ChCGFFtCUcdx+7kUtpcHBiZkGjmNHQW5/4?=
 =?us-ascii?Q?4oObkREnW3nJzEjLaNz5XnQy50qXKtAzVne5euUaU35kqpz75bOM5Wm34Xow?=
 =?us-ascii?Q?V/vnAJRyDibL/PiPJyUccuS6BtP8OMV6wesUjgP18GBCBIKGcW24nwoZHpdF?=
 =?us-ascii?Q?4F9cau2DcZVkPIlb0PgJc26UVBJ0kXAvJGz6ttYoWKwEiDt6RJTpj7UWPK/Y?=
 =?us-ascii?Q?c1mFcyMWBzJ1ftLtbD9tUIngQ7KJe2YyR7Q6NIMR6/RusA+AX7gurLg7FqaR?=
 =?us-ascii?Q?h4LUixf8Fp/Q0lTu/GrKyh5LOLqxQ7BoMU95warA9yAqpe7V8hPvzXtstYAF?=
 =?us-ascii?Q?zPiurCzkK9DResY+OSVD62Eimf3xT0EgTDETVjb/rCfFO7PBkfqL/YDJcdsA?=
 =?us-ascii?Q?hX4H8ChVejCK/UsIsuKtJvfRVInmI+s+o7/Zq9HqRmuPNclAF1I8G/Xq+rR4?=
 =?us-ascii?Q?huNETIOaPXp6UCwWS0zELxn8L/9ADUbJR10I3e8efxEn4aktpjxhSQhNqlbA?=
 =?us-ascii?Q?3Rxg3/F58jvxqxTgCTxaZwrax0rEuxhONx9C9AopcHIsfG+WVeRoG4+uCobU?=
 =?us-ascii?Q?vE77cZCcaiKh6Mzs9tUj6EGAFl2whwP/rPgf0vRVSvJSg2mbcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0wF0Yril/J5V6VR2+sdUIr6ruEGc0Tpx2fwEO2Z8jFyhbeb9gtixPDr/7Hsj?=
 =?us-ascii?Q?nW7tTpwWjcoJJ34ZnyBV3PbWs22RrukRcQmoyv/NgHArKfhl5eyw2TLSHUtT?=
 =?us-ascii?Q?pTF617zzBLtO07Gm7Fx60cW5p7F15Ib98epm49otY6G7Cb33aCQ3pw3I2ogs?=
 =?us-ascii?Q?zcoohKn6jgKbBHEBKDM7RuWfma5UDzpzod6GJLX+2id6H3wWNF00X74IoIcE?=
 =?us-ascii?Q?nJ15vkuJQL4SZUACcD1hxWVYpLtYoSGF6zX293Y/nQA4RjDpwOb/Vz13195o?=
 =?us-ascii?Q?ClBigNagR7hDo9Gi57MB3GXtcMZkbUwDW9oOwVIG9SMq4OOUMPqCNZP+j9L5?=
 =?us-ascii?Q?6iAU7dcn3FwO3xvsd3JFGfae4ZcHgjjwuPiKt1YxW1UOiv0khOFKQKMAa+Eo?=
 =?us-ascii?Q?biwnxMRB+unVYrPdGruMIlZJhPmBMz6ZckZbuAR8bxyw/A/wPZ0/tmcFgqs7?=
 =?us-ascii?Q?JxIX3oLu3YX5TswLxBio4lPBm3XNS028LFRM3143gXjnwzAFCyXqKpJ7Os2s?=
 =?us-ascii?Q?7Db8pa9zghzaW8wVT6iUppq/yS7ORj2RAWp+UYZxifbz+fIxE1N+P/3oUYxw?=
 =?us-ascii?Q?3um97sjKVrnibQAi0IKCo0/sRBlquoD/qah5ehIMcyCaJAlJEc0UwvGMj06q?=
 =?us-ascii?Q?LIZpiECYlWWijgl05uvzM1lQyZ9rZHIbZhj9EvqFNTxlUGcWm+Pkyi+Y9C25?=
 =?us-ascii?Q?qCeA+18tpbfM1kC+8mr3JusHmjLXF5jKK3rZMXxTs9H/WyFfL8E9ry9sR5C4?=
 =?us-ascii?Q?jRY7qoZ1TtUGe/N0hoFG0tA6yZ0ThgIDDMPI5KL1zNKoO1txgtXZh4q3JEjZ?=
 =?us-ascii?Q?LMObCPwVcydpBT7q4SQ3TDSjhIuNd0WGwH4DeT1FCVrHbYgTRYlrq1MgajMY?=
 =?us-ascii?Q?kpZyp7Er7tP3ZA2V2uwVgK5m3TuauDmrkpkM5RSwq2aBPFeHmxErzukwRK0q?=
 =?us-ascii?Q?LxCAnZn6ytNKHt7o5hLfJoUpW/48mvnleHSkfJEpnlh2ovBEli+sUMfQ3C+p?=
 =?us-ascii?Q?ZUlq2rG/8tTTXfMogocx6U3Y6kLDzb8+mNevRJsCbuRY5HogegH4ijbhulCX?=
 =?us-ascii?Q?TH6ThEtCpm1nvds/FpzZXG9ImXEe2lBMa199VcifoO77P4ry3f7pJwZ0MGYk?=
 =?us-ascii?Q?rg5E9WcGGxLyhWHFGfe5V0U1xZFOTk9imp9olBil59Nw5F8WTHlcWGESUKMB?=
 =?us-ascii?Q?diueF8U4DpraSHlTB8qrmoMnYHbEILupspcild1U/ojyQenKkz8a18dMpNyH?=
 =?us-ascii?Q?/7Vfn0evJ7rleQEdWr6mEOEgr7JJQAwx75YMbrnB8UmSjAIBrx97f4gtKapO?=
 =?us-ascii?Q?f4rILuY5TrGypBPodFzQ9C32JPonSHhvCPC/vn9mvdLi8mOe6wOefyRpucfA?=
 =?us-ascii?Q?VH8ijeNeLLCGmhxioUi5BYFBXOVC1IFaIPYfKezNnQxmYZ4SduClY1VnXTQ1?=
 =?us-ascii?Q?SlzK3snYYIA2ak71X2y3Hg+vACbqKlyd181k6gGsg77DeGH0O+F1WrmoWk1I?=
 =?us-ascii?Q?afiqFGeyh/OUl7nlEZ1jWqOfkuxFmm0/pImVq+IW8sMp2AfG1w6zNo4f2TZk?=
 =?us-ascii?Q?wxPQ2INSLLXi3CtXldQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39810096-28ef-4466-89a8-08dcd28c91fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 18:07:16.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APxXw/KbVO6cQyNliQauW861HKfv0qOp4q/mz8N/HTAuZ2ycpp9/RLddWjEL4Hqw0bYcQx20i/FOvqt2F/FzuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9052

On Wed, Sep 11, 2024 at 11:33:56AM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 11, 2024 at 11:19:33AM -0400, Frank Li wrote:
> > On Wed, Sep 11, 2024 at 09:07:21AM -0500, Bjorn Helgaas wrote:
> > > [+cc Qianqiang]
> > >
> > > On Mon, Jul 29, 2024 at 04:18:18PM -0400, Frank Li wrote:
> > > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > > >
> > > > Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
> > > > the controller resembles that of iMX8MP, the PHY differs significantly.
> > > > Notably, there's a distinction between PCI bus addresses and CPU addresses.
> > > >
> > > > Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
> > > > need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
> > > > address conversion according to "ranges" property.
> > >
> > > > +static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> > > > +{
> > > > +	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> > > > +	struct dw_pcie_rp *pp = &pcie->pp;
> > > > +	struct resource_entry *entry;
> > > > +	unsigned int offset;
> > > > +
> > > > +	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
> > > > +		return cpu_addr;
> > > > +
> > > > +	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > > > +	offset = entry->offset;
> > > > +	return (cpu_addr - offset);
> > > > +}
> > >
> > > I'm sure that with enough effort, we could prove "entry" cannot be
> > > NULL here, but I'm not sure I want to spend the effort, and we're
> > > going to end up with more patches like this:
> > >
> > >   https://lore.kernel.org/r/20240911125055.58555-1-qianqiang.liu@163.com
> > >
> > > I propose this minor change:
> > >
> > >   entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > >   if (!entry)
> > >     return cpu_addr;
> > >
> > >   return cpu_addr - entry->offset;
> > >
> > > I still think we should get rid of the .cpu_addr_fixup() callback if
> > > possible.  But that's a discussion for another day.
> >
> > Stop these fake alarm from some tools's scan. entry never be NULL here.
> > I am working on EP side by involve a "ranges" support like RC side.
> >
> > Or just omit this kinds of patches.
>
> As I said initially, we probably *could* prove that "entry" can never
> be NULL here, but why should I have to spend the effort to do that?
> The "windows" list is not even built in this file, so it's not
> trivial.  And even if "entry" can't be NULL now, what's to prevent
> that assumption from breaking in the future?
>
> I don't think there's anything wrong with checking for NULL here, and
> it avoids copy/pasting this somewhere where it *does* matter.  So I'm
> in favor of this kind of patch.

I am fine for this change.

Frank

>
> Bjorn

