Return-Path: <bpf+bounces-55396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E70A7DCF0
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 13:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C237C188F4D5
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 11:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B442459D0;
	Mon,  7 Apr 2025 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mMNq8yIi"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26D23E227;
	Mon,  7 Apr 2025 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026814; cv=fail; b=VxqYMglGYr5skV1wZHrhd7Egk9BXJnSdbozDxGzKc9ZLAziIAYoCiimKjoZywD81u1S7+2I89quk8U/3xb0EK4HITTsWyrK7H9P22U+Ira5UOoMuyNWtnHAlq523+hAC3cVPEnu70KFV/dMhtIKZBQpetFfz0ZAey3FjrkQeDi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026814; c=relaxed/simple;
	bh=atlH64FAs5Qsvd7FjiUCTtaMEPnAPgSfOoe/gNwvvx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LEtChN83hAxJDHpPb6eLrfI4qRndK72zJ9VI64jG4m4nuJ1100vQdHR2ZwwOyM3oLtLYYxEKL7NdVhmy8ewShMYaZxq6hUHaSvj/huLFnXXrwz/izSMeEp9fgo4qRKBjYQYEfcayhlFYqV/OJOQ06SRgvS10nsTO1D7urtaZn+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mMNq8yIi; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2XFHsVI3rtJc66nhqF/yV9OUhKdQTwa1AZcKqez17mAVrmQ5Tp8nI1ipBzY098KP9jg4uyNknVhj3bNjMfT2YU8eNOsbmHfpGnIIrD5i117hGNof8geJTJCuKiwUXFGG6AH8zPvjWj8Rx+UO+dPPNSd85CD+I79lbs3r+naprTO8RY/5ux8c+eJ00+q4lQJjv9DQRDzNZR1IckejIlpV7d3kFKGgVBXAxB7/O9wc85jwIL1a2N6nWJBTGlT8SGNJCcZ0SIMopQ8xD3bwlZgBQzi75Afjc04kbVCXaEnnoWHFgbOJLNvRefSgxCGxm2iegyPfuSnS34KRkLVyssYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7GK4nz2svT5e+rPG6WR7WnHxpeAkDdIw2+m5JIlyIg=;
 b=F9frfJkKt0KjroitJTe6IFGW6VIR1RYs5CRGLblpdZI2RK4TdvXbrOBL9s6dJ+tIoONvd3rdXw1nQ1h21TAqGDzK7L+xnSOx3Wgc+2ySsdydIahKPjFHqnoFZBUvKaaH6Ol5tXaPsRKU0zPVSi6W1p0IVOKFTm2UCpAtMaNIy40uFLxUxmmI3EtSo+sykWZ8gyUoHkyLdwMAga2wI1AbOuuRfLy8CjeqXG2nUGcJA+V5gl+1kvn9C5NN2Zi2YqKpozJcbbo5aDVLoZHouVyTYXakJ4FyXcU3cbDMeS6OMZf9pKjRswmCUx8+HALAueHmYoXIW6Nw/Ue6R9NgwKbkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7GK4nz2svT5e+rPG6WR7WnHxpeAkDdIw2+m5JIlyIg=;
 b=mMNq8yIibN83Mkot8WpeJ9D3wVdKQ/eztB9tAhPdhPpgovkDKK9bWxhxviWdTrzYtaMVoG68kbpXQnVnl6E/PbM+scW/V55+TcyizMQjdxFNlnhpbjwgqNfVVZl+hK68TwaGsY1ogIPeqxBVPSHA0VA5PyYrfphuBtpYKhrfrHgLiunLCxMWwNJ68QUuhffz7EW7Sz47QRqA5HoQ4plCzfckMwQFVxIE9J38+NnVuEZgbfN37DqCy3wDGy5/dL4Pq08bw1Vk/ccduP1I0hPwqzok0V06OIj4z0GgjG9rZIjeyvSneEKXA1gifVWoSCiSokyB7FxOxFmm1nDjbvKghg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.31; Mon, 7 Apr 2025 11:53:29 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8583.041; Mon, 7 Apr 2025
 11:53:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into
 helper functions
