Return-Path: <bpf+bounces-32308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E0490B38A
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E651C21154
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925315533D;
	Mon, 17 Jun 2024 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MZDvpVfn"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2084.outbound.protection.outlook.com [40.107.6.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B849155328;
	Mon, 17 Jun 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634416; cv=fail; b=J7fmPdTyKUaeDNTGUvTbS1Wp+z2oBfDXMnme+gszqBDjMviUdrewKNbGgWAc8huzgaBtf1jUU2ep/Kl0eeniwzVz1UKQpv6ysybxrhBloQ3TXfvJweNOIAyormFDbhvMjaEe5Oy+8t8QxgY3SP7T8XqrQVXcoZcDa9w9YDPrqYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634416; c=relaxed/simple;
	bh=q5SHm9zpXztMGkUVWlACrw1QDoDflJAdoWyiXZ7h3tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vDZt1gQlVZ+LgakBIEnzresbwVFBBQM6bKuQdnMuCUsLnLn9xFFq4FfTTuEAp+yyJp9zqqmM1Chdw53h5vInrVrtShflOhLX8WGGA2CnWl7yIZf5irk9+UZKyOMpXba/UNe2PTKKvpvaRBeOPT3N2AZ9/JfshSLD7HHtfBCk8UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MZDvpVfn; arc=fail smtp.client-ip=40.107.6.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+9109ZSMNYe3EfwUbQ43XpqaWiP6B0ZgfLlOjXGPymXWx3blYQIBBpk0OET7xVuV3COBfGGZT6KJop/7i2rh9cby2Rp67LV0kgLaPOZDmCdmiKbxsOMpYfaOjFy9Z2cYc8vpvbri9pp/feSVOAhn1XIjfSvpiArRP1cTux/yOEcRa2Li9681GV8UqzQnLVld/qGUTVV0Jd0+4rBoY0Rv12UYfdivKh0nly6zt98f2gsJ0CJPk1rwQPYlfhxRfJTMN1K0zw7GwVYkpO34kcSRkKSKKoLw3rPYNoeSGTwEe2nZ54cc1ONxbvf5o5CiYObhBxRQH2oqVzoj/x9tMOLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRzFVGG5OWx08KI8GTY8amN42zDaAXNvMFJcAKsJ52M=;
 b=OHtk69Zsdf/tgtzEw15sM1S6vCvS9PJyHKD0OaHCDS5VdPJ1xMKFFCA6mLvcIyzSCdgl4+U0wYy8xZUolPxVN4Rc7uqlx5Vof2p4C12/wu2oPeqh1OIrbRPZ52AbUe9kbYVf9oJVwbY45bptpCaQPkUmJubaxcZ2cP47eodb1le+K7H7jJJXtumegVEWxJhHNJHrysJTEHv/Yfs/3n3PbbQeZNEBmy7CE3pIDIRaFvzPCeuyA3Wt+3l4PdyD+0eBGheFaRW4ZWqsj9XFKWtA8LX3irGTms6phPMIEqP3om7Sd9Y7XEWVboQeYSVgMkeQjsCNAhBp+R2AmvX8T8F4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRzFVGG5OWx08KI8GTY8amN42zDaAXNvMFJcAKsJ52M=;
 b=MZDvpVfnlgDMaXfm14Z4rrEqYio3iV3Xe6mfOZdf72aAGp+pSDeCR0o4prp0mdKBgljOr4Xb8gdgAS+MKSrvrWBag3xpAa9dYYTLz8//s9D8TfFv3d2ve8MZsBvR/aiw4bDKcVLrXkyXBM7R8ib24Ev6M7hfwzA+irGSs+Ispi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:26:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:26:50 +0000
