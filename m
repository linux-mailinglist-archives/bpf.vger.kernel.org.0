Return-Path: <bpf+bounces-34100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C8D92A7E4
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D7CAB21482
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30C614A62B;
	Mon,  8 Jul 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ET+EdSC1"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F9E149C77;
	Mon,  8 Jul 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458513; cv=fail; b=DymDoROk079XW/npfqIkfGUtY9WjUAQ/OfybQ7YiY5+4Fk+3vH3u031ikFNWmG6Zwhz7nG/Kx6aTyfIyUYITN1eHhCDQUn3V3NDUB/+Jkk7z/UWPbkcpAi0KJQIuxwT1XS164JnwwANg2Id8jLG6bKCm5kNQq8O6MqOxaS8Sfb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458513; c=relaxed/simple;
	bh=SGtc8Ve8rC1yrCNM7OE5EflePLc4rQ0NW2nqZMfaMX0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BiKUVD6ISDSKM2q8LnwAJ584OoNRZhATpiLW+RvDVsZBE1gvXHNiu3y4goKrll+mDdVR0r7omtmIlqL76qjq+p9M9qn2Z+De1PIUTOPWJe9Nk/5LHa3+lMH2/MrWRPNei/525pqr66uT0hyoVMgPQJdC1TcPBOuz034XKePT57g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ET+EdSC1; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2cVksMZaxqj25xj8gxe7z1SdCYDFkynWbE8Wr3Up0ba9lCh/CR3gkGWjH6kLdg3pXl8JHktaEKTdQMmxVnJKJA9vjiQs6epLEkKjA4IKNNan9ktrxBy+lMsXP077a+hIfpgp7zyoVC1XsutIL4L5IU+E+t0Gn3X0HRpmNCPuWEV+pLo2B/8i/MntJ5npdhyrplVIE07zDsaFVRcrSJAc3mXPIdQyWI6r2/SE9gTz2dkYAPLsVUOoU+yAW3TIIzf799ekL13i0P9vGeJ2gFNoD3DCcIWXetfo8S+bvtavl+jTuQFYiOocK/sjV5r+CIg3VScJOJqkdY3q0RJTtFPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV08PDInB95HNGYt/mV+eg3/3PupCSil+Z3uzpzZ9oY=;
 b=Toyixv3dt8P/j5K6dVzHv2cjbAATyXOF6CkTlBhBoIB3YseC/fN3L5wqp5SUn6oi0/Co9PZe4EHH6VoxM57ypZF4QIwNXazFFVg7Eg4kjr6LO0V3cqaoIC7JM5lwizfovFQsZJoE4fMfC7coVrVJh+z9IWNg0XgsntRfLQnSlzYez1ycNh0scCM8t+HcBSyfo4eGt9uPi7EiojCq2ZoVbiB6+LJhgPbIafCnSbojzA5wtX0m/UxU2jo+3grP2/NRLI+ae6yxwL7Ag7Y6q9yrRp7RZ4LONnOqCcq1EXjOV6QF3v+OAImDECbxpP4NxGdl4OgBNGucveoYbpqC8o80AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV08PDInB95HNGYt/mV+eg3/3PupCSil+Z3uzpzZ9oY=;
 b=ET+EdSC1KwMqp6IxNRnmwiRit5f00tY9FLzd1bpJGI9PMWLaEvPiOQnfCLtHLRJaSqQu8ghL6UMf8L/x4QOPZxWfCgzNI/YNI2M2Qb7+tc2CUP2CyPraU7+V1vfVmFySl2jOTgC33/Hk+rSsgIkWT9Zv3MNTzY3ZljCn43BHk34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:08:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:08:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 08 Jul 2024 13:08:05 -0400
Subject: [PATCH v7 01/10] PCI: imx6: Fix establish link failure in EP mode
 for iMX8MM and iMX8MP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-pci2_upstream-v7-1-ac00b8174f89@nxp.com>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