Date: Mon, 07 Apr 2025 07:53:24 -0400
X-Mailer: MailMate (2.0r6238)
Message-ID: <F607616F-ECAB-4F4C-9F3C-4F6BE0655C7F@nvidia.com>
In-Reply-To: <87cydoxsgs.fsf@toke.dk>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
 <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com> <87cydoxsgs.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR01CA0022.prod.exchangelabs.com (2603:10b6:208:10c::35)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: f928bac0-c839-42fa-97f9-08dd75cad017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXd4ekpIb3Y0U0NKblhra0gzcjJOZFZuTFlRaGs5OUlIODkrWWZybXNSa1Uy?=
 =?utf-8?B?cWQ4QWtKdG9qNEI5ODhRRTh6dXRzMFY3TUZwbVdOTmZGQ0h1T0paNEFHTmpN?=
 =?utf-8?B?Y3dKSkE1djZRSlJ0UTlOUzlveERodzNES1JvdUZYUkYycSthUDJTeEVLeHZz?=
 =?utf-8?B?dE1rd2NYNm1xTHkxNiswWVVEc0kvTEVMbGs3UFZBakZkNHcvQmdTREQzNnVx?=
 =?utf-8?B?endNdjVpTWIzWjNGTDBZZDQ4MzZRSm5NVDB0VGV0dEtSQUgvTGNHZVBhUXUr?=
 =?utf-8?B?VFJxakttelNqaWJNWUhjenpvZU5WcWFLY3g3WmlXZExXWGNkUmgxRHJla3R3?=
 =?utf-8?B?MkNvbENBOVVWSnlzQlpKSTZxSCtLRGt5bksrc1F5NENaSkNKT3VVUkJsK0Zp?=
 =?utf-8?B?blRxa2YzSWFjeDVoaHdxR3FOVENTazJ3SmlNVGU1Y3hQRlhhcUJUa0ZGdllo?=
 =?utf-8?B?L3FtZDhGSzRxenpJUXl2U2NLOUtwR3krbzRpS2JjMGNhNUFCcWV6eGZWVEFK?=
 =?utf-8?B?V2d5NTNzZ2dXNWE3SkdjRENIaGtYVS8wYnNndkQyQXV4TWxPMUhqRk9YZnEy?=
 =?utf-8?B?dUhETUx3MUpqVUZ6bVRVQ1ZycGlSVWtmMUJTMEtqQkIxT0VhRDNIcE1ORTBZ?=
 =?utf-8?B?V3RBd1p5YlJCdmgwdTVFajNrRXczSXpkNDZsenJ1d29BMW9SdURDS2hQZUM2?=
 =?utf-8?B?b1A4WlhmV1RJQi9scm0yeWlsRUlZWmtLdkRNT0srTnJMNnRCTEViWVQ1dHFS?=
 =?utf-8?B?OE5mQUlLT3lrY3ZWSHFhUFRoSk5xcWcwbkZGUmJaQ2NsTndyMW54dGZERENO?=
 =?utf-8?B?VXhEZDRUVGV0b3R3MTZVWXRYck5kVDVGQkxGQWVYdVRCblRBZi9HV25UbG0w?=
 =?utf-8?B?MHpTbWpZQTZUTFdybUUvZkRwVUdCOHRPaHphVFdwMm9OUWgwOXdIY3luMVdo?=
 =?utf-8?B?RnlVZ2ROaUdoMG5FUkpHK1NTbjBpNUxNQlpZUHByL3Z2eWpOaFVnR3dPRWxP?=
 =?utf-8?B?aUtFMnlZeVJBMnN4Q2xTQ2pJMWpQSmIvVTFyRCtsZDIyTjhqMkpRVk9vK2lB?=
 =?utf-8?B?Z043RWtIR2F2SHF5Q1drWVNwNWgxNmhjQ1JPbncrclpPMDFaK1N0bWtUaEhE?=
 =?utf-8?B?TGZ4TmZYNVNrQlA1OTUwSEV1dHdoQ3NXT3JtZDNuVEpZdkxRVEN3cjFaeEJK?=
 =?utf-8?B?Um1pcERpSlN3YjlRYnM4YVFxckdWdWhoUWh0UG43NFdObVpyanVaZWNiaVdy?=
 =?utf-8?B?Tk1iaEtFOHVkSHRTY05QQUF5bTRzQ0F4Z0hUakZFMDBMbklmV3pQOFVMQVo2?=
 =?utf-8?B?dGZhbHl0b0VJQjkyUjNQek52NUtLeVRTNDdicFNsZUI4blpGYW9nejRBb2Vp?=
 =?utf-8?B?SnMvVThlRW5nRVJuZkVKQnB3dzhlZGJBN0dBMEdRTGtEYzlUNUUrWUUzc0pp?=
 =?utf-8?B?MjRZZkFBMW4rQ2RNZDJHT3JabG5UWFRmZjlLR2RySUZBcVdhT3IvTXByTDRp?=
 =?utf-8?B?NXRaMmpxaXNOZzFSdGlBa21IOHRWM3VSdUJReG4wbDVKK053b0VKWjh0QW9W?=
 =?utf-8?B?cE9OYjlXdytJQ3o0dm0zdTY1TEw5TTJpazZIOG16N3lsZ0RRTHIrU3FqRmp1?=
 =?utf-8?B?ekphRThmTUFMQ2ZUSU12NzAzQXdTelFCYmQ4OXdnUXNVQmhNMzBzdWVJVmxS?=
 =?utf-8?B?SzZjM0xBV0lwejcxN0ZNdVpqY0dFOVZ4RkFRNm1TdHc2UWRTOG94Z0poR1ZK?=
 =?utf-8?B?ZktGdHhFdWdkSzdscnNyMElhZ3VQaWJXSE13cng0WWFGN3cvZC9BZEFGS24x?=
 =?utf-8?B?MHFRWWNUQUNoUm5pcHlUcXhTODVpdEJyVWZ6WmVxY01NbituajE2eHlMV095?=
 =?utf-8?Q?tT4idL2Jb3Uc2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXZqNnpCTG1tRnhvYzBlMEhJWWVNd2JWSDUreWgvTkJjS3VRNFdublhiYzVy?=
 =?utf-8?B?YzZ4QWJSVm5nSmt6ejBHNklMeWQ5MHVZc2dQaWVxZHE2dmxKVEJObzZSaXdh?=
 =?utf-8?B?N0piRXpLVjV5YldaZlJhTUY0aGFxcEFrY0NkYUJDVUpzUVBrNTloZ2RnSk5l?=
 =?utf-8?B?Rk9nK3gyMXRUWkJTeHMwT2g4aXRPYVhQRTVYc3JCQXd3Tzh4UzlXQ2ZBY1F4?=
 =?utf-8?B?d2xoUUNVbEhxYnJYOGcvNDd5R0xiQU9OYmpOb1F0ZGhuR3hFdFFLSlprYU5i?=
 =?utf-8?B?NHBpTEpOcWFHYzlzbXQ5QmJhbVVoOXFnRllSTXFuQm04REdnQ0pnK0NyNEtm?=
 =?utf-8?B?L2QvbDAvbjliL3piZmZDdktZR1NHYjBtYWgvUC9DOTJTVFFTd24vdWNvblk2?=
 =?utf-8?B?dXd2SnZtbzdBRXpSaGhFSEdQejNUcFpiblBkSEQyY0czWGF4ZEk0eXE1VGMy?=
 =?utf-8?B?TEREaWZWcFVyU0NLQXlhZ2loN0JHTXRrOEZ4R0NVQTVPa1NlWm9IN1Rsa2cr?=
 =?utf-8?B?cmg4UlV5bENwZXpWT2FTdTlpeTd1alJNMzRtOG1RMHFvblRDd1JUUWNVWmE2?=
 =?utf-8?B?TE1hTEhqQjNXRU82dnNTanNwZXRORkpSUVdWWE9GSE15TitFeEZUeW5yL1Bw?=
 =?utf-8?B?eEVQd1B5NnkxUXlHL0ZoOWw2aDNBT3dDWGRLWHloUWRzWS9tTWZzSUFScGRI?=
 =?utf-8?B?TmVlWUd2bGVOR2tOZmRLcWZXampVU1dtNldDU3NXQmpaeTJzSEJxWVhGZVRr?=
 =?utf-8?B?Vi9OV2hzYytZemNEeS9Qc2FHUFlmUFJicERpV1k3MEFGZkczeTVtVlBDTHhM?=
 =?utf-8?B?ckdnNjBQbkEzSVVkNC8rMlZ1K3BxQ3dtTVZHWWtGK2xEY2M0aXltSCtaYUdZ?=
 =?utf-8?B?SVhRQWdqQ2xudmJKcHlFV2E5RnJIZXNqMFlZNDJUYy9ENTUwR09vaVZUY0Zl?=
 =?utf-8?B?cjFCWjZnMWJTdEtiOGxHc09qTXRlaTZ4eWs1dkVNd1RCOUd6TmVUelhKQU0x?=
 =?utf-8?B?OW5wZDN0cDZ5OU9wa2dDYktmRjE2NG1mek9MN1RyVkxiZnROSGZGaU1Yd21s?=
 =?utf-8?B?eGFqV25IYkhRQVlIOHc4ZzQzK1MwcHZGbEdnWlB6STJRMnJxZUVJbHFLWW1V?=
 =?utf-8?B?NUsrZW0xNnQ0bEd3MlhiV3VSQk52OWRQUUxTaVRXRE01RTZ1czZQVnhUTVpB?=
 =?utf-8?B?azdLVlVLUUZLN2lCZUIzcHhqUW1ybHg4WVFWR3JMUmxaMXNDcUxUU3Zid1NK?=
 =?utf-8?B?VFhLeURlbFhJKzRmbWRGdWdpYlNXRGRJcjZIK0NlTU5hdnJyaWNuWmR5SXFx?=
 =?utf-8?B?WU9UT0Uzak50RjZvTlV1WENHZ05JWUZJM0h4WTZyM3krYnJONEhhVTJPNXd6?=
 =?utf-8?B?SVhxaCtqWkZQUjluWHkveDQrR2VxWHRITEsrbWN4cTl3RWZmdWkwSis2bXFI?=
 =?utf-8?B?MUIvR2ZXakFML2NCTk5SQWtBb0F3dDAwVVkxbmJXS1RzZjd4V3dqdnJMODFy?=
 =?utf-8?B?WlN0ZE5TU2x3ZkRwOUlKS1N6YUNrbFdoUGxkcUxMQXlNb1V5UVY4eERDWC9R?=
 =?utf-8?B?aHNRRVlQY0N0dENTcFlrektpemNhUlZOWUxGWW5sUGdiZkZhMERRRVd3Q0Fh?=
 =?utf-8?B?SGY2b3Nmeng4L0lmTFc1OFp0Q3B0bnlseG9LWGNjVWsxUjdIc0RUYklGa1BP?=
 =?utf-8?B?b0FXWWVMTEpJUllUYkwwRXlIb3ZjaUVYbFRPNXE0WU9URkVCSjlEZVIvN2t6?=
 =?utf-8?B?ajlzV05hWXhpQ2xxZXFTV05lVVpYbXlXZHZVbkJmTXpsQ3lJamcyK3NmRWhF?=
 =?utf-8?B?ODlBT2RCRTNWdkVESjR5cVJpeVpvQnlDVk9ycjJSVllUWFFEMURNTCtjZWp3?=
 =?utf-8?B?Q1hZNEpUTWJtb2xSazZFeitoV2hZWWhrTDhmQTM1d2lYMTAxT2h6WXJtYlgr?=
 =?utf-8?B?WkduWjVQZ2QxV3o1a25tdDY1ZEwvNGhIeDlSNVdxRmwrSTloLzZlNjFsMDRP?=
 =?utf-8?B?QUpSbHAwa2cwRWRpSHVub1RnQ3ZObEhTSUMra3V1NXJNWHYxYTdPMGJWN1lW?=
 =?utf-8?B?STR1b3gzZTFhMDBkU1p2cER0T0lFMFpsZTlvZkptbHNFR0Z5NlVsajBxOTR6?=
 =?utf-8?Q?E16gH26x6GAOuF0F7GlcY0AQV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f928bac0-c839-42fa-97f9-08dd75cad017
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 11:53:29.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHGm6LzMHTi39p0s76ioo6GAMgDKI+Br0/hESPEvRtVPboHX88WC11mLIxZkBA/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011



