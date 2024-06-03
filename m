Return-Path: <bpf+bounces-31261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532288D8B5A
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975B9B22812
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013FB13BC0E;
	Mon,  3 Jun 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BJt7S5Ir"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4FE20ED;
	Mon,  3 Jun 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449394; cv=fail; b=lYd4ujIm3DzEGU2TP8dZBqunsYdY2FHV22c4uXPCx3NnYHU6xMV35lz4Bpyy2dhAP3sey1Fsj6bdXSeqUc/UWvqEa9SYBjyc21W9Lg8tHS8ub3gts48OID8ZAO/PzvJ/yChD+MW+glIrPEWKJd0LbizmoXLdtVFJJw5m6gAHdTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449394; c=relaxed/simple;
	bh=EXGsy0HzFQCH8IEfn5CT+s0q9AJXcrQpPpeP3urO9tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oqZmiYJodljdLq8mkcXoMWO7Tmb81q07t4DWPc1N3POIXA0cMvYvzOmg8usRlxxoCI3VaU6tEkmr06HlZjL2wLyHohhkymqOw+xit+D7WbfgNJabMKpeCJpou+4dn6bxUurbLCeQqnSlLlME2JkBxtITu1SGkuW48JKJp2qLNvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BJt7S5Ir reason="signature verification failed"; arc=fail smtp.client-ip=40.107.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qlkk24PATCgHjh8uMcQnrTdBMhAn7Rib+q4Bfxcdf+KAavYWxIEmXmX+f/bArWcj+2hI3xD3WtGfE8TrGu/ctmsV5pajnWp9ynkZwat59wo8HGf5WYTd8Tff/drb8Da2PQbbpVtGwcRtE6ZJR0Gh3o3QNrAA6QFfGLfZ6CCMrc8XviSxWSSTi+9rCGhBZjMuvtWC6cNMcFCNbz2PPHZcvHCcfVDfRDQUPSef/mBKz5jSG/WGBqgEJkLDb8VK6LsaM/pQs5ih7zueQt3vQt+30wQbrKTBHwbGzRoOGEHqfojYtCTeYUDuZtSX5xMCkUNKfQUuT5//hNhZDEnqrnjAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+HUvH417yxsNvPymRw//vSfa0trcFAW9AJeRoe+wVc=;
 b=CVr63kFAB00sQZZWt4eQs2oZfANVTSYwvvRUHb07r8k5JUZDrEvFxBDFa5yiMd+NxkCVqTt/EFAlyDQCaKUwUS8bJBhx07SMx6h1bjz2P8gt/5XlULNDIU9h03t6aaVFlpwnQT3D64GPTe9pk+T6YmaE2WayW+hyInniRTxSLj6J4naGrYGcPUazVR7e6I6j7yDx3SAATKj7aQNuJ+RLOu1t8SCurW5Cq+vvT2d/JUuXolkBKE9QvzXcIgMTZsDWNrmDBBmISzqVGTys6rUYZHREE7lQX/p6h0hG1ChDf4mNBiRkTrs3GRrbkRm542vUl6nW6L6qx7eHs2h4SXdZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+HUvH417yxsNvPymRw//vSfa0trcFAW9AJeRoe+wVc=;
 b=BJt7S5IraN6L5Jsg30WQVmPLzgo3Vt378YMYwMlxvvB4+4HYbYgQQNFOIzRuBgR0V57WncZX72RIFma5J/t2EnP8rJN0g8oPJLFhXOy0ntbZpaa5XBehhpE4qKtMJqSE4+Fz4dd/EO13LyX+zqAl5yMlnG56O62vxpNlGyOXFZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7834.eurprd04.prod.outlook.com (2603:10a6:10:1ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 21:16:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 21:16:29 +0000
Date: Mon, 3 Jun 2024 17:16:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Tudor <tudor.laurentiu.oss@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
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
Message-ID: <Zl4yof4LUahtjFe3@lizhi-Precision-Tower-5810>
References: <20240530230832.GA474962@bhelgaas>
 <974f1d23-aba8-432e-85b5-0e4b1c2005e7@arm.com>
 <7edbdb11-5135-4f26-be12-c86f4dc4c0ff@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7edbdb11-5135-4f26-be12-c86f4dc4c0ff@gmail.com>
X-ClientProxiedBy: BY5PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 126f7139-19ba-4502-aa6c-08dc84126f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|7416005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?3E6PZuyg0qYyh4QKEET9mr6KNppzwh9o+tYMMSwrJOS4LktCVYJZaQl1fq?=
 =?iso-8859-1?Q?+VBks4r/1jaEVrN4NC+Fdzxfz5I2n1afTPxMA88IukLisMfDtr/JNUUfkb?=
 =?iso-8859-1?Q?WyvH2CH07V5YU3eMqyw2ZaX/M3IlJDJ3whNKgTgek12rXw6NYp5tYGkbJf?=
 =?iso-8859-1?Q?pvKWhbx3Llkl46h9JlvQDWtactQUdoxTJQPfH/Y91a3WckMfxYJWVULSJd?=
 =?iso-8859-1?Q?FGca4EGKHfCyCjvskUR3Ie7B5McTpj8ZW2VdpwrIvHZLaLZ+XP0961Mj5Y?=
 =?iso-8859-1?Q?eEaXeKjsvqNU0n+4s7IHi686xVEGYi0cXKP7zHfCvx6W7w+uxTYYWXEZ9j?=
 =?iso-8859-1?Q?FjRcOAhHB5RFFY2y34C44iMn+dCCi2LKVZvvX9paSB1Qrh9qRZsRoJIayF?=
 =?iso-8859-1?Q?WfG863Z5hAB53m5kY0Gu+UknKumnBkb5Xm3m2ANsFJag7CHA8s2lp++I50?=
 =?iso-8859-1?Q?EU4tnlAbxzh9iJkbxvFKg7ujxsnXk1+R2BhlUXfO//y0XCw1jrbNeqiJKR?=
 =?iso-8859-1?Q?S/kaK2jdM9oc7rzMjJ3LflR41kx9ZgeNZyKpGMM6vAjhYrv4x21BiKp4VY?=
 =?iso-8859-1?Q?pMlfHA5hFtHX0hYCxAc1wX6NkoJ/PiYpDEL7YRAAQCG5+MyYYbZEkYCoKr?=
 =?iso-8859-1?Q?SPHIZqFTeS3PjiK1ZHgpNZEy9vvmJwqMMGSFXTfgGX3nyiwVNRDdNNr5RY?=
 =?iso-8859-1?Q?mn4ADCx7yOfOOorD3vogx4lLwvfE0FGZV3co345T774+Djo9V7yUh36rhH?=
 =?iso-8859-1?Q?WwIyoizjI7TvmVnA+LaUOBM67DMuuvJDB+iyHED9VERnjU85YkYpIwmRZ+?=
 =?iso-8859-1?Q?LPVTRyK88UPmWarGQsyHNU4HSnQZ/WSgTI5mSMlWiSBX/pkgNldr8T195t?=
 =?iso-8859-1?Q?35RovxlAuWKk+qr/5YOkibeyN4v8kd8eWxT1P25f2groENI46aY3/hWocM?=
 =?iso-8859-1?Q?JIsOmnaJ/kMrnuYEj5cgJgVj3tYT5KJpQtXQDj105GJF5p2CWZAxqgTBI4?=
 =?iso-8859-1?Q?w4z+4zfiex87lf2aNbPln5Hi5lKJtTjCvNVEJurq2+90V8bniTnZxV6H9U?=
 =?iso-8859-1?Q?xx5H41NZ/JHOEUzp1qcPp47Pb15q5tM/9vmQ2P5QJD8vN+++uwHblbJOSN?=
 =?iso-8859-1?Q?Ra8LKE3HIyFsd98MJiWu3CwGveFRq0XfTDzveqM/Lh/FYmYPe05ivh8MBl?=
 =?iso-8859-1?Q?3mC9Vtlyc8aD/P3XOH1Mb7tmWHzMdJCBd7h/jm8wQszIv4YL91veVLZ6CA?=
 =?iso-8859-1?Q?iZXnjGv22ModjyKHCe6cnCbO31zj/6+DWFfcH8TNeHZkltco+acc31/0W1?=
 =?iso-8859-1?Q?w+Pv4H7EbCCLmmd3Ymwfie/dTSqz89cBXyzXenYr3K8Xn1xmfbzHDS9Nro?=
 =?iso-8859-1?Q?cfBCuNq6bd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?2siqpxJU1L+p345bKEwa1UvReb6mc3pEyJWq4fFcocEH+YzECO+/52fdn5?=
 =?iso-8859-1?Q?8sGD0frTh7dqqkSvOFwm6uIpBPx7B+lD9xtHW8WtAlFbShGJndFAGQ7j9V?=
 =?iso-8859-1?Q?fQHQo1tSM/mb54hOAJpGLU3WvQKIhbtbDVWCP7y7ak4klGCEc+XcWc9AqM?=
 =?iso-8859-1?Q?Pvl1S48iA4rtj0BrUryH3nkjtzJpG0wdC5NH3RKuEqZYdBDA/1jhRLXtyY?=
 =?iso-8859-1?Q?E0v80y5W11B3FQrxWABLfYW7ACqobPN8zAEh7+Nao92xscctZV/eNbm0+V?=
 =?iso-8859-1?Q?ZmQRT/tO5MBHbSAaMu3aJ6wkF7xYQTDE0wDl5KN7ANwqC91zdVgG2+Y83v?=
 =?iso-8859-1?Q?Mz/UtQNaLALZDytN2NjS7DFtIehHziIeRm13nONSUQQEsTWjstVc8o807e?=
 =?iso-8859-1?Q?qH11lzwLpgqAWXMYHNWYrkJyW/8pL+CR0Uesp/2zcGUHp3lWLEyibrwfkx?=
 =?iso-8859-1?Q?z05h226LZqjlaZ0TanbdklwQibKq6WQSwVK2D/asc1SqpFePCqHgCgHk3Y?=
 =?iso-8859-1?Q?QOuZI5cLNjwUTPMKSnLRjsKhY+52kkRiUi59q9dmG0dzYdIAV5ClGvm+j6?=
 =?iso-8859-1?Q?5fwyJdYGV7hWBDxWs2JTtCZCfaCs9O278Ro23W3hiXikcktFkr9gpY71zL?=
 =?iso-8859-1?Q?ZNxzX4keoPx3WJKMEifZCXKAsaD5jwATLxSbA3xrJ/5Oj9yo4NyX/z0gdM?=
 =?iso-8859-1?Q?s9av5znPplOSLw7kmzzAKe0YEnQA6Wab8p8qLRESBSCfdhdY2Sg1wBXCU/?=
 =?iso-8859-1?Q?xjATdpngUMheDm5vfvFA3fg2r0HL/wC8+HZmXsAEXz04Ufybmkt6hEKNoO?=
 =?iso-8859-1?Q?0YjbWWMTgYU9aPeFB7QoStCtkvmI0CtpAUPB0xS9cINr7yK8Pe9Uqcfm6X?=
 =?iso-8859-1?Q?Sw/g1EbDR8lZVGLAJJzbobbteo9gsr8up5QfvehRmjHfr5Ax4T+wsMVaQg?=
 =?iso-8859-1?Q?VFYANcwxabcABO0OE9QzmgeA5SJ57Y7aicwj+U+XzoUavNrHzkvpMrmDvd?=
 =?iso-8859-1?Q?FXkPqLxR56sSnV5WaAI7pY6F4rKyteJawu8Rh1HbQja1j91btN9kpbCIb1?=
 =?iso-8859-1?Q?c/ma0HeJwPHyJqmoMPWQCCeRHfscYUyTsRUVif3qvoeRifg9T0Jkw0FsN7?=
 =?iso-8859-1?Q?Va9KvbH7Zu/13v0myoiyE0wyC0/tGODxEYXPa5DeUtMwDOA0/6y14jc1VP?=
 =?iso-8859-1?Q?22mBebvi66KsogDTXdXew2/pWpyyYOhdUpguKdMuomzZrm8Y+kXqe/Ip07?=
 =?iso-8859-1?Q?Eo0HFUB0OeH+XMLSX8yep3+Gb2L9xrXMetl3KuMOzT3csRo48shIDRojRJ?=
 =?iso-8859-1?Q?Zrxz4U2sxMGpLXQ8X7Cp3/mbfRfj7xs+I4iVCfJ1NwSjvZDEUIjbBGycx6?=
 =?iso-8859-1?Q?w1/Uh15lG61EODI102jOlLwtmnPhr+Za7aZkMn6Wnotb00firU4V6/LFp7?=
 =?iso-8859-1?Q?DApp0zozxsSRl/XMhLQXr0JPkw1TcbgOrSnKwZ42toYNXPe3k1JT2jvv89?=
 =?iso-8859-1?Q?gPNsnj6aS2c4M9cE87QMaiwuoAYdXqx8sZObk8Us4tEXoL1imotRHJ0mZ9?=
 =?iso-8859-1?Q?EksxrTH1Wb1b4cmLU+//JVxBxfg1MuKdFz/JYcKj5ua17HqVtVAOqrKyoJ?=
 =?iso-8859-1?Q?o4MDD/mbOZNKWL3sqxPka7qqyLoNmiC5Zy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126f7139-19ba-4502-aa6c-08dc84126f5a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:16:29.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NJ9k7qSbm1dvlMGoS7YPnZBuwq7dB3iReZTnS0vQhnjwOsG8HBqjOSybXt5yrB2YwqLs4nJD7zU+wwskltNLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7834

On Mon, Jun 03, 2024 at 11:29:38PM +0300, Laurentiu Tudor wrote:
> 
> 
> On 5/31/24 17:58, Robin Murphy wrote:
> > On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> > > [+cc IOMMU and pcie-apple.c folks for comment]
> > > 
> > > On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > > > For the i.MX95, configuration of a LUT is necessary to convert
> > > > Bus Device
> > > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > > This involves examining the msi-map and smmu-map to ensure consistent
> > > > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > > > registers are configured. In the absence of an msi-map, the built-in MSI
> > > > controller is utilized as a fallback.
> > > > 
> > > > Additionally, register a PCI bus notifier to trigger
> > > > imx_pcie_add_device()
> > > > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > > > controller. This function configures the correct LUT based on
> > > > Device Tree
> > > > Settings (DTS).
> > > 
> > > This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> > > have to do this, I wish it were *more* similar, i.e., copy the
> > > function names, bitmap tracking, code structure, etc.
> > > 
> > > I don't really know how stream IDs work, but I assume they are used on
> > > most or all arm64 platforms, so I'm a little surprised that of all the
> > > PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> > > this notifier.
> > 
> > This is one of those things that's mostly at the mercy of the PCIe root
> > complex implementation. Typically the SMMU StreamID and/or GIC ITS
> > DeviceID is derived directly from the PCI RID, sometimes with additional
> > high-order bits hard-wired to disambiguate PCI segments. I believe this
> > RID-translation LUT is a particular feature of the the Synopsys IP - I
> > know there's also one on the NXP Layerscape platforms, but on those it's
> > programmed by the bootloader, which also generates the appropriate
> > "msi-map" and "iommu-map" properties to match. Ideally that's what i.MX
> > should do as well, but hey.
> 
> That's usually fine, except when SRIOV and/or hotplug devices (that is, not
> discoverable at bootloader time) come into play. We came up with this
> "solution" to cover these more dynamic scenarios.
> 
> https://source.denx.de/u-boot/u-boot/-/commit/2a5bbb13cc39102a68fcc31056925427ab44b591

