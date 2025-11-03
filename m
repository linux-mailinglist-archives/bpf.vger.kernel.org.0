Return-Path: <bpf+bounces-73351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9CFC2C22F
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 14:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B66E4EC9A1
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E55A30AABF;
	Mon,  3 Nov 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ukIhivwU"
X-Original-To: bpf@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020118.outbound.protection.outlook.com [52.101.189.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414A26C3BE;
	Mon,  3 Nov 2025 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176860; cv=fail; b=aRHVtfruFXqvpx2TGFVN9rw3pFhi9UwP3SbenQuil0wOZhG0J7rSPvHfv0Xdc6o7m0WIsLuN/M/i4FBuB4dLTKiLko/teFG9rEUjB+WtqZHrvWEaD3JLhVQnWIETtc2dujttqGQf1pGbTw7SpsfI/OMclLS0rjE5ZfG2eTDmxS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176860; c=relaxed/simple;
	bh=h8mENeGFErGoOwiWNnnFRuUQq1kBqs4uPWhC7LraTyg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnejuCtdAyAGiWhHAt9sDfViK8RUOfEzxYrTmoS9OzPqXXQbe1z6jON4V7/uRYFEAS3pQXRALbJva7UACddyyfsuqp8xzMmFpHBG+uYlzfXgb30YoB2yWQ0HrbFshQ5XFBJz2FeNsufEoFNuE8Fs+InVaw8BnDkeFDvV7L6lLZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ukIhivwU; arc=fail smtp.client-ip=52.101.189.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEz+BEPeKlEU+PwKPErXJkhcm5f3pxwd4BFPPoYNu+NYTzZ76EgUAUDxcDhH34gBSM1cXtkBpDenfKKWiWeTvfV9NNmv2Q+82UkO9spGXqJBJeQVPsYpbYI6UPv3pNfj3DGTMWdTqKgteNJVBykahMBj3lxfoi5Suc5hR5AZMRZciPHfpZqDTOzsUrF2eApnTLTz1SvXoeuMqtOPwpIeZuRc9s4NISitXFGX9fyYWyxAEjiz6SUHRN3iEZLr2FMmJh8+nUKV8Jmx3OwygNqT2XAAobBMhMQYdeDvE6uQQhFFHPIk0wtaJ7ClwOY2keV5xsWzFiH4Q57KUQwYrfa1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjHWO+tvy9vXU2GzY5U7UNgtUNLeoeWjNLma9lWJIKM=;
 b=wn+72Tcc8y7PvQGkLAZrZlDnJQ4tyCDhollJLjkXJM1KAOCq0NgaEkCt47QKPyflS4745tz7+eYVGqFSo1xragh5F5idtBAZPe3QA8vLri/X/iCEH4eJdxtsg/vzOjpfmpzBiI+9vGb3jNpaVkio7AGa3gfumVCTEycdCUfMzoeG3psYHezkwAhCfSS+Btd5UWI2FLSPxuC08VtBoZY5YSTgtjjMwzt4kPWQws3VN/KeY0HH2P+7lpxEulSUgrT2HoE0puQ+lpmaJz0BPTlkCiGM1ap3jXJW0k4h2igWm3dIhENj7JkDjYGAZtM13J5E0kv/1D/31PG1lUZFUufVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjHWO+tvy9vXU2GzY5U7UNgtUNLeoeWjNLma9lWJIKM=;
 b=ukIhivwUFEYNUHN+E7ov4gjcuEjVLKdzclAYNb+PsVMiM39mUPi4Tu8ibtubPkh7OFyoq5b378TuM+3FC9gzKDBZCjk3cssAfwOKQs9aySKvRv12z5Ok52F01Mz8/avovtsG3WPzcTlZsS9hAquoxPxdM9LoM7XycYSV5E5cJaI3+XqhRRQhcSSz/Kn01pG0a0KySibbI2eDbtlLGRFyqLjbtg1f/y0wblm6RZWVYS6nX1mcvyyEbWQeaDN7kHxpYFeIQSqaqpQjY7frAl3Cm7+5whm1OVWdc1WJL5Iqy3Usu12ALQc42038NKCnYbot9ctWVedNVwXNM0M+rSo58A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPFE6D45D8EC.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::499) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:34:12 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 13:34:12 +0000
