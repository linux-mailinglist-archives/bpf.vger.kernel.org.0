Return-Path: <bpf+bounces-32921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C27191513A
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 17:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932391C230B1
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8310919ADB1;
	Mon, 24 Jun 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C/wxKQIe"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6481DFD1;
	Mon, 24 Jun 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241246; cv=fail; b=rC0CNZhku1LCUMenSjaSDVwYbtC43EppuWsNGfQpHXTBlwkmsaYY4Ek3yLkoScjlXtIgJ1rR9wgvZIC8rRfSxcMcKfpmjoDlxO959lkHt3jC5QTpxZ8g/ky7UjqTrXnkkQCSQtIbk4rEp4tnzNryhNHVc1a7Aa3SdKUlMoDJpGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241246; c=relaxed/simple;
	bh=EUq12eUSawT3CQiNr9SRACjHfGzEyrgKA2lfZzC9nwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=igV8HE4jbjlwKPvgGn37R+1p/9f2LZQEEMOkS30zflCDvhs1i9EXcQ96BMcpEMMwsZWnV1eSxEQ+dCeD+6asbaO0+cnVzPm6EPeFda+XbMK0kkUmtp+CtyX4kss0U4MoecaiYwdqMzouOSL9KN90F5i/ZMkd9Tm7SOqVqtTfY3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=C/wxKQIe; arc=fail smtp.client-ip=40.107.6.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l211PTk/AlYoOyZQs8uhkol5bR7bHeromLPW8GWnJLVxa4zOzCizgT7QMf7o+J/bRGtfg7lOcVUaD0sqP3FppQz9SIRKgKdjyhjrAuvZ6cDNhivJfswphzt3ScgXqbeFX6MVQfE5yaBBlH6p36CfRgxtLD5SPnMqYBScIbM/NFrkcucPzPKI+Jq0ncvlb4TteH84FYTPtAEyGLcF0x+yxYTMbt4hFcUyayBzqc2VMdShbZ0pHZNpaGpVbnQMwLsyzViVLRaNPKg6NsBWEw52Gv90OziJZbZIf/4q/XSDaTafEl1Wd9OJ/y9PJ5lQgqhzfIn0e/Dehn9GeoInMsJEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71AFezmr/iU9ajfbnv/Tt5ZKRiNW8QN7wp52wmUPvlU=;
 b=OEPJaBWWwG+1tdsrk+1EzoTH/SRZThY8siMLbCx5dLuqGkgyeOqtoV/PWp5TVzg5LQYXfO0L8Gizt8igFuD/XQ6PXbJlmk9vHjvngz+GNi0YmeqhtuZIg1Cr/F2R1mVkvQKncN0RSk4MF6V1CinyXEXcnXlhI59rMiP/45h2IRGxRQFE7a2TZczhl9KbVzLVkXFJKJwOZnQ/9kORz/sC4p+j9dfEhzptfBzaCDj6CiBuAYWW8qILoT/XgHq4VXX0Ww/4Xoi4HpoWbkOgKJFf62XYyQ4S2DIx8N0n9OUvJY7o11NNsSj0AiJbjXK3ff+76X6k5OTjo8plbEhTLiGLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71AFezmr/iU9ajfbnv/Tt5ZKRiNW8QN7wp52wmUPvlU=;
 b=C/wxKQIe1Fm03sTi0X4zVuyCRWiECS4b2TcxdekLk2wyZqh3fLKKfUuaYz2bLSp5704Zztc41zpkYLbhH9v4bCot0ANZi0mPqLPvZMUm+XSaUtLGnowEE9KGYxdZa1ICFiAx2x8ttFvQ3UQXlX3L1V548qdYKmWkkLyohsfmano=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 15:00:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Mon, 24 Jun 2024
 15:00:40 +0000
Date: Mon, 24 Jun 2024 11:00:29 -0400
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
Message-ID: <ZnmKDYg2lsJVlILk@lizhi-Precision-Tower-5810>
References: <20240621224321.GA1410825@bhelgaas>
 <20240622173849.GA1432357@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622173849.GA1432357@bhelgaas>
