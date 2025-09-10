Return-Path: <bpf+bounces-68023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6490FB51AA0
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDA71888151
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E37343205;
	Wed, 10 Sep 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RCBmXqae";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="XXby0gLM"
X-Original-To: bpf@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E7322A26;
	Wed, 10 Sep 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515584; cv=fail; b=K1sQ/xlqdu5AiCKuzmHlmYJPpWS3A+Ea/2xIJPxTv7FbSMYMA5ok7pZt5Q8Nj7tpAqJpewYwkhPeJcLlQ8TmPcAtXkwgRgfs3lkcUQ59k/rr6XNyiHkEzE3Y6TgggFWAlneQwkO1zRJ50kSjJAchpqZxtn2NPUC1fcXxY0nseVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515584; c=relaxed/simple;
	bh=6uGt5jsFHIdxaOObXyaSLDfrUtZj2xo6WeC735R3xaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fRwZkDhpw01SveC+YteKgQ/Kiir3pexLQHC7ggnuMTGDePAaJ/+MXzblOw4f9vS3VC3x1/EOc9xGHyzEwl0JS3j3OX2Dy6FIMQi/K30bZVDli4KI6pSD/S5utPXVFNRE1mQoKceT9p5adfWUluejhDhVjRgUiPWktbuV/v08kjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RCBmXqae; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=XXby0gLM; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACbckM018131;
	Wed, 10 Sep 2025 16:39:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ZLLb/w+BrV8792a+5Bau6IxvrSeiHe/QT6l9p0FRvfY=; b=RCBmXqaeKVEmXN3R
	e2/RQEn+8cS5aZiYp8b5P2ALR5PdaRAYNgWSm6L+SOF9MW+wmtx1X0a6pNfSa6pV
	NfZRD/Bq2qomQG5wXSDcDsFpVx5D02XcpCTRfUIXe3cxZODPiPeCk0bHQmOalL5W
	+xuiqS5pA0lWSGou2Y6L3Y0+QbEC6OvhVKjau1X/119l/5oCN2s3udWW/qYBz+7S
	6h1zKj305MWO8TNXktXLIUzjMnauQOSMmDvr4b343x4COIlWOT3p+Ft2k/AcZF8x
	FSUM++l9trMqGy/Eaf/g67SH5tTCHUXQji3GsnIplM4nyZQx69ClxX5fT9oVKWEV
	LFTj/Q==
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4929f0yuwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 16:39:18 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO/m9VR3PrwTyajco70X5qvohgDV2zKurRzjDNBaHYhHabbrBV9lVP+DBVMaV7jOHqOAEnlkJf1uDj81t4No4bqddqoSdKXUKS2a+/Db7U57ZHLX4aqmzDOsmk0/mS5qwf1gSpcUG9kIqh2I4dZdj+FzlsO+bV4NILv8H5ELfWKtonQlTcbMPkceEz0NoxoAiAOBS91DWXPmzeJat4+6ivpQrjwwrlByVqrq03kO3wH3V6UlFafEjFTzacxiz7eamaG5iRFinnSvr1CWg+eORj+YzzLALWXAOX4mX+4Gc+0p9Xls1Me1Z3hbz/QTloY9Ej1dQlgrWbsC7sjt/kEYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLLb/w+BrV8792a+5Bau6IxvrSeiHe/QT6l9p0FRvfY=;
 b=lD+gciZy1/Tnpp/Rbo4hyRMLeWvyC+taNNg6yO9AGzcl7qEICpNYK8AW/3z6+dRWzZF7IsT/sGGURIiEBypjKfd5y/WZns7FrurBM0Q9wv9jO6ikzRUVY33TiBiBQiL+8vSOva3T++i7ryvd3xmTi2F/77RBilOqKYf137bM8ewzfIQ6FS8xppaOBEgif+SITGpDN/RHxT0L8YyOD5US4AWGza7b9fHRTLxwz3qfLctkj2SGikTr7ZEXo9nVo/rXvNxTAGcQON/ak7hvS0Sed7HNVn26wIp/1QIb1Yi0iCdDBr25vv+P9WWzfrahdpilhSEcDY1YclL9dpeRa5KKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLLb/w+BrV8792a+5Bau6IxvrSeiHe/QT6l9p0FRvfY=;
 b=XXby0gLM5A49VmhN2cQbeH7JZ7eBqMclTSegeNlouVHbFDsPzMB2BqSn1x275uZsrmRbwyw7gRmsGgFAdu4GsL7xdX9pWewKlP7ffzQZ9oAxiWeODpIkH6pT197saHjDqq0bxV4F6eyfjU17wbw3eOZGwdQxR8Bq7HCWcr3GWxc=
