Return-Path: <bpf+bounces-28931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDBD8BEBCD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EEF28635F
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD4216F296;
	Tue,  7 May 2024 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VbFJIgtf"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02816F293;
	Tue,  7 May 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107624; cv=fail; b=tLHaxGJ1CdBN2b31KF5Wk4ZxpXJ4KgnYcZdQsAxvBQ83NnweoM5uBGqows4yF8VZfRGifCFnktf4Z4yC5SAs9pnBurqwcZHhALB8eldpFQOUw52pw8/4tnfZNx3fJ7zVMC0kWe9IppBIAr9/70dJVGjHhONLsM5i2/2QacERn/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107624; c=relaxed/simple;
	bh=fRuAnexzFcdciFfcdAEZxW1Yau8j1A65EcffAYhydkg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cURfM1nFjsugAQIdpFkxQDnQltrkyTxQ29KlNf97JBxcEm2z5BACgipvvJRGDJEJCvELjN6nQ5xo8WqyeJ3PiDerLhL7TEcBlkMn+wgoUobv+ygqo0e73FPTjc4z89F9OK1+YHaPXRSYs2AAHQs/kmFf98bP+2sWveYf8gOC6eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VbFJIgtf; arc=fail smtp.client-ip=40.107.8.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gay4YOq0YjuUS26IcPIf3HDtwjKXyzNsRrazs5XWZ/Aj9U0AH+Glyuq5o7rIBC4iF8GapKK9zdjen8qCAEzaX292F7+vnu1nWz7c1ZJU1fnNLoN5DNkW8GQ+W2Pk58B4tp/Pw4t3zIh5gR7SA7v0ioonTsc6eeYoWuw3MKVwyQ2JsvLa6xoejIt857pcBJyJ5YeCJzfKjCaeLgqHdjwogRrEX2UYnu5HmoEjokFeqhxb5O4sC/D8cF10jVkZ9a+hECCeDTEt7KRXgK3KckLC4PoxXPwx5+frr5Ehuu8JgIdHd6P5MCeIKa6wsBA/yfmt507aaM4qgLmG7NahvRv8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3hLRtu6tlq4CUbpU2aouIFuo+Jil+5bWfaulAUHiw8=;
 b=OXF97OIAwyKj/qFsv7TF6dmx7Bthn2Xf+/iWd+sIzmcoPNF+ZvPRHCZe0GbMEakxgxhJOcT5cIjZpRmoGDmK6BmyPrPyw/oOszQ2XugCh5HQRybhZa5vufpUe61mEbQN1YXSEFzxdk39hDc6LjpuEkSeHw3MLDJLv4kF7FMB+moEE3VueAVfhOrsyCxIS3pS5lkripigaBzITH5kUx3gwQREZ5qwW8+B4mRDQx1xoMe3yT8Bqf1vNrnhqslsVJ0yJHFp3NHUQ2ASXC+QjdWR/JL3/gn37hZ0G6PaJQPaVU8eDujNYB7rzP8x4Owj6qt+Ja9AOrwApipUm6kfiYTFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3hLRtu6tlq4CUbpU2aouIFuo+Jil+5bWfaulAUHiw8=;
 b=VbFJIgtfeatXeQJkNCBu/BJpzB8hQik3CsFqy7Bfe5debo2P68reGUI/Y8tX+0iNHBFZNRwMxBwjbNuw3N1FAljHLUbUR1r8mJMsmQFSIYVg38Xps0/AyKq5AftYsMTC3KXI8ogGwBkjfYQMVAP6n24+WElItL7qP3Fqsk2MUVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:46:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:46:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 May 2024 14:45:45 -0400
Subject: [PATCH v4 07/12] PCI: imx6: Add help function
 imx_pcie_match_device()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-pci2_upstream-v4-7-e8c80d874057@nxp.com>
