Return-Path: <bpf+bounces-30778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CB48D2501
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC092B2AE80
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8053217F37A;
	Tue, 28 May 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B7iZDjEV"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF617F360;
	Tue, 28 May 2024 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925223; cv=fail; b=umd6P+33RlRLUgt5hdJBOdPnsZ9ylzOqakRkV2Phw2Jk/lvlcFyPSNs0SZrdF8kWQBgf2FuHA7QKP5epwUMvLkSefRCO6ss53vvncDeAxIxODq1asDWS+Dw7EKD11v9jpyIIhgdvv9yY7abO6yYxix/GK5JXhbqOyLlsEUajYCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925223; c=relaxed/simple;
	bh=ySu5qHk7hIAcbcfDqEd059/E1Yj5995nHxkvFfStadc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hCBVM/P9nI3mqA51HXMAbhahSU936T4YBlT7WBMTPhy5wLh4cGIcTU5iH1zzGSWzF8Y8c7swcNd68gWfluTDtvFYUNvcP4XC4xIuBFlgGzTddupc6G38TJleyenhWngBtCY8KtoyONzhLHh7fORwXqRWFdxiZE2owByaCShi0YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=B7iZDjEV; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV92XfYtOBeaA/YefcwVJk8KxJMRA6i3zK+HuqSNhZotoVaT9a0dihFDBrp/Qx/E99vksrZZd6ssi39DMlFfLgDc5CQZV01Hx3AzSKwCNZWVYYWt0VN+nHtQRX+UWJEWgHxYyx3AoLm8RwNzaIUQjUItSNucXno+0voAYDRDv+06qfbC4DmDaLCTDSEXpBbq/59tMQxeRhhO32Z+JGEUPVuVXytkOrZGnQgbwgtG8UZKaV4duB4Fpq23R0T40bMStrZyVrxwWEaL3OO0gQpV+X4CF8DlJgTzzW+KDyv00yg/zUo5aLAN3TISYDzthoJHojZ4GaoQQh9lfZ2cKmU6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDJN2Q663bcenqdW6HOaSCyJ1hJBvHmMI8fJTReImEw=;
 b=VOdsGVKwBmkqJV6gaLJ3aRKCObIzKTPJnLir0/IkqlkMv5v+TArV/NXGKeyzmWVTrrG7gd86bwILS8QqsfqnjjcjYMhHgdWUF4/KF2gDZ0axpZ2W5tFUuUwTtlmofY8LbJYK2+B5D5gDuIRrXbqPJyWNfHks8UiN3fFsSDiOoknFwbYP3WZ5+LJ+XyQ5Pf5jVbXCADt9caAONVGK4Aw35wckIO06KyxMbS2OFEqF7tdfFXaASBbEu2xstCutv+ZpkrGiUR+KEnBfWQXusXKe69yRuU5HQEuuYtKM8RynvlHBaCwBbKouXFbjCjowDcAfkkgnrRIw6OVKEDergi0vPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDJN2Q663bcenqdW6HOaSCyJ1hJBvHmMI8fJTReImEw=;
 b=B7iZDjEViSwHavdsyg0nWo9g6jPYk7SSRCAQx6lAIHUBXay8QNt+8K+4Px+QWbSHcz0tPhVoHkMkCuQj3kEquJAmTPF7TqlEKcdmyyvm5Sg1Z+0wGSqGKPRE/uE7KyiECAmoTBYw1L4n/9VQHxC9wCUP0gluBNmh7IXn2AgYxPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:40:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:40:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 May 2024 15:39:22 -0400
