Return-Path: <bpf+bounces-46579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D72F9EBE17
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 23:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC28167F07
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B86211295;
	Tue, 10 Dec 2024 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ijzIVV4N"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5851EE7BC;
	Tue, 10 Dec 2024 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870972; cv=fail; b=gQrl6n/PsoXcCu2w5g2eMveCGCEMryKUTvfxpZjG7l0v3aZnLJZ1HibBMtdB3QwWjdqv7v1ef3Vh7B//mzIqvD/4DPHlD6RtZQTYFgXzeseVWMdvn3RkQQf1twsxVb6sz93JUmNHxfM3P/w84Q8niXVsTF82QMA3Ncnskskd+yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870972; c=relaxed/simple;
	bh=oP5DdB3yQAs0Hi/+MK6Xu7LeBmLWMIOx7WxcBiJ3W20=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ecI9eV38+l6yKVQ2hnE88s2qNk5onV2me1Lwg4J9WWkhZh+JYSDKZvRJK7btlplmFTVpenzTo9rIvZKH0QKoL2veKtFe5ZgOjzrJT+fSYPeOMrGvururqUnqAivHGvCAOwvvMdE1ThclX+s9kzUc9KI1aCf8XEt+kBW1eCYHXtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ijzIVV4N; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkFXqKuQS9XMQo0AF04lCXRveEcyLX+YGafKZ2O56MkGyBwk0vXK6WiFuI0v8J+jApW+S+JErRLWSJYnf2PrM4YBCioN9UV0aFo+2UMhPOgJqRl/yFzxswK6vYcTaEXq17ib7vtv85weJYZMOAbJewaduScVMKnweCquWdlPk4hci6nm8R54iE22zad6QZ19CxUjct1DmlS5QFrif+0yq3JvK/rVXUxrrnMmflWzk8Y8hwh7kxkqVZmZzsfANWiIhqX3Ce1p03krjmdLPtmpgURQiFKfndMoDUym+nrxl8BSY0TgSqLnTVX12G/SWQnKcx8AbDBbPfnBz0h5doPu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XREZuEFyeTssP2HW1zZetavLYUnAQmEZryNOkuxfpb8=;
 b=OtccVUFHkEwIIrtrRcCNddFCzvUy6zoWap8sqrdi1ncNoWRum1HeYnE68pz+VAIYw9HQ5+I4g8YLrkBt1L6ztzOgzWesgfDvs7W+MbcXxZEDxtDnwocV4hBd1psusrU89Qr+TS1D3wNr9X5RT1KdLqURSanWmk8AdWZUlEFhhJTW3SjVuqSIFSe6TdWp8qVlTTuSSuAh52DuuDXKxPIlnse8/61xRhu9n+C10yJHiQrqaKkJ8te/9ALJqI0KeM66kzz4lk59qPQtUjlwlR21UjADtgNcFJobQqrs/M8nWi/zoSlostU70uENx/goUn4yaaRbiuKxjwv7DZ+LY2zxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XREZuEFyeTssP2HW1zZetavLYUnAQmEZryNOkuxfpb8=;
 b=ijzIVV4NgxvKacNwxCVKi/9uqX6hZD3l53AW5hVBa/vw9MUfIhgtHVLRIJe9p8QRSVkghRCt9p6I/hin7U4nTN9HUwgUAVclVQTpUIH5lkIuwmMzX1f+3tnIvJ6lB1t7MwpEYSchCeMS88fZVOppqAfJbKc/ED//PbfSfEuhsK7QL0iWiG7IrfCgu+TfrakxVEAHHSbedH1fvm3cD7UxzV31Bn3ilywuPfVP22aZeTfCaNdxtqHvI7VzgGhgTl4qz6ojzFT6+p6l5/yl5Y7wOhVIS3xPcnYhO4JUKwsDHwBifOhZJzUbI0D6pEEBhz4sI8+O7yZK9PNWBjbiPk+CDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6784.eurprd04.prod.outlook.com (2603:10a6:803:13e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:49:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 22:49:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 10 Dec 2024 17:48:59 -0500
