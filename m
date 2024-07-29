Return-Path: <bpf+bounces-35937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941993FF3B
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0971C22559
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC25F190686;
	Mon, 29 Jul 2024 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ap+1KBwS"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D1190473;
	Mon, 29 Jul 2024 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284386; cv=fail; b=sXgUCzvS0u7OEG2hzStgGizadjgBhPWIU3POnlNxLpMsOI83wkp7YPyVIJ/XbQFn/m2KvQ6eFp2ej4TVIP1husbe5qAvijhMTcExu5DpGoZZVeln72U0/7hRsv3ZYTmTMMfx7Oi/0dcw0aMWuOOkAwFK0RuXuCeZvsaOuh3VljU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284386; c=relaxed/simple;
	bh=xnegrrqq+Q1Ekgre7IoRsuq7FwdKEEV8MnDreE+OHeQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=e66IJDnblFO1ytTREK3MY53TEEns0+aazdjV+//c7WsiD7Ad/ieLazhx3nmS8CZXd+9j7dXUzQMPkRkXRTKnfjPM/3g2YIXAKH9gRo3sj2tI9QGzIwrhwuCh3G6KFS37X8bBJpG17yjy5Krj48SD1MN2HLegS9caLrEHwaXCvDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ap+1KBwS; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8p87ruLpFvkif9bPJmyTeVpdHisL7UoscE9uL6Y8BJ6uEOOQBQe4L8NRGF3+/+h3VMXL0/QtLpbf1OkaoT/a36uqkrU/ahepcUhSKQbj3pTAAS4dnDZWTkr0ovFPvUNMwk5To3I3NVKeut2dFvXJmHYs5yHqIf5ZwNTp6XeOydBKSKCvHJiYE+0TmEV9vCZG1WDnzZa+rmdEs/r2uEZ41rPMirCNzetNe4eh0EIrZkJYLObY6IOetZA9Wgtyb56W8zTx8R8NKmRVdhhG0rVAyH2bv+28j2FXaKm7td9areO4gZwb2Fpccak701T59Jo1p+98pM5YmnxIx2PPdphTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBwLRFPfd+0byJrsW+igL3Gd6ozPrhPd3TitZlHjCHM=;
 b=T4aw5KUrKVJocWNMxB4aOocYy/G+aHSLxwS9fvT++JZ2H5J4JCHyb6ic1RDhDdVPcaScI+pwHd+jxfmN6R4f1C6nYY5pERY6GQIrDUVkgZd82v31Jo/EUgg+vUosuVrKYg4lnNMA3vVDpi33y3IyLVY6S6B/7iLYb9kQ2vaurTrIGr/0Wyzt0X1YnSpfPk3voW+xCgYgTK+vr40oNKXrQdk8iaH4Q/+8rBLMBAO1NhvdRFvbC9r+AdOUMuqOImdAwbC4ayRY15Y84y52s9qEZXNxqcZfUK4dcGnf7XtZo2Q8A+nARXGEgnr8bXz9aHy65fnZMMiCc5k8ZO8r8rMAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBwLRFPfd+0byJrsW+igL3Gd6ozPrhPd3TitZlHjCHM=;
 b=ap+1KBwSyeEpPsOpbQNhTy+2+y+1nI4pVrvwOSD2NX4ivw73r9xldX3f73RW/aEhBYEw9YIAP4yalyvA7UU4FEJJEQdrxWV4TQb0sbGMsWguVA1pVcYT+mgUR/lwUpg1MFFuE5J2c8sJ6sTQzyIHWCowxF3AwcKsQuFUqGYkXp74HvPj6BeOrHSci3uiMyf2z7p9m+nDuOorr7cdIjtHIUE21kL/obEd2nzusgFu4V6BGl7UkvW8hxmXEGThf85i4WZOcmnbbNTcNq8552/JVb/p5JVGoqOBmhyoX4C9ZD+F7HqA1cW5qooxtK/GSm4rJVbP+9/GoICA0BWcBNEUTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 20:19:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:19:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 16:18:17 -0400
