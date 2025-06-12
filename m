Return-Path: <bpf+bounces-60451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD9FAD6BA5
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 11:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B1D177339
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 09:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0091F22425B;
	Thu, 12 Jun 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WvOHKL9v"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601181E51EB;
	Thu, 12 Jun 2025 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719162; cv=fail; b=PkPCU92Gwzr+kcSsfdqZZN+uLSM4cCAK1qB3uXqhd53Ve69TMoKTNSjS56jqI8bEvPdT7V9wh7KO52pzuNy1j/O/yfUaYSwuR4IZPL/OxUUqY2hbvsMvRWYziApFMZxcD7kKR/J4JwNfXPc1AtLJECr14XhGpJoIfgR+VH7B9UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719162; c=relaxed/simple;
	bh=OZ4Z6RfpBzR7HhgnE8rt30BED7vHNY2sJN4+KBI2Rb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oYETUY1YWbgEYe9c1vbYnjo6wxZUQ37xdzPM8P/q3E6578raRslw7BPm4MaqatLVO1y4CVJp/cxYeSoL9Yf9PQUvowht+d3vI7bBf5rgmUjt1avw3iW8/JHDqNSyOWbdgMaivOj+jAuHHbi3ky6/TcfbDBqxP9p99lWYIbKj78U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WvOHKL9v; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kwd9uCIm0S+k3IRIfLjLZzD+xYgz+Dlg8moBlwNpqTLF3LUvVVl4MoA6ThP7pZJyHH/fBtnXUcgkT2zFNw5MPptAyGTAlekVLELuqTna4L9L+oC+s0DKutXdbRIxeXuN5iGceuTYed2jfdEC6unrq3g/xPW8znEnWLKDVW2z+e2zglsCM9g3ChToaqgbohw7DzQ+GDB59ilSZiT6V7Ld2sge7IneVXSuU5To39r2arPDP25u7HZfBkr/Nls/sEVZWMXX5FLljxxFcvRuhGkCYHZ5V2JmU0vxwQLJG5phBAzkcmJ91H/5Y+0RYxMCixQcyWwyvjn5MB5znId8Ss3dqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ4Z6RfpBzR7HhgnE8rt30BED7vHNY2sJN4+KBI2Rb4=;
 b=m1bWSHQa0Oeaoc2CWrUKRpOBOJHju+T9VNtyFoFzjGY0Cb8yUPtCHdUguc/whqS6GzWjpeRlXzJ6IDPotGUI4B1UXjPMCHw3H/dGH4XaRZeu7aoYgUPW0vnMQmbvF0mf5+CRJWUxX/KL172L5raMaPeqkWzZp04YZXT5ZS4yMPNOh4KuKAL9yixRu5jmM2ICuH5TC1QvMRNcSitYmDPOHU0Yev4e6/hlju8+9lxVRxhH/4P1A7GfvdtwWgZcPsrE8R2R7qQjrcRFvxaXCU7NJdgAL0hygiFzxMP75RzFfFtyA1b6ojneveTDYwvbOD5AGUeS/cO290DHsTOYpsy6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ4Z6RfpBzR7HhgnE8rt30BED7vHNY2sJN4+KBI2Rb4=;
 b=WvOHKL9vsi2vxTwL1fylZSji+xgCUPdKmB7JZdEeWMhFLNG943+6GTX7rTljaHR903wZUKRBIbkbZKQTxTmarmcM97z6Uo1pcnd17pr3kOGZaLFM8tSrVtu23WlvJOz6WBVG5tsELxV9UiYXEYupsmrM68jd9Hk2jeOIwRHLQk6rbJX2S0jfe8U/JD8gQ5E9Pzh5OZbFSwMkwnIoDCpZ0RORdYcpLLvn2VieSKmUk6Wgah3zQAIzodAP50NFOoNTvIfIwuJwLpy0CiUFp55DTBKtz0LZBWJIlVqr8m6IOdnRp//z5G3dxjLqBE/8t0QIk6NC2Qyzy9BDWo/IJPhBRg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DS0PR12MB8456.namprd12.prod.outlook.com
 (2603:10b6:8:161::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 12 Jun
 2025 09:05:57 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8655.033; Thu, 12 Jun 2025
 09:05:56 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>, "almasrymina@google.com"
	<almasrymina@google.com>
CC: Dragos Tatulea <dtatulea@nvidia.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "hawk@kernel.org" <hawk@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Leon Romanovsky
	<leonro@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, Tariq Toukan
	<tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 10/12] net/mlx5e: Implement queue mgmt ops and
 single channel swap