Subject: [PATCH v5 09/12] PCI: imx6: Consolidate redundant if-checks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pci2_upstream-v5-9-750aa7edb8e2@nxp.com>
References: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
In-Reply-To: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=1050;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ySu5qHk7hIAcbcfDqEd059/E1Yj5995nHxkvFfStadc=;
 b=UWIOyHZBdzRyNAfFu912U7je8+f0OrDQMMthCa8FHcdVVr4G87i2v3rjnhQ2F/eYANJTvpcLz
 wE60yGwuD7wD3IWM9KgFNJNszwn7cGyViVkiUO1/x04n+I+gPqbyJg0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5457b6-c835-45be-3058-08dc7f4e0125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|7416005|1800799015|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVRoQW5UcXgrUkNXaFVQTWg5WE9kQnlpWTF1VGdvYXBRNC9RaGVNMnhVK3dI?=
 =?utf-8?B?M3RCVUxxUnFsQy9UbWtyN1ZkQk02bXNEVmhNcVNGU2R2V0JLQ1VFVGYrMnZJ?=
 =?utf-8?B?aGNsdEQveGY2by9QcVNkaTV1MWdZRFJLdjNwOVU5c3ZPWWN1Y2UyOEFQZnBi?=
 =?utf-8?B?K0dCL0dwQ1JUUG1RajNuTTU1R0NqMDRoVTlJczI5Y2k2aXhEZFpkRHFUM3FG?=
 =?utf-8?B?d2JJL2ZBUG5UWEZHODFYUUdueFNzaTNIZ094SGtUSDFkSXVobGZVRklEbDZ3?=
 =?utf-8?B?VjJpOXhSNEkyRkxJbFZpOEVaak1jajhjSlpOU1F5YS8wdGNUTFlLT1U5WXI5?=
 =?utf-8?B?bVdLdXBHQnNmeXc3eUx6c2FIYnpPdkRTZG5MaC95UE9melFRb1lUeUVhQ1FY?=
 =?utf-8?B?SEdYN242OXQ2alFLdDFZWWxTNEpzanlHYXhFdEhBclJvNDNPWi9EVnpieWIy?=
 =?utf-8?B?ODRuWGlPbmFIcGxVMVRuejRnMkYrQU5oQVc4QjdvemFXSEoyNTUrVjFhd2Rs?=
 =?utf-8?B?c0ZzTkQzQ2NuWUtRWnNWOG5kTVphU0g5VGZSOWV6bEVORTMvM044Ri82NUxB?=
 =?utf-8?B?Tit1elp4TWI1YXIzc1hOZTZuV2FoN3ZMZllsVnQ3RzdKc0FTamwyUjdua2Vl?=
 =?utf-8?B?azJYeFhVM0NLQnNnaGp5UFNkNXZkYWNVd2pXQmJiWmdXWWNnTTdBTXdQWGZC?=
 =?utf-8?B?SFFaUjJrOE9SWDhqNEhoS1NLWm5leVE4aTh5NjJOSVBxaytDYlZPcnRIbE94?=
 =?utf-8?B?TU5KekhDcE5UOU9ORTNCL1BSaTgyU0I2MEF3VTErUHlyRTRlZDJBL2JLYlZy?=
 =?utf-8?B?d1ZTRk0walphT1JFeWd1dk1wakpET0cyZ0FBYTlrRHhtOWdsZUl0VThzUjZy?=
 =?utf-8?B?ZW9EWkhQSytTUDU5RkVlSXF3MGQvUWY3MzhsdXJNU3ZsT0RrTlAwakZSUkt1?=
 =?utf-8?B?bFVCT3U4RHNlQ3hXdmRuUG8rR1BOY2JRYTRsN2U3a1hGZjhFMjM5RTNKZXZu?=
 =?utf-8?B?VVpnYnBMeldSVHFuZkxmK2docFNickNOdFdZeGdOMGxCbGVyZkxoV1V4cG5D?=
 =?utf-8?B?bk95V1JPYzl3aWh3dFFqZkc0blNaTzI0aGN3YjFwR2J0cnd2MUFiUkg0YnJL?=
 =?utf-8?B?Z1l3Z0hqbndNdlBCSWdRV2pDc3IyTTNMVTkrU2FDL2lJL3g2MEFnWmlSd1BD?=
 =?utf-8?B?M3pBNkJ0eEZmVGtJRHJCeTFQT2QvUlozcU1NVWFLdU1SZysrV3h0UlJmaE1Y?=
 =?utf-8?B?R3djUHpFUlZrQmJHVUxCdGMyajVqL1kxcllYWWJmYk5XWno0dzNiMjFpWDJQ?=
 =?utf-8?B?Y05EWTF2R1k4Y3pQY2VzU3ZMOXF0UEMyeGcvNCtodEo3elpVWS91Vm9WN0F0?=
 =?utf-8?B?eW5LVDA0d1pic1F3SjliOVdaOUYrNUhQZU10U2phMkFyWXl0dG5pOEk4dGMz?=
 =?utf-8?B?Y2tsbkw4cVdFVm5Mb0lzVEIvY1JXWnFybCtDVjIvV1huSzNQaGNYL2pYZlMv?=
 =?utf-8?B?cjJMTlY0azdXUkdqeUZSNmZoSVFCeTdKT0tqMHJlWXN1TmtINzVtUHV4RitE?=
 =?utf-8?B?cmxIaHUrME12UlRtUUpVSkk4YnBPbDAzUytKN0R1WXZZTnVzekZabFZnTnZy?=
 =?utf-8?B?Z0JLd2RhMmJTRVUyYWNEY1ZuU0FucTdsdFRITkxuL0oyY1BlTVFmZTZTRW5u?=
 =?utf-8?B?amFDTGZNUko4RzJOeFhLbjlKUExJM3k3REtoMTFzdGhlbm53WVB4aHU0UDFX?=
 =?utf-8?B?Y1RQa0V6eitPZWhJdWlKb1pmS1IwRkVOaFljaC93MGhPODBrR3JRd1k2Y09J?=
 =?utf-8?Q?gg+5Cmk1Jq4NB1aBtT6T4AMg4SFdf0gpAuvQc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTV0Rm5mazZldWhqcFR6UUJHU05JdVVDc3V1UjJYbDIxbjBheWtSRmRoSlNX?=
 =?utf-8?B?Q3JDaHkwalBRTUZzb0J2cDNNOTNlcXU1by9SZDNsSU5UdVBaUWE4Q1ZxcTU2?=
 =?utf-8?B?TGRGak1Td2FWSUpqVFJYeUx2REVHNXMxUndYVFJ0dFNkbmJXUTg4ZGlETXY3?=
 =?utf-8?B?OXdLK2RlaE52L242bVpOdW5jUG4rVDU5cVFBMit1STFmRE1Td25PRmtZaEZI?=
 =?utf-8?B?UjdCaTdvVlZDZGRJbUJuLzZ4U1c0SzRCeEpNSkY5NWtPMjBPcXllcXpIM2RJ?=
 =?utf-8?B?MU9KY1VXUVpucncrMVljdC9rTGt4TEgvb3Q3OXAzdlByeEU0U3BNaXZUZWhh?=
 =?utf-8?B?L0dVRWlaMGlJbFhTRGl1cFpLeWV6ZVNSK2Vqd1FxdXMyMndzczkwWFVuaWQr?=
 =?utf-8?B?R0pmTG0ySnNmNi9IcGpaYTNBN1ZhdDhuUmFaazM0VGFOMnczRkFTdE5EWTFV?=
 =?utf-8?B?U1NpVUhoSXZrTlVlTHhPZHFlWFQxZmZucHBGRnJJK2h2Q0FKVGJsaWk0STJi?=
 =?utf-8?B?SjdtS0lqMjZ1OC9RVDJUSGNzS0NOcythSG4ybnkwSUZ2T3locDZndnhSc2pC?=
 =?utf-8?B?ekxQdVdweUcwL0hDQ1BtVEJOd2Mwb3N0WWxSTlNocWxDVVVIWVR5MGtFcURO?=
 =?utf-8?B?emJKTlRnb1h6ZE9YZ0FZeHp4Y2dPdzFyc1VWN1NTOExDcmt6SkRTWDh3cXBj?=
 =?utf-8?B?U0luQyt2MXZIbjZXT0t0QjgwUjRhRjc0dXVwMzNBSllpV0lyQ3pjaG1BZTk2?=
 =?utf-8?B?UWlOekdSSmNjR24vaTRGTkREWjE2UzBWRnVpU2p4ZWRmb25sZGFRdFRBV24r?=
 =?utf-8?B?SHYyTnBna1lDcms1NG1yWVYrbmsycWFUa3R1NWVBZDRlMmQzcjJ2SE9Kdlk2?=
 =?utf-8?B?elpDUGN6bFEvOTFkc3EySFZMSUtBVW5kSGl2NmFzYTJOVlhwamhGaUlTQ0xR?=
 =?utf-8?B?Ujd2bUZzcnAzckdMeEdxaTJsZ1JrVzFENnhZSnk0Nzlqek5hR0tORzV2bDlu?=
 =?utf-8?B?K2wyNEtMSFRJSnp1ZTZPMGRuSXN1UnRXcm0xVmhpbUlGZXFBVVRTU1czTHl2?=
 =?utf-8?B?aXY0dFYxZVVDZWdRTzhyKy9HaDFQVXpFQ2x2UGIyNjhZaXZQcC83OGQ4bVEx?=
 =?utf-8?B?UmhJQ1F6d0tyaWdFaE5TV2tBbThlTjFZV2lwTG1YYXhvTzYxTlhrNzNkQ1Zi?=
 =?utf-8?B?aUl0aEgrbnljLzNlL3ZlZUY4NVRpMjRpM1Zwa2lZM2Q5cjFPRUpHUGovZklC?=
 =?utf-8?B?cFRHM24rVytQR3E3UFhFR25RSUZEVm9ySlQ4VVFuTG9wcGYvdkpDeU9CS2J0?=
 =?utf-8?B?b2VMaVR5VkRoN0lPSW5hc2ZKZ2syaW1ucDg3eElET3AyY0N4TWhHVHJhNkJB?=
 =?utf-8?B?UmZkcHRPSkh1c2hzV3NYRWJLbm4yNUxQcHVCbTVyeWJQbHA1NHQzMkRIL0Jx?=
 =?utf-8?B?SGVmeTJaMk1OS2xaWTNTbUp5ZkxwSHp5ME9VZHpaWWRmaWVXMURRckZqaHV4?=
 =?utf-8?B?RGJEL0FnbXJBa1YvREtuclE1NzJ3dlZKT0NFdHZZaHUvUTRlVE9vMkozREtx?=
 =?utf-8?B?WlhOMTVoNDBZTzVBUG9BS3lSZlNqUXREYSt0bVp4UlZ3YVZoZXJCYU9jN1M5?=
 =?utf-8?B?YnF4bkw3WW1qR1l3bkFBTW1JZFMraFd6U2pLYkpDMmhaeXAvNTY0T2N6dnVn?=
 =?utf-8?B?MlFTK24wVlh3aXNJUEhzVnRkWXFGdm85Y29OSDVwdGpRM3dUQnZmUHQ2MTRE?=
 =?utf-8?B?RWsvOE9YNGNnOVFIQzRyRVVhVEFCRXdCbkhFK0dGcktPaGpiNGNoZW15c2t2?=
 =?utf-8?B?SlVWTDhZcXNWN0ZXWlRqaFRkUXdnN0txWi96TFBtWnpyV0lUSzcrZVpFbmQ1?=
 =?utf-8?B?K1ErWG5iVC8wU2JuRXRJUVNncy92ZjM2VlAxTHVFZzQwLy9JS04zUHg5UGpM?=
 =?utf-8?B?Q1RScFd6WkNyMkVDWWZnZ3BVRjdUbFdJVnUyUXhNYXR1NUM2aUtCeW5hWmky?=
 =?utf-8?B?c21pR2t1cXFDUk5DNmVTZW9JdDFqd1AyWnlTVngvTE9ORjExWjN3SDlGQktF?=
 =?utf-8?B?TFl4b0ZxZkhtdFNEVFEzekI4Qm82NVhBcEhlSWpjaWw5eEhuSWhmUW9YeFVZ?=
 =?utf-8?Q?X3os=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5457b6-c835-45be-3058-08dc7f4e0125
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:40:18.4119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nl3j9YI2d3JMiSMGcctTRcpAvHfJKMx7lPQS74zq3+4dba+5baTuVGPSc6ooGgAXw7yCtMZW29pOqcxcBmv6Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655

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
index 8ecc00049e20b..c8d58481f80dc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1028,9 +1028,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
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


