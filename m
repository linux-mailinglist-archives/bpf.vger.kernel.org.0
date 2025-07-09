Return-Path: <bpf+bounces-62795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE11AFEA9C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21191545802
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCBA2E041F;
	Wed,  9 Jul 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iWTrqGsU"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2099.outbound.protection.outlook.com [40.107.116.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0EE28C84D;
	Wed,  9 Jul 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068782; cv=fail; b=BL+usD7gpUI9K6az+sLyEWELg96hylNZR9nXbW2GJS/Bb5p7OtaPAQH4DBlvMG9bbLL10cIm32qHZJL61bFtqFQ+dSh3Jw5E83uhHtWJyLR8Z5zXzsGOo/AFh49v3KXymQUH90iMt1kGOLQUQwcEqCWULtBPBrNBl+fgQyuS6QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068782; c=relaxed/simple;
	bh=xwgvWkmmSiZXC67mEN4IldflazaEVznN+dTIl2WXl5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kib0aya4wkRiCsRxsGwIyGX8rEVgQeXiWLAPSLmCpK/bjzU3PRLRcYL+poVTIdGSkSJfFK8EixohdBxMDlAbvHc4DzP2+Z9sS3HWIilg5vUeShZJZpr6K6k8ry7OceczJNUj+lpVJNgVqqt6lrjgbhFk5FVvVRUgN8bJ2pLGkUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=iWTrqGsU; arc=fail smtp.client-ip=40.107.116.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzGtRePHFr3L3nWvwlssgEbAxZEOi3aAAcZ5JTOcrQL7rC+1GbBD3SsEg7+Dd9FU7Wb7ruNajxDdD30Q9YD6xAy0JjT5dWZmMU5lmcUny0Y1d5NsV7AzFUlXo+ZgammCGo8lb5yt4vQIjn9f1TwDBW/BNhxmq2uVPqWw1dAwaH1JbeWyen/NIdoRQheQMPoDjMQNEuDsu09FCkFBBGvHhR73r63jyJ+0P71o/ioMcq47MopxqD4cWvuJMK8C79J+voSwBgCewpzwmjs8EMaHvW+QcZIGyttJoH5O4OXgFbt++GcHWPD+BBeXciQveiGVU/S5+ZYECDhM8yi9atUf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoUSy8uRkvc1quFBadC1tbJrmfR0t8P3NLpaerP2TnU=;
 b=exyVyLgmed/uKbPxpOeZhvtYR1+GATjjAwVsNp/rOJIE3FrbADP60ni5RdfNwAE4hFKS6rhg1q6hO+OnQ93bJoEtfqSbRMt+RlFJ6tAh44rN6W643rGUcuGIJZcZQdj6JtRJ51AFW3dgWr5VmBdmxhqNvCvStAKBuSfdsqpA/vL6ImHoUSuKrwgbGd75hFO1RCs0458lLG0N9Cqi4+JdMRLz0vjpNM8rUD5usXY5h0G64rC36ZElr6mPWGk+tekHsYwjT0tcRQzKDHln/DZNToz+hrRHOVG2rzdNtwnhbj5TfQctNonNpNs6Kl8tE4v7Oc8Q8Oqhny5C/1S84zpJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoUSy8uRkvc1quFBadC1tbJrmfR0t8P3NLpaerP2TnU=;
 b=iWTrqGsU8BYDSU5em3V9KwGC99Xv9D9gXRrMMj5zupnFuzql1VDE079TCnRQFWwXsDbvNqP4B4rRbiCKti3d1uuiQaDMxfEY+5OYVSR7SaMLmJdxq/r5te66Tx+vNEn+bl0sYV+NOKRa2+oGQNzbO1sHZUvSP+gXobP8j6VhDRktJCMYw+kWSVtO7ViWwz0/45Qz+fPc4rrN0roQuwu3PxMj+frSOkBKC5bbS61DktFM5FHsLHR7nDdZ0i1NI4Gs1xqHVOwN45108kl+Kwpfn3XR3ggIk2bUpEvum6Oosz6L2QRxUwWbIqQD0y3wQdt5N+M4nZfUe9ZLSZAIiorqRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 13:46:16 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 13:46:16 +0000
