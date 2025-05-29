Return-Path: <bpf+bounces-59298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3BEAC80AD
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 18:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583E64E5BA5
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 16:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6571322B8CF;
	Thu, 29 May 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cskYxXKm"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2112.outbound.protection.outlook.com [40.107.92.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6191F4315C;
	Thu, 29 May 2025 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534790; cv=fail; b=QfB+ZJxAj1hjEv/oupWZB3nvk1RabtWFjqNnn4p/TbbsdMGX1slufsAkuo8fU4V7XG9qc0g63ZDbZJ61gRCI6raDGW5BFZ6AiZ03SpZ3bVpuhxga79TcXIekBIBlv0iAZnHO52m4//ulTS1X54oyQJvECGKIKHpDprh9N7B68T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534790; c=relaxed/simple;
	bh=MXg/jDi6Qj7iN1GLtseqLf6vrX42RSK9E10Xaz0gPy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pq1PrpeDWzEox1M76AXy2xe+70nEsTH2ol8FG9sOhz4VMViz3txFQpDTEyPM2c0++sm8M34ATPphzxXuem00u15OKxIEncv0Vd18Y4GsarcfXaqIKk4AXnXUEW3P42g/tWM+2INoRDkPPg1YkYD+3XkO64jh72jrhbq8ww9VkyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cskYxXKm; arc=fail smtp.client-ip=40.107.92.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LM3F/PlZ72cwEfytompTuEMtgNt9znTnQ8HHE8O+CSGSf5qZGM9c+mcrI92cO3RYwaRoALJgSDPO41TAoC+Fk6ygfuLHt6uXmoWI4HT3E3Z/HFd2oo4enPy6LDPWIgGXeXE+ArcETt0MH97IFGggcn2FMvpMLdjg5F5soJe7QHKq/HIq4euLek7GmIMRaVOvWtEKf71ySD19kmLREs8R7X6rrowZ8vEA/CfnwAoQAytBpSIg/o7Ta6m+U45hj6M5zFiUWi9+fsGWDMsiMuEK8+Th9a+FcFqbYIkJhj1bPCLqKH1jNkbOVNzHnSUqlVsxA4D4cRH/6WNTAiT6kgUmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXg/jDi6Qj7iN1GLtseqLf6vrX42RSK9E10Xaz0gPy4=;
 b=cmMtbpyBvSHKhatQM4GJMldN6B88JgzsAKwdYLYRyhLCRrq4/CKLD+K08eu5//n6ysBIGqCuuuEKC/2ZOHvIO2adyYpIROJMg+ztZeVkyLIYLrQSOCC7EFHqXLbtL1gdGOtbH+XMdyjVBVdq5ZDhDutqhkRGpswRGexJU+qsR5Smx1nB22Tf5Q5P/bUZzphhzS3AwOS36n0rkVkZLner+HfDFzYdT/9t72jolQDjDABh0OOVAq/JlMSmzha9+NRqT+kWTmCLFls3KXFrqp3gDu7WwbISoLJ4cVf+RwKkK/0udFu3tfpyXie9KEbLVTQOErQ29A5aYO4NROlsz9iESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXg/jDi6Qj7iN1GLtseqLf6vrX42RSK9E10Xaz0gPy4=;
 b=cskYxXKmixGbw70/bKsg441WgGl37Vkx9UWNlXBMprWyZsNWDtJ1tRe7A3i5r5bMu4Py6LUxyjt5STBAGhP0U2eIKLTQNrJXnaoPIFXSXvzPO/9z0oxkhZFcjNHDUovQYNWqL57Kkq8FHZrP21d9bjXX+2cq875fcbOsouxplL0=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by BL1PR21MB3234.namprd21.prod.outlook.com (2603:10b6:208:39a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.8; Thu, 29 May
 2025 16:06:25 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%4]) with mapi id 15.20.8813.008; Thu, 29 May 2025
 16:06:25 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "leon@kernel.org" <leon@kernel.org>, Long Li
	<longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org"
	<hawk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, Konstantin Taranov
	<kotaranov@microsoft.com>, "horms@kernel.org" <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next,v6] net: mana: Add handler for
 hardware servicing events
Thread-Topic: [EXTERNAL] Re: [PATCH net-next,v6] net: mana: Add handler for
 hardware servicing events
