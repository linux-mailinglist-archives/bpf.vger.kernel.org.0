Return-Path: <bpf+bounces-35931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA6D93FF0D
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D47628229A
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EEE18D4D9;
	Mon, 29 Jul 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d6qzRRy0"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC118D4C3;
	Mon, 29 Jul 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284355; cv=fail; b=Cy48F2Y+UpYqE6jqmz9j6BjJAGzShyw8bt2KKiurjLd4ljrjM6+p9ageTHJ0j7bcDQabLQrG9EzGYWqyBQHIiSlL0cQ0tZIKlbsG2n38Vf1gxO6AJxmanL19m/NFF6q+l6dZEZbjYYKsFWAC0j/WjgQN1ZOBnnSTnvZJurKrwYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284355; c=relaxed/simple;
	bh=6gE0KZLzZJ/K8LOa6mRvEFG2bepxNOaYVhv6blglIdo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=to370PcKltGJ/tk7Yrq6+rFE/TfYMULZjVIo5lfzEIxFvNLM2xEPRLjDtJqDKbT6ApkIuuyV2qj2cTK/k/+hS/HYXYRtj1MSUfXLddPFz8qTLpQF1F4CrN9iczqrF4ft3TLvPGfKBgPuFqPr3kWDbFoVFxAGI9qQjotNGzeyqLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d6qzRRy0; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPyvNWgIDzPF70Y0Sp8Hr4jD4piVUGt4qRRE5aCPSx9r5iPkkeR+RT0kU7tzonpZv6jiYljImqwtfO92OBmnI8ps8CDK76Aif6ES5gOtedeyL+B3up8WZ+1Agu0tJ1uNhMLom5q1w7lvFfHf68dbzANpuvFKbTOrU77M5jg/LyeGboqpfcUe1SKik6eBEWdA/+Tdf63XT/ewmlBlAw544A5bk1tjas/5KokUonHAaTzoW8qtV4N76Yzgw67Db7/frCcxo/aQSZi8+aPhYrG9+2kBMpfJsgV42yf+oyuR3mm2uK1gbaVPHcM7s/Hs2s3p9BiXB60eCMumuyIorPl39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrPwzF4xhQ0Yu7MB3SHIMxCetbC74aOZK6FPEPgSsYo=;
 b=RmnVOSUCGXxe0ad2S3JUUuZ6Mc2cgAeenQn/0RAA+q7ZBspL3V6RvMMgTwm+F/Nd6IukxXBK8qp7GnoA0M94snmqn4hCH7wWVPI84uT1pZ2+6tsCLNM4e8nU4SjQnVuotjz0NGZNNW8TKDEcerL5+3zQnq2SspqDrJy5MGbgNl/X48Hf6oF1T/8Sbu2jAtMkhufb1cJOEkxhMccBWZBPoIA3BW9j6ehKDSuH4ZeKq4Njjlp9IYC+fJCfKqhfC2VGLejVTxsUO/A2sqEj+IZJjHnmcOAae5ta9TCdoMSpimoPRI8DXzILD24zTmy5eeRGY6dZVZ14FKHWgdw6vNvtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrPwzF4xhQ0Yu7MB3SHIMxCetbC74aOZK6FPEPgSsYo=;
 b=d6qzRRy0M6bb8kNHJj/mjcm3mKU9QRHQqlEFJIg2vQ9CVR2jL/DurpgP45+mP1H5oqQUJOkBuNDWkdyN4dI3Rfa6BEJwsne7m9pAqhASuxWvL5J59vZecexvBHdQQrCAfaRgtkoIvmpqJM4U6xGcOfUsUoJWlhMCnPmwDI7ky4pcfY2dhEu2I6k30q2koYYFLD44eYpAq912DARFCnx0SFEtWdRb9fZBto/ju+xr+gCUyL9s0HwqFzVutvJDtxS75E3TD/o+2dJrN29eQ1G6bctMBkQz8SeWjdkpACRvyM0ECaYq8nJoDY6+EE+5kVXVD85DsVXS2024DnnrMQLrMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 20:19:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:19:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 16:18:11 -0400