In-Reply-To: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720458497; l=1527;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ANVarESKV+O6tlN/FaWd8tQfK1xN7/HQ77vO4gvZSgQ=;
 b=1IZKWaqEHxFdmX7g8K9hpBEVn4jluQEzZh/gw7sNY9OY+4CWjTi0yZKS+m18CnPYkR/XEjasO
 YSwPxAmbeqlBAMUpl+xf4HuEXPNxZt5QRGY6Xt8XEzZrpbUn6ZqgmBK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 998b2198-f93d-4e16-6556-08dc9f7096b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TElhZ1lDNGg2V0ZDaXhsakJVMXROWlhNMURDMVhGSVpCaVMrQnh2d1hQeThW?=
 =?utf-8?B?ZmJmTGxPcmIzbHZoZXdqOEUxQzJheW51QjA5MXQ1K1NlTGR2bkk2Y3QvV3do?=
 =?utf-8?B?UjFpUXNjOFdtUVFjK0RlN2NGVFI3Y2lEUTVVbnlKSnQ0b0dXL2RmYkIzNzg1?=
 =?utf-8?B?ODNFOGtmVHV0MG9qMWp3Zkl6eHluRXgyU3lINXNXd2RKcUxBT0E2QXBtWUhY?=
 =?utf-8?B?U1BCWHY3LzJnSVh6VVVuNlFXZkhPTXg4ak83azY4VURNbHEzTm1teS94NDdu?=
 =?utf-8?B?cHVlR1ZVTXI5RndHMENhQUROc08yNnFPZG5tMllYSDdPYWg2SSs1VXdPdSs2?=
 =?utf-8?B?TGFRaXYvVUdpSHZYdmFsOXVoS1gxZ2ZYUVlpenVOQ2lITXYwa0xCZ1Z3OEZj?=
 =?utf-8?B?eVdMQTNsQkNGS3BXVjhUZVJyZUdTL3lsTEo4ejBSSWhFaFZFNnN5N2hXaCtG?=
 =?utf-8?B?SVZRWFRrY1lDRTZSblRyTGpzR1paRUZHTjJtYURXTGd2cVpMdkNLMmJJd21P?=
 =?utf-8?B?bVJaWWJrTTJZbk5xTG83YS9rQlZ6eW9SWGdob1JKSlhuZDN6TUUxaDNUWDl6?=
 =?utf-8?B?Yzgwa3BKa21qK1hpQnRDaFFPcFZzYUxERS8vZ3RrOW1RaXJacDhTZS9vWTNy?=
 =?utf-8?B?ZmhDQi9oV2M2Z2hrYVNWcXJrUkNhRTAweWN0bUgyR2IzeEplVEs1bTRkNHhz?=
 =?utf-8?B?eThnVnl2alc1K0JuN1dYSXlYenNPM25yam1JTm1xMVBLQ1lKRlNKRTF1Q3Jx?=
 =?utf-8?B?Z2RibUVxUTAvYXNmR1BtTFd2VGM4UUk5dWN1SThTTG1Jb1pOMEg4dmIrTkQr?=
 =?utf-8?B?UUFZbnl2YjdrcERyWFN3R1c5Tk1Zd3I3NG13OVFZWmxxTnR6MzIrcDZJK3lk?=
 =?utf-8?B?LzhTNWJJbThGWm5aTVlXVG8rY01BY1YvUUhXNnRRTTRxb05xeGttOTVGL3px?=
 =?utf-8?B?SmNMRmlqZVlHMWsrZ0VCazlqQVpVQkdwcHUvOWFTUDRnV2I3cFpBdVl1Z1ls?=
 =?utf-8?B?dlhxMXFZWi9MU25Fdzh3c3RueGJhWU1oY2J5VUV5KzVQb1BlejNaQ3N4b0dp?=
 =?utf-8?B?T3dxTEFkclAxVnQvMkVHbWNIMURITllvYlArZU5CcmZNdWtlbExVekh5L1ZV?=
 =?utf-8?B?RWRyY2twbks4N1lHSjZxS0ZDM0hJdDA1akxleEJpY3Y2ckFVK1FkWDg3cDN1?=
 =?utf-8?B?L0w2bHUzVjNQcEtSUVljR2NiODNkUEZrV2hvRndXL0VTSEVUT0FkZjhFa01h?=
 =?utf-8?B?Zjg2M3RtRHF1YlFualZHU2tGdDMxbUVnQTZFZGhhMzhMeGNSTE4vS1JEaEp4?=
 =?utf-8?B?aU9TVHMyWmhMOHY2ZUFyS08xb3hZY3RhdTVQOUYzSmZrZHBXWm13VXE1NGVS?=
 =?utf-8?B?REFUc1pDd2F5blpXeHM5VzhUQ0d4UkJQbEZ1SHRnNys2RWY2QnlZRVJQN1pw?=
 =?utf-8?B?SVBjbWdoZmtNL0hXa1hLWUlyaDQwSTZheXNhZnJ3ZUV3ZDJnRVlueVZBQlYz?=
 =?utf-8?B?alVOVTBrMHRnTUpiOWNTSWp6Slc3ZTBRZHNDbkdIZEx0UmFyRFF6WVNXYlJ1?=
 =?utf-8?B?eWpUQ1ZDdHNQWTZTZGZMNkRpVk9ud3ROYXpJbXpUTDFnVjBhSW1weExMNks5?=
 =?utf-8?B?bWlkL0V5bkhMdGZqOEdoaWtzMStJSDhJNFpHMVd1RnFTYVhid1dOY1gvRC9p?=
 =?utf-8?B?Mm1Lckl0UE9wS21JY3paSnc5bTYrRTRnZ25aME9rdzlmVUVjOENENkRtM2Za?=
 =?utf-8?B?Nk9ZRm5hYnh4OVhBWm42MUFTWXB5dnlBbUt2SitHZnZVOWZFTDZxbm0rNng4?=
 =?utf-8?B?dmVkcXltRyt4MDZpcHZLOXB1MVFUUGE5ZjJZd3pVTEVHY2RnLzFMU1c5U0hT?=
 =?utf-8?B?Y1d0S2FQS2xuSG80OXlvOWlxbEZhZ29wUktiZnVzUTAxTWk1OWw5WkhDWDJK?=
 =?utf-8?Q?gRKSgIqMwRk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGtteGVpK1VaU1JyN3VsL2JyaEJDTGN0c2VLQTJDVDZvU1AyRTQ5VHA1TFVZ?=
 =?utf-8?B?NXU0WitFOXBkNWQ2Y3JwblVsNkN3YWRtY0NHa0pZZlNUcUF4L3VBZXBrMUVy?=
 =?utf-8?B?RW8zYTRvQ2NIYXVScFNqQTJTTHY4TzE2NWZxVWRPazdKYnhnMGVNSlpWN2Ju?=
 =?utf-8?B?NTR2Zm5zMlhxcjZodFprQUphdllRbGVRWldMUFlHS1lwZUFIMVVEVFF3KzhN?=
 =?utf-8?B?ejE5ZGRtTmZaUnlFcjlIeXp5cWpmVW1GWkdmK3NQSFgxRlhDOUFTSXpxTTEx?=
 =?utf-8?B?Z2JlNlZ2N1gwNWFXOWdqS1BiWUNMb0w1T0thMWJweU5Hcm0xVlRpTFRsZEVF?=
 =?utf-8?B?UU01OGtvTTdTMnJrRVJSSi9ibmJtWldhSGwweXJmQkR5ZUtaYk9iZnNlU1JV?=
 =?utf-8?B?OVVTdmxZL05ERTdocld4U002N0xlaHlKcjZxRThIaFpwWnhhenJ0WTkyMDRu?=
 =?utf-8?B?OXdmRHBoWWt2cVRVT2wzUEMrVFlQUERhdVRaelNFam11NEtNaDR2aXBuUW4w?=
 =?utf-8?B?b2lybHVmWEpUMTA5STJkeWxzME9nQTJ6eXBKNUx1eXZ0blZqaHZ0NGNuOXF2?=
 =?utf-8?B?Y0Z2SFh6QkJ1MGlEYVpFcmVNUTRvUURjWHdPZ0JEdXQ4Ykw0K0krUjdQL0ZQ?=
 =?utf-8?B?ejdISHFSVlpNNFZCS25VU25INHkxaUJBQk1OY01QTHN6QzAzWTFLQ3VhQUpz?=
 =?utf-8?B?VGpWRDN4TVlSTFBPQ0NobStpMi9uMTJHMndzWmxXMkFTRHU1TVBjeWNIeVBr?=
 =?utf-8?B?bXJsUVZnK1ZPZTU0ajI5ZFFsYXJsS1pMVXgwZ05DSm9uOGo0VnBvK3RsLzl2?=
 =?utf-8?B?WVQrV1E2WFRnTWVqaEt1ektmb3dQclB1RVVDQmNlemgrRFpscWxtZ3pnekwv?=
 =?utf-8?B?ODlKdG5Ja3VSQXpEQitRN3VkU3QyODlOcy9KTG4zcTFZT0pPOVNzZEIvWVAr?=
 =?utf-8?B?ZjJNeXpsZlQraVoxUmU0bjJtQzdpa09MTlNQNEhzSVUyTkd6NFA5ZlNUN0NU?=
 =?utf-8?B?a2U3eHJaSU1zT1E0V1FFc0psUGNwWXJPWEdCZFB1MmowVS8zYVNZRW5mNDI4?=
 =?utf-8?B?M1ZqeC8wWjR6M0I3VUdmVlBYWmc2WnZ3cTcwSUlPOWdLY1BOYWZnMzZUTFhU?=
 =?utf-8?B?VHVoRW53OS9OQWdncmlCRGZ6Sk1XSUg2SEJOeHVBcDRpS0ZTZGFBMEFJOWw3?=
 =?utf-8?B?TjdLNGsvTm5CYUhTdXNJUWhLMGt1aVQwTTU0eHFQazIwaE9Lc1lBNTNNdUhF?=
 =?utf-8?B?OGozaGlnVHVWeCt4VDBYay9GVzdpYytjOXpSS3A5K1p3SjVsNmExQ0tLVmZV?=
 =?utf-8?B?b2sxbmp5WkZySmJFWHlaN3V4QTFNQW1od0xRcDZoWC80c0NNQzR4VlZyU1J3?=
 =?utf-8?B?bVdtOHpobmJ5Y1ZDVC8yM3Z6MEpibjI1UzUzU1JadEZpYjNtWGQxWlg3S2Ur?=
 =?utf-8?B?elV0a0Y0L0xpWFRjUzA4L1FheHIvMTVVaTd2NUUwc1B0ZGZlTTVNb1BKVzZV?=
 =?utf-8?B?MEJmZXJreDNMNjhET1duVkxlb1Rxd2lKc3E0M2NZRnlHZWpTL2ZUbjJUcjQz?=
 =?utf-8?B?K2VHbGFaTGxERTI5dVRqd1B1b2sxbGRrYTcxbGhRb0treEpFZko2Y1crZmlv?=
 =?utf-8?B?ZDhzWkxFaStmK0VxejJUVVM1d2NyNXhYc0pmc0ZCcnI3eU1VbHRUTDZYREZp?=
 =?utf-8?B?R3E3d3VpeDd6ZURRcEZ6ZUJUbEpHV0JZdjR5RUZkaytUVTFvMzdtQUloTHF2?=
 =?utf-8?B?aFdTUFBmSjFYUXduNUxqcHdNeDZXTnJkdlo0MVJXZStaQng2cnA4NElpajdQ?=
 =?utf-8?B?T2FIWFBoZDhTNDJNZ3cwR3dKbzVoVlNpMXhZaG9uT3pqeDlONEk2Ym1rWWU5?=
 =?utf-8?B?VHFWTDFnNUhWK2h6WmRoMlNCbXBCWkpTNUE4OUQvZWM2WnUvd2JZZWtTbGFa?=
 =?utf-8?B?Q1RHYzBwUTkrVnpTNGZaRC83QVVSZ2k2MURTTU9kaWR2T3cyUE9Melplc2Q5?=
 =?utf-8?B?SXZIOVZNMlFhUFFxaWgwZ2dTV0d2U0JBTDdHeWZYbFZJZHJiWUtCajFqUUdx?=
 =?utf-8?B?Sy9pUjBERXpXN0F2YXcveFdOTlU3WVE5NXZJbGphWlNtTUMzbnZZUUF3UUdT?=
 =?utf-8?Q?2gDI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998b2198-f93d-4e16-6556-08dc9f7096b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:08:29.4625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XkY5T7VVNr4rsLXG6gtfc514zFaQ8m0zgC2FfkvSRG8aKk9e3Jn66LXA+Od4/L4cK3hY1ycnaUjACQ/eiB6TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867

From: Richard Zhu <hongxing.zhu@nxp.com>

Add IMX6_PCIE_FLAG_HAS_APP_RESET flag to IMX8MM_EP and IMX8MP_EP drvdata.
This flag was overlooked during code restructuring. It is crucial to
release the app-reset from the System Reset Controller before initiating
LTSSM to rectify the issue

Fixes: 0c9651c21f2a ("PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 917c69edee1d5..9a71b8aa09b3c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1578,7 +1578,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1589,7 +1590,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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


