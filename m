Return-Path: <bpf+bounces-32339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD590BBF1
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5181C22B87
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1627719B3C1;
	Mon, 17 Jun 2024 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dGQ0bjFc"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2067.outbound.protection.outlook.com [40.107.103.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E71991D8;
	Mon, 17 Jun 2024 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655477; cv=fail; b=PAXh4a9IURoZ8hxquj228CqHphzfV8V//ZmEYjCFwrjn7xl9xdh/HXv8wOcgl76WRHdN+YXUhkK16cQ2MJg9IlAj+PzeHZDlYckdONVpS2CDve7HxlUSvDKbczkDKH1KX9uuBKIqLRq6n2oj00qds8jAgv7NW8vM0JIrOiSEFto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655477; c=relaxed/simple;
	bh=om4Fh5oG1kwE0U1dD6JH9tan5doH9jtRSql0uUIv1xY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pmFakF5f2y/ZCA46csST+16WRBQ410MeJ3KRz9MKGkL6WVU3oZuTQ1ySLzWVzWxiboArCxn2j2gR/wr7D9tLw3sobSYAMQqqFQJMK84A76INir34iy6OOBF8I9ORu9xOMRdxLfdyCx4Fe2MsqR23AkJgyAFwlSM2tYyrFnyu9RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dGQ0bjFc; arc=fail smtp.client-ip=40.107.103.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQkv+5eczKPHjTcJuDyR3iMU37XH8y0vC9fwRJ9D05W5w0CqBpqkBvNKiditjCOp/TnX5+lvTCXoWEUnBWCq0d/eTLif6b6Stu0rvmbFl4DIjSmKs4EkfFEf75X2eNPYPnsRfNN4tQF7xW5uIrW1kAjYf92qRqxUZPRCw9c3rhzUmlz1Nq6chkrUP4pnJa8BjLla1vGN9I0KPUJ5Nc079JhXiQ5r2rEWoDPQu1o6z5uXZNhKwaFxiBAc4chH1Vo4ZzrHfYO8MQrgiJZRyh+4dd32wZhV9Wxb3mC0CS4qtrYca/8qRAmA/DQFhiTXCN/L7wySMkxShUnjd+XmiwejkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFxC9rPKvd93kah/Dqg8UZA6Y/nTglhldH9xaKShG1E=;
 b=ib8paJe74nGtt6ZkPVFnsrR2GYLJPDdGZ8ZTOeMzjn2G4zgS+Br37z9iTaP1UpGKmcdjBHh9z6WwYef2ReuKp1KWjyjHsFvrRJNCZ+jjELpFFqSG3ky55bzam7ucIFug6cBTi2B/WCGkrP3E2o1Nt9B39CCpeUjJMUT3Yu1JTbIs/QF26pyb6YiaBC0GUIol3O7UXZ9pEvgvDuUZskBwUu9f/zscnjRTeuXqoEwNzEzQp+WGTZSs58aYw8hlmm/C22pC9SmfmZuIrgzMZA8DjbIbEsC8Ah3MUAsTvSv9FDW2+FjnP19cG9qRi1S3JiWIjxcrdn7s02CYA6Bs36G9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFxC9rPKvd93kah/Dqg8UZA6Y/nTglhldH9xaKShG1E=;
 b=dGQ0bjFcrn/NjqDpOwoEA98K40NHE9KY+rh4A6FAbgjQHUaylhHN44f5sVjzUb9TmSHH5vHya+is/OKFgdA82Kdeyio3PUxVnxLiDY/kMcKNBsW3QrYVIoO4Zsoix1VK5X0oYlCORIVVgJnpauJTj+6Z32DmEU5Ewce0S32knSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:17:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:17:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 17 Jun 2024 16:16:43 -0400
