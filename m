Return-Path: <bpf+bounces-35934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 774B093FF1A
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051831F227DD
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A8818EFF0;
	Mon, 29 Jul 2024 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GoOyB+GZ"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30F18EFCF;
	Mon, 29 Jul 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284369; cv=fail; b=q0G/HTzTX+cvS9NKZZLvvisxSCZ7mfRFK34qbYhR8OwedMYUxAZSk1lX5es4un7GfAPnefjbp0QIxQ00Cj+0MrH3f4rHhlDKrLOBi8p9wmRq3KgOc5TUhAh9kFJqQHK7VPehYfl0Dkh4qtZeydDcX3neVaRzFVafNPA06i+vl/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284369; c=relaxed/simple;
	bh=TNSd+b5y2IdUI30Q9idwzdMxK5IHuQjkFajPvbPUy8I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gNwEYFCcgzq+jRfO9WjmmEA22NcclTtuUSsss3dgrjZUB1RDVRXZKCD9VqCTNYDSdO8BB420xFxsxqXjPtC6gx1XNV5iwR9wTKrK7H77ehRQ84TaLh+gxEO+pLiTx+wtMaId8CDFnNdtZVKSEOanMaP3Ph3RU7gxSPngJEhuwYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GoOyB+GZ; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Btr5xMXflJ2MxvcJzeLsNR96hHd90NQceLYel/LqyMm/iqj0bjwMJJrYJ5vvDKA7zDZiuLfqOElIQMWY+BAdtGwtv5IxQxIKbX8SP2yIyKttsMgBLgLIlN+yEBwelcYxBbaqHIJF9gyVSJEexiO3yF+rziQUN3wuCymkXmYBKAE/LZ1oPgRuaJrgpLbhCNnWXBt0gFPE6vXERYTHsvum9OtbzKsGaK7QzZlSAwCV7doRkoKyq30GuOz4PFRRgBS0v6w7eX2vbRFxKSQjyjJ3qSwGxHQgHztOcgFuOQksCxdAJ343xEmoM1knw05KRy3DkPoi+wZC964dUlSB5FOLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgP2ZgQ8Y17baGCLCTwEGc6nED28+XLD9ppoSRJTCow=;
 b=LEGfBer9sHSNb/cEq2W5fd3QX0WKR4PS2mIColnSqZNcFjE1nPdn2/L+H3QiEr/xh7IkH67wilteZ53dU4Tlc07On1Txsa846tXFEzFBKpAtU+svj7vfILRW3gVRR8mE4AxxrSqWXDiav7fjHEHDWQ8VHJw+rNA/hOlba6cpWJujV+KIdcWK0TdGtVPBoEQIHdxeJ9VuxXR51ilBx+47Yd70R2G8ZUM30VcWyDSoCHP1raN9wxb/9k6UZeAVfmQGNl4Pl8QLbsjEcQbcVVeQ+EZ77RwlNOqUF36o+JN+gAhj8Ii7Fw3q+ymHAFMXHo4SE6TFC4dHZxIvhASnuCMIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgP2ZgQ8Y17baGCLCTwEGc6nED28+XLD9ppoSRJTCow=;
 b=GoOyB+GZnh2W1lzYSBhGSmIHK+RkbpQml8lMK9tVWsBBQVcO+YlC4QGz/E1D+0hPfM5vQBjLdpX+sohllHGcaTMKzxRvSuKoTsvXJ5/Z/Lnu+LS7MhIRrZUtc1T9nP9y4DisXL/GUQraIhCz7FOVv8YCtPiqxj3opZDFt1eT2Fo9bNYQhfxqBdyzbcAZpORmhLPBFrsZGb3E9a2mHpesuuczYL7a9vUZiOkzH2zT86t2+quqUZ4vLiEPHAwAGoZE+5sNOCp2sW/9PpmHhDhs0/CXJBnKxMxrmY+FwCb/JpbVSfTlud7ufR9LsVoXB0tZwpuJrRRWyjOx3anu62zMzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 20:19:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:19:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 16:18:14 -0400
