Return-Path: <bpf+bounces-33062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5FF916AEA
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 16:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B981C23339
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D016C840;
	Tue, 25 Jun 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y/t6w9nz"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D5D16B720;
	Tue, 25 Jun 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326843; cv=fail; b=CaM4pZ/Wahp7GyDIIR0B6Zbk7vBR85vnImwOirr/ZFR8JZwGyQr6g4SuRpljun4WBAAMLMlxtowEmLvTa7EpdlfM0OhRMs5OWrmYBC+XicF6+N+fd7SSZRsfZFponD+h8chSlzhu2IUOrg5I804WqkKsnDg54zOh5+/ekAC0/Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326843; c=relaxed/simple;
	bh=ZeW4B+xYqwcgdHxZkId0jusuqOiUWQ33TtnM8CSf9Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m2m7VyOJ0Hg3OWg0e3cWV3Z9ah7toNe5qmeLgRosBV8geWO5kSsbmaB845L/Ohy2uqpYwi9Jr31WThYzJxzDLRPjUXvj8BEFVor8eCYDmnNpjoxWezYN9VskptsJyBC4M6Rb+PN4XaVlVYDia7ggkc4fJ9u0Z+CvPp5f4HEntwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y/t6w9nz; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA1Is1V6YY5poIVXKwnd4Of8qzYRdbwG98H152cRZzIqsetkc3aqAMR/SjVdG5hV+WZst1W4qdsxCwAO0YmEfiLR89fNi6uzpy1H3yb6z0/eWwptLMB57OjpVPnU7aA/rlOlsy6OemdKjbCg7EXQ6k5ZgjAvsl5RZv9VuuroW/7uMXt7Hw7xvIfGUbV6Sfp9I4cZsAgwtv+mIVuXFwTk9qW51klHWHfFbErDbwfk6C+TgoCOTmRb69J7qHh/GeNdkk3odMnZCxd3TE5IKJfHtCxIuPImzrWlyAUXI4bSDMdyd74ymKDe2ECD8hvsuXVSDhoCPyF7YnvixLqwIWuTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN8va3lu84hAb4wF0yAYO54FTLc32KteCc7kYfIHXI0=;
 b=OOodT2CrjBiRgE9U4DBElIlRTWCCnas78v+oxI+iEn7n/FiblKxSOLXzgOl67QqJ3jF71NDLw0n6a9pXKHfnjuFyByQjIQ+Hzlo2jTbHM0Frr3wct9azPxvgPhy1/PIl2X5zBsVZ+SyCTtwKGkBydmgYQvexnbccZUKiQvZ8NQKBn1n2o+3M6vrpDMeFtYIKmeOB+a9nQqwgZ8/fq1E8vEv9TkoystxzV+WEhdHCQw2atssEZq3QOkVSVX7uVA7viKjwy/x7sSxkHXBocrgRM2TLJx+w427WFtg30AhU+q9re1DJGpEt+9HEzC/5IVZXt9rQwpoFsHubU9qna8FIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN8va3lu84hAb4wF0yAYO54FTLc32KteCc7kYfIHXI0=;
 b=Y/t6w9nzOMbxNIOZQGgDc4GdYcFs3xSPxCMHIMkREJpRhK5QR0NQavVQOCHIqyW526ljKdHyqzSzmx2Y0w7ofVtxRhMHL0b7HAtSbPntIX3Gm62mGeebmmRw64aL0jyxrAaGiTrQJMbl7of6GTEbd7i7VOE3jeIkn8PkMBCEgbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 14:47:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 14:47:18 +0000
Date: Tue, 25 Jun 2024 10:47:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, devicetree@vger.kernel.org,
	Jason Liu <jason.hui.liu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 00/10] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <ZnrYaa3XkLJl6j1K@lizhi-Precision-Tower-5810>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
