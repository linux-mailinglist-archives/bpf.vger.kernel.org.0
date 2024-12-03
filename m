Return-Path: <bpf+bounces-46040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4D39E2FD6
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 00:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE312833EA
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 23:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E9020B211;
	Tue,  3 Dec 2024 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b+4iR4lS"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6220A5EB;
	Tue,  3 Dec 2024 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268468; cv=fail; b=YgbLB23eJxZrU3iP3gVlmidKCrP/uS7zzWl1oeJ/c4h6lAnNlmQx53mnRB+WsULbU7rGykhvUQUTxjJCF2G6Q+4ZYEvkdzmxym7HWN/quJqPjILqS2pabA7o/RoIrB9PTw1Hd6fJIufc61ZdqSCH4KfAsLQgZmYDimAyvV6KfGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268468; c=relaxed/simple;
	bh=rXhNqwdgirRPqijx7i4RJfbC7AudsiBL7xFaxLL5LAQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oa/tRX0GquerPNR/NZqQg3x379hqbp6A2JclvcZ9wB4qFoD5lTLNcbFcCdwQ6r/8IAxN6s6m6qx9LlsFt0gYT48jIGP50J4CIPk1I7weKMak69ld3GRWiT4oIhCNpk1I7gzUEJwW+RqcOh4Tq611PMxZtakKZUUdKzR2StNNGHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b+4iR4lS; arc=fail smtp.client-ip=40.107.104.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtoM2NtgZM4G1Z3G38yOE9LHI1Ou1swzvX0Lb7/GHovEpefVyDBbpB3Ww4yhCSuD5fO2cv9F/oUWsZ2lR8kc1u6PLC56N8YhqaxAdOgVfsDx8L8b+AkV5NqavUsOL4tkRCRo8Rik5vKsi3RuevggzZbG7Kd3hhH6wgqpkoc6zFXVqMX+EhxvqYxqLavyRAyfrV7W2NJrEONauzzNyUM3kIJOa8h+Itt8/SUkFO7u0EXeM4ChridPBBsyQV9Up0ELoYt7Xoe9ObJOHXOorQHsrqquOy/j04Knh3T0BEGjMYLfbXQBqTlQDqLzpw/PBHyzrLEU7BbjTs98ufxI/ZU//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mpFJRyM8rsbkTuLLftvVbBxxmv+3Sp+Y18ElK0+EmI=;
 b=OVanvwZUau1ltpMy2APnX1x+3Kb+SeJMxWENXjTrpIJFw116kJH03CuiGlW9w8cuA5mZ1JZ33WhHtHKDlZtAbW8q0sc1GPGf5crss/tUwqVfBKlDTqEl2GI/XG40aM316mKmF1ug0AK6Iq2aBV/zBJFK075+KDX1e2j4DdTNQIep2tM/qjInqvEkC4VtNtJk/rDl+5hrtjtDPO96EFcNsL08QqjHNO4CWIkr8IdH33J+f5p+3ci+IRuY5XUgqcc8lhMKwkNPD6VzB/FEd9b/WlgWc959zFL3xqxoT4dD/SXnUzxya5Pks7dvT3A/WYwquc/Wae7OvAsVZWVN5X7Y1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mpFJRyM8rsbkTuLLftvVbBxxmv+3Sp+Y18ElK0+EmI=;
 b=b+4iR4lStLa4E2RqUVluTbxZKEFMbazh+j+KKogtaXwJ9PmPBwop1BnRJv4hDJVEPMuawVUQKtsN47iWpvwbh46gEEqVYdUbqwqr02KQBTy7o+RDM9obU1k8NkcAu5mD8cUt8LzmSxPqWL5L+Vhgtn7gUzwtZFLH2wpbZd2DBFpzx+fju08x0LPk4K6hpJ4iozqeczkFxgeE0arkQ6or4swlDIK41nh520Cmv870wJjaWFg5sU5BMt0AnPVDz7g7puA0evyOAOTHEPbUeWuIXC1AuU5E7Zshh+QKWOjTIVbjHQkWzj3CGvvs4jyNxun3P4GFw7FqkCa5c8cfdAeSaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 23:27:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:27:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 03 Dec 2024 18:27:16 -0500
