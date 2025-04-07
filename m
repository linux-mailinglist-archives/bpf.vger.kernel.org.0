Return-Path: <bpf+bounces-55415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30BFA7E5EC
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 18:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B7C1889AEB
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB321ADC86;
	Mon,  7 Apr 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EpbPh2OI"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF6205ADD;
	Mon,  7 Apr 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042016; cv=fail; b=X4HI0ybo7+wMJG7YSFJnxW+6niZsq+0Xnt3zMWPhZkbqyKT9g+40jmDf8sBliygB0pmpS8tcpfmIJBvRHfTS+5+rUvVEQq75yKHL6VYXQ2YRitDGPpu2BykwIbl1bpaJWvbiaoVN71U1IMAMIYPi+ZpTp61WDq6CWjfafI9C8Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042016; c=relaxed/simple;
	bh=JgGU5xWZx15w5ptwQK1qpBty7GFxBz42BlPcfaLPJh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFmtvQbq2ZB4wCrqIMNGh66gAMMaPJpH++2b9LpZqhP1n1MP9qTmxpKbDOVpE+O3ESb48V3AKoCALJdr5Umh0cT+2QSYzfe30WSrlAnpUSIAa+w3Sc29NDTLr/QCixGOz81R2C7nzDSN838SeFXH1935Iaw8TcX3qBA3AQw4ess=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EpbPh2OI; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1GOR+ID6l6j0xHSpDCX/TDNFT966LUaE9IOzn2DimEeaXMEizxCh2Mw7G9szmO7VE4RM9zBbKlOm5inBJQqMbSVxOe8jKOp4J9CCqIUR/PzvkBFolg/LX9N5pd20R8zTxsSy39/gvVgGd0+3SqnHjALA8IXdY9p8OAkSy0BLeCcIC3l2fl1AvNuQndcsh8NoQyfgTzUljpoa7OmeVk9uaK1RpLP2ebHTY6snfMrI4Rtp0wg/LWAK8euGyWhn782cDARdAk+S7CgxlZp7qhinnCr+lhq5CgOtI+6sfAuZP06kaTjPU/bBvzlGDjIYyJ0i7iROrzRaeZqoF1baDqS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJZBRrUQaj1/1hVsLF3rPV05KKS6vp0zkRmfTb0FHWg=;
 b=PlskpKpUiZ0Bo6RG6JNb1R6IAtWZMPpNkZ/srbOlKg/sl4N4EtJtZLnVYQO0X02UI2Jh3Pp7ECHBegbUW6VMYzzFMvafbm8scXEkX22w7ytaGK1C6I1CZqU18DAMzktx/2F7YlnVAMOMns1m50cWw4k55nw0tXTY3Bfyk4SIfvuYLiQUK2K1U42vz61ySKDHlihHYGK3jhZRXH/72YgDdYXHhjNUSUll4becUUiZEnN1qmZ5N9jSTdWeQVUm0FeCEgx+bbb/rc9VgZsPESltFsRN0YuFmiwQDVOBE105VuiramOCHcUO22eps0QwhnMB0RTpN1JdIPCkOPCV/JrSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJZBRrUQaj1/1hVsLF3rPV05KKS6vp0zkRmfTb0FHWg=;
 b=EpbPh2OIL4yZWHIRHRuq91Dkcy0RC+fyTX9uqGLpyfDNlVkdNOZDsKK8rTj0szZzJku0tRK5JkvWSj38CoB2y8CdUTKGAzKj9dNplnyHBT1Y3q4Z/WepZI8XOv7zj3FncOoseDrNCRohfBjclc2YFEEpoIkRvRc+uuBWv5PZoL4NmIJ8D9l4NU9g7YJo9pgtIywR8ZZ3lpHm0pw2/0BOyJTayvBFGzNn9qGntdEji3W821rsZbb2uHnz3m0Y7LPznpyvvSqpR5o8mW5U5RbOal4JiTVDy0m1teWxmx3aDGmlG5KkZhBbnVnoEaYuf8fszO6Fl9lbg8DFaQ4ahPbiKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.33; Mon, 7 Apr 2025 16:06:50 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8583.041; Mon, 7 Apr 2025
 16:06:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
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
Date: Mon, 07 Apr 2025 12:06:47 -0400
X-Mailer: MailMate (2.0r6241)
Message-ID: <66692A4A-5747-447A-A1E6-678EBB9A33E0@nvidia.com>
In-Reply-To: <87plhovtx8.fsf@toke.dk>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
 <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com> <87cydoxsgs.fsf@toke.dk>
 <DF12251B-E50F-4724-A2FA-FE5AAF3E63DF@nvidia.com> <87v7rgw1us.fsf@toke.dk>
 <E9D0B5C7-B387-46A9-82CC-8F29623BFF6C@nvidia.com>
 <893B4BFD-1FDA-46DE-82D5-9E5CBDD90068@nvidia.com>
 <4d35bda2-d032-49db-bb6e-b1d70f10d436@kernel.org>
 <4185FF99-160F-46A9-A5A4-4CA48CC086D1@nvidia.com> <87plhovtx8.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN8PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:408:c0::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: ce98ce8c-3c36-471d-8f45-08dd75ee34b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW1JTC9KUitjd3lIcy8vVFc2ZTRMSzFLZGdGem1wTHhOL0U5bC9xVHpaU3pr?=
 =?utf-8?B?VE1meGhrRkZURXNIMTZzQ3pwZ1g5ZVF2RmlvNkExckFXcTlWM0ZqTGlaL1Bl?=
 =?utf-8?B?WmpVbzVmNmZ2Um5KdnZVNEcyQVRSZVVsanZwVmdtWGNNWGJBYklRRDYwSmZ1?=
 =?utf-8?B?MGY1NkJXWFB3RVpHNUQ2clB5eDJnWHBNYWdwZ284L1pYRVI5SmhMcEwvRTF6?=
 =?utf-8?B?N0VZS2dFRkI5bGorT0RDWE1QVm10aWhORllZVmVWOTEvdHRJaW1BTTBrQUZy?=
 =?utf-8?B?cDh6UWF3MG55VTEzOGswMmJUbDRlRzE4NXRHZ1lId2IwczJRS0NFUmtXWU9H?=
 =?utf-8?B?ZjQwV2lYSVhoV1R0UWJuYW5ZTXIxQXFIVHZiNTJZQ1J2ZTcvYTBkb21NVXF5?=
 =?utf-8?B?QnJMTFRyMzZUWGZJQWZqQy84eXo1MXdNZ0d2SWxURExnVFZQZWRqeVRwVHZv?=
 =?utf-8?B?UTZhbHZtNVE2L0xLQ0pnSEN6bTNvdS9mbWx3SE9BVmV6WnBiTUFxbmRReFFn?=
 =?utf-8?B?b3I2K1dUa202bWRXdzJsdXlwd3dRUUczSkwzaXBnSTZEb0l4TGhLWE9LSzZs?=
 =?utf-8?B?UWlBL0hMeEVkSjJYdDNUa2syUmVNTHNBdVBJZGtCOW5nSHRIaWhsVnRvRDBm?=
 =?utf-8?B?R3N6dzJ1Z2R2a3kwZnVqdXBUblV6NU05T3p1ZFFWdGlqa3BhVXp4MVA1Tk13?=
 =?utf-8?B?VGVQZGFVZkNLYm1yWERoN2VkQ0dsb1c4MTU1cTA0Z293aEtJV3lUQ053a1Js?=
 =?utf-8?B?WVM2aTE3em1VQWVuQmlTeExiaDJHV09hVVZ2U0dob0xQaXA2UVFUQWdtdW9u?=
 =?utf-8?B?T3RPcklTRVJjZUZRUE5xUWtUWi9kUDluc0gzYmk5TFZJK082VlZXTTFDWUZM?=
 =?utf-8?B?Y3kvVUJLWmxHWkR0R2RlMzZac1l5ZTdtcXhtS1JSRWI1Y3NxZkVLVU1uN255?=
 =?utf-8?B?WXMveXlZM1A2Q0YwSmRxMW9pbWZMQkZGS212S3RIa3RDRjEwYW9FZ1lGdlJh?=
 =?utf-8?B?blRJaHBuM0VjdW1IQkdjNlVVSVJqL2lIVjlNd0xZRlptVjhzZkVMaDh6bTdy?=
 =?utf-8?B?ZlRXZ0h3YnI1cHlZY0V2VHJ5bGUrN2NRcmZRYkVEYzBDYms4OWxFeDQ5aExr?=
 =?utf-8?B?bG55UlZzbUwyUFc5QW9hM0NLYXhRMm5MVXo3WktDRjZiYXNoYlk4ZTg3bnNa?=
 =?utf-8?B?bGdOMWxIaVZYcXdVLytyU082blVybFBuVjlNalhGME9SMk1ad3VRbUdBeUtD?=
 =?utf-8?B?V0FhaEdZbU9MQ0lkUVBJR0w5aUJEWUtidGhQU0E0RkxOYmpqcFlTTlAxYndr?=
 =?utf-8?B?OFZzWURBTGJDUHZLZkx3MzJOd05Ob3lmcDY2SWUxNnFBbkVZV1hvZlluRG9j?=
 =?utf-8?B?L3lnMG8ydXVyN2VFanRqZEhRamtOTzRCdGFoMDRneTJYKzFvR2I1RkROdGla?=
 =?utf-8?B?aHU3S2c4QVRWa2RLNDY2dkZRaUtUQ0lSRzdUQ0NEK0ZCM04yMkwyS2NjOENV?=
 =?utf-8?B?MGJFV2pIcnJ5MDVrL2UwSXNReDJnbFFLM2V3MER1dWo3RCtlRzdPTEtUdkRK?=
 =?utf-8?B?dWNHcHUwS05lTExCOVZrQmQ0SGZNQ1NIT3A1YW95V1pETnV2V3JIaE84SFhB?=
 =?utf-8?B?N1N5S3pSaW1OR29KT05Ud00yeksrV0I3NWZid0dyYVdtWmhTdm5GTFA2V2pO?=
 =?utf-8?B?ZHBJelhLa2haK2JyQ0RtNXdkRDFHNSs3QUdTd2RIRjk4T2VveHArdU0vaVZr?=
 =?utf-8?B?N1ZkcnoyVTZqcmY1R3kxVGNvRldoSzQyWVNGbkxZZ0k3RkREMU4waVhWdE4r?=
 =?utf-8?B?OW9mQUZFdmdaUGRpV2JkMFJJa1JacTZYakRLUDRjSlhwaWpEdGQvK1I4UWJo?=
 =?utf-8?B?T2ZHdDVOWUVsblR2Nnc2TUlvblIxdUFCazJmSlE3L05uREdneXNmOFd0Q1lC?=
 =?utf-8?Q?w4UITc64Tdk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmdqZXhtdzhacnJrcC9zU2Y4WkhjcHZFak1qbGNiaDJMaERtWDVzbmRDeU9j?=
 =?utf-8?B?MVdVcVFJbEJZSngyY2JuL1ZYRHQ1aHV4UVl2TVJNYlRibzgrYzlPb1ltMTVQ?=
 =?utf-8?B?TVMxazJqM1V2Z1FLSUlwdkQ1c1dEU0ZzU1NTMXMxZFZ5c0dFMmplMDZhQW9N?=
 =?utf-8?B?aHhLTVEwbEFieFBtWmx4SGpzQzFnK1J2dWZNYWNkSHNYY2tWYk8xMWtxRGky?=
 =?utf-8?B?QWZFZEw5MUF2V0NpMUJpM09ld083a0lTa2FFM1BrZ2E5dXdJb2ZiOC9idXh3?=
 =?utf-8?B?TTJCQTRQVUplTmFRWEZIbWR1T1k3eXVnalNWakNGZ0huRndkdjNKZXRqcWlO?=
 =?utf-8?B?OXRQRml2ZlJSWVIySkZtT0ZvVHROT3d2Y2RZb2picm9LaXdDSWw0WUNEOUZ5?=
 =?utf-8?B?UFRNR3JKRFEwbzFKQUgvekpBMjU2V3cvMCtjMUxlOTlFREg2cnhkSy90OVV1?=
 =?utf-8?B?QkYvTnlaZitib2ZobjJDWHNUNW5iM083eFBrQXFHMmlCK2ZGOVg1ak1uM3Fy?=
 =?utf-8?B?Ti9tWmQzQy9LWFAya2NsR05NTGphcld0dlhhNlJSNkV6RHZjWlJOT2FPOEt5?=
 =?utf-8?B?VU9XSlZ5K2RiUjVmUng2czYzUzM4ZHBNZXRsdHp6a01mQWttM0s5RXBuK1dL?=
 =?utf-8?B?VTlTdnZwVm1RTTFhcmNsVHk2bzFoNXFhSFk1RGsvb3hOL1dNNzlKdjZRd0gy?=
 =?utf-8?B?azRLVE93WjByVjh1M3FEc1hyRnFSOWt1MDUxR21xcTluMkMrYkQwRHluRzFC?=
 =?utf-8?B?TW9LS2RVNjh6UVV2MzRFSWNUbTQ1eUF3bHkrTGpPbFI0SWl4YmtmcFNMeFU0?=
 =?utf-8?B?S0RsMmgzRld2R3gvR09OaUhjblZVcGQxZ05nR3VhNlFEQ0VobG9udUtrQllM?=
 =?utf-8?B?Y21ETEVOb1IwdEJnU0Npbi9IaDlmMTZ6UHNoK2pwSmxUZ3pvbkUvWFI3OXVI?=
 =?utf-8?B?NHdEaGtDcm5Ib1lUek5Ga3ZTcjZRVEhiT0hUYjhMOHJHeTZXYndvb1BrNEs4?=
 =?utf-8?B?Wi9KQmkweEdISWhJRFg4blVOczl3d3AreVo3N3hVc0t3QjN3L1FueFd3QzBY?=
 =?utf-8?B?WDBhZEpDdS9Mbm5idDlTL1VMMGl6U0QwTGEzUk00WmhSZmh0aEdjY2ZUR2lu?=
 =?utf-8?B?ampldmszZU9JelA4MlBYNVhzeEVVbGQ0SnQwRDF0UWRoUFk0VGhYdERNa0wv?=
 =?utf-8?B?M09LY1Ywb3ZLNk5YN1cxQ0szUWVjcWFsK1BMNVM4VVdJWC9RUW9qem9rUEVH?=
 =?utf-8?B?RnV1a0xJTGhsOXpQVm5Ubms1Ny9LY3Y1QXozZm5sNi84NS9QTXU2d0FheUZJ?=
 =?utf-8?B?UXdZVDVDaW5SeHRRVGlwZHdvakRwQzl6S3plU1lSRlkxK09iaC9IckxLUzlt?=
 =?utf-8?B?MlVuVXJIbmhMcGdqVWNQYktXdW9URFZ3cUlYMVA3TDBTWm1QWFlxTmFaNTB0?=
 =?utf-8?B?cm9iNTJOSkZwZElzUnJmaHJ6Vk1kcHJFd1Vid29mSU00SmJIcm5reTkxUFo4?=
 =?utf-8?B?cVgyT2pCMU9WRTRJRHY0UDlZelpYUlF3ZzZFM0djOUhEb2NvM2ZWUFU2N1cy?=
 =?utf-8?B?UTZBM2FnL3NZZGh5U2RaS1dseEEwT0NrMmtYWHlqWWJqSmhjamtjdEZsR1JK?=
 =?utf-8?B?WmpYMjd3cUJvMlYzYVBOT0ljaGNhanpUcFdJSGhRTndvOFkxb05xdXhnd3hE?=
 =?utf-8?B?bDA1a3FzTk80ckZqRXMxSnNhRGtoRXAxNUx1TFpzbTcrZ3l0M3lIU0x3aHJl?=
 =?utf-8?B?NGhGa3lZOWxBc0tGaG5qZm9FQXliZXFjWXNWZmttQ1Bmd1JKT0ZkUnF4K1N6?=
 =?utf-8?B?OTNhWjFIU09KVVpUK1p0eXdvd0cvSHVYbjZTaVZhbGoxMU1kVWlNTXdhUlhJ?=
 =?utf-8?B?RjFxNStnWjdkYzNINnI0dEFxTXFoYmdqNFNqOVhnSWZpS1cxZ0hjNzByVCtm?=
 =?utf-8?B?VWN5MDVFcm1kc0xGUGJHdWI4V24yYTFHN2ZBM1owanN5WUJZeXpOZkdFcHlm?=
 =?utf-8?B?ZDVPR1U0VjNMVVJ0YXE2blk3K0ZhcHRMWkRzbnhMZGFVOXREUEc4YUwwYWVC?=
 =?utf-8?B?b001WVFMcFRYRTlCeTc2ckcrTUwrM2l0d21UR1ZFb0tJYlFTSEFIVFdMeUVy?=
 =?utf-8?Q?CrrLN+oLhCV53fq5YlFeFx0tc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce98ce8c-3c36-471d-8f45-08dd75ee34b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 16:06:50.5034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECYNwxlRKZZEfwPmnzQGIjBAAG6av12UTVX84EeeVfcHKA0KendYninJ0UxqZvzT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482

