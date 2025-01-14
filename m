Return-Path: <bpf+bounces-48850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD39A1122B
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 21:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52162188B223
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814C220CCD2;
	Tue, 14 Jan 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CNJT8Q4L"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2059.outbound.protection.outlook.com [40.107.103.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2D20AF8F;
	Tue, 14 Jan 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887055; cv=fail; b=nnVxRlIsjx6IJ6M7uA89DCWzvPbNrb03Ta3VhrhKLARemQpS/pK3NMWVklTvdb5bCv96+0kfzvQTEL0G9Kq+9i9J8ukBBMtdqop54GPtgWBwTU1w6fLiEfmwVPcoZOc+xVwf6GmIrAelKtTGaoksK08DHmJHGMufCt3Q+ZN66LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887055; c=relaxed/simple;
	bh=YFwqA+lDO6liNzl/Cppqxu5pnux+mxu09eolNFJM2yc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=BJCYh14EpY3ps78yUcSD15by0P0DlE8SgpGTcE4Y0gNMdfEhDkGDVz/S08Xh1ewkR0VuJpNZsWYQnge9bCnc8BSvgLtsnIw9dU4G+BMSJLGrrX6CZcGUN8mb1AmRQr0UQmakTRyF7IHwl5W9pCp0gLW9X1FhuhGOnCEbN7Lcfoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CNJT8Q4L; arc=fail smtp.client-ip=40.107.103.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxaTFkfyMnAoQk2VFK8w/bHfPnNu2mWupUSGcQrLayWpBdYlbolzgqzjg920jL//D6CmOJXPWN07kITuQcTbxG2+7p0J5tFvIWmPZ3qDMRNzNE8fcqDwm4jL2jsi3CtPm0Iv+TFSyjLqJAApnHk9RWQTf/fveE0GngTPhbublGh6uAghJWiLxMX9zgaxRIVIUhIFQtqdfzcD0rMjQE2LeayuRC6/YfLbmCb1qKEHQlQs4TEVOWVXKdlzuxhUbUiRqz7QJI/RlDXVTD1HwLozR2RMAi545n6Cbba6b3y81fQeg/Ew3Z+ggS0bnIvHbh9lFShQBBZqhWD6+fFIysGhHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZkjomNiQTwE85wrS+r/oxinAA9saigLPDFapCHXMeY=;
 b=zIE6irApuAX16hhYmC+GqAyiS603AccYjw6uvDPD6nOgcDsiqnppfEHSKQ/gqvyaOCnLmfAKoC9D/jlEgXeKQY1WO1/vwA3ei6NADapB5ZdMtjapmSGSDjQLtNFWMbJiOQSOEcy9wVEomR96S2iU5pCbX5itfoX6/WlDlPhFkKL2jW5hG8gDl/JL8SUwIyg3Ys2TzOoQAv/CZS74hTcn8cgFsLE685UiYWhoF4n/B3JIea5iSRap/0AGTm6I0Q+m2zFIrPOYsYSj/dSQHq7R1OOp+LKzPhdvX4RcNNAHn0TVDByEFdZoHSO7aJa7gDZ/X9EW0gynNIPEZkov5fwx2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZkjomNiQTwE85wrS+r/oxinAA9saigLPDFapCHXMeY=;
 b=CNJT8Q4LY9QiPMggpSLNrSNEXkvIrZEiUrj0Dfc8xoh47upiC2Od68qhxdwU2URhvSjChfuPZU4iC3jE6MYbPViV6MnQ+M7knPBg9ZjKdZoTIKeb9SApa/OkeY8e1PFSUM2//6s+DKL2im2OBb9Zn84MpBktbpeJDtFD77y7TO3w9TgvyuvLlRP8Pn6WlUCy1MMKwyPlqsAKEbDXaTKWmBDWXe58LzUE32wFB1pJU0QsBuGBZ1YRUeSIsDdeI/gESk/sEvOvmZpXu96/ngjuBP245dExmQudmsrXM3DT3ZADWFCeaTSNx0SusZsdprcntlDhaMCKAqt7ww0Xnwvy9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10374.eurprd04.prod.outlook.com (2603:10a6:102:41e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 20:37:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 20:37:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v9 0/2] PCI: add enabe(disable)_device() hook for bridge