Thread-Topic: [PATCH net-next v3 10/12] net/mlx5e: Implement queue mgmt ops
 and single channel swap
Thread-Index: AQHb2U8yAo9E9V63ckyHHsmX6n0NXLP/BH2AgAA7SQA=
Date: Thu, 12 Jun 2025 09:05:56 +0000
Message-ID: <9107e96e488a741c79e0f5de33dd73261056c033.camel@nvidia.com>
References: <20250609145833.990793-1-mbloch@nvidia.com>
	 <20250609145833.990793-11-mbloch@nvidia.com>
	 <CAHS8izOX8t-Xu+mseiRBvLDYmk6G+iH=tX6t4SWY2TKBau7r-Q@mail.gmail.com>
In-Reply-To:
 <CAHS8izOX8t-Xu+mseiRBvLDYmk6G+iH=tX6t4SWY2TKBau7r-Q@mail.gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DS0PR12MB8456:EE_
x-ms-office365-filtering-correlation-id: 0b7b6616-600a-490c-021b-08dda99057ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVJ3RTJnSVJuTFB2andKc1hEaEUwY3gwSWlTQWFGbHRTc1JST0VubHRNakhH?=
 =?utf-8?B?OU5mUEwxUisrNGJtU0dBd1ByYVNtWmdrdVNEZ1dsOWhNQUF5VlMyOVJnZGRB?=
 =?utf-8?B?SHJrRndzMjlWekhtb2lmYW9UdEJGNUE2UzR3UHBhOVpEd0haMWFxN0toNFZ5?=
 =?utf-8?B?SlI1bnlRSzE3V0pIRmFtZzJIMlRHTEdPeUxHNDcwajVOMXdJR2ZVUzhpUjBo?=
 =?utf-8?B?aGFxMjZFWmV5M2FEMXlpaEVnUC9TL0JIRzBwTEx2aGU2bzhUb2xlSFVYeVF4?=
 =?utf-8?B?Y0lVZlRxUVJlUWpIbkptNHhzZWM3d0ZRUWx4cHIweTRJc24xYzJsSGRRVnkz?=
 =?utf-8?B?cXVHcWIrcGs2STRSeFRVNmhwUjZoZXFoRjl6YVdlU1pkMFNoNldqa0dDVm1m?=
 =?utf-8?B?YW9nZnJnQXlzd05hMklsL0JhTm9YemoxWTNSRWJ3N1pZQjRUVjl3bFRPd1Ba?=
 =?utf-8?B?RFZ6enZQYmVyeENEWnNqMHB5ellNM05nTXNHYmd1UVhYanVBa3RWTEhZYXZo?=
 =?utf-8?B?SzBxTDJOcWJuRTZjclU0V0h2OUlyd1NDS3hTSzR5L2pPRWkxOVpOTm4yZjcv?=
 =?utf-8?B?UTBZakJuVzBUNC9VMUV0K0NLeUx4Z2piQXdXOS9vc2J1bFg1TndJN3grNU9j?=
 =?utf-8?B?U0dScVFWMzlWSmRkM0dFRDdtcWVYbnRNVnFhb1JaNklNMThqU0RPUmxXV2Nu?=
 =?utf-8?B?ZHNuaDE2d1lLYUc3NkE3RE9FZ3dSanM4dHNiOXZDNVZZZzBkZFF2ZEFvbHUv?=
 =?utf-8?B?V1ZUdHZvLzN0WE1nYUpmVmI2OTNmK3hJQ1JWd002Z0dZTWxuVkd5QXdMam9Q?=
 =?utf-8?B?aXJ3ZVhmaUdvWWg2bnl1S0h0eGc2TWdpK04wS0E1R0hyandwOW1Pd2RUa1Vz?=
 =?utf-8?B?SzlkVjltZFgzYXJ0WWtYa1p3MURaS3lldS9nMGl4K0MwdkJwWUVuaFB3YzMw?=
 =?utf-8?B?dDNjQ0N6YWJwcGR3c1RTd085b1I4WDdsaVMyaG9wT3BUSCsvM2lDc1Jhc2xO?=
 =?utf-8?B?OGV5ZVgrNmJMb2tjUy9oSkIwcHB2dEFYdS9KbWFqYk1JVFhMZVlJR3ZSYnJi?=
 =?utf-8?B?bGw0UnpCNm1ZSVFBRG5FY01TN0UzT1MrOHMyYUtBSGFDNFBqVkZsQlJKTGFl?=
 =?utf-8?B?OXFkNm4wanZxRGl2OXBkRG1tcE56dUllU3BWVlFxL2Q2aklIV2Rsem93R2cy?=
 =?utf-8?B?aS9SUkNORjVDUUIrcGNEWlpZTHFVUVhleDNjZ0M2UXlpSlYvaHhHOUNaK1hP?=
 =?utf-8?B?Sk96bGJYeVk3NE5tekx1ZDZNUjNVVC94NkpGeTJLeW5HUFY0ajdIWlJ3SEdL?=
 =?utf-8?B?dDJJOU85cnV2KzBqdUpWL3F6KzVlK3hYUmltUUdYZXprSS80cnNDMlpBZTM0?=
 =?utf-8?B?aktMV251VG1hQ0dVQnF6ais5UHpNeG40NmtwdVZqUVM0YUNFY0p4STIxNHZ2?=
 =?utf-8?B?YUZRRkRmL2NQdVVwRWptR0MzN25VMTY0aktDVDFrWERQNkljZk5oUU9MNHBr?=
 =?utf-8?B?Mzd4Y0g1dXBmdmx3ZS9teS9wajZSd3JjQ0V1QnkzSVUwZndSQTFnMmg5OUhz?=
 =?utf-8?B?ZmhUdGRGcDgwcVNiQVpOVzdmSEV5QmRsUHh1MUlDMG5hMG5PandnVlRFQ0g0?=
 =?utf-8?B?ck5BSm1rMWZveVBZdlRaTnp4SStzSk1uQmVQb1dLTE1XelpPSnBlTDB2Q0U1?=
 =?utf-8?B?RnowbVNKT3Q3dHplK3NuYTdQZjk5bldMcnF6OGppVVJSTXNJVW5UMkdEVlUv?=
 =?utf-8?B?SlhCZ1dkS0pQZTQ2Uk5aeDZ6dWxSUDE4d0FBdmRYRm94ZGVBMU9waW9SMTdx?=
 =?utf-8?B?SWZaY2lIRU5hYWtNK0hlYmVWRzg0QkRwTDNwVXhObnVoMTZYUWc2RTMxaTVy?=
 =?utf-8?B?NTFKNlZobGtrZnVjOGt1SGRyOURrejhBQkEyZGYrRDRTMVAxdjZKOE45ZGVu?=
 =?utf-8?B?dE1mOUx6MG1GZ3VONnB2QXM2djl6eFc4VXRUWEtyWUtOd21QRE52ekpzR1JB?=
 =?utf-8?B?NDBuekVSa2V3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDJmRVlOZ29jUmdRL0tJamVwOEVXZjlTYW53bjdBUUNqQ2tYM0ExdnlVblJO?=
 =?utf-8?B?UUUzTExGMXROaXRDZ29QVTZXM2pWWGNRT3dZejhHMlBPeFBYL3RnK0tMMUZH?=
 =?utf-8?B?b056TkNwdHRFcmZMeGUzdWtwamxNLzJCWUQxZlE3SVQyejJ6SWg5M1JhUlNw?=
 =?utf-8?B?UGpDbSs1V29NZU5ZbXZWTzU3UTNYVG9jMStnTDFyM3RCUkZsTVRwUU80b0Yv?=
 =?utf-8?B?akQyYjJSbm9vN3RHYTNWV1oyMEVSeUtvNjlXejc1QUZ6SnZMNDNTU0xQN1Mr?=
 =?utf-8?B?YUt5RmNLNHhQaVd3MEg1UldlK2tCUGtvek8rU1grQVJhZjZma05zaVRYUTBq?=
 =?utf-8?B?QUdIclF5aTlXR3Z2d3ZWYzlGckVEaXBqOXdKZk41dlhYdm56QWtCcS9YRCsx?=
 =?utf-8?B?RjAxNk4zem9pSmhKRldFWm4wbENxTXdzRFYzbmhKSHRmR041cW82dHF5S2Vp?=
 =?utf-8?B?RWpQOWp4OWszT0VtWkJhcUpHU0VCQk0rb0MrNDkyVUpqQWlNUm9Mc2JKVVg2?=
 =?utf-8?B?azJBWXFoQ1ZabHVJWVlJc25YcCtDOVVNT3AxWjlUNFg2aW84THhqOVprRHFr?=
 =?utf-8?B?RXptQ1dtVVdjZS9MKy9GSEtuOXdGaDE1SFh6NXc4WWx2R01jV2IrVVlWN1o0?=
 =?utf-8?B?elFCYUZSRWdyeWdML3lWMCt4TlUrREJTQldjRkZyNW0zMTQ4UDRFUHkzOFl4?=
 =?utf-8?B?M2lycUFjQXZwUFg0SE1GUzd1azdRUER6ZnEzRHZuY2pHRElOWmFmT0QxMzd2?=
 =?utf-8?B?TE9kSzVSSk1wcVFNUlNscHJ4YnV5aWkzUkRhU1hhTUdPUnFtRmRMN2s5Z2J3?=
 =?utf-8?B?MnBIZEh2dkRFcFVJYWdvYmdqRmluK3JWaFNhK3JzemNvcDFXeFdFeFNSRkoz?=
 =?utf-8?B?M2h6L3RGMFhtY2I3QXhoUVh2VFBENTN2UGF2ckROeWhOeDhBODUydEt6K050?=
 =?utf-8?B?NTdkSlZrbW5MZFc3UURJeVVOSEJmcXVEVXpVTG1KcXJSOU5WdHN5SkxPSyt5?=
 =?utf-8?B?L1czYjJBVHd2b1BxK0lxc1ByRHZhMmZHNmRoRTRoUWZBTFh2R2s2ajNmTFJW?=
 =?utf-8?B?V2JTL2paQS9iQnRBQlAvNFJOY0pXa3VXc3NnUjE4NkNxbTlDNnYrOFRiV3la?=
 =?utf-8?B?b2I3K3FLbWx6aGRXSUFwYlJGbTlVL0tuTHU1THdkOEtaa0ZGcTlRMld4WGhC?=
 =?utf-8?B?YXJ6WjZZQkVLT2YxTUZFalU1aTQ4UjNITVFNZ1hMY2hyelpRdTJLYVlWZE9S?=
 =?utf-8?B?UXNvSmJSelpicFppdXBQY0xJeGZ3OXFXN2tQclMxSGdVZ0NYdWtpaVZQaDZm?=
 =?utf-8?B?c0FZdzBiS2QvZ3lKNWZES2F2cGd5SnlxR1pkVWpqYmFhUXVxcmpPTzFpaXc5?=
 =?utf-8?B?eWdoRVJZSUY5V0FjQ0lFTjFQajRJVWRTMjNVUVBJQVkxV2UxT3RRV3VJUmVC?=
 =?utf-8?B?WHZJSTQ1SnprSmhKTTIrMDYzZnhpa1pGb2ZqejhsVmJDOUJUTXFLSjlmNWFm?=
 =?utf-8?B?Qjh3b2F6R3lkK2szV202SDdOdFBCaHd0ZXhXeUpGT2g3cFZOWTVuRzBaMmdq?=
 =?utf-8?B?M3ovT1hPTE1nT2FKblh0TTZWWFc4a1RLZFRJeGlXbmNaODVsL0ZVYUVlempE?=
 =?utf-8?B?NzY0d3pqK1RqS2p4UlVHNVFJbTc5aUR1ZDFpQ09sc2FiMmh0MEhaQzR0VGlr?=
 =?utf-8?B?VWJ6L2diUXhBWWZ1eEsyWGZ4WXlGNnNLc0J3UGY1WTcyemQ4UXNETG5VY2lH?=
 =?utf-8?B?WGRNc2hVQWl3TlZDTS9qSktlek5wM29ad05ZaWZRV0tQWDUwUWh5YzlaOHZP?=
 =?utf-8?B?NFRybHptWW10UWNXNEl0TnJna3o0OS9UaXNUcHlSQ3BxRFZqbHF5TFFqQTF2?=
 =?utf-8?B?QWR2UmxoYVhNeEpFelp4WnlvUlJ6Rk5mdVZybTR1TWlaKytOdEhFZXdaOCtB?=
 =?utf-8?B?OTlpSXlFTmNqRWNpOXFmMHhZaFdYMVhWMXRhQkRuZlVydFEybWJreGNVYWF5?=
 =?utf-8?B?emFCTStFRk5uWmdaVlhFaTQ5aEVoZWFaenFyTzczUS9nQnduY1h5bGtzNU1s?=
 =?utf-8?B?Wk1EUklHN3FFZzBOc2p1bDVXTUdhNUd6RXpZd0NSbVpxWkEwL0Z6ZnVNWldF?=
 =?utf-8?Q?9qnd6OsJKTsZFLU01ZUWe8Ndr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E770E2E0EEAA3647A370A69B17B86939@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7b6616-600a-490c-021b-08dda99057ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 09:05:56.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6MrCCr4sAI4sZVw8VXPZ+KX1QiDjUMqjSBJ0Z6HqSY8UUeIVhHIZTAkEEHHfFy35IwiNyDtssYwuzL3KT0JCmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456

