Return-Path: <bpf+bounces-30779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C558D24FF
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3E328EBC0
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952E17F391;
	Tue, 28 May 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M5Eg3D5e"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11617F38E;
	Tue, 28 May 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925228; cv=fail; b=qdamRBYRLe0zYKF6lxrdPH01AC1Ujr2q+nGygMXD/B/+4bULBG9VEwXqMS4AeHvGnZdk3rjL8GE/fSCmR+LB8kcgCZPEIfAzIhVB4V0mPwQsxciJ4JZS4/5bZWrBJ9/9T1lLADl4Bz0KJCEu3JNBHec4qaQnZFK81fTzFCUR+8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925228; c=relaxed/simple;
	bh=rdBX9SAsLGGVokztvn5vz/ebdrIJ20HWryji5UtWJnk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qTHhn5TZs8lcvBdIpSk8bUOuNXVSvhjc/NGg+sSzIciLujDelV/Ex8vO6sLqFYX1bj32+zu9nZivn0IhYI0xBThYH5L7e0y46zSY2YS2ekBdLl1zupwH1PXiuVcgM3cMt308yp9LlO3x2+Gtogyn/WhjxmibX3+MQefc2wgJ7Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=M5Eg3D5e; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljZ6c0NqyRbcG+PVpzMDWIYlKZRPFlAee8c0u916uUI41qFEyZpBf5qSn3vUHxDvS64v+XyB//bePVtAucLnPeysx3JnyBzFVuGLEuGn4L+P5dXTQN2uBc4XweOjBhxk0BVGxz6/lifPjgjT7aWOCu9dTPZCu5KBUvzZ7FRllU6Q5ZnnZ9bhxjW9kPHc8SH/UNB4u861lRCmC8SvG8mWo1fp0IRKLYkH96VB4HEnolKwsx+P5fxXKpWmZoQt16YJq0HY5QQm7BZQWAo+2qqQuTaf4yhZTNnkuedJTltNZ2w8YLviNY63xUixLUmQQip1wqkmOY4Clz2/hWyiWcl+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MbpA0y8LU8HRpju2DUmQSRJX8UDOWjSKuL8l04o6lQ=;
 b=P54knbKrJLT2e0rI9n4yTrrKPpS974E1DyvFfvDT1wZGMJy7hdFNdM3FDhr5SdFFTvODuBzz7c5OZeaL7JJLBHrrTxHex0PhgEfX1cYVQc0wUVZgVWpFcaupjN6xZ0hoI7LyzYly5nCEUhWgaxmJiHNhi68inogQtt4eRD0qjl3mTd5mVB6AdKVot9Y2Zd2VtVedMbVgqDb986YaPG37y2yoJdkOpO/InOBsB3Cqz5I1j31a81H8G6Nlxec+4y21d8fbSH33ErApTiW9vBpC+2FM6H/pdn19Bx/xnbsthK5sgWSPUle3Uawqudkl0X+GKcDas84txwG7PYJ0UbjhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MbpA0y8LU8HRpju2DUmQSRJX8UDOWjSKuL8l04o6lQ=;
 b=M5Eg3D5e3imO+nqkAeeRqEV50UvAqHIfjqlk+ObKAKNGc9P8XzWrIpUPdDo2sQOx7r8Eu9/HOMUJ6mJR8NScvlSU1yhfg+/crGXd5VxMdH8BMZRdTkAiMHS1vk07sqRrN0/sI9+WwPU/beAMh1xCMVcps3Pj4BRKDpCeVoXvVuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:40:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:40:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 May 2024 15:39:23 -0400
