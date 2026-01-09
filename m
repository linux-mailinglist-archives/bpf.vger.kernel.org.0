Return-Path: <bpf+bounces-78365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E92D0BFB2
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9793E300FA35
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE62E0405;
	Fri,  9 Jan 2026 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BH++45Vt"
X-Original-To: bpf@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020131.outbound.protection.outlook.com [52.101.191.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43D29B77E;
	Fri,  9 Jan 2026 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985110; cv=fail; b=ISGulJTEE1t7bgACg5UTZrWZs9UiuJmUVPDAo6quZmYY0wmnwQLyA6WFlHWxBshRrA5sqIR8uImrcqvUceJ9BunZos3ip01kZP0XMaDBx8qYdemy/QmOXejtHfUpDNoSkb3czOf+wgcCCECqL4F6q5nj4amWFuZ+XoSh6+Tckss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985110; c=relaxed/simple;
	bh=oVJUJPfBizB8k+mgor8wDk/n3x5++l/Vq2Y/m/2SH4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rFJjcr63fbEHkm6pWPF8Bpp4PEkMsSjULAnS56k+gKV1Cqqewi5cCKXTh39Ji0KeN9NnU3DLIyJJzM8fu+pIjjSCxkacbbQ65xM30SE3a7G6oHSwKwpa+dEj4rO8fCmL6husSGlW36vhX5Jljj0MqT7EjwvCVNyHvdDCHS0bImI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BH++45Vt; arc=fail smtp.client-ip=52.101.191.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5Cr9iu37av2yN/4Q2I3dfuJ5o7gf6NPt/UO1oYac8YeiyfuXKfURw9SiwGIL3bf4qEhO8YKC0FjyqwEYvjiYlXBIBvHzDkQYiK6CcYu7T7yfUZXFnF5HfTyYEN32nLQn/adekOJLr+DAa4DqJnD4STEmh937rmLyqDAy3toEH9TnPda32bvaqXLSP2DO9h92AGPyrZsd58Kgn3YpLdq9un7bwv3MgkSid4lPRykFhTRJ40g+EGbUds80boPxrpw2DaiZy4HZ88VOwTq+0r7WEYmXSHPqpw+NpZmBevy3I+aO3uuRhboaa/DxO76/hA5S+WompdShGyLFvfIZ5mk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsXOZS6L9wNrluzPepEMO/k0cygO2XSbjlgto6shVQA=;
 b=vFmGUIW6hgpg78AL6FQs9UHWOrAYZyZk0fKoXdwSQewGKt5OfX1W2WSwn4lUSFeNNzbUgxWfa/TTQCFBVpOr8UeS6YS91TkRwhVD8MCSd8zLBESwYwdOtZlJAUqhQVdwAxiDVYcr4s5fCoMzlBC9SBorj45WUbXrWUSn2VBhm/Bkjmx4H6UHLrNrJL5uzv+VpcCfCN5plJQGKHOWgzO0RvgYW3AXWcnKlHuz44CJNnQdT0YRbqSWr7lRMAQKKSHq7wvEcbQ/8yrFw5pWW49dQi6nbPoh3gUjyKmRpbzZtgyCwMSPpCqU6vFZUXKX/K67pQ2LOOm9vno25T0EEvgjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsXOZS6L9wNrluzPepEMO/k0cygO2XSbjlgto6shVQA=;
 b=BH++45VtAeSGVgYRGI1L4bESJ5CP0ruRL4Q1Ah6dnsKIKIKppbsaKPGXJMTYwFY3DUedFDjq3R8ZqYBNXcGhRnE/XNe0a0vQmCMSYu0bG6Hc6hTvcaJEnM2GtJgkr80aevYwTbDRDuKnlQI4LSThfdmS0VfsojcI5FygxTaAkEq9e74sLcfHOWv4QLk4WTw08xRBI07B8GyKEVZc3cjLqwZOJrtRQ4HyuDfiZ8c5pmpwG3L36TI6bdDWQFWNEttl54IXrT8gSpTqH9FOHOXtl98pKPMeB+Jh0F+LMg/QTugUpMdyMOjnGNeSWLxzDnhvD5TqlvxBDtLtuN5iJnsOsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB11264.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 18:58:22 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 18:58:22 +0000
Message-ID: <8252131c-4c54-43ca-9041-71481165e516@efficios.com>
Date: Fri, 9 Jan 2026 13:58:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20260108220550.2f6638f3@fedora>
 <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <20260109122142.108982d9@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260109122142.108982d9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB11264:EE_
X-MS-Office365-Filtering-Correlation-Id: aae6c5ef-5593-49b3-2003-08de4fb10f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3VXYnByMmZWYjY4L2JVYU02eWlxSUpBOStZdFlPOHVYeHluSjNCYjV5OUM4?=
 =?utf-8?B?MmZBRDNkRzl2Qy9kbmU3aGtXK2FwOUgyRmZ0OXNCTzU1SGdVY0VHT1dIL3Mw?=
 =?utf-8?B?TUFLZVo2L3N5bWozellocFlwYnlPc3NETGNjYjluWG51bXh5UDdsT2RnVmt0?=
 =?utf-8?B?NnZvclpoVjVzMkNaRTE3VDdyMEgwdDBBVzltSzJqYU9NQ25wUUFnUHlLQnU4?=
 =?utf-8?B?S2xRckQ4bks3cEZWUVNjT3Fhd1FzVFdqbHNqL1U3QnhzMFNMOXVqKzRYTlRv?=
 =?utf-8?B?WGhOa2hHcGxySHc4bit3Tmc3bk5ZSzQyWHFab0plb0ZiRzA4d1NFZUMzMy90?=
 =?utf-8?B?cU5yNnNmMGFDSWRZTXQyVmlFREw4L0RQVUdmWkdITzdhVnh1YU4zeldyUm9w?=
 =?utf-8?B?bWpISHNjbHoyMHVsVFBZMkpkK0s2UDZHVitmTXpsSjdyeTdVVXo1a3RFUVdK?=
 =?utf-8?B?SzJJbWRYWnNlcTZHeXkybU5KMjluOFlrVklSaXRkZGY0SS9wMmtvWUVEbDFz?=
 =?utf-8?B?UVJDdWVRaWhBeUJSTUZoTFdqSGJIcnE3TjBPT28vaVZFaWpNaEhORDJQc3Vl?=
 =?utf-8?B?QW9RUkJKTjlpN283Z3dwVzZuSDBrYTNGSEdpNHpqcGJwWUhvaitnYzYyRVJW?=
 =?utf-8?B?NCttS1g1ZTF1ZnhLaXBGdis3aWRuWGI4K1Z4UU41Wm5ONGJYVHc2Y1hVTmtk?=
 =?utf-8?B?WWtVNHNPQllMK0czYTVWcHh0b0E5TSs2L0JSenpvc3ZQZXZ3b2lqQVZOSGJt?=
 =?utf-8?B?bzRaeFRaV2RMeFdhSCtRcGN6SnNNM1k1N0Zzdmd3cGFYdndlaU5BQU1tSnJC?=
 =?utf-8?B?bzd5VHVHUEpuZEozNkZDd1dhQ040cFoxTFF6QnlyTExoMVNHdDY5aGVoZFNh?=
 =?utf-8?B?M3hIY2ljclQ0M3lwckVkRDNaazhJZG9aOVZSRU1Lam80aE9GWjlwVzJySTRn?=
 =?utf-8?B?Ym5xcW1qL3lrSFNwWjhodi9WdVNxckRIdG4vRHVOdGd1aGpsMVphOE1LWDJ6?=
 =?utf-8?B?VUxGaDlVL2hOazErSWhuc3NxYlZ2TFhwcS85V2hta2poR0thMjl0VVRhR3dr?=
 =?utf-8?B?bzFBOFJjWXlyNUhNU1BqWVpMa0haWC9pSzV5Z2cxRGVkRXBBK1E1Uk1uOERO?=
 =?utf-8?B?OE5LYWxSSVV3ajBHMUhEZEE4ajQ0MTBXRzVYYXU2UFY1akRHaS9KbTJ1Y2lm?=
 =?utf-8?B?anIzZUZuM0F5alFxdDNKaEVuWVhyMTRsaWo0S1BqNEdOcklDT2pkbERYZGVy?=
 =?utf-8?B?LzJnYVdmUlFXY1RMUE8yZmx5OXBGZTBUME9Kclc5cG91elI4bjdxZnZWb2hz?=
 =?utf-8?B?NnRoUmNiM1NxMEJPVGVRcGFmOEljd3RXWFZ1a1JyWGVTc0doL0l1ektuUDNl?=
 =?utf-8?B?RnplTlQ5M3czVTBScEtNWTVyZ2docUJaOCtTLzVTaXVTZThwTGVFeFU2Sit4?=
 =?utf-8?B?dWNYOHJJVXJ5azFiSmhQRmdFWFNydXVLZG5kVDhWK3lvWEhuU0F3Q1NzQkhZ?=
 =?utf-8?B?aGE2SW5mby9GZ3pPRHRhdElJNG02Y2FGMFU3RThqRm9ULyt1dmlXNHNRdXJu?=
 =?utf-8?B?Q29acmhnWEpaZWhIQW4vMUk0anQxWXJOZ0NhUzhNODRWVTN0SFoxdGxGUDBS?=
 =?utf-8?B?UG1rMVd1MDIzbWVibmROclZCcCtUa2h2dFBFUi85dVhMV0o0NTAyUk9YSVZQ?=
 =?utf-8?B?SGEzdG9seGNRUmQ4SWpaRTdKa3pMVzFNT0JsbGVSS3NJM1pudFVVLy9MWHd4?=
 =?utf-8?B?UHZKd1E1bDNEbFJMaUhKWWxmcEFtWGpCR0M2Tm93dVJEUy8vMWFCL0t0b3NT?=
 =?utf-8?B?MWtlb3RhaU5MWGVmaFRXaEJ3eXJYUGxsQnYwRVpWbXR3TmRNV0pUbTJKdTRW?=
 =?utf-8?B?T0VwWW1XdkZCNjdEQlgya2JycFNUM2xUWW5wNWYvUmh3S3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEJZbjlXcTIvZlB4S1FNZUY1bGwzbnhkY0h3Ui9XRnVVSWt0TVpyV3dyZ2NT?=
 =?utf-8?B?UkZHNVNncVd2enJZbDB0c0hzek5rNWR5L0FRcXFPU3drVDJORzFheTVrdXFF?=
 =?utf-8?B?V2xRWXA2dW1tNHlFWXozcjJYMndWZW5iSXd1RmU2UDRhTmJoTWVweGRFSlQr?=
 =?utf-8?B?WnZ1bnFrWjVrT0k2K29NeWVjNGdFMU5GbndNOTM5R2RNWW9WZ245SktibUsr?=
 =?utf-8?B?SGY3YkE5MDdvVkZwMFpEVjNWUXA4bTBTL2JISktqRG9BQUdERndyMms1U0Jy?=
 =?utf-8?B?S2NYbWk4STR5WDRRZGxUR2Rlb2FqV3pTZGRSQWRkOUp6di92KytBUXJsM0V2?=
 =?utf-8?B?emVIQ05BYXV6ZG15eG1KNzNHRDltbVhvaklySFR0VDMvY3VlcnphQVlrNXpv?=
 =?utf-8?B?K0E2elRoazY3YThRZFZjZ1NMQStHaWFtK0hkVjF2RXp3STNXN2lnRGVVUWdL?=
 =?utf-8?B?N3BWWGdOMjlkaFRLM2dVL2ErNHBYdWtpQ0lLNFd0bWgybU1mSXFOby9Ecnpx?=
 =?utf-8?B?eWFkejRBQWJhUnh6eEJ2VU1ETUVaNU5xVHp4M2g5TGVGVnRPRnVueVNvNVEw?=
 =?utf-8?B?WWI0T256MVoyaS9YSVFLeExFeGxLbi85U0M0SnMzWE9pYkVPMGNwVTUrN1R1?=
 =?utf-8?B?RmRCRmtZQkpEbDdDUU50UHp6ZGJjNWE1U3dMejY3c1JMNWJXd1JyWkoydEtv?=
 =?utf-8?B?VkhtTlhac2RzbkZGNDViL1BnOE5KMkRGSTczZmpueFp4V0dhNkpMMkF4dkpy?=
 =?utf-8?B?Q1JQZTFkY0dWbjluWVBYc2NzclJEaEkwQyticVZkaHBnZFVIeDVpV3pvYkt0?=
 =?utf-8?B?SzljREVmSVgrSHJZRHU5MDJvQmlvY0pPSWpXcTd0OGdabnRGaUllbjh2TDB1?=
 =?utf-8?B?SnVMUUNabW1RZjdQQnRiRzkvRjIxL3liVHpnS3lBRXJuci9kM0taY0p4MFBP?=
 =?utf-8?B?MHlqeTdpOXJFOTJGbng0QzZXMWxCb2dXOGpuMnphTEVML1NDdTNsK05UUnda?=
 =?utf-8?B?Zzk1Q0lhNzRlcE8vUjRkS216UjQyT1ZsUWN2dnNtQ3N1c0h5NDZGY2dibzFm?=
 =?utf-8?B?RjVXNzBDRUpCLzVQUldoajZyODdIWEdidzRBVVdPRnlnUmEwMGl2ZStVTW1k?=
 =?utf-8?B?TDY5MFhmcXBYSFZWTVppZEVLWWRhcFBiRnVyTW80ZzN1bWRtTnFYSms5Y283?=
 =?utf-8?B?WWp6SEZQTXMwRXMwbmZBUVZMOXVxSTZLN28yeU1LVjdLR0ZnOE8wWkQ5WWhG?=
 =?utf-8?B?L2xxcTU5bTU5SjJsZFhja081OHVWSkxIUWZzNEVJOVRFSU1OYnRDR3Q4QkFW?=
 =?utf-8?B?QXhrUHk5YVRaK1N0M2w1MFp3UVB2amZGU1BLSnpVRVBPMFVxai9yZk9jdWFH?=
 =?utf-8?B?MmZtdVVGaEU2SWlqM2JkNVFKbTZXUm93TzV5ak5sU1VRR1JOdG56ZUJZOVNP?=
 =?utf-8?B?K0V3UVJ4MGlmS1cyWHRSOXZGUTVYc2JzYW9tZGc0UGhnYmVLcUpFSHA2WkQw?=
 =?utf-8?B?YzFWVUduTklLb29PcFNiLzVacFVnTkxIMmVUM3NzOFlOUExZUnpzQnRPSDc5?=
 =?utf-8?B?OXVWU0ZITm9HRDVRSC9LU1I0REZtTVp3YThFVE9wemdDZDdYQXdrZG9sWVl6?=
 =?utf-8?B?cHMrQUR2c2hkS0V0elM2WmtLeHdmUHpzdzFyMmNSb0FHQmRvNkwxcUhXT3Jz?=
 =?utf-8?B?L0orcEZrZm1md2p6UXZSWFFXQkdSc0pGR1R1aUw3Q05LRDgvUmZSeXY5RThO?=
 =?utf-8?B?OUs4NGJ6UGt5eXAzcWsyNllzV3JxT3pIUHBHVWJ0Q3VQaGVIUVk1T0lHa2Jm?=
 =?utf-8?B?Q0JnUjZyaHcrT2djdWUwNUIxdEp6THpxV1lUS0hmMWZQQnZoNjdTdXpXYlBp?=
 =?utf-8?B?akdOS3FGUzF2b3dKQUZSZVUvblR2aGZiVzBrNEFsL3IyMGE5U0hWNFRSL0dL?=
 =?utf-8?B?YnA0eWhxYTZQYW5BNGZMUFU0NlQvTGxubVRPMzdCRVdMbzZxcTExcTBLLzR3?=
 =?utf-8?B?UDBhMldrZUEvbys2MmNlcStHcU03TXdWU3hmUzJkWmZ1LzhPRDc0bnZVSEo0?=
 =?utf-8?B?eEgyTUhzb3UrQnV4MG9JYXdNUDRxWEtESXlXM1Rkd0R3NnFsdlFoOUlDWVZt?=
 =?utf-8?B?Y3IxM3FKWmFPQVpiVm04empEMkxSaGlOQ1U5TnNTblNWdmVVZFZ5eXM3a0hD?=
 =?utf-8?B?QmZRWTA5dzUyU25UQVhkSlBZdDZzbHlKUml3RU1GcEVERHA5dzZMY05oL1kr?=
 =?utf-8?B?WDBiUHRIMTR2K01kVUd6YVh0M2MwOVd0VUg3SkkvdmFJcVgybmZEY0l3cEtG?=
 =?utf-8?B?UEhZNkNvZStwRTFmWkJYYXVzU0ZWYmMvL2lWV2oxNCswbjYxOWpZUG5rK2ZF?=
 =?utf-8?Q?uTOED5pmnnKxjOWM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae6c5ef-5593-49b3-2003-08de4fb10f97
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 18:58:22.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULN1kwYHIWapawfHrFeH9+el90+EbEP5qTIsW2KCZTPgeWxz4dOnL7tDHo2Y7rHAfor3NBewSarq33t8J4EPr/cqkqRRLY9iaJXi/FI7zAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB11264

On 2026-01-09 12:21, Steven Rostedt wrote:
> On Fri, 9 Jan 2026 09:40:17 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2026-01-08 22:05, Steven Rostedt wrote:
>>> From: "Paul E. McKenney" <paulmck@kernel.org>
>> [...]
>>
>> I disagree with many elements of the proposed approach.
>>
>> On one end we have BPF wanting to hook on arbitrary tracepoints without
>> adding significant latency to PREEMPT RT kernels.
>>
>> One the other hand, we have high-speed tracers which execute very short
>> critical sections to serialize trace data into ring buffers.
>>
>> All of those users register to the tracepoint API.
>>
>> We also have to consider that migrate disable is *not* cheap at all
>> compared to preempt disable.
> 
> To be fair, every spin_lock() converted into a mutex in PREEMPT_RT now
> calls migrate_disable() instead of preempt_disable(). I'm just saying the
> overhead of migrate_disable() in PREEMPT_RT is not limited to tracepoints.

That's a fair point. That being said, the kernel code which relies on
spin locks for fast-paths tends to use raw spinlocks (e.g. scheduler),
which AFAIU does not need migrate disable because those still disable
preemption even on preempt RT.

> 
>>
>> So I'm wondering why all tracepoint users need to pay the migrate
>> disable runtime overhead on preempt RT kernels for the sake of BPF ?
> 
> We could argue that it is to keep the same paradigm as non RT. Where
> the code expects to stay on the same CPU. This is why we needed to add it
> to spin_lock() code. Only a few places in the kernel expect spin_lock() to
> pin the current task on the CPU, but because of those few cases, we needed
> to make all callers of spin_lock() call migrate disable :-/

For tracepoints we have a handful of tracer users, so I don't consider
the scope of the audit to be at the same scale as spinlocks. Changing
each tracer user to either disable preemption or migration if they need
it on preempt-RT is fairly straightforward. And if tracers don't need
to stay on a single CPU, that's even better.

I'm also inclined to consider moving !RT kernels to srcu-fast rather
than RCU to make RT and !RT more alike. The performance of
srcu-fast read-side is excellent, at least on my EPYC test machine.

This would open the door to relax the tracer callback requirements on
preempt-off/migrate-off if their callback implementation can deal with
it.

> 
>>
>> Using SRCU-fast to protect tracepoint callback iteration makes sense
>> for preempt-rt, but I'd recommend moving the migrate disable guard
>> within the bpf callback code rather than slowing down other tracers
>> which execute within a short amount of time. Other tracers can then
>> choose to disable preemption rather than migration if that's a better
>> fit for their needs.
> 
> This is a discussion with the BPF folks.

FWIW, the approach I'm proposing would be similar to what I've done for
faultable syscall tracepoints.

[...]
>>> +
>>> +	trace_ctx = tracing_gen_ctx_dec();
>>> +	/* The migration counter starts at bit 4 */
>>> +	return trace_ctx - (1 << 4);
>>
>> We should turn this hardcoded "4" value into an enum label or a
>> define. That define should be exposed by tracepoint.h. We should
>> not hardcode expectations about the implementation of distinct APIs
>> across the tracing subsystem.
> 
> This is exposed to user space already, so that 4 will never change. And
> this is specifically for "trace events" which are what are attached to
> tracepoints. No other tracepoint caller needs to know about this "4". This
> value goes into the common_preempt_count of the event. libtraceevent
> already parses this.
> 
> I have no problem making this an enum (or define) and using it here and
> where it is set in trace.c:tracing_gen_ctx_irq_test(). But it belongs in
> trace_event.h not tracepoint.h.
> 
> I can call it TRACE_MIGRATION_SHIFT
> 
> #define TRACE_MIGRATION_SHIFT	4

I'm OK with that.

[...]

>>>    }
>>>    
>>>    /*
>>> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
>>> index 4f22136fd465..6fb58387e9f1 100644
>>> --- a/include/trace/trace_events.h
>>> +++ b/include/trace/trace_events.h
>>> @@ -429,6 +429,22 @@ do_trace_event_raw_event_##call(void *__data, proto)			\
>>>    	trace_event_buffer_commit(&fbuffer);				\
>>>    }
>>>    
>>> +/*
>>> + * When PREEMPT_RT is enabled, the tracepoint does not disable preemption
>>> + * but instead disables migration. The callbacks for the trace events
>>> + * need to have a consistent state so that it can reflect the proper
>>> + * preempt_disabled counter.
>>
>> Having those defines within trace_events.h is poking holes within any
>> hope of abstraction we can have from the tracepoint.h API. This adds
>> strong coupling between tracepoint and trace_event.h.
> 
> OK, I see you are worried about the coupling between the behavior of
> tracepoint.h and trace_event.h.
> 
>>
>> Rather than hardcoding preempt counter expectations across tracepoint
>> and trace-events, we should expose a #define in tracepoint.h which
>> will make the preempt counter nesting level available to other
>> parts of the kernel such as trace_events.h. This way we keep everything
>> in one place and we don't add cross-references about subtle preempt
>> counter nesting level details.
> 
> OK, so how do we pass this information from tracepoint.h to the users? I
> hate to add another field to task_struct for this.

This could be as simple as adding something akin to

/*
  * Level of preempt disable nesting between tracepoint caller code and
  * tracer callback.
  */
