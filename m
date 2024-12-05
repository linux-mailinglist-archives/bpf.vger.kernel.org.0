Return-Path: <bpf+bounces-46163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B619E5ABE
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 17:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A268162C5B
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FEB21D595;
	Thu,  5 Dec 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pl1AVLQi"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859DB1CD2B;
	Thu,  5 Dec 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414853; cv=fail; b=hYCm+mVl2hghnqpHWRqJh+qYk50EIrU0sZfp9BA5i6lUrFZ6U09cK6zRnukPfwCvUMwR8+5qhlcy3xbfKj3IEdUspOZXEahflBPpKx2m3SZzJ61DW/kLiPjUDeQA4ZGR3Nw7QMgtwBV0PwLP9CKJvUSGsvc/rFzcPni+N48DuNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414853; c=relaxed/simple;
	bh=tiXho+m6z/jJogjxwCmvJ/gwAjC334+9b8v66EyML9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uQBWYwiBdHkc8gxl3iBhXOhV3dGDDwJmTXwqOCl+LOuBokT/r36xh56jiZX98UyjGbVY0qbn4+g3/YQwqXE36zAmSY+j2WLJtCU6S1tolDgvXeSmgPPAbgD7OepiBKSFH3Hn96SPYYN+dk+Uxf1zrwwnwNBG8RYNGt7577/FHAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pl1AVLQi; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8HWicXVaSqvRsOAywM1IBPoPRXvm0+fFXa/Dapqfs4B0EDf9mnhpDBCmoLALmiyy9yqEUST6y6ESutgVPRzs7GcWOsxGM/OCZKiMc4Wuf9a/8aVwx5JDi3kNUNPMNOQxeprauUOv11Fp17Ho5CRAmvnZqxXQVNSy6HzEgigeV81lZkdk4TceZtdo3rM3J4CXFrBsuqIVcOVeROFUsRUINn4JgFQ12pnBarEr4GXJGu/stRb/Z8QkFZcCN4E3JPyTospYd78BbeSm+j2UphqcZsEIKwTp/VOJf8EXYwDPXu1s3MdZIKDyxNTzVsFj3mmWSzuVjWOOJPHyy7sjJkEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBMzhlMBA+ph3EIHCDX9XDJQZdEwfadgYHc0pGgGQos=;
 b=pVffL2bdfuFzjWbYMYe3zHcLSt2RYkYdsNrdo7VEQQk5FxmfYXJh3AEbW/76hNIA8aXbAjbf/t3TDTM3YIIVZnmUv73PRpkkgqP+CHJhpIRKaV8arEJQYtudDjuvWiFzUn9qLrVL7tlRIQAxnRtD9Vkhb/jiywFtE7Qrm1rKdanZX3zPVn2jRXZnbdo+0YQWORDts1bsrHlbXkpENNwxjGXFBpHhqHkVnDrHZ2uCTkAj6ig58oUS9fvT0yHW+rTdSU8pFp9U/bN88V9rmaI54wXvGMJL/Y1j83CKOCsF10vw68AJ8J+LWzEcNjJUbJ2eQqqjYzIGPXWy+0MLF7kGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBMzhlMBA+ph3EIHCDX9XDJQZdEwfadgYHc0pGgGQos=;
 b=Pl1AVLQiws6KLZkTyTTmEhN2rbwHINUGYhh+VgfOIC1T52RgAXZbIiF3IrjSZa2o3FWgfoK0tQ3OeYkkUL7XW1BN8FDlfwH3bWg3T2wnNfJ0vet+2TRA63/zPxp5xEaa66QAmtX5hhZQ58V4gUtcCz7l6OrCipPu/6+F9FcCOPgxgscY3gqIyszSP2I5kwsc10zRd9GGMrhFiRhQl1cyK+/oYkrzzDsZo3Xh+bQukdrPZbWonCn4+qctkEvc/rTfcE6N6kd8BLbv+dT3Kawszy3VMB5l2UBAi2XShzcm0pSCyx3YuXb7oGJ3kOswF28ktQLI37I7evAyGFe5azgwvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10085.eurprd04.prod.outlook.com (2603:10a6:102:3ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 16:07:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 16:07:25 +0000
Date: Thu, 5 Dec 2024 11:07:15 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v7 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <Z1HPs2/PBZY4iq/1@lizhi-Precision-Tower-5810>
References: <20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com>
 <20241203-imx95_lut-v7-2-d0cd6293225e@nxp.com>
 <Z1F/g/clUxAIGFZ1@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1F/g/clUxAIGFZ1@lpieralisi>
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10085:EE_
X-MS-Office365-Filtering-Correlation-Id: e1745259-70f2-4e32-016b-08dd1546e8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dJBNgA1yOvy18OMy5lMAeLZfC2bWeKkAhDU+gjTHxjbUnXNzH/UzsrH9WbKe?=
 =?us-ascii?Q?OxC1UVGHJKOsIlxrA0P7ksI6+yCgIjWUuFOMxetlp5WA96XPnzSMvht9uVi2?=
 =?us-ascii?Q?IC2FXMitAH3OrCZnG79IP+5Ay8QLvUD2xohRr+WDBDmLPeaUPNseNfFLD/h/?=
 =?us-ascii?Q?lXFHNROzYtqMHlBYLSa7uf/UL+2SE33l2Bta+NTmeNZrPqfJj7zqp+czN9tG?=
 =?us-ascii?Q?UOfR65o3p4c93Ed9t4DNAkk+eg3//YGc8evN7lC/hz4s6aSCT39a04FkNvO7?=
 =?us-ascii?Q?kthXJBhcfDR8uPybbesTV7JKml1kpqtSQZXQLe829QVFxDr43MfgRMp6GTxA?=
 =?us-ascii?Q?OofwEbOC6oUef9wWlCpiDKhCznjeNZCi++9YLvh2AYhumvUTzmCTjQMvzv8V?=
 =?us-ascii?Q?zy75BuS88M250t77vilP7rerXrBJVX2LqT91mMCdd/Q9nMdNh/tUlKFKVe5d?=
 =?us-ascii?Q?rrZUBIr8R4AGQ9Zs06kCYWfMWx7GreZYTno55ErIIWLkvVkebKvVBbsUznfT?=
 =?us-ascii?Q?QnGfh/183beTGZ8hKWXMT6mYJhI1oCzgBEhnpBsMy3EfL1y3mo3HzRalQfX3?=
 =?us-ascii?Q?5xBDj2qc4q8Srifm3szMPSGRdD2x8wC6VWFXJ0GU0EQpYoK1LaHTADg8BMST?=
 =?us-ascii?Q?0DWfnJBZjLYJTBwZE/QKImpM3KgnDUpLs1zn3UFddCXY0W27FEvzBAcQ6fZG?=
 =?us-ascii?Q?hSaqjRi6v+4leqO7w6gos+9WFTWkoy/xQmeNuedItx/JodAwXUfnqTgW/XR5?=
 =?us-ascii?Q?kUzQCtBq/s4ObkKQ4v6FGF7Sh+13Nc6S/SFu3Ly9QjjokqNKt28oECY7L659?=
 =?us-ascii?Q?vzZhGHk2DZ691wOFf+qcKddp6Ce5GHLvVjWRJl/F3mrk3MILl/7Hx7/4Y8sZ?=
 =?us-ascii?Q?9NQtMnEubjYC1oQef3mdz6SzjApVhw63tNFxEEUKW8kScU5FrsNDbgqXCl/J?=
 =?us-ascii?Q?ndv4aFZNBpaYzQjhHgdQt7I4XfUJvzRuZ9VkmvqMIy5XGk1v8e5NrBxQpm4+?=
 =?us-ascii?Q?X6QZ9iERnzgSoBhz7oHt2R/a1ZxPV42yBbaMeb6PZb+ndOiZdLBOoyxTLBdi?=
 =?us-ascii?Q?pJfixEO267W3aq1SozzQQPHB0AvnGO8zu7PiVPPd9s76yczLW5m4YrOrUqRJ?=
 =?us-ascii?Q?Z7FrBf9/kOfuOIQJ1HL1rKn2XyqVfV+SUeN3lwsaYhcwDVv/4k+5QLyzKHUD?=
 =?us-ascii?Q?EW/MEuUdbkS9BOQ7yGgQFBWrEDFiYZIXsR5A6dSgdRpoDC5Bo1PFjrrrZ3tg?=
 =?us-ascii?Q?QfYVAXbDpvl+X6tfENnDQDPGdcoHm2CpmqefgxwMrni1vUAiF5BP6R8xh/V/?=
 =?us-ascii?Q?Jwa16CAHTOEC4r3i9x6HMC1AHUZQvqYnhC/RAJ1lwMFesbQxM+zhojdCma9u?=
 =?us-ascii?Q?kD3WICPkVLKW4vTdqzJy5n4aXo2bO3oV/W74mqYNB8sHjR03HQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rIU9rlsHw7DhQ7OvXhNmCVFBfz/RByV+RjxI0Sl/EgviiUGRJBfsdB23qkVE?=
 =?us-ascii?Q?K8tR8WN6/XLH0Kc8cANTyX+yvZIV8ODU4MhEXyiVLpbKDM/d8JC1CFoFbIAn?=
 =?us-ascii?Q?XyvOSrFYT0/5W2SuAOaWHom3NSnwmAB7mRvdaZgkKDN+DfiGQyk8HeazhqT4?=
 =?us-ascii?Q?TlK6aJWGNMUvTaTvowKH3k5HlmAU1YLJ5wXyZfdkiVizEHBRt3GRMj1Pkk2u?=
 =?us-ascii?Q?a+usngMvY61wGc/GVDKTPFxzPwtUYClT1sjiwoB+kUnp9ZEz2Hq1JWakBTE9?=
 =?us-ascii?Q?8goNJJYwR6fEi+dwd8uvKEDFOFksBgS0uhkeFZmJBkqlKweF+9LVLMwC9KfI?=
 =?us-ascii?Q?3Ib/KiTfvj8t3Ia6uaEq/oikdUFxPwylxFmYfCmBHIgQoIFsJav2XP9wz+IN?=
 =?us-ascii?Q?I/bVPIcGKQOQW+UkV+hQFsmkNio7qp7EcNKjnDNzzQQ5WPDbg+B3Vy02Banv?=
 =?us-ascii?Q?2SGGRsvibygKFcmp0m+VWwZvChkPrZH8iFRLRMxcS82l4vOcrWntLHFnBQx7?=
 =?us-ascii?Q?h5+EiVuFNgSZ0uc0v3fWRlwtl6is5ZBnb3m3a6iGdXjYXeOaxmIQOecSG8xn?=
 =?us-ascii?Q?TVr1uMrdKs5UzhRbQnIe3MAERWdACYhVhc+9hyUhCsWbLmIQzC2QrkdETCas?=
 =?us-ascii?Q?MtVZl+y9CYY6dONsleC6yPCy+RmkDJerL9Pvgfv8SogbIDCtn5hIuTYRq7r2?=
 =?us-ascii?Q?WPGS9wDHdFM/VbtGz9RWe+K20ijNrPOwD0wna2uzaIjjfGMgrPDH8i4lXTV2?=
 =?us-ascii?Q?obHxlUJrE5awQytTHtIByi5fyzPkS8jSQF5vTA481z60r92n/uyUaFSQyb6Z?=
 =?us-ascii?Q?SkPk00s2cjh9eCNafqtILYcEMaD1Yw2yB5YAUtKGstWfbaVM/SuAJHhcUolV?=
 =?us-ascii?Q?Hz08GH/RTorVXst0DEn644TZKk7ZAr8cuRGdsd+FbL5DYK56lFancCJq6FaB?=
 =?us-ascii?Q?s3UlhQttQ6qQpE6SWPjWgsJ0w9PnBZsfk+PgXrm3IDF4KTbXRIUWYJ8tvwJQ?=
 =?us-ascii?Q?JUJ85sLzhJelAG+lyDft0FO4L9/MXdV4v4VV3D7hvmr3NL2PZ5gyoB0bczmY?=
 =?us-ascii?Q?Rqko4A72sMXNeOqz7HzYmxHwgH1xuJ3eZBdtD5lDowOhLNcps1UlZgNVNgLc?=
 =?us-ascii?Q?WgwlJS342AppTEVbn+4/Uw0vPYaWtWyIDR+jMvb0Ct/PwHNyYLRdkJrjwCTj?=
 =?us-ascii?Q?6jsT6ga7vk4UnFuoyeol6kgedaO8R72+LjRFNK8yHBGdd8kkCFWcK8kwVzZO?=
 =?us-ascii?Q?Wj7FMzkLWg2NAxCDc/tCmPaPpsXtdx6mhUhJgCXHO+XJGADXUAqa3darR2JP?=
 =?us-ascii?Q?dD2D7bz9NrwfyVoAN1w6CwcMBlWjo2bncnoJ0XmwHzdxqoXupJOgmO6cZ6eD?=
 =?us-ascii?Q?C+HNlSfT96rwIUTdiVNLrxOZ4O0RV1+as3esHYf0qkn2cjxw5Geo1595nHY3?=
 =?us-ascii?Q?9/0REPP1QO29nJvfixVHqQZVUjQNPrxQmyxMj2Wo6b67R3Xej2HguW6PJMLu?=
 =?us-ascii?Q?SStcVUDqIYLs+aPZNzu2E0bDFFS4RrwOglQF1OVM+Du52FvBXi1YDWLY6CED?=
 =?us-ascii?Q?ONbqepjpQu4Z9BnlmrPi8/omAzbCJTNyQ5eFN7ZD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1745259-70f2-4e32-016b-08dd1546e8b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:07:25.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vk5nJlginhHo8Ak5SeNrNYVFuBUTUb+LQgN+vuIAn9fRX8jD+RPaOsANYR7cloeEPxlr7JWRhx4xMLmYdcka6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10085

On Thu, Dec 05, 2024 at 11:25:07AM +0100, Lorenzo Pieralisi wrote:
> On Tue, Dec 03, 2024 at 06:27:16PM -0500, Frank Li wrote:
> > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > This involves examining the msi-map and smmu-map to ensure consistent
>
> This involves checking msi-map and iommu-map device tree properties
> to...
>
> > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > registers are configured. In the absence of an msi-map, the built-in MSI
> > controller is utilized as a fallback.
> >
> > Register a PCI bus callback function to handle enable_device() and
> > disable_device() operations, setting up the LUT whenever a new PCI device
> > is enabled.
> >
> > Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v5 to v6
> > - change comment rid to RID
> > - some mini change according to mani's feedback
> >
> > Change from v4 to v5
> > - rework commt message
> > - add comment for mutex
> > - s/reqid/rid/
> > - keep only one loop when enable lut
> > - add warning when try to add duplicate rid
> > - Replace hardcode 0xffff with IMX95_PE0_LUT_MASK
> > - Fix some error message
> >
> > Change from v3 to v4
> > - Check target value at of_map_id().
> > - of_node_put() for target.
> > - add case for msi-map exist, but rid entry is not exist.
> >
> > Change from v2 to v3
> > - Use the "target" argument of of_map_id()
> > - Check if rid already in lut table when enable device
> >
> > change from v1 to v2
> > - set callback to pci_host_bridge instead pci->ops.
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 183 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 182 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index c8d5c90aa4d45..ac5caa7b05075 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -55,6 +55,22 @@
> >  #define IMX95_PE0_GEN_CTRL_3			0x1058
> >  #define IMX95_PCIE_LTSSM_EN			BIT(0)
> >
> > +#define IMX95_PE0_LUT_ACSCTRL			0x1008
> > +#define IMX95_PEO_LUT_RWA			BIT(16)
> > +#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
> > +
> > +#define IMX95_PE0_LUT_DATA1			0x100c
> > +#define IMX95_PE0_LUT_VLD			BIT(31)
> > +#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
> > +#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
> > +
> > +#define IMX95_PE0_LUT_DATA2			0x1010
> > +#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
> > +#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
> > +
> > +#define IMX95_SID_MASK				GENMASK(5, 0)
> > +#define IMX95_MAX_LUT				32
> > +
> >  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
> >
> >  enum imx_pcie_variants {
> > @@ -87,6 +103,7 @@ enum imx_pcie_variants {
> >   * workaround suspend resume on some devices which are affected by this errata.
> >   */
> >  #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
> > +#define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
> >
> >  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
> >
> > @@ -139,6 +156,9 @@ struct imx_pcie {
> >  	struct device		*pd_pcie_phy;
> >  	struct phy		*phy;
> >  	const struct imx_pcie_drvdata *drvdata;
> > +
> > +	/* Ensure that only one device's LUT is configured at any given time */
> > +	struct mutex		lock;
> >  };
> >
> >  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > @@ -930,6 +950,159 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
> >  	imx_pcie_ltssm_disable(dev);
> >  }
> >
> > +static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
> > +{
> > +	struct dw_pcie *pci = imx_pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	u32 data1, data2;
> > +	int free = -1;
> > +	int i;
> > +
> > +	if (sid >= 64) {
> > +		dev_err(dev, "Invalid SID for index %d\n", sid);
> > +		return -EINVAL;
> > +	}
> > +
> > +	guard(mutex)(&imx_pcie->lock);
> > +
> > +	/*
> > +	 * Iterate through all LUT entries to check for duplicate RID and
> > +	 * identify the first available entry. Configure this available entry
> > +	 * immediately after verification to avoid rescanning it.
> > +	 */
> > +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> > +
> > +		if (!(data1 & IMX95_PE0_LUT_VLD)) {
> > +			if (free < 0)
> > +				free = i;
> > +			continue;
> > +		}
> > +
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> > +
> > +		/* Do not add duplicate RID */
> > +		if (rid == FIELD_GET(IMX95_PE0_LUT_REQID, data2)) {
> > +			dev_warn(dev, "Existing LUT entry available for RID (%d)", rid);
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	if (free < 0) {
> > +		dev_err(dev, "LUT entry is not available\n");
> > +		return -ENOSPC;
> > +	}
> > +
> > +	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
> > +	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
> > +	data1 |= IMX95_PE0_LUT_VLD;
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
> > +
> > +	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
> > +	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
> > +
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, free);
> > +
> > +	return 0;
> > +}
> > +
> > +static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
> > +{
> > +	u32 data2;
> > +	int i;
> > +
> > +	guard(mutex)(&imx_pcie->lock);
> > +
> > +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> > +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> > +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> > +		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == rid) {
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
> > +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> > +
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> > +static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> > +{
> > +	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> > +	u32 sid_i, sid_m, rid = pci_dev_id(pdev);
> > +	struct device_node *target;
> > +	struct device *dev;
> > +	int err_i, err_m;
> > +
> > +	dev = imx_pcie->pci->dev;
> > +
> > +	target = NULL;
> > +	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
> > +	if (target)
> > +		of_node_put(target);
> > +	else
> > +		err_i = -EINVAL;
>
> Why ? If target == NULL err_i is already set to a negative value ?

When no "iommu-map" exist, target == NULL, but err_i is 0.
See below err_m table.

>
> > +
> > +	target = NULL;
> > +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
> > +
> > +	/*
> > +	 * Return failure if msi-map exist and no entry for RID because dwc common
> > +	 * driver will skip setting up built-in MSI controller if msi-map existed.
>
> This is not ideal - to depend on the DWC common driver behaviour.



>
> > +	 *
> > +	 *   err_m      target
> > +	 *	0	NULL		Return failure, function not work.
> > +	 *      !0      NULL		msi-map not exist, use built-in MSI.
> 					^^^^
> "function not work" does not mean anything, sorry. What is it meant to
> say ?

RID is exeed what msi-map'r ranges for example

 RID	MSI   stream ID size
<0x100, &its, 0x8, 	0x1>

If RID is 0x101,  err_m is 0, target is NULL. sid_m will be 0x101, it is
wrong, because max streamID width is 5bits.

So it should return failure for this case.

>
> !=0
>
> > +	 *	0	!NULL		Find one entry.
> > +	 *	!0	!NULL		Invalidate case.
>
> "Find one entry", "Invalidate case", I don't understand what they mean.

Find one entry means get one streamID, as above example, RID = 0x100,
sid will be 0x8.

Invalidate case means never happen, this case doesn't exist.

>
> !=0 !=NULL
>
> > +	 */
> > +	if (!err_m && !target)
> > +		return -EINVAL;
> > +	else if (target)
> > +		of_node_put(target); /* Find entry for RID in msi-map */
> > +
> > +	/*
> > +	 * msi-map        iommu-map
> > +	 *   Y                Y            ITS + SMMU, require the same sid
> > +	 *   Y                N            ITS
> > +	 *   N                Y            DWC MSI Ctrl + SMMU
> > +	 *   N                N            DWC MSI Ctrl
> > +	 */
> > +	if (!err_i && !err_m)
> > +		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
>
> Here you mask sid_i
>
> > +			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +	/*
> > +	 * Both iommu-map and msi-map not exist, use dwc built-in MSI
> > +	 * controller, do nothing here.
> > +	 */
> > +	if (err_i && err_m)
> > +		return 0;
> > +
> > +	if (!err_i)
> > +		return imx_pcie_add_lut(imx_pcie, rid, sid_i);
>
> Here you don't ?

Okay, only need mask sid_m.

>
> Moreover - this would also cater for the case where (!err_i && !err_m) is
> true ?
>
> Probably cleaner to do:
> 	u32 sid;
>
> 	if (err_i && err_m)
> 		return 0;
>
> 	if (!err_i && !err_m) {
> 		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
> 			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
> 			return -EINVAL;
> 		}
> 	}
>
> 	if (!err_i)
> 		sid = sid_i & IMX95_SID_MASK;
> 	else if (!err_m)
> 		sid = sid_m & IMX95_SID_MASK;
>
> 	return imx_pcie_add_lut(imx_pcie, rid, sid);

Okay.

> > +	else if (!err_m)
> > +		/*
> > +		 * Hardware auto add 2 bits controller id ahead of stream ID,
> > +		 * so mask this 2bits to get stream ID.
> > +		 */
> > +		return imx_pcie_add_lut(imx_pcie, rid, sid_m & IMX95_SID_MASK);
> > +
> > +	return 0;
>
> return 0; is dead code AFAICS.
>
> > +}
> > +
> > +static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> > +{
> > +	struct imx_pcie *imx_pcie;
> > +
> > +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> > +	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
> > +}
> > +
> >  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -946,6 +1119,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  		}
> >  	}
> >
> > +	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
> > +		pp->bridge->enable_device = imx_pcie_enable_device;
> > +		pp->bridge->disable_device = imx_pcie_disable_device;
> > +	}
> > +
> >  	imx_pcie_assert_core_reset(imx_pcie);
> >
> >  	if (imx_pcie->drvdata->init_phy)
> > @@ -1330,6 +1508,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  	imx_pcie->pci = pci;
> >  	imx_pcie->drvdata = of_device_get_match_data(dev);
> >
> > +	mutex_init(&imx_pcie->lock);
> > +
> >  	/* Find the PHY if one is defined, only imx7d uses it */
> >  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> >  	if (np) {
> > @@ -1627,7 +1807,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX95] = {
> >  		.variant = IMX95,
> > -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> > +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> > +			 IMX_PCIE_FLAG_HAS_LUT,
> >  		.clk_names = imx8mq_clks,
> >  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> >  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> >
> > --
> > 2.34.1
> >

