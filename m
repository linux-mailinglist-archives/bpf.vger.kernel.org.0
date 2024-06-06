Return-Path: <bpf+bounces-31539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617DC8FF5D1
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 22:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022AD289C42
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA2378C96;
	Thu,  6 Jun 2024 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VX+zFklH"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2086.outbound.protection.outlook.com [40.107.8.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CA96E5FD;
	Thu,  6 Jun 2024 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705475; cv=fail; b=SbFF63LYcag8h3id+sjcfROcPo0p0ypfVvuwoiy6li7sTmIc7ecIsgwJKCGM/4OhbUl3e0ppq1EMJUd3cduGlemNh3zAUuBKQ5zBUR9WL/s/kWYpwtK5EWeFgNFH6HoZGVn8m4YyBhqjqcG6bkdj8BJdayOL0R3eWRtYM5TXeQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705475; c=relaxed/simple;
	bh=zBMIvndS5cpOk+/PTiOlIsRVQuUzEp1LuCgO9Fqe3cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cHX+i+sHrjBagoR0qG9i+t1e7tsKvF2JgxIwJM9sdWnxVIvfK/i5bhwtG/CPpepOsYfU2T/OEHoEw7kXhs+smJ7ajizNWzld01EPslJxA/gSoJqL68MKNoZPg1XaQ7AQwCR6cc6MKxgYDHPVoJ3eU5xIF6WplUwpLgPfRYnLjLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VX+zFklH; arc=fail smtp.client-ip=40.107.8.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD7baqa0nbtDE6LoZl+JyPtOP4mViIJGD3I+BECLkj8a2/r0zYEWGk1wS1vvNU+PKcuQUByVddxxmU88K/C1hMC6M8nlHGUqQ6LrrgDLiVJ0/89I8jxnG8YiuJfIRJjg5lJHKO+LX6SrOlRUS/bk4BVFONu94zbnXTTC3Ym0oWlVWM4r22WVgn/R85A0oOcjnPWdyvIcezgfNMiOmMe1+p7T/SfwZJAYpsAuhM+oDoiigAMn6UMmoECHL/RbRHeCsAPovKPR4JV6os25vw6IpopdiUNjvlJgJXcH58a/OHs6Ad/rlO8OYl0VqJp4zBaGtgdjtQMf5E3dnzL4pr8SFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUJDdPggoDKtf/7pz1wtkVSdIdjAwpyQnlEfv8qibhI=;
 b=FGIws9BMr7FM6B/pxVeWFjQJw9rBy2dTXyhrjWjEnHcD5Vd2ES46mECHTlXmADyiRJTQXk8+rVRyuFz/k5mcrrMfSjpjebdF9ctWLRq0gP4J9OSX5y1wV8oRjlzpm2u304aqv9nS2baaqMMXLmWGZMLxzYYy4rJWO9PIrwDCGKaJGZkrJAYk1Aqw8VnpzT8RGlBFNpvowoxzjCl9HATffO9hMDJ02Aarhl/QtcRdaXhERevZdyzPeuH+mEP1ZWksBpPENoNNaPOKOGR31ku2+Nj70gQxbPTfN3aXlYjIToZLGefM/eQoRv3Ed8iT9igXJ6orKdvABcKx18+sJ3uL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUJDdPggoDKtf/7pz1wtkVSdIdjAwpyQnlEfv8qibhI=;
 b=VX+zFklHnJyTmlduLrjRYG8xUzKvBO4sAy0i0h3O+yQlE+zOLPkrE9/wepgoZIOd/lpV9IH/IXkdtkKP2xKLyrWNIlcwz3aC6L/+o7LA4jJWy6t+watJmhiWNwKEPMmfZ5BW0TDwnWPW9clSomW/fSsSIWkWURB3TtZU+9sm51o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 20:24:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 20:24:30 +0000
