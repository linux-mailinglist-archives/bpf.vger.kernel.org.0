Return-Path: <bpf+bounces-43926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD39BBDEE
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6CC1F21DD9
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFD1CC89A;
	Mon,  4 Nov 2024 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H5n+TbXf"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7391BC9FE;
	Mon,  4 Nov 2024 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748208; cv=fail; b=Zsd2qq5rRiston81RKJ/afkf6lIoWx0x0C4laL7pdDxRyK1ppwCKfywbzW9KkRLeYSgWgDbKlJ0Q+tfwnCgmnJzadhsal2sC0gpulwVRYHrXd7giw5Svs4MY7XIyv+W5bFceUF6xRDPnjF046PWRxNRUkxL8MPEGsZUMg9fHQks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748208; c=relaxed/simple;
	bh=8CKgz0CXHgolk8bfnP5P9n7wD4iGkd6sl+5AuBcqB38=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pgfDPaUcX3tivTAR5dZzqQj8jabC+ei2cWj8UYgexLC6TeGGq7ihpVRB1qOd/x6mzno62Lk39xpiu2Jo4uGn6puutOs5TWBVEkSa5hdnmFk6AxxndrrnhAct+uOfkMktzwcwpVEA4wLQxoljcXZLdfWZPsRzCPYAxHhrA6hO9ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H5n+TbXf; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zuj4S/8NepRymJCwsAiOQOCLVLsiZ9KDEe5Ge/EinzaxNlAxKN8cXkae46x3Qn9QUmQ+zulnIv/hZDRAogWyWhxViGPL7Wq+k97RBK8k8+zlYknOOt1/Lx2c6DphWjhlp4CjPyfYTKQ9HX6aS6IpuBG+TvqgNZoDLpWaHzsfAZvRvm4Vgi7okhXr/8TSQDQwm8CAgUdNoUPDiAPUw91CgoNZx8pn/oIPdkV3Al+jmbkmL0VAyyYllCl/AxVnFRz85/0VwySrmmcYihAzncv0RbAiZxqsU52lftiGO5RHSAu+J3RD09MFXmrkGqFOrl2UuaRD4+TajGZCT3eM7ehu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+Z6+TCJdDoy8UwE3Y9/Bs3kkPwtKnXI87qBGTTmAy8=;
 b=WuuFIkMTkMFDtbC6AaWKOKVoVXHL1wj+7d5L262b6Svpo///PokxbKDd4Li9bxDBVjh931rC6/25nIoOoWmml2Rm04eb8VZRP9oyfM2O1p7ZbYbNxyZpb2m6sYAufHZpsUxk+VkZQFwgTBqvXbG50E/zsdjFPuSdEtOSt9YJu2X3mssTvAlGAF9YAAaKT/XXy0kqdgcFZ87nOvRyIDEBX1VsN/r15TZyK3aUN7dYZ1KR2bzXUDw0e3pkYrfmO3qx0PzEonLXaWJlgZJ723N1AmG6CbOcVO+eqkFSR90JIt2+O08binJzFkN341pvoM8U2YjknnyIL4KUNbIbikM3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+Z6+TCJdDoy8UwE3Y9/Bs3kkPwtKnXI87qBGTTmAy8=;
 b=H5n+TbXfPYzDEDcA/oebki1wKmfIbcDLvKzJqOYq4p94nu+QxpBVafwJIqOHBZxA0Lt3BT3ZDleP1o921ghEK3/lbSFf+mGGdVOoNKmagxLqWWoXzfyAgsZ7VE1hpOF8SK+ojdqUiSw+/SwwhlHbpgfxIQS5+NHdp0TNLYvNS02B821a+V449DPl8/mE+R0ePkXwQZu/TMZjB2YJIg9P4FkScs4BTcE3T4XuHcPfgSO65MwMDVGnQGkS74o/UlScrnEljJ4yAiDD2XVEjS2Jd8SCH8Q+Dj8k/L76z19mnVs90ldJIaR4KWW4HKZNTMEbwnWy16H5m+TF/sc7q7Bvjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 19:23:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 19:23:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 04 Nov 2024 14:22:59 -0500
