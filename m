Return-Path: <bpf+bounces-43789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D159B99CF
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 22:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33409283015
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356A31E285B;
	Fri,  1 Nov 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cj6PQfIV"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333F1E260F;
	Fri,  1 Nov 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495104; cv=fail; b=Ws11FtKCvtaTZQJeOV/mbZTMS5GnUNcHZipel0YdC3YHwpYy0w91PHiGTR3r6SIGJL8L+PBQ0S5+HBvQfQ9EEkplQsqjqnJY3y7lQvk/Ps4ordX5VBLEyVpNcIJu8eKEfLC9RyvbdCmIPIgMmEJ3hs9uxB0THFxYk6jnHB7Tb70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495104; c=relaxed/simple;
	bh=4p8lEaTgoJLNoLN5Blpp9G5ER+NKuLVgu/8fl9wrMng=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=nQOZKaZJCNt1LudqkSxs9BPlnN7PQL+du90XKi6hD3fpKc623R5EtMhAFohm8GQ45HimUwvboC1KJI9xxCc1IwitEGnzcIqGVPXO2flSaScK0Tohvr3FiwOBs5qg6eoZOv1ZN8BbDQGchBocYQq1lULEn86+U0a4WIZTR88witk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cj6PQfIV; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs4o+/Mt7Mfr89+HDdSdXukAUKr4sMQfWKvQaTYB6oqf/lE+EOQ4KM6Ucn05ptQU+or7PwcgBnJwi0MwCwzzbcyD/hCbQwfb59kHT1opqtmY4N8N3iOkpH1x7HA8Jke7eLK02L1omZeFcx+8R15cI94iPwm393Dj3pFhy0kQeRo/udvV77EDtsXE7R+be/OjIFxpdmR1GdyasEoaBLXw5w9MB+VLbSRAlCJIy/T1CEpZXwkYmOWJTIwNLizRpnFfffreNs/zewwAlFYJ6YNMkdXCfHhEl80yupag1rdrKASPHchiVXfq0CXdjWVlENOmEGUcNgYlomYGo6Bs7AgRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZaCV9fnw62B9gZxPc9IhfJqEzdCFKLJef6xlrBUrhQ=;
 b=W2jlGbYz0dKJwvDbvBurnP+ubMxnQ/buJtLhRadt8DG0MFYGaecnsq3y95JvAqtFfsfvUDyKrR1IRpjAt/MGentmHazKku+ofbTEy9uHbTTufMWIdybWv1T6/CCFdGzI2NPJ2ZR7a+WigyEV25+kdN1fX1ZeQWa0DYlhWaNyYi2MwU5YIUzDnRPYVyw88CzKo/8H4kS9lVKW7wFrHbboP/s4QuoM9Gy8ak3hWLyD+iPGbEI7EMEGreGs2g8VIxwRww9XTsJmBmEbTb6zL141EpQElfHLIu9MjLoIOpjhCmyALl6gfJCULfa9BduXeQGeSvwj2yJ58eNqIbA8MijnQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZaCV9fnw62B9gZxPc9IhfJqEzdCFKLJef6xlrBUrhQ=;
 b=cj6PQfIVXvqIoGYIElzpn4poX2DN3az9pP7Q2HvfI5+cZzu68PIxfkf86Dc8PBm/VHjEw3Fu2tMGb/QE9qTctT/S5iuuxChLh3yiwcqKO+8W5a2fL9/pK78xrUsp/Ml7zydg0IOT1ytj0SSwyNMxuEwihXu7KpZj+EFZ6Dc3OTwR647TWo93YXApGy2bCxl8FGZFo09A6qGhANjUwYUbr6WbURSENcW4hDuhbnTsTHJYqfQyhRIdjC9ipmEfrsb+M0DO0rin6+adjDWPG7m+YB1mxB0fuG2mpHt1NyngQeGG1SgDY8a03niQhXsjH5IYx2J+/d6DGmeSZqkcPDj2Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10502.eurprd04.prod.outlook.com (2603:10a6:102:44f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Fri, 1 Nov
 2024 21:04:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 21:04:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/2] PCI: add enabe(disable)_device() hook for bridge
