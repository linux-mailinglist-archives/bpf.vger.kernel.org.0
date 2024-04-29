Return-Path: <bpf+bounces-28126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EC18B5F78
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6730EB21A05
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189478626C;
	Mon, 29 Apr 2024 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rwopRnz8"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276058595F;
	Mon, 29 Apr 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410045; cv=fail; b=cj8msIv3Z5wx5zXYJWFryorxgs6fpi0jPM0Wh+exFarxxIuf8ky6bZWlKTw04Xg11INUFbD8dNjB+i1339K2N4jARZUPYcC1LSJQhTt2Ws2g5QRBtcvE1REqhmHO/4FRMjG+AMflMXbSv7KbjAlUXnMAgeTkbbAS4Zxu05mTQBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410045; c=relaxed/simple;
	bh=zvjt6O+81kDWzoTb0bDlf5vzwvu9lSlw9onS8Qs5cQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=URDSy+ANF8zsJH6kpoMzxIR5D8/WxnZBDQAwcyWDphYTXInA0kjoT7SOJAarht1i5j33PKEzxX1/eDjEaagNy9uhqkFycONBtoFZ6WKcSG9PBWLZw8H+MIiJSrKfdxguass/OBGvMfVsQlFxQoGGtLATun6y49fjRLwFRGrdas0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rwopRnz8; arc=fail smtp.client-ip=40.107.241.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZjtXy6+H94HMRUI/wYr1TWhcdrU+l/jIQFtEF6cqHMqSi3VJtWK0oWMxm/QTCTLd/KsR40rdu7Tx4Nrw8AHmXP5Q8krNw5Fe2fuzsYcDyLfhwe5rqyHqrhMfgoRDXmlgVlUWuj3YqzLbyADrzoSdrXdnXwjDKjBiA4PGJuldqvbO6kNcEL8x6Tq5+eMeA5jFCvRg9NhuKAEUu3WjUEwnRbmG17TNXehf2XxavPwL4W4mny+TV7SGLKBm96DpImGp1hWIY8ht2UvtnIiw7dzSnx3j05THTplLqK/1ssCvIw0VzefH1rkqr7yl9bx6XzzNEViXQ9AATOPuqmJ0Et3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJfFiZPVOXLfqvawNLtUWOkQQFjszgzSvLvaksnNFnU=;
 b=nWWOZ60oSPoY+vmraZKmknLl1Z2uiFNFCjnaAenzkUctXSFYkOgLZVn1PWvEMSKJ91VkFNpJGVz7kG7pMAYOLLSCKg8RDLnt++OCsMeo2dEQDegtgrs3/YcTUQuGE0DD3N2JtU7sqXnFYSP85nllNudBb9dD76mm1tXMt5zuP4XJgp3FfMWTSnYgOmFduZIYdJPIw5gPqhBl5yMfJFY6453akcK74idJZxAR56Rpl+ijLSwFJBRDzYfqRcTZaWR+4L+MeUiORG7rsNXW3arsYrDvB4nhSsiJojtTzeLIYKwNFhLAALf9kBWTA4O7fRKWdDJ1zPMT5eB/2RveSFqQXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJfFiZPVOXLfqvawNLtUWOkQQFjszgzSvLvaksnNFnU=;
 b=rwopRnz8D+Gvzhk77JrZerknk/JVmpf1zSukVHOUOyXllJ8vclAXXx0m2sciZBAM6ZF5SxVCdE8OYNDPPmaMqNF6iyDyiCKxDHrpGgXgjBvcp+FJrElb7sZ236OhM6Z3jv8PWuRobvLhMf4DBcIhsX31asjc835UboF315yQCB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9047.eurprd04.prod.outlook.com (2603:10a6:20b:442::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:00:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:00:37 +0000
Date: Mon, 29 Apr 2024 13:00:26 -0400
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
Subject: Re: [PATCH v3 08/11] PCI: imx: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <Zi/SKgO6TkrCcsj3@lizhi-Precision-Tower-5810>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-8-803414bdb430@nxp.com>
 <20240427113643.GM1981@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240427113643.GM1981@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 547dfadf-7f76-4bb3-460c-08dc686de429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|376005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXdpenlWTndaOW1lN0NXOXo2THVOZzl1c1lsQUtUMTNDRHlrMjFydjZKdnYy?=
 =?utf-8?B?MGNNUDJzTmNzNk5Td2REay93M0ExUXFtZkdaZ2hzTGF5QXI2WngwM0g4Y3hO?=
 =?utf-8?B?YlV3RkZCdGM0UFlpakFoeS90Z21FTjhIUDBYSS95WEpnQ0dsLzN0SFhreWFy?=
 =?utf-8?B?eWRWa1ZCRFgrTktDM3JUdDhxdkxLZ01rQjlNZ3JTajdFUXJjaXNRa1NKNndY?=
 =?utf-8?B?cUtFY3ZadzhGdjlzUXFaNWVWTHdtdzJta1JTbjB2MHdZS1ZObFNNWkF3V1Ft?=
 =?utf-8?B?d2FWT2NjbWVuS3VTQis2Zkg1N1hxM0phNzRML1doUC9VVGpyQkdPcDNTSnB5?=
 =?utf-8?B?RmpIUEJTd0doRnFhS0NwWW1BNFRkQWlpbXZHbjB4ZG5SNDFCVDlVSFF3S2pK?=
 =?utf-8?B?bDl6UlVUcGw2RnFZRHZmMlNWMG0yaDkyVk41Y2FQRnhWWlFmNHVCS0FDVzdu?=
 =?utf-8?B?UHQxaEdIQStwR2ovZGl3eTQxL0F2TVRZSEs3ZjRVM1puSFY5Z2V2aGwzMWxW?=
 =?utf-8?B?am9pN1lrTi9EN29UZzFIZlpBbE0zRjlIMU9BTkVGTm5wcDNLSEZVbjhUR3Vt?=
 =?utf-8?B?TnBkSnNSdVlnVXhtWEhpNGdhOEk4MXhRZDlzVXhaUkRGeWJIeERHQ2czVjUz?=
 =?utf-8?B?aG5ORGQ1TzV3QmFrYVJueVdIcGtvekR6NkJEK0lXVFNENTVXKy9JNGlVaktE?=
 =?utf-8?B?bE9LTS8xMHBONXI5bUppd1A0SndXdll4UEM1YmNEVnQ5dzZkK1FIZGhzSVd6?=
 =?utf-8?B?SEZBUGk0dGRuK2FmdlRMbGZmNmJXa29aMS9vNTVhUHBjREE3TFJQbHVtSzFx?=
 =?utf-8?B?aWFaZmU1bmExdmtSS3NPL1pSRmV6MzFGSG9jaksyWVkrZ0kzbitPdUFzZDFY?=
 =?utf-8?B?MGZzeXMwNWVIQU5wT0lpSzFrUGZ1ZDVwNGZGaUJmbEtNMDRiY0NPSlJNUDBT?=
 =?utf-8?B?OWNYcmdjdkw3cDRpT0NSZHZWWGVjU2N0R0ZYTGxMSHo2enFhWmwvUkpGZUM0?=
 =?utf-8?B?R1JlUFNXMG9DUmV3bkhRN09hRDM1dnhJRkVKbHRLdXpqWjI3TDNLdkxTRTRn?=
 =?utf-8?B?WStkZkE1UjAvcEM3dWI2eldLZy82MGpodlFvUHVVMVBWK0hERkl1Z0NXSENI?=
 =?utf-8?B?WW1HQnBYWEhmMGJzNCttWXRKeCs0aElWSDVjV2YxV2xpd0hLdGlNZE9VZDd1?=
 =?utf-8?B?NWgvb2Vxa25iVkFPamJRUEFEVTEzK3RGY3N1OUIvSHpub2Zrd3ZMMlRSZWp1?=
 =?utf-8?B?cFFGVkEzdUpRTklFN0lqNmRuRWxUSUJ4cUVGSXZVZXJNT1NESksrRkhuWk5N?=
 =?utf-8?B?dHlhY1JCUGhZRjhnWnBOTmVxTERUK1FmbjBNUjBadHgreENoVmxSK29senVw?=
 =?utf-8?B?QTJZNDZaWFptS3piWjMwazlSVk04bjdYQmJzZE1vb0lSUFV0ZDlZcGFBZllp?=
 =?utf-8?B?RlVYNkhWc3AxK1BLWlNXYkY3VGYvZ1dXYmhsUFdxVmJ5WGI3Q2FIblpUdVVH?=
 =?utf-8?B?c3d0L2RnODRxeUx5enRvM3ZlWnd2WkRZVFVReXdFTFZoOERreEpjYnQ0Tkpi?=
 =?utf-8?B?eXdEbmVJdTRYamcySVUwVGJyNFg2WTJkRHdVd0JpejRaTkdrQkNzNXdod1JI?=
 =?utf-8?B?V1JMUUdJelBpYk1JWWhpSUJIeUNVckw5WjVad2hoWnZScHF4Z1pzUFFKWE00?=
 =?utf-8?B?NjZPRkRnVWpUQ3VzUEtQNGluZWUxN2x3NG9wTjFGRWoyWHBQd2c0K1dPU29s?=
 =?utf-8?B?UFFIdGNacEt4cDFWQVRvOFNwL1dUSnhFcTAxMnhRRVZjVFFSclhnc3dhRUZ3?=
 =?utf-8?B?WEUrU3AwODdyL2hKcXVVdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVNUZm5LaEVhenBlZ3NmSG1uU01RZnlYMTVDUzEwczVLTEU4S3g2OS9YSTd1?=
 =?utf-8?B?Z1NVSGwxZVhGTmp3aGFQUUN3by9pSUxaWG5HVlR6WVdXZUhBNlVHbGFmWE1M?=
 =?utf-8?B?QnRRM3B1MUtERjZNRDRrR0NueDJQRTMrNjhYUWRremU3V1NYMitjUy8xNEF6?=
 =?utf-8?B?Vkh0VzJpNTBZSmV2TVk5M3FieWxIT2xpcGVRRDlURDdtSzhoLzJvdGZGdmVk?=
 =?utf-8?B?VDBSMmJydldzdlhLQTcrcyt2S293djJZQUN5Qy9zZGpBYzlYbUVSTjNmM2RJ?=
 =?utf-8?B?ams5cFlMMStVTTkyT1BncUNUcjhENnhKbmZtL3FaZnRkV2dpSjhXV0ZoaDFi?=
 =?utf-8?B?S0M2bjBFdXVDdmcvNjJjSFJnQ05XV2lLbzAwMVVZYnliVm9FRXd4MGgrTFo3?=
 =?utf-8?B?R1M5WTJ0VzNJN1Y3YlRzSWdjeDFibS9GaWhaRUxKcnlSK3UyT1B3UVZuV2ly?=
 =?utf-8?B?ajFEdVd4dXB1S1Y2cHA5Nk85YzZodldTMHJ2OXJtenVISlMxb3JMZWtXQ0Rx?=
 =?utf-8?B?S1llQ3FwNG0vejlBcG9KTEVIY0d1dEQ1NzlNZG1lbTRqcUdsYU1oOU13eUsr?=
 =?utf-8?B?dE9yZG1mRURsS2RMMy9idkdQK0NYWXNLdTJUdW5KRytTVnBabUpZdEdlUDVU?=
 =?utf-8?B?eEZkSC8wOFphMEdsdEN1V1l0ZnZFNytJVkxpZlVPOUxkbmI0NG9xVTM0MEpk?=
 =?utf-8?B?R3Z0ZjlZd3oyT29RaGk2REF3UHZQbWlTZlcvYkJXNXVwR2lteEUrMW1kMmNk?=
 =?utf-8?B?UytKbEtvQzErN2pJbDNCakEvamVvYTEzUGtmY2NMMjRWYzJOM2JLWFU2aXFW?=
 =?utf-8?B?WDdCMTUrYlJUcnpwZlhtTVhobDZnNkw3OXdGMW1SWVM5VXF0SmdpeWJUN0Zx?=
 =?utf-8?B?MjFvZU5nSkt5cXVSdzNuMjFCVlBZeXk4VExuVDNjY3E0WkE0czhFL0V3ZlBE?=
 =?utf-8?B?UVBCcDNvVFdpU0NURkx6RG50VTlFMTJ3RTZZeGNlWDZaRG93amlmZVhuNjRI?=
 =?utf-8?B?cktCT2lYWWxHQWhFU1Q3amdLNndTSTYvQ09hVUNtOEh1RnJOKzExNjFtZDBs?=
 =?utf-8?B?Z1Y1Nlc2Q3BSZUgwWWV0UDVJNmxMNXdmMlpRRWZSWklLclMvOERKcGFpM3pX?=
 =?utf-8?B?azllZE9XM0lURk9VY1AvSWZGRUhEWjFBeUo0UnBLcThaSEZhSFR4dUFZME4v?=
 =?utf-8?B?WlZFaERxK3loK3o1Z0pjdlhjcHZ6aC8zTTFjS1lQNkloMmlEdjl2U0Z3bDA0?=
 =?utf-8?B?cithLzh2bENzQUUyeFE2NWU5YzNwWFAyNG1OUTZyUTQ3SmZCbmdBNzU5K0Jm?=
 =?utf-8?B?RTlFMHdBdWZHSVdUQkpFVE51TDlLRG1wQU9PRDMyeUJuR052Qm5rL3JsNWx2?=
 =?utf-8?B?VUxGdDZtaDBwczg3UVpVT3dTakd5c3h1RmVjQW1adEpJaTJsaUp2RDBLSEd5?=
 =?utf-8?B?Q25URlJJdkhnbFBQa05IVlVvcHlxYVZiOElXVkFBNWc1eVo2Q05yR2NCWWxo?=
 =?utf-8?B?RE9Xa01Dd1BORjlDMzRMd05lNE5uM3VrV0NaRG9qdzNQVm5xbG1HcGRVam1X?=
 =?utf-8?B?dnVYSTNSVUppM2dFRDhxSG1HeW45eGJDd1pSOHVuUW9wSk9WcWRoUXdmMHhD?=
 =?utf-8?B?dWpMYS9OQ3pOTjh3bDlOcmdKVWo4RFNXS1F0YWpETmtVZ1FTejdFRWwwcEV6?=
 =?utf-8?B?M0tEb2dmQWh2M0tPUGxMZGtmeTBHWGxXTTZwOElBT0sxT0JFNDY3Z21VV3kr?=
 =?utf-8?B?RUhVVjBERFJjQ2M0YktIa2NKOWMrdmlPVTdSZGIzMGtaUkRSMEwvMCtQVGla?=
 =?utf-8?B?RWNCZ2dNSlpkNjExM1ZNa202U2lENHBqQjVEYXgvQUxuNXNVMEJKSWxFUXJk?=
 =?utf-8?B?VEFqd2Y5YXhkWDNERmtsdHF1NTJFZGJ5b3pMWUR4SXNWV3VFbHFjUmt2VkND?=
 =?utf-8?B?OTk2UFRjbm41dlRhRkEvUy9oMVkzS3Y3bDlWbVJWNDIrMU1LTWNoczJBWGE2?=
 =?utf-8?B?WGZjWSt5dHJuL0JiTFVveUcyeENLcU5xNDErZDY0MGpNb0lCTThIS1FUWGdN?=
 =?utf-8?B?VDlabDY3ZEEvWVNUY25xbEFkY3V6ZnFYVUJua01CcTdrZnlMZStyMGFhdlRx?=
 =?utf-8?Q?fh7c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547dfadf-7f76-4bb3-460c-08dc686de429
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:00:37.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3mHBMRQyruIBomYXkec6XezL8L8EfBFgtPLze6YVf5fsqZppANVjfiRDQXQ5mdgfWBrbM9UJ+XLIBYnd6HVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9047

On Sat, Apr 27, 2024 at 05:06:43PM +0530, Manivannan Sadhasivam wrote:
> PCI: imx6: Add support for configuring BDF to SID mapping for i.MX95
> 
> On Tue, Apr 02, 2024 at 10:33:44AM -0400, Frank Li wrote:
> > i.MX95 need config LUT to convert bpf to stream id. IOMMU and ITS use the
> 
> Did you mean BDF? Here and everywhere.
> 
> > same stream id. Check msi-map and smmu-map and make sure the same PCI bpf
> > map to the same stream id. Then config LUT related registers.
> > 
> 
> These DT properties not documented in the binding.
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-imx.c | 175 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 175 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
> > index af0f960f28757..653d8e8ee1abc 100644
> > --- a/drivers/pci/controller/dwc/pcie-imx.c
> > +++ b/drivers/pci/controller/dwc/pcie-imx.c
> > @@ -55,6 +55,22 @@
> >  #define IMX95_PE0_GEN_CTRL_3			0x1058
> >  #define IMX95_PCIE_LTSSM_EN			BIT(0)
> >  
> > +#define IMX95_PE0_LUT_ACSCTRL			0x1008
> > +#define IMX95_PEO_LUT_RWA			BIT(16)
> > +#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
> > +
> > +#define IMX95_PE0_LUT_DATA1			0x100c
> > +#define IMX95_PE0_LUT_VLD			BIT(31)
> > +#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
> > +#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
> > +
> > +#define IMX95_PE0_LUT_DATA2			0x1010
> > +#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
> > +#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
> > +
> > +#define IMX95_SID_MASK				GENMASK(5, 0)
> > +#define IMX95_MAX_LUT				32
> > +
> >  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
> >  
> >  enum imx_pcie_variants {
> > @@ -217,6 +233,159 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
> >  	return 0;
> >  }
> >  
> > +static int imx_pcie_update_lut(struct imx_pcie *imx_pcie, int index, u16 reqid, u16 mask, u8 sid)
> > +{
> > +	struct dw_pcie *pci = imx_pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	u32 data1, data2;
> > +
> > +	if (sid >= 64) {
> > +		dev_err(dev, "Too big stream id: %d\n", sid);
> 
> 'Invalid SID for index (%d): %d\n', index, sid
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
> > +	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
> > +	data1 |= IMX95_PE0_LUT_VLD;
> > +
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
> > +
> > +	data2 = mask;
> > +	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
> > +
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
> > +
> > +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, index);
> > +
> > +	return 0;
> > +}
> > +
> > +struct imx_of_map {
> 
> imx_iommu_map
> 
> > +	u32 bdf;
> > +	u32 phandle;
> > +	u32 sid;
> > +	u32 sid_len;
> > +};
> > +
> > +static int imx_check_msi_and_smmmu(struct imx_pcie *imx_pcie,
> > +				   struct imx_of_map *msi_map, u32 msi_size, u32 msi_map_mask,
> > +				   struct imx_of_map *smmu_map, u32 smmu_size, u32 smmu_map_mask)
> > +{
> > +	struct dw_pcie *pci = imx_pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	int i;
> > +
> 
> 	if (!msi_map || !smmu_map)
> 		return 0;
> 
> > +	if (msi_map && smmu_map) {
> > +		if (msi_size != smmu_size)
> > +			return -EINVAL;
> > +		if (msi_map_mask != smmu_map_mask)
> > +			return -EINVAL;
> 
> 	if (msi_size != smmu_size || msi_map_mask != smmu_map_mask)
> 		return -EINVAL;
> 
> > +
> > +		for (i = 0; i < msi_size / sizeof(*msi_map); i++) {
> > +			if (msi_map->bdf != smmu_map->bdf) {
> > +				dev_err(dev, "bdf setting is not match\n");
> 
> 'BDF mismatch between msi-map and iommu-map'
> 
> > +				return -EINVAL;
> > +			}
> > +			if ((msi_map->sid & IMX95_SID_MASK) != smmu_map->sid) {
> > +				dev_err(dev, "sid setting is not match\n");
> 
> 'SID mismatch between msi-map and iommu-map'
> 
> > +				return -EINVAL;
> > +			}
> > +			if ((msi_map->sid_len & IMX95_SID_MASK) != smmu_map->sid_len) {
> > +				dev_err(dev, "sid_len setting is not match\n");
> 
> 'SID length  mismatch between msi-map and iommu-map'
> 
> > +				return -EINVAL;
> > +			}
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Simple static config lut according to dts settings DAC index and stream ID used as a match result
> > + * of LUT pre-allocated and used by PCIes.
> > + *
> 
> Please reword the above sentence.

How about:

"A straightforward static configuration lookup table (LUT) is established
based on the stream ID specified in the DTS settings."

> 
> > + * Currently stream ID from 32-64 for PCIe.
> > + * 32-40: first PCI bus.
> > + * 40-48: second PCI bus.
> 
> I believe this is an SoC specific info. So better not add it here. It belongs to
> DT.
> 
> > + *
> > + * DAC_ID is index of TRDC.DAC index, start from 2 at iMX95.
> > + * ITS [pci(2bit): streamid(6bits)]
> > + *	pci 0 is 0
> > + *	pci 1 is 3
> > + */
> > +static int imx_pcie_config_sid(struct imx_pcie *imx_pcie)
> > +{
> > +	struct imx_of_map *msi_map = NULL, *smmu_map = NULL, *cur;
> > +	int i, j, lut_index, nr_map, msi_size = 0, smmu_size = 0;
> > +	u32 msi_map_mask = 0xffff, smmu_map_mask = 0xffff;
> > +	struct dw_pcie *pci = imx_pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	u32 mask;
> > +	int size;
> > +
> > +	of_get_property(dev->of_node, "msi-map", &msi_size);
> > +	if (msi_size) {
> 
> You mentioned in the commit message that msi-map and iommu-map needs to be the
> same for this SoC. But here you are just ignoring the absence of 'msi-map'
> property.

If msi-map not exist, it will be fail back to use DWC's msi controller
insteand of ITS.

Do you think need comments here for that?

> 
> > +		msi_map = devm_kzalloc(dev, msi_size, GFP_KERNEL);
> > +		if (!msi_map)
> > +			return -ENOMEM;
> > +
> > +		if (of_property_read_u32_array(dev->of_node, "msi-map", (u32 *)msi_map,
> > +					       msi_size / sizeof(u32)))
> > +			return -EINVAL;
> > +
> > +		of_property_read_u32(dev->of_node, "msi-map-mask", &msi_map_mask);
> > +	}
> > +
> > +	cur = msi_map;
> > +	size = msi_size;
> > +	mask = msi_map_mask;
> > +
> > +	of_get_property(dev->of_node, "iommu-map", &smmu_size);
> 
> Same comment as above.

If iommu-map was not exist, it will work without iommu. the combination
as below (4 cases).
			not-exist          exit
msi-map                   dw-msi           its
iommu-map		  by-pass-mmu	   smmu

Require stream id must be the same only when both msi-map and iommu exist.

> 
> > +	if (smmu_size) {
> > +		smmu_map = devm_kzalloc(dev, smmu_size, GFP_KERNEL);
> > +		if (!smmu_map)
> > +			return -ENOMEM;
> > +
> > +		if (of_property_read_u32_array(dev->of_node, "iommu-map", (u32 *)smmu_map,
> > +					       smmu_size / sizeof(u32)))
> > +			return -EINVAL;
> > +
> > +		of_property_read_u32(dev->of_node, "iommu_map_mask", &smmu_map_mask);
> > +	}
> > +
> > +	if (imx_check_msi_and_smmmu(imx_pcie, msi_map, msi_size, msi_map_mask,
> > +				     smmu_map, smmu_size, smmu_map_mask))
> > +		return -EINVAL;
> > +
> 
> Hmm, so you want to continue even if the 'msi-map' and 'iommu-map' properties
> don't exist i.e., for old platforms?

imx_check_msi_and_smmmu() will return 0 when smmu_map is null.

> 
> > +	if (!cur) {
> > +		cur = smmu_map;
> > +		size = smmu_size;
> > +		mask = smmu_map_mask;
> > +	}
> > +
> > +	nr_map = size / (sizeof(*cur));
> > +
> > +	lut_index = 0;
> 
> Just initialize it while defining itself.
> 
> > +	for (i = 0; i < nr_map; i++) {
> > +		for (j = 0; j < cur->sid_len; j++) {
> > +			imx_pcie_update_lut(imx_pcie, lut_index, cur->bdf + j, mask,
> > +					    (cur->sid + j) & IMX95_SID_MASK);
> > +			lut_index++;
> > +		}
> > +		cur++;
> > +
> > +		if (lut_index >= IMX95_MAX_LUT) {
> > +			dev_err(dev, "its-map/iommu-map exceed HW limiation\n");
> 
> 'Too many msi-map/iommu-map entries'
> 
> But I think you can just continue to use the allowed entries.
> 
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	devm_kfree(dev, smmu_map);
> > +	devm_kfree(dev, msi_map);
> 
> Please don't explicitly free the devm_ managed resources unless really needed.
> Else don't use devm_ at all.

It'd better use auto clean up function __free(kfree) here.
> 
> > +
> > +	return 0;
> > +}
> > +
> >  static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
> >  {
> >  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
> > @@ -950,6 +1119,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  		goto err_phy_off;
> >  	}
> >  
> > +	ret = imx_pcie_config_sid(imx_pcie);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to config sid:%d\n", ret);
> 
> 'Failed to config BDF to SID mapping: %d\n'
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

