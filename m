Return-Path: <bpf+bounces-46038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBCE9E2FDA
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 00:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924E6B29A0E
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 23:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8B020A5E8;
	Tue,  3 Dec 2024 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HixhssCB"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB87E0E8;
	Tue,  3 Dec 2024 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268457; cv=fail; b=a3inean9EpZ0kKJJlqlKXQgs8SChJz0nhUiKejmtggKHC0Qx4rghuPLtM5mLV+WuIcKoHQ7WjbERLQ55YF04I3nV9gnPc6xvyfndw2lT+ejx260A5IKFKNnJQ+YNNXwS02xxXEBBxZ4kjVTyi11B9KypZqupXz9Lh4Uj3ZYZQUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268457; c=relaxed/simple;
	bh=shOHe7cmTF1H6vKadfS0HmYw8AgCeZm86jLE6+lRuW0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=eMLY0mB7IaSNO1bsVbYNoZ4dRGGG16A8GCPXdFX7SQ/8KKAVDqntqt3JDU1R2yqeINlupcAj3+1SaviWwyGJrlhkX/hOoZl89G7vj3oPPFKIDjImVNBxwurZNXor4fKsebkZ2yC9zsxRU2ifL0DTLeB4meZoTrPKPEoJZpwNc2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HixhssCB; arc=fail smtp.client-ip=40.107.105.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2G3EpSTQzknsTXms4LBl9O7O/qDSRlFI2htdn/HxkhWr7MhhUeYTizRG8JIBOTR2ezM+hQf2/dOc2Ux6xA2rWPcJ9X9pwW12y74rryxWwvoZG+0/3ZEamhb2L1MkMD8oLzXG/s+vY8ujqcALLdHnVpGK6BifVhbHW8VJoXk27nCrzCj6q8qDVTKeOO9+q2ADfBN6gEEJJTqnVYjVw5QqbeKpMUmOw6Je87A4sWcusDnvPnZO60GVQmZAEmmk3T0GMMZZvF6JeAfOJXr+XLomDCtLB3FxNkB57c5WwPAtMDOGfBVkVN1ZDkkxfbEHI5IJ7o6YNqv2OAv/JAyegmXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOTTAJFcSrB46TDyuVyN4UfDPuhoFiUbIOqMeTRxmxo=;
 b=UAs+tngQz2qIZr/5wTZmS4Mt/QnNzRUawalX+vb9OXtM6oT9QPTyOM+3h0z5JzKTJ2zJ+qXs51wlSouBU3bPtKpQryx7xe/K0xrH2yJsOoG/HI4j0yeUIiDqjEc5X/NPopLFLZCPXp/SStRTKre+hqscgkudfaxk1xYw9FL9z5AGSxfu+3VIXF8Ie+MM0lnNtas95Ils+7Tss3yeOna7UoyG7qtOqvBbMc9gSj7D8I2NN2UbAoS9MOzj7PHzoRnSoWLXhrtZHOB+0fk4kz3SADfwdRrhNC9INC1sogpno6a8cSHXFOOg88kOIgpUAh6Rgc/JnE0R+y/251hXSmrOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOTTAJFcSrB46TDyuVyN4UfDPuhoFiUbIOqMeTRxmxo=;
 b=HixhssCBsRcH/Lhxa+etzZfBtdk4PRw4PFOZJ65UOJ4v2GwDDdmJQyQVFyNpyEe/tbiAFSDG+ZqeAEoypYuETY+LCxgiK1grBwp2pjnS8RSv8JljpJ8AMUVDxPcC+CMZt+HlVSbT1Pa9HRrThI2u+OiVHmST5oLsyOUDk6CaqKEyomD585c5PE/xWzPBfFsx1tvGdX72g2D5Gk+qAO+wd6P4vCovNxkRbCCvF0WLgXDwIJ+YHX0lXXCBJjQKdFxirSA5lOced3iDwd8ugwqijDHe3qYVqvNznv2fGa8h38eYh1Z5LEooYRLE4xbBCoO9DZ7oC9XIikQc6iOyG8z1jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8846.eurprd04.prod.outlook.com (2603:10a6:102:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 23:27:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:27:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 0/2] PCI: add enabe(disable)_device() hook for bridge
