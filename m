Return-Path: <bpf+bounces-40603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F134098AD16
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DAE5B219D6
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 19:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E36199E9A;
	Mon, 30 Sep 2024 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RE+AiYdD"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18515E97;
	Mon, 30 Sep 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725372; cv=fail; b=vEdaEdzwOQzhVNIYnkuZbXOLMCZKWvMSndjGVA8HXWKtoZg6r3sij69XyF90UghNktoVubtPrqTXcnh1iDL0C3/mcug1hA/hnU1WSi1vCn6W4S+5a+quF8s8em02/s+6Y7BLgKHb9AmCGP/UBZjE22vZT6h8gRkIfibdQtjwrlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725372; c=relaxed/simple;
	bh=Yh64Qguo0ihgOvh0poTbix/udsCMkZDBgeMS9aYupgw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=A6RIqRmcojhSCxNft5o9IvBKQ442HuSWjlalI1aF/jRNQekxBB4zid2dum5m5EbNuN23RDfIO3+nzsnvrZeiH0lEpXiTje6mq9s5pYf3qKOXPELi/bdRlzLu7p/Nc6Ex22ytntTUbgWWsvOCH+QYrQx49FldM484FdBZURyn5iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RE+AiYdD; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxn78VSMBZHDM2qrH3/vhlCvbqdEHStzGtbAc97V/Ys/ELgJTis9vIQ/hVsXhcXSOSM37YPH64Hi67cdB0c1oLIbwsQBiKOywe9oy9ajRjeku0iOGJDrVeizkgOAWtbiwN2KdEgM35sSJI1S7N32uNY/F60cD8UifYKqvrMPaxzMgJE4rRGmnmCs6jQi+lPx09e71WbFMWvlGhqNwGqQXiXvY4nd1zXney9AezkQxV2SGef1jr3IRB88nHWkUsPp/a9Jj9ELetYrR7f6BxKNDe6rT4Yd5Nfb8O+0P2D1b+fz/OH+XvMZgoNui/12fJcVOThFaMq0kNPvsVpWfAE1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o14ZWgVuo6zwgl1KXXMwtBRXK9B04Ouz3nJxIkhC6Ds=;
 b=h7Xw2yu845WggyCHhIDqjfXBLKhL4FNpQ9qcKP+51E2tE2/ggkvq6kn1i+zdriGwVWih3d4atyvh3DyWm/uxoT6Z8AQ8/OfWcY1U4Nm54gXT1HA668FmQ1a5U8IKiczWYSJuzVBJlxybbCITutSLg6CYqjZAcmZMJE5arPodnyyzD8PGO//FmddSuxU7lhaRbieNoFy2JsxBteN1m75c4CKOv3MuUAi+FXb9PiB5S7nSTkz+gKoreaXbiJ+gY7gJwaJ+4UBb7iKLH33Jjr+k6IebfWfczmggL0/jEwtB0K6Y/KcutgKNaGy1ik++MQqlrZn+k5xhZM1E+/DulV2E6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o14ZWgVuo6zwgl1KXXMwtBRXK9B04Ouz3nJxIkhC6Ds=;
 b=RE+AiYdD+frGqxgF8b9tKTEa8osDvQJlwbkGVHsYIf+gx454Y3koeVoCYgoXiNw2EL9XU/4gvbOk9pNwjAd2R7/kHZ6hKk1WDwRYkba+nlWbKTjYUnSX2X390IUZVP5XRLb7yo9yqEbGpYdcheDYpOiXgueeav+4QIMasrKW+/7bFPTurKlIzn0zQR0VBORgUtQEAtqB1kXSKRcrvK37sLIbkQUzrFpdQvsKBX375Ge+3Z4sWMKcxCpe7Pm03wr09hF5JF0iWoJeSHFMXvPNLHui7hoblzIQ6TI6//iWnQPKN9DyQoNMrhPW8kumE0QvTWKCV+cITdoW2eqxf3ZkKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 19:42:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 19:42:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/2] PCI: add enabe(disable)_device() hook for bridge
