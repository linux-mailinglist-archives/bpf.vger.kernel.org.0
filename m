Return-Path: <bpf+bounces-41845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3F99C549
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 11:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3857D1F26D2E
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9DC15C158;
	Mon, 14 Oct 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JxdbQLyU"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E58158558;
	Mon, 14 Oct 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897049; cv=fail; b=Y0gy1k/WEGT5Q4+dVS1eFkMa7iSytq+6SN79IITSOq0GQIeUkmbIRb0pNczz1AeNKbi15WSLSNGv5tbg0kH2dKcnz2TtjYeARbFWR8VbKlt++QyEIDeqeucfjfv3pSXqn+YaOOp43euoHcp+rXiOw+qwm3IFKKcqjc/VRREO5Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897049; c=relaxed/simple;
	bh=twhl2XMNEkhSOfSDhQvZFWsawB3SlVqeBEmXV9hmAIs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gLeuvRs7/DeRc6Agti4YB6/Ev9TCgCG3mTXgPOKjGj26mEu+Nphfns7bqJRgBOx8c1YnWWpNS3AzQOtyTUIiZuVISqg/XMHuuygV9HDJG/faaTF2l4cTC4IW4tWi1PXIKGZdE8niSY83kSSWYmL/dNQnYKJq8WgKtSC8dJmu/x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JxdbQLyU; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hM82Ifjl+xMl+7kBQgr6FdUNflTifFiUqB8RFqGxgYI7Qy24xw82iPGGU4pNWS2TW/8dQswMm8jz3cyyagDqImtdn2Nyxmh2HVgids3B5voDs3iPH9CeQGX3mKqldEp0qB5fQWbeUiOpvaqsLs1c3eN+M9H4k5mufhR67evf/+QauWFGv6kMx4pc/sH3vEStSsGnU5S/CHMIN6mLKTu7Uo6w4pIAqv/ZIF9AjgiCd8WAC2bSBAEasw3HV9ugoO+MjNBE8nfx7znmhPUrUFYzclGYq+IpMMeVx6Uj3hjHwO+oQdIaIRQp0fAgj0r+De5KS6ZjdSDgpRVEc+DpAq/x9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leQXKapewwnrBlLQKiDkdqhzZFLKayJESm890HxHiwI=;
 b=Vptw2+RjOUdu0323G6flCnMs1Aa7B72r6uN71RVUIUwveHnOsvH41mUYnUg+NaH4Z53kljQgQg9TltQ816WgoyCYdgbszlOg/YXfgkK9OkpKCaHG1/f+f8K5knmLeRvXqTmYbBP0tNtezt/58i97A5qV/ovJgyI/nwriEa85sgP1UZMDQ1aAYavmhDNJjCFSoexDFqx8dTfSslnr8XkA3nBA7oxAF4rfiTGb+yegeNFjPgjQn8j9wEPDUo0IInoo5NwM6mtFYnMv+tlQ5o3t/NqBwppylMzKCAoo82WLnErHdph/s74BbadWZRtQeESI0PMrzH4SvC+WjcTtLYALIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leQXKapewwnrBlLQKiDkdqhzZFLKayJESm890HxHiwI=;
 b=JxdbQLyUanHgfS7bq7siKd+Lb1XZBR3OYwJVDQFTvvi6xguRW2/3t3JHBMGhRcXun8S2nDSsm+9pQRjvJUbqZCWlcICG+oAOe/CapnOPItPwqZDDMWoxzubh+yXfFh7U5a4HYluu8earyhiaLlDwA/3mu0cXEE0Nv1rPdRr3+6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:10:44 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 09:10:44 +0000
Message-ID: <6853d494-0262-4a6a-b538-338695677f57@amd.com>
Date: Mon, 14 Oct 2024 14:40:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 03/12] srcu: Renaming in preparation for additional
 reader flavor
