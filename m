Return-Path: <bpf+bounces-41135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2682C9930ED
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 17:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365341C21296
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D5B1D6DAE;
	Mon,  7 Oct 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f9s948XK"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11474EEC9;
	Mon,  7 Oct 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314368; cv=fail; b=XPohXz4GHIzF2oRDxNIA0TJZgdCnV7h7AoOYT2nrYqHwjxg+sZ6or8UnlzC8wUW+pFA2kFWECaBfwiCIjsuCoSJUCGRFYN22r38hioj+oEGsnymiB5vHbx72HkJRe+EgrO2rMt8Gx8chJHqDIwuJOQYTX5azqKVc7dApkFYdpyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314368; c=relaxed/simple;
	bh=dtZSK++3ZXafgsLBzMMixEZlNrOn77olA3HEe5m81kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tS8y9fouWzIBLOLpSP/CnORrvyppw1o80tvKm0QSsMdnaG3qUWHpuItd55q2RlRAK+Pg3fFLxYUhsYGln5f/T0FQWk2iWyTfW9f2cKyuayCwVvNbHButXwnxETDEO9Dw7ba9afB2PAtQA7vCIK2PQstZju2AXoELoAk0/SGqmes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f9s948XK; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Avdm1hUThWGl+W3v81o6T2w3zT7JeXON8S2UbGjq2HtT9LA5tMkfri2Gb1GFjAj5qmAqM/NtW1nWn8V1cthRHQm0kwgflLwEWtdFy6UxOyTFbnQJkA/EFv5f6S3erkJTwFNI8sxhLJk6D6Du3kOYTsgdEUiamwCd+pK2ZBCTRxvu9h1AaW+HcjLX+97LjcK1wAu7Ln8Hg8l09JEOc0i6wsYvS5swzMRKotvyi+lvvV5BG7BGsb4WVrw0iC9bUru+lN9bQKrki85gNsy3xEU1bF1M6xzUkXEFYLuF3vvAlNsKxI8OLfH1L28ijgG1I5UhSKb7za3uLkxZlXEN3k840g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHh1FLrWYBdU5XaJBNmzYzHfLGxEem/B8eUaquqsDvw=;
 b=kzzANHTQfmRHsIkl+PPywEgICNMZJdrCxkghv1LP3gO4UELYNI5yVwA5SC7Gy9g29lILw6Kh4HAxzCucpNSIoOSXsG6D3mDXkvNMu6z5+ht0h8Zv1JggnZosXm0o9Iu3qNuOYagulrUYADkwmP7Wvp7z/Mz3kWfIX7ksp7GCz7lam7Ynr3QqtLgEwAbJkz/vP0zpwlEcDHpi7wlyrRPvzR0Sk+LC0HnbWujHVTZg4rsnNKjoTfH4WDWDawxlnL8RtL+rmuicwmDEYhrGrh0F0Hiq5mMUqfTt0so5+z3DUlQrfa8BHTedSYbdyifv91wylOtCKkbveMbGJn+PI27siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHh1FLrWYBdU5XaJBNmzYzHfLGxEem/B8eUaquqsDvw=;
 b=f9s948XKLuF7labLXT0uY0xCtRCsZlkoNWBW5m8OVvrJRZtDtzYg7OEwc0BSG43XVzMNDfssqXuh6Pz5WVTgle4VFux6ndIARUpSywULOoqf87Jp5KpcJUHJPZg5yljr3RUtsiprEIX4MAJFgHA/+kr9fKsnYOtAwZ3QT5gX4mR6BZx952jgLCV77U/DKRT7F4TyLnzaK56Oo5U0MQFWbqD95+ljyccFHZjc5f8TfqkrblYxzmOky1wOg8jluEBI8HPuzrOX45zMgnLYBbRpPVr7t2qf8SsRnlcSghMVfA4omOHdZFT2sXCAlU3BjFI4ug/GvE9gnk3J6iNNLnPYlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10307.eurprd04.prod.outlook.com (2603:10a6:150:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 15:19:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 15:19:22 +0000
Date: Mon, 7 Oct 2024 11:19:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v2 0/2] PCI: add enabe(disable)_device() hook for bridge
Message-ID: <ZwP77tppA5N/KIrM@lizhi-Precision-Tower-5810>
References: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
 <20241003051528.qrp2z7kvzgvymgjb@thinkpad>
 <Zv7t9HnRsfTxb2Xs@lizhi-Precision-Tower-5810>
 <20241006175047.xgy2zyaiebvyxfsi@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241006175047.xgy2zyaiebvyxfsi@thinkpad>
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10307:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c0f0ad-bdde-43ee-0e2a-08dce6e36bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlY5ZlRjSDQ4a095QnBwcTZncHB0Y2psQ2RrQm5XK2Q3U25GY1ZicVoxcjRK?=
 =?utf-8?B?Zjl0eXZYOVlyRm5samlUNVpTdDJGa29qR285VjdQSG5oaFhQelNDQmFUNW5B?=
 =?utf-8?B?dUpJZSs5eTU1Wk1PaWxBeHArOGxtSk9ZSnZlb0FQcWtOSUg1c0l3WEdEOUNm?=
 =?utf-8?B?SDVRTWhBb2tkRVlJWFdWakl1RlJjTDNtaUd2eEZ2alc5U2pJcW1rOUpJdkd2?=
 =?utf-8?B?Z1NvNlZUcnA5Wm5kQis2RjFaUnI4dXB0MGpGZFlFVjAvWklqcUd5SkpJa1Vs?=
 =?utf-8?B?Q1AwZXlCMUM0a0hwa3dWNWN0azhmR0VTbEFVaER1NnhESXVudE1MNFp6QXll?=
 =?utf-8?B?ZE93b3MrWGtKNzlxcm5nUlAzeXUrbDNQaGxyNnFjZng2TElqQzlmaWZINkFV?=
 =?utf-8?B?SXZMNnMvakRZby9oVE03dHVWZnlyME10VFNDYlcvWWl3NUw0WlJ0QWtWbWFp?=
 =?utf-8?B?dng3QlJBV1lsS0lkRlJEVm5nbTFUNktiSFVoMlZzc01QRlpHR2MxUkR0Z3ds?=
 =?utf-8?B?bFRaTWd0NHY2MEhGUEluUDltTFh2azBFWm84bjhZb1ROT1BkQ2JQTXRoOGxa?=
 =?utf-8?B?UU1sT3Rsc0ZOTlpwbG5zSzhCbUpMdFAzOFpZcEdXUVJDYjdxTjQvOVhIZ2w5?=
 =?utf-8?B?c0lsZVFsQjdWQjh2RThKenZpaS82U1RheFg1NHVReWFGQ3Q2US8wdE1BUE81?=
 =?utf-8?B?dXRBTU5obCtBVkNFWFY5ejJHTDJNSm1nN3RZS1ZXU3BzczJMQnl3TWxOQ0VZ?=
 =?utf-8?B?WDdaZ01Gb1RKcEoybW0xdk9lb3JaQkphYzhpbTMreXFESDFZVDUrbnZvWit2?=
 =?utf-8?B?NmYrMVgvSkVtelR0SVJKbm41QTBPRFo4WEhyWXhlNnFlQVMwN0VIYUdJbER1?=
 =?utf-8?B?TEZHdWhGYm1WZC9GQSttMVVvMkV5UlJJZDJWSzU5dkwwbS83eWZMRzNnQitQ?=
 =?utf-8?B?enE4NUNkYzR2NzB2UE1CREpmQk9jcG1RTWpnQzIyb3RscVU3WUJ3bjE4TUJ3?=
 =?utf-8?B?eklzOHVPM1o5bERJQjc2eEgxVlFVbnB3QlRsd250V0t5RjczT2tjTkhUK1U3?=
 =?utf-8?B?S2F2Rm40eXhhOGFYOFpVZHRLQ3E4R0dwYW1OUTgyYlBUekJwU3BPUDh5V3VN?=
 =?utf-8?B?ZWZUWEZEazJITjNGWHlWWi8vNUwxK1lrZHk3ZGRIbUlGVkRJanZHR0V0MkI5?=
 =?utf-8?B?d1R4YWpkRGJTWkZ0d1VaUDR4Sm9CVkxWaExIZVAwQ2JqTXd6eXkxRXIzTUxX?=
 =?utf-8?B?cExPNUl3QjgwWkwrMlJBV2oxS3BUYWNQd0RPSDBMOGpqVWJDOGV2YkkzSW10?=
 =?utf-8?B?MHVubTRTYlY0NSsxMVk3SHpnWjdqV3BIeU42OWtXOXQwVzJ6RFZUT2owL3ND?=
 =?utf-8?B?MWppRFJjUEc2dVN4dFloL3BXMXozaVlLSFFBV2oyTXFtN0V6cHRwcnV5WFNl?=
 =?utf-8?B?QU9WanMzZDd0eUhkOC90bWVqNGlHSHpZSEt0RmJhWkJFYmtxdEJhQVFEY0U0?=
 =?utf-8?B?UDBMVXpJSU9la0M2VTlWbWVNQ3QwUkdBSmxQbzI4bUNUaUxUUXNZSExZd0Yv?=
 =?utf-8?B?RnRYNFBXLzRJVWdaT2UyRG5NRkM3L3RUaWNjQjJLblZHdlhkRUJGcGJlUC9B?=
 =?utf-8?B?Y3lWaFJ0UWkvVUk0b29EbFZyNVk3bE9YeFpmM1NCWG5UdzN1MXQveDkvQXF0?=
 =?utf-8?B?cEE3RDBvakJQNFdabG1wcUNJYk5YOFdKZkd6ak5jMTUrQUF4NzhIK2trVW1J?=
 =?utf-8?Q?9nrm7ufL7ZMLHlinro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1lHdzdnWjRnc3lZNktFZnpXQ0Z1MGExRHVXaGVYc3hDenJCeHlKSE9kT0o4?=
 =?utf-8?B?VzZIZk43QjJjczdqcHNsQ1BpRmhkdjFYbHA1L0xIMU0vdldkL0tBb2NoQVBs?=
 =?utf-8?B?RjhnbjRwSDJIbCt4dE9vM25lRVo3d0NqNDlFSUJERlZrS0NiZGo4TStKRiti?=
 =?utf-8?B?MnBSNEw4MEVDUHVHaHMxa29OV3JzNmlxUDY3VWRxa21zZG02MENyQjdEZFdW?=
 =?utf-8?B?UFpxZ21GQ01IRWwzVGUrbXYwVFE1U0YyZG5rZk5sTjVDMmNBbE1OL2ZXaXN2?=
 =?utf-8?B?ejlWb2VyVEQ1LysvVTIvdEM0VjZkRHU3c0d4Z2VrSE4zNmZFci9PcW9rcWtC?=
 =?utf-8?B?OTRyT0p4NXlqLzFxN29nK1FGMDZxZ3U0RklSa1ZlaXlraGhLV3l2cGtRR3Vw?=
 =?utf-8?B?OGJzQll4eDByL2J2bkRVY3lDSEhmOVE1NUZjV0F6NXduZVZ0UW1xQi9Gellp?=
 =?utf-8?B?aWVqbnEvb2lOSEU2ZVBTQ01ZaXZwU2JUNTFiOHdZaHNXNXBiVWlXeThKanBS?=
 =?utf-8?B?d3NMZlhKdXNPeTRQTzZMa1RrVHVvcVFvYmZQNXhkSERlT3Z3WjNrd01lTXR5?=
 =?utf-8?B?SmtnUU41cW5EcERTdytSV3dndXBoWFBIUkluMXlPUk81aVlOckYvOEhyVTlx?=
 =?utf-8?B?ZTVTOWVBOTJTQjhjVjROL0tOSzBUK0JHVzd0Tlk0U3c2VGt6YnNNampZbDR2?=
 =?utf-8?B?NjRWdWw4cnZaVHlIeTVRcnB5YWxRS1JYdnJFckVDYUF2Y3ExWWZmUE42N00z?=
 =?utf-8?B?a1ZzOWRWbHExcnBvOHdENjdEZTlBTWRlOTE0Z2g2ODVJd2xqSnUzVVUrV0Nj?=
 =?utf-8?B?RTlNbVFQR2xqQTNGWVVSSlhwSmxFRnF4NGxlZjVESjlZUVdtS2NuNnRySVl6?=
 =?utf-8?B?bW03d1JUNytyemdDcFZPbkpEb1JQMzNqT1BtT0xIYXJ2MlkzSXc2cVlqV3dP?=
 =?utf-8?B?a0NHOUp1ZkVIQnU0Tm1OaFA5cWVUZUVEZjBoWHRLaEJka2pPMlhDa3c3MnN5?=
 =?utf-8?B?TjZQMzlVU0VXV2NhekljQWhmNCtTSEpwRVhFT1laSmtPL3VFY1dDS1JDMzVv?=
 =?utf-8?B?QnFlR3FZbGx2L2U3dnhWdnZxYmNvcDYzdm5lNVAxaS8raStYUHkrMDRaZDZZ?=
 =?utf-8?B?b3B0UnlrSzNCcFpmb0dzSGJwSW1VRXhHdTZiYkt2K3ZzREpGazRGY3JpaWVx?=
 =?utf-8?B?encrL2tBUmo5VEdxN1B6WlFwbEZUOWdlVFlNbUJNWWZiUUptR0Z2cjcvSm1o?=
 =?utf-8?B?UGNXUSs0ekt6aGFUS2FlYzhQY2hkWnBJRGVyalA4b2JVOWcwZjg1ellvVXpn?=
 =?utf-8?B?YU5BTlZrdzg5MEV6Yll4TlVFSWxiczFxQkp4WXZJeWh3UGFUaVZ0eFZrS1E4?=
 =?utf-8?B?UjhDamFhcHZLbXRXQVd1V3lUckFrSmVEUkZZVkdNZ2dLM0RvOHRnMTRINmhO?=
 =?utf-8?B?ZTBsbnBiMWxWY3pXc2xOR2dqbGtwRjNMY3liYXI5UXBOaDlWM3dITVk0Vk1T?=
 =?utf-8?B?dTA2akJaeW5uLzM1Zm96RHRoaGNWR3hUZm9xdC9Od3hweUpzR3dia2VQL3pj?=
 =?utf-8?B?dU1id1ZaWFNZdnZOaG9KbjRjYzUwbFh2UERPdHFDS24xMjB4OFJhbkptMVJn?=
 =?utf-8?B?SDlwMUdGTEsxVlFqbU13cVVONWFMcHpmRndBT1U1ZHg5MGpkQWhMS1UzOXlj?=
 =?utf-8?B?Yk5VcUtGNWwvR1BaNUY0OXBqZk5wQ1dsenhiemRNbW5aVEFLL0FEZnFTZUlq?=
 =?utf-8?B?ai9kc1FQdjdocGc2akl0Vk43Y08yeGRlLzQrTUdXQlB5M3JCSEdNUGp5L1E4?=
 =?utf-8?B?KzlBeWRPWVFoQzEra3BoVm1ETzJCazZYT0M4bjV2bjlOM28zWVJpSUVrOEtV?=
 =?utf-8?B?ank3aWs4ZFUwNHFSdzJXYzd5M2swMkNON0NCM2EyZmpCRWkvZldRWlU5bGl4?=
 =?utf-8?B?TURKa2d2SFFPL21qTnNaMHVYSTN1bzUxdktaVEozRnlrMm9wNEtKT3c3WmZU?=
 =?utf-8?B?Mms3cmg5L1pIb3NXamxlNHlNS3dFcEljWjJiMDlpSGhINm9HcU5MNlZUT0JE?=
 =?utf-8?B?OE0vYythV2dNYzdKUzZ1SmJuRlNRdWVGWXpGQjFQS3MzRW11MXIvOTNIK0Vu?=
 =?utf-8?Q?vzVqXzKBW5P2f9lldqTK6Lk48?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c0f0ad-bdde-43ee-0e2a-08dce6e36bde
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:19:22.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5DaCMkXFwlvUuKHiskl+sccZ8Y53z7nMxQRV9mtqToMsPKHYJWqt13E7wgJVVNP69dz2WzDAT6X90BRyRw9IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10307