Subject: [PATCH v8 2/2] PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-imx95_lut-v8-2-2e730b2e5fde@nxp.com>
References: <20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com>
In-Reply-To: <20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733870948; l=9334;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oP5DdB3yQAs0Hi/+MK6Xu7LeBmLWMIOx7WxcBiJ3W20=;
 b=BaD46AC8ONfzMIhJjsmXkrTYQA+WUdUPz65eXylBMxPZuMSUygZXzCz+oIiiydFuv8tlr219/
 F2hESt2VqivC7CQX247XT04G8Jf4/P89maRqUZQ4Mc0rnxkXbmdVkRz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f20d62-c18a-46f0-9cbd-08dd196ce5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFJhUkZiOW5ybkU2Tmd4SVB2TU1Xa0JaZ1ZyTlUyWGR3ZmxmMkN4eW10S3Zx?=
 =?utf-8?B?ekFENEJMMG9heTBaMU0yOW04aURkd1l1cXBuOWZvL1FMRHpXVGdLUWJXNzBE?=
 =?utf-8?B?V2IraG9PSmlnUmxYNHBGaUhvZC83UmdYRUxRQkpvTXNMUEJ3ejFCd3NKcjVQ?=
 =?utf-8?B?SExzVkVpZXl0TjFBVGhRRFQrN25XUENrUmozMDJSM25NbWFJeDE3cFdQYTdL?=
 =?utf-8?B?UzRzc3R3aFBwRUJXNDZKMGtyWk5QcGtTVCtrOGpGaFpHNTV2QVhicG1rRW1n?=
 =?utf-8?B?OEt6dU16aDJPaFZjQlZ2S1AvS0ErMGNKRHZ4RGV2bHd3dGtNamhTQzVBZ01M?=
 =?utf-8?B?cjVUUjQwSE9JRGQ3RDFIcmdleFN6SFpvSzhuazRVNDZDN3A1RW1adnE3bFRO?=
 =?utf-8?B?ZWhlbEcrVHVSU2FkZ1ZFL2FtQjdpSkpVMUxsbDM5V0R6L2tVanZIR1Z3d1FF?=
 =?utf-8?B?eTdmS3JtdkhBRk0rVC9KSzRLRDBVVXRIUWVXZ3EwYUQweGJ5SE1hUnp2NUky?=
 =?utf-8?B?SzN1SWN4UWJBZkNVZVo2QW5kWFh3N3R3T1hDbHJhZlQ1dGdublZ0OFZ6TDYy?=
 =?utf-8?B?cWlhYzUxWWhwVXhFUDE2VGE4OGNWZ3E4ejJLZGhoUUNKQVlrYWpLajMzYUNB?=
 =?utf-8?B?ZDRZQ0JGZ0Vyb3hGNGQxQUpYdWViSFZ5VlRQRDcwSmNWbldTQWhXS3ZqVnBK?=
 =?utf-8?B?dWo3empLRXJnN2RObEtIc0x5dXFNMXFNUnMwVHZNaENHZWZDQ1RsTTEvZTRh?=
 =?utf-8?B?MzBFWkVmQ3RVT0dua2JjNzM1eVIrQjVtNFBhQm80eW9nUzZsUnF1WUN0cVFS?=
 =?utf-8?B?Mk11T3d6anBMUGlCOE1sODdWeFBiUjF4OUZxR1lwVlN1eDRObEFrZ1dSU21C?=
 =?utf-8?B?RGVYOGROdlFFZjl4ZzVhZUM2d3N4TlNEZDlsMFdUYld1NnVudndhNjdyNW16?=
 =?utf-8?B?a21KTGRQRml5MUNWVGtPekdMemgzNldXUko0SEhIdEZSRCtUZ0J6UTU2dnVy?=
 =?utf-8?B?R2c1bDIyeGVtTW52dEhNT0VkQmFYaVZIVVdESVhRcktsdkcveFEzNmZtSS9G?=
 =?utf-8?B?SXdPdENaY211a1grL1FkNlhlWW9XcjlnMEswYzZVUVJnNklxS3Q3NllydWRo?=
 =?utf-8?B?QitqcnU2Wng0bFptTW5aeFJTNndicEFpaUtyYnJ6RVBjWWFYekdBQS9uRVE1?=
 =?utf-8?B?Qnp0Y0pveXZwMm1nZlB5RVBmNnN2alRLVm5MZVNyZWpDeGVTZGtIRU9MSnZU?=
 =?utf-8?B?eHppbEZnN1h4aTI2UEZnMTBackdrckkzYnJocmM1bkhyNVlyeUEyb2thZGpY?=
 =?utf-8?B?V25RVU11WGwvWVFxNVZhVVdSVkdVdEhHR0NTenFPSFR2VXVJcTBKMFV2NTVL?=
 =?utf-8?B?bHpCTUdxSHc3QkF5QUhleU44cGVKcko1dEdQRkRaU0ZxczVCYkx1dHNLVHJy?=
 =?utf-8?B?N2dCTWp3bVNwdUxHbDgreWQvYmI5eEdLenF3TkZhYkFDTi9hUEV6NVp5d29B?=
 =?utf-8?B?cFpnR1NOMjFkTFg0VVNCak1mU3RGWWs4RzhxS1dUMjJpUnpud2tjMkRYNVFG?=
 =?utf-8?B?WHR2eVhHRUxSa2I1by92NjZSVVVDMlBtZ3UvN2d5MzdMY2Q5THlJaWhLeXBZ?=
 =?utf-8?B?Q0N6R1hQL1lOcHhhWGsyZktVWVJVQUZYNWRoUWtScUgva28yWVZSMkh2dWtr?=
 =?utf-8?B?SnozVDA0WUZwSVRKSit4eUJMOGV4M2ZZako1M3JEVy8wcVFneWFvbWxzaERv?=
 =?utf-8?B?WDRuTjVmNzZYMHcxdnUxS3BrS3B3M3NNMUJVZVJ2c1V6b21xcUhuZGI1YnZl?=
 =?utf-8?B?YThLb2RvL1RCNXp3QjhvK0NkRHVlVkk0TG5zblhFMTBCdFFSNm1RQzZJQ2ho?=
 =?utf-8?B?eHJRQnJySDdPTGtHek5jU3c4OUU1NzNlNXE2RW9md0hrOUFTWDZocVBTdW9P?=
 =?utf-8?Q?rEFQOYkQnRg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y08xZDcvTzBlRUZ5QmIydDdpZDB6aGg5VlY0VTJybWNubWEyc3d3d2g2V0pm?=
 =?utf-8?B?Z1MxR0pGYWErL1RTZXNMUDd1a0RreXU4UDJvTjdFclg0Sk0wUXhBYlVXZ0hm?=
 =?utf-8?B?bnRDelk1TCsvcmsxYnFhUUJKZ011VVRMd2JSL09uZ08vVE16bStNM3k0M2Vj?=
 =?utf-8?B?STJ6RUNWR0ptV0xSZEhXRi8yb1hTQ1lsRWgxaW1FbHhJQmR4Yno1QkUyNnlQ?=
 =?utf-8?B?N3Z4dGk4MC8rMVV3d1I4eUR1N1ZtbUJQejNpcFI5cWU1NFFHN3oyb2ZhOEUr?=
 =?utf-8?B?MFlhMEJrVHY3b1NHejI1S1llVVFQYTRlcTlxV3ZqY3pHWlBteUptVVNuYk0z?=
 =?utf-8?B?LzhuVlRHcWZYQ1kycHlsdUdkUjlSN0pyc2QyMVR3VkM2UWJ5SjFpeXBLbE9T?=
 =?utf-8?B?L244YkJjYjIrdUFObFNsbDA2T2VpaWlTTjkxS3Q3VkZVT3NIS3MzTVdpdnFE?=
 =?utf-8?B?N0djS0VvNTBmN3d2Mm9oMGdFVGJxRUVVMzA4endBQml2ak1JMXRMQk9oZUtu?=
 =?utf-8?B?aTk5QmNOcHY2ZWZFTmc1ME1aWjE1YStyaC9RYmQwckxib013cDVRK0o2K2Nu?=
 =?utf-8?B?dGcxemx0NFR6bXVyTEEybnc3aVhSbGUyWnJhWHE4UDdkVXlFclIwblVLUzVn?=
 =?utf-8?B?UmRkcUJQaTZJK0JEaG9DSjkvakVobGc0TWxLK2llbXY4QkZOTnZlVGREU00y?=
 =?utf-8?B?S1A0SkVnRFhVR3JZQnZ4ajUzVkZCeG9UakljWlN1SGl5d0w4MytlZlJSTVFz?=
 =?utf-8?B?b0VXck1NenVGZ1RSUk9Pa2diRitCdnV1bnJUR3ZHSzFCSGhUbTkxeGJkT0xz?=
 =?utf-8?B?ODJ6NGZyNk9BS3VxR0k2ZVlGNTlaYUw2Z05hL1dSQ0lOdUw0VzEyZHhRRVRw?=
 =?utf-8?B?L2l1U0UyR2YvRkQ1ZDhFd1RrYUVlU3dtM3BOSjZYL3JFUGo5cnNOcW1SSnpL?=
 =?utf-8?B?b2thN3ZTcGxiUWRqNnZ6RyswU3hEenZUZWlCVmd3T2FHQ3lLbGZ3bERIS0FX?=
 =?utf-8?B?c25pQUtrWlI1L1hEVmRxbUNtQk0xNEZkZ3M3Vms1eFpxb2UyWTlrSVNSNlBo?=
 =?utf-8?B?T1YwbmVxYWorNkRBZDRTcjArMzc2S0FMWjFkZnNLS3lOaE5xaFEvcnBBbzhX?=
 =?utf-8?B?R0owNjM4QzEvUmx4UHFuVFpDYnA1U2hyZHcySTFXMS90d3ZZeFVwRlhtV3dI?=
 =?utf-8?B?aW1mZHZsWjZ5OW9Oa3FhRnRTb3NtcjNocHdaUFhZRlkwRnVENXlOdnNNR0x5?=
 =?utf-8?B?cFJnQjJpSUFJdEg3dlFEdDYrUWY2MkkzcFpSVWtBNDhzN0pCL2RHL1lFMXdt?=
 =?utf-8?B?eDBDa0dVZ2VVRVVyQVFSODhMUjIyVEk1bHFWNFBEcWhYSldmbTExb3VKRVJ6?=
 =?utf-8?B?VC9RL2ZuQ0EwNnRrb0tKNXcyemFYd2E4cVp3U0Y4eUZOZEJjNkpsZGZnR3Nr?=
 =?utf-8?B?MHQ2a21TcTJQR3VVNEREMk9Ra3VSM2hjU0lHOUV2dU5vcmltbk5YVEE5NklC?=
 =?utf-8?B?RDZwWkxjUFRmNExCY2Y2WFFjb3p1Nko3b0UvOWF2QW9tSGpiNmFYVVBCeEd1?=
 =?utf-8?B?aXZ4SDYydTlaYkRmbmwxNFRWUGEydm9Ha3dvOHpPWnhmeDRaUzVsWkZGcTNX?=
 =?utf-8?B?U1FEbjdSQmZ1WFhKZ0ZLeUU2dFdXS2dtT21PY2ZmaE5Rbnc4NVFybFBxZFk5?=
 =?utf-8?B?VTQ3cC9QVXFldEY0ekRuSTJKNll0U2NidFU2aXhvMFE1dDk3TmNwVXR4QzVw?=
 =?utf-8?B?Q0dueENjcnZEci83TG4raWtNVE1zQTROclkvMFRzUEhFamluNVJ0b3kreHcw?=
 =?utf-8?B?QnplMmpCU2RJeHR0Tm1hWTlmTGk4NHBKMnRSSFdZdDJGOUU5ZG5qR0hha3ds?=
 =?utf-8?B?QWc5U2xmdk1ZVHRIVWJmSUJ0S3NUU1AxKzIxZHdwUWtuQUZSaE41NG9STUF0?=
 =?utf-8?B?Wk91Sm9VRDRvbzhyWnluRURQVlZWdUs3L29lUEhjc3FvU1M2NU5BT0N0dzh3?=
 =?utf-8?B?c2dyTnphQ0pDQWZRYVJQMm9Ya1lsM0lLS3NIdEtyNkZ0S3E1K2JjM25pU3Bk?=
 =?utf-8?B?Vm1Raklza05xK2VHWTVJZ0xnMlNDSjB1eWZTdnIvR3ZSREZXeGJ5UmYxUVZI?=
 =?utf-8?Q?0AyjzQkon6j3SBzxIMAxtmkfl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f20d62-c18a-46f0-9cbd-08dd196ce5b8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:49:25.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhVq3J7XOX2R9pYQY0JqmGUyuo09f/No3o+gVXhNF1LnaFFYXOkedLeSRq+QpgQbOfDJwuOKFwbQJIVFuheTKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6784

