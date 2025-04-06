Return-Path: <bpf+bounces-55373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0D9A7CFD1
	for <lists+bpf@lfdr.de>; Sun,  6 Apr 2025 20:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68433AC89A
	for <lists+bpf@lfdr.de>; Sun,  6 Apr 2025 18:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB641A2C0B;
	Sun,  6 Apr 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y1NSdTxI"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D272E628;
	Sun,  6 Apr 2025 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965817; cv=fail; b=aJKLcmvO/8JnwXVrauWsU6hcm+fBohq5xfZfwVceQqUOmyX9D1ka8U73bDPnJePFKMq1fp5HqHswqd9zD0cpUODEidn4A6UGCNIDGvaQf7b7o/55/cY6jjDFxYzU3UfNiqu5gnWqnoCvNHq4JSnguVh+7vX5yWburQFZ8xclwCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965817; c=relaxed/simple;
	bh=6yLaEyotzciZLzI/dUITdhBhulbJM6Kvwp8o0gjWEdM=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=uW80e1pfo08Jt+m6WEvtQyLOK1dJ4fI74AVfKqUQBlGYDeQZBvz3o0FmqC+n8KGtVQXFCEOjrrMNV/WOf7BX7sVTCH4GgLHvyeC+qunbGMGZTm2dixh0n2i8V8p3B28cxojkWxH+2KxQPIf5H30m4xWwZ7GgAZtx+ce+FAPXcGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y1NSdTxI; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPNCrvgo6f+uyKyFOMYwSxVmh6wIZilwd6VMOVPcMMlbFDg4QYesy1KWYdEZbmup0qr7tQi+gOzk1IWexuVcwUPmBwTZYULgAlTWepGUyy6k3awBd+0x47iBvoE03Ploc3THdo0bEII2AZsFCWphhoQUYFeZwQrR25PbQuhbnvPkrmgtz/k8kW5kttiXwn3QSAw3pycNbDn0aVwgQscd7STsu2IV5OSdc3wNKM0Rlr9WqWzTfAEPLJO2QlB/Vcgaez8RSK+OOCMslI8cGGhz5xF3T9TQ39L9dV9528tmYkbAEErtuZWrMnfbBR/AT/lLxVyMm3dKFX/IZ6xcMVj7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43AAQ/MdI1rD+dEoG2MqnKhWl9880jlzHtEPENekXhA=;
 b=N/F2UtfIxSL0cXfLajFCSDbiLnJneAJ2cL7Rus3fUypypThGIb2UaStU5Y3KdX4zN4uAWT/ikxozHVLUCDs/dDc0lRt4QBHD9wzZQkLGhjB1qjvlDF1o83SIV0o+GAiYJSEOCbpj3ToGgnxxR0BkymWPYqpC9WOcU36WLiIq4GVgDf6OlQTvTlAyTzoT6ivWPIxJrKFEakbR0/rx1FxKGT40AUqe7GNikOT1u/4YtBXGPMKAL/BQJIGf/HMmOxGL1DWtwLFFEEHVpN6IaDLKW1I/LBqs3kpKQ+7gE2i5PT3nkyFGlW7uh9TTbRShL4HFtvTfQPUzC3csfQHuwiBGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43AAQ/MdI1rD+dEoG2MqnKhWl9880jlzHtEPENekXhA=;
 b=Y1NSdTxIpUwJwBgSLKRL+ZTKc8B8e8jBC7eBumoEjLfQG0W66qMLku2dvTGG/V4Zre7pvryyHouw+cN42NOyKF9EAUoDdRoUMVMumGC3ELf6SoHJHzVl0jaD7x3D5/Rg/3TuhfKjJYmoeeMfKSEU0/nex41SM8T14y8PlWXbifsoI8/hWkOk9nkU1BJrMEr1553eoaryJm3S3Hncmnrr2v8IecrTPCSaCEAyFxrG/jDKJrhDwJu1ErY1LDNVKLRDrmzheHYxPBsQqVR9U7TtPQHlWh8BKiHFzwee4bOX6VRtsiOfndJkJ851SOUZqraccbY9mwhh43EVvZ6Yxr7FPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Sun, 6 Apr
 2025 18:56:53 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8583.041; Sun, 6 Apr 2025
 18:56:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Apr 2025 14:56:51 -0400