Message-ID: <b2fb5a99-8dc2-440b-bf52-1dbcf3d7d9a7@efficios.com>
Date: Mon, 3 Nov 2025 08:34:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] srcu: Optimize SRCU-fast-updown for arm64
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
 <20251102214436.3905633-17-paulmck@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251102214436.3905633-17-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPFE6D45D8EC:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d49fbe-81c3-4f98-f4a7-08de1addacb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekV1NTh1ME9CTjIvSHgraTBjYVNndktUTTNZSGRtWmFvaEdLRUdwOEs3SVgr?=
 =?utf-8?B?YVY4dVFRaGFCaWQzNTJFODdWc2VxSkZSYnh1MEZNUkxPUERDbVo4Sy9lVlF5?=
 =?utf-8?B?TEVsc0picCtMdnNBdGFhMy9aZ285RTI5OFdPYlQ2ZGh4ZnU1M3c0NnJMQnhM?=
 =?utf-8?B?UHVjNW5XcGhTeGxqZTk3QXhkamcxUVYyK3I3TWNDaGw2eHdIbml1RE9RY0pu?=
 =?utf-8?B?Yk5xVlJwR1lBQ0dya21ZN1FCUFdzd1NkcytqUloyNGUxMmdPbm0wRXZQVEJ1?=
 =?utf-8?B?NVpnWVU1OTlOYU4yakxBWnQ1VWNUZ1kydUw0M0gxVEFIMXAxZkI1eklPZ29o?=
 =?utf-8?B?ZkV4WFBpSm9pVzdNZExQRm1hem53eHZnNVBDaW53elBEbWE1dmtSVmMzeUlM?=
 =?utf-8?B?NkFVMnptRjdHWVlWNXZmWUg5V1F1cUw4elRsVW1HNHl4U2t4K0RWTUNQNmpC?=
 =?utf-8?B?MWRrQVhpT0lqWmsrRC9nK2g3R3lUaVppZVlhTDRXbEhJOEJMbXdhWkVDcGpz?=
 =?utf-8?B?RkpNakJybzNndE12aytlM1hwSEVER1IvemF3Rlc0N1ZvVnM5MEdOcDRZazU3?=
 =?utf-8?B?RFNrV2ZqWmpwa016ZmZ6N1NITVVrUE80bEp3UlFTazQ2aW9VQ2dhRS9wb3hw?=
 =?utf-8?B?Wm9FUzIrd1BOOHY3aytsQ1hURktyWnl5UjA3R284MkQ5dEZHVFhqUXNiVGg0?=
 =?utf-8?B?WDVRNFcxTExnSHlBd3VMZnE4YmJXVE12NGZ2OU5mSHVuMERPOXQxVUFMc1Fh?=
 =?utf-8?B?MGFDemhSMHVCTEhlb1AvRFNSYlFaVjgxamIyd20vSlZNSk9LN1dkZmxkTVFF?=
 =?utf-8?B?STd1UGlyVlNPejROOTg0YkhXdWo5Z1A3T3lMR0ZnTTFJTGhGYW5YRFArcGZG?=
 =?utf-8?B?cWM2Slh3MFR5MmJhSDNQaW9abU96eENoald1QWlPcWhXRmhYa0NJVlNPdDY4?=
 =?utf-8?B?RCtXVzVSdzkwU1JaZEpWQ3VnVUdZT1V3OWliOHNtUllyOUlGdXBIYzJ1WkRQ?=
 =?utf-8?B?N2F4ZTZUUVgxcEJLL2NtZTUzY3dMeExJTTMvc3J1b2JqOGlIMnVGNHE0d3Nx?=
 =?utf-8?B?R2szSnc3TDhPbXl6K2luVkl3L0FFOTZqZGt1dC9Rdi9KKzcvTkhxblE2bmh4?=
 =?utf-8?B?S3V1eWhxNVdyd2RTZm40YjJyWG53T0t2UlpwZ2cvc0VLNnkyUklWUmpGcGZ5?=
 =?utf-8?B?K3BlUGhLdXpwVEpFdEVKd2pCS3JiZHhUa0lxck01d3p4RFpXVXRWUElaN0xS?=
 =?utf-8?B?U2p2Q1dSQzBNaE9CL1A1NW9ZY1Z1WEE0eVVhdWRneFMyclhhK1pBZ2hSdmJR?=
 =?utf-8?B?Q09pelo5YTIxNFc4WDExdXVWTS9EaHF2cGpaZkpvYXpJZjdOd2JmTlpOandW?=
 =?utf-8?B?elROZUF3Z0JQMUp0K2dFVVFFemdJSXZweGxFVndhUFNwMDdsWUdOR2RNR0Z0?=
 =?utf-8?B?dHdibGlNZW9qSWZlbXEwL0t4NTEzSnFsWUNGVFN2K05TTXJ0aytjdFR3bk92?=
 =?utf-8?B?VWtpaXdoejNOVzlpdkpQOG56WUk1ZmtZeWZvSHNicGNRR3Y4a0VSakRHaTJy?=
 =?utf-8?B?akFBRzkwUjFmbnk0RitnaGlZbWpDY2FGQlJycmh5Q3B1azdyZk5Ya0FNZzds?=
 =?utf-8?B?NjQ0ZTBvaVBYbkpEbkV3UGVzRjc2NlhFV1gxZXc4Zm84ekZtb2F2WFUzMUJv?=
 =?utf-8?B?Z3FlUjFsdnNadDRyZFpJbWhoUkRYejJYeEY3VlN2ZXpZdCtIeGNlTU5LSTFv?=
 =?utf-8?B?ZkxVaVgxeEFUYlJwcTFNRTNCbDl3a2FwaThVU1ZvUkFWcHM3Rm5ybjhTN0Q0?=
 =?utf-8?B?VHg0OTJ5bEd1WUhCZzBYZjdJOTkzQlcxQkMrSFBpdHd6UFpheU9zN1RSNzFw?=
 =?utf-8?B?S3VQY0V2bVBXWTZCSjBZeS94NWt2c0o2eUlYOXo4TG5mbXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d212NW1vS0VqenVHWUxpd3BhVEliaE5yZXFjcjFFZGQ2em1QSGduT1FVa1hq?=
 =?utf-8?B?MmtGclNlZzM2UDJQUmhVL0RlVGVuV3ZzMDJPRktKdCtSS0VIQlZVWW5PdDVI?=
 =?utf-8?B?VnZremFJeE9nOWxaQlBwYmo1V2taTE1XaW9NT21GTGdqd1lscUFGakZqNk85?=
 =?utf-8?B?bGJXbVRwbnlFKys3aXRxOWRTM2JLbC93UXRaa3FGdlpYSHdzeHRpWk8zb0h1?=
 =?utf-8?B?bDc5S2I5L3llanQ4Q01rSEpsRDgrTGY2N0ZpNTNFZFA3ZVFyVnZsZ3dYQkV5?=
 =?utf-8?B?VWsxSnNTY25JOWR3dmZaRGd1YmVPYVIwR0VrNDkvWjRBQWRlK3VNOElSVHZp?=
 =?utf-8?B?Sy9BSzRVOENidkhJQkUzYjZPcG1vYlFzNndHK25YVG1GUkV6WUdCck5VQ3Av?=
 =?utf-8?B?c2hFa3JZV0ZQeG8zTWM5Q1ZDTmpWSURuak5mVkkwWnQ0ZVhSK2FiK0pLQTU5?=
 =?utf-8?B?MEw2V1Z2a1BTUFdnTzZQWEl3QVR3V2NwSUg5TkNNeXVvMGlJNmtab2lYNTBp?=
 =?utf-8?B?T3J2dkJkNEdSLzFicisrOTFudFo2dzVaQXdNMjdwSHNxaVYrVzN6Q0praDVE?=
 =?utf-8?B?M2J4NGpvTGJWV0hNUzNKclMxRVY2VjFtVFQ5ZUFQZHZQTFhiTHZGQktMcXJn?=
 =?utf-8?B?ZnhZSk03RnA4eVduK2pmc0FyVkkzUnNUWEdQRnNZNGhvSWI3MUJtN1VKdk1N?=
 =?utf-8?B?TEhvQU45TFlOUVZVR0JTWnRwM1hBZkJDSFdndVR0Y0o0ejFPYko0Y0FrR1pp?=
 =?utf-8?B?Q2ptcDlURjZNRFg2aTVpY00yMkpGTXVmU3VoZTlxVVF5bmpOL1NrdU1jVy8y?=
 =?utf-8?B?QVNYaXppSCt4a3gzOEkwOFdtZnhadUE4VDdoK1cwQ1FlUElnV3dvVjZxTTJM?=
 =?utf-8?B?K3hzcW15RjA0RHZKOW8rMHFRaGw0a1A4QnRRNTFRMzg1WDhFcVpvYVprUlF0?=
 =?utf-8?B?NVdBK29qRkNyL3NTRCs4eHpoSzRUV1JybWpTTEZIc1B4ZFVCcDlmaElBUmVh?=
 =?utf-8?B?dXEvTkI1SFFtWExDQ1N0QXNsRTdpYmVQYTNYMGIwNU1BWWNGZUNYREF1ZStL?=
 =?utf-8?B?dWwwYjMzQnpzcHJ5T1ZTWU5JR2FuSzFNaDk0U2MrV1cvR25NYi9xdTBvVWFR?=
 =?utf-8?B?a2lFQ25KWm1aMU5HeS8weXBrM0lYWjRXSmhCbTFWN3l4dlJsMWtQYklwa0Ev?=
 =?utf-8?B?Q1JWQWpOVTFPdy93Y1FNdWZZUW5BRi9mUzYzd0hkNTVISERzVDhJS0ltY0Rw?=
 =?utf-8?B?VTMraEN0L0dTWVFEK0prMzRPV0pmTndIaGFnZE96Tm5XVS9DYW1KSTQzY24z?=
 =?utf-8?B?alJPOFoxUjhsUjdjdzk0a0h1WnN4a0c0UGkwOUptRUJrYmFaOVlaWU1ETjR6?=
 =?utf-8?B?bXZmMStXRjVrUUVKZ0lOZEhYNlNBaDE4dnJQZzJlLzdIaVhrT3hOdWRHZjVD?=
 =?utf-8?B?Q3dTY1BkeTlNRXdFOVY3K256SC8yZzBKaW5nNHk0WFJxUUE1OUR1c1laMW9G?=
 =?utf-8?B?YVlXRnV5OXJ3elJvNENSRVdVTDlNczJvc0kyeUs1Q0tKNHhuRVRsdE1SVEl2?=
 =?utf-8?B?S2Q1VGZFS2FhVUk3N1U1djJQUmpNNHl1R29GWUFSMEJQcUo2NVQ1QWEwa1Ax?=
 =?utf-8?B?a3l0Qnc4bFJtU1B6UXhlWTl3MjIyb3JXTnpCTmFWOGIyUko4Y3lRMUFZcE5K?=
 =?utf-8?B?elV3UFRaaksxSlo1d3dYd0QvZ3ZhTnB5cVE2d0Y0MkdIdy9DeTlrRS9zemJF?=
 =?utf-8?B?a0Q5R0VKRGViYzdOWXI4b3JhdUZMUkdNSHMwVGdWZnhpT0kvK1pZLzJNaE5F?=
 =?utf-8?B?VDNyL2l6aDljUnNBeElVNjdkTmowNnhYM1NLZFloVFdBM3dzWDN3eDN0c3Rh?=
 =?utf-8?B?ZU4xcWJFd2Q0bXNmMkhZRVZhRFkyQ2tmSW1KUU1rVXdpUmJtaHFhRWxhbkJ0?=
 =?utf-8?B?Y28zaDVEcFJpTTgyYXl4WTBhK1dHY0tiT0c0Q0djWE15d2MyRkJNUDIzUFdp?=
 =?utf-8?B?OFNSdXRmMmdObE1VeC9LYm5ObG1KcnlPN1JzUkdhbktOYUszOUc1MU1janlq?=
 =?utf-8?B?MXEwZDZaRTU1Z0hsc2x0YmdwdC9oa0VPR29WZENJZWFSNkp6WmhWQ2ZOTWEr?=
 =?utf-8?B?NGJGNElPNWFsZWEwQ1hWWUtxMWlOOW5RM05VNVJKU0J4ajB0S2haRlIwdENm?=
 =?utf-8?Q?GRWSn7PTVjTSfR6M5tSydKY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d49fbe-81c3-4f98-f4a7-08de1addacb8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 13:34:12.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oc8H/nJP13T/U61vp77vXstOo/e/T4RhdJpvAulS+/Z8cgOWM4oFvdOxD5u++WPEkOuaufMIwKSD0v8u8IcRi7qJzs1IXs1PE3zIvGaghqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPFE6D45D8EC