Subject: [PATCH v8 07/11] PCI: imx6: Improve comment for workaround
 ERR010728
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240729-pci2_upstream-v8-7-b68ee5ef2b4d@nxp.com>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
In-Reply-To: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=1916;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TNSd+b5y2IdUI30Q9idwzdMxK5IHuQjkFajPvbPUy8I=;
 b=2MBJzBHUD0rNYMpINkM4Y3v8wUZKNpvtaW8d0qIWkN1T2SYEBFFQQJEbWnGdhd4uB3RgEuskl
 QemHbccpzCQBj2PGMJqqAoe9Mc6+KLkpq7LUVe+GiDcwBVm1inVpGev
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f17378-a150-4e66-5bca-08dcb00bbc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEZ6dFBuN08xcVZrSW9ndHVxV1YvdWNDdy9oTExWMFJwajUrSnErdVpzeFFw?=
 =?utf-8?B?eVJVVFE2OWR6VDhqTWlqUytnVFBMaVZLbElubmpMRGk1aFNnR1JWSE5JU28x?=
 =?utf-8?B?ZmltWlpKVHNKM1YzWjg0ODh2VGVBVTNBY2FBUjZreUNLbUtETmxvSWZ5eEFk?=
 =?utf-8?B?eHYyc0tYV1dpc095Q2xrcVBjVXpaamtRQTBnSnBwbFVsUFUvKzRnazI3TFBu?=
 =?utf-8?B?RVNCK2lSWm5iTXFQUFo5UGJReWpac2ZtRWtacmNiOC8yQVRYWXRPOEJKVzR2?=
 =?utf-8?B?aytEQ05QS1ViRGtnYjh6blZaeFVFY2h0Ylk4WnFOeHlGRU1qTVh1MVhOUDF0?=
 =?utf-8?B?c2NnNDh2OHVYQ29UNnZVOExpWnZPRjZJeEdTenRvT1JFOVRpYUhiTFdrSkdz?=
 =?utf-8?B?Z3JpaDM2a2dReWZubDAxejdhRDhOTGtjUmV5N3o2SGwvUUxuWTRQUmhWLyt2?=
 =?utf-8?B?dzVtYU1Fb2pscGNwaytkV0lKb29rNEhNVWlnWUQ1L2xaVHo4aVlrWUNZYWpJ?=
 =?utf-8?B?NnBqMGVtRmZ2S1pSNmpSQmJpUGFrT3NvL0xvYlRUU3FrNUJ2cU9YVXhhVnpm?=
 =?utf-8?B?WHpxMlVlQVgxeHloZWVMcFFsYld6NFNFZGtqSkF0NVBnSzhWUm5LOG5JcDli?=
 =?utf-8?B?a3Y1MEpNdmNFdnQvVW1hQlUrMkpqOGhvV2gvbStBZ05KSWpSYzg5N0s2d2E4?=
 =?utf-8?B?b3hqc09FOGJpcDJrcy9waEVwVWxWUDEyUnp1eUd4N3lONzZGcStjWS9HUUFN?=
 =?utf-8?B?RjlJbGRCTFQwYlowOTlJV25iYnFyaFJHNWI5UDZjdjJZRjFNTnlUOTBrdkRW?=
 =?utf-8?B?UHQzd2FvZkVnemgzUTkrMHhzUjJVUWJEcjNYOUVzQ0hJZVNnR3EwdFd4UWVo?=
 =?utf-8?B?blUvSy9TT2dLYVRSY29KMlkzZXo4cFJDQWlReHFZRzIxKzhpU2ZmRUpxaGNs?=
 =?utf-8?B?NTZQYTNFcHNHcWV4UHNLbWxSMmdOak9la3ptaGhBak10QU5uYzR0ZVJWNTBF?=
 =?utf-8?B?ZmF2U2VzckZibTZRYmk4NldwWXp0NDQzYXJJS29yek9hQ1cxMXVyTVZjVE9D?=
 =?utf-8?B?MnZHUWhPVUx1Wlo1VVN3TVdhMUZRK3VISGVtRGpITW5KS1c0RVFZNTBXRWl1?=
 =?utf-8?B?UmFGVENRdjJ1UzU5RkRYdmV5ajNRQWIxaWM2amxVeS8zejdScXNRWUlHZVBF?=
 =?utf-8?B?UU9ZcXJOTlZFMGEyNUpnQVdEd0N3L29PcGxpUWZISEZhdlY4NmgvdzV0d3pw?=
 =?utf-8?B?OGhmWldaWi9LM2RBZ0VxL2dNUlppb0VlYms1bWJOcU1memk1WWkwVW0wODFJ?=
 =?utf-8?B?cnFqcmdqQXhtc1Yvc3RQSmFOeUlyWVhFUkp1Q2ZqTDVJdXFidmxaei9VSWxD?=
 =?utf-8?B?RmVqb25zMU1ZUE1hTS82WEh2bWF3eVlzODJrZnNackRxQm9vZGlwNVVQSnI3?=
 =?utf-8?B?c0RtaTJiZUFPT2dRWkxFK2V6eXAwc1F4ZmJJdHlRbXhVTjVyVkhQRHNIRkI4?=
 =?utf-8?B?c0taaHBTaUtHd3VOVHpPN1RFNUlyRWN2enR5MUhOTTFhbzljMHB3ZVNmdkxs?=
 =?utf-8?B?UHhmbzJXWVVmVVR5YjU3NUNDZXQyenJkRXp6NDBxZHNURVorc2gveGZQZGpt?=
 =?utf-8?B?R0JITWxReTVNbDMwem9ZMTl0ZzEyZWRpNU5lMUU1d3R3KzI1MEh5Qzl2NVpO?=
 =?utf-8?B?cU9idDdSckRSMGFab2prR2lWejNtMGRWSnZ5SHFzTHhaNUI2UmMvQ3l3OHZQ?=
 =?utf-8?B?cUxJNVp3SENpOUl1RnlNZDBNRlNIU1FjRWtyRkZqOWdhT3NoWmE2OVdhRzBF?=
 =?utf-8?B?VUpva1ErNEtWek1RVDUxektjRlhhSGlVd2hpMlFqQXF4T1FwQ0xsRzAzcEl4?=
 =?utf-8?B?WXpjd3VCQTZoMkp0b3gxSGlUR3lHTlppYmVJUlVDenJsaDlFcHpFMU1ETlYz?=
 =?utf-8?Q?aB5wQvEC1Xs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEZLNEg0U2djdTZIUnVhaFhKak1MYUEwdU1zM04zOW4zMGlZNXpFK1NaT1Zy?=
 =?utf-8?B?ckFuNHQ5N0lVeFF1ZWd3bHFXUjlxaHljRVp4UHFYc0puOEZTV0VrMnR3U0gz?=
 =?utf-8?B?RCtGQ1ZqNVB5bWFTRWRVME01ZGtRS25pNWhlRnRjTVlsYzAzYWw2NG8rdk5U?=
 =?utf-8?B?b3oybjNaaU5rUVJFWXh6cG51QTV1ZjNPZkdpRERJenFSN0cvMUVNbVZ3Qmtv?=
 =?utf-8?B?WkYrSk91U05TbXkyRjdwU2ROZGg3N3B4elJYbFZmSE84UlNSc2Nvb1cwNFRw?=
 =?utf-8?B?dGpQcEFJZFNpUml6TXRoSVFOaEthNkF3dytLZE50NTNMWktDVkxMVUxnWjRp?=
 =?utf-8?B?dkgxZVhVM3gySGdLOERuTEVSVTM5ekt1TlVOa1UvS0VsMmpHbnF1cWFMOGNy?=
 =?utf-8?B?SytsYWFoNTUzK3gzQUNwZlBSanVPQWpNeHVrMzhhcXZuU3hla3RDMHBNQThL?=
 =?utf-8?B?Y3c1VkNlV0lFQ0hIaHVMZ0ZBU2RoMzRxODZ5RzQ2Qlc4T2FoOFo2MHlQajVR?=
 =?utf-8?B?MnJXYVQ5dktBTXQ2YkhSbE9OVGw3NTBCSXZwMHI3NXU3K0hMQUE4WWFTYUIz?=
 =?utf-8?B?d2Z0dTAyZjdJN21LVkhWVytxQjl2eTY1a1Z5dEpkRDA3d21FTGV4ZXZodTMr?=
 =?utf-8?B?WVJvSTMvZzhXNTNLQkM3eXRFWEM5enFNcnB6VzFaRGhLNkkxUzQrcGN1OWVT?=
 =?utf-8?B?U2pra3ZldUJtelU0SmpMTm9RVERZeUpnYjFpWnhrelJNS2VmeWtIN3N2d3ov?=
 =?utf-8?B?N1NpWG5ySk5HSXV6VVpWdEp4RmV3aGFLTE5taWZOMDNHOEVrVUs1ZEk3YzFR?=
 =?utf-8?B?amJWQjkwSjhnbFhkT0RZeFRVR3NIYXpROGNTTHVsbFR1L3kzK3oyVytqRTRk?=
 =?utf-8?B?cnhISnprVVUxb2puTEQxUUdWSzg5UXVVZ2Ivd2FvZCtwMDArc1BzV3dpeTNr?=
 =?utf-8?B?eXBOVk44YXF6OUNCMVMyS3dvYjhQMURrZTdBR2Y1cXV2Z094cGd6NEFrWUtX?=
 =?utf-8?B?UjlEcmh0blNoVGdMV0Z3bTFDZnRtWXo0ckZKVUtjSlhTbkVVazJmMjI4bFJJ?=
 =?utf-8?B?YnEvcHdqWXlZbUNqOUJiWnBxVlhVZTRId0lBQVQ3c0hISGtERXBJYmxrM0lF?=
 =?utf-8?B?VmExTXoxcnQ0MTJwbitKZ0RLV3B2R3pVWlNrWG9pV3dMZzNUek00NlhiMHVl?=
 =?utf-8?B?aEc1MExCY2FsK2VMVlNtdVAweklxZ0dBRnFHZFVKVlNUV0x3RGZqdU5xSnRB?=
 =?utf-8?B?Q1J6dWtSOHRxczBVVnhLb3F3YWNISmtFeDhpemM0bWR2d0tnYjVtWE5mSVVo?=
 =?utf-8?B?NUx2aDdOUDJNaGZUL3cyS0MwdC8yTGhKTlVzczV0UVVDSFVLY096T1BmUEJU?=
 =?utf-8?B?amZKbUtleGhER2RMUnMrbkZ5QjRJb0dOeFU3SlVlZDNQR05EdmhqbHhZU2R2?=
 =?utf-8?B?WVVRRStTQjlGNkpsR05tclVHY3V0bEdrb2JoMWVmWmk5ekRucmdVL05tcjUz?=
 =?utf-8?B?ZkZMMjBkOHVhVFQ0VXAxcnBxZmZQUTZ6NGFIYWEzc2RHUzk5QmNxZGZyWGdv?=
 =?utf-8?B?VmFxdGk0ZS9PK2dGUmowYWg0SnkzdzRmWGtuTDYrUVdVYmg5dkpHZVVLbkI3?=
 =?utf-8?B?TWN0c3FMS3o1THRBZlBzbXp4ejJIZStBNkRvaDJvMjFJUExnbVpRYUdORkgr?=
 =?utf-8?B?anZLVGNhMlBndFd4RjRuSXh0REVOU3NYWDZVMnFKa0c4T3BmSTIrUzNSVHA0?=
 =?utf-8?B?S04wR1phaFFsbEJWdlJRbzI0TDZNK1J2WmJhNC91a2dOUWZ0bHF6VFg4ZHhL?=
 =?utf-8?B?NEVPTHdGU0pVUEFTV0N0UWtjb1VDbG5iZWRLektnd2ExeWhrcFFFYkZSQXBI?=
 =?utf-8?B?UG5Sc21RYjBuOXZIbDBnSGtDUWlza1ZMZURMWXBkcDJQNnBUQW4vbFExTkJk?=
 =?utf-8?B?ZmVyY21lSHNGYjdnSG42TC8yZmJnTlB2NFJXcVVobUV6aHBVME9kYWdnMzJV?=
 =?utf-8?B?RGZvRjJzS1ZXTU9abVZ5WWZBRU5GWFZRRzdlRGtrU1MrVm1wMDBFRHVOWWpn?=
 =?utf-8?B?bjNaa01kNTdzWWFUUWs2RzFNSGpWcnRURW1UNWJWcy9DR3VIQ3ArSWhMcnA3?=
 =?utf-8?Q?ydCYXKu0DIIiitWFiWfTlCxQm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f17378-a150-4e66-5bca-08dcb00bbc71
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:19:23.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4wvPqwygIKYoOHyV8bbpWKTjbjMxN5x7tY/jqhKhbX+IhDyCSdSSoF0iFCljTTfecZsx6aim46SOe7Os0YhOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382

