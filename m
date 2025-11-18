Return-Path: <bpf+bounces-74930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EA0C6899E
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7115E4F46D0
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C2D2D5940;
	Tue, 18 Nov 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X00XV+FH"
X-Original-To: bpf@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3181513777E;
	Tue, 18 Nov 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458585; cv=fail; b=UrPZYBGteYVXV0qTL8T4EbtRbhUnLU6LsXfZuafHMXk0KjOgUdmmf7+9HvWSqjw+FOeE7atEk8oC+d6S/k+/OTXQrc0CywutYzSSahfnfWXwX/LNtJQJXSC9C02/Qp0LGL0Gfs/IV1rQYQlXlxiDGFUWiHAM+UQrKfsTlNVMrGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458585; c=relaxed/simple;
	bh=pjnDGWLuCVDPnAi+G7beoLMR0iG0DDSNnso/6IOnR1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nh3RbZxAftvBOZGQ5ze9N1byBct8UJ0ddpLVq69R/KUIdatmUzmb4MucyRkk0yRnBEunZ2/uchqnwd09GZvgZB5Mq5hsPpKO3yOPt/6fftRGrrZ0VNKawm/6Fvk9jXW5f6+prYeWlQUhJiP4vnJ6pGlbm9XH0sGV0slEAIA2usQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X00XV+FH; arc=fail smtp.client-ip=40.93.195.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/+hHxBAbr1BjoBQ2FUDTSgtKBjLcFqG7CgqUkFDyO0b0E87s6rb0q89LkweaNMJgGhcbNhno7TBqAzg6t4HWKCJDjPh9VlgAwg1wpCgp8vtUcGidz8gwLfX97FjqlU9gAn5UJGKbUa7EIBl319jfCxUJc435T3zPx0k9yVzuz4LV/7PWMbp9gA9MEHFJ9cT+I/cz5bEG9NJSodTMJvFs/Tu7/MGAwb5laWXfUwK7QzCRRbaP+cWukYVUlWBZxVhE4Qy4tAD+vz5PFPB8ivlVx/v5XdwgduQS4BBIZra0+zkW4bFtaTXr1BiQyZmkGhmM1or79F38l1+mVDhv3TxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4776vsjsCmiTux3ieNKc2neWGwfWrVJf1HV+PKZwcMM=;
 b=r8bY4SyG63Ck3wJeLwOKUtylBsjJ3GxNevCBHLstshzek8MghCE5/TshcXYrRdr7rlZF6OSOE5jsPeGlAnljgRrF3M4TSsYg+DTqV2A+4xFIfAWkYETLW46V6FeZovTEazXt8ZEyz16Y/X0GmZ5mbQTCnWtxrJkzdztCdsWSBhxBGO2KfbdKqqqNAeJV301vbCTpzVCk7XAT2pZtD/jCu2Ze7PfHivPzcqel92abavN3+jKaOQF+VmDUidemxsgwmE9FOWk+4rlz3VgbBQ7ZFMEZCNqCWhqUvrJpn4e3sFIdUdErJg5ouRYpA5TeJxkniadjZKkqqyhJ/irWpSLZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4776vsjsCmiTux3ieNKc2neWGwfWrVJf1HV+PKZwcMM=;
 b=X00XV+FHVDCt7S5KGcUPSrU4bJTjL2keGDLo9pcTw8i9YksNYVMxMjsheye7O+vcYjrib/mV9f/7l2wNZsrYzzmqao/nDhFURTcFd1EPCK1vS9mjepn920fvBxWz2WaTgLTr4q6/u2kCj0gIueTWV4QPsP1RHNRepV9bws3bjJt2W53ePVVgwLHMzxBc/qGigG5qjJ8qcs8BuzRt55SrWEoMFleZa2jfwQKKe5kgpdzBPg+eFyqDqvj2x1uWrY+tlx4FcgUY+/zc23SHWV533hB0JG7BiM+384WaPMKw6ZUinRuFQ4gEhI59if0oA8uUAwCj5ueXuM25RfiIXbslqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 09:36:21 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 09:36:21 +0000
