Return-Path: <bpf+bounces-32333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592DB90BBD7
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043C51C239D7
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF829199224;
	Mon, 17 Jun 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SZjWYQVw"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2076.outbound.protection.outlook.com [40.107.103.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC51990A8;
	Mon, 17 Jun 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655441; cv=fail; b=sFvJzSyAFgJRaRMuDmdexTJyece9PKHreyqrQbNHsvbxOvef5J057qavERlOhLF+cxcAGuqoYVu7lguj1LjVgUfvtVJ1JcRTe7yLgUz/SSI5SsJoKRuAxI7Ptt8hBXN0ieH6PlDB37F7xdHxi7GxDk8zdDMkwWGrRLHEcniReoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655441; c=relaxed/simple;
	bh=bQfDRFUmBsjiBwmSYlRFuiuVTUjSe2+Qil7MOoSm6P4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZpZDIJL47ygnA1yeqW4j7TaBWtxyy/2VchRWd9Ozcq2p664jkYohDf6O0k+rLxaHO6lzi9ui8yvmeCYj9yDhM8+0n3FkEq1FuleNm6mjV8IELPK+uDzo8PblSiaT2I8lmfZqnJcCelZRbCCKEkZ1QxVIJ/i4pOsXarF6iPkIpdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SZjWYQVw; arc=fail smtp.client-ip=40.107.103.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKdDtz54JKCobdNItONe8nbWE/36Rk4v/Pk5EBb253g1z1P863juD10/LHNeRQQj712Lq5AvZ8AZ002+YEgv7ZDAmcjL/St/7XhZbh2K3zEo5jaceE1IdLpZTtEwnFFa+qI3EYlRfbMwZVipSrj/FafbwnAGDG5dG3dXVWv+wM45NUf9ZEL+ti8a1dk8KeL9dWGIBWyEURl50NIfBZ4THL7Ffi0P/yUzowFB6bDxLu12mAjhfaMj0XRToBMuOxtagyIJVAd0Za6YEqIZKDkncT8NSIw589ZqhZtAWOZk8nrelh8xd+TeCRHbLPdGoB/UZ7cwbNtkRNZwX6/yZ0la1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4C4bd6RCTWMeAWPYur9JFr3N+1JAJyKW82kjXipNJY=;
 b=Dj3q4Dh7tdgDbsAjgBpBf+8ppQo+EicBgjCcS1UDgFWxYC2X4cOLVQGI6fhyhXbbzgyJ1Yf4YK7HCocqKYX2jJjW9Iub5gUQojtPxmxRJ9Y9oAp3SBiSyxVE+nwbSOt0Os0CEvhFmG2SSAmjC9Ko62xoHHo/SPIlX1Cafv6mSuUBjFAJfHr2slZ89FZqHLVUsqwRRHLQbR8EztbyG4w0vJaTwdMF5TEsDpZYnxMHeGfbVaGJBkWgJCgQZUO1e8eLKdLSfyblT0VbwlMYETBAo7Lcn1QSrp2DjXawWe9DTSPsWd6uEButN0Mh2p4wMCmteHcGgcTbZEzntguQUwOltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4C4bd6RCTWMeAWPYur9JFr3N+1JAJyKW82kjXipNJY=;
 b=SZjWYQVw5RN/vASJwdeRmt9czkMQR/8gE9rFrd4Oe2ehf4GTikqa8FBOVKD6oyD4ULi24cEkQCVaUTtrRXte7vNAO+tgi1YzhtL2fE055022T26tc52QkOPmmKZGLFdPiZMOd1gt6pw1gGXGn4jHrgiEwv3xQypAhMOGr0v/vgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:17:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:17:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 17 Jun 2024 16:16:37 -0400
Subject: [PATCH v6 01/10] PCI: imx6: Fix establish link failure in EP mode
 for iMX8MM and iMX8MP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-pci2_upstream-v6-1-e0821238f997@nxp.com>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
