Return-Path: <bpf+bounces-55412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2420FA7E591
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 18:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2324D441FA4
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3F205E08;
	Mon,  7 Apr 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTH91HWm"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A442054F7;
	Mon,  7 Apr 2025 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041068; cv=fail; b=PSC7jEBeQHBr4qgCLth/mUmriMn5rdXxQwTXruL1Sm6CLPZQrJs3dSbkKhEhOHwUTKhflPYePPQvFr9IMQztg9Z2GGyKZMKqkn9BIkzbIgxzdegLmLRwvUNjA9bSkltIDFlqzXsIPd7LPgdlhMBeZf3cAAgeaLGY9D5fV87Tno8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041068; c=relaxed/simple;
	bh=nxzL2FsVfuPe7C79ol8vD9LdS9mk0cs1q+9ibEuQc2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PaKBAB93jGgkWPqXVjXP+sEqpxSCtkk2DYKNzeVBoRIYZXTPDeaKdxVHh35zJe+Old7uYlJ4RivsHLJFWzo6pDQsS/w238LGiaeMU/hIYNUqQNmTFiGstTadmEe6f5KSXiqmYOgB3LZ0c3MZ4vRTiF/FDmbexcXvS0r73B08PzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fTH91HWm; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6PTIJFtlQXZGEVRSd8AMjtv86naSZtK7vAwURLxrSrXNNCv9fSvlkABW/Vkj0h6lad+VVknHZV1W8KzyhhmE28KgPu3Dymn7RHy6A8KjBlAuGgkGlrPSMkLMQGlBPobmKwxARaye+MDdmHUKy3wcbjxvur/HOvDQCJ/4ncdBIngkA/UzBV9WxoskIjDCu+l7uKt8Al+6YdoxA43iSb5jDX+a68B0dr3lbIO6iYmbez2fX51qqYhFZ9H7X801a+kcEnl0IaKhjCTz33HZHY5iD8klB71yadvbHqaCWvxOClRTPtRPXdhT2OPj8b9QkluIvn16yDeViKrZofSochw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hMEJQJyf8k3psPxq35ujB2UzUqpfsm0Kmaau7wDBG0=;
 b=Kyw5L/lgkpo2btdPiv5YxVI5V99cxso+PC7rwNBjkQyuSijZvkFtHJiwvu8LpBnVr2Rj8zxSrU8itEmnIPtypQ7ASR0R5CW4Flm/jlYHXykXmvTmGnJberKBYZqPSTgIDnTPTCd8Q/DSJiQsduCQZq6FZoVgDjNLPNZz6MjlTC64S6Eo0Eu+d7HI1fvFSP4tRJiHkrKEOh3EIjxdFS4C1mz5lLu6pfPVlZ2T1+DqwZK+YMDGFHkTZw8p/pcELdVUWkP76TnqBd3Rtelwqw7zww//u8yyZa9ZPZSYbLrU6y9XK7Pjewc0RHf3jwOubNLi/UY8+uHBsDAq2FCg0tfKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hMEJQJyf8k3psPxq35ujB2UzUqpfsm0Kmaau7wDBG0=;
 b=fTH91HWm1kIYXQ7GaBBoK6mI233n15Nfe6Ba3Jac9mhSnwkF/bPdtUT3tKWUHUOI6VNsqqOgaXv95TW46MU+IChojmz2v6mdR3mbeFbSfueOdkHf2g3i4o5PydzzrsogM78Kx7KQ3Qae8iXYwIcBHppkbE6b6N9HODIW7p73MjO9yHn7+cK5qSbAl/+sYJ39fuvWBeb52tSdIqDZD5dRcpBDSibes5T142HOv9xVu3q8wJt2v4wnfZLZGCPXzAsKyPUdK05RvXidtdTZFxeZbY/1s/P2PCy+uXesBMX4AL9ScbMRUXfCLfeXPoKqS2kRhDsRzUE9r7KRIRWC6KOfaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 15:51:01 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8583.041; Mon, 7 Apr 2025
 15:51:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
 kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into
 helper functions
