Return-Path: <bpf+bounces-28930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A18BEBC9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 20:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19C21C22CC4
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911CE16F26E;
	Tue,  7 May 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WEB15Wy+"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7816F0E3;
	Tue,  7 May 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715107619; cv=fail; b=F5tFo0YHnB6QXy0Y/5Ukg9lH97Z8ZNfa/3XWUAaGIt+lskRa4ABYpe696EmmwNef8akJhV7DhFvdyEWJ6yxZmAJ1TLnbFhqi1BfEmA8NlAJVcz7+qYV7CvoZkcj691RqaLlHd7fH6nRHlei1bMlHTYjUxHnD1rH/HJwtIBHIN0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715107619; c=relaxed/simple;
	bh=6PxVWHNhAUXVQqBSArIaUpWHawAqcbFt/BL4vN7KTrw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gZLYIG8qG/xX/wmMWQw1zxdBMGfN62vTVs29hbAwdVRsyrQQ9r5L6SK8143ONdp32RYWLhnaT0+IaylazKhnQKqMlfNwbzAqaWva0Flc5I+ZlqJWMwzq0OUO+8pi5ZiauDYS1eAtiIN0l2fQ7aUOjrTNARFIx+KCEPYlqCXYptY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WEB15Wy+; arc=fail smtp.client-ip=40.107.8.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4MX9g+jjk9C+QMTTHZ5xww+LblaKFr7hpLrTJmerUEbhSNtV/1AMH/v50a/Rc2nHAY7wk2UGkfe00QzqOmn9JrGhCeihYtqsGpkypFIZe5b9KpMoJejMEM+H1r67JwEIJJf2alg3IuReJ7eACnE2EqWmN5G6Ni8xTF8JfhmVwhVoDXFHuGyAdFVmAoQK+S+av6hZclT06FjRSxexsuBoem2qQq48sPlJmnTu6/CGiqyLs/ep40Q477B3xchYMWM6xZk/Hsr0FeJieCpyOfTizxyhGTQHzNOAYSfkqKicBqfGEBHnGEs1envvp5C1tkrxUtQxQP/l+xqZ27XLKKzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No1e6ggxcaWM6w5fhc2pL0xcstqCy/cseH/nZ7iA8to=;
 b=aqqeCNyumq6CPqj9pUE3L73D1ci7/D06Lln1rZTL5V47E7ynk63mKG0IbaAEaIUjEQlR0Fh07rHdSfncUuAM+IMT9Ms+ee9eo4C9U9G5o+OpyXntLeuAtJq/6WD0714wLCwj56pAsbEl5ecVUzvPX6FrrDQ6+gBvVXrV1ib4HeNyI7CKD8R5//FGHI0w47P1b8DGwG7OSLL0SF2Ay+YRPiCHM+ZwiHi08CEfWewn7fSu1njXNrHUqB0byGxXzehp851deDD1Em4hcv2weDZvsVsnyklqS425xlF2FznmuPwzoYoOE28mHqLA0ixLrV50NqQ1uFS5pqJhy5TZXct0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No1e6ggxcaWM6w5fhc2pL0xcstqCy/cseH/nZ7iA8to=;
 b=WEB15Wy+argoIz62i/qYWNa6CbiwqKMHlQyZ8XXOfBYDIu8rRkUSsV/kqUS7TzQQdl0YSbh2zjk1ReWqJTAch2EvGUTtCbsTkCsSpGOpRPTEMgcPpqZykK/5tnZWOR8coOnWOPDi3Cx4oy1MtdqJsdxb6YIU1TXFjMl15uScl2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:46:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:46:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 May 2024 14:45:44 -0400
Subject: [PATCH v4 06/12] PCI: imx6: Improve comment for workaround
 ERR010728
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240507-pci2_upstream-v4-6-e8c80d874057@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715107574; l=1779;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6PxVWHNhAUXVQqBSArIaUpWHawAqcbFt/BL4vN7KTrw=;
 b=dpNV5b7Bcq3i+CJaFrMuFzOmeJ6VpzfhNg34d2e3wRjWnU0GZTkhcGKtpAUhtZZx45/Bkr5Ol
 WJicUuCTpvxBJsXNiunlXbJq7f8T69owYCw67y5cKdixklWYeoW+KGg
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
X-MS-Office365-Filtering-Correlation-Id: 6cfba788-ca66-41e4-9ab7-08dc6ec610a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2ZXN1VIdWdzWTgweUEyV1VnZWJNWVIvSS8yaFYxOEtiUVhVa3o3TmVGdThH?=
 =?utf-8?B?dzAvWnZGRGxjQXBhQzlnZGQwNXpjL0pZWU5Fd3VQTS9CMHZ6Q3dZQ2Vpcm0w?=
 =?utf-8?B?eTliUWZCY1h5WER3cjd6OUpTc1pLc2JhbTk3OSttSnFDd2I3OUQ1dFhvbTNG?=
 =?utf-8?B?Mk9FNk42N29yL3lnY2UrYytIeGhRU0VIVUJIU2lseXdPL3lQQVViT3hEVGIz?=
 =?utf-8?B?bExJK204RHUxazJRZjRtMHExanA5MzAxc3JXb052c2tiMnNFeWsyb09zTlJ2?=
 =?utf-8?B?WXZxbmZOeUkvYXlaazZOdzFtYyt3cDZHQnJ0UDFCTUoybHhYTzVvTDEybTJY?=
 =?utf-8?B?TjBpOU1rTXl1cHhEUS85eXIzb0l2bVN6L3FpTmtaa0RDZG9yOWE2UU96ek92?=
 =?utf-8?B?dnI2NFlFTUZwcndueE5yWEdybDlhMkxSQWZMYjZUTkNGNGhPSHlrS0xLZXhp?=
 =?utf-8?B?dmo0OGVkUEZ5TFNRZ0RxRDZWdDkxczQ2WFIyTGJzY0srVjhjRjBTQlA5eWxv?=
 =?utf-8?B?Q0gyTkNteENNOTVhZ2p4aTMwZzZqQjJ2M1lkZEFKeWJHOG1yem95aUkxY2dy?=
 =?utf-8?B?UzRMZnJETmhkQXMvbHNhN1JFaFlRQVB4dm53R1JYK2NKR0N6akdhZXJrSDNs?=
 =?utf-8?B?MDZyM0FNS1poeW1BdEtxaG5qbkc0dVZtWVhid0p0R0RTc3puM2VlcXVHRTFS?=
 =?utf-8?B?TFVheGd1TGh5a3RMM1NKaUZxMEUyT2JNQlYyK1BMNGFSVHNVa0cwQmN0MzJw?=
 =?utf-8?B?ZzVrbWNIajQwUFBlWGo5aEVCNWN0dkZsZVhDbUgrcC9zKzh1N3JxS05iYVov?=
 =?utf-8?B?alJZaHdOZUpySWdUY3NYcS9Ycm5rdm94Ty9Sb0kzM0pRa1U4OUtzb3FXYk0y?=
 =?utf-8?B?RkkzU280am0yYXZvUDRaQ0dJSlhvQjI2TDVUbTJTL3l3K2NvSnJEdTg1RHJo?=
 =?utf-8?B?eUVUUm95WXdCeGg5TURLV3FaZWtaMFYxSWF1NW1uTlRoOTFEWS9ZUWZVcTMr?=
 =?utf-8?B?Z1ZPTXRuSDVZeTFhdDBGTFVXbVNZRWQ0WXBoNlRpWWtXS05BN2lOcUlrTnBB?=
 =?utf-8?B?enlObU5YWGNxSmxuVlpjaXlNVjVmckw1SkdKdmJEL3lYUTZFbkxFbSsxdzBZ?=
 =?utf-8?B?Ri83WG4rR29Lc0lERHhiTDNMSFM4TkdmNHlrcVRvL3lPOHY4YUxWZEF2aDFP?=
 =?utf-8?B?VXh5Z1BwMGg5ZDZCV0gvYzhTQnVtZlhneEdiN1ZkZnJVV3B6bEVMSVBGb0VD?=
 =?utf-8?B?dUVvQTV2RGpxYkNIR2lKbFBDbkgxL3JKOXF2bFNXMW9wNE56dkduODRmWlYw?=
 =?utf-8?B?V2NWYmVIRVNsL0lhRytTWFU0UnR2Ri9VK05YNjYveFV6WkQ2Sm1KSXhpdDJO?=
 =?utf-8?B?RlBma3VsRTNwcFk1bmIyQ1ZwQTdLV3ZoaFlKQmRGWEJNaDRua1NSVkMxTmFP?=
 =?utf-8?B?SW9QWUowR0crY1NNUk5xT1c2ZHVDZjQ3U3FlamtmcFZqL2NDWkpJcVpZay9m?=
 =?utf-8?B?SVdtbTRMV1Z1b2g3QmI3MEp3VUxXVGljcHFyajJTdEltczEwRStyZHcyM3JZ?=
 =?utf-8?B?bFZjbS9xMkIvKzRyQmVvQ3k1TmFHNlNmVFZ1dXhDVWFobWdodVlQbGNmLzhl?=
 =?utf-8?B?VytuYzVxbHFiL2dvMHRnZzJTRkU4MHpLaVYzSkxkQm5hZStkUTVSalM1TDJV?=
 =?utf-8?B?R3JiNlZBcTFkNk9GSzZMY3JJRENLU0FncUhWN1JLYkV6d3BoRHY5VWQ3My9E?=
 =?utf-8?B?STlVZ0FreWF2K09VcWpLSUxEMzAyQldiTmRkNlFSRDBDNUg2QXgwMXNHaFNu?=
 =?utf-8?B?dHc2MDlXUjhhbFlCT2RoQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWRRRy9WK3BmZU0xVlBRcitqSTFTVjNSSXg3UVVLT3ExT0tSa2hQWFJ6WVZE?=
 =?utf-8?B?RHhVVy9oYUFlVU5iZDhOQ1pZbTQ5RUdwZWRCSTBHRXVIS1V0TWVJUjFPZzhW?=
 =?utf-8?B?TE94cU8vdFd0T0dubk9CMWxmeHpDc1lOZUd1WlcrNEhBWVpLcFZoaW5XaHB6?=
 =?utf-8?B?Tjk1RndBc0NQczlpc2hlMktSNzY2MVdVQ3U3ZTMwMXR5WCtLaW1OK3NIY1Jr?=
 =?utf-8?B?L0lWOHdJTWZ4VzZSR1JMRXBkYk9QWnFLcFQ4QklRTHJ4dEtVdkNTa0hPY1ZQ?=
 =?utf-8?B?bVVjcDJBenlnem5HbXorNDJzLzJScGNLbk1RRkVyNzlSZU84QzVvTXhTNnJq?=
 =?utf-8?B?RFhaOXU3Z2hlY3dsU2lOeElIY3hsMnlrc09ieHNxLzZyVkV4aFhGQ0FIWlBn?=
 =?utf-8?B?R3E4VVlHdWp6eFo5R0FBaHRZZnlvYXk2TitxYzFmd3FLSTE2ejlSbVRzc25s?=
 =?utf-8?B?U2RQSnluenhtK1FNOTdBa0JESWJTNlFybTd4dGtNQmVrejhPQ21MTmlRMkZB?=
 =?utf-8?B?NFYvWHBySjdTZUVZY3V4SURMckJYeDhXdDRxYUUzc0pXcVk0bnhVcjJDU01x?=
 =?utf-8?B?MVdUOVlvZzNXY0E4MFRpa2crMlVWbGNOdHZtbW5uRWxUZTh3NGE0MTFnQmZ5?=
 =?utf-8?B?QjNRaHI1WkxjQjhwVEo4aGRvNDVXZElaemxYMkxMN3dMZ2V1bDZxZ3gwclpV?=
 =?utf-8?B?S0tOUmVHb1VxcU55ZG94bVdab3djaW1HcUpPYWFnUVdFc3JRdGl1cmtKbk02?=
 =?utf-8?B?YUMxK0hhaHJzeGowa3Y5dTNsWWNpYWVkNEhuSUh0K1pvSVpnbkkyTGtJaFZo?=
 =?utf-8?B?NW10VVhOMG9VU0pHUzlSeTlTOXpyWUZpUk54S29VTFFUSjFJTUVpMHdqbDZw?=
 =?utf-8?B?ZUpacWVvVVZ3Q215MFpJOTRkdGFUWjhJQVBibGxaeFBDOWpuZ3U1SThxVXZY?=
 =?utf-8?B?SUhYWDhKQ3VMN1JqeWhMQ1A3L25uNlNvNXI3Mnc1aFh3a1FKc2RPeHhaWWtZ?=
 =?utf-8?B?aGlDQm1vWExGeElJTjQrU2kzbWNzQ1NJN3lranNoaFBWQU44TlQrNFFaN05s?=
 =?utf-8?B?RVloQnhlNE5kdDRJUVpWYXNpQk55YXVoR0V0OVNyaVFqUkNNZmpMbS81RGFX?=
 =?utf-8?B?SmFycGt0VWFlT1Y5elBRa2JySDFMTXhSU21rcXNRVEhVQUUyVDBDV3d6QWtD?=
 =?utf-8?B?TmEyTUF4dXJsNWRKZTBVNVlZYzFOUFgydFY1V0MwRHlDZjIrWVluR3l0NlVL?=
 =?utf-8?B?N29MNFJDZmpMVTdnY2djYkQrYU05NE1mTlY3YkdNVGZqVkh2S3Bkbmt3SDc4?=
 =?utf-8?B?WVRxcENZTy94Z0VVRGVvSk1pZG9ESFE3NXFIZnIycytVaERDSFRNRUJGalhC?=
 =?utf-8?B?U2llWE9GdFJNZ0NaMWNFbkpLNHVjQ1JqQURNMjBMMlprYlYwNnJEbmJEUHQ3?=
 =?utf-8?B?SWE2Nmh5aHZqdEhUeVllUUhITjVYTU5uWTkxMDlEY0syTmtDRkRsNDhzQkpI?=
 =?utf-8?B?RWFiVVdaaXRlVXp5L3VZUlZKYm12cGdYcU5Yc01hTzYrbGZLVzBXNTczV2sw?=
 =?utf-8?B?Wmhrc0FQQXJsbmRTMWFSd0NJVkZZZGFyUlZ6VE44Wk8rTDZzL1g5YVZMb0pw?=
 =?utf-8?B?STVlYzFkLzJDSzMvMmNiYTZ1ZmEyM3ByWGViNzVNSmprZGFaMjBSdGNmTGwx?=
 =?utf-8?B?UUQwanZod1JJcG5TYURncFU5azhFbkIzck5FQmdFeHRwdldVRHV4bXFkTmoy?=
 =?utf-8?B?cCtQaGFIWHl2OG9IWmtpSHRIRjB0Q2oyb0UrMTYzM044bTM4QUg4TVBEWW41?=
 =?utf-8?B?QUUxV2N0WUZDZEp6aGRFNGYrNGJCcFB1YVpTc3JOWmxsTEtRT0hvb3hCdU92?=
 =?utf-8?B?Y2V1ekRQeXE5UWl2NG9DTG1ZR3JXQ2swVnkwVmxCUHIxL2xweWhZWkJrUERC?=
 =?utf-8?B?eGZnb2Z3eDByRHUwWWo5Ty91RmQzN3ZqQlh2ajUyZlNFcE5oRmxSSXVQL0lz?=
 =?utf-8?B?Qk5iQXZwUmh1aXc2ZnpSZkJnOUxrK2ZWcEd3cEprcVZ5cFFyb0ZGNlhuMEU4?=
 =?utf-8?B?bU9VdnVQOTd3bHd4bWhMOGdFWXEvTXE0eFpEL1o3Vzc4RFlrZHBIUmVEZWZo?=
 =?utf-8?Q?Kp9kxfaDcO3c5hzc6rhimj7zN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfba788-ca66-41e4-9ab7-08dc6ec610a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:46:54.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ur58RFRXbUWyNqOIZIDMk+veh+BF0b3gVqfX5l4fG30qrzrZ4kRFvYV0YEKB3d24eN3WfpZaEQxHpKnzsG84A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

Improve comment about workaround ERR010727 by using official errata
document content.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7396f0d51119a..d074bcc34d7a7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -715,9 +715,25 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 		return 0;
 
 	/*
-	 * Workaround for ERR010728, failure of PCI-e PLL VCO to
-	 * oscillate, especially when cold. This turns off "Duty-cycle
-	 * Corrector" and other mysterious undocumented things.
+	 * Workaround for ERR010728 (IMX7DS_2N09P, Rev. 1.1, 4/2023):
+	 *
+	 * PCIe: PLL may fail to lock under corner conditions Initial VCO
+	 * oscillation may fail under corner conditions such as cold
+	 * temperature which will cause the PCIe PLL fail to lock in the
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


