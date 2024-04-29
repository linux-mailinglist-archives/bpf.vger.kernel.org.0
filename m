Return-Path: <bpf+bounces-28114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AC08B5E62
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7F11F2205A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C2685634;
	Mon, 29 Apr 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WjNBopH0"
X-Original-To: bpf@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD261839F1;
	Mon, 29 Apr 2024 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406325; cv=fail; b=jo/R0O6tCGOBr2+GwX3C9uUM7aKlCOmBJ0LeoDOIbTtk36Q5BHPckIYPnGXtEqhCYKxtOqpofvfU5OKvB7J3GmY0jXHFbZUo0bppTuFNj9a9y1WjENnTORdC0QQ0MBRMJDqmIdi+F6ciFONE07P1wj4nEZufnzFejyBLlYrGQac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406325; c=relaxed/simple;
	bh=wfLNholRfd5FiolFlawOQRgB6En09HWf2FQDj64KN+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hzPtWIJj2b72vU048lZjTCtDaipMsNLPRql6Bi+sZpElIpJn22oPvculLO3FeuRoQigLoGuu5kEUpqeztElBZ4/6QZ+b0ZL0vibnCvuEqcn0752PT/lj0xV4UDG/r28y3K9HKkgtbsbYA8VR6r7aYxuABS6JvD7UsH3eBr5bjFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WjNBopH0; arc=fail smtp.client-ip=40.107.14.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfcLJldZ5ApfKPTgSfdOxdohEz4C765oGhe/WBfAJXBnvR79T6FpqBVuhbKxYtf+P9WqWoyCrY1rJ7AhBRV3vP9+vYgkjQkrLAHVHFWBpF+NZIB5SnR9XHFkHmlvdW68XHuyAJqOGgjN67JJ41r9BCJrvW74E8by0iTf09fse8545pAQNN7rbUavO/GXVYcXujDYu8ZCV66odlu9jlE75UAG50A+itlut0qkyMD3uIiAtjqYiMDrDd+re29W4EbPEziao98HgVEqHkNHPrUY1xjBoQr5hCq7e9ICYjcu1yn9koXL/w68EY4CvraFY0Al7Pq0DENkMj9xLzft2SoY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5M353EzOKgI20Bw1YibZxDlrPVV163IfBhednIpD+DI=;
 b=Ywnbz9y+3DuYt9+Kxml7p76sTDU9XUEaTd5kBK0dDzs+LpUw9wjQtvPlN/yDzl6qt6DIPGYdrMw13AQ2cMWVhjdnJGmzOwD1PLEaQzbIDAdMQIb70fSHhE3OMMQtXB0zq9leFm3TxnX7qs+tByqGI0apPiN/haVdK/qthLK/xFoaQPykqglx5fiYia1cRTNXkYY1H9RDAuDbBOJ3NtsiMAz6Ufi4iKPffr0eFoWBy+X+MCm9CicIE1YgDgaWTKu9ZhtPOWP0t1K+pQV7QbVHJa6VcGRObQzRjoGJu6WJyt8xcNMGygX1Zqtldim+ZVqqHwzY+RLe2FHT5YmPNRZ1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5M353EzOKgI20Bw1YibZxDlrPVV163IfBhednIpD+DI=;
 b=WjNBopH0FF8Zp9bSyiAdSVKH6i7rj/FT7ABaoJUNnEuviP4MA6iDBaRifLOFMw6pHmdXXqFbGQM6nOy00qyhAJrCUi1c6pJgsKvtDckCn98+DwWnzwxDpEFHAUWZBQGYhIUDP7R3Zr5986hmEtv4lfwH73NPko/+LzBIsTcMnnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:58:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 15:58:39 +0000
Date: Mon, 29 Apr 2024 11:58:28 -0400
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
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v3 02/11] PCI: imx6: Fix i.MX8MP PCIe EP can not trigger
 MSI
