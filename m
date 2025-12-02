Return-Path: <bpf+bounces-75895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 05895C9C354
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 17:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43D25348472
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B073A28640F;
	Tue,  2 Dec 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OxXzCVEh"
X-Original-To: bpf@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B9270557;
	Tue,  2 Dec 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692964; cv=fail; b=q3fMLcOPe0gxwCf/IZCKQ8qXfmeKJaV+PtMXrgC21S4zSu4Vd3HmhV/rDZHn4I2QY0nPzWgRADl7t26SX3de2ff2ROMJyXOX//Z6g37OdcyOfCYVzhMzzq+qNGAEjfdGwo03Xsy2d4Sazm11Tem0rJ6pJnkFBWR88GLdsQKdon8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692964; c=relaxed/simple;
	bh=wdVDF50mHq4+acHRFRFWZvbe+1A6WbVknBZydhMl55E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l6dZV9pOfGjiRGYWUTKrfbWYxm5ttH65+2O4YsHZyvHffLA69ko3VAR7ECvn+Q4SY0hwJlyx4cIPREX4HGK/mLH4wGx9cB0Ic9F2go8ZGxntwg2VrZuRQzq4FWZWVdt/lovenXL4DJNUFMr+X4T4ofBunpcx8J+IClFoS1LLOSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OxXzCVEh; arc=fail smtp.client-ip=40.107.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gV1cp21W8GXopwsnSJP3HrMi+wmTpbC7KLfNKySIB2vuhGEMbnEV0zyv4BUad6zwpMXG5K/eaWvkodOuCcnomeCgGHwbV780cUD5YDhHAFcEzEkUKugxtfP+6GVhotHrFLYoBLLY1I97O0l5H4pjFJPx/88mfEj5nEWT9JkR2o7RDjTqI1FR9u2JbGLXy/UEHahxScJOZ0/tYzqpk76D51PZUM8/VAQnOkI90NUeRrfbhwzCoB1cWAiKBj9as1ajstyUGoK9p6u5sOiRZGo6tty/2zHwxSaZEn8ab0KH5QkUrm1JMS+aHqt4XJmAP0po8hBgvEWCNbqk13a1tMDFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNjK6YpPmEvUkX7hG1s+Uu7SqHQeJf1gJOjB9loDRlE=;
 b=O8QS4sEact8sGmNDOphotPBWPNDJiaizc2SqYE0UNwHRd5Lz3uNveJVHOpgIEE6fbwSKN3DsY33eIxiCh0p/Go1YO+Rxgx9b/ux0De47yuNMGh7lUTJxOe+78r5THHhCn63RSyx4eOWqz2hjUYjj/rtfIa6hdlXxZK3QACZIl3LbiSS7zRYu5TOo3PxdmgCzCaMmLQO97eN5n+hM70dvIkbZaodW9mj2EI2NCEdD49IqXB/WXBPnr0pm1FUxfP6RAa0AbREng3ltW5O4TlSiroKzx8aHcWwEdv6IghcU48BTYKxQwQQYS7VP1aLdxIpWApg5TGoq1lUaJ4IgaCmCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNjK6YpPmEvUkX7hG1s+Uu7SqHQeJf1gJOjB9loDRlE=;
 b=OxXzCVEhwWZIcgaIl04aF4q0kvhfOSziutfTkfoumSAPRYuf0y1K+1BHOWyz2xG+TdNTi1/e5+Ovdlss+1R+8hByK2XMhEirDwgXtRyp5T8Jmd59VLi+NNpU7KoE+bG51Yi9yrUkXEOTzmEbpvm1ygqX/7Zp5fReWOuymvAOR2Gx99Q5Wgq57b3fU55UappXXMa+5U7Ghq7wefCHC4qR2gfQrPqK50z7FJvxHlc7XcnS3SWqGTtLAaHHtoUACRwiUyKMqsrVRY06AIlI+NduS6u4qewCYBXSDG1spyWWReggaINSl6gtiCzrtLlwTrtBM7pVRM772ZqfdLHEGy9ezw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:29:19 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::7e7c:df25:af76:ab87]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::7e7c:df25:af76:ab87%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:29:19 +0000