Date: Tue, 03 Dec 2024 18:27:14 -0500
Message-Id: <20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANKTT2cC/23PTWrDMBAF4KsErasyM/qzsuo9SiiSLTWCxg52Y
 lyC795JFo1cupjFG/S9QTcxpbGkSex3NzGmuUxl6Dm4l51oj6H/TLJ0nAUBafBkZTkt3nx8XS8
 SW9sQUQKvteD35zHlsjy63g+cj2W6DOP3o3rG+/a/lhklyA5aS9C4Lob41i/n13Y4iXvHTJVTU
 Dtip6LV1sVglA9bp34d8tROsXMGfOsjX2vs1umnQ8DaaXaQu+wD5eSM3jpTu809wy6n6B1llVH
 9+Z+tHDa1s+wCeYMxoFLaPd26rj/p/6NTuAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733268445; l=4531;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=shOHe7cmTF1H6vKadfS0HmYw8AgCeZm86jLE6+lRuW0=;
 b=x67FwKFG1Dh5ZuuWUNWjgoFPP69OcwvtOXTdLB9D2WDL0GVZM6Ek/SHWjDVWaN8Jo+xiua2MN
 BrzU7O+8RnBC513OalS+4B09KkXTsftem8gAeiC00FSYHtgpUmyZ5KZ
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
X-MS-Office365-Filtering-Correlation-Id: 851c7ae7-e270-4395-e6e7-08dd13f20f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3hkWGw2VnZNNlRlNVBIQ2YvbWgvT3oydnY2aTJSMGo4ejN2RlkwNE42aytS?=
 =?utf-8?B?NGcrTFdVMDNZQ01zd0tYc2ozd2lJeldQSVloam9TdmtKang4TnVKWDh6ajlS?=
 =?utf-8?B?VjQ3SlpVT25XM1RTb29rL2JWcWQwL3E1NDFIUVdUUE9LejRFbE9mK1BZT3ov?=
 =?utf-8?B?KzhFLzBuUzZKUlJ2SmVlUmY4dUdIQUhEWmlhRFd0SVlTTFpSTG4vSmRaQkxG?=
 =?utf-8?B?NXdqUk5ENGwyS05WMFpUY25QbUtBTytTQjhBM0xJSU9BLzI5Wnp3dmZsN3BN?=
 =?utf-8?B?U09pb09sVmxtUUhMd1ArVS9Tdmxsa2Joc0JDaUJjUXZuSVEyTlVWZnFjYWdp?=
 =?utf-8?B?eS9CdzZ1ZktKbnpFRDNhVlN3dnM3b1NIUGkxNGNyVzRaRytXaVJmRUo5UUtk?=
 =?utf-8?B?UFFtSURCZzNiZXc2WGQwLzNTNjdKRDYrVCtpdkhEWEg2SGRxdCtmcnd0VDdh?=
 =?utf-8?B?cXBuT2U0WHFLUXpaVUhhRXJFbnYwdWdZTFIvUlZENTZCdks3czk0WDJFT0lR?=
 =?utf-8?B?NkUreWt2cFJQY2tBUmdoWU44STVTMThSVFhBaTZCblVVM053ejFlcmN3WXhK?=
 =?utf-8?B?RGZPaG9hcmJZeVc0VTI4ZERwKy9Na2pGU2JMYjQxYTUwUDZVM0JOaWw5eERM?=
 =?utf-8?B?MVNPUDVWRVQ2SnBhckR3VitVNjBkbXpQSkI5L0lLRGRoVEF2VEo5MXUxRHZW?=
 =?utf-8?B?M0xNQVY2ZG5ObkNDWHZtUWlmZlNyd0xubTR1VEg0UzIzeURQK3YzYWRpWDl1?=
 =?utf-8?B?VjAvOWVZZ3c2YXRGdy9CZWhUWWtCY0V3VVJSMVFSZCsxUHFyTkRRamt4WXNm?=
 =?utf-8?B?VUFmLy9YZHlYdEJHSSt0UjdHQzNsNTVuWmZTV1ZVa3p1TGVsL2R2TDlKdnRT?=
 =?utf-8?B?c2I0R1hGR0JnUzlYZDY4TjgxUmJCMm5aUlZQNms4NnhpeVpnY0hDeDJwa3du?=
 =?utf-8?B?ekdtMGszR3VWVVZZa1FJYkd1VU1RaGF6VGUzVkc2OVdFRzBBV0g1THg1aWgy?=
 =?utf-8?B?TzFoVHRzeXpEY3pSYVB0ODcrK1ozZlVoV0x4TTNYWCtqTlliMy9PMnpPVEF2?=
 =?utf-8?B?Q2VPNDZRaXRleElEQ0tuZi9YdDlWRnBySnY5Z0hFZGk0eVAwUkttbjBBd0ty?=
 =?utf-8?B?Z2JiOFNIS0UxZitCeWdpQWVpczB6bXljTVZwaGVyMmhaWG43K0UxVlNkTlJD?=
 =?utf-8?B?VklOU2Nvb0NMOTBMVklSK2U0SFZDL0l1RmY2YUg1NXRVbFF6VzNJbkgxNHdh?=
 =?utf-8?B?RkhwTkx2Vit5ZkJXbVVEcityc2ptVDY2cEZFL3owNzg2V3hLTlBENSswL3Bx?=
 =?utf-8?B?bjBkbTNPYTBuZDJ6SzlpcTVlSWV3VzNrZEZLenlPN0JHb0xUbkQ1MHB0eEVC?=
 =?utf-8?B?bXdERVZzaEZxQ2d6WWtQNTF4OXhTVVlEVXR2bXBFNEVraUJjLzFVZUV3Z2l1?=
 =?utf-8?B?b3NuTkdRa2xxTGJtNld5OHppRWNVZGVKVmRmSmNiZXdRS2pzRmdsTUhCK1Nt?=
 =?utf-8?B?RXgwVUVpL3dHK1dWVytNZmYwa1U5RlQzVzJqV3ROTnluTENNOVJDWGNYdDh0?=
 =?utf-8?B?Q0l1S2ozVktDcmVRVTJlYlpvbUo4QTlRQk1aY29lM1IwWC94Tm9WbnB3ZkNt?=
 =?utf-8?B?YUlpRzdjUURGdDB1MGQ3MlQ0SWVZbkEyc1REL01rOS9LZk1kWngvZFZvWkRs?=
 =?utf-8?B?YkxpRzJ5aHN4LytOYzNwa2taUW5HN3NiQ25oVTAxcXBNOHBhK1I1UXl4bTRw?=
 =?utf-8?B?NnQ3M3Z3STQzY3duUG1iRmtpbk9pdFBwVWtIS1dyNEZkNnQzUWlybWwrTW1N?=
 =?utf-8?B?VGo0Q2ZCK2lIbmpxWHNjUHdndy9VS2pTWDZUN2FmWm9NdWt5OUJnelpIeG1M?=
 =?utf-8?B?WlhjaFlqdVBUSURhaTlpMWZBZ3hjc2QyYTlHdU5DV3NtSGl0TlIrZ3dwN3pL?=
 =?utf-8?Q?CgdJctsomgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjJkaVhNdjhvNGVGRmpQUDUxNGlCK3IwS3NMT1lrYWx6TyswRlQvUm5tYU95?=
 =?utf-8?B?cEN6ZThKNVJsQTlQTEJTZGpEUXZoWUc1cVh1SmMzUDFkTDRIaUNpeXB0a1Vq?=
 =?utf-8?B?blRNMWlBamdvWEdvYmlDQmxKOXMyRVFseVJGMnVhOHdqQzU0Z2NJb2xiNUha?=
 =?utf-8?B?N2ltajVQN1kzMjh4eUpwOUlSNjcyZjJVMHg5b3FHbzMwOUQ1Q0JGaGN5U1B3?=
 =?utf-8?B?dE5Wb3hXYkM3Nk81czY5T2N4cStaODJhYll5R3k3WE50UFpoVENSQVBSZE9G?=
 =?utf-8?B?cld5ay93cWxlbkVUVVJ1UlQ2QTlLTmVJZm1OSUwvVnYzT0hmL0o2alR5YWJJ?=
 =?utf-8?B?bEpSNC8xU3JYT3VscDNtL2wyWU4vbW82TUJTR2lwSytmR0htVENtVy9iRmMz?=
 =?utf-8?B?MFJZK0dPS0d6azB0NEx5UzBWQUZvZFlFNi9KS0ZkQ2ZuN3owM0lSdjlydkVY?=
 =?utf-8?B?dXZ5c3UyV3RIeFBrVDBjLzhnOFdBSkF3S2dsK3l3dTh4RUlqMzB2c2k4S1RW?=
 =?utf-8?B?bFh6czU5ZWQxVzlzSE0wcU5LNWdqK0VlOXJYN2ZrSXZqSlVDS2liOXdMeTFn?=
 =?utf-8?B?emRlaC9yOWN5K3Q3NktIdnJpNThuUStqQXlFaUpUcWtaUGEyeGN6dkZRbVJ6?=
 =?utf-8?B?Q0pvU2dvZWdTYnBlNXpJVUlCK3dtTGdMeCt2cEZDRWJUSlUwR1ZOYm5OeU16?=
 =?utf-8?B?Tk10UkwvUFBvWXBFSncwNFZNZjRNUXhSZ0hvUVZORFJlTkxkeXFCcmNhdWFz?=
 =?utf-8?B?M2RrSmltRjJsSWgyaDA1dFZhOGdlUmpDNnIzZVZhNXZWcUJpZEs1UGxjVnR6?=
 =?utf-8?B?Mkxha2x0bmVmMjB3bGw4UytoZ2hWZm83TmZpNlZiSG5VMVQzNnRwWjEwNjBU?=
 =?utf-8?B?d04velpTeHRjcVByTVBJWEtQcTlzdi96d0lFMGRHZmttTjh6bDIxRExWUHVS?=
 =?utf-8?B?OU5NMXdXM2IwOUR0cklodVBualRuWFB4b3pKbC8yWEYwdDhpYWRwQVNWV0M3?=
 =?utf-8?B?Umd3RXEvNWdQL0pSQXBHeXBMcFNNa2ZrZ09HYW5SR1N0VzArRHdBWVlrRjdm?=
 =?utf-8?B?TWYrWTh5QUZ4d1NpRGRyRXhEU1lMUHJMNnZTMHc2bHVWa0psN3JvQ0swd2x5?=
 =?utf-8?B?VDRRbmp1ekd1SWZJdmVGSTRkVWh2T0xJQy9IdjEzN3BlWlpmZktxRUZMS1Nh?=
 =?utf-8?B?dGY5ajNUUFVjMGJ2RW1EZDhJWFhhN0ZFRTJxbG9scElLNU81ak9wZEVVQmJ4?=
 =?utf-8?B?ellyWmdDUXNMSzhIR01pUDdBWGo3aUhSczczd2FXTEd4aUpVSlMvVVVpUjhj?=
 =?utf-8?B?d3pVMFhBNXZiUWhseVA2S1Y0aytzSzFQcTV0Q0o2TG9oVnpDOVBzWkZqRlB5?=
 =?utf-8?B?WmVGNzJUbzMzaGw1SzRjVVVBRTFrTWFyc1VLWFlwL3ZVZVpRSXc0MVNiRFVk?=
 =?utf-8?B?TkRZM3JqRDlMVG4zbHI4S2xPd2YxZnVhVEJNMGlDU3paMXl0WlphUktpeHhC?=
 =?utf-8?B?YXprQndhcmNMV1dOT3MzSzc4UndkQmhvMGFnanBxdkVSRnh1OWZWSmxqejNP?=
 =?utf-8?B?NU5qeDZBU2pSNStQdzdQblRpa2U1bjRaRmFFSWVSczBWKzkwcElVdHZWbHZM?=
 =?utf-8?B?UVFOL0RvWkxKYS9sazVmTmxyVm93UW9MUFFtK3hIVEZ2bEhYYno2cXdSOHg0?=
 =?utf-8?B?WTBDeGlyc1ZFbnp2MVFHdk9LRUV0REZObjVLNi9FV0dDNFg5SUtJQUlVaDRX?=
 =?utf-8?B?d3JERERwS3Z5SzZMYW5US0tDQkRuZ3F1STJIVVRGd1dZTFo4THphNXF3dDdn?=
 =?utf-8?B?bGFlQmR4L1ZQYlhVK295MlVRdlJBZlp0T05RM2dnZVpjcG5sYVE5eFB5MHF0?=
 =?utf-8?B?M0h4ZmdHRkYwejlBZkdxRG14blgyd3lBYXJuVHU4Q01pNFhLMDVIS3IzdW5I?=
 =?utf-8?B?OGNyMUdFOEFPck9CK3JGUzV6eGtaaDRWdHZjYlBLbVgwTlNHN2YxZjM0aFRs?=
 =?utf-8?B?K2M5WEh3NW5RRTNnendobU84Ulc3NkVWSXdlUHQwRkJRMnRUditkTW1RTU5I?=
 =?utf-8?B?YXRVUGlZV3d2SW9pUUt5VFRFSG1LQk9YbkVQTUZDODJUbEJVN2k1YWxISHVp?=
 =?utf-8?Q?/c8PeLLE9c/l7A2R0W2aceNem?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851c7ae7-e270-4395-e6e7-08dd13f20f27
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:27:31.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fk0qwZdx/eHn6vCHuzhAzkEO/5is+tYWmqQP43wyW4i/Bgd83kdoOh5BTDqA62qEQsZrv8p7utH9apwplUyEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8846