X-ClientProxiedBy: BYAPR08CA0054.namprd08.prod.outlook.com
 (2603:10b6:a03:117::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: 12621681-f679-4abb-1c0a-08dc945e69da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yxwuQncggjGliaR8zdUKuxb/XSRMYYX10dG3YoFJle3k+5C4Ur7TmHg7p2YN?=
 =?us-ascii?Q?ow1Uh28k/fJzuVjdgKZvmmDsrr8TDMvm//J5Q5GbnKuuEwxPLo8ZtDlv12FC?=
 =?us-ascii?Q?4TLYixPKvasGik37iAWbqVxcZrrPHvtI2p+iYE3mPXM41gZYTZ6jNX4ZGUaY?=
 =?us-ascii?Q?6WqRWoc+iXZUQM1e8wd1pdhahDrhfrzJQzbP0iYOcoklhuiKYICnnnd0gXDT?=
 =?us-ascii?Q?tV242BZBWXAH/RI9S8MH5zTG63yrwNj0/ClfYDTpQ+fKanEX+kx0wttR2i8P?=
 =?us-ascii?Q?+flrkwq6ZMHGjh0t3mX4sMP9SWuFCRIkqTsU+TyCNT/reJwq3mvI2NK+fUUb?=
 =?us-ascii?Q?cQ+biOpPDs2W7NFt6o0QiOsOQqKUknNi0vTGnxd1mooa90TLaOZEo5lrjpbx?=
 =?us-ascii?Q?7vkpMiIznQ8raGdPg1RVA+uxthapuj7SH6fC4ipiq7UBSG27hr/26LTAL9dN?=
 =?us-ascii?Q?9ZGWrAcmwbhGq9spwPQaf4NXozXXe17kuPu8hp7rBosQopXkxDcC6Stvsyfa?=
 =?us-ascii?Q?vmWlssRcmu9eULP+e9BTfc5LUk5C1Je5rNLookHUZmZITlNZsD5T7hheJKGz?=
 =?us-ascii?Q?9xox3sOK0EN28Vq8fgPqg6FV1e1PUOYqR+Zjw+DDxJQ/L0ah/OHEA9ivV1Tp?=
 =?us-ascii?Q?CbpniVru66SAqB4Ar1Vk8ezs71xLWr2bhaCTpl9DLtn/+CXPPuxsSAqdFCKE?=
 =?us-ascii?Q?WySANGxSwTvch5P+iIdL/0PYN9pnSKKBr5dDooANzZpUh0hIz9zC2Ah39vqo?=
 =?us-ascii?Q?+dvH/EigwrfoV/t4/WjO7OJlCfuTGp6VXejYmis0dsjA3pT8dpDS8vsfFV+3?=
 =?us-ascii?Q?T4kdee1ZleyrsZxXJHHOiU/y/pQxipWPb9PAozAJtcMApB/y4lW0EBbVKMSI?=
 =?us-ascii?Q?A7kQgUKTbigTytSckWZbuM7y8DiR++0z8kXUuDe0rQV//+/AGJ5gfDQGPe43?=
 =?us-ascii?Q?YzO5SKOQkW3uaOEWL5K0BTq48Cu1c5ReZNEbG+D5vsVdkCp0wjMYvaWq0xgG?=
 =?us-ascii?Q?EgY+32PqT4LruK8fmtqAfEM1DLuMhhmkbzDNY7vJG0ePuC8rUpCyuOsTtTDu?=
 =?us-ascii?Q?s5cfvWLIim8kHF/+vyPSiGhXcexYrrrXARUOghm1Hn2dM4fm4ikzpP0UhQIn?=
 =?us-ascii?Q?kZdOky2GaYePHp8oyRDFcrbJ2weJCawFuIV7XxBRR5JrPmggAjsZSdctQxru?=
 =?us-ascii?Q?eCxSu5TPObrC7Ry36+1RiwSlKlVqFfPwF/FSgYjXQ9Li5bfCluXphT4eQsN0?=
 =?us-ascii?Q?cpBeAut7SWdZyCdhcjf4k//1md5lYu3AFzAII2J8F8/cE1KMpkg3d8KZAP9i?=
 =?us-ascii?Q?fl/3JqFa3fyl1IDvqr/WI/CJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HotDFeJ+qltxdOI7hlcumYPjSyujJi7uWBSOQjS2DGFN5LcANQhZmRHKiaYO?=
 =?us-ascii?Q?2PM+SVokT1ovEdjrBLy//9cChUfyDXaIA9DFjs7xXnMfNY6b8XRH4NB5PL45?=
 =?us-ascii?Q?340q9Xws2tijIeCQaQzKFjnU39w1CED0XTTy2p8MvPJSyDM/PKblIyLUjj4S?=
 =?us-ascii?Q?mOpcymsZ8tgHh6Os7Wg/S1wDCqfiBaSCHiK1SUrRs/EJtEuSJkMamr9lTU06?=
 =?us-ascii?Q?RFKKKXn9qFe6b6xIt8IOD9oqNyPY+SszMBwXxj0pKuTOPaNms61KZ3Fl04FC?=
 =?us-ascii?Q?+WC2z4m7FJkJasp0mJnWk1R/laXyH8qn79YgbsO0GKGAEc5vyPgs7IQAT5JN?=
 =?us-ascii?Q?oOze690/1RL0Je9SOD/hFNe1EUQS9YocRDKhaykhWaEO1KU7HMspyPdGP86v?=
 =?us-ascii?Q?sqRYSjzfiIdr06dvDVV/Y8AX57ff+KtvQnmDTrtFiW/C4Z2SFl9tSl2cF0kj?=
 =?us-ascii?Q?659jOpxmMisBKZCT4tVo0/I4txah7zVvx2xMcgfOuaUdCv3InUReOza0vtNH?=
 =?us-ascii?Q?sA//7DymgNoSiJ2pp/LpmZfzXww4WT8RWRGGJvlz0K5vcB0Fs8ESXDfXm0lS?=
 =?us-ascii?Q?JPblx8k6LUqc16WGQR6YCYvG9LIxR3qjhspiO5ePp65K1uLqzwTPUD7n7zTW?=
 =?us-ascii?Q?jhy3khZsWrb+4WAk47Ro8m92caovDFgX3Yeg6iJ4g+zVshaZmRANLMapk2uM?=
 =?us-ascii?Q?yevB9sFoOMoOTrEbmqFSo9BhUDRstTvJx2hfDg1zy1FrkqUBEaa3GAZ0FqcR?=
 =?us-ascii?Q?+4LlKV0vS2elw43bPxGVv3eeSSPJdK5hy/aI5L23PxTMUSfvkEIWHVRCinF+?=
 =?us-ascii?Q?jiZR1ikSKAKf7n3xenzubgX2caiQQYxcRgb43Wc6PVCb9beOl3+6CTseg6Cn?=
 =?us-ascii?Q?5g1h1JRjmfbf/zmLeQt03dyCM59mqFGjG/8xVWrMej+pjnfDBghDe4JQ7Qi0?=
 =?us-ascii?Q?OLMXhwCTc5p9Ytlrx84wfmTjFUfUmttJysAI0s3SXMoBO0BlWFuZgGzb59Qa?=
 =?us-ascii?Q?EBQfZmcf9rId0XCm6BZEeuWUbunjXf1ulDex18UrG393siz4JmTFUtkG6Ly5?=
 =?us-ascii?Q?Bq3Yxtd1IOLZZWBplUhzspbH+PJFoIKr0Td1l2jF6aWQusLXJpoCFMIQxc09?=
 =?us-ascii?Q?hjF7W6pdoebqK+NRqoUx6PvsrB04jFblfNBDwSzE8u5QRzdlTzRmYOjPX3uU?=
 =?us-ascii?Q?75fHsrM2Q8Rfjhth71lvXCdiB8hDCcT9z7+mzIAdm+llFhJ3kFMechvQaXT0?=
 =?us-ascii?Q?Su0LNknOHLqThaEnIstJL3JAUh7ueboqWwe3gTptSy3m+YNeekAlwVACII+J?=
 =?us-ascii?Q?tjFJ9eDrH/nzBI1zhi9G6nrXqIdHqE0dvkVXM3oAqh17mZ5+v9EuquD57jTI?=
 =?us-ascii?Q?HjR+5C8ayhF7SGPhMQ/T5Vxi0QW7WudzQjNkCEJX/PAJGs9Op42fdgr1lX5C?=
 =?us-ascii?Q?lnd7G9UFrP4ujRAtQZLooPN+IH6yodynRkxmPhdMk9b/l//MG6b6x82zgWPN?=
 =?us-ascii?Q?IceztwhtP2m+E8jMLSQte2OD4C75FJ0olYhD+m8xrbN0R3p+KMEkOzNAXVUt?=
 =?us-ascii?Q?WS3IqWC4IMUHAoonkV+KKt0GlMjVohoz3AdNaTVa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12621681-f679-4abb-1c0a-08dc945e69da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:00:40.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izNiBA7u+kn47294+P+J4hnA0EE7dqkHFHySarFgPBCrLp3EwaVuq8khhezpnIcpNI3Oqbq67zbbo8zznY3YVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849

On Sat, Jun 22, 2024 at 12:38:49PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 21, 2024 at 05:43:21PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 21, 2024 at 06:29:48PM -0400, Frank Li wrote:
> > > On Mon, Jun 17, 2024 at 10:26:36AM -0400, Frank Li wrote:
> > > > On Thu, Jun 13, 2024 at 05:41:25PM -0500, Bjorn Helgaas wrote:
> > > > > On Thu, Jun 06, 2024 at 04:24:17PM -0400, Frank Li wrote:
> > > > > > On Mon, Jun 03, 2024 at 04:07:55PM -0400, Frank Li wrote:
> > > > > > > On Mon, Jun 03, 2024 at 01:56:27PM -0500, Bjorn Helgaas wrote:
> > > > > > > > On Mon, Jun 03, 2024 at 02:42:45PM -0400, Frank Li wrote:
> > > > > > > > > On Mon, Jun 03, 2024 at 12:19:21PM -0500, Bjorn Helgaas wrote:
> > > > > > > > > > On Fri, May 31, 2024 at 03:58:49PM +0100, Robin Murphy wrote:
> > > > > > > > > > > On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> > > > > > > > > > > > [+cc IOMMU and pcie-apple.c folks for comment]
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > > > > > > > > > > > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > > > > > > > > > > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > > > > > > > > > > > This involves examining the msi-map and smmu-map to ensure consistent
> > > > > > > > > > > > > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > > > > > > > > > > > > registers are configured. In the absence of an msi-map, the built-in MSI
> > > > > > > > > > > > > controller is utilized as a fallback.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > > > > > > > > > > > > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > > > > > > > > > > > > controller. This function configures the correct LUT based on Device Tree
> > > > > > > > > > > > > Settings (DTS).
> > > > > > > > > > > >
> > > > > > > > > > > > This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> > > > > > > > > > > > have to do this, I wish it were *more* similar, i.e., copy the
> > > > > > > > > > > > function names, bitmap tracking, code structure, etc.
> > > > > > > > > > > >
> > > > > > > > > > > > I don't really know how stream IDs work, but I assume they are used on
> > > > > > > > > > > > most or all arm64 platforms, so I'm a little surprised that of all the
> > > > > > > > > > > > PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> > > > > > > > > > > > this notifier.
> > > > > > > > > > >
> > > > > > > > > > > This is one of those things that's mostly at the mercy of the PCIe root
> > > > > > > > > > > complex implementation. Typically the SMMU StreamID and/or GIC ITS DeviceID
> > > > > > > > > > > is derived directly from the PCI RID, sometimes with additional high-order
> > > > > > > > > > > bits hard-wired to disambiguate PCI segments. I believe this RID-translation
> > > > > > > > > > > LUT is a particular feature of the the Synopsys IP - I know there's also one
> > > > > > > > > > > on the NXP Layerscape platforms, but on those it's programmed by the
> > > > > > > > > > > bootloader, which also generates the appropriate "msi-map" and "iommu-map"
> > > > > > > > > > > properties to match. Ideally that's what i.MX should do as well, but hey.
> > > > > > > > > >
> > > > > > > > > > Maybe this RID-translation is a feature of i.MX, not of Synopsys?  I
> > > > > > > > > > see that the LUT CSR accesses use IMX95_* definitions.
> > > > > > > > >
> > > > > > > > > Yes, it convert 16bit RID to 6bit stream id.
> > > > > > > >
> > > > > > > > IIUC, you're saying this is not a Synopsys feature, it's an i.MX
> > > > > > > > feature.
> > > > > > >
> > > > > > > Yes, it is i.MX feature. But I think other vendor should have similar
> > > > > > > situation if use old arm smmu.
> > > > > > >
> > > > > > > >
> > > > > > > > > > > If it's really necessary to do this programming from Linux, then there's
> > > > > > > > > > > still no point in it being dynamic - the mappings cannot ever change, since
> > > > > > > > > > > the rest of the kernel believes that what the DT said at boot time was
> > > > > > > > > > > already a property of the hardware. It would be a lot more logical, and
> > > > > > > > > > > likely simpler, for the driver to just read the relevant map property and
> > > > > > > > > > > program the entire LUT to match, all in one go at controller probe time.
> > > > > > > > > > > Rather like what's already commonly done with the parsing of "dma-ranges" to
> > > > > > > > > > > program address-translation LUTs for inbound windows.
> > > > > > > > > > >
> > > > > > > > > > > Plus that would also give a chance of safely dealing with bad DTs specifying
> > > > > > > > > > > invalid ID mappings (by refusing to probe at all). As it is, returning an
> > > > > > > > > > > error from a child's BUS_NOTIFY_ADD_DEVICE does nothing except prevent any
> > > > > > > > > > > further notifiers from running at that point - the device will still be
> > > > > > > > > > > added, allowed to bind a driver, and able to start sending DMA/MSI traffic
> > > > > > > > > > > without the controller being correctly programmed, which at best won't work
> > > > > > > > > > > and at worst may break the whole system.
> > > > > > > > > >
> > > > > > > > > > Frank, could the imx LUT be programmed once at boot-time instead of at
> > > > > > > > > > device-add time?  I'm guessing maybe not because apparently there is a
> > > > > > > > > > risk of running out of LUT entries?
> > > > > > > > >
> > > > > > > > > It is not good idea to depend on boot loader so much.
> > > > > > > >
> > > > > > > > I meant "could this be programmed once when the Linux imx host
> > > > > > > > controller driver is probed?"  But from the below, it sounds like
> > > > > > > > that's not possible in general because you don't have enough stream
> > > > > > > > IDs to do that.
> > > > > > >
> > > > > > > Oh! sorry miss understand what your means. It is possible like what I did
> > > > > > > at v3 version. But I think it is not good enough.
> > > > > > >
> > > > > > > >
> > > > > > > > > Some hot plug devics
> > > > > > > > > (SD7.0) may plug after system boot. Two PCIe instances shared one set
> > > > > > > > > of 6bits stream id (total 64). Assume total 16 assign to two PCIe
> > > > > > > > > controllers. each have 8 stream id. If use uboot assign it static, each
> > > > > > > > > PCIe controller have below 8 devices.  It will be failrue one controller
> > > > > > > > > connect 7, another connect 9. but if dynamtic alloc when devices add, both
> > > > > > > > > controller can work.
> > > > > > > > >
> > > > > > > > > Although we have not so much devices now,  this way give us possility to
> > > > > > > > > improve it in future.
> > > > > > > > >
> > > > > > > > > > It sounds like the consequences of running out of LUT entries are
> > > > > > > > > > catastrophic, e.g., memory corruption from mis-directed DMA?  If
> > > > > > > > > > that's possible, I think we need to figure out how to prevent the
> > > > > > > > > > device from being used, not just dev_warn() about it.
> > > > > > > > >
> > > > > > > > > Yes, but so far, we have not met such problem now. We can improve it when
> > > > > > > > > we really face such problem.
> > > > > > > >
> > > > > > > > If this controller can only support DMA from a limited number of
> > > > > > > > endpoints below it, I think we should figure out how to enforce that
> > > > > > > > directly.  Maybe we can prevent drivers from enabling bus mastering or
> > > > > > > > something.  I'm not happy with the idea of waiting for and debugging a
> > > > > > > > report of data corruption.
> > > > > > >
> > > > > > > It may add a pre-add hook function to pci bridge. let me do more research.
> > > > > >
> > > > > > Hi Bjorn:
> > > > > >
> > > > > > int pci_setup_device(struct pci_dev *dev)
> > > > > > {
> > > > > > 	dev->error_state = pci_channel_io_normal;
> > > > > > 	...
> > > > > > 	pci_fixup_device(pci_fixup_early, dev);
> > > > > >
> > > > > > 	^^^ I can add fixup hook for pci_fixup_early. If not resource,
> > > > > > I can set dev->error_state to pci_channel_io_frozen or
> > > > > > pci_channel_io_perm_failure
> > > > > >
> > > > > > 	And add below check here after call hook function.
> > > > > >
> > > > > > 	if (dev->error_state != pci_channel_io_normal)
> > > > > > 		return -EIO;
> > > > > >
> > > > > > }
> > > > > >
> > > > > > How do you think this method? If you agree, I can continue search device
> > > > > > remove hook up.
> > > > >
> > > > > I think this would mean the device would not appear to be enumerated
> > > > > at all, right?  I.e., it wouldn't show up in lspci?  And we couldn't
> > > > > use even a pure programmed IO driver with no DMA or MSI?
> > > >
> > > > Make sense. Let me do more research on this.
> > > >
> > > > Frank
> > > > >
> > > > > I wonder if we should have a function pointer in struct
> > > > > pci_host_bridge, kind of like the existing ->map_irq(), where we could
> > > > > do host bridge-specific setup when enumerating a PCI device.
> > > 
> > > Consider some device may no use MSI or DMA. It'd better set LUT when
> > > allocate msi irq. I think insert a irq-domain in irq hierarchy.
> > > 
> > > static const struct irq_domain_ops lut_pcie_msi_domain_ops = {
> > >         .alloc  = lut_pcie_irq_domain_alloc,
> > >         .free   = lut_pcie_irq_domain_free,
> > > };
> > > 
> > > int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
> > > {
> > >         struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
> > > 
> > >         pp->irq_domain = irq_domain_create_hierarchy(...)
> > > 
> > >         pp->msi_domain = pci_msi_create_irq_domain(...);
> > > 
> > >         return 0;
> > > }
> > > 
> > > Manage lut stream id in lut_pcie_irq_domain_alloc() and
> > > lut_pcie_irq_domain_free().
> > > 
> > > So failure happen only when driver use MSI and no-stream ID avaiable. It
> > > should be better than failure when add devices. Some devices may not use
> > > at all.
> > 
> > I'm not an IRQ expert, but it sounds plausible.  There might even be
> > an opportunity to fall back to INTx if there's no stream ID available
> > for MSI?
> 
> Sorry, I think this was a half-baked thought.  Exhaustion of stream
> IDs should be an uncommon situation, and the important thing is to
> prevent terrible things from happening.
> 
> I don't think it's worth bending over backwards to make everything
> possible limp along.  If it's easy to just make the device
> inaccessible, that's fine.  If there's a simple way to make it
> available but keep from enabling bus mastering, we could do that too,
> but only if it's really simple.

Mani mentions qcom use simple method to config all lut when probe at
qcom_pcie_config_sid_1_9_0(). It is similar with my v3 version.

https://lore.kernel.org/imx/20240402-pci2_upstream-v3-8-803414bdb430@nxp.com/

Of course both have not resolved run-out sid problems. But genenerally,
one PCIE slot only connect one devices. static alloc 8/16 sid are enough
for 99.9% user case.

best regards
Frank Li