Subject: [PATCH v7 2/2] PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-imx95_lut-v7-2-d0cd6293225e@nxp.com>
References: <20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com>
In-Reply-To: <20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733268445; l=8868;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rXhNqwdgirRPqijx7i4RJfbC7AudsiBL7xFaxLL5LAQ=;
 b=JfU1yYrnBR0XrgK2ehuoXBbhcSAxNnSo7Ft6lKLFdaQNK4p2BIKke2wYBSV0pYPs8euZxITF0
 RUzC3EBiUsgBAv+rGhp5EBV+8rsD3zZczxB/JIRxm2Rb9vPxIhuDhFj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ae0996-8a30-4c76-68e8-08dd13f2167d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUh3U1RhdnMvN3loUGZtemJZRmxNVkxrSjIrNzRqOG54SEppMHhjUURjQTh3?=
 =?utf-8?B?L2s2ZVRYenBYM25mbGl6TDBkdDh1NnVnaythQnpmYlRXY0k5TmZHNnQ3VnUv?=
 =?utf-8?B?Zk1zMGJ6UEVmL25CQ1BsQ2ZWVklLVEtIK3ltZGZTYmRMdksweUNzeTg2RXhq?=
 =?utf-8?B?M2E2eVg0by8vMFpUeG1ucjN1R0wxdDJpQ0ppWDlFeWFldW1Ebm1aZFliNjl1?=
 =?utf-8?B?TmVOV1JwVm84NUY5Y21qN01oRm45T2gvSUVDdHcwakxyMExjcWtVRWVDaTg0?=
 =?utf-8?B?Ulo3WGo1SkhxdlgvNlZQMS9kYW9ic3d4d0Q0S0Nqc2wyWFdCaUZTMS9jUjhi?=
 =?utf-8?B?K0FER2F6NU90eklkRFNjTHNFVStDM1pFbno4b2ZvaHM2amJwRVJTY1J6ME9n?=
 =?utf-8?B?NjJOQ3lyeFhDdUZXQzlaN0NCSDRWdS9rc3B4LzgyTCtUMEI1M2FoYUFhMzJS?=
 =?utf-8?B?YzU4MHIxTC9ReVB5aERuK0VMSTYvS1lxRHdxRjF5bGxnTmlQUFFLd2ZnZlVr?=
 =?utf-8?B?MDMwVmxmR0FmVlJlM3l2TXdrcG1VbnRTWUJ3M2RPbC9CSXMwWmt3UkhjUFpl?=
 =?utf-8?B?Y3AyWWVHRGhOUS9iSWIrTkZ6KzZqMUplVDJjQ0ZwWU1WdFlQSjhVMDdCUzlR?=
 =?utf-8?B?OUtoVzFVV0xZOUZ5K1BHb1NObDRIcnFMQ01lVE8vTU1scnhYQkdpdDYxc0I4?=
 =?utf-8?B?ODRrQ29mMjdXOEZsZmJkT3lLUlVWNTE2NXlNV2Y2VHVIRjN6Z2V0b2I2a0Vq?=
 =?utf-8?B?REthUjJUSWMydU5QUWY3dmhRejZoOWdRdUx0UkVSem9iZGt6RExaTzVJRTM4?=
 =?utf-8?B?Z1FRcExpRFg4eHVyQ2tHWlNsQThoTzJ2dFZuZ2VsQmdGUUNZNGF5VFh2SDNj?=
 =?utf-8?B?M3FJZWFBOU0vTEU0eFUxOFlHMnBIcFNVTXhDS1VxclpZRHBnRDBsNnNKNjE0?=
 =?utf-8?B?VVozdTFkZURqZVFqZzNBQlhrelNkWkgrTmZnY1hhRTkyVlczMkRoUHFMYjg0?=
 =?utf-8?B?d003eElVNDJjSWlNRUdkcjJ5eU50dklaVDRSK25EYUx0V1lkOVFWRVNqSkY2?=
 =?utf-8?B?NlVUWHN3ZE83OFYxQTFCWlNtTTA3eUt6MjVMQXBSNHdQMDFEamtoQm5jUEVq?=
 =?utf-8?B?ODBDNEJ2Y0FCOEJnWU52QlJGYnlUVWN4bElnUXE4TTlEMUZRNXF2SUxJRllq?=
 =?utf-8?B?L3djeG9mUVl4THlkYVRTT1ppTzhMSDUwa2txRnlLbUdsZkdsVEJ5alBqTGxI?=
 =?utf-8?B?V2l6cUQwdmJiYWVSM3JqZHdadkJTTDE3S3hEYmFNM2hRTFJFODQzaW1JcXZW?=
 =?utf-8?B?QTM4cDNxVWFWcU9rTUdMOW9uM1VRam81dE4xWFhtR3RldEJWRzR0VWpPdkw2?=
 =?utf-8?B?UjJDSEZ6QWFwQmllODdaaCtTeGRrM3ZPUVZMWXNtK1l1MStmb1U0SjNrNFI5?=
 =?utf-8?B?Q216Mkl3T1JWbVdVT2dRSDhLdjZmS2kxUVJITkx4aUdyODloTFdMdWxUYkxP?=
 =?utf-8?B?bDFFeFA3VG9NMDQ3TFNFaythVHNZdTVSNk5SeFlUdjF3YmZUQ3YyT1NrZC9L?=
 =?utf-8?B?MEp1cFJjbkFtanlEeDZDQUJ3clhEMmcvUWNyMm9lbG94Nk9od09XTWJBemhR?=
 =?utf-8?B?OERjK1VkbkROWkw0WGk1c3FHcEpwUDZDN0YvOHIzbnliL2dLTkRwVUlER25E?=
 =?utf-8?B?VzhGSm1mck0yV01UWFg0VDRBR0NTQnZkYUNpeHVmU3htcll3d0RUaWFmM0Zu?=
 =?utf-8?B?R1ZkeEV2T0I5R2NzV29kZDlrM0hCTytoQnZ6Z1UyT1lqZXAxWXhLY01Hcjdn?=
 =?utf-8?B?UWFzNXkrNktxaTVodVl0SktuZElrcjd2dXNISTB6RmpsdkZ3RENvRHhLSU51?=
 =?utf-8?B?QVg2T2pyTnVGNlpMVEh6VmVHNW5JdHJ5ekZYWUZ2NC93RW51Z0lEb0QwazVu?=
 =?utf-8?Q?Nw9tnQToPd0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SS9vd216cDB0ME5RRDcxVE5XTnFHcEVHN2gxS3I1d09rRm5xT3BhMlh6TmNn?=
 =?utf-8?B?cFRGYW5mS1c0RTRpTWdHd0haMUpCck9KVHZmb2owODFJOC9OcDVMVVBXV1c1?=
 =?utf-8?B?R0EvYWVYQmplMWx5YVNZUTQ1cm8zSmYxOXUzdml1RFZ6YVZ2OTNrayswNWZ1?=
 =?utf-8?B?Ty8wMHovUHp1SldTeVlnMlRzU2JRalpQNUJraDI3QVhBWUU4OGtKbm5KQUw4?=
 =?utf-8?B?Q0R6dHZkRGRkZDdWR1pKT0JsRFNoTHBqb2ZiU0dHVHhnWjk2c0E5LzVEQXFU?=
 =?utf-8?B?cUtXU2VKQmVvOThGZURTSUIvRzBSU2tJQTZ3emFFeUkzTk9McHFtbGl3L3Va?=
 =?utf-8?B?QU02SFN6VWNBTFVHQlVEZEs2bHIwZGJ5ZnUvcFB0Q1dVRER0eTFwZnhqTXRa?=
 =?utf-8?B?SVZBalA5cmsrRHhWcTRtdmtzRXFreUpLekFtaE0rMmhWM01rRXl5aDlYeVhv?=
 =?utf-8?B?ZzVUSC9QVXg1dTkrR2IzM2F1VmZyU1pidXFTWG9HcTlrK2dIOThYcWlEVHlX?=
 =?utf-8?B?SGMyV0VGNHRtYlByQXFKaEhMd2ttTzRSMFFoc04yQVIwakRCcjVmUUkweHZi?=
 =?utf-8?B?UHZlS0dUaCtyUWg3cHUzNWxNdzNlYksyYjJCbkNZcFdyVlhHbFIxdmxVUmwz?=
 =?utf-8?B?bkNuaTd6bDZPSlNLNlB0eTJPL3J0Qi9UUnNhWDJFNTl1Tmp6YzFha2dYLzJJ?=
 =?utf-8?B?UTdUUDlhV1VzS1A4eVp1WHJ0QWR3SmZVMkROMHlndFVyRkM0dC9VVVUxeDVS?=
 =?utf-8?B?QjBOS1V1OC9WbVppVmR3NExvWC8rbjdmV21JVmNUQlVuaHcxM0xNaVB4RS9T?=
 =?utf-8?B?VlhQVTVEUWp0VVRFQWxsRFdjY0IrNFZmNHJXTVBoQTAyUlRSZm0vc3VBdmJD?=
 =?utf-8?B?VFROODZYYldyaWcvdHUybW92L3hQTUZwSFFaRnRZNm9ETnVUNCsvbXdFUnc2?=
 =?utf-8?B?dnBwSXZla2FGUnN2TWZNT2dvRjZ5Z0VxR2tmOXdsU3VHcUJ6bENqcDIvcW0v?=
 =?utf-8?B?M3NRY1FndWxCL2ZTYW1pQU0xckdKRWtqR2MrelFYaVp0eUJmZDQ3NmNVZGp5?=
 =?utf-8?B?TDFKN1RHWi9ULzBNRU9vZXh0MTB2ZnRhRDNVMkhiNDExaktFY2VoWEtIM1pB?=
 =?utf-8?B?bS9UT241eVcxbjVMWm9OU2RWZTJOSG52eUdCRFBGTm5EZkc2Z3YyNGZXS0E5?=
 =?utf-8?B?c3NhdlFFUGZaYklqcHlwb3hUUDdJTmJvWFRxd3RuUkViNCtLdDZoZDNBTDRE?=
 =?utf-8?B?TllkVnFKb0JTNyt4bGkrc3JJd3NYS24xc1J0RlJLZTlpeDBtdy9FalltWlFi?=
 =?utf-8?B?bFVwWUg5b1JTQjBJRzdQZkdaUnFPS3BKaW9HY3BMQ1Izd3BCd2toNVdYdE83?=
 =?utf-8?B?RGRGZlc2TnV2cUZROVJhdUVzZmxvTmZOUU5JK0p1bnF5SnRZK0p5VkI0OWFt?=
 =?utf-8?B?MUhYclVCNWp4TzEvMzg3NWs5MkdCNEtXWEFMRWovbGd1ckg5SnpQQ0ZPT1hj?=
 =?utf-8?B?MHUyK2lOZmlRUEg5YXd6K1lGR2xyTTlWZWNsOC94T21jZ2FrcGZ3VllBOWtI?=
 =?utf-8?B?UzAvNCtRV25jaGtIS3FtRVhybDdqOUZDZEI4NzJ4ODFocUxyMDJOb0FQelRI?=
 =?utf-8?B?ckxiOXJFZGpKanpicndhMHlyRGpVclV6dmQ3aGdKdVJObkVQR1lSUWl2WjQx?=
 =?utf-8?B?V0JLVWU4SDJGTGJPQkQvdk1VdmxnQlBiQzFybUdvdko2bnQrdFNKQm1sYytC?=
 =?utf-8?B?NVJDN0JHMVVVd09kc25IUEw4RU10elNRaHlsdXFaYWd0NjNyM25xb3k4OWor?=
 =?utf-8?B?bzd5ZHRpYkhZOFNVSUdzcmpSWEhRS3pCZnI2Tk5wbmJ2UUtEdEJLMWQ2bTg4?=
 =?utf-8?B?MU03L0VQK1ZKbWtTK0JlNlB6blZRdUpiUW5JQ1RuOGl5L0Rzbnd2aFcxV252?=
 =?utf-8?B?K29TcjNWY0dEMVQ3ZGRNSGFCdWhjbVBzOGVVVS9FbElIYmJ0eTB3dXRTZzRN?=
 =?utf-8?B?b2JVSEk4M0o5ZFc0TjRiUDlkaTJZOU1ucVpMM2RGQU5Td1pPRXFUcHk3T284?=
 =?utf-8?B?WXRmMGVKSHhxdEpzRzljSUpZZDFDalZ1eGR3ZnRNRVVONEhMLzhHVzlRdm1Z?=
 =?utf-8?Q?7auFfSdnfo2qaK2pQiUWJG8ej?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ae0996-8a30-4c76-68e8-08dd13f2167d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:27:43.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s+Ytw8Gk095fG6GnRk6ClkZYOdxVQ+33ubRhmyYQ2nTljY/o+ckVTXl3kVGOVRXD6ok7Npa4sZDDg+dN+0f1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846

