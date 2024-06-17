Return-Path: <bpf+bounces-32334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 127C690BBDB
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D171C239C9
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C8319885F;
	Mon, 17 Jun 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iT90QTp0"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFEE19938A;
	Mon, 17 Jun 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655448; cv=fail; b=u9M4bFj9bUZ7nbNSukt6ACoMOreNl6UOk/oA5CAFS6Lv5SMDWiqFF82jbyctalFBZOmDx9XvSCuhQG+Pp9Pf6rzsY3pH7SwfjnVgOQxA0liGprmNibYRK2ssZYh//FXq5rrDf8azqlPOfiUGaNNITlyU2ZjRVRMbUWVcEMrQip0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655448; c=relaxed/simple;
	bh=EHyeS3eCsKTVfj4EEn10/36Iugqdn8KqQ8XKGyRIeGQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VXKi8cd1RM+7rBM2fm0Bkr5zVR+nH9ArcBcuGxd1Iy3jn2OT2pB4cYaSDZc5AHSBF0uWX2B0ix58zHh6MHw49MdSO+mDxyO5pcC3Mb55lRGk3Zx+Z2IIzLHsPOV9C3zBm9ra+bOVAZNwcSxjDdiq4Ha9HBM6s2X9wweU/5PYJO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iT90QTp0; arc=fail smtp.client-ip=40.107.103.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtaGXGO7AXZ1qVpYGELaYIdiG5O1O9/XyFZekMXA+iocJ+S8sz6pW0P6K5DNfd+00ulDUQd+yTina8sGa58PNRk1/UUs27AJmS+vHnD5hYL0KFKYfdIc8zaJ7OFw7XM9vzf1wMMtQbMA6bJc+W0pSeFULNYDJpqgw2Q2FkRJYMfLJkzhw/S1pS3vmbwv1CP51JTWUmQF+Z5tsucredKzrxEiQL715eAlLvC4i/x3+sDVHgGTp/NcUzohsFMH+9joWIfOy0fap9TSCHbEQ9k+bVXVXtm6pe/wCSqlWtKDcguhM7cxA/NC2eDlma8Vv9yQYtlQqlw3o7VRRdUO6J9XvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUBWGHoGKaKMGJh9TkXeHEMhc07ASjRiTyfpTUk9/iE=;
 b=co3b64GE7AU3c7ps5rF2QuGN3yD+Kk64xy1heqXsBXdnhGEtRL6+NWVIopk4QaPiwlTfEleKJ0UPYuj43bAt9dbuYGDUIScjkoZo7FyyIW6scN0hhWQ711eBuEsFVBbLOzeCSld/CvnMLpHUxAGPo8AYeRcFh1sYJjw4eVqf9AEhHQRNMUdlQqAgPvMadbQm2GdWkzdEg/akb4DZZtybXWIIR1/uUIVA7lBhICjkh24dTdk1NY7BQKkqQTOKCH8QiDWlfDc2oiv1/ihDCn5A+nPHaLT1w9lXZtkBRXrc6WjaiZcEHtMA84ddjgmuAdsrd3WNzTeregBYDkLYcFLDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUBWGHoGKaKMGJh9TkXeHEMhc07ASjRiTyfpTUk9/iE=;
 b=iT90QTp0PGvsvqG5erjGy4z+8ck7NmSENIH2zoV+oDQRLL64M/VohzD4kGlPFnNDtWJ+uiVVTOnNKhueIA2te0yTA314ML/KcBZ+u+MaRi02mK1fUiNqLFGMHmzhrNf85AL4wVNltwDlWwPzUxnO46wbM/q0NvPce4CezS0mi3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:17:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 20:17:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 17 Jun 2024 16:16:38 -0400
