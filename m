Return-Path: <bpf+bounces-34094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3307692A6B7
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 18:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9861F207C3
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 16:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB20146A85;
	Mon,  8 Jul 2024 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cbnSjkyj"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013067.outbound.protection.outlook.com [52.101.67.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7214659F;
	Mon,  8 Jul 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454525; cv=fail; b=kukNqQHYme1pWc1d+W8uCXAjfMSPDG/nbn9+3npN5/PzESmbVl7n2gFxd/zSzG8mvcFH2MRDRxwD/PDLLI/nxSF94Gxh49Gp+azwa1xGCCHskj4MOVFUtNWiE9TvbuYO9byMCfusHoJcc8OYjB7oOL1YuPStH27NyIygS+xiVhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454525; c=relaxed/simple;
	bh=tpzXvRSxjjpodXq9k8ZdEGUX5G3ib8M3BZdBOBeQ3Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y8AFwNBeNdzoGakvTYAv0kyY+uPNNQ16a/pZe7eEjc1Kqi6SmBADHbXzt9/OVTfISrFQIsmfb2sWw7l1ji+idT5TdW3603TwkTuRw0jzUS5PCgQdzg/j/mAq1RxC/DZ9L1W9XK+RUHn0dq1XZJ5oi4XO7NWh7qNivGy3gHhcKhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cbnSjkyj; arc=fail smtp.client-ip=52.101.67.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRyreakbxkQPqv0xqBG5/QQv/cXwRMTGNrWEpUBe0yj+tsCwKYXEUO1KcGlZUJFY4hM9s0DRGc7fjQJGkap3wyzfmpgota6SvF7CftlYFO4flmJeWYMGiAm+xqRgEFSsR4/kb4lMTm4d28BAfhE9nYTYcxtzoQCqiFre1ykJSHNxffh8kfaKzglL5JAs5epWKjxEZvHJcKt5NydxqlnBjJ2Pjjs7SwxvNeV+ll5b1tJuZatZsW69NmOV3qjxbRCgSJcmzHugIozergxagkbEhgIEVg+xpcfvBWKaIHrLbQHdgQ4ru4fM6vXhjE8JZb53JscESCNIwc8byBbBPa3y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqwzMaWJB7mvKgcIftUtRUJl5jK2+07l6sXX1HShimE=;
 b=MvOahnPIHWThA5KPj3eF4vcya130HVxJUbDHbkd5qYZ/XRrVTs6ggCxxoYR61sWTMHSTx5kHzeWrureEb32uUrdcVwnGJ0aMUn69JseAso7YpvBld+1K/P+rAaBYb7OOe3f5veUf77GQ57Gg8vT0WGu8/ipneVWx9NcIj/vXlR6oYLFPHBKUjHtqyuBWh6pFksZThbR2pdVMYklnfWBVktSF/ncCKCsEA091UUDZkpFWIXCbOwrOyg2fx9MYNbCGx/EvD9tIrM/Wdnva+zdmEnZjzcNcq99UPgSsnG6rXp2aoIst/So4kDJH3H93CRyVazMdGRH20McDIQMHOagb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqwzMaWJB7mvKgcIftUtRUJl5jK2+07l6sXX1HShimE=;
 b=cbnSjkyjqbBIHt7WJrbHedbKoI6QmHU/9UepdWT8VzXz6dxXqMboo0hR2OalgNKOXd1Zqc+UjMfCjd8bTnlIbXvyl5lKlpUh+8v04G6y9ppuM4+fjYDmJDyn3S9irinw67+XB1o51qyOrHs/qYMjsi3VhSma6CkZzOJfAPp6EFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9330.eurprd04.prod.outlook.com (2603:10a6:10:36e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 16:01:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:01:59 +0000
Date: Mon, 8 Jul 2024 12:01:46 -0400
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 09/10] PCI: imx6: Call: Common PHY API to set mode,
 speed, and submode