Date: Mon, 30 Sep 2024 15:42:20 -0400
Message-Id: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABz/+mYC/23MQQ7CIBCF4as0sxZDJ4jFlfcwjWkB7SQWGqgE0
 3B3sWuX/8vLt0G0gWyES7NBsIkieVcDDw3oaXBPy8jUBuQouELJaM7qdH+9V9Zq2SGi5UoIqP8
 l2Afl3br1tSeKqw+fnU7tb/2npJZxZriWyLuzGYfx6vJy1H6GvpTyBZk9vCegAAAA
To: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Frank.li@nxp.com, 
 alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org, jgg@ziepe.ca, 
 joro@8bytes.org, l.stach@pengutronix.de, lgirdwood@gmail.com, 
 maz@kernel.org, p.zabel@pengutronix.de, robin.murphy@arm.com, 
 will@kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727725360; l=3205;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Yh64Qguo0ihgOvh0poTbix/udsCMkZDBgeMS9aYupgw=;
 b=B9KCpyiLnH0VYc09V5SLpkcGE8QaFQSp/wsGfLNNX/qMFMQ/b7NxrmYyHaBtzqI51NFDypAho
 AcM5nHYyA+TAIzvcDUs1DZ6Sa2Fy6n5qUcn6ZXb15dbFeoHd1u7hizd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c1647c-e6fe-4fd0-3e48-08dce1880f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGRudkRrQ2NGcjBGUmd2S1VMcktHc0s2ZXNMT3RUQ1VZZm5tMy9tMUNqNm5x?=
 =?utf-8?B?bjBQL0V0K0JIdXZ0WGFLSCsrM0l2U0xFcGMxYXR0OUZOL0wrSUczVk8xNU90?=
 =?utf-8?B?NCtZSmZ0UU9VTDN0OElJWllXOTVPSWt6NHkrL2w5QUFRQjBqT01sR2J3WW5o?=
 =?utf-8?B?WjEya0xuTmxzcDZrZExBTnJESzFCUHZpOGs2VE51MDU2d1lRRk14Wkg0bUlH?=
 =?utf-8?B?cWR3dXk4VnlLTWlFaEkwbUt0VWpSNFJuTzRiV0JYaitBcHByR0t2cGluUXVy?=
 =?utf-8?B?TUZNQ3NYMkNMZ3lKRDhMMFQzc2lFVTlYR3djcFZZWlRwcjdOYmhZTmNKVHB0?=
 =?utf-8?B?ME1LdHc5RVgvcDk3Mld5MmtlWjFhakJxdndqS2RWYmFlRUM5akIzQTBiL21J?=
 =?utf-8?B?RjZBc056NzFOSlJmT1ZQdjZ2SkFKaCtETUE3REdyREwwdExTVlFVS0ZhVEd5?=
 =?utf-8?B?UkRIa0Q2Zkw4ZGVBK2JGamJicis0bUkrOVNkSWZUVWJxTEZ1SVJvUWg3a2NB?=
 =?utf-8?B?UVFGYXg1Uk9vT3F4bWRCMEZXTUZTSTZhWFhvT3dRaGoyakJBRkhqUEE0WmNP?=
 =?utf-8?B?cXQ2YWgyZGlyTFhWSXRQcXV3SGliOEFvKzZ2WjJ4VktXZjhJWktqZ2NaQXc0?=
 =?utf-8?B?T0dFTXRTYTBka094U0dTQUZrcjV5OU5GdUVQN1ZaNmhGSmJOa0xSd01lODRm?=
 =?utf-8?B?K3NPcEZMdjJOVEVkdExYZE1mcEQ5cXVpc1h5NURuZjhRVkZxM09WMFBxbXBZ?=
 =?utf-8?B?YWQ5ejVZNmduY1AvcmluRFpYWURoUGYza3JWSENTOEFrUExqdElXS2ZZbDFG?=
 =?utf-8?B?SlBuRVAwSm10YTRtQjFtbFN3a0NWYjNLM3NYQnZaWG9EdUdBRGRmVTJtU2Jw?=
 =?utf-8?B?OVZRQkZjUnVPRDAxSlRDZUNCQ2l0RWdscDYrR216T0NybEVzMEJBZkRGYVdN?=
 =?utf-8?B?WnFWNnFDODgvQXAzTDEwaHJ6ajVDbVlJOVYzOElBQUJITUUyODM2MVdialZS?=
 =?utf-8?B?Y1pDb0lab3JvUEZvMTJHVkYyYTBtM055K1FrMTJWWmVOMkpEaGRkR1ZnT2Ir?=
 =?utf-8?B?M1BnNkxHV1M5QWRkYjJ3Qko0SUhPYUFxVlBVZThHd3RvcnpVald3RDc2eUk2?=
 =?utf-8?B?a1dQUHhVemJEWlJyWkkxZHpxMjhIMDlOTDhHb1MxZFo5SDRqU2x4SWM3MEwx?=
 =?utf-8?B?WDI2MnQxdGo1ZG9rUXRmOFZ0SDhMbWlWUTFZUHZaSnMreFlnQzRhT2VLTWdn?=
 =?utf-8?B?aWN6bTNEZTliMWVPRmRpcHpxZ1pkVHprcHpnZE5LRUpkVmcwM2RvMUxBOHhD?=
 =?utf-8?B?c2gvYW1TRHlqb1FvVGxURGRrSjdSUnpPalZvSlBRcURzN29qUjJNVnFtVEkx?=
 =?utf-8?B?QVlqNDVkV3pabXYzYkMzMTRvWGsrRWJpanFVdEF2b0JEb3NIMVRYdXRxbTVE?=
 =?utf-8?B?NU00YXdsRjN1Q0tEcm5jSVVCWlpqTDNucVNMR2J0M1NjQklWY2tkaDdTSTAz?=
 =?utf-8?B?QldpYUl1Q3Vkd203V3NHMy9oZWJVSWRqOHdtS1JKeTYxWWhQYVdrQm5uN1R3?=
 =?utf-8?B?VVVZM1NrZk9jSUVEK0xLR1p3NG9mOVozV2MxdlZBMVZoQU5KeU9NREx2Tnh3?=
 =?utf-8?B?NGFLSVk5d1dEbWV1bUIwM3Y4MGx5TjFBY3pHV2poMUtiTFZJM3RYNDZNaFhJ?=
 =?utf-8?B?UXUwMm9iZVZsZGtpRnVYL0EzUkhOOTRNUExzZGRwYXVkeG9NbHB2U2FhMHh4?=
 =?utf-8?B?a1ZLUjIrWkRWS25xYTRKak5xSmk4bmxJTmZLTkY2TnBYekZuMERJTjE5TWJ4?=
 =?utf-8?Q?6zAUaDeJ2r/hpk6ThH+t+2vdfM5IyzSP1S9Uk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3NSQit4enNmL2JVVWNzN0kwRGo4TXVpTDBURGUzbFVZeTBwL0RwZVR0NmhO?=
 =?utf-8?B?Ky9OcmkyeUo1clc0UXlqVThCK3ZjbXR3NnUydXF6TCtMZHlQamEwTEpoZkEz?=
 =?utf-8?B?YkVkdGtiUVpON1JRTE1XN2RsczBtQjhzQU5RalVYWnBacEM4eGZwaFBVaFpo?=
 =?utf-8?B?NE0wZ1MxOTduKzc4bHAwcU8vNVJvaDFzQ2plekt3MGRSWVJwZE9yVDllTjdi?=
 =?utf-8?B?NC9yeUdOZ01GNnVRM2hkVzRvRm9WWURjRkhlMG1SdEt6Q3NmMkFrOERlOWIv?=
 =?utf-8?B?QklrNkNNSmFUMDFibGRPR3RLR2NXQXRkdVcxTW0vWWdaQ3BqNmN1aUdVS3N4?=
 =?utf-8?B?VGVRVmUvS1dmZVhBSkI3TW5tRS9nN3hmVjArOHFmSmZkeDJPMENXNUJzbjUx?=
 =?utf-8?B?S213MGZJd1QzeUJUSktTMXFDNjVYQzdDQmMydmZtOUpwM1IyU3VpeUtaeUc4?=
 =?utf-8?B?WXlGd3FuZmVVcENJdi9ncDRuL0hWdjFTY0M0NTcrRlFtbDBsWmxkQVBUTExP?=
 =?utf-8?B?enhuSVhoZXI1dk1hTDQ4SzJmaUlFVjFZMy9FUUo2S1RDbEs4SUxRWnQ4K1hK?=
 =?utf-8?B?eDR5OVc1TTNDSUtHVkFoVEkyZm1qZGhKdXQ2QUpFbE5OVHREMmlWYStDcmxy?=
 =?utf-8?B?a1VqUzlyQXA4ZkxoQWE5TTZiWHgvZVJYZS9SY3dPQ2IwR3VXWkNqK3BkcFRx?=
 =?utf-8?B?dm1adlFFQ2x4Q2xGVFFQcVNDbE1IbWliK1h3NVVUSkN1YzRMejkxUGQ1dGVj?=
 =?utf-8?B?VnkwWmJyVkFTanNCc1NwTUE1NGI3ek5hNjk3T0RqNEkzSzVWSmUyQWhHOTFV?=
 =?utf-8?B?NTZlelNnUlRkdm94V1lyRE9zTHd4NFI3NHM3VkFLYUpzZVFtMDZOcDkxdjNt?=
 =?utf-8?B?TUdNRi9OUkxHZjllbzhyZjVkNG5YMTFodGllRUxmdi95T2VOOS9vTDZQMzF4?=
 =?utf-8?B?RjB3cmNNVE5MRUFyN2YwaVNJNCtVdFB5dFJGSGRWUmNkRmJkZmh5eU5Wdjl2?=
 =?utf-8?B?dy9kYkxROW4wUkZVa2JDVXVUaE5pL1lpN2hHWHpoaWVYQ21BSVdjaUdob1Ju?=
 =?utf-8?B?eWUzU2lUQkFwWmJtR00vZ3l0V1JXdkZmYWhwZFVObkZTZEthZGZDTXpxYzN6?=
 =?utf-8?B?MEpHay8xbDU3SUh3Ynd4TkVYeDY2SEJSVG1ONEZLUXF4YUUyOEZ0QmovQ3BK?=
 =?utf-8?B?Q0tpWDdtRFJrcTVLM0J3dUNjdDdnYURhOHp5WDhMcmYxc0d1M1ZSNzFuN3FS?=
 =?utf-8?B?N2ljREkrNElUVlUrNWw2MnNLU0FSeUN0WFFuakVVM0R1RkFwUHYxQ3A2cVI1?=
 =?utf-8?B?S3RCYnN1TzgrbmNJeWhrakwxenpBaGVZd0xFS3VMUlR4RGxxZGhaRjRNZ2F4?=
 =?utf-8?B?SlRrRHg3T2VhdW5jWVNlM2QzVXZGUzRZRjIyMWkraUFJMUxhSm1od0ExVmdI?=
 =?utf-8?B?aGVBbVVySFlmNXRtSXdYckcrWjJPT013UkxzOUVDSndpZERWa3dZR0JNZ1du?=
 =?utf-8?B?ZnNKc3paQWRUdWhjNVRCOTNUbjV5am5FeU5IS2tKQzBXSG80S0dmRTJyTU1B?=
 =?utf-8?B?VUNlTEx2Ui9oRm5QQjgvZ1FSbmdRRncrSlVFVW0xUldwKzArMXhtV2hLTFY4?=
 =?utf-8?B?VjJQRVByalY1VDdvVFNkbDFUTkVhVFRFRjlxQ2I1WjVhaXJSbzFXUzlsVkRM?=
 =?utf-8?B?S1cyRUJKcTljbjM0eGF0ZFN2bFhnViszYjBvd25NdC9rR2ZXd2dDUkJGZTEz?=
 =?utf-8?B?ME5kbThJYmloTkNRejBoeWFyS0w3dnR1SEtwY2dhZ2theCtjWjE3amZnMHV0?=
 =?utf-8?B?MXBwSDJ2MUtJZG1maWFuNER1dzVCaCtKZXdCMVFNcUtTYSs1NGY1WWRjL2dm?=
 =?utf-8?B?VThRRlZBZEgwN21ycmZpcWRaV1lXS1UydmFhTk9vMzRkV041dGJYRE5MQUM2?=
 =?utf-8?B?bEM2UllmT0FmMzBta01SbjgwRHkyY1NYZmhKRGRGWkFQZ2xjY0hqWXRIbXJo?=
 =?utf-8?B?UndyQmltVk1LUjM5eHdCZFFwVmtJYmJ6ZXdFWWZlZGtDSUh2TzZoYWlPVFRl?=
 =?utf-8?B?aFpqNlNSdzhZdU5SWE1rY1VxTGlnWTFLOWMyNkUvN3YzNEdTd3ZRTU9uSzUw?=
 =?utf-8?Q?K44o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c1647c-e6fe-4fd0-3e48-08dce1880f0d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:42:46.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/0TXkJDVnFncWU/ijChxxf6YEx5sr3J/O2Fnjx5PzN2vAsCEF2VgkobbgBMmN06ul1ZoOMAYrlG8QAS7xAPKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

