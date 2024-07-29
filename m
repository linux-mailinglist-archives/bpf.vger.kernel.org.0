Return-Path: <bpf+bounces-35935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EC093FF1F
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E34B22107
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1AD18F2E1;
	Mon, 29 Jul 2024 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a92F3iMz"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97195188CBC;
	Mon, 29 Jul 2024 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284374; cv=fail; b=fvpmuvEGkMNLKx8Chn6FRnqCENHt+gjMrbifVDGQDcQ84hN5YcxjSP7yOt96C2YJLBufjBU0KHwsZh1af891GoghMU575lCB5wWpfW34eHlT2TnyLTSAsnb8xCAMpTKjXkowYFLzSjPJXrXfoqAFU1eDN5HWxJLDXgM+fdAmjLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284374; c=relaxed/simple;
	bh=Sz4wSH9fJRxSuOtKT4ii9bZq5wdfSH0QeE8uwN+gSOA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Zl5VXWUrEk6JMiz6CV3v6+nawDL4jouFNh90/rJLWF2O8KC07NhAbQ3ah4eu0nx+BC0WyLBlVH4OTD8b8HaNbW83XzeIGIIIy6Sk53S/jsLaMJqDByCdh4ieyGM592uXn/yglUyyZa0pN8zys4HlcjVuOe4Q8u3pCQmpD0voYdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a92F3iMz; arc=fail smtp.client-ip=40.107.104.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osuSUH8dhrs+eQInmpCwxHGoy75n+KZADa8X+qPB8ubrr/q+iPqYzbdxWJFOtIhGO/n6Pn3KT5GhZSpfoSA3LBjz0NnXCmReMV7Lj5fhAOZKHO8qNl8vopWcR/CowZoEXNs8zV9hLD2otW/wHNIXT8kyiS7Ag6blMcI88efkjEnbBUGKc7OIN20umDfnNawq5ZvvgOFS/2JqAxqSNS11v0q47/fSUdUJQNT1N5Lvpn/fwOAKmB4O4+t3Rz/TWuVSv3VmPNwjjxg7tXiAU87M/edrMvGOd2zEd8OhG5p3sOhtzczMEn13ppYy4tnaHO0vhusI5PZNBYTaYDSmzhiBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMwEaN6yeCcLphdNMKFyLxeCWmsveowSNo0XAum9u3A=;
 b=FgMkMZcHdwUSF3o5Iz7urnfICyVuoEeg8eZ7NxRGJw1ddjh2JLnucqDQRSxCHsK+Y2X+rkJDVDt0B8p1SudJ4smpaOnskPRJEEHHU91wJtqLX0/0aSI1mfbJm7TLET5SLJU+EdsDU30hJk8nnz7NrFAvTFF2jKrXzL5BipuKyncaOTQkeWFItTt6uXMrOD2BG4Lm7AhBFqc/mah6nmXoIdiVtMeyvmPU0sIsojNvSCH/PhI9Qn4i8tq+yKGPdmwQ23BMpevNHPboUIXfQjczlOThGCELNQETsQLHbEJO0eex8Kx/Zr9t84o8quPms5hQLKyyO/WDU6+UI+4mKa3mQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMwEaN6yeCcLphdNMKFyLxeCWmsveowSNo0XAum9u3A=;
 b=a92F3iMzm2cWftEO95qj+MEIsvQPaHwHwvLuhKX1URZ/+00tOTzS7IMKLyaVfRiCRQV4+9fl7VZVDJOoGGEqOEQIGSp4p2+DhngpGy+PwUHmcWWk/jR5r9vIh37gZfDZF9FBVcgmH2cEZ6hGQvOaAhZxgd0RclQ8FQ6NTALVbUPaEkiirLxIhULv7f9p015H9SsxR44833W2jzsXxAQpsJBl5zlvTKQp6auIz0AErOzeEf7y4fckjwWwgisv2dwzj/aCSx7M85DFTG87HVjE4Is24dkhL5L93whaKkUo/SLm1SIgfrPDpTDtk2dXgxnMC0n3p4eCaRLZTqpUyGbwIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 20:19:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:19:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 16:18:15 -0400