Subject: [PATCH v5 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-imx95_lut-v5-1-feb972f3f13b@nxp.com>
References: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
In-Reply-To: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730748193; l=4072;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8CKgz0CXHgolk8bfnP5P9n7wD4iGkd6sl+5AuBcqB38=;
 b=dcSFC3MwwFcbr4holoLbUXJvikUCgME+sFBu83RzwZi1VDYdbP9VGI2nFYMUFYBbkkwMK/DSF
 eer7aKWDJBlBGACBF76LbyFgji0htAtHM/DV9UfFTF1vrQ1YJByB5Gc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d239559-d862-4aff-cca8-08dcfd06276a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHpFbldLOHZYNmQxQUdTaDg3NUhzYjVlZWtITWZTYnpLaitKR25SaFB6ZWI5?=
 =?utf-8?B?R3FxMmZCblVpN0FzYllqV25pT0hsWFJPSWJUNHh3OFNVeEs3U1NNVnljY09v?=
 =?utf-8?B?L3kvcnZyak13MnFVbVIybTFINnBKN014VEpYaHpCVmFucHBzUUlieHo5eElZ?=
 =?utf-8?B?Z01CbE1sWXZmNk5scmFCMDBiRHM4Qkl5UjJBd3dacTFBM0ZUTDh1VDlob2Vw?=
 =?utf-8?B?Z3pOM2VBVnhDK3B2RDBwbUVTeFE4eXlGSEJ2TUNqbHhhRnlpaTFJeGRQekhq?=
 =?utf-8?B?NmJwSWxPd1hJSnM2S3ZQV3RHMklDNkMrMHp5ektYVlZKM0VUZ1ZaYys4YXdj?=
 =?utf-8?B?Nk0wWTU4MGJKQU1ubitGMkIybEIrMXJicThrRzBQcUkrOVcxNTNTMThnOC9E?=
 =?utf-8?B?Y0FCeFlJbWlBMG1hTzVqNnBqT21WV21vS0hTRkNVNXhMNkdyMVpBOTZEdWJL?=
 =?utf-8?B?TTlnSzhLaTEyRHJzUFNCNW1tUjEwRVh2aFErL1l1SHkyczE1UitwaDBoN3k3?=
 =?utf-8?B?dFp5RFRoUENJUGFhV0N1MTdHL2pzZkpiZE5PcURRTWNEWWJ5RE1MSUdHQTY0?=
 =?utf-8?B?M21uTUVLNnZ5S2ZXRlc5NGJUVzBTRTZsOU44dUJJbkdhVEZZdDdEMmpWbmhw?=
 =?utf-8?B?dlUxZzJlL0dOQU9NTmJJR1ZNZjNjTmRBRWNBbW83SUdSU3lFSXVpczhFdzZs?=
 =?utf-8?B?cXpYZlNzQmhKSzNQSFNreFZaVzNZNlAzenVoOGR1aE8ydTRmSHE2aTlZWVFz?=
 =?utf-8?B?Z1Q2bDZ3bUhsZUZIQXRtU2RYV3VqNFlFNVBHcHIzZGdJYTM5eWx4NndjK2sz?=
 =?utf-8?B?NW5aZlVWL3E2VzVob28rL0lYK21TNVNjN1M1ejA2WnhTMVBnT1pwN3FyRC9q?=
 =?utf-8?B?czFaekNsZEswODllSHMyT0t3bFZES25Ca1R5VW5aajBnQ240TDRDZjdkREVz?=
 =?utf-8?B?VngvZXF2Y3ZPVmRyNEhkNFdtTm52U2ZUcUptWUpGbXMweVp0aENsUFEzTzZs?=
 =?utf-8?B?T0o5VUZvMEVyNWdwWE9lLzJmdDVRYmZxaWZhV2g0QVFxdGJOZk0wb2k4b0ZV?=
 =?utf-8?B?ay9US2c4NHk0bDh0ckY5WVdQbHdVT0daMEY4NU1TNXNMbS93clE5YVQzRGpC?=
 =?utf-8?B?NnJ4TVZ3OHJJSHJiMDZaQlNIbXo1N1RjdkVuOEVBWG1VMzVPS0JmbDloOGpX?=
 =?utf-8?B?TCtjZ3JxcWViSGU2RklKRkx1VjlIRmNOWldRMEhLRmtCelFtMDJaZUxndzJQ?=
 =?utf-8?B?RUlzWnhKNHNwdGZGZ2o1bzUvTDl4L1ozUXdsOExtd3FhMlBEZ2hoZFFUVmtI?=
 =?utf-8?B?TlR6dDVUak9YSktaVEtVTWNJKytNcTUya083ajIvZVFhSFF5QjdCZjI4VG9z?=
 =?utf-8?B?VmtSb2dNQ2p0RzhtNWN2cUx2NWVRWjVsdmZ2alpnbDh3WCtwenFFcFFDOVkx?=
 =?utf-8?B?eDRuc2diT1RaU2J1QkprbnJ4NWNUZ0IvbklpYW5Zd0k2Y2ZsM21HdGFsa05y?=
 =?utf-8?B?TW9IM1BZa1ZrZmVNK3R5Q0o1cDJMektneW1nQ1QzaXJhRkM4RFJ1dmh0QVlv?=
 =?utf-8?B?cmpuMDN4R3F1dHg1OGtsYjlLV0JDSlRlbUh3NTBuTmx5WkRqRHNweXljVkE2?=
 =?utf-8?B?ekEzTzN2bWw0eWtZNVJWQUR6Mlc2NDdpQWdMU2pzOGNjdTA4WW5oVWhvaGFj?=
 =?utf-8?B?Qk05anBpZXZhVW5qVHVMRGlmZjhuL21OeTNOeWFtRTA1V0xKY1hwSTdidGcy?=
 =?utf-8?B?MlkvYWt4UXRUQWE4bWpSM3lhY21ZUmZTRWovZktQREJ5OEZZZXBoWWFNb3Jr?=
 =?utf-8?B?T1JIRGVnL0RsYzVia2VmRTZnbGgvakg3UHp5YnROSzR0OVJBWE5JdENsVzEx?=
 =?utf-8?Q?rp9w0RYLaoHhs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blVPUDhwNjFKLzl1bTQ0bFgrV1lRKy9RSlpvSHc1REVlSjdoNkN0NU44bytk?=
 =?utf-8?B?dTZBaDgrRGJLNDkrSUlNc2xITU5FaFZQbmpXRTVpM2x5SVZ6KzQ3UFhIYXhM?=
 =?utf-8?B?ZE93M1BUQ3BuQnJta2ZuNW1XSGdmbmEzWDA2TFFCRXo3bm9aZEgyLy96amRU?=
 =?utf-8?B?NVNEMWNmRjNkemdrSmtFVjl0UGVOdnJqdTVsYllHTy93ZXFEZGlVaGxtWHN4?=
 =?utf-8?B?TFNSRlRSYmhUS21MTWtiTHc3ZDBPYlB3OWpzZ1MvUmZIVFdDTUpaR0ZIeGZC?=
 =?utf-8?B?bUlMVGRuNm0xb1daUGxoRVd0dllHQklXbndjaXh4M1lkVFRES2hWMThoSXIw?=
 =?utf-8?B?elNITXVlNjBBM3lyMmJBMkZzMkRvbTFJdmNUSDFWM2JTa2k5SE5Ra3V5N0lK?=
 =?utf-8?B?YUFNc3ZLUXdGRGhqODl3MVdlWU94YnRrR3ViKzBEa3gwQy8yOXF0WEEyRVk0?=
 =?utf-8?B?Mk9FWmZsSWtubjZobTdlU2VMaWZ4c1o2cEsyc254N25WUzh5WHlncHp1d1M0?=
 =?utf-8?B?NnRnTjZpVU1JMlZYaVMvNDdwTWVDRVJLT3pvNmJMdmxGMXViaVczV3VWeExq?=
 =?utf-8?B?d3FIR05uSC9yWGZ0dTcyRDRLc3dYRnNpU0RwV0VJWFhRbGw4V04wMHo1T1Zp?=
 =?utf-8?B?dEkvaHdLTDQvTDE3N015TXhhMjZiOXZNZVNia3c0NHJmT3pONXZsdDIxZVZO?=
 =?utf-8?B?RU5QTjBUcHFZK2g2VkhPRUl3QWRia283VzFXWndKM3hxMTFjVnk1YTlzZUdz?=
 =?utf-8?B?Y2oyN2VEbmpuN1krWnJCZVZXQ3U1bTdrV3Zlcms4KzBCaTU4ZTkyVWdRS3p1?=
 =?utf-8?B?c3A5WUlBc0ptZURsbjRoNmdONG1kaWE2L1lQZU1ZNHNQa1hURldkbUVLTGdI?=
 =?utf-8?B?dHk2MzNuc0pBWWRTdWtwQm5PZEJGSUdpbkVrS0tuRTR4ZWZoNUQ4ZmMxYXpT?=
 =?utf-8?B?d2tXMi9IaDdBSWZrZ09mTEFVQS9wRDFRaVBZL3JDWTBjaGRZVkRYYXlVN0hm?=
 =?utf-8?B?TGdGeFZ6ZFExU1VBUVNPREo1VVNNSi9tYnJGdncvNHIxRFZ4dWdKZTk5aUxv?=
 =?utf-8?B?aGZ5YW1oMkwrSDBNMnkydzZ0NXZhL0dad1Fld3lJbDcxUjFIYlBwS0hvNU52?=
 =?utf-8?B?K0IyS2dEYndDM2dGeDAzcEp3a1pBb2VMTFBGeENTT0orcSszNGZkTG5zeG5m?=
 =?utf-8?B?TG5MeWxTbERlSzAwWXc5N0ZENHIrZyt2NFFUNHBpZWw3bjAzNWVlT0ZlYWRF?=
 =?utf-8?B?VjJOc2xsQzRuMzZaeWc0c2dHU2l3a3J1ajFwQXZlQ0lpRnlKOCtiSVN3LzhM?=
 =?utf-8?B?cHl0bTh6RkVJQktNaTZkM1pra1NIOUU4WmxyMlNUKzFTb2paNEJOQjRUb2tT?=
 =?utf-8?B?NTh0Rk9GTVR3MmxKNnMyZHBXMyt6SWpsUERkS3RUSHRLQUtFNk9xdlI2NWdU?=
 =?utf-8?B?dWYxZDhRK24wUVRtNlZlQnhJVzJuM051QmpJVzQ3RTlRZTEva3d2R1BHRE9i?=
 =?utf-8?B?eTA5cTJXZGdGT0tkc2lKUGRRKy83anh2dG02SXFhRnh6eEcrcElGaWt5VVY3?=
 =?utf-8?B?T0VCUkx4aFJUZTZ4UlpUOHFvRCtjSzFPdWhBL3l4L29MTTVmemp3UjMyZVZr?=
 =?utf-8?B?S3RzZzROb2RINDRIU3JoMFFJd0YvTUNBSnd4bWhsbFplT3pJVDIxSXA5a2pa?=
 =?utf-8?B?NWxGUTlnaisvQ3VqekhQUnFCOVlsWWg5WXhPM1IxbkdnOGNKaTdqVGRSOElv?=
 =?utf-8?B?eTY0QXQ3VVR1ZlM2a2Z3ZjNOd1FHcG01R0hVQ1NvTE1mODh5TEMvVUFhUTlW?=
 =?utf-8?B?NWNOVHdGYVJiTHpzZmhudWVYcEQvQlBMRi9pY2hmNXBTVWZiMjlTZWs2WXo5?=
 =?utf-8?B?Zmc0T0VqOU1hU0lRcjFGUWpGTCs2TDJpWTZMWUxTWjZnY0xBRmdMVXlzOTVo?=
 =?utf-8?B?cVI2ckoyamxvb3FHTWx1b1pKYy9Ea05qdWw1TDc0dkxtV0Vvb2FVT3lBTit4?=
 =?utf-8?B?cTlMeUZuRUk1SnRmTFNXWkxCanpna0ttdjNMRVczOWc2SlAxaThTSHdvZVA3?=
 =?utf-8?B?NmR4WjhLUGJZaVNRQ3c5a1A0TlJUbVozallvUWllSmFRbXRYc2RPMTdNMjVI?=
 =?utf-8?Q?iJqs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d239559-d862-4aff-cca8-08dcfd06276a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 19:23:25.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wA3lh6PyzaTVjOD2B7Th2iaOFuWMwfht0iRo6RjBHvxGzEiuPzSBNZb/0JfLdK9uou+krexcaJ58JqE5EBsnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886

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

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
index 67013df89a694..4735bc665ab3b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2055,6 +2055,28 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
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
@@ -2070,9 +2092,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
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
@@ -2087,6 +2113,12 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
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
@@ -2270,6 +2302,8 @@ void pci_disable_device(struct pci_dev *dev)
 	if (atomic_dec_return(&dev->enable_cnt) != 0)
 		return;
 
+	pci_host_bridge_disable_device(dev);
+
 	do_pci_disable_device(dev);
 
 	dev->is_busmaster = 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a17edc6c28fda..5f75c30f263be 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -596,6 +596,8 @@ struct pci_host_bridge {
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


