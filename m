Return-Path: <bpf+bounces-30769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3E58D24DA
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D892C28BDD1
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482F17967A;
	Tue, 28 May 2024 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OoeniFix"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9E17966F;
	Tue, 28 May 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925172; cv=fail; b=HUPjPNhdIUK4vC4VqiW+DUMV/TCPMp7Nw/QXbd+cjWXKU0NMXPAiKh4qwkAHY8XWSChqGZ0cSj7FR1bs5lz9eLGYWJeuQVngJSvcgtR0hBcw06lFz7ajiCPNu51TwTZdtgFyiew6UkaU1SuVyXgJsuQWZy13uNzVXljsto2zlBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925172; c=relaxed/simple;
	bh=ru5ELRV+Mel4uF1o37Wl87WKzmUjv21jB3Y1hFLGfM4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Q0U/wTbGvj7ToikUhuqTwObjtHOftfKkIKEEtBIQReCD82tpKSTgzpJZQbt3zibAoOsHKfO3c/KUXTeUFkCyaSiojG8qimEeCjO2AVFpMBdLIXZMXABUu0dREBocPWfpNKdsEy1Z66oEYjazRCGTO0HUtMpehHBw9wuElxRmc/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OoeniFix; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDz/01LG8x789jldZAQ5mN/xaEN9LkwUo9O7MZf9kdHS+sjDJP5hd2hBvRmKgLzQpxUV/irfm5BAj4ebjCb1agtLtIpHzqoAB+XEYLs0PkCdI8aXPTUSejU5+C9UC5qhA+vdHRk3CIYZYcpux8XQ1qzfCYJ8fqlb5Ko/iDlED+KgOoFImHBT4a/TGcwriwGAAJv9w1DN+5DH11+m9iiWfwlIoGPpqPSRrz0QcoHQYLMbs9zUQK8kQagYwPXtRkFOWIJdxNZd3L+xHN5OgJj2Sfl7jhT0imvOJzR9qwEYK4vPtb06KnP11q0KebjIMgkmaTgCsIVxfLoR6WPcHUzqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1izfknJNScEV+R31c8FQJNqtxbY9z0J0ldP6WklXW9w=;
 b=JNwoGIia89TsGlAPC5wJLQkmu2eNk11Dc//i7uionPbGIXGUYWf2t0nLXL6+5kS02rzwt/9mI8uMbuINffYfLJNDpyqDe1Nqc+FH1tns8bfdFLZ1XGsaVcDjQbTzcU8jeXzUuESz7n42Wwu1WZdBIFzdGd5oEzzHEWMcN2rWysUmrQ7pmzpfT08fssb09OPJCeI5YhBzDsOeOufTFLH36tgJrcaGxp6RhHmcclTFJW1Ad8pOhSgkzo8py/QlXX56cGBpgbGU/Zc/gwwy/F4ksQ5SAgOo7x0QLXzziWyqkECvEsTjKj7nwVBMwo4d02dmYM6ICZdKIz3gOFaG5xjoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1izfknJNScEV+R31c8FQJNqtxbY9z0J0ldP6WklXW9w=;
 b=OoeniFixcB6sDzvTtA1X/K1V6AR0opdszu7Eu67NUZF1n/ji5PQ4aEgHplzx6g09WGis/u9bepZJ1QU4M/oW1kZX1ueVp2sNt32Ga4fotyZbUloV0MxObjam+7uROvvxYSbn7RmYKC37CCDwcQhi/Mc0yleIRtdv8LiJkJaP6xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8663.eurprd04.prod.outlook.com (2603:10a6:10:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:39:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:39:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 00/12] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Date: Tue, 28 May 2024 15:39:13 -0400
