Return-Path: <bpf+bounces-68025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B1AB51B30
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DB03B9FA3
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FA330CD87;
	Wed, 10 Sep 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4oQROPxr";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="mz3CuLQh"
X-Original-To: bpf@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C0629E11D;
	Wed, 10 Sep 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517079; cv=fail; b=OTcz15bKRycm6yjxALkkBF4RZUnI4xH1BgWLuJzJGNVjZf9muGY/9zuqwZvYf8cmwLHe9JJIsFN0lQS2Qrw4wZXChRo719bQQl3fYtegaVFGjoPLFTqI9YhKnMmVjoVVQ21i33j37ERzzZLoJeSNLVy+e5B2+9FKO5/FYlWwtZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517079; c=relaxed/simple;
	bh=tpK7AbqpV2cPLoE0Yn+qjxxmFSmLJvKKKT6oXJzi4t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZRSjgL5c/2WrEN9jagF+2MFyt0b8zSoNJwznlqw1odJl6H4Zfh1NblZyqc/RMNblQTJbLPC5RUWfKAmlzxRhBtqcC4BNRLa+8+mXUkjw/CyP0eJDfJCr3L8OZ1pYczNU6aeh2ARvEydKY4THc1Ps0zl59qwwta9XkLGVDCg7oUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4oQROPxr; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=mz3CuLQh; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AEj99K023918;
	Wed, 10 Sep 2025 17:10:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	6TF5MWjgALEzQ8V7Pi/quy/8QlQZJDN/0z3LNTPUA7I=; b=4oQROPxr/OZkUWTH
	49vIOCNzq1Dl1c4lwv46BGToNQrJZ3uEwlE1cRb790BrPoXyHk+ZB0B7VD42gkep
	yMEgC13PmIYiupYLE4WqGxsmrZZNLCD1jGqGLuVVPKGmDBnjZt6zGFEdAhE3PNri
	jX73yZmyDjFm3wz9DSRKPI/q/AAurBMcTxh+1IgQXBdAShHrpCd6lOmcF4DkDmGB
	mjgM6GEsxPbSoz5DF4bI8g4maQbGJz58VNtwOAoTj8PEJpuDW2SBMM9ECnqTic/x
	PBrSCzyn6KJbRa6X2vMnKRXPrsnxEf/Fh5zuz2gI80cnwfrNnUWmMKAV0srVP8j2
	wcaOUQ==
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4934xjj052-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:10:41 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCy8V9bx0QvHvIlUqRRUg/Ub/ZPkmm3Xv3dZFa17zQ2RwvGKl0QO2NgpCPK7mxdC4tKynFO26nBAMsu0V8ROdz8OcRpLXCpLqj+tv/RTLwXF+povK0IWncjks9YnPqdCXRRRjLF2kl8j0zfp5iAlLQfgU67l6sNgX36mwy5aVBmoIekjiDseI42eOmq4qFE3UlBILdZ1PQde2hpztRRNJpMJZ67cOm80xydGuej7CMe6bP9p9W/e2NbAO/o8TR5tBXz/aDjToOyyWI0kutjZTs0n/ahEaFU9rmCXMJP3oWdudN/Yx02iT0EP9gO5+xfhjBe7EEu4IO4LNnXrJ8OAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TF5MWjgALEzQ8V7Pi/quy/8QlQZJDN/0z3LNTPUA7I=;
 b=fw8QTk9pYIcoGkLuj15OM9uv61YhZILkbOfuK9MSnXpcBTKQ9g+/66SPoaHJmT2iObpzVhlpEtyZ+NA6CbREMU/hsaUxVV3LTjjKwLg2Fmo6lzdNLGk1y3SxU8RbYPkqAsdMjM81/PxrsRCcoo+o+0eOgcYPTvmkoYKznzKK3MIoFJLArPKn1lUxYRhs8zQywcF/hGflipjcHU5wXD9nl4gyTcUb+AK9NjLs5Q2Qhew+Jj/v9RaY7eIhZVYNk4jgZGiL0nl/4l/05I9iZIOdE8gnk/Cj3BYQzSz/xeo4E4F6j9TSC6AZxw7nuW+SENvGB45rjZsTnCMaHWasuefXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TF5MWjgALEzQ8V7Pi/quy/8QlQZJDN/0z3LNTPUA7I=;
 b=mz3CuLQhL+TU1WR2D7GyTM/REwICgEix4LQ9/lOwi8MFYp19AdqQqBW/pHP2w2hmKr8k0jORIeDq4O2alGRY4WjDroFE56xgKb0pG04AIlhfpIzKqBZDQdBDhMRt8vVZgy3EQzaZdnFL+L56ZMZTZvJuFgDxyAtYRNqlI/tPAFw=