Received: from DUZPR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::17) by AM0PR10MB3332.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:39:08 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::37) by DUZPR01CA0171.outlook.office365.com
 (2603:10a6:10:4b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Wed,
 10 Sep 2025 14:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 14:39:08 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 16:36:46 +0200
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 16:39:06 +0200
Message-ID: <30168f27-aec7-4ccd-b66b-c1ffa215293b@foss.st.com>
Date: Wed, 10 Sep 2025 16:39:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH net-next 06/11] net: stmmac: add
 __stmmac_release() to complement __stmmac_open()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: Richard Cochran <richardcochran@gmail.com>,
        Jesper Dangaard Brouer
	<hawk@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        "John
 Fastabend" <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, <bpf@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>
References: <aMBaCga5UAXT03Bi@shell.armlinux.org.uk>
 <E1uw1Va-00000004MCL-2B4O@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <E1uw1Va-00000004MCL-2B4O@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|AM0PR10MB3332:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce19e0e-553b-44fe-01f3-08ddf077ccb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnZlTGdTTVV2OTcvMzMyT2h0bFRsTEpFdHNxZmtoQVJYcHhHWVZXaG82UVJY?=
 =?utf-8?B?SnVJREZDVlZoYkF0ZXNsRVN1a2lhWGYxQ1ZYMytKL1BhMEV6bnA4Z2x5S0cx?=
 =?utf-8?B?ZVJ0UnA3RU1LZ3JlTm1MVnNzaTV2cWFKOU01YkZEY25RTHhrL1BjeDh6TXFn?=
 =?utf-8?B?Q250cXFDK2tmK3ZHTkhQbGFKQ0I0d2JJY3RXb0ZOS2lETEZhR3V6OFo0YWU4?=
 =?utf-8?B?ZFR6TFR6WTdYa3gxb1FQZE1QY1I1QW1EMTlxeDBzTVdaRjg5aDdHV1RmQTdY?=
 =?utf-8?B?QU03MEFTcVFyWkxWOUlhVUQybnBLSkJ5a1YrUU5GaWo4V3kyQWJ6ZnNoZzJo?=
 =?utf-8?B?YjczcnpUMEFkTXRmWko3RVhVZFJoNkRUajhISGNxZlpoYjVwVlQ2dDhsQkVu?=
 =?utf-8?B?bE5NZ0g0Vzc5Wm82VjBQL2NHUzZpVExTeUROYU9Dc1BEVkhHOG4xenRXMkZp?=
 =?utf-8?B?WU5rRjdSMUZTQUJSc3F6RkNCQUdYNWtXOCs5RVJFb0Q3Y0RGUzFjbzBpYUhJ?=
 =?utf-8?B?aEJYNnlnM2ttN1E4WWpZNHhpUmhaZlQzR0ZPQjRSMUduaHVTcUlzdHI2eXJY?=
 =?utf-8?B?NjdBQ1E5emI5NU41WWU4MmZmNncvb0ozQlh0NEdySko4ajQ5VlVtbC9WMXFr?=
 =?utf-8?B?YWtPZk56ZzRtelFGMEdURGs1SWhiWDdHVUYvUUQ3cEVMd2V1RVFkQ1N6NzVk?=
 =?utf-8?B?TW1kTmVoNDllZVFldHJhRlhyd0Rub3UxU0huaGViczA0Si8xMWIzWFFaSEJU?=
 =?utf-8?B?NVVhUWZZT3FXZTJ0TXI4UjFxVjZjMjVva3FwWENWMVVTYUFHWjNLcmc0allY?=
 =?utf-8?B?Y05vUVRzSmhocUZEeVJvL2svczg1ZFRha3ErT3UwVVgyY1FTNThQQU1ST1Nu?=
 =?utf-8?B?b1VieDI0dmN6OTVHMnYvSkVHM2pSUGVhanhYSzZWQi9jN1U4ZGFjMjRPV0Fu?=
 =?utf-8?B?NWFiSXdKWE05eGFFVTZnejcveEpNQkVZcXJEV3BDWHNCd0s4aUF0Y3dOK0gy?=
 =?utf-8?B?TmIzeStjYzR4eGJOQ0lWSEVVeWNqNjdvSHZkd0Vtci9BanQyNE9icnVDL0FR?=
 =?utf-8?B?ckdDWEM5dDJuTStaUDZRay8xVUpFRi9TMXBLRGpJL2gweWMxNHB6Vm5Cc3hZ?=
 =?utf-8?B?cGh3Q0FOL2k0TFI0MUkxOXY1b3I2MGs5Y3h0emptYlBnd1pqaTVnTC9aZlFk?=
 =?utf-8?B?THZMWEZTa1JuVWQwWStUSTVlZVgyTElqaEhqdVIvcWNpZmtkamJjWmpNSlVB?=
 =?utf-8?B?RG9ZTFFmN0NvbW9VUUk0czF6VEVocmx1ZE5KVEIxakcxdzU4dThxanYwanpK?=
 =?utf-8?B?QnJYKzZENjA3dnBxMjlCeFNVZ1Vscldac3N3ZGhFQlZNSHRBbWVmQlhJOFVV?=
 =?utf-8?B?cXd2dG9jMFVXM3ZoblBJbWxVSC9VL041ZDVZVUlzNm1yUDh2emtsT0gyT1pp?=
 =?utf-8?B?UWMrZG5jUDhiYm10alNjVzUyejlaMS9MU0NRQzhkb08yd2dUZnl0bHorVy9R?=
 =?utf-8?B?TUZHeUQxS2R3L0x6bVlYTjJkTStxSjBJWFRsQVNGVE1rQjF4UEY1anl4aEdX?=
 =?utf-8?B?dG9tUGJLdktkTmFiaDlPVmgwOENmQ2hwMmpQOXdUMG05a1k3bUw2SXNydEJZ?=
 =?utf-8?B?aUI5NGs1d2VtSFF3TnNTdWVYVDRuaUpoK2Mrb3p3YzJzWGpjQ0pvWGtyYnlQ?=
 =?utf-8?B?bWgvY1AxY1ltSVlVRDFxT2RMTFZwcXpxQUd1WllIcElLVFdCLzlRSHJJN0ph?=
 =?utf-8?B?dGRYcXN3MXdxbmgwQm9KZFJNNUEvUnJBb3ZSTGJGcUNSQk41SXNvbHpPZUd4?=
 =?utf-8?B?NXpqUUJMYkNkYytkNDJ2dW5jTnFORlI2U2N0MUtEQ3F2SUdIUXdwN2RRMGQz?=
 =?utf-8?B?a0ptblVRckREMUlMc1FEMHNUZ2dlTEZRL1BEVkZPN0lPOHhFQlNWRm41VE92?=
 =?utf-8?B?dW55bFlXYnpXcllhYWRON0JnU0dzTlpIcm5oOXMrV3ovVzVubm16cUd3b0wy?=
 =?utf-8?B?VUhFY1IwTXF3S3dPRXk1dWlUN1JVcSs1WTJ5cDlEeTA1dTloRWgxaWhaeldm?=
 =?utf-8?Q?wkOqvL?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:39:08.1763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce19e0e-553b-44fe-01f3-08ddf077ccb9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3332