Message-Id: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOEyVmYC/3XOyw7CIBAF0F9pWIsZGKDUlf9hjGkBLYs+AtpoT
 P/d0U19xOWdzLkzd5ZDiiGzTXFnKUwxx6GnoFcFc23dnwKPnjKTIBVIWfLRRXm4jPmcQt1xcN6
 LqhZaGGRkxhSO8frq2+0ptzGfh3R71U/iOf3XNAkOvKm0PFpENGC2/XVcu6Fjz55JLhZBfVtJt
 vZQOh0a4035aXGxdPnbIlkLqIRqfKMQPq1arIafnxXZYJ0Fb0taeLs7z/MD8B4YalwBAAA=
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
 Frank Li <Frank.Li@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=5104;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ru5ELRV+Mel4uF1o37Wl87WKzmUjv21jB3Y1hFLGfM4=;
 b=19keTB9KKbO5XeR7DH1NE/2vTWK2vcr1RgrKbugTVUDl7w3MqeimhKhY1D8BL+HYInkcl4o3C
 sN4sJGEOIjWCnadOiJK/hlrSJGlwHjsYouCZkf1zOFNs/M8TNyywV/j
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
X-MS-Office365-Filtering-Correlation-Id: 972dd1a9-9514-4d75-8dac-08dc7f4de2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|366007|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWVZbW9ubERiOXdNLzE4S3BDd29MTG5TcDZmZHZIc245R1RVMFdtTlVoamY0?=
 =?utf-8?B?ZVgxcDRIRnl4QVNRMFZBTlo0VnF0OGQvcC80MVNSSE9MOXpWS3VjWHBxOTlV?=
 =?utf-8?B?QytnWGJ5dzRqZkYrNEdYU0tvMU5GSjVzZDJzbThFT3JsTzBDRlBobE15N0My?=
 =?utf-8?B?c2xmY0oweVBRbDZJbFlQTmRsZzkrY0p3dC8zQXpqNUQrVVNBalMxY1RsSEpO?=
 =?utf-8?B?ZjBzdGlTRlFHSkhmdjNyZFQ5L09BM3cwaTJKRGJzd3NESEFRNjJieDZQYmx5?=
 =?utf-8?B?dGRGUlBFd2Z5ZnZvNG1HOGV6bHpPUHNUUEE0NFBYU3ZnOE1QMzU2a0NKVU9F?=
 =?utf-8?B?U0g1SVgyRE9ZUHhLK21jazRTNXovVVY3MEl1M1ZPNXFIOGp5NENGWmdrMkZO?=
 =?utf-8?B?U2p0RlN3bGs1OHJBYjhvcXpiaFpHVGdDOTBKVlZDTmgrdGU1ak1Kazh1VWd3?=
 =?utf-8?B?dXo2dE9TZ3JRa0pSMHJZREluR0RpQStRbFVDU1hrRHQ2UGFvQTdaRG54dGtE?=
 =?utf-8?B?V0NBOEVKbUUvdTNUcktSYmhlYzBjQjNWZllUQzhyb1h0eWxhR0lVL0VsckFl?=
 =?utf-8?B?eHVjRnlIaWJGVTBncUFHYjgxbldtTGEwUnRrZEZWNElHOVgvTDdPdEdMQjVZ?=
 =?utf-8?B?T01DdHJwZ3Z5T1RJWG5Ja3ZxSUJOOFNUVVpzQjVXZWdUVHhCdUpzMHlHbzVP?=
 =?utf-8?B?QlM1MnhYd1RxeW9VNUovU0FFZytPaWQwb2hIL1k1Y2dVZ0pLNVd6T0kwcEtm?=
 =?utf-8?B?Vy8yZDVEdThaa25GOWs5d01TSVhxZFl0cW04QlZiN2k5bFlsWXhpNTJyN0ph?=
 =?utf-8?B?YlNFU3JmYVF6YVJNZ2d6OGxQa2cxSm5FdUN2Q2ZiOWk5Q1VHRUFvM0U5YjVt?=
 =?utf-8?B?MTdWZzlBSmdvUEhUNzhhT215Zm1sYUQxL1VJdGsycE5KQXFseVBPWGpINzBU?=
 =?utf-8?B?RTlHbkI0enB0a24rZmcxZGVKVUMyQlhIQndsZW96ZFFxWUdnQlN5OUhHQm5N?=
 =?utf-8?B?UjhEK2NMRk5nNzlpWjFxMytEejRiaUR1QUV1MUFaM1lRQ2RCMWwvR2Y4bUNj?=
 =?utf-8?B?ZFBXNytZc2srbXVRSld4cTRjNkt1ZEZCUTBpRkFjZWFBTDdQMXlmemJXaCtE?=
 =?utf-8?B?NkJrMmpralNVQ3JyYUVTazBVcW9SRmRYWVJLTmRBalp2c3FxKzMzanVNdUJD?=
 =?utf-8?B?THhoNm5TS0tzV3d3elhlYUNmQ2JpanQ3TG51eExPSzNFT1FjZWpzUWZpTFZa?=
 =?utf-8?B?QzJHd1BNYUZHb1c0M2gwVURPMThjWU9MYXJYVnA1UlRxSHcxQmtvNHZHVEY4?=
 =?utf-8?B?eGdHMTBnRDRkTHBwYXhGRERRcFd5Rm5NVlNTNzlvYW80aUR0SUJkMEhDVTQz?=
 =?utf-8?B?blBxVEhFWDdjd2ttYUVYejdZTDdKRVZ2S01PZnUyeHBHaWs4MmszbHE5bDA0?=
 =?utf-8?B?MW9DeDN3RlNDQ2pUK1FEYTVrMW93UjRZemNhL0lrT3lFY0FmbVVLTXgxbHJ2?=
 =?utf-8?B?bXBVdDV0djNUZXdaZHphUzZLMVZHYVZhcXJ3REZOQlRwRHM0SFVaOW5ReEF1?=
 =?utf-8?B?akJHUmpjSjBNekNjQmlqMHlhWkhnZ08vNmx2aFZxVXA1SDdCcWpiUUlTdlM2?=
 =?utf-8?B?ZVJCZ1RvWUdkaGdlSVNXZDV3MVZaUzFNdkVQY3BPdTJmcUNiRlNoSlNaaGxq?=
 =?utf-8?B?eFJZMDZxOUtaU2lkNHVxMXhqL2N2d044bG5LcWlMZThJbEFmY1BHYTBjQ01F?=
 =?utf-8?Q?2HL//K1vPAWlW7fWiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpQTW5BUVQ3cFhqbG1JdW1ZdXJ6QTVCUEY5dmdFeTRYMjdGYTYzUFlKWkpD?=
 =?utf-8?B?aTIzaWV0aFZtY1MvNkoraEJ4WTVYR2VEand0RUk3ODFoNUcweFlOWHZlaFNa?=
 =?utf-8?B?MW1uSHVqeXVtVjlMNjJYdGVkY1NkV0E5NmhKUno1dWduelFlRC9Sc0wwSUx2?=
 =?utf-8?B?czk5MVBFUXBmRzhIQnFHRlRxU1Rkdm13Z2VBeDZBV1ZEVmJmTzdKa2Q4bHU1?=
 =?utf-8?B?SUdKWDZsdm9sR2JBejBoaTMxUnNXaFpqSlZ3VTEyQU1pMzVyWHp2MnJkQVhB?=
 =?utf-8?B?OEJ3RE80UGFQU1I2d3NjaHZTQkxwd3pTa0dWeXlSUG9oMTNpQytnUmhtd25Y?=
 =?utf-8?B?c3pLZy9VVHFaZTRIM09YQVVrVERzS0RWYkwxSmRzSEdkSkg3bHkvMExTYUhu?=
 =?utf-8?B?cFREclpCcmRtWlp0c0ZqcFNvNjJJWDBONm9xTE80emNqOWI1bDlKMERWTVZ3?=
 =?utf-8?B?cStJdjQwQmJCM05tcFR2dEVWZ0FtYW5pTk5ERmR0ajBrNTdQZnZMVWtqQUho?=
 =?utf-8?B?TU81NlNxcGFjMEVGR1QyUTE0TUs1dG1aS3N4anR6Q0J1NG1jL3hvdW0vazI2?=
 =?utf-8?B?YnZvYmRISFF1WEhGekFQaDBtRFpTVUwzZTZuM2UvT2NYdGZSak44MTlwNjlR?=
 =?utf-8?B?MlVja2lNMVJkeGtDQ2s2Znc5bjFjSlc1dVBmdTN1ajA5c0htYzl6LzdWYTVn?=
 =?utf-8?B?Z0NVZjNZWHVPWWtZUy9pdnNLOXBSbzRnYzhmd1ZTUVBrTmtoOEs4Szd2Smhp?=
 =?utf-8?B?L0NIblMwWVl6MWdsVklWVTlVZ05qVFBReEJwRHhDUEc1WHdKeVZoV2ZSOHd4?=
 =?utf-8?B?RmdxVi9WQVQ0L2g4YUo4eExQZTBwN0tucXk2dmE5bzEweG1IYXRPb2c4d2JP?=
 =?utf-8?B?aHAwK1VncUZ3d0FEN2RvZXRHblQvTnNIeUVvVS9wb2IyTndEZWpsc1VqZkRU?=
 =?utf-8?B?WVJORzQvdnVxZTZoUjNPR0dERk1xc3hkc3plZ0wxZlgyUjBaK211dWZWMUE0?=
 =?utf-8?B?SGU4TnhxZm1qcExaTm5XK0hGMW0wTnp3RFk4U1M1YXp2VXVqRld1UmJzeDNW?=
 =?utf-8?B?b1Z4OWpLTFdhNzBiV1RqdGhTQnNwbHFtbWdPVWNLVDdkbWF0akNmMkNiQjE0?=
 =?utf-8?B?ZHZxbkwvTXdkeVRPRTc0T1QzWmE3ZDM2emRld000bjBWSCt0eFlCZEttMG5I?=
 =?utf-8?B?RUVlQnc2b2VxR2graWY2K3JmbTZlZzRsS2wwd0JiOFBZZFJTb1kzcUlsK2Jr?=
 =?utf-8?B?TVVrT3RaWEJkb1lLa0dhMUZ0UXVIbEoxdUJ2S0czMkZNMWQzdjZqMHpxTXVC?=
 =?utf-8?B?b3V4RE1FaVVtNi9aT0dVekY4T0ZOM3VUTkFrYlJFb1hhSWtITU9XK2prR2RG?=
 =?utf-8?B?Z3ZNUTBGTmZFNXpNdEw0S3BxVEpzWjRJQlF3R1FkSUpjS2ZFUjZVdzNTZVIy?=
 =?utf-8?B?TWdXTDBJUXViWFFjaXViR29QaGZnbnducm1lQ3B3MVRyUS9oeFNZM09mWmoz?=
 =?utf-8?B?aERtUDdFdmw0V0xCN0UvNTFTLzdqMWNhUjhjemt4UFkydWliMXcrUXladThD?=
 =?utf-8?B?eG1qMytiaG84dTM1eVZNVXBtL0xaa2RxeVdJb3NGbVFzcjMxOC9yZEdMdHB6?=
 =?utf-8?B?azhIZnZxdlY1ZXdXU3Fqbm9jZ3crd3dTVVVTZStVK2J5dHdUN2MvWkNDYWxD?=
 =?utf-8?B?VkxJSVlVRGd5S1N1c0tmTS8yeUxWUjFyWEZEaGltQkx3NHI3bjVzU29OeE1u?=
 =?utf-8?B?eU0vejg3Yko2MFAxRFk1cUtmdUhEYmRPM0ZGTGQxcEFpL1dQOEhwc3pLdytJ?=
 =?utf-8?B?a2VEYXBYbyt3cWZOWlVPSmFHc09XNWx3QVZKSXFyczhNbWdGUUk5b056MEow?=
 =?utf-8?B?QllJYVZzWFhtWGtLOW4yU0Y2OFlEdlk3aGlyU004L29CL0NUMG81eTM0RjJj?=
 =?utf-8?B?ZCtjTjB5U2lJQ2VUSGtrK2dnQ2UvNkxWOFdaNlpDMTE0TmFXSFhJcGxnejRz?=
 =?utf-8?B?ODJDWnQ3dWd2OE1hbFAxYkZnaHI1Y2k4LzZ6L1hSeE1PVnM5SytXWEFrc1Bl?=
 =?utf-8?B?bUpEQ3B0aThXVENydldTSzF6S243NlYrbkRvdDhkYlVmM2pZTGpjT1FQWU1H?=
 =?utf-8?Q?rJks4iURtDTfCNVxKZs7Jz5bn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972dd1a9-9514-4d75-8dac-08dc7f4de2b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:39:27.3671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWc2aMSi6+PwlkAoXNmpCz0ppCJvvgb3/ZUuBZIGisu/6OfygUO+cIMNhDLH61V/GeYnW+EbvSFnviTrFI/UCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8663