T24gV2VkLCAyMDI1LTA2LTExIGF0IDIyOjMzIC0wNzAwLCBNaW5hIEFsbWFzcnkgd3JvdGU6DQo+
IElzIHRoaXMgcmVhbGx5IGJldHRlciB0aGFuIG1haW50YWluaW5nIHVuaWZvcm1pdHkgb2YgYmVo
YXZpb3IgYmV0d2Vlbg0KPiB0aGUgZHJpdmVycyB0aGF0IHN1cHBvcnQgdGhlIHF1ZXVlIG1nbXQg
YXBpIGFuZCBqdXN0IGRvaW5nIHRoZQ0KPiBtbHg1ZV9kZWFjdGl2YXRlX3ByaXZfY2hhbm5lbHMg
YW5kIG1seDVlX2Nsb3NlX2NoYW5uZWwgaW4gdGhlIHN0b3ANCj4gbGlrZSBjb3JlIHNvcnRhIGV4
cGVjdHM/DQo+IA0KPiBXZSBjdXJyZW50bHkgdXNlIHRoZSBuZG9zIHRvIHJlc3RhcnQgYSBxdWV1
ZSwgYnV0IEknbSBpbWFnaW5pbmcgaW4NCj4gdGhlDQo+IGZ1dHVyZSB3ZSBjYW4gZXhwYW5kIGl0
IHRvIGNyZWF0ZSBxdWV1ZXMgb24gYmVoYWxmIG9mIHRoZSBxdWV1ZXMuIFRoZQ0KPiBzdG9wIHF1
ZXVlIEFQSSBtYXkgYmUgcmV1c2VkIGluIG90aGVyIGNvbnRleHRzLCBsaWtlIG1heWJlIHRvIGtp
bGwgYQ0KPiBkeW5hbWljYWxseSBjcmVhdGVkIGRldm1lbSBxdWV1ZSBvciBzb21ldGhpbmcsIGFu
ZCB0aGlzIHNwZWNpZmljDQo+IGRyaXZlciBtYXkgc3RvcCB3b3JraW5nIGJlY2F1c2Ugc3RvcCBh
Y3R1YWxseSBkb2Vzbid0IGRvIGFueXRoaW5nPw0KPiANCg0KVGhlIC5uZG9fcXVldWVfc3RvcCBv
cGVyYXRpb24gZG9lc24ndCBtYWtlIHNlbnNlIGJ5IGl0c2VsZiBmb3IgbWx4NSwNCmJlY2F1c2Ug
dGhlIGN1cnJlbnQgbWx4NSBhcmNoaXRlY3R1cmUgaXMgdG8gYXRvbWljYWxseSBzd2FwIGluIGFs
bCBvZg0KdGhlIGNoYW5uZWxzLg0KVGhlIHNjZW5hcmlvIHlvdSBhcmUgZGVzY3JpYmluZywgd2l0
aCBhIGh5cG90aGV0aWNhbCBuZG9fcXVldWVfc3RvcCBmb3INCmR5bmFtaWNhbGx5IGNyZWF0ZWQg
ZGV2bWVtIHF1ZXVlcyB3b3VsZCBsZWF2ZSBhbGwgb2YgdGhlIHF1ZXVlcyBzdG9wcGVkDQphbmQg
dGhlIG9sZCBjaGFubmVsIGRlYWxsb2NhdGVkIGluIHRoZSBjaGFubmVsIGFycmF5LiBXb3JzZSBw
cm9ibGVtcw0Kd291bGQgaGFwcGVuIGluIHRoYXQgc3RhdGUgdGhhbiB3aXRoIHRvZGF5J3MgYXBw
cm9hY2gsIHdoaWNoIGxlYXZlcyB0aGUNCmRyaXZlciBpbiBmdW5jdGlvbmFsIHN0YXRlLg0KDQpQ
ZXJoYXBzIFNhZWVkIGNhbiBhZGQgbW9yZSBkZXRhaWxzIHRvIHRoaXM/DQoNCkNvc21pbi4NCg==