Date: Fri, 01 Nov 2024 17:04:38 -0400
Message-Id: <20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGZCJWcC/23NTQ7CIBAF4KsY1mKmA6XFlfcwxgBFS2J/ApXUN
 L27tAutiYtZvMl8byYSrHc2kONuIt5GF1zXpsD3O2Jq1d4tdVXKBAE5SBTUNaPMr4/nQDMjSkS
 0IDkn6b739ubGtet8Sbl2Yej8a62O2bL91xIzCrQCIxDKotJKn9qxP5iuIUtHxI1jsHWYHNOCi
 0KrnEn169jHZWm2jiVX5CCN1OlbKb5unuc3e0JaMxABAAA=
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730495090; l=3682;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4p8lEaTgoJLNoLN5Blpp9G5ER+NKuLVgu/8fl9wrMng=;
 b=TNPZc196qUdgLUJgKgkVSKQN5ig+Qz+yTB6Nz4tWblFH909y4o/DmapJ0HcdQnynPvJuOt3m5
 JSxq7KIiibMBw3T90QG4xlwhestzQ0aFHacQR4iksoNDQVMxSY6YOpJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10502:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f858fe7-7152-4aa8-d94d-08dcfab8d6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWJObm9ETk5iMGVLWlV5ZC85czYzVUpUcC91ak5JWXJ5WGh2dElEUFpMUEt3?=
 =?utf-8?B?NmR3L0lXR0ZMWVpNRStzU1k5TTdrWFNOY0h1aXIyM1NGZzNHSktyb0dnSElL?=
 =?utf-8?B?clRRdnNyZG1EeTdyd1EzK05GS1hlUm90UldTTlh5ZE02dTloYmtRVk1Sd3hW?=
 =?utf-8?B?WUlJZlp6UGY4VmZEYXpPZzB4R3JpUHc4UUR5THZ5ZUlMWHY4SUNzdWVYK3Fs?=
 =?utf-8?B?NWNKNDZHTkRUMng2T3JyZkdJSWRnVFNaS0hkM0FGNnFuMFVkM2I3UkFDRUs4?=
 =?utf-8?B?RG5PWjdPOFVWNzl3Z1I5QTlJSGJ1aE1ta21ucFU4aW90elNuYjdMbVpGZGNW?=
 =?utf-8?B?bWtONS90RmtYdjltZGdqbHFHV2gxSHYrRHFHeTEzRGhzQ09lQWhuK3Exayti?=
 =?utf-8?B?ak9OVmpueEpjM2EyWUN6UVNONXg0ZU01VkloT3Ardm43aVZuWG9QMzFWWFNt?=
 =?utf-8?B?djNwYm5JVmI1UVN0Z0l6WEJMSVVib0tRQ0F1MUJkcEJXUU9CMFZOVG1NS3Vx?=
 =?utf-8?B?SE1NYTJTSWlsTTZ5bDJqMWFjRjdZcUdJTlc0QkZ1VTVxYVQyQnAvSnVRQkFB?=
 =?utf-8?B?MFNIWU41UVorZE9DWTJ2WFRPZTlOc1JDaEREMzlTQUM4YWdSNHl6NVF1cEZu?=
 =?utf-8?B?NU5wZ05sTHp5SCtYdFJPWStZcy9KNENyNm1wN1YwdzZDM05XTTB4Z096cDRq?=
 =?utf-8?B?NDc1dkM5THE0K3FrTDBxNEpIM1gvN3l3Q2h4RHhBTWRvd2ExMUx5RUxhMXlk?=
 =?utf-8?B?WTFPL3JNaE1yaWkzR0RIejZRODNrSWk2K2VQcS9xaHdPbHNYM2k1MXI4eVQy?=
 =?utf-8?B?ZjZYRGhwVXlYbjloZzdjbFBvUmlEV1hQb1MzZUZtSFkwZDlpS2I4TGhtQXJE?=
 =?utf-8?B?TUx6NGJGV3lpZzJ1N1FLWVhjVDFJeXhDTERZekxLVVpBL0UyUk9MRWdHK1ZE?=
 =?utf-8?B?ZFJ0b2p5WGdBM3dTSTFqWkpmUTczMXR5WmNXZ0NScFJKam5UZWFadHZyaUlN?=
 =?utf-8?B?VDUvNUd5dHFBd08rMlBoYUJFcHhZdFNFWUpOQjF2VlBqaFhWSU5jVm9TTThF?=
 =?utf-8?B?RUhlZVFmVDBQbXNUY2Y4YUlPcXJiUU1xSkFyMHROb1Bwc1J0MlhnWk5kT3F6?=
 =?utf-8?B?VFV2Yit1WUpMNVluS2NRNmVTZHlvN3hXblhaUG9Sbi9mNWlCWjI1NmlRYzhP?=
 =?utf-8?B?MUtZTDJpVFp4NWpZSk52SUpBWG10andlSi9wOUtnb1hwQzFySUUxSDlOWXdH?=
 =?utf-8?B?ZGxaNk9nUHBra2xKYmJDVjNMMCs4Q1N1Z1gyRVFWKzdDaitHVXZmUHRIV0lC?=
 =?utf-8?B?Z1RRY1pBTWFpRHdwMjF2bk9vYWduaDNMRkNHdGlxcDg0V2NReDhTU3pJemlN?=
 =?utf-8?B?anFEQkNQNFJmM2h3ZDdaT2JsRGlqM3dOc1RoZERDVGVCbGQrMDFQdzRYNTNq?=
 =?utf-8?B?dENIWWZDUXpzcVdRU3V1Nk1uM1g3dmxqSmRSNktJOUR5c1FzYUp3TE9vN3hu?=
 =?utf-8?B?TU4zRi93L0JGRDBNRUNONk5aQlQ5VUttbWgwUnh2R1kyaFl3Y2lSVXlFRXlq?=
 =?utf-8?B?RDY2TzVGYndONURic0s0ZUlZVmdZL2UwNlZ5Y3ZnYXhjSzlnd3IzM3JqeE9M?=
 =?utf-8?B?bE5mL1lCTzlMOE9CUDZsZXlGM20wTE9oSjJ4bGpLQUdqeEJPWW5JVG9PSU5z?=
 =?utf-8?B?eDNmWTZUaEo0YWJLeEJ5Nkk3MFQ3RVNoYjlLelAyN2graWJva2JiUzR3MElt?=
 =?utf-8?B?Y0ZFS1BZcENuYUt3Z3hqWmp6RUsyVUM1cmVQMGEzS3BHZStNb2ZoY3M1bzJH?=
 =?utf-8?B?QW9SN2ZvOWlxM3FRQ1l5SFVIUFFHQ0RjZWk1UzRicXlWYVM2dXd4azFlcUdK?=
 =?utf-8?B?OVBjaEo3MzRQaFdvQm5QTHlobUEzNE1WaElERktRVTVnbnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlJMU3VKSkpLQ1dvUG5KMm5LeXArR2Jra2l2aE9TT2dBY2FENXhmYzNIakkr?=
 =?utf-8?B?VjNHenRJS3FISmlQVGpBYmNhY28yQTR4MDZBNVJVeDhnRTFOQ1BnUWhlYkVz?=
 =?utf-8?B?ZmxnWTBkMDBYcCtud0VjYkIvaG1UM285OFdoL0xqQTV3Y2l6emhDYTJ6bTNZ?=
 =?utf-8?B?amRyYWp5elFhWlFFdmVMWkF2bFV0c1c4dy9sY1VFNzMybXdWRGcyMDA1TjFT?=
 =?utf-8?B?SlJNTEQ2ZmZxMmI5K3VGenVTUllmRWh6bnFuUUJNVzhnWWw5TEY3L1dzdW1X?=
 =?utf-8?B?KzZvVi9ndTlKUmNrZDF5VGlLNXdEVjROU2Rtajl2bTZrNE1QKytucTF3R2Yx?=
 =?utf-8?B?eFFON0ZFak5ENTNMVGxyaUVLN09tb3NVUC9sR2FTeHpsWktrdVVqbDVNbnZv?=
 =?utf-8?B?K3dxZHZDVTFPK1N3cURqSkpHNFVmSEFDYWwzaStBYXNIRHZEaDFCVGw1TnRU?=
 =?utf-8?B?SVd6ODZscjQxNVRIK1l3MzJ3NVVCSG1Fbzkwb0xHMll0RnpaOGNZYkVzQlZa?=
 =?utf-8?B?cU05bFNDVkRmZUMvTVNkcEtCdExxOXliZjNNeW1zZVVSbytsbGJ5ZTV5MFJZ?=
 =?utf-8?B?eVF6UElLMW9DUTE3Q3hRcm03b0dMRUEyeE12ckFzS0ozanp1dGttN3pZbWxP?=
 =?utf-8?B?ZUtoT3EvRE5tOTljSWZvN2pHUEtnblhOSmQ2NklMWENwRmt3L25pL0RkN0ti?=
 =?utf-8?B?OVpyay8vNGRxbUc3T0FuNHBCUXFUNksvMER6akhDK3ZXbUk1QVpvNHV2V2Zz?=
 =?utf-8?B?SzNjT0J2L0lyTTZwNzBVa3doVlFPbkJRaE1DeTl3bjUwT1VSRmZKTlFxU2dK?=
 =?utf-8?B?SVYvY1JBbXBKZWJwRnc2SGt2b2lRUVZxSlBySElBVm1JVW9iS3hyTVFudE5E?=
 =?utf-8?B?UXhKMWxmUWZsWW4xWVc4aGVKUmJsVi9oOHc5bUw2TXF3RFg3OERqN2srYXcv?=
 =?utf-8?B?b0t6WGZ1VEtJVWxVS2ZVN2prczJIZzlTaHcyVjhvNG1vZjJxQ3YrT1krZTJM?=
 =?utf-8?B?Sm5saS9wVngyZ2Y3eEU2WEg0WFJrWS82d0FPbzc3Ny9nbTFRZ0kwd3Z5aWlj?=
 =?utf-8?B?bmQ5K2pwYys5ZmwrM2plb21BdHVGUDIyY2lmcmZKcTlGSXU0b2g2alh2TEda?=
 =?utf-8?B?WG5HZFBSWTYzckxCOVlqZElpajVyTGl6V1ZjdTZobUc0Vnl6YmtTZ2RGZHI3?=
 =?utf-8?B?dytTbFNNSXNtUm05TW1CSDZHQ0FqbE1OdlhDZDFvajB5UG40ejBVMjNLVmFZ?=
 =?utf-8?B?cW1SYTA0eGQ5bFl3N1gwUzFjY3JhTWxRUCtnVVducE8yWG9rVEZwKzJFcU4z?=
 =?utf-8?B?VWVoNU81K0tpb3AvMEp4cFJ1cWkyNDRsLzNpdWRrelYvUWpyUWxxNHFHQ2Jh?=
 =?utf-8?B?TUg4VmNvZ3JiNWZGdE1kNjRsbStweHhoOUlEUDk5anNhelZCcXVlVHJkUEVo?=
 =?utf-8?B?bVM1YkM5RFpTRzJxeVVtV21PT2VUZDlaVWN0cGMwc0hpRTJHTGZDV1dSRTlj?=
 =?utf-8?B?K05pS1M3OC9YbGVpRE1YQnc5ZW50ZFhaMVMydnl4YWZQbTBrTWhFRml5R0lS?=
 =?utf-8?B?ZTBKZkloMTRqTURwYTE4ZytVM0hRd0QxOUFOdk12WXNQc1ZiMEc2dGVZQ1c1?=
 =?utf-8?B?NFVqVk51djUvWTIwQ0d0bDMxS2o1ajdxREJDQmU5d2JBTVdCYnNidVY3TFFP?=
 =?utf-8?B?QUpSZ0ZaWS9PVGQrZWxuSnJ6V2FDYmY4d0ZhbEZUMXdBNWdWb2FONXEvYXQr?=
 =?utf-8?B?WUxFWEJ1V2pnQzkrYWN0N2tnUVlUa2k3MGlhR2t0UGhzS0xxYXAyWFQweVBz?=
 =?utf-8?B?VGZjTDZKWGR1ZUNHajllOVFYS0s1RElvSXJIQU9wQWV2UUFQeTd4NUF0WjhD?=
 =?utf-8?B?RzZYUFZBUzdBUERsY2N3RlM0RXQ1Tnd4L0xFeDZHWWZhTHd4N2l0eUVteTdV?=
 =?utf-8?B?dFgrK3ZCS1Vwb3F6TmRaeUNEUXlCT2M0WTdHT1drN1hmSktZUjdOOVRUdlZx?=
 =?utf-8?B?SCtKTnB5TE1qYWNrekpGS2ZMVlhrcytZV0c4U2RrRkFhNTlpMFpVUUtLQ1pv?=
 =?utf-8?B?Z01uaEV3Z2Fob2dXWmZJUE1KRS84ckJuQzRnWkhMeHoxNmozZnRoanp1bTlr?=
 =?utf-8?Q?ZDkw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f858fe7-7152-4aa8-d94d-08dcfab8d6aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 21:04:56.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgKtz+IAIVZKpd0/jO0TDqos2Pkok6YxZLLSG3fBlyX06t6GLt3joy+HKgee6ThOUC5VooS61esiqavBvdoBGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10502

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

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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

 drivers/pci/controller/dwc/pci-imx6.c | 177 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c                     |  23 ++++-
 include/linux/pci.h                   |   2 +
 3 files changed, 200 insertions(+), 2 deletions(-)
---
base-commit: 9a6b4af5bc27c1d3e5dc9f7fb0edd26047bb74ed
change-id: 20240926-imx95_lut-1c68222e0944

Best regards,
---
Frank Li <Frank.Li@nxp.com>


