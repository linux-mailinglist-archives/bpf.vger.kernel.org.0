Return-Path: <bpf+bounces-32778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18644913052
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 00:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64EFBB21684
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2524916F0C5;
	Fri, 21 Jun 2024 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V+Ol/6q1"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2067.outbound.protection.outlook.com [40.107.8.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B1208C4;
	Fri, 21 Jun 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009006; cv=fail; b=bv+RhnED7hP7lefULaBMA23wZPccCcroxqqv9zRWrSHGd5EJuXBZzpqeeBepW5d61VxjXZSr3O4inRqdfKxIHFjpy4QEgB1Y+a40eJHc4VsLM0iD6032KXu3lHqws+8rLYJndEcrHv2xXjY0cnW3xEFC/4xUVR5nVZI4nJb+YUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009006; c=relaxed/simple;
	bh=ypLgEN/Zjn0orQJOowekBOkJ1wleHuoLiUZ4HQZeuaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Huvg+ZHZhitP3PucUue6vvV3Q+KbKWkQ3KH/H7/+GMgD2o4q5/ZdOBF6VT/ZlQ6wRPkR6b99Hb3w4pSLDswSZ8gTzQVukfUrmpRizO88ce32BPrgpkgQq8TmoKFq6P67lJgsR8BmxOvqLcqgNtHDR4pxagihVsaNOlfOui3Vqfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=V+Ol/6q1; arc=fail smtp.client-ip=40.107.8.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRMt+4uVbbd6wDohQRJDqgwTsNYGUm43tXMzin60arGX0k8/q9XBdG+9jY4zRl5URvMuKKfhlg/t9aFkHp9DOz7d9Y3HwdZwE+EyJTTC+aZpixHLlG2cmo/uKrBaIKHY087CkgJIUYQiCt8A9KSQjAf+weytaIpCuG4s+P2NPZTU+WHaVUWMbpn3TUYKp/3/Ake077B6TxL1Mn8I6j8NwplXRLB/UGebzahtPnpKUynqpKhCD3RvVE6iG5msSkcZauIb0JIlXhtmp8yNJQBuQjt2tLdXpgKoihaYkBh/JOWhNHRT/0hi6UqtYJ/DDUG/7jVN97DVu89N49/3Swab5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B3OA8YmVStHZQ7GGH9WJx/6/DKSSTnpsT84zN8EtQY=;
 b=jkPAvEqx+pAf5KlH08F1jEuR7AUgQHy7Sjk1tuPPxP8/af8fx7fEZo6JHVcPuUl0f+h+RG41STF+CUJhHTUAkxTklOVAqsDKa803LjyvOCyy9zCGs/iYeFlwo5LdWoTLt7SXJnE1VyuoLjH7ooP0i+Eq2FgNpvol3Wy01tdAtA9wcfWDctxxF09wKUF8Zy4c6aisRUsryGeB9PGANwhsL5JGtTLpMS8ze7krcRkA+U7UchorqfezIuKk20FLzHKFytCJTikletYAVfAjY/pZo1mT21vU0QChhe3xeboaIXTBj0O3Uvf50uZoBYAyZoENhdvlZHU3+4fpFrF0Z/x4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B3OA8YmVStHZQ7GGH9WJx/6/DKSSTnpsT84zN8EtQY=;
 b=V+Ol/6q1eH6Lrzs0zUQVlgBIJB/IEVWjAUFHCq1cLF1eqo+HbDU6GtxolruZVLHKGuwdi1g3wG2wm3oK33mETxYW9ENu532YtX+6rfgCdALSmCUi4Yk1VdeLUXry+rC+wlXDvXR7zjkFLXLncK4WZAXiLV/W1hCoE7CyC2v4UmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8879.eurprd04.prod.outlook.com (2603:10a6:102:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 22:30:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 22:30:00 +0000
Date: Fri, 21 Jun 2024 18:29:48 -0400
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
Message-ID: <ZnX+3H+bwTr4FbDb@lizhi-Precision-Tower-5810>
References: <ZmIa8dIahUdstpLo@lizhi-Precision-Tower-5810>
 <20240613224125.GA1087289@bhelgaas>
 <ZnBHnPTp6I2qDD7P@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnBHnPTp6I2qDD7P@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e72bfce-6b2a-4cf8-b0ec-08dc9241aff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|1800799021|7416011|366013|376011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8YFSr9QyYf3vtv6ozrqcFdJy2HxSn75PtMCh5q2XK2dISYwkZldaBTE4BNXB?=
 =?us-ascii?Q?U89m3ABM5/NvUoAvsFR3rqBsc9jOPppSfmvDCAudW9U/N4SRvyzmEdv3f8Ls?=
 =?us-ascii?Q?u4CWJnHM/iUM7JhxOxjkM86ST76eW6Sdl1eVXiSX+n21qqYz57LcO4mpURmX?=
 =?us-ascii?Q?Uwa+S/E4udzpiNEfMvGqYQXSTHCrCOSMy5uoePJ14yagnrNQ/zLd3Fk2d8TZ?=
 =?us-ascii?Q?Q252WK3/uUL2i8EZ93C/yQv//YIOiPbjGCd4u9o8JNNpEaR6kZ1iNYY0OrOc?=
 =?us-ascii?Q?NS53CS6zNAmYh0xxqxpEz9d6cBU4CFPlPdO5+e0JAyDPO9Fx/auVMeBz6kpy?=
 =?us-ascii?Q?v/50BSs91SwaFTZp8xCSEE+knOTw95nNV5znqBvCoV32EgQGSEjcuIL801H0?=
 =?us-ascii?Q?jneeIh/xbO+YJqxST56Y2mGGqXPCb0Q9IjItU1wQRyGuUeUxr2rHFpHNKoNC?=
 =?us-ascii?Q?bzGZXNuyUVeSvDoJOd3lG6jhhfPBQ4GPQpwZOoEuQm4ybSYDuRm5sqGbm4rn?=
 =?us-ascii?Q?Z546Q5rTRdgzAgsmCtAP7LCOnSJeNUI3c1JvziZuggAVFS8cGVzJ7sqax3dk?=
 =?us-ascii?Q?9lXCRM3hTzs29czTquUuvBUIMb1aeyQ028cQHo4nTDdtXnJMILRJxqcSfm8A?=
 =?us-ascii?Q?rgMUG6498o4VTXmoZGY+HTr6g/rxUDcVP1tgwIgFawvLpSR5xyej2whMPfWR?=
 =?us-ascii?Q?9TSWBh03Z0LhbfxJvBUgvnQXtDiZzajL+dr3fqmQWV63xPCRpkSbGBbJYJkp?=
 =?us-ascii?Q?xlMG6ybl/VrjWg1//BtN6qo3UZFxXaCyr6kUe3fxpNesF3eUIx/bMWMoZHBi?=
 =?us-ascii?Q?GVj/bin9PSa1x+iLjvO2ztuUGNTnah9baLE7O3o541HQZ52k7tjBzxZlcpP7?=
 =?us-ascii?Q?1Tlz1nWQIpl96nzucM3Y9EjUR1cO2MDeGb2qoJUrYpA42okSyQL9PHgJ1wAt?=
 =?us-ascii?Q?txBm2b7agOsIWtU+d0ub3VAdzkBbCd2UBcq1p0hG+L/RU32G1Kf139id6yO9?=
 =?us-ascii?Q?drsyVZOljvdO5+8BSYUW4o1vvCHdxpTk1lj1RVPiuiHQ1YyHxhgS4DaIFdFn?=
 =?us-ascii?Q?VmMvQzyvyrcSoJJs2NlEYI8sBxdy4pavM258BYIszdlLj6ZpNA03IVwmm9lt?=
 =?us-ascii?Q?aQXVnmPNFkpJ1Lb73Jyhq2C5d4Z8YFUHE7+rZlk0WZN4sPBqqObEA+CSHVid?=
 =?us-ascii?Q?Q+xxocujFCj4cLDZ7/oSP66JthxDqPygXqFZEiD2PNMfhBEcSdqt40aT+7tB?=
 =?us-ascii?Q?v1SUme2JYCScuD+rKruf92xO79Pnc1lDznlJt7RQOTMn/uWFahfNyHMpGeSS?=
 =?us-ascii?Q?XVTfnih+9CIJ5oge5c6+VDLQsklGzAotcMwnE4kuTzVbN6uSvOQh/XDg+CiX?=
 =?us-ascii?Q?0EWCtag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(1800799021)(7416011)(366013)(376011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WYdD7AhM+WWtG0DlTohIb4SviBDpfjfgxuir2hxQhOSkh0LN40OPeuvN5HQ7?=
 =?us-ascii?Q?ZTY0QHPaH9JWWYr35t7OXLJL3PqvcMJcjROcO4wEBZdTg2ZwT3R48B6swZAJ?=
 =?us-ascii?Q?GQh+c+ckjWQZdZiXebKU8jueC7q9Qz17DTP4LJ8nX+0ZqLVRkyzVwp/+sCO8?=
 =?us-ascii?Q?WZpFEgShiACpbX1NrqVQzf4NKFwFX8Um/W625zgy5CpTpxBT+Jd8L4ApUIlI?=
 =?us-ascii?Q?SX5LjUOlK1wqQovAGZ1nMrO5Y2sJG+FIK7kcYCyezRaH4dEWy7x7g1XPnOnc?=
 =?us-ascii?Q?L0b7sY8AIMlSoSpkYIeo5SEu5VjIhNQQn34vqCUD76vkeiz2q+hP+8n7BemE?=
 =?us-ascii?Q?yrcMuNCSqrP3o+ARURvAM86wGMjWzTXjWRrkywl8STJ3mtvVVIENfoR7kWTY?=
 =?us-ascii?Q?Qq+vlCW/NM0ZoVOVs/ELIub/jij20iuUp16UNCP+U3TjqbIStbYs+stHvQNF?=
 =?us-ascii?Q?YXSxHZcOPdL3vh1syg9UIR9GYu5kOe2fJtkC2/qUxPLLtLTdHjC34ti1rnuL?=
 =?us-ascii?Q?uIxQLwne+da6GX8TKWpFK15aLZ6rdt9i5HfJtNp/bNdpwwgbM4tdzg71WAiA?=
 =?us-ascii?Q?nb5m/mTg5RBZmiKpQW/sew5dADAjWZiH9GpGnMmo7v6B+4l6oZBqgcVyMSt5?=
 =?us-ascii?Q?aE2ExgSd32ZY/4qvkJ/DOpQH+9qwMKPZWvBh1y3fvBlEiTX3qFHbQxvn/L52?=
 =?us-ascii?Q?E0vFg3qqzKPt8s2fhbjFN5vDmbVoG7ZjVpmxJuvNe5L7F/PeaFAXJmdlEATl?=
 =?us-ascii?Q?TYJP440283Mwml6daLEsCAe0a8QhXvPyJWC2vTjaILwEIGaVYQzpUeVv19vW?=
 =?us-ascii?Q?GpJWw1Ly7mc9GMqjfuRSbofbcKTIi9jkuz8ik2M4eNIMPku5ACiem2ZyQOji?=
 =?us-ascii?Q?S6Go3PomRP/uDQHtzfSJxqum+vN6B1SRhaqF4kQ6J2r3nD/m4bAHu7cmpi3A?=
 =?us-ascii?Q?ppyEXg+q6T2d9VFX2IhNg11oGWDES9BItdRm3UyHTNKgw8g75wbFRgso5aD1?=
 =?us-ascii?Q?t3UuwtwfVHlLC+diieN1eCDAZjFV9e0XisQ1Ni2s/+JY47cZ1zfYmHv/0igb?=
 =?us-ascii?Q?0hTMG6CbJiWYMM5MQIa77UvIlXOCXc0yB6kkV07b+V/IY5+LC+Hh3Xgzuokn?=
 =?us-ascii?Q?4cWokFe+HMHlibA2ZSQCR/a8fQXmPJ8Zx0ZgYGO2gNov732Pv9DU9Uwp9kw1?=
 =?us-ascii?Q?e9CGbuS2c0j7yiYcKmuQmQovGJzQp9om3GZmLBWVbQOutcsFQZ4xfQdFJLmr?=
 =?us-ascii?Q?WmnXmGIqbjD1haGap5MBUrUjd21/GsmLIlrV4r6jJwB3F/iBwJG/pSeLf/EV?=
 =?us-ascii?Q?/puv0JeLNqxamDCr2DblbfAmhD/vtIaKdfTbw0GxzGT+h3tFu9wiOCcgyser?=
 =?us-ascii?Q?GJbjORhLwhcoX3NUjRazy6IJPm8/4nsFNJI6XA7qc1DLx2UqK4tZ+B0ThRLS?=
 =?us-ascii?Q?ubv2jikBnEzaHT+fwvD6Oqh8X93mvKG7WEg5cGWtW3rHRC3Gj7gVRrt5zlTs?=
 =?us-ascii?Q?f0Y9fa7IvS/Ic7s6TTBRnU9UcTd7oXM6uTSEx6sijer9MCmIniIheAIP3F/9?=
 =?us-ascii?Q?Lw7V7GnTFLSa26fQURAoneCZnA5NbA9qHHkKNJol?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e72bfce-6b2a-4cf8-b0ec-08dc9241aff4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 22:30:00.3744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbYCRD7xNQjZ9JnS9Psu5C38IE8XTkRejfMWZVMSmxpwtQ+UY9D4RoXPLlJ5Kh38ShZW6zMKy4oqACqyvef6Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8879

On Mon, Jun 17, 2024 at 10:26:36AM -0400, Frank Li wrote:
> On Thu, Jun 13, 2024 at 05:41:25PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 06, 2024 at 04:24:17PM -0400, Frank Li wrote:
> > > On Mon, Jun 03, 2024 at 04:07:55PM -0400, Frank Li wrote:
> > > > On Mon, Jun 03, 2024 at 01:56:27PM -0500, Bjorn Helgaas wrote:
> > > > > On Mon, Jun 03, 2024 at 02:42:45PM -0400, Frank Li wrote:
> > > > > > On Mon, Jun 03, 2024 at 12:19:21PM -0500, Bjorn Helgaas wrote:
> > > > > > > On Fri, May 31, 2024 at 03:58:49PM +0100, Robin Murphy wrote:
> > > > > > > > On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> > > > > > > > > [+cc IOMMU and pcie-apple.c folks for comment]
> > > > > > > > >
> > > > > > > > > On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > > > > > > > > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > > > > > > > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > > > > > > > > This involves examining the msi-map and smmu-map to ensure consistent
> > > > > > > > > > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > > > > > > > > > registers are configured. In the absence of an msi-map, the built-in MSI
> > > > > > > > > > controller is utilized as a fallback.
> > > > > > > > > >
> > > > > > > > > > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > > > > > > > > > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > > > > > > > > > controller. This function configures the correct LUT based on Device Tree
> > > > > > > > > > Settings (DTS).
> > > > > > > > >
> > > > > > > > > This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> > > > > > > > > have to do this, I wish it were *more* similar, i.e., copy the
> > > > > > > > > function names, bitmap tracking, code structure, etc.
> > > > > > > > >
> > > > > > > > > I don't really know how stream IDs work, but I assume they are used on
> > > > > > > > > most or all arm64 platforms, so I'm a little surprised that of all the
> > > > > > > > > PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> > > > > > > > > this notifier.
> > > > > > > >
> > > > > > > > This is one of those things that's mostly at the mercy of the PCIe root
> > > > > > > > complex implementation. Typically the SMMU StreamID and/or GIC ITS DeviceID
> > > > > > > > is derived directly from the PCI RID, sometimes with additional high-order
> > > > > > > > bits hard-wired to disambiguate PCI segments. I believe this RID-translation
> > > > > > > > LUT is a particular feature of the the Synopsys IP - I know there's also one
> > > > > > > > on the NXP Layerscape platforms, but on those it's programmed by the
> > > > > > > > bootloader, which also generates the appropriate "msi-map" and "iommu-map"
> > > > > > > > properties to match. Ideally that's what i.MX should do as well, but hey.
> > > > > > >
> > > > > > > Maybe this RID-translation is a feature of i.MX, not of Synopsys?  I
> > > > > > > see that the LUT CSR accesses use IMX95_* definitions.
> > > > > >
> > > > > > Yes, it convert 16bit RID to 6bit stream id.
> > > > >
> > > > > IIUC, you're saying this is not a Synopsys feature, it's an i.MX
> > > > > feature.
> > > >
> > > > Yes, it is i.MX feature. But I think other vendor should have similar
> > > > situation if use old arm smmu.
> > > >
> > > > >
> > > > > > > > If it's really necessary to do this programming from Linux, then there's
> > > > > > > > still no point in it being dynamic - the mappings cannot ever change, since
> > > > > > > > the rest of the kernel believes that what the DT said at boot time was
> > > > > > > > already a property of the hardware. It would be a lot more logical, and
> > > > > > > > likely simpler, for the driver to just read the relevant map property and
> > > > > > > > program the entire LUT to match, all in one go at controller probe time.
> > > > > > > > Rather like what's already commonly done with the parsing of "dma-ranges" to
> > > > > > > > program address-translation LUTs for inbound windows.
> > > > > > > >
> > > > > > > > Plus that would also give a chance of safely dealing with bad DTs specifying
> > > > > > > > invalid ID mappings (by refusing to probe at all). As it is, returning an
> > > > > > > > error from a child's BUS_NOTIFY_ADD_DEVICE does nothing except prevent any
> > > > > > > > further notifiers from running at that point - the device will still be
> > > > > > > > added, allowed to bind a driver, and able to start sending DMA/MSI traffic
> > > > > > > > without the controller being correctly programmed, which at best won't work
> > > > > > > > and at worst may break the whole system.
> > > > > > >
> > > > > > > Frank, could the imx LUT be programmed once at boot-time instead of at
> > > > > > > device-add time?  I'm guessing maybe not because apparently there is a
> > > > > > > risk of running out of LUT entries?
> > > > > >
> > > > > > It is not good idea to depend on boot loader so much.
> > > > >
> > > > > I meant "could this be programmed once when the Linux imx host
> > > > > controller driver is probed?"  But from the below, it sounds like
> > > > > that's not possible in general because you don't have enough stream
> > > > > IDs to do that.
> > > >
> > > > Oh! sorry miss understand what your means. It is possible like what I did
> > > > at v3 version. But I think it is not good enough.
> > > >
> > > > >
> > > > > > Some hot plug devics
> > > > > > (SD7.0) may plug after system boot. Two PCIe instances shared one set
> > > > > > of 6bits stream id (total 64). Assume total 16 assign to two PCIe
> > > > > > controllers. each have 8 stream id. If use uboot assign it static, each
> > > > > > PCIe controller have below 8 devices.  It will be failrue one controller
> > > > > > connect 7, another connect 9. but if dynamtic alloc when devices add, both
> > > > > > controller can work.
> > > > > >
> > > > > > Although we have not so much devices now,  this way give us possility to
> > > > > > improve it in future.
> > > > > >
> > > > > > > It sounds like the consequences of running out of LUT entries are
> > > > > > > catastrophic, e.g., memory corruption from mis-directed DMA?  If
> > > > > > > that's possible, I think we need to figure out how to prevent the
> > > > > > > device from being used, not just dev_warn() about it.
> > > > > >
> > > > > > Yes, but so far, we have not met such problem now. We can improve it when
> > > > > > we really face such problem.
> > > > >
> > > > > If this controller can only support DMA from a limited number of
> > > > > endpoints below it, I think we should figure out how to enforce that
> > > > > directly.  Maybe we can prevent drivers from enabling bus mastering or
> > > > > something.  I'm not happy with the idea of waiting for and debugging a
> > > > > report of data corruption.
> > > >
> > > > It may add a pre-add hook function to pci bridge. let me do more research.
> > >
> > > Hi Bjorn:
> > >
> > > int pci_setup_device(struct pci_dev *dev)
> > > {
> > > 	dev->error_state = pci_channel_io_normal;
> > > 	...
> > > 	pci_fixup_device(pci_fixup_early, dev);
> > >
> > > 	^^^ I can add fixup hook for pci_fixup_early. If not resource,
> > > I can set dev->error_state to pci_channel_io_frozen or
> > > pci_channel_io_perm_failure
> > >
> > > 	And add below check here after call hook function.
> > >
> > > 	if (dev->error_state != pci_channel_io_normal)
> > > 		return -EIO;
> > >
> > > }
> > >
> > > How do you think this method? If you agree, I can continue search device
> > > remove hook up.
> >
> > I think this would mean the device would not appear to be enumerated
> > at all, right?  I.e., it wouldn't show up in lspci?  And we couldn't
> > use even a pure programmed IO driver with no DMA or MSI?
>
> Make sense. Let me do more research on this.
>
> Frank
> >
> > I wonder if we should have a function pointer in struct
> > pci_host_bridge, kind of like the existing ->map_irq(), where we could
> > do host bridge-specific setup when enumerating a PCI device.

Consider some device may no use MSI or DMA. It'd better set LUT when
allocate msi irq. I think insert a irq-domain in irq hierarchy.

static const struct irq_domain_ops lut_pcie_msi_domain_ops = {
        .alloc  = lut_pcie_irq_domain_alloc,
        .free   = lut_pcie_irq_domain_free,
};

int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
{
        struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);

        pp->irq_domain = irq_domain_create_hierarchy(...)

        pp->msi_domain = pci_msi_create_irq_domain(...);

        return 0;
}

Manage lut stream id in lut_pcie_irq_domain_alloc() and
lut_pcie_irq_domain_free().

So failure happen only when driver use MSI and no-stream ID avaiable. It
should be better than failure when add devices. Some devices may not use
at all.

How do you think this method? If it is okay, I can try research how to
set LUT when do dma_mapping(unmap). 

Frank Li
> >
> > We'd still have to solve the issue of preventing DMA, but a hook like
> > that might avoid the need for a quirk or the bus notifier approach.
> >
> > Bjorn