Fixed 8mp EP mode problem.

imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
pci-imx.c to avoid confuse.                                                

Using callback to reduce switch case for core reset and refclk.            

Add imx95 iommux and its stream id information.                            

Base on linux-pci/controller/imx

To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP Linux Team <linux-imx@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>

Changes in v5:                                                             
- Rebase to linux-pci next. fix conflict with gpiod change                    
- Add rob and cornor's review tag                         
- Link to v4: https://lore.kernel.org/r/20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com

Changes in v4:                                                             
- Improve comment message for patch 1 and 2.
- Rework commit message for patch 3 and add mani's review tag
- Remove file rename patch and update maintainer patch
- [PATCH v3 06/11] PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
	remove extra space.
	keep original comments format (wrap at 80 column width)
	update error message "'Failed to enable PCIe REFCLK'"
- PATCH v3 07/11] PCI: imx: Simplify switch-case logic by involve core_reset callback
	keep exact the logic as original code
- Add patch to update comment about workaround ERR010728
- Add patch about help function imx_pcie_match_device()
- Using bus device notify to update LUT information for imx95 to avoid
parse iommu-map and msi-map in driver code.  Bus notify will better and
only update lut when device added.
- split patch call PHY interface function.
- Improve commit message for imx8q. remove local-address dts proptery. and
use standard "range" to convert cpu address to bus address.             
- Check entry in cpu_fix function is too late. Check it at probe
- Link to v3: https://lore.kernel.org/r/20240402-pci2_upstream-v3-0-803414bdb430@nxp.com

