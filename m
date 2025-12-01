Return-Path: <bpf+bounces-75799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81732C96948
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 11:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F483A196E
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA265302162;
	Mon,  1 Dec 2025 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GuKyJF73"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9077D30214A;
	Mon,  1 Dec 2025 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583987; cv=fail; b=RmEdyAYgEgq8e8B0hA+PhXScddPCUXJDom3SK3PVvsfk+wB2JzB/8eXxqO2gL8SxaSO4AA7+W5weFbfOKBDimnSils/P1PnZ/7FHpwclKfPBBkQ7qfYV/8RXx8mGsKvC79CMcvuyXFrmdCGJkF+PBns+UCfHR4xVlrs2/UONzOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583987; c=relaxed/simple;
	bh=SPruAaxLrX/VKGnlsTsRhaoy+YHIld+VqMBnemo6rlo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OCcUD34/rU0/5J/7tFC+vcQRQnWyVJ8XgRcyA3VOJ1RXtkmQDfKISrSBzD0LvzMlliyAEoMuswfm3/6pgW0SBD+Q66UzaMv2KXw8UmFfWJxVWoFVBCN37Q2dy22nuss99Mxes9JX9ycqzRxlTFtLLVA/mG8thEdm88RFS2PHF5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GuKyJF73; arc=fail smtp.client-ip=40.93.196.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luZjOMmdp+6b3IPVkz6Js67R4xNBE83o24XRqfd8fU0HrDGFwaEMVzi1s0iAZEQWgFdkDxpc/4HNMeI05Ro1wCMM4SGGVVhQcS2uleLbKP9/itrId/IeMkWCs4+hDJB05XKAi7tKuw3GG82L/cM/Yv3jYXKKveAWyWuX3kwflnfrYOuW3UujM956guuJZHHDdsAbc9uFBreSjv9oNqwOdqmTkCyOfqS67yj447PhP2r3/I83h+6utGPE/+Pgbb76cnzamB4zME3YOSn29hf+1en7fK54Kxqzx+gXfpZnC7Lj0iy1HPWdh8QOQgxatWpkTH6l/PTyvsHrGGLrX6LqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U297BzbgpFW/OWDg6PxXZ6/bhqydrkPd21IjfzSbozA=;
 b=WPw1Q/Rloew64vq9D3WxefWN5ZAH9lsyVAxw20spYZ+on9smp0vEK57sId4wMR45URYw47KJeFmgpcVcPjoLEwndvbPvHkbN55E1vOxneGoim+7y9PHwDm6NeqaPX+9m7Hwnf4E0eFN7xK8Y8Vp9piCeYNMOz+nYTPtmrPq0D9/u8letmQJf41IP2JkH4h+gD3jLAW1bEv6VIvj1BNT9BjuHGY56pWwMofJc3X/WqCqQMeKEqHeTu7QSm+1xv+jo+ChQrzxXwbnRKxHrdjXaMAIMNglezIyixWJTU2isFSPNX2Xj1XqF1anWHawYYT3OmXQ0Y1Wf4dWIJRWDM4Smqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U297BzbgpFW/OWDg6PxXZ6/bhqydrkPd21IjfzSbozA=;
 b=GuKyJF73FtEKUMRKARJ2b6F5Jln6VI1QvB6hRhZ9JD1nO0RTgyEVhMsViPy912ot5Lvicxz1XoTxNc9KOKZGF0ylTQsTBcq+lwtXVGlKM6RMuE3KwfVuepqhJx7iUS/IIoUFZi4CGKuNiNEcUfSiZDWzEMSo6yPk7TK2GNmKiawTMZO7wB+bPQoHlGMBJDAR//7V4okeRF0zRmi6hHmWNcvue7axcFuG02vIygcp0KfuHOzhhJay1AbdplZ01Kva62mAW/FibVJq31ztEX06PcbcY+AgUaQRrPJvfY1wYglKtk+ylmAYgpGMXq555ZNHkOMg7YSCrjwQZ8yNS0tUSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:13:02 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::7e7c:df25:af76:ab87]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::7e7c:df25:af76:ab87%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 10:13:02 +0000