--
Best Regards,
Yan, Zi

On 7 Apr 2025, at 4:53, Toke H=C3=B8iland-J=C3=B8rgensen wrote:

> "Zi Yan" <ziy@nvidia.com> writes:
>
>> On Fri Apr 4, 2025 at 6:18 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>>> Since we are about to stash some more information into the pp_magic
>>> field, let's move the magic signature checks into a pair of helper
>>> functions so it can be changed in one place.
>>>
>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>> ---
>>>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>>  include/net/page_pool/types.h                    | 18 ++++++++++++++++=
++
>>>  mm/page_alloc.c                                  |  9 +++------
>>>  net/core/netmem_priv.h                           |  5 +++++
>>>  net/core/skbuff.c                                | 16 ++--------------
>>>  net/core/xdp.c                                   |  4 ++--
>>>  6 files changed, 32 insertions(+), 24 deletions(-)
>>>
>>
>> <snip>
>>
>>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/type=
s.h
>>> index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224feb2=
6173135ff37951ef8 100644
>>> --- a/include/net/page_pool/types.h
>>> +++ b/include/net/page_pool/types.h
>>> @@ -54,6 +54,14 @@ struct pp_alloc_cache {
>>>  	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>>>  };
>>>
>>> +/* Mask used for checking in page_pool_page_is_pp() below. page->pp_ma=
gic is
>>> + * OR'ed with PP_SIGNATURE after the allocation in order to preserve b=
it 0 for
>>> + * the head page of compound page and bit 1 for pfmemalloc page.
>>> + * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid =
recycling
>>> + * the pfmemalloc page.
>>> + */
>>> +#define PP_MAGIC_MASK ~0x3UL
>>> +
>>>  /**
>>>   * struct page_pool_params - page pool parameters
>>>   * @fast:	params accessed frequently on hotpath
>>> @@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
>>>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(=
void *),
>>>  			   const struct xdp_mem_info *mem);
>>>  void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
>>> +
>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>> +{
>>> +	return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>>> +}
>>>  #else
>>>  static inline void page_pool_destroy(struct page_pool *pool)
>>>  {
>>> @@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct pa=
ge_pool *pool,
>>>  static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 cou=
nt)
>>>  {
>>>  }
>>> +
>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>> +{
>>> +	return false;
>>> +}
>>>  #endif
>>>
>>>  void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref n=
etmem,
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9ced85e0=
d198947be7c503526 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -55,6 +55,7 @@
>>>  #include <linux/delayacct.h>
>>>  #include <linux/cacheinfo.h>
>>>  #include <linux/pgalloc_tag.h>
>>> +#include <net/page_pool/types.h>
>>>  #include <asm/div64.h>
>>>  #include "internal.h"
>>>  #include "shuffle.h"
>>> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struct page =
*page,
>>>  #ifdef CONFIG_MEMCG
>>>  			page->memcg_data |
>>>  #endif
>>> -#ifdef CONFIG_PAGE_POOL
>>> -			((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
>>> -#endif
>>> +			page_pool_page_is_pp(page) |
>>>  			(page->flags & check_flags)))
>>>  		return false;
>>>
>>> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct page *pa=
ge, unsigned long flags)
>>>  	if (unlikely(page->memcg_data))
>>>  		bad_reason =3D "page still charged to cgroup";
>>>  #endif
>>> -#ifdef CONFIG_PAGE_POOL
>>> -	if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
>>> +	if (unlikely(page_pool_page_is_pp(page)))
>>>  		bad_reason =3D "page_pool leak";
>>> -#endif
>>>  	return bad_reason;
>>>  }
>>>
>>
>> I wonder if it is OK to make page allocation depend on page_pool from
>> net/page_pool.
>
> Why? It's not really a dependency, just a header include with a static
> inline function...

The function is checking, not even modifying, an core mm data structure,
struct page, which is also used by almost all subsystems. I do not get
why the function is in net subsystem.

>
>> Would linux/mm.h be a better place for page_pool_page_is_pp()?
>
> That would require moving all the definitions introduced in patch 2,
> which I don't think is appropriate.

Why? I do not see page_pool_page_is_pp() or PP_SIGNATURE is used anywhere
in patch 2.

