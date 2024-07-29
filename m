Return-Path: <bpf+bounces-35938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42093FF49
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5938E1F22D18
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EF71922D4;
	Mon, 29 Jul 2024 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ai5Wt+cs"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B854E1891A5;
	Mon, 29 Jul 2024 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284391; cv=fail; b=dD9xhvzGb8zt68mdLoQ/3X2wWqF/GCjq2g7sJTJVydiWUDkwcvbRhWbzjHAMYL4cC26km/pihnbOsQJWp/+AONIeow5bdlX+VyaWOYiI8pKUswTcbQLKQaymjTf63k7owQEQn9aaklFaDSz8iEAEkBjay/LFJV8NS65T1XZcTbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284391; c=relaxed/simple;
	bh=KdZlyCITxZcXwj6rdScVn7jTqQq3WgNb0RtEfw8b6tA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tK0eF2FKeWICM5vRbcl++z3eKBxl7C8Y02KmxHCUFahl4DKymEwpvT0mJoLs3ZiNCJ/PW3V0M8PUMbCSwbcv3cWm8GDkiW4INTW4gHxpD2kh8C8EvtogPoLVXVjBzamnzU6l+jNcJ4QqlpCggz6df5trL/UrJN29fRBrIJA1B5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ai5Wt+cs; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEaDqVT4iLB/A0Mka09DZnalNfOFpLkgmauLGyhWvZMs9IQSqwBawtPqDJV0LN+1ICRv9gI1SFfuKNibLq0ij5UQoxlQU9qinPUBswLTQME2c+abzNcvNdTmCZQ4O/A43vg3lJBy733x2WbRDEgQ4kn06RkqdZiofcrBjc8cBxg5Av6/xT2GpVSYSeY91rxjxpedwnyftUUshGMLrwDatUJxKDuiLf0YL6CPHrHudTSbyHZ36x2k36CYPi+/DxGjspiFcMXji7GOEa2vjS2JtdZTDIT+PG4n0ciHPaK3zcYRKgij4bHy360nKpd9Zgfi30Rso3LWu6GOO06XJBC/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2iprTHuLx7USQWsCBZ4VtJzBtVOi1XxZNwYrdt/NJA=;
 b=IIjWtwzLW8BnEoambqFpY/GMw4AwFv7twHxLFp2O7vC0hiWZTVbad4Ip4wJx/Jy5WirGJ1IK5k8Th7zinu1Xky/h3iAB24pffb3LX7c9QlWMl9fUACIuVWX5aSyD0Kqfp+yK/rBTGiLRAW32koMMAIUFGG7q6ubXpAo2pJcWWnofWvbjfNLaNmgz8KyRJBoMLzehH7GDEEavxHosGOkmqH6oktNTYVcLuu4BpwAznRt87zIQ6x+v2EC7213O5b9Z2ZOIgukxdNMP2aeP5/UpOqbdbHx5Pwk9EA39wOHTTnBsMEQ+zD6T4rk8Vhh2Vwtstvif9ptXoJjNPtql1VWGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2iprTHuLx7USQWsCBZ4VtJzBtVOi1XxZNwYrdt/NJA=;
 b=ai5Wt+csG1vGfdP5IluEPeqZA0nYgKnLyS7iUtvoWxUHcu5AM940eLsMsuaYsQBX1o917g4bjP6SH3uPKYX20htxi6Ul6R87fGdOnFluZuREZIyIhGPoBb55GJbgCWe7Jl93pXqzPX3nG84PeXlFl6Mz8d9H2ghpioIFVgd9AuTuoJTSn7wuoxh9aO7oYqsSRoA4+uMrMh7+2mHR4iu4XKNUKZzSU8ad7MifV3iusUI5uIK78xs2obc+OoXSQKt9M9LpuZu52calV1E59eeI8x4hlikGhs9TAApW0NqnxPnSCtcRrI84tjsVFOvC1cXBu89SSSMihbnpj9DtOyDGNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 20:19:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:19:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 16:18:18 -0400