For the i.MX95, configuration of a LUT is necessary to convert Bus Device
Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
This involves checking msi-map and iommu-map device tree properties to
ensure consistent mapping of PCI BDF to the same stream IDs. Subsequently,
LUT-related registers are configured. In the absence of an msi-map, the
built-in MSI controller is utilized as a fallback.

Register a PCI bus callback function to handle enable_device() and
disable_device() operations, setting up the LUT whenever a new PCI device
is enabled.

Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v7 to v8
- update comment message according to Lorenzo Pieralisi's suggestion.
- rework err target table
- improve err==0 && target ==NULL description, use 1:1 map RID to
stream ID.
- invalidate case -> unexisted case, never happen
- sid_i will not do mask, add comments said only MSI glue layer add
controller id.
- rework iommu map and msi map return value check logic according to
Lorenzo Pieralisi's suggestion

Change from v5 to v7
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
 drivers/pci/controller/dwc/pci-imx6.c | 186 +++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c8d5c90aa4d45..d325f4fb279c8 100644
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
@@ -930,6 +950,162 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
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
+	u32 sid;
+
+	dev = imx_pcie->pci->dev;
+
+	target = NULL;
+	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
+	if (target) {
+		of_node_put(target);
+	} else {
+		/*
+		 * "target == NULL && err_i == 0" means use 1:1 map RID to
+		 * stream ID. Hardware can't support this because stream ID
+		 * only 5bits
+		 */
+		err_i = -EINVAL;
+	}
+
+	target = NULL;
+	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
+
+	/*
+	 *   err_m      target
+	 *	0	NULL		Use 1:1 map RID to stream ID,
+	 *				Current hardware can't support it,
+	 *				So return -EINVAL.
+	 *      != 0    NULL		msi-map not exist, use built-in MSI.
+	 *	0	!= NULL		Get correct streamID from RID.
+	 *	!= 0	!= NULL		Unexisted case, never happen.
+	 */
+	if (!err_m && !target)
+		return -EINVAL;
+	else if (target)
+		of_node_put(target); /* Find stream ID map entry for RID in msi-map */
+
+	/*
+	 * msi-map        iommu-map
+	 *   N                N            DWC MSI Ctrl
+	 *   Y                Y            ITS + SMMU, require the same sid
+	 *   Y                N            ITS
+	 *   N                Y            DWC MSI Ctrl + SMMU
+	 */
+	if (err_i && err_m)
+		return 0;
+
+	if (!err_i && !err_m) {
+		/*
+		 * MSI glue layer auto add 2 bits controller ID ahead of stream
+		 * ID, so mask this 2bits to get stream ID.
+		 * But IOMMU glue layer doesn't do that.
+		 */
+		if (sid_i != (sid_m & IMX95_SID_MASK)) {
+			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
+			return -EINVAL;
+		}
+	}
+
+	sid = sid_i;
+	if (!err_m)
+		sid = sid_m & IMX95_SID_MASK;
+
+	return imx_pcie_add_lut(imx_pcie, rid, sid);
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
@@ -946,6 +1122,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
+		pp->bridge->enable_device = imx_pcie_enable_device;
+		pp->bridge->disable_device = imx_pcie_disable_device;
+	}
+
 	imx_pcie_assert_core_reset(imx_pcie);
 
 	if (imx_pcie->drvdata->init_phy)
@@ -1330,6 +1511,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	mutex_init(&imx_pcie->lock);
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1627,7 +1810,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
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