For the i.MX95, configuration of a LUT is necessary to convert Bus Device
Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
This involves examining the msi-map and smmu-map to ensure consistent
mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
registers are configured. In the absence of an msi-map, the built-in MSI
controller is utilized as a fallback.

Register a PCI bus callback function to handle enable_device() and
disable_device() operations, setting up the LUT whenever a new PCI device
is enabled.

Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- change comment rid to RID
- some mini change according to mani's feedback

Change from v4 to v5
- rework commt message
- add comment for mutex
- s/reqid/rid/
- keep only one loop when enable lut
- add warning when try to add duplicate rid
- Replace hardcode 0xffff with IMX95_PE0_LUT_MASK
- Fix some error message

Change from v3 to v4
- Check target value at of_map_id().
- of_node_put() for target.
- add case for msi-map exist, but rid entry is not exist.

Change from v2 to v3
- Use the "target" argument of of_map_id()
- Check if rid already in lut table when enable device

change from v1 to v2
- set callback to pci_host_bridge instead pci->ops.
---
 drivers/pci/controller/dwc/pci-imx6.c | 183 +++++++++++++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c8d5c90aa4d45..ac5caa7b05075 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -55,6 +55,22 @@
 #define IMX95_PE0_GEN_CTRL_3			0x1058
 #define IMX95_PCIE_LTSSM_EN			BIT(0)
 
