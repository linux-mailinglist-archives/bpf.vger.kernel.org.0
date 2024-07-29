Return-Path: <bpf+bounces-35929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF5293FF05
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E195AB22AC8
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989018C348;
	Mon, 29 Jul 2024 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BDQXh7Br"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF518A955;
	Mon, 29 Jul 2024 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284340; cv=fail; b=Zpk8KiDPwnr6ScERhYvOPqbcpWyz5v6Co1a7zYg+a6nASKwc8bjHLMsntq5uQo0wbQhtCkWVwJvr4a04jq6GnXDA/2WblIfuw//KO3+hP7qBhcH/cnpJSjrUYWqy1EYgoOCb9dbRaddii+007h3lwdZbPjo0INLT88eJL7gDdHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284340; c=relaxed/simple;
	bh=hpqdEP5Pgr9uYqW28LwRsva5OMhbbRtNGQBvj6M+tnI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BdTF5Pg7FA4Ee/EP2n9l378nEZvnRAsa9jcrAISP5X4/F2h8yd2qWDYPf/gtvIs/nBgLe48mkQafIh7ZqJkbDsnLQsbIHQZjSf9cjo3pwOYr9rHN0XlFUeecaYR4VgXPoipJVxWfA/hEyhCuZMA7474gUY/HBwGyI6EQYFkXIz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BDQXh7Br; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCmn3G3K3bfAlEB1RDyL8Y2NfWl/ubgGotUXEy3Y+21Ou/W6YfWHxGXbC+E9gr7pUNryMZKPywfeEmFIWq7Qjx9sGC/lPwzswXucWAhcR4VaD81TMYe5eZezgMR0iU5eUwXEbdwx6yBbiVd35zKlEHFJbzN48HopktWsi/mp62EKKdN8pBj+6i0bTETMTXyNYjqhC+PmR7cKicXbF1e1qcAQ0ElhHhTIY4ZBFaFoerVBFUyx9P6sk+uq/1kXEIAJVB4qwkzio3389T7P5ZcUhhPouHAwPUEn6GmgoT1NQGyv1AGdl1wTOHKO6Bzbt7CtvOGRPPjW54/n8QCUbFIYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mXPAqxzgD3DfLhd10Jz2h/StlIoB396o6udlgnSLuQ=;
 b=ZQFtbSqCf7w05w5oND7Of1QEoc/0JH8+NkfiplHxXikM+qnSAUazFKGI4NsuHghLiSpVCuogjfJu64PZejqpsO4BVlYpmqRrrQnO/FS4EdlyMoNbL9MExklP86XDZXCufNw6dvqnz+F3UyYt8VtNNlFaLyOGJ/KFuigOGuNYAcIn5tvVqazOoJlf5D0oLfysipnCaQ4GOf4YmyfuTdHNXpRNkgmB/pKfzYI+VDaLzSSnxlTZtLWivdFvNvpn1WX7cG+mdUnn+TyKMxCrItzsfYhA7kYEw9q4F/CX88vtMuw9PxQ/nSIuIcfZnJ/vwmrskPL5n1SySqIe6dorHzL31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mXPAqxzgD3DfLhd10Jz2h/StlIoB396o6udlgnSLuQ=;
 b=BDQXh7BrglETCVkHbH/QDi9fsb8gKxPhPkdQULuwCXXQgDvuAWIPvz4ku/Fe8iqVSmaxEQuOe9Vx+4R8bYhtC8kS8IXspAY+4RHw3c4HEyhQP2w0HoMeYsFEGhU1ance+I5twl+OlqWoxLbXhiqRJ8QLx52GaPPzkLSfkDAP3ajFVs2C/Z34c6NgJGMkyrNPpC9pXM4r5/ronPHEvKyvtxO0r9EtafQ1sg2fhQDj4rVUbYQJNBLw0aZftn5vg9BV0nx5hNFi0JMKsGykzzc5valRsb1AYjlfTIpmPJJlc8NrnxOOvBLpeQ7P8Ib3J9U6SILgqvPKXn8gQzldmXePUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10240.eurprd04.prod.outlook.com (2603:10a6:102:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 20:18:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 20:18:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 16:18:09 -0400
Subject: [PATCH v8 02/11] PCI: imx6: Fix i.MX8MP PCIe EP's occasional
 failure to trigger MSI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-pci2_upstream-v8-2-b68ee5ef2b4d@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722284317; l=1387;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=M9wO2WI/42fd1UXuH4/xq4IS1t8W2AIoBjreaGqLJqo=;
 b=btyzVEu7eaMJllA91jP4QDpf7klL334SGxCNLum/F0kgX2SlLLsuNDQMFG+NJe+YA087prVZT
 UqcnjwRTM4UDkK7+igOUT/VELY8DefnOToZbQ+36udd6REe1zac1i+S
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10240:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a63c99e-4139-4e55-ebd7-08dcb00babaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGtjMU5jOTh6UFFBWVdBK1Z4cW91eXlxaU9LNXVidEROZnZPQlJaaTYxQ2JW?=
 =?utf-8?B?THRNUC9hVnowRC9TSlcxVUR2RENpRW5HWVB0VWF3MnZ2VWgxOFg1dkhFNTlZ?=
 =?utf-8?B?WGdKWUNaaU9VUmYrbEhJdTNoQ1g2dmdnakFCMVRRdEZBOU9kTUdZZUZlVncx?=
 =?utf-8?B?OS9NQzkvTnZHYWRaQkRkdUp1dlM5SlZ4VUllUUFVaXllL1o5WWFtWkNNS21x?=
 =?utf-8?B?dWZiaWZoOTFUNFhsY202Q2o1RWw2VjlFUzVDMjMwdzFVenAxdmN1eVg3MEs2?=
 =?utf-8?B?U01WblRBTUwrdDBCcmdDNmdSSHp1SUtiY3lROHZaUnNnV1h4aC9YK210eW9P?=
 =?utf-8?B?R3EzNGppZU1qeThwMnY4SDRRNU1OODZBWkVuaTRUd20vak1wTUxGMXJZV3BK?=
 =?utf-8?B?T2w1aFQxdGtRSElUelFINW5ZR2dCRGJHZDVqRzRwVC9nMnNkdFFsUlVuMVNI?=
 =?utf-8?B?aDY2ZDM5Y1NyZVVBZWtJdHUrQTR2Wk14bEdXMUgyN20xeS96T1hCS3k1VS9J?=
 =?utf-8?B?QmFHaDlnM1Vnd2JGck5McjZlT0tXSExSSGlMYzFoZ2Q1VmJrRU9FSDBOYzBE?=
 =?utf-8?B?a0FkZkx1aXNaWEZhRS9mdzVTMnhXYTF1WEM1eTM1VEpqdStxejdnQ2RCZDc0?=
 =?utf-8?B?aGlhRGkzWmhkd1BOZHdITE10UDN0UVJqcGlOWEptQUpMUnRCZEtsNnNudFZP?=
 =?utf-8?B?ZERxbys5SXJtNW0rLzRNdCtmdXBJa2JqZHRReGxKYlhaM2hRNnRMZU4zakNZ?=
 =?utf-8?B?UzI3NnFEUSs4Zk5IMjA1OGsvckNEWDVmczlDSHpiVXpJK1ROUUZpT1l3cEla?=
 =?utf-8?B?ZDIwRVNNWHdtdCt6SlQyYmFOZ2RsZmlRNjJCMWZKRlpLeTI0WUF3T0VYMGtC?=
 =?utf-8?B?OTF2Rk0rTXlIWG5oZ3FPcXFiTDE2MGFWUHM4MURPcks3bzNXNzJqVm1nM25a?=
 =?utf-8?B?U1ZHa2FCUDJMVllyQVZVenY2TGloeTVyRTNFNHpOdW83bWZ4dWhmeHNROEkx?=
 =?utf-8?B?TFYzWVJzZXRlaWxmU3l1cWZXN1VPZW5KNGVrZVBGQjdrNnoyU1hubHEzd1Yr?=
 =?utf-8?B?ckgrVlRiTXowYUFkL3IxNm52d2lzRG54QUdtdUpzU2krRHFISkIvdXFWYmFz?=
 =?utf-8?B?L3JHQ1ViekZvckJJZ01NeUJmQnExWFFrZ2locUgxSWxXdE1jNlNMRERXdWRo?=
 =?utf-8?B?V3FBK3VucmRPK3N2Si91RStuS1dQbkdDUllqMDZ3TDNwZ25YemJJTjkvSWhp?=
 =?utf-8?B?TGpmZTE1Y1RUL1Jvd1AyeG5yZkVDTGdPSE9hTGttWGNNalo2WW9LM2pJQThk?=
 =?utf-8?B?OW94ZkYrVklhTGtHcFBUeG1DclhWZzhUbE1zV3U2OGlpK1ZTMkhiVzd0ZXNW?=
 =?utf-8?B?TjB4SEw1ZmNJZlY5ZjBIWlVmTk5OY2krU0t3L0pIb0xsN1BDZVNuT3hDQlJD?=
 =?utf-8?B?d0R1MklQc1BrQm16SU4yRWJkSXpNb0lGRFFHL242WDFFSHVNdldRM0lRK3Ir?=
 =?utf-8?B?VUVZVGVydmNvN2U2RjVuZ1B4bXVGMmhldVFQZ0hYRkluZ0JKM0s3MW9CTzB2?=
 =?utf-8?B?STJUSTlxYTgvMVd4UkJIOTBPWGREZGp2eDFJeXJNaW5UQmdlQ0lpS0kxakF5?=
 =?utf-8?B?NXVicFZkY2gzbmJraVJMOS9RdXdleXgxS1FuTTlndjRjajcxc3VWcnljM2Q0?=
 =?utf-8?B?T1lXalFvZ1RmanlXWTlpaEtsRnFiVlRHYjhiS2hBV29vSlZDSnFlQmZuem5l?=
 =?utf-8?B?MlBSNGd2Zk5xQ1hQR1YrdnN2S2VTakhCZG5VOUhBM1llc3R5VmZ1NWd2NDRh?=
 =?utf-8?B?K0lFYjdtdFlXTmpJd1pPeVppSDlydVpTOHA5SDNGdURIZUVwb0d5d2F5Vktw?=
 =?utf-8?B?VTg3b1RndEZ5RGhlRk1GTGRLOUVmQXUyYldDblBNT3BtMkhaSFNTbVdFdnNr?=
 =?utf-8?Q?1h6Rs9WGN2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmVKUTNLN3A4M285MytRNzlsKzZONE5EQ1NGNmhHOC9FZWdRYWJXZmdZemZ5?=
 =?utf-8?B?amYxaGw0aTZROTlZQllhS3ZDOTFJVkt4Rk85UXZTSWp1dzB1aHlsblViUVlS?=
 =?utf-8?B?S1lHM1Nqck0vKzJYS0RsN09ueFBza1ZLRTVsYXhJUWJPS3dhMkM4Q05DQlVo?=
 =?utf-8?B?YWRGMytGY3UrZnV3L0JxT2tBQzZzVVAweC9zdnl3elhMaDBIVWFIWFVFU3NB?=
 =?utf-8?B?T2VIaEFvSVl4MEM0ZDdTS09PM1NUd0czdlBmd2lNTmxxaldBTldpbmZGMVd1?=
 =?utf-8?B?d3hmbXpONERzYm5BZmdHNlZ3c1EvTHB4b084VnFnaGpKSmlZV2QvL1IvUUlh?=
 =?utf-8?B?VTFHNHJWWlNyU2kyZ0ZVYXI0QktRT3hmUHBYSi9DMFZNS0cyb0J4dUd5cWhx?=
 =?utf-8?B?RU1GZDJLVzlrbDR6V0tEUXY4dytSbUtxUmR1WEJwdEFLTlg0Y0p4ZisvODdU?=
 =?utf-8?B?ait6VUxBQ0RZaUtJcm14MVl0VmNWTCt5Yy9FQVZZdUw4T2NmVTZXc2UrcW9W?=
 =?utf-8?B?QTJCOUc3MytqRjRIVFl2Rm50OEo4WEV2enErRVB2RXhYVDFVTFgxVkxOMjZy?=
 =?utf-8?B?U25PSWlmbUNLRDBNcHpFNTdyVXhZNXdHYWtUbVdXc2RDelRDUXduY2YrZEhY?=
 =?utf-8?B?WENnYlJ5MUk3Nys4ejY5NnNiTXlHRGZYMGl6M21ab1NlZFo5QmZyY01PT2hG?=
 =?utf-8?B?T25MKzZTVzJHTktZQnc0aGVXdmRJSGZCMHRaMVBDQkRkdzVUZHhjcmRJZm9G?=
 =?utf-8?B?QnF3TzVnbDc1M1JQM1BhTE5iTG9IZGJtSW5iT3J6UGJ2bjNsZ2h6M2JnTkU0?=
 =?utf-8?B?eWxWdHBMQ2wyZlI5RDRSNjNoTWdpTzd1TTVxLzNESCtuNGlkRmJ1a3FEdHFu?=
 =?utf-8?B?SEw1TmJGdllkYmVrQUtIYWFtdVJTTCtvZUtEN084dEwxaGZid3pPWVdQYkdI?=
 =?utf-8?B?SmQ1UUd5NTNXU1M2RC90ck5RMkRjUmpwemNZdnl5SmdOV1JjaDNmUVdLVzRI?=
 =?utf-8?B?ZTg2RzZwTzI4dHZCa2tiMWpwaXdHNFhHTlo5UktjRUlhOFU5QmdGcW5DZVNt?=
 =?utf-8?B?aVlBelBXSGFVVjZ5QjFIQWZEdnNGVm1oNHA5NG9SVkVZZ2g1UDliVmpoTjBB?=
 =?utf-8?B?UTBySU1GQVNXL05Mazc1d0ZyTmw4ZU9ubk1FSXB4RXcyVE5GQlBqajQ3TFlR?=
 =?utf-8?B?RTdXVmZpNDhvandKQ0kzbzVSOGNueWJjWDB6K1NDOGhkQ2JNRlFLVXBXVXI3?=
 =?utf-8?B?dlJDZTgwTzBQYkpwYVFjRkxxbTRwcm1ScDNMTHpzNXFPUWFyRXQzaHF3TUNi?=
 =?utf-8?B?cGVjRk13ZmJPR3YzazlKZEVBandRT1BVdHljUE0yUXpHVEhrMnB1dkxiSVlS?=
 =?utf-8?B?Y3MyZzNleU0zNm0rSUZESWZRQkszbmVPUWsxTklpaXBmWDgvYmdiTFRwZTEy?=
 =?utf-8?B?MXoyWTAxNWhmQzVlZ3RkS2JGT3F2VXpiVEJEbWZ4MW4xZHBlV1hrWUI1NzU0?=
 =?utf-8?B?OGRMRmpRSVhkWk12QkxINGlsNTlzM2s3eVRzVjk4TUZidy9CeUU3dlI2UlIw?=
 =?utf-8?B?UEpQdWh6eUQ1b1pkcCtWTnhVM011YU5ua2VRSmJ1a0krb0ZyY3VpRWoxaWZX?=
 =?utf-8?B?dWlDS0lEeW5VM2sramJCeVVpTHp1WklaS3hxeHF6T2dJdGxlME13Q2dQWm15?=
 =?utf-8?B?T1d4UXNkWklDV1h1K0k3N1ZkRjlyMHV0R0E2T2hBTGVJU0dtdnZpL3pUK2h2?=
 =?utf-8?B?ZEg5N2hTcVFHRHlzekZYTzZ6ek9XdFhKd2FWWE0xZ29kcjRWa0lva2FPbk04?=
 =?utf-8?B?WlFuUHg1bzI4alNrbStWQTlJaDNQL21KT1dWU2hQczZBRXI1R3RZNzZYZFBh?=
 =?utf-8?B?eHpnc3JFYUU4eU9qUi9qU3FXd1FhajIrV0NuaFVqdWtMaWNtVTZNZEJFdjI2?=
 =?utf-8?B?c3RmTFY4RXVTbG5UL2hwNFh6OERMVkVYdUtxeGd4Z3JQQ3N6alg5L0xDS0ZW?=
 =?utf-8?B?bHcyaDcrb2Rob1J5UDljdFdXRWZ0Q1FlQnFveFJBbkdqcHAvSHBXaEs2eTc0?=
 =?utf-8?B?VlJHWU1YTzRNYTR3bi9RcU1UUUJ0YzNtMzgxN1V1Q1lPVXhHckkvUml6YVV4?=
 =?utf-8?Q?ASj6p6KSV/g6dteBcKT4sMhpa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a63c99e-4139-4e55-ebd7-08dcb00babaf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:18:55.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zwchzj6z3QDQDnCAYqv5bPv7XPb8pPB9N6PMHxDFCagMKTfIOO8JtYjE4vKfTX05iqH7XTrOOuniE+DukQpU5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10240

From: Richard Zhu <hongxing.zhu@nxp.com>

Correct occasional MSI triggering failures in i.MX8MP PCIe EP by applying
the correct hardware outbound alignment requirement.

The i.MX platform has a restriction about outbound address translation. The
pci-epc-mem uses page_size to manage it. Set the correct page_size for i.MX
platform to meet the hardware requirement, which is the same as inbound
address alignment. Align it with epc_features::align.

Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 42fd17fbadfa5..3b739aa7c5166 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1113,6 +1113,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
+	ep->page_size = imx6_pcie->drvdata->epc_features->align;
+
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");

-- 
2.34.1


