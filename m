Return-Path: <bpf+bounces-44506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1E79C3CD9
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 12:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAD3281239
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55207188721;
	Mon, 11 Nov 2024 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ffZqxohX"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466421553BB;
	Mon, 11 Nov 2024 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323885; cv=fail; b=ijKwausCf7SaMJxFUbXxBoep19Ceqcn/gr55WjYQ+JfEY9+ava7bQhMJrOAhr0oTj8cbg/1GciJmVOoaE+nc7KRV+EutOEjatP77AwNi1km47u9uTYq4aIN5ihbcCKfa+XBKCLTk5ys9uvfrVjazPaAuiAjA04/ZUYDQqWU8w5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323885; c=relaxed/simple;
	bh=y2rWPZFOF+CgpCC/i240sVSH+kiEXtrQeduLTjzBAoY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N9lYkj1YAqCv9A5lBCiloTRsyEu+1Wv3vDwMZUqYwLIJLdOS/8SzhidGT37PKc2Kb3xaQXGvhZQOv5M93OTnAq8e0WGHtaEKagQYdBDY5782e+qM69Aqn1X06E+WQU7k6qVb8Ncm8qJVpI8+GkOhrxXeFYoRY9VjX5m1FO7N+SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ffZqxohX; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8vltFX5jSILB0DB7jKmZuk60tPO8yQfMDhHRckStGtge7wZaiJ07DlOV4oTkghDn4QmOM2xQ73GdTvUCDPYdc0BDafVUj2WKpmfIFHUjMFCp4x3kxMGoSkB/w88jy0ZplbzTYeEWSfkQOqz8uq4gsz0A38Xeu7GlDiVRVTqJWx2MYWSdNA+iWHKIOMJ1A8hnezbjuOg+IXGR1W1iKCuEPE3TgfsKSXfXfLngtIxB/OQTNMlDr5VK7I7M4o6xJ8MoXrBNj/paR/+gK2CqfWAnCN7UiEfJmci9BY55yzWyH2JjeKyYv/7ij/7ppvyXMeZGBBIpqMGJ9SoKuqXMEZZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0UKT338STAw6DMb5yA1i8k87AdgEWc2GYpqlfdzFXo=;
 b=B204qAHTiYLyiQL8HzCbtIpj61aAO2jr5iQKtDSYcebVwkkpBJFXTRsmBBuo+2xyICAI+BYbw6tEYE2leeYMCPMomN1UMb7aTgLa99GEnuken1C6xLM2ExFkFvFKC4wg1STH10t8FhJqxGQSmpR++eN47XMClJHft1ih7b4Ad+fkHxFhl1bPPAshvaHd2uUp3mlsIlbsBL7As21+BhCpUB7/PMt90DljQLRwFj7qU54msGiixy969z0QK8ohC3iQh9ohvxmU2b+ZWfbJiPu5CbNbiJ8Vax60uuLZ6EM9M4JgnfapxVNJaGPlyURBCj9jvPexkN00tGI0ywMbTGF0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0UKT338STAw6DMb5yA1i8k87AdgEWc2GYpqlfdzFXo=;
 b=ffZqxohXhnrElpG0hPae8KlOSQ+lV6FVHgDyzlVA2fC8Hwos/COLWF0e+1aEz3NKzzmqVnLPJH6kN+ZsCW0reS9E5mqtxlWMq/gOXRzVMdr66gPDnZnMBe8UEx4scMG9g8Aceu8DjkICFTbrNCG/enuHL16qhdkqcAc/eG6EDkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 11:18:01 +0000