Date: Thu, 6 Jun 2024 16:24:17 -0400
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
Message-ID: <ZmIa8dIahUdstpLo@lizhi-Precision-Tower-5810>
References: <Zl4OpTfcfqMHELiX@lizhi-Precision-Tower-5810>
 <20240603185627.GA687746@bhelgaas>
 <Zl4im579O3qjIzZ3@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl4im579O3qjIzZ3@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 8459913f-2282-4b92-9e33-08dc8666ab4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZiPrezCoGHHTkj9fPoSqR1WONXD3aHXgcW1qPFtlrriQjBOR4137d1Ze9lAV?=
 =?us-ascii?Q?fmuM6jH0XBG07Phui3Clrp8l1Hy/O2nI+qNB5Z8xHCVAZo3i+/heZUl92H1A?=
 =?us-ascii?Q?0s53qTeKalEiC5qbljCMg0gKf5mlfuXwwiiiuUFvVyiMic70cUkiS+9PSCi5?=
 =?us-ascii?Q?pD6+uB7c2mYcUmA9pHef3ZrPqSEuZShne44rEqEgTpTVBNEyCDkZai+TjmsC?=
 =?us-ascii?Q?oxhI55d3tQv24ipvGMw0qi0WeeSwbXr8RBJHihhKnNydTN9JFggLF8QiNQWi?=
 =?us-ascii?Q?Q8Y9jeTSuoCcaxpkaQ6glDI8zqQ8usf3dOmI+AYWJic2v5DX4pKygKnvsPgG?=
 =?us-ascii?Q?i2LFiok4qDUyisbsizh+5vbyidhQW5BaIxgId9/ZSfTbpqLsO/395UHNd/Tf?=
 =?us-ascii?Q?T2r70ag0Kdp9rhrEiLDIbGc9L8VpPga/FMzDpHf3fgdQZwyTxmGp64fa/DJA?=
 =?us-ascii?Q?/Bl9agzweCnWp3jGYiR3HVCcSk1r/7Zp2alWHifFonepyHB2IkQ6aiE2EEbm?=
 =?us-ascii?Q?mZb7TCFvgW0UyRp+tU/WghUfHqVQhku34QVu1AecrNGAkGdASQLd1PwABDz+?=
 =?us-ascii?Q?HX+Di+lDlIAVkPEhFOZzI1unRJv/cbjy5EipDH8TZ8RDHCPipg++/SJx6vNG?=
 =?us-ascii?Q?qLKzB6wdFiNTRLh+YN+n03a/IuUeDtZvuT2/CV5u7kNkxuXIajHR7yXUsNTw?=
 =?us-ascii?Q?Lfbhl/8rByFeuzt51ksSuCLYW4tRhKTacnPaJb1mQn3DQGq/OM8fVQaITC/I?=
 =?us-ascii?Q?GNV1XpjH0uX7Z21/5iLORSYmkW/KAFwc3W0bx/tFhzlYKuXJNNDRn8GVgUkA?=
 =?us-ascii?Q?K2tLEMvtFkQztqWUNKdlGfhkf4kpSSgLCCvRsUhhwU8mBcukxtm1lRYSAe7q?=
 =?us-ascii?Q?iR9hp431pBtSaLJb7g8J2K+SqkOr1gz3PsyLncGD5AAyURlFJij7fZSNt7nS?=
 =?us-ascii?Q?ftu+77aTX/1W8FpAquZOt2U3Z7qS33/wAtJDQphkRAoS7sKTRjZjgqXngOhC?=
 =?us-ascii?Q?GuoYoQPsRUdSeXtlXImBeMEoEw/Z6acjrl9Lkcl8wfATWvUq74O6IpSWL2r+?=
 =?us-ascii?Q?CyZf72M1YK3foLVFmaZwRXHiPWaBEph3FV2tdcFWqRLsFM1W8+L3NIIkBvLJ?=
 =?us-ascii?Q?MPIlKi6QhNZvcOqsau/YR7ZKRxVMQDIEzt45JWyf95gq1kSIKW/e/EFFoFRN?=
 =?us-ascii?Q?aiv43d+u0fmKiZsGJacye0owIvUzMLS6D4BxASSxKmxgXjIM+Xyxb8fa4Rgm?=
 =?us-ascii?Q?xtVy6txkbe0K0o3UMZ70IV+VpM3zwj83KicnXZfcbfsNaUMLd555d88NZSB7?=
 =?us-ascii?Q?8imyr09U9UqqNBzSlbb1IC8zSDT0Mke7/OnGtnmlYB5Tv0ON/F/Fp0IhfS8m?=
 =?us-ascii?Q?XXqVd7E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OPkPCar/76+mfXhm6H2xWAKD+p1MD5zz14OuijacDUNiJXTk0vgu+DebH4E+?=
 =?us-ascii?Q?lAMdmJHwmCtFebddMKXH0cPHfHs2ybTGUYJBfcNMZ2pn7h0MLuxOItQu8uZx?=
 =?us-ascii?Q?BtB4ymfJCTk1a64cY6RX6KOQE4+2xIL+xP4IZDwQL6dwoRRD8bxEMfk+hAVO?=
 =?us-ascii?Q?Cli58rbp3Iji9V3KLirOkgKn4IXootxOWLlAnRlmUupS8d5uCAzP89+KpPu4?=
 =?us-ascii?Q?vJaNVDwy4NHvzE68bkklj4+36OPMBxE1p1ppegLKVM9utKO8TjFl8Du8zBaC?=
 =?us-ascii?Q?nl4EAy/x1rVpdfopOtaIeFcwvoVEtJyEMKpkwGEE0aAxMlW67LQGDzlGcSze?=
 =?us-ascii?Q?F/GBH4XDdnAqLixsCSuaPd0Mv8rJxS4Ne9yOwRCOuDIMfcWgiiaMM4Ae7Sd8?=
 =?us-ascii?Q?b1PrkuTiQ/iMUoEqcjkA3YmX3fZmb/99OHqmK0uGpB8JOZLzxvKb9clFr4EX?=
 =?us-ascii?Q?NtqvdzxgaJXNKLCQiKVqvQuHf8EfU+7tq8tuTh/cW4quEog0Xus0OwqeFE7K?=
 =?us-ascii?Q?oDscBMpAzZjZxE8XcgyMjMoBtE6szdRK82qSoc2FhGcvSEjm6C2iNsAUfowR?=
 =?us-ascii?Q?cjG5QCfPLTXumrsJGhObgkPLRScp42+SwzTcQuyxGEmteiLmS1WmFmP/Uyib?=
 =?us-ascii?Q?CuE5m5SpAkL7QjQA60pptV58ePOd+BKmQbiGv/xsfywd7WXkOZ1AopfeghYy?=
 =?us-ascii?Q?J33bjAjhNQq7FA9UWRhYEQvfvWaxnVVkLrUz24LKaPZlIP/Q5dvSVJlu1dUq?=
 =?us-ascii?Q?ZnI6oTK3N4CM1G1ufEcDEBbvuP/ZvjbjlcMRBgQQszQZ6eZmWX9BLZtHdrzO?=
 =?us-ascii?Q?fWsSczxcckcwf/NsKqnKoq7mJUwUw3f+vrOMKf90zwvRGYfpKk10zwUogA6K?=
 =?us-ascii?Q?zcY4MlLkIGRl/7APkEPAAvN0r9fs7mm3GCYy1u4+gurSHyAYPRibhRjZNB0m?=
 =?us-ascii?Q?56AhlJet8PpiYmv/w32QiEIjiMPv2lABZViR/UPF0HkotpHlZPkrWmDyxsEs?=
 =?us-ascii?Q?6vq8vs0Cq794GAaAxA8dfYrCF/ICsXUUKDQrZHY9B6fiJImiczO0UitTKoms?=
 =?us-ascii?Q?F9PR6G+AGZabOaFvU3CefCv5di8UjQs7xefxxJ+gaBp6fwqz4B5CBWgNdBcK?=
 =?us-ascii?Q?SJnpP791rae0YIDWndXu4CMRZHxzrowk/Yi1yoMCcewHlFT2nLjYt7ow4acH?=
 =?us-ascii?Q?d/lxS+uJwNI/4pGwEM5yuG1O/CoJPfXzGhKnQMOg3YtWNV7MS1LVXNUMSyj/?=
 =?us-ascii?Q?J6Qpzis0YJV9Qu50tsGHeOfMtGTJCTwUVg3BgBhimn6QQsIVIBBwGcCJt2i9?=
 =?us-ascii?Q?Y84/FpAoVGy25njZ16dxVm/LqmytsHP9StwgceW/QKNyoSowtpJdz9k+Dd6M?=
 =?us-ascii?Q?2SBlYDZOiPrPcCLp2ujeVP9kVuZBTm/bnmXnikSYsqkNEJIaZmPYkRnq+0a8?=
 =?us-ascii?Q?AmCK41qteRqXOooxzbkJMcui8pkRkKXzcV79VWXNwyF5ASAeRuLevDeYX5nN?=
 =?us-ascii?Q?X13jyzLZJOD6XHMBS86HxChdnKhddv2QHfm8JWzWjCIETcSgIT6b5bataBQ5?=
 =?us-ascii?Q?ZWWipfPSxabdmsh79ec=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8459913f-2282-4b92-9e33-08dc8666ab4c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:24:30.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVJ2WTO39y2kbLoma2H8KEHhjKbpoTibWce7frwi6Ryx94SXgz/aA21FT3DkQWvkTImCEy7cMFWgZbsjbOoeYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786

