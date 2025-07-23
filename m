Return-Path: <bpf+bounces-64172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF128B0F55A
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203047B4802
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E332F5325;
	Wed, 23 Jul 2025 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ekENLtkX"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2124.outbound.protection.outlook.com [40.107.116.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B152F49F0;
	Wed, 23 Jul 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281165; cv=fail; b=uF7LB48s461/D3J7c6d8CHbWj28v/qW6HpGTz04F0GNUNkpzJrHK2lwqtMyklILig1oyd0QkbD6hdUQGUwRc/4E775pZZe/7qE+iTuC6oR1pPrSkbQk6lTqYGsUIjHZyw7YDslB9K6qtUXPnaWp5PQiNzW54Qx8g4JlTxK3v+DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281165; c=relaxed/simple;
	bh=CD7kLWKmQg0h3+1v3bqX9cQF8j38Tna9DMnI9G94yOs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HGGV5Y/ADnUHOJLdwRaCPB9NS79+SwfCXkb4oHoZQCm9bcOpZlVIjmnpOCC2i+nUtyHon2SvSfXLyGOW2A/dtTHhK+KjHXF5e2NZOQ/aa9PyQflS8ej6YsV4zwiZSLKjbT/0hKEoD2I8gsVfO7JJrfTvvHor+1kN9iuG0snMXws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ekENLtkX; arc=fail smtp.client-ip=40.107.116.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAq/Q8kvrEwZXTBT7xagoQpr4caZ2LgW7marjpCgwUiYtPkLrO0C1gRioDNdyh2uS8/jg1PKSRQ6q0uPTy8sPZVnzzOeE/ZdkijUP3biZhvEvzEg2Jd1YM8T/nLXY6945n7s1VR+LP5Z6BIdOCvadvjNisffT22dn2UWQxBzhOROdPojtq/TpuRnN4VfNiCNINd4ISl+68CARvzz9cvmiJJfOpt6yxLUNNleDqsHBHN/CPAVEGgXhQ82uFM7onYmxs6V15KGE3QE5yTeMpTJIArTwqOjzXv2/v6U9PoatYvnGpaS/QVd8NRM4yTmjlm9rZ1OQ2fyDIBvzWjGE8gA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBzP9bEnG7bU70++lRRmSILz/D3ax/xhZ5lN5Ftfuz8=;
 b=lH5W5/ekyfBcKO5wpae0KMGatJJP8irJPvsDt+Bh0OzRzm83Yj/Jz1JIAfT2/br7tabsIS5kmfAjuAeDZ4danTwxNbOxpHAw7HqN7vDrUtkI1rJ81EIg4LWmBRcX5uPWPojj65dVP+F/MFP6tOVxKYsRQinPfnSticEQ9OvyHSKKFRUX5BRMFuKCWf5sPEpCclrw8Ie078rckz5A8fDnj+Ly5YJgBXwfewRZFjBlus/3fS8t1NDLPl5rUd8Eqna6ipbyIeHuqtPblb4ac/RW/0m0h/n6n7laKNJeeC67agIZDghXF1gY8+oTeVUWWOiskW4Wo2D8+nLYUreuoWIXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBzP9bEnG7bU70++lRRmSILz/D3ax/xhZ5lN5Ftfuz8=;
 b=ekENLtkXUyoOMCsAydStlM6WpY0OfQJrBSdQsoymUaYwiVB2oX/J6irbKPvRNIgY6JSJ/VAGm3t3D157alBYHjw/vHkxnnymH4ErBqObGtY+2BMYJMIoT0ZqYedGGmFcqInZ0X8ygb3FmEbcMMvP5JXfAvhJreE6GjzfZXCulLmixVlEiez1iGNmy5+WHfPnjFVenG0kyD/IyqLqA9dbL41Vhttq6AtNmE4befWhjOklVisryIKs3wIGAc+NnwDpDQI/hTZ4a2JwoVnEKHySgO78SSUYxrhWbZEwBjDzXt/DGCNyyUq5ZorszRrAIpxoZfpzSErurd/XHziFhlsIeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5466.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Wed, 23 Jul
 2025 14:32:39 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 14:32:39 +0000