Date: Tue, 14 Jan 2025 15:37:07 -0500
Message-Id: <20250114-imx95_lut-v9-0-39f58dbed03a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPPKhmcC/23QTU7DMBAF4KtUXhM0nvFPzIp7IITs2KaWaFIlJ
 QqqenemRaI2YuHFs/y9kecsljSXtIin3VnMaS1LmUYO7mEnhr0f31NXImeBgAocmq4cNqffPj5
 PnRxMj4gJnFKC3x/nlMt263p55bwvy2mav27Vq7ze/teyyg66CINB6G0MPjyP2/FxmA7i2rFi5
 Qhqh+woGGVs8Jqcbx39OsmndsTOanCDCzytN61TdydB1k6xgxyz85iT1ap1unbNPM0up+AsZsq
 S/vzPVE72tTPsPDotg5dEyrbO3h0C1c7+7DMadISoU+v6yslmnz07TJYgYNI5Vu5yuXwDiMdiv
 igCAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736887043; l=5315;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YFwqA+lDO6liNzl/Cppqxu5pnux+mxu09eolNFJM2yc=;
 b=gnngkCdJE/vWLwcE2V17lB8tAw+S70Lzw/lEPHHf18btLytV/0JQRYfaQYky0eCFS4VxvI5Vb
 c8qSzXJ0gEPCBfIyjm1+D5fKKqZWhYrPT/ciLdug8dSlLYmkJTDR8cW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10374:EE_
