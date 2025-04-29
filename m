Return-Path: <bpf+bounces-56956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 279A5AA1016
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847CA1B6235D
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652921D3E9;
	Tue, 29 Apr 2025 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LZEXcxcJ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E478F44
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939640; cv=fail; b=hQjJ7Wsvvok82FM+/JAI3tzvxOQ0Z6cM5K7J4Unio7pJiGYMjcHGOaXjI8WHEIcXBKalu/JKbKq6KoxHU3j/Wp/HgdgXKofj66RQAEkVIxk/oltrjMWssi761MDAGaNs4K7Xcv3yMW5I6FoWSbOWllq7oZeOYI33vm3U8a1UxiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939640; c=relaxed/simple;
	bh=WJHfVu+4j28cAzfZBVcrHzy35RQnHaUSedthdt27Q3g=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=YRwoqEuoSHwgd8jGWoSEKc86cE1ti1OsjU0y2gIrVswopFYUZ7KAmuyK1fKCkpWftmYBczxMPlD6ahbwMdCw2qvsASYtPKgp3ItZeEA58MiqANILZ0SC3Xx7gKT3lZs4B+M19jnAjnGpUY6PAE+sqyqiYKpb82OaWsKpuXlNKWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LZEXcxcJ; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqdhMSUFqZUCmoNbDiaTR+HaP1EXxZlkzloz8gUwYR/vTAWeNGnSEq5N+c9DI+N1lit7q3tlh095mJY7aO4RTSyoS9RKJhEp+DYUQAbgXsNy4WKCwoB7Q197OY4OqXrPKqGE+PZIwSEOUvrW62/8G+J4cv3XyrIlJN5bCstcNybFr4j9ZgLwGAslDYRFj+SHw1ECsa+8ou/AQJ2sIryh93tvjWr2Vb8t32f847K8R1CPat+hobUU8NfZJJBhnJv+kEiDYHXBaM6jcuCaFLxnBA+oFzl2u3SfAOrM5A5eljW02yFbj2N24UFrCcXBpyjTzNgnzjAqHDXcdW/1lBh8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghXbuEZXmJMYMlXD8Yk77nlF/z5ntWPRWZaN0Y//WD0=;
 b=wZw86LUgqsSucR+likzJ3Cxy/xMWfFL+UWObUXhQergNLWxqAHpRQJ1Xbq3TCnxeqlLqTUy4GeoC96VXoQsaCqBdntHNIJ5gArrbsJYajoBfNK5nbScB3DWHfq9ArA3VkCfAV3NvKs9mm8gm1mQAjZjH0D9M0HzOTW4mO3OEwMfXR8D1vECYd0yveLwUt0dLW31lnRINylSeDaBBNOFeu0bglSSFKckqs3LLpDIRyB6LqLHlDc9kTpf6EYWT12F/6Q/TPFFHgWBiea4C1Ph1+CPapCaXI1FsNtHsOvIdeNOK/K6E7avdUIcPiITEApi4RccnnIL85bluDGCBRicqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghXbuEZXmJMYMlXD8Yk77nlF/z5ntWPRWZaN0Y//WD0=;
 b=LZEXcxcJ3eYZrKgjJ/pdD7jNxmiGTOSnolo/KCbSAq2wo1zfDYJ4CTO1E63uBq0hwZNDHSLMkPlScW0OiiwPkDvh/7PCeQ5OX3mKIoburw16xwSIHIFazMS6W2jGHyzV/fa2KwpFL+nt6xVnWymxCgDBY+JF81iVZTRNxclT00GPL2gmixSZnfyYC0CqDOrEq8jF4g8irwDio41Z+gnCknUIO6hy64IIpqPXpY53m9sfxA4upQnQpGjH+zmoLn628ertvRXoc9Y8VMNszsoD8gRzNfMQxuv2NOgT3Al0twI8ycEfOZzNbrm2EvHgQ8aigxc0SYqKcXjAyuGUsUS0Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 15:13:56 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 15:13:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Apr 2025 11:13:54 -0400