Subject: [PATCH v8 08/11] PCI: imx6: Consolidate redundant if-checks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-pci2_upstream-v8-8-b68ee5ef2b4d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=1048;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Sz4wSH9fJRxSuOtKT4ii9bZq5wdfSH0QeE8uwN+gSOA=;
 b=otQ/qzidAqYKVhiDPLASOsMjdg1AE4Xdv1KHAq/GPRkWZV0hbxj3xmDagbjVAYFjGZMjm4Wl6
 OA/fMROuLhpAjkqgLlZ0XgDQPDVSus1fcPcRFd6WbrE1+CUWOf+B3+A
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
X-MS-Office365-Filtering-Correlation-Id: c552c389-46aa-4994-0ef1-08dcb00bbfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yjg0M1ljY0lTWmpReTRXcTc5a2lsNGF1YVA3UlhHd2dZL0pDTWpyRCsybEpW?=
 =?utf-8?B?RTBoY2hmTXo5OTAwNTlWQUlrL1pXdHQ0WjhyQ0VMUGlpMnpqOFUwQmJKalB2?=
 =?utf-8?B?b1RManhoSmVKZjFxZ2JyQ2hWQzFLTXhNQm1NcWp6T25RNW1CTk83UDc2VGNR?=
 =?utf-8?B?SU1uZVdlVjJNTmd4RTZqL3J0T3NjN3pOSzRlUXBxQ0FtRDEvVGFXdStBS29K?=
 =?utf-8?B?VnpuRkZqTzQzaElEbmE4WjUrdkFqZnRMTGVpd2JMQ056angrS05uNExoeDdn?=
 =?utf-8?B?RWpQdHM5elpESzkyM2I5VWtOOWszVVlNNTJpeFZRaVhwcHExVjZaZGMydjY0?=
 =?utf-8?B?NGtZeVptVU9GSGNXWkZVbmVndjZQUXdoMVZnRVBCZmM1WTBycjR6alhiODl1?=
 =?utf-8?B?aUJOZHlLSmNpK2diejVSV3NoanNoQnl0dzZaU01wbGo4TFJwem4vc3FzK3Er?=
 =?utf-8?B?WDdWc1llTnNZR3Q0ZkM1TFNYdFZ0bnc3M0ZnSnVpWWl4NnlWNWxIUzZPTDhW?=
 =?utf-8?B?VVZQejB2WENkUm1GVFJqMGN1OUc5Q3JMM1lCWGhnTkw2SkhNUXZqQUdoanJY?=
 =?utf-8?B?REJuNWRFL00zSU5zeHFMOVk2aVNpa1ZBSDY3ZVZBeTJhWUUwbGJzLzc4bThH?=
 =?utf-8?B?SEYxYUUvV29QM0ZhajdLNDJGUjc5MlJMRGl5YjhSU0tSWUhMNEpjOGU4bnJZ?=
 =?utf-8?B?YlZoeko0dEs3aXNSYmpINitpUFFkdTdRVE8rMk5ORzQ5MkNZTGE3emlzOGE0?=
 =?utf-8?B?NVFJTFlaZi9iRTF1eDd1dnkxSndkSWlaOHZEWUI5bFd0T1ptdThvdzB1WjUr?=
 =?utf-8?B?SUNqbVRMSTUvM3dUOFVrdjhSeHY0bWNya3JvbmtMRzZEd2puSXhuWE5EN2Yz?=
 =?utf-8?B?MlRMMzN3d0RlOUp6Y0c3cnlvYUZwQ0tJZHUyL2NIZVhMSG5QK1hPOHJvdGtD?=
 =?utf-8?B?TlBUZllXdkc4NFp1cWZoNnJDb2EzRjJOUFlPdER4dmVPZE5OK3lQUGI5WEpN?=
 =?utf-8?B?UWhkQWVZU05INWlyQS9ya01nMEl4Mzcya1J2aHVnamYzLzlhQTNJZ3lFc0FQ?=
 =?utf-8?B?ejlUc2F5Z1dIQ1M2ZWRiQ2luOGlneklJcjFyUi9PaHFjWkhTMmFNYWZJb3VH?=
 =?utf-8?B?UGk4YVpRK0pSNVR1V0ZTK0ppTXg2YnFDUTZod3FiSDNZMFNzNzdJN3dSL0NU?=
 =?utf-8?B?NjNjR3BEa0FIMXU0eEErd3JCcHVsanltL0tjZnd2NjlOaUpSRFpSd0l6Y2Fw?=
 =?utf-8?B?Nm54YlpLQ2NLa3VGb0VaWWE5SFBoMzE5TnZRb1pZWWVEY055WVpVSVNIYzdK?=
 =?utf-8?B?UnFEQXppVHZtdXB5Y0JsOXlwTXNtRE5hV0hyOWRJRGxlWDlNdHVET205WTNs?=
 =?utf-8?B?aitZWjNOc29CRzZFUnBzNzRJSVBESWhlNnRvY3hKZGRVZ29GT1RqbG9JMWZ2?=
 =?utf-8?B?d1B2bkdkQjdYSk5HYW55TlFjaWJBdE9TN0pNS1UzVW56aWxucHYzM2ptU0tm?=
 =?utf-8?B?bmU5MDVNWHcyMmhWT2hTZlFpTHZ2emQ0QWxMc29QSWJNZXIxamJ5SUZnSm44?=
 =?utf-8?B?NGswTjl5NzBEakhMOUdCS2Jmckl3dk96VGpsbmJsb1ZJbGpjdi8yMkVUNTlX?=
 =?utf-8?B?VklyY2ZiZDJ0OHhiZUJEc0xzQ1BVYTcxdSttNDRaTXVoTXMvTStDWGtvbXVE?=
 =?utf-8?B?SkhVdTloWkJubGl3dmlWZlBMUm1iY29GSThVYk4wU0pMSko0MlpYMmVVM25q?=
 =?utf-8?B?WDhGWjJ2aU5OZHEwMXdRenJlVmFscXlRRi9jWW5RSjBRdHBXYlY1bXNKME4y?=
 =?utf-8?B?c2FKbXFtWEk3cWNJQWxrZDlOOUF5T0xJTEVxWUlBak93bmZnWkE4bzBOcDFD?=
 =?utf-8?B?eGJEakFpWlJRdVBSNG9lVFhxOW9tNXRxbjh6SU9TQWlaQlN1WHJVY21qendK?=
 =?utf-8?Q?cEDDbpgucfA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MENhZW5Yb3FzbkZLVGV1eFZkUVFTN2dEL3hjQjJVMXZCTUIzL09wak9Lc0hr?=
 =?utf-8?B?QlZOLzI2UzczK0FteG91WDVEUHlscXEvUWd4YzJaRHhDVmFuUzcydUtEUXU4?=
 =?utf-8?B?UXYwSWEzcFhIUnJCN0crV3kxZHVhSlJoSzU2OXAwOUF0TVRsMjc2dDhHS1JO?=
 =?utf-8?B?eHJlNXF5YXlKT0FmWFoxL2hiMXVvNm1HN1R2cGVUdVA1b0V1ZWwwM0UxM3lj?=
 =?utf-8?B?aFN2aWYzRDdnYk1IZVNNOG1xdFRWS0o5Z0lEaFRhcGN3Y2dyLzZ6aUNkYzZP?=
 =?utf-8?B?LzVvaERKRVBiRWp0dklMeEJCbndrZGhLcDJhUGprQ29jeTB5Smt3dS9lVVlY?=
 =?utf-8?B?L1AvdW1nUHFOWEVtN3ZwT1lMaGtpSjZELzN5RHhQMHV5NW41OGNNT2xPam1n?=
 =?utf-8?B?aFl4N3FZOXZFQUZJZWc1bVYvMXNsWWxHMVltbWF3VG1jV1NyL0hKMlU4OWVw?=
 =?utf-8?B?b1BLM3RIVGFNRW9MRUpnMFNWKzBVdkR3NzNrTDlVQmZvY2NFWFgxUnAzbXdk?=
 =?utf-8?B?TGJUSFJveFd4L1BJUDc2RTM3cjF4Q1IrNW4rQThvdmdPNmlwVDE0Tk45TCs1?=
 =?utf-8?B?bFVSZFNaYzU4OXVjT2tFSmlBb0dVTzFvakd3ejRydWpoMm5ydWE5RkxIc3JX?=
 =?utf-8?B?cWFGZFVnUE5ySHhnNVd2dnI5RFdQb0hmNDhqTW5BbzAzUXR5a0ZQd0tUWXp1?=
 =?utf-8?B?MXhPN0JSdDBsMVlyaXRtNUx3SUYxNUlPVWpheDBsUzBEVzVhdHNJTTVabGVj?=
 =?utf-8?B?eUxYOGdtM2pTdDZRU0piSnJNRzc2bzVwVmkwQWVRQXhVL2tFbWE1cEY1aHJ0?=
 =?utf-8?B?N3JUSkppZzlvZ2lzVGE3dUNGV1R3b3BqbGUyQm1xT3R3VzV2c1BvajlxeTR3?=
 =?utf-8?B?Wk4zcng4Vi82aTlteGV3MmIrOUJ4amtqcVpra3hXcTI5SXdMc2NnUmd5UElP?=
 =?utf-8?B?S05WZXJ2ajlmSEVmNE5HR1VvY3JNK2FLWFFLaUlUSG9ZYnVNbE1IQi9YRHRE?=
 =?utf-8?B?c1dtZmRRZ3lrODIyQmIzcmRJOVBCUUxWUFJ2dXpTZjlua05tUFU1NDdVNmZR?=
 =?utf-8?B?MEk0dTh5SGh3MFVEenAxNHhDUVBHcWtSSkdDaUFLSUtWNU1VckFYeWdYazFn?=
 =?utf-8?B?WVBWU0UxaVY4TUN0VGQ2LzdrQTVYRTFBeFB5U2MyTktkYlNsS05SVGo3dUtu?=
 =?utf-8?B?OGJrRytmL2NyUmYzRFlMWmFjYlpzU2VieVc0L1Vzdks4Tm1mWVpXQ2NSRzhk?=
 =?utf-8?B?b3J4M0pscER6cjM2UWtlajFGTGJEUjFtZndhMkdWLzhCelJDTTRaUGk2c2Fk?=
 =?utf-8?B?Rk05ejkySEVTRE1LME92OHFVTTB0cDc1b3kvY0c1a0tXVm9WTlJTcjI1NDBJ?=
 =?utf-8?B?eUJvZTZEbHhOOGYyR3ZzWk1lSVM3UjRyZ21VWnJSZkdSNlBSMUg0cExhRFFU?=
 =?utf-8?B?V1JDTmdaK0hGbUNDVCtFazNUcTlmdjZwV202RHorZXU5Rk1iQlZYK2tZREJy?=
 =?utf-8?B?NEExZFpveU16N0VqNWpoNStLcWVjQ3lLTE1uU1pJM1dUeGphSnU5dlcrcTNz?=
 =?utf-8?B?Z2JYRTlTQXRjVjE3ODVuQ3c4cDRZQmFROUU3L0FzVlZCam1WYml5NEhscnE5?=
 =?utf-8?B?TDFRZE1xdUgzRk00UGh1ZGFQKzVNdXhld2NaZGw2WjFiYkd3QTZMUHdHNUFh?=
 =?utf-8?B?WnExZWNRRm11emxWL05ES3JLTkplNFdocmpHeUFrVVVhMmdNWnBkSDRlem9L?=
 =?utf-8?B?VXFuUVdCS0V3NVVhcWRaREwvNHl4TnJOb1hjLzNva3FLVkdPRG44L3NyU3Zt?=
 =?utf-8?B?VktSdlJXcGJlN004MC8wYngzd0NZdUltRlJqMmlMdVVMV3ovMWVadVpMN1Y5?=
 =?utf-8?B?SFJuRDg5cFlWaFZIWURMRk5nTXdRSzQ0eVBta0lqK0Z1Y05XT1M3anFpajRs?=
 =?utf-8?B?MlZYVnlZZmVpZUJxSHJMMzgxZzc3Y3ZKNkRFdUZHN2h3ZWM0cHdjb2JHVFMr?=
 =?utf-8?B?TFZOd1RPMXRZTm5MWmNwVDZkd1oyVzVFaUlzRnFzdmdGbnpodFlyVVBKN21Y?=
 =?utf-8?B?UEFZWXJLVG1teFY4M0dNaHRKMWJyNERLeWkvWmc5NkIxbml3WnU3ZzY0Y3Rm?=
 =?utf-8?Q?6Gr00UTOaZA9KkO1LIW246d1q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c552c389-46aa-4994-0ef1-08dcb00bbfc8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:19:28.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG8Ets+4KUHaackq1yrkcliH+uKsJWIHL6bIexKc7Neie0E4CUYm9q3xLYc4fZ+yeWL+AMOwHEvVSX+YX/srIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382

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
index 6be32a93411b6..ccb7cdae32756 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -949,9 +949,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
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


