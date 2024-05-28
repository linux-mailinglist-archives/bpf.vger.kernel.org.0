Return-Path: <bpf+bounces-30770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3128D24DE
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A9B298EE
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4117A937;
	Tue, 28 May 2024 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NoBlis2v"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4630C17836C;
	Tue, 28 May 2024 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925177; cv=fail; b=X7eRssRT7Bv29bIyCCiKsyCS9XbCWXm60dqXcWGhFi+39Bbbh7LkjZpT/UACfVdHFw4gZdXpI3lW1bkOapy5qX9510H2iNR8mFZKQkhY6xN4pPLw/3YPgWmWM3tChp/s+pOEIXkW8+18iglho3nH76AIhYJ1TeRxEf/TmtH7HJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925177; c=relaxed/simple;
	bh=mL7P+VmAKqXwuvaP9LpUU4giX8nowQXttSuo1u7H44U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bqYNhxyKgVasXjxJ/n0g0ZcQLuvEXxf1qLHMORDvwHiUsh52Ob5ICuUuYz7seTE9EzRSqHB2Dq2JJKsXcakDT97FddWliZS18r/t0YXmvDFkbs6qtNm1iy6NbsKuecZqAUmyFbnuLxfJ7DSjHev7otjxMC1jJ+I+E9or7StjFrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NoBlis2v; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSSGWs1f0RRYnnRqTYa5vVRhFao38iRzmBE8pwuqSKct5Jss6zhfqCZbUti01+0lUuHCWFuPRLKRQG+a9FF2yBv8Qh0V1XK7gokj1mldlEeIOPu7ARowPdcbjGPi3n7xZrNt/Jz8mau1dRdp9P3BTDv40Bzm1yVsN6jgg/ORzt5kDSxYaw7VPMDJlLY+nqvCiesHgxGx4RLtAejeca3Y+FfJ1ho53WdPVssWRYXIgDYuYX5j3hQ2stPSxv5/sGKLZyG+63ZJTAEyTdzBBeRnS2mInQ1BX7SfkHUYS7Zd87k2Ky/nHH3Yp5WxFcUHQIj3zNS+jLKr4zcAGXeoRIYFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYUB3tl5kIi+kVHs3bp7a/znXcH2HlQ3RI1CGeMqQEQ=;
 b=nbFaregc6P7DFqoOhg/Z2VV7sS7iyS/j9QeJUtsiIxtJEJCY0iKSOgZQcldI/hDLTr+MY9qCsnGsLiJ1Vl73zwboCLxqLZt0HqZE8RP485xEQ1yGrA00kE1xSLSkylZW+CbibOkRr2D+HXxOmRv+ewcFdPQo19awqVf3zna8kkLy+LoRcbSlkTgpbYiBZn2Ld3I6Up1zG4zFR3/RChYUqQlny7zlc9ScrF1jyBZVIcTbvAP0O3Yfdi+PHV+BeKB5MQId6kwg/hlO413zTMkSdhGSa9wys3j7rY+N04j1X5GarosYT0bfSIxH5YxLNAVjfdJ9fxxp2DXSbuK9MIHG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYUB3tl5kIi+kVHs3bp7a/znXcH2HlQ3RI1CGeMqQEQ=;
 b=NoBlis2vak8tjvtVhzoIFtjn5MzgO86u9J0VDCBUy3bX773BanhT+WVtgjGYRn6yxdRtTjfkIdeexF3IiMFxPn8xWd/22/M1CAOQ7Bz8ElErUwjXUxb39Nf38R4aBCSeAq8i6Xd5o+go9q/ZpzaCNaYFAoz72poFqGJVr9MgyLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8663.eurprd04.prod.outlook.com (2603:10a6:10:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:39:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:39:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 May 2024 15:39:14 -0400
Subject: [PATCH v5 01/12] PCI: imx6: Fix establish link failure in EP mode
 for iMX8MM and iMX8MP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pci2_upstream-v5-1-750aa7edb8e2@nxp.com>
References: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
In-Reply-To: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=1456;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Pysl1T42hNHtG1QAGHioLlAZS/qhp6TnqoOHQL4Is3w=;
 b=IE8CFDTcPynPQ+U/TppmViALoub2is6yJiL2pUhtHqyP34AzebCs6xF5db7CQe1p4yP9zvDAm
 xs0yvwairJ2Cp2f4FJqlePg2NNU84X6PT6iovpkX3sizWi6HrUcw/e7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9040c3-b53e-4b85-ae0d-08dc7f4de60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|366007|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2syc254UExZYm9wbDVQdk9pY2xxNUFqaDVldzRaQUlHL2FiWWNKeWs2WGNO?=
 =?utf-8?B?VmV0ODJLTmxxNjBlaktrM2dYZzUwbkdkQzlRQ2hzbllhS2lueHJ4eVJNTnFV?=
 =?utf-8?B?WHovMldXay84eFMwOHY5RWNDRTlUSUZ3U3B2K25YS21XaVdWMmFhNlRpNmZL?=
 =?utf-8?B?aEZ2dktuWFkvaFBUQnN3dWUxTFFKMzZOblduUmxMWVJHYmE3dGJkUytPdS81?=
 =?utf-8?B?T3RtVnFqRERLMjFxekZIZmpMZXdlYW1xNEtLUzZhRmtTOS9FYkJQVTl4WVNZ?=
 =?utf-8?B?bG9FeFdHNXRNb1BGblJpaWFtdk14Q0RzR1ZLQitURW5rTi9kaGJ2eGxwV3ZF?=
 =?utf-8?B?M2V1Y2o3aDcvWlBXNUhrVnJQVTVWSENyWWx2dzdwcURZSlpNTXllM1RSRkpE?=
 =?utf-8?B?VS9kUDBsYm5VSlc5bDh3NzBVWUc4MEVSWmRlTTRINGRDdjUydlU3WkZOeVE3?=
 =?utf-8?B?d003VmI3dE5lVWx5N1lreVlFMTRrZWF0VDhWZ1RLWERFc2FXSU1ISzZNU0Qy?=
 =?utf-8?B?RXRyaGQ0WTcrSzVZc2cyR3h0WGVteGYra01oS3hYQjFoMUhuTVF4SEFJVVph?=
 =?utf-8?B?UHVxdE1lMFNtRXR0bjFONkFYemdVaFl4V3lFWk1JRHBIb2J5L3E4TUNLV0xI?=
 =?utf-8?B?SllYa1NVamNMTzAyYmVaR3VUZmw3Ynd4N2hGM09EWlcxTVYyZkNCMXZWMmJX?=
 =?utf-8?B?MFZhRW1DOURjWVBpSjJwYTYzS2tsS256ZzJ2QTIrVkhpdjJwRWl6NlF5c0NM?=
 =?utf-8?B?RVUrazBiRytaL1d6UkpSSjVkNUJyeklMWjE5UFRDVXVqTURISGVuenpSUlIx?=
 =?utf-8?B?bGhUekd1N1FudTJlV0M0NjJyOXl4cUc1UHVOMzE2VHZwWk9EMTl2eHp2Qk5Z?=
 =?utf-8?B?dVdFOVlpbUl4M21vOHVhdWIxdjF1TjlVNjA0N1RkUUgvNHpFR2kzYWE2c3hm?=
 =?utf-8?B?T0RXSlZPYXJOOFRZTXpGbWF4aTQ2b1MzRktTYlR2Y3htK2NKR1R3S2pDUTlL?=
 =?utf-8?B?b1RxbXVJUzlDMTRPa3E5dW9tSU5uZ24rc3hpZTlVRTlmV2xjOGRpSWo4ak92?=
 =?utf-8?B?WU1JdE1wVUphZGFMeENlTndSOUtyM2dhZVQyRGlyMlBrelBLZHFvSTdrZ3NT?=
 =?utf-8?B?dlJMQXNqOU5yV0ZIOEl5ZjdzU3JUTkxtMTI0L1plRDdIVm9JUEM0MVlUd3BY?=
 =?utf-8?B?aHZWUk5SZnN4dUVMQWRsOFphODR2b01qbENOOHFnYUVwcjkxelJJbWZaMTBZ?=
 =?utf-8?B?K09Rc1Q5Wjh1VXdXZ2hsRkx5cGhhMWlWWVBTMHE5dEJEZ1VCT1ROeHJUcmFw?=
 =?utf-8?B?ZEwreVJRUG1GSVB0OTJ1Snk3bTdoUmJCSE83SkJESjRhNEVwNUxDdldOOXow?=
 =?utf-8?B?aEhiT3lIZVRKYXo3SHA0ZXUvU0VicUViOXBpMWJzSXkxcG8zRmVkWnpKQ0NM?=
 =?utf-8?B?c3BOLzQ5QXMrdElJTHRIQ0c1L0gxV1k0RHgxRVRCdWJWNk1DS0Q1RjIxOVU5?=
 =?utf-8?B?djRjSXBZTWtIVTVlK0VzSzhWQVFHbmU3WXZKTWk4UVhrYWJ1RldSbXlhK2ZO?=
 =?utf-8?B?RHJ2OXhoOTYxQ0FWUGtzek10OFVGazF5Wnc2SHFOTC9UbVgvZ2ZpT0M4YkJ2?=
 =?utf-8?B?QTZ5ZzUwZmNwSFJLQzkxdCtWaVZoUFB0VnlYaXJYaklFaWlzbVJnWHYrNmNZ?=
 =?utf-8?B?eFIwQlBCRkttSHlMNzFSSDhDaTdueHh5VUVtOExXWUx6YU5YVmcrSzN3RklF?=
 =?utf-8?B?bzY5VUtHSEVOZ04zQWFOUkViaERDTWNSZ0hJZ2tlNFFvdjlMKzFuZ1A2djlN?=
 =?utf-8?Q?rgEXWxkxXG11aJYIfZHh5AxBNQMOhRHZav0S8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzljZm5RSWE2WjViaHczYWR4NTlyVVNpbG9odUNCSVp6bzh0eTBJWDl0RlNm?=
 =?utf-8?B?RFc4YjdxWGRvQmd5YllJNkZ4aFQxQndEYnJDbUoreCt4bUo3VTNra3gzR0M2?=
 =?utf-8?B?VkZIdXJSWjdJU21Pay9SR2NHZXFUTWE5ZmZoRWs2VWpES0RqU2ZXbW9jbzdU?=
 =?utf-8?B?bXI5OHRqRGtzUmZ4dFNIOGxqMDdLODRDTnMyUDFzckJUcy9vcHlWMjVtMllR?=
 =?utf-8?B?MkZqdVJ1RnMxaDJUUE4yNmFwZmJYVlA3VlF2WTRqZkp6TG5XeE9Pb2xpMU9P?=
 =?utf-8?B?UHB6M0Jpazh5alhZK1p1NjdvRU1Fd2h6b3I3K1ZZeFpJM0xoQlR1QzZYZStD?=
 =?utf-8?B?UC96TG5wWm5TSnpDNkh5RjdHaHExRWhzdjV5WDY0TXViZEt0dDNPbmE1N2Fn?=
 =?utf-8?B?T3BLbytRVmtnZ1hDK0VxMUtNcnZnRUpaT2JETUl0K2FaYnlDRko4U0FROXg1?=
 =?utf-8?B?L0JoZGVsOVY5cU9nWjJ4cnVYc29ZL2svbWRLUVBJcGJvTDNqbFVqVlE1RHlH?=
 =?utf-8?B?d2FaSmNGcldHOEdBaEVYUXkxZy82dU44ekhFVVVrWGIxS0hHVUZ4RU5vWFE5?=
 =?utf-8?B?VlNZYzZuazlleGNaQVpNbUZPdHBRZXg2QnJ4UXBWaG1SWGtsOThVL1RZbzVK?=
 =?utf-8?B?Lyt4VW9JbWxGRnprbU1RbFhQNlF0b0VXdmJVSmY2cXNCTmVsZHJ3c0Z1cFph?=
 =?utf-8?B?eE11S24rTlBjNnh4OHJpUXZLNFB5bzhjOTNQdUV1MkYvV3dSVFh6NFFXbkEz?=
 =?utf-8?B?OHVxN29FYklZcUlYRjFFckRna29JeVd2b0phL0libnJZbWYxVXpna0krVjdm?=
 =?utf-8?B?Ui93NUxqS3NXTEd1SjUxamc4eDlvdTFSYU5nYUVJVjNtdldnMjJMNFc4SE1z?=
 =?utf-8?B?c1F1cHhjNUY0QlJrT2xlQVk3YUU3UXFqOVNocGlndjA1anB5UmkrTmVUaUZS?=
 =?utf-8?B?QXRUbWEzQTMzU29TOFdIYVNDaVJoUVdUTlhDNlNYVENnYldiUW9FMkFESGl3?=
 =?utf-8?B?RXk2YnFvbWdmTE0vcWdaY1VRSnRwZndhVTkzYVVZenYyd2FURGQ4VHBUbUZz?=
 =?utf-8?B?eHFUTUYzVllpNkQzdDVPYkk5V0hHcnRXOHJ3YVdLWXhVYlhKcVREcFRoVlZ6?=
 =?utf-8?B?SmNvVFJWNkVnTm5EOTdiUE9wcjVWZy9TUXdMTkNnK1hGVitia05QWlNsQ2tR?=
 =?utf-8?B?WHdxNXdyb1JocGo5bDJHbTlxeW95c2x1bHMyVHJ6eTFFOU51Qm5VWHNPWnU2?=
 =?utf-8?B?Q0J6Q0QvZDhVS0V5ZEN0dlJJOURFQ0hRV2V6UGRySjJkeXowSlpLSzhDWFRX?=
 =?utf-8?B?eGJBODZvZ3cvSFpFdHBxRkpnSThHQ0NkVFVjcXZFUkc2U0EvZDdxY3p4cEkz?=
 =?utf-8?B?by9sR0FVNGVOZjVDT25WaVNtWWJzTzdvNThUaTludkl4SFNQb0lXOU0yQ2g1?=
 =?utf-8?B?V3lkT2Q2K2tSbUJvcU5IQ0pvU3MwNXZkY082VEZEa3JpZytKenZzWnpPVUpZ?=
 =?utf-8?B?eEFEWEFxaURmSFJMa0VZeEpVSkRBeXJsamQrYTZVVEZ2MFBiMitDemIvQzMz?=
 =?utf-8?B?bmpVVG9YS21sa08vTm1GYkduYi9EQ1dEL0xYeThlajFBRHNjWitSM3NLMHBa?=
 =?utf-8?B?RkpDMDlFWDB2MktHSkZqNFVvWGY3c3UvWXM0ekVNR0REeWdTT1RUSjRWOTcz?=
 =?utf-8?B?d1JxYTJOTkY5TkZxcmp5WWdXUG0zZkFRVDVyKzZsRHM2UUx5WGZVanFLenZD?=
 =?utf-8?B?ZTZ0V2VWdzY0TEVPRTB6a2FjS0dYQkl2Z01vZlB3Rm5VYjdKUzdVR3NNV1ZH?=
 =?utf-8?B?WGVUc2E4K3NrN0R5ZDNEaXBmR1BjOGRvcTNqd3EwQXREMkl1dDVucHdORzdI?=
 =?utf-8?B?OEhoQllVaERyaTNOZjVieE00dFFwUUJCZ1JUSFJLRGFnei9CS2JpK0hqUWxW?=
 =?utf-8?B?cTJEbXhsMVM0eTRGenBTU3VLMHFBUWhLRURJWmxRSUhIL1NVb2xWNm5Kd1ZL?=
 =?utf-8?B?c0IzZnprZ0o4M0NFN2xxQVRCNllTbTVQTUl1VVc0VmQ2Y0tPZ0x5by8yN1A1?=
 =?utf-8?B?TEIzZzdUSk1WQ1A4VDdBcVF5ays1WVBYSDZTaXlsMnRxdlpGUWpteFJKQlk1?=
 =?utf-8?Q?Cmm4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9040c3-b53e-4b85-ae0d-08dc7f4de60e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:39:32.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKdTJRAubF2HrgxYSV0veSvntvF25+687GgdfyUVXVNo3viesJXSa2ErOCaVcmM88vwXc1Zv8W/T6QY9ezx+iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8663

From: Richard Zhu <hongxing.zhu@nxp.com>

Add IMX6_PCIE_FLAG_HAS_APP_RESET flag to IMX8MM_EP and IMX8MP_EP drvdata.
This flag was overlooked during code restructuring. It is crucial to
release the app-reset from the System Reset Controller before initiating
LTSSM to rectify the issue

Fixes: 0c9651c21f2a ("PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 62a4994c55019..e9a16083d79d8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1562,7 +1562,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1573,7 +1574,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,

-- 
2.34.1