Subject: [PATCH v5 10/12] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pci2_upstream-v5-10-750aa7edb8e2@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=1356;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9ZkdHDkA+jFfsgNpx5r6KX8wuw07nzBbE/IHsRQRYtw=;
 b=ATTTasnX2YyZwjZgfC2m0blhrkHyfy34FsjGOngfdH1Oh4V8ofrVqFw8UoHrF3hBiRLbyn0Fw
 cw7mFkCyUCfDrB8SqG0pFso4IRnQOhKBzFYqDPg7Zhe5p87OgWHAzMw
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 1294184a-b1a3-4b51-3a27-08dc7f4e0499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|7416005|1800799015|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UElVK0lMeEJrbEhzRG04Y2RxVmtqWk1hZlg5R2d4dHYxQUNGVTQrS2JHUVY3?=
 =?utf-8?B?WGQ3ckFFbHhyNDFXSkIvZ05Qcjd2VE9aVCtxNGlSSFgvWUdZQkRWN05TcUlN?=
 =?utf-8?B?T3dWVzhra25TYjY4QyttaHc3cWkzQThndHJkQnNGaFB6TTc4TCtQUzFXcE12?=
 =?utf-8?B?emtBaHNCUXJ2MjB2OXBSbzJNWXQ3YjhBNUw1S09yaDYxTVhBTWhnOHB3ZHVx?=
 =?utf-8?B?TUNhb1VucmxLa1h3OHhKR01lQ3ZFWnJCeCsyT0o2MjBHY1JUYUN4aUdodnZw?=
 =?utf-8?B?ZVEzSkFBWldoRDFCVHh2c1NpVUxOVjl4T003c3Vpb1Q0YjYwYzhIRng1L2FV?=
 =?utf-8?B?RFpqNDRKUFYyQmIxMjZBRkt3anUrbXRGSThkSkk0R1NhblQ2RXo3YWNXVlZ4?=
 =?utf-8?B?Z2MrOTNCTGxnRnRIQmpadTlVdEt2QllJRmYyeXI5VUVCVlUwcFZ6dzZiNjVK?=
 =?utf-8?B?MWZjeHFzQWl1Sy9XRlE0RjluRkxFQVVZak4weWpRTmt4emJjQVlIVFljVlp5?=
 =?utf-8?B?eVQ0bzIwL0drUE9NNjBBZFpZeGU0RnBQajFXcFlsaSthSEE1cUl4eWJpUXdp?=
 =?utf-8?B?c3h0SjE0VmNXdmh4eDVKaUNvU2F5M2xzaURKMytrOGJFODVOOVc1N2FCaStX?=
 =?utf-8?B?ZHlhOVdWQ21sSm9lSERPVjlteDgwRDE1UWZvQ0FXMWNMM1NTaEdWN0Y1Wmg3?=
 =?utf-8?B?NHlQQVpuTUgzck5jbUFGZFN2RUtuM3B1L212MjM1M2RFQnFMSit5MjcyejVy?=
 =?utf-8?B?OVdvTHJURHhNTFZ6dlU1OC9qbVF0MkRnMWVHTWxCZWZ3SXFibVc1bE5EUWdD?=
 =?utf-8?B?Sm9hN3VKaklCdVQvdWVpazE1cnZWbXAwWktNZEw3TEs4ekUwYnoxVjVVa2pY?=
 =?utf-8?B?MllBRUJQU0IyMWJzaDkwWTdTQlVnb3JMVnBVT2VSY2txNUtTS3pSWC92eVNG?=
 =?utf-8?B?bzhyRlE5QU4xNU9lZUhtSXJndTFKOEx5bzNRLzJaclFmZkh1d3BJOENtdlIw?=
 =?utf-8?B?aW5JVmVURVFXN2lwMlpYM05LSStJL01pdUV2Q0w2Qm1HV3FUNEhBN29WWmNs?=
 =?utf-8?B?TFNaSldMZU83U0FrdytZYURqNDFHZFA1RDR5SGh2OXhNdnl5aWg1TmZWRTlX?=
 =?utf-8?B?T1hINlNwRVFBMm9tMkxtUkptSmMrR1RvNGNvUFJqbklBa0p4VSszNDIzQXlQ?=
 =?utf-8?B?OGN3R0ZFOFhGdE5QSFdnTnBKcG1pck8yblI1TGV5Q2lkWkZTY1V1Rm5ZRk5J?=
 =?utf-8?B?YldVbVBvcnRkbU50a0xaY3AyRngxanIrUFp1dXJlYnpFSHE2bEowNEpEa0Ra?=
 =?utf-8?B?eDFwREFpVVRoY0NPTFZuazNvc3JHTlV6VGJpR0g4K1RsbEdybUFmYkFITGU5?=
 =?utf-8?B?WCt5R2kySlpzNFI3T2N6NExSZnA3dWdUZUlyZTdjSW1xanh1bWEzWnkwRVFn?=
 =?utf-8?B?U3lVRytqVDcxZk1mSDhZNitRSnM2emJxYk4vcXNxc2JkQTVnbkxyaGNTdU5u?=
 =?utf-8?B?ZDNZWHcyUkNZOFB1anBRbVMzNFU1eDNaQUNaRW9iSGFXeE1JdlpYTEJPWHN0?=
 =?utf-8?B?VmxhME55UisvbHcvd2RoS0N5ZkdaYlFQNkI0N3lHQjIxMjJvelRzQmlEVC9O?=
 =?utf-8?B?MXpmTWhzQW9Na0RZZzVqQTdjQTBoaTNzNjd3V1BoT3JZWkgrMjVHeXhtdWhm?=
 =?utf-8?B?MlhzVDNIa09odHkxbHFlbU1ESjNaVUEvNnRkb2p5ZWVrK1gzdDlldEJpMG9l?=
 =?utf-8?B?R2Z5bGI2UXVhZVBSeGhiWU56aGxBTXJVUkovOW1kMHh1UEJVdDN3dEg5Y1Ur?=
 =?utf-8?Q?VjrmQsxeSggCNj26RBqBo5i+CfBVzPf97jn8g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEhpRG1pQnhjb3NoTlB6SU9JQ2ZiN3JNc2JDYWwxMTFJeExNclUrSWE5bUtH?=
 =?utf-8?B?alVTMEw4TUtKZG04VlJHdlBoYkk2Z1dWQWYrQisxeHU3ZysyRVJhNEQrQU9h?=
 =?utf-8?B?ZjVwcThXSVpWb2QraUVqcTViMjh2TnJ2N2JkTmZUcnpsNmRIcFFzc252aFZo?=
 =?utf-8?B?WWpmZUdaSVJ4YnJ1bkRDbVlKamNzMndoZ0gwN2NCaWdpOVZ0SmJ1Zm8vM1R2?=
 =?utf-8?B?LytyU1FLR0ZhZzBQTVJaRnY1WmtIQ2M5UndLWUNqSDBXWCt1dnFEWi94dXBv?=
 =?utf-8?B?bUlaSm1KNk9PdHlZSHJLZUZ6Sm56dG5oWVFHSGNYbk1EWjQrcVkraU14WHNS?=
 =?utf-8?B?MXBLS3dnUFdBWWtvNUZ1M3FXOEF4M1JqVlJ6bHhMV1h3bHlEQ1dDK1RJa0dP?=
 =?utf-8?B?bno4eUFwM1JNVEZpcVdsRkhrcEdSb1JLbEo3TVhncXJHVHZPUXducXdLeGJm?=
 =?utf-8?B?cWJzWnptWU9CdThtd0N1Z3cwVG5pVzFhT0g1blBOMUxXRHhrZE1kRjM5cGhs?=
 =?utf-8?B?TEdtVHB4b2dYY3dPN1VYOHk0YXNZRndDdkhrN1k2dzd6bzRkSVBDdGVyeldo?=
 =?utf-8?B?ck1ualFyazVYT0J6UGI4YnJ6UStDaXZmRlBKQ1NuYk16a0xQVmFUNTBCcmRp?=
 =?utf-8?B?YTF3NU0xQ3dGekZJTFNkSTBjODFjTSthRHFEQStuUkplTFdVNXg5ZDIxR1Jq?=
 =?utf-8?B?VFhMNUFZdmZhNkdJVlBycE5UUjhhS252bitGWFM1UXVQNDBOckU0bTcyVkxP?=
 =?utf-8?B?Nld4cjc5TElCUEtlNTF3OGZNbTBQb2R4TlkvWk9GYWdKV0RQQTYvZmJ6cVNY?=
 =?utf-8?B?Sk1QRjNqWDVmUFc2WUppK0cyOE8vZVhBbG5IZ3dNT2FQRWFGUnBFOGVMRGFu?=
 =?utf-8?B?N0ZoVFk1R3U3ZlZWODN3NzBxK1RqM1Z4dXNrUDFVWlNWR2xLQzE4T2tMWlRa?=
 =?utf-8?B?Z2RrdllvSFUwMUxPQWdZd1F6Ylh2SUN6Qm1EOHl6dTUraG5idWxDUDRIRjBB?=
 =?utf-8?B?SjF5a2ZNQ1VyV2NlSWlselRSYSthdE0xNEhicXpINlNYd2E4clZVdm9lVWtY?=
 =?utf-8?B?TjJ4Mk1uaitEaGIwZGtFQjdMSHdvNUQ0S3NuUEIrVkRpK2JUb0NpUFVHOGM0?=
 =?utf-8?B?R0lRNDBlNU9xWnpaZnM0VXUzQldMaXRvZVU4UUZxNnNOWEFTa3V3ZnJjN2dP?=
 =?utf-8?B?WTF0RktBWUxQQWtGMEtrK2Y3Z0FDbFE3RXA5d21PcmE0dnltTTRySjBjVGFD?=
 =?utf-8?B?VXRpc0pPMGNFMmlaazl6QWdiMlZjcjRTemxKeUR1ZTlScHNUR2ZKQTNVL1hj?=
 =?utf-8?B?clRRR2puMkl0Q2NvRzZLODNwNzNnY0tqRVBRbkJHeWhmejQ2TkFVL0U4Vllo?=
 =?utf-8?B?L0hnb2UzQkIyNSszblJxM2c0cjhxc0VBNkhabzRFdUlBcVRMN3JWUmx6QkMr?=
 =?utf-8?B?STZjdnRySnloOE92VTRqMVdNYkJEZFNKMkxqR0tIOVpxdmZ2VmV0VkxRTGdq?=
 =?utf-8?B?T2FwaENwbDU5RFNhUzEyWTB4S3g4bENQQlZPU0JIakpvVUo3bFdnMktSNHhX?=
 =?utf-8?B?N2hLVzJXK3FjVFN3RlFIRklsUENZRTRoeW1nUGxnemN0ODhhaHN2c0pXL1Zs?=
 =?utf-8?B?K0dlMDFaRlczcWZXR1p4R0RCSEZWU1ZmZ1JvSEgvdTJNMzN3SzR5d0ptZmVI?=
 =?utf-8?B?ZTh3NVlXQ2FzT1lsRjl1bmc4cE1HbFZLSlNhditvcm1PbjZmWGE3UVNoTXZ3?=
 =?utf-8?B?ZC84NG9pMXVlZFB0TFRXWDdvNlFNM09lamd2c1QzK3RuZUhtNitCU21DNTFR?=
 =?utf-8?B?OWRrQ0U3V2xpMUdIaW5XM0h4OVM2bDJXMHdWNTRNaUFZVVNaTFV5VmRNVS9u?=
 =?utf-8?B?WFc2aE1IQlN4OU4xalQ1TVZ4UUUxeXhuQ3B3RGhBdDA1c05BaFJmdjBhKzgw?=
 =?utf-8?B?bHRoUjRLQ0lXV01TMk42dG1GOVgvS1V4Zjl3OWxuaWdua1dGZFJvUUhpNThD?=
 =?utf-8?B?SXEzRUtRNjVzVXNHVHVWU3Zud09qeURkVHcvZ2tlZkNYVDlJbHVNbU5CSURZ?=
 =?utf-8?B?K0krc2ZJelAyb2lMYks3aHFZNDhOYlRRUWRNc2JpQnpSL2VzR0tabWhPay8y?=
 =?utf-8?Q?Jg5M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1294184a-b1a3-4b51-3a27-08dc7f4e0499
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:40:24.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFmwn/pZL7y4L9EqXofeIMIXX4HWxGjtVqVXttFotUiTPQT/4UC/3mIdW87bUqb6HY3Rgtg+Y2b2p1mGWCBKgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings. clock-names align dwc
common naming convension.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 8b8d77b1154b5..1e05c560d7975 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -30,6 +30,7 @@ properties:
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
       - fsl,imx95-pcie
+      - fsl,imx8q-pcie
 
   clocks:
     minItems: 3
@@ -184,6 +185,21 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8q-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: dbi
+            - const: mstr
+            - const: slv
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1