On Sun, Oct 06, 2024 at 11:20:47PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Oct 03, 2024 at 03:18:12PM -0400, Frank Li wrote:
> > On Thu, Oct 03, 2024 at 10:45:28AM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Sep 30, 2024 at 03:42:20PM -0400, Frank Li wrote:
> > > > Some system's IOMMU stream(master) ID bits(such as 6bits) less than
> > > > pci_device_id (16bit). It needs add hardware configuration to enable
> > > > pci_device_id to stream ID convert.
> > > >
> > > > https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
> > > > This ways use pcie bus notifier (like apple pci controller), when new PCIe
> > > > device added, bus notifier will call register specific callback to handle
> > > > look up table (LUT) configuration.
> > > >
> > > > https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
> > > > which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
> > > > table (qcom use this way). This way is rejected by DT maintainer Rob.
> > > >
> > >
> > > What is the issue in doing this during the probe() stage? It looks like you are
> > > working with the static info in the devicetree, which is already available
> > > during the controller probe().
> >
> > There are problems.
> > One: It is not good to manually parser this property in pci host bridge
> > drivers.
> >
>
> Why? I see the comment from Rob saying that the host bridge driver should not
> parse iommu* properties, but this series is essentially doing the same just in a
> different place.

Rob's means is that host bridge driver should NOT parse "msi-map",
"msi-mask", "iommu-map", "iommu-mask" by use low level dt read property API
function. It should be fine to use high level of_map API to map rid to sid.