Date: Mon, 07 Apr 2025 11:50:57 -0400
X-Mailer: MailMate (2.0r6241)
Message-ID: <4185FF99-160F-46A9-A5A4-4CA48CC086D1@nvidia.com>
In-Reply-To: <4d35bda2-d032-49db-bb6e-b1d70f10d436@kernel.org>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
 <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com> <87cydoxsgs.fsf@toke.dk>
 <DF12251B-E50F-4724-A2FA-FE5AAF3E63DF@nvidia.com> <87v7rgw1us.fsf@toke.dk>
 <E9D0B5C7-B387-46A9-82CC-8F29623BFF6C@nvidia.com>
 <893B4BFD-1FDA-46DE-82D5-9E5CBDD90068@nvidia.com>
 <4d35bda2-d032-49db-bb6e-b1d70f10d436@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:160::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 29bac72f-d85d-4310-c685-08dd75ebfe90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0Erd24wV0RFY2JZTzJ2aStheHliODhZWFVKSGFNU2lmblAzZFVZV21aZnJr?=
 =?utf-8?B?VUgwZmdid21QQ2xtOVkrbHZUTG5oVmlaTEJYQnhSUzl3dENMQmdNNUJ2cEFD?=
 =?utf-8?B?MmRVa251Z3E1dlJZZUZ1WUNGMlZqaFhPbmEzeTgwQmVwM0JBeXI4Y2NSVHV2?=
 =?utf-8?B?SnlaTC8xN3ZyUWk5aUhZNzB4UnBLaE9qL3E1UlplcUpqVlk1cnRZSTlzbGFs?=
 =?utf-8?B?RjFoKzR3WkRGK3Q5cklmT2xOSFBXWFh4V1VmV0RNYTM5K1dUUEhsaXRId1lz?=
 =?utf-8?B?TUxwQUdIcVFKZHlNbGN3K1hxSERqWU5kRUV0Ly9lYm5lOHdHYzI2Z3h6ZEtp?=
 =?utf-8?B?bmdPOEQ3TWVjTVozMmt3MVNzdnJza0NPQVZvdGUxS0gwbTJXcTh3ZWNCaW9N?=
 =?utf-8?B?bmdkeEduNUgzdFZnNzFuTnZNT1BNWThuUnN1YTFYOXo0VnBnN0xYU1ZXQXFP?=
 =?utf-8?B?OWFmUnlkMk1kYmVaUThCblpBd2g0WURHMGFDNFVCSmlSeWY3Mzl0c1lmYUVv?=
 =?utf-8?B?NC9EUEFwaEJyVzZ5eHI5akFiblBQVUxtOUNQWU5jU1B4UkJUUTZzYm5ZZmJ6?=
 =?utf-8?B?SnpEaDdGSXpSL3luRXl2M0hHZDIyZ1A1bGhycElRdXNNUlRMaXBvcFNaK0la?=
 =?utf-8?B?SmZSMUR4NTZyRW84QlZFc3RaRUNlZU8wc1FHM1ZtRVFkbzJRT0pHUFMzSnVy?=
 =?utf-8?B?SmMxQk5wMXh1ZEIwUUsvbGovU2RabU9PL1o2dGdYWFRYcHVJSStEUXlPVHR2?=
 =?utf-8?B?VWV4VWhTWUhNZmxTR2U4bGFDWmRhckg5dFdoRGsramRrRW1BUHJRL0sxdVpj?=
 =?utf-8?B?dUFrbG9mbW5IajVUczdEeVVRUC9GcGE2VmxLWmhVREh0OEMza3Y4SURHZlZM?=
 =?utf-8?B?cmpqLytMM2NvRHlXRjQyTm9aNHF5RThVUjBNU29MVUh1ZmVpOWpLdExWN2tP?=
 =?utf-8?B?V0FaWXU4TjM1UWszZkk4VWNzeitjRWdrci9YMUFteU1ReHV0N2VCdExUdXRL?=
 =?utf-8?B?cE42NUx0RlB3RldxOGl6YzFFbFdodGZaRFE3Nng5VzExVkFDbFJLYXliaXFo?=
 =?utf-8?B?ZklkNzFlOXdjRVluZW0zaDJ4Y0lqUjVKMWQ4V21vTXAyMW5iem03QmYrQ0Uy?=
 =?utf-8?B?ZzhLdDIwODNhYm5GSWZBYUgxTC9rL1I5NFNaY2J2VGtWM0Q1eHZ3d1kwTSt4?=
 =?utf-8?B?WHpPTFJCaFF4NEM4TW14UE9hNDl4NmdVZDYvVnJwd0hkNVF3bXZLa3hJZDBj?=
 =?utf-8?B?aGgzbXdHSzUrc0pVbVM1RHNqNS8zQ3o5ME5na1VJNm5wa1FwVHhQeGhyZ1ho?=
 =?utf-8?B?WmR4dlk5dy94S05HRlBjcW40ZE5QVEFWVVQ3aVNTUm5sdjRKa0JhNzVNQ0VK?=
 =?utf-8?B?aXh0b0oybXFYSnJlN2oxMHNOYUZIT3NSeTF2c20wYlJKVFBjS2JkMWFxMnRk?=
 =?utf-8?B?T01GMFZqZWpxYWFQZ2FmVG5rb3ZhTUZpWEpDaVRhNmhPcTdObTVPelYxdDJS?=
 =?utf-8?B?VnhKTDRGOXNKajhtWE9sR1l2c3RRZ245SmxHOFhQNzNSdTJ4dW8yZy80anVO?=
 =?utf-8?B?ZmZPSTF5UzVDL04xR1VrOEZEQnhjVmpQZ3V4c0t3YjlJMFdtY3l4RGtrTGxv?=
 =?utf-8?B?cEIzVE0vUVd2SXlkRzMybmIzNEY4ZnlMdGFKTlp5Rklpbk1oWW1mL1Q3WVVp?=
 =?utf-8?B?dUxPaG1CZEFodk5TVS9qbGlRbG5icEdidVkzejhMa0lWRGVtSTVmVlZWZ3Ew?=
 =?utf-8?B?SytEOE1XZ0JnL1RibEJvTmJGc25GRitDRDhVQ01xS2NSeFpmVGt4dzhjeXZ5?=
 =?utf-8?B?Rm81NUNMWFM3MWN1SElKcDdobHhIQyt4Ty9uRVRaUFdGSm02aEVpcFpra2Rs?=
 =?utf-8?Q?cYGF9xvTHi5mt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RloxaFlDNUs4alE1dGdKTXNUMGFpSUw1WldQSlcvTUNGWDVxWTRwUEVzMVVC?=
 =?utf-8?B?ZE5EVFV2NldlMUJyclB6WGFJUjRYTkc2S0NRUTRQUzRsQWR4QWRhY2VlZkZr?=
 =?utf-8?B?dnN4aFJaQjBTcmFqdElySUgxSTZMVDUyRFZPSU9JQitHaTg5VWwzbnNVYlM1?=
 =?utf-8?B?TXhLcC91U1NlTFNtVHNFaE1EeHkrR240TVZNMTdhYzB4RVRNZkZXU0hhN2pK?=
 =?utf-8?B?V0pHWUlrU2I5SVQwTWxVcmR6SzV3TkRVMmI5Yis0VWhiZGkxa1dIUW9DL3JH?=
 =?utf-8?B?bFFSMCs4MTdQVDlZa1VoRHdXUUthbGhPNkszZ1dWK2puRGtIdG1zc2o0OFd1?=
 =?utf-8?B?cjAwc1dkeTVpM3dUWG1VZjJzK0U0NFpJZUFMY2QrZC9yZlhSUEpBZGNtRDNz?=
 =?utf-8?B?LzlDQWQrRnR4Q3VaQmRibmdiZHhuS3Q1NVMwRk1TTWlwSnpRVEZYM1luTDdS?=
 =?utf-8?B?SGFQUTErYnVub0VYNC9McTdROEdlQnZGS2VHOGZibnI2MC9GN0lYUTBYKzky?=
 =?utf-8?B?cjRrRXRvWEZpZkE3SGZqUitrcTAzbFlFT0Q2TXBnODM4d1g2NStZbGJhbjJ6?=
 =?utf-8?B?MHFXcGtDTkE2N2NlUWo2RVlSNXNEVlI0ZkdQaEViNUdWU1IzT2UvaytqclFI?=
 =?utf-8?B?cTUvRTVBeVVaNDNKMFNIMWNWdk5XWHEyUnIvUVp5cy9VK2NzTUFVUCtVSlp2?=
 =?utf-8?B?a1Jmanl3eXVmdjV5QW15Y1llWmdIdWtBR1Fvek5JbHRoRUVZcDl6TjFJZmFB?=
 =?utf-8?B?S2c1ZW5JL2ZaSXNLWVVlSzNaQW5MNVJEaDk0S3cwMEJLSlIvdzA1N053UEJt?=
 =?utf-8?B?S2RiYXVNa0JLL2ZyYkFPeDlmM0kzWXdxeGdNUWJxZU15bUdkeTFQdzIvQXN3?=
 =?utf-8?B?cDd4WFkxeSs5YVUxanAwcDdEZ1BUM1Q4L1ZaakhreG9YMTh0SDFKdFJGeDBF?=
 =?utf-8?B?ZGlMWUc0R3ZhbHRENmtka25pdE9jdFZvWjhNSlFaL2FVZnJKOHFVMDV6bVNz?=
 =?utf-8?B?RjFSRnFYUVVPUjZTanZkTElsekZsaUxpLzg3WUFzdy9VVGN5OXZDS1VtNGx0?=
 =?utf-8?B?YklZNTZybDhpeVI3dW12RVB0dU5zM0xtSHF4K1JUVERaTmk4WEsvcy9QK3hQ?=
 =?utf-8?B?THZjVUxTYVQrVXZnY1JVeFROdGxTVmRqWTJVbkZEL1MzSW96bDBwcjdOOW5l?=
 =?utf-8?B?TW5kWDMwOExaQnEwazlHTU9QVGZOd2EvWE9OcDNGelRET050dGJPR1ZNYnJm?=
 =?utf-8?B?SGtTamZ5SE5sQ3NsaHQxT1prU2FUc2orVXNXbUhZeHZ4ZG03WlJaV253SUlI?=
 =?utf-8?B?SGs0cWRpZ2llY0dEVVpVcTJjcm5yNFFMRnpMNTUvaEpIUGZRbUQ1NnVZUWht?=
 =?utf-8?B?a01yNDR2cWNjak5vMXNGQ3ZWc1NsYjdsYUYrOWp3MW9VZ3BndGcrUW5qTUFE?=
 =?utf-8?B?RmxYRjhBZTV4emx6TksydEVWWVIvU1loVTNjanhpMzA4VXpOZTVnSEVlOHNM?=
 =?utf-8?B?dTBlbW16ODk3aXp6NDEzMEV2RXJqdm1ML05iY2k2eTFURWhQanlFTkxOUkpX?=
 =?utf-8?B?ZVhjR1FRVTJadVpva2piWHhEMXU2a2NHMEZ6WnJlcmpTWlA2ejlWMmhuVFZO?=
 =?utf-8?B?SHRlaDZlUkVDbEoyTUZTNDR5K3VleHdzQm5JUVMxc202L2Y1dU15QUFIRXVq?=
 =?utf-8?B?djFHWHJlRnJiSGJydElhcjdrZHVOSWxVN1RrYnFzZzY4V3pMUmsxRDZlVEkr?=
 =?utf-8?B?ZE4yV2VRZ1huZVF2MlQyNjhSV050R0hOWVpzb2hNSjZKcFBuSm1Lc0JHSWdS?=
 =?utf-8?B?WUMwRzY1S0FvZjJTaGFOL2dQMmhTMCtTLy9HL28yZ2dobVZzSG9hd3lxMUFk?=
 =?utf-8?B?VDAxVEswVXo0SUVDNUJnUmtoSEtTRllCdEw0M3djOVVYbEJNcDhrQXd2YmpJ?=
 =?utf-8?B?SDlMQVE2TGFvWW9OZHdoY1ROWlJCcEt4eElTTFZPVGsybERxNVlTbVUzVW81?=
 =?utf-8?B?OTdqVEt2VTZiR2QrOXpIYXppT0V2bnVYMmlwVUV3YzZzQkxHa0V6SS93VDdU?=
 =?utf-8?B?S2dpdjRESm5VN0hxRTlka3J5OGlrdGl0YUlBM2hBU3ZvdGZTREtpQkhzcjA3?=
 =?utf-8?Q?MY6aGMGYlz+/spOo7VTygJA0f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bac72f-d85d-4310-c685-08dd75ebfe90
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 15:51:00.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0QQJcRTFFwsuzbSMvj8vNQomkFVvJ4H5BuP8oMvgn83w0diRsUizbFebQKRQYU1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

