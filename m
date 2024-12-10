Return-Path: <bpf+bounces-46577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9695B9EBE13
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 23:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4052283AC5
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 22:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B44211268;
	Tue, 10 Dec 2024 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bVZGUtQB"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99051EE7DA;
	Tue, 10 Dec 2024 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870963; cv=fail; b=mAfbohdc3/z560FtDawdaVq2qZzTryH1/4i47/hBToP3qngUGQgwkLD2rnU1lqsrgl1XTI264OOJCM6WIkY9+G9Xld7UWS6MSdJgVePrFN95PIHQglL5Xa4DhJmblQIvnB6iK81kdNcgkGbAseTsdM2GqmQLcWWyTru2cELpLS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870963; c=relaxed/simple;
	bh=HRvECFQA7StWB7pWk/IGaoQ4Bvx9a2u8BEJbLRBEmYc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HG6A3qyWhJua1SuTnSCLKmAdDImnZgQRe1aj4mDNjKjrkJBfhZh4b+Bo8O9ONJ/z/zoA+NoyERqeyIk/57y67rq9rgRb73X90zfpLoBg9fE55kx+uVTavhR7kaBugaWoWSQwsWbTsItB/ITDpIuFuzJjCdM2WAOEY3DvINjxI2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bVZGUtQB; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcJyiUXoh2kymg2rHe6b5Y7lX5gbiIZiqh4CsG9lhpCEx4ow3x/uPafBzuZ/vi/93BM6AIZL4ngtxYAG9jaCQ7fqHFKvoZSqZRLLUQ98ePv8aJICbhxtR0tmtv7rK1VRVM9ryGxF2+21ecll4qneArGTztls+YESRZsTCJUSNyZ6PnI/46JSW05A1Y7a3eyC/lUsnnambCtuZq1Slzu3E01+YhSKmHvf0QYzA1xz4xdouOwV5mHskrb1fVEz83jce4RU+fsqAt17bMtPDC2KvB38uRyAVI2t3ZubHVTmFu762JW3ZIZvkgSxnPsvJcmhXEbsO20VLmrEfeyrQ0CdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7IKGdrjwj1RdTdGQ56GK0ia4qm/q9umJDVy+Eznp6A=;
 b=A/YuIIYjjnXX9NKbt3FjFt46jN1AGU3hmjPm64JihzP0XsxWqenimhJGgmCyfk9woJWune6bm2sZ83LuwGvU4tm8tmtyIesnsa2iTzAESJWaMfljv73SoHMXc54qSJVY/iBdYIFQ3EKPJQJAxJhLS+sumCicAMyQB65cUkGbXmosXCRyXBizYiM5xBQiB3UsUmvgmq9m7itkHNoLTS5ENWLij/JdvMiF6yKSZ4do/a61UqLH82K44ZBaMrup/ysmjv4uA+OTUIcLFXhEhEniOcjM6IYcZD0pau2bw2jv697pTSVmuPZp4bZ4ePLBtpXSnGnQjjcnWsa8TswrRR1vSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7IKGdrjwj1RdTdGQ56GK0ia4qm/q9umJDVy+Eznp6A=;
 b=bVZGUtQBg/NIvr7/uWR0hc68DSRjMQA+RKZ9oyc3UG4RnfXeX1GU5pHkBCU/DAeGEtX3INsOYc57hN//z+2i8G1vSRgKJKAD8A3fFuRE5dl1nwBJsf3ooO+czUNItrjG8heqiNR8Vd+0KiLYse2YjcIcNlJYXe3vLxmInaS5lic3ivJI8+H7rf8H5gdxN4xDEsoQZv8NPyLTtMeg7pHsg7yFuFSHwV/dToI8jOaHnDbW6mTkEwYwGLm3QPuaJamh+tAeML4/tkXpAwXiJe9mtQOHG5DVvL1B32Nts+poxXcx3WO9Ehjd3Q4yerYILrgjRW3gvTrKjzJbTKrF9mY05A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6784.eurprd04.prod.outlook.com (2603:10a6:803:13e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:49:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 22:49:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 10 Dec 2024 17:48:58 -0500