Date: Mon, 17 Jun 2024 10:26:36 -0400
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
Message-ID: <ZnBHnPTp6I2qDD7P@lizhi-Precision-Tower-5810>
References: <ZmIa8dIahUdstpLo@lizhi-Precision-Tower-5810>
 <20240613224125.GA1087289@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613224125.GA1087289@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: ece09f67-1355-4bc4-7cb4-08dc8ed986e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9fiJiu56KlGRwEWWNsTS7K5IuuVYHrzeIjCUio+sYHQmKF6LgXoZeQfb+fza?=
 =?us-ascii?Q?PfuMmhoBKpY4ZHmqjqEgbGw5yuZZXfuE7v/zWsZuAOeSGJ4kV6vDN9ImhjqF?=
 =?us-ascii?Q?f0QiUdr0NDmTFXHdGsXSxEXrO0HpRN9GaNaubNbIaxHuvhpnZsJ3AkjNKn+E?=
 =?us-ascii?Q?ZdgmndPnZKOGm2eWGZCRYewqSJyiOPsbZuUun8vaakZrFO17wwahG//Oy5hI?=
 =?us-ascii?Q?aBDjD8ZWD21tqS2mys1HT+t/P73EsxArM70IhpBpM1WEF/xTQkiBfgcSBeOz?=
 =?us-ascii?Q?beB3cb8FoVcmIRQAjUdd/KXlxTrBL5FthTERA52YlEz7wOCaqucu3b9thK1G?=
 =?us-ascii?Q?ERL705hu9j9y+0bDNDRDcNgRiDexQgZhyQqbBSNkApOE09roclbAk3xHRqQq?=
 =?us-ascii?Q?jYVuLoBjlZahvb4T2wQlFERUgnFbnbbZAQKdLY4cGnesu+1DlUEC2C3whS5q?=
 =?us-ascii?Q?eDOJzvHElNsVfxdr4wK/0VEXFpkS1UrD00aSz9qTEEz6rKN2YNIfRvDriAL4?=
 =?us-ascii?Q?bjByEfMKOYqZMBbbcTRUmK6rT8/mHWKcwyKuq+iJKhrA95C/LP9YZnsEJkrF?=
 =?us-ascii?Q?ITy+6A30ELJOCefMi5dxt1VhuVUKkA4GI4c4Fc3bmvPTJZHtrTLMdC6KwHaO?=
 =?us-ascii?Q?FIYbyh/0bJVxOVuTDm+7N0rYuaqu8laSiGa8YI4hnzOtBhcZrhSEdntVQGdW?=
 =?us-ascii?Q?0lq6rvS0bgIRGp6gixToyMbrirZVRumLzlftwP9r3XR6hlU9NVOemUPdzNqE?=
 =?us-ascii?Q?2JbpTOAAa8qQFpdCPITu1wU/kKe0fQQdsepD8KoLg1U7zWbjViZJJb/hXcVt?=
 =?us-ascii?Q?V75POCY9pEvhQ/1MkPuw+9Pam1ivO0h+CNucJJkMIoxe6i3ysbKdLZMFdhrx?=
 =?us-ascii?Q?KW0DyHcOfrRogGMLn70NUPc5MtuqG8MXxy8x0dIbkweQvyPtl7R1bG2f8gfS?=
 =?us-ascii?Q?vmQK1VxmZeSJFuQ3h1/o5D6IbVr6DuJhVD0v6C/jQhlEEZc51717JVLInjwK?=
 =?us-ascii?Q?5FlbfslOqiqpjqRFmjhgNzsdBrXiRUBoGB+TyP/XoDX762v101wmHYfJuxWL?=
 =?us-ascii?Q?8AVAnrwxhQcVxiIWcGO3IsVitovS/cvgxzIb+a6S69plRZHa807SW6+dU7cE?=
 =?us-ascii?Q?d/LfhsNMwExfXc9mXaJKBGOgzOYk5hEp+Bmj6mO2f3Nw73aOqHxkbvqV+ban?=
 =?us-ascii?Q?2K6wMn8xXwi8s0m9GPi20wDrm7nux5ptkkC2oyOAeWEcNbnFVzYp/DgyFo5U?=
 =?us-ascii?Q?pMiXodi/uuUCFVQBl8av8xW29RHJ/GlLZvB1QwYvCDDgu/I0Bk//5QS38Vyj?=
 =?us-ascii?Q?FRM/xeOGnDTUu0PUQ4oCBivO4pQ3gJkyQ/Kiqq14drWoZceIUp/86om2EYjp?=
 =?us-ascii?Q?dvCwCuc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oycDNzD2oOmbrvVTPVMImLJt0r1EA/BKIrJJYyOWTBPPbElNRtzs4S6tjD8u?=
 =?us-ascii?Q?eIKnRqEjMboaEWiAZFs/8UTw7sgmh9AyF1AP8HpdhjkXCZHM6k6BG7uXwO0y?=
 =?us-ascii?Q?PQmcQcolv3tGlilIxLzboOPuamRKWD+UBHWDdP7WymFd3p2Z8P27TeRvq0MI?=
 =?us-ascii?Q?NucDOGNRETO6q1Tf7RmgAqEwnPDh60xAQNssvZanr6BIUAaWeplmtZDR3Pyl?=
 =?us-ascii?Q?37PoTXqw8z3wEdbNScKcPH2x2CT8IprJUdh5rmnPt4Zzl9vZITgmw+KDEhuk?=
 =?us-ascii?Q?2W7EJg4wBH/ND/eHpEYp6BhJDT9lzMZDZRc1/l39d8rNqMK4bjxBGL+5LAI7?=
 =?us-ascii?Q?dAa5nFgkx3Vi0NUIVgQA/fqlP3gYvIw+IVLyV5Om7LBBJlsemQPH8jVc//DL?=
 =?us-ascii?Q?2QYfnfFwjhh6pYQiT1F/Ncj9tH0iHV8XscHRDOqLMXtVOYIC9A0P+z/dA9n6?=
 =?us-ascii?Q?6aJ8DyhbOf85l2mmocdagOXY281srUkQg4GN3wM33qXXBOApOsbvQfZTRA38?=
 =?us-ascii?Q?pLlbJIvVy9TlRjYz0/uqfcYXmDq3qdrWmkSl0pSWsa/Zb+F/P/fHB2/fj6QV?=
 =?us-ascii?Q?Pci5KMMCh52aJTXDtUCr/NR5OhwdAzxTjYkYK52T90I4XR9Yu32k2kNmg7/4?=
 =?us-ascii?Q?LU62hs9whAglMVxxP0Afqm7wLJ75E17FBH+DpNY8/Tb5QqAir7jnVD5SPiPA?=
 =?us-ascii?Q?yEn8zU4Al+9B0SUqJUMgEU//c1c18QnonxvBot9mGb167zaKWTlXcvHyWgOj?=
 =?us-ascii?Q?VAULzJBDWsjvR12Y8WOxbg5Cyhbt2471KPi3ZlTNhZ/f7DsbOSuUjraEl/IG?=
 =?us-ascii?Q?/vsUSiGVsKyD3rVH4S0ga762BJNvj86EA9rDdBQVze/cLoXJwadBF6oWYO6T?=
 =?us-ascii?Q?ZVSLJxkK+d7gNlS2IBYgewZMvPjNEKJaS9ueFJO2Y089U5Sj6P9wam0q0YH4?=
 =?us-ascii?Q?ATv/xfFNzUN1W1yhutL8W5Jym3fYybtSnfZU/hpb2t1p94pUbl6O9S3ygUE6?=
 =?us-ascii?Q?yexyR8fkoF4EgYJ/x3S8wjn4Oto8oaAQm7qk333zxKn/PrTqBsZf81Icl9sV?=
 =?us-ascii?Q?P1FBJUEZUtE7/BaIuzGOBrA+Uz0i+Np3M7SIkqXVP5GlyvBuYqR5KJaZcFwp?=
 =?us-ascii?Q?CNRxSz4SUJrJLcyu4MG2WVzk1MEo75cDYYlgrTZF6V2WfckQeMDKZMZeZxYq?=
 =?us-ascii?Q?ROvm4Xuju82D5FY9hP+uaV5zJVM3szl5JbXv4bhtEA1kTsM7+O8N7/vg1cqX?=
 =?us-ascii?Q?TCpe328LDpyl5ZKxhRHkEmzRr/mTAABCNbLYvhzo/R4gFWp4b9HFi5mlsYy4?=
 =?us-ascii?Q?cEkTgHTBsjO6SWQrEhOGrfPt7FMY7XTzOLMZrQ7t3hmL4YGISEJTEFJ11jE+?=
 =?us-ascii?Q?ACGOkjt047n9vGmTZFxT9wXlpE4c145uYrzmOWE9xe+mRrB6RjjU3KkGdeC7?=
 =?us-ascii?Q?UC54DwmSy0kX8wnHiKzSqPh+RL2pYsN1a0nc/1CvMZKn3aeEVhRmyrFGVmq7?=
 =?us-ascii?Q?skA9wv6qrP7/XI9XB898CnnDIfVw9yCnOM3sHRl6czAh5nuaYhS86e17Ntrz?=
 =?us-ascii?Q?hvLqEWou+2juNwpVuGo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece09f67-1355-4bc4-7cb4-08dc8ed986e9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:26:50.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: difwgceVfIfe/lBSGDu6XwYG4pa9qDFT01Wn1C90u1/b7UNp62vjNGtX78EnsQcqcBRVdWVXjG4j37dW753GQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335