Subject: [PATCH v8 04/11] PCI: imx6: Rename imx6_* with imx_*
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-pci2_upstream-v8-4-b68ee5ef2b4d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=59275;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6gE0KZLzZJ/K8LOa6mRvEFG2bepxNOaYVhv6blglIdo=;
 b=EyyEGkhWofTgRw7jfrvzm54OZ96eRG77+F4F7T1ArRwMQdxONoXAD0cqlezr8k8rmO/qxNrBo
 Redca4h2EsqDUc3ZOqSbMPQV2XGGUXGC7E+bLmvjaopTpSnzeroAeFW
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
X-MS-Office365-Filtering-Correlation-Id: 656e8336-bfd5-45e0-2613-08dcb00bb25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzlxK1NxWWpRcGc4S1N6bWxsbW5uQTd1dys4Vzl0d1d2ajY3RGJFUjNmZUVS?=
 =?utf-8?B?YmlWRlZXampuY0J6VHM2SWNITi9ySUxGMkNWL21zc2YrbzRDUkp3TmZGNW1C?=
 =?utf-8?B?K09ZRWdHcHEwemxtMVNiRmJ4U214aTZYUHQycEZaUHVEdVV5cnREOTQra1Uw?=
 =?utf-8?B?bUUxTVFoZ3FpTktsRXFEakZVWTJ0enNIODVoZTArNXk0L20zVGNkcW5aTmgz?=
 =?utf-8?B?cEpqVUZyK1dta0hoMkdjbkJEZDM1Z0tTeGx2eGxtZjB2MW9VbURKUTRPUVpY?=
 =?utf-8?B?YlZ0clZRcnZKMFQ2K2dldklwSnJESEYyTzVCSHFxbElRVGJQT29QTThCZ2cw?=
 =?utf-8?B?UlZReFlZb1dPaFZwZFByR0ViZzhoMlZIMDBoTVNLZThxWlFtaEJYN2dzZVRD?=
 =?utf-8?B?b2VNYmRLT21rMzg0bWhRSTI2emJRenJtVStWQ2dzUFNGLzUyTy8rampxSkVN?=
 =?utf-8?B?djljMzFCc1Z1L1ZHYUIwejdrdFRxWG9PMGN4bUxaaFVWVlA4WVlUano3RW5N?=
 =?utf-8?B?dmYwdTZ6RFBWS3YzTTZZUFNadFZYTisyWXNFNHhoVHRrZVhDMElwMWxSdUZ5?=
 =?utf-8?B?UFg2aFQ2UnUwNE9rY3h0UGZDTUxEYXJUVFkzeStpZDY2bXZrODVTdTU1TFRs?=
 =?utf-8?B?WnBpbDJMSnJneFJJdnZ1Um96MDMybjJjZkRHMEltRXhUaTNDUm1wMkp1MTk4?=
 =?utf-8?B?NWUraE15cWh0NElMS1k0TEc4bTE4enpVeG1YTlp5ZFJOVUl3ZDBZUEQ0MFF2?=
 =?utf-8?B?MVF6Q1oxd1pycEFqNHJwc1drOEMwbzFtSEhZbTJmcmtVazRaRjk1Y0w5czV6?=
 =?utf-8?B?eTMxaW1EV0NlRFF1cVpnVGxLMTU3NDBFc2lEelZKdmFicllpUHE5NlJWVjJa?=
 =?utf-8?B?bGliL0dDSDlQRDhtd1ljMGY4YU9CL0R1ZHJSVFZYKzFPU2F5bEtWT0NuK3lr?=
 =?utf-8?B?c3dSTURrQ2VMUDJ3MHkwT2dDeHpDTG9iWWpHZ0VUZWlTNi9NK0Z3VEtJeE5l?=
 =?utf-8?B?ekZLdFZJZHVLUDd2UmpoTjFzMlo1QUloeVRNdXZ1REpjdFNoM1puRVRYL1hK?=
 =?utf-8?B?dzd1WFNhQWtpZHlGY2FsaVZnQTJlRHN2WEV4T25qa1ZXSlBGZlpxMVFZbnJk?=
 =?utf-8?B?d2pBTGp6UjJQdzJwVnZwZUtqV3YzZUMxbWp0bVE4NHdKMjc1bWliNjgrLyty?=
 =?utf-8?B?b3hXbStLMDJjSExyQkVkN0prWVpTaXNIWFR4NlExWUtyek5GeW44ODNndU5s?=
 =?utf-8?B?c3RYWGR3VXZkR3JMaThhQkNRd1IxcHF5K25NVjVIemV3ZzNRVlhHWVNWL1pY?=
 =?utf-8?B?QUhyODZzdmN4b0FtYlV1cUN5SXZEWmpSSlpzcmFTelMzeTZzcU02NFJKcVd5?=
 =?utf-8?B?eUlGOHhMZWZlb3JpWUdwdTNoV3VublYrVWw3S3BsK2p6ZS9YVHIzM0M2b2F1?=
 =?utf-8?B?N09xOGpDeEw2THdFVExMUVZ3LzRNTFpUVjFmRVFobE5hd1VYVEZoZTUvZEpz?=
 =?utf-8?B?RlJKZkpiOGFYbU9FckRkbm1qNklXUDZaTDVYci9PYUV4MVhib0tMeGxLbVR1?=
 =?utf-8?B?Mmg5VkhURjFUZ1hCZ3A0VVc3cXJ0WWlZVUlsQ0tsOTh5SW5PNHNrOEVDMDB4?=
 =?utf-8?B?d05UOG52NFpFc2w1cFlIc2pqOUt0Ukx6ZTFUMW05WEJ4anBsdW5BOVpoYU1K?=
 =?utf-8?B?VmZZbTlNVHJZdnI4K2o3N3RRWVlXV2pZTDFOSjdCR3dtZFdLTEhBZUdEM1Zp?=
 =?utf-8?B?dGdoMklZa3VWZHR0YVpoUFVXU0REYmNYcHZ2UjNFVlBvMmZLWHJweUxDVnhi?=
 =?utf-8?B?aVBhRVUyL0l2dm9iOXNyQzFQQUhlQjRRT2lqalZ2QVNkclQwMEdmY1dwTkxY?=
 =?utf-8?B?b3NNNXc1NElNVGIzUXZsNkJZQjRyQng0dzNja2kxWmNwd0Y0bVkxNVBENUdC?=
 =?utf-8?Q?LgyskxSHNkk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjhMbzVteGgyYnZhRUMvSlh4RDJUY2dhVW5mdEJDcm9QZlpsMzRIZXV5Q2po?=
 =?utf-8?B?dVRlNE5XaEFRUzZvNjh1UXdUOFQ3R3FRSHN4aXdUN1hRbU05eGNIMDdpZVpj?=
 =?utf-8?B?OWFjUDJxODNCRWxNcG9nZGY4dkVWeGJLZGdoaWdjRkd6NFhwZ0VtMVlaOUto?=
 =?utf-8?B?MU1EaGxUNWVNbUtreXljQ1VaUzBDVm0xeFRXdDMzUG1WeFJGUmJzUkVpc0pS?=
 =?utf-8?B?WlRjNmhYWUxaTHhVNU9NZ054SS9VcitHZVZlclB2Y0JrYzYrYkVtUG1LYUxJ?=
 =?utf-8?B?eDhON2pMdUt5a0ZNYms1VFBSUkRNOWJTS0xtLzZRYVArR00zNkVXYWk2OWU3?=
 =?utf-8?B?ZW1kWUdPSUlzN2J2YXlXZkhCbm41SVZQYzZNdkhzNytDcVdlelhmR2tIL1c0?=
 =?utf-8?B?WlRXL0JMZS96TWN6MnhnSGlFMjZINElwZkYwRE1JSURaaUlrN1BDZWxHTVp4?=
 =?utf-8?B?bjNyeERZRHcwRDl3ZnRQVHFWS1VxdUloWDZJWTVMV091QjVXdWJweTlLWjI2?=
 =?utf-8?B?YlpoUHBlNVlWb2tNZVVzRDd6dFBWMngrMHRteGU3K3JrKytYYS8vNm14UnQv?=
 =?utf-8?B?VVZOc25FYXNNN3FUVXBrQzEzdGg2NlEzRVdheTlwRDVZdmhoSFhrek80bXQv?=
 =?utf-8?B?ZjlXTEZGS1lWYUxJZGdMWmVlUjMrSk5qUEpCVzNuM0Y5eXBMdVVCN012ZHMw?=
 =?utf-8?B?RGhCYzZpc1JjcVBqd3I4b3Z5V2lvYXpaY0lsY2lQZDFGV0hsUGNEc1lIQ1JZ?=
 =?utf-8?B?SklneU1WQTgzYmJYMDNmYVlVM2pIK0d0Tk1jbDA5SThlQjlEdmgzV29wQkhQ?=
 =?utf-8?B?M0N0OFN0S05tUWNRMXg4emdVcUdDVzYxdDFBM2E1K2tPNk1TOW94VUFEem5w?=
 =?utf-8?B?Q0JGOVIxck9PL2FNeFZ2ZXo0S3lIamFFbXZTazVGaTd0VUwrdFVwbzBDOXVU?=
 =?utf-8?B?ZFJSU2dJVE1nUE9zbEF2V1c4M2ZYbndaRjk1T3VKcGI0OElKK0t1MHk0ek00?=
 =?utf-8?B?SEdrMGJzdUJrUG9pc1Bwb29uL3FaRXNsa0NBT3NHV2lWcklhckxxczRRRG04?=
 =?utf-8?B?eTdKVGwrbkVmTTZWT3BJM1FIYmljNjV2RmNVZ2Jmd0ViT3UvTEZTaUZPRTBo?=
 =?utf-8?B?cmFOOERZMFJXbXQ4a3pqbGc5WFhydUtNeDRHVmpHT0E1VjFLMkl5bVJqOWZv?=
 =?utf-8?B?UU4ydXhiNDlrQnZqbWFhL253bUlrKzZYanNIMkNCa0dPRmpPUGlMU0lKL0hq?=
 =?utf-8?B?SU9mMEYxMDg2QTVlRUZ6VUpIRFNBVG5uaVpsNkY4MUl3YjEzbGdDaHRyZktv?=
 =?utf-8?B?aWloUFVWRjZXVTdkSzNWK3pteEQzMHdvWGpUYmZsblJVMFpIbnI0Y1ZwbDdw?=
 =?utf-8?B?NXVMZ1dwM2dIU3NWQmhmQURONG1nNEwxNWRNQmZvNXVxLzM5TTlQUUVVOUdn?=
 =?utf-8?B?alNwaEZHM1BmK2lNcm9ab3cweVp6ZDQwSnR6bzNSSWFJMlNYVmtIM2NubUlp?=
 =?utf-8?B?ZFFqSkdiL1NOUGZDR0U2amdZSnVCajg0ZlB2bm01SUdDaWVqMHRmdDczZmR6?=
 =?utf-8?B?Ny9ray93R3MwUm5GUVlYcnZZUzFYOE4rcjhYVmI3WGVHSEd4MGM3WncxWTVj?=
 =?utf-8?B?Nk81cXBvdlArWGp1M0NVaEtJOERTSGVqajRLWjZGQnhEZTB3bkZrMDdTaUkx?=
 =?utf-8?B?VHVJL1FvM3ltemJkaXVYVCtsSXNodkpXQUxrYW52UU1WSFhrM2Y0TCs5dUgw?=
 =?utf-8?B?ZUpuUnM5MXc2SUFtd0pSb2xOWUJxV0xaaTZROFVqRkZOeFlLOFNqOVhhSUlN?=
 =?utf-8?B?cTVTdzhUUHVrQmplVXdjZmlCSDB5MnhaSmNTYVhSeDU0dGNsMWYwNDRaeWE4?=
 =?utf-8?B?R0w4NXRvV1ZnUkloSnI1ZTVpeS90REswUnpNck8ycTNmeFhpUUt1VVVSaVdM?=
 =?utf-8?B?OWs5OGpuTzI1cURWMHBDVzBJb2FuMUF3L2J2b0NrMWU2UUJ5QVJ4dVQxdU0r?=
 =?utf-8?B?eFNla08weUdNUnYyalp2c0N6S1FqWEpaU1YxUFVqMm9ybFZ3bW5ZQ0ZRenhT?=
 =?utf-8?B?VGJhZ1lMOHRiWE5aZ1lRaksyQm96RVppVGo5YVphcWxGWmF3K3phMStrOUlI?=
 =?utf-8?Q?Mu/N5Wh5xThbVlVEn3gzriShG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656e8336-bfd5-45e0-2613-08dcb00bb25f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:19:06.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4neGh53ghXsZtsgVXZrfuRn0sn9k+UscLI8g7zUNwEfaLty6fhrEYDvGJwkJpnavDmPOsqu/+6NBphkeJwzzyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382

