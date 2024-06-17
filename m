Return-Path: <bpf+bounces-32342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B7B90BC00
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD7C283B82
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03C19D081;
	Mon, 17 Jun 2024 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nUALNL3y"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2043.outbound.protection.outlook.com [40.107.103.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2E19923F;
	Mon, 17 Jun 2024 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655490; cv=fail; b=W/GU5RnANrBVJcmhah4ItGInRIl34Sztg/794tyASyr5U2YAQQSZQJSm5k2kE+YF+OZNM5z9R5etc9AWiKl0im7qUsklWH3oA7FZ9r/30sToJCOLOU6Wv9mROjgbpliQwvenGutiFcb3Jk/Jr3ONRhGssC2SjmxSI9lJjJqTwX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655490; c=relaxed/simple;
	bh=SHH+RxbPVg9d9vvgQwAyIOSN1a0ktF2Q9tORg7XL1Wg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BAASp77DUvJeouY4dyfCDTrXOpv5W1WWBeiehymJUeASDzfSkIQWvCJX6kZGdOVHIL9vpDrJJe1PvzQx7s36lbLtRWqzyuKrLQkCbNt/5hr//sQttrEgq7ka5Ew6UNvAI64hQWiykrHIe9QIJRGjTFcmhLbfL1veBf0WoIg6D/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nUALNL3y; arc=fail smtp.client-ip=40.107.103.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLlh1Q4LU71Zy6JKAcX+isitunPdsHwVaLip4liZSK4MkU9YqF4RlSYo3+NuH+2KRUt1DBFSB3+40qOO7ZTsoujfwz0Jkl1hV1NYu04pSKtgsI1A9j5/6NV+nHirvMdxkg1aeAmmWVkt3E9esjLDpeTdcuJ9INmN0tYqV6NsLgVhpt8Tjqa9iPrT3X+bXNHl6W5ABUOAIWK+RNTdyYmqp1zLqBVheyUz09uB8IEPFvMGIpQUq3tYmbyY8AAfDzBq6cDio29wWFgBYmRFWwIGHlrgKU9ZaXbSsL/BCdSNeVkzlIqkW4WZPzOLl2nFIV7NW4/fAf+uPa4bpwG+poJjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHd1Na5jpn2/1hr3DnG0fdy90jL7MoCN4Eo+Mj/vcaY=;
 b=eRXZiA3m8NhUpK9/ZotHyUvmjksuivr9nNIGaFYhFlm67zpKZnmY3ZoKEh+y3KCkww+EMu0NbmtnQZncTexLDHbIxENGAF6zuWMQ4yKkQmXjGAxvl7G7IcOdmrkPinm++QbJ3Tqd9SXI9TmjihLXUvOSxgnMUHqDxW08PFAgfeq7BFFRSW3XnJWwBIyn7sCVJYNp5YYhvd46a3e4ctv7WJWLvTXSSIu+3J+D+V/f1X6idLe2BWfxKpPsagHFMP5BGPIfFPicBnHjPAbhI4dKqnp7FAE4MLo6UA5xL7HIh+r+9ZSqRCCrm8Y6TibgP7jxWglSiybv+QJfxor1+iLhEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHd1Na5jpn2/1hr3DnG0fdy90jL7MoCN4Eo+Mj/vcaY=;
 b=nUALNL3yY13rFk4t5BpAKAS0N7C4vD3lhhclDrk56DvI1/QwFRN83+ZdDsPwDP4whKvx52lb/sJVdPWLVEoExsMU3ENGmGvwSiFba+x2ymsyudSm7jBiDRQvgBzt5pLqZkRaP6bKcQN3UmrZUBqSLOUud7XQS7DKo8xzMOmzqhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:18:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:18:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 17 Jun 2024 16:16:45 -0400
Subject: [PATCH v6 09/10] PCI: imx6: Call: Common PHY API to set mode,
 speed, and submode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-pci2_upstream-v6-9-e0821238f997@nxp.com>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