If my understand is correct, basic it was still pre-allocate method. Just
reserve more streams id for SRIOV and hotplugs. It was not really depend
on what devices in system.

Frank

> 
> ---
> Best Regards, Laurentiu
> 
> > > There's this path, which is pretty generic and does at least the
> > > of_map_id() part of what you're doing in imx_pcie_add_device():
> > > 
> > >      __driver_probe_device
> > >        really_probe
> > >          pci_dma_configure                       #
> > > pci_bus_type.dma_configure
> > >            of_dma_configure
> > >              of_dma_configure_id
> > >                of_iommu_configure
> > >                  of_pci_iommu_init
> > >                    of_iommu_configure_dev_id
> > >                      of_map_id
> > >                      of_iommu_xlate
> > >                        ops = iommu_ops_from_fwnode
> > >                        iommu_fwspec_init
> > >                        ops->of_xlate(dev, iommu_spec)
> > > 
> > > Maybe this needs to be extended somehow with a hook to do the
> > > device-specific work like updating the LUT?  Just speculating here,
> > > the IOMMU folks will know how this is expected to work.
> > 
> > Note that that particular code path has fundamental issues and much of
> > it needs to go away (I'm working on it, but it's a rich ~8-year-old pile
> > of technical debt...). IOMMU configuration needs to be happening at
> > device_add() time via the IOMMU layer's own bus notifier.
> > 
> > If it's really necessary to do this programming from Linux, then there's
> > still no point in it being dynamic - the mappings cannot ever change,
> > since the rest of the kernel believes that what the DT said at boot time
> > was already a property of the hardware. It would be a lot more logical,
> > and likely simpler, for the driver to just read the relevant map
> > property and program the entire LUT to match, all in one go at
> > controller probe time. Rather like what's already commonly done with the
> > parsing of "dma-ranges" to program address-translation LUTs for inbound
> > windows.
> > 
> > Plus that would also give a chance of safely dealing with bad DTs
> > specifying invalid ID mappings (by refusing to probe at all). As it is,
> > returning an error from a child's BUS_NOTIFY_ADD_DEVICE does nothing
> > except prevent any further notifiers from running at that point - the
> > device will still be added, allowed to bind a driver, and able to start
> > sending DMA/MSI traffic without the controller being correctly
> > programmed, which at best won't work and at worst may break the whole
> > system.
> > 
> > Thanks,
> > Robin.
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