Since this driver has evolved to support other i.MX SoCs such as i.MX7/8/9,
let's rename the 'imx6' prefix to 'imx' to avoid confusion. But the driver
name is left unchanged to avoid breaking userspace scripts

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 748 +++++++++++++++++-----------------
 1 file changed, 374 insertions(+), 374 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index eaec471c46234..443c7c75f2842 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -54,9 +54,9 @@
 #define IMX95_PE0_GEN_CTRL_3			0x1058
 #define IMX95_PCIE_LTSSM_EN			BIT(0)
 
-#define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
+#define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
-enum imx6_pcie_variants {
+enum imx_pcie_variants {
 	IMX6Q,
 	IMX6SX,
 	IMX6QP,
@@ -71,25 +71,25 @@ enum imx6_pcie_variants {
 	IMX95_EP,
 };
 
-#define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
-#define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
-#define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
-#define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
-#define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
-#define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
-#define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
-#define IMX6_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
+#define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
+#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE	BIT(1)
+#define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
+#define IMX_PCIE_FLAG_HAS_PHYDRV			BIT(3)
+#define IMX_PCIE_FLAG_HAS_APP_RESET		BIT(4)
+#define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
+#define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
+#define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
 
-#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
+#define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
 
-#define IMX6_PCIE_MAX_CLKS       6
+#define IMX_PCIE_MAX_CLKS       6
 
-#define IMX6_PCIE_MAX_INSTANCES			2
+#define IMX_PCIE_MAX_INSTANCES			2
 
-struct imx6_pcie;
+struct imx_pcie;
 
-struct imx6_pcie_drvdata {
-	enum imx6_pcie_variants variant;
+struct imx_pcie_drvdata {
+	enum imx_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
 	int dbi_length;
@@ -98,17 +98,17 @@ struct imx6_pcie_drvdata {
 	const u32 clks_cnt;
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
-	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
-	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
+	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
 	const struct pci_epc_features *epc_features;
-	int (*init_phy)(struct imx6_pcie *pcie);
+	int (*init_phy)(struct imx_pcie *pcie);
 };
 
-struct imx6_pcie {
+struct imx_pcie {
 	struct dw_pcie		*pci;
 	struct gpio_desc	*reset_gpiod;
 	bool			link_is_up;
-	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
+	struct clk_bulk_data	clks[IMX_PCIE_MAX_CLKS];
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -129,7 +129,7 @@ struct imx6_pcie {
 	/* power domain for pcie phy */
 	struct device		*pd_pcie_phy;
 	struct phy		*phy;
-	const struct imx6_pcie_drvdata *drvdata;
+	const struct imx_pcie_drvdata *drvdata;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -184,28 +184,28 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
-static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
+static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 {
-	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
-		imx6_pcie->drvdata->variant != IMX8MQ_EP &&
-		imx6_pcie->drvdata->variant != IMX8MM &&
-		imx6_pcie->drvdata->variant != IMX8MM_EP &&
-		imx6_pcie->drvdata->variant != IMX8MP &&
-		imx6_pcie->drvdata->variant != IMX8MP_EP);
-	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
+	WARN_ON(imx_pcie->drvdata->variant != IMX8MQ &&
+		imx_pcie->drvdata->variant != IMX8MQ_EP &&
+		imx_pcie->drvdata->variant != IMX8MM &&
+		imx_pcie->drvdata->variant != IMX8MM_EP &&
+		imx_pcie->drvdata->variant != IMX8MP &&
+		imx_pcie->drvdata->variant != IMX8MP_EP);
+	return imx_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
-static int imx95_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			IMX95_PCIE_SS_RW_REG_0,
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			   IMX95_PCIE_PHY_GEN_CTRL,
 			   IMX95_PCIE_REF_USE_PAD, 0);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			   IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
 			   IMX95_PCIE_REF_CLKEN);
@@ -213,9 +213,9 @@ static int imx95_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 	return 0;
 }
 
-static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 {
-	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
+	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 	unsigned int mask, val, mode, id;
 
 	if (drvdata->mode == DW_PCIE_EP_TYPE)
@@ -223,7 +223,7 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 	else
 		mode = PCI_EXP_TYPE_ROOT_PORT;
 
-	id = imx6_pcie->controller_id;
+	id = imx_pcie->controller_id;
 
 	/* If mode_mask[id] is zero, means each controller have its individual gpr */
 	if (!drvdata->mode_mask[id])
@@ -232,12 +232,12 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 	mask = drvdata->mode_mask[id];
 	val = mode << (ffs(mask) - 1);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
 }
 
-static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
+static int pcie_phy_poll_ack(struct imx_pcie *imx_pcie, bool exp_val)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	bool val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
@@ -256,9 +256,9 @@ static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 	return -ETIMEDOUT;
 }
 
-static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
+static int pcie_phy_wait_ack(struct imx_pcie *imx_pcie, int addr)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	u32 val;
 	int ret;
 
@@ -268,24 +268,24 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 	val |= PCIE_PHY_CTRL_CAP_ADR;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
-	ret = pcie_phy_poll_ack(imx6_pcie, true);
+	ret = pcie_phy_poll_ack(imx_pcie, true);
 	if (ret)
 		return ret;
 
 	val = PCIE_PHY_CTRL_DATA(addr);
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
 
-	return pcie_phy_poll_ack(imx6_pcie, false);
+	return pcie_phy_poll_ack(imx_pcie, false);
 }
 
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
-static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
+static int pcie_phy_read(struct imx_pcie *imx_pcie, int addr, u16 *data)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	u32 phy_ctl;
 	int ret;
 
-	ret = pcie_phy_wait_ack(imx6_pcie, addr);
+	ret = pcie_phy_wait_ack(imx_pcie, addr);
 	if (ret)
 		return ret;
 
@@ -293,7 +293,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 	phy_ctl = PCIE_PHY_CTRL_RD;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
 
-	ret = pcie_phy_poll_ack(imx6_pcie, true);
+	ret = pcie_phy_poll_ack(imx_pcie, true);
 	if (ret)
 		return ret;
 
@@ -302,18 +302,18 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 	/* deassert Read signal */
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
 
-	return pcie_phy_poll_ack(imx6_pcie, false);
+	return pcie_phy_poll_ack(imx_pcie, false);
 }
 
-static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
+static int pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	u32 var;
 	int ret;
 
 	/* write addr */
 	/* cap addr */
-	ret = pcie_phy_wait_ack(imx6_pcie, addr);
+	ret = pcie_phy_wait_ack(imx_pcie, addr);
 	if (ret)
 		return ret;
 
@@ -324,7 +324,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	var |= PCIE_PHY_CTRL_CAP_DAT;
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
-	ret = pcie_phy_poll_ack(imx6_pcie, true);
+	ret = pcie_phy_poll_ack(imx_pcie, true);
 	if (ret)
 		return ret;
 
@@ -333,7 +333,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
-	ret = pcie_phy_poll_ack(imx6_pcie, false);
+	ret = pcie_phy_poll_ack(imx_pcie, false);
 	if (ret)
 		return ret;
 
@@ -342,7 +342,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack */
-	ret = pcie_phy_poll_ack(imx6_pcie, true);
+	ret = pcie_phy_poll_ack(imx_pcie, true);
 	if (ret)
 		return ret;
 
@@ -351,7 +351,7 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
 
 	/* wait for ack de-assertion */
-	ret = pcie_phy_poll_ack(imx6_pcie, false);
+	ret = pcie_phy_poll_ack(imx_pcie, false);
 	if (ret)
 		return ret;
 
@@ -360,74 +360,74 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	return 0;
 }
 