A typical existed issue of manual parse commom property is
drivers/irqchip/irq-ls-extirq.c, which missed consider "#address-size".

This series use of_map API, instead of parse msi-map\iommu-map directly.

>
> > Two: of_map default is bypass map. For example: if in dts only 2 sid, 0xA
> > and 0xB. If try to enable 3rd function RID(103), there are no error report.
> > of_map will return RID 103 as stream ID.  DMA will write to wrong
> > possition possibly.
> >
>
> Well, you can use iommu-map-mask to allow all devices under a bus to share the
> same SID. It will allow you to work with the LUT limitation. But the downside is
> that, there would be no isolation between devices under the same bus.

But you can't do that for GIC ITS case. Device A have msi 1-16, device B
have msi 1-16.  You can't shared one SID for device A and device B. ITS
also need stream ID.

>
> > https://elixir.bootlin.com/linux/v6.12-rc1/source/drivers/of/base.c#L2070
> >
> > Three: LUT resource is limited, if DT provide 16 entry, but LUT have only 8
> > items, if more device enable, not LUT avaible and can't return error. of
> > course, it may fix dts, but It'd better that driver can handle error
> > properly when meet wrong dtb file.
> >
>
> Drivers can trust the DT, unless there are evidence of broken DT available in
> upstream or got fixed.