On 7 Apr 2025, at 10:43, Jesper Dangaard Brouer wrote:

> On 07/04/2025 16.15, Zi Yan wrote:
>> On 7 Apr 2025, at 9:36, Zi Yan wrote:
>>
>>> On 7 Apr 2025, at 9:14, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>
>>>> Zi Yan<ziy@nvidia.com>  writes:
>>>>
>>>>> Resend to fix my signature.
>>>>>
>>>>> On 7 Apr 2025, at 4:53, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>
>>>>>> "Zi Yan"<ziy@nvidia.com>  writes:
>>>>>>
>>>>>>> On Fri Apr 4, 2025 at 6:18 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen=
 wrote:
>>>>>>>> Since we are about to stash some more information into the pp_magi=
c
>>>>>>>> field, let's move the magic signature checks into a pair of helper
>>>>>>>> functions so it can be changed in one place.
>>>>>>>>
>>>>>>>> Reviewed-by: Mina Almasry<almasrymina@google.com>
>>>>>>>> Tested-by: Yonglong Liu<liuyonglong@huawei.com>
>>>>>>>> Acked-by: Jesper Dangaard Brouer<hawk@kernel.org>
>>>>>>>> Reviewed-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
>>>>>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen<toke@redhat.com>
>>>>>>>> ---
>>>>>>>>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>>>>>>>   include/net/page_pool/types.h                    | 18 ++++++++++=
++++++++
>>>>>>>>   mm/page_alloc.c                                  |  9 +++------
>>>>>>>>   net/core/netmem_priv.h                           |  5 +++++
>>>>>>>>   net/core/skbuff.c                                | 16 ++--------=
------
>>>>>>>>   net/core/xdp.c                                   |  4 ++--
>>>>>>>>   6 files changed, 32 insertions(+), 24 deletions(-)
>>>>>>>>
>>>>>>> <snip>
> [...]
>
>>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>>> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9ce=
d85e0d198947be7c503526 100644
>>>>>>>> --- a/mm/page_alloc.c
>>>>>>>> +++ b/mm/page_alloc.c
>>>>>>>> @@ -55,6 +55,7 @@
>>>>>>>>   #include <linux/delayacct.h>
>>>>>>>>   #include <linux/cacheinfo.h>
>>>>>>>>   #include <linux/pgalloc_tag.h>
>>>>>>>> +#include <net/page_pool/types.h>
>>>>>>>>   #include <asm/div64.h>
>>>>>>>>   #include "internal.h"
>>>>>>>>   #include "shuffle.h"
>>>>>>>> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struct =
page *page,
>>>>>>>>   #ifdef CONFIG_MEMCG
>>>>>>>>   			page->memcg_data |
>>>>>>>>   #endif
>>>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>>>> -			((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
>>>>>>>> -#endif
>>>>>>>> +			page_pool_page_is_pp(page) |
>>>>>>>>   			(page->flags & check_flags)))
>>>>>>>>   		return false;
>>>>>>>>
>>>>>>>> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct pag=
e *page, unsigned long flags)
>>>>>>>>   	if (unlikely(page->memcg_data))
>>>>>>>>   		bad_reason =3D "page still charged to cgroup";
>>>>>>>>   #endif
>>>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>>>> -	if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
>>>>>>>> +	if (unlikely(page_pool_page_is_pp(page)))
>>>>>>>>   		bad_reason =3D "page_pool leak";
>>>>>>>> -#endif
>>>>>>>>   	return bad_reason;
>>>>>>>>   }
>>>>>>>>
>>>>>>> I wonder if it is OK to make page allocation depend on page_pool fr=
om
>>>>>>> net/page_pool.
>>>>>> Why? It's not really a dependency, just a header include with a stat=
ic
>>>>>> inline function...
>>>>> The function is checking, not even modifying, an core mm data structu=
re,
>>>>> struct page, which is also used by almost all subsystems. I do not ge=
t
>>>>> why the function is in net subsystem.
>>>> Well, because it's using details of the PP definitions, so keeping it
>>>> there nicely encapsulates things. I mean, that's the whole point of
>>>> defining a wrapper function - encapsulating the logic =F0=9F=99=82
>>>>
>>>>>>> Would linux/mm.h be a better place for page_pool_page_is_pp()?
>>>>>> That would require moving all the definitions introduced in patch 2,
>>>>>> which I don't think is appropriate.