Subject: [PATCH v8 10/11] PCI: imx6: Call common PHY API to set mode,
 speed, and submode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-pci2_upstream-v8-10-b68ee5ef2b4d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=2619;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xnegrrqq+Q1Ekgre7IoRsuq7FwdKEEV8MnDreE+OHeQ=;
 b=3FmqDsHSTKKkzp+9sX7JBJOjNmCre53DefCsAe67ExslztvYHsn8f4rmrntF3dj1hUY4im/Qz
 GITWKhfUMSGCU0nCedF5e4B4e/G+HHiAiwjoLqsBpkEQmB8MD6SFm4W
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
X-MS-Office365-Filtering-Correlation-Id: ec0118d5-3f30-49fc-d490-08dcb00bc6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nlk4VmtvMGVZM2FQaElNRGRuNEVWZTBmWFJFV2s1U0JIaGM0M0daWmFldUZM?=
 =?utf-8?B?dCtwdlhTdW1LSUdmZkQwQVZLakRpbW5ud2E1OE1aNUJHYSsyL0Y2b0tObjJx?=
 =?utf-8?B?VHI3Um9BZXp1NVlTcUhSK2FIUDMvNzhWelNTVUNwYnZRZnN1dVZLUWd4dE9u?=
 =?utf-8?B?R3VOa21lYytkZW0vSVhqNHVxWkUyVnVwdVlYMFRGU0cvYzZTZm81MFhzN05l?=
 =?utf-8?B?SEtzNG52cHNmQ1ZYaVI3YWZOblNDbVhlWGdZNU9wek05Z2NXZWlkZ05WcTlM?=
 =?utf-8?B?SkErYlkvd0JxUHQ0bzBid2kvSm5RMnBVdUNwQmNyMGw2Y2Q0WThWb2tyL2ZD?=
 =?utf-8?B?ZE56TlBTZlNUVGhJNXpDUzlTQjNVaDFoYnY5RnZFeGlsSlBJM2FHN3Fydmdu?=
 =?utf-8?B?bC83WnZ6Nmp1dUQ3NDEyeFcrckFsTlRlYkJOVnBpZllkWjNHTVNXOHgzdmI3?=
 =?utf-8?B?UFRaVm43QmZoSnRRY0hNazNxQ1FEYXRYelVrb2hOT1NSTTMyL2NpMW9zYUd5?=
 =?utf-8?B?OUk4VlVCeVZkNkZsSXRQWXNwdXhla251R0U1UzV6dElHMitLUTNCWVlocldj?=
 =?utf-8?B?TlRCWjNxeFRWMU1RYjUzMDRQV2ZwK1VQV1ZBbGRUT3JnazRBMTh6YTdNcXNC?=
 =?utf-8?B?ZlZ2RnJKbEZsMWdCYnRLaUJsSVNWQkZYK2t0WndYaCtmSUdyWGwxNU9McTRa?=
 =?utf-8?B?M052QjdDQ2QvRDZweXZjU0pOT3hwOCtYWGRqckt5TWp3R1A1bS9GK2VralFF?=
 =?utf-8?B?RUNkZERGVEdqRWxabmdJL1VCay9TUGFJaGdCcm5aZzhEOUVrb1lkZHNCZDBr?=
 =?utf-8?B?VEsxN1pUMXc1SUFYOWZqWmc2ekZDNjVMRkk3bzZESE9BTkl2YUhFTXRnRTZs?=
 =?utf-8?B?b1RnazBmMTREMmdFbFVJdXJGMStlWm9XcVREVUtkb3lSRmdTR0pUNWJpc2Y1?=
 =?utf-8?B?Vm82TXhqaHlwWXlpb1lxTjk1RnRZamhOYkJWQUJza3NuSW5QYzU0SlNGUDJE?=
 =?utf-8?B?YWpETzJzVi93YldXb3F3M09BeUpyWGF4eHFlblduYXVqRUhRMS8xZEx6aWNB?=
 =?utf-8?B?N0Z1UzNOSFJPd3NwM1c0TGV0SUsrTXp3clMrSDh2VngwaUZSRERrZmpFSnJE?=
 =?utf-8?B?VHFHMHg4S2lQZ2tWMmhZYVBWc3ltRmJqWk4zSExrc0tyN1JYRFFyR1lIWHFK?=
 =?utf-8?B?TUNPNTFSQXlmYU5udno0Mm1JTnhsNUY1Wlp5TWtwZGpxcjlQOGVCUDNoZWw2?=
 =?utf-8?B?cjFCVWZkTW03MU1Nc2QrRzNERE5pUnRsOHp0VWlPOENOZnBjSjJWbEV4VXN0?=
 =?utf-8?B?MkxhMmNEcXZTcjZMSkdOTldjdGlLRkVoWGpyWnZKTitJTnBvVHFyWTBpUGZm?=
 =?utf-8?B?RlF6TUZqUFpsVmxRcGhjd1gwYzlzMWZvNXhDTUFUaENWSG1jdUhud2lOOGVu?=
 =?utf-8?B?a1VPZUlVcEh4L0xROEhMSk4vRzRBelFTSGUzeWJQQTRSbXdKeGZwWTVoVUwy?=
 =?utf-8?B?Sy9uL3ptdUxqVUc2ano0bkhsZkN1TDJ5WXRwYXpCaVlBdTZzeU9aQ2VmaG81?=
 =?utf-8?B?Y2RydndtN0RJSExnNXZ3WFVNM3dxbENwS3huYjErK04xK0J1WThmeHU4VWRO?=
 =?utf-8?B?RVYxMTVPWFJSUEsvZ0hVZkZ5TEplZFVVclY0Q0NkbVI1djJSeGFpYitZTWNZ?=
 =?utf-8?B?QTduaC9FOUVqL3dTNmRxSDNXdHR3blpoTm83RlFPK0lFNTM1Qm1tREFTMVcz?=
 =?utf-8?B?NlZ4RGVZWHhuNHlveFNocThzaStVVHRMMFZqZHpMVEE1Q1VneFg1YW8wNElh?=
 =?utf-8?B?N3NQVHBrUDBLU0xhZUVBVnVsNEFHbnpVL0lYTmNIYkY0eGhkN2xycGRpVmxu?=
 =?utf-8?B?R0h0QVkxdmZzZ0QxMmtmVlgyd21rVGtNS3RKdEx1UGx3TmlBMS9sMVA1K3Vq?=
 =?utf-8?Q?kLVVBhLt/W0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3JQamZIRmgvRXB1ZGRHMnhSTDFYVS9MYzFoR1lLTXJwUFoyYmFsNGNqd3Fv?=
 =?utf-8?B?U0NTWndNaytBZm0vcXpGZmpuM2NpbUxOdjEwb28zWURKQVBQdlVNZXMvaktQ?=
 =?utf-8?B?djM0cDI4ckI1aWI5cXNjc1FJTlFrWlR5QU9iZHZ5aisyOWh1QXo4NlFrdG9Q?=
 =?utf-8?B?TjkxaWVqSHVGQk5MQjdKL1BzNVRPRFowM3c0ZzNZTW4zSnZOWmJVaFloSU5E?=
 =?utf-8?B?ZVhFOWdhZHMxMGEwQUhLSVlEMllLdEJNdUFLUFpYTlpNVHdBTjVZNk5XeWIr?=
 =?utf-8?B?YjdwYzlaOC9na0lmZEYxY3g3ZXZ6UDlpZExSNjlOTHVqQUhWMnhwcjFLWHBp?=
 =?utf-8?B?QUpZbHdod0hoNU5tL1NVVUR2OXFaTkU0aDVYN1piRVV1Y2dTWFpMTkpVVUF5?=
 =?utf-8?B?SkZENkZ0cUlTa2RmMHN2a24xU211OUE1eTRNcnhtUFBTV1RzTVNFZHgvRUJR?=
 =?utf-8?B?REFJTmIveXI5eGdVQnl3MHBuZ212Nm1hNmhQMVJFeDJDendjWTRESTNDUERR?=
 =?utf-8?B?UUpKWXcxUzJGWEhGTmZkZFFmK0JjbHpEbGNVcmk1Yk01UXFvYndzenB3eHpR?=
 =?utf-8?B?UDgvay80SzJXMVZ0VDZrN2wwRjNsKzc0bG5wNS9ZRDJJR0oxMVFxK2dqa2hm?=
 =?utf-8?B?UzdEVjZaakU4cE5ZWkVVVyt1bTBiMVh5UDF2TlFDYWZjSUFlckR2NGJ2MUJN?=
 =?utf-8?B?bklkenhWN2pTQVVldW4rY3dRcW5aM3J4VERMWEt3TWEwZVZwOFVNSzRhWGp2?=
 =?utf-8?B?eWpUMzVWaUFzRU9QMXIzaGtKdUt6SHhPVlVpWHpVb3FyeWlYeUJ0VWEzYnI4?=
 =?utf-8?B?U2kvb2pUVHd0TTVuL3JCRXRtWHhqWTlpZ3NVL1FFVFJrWXFYZmc2MCtvQXJZ?=
 =?utf-8?B?MHpJZ21PUFExOXZrS2FLS3NIUmc1TjBTWWU5YUsvN2l1cVBucmpIY3lheGk0?=
 =?utf-8?B?ek1kR3RrSDJpdUJkTmpCcWhkeTl4LzVYQy9mWVg5OHBweWhxT1F1aWFZNjBz?=
 =?utf-8?B?Tlcvd09rQlp0d3M4OWM3bWYrajFOcDFYUzc5STZyUUMwNUNScHpkSWRYM3dq?=
 =?utf-8?B?d1YzNytqbU9LTFFWSGtCcThPOW1mWm4xMUlEbk44aUV2NTJkaU1kVGFEVnlZ?=
 =?utf-8?B?dUlWNGRZZjlHWWNRYzNCV1EzN3NwYXVFSmVWRXVQNnU5dnJaNFhhcmlPUW9y?=
 =?utf-8?B?UXo2WEcvZ2NBRksyVm1KczZiTW9BVlhYVFJha2R0aURkYXZOVXB5dGpzYTl0?=
 =?utf-8?B?RUR3dlo4UFBYV2JEZitHUSt4K1VBdXoxRnNxVnlJeWtXL3kreDlDaXNCbFpq?=
 =?utf-8?B?SVZEMTM1YnR3Q1dDVTZmRlhhQW9VRVA3NXF6b0Z2cW5QUUdmWVhNL1VvcDFz?=
 =?utf-8?B?aG12UzlocnJmZHF5Q3JERkswUndsejAvR3RpdWFuWkkwRElPa0k1QjB1bk5T?=
 =?utf-8?B?SzhsMW9sdW9hZXVOK2o3UmlEc2ZCblFyc1ROQlFmMU1SUjMrMFBmTGVLR2Zv?=
 =?utf-8?B?RWx0ZWpiZFNNM3dKR1dLaVJrOVZVSmpRT2d1ZkxEcHJHVFVVWWJhd01KS0ZQ?=
 =?utf-8?B?cC8wYW92MVpBYmVxZlcxWXNjeTFQZ2F2LzlZRTNSb2J0WWsvWC9QalB6dExJ?=
 =?utf-8?B?NGNaVmtBbVFiZGpHbTRBRkorSnFlNys2L2wzOEM3cW13emJXNUZxZy8wZmxM?=
 =?utf-8?B?all0RUxSY1BISzUxQUtVbHoxRjFvR0FjNXhrNllodjY5cno4OWdyM1loS2pP?=
 =?utf-8?B?N3VYOER2dHVTektwSVo2R0RtR29BRGhoRkhDcE5Mc1ZyZjV3bVUvOTd1NWZx?=
 =?utf-8?B?ZWxXd2hyZk9EK0xrb0FnS0tVaUgwRytZSG9zbTkzVGlkcGRLTTYyWDJYUVp5?=
 =?utf-8?B?QWFUbk12d3phRHNVUDNiY3pmOWRwYkdla0Z2cHZzc0pYRkFacFlJWkl3dkEx?=
 =?utf-8?B?UjdkZjM0NzFWRW5sSlJ5K0MxOXhTT2paN2hjQUtUTXc5Rmd4U2luWDR6SDdB?=
 =?utf-8?B?V1hwZEpKWkJVajJ6N2J0REJaN3oyTlpiYjNEVDE5eVEwRWJ1OVNJa1dSRUJx?=
 =?utf-8?B?b2tJMTN2MzRER3BZUXRIMDlSRVE4R3l3bmxWQmFtWmlMbFFiQ0Q5dmpKQkRy?=
 =?utf-8?Q?B5zLxwPPYrD0RLfg+vJU3Obn3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0118d5-3f30-49fc-d490-08dcb00bc6ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:19:40.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pw83kBQPGbL1dZfbBLglZMVmw7+67gVVExWGmdwkOLZRAk2p6lIHO7qOdhrkneLVbYeaVgmYhCpmh1m6QwBIzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382