Received: from PA7P264CA0298.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:370::17)
 by DB9PR10MB8029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:10:38 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:102:370:cafe::9b) by PA7P264CA0298.outlook.office365.com
 (2603:10a6:102:370::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Wed,
 10 Sep 2025 15:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 15:10:36 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 17:08:15 +0200
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 17:10:35 +0200
Message-ID: <a275c50b-2bcb-4fea-bc73-b367d05dba08@foss.st.com>
Date: Wed, 10 Sep 2025 17:10:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH net-next 00/11] net: stmmac:
 timestamping/ptp cleanups
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
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
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <aMBaCga5UAXT03Bi@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|DB9PR10MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: c7de0e64-c9ab-46ed-5efd-08ddf07c3240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlZIaStBNVB0bi9YQ1p0bDZ6cEdvVGYxVnBGRm9Ca25BdDNuYVp1bjRhR0Zj?=
 =?utf-8?B?bE80Sk5qWkhJeTk4ZGc1VWpnNE5CQVladmdHbDRCZ2h3WHdySUZGYWt6bFpv?=
 =?utf-8?B?ajVNOTJYUVBlTjcyam1OKzYyaWlqQVJ2TWVZRnRaRFNITTNsODV5eldsVTdF?=
 =?utf-8?B?UWdrRmhNYjZrdTNqemlmM2JoNm0veDRVVnlOVU1kNE1vUHIwN3RFSUtXdFAv?=
 =?utf-8?B?U0Z0bzcwZDFLU3czWXE1Z1QrQmVTaHJTVnVISGxEelowbWs1UkQ0Zjc3NG1T?=
 =?utf-8?B?Ykd1NGdNdk9wZ24xWnVrZ0pzM2xrK1lxOGxXalhzM0JMUVgzR3ZkSFVmMllK?=
 =?utf-8?B?TUJrYzRBOWZiV3JpRGNSSHJwUjN6Mzdjdi96SHBrQ0VwemI1cS9NanBaMFFZ?=
 =?utf-8?B?NSs1Ymo4U29rRHhRVGpCYTVEODZ2YTBTMTBmZC9CWjJGRnUrcy9zemdrZnlq?=
 =?utf-8?B?UlRSOTRxWldNci9FVWl4YUswNy8zWVdrb09Pd0YwaFcxaTN5NGdMYmpZSEVv?=
 =?utf-8?B?L3Jac1BqYWRwLzFOWHRUNFJ4b2ZGNjNtOW1RaVhHQ21oQXFOVk9yMDM0d25s?=
 =?utf-8?B?UHg4V2w3cHA4Nk5wV054RmpaNGx3L1JLNmdRQkNaeENHVXEvTGtyRnkranpZ?=
 =?utf-8?B?WXpTUGtrNGV5WnF4VldkN3dUNnJkTzhROExqMVJPNWF2TU9lL3lETWZ0WXNp?=
 =?utf-8?B?WXFhVWxuVlE5Y1ZnN09mY3pJZHlwZ1dYRFdtMEhpOFdJSWZvVG0raUxrWDNr?=
 =?utf-8?B?ZXBIV25iaDAxSnorUFArdjNkbDJFLzJhNEhkbFNLZGxuS3BHREFab2VFNk5h?=
 =?utf-8?B?c090ajJ4UzBiVkJGNXROdnlSY2VYSHRjYUJ6bkMxYzk2YzlmS21NRSthNEtl?=
 =?utf-8?B?REVJY0I0dXpVS3REMUxZajArV3RLVnptV0szNmtmdTNWWWdCUC9NSHJ4K2xi?=
 =?utf-8?B?eGRndXQwRSs0ZnFxWFVJSWZzRE1GNHNKVnpTdWZpQWI3RGY0ajFqR3JyZTdt?=
 =?utf-8?B?UDFWYWpQdllhOVRKbFd3NHo1UVRNZTJyM2JQRVpHb1ozdkxuaDQ4UUVhMEFo?=
 =?utf-8?B?OFVuNEp4cjd6c2hzS20wOVFBQUZ4ckFmZDJqelpVbTFEZEgzb0lBS1NHTFlh?=
 =?utf-8?B?bk5zSG9SMEZmUnBrQ3M3QTBWU1NTajZTWnUyS2d0eTZvb1FnYStBZ1UrU1cx?=
 =?utf-8?B?bDJacmJsNGlnemptdVR0eTFIUTZ5UUhQSWlSMGN6V2syKzhRQktNbldSazcx?=
 =?utf-8?B?ei9HNmpTd0sybUlnVjloTnVZMVc4L2dlSHJQeW5JVUhldmRScDZRRUtSTmwr?=
 =?utf-8?B?ejhKNFJPYS83TWsydWpHTjJVeEVIWWxRRmRLY3k4VmtFRERTRjZ2M1lIUUF3?=
 =?utf-8?B?cnIzOWJzNFRPcU1pU2picVBzQ1JVbFc4VXRSSnNaK2N1RnFlRkxnc1JtcDZt?=
 =?utf-8?B?anEzbU1XeDZPN0RiU1FwbHFtQXRmamlndUJZdXVLbll6T3NqTEpTUXRYbkVT?=
 =?utf-8?B?YkY3SmhXeE5TYnBBaTV6NloxMW9zeUhkTDdYQ0R2d0NnQ2dYZlV0UjdNcG9t?=
 =?utf-8?B?N3RkaCs4bnFTUDh0UDRkQnhRN1ZLUlFKUXZqYUtOeGxyT0s1cUtKZHZscWs4?=
 =?utf-8?B?MUVkNHFYUStZZTJ3ZkRkTE84L1lvODRGRFNwMlNVMEVIUS9pNC9RYjJKSU5E?=
 =?utf-8?B?TlNQU3lPNzA2TEhHSy9SVkhYQVVsWmV1UGg0RElvY1VLMDJ2V3kxSXFWaHBx?=
 =?utf-8?B?VkpkbUR1bUVKM3ZIaWdKTWxVY2QwSWZBeWdJZ1VBbmtwUmQ3Q2E5bEMyNTZ4?=
 =?utf-8?B?QmZIOFBZUm1mc0xDTXhNb3RJSVhxcElXRERBeFAyU21jSzJzN0x5WkVFL2dM?=
 =?utf-8?B?S1d4STVxTFhidndqdmdYbW8wTk5yL1VWanl5OE1KMytxcXVXUzY3ZGdpVWJ0?=
 =?utf-8?B?NElFSURoUlltcjREcllGNy9ENEVkRFlOTUVYZS9ncEhwcUVjYlFwNHZSeWs5?=
 =?utf-8?B?ZlR1bDFCTk5XcWZ3RjJwYzl2K3JONklRbHZnRzFGZjlkZUdaSnp4MEJwYVFL?=
 =?utf-8?Q?iAT5hI?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:10:36.5197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7de0e64-c9ab-46ed-5efd-08ddf07c3240
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8029
X-Proofpoint-GUID: SBeCU6CYzDs-S85f1-WriXoJaeePO-MW
X-Authority-Analysis: v=2.4 cv=GuFC+l1C c=1 sm=1 tr=0 ts=68c194f1 cx=c_pps a=75iWbPoZHhoD3Jfch1nqtQ==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8 a=XmVa0EI4HaVEt0dNDoUA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDA2NiBTYWx0ZWRfX/6D+Z/pCzNQL 9xCh4wORnGDZV/ISfTs6++h7n68eGbhiDkPiJyzJ7QHJj7Cr0gWvAchoLNUKb8ECszmVdNr43xb mCsIiyrhfOmVKpqCK/PYCN2tt+rpadhQOCuThPu5pHxZFx8j5u3yu7ZsLbA+vbLiZj4SftmklR4
 ztR6f7AYY+veEd72snTB+lSdPCrGfafmTDKTEkIP1TGLDA7ko3bhX8Id+44JHjimKQqNFf//XZL slTRQYRgw0f8jLcAAugEMdLaqF8m2QxaSumKWR9LcIQ5JIuQfGnGVAPqQ4zrz96zwhrMg1w30Wf HbekUdDZ6JLRYOffJLBoAc+HUTDgzA59dL5JoywR26EjcwXayKCT1ZcvDrPW5ljl+54ikMoniIL mB7cBGua