Message-ID: <39cf3aab-7073-443b-8876-9de65f4c315e@efficios.com>
Date: Wed, 9 Jul 2025 09:46:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
To: Jens Remus <jremus@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20250708021115.894007410@kernel.org>
 <20250708021159.386608979@kernel.org>
 <d7d840f6-dc79-471e-9390-a58da20b6721@efficios.com>
 <20250708161124.23d775f4@gandalf.local.home>
 <a52c508c-2596-49d1-bbe8-8a92599714f6@linux.ibm.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <a52c508c-2596-49d1-bbe8-8a92599714f6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 64987512-0124-42d1-1576-08ddbeeef9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGVtNG4rbmwyWGtzTWoxN2JTQS81ZEsrbnMybnUyTnhLRG9OUDdRWnI5SUQv?=
 =?utf-8?B?bVI5NkdaVFRqTHUvQ1dWVmdKWkdHNGZzTE1lS1NiSmQ0ZFNrNFRUQW85SVRx?=
 =?utf-8?B?WkMxNjZNaUYxS1pySXFaL2RzYlIzWmQ5Rm5DaHZWTXJ2eDRJTytQMElRaXFH?=
 =?utf-8?B?MG9WZlBLSTlvSkEyV1VrcGZmcWowK2RHdmZ3clBGcE5hWDZmc0RyS3FQdVc1?=
 =?utf-8?B?WEpzbGk5NnRKc0dsU2JPalR5TmZlRlJnWnp1Q2U3aDVTeHpCQWtrcmVWZGhV?=
 =?utf-8?B?TkZZcTB6NGpRTFpZT3h2UlEzbHlvUFhOWDBFUkg1MWlxWWdKTU1rMWpDMGha?=
 =?utf-8?B?MmtRSVRlZ0JOTWtsdnYxYmNrRzMxTlJob3JtTTlPVyt0QzVJYTk3ZFBVRVZ2?=
 =?utf-8?B?MHFzaVErMHdlc1hIYzN0MVBDelpzZ3pqdFY1SUNCSW82K3MrSFdqU0dVWkFk?=
 =?utf-8?B?M25JR0V3UDYwMEdTUE93WFF3Um9KeDZWSzNBYkhVUVpxN1ZuMlRMMUVRMTVO?=
 =?utf-8?B?cTFUa1FsNXQ4RElNSElySEhZUnR4OWw0YS9wREEyL0IwMHNZRXNoSGNGeUt6?=
 =?utf-8?B?VVk5WVJMaWdOd3ZYM0FHNUhiQXVOYjAxQThWS3pHYUFWZklKeFlaamJJRHY1?=
 =?utf-8?B?L01qcHBsVFRHWHZvL3czVk9xUzBCYWtPY1plbEl2aDQwRG00OWlVWjlCemhn?=
 =?utf-8?B?MHZwb3F3MnJ4WW8velZPZmdWak9NcnhLNStXSlhmZWFJdzZheUlRZlRDYnVr?=
 =?utf-8?B?cWdaMFhML05saS9IZzBPMVdtbHlDaXNCTU92cTdQTzRjRVJ1aGZQN0RZaXBI?=
 =?utf-8?B?OThmOTdxZDJadHgvVkpzWVZNelJ0YmdNMWxwb0V2SUk0eVhjWm1SMXhPV2di?=
 =?utf-8?B?ZGprbzloRXM2L3lYWDM0L25jNmtaZnJWbGdBbi9Ha09WbWJweDRBanBQWE4x?=
 =?utf-8?B?SG5jRTZNSWJNazJLMnpWZnNnd1U0NFR2Zm5mbis3MWhXd1U0c1lOa1FzVFBY?=
 =?utf-8?B?dGluMFNUczY5b3gzODVTUDNKRWtNY0d6KzhwcCtSSnV3VEdGRFpBb0FOTUJU?=
 =?utf-8?B?SnhkVTM1aVRQdjZEanljc01idEJiOEI0OUF3YlU0U2F3NG5CQzFTQzZlOXkz?=
 =?utf-8?B?UnJCeVNVNE9XNFZQdS9ZUWFhRWdHZnFLbzJNUHR0dkpTeDE3SGhRVTMzZkJz?=
 =?utf-8?B?UUZGa2p0bTd2L3ZMY05mL212TUF3emRMak45VFQ4Ri9TVHdkY2VzWGl4WktI?=
 =?utf-8?B?MFZyVXc2QWg3TyttUzNTWlBxZGprOGNhOXdhWXR0TVdVWDF6eWlObUEvNFUx?=
 =?utf-8?B?aUdDUmVVM2NkV0NLeWhMd1dhWjFxTzNJUDBHaTRPMVZlZVVJVzVzZlBFQ0Ru?=
 =?utf-8?B?akx0UWdtY2lSRUZhR1NXTytGWmFpbGRhWnlWOUplVk1SdEtaZGthWDZQVXo1?=
 =?utf-8?B?bnBlbm9QQmtoNEZYZ2tCU0xEM0lYZVB1VWV1V0hsMzBTNGQ3LzJCN2YzaTNU?=
 =?utf-8?B?bGF4OXNBNURFcGdER1VWQXNTbTgwUVk1ckxDUDVQaHYyUXVwWFlqcVdUYlhr?=
 =?utf-8?B?cytFaGtHNlZHNGxHcVNGbm5VbGZPcy9kS2dXMXg1eEhBQXEwNWdVR25MK2xH?=
 =?utf-8?B?U3pDekZCUkgrVjZUNEdRaWVWT1h1OTZnQ0JaZWNmVENHVkNSdWpNS0JBZzdH?=
 =?utf-8?B?bStjV1ZUOHNTYXZpd0JHa0VHZ2lwRkZOanNZWE9UMnR6aFZiT1NpZlc5QU1y?=
 =?utf-8?B?cDZKMmY2cm9kaEhyNG1uMkJSZE4ya0FUaERISndqRlZlKzlDT2J0eGh5c3dv?=
 =?utf-8?Q?YxB24zG8XxuRTLqHPOY9s00yfeeAjivl8x9Wg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkJRNzZLbU1kdnM2UURLOWhCUndvWkdjWU5GcnBqRmV2QzRwc0E1SWU4aXY3?=
 =?utf-8?B?TTVwb0FZemY1azdXSmF1WngvdnhEdy9NeEhQZitYZE1mb3RQQVhQQS9oUkFu?=
 =?utf-8?B?YkdTYi9lRTQ5UUxrQlJMTXBYSnpQdEpWK2ZXY2xaaUE0YnA1MXlFQVZyOGdF?=
 =?utf-8?B?dHhWS3JVWmlWNy8xTEdZQ2l5RmRYTDNJbU95dGZGSVJHOUxqYXpLWUJKYUtG?=
 =?utf-8?B?WTlGOThNMWRwSW54MlZtbTRTODl0eTBXT0lzSFByaVNMVFRTVGhPMEhrenlR?=
 =?utf-8?B?OFRGQk9SN21lYUZId2I5Q3RYOS9Zay9UOWVHRWc2amhGVnhmMkZRNS9XQXU2?=
 =?utf-8?B?TE9MaGR4ZHphbFJpYTFkeHc0ZXZXR1NyZTJNOTc1bkFDUzV5ajNyanVrQjVF?=
 =?utf-8?B?QjNBUzRYdmNyYTVjTTFiNHpkTlJxTmw4TXcxZVBtTmg5aXdBbWxXRnhCOUE3?=
 =?utf-8?B?YWtlVi9WcU5vYThUK0ZjSi9tQlBlREZBUHdISHM4bzg1bjVWWnZ2RkVEUUNi?=
 =?utf-8?B?V1MzNlV1dEJOZDRwelltcTJZOEJ5T214YytxeWZlK2I3TDNmYWNkcG54SXJL?=
 =?utf-8?B?Y0xSUk1ZQkQvTXA1TE5PSUthMXhzdExWTzZ6dENIYlpuOTdPeHlRNnBYd045?=
 =?utf-8?B?bW83N2JiR3lsSjVyeFBTa0Zkd0J1RjJVM01oUWFTdlhVRzZlUzBqUm9GeUtt?=
 =?utf-8?B?QVZuQmVQQ2NWeVRvTER3aTdiSnlnN0FPT1VJYktadHdMYkhITmptbWV3UmRP?=
 =?utf-8?B?SkJSd3E3ODRQekZhUWZxOTdOa1RFWTVXQVB3YW5xU1djVHl5UFdmY0xEWWNk?=
 =?utf-8?B?S3RVeTNQL3A2d09INFk3Qi95bS91NmVKTlNtZ3U3ZlF4UGxVNnVDcEpxR3M2?=
 =?utf-8?B?aEZJK2tIR2lmUGZQTDNXb1lxdVN5Q09CN2x2U0RTTVdQSmpTNEo1RmoxZVU2?=
 =?utf-8?B?dHRMYVNVVHoyRyszZkJmZjF4Z3lnWEUvbnNhTjY3SW5WbWxMUDBJWWFmdzJh?=
 =?utf-8?B?Szc5UWVtc29OanJUZVI2eHlUQTlPbnVxYUlrRU50TklZZzVQc29aV0ExQXV4?=
 =?utf-8?B?bTdyQTdPMnQxanpNZkFqaUQ1MGxicnVaUElOU3NJUDh6Z29wS0g4cnBKSHlN?=
 =?utf-8?B?Tk1COC9iSG5sMkh0OE1yQjVlN28vaW5rQVlmb2lvN20yNkpHdVVTRUNNUjdx?=
 =?utf-8?B?dk0vRmFSbkhWOGxOcS84bEF6eUZoRk9odS9hVDJsUTFrcExseHZjUGJiNklE?=
 =?utf-8?B?d292MjVxVmRnNXJ6OUZPUkpoZXh5Z09kelRDSTE0VjVGK1NTb0JSVDFhM1FT?=
 =?utf-8?B?Y2thR2RDbEVPSVk5MkFJUCtaWjdDNFpVblFIbEtwQzZwZkFVUVhtRzZIeGVo?=
 =?utf-8?B?Uy82T0JmRURaQ3UyRDlYdm5pME9ia2dzZ2R5UU5lY0dab0xuNWFEMDZsRDd0?=
 =?utf-8?B?VzE0RmFhNHg3NUV6ekZucGRoK2ZOZS8xVzlPUzBLdGdoVkFXZXNoL1NSTGtu?=
 =?utf-8?B?aGNQeDhpdGtQTlBGYngySzNvSTRHSU8rV0lORS85emYxTE5XRUlXUG1YQ3Nh?=
 =?utf-8?B?TUFZeURXQnBWaGcyR0F0VEloWmpPYy90NVVVWDFrd3RydFFwS0ttdVcyMXk5?=
 =?utf-8?B?OFNRWUorbG9vdDhTWTl5bWVXcjk2K2ZmYkR0U2hrdXZ2cHNxcUpTb0hwUWNy?=
 =?utf-8?B?QmV1bU5OcE5FbXpQaTlqVmNyaGJZY2xVY1hlb0hFRkNEQlZyTy9KeDRCeGNJ?=
 =?utf-8?B?dTMraGZzZXpLV2d4YjFMcVdQd1BRVHZmZ21ZK2xSVUE1NW9YYVk5NkFWRUNv?=
 =?utf-8?B?dXQzWElicTR5YU5UblRxbXlPSVRvTWRTSDhCdGFMaUtyVHlNSVh4U3JQR2ZT?=
 =?utf-8?B?Z1JOSEpNd0dNZ3BuWnNicXV4M1EzZnE2NWNmTi9qUm5oakNnMnIxcHdZZlF0?=
 =?utf-8?B?VjFkNWRLOE1HRkhMcUdXNE8vSEloQzJiQXBGMG1td01NaDM3M0wrLzhucWZs?=
 =?utf-8?B?cTAwWHRJRFBra05TdDNBZFhSN2pmZEVLMXp6YjZJUjIxaFNPdTA1cS93dEEv?=
 =?utf-8?B?M0d4M0RxTWhnekIxdHRRY3k1QmtneE5jVmZRRXhuNjVqSHdWUWFlSkQ4T3FM?=
 =?utf-8?B?MUtmMzNtb3hrS0laVkpIVkV2OTB2eFVpaFpWazhIODFpMjRJL3ZkL0p5MjJx?=
 =?utf-8?Q?TNzSupCgj7Cpqn36D6eDMUk=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64987512-0124-42d1-1576-08ddbeeef9b0
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:46:15.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Gmn1dsynpJE9Bqm7AnTjxGKTOGTp+ulQ3shvBLIkYKFKK+o6DEn6rfJxHOTGT8eZjdPxaXulsjT56uBhhM11fiqfWmJyfaM8krnR/9S4No=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9011