On 7 Apr 2025, at 12:05, Toke H=C3=B8iland-J=C3=B8rgensen wrote:

> Zi Yan <ziy@nvidia.com> writes:
>
>> On 7 Apr 2025, at 10:43, Jesper Dangaard Brouer wrote:
>>
>>> On 07/04/2025 16.15, Zi Yan wrote:
>>>> On 7 Apr 2025, at 9:36, Zi Yan wrote:
>>>>
>>>>> On 7 Apr 2025, at 9:14, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>
>>>>>> Zi Yan<ziy@nvidia.com>  writes:
>>>>>>
>>>>>>> Resend to fix my signature.
>>>>>>>
>>>>>>> On 7 Apr 2025, at 4:53, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>
>>>>>>>> "Zi Yan"<ziy@nvidia.com>  writes:
>>>>>>>>
>>>>>>>>> On Fri Apr 4, 2025 at 6:18 AM EDT, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>>>>>>>>>> Since we are about to stash some more information into the pp_ma=
gic
>>>>>>>>>> field, let's move the magic signature checks into a pair of help=
er
>>>>>>>>>> functions so it can be changed in one place.
>>>>>>>>>>
>>>>>>>>>> Reviewed-by: Mina Almasry<almasrymina@google.com>
>>>>>>>>>> Tested-by: Yonglong Liu<liuyonglong@huawei.com>
>>>>>>>>>> Acked-by: Jesper Dangaard Brouer<hawk@kernel.org>
>>>>>>>>>> Reviewed-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
>>>>>>>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen<toke@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>>>>>>>>>   include/net/page_pool/types.h                    | 18 ++++++++=
++++++++++
>>>>>>>>>>   mm/page_alloc.c                                  |  9 +++-----=
-
>>>>>>>>>>   net/core/netmem_priv.h                           |  5 +++++
>>>>>>>>>>   net/core/skbuff.c                                | 16 ++------=
--------
>>>>>>>>>>   net/core/xdp.c                                   |  4 ++--
>>>>>>>>>>   6 files changed, 32 insertions(+), 24 deletions(-)
>>>>>>>>>>
>>>>>>>>> <snip>
>>> [...]
>>>
>>>>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>>>>> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9=
ced85e0d198947be7c503526 100644
>>>>>>>>>> --- a/mm/page_alloc.c
>>>>>>>>>> +++ b/mm/page_alloc.c
>>>>>>>>>> @@ -55,6 +55,7 @@
>>>>>>>>>>   #include <linux/delayacct.h>
>>>>>>>>>>   #include <linux/cacheinfo.h>
>>>>>>>>>>   #include <linux/pgalloc_tag.h>
>>>>>>>>>> +#include <net/page_pool/types.h>
>>>>>>>>>>   #include <asm/div64.h>
>>>>>>>>>>   #include "internal.h"
>>>>>>>>>>   #include "shuffle.h"
>>>>>>>>>> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struc=
t page *page,
>>>>>>>>>>   #ifdef CONFIG_MEMCG
>>>>>>>>>>   			page->memcg_data |
>>>>>>>>>>   #endif
>>>>>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>>>>>> -			((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
>>>>>>>>>> -#endif
>>>>>>>>>> +			page_pool_page_is_pp(page) |
>>>>>>>>>>   			(page->flags & check_flags)))
>>>>>>>>>>   		return false;
>>>>>>>>>>
>>>>>>>>>> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct p=
age *page, unsigned long flags)
>>>>>>>>>>   	if (unlikely(page->memcg_data))
>>>>>>>>>>   		bad_reason =3D "page still charged to cgroup";
>>>>>>>>>>   #endif
>>>>>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>>>>>> -	if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
>>>>>>>>>> +	if (unlikely(page_pool_page_is_pp(page)))
>>>>>>>>>>   		bad_reason =3D "page_pool leak";
>>>>>>>>>> -#endif
>>>>>>>>>>   	return bad_reason;
>>>>>>>>>>   }
>>>>>>>>>>
>>>>>>>>> I wonder if it is OK to make page allocation depend on page_pool =
from
>>>>>>>>> net/page_pool.
>>>>>>>> Why? It's not really a dependency, just a header include with a st=
atic
>>>>>>>> inline function...
>>>>>>> The function is checking, not even modifying, an core mm data struc=
ture,
>>>>>>> struct page, which is also used by almost all subsystems. I do not =
get
>>>>>>> why the function is in net subsystem.
>>>>>> Well, because it's using details of the PP definitions, so keeping i=
t
>>>>>> there nicely encapsulates things. I mean, that's the whole point of
>>>>>> defining a wrapper function - encapsulating the logic =F0=9F=99=82
>>>>>>
>>>>>>>>> Would linux/mm.h be a better place for page_pool_page_is_pp()?
>>>>>>>> That would require moving all the definitions introduced in patch =
2,
>>>>>>>> which I don't think is appropriate.
>>
>> The patch at the bottom moves page_pool_page_is_pp() to mm.h and compile=
s.
>> The macros and the function use mm=E2=80=99s page->pp_magic, so I am not=
 sure
>> why it is appropriate, especially the user of the macros, net/core/page_=
pool.c,
>> has already included mm.h.
>
> Well, I kinda considered those details page_pool-internal. But okay, I
> can move them if you prefer to have them in mm.h.

Thanks.

Best Regards,
Yan, Zi