Subject: [PATCH v8 11/11] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-pci2_upstream-v8-11-b68ee5ef2b4d@nxp.com>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
In-Reply-To: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=3899;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=FeU0M7scoVtlq9n7CVtHi+M9qoXqi9J/fKpHzWWulhc=;
 b=ly3UYvzhU1A3G+y1qaOQQb5qwRHB3R/VA6CXczl0nDpWHA7oEfKYTPsH5ivFHu2OdMjqnDXR/
 Yosu0/a0icZDq1BnkWMMwJQDvdkObthOSZvfuGzZiXgxxBpOTk7hxoJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 0997430e-39f8-41f3-f562-08dcb00bc9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjJLS2NlOVRWeWx1VmU0Vm1LU1ZlMTBOQnNhYjdJZlE2TDN6VjdIT0kvUFVi?=
 =?utf-8?B?ZW9kT01WZlB0cDBkakNSYzdKVXVzbDFkbnhXUFg1ZlVKZ0VINGZJWU82Rk1E?=
 =?utf-8?B?d1hLZDNWc0lrWEhaTlV3L0FYaVh5SkxvUzQ3K0M5ZTRHa2JzVGQzK2pBNm1B?=
 =?utf-8?B?TDN6NC92ZFY0WGF6WmJSeU9Rd3FPajJQczdrS3lQNFFGYkNiREVyREpKcjVo?=
 =?utf-8?B?ZkVjd3B5d3N5NnFPU2kxZFdHNVRFK2paeDlvaThxMlhuWW5teVRQdVphT1dp?=
 =?utf-8?B?dFMvNUpZQWtldGZJT2FqSCt5amFnZE9leXBja3RRUGF6Z2d0M0JGZEtmK2Za?=
 =?utf-8?B?ZzVDcHY4UU9qMnFUWVRObmFJYVhkdTc3VDR2K09paGI1OHQ4em5hdnBhNEdR?=
 =?utf-8?B?ZEVDa09abU1WRmQyU3R3SUIzQ0V5cnpQNSs3T24ybjJIVG9RZkJPdXNIQ2Zz?=
 =?utf-8?B?Z1laMFV2WEpaRGRnVllmZEpDRlpiV3FzOUJPOVpKUDNvMHZsMm5MVkdEaDc0?=
 =?utf-8?B?QTBpby9YWGd1RHdEWVYzTUJ6M2hsdnpEenhhY2gxZlRhRFZmM2ttU01pNTdD?=
 =?utf-8?B?YVRTT1dsUDdlRU4vSzd4c2t0d3YrWFRSaGhjSFhKRzJQc3VTbC9DSHEzSWRX?=
 =?utf-8?B?dWRuVnI1bmtJTUt6azlJQjFTZ1BodXpzMUxmVzJsemhYMGovSEJxeC9hWDF3?=
 =?utf-8?B?aEI1RGNSZ0FLclU3WDJKWDB0WDQzR2ZwR2hzQ0tZeFBEUHdRSEZPd25ka09B?=
 =?utf-8?B?OG9JUnhaV05makZranU3cVBXUnh5TVBTSVRsQkNhVnVoa2dhYkMrb1lUdklo?=
 =?utf-8?B?ZnhKV1RqSjRYMCtJTGhjYS9GcHlTMytRdytCaEdrM0NFcjB2Z3oxbGlCOVlm?=
 =?utf-8?B?cGlUcWpFRFdEdkEzOFRRYlR3WTMvMmlKaCtCQTBaQlJQQVNZQi80UTVwYXVC?=
 =?utf-8?B?ODQ4djJkeEl1Q3RnVVJla3BUcUVpV09zSElSQzE5STB4TE92NEJ5N1F0SEVC?=
 =?utf-8?B?ODhJbkhzMXV1NDV5aTVtZTNPUUo0TFc1aTRZZk0xaXFENjFtRVBLQVoxMXVy?=
 =?utf-8?B?YklNRlVpV1FqMVhoMWxkOFJNQ3ppaldVY0RabmVKakc3NGVBR25aOVJMTUdn?=
 =?utf-8?B?VXlhSU1pMXVKNW9QY1k5NHgxL0paOVNvZmEyemtaMmU1ZUVRMkRGV1hXbm1w?=
 =?utf-8?B?dzY1aE82eVplM3pOMnU3aFZ5YVU2ZEZZQXlyYzBhU1FTWTFUM3FVdkdjR3o5?=
 =?utf-8?B?eHZrWVNBQ1BGak9rTXFZd3lpcVlNS1o4MjhMNFlxM3kwdWVOT0xIYTFGczEr?=
 =?utf-8?B?QmFrcHlMZ01GRnR3MXRvaGFlVzd5cGdNcXozbmdsUWYzVjdNeHMvT3dETGYw?=
 =?utf-8?B?Z1AxeVdsNm5CUEF1eEQwdEthdE9vc3kvTHZ1MUo4emFQeTR5L2l5ZW0xbW93?=
 =?utf-8?B?SHY1NExvN1AvQWhlL0pobHlpLzViU1FHeTVUcUdySHVYM0VpMGgzM2J5VEFm?=
 =?utf-8?B?VXpoYnVzSkpPUm5nV1hVRXV4WHB2OUIzZFJLWENDNFJuNFFRV1RMQzVBTTk1?=
 =?utf-8?B?eHZIR2l2MzBLb3lZUnB1emFiQ2dIWmlsWVI1R29xalN4U1NpYU92VlBnSHFH?=
 =?utf-8?B?ays0N2hScXVvdU1jMEtGeDVkMVlwRXE4TXA0eGQ4QVF1dTlwOFVIMDhrVVF6?=
 =?utf-8?B?aEp2bGlhV3BrTzFhcTNZMjNlZEpubkhFZnhkRmFaNGtVcnhqcXhCb3JBZWg1?=
 =?utf-8?B?Z09QSTIrNFByRVQvaDlSWnhQSlpUSG9xZi8zSUhsTGZFZnpYWGJsNWlhOG1O?=
 =?utf-8?B?Nm5rSUlqZWkzZFRDVEl5YnNCSE5lZnh1UUxUVVQrZUZsYlRwNGVobFlNbDIy?=
 =?utf-8?B?bmZLK2FNa0JhdktrVytNS0VYQWkvUDZBbE1jeXFLUE92UlI0Zi9PMG5zdjF0?=
 =?utf-8?Q?lrA/w6/+w44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXJXYk5vMTZoeldGbk1UODlucVJ0RDVnbDBSUWt3bnAvMFNwdEEzZ0ZndElE?=
 =?utf-8?B?eWJHeTArbVd6N09sZGY0cUkwVmxnbzNJZ2gwK2tudldGaEhlc2RKUldFY0dl?=
 =?utf-8?B?NjBZclpObVh0QWsvNGdLKzdvcnJaaFJFTVpZL3VjeW5tQjNYTGsrbnd1eUp6?=
 =?utf-8?B?L2hOSVNtUklac3JVZFNJQTV2ZGRneTNwVWlRQ25WTDUrcDlwWXNHSkNVWUxv?=
 =?utf-8?B?eDhoc0JjQW9qOXNUaEFaZkRXbzdlQldOYlNoakFHY0lhRzRkNWdNTFMvbHB5?=
 =?utf-8?B?NVUyT3I4N2t6UzRKUEt5ZTNkMWFkMVhiSHRkMXBhdm10ZVRGam84blJRelpl?=
 =?utf-8?B?VndhMWpIQkhiUG8xaXc5RFI3NlFDTW5VaFozYTVmS3lCQTNzazFYb09BQTNw?=
 =?utf-8?B?ZTRneDBJTXY1bFRSajNFY255azBUMFV4NzBVMjNDcGhGTTNTUkh1VUltb1JX?=
 =?utf-8?B?YzdlcFlza01DcUFRTzRtNEZRekszUXQ5S3pUUS96K1E0R2xpWEp1QmgwdDlp?=
 =?utf-8?B?VE1kdFdreFdYbERPQ2plT2xhOTZDdlpCd3JmUGNBV0IycDdYVm9lQllwK0Rm?=
 =?utf-8?B?a2ljUXpaME45WXVmL3VSeWJ5N2pPQjFyaFlXVk1ianBKVEdNNnhiL3Ixd3Ew?=
 =?utf-8?B?b2tLMWc1TjRrU1NBcEx6TWVUQ0xkVUY3OXRGbGRBcU14c1J5cFZCM2U5eEMy?=
 =?utf-8?B?UTdlOEgwSkpvMVliaVJ5UEdoYVpwanpwOGxDdW5FUHJkVHFQOTMxTHc4Tkda?=
 =?utf-8?B?RTZxa3M4L3ZDTlR0bFNDckYvSFZlNXp3WFVYUzFobHpTVFI0bFYzRERYQzNI?=
 =?utf-8?B?ZDRTLy9Hd2FGNmc5V2NRQ0R2NWhGdDNiTEZIOEpBaDZnNXpKQ0VVUVdEOUMy?=
 =?utf-8?B?UkEzRlJzaFN5L3pndkdEUXJpY0c1V21kbG84Zjh1akhTOEwvcW5wNE9aYXow?=
 =?utf-8?B?bjZQb0tJTVlTaTFwR0JHdUV6eC9BRE4wS2ZqNTJwS0t0Vk9ydUtKdDlaSWRU?=
 =?utf-8?B?cjRTL1RhSzRobXMzWEd2NWNUQlhLb3dwMGN6Z2tXNkJsMXdNcTBWZVQxWk1Y?=
 =?utf-8?B?UGVKdHZJZlRMSmt5N2x4Vi9ZUjJ1TTBiL3R6eXNPenlnMlNzZVZ3dE5BR2lo?=
 =?utf-8?B?QmZkdXlDZkx0LzlxNnk2Qk10MjFsa0hkTW9MOGd6N1c3MXRtRWFoZ2pBMjln?=
 =?utf-8?B?djRjUEFGWkJQOVRlajBwNkttVjVhRWJHeTJmdlZob0ZvZFhPbHVEZkdQc3pz?=
 =?utf-8?B?VmlHSHEwWVNiSU51SFlKQVFtZkNGK2t4Kzd5TmpBbmpkd1JCZktmQWY4encr?=
 =?utf-8?B?NFdRZVhzbkVHaVBqS1RVZ2xXc0U0RnNjWTJOMlMzMHpPRWdMTy9Cbk5xWlk5?=
 =?utf-8?B?M2VGUzRSeUlwSlhWKzBWQWoyZkNSM0tWRXpEYWNHYklYdFRUL3krN296VVJ2?=
 =?utf-8?B?NjlTYk5RdzVNODhmU2dScnNHRkN2YXhuRStsU1Z3Q0h3NG40UHh2cHRhb2JR?=
 =?utf-8?B?VTRhamhvbEk3QjhqM1ZkMzlzcVpVM3dHWkR4MDcwQ3p3MWNNRXpReEl1WHU0?=
 =?utf-8?B?d0ZCSmxDMTZtQmxFemZuTXRZNml3dTI3cVlvVmZIWTRiOVpodTVCZEdnN3k1?=
 =?utf-8?B?TjRrbmNSbEFNalBrL0dweGFOZXdPcllqQ1lsK3MvVmNSc0pkckdkeW9yd2dw?=
 =?utf-8?B?L2VuUHM0MFBBRyt5cnNWSDgrRnl6NEVXTE5sRlhQTllTK1prT0grdVFDRUQx?=
 =?utf-8?B?bHdWVWx1RXdMRjhXN1M2d0VDVG13bTBhellQc1pXRUNiakEzV3FrcGtKbHFD?=
 =?utf-8?B?bEROejBHTEZRNmtPL08zWWMraUdTTTg2LzZZOE00VkY1WUpSdXlWUFQ1cU14?=
 =?utf-8?B?TWNocnl2cnRPcW15OUx4SU9LTGxKa085WjhIeUVYWVpzaktCdXVCbDVqbVFS?=
 =?utf-8?B?LzNTZzVqcktzYi94Q0wwWWJCQWRXSWF0NkRRNDRMZk1nc25DUDBlbVVUWW9B?=
 =?utf-8?B?MEJzbFRRM1lhRFRGcEtaMlpmakpTdjlrUld4QkQ4YUlidTFpZXhoTlFsQ1dF?=
 =?utf-8?B?M1BGYlhyYmNHVzNScEpSWXpRdW9ZdkpkTUQ4a0V2YjVpVGdUeUFIL1R4ZURp?=
 =?utf-8?Q?UHgbqiE/8gptgO6G1aBDQHxXD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0997430e-39f8-41f3-f562-08dcb00bc9fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:19:46.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWmMQG3yh4r/XtOrOvrLZdsdOe6hFUKnwl3beQoUjpTao+jf+gC1VWjGryUjPGcV5Rdw3yHD6ixc8pWS+D9kQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382

From: Richard Zhu <hongxing.zhu@nxp.com>

Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
the controller resembles that of iMX8MP, the PHY differs significantly.
Notably, there's a distinction between PCI bus addresses and CPU addresses.

Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
address conversion according to "ranges" property.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 91aab0288fdcb..4928cea05f6fe 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -65,6 +65,7 @@ enum imx_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX8Q,
 	IMX95,
 	IMX8MQ_EP,
 	IMX8MM_EP,
@@ -80,6 +81,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
+#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 
 #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -1011,6 +1013,22 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
+	struct dw_pcie_rp *pp = &pcie->pp;
+	struct resource_entry *entry;
+	unsigned int offset;
+
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
+		return cpu_addr;
+
+	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+	offset = entry->offset;
+
+	return (cpu_addr - offset);
+}
+
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1019,6 +1037,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
+	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1461,6 +1480,7 @@ static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
 static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
 static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
 static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
+static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
 
 static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
@@ -1564,6 +1584,13 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
+	[IMX8Q] = {
+		.variant = IMX8Q,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
+			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES,
@@ -1641,6 +1668,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx8q-pcie", .data = &drvdata[IMX8Q], },
 	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },

-- 
2.34.1