The patch at the bottom moves page_pool_page_is_pp() to mm.h and compiles.
The macros and the function use mm=E2=80=99s page->pp_magic, so I am not su=
re
why it is appropriate, especially the user of the macros, net/core/page_poo=
l.c,
has already included mm.h.

>>>>> Why? I do not see page_pool_page_is_pp() or PP_SIGNATURE is used anyw=
here
>>>>> in patch 2.
>>>> Look again. Patch 2 redefines PP_MAGIC_MASK in terms of all the other
>>>> definitions.
>>> OK. Just checked. Yes, the function depends on PP_MAGIC_MASK.
>>>
>>> But net/types.h has a lot of unrelated page_pool functions and data str=
uctures
>>> mm/page_alloc.c does not care about. Is there a way of moving page_pool=
_page_is_pp()
>>> and its dependency to a separate header and including that in mm/page_a=
lloc.c?
>>>
>>> Looking at the use of page_pool_page_is_pp() in mm/page_alloc.c, it see=
ms to be
>>> just error checking. Why can't page_pool do the error checking?
>>
>> Or just remove page_pool_page_is_pp() in mm/page_alloc.c. Has it really =
been used?
>
> We have actually used this at Cloudflare to catch some page_pool bugs.
> And this have been backported to our 6.1 and 6.6 kernels and we have
> enabled needed config CONFIG_DEBUG_VM (which we measured have low enough
> overhead to enable in production).  AFAIK this is also enabled for our
> 6.12 kernels.

