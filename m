Return-Path: <bpf+bounces-30845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0658D3A2E
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 17:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A353A1F282F3
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 15:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128417DE36;
	Wed, 29 May 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m0F9jGTW"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070.outbound.protection.outlook.com [40.107.241.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15BD2F0;
	Wed, 29 May 2024 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994870; cv=fail; b=SEzrnfxO9xETN97C5j639yIn+0h7XMVzt2Zu0QxXpk90DB7ZRAvv/e3C2aaGNYx/FnPB6bdjrz1XDKESq5GGLshf6gKVdi8Nf66vwjkZGaBtqr1mbFr/BO2IO/jQWYiGR+54X1Zkn8kwhPWAPYS+KbIku4pIJZgSqEfolVqEEVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994870; c=relaxed/simple;
	bh=OyYTN+pHlkuyuDD863WZ/lNuPq+xbR7G65Yy1o40wKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WtY52I4Mfob+IaxwoE2B+DaI4aRyjpUJrMdG5ldzcNGDqe0XAX7kaDt/aGD6NFzk+Ic1HtQf9WNhTUHVM5z9qaxbsxQfSKDhvgzsqeo/kWGA06hC4u1ScM0fUE6n2g2h/YmfCiadBE7l04Eux/NzAIM3AP43PaaOR8hrtFNc0mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m0F9jGTW; arc=fail smtp.client-ip=40.107.241.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsRH6OjSmn7bzeTsEaRIyWQUDOMBRDVSbJ9JQtXIu7mGVsKzsSFP1OTB71VYSoc3KByAJxMcNfDoZwAFbBKd9mXZYKQBSyYFMHEP8c2cVZEeqFoHWDEqKopn7PqAFwmjX1KaI3L3nJ7g0kYHQDf94n80WrKsgCxqBLPX6FP5aqF9KbNmvQNoCiMlDECDWMHMcX8gN4XEDdJziVRkpDwbuOGu1uOu/cCSPDx3iMu77en/cCZZ15l4Xfrf8lcrqXgNio80vxOUVOHy36kCoAqDVH5oX5J3RJOgE4jC1vxUxR43C4J1zg854eoQdDDqPG3E9gmgivMvjQWHOUCoGJA9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHG+3OsL2/sCl4bWEv+beUqhF8Tc/5Nm3VxleNLibB8=;
 b=QpgqSVEpgvRlDhNzEstB8efII50eeHqkJxDDwoSA5uRQpDg9t80W9OYviRbhvfGXVgDt2Bndwxzu6kqDMIO31BwedtUddgK38k0VtJlIekCQKJauixfvqKDwE7IiT7ZyhL8fnhre0i5yZZTVcQUwguZ8YTQnokt2YyUMCP+S7kIHfIcc+9utnX9Ho79lvPhcSkx/tzPodo4fcj05VG2lvGWSQSnGxvl/4CNYEsVno8My6q64W8hPbJ2w9XFjKLb7WcKSAc0ZFisDGB28ZAh1UHLUlYdFaQwUASPx+5yQJZXbxqtatEZbcZWJpEmiU6nAimqNbJXhkQYF01Tm0erF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHG+3OsL2/sCl4bWEv+beUqhF8Tc/5Nm3VxleNLibB8=;
 b=m0F9jGTWzF+EHEuLqwlctbFRawAUUjkfyF0UMG2fW5Tjl+nb+lGIqxn0QhzpRpbUC+otsGK+dZ0nM2+iWXtBAtaJ+L/f1KqUaPEQSz69n3LdjHg5azpy1o2l1GFxhaGweZkOd26mnMipzjTyHMApFaCOnEITIOU6LQe9nPtUkGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7391.eurprd04.prod.outlook.com (2603:10a6:800:1b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 15:01:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 15:01:01 +0000
Date: Wed, 29 May 2024 11:00:49 -0400
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
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 00/12] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <ZldDIabPAa7NEmDQ@lizhi-Precision-Tower-5810>
References: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
 <20240528223136.GA473846@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528223136.GA473846@bhelgaas>
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7391:EE_
X-MS-Office365-Filtering-Correlation-Id: 6803bc9a-33eb-4087-ee02-08dc7ff027bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VBbh9/+nvdyBxhMfeFyzf2d6pNoGpkYAZfQwsoWWoz93bjvuFjSXl4wTmI+N?=
 =?us-ascii?Q?8ynXiaQP8j+puEN4bcemRtys1GWUr6ZUZV+3DESj+vQZ7cZxMurkN3749hgk?=
 =?us-ascii?Q?n5X8ounl5F6znxnCNFVsEU4sZbUId8epA5nveNeL0e0Rs+xqRlOhPkdVTr29?=
 =?us-ascii?Q?F4t/szsYCLZsN/ui8l32Hh8XL/qVfrasqOHUEYSprpFDUsXVlcv/4/zbhvKb?=
 =?us-ascii?Q?botUswBk+ZJUhhiX3Ss0L6XoqKa0HOkkWmeyaZx5Qgnj15cCPWHyqPGRCJsv?=
 =?us-ascii?Q?5II0KJ7KCKkUZUBKoOnVgRLvUF10SIfUs9IBNbPbPLG1WwoQfQ0DNMHPRJ2f?=
 =?us-ascii?Q?GlwnhPP3fnjT6DRj8b/BvIIfGEg5WgvQo62uz/HjQ/CPAYEy0muVK76J8NAK?=
 =?us-ascii?Q?9cGQjAs8Usf5I/20QLVXU0jVJind+rEYytfu+NHJXf4/k5ZTq775zGILue3Y?=
 =?us-ascii?Q?R2dV+n741KbbADEDKSBNs8kaSaLSKedPwUSqe2POUy6X7JLDfGoF1nkOc5k1?=
 =?us-ascii?Q?xA1k0gxXjttBCVfT/xJbRkeDAJmCZOPkvclSBELgeo+9fWoNxSEwKqYKn7iE?=
 =?us-ascii?Q?OWrc4Yz3IgJSlfUUQTl2qmYK/5S+8FKsGYRwKbF3TK5lLZ+OBkMw1I3t3W+a?=
 =?us-ascii?Q?22Vcbg0P/dQx5w6QiGaT+FmeAcKBwz/Bu3L/H6Kxr/P50YIIO0faV93KMv7V?=
 =?us-ascii?Q?zZAfkMdIIq7sTenhdLUOoRLEl9Ly9ssvdc57RbWyxlGZHlZQg6EpuFFtH3m5?=
 =?us-ascii?Q?GZjYBmMjquA0KFOQqlxekCL8Q4fl11dK34LFNJIOmOR5CsBBXrv67cZaEZSG?=
 =?us-ascii?Q?U/DKmfaO4a9e9B7sl3pik1d2wMUFkC0gUZwU3+xCJwzSGsEqtor5G0oip4n6?=
 =?us-ascii?Q?5QUH75VlH4dogopi/SP0wWo3nBxmc4umJjaUCdH6tU5yduPkUbGx6QrW+XlU?=
 =?us-ascii?Q?YOxawnWHjTdOqSoFb+Tnpb9S3W8UDx4tl1+tqBiVXvz/CYJcneatUhz8oDRW?=
 =?us-ascii?Q?IJGFY+xCUxOTjCox4Yf/bd5WRIJ0jwrHzIA0Th7XcjeIGvvWYI4nwqQrRTBM?=
 =?us-ascii?Q?WkrL5s6mcP+/b8CRRFguDEQluMKXxfDVChis7uloyd2hKjEzp6A3AgSbpqjR?=
 =?us-ascii?Q?keDEP/ZrVKrTMV56KRc3U+vse1iAP4qmJgnZBnXvoybH9t+ITO04XhPz+mMf?=
 =?us-ascii?Q?mdQ3x7Ek0oC3zM+IzPqW3XPxiTgseAQ6RUqeQ0EuuCrTfDgNq//Ns+V0WCF4?=
 =?us-ascii?Q?hbScmR11LAmTW/Pmpu3FfMjv4QvXdaXSmFjYNTMiLTxzDaZPbevzwIvec6mT?=
 =?us-ascii?Q?als4ytEIqBz6Thhls7Zz1EQCgG3OGZ/2aGdzkM4egSfOEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZO8KH/hwRLtF/28XLHo4/qB4BRpS5vcyxi20g6yoZdEYWUb8xvYpJs88dfW/?=
 =?us-ascii?Q?rcT/Yt7YMrgV1sH9J/CD6XCngO1HO8TRNAyqoUm4VfdH0aYWM1s9LklEgdXF?=
 =?us-ascii?Q?pqRF7sqRpUWY57HgB31xucJBl416sRD0CTZ3UU1i9P9qGoLr9mDrF98mmrqe?=
 =?us-ascii?Q?0lpHWStiuzY9AMs8OOaaRahVS9Px1O3gxGgm5laFAC4hDNYY8jzR0xRTUZJp?=
 =?us-ascii?Q?1IgOmlZhUxqNRt0hceX98XnX23Phoyz72vQ50Vy7H5G2/1vJigj4+/g74MA+?=
 =?us-ascii?Q?6se9QO1MQhiMCu9GzRoR/t/wtZY2H39NPYjtQe4ytSuDd2ASdq4+ITPpwRSY?=
 =?us-ascii?Q?xs9H7A/fPtySMLcd0aQzX/hEY5Usfn1UahhXRh5SO5mMknaJZ6sCQna+HqVP?=
 =?us-ascii?Q?PBcAqbU9wasQM+hfmM4knHXhHY3gJwwunNNL1z5dCU0o9xpvHpWL32isxUH6?=
 =?us-ascii?Q?E/CaKxDV9gDrc+pR1w3tZZRTcjxBqSzkquqb6cRgylEf9E3XYKop1G0uQSUd?=
 =?us-ascii?Q?KtG2dcK0BVxlcqfHvNFOiOSuFU+vdbRseVytmeNIWhCj7humqLaTrJtRSGLR?=
 =?us-ascii?Q?zzz9JffGh5hDmWoKBjXIAdnGYVcakl7PCJT23lyTPteNf0fr1ckbSqtyGi/l?=
 =?us-ascii?Q?HpNGvmsL+4tL19ckKS8CpGay05Yb/v7pfkrj9oq1tCOBTkoW6JmWcMPNcD7a?=
 =?us-ascii?Q?qBCdKEsCf9WxP6K8QJZAvG1PRLWKA2ctF119xYoHBQBdGZdSDyZSpRjWvMbn?=
 =?us-ascii?Q?vnuJxT+UV3Ujo8qshiE0OAD9fW5pgHjwLAvso116xgnljWolPlYBytudWjuR?=
 =?us-ascii?Q?8JOT6768E9UMUEJqK9dmHG9xFsSEptwMi+jZWvmSD+RnO+pINLNzIPnHu9yZ?=
 =?us-ascii?Q?1rWtBcAXVvlXDzHXRbVwr05QxkSb9Ww+uPJ1YtjQlkhpK2QeWhVpTxlotXWE?=
 =?us-ascii?Q?7xX3yzhVmMhGHYrqL3kVtOa9XGw9Vgho7hRwnVgt5JxAX0Je2tdXE9ys0QjY?=
 =?us-ascii?Q?vPLTtNe9vye9c2u7qSe1woqSGj5fkZuOL7ZJlS3t33MmbPaV9FXK8i9Crhyf?=
 =?us-ascii?Q?To9mQFZH45i+5100UHKtTeO/geJQCpgGaBpbLuhSBFp7h9z7lXFW41lLTteO?=
 =?us-ascii?Q?zee5ZZG+ZgmT5wvBaaIIsLB2B0Ph9xefINOPOlxmuh3tlyl5sMsK8ufTYyq1?=
 =?us-ascii?Q?N/XI5+WeYf9dCrbgZcQsrJiTlTA7AzlLJlFGnC4AzShN05tTaEZ7qlUUkdTq?=
 =?us-ascii?Q?xXAex4ZPgSdLXCQni5WVO/I+SQ3gjAcWp8cMhdnfgyU43kTz0gMv7IQ9AxcG?=
 =?us-ascii?Q?awAven3A6KWUEO6Oyg4Dda/ImX26n0ktu7se/doyZY0v9JhvRkxUIbnASREt?=
 =?us-ascii?Q?fjw/jmgx4HqMHXLPl+ZY2sN9sKVXqlF+094NN4f4HLj5DGpI8Vxgy9shIgJL?=
 =?us-ascii?Q?BlOr8KAe62oJMMsuMCMMpSMPwe5Vk94qYJFumfr+pduWlqzlNfG7BgcL7AK0?=
 =?us-ascii?Q?QjRbOCCX2M9kNCmmibCPwhtsGYs9VBiZhT8yMHIjJPrq0vZLOSFjter/Pcfh?=
 =?us-ascii?Q?o9/1c4NVcPs9BV/6VdQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6803bc9a-33eb-4087-ee02-08dc7ff027bc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 15:01:01.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efQvNHTmL/y/vnJ+/YukFK6hj9+7K/aiNhP3C+yxJrgbxS5IXN+X+Y65OQbJtXM151XJRa4uEfklpaLS3KkiKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7391

