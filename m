Return-Path: <bpf+bounces-22957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E686BC39
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404F51F228C1
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C2072922;
	Wed, 28 Feb 2024 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DOecrl6u"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334713D30B;
	Wed, 28 Feb 2024 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163094; cv=fail; b=VWPeDjUwuTtGjRNZ7fcDYvNCWhimfYPTbkgUzAIUjATfPSMGPmhIaqQpCzYLTZghoR+YG7ngS1FU0VfVjVhDnozhwiPTBE7UtDtbUhOhxT7y/BNTiJAS2a/sZ+oHahynwEUpzxSIeG1xvpH2bLAoWBvipwjlW0NcS6IwGdj9O8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163094; c=relaxed/simple;
	bh=rLIdj5UcUhCGPtWdkyxjophg29bYk6fqDo8nhqZl+yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i0wg49K+5W9b33eWgqd2nBsMPwNj7RC03U1X1J3cogbysLdiLQPvz12cPct4+hIxs+0W1T0AhzU8xT9uKnpmPgQIEy2fjmjewKtDIlkSwvHzD2AO6BxUj3wkMNIMfMDjhyHp/dw8xp54LT+xQ8EfF/zAiQhCYDX46NYllYGMIvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DOecrl6u; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chtxeeQxGXG7py+QoBPvl5lRbz5T2ukaHbyBoAugKYEisQZfkjqcS7jhWT39llQen7QqZRfHl79pAH9R4Z21fX0WgtnsEMGB/KStnHx+36iay9dhKmh7ZbSPOHPeHo6mQFSa94jdIp/AZVBThYmDB9JdLeFqKMs7f6a6zq8M3Xhtap6vZ2sICk8Y5ggnWNmeynXF/X47KkCMSd6I4WOlhdazM886G271md2Yam96GWB497dyoUDl4UuMf39M3HnhXe5t9dJBRUO2TiML5tWIbN0Qm86tVKIqFLc1OP+QDM6A/KgV0Xw1IxRO+2d4tWV/5Tq5Irtm62ER77jQw2xRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+zEujrZgRRWcv/CKCH6/6JwCOeRo9m+Bgoy3Dwi1q4=;
 b=oBB7n27hvGBjJb2VrLoBuOfSHpnseKq5n28GoXzF9Qit8cTFH2Y6CmyFSqwiVcSjkE3yfvbK24JB+1f86OMroNS87vhMQU6Mwo2l2gFXoGua0SfAtv5G4CjIQnQ5QfRQZSCDU4++6UFU88vHnow+yrE6vz9QY0tT2nyKxlqwNs85/f8Yk83uFOcRIwIY7kE6y9/7SXmqdYMsawoRD0DXlmRvdBGZcA3fnqKmcWKHhy+DgAlj+YYdflnmpK3vd2EpGIWCsXyLYLMSDN3buZ5xyvqBydMf4VBgjr0yd/Sh76QvB2x8wW/vXS7lBQMeoRx1X3xM+l4u2VvRW1Qr8PeVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+zEujrZgRRWcv/CKCH6/6JwCOeRo9m+Bgoy3Dwi1q4=;
 b=DOecrl6urjGbG+540Ls2CEWGkVu5AYt8KAyhQv9Gt+oGjbfDcczeXFvGhlZu44lVVCCg7sG1BzrvoZrJQTsFJ0ZteyB7I9eI+akunxV8PAThd5GClCfqoSDqovhPxZhyoO01DxpaHrgc7+FJ4e23vaFu7FR5D3Yys+ts4GobBQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6865.eurprd04.prod.outlook.com (2603:10a6:208:181::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 23:31:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 23:31:29 +0000
Date: Wed, 28 Feb 2024 18:31:20 -0500
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/6] PCI: imx6: Rename imx6_* with imx_*
Message-ID: <Zd/CSFU/FBsp803i@lizhi-Precision-Tower-5810>
References: <20240227-pci2_upstream-v1-0-b952f8333606@nxp.com>
 <20240227-pci2_upstream-v1-1-b952f8333606@nxp.com>
 <CAOMZO5C-01=jYbJTgQucfD8+pT-chy4xvQMckUee1O+gtE-0pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5C-01=jYbJTgQucfD8+pT-chy4xvQMckUee1O+gtE-0pQ@mail.gmail.com>
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 988034d4-38f0-471f-d367-08dc38b563aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z9izIDaC41+atgIzs2byxiE42kLpBnuTfkYXnRVN/wOHakhewMw22h+bQ8hARkSqiVlEpjnYYnCcdSDJbTum4v94yhpN20ixFCuuwcxL1YzgPknDmS6DLZt2jQRiaZZjEewjfD/VPhlMW/5+wpSnYu2fPnbd7CWnUcfkKgSgAaQ+c9ZH5JrgDBRSCjEUBe18W56z1FtmKhnsIwsw+bXR0IIySyPgoxYSLyBrMMnWoGs+vvXLwwN8rTckq0hfNAKYPgSIzstnErfcFQZGN5Q5Xrlkm7eOrdhhdoEu7e7/c8W/LA6UIWTxfjlopYWuf2vk6D16i5c3N/OtSBXPoq7ixIbqI58iQFGmUDvrAcnJZaRa2YqsEh6n4VCCFoDjLDSg3wSsFrtboe81HloU1Hvl4C0KGEgkOlDa5k+YbDFP/M0Y+l6CiQcEraaLgtM+91F9WCpDMRmEGreYESJ2WJ7tGXu9kldi6y2dE0N907/Zj+1/dnZLBO0ytFFvZ/syd+bRINO/thF5WVHpzeJab/eJLwidVFowhwmrR1sQdDxnin7IyxM5rFP++h4QHiIYxh+FkvxOFmSgi3AqzEppuTcDcPE/PwXTD+qzzuDW6gULs3VuWiK+/jyEsUjXUBA05umMhGNhqfD101rBCK9CrrO0vglnBqJBuO+0trNC4wuEnZ9ZS78ekN+4ckw1iG9Mdwv559axMSeJbMKdN5XGyLaBoDLENc/tCnWXLqy8WNaMwR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDhqSTFyNnN5bE0wWVd0MXBZa2pwcmlEd2ZHVFVVdkw0dDhtNktHS25Zc1VY?=
 =?utf-8?B?cVZLSk00V0NqaWtTaGdweFRrUnhlT296NXlKT3RxVVlIRCtBb2ZMZTVUL2ps?=
 =?utf-8?B?cFl0cWhnWDZkbU9Sd1J1dWZoNnRneUh4dXl6dmd5R1JScDM0NVFIMHhRNDZv?=
 =?utf-8?B?NUd5YnFyYU5wZFlKenYzaVV4a0I4S2NLc1kxWEpLcmhhb2NyZEYwNTd2N1F0?=
 =?utf-8?B?MlZUclMwcjc1UzNzWmU5dWtYOU9zRnRCdDB5cHFRTXFkcnU2eTNzc2F2TUZj?=
 =?utf-8?B?L3RGM1J2VDdZc2JVZEVYOUtsUnJMQmFFL0FMZ2FvZDZqL2Q2VkNVOGcySEM2?=
 =?utf-8?B?WHlwclA3QTdTY1BJWDFvK21xUzFMOHAzRVJORFMyRkNpdjB3Z0x4T3VnQmJo?=
 =?utf-8?B?dVdYV0NpYllnaUtWOVhXRkE2UG9ObXViSDkrS0lTTE5rRElrR05PU0tBTXF5?=
 =?utf-8?B?WEJkQlo2R3UrZ2tNc296ZStjME5ZVTh5QkV4MWhmL2U3S0xTbkljcktnNkRv?=
 =?utf-8?B?MDJmbUFlNkNRbmVBWEhOSVBZUmxzWlNIYkp0clZLNGI4dnlGeldPc1FGd3Qw?=
 =?utf-8?B?Nno0SGRtTlNISVpDdXIwTTdaazJyaWUybDJqdE5yS0F2bFFiWW43a29tK3or?=
 =?utf-8?B?Z0VxSjdDSURYdlZmSkNnQmxBMzF3bTQ3ZTc5ekFjbWRncEVXNlRDRGV6dHRr?=
 =?utf-8?B?dFIraEgvYjYvTmtJd3dveHcweVcrcFIxNSsrZjQ0K3FJSzQvb3hBd3NCbVN3?=
 =?utf-8?B?UjF5VWkxd25TeCt6K3pzcnBWaEFMbHpwTG5CSWhuTktJSXJHVFprSkNRNGE2?=
 =?utf-8?B?NVkzTWNMVm1FUEFvSnhldTRsN2orVVljMFg3S1F1ODA2TTdWck55YXZvR3Nw?=
 =?utf-8?B?elIrVlo3aUhwWEdZbEdmTEoybkFyZEkwVDZsTERxSWRWQjl2SFZSWXREK1J0?=
 =?utf-8?B?MWVId2IyZVZwY2dQbEQ3OU56aTRlUGF3eE1zU2dPbGpKcVZEVmwyUHZJMEEv?=
 =?utf-8?B?NnZiWGdwYTgxRlNOS0NZekhDZnU3dG1FeXBzSzIrSWhMUHdjZnJUTUlkSXBC?=
 =?utf-8?B?d2VOcnpqUEJrNUtXU3oxMEVEVzVqbG5aSlBZcHExbHViR2d6TkNVR0hheExV?=
 =?utf-8?B?MHo2aDlKMm9RZlJKSHRleGZMbzEyc1lYTUNGTlFwenVVMXZtSkhtWWJOZVpQ?=
 =?utf-8?B?b29yQ3pSKzBwUzV1bUROUG9ldjI3TmE2citoTXVYREMxTHhrL294aGtGL3lW?=
 =?utf-8?B?QjJyWEZBQ1FjTTdOTldrUEVKcUh6eEVuNTJaU0t6aXFVUkp5NjFoMk5wNisx?=
 =?utf-8?B?T2YzdFpzbHJwL0VwMEp1OHplVW5DZXB3b2xnRjJaUDd2S0VDYWhnUDQwYU1I?=
 =?utf-8?B?aG12UGZ1M2o4VG9JSm0wMWhXN202Rld4ZjRGNXJoRnpoRkk1amk4N3lLcGJ3?=
 =?utf-8?B?RC9RRXFqTkMxTHA5b1BlYUloVWVWMnJUU05zQmwrZXdLVUlHdWFGOG9vNTB2?=
 =?utf-8?B?eDlCa28rcENVZ0xGTkxINWFxVVVLZ052RUNUSXVLSHlrOElqRHhUVE5TREJX?=
 =?utf-8?B?K1EvVjdHVnFlL3ZTQTZnMmNOMUxLekJIaWVHUEVJQjRESXBscEZwcjJ3bmI5?=
 =?utf-8?B?akluZkZiYTJaRVhIa0hrQmNmMUZQaTM1M0s2Q003N2ZXeHIycEMyWVJmUGZB?=
 =?utf-8?B?aHJrb012MkVabE9vVGtIamN6Mmw3UVVBMGVHUDFBNWtQanpheWhZU3NtdjJ1?=
 =?utf-8?B?S01hcEVpK0NET3lvUFBreStTL2JRN2hydmJ4bEpuSW4vdmpiUVVyMERXeWJ0?=
 =?utf-8?B?TTBXb1VXTUVjWWI3UUtZWTRPM0RLWDY4bTBuTnhUUno4ZUpVZmJ0TGZzUTlS?=
 =?utf-8?B?ZzZxbS9RbzVlMnJUQVd4UnpCN0tFZlpFeDFlZEhOR3lkK1N3NTF4aWJhcCtz?=
 =?utf-8?B?ZUFjZTJGU1J1cjk4Yks1dzZvWmFyenYxZ1Fzc0xXaEhaOVIzaWIzRHZNSmxp?=
 =?utf-8?B?Rm5VSktkVnJtU2loS1BZMlFvMCt2UCtIVGlCNnBVUldXOHdDMGloWnd5Q3d2?=
 =?utf-8?B?MXY4dWRyallMZk9qTUZab2pkOEpJVnZBVEdxaFdRNE5XL3kwVEpFWWk3dTdR?=
 =?utf-8?Q?qMQg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988034d4-38f0-471f-d367-08dc38b563aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 23:31:29.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdGIJhLS9GmrrBZN9EMtEYscLfiuPUQ7nf+jjxQh7u1i9+fuhEympCiR9eQtQvaGY+IsnDh47oZWCRMgo5c5gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6865

On Wed, Feb 28, 2024 at 08:14:16PM -0300, Fabio Estevam wrote:
> On Tue, Feb 27, 2024 at 6:47 PM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > imx6_* actually mean for all imx chips (imx6x, imx7x, imx8x and imx9x).
> 
> That's OK. In the kernel, we have lots of examples where the names of
> files and functions follow the first chip model.
> 
> If this same IP gets used by another SoC in the future that is not
> named i.MX, will this driver get renamed again?

It will depend on the how much difference. We can't predict future. We will
discuss at that time.

We use dwc IP. Only difference was external glue logic. layerscape use
difference files.

> 
> > Rename imx6_* with imx_* to avoid confuse.
> 
> I don't find it confusing.

If you follow next patches, you will be confused. Some function will use
imx7_xxx_reset(), imx8_xxx_reset. We will add more soc support.

It was not easy to distinguish imx6_xxx is for all imx6 chips or all imx
chips. If you are expert at imx chips, any name should be okay. Good naming
will help for all reviewer and contributor.

Frank

> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 754 +++++++++++++++++-----------------
> >  1 file changed, 377 insertions(+), 377 deletions(-)
> 
> I think this pure churn and we should not do the rename as it brings
> no benefits.