Got it. Thank you for the information.

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b7f13f087954..a5c4dafcaa0f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4248,4 +4248,63 @@ int arch_lock_shadow_stack_status(struct task_struct=
 *t, unsigned long status);
 #define VM_SEALED_SYSMAP	VM_NONE
 #endif

+/*
+ * DMA mapping IDs
+ *
+ * When DMA-mapping a page, we allocate an ID (from an xarray) and stash t=
his in
+ * the upper bits of page->pp_magic. We always want to be able to unambigu=
ously
+ * identify page pool pages (using page_pool_page_is_pp()). Non-PP pages c=
an
+ * have arbitrary kernel pointers stored in the same field as pp_magic (si=
nce it
+ * overlaps with page->lru.next), so we must ensure that we cannot mistake=
 a
+ * valid kernel pointer with any of the values we write into this field.
+ *
+ * On architectures that set POISON_POINTER_DELTA, this is already ensured=
,
+ * since this value becomes part of PP_SIGNATURE; meaning we can just use =
the
+ * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA), an=
d the
+ * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTER_DEL=
TA is
+ * 0, we make sure that we leave the two topmost bits empty, as that guara=
ntees
+ * we won't mistake a valid kernel pointer for a value we set, regardless =
of the
+ * VMSPLIT setting.
+ *
+ * Altogether, this means that the number of bits available is constrained=
 by
+ * the size of an unsigned long (at the upper end, subtracting two bits pe=
r the
+ * above), and the definition of PP_SIGNATURE (with or without
+ * POISON_POINTER_DELTA).
+ */
+#define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA)=
)
+#if POISON_POINTER_DELTA > 0
+/* PP_SIGNATURE includes POISON_POINTER_DELTA, so limit the size of the DM=
A
+ * index to not overlap with that if set
+ */
+#define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_IND=
EX_SHIFT)
+#else
+/* Always leave out the topmost two; see above. */
+#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
+#endif
+
+#define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT -=
 1, \
