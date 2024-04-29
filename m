Return-Path: <bpf+bounces-28101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D790F8B5BFE
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074871C21EBC
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D278060A;
	Mon, 29 Apr 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h+bE41xu"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A74D745C5;
	Mon, 29 Apr 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402419; cv=fail; b=IenmHkjiuVVcjrVqug1GN3kVUvIhHeSX492qRNIej4FQThHzwkDy5LrYPCjg5u63JXk6NLP9eZj55EC2SB8seh0+V9VN/DMNrfk4Ar5g4DhuOE0eId6rrdOOprItkart4tt/UdDi7uQYC6/Maw7xhkPCrkOPpb5iRcgH2GPbMUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402419; c=relaxed/simple;
	bh=6iwZtktwNi5GwAUHukB6UGOGaFML4ql5Jn9IqpwDfSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yz8ZN0SZLD/v2LIOLrgVUK5c9QlHJyrsKXJuZlckFZm0PlducJUhIF4WgUUuBg5NfqaQApH35oZyTy+jIe8f9brwBkpmasHb9imUHL0ZyMRyPPPy9VoX6+Gfbbo2bVqcFeaKm3HMPICqSDUkNaTzdLCC1wnd26AB+RwQOqX2BJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=h+bE41xu; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlMIufFbyJWb75jWtZNXEtBK2sAvM4yvtSWmHL+axlBVbqdkY2VxR5eveCDpn8S3l5XRp7M4GvyXlRrgJAfnuwJVyceEB+8wvapHlnnDGhtWt3gR9emdXliuAOl6ct9IazahFyJN0XVlbgDCwO1bgSXGRml7m4cWLFUGvcyCU9LUuckL5q8OWfzxWPbfg9i7mMpQQNOceYM5GcK67qFgsCLy7Vv1hU5pBAGY4ZYxV6ObHOuXOI4fU0ifYsjBHyiyww6Cu+JdwB300ScYfe1ibjw18lckbFz/6O/M6Y276Kgdi35cXs0GGZAqUMvubL6lmfNB1ML6hV6KjnSV4AYZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTv3s8R4gGV8eA5SgAMN9mmpzdrZxMMikCAiNKuSIiY=;
 b=mK7EoDN4yTsoQZL32TCKlF8tv40Urj/qz1B64+kBRZc9WziQ7XIJUpygrCqidzj5rZKMPJ82jgY9x5LbgIKJ3ulgqigRXFNkCTvfBsm32MDemZBhnbNWNW/Ij9qpZjLEpTANwYTkxFbtWAc/a9n9OgWO6CsfBcAusO8XubkjzSYELIJCcwJWk52u045JCHInfHgTSMhwi4FZByFcMzfagyUtb/PecN8A8qiv9t5YEzVzEBj2GJTZt5V/9VeUfZpl+OPbyu1e0UyZo8B+l3qFa2ZW6ODFdiRKvW9hu1vnPT/Q8iV9KsqeDe9TcR+IHeEJ9OHFZW2wkrOfV1gZOvEc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTv3s8R4gGV8eA5SgAMN9mmpzdrZxMMikCAiNKuSIiY=;
 b=h+bE41xuIIa0YQS4fUp/QzogNXOM4ZNTt/ixikHTTg9BGKyv33m+DLkh4+mA16FscbNwbHI+6HhvmIUlpwHkpbE7NfEd01ox0bhecAe1DYz7pYxG+86n2tnwYRgTVvAWLoLhYaxkNjbZX4z/XIIw2ybjJ9ZvrTp62zg50ZRe8h4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7108.eurprd04.prod.outlook.com (2603:10a6:208:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:53:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:53:34 +0000
Date: Mon, 29 Apr 2024 10:53:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/11] PCI: imx6: Fix PCIe link down when i.MX8MM and
 i.MX8MP PCIe is EP mode