Message-Id: <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com>
Subject: Re: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into
 helper functions
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, "Saeed Mahameed"
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, "Tariq Toukan"
 <tariqt@nvidia.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Eric Dumazet"
 <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Simon Horman"
 <horms@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Mina
 Almasry" <almasrymina@google.com>, "Yonglong Liu" <liuyonglong@huawei.com>,
 "Yunsheng Lin" <linyunsheng@huawei.com>, "Pavel Begunkov"
 <asml.silence@gmail.com>, "Matthew Wilcox" <willy@infradead.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.20.1-60-g87a3b42daac6-dirty
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
In-Reply-To: <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
X-ClientProxiedBy: BL1PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:208:2be::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ef95e4-3ad2-4464-fa19-08dd753ccbad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekppNHJCRjRjRXhjdkM0eTk2UnIzSFM2MWxKYUl3d3RJdEt4K0NrLzBxYXhP?=
 =?utf-8?B?eHVSeitsc05Ycy9GMU1pRWdMbnhERlVNVE1iOGt1K3FzeGIyaXRKY0pDV21M?=
 =?utf-8?B?cjgyMVJTeTFiamVPRGJ3UVRhN0I0UkhDSHdMTEVFSnZJaTlQQklJRlEwTEs5?=
 =?utf-8?B?cTUyWTh2TjRlc0pjK0RIMmNyU0JhVWJub1ZPa0tJODBsTnhYem9CL3h6akJz?=
 =?utf-8?B?ZVo0SzdHaWUxNjB1aHd5RU0rb0puQkc5dGhwNEJXemdvc0d6cHZyL2MrcjI5?=
 =?utf-8?B?aVhiKzJpQmtZMWlXVVdYWlVvY2p6elRKNk11SER6UVdBdkJFaTBHbWlyUXlB?=
 =?utf-8?B?a2ozOElsbFhDWVpwSTdFaHIwYzU4aU5XQndGRkg0dU5vKzljUjd3LzBDSEFj?=
 =?utf-8?B?Q0ZPc3hodHFnYnBrZXl3WGVGSmFBakZFbUZndVNsakFGci9lQ0NJUDdRZyt1?=
 =?utf-8?B?THJmeEhjMmZhQVdrTE96b2IyNyttQkp1VG8zK1FuVlNoZys1aGRsZXNtcnlF?=
 =?utf-8?B?clVMVzNZTEphTVJLM3FUZ1JnT2lYS1Y0SGN6RTdqcHpCa3ZWYk1uSTNENHQv?=
 =?utf-8?B?cXk0MmM0M2RLdnBKR3JSMzNJRW5pV3pSWktFTVFvZ2IrVWtxa0QzWlBNVmlt?=
 =?utf-8?B?NmkyNFJob0k0ZS8xWVFQdFgyc0V6czRpNXMrb2NkL3c3VU1VdXZZYXFna1py?=
 =?utf-8?B?WGR1Umx3VnUzbSt1dVp4WmwwM24rTFV0aDI2Y3lhZ0FSOU5IRG5LeE5zYy9T?=
 =?utf-8?B?Nno0Z3dieTh1R1c4TXRTbUtkMVRSQ1Z1bnE3S2d2eURiME9zMEpENC9nTGZq?=
 =?utf-8?B?Zkp5bE1IZ3JhVG9ZZ2N4STRNWTJxalBQczBsVmJObE8rQnZHdUI0TFJyd1kx?=
 =?utf-8?B?UHM5OGlvVlByWEtHVlBVZHAyT0pITFd6L0xpUDNqQXJSeFdSNGRsSVdrQVBN?=
 =?utf-8?B?MXlrRGE0bVRPRXFicDQxcEJPdSs4TTk1aUhieXFjc2hlV1hMSGwwZnlZWW9M?=
 =?utf-8?B?UXc5RHUxcDRuS1BWSHJLaHF5Y1R3WTFHb0tPejBocVZZZjhac2o4aEt5SEEy?=
 =?utf-8?B?czN6UzNuVkVkYWZoVkc4Z2M2UUg3dFh1KzY1WFRxcGwvcGI1WnR5SE9UcElS?=
 =?utf-8?B?Vlp2eFIwcWJ0dW1ZSEdoaW9rZTFESlIzaHVhWXo4NE1aL0tsL0VWZXZXQkd1?=
 =?utf-8?B?Z0RBekh3a1hrM1kwR3M3N3k2cjExWTM3SVdMMFE3aEgwZW96ZUhWRVB4ZnUr?=
 =?utf-8?B?ek1MUEJ6SnRPMEhPdTA3eUo1LzlhOUdrZVFUc1pxQkRNWGFFbmFKczQzYUs0?=
 =?utf-8?B?NHhoSVhwWlFqVFVxbHlWS0VDM21BVDkwNU9zVG1LLzVQR0tzWkprK0tmSDMw?=
 =?utf-8?B?eUVlMlU2NWhUWlpValI3TFdQMDlGK2xkaFVLQ1NDZzlpdDlVMjJtc3Qrbjha?=
 =?utf-8?B?QkVSSGszMWpzWndFRWtqcVh1RnVTYjNUb2Y4bVU2TVNsY2wvbUMzWHg4VmJH?=
 =?utf-8?B?M3NSMzEwYXI4Vjl4bE4raCtmTjlORlhPWXR1eVhYTUNtdXJPZHg2RUVxY01Q?=
 =?utf-8?B?TUlKTWlnZ1N5Y0JHVTNmRjc4NkdaU3ZOZTBzS1lIVWxOYzFBMXZabXpaREZ1?=
 =?utf-8?B?SmhWMDdSUU4wNlBBbUpZVFBVRkxiU1NIM3hvRUhUL1QwcUcrZWVNM0trM1da?=
 =?utf-8?B?MjNrb0dVdW1KakNUZUpwNGxQaS9xUWczSmsyZGxEYkhHMkFnUTJIaks2RWtu?=
 =?utf-8?B?ZTgxdHdIYU1NcVhzWFFNOUtFbVZPeFp4WU40TEVaSFNwWDdKc3pCN3NTMDZJ?=
 =?utf-8?B?dzJHZGFZcGNRUmZDL2RkUWtOL3ZSVEFtU0liRE52UFEwSUZmS3Rvb0p4TjR3?=
 =?utf-8?B?MzN2SzFuTXZ2eGtRMlo4VVZKOHRIQk9lOHR4dFBGV21jTVNPb0RtckR0WWVt?=
 =?utf-8?B?QkZQRkFyTUZPZE9rZ3hsVEgyMlVXWFgveE8wSUpSTjduT2hBZzRlNFRlYkF4?=
 =?utf-8?B?SGMxL3hac0l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHpDc3lHMnVtYVN5cUEvcXdJR3ZxTnZWVy9mTitidW9ZLzBKN2tCTk9DU2Ex?=
 =?utf-8?B?Qk9mQWdzV2tkbXJ0NUkxTzluSjRUdU1zc1FESFdSZWJNWG5HRXBGOFhKZysr?=
 =?utf-8?B?MVBiZUIwVVQxN1IyamhrVEdKZy94TUx2SXFJWEJQaGNEeGlNSmswam1IU0Mz?=
 =?utf-8?B?YkxvdTRWbnBGK0dzOUVPUXIxemJ5Y3FmVEp2ejh1akZCdEFwaEhuTHpJRVRX?=
 =?utf-8?B?aGovVWFwV2RQcmQ0U203T0NjcHRvRFFhY1NyRVNsb05ZZ0kvV2JtRjBFRDZT?=
 =?utf-8?B?d0ZIQlpPOC8vWjB2VkJxMzl2cnBXTU1KQVV3STdWV01DUXRxSE90UXlQaU80?=
 =?utf-8?B?akJmWTFrNEQ1MXlYbFdFUlhvYy9hKzhGTlB5dkdvRzVIeHNqKzgrYmg1eExn?=
 =?utf-8?B?NmR1d0IvaTFLdDVtWlV6MTg2RG82MjVKb09TNTZ0RjBSL3ZEN3JKM3Evekdw?=
 =?utf-8?B?eWJuU004OFFwNVlvZWh4ckdZWFBxdjhWN2h4OUJoSDZSL1pPeVdDTmtmNVRo?=
 =?utf-8?B?Q1hVZjZaSG4ydkFUOFk5ZWx6YzQ2ZU43TFN5NzZRb2JHRktBQTFHWVdFWUMz?=
 =?utf-8?B?UjVaQ3BKYkFNenpYSFlBVWc5LzBkcmFXSkNyaER4WkZtZ20wUTVpTU9FRzNU?=
 =?utf-8?B?OFNjWllxUG9qcmNKejNhNkp4c2RJQ09zYVZpUmExbU9ycG1OMU9kbjRML0lq?=
 =?utf-8?B?OXlVekJLai9nbzBSRzhHK1ljN2dzSE50azJjMnFHK0hYeTV3amNETFVMUjNw?=
 =?utf-8?B?ODUrRUxKK05XUjlrZm4rY0wzelo5WFlZUjRrNmR3YytQeHZxQWVBOVNaMklX?=
 =?utf-8?B?Vk9lOWFMUkx6OUxaZ2tTOFJONUlRVXd6Y0cwQ094WTZUaDRQYmh5SXRocU5C?=
 =?utf-8?B?QjBwUG9JenB2a3VFLzBPUmhEZTdqZGNrNnhjd1hXSTh3WGszZEVjeXY5bFhV?=
 =?utf-8?B?WHN1ejRoZEsybU9KbVVyMHJibzhxUy9Xc2JaRmNKcXNKdllBT2dCaW5MNXJE?=
 =?utf-8?B?VmZJbDducjhvVW5QRUwzbVNqRjJLQzMwYis3SldLS3dYajZIZFpiWkpRa3J3?=
 =?utf-8?B?Ym8ySmNpS0ZPbEk4NVN5ejdiemtENHQrZ0F6V0FEbjdxUVNTd01Ea0Zmd1Zh?=
 =?utf-8?B?TksvbDZYcVdzY1B5Mm1TdnBTcHcycGhWOVlrQTUwVFQ2U1BPMHQ3RTJIVnNn?=
 =?utf-8?B?VFhTZWoyLzZZVWFEblkvUTRBZXVuRkc5SGF4K0E0bWJkTmhVU1ZyRUszZ0pK?=
 =?utf-8?B?WXR3YzA0cmFXSlNwRUdFVlA2QUROS1BRb0pRN1l6azdQS2tESGFYN2JodmlI?=
 =?utf-8?B?UGt0WVRiR0orWjJQdUttRzNKZ3lHQ0UyZDNZSEExWjlEM3ZlU3J4a3oxQity?=
 =?utf-8?B?Y0xzK1NtZzcrM1JkeEhnc1gvR0NzRWFDZUhWdk1lNXdJNXkyNHhNeFp5ekJ5?=
 =?utf-8?B?Wkt3UEZLSEFidEpsMTAwcURMY1FRVDU1NHZXOFovUGJqM0dTa3BDUmQvNzY4?=
 =?utf-8?B?cmdBcStMR0NsM1UvV2kzWHVFWnBxQmI0Zy90ekZNWm85ajR3ZmdJY3NhNWdV?=
 =?utf-8?B?NXhPbWJuL0NzZ0w3TTNGYjhIcVRCTGlYalF1ekhWTStqemcxYzhpSlZ6VG9B?=
 =?utf-8?B?Sk5UTldickE5SVFVZnBDQ09odXl0YWcvRy9xNUZCbWhLa2xwQjZpZENEdE51?=
 =?utf-8?B?Vm93dStkZE9rWDJKTUl4cy9ZZ2E0NHVXZUVScEowc29aOEk3aFRXTmZoa3hm?=
 =?utf-8?B?dTVyRGt1dlhwOVlCV2pDbUhvMWE4SXh6QXpXd3hhV0RYb2Fqc0dwaGIySkNO?=
 =?utf-8?B?MnY0L3FrRGZOSDQ5dE10N1hNZksyYzdSUk5wNHJ0eHM1UHdsZ1ptM3Fta3F2?=
 =?utf-8?B?SUxQU0J6bEVTNnBsNEtvK0FwazJ3bmxWcUIrbEdaRWpIWnFTcEQ4M3BpVVBh?=
 =?utf-8?B?TkZQREtsemcwZGcwd05EZzVBL2RsVms5SE9yNmJjbXEvMDdaaUxYQWlMTEM2?=
 =?utf-8?B?YUMxbE9CejJmcXJlMmlMdFZ4TUVDQldIOExvR2dScmtYU1ZNZVhKQkxyMzNk?=
 =?utf-8?B?Q29HU0p1YVRDczNtRm1rQjNZVDlVU0o5TC9adHdCT1RaMXUwbGRRVVN5bnM1?=
 =?utf-8?Q?KjQVxhxDZ/avsNZsMWsuOwhAZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ef95e4-3ad2-4464-fa19-08dd753ccbad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2025 18:56:53.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FO9SYXHg4gKVg73W6GpqvUxFcviaHbXsPaaHkCB/QrJsnrX0F7jQZYtjH36ju8Aw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159