Content-Language: en-US
To: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
 rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-3-paulmck@kernel.org>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241009180719.778285-3-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::11) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: adcbdcb4-9ee9-41e1-02e0-08dcec30157c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QS80SisranBIMkt1a3RTNGpSK0Z1UXlYTktORTZrbmhFaEhabWdYRzRWdkZu?=
 =?utf-8?B?VFRFeElCQ3FxdEpzWklaSGxNYm1PdE5QTldlVitCVHNjdlRXZW5uMXFwZlNG?=
 =?utf-8?B?WDFZOC8vRzUvN0VGMlk1UEwxUDB0KzQ3cmlJcWV5RDhCQ3pYbEpBYUdFNVhS?=
 =?utf-8?B?Z2NJYVF6emxUTDBsU3IxZDR6M1B3ejdqTFFjU2ozb1gvQlRsRWwvRDZpWWc4?=
 =?utf-8?B?bFVGNSs3aXdvQXV3ekVQa1lVY0ZRTmQrQysrYUJhRDAxd3NFQWFIdkQ3cldD?=
 =?utf-8?B?aGpSaTlBbHhOSmdkMDhSOU1iSzlCTm15cDM5UGEvZFRMeWo5NXhPK0RxdTVK?=
 =?utf-8?B?cm14bTJWdTl2MnpSbEpLTWZUZ2hCbVZCR2c0N3YzbjlpZU5XT3B3UWIyTHZW?=
 =?utf-8?B?M2JpL1dBVDBrUzZUQXIvTkZCMTZpVUxaSVp0Um5vSzFENGx5Q1h5a0VvYmln?=
 =?utf-8?B?bW56U0RDc3pMTlZQY2hhOTJBemFJelJhWlVsMGhiRVdUbElDdHdNeGFZakxV?=
 =?utf-8?B?V0hUUU5sUDM1QklJNWpFem1SSkRML0k5eVRmTU11T0VMcDNVS0NIb3VUQnQr?=
 =?utf-8?B?ZkExeWxyQUpYRzBRR1F1MmxKMjhpNVlMSTI4VVBTc1RlUENnRk9TMldUUFdH?=
 =?utf-8?B?SENoUXF0RTdFMjE2NHhFTWd4a1FpZ1FYYXh6Q0VQd0NqejZJNlpYbHB0MVVk?=
 =?utf-8?B?WWFsQ1UwTWdHRzRISUJ4QUcrNjNpSEk5eWhRYksyS1QyQS9mMGNCVGl3UVpk?=
 =?utf-8?B?OG03Z1NLeHFWTzlTOTBrYUpia0ZRYys2bVMxdzNPTHBZcWVlR2p4N0s2dklH?=
 =?utf-8?B?ZExYMGUwbGYvbUU5UEo0dlJjb09QbURSZzdOME9CN05nMEFNa245T1k1d2Zp?=
 =?utf-8?B?S1hpMG9RQWtHekxDWi82VjAvek5Vak9OdnBZSlF3UkZSM0QxOW1abHByaE5n?=
 =?utf-8?B?RGY5RUViZU9PYk90K1ZvckQ1RElpclRxbWNya2dudm8rYkNUSDNtRHVDWFVk?=
 =?utf-8?B?MjN4UnkxMkwyZmNlRGd0L25TR3hPd2lFcXpoL3FPR3dDb2pJVlRVUmM2WWky?=
 =?utf-8?B?dE16L21nbklVYU5Pb2VhamhBLy9Lajl4ZE5OVUtTTUJYSjZaUFNwOXB3WXpU?=
 =?utf-8?B?cDluYTdiTVBqVWFNVGZWVkFjNk5wSCtJZU9KeGNGZnlDTEJJNVVtYmRHeWdH?=
 =?utf-8?B?QVp3VU90VGRIUzJQZ1JLcGh3Wlk1UjBjRks5OU1lWGgzWXpUcjZjS3BqODB6?=
 =?utf-8?B?Z1VKQkE0OWlscnZRSWJzMkQycjFyTEthRnFKZmRWNmhOQWh3L1NZVjlYUWNi?=
 =?utf-8?B?enBjd2hPQTJncDZNRUs2ZDI3NzNNeFYvMkkwY0F5TWEweDVHSERpdkEvTncx?=
 =?utf-8?B?NFg2SnhlTDRSK25vNEo2bVFVSEt5cVRjU3lIMzBRLzBIK1BVRHR4YTdrcGdZ?=
 =?utf-8?B?cVV0RzFHMDQ5c2QzY0x2dllZOFhsNTRuRjUrMnRDSjZNRFMwcWI4N2hJQllr?=
 =?utf-8?B?bmNxV0Y2WGZESEMvemI3V0Z4aktxdlhJM3VTcEJXeGFHUHAvbzNPR2pqSkN4?=
 =?utf-8?B?L2pESVh1SU5WWVIzRDk1RHpTenErNkdjaWJPeWRxa2pVaXJhQUFtMEZETkg4?=
 =?utf-8?B?aEIxNTVmNjB5c2JoMCtKQTRGTVRTZE1oTWFqWk9OQlQvaWxYZ3lGZXNlMC9Z?=
 =?utf-8?B?b3dsYXNRVjZldDJBSDRGclJrMkZ2UUtTN0o0STk2cEZPUWVKSmg4UVNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFdWS0RWZzRpZEVtdVJjSUhiZmZ0S3NRS09YQ1hXaWJyZU1pd3VpWDA4MDk4?=
 =?utf-8?B?akZTUXFjcDVibGtRZFVVOEs3c3Q4d08rMUNRNEhwcDBFL1RZdk1YTmtTNlhS?=
 =?utf-8?B?bkd6eFg0R3lvMUZ1eFp5dUhkNTVrTWpLekVUOGxpRWZ3WHM3Zko4MXMrY1My?=
 =?utf-8?B?dHJwUFAxSFZUcTlYbkRiQzVHbDdBTzBmMUo1VkdveCszL3hSYUw4akN1Y3Qx?=
 =?utf-8?B?cTNXeEpXSnVFTEozdkJld0w4R2x6UHJ0b01rV1lUZWE2Wm1vdnJYRGFQQlVl?=
 =?utf-8?B?YlJDbCtoTFkzZ2dHMkNKbFNSUlBRaU0rOVRxU0hOSUFEZE5YS2dnMzQ5SEhy?=
 =?utf-8?B?VjFwVm9scm9pYm9CRk5zVmMzbFBpWmw2VHEvNWtrb2hWUzEwTGo3eWNlc0pm?=
 =?utf-8?B?NUY3SFljRFlIVWJxKzZTNTlKdWM4VjJEVVFVYjhQNDNjcjFvdUpUM3lXRCtl?=
 =?utf-8?B?bUlSWU5TUFJNcWMySW5CWXRhNHpLWFZqKzkwRXgvbTkwRTZaZFFwbVFNVDRz?=
 =?utf-8?B?RldCWjgrUDBiVEF0dEU3aDgrbUx3WnpDY3dZUlM5enZUSVo3Mm1kNTFRYVpE?=
 =?utf-8?B?YTJrVlVFMXFsc2tab2dJNFF1NTlzcERkUEEydUplYWZLeWV4M3o1U1lZYXVq?=
 =?utf-8?B?UHFBcG80WUhhYkNoTUxlSW1QVXRxaHFrSExZdHU4amt6bUwraWUwMitUa2Yy?=
 =?utf-8?B?TmdlMGJhcGFFK2ZnSUtVbjNRQlVSOWtjYlZ5SWo1eUJ6RTJEa0I3dzljZ2ZD?=
 =?utf-8?B?T2M2ZDVjaW91Ui9ISUJVdkxSOS9rWHRTRGloemRFakhkRWRlbE9PWTRVdkl0?=
 =?utf-8?B?L0h2YWoyMUNTSy9yNkRWa0ZOakJkSi9VUjZ3bjk5Q2tTOWVVNU5NbUlvT2VB?=
 =?utf-8?B?VFdzRHlMei9rVmQ1WEZGWStzcWpQSTVaZERqK3IybWVBdy81VmxYeENDOTBC?=
 =?utf-8?B?QUtwTm9CL2FxY2IxOHU4T3I5ckZxbHVJNHpLcUJDZ1I1WjFROTN3SWQ5MCtH?=
 =?utf-8?B?bG1zVkZwMXBHalJvZ1NPQ0gvWFJXQ1IvcEVqbWRYbnM4cU9ac1FFQUhUUEFL?=
 =?utf-8?B?d0dWZk10cTVBN1hhWnJtalZsdjZJQUo0SVlkSjY1MXhJWWhDTkx0Q2R6RGhI?=
 =?utf-8?B?WXJITTlydFBrWFg0N3hhY1ozTGVHT1pVcGo5WHlqd1U3KzM2M0NlSVIrNk9h?=
 =?utf-8?B?VEh1YUQwMVRVU1EzenNxNlhYSnpXNnVCUzdCVXBwbjAvQ1RiYWptUTYxeTFM?=
 =?utf-8?B?Q09aNTdEWFBvb0FPU0lFNDBBWWxpZkhtOEZ3bGUySVFiV3gzVEllbnl5NnY5?=
 =?utf-8?B?UVVYcE81cVdrMTV5bmpFUmJodEpOTjQwcXVEN0hCYWFDWG50U2hqckdQa0k4?=
 =?utf-8?B?WjNBZW5mQ3I0bmwySGt1RWxDK2xIQ3Y4YW1zaXdxWk5KYmFSWGcvNWY0U3oy?=
 =?utf-8?B?OGo4cFFzbXZyZU5Tb1R4VG5QSXJVZVdRbHpPd3NQTFJuQkJsaWVzSzJsckgz?=
 =?utf-8?B?Q3gxVzR3eWlBTGp0c3h2dTgrUU9FcDA2S0IyLzc5ajJUbE4zOHZobjdUdUVh?=
 =?utf-8?B?UWNwV2NkNHlXU0NSOGE3WmhJakdleXlsb1VMaDFCQm5wYzhJTy82dUlGb29j?=
 =?utf-8?B?V1VWemhQYld4N0ZOMzM3VkxCZlY5VVFnRExpOE52VkgzRzFSSGNiUFZCWGhP?=
 =?utf-8?B?ZGx0Q3VnRHN4YlAzU3ZTUGZ6bEtXVll6WExveEwvWWFTK2w5Nk05VkVHM2R0?=
 =?utf-8?B?Wllod0dOcW9mRU1UazFxSzkrS1NxcTUwZ3JCaHpKYzV4V1VwbVB6c3N6dnAz?=
 =?utf-8?B?YmhBYnkrbmUrQjdCR2o2eHFDTUNaTUpWREF3TkVxNktXSEZERGx4Y0FVaXg0?=
 =?utf-8?B?dUZCeERlVnhyNlJlYTJkN0RWQ1ZxTEIzOWZtcXF6Wm51RXB2MTlINU85cm51?=
 =?utf-8?B?Ym1FamlWVGhnN0U1dk1ud0xXVlVwb3QveDdDNnhFR050VGlacER6TDFzMHJi?=
 =?utf-8?B?WEIxRU1ieGxxTTBKbG0wakNFNkx1TWo2Vm5uNnhaZHk1TDlxMDFiZ1U5Ylhs?=
 =?utf-8?B?SDFwZ25vRCtuazBwck53VVBaV2cweWFMV3hTeFBYM003clJFcDB5MWJNL0U0?=
 =?utf-8?Q?ZM9U0azGkpywOV9imFbCjxQpS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcbdcb4-9ee9-41e1-02e0-08dcec30157c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:10:44.6167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/BXsiA0vj8Nm4QsqsVdmXzJHmYEYejkNOFNbmeYFhZdvWa7j4e/8yIgXxkuHR5klh+dz/U1Zmqfp+4tO8mPrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882