Message-ID: <ad6c4448-8fb3-4a5c-91b0-8739f95cf65b@nvidia.com>
Date: Mon, 1 Dec 2025 11:12:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] xdp: Delegate fast path return decision to page_pool
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>,
 Toshiaki Makita <toshiaki.makita1@gmail.com>,
 David Ahern <dsahern@kernel.org>, Toke Hoiland Jorgensen <toke@redhat.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>, KP Singh <kpsingh@kernel.org>
References: <20251107102853.1082118-2-dtatulea@nvidia.com>
 <20251107102853.1082118-5-dtatulea@nvidia.com>
 <d0fc4c6a-c4d7-4d62-9e6f-6c05c96a51de@kernel.org>
 <4eusyirzvomxwkzib5tqfyrcgjcxoplrsf7jctytvyvrfvi5fr@f3lvd5h2kb2p>
 <58b50903-7969-46bd-bd73-60629c00f057@kernel.org>
 <wrhhvaolxu275zw3fxgvykg7tndzp4pl4u3mnw3z4t5yfbkpix@i2abs45et7tr>
Content-Language: en-US
In-Reply-To: <wrhhvaolxu275zw3fxgvykg7tndzp4pl4u3mnw3z4t5yfbkpix@i2abs45et7tr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 140cdc32-b0ca-46b4-cbd0-08de30c23615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck5vV0NxUUZnUmYxWERhSnFtQ1F0anl0QWJNem5IVU5WMm9wdERxQXVvbFhv?=
 =?utf-8?B?SnlBZHJGczJ0b2lpSCtmaGtrbTBmUEJqd0hSOGo3TjNyNkc2UFlEaFVodWVL?=
 =?utf-8?B?VGN0RkI0ZG44RFpEM0l0ZkZ6VHcyc3l5dytMZGhsU21aWWxZNnpaT1N4Mll3?=
 =?utf-8?B?OEY1UER0azhSQ1dFTk93dGw3QVZKTWlRQ0lXY0dQZ3ZRLzBNMG9hY09JR0hj?=
 =?utf-8?B?YWFYSjhMRHBXa3ZpNTFTbXQ5ZkMwSXhpMzhacVZlcXE2R3IvQzl2TkVVcm11?=
 =?utf-8?B?RTF2dmtoVmxQNEdRamVCckZFZFJsWUIra0hMWm12WWxNSnBWbkx4NCtqUVpC?=
 =?utf-8?B?TWdSdU5lQkF5cll2cTlCVEU5UEh6QjlhV3l1VU5rNUNLeXpYaXh4VWtmV0Vu?=
 =?utf-8?B?YnhjWmFZbjIvZyttWVZLMkE3bnVXcWRmWExFOW85SWtacXRKNmRtZndwWVBi?=
 =?utf-8?B?N2dIY0h1bDk4aDhydnlydXNHWTZCVkd4RldtR2NCcHREWXhlaStXcjcyRzdO?=
 =?utf-8?B?UDk3RFJRc1R4NXVaWm9vUzRQR2JwdDMrODJ3aE5FZTRuUkpBWk5KcXZkZ2w2?=
 =?utf-8?B?Z3lFN1J2NmlBbXFrejdERTRZRUIrTjd4T2xSWHdPcWNYWk5BTjMwbWk3YnpX?=
 =?utf-8?B?dWpnT3JMdHBic21ZdDgzTVNxUHQvSXRHOTJ6bGpIU0l3dmlOYVh0dnFIbEJY?=
 =?utf-8?B?ZDlpbXlTNDJhWVBHWDNaL1RKSDQ3dE52LzR0QjcxSGFDZnBScy9waEJTYUk3?=
 =?utf-8?B?V0U3NjY3ZjBEZVVNMDRXd0JDV3l6cG9SWmYvWG5TOUVabSs0NWVhNi9TMHkw?=
 =?utf-8?B?Y0VadlY2L2Z5bHdSakcybEpXOWJtanQ3bXhxbkx0dUNCdkFVTXlybDhDYit4?=
 =?utf-8?B?WUZhejYxQXNCMDdmOEM4VlhTQXdzcFBtWDJSTHhNMFhCVHhhMDg1RTZQNS9M?=
 =?utf-8?B?eDlxZmozTVBYMjErNXhubkZIU1BKMzdRdExnanBQRW8yZWlVNnExYlBHaGVs?=
 =?utf-8?B?SXZUWW9jYkM3aFc0ak1KaCtvTEhJRVVFWFNrS3dDdVZwKzNPcWZOcElZVG5L?=
 =?utf-8?B?ZFo3OGJMVldhUmZxV1gwSEVCYkNWbWlaeWdiVGxZWU1rREwyZ0FRWTZ1Kzdh?=
 =?utf-8?B?NWxMa1RwWmlEai9qNmkyVFNNa3paV1FPTGNnQkZDVFcrdnUxaVV4aHRMNXpu?=
 =?utf-8?B?MkR3VlRmRzY1QlIyR2ZYMmFKU1hzcCsreVNOUzRtZnhBaTkwL3pFSlBZbWFB?=
 =?utf-8?B?TmxYaUgrSHRINksxR1pDa25qbVZGS2J5djVkWkRSU0xRdXJrMzdjb0YwUWtt?=
 =?utf-8?B?NXJiNUZVcE9zLzdibDdLcWxKS3dadXJtRlAyV2NpZzJNRDZ6Tm5wUVpxdVdt?=
 =?utf-8?B?ZmlUTnlkOW1ucjBTbzFFaStVcWVhdy9ONmRPZ2h0N05NejFNYjI1dzY3N3E2?=
 =?utf-8?B?VWwxM1VjVkhqekhrS0hoZ0orZjkzNHpQdmRsTFhTekN5MUJKMjNaSXBmRWlz?=
 =?utf-8?B?bE9XTHZtSUIvTm9DNTNoUXZhUDJYTnVTMTZ0dlpLTnlsbDhUYkFiZXFkaUZq?=
 =?utf-8?B?RnEzM0RGRGF2Q0x3ait0WUJ1TmZ2WW1KTUFoeHRteVZDVTJWUkFkUHQ1Ri93?=
 =?utf-8?B?cngzWHFLd3cvZlJrZmJ6T3Q4RUhCT2ZTRzR6NENTNVpxK2RnbzNyWUZwV2hB?=
 =?utf-8?B?bmdDMUZDT0RZOGZhNDc3OGZWUVpkd1ZUVnVUbnYvQklTLzRRZFVlZFpyWkVl?=
 =?utf-8?B?a0k1WkFMN1oyUzY2TkJaeC83Ym9QMzBkSXhneFAybmREZGZyT0ZBTEdZWlla?=
 =?utf-8?B?WGI4MTl5K2hzc1ZybXBHb0FtMlBJTWFFTEhRWUQvVE5Icm80eGR5SFFKK1hk?=
 =?utf-8?B?czQxbFNSQUxidHNTV0F5c0t1cHI1MG9JNzRVeVlFdmpjeEkxM0s5ZFF3dTlU?=
 =?utf-8?B?UU1LQW1QY0JYdjlLUW85QU9FcjlrY3pzNDFFcGVRL1pUeFFtK2dkTXdBREd2?=
 =?utf-8?B?SlVBajFnMTQyNzRPSXY1OTI1UmJVZ3k1WjJOZVRiajJIajExb0VsbEpKSXBP?=
 =?utf-8?Q?Qt0nx0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXl0ams2YzRDOElSakdZZjJtSGg4cUNSU0pBR1pKZTVvODY2VDUvZ0VCZ0V4?=
 =?utf-8?B?d3N2RldtajNWWTAwMDI2bE5KR3BmVGV5ek5XQ3AvNHVHbmIzNUlORkdIT2Uy?=
 =?utf-8?B?MmFWTS9UMHdFZlp5WDkxbkIzRXBpTk9IQklJbks1dHhUTnJaUUlFSnZvdmJ5?=
 =?utf-8?B?am43dThzdEhmSzhEWDFQS1RnU2N3S2JHSFlCdlpIck4xRG1rU0JoN3BMVnln?=
 =?utf-8?B?T3BNUjYyYzlGRVZSeCsyNEFGMGU4VzFMV3V0Z1dFTWY4RXk5S2w2K054cE5U?=
 =?utf-8?B?WGNKakI4V29Rbk5TNy9XcW04V0Vob2FWelN4TU5FeFVCMUpvTW8raTFNMXdN?=
 =?utf-8?B?Y0luZ0VmZTVNbVZrWm9xMTE4anIyWUEwS1RyRmV5amZKTW1sck9MalFQWGNI?=
 =?utf-8?B?dnFSY0VtTjhFMk9seWVXcmkzTktzOEE2c1AydHp6TFJYUEJyK0F5bXFqTTd2?=
 =?utf-8?B?V0tlRnVSdDFRUjlUcm5XNVI2cGhTc2RPa2p3NmJFWUtkYURPOE9FYmROcXNw?=
 =?utf-8?B?VHRpTE9KaHZQTmNvS09kbUx4c3JVcDRJaWhaejJZUjk2bHdaV1ZTbG5vQ1Y1?=
 =?utf-8?B?SE5FeGFoVFduSEQwbjJZWTZmWDBmcERMQ0g5VUloMHpCOERmSW1hNjQ5UzRI?=
 =?utf-8?B?YlF1RnpTM1gyV2U0M3pmbWI0VzJtNjV5Vk1iTEpPaGFPRHlwQ0ovcjVuWkNq?=
 =?utf-8?B?MTVUS0dVV3kxb01jYnl2RGFGZ3ZvUmQ5VGdXZmFoV3F4c0R4aHFWK2xMbzRW?=
 =?utf-8?B?UkFoWDAwYk9JTjFtZEVoQjFBbTF1Y3lMMm5qdlZhcms2cWVKL0cvWXZKZTI0?=
 =?utf-8?B?TlRrSDIxa2hBZk1FRm94VVR3RmNIOU03OFR1ZFZ4b0RnSnBBWXNRT2FNTmRV?=
 =?utf-8?B?SEY1djJBZU8yd2FKTUtMUng0eUVhdFlhWWJGaGZITU1jU3N2MHBwcUd4eEJS?=
 =?utf-8?B?NHJtUVhLRjdKbmI1L2YvZWZJejZjazVMUjAxS25FaDdPZzhMWlZDQzhhd3h5?=
 =?utf-8?B?Y1RjYk8wUHJCTDdZZHJIZGkwdXJLV1Y5YkJIT3JZU3JYbUNXSDFBOWlWUExo?=
 =?utf-8?B?S1Z3Q3BXcjlkaFo0VC9wb2NPTnlzTzhKT0RqSWdVdXdvVFZ5MzhDSDgwOS9x?=
 =?utf-8?B?N2NhUmoxTk5DeFFMZ2JiSDhyc3ZCaEFQcCt1MGNXNFBzZC94bnhzc3Ayczds?=
 =?utf-8?B?ZEMwQVpHUEh1bTN4b0FNUTZ0U0xLckxFUjdGYU52bXpJMlhML2ZKL3hGWSs5?=
 =?utf-8?B?WDNCMlFyLzlKRytUYlY0V0t0U2xTME9sRWFNZHJoeVBWek8vdURYTDAyb2FI?=
 =?utf-8?B?U1NPWmtjUEFTTUpNSW5wMXBjS2c3WjB3OEpjZWlOcTVHampkYS85Y0gxV3dV?=
 =?utf-8?B?anQyeFE4eU9ZU2pybHU5SFk1RHZXUGlJRjk4cUVkTXYyOGNuWGVacmxIMitL?=
 =?utf-8?B?a1pwVnBUdGFkR25URXRCYzZ0aityc0FaUnJtdlQ2RlJFZ0g5TU9RbS81Y043?=
 =?utf-8?B?b2o3bmFVNmNmL3lWY1FIVzJ5MjBXb3BZTnpOa3MvYVdYNUplYVFXU2dZQ3pJ?=
 =?utf-8?B?bVdzQjR4NGpoNGQxUjhQbE4rUzFRbHl3RTQ3QU1XN3NIR1gwSkpJenpIaFU0?=
 =?utf-8?B?UHFRbitaTldHTUZUUWtWMEl4K2J6RDhjQmhUWGZXbzZpK1VicnJsZWxaTGE2?=
 =?utf-8?B?TjFDUUJTOXFaREJkYkdkRUlNL0IxY3Bvb0lCZlhrSnFOQWJXVkxhRzI0ZnR6?=
 =?utf-8?B?RmFDY2JTVisyWWxwYnlQemRiR2dNUStiSVZmZEtRc3VZejg5R1RSR096UlV1?=
 =?utf-8?B?RmRGVFY0aTFZUXJRcnBTMjFvL1pkSFErNi9zUUlYUGpMTEF4dWdpc0pRZHFk?=
 =?utf-8?B?NUZHTkRMdENnRE9TTUMwamY3WlVRbmdwMWhNTFRoUE9DRXZnWmdITkVxNXRP?=
 =?utf-8?B?TXpsTE9PbDBCdjBDNm8yV3dJUEp5NUJ6cFlCRTMrdGFTTVFiQm94VmZnUlla?=
 =?utf-8?B?WVl1OUp5WXdHWjIwWXc4RlNtZ0dabGJWRUlydmUxUDE0U3dHaThyVWFvYUVN?=
 =?utf-8?B?cjNnWmVDb3lGTEtCeUF6TVpadmV2N2dLMENyUklNM3NvaUV1V2s2VlhCb1dt?=
 =?utf-8?Q?c+VGGqrpqi218n/1ruz1UhGJJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140cdc32-b0ca-46b4-cbd0-08de30c23615
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:13:02.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvn7r1AVYGYIvIu3GZIZaNlnXGC4vPY3zRAZLjH7QAi2aECi31gN1zjOURuNAunp0uz1wOmlqryxEZ79nznd3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635