Some system's IOMMU stream(master) ID bits(such as 6bits) less than
pci_device_id (16bit). It needs add hardware configuration to enable
pci_device_id to stream ID convert.

https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
This ways use pcie bus notifier (like apple pci controller), when new PCIe
device added, bus notifier will call register specific callback to handle
look up table (LUT) configuration.

https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
table (qcom use this way). This way is rejected by DT maintainer Rob.

Above ways can resolve LUT take or stream id out of usage the problem. If
there are not enough stream id resource, not error return, EP hardware
still issue DMA to do transfer, which may transfer to wrong possition.

Add enable(disable)_device() hook for bridge can return error when not
enough resource, and PCI device can't enabled.

Basicallly this version can match Bjorn's requirement:
1: simple, because it is rare that there are no LUT resource.
2: EP driver probe failure when no LUT, but lspci can see such device.

[    2.164415] nvme nvme0: pci function 0000:01:00.0
[    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
[    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12

> lspci
0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)

To: Bjorn Helgaas <bhelgaas@google.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: Frank.li@nxp.com \
Cc: alyssa@rosenzweig.io \
Cc: bpf@vger.kernel.org \
Cc: broonie@kernel.org \
Cc: jgg@ziepe.ca \
Cc: joro@8bytes.org \
Cc: l.stach@pengutronix.de \
Cc: lgirdwood@gmail.com \
Cc: maz@kernel.org \
Cc: p.zabel@pengutronix.de \
Cc: robin.murphy@arm.com \
Cc: will@kernel.org \
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marc Zyngier <maz@kernel.org>

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7:
- Rebase v6.13-rc1
- Update patch 2 according to mani's feedback
- Link to v6: https://lore.kernel.org/r/20241118-imx95_lut-v6-0-a2951ba13347@nxp.com

Changes in v6:
- Bjorn give review tags at v4, but v5 have big change, drop Bjorn's review
tag.
- Add back Marc Zyngier't review and test tags
- Add mani's ack at first patch
- Mini change for patch 2 according to mani's feedback
- Link to v5: https://lore.kernel.org/r/20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com

Changes in v5:
- Add help function of pci_bridge_enable(disable)_device
- Because big change, removed Bjorn's review tags and have not
added
Marc Zyngier't review and test tags
- Fix pci-imx6.c according to Mani's feedback
- Link to v4: https://lore.kernel.org/r/20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com

Changes in v4:
- Add Bjorn Helgaas review tag for patch1
- check 'target' value for patch2
- detail see each patches
- Link to v3: https://lore.kernel.org/r/20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com

Changes in v3:
- disable_device when error happen
- use target for of_map_id
- Check if rid already in lut table when enable deviced
- Link to v2: https://lore.kernel.org/r/20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com

---
Frank Li (2):
      PCI: Add enable_device() and disable_device() callbacks for bridges
      PCI: imx6: Add IOMMU and ITS MSI support for i.MX95

 drivers/pci/controller/dwc/pci-imx6.c | 183 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c                     |  36 ++++++-
 include/linux/pci.h                   |   2 +
 3 files changed, 219 insertions(+), 2 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20240926-imx95_lut-1c68222e0944

Best regards,
---
Frank Li <Frank.Li@nxp.com>