Invoke the common PHY API to configure mode, speed, and submode. While
these functions are optional in the PHY interface, they are necessary for
certain PHY drivers. Lack of support for these functions in a PHY driver
does not cause harm.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ccb7cdae32756..91aab0288fdcb 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
+#include <linux/phy/pcie.h>
 #include <linux/phy/phy.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -227,6 +228,10 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 
 	id = imx_pcie->controller_id;
 
+	/* If mode_mask is 0, then generic PHY driver is used to set the mode */
+	if (!drvdata->mode_mask[0])
+		return;
+
 	/* If mode_mask[id] is zero, means each controller have its individual gpr */
 	if (!drvdata->mode_mask[id])
 		id = 0;
@@ -802,7 +807,11 @@ static void imx_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
+	u8 offset = dw_pcie_find_capability(imx_pcie->pci, PCI_CAP_ID_EXP);
+	u32 tmp;
 
+	tmp = dw_pcie_readl_dbi(imx_pcie->pci, offset + PCI_EXP_LNKCAP);
+	phy_set_speed(imx_pcie->phy, FIELD_GET(PCI_EXP_LNKCAP_SLS, tmp));
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
 				   drvdata->ltssm_mask);
@@ -815,6 +824,7 @@ static void imx_pcie_ltssm_disable(struct device *dev)
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
+	phy_set_speed(imx_pcie->phy, 0);
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
 				   drvdata->ltssm_mask, 0);
@@ -950,6 +960,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		if (ret) {
+			dev_err(dev, "unable to set PCIe PHY mode\n");
+			goto err_phy_exit;
+		}
+
 		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");

-- 
2.34.1