On Mon, Jun 03, 2024 at 04:07:55PM -0400, Frank Li wrote:
> On Mon, Jun 03, 2024 at 01:56:27PM -0500, Bjorn Helgaas wrote:
> > On Mon, Jun 03, 2024 at 02:42:45PM -0400, Frank Li wrote:
> > > On Mon, Jun 03, 2024 at 12:19:21PM -0500, Bjorn Helgaas wrote:
> > > > On Fri, May 31, 2024 at 03:58:49PM +0100, Robin Murphy wrote:
> > > > > On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> > > > > > [+cc IOMMU and pcie-apple.c folks for comment]
> > > > > > 
> > > > > > On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > > > > > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > > > > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > > > > > This involves examining the msi-map and smmu-map to ensure consistent
> > > > > > > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > > > > > > registers are configured. In the absence of an msi-map, the built-in MSI
> > > > > > > controller is utilized as a fallback.
> > > > > > > 
> > > > > > > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > > > > > > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > > > > > > controller. This function configures the correct LUT based on Device Tree
> > > > > > > Settings (DTS).
> > > > > > 
> > > > > > This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> > > > > > have to do this, I wish it were *more* similar, i.e., copy the
> > > > > > function names, bitmap tracking, code structure, etc.
> > > > > > 
> > > > > > I don't really know how stream IDs work, but I assume they are used on
> > > > > > most or all arm64 platforms, so I'm a little surprised that of all the
> > > > > > PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> > > > > > this notifier.
> > > > > 
> > > > > This is one of those things that's mostly at the mercy of the PCIe root
> > > > > complex implementation. Typically the SMMU StreamID and/or GIC ITS DeviceID
> > > > > is derived directly from the PCI RID, sometimes with additional high-order
> > > > > bits hard-wired to disambiguate PCI segments. I believe this RID-translation
> > > > > LUT is a particular feature of the the Synopsys IP - I know there's also one
> > > > > on the NXP Layerscape platforms, but on those it's programmed by the
> > > > > bootloader, which also generates the appropriate "msi-map" and "iommu-map"
> > > > > properties to match. Ideally that's what i.MX should do as well, but hey.
> > > > 
> > > > Maybe this RID-translation is a feature of i.MX, not of Synopsys?  I
> > > > see that the LUT CSR accesses use IMX95_* definitions.
> > > 
> > > Yes, it convert 16bit RID to 6bit stream id.
> > 
> > IIUC, you're saying this is not a Synopsys feature, it's an i.MX
> > feature.
> 
> Yes, it is i.MX feature. But I think other vendor should have similar
> situation if use old arm smmu.
> 
> > 
> > > > > If it's really necessary to do this programming from Linux, then there's
> > > > > still no point in it being dynamic - the mappings cannot ever change, since
> > > > > the rest of the kernel believes that what the DT said at boot time was
> > > > > already a property of the hardware. It would be a lot more logical, and
> > > > > likely simpler, for the driver to just read the relevant map property and
> > > > > program the entire LUT to match, all in one go at controller probe time.
> > > > > Rather like what's already commonly done with the parsing of "dma-ranges" to
> > > > > program address-translation LUTs for inbound windows.
> > > > > 
> > > > > Plus that would also give a chance of safely dealing with bad DTs specifying
> > > > > invalid ID mappings (by refusing to probe at all). As it is, returning an
> > > > > error from a child's BUS_NOTIFY_ADD_DEVICE does nothing except prevent any
> > > > > further notifiers from running at that point - the device will still be
> > > > > added, allowed to bind a driver, and able to start sending DMA/MSI traffic
> > > > > without the controller being correctly programmed, which at best won't work
> > > > > and at worst may break the whole system.
> > > > 
> > > > Frank, could the imx LUT be programmed once at boot-time instead of at
> > > > device-add time?  I'm guessing maybe not because apparently there is a
> > > > risk of running out of LUT entries?
> > > 
> > > It is not good idea to depend on boot loader so much.
> > 
> > I meant "could this be programmed once when the Linux imx host
> > controller driver is probed?"  But from the below, it sounds like
> > that's not possible in general because you don't have enough stream
> > IDs to do that.
> 
> Oh! sorry miss understand what your means. It is possible like what I did
> at v3 version. But I think it is not good enough. 
> 
> > 
> > > Some hot plug devics
> > > (SD7.0) may plug after system boot. Two PCIe instances shared one set
> > > of 6bits stream id (total 64). Assume total 16 assign to two PCIe
> > > controllers. each have 8 stream id. If use uboot assign it static, each
> > > PCIe controller have below 8 devices.  It will be failrue one controller
> > > connect 7, another connect 9. but if dynamtic alloc when devices add, both
> > > controller can work.
> > > 
> > > Although we have not so much devices now,  this way give us possility to
> > > improve it in future.
> > > 
> > > > It sounds like the consequences of running out of LUT entries are
> > > > catastrophic, e.g., memory corruption from mis-directed DMA?  If
> > > > that's possible, I think we need to figure out how to prevent the
> > > > device from being used, not just dev_warn() about it.
> > > 
> > > Yes, but so far, we have not met such problem now. We can improve it when
> > > we really face such problem.
> > 
> > If this controller can only support DMA from a limited number of
> > endpoints below it, I think we should figure out how to enforce that
> > directly.  Maybe we can prevent drivers from enabling bus mastering or
> > something.  I'm not happy with the idea of waiting for and debugging a
> > report of data corruption.
> 
> It may add a pre-add hook function to pci bridge. let me do more research.

Hi Bjorn:

int pci_setup_device(struct pci_dev *dev)
{
	dev->error_state = pci_channel_io_normal;
	...
	pci_fixup_device(pci_fixup_early, dev);

	^^^ I can add fixup hook for pci_fixup_early. If not resource, 
I can set dev->error_state to pci_channel_io_frozen or
pci_channel_io_perm_failure
	
	And add below check here after call hook function.

	if (dev->error_state != pci_channel_io_normal)
		return -EIO;
		
}

How do you think this method? If you agree, I can continue search device
remove hook up.

Frank

> 
> Frank
> 
> > 
> > Bjorn