#ifdef CONFIG_PREEMPT_RT
# define TRACEPOINT_PREEMPT_DISABLE_NESTING	0
#else
# define TRACEPOINT_PREEMPT_DISABLE_NESTING	1
#endif

to tracepoint.h and then use that from trace_event.h.

> 
>>
>> [...]
>>
>>> + *
>>> + * Returns a pointer to the data on the ring buffer or NULL if the
>>> + *   event was not reserved (event was filtered, too big, or the buffer
>>> + *   simply was disabled for write).
>>
>> odd spaces here.
> 
> You mean the indentation?  I could add it more and also a colon:
> 
>   * Returns: A pointer to the data on the ring buffer or NULL if the
>   *          event was not reserved (event was filtered, too big, or the
>   *          buffer simply was disabled for write).
> 
> Would that work better?

Yes.

[...]

>>
>> So I don't understand this comment, and also I don't understand why we
>> need to chain the callbacks rather than just call the appropriate
>> call_rcu based on the tracepoint "is_faultable" state.
>>
>> What am I missing ?
> 
> Ah, you are right. I think this was the result of trying different ways of
> synchronization. The non-faultable version should be wrapped to either call
> normal RCU synchronization or SRCU synchronization.

Yes. Or we switch even !RT kernels non-faultable tracepoints to
srcu-fast, considering its low overhead. This could come as a future
step though.

> I can send a new version, or do we want to wait if the BPF folks have a
> better idea about the "migrate disable" issue?

I'd recommend going ahead and move the migrate disable into the BPF
callback similarly to what did for the faultable syscall tracepoint, and
let the bpf folks comment on the resulting patch. It's not that much
code, and showing the change will ground the discussion into something
more tangible.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