Subject: [PATCH v6 07/10] PCI: imx6: Consolidate redundant if-checks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-pci2_upstream-v6-7-e0821238f997@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718655424; l=1048;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=om4Fh5oG1kwE0U1dD6JH9tan5doH9jtRSql0uUIv1xY=;
 b=9uMWFLwCroYvOHNKcVvIyAR98TUgqlnHeSFOo7S1rAHPzfM51UrKhhWjtHs+nq2N1UKOlhl1X
 owo2yndpsGqCSHZI5Lv7DzWZMFSjssR1DMn57At8HNnaPPdP6Muk//F
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
X-MS-Office365-Filtering-Correlation-Id: b7d209d0-5982-4a3c-7811-08dc8f0a9163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T29LVTZpcjRsNmwwKzN2WXhqOWVsNG15NG1STUpzZFcxNlNGZ0VieVcxV2tQ?=
 =?utf-8?B?Z0xNQ3NjUXNmNXdDWTR2djZRaWV4MkIvMW51ZDJ6cXlOVTc5a3JoMnIwMkox?=
 =?utf-8?B?amtMMlF3VE1PN2w0eEM2YU1NcEU1WTJGa08zTHNKdThGUjVvc1V0QVYwUm5y?=
 =?utf-8?B?V2JIcnJOeWtoN3dVQ2pyd0ZOVXN1YTB2OXBIbjFvT2J0MG90emtsRThvUU8r?=
 =?utf-8?B?ZGFPanVITVAxTU8yemJUVU9EZlo4YnpkNVdSQ25BK1pmSDlOTjdEV0FKSG9X?=
 =?utf-8?B?U20yM01tVGZWQ3pBOTFjL3pJWnd2eVc3alI0bmJ1azdXRUp2eTB4anZNLzBG?=
 =?utf-8?B?KzcyWVYyazUyZk9QYlhvUHE0K0hmT0lzcm5GanVETTUzajI1MU8xYmt5cFFa?=
 =?utf-8?B?RGJtRmFtZnppMm0zM2RLeGJqMFlzU1BQYVA3WlhidGN1Q3VPYnVoTkZDL2Yz?=
 =?utf-8?B?cEsrYnUxTzhYcDJmNVY1eklXQnV5djMyK2tpbVJYdmhncFBPQzk0cnVZSTJS?=
 =?utf-8?B?K2paNDZlNXNlcy95MWhlckZJUzhBOUxWSmk1Wk5QYThLbVBaVmpsV25vT1BB?=
 =?utf-8?B?MjdNUjYwejJJY0JxZnhPWVpRTEJNOERaZGJtd2hIVXR6T0xVdzFkcGFVeG5j?=
 =?utf-8?B?amVhZzR2cHoxMDI5K2hhTXdMVE44ZGxpTzFtajUwUjlSWkwyYjVwVkkvNHZm?=
 =?utf-8?B?TVZtQm5zQ1ZCWmVBZlpocjBjTVBZdVFjc2F5dEpPTWFNMHUydXB3Y3B1Vm05?=
 =?utf-8?B?U2FxYXdLRnJQQ1lOdjkwWXhqM2p5MTdCVU5yV1FhUEhyZm41Wi83bG03MUFk?=
 =?utf-8?B?bCtZZFFmVDNMTWEyRUJTVXV5allCN1JPYlh1WXFQbTcvZGRaZUxUK2krenFQ?=
 =?utf-8?B?ZDY3dEducTdBQ2U3VlJTOHd3YmJyc0VHZklqajJIeGw1UHBXZDVmTTNqY1Uy?=
 =?utf-8?B?akxqdithYUxRalE4OHpadjdOcUpjaTV5MlFjSzlaMW5GcXlUQmJwWWFWUDg0?=
 =?utf-8?B?ZWpXb2JEZk4reGJUdGRLQ3dHSXcwN2Z1MzlHUkd3VzZYSGVQRUZFOG5LbzNZ?=
 =?utf-8?B?K2g4d0s2Zy9CNmlVc1U1Y0trbG1sL0o3c2JXaXNucldVK2ZJRGRFWEVGSnh4?=
 =?utf-8?B?NFFNcms1RTlGdmRhcXVEbE5sZ1N0OGNKcUNER2dtdUw0UUtiakdyUnhoM29j?=
 =?utf-8?B?dGRjRGlYdGIyWVF6M0VPUGRXWWtrV3JsUVVKQk9zVGtqZ29yd25BWVpRMmJ3?=
 =?utf-8?B?WUNuSEpCYUhQaW9DK3diTWdBTHVvSUkwWmNaRjlOb1k5ay9zeUdGUUFRRE1v?=
 =?utf-8?B?RkJsdTJyVzBwWjdZdE02S3ZzcE1qOU1Fc2N2ZXVmWVM4Q3gzc0QveXI3ZVpv?=
 =?utf-8?B?aDhGLzBDUGlyYlM1N3VZOFdLTklQQ3BqU1VaV0J1R1hvTW4xRXNoY0RRVTNa?=
 =?utf-8?B?Rkp1RStQYy9IbEg1T21zaVRGR1ZySGVrbEFaTnN6dk4yU3pzQjFwVHNXYmNi?=
 =?utf-8?B?SnhRanpnTGgvZk5HT2tQZERjNFB4T3dxZ2puenEyRmpMQitKYVNSaHNldTkr?=
 =?utf-8?B?S1E1c1F6aFozYVNvMkIwMDJBVFRpYXI3WlU3Q1RIZFl6MHBXODR3RUxmaExX?=
 =?utf-8?B?Q25IdkROSmxoVEtlVlhEd0hTazEzTndvQlhzSU9xSnRTUEFGcVJXNE0wTFRP?=
 =?utf-8?B?eHdLZGlWak9iSUQ3QThvYjFCQUJvRTgyMDVhUjY5a1VDRlBWUmJQRWdaSVE3?=
 =?utf-8?B?ODN2MEFMK3ErUExYTy81TUgyS2hsNy9NVjJNdkthbHRNaWFYRnRPTFRnQ0d1?=
 =?utf-8?B?UEJrS3JRUVA0THVGSGpFUDFrR3JFWUcwUVB2VFhDMWZJMjFTUUpORThiMnQ0?=
 =?utf-8?Q?PC1l7C9NUteCT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWVWNGhMN2Y3eFc3RitLR2lTRDk4bDA0d1pvcHI1NHpYWW1DR2o5Sk9tQ0tR?=
 =?utf-8?B?cVFoQnhzT1BWOUsrTUdhTTV3SnUvV2ZaSGtZR2d0eHNVSGNmYTZ4TjJTbXo3?=
 =?utf-8?B?MUNiY3IvSmtEaDVRMHlzbS9LYjZIQ3ZDblROSmJWK0dTZU1FcTBCRGtYbkc1?=
 =?utf-8?B?YWFhRnp4V2ltUEsvNmNnMWVsMEhjNTc4RnZEZTlHWjhzeDZzdUZVTE9RSzV6?=
 =?utf-8?B?UWpBZXJNOTdaZ2dVTVVZTlBKRE1JaFpqZXJXd0pkRVk1RzBMYkJiNFpZOWtF?=
 =?utf-8?B?MWFhaHBGYXZ0clo3QVIyL0tDRXN5SFNPM2h1ZGY3OHkvWFd5VVR2bVVXREtp?=
 =?utf-8?B?OElVaWpjTGZpOXN0eVBhaHVMRnRKbVdZWTF2ejFzeXFpd0JJcHd2cldCSVdC?=
 =?utf-8?B?VCswUGtPeGs0QkJFdVRoQ0V1Y0NaY1BGWlRQdnlpNDFhSlFjY2hnaUdPT1Qr?=
 =?utf-8?B?bkovNkFJYnNSdWNHbnBtVVFrTERDd0dZQmR3OGk0QlBPNHFMdkQvV0F6NmFQ?=
 =?utf-8?B?YURDZ3prR3hHVnZXc3dJbFhvZHI4Q2lObmtqcFU0ajFqQ0Z2RExGdlZsbjA0?=
 =?utf-8?B?UVhTclBieTJUR2xnekFGcUNWWjZ2TXhVbDFqWnhaQmVDSTNNdXR3b3VEM0Er?=
 =?utf-8?B?UmhWNDNxeEQ4a2xQcDg0Y0JkMjBrVlJOeFBWVW1nbG9vRkQ4RW51ZlJCRnJu?=
 =?utf-8?B?RTM2Y0RTUU9kTk9CRTYrWDJueUR6S3VDc3NKT05DTE9IK0hBTUw3Y0V1SC9O?=
 =?utf-8?B?a3dseXJ4dk1kc3ZnamhwVEE2cWI2bzkweXZUaDhtdHVvZzFiS1BmTG1EYVdi?=
 =?utf-8?B?STJnNFB5WS8zejBham4zY2xVM1pCbU42bUR6eUN6cGVwcG1JM29CNXRqS1Uz?=
 =?utf-8?B?aXBPYjdCeUlwNStoY1YzZnhFY0plWTBHMHlwU29ZUXkxam1DWCtTWmJqMlhr?=
 =?utf-8?B?MTJUWFhBajczWjhiMm00QzhWYVlvVVVBU0t6SjY1Z2ZEKzBRemZTMStLMWhX?=
 =?utf-8?B?YmJYcEh3OWVOQXZzYkluZG9aTGh2R05QRFo4UDVsc3p4TGh4WUdDR2JIeEJk?=
 =?utf-8?B?VHZWdU55RHdBandJazRGeXhaWVNnSDVteFhPNko1S0RYRi82NWE0d1pJTncr?=
 =?utf-8?B?V2FTK0FQNWN4eU1ROERDTlFLL0VVZkNxSjM4YXpJSjVVUDJIM25uemI0S3pU?=
 =?utf-8?B?a2wyM3hPRkFoZ2ZIUlQxTVlMeSttS1lGUEhmY2VZbWtpZEdyS1k4b01KTVB3?=
 =?utf-8?B?SHY0NzJ1enFPc1NFS0JZZWpZcnZtQ1QzY1Uxck9YV1hSMnZnTHBnMWFMWk5O?=
 =?utf-8?B?Wm4zNnNQeFUxemZVTW5qYkVWTmwrYzZRcmxDUDRWd1A1OHFiTWhPc0tYM2lu?=
 =?utf-8?B?c2pwNGM5aEo1c1lubXh1UWozWFZEUFplaGg1alk1L0VncE9nelVrQkVtd05r?=
 =?utf-8?B?MmE3amlhSUpsT21GeFREaXdrd1Vrcnd4cnc4VCs1L1lGREFQc0M3Wk1KSVMx?=
 =?utf-8?B?M3pHZUN0MEFnWGMwWW5DM1g1UGhJSFViT0lXblgvOUpqR2M1Nm9OVkg3dnV6?=
 =?utf-8?B?engrT3FiUVgzRHFFeGM2L2VsSnlzbU5QTHNySUxOaERKNlZ6S1AvMVZFbHhK?=
 =?utf-8?B?WDNmZXNkWXlodElld25IZXlLSUswYlM5Um56R2hzR0xFdHVUcjROcnpNdmJN?=
 =?utf-8?B?YS9vUFFKbEh1VUhzRWErczV3WHFEdldkdkowQVlCUHh4ZEQ3ZjNyWitvcmhE?=
 =?utf-8?B?MmlTSWJSeWtVaWI3ZUdJanJIekoxVWNIWSs5VHNKbHREWVpvNmhRRDhVSXhD?=
 =?utf-8?B?NzExU0lsTkNMTXZOWGRpUUY4M05CZHRXS3c1MU9OUW9VZnc1K3kvWW9oNklJ?=
 =?utf-8?B?cVl3RkpvZFhwQjhUSE54Tm9FcisrRFlEUCsyd2dBRDlFZWdMRHNLVFNMMmhW?=
 =?utf-8?B?R1pZK3pDV28xN1gzdUMrcXZDdUpKdVBtazZpTUhpL2RXc2FFajhOSnpyajNa?=
 =?utf-8?B?cUdTdm5tR0pLUHV6VTZtaTJOVndDZk9nc3lNR3lyRzRYaUtIb2Y2ZG55cVVm?=
 =?utf-8?B?MnJPWGpSaU41c2NhZmsyM0NqbWhaeEtDcjkwZ25Zc1ZHYW0yaU9hV2dwY2JD?=
 =?utf-8?Q?mn/H3x5+uQDxW2UcP16jxMibW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d209d0-5982-4a3c-7811-08dc8f0a9163
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:17:53.2471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkN85sBbzMxJopQ3Xs6+itDiq2dAuoc2dmKKDiVFZLqrCM7JSwDDxczx9jvgzNOjxGdnM6bY3HFXs0uJupFqPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

Consolidated redundant if-checks pertaining to imx_pcie->phy. Instead of
two separate checks, merged them into one to improve code readability.

if (imx_pcie->phy) {
	... code 1
}

if (imx_pcie->phy) {
	... code 2
}

Merge into one if block.

if (imx_pcie->phy) {
	... code 1
	... code 2
}

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6e3ac3fc33745..ab0ed7ab3007a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -954,9 +954,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			dev_err(dev, "pcie PHY power up failed\n");
 			goto err_clk_disable;
 		}
-	}
 
-	if (imx_pcie->phy) {
 		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");

-- 
2.34.1