-static int imx8mq_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	/* TODO: Currently this code assumes external oscillator is being used */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr,
-			   imx6_pcie_grp_offset(imx6_pcie),
+	regmap_update_bits(imx_pcie->iomuxc_gpr,
+			   imx_pcie_grp_offset(imx_pcie),
 			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
 			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
 	/*
 	 * Regarding the datasheet, the PCIE_VPH is suggested to be 1.8V. If the PCIE_VPH is
 	 * supplied by 3.3V, the VREG_BYPASS should be cleared to zero.
 	 */
-	if (imx6_pcie->vph && regulator_get_voltage(imx6_pcie->vph) > 3000000)
-		regmap_update_bits(imx6_pcie->iomuxc_gpr,
-				   imx6_pcie_grp_offset(imx6_pcie),
+	if (imx_pcie->vph && regulator_get_voltage(imx_pcie->vph) > 3000000)
+		regmap_update_bits(imx_pcie->iomuxc_gpr,
+				   imx_pcie_grp_offset(imx_pcie),
 				   IMX8MQ_GPR_PCIE_VREG_BYPASS,
 				   0);
 
 	return 0;
 }
 
-static int imx7d_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx7d_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
 
 	return 0;
 }
 
-static int imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 
 	/* configure constant input signal to the pcie ctrl and phy */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
 
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_DEEMPH_GEN1,
-			   imx6_pcie->tx_deemph_gen1 << 0);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx_pcie->tx_deemph_gen1 << 0);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
-			   imx6_pcie->tx_deemph_gen2_3p5db << 6);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx_pcie->tx_deemph_gen2_3p5db << 6);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
-			   imx6_pcie->tx_deemph_gen2_6db << 12);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx_pcie->tx_deemph_gen2_6db << 12);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_SWING_FULL,
-			   imx6_pcie->tx_swing_full << 18);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   imx_pcie->tx_swing_full << 18);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR8,
 			   IMX6Q_GPR8_TX_SWING_LOW,
-			   imx6_pcie->tx_swing_low << 25);
+			   imx_pcie->tx_swing_low << 25);
 	return 0;
 }
 
-static int imx6sx_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx6sx_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			   IMX6SX_GPR12_PCIE_RX_EQ_MASK, IMX6SX_GPR12_PCIE_RX_EQ_2);
 
-	return imx6_pcie_init_phy(imx6_pcie);
+	return imx_pcie_init_phy(imx_pcie);
 }
 
-static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
+static void imx7d_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
 {
 	u32 val;
-	struct device *dev = imx6_pcie->pci->dev;
+	struct device *dev = imx_pcie->pci->dev;
 
-	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
+	if (regmap_read_poll_timeout(imx_pcie->iomuxc_gpr,
 				     IOMUXC_GPR22, val,
 				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
 				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
@@ -435,19 +435,19 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 		dev_err(dev, "PCIe PLL lock timeout\n");
 }
 
-static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
+static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)
 {
 	unsigned long phy_rate = 0;
 	int mult, div;
 	u16 val;
 	int i;
 
-	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_IMX_PHY))
 		return 0;
 
-	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
-		if (strncmp(imx6_pcie->clks[i].id, "pcie_phy", 8) == 0)
-			phy_rate = clk_get_rate(imx6_pcie->clks[i].clk);
+	for (i = 0; i < imx_pcie->drvdata->clks_cnt; i++)
+		if (strncmp(imx_pcie->clks[i].id, "pcie_phy", 8) == 0)
+			phy_rate = clk_get_rate(imx_pcie->clks[i].clk);
 
 	switch (phy_rate) {
 	case 125000000:
@@ -465,46 +465,46 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 		div = 1;
 		break;
 	default:
-		dev_err(imx6_pcie->pci->dev,
+		dev_err(imx_pcie->pci->dev,
 			"Unsupported PHY reference clock rate %lu\n", phy_rate);
 		return -EINVAL;
 	}
 
-	pcie_phy_read(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, &val);
+	pcie_phy_read(imx_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, &val);
 	val &= ~(PCIE_PHY_MPLL_MULTIPLIER_MASK <<
 		 PCIE_PHY_MPLL_MULTIPLIER_SHIFT);
 	val |= mult << PCIE_PHY_MPLL_MULTIPLIER_SHIFT;
 	val |= PCIE_PHY_MPLL_MULTIPLIER_OVRD;
-	pcie_phy_write(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, val);
+	pcie_phy_write(imx_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, val);
 
-	pcie_phy_read(imx6_pcie, PCIE_PHY_ATEOVRD, &val);
+	pcie_phy_read(imx_pcie, PCIE_PHY_ATEOVRD, &val);
 	val &= ~(PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK <<
 		 PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT);
 	val |= div << PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT;
 	val |= PCIE_PHY_ATEOVRD_EN;
-	pcie_phy_write(imx6_pcie, PCIE_PHY_ATEOVRD, val);
+	pcie_phy_write(imx_pcie, PCIE_PHY_ATEOVRD, val);
 
 	return 0;
 }
 
-static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_reset_phy(struct imx_pcie *imx_pcie)
 {
 	u16 tmp;
 
-	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_IMX_PHY))
 		return;
 
-	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
+	pcie_phy_read(imx_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
+	pcie_phy_write(imx_pcie, PHY_RX_OVRD_IN_LO, tmp);
 
 	usleep_range(2000, 3000);
 
-	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
+	pcie_phy_read(imx_pcie, PHY_RX_OVRD_IN_LO, &tmp);
 	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
 		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
-	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
+	pcie_phy_write(imx_pcie, PHY_RX_OVRD_IN_LO, tmp);
 }
 
 #ifdef CONFIG_ARM
@@ -543,22 +543,22 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 }
 #endif
 