Message-ID: <5738aa55-8db6-4d62-b7e6-14c644f9c24b@nvidia.com>
Date: Tue, 2 Dec 2025 17:29:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] xdp: Delegate fast path return decision to page_pool
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
 Martin KaFai Lau <martin.lau@linux.dev>, KP Singh <kpsingh@kernel.org>,
 kernel-team <kernel-team@cloudflare.com>
References: <20251107102853.1082118-2-dtatulea@nvidia.com>
 <20251107102853.1082118-5-dtatulea@nvidia.com>
 <d0fc4c6a-c4d7-4d62-9e6f-6c05c96a51de@kernel.org>
 <4eusyirzvomxwkzib5tqfyrcgjcxoplrsf7jctytvyvrfvi5fr@f3lvd5h2kb2p>
 <58b50903-7969-46bd-bd73-60629c00f057@kernel.org>
 <wrhhvaolxu275zw3fxgvykg7tndzp4pl4u3mnw3z4t5yfbkpix@i2abs45et7tr>
 <ad6c4448-8fb3-4a5c-91b0-8739f95cf65b@nvidia.com>
 <cfc0a5b0-f906-4b23-a47e-dbf56291915b@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <cfc0a5b0-f906-4b23-a47e-dbf56291915b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::18) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec50421-9a4f-43e2-e58d-08de31bff12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzlFM0FLZDNlNUxCT1VQdC9xY3VPZTRIdGgrL0xHMUpFc0VHV1M2ZWUzRjUr?=
 =?utf-8?B?RmlSQjVZMFZ6eHUvTkovUi9JQkhmOGFlN3dLT0s0K1lQRGI3L0lXa1FqQ0Jv?=
 =?utf-8?B?YmVWYTR5aHRuVEhQRk5MbmVGRXQ3eTM4RWRvUG5DUHlGUXNzT2tXdk5ubWRi?=
 =?utf-8?B?TU1OaU9ocUVyMW8rKzkrRHArK0Q0V1V5UWI1L1hvQjcySVNlajJNVFYyWTRr?=
 =?utf-8?B?YmovTFBieUhwaFc0WXAzL3E0QkxKNTJQQ3FNSmZ1MmdpWlhOVmRGME9tQnJr?=
 =?utf-8?B?VVZBLzV3Q20wZkNrZ1ZEOFhKNm9iZkc4R3YreWN0RUJ4SEw5eHdERVlqY0hR?=
 =?utf-8?B?clhMUkp3OUhTQzBmMUhoNHRFNFdUTzlFdU1ybDhwR0xpYytPcmFCYmllMndq?=
 =?utf-8?B?YndVbmxiNHhQYUdsYTc5aU8rTEtWRVVhZnFXY2phR0s5ZDBiWGhISnQ5SkpB?=
 =?utf-8?B?eXpsTE9XcG9FOTkxNnNZTzVlczhSdTBEVEhrd01MM2U5QjczYU1CUU5ndktl?=
 =?utf-8?B?L25uSnJ5aEt3NkNaMU1uNkZDMXc4NHJibksrZEpvc3NNbHh6aTA5WnJNMUpO?=
 =?utf-8?B?RTFBTmtSR2tOTVlXR2ZrTFBZcjY5OElZTWozRnFwVHVGMmJpQ05NYkdNRjA3?=
 =?utf-8?B?TW9mUVlUTjZ3a3JOSU9LWnUzTVJ4V3Q2eDFUY0FOY1F6MmpISjl3UHExMjNE?=
 =?utf-8?B?NHd3bU4vaEwycVdBVUNMMVQ4WmhTd1VxMnBKdnA4ekx0MFFLSW5DSlhlTTZn?=
 =?utf-8?B?VEhTdDR1MWpkT2hrSXhzTGIwb0R0RjBqbzRuYVFkeGFBZVNURGswRWJTdW1n?=
 =?utf-8?B?TlgxMnpmVDhyZnZIZUVESlhCanEzdm9Bc2lpaWFGcS9GMGlmcHN3UjBQKzFH?=
 =?utf-8?B?Y1RyUWNyTzNuak1GZFk2RmRhc2ErWmd3NzB0S3RPZ3p1aHpsYWs5MFhqajJT?=
 =?utf-8?B?aFJtdS94LzRSSUpLQzIzNTFoMXZCc2YrcE9ERCtheEVOQ2lRMS91ekk4QS9R?=
 =?utf-8?B?S3plaVphamVHOEhucHF3UzZKQTd0eUJjeEdoNW5RNXJkejBjRkl0K3E2K1NC?=
 =?utf-8?B?d0pkME1HekNZQ1B4L0hRZUJKNllydmJBZ2h0ekVBQ2lSSnhVWkErYkdBUHNo?=
 =?utf-8?B?VjR6NEdJejRSbUJxVytwSzBiejZ0Qk9xRkdhUnVkREZ6M3Y3bXU1Um5RZlo2?=
 =?utf-8?B?VHRrUkFLcHFhVlVGQkpxSUlDT3lld1VEOGU0T2lBdFZ6V1UxVWFRKy9zZFZ2?=
 =?utf-8?B?MlNmUGtPajd2YkdpdThRZ244SVY1OGdabkdBYnBUTkRBWTgwUmI5R3pLU3BP?=
 =?utf-8?B?clI4L29qdnc1U3h1ZjQzem1ha0dzOVAzU3FVZFBEVFhOdzBhWnREVllXZ2Fp?=
 =?utf-8?B?eEN3LzA5QnFqeEZYdnJPRGxWTm5SWjZIb2NUUkwwLytCTmRxaDJMWXBhaWpW?=
 =?utf-8?B?Q3dTRk9HRDE4eXRKdkZBQ1JlSGY0eHJZY1daZDdoOFVvMHRKSkR5a3N1N3Rm?=
 =?utf-8?B?cFhwa2ZmZG9WaEVTeGtibkhMWlpwajljdXRqUmhJL0JvYlhGQUdscEkrRngw?=
 =?utf-8?B?VWV1ODZrNEZhTFpqbE1QSkVxTG5ZemtGZnBjY0lZYjVWMWFOUXNvSWF1MFFi?=
 =?utf-8?B?RklEQVNMc1UwTWlNck12R1hPVVpyV3ZvRUErWjZCQTVqWkM4MEhxeXloVnFt?=
 =?utf-8?B?UEo5VUNtenJJMTc4UmJYcThKVkdEeUVjK0pNcUdhWEhhUS9admpaTTVZMlhk?=
 =?utf-8?B?VVdjck5qUlJ3UWl0ZFNFUXJGMVMwN1FIcVRPK3hDN25kNTRsSjIvT0dlOXJ1?=
 =?utf-8?B?VG1RcCtGVCtHL29INjZWaHZzTnRoRlVHSmhVa25SNGplSnM4SW5EbmtVMjBr?=
 =?utf-8?B?aVJrNWRKU1pOdEo3OFBUa1FRR3lzTjQ1OUpmUWNlRytialJEMldEelZ2WnJt?=
 =?utf-8?B?WUJvRWhyVWtzQk1Pb1Zmb1dGRFF0VFpyMUVhNkIxZWNHWkdQd1NnS2ZVbjRa?=
 =?utf-8?B?WU13R01mclVCNmM2ZWhMdXpNUUNSLzVCNHE3QWsvYlhqcTlYaU1yQndQMmM1?=
 =?utf-8?Q?Nn1aTL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXUxR1lRTEFhanl3dmsxVVpzOTFvdTgyYkp4ZmFUd2ZjUjAvdjB6cEJZdjdX?=
 =?utf-8?B?RE80c0t2Tm5YbFB5K2hoelplZWNsbEJsVmhFLzNPNzJQODJORVpjb0hMOURK?=
 =?utf-8?B?L0ZKaFdTVkUzTGhlNHdzWnF0WVhWZ2R4VytSTDRSUzd1c3diblpGV2lBVzVP?=
 =?utf-8?B?Y042ZERmV1RDODRHVFpLR0JNYmhrTkczUjhMVEFKY2ZEd04vM0t1VG14N2gy?=
 =?utf-8?B?QWhFY3dWd0dKYkFia2JaOGhteW0wbXdHSXc1ZkdIaUNvRlUrb2kxMGNWVnFE?=
 =?utf-8?B?K0ZjdjB4aTdKU1Q0S2tlYUoxcHZXdGh3dytDUGRkS0FYQVRWUDR4Q2E3OXR1?=
 =?utf-8?B?Q2sxOXdFQlBwMnNja2d1a0RJMHBWSkJLNjFDd1hoOUN3YkNhSzVrcm94UG9N?=
 =?utf-8?B?SXU5MC9CdlIybDJ0aXB0NFlVQytkakZvd1Y1ZC9GcFdEWU1TaVQ3SnVrNUR1?=
 =?utf-8?B?TUsvYzhxVENlbFlzQ2hVZXlMUzZaeERlZlJxbEp4dWRtMXBjVWdPcXAyZkVB?=
 =?utf-8?B?YjhNdGlFcU92dzhQa0NFZDk0emR1M2dHT3B0TmRMQ0pIQ1lWVzg2amxqejhN?=
 =?utf-8?B?bG5QOTN6Mng3Q1BNb0k0QTRDYklUa1VqN3VKNm9lSDkvWEszTVVvTlFRN0dG?=
 =?utf-8?B?YXBNWkFQVFVpRm9XSDV5ZDlYSWlCdG0ycFQ3eUhtdUdRM1k2WEFITkFrb0VX?=
 =?utf-8?B?QTlMTFFGL0VKcFpML0pzUzR0TDFiL0E1M0ZRMmcwTWs0UDFHd2UvUnluWFVL?=
 =?utf-8?B?dGU0dlZjQkdQWDZOdDVkUkZING44V1RDbkQ1STI0QTNlNDA0QytaQWdUZmtm?=
 =?utf-8?B?YzBvQ0M4NzMvUFg3OUIrZTRCQVBIK1Byenh0V1pLdjZhdkJMSnMyaGE4NjI2?=
 =?utf-8?B?QVRTZW1NN1FZdnFFVHhmR0lpNWFsTm5XQW5DVGtQc1RnaitXbjhQR3RtQno5?=
 =?utf-8?B?c0syaVEwUjg1ZitIQ0FCMU9BRmNNYXlXUEJpWmg1UzcvMmJwdkdQNUpaaU81?=
 =?utf-8?B?UCtWbGw4S1NnMFplTVdqMElxak1xN0ZOemFqV0U1Ny9Nb3dVZVB3Nk56cmlq?=
 =?utf-8?B?b0hGQXp4UDlkRDhaNzUyeDlNSXdySDRFaVhyRXlFbnFHSDJ6cUFSL3hYNUFW?=
 =?utf-8?B?by9xVjhYaHNjTENWQmplM1p0ekQ1aFFhZTdlK2RULzVndDduRFFJNkN6MVpk?=
 =?utf-8?B?VHVxaTdENTZjeTdzdjVzQXcwcWsrU241d3RmNlFRSTBuOXhESldWcGEweGly?=
 =?utf-8?B?YTVpS1FiSzhkanpvZ3NlSi9VMWFVR09iTXNRanh6OE5tK0R6blhSUkNEM2py?=
 =?utf-8?B?Wk1oRm0vLzhTL2ZHWUpLTTZ4U0gyOWp5ZVZvUDhORmpldjNqZjdSQTJxVVVT?=
 =?utf-8?B?WXlKSzE2eDlYbjhvVWFsQmdOSmFqOXd4ZVA0S3pHUHNSZ2xSSGNwQU5GRlky?=
 =?utf-8?B?ZWYya0prVExXb1RqelVtSUt3MEVFWldPQk1CS1B5WlJWWkltbk1LR2duU1hU?=
 =?utf-8?B?Z3pjU1F5ODFVZGRZMWcwaWptWVNTQXp2YmRaMEdmZElNNTV4Yi9pR3BRSlBZ?=
 =?utf-8?B?Vy9ycTV2cXRKNFMxR3RTaFNXMk1CL0MxYi9GRE9McmxvY25uT0hPRE9WUTg3?=
 =?utf-8?B?NTZBR0lQSEFLbWZrczlWMHdLVUQwd3FJbThpbm1GTDFjYnliTndMdW56K05U?=
 =?utf-8?B?d1N0aDlnWGhvWDVKZGZNV0tpTVM4bWJqY09lZ05LdVJzaHkwZkJteSsvV3Vs?=
 =?utf-8?B?aURaUXZya3RnNUhoWUNvQ04rQTUvVTlkWXpqN2ZsOEpEWmE5dldwdFVBbFY0?=
 =?utf-8?B?OGpuMnFBaEhHWDJGYWw0WFRpUzVpWko0d1QxdHFyT1hwVXd1ODBVMzFKK1M2?=
 =?utf-8?B?bklBM2FNZGlDYnI2TGJWWFF4dS9kYzl3aXFTWFlNNk1tN2lmQlkrMmNYeFRh?=
 =?utf-8?B?bHlTSUhIUVVKWTNxNGJ4eDFtTHU0Zzc2T0NLbEh6SzFIbHhrSkFqVFc5U2pG?=
 =?utf-8?B?YlhoMDF0RVFSQzRVdENaandDVTI2enFrbkthSjkzdWVXNGFmMmo3M2E3Zm4w?=
 =?utf-8?B?dHplekZseXdGZlVSTUVSYk1NMzQvWndKZDJsTTF4RlptUXR3TnYrMTZDYllQ?=
 =?utf-8?Q?U4mFJ2CRUcJjIaRWOaESSrfaN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec50421-9a4f-43e2-e58d-08de31bff12b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:29:19.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzX8XgTgtU/n+B1ux2erp3G+gwHZtPG2okUHu81+dJSMxU4OpD9hh4ISOcaePlLekY5vc+wrZ9xZkfL9J3D32A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533