Thread-Index: AQHbz1BoMiCTL0PghUKhgNYiPeTEZbPpKrwAgACdr5A=
Date: Thu, 29 May 2025 16:06:24 +0000
Message-ID:
 <MN0PR21MB34379C832400E17F10F6C687CA66A@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
 <21c1b2d9-1b94-4caa-aa68-8abbb6562446@redhat.com>
In-Reply-To: <21c1b2d9-1b94-4caa-aa68-8abbb6562446@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d9a5b75d-6fd1-48f4-9159-8a66bbf911ec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-29T16:05:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|BL1PR21MB3234:EE_
x-ms-office365-filtering-correlation-id: 65e377c1-19fe-43e9-1cac-08dd9ecac316
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjNPL2ZWRVluNlNVUCtaZUJ1Si9iOXM0TGZIaEhYNUIyK1hRR2tQaG1XYUx3?=
 =?utf-8?B?SldSUHFBcGVDQXNsczZVVUxSSHU0STdXZERIMmtxNUwwQ1hvZFRPLzV4ZHlN?=
 =?utf-8?B?MkR6VmxIVHpCN28wOUtrVzIxNEdRM3ZRbFdUZ3hnV1ByNnhYTit2d21mV3Ar?=
 =?utf-8?B?OWpwV0RpcWNPQW42dWF4aEE3NktZZngzOXp0VmRNS1lnMElFdkZYMVhiMUFM?=
 =?utf-8?B?QjBWNG53eWk0aVNqOGF6YisrYjFEUThBSjk0Rm42K1NrUHBNNFVIS2luSGln?=
 =?utf-8?B?U1VDZWFpS1JkbkZ0QThpeUM0NGpGcTVxWkpNV2FQTUR0aytmSlMvLzhxM2Jx?=
 =?utf-8?B?aWtIc2IvQjdPU2FUSzFwWkl6TDl2cnZkclRuUVdoRzZUTEgra3Z1aXp1MjZ0?=
 =?utf-8?B?MCtSTlgxZVRLekpxWFV0eGFDMDNWeWVlbGJIVVJqSU10UWFDMnU1UTNPeisw?=
 =?utf-8?B?UUpxWGJMOGV3V1VjUXRsM2NxUmtCNWtaTGkwclBsWU9ISnp5TmcweDVyWXhl?=
 =?utf-8?B?NG5uT3dsM3hKcWVKeTVnQlJjczhwTGZ6REdadHVwWHpGRm5wSVJVWFdNTG5C?=
 =?utf-8?B?NjEwTDVhNWc5em16cjJDOThsRkN4SmdXZ2pMTU9VREt3UlhBMUtLMnJyeHh1?=
 =?utf-8?B?a2tIb005Q3kzbVJNc3c2bE85WDZpaks4QXVWMm1RalZGL09VczVEZ2lZK1hZ?=
 =?utf-8?B?NGVlWFo5cVB6bFBRSjdlOFRZL1Q5SERPbCtINGN5aFhpVldNdUpyK0M4YzNQ?=
 =?utf-8?B?TU5WVUdSY3ZiK2pOMkx6SWRDbWxNcjhCVjRHYlo0MjBrdlBjbEx0TllwZ0NF?=
 =?utf-8?B?MlJrc2JGb3lOMitieFRZOUdZVXFoYXZ5WVVGNWxiaDNYNmVYTExyaG9xRWpa?=
 =?utf-8?B?aWZFK3BWcTk4d1JPQmU4cDVXNEIvTGdlTUxTQ0d4bVBBSW9ORk1vdlRvMDJz?=
 =?utf-8?B?ZnN2aUorMXNnTTJmeHhkcmFTUXpVUzlJekU3K2YyMnlHcUNNR2l4eFRNTEZL?=
 =?utf-8?B?aUhuZHM5emRxTE1hSHlGd0V0TkEzWHp5RXR5VlNsVjBsMGhKZUY4NE9MY0dy?=
 =?utf-8?B?N216eExIVSs4dGNIL0w3TGZjOFhBeWVjUmdvWGxodlJKdmxuSWgxeVNnS200?=
 =?utf-8?B?VE5rdkU3SUpVTjd5SXZJdFJwR3NQczNLZWZTRXpUWGh6cUkvSkZnaFFJTnNW?=
 =?utf-8?B?dXVvYmYrQjB4QXJFUmFyWWJCS20rTmJWS0p2Ynl1TlJobnhoSVZvd29tUjBl?=
 =?utf-8?B?N3U5ckpkWHdRRFJvQ1MrQUw1aXp2M2UxS0lZQ3BUeUdCUlh0dTlvUXRwUXRr?=
 =?utf-8?B?RHpHYitQNTRCeTcxNjZ5S1FoYkllM014ZTd5R1djTXc0Wi9WRDhPblRuZ1FT?=
 =?utf-8?B?L0swVlFFb3R1elF0cFAySE5od0xZWFBuNTZKcFI4cmgwYnBMUDRyR3VHdDRW?=
 =?utf-8?B?eUZRejdqbGpMRGpZdXJ2azhtWlNNa3JVc3BSUkZHRVVNcE5idTFFMW9UVlBt?=
 =?utf-8?B?V2N5VkZ5V2FMelE1STE3MkZQQjc0U0dxY1Z5SnFXNFljT3VEa3lTTDFPb2ZS?=
 =?utf-8?B?ZjNRa0FXTUlrTG5SV3BXYkNvOWthVmFUY0g5eUlGbkRTaStMQzc4WmtMWmlF?=
 =?utf-8?B?c0tTa2xULzlUckxmN2F5ZG5iNGV3Z2RDSnJMSDgybmRNV1lKRldJSE56WldM?=
 =?utf-8?B?RUU2M3hWT0cyMnloRHp5T1E0akp5SzlQYWFrb2V3RTkweDZPYlowd0ptb0RR?=
 =?utf-8?B?L3o2ZTNYbVNTemRheTNFUWd1ZTk3cEZkcE1xL2dGNHBzUGdvRW1pa0VHeUNZ?=
 =?utf-8?B?ellLV29iMzVIb1lHcXViY0Y1QmgvakNZSjd1KzJmMHl5MUg0YkFKS08xZVhZ?=
 =?utf-8?B?S1RwaGgvaG9mSnB1eXNvNGZOM092VVh1SFl5NU9xa2MzeDRIOXRiNUxyR1dq?=
 =?utf-8?B?dklJb3l2ZWtKNUNFTUg2ZTEraVQ1eUxVTy9RdHB6dndidC9PNU5QWVI5ZFJw?=
 =?utf-8?Q?fS3qzXme4JHvGXm0/v67gD9+0NiUW0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qkl6RGx2MzNqOHh5TzFoR2xiWTVGWW1jNmVPM0FDcXl5Z2Y5RWRRLzQ0R3Ur?=
 =?utf-8?B?V1JkRUJ3cVFvcDNLN1NGdnEvWjYxQXJaV0RCdzgrOHpWcGZxbjEvNFRMVjZ4?=
 =?utf-8?B?MVV5ODJRc2FFNjhvWk44UkRLZ2wwcXNhY1gxTHRqNERnbms3SG9pQzBHN1Rm?=
 =?utf-8?B?MFlxaHFjSjVaaTdKQk9zb0lLQWpYeUl4UkFuVXNlWGRnSjFmanhIeU9BcEZk?=
 =?utf-8?B?bzhGVUgreU9iV3RuZFdWNGFOUEY5QWFTd0svckptKzBYZWNkRDNFTEZJK204?=
 =?utf-8?B?a09iaHJaK2h6Ty9COHBaL1V1dXVxUEtxcENNYldKNUc5Tk9GSVlaajZhUUh5?=
 =?utf-8?B?YlUrSWp5dFhNZm9FaFFoMENtN2FrSzBrajY3SUliTlVJcTg5bGpuZVUxK1J1?=
 =?utf-8?B?TFlEbkJhMTJ3RFJVd1pJd3E4MFpNQks0WFJYSjBxdlZ1UW5rY1F1b0k2b0ZU?=
 =?utf-8?B?ZHJCa3FMUm1Vdkl6V0o3Y0dHRVQ4emwyUy96NXk3Z0xWNjB0eFYrRmpZOUtK?=
 =?utf-8?B?TnovNlMyZkhCa3dsWGRySDF4K0xYVmJhcU5ibE5KcSsxNkpZbWxhYy9wVStR?=
 =?utf-8?B?MXBObkxqYTFiTXk0L0RrdW5QcmpldnBWRW9Hc0Ewa2NWSVAyYi96VVJXSWxN?=
 =?utf-8?B?bzF3N3VYTmNBcFg3R1Uzejc0SGZ1dnMzeklkU2gxQStFSWg3bTNac2ZOOWp4?=
 =?utf-8?B?V1ZiS0Foby9vNzEyMkJ2cVRaUjZuTTlOTDZIcElpVWhLeUthemY4VGN3NmYw?=
 =?utf-8?B?RC92VUp2d2w2YTFTWGtwL2E4QktIcytPRGZkZzFya2R2ZExObEllbzhLNy9G?=
 =?utf-8?B?VXNjN0QwcS9jM0Z6S0gvMTdXTk5oM0Rsalh5Q2h6d0J5V2FtNEpUdGhTUWpW?=
 =?utf-8?B?RjNET2RwZGJoRlRGejhSQ216dnBudG53S0xSN2tsbzdIbEhmaHlqT3BqUUVO?=
 =?utf-8?B?Q09rZ1hWTjA5OUtQcVpPZS82Qk5JUStTOUwrZVdQUE9URW9NZnF0dWp6TTdZ?=
 =?utf-8?B?eGEyV1dtT24wQ0ZsKzVVWkRYckpzcWw3VW1aOFZ3OFVXS1ozS05Xd0lEeGpQ?=
 =?utf-8?B?RDlNNnVpT21XVG8xUFhIellrWGQ4NGdYLzkyOTZmZDNUWDhOc3VFY2pkM3BV?=
 =?utf-8?B?Nlh4SjIwdmpXQ1AzZmZ5Zm8zY2R1dzNJb25vZldrWXpPb0ZWTEVBWEFURVdr?=
 =?utf-8?B?TGRxSTVqR2NXZWJsVWZrR0p3a0cvRVpGcE8vb1RHVWIwTkU1VXRmc0tnQXJj?=
 =?utf-8?B?OUY1QkR6UXR4TWtnb1JOZjZNdUxOSDF6N3Npb0dJeThzdlVIRmorMW55bmhm?=
 =?utf-8?B?OW44NXh2bUNENWxTY1BVVGR5UVE0RlovbjQ2dVd3SXlhcW1UTU90RWlmVnkx?=
 =?utf-8?B?dE1xVFlHb3IxNDAzV05QRCtuRGd0ekpxVWhHRnVWZ3VuYTJNNVo4NzBNKy94?=
 =?utf-8?B?Y1J6QU1aSTVKRzJZZzBoMDJmSy9jZkRmZWV4M3RVMnlNbGZoUEc0Z2tSbld5?=
 =?utf-8?B?VXh0OUhTZDU4MmRCRCtoaDZ0d2p2ZDdmb295eHZaY0pqenZ5dEpoOHU3Z2dj?=
 =?utf-8?B?ZE1Dam4xNS9ZOXdoeWlhWkV0MXhNUW16TVdnWTcrc0pjVUZ1VWZONDB3a2pt?=
 =?utf-8?B?YStjRVdiZ25qQWc5UERwYU1QaVU1UmNBc1RwUHJWejhMSFNyUUFYTHBJcmZT?=
 =?utf-8?B?RlJrREVobm9uV2tQbTYvbHhxa3dtVXkxK0cxUmd2elRBOVlVeFBQdDJ3OWEr?=
 =?utf-8?B?ditmU1BlUFNWcG9FUFhZMHYzcnlCMUlETnBzdEwwTXo0M0RQUmVKcmNIbHVX?=
 =?utf-8?B?R3Y1UVUyUUZwb2V0Q3ZKc3JWdmNxeXlsWXVvUW1MWDVwbnN0dTBsUXdlZHMx?=
 =?utf-8?B?V1hBMUh5YkF3UkpGVGszSUhLWnU2UGR2ZTRpWWFFQyswVTVkTzl1dUFDY05a?=
 =?utf-8?B?ZEZKelBMWGNHN1ZXUTJLUGRZOTVsbUJWQ0poNmc4M3ZQcDA0QVFaa3l6UWFI?=
 =?utf-8?B?SEFwWnV5Y0ZPdW5qUDNBQWp6V0k5MW9VcjBnZS9JNmg4eWFpMWZYVWg5VkMx?=
 =?utf-8?B?ZkZ4TTNUVXVUQURJMmFGRlRvNEFDMXhmblBBajdVVG1neDQ4amJYQXQwMHY0?=
 =?utf-8?Q?+2W7UuIAtlensjzEUU76S6r8v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e377c1-19fe-43e9-1cac-08dd9ecac316
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:06:24.9914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ly+B1Ej2AAuRXEyvyctkGxbsmv9/ycFq415MP6zBdD+oNKlDvXe4CnbodNq2lLxnD2eDo0W6Qy9C9Z9ctEpXIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3234

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDI5LCAyMDI1IDI6NDEgQU0N
Cj4gVG86IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBsaW51eC1oeXBl
cnZAdmdlci5rZXJuZWwub3JnOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBEZXh1
YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPjsgc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc7
IEtZDQo+IFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPjsgUGF1bCBSb3Nzd3VybSA8cGF1
bHJvc0BtaWNyb3NvZnQuY29tPjsNCj4gb2xhZkBhZXBmbGUuZGU7IHZrdXpuZXRzQHJlZGhhdC5j
b207IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+IHdlaS5saXVAa2VybmVsLm9yZzsgZWR1bWF6ZXRA
Z29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBsZW9uQGtlcm5lbC5vcmc7DQo+IExvbmcgTGkg
PGxvbmdsaUBtaWNyb3NvZnQuY29tPjsgc3NlbmdhckBsaW51eC5taWNyb3NvZnQuY29tOyBsaW51
eC0NCj4gcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGRhbmllbEBpb2dlYXJib3gubmV0OyBqb2huLmZh
c3RhYmVuZEBnbWFpbC5jb207DQo+IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IGFzdEBrZXJuZWwub3Jn
OyBoYXdrQGtlcm5lbC5vcmc7IHRnbHhAbGludXRyb25peC5kZTsNCj4gc2hyYWRoYWd1cHRhQGxp
bnV4Lm1pY3Jvc29mdC5jb207IGFuZHJldytuZXRkZXZAbHVubi5jaDsgS29uc3RhbnRpbg0KPiBU
YXJhbm92IDxrb3RhcmFub3ZAbWljcm9zb2Z0LmNvbT47IGhvcm1zQGtlcm5lbC5vcmc7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQ
QVRDSCBuZXQtbmV4dCx2Nl0gbmV0OiBtYW5hOiBBZGQgaGFuZGxlciBmb3INCj4gaGFyZHdhcmUg
c2VydmljaW5nIGV2ZW50cw0KPiANCj4gT24gNS8yNy8yNSAxMTo0MiBQTSwgSGFpeWFuZyBaaGFu
ZyB3cm90ZToNCj4gPiBUbyBjb2xsYWJvcmF0ZSB3aXRoIGhhcmR3YXJlIHNlcnZpY2luZyBldmVu
dHMsIHVwb24gcmVjZWl2aW5nIHRoZQ0KPiBzcGVjaWFsDQo+ID4gRVFFIG5vdGlmaWNhdGlvbiBm
cm9tIHRoZSBIVyBjaGFubmVsLCByZW1vdmUgdGhlIGRldmljZXMgb24gdGhpcyBidXMuDQo+ID4g
VGhlbiwgYWZ0ZXIgYSB3YWl0aW5nIHBlcmlvZCBiYXNlZCBvbiB0aGUgZGV2aWNlIHNwZWNzLCBy
ZXNjYW4gdGhlDQo+IHBhcmVudA0KPiA+IGJ1cyB0byByZWNvdmVyIHRoZSBkZXZpY2VzLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogU2hyYWRoYSBHdXB0YSA8c2hyYWRoYWd1cHRhQGxpbnV4Lm1p
Y3Jvc29mdC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVs
Lm9yZz4NCj4gDQo+ICMjIEZvcm0gbGV0dGVyIC0gbmV0LW5leHQtY2xvc2VkDQo+IA0KPiBUaGUg
bWVyZ2Ugd2luZG93IGZvciB2Ni4xNiBoYXMgYmVndW4gYW5kIHRoZXJlZm9yZSBuZXQtbmV4dCBp
cyBjbG9zZWQNCj4gZm9yIG5ldyBkcml2ZXJzLCBmZWF0dXJlcywgY29kZSByZWZhY3RvcmluZyBh
bmQgb3B0aW1pemF0aW9ucy4gV2UgYXJlDQo+IGN1cnJlbnRseSBhY2NlcHRpbmcgYnVnIGZpeGVz
IG9ubHkuDQo+IA0KPiBQbGVhc2UgcmVwb3N0IHdoZW4gbmV0LW5leHQgcmVvcGVucyBhZnRlciBK
dW5lIDh0aC4NCj4gDQo+IFJGQyBwYXRjaGVzIHNlbnQgZm9yIHJldmlldyBvbmx5IGFyZSBvYnZp
b3VzbHkgd2VsY29tZSBhdCBhbnkgdGltZS4NCg0KV2lsbCByZS1zdWJtaXQgd2hlbiBpdCByZW9w
ZW5zLg0KDQpUaGFua3MsDQotIEhhaXlhbmcNCg0K