Message-ID: <1ee4cd59-39ca-46b3-bf60-38d2042e67e2@efficios.com>
Date: Wed, 23 Jul 2025 10:32:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New codectl(2) system call for sframe registration
To: Indu Bhagat <indu.bhagat@oracle.com>, rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
 Brian Robbins <brianrob@microsoft.com>,
 Elena Zannoni <elena.zannoni@oracle.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
 <69d09381-2315-4c95-ba5a-28d148ffd19d@oracle.com>
 <79b59f16-3f77-4e94-ab85-dc454b1df18e@efficios.com>
 <cf26c916-74a0-4945-981f-0c3c9d9bfd40@oracle.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <cf26c916-74a0-4945-981f-0c3c9d9bfd40@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5466:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eeac1a7-6f02-4e7a-97fd-08ddc9f5c6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEhSeDdPNFRXOXRYTG92YXVQOEVhZ05VTWhnZXgxZDN6OElyc2FCaCtEdko0?=
 =?utf-8?B?LzN0U0NWckFmWTQ4TTBDY05SOHVQcjh1a1lxMkI1TG1mVlF0UWx5aTE1c3F0?=
 =?utf-8?B?UW9EQjZqRmxxckhtSWo2TmNJNWEvdzh6ZXVCMVdVRmdrVnFFK2ZvL1o2cHcw?=
 =?utf-8?B?bWg2YXlCaFJBRnhxdEN6SnZ2SzlYL05QcmUyN1IwQ24raXdiWFpUa0k1b1hG?=
 =?utf-8?B?TFNPREFXTGhrc2x4cUgvL3UwYlNOOUM2Ujl4QXI3cDdnZzVEMGhDUnBBSG4w?=
 =?utf-8?B?d2hxNTc3NjI0ZVoySGlLVHhpV1RoS2IwOUMxTG9RaWt0TTh3VGlTVjF0Njkr?=
 =?utf-8?B?cFBlSmplN0RVZytaNmJubytkT1J0RjhnbXZsYTN6QlUyYzBsYnl4cmpKWExP?=
 =?utf-8?B?YjZOaXdXVkFQZk1WUVZHeVVrZEV0UjJsRWtTZkZNczJNejl4RFdJMDFYYzNp?=
 =?utf-8?B?ajlNUGF3TWl4TW1UUUVwOUJScXJHRVRKb2hPR2l4bUNuQ2JTaDhacVVnWldX?=
 =?utf-8?B?STdlQ2dlTXJCMU55OFZGTnBGWHA1TEpyZ1dQWXk3OFBIYi9IWXdFMHVtTnhE?=
 =?utf-8?B?NXkxM0ord3BSQlJ2WjRDNzg3S3MzcEcxTHowUWZSTHd2YXZ5ZUUxaUhDNUM2?=
 =?utf-8?B?VjFGRW1XdFBxR2pRLzUyU3VPVFRXU1pMZjFsd1V4QjhzQnBWQlRETDY1ZHJC?=
 =?utf-8?B?SzE1cUZLaU9mV2QydXRGV01zMWhmV1ZjMUN3MUl6clpZUElTNGxNRkRTdFJJ?=
 =?utf-8?B?bUZWMGlHak4veFRpcS9rOXJkRWVaY2VsMEQ5aXduaFJvdFgvS1BXd0txZ2ds?=
 =?utf-8?B?dXB1OWEwQS9zWFE0cG5TQUd2d0VMZjRaNzJlUm9XU05KaXBPMWhUSTV1c3Q0?=
 =?utf-8?B?NHcvVnJWZTR2NWZjR09ib3V1WG1vVXAwMndRR2FOZlZkUTV3TkRVd3V3VmRl?=
 =?utf-8?B?Q3VSR212dks4WEtrNWNna0d2cmFsbUFUd2VVdS82Tmk0am8zUDcwNksyNlEw?=
 =?utf-8?B?a2ZTRk1nUDUvWC84aWdNM0R3Q2h1WWFqWWtyYVJSa2M2MU1RVmJ4OXNVd3lI?=
 =?utf-8?B?SW5BM3U0N1hLOTkyMFBRdENLRFV0VEZIUVUrVDRTYXpndG1LeHRVQ0x6cXE5?=
 =?utf-8?B?YVF5VG1VZlh0a0cvR2VYQXRQWHpyM3ovRlF1akpHaFFqcjVjdWJ6eVZ6dUlo?=
 =?utf-8?B?ay90VEhsejJQQndzM1ZIOGZsN0U0R3c1K3JSV0IvS1ZwR1M2cllpMnhQT1hR?=
 =?utf-8?B?S3F6TkNCTmJiWHVVMlB4T1lXMVZ5cFVMSDdTZUd3ekJBOWcvM0pGZEFiYnRp?=
 =?utf-8?B?ZGdoTGJYSlVrQjNVOUd1N3ZTNVlHR0hrZTk3QndjWVhJcWNyUVR5ay9NUXBU?=
 =?utf-8?B?c3BBQUNLMGFoVi9WRUE2aTEyY05mb3NrajVMem12NWUvTUUweVNvUzJrd2pF?=
 =?utf-8?B?U0xaS2RjMXdoKzJLZFZQTitHN0pIOFZ5a04xK091NThtUFZnOFI5M2FmRmd5?=
 =?utf-8?B?UHBIVC9zWGVQaXV5K3dZMGRLeEl3akZFdVZyWVhnMEIvNk56dmw0TVBqKzVu?=
 =?utf-8?B?WE1sTUZSbTZ5SVd5b2tGRlpuNHJadkhYYTJZc0Rzb2dObTAvR3U0NU96a0kr?=
 =?utf-8?B?TmdySDgrbGNSaHRQTHRLTVVYOXZBRlpWa3RoY096Rmc4N2VpL0QzN3RUTzRw?=
 =?utf-8?B?UHJRNW1RYTBZcFMrNzlMblFBRmEvOTFpK1JKaTdIOExJb0FqTlYreTVRKy9Y?=
 =?utf-8?B?NVJ5N3lwcTUxNDRYZXZ1SENSQnlJQ3NHbVZGRm5pMFNQakFMQVYvdHRhSmJE?=
 =?utf-8?Q?UlyiABo6Vj9XwxPjLq6hsl03Og/nmXFdAR10Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXdENk1OMGtFRVF5VFFReEhZdW5TR1BCMlJLWFdySzJ5UE9pSEprTmZUV2FG?=
 =?utf-8?B?R0xSejZjZ1hGc25sZmYwVTVkNzRYa2JUMU9DZ0dlVjVQOXBLdTNhTXpWMVdO?=
 =?utf-8?B?NmJDblZ2SlZrTWNEWmd6OGIzQmhtd3RLOW53eUJqdEtyNDRhMTZ0dmd0Q2lL?=
 =?utf-8?B?c3c2elphbnRzS1dHQmErWS84YzJPN05HaGlGdE5kUE5rdTNQZGg5L05pMEdt?=
 =?utf-8?B?ekY0dWdKSXFLRVVzZEswOVRmTXhLS3psWjcwZkdPazVURnJNUXBhRFFIMmFx?=
 =?utf-8?B?QlRnQkhhN2g1RklRUUZLYUswWFVoVHE1blBlbGRFUE9zTEJsbWFkQ3NnU3lR?=
 =?utf-8?B?a1R0N2JtZ080bHZscUh4Mm9ZTHlMc3VuWm1KM0lraUxKWXVLSXBZSkNOWlow?=
 =?utf-8?B?YVhEd21EbTR1WjhCRHZMTS81R1I1bGtwSC9wd2xYdk9aWFEyTk1zNjFTK3Jq?=
 =?utf-8?B?RlphZU5COFFBUzdHT1d2M0VPTGorVzNKZlpGZFkwd2o3cGxYMHhMM2NwMTJO?=
 =?utf-8?B?RnFDQ2llV2N1NWlJMGZoM2loKys4UFpZd1VzSFVwVnpodjFxeUcwS09RMkVt?=
 =?utf-8?B?U0doNG1Lc2RCTEw4eTM1VTV1dEdCdnIxcXphUytNeHpVWjd5ZmM0UGlNc2pW?=
 =?utf-8?B?UmJEK0dObDRMYVQ0NmswQmxGeWZmMWlFTVZ1bGpzNXNVSWcxOGFjTVR4UDJv?=
 =?utf-8?B?Zm5adkpZVFU5WXBOWTlJNGl1MnNVVGkzVElwZHo1a2NQeURHMzBSTVhTUGhr?=
 =?utf-8?B?QW85cFpIcnc1M1BneC9saG4vSkd4Q3NEYi9JcWRKWjNiQ2Y3eFh4K1lKbytG?=
 =?utf-8?B?NHlrM1RjL2dOVVFjaUV6S2RETGE0eFBEUlFmbXJuSVEyaFdTK0RHb0pLOWNV?=
 =?utf-8?B?a1BHZjVTWmhoL1hnSHdObGVvOEExNEVsa2lpcDdjZlJkTGRwWVIxbzF3ME1s?=
 =?utf-8?B?M1hUeGNCZlBhUEQrSWcvSHhMMmM0TjRZc2NYNDk3TTA0ZFhNd3lzaVhRLzdt?=
 =?utf-8?B?ZnQ5UFBzU1JVY2ltVSs0NGRyc1dzRElKUmpkMjF4WkZHVlpRU3BiTDdSV1pS?=
 =?utf-8?B?U3FPenoyWFJDc2tJVTd1OUdkMy9NQm1BQ1M5ME1yUTBHc1IrYVZDRThHZm13?=
 =?utf-8?B?cmZtTzZqYkRzNUpBVzdFUkp1YVpVbFZHT1lDVk5KUHk2Z1hQNG9pNk5hdURs?=
 =?utf-8?B?MHV5MXhsbHB3NzFmUVNsMGtTU0x5T3RwNU03N1BXeVJncUtjUGI3Z0dLbVlv?=
 =?utf-8?B?bW1ZQjlOY1lIN1lBc0EwbUYzSEVGbUZQeDlhT2FDZ0FRUlRMTE5hUWdlT0xR?=
 =?utf-8?B?Q3ZOTGRzQlJTMkFkTjF2dlpjckxBbGxSb3VpZGFIeG1xYlpxSDRMb3dDOGl0?=
 =?utf-8?B?N3lucWQ5bXowUzBEcTBmak8rWGlQdjRPMTFIdVlRNGZiZzNnTWMwOEtzOFl2?=
 =?utf-8?B?SGFtaDVBcDQ5ajBwQlhmZ3ZIRGk5dzdkWHYrTkVrRmtRcEphYlJVa3QrK2Uy?=
 =?utf-8?B?K2d0V3dtQURtcnlybGZsSXJDZUwxVVowa01WK1FaSGlLVjNDV2lrY3JjdHVE?=
 =?utf-8?B?QkNCTnl2bFBoTjZGbE1rRHhNQ2lXYTA2ZUN3czhuV3VLT2hkK1ZpaHRYelFW?=
 =?utf-8?B?enFZRVlSRXY5QTNNb1VpZHdYK2p1Y2dVN09qVjM0TDlhd0xpRjY1N09BaEZo?=
 =?utf-8?B?djBVNlgvZzl0TW5KNDdTeGY2Q2FwM0I1bWpCQk1IUmhZRFBCM0ZXbS90VWdi?=
 =?utf-8?B?dE9lakRSUGZlNXRQaERWd0lYbkpRQkEzeTZyaDZIV2E2UUE0TDcrNlVjM0NS?=
 =?utf-8?B?bjVKd3UvWDdQVFBDekltU1FRN0RIUGJMV1Q5ZHliTk81dmtNajg4aDVVYS9P?=
 =?utf-8?B?cG1lcDJkMDNSYzFEeTEzVk9MTE5wdGdvRlBOQmlhR0VoY2dHQ0VRZE83ckVq?=
 =?utf-8?B?T1B2ZXlkbG93YXhKZEdUb2RwVkcxajlVYUJzWE5tM0FyYkRlcWhoZ1djajlP?=
 =?utf-8?B?RTBENTlab1dIMUphY1BQclRzQW5lZGV4c0M2L3BLRzIvVnJ4QkwwOFlXYmU5?=
 =?utf-8?B?ZjIvNGEycDQ5MEtCSnpwNnpyWmhiRGNLd3ptRFZrOCtFTG9JNExmWUV0WFpT?=
 =?utf-8?B?OEZhUlFhRHhjcHAxMFllK1MrbVhJSUZ1OUtYZUQ0dVVIRXBRZVVUM0U0QkJ5?=
 =?utf-8?Q?9FbW/n3zS1GYqxNXdBr8E1E=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eeac1a7-6f02-4e7a-97fd-08ddc9f5c6a3
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 14:32:39.5701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxLXjVpOgmRF7XRrlIKzK2mN8VLFTGfKTgdep73JMa3AISKr60cAvuoxdskGYH7nRduvziyYm2eIr4Q4ETgwtsx+ZJkiiUuc4UbxjiYZ8xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5466