X-ClientProxiedBy: BYAPR11CA0074.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe4658e-535e-4143-b4c1-08dc9525b582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|366013|52116011|376011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUhIYWRibnZVR1VNa3ZwQUk1bS9zckN4SEpXYThlUithMGFMTGRBSWRYZm56?=
 =?utf-8?B?RGNNZW16dTRoU09qK3hvSSs1T3lydlhubkc3ZWxSL1pQM0ZFdVVhTE1iTjBR?=
 =?utf-8?B?VndtZlJ4cGtndmRzM1Zxd1JoemZGRlF6S0dFSkZFc3Exc01hVjVYRHozeXUr?=
 =?utf-8?B?a2docGJoVG1CUTF2Z3JkK3RkRTBFaWFaTGFrOWgxMkppUEZDNFVCS09FcmJP?=
 =?utf-8?B?QjdKR05zbC85VGk0c2NvZzhtWHY5elhmTWI5RlFDNWVFMGdPakFHeDMzY2Qy?=
 =?utf-8?B?QTNYOHliMTlXdHIzREp6NktMa093SGxKUEk1OVBDdUJ0eDhNdU5MOFN2TStV?=
 =?utf-8?B?RzYrTXdhRlh0Z0hQMVpvSEMvbUl0Y1F6OVI3c3pnblJBQjJ3NEtEYXZVdWRt?=
 =?utf-8?B?eVlRQVB1T3VZK0pmcHFHL3FXYkVodi83bDc5YkwvdkpHY1ZTT3p5NVBsR1VG?=
 =?utf-8?B?czdYUldBR3FHd3U2b3BpUWJHZHVsYThBT083Q2t6V0hrRjlTWWdMbE1BOWhi?=
 =?utf-8?B?TXI1WjNiMVpKbm5BTy9KNWcreGZpc0tJd0QrNDBmRnI2L25FeW5DWlRHOEl0?=
 =?utf-8?B?TVIrSU1yajVEc2U3cktKMmNWb1Y3eVRIKy8yT3RyNnpGS3YvZ1NLWGtsNmdy?=
 =?utf-8?B?S0VuTnNWdHRHM1EvcVNiMjVjRjlYY2Fvc3BSR21NM3puRlNYTTVUeDhjWXBQ?=
 =?utf-8?B?dDFXQ2FhQUZHT1JpNVJVT0JLTTIwQTZlSWRCQnVRMFZjQzFINklTd1ZZeFZJ?=
 =?utf-8?B?ZWNHdHg4aXNNazNCQTFhTmtHaUtUY093MzlBL3V2THJoa3dLTHRsWmpxS3d4?=
 =?utf-8?B?ZktNczg2VzZIVlFtbG5aYytGRkh2eVBBNy9UakM3ZFlOSGxmQ2RhWHdpMWF2?=
 =?utf-8?B?MHpudE4xRjJFbzJaTFhwaW5NQTMrLzhPcVlobHdVcG9DVzNpYjJnellUN3dK?=
 =?utf-8?B?SmdXNzA1aFJDRy9teW9HcUpxZUpKSmF6SzBBYnFwd1MzWnJpc2FqS2UyVnR3?=
 =?utf-8?B?ekdtZy93Z3dOWDhPT0FJb3kyQnNIenRkYndGRGhtSjBDTGJ4UTQxMEFyOE9q?=
 =?utf-8?B?d09wbS94OXg2R2JPMlo4ZHgybm80M253a0pmRHZzRXk0ZzV3QXd1RFFWYVVE?=
 =?utf-8?B?am4yWk9ubmErTDZuckFNVHQ4Mk5BNndFNTByM0YrMzMrQnVNbE9iTysyMHRE?=
 =?utf-8?B?OFNlSy8raXZRUkhWNWtHZGthWGVZa0lRMGE1bTlmVlZIZzQvb3UyVGVSWjR5?=
 =?utf-8?B?UVZnMDgxaTA2VjI1TkZVNER6Y1pjSmhqRlJqbUV4SDNhNFFsaHloWVlzcDYy?=
 =?utf-8?B?OGhoL1hVYXZEQkJzaVBCeEkxK0RkYkhHUkhMbjB3T052b3NHUEZtWWhmemRV?=
 =?utf-8?B?L1I3cjlEYmxXa1gvWmw4VkUxQkpHMHRkb3VaYXBBak9NQW5aMm9XUXBKcnJO?=
 =?utf-8?B?c3ErMnlNK05jZDZTRk5TQ045K3ZVb0w0dE15dCtUdDVOSG54SnRGMUE0RjFT?=
 =?utf-8?B?a0JocmlMRGxNSFNtNnZZbllySnNHOVllM1VGSHdpQXBQcHIxQmNmRHI0YjN4?=
 =?utf-8?B?cXNEREpiYVZpOUpZSE9FZTBZNlh1M0tnS2JrSmxRTm10bDk5OXRyZk5oanlE?=
 =?utf-8?B?cHNXbjAwZUFMUUx6bHNvZnpYcnJWaDN0OFpYKzFtc1I2UWwrbGRTY1ZXRTRz?=
 =?utf-8?B?Tnp4VkY5ZCtiRkF4N3JCd2plS1hoTlZoNzNrT0RnWGZJQWU5eGFHZStZbVMy?=
 =?utf-8?B?R0tPT1JQV2U3TDhqcjAzdTdlZG9kL0FjcFZsT2VKYllzL3pwNzFEZ2JReHQ1?=
 =?utf-8?B?cG1mR2NoTlp6NjJwT2lkaUw4SExPellFcXUrRVE1K1c0OUZZY0Q3djdaNXFa?=
 =?utf-8?Q?eUX7ocxnPEWbx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(366013)(52116011)(376011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHZNaWtrOFdUdWpMTjJtVy80OFJIZ0Q5RThlNW1tVzEwUUQwYlRFQ2RYRmNX?=
 =?utf-8?B?OFExZDJ4Nyt2amoxRm9Yc1JiZWtXdWVjQ2ErQjRDYzhEY0V5cUYrMmU1dGsy?=
 =?utf-8?B?UkdwSk1MYTdrM2ZLT2RiMExhWnZmMXY1a25oSVIwL1pGeGVGd2RCRWw3NGUr?=
 =?utf-8?B?ckNtbm9KWTFidUx1ZmxOdFR1YUpkbVFKdXJPMTdMWHBDREJiUUc1S2VYbW1O?=
 =?utf-8?B?cEhBNnBZWElnZUgzQ3RTWWZyR1hxU3QvdUMxd3JVWUlHRXZ5eHNIeENPU21n?=
 =?utf-8?B?NmlTMTBWdGhjc1NWWFo0cHcvWXl5bGszaVBwSTV1SlF6dlZFM1JsS1RScUZ2?=
 =?utf-8?B?QnJFOGFHMkFqVGVXQ2NXUXdGUHR2bXBDeEVQRExyNThoQWFnTjd4NHpFM0I0?=
 =?utf-8?B?QlZ0OStUVmM3cHNXRlZRaUZLdEJ2M0hLVDZEWkdTeHEzZjRqMWpIOGk5eGts?=
 =?utf-8?B?RnVCZUJrcFRKRnJhNkNMWStNLzlNU0lPMGY0VWc3b2ZUNlpnejRqV01BMVlC?=
 =?utf-8?B?cldtTzlOTFRYRmdYV2N0WnNDbjhEdXZNbGV5Y2QrY2ozTnVkV2ozRXNQelpF?=
 =?utf-8?B?cXZ6dHlraXhLRkJTNEhiMDZpTzkydWVwSm51SzhUejFwV0RCRzVmQ0FlVmh5?=
 =?utf-8?B?U3NTQVlldDVYVzVsMkZ4cXhCNTYyZEJudWVNTzM3VkdpZ25hTS8wYUNKbzhr?=
 =?utf-8?B?L0Qvem1pbGk5UHV0MnI0eVE0S2RLTE4rcERXM3pqZDMzbjcybk1ydjRuejkz?=
 =?utf-8?B?aXczd3hqanJKc04wMXNzRjJjK1FwLzJvMkxxbWR5MnY4THFNWlNyRUJhbzhB?=
 =?utf-8?B?S3NJc2ppcVpYeFNJeGg5NVJVRUxNUFh0TE1FREdXYWZIbnpLUDFRQTBxeDha?=
 =?utf-8?B?UVJFUUZhZ0NORmROYVJFcy9pZXhnbkphcDB1ayt1dDNVc2VaR042MTFTQm9E?=
 =?utf-8?B?Ulp0amNPYkVBdDQrUWt1UXlpSkxoeGQwV0FDTzRqQlhYQTZhemhUYWJYb1RT?=
 =?utf-8?B?MVVVcHE0c1RoUXVKblBZaUUwZW5BelM0TDdpVlRBRmtrTGo3K0tUbFppOGRs?=
 =?utf-8?B?KzZRaUluU3hCWjJjNk9DR05pQ3RqQ3NzcThjdWRHc3F4ZFUzbGdTRlQ0UUEw?=
 =?utf-8?B?ZXdTaVluZmw4OVJTNWVleXJoR2lKNjZucFFoV2tKc0hNTFpHV1Mzd0FHZjVs?=
 =?utf-8?B?czlrTkdCaUlVSEtteG1GaVFpT25vODdIN2x4WTZQdkRsSHJ3RUN4Y1JvUklt?=
 =?utf-8?B?Y0luU0lNa3p3Z3ovOFZxWHEvRFRPZGFOc2kwNUlGeUdlTVFabXU3eGZnOFRh?=
 =?utf-8?B?ZmpLSDkrM2drYXJqN0ZBVjdpYjN0OFJQcWRRd2tBNXpXWit1K3BKaFl2QWM2?=
 =?utf-8?B?cTllRkphZHYyUnZvbkVkZFpmK2M2MjZpdVFxV3d4MnU4MXBmcTJWVUo4cmFq?=
 =?utf-8?B?MTRicldtM3BTUW85c2s1MjU2QUo0N2VwcE5mM3VxTi9pWFFIWUhobkRkL1o4?=
 =?utf-8?B?SE5aazBFVmJhNWRvMzg1NzJQcG1RQW1NSDBQU0JpSkhBNXYrdEVJTGR3T016?=
 =?utf-8?B?K01BVUQzc0VQQVU5SWhmRmVRUW83YkptblVLMmNYTU1Nb1B0MWhXVXlJdWM3?=
 =?utf-8?B?UzAvK1FkYWpoL2ZuT0FhTjU3Z0ZxaWhEcEVQaGJWR2tLeXFwUXdlWGpJTk4v?=
 =?utf-8?B?WGVKbGF2ZFZKYzJURDc1MXVGQzFuaTBjeG9rTGQ1aURrU0hyeGwvZzFzVDk5?=
 =?utf-8?B?TDNWZVE0akNTbE9pRzRsbU4xZGJBb2xEaThHNzZyMGlUcWJZS005YWxUa1hw?=
 =?utf-8?B?MUp6RlE1eG4wVitNU0tkVzdielZpQ1dRK2hSMWRPR3FaaVJFY3EyZm9jaHFN?=
 =?utf-8?B?dGJUSlk4L1c3UTRXa25FdEhNRC9lVTQ5QTJNK3RZb1FQTjIrM1F3dmxUaXZF?=
 =?utf-8?B?WkwwV0l6ekFOemlWOWM1L2FaWVQ3aUNodUxWdC8xclI2K09mc0l4WXFGSWZM?=
 =?utf-8?B?dTRqU1N3T3JJZFVZaEtKWlIvZDVzQlplMGtCa2hvMXhEWTNId2xXd0RlZjRl?=
 =?utf-8?B?b3RqV1FSTlo5VjdVMVFyNWY0YXpBVXcwVXY0eWtkcGJGNG9xMzUra2NOZXA3?=
 =?utf-8?Q?tb+onbn4JE8Bc3n5yltvqx+NJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe4658e-535e-4143-b4c1-08dc9525b582
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 14:47:17.4197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0yMXxJQt31h8n/unDRmcfCWZr0fEMs1FMcg0qKWe39HwhxlVROZq/E1AlK9rPBFhwLJrutgiuY2lw4cQAFEaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

On Mon, Jun 17, 2024 at 04:16:36PM -0400, Frank Li wrote:
> Fixed 8mp EP mode problem.
> 
> imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid
> confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to
> pci-imx.c to avoid confuse.
> 
> Using callback to reduce switch case for core reset and refclk.
> 
> Add iMX8QXP and iMX8QM support. PHY driver ref:
> https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?h=next&id=82c56b6dd24fcdf811f2b47b72e5585c8a79b685
> 
> Base on linux 6.10-rc1

Krzysztof Wilczyński and mani:

	Do you have chance to check these patch? I removed imx95 Lut patch,
which need more time to discussion. 
	At least first 2 fix patch is important, which fix some function
issue.

Frank Li

> 
> To: Richard Zhu <hongxing.zhu@nxp.com>
> To: Lucas Stach <l.stach@pengutronix.de>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Krzysztof Wilczyński <kw@linux.com>
> To: Rob Herring <robh@kernel.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: NXP Linux Team <linux-imx@nxp.com>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Changes in v6:
> - Base on Linux 6.10-rc1 by Bjorn's required.
> - Remove imx95 LUT patch because it need more time to work out the
> solution. This patch add 8qxp and 8qm and support and some bug fixes.
> - Link to v5: https://lore.kernel.org/r/20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com
> 
> Changes in v5:
> - Rebase to linux-pci next. fix conflict with gpiod change
> - Add rob and cornor's review tag
> - Link to v4: https://lore.kernel.org/r/20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com
> 
> Changes in v4:
> - Improve comment message for patch 1 and 2.
> - Rework commit message for patch 3 and add mani's review tag
> - Remove file rename patch and update maintainer patch
> - [PATCH v3 06/11] PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
> 	remove extra space.
> 	keep original comments format (wrap at 80 column width)
> 	update error message "'Failed to enable PCIe REFCLK'"
> - PATCH v3 07/11] PCI: imx: Simplify switch-case logic by involve core_reset callback
> 	keep exact the logic as original code
> - Add patch to update comment about workaround ERR010728
> - Add patch about help function imx_pcie_match_device()
> - Using bus device notify to update LUT information for imx95 to avoid
> parse iommu-map and msi-map in driver code.  Bus notify will better and
> only update lut when device added.
> - split patch call PHY interface function.
> - Improve commit message for imx8q. remove local-address dts proptery. and
> use standard "range" to convert cpu address to bus address.
> - Check entry in cpu_fix function is too late. Check it at probe
> - Link to v3: https://lore.kernel.org/r/20240402-pci2_upstream-v3-0-803414bdb430@nxp.com
> 
> Changes in v3:
> - Add an EP fixed patch
>   PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
>   PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
> - Add 8qxp rc support
> dt-bing yaml pass binding check
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx6q-pcie.yaml
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dtb
> 
> - Link to v2: https://lore.kernel.org/r/20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com
> 
> Changes in v2:
> - remove file to 'pcie-imx.c'
> - keep CONFIG unchange.
> - Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com
> 
> ---
> Frank Li (6):
>       PCI: imx6: Rename imx6_* with imx_*
>       PCI: imx6: Introduce SoC specific callbacks for controlling REFCLK
>       PCI: imx6: Simplify switch-case logic by involve core_reset callback
>       PCI: imx6: Improve comment for workaround ERR010728
>       PCI: imx6: Consolidate redundant if-checks
>       PCI: imx6: Call: Common PHY API to set mode, speed, and submode
> 
> Richard Zhu (4):
>       PCI: imx6: Fix establish link failure in EP mode for iMX8MM and iMX8MP
>       PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI
>       dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
>       PCI: imx6: Add i.MX8Q PCIe root complex (RC) support
> 
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   16 +
>  drivers/pci/controller/dwc/pci-imx6.c              | 1004 +++++++++++---------
>  2 files changed, 551 insertions(+), 469 deletions(-)
> ---
> base-commit: d9b6deec8e0a49b3ade6559b68c6a77ded0f4a8d
> change-id: 20240227-pci2_upstream-0cdd19a15163
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 