Some system's IOMMU stream(master) ID bits(such as 6bits) less than
pci_device_id (16bit). It needs add hardware configuration to enable
pci_device_id to stream ID convert.

https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
This ways use pcie bus notifier (like apple pci controller), when new PCIe
device added, bus notifier will call register specific callback to handle
look up table (LUT) configuration.

https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
table (qcom use this way). This way is rejected by DT maintainer Rob.

Above ways can resolve LUT take or stream id out of usage the problem. If
there are not enough stream id resource, not error return, EP hardware
still issue DMA to do transfer, which may transfer to wrong possition.

Add enable(disable)_device() hook for bridge can return error when not
enough resource, and PCI device can't enabled.

Basicallly this version can match Bjorn's requirement:
1: simple, because it is rare that there are no LUT resource.
2: EP driver probe failure when no LUT, but lspci can see such device.

[    2.164415] nvme nvme0: pci function 0000:01:00.0
[    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
[    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12

> lspci
0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)

To: Bjorn Helgaas <bhelgaas@google.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: Frank.li@nxp.com \
Cc: alyssa@rosenzweig.io \
Cc: bpf@vger.kernel.org \
Cc: broonie@kernel.org \
Cc: jgg@ziepe.ca \
Cc: joro@8bytes.org \
Cc: l.stach@pengutronix.de \
Cc: lgirdwood@gmail.com \
Cc: maz@kernel.org \
Cc: p.zabel@pengutronix.de \
Cc: robin.murphy@arm.com \
Cc: will@kernel.org \

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com

---
Frank Li (2):
      PCI: Add enable_device() and disable_device() callbacks for bridges
      PCI: imx6: Add IOMMU and ITS MSI support for i.MX95

 drivers/pci/controller/dwc/pci-imx6.c | 133 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c                     |  14 ++++
 include/linux/pci.h                   |   2 +
 3 files changed, 148 insertions(+), 1 deletion(-)
---
base-commit: 2849622e7b01d5aea1b060ba3955054798c1e0bb
change-id: 20240926-imx95_lut-1c68222e0944

Best regards,
---
Frank Li <Frank.Li@nxp.com>