Message-Id: <D9J7Y3DKHQJI.2MBF33WKN1BH5@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [RFC PATCH 1/4] mm: move hugepage_global_{enabled,always}() to
 internal.h
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>
To: "Yafang Shao" <laoar.shao@gmail.com>, <akpm@linux-foundation.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
X-Mailer: aerc 0.20.1-60-g87a3b42daac6-dirty
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <20250429024139.34365-2-laoar.shao@gmail.com>
In-Reply-To: <20250429024139.34365-2-laoar.shao@gmail.com>
X-ClientProxiedBy: BN9PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:408:fb::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 51035743-d331-4da8-c268-08dd873075a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1MvM0FRalpYR0F0ZS80NDBqSWQ2WHBUQVRRd29aN3FCeFBvZFBtaDhmbmd0?=
 =?utf-8?B?aU5zOXF6SWlSQXZrMjJmOHN4YVgyS2U4MEJYUmJZRW41MFk5UXZzRHAvcFhi?=
 =?utf-8?B?cXhleWd3TFZCakxldlRqNGdTbi9LWG1lUldWS1hsL3kzRGlzTEdNUEI2dVhu?=
 =?utf-8?B?NWNRYTZaQ0F3Q0Rhd041cjJ6d05peXdqeWljUFpweTBTcDErVDBRTCt1c3Rk?=
 =?utf-8?B?WnhTOGpnQ3MweUJ4aWl4YUdKQkRaUCtOTkhGVUxBZVJWdjU5SXpNc0hWbng4?=
 =?utf-8?B?S050ampSbXpRTzJBR3lla2ZBSlVzTjRHSFZMZXpONTFxZ1lUdm93dElQK0I3?=
 =?utf-8?B?U0pmL21aSmdLU3Rvejg5MHVmMEREYW1EM3F1VWszQlFPUmUwWi9YMXJsZThn?=
 =?utf-8?B?eHVES0xONTZQSWNNU1R6eU0yNDhCdG5vRVJLbGs2emQzUENDdmsrNTZtdC9M?=
 =?utf-8?B?WHh0VVBVQngvSDUxNXJkM0pVYlBTSk4vR1N6RS8yc2VVS2VaRXF5UVN2TStt?=
 =?utf-8?B?M0ZpMUprUjRaOWtZeGppYnBCdm9LaHl6bHYrVy9OditSZ3V1dFM2TXJ1Z1NT?=
 =?utf-8?B?amdkdU4wbUpuQ0s1VFNlV1pqMTVvMEdxSUpTaG5KMDMxb0RvSjNjdlBqL3pq?=
 =?utf-8?B?NllwVGJYdXgvQkFyd1MrM2NlSkpTa3hORk9Bdjc0Ni84NzVLeXc1NUc5R2Fs?=
 =?utf-8?B?QzJLUDBPV01IY1dXUlhvNm1ST2w0M2F6Q2tINFMxZFJkeElGYkd3blJwd2ta?=
 =?utf-8?B?VDlMUm11REg0OHlzbkcyaFlqV0hna2JYL2ZyYk42c2t3ZDZpTGZXWXJGNHUv?=
 =?utf-8?B?WG9aQWFFSkloa2xZSVF3SjllY2ZQd284N2tyS2NkQ3RnY2JESWlvMnFMUG4x?=
 =?utf-8?B?QzRCUWVQVnBxSlE1WHEwdWh4YVBwb3VSMEhBUENFOVJMbHhYanprZEZEdnFt?=
 =?utf-8?B?OHBxMDBqNkVVUENyNjFEU2s1UldnNGkvRDlSYWVGSzgrQ2pXOGxSZmNrR3d6?=
 =?utf-8?B?RkRDbzljdDhvZFFoYS9RL2pHa3Yzb2hhVThQUVdoa3BwNmx6eXZsYWdGY1Rs?=
 =?utf-8?B?WXBFbHg2Zm5YY0ZqSWNYdndIdTZmbUJFVVE4Rm9nTnZuRVdkeGo0M1l6d29p?=
 =?utf-8?B?T3pOSy9EdWNZYmxPMXVxMHgzUkhHYlRUVjB2cWRHUllsbHRJT3NyeHZKdzFQ?=
 =?utf-8?B?dG1ZUlE2dmMvNy9ZdGxpUE5BOW1DRTRZMGlJT3BiSzJ6dnRCd3pYSk9rMDds?=
 =?utf-8?B?T01McUpKcGV6QXFMTDNNdEFsRVY4Q3dwRFBNZyt0ZnNIdFJBcEFIcXNuVjZo?=
 =?utf-8?B?MklKdVM2SVJkTVpjYWcwTnl6NjRUR0JsdGhlYnVxcVN6OTZLRmV3TGEvVXcz?=
 =?utf-8?B?L0kwVmEvVlBhT2Y2THFBVGpJMEdTQzc1aHM5enBTbUw2d09KcXNST2hZSDFK?=
 =?utf-8?B?c3Q0cFJodjRaVHNKbkQvR3BQenpUcFJYQitWM3Z1dmNURjNwcVRUbnU5cEN6?=
 =?utf-8?B?Mi9HYVdLRCtXbnBjOGVRajRnM0swOXRrNnE0ME5YMjJHNDI3di9hZVpTWHlx?=
 =?utf-8?B?SWljODJ5K2ZOcC9LV0RWay9DMHVFL01rQWV1YUNzNkt5endRVFBXZ3Job3pa?=
 =?utf-8?B?VHV5d1VzcHJML2ZIdkErcmhKVzRPZyszNXE5OU5keGVRcXRuQlIxb1ZMNUYv?=
 =?utf-8?B?SncxTlVrMElXZnBCNUxxeHlyMTl1bHIxak5nVTVSRFp6MGl3bzkwL21lUWxC?=
 =?utf-8?B?ZHIwNGpOL1BwMkZxMGhNdldiVDI4MW1aai9LNnJjLzQ0V3lQUDRNNS81L0Jv?=
 =?utf-8?B?T2hPOFJKL1dpREprYm1vTGNTYzExYjdRZVRZTFBzVGhaTXNURDZTMER0dndv?=
 =?utf-8?B?b1dDRGJOc2ZMaXFIRnNXeFppL21ESlZBNmhjNUlaN0dibTVUUzdPMGRWU251?=
 =?utf-8?Q?gCcE6+CfJjs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0JiWXVvSDBvVmtkeGdjcmZBRGFWRFpFL2F0Yjk5emhpcUducUFwNlo2RVgr?=
 =?utf-8?B?RGRXM3IyZXNuRDFCSmdCYXBFb2lVZmxobzlqcnIxd3M2aFhBRUR6Q1BPVUFq?=
 =?utf-8?B?NUpyaXNOdHo4c2VmRXZKTlRtK3hNZXM3Kyt3dUdhOFM1ZVlCYVNJS0dYc3or?=
 =?utf-8?B?czNSK0pwV1VyeEluQVlFRU05YUU3Q2JOR0pnT2M0Nmw0YnVVem1wZ3BIOFRa?=
 =?utf-8?B?RjczOHJnelFKQXcxaG40UTVEMjZ3dFF3TEtZQ2l6YXpoVXMyb0hsWjJlOWhG?=
 =?utf-8?B?YndBb29JVktWYTYxRzQ3bkJOOVg2dU1MNElYRGZYanN4eWhvQ2JMWndhdjZD?=
 =?utf-8?B?RENaOU5Qem5WWXV0N09NRzRZeEEySXlRYXM2Q2dWWkI5TWZFb0E3VFBad3Uz?=
 =?utf-8?B?Y3ArK1NVZW9HUGNDSWRWYVNTT0N3RnNmdlRaOHNLN3VGRCsxdmNGbFArU0l3?=
 =?utf-8?B?ZkF6cmNQR0NNNG42NHBGVE5TTTdGOW13L2d2V3d6K213emQxUDltVkxIVUZQ?=
 =?utf-8?B?bWpDU0Jaa1BjaGh0V3lSSFkzaEttckZMRXlMYmxMR2FYM3ZYbENzcHY0YVlq?=
 =?utf-8?B?dWdFVldTRVBOb2h2RzA4TDRNa0RlcVRBMlY2NEpGVEJocWdZYit6dm1BbmhX?=
 =?utf-8?B?RUZFeHJXK3dXSExDWUxCQTFiTFFPZElJUStUWitzeUV4MnMrV1hIbFRiQWVE?=
 =?utf-8?B?a2RUa1FGaFN5aHhkZ3k1cHZaS0dDamNZTi9BcG81K00vZituWU5SZDNHL3ls?=
 =?utf-8?B?M1hpZjBNek1UeU9oL1VkNHhBa3VpdzAvQ2ZhSVJqZFFKK0tkSGdtYW91VE5n?=
 =?utf-8?B?V0s5ODlhVmlaYnhRemlUUWpCSWZiVkVUR0JqUnhvV3ZqMHJ1L2FoWkhrejAx?=
 =?utf-8?B?TTZTT2t2bkpsVFdhVDJpcW80T2p1NVVXZ1pmUVJGUitGckdvZkpicm1NYzZU?=
 =?utf-8?B?WHluN0pnVnJ5MXFmcjJxWUV1WUJPZzVwN0kxOVd1UHR4RDAxVmViYmZLSTI5?=
 =?utf-8?B?dlAzaTVOVGVPRlR5Z0h3YlVwRmJRNWRVb3g1UGtWMG9SZ2JENE5veXJsVHpv?=
 =?utf-8?B?RkU5OEc0ZERlSmZnRVoxVlRoNjh3SFh4ZllWR01pVVRxakVobjYzdjRpalRB?=
 =?utf-8?B?WG9tcER6K2kwVFRjaGFmZXFFTEYyK1dRRVJKQnhjWUpYMUZidE9UQUF2WE5p?=
 =?utf-8?B?TzFsWGI0ZWszYXpRT1dxUkxYZ3ZVMkFJcUE3TFY5cWdscjJxbFF3aU1GVXdW?=
 =?utf-8?B?ck50Ulp5YjVkeXdUVjR0eHJLNW13aTl6bTJGd29zVHZkYjNDUmFtOU5UMzR0?=
 =?utf-8?B?bEFlTVVvZ0VuUmxja0UvZDN3QzIxMndwanBQOE85bk9Zalpick9CWEJUN0pY?=
 =?utf-8?B?QXZqOHBLZllveFZ4RjlKNWJoMUV6dEU4M1NMNlR1K0RZdkJ4ZFBGTHB6MFpV?=
 =?utf-8?B?Mkh0UWI5eHVWTEE5YTFCY0VpVWx3SFk5QTJUbDdLMnFBM3RsKzRYb2E0MHIr?=
 =?utf-8?B?bFpPOVphNWpCVlJSa1JDazVCSjZqZHNpaU0xck1ETlp0U2tJZ1JDcWdPU3Fl?=
 =?utf-8?B?QXhsMC9pR1I3bUFZMHNUdkFhd0wwempqMkRGLzMwRDlrbFVmRC9jbzJZWDdp?=
 =?utf-8?B?a2IwSWlHMm5mcXBySnVLNmpWY25CSE9RbndTcHZWN1ZNTStGVGhLMlhrSW9P?=
 =?utf-8?B?RHBCcXBHcWVnT3JldjBRQm9TYlZYQ2NzRHJvVjV3U25zWGpUWTlZVmZ2bXlz?=
 =?utf-8?B?NmNJMUI5eEVDRU1ESmJEOVBIbUMrRE1Ucm9JVmo0akMrK1Z4VWNVT3AyUXBy?=
 =?utf-8?B?RXJHTjY1S3RRU2F0VCtpYWU4RnhEbWNXdjNTTk1VeW1hL0JjSG5RYno2Y2hS?=
 =?utf-8?B?SHBHWlVibHdpdDJtYnZOL1ZpS2M3UzBoQXp1blZTeHcvNkU0RFNSa05XaGMw?=
 =?utf-8?B?YUZIMEFwdzFrdHJwU0RvM1haZ3lPSjdBa0p3d1d6Rm95OWliTEtYOFllQklD?=
 =?utf-8?B?OGhZbWNHWDBJK0UyRzZES2drTDc3MWQxeEhQLy93SVFEd2RMZmF6TjNxY0w3?=
 =?utf-8?B?dHM5dkpwOFBRbUVOUmRyT29Cb0lwcDl5T2lVa3o2NEpYSldjVzdGS2tNTW5p?=
 =?utf-8?Q?3yewCmxx92HqZDUwOUAaDn6yu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51035743-d331-4da8-c268-08dd873075a4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 15:13:55.9396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0fYANImuijs/qUDwicEB9jQ6SXCwKIJ8L+aAsmDJuOW1xjA52Mlxs2So2jm4ARk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836