Message-ID: <Zi/DpIhGN3lAZhG0@lizhi-Precision-Tower-5810>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-2-803414bdb430@nxp.com>
 <20240427092303.GG1981@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240427092303.GG1981@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f4d3cf-9378-4468-18e5-08dc68653c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STkxOFVLY0JtMHdjREVKTFJNVDR3N2RNTm1DVVh2MlBsSVlTSUorekloUWJO?=
 =?utf-8?B?bkZ5RVNMb0pMbXJ5TkZ2amRST3JmZW1wUjBUY3Z4WlUydFRDYWNvQUY0ZGRn?=
 =?utf-8?B?citaRmIxQWdiMDN2ZjBkVEY0YkRmZGdKNXpjbnZLd1c2WlRJU1Vna0FoZFFr?=
 =?utf-8?B?ZDhBSFJ4TGx3WTNIVEZIQ1RXQlUwTXhIY242ODczN3RPbXQ5MkYwc0htcHAy?=
 =?utf-8?B?bGpQSHpTVElqK0tkbWhDWmhSZjJXVkZRd3dYZHRuZ1N4UmRWK244dTBqclli?=
 =?utf-8?B?My9oSUloZE9sZEJzcnAzSEJBNTNGTTNjaFg0Wk5JU3FBVXJHQUxPenBsTWxF?=
 =?utf-8?B?MkREZUJhTUZOdXhXbmVNdFJEYW9CTXdQYUNtd0ZHZ28yVEM1RTBLRlR4eE9o?=
 =?utf-8?B?TURzSDJ1UWZreVpBODk0ekFRa09VV3VMNStKUEhKcUFtRFp1U2xFckxJS2tL?=
 =?utf-8?B?dGhrd0dXNUpqMStvbXhCYU82Zk5oeDRDUXdGdnIrWitxd016WDY4cWhpcTNX?=
 =?utf-8?B?Wm9kbUYrdDFxWGd5Q1JsaDBuaGlkRVZ1cXdTSGVtQVZER3U3RU1VWElBZTF5?=
 =?utf-8?B?ZjNWWkNTSHJpd2F2cTljZ2ZCNGM1Z29EN284dVpXY0taOTJvejNZejRIV0g0?=
 =?utf-8?B?YmtKTWZxQlFNdU90anhlNkEzYmpvZGlaZE9tSjhTWFIvVzhqbVlPQk1RRHRW?=
 =?utf-8?B?cnJTN1cvT1pLQ1NzUlhGYXFPYlBMaFdacVhxVEZsVmsySnV2eGU5N3pCelhw?=
 =?utf-8?B?b1JxZjdGWHZCdUY4NkhKTHAwZTFvNTk1UW9WQ1Y0dlhTNWRER3ZHSjlKTlR0?=
 =?utf-8?B?dStmaHlwLyszaHFUNXNIbndkdFErQTNJMnd5WmZ1SjZkN2l4bS94TThWUW03?=
 =?utf-8?B?R0RFd2hFOENRQWpTY09pcHZaS0QzZmRqa1FUNHRUUzY0NGZ1aWVsSnBQb0l1?=
 =?utf-8?B?U2pPRXZVMWRoMWZuVTBuQzdXVkxDY2hkVVoydGZvUEcydDNFY3prN0cvWkF3?=
 =?utf-8?B?UkMzVzI4UGdiNFZUVWl1a2FWcEsrTGpieklzWkhIUzZaL2tURFpla3JkR0ds?=
 =?utf-8?B?UjdvbzZYdi9WSEwxYnNIRTdyTzZGeEhmdlZMUy9CdURTRjhTU3RnVUhhdFVF?=
 =?utf-8?B?VDV5M20vM1R4WWZKQmNsQmQwNDJYOUF5Wk1Eck1VN0VtRmlaZTNrdjBBelE2?=
 =?utf-8?B?VzhSRlh2dzllcVRjMjV4eUF4dE1YQ0pwbVl5MGUxdmx2TmJESUZlK1V3T2M3?=
 =?utf-8?B?MGcyTzNFVWFRZlZhVGthcjFDWXRXTk9VRmI1ZTYwRDJXcG5BdHJwYjlOeXdv?=
 =?utf-8?B?SG9DdUFlM3VYMkhkcnl6L3MyaXFpOVY2ZWlGRkVQdndjTi9oVmhybFE2cDR0?=
 =?utf-8?B?WVk4SHpKTjBteDFsKzdFcXZIUUZOZmxpcUltTUZ1cWt0T2psY1BJTkh5Kzl2?=
 =?utf-8?B?QnFySWNqdmtWVHluT1pweXpXQ2hqaDBRRW15UXhldGZnaGcwcTQ3RXk1SkVs?=
 =?utf-8?B?TGRkSHQ0dlgrNFZhcEVtNWVjallTTEN5S1hMeGEya2tCOXd4RThLUURYczlW?=
 =?utf-8?B?WlphOGV0VjM2ZnovdUpaL1BGeG1keUtTbFQweDJLb1h1WUJSYkhnd1BBc0JN?=
 =?utf-8?B?RTJYemtCaEl6UC9VODYrTlVOYWdpTjV5MFpyMUJRTThQMG9MSTN5eU4zWVhY?=
 =?utf-8?B?YkZXaDUxQldURnR3ZlAxbXlWWVJXdk1nR3g4THJpV255UXA0OVFvUnZhMGZD?=
 =?utf-8?B?UE9wK2ZJdjkwU1RLZFkrc0c3MUlROXlpK3M0SHhXcnJNZGxJMlZPZXRLRDRD?=
 =?utf-8?B?cDFmbnZYVy9IcS9iL2o1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z25hazNGdWl1WlhMVHlGSm5McnIrdW55WkZONlRFUFY5alNkckd3aGsvNHU2?=
 =?utf-8?B?R0dwZGxtTmZXRjZpYTEvNUFqb2hBWFY2c1QwelZjM0pNWXJ6anRBd2swZFgx?=
 =?utf-8?B?QVhITkdYNUhmck5sN2U3VEdjenJhbDh6YkJ2SnZzVUY5SEh4Mk9FbjRzMFRh?=
 =?utf-8?B?aDJ1NkkvMzJIWEppS3NORVZycU95NGp3cGswU3dRanY5U3lDaERrNEVBL3dp?=
 =?utf-8?B?NnYzd2Ntdmd2LzFKTlVBKytTV0dxQ1AzOXdRSGsxVWozbEtmbmQyVXlMVnVX?=
 =?utf-8?B?WHhmREpKK29XUERBNng0bkNnZ1A4c3l3MWlRMGNyL2lpaU1Gb0tEZDY0MS9y?=
 =?utf-8?B?SFI4TVYybkJnRzVJSGsraS9TMFp4Ui9mZzNKZFFienJBVzVOdkZsVkx6Mk9o?=
 =?utf-8?B?ZEZWTXB5dXQ2d0FMVTJURGNWRzRTTUhJc2FLbEg5RjdWTTNJUTRZMnRDNG4r?=
 =?utf-8?B?cEFManhHRWl6Y25IR2ZLWTBsSGVHMHZNUzVjYllUWldlbjY5d1RidTErZks5?=
 =?utf-8?B?MzdrMDdicmRmQjRYa094REgwRUdaMEE5TndLZm9GeEltbU1RWTVrT3Z5N25O?=
 =?utf-8?B?UDNacGlCMHdZRTZMMkx0ampPSWtubDZydWJVR3ZHSUROVGlxeGVrR0R6NjJW?=
 =?utf-8?B?d0daUXo0NXVrMHZOZnZDYldxYzRWRm1wR2xRLzMrQmYwUXhWT1hwNTJjVnRW?=
 =?utf-8?B?WHBnWUNGVXc0dG5NaXFBWlp4eFNTOEltVEw4UG5ySkVzL3Y4dmJSenRlTmMr?=
 =?utf-8?B?SmpDenVKM2lWNHhXYTQ2ejgrOGNZbXJDOEpkTUlTUWVNMFhiMFMrUmF3d09I?=
 =?utf-8?B?VTFZVUN1V0VlZDF4SVMyTDhIaHVoUHNBVGROSFNEQ0RYZjhtV2pleHBtM29a?=
 =?utf-8?B?dTQ1MTc1Z0RIa25na2Vvcmo4TzZDUU9Xcm9wKy96TzdtK1JKWEdwZVlFRVZp?=
 =?utf-8?B?WXFQdm1XRitiUXk2c0g4N0pSZFF4WnJXQmF5b0JOYWVzVGxwY1NLQnRlZkVC?=
 =?utf-8?B?SFBnc3JzQWF2cm9jYUY5VFIxckhJRGR3c2pFRTgyeUJ1VXFPdW9LS2RHamEr?=
 =?utf-8?B?RG1RWXF4OVkveUJ5N2RxWTlCTkxpazJjUE1QM3hYL0paL3hHY3paN05ZR0tI?=
 =?utf-8?B?VHBkZUM4TEZobHFtSmlEdnVETnZmdnNLT1kvUFIyMkV6ZERBdWtRQTlCcUo3?=
 =?utf-8?B?UEU4VDczTnl6eUtQVnJNMlZHdXQrQU1vMnhyWTcxZVMrZmhXSHRxOUdPN2FJ?=
 =?utf-8?B?b0IxV09vdTFrRGZpaGYvWC9ranlLUWt4UFVDK2ZTMVNQaVZkVGdmcGlxTjlG?=
 =?utf-8?B?U2ltamd5S1NGMW5JemM3T3IxOXAzbmx3UG4rUHV2R0FTankyUXJ6UTNrV3JK?=
 =?utf-8?B?L2g1d2p3ZkwyM1NTSkQ2OWJWbnBVM1pTelVScWpDTzdmVzQzY05kTDdZdGxV?=
 =?utf-8?B?bnBlYVdiQjYwOWZWU3p3TkROTG1XVVRLZ0pFL0RxRk9MY0xUYXJROVgrajh0?=
 =?utf-8?B?K253N1Z3N2JYWU9BUVFLVWRQZE1qdDZDTTBDcEhFY0JHYUw3dXRDUUJ5Zmdv?=
 =?utf-8?B?VUFJL0RROEUwbzgyNUx4cmpNUnBCL0dKa2hxVER2T1F4amJ0VGovUXRqdm4w?=
 =?utf-8?B?RnBadWM3UUNCU0RnY3JneEw5U0NmZGUxSjNnU3dHbHN6dUxTRmp4R3FVNU9r?=
 =?utf-8?B?N0tsanYyeEt0THM2UXVFOUlBRE00UjVDbXAydmdUYWNzRmhnOUcxaktNMXln?=
 =?utf-8?B?Q3dEa0FoUzR6bU1VcmpSSGxFbzZBSXBjRERzY2xDeHpoSFdvUXpoeFJISDVz?=
 =?utf-8?B?RmdVVStldHhpZnNkQXVlWjczajhFcFFBVmlIZVQ3NUNqOUlqaG8wQ0ZIMzNQ?=
 =?utf-8?B?dU1pc1p2bmM4YTh1SEROalZlbXRZVy82VHVtR2tjYmNwNENNeWMwcXJ1Yjdp?=
 =?utf-8?B?YkkxYXBBRTlNdHZPU0gxOE9NdUkrZFVJeXQ4L04wbjRJcjFGaXJjR1BhNDNS?=
 =?utf-8?B?M1pndzZaU28zWUo1eTBhamgvNmw0a1Rxd2FWTVprMHRmdWxHQ3JFWFZzWW5z?=
 =?utf-8?B?WWNiVmlIVHl4V1Fja0o3eFVVVUU1aEYwckN3d1c1TGJ3emtYOXE4Y3QxbDRz?=
 =?utf-8?Q?wVdkNdOluGMjr72VwMcjTJov8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f4d3cf-9378-4468-18e5-08dc68653c5a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:58:39.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WNVhAlEBmrA+UMCtiUPM55zWdy3MiVZgt/JkdonnevIQ7t/xSbrhTCk/36Z8OwCNk/TVIuutBSsV7Za13v3vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