On 2025-11-02 16:44, Paul E. McKenney wrote:
> Some arm64 platforms have slow per-CPU atomic operations, for example,
> the Neoverse V2.  This commit therefore moves SRCU-fast from per-CPU
> atomic operations to interrupt-disabled non-read-modify-write-atomic
> atomic_read()/atomic_set() operations.  This works because
> SRCU-fast-updown is not invoked from read-side primitives, which
> means that if srcu_read_unlock_fast() NMI handlers.  This means that
> srcu_read_lock_fast_updown() and srcu_read_unlock_fast_updown() can
> exclude themselves and each other
> 
> This reduces the overhead of calls to srcu_read_lock_fast_updown() and
> srcu_read_unlock_fast_updown() from about 100ns to about 12ns on an ARM
> Neoverse V2.  Although this is not excellent compared to about 2ns on x86,
> it sure beats 100ns.
> 
> This command was used to measure the overhead:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --configs NOPREEMPT --kconfig "CONFIG_NR_CPUS=64 CONFIG_TASKS_TRACE_RCU=y" --bootargs "refscale.loops=100000 refscale.guest_os_delay=5 refscale.nreaders=64 refscale.holdoff=30 torture.disable_onoff_at_boot refscale.scale_type=srcu-fast-updown refscale.verbose_batched=8 torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=8 refscale.nruns=100" --trust-make
> 
Hi Paul,

At a high level, what are you trying to achieve with this ?

AFAIU, you are trying to remove the cost of atomics on per-cpu
data from srcu-fast read lock/unlock for frequent calls for
CONFIG_NEED_SRCU_NMI_SAFE=y, am I on the right track ?

[disclaimer: I've looked only briefly at your proposed patch.]
Then there are various other less specific approaches to consider
before introducing such architecture and use-case specific work-around.

One example is the libside (user level) rcu implementation which uses
two counters per cpu [1]. One counter is the rseq fast path, and the
second counter is for atomics (as fallback).

If the typical scenario we want to optimize for is thread context, we
can probably remove the atomic from the fast path with just preempt off
by partitioning the per-cpu counters further, one possibility being:

struct percpu_srcu_fast_pair {
	unsigned long lock, unlock;
};

struct percpu_srcu_fast {
	struct percpu_srcu_fast_pair thread;
	struct percpu_srcu_fast_pair irq;
};

And the grace period sums both thread and irq counters.

Thoughts ?

Thanks,

Mathieu

[1] https://github.com/compudj/libside/blob/master/src/rcu.h#L71

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