X-Authority-Analysis: v=2.4 cv=MrlS63ae c=1 sm=1 tr=0 ts=68c18d96 cx=c_pps a=hKIJfTMmGXcoSyh2svBxPA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=PHq6YzTAAAAA:8 a=pBqPG5E1Vc45DVLMjNgA:9 a=QEXdDO2ut3YA:10 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-GUID: _EA2WyxyhuLbceC2aLWny83vD7b1A-0Y
X-Proofpoint-ORIG-GUID: _EA2WyxyhuLbceC2aLWny83vD7b1A-0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDAwMCBTYWx0ZWRfX82HcVVV3I2gK DgBjBLYY3WtRHqDlp5ER/5FhyJu+0np/XjnMaLCC7rOj1Z9KVM+NehjNLQzrB+vQpqVZB30IrOj JNVxhvYZxhq3eEHziawpgMdi4tWpoIPS4zH0B+pMKLmRqPlOqtsxQ3vmS8fpAKNDbA+KpWKGqE4
 pEGjf5r9Xby3Y71FYLDvqq9sIxm8b2aqT7c4OxLIELSh0//yP1YLGGM08ATcx2YTRCKSteVafco r75UCpo63ghY+tqXudjgipXFiXZa8UQYvvWW6WDmAagfHuo15YqamaOLMcjkCKc5CdKxeVtqAIu lfYVd20ZdZ4NLe3HCr42e0thFpdx59dh+jXOAyXmdD9leI8WCFDNunpNyjpbYZLEeiyobmGsJgi Zj9oVo7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509090000



