Return-Path: <bpf+bounces-43112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 415779AF576
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 00:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBF61C20935
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740962185A5;
	Thu, 24 Oct 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ncc3KK1S"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D822B641;
	Thu, 24 Oct 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729809306; cv=fail; b=G6BUU1YrY8x1h37QfOrFsP6Vync3aB0h6b7yAyBbiGGlUg8NRx/6Bzq0lx/69Jm1W73ptAse8TLhfgdBDY1goHSUXTmXQKhPGzd6bStUgPFdExyL9TwQSutfrE15XHKIg8jfN6e4y44thFDogjCPt1ImFxtHoczNjVRrIt92ZB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729809306; c=relaxed/simple;
	bh=N8dAoRXaPbcI1CqA/wPzjz+zuwliwQimyLiLRuqZYiU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ZxP0ubXlBd9yOYiMBaJmZWjN+AW5gLHQGzr7KO/ucJrKtV3b0vVUVzcMYCF+vXO2fTUe6rOw2CrW5GwU+YKkgH1vNFV77CdzSG0Td4rJaac2sb88icPQyW2QwRFOlfmcCniKzVdpzwpeIC8QtrHO+Hzh28vVbJf1AMesQpU5+LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ncc3KK1S; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUuwXc2O0eAgamE88qccEwGi1PE4708Z8iseB+GqBBGAMkuqbRRJwYhTAVnJD2DgbFXy8Ao2YsphL6MZJ3PptkAtB9pkb3FKAwWwT2HMAne4LO5xOKOnUsMJQjpVbcyxxX17NrVcT39svjsjkBDW5/9zbt4IgOzO+QcL3Xj2L/skAoJJpwrzUKqYVy4izmYwFT6nL7+Ic4WKifkf0Sur1Tj1+KOoLF/s/WL2NKoYyKa9ZaypolbxLAyVgLDQcGCW4pKWkpBF+zdGirrAo0T8RUFVbH9a7iX/Xftt5LxMzPFvZCs8MCfq8WO9t8jZl0VivwqWOGINySq4alEsc/sr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALlYyFxJUoh2fcdeG+r1juTV/kIcZrsE9a5YT2fDmpQ=;
 b=KcpsbP9ntVkKJnFNqh1IE/6/J3lZyHtaKz4eJyQHJZCvKO/bYULvMAqOj8B3VfcqG8bFFqgJFvJWj8Hq0SZRcAjKcfYLzq/xrVA8i2PCbiP4WKHWZRlpAFgNebpuUpzPegmlJ6uHHk10RHWeZCDkksEZweGmkmtGH1n9IckJSVSScPqdQuPpmfYEVXY0o+3KDLXvtqU4rSFxPRQb8AHSx5ZrGbfJ1FOLunT8WzIDZEpm1aMLgY2hOo7PhGX21DSjTkR86S4QgjnbSBmmC7gUZ1T0QmaxizD48Y5omsFVRuRf+dEfSIqBnoS/GBhl6GPxRXarUzyPwZMItc8COk3ICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALlYyFxJUoh2fcdeG+r1juTV/kIcZrsE9a5YT2fDmpQ=;
 b=Ncc3KK1Sc9tq7pt8HAVRyKdG+G3rUxzcuS+OhaGxvtwpDJnNdhdF6xuHJj0w8xEImhIcmdoyWz7QwKiHM+RZIQwfCudFCDvQFqWcSt2O+ioFcLkaMc1zjIVTfPQf2jIgco9gWg7IyTEbH82+iILwJhFKrWIjJ5P4oORSQwfGEYk/Nimge27gmTD21CTQ87hLAqWJWIeSfRk5sg0nJuNUjuCzE9F1CK2mdfeJtYWemcbAdz0Z/VNpmHVFW6WPYdSwX6f8z5nO1JXoC5sht7nuamqj7nJkz7KH/q3PZN7UvEPvhSjrBxDJdrzQn3cvlU5zikjwQcp5KxRlpiVkQC4I+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 22:34:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Thu, 24 Oct 2024
 22:34:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/2] PCI: add enabe(disable)_device() hook for bridge