On 2025-07-23 04:16, Indu Bhagat wrote:
> On 7/22/25 11:49 AM, Mathieu Desnoyers wrote:
>> On 2025-07-22 14:21, Indu Bhagat wrote:
>>> On 7/21/25 8:20 AM, Mathieu Desnoyers wrote:
>>>> Hi!
>>>>
>>>> I've written up an RFC for a new system call to handle sframe 
>>>> registration
>>>> for shared libraries. There has been interest to cover both sframe in
>>>> the short term, but also JIT use-cases in the long term, so I'm
>>>> covering both here in this RFC to provide the full context. 
>>>> Implementation
>>>> wise we could start by only covering the sframe use-case.
>>>>
>>>> I've called it "codectl(2)" for now, but I'm of course open to 
>>>> feedback.
>>>>
>>>> For ELF, I'm including the optional pathname, build id, and debug link
>>>> information which are really useful to translate from instruction 
>>>> pointers
>>>> to executable/library name, symbol, offset, source file, line number.
>>>> This is what we are using in LTTng-UST and Babeltrace debug-info filter
>>>> plugin [1], and I think this would be relevant for kernel tracers as 
>>>> well
>>>> so they can make the resulting stack traces meaningful to users.
>>>>
>>>> sys_codectl(2)
>>>> =================
>>>>
>>>> * arg0: unsigned int @option:
>>>>
>>>> /* Additional labels can be added to enum code_opt, for 
>>>> extensibility. */
>>>>
>>>> enum code_opt {
>>>>      CODE_REGISTER_ELF,
>>>>      CODE_REGISTER_JIT,
>>>>      CODE_UNREGISTER,
>>>> };
>>>>
>>>> * arg1: void * @info
>>>>
>>>> /* if (@option == CODE_REGISTER_ELF) */
>>>>
>>>> /*
>>>>   * text_start, text_end, sframe_start, sframe_end allow unwinding 
>>>> of the
>>>>   * call stack.
>>>>   *
>>>>   * elf_start, elf_end, pathname, and either build_id or debug_link 
>>>> allows
>>>>   * mapping instruction pointers to file, symbol, offset, and source 
>>>> file
>>>>   * location.
>>>>   */
>>>> struct code_elf_info {
>>>> :   __u64 elf_start;
>>>>      __u64 elf_end;
>>>
>>> What are the elf_start , elf_end intended for ?
>>
>> The intent is to know at which address the first loadable segment of
>> the shared object is mapped (elf_start), and the size of the shared
>> object mapping, which is the sum of the size of its PT_LOAD segments.
>>
>> This allows tooling to easily lookup which addresses belong to that
>> shared object, for any loaded segment, whether it's code or data.
>>
>>>
>>>>      __u64 text_start;
>>>>      __u64 text_end;
>>>>      __u64 sframe_start;
>>>>      __u64 sframe_end;
>>>>      __u64 pathname;              /* char *, NULL if unavailable. */
>>>>
>>>>      __u64 build_id;              /* char *, NULL if unavailable. */
>>>>      __u64 debug_link_pathname;   /* char *, NULL if unavailable. */
>>>>      __u32 build_id_len;
>>>>      __u32 debug_link_crc;
>>>> };
>>>>
>>>>
>>>> /* if (@option == CODE_REGISTER_JIT) */
>>>>
>>>> /*
>>>>   * Registration of sorted JIT unwind table: The reserved memory 
>>>> area is
>>>>   * of size reserved_len. Userspace increases used_len as new code is
>>>>   * populated between text_start and text_end. This area is 
>>>> populated in
>>>>   * increasing address order, and its ABI requires to have no 
>>>> overlapping
>>>>   * fre. This fits the common use-case where JITs populate code into
>>>>   * a given memory area by increasing address order. The sorted unwind
>>>>   * tables can be chained with a singly-linked list as they become 
>>>> full.
>>>>   * Consecutive chained tables are also in sorted text address order.
>>>>   *
>>>>   * Note: if there is an eventual use-case for unsorted jit unwind 
>>>> table,
>>>>   * this would be introduced as a new "code option".
>>>>   */
>>>>
>>>> struct code_jit_info {
>>>>      __u64 text_start;      /* text_start >= addr */
>>>>      __u64 text_end;        /* addr < text_end */
>>>>      __u64 unwind_head;     /* struct code_jit_unwind_table * */
>>>> };
>>>>
>>>
>>> I see the discussion has evolved here with the general sentiment that 
>>> the JIT part needs to be kept in mind for a rough sketch but cannot 
>>> be designed at this time. But two comments (if we keep JIT part in 
>>> the discussion):
>>>    - I think we need to keep __u64 unwind_head not a pointer to a 
>>> defined structure (struct code_jit_unwind_table * above), but some 
>>> opaque type like we have for SFrame case.
>>
>> What is the reason for making this an opaque type for sframe ?
>>
> 
> So that the system call only does the work of registering the memory of 
> specific size as stack trace data for addr range (text_start, text_end). 
>   IIUC, in the current proposal, the format of the stack trace 
> information is exposed in the arg. So when the format evolves, this will 
> mean additional management via some flags?