-static int imx6_pcie_attach_pd(struct device *dev)
+static int imx_pcie_attach_pd(struct device *dev)
 {
-	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	struct device_link *link;
 
 	/* Do nothing when in a single power domain */
 	if (dev->pm_domain)
 		return 0;
 
-	imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
-	if (IS_ERR(imx6_pcie->pd_pcie))
-		return PTR_ERR(imx6_pcie->pd_pcie);
+	imx_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
+	if (IS_ERR(imx_pcie->pd_pcie))
+		return PTR_ERR(imx_pcie->pd_pcie);
 	/* Do nothing when power domain missing */
-	if (!imx6_pcie->pd_pcie)
+	if (!imx_pcie->pd_pcie)
 		return 0;
-	link = device_link_add(dev, imx6_pcie->pd_pcie,
+	link = device_link_add(dev, imx_pcie->pd_pcie,
 			DL_FLAG_STATELESS |
 			DL_FLAG_PM_RUNTIME |
 			DL_FLAG_RPM_ACTIVE);
@@ -567,11 +567,11 @@ static int imx6_pcie_attach_pd(struct device *dev)
 		return -EINVAL;
 	}
 
-	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
-	if (IS_ERR(imx6_pcie->pd_pcie_phy))
-		return PTR_ERR(imx6_pcie->pd_pcie_phy);
+	imx_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
+	if (IS_ERR(imx_pcie->pd_pcie_phy))
+		return PTR_ERR(imx_pcie->pd_pcie_phy);
 
-	link = device_link_add(dev, imx6_pcie->pd_pcie_phy,
+	link = device_link_add(dev, imx_pcie->pd_pcie_phy,
 			DL_FLAG_STATELESS |
 			DL_FLAG_PM_RUNTIME |
 			DL_FLAG_RPM_ACTIVE);
@@ -583,20 +583,20 @@ static int imx6_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
+static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
 {
 	unsigned int offset;
 	int ret = 0;
 
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
 	case IMX6QP:
 	case IMX6Q:
 		/* power up core phy and enable ref clock */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
 		/*
 		 * the async reset input need ref clock to sync internally,
@@ -605,7 +605,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		 * add one ~10us delay here.
 		 */
 		usleep_range(10, 100);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
 	case IMX7D:
@@ -618,15 +618,15 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ_EP:
 	case IMX8MP:
 	case IMX8MP_EP:
-		offset = imx6_pcie_grp_offset(imx6_pcie);
+		offset = imx_pcie_grp_offset(imx_pcie);
 		/*
 		 * Set the over ride low and enabled
 		 * make sure that REF_CLK is turned on.
 		 */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
 				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
 				   0);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
 				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
 				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
 		break;
@@ -635,19 +635,19 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
-static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
 {
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX6QP:
 	case IMX6Q:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				IMX6Q_GPR1_PCIE_TEST_PD,
 				IMX6Q_GPR1_PCIE_TEST_PD);
 		break;
 	case IMX7D:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
@@ -656,17 +656,17 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 	}
 }
 
-static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
+static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	struct device *dev = pci->dev;
 	int ret;
 
-	ret = clk_bulk_prepare_enable(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
+	ret = clk_bulk_prepare_enable(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 	if (ret)
 		return ret;
 
-	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
+	ret = imx_pcie_enable_ref_clk(imx_pcie);
 	if (ret) {
 		dev_err(dev, "unable to enable pcie ref clock\n");
 		goto err_ref_clk;
@@ -677,41 +677,41 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 	return 0;
 
 err_ref_clk:
-	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
+	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 
 	return ret;
 }
 
-static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 {
-	imx6_pcie_disable_ref_clk(imx6_pcie);
-	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
+	imx_pcie_disable_ref_clk(imx_pcie);
+	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 }
 
-static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
-	reset_control_assert(imx6_pcie->pciephy_reset);
-	reset_control_assert(imx6_pcie->apps_reset);
+	reset_control_assert(imx_pcie->pciephy_reset);
+	reset_control_assert(imx_pcie->apps_reset);
 
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 		/* Force PCIe PHY reset */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
 		break;
 	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_SW_RST,
 				   IMX6Q_GPR1_PCIE_SW_RST);
 		break;
 	case IMX6Q:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
 		break;
 	default:
@@ -719,45 +719,45 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 
 	/* Some boards don't have PCIe reset GPIO. */
-	gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 1);
+	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
 }
 
-static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
+static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	struct device *dev = pci->dev;
 
-	reset_control_deassert(imx6_pcie->pciephy_reset);
+	reset_control_deassert(imx_pcie->pciephy_reset);
 
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX7D:
 		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
 		 * oscillate, especially when cold.  This turns off "Duty-cycle
 		 * Corrector" and other mysterious undocumented things.
 		 */
-		if (likely(imx6_pcie->phy_base)) {
+		if (likely(imx_pcie->phy_base)) {
 			/* De-assert DCC_FB_EN */
 			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
-			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG4);
+			       imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
 			/* Assert RX_EQS and RX_EQS_SEL */
 			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
 				| PCIE_PHY_CMN_REG24_RX_EQ,
-			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG24);
+			       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
 			/* Assert ATT_MODE */
 			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
-			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
+			       imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
 		} else {
 			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
 		}
 
-		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
+		imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
 		break;
 	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
 		break;
 	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_SW_RST, 0);
 
 		usleep_range(200, 500);
@@ -767,9 +767,9 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (imx6_pcie->reset_gpiod) {
+	if (imx_pcie->reset_gpiod) {
 		msleep(100);
-		gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 0);
+		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 0);
 		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
 		msleep(100);
 	}
@@ -777,9 +777,9 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	return 0;
 }
 
-static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
+static int imx_pcie_wait_for_speed_change(struct imx_pcie *imx_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	struct device *dev = pci->dev;
 	u32 tmp;
 	unsigned int retries;
@@ -796,33 +796,33 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 	return -ETIMEDOUT;
 }
 
-static void imx6_pcie_ltssm_enable(struct device *dev)
+static void imx_pcie_ltssm_enable(struct device *dev)
 {
-	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
-	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
+	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
+	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
 	if (drvdata->ltssm_mask)
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
 				   drvdata->ltssm_mask);
 
-	reset_control_deassert(imx6_pcie->apps_reset);
+	reset_control_deassert(imx_pcie->apps_reset);
 }
 
-static void imx6_pcie_ltssm_disable(struct device *dev)
+static void imx_pcie_ltssm_disable(struct device *dev)
 {
-	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
-	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
+	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
+	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
 
 	if (drvdata->ltssm_mask)
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
 				   drvdata->ltssm_mask, 0);
 
-	reset_control_assert(imx6_pcie->apps_reset);
+	reset_control_assert(imx_pcie->apps_reset);
 }
 