On Fri Apr 4, 2025 at 6:18 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Since we are about to stash some more information into the pp_magic
> field, let's move the magic signature checks into a pair of helper
> functions so it can be changed in one place.
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>  include/net/page_pool/types.h                    | 18 ++++++++++++++++++
>  mm/page_alloc.c                                  |  9 +++------
>  net/core/netmem_priv.h                           |  5 +++++
>  net/core/skbuff.c                                | 16 ++--------------
>  net/core/xdp.c                                   |  4 ++--
>  6 files changed, 32 insertions(+), 24 deletions(-)
>

<snip>

> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224feb261=
73135ff37951ef8 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -54,6 +54,14 @@ struct pp_alloc_cache {
>  	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>  };
> =20
> +/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magi=
c is
> + * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit=
 0 for
> + * the head page of compound page and bit 1 for pfmemalloc page.
> + * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid re=
cycling
> + * the pfmemalloc page.
> + */
> +#define PP_MAGIC_MASK ~0x3UL
> +
>  /**
>   * struct page_pool_params - page pool parameters
>   * @fast:	params accessed frequently on hotpath
> @@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(vo=
id *),
>  			   const struct xdp_mem_info *mem);
>  void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
> +
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +	return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> +}
>  #else
>  static inline void page_pool_destroy(struct page_pool *pool)
>  {
> @@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct page=
_pool *pool,
>  static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 count=
)
>  {
>  }
> +
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +	return false;
> +}
>  #endif
> =20
>  void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref net=
mem,
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9ced85e0d1=
98947be7c503526 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -55,6 +55,7 @@
>  #include <linux/delayacct.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/pgalloc_tag.h>
> +#include <net/page_pool/types.h>
>  #include <asm/div64.h>
>  #include "internal.h"
>  #include "shuffle.h"
> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struct page *p=
age,
>  #ifdef CONFIG_MEMCG
>  			page->memcg_data |
>  #endif
> -#ifdef CONFIG_PAGE_POOL
> -			((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
> -#endif
> +			page_pool_page_is_pp(page) |
>  			(page->flags & check_flags)))
>  		return false;
> =20
> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct page *page=
, unsigned long flags)
>  	if (unlikely(page->memcg_data))
>  		bad_reason =3D "page still charged to cgroup";
>  #endif
> -#ifdef CONFIG_PAGE_POOL
> -	if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
> +	if (unlikely(page_pool_page_is_pp(page)))
>  		bad_reason =3D "page_pool leak";
> -#endif
>  	return bad_reason;
>  }
> =20

I wonder if it is OK to make page allocation depend on page_pool from net/p=
age_pool.
Would linux/mm.h be a better place for page_pool_page_is_pp()?

--=20
Best Regards,
Yan, Zi