Improve comment about workaround ERR010728 by using official errata
document content(https://www.nxp.com/webapp/Download?colCode=IMX7DS_2N09P).

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e295c7bef732e..6be32a93411b6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -712,9 +712,26 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 		return 0;
 
 	/*
-	 * Workaround for ERR010728, failure of PCI-e PLL VCO to
-	 * oscillate, especially when cold. This turns off "Duty-cycle
-	 * Corrector" and other mysterious undocumented things.
+	 * Workaround for ERR010728 (IMX7DS_2N09P, Rev. 1.1, 4/2023):
+	 *
+	 * PCIe: PLL may fail to lock under corner conditions.
+	 *
+	 * Initial VCO oscillation may fail under corner conditions such as
+	 * cold temperature which will cause the PCIe PLL fail to lock in the
+	 * initialization phase.
+	 *
+	 * The Duty-cycle Corrector calibration must be disabled.
+	 *
+	 * 1. De-assert the G_RST signal by clearing
+	 *    SRC_PCIEPHY_RCR[PCIEPHY_G_RST].
+	 * 2. De-assert DCC_FB_EN by writing data “0x29” to the register
+	 *    address 0x306d0014 (PCIE_PHY_CMN_REG4).
+	 * 3. Assert RX_EQS, RX_EQ_SEL by writing data “0x48” to the register
+	 *    address 0x306d0090 (PCIE_PHY_CMN_REG24).
+	 * 4. Assert ATT_MODE by writing data “0xbc” to the register
+	 *    address 0x306d0098 (PCIE_PHY_CMN_REG26).
+	 * 5. De-assert the CMN_RST signal by clearing register bit
+	 *    SRC_PCIEPHY_RCR[PCIEPHY_BTN]
 	 */
 
 	if (likely(imx_pcie->phy_base)) {

-- 
2.34.1