On Tue, May 28, 2024 at 05:31:36PM -0500, Bjorn Helgaas wrote:
> On Tue, May 28, 2024 at 03:39:13PM -0400, Frank Li wrote:
> > Fixed 8mp EP mode problem.
> > 
> > imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
> > confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
> > pci-imx.c to avoid confuse.                                                
> > 
> > Using callback to reduce switch case for core reset and refclk.            
> > 
> > Add imx95 iommux and its stream id information.                            
> > 
> > Base on linux-pci/controller/imx
> 
> This applies cleanly to the pci/controller/gpio branch, which has some
> minor rework in pci-imx6.c.
> 
> When we apply this, I think we should do it on a a pci/controller/imx6
> branch that is based on "main" (v6.10-rc1).
> 
> I can resolve the conflicts with pci/controller/gpio when building
> pci/next.

Sorry, I forget update this. It should be base on linux-pci/next
(e3fca37312892122d73f8c5293c0d1cc8c34500b). 

commit e3fca37312892122d73f8c5293c0d1cc8c34500b (pci/next, linux-pci/next)
Merge: 86e0cd3da71b5 d19a86d584e04
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue May 28 12:34:12 2024 -0500

    Merge branch 'pci/controller/tegra194'
    
    - Ensure Tegra194 and Tegra234 inbound ATU entries are 64KB-aligned to
      match the hardware restriction (Jon Hunter)
    
    * pci/controller/tegra194:
      PCI: tegra194: Set EP alignment restriction for inbound ATU


> 
> Bjorn