Subject: [PATCH v6 02/10] PCI: imx6: Fix i.MX8MP PCIe EP's occasional
 failure to trigger MSI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-pci2_upstream-v6-2-e0821238f997@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718655424; l=1357;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0tg9I2bqWF9gd4zcaTOgOiV9PwF7bz2gPmS25zNUpq8=;
 b=icFYh2KCatik2YOeIh6B5e1BgU8Dz5wLHv0lscwqBENs3K3lUYYsTOO1g40PbcGJKFNGyBzrt
 foV+BgSiXYnBXDfeLPGP2+eswK4O5iPCG5aB5pHu0qtojZVDS+3SBfg
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
X-MS-Office365-Filtering-Correlation-Id: fa98ef6b-76e5-48c7-0327-08dc8f0a7f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|52116011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVQ1SjdzUXVlVTI1Wml3UVM0STRXUk5pYWo0MVhtczdJTDdnVnZ1VkhZSlFy?=
 =?utf-8?B?TkIzRWc0RGtsMmRiVlZIUUtYTVV3ZUpNVXV4WHQzNlNXWXNzWjFUUFh0VGpW?=
 =?utf-8?B?djFQYVc0SW5mMEttK3dlOURza1FQd2UwcUJ5bTl5ZzFSRlpLQmRIVW5tcGFK?=
 =?utf-8?B?dkptV282TEJLczhMWDBwTVcyK1FlY3pvYmg2U2NhT1NJamIwNWJPUU52Qk5i?=
 =?utf-8?B?M3hkeUYwSE5JQmRMWVpwc2Q1elp1TXk5NU4zak9QQ0NxTGw4QjByaXMzL1RQ?=
 =?utf-8?B?MEQ2MXZTMHFraEFXRzl1dUljWTBUT0U2ZG90aDViZU9yV1ZYaWlIV0RKbHYy?=
 =?utf-8?B?d3p2WHNGczFxbFZCdHNXQkk5dHNuZFpqNE9BWXY5bmhZcmlLOGNrTkpvd3R0?=
 =?utf-8?B?eEIrOGRydVVsZjBYaU5ZTGlFOGxKMXBFMzRJcUlSZG50MlVDMVZ4WUluNXlV?=
 =?utf-8?B?SGlicHBHYkdZRXBvYVMyWXhhdXVOMmNxUU92RzZpMzhKV2JjenNPNzBBbjQ2?=
 =?utf-8?B?Ykd4S2wwSTRubUs0OCtXSFNzeEx2TFVOUFQ5VjhqN1NmUUtDVGJicTZKUGUv?=
 =?utf-8?B?RTdIQjRiNlorc2IyMThnR2RHS29Ga2V1YVNxdVpuWXlTa0RPRHdKVlJ4Q3U1?=
 =?utf-8?B?dGFCekticVNKNUVQc0poUUdhQXdTT1F1eUtVTUluWjd0ZXBNNjQwbURWMitu?=
 =?utf-8?B?OHJkT2RHYkhwWlpLYkpPV1FXMXYwUkowOGgybjE3MDMwQmlqR2VxT0dSWnZq?=
 =?utf-8?B?RFVpbjJReUhvR0plZWs3MGd2eU1TbzlSOHp0Vm9hb1BYUTIwKzVNeXY1N01K?=
 =?utf-8?B?eGVWM2QydDBydFNZdThIaXFmQjd5OHBXWVZ2b0ZCNk1BV0hYTzV0N0hwcWhR?=
 =?utf-8?B?KzFFUW1TVlZwdFplUTRBNzhnSWJlS2hDUnZ0RHZHeTBKU21JYlhuU1NhcnZp?=
 =?utf-8?B?YW1UMy9kYnhSeXplVUNBZitBdy9GcVFPY0NuQnovcDNPM0pZajJIU1dJOUpv?=
 =?utf-8?B?c1lDa0Y1VWprRUNGb0N3RVNCTnQvNk1UV1dCRjNoMlZWaXRlc0JpVlI5dWhy?=
 =?utf-8?B?cHlxL202dDJrZkNXZkxrRUEzbUJJeFJGMnVNUUxTZ2RVcXJheldZRzQyU1VW?=
 =?utf-8?B?VGRyQWVLVjFubm1MS2E0eVp4SWkwMEJVK2RrV09ZeUo0cnVQVE9xL0MwcWk3?=
 =?utf-8?B?cHVyVytFWCs3MW5WZjVsWk4xVnlrVEZNZmczZnVTN2tSS3ZaTlF3d0Q1QU1k?=
 =?utf-8?B?OTJMcTRNOWQ5dGFEb2NmYVVncWR4bGFTb252WER1NUlaTjU0OC85K3NuSzRh?=
 =?utf-8?B?SkM0cE1URkc0U1h3eXFxYWVwdTlKUUVCZng3SldXNXk2TXpBSDY4RFdkRjY5?=
 =?utf-8?B?NWtjRWFsbndDTFI0bmdtVWk2WThLS1BhN1czTGM3UmFZMlZFTXVaV2xkM2x4?=
 =?utf-8?B?a2l5ZS91cFpQUkFTUm1MYlNaakpLVStETWFheXVDYXgzc1N4WGdNSEo0a212?=
 =?utf-8?B?QXYzYnJiNDR5MWRSeUQxTVgvbUJkLzFIZ09IRXlHZjcreGhtUWNOalZpVytH?=
 =?utf-8?B?MHhyNmhNVDBTL3QyeWtEOENCTnUzUzF1N01TTitqeCt3MmQrd1lZbXFkbmNG?=
 =?utf-8?B?dlA2WXpxSW9TWkpmME9BcklLdUw5MUhlaklRY1ZtK1pxenNnbStQQXNUNHJG?=
 =?utf-8?B?WDVvcVoyUTBBQUc1SW5IU1dSc3RuQlhnQlBEZnAyM01KTVVtcWFYd0RnNmdD?=
 =?utf-8?B?Y0hHdjQ4d2VpOGNCeGxJZmtYV2g4QW1pcUloMHl1eFlFNjdjUkI4Zk5scHlo?=
 =?utf-8?B?QjZOY1Bhd1RuUmZadUpSbHp5TVBDbVgyZVp0ZkhqTGZ1c1FlM3grZkZaWnUy?=
 =?utf-8?Q?CNeWM/UiYvkeO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(52116011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm1jS3JESUI0cG1aaEQyZExYRCtsdVdBOWlQb1NrQzBVTFBFNDZlZzJYaUxx?=
 =?utf-8?B?ZUhHSnV2VHBDeGlvME5YU1pwVllKQnRPMm1CNUx4TStoczBpU0x0b3BhMUFD?=
 =?utf-8?B?dUQ2bFlKRTd1aUR3M1J6bE1Gek1meEVMa25PYUV3MzltdFJ3SmhSVVZJL2l6?=
 =?utf-8?B?amw0WEdRL0xQam42V2NkUFUvY2FiYnViYndCUVdScmxzYnE5R1FLcGluanFY?=
 =?utf-8?B?RGpqa3c2M3Z0RlBCRE5jUEc3ZldWdnNIbU5wbjBSTllkY0RIS1FPS0NWV1ZC?=
 =?utf-8?B?VnBVQzJBN3V5TDVURHhUY3djbWxHM1BnRi83SzZvL3NPaVptS0FDL0hqTTNj?=
 =?utf-8?B?QjBIOE1oMEhMWkQ4cEJPc2dWd1pxeDJrTitXY3VKSmZ1MURBeVNjek9IbEg3?=
 =?utf-8?B?V3FMV3NaT29jenhVQjQyVmtKWDlxd2l6bzhTNFRGMFFHdytKaTlKN2owZTN5?=
 =?utf-8?B?VmdoclhCZVRkcXZKbFVMcEhSbU9rMDJBN2kwZEk3RFVHdU5LODdWQXZKdHFH?=
 =?utf-8?B?OWxqNFpZMGc5a0Q3REFJWlBsMm5wVnVsSXJHOENiMFJka1JJTS9WNEF0NnBG?=
 =?utf-8?B?cFVVNVN3SE9HcWdud2RCVi93ZC94cFJZcjB2c0ZtdElBaEZjeGpUSXU2NG5o?=
 =?utf-8?B?UXVCR0F5UXhCbk9nWkhWaWJLTDM5VFIvSVJ2Y1MwZ1l3bWUzaCsyU3JaM244?=
 =?utf-8?B?RU1ZR1RvakZaaWNwV2RuZ3M0RnZKSEhpbmtQeVovWEE0WDZFQVhyQ3FXd0w5?=
 =?utf-8?B?YjRKdW50dzRxdVdRemN1cTgzNWlOUWZaWjVhRW1mZUx5MjhSSWN6eVhMR2Mr?=
 =?utf-8?B?dk0zaysvWFRVTXB1N1lPdSt2OVNZUjVkUmU0THJQLytBS1l3MktraVdIU3pR?=
 =?utf-8?B?UnZoeEtzWUdZZEZHOTcyaTJDUFBtZmZhbHNUUXZJYTU5VkZnTENXWS8wdXlh?=
 =?utf-8?B?d3ZGTVVsV3RWT0pMOWtPTkJUN1FuQ1N1Sy9BdTIrVHdQaHcrb0g5UDZBbkRo?=
 =?utf-8?B?U3F4Rk1ZRFdLMTR0L1g5NFVydi9WU1UvbThJZjNxQ0lRamF4akdYOFQwemFj?=
 =?utf-8?B?ZG5Ic0NXZ0NqM1oweURyL0N0Q3NnVmlRSzZleXduOGt6QUs1SlE5c1U1cmtG?=
 =?utf-8?B?NkJKUUhVQ0NTVnFBdnNQTXpqSDJadnVrVk1nTWp5cFhGa3JmTW4yb3ZuV2hL?=
 =?utf-8?B?cWkyMVZoZE4vUDd4N1ozZFdXTVBuZzk1NWVYTEM0b28wZTFzL29saUtrQ1F4?=
 =?utf-8?B?OXBzczVNZ1I0YStuZU1zM3hSTWI5bFZ2OWZuaTJIb2dZZjlSSDhCSi9GbHMr?=
 =?utf-8?B?Q25DWTF2WTF4R1YraDUvTXNjWFZObXl1Si9uV1FhM0pRNTNNUEJ0ZUEra3Np?=
 =?utf-8?B?dk5FUktpSEdteVpFYkZzS3NmOE1LRTdaMmtnU1MxdzBKU0NGeTg2ekVPNzF5?=
 =?utf-8?B?aGtBYzlxYjFTQis1dk1wU3dMVHdUNHJRNTEvV1pnWHkrRzhoZnVNeWhsUlZp?=
 =?utf-8?B?QlFCeGxNbHB3dUxqZnlVdUZXeWUvZVkvQ2Q1Ulgyck9UeDk4Z01ERVB3MUta?=
 =?utf-8?B?RkJ1WnZaNXcyOGRaZnU1Uk50bkdyeU1vcGpCdjU4ZVFPNm9zR0gwV1l5c3dq?=
 =?utf-8?B?VFBqWjNlRFNPeitWdloxaC9ydjVUVTdTWDZod3dUKzVWaWhjcGk0cTNBalRY?=
 =?utf-8?B?UXB0dm85eVcvNmFVQ0N6cWRRejA3OW5PTy82QmMzVmRxazZBTnlHU0J6MTUx?=
 =?utf-8?B?bzBHb0Z3czQxV1I3VlVWMzJwSXp4cmEva3RRWnFZdEZHUVVxVFowc0FxYTBN?=
 =?utf-8?B?b2I2SDgwVWZkb2kyWFNwM3cxa3VjSUVDZVJYc1JPSzdhOE1XaTlLckZ1Y2Jv?=
 =?utf-8?B?eldlM3hUTmxEMExaTHpEMkpHeDMydzhKVmhKVVRRa2xMT2JVRlJaNldJVHhZ?=
 =?utf-8?B?Wm11NGxtSFByRk1tZlg1Q2NISnZtQks1S2NBOWwvRmZzU1Jka2Q4bGxWRGRT?=
 =?utf-8?B?UExSR0R3RHpRN04ybW5GbTQ5eTNSM01TcEttTzJOQ3J6ditNZVZvRXNiUU9y?=
 =?utf-8?B?VDc5UGxheTNXSHYzVEJrdEdYMHhZY3R6dUxoUlpVRjlCMGR2T0phVWJyQlU4?=
 =?utf-8?Q?Gh+Xh8dQGk5ocjnajwSM/k3+Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa98ef6b-76e5-48c7-0327-08dc8f0a7f67
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:17:23.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdTRYRJPlmPW1+Y3MR6cdqeo3pxcwZXY37Jq6XlcIv056HNJHxtkGJdHtEidak2aWvkf2SMN6q2mQJdw9dJlfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

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
index 9a71b8aa09b3c..ca9a000c9a96d 100644
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


