Return-Path: <bpf+bounces-73988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC6C41DCD
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 23:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78D254E06D3
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 22:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B2F3019DE;
	Fri,  7 Nov 2025 22:49:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021074.outbound.protection.outlook.com [52.101.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE36721257A;
	Fri,  7 Nov 2025 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555766; cv=fail; b=dn8lR6fSRs34l/BmEaeTlTPwpiK8lzTmU2Cb/imzjUO4htJMkzMbHDGfAeDyqh1+5OEnPJoRURKufeKsDDZf52Kqv2RncMdFdQD1LSOsoKzg5PVUkTfRsyMoXWCBhSgR8mAD7IQIJ1ABcv3JfaA87maGmDzq05H2782SsaYEUJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555766; c=relaxed/simple;
	bh=kiutZtLJHhiiDVstGuTDdr85rzjjZYGDD9QSh8jhJnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tLY/5vjEjwyw+gVG3v3n25z9YhAaXajWSc1tbAk/00eAnAA6L4E1VRM8XXvokQdAmbTXsXKiYm+lhnewFKeVRseS1J/p4+ACVRgUHaPrhy6ZJHVCAqv8PCylR13yuSIanb9gIAVCkhA5UXgT5HpLDMdP6nFF+jf+n7M06FoQ5dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scYlIby7pXbvEIeDnyWGH10kEKPXnM/HrjM/HoLgl5bzl8PiQX83bdejGnotvP2dljE2KD+QzDYH6kNw/IqI2C2ExaY9HLNEGsMBWbt5BT2NRLPX63xn6wT8u8rZv3DKHJ7gsJMyiAjdWQMGUxghmM/pLPRMCTxuDRBx9XE2N96gCTdufHNVgzzYQZtTfZxehiDnWZXq4/9qFdKJK40wYIpW88ze+xkuN2Md4wveoVBp+7FaJOP4d/IW8iOY5j9bPTzH9yzErj9pQjJa5fFKAVUXRbMYA2rhsJH5IbAJf6Ki0BMuWpu1UJQBC51qW74w2LycpZs2uheBQORcpjKwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpZ31menD50kmAWcDJoJDgKGHdA1/212kU/791zVvFg=;
 b=IhJJflIKW0Ezj4iwZa53YTuWlZnFMFbrKyu9EoRIUtXbZuaBV/8iqlG5ZC+D9deOTK2VAsIS34yy7fbfe4t49sW69BscK0vZ+r7NUxfhsZUbt3X7u8rhOMJS1G9Oqxj+RwUoxZb+6PE/UVOIqFX7FLr0uK93Uy8WHj5wb4tAmJ5QF9MhbSSmr0urW18pfJpJvJHDAq9Vo5qRSzQm/zqzkv3wJ4bFNCoelV2EApgV/0gW8tYsd/17+Bat+WjjaKv8ibpCcUhXr00tDxxN/Qnvw3xH/A40dz9CEbBMXPkJspHDfHbv4BoD70osKYZyTuV60Y/AQ49SO8yd6GoX8dCwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:be::10)
 by LO0P123MB6688.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 22:49:21 +0000
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8242:da40:efa0:8375]) by LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8242:da40:efa0:8375%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 22:49:21 +0000
Date: Fri, 7 Nov 2025 17:49:11 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] kallsyms/ftrace: Set module buildid in
 ftrace_mod_address_lookup()