X-Proofpoint-ORIG-GUID: SBeCU6CYzDs-S85f1-WriXoJaeePO-MW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100066



On 9/9/25 18:47, Russell King (Oracle) wrote:
> Hi,
> 
> This series cleans up the hardware timestamping / PTP initialisation
> and cleanup code in the stmmac driver. Several key points in no
> particular order:
> 
> 1. Golden rule: unregister first, then release resources.
>     stmmac_release_ptp didn't do this.
> 
> 2. Avoid leaking resources - __stmmac_open() failure leaves the
>     timestamping support initialised, but stops its clock. Also
>     violates (1).
> 
> 3. Avoid double-release of resources - stmmac_open() followed by
>     stmmac_xdp_open() failing results in the PTP clock prepare and
>     enable counts being released, and if the interface is then
>     brought down, they are incorrectly released again. As XDP
>     doesn't gain any additional prepare/enables on the PTP clock,
>     remove this incorrect cleanup.
> 
> 4. Changing the MTU of the interface is disruptive to PTP, and
>     remains so as long as. This is not fixed by this series (too
>     invasive at the moment.)
> 
> 5. Avoid exporting functions that aren't used...
> 
> 6. Avoid unnecessary runtime PM state manipulations (no point
>     manipulating this when MTU changes).
> 
> 7. Make the PTP/timestamping initialisation more readable - no
>     point calling functions in the same file from one callsite
>     that return error codes from one location in the called function,
>     to only have the sole callee print messages depending on that
>     return code. Also simplifying the mess in stmmac_hw_setup().
>     Also placing support checks in a better location. Also getting
>     rid of the "ptp_register" boolean through this restructuring.
> 
> Not tested beyond compile testing. (I don't have my Jetson Xavier NX
> platform.) So anyone testing this and providing feedback would be
> most welcome.
> 
> On that point... I hardly (never?) seem to get testing feedback from
> anyone when touching stmmac. I suspect that's because of the structure
> of the driver, where MAINTAINERS only lists people for their appropriate
> dwmac-* files. Thus they don't get Cc'd for core stmmac changes. Not
> sure what the solution is, but manually picking out all the entries
> in MAINTAINERS every time doesn't scale.
> 
> Therefore, I suggest merging this into net-next so people get to test
> it by way of it being in a tree they might be using.
> 
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   1 -
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 113 ++++++++++++----------
>   drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  10 +-
>   3 files changed, 67 insertions(+), 57 deletions(-)
> 

Tried on the stm32mp135f-dk board and was able to run ptp4l with
coherent timestamps, so:

Tested-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