+				  PP_DMA_INDEX_SHIFT)
+#define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
+
+/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic =
is
+ * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0=
 for
+ * the head page of compound page and bit 1 for pfmemalloc page, as well a=
s the
+ * bits used for the DMA index. page_is_pfmemalloc() is checked in
+ * __page_pool_put_page() to avoid recycling the pfmemalloc page.
+ */
+#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
+
+#ifdef CONFIG_PAGE_POOL
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
+}
+#else
+
+static inline bool page_pool_page_is_pp(struct page *page)
+{
+	return false;
+}
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 5835d359ecd0..38ca7ac567cf 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -55,52 +55,6 @@ struct pp_alloc_cache {
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
 };

-/*
- * DMA mapping IDs
- *
- * When DMA-mapping a page, we allocate an ID (from an xarray) and stash t=
his in
- * the upper bits of page->pp_magic. We always want to be able to unambigu=
ously
- * identify page pool pages (using page_pool_page_is_pp()). Non-PP pages c=
an
- * have arbitrary kernel pointers stored in the same field as pp_magic (si=
nce it
- * overlaps with page->lru.next), so we must ensure that we cannot mistake=
 a
- * valid kernel pointer with any of the values we write into this field.
- *
- * On architectures that set POISON_POINTER_DELTA, this is already ensured=
,
- * since this value becomes part of PP_SIGNATURE; meaning we can just use =
the
- * space between the PP_SIGNATURE value (without POISON_POINTER_DELTA), an=
d the
- * lowest bits of POISON_POINTER_DELTA. On arches where POISON_POINTER_DEL=
TA is
- * 0, we make sure that we leave the two topmost bits empty, as that guara=
ntees
- * we won't mistake a valid kernel pointer for a value we set, regardless =
of the
- * VMSPLIT setting.
- *
- * Altogether, this means that the number of bits available is constrained=
 by
- * the size of an unsigned long (at the upper end, subtracting two bits pe=
r the
- * above), and the definition of PP_SIGNATURE (with or without
- * POISON_POINTER_DELTA).
- */
-#define PP_DMA_INDEX_SHIFT (1 + __fls(PP_SIGNATURE - POISON_POINTER_DELTA)=
)
-#if POISON_POINTER_DELTA > 0
-/* PP_SIGNATURE includes POISON_POINTER_DELTA, so limit the size of the DM=
A
- * index to not overlap with that if set
- */
-#define PP_DMA_INDEX_BITS MIN(32, __ffs(POISON_POINTER_DELTA) - PP_DMA_IND=
EX_SHIFT)
-#else
-/* Always leave out the topmost two; see above. */
-#define PP_DMA_INDEX_BITS MIN(32, BITS_PER_LONG - PP_DMA_INDEX_SHIFT - 2)
-#endif
-
-#define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT -=
 1, \
-				  PP_DMA_INDEX_SHIFT)
-#define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
-
-/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic =
is
- * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0=
 for
- * the head page of compound page and bit 1 for pfmemalloc page, as well a=
s the
- * bits used for the DMA index. page_is_pfmemalloc() is checked in
- * __page_pool_put_page() to avoid recycling the pfmemalloc page.
- */
-#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
-
 /**
  * struct page_pool_params - page pool parameters
  * @fast:	params accessed frequently on hotpath
@@ -314,10 +268,6 @@ void page_pool_use_xdp_mem(struct page_pool *pool, voi=
d (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
 void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);

-static inline bool page_pool_page_is_pp(struct page *page)
-{
-	return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
-}
 #else
 static inline void page_pool_destroy(struct page_pool *pool)
 {
@@ -333,10 +283,6 @@ static inline void page_pool_put_netmem_bulk(netmem_re=
f *data, u32 count)
 {
 }

-static inline bool page_pool_page_is_pp(struct page *page)
-{
-	return false;
-}
 #endif

 void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netme=
m,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b14f292da3db..a18340b32218 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,7 +55,6 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
-#include <net/page_pool/types.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"


Best Regards,
Yan, Zi