The problem is the broken DT should not cause fatal problem as much as
possible. for example, broken DT can cause PCIE doesn't work, but should
not cause system crash.

Frank

>
> If you really want to validate DT, use dt-bindings.
>
> - Mani
>
> > >
> > > > Above ways can resolve LUT take or stream id out of usage the problem. If
> > > > there are not enough stream id resource, not error return, EP hardware
> > > > still issue DMA to do transfer, which may transfer to wrong possition.
> > > >
> > > > Add enable(disable)_device() hook for bridge can return error when not
> > > > enough resource, and PCI device can't enabled.
> > > >
> > >
> > > {enable/disable}_device() doesn't convey the fact you are mapping BDF to SID in
> > > the hardware. Maybe something like, {map/unmap}_bdf2sid() or similar would make
> > > sense.
> >
> > It is called in PCI common code do_pci_enable_device(), hook functin name
> > should be similar with caller. {map/unmap}_bdf2sid() is just implementation
> > in dwc.
> >
> > stream id is only ARM platform concept.
> >
> > May other host bridge do difference thing at enable/disable_device().
> >
> > So I am still perfer use {enable/disable}_device().
> >
> >
> > Frank
> >
> > >
> > > - Mani
> > >
> > > > Basicallly this version can match Bjorn's requirement:
> > > > 1: simple, because it is rare that there are no LUT resource.
> > > > 2: EP driver probe failure when no LUT, but lspci can see such device.
> > > >
> > > > [    2.164415] nvme nvme0: pci function 0000:01:00.0
> > > > [    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
> > > > [    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12
> > > >
> > > > > lspci
> > > > 0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
> > > > 0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)
> > > >
> > > > To: Bjorn Helgaas <bhelgaas@google.com>
> > > > To: Richard Zhu <hongxing.zhu@nxp.com>
> > > > To: Lucas Stach <l.stach@pengutronix.de>
> > > > To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > > To: Krzysztof Wilczyński <kw@linux.com>
> > > > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > To: Rob Herring <robh@kernel.org>
> > > > To: Shawn Guo <shawnguo@kernel.org>
> > > > To: Sascha Hauer <s.hauer@pengutronix.de>
> > > > To: Pengutronix Kernel Team <kernel@pengutronix.de>
> > > > To: Fabio Estevam <festevam@gmail.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: imx@lists.linux.dev
> > > > Cc: Frank.li@nxp.com \
> > > > Cc: alyssa@rosenzweig.io \
> > > > Cc: bpf@vger.kernel.org \
> > > > Cc: broonie@kernel.org \
> > > > Cc: jgg@ziepe.ca \
> > > > Cc: joro@8bytes.org \
> > > > Cc: l.stach@pengutronix.de \
> > > > Cc: lgirdwood@gmail.com \
> > > > Cc: maz@kernel.org \
> > > > Cc: p.zabel@pengutronix.de \
> > > > Cc: robin.murphy@arm.com \
> > > > Cc: will@kernel.org \
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > Changes in v2:
> > > > - see each patch
> > > > - Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com
> > > >
> > > > ---
> > > > Frank Li (2):
> > > >       PCI: Add enable_device() and disable_device() callbacks for bridges
> > > >       PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
> > > >
> > > >  drivers/pci/controller/dwc/pci-imx6.c | 133 +++++++++++++++++++++++++++++++++-
> > > >  drivers/pci/pci.c                     |  14 ++++
> > > >  include/linux/pci.h                   |   2 +
> > > >  3 files changed, 148 insertions(+), 1 deletion(-)
> > > > ---
> > > > base-commit: 2849622e7b01d5aea1b060ba3955054798c1e0bb
> > > > change-id: 20240926-imx95_lut-1c68222e0944
> > > >
> > > > Best regards,
> > > > ---
> > > > Frank Li <Frank.Li@nxp.com>
> > > >
> > > >
> > >
> > > --
> > > மணிவண்ணன் சதாசிவம்
>
> --
> மணிவண்ணன் சதாசிவம்