References: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
In-Reply-To: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=1526;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fRuAnexzFcdciFfcdAEZxW1Yau8j1A65EcffAYhydkg=;
 b=3YVnuaByILStdkLLA+qLb8m/jl0Ys3Esr56UQFrMbjUc1CPdSlChVR5pnQ8FAP07s7WOxK2KU
 H0G5o2iU/gsBz0ZKjM153QM8huItXIre0UgtwS4oPNLhrHg9M2WpD7Q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3c31d0-1b84-47c8-883c-08dc6ec613e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NENSZHlRS0Y1QXFVSEZPVlB3bHJnSUNiSHlXbDhzMVl3WVRXeVdZb2JtTHhD?=
 =?utf-8?B?YlBxaGR5bTdjZ29ZbkRaMkdxRG1PTFFEc0NuR1NqRXBkSHRNUjk5NHQ2R1Z4?=
 =?utf-8?B?ZkZJU3BVcDNDRkRxbE4rc2FVc0VydXB4a0RRb2hqbG1wMlB0azBxSnRBMVJy?=
 =?utf-8?B?WHUrV2dqaWZ4cFdONGo0cGFVREZ6V25YVTUvV0lCRmMrYllFVkNYdFhrNXY4?=
 =?utf-8?B?RmNHYVM5MWwzcUp0aWVpUEpIdE5velUxeE9ucUxZeGR4KzNqbnVjdUNVaXlk?=
 =?utf-8?B?V0FxZlFWdnhUL1pTNjBseExOd0JCaWNRbWp0cGJGVlE4UHM0NnY0NXN3ODFW?=
 =?utf-8?B?MGZveXoyY3gwaThWWFpJR2NzZHk1aFZWOWRaQ2k0KzhwYUxYZm9RMnNYNnRY?=
 =?utf-8?B?dGVRanZWalVIdUd6Z3JuVDVOdUpGbWpXSGp1NlhVcU5pTi9oSkFqQ2pmWjhl?=
 =?utf-8?B?R2RyNmdNMWUreWlIRGU3R0Z1Z1dzSnlrQm0vS0w3bzQ5TWNFcit4YnppN0hW?=
 =?utf-8?B?eFJybjBGWENsNHhZc0VGclltcEc3THJXYngwUi9BaUlua0pxRElKQWhORFUy?=
 =?utf-8?B?TWlQcnFwcjQ3MTBDNHU0d3cwc0VKSEcxbmR5OTBET0IySXhNVEJzVjJqMFhj?=
 =?utf-8?B?QzZjWk5HclFKMnE1ZFRadFZqenBZeTBqeHFBbjEzOGllSi9TSHlzdEZkVEto?=
 =?utf-8?B?TWlOVk1rMXRsOXBPVzJueGhjZHFCQkpqd2ovNXZyWTdraS81YmMyc1lOajJH?=
 =?utf-8?B?eE53UWJFc3JJU0E1bFdBSVBNcHNVRkV5Z0llZWhkSVB0RzZSYm1CcTVGSzdB?=
 =?utf-8?B?K2EzYzY4U1VKenNBaFVGWXVZWXBTT1dyRnVZU01aSFZnSXovU1dBalV4NUtF?=
 =?utf-8?B?a3NzOHZ4VVlKVHpBMFFQSnpaUVgwRjRWSm9QdjlhWk1mZzl4eGtqTXB2ck93?=
 =?utf-8?B?eExCcElQdXpESzV1ZUR5QkNXNnkvRXdvRE14YnBtcEg4QkdrRm8xR0k1Skp5?=
 =?utf-8?B?YlRpV3UyajNVdSswTExwbTVDQVNsL3hkbGYxaThUdFh5SnBwamZwa1hoTjZq?=
 =?utf-8?B?bysxbTBnRStmR0JPbFlPYWprUTZOVTJzL2V4bUVvdnJBQThMZ2Nkb1dmMjh4?=
 =?utf-8?B?OW4zUEl4MW83VWVMSlRKSUdNSEpaZG4xUksrY3BlZ2VVcFc2TGFLK2I4VlZF?=
 =?utf-8?B?VkhPRDZvYzFTUHJTdDEvSGJFZTJzeW04Y0ovUmszMDFOVXdpeW1pVnRyamVz?=
 =?utf-8?B?d0crQnRrMmlPOEFqVUhjdFlGN1l5bGRkZ3RFQ0R4Tm9OZ1lqM09UZXdiV2l3?=
 =?utf-8?B?bllCSVZhbEVobjh1NEFUYnBZejlSaWFKSTJBK0cvdDFUWmNLcjFWb1ExMW9M?=
 =?utf-8?B?U0hDQTJEdDR3L0RzbzVVdmhqYlN5UE5GTHE5M2hrSXFOZ1p0Q2lYdDRuZFRE?=
 =?utf-8?B?WmNEVFhtSFJLRWdLbFZyeU81V2JkUW5pNWdTdU1wR1ZGZG9LRGY4Rnd2dS9W?=
 =?utf-8?B?UTBBTXc0dWJ0WkNuQWZHa2FGNFg0ZklUSm1aOXVlNEN6QlZUeUd0NzMrWmJy?=
 =?utf-8?B?RXlsVU1FTVQ0YTVTRGllUzRLaXA4TVZBUUxiZDZLZWpMdGt0eDJsSkY1Uk11?=
 =?utf-8?B?Z3RKU0w4R2RhbDRiRWtWcUVWbkxpUXFjV1BKdE4yRVZSQWRYQ2ZBS1hIT2hz?=
 =?utf-8?B?SXhMV1JvYmR5QjY0ZE9GY3dTQjh3YXdTR3BBVjZhUTMrY3hxcmlCeVJEWnpO?=
 =?utf-8?B?U0xJZEhhZmNlc2dzdG1GSjgyNDJoN2s1UVd4ZEVVNE9PR3MzU2JxRlgySE5j?=
 =?utf-8?Q?eqOGLSQ6Y2YYkADVrFAp6vVntyWnDrzQGL0v0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGc0bWJ6TUJJZ05zZzVDVzA1ZVYzT3dPdzlnUzdDM1hTUkU2bjBDYW1JOGhl?=
 =?utf-8?B?L0JwUXdJK2Uzbkx6ZE1PRWlxM1ErdW10OUVURk5vQUV4UmhTcFlCSTVHVXhQ?=
 =?utf-8?B?OXdkKzNwaEtCTklWNTRJNFBYWUtvdmhiaUFnK0pCcVlPaHg5K3pOaGZkTC9K?=
 =?utf-8?B?ZUpRY2V0U3RrYVBUNUhMeGNTbU5ZNi85aHVsY1E3NjRtM2pEMjFyNkw3RWFk?=
 =?utf-8?B?elV3VS9DZjd2ZmUxSktnTHIyZlNRWVZ3ZE9rQTFIbENobHREYXVRLzM4LzNL?=
 =?utf-8?B?YWMwcFljeU1tdmtTUzNoREtPSnVSanJBeUVTSEZ5aFIza1JkZllPRFhIdlc3?=
 =?utf-8?B?NXpxdmlrMGdnUElTbHh6Tzhsd3hsdlVVbGhiNklobCtmSk1KblpiSWxweEhv?=
 =?utf-8?B?MjV4VGhqanlWc0w2Z25CNnk4M24zZm5MTldwb1EvdjVMUkc3aGZORFc0aXBn?=
 =?utf-8?B?SkdpeVg4eXJFTndWbVBUWUowMWFhYjRmc1ZIN1dlSk9UU2lOSDRUQmVSbjYw?=
 =?utf-8?B?ZjhESVB0Q0M1cDhPenEyWW1xYllyWWMvQ2diY3JXU2pRb3JpbU8wbHRRWXd3?=
 =?utf-8?B?WkJmcnkweUo1bzZxcVVRNjF0dSsvaU1TSlpOVGcrMFY0VnVxUjdzL3lGSlYz?=
 =?utf-8?B?SjRMQVBkNlZ2Vy81OGVZRWdlaTh4QzJrZ2lwak9FV25RNXhxZUk5bko3OEYv?=
 =?utf-8?B?WTRPc0pSVVpCMFV5Wm1wNDB6S0JidmFsRXZNZUd1K3NMbDJkVGRnUU9iNDhS?=
 =?utf-8?B?K2dJTzlvcWp1amlYVlBMRko3QXRoMHg3eWxLS1hpdmx0bXNLekZjcGlrOW01?=
 =?utf-8?B?S3FyQWZyZmIzWU15T0kvN0thNFNHSncxYmtpZ25hVEtaNTJvV3pxLzBFcWFk?=
 =?utf-8?B?b2ZTaFgveVlKOHB0QTRxTW5paitxdHA5ZUZ0cDM0WWFGc0t4aCtZMXNPcDBm?=
 =?utf-8?B?SkttMjgxNDUzMUs5dlR0a3NuYzZlL2M1SkptLzhKdi8wY0xnQ0ZYcDV3dy9X?=
 =?utf-8?B?U3l1U0pkbSsrUXVCTjB0OXMrSjRuKzVBalYyUFViWXlvYzhONDZmbmJZMk5r?=
 =?utf-8?B?eWVMaElpZEdoajUxMnVTNkY4TlBoYmgzVXdUclNZeHZJbXZOWm03Z2ZlUFlK?=
 =?utf-8?B?b0EvcGgwZkhBdEtXcEplRU1zSlgzWDA1OUV5Z0xuWElJbDBMZzBQL3luOTli?=
 =?utf-8?B?OFNhOTFmTnBMZ2FISDFIb2paSEVaWVYxVk5DWktpQ0RrTnVjNm0xZERNeW53?=
 =?utf-8?B?SUo2MmhnQVpEYnZWREdUUmFoZ1M1cy9qQ2Q3QktzUVAwSVptcFhyQzkycWlj?=
 =?utf-8?B?Nk9GRE9nRTQ5SHVwa1Z1eW5QQTVYb2hTbllZQjcyMG5tSzJGaDcrY0RlR1NP?=
 =?utf-8?B?QVVyR3FjRU9WVHFlemtNM3kzbGlTRzlZK0xndGc2QVl3WldVTno2QWRYcEZx?=
 =?utf-8?B?ekVuQjEySVhyQUdTakZqeUgwK29mdUl6bmJaMXAwUHlnVmd3THpwT1lyNW9R?=
 =?utf-8?B?bGZaeFR4NjNjdVYwa2VQVnk4dEhXenN6bDd3a0k1UlQxODk4Zk9nRkdNTkhK?=
 =?utf-8?B?RlVlRzBnZVk1N0M4WWhTV3BTT2UvelFjWUZrSlgvdDhVbXZJWFdIbEZJUEpq?=
 =?utf-8?B?dkRSOHZSckVSUDJXSnRsb0lhb0lPK3FFQkd4N0hpaTFvdUxHRTZSWHZRTHNp?=
 =?utf-8?B?R0loZFN0Zk1mY0FhN3NweU1rNUdTY3RQdUdHT0c5VFpwVE9BeUNQOTZJR3Zl?=
 =?utf-8?B?N1F0TTNZQmhreDZUODcweGx2VzU1SktyZ2RGdWgyOGxVVkFZeFdyWHhqb2RD?=
 =?utf-8?B?Q3Y1ZnJSNDRkcHRadjB2eHNMOTV0Q2syNmtXWmJTbWVtSFg1Sm9hRGhzYkg1?=
 =?utf-8?B?cy9qcEZ0ZTE1SkJrZzBNUjBybHJ1T0R5bm1JaUdPWHFjRklwb1Ftc2VzV2ww?=
 =?utf-8?B?UndjV1dPd2x4a1BnejhjeWl6a1dDZWh2bGFTRU4zT0JVRzBMZ2hiYkRDZldR?=
 =?utf-8?B?dDF6V0UwdzJQV2tJRnAvaVRXUnVvdXZ4K3VpWUNOaTd6YllHWW41VHJNM3FG?=
 =?utf-8?B?V3o5dkhkSnZFdGMyZDJOSHZKbEdoaHowbnlaQTZkdGx1SWNXSWlzR0N6Tytr?=
 =?utf-8?Q?Tuy+9ynQ2533kJ1/sjJKjjj/Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3c31d0-1b84-47c8-883c-08dc6ec613e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:46:59.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARu326s5w14mlG5Cdhah7zUOuU37OQ/ZoUbIsHGFgtQjRc14+kUy5haKFFG6oFKOZJxBHK5/sUwCzDEFHGjWfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