On 2025-07-09 03:58, Jens Remus wrote:
> On 08.07.2025 22:11, Steven Rostedt wrote:
>> On Tue, 8 Jul 2025 15:58:56 -0400
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>>>> @@ -111,6 +128,8 @@ static int unwind_user_start(struct unwind_user_state *state)
>>>>    
>>>>    	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
>>>>    		state->type = UNWIND_USER_TYPE_COMPAT_FP;
>>>> +	else if (current_has_sframe())
>>>> +		state->type = UNWIND_USER_TYPE_SFRAME;
>>>
>>> I think you'll want to update the state->type during the
>>> traversal (in next()), because depending on whether
>>> sframe is available for a given memory area of code
>>> or not, the next() function can use either frame pointers
>>> or sframe during the same traversal. It would be good
>>> to know which is used after each specific call to next().
>>
>>  From my understanding this sets up what is available for the task at the
>> beginning.
>>
>> So once we say "this task has sframes" it will try to use it every time. In
>> next we have:
>>
>> 	if (compat_fp_state(state)) {
>> 		frame = &compat_fp_frame;
>> 	} else if (sframe_state(state)) {
>> 		/* sframe expects the frame to be local storage */
>> 		frame = &_frame;
>> 		if (sframe_find(state->ip, frame)) {
>> 			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
>> 				goto done;
>> 			frame = &fp_frame;
>> 		}
>> 	} else if (fp_state(state)) {
>> 		frame = &fp_frame;
>> 	} else {
>> 		goto done;
>> 	}
>>
>> Where if sframe_find() fails and we switch over to frame pointers, if frame
>> pointers works, we can continue. But the next iteration, where the frame
>> pointer finds the previous ip, that ip may be in the sframe section again.
>>
>> I've seen this work with my trace_printk()s. A function from code that is
>> running sframes calls into a library function that has frame pointers. The
>> walk walks through the frame pointers in the library, and when it hits the
>> code that has sframes, it starts using that again.
> 
> I think Mathieu has a point, as unwind_user_next() calls the optional
> architecture-specific arch_unwind_user_next() at the end.  The x86
> implementation does state->type specific processing (for
> UNWIND_USER_TYPE_COMPAT_FP).
> 
>> If we switched the state to just FP, it will never try to use sframes.
>>
>> So this state is more about "what does this task have" than what was used
>> per iteration.
> 
> While there is currently no fallback to UNWIND_USER_TYPE_COMPAT_FP that
> would strictly require this, it could be useful to have both information.
> 
> Or the logic in unwind_user_start(), unwind_user_next(), and *_state()
> may need to be adjusted so that state->type reflects the currently used
> method, which unwind_user_next() determines and sets anew for every step.