On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
> The functions hugepage_global_{enabled,always}() are currently only used =
in
> mm/huge_memory.c, so we can move them to mm/internal.h. They will also be
> exposed for BPF hooking in a future change.

Why cannot BPF include huge_mm.h instead?

>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/huge_mm.h | 54 +----------------------------------------
>  mm/huge_memory.c        | 46 ++++++++++++++++++++++++++++++++---
>  mm/internal.h           | 14 +++++++++++
>  3 files changed, 57 insertions(+), 57 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e893d546a49f..5e92db48fc99 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -177,19 +177,6 @@ extern unsigned long huge_anon_orders_always;
>  extern unsigned long huge_anon_orders_madvise;
>  extern unsigned long huge_anon_orders_inherit;
> =20
> -static inline bool hugepage_global_enabled(void)
> -{
> -	return transparent_hugepage_flags &
> -			((1<<TRANSPARENT_HUGEPAGE_FLAG) |
> -			(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
> -}
> -
> -static inline bool hugepage_global_always(void)
> -{
> -	return transparent_hugepage_flags &
> -			(1<<TRANSPARENT_HUGEPAGE_FLAG);
> -}
> -
>  static inline int highest_order(unsigned long orders)
>  {
>  	return fls_long(orders) - 1;
> @@ -260,49 +247,10 @@ static inline unsigned long thp_vma_suitable_orders=
(struct vm_area_struct *vma,
>  	return orders;
>  }
> =20
> -unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> -					 unsigned long vm_flags,
> -					 unsigned long tva_flags,
> -					 unsigned long orders);
> -
> -/**
> - * thp_vma_allowable_orders - determine hugepage orders that are allowed=
 for vma
> - * @vma:  the vm area to check
> - * @vm_flags: use these vm_flags instead of vma->vm_flags
> - * @tva_flags: Which TVA flags to honour
> - * @orders: bitfield of all orders to consider
> - *
> - * Calculates the intersection of the requested hugepage orders and the =
allowed
> - * hugepage orders for the provided vma. Permitted orders are encoded as=
 a set
> - * bit at the corresponding bit position (bit-2 corresponds to order-2, =
bit-3
> - * corresponds to order-3, etc). Order-0 is never considered a hugepage =
order.
> - *
> - * Return: bitfield of orders allowed for hugepage in the vma. 0 if no h=
ugepage
> - * orders are allowed.
> - */
> -static inline
>  unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  				       unsigned long vm_flags,
>  				       unsigned long tva_flags,
> -				       unsigned long orders)
> -{
> -	/* Optimization to check if required orders are enabled early. */
> -	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
> -		unsigned long mask =3D READ_ONCE(huge_anon_orders_always);
> -
> -		if (vm_flags & VM_HUGEPAGE)
> -			mask |=3D READ_ONCE(huge_anon_orders_madvise);
> -		if (hugepage_global_always() ||
> -		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
> -			mask |=3D READ_ONCE(huge_anon_orders_inherit);
> -
> -		orders &=3D mask;
> -		if (!orders)
> -			return 0;
> -	}
> -
> -	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
> -}
> +				       unsigned long orders);
> =20
>  struct thpsize {
>  	struct kobject kobj;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2a47682d1ab7..39afa14af2f2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -98,10 +98,10 @@ static inline bool file_thp_enabled(struct vm_area_st=
ruct *vma)
>  	return !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
>  }
> =20
> -unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> -					 unsigned long vm_flags,
> -					 unsigned long tva_flags,
> -					 unsigned long orders)
> +static unsigned long __thp_vma_allowable_orders(struct vm_area_struct *v=
ma,
> +						unsigned long vm_flags,
> +						unsigned long tva_flags,
> +						unsigned long orders)
>  {
>  	bool smaps =3D tva_flags & TVA_SMAPS;
>  	bool in_pf =3D tva_flags & TVA_IN_PF;
> @@ -208,6 +208,44 @@ unsigned long __thp_vma_allowable_orders(struct vm_a=
rea_struct *vma,
>  	return orders;
>  }
> =20
> +/**
> + * thp_vma_allowable_orders - determine hugepage orders that are allowed=
 for vma
> + * @vma:  the vm area to check
> + * @vm_flags: use these vm_flags instead of vma->vm_flags
> + * @tva_flags: Which TVA flags to honour
> + * @orders: bitfield of all orders to consider
> + *
> + * Calculates the intersection of the requested hugepage orders and the =
allowed
> + * hugepage orders for the provided vma. Permitted orders are encoded as=
 a set
> + * bit at the corresponding bit position (bit-2 corresponds to order-2, =
bit-3
> + * corresponds to order-3, etc). Order-0 is never considered a hugepage =
order.
> + *
> + * Return: bitfield of orders allowed for hugepage in the vma. 0 if no h=
ugepage
> + * orders are allowed.
> + */
> +unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
> +				       unsigned long vm_flags,
> +				       unsigned long tva_flags,
> +				       unsigned long orders)
> +{
> +	/* Optimization to check if required orders are enabled early. */
> +	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
> +		unsigned long mask =3D READ_ONCE(huge_anon_orders_always);
> +
> +		if (vm_flags & VM_HUGEPAGE)
> +			mask |=3D READ_ONCE(huge_anon_orders_madvise);
> +		if (hugepage_global_always() ||
> +		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
> +			mask |=3D READ_ONCE(huge_anon_orders_inherit);
> +
> +		orders &=3D mask;
> +		if (!orders)
> +			return 0;
> +	}
> +
> +	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
> +}
> +
>  static bool get_huge_zero_page(void)
>  {
>  	struct folio *zero_folio;
> diff --git a/mm/internal.h b/mm/internal.h
> index e9695baa5922..462d85c2ba7b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1625,5 +1625,19 @@ static inline bool reclaim_pt_is_enabled(unsigned =
long start, unsigned long end,
>  }
>  #endif /* CONFIG_PT_RECLAIM */
> =20
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static inline bool hugepage_global_enabled(void)
> +{
> +	return transparent_hugepage_flags &
> +			((1<<TRANSPARENT_HUGEPAGE_FLAG) |
> +			(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
> +}
> +
> +static inline bool hugepage_global_always(void)
> +{
> +	return transparent_hugepage_flags &
> +			(1<<TRANSPARENT_HUGEPAGE_FLAG);
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> =20
>  #endif	/* __MM_INTERNAL_H */




--=20
Best Regards,
Yan, Zi