-static int imx6_pcie_start_link(struct dw_pcie *pci)
+static int imx_pcie_start_link(struct dw_pcie *pci)
 {
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	struct device *dev = pci->dev;
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 tmp;
@@ -841,7 +841,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 
 	/* Start LTSSM. */
-	imx6_pcie_ltssm_enable(dev);
+	imx_pcie_ltssm_enable(dev);
 
 	ret = dw_pcie_wait_for_link(pci);
 	if (ret)
@@ -864,8 +864,8 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 		dw_pcie_dbi_ro_wr_dis(pci);
 
-		if (imx6_pcie->drvdata->flags &
-		    IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE) {
+		if (imx_pcie->drvdata->flags &
+		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -875,7 +875,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 			 * failure.
 			 */
 
-			ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
+			ret = imx_pcie_wait_for_speed_change(imx_pcie);
 			if (ret) {
 				dev_err(dev, "Failed to bring link up!\n");
 				goto err_reset_phy;
@@ -890,37 +890,37 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		dev_info(dev, "Link: Only Gen1 is enabled\n");
 	}
 
-	imx6_pcie->link_is_up = true;
+	imx_pcie->link_is_up = true;
 	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
 	return 0;
 
 err_reset_phy:
-	imx6_pcie->link_is_up = false;
+	imx_pcie->link_is_up = false;
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
-	imx6_pcie_reset_phy(imx6_pcie);
+	imx_pcie_reset_phy(imx_pcie);
 	return 0;
 }
 
-static void imx6_pcie_stop_link(struct dw_pcie *pci)
+static void imx_pcie_stop_link(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 
 	/* Turn off PCIe LTSSM */
-	imx6_pcie_ltssm_disable(dev);
+	imx_pcie_ltssm_disable(dev);
 }
 
-static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
+static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	int ret;
 
-	if (imx6_pcie->vpcie) {
-		ret = regulator_enable(imx6_pcie->vpcie);
+	if (imx_pcie->vpcie) {
+		ret = regulator_enable(imx_pcie->vpcie);
 		if (ret) {
 			dev_err(dev, "failed to enable vpcie regulator: %d\n",
 				ret);
@@ -928,84 +928,84 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
-	imx6_pcie_assert_core_reset(imx6_pcie);
+	imx_pcie_assert_core_reset(imx_pcie);
 
-	if (imx6_pcie->drvdata->init_phy)
-		imx6_pcie->drvdata->init_phy(imx6_pcie);
+	if (imx_pcie->drvdata->init_phy)
+		imx_pcie->drvdata->init_phy(imx_pcie);
 
-	imx6_pcie_configure_type(imx6_pcie);
+	imx_pcie_configure_type(imx_pcie);
 
-	ret = imx6_pcie_clk_enable(imx6_pcie);
+	ret = imx_pcie_clk_enable(imx_pcie);
 	if (ret) {
 		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
 		goto err_reg_disable;
 	}
 
-	if (imx6_pcie->phy) {
-		ret = phy_init(imx6_pcie->phy);
+	if (imx_pcie->phy) {
+		ret = phy_init(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "pcie PHY power up failed\n");
 			goto err_clk_disable;
 		}
 	}
 
-	if (imx6_pcie->phy) {
-		ret = phy_power_on(imx6_pcie->phy);
+	if (imx_pcie->phy) {
+		ret = phy_power_on(imx_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");
 			goto err_phy_exit;
 		}
 	}
 
-	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
+	ret = imx_pcie_deassert_core_reset(imx_pcie);
 	if (ret < 0) {
 		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
 		goto err_phy_off;
 	}
 
-	imx6_setup_phy_mpll(imx6_pcie);
+	imx_setup_phy_mpll(imx_pcie);
 
 	return 0;
 
 err_phy_off:
-	phy_power_off(imx6_pcie->phy);
+	phy_power_off(imx_pcie->phy);
 err_phy_exit:
-	phy_exit(imx6_pcie->phy);
+	phy_exit(imx_pcie->phy);
 err_clk_disable:
-	imx6_pcie_clk_disable(imx6_pcie);
+	imx_pcie_clk_disable(imx_pcie);
 err_reg_disable:
-	if (imx6_pcie->vpcie)
-		regulator_disable(imx6_pcie->vpcie);
+	if (imx_pcie->vpcie)
+		regulator_disable(imx_pcie->vpcie);
 	return ret;
 }
 
-static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
+static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 
-	if (imx6_pcie->phy) {
-		if (phy_power_off(imx6_pcie->phy))
+	if (imx_pcie->phy) {
+		if (phy_power_off(imx_pcie->phy))
 			dev_err(pci->dev, "unable to power off PHY\n");
-		phy_exit(imx6_pcie->phy);
+		phy_exit(imx_pcie->phy);
 	}
-	imx6_pcie_clk_disable(imx6_pcie);
+	imx_pcie_clk_disable(imx_pcie);
 
-	if (imx6_pcie->vpcie)
-		regulator_disable(imx6_pcie->vpcie);
+	if (imx_pcie->vpcie)
+		regulator_disable(imx_pcie->vpcie);
 }
 
-static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
-	.init = imx6_pcie_host_init,
-	.deinit = imx6_pcie_host_exit,
+static const struct dw_pcie_host_ops imx_pcie_host_ops = {
+	.init = imx_pcie_host_init,
+	.deinit = imx_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-	.start_link = imx6_pcie_start_link,
-	.stop_link = imx6_pcie_stop_link,
+	.start_link = imx_pcie_start_link,
+	.stop_link = imx_pcie_stop_link,
 };
 
-static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
+static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	enum pci_barno bar;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -1014,7 +1014,7 @@ static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
 		dw_pcie_ep_reset_bar(pci, bar);
 }
 
-static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+static int imx_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 				  unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -1061,35 +1061,35 @@ static const struct pci_epc_features imx95_pcie_epc_features = {
 };
 
 static const struct pci_epc_features*
-imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
+imx_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 
-	return imx6_pcie->drvdata->epc_features;
+	return imx_pcie->drvdata->epc_features;
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
-	.init = imx6_pcie_ep_init,
-	.raise_irq = imx6_pcie_ep_raise_irq,
-	.get_features = imx6_pcie_ep_get_features,
+	.init = imx_pcie_ep_init,
+	.raise_irq = imx_pcie_ep_raise_irq,
+	.get_features = imx_pcie_ep_get_features,
 };
 
-static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
+static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 			   struct platform_device *pdev)
 {
 	int ret;
 	unsigned int pcie_dbi2_offset;
 	struct dw_pcie_ep *ep;
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
 
-	imx6_pcie_host_init(pp);
+	imx_pcie_host_init(pp);
 	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ_EP:
 	case IMX8MM_EP:
 	case IMX8MP_EP:
@@ -1111,10 +1111,10 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
 		pci->dbi_base2 = NULL;
 
-	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SUPPORT_64BIT))
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
-	ep->page_size = imx6_pcie->drvdata->epc_features->align;
+	ep->page_size = imx_pcie->drvdata->epc_features->align;
 
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
@@ -1132,30 +1132,30 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	pci_epc_init_notify(ep->epc);
 
 	/* Start LTSSM. */
-	imx6_pcie_ltssm_enable(dev);
+	imx_pcie_ltssm_enable(dev);
 
 	return 0;
 }
 
-static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
+static void imx_pcie_pm_turnoff(struct imx_pcie *imx_pcie)
 {
-	struct device *dev = imx6_pcie->pci->dev;
+	struct device *dev = imx_pcie->pci->dev;
 
 	/* Some variants have a turnoff reset in DT */
-	if (imx6_pcie->turnoff_reset) {
-		reset_control_assert(imx6_pcie->turnoff_reset);
-		reset_control_deassert(imx6_pcie->turnoff_reset);
+	if (imx_pcie->turnoff_reset) {
+		reset_control_assert(imx_pcie->turnoff_reset);
+		reset_control_deassert(imx_pcie->turnoff_reset);
 		goto pm_turnoff_sleep;
 	}
 
 	/* Others poke directly at IOMUXC registers */
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX6SX:
 	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
 		break;
 	default:
@@ -1174,73 +1174,73 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 	usleep_range(1000, 10000);
 }
 
-static void imx6_pcie_msi_save_restore(struct imx6_pcie *imx6_pcie, bool save)
+static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 {
 	u8 offset;
 	u16 val;
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = imx_pcie->pci;
 
 	if (pci_msi_enabled()) {
 		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
 		if (save) {
 			val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
-			imx6_pcie->msi_ctrl = val;
+			imx_pcie->msi_ctrl = val;
 		} else {
 			dw_pcie_dbi_ro_wr_en(pci);
-			val = imx6_pcie->msi_ctrl;
+			val = imx_pcie->msi_ctrl;
 			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
 			dw_pcie_dbi_ro_wr_dis(pci);
 		}
 	}
 }
 
-static int imx6_pcie_suspend_noirq(struct device *dev)
+static int imx_pcie_suspend_noirq(struct device *dev)
 {
-	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx6_pcie->pci->pp;
+	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
+	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
-	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
-	imx6_pcie_msi_save_restore(imx6_pcie, true);
-	imx6_pcie_pm_turnoff(imx6_pcie);
-	imx6_pcie_stop_link(imx6_pcie->pci);
-	imx6_pcie_host_exit(pp);
+	imx_pcie_msi_save_restore(imx_pcie, true);
+	imx_pcie_pm_turnoff(imx_pcie);
+	imx_pcie_stop_link(imx_pcie->pci);
+	imx_pcie_host_exit(pp);
 
 	return 0;
 }
 
-static int imx6_pcie_resume_noirq(struct device *dev)
+static int imx_pcie_resume_noirq(struct device *dev)
 {
 	int ret;
-	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx6_pcie->pci->pp;
+	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
+	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
-	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
+	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
-	ret = imx6_pcie_host_init(pp);
+	ret = imx_pcie_host_init(pp);
 	if (ret)
 		return ret;
-	imx6_pcie_msi_save_restore(imx6_pcie, false);
+	imx_pcie_msi_save_restore(imx_pcie, false);
 	dw_pcie_setup_rc(pp);
 
-	if (imx6_pcie->link_is_up)
-		imx6_pcie_start_link(imx6_pcie->pci);
+	if (imx_pcie->link_is_up)
+		imx_pcie_start_link(imx_pcie->pci);
 
 	return 0;
 }
 
-static const struct dev_pm_ops imx6_pcie_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
-				  imx6_pcie_resume_noirq)
+static const struct dev_pm_ops imx_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_pcie_suspend_noirq,
+				  imx_pcie_resume_noirq)
 };
 