Date: Thu, 24 Oct 2024 18:34:43 -0400
Message-Id: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIPLGmcC/22Myw6DIBQFf8XcdWnwgiiu+h9N0wDSSlIfAUtsj
 P9edFMXXc7JmVkgWO9sgDpbwNvoghv6BOyUgWlV/7TENYkBKXIqURDXzbK4v94TyY2oENFSyTm
 k/+jtw81763pL3LowDf6zp2O+rf8qMSeUNNQIpFXZaKUv/TyezdDB1oh48Bg9epg8pgUXpVYFk
 +rnrev6Bb+pNArYAAAA
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
 will@kernel.org, Robin Murphy <robin.murphy@arm.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729809293; l=3473;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=N8dAoRXaPbcI1CqA/wPzjz+zuwliwQimyLiLRuqZYiU=;
 b=huGbZ5hWOHq7NpH9VsBva3O5e+3z7dGkb+O+o/Jd1m5hXIII1GXpoTMejiqeuOeb2hSWPIaIH
 BWI6suqnspZCGfjFH1nJu7gUJP3Q6/wNCcfFBrmyiP6yv/8yLJ9aGgi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 603d5253-6a45-4568-1c94-08dcf47c17e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TncrUVlxQTM5VjRmNjV0YXNlUmVlZHhuNG9sL29zTzlRWVljVDRlRUxIRFI3?=
 =?utf-8?B?dFRSNldRSDdySHQ4YnNVODBTMCs2TlFSM3BvZG0ySU1GM2lFNnRzVUNWeGNU?=
 =?utf-8?B?WHRUcjdlNVQxQW9nMDhac2lQSTQ4ZTBLbFZVMGhIZ080c0lZM2FFTDNrYTdx?=
 =?utf-8?B?UFY0MlNzL1hFaG5nU3hTdm0xSWhVTEhqalRXY1FzK0J5ejZZQmI2bGV0ZUVC?=
 =?utf-8?B?SHBJdnNHSkpnc3NqRUJETEtOUGRjbTUxOHBrb2U2MUZkS3ZmeWhoaHUxdWh3?=
 =?utf-8?B?bXJPMFM4UEZKSHZFVmd6eDRONm01cVNpVEtRQUgrL1VZZ0dWRXpqK21mUzlk?=
 =?utf-8?B?NkYybTg5OGEveDBsdzNUbjdqM3JKN2Rpb0NObUpyQ0ZEd0xKcDkvNmlBYnZ3?=
 =?utf-8?B?Mk5YVjdsYVc3aldweTNQOEdmcnR1bHV1MjVreCtLRjU4dG1CK3lGR21QSGJq?=
 =?utf-8?B?YjJaampOU0hSN2Rmc29wTTQwMlBKZnVmNG9SMGM5NHp6blRURWZYWnpZcDFZ?=
 =?utf-8?B?anQ1QTAyeUNvNEVhOTR6MjF4NXd0d0JUZEg1QXFCK3NYdUU5RXhLOG5XWHNx?=
 =?utf-8?B?SDloZmZsTVEwMGdxYy91UWNQa3lNRWR1cCtjSlkzaXV0L2NNLzNRSDZWVDh3?=
 =?utf-8?B?QzI2Z3E5cFhWT3pHS1Y2RFFWY2lvQ0VxQWxqVEtCbHZFNTIvb2t1Qk4vTWtB?=
 =?utf-8?B?SGpsbTdjMUVjUTJFaEdWd0FvZWFNd0szK2QweU5vQkdIQkhSUTg4Y2E1Yndl?=
 =?utf-8?B?bmZVbkNwRmhwcVN3YUt4YlVHV3hITlNxM1BLdlZVdXpkeWV6cks5SE1iQUJ6?=
 =?utf-8?B?amkySnppNndxSkdDRTJWRllSeFM2dXJVUnhjKzg1WVNOUWtLTjBqbUVSYmRR?=
 =?utf-8?B?YjNnYnhmbVhTSXFNQUZFT3Q1VHdGZHRNZDhtOXR0TmludXMzNHBuWTU0ZjdZ?=
 =?utf-8?B?Q0xLdkNKOFUzV1BWVy9salVBdldyMGxGVXo1NVdEa0s2QXZwbHhBQS9lN0xx?=
 =?utf-8?B?cDU4QWpFU3pxNlZMcU5QQy9Da0MzM0xHTkx6NldjaUl4VjRjTUd2dGpUWWt2?=
 =?utf-8?B?ajJjV2MxRTFoZm5KZFh1TW50Mno3NnRXREpwRGI4WmRpK1lwb3JHdm9hUm9a?=
 =?utf-8?B?UHVKeGRhYmNpV0t3YUhGajRRNXNMOTl1a2FoeGhha1l3anprZDZWWkxyeGFR?=
 =?utf-8?B?V3ZtK01UekRSc3VLdThCMVlGck50Wk85VjBVTWlwc1orTW84WnZkdHppR25n?=
 =?utf-8?B?UFI4M2hmWktpTjB0UXZvRysrNVE4SVpHUFNjZjRBWEIxQjlscmJjYXhyelgr?=
 =?utf-8?B?QWUvalFvU2VGSjJacDltcjVIaXlIVG9wODFYNkJQbnZmaUdlVGlpRDhJcEdh?=
 =?utf-8?B?c1lMaGpoVWZMS081RVlwZDVEcTd0NDE1N0hpMkZJekZhYUVia1pQSjlEclls?=
 =?utf-8?B?NDRMZWVZbWs4THBOTlV0S2N1TFJzRFluMEwxSWVqMEl4RUo5SmFHaGtWNElj?=
 =?utf-8?B?R3N1Ukh2RTltRk4rczBRL1NVc3ZrRXk0OXR0MWc3d0pjS2JkWW5vcTVQQzAy?=
 =?utf-8?B?cCtEZlJ1NnhlWlY3VUhxZFpFMVFCVXV4cGJsNlA5QlVFMWVYQ3FROHFOWG1s?=
 =?utf-8?B?d2hnVXpFRk1QUit6anZ0eEYzdWFNTTJUbTlkbSt6MVJyREk3Mzh5MUxtVFRN?=
 =?utf-8?B?cjM1alpFSktLNXJueWVuWk1uYzArMkxJNVhubDJ2MXRmaHpkSFduY2tQVGF6?=
 =?utf-8?B?S0FjTC9CQjdKNmVEdkJEU3QybjB4ZVhnUFFjMEhKQjIrOWw5UGdmV25NS2dt?=
 =?utf-8?B?ODVnRkswWFo0OG9mclY0ck9hZWhjUnYwYlpYeHpkZDR2V1IzUXZYZXBpd24x?=
 =?utf-8?B?UVpiSHFYL1pxZmIxTHRJSEMwQk1vL0I5a0w3eUJremxIL1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUVyaE9XcEVvaFNkZkpCYS9hODVSU1NaVUd3aU1oT29TNFd6NC8ydFpBTWhk?=
 =?utf-8?B?QVVXc2paZlVCUW56K1lmNlk2MkZxNHhBNkFXV2tiRWRRb0lGUUVtUDgvcFF4?=
 =?utf-8?B?Q2hwcDV1UHM5dVJzL09KL3U2aGJpUkE0ZjU5dUxsUUFzS1NRZ1pqRmJEa3Qr?=
 =?utf-8?B?V3U3bnYxRkNzOUlpNmk5T3l0Ym1JYUR6RUgwZ09Na29uTkRUdjhiVkJzamda?=
 =?utf-8?B?blVKUTlmRVJrZjhVMnE5ZDlmeHQ3dUtQTnhZTVprM3RYL2lKeDJabjhGWlEr?=
 =?utf-8?B?b0IwWE9YQUpZMXlVaDlaemZLNkw2VjRLYVVSUjJQOU5xMU4vZDRzWnNCVTNY?=
 =?utf-8?B?U1VBWjd2MmRiOWE3cWpMLzlxUm1iWVNjM3U2dlhZVmpPVm16RzJyVWJmc0gy?=
 =?utf-8?B?OTZEa1AzVFpwY3RvSy9nTzJDVGFtcW1NMGxLdVEvcXpacW4zZk54VGx0aVc3?=
 =?utf-8?B?Z1hyVkp1YkRQQTYvSmMwYm5xRUx2Zm5QQVdKdVZOenBPRU1RQ3JUVXJTTmhY?=
 =?utf-8?B?UFRUNzhoSDZJdU9VOGFvd0h5YU84REJKM1RXL2NNbWx1bVc3Tk53elFhNWRn?=
 =?utf-8?B?VjNHeFBoT0RxUzVzbWJTajZSdGQzejEwQmpBZ243WEcySENORGJrVzNJdWZM?=
 =?utf-8?B?Q1NEc3pNUHdreW42ei9BSGJzMWNpNDdURzV4VDgvMG5FTitMZi9UT2ZIaDRI?=
 =?utf-8?B?U05uY2RMenJPRUZOTUR2R1QzNUZMZE8vNmJwQjJ5ZU9RUWc3UVdBdUd4OTZi?=
 =?utf-8?B?ZUk0MUpYMlNJSFJ4aFdOMU5WSFNJQ3hBSnlMZTZ1MEcvUS9pTXZiOFZZTEZ0?=
 =?utf-8?B?TjZUOEdNQzFaWjc5cDR2blUyYnRhOGlpM3JNYTVhdVc0NENHSjNma3hlaTFn?=
 =?utf-8?B?NnYrTDZnQWtKb3RNNzBieVU4TGR4cDRmekhpcUIrMDJmeTFXQVdSR2VWMWJo?=
 =?utf-8?B?SE1kYmk0RGRjMWJJZ0dWSndzYWJLd0V6clpadkJUUUlRYTAxR2I0RWYvNXh4?=
 =?utf-8?B?RjNnbUF1VldxbXpPN3dmRUgvSnJrSmJzRDVNaDFjUmk0dnpFUTQwT21NaG9Y?=
 =?utf-8?B?Tk0wdnNlczBrNkFiUTVwVnZqaTJYeEd6TEtkK1JDMUZvMkFiRU1CY3ROM2s3?=
 =?utf-8?B?VGNGejYwVnZUdWlsN3ZJTWUxZGFKblk3QkxYVXN3cmxzUk1nK2lDRElBUUhC?=
 =?utf-8?B?RGpXSERTT1pNTzRIQUtiWUFPMGhybitmYWJER0hOaVQwZktzT1p1bjR0bW1l?=
 =?utf-8?B?TDhQTVc5TVIwSWJyaG54UGM4Q1dZTkU3Z2dZcUZrbThIZ0lCdytRUnllNkpC?=
 =?utf-8?B?dVl5dStWQmxQNDBPdHRUelZRTkdTbytUeE9tNlNWSmNNZlJyZ05BdFlwS1pE?=
 =?utf-8?B?dlRNZ0NpRGJJT1FnRldHQ3o3Z0NYSVZUR2gzYmhYbWRBeFFzeHVYZ1p4ZTNE?=
 =?utf-8?B?ckgyU2YzSFkxYTZqdlpFcitwRnZXbUc3aUVWd01zbDI2aUlQeEdraC9XTW01?=
 =?utf-8?B?a285YTh6dmhJRWxya0p6VFhBVEU2SmR3NGJSVFIyL0hvNG53R1dLejhJZXpY?=
 =?utf-8?B?K1E3VXB1bXRVWkc3dm0xK1luOHFjUjRrSmdoNW4vL1RQSVlOVVowb3REa0d1?=
 =?utf-8?B?STdkazd4MVE4NndzMjV0TGN3RDJMeEE5K091ZXFUSmxFQWlNdFd1YWpHVVA4?=
 =?utf-8?B?OWhpWWR0UnhzdVFzd0tiMHY5RmlqUHJVaklmckhENVFqV0ZSU0c3T3BvQzRI?=
 =?utf-8?B?WXdLc2phd0diWnN5RHNlelNHNkh1eTdmS3JQUHhKL0tDY0oxM1Z2QWNYbzZj?=
 =?utf-8?B?OWorSWRabWhOaEN0bFYrbDV1RmQ1aDhaa1ZuNTh2dFAvY290WFI5ZXhKVzFD?=
 =?utf-8?B?cHJrcE9oWGZHMER3dmtYNi9NTEVoZUxDc2oveG42UzdjQUFLWis1N2FQTVho?=
 =?utf-8?B?NmYrdUF1ZGtaeE4wcjBNYnVJaVFaTDBCcTkwV0Z3S20yNHJEMGRaeGxaeEF1?=
 =?utf-8?B?TmFVWm1adG5GSmZib3VuMDc1ejd4d01xV0R6RzdnM09EK0duK1hieG9tUjJp?=
 =?utf-8?B?NlY5NVRMSU9pOC9leUlsNFhRUy94ZVVzeTI2WEVESEZlR0tYSmlxVzRXbWVQ?=
 =?utf-8?Q?rX6Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603d5253-6a45-4568-1c94-08dcf47c17e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 22:34:59.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoKG1UzGMbzKRM469JAW8F9RYRyOHPsyZfnmkWzwiB6MctQGS+CWZCoRkhvT1c/zmF1uhM5ooTD+IyNP3Y64+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

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
Cc: Robin Murphy <robin.murphy@arm.com>

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- disable_device when error happen
- use target for of_map_id
- Check if rid already in lut table when enable deviced
- Link to v2: https://lore.kernel.org/r/20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com

---
Frank Li (2):
      PCI: Add enable_device() and disable_device() callbacks for bridges
      PCI: imx6: Add IOMMU and ITS MSI support for i.MX95

 drivers/pci/controller/dwc/pci-imx6.c | 159 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c                     |  23 ++++-
 include/linux/pci.h                   |   2 +
 3 files changed, 182 insertions(+), 2 deletions(-)
---
base-commit: 9a6b4af5bc27c1d3e5dc9f7fb0edd26047bb74ed
change-id: 20240926-imx95_lut-1c68222e0944

Best regards,
---
Frank Li <Frank.Li@nxp.com>