On 02.12.25 15:00, Jesper Dangaard Brouer wrote:
> On 01/12/2025 11.12, Dragos Tatulea wrote:
>>
>>
>> [...]
>>>> And then you can run thus command:
>>>>   sudo ./xdp-bench redirect-map --load-egress mlx5p1 mlx5p1
>>>>
>>> Ah, yes! I was ignorant about the egress part of the program.
>>> That did the trick. The drop happens before reaching the tx
>>> queue of the second netdev and the mentioned code in devmem.c
>>> is reached.
>>>
>>> Sender is xdp-trafficgen with 3 threads pushing enough on one RX queue
>>> to saturate the CPU.
>>>
>>> Here's what I got:
>>>
>>> * before:
>>>
>>> eth2->eth3             16,153,328 rx/s         16,153,329 err,drop/s            0 xmit/s
>>>    xmit eth2->eth3               0 xmit/s       16,153,329 drop/s                0 drv_err/s         16.00 bulk-avg
>>> eth2->eth3             16,152,538 rx/s         16,152,546 err,drop/s            0 xmit/s
>>>    xmit eth2->eth3               0 xmit/s       16,152,546 drop/s                0 drv_err/s         16.00 bulk-avg
>>> eth2->eth3             16,156,331 rx/s         16,156,337 err,drop/s            0 xmit/s
>>>    xmit eth2->eth3               0 xmit/s       16,156,337 drop/s                0 drv_err/s         16.00 bulk-avg
>>>
>>> * after:
>>>
>>> eth2->eth3             16,105,461 rx/s         16,105,469 err,drop/s            0 xmit/s
>>>    xmit eth2->eth3               0 xmit/s       16,105,469 drop/s                0 drv_err/s         16.00 bulk-avg
>>> eth2->eth3             16,119,550 rx/s         16,119,541 err,drop/s            0 xmit/s
>>>    xmit eth2->eth3               0 xmit/s       16,119,541 drop/s                0 drv_err/s         16.00 bulk-avg
>>> eth2->eth3             16,092,145 rx/s         16,092,154 err,drop/s            0 xmit/s
>>>    xmit eth2->eth3               0 xmit/s       16,092,154 drop/s                0 drv_err/s         16.00 bulk-avg
>>>
>>> So slightly worse... I don't fully trust the measurements though as I
>>> saw the inverse situation in other tests as well: higher rate after the
>>> patch.
> 
> Remember that you are also removing some code (the
> xdp_set_return_frame_no_direct and xdp_clear_return_frame_no_direct).
> Thus, I was actually hoping we would see a higher rate after the patch.
> This is why I wanted to see this XDP-redirect test, instead of the
> page_pool micro-benchmark.
> 
Right. This was mentioned in the initial message as well. I was also
hoping to see an improvement...

