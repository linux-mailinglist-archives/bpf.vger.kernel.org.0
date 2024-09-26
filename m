Return-Path: <bpf+bounces-40364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56708987B01
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 00:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7712A1C21F97
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 22:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50734189BB8;
	Thu, 26 Sep 2024 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uc8cVz5j"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD31898E6;
	Thu, 26 Sep 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727388495; cv=fail; b=gTVgvSaszW0hxvyvkILmo/K/kossI7dtU32Y29572+QpuhbfLYGCyTfT8swXV5kNVuJ9eyHEwX5rf/OmdhpJSFTJC6rUICKerhOhA/uQPvlooMlCFcgzZhHnFROmcdZ9vTxqAcM/5I3/1cJuqi+bU2js3JeNiEsg+meh3U3oi4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727388495; c=relaxed/simple;
	bh=14hFnbXmRluLjGSiKRej/f7VpiNO+1DgtI8irwhuSwI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Cx7qMgimSezMDkIb4r8zXZtZtz7KJFjWsTCo0ox5gpUG9ugaqkbSsQNVzN/i+H3OEqdK3YEMVzFXPl5ZYnVRmL0ogHR9kdztoaQNO7hyYqzqm/xohp9aWby9SUtgORkpTeXbT1XMaefm+JGaQUUMXiUUcmB1ZuFxdPwWB7rQjfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uc8cVz5j; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgNX8glxbPmh9XY6O2jn2ng7Wq6t5pXXNWGroQXoqA2u9XLLitRxVJpisHdk1OdgRcJQB2aumNfy5XKFTgC+8bxiwvbQbU8bdsYJcWRKJgp5gmSBCaUvpgmEsdyqQ4WJQ/ieUvcoh1Vh0qORmWk0pcK20wAgHdQwdBGKbai9g1BksXu5NtJ+gR/JTAUkh2SMXUk6QbJomf/YwnK07v2GsHe4y6KhZjIvv5Ak9t9+ZRL3zsoQJyft2BepV1tzoGZDPsfwkhAAP6FcB2OO9Wmnx3MHB/2BBqMgdAnQk3MFRu6N7Nvk7mQrzCHO1gXCzuBZs7iZffcOZ/EjwvqPVSCkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzCT7+s1b0Q80pJCAftFwbhXnxu+FudVU3zL4cQP3CI=;
 b=ptGspLNwkStXVIfkuoPEpDzp5VjZGid+vqvPvCkUUur3ffXv+o70ODbtxRJExVZL4t8rVM5qKtw/65hbTnPLr2TbCYwcluLOsxzPfnSSnUVJw8PZ5iq9fDlZvEQCocLRcOKsYbSIaubhL3PqjYNSzx3UWC4cJMijgiq11/VPj5C5kd4LfoYPGALy+GUSuGtHbVtBNI3ACiBLCiKsYFosZRoHp94heQRV1aKKOm9TieYUNYxutQIjPQWUvaFYKSsKFauJntIFUA9c3+NjUwrOjCV8l2oOvMy5h7WRlCH9eJV0AGqt4LphNIAzWOIHJSkXxbD+lUNVxAegDSE4KhYYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzCT7+s1b0Q80pJCAftFwbhXnxu+FudVU3zL4cQP3CI=;
 b=Uc8cVz5jKIUjD4B+5QHLYC2MoQNEgKecVTg+4tSw2wCdGQUg2AE0wrhW9cNARxNS0Gxe8RkhJ/scThZaYddke4YuhQchVaMvi5YOeHKtd/bc98u8ridfcQ75AleQji+E9URaK1dgvVkQG4225ttJYVfPs48m8cINq0+poakFGhrRF3r0wrgXqy3juvEgc9WwOpICZfmEaaSVU4oeasgbwJ1tnazxO3I/jIDnlFs5Vf5TAwZ0SIDLlcUT4b4hG9dZM1MmRW0UO7FvQLsx71f0qqHBgvD9GHn7Rq61TWFdnKF9JiNJmx42EfldoXCbS1NpilrLH3DKUoHoCnnmp8Y2yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7408.eurprd04.prod.outlook.com (2603:10a6:800:1b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Thu, 26 Sep
 2024 22:08:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 22:08:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 26 Sep 2024 18:07:47 -0400
Subject: [PATCH 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-imx95_lut-v1-1-d0c62087dbab@nxp.com>
References: <20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com>
In-Reply-To: <20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727388480; l=2692;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=14hFnbXmRluLjGSiKRej/f7VpiNO+1DgtI8irwhuSwI=;
 b=lT+wylHwx8H3K95Ji3hWk8mu5rKX9pmIT5c/dl5aaueI8yWK29XEX5kC0v6wnGkr86Ga+GGe/
 ++R1+SImQ5gAjJPybKk5SyrIsL1X5qcuEvQgKszPTO7wOWJhluhzQxD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 21db92c6-1f41-49a8-2dff-08dcde77b637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z25LQzdsbHNPaCtXWnRNY0h2TVJDVzNvSU5FWnVjVnAyTy9oSnl0SGJXcDlT?=
 =?utf-8?B?aklHY2V5aFBzVnpicEQ0Q3RRamNiUG1EUlZEbHlXNnVrYWZTaUlac0I4K2tj?=
 =?utf-8?B?OUppVVlyK0hqUDB1QXVYN3k4cWN1MGxoY2IvSVAzNVRRVm5MblBPMU1Wa1I2?=
 =?utf-8?B?QXhtaUl3UFdnU3BJOUI5U1VzV0trczNqS2E3OUdYZXMxRXBOSzdXZUM2bWV0?=
 =?utf-8?B?UmJkVE55NTlWa3RSSlVidnBTN0d4c1J4U2haK2FxQU1QZFBCQlNqZlR0WXd1?=
 =?utf-8?B?UUVndE9LbTA2bGxPVllzeXJWMnQ0YUhrcWgyNHFCMC82QXJZRHQ3eGxHSXMw?=
 =?utf-8?B?YS9VSk91RGdPMjB3a0w3QnVNakhDamJYeDNRL2xiZ1ZBc2dQeTltRGtOSkxo?=
 =?utf-8?B?NHN5NmhTc2J5WkhXRmRRcWozVW1tQTNwNzVqd3dWWERSWDBVR0RHQ0RRa3BC?=
 =?utf-8?B?amNrQU5tTVM4VjJGT1AwQnVRSU9Qa2QvT0JId3Q0azJycVRLRHY2aC9WV1A5?=
 =?utf-8?B?SVFjckM5YUZtNENyWHRUYjVreGgzQW01eWZrbkdkYVdicHpmVWdUcXlPenBS?=
 =?utf-8?B?TFp1emRNaDkwbXVFay9XQkV6dWVhSTZOa3IrQ0FMaDhKWGUxRVE3ZElNNmtw?=
 =?utf-8?B?VUJGTjlUNjhsUmp2dWhVY2Vodk1nSmFTSS9rV0tRQ3pHOG54V2xSU0F5bDhV?=
 =?utf-8?B?eHpPTThEbjFMRHFQb2dnY0tmVEVnbnB6cXZwdUN2T0lxVElTZnBrN204cGcw?=
 =?utf-8?B?eHJ1V0IrZGdJRUJTTUtqSTFGdkptM1ordlNzY052TmR6cnRHTG9BNXQ2cDdL?=
 =?utf-8?B?NS9pYkdnSjE0am5NRUFjbUc4YVFLU1MxeFo0K252TlFRY1pMNW5McHpwVEpy?=
 =?utf-8?B?WEplZEJXUERuS01lbTg4eFpTek5lOHFqdVhkd0ZiZVVQOFBlU0ZHdUUwL0ZB?=
 =?utf-8?B?Y2xqZTY2bHpVOGVzSCtkdm1NTkVXZHQzblY4ZDV3L3JkcnJ4Z3IyT0tiTVlh?=
 =?utf-8?B?TUh2Qk0xZXpqNHRHbElmeGVOUk13U0gvV2RTUjNxVjliN0U4YVMzR3kyaENF?=
 =?utf-8?B?UGRnM0RrbWpvcTV3ZHhMb0dXUnp3ZndkTmtNc3pqdW1wT3dkeHdjNEFhMkxw?=
 =?utf-8?B?UzBacDZ0VjhWV2Q3OStnVXBFTTB0RmsvZ2pzQTVQdWpHRVJuelNKNS9scURG?=
 =?utf-8?B?UCs3dEt0NDhqd2Q3QUw4dTg0NzVoMFcxWmZlQUpabEhLa1RDV1FoR1ZEdkxO?=
 =?utf-8?B?ODJJSnRHbUMzYVpnbytLNndsczVPcTNPOFJSL3FKQlpTK0RFckFlcXVJZ2NL?=
 =?utf-8?B?YUZ1Mi8zR2h2R2lzWmNVMElwaGc0U2dRdHVkYUJDeGxYelZ1MFNpUEJ0RFlw?=
 =?utf-8?B?eFZpUVFEZDh5RW1LemNXd0Yzam5rQmlxUHhiNFRUcFo4NlhTY1Y5N3BlS2tz?=
 =?utf-8?B?M3NoVzVENkIzZmZkbTJWVXo2NmhPY0FLaUhGZElsVnV6NnZNeHJQWWVBZVFV?=
 =?utf-8?B?MThkbGNzanhnRE9mZGZPcktTVHVKNENnU0VkUDNULzljNllMYjViSXpYcVhV?=
 =?utf-8?B?TnBxbnN1VkZYOVNHMkh3UmlQb1NPOEQyNi9EcHFUNDlIMURWS1lDby9zUFBF?=
 =?utf-8?B?bzVCYWh2d2dNaHdkMlRHWVlicE95OHVUUHJWUFptZGdXb2tIZGlCWmd5U2ds?=
 =?utf-8?B?VWZTd0ZXbStGRkJDK1I1R21GR0NKNGg3TTgwUkpuWnZaeGNmRzl0azJ1YnZn?=
 =?utf-8?B?bUYvWmp3TjlSM0lFazdLcmFtRzV2dUdJZjhEV2tjL25IeHQ3NXlMbE5IRjd5?=
 =?utf-8?B?WmxEengwb1JvK1B2MlBsTTdmNmJwZzhwMWdjQjZIdkNvVi9vVnhIejJqL0h0?=
 =?utf-8?B?SUFmRTVXRE8xT0FTN3dCWEVib1Z4Ti9vNWRkZENxSmkxOFhQTERwd2Y5cEcr?=
 =?utf-8?Q?Au3CzVw6rtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHl5ckRyOWJXVkFDaHQwQ3BHZmZDcExiR3VILzh3b3VRdEN6dncrdVhkTTVE?=
 =?utf-8?B?dFc4dFpaYTJUTHVaaENQbEpyTzkzVktYMUEzV0FQRDhRWlF6VnhDTWZaRWVv?=
 =?utf-8?B?bXVreVAyNSs5WWhWbFhBaER2U1BmY3RDRU5PM0dYOXk3ZDhzQS9hcW82UmJJ?=
 =?utf-8?B?L2F2eGt1a2Q0UngvbmpSSDNDRks1V1N5dFM0YWlVZWZrWEJ2dmtwdEw3VU9Q?=
 =?utf-8?B?NnQxVVBsaDV4OTNRY1lVZWJUM0xlR2dQZXdrK1dXMlJ4VzlHQkxuaVN0a1lx?=
 =?utf-8?B?UFIxdXBhOTk3Q1h0WFpJd1hXV3JzQlV2bUlHbGpxL3NJcnEyS2RPeW1qa2VJ?=
 =?utf-8?B?eTlGcy9CMGJLWWNoQTlVTmd4dlV3UUpienkyc1h1NXRvaEthVVgwL2l1WDk5?=
 =?utf-8?B?R3dLVDBNN2JBSlI2VCt0b09ZalJ1WW5ueHZSWHlVZDIrcE11bW1kK1lneDVI?=
 =?utf-8?B?ak42bE1zdThaOXBJTWYxZ2VNa0dkbmZucEl5NjY2Y1VzWjZjL3U3ZjIwMjFj?=
 =?utf-8?B?UmMxQXVNNmtDT1N2cXIvZlIyZjNzSnprY2J5SlAwTTJZbFZRSzV2TllyWFBp?=
 =?utf-8?B?dUY5OEpKQjRKa09VOFFGeVppNUFlYW5OQWVOc1gvZEVZN0xOeVZNWFlQRnFB?=
 =?utf-8?B?NDFnaUdLWFd4V2MyM0ppc3B5Q1dTRnBHSThkQm96aHNUYnprb1lDMm42aGJ3?=
 =?utf-8?B?Mi9kTkIreE1TanQ3SHdWMXd0S1VjdkFQdDgrUGVwcFNEOU1JdTIycXloK2x6?=
 =?utf-8?B?dStxSjBaNVFIQzd2M25xdGt2Z1huOUZFK3ZPK3ZwajFEZ3VsVmhHbHd3Wnhk?=
 =?utf-8?B?aEF1TG8yVE1IdnJXcC9rRUd6aUpGQmdLbEo2MDRIOCswTUhBaUxZTVFtRm5s?=
 =?utf-8?B?T29BYmlidllsMFV1SnpkcVB0aDZEcG9sckFDOE9YdDNPOHptUHR5QzdUOXE4?=
 =?utf-8?B?NCtZcW9yN0h1Y1JXK2Z6Rm95S1ZrMThEWnBrYnRwVDZPd3M0MzZ1TU9TRVcw?=
 =?utf-8?B?OThTcEFqN25JTHpNTGZaU3ptNkowcXBYbUJNbHNSWlB6Yk83TnhKdUtwQXFF?=
 =?utf-8?B?S2hCYldNcGlVZHBJTWN3SXlkWVRrT3lKWUJiRHhhV1VIMWVwWkNURVZQajBM?=
 =?utf-8?B?RHZpeFZXUzE2YzRmN1NUTlJVQUYzYy9MZXRFeDJSOXZ3L3JHbkYycnVoVVVW?=
 =?utf-8?B?Vm8vWmNLck9UY0dsNjFDdWFOd05PK0t2Z3RmZTN4eDh4YmxVMmxjb3FzKys1?=
 =?utf-8?B?VUJJcU54eW9zV1IwWnFsREhvTmJGaEJhek13QWRwUUorVy9QSlJxeUlBQ0tP?=
 =?utf-8?B?NHI1K1JKVTR0ZjR2UHg4aWI5Tk92bVVrZWtrQlUyM05KVHUzSWJVWjFVQ0M1?=
 =?utf-8?B?eCtvdzBEYTFRSzdrT0ZxUDF1dzZtdzBra2x3NnErdnMyNVEwczJWTGxJTHk1?=
 =?utf-8?B?Tnl3dGhzRmF5UklNa3o1UXJmaFN2QUpKWUJyRndJSWJqMERRb3Z5MjUwK2l2?=
 =?utf-8?B?RC9lNll3VnN4b3REdFplQkE2SXp4UG8vWHh3YW5pdVhyU2hYNGpxZ2Z2Qlc1?=
 =?utf-8?B?MGlvdmREakVjVDZjdC9zVlZOQ2pHWGxHbGhVdkhtOEZjSU91T1lXbUhNbmZK?=
 =?utf-8?B?UW9Mc0ZpWnVXeDdqNkk1amI0QUFUSG9MRCtHM2dGMUt2VDNycmYwZENmVWtT?=
 =?utf-8?B?K3d0VElhdm41Tjg1MmpVMFBhckZEZk9wbVoxM3l6MFJyNmora3YwWXZ2OXhZ?=
 =?utf-8?B?ZGJHM3ZIWEhBS1BnbG12VDJheXBXNW9WTi9zbTcvQXBsaC9qb2E3SitpMDZZ?=
 =?utf-8?B?aDVMNFlYZVZQWGVJYVMzVEZlSFZMNHJsVkZNSURRTmwzVkFkK1dvQ1BFVHN6?=
 =?utf-8?B?SUk4ck9wYnI3dDNpRTZjdUMyL1hRanRUTkZUZEJ0TVdMejZMcXh2NFEzTVl3?=
 =?utf-8?B?dzdtb0l2ejFIQk9QdE53T0h6RTdmU3lhaU8vakZuclBYYlFSNktFbmtDUFQ4?=
 =?utf-8?B?NnhtaHpEV0tGT05NRHllSkNMakh4NjAzQ0FVN2hrdVRZV3c5Wkc4TlZSLzds?=
 =?utf-8?B?emE3V08wRk1lWlhqVGFJMnZqNUtnV0xmUWljT0xMOFNXRmZGczZOaHpESXk2?=
 =?utf-8?Q?yDg0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21db92c6-1f41-49a8-2dff-08dcde77b637
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 22:08:12.0308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wg+XxoCfKRQarqpZ4s8aqk8/AwBLb0LWRugYzLovU2jDaS/+JbCI1guqX5wA6euI0MBsFMpmLaz43dhMTg4v2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7408

Some PCIe bridges require special handling when enabling or disabling
PCIe devices. For example, on the i.MX95 platform, a lookup table must be
configured to inform the hardware how to convert pci_device_id to stream
(bus master) ID, which is used by the IOMMU and MSI controller to identify
bus master device.

Enablement will be failure when there is not enough lookup table resource.
Avoid DMA write to wrong position. That is the reason why pci_fixup_enable
can't work since not return value for fixup function.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.c   | 19 +++++++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2a..e0f83ed53d964 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2057,6 +2057,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 {
 	int err;
 	struct pci_dev *bridge;
+	struct pci_bus *bus;
 	u16 cmd;
 	u8 pin;
 
@@ -2068,6 +2069,15 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	if (bridge)
 		pcie_aspm_powersave_config_link(bridge);
 
+	bus = dev->bus;
+	while (bus) {
+		if (bus->ops->enable_device)
+			err = bus->ops->enable_device(bus, dev);
+		if (err)
+			return err;
+		bus = bus->parent;
+	}
+
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)
 		return err;
@@ -2262,12 +2272,21 @@ void pci_disable_enabled_device(struct pci_dev *dev)
  */
 void pci_disable_device(struct pci_dev *dev)
 {
+	struct pci_bus *bus;
+
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
 	if (atomic_dec_return(&dev->enable_cnt) != 0)
 		return;
 
+	bus = dev->bus;
+	while (bus) {
+		if (bus->ops->disable_device)
+			bus->ops->disable_device(bus, dev);
+		bus = bus->parent;
+	}
+
 	do_pci_disable_device(dev);
 
 	dev->is_busmaster = 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be61..42c25b8efd538 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -803,6 +803,8 @@ static inline int pcibios_err_to_errno(int err)
 struct pci_ops {
 	int (*add_bus)(struct pci_bus *bus);
 	void (*remove_bus)(struct pci_bus *bus);
+	int (*enable_device)(struct pci_bus *bus, struct pci_dev *dev);
+	void (*disable_device)(struct pci_bus *bus, struct pci_dev *dev);
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);

-- 
2.34.1


