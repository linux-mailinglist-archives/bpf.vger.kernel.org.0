Return-Path: <bpf+bounces-28926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E28BEBB9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300E31C20FBE
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6250016E870;
	Tue,  7 May 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kA5dPyB2"
X-Original-To: bpf@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2051.outbound.protection.outlook.com [40.107.15.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0C16D4F6;
	Tue,  7 May 2024 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107595; cv=fail; b=Fi2KPRByk+KgYHQP2vBe51jW3HDz66vvC9vUWj/DMdlqdgjrUHssZprq6BRG8UwDmCJoigF9ZxN8W9vX13/egqU6DiYHbM6M1jstPvwBs+hUKg9L9VQCGu5GjXLC6jchmblF48TsCuVZEI2qIDOXHha1z7EqQfIy6tAcPd7mB8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107595; c=relaxed/simple;
	bh=OgpauZFcGum+MIZkOfelPjFuUuL0H86OUPMoXcG8FfA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G6pGG9RI9DSt7dolpK58mUnmPpYjauUcXncQwAxPfGkNqnP7w48EqHFm9oi3NYD66KaWLDMFKtZEnxNTmlJJ6FccZ8ubdReTPi2OyOFq0oxQyWKQ+3I+uf+hNXWgYekGNdnOKSKQ0MOEE65vNs5gx6ultnpmZnBcAg0cvYs0J5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kA5dPyB2; arc=fail smtp.client-ip=40.107.15.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMjsteSB8W0YXCpAvrCc/ogQip0X8Fw3L7yPbDyLpFEUJg2shX1IYPvZnfWB7NnX9N8yBxH6N+qUDixeEKmuw8Ms2mNbVBnPwz2rmkxQ2YagcCI2RJSHfP0HAZe9CP4zSdtTBkGTrYlNHRu/FA5x4RDpWOk6k2QdY0tWHI4UAg6OFpa2F6hdXyG6YPc8TcmoLD7r8Cw8bVPoWjnFYUnocHvLd89VwAnoCHlgu1gODHnorqFo+8JuVVE1Gp40onK3lNfk6vAmoxZ1VTCbRL9iVHORY+5CBd2qEDFcZ3g9jF6UoXwubo3xyNuPTS8bgmzNbMs4GSWCVhGCd3GxKixi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrkaTSZzqqw8GcBn/WHt/2B3DkpbPCMJ0WUaK9Q0H5k=;
 b=Duc2VXJm2+T9+jPBk7whvHD79m+GjrPMVZ82AM4SxIb1QYSFHHhtQQT7HOpD5nD1BV0SEVldVRM51c+YZS6SPMPfoDM8DjQCdkw10SLncMcWZkBMGd31+2+Jt0z3Lw5hORy+hfqvPG9pxBfMq96JAhfHYZWv6aqJ18FDAvF2jUFrp8PBvUWm0r+R4+vOGYOnLMR75xNZT9W4830+WUOlXW4YhSUBJr1jSEuxREqn/naJB7rTFZ8Dng1VooKSMGpt+Qa6L9kGoes7GxNoMNsMIOPXRdesIe9/bzkGuPEnjDLJ2EeGUhs87/8EFOl8wAuJVCFLp8GYMOM5KBWm0WMAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrkaTSZzqqw8GcBn/WHt/2B3DkpbPCMJ0WUaK9Q0H5k=;
 b=kA5dPyB2T75oPiOQkMN7xCJblS5kKeBwA+zzTyao0cdOrlsz8D+HrEQCAhLr3u20w+Yhvs7USQ/PRm31dKgI8uqic9XkUdGPJATykcueaR20QNrOxA4Cv1P3RNC9M071Hfi6bcaFjk6H9rBesi2VPj71PzVUtrnG+iuMAW+KM+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8204.eurprd04.prod.outlook.com (2603:10a6:10:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Tue, 7 May
 2024 18:46:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:46:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 May 2024 14:45:40 -0400
Subject: [PATCH v4 02/12] PCI: imx6: Fix i.MX8MP PCIe EP's occasional
 failure to trigger MSI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-pci2_upstream-v4-2-e8c80d874057@nxp.com>
References: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
In-Reply-To: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=1357;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ol8CdKOtRGfAfsl8PVkNMeRQytaQpVg/b6Q5f4hgeBo=;
 b=kfE4VU+auk2OhfU4mAa+5x3eXAFW2Gnjj2rphlD9YN/sg5IHSwSNmM4pIo1eWAPtsBvzc7ar0
 h4B6uEzoTytCPYgT70kExZGyRcVHi8AxIORRMbJVl13dpRqeKpzZbyP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d98d75-2c3c-4153-5e34-08dc6ec60317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|52116005|376005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUZGMHpLcFd4dkhIRkZpZXZudUhMSVNpTWk3S2tqam52ekN3ZE0xUUpidDI0?=
 =?utf-8?B?VGNNOXhJR2szSFZSbHFFMnVqbUxreWwwNEZ5NXdIT3djYndCeXRZZjRUNWMy?=
 =?utf-8?B?UDlVTlE1VVBtSUYyQkNkeUpLSDQrQ0crblJGek5HQlU5RWw2ZFJFOXptdStL?=
 =?utf-8?B?dno0aUwwdVdNTVlkUGdjeVFtSkhTZGg5MmNZTFdEaGYzTG5uQS9URHB3dTNk?=
 =?utf-8?B?UDZzRlBCdXBWYWdIUnJtVjlFZUNBU2dKWElDYkZDaVdndldTNEw1M3NiRlFw?=
 =?utf-8?B?ODdpaUJWMWlJL2E3dTJvTFVwYW1KZzR2dkc1aXNIeDRmcElYNUdORHZldmZT?=
 =?utf-8?B?RTUwWmtZSlpuMjYvVjJCUGVrMjBDSnl5L2I0TU9zbDZ1VlFMR0d5blpWOHd2?=
 =?utf-8?B?Q2QxUlo1bjl6NkZEVUppQjNST2dUZUlHbllRc3VpaVY5SE1jcWdELzVSRGtI?=
 =?utf-8?B?VGY2WEdKb2NRRS9peWhDUnpkK2NSb1ZuQlFoTklzVHg2YkVMNGJBWDJqMGFB?=
 =?utf-8?B?WnV1bE44UVNJQXI4TTZ0b25jbzhhQ09yd0h5eTJBcVZoeHB2RThOOWZzVnRL?=
 =?utf-8?B?dG9SRmxvVmJVK3JxVDFzc0cwSk84RGFrWWQwd0FQTU1uSEEzVkFvMnA0Unkw?=
 =?utf-8?B?WU8xN0cyL2ljNHJRcHNxQklUU0NMeXpEdHhrMHUvcENkaTVsd3VxODBWc3Ez?=
 =?utf-8?B?WUF3OVdvNU0zbGEwemRtSThoUVZnelNnVG8yc2w5VzZFcW1hRnBNc05oMG1Q?=
 =?utf-8?B?dGl6TnduRkVWY0VheGs2Y3dmOEJxMUxTNTlHd1h6SHZLNURQQkVGa0pyNFlN?=
 =?utf-8?B?ZGtsYlpuVmN1SXZKVDl5ME9MNE5xV2hHZDAzZ204U0VEaHFTTGlMRWpjWDNT?=
 =?utf-8?B?STBGNnJhUDhNWEVXejdoUHZKRXZWeXZ5YVZ3RWxLRG1FWTFhcExGSit6WWtN?=
 =?utf-8?B?cU9DUEpSUjY1dExWa2FkTm5URUpDYUFMUWRqZUhONnExeVNOT3E3Q0xVZ3ox?=
 =?utf-8?B?Wmh6NkR5WnQ2ZTJ1SU5NKy9tcm5kaVBjV2pGK2xTMVpLUGJwS2hNbGk2MFZk?=
 =?utf-8?B?d2lDWEtkUUFYVGNxb3pPN2pvS3FtUHdrSWxVS3NkS0FZdnI1TTQycWt0bUZh?=
 =?utf-8?B?Z3N2K0pZK1Q0SmpOakdMNHNWdkpOdk5LWmpnOC8rYlFZUmdZUEdGb2dtRjFR?=
 =?utf-8?B?MklUYmVLODE4S2d6QlRURWFoZVZyajAvT0FsYVJoTEc1RnFxMnJIbHhhbXEw?=
 =?utf-8?B?UkthS0ZiQ0lSUU9qZ2VFY25zdW9Rc1JnVmJiREQwTk1rb2Jsem54Tk4rN3hI?=
 =?utf-8?B?TGc2YWpwMnMwa0d1am4wNEE5ZWJLelA5UUZaRFhNRDdlMDRMWUJibTJWWlVh?=
 =?utf-8?B?amdQTzVJNnc4alFTdXQ0ZUZrMkdTVmYweGV3cFJ1WHVMMHh1TThrU2lvcTVj?=
 =?utf-8?B?SEN5R0tEZXJEdjI5LzR0UlN4OStZRWR5TDJDckprdGFHc25MbjhKVENNQmpV?=
 =?utf-8?B?ZTBKMmFvNGlNaGVuRlVZUjNUNU0wUFQwMEg4WDc3aE94Wk5PMDhwQXNDS2Yz?=
 =?utf-8?B?NEdTMzczYmtqZG5YWUttdk9JeUE2ZXNsUlh6UGU5V1hWVStwUHNaZGNsbko3?=
 =?utf-8?B?V2pVUnlYSmZXTTFYNWQ1SzNMWjhvQ2lNTmZ5bDlHZmJNUkMreS9KY1R5RTJG?=
 =?utf-8?B?aVdsTFJEMTF1TXRNTmYxSTllcDhLS28rWWtDMG80MngyN1lnTkcycDdJUnpL?=
 =?utf-8?B?ZGU2Yk1MSUNHaVlZZjdaY0tCNTFXbDZMU3JqZGQzNXpqQ0locnNlZXg1WVk3?=
 =?utf-8?Q?o7UwStUYRaFIcDgefp3Da2i1y9qdcxkYdatGI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(376005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1ZtcGdGTXdJMHNqb1JvSzZ4ZDBWZ0kwOXptbzZIZjJpVVRXYVlvM2tRRDlB?=
 =?utf-8?B?eTlycWRIUTlFVUVEN3paT2dyZGZlQ3ZTeUtERzF3TDJiUEIwbFFuYkR5ZU5D?=
 =?utf-8?B?TWFsMDFkY3hoTmVDVVZ2czNoUkVlMVJZdlJUYXIzNlJpcHhGVVFwUVUyQWdr?=
 =?utf-8?B?ODlORlNTKzlLbXhkMlhibDg2M0N2a0t0aER2NlpCbENUaUVyK1FXSENmaGl3?=
 =?utf-8?B?T3hVeHcwenpsdkR0ZTh0MTU2SFBsNnVyaTlRREhtb1lMMmFsQ0ZWNUw4Z1Fv?=
 =?utf-8?B?SFZqSVlpS0crck45cTk2NGpRRko3aXNXUENUWFF0bGkvUk5kT1N6Ulc1TCtz?=
 =?utf-8?B?RWZ5Sys1OHE3dm41eFMzdUVldU1GdWhlMVlPeGcwMjg5U0pNbktabHpub2pY?=
 =?utf-8?B?cXBueHdGU1pUZ2pMUjB5YURZZTNJeHFmWnorR2Zlb0tDZUlkQ1BLdWhPcnhm?=
 =?utf-8?B?L3ZoT0IzbFo4WEpRWGRwZklMQlJPclFUT2Mva1BydmtRK09YQ1lseUxvRWNG?=
 =?utf-8?B?ZjRucFRYOHphWmhwMmlucWU2SzY1MnRjRE1rUHdXOXpiWnNJQnlPWVVhVXdr?=
 =?utf-8?B?b0crS2tBMklTQ3RVK3FXbzFjNWZwQlkvMmZLTncvOW50R2V6WjY2WmpLY05q?=
 =?utf-8?B?OVU2dEN6QjhEeGtia3JWdGd4SHV5MldPbmVTbUJVaGN4ekE4SWYwdWlhWXNR?=
 =?utf-8?B?d3JOT3oxS3ZrQUFIbEZtQkUzK2Q4TURIMElaUEc2c2VQOXlEeit0NjNrRGdC?=
 =?utf-8?B?bFNUd1JKUm01MUxGeDZwM2l1Z3NqVWNENmdnb1lyaTZqZ2kvaG91ZjY3cGZs?=
 =?utf-8?B?MVJmdlFCdHFSME16dVo3QW9KZ25BcVdWUUVnMnRIRFVHOXIwQXZXUzB1Ujd4?=
 =?utf-8?B?MlMrMjAxWldaVXlpdi92cWplU3gyUUF3dWJzeFNmNjZ1bmdvTHVYU283WFFh?=
 =?utf-8?B?K3gwTWFNL3lJUXdrSzVLRlYyUGdva2o0N29KSDNmZjJlQ0czN29OV2daTGhh?=
 =?utf-8?B?KzFOa1ErMnZ6TlJjL2Jma0MyenB0QWh5Zm1hN0FyMEd3SUI3SkJwa1RndEU2?=
 =?utf-8?B?UjhLZUZKRU5UQWUvREFFZDcvbEQxajN3U0N3c1NjWmp3ZTI5aHVqUkxLVzEx?=
 =?utf-8?B?Q2piYUFBdnFUZDRua2cvbjY2NmdxYnV2UWZrSWVNbzZHdEdBUEU3SWhxcTFu?=
 =?utf-8?B?NjRwN0xzaXBYSTdIVnl2NFJraTZTY05oVFA4OWFmOXBKblVnZitaUytOMW1S?=
 =?utf-8?B?dzJTZ3UzNHVmb21BNDNSWW5aZ2c2M3B4eDBKVjZNdDZha3hYZ0MyTDBhRG1l?=
 =?utf-8?B?cHluR2hucWpndk9HSmVSK1ZxVjV3cUdsVnoxbzFJbW1wbGZDTnpPMmIySC96?=
 =?utf-8?B?NnZtdGlNVkEzckM4QUp0RWhSV01vSHI5Sy9vYjhwNnM0Y3V6WlIyOEFSZ3Yy?=
 =?utf-8?B?WGRSQS90aERJUXlaRGpVcWVUamFqRkx5SGI5NGhCM240ZkVwaFBUVUZlZVk1?=
 =?utf-8?B?NWhQdXZKZm9qUE9TYWlyeHJwL09uaFdTTnJzS01wcnRlNHFzTjdpQjFtd2pr?=
 =?utf-8?B?b21pSzdjZVlWajRZalJVMy9ybmRGd0ovelREekNrTU5LLzJiZFBjTytxQU1F?=
 =?utf-8?B?OXlLNlFlRldXZlRJTXZ6NnRLMDJwd3hrUVRhbnFVOHpMcWo2VThsaFRjWU1q?=
 =?utf-8?B?ZkFDODlkeHFBd2VjeWthRmNaekZXQkdoK3JNTnFkR1RsZ2lXTnpSM0ZZYVF6?=
 =?utf-8?B?VFNOc0dJL1VHY0UrWkFmTTZTYmpIUlIydEJLNmphT29HZGZ1MnluQjZzS3VC?=
 =?utf-8?B?QkpxSm9nVWNtTVBTU2pDc0hLQ2FjZ1J4T05OamVNQi96OTU2ZDA4L3hYN2ZZ?=
 =?utf-8?B?S2xYendoR0s5cXZHTmQzTWlIRkNxcGRJTTlRVWZLdDNLUGZhRlY0VkRzcHdt?=
 =?utf-8?B?MUxVRWl4SEYrMnhKRkx0OUhpMlQ2cEJBSTBtSlBLK3I2R1VRbkUwaTRtbHky?=
 =?utf-8?B?cXV3OFRVWGtqRFRabmdvVEZTNDdBUUlRT2kycjVIWGthTGFMNWg5YW4vZXlD?=
 =?utf-8?B?TDhRSENQSHNWZEYxYlc0czNKRFJkb3g1NWlJRllIeUhNeGx3UVZnMm9nQVJ0?=
 =?utf-8?Q?v3IoE9tQ1f+LXuIM1aqjiNcE6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d98d75-2c3c-4153-5e34-08dc6ec60317
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:46:31.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4Eyfj4Df6/2karId8j7zLFiljMXNwsHVqZVzqwxrwyKCntBHXWljCfu+lLb4vLbYVzDIRjS4Yd5x9tAe71uxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8204

From: Richard Zhu <hongxing.zhu@nxp.com>

Correct occasional MSI triggering failures in i.MX8MP PCIe EP by apply 64KB
hardware alignment requirement.

MSI triggering fail if the outbound MSI memory region (ep->msi_mem) is not
aligned to 64KB.

In dw_pcie_ep_init():

ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
				     epc->mem->window.page_size);

Set ep->page_size to match drvdata::epc_features::align since different
SOCs have different alignment requirements.

Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e43eda6b33ca7..6c4d25b92225e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1118,6 +1118,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
+	ep->page_size = imx6_pcie->drvdata->epc_features->align;
+
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");

-- 
2.34.1