On Thu, Jun 13, 2024 at 05:41:25PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 06, 2024 at 04:24:17PM -0400, Frank Li wrote:
> > On Mon, Jun 03, 2024 at 04:07:55PM -0400, Frank Li wrote:
> > > On Mon, Jun 03, 2024 at 01:56:27PM -0500, Bjorn Helgaas wrote:
> > > > On Mon, Jun 03, 2024 at 02:42:45PM -0400, Frank Li wrote:
> > > > > On Mon, Jun 03, 2024 at 12:19:21PM -0500, Bjorn Helgaas wrote:
> > > > > > On Fri, May 31, 2024 at 03:58:49PM +0100, Robin Murphy wrote:
> > > > > > > On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> > > > > > > > [+cc IOMMU and pcie-apple.c folks for comment]
> > > > > > > > 
> > > > > > > > On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > > > > > > > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > > > > > > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > > > > > > > This involves examining the msi-map and smmu-map to ensure consistent
> > > > > > > > > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > > > > > > > > registers are configured. In the absence of an msi-map, the built-in MSI
> > > > > > > > > controller is utilized as a fallback.
> > > > > > > > > 
> > > > > > > > > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > > > > > > > > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > > > > > > > > controller. This function configures the correct LUT based on Device Tree
> > > > > > > > > Settings (DTS).
> > > > > > > > 
> > > > > > > > This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> > > > > > > > have to do this, I wish it were *more* similar, i.e., copy the
> > > > > > > > function names, bitmap tracking, code structure, etc.
> > > > > > > > 
> > > > > > > > I don't really know how stream IDs work, but I assume they are used on
> > > > > > > > most or all arm64 platforms, so I'm a little surprised that of all the
> > > > > > > > PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> > > > > > > > this notifier.
> > > > > > > 
> > > > > > > This is one of those things that's mostly at the mercy of the PCIe root
> > > > > > > complex implementation. Typically the SMMU StreamID and/or GIC ITS DeviceID
> > > > > > > is derived directly from the PCI RID, sometimes with additional high-order
> > > > > > > bits hard-wired to disambiguate PCI segments. I believe this RID-translation
> > > > > > > LUT is a particular feature of the the Synopsys IP - I know there's also one
> > > > > > > on the NXP Layerscape platforms, but on those it's programmed by the
> > > > > > > bootloader, which also generates the appropriate "msi-map" and "iommu-map"
> > > > > > > properties to match. Ideally that's what i.MX should do as well, but hey.
> > > > > > 
> > > > > > Maybe this RID-translation is a feature of i.MX, not of Synopsys?  I
> > > > > > see that the LUT CSR accesses use IMX95_* definitions.
> > > > > 
> > > > > Yes, it convert 16bit RID to 6bit stream id.
> > > > 
> > > > IIUC, you're saying this is not a Synopsys feature, it's an i.MX
> > > > feature.
> > > 
> > > Yes, it is i.MX feature. But I think other vendor should have similar
> > > situation if use old arm smmu.
> > > 
> > > > 
> > > > > > > If it's really necessary to do this programming from Linux, then there's
> > > > > > > still no point in it being dynamic - the mappings cannot ever change, since
> > > > > > > the rest of the kernel believes that what the DT said at boot time was
> > > > > > > already a property of the hardware. It would be a lot more logical, and
> > > > > > > likely simpler, for the driver to just read the relevant map property and
> > > > > > > program the entire LUT to match, all in one go at controller probe time.
> > > > > > > Rather like what's already commonly done with the parsing of "dma-ranges" to
> > > > > > > program address-translation LUTs for inbound windows.
> > > > > > > 
> > > > > > > Plus that would also give a chance of safely dealing with bad DTs specifying
> > > > > > > invalid ID mappings (by refusing to probe at all). As it is, returning an
> > > > > > > error from a child's BUS_NOTIFY_ADD_DEVICE does nothing except prevent any
> > > > > > > further notifiers from running at that point - the device will still be
> > > > > > > added, allowed to bind a driver, and able to start sending DMA/MSI traffic
> > > > > > > without the controller being correctly programmed, which at best won't work
> > > > > > > and at worst may break the whole system.
> > > > > > 
> > > > > > Frank, could the imx LUT be programmed once at boot-time instead of at
> > > > > > device-add time?  I'm guessing maybe not because apparently there is a
> > > > > > risk of running out of LUT entries?
> > > > > 
> > > > > It is not good idea to depend on boot loader so much.
> > > > 
> > > > I meant "could this be programmed once when the Linux imx host
> > > > controller driver is probed?"  But from the below, it sounds like
> > > > that's not possible in general because you don't have enough stream
> > > > IDs to do that.
> > > 
> > > Oh! sorry miss understand what your means. It is possible like what I did
> > > at v3 version. But I think it is not good enough. 
> > > 
> > > > 
> > > > > Some hot plug devics
> > > > > (SD7.0) may plug after system boot. Two PCIe instances shared one set
> > > > > of 6bits stream id (total 64). Assume total 16 assign to two PCIe
> > > > > controllers. each have 8 stream id. If use uboot assign it static, each
> > > > > PCIe controller have below 8 devices.  It will be failrue one controller
> > > > > connect 7, another connect 9. but if dynamtic alloc when devices add, both
> > > > > controller can work.
> > > > > 
> > > > > Although we have not so much devices now,  this way give us possility to
> > > > > improve it in future.
> > > > > 
> > > > > > It sounds like the consequences of running out of LUT entries are
> > > > > > catastrophic, e.g., memory corruption from mis-directed DMA?  If
> > > > > > that's possible, I think we need to figure out how to prevent the
> > > > > > device from being used, not just dev_warn() about it.
> > > > > 
> > > > > Yes, but so far, we have not met such problem now. We can improve it when
> > > > > we really face such problem.
> > > > 
> > > > If this controller can only support DMA from a limited number of
> > > > endpoints below it, I think we should figure out how to enforce that
> > > > directly.  Maybe we can prevent drivers from enabling bus mastering or
> > > > something.  I'm not happy with the idea of waiting for and debugging a
> > > > report of data corruption.
> > > 
> > > It may add a pre-add hook function to pci bridge. let me do more research.
> > 
> > Hi Bjorn:
> > 
> > int pci_setup_device(struct pci_dev *dev)
> > {
> > 	dev->error_state = pci_channel_io_normal;
> > 	...
> > 	pci_fixup_device(pci_fixup_early, dev);
> > 
> > 	^^^ I can add fixup hook for pci_fixup_early. If not resource, 
> > I can set dev->error_state to pci_channel_io_frozen or
> > pci_channel_io_perm_failure
> > 	
> > 	And add below check here after call hook function.
> > 
> > 	if (dev->error_state != pci_channel_io_normal)
> > 		return -EIO;
> > 		
> > }
> > 
> > How do you think this method? If you agree, I can continue search device
> > remove hook up.
> 
> I think this would mean the device would not appear to be enumerated
> at all, right?  I.e., it wouldn't show up in lspci?  And we couldn't
> use even a pure programmed IO driver with no DMA or MSI?

Make sense. Let me do more research on this.

Frank
> 
> I wonder if we should have a function pointer in struct
> pci_host_bridge, kind of like the existing ->map_irq(), where we could
> do host bridge-specific setup when enumerating a PCI device.
> 
> We'd still have to solve the issue of preventing DMA, but a hook like
> that might avoid the need for a quirk or the bus notifier approach.
> 
> Bjorn