Message-ID: <vb2dmubct3kvbtzz7zlcslxie422khm2ngmu4jfcpnfcoztuvy@6oi6urgqvc6y>
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-5-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105142319.1139183-5-pmladek@suse.com>
X-ClientProxiedBy: BN9PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:408:112::18) To LOYP123MB3534.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:117::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P123MB3531:EE_|LO0P123MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: a59a6b91-fd86-484b-9ba2-08de1e4fe3a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TCszaWpBdDBibTFJOFB2TXZJcGp3RlBoTzJDb0ZEOGdUckszL29YM3k1aHhO?=
 =?utf-8?B?RFJMSGxWeElLNkgrcU9jYXYydFJodzJVaERTYWs4U3FwcERKWmZlTWVzSDBY?=
 =?utf-8?B?TkZEQmpUcitSRVFVMEp6emk3UmNQTWxucVdsdzNaV3J6Zkc5NTh1SkxSZWdM?=
 =?utf-8?B?ZGxNUmNmOE55QjExeDd4N2Z5elZLbG1Gd01YOUNlaTZIUlRpR2IvOUNNZjha?=
 =?utf-8?B?TEtFTFo2a2dyNUZ1Y1lVRjVpbkNibmJmRWJuSkR5TDUwQzJpNVl0Vit2WlB0?=
 =?utf-8?B?ZW5jbUJwWk1iZmw2ZEd0L1c4KzVxTzRxeHdWM21kblN5S3NFVXdMaDcyelZV?=
 =?utf-8?B?TktqVDNiRWJYdzJSdXZDTnMycmdmWGgwZ1Qzb3g4UVFLcXpEL1BKNkxYa0V3?=
 =?utf-8?B?c1FpOW40clBIMUJpaThpNVZrYXpDa3hqTXpNblhWT2lJR3VFZWxQNGdOM1JM?=
 =?utf-8?B?aStsNmJJZWIvSDc3U0FsUjNna3NUKzhHUGIvQmlrOFJnUXZ1dFlGSFR2UmRu?=
 =?utf-8?B?VksxT3VITmJQeVJBenJmbzBaazNIdGorUlZrZ200L1EwSWZDVEY0QXozUXk4?=
 =?utf-8?B?YzZxT00xeStVVmErL3Q0TzUzZzRPU1NZd2FpMkUxb2M3ekhFdXlsMHFpd0dG?=
 =?utf-8?B?dnFwa0ZVMmFhWVMzYk5wZTNDakNLZVJTeGVqTmtUbzhSWVI3UTlxLy9vWitG?=
 =?utf-8?B?WHFRbk5lM3pUVE9ieDB1K3N5TmErOTNwT0xNaGJ1UHdoM1ljMTB1QTRaNUZq?=
 =?utf-8?B?S21TTGlYdm1kMThJc0RTMGZIYUdZR3BvRm9wcDBxcDVQL2xjYmZUZzVxcVMv?=
 =?utf-8?B?OGpEVWttL2cxWWVpcmYydU5XZTlyUlc4MU9UbEViYkVyd3BUazh5Mm9DbXBE?=
 =?utf-8?B?b2ZweUtvRkpnNDErVmprSUlYZUxudUxxR3k0QXBzK0ZJUHcxWk9nNHR5Wkc4?=
 =?utf-8?B?UXhFMFd1dXNrMGx3TGlMckszNERVcmtCNVN2aVpaTmhZY3FvKzhseDVaTHhK?=
 =?utf-8?B?RndNU1NYc2Y3OGJqL0dPcWczU1FpeXVlSTE4SUFtaHYzWk1oZVExNGJ0Rll0?=
 =?utf-8?B?NUZIVVBSblczYkRmL2dvUU1DdGQwZWl1Wmh0UmwrclFvMHEyVUFTYVp3b2RF?=
 =?utf-8?B?K2pkZDQ0anZydjZuMWZjbldzWVltMDlwWDJyOFlyUTArRWJ0ZStqME80Wmtm?=
 =?utf-8?B?Z1VVeWtzQjM1N2VVNmJJbXdZWjNXQ3cwNFhOK2hNZU5qNDhHdG5sRkdUYldw?=
 =?utf-8?B?RjdYeTZkNng5NUFBbnZiaG1xRVJJUmdSQy9HOFp3cytTcERDM1p2NTNjQ0dP?=
 =?utf-8?B?MVBkeUJkTWVxWUptaVNsdklmT05VcjBsMFBsbEt2RGI0SVFtbDZaRjZxS2Ru?=
 =?utf-8?B?d0dTalBhVU8xSkdXQ0tuSEhvSjY3bElVMnpuTEphWm95RzN0TlVtVkdvaUp6?=
 =?utf-8?B?MktFYUlnRUpBUGdtMlI1WUNFTXN1a0NjenQ1SEpWbzQxY3c3RXd5UmF3UHcy?=
 =?utf-8?B?a1YxVW5WRit6YkFSbHV4Rzd1ZjdoSE1xSlFrUHh2VG5LMDM3cElOZ0l3T3N6?=
 =?utf-8?B?Z0ZlcUxMcFNxU2FicUNKYmVsdis1RlNRUTFzQ0tLOEdaZU9jS2tyTkdrMG82?=
 =?utf-8?B?M2VQRGptbGFDS0FJQ09nemxGejlTS3o1RkRWVWdyRTh6UlJlNXc3dzY2d3BE?=
 =?utf-8?B?OTZhT1pkZ2NGbWNiTXRzUm0rdTZMZnNLOWtYM20xMk9FclhuTDBpNzc0Qytn?=
 =?utf-8?B?MGJqenRQUG5XcHRlYVlRMng1MlRmQ3Z1cWdwaFlFSFN3K2IwZ3h5VTNaSTY1?=
 =?utf-8?B?bGZDWHkwVWtrMld1TE1kL3dwNWZtYlZkRk1qcFZtNURBRTAxK0lkaHBYZEd1?=
 =?utf-8?B?Unk2RFYvK3ZyN3phU0N5ZDFVZElEK2JxWkxzOXR0bCtmWk5tOFozUGRvakRS?=
 =?utf-8?Q?Yv0TUh73nBEenF5uDGZ+/WdCBJs5bNMj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGxwKzZzMzZNaVl2eUI4SkI2R3Nyby9RNi81MDdjNGRqa0gxamxLKzFDWXhD?=
 =?utf-8?B?TmZMMU52R3B6QUpsTUd5emg0RmpCU0tOeXJtWUwxek4wSkt0MTJsZ0tEd1g3?=
 =?utf-8?B?QVJreVRTZ1M3NkV5L2l1YUdjTy9ydnhING16blRienQ4cThLeG1zYXlaYkRZ?=
 =?utf-8?B?MzBSZGRzM0R5SnhUcGh2aTY0Ry9zZlMybkZ0L2IwZmYrcFZaemFTZkdmK0dZ?=
 =?utf-8?B?ckhnL1hIeGRKYlBZSlJxcTJTRWxJRUJxMmYvaEhLVS9QdklRQ2N4WjhmTG5x?=
 =?utf-8?B?SGJHK0hLZ1lNWmJkVTd1OSszby9JeFQ3TUdpUUVhUUV6ODhpeUxLOUw1Nkdk?=
 =?utf-8?B?bytNOW1FOXptSFNNaHM2cXdIbE14dU5SM05oTEFJMzE1OTBROHFKM1paNHQ1?=
 =?utf-8?B?Znl4T2FYZkwyQ1N0UUlzSFJWRzd4eVQxcTB5YWhBQ0kvTnNUVW1ud2xySVJP?=
 =?utf-8?B?V0Y1U3V6OEdkemFJcEdaYmpYSUYyUzczVkloeEN1Q1dOR3Q1WWc5cVVDVnlh?=
 =?utf-8?B?bEdkM25UV0JiUDFhVVNqdWtQVGFLb3hpWllBZDY5YlJFclZuV0hXdkRRV0R3?=
 =?utf-8?B?c0ZYaEtJSExjNEtnb1p4TVdsWm9kd2lIaWIwOFoyVDZxK3dlS0ZBNWR0VEg4?=
 =?utf-8?B?dGZmTWU3cFhsUFNXWXRCMGhsTnRzRmpRTmFCT0lVZlNpSy9YekNMZXl4YjdU?=
 =?utf-8?B?QVBDZUdabHFYUmlYR0g3NURjWlo5clErLzFaQTYxZUdMV2RzYUxzc1NJSnNJ?=
 =?utf-8?B?ZkxpbUVVd1M3SnYxMUh3MmpwQksrYVpOTkdBWjJkTC8wS2R1QWdjRzlVQlhl?=
 =?utf-8?B?dy9uZDBobGUvUlpaS1ZoV0d5TE0ybGpYTnhnR3lVTFNvSjVHdjdrN1dNYUor?=
 =?utf-8?B?Vm40cVo3TkFHcUlJRGlEbCtzVGkvRGxOTTZCcmpFaHVkRnUwUDJqZ2lUd29p?=
 =?utf-8?B?L3g5R3hTeUVsSnB6VmZiL1A2cTJiczZUZXltMG9vRGl5b3MrVC9La3EvMUtF?=
 =?utf-8?B?b1VXOFZOd1FHRGl2MlkyYUhhWnFJdHhmenZCVmhBa0hTSms0Z1k5TGtjR0Qz?=
 =?utf-8?B?clNHYUtNVVo2NERpeFJDSEFhMkoreUExcHdTSi83c2RYYThyZE1TUlc2RlVu?=
 =?utf-8?B?MHZQcHd2dWtKd215M2lwYUp4NFlsbnhha0UwY3YwMDJMVUVZanRtb0xJbmJJ?=
 =?utf-8?B?L3ZlcFVRWHBIQ1FId0ZhREN2NitiWnZ3ZUpXWkNjYUgxakpSZGQzdmRtUXM1?=
 =?utf-8?B?UVc2MWtRRjJWb2twRGRWVU9hMmNLTTB6ZlZyTTJhVEJBS3pkWXpQWjZtM21I?=
 =?utf-8?B?bDU3eEkrQ2wwekVQWkgvQm1neHVLQVJjRUxzMFIrbWRhUml2RlhFTHFrMG9k?=
 =?utf-8?B?V1FpczRta2pDUVM0SzZ5THNSNEpxT1M0RngwNlRPditIV2xGcWJUdy8yV1k0?=
 =?utf-8?B?dElIblpMcWxSdlZQcm50Wm1jRTMxZW1BaDFmVXVrakVoMG82eHRhQklPclIx?=
 =?utf-8?B?SGtsNjdjZW5iUWJJY1RiMTJmVnJQVWlZbmo2TjVFSG8zZzdwc0ptdE12eU4v?=
 =?utf-8?B?N1N5U2dEeU5vZSttL0RodGlMT2dKZERybXIySTRIZGNTM3pHWDZ5SmxnN1Vq?=
 =?utf-8?B?WTZ0R09PYTlFZDF2MlYyK2hTUktqWHZsMHZ1cGhxc1R0ZnU1U0REb3IxNWpJ?=
 =?utf-8?B?Z0hKR3lkRTdveFJ2SkdQUU0xVVM1Zk91YytJK0x4NDRWanZkUHR6N2IwT2xD?=
 =?utf-8?B?RmRhNStnWEthRGJJdG1icFJtV3EzMWtHclQwOURlY0ZWaFp0ZCtzNVNzMjdE?=
 =?utf-8?B?blNRMjNMMnU4VWpNWTF3dzlKdGJ4WVk2SllYdHMwWWcyZ3J5R2tQb2JhUWR2?=
 =?utf-8?B?aWJXMWkvUDJWb3h5SzA3SVB3WlE2bDJuY3V3cXg1YWN2Rzc5Tld0K3R3UDVT?=
 =?utf-8?B?Rmt5dUdGMWZ1ZGo0UmVoeUlTUXBIbDM0alRrTnorZGc1bzJFUUxXNjFOdkhp?=
 =?utf-8?B?Y0RSR0VuVjhoSU13S0lEbXZsQlF5MEo1WE9hV2FhL0x0ZFZhYWt6S1A0OWFs?=
 =?utf-8?B?K3o5YW05RGVKT0ZVcDF3M29PeUNrMlFWTW10UXNMT0MyVUVrblEwRW9UMGFU?=
 =?utf-8?Q?V8O/YgoFu3RnoUr4LNZtvg1cF?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59a6b91-fd86-484b-9ba2-08de1e4fe3a7