Message-ID: <Zi+0Y+BhPqIw7PeL@lizhi-Precision-Tower-5810>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-1-803414bdb430@nxp.com>
 <20240427090057.GF1981@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240427090057.GF1981@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0117.namprd05.prod.outlook.com
 (2603:10b6:a03:334::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: d94fe8eb-7e04-4f42-4d11-08dc685c24b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2lLS3M4RDZCZkFhRVJIVFNTZlBqa01qOGlEa2RFYVZWU014SGtHejEzZldW?=
 =?utf-8?B?anBncHBuUy9YQlIvVTU4SzVTMEFQcUwwT3pnTGZoeFVsNzZRSUFGVnNMSUR3?=
 =?utf-8?B?eDRiazF3M0F6Z1Z5SXViVVlMdzlzbldHYTNTSVdMWXBRMk5ySHlqek9kanQ1?=
 =?utf-8?B?a3NSelNUVGNRV0VjZGlnajVHWnA2c2tkSHcrbVI2NmYrb3lhWTdabDQ4Skgy?=
 =?utf-8?B?YlhsSjVDNVRmU3lLNlRWOXhBcEUwbkFSRnZUMFkrb01BenRpM2Zrak01aCtj?=
 =?utf-8?B?UVMrQlNTbjdtaElHRXVHNEpJRkxRWnIrYjJiUm5BR2hDeGNpYXUvUnlNUGRN?=
 =?utf-8?B?SmdQaFBZNHR3bndiSk5tZDZsRXFwd2VNQm5Na2t6V0xFSU05ajAzRlRJUGxq?=
 =?utf-8?B?MjNkZ1BjMVZEa0drL2cxbTM5dG90ckZMYnF5Mm5XWmJMMiszRXpBN2lUS0tX?=
 =?utf-8?B?c3BvaXdzMEpQUWgwMGNuWThVM3A0WWFZSEowL3N4aUNDNko3MEwrQkQveE9U?=
 =?utf-8?B?SGdVUEtuby9lcmpHVDVNYWZzWEhyWXl1c1ZwVjEvMTJmekZqVUpBc29SdTN1?=
 =?utf-8?B?eVNzbWppZ3NveXVsYUt5UWtpWWxXc213ZnN0eWVOTk80aTdRVU9wMzJuWVIw?=
 =?utf-8?B?bjRBeFNlRklxRFgzZ1k1VE15QjZxajN4bi9VRXhWb0o2QlFwZjlSZTNtWW1G?=
 =?utf-8?B?czNsQTFyYkJySWs5RGxzRXkrS2MxTW5qeHYvNTJpTHJjdTkxWE1JSWRPSkhK?=
 =?utf-8?B?cTNSOGdaM21qVVpDeFJLOWJlckJ3cEI0b3RFalQ4ZmlVL3htcWtaTy8xbzVY?=
 =?utf-8?B?b3MxOWhDVjhTTlRtOXRXMUk5bWs5QnRTZThESDFKcjNIaWwxOXdRbDZENm5i?=
 =?utf-8?B?SC8weEc1T09VdHdBSWxPLzlJbVhpd084THNQelpXWDFQSVYxcDhOZTluclNu?=
 =?utf-8?B?eS9TbFpNeDBJTjZPK1BZdnBpK3NmUDFSWGV6ajJqSlBCcVVmQ3BEU2N3MzlO?=
 =?utf-8?B?YVZxc0VGbDFRbFgwdzNjWnovRm1nalJGRDRZY3NvbS90MEFGNEJwekJJSmJa?=
 =?utf-8?B?ZkcrUlI4Skh3WlR3U0dGNEtlaEEzT0hZRFlrVFBrRHcvUVBsTS82RVlHNlEw?=
 =?utf-8?B?OFY4RmFYTFFGRXZORmdYSUR6QXJhTHBueVl2WWJ5RnBuTlhSbDVkL0NlTDV5?=
 =?utf-8?B?bW9Va2tCTFlDcENNN3BYTU9Fb2ExOVZLb085M1ZsUzF1RjBUSk44ejFjdUdy?=
 =?utf-8?B?NjZOZ21BeG12dkZFOHRaY2NiTzc5RE85Y2VpV1c2S0FOckNQZTh2cWs3bDFs?=
 =?utf-8?B?bWl0a01tYTlsZkdXYUx0bms3UzVvUWhCVXUzbXBGazFoNEY4K284UXh0eTNz?=
 =?utf-8?B?ZmJQQ2RJWFF4RElRZE9OTWtXVHFvK3U4aVh2RXBNU3Y1dE5vNWFwU2NVZFVw?=
 =?utf-8?B?Z21QdGcxU2VibElIY0FOZU5HRHNDNGVaS1RxdVhNaElTaUhBc0pNeFRjeGZX?=
 =?utf-8?B?TXdnNDE3MWdWWWt6R0c2UEVPNmNyM3c3dTlTM2hBTkNmMmhieU8xNWtPMElX?=
 =?utf-8?B?TTZ0M1k5Wjd0UzMzYUUrTE1Fc21lNHFGNm1lbDlDMHBGQkFhMWw4dmxJT1VR?=
 =?utf-8?B?d0JEK3d4ZzliU21EL29oZFNRbUYwU0JWdDBlUld1VHduWnhveWkwN3p3SkVF?=
 =?utf-8?B?aS8vK1Z4TjZkUWJCTm9ON2lTdFJVb0FwcGZpREtlWXRnODNqK3ZqRG5ZK0Vl?=
 =?utf-8?B?NWt3TWJ0ZnFQUm9UbUxvS3NtMlozekw2TmtFUHVrVC91eUduY3ZIRlRnYnZV?=
 =?utf-8?B?WXU0R25BaGQ5VU85NXBRQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWUwVEQ1VjhCVVNpeWRidmIzdUEzUmp4ZlBrYnBWdkRXQVY5ZVZDWGIxZ1Ns?=
 =?utf-8?B?cnFZV1hxN3NzQVNDZUhzaG5qajQ2TXZ3Z0ZDcUlFUDNxSTU1MGNVTFBLc2xo?=
 =?utf-8?B?M2JTdU1hL0tpbkFvWTYrZmoyUmpaOUVGVjEzelJYVUNmRUlaeG9aTTFacHZV?=
 =?utf-8?B?QTBIREtQTit2YUtUNjZxQ0dnamV5Nmd3RVF2VEI4dHhhRFNPcjdNeG9lcS9z?=
 =?utf-8?B?b2lRUkpkVDlQRWxBUDg3R3lKL0lQYnFDVDhLa05CR2RjZ29kcUwzZ1dNU3Ri?=
 =?utf-8?B?SFFRSHNKSFFCQTdvZHhacitEVGo0N3BWemxadThpT0pDcWFYMGZVbUx3VTJH?=
 =?utf-8?B?TkRuMm1NS1VwM1dYL1BtWjg0V0ltWlVvT2tYOTVteW12WHFETkZkSHVPUkxx?=
 =?utf-8?B?akFFdDExVCtiVnRtTXhXU1ZuanE3WHI3NjBrbE5FWllSTHBMNWN1TkU5WWsz?=
 =?utf-8?B?NjM3MGo2RE1BdnhWbUVydVcwcnlYdFoyM0NRbDlaTUhIcVM0bXBsQWN1RFg1?=
 =?utf-8?B?WEd1aWpwdmVTZFA2QVZ4SThsV2syZ2dBb0IxMllsUDVONWFaZGtKMmpQbEp3?=
 =?utf-8?B?N0duVUp4ZTl4WElhaXdRd0RpN2h1ZnhlM2dMYmtHeTN4Ukp1U21QZnNITDZH?=
 =?utf-8?B?TXNLbXJnOGFyUTE4K3podkc2eWVYOWRncmsrZ0QzSzA1SGpnYXMwY1RueDdY?=
 =?utf-8?B?cllhQUFRRGFLNUgyR0pVR2RQbFNzSXlJNjdScVdZN3EyeVUvUDU5NFZLMGcy?=
 =?utf-8?B?WUh0aDl4bWl1M255UE1iQ0JzSi9kOHg5b2hacHNKdEgwMWZ5V3JoTjhCd01r?=
 =?utf-8?B?R2pJa1dYQmRvQ3JtdmNDRDZVOFVpOGk2NGtLdmFWRzJPbjEydStUbVlUQVRP?=
 =?utf-8?B?RVVvbHRuUFByTzFRdHVQMmJzNEJXYkFoOTZ3ak1pS3M0Vk96L3d2bGJjQVp3?=
 =?utf-8?B?T0JRMFVpYzJkRU5aNmNOMHpHYmtWTXVBWVZ2b1lOMGttVzdCekpwL3grcEU4?=
 =?utf-8?B?ZmQyK3ZodEpIeVJFRWhzOEZkUUk4eTArUTBVRGkrbXpFdlhjazZ0Z2RUZkZa?=
 =?utf-8?B?T2craWwrbjhBTjc1WUFuOVNSVmNLa0FpMHlicUl1elptdnA5N2wvcUY0elZx?=
 =?utf-8?B?NGdiTDRoZUZ2SGd6Q2xwSFQ0WE1IZVNEVG5OWG5GajVPbWM4bUtxVm1uQXBZ?=
 =?utf-8?B?MllMcHVIUnFtVTFMaGNrdkxlZjFLeHJvSXVBeHBWWGlQSjJoL3A1cVdVbFlM?=
 =?utf-8?B?MU5VdmQvOW9ZUDdUL2M3aFA0STJIcDVGUnF2N3YxU2dOTWZhWjRVdEZoRmdE?=
 =?utf-8?B?czRmbmlsMk1oMTJpcWx1d0dkRzl5YXdSTGlKQXpHWS9HWFc0ZlIvUDJuNEkw?=
 =?utf-8?B?ei9IZ1lLallhYTNnbHc2WXdjQ2VyUEpTTW1ZdXVWS3gxNjczbDNyRkxrR2x3?=
 =?utf-8?B?NW52K0dYQy9IYnpXNVRHTTBpMUdpeTNKYWdOMlppTWR2WlFwRDJESktuaXR5?=
 =?utf-8?B?WFQ3RFJ5T1RSak9ZWDdrZ3NiYkRSNk5oTjNBWnh1ejNZNXE3ZTFQZks2YnZR?=
 =?utf-8?B?NXBNeUlMZU1tUXIyU3ZuNWxwTDFpYjlOaU9YV2NscG5JdThtRS9DbXBPS3kx?=
 =?utf-8?B?SWdYWDBpN2p6SmF5NDBMdmJRUngvRVI3T0xzcEJDWm5neGd5K3RHS3hpK0V1?=
 =?utf-8?B?eEtBRHFOanMzbThGTWJoWVBiN1JBMmlxWHhkd1hFN0dsS1BvaXA0L1ZFTjlG?=
 =?utf-8?B?SC9pT3hudE96MitOVnVGYTdJUE50MFM5WE9GRjNDUG9IN1BBU2RickxVTXJM?=
 =?utf-8?B?UnBkeTNmMnd0RjNMSjA4cnlmOERiejlkbXdUeElSTzVYaERvcnE5bmh1cXBw?=
 =?utf-8?B?Vm1xRzc2aGs2YTBzeEh3dUVqUWRYdndyV20vcnRudTRFUHloVDZicFdXTld6?=
 =?utf-8?B?UUtoTW9DK1pmSnpVeU9lTkR2U1RYS084Umg1V29GVGlId09kZWtDcGsxV2xy?=
 =?utf-8?B?bXFTRWhGWW1EL2x6dHIzaVc0akRiZmtiNnphQ0k4WkdnUFRvV2diVGk1dWlT?=
 =?utf-8?B?b1Z0dHk4SEhra09yZkI3T1U3VUNYYW1EcUhBS1JOS1NqT3pYcjl6ZDB5dEJx?=
 =?utf-8?Q?vsRaHbfvFQ2titywgzAIx+L9F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94fe8eb-7e04-4f42-4d11-08dc685c24b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:53:34.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6AmzYPD2r8cFd7e+7tPXYqH3rIAAsi8nucNZlbCQtU3Bus8Kw6Ua+dGyo+MkFKvlppLMviVQBhfkvU3DbqN7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7108

On Sat, Apr 27, 2024 at 02:30:57PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 02, 2024 at 10:33:37AM -0400, Frank Li wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> > 
> > Both IMX8MM_EP and IMX8MP_EP have the "IMX6_PCIE_FLAG_HAS_APP_RESET"
> > set indeed. Otherwise, the LTSSM_EN bit wouldn't be asserted anymore.
> > That's the root cause that PCIe link is down when i.MX8MM and i.MX8MP
> > PCIe are in the EP mode.
> > 
> 
> This commit message is difficult to understand. I think the issue you are fixing
> is that these 2 SoCs do not control the 'apps_reset', due to which the LTSSM
> state is not configured properly.
> 
> Referring Link Down is confusing at its best. Is the link training happens first
> of all?

Commit message is not good enough, how about change to below one

PCI: imx6: Fix iMX8MM and iMX8MP's EP mode failing to establish link

Add IMX6_PCIE_FLAG_HAS_APP_RESET flag to IMX8MM_EP and IMX8MP_EP drvdata.
This was missed during code restructuring. The app-reset from System Reset
Controller needs to be released before starting LTSSM.

Frank

> 
> - Mani
> 
> > Fixes: 0c9651c21f2a ("PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET")
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 99a60270b26cd..e43eda6b33ca7 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1568,7 +1568,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX8MM_EP] = {
> >  		.variant = IMX8MM_EP,
> > -		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
> > +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> > +			 IMX6_PCIE_FLAG_HAS_PHYDRV,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> >  		.clk_names = imx8mm_clks,
> > @@ -1579,7 +1580,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  	},
> >  	[IMX8MP_EP] = {
> >  		.variant = IMX8MP_EP,
> > -		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
> > +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> > +			 IMX6_PCIE_FLAG_HAS_PHYDRV,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> >  		.clk_names = imx8mm_clks,
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