Changes in v3:
- Add an EP fixed patch
  PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
  PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
- Add 8qxp rc support
dt-bing yaml pass binding check
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx6q-pcie.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dtb

- Link to v2: https://lore.kernel.org/r/20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com

Changes in v2:
- remove file to 'pcie-imx.c'
- keep CONFIG unchange.
- Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com

---
Frank Li (8):
      PCI: imx6: Rename imx6_* with imx_*
      PCI: imx6: Introduce SoC specific callbacks for controlling REFCLK
      PCI: imx6: Simplify switch-case logic by involve core_reset callback
      PCI: imx6: Improve comment for workaround ERR010728
      PCI: imx6: Add help function imx_pcie_match_device()
      PCI: imx6: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
      PCI: imx6: Consolidate redundant if-checks
      PCI: imx6: Call: Common PHY API to set mode, speed, and submode

Richard Zhu (4):
      PCI: imx6: Fix establish link failure in EP mode for iMX8MM and iMX8MP
      PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
      dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
      PCI: imx6: Add i.MX8Q PCIe root complex (RC) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   16 +
 drivers/pci/controller/dwc/pci-imx6.c              | 1181 ++++++++++++--------
 2 files changed, 730 insertions(+), 467 deletions(-)
---
base-commit: 50d96936b7b1be01bcc7b9ff898191214ee72697
change-id: 20240227-pci2_upstream-0cdd19a15163

Best regards,
---
Frank Li <Frank.Li@nxp.com>