Message-ID: <ZowNaiSmbuCdVtcW@lizhi-Precision-Tower-5810>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-9-e0821238f997@nxp.com>
 <20240630162337.GD5264@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240630162337.GD5264@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: 0070d8d8-af7e-42c9-4331-08dc9f674c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFd3SVhidE5WVXVmOUFCK1NJcURiS25XMHhra2RiZ3ZlK3hDSFdnZ3hMU2tl?=
 =?utf-8?B?am00WmoxUUtrZndiaytJQUoyVklUZDVqQ3k0WFk2Q1ZDZm1BZmszVW5vQ2dY?=
 =?utf-8?B?aGtWZmQ0cXpROERjMjFSSWtRUnNHWmxNVWZCd1RZQWQ2eldaNkU1L1hTaGgv?=
 =?utf-8?B?b0YwQUkyRm1TV1VrdGZoek5MaTlINlFpeG1NQk0zNnkybFlUejQ4dVh6L1Zp?=
 =?utf-8?B?Vi9adFRFOTVYZGtXRDlRMmdwWGNVUU5NYXJ1M3l4R1UrQks0TTRjU05hYXNr?=
 =?utf-8?B?a3d4enZVZTZ3a3Vlb1cxS1ZzVGk5NzhPYXV1bWE4bWlwbE9idXR5OFJkMElv?=
 =?utf-8?B?dy9OSGsyM1phcTlIYldqa2pONGFFdDFVT214RlpzRkgzWGpiWGZsNjY5citk?=
 =?utf-8?B?blpjbHdNSHUySWt3cVE4WE1GRjhQZmkxYzhaUENvVEIwcnYwYVhyZEtBYUN6?=
 =?utf-8?B?N1dCSjNyV0l5ODBKbkVPdHl2eGdmUC9nNkh2UGZKaGxHdmpzcDkrdjJHcTlM?=
 =?utf-8?B?QXlHazVZeVdPakdEdUNtRU52N0EyRDBTQkI0WEtJbVhvcmhvRWhlQk9TWHYv?=
 =?utf-8?B?SHZBSzNQRmZlVWpUNnEraGZhdTdxOFlMZTFOQlVMaGYxdTdxejFZSVJweWlr?=
 =?utf-8?B?NEZpWEFWbDVSYjNML1lhNDNHWkEzcUduMkt6clBDRHRDNWRrMXVQK2Yzb0Y0?=
 =?utf-8?B?ZzV4Qk1qbHhJUmtKckR4ZHdXZHBDeC9hU050RGVDN0k1ZXBKaTdJeFdzSDhn?=
 =?utf-8?B?RDJLbnBIVWp3aFllam8vWGJrdkN6c1BrKzNmRGNwODRQa3BJeHpQa3JyaC9H?=
 =?utf-8?B?SStxRW56K1dKTDhSQkVsQWR2TE9XdCtHd0ZETUtIbitZVzZTejlqOW5LcEU0?=
 =?utf-8?B?cUMvSXNUN0dhVWowaEY4d3lKV2tEZU5nODhiYVhoTGl4RzFWUDkxODRNb0R4?=
 =?utf-8?B?ZG1sR1g2dGhSaW1rQ0h6dndqTkZiWGlUTFN4U3ovdG1CMkM4OFFYM2x3ck5J?=
 =?utf-8?B?QWtZRElnMHp3WHZzNWFBbVBUSEhiM05rRjk2NjBIYytRNDdyb2pvdklXeWgv?=
 =?utf-8?B?azcvY1ExL0lBd0k0UmhQMkVPVFpwU1ArS0k0bStwV0ZxVDFDNktmKzZWbXNL?=
 =?utf-8?B?OXhCdnQwNlVNY1JzdWNzeHRSYVNsZHBKVUptSFJmelpHenJ1QmJaS0dVbHpH?=
 =?utf-8?B?ZkhwUm5vUkRiTU5MejEzUDdZNElZaWxOY2srSXRtaG9QL3A1bmxRRHdiNysy?=
 =?utf-8?B?RG5yOGc0ZTV6QjhvUlF6SnBZRUFUaE5ZMGtoRVRER3ZhOG1VLzR5RE13a2w3?=
 =?utf-8?B?TDEybXFVSnlPMnFTcndoWnpuSS9zZGRsQmJLWmtRTHFGTzRuUnJyckVhYlBn?=
 =?utf-8?B?dzU4SWcxZ1IrUlZiK25TcXBSZzFNcTQ1d0xZNnZmL1BqLzZ2RmkycVVkN203?=
 =?utf-8?B?VXhBV1I5RlJNSldqdFVOVDZpU2NnVmJ6bmhldDMyQ3FNVHVEVXp0cU4zeTdX?=
 =?utf-8?B?ekZiVlRTOG9CVGxpRlNlcmRkdTIvSlhJYzV0S0tJSVlwRkl4d0NxcTA2RXVN?=
 =?utf-8?B?WTN2c3MzblRQZ0hJRVJEUHRSWlJhdVlkV0tHVE5SVGF5ZUNYVVdNNnJIU25I?=
 =?utf-8?B?dVdiMnpxc2VVd096VDdybTFJVWpqOTZ5OGlYYnZHNExUMmY4cVI0OFNGeGxD?=
 =?utf-8?B?OElLSTR5dVBZYzdEOTIxbFo1MnU3VkZpcFBHYUxWWUhtL01idkpHVVNJc01t?=
 =?utf-8?B?SGtVSHRkd0FHYkVrNVpiMk9BNmxPSWNTVURYcGgxcU5SZDhXY3RDclIreWJB?=
 =?utf-8?B?RXF2ekRZTzZKU29PUmRXclNxWmlJREZtYklPRnBGWnRPbUVadkxaM3h3R3p3?=
 =?utf-8?B?WHpwVTVSWm54blR5SEFFWWdHTEYyQWNqSmVYNzlNZk15K2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TU85N0ZweDhFWHFiMTVzeENoTVY2VnJqYzRUVnJjWHB3UFhxMXFlOFRnc0R1?=
 =?utf-8?B?c3lvQWJaUC9ld3dIWXdnODVGQzk4bzljSjJxRVF4NFZVRGFLVysxWHZsNE1M?=
 =?utf-8?B?Rlo2QnEyZEMzNVdHTzRXdGY3N09jZit4YXFWbU8zcURqbFAvaVJnRS9mYVEy?=
 =?utf-8?B?Vjlab2VqN3lveUcvMCsrTjltV0lDemNzT1VPRFE0NzJKVnJhUTZ6cll6bTU3?=
 =?utf-8?B?blRTUEdOVnhZVmU2SS96TjQ1Rnc3VnVVVFZ5SmlwbTlDMUM2RElJWGpjcVc4?=
 =?utf-8?B?NWZmcm1YVktmbnlCa1hRUDljUHlZbVduOFpmK2paWHZjTnZSVlFrUWFVeVQz?=
 =?utf-8?B?YzN1eTgrUkFFemNEeHlmWW14RzlmQzc0UFc0Y1VHNWw2Z05sL1VDemdZb3ht?=
 =?utf-8?B?MHRWeS9RWEwvVlA1VE5kMElnWTFJcmpKMnEvOTdEWFkwcjIrb0ppNS8zQ1lv?=
 =?utf-8?B?d1dCeTZYS3BXSXNVdG01YVdPTHFaSEljTzdNRTNlOUxjVW1zdmdkT3U2RWtU?=
 =?utf-8?B?eUZhaFpDWEQxQm5Tc2xzdTdsREZUMEgyVW9kSnYvcEJwNWtsZHJQSkhzTFFO?=
 =?utf-8?B?bHM4VTNHZm9pZ0tFd0tWUmFhTzk1eHN5ZENpZUdmZUpiMXZ5MDZ6MUZIZWMx?=
 =?utf-8?B?by8yRVNHSXR0MThDZXZPWFdwbktacUNZLzBndnFQUEVkMzJ3ZFdJNHBMVThB?=
 =?utf-8?B?SnVnazhXVFVXUWVFU1R2L0FBeGlWTGphMG1Tb2ZaR053MndpUERnVStHcFZa?=
 =?utf-8?B?cldtTVpIMjVHTWMvZzRBcis4UDhZb2dJa0s2RFZLUzdwZzNOejhINTFQZEF3?=
 =?utf-8?B?WEdWK0JsOVJsNVVjYTgvOTgrTEsrYUpyZHI3TlNFU1FpdWtlT0Z1NFdrZGF4?=
 =?utf-8?B?dStQZkx2emYxeklNamJnL1BxYzRpdkw4Y2l0TTlDWEx5YTJ4Z1JuTE1naHd1?=
 =?utf-8?B?YlRWTEQxN3luWlpacjAzcTAveGZHcGxad2g1eXNXMEZIeGZGWFErTXg5cEx2?=
 =?utf-8?B?YzJxNnJxZjhxVTB2ZDNOY0RaU25FWEdXUWNuQ2pyTkRPOTFSSi9IWHNDaWp6?=
 =?utf-8?B?cjUxSjFlUU1lSThPYWgzSDZKSXhadWRsd1F3RGp3Qk1URFJUMnN2MHdlZlRX?=
 =?utf-8?B?d3pveVREK0R1Z0hzMlh6WW9qRURuTWhwcmlaOTRJTkE2bnk3eEJiRTJ2YkVU?=
 =?utf-8?B?eUgvcjRqT0VQejU2ODBVNndTbkkwZHM4eUhRRElxR3FiYVdrTlRibnp0QUFC?=
 =?utf-8?B?V3ZEVjAzbW1jalBqUmlyMFhseGR4Z1JFczZwYjlmQ2FEeENZUzVKUk1XVVpo?=
 =?utf-8?B?eVNLdUlJNXFCQ0huc3gyeGpMbUVjeFdBYStvLy9GYWpRTGxoNVNUdUloRHBE?=
 =?utf-8?B?eHlyOThZRHRnS3k3eVo1bXdhS2RKeUFRaGxNSGhCZFlIWk9NeVRjOXplWTFK?=
 =?utf-8?B?T3ZWenlPdEo2UTIyaVRlTnkrUUlCVi8yOFIyZ3RUV0dlYjhPQTNlRUxmK1Qw?=
 =?utf-8?B?VUpsZGpqZloyaVFPQW0xK3o2c1RyVjB5TWE3QVVZaWtZdHEwYS9pL1FMRE1t?=
 =?utf-8?B?YWlhRUtNUytVSkdFeWNXbkZSSEVoRHd5YmFnZG8vdEs2UHd6Z0hWNmRxcFN3?=
 =?utf-8?B?REJOWGtNS21NM0ZIakcxMlJnNWpFNUVXOUttcDRiemtvL25zMC8yZi9GRDNJ?=
 =?utf-8?B?RS9Nd0paZnkrRjhBTEdMV2pyTmdhQ05lMHJDUGwyak5sazBUdGw5dTkzekNS?=
 =?utf-8?B?V0dOYkd5U1dPLy9NamtHTG43V2FPYzdaQ0pkVm81Rlc1bWY5c2FsaW5KT2ht?=
 =?utf-8?B?dllJeDNOZzAvVTNVcjloTmtKQnp0L1pNazN3dnJ0YlU4MVIrLzZ2Tjg3MUlH?=
 =?utf-8?B?SGNUblhlMy9DdnF2UEhzN09DWDBsbi8wRWZrZFJ1aG9KU3UzNWhCWlhSN3cr?=
 =?utf-8?B?aGJjNURGK2Y5YnMzcFgwWE11UHBLNm8rT2o3ZVlwQURjZEt4L1o5Tk0vL2tJ?=
 =?utf-8?B?U2h4OWIwUnBSekx3Z2lOSFZENlV0RmpFTDZkNHp5RURyQXhibVc2M2NwMTZj?=
 =?utf-8?B?d2dQSE4rcS9HVnZCU0owM2xwNXJIUDRpakorZXg1N3hBdlBveTE0ZE1mS1h0?=
 =?utf-8?Q?zwicohCGEkJEzf5eD9s/fiMtT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0070d8d8-af7e-42c9-4331-08dc9f674c3d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:01:59.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtalitup7sCpy1GYTbhAK9b5fWAT/Hb+BHlCvZ+0IPIFsPNacqphF9I9EEGyPWvI2TK0MNxbNb5JHthpnV4Mgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9330