On Sat, Apr 27, 2024 at 02:53:03PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 02, 2024 at 10:33:38AM -0400, Frank Li wrote:
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> > 
> > Fix i.MX8MP PCIe EP can't trigger MSI issue.
> > There is one 64Kbytes minimal requirement on i.MX8M PCIe outbound
> > region configuration.
> > 
> > EP uses Bar0 to set the outboud region to configure the MSI setting.
> 
> I don't understand this statement. How EP can use BAR0 for MSI? MSIs are
> triggered using outbound window memory while BARs are mapped as inbound.
> 
> - Mani

Let's rewrite commit message. 

PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI

i.MX8MP PCIe EP requires 64KB alignment. MSI triggering may fail if the
outbound MSI memory region (ep->msi_mem) is not aligned to 64KB.

In dw_pcie_ep_init():

ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
				     epc->mem->window.page_size);

Set ep->page_size to match drvdata::epc_features::align since different
SOCs have different alignment requirements.

Frank

> 
> > Set the page_size to "epc_features->align" to meet the requirement,
> > let the MSI can be triggered successfully.
> > 
> > Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index e43eda6b33ca7..6c4d25b92225e 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1118,6 +1118,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
> >  	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
> >  		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> >  
> > +	ep->page_size = imx6_pcie->drvdata->epc_features->align;
> > +
> >  	ret = dw_pcie_ep_init(ep);
> >  	if (ret) {
> >  		dev_err(dev, "failed to initialize endpoint\n");
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