Subject: [PATCH v8 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-imx95_lut-v8-1-2e730b2e5fde@nxp.com>
References: <20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com>
In-Reply-To: <20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com>
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
 Marc Zyngier <maz@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733870948; l=4347;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HRvECFQA7StWB7pWk/IGaoQ4Bvx9a2u8BEJbLRBEmYc=;
 b=2dHOhD6AYxIFhpI9rhrCSVylul64jHTTKVtwVlC1m1h8Riy5dVxCbEzVSJo6NEKzplISAyhxh
 crS4db/POyBCV2ybZLILuQwkKEiGHayzmVm1Do9ZfXLpjLj6M5INhdD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 014e3707-9ed1-4644-0f7e-08dd196ce22a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDF1MHdNbDFRb3BIS0Jld2IyeWtkakY5b2ZuS2FQOW1mSmVENTlpbEFKN3RL?=
 =?utf-8?B?cm1jNnBKZk1mNXpCMjFxd2xjeDhHY2ZZaGh0TW1IQ2tXNCtaZi85SExSTkxW?=
 =?utf-8?B?eU1QdE1sdld6aEpSMkp6bmZoNkMyMDAxdEE1eHYyZWJLNCtGaVFoVk1Qb3ZU?=
 =?utf-8?B?NzNkUXFPSk9iS3hsYVZqSThBTEY0N25UUkVWQWxKZWJ5aUxkTFVQZlZzUmFs?=
 =?utf-8?B?c3RDUFJCS0xYajFEdnIxU2xmYVk4R0crVENWRmJ2Yys3aFhzdUNNMWo5NUdj?=
 =?utf-8?B?MlEvMW1rbHgzanYzblRKVXlod3dPQUJmWTMzWXpSOGRON2dRYXNIRUhBR1Br?=
 =?utf-8?B?VzNVeThRa0pQbmZ4YWRjL2VqdTFsMTVxbDZUeENQQnFiSWZNV0xEOG55K1Zo?=
 =?utf-8?B?bStUam5raDVhYUdRT21KR2k5L0l2cUxvRG5hQTlnS2ErcDl6RkliZDVRQmRw?=
 =?utf-8?B?b2VEYm1PZ09odzBhYXBXMFNYLzBxcXovU3crUXhGM0Z1OFJ1dUEwQnh2U0Iy?=
 =?utf-8?B?S3ZSeXJwOW1NeXFoRGlIQXhpWCtYQjY2eXF0Y0dDcWJWeGtXRWxDS0d6Zk41?=
 =?utf-8?B?WUllK3dwU1dwL2tSQXkycEhRQ1A1LzRtdFlDKzFEUndlRDJqQkRIRUJwS2xk?=
 =?utf-8?B?S1B0eERIb1Y5TjdmQlFXbEpvT3A3VVdqdjlLYkIwdXlaVTM2eFBhM3pZbzdm?=
 =?utf-8?B?bWVnSjVzYjk4bVhCK3dOWlM5Nm1hL2hGbXRJRWJlUTNZOUs3aFU0TGhyVVpw?=
 =?utf-8?B?VUViVVdZNlhrY2g5RnNhUzBUcjAxQ2pkNEFycnFmZXp1QmF1OE1xMFo5ODE5?=
 =?utf-8?B?QVREaWZDVVd4WTQvMzRxOHpmRFNOWUc3SnlxcWVwa1MrNHNwUlE4dit1cjNY?=
 =?utf-8?B?N2M3R3d2aEpYb3l5OXRhcHhpS2FpOEt4OXd2ZlZmU0pSQm91eStnbjJlZi9m?=
 =?utf-8?B?SDRtVFlPczQvdE44NkNvTXo3YUY1eHluTUlyOXJZaWhldDdneTY0YVArbVZ6?=
 =?utf-8?B?cE9UTmVmTXVmdkUvMVlOaC9pNFJ5QVJGUXFyMk9OeVhFeUVRU2E5OC9xUmZj?=
 =?utf-8?B?MEFCSG5zN1FhTk8zdzRoc1ZUWjVzVnBTNTN2RDhReVdNTWlwbDFRckwzWkg5?=
 =?utf-8?B?Q090djJzaC95SEF2Q2d1WklNaEY0MXNZRTdqRWpOTFlObjBuRGx1MERJU0pX?=
 =?utf-8?B?QnIxaGs3cnE4SDRiSmVYcGFmdGN3S3ZaQi9saUxRQzJoUWc0ZjBuWk5KWXlF?=
 =?utf-8?B?amd0MjJOeFBVMWNBQkJaR0t2dUxuQUxncGUraGsrN2JqYkFXcFZ1SFJ3d0J5?=
 =?utf-8?B?VEFOWlY4bklZVUE5UXFUaENDbnNNV1VNM0paYk5KT0Y4Y1R2eUxJT2lNYTM4?=
 =?utf-8?B?N0w3Wmx2WTJjeXlYdENsdjY2VkVOVU5kTklHcFJ0TUVxWFJVVHdhRmZhUmpi?=
 =?utf-8?B?b2Q1dzhZb1AvWklzY0FOUnZySUczTjB4a3E4OTBBM2s1UTRQU0Jjd1VJUEs3?=
 =?utf-8?B?eEhHRWhDQzJlQitQdGxtR0t1RTFhbm10SWx3YnptYnM3SExubHNpYjY3bkQ1?=
 =?utf-8?B?ZERjcVRkc2o4bU9JeTN4M3c3ZUwwampTRHJYMEVPNXpqek45U2lLT1RaakFJ?=
 =?utf-8?B?TFA0dlFxUzRLUURBcStUMXl2aFRBNGVxb0svTnp5OFhnb3FZcjduSlBsL0hp?=
 =?utf-8?B?bmx0ZmNHWDdDUlRRQ2NVSkpVbE4yMzR0ZzFMRWM2UWFmZjNvSXVJV1FobmJ3?=
 =?utf-8?B?dFZuYnNQVGg4K2RaWHVsd0RtcWZ5SzdnRytxN0dqMXdKVUVQT29NMm5BdW9t?=
 =?utf-8?B?OW5kVjVidXM4RGE0NURDRmw2TFNkckIrTlkwQkRGc2V1OVJ6UHlpVHBuUXVm?=
 =?utf-8?B?SktVM2VrdjdKSjA3ai81ZDBUOGczSWlubkZtQW42bG9Kd0tHSEN3eGtMcnBx?=
 =?utf-8?Q?LUQyTB6b8i0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFFJN1grVVVIaUJXYjNhSlAxcnFOS2dnNmhDbzhIQUg0VkpqSjNicG55NGZ0?=
 =?utf-8?B?SEJtSDRkQnNaQ3pSZGNwWnloT2VjSjAyL0NuUkJUcWhocXdYWFZ6d3VTVU4x?=
 =?utf-8?B?VXVQVS9jOUsxYzRlQVZtaW5tNGptTytmbXZ3ZkQ4Y3lwamdwQzhRS1BDeUVo?=
 =?utf-8?B?eFI5cUhwYkNTaDVZbkF6emp1R2M4eUh0OGsxS3hFejJJaXFHM2tkK1VtNFRp?=
 =?utf-8?B?VmhRT0hFZHJVQ3M2ZlJPN3hocVo0RmNRcDVPc1FTOE4rSEdBclBPbTQrOUor?=
 =?utf-8?B?ZkVrNzYwYmxWWXlxZnkrSTFxYU9HdktBRDMrOVpTbWhaOFlaQW1RSW5EcU1Z?=
 =?utf-8?B?U2FJcFYzOUMrVTh1c2VudlFxYmxyejZncGM5Q3NLZVB2bkFUL3JoNkF2cnVm?=
 =?utf-8?B?VkNUcXRoRkh2aXdOd0dLZnJpUVpwb05Mc0JHNW5KVkl2anh6QzlvU2l5VjNt?=
 =?utf-8?B?dzY4d1Z0YUVYZ3JPUlVDSVNsVjBOQUZ5R29BWTJWdUl4UnkzMDFyWDlDR2RN?=
 =?utf-8?B?dnZNOTdtdC92WnJKWjhjYlA4S1pQMjEyNFp4ZVVHYTUwR0xXbzIzT2xodE4v?=
 =?utf-8?B?Wm8wWmQ0ZjBYWE45azhsSUlucEVDZjJXZURBQ1BDakhvLzF0azNFTURUQXZP?=
 =?utf-8?B?MGI3VGRTazVMVmt0RlYwTGJXRGFRamYxc3VKMVk3RHZZZ25TWS9PV21oWVAr?=
 =?utf-8?B?SS9tWUlEUmZUTWE1REkrbHNhM3o4RHlUZGQvblNDSTFHUThoZHRmRXNSdnFT?=
 =?utf-8?B?a3g0ODFINW9DV1VTQk82Mkw1REVHbWd5cktkYzVDNlZLa3crVm04OWc3Yzhq?=
 =?utf-8?B?V2M2bVh4RzhkSm9FeHgxbk4xSThFVDNtSmYxcXlmWndrek5JSkg1R2dXcWx4?=
 =?utf-8?B?OTVwdkJtcXphaWs1c0RtU0s1QWdtczhHZjB0b083L2c1QWMzSEdhOWs3M2pw?=
 =?utf-8?B?U0ZvVExveGY5QmxRVklwRzNMc1hnbXdjcXo3QU1seU0wa0hrRnhMQ1ZQMmZI?=
 =?utf-8?B?Q1VNYVYxbEg3enBkTHRuSFc2MmdyZ0xGL215M0Q0ekhRZDMwamJ4MWcyTmJG?=
 =?utf-8?B?RmR3bXBwcHdJZUdJaGU4MU9QUGJQTjdUcHh6K3YzOGpXcmIyUUU0ZVVNdWVs?=
 =?utf-8?B?aytoUFFqMllYRXkzUHNaRGNmcG1WdjBKSHA5YUxmUUh5MkRFcXVPV3lodEp2?=
 =?utf-8?B?ZUVSeWJaV1BpSTUweUdZbFJPTEh1UVRSS0F6dE9ZZGtGN0EyWkszc2x2Q0xs?=
 =?utf-8?B?UmgvY1I5cWRJNDdLclNDTGVrdU8yZlFYOVhTRUsrelcvYmxXUmZ0TlpyUEhF?=
 =?utf-8?B?bGFYVTJ1QUVSalhRdzBhaE5wdU1pdGU4bkdYYmErNHljN3NySnlyaTdDOXBS?=
 =?utf-8?B?ZkJOVTVVaEtqYXc2WGxwR0hJaGtOaGhpWGxBWS9mYXZjYTRHRExTWWJ4VWxk?=
 =?utf-8?B?MURoZXZnbjFOVUQyK0g3RWQ4ZWtGZDAvdEZUbDlKOUhvTEY1TjlTdjRqSG1y?=
 =?utf-8?B?RTZqMm9jY0JvVnZVazRiSDBTMGdSSWliZ0xuc2JqN3ZLcUJNSWZtTDFxd0RF?=
 =?utf-8?B?LytvbzZ3RzZQeXRZS2x4bTBzSWVQSGozdEFXSSsraU0wTE9FZTQxZ2JXeURo?=
 =?utf-8?B?V2pDcG9SRXI1SjFweE1LemZxekFaSmFCUFJpOVRRUUFrQTZTT2E1dURNR2xD?=
 =?utf-8?B?M2IwQkYwdzdmMUJPQ1VZMjBteHpOcjREdklXSkl2dWdDN1hveWFFT1FEUVly?=
 =?utf-8?B?Q2NJSDlKVzBPL01KR0hIbHg0MVdRNVZrb01OOGlIN2xYRFhFZHp3VXRzUFVG?=
 =?utf-8?B?RjhSZ09Zd2ZlTHZUd0ZkbXdrYS9mamZIdUp1V1lFMjRwM29NR3lGK1hIMEJi?=
 =?utf-8?B?c2gxZUI3d3RudWlmM3NJZ3VxbGVNdjhOTE1oUTBpbEN5TGtQaERIcHBwa1hp?=
 =?utf-8?B?TGw2S1l1SHE1NnpxNHA2NDI0MUUxN1p0dTNveFQxVzI3VytCUXdLM2dUaCta?=
 =?utf-8?B?QTNHOHJ0MlltRzRYQ1JPUDZQUFRlb09SOGJOeWFNSU5LMWVLUi85ZXV6VlpY?=
 =?utf-8?B?U3p4WFFWWWNOYkxnZFZtdWVXOForM1RzL0xyVVFKc2lIVUJZZW8zQlFQMDc0?=
 =?utf-8?Q?lxpFfUJo33hA5yPtiK6S3TG88?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014e3707-9ed1-4644-0f7e-08dd196ce22a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:49:19.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AerULrSAY7tx0TBvFSli0gPM7aisS5C5s9+rwZ9ylpIh+eQxo76oDJtck5CrosmBbcnS1eT+Z/Updfa+EsapSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6784

Some PCIe host bridges require special handling when enabling or disabling
PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
to identify the source of DMA accesses.

Without this mapping, DMA accesses may target unintended memory, which
would corrupt memory or read the wrong data.

Add a host bridge .enable_device() hook the imx6 driver can use to
configure the Requester ID to StreamID mapping. The hardware table isn't
big enough to map all possible Requester IDs, so this hook may fail if no
table space is available. In that case, return failure from
pci_enable_device().

It might make more sense to make pci_set_master() decline to enable bus
mastering and return failure, but it currently doesn't have a way to return
failure.

Reviewed-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v6 to v8
- none

Change from v5 to v6
- Add Marc testedby and Reviewed-by tag
- Add Mani's acked tag

Change from v4 to v5
- Add two static help functions
int pci_host_bridge_enable_device(dev);
void pci_host_bridge_disable_device(dev);
- remove tags because big change
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>

Change from v3 to v4
- Add Bjorn's ack tag

Change from v2 to v3
- use Bjorn suggest's commit message.
- call disable_device() when error happen.

Change from v1 to v2
- move enable(disable)device ops to pci_host_bridge
---
 drivers/pci/pci.c   | 36 +++++++++++++++++++++++++++++++++++-
 include/linux/pci.h |  2 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0b29ec6e8e5e2..773ca3cbd3221 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2059,6 +2059,28 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
 	return pci_enable_resources(dev, bars);
 }
 