Message-ID: <c66b0dfd-a9c4-4eae-852c-3cd9d9babe4f@nvidia.com>
Date: Tue, 18 Nov 2025 11:36:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] tools: ynl: cli: Add --list-attrs option to
 show operation attributes
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 Nimrod Oren <noren@nvidia.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
 <20251116192845.1693119-2-gal@nvidia.com>
 <20251117173811.0b600b80@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251117173811.0b600b80@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 6687e2fa-ed36-4649-3478-08de2685eeea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDJXNENTV0lYK0RoZ0FicU9rdUFXRUlHQXlFejZDdHoya2VZZzBtdDJYTHRP?=
 =?utf-8?B?Z21iWnVGTUExbU45RFFFVGdvYldRY3NKTDZSeGEvNnBmYjh2VzBuQjFWbUk4?=
 =?utf-8?B?TitGR0p3ZGdKcEpQd0lhdHdxWnVpOEEwQklSZmdNV1UybC9WOFRsNGpMdWVT?=
 =?utf-8?B?Vk0zVXJtZWc3cXZMWW10VWNUUDZpd1hKeXJjRHgySUZUNXB0K2JaeXZUdXBl?=
 =?utf-8?B?YjNBWVpqcG5Vb2RQRktqSmtmUWdvYk1nMWdlOS83QnhPNmRJZWRXa0o4eW1s?=
 =?utf-8?B?bUlvVEJoTkd2MndzTTIwdUVPM0hkZXoyQXIxV0t4ZGg3YTNjcGp4QTJhNXNI?=
 =?utf-8?B?c0ZESlQ1R0pUOExxbUtpMGRVaElidktOdHUxMU5KeWs5RkZQU0tZU1RMZWR4?=
 =?utf-8?B?d3VGRGFQVG53TEVwTWhDditJcWY1SmNIamlqQncvM2s1UmgzMEZJY2tPUG1W?=
 =?utf-8?B?a0w3Q3R4VkNTR2tjaVQzd0kvK0E4T2wvVzBCclhVUzR1TVZCOEVFb0I1R1pS?=
 =?utf-8?B?YjVZdVdjdWs1OCtjandpVTNEMk5GN2Fhd09xOHZML0xRSXJmaTB3VWRpWTJp?=
 =?utf-8?B?UmwyOCtyOS85aUlRNXN5aWFWNi9YeEdoQ2NwWGhYVjhsUHJTa1VhSXdsZmll?=
 =?utf-8?B?VkkwczBvL0RrcVF4dnIrUkNGK2NLNHZML1J4R2txelBmRkNTaW95MUpKK3hS?=
 =?utf-8?B?RW9MK292MUhsK3ZnNU5YdUJ6TjkvdnJrY2NsbDFjWnNQZEZlY0psSlNpbitU?=
 =?utf-8?B?WFEvbG1pNzZ3UG96aTh0SDNOQ0pGazNveVJiY25HS2tzT0dWRHZlOGxtU2Zo?=
 =?utf-8?B?T2RWZVNCZUpTV21qaXgrS2YwMkI1d3M3ZHFiWXp5d0Z1V1l1TlFnZ1JnNVB6?=
 =?utf-8?B?c0ZBMk14MDh0dlJDWm5HQjRlSFNQSEkzVDgzc0xERFlDYWFRdHNIbkwxRUJy?=
 =?utf-8?B?YlRNZ2JxbWR3ZUR2OFZ1WmZXRTJWckFIVnVTY2dUNFlHS2dJY242WGZlb0tp?=
 =?utf-8?B?eU8yY1NjaGJycUNpejYvbkVpU2pLc0xnMTF4MEpCVkIvTjc4cTluSWpDdElu?=
 =?utf-8?B?ekZsOFd5a2x4S1RzQnVVOFVkdCtoQVFHd0JRMmNvU2h4UFA5VFdEZ0UxcXAv?=
 =?utf-8?B?ZjdZaVp4bE9rNlRxTDYzT1BjKzRVRW9vYVN5RERCVlBkTkdXUmdsZG1QcDRk?=
 =?utf-8?B?aUNsQ3V6STFCZW43bVhxUktRNGZNVjNsR2hqUWw0WDBQZnBzUUZlbmhFUUdW?=
 =?utf-8?B?YzR6N0Z0NkllRjR0azRYVXhndkg1QUVNMkFOU2VWdDY4ZG1KNkpabHA2VHZu?=
 =?utf-8?B?Vi9icmpodkx0K3BPT2hsNWhORmI3NVZjNVJEYXF5d0J0anJvQzcrU0hmNXpJ?=
 =?utf-8?B?S2J6eU9NMlRpcDN3V2w0cnhHQS9GYUZCTERNRWdFMTJhZGY4Tzgxb25hSzJT?=
 =?utf-8?B?dWJTd1YyMFNyVGxYZDBKdnlmOW9vclFpUk9VdTBPMHpvTk5FYzVXYlcyVldH?=
 =?utf-8?B?TUV1a0d6U3VXWnJXbW54K2xyMnVGTkMyaVVtNnVXSVJmRWV4TDdyVG5oallN?=
 =?utf-8?B?clUzL2JUVk5Tci9FQmlaWmFvaE54WEtHRCsrUmRNUmhzOUR3cjN0VDRoQThO?=
 =?utf-8?B?RXNDNXlrKy9jdUFFSXVrY2NkaldTNEdZSUtHbXBwRDRzb3ZIUUtzYVJHbmMw?=
 =?utf-8?B?QXpmQTMvL3AxVHo0c1pSNllubEp2U0phWHk5VVMyNWNsd2JXNGhOY3Y3VC85?=
 =?utf-8?B?MitrM08zUFRCaFJkaFc3TU1XV0VuZFJBcHNwT0RaNWRSZ2F3VlhvMVFzMm9R?=
 =?utf-8?B?YWtHT0FVVkVOb3BaeXlrdE9scDZ1Q1N4ZzBiT3R6ZHpab0NxNHdTNkw5aGZU?=
 =?utf-8?B?bSs1emxBSlZVb3hIdXhCK3VVWUxvYiszN3hZdE9hbFJrelBmV21CRnRUMWtO?=
 =?utf-8?Q?ygrui64Px0Sr6Z+zgvHCfjkj98lXVyHg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVlSeW11bGtFckx1U3NWWCtZKzVvanZWUjlST0p2bXB0amZUSHp6cVFEOGJF?=
 =?utf-8?B?TjhtZDJEUVRjOVlucWk2U0pjNkhOdkc4OHlXdytNZk1PWFB0c2tBdDJFNFBi?=
 =?utf-8?B?V09XZ1NTclVEYXFlaWs1UVZHbkNRU3Y4cVhuNEQyNVFQaWkyb282OE12ZTZh?=
 =?utf-8?B?cEpwdDZSNjBsVDI4aWRmODA2dC9senZrWFNKbkcrdkV0VTFhS1I1d0d0eUg0?=
 =?utf-8?B?OVVLY3JnSkVWaldCSTlGK0swcnpVY0VTa3AzTzRGNkJ5TSttWUVheEhvSXNX?=
 =?utf-8?B?MHRDLzlUQnpVWVdBYm1FMC9tdWhJUjFKVW9hMjI3R1hiMjRYK3ZWWTNtZDRk?=
 =?utf-8?B?SEh6NTJTK1lhd3huMEJXQjF5NFIyLzdEbTJla2puU3Qyd3JvUnhJTkljSndr?=
 =?utf-8?B?a1VEcEI4bnhqQ3FaelU4M3NzNXN6SFVlV1JTbldOV1kra0tHaG5CZ1hEUDli?=
 =?utf-8?B?M0tBSlNvbTR4ODJJTDBrdmR1cFJRZFpDYk1pWDhERlZBTk1yL3dqMFpER2FG?=
 =?utf-8?B?NXRYOWpGTXRubERhTUhUUTRzbVNmV1pVNGZ4bG9EaG5IUDZFR1lSOWd4T1BG?=
 =?utf-8?B?WlU5MHhvRTFFRFBReGV1UGw1clFsbzRhUUh0b25qcyt0S3FEVHVaWkVmb0NU?=
 =?utf-8?B?emRSRmJzUkE2REYwUlJFV3ZrcUJ4SURscWIreEx1dHRaNmRZZzFCTjJaS0ZZ?=
 =?utf-8?B?dEhYVW8vaEtNWFZTY1VPZlAzV0JEaVpLOUV0ZG8vWmVCdVZvbUQ5OVV2dTA5?=
 =?utf-8?B?Vm00LzZlMEUxakc2QXp2YWRRZ0tYU0dDWHVIajQ5VE5VTFpDK1RIN043Tmdv?=
 =?utf-8?B?TmZZZlYyMVJaN0FaN2RUd1pra084UkN3VjNRd1Y2dkRpOUxSQS90WXpCL1pL?=
 =?utf-8?B?T0tZYk1laE9RckJTV2RUb2RTMWdOUzErTzhwbkZoV1p6WUZUOXFLTS9yRWtF?=
 =?utf-8?B?THBSV0xYUXBHd3J4blNvQVdicFJhdjRtL0pTbHFIY0huMUVvU1NUT2x0R01F?=
 =?utf-8?B?ZDArSzZnMFVyWG1zRDBpd050bUs5T29yaHhsd3hzeUxlR0thblJNdzY5MmdC?=
 =?utf-8?B?L3FiSXFRL2hiaGNaWTFaS2JBRHJEdVZLRnhhLzhaYlE3V0F4UGkrVHJEM0FH?=
 =?utf-8?B?QWpjVFMxMUZsTk5maGk0Z2dUSEliSXFwQ0lEUVUvMy83WVI2ajk3Ty9Ud0lI?=
 =?utf-8?B?RVJRdEJxYVZKOEhmQVdoNmZFdHV6L3pFTkQzOVpwbTBLTWNaMVI5eEdxSUtT?=
 =?utf-8?B?TkJLLzhOOWhHbG1FYUo3OThmYVNZZlQ1aURycWNkOUp0K2liQ09kdjl1aEFQ?=
 =?utf-8?B?K2ZtSDg1T2l2bmVGYzVXWWVTNVJURCsxaHozVzl2cmJ1STFiSStkT3R0QWx0?=
 =?utf-8?B?ckJTRVk4Q2IxejBYd29BYkNxUDY2Q3BpNWVEQzR1M003KzhxeGg3SWtsREk3?=
 =?utf-8?B?b09tS2JMcEgzSUNuOUhBeDdYcTNxWkZyY25aOGF2SVFqaUVqa2NJUU5ENi96?=
 =?utf-8?B?anBqbElYaEY2b1A2K29nRmxXcG1LWkVjUlo2VVJiSkpHNW04cExsM3ZHdCtY?=
 =?utf-8?B?T25oTEVnK1c2c21IdGprYmlUaUNzd3BOWWNuTk5JWng0clFveWo3NHBzVEht?=
 =?utf-8?B?NzF5VUtZUE9HMzFjeVdOakIxVmYrd1VsS0x4Y3phTlZ0WjQ4VzMycElEN284?=
 =?utf-8?B?eEtFcnRMb0pxZVpmaTJlZkRqd0FLaXVuM0ltOGs0OTlhY25xN05zUmJTelpV?=
 =?utf-8?B?bGhKWXkrNWpQTGliYU5aSE9rNDUxUjdZMmhhQUl4aXBBa1UrNjhHQ3dPN3BI?=
 =?utf-8?B?dmdnZ3h2RkQrVTVPZEVRRVpUdWZBTkFMeEZiZlRyanppTGxRaXJNakRNTEhC?=
 =?utf-8?B?c0xEVytjcUNzbXVIM1lGWlBXVVFaMDFIUm5STWR1NVRRS0Z3UmdwNDRodjEx?=
 =?utf-8?B?MEprOERGMit6QmZuVTh3K3N4Y29vY0JJeW85enBsaWhEdkcxbU1uSzNEdFVS?=
 =?utf-8?B?VTEvc3VKdkh6QjViVzlOK0czbHZ2eEhZV1V4bjBzeTNGZmpCOFY1dlo4amp5?=
 =?utf-8?B?ck1CeERKUGxtYWhVbmcwOUNmRWZNWVNEaGNNazEzNFZRN1F6cE5PMGE3RHEy?=
 =?utf-8?Q?YwZdeeWM9ye6OGiI8F2+rE9OM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6687e2fa-ed36-4649-3478-08de2685eeea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:36:21.6583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMBZYiTxm98pQzqA2edz/81g5nj8ATHqq6jwxuX6Nb5gnixAtHP6CRAblR4foKBz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

On 18/11/2025 3:38, Jakub Kicinski wrote:
> On Sun, 16 Nov 2025 21:28:43 +0200 Gal Pressman wrote:
>> Add a --list-attrs option to the YNL CLI that displays information about
>> netlink operations, including request and reply attributes.
>> This eliminates the need to manually inspect YAML spec files to
>> determine the JSON structure required for operations, or understand the
>> structure of the reply.
> 
> I _think_ these two pylint issues are new / should be fixed:
> 
> tools/net/ynl/pyynl/cli.py:166:0: W0311: Bad indentation. Found 16 spaces, expected 12 (bad-indentation)
> 
> tools/net/ynl/pyynl/cli.py:166:42: E0606: Possibly using variable 'op' before assignment (possibly-used-before-assignment)

Will do.