I concur with Jens. I think we should keep track of both:

1) available unwind methods,

2) unwind method used for the current frame.

E.g.:

/*
  * unwind types, listed in priority order: lower numbers are
  * attempted first if available.
  */
enum unwind_user_type_bits {
         UNWIND_USER_TYPE_SFRAME_BIT = 0,
         UNWIND_USER_TYPE_FP_BIT = 1,
         UNWIND_USER_TYPE_COMPAT_FP_BIT = 2,

	_NR_UNWIND_USER_TYPE_BITS,
};

enum unwind_user_type {
         UNWIND_USER_TYPE_NONE = 0,
         UNWIND_USER_TYPE_SFRAME = (1U << UNWIND_USER_TYPE_SFRAME_BIT),
         UNWIND_USER_TYPE_FP = (1U << UNWIND_USER_TYPE_FP_BIT),
         UNWIND_USER_TYPE_COMPAT_FP = (1U <<  UNWIND_USER_TYPE_COMPAT_FP_BIT),
};

And have the following fields in struct unwind_user_state:

/* Unwind time used for the most recent unwind traversal iteration. */
enum unwind_user_type current_type;

/* Unwind types available in the current context. Bitmask of enum unwind_user_type. */
unsigned int available_types;

So as we end up adding stuff like registered JIT unwind info, we will
want to expand the "available types". And it makes sense to both keep
track of all available types (as a way to quickly know which mechanisms
we need to query for the current task) *and* to let the caller know
which unwind type was used for the current frame.

And AFAIU we'd be inserting a "jit unwind info" type between SFRAME and FP in
the future, because the jit unwind info would be more reliable than FP. This
would require that we bump the number for FP and COMPAT_FP, but that would
be OK because this is not ABI.

Thoughts ?

Thanks,

Mathieu

> 
> Regards,
> Jens


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