+static int pci_host_bridge_enable_device(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
+	int err;
+
+	if (host_bridge && host_bridge->enable_device) {
+		err = host_bridge->enable_device(host_bridge, dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void pci_host_bridge_disable_device(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
+
+	if (host_bridge && host_bridge->disable_device)
+		host_bridge->disable_device(host_bridge, dev);
+}
+
 static int do_pci_enable_device(struct pci_dev *dev, int bars)
 {
 	int err;
@@ -2074,9 +2096,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	if (bridge)
 		pcie_aspm_powersave_config_link(bridge);
 
+	err = pci_host_bridge_enable_device(dev);
+	if (err)
+		return err;
+
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)
-		return err;
+		goto err_enable;
 	pci_fixup_device(pci_fixup_enable, dev);
 
 	if (dev->msi_enabled || dev->msix_enabled)
@@ -2091,6 +2117,12 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	}
 
 	return 0;
+
+err_enable:
+	pci_host_bridge_disable_device(dev);
+
+	return err;
+
 }
 
 /**
@@ -2274,6 +2306,8 @@ void pci_disable_device(struct pci_dev *dev)
 	if (atomic_dec_return(&dev->enable_cnt) != 0)
 		return;
 
+	pci_host_bridge_disable_device(dev);
+
 	do_pci_disable_device(dev);
 
 	dev->is_busmaster = 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index db9b47ce3eefd..bcbef004dd561 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -595,6 +595,8 @@ struct pci_host_bridge {
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
+	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
+	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void		*release_data;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */

-- 
2.34.1


