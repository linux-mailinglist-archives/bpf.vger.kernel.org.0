Return-Path: <bpf+bounces-40604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3315098AD19
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCB21F21B05
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 19:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4D19AA57;
	Mon, 30 Sep 2024 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LEwM2NVp"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75853199FC7;
	Mon, 30 Sep 2024 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725377; cv=fail; b=BvHFxyVFRzuF7FqP7UYl6oVi3UUYiiUs/dRf4CVY5BPsAjjJqN2bkGUBKoJMXruxGsL4pD1DEN/Puuq11/o8rEzt5VTOyxL0sTJT5+45r6LYj/bM+CRVq63GUrEsJV+FZRZ0dgRVhjNsOoViQ8q2HiSm+raXWLQg2Hp/QoEtAIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725377; c=relaxed/simple;
	bh=OREvL7vqU5D1pI9TulNzKxJCjsrDXsupI4DL+EY4/Co=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cmWZAsi5Q2QjobWCJWTRFu7HNj5oaVE7Xyld/9aMdH2cA7fgVbCMyI6K+2fMsPUQsE8FXupdPvIrZYWoS3NdthuGB9MK7HPq6W4N+4lzdzRSPWIA5q9k1xS+D6TQjP8ILl4BfCGU3qDhBRAycmgnZkNyIvAOeNJi0gVurr9Fog4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LEwM2NVp; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVN8vmtCUI1bO2OROmRf3rlMkp9XeRMa8KiLdHJpbBy7pdNJ0ADi0fk3fab+3cVC67QDOfZBE3wIbp5MU+EAw/eDb22FMncGnAwX/I+1ogvMzbNB8zaU0J9zDWN0J7YtRcY823hciQ4Gwo0x9qbbF6RwgKdr+VAGL+E/zIt5sYOrsRlMfhUQIR6kY4Dxf/W/WsoyqlCetKr9bQNbIESIeapGE4HoouuIBid07nOKedLZbIG+UzcGUUh6+KaAL0JINW48uMljhS+k80H6vL0VIuOEI1j8d2+9BBp02TUaKQIdptFePQ7tFzPkIA2UVaTBOlMxgSzSIClPwYmzj2mxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsNjTO2JALhoDDDoueTOVkkG65B/pDGx9V+st1y/KHE=;
 b=gf+5EbYMCjvzAylsfjpmbqGYN3f4izlsEaU0LAdLYrTzxsudU+LcGpXwZeonaivujrT38Zy3fpya5Ce3bDpeYFTogXBOCD3zEREq9K0KZWBIq9x1t2Ic7rKI7SJy1qHsUvOrptAj+KRK0P6huzIY+xh7I6LJ//fXQMb3SMIvDpr6/2geElx7fA/BbIeX+KPp2FM+5PBgy57X07aeHAB6qAHJiW5XRexfpA+N827Bn20X28T4km/LAFLuInw05FnBBJFMJLmCfrNwR55W2pSXSPEDqijqU5U3f4whHEnOoV8NNxiA1RuCi/dkEkpB489wVNcqS1TP5X9g7WNv7AdIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsNjTO2JALhoDDDoueTOVkkG65B/pDGx9V+st1y/KHE=;
 b=LEwM2NVp1j6R7XvoVS655NX1IMJ0gEJ3RrofWlLmu0zg927wl47NGSPnMOlyq4LaFS0h/y7oRiPaOhoQ8p7ASdjf+27sDQdRtcj5MiIOIgKvMKHlErQIOckeXJZ5wRoK55wvaEQ5VJ0djrFvL40eXPoRLWq7UGE5TR2rJMWm5xxoIECdb5BpVPtfpmPL+VaT+nDHB07sbkKj/Js2Ze8FulxTomPLhWgjSFIWq0BtneLVrZq80bbg7QK03zWcUsOkPXqx/hUoRa8PtO/0GZA0AUNEjYdIHJu3Ni9WhUfnDJJujNZEFUVP88SemrL0lAoNHKywbczadApoZFJPwuF37w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6806.eurprd04.prod.outlook.com (2603:10a6:20b:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 19:42:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 19:42:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 30 Sep 2024 15:42:21 -0400
Subject: [PATCH v2 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-imx95_lut-v2-1-3b6467ba539a@nxp.com>
References: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
In-Reply-To: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727725360; l=2850;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OREvL7vqU5D1pI9TulNzKxJCjsrDXsupI4DL+EY4/Co=;
 b=RqmKxOkRwsBQOKa+uPjogC3a6gO0ILQoO62arITPZQMdYYMVLUbuT3EPUNnE+1w04GgFbTCYx
 vuI/bVMbsqvDRBn0yAKofZJWjWyj/t3pEMdPEJicAg4ZvpkWmMJKSl5
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: ad03690e-6b4e-4da8-3832-08dce18812dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVBkYjV5R2tpRkQrTzNzVXZ3M2lzTkRvMDE5djgrRUl1V1Z5bEhIVGVaYnJN?=
 =?utf-8?B?eEZoQnpKM2hvSjN2RXpXQjB4ZXp1S1FPdGQyTExPUlVzSHBwbWlrQnA4SWZ2?=
 =?utf-8?B?OTMyckpoRFBTc2loZTlDSVk0ZEhWUDQ3cXJ1VXdVbGc4S3Z1K1dRWmVkd2hQ?=
 =?utf-8?B?MnNyUE8wQ3JyY21aQjc1SWRqa1E4aGVnc0wwNlVUc3Vmbnk2ZHgyUEd1MEIx?=
 =?utf-8?B?QkpJM2hsL3BhRnVQZ3IrajFSV1lvd0NOM2FPYnpCWGh1U2Z6NEV0ZCtGaUYw?=
 =?utf-8?B?S0R5SmxsMGxMcUFUM3FkQS9pVGlrSnVNMlpqREU0Ujh6VXhrWDhoby8zbU1L?=
 =?utf-8?B?Ryt5SFVVRTd3UkVKbHdrc0FSQVJteGt0bjBwNlhETWoxY0QxdGhsdG0yamFS?=
 =?utf-8?B?UHVuYW5XVzJFTTFrS2liRUgxUWlqMjZMbXloWllGbkQ4NzFQVjRRczB6N01i?=
 =?utf-8?B?b01LNHpuRTAwSUxQcE5pYzN2cUpSeGxWNUE2bll5UnVtL0ZvVnhFWkx5N0dr?=
 =?utf-8?B?ZSthRmppeUVyaHdIZ3IwVnRYME94Q2lPeXFTN1lyYXVVdHJhdElaVEsvaWYx?=
 =?utf-8?B?UzBCNUhjclBORk1KSGRuOVBpdjdmamd3VnJsNHlMTGYwd0xvdDBYSE5abGha?=
 =?utf-8?B?Y1BQWHQ1RnRiaTNYWEFLbkcyWktkWlNBOUtkdFZkdXJwaDhsSVBLMEZWSEhL?=
 =?utf-8?B?TnlvdFF2SFhONnZvR3VtRUNZUHZTd0h5V3RXWFVPNEY3bHJUNFZrblVpRUFo?=
 =?utf-8?B?bEorWWtKTVU0ZnFkb1QxTzAxN0xkbkRiQzhBdm5WZjJQVUZkeno0eVJFSGxN?=
 =?utf-8?B?OS9MSzFwdE91ZThDQk9SWitrL0hPTGEySzcyYk15bGVXLy9LQVUzRjJ0Sjc0?=
 =?utf-8?B?VEpJS3ZjZHJxNW13STNSV2hmdmtMZHlNc2FZVEw0K29HSVYwcmxKVmZwaW1N?=
 =?utf-8?B?TmdNNHdNam5VczNkcVU5bGE3ZjI2RzNVZjhrKzdCLzNWSUhRem9zdmcyMDVD?=
 =?utf-8?B?Mjhwd0M1OWx3QUlkUTJqVk1LcUl6Q1FXYmVFdi8yT2xDcmRwdnNiVHd2Q2xv?=
 =?utf-8?B?cHR4VVZEME1FaURRY0VHMjZZMnB4ZWJrUkkxRUtmVm05cTdFNVBLVUE0cE5I?=
 =?utf-8?B?QmJMUTZUMTlINVNRS3pkd2g0cmUxYTI5SjZYbWhNTGFWY0QvcHdGMDhpdXQw?=
 =?utf-8?B?aGJzYlFFVjJzUUtIS1lwdzJwNm9COFpsUGJtOHQ4aW42NkRGMCsyYnoxaWds?=
 =?utf-8?B?TkhHQ2dZQ1JaaEJlU2VRSGJldElCTFVURHErc2Q3S2JvK0djbUcyU1I5bFhu?=
 =?utf-8?B?M2dhTENyUDM1b25EdlBiL0daTHFlcnVQUG9kQnV0VGdLRThWdm1CSFl2MUhm?=
 =?utf-8?B?VUI5bHdTZGJ3dDhrOC9PVW0wQmtYWFBVcDQ5Y1RpSXBsam9qNzVXNmhieDVD?=
 =?utf-8?B?Vk5vMVp0TU05THJvcWtJNnAxUks3a1pabEJ0MkhURFl2V1lpMk5nNnRFOHJF?=
 =?utf-8?B?V3N2RmtLZlJsT0UvblAvQU5DTkNwclFKeFhnTWlEb1c1aUgrVWxVeWlYVUhB?=
 =?utf-8?B?V0ttVzJqR0dwRm10VFVBSTBsbCthY3dzSGxQMVVEcUFUVlExK3Z6STdDcHVD?=
 =?utf-8?B?akFXU1V5UGRhNnVRQ1U5UVROWkcvQ3A2Y0d5a2hUbDlqUTluWi9Fdm0xTDNp?=
 =?utf-8?B?WGM3aUZXaXg1NnlUa0JyTW9UVTgrcTl5RkJVZExwRFhNNHJTVzYzMW84ZlIy?=
 =?utf-8?B?cmhSV3hFejBkZDFxQTlTcmIwTDFodDdUZi9XbXcxNHBiZVFZLzRkUUtScVpX?=
 =?utf-8?Q?G1Nr165FDVKA2gV8zuYXVLu5sUtj4ftr9jx2g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFVsbzB3dzkyaGkzUklwME9Zd3kwOWxleDhYd3FnM3ZMalQ2ZWMzOThXbTZP?=
 =?utf-8?B?cXR1SGtRYjJXVDhCSE40UVZlVHRGRnhUVWxEcVdJMU0waXdMdFoyaytnVmJK?=
 =?utf-8?B?d1FJenN5Tk1XRXBPODllcEpRVHpVcFJPcUE1QTBPc1hMc2Y2RG5JMTdXdE53?=
 =?utf-8?B?YXFzcnpqL21KNTlRbUg2clM5WGxkNTZ4a0RnUTBTLzFJSDZDTHhGbDc1aDFC?=
 =?utf-8?B?bXpwTFRIc2RWZFNtZk5GQis0T2FicFZNcHE1eU1IcDdzQm9Qam5uNWVGeGNS?=
 =?utf-8?B?d2ZoeWZBWHVhYVEwelpFcGhYdW5XQ2t0MWxMRWZWNC8xdDQwU1p5ZTVtSVkr?=
 =?utf-8?B?YzFxcnNKd3lFZ1Y2bU5qWXBLVzdET2NmY3FYMlFEcCtyWExpalYyZUtNWERZ?=
 =?utf-8?B?Z3RQV2poT2NQNmVqTEJjeGFXSThSWnBkblhyOXF2NWtSam16bjFWeTdMNlRT?=
 =?utf-8?B?NGp3YnpTZmMzN3dDQVk3QWJsL2VaUXFiOG9vNnA0dlJhQnZ0UnlYMjNsbjV4?=
 =?utf-8?B?OWk1eFIwU25FbklKNlRreC85dWhnRHlXOFY2MEtuRjB2MmxtRE5ZeXY1OFhi?=
 =?utf-8?B?ak8xZm13QlgvbkFnYlBHZGliL0Fua3NkNXBwU3NSczFaM29EQzJ4MXgxQXdl?=
 =?utf-8?B?RTFFOXA1YXNIdHk4cUNCZ01FRWFDU3d3Uk5CeVd4R2dGQ0laSW5MbXQyOGdU?=
 =?utf-8?B?QmsyRFkzelg2a1pBOEpzNDdwc0Y2ckM3ajZhUEwrZ3NTdllXSHNJRS9BR0d0?=
 =?utf-8?B?dkdIbFhVL3BDSVBxT3hJWHUyS3pYZWxSMzZoam5kdTZRcDZyYzYvYzZLekNQ?=
 =?utf-8?B?cjY4NDQ3dlpNaVpPaXFHaEJGNU93aDZpRDhjWU02WmxFMDFFOEFGQzR3aUV3?=
 =?utf-8?B?dWk3K3hJaVduSU9zMmhWdXo2a0laMmphUDdGdDh0NEJ6aVg3Vno4anJFallh?=
 =?utf-8?B?WHFhYzQ5UmU4UEZxb3JoSXEwekxlbU85WkE0Mzd4ckUvRXZrWlpONW1ENGdj?=
 =?utf-8?B?aE96Y2xjUVVsY1hmS0RhZGxiZEpGUjNOTjBFSFZJTnVTc3JWK3ZTNEl0SWN6?=
 =?utf-8?B?VUY1NEt0QmhqN296aVJtdGdGdnJVUEVWOHBSanVjNlcweVEvcEtVbFMyaTVL?=
 =?utf-8?B?blp6cEp0QnJUdDAxc2t5SjBaWFBvQjVydEhiTU1CTnVuUGsyZEJsTU83M1hY?=
 =?utf-8?B?YTA5RW9za2t0Zmd3S2dVbjNSSlI0dndQamNxWUxvdUxuWGI3ZkZ3b2E2c3kz?=
 =?utf-8?B?NkhWL1RiMXFqaEpZL3oxdWt5NDdlMlJWOWNhZDkyN3kxUGhRL3pyVDNUVlJO?=
 =?utf-8?B?YUk2YW5kU0hHOW4wY3laUHBOaCs4YmUrU3kya0kwVkdYa2RzZEQ5dHYwTnFW?=
 =?utf-8?B?Vjk3NW9LSlFiQ2QrUUUwQ1daVzNUdkxESXhDMkZiVnRKbm5XUmRKaFRLUk1n?=
 =?utf-8?B?b01xTHV5bWJ3NnpiUnUyT2xIdkk2a2paUjFjQ2xmWUdNT3B0N3REaXprbzBm?=
 =?utf-8?B?Z0NqQkZGd3VtUTJwVlduT2tMeWtjWkdLc2xaSE9udHp5QzEwWHEzMFZqQnBv?=
 =?utf-8?B?eFpXZ0hrVnp5eVQxWjAxNEJhbmFoMHhhMnZnNVNNREM3SFpBWGZhYXBvK0oz?=
 =?utf-8?B?d1RaN2FsT21NZ3lDY01qcjl4ZUxTQThiMzg3K1FabGs1RHNnaHl3S2R1ZFBQ?=
 =?utf-8?B?aFhuaTgrRnpjZUUvQTFBYVFQVHRJUjRabGdERldzT1p2b09BV3l4UEx2Y2pB?=
 =?utf-8?B?MGJNOVZhVk96c212bUdjdkhOTkpZRmd5YlBPN1lkVEZCdlNKcm1xNk13MlJI?=
 =?utf-8?B?ZUFQaEo0dXZwdmlvVU5GVjQ3NmxFK3c2THlxQU8yUnFEZnRHaDk1eTRCMFVU?=
 =?utf-8?B?NlFYU2k0RkhIU2RTZDA0b3M2VW1SR1ZaSlNVTXQ1NFpWcmlXR1orZ0lPSERY?=
 =?utf-8?B?Zlc0TE52aVJVWU5PQkRVNE1XcUUreDRselVlYzgwNkNwbndrTGZIUUNuOWVR?=
 =?utf-8?B?Yjh3V2Zzc3JGdDdSL2RSN0hsbEU1NEtucSszTnE0ZFFINk5pRkZxRmFpVGNa?=
 =?utf-8?B?ZE1wQnZzYmhBdUpTaWdqZUJqL1UvUVRnbThVbVl3Ym5QL285bTdLeXhjOWZ5?=
 =?utf-8?Q?akEE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad03690e-6b4e-4da8-3832-08dce18812dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:42:52.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92mq3BVGPWYhXI4UmSIq7i1/Ai5uZ9cXYathcMNL5yhBymBJ33cU+otnflk59iW6MKpJyWLJQra8tyFr7X4m4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6806

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
Change from v1 to v2
- move enable(disable)device ops to pci_host_bridge
---
 drivers/pci/pci.c   | 14 ++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2a..fcdeb12622568 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2056,6 +2056,7 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
 static int do_pci_enable_device(struct pci_dev *dev, int bars)
 {
 	int err;
+	struct pci_host_bridge *host_bridge;
 	struct pci_dev *bridge;
 	u16 cmd;
 	u8 pin;
@@ -2068,6 +2069,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	if (bridge)
 		pcie_aspm_powersave_config_link(bridge);
 
+	host_bridge = pci_find_host_bridge(dev->bus);
+	if (host_bridge && host_bridge->enable_device) {
+		err = host_bridge->enable_device(host_bridge, dev);
+		if (err)
+			return err;
+	}
+
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)
 		return err;
@@ -2262,12 +2270,18 @@ void pci_disable_enabled_device(struct pci_dev *dev)
  */
 void pci_disable_device(struct pci_dev *dev)
 {
+	struct pci_host_bridge *host_bridge;
+
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
 	if (atomic_dec_return(&dev->enable_cnt) != 0)
 		return;
 
+	host_bridge = pci_find_host_bridge(dev->bus);
+	if (host_bridge && host_bridge->disable_device)
+		host_bridge->disable_device(host_bridge, dev);
+
 	do_pci_disable_device(dev);
 
 	dev->is_busmaster = 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be61..ac15b02e14ddd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -578,6 +578,8 @@ struct pci_host_bridge {
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