X-MS-Exchange-CrossTenant-AuthSource: LOYP123MB3534.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 22:49:21.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kyn/uurbRsAloNyzlbcVPaPkoH8dW8U0dCZ7LmFpubQlhhwHDkJEOK2D5mt4CPlmvmgVsFqaRxXCtTjz2n8Qsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6688

On Wed, Nov 05, 2025 at 03:23:16PM +0100, Petr Mladek wrote:
> __sprint_symbol() might access an invalid pointer when
> kallsyms_lookup_buildid() returns a symbol found by
> ftrace_mod_address_lookup().
> 
> The ftrace lookup function must set both @modname and @modbuildid
> the same way as module_address_lookup().
> 
> Fixes: 9294523e3768 ("module: add printk formats to add module build ID to stacktraces")
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/ftrace.h | 6 ++++--
>  kernel/kallsyms.c      | 4 ++--
>  kernel/trace/ftrace.c  | 5 ++++-
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 7ded7df6e9b5..a003cf1b32d0 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -87,11 +87,13 @@ struct ftrace_hash;
>  	defined(CONFIG_DYNAMIC_FTRACE)
>  int
>  ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
> -		   unsigned long *off, char **modname, char *sym);
> +			  unsigned long *off, char **modname,
> +			  const unsigned char **modbuildid, char *sym);
>  #else
>  static inline int
>  ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
> -		   unsigned long *off, char **modname, char *sym)
> +			  unsigned long *off, char **modname,
> +			  const unsigned char **modbuildid, char *sym)
>  {
>  	return 0;
>  }
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index efb12b077220..71868a76e9a1 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -378,8 +378,8 @@ static int kallsyms_lookup_buildid(unsigned long addr,
>  					 modname, modbuildid, namebuf);
>  
>  	if (!ret)
> -		ret = ftrace_mod_address_lookup(addr, symbolsize,
> -						offset, modname, namebuf);
> +		ret = ftrace_mod_address_lookup(addr, symbolsize, offset,
> +						modname, modbuildid, namebuf);
>  
>  	return ret;
>  }
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 42bd2ba68a82..11f5096fb60c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7678,7 +7678,8 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
>  
>  int
>  ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
> -		   unsigned long *off, char **modname, char *sym)
> +			  unsigned long *off, char **modname,
> +			  const unsigned char **modbuildid, char *sym)
>  {
>  	struct ftrace_mod_map *mod_map;
>  	int ret = 0;
> @@ -7690,6 +7691,8 @@ ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
>  		if (ret) {
>  			if (modname)
>  				*modname = mod_map->mod->name;
> +			if (modbuildid)
> +				*modbuildid = module_buildid(mod_map->mod);
>  			break;
>  		}
>  	}
> -- 
> 2.51.1
> 
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin

