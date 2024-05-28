Return-Path: <bpf+bounces-30775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F418D252B
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27F8B2A336
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C7178CF5;
	Tue, 28 May 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l5wwo/lw"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5717BB07;
	Tue, 28 May 2024 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925207; cv=fail; b=Cv4buc7CdVZUs0rRPMftYXhVEnxs7E57yh8f6ggn3MKDyPqWZQjHv1q1KCV894f3dRx3dUpB49tPL+JE042qXOT+fTbMGmjtFF41STFBb1sFC0Ug0i9uHb0qvDLxp+n9teqbvDO0NLdCRtgf/3UxV68xnAH7NasznKVuIiGMoAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925207; c=relaxed/simple;
	bh=8xOc8FHVDA5CYg4ysfXUDK0s+odx3UuJLqh5Cmr2E2M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PFw3YpE0pEFC4OVnPrsW2ZNgfpfW8bpEwvo1G/slLYQJ+BgRyk3E0aGtj8bNOHxtpgaWoIaQhk4h6HTFtb2E4r9aVNhg0Pu6wL//nyT3bEm43jNMxNrrmIF6IjW1470kWpUQprWGF7NDKDHn7MgTiRws5zOPAPqVeFBYzwPE0Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l5wwo/lw; arc=fail smtp.client-ip=40.107.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXXe6d6mVPiAISQIfqPuCHXgumL//7EFDkQ5QlI6ANUEIFuplwxIIJr78yk8oCVe1P2erSaFgGx5W1GMGyX8da30c52UaPuSmIfgkplnGUzReT8pf4O8pw87gF7Ub3Jqtmkl1laI8F8WYtuArNdM2yBXjM4ArKLkVgfM30mrHmHTG47tanLRO/Pdm8n4WJpCjR0sjn7CEGhRZl2ptpk8xdyP5GNgIDtK/oUUiZTm7e5QSFnjXCisnjaJZrcwO20AQdQasMbifLb8rSNpWPtaY6TrElndLifZ5q9Py63aYkxwTP/bdVVPcA7KSxmACtnkUQttDvEMT1k1LxG1vm6SAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0M9WIgOQl4llIMpW1aAUyGhkZhEC+Fe2S4zElR+oQH4=;
 b=fX+2qevUZTVeNkyQHu+954ym4TZFNS3zGw+FFre+d7iNIyby4Xsrh1++O3D7FQh+QJCrMmA5clEHaxYpqSrg5ir/WQ0yS3ZjrJouZb6dUdNGSlyCKV8KhIQ1J4Ej8+g8Z+HicGn8cpjuLtO/SID+zSCFINb4XdkTrwuysxCtBVyAn8R02JtB+yWVG4ErhAEoI/b7oZyqUOOwlVwFa2/lekvg6w5tUhQuZ/Dn5qsQHHKwRaSNc2vQbeK4bHoebo5CVJPYinCapkJ1XMBSCiRg8PzRaoRShuy5tdiNA1pWFWs/BcycXXfyYScS1rcBed0QZgOi+SjVbZu+cDtl9LT2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M9WIgOQl4llIMpW1aAUyGhkZhEC+Fe2S4zElR+oQH4=;
 b=l5wwo/lwpRAM+156in7bfpjWHomt6EQQVXq90UOYCsGOSHxtT/1GVT7p0TNYjnz8PLW48GANhJ7T2ZEMmwfI9Tma1S1IO5lftAQMjhsUHKFY2lPJJMMw2jKfTu+m01OH8WxxonG+XIjtQtjAH2HqABxB/Bgk9yPQJSjBHYd5QaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 19:40:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 19:40:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 May 2024 15:39:19 -0400