In-Reply-To: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718655424; l=1456;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=K6q4j4Cq6SV/EGfAgEb3QEUnqNvPzUe6F4DIJInjKRQ=;
 b=5ehFQPKy2lBa0kl679ExySig2nvMKJxELh5ihOZtM3FBIJvsovNT59vYvM4+jMFQla1QE6SMc
 csswxe4WmdQAScA8TdHa14yccH71qL3duWF6PwJzPGFQ2n4SUJz0Myt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: b298ef22-d82e-4c29-816e-08dc8f0a7bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVZQREEwcWd2RFdRWWY3L1ZuYUp2azhZbEt6WGxsbE1SWXIvM0xLY0Ira1Qy?=
 =?utf-8?B?NW92STVtQXdSUFJ4RXNiaWJnakNDQmdGUGhXNjIvbEliTWU0SHZQWjBSbnIx?=
 =?utf-8?B?NlpLNGgwUzlsZWFzRFA4TVJHc3Juek52V05PQzlRUkpic1NxZk9WbEJpY1ly?=
 =?utf-8?B?Z25zTk5wR0cxQmZ4eGZuakZ6a2xMUExzTC9xdzFjWmFvRElVVEpZMXA0TGlN?=
 =?utf-8?B?akM5YUtxOXFRZDlQamxUc3BxZzN2ZTlMTDVDK3hlcGFGZlhBZ295VndpS0tz?=
 =?utf-8?B?Ujl0Umoyb1l6WnZ0SnRHU21PMVhaK0V6d0lUZFN6Ym9IWVpGY25ZR1p1R2Jv?=
 =?utf-8?B?U0VPVVFEYURkNExmU3dsVjlNbXpsZXpaRG90Sk0zckw2LzMrUUx6Y1phL0U0?=
 =?utf-8?B?OU93SEhSSFhIS0lEbkNmQXNCOVdlR2dFNUIrKzA2QU5USE0zS0NpSjI1aGVD?=
 =?utf-8?B?VUpTMFVOMk5uY1dwSG1tNE9lL3dKcDVjRUJxenRMUnpQemxUNUxIMGxoK0th?=
 =?utf-8?B?RDN6MVBCZlNlN1FnalhWS3g4YSsyZC92Y2ZNMGl2ZWd1eVNTVFJpTlhCcndX?=
 =?utf-8?B?eWdPWkF0ZTlQYW1VTlcwcVErRmNsL1JsdW94c0FOQWZGYlgwWDZ5TElSclNr?=
 =?utf-8?B?L1FmMkVQaUpobVlCRThRSXJFemN2cDRKMUpLNnBLWlZVbDR6T1VWcmU4WTFz?=
 =?utf-8?B?cGFhU3VzaUdZVTUrRTZLR2IzMS9WOWhWSGRteWJWQ05IK1NBYUlUdjd4OFRw?=
 =?utf-8?B?bkxYaDByaGVkSEtDSGJCTEtFSjdWUTVNRjhvcjd6THY1Q2wwSy91Z1ZIclpt?=
 =?utf-8?B?SEIxekVBbFMvand4cE5vSFpjNjBHUHlGNlBBSm14VlViaWFKenZZdWtKZk1S?=
 =?utf-8?B?STMvWkVHVkJuQkNjLzlTRFZPUWpHbmtNbTBZVnRBTTF3ZVlWNHJDUm1waXB0?=
 =?utf-8?B?MUdmaWhBNzZCdFpUcTZ3TzRLU2FrMHh6V2lZQ00xTW0xTEhUdVpQQzdqdlpO?=
 =?utf-8?B?SFdBVDBCR0IrZG5yV0h2aEQ2elNNSVR0ZzBWeWlJOWNWbkZCbEE1ZDQ3K1BK?=
 =?utf-8?B?ZmdabXpwTFdqV3pRYkRHT283SkphTHEyY3docHRhVGZFUzJ5SEprVTNXcVZB?=
 =?utf-8?B?N3gwdjVhTEExTkYwejJuQmc5M3Bhdmp2RWZMUGxyL2x5Vm9xVnU0Ymd1V0I3?=
 =?utf-8?B?dndncG12bmVDanpUb3c1OGxnNUp3VFM2a0tsdlFTYWdXSEJPc3d0VndNbXcr?=
 =?utf-8?B?cFEreHdwbjlDU0RTQTJYWDkyRXlQVXYvcGVIaGdSM2NHeTVhcU5rUytuSnRT?=
 =?utf-8?B?L2VTZ2tmVUJPemdFZnJCeFUzVWdaMmJrTmViY0U0Vkk3WWE1aWtxZTNQNU1X?=
 =?utf-8?B?T3VadGhVV2U3aW1odmNtWUxBaHhtN29xUmwzaEZZdTNFcGZ1RnFNOTY4OVBv?=
 =?utf-8?B?M3lOYWFTb2lOU2g1cDdwaElmclVVblBnUFNlaHhEc1dJVnp6alZnaEVyQ21z?=
 =?utf-8?B?NS9KWXpkek1RbmlER1NHTjFSSVB6a21mU29HaG04eExpTTBLTTdiWmw3bmtl?=
 =?utf-8?B?QVJpZzhiRXVXV2RkcGtESVRTTzNnN3VJOFozemluZnMxamNNOGMwcXZoMEE5?=
 =?utf-8?B?ZnVFSU85Y0pmTFVYdldGRU5yMHFNemJvcEVwWUI1Uk5WcGNqODBNVjhDZkl1?=
 =?utf-8?B?U09GY2doeURJSjYxNENySmJ1SzRqQmpnYjRnanZIaGtuSy93M1FaL2lEL3Yr?=
 =?utf-8?B?TjF0ZzFjS0xsUElyQjVsMXFINzlXMXdmRUltblY2SWdqbzE4YUNHVkpFbWt6?=
 =?utf-8?B?bGxqQm0rZjJVTGJlUXd4NytRejdScFVGcHl0UXIwYUZyWFMxVmdYR1NsTWhL?=
 =?utf-8?Q?B3PySKfm5I1wQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2tqT0xnVDAwbnBWZGlHWFJOVnZxNzJWYkp3TThhZkJmUEc1Q29sQnBnWXRJ?=
 =?utf-8?B?MFZtM1dMRXdnbnpoZGdOQ0RTc29TUllvdjJZQzJnSnI2U2FqL05RVlVmeUk3?=
 =?utf-8?B?NTlaREI0WHlrVFgwMHZKUUx3S0luTEhpaEdEamVSb2RzQm9ES3hIQlYyWGdW?=
 =?utf-8?B?aXg5Q0VJMzRJQjlzdmZzVERSeG9VcEVWcnIrRnk5WkZXUXBWVmhsY2VVRThy?=
 =?utf-8?B?QnJzKy9hT0ZYajlOSmZWUGNnR0JMWTBvWFdMcjJjaXNzREZxYzVEdHZMNk4x?=
 =?utf-8?B?UHhZSkczRHlHVnpXa1B0bEtGTlZSR1ZITndzM0dCVmNiYkpDSGN0Q3R1Wncz?=
 =?utf-8?B?TFFOZFduYi9paGZldjAyM2R6NGFFNGRmSSt3ZUJ0NFVROFdTWUtkVVQ1TFow?=
 =?utf-8?B?Y0ZyRXVScWFKak9vYklLMnVZR0swcUpXQXZSTEFDN2hLR2JzRnE3bFlMcW1k?=
 =?utf-8?B?THhhbWhoWXZRZkFrbWVVcWtjMEo3a0s1ci84MDFJRFpPR2hlVmVtdzlrU3F5?=
 =?utf-8?B?eFl0OEEyeGN4WG1Jd1daaVFwdUJSUDkvakV2YnV6K3ZwZU15KysxV002alRi?=
 =?utf-8?B?dEYyeEdaNjFyR2lPSHJKdW9DSDBLNHdJb3VaYzRoWUpyYytUQnFrVWYzeG1S?=
 =?utf-8?B?bGNETmF2bFRHcXU0Rk9wblRBVlRxaUdZa0F3ZWdrZ25FSk02bzZPcEpyWVA5?=
 =?utf-8?B?WXZYRnBhZFdVVFhma0EzR1IxZHpibW9td25mUWplSTNmM2pTT1A1bmtiTU81?=
 =?utf-8?B?YVF5QTVhVnZzSVB2VWhCNXNYYW9jQTlGc0JXMGZmVFNEYy9LVEZIbXI2ejVL?=
 =?utf-8?B?a25kSTZkamtTMWM4TzRpVWFTMWpDZWdmaXJmYzFnQVY5Q3gxeVBtR0NzUzYy?=
 =?utf-8?B?K2V3aHFrMCtXUXB4d1FJck1vM1VYMm44VlRvMXgxa0lzeW9XaVRsVkZTTGcv?=
 =?utf-8?B?TXBqcHh0SCtSYWZUcGFxVThPeDl5T3doYkVPRnk4TDVTMVRHOXBpamE3ampQ?=
 =?utf-8?B?WmxmWmdHbGJXQVNRRzZFWTgwNEsxRnhLWTRlUmRoeTlWbVY1b2tQNFVPNklo?=
 =?utf-8?B?amsyM3RUYVU0MU1QSTMwMHJ5UmpOUDN1OTVRdVFsL0YzTWZVTUYzUEhpM2JY?=
 =?utf-8?B?enpiQ2tDMjZkckV5M3B1NUREMUVwcnJxYW9wa3NSaXpHNHFPNTQ3NmN5OHNs?=
 =?utf-8?B?ejhFSFFPQVVCSnNZMDJVeUVhNkRWdU9sd3N0Sm9qaHM0azdrTGhVbzZDRS8w?=
 =?utf-8?B?L1JmVmdsQjJQd29hakdvMFNJZmdxV2J6MzZ5cVZROWxpSUZDSUYzUmhwTkwr?=
 =?utf-8?B?M2Z2UEJaR0JreW9iWGVxL1M3b0xSWGNRWHlqWEE3TFlnYlJrMUZoVnNHZzRI?=
 =?utf-8?B?OXNpUGE3K2x4WWNrVHVxQWo1Sy80cktreFNxQmNRQ1pyOFFDZkFTTnNHdkdx?=
 =?utf-8?B?RGNpNmt6b2ZkM25qeTUvQzhiNVd0c0xBb2hxZmFSdVBGNHM0OEJQOE9IT21Y?=
 =?utf-8?B?MlVJSzJ4ZUxkYmx6UE41RGFsaXFlazVKOG1iYnVNaHpIZ0NkODBGaE9zNkZF?=
 =?utf-8?B?aE1BQ3NCTkNRVndLVDZaUzlBWGJyT21BRzNvaEZycmwwK0QxaWNFQTRCcVZO?=
 =?utf-8?B?T1QxWHRoV1lOcDBHNTJlNWxab3dGQjlyRmUzNGpBUzJPMmEzMmpjWnB3YXQv?=
 =?utf-8?B?WnZOUm9mNU1GSUNxQWs0bm5uaXU3YmlRQk9STlM1VGozQ3ppR2hOSlZMN29u?=
 =?utf-8?B?SDJYaHI5L3FYZi9rYzI5VWN3czRUWnE2ZDltOXVhbXZPNjdjUzNHWm5NeHdT?=
 =?utf-8?B?d0NlN2dMRFBxK3JvWVhSc25RVi9xdm5zSTZDSG53ODhXdnB2bE9Tei9zSGlP?=
 =?utf-8?B?cmJyZzh3TGZERE5rZ3JHOVFBTWJ4ckVtV29Sei9xWFl3UjEwQnRIMzdwVEcw?=
 =?utf-8?B?VDlvYlpScEFPOVl2dlY2VUorczVBZWFwdVArV2UzV0g2RHBsbUp4Tkt2ZXYv?=
 =?utf-8?B?MU5WL3pmUzF5RGJsZTR6dGtCY3owOXU5b2tmN3dPdzkzYVVJWGpuOXlYUWJ4?=
 =?utf-8?B?UEJ4bkFGd0tGSXlyU05yYkdVQW5HZmM5cHdxUXBuOGt0N21YaHA2RzhCTlNX?=
 =?utf-8?Q?eYpRb2L2UVtbbSJsDc9+CHDp1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b298ef22-d82e-4c29-816e-08dc8f0a7bc7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:17:16.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ut9r386IWK+QeHki7gkF5EVJ+/L5SPATUrCJn8t/feoWyP1HlqTzLFYjj5MuwCdwVX/YdbEQbQouPrfu7ZOGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

From: Richard Zhu <hongxing.zhu@nxp.com>

Add IMX6_PCIE_FLAG_HAS_APP_RESET flag to IMX8MM_EP and IMX8MP_EP drvdata.
This flag was overlooked during code restructuring. It is crucial to
release the app-reset from the System Reset Controller before initiating
LTSSM to rectify the issue

Fixes: 0c9651c21f2a ("PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 917c69edee1d5..9a71b8aa09b3c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1578,7 +1578,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1589,7 +1590,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,

-- 
2.34.1