> 
>> I had a chance to re-run this on a more stable system and the conclusion
>> is the same. Performance is ~2 % worse:
>>
>> * before:
>> eth2->eth3        13,746,431 rx/s   13,746,471 err,drop/s 0 xmit/s
>>    xmit eth2->eth3          0 xmit/s 13,746,471 drop/s     0 drv_err/s 16.00 bulk-avg
>>
>> * after:
>> eth2->eth3        13,437,277 rx/s   13,437,259 err,drop/s 0 xmit/s
>>    xmit eth2->eth3          0 xmit/s 13,437,259 drop/s     0 drv_err/s 16.00 bulk-avg
>>
>> After this experiment it doesn't seem like this direction is worth
>> proceeding with... I was more optimistic at the start.
> 
> I do think it is worth proceeding.  I will claim that your PPS results
> are basically the same. Converting PPS number to nanosec per packet:
> 
>  13,746,471 = (1/13746471*10^9) = 72.74 nanosec
>  13,437,259 = (1/13437259*10^9) = 74.42 nanosec
>  Difference is  = (74.42-72.75) =  1.67 nanosec
> 
> In my experience it is very hard to find a system stable enough to
> measure a 2 nanosec difference. As you also note you had to spend effort
> finding a stable system.  Thus, I claim your results show no noticeable
> performance impact.
> 
Oh yes, converting to ns does bring a different perspective...

> My only concern (based on your perf symbols) is that you might not be
> testing the right/expected code path.  If mlx5 is running with a
> page_pool memory mode that have elevated refcnf on the page, then we
> will not be exercising the slower page_pool ptr_ring return path as much
> as expected.  I guess, I have to do this experiment in my own testlab on
> other NIC drivers that doesn't use elevated refcnt as default.
> 
This part I don't get. I thought that the point was to measure the impact of
the change on fastest path: recycle to cache.

Are you saying that you would like to see the impact on the slowest path
as well? Or would you like to see the impact for a mix of the two? Maybe
mlx5 can be hacked into this mode for benchmarking. But not sure I understand
your usecase.

> 
>>>>> Toke (and I) will appreciate if you added code for this to xdp-bench.
>>>> Supporting a --program-mode like 'redirect-cpu' does.
>>>>
>>>>
>>> Ok. I will add it.
>>>
>> Added it here:
>> https://github.com/xdp-project/xdp-tools/pull/532
>>
> 
> Thanks, I'll take a look, and I'm sure Toke have opinions on the cmdline
> options and the missing man-page update.
> 
Oh forgot about man-page. Will wait for his PR comments.

Thanks,
Dragos