-static int imx6_pcie_probe(struct platform_device *pdev)
+static int imx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
-	struct imx6_pcie *imx6_pcie;
+	struct imx_pcie *imx_pcie;
 	struct device_node *np;
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
@@ -1248,8 +1248,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	u16 val;
 	int i;
 
-	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
-	if (!imx6_pcie)
+	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
+	if (!imx_pcie)
 		return -ENOMEM;
 
 	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
@@ -1258,10 +1258,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
-	pci->pp.ops = &imx6_pcie_host_ops;
+	pci->pp.ops = &imx_pcie_host_ops;
 
-	imx6_pcie->pci = pci;
-	imx6_pcie->drvdata = of_device_get_match_data(dev);
+	imx_pcie->pci = pci;
+	imx_pcie->drvdata = of_device_get_match_data(dev);
 
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
@@ -1273,9 +1273,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "Unable to map PCIe PHY\n");
 			return ret;
 		}
-		imx6_pcie->phy_base = devm_ioremap_resource(dev, &res);
-		if (IS_ERR(imx6_pcie->phy_base))
-			return PTR_ERR(imx6_pcie->phy_base);
+		imx_pcie->phy_base = devm_ioremap_resource(dev, &res);
+		if (IS_ERR(imx_pcie->phy_base))
+			return PTR_ERR(imx_pcie->phy_base);
 	}
 
 	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev, 0, &dbi_base);
@@ -1283,72 +1283,72 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pci->dbi_base);
 
 	/* Fetch GPIOs */
-	imx6_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(imx6_pcie->reset_gpiod))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpiod),
+	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(imx_pcie->reset_gpiod))
+		return dev_err_probe(dev, PTR_ERR(imx_pcie->reset_gpiod),
 				     "unable to get reset gpio\n");
-	gpiod_set_consumer_name(imx6_pcie->reset_gpiod, "PCIe reset");
+	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
 
-	if (imx6_pcie->drvdata->clks_cnt >= IMX6_PCIE_MAX_CLKS)
+	if (imx_pcie->drvdata->clks_cnt >= IMX_PCIE_MAX_CLKS)
 		return dev_err_probe(dev, -ENOMEM, "clks_cnt is too big\n");
 
-	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
-		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
+	for (i = 0; i < imx_pcie->drvdata->clks_cnt; i++)
+		imx_pcie->clks[i].id = imx_pcie->drvdata->clk_names[i];
 
 	/* Fetch clocks */
-	ret = devm_clk_bulk_get(dev, imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
+	ret = devm_clk_bulk_get(dev, imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
 	if (ret)
 		return ret;
 
-	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHYDRV)) {
-		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
-		if (IS_ERR(imx6_pcie->phy))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
+		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
+		if (IS_ERR(imx_pcie->phy))
+			return dev_err_probe(dev, PTR_ERR(imx_pcie->phy),
 					     "failed to get pcie phy\n");
 	}
 
-	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET)) {
-		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
-		if (IS_ERR(imx6_pcie->apps_reset))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_APP_RESET)) {
+		imx_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
+		if (IS_ERR(imx_pcie->apps_reset))
+			return dev_err_probe(dev, PTR_ERR(imx_pcie->apps_reset),
 					     "failed to get pcie apps reset control\n");
 	}
 
-	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET)) {
-		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev, "pciephy");
-		if (IS_ERR(imx6_pcie->pciephy_reset))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pciephy_reset),
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHY_RESET)) {
+		imx_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev, "pciephy");
+		if (IS_ERR(imx_pcie->pciephy_reset))
+			return dev_err_probe(dev, PTR_ERR(imx_pcie->pciephy_reset),
 					     "Failed to get PCIEPHY reset control\n");
 	}
 
-	switch (imx6_pcie->drvdata->variant) {
+	switch (imx_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
-			imx6_pcie->controller_id = 1;
+			imx_pcie->controller_id = 1;
 		break;
 	default:
 		break;
 	}
 
 	/* Grab turnoff reset */
-	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
-	if (IS_ERR(imx6_pcie->turnoff_reset)) {
+	imx_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
+	if (IS_ERR(imx_pcie->turnoff_reset)) {
 		dev_err(dev, "Failed to get TURNOFF reset control\n");
-		return PTR_ERR(imx6_pcie->turnoff_reset);
+		return PTR_ERR(imx_pcie->turnoff_reset);
 	}
 
-	if (imx6_pcie->drvdata->gpr) {
+	if (imx_pcie->drvdata->gpr) {
 	/* Grab GPR config register range */
-		imx6_pcie->iomuxc_gpr =
-			 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
-		if (IS_ERR(imx6_pcie->iomuxc_gpr))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
+		imx_pcie->iomuxc_gpr =
+			 syscon_regmap_lookup_by_compatible(imx_pcie->drvdata->gpr);
+		if (IS_ERR(imx_pcie->iomuxc_gpr))
+			return dev_err_probe(dev, PTR_ERR(imx_pcie->iomuxc_gpr),
 					     "unable to find iomuxc registers\n");
 	}
 
-	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_SERDES)) {
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_SERDES)) {
 		void __iomem *off = devm_platform_ioremap_resource_byname(pdev, "app");
 
 		if (IS_ERR(off))
@@ -1361,59 +1361,59 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			.reg_stride = 4,
 		};
 
-		imx6_pcie->iomuxc_gpr = devm_regmap_init_mmio(dev, off, &regmap_config);
-		if (IS_ERR(imx6_pcie->iomuxc_gpr))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
+		imx_pcie->iomuxc_gpr = devm_regmap_init_mmio(dev, off, &regmap_config);
+		if (IS_ERR(imx_pcie->iomuxc_gpr))
+			return dev_err_probe(dev, PTR_ERR(imx_pcie->iomuxc_gpr),
 					     "unable to find iomuxc registers\n");
 	}
 
 	/* Grab PCIe PHY Tx Settings */
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
-				 &imx6_pcie->tx_deemph_gen1))
-		imx6_pcie->tx_deemph_gen1 = 0;
+				 &imx_pcie->tx_deemph_gen1))
+		imx_pcie->tx_deemph_gen1 = 0;
 
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-3p5db",
-				 &imx6_pcie->tx_deemph_gen2_3p5db))
-		imx6_pcie->tx_deemph_gen2_3p5db = 0;
+				 &imx_pcie->tx_deemph_gen2_3p5db))
+		imx_pcie->tx_deemph_gen2_3p5db = 0;
 
 	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-6db",