On 10/9/2024 11:37 PM, Paul E. McKenney wrote:
> Currently, there are only two flavors of readers, normal and NMI-safe.
> A number of fields, functions, and types reflect this restriction.
> This renaming-only commit prepares for the addition of light-weight
> (as in memory-barrier-free) readers.  OK, OK, there is also a drive-by
> white-space fixeup!
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <bpf@vger.kernel.org>
> ---
>  include/linux/srcu.h     | 21 ++++++++++-----------
>  include/linux/srcutree.h |  2 +-
>  kernel/rcu/srcutree.c    | 22 +++++++++++-----------
>  3 files changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 835bbb2d1f88a..06728ef6f32a4 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -181,10 +181,9 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
>  #define SRCU_NMI_SAFE		0x2
>  
>  #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
> -void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe);
> +void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
>  #else
> -static inline void srcu_check_nmi_safety(struct srcu_struct *ssp,
> -					 bool nmi_safe) { }
> +static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor) { }
>  #endif
>  
>  
> @@ -245,7 +244,7 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
>  {
>  	int retval;
>  
> -	srcu_check_nmi_safety(ssp, false);
> +	srcu_check_read_flavor(ssp, false);

As srcu_check_read_flavor() takes an "int" now, passing a macro for the type of reader would
be better here?


>  	retval = __srcu_read_lock(ssp);
>  	srcu_lock_acquire(&ssp->dep_map);
>  	return retval;
> @@ -262,7 +261,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
>  {
>  	int retval;
>  
> -	srcu_check_nmi_safety(ssp, true);
> +	srcu_check_read_flavor(ssp, true);
>  	retval = __srcu_read_lock_nmisafe(ssp);
>  	rcu_try_lock_acquire(&ssp->dep_map);
>  	return retval;
> @@ -274,7 +273,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
>  {
>  	int retval;
>  
> -	srcu_check_nmi_safety(ssp, false);
> +	srcu_check_read_flavor(ssp, false);
>  	retval = __srcu_read_lock(ssp);
>  	return retval;
>  }
> @@ -303,7 +302,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
>  static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
>  {
>  	WARN_ON_ONCE(in_nmi());
> -	srcu_check_nmi_safety(ssp, false);
> +	srcu_check_read_flavor(ssp, false);
>  	return __srcu_read_lock(ssp);
>  }
>  
> @@ -318,7 +317,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
>  	__releases(ssp)
>  {
>  	WARN_ON_ONCE(idx & ~0x1);
> -	srcu_check_nmi_safety(ssp, false);
> +	srcu_check_read_flavor(ssp, false);
>  	srcu_lock_release(&ssp->dep_map);
>  	__srcu_read_unlock(ssp, idx);
>  }
> @@ -334,7 +333,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
>  	__releases(ssp)
>  {
>  	WARN_ON_ONCE(idx & ~0x1);
> -	srcu_check_nmi_safety(ssp, true);
> +	srcu_check_read_flavor(ssp, true);
>  	rcu_lock_release(&ssp->dep_map);
>  	__srcu_read_unlock_nmisafe(ssp, idx);
>  }
> @@ -343,7 +342,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
>  static inline notrace void
>  srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
>  {
> -	srcu_check_nmi_safety(ssp, false);
> +	srcu_check_read_flavor(ssp, false);
>  	__srcu_read_unlock(ssp, idx);
>  }
>  
> @@ -360,7 +359,7 @@ static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
>  {
>  	WARN_ON_ONCE(idx & ~0x1);
>  	WARN_ON_ONCE(in_nmi());
> -	srcu_check_nmi_safety(ssp, false);
> +	srcu_check_read_flavor(ssp, false);
>  	__srcu_read_unlock(ssp, idx);
>  }
>  
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index ed57598394de3..ab7d8d215b84b 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -25,7 +25,7 @@ struct srcu_data {
>  	/* Read-side state. */
>  	atomic_long_t srcu_lock_count[2];	/* Locks per CPU. */
>  	atomic_long_t srcu_unlock_count[2];	/* Unlocks per CPU. */
> -	int srcu_nmi_safety;			/* NMI-safe srcu_struct structure? */
> +	int srcu_reader_flavor;			/* Reader flavor for srcu_struct structure? */

This is a mask for the reader flavor, so s/srcu_reader_flavor/srcu_reader_flavor_mask ?


- Neeraj

>  
>  	/* Update-side state. */
>  	spinlock_t __private lock ____cacheline_internodealigned_in_smp;
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index e29c6cbffbcb0..18f2eae5e14bd 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -460,7 +460,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
>  
>  		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
>  		if (IS_ENABLED(CONFIG_PROVE_RCU))
> -			mask = mask | READ_ONCE(cpuc->srcu_nmi_safety);
> +			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
>  	}
>  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask >> 1)),
>  		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
> @@ -699,25 +699,25 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
>  
>  #ifdef CONFIG_PROVE_RCU
>  /*
> - * Check for consistent NMI safety.
> + * Check for consistent reader flavor.
>   */
> -void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
> +void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
>  {
> -	int nmi_safe_mask = 1 << nmi_safe;
> -	int old_nmi_safe_mask;
> +	int reader_flavor_mask = 1 << read_flavor;
> +	int old_reader_flavor_mask;
>  	struct srcu_data *sdp;
>  
>  	/* NMI-unsafe use in NMI is a bad sign */
> -	WARN_ON_ONCE(!nmi_safe && in_nmi());
> +	WARN_ON_ONCE(!read_flavor && in_nmi());
>  	sdp = raw_cpu_ptr(ssp->sda);
> -	old_nmi_safe_mask = READ_ONCE(sdp->srcu_nmi_safety);
> -	if (!old_nmi_safe_mask) {
> -		WRITE_ONCE(sdp->srcu_nmi_safety, nmi_safe_mask);
> +	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
> +	if (!old_reader_flavor_mask) {
> +		WRITE_ONCE(sdp->srcu_reader_flavor, reader_flavor_mask);
>  		return;
>  	}
> -	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
> +	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
>  }
> -EXPORT_SYMBOL_GPL(srcu_check_nmi_safety);
> +EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
>  #endif /* CONFIG_PROVE_RCU */
>  
>  /*