+#define IMX95_PE0_LUT_ACSCTRL			0x1008
+#define IMX95_PEO_LUT_RWA			BIT(16)
+#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
+
+#define IMX95_PE0_LUT_DATA1			0x100c
+#define IMX95_PE0_LUT_VLD			BIT(31)
+#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
+#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
+
+#define IMX95_PE0_LUT_DATA2			0x1010
+#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
+#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
+
+#define IMX95_SID_MASK				GENMASK(5, 0)
+#define IMX95_MAX_LUT				32
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -87,6 +103,7 @@ enum imx_pcie_variants {
  * workaround suspend resume on some devices which are affected by this errata.
  */
 #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
+#define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -139,6 +156,9 @@ struct imx_pcie {
 	struct device		*pd_pcie_phy;
 	struct phy		*phy;
 	const struct imx_pcie_drvdata *drvdata;
+
+	/* Ensure that only one device's LUT is configured at any given time */
+	struct mutex		lock;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
@@ -930,6 +950,159 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
 	imx_pcie_ltssm_disable(dev);
 }
 
+static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
+{
+	struct dw_pcie *pci = imx_pcie->pci;
+	struct device *dev = pci->dev;
+	u32 data1, data2;
+	int free = -1;
+	int i;
+
+	if (sid >= 64) {
+		dev_err(dev, "Invalid SID for index %d\n", sid);
+		return -EINVAL;
+	}
+
+	guard(mutex)(&imx_pcie->lock);
+
+	/*
+	 * Iterate through all LUT entries to check for duplicate RID and
+	 * identify the first available entry. Configure this available entry
+	 * immediately after verification to avoid rescanning it.
+	 */
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+
+		if (!(data1 & IMX95_PE0_LUT_VLD)) {
+			if (free < 0)
+				free = i;
+			continue;
+		}
+
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+
+		/* Do not add duplicate RID */
+		if (rid == FIELD_GET(IMX95_PE0_LUT_REQID, data2)) {
+			dev_warn(dev, "Existing LUT entry available for RID (%d)", rid);
+			return 0;
+		}
+	}
+
+	if (free < 0) {
+		dev_err(dev, "LUT entry is not available\n");
+		return -ENOSPC;
+	}
+
+	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
+	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
+	data1 |= IMX95_PE0_LUT_VLD;
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
+
+	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
+	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
+
+	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, free);
+
+	return 0;
+}
+
+static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
+{
+	u32 data2;
+	int i;
+
+	guard(mutex)(&imx_pcie->lock);
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == rid) {
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
+			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+
+			break;
+		}
+	}
+}
+
+static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+	u32 sid_i, sid_m, rid = pci_dev_id(pdev);
+	struct device_node *target;
+	struct device *dev;
+	int err_i, err_m;
+
+	dev = imx_pcie->pci->dev;
+
+	target = NULL;
+	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
+	if (target)
+		of_node_put(target);
+	else
+		err_i = -EINVAL;
+
+	target = NULL;
+	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
+
+	/*
+	 * Return failure if msi-map exist and no entry for RID because dwc common
+	 * driver will skip setting up built-in MSI controller if msi-map existed.
+	 *
+	 *   err_m      target
+	 *	0	NULL		Return failure, function not work.
+	 *      !0      NULL		msi-map not exist, use built-in MSI.
+	 *	0	!NULL		Find one entry.
+	 *	!0	!NULL		Invalidate case.
+	 */
+	if (!err_m && !target)
+		return -EINVAL;
+	else if (target)
+		of_node_put(target); /* Find entry for RID in msi-map */
+
+	/*
+	 * msi-map        iommu-map
+	 *   Y                Y            ITS + SMMU, require the same sid
+	 *   Y                N            ITS
+	 *   N                Y            DWC MSI Ctrl + SMMU
+	 *   N                N            DWC MSI Ctrl
+	 */
+	if (!err_i && !err_m)
+		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
+			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
+			return -EINVAL;
+		}
+
+	/*
+	 * Both iommu-map and msi-map not exist, use dwc built-in MSI
+	 * controller, do nothing here.
+	 */
+	if (err_i && err_m)
+		return 0;
+
+	if (!err_i)
+		return imx_pcie_add_lut(imx_pcie, rid, sid_i);
+	else if (!err_m)
+		/*
+		 * Hardware auto add 2 bits controller id ahead of stream ID,
+		 * so mask this 2bits to get stream ID.
+		 */
+		return imx_pcie_add_lut(imx_pcie, rid, sid_m & IMX95_SID_MASK);
+
+	return 0;
+}
+
+static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie;
+
+	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
+}
+
 static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -946,6 +1119,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
+		pp->bridge->enable_device = imx_pcie_enable_device;
+		pp->bridge->disable_device = imx_pcie_disable_device;
+	}
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -1330,6 +1508,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	mutex_init(&imx_pcie->lock);
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1627,7 +1807,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX95] = {
 		.variant = IMX95,
-		.flags = IMX_PCIE_FLAG_HAS_SERDES,
+		.flags = IMX_PCIE_FLAG_HAS_SERDES |
+			 IMX_PCIE_FLAG_HAS_LUT,
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,

-- 
2.34.1