-				 &imx6_pcie->tx_deemph_gen2_6db))
-		imx6_pcie->tx_deemph_gen2_6db = 20;
+				 &imx_pcie->tx_deemph_gen2_6db))
+		imx_pcie->tx_deemph_gen2_6db = 20;
 
 	if (of_property_read_u32(node, "fsl,tx-swing-full",
-				 &imx6_pcie->tx_swing_full))
-		imx6_pcie->tx_swing_full = 127;
+				 &imx_pcie->tx_swing_full))
+		imx_pcie->tx_swing_full = 127;
 
 	if (of_property_read_u32(node, "fsl,tx-swing-low",
-				 &imx6_pcie->tx_swing_low))
-		imx6_pcie->tx_swing_low = 127;
+				 &imx_pcie->tx_swing_low))
+		imx_pcie->tx_swing_low = 127;
 
 	/* Limit link speed */
 	pci->link_gen = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
 
-	imx6_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
-	if (IS_ERR(imx6_pcie->vpcie)) {
-		if (PTR_ERR(imx6_pcie->vpcie) != -ENODEV)
-			return PTR_ERR(imx6_pcie->vpcie);
-		imx6_pcie->vpcie = NULL;
+	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
+	if (IS_ERR(imx_pcie->vpcie)) {
+		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
+			return PTR_ERR(imx_pcie->vpcie);
+		imx_pcie->vpcie = NULL;
 	}
 
-	imx6_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
-	if (IS_ERR(imx6_pcie->vph)) {
-		if (PTR_ERR(imx6_pcie->vph) != -ENODEV)
-			return PTR_ERR(imx6_pcie->vph);
-		imx6_pcie->vph = NULL;
+	imx_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
+	if (IS_ERR(imx_pcie->vph)) {
+		if (PTR_ERR(imx_pcie->vph) != -ENODEV)
+			return PTR_ERR(imx_pcie->vph);
+		imx_pcie->vph = NULL;
 	}
 
-	platform_set_drvdata(pdev, imx6_pcie);
+	platform_set_drvdata(pdev, imx_pcie);
 
-	ret = imx6_pcie_attach_pd(dev);
+	ret = imx_pcie_attach_pd(dev);
 	if (ret)
 		return ret;
 
-	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
-		ret = imx6_add_pcie_ep(imx6_pcie, pdev);
+	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
+		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
 			return ret;
 	} else {
@@ -1433,12 +1433,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void imx6_pcie_shutdown(struct platform_device *pdev)
+static void imx_pcie_shutdown(struct platform_device *pdev)
 {
-	struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
+	struct imx_pcie *imx_pcie = platform_get_drvdata(pdev);
 
 	/* bring down link, so bootloader gets clean state in case of reboot */
-	imx6_pcie_assert_core_reset(imx6_pcie);
+	imx_pcie_assert_core_reset(imx_pcie);
 }
 
 static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
@@ -1446,11 +1446,11 @@ static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
 static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
 static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
 
-static const struct imx6_pcie_drvdata drvdata[] = {
+static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
-			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
+		.flags = IMX_PCIE_FLAG_IMX_PHY |
+			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6q_clks,
@@ -1459,13 +1459,13 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
-		.init_phy = imx6_pcie_init_phy,
+		.init_phy = imx_pcie_init_phy,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
-			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
-			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX_PCIE_FLAG_IMX_PHY |
+			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6sx_clks,
 		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
@@ -1477,9 +1477,9 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
-		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
-			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
-			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX_PCIE_FLAG_IMX_PHY |
+			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6q_clks,
@@ -1488,13 +1488,13 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
-		.init_phy = imx6_pcie_init_phy,
+		.init_phy = imx_pcie_init_phy,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_APP_RESET |
-			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
+		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
@@ -1504,8 +1504,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
-		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
-			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
+		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
@@ -1517,9 +1517,9 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_PHYDRV |
-			 IMX6_PCIE_FLAG_HAS_APP_RESET,
+		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_HAS_PHYDRV |
+			 IMX_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
@@ -1528,9 +1528,9 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_PHYDRV |
-			 IMX6_PCIE_FLAG_HAS_APP_RESET,
+		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_HAS_PHYDRV |
+			 IMX_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
@@ -1539,7 +1539,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX95] = {
 		.variant = IMX95,
-		.flags = IMX6_PCIE_FLAG_HAS_SERDES,
+		.flags = IMX_PCIE_FLAG_HAS_SERDES,
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
@@ -1550,8 +1550,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
-			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
+		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_HAS_PHY_RESET,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
@@ -1565,8 +1565,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
-			 IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1577,8 +1577,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
-			 IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1589,8 +1589,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_SERDES |
-			 IMX6_PCIE_FLAG_SUPPORT_64BIT,
+		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_SUPPORT_64BIT,
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
@@ -1603,7 +1603,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 };
 
-static const struct of_device_id imx6_pcie_of_match[] = {
+static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie",  .data = &drvdata[IMX6Q],  },
 	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
 	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
@@ -1619,19 +1619,19 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{},
 };
 
-static struct platform_driver imx6_pcie_driver = {
+static struct platform_driver imx_pcie_driver = {
 	.driver = {
 		.name	= "imx6q-pcie",
-		.of_match_table = imx6_pcie_of_match,
+		.of_match_table = imx_pcie_of_match,
 		.suppress_bind_attrs = true,
-		.pm = &imx6_pcie_pm_ops,
+		.pm = &imx_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-	.probe    = imx6_pcie_probe,
-	.shutdown = imx6_pcie_shutdown,
+	.probe    = imx_pcie_probe,
+	.shutdown = imx_pcie_shutdown,
 };
 
-static void imx6_pcie_quirk(struct pci_dev *dev)
+static void imx_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
 	struct dw_pcie_rp *pp = bus->sysdata;
@@ -1641,33 +1641,33 @@ static void imx6_pcie_quirk(struct pci_dev *dev)
 		return;
 
 	/* Make sure we only quirk devices associated with this driver */
-	if (bus->dev.parent->parent->driver != &imx6_pcie_driver.driver)
+	if (bus->dev.parent->parent->driver != &imx_pcie_driver.driver)
 		return;
 
 	if (pci_is_root_bus(bus)) {
 		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-		struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+		struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 
 		/*
 		 * Limit config length to avoid the kernel reading beyond
 		 * the register set and causing an abort on i.MX 6Quad
 		 */
-		if (imx6_pcie->drvdata->dbi_length) {
-			dev->cfg_size = imx6_pcie->drvdata->dbi_length;
+		if (imx_pcie->drvdata->dbi_length) {
+			dev->cfg_size = imx_pcie->drvdata->dbi_length;
 			dev_info(&dev->dev, "Limiting cfg_size to %d\n",
 					dev->cfg_size);
 		}
 	}
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
-			PCI_CLASS_BRIDGE_PCI, 8, imx6_pcie_quirk);
+			PCI_CLASS_BRIDGE_PCI, 8, imx_pcie_quirk);
 
-static int __init imx6_pcie_init(void)
+static int __init imx_pcie_init(void)
 {
 #ifdef CONFIG_ARM
 	struct device_node *np;
 
-	np = of_find_matching_node(NULL, imx6_pcie_of_match);
+	np = of_find_matching_node(NULL, imx_pcie_of_match);
 	if (!np)
 		return -ENODEV;
 	of_node_put(np);
@@ -1683,6 +1683,6 @@ static int __init imx6_pcie_init(void)
 			"external abort on non-linefetch");
 #endif
 
-	return platform_driver_register(&imx6_pcie_driver);
+	return platform_driver_register(&imx_pcie_driver);
 }
-device_initcall(imx6_pcie_init);
+device_initcall(imx_pcie_init);

-- 
2.34.1