Introduce the help function imx_pcie_match_device() to facilitate
imx_pcie_quirk() in verifying whether the device's bus driver corresponds
to the IMX6 PCI controller. This addition lays the groundwork for future
support of ITS and IOMMU in the IMX95.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d074bcc34d7a7..b33d8790a93af 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1652,17 +1652,25 @@ static struct platform_driver imx_pcie_driver = {
 	.shutdown = imx_pcie_shutdown,
 };
 
-static void imx_pcie_quirk(struct pci_dev *dev)
+static bool imx_pcie_match_device(struct pci_bus *bus)
 {
-	struct pci_bus *bus = dev->bus;
-	struct dw_pcie_rp *pp = bus->sysdata;
-
 	/* Bus parent is the PCI bridge, its parent is this platform driver */
 	if (!bus->dev.parent || !bus->dev.parent->parent)
-		return;
+		return false;
 
 	/* Make sure we only quirk devices associated with this driver */
 	if (bus->dev.parent->parent->driver != &imx_pcie_driver.driver)
+		return false;
+
+	return true;
+}
+
+static void imx_pcie_quirk(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	struct dw_pcie_rp *pp = bus->sysdata;
+
+	if (!imx_pcie_match_device(bus))
 		return;
 
 	if (pci_is_root_bus(bus)) {

-- 
2.34.1


