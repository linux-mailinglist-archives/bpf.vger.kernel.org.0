Return-Path: <bpf+bounces-57039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ACEAA4AC4
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 14:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE359878BD
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051D231A23;
	Wed, 30 Apr 2025 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SkFR+DBn"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B6248F5B
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015068; cv=fail; b=hWHa6ieIB2VhGSRJkk8WWLB1dkiwrKiffA/Lw/K6kYAev1RiZOWCYak0DJ/LDtfhqJT/SdrXOQ8CZk+qN5vjGfw7nAAT5EfAmAj6OtP1B0t7EOL8iqaGCKSYrUzc7uBtHnYFWp4dxPD3hMtNBAkNRxI7XTLGRyeGbLnik/vgRGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015068; c=relaxed/simple;
	bh=vWXYHTbpL6EJ3vJJq/aR+0MjYoOLTs+i3HtvrlYQ/Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BboQF9/VtFfvXRw5UHQtCiUvVTPMGq4L4en3Jap8w1f5H3CnSLYVVvv2Iieecev7Z6bbTUJH1QYfczPLTIW4OxIM8B5P53lLtpVtMQQGFXPLINtDFIFVS2mq7iNB0IztY4pDOjwhgQMn3ZqVvJHPcenIXZEVZn6FCi4jo61eeUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SkFR+DBn; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIsx/MKNtJkd6D7QQLEnufVmGNPBBxdKb0w+slSxPaCSPsTrxm4HoMhSHYWhgnFQPtmsNmevqSnlXxG0lTfxhLqJqpEKb4Om3IJstdIZC5eTsgSq7IfFu/vQ70xpmFEqa0cSy7kSOeMYU0ocegFBLklmVP1BHWRbJPn7vU5msBRmIFPVyCI0kaBO44tSdpBMmfLCFzmmyMOwECjaOVDgBMi9JYqGDBxjnP5pddH2BENw2a3LfT+y3OpOeCjWa1y+SUBbe+5arUAF5eMvUZqL3/IVymb1xZfedbrdEczAQFvQgg1yZlflBPdxJg4yOlPnpFQtU0do4OnzIl6z8Z8UPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWXYHTbpL6EJ3vJJq/aR+0MjYoOLTs+i3HtvrlYQ/Vc=;
 b=i8ZXDtx2jKqVC3wYeIEeV6mau1znWv3TPHlPGSjK+i+TQ82uaMt7SiQvkhXLSZa6tWVIYL4F1guZv/eyC6SHFowpMimCzDPqyfqrUQNRcQLtwqA6qqCHAM+ZDyNkq/2DxODbVGU+RPVu+IJtmk9jdH2hgRZH/awwXov+6WoZEJ4cfqIg94IxAXE/xzmfMZWU53e92dmVQT4eWTBtf0aRV5i9GPXlLWUYLCZY1AxcTxq+iDkMlRgvtfIbdJGzw4PqD6MwvWLANAoLlk4UU3nnSPDWvI3QjE+GCTjrvOEruMqrJAKGnyUv5bu/UxqoljTkPATWYI8bxrVPWrhvz1ukyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWXYHTbpL6EJ3vJJq/aR+0MjYoOLTs+i3HtvrlYQ/Vc=;
 b=SkFR+DBnu1tfgHjSKy8X3n+9LPoFYGY9mbDUM5b/sObdIY73pfqyI+64bwSQOgXJSSHO0Mwxj++AIP+5HbxolTZaDG0+mr6SoBPclV3KxGej0scttGUZNau8TI6Y58EGPNVfouRcKEnewOO9YgxF4Dt1uDTW/xuwzPQLPPpuwW92HPCFz3dt0mmw0vtL6Ijc6ZCHnZxRUwTbC0pfD4pF4Bm56Np3HZrjdJ8fvWCHKTDjYSI4bXbkIBppkNuFl7fkiF6rPujiKBOXTW4Dod4L0N3Pa4OTGeB5S4ePfTvCWcs7CYj6MA/X2p8XFbYIk+vjEwe50VTMFHWe9g7wCMwH1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 12:11:04 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 12:11:04 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] mm: move hugepage_global_{enabled,always}() to
 internal.h