X-MS-Office365-Filtering-Correlation-Id: 514c4376-3345-498e-8164-08dd34db4391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG9SSmZTNVYvTmtiaU1mM1IxM2lDN2ZkL1NqSjQva3hjblpMT1VLdTBTSmNP?=
 =?utf-8?B?dDlRdmJHd2dpQUdCRysyaG1lMVAwbzdmRnZBMHdvNVpjeExnNjZ0NENaWWpz?=
 =?utf-8?B?K2x2MHV4U2YwdjRBUWp6a0UrQkkxT2tlYjJ4aHNKeU53ZzNOWHhVcFd3TXdN?=
 =?utf-8?B?UUhTMnQyQjVNZmNZR21yR05QUHNkckxoWVBzdGdQVnNUSlNsdDBmbTR0cmNk?=
 =?utf-8?B?QVFKSDlpNWtCWjUyd3F3SjZBYnB2NDhJMFl3U1JueEZxR2VScHJZSlVsMnNs?=
 =?utf-8?B?Y3pTcytSM1RMa1lGVTRrTmdZOXRJYTlNQ001WGxmcXc0NjlPTVloeTFEUWFT?=
 =?utf-8?B?UVFDUEZ4K2pqeUlRSGwybjR5VzdDMnEvN05zUzVtdTYreWhZTDFlcDdnZS83?=
 =?utf-8?B?Z3BDMmhFQjRBN3FCZDhUbTE1blVoQmpaS0dHYktHWmdsNFFlWHJON29ZNDhh?=
 =?utf-8?B?cm5leDZVV1lkcGNyREcwbkVRR3luSHNYTFA4UGtHejFmWGdKY01PWmpBNFV0?=
 =?utf-8?B?RVlhWDJzMGc0TEpDdkJyeEJkVzRuOUhjM20zb2RRRnljVkkxVWljbWhqUk9k?=
 =?utf-8?B?TmFvbmI5VXVmazk5cnlNRkI2RTdTTGlMTEM3N2JkQzIrMzErOHBuakFFNGtJ?=
 =?utf-8?B?QS90NmYxeFk0S2pKWkEzdGtoZXRBQ3Fxd3dMemVIWWhrd0M2d3Vxd0pCYkpo?=
 =?utf-8?B?eTU1MG54OHZKYk41QnFrT3pVdEc5YXV6OTFidTBOb2ZnTWRUZHkyN0FPbDdw?=
 =?utf-8?B?QzE5RGx0WCtMdk53dnZscTgwWlR0anA3Nm1POEpjbG9YVGlMNnV0Q1JzVUt3?=
 =?utf-8?B?SUlrNHp0aXRBYUQwNmZJV09DbGYyenRZT1FwanAzbUo5V1RBdjVzRHRFb0pL?=
 =?utf-8?B?bG0xdmJVQkFrc1pnU25jdEk5d1lzbk9SOU1XREl1Q1JCYWYydEZoVXUrN1JE?=
 =?utf-8?B?OW1nOXlhT0Y4d3FjQzhLVjdGYkc2NkFxOXdjSkJjb1J0YVoyeGhnaHZ1N004?=
 =?utf-8?B?eHR6QTh2TFlaVzlxaTVRcXRoNVUraWJxdUNvVUpKbWZNUE1WUnhCMDN6cjJi?=
 =?utf-8?B?L2Z3QlQrMmdlMEZHem5JVnVKQXMyaDdMRVNOUUpEZzV5c2FjSElDcTZTTmNp?=
 =?utf-8?B?QS9zbXVBVGZnR2h4QXNsbG4vY1U0S1JnMnE3cWZoZlQvcDQrTzVzOGlFOVdJ?=
 =?utf-8?B?S1pkVVhjanRrN2JRak50VTd4djZ5cEtLRmZUYVIzNXhGdGFKc2xXTVF6V29W?=
 =?utf-8?B?N3VEcURPUnozaW9iSUdNQzlSSFVpUkUyUldsbzNlTGlLd0R3QkhaanhOWDhw?=
 =?utf-8?B?ajJhV0REWFU1aWlBaGFEMWlpTHZXSEhwNzZkcVBEVzJ2YVA3ZCt5VlVzVzhj?=
 =?utf-8?B?VEo5VTBEZVlWK3dwNW1MZTFHKyszczQ1Q3hCd0I2RTVUVDh0MG13TGlObzJq?=
 =?utf-8?B?N2RoNGxBSG0zY2VVY1I2N3N6bnRiU1paWmx2SUZ4ZUJveDNoaS9GQWVKUC9k?=
 =?utf-8?B?RjFpWHJ1cFFyNVZSMVJmSlQzeWRhUm8ybzMzbDZpZFJ5NW50OVFVTFA1czIx?=
 =?utf-8?B?UzBZaTZqNld0bG51V2o5OUlLZGlpQ0tBM241QnowUkROOUp5NlpGTzI4NWRM?=
 =?utf-8?B?TGhpMmREQVFmdm56N0VtWllMUEdkdnplYllqd0hKYmVRTUVtMnAzZzdHZCs2?=
 =?utf-8?B?SzdtVG9sZmhUNXByNUlTMWhnV2xnZ2lMNFk0K2VoeXZTMlhPTkhRQm42eUtn?=
 =?utf-8?B?MFhlZVhtUnQ0bExibVhleUowQ0R6MCtEeERaV3Bwa0thL1ZQakhsZUtTTTl3?=
 =?utf-8?B?SEwwVEI5MjhtbExDYmpibXl4TEpZWjNzMFE2QmNmOVcyV2hKWlp5S0g1MlpF?=
 =?utf-8?B?U2hRVzZSQ0lBNDMvZ3c5aXRuS3dJbDY5NDUvZzNjM25obksxZDFmaW9TUy9m?=
 =?utf-8?B?a1ZEZTk0bTdIL3hydHU1Tk5yVG9Yc2x6YWoyTVZESkNoeFFxLzRTSTBwQTVs?=
 =?utf-8?B?UW90SDhnN2VBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGg5VUNsTjhkbnBSK0lKS0c2Wk5hWVczWVZvN2xXVSsvM2xzNXZHSlZCQkNU?=
 =?utf-8?B?Ui9kT0Z6RC9XTVFmVHFWL1BjdXduRWc3RklpZXlZNlRVa25tZ2M2MTJnODBp?=
 =?utf-8?B?eFA1QmdCc3Z2QlM0NHFPcFpISmpkRHkzNW5EOTBVamM0N1BLa1hReWoyNGFR?=
 =?utf-8?B?OTA4RlFWQXkxbWFCSkZFT3ZkUHRGa0Z0bFoyeFZPTEVpcGNWUnNDdGRHV0Jl?=
 =?utf-8?B?bDJDWS93NEtVV0xjQUhHZ0hqMVNPWFQ3Vzlqa1VFU014TG5uaXJqVjc4K2lo?=
 =?utf-8?B?ZWdqL2pYS2t5bjZIUlJtYnk1VFdsSGlLOEg0cHFYd0o1amp5NERiSVNlNlU1?=
 =?utf-8?B?NEdNMDQvdVpYdHhkeG9FMXduQUZKUXpsWjBIMVZOSDR2TjRjM251dGF6bWpZ?=
 =?utf-8?B?Mkp5T0VaTEZnVmFXNnJuN0NOdWN2OG5Gd0x6djFmQW1RN0U4dko1NmVaQ0Vp?=
 =?utf-8?B?WlM5WXJrRXQ1UGovbzlBVWdNSEREQ2ZtR0JSeDR0QzE1WUtQYmg3eFRwb0NS?=
 =?utf-8?B?eWlOZnZRTVJmSmplbFhndnVBcEUvbE8vSExvUUI5ZHJGaUwzYVdoQ1dUR0Rm?=
 =?utf-8?B?K0xkR0tBVnJnaTAyT1JxQnpnUGtYc1FwK0xqbTlhREQ4bzFWL2dJNDJPNk5t?=
 =?utf-8?B?MWtHQWNONlhrZXZObUZubzhZTDMxU2RadkYzT0tYT2t1REQ3UDJTRDhYRmlR?=
 =?utf-8?B?THppUjdYWEVSelcza3E1NEI1R3hyWU10OUhKcENwRG5qbndzSG1TSmRudEl4?=
 =?utf-8?B?WnZSdGkvcHErei9EMXFvbXhyRHFuWlpiWnNVekRNKy9tYWllYmsrcFRkWmx0?=
 =?utf-8?B?VC9ITlAwa09FeGF4RmEvN0lQWG9SUDBLb3Vqa1hpaS9JK3NZemxOTjJrOWpi?=
 =?utf-8?B?d0prMWp0WTVaWFN4OXB1MjdGblVZMGNUTnNpNVpaMjJ5YTdnZ0pxTkx6cnhw?=
 =?utf-8?B?WmkybVI0SDRvSUVWOXhJWWp3MGRnd05QaXowYWpENTlLQkFkeklEK3o0MkxV?=
 =?utf-8?B?K3VIKzM1eElPQnN0RzBQQTdMWDV6R2lpU29uOUU3NmZTS3JoMjZjNjhGcVlX?=
 =?utf-8?B?WTdKSVZONVUySE9kQnh0dGI4WGdDb3BTKzZ5VGpqelZRN3hzeW9YSU5Wbi9R?=
 =?utf-8?B?Rmd0UzNtNVMxMzNYZTRQNE5iTUxjQlFkTXhDY2t0REkzS3RoRUNxVVhLMzh6?=
 =?utf-8?B?MldLZmxKVUpWZGNxRktNUW5tdXFKWFFvVU9uZ0pTZXJHV25SNHV3SGhYZmN3?=
 =?utf-8?B?a3JXZ2V1dTVxc1cyMnV1MlFpS0JpaC9JZE5JSGtFRzhBeUdRaHpuNUlZRjFB?=
 =?utf-8?B?ejhWdzNTTG16Y0hhMm1zQW1yazRtM3czT0dzRWwrQ3dGV1ZCNTNBOHhpbjVl?=
 =?utf-8?B?Yit4UU0xTGRoUFlBV0lHT204SkV3Q1NYcng1aENBK043VG5mZkxNS1BrOWdo?=
 =?utf-8?B?YXNtWXM5VnIrVm91b3l2R09LK2o4UitSdHhYQ01IK1crSHUxUDBBM2xDRTlT?=
 =?utf-8?B?L2l3UGl1NWVZN0JYdG00dzRPU1Y5RFZzUmNmc0NadVlWKy8wNTFYek42UXcz?=
 =?utf-8?B?SnpkTGZpd2g5bFNZU0Q0RHcydlg2QnhMVlBXUmsrOTFPMzBDdXN3ZXJWSmlF?=
 =?utf-8?B?TWhDanlJY0ZxUGRQdFFsR0IrMHExNnp5K3oxVDk4UUZkY2FXUWR3bFc3Skdl?=
 =?utf-8?B?cFVUcEJ4SDlIMXAxamp1Q1FDYTVnMFp2cC9KVzJ6eWZrVGhUTUtJeGRwVGJT?=
 =?utf-8?B?WHl6a0EyU1Job1NrbjNNbm5GTWRld3dFTUxKanhSY01yamRJOUYwQ0lJK3B3?=
 =?utf-8?B?Wm0yVlFla3ZMU3ErN2dxUTBFNVBCVjJhZkovVWg0eUtPY05IOTNMNzF1YU5B?=
 =?utf-8?B?S3dTeHlqbE9JZ0ZEcStsbWd0czdDWGIwN0JleUNEOTVpcVVTRW1MZnhGckt0?=
 =?utf-8?B?Ykw3NVBYZTJabS9ZU2ZZMHJGY0xPa0hWcnhMaUZITE9td2hWYmRnMGRDSXBO?=
 =?utf-8?B?a21xa0k5ZnJYR2tBYXhYL1BsU2xaSkY2M1NhQllwZUFnaFpRYWNYdDBZdDZ3?=
 =?utf-8?B?emNJakR5NlNsVGVTRFFsYnByVDZ2SHRIY2RRYU9sWTFFMzJUQjlOeEdZcTh2?=
 =?utf-8?Q?VVyw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514c4376-3345-498e-8164-08dd34db4391
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 20:37:29.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMWIAKNWa5Xr+V2sz+ULDa25OSuCV7LAFKbHA+tBabl5EZ4+5qqxKL/AyoxlCgS2ixaXohn0MEnRwU6KauOzjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10374

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
Changes in v9:
- update commit message and comments
- Rob agree use API to parse iommu-map and msi-map.
https://lore.kernel.org/imx/20250113225905.GA3325507-robh@kernel.org/
- Link to v8: https://lore.kernel.org/r/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com

Changes in v8:
- update comment message according to Lorenzo Pieralisi's suggestion.
- rework err target table
- improve err==0 && target ==NULL description, use 1:1 map RID to
stream ID.
- invalidate case -> unexisted case, never happen
- sid_i will not do mask, add comments said only MSI glue layer add
controller id.
- rework iommu map and msi map return value check logic according to
Lorenzo Pieralisi's suggestion
- Link to v7: https://lore.kernel.org/r/20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com

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

 drivers/pci/controller/dwc/pci-imx6.c | 199 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c                     |  36 +++++-
 include/linux/pci.h                   |   2 +
 3 files changed, 235 insertions(+), 2 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20240926-imx95_lut-1c68222e0944

Best regards,
---
Frank Li <Frank.Li@nxp.com>