There are various way to handle extensions here. The simplest
would be to add a new label to enum code_opt and register the extended
JIT abi as a new option. But this would likely involve a lot of
duplication if the goal is just to add one more field to struct
code_jit_unwind_fre.

I suspect that the unwind table and linked list of unwind tables is
something we won't want to change for this ABI. What I see could be
a relevant extension point is struct code_jit_unwind_fre, but given
that it will be placed into an array, making it extensible requires
some care: we'd need to keep track of its stride. We could do it like
this:

struct code_jit_unwind_table {
     __u64 reserved_len;
     __u64 used_len; /*
                      * Incremented by userspace (store-release), read by
                      * the kernel (load-acquire).
                      */
     __u64 next;     /* Chain with next struct code_jit_unwind_table. */
     __u32 fre_stride; /* Stride of fre array (includes padding). */
     __u32 fre_size;   /* Offset at end of last used field. */
     char fre[];
};

So extending struct code_jit_unwind_fre could be done by adding fields
at the end, thus potentially increasing its size or turning padding into
used fields. fre_size would keep track of the "used" fields.

I'm open to extend by size (with fre_size) or using flags, whatever fits
best.

Thanks,

Mathieu

> 
>>
>>>    - The reserved_len should ideally be a part of code_jit_info, so 
>>> the length can be known without parsing the contents.
>>
>> I've placed reserved_len within the unwind table because I planned to
>> have the jit information for a given range of text be a linked list of
>> tables. Therefore, if one table fills up, then another table can be
>> chained at the tail. Having the reserved_len part of each table makes
>> things easier to combine into a linked list.
>>
>> Thanks for your feedback !
>>
>> Mathieu
>>
>>>
>>>> struct code_jit_unwind_fre {
>>>>      /*
>>>>       * Contains info similar to sframe, allowing unwind for a given
>>>>       * code address range.
>>>>       */
>>>>      __u32 size;
>>>>      __u32 ip_off;  /* offset from text_start */
>>>>      __s32 cfa_off;
>>>>      __s32 ra_off;
>>>>      __s32 fp_off;
>>>>      __u8 info;
>>>> };
>>>>
>>>> struct code_jit_unwind_table {
>>>>      __u64 reserved_len;
>>>>      __u64 used_len; /*
>>>>                       * Incremented by userspace (store-release), 
>>>> read by
>>>>                       * the kernel (load-acquire).
>>>>                       */
>>>>      __u64 next;     /* Chain with next struct 
>>>> code_jit_unwind_table. */
>>>>      struct code_jit_unwind_fre fre[];
>>>> };
>>>>
>>>> /* if (@option == CODE_UNREGISTER) */
>>>>
>>>> void *info
>>>>
>>>> * arg2: size_t info_size
>>>>
>>>> /*
>>>>   * Size of @info structure, allowing extensibility. See
>>>>   * copy_struct_from_user().
>>>>   */
>>>>
>>>> * arg3: unsigned int flags (0)
>>>>
>>>> /* Flags for extensibility. */
>>>>
>>>> Your feedback is welcome,
>>>>
>>>> Thanks,
>>>>
>>>> Mathieu
>>>>
>>>> [1] https://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng- 
>>>> utils.debug-info.7/
>>>>
>>>
>>
>>
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