Date: Wed, 30 Apr 2025 08:11:01 -0400
X-Mailer: MailMate (2.0r6249)
Message-ID: <23D129C3-0E55-4056-A0C7-5713D71FA42B@nvidia.com>
In-Reply-To: <CALOAHbCXSmTMwUNSR=6CBtFRUipFbm-58zX1FDKff55Bv4QbNg@mail.gmail.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <20250429024139.34365-2-laoar.shao@gmail.com>
 <D9J7Y3DKHQJI.2MBF33WKN1BH5@nvidia.com>
 <CALOAHbCXSmTMwUNSR=6CBtFRUipFbm-58zX1FDKff55Bv4QbNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0150.namprd04.prod.outlook.com
 (2603:10b6:408:ed::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: b373cf37-35ff-4593-e32e-08dd87e0144c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEoyUU01N01HZlduMlAwUXF5NThmdzdtYkxmV1RLblU3R1YrMHJHTm9XNkdW?=
 =?utf-8?B?bDAxNjU4dU1TMWM1dEdHWVRJS3RpYVZUcHh4Sm9RZ04rTHQxUmVEU1RXZk1h?=
 =?utf-8?B?enowRWlqU01GdDFwVk55MjlaV1ltaXVCa0ZHVGVWWVFVMnpTc0t0TmZiL2Vk?=
 =?utf-8?B?WTlIcTVWQ3BvRlkwM3hZNXpXZkY0WjR2TktmMTJTQ0tkOTlXbUNWSjlZdUdH?=
 =?utf-8?B?TVVEdjRpc0lZenh6cEtZajFCNDlITkpuaXptbXVpWUpaRWlvc1Q2RzUrSjV6?=
 =?utf-8?B?L0VNMlNUZ1pwWW40ekxsMUhxcXV3d3JUQmRFQ1JKbTYrOWI1bEZERnBneGZo?=
 =?utf-8?B?TjlCd3ZoNk01OWlSdWxOR213dmtZUGE2S2tFeDdKcUpGdUVBZ1QwdlEwT0Uz?=
 =?utf-8?B?VTRvMmFEZUQ4b09PRUxGMWpCRlZBUGtDTmN2NDhGbUNDbncyQ1M4SHFOVE9n?=
 =?utf-8?B?M1JWVnhxYzQzRGs5WkMwOVUrd3JSRXErZytwZXpTRTNTTFJ4eitUMEx6amUy?=
 =?utf-8?B?RGVoZjRIRVJDNTVNakVQSGV5S1hFUjRKV3I1MTF1WENzN0pKTndsbFRVeXlW?=
 =?utf-8?B?OXNJaHlwL3J5QkkyZ2pOd1RJWGhpNjM2Um5IczZxa1NDWTI0WVMwcjdiT0Yy?=
 =?utf-8?B?U0pCTU5FWWgyTklTaFhmRzZWellHdTI1UjFudWZrYndsRVk1WTJrbUdvd0FK?=
 =?utf-8?B?NldlUVdJR1V2V1BkYUQ1dlNEY012MWxZdXMyQ2xmdjRVS29pVnRMY1k5QmNx?=
 =?utf-8?B?UDg5eGxGMGZCUXMvTXRtUTYvZ2Nja09Tdy9rYk8xaklicHV5cmc4MnJJczhQ?=
 =?utf-8?B?cUhlKzFZWFltWmYrY09zVTl2eXZZNVR5VVdHbjBHb2F5TTBHN1BSUzVRcEZD?=
 =?utf-8?B?bTRHNmp2aURqVS9zbTVYOW50Z3A2SkkxZ1RTc1BrK292MlZnYkVwQUMzNHFI?=
 =?utf-8?B?Q3V0bkszYlhTN21NUndvT2p6cEtlQi9nN1RYTkZNa3lkZWhuODlLcitmbDBs?=
 =?utf-8?B?MmdXamdQbVFCL3VWV3pxTU04MnAzZVJFRjFNa0d6SzhpVGI1TG8rbHZQK21r?=
 =?utf-8?B?K255Zmlla042ZHBseFRzTnpxUFd3aDhMU0lUeHB6bjlheHNiRVNDYTRaVWh6?=
 =?utf-8?B?TWVBL0FNbkptQTFYS0NYSWY1Q2Q2a0N0bzh6dWtiaStqRWhkdzZld2kyUVNp?=
 =?utf-8?B?amxWcFhjS2o2R0lMVDdQLzJrS2xYNGw1VEt0WnRIanQ4RnJzWEJHRFFzRGhH?=
 =?utf-8?B?QzV0U1BpaitSY2g4V2lkaEl2STJ1RHQ2SW1UVFA3WkhzZFNOd3hScm9xcW9G?=
 =?utf-8?B?NndWUkZLWG1ITWFsRlhJTy9zYUlRRDlSb3MzK1dNZ2dkclR5QWh0TGFaMVI5?=
 =?utf-8?B?ajBYWVFUb3A4dHpFamIwaXg2WXdDcnltbjZqSmFORDlYMWl3bWx1Rk5oS2t2?=
 =?utf-8?B?N2RvSTdkZVpERkcwM2d4U3VLK3NCRFpDb3UvazZ3emdLVzZQclJISE95cVJM?=
 =?utf-8?B?bnV3WDZHSVNUY3cwenJ5N0xKMDF5Z0Rrbm0yc2FoVE42ZlAyU3JoOWhyTW04?=
 =?utf-8?B?Qk9iNEZUaGJidlJPd1NGRmE4aVNCN0JkVTEyZ1ZtZk1PR0dCYXdVRFZ5MC9M?=
 =?utf-8?B?eDh4T1pXVk11YWFadWdWaUdZWi90dDUyWDNOL0Y1TmUwWHFnSHRBNU04Vk95?=
 =?utf-8?B?ZFVwdU83cFo0eDZBcHJ5MTNEOGdzdDlyUzZqRFFya3BmMndicW5lOXRNdzlB?=
 =?utf-8?B?dktROVNmdTRGbHVBUjcxVytUb1duaDBGUXFPMnYxRUpyQjcxWVpsZ1BCaXVT?=
 =?utf-8?B?Z0djb3k2Umo3K2grTzdxY2lueUhsWXZHWDZhc3dFbmVjaHVQU1Z5K1F6VXVo?=
 =?utf-8?B?SXpoYnAzOVhtUVVmVkJKRndxNGdHMEthZDdRZmJZR1pXUXZteUg4ZG4zZDZz?=
 =?utf-8?Q?a5e5TeKLnjA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXdVd3VuaWtMdENJMU5BSitBK3c4TGxURkFzdlY2T2luRXZsODBkdGZ0a0Jl?=
 =?utf-8?B?OFVIYTBQRDB6Y0l4RWY1dW5MN3dVSEpVVE1qTGJmSldaUmRXbm5rbXZzbHBw?=
 =?utf-8?B?RUFkNVBtQk1hcGdmekRjSFEvODI5eUFrYi9OWDd2SUNJVm1lLzZsTzVJYVpD?=
 =?utf-8?B?T2M3VlJ0aE5KTjh5NUJCUjArS1V2Zko5eTJBRGpvelZJampIVFhGNll2dlZ5?=
 =?utf-8?B?U2NScFU0UzRORVZpSXNhdFRGZFQvRWx1ZkdZZll4VE9Kak1FL3ZXcHVYMlFE?=
 =?utf-8?B?QVB3RjVlYm83TkV1V2VyY0RqaGpsVnBEcFFaQS9CakUzMUN0TVFPWVNETWFk?=
 =?utf-8?B?MThxREJ6SXpRRnZQei9naWRISFZ0Y2kxS1htcGpheWNRWlpxNnRKMTQzUlh0?=
 =?utf-8?B?aUtBV20xUzlnTjdCSjYwb1ZLc0RRbUUwZmd0Qys5Rzh6YmJraFo0WnBDaWkz?=
 =?utf-8?B?OGJGSTVKcW1kUExDckdmejZwK0NkR1RMZzZENnNCVXFBaGtCNGNrcjQySldw?=
 =?utf-8?B?d0E2emJGenJCZDhhOWlGSGU1dW9aMmV2bmxSWS9WMStJRmQ1MHdqTG1pWDFl?=
 =?utf-8?B?WmRjK0I0aVF5YWVRblFQVEZ2dlMrSHZLMEJMbFBQdmQyM2RjSVUzY1lMcUhW?=
 =?utf-8?B?anZENnl5bXpqei83Ykk5NWQwa3dIR0xGU0ZFanM2OCsvY0pDVDJHQVhBWVRv?=
 =?utf-8?B?U2htMlFpOEtXKzVCRTJweWx5T0dsYlMzMTlyWWduMjk1eGM5WnB4NmFkRENI?=
 =?utf-8?B?UU4vS05LbG1nOUw5Y3YvRnlKemUza3U3aCtkSExEQ04vSzlnaGFYTnBMYlpQ?=
 =?utf-8?B?MUkwempmdXpzMU9HWTduZzJBOXlxcklIYU1MeWFhRXI0dm9NMENQZGVrTmpO?=
 =?utf-8?B?Y05QSVNMRTBNR1ZxN3ZXcXdWSUFrYkV4R0FrWmNQa0g0S3FNVTR3bktUSHZW?=
 =?utf-8?B?b1IvcHA0TXRkMWcxbEFZancwNjNCRFhRUnBjUnhNQUZONjExMEhDekx5R1JM?=
 =?utf-8?B?SU9LTmEyUS9nWjZkSnpFS250eUlha2FPQ2FYSDkwV0Y1SnpkcVFtUjMxYjB6?=
 =?utf-8?B?WER6dWRSQzNickNlY0V5OTZYaFoxSVQrWTd3cUlPbXpxWDkrMnRqQmRhSjIv?=
 =?utf-8?B?R2dpaTNPZDhuSkJPS3N2M0tZSzAwZzVvYUZpYU1hQzZZWEVGK3FNNERTRTZ2?=
 =?utf-8?B?UXRNS3hCeEdKdGVidWgzNENuMmFWS2k1LzZTa0tDTGdOeHVPTWIwb1JreWxI?=
 =?utf-8?B?cm1rSXlpMTJXbERHUWlvTmQ0U2J2cm5MalU5WmZDcVgrSUN6aWRidXE2S1lr?=
 =?utf-8?B?dTRBWG9vd0ZoVnEwaFBEdFFiTUlJMmRXMnp0RDNaeWcrUVJoUXlBc1U1d2c2?=
 =?utf-8?B?ZVBZaTVKZHNIbzc3RDJOL2ZuR3QwYXV2TjdBUFVTTittVnBUcGw1MXRiUGZ0?=
 =?utf-8?B?WERTb1UrYXR6TkxaK2hmeDFtNXdmYWtXWDJ3WnE5U1BTY3JQNkQyMzFOTkk0?=
 =?utf-8?B?UkZBcGQzc0hmV2xqZmhtaS85YjJMSGlZU2thaVIzRVBqMmRGUnJGRSt0QVVy?=
 =?utf-8?B?cUJmOFRpYU1iSmZrRnk4MUExa2l5OGhYRTNRMUxWVTRKWDRlZXd0c0s4Yk5R?=
 =?utf-8?B?RHhZNjZMd3VHRFVtSVVGTlAwN3B4NEpKUm92eVdqVXJBdklac200UnBMSnUw?=
 =?utf-8?B?OTlZUEZkOUpZc2Vob01LUHpvellJekl6UjlIRjgxcklBcWJBRDBCRTFoT2Rj?=
 =?utf-8?B?c0I0T2F3dng0MG1mTnVlNkZjTUc5djh1UXBGdzlNYjZUUnZXcVh1ZHo1eVBO?=
 =?utf-8?B?VnE2cWlwV3NvWm1aMEdxVGpUNkhDWGYyUEV5dlFpVTRTcmZQdDYwY3FJK05H?=
 =?utf-8?B?TVFDYkFrdWJLVEgxWFhpMWlQTEFPc0h6V20wUVk3UTUxTGw5Q2lFMU81djVH?=
 =?utf-8?B?ZGswYkMzVUxGUHgxMFlML2J3MG1qSU8xRkh5MS91OHBuaWtYL3pLbVFhWHlv?=
 =?utf-8?B?QlJ5STh1SUR6SjUzSWlkSnJ2dkNFYkxkZjF4UDFLdTYrb2J0UlZCZHZ1OWl5?=
 =?utf-8?B?L0pQdmR3RC9XWm0vVjAvd0kwV0tWd2lPcU1CZXl3NWhGdHZnSTBQRW1CU3RN?=
 =?utf-8?Q?hfz6us3/d5R8cUMpf6BNLAaPu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b373cf37-35ff-4593-e32e-08dd87e0144c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 12:11:04.0676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCijsHensoE0FcnpcPW+r05tEyShDeOYwlZaG2QG93IxGVcOT0rvZTi+a4UyZkBt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852

On 29 Apr 2025, at 22:40, Yafang Shao wrote:

> On Tue, Apr 29, 2025 at 11:13 PM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
>>> The functions hugepage_global_{enabled,always}() are currently only used in
>>> mm/huge_memory.c, so we can move them to mm/internal.h. They will also be
>>> exposed for BPF hooking in a future change.
>>
>> Why cannot BPF include huge_mm.h instead?
>
> To maintain better code organization, it would be better to separate
> the BPF-related logic into dedicated files. It will prevent overlap
> with other components and improve long-term maintainability.

But at the cost of mm code maintainability? It sets a precedent that one
could grow mm/internal.h very large by moving code to it. I do not think
it is the right way to go.


--
Best Regards,
Yan, Zi