In-Reply-To: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718655424; l=2342;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SHH+RxbPVg9d9vvgQwAyIOSN1a0ktF2Q9tORg7XL1Wg=;
 b=1DI3HJ76h3fwRbwaWh5+zj2zcwaMy67Ux3uNEvoY+VsVDXNwCeK8AK9kbH+c+fD5DiENFwqw8
 s3npenmN8jJBqLfo2zclPe35U8r/3CQzw/wF27Wwy8LUHJeKwEj12gS
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e2af5f-b5ba-4353-2f27-08dc8f0a98dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1ZIcXZpRFdrUkVXQmQ1RzJJTWxuMHQ5bUN4L3QxVjdKemI3cDA4WjhNeWdX?=
 =?utf-8?B?SDJBUEIyZDV5SC83UXdXVWpKc1pndzRNVnBwMFVaTElQQ1V3UXlhWjNBSTVO?=
 =?utf-8?B?LzUwdWIrMnhFMzhoUUZvY01qbXVySmhXdDRQaWJ5VldZOTdLVHdRcDFQNTla?=
 =?utf-8?B?ZFFvT3RSWnNIL0JjanBVdkNvK2U2Z3dnVzJlRFgvaEF3TFhBTlFqa1JsMlR5?=
 =?utf-8?B?TkZ1MVVaSysxaVB1R3o2L0JHVXRraThjSytnTjY4ck83RDFjckRzS0VGZnNS?=
 =?utf-8?B?NzdCdGFOY0ptWmloRHZLQlBRbHlRMzJFd2p6K09vQVdoVzNUVjF4eW0rbEc2?=
 =?utf-8?B?WmhPUEluNGVtSm5aQ3V6S2owemlPajhmVHVYMDJ0ajlveHJZb0tZL2FNamdl?=
 =?utf-8?B?NjZiRXRTeE00R1VLTVZWSzJKZmFxamhTVzNSQ2xXS1lCUWZkcWxIbElTNVpp?=
 =?utf-8?B?MVlYN1lCa3JNZ2Z2eC9vR2FpWERLWnJsTlRjN3ZILzRCTWdJZE9tZFJ6RWY3?=
 =?utf-8?B?bThic3IzL0tQU3pRRHUrSnl6aXppUVl0SVo3NlVtcTRqRDZRN1U1SjJiWVgr?=
 =?utf-8?B?NDNaTzRscjNiai9uRFFEcFpzWHd0UGhLQXlQeUx6R0JseVhFR0lhM1BGcHJ0?=
 =?utf-8?B?TU9makl5MkNsN2dMblJ4Sitsc3JXVUNScEJ2QzFaeTQxMjFCYkswZms0YXNx?=
 =?utf-8?B?bzByUkhYYUFSYjlzWnhnWk9WVkVBLzBRYng0ZzUxaW50RmxtQW9YdVBCR1hR?=
 =?utf-8?B?M2IrU3pqTnExLzRSVFc5SWRwVUZVQS9mV1lWM3BOaERlWmlUUWg0THUxbVZP?=
 =?utf-8?B?eUJvcWtBYVA2MER6d0I4RlJBbnM1a3lhRm9TWUk0WkxXNExZbTJaOWlaMjRa?=
 =?utf-8?B?OUc1UzdkT1c2ajVudXFjS1VZVGRaN1NRckpUVUFFLzVUNVJKd1FkczFGQXBi?=
 =?utf-8?B?SGxJNUZhaXF0dHpkM0E1NDFVS3E0VXpQU2VUNm5QTW9TcG5PVWhBZG05MVJ3?=
 =?utf-8?B?Tit2c1Y5OHEyaDR4Q2lwUDdndUxkNnBPVFo5cHVKN3o1M3Z3SDRXQzVickp5?=
 =?utf-8?B?cktOYU5DSEh4OEhRTGJtOXdXVk1ONEdkcGZuQXpuajdueTcxUjBxODJINVRo?=
 =?utf-8?B?WFlrK3BCRGVMYTA1cStYK3JwWVhlcXdqQUhJWVpIaC9YVFhGbU5rNU43dlp3?=
 =?utf-8?B?M2ZoT29Yd1hoSUlBZHlVbHNDdmRvQnZwZ0RXYnhiWG40SDd0WUpoMzNpNUtR?=
 =?utf-8?B?ZnRKM29JMjhsb0M0STF3dmlYRlVUcEVOREVCZ1RGOHJsV1IyZnhXbTJOeFdI?=
 =?utf-8?B?N1BDUWJnazZxTUVqR21LZEtLQmVUWVFQOTJQZ0szUGNkMVpocmZqN25OWFJR?=
 =?utf-8?B?QTBEeEFDNW9YcTJmOXo4ZncvNnhENGNCUCs5Zy9ER1UycXFFZGV4bnRNMTlm?=
 =?utf-8?B?K25PejJXY1Q0djlsNXBvM3JmOEg5YnI5UHQ4eklpcjUxeWdiNkszeGpiUERh?=
 =?utf-8?B?b0lEZVdiSndjdHJMeFkvZkVMbGx2d2xQL0ZGUmNzUkVWWW1TNG8rYTlaOGdE?=
 =?utf-8?B?bVVNMGxQL2x0ZG5sZnhjSXdVYTRKSVZIYStzL0xLMm15RXdLN1FZemtncUhZ?=
 =?utf-8?B?WmNjMnZoWVJFeTNpNy9GakVzSzJlUEYrNFNWb3R6b05sOWI0S0Zwc2hscTZV?=
 =?utf-8?B?UjN1QnNRRWhxUi9FRzh2UFRxZU5naVd2cUNGNExFWTE0M3QvMkMvQ3Y1NExz?=
 =?utf-8?B?eS9OSmFzMURjWTE5N3VOdWNiNGlCRkR2M0ZvbERYNzh2V3lKL2dhQU9jZDlk?=
 =?utf-8?B?dzZ2YU4wQ2lUR2RKT2UzQXdUNHJKSFF6NUFwbVVhd0ZUN0VYTUdMa2lvTjhr?=
 =?utf-8?Q?OeM0dYvg3k6Ug?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1lPY3RMMnFhenIzanhiWmplRm1QRldWQWxqTXNvRTBaNmQweXVESjRueWZY?=
 =?utf-8?B?NFU4ZmszZW96SUdFZU14cThha0c5UzBkalhrRlBSaFpXczdETG8wdll4b0ht?=
 =?utf-8?B?eGJKc3dBZnZiTWpmcmdRTXpKOHF4Y1lKTXJucTAwOVErUDdxL3o0ZHhhUEN4?=
 =?utf-8?B?NGtES2M2ZWFZeDZ3SndYN09FSmZ6Sm8zMEdzYTA2d0FNV1Z5dTNvdzJBY3A1?=
 =?utf-8?B?TGc1RnRMclIyenl0cW9MWmp4cW9rdXlwMjR5K0lYQytUMkFScmhWTU8vUnds?=
 =?utf-8?B?ZFNKdFpDUHAvdzRoejlqR3g4aHlhNWRYREVnallNR2F4a3p1K3cxWnhRMDJQ?=
 =?utf-8?B?K1NNMURmWjE0QU11MHM5RUZIRURPUUgxdC8vWGFYSTFxLyt3dnpKbUpkRWNL?=
 =?utf-8?B?TnlJS2hKUVllZ01sMGc3OU9ibzM5K2xMbWN5bm9XdFpGQUFyNTJpT3M5a0xs?=
 =?utf-8?B?dmxIYkUva05uMTlBei9nTTdRV1pvNW9Ya0h0NUJSM21hbnBCa0Foa1U1TnVG?=
 =?utf-8?B?bjVFV2Y4TWhQU3JTbEdUaENadUpSeGZjTXRWVnZTQURWK2hTOTFLTWhadWtl?=
 =?utf-8?B?b0NhcTZiVWJoR0ZtNkRWSW1FeDZYV0ZyU2JRWU5lQjNTSHJ4RDBmcUlmU3Rr?=
 =?utf-8?B?dnVKSWpOd2lCazNEa1NKRFNMNUtQSEtzWEw5cVVXMFBaQmlEVkMvTHlEWk9Y?=
 =?utf-8?B?aXFKaTlXUVIrMnF4R29kVHh5c1c2SXR1UUxDZ042NUhLbmMyaEhXeVBMYmtJ?=
 =?utf-8?B?R3RYUEdBaUhTeG90SFVvVDVSSGMrTFNneTdySWxqZThDYUFUMHBsb1FTOElJ?=
 =?utf-8?B?OGZNcXlJa0p6UGROelBjNFkyYkZ1RzQ5SWFlN0IzS2FyVlpsSU9rYksvMWs5?=
 =?utf-8?B?RFBoU3JoeUplUGlPNU9laWVCOFBwb3VoNHRxREw3R3VaMGlEL1RqaWVkbllD?=
 =?utf-8?B?VytqbjZXSWpncCtnbHNXQzN3MDhLVUNxTVEzSkdrZWl1VFhnaXJKUGFtWDlH?=
 =?utf-8?B?cmdmc1JJelp5U0UzbTljVVpINjNZRVltWmRVaW5MNXpycHpabm5zbXpmUitP?=
 =?utf-8?B?dHMyUlEzQUlqRFZBRXpuOGxoVFR2WjdwTTlpcENmdDIydVErclEyQWFiZlVv?=
 =?utf-8?B?WEtOS3NLYkFjWUFFNzBlVHlPemt4Y2tPdkFaeW8wQzZCQjJPWEZkQTZhZ2No?=
 =?utf-8?B?dU83cnBiOTVSdksxMmQ3WURkYkdReXNHb2djekxkN0htR3RJUVhkMzEzYzZI?=
 =?utf-8?B?czJSUVZURmRqemUvVzAwUzBpN2FHTkFVaG1EUlRQNkM4R28vd3crUko4cjNN?=
 =?utf-8?B?dG1YMWRCSlM1c1FiVTk1S0NVTm1JcTNXWkVEWWY5eDFDbVRWNXpkWlgrUXlp?=
 =?utf-8?B?Smx6N252U0hhQitqczVyRWV6eTRBY3M1OHJvSnI2ZjlSQUZxbStKeERRT0o2?=
 =?utf-8?B?c2FJaUh5RzdmMS9IeE5vMEtDSCswMlM2UHo0MlVVYkgyNUxwc09vRXlwVmFa?=
 =?utf-8?B?YkFqcW02SjBhU3ljZ0ZRbndBRVdmRnpxNlIza3VEMEIzeGdQNVd2SWFyZWJH?=
 =?utf-8?B?Q20xeGpkVkhIanFidjdLZ2lzNWxsY2dHM3Blb0tjQkNxTkFkRkE0UUd2ZHBi?=
 =?utf-8?B?Z0QxQjlXT1dhTXh0dDVHMFRPQUhzc2xVQWtBd3Era2VmZWNhbmpFNXZhRVN1?=
 =?utf-8?B?ZEd3OCtoZUo0cm0ySnhyb2NVMnNObVdLcVNSRVk5dkJjV2FtTHk4aHoxMmdl?=
 =?utf-8?B?VkV5K2tlckVHLzQycFY2dGtVNG9seGdmVFQvZk9MeEdhN2tKVDFRK1krcm9s?=
 =?utf-8?B?R2VNSE5CbzB2MG5JQU9CRU5uRGlDK2QzM1hvZGtwbVBDNU1nMk52Vm8yUldw?=
 =?utf-8?B?akhoa2hxQU9ncWc2S0JJSWtjeTMwK1pUUFdNdkZHQm9TcW5ueEJnSmthNXBR?=
 =?utf-8?B?bEt6U0NtTS9ONkdidzF6RHRZY2RraFdnYysyT0ZZWm5qR1Y3Sncva1NVbExl?=
 =?utf-8?B?YUFyMXZqRERscW1mM1AydEk3MlFaRi9jeWd0Vm5ERG5SS0NzR0l3REVxaFRr?=
 =?utf-8?B?R3Z0MkNMVjF1eVQ1Qk44MXpYUTlwTzB3b0haVW9jazg5OFc5MnFXTm5WV3Vu?=
 =?utf-8?Q?A0XU5l4Dp/FIjlfXaq1YgR8rg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e2af5f-b5ba-4353-2f27-08dc8f0a98dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:18:05.7756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcQGik/0oNDC8zazY4KbcK01Tw0mraCBnbMElbrZU86Fsd1fYBixyg6LgD+6RyacYUIRUB+vKr9HYZoGUuSVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