On 9/9/25 18:47, Russell King (Oracle) wrote:
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Hi Russell,

This is missing a commit message.

> ---
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 41 +++++++++++--------
>   1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index efce7b37f704..cb058e4c6ea9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3965,10 +3965,6 @@ static int __stmmac_open(struct net_device *dev,
>   	if (!priv->tx_lpi_timer)
>   		priv->tx_lpi_timer = eee_timer * 1000;
>   
> -	ret = pm_runtime_resume_and_get(priv->device);
> -	if (ret < 0)
> -		return ret;
> -
>   	if ((!priv->hw->xpcs ||
>   	     xpcs_get_an_mode(priv->hw->xpcs, mode) != DW_AN_C73)) {
>   		ret = stmmac_init_phy(dev);
> @@ -3976,7 +3972,7 @@ static int __stmmac_open(struct net_device *dev,
>   			netdev_err(priv->dev,
>   				   "%s: Cannot attach to PHY (error: %d)\n",
>   				   __func__, ret);
> -			goto init_phy_error;
> +			return ret;
>   		}
>   	}
>   
> @@ -4028,8 +4024,6 @@ static int __stmmac_open(struct net_device *dev,
>   	stmmac_release_ptp(priv);
>   init_error:
>   	phylink_disconnect_phy(priv->phylink);
> -init_phy_error:
> -	pm_runtime_put(priv->device);
>   	return ret;
>   }
>   
> @@ -4043,21 +4037,23 @@ static int stmmac_open(struct net_device *dev)
>   	if (IS_ERR(dma_conf))
>   		return PTR_ERR(dma_conf);
>   
> +	ret = pm_runtime_resume_and_get(priv->device);
> +	if (ret < 0)
> +		goto err;
> +
>   	ret = __stmmac_open(dev, dma_conf);
> -	if (ret)
> +	if (ret) {
> +		pm_runtime_put(priv->device);
> +err:
>   		free_dma_desc_resources(priv, dma_conf);
> +	}
>   
>   	kfree(dma_conf);
> +
>   	return ret;
>   }
>   
> -/**
> - *  stmmac_release - close entry point of the driver
> - *  @dev : device pointer.
> - *  Description:
> - *  This is the stop entry point of the driver.
> - */
> -static int stmmac_release(struct net_device *dev)
> +static void __stmmac_release(struct net_device *dev)
>   {
>   	struct stmmac_priv *priv = netdev_priv(dev);
>   	u32 chan;
> @@ -4097,6 +4093,19 @@ static int stmmac_release(struct net_device *dev)
>   
>   	if (stmmac_fpe_supported(priv))
>   		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
> +}
> +
> +/**
> + *  stmmac_release - close entry point of the driver
> + *  @dev : device pointer.
> + *  Description:
> + *  This is the stop entry point of the driver.
> + */
> +static int stmmac_release(struct net_device *dev)
> +{
> +	struct stmmac_priv *priv = netdev_priv(dev);
> +
> +	__stmmac_release(dev);
>   
>   	pm_runtime_put(priv->device);
>   
> @@ -5895,7 +5904,7 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
>   			return PTR_ERR(dma_conf);
>   		}
>   
> -		stmmac_release(dev);
> +		__stmmac_release(dev);
>   
>   		ret = __stmmac_open(dev, dma_conf);
>   		if (ret) {