On Sun, Jun 30, 2024 at 09:53:37PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 17, 2024 at 04:16:45PM -0400, Frank Li wrote:
> 
> You don't need the colon after 'Call' in subject.
> 
> > Invoke the common PHY API to configure mode, speed, and submode. While
> > these functions are optional in the PHY interface, they are necessary for
> > certain PHY drivers. Lack of support for these functions in a PHY driver
> > does not cause harm.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index ab0ed7ab3007a..18c133f5a56fc 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/reset.h>
> >  #include <linux/phy/phy.h>
> > +#include <linux/phy/pcie.h>
> 
> This should be moved one entry above.
> 
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >  
> > @@ -229,6 +230,10 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
> >  
> >  	id = imx_pcie->controller_id;
> >  
> > +	/* If mode_mask[0] is 0, means use phy driver to set mode */
> 
> /* If mode_mask is 0, then generic PHY driver is used to set the mode */
> 
> > +	if (!drvdata->mode_mask[0])
> > +		return;
> > +
> >  	/* If mode_mask[id] is zero, means each controller have its individual gpr */
> >  	if (!drvdata->mode_mask[id])
> >  		id = 0;
> > @@ -808,6 +813,7 @@ static void imx_pcie_ltssm_enable(struct device *dev)
> >  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> >  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
> >  
> > +	phy_set_speed(imx_pcie->phy, PCI_EXP_LNKCAP_SLS_2_5GB);
> 
> Is this setting really universal? This looks like applicable only to specific
> platforms supporting this link speed.

phy layer just ignore it if phy driver don't support set_speed, like other
phy API. Check platform will make code complex and without benefit.

But it should be better to set SPEED as the same as CAP register.

> 
> >  	if (drvdata->ltssm_mask)
> >  		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
> >  				   drvdata->ltssm_mask);
> > @@ -820,6 +826,7 @@ static void imx_pcie_ltssm_disable(struct device *dev)
> >  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> >  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
> >  
> > +	phy_set_speed(imx_pcie->phy, 0);
> >  	if (drvdata->ltssm_mask)
> >  		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
> >  				   drvdata->ltssm_mask, 0);
> > @@ -955,6 +962,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  			goto err_clk_disable;
> >  		}
> >  
> > +		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> > +		if (ret) {
> > +			dev_err(dev, "unable to set pcie PHY mode\n");
> 
> s/pcie/PCIe
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