Invoke the common PHY API to configure mode, speed, and submode. While
these functions are optional in the PHY interface, they are necessary for
certain PHY drivers. Lack of support for these functions in a PHY driver
does not cause harm.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ab0ed7ab3007a..18c133f5a56fc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -30,6 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/reset.h>
 #include <linux/phy/phy.h>
+#include <linux/phy/pcie.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
@@ -229,6 +230,10 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 
 	id = imx_pcie->controller_id;
 
+	/* If mode_mask[0] is 0, means use phy driver to set mode */
+	if (!drvdata->mode_mask[0])
+		return;
+
 	/* If mode_mask[id] is zero, means each controller have its individual gpr */
 	if (!drvdata->mode_mask[id])
 		id = 0;
@@ -808,6 +813,7 @@ static void imx_pcie_ltssm_enable(struct device *dev)
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
+	phy_set_speed(imx_pcie->phy, PCI_EXP_LNKCAP_SLS_2_5GB);
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
 				   drvdata->ltssm_mask);
@@ -820,6 +826,7 @@ static void imx_pcie_ltssm_disable(struct device *dev)
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
+	phy_set_speed(imx_pcie->phy, 0);
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
 				   drvdata->ltssm_mask, 0);
@@ -955,6 +962,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		if (ret) {
+			dev_err(dev, "unable to set pcie PHY mode\n");
+			goto err_phy_off;
+		}
+
 		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");

-- 
2.34.1