Subject: [PATCH v5 06/12] PCI: imx6: Improve comment for workaround
 ERR010728
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240528-pci2_upstream-v5-6-750aa7edb8e2@nxp.com>
References: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
In-Reply-To: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716925161; l=1779;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8xOc8FHVDA5CYg4ysfXUDK0s+odx3UuJLqh5Cmr2E2M=;
 b=QJZ6JJZw+iCIa2mgfIFRpS8hV4kH/8cpSYH3EcOuAOFnJXzcbPqQjw6Fm+W8j8cx1XHxfp/kz
 Npf7iy0FkYKDZnAoUvNE+eYkZ+Iu3t/3tWG1BYffA89B8TlIHyFyXPG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a2e174-b692-4404-ba16-08dc7f4df6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|7416005|1800799015|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVFFcG5PbnNQdGd4ZE1aQVRLSGMxZFZFUFg5cmpZR1Z0VmxrMEpOSCs0L0Fz?=
 =?utf-8?B?VHJUTlhUMGd6SU8wbTN5VExpY2U0RkxVMTRhTURTQmk0dXRBbjFEREcxOHJq?=
 =?utf-8?B?bmh1UGxRS2wxeituVmV2aGNZSDk0VUhYamRnaVFrYS9NOGtySWZjMDc1d2Vj?=
 =?utf-8?B?TU8xRklXQXR6RlhVR2JuN1Y0TG9jTHltdml5eDlGNjIzNUVpWHNpZXNidHVR?=
 =?utf-8?B?bC84RlFPaDRxMC8zQ3phTTZZcmpLQUxJcERkOU13WnFBcDBSd3RQaEkrMG5L?=
 =?utf-8?B?YkV6c2ltWUJybTNQdFpCM0RLbVN3RXlZYXl6Y0NuWmVVRkg1YVpsNlZFU1Z2?=
 =?utf-8?B?b3pyMXJqN3E0Zk81R1pURlp4T0R6YTI5N0xxanQ5S3o4cjVVZU1Cb0xEckxt?=
 =?utf-8?B?eVJJOURlMUhvclZBTnRZbkNjYUg0R2M2bTJTdThjcVZRVWM1UWNUUE10Y3RU?=
 =?utf-8?B?VjM0NWdJOGp2bEFobFJvYzdObEZnR0dRZTl4d2tKT0QyVWlGejY5UDhMNzR2?=
 =?utf-8?B?cXJFVFRtLzRrL1ZxNEJxbzYwOTNGWUJNZ2FYTVJmN2RPYk5uZW5nQ1EyMXpn?=
 =?utf-8?B?MUJBRUhaRUlzaGtkUEptMEFPVTlQcVZuUWVCdDlkU1dsa2FuLzB2cDJ6Vktn?=
 =?utf-8?B?QzBteTh3YmdZTTk3aGtxNzNLQmJvV0ZFWFozcThmZ0Y4RVlDWTIxTDN4eG11?=
 =?utf-8?B?emc2OEwxVXlwdVRYb2pLVTd4T3dnbHFmY0RRd2xJdWorbUd0ZHVLZXdxd0V4?=
 =?utf-8?B?Z3ArcXlwQ2cwbWlac04wUENWUUE4VkZRalNvWEkxbE9JUW9RTEk1S1o2K24r?=
 =?utf-8?B?Y1dIcmhDSTlNaUlTMG1kZGF2TStPSExueVQ1QXY2TnFVTkRkQk15clZwK0FU?=
 =?utf-8?B?T3NPV2Y5a0xXMjhFRFRpcWdvZlF0Tk5PNW94M2R0L29GQ0JzRGhNVG9sN1B1?=
 =?utf-8?B?M1RDQlVua280TWxtRUZ0cWZnTldXaXEyRXVEODBrc3Q2SlNINnZxd3h2WkJo?=
 =?utf-8?B?QmVJVytoTTVycHNDQy90dWxldFI0UWd6elRJSXAxT0hTbTNWYjZuWEM4dm1z?=
 =?utf-8?B?cFVjcGZOWVR3RXpIdlBRVDgzN0NkQ2dhWEc5bkhPWWR4d25xYXEyV1o3a3gv?=
 =?utf-8?B?RXNjU0FRd1I0dzYwVFNrKzlBV1RaSG1xY2xLOVpZWVhzcExCNU5FMXFkclFF?=
 =?utf-8?B?U1BTekJ6bkxBQllCOFAveTI0WE5YcUk4a1M1Z25zQmJDd2ZTZk1OeU55emc4?=
 =?utf-8?B?RG9sYUZMZXhUdENid0hBYytSMEZnS0pqUkVBNUFUcWEycFk2NS9LOTdYekh0?=
 =?utf-8?B?dEJ4ZExxcGRHSXp6U0VVczZSejh0b3Y5LzdLU0xYNUZoQ25sOVQzdTF2QVdB?=
 =?utf-8?B?RHY3U0dKM1N0QkwwK0NLdklmMUZ4L0ZrRHBZbCtYamRpLzVod3BrSElsUzY2?=
 =?utf-8?B?MVhyeTEyVWV0RVc5U3NOeXM5VHhydWpnelBEaU1xTHVuam8wU3Q0c0wwc0U0?=
 =?utf-8?B?WDVYZDV4VXJNUUR5UXIrWFljWXZPL2VDN3ZuTnBQQ2UyRURIRFV2bFBhNnhH?=
 =?utf-8?B?M2NnZ3RGVm5lU3F2dWFtaFplWGtxb2w0bmlrRUUrUEpTK3JrcGFIdWloUmtR?=
 =?utf-8?B?SEhyME9YdURiT0dpK3ZKd2tGTEpVY0RXYkgwMlhhSElZNGNCTERyVnoxU1dQ?=
 =?utf-8?B?S2YzUVcvOWk2T29jRlRCZndQeWZLdFdQTVlLTG9hMzdaMlRaQm1Rb2oyVG40?=
 =?utf-8?B?eHhxbkRZczZnY3YxdHZFdlQvbFpmZFFnZHR2OXNiRTA0MFZjcHBZUHdEQ0lo?=
 =?utf-8?B?K2dYek92eE40Vm5DZXBqdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3d5T2JRajZrcnJXTUFxd29TbkMvRTZwdHo0VDRGQ0puNTRPS3FlSVFZc2wr?=
 =?utf-8?B?S2lld3BWYk9tOGJDSEtKaE9HbFJwbnBsTUlQOUhKRTB5L0ZuMXlWQ3pxTXkx?=
 =?utf-8?B?YW13QUlNdExaWnZId2dvcTloQk4rcCsxYjdUQTJZcDhFTVpyeWhRakpBanpR?=
 =?utf-8?B?QlpCY0lvcmhxRDdKM3QrMTNIS3BxL1dXMjRmR3FGY28rVWc4M1JFK0lJYkY2?=
 =?utf-8?B?dVhqSE9SYm16UU9YUzlsdWQxVVd3eDBHTEdPR3lGeU5UQ01yOVd1dFF4ck1W?=
 =?utf-8?B?R1dLWTZQMW94QlRPaTlacUtQVG9CSjVheHBJQmJrckVuYVJBMEhFUnVHTldz?=
 =?utf-8?B?SlVDU1BSL3E5L0xQQ0w5MHdoS2hrR244NTNLQlN1eGFlVkdldDJKQUdmL1Er?=
 =?utf-8?B?WXg3c0hjTFNOZGEwWnRyTmMzVWk2Tk1ZV2pOQWx3a2VvbVV5Ykl3Tk50b2Ix?=
 =?utf-8?B?ZGEwUWhBUmhTS3Q1dno4VGh6UHNld1QyelpTM2dkc29PdnVGbWM0UExpNE96?=
 =?utf-8?B?K3Z2MVU0YithbWhiMlc1RHVaL1d4cUtMNkRBc1pJdkpSWGdkL0lreWkwNlZ3?=
 =?utf-8?B?eExkVXhQczZQTHJ6cEZSdG4zNFljODJrRGFjZ1F3ZWJ4c3A1RWtqckcwRU1x?=
 =?utf-8?B?bUVNMmJLSVNBVTcxc1hSRWdHcWJPRHFhbHdja0YybTkzRjdtbGZJZXZ1ZWxL?=
 =?utf-8?B?dWNrUnZkbXMrcU9mK1NQTW43cks3Rit2blRLWmFXd013M1lQYm1yWS9wOWxY?=
 =?utf-8?B?S1F1UG9FeHk4eW5EUFJYclloOStEUWVtU2JCc1lqdFFNOUw0cVBtSFVXRFR4?=
 =?utf-8?B?QmNXZ1F2MXM0ZUVnaEtTNFBiMTAxRWJianVMZXlDSDV1U3UrUWFYMmhzV1hk?=
 =?utf-8?B?eW5OcHg4b0NvbWpEKytWU0dGQk00eFdwOWE4Qk1qNXp2OTlzSjZhR1cwYit1?=
 =?utf-8?B?d3VLK2YwM01WSU1IQWs4WXlCZ2xCZ252YVFGa0ZVc0Y5azRrTXZJbXZzWUsy?=
 =?utf-8?B?UEUvZEUrYmkzd1o0eGREVUMyaDliUEUwcVp4dkRWOXh6UDBSaUMvWldaRkhU?=
 =?utf-8?B?RjFCaTVtVTNEUTljNDRwV2hBQm1GZkV3UzVtZjBXMEJKUmk3UW94TVlYZllD?=
 =?utf-8?B?aHdGanFoU1R2Z3lGRS9QU042a3RUUXZrQTVCYzZlZjYyV1hkZ1hFWmtiOWVJ?=
 =?utf-8?B?TWQ3MzRpK1p0T3RjTit0SEJlMHU5Q1EydTBSQUxORTVDMjJDQmxGUUdJNm56?=
 =?utf-8?B?MitqY3hHVFVsY2Mza0hxOGlmczh0ZmkvZHJGS1JIenc5Ylo3OWlnNkloQ1ZC?=
 =?utf-8?B?YmZxYzN6QmgvcktlQkx5eU5TRG5RNW5tM0xaREhlVnhGUmNVUUZhNEVGRTFR?=
 =?utf-8?B?d1puZ2ZuZVNwN28rTFVpTTllZE10M2JkNVdZaHZxRktESzFJdVkreWVzTldr?=
 =?utf-8?B?V2dEMmVpR280WCtrZTYvN2p5NUJpeTdaa252TExEd1RncmVrYXRiT1NRNk9N?=
 =?utf-8?B?bDk1Q2szN1V5b0xmei9meWF4VG9pR1JCRXJtVzZGeG5haWZ6dGNPM3EzUGJV?=
 =?utf-8?B?aEM1Q2V6SUJZOUlCdWtLb1BaalpTay9BYlJhNTNjanYvWC9Pdk1yZ0RteW1U?=
 =?utf-8?B?ODVWREdJV2hYY3ArS3J3dHR1eDBieDdodWNVSnIrSjRIQXhabkwrMEptT1Br?=
 =?utf-8?B?NGhacGxtdXFuVDdtWjNTQ3hJUWRPYnFCSzZGMEJMazVVeTRPUUJjbjRjRjlN?=
 =?utf-8?B?UDFRdnFoWDY3bUxBbjNRTWZjYmNSWlpDa0d6OUpnbWNYNVYyZERxUFk0QWh5?=
 =?utf-8?B?RGhmSDU2MEdNdDNwQXVuMlFTdE5LT1E1aU1xbWk3NllxYTM2WXhXK3hkNHZU?=
 =?utf-8?B?aGEvcU9Uemh6b3lsVndvSm5USnVkZUtCUmpVWDlyWmd5VzVhbUtzMnBmOFBa?=
 =?utf-8?B?ZUFTQnUrN21wY21RQTFlTVN0VnMrZTRPcHJySUF4YjI4b3ZzUnJmZ0I4UktI?=
 =?utf-8?B?N3NRREZZUXQ2K3huYXhEQ0RLSzBQSElmYkVSOXdVN0EvVVFvV3NtRExKckRH?=
 =?utf-8?B?SjMxeTFLdWF0ZGxwQVMrMGZ1UDhYd294dDZJRldGUXhORXdpVGZuTWVLZVd6?=
 =?utf-8?Q?CAcY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a2e174-b692-4404-ba16-08dc7f4df6f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 19:40:01.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbsX5tOYV2pupuol3g1juA6zmN6BU/9PjpSBXRewclZvjc34VTjRbdYDbITmDPRP0/egFmON8148tDQ9e6r3TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655

Improve comment about workaround ERR010727 by using official errata
document content.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5e21fc942e90e..5533b7ad0f092 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -713,9 +713,25 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
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