Received: from CY5PR12MB6599.namprd12.prod.outlook.com
 ([fe80::e369:4d69:ab4:1ba0]) by CY5PR12MB6599.namprd12.prod.outlook.com
 ([fe80::e369:4d69:ab4:1ba0%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 11:18:00 +0000
Message-ID: <d07e8f4a-d5ff-4c8e-8e61-50db285c57e9@amd.com>
Date: Mon, 11 Nov 2024 16:47:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 08/15] srcu: Add srcu_read_lock_lite() and
 srcu_read_unlock_lite()
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 kernel test robot <oliver.sang@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
 <20241015161112.442758-8-paulmck@kernel.org>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241015161112.442758-8-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::8) To CY5PR12MB6599.namprd12.prod.outlook.com
 (2603:10b6:930:41::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6599:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf6486c-3dbb-4406-efbb-08dd02428060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW9xdDIweXluN29MeVV0bTNHZGQ4YlhuS2RMdi9TV2t6Qk9JK1BIQi9XYXgx?=
 =?utf-8?B?QjVFM1RvSTNscmtpTEtwL05hV0J1NGF0TFcycWt5ekVOdE1CVXoydFlMc0R5?=
 =?utf-8?B?RzhURTZLb3JJYVp6U3gzSDNMcjJkYzZTeGlxUDRzaFQ0UkM3QWU2KzhodnNt?=
 =?utf-8?B?TDl5b3p6ZldHenNvMmZRNXpXNktNSlZuRm9DNytrajg0WndDamtvMnFKaDRl?=
 =?utf-8?B?dUpzK3J6MzFUYUp3TEUyd2t1REpqWWtNMkphb24wbUVadkdGN1dlTG9PekJW?=
 =?utf-8?B?Y2ZPR2lGcVdKYmFnWlJZMUo0NStSZ1ZyaUVoQWtMQXdDWG9qZklXMEpQR1NU?=
 =?utf-8?B?eFJFUS8rSDBxa3BUdnhnQ3I2cldwbGNieEZWNUZmR21aOUZFb2V4dm1qUkJp?=
 =?utf-8?B?WHhCblk1K3AxVGlUTmlKSXpjMEwwS0lUQXhrSDU2RzJGY2duajJQYmpncGo1?=
 =?utf-8?B?SW16S3hYRHNYN3NtV09oN3hnYUJ4NDhrQ2srcWNTdkU2N1NsKzQzbVNkaVlI?=
 =?utf-8?B?VlJwVmdZVVpDZlo3c0hpV2hyVFJ0cHFTdEJWemJOekIvbGxIVE9TTWgzM2VH?=
 =?utf-8?B?Z1pocExqNU80RXc4d1ZqREFVemFLRFhJamJ5WHNyQ2FyaFdZRHdNZkhjRG92?=
 =?utf-8?B?NjJrSEpTcldDdDNpQzFaS00zVVo5Zmd0Y0oyN3J2bndFSG8yaVhOTEwvbjJa?=
 =?utf-8?B?TTk1eXUyelhvelBqMFNmajcyNkxkbVFTSzFMNXdlQVM2NVI3ZjVNNU9pUGc0?=
 =?utf-8?B?VStmcE9IUUQwMTM2bGZPbkdxYlZaSVMwTkVrQ0dBQVBDQjhOdk9KUFpjZzlI?=
 =?utf-8?B?ZmFhWUVDOVREYTdhNitOWGhsamo0WGthbUpramI0bUZqekR3aHZRRkhVMnRR?=
 =?utf-8?B?d2tUS01zVGRNMlFSMEtwODJaS3RkTFJBT0hXUWxCRStMYXhlWndaNVNxYXJx?=
 =?utf-8?B?U2V2QnNqak5laXVRNUx5Snc5bnFxQ01OdEdUSFFFY3IzSTR6c1dMdWNVcnJL?=
 =?utf-8?B?ekFja0tCTUdpQStpNHN6NThDbGJTTGl4amhRd0VlbEFmNEl1eVQ1aUxzNlJD?=
 =?utf-8?B?TnAydWliY1hmTUhBZlBPbHViTFcwckxwRDltMzVRSStmU2JCUnZ1UEpuU000?=
 =?utf-8?B?RTI3c3krQUp6TXRyeU1KaHlnd0pSN25ZNUZMN0M4VEdzUUFxZDA1ZHhXNitD?=
 =?utf-8?B?cWxMQ0YrRW50UUs2MjJDa1JVMGFVTUdwWFpEVmF0VFRlbkJOeHpYMWYxeDJn?=
 =?utf-8?B?dkJNUEV6TXZYb2w0eU5FUHJNcSs0blB6VHpQbWcyaENLamUxTUdCcVB1d1pm?=
 =?utf-8?B?V3l2UDZ5Y1RKMVhRZGJmWi9KSHl3aDNWRzFlYkJQZkd1TnJCRmlJRjkwNWNk?=
 =?utf-8?B?cyswUXRCMjhKNGRBdnR2ekxRQ3FoMjg5eGpYWkkwTklUdUJHL3RML3Y4emRz?=
 =?utf-8?B?ZDRqcTBHV1laZFYrdDFHVmFEQXpuUFYxc1dIcDR5NFhJVUpqVGhvVHZnN1pO?=
 =?utf-8?B?VEJ5YVU5UWs2blplM2ppSDJqYmNDK3MzVm5KOXlPMWFybm1FeFRCNlRaNVlr?=
 =?utf-8?B?cE5hRG5ZRFgzUmVZVWhZaEFhampBbEQwelZzL2cyZEM3MElZcm8yQmxsbUFS?=
 =?utf-8?B?UTdWbEI5b0p1VGtsc2R0V2lPSHpCVEZJcE9JZjhtRTNHVXp1Q1BGa1lHVUcw?=
 =?utf-8?B?WlNGZTRCTmh1MEdNY0t4TXY4Z3NsaHZqbDZIeE80LzhyNTE5MTlHS1VoNjBK?=
 =?utf-8?Q?2jPhP8I2yA9QHR1oNErJ7zng+WuG8g105xYiy8W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkJ3MXBhTTlvTVVXTXp6anRpSW9BUGRTcjNONFZId1hBVElKV083cGJsZFdE?=
 =?utf-8?B?Ri9vK3l4NUJzV1MzVW1Dd04zT2VvYk9KR2FML05tem1iTUZydGZHWCtJTjFq?=
 =?utf-8?B?VTFuOGQ2Q0RBTVJONGp5NkFlQk1CQldHUjZ6MHk1OWZSUG9RaG50dEU4UXhL?=
 =?utf-8?B?UUVweEw0Z2FTNFNkWUFlZGluMzQzTXh0Tjhqa3B6SmZxZVRReE4vS0x1aHF0?=
 =?utf-8?B?SjR5Mk1oV1k5Ym1IM2RrMVhOV3djYVQ2R2xkNW1pRnhuWTliQm83TDhuYWN4?=
 =?utf-8?B?Qy9rS2F1WXhHRE4wNTdiTEozamo5emE2SGpFL0tXNzBXcXN1dGw1bE1Rdllh?=
 =?utf-8?B?N3pkTEx1ck9nL2lNSmJXczZyYVloQ05LZG1QMlRKcmRONFFlTW5rSkFGMUZ1?=
 =?utf-8?B?bVY4NUovMVpzZWl3eGw1Z05wYVpTM3ZLZ01JNytBV3JXdUJkQ1phamd6QTFn?=
 =?utf-8?B?bTR3VmVzVFllNGpJbExxOU1jcDJhWllnc3JaTHdNSWpzYnJjQVgzcU93WTBK?=
 =?utf-8?B?SHlqUGRObHY3YXIzV2NqTTludEhZVlhQK2RlYmpUUXp2WjBVRGRJQkFwOVpz?=
 =?utf-8?B?MGY4Q20vZ1JnVk5iSllNM0x3SUtzbm1EU0dwN2JEeUhsa3NwL3QxSENvRWRO?=
 =?utf-8?B?V3BpOHNORTFUdWJydlFieFBZdEx5QUl2NnJjY2VrUE5yOEYrRVVhcXZ5ZDNS?=
 =?utf-8?B?enNTTWpLcnBWbVlIZ2FJL0c4ZmJFV2d4K2ZFeDgxeWV6OVk2T2xzYUc1dm9Q?=
 =?utf-8?B?NHFtMnpkOXVmdHpSV3FjcnZpTnN2V2NxYjMxa20zemVRaitZVi9ZUlB4WnQw?=
 =?utf-8?B?eUF2amF5U0kzcUkyUm95M1dSczNNN3EwQkY3dnY5djY4MkVCVW1vaWhyd2ND?=
 =?utf-8?B?SXdXVTc5NGlEeWFCaUszbkhWcE14T0gxWURqWStGWHpxNktrVUpHaTVZK01z?=
 =?utf-8?B?NW5SVG44LzhsOG05L3hwQjV0Q1h2MytLRGlFTUhaeVVpd3FuV2p1cWxJNzJk?=
 =?utf-8?B?ZFVwc3duSitYcUR2UkRhTHVqTlljaUozK3IyUjFhZHg2d2MxQ0dLM1MxYmJT?=
 =?utf-8?B?RmJaYzBCcFZ2SWJoT2ZRVUlrdURqMHlhTFBnZ05BVHV2QS9jd3RoZ3NKVmdK?=
 =?utf-8?B?OWxEVjExeVFNMmdTR3d5MkkvcU9qbDNpVzJzR1N4K2dEM0dLZkNZdDdac3Bu?=
 =?utf-8?B?OGRxTEY1TElQRC9UMUNTQjA2YkpCY0tkRzdvVGtOS1FPUWdySVhCVHZ4Z3BJ?=
 =?utf-8?B?ZklBeWhqcWdrVUlnb2Y1R0tHaFlwV3ZPczNwanJCTEM0Z2lyYTBSQ21tQmFu?=
 =?utf-8?B?RmZoNXFVMFlWTUR0QTN0RXdFMUtCQ2M2c204TUhtdmZWN3luQklOY2ZJQlBi?=
 =?utf-8?B?dTkrcVBxTGRzRWpKN2NTYUNzZGNmUmRBYTJyTHE1QTk2SXpFTmFuZUVTdyta?=
 =?utf-8?B?K1Q1TkpsMDdaZ1dxSlArbWM2REhoNzROMzVqYnRXTitwcG55RHBVb01aSnNX?=
 =?utf-8?B?bmVVV3d5RndteEdJY0NuWG9JMFhBUkhOV0lpNGRHcmMyRFdkV204TWpJVmZa?=
 =?utf-8?B?ZjlNbXY1QjBFcU53WmYwRzFyb1p4WWxRRVNEQ2ROaUlpV0tVNkduRVoyQnVM?=
 =?utf-8?B?eWZXL2ZIOEhZbSs3MDQyVWZRSFN3NTNnbEtacHVjYXR4SnB2Njk1b210QTRy?=
 =?utf-8?B?dTR5VDNjUS9BY1ZvUE1nUVhxYnVvYzV1K2V2U3hmN2d4akQzZE1VUDlrZkNv?=
 =?utf-8?B?aWZmeVJYSC8xY0E5VUxYRXFlSHhJQnJ1WDRMdGpPOUN4dWMvdXU0NGhhYXdj?=
 =?utf-8?B?WXA5NGhvOVdGNEJSQWliTkdtdlloekQweHQyckViUW9oN01kaWtTUnFJbGlB?=
 =?utf-8?B?bnQ0WVliTWpGRWtSV2pBbmpkWkFMNmlJMllDVU9PSjFwcEtFcFFFdFNRZm0r?=
 =?utf-8?B?NzdzZlkzSDRiRzgxdk13ZVA0bnBDbHhUV1FsYUVPRFdIWUp4M2ZKZC8wWnJi?=
 =?utf-8?B?OExlSUdRbUNzanVDK3hIdG1jS1hLaUZoQmoySmovT2NLL2ZyRmF5TTFnZStM?=
 =?utf-8?B?KzB4Vm5XQmRWeVUydW9wOUNJYWg5R1VpZXBSWkJjQjJoVGNkUERNZEE0OVVx?=
 =?utf-8?Q?lEDcAwwdmYFayJnO7Kl6aG9Lg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf6486c-3dbb-4406-efbb-08dd02428060
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:18:00.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQyt69HdsB0Hir/1H/3BB1679D81rN1X8y3TyVcxM1gsdzVRnC7H7HcqiQvwXCzR8OLOR2osTnlMd9dtUJLOsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574

 
> +/**
> + * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
> + * @ssp: srcu_struct in which to unregister the old reader.
> + * @idx: return value from corresponding srcu_read_lock().
> + *
> + * Exit a light-weight SRCU read-side critical section.
> + */
> +static inline void srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
> +	__releases(ssp)
> +{
> +	WARN_ON_ONCE(idx & ~0x1);
> +	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
> +	srcu_lock_release(&ssp->dep_map);
> +	__srcu_read_unlock(ssp, idx);

s/__srcu_read_unlock/__srcu_read_unlock_lite/ ?


- Neeraj

> +}
> +
>  /**