[...]
>> And then you can run thus command:
>>  sudo ./xdp-bench redirect-map --load-egress mlx5p1 mlx5p1
>>
> Ah, yes! I was ignorant about the egress part of the program.
> That did the trick. The drop happens before reaching the tx
> queue of the second netdev and the mentioned code in devmem.c
> is reached.
> 
> Sender is xdp-trafficgen with 3 threads pushing enough on one RX queue
> to saturate the CPU.
> 
> Here's what I got:
> 
> * before:
> 
> eth2->eth3             16,153,328 rx/s         16,153,329 err,drop/s            0 xmit/s       
>   xmit eth2->eth3               0 xmit/s       16,153,329 drop/s                0 drv_err/s         16.00 bulk-avg     
> eth2->eth3             16,152,538 rx/s         16,152,546 err,drop/s            0 xmit/s       
>   xmit eth2->eth3               0 xmit/s       16,152,546 drop/s                0 drv_err/s         16.00 bulk-avg     
> eth2->eth3             16,156,331 rx/s         16,156,337 err,drop/s            0 xmit/s       
>   xmit eth2->eth3               0 xmit/s       16,156,337 drop/s                0 drv_err/s         16.00 bulk-avg
> 
> * after:
> 
> eth2->eth3             16,105,461 rx/s         16,105,469 err,drop/s            0 xmit/s        
>   xmit eth2->eth3               0 xmit/s       16,105,469 drop/s                0 drv_err/s         16.00 bulk-avg     
> eth2->eth3             16,119,550 rx/s         16,119,541 err,drop/s            0 xmit/s        
>   xmit eth2->eth3               0 xmit/s       16,119,541 drop/s                0 drv_err/s         16.00 bulk-avg     
> eth2->eth3             16,092,145 rx/s         16,092,154 err,drop/s            0 xmit/s        
>   xmit eth2->eth3               0 xmit/s       16,092,154 drop/s                0 drv_err/s         16.00 bulk-avg
> 
> So slightly worse... I don't fully trust the measurements though as I
> saw the inverse situation in other tests as well: higher rate after the
> patch.
I had a chance to re-run this on a more stable system and the conclusion
is the same. Performance is ~2 % worse:

* before:
eth2->eth3        13,746,431 rx/s   13,746,471 err,drop/s 0 xmit/s    
  xmit eth2->eth3          0 xmit/s 13,746,471 drop/s     0 drv_err/s 16.00 bulk-avg 

* after:
eth2->eth3        13,437,277 rx/s   13,437,259 err,drop/s 0 xmit/s    
  xmit eth2->eth3          0 xmit/s 13,437,259 drop/s     0 drv_err/s 16.00 bulk-avg 

After this experiment it doesn't seem like this direction is worth
proceeding with... I was more optimistic at the start.

>>> Toke (and I) will appreciate if you added code for this to xdp-bench.
>> Supporting a --program-mode like 'redirect-cpu' does.
>>
>>
> Ok. I will add it.
> 
Added it here:
https://github.com/xdp-project/xdp-tools/pull/532

Thanks,
Dragos

