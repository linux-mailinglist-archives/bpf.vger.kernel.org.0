Return-Path: <bpf+bounces-62190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF47AF62D4
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BE17B0CF3
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517E32D77F3;
	Wed,  2 Jul 2025 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rbXgPJpU"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2128.outbound.protection.outlook.com [40.107.116.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EED1F3FC6;
	Wed,  2 Jul 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751485706; cv=fail; b=iJHreUSjkMyV3bdX6vkv2dNsgtnqckeCwLIvkmjvayoTCIPOO6wNYXWZo//CVZpCiJUZrV5/LWsIiTXMjVttI5BROouYqKrUWb/FMV0wwFZFclGtI1gY8EWPq4gZKmMF5NbKdtc/9gWRZAyrL/T4k3TccPs6ZA6kN3mjkqo68gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751485706; c=relaxed/simple;
	bh=I7eQgkB5RGExAmwpMv+cY1ykJPHM/AY3UECAQahm8DU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X5WvV2f/2d8o+z93+uHjyYghAqtGRGN+MFj8j611ZuSHaIXLY7sBNkmWAELUJjAoK2mLz/UuwrMoLi8U0VCcFIpJ8QzwCTbelIuA/WwX9+pNCWLbZgj6IR7MdIWviMFfZCaJyK3mDiSQprP0wPS1GcykCXbei+w8dl1sxTPbtTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rbXgPJpU; arc=fail smtp.client-ip=40.107.116.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8VsGHMnxd3jjW2LeaU+fKB9nyPPxgF0GuVRBXox0UVVKimJTT4d6UO9NHxehbYDI2wv8LU908Me66Dsyqv42v4ZJaWRQKKDpUbfydbuhl1t/9uOhlgqNBiAJ4zshhe3xNmZq363jHOIk3B4qVGoeQUIaz4voA+kOrgm5eNG9tkABkspfKNbJ+dIjwHD4JW6YjHpl2+T50d9wF4PrcCyeBhPyoRbV+hBio5YRZEXkeSApsVzORFYejrUiBHuQWSMH6xfLCvo8eo63GOAQPuN/c/79C66jxTLT0Ip96KMVcFufGrqRZ0CZKrj+caR89j9N5V4kmZtbKgFfn4kP+hMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbe5wsMxx6O7ierqaxzXok4FasyKx5S2aVD5L8IKBYQ=;
 b=y4hdOpCCQbP5yDjlrFvNkraMQLAV5v4NByEgAASTQt4mdegtcuZ8nHGvDk8rzo+1ZefjpRpNci7epQW67Q+Ckcr7iLQ4fsYkHeDWUPI7iulfPkaKlOvjWOb5KyyBIIeoGhxJ9xy6mclPfywTWXoUlQ20XXMH3TNcqAUzKsJXdL3HdiDPERxUjeR0H5ATZqqErogLHusg3v9Ax3f2Qz7NaecFh7Va0rIti6B7RIM4xdbDFsEWx5iryF0omkaZMFXgTnH00UXLHcOaGncw+ugCwQtrOiHKVQqUyVqN1gluDa46Yw0vnukcOPqp0SDq+zvtJQEHKmVy7gnNB4HIHvxonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbe5wsMxx6O7ierqaxzXok4FasyKx5S2aVD5L8IKBYQ=;
 b=rbXgPJpUpnoiKWtpId1SCb0sP0EMYMh+UjJGYMZ4MTv2MMGMv/ozplfaZt0+y7vmgwm56AcwardEWHxANbr1OoKeZh5vxlLe53CSVn8E7ATPIqQGwXcIf7ftRfvKIrmDwiHImUTtlenflZ+BtGVu99RwcIG9oK5Qz0zvckhaChu4mkn9XD+kX87tjtY7lW3GaLxEFyodIrhtsO5tjRr/kjT+9sE00oRFMKhXbgUFWyxrLemakFShECdBk6pfr4JGdd4XHWKtE3yg4Nc+tE3/LGG6GYrOFCfZFNhXOzO+CXU+WV+ZNl4x3c/gDcr7c0tcP8lwxBaAn6yNVYXqS3u/pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8896.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 2 Jul
 2025 19:48:19 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.021; Wed, 2 Jul 2025
 19:48:18 +0000
Message-ID: <16b8f9a8-b1f8-43ac-9dad-4b83d8ca9f9f@efficios.com>
Date: Wed, 2 Jul 2025 15:48:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding
 interface
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
References: <20250701005321.942306427@goodmis.org>
 <20250701005451.571473750@goodmis.org>
 <20250702163609.GR1613200@noisy.programming.kicks-ass.net>
 <20250702124216.4668826a@batman.local.home>
 <CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
 <20250702132605.6c79c1ec@batman.local.home>
 <20250702134850.254cec76@batman.local.home>
 <CAHk-=wiU6aox6-QqrUY1AaBq87EsFuFa6q2w40PJkhKMEX213w@mail.gmail.com>
 <482f6b76-6086-47da-a3cf-d57106bdcb39@efficios.com>
 <20250702150535.7d2596df@batman.local.home>
 <47a43d27-7eac-4f88-a783-afdd3a97bb11@efficios.com>
 <20250702152111.1bec7214@batman.local.home>
 <20250702153600.28dcf1e3@batman.local.home>
 <20250702154048.71c5a63d@batman.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250702154048.71c5a63d@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::30) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: a1714a61-a431-421a-0514-08ddb9a16478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2VUOUZHZE1JMTIyY2JEaHRxNjdSeHdkTXlERWlublVkK3owUGlKUkpqMWNY?=
 =?utf-8?B?bVpHcjYwVjloNmhwQy82SlhYVjVzdythVksvMkRZOG5pSDJBQ2VRS2I2M3Uv?=
 =?utf-8?B?TytjWFh6WVl0VHNobE15a2pvM3N5SG43YTArRjR1Nm9iU1FoUDB2bGlGQnBz?=
 =?utf-8?B?ZjMyUlQ0UlpjS0pEWStwVlpjZ0dEbktSRWRoeGVNVEMyTmwycFZOdXJINnV0?=
 =?utf-8?B?MGgwNTdFVW9LaEF2NWgwMTA4S3pJalVSaklWdjRFOXJUK3dxczc2YTNGNE1v?=
 =?utf-8?B?ZzJHNFdTM2NERmpkOWtXemN3YTNsUnh5NUF3RXVLMWsrcU04TVJqY1pEK0Vm?=
 =?utf-8?B?ZnVVZnIvUDFGZzN0SDkzdkhVTUZmTk50OEFwNDh0aHNkSW1lVnJ3RUtMMC9o?=
 =?utf-8?B?M082d3FkSXNwZ2E1ZnN2MzBFYzVKU0hUbitsN0JqemdUZTEzeXRMTlRoWWw3?=
 =?utf-8?B?UVJ2c09Oa3cwbng2MmJ6TGR3UlYxaGxFV1JpeFBYcjVWSzNWVFgyckdsWTU5?=
 =?utf-8?B?aVFRNk8vQVFFN1lrU1FHT3FtUW9ibVlyYkltWElzSGlCdFNHZFF2bTB3Rjg3?=
 =?utf-8?B?Wjk3bVBVamk2ZHZZSUJQck1NNm1zeGU1ZW9ZdThjd2hoK2RRamxveS9hU2RT?=
 =?utf-8?B?THk0Z2ViL2lWaXpaWnhzRlhiL1RxREVYK3lweDRQQ1phd0hsTFUrRm1SQkJh?=
 =?utf-8?B?TjJVZmh2b3cxRFZpaDd6aThHNXowcVVwckxvbzlPT1VuZnQ4NWJ6VmpWL0Yy?=
 =?utf-8?B?ZGpZajYrbkk0NjQwQjlIS0M4SFJGRXFKYXlqdkhVYWFDdThJK3N0Rm1YRnhR?=
 =?utf-8?B?c2ExeG1oTkRVMHFZVEhMQlhwd3FZYk1LUnBoUDMrM3JFSHRJZVduS1ZuK1ZL?=
 =?utf-8?B?aktSMHZDbC9GWXUwVnBuSmtaNTU2dFozdXpYaXIwMHNoUWR0SU5MS2dzd3lT?=
 =?utf-8?B?RGlXNlJDc290eXRwZEk4WGlmNWpLa0d0MXF3OFI2dkc3UVJYYVV2cm85SXdC?=
 =?utf-8?B?NlBZS3VDdk1hU3EyOVJucEpCRlNURC9pN0x1d2tMT3JOZ0dJcTRwZHRPMDJ0?=
 =?utf-8?B?TWp6Vkt5Y0lxejVFQmZkNlNoYlBWOG5XSVFRcGdCc0J5Qk5DSEtib2MrUkFm?=
 =?utf-8?B?ekZ4TFBvODYwbUEveTBCa2pZZ0h2VVhJTkhZaXVFeWV2N2xSaTdnczhsWjZ5?=
 =?utf-8?B?bzRqaGp6Z3E5cWp0b25zUWw1ZEx5VDRKZERZdTBPNDVnem5uY2tucVpyT1Nn?=
 =?utf-8?B?Y3l4RGV6bXNZQ0cvdDl5Z2NUZkE4eUJGdTJVbmNZUi9sYzlBOTQyQi95TklF?=
 =?utf-8?B?NTNENDk4NkdiZGtzRjdOaTc3bEExOVlvVGtvd0FUd2p4ejRVekJUOTFjeU50?=
 =?utf-8?B?NkxIbk1GYzlKQ2Y5V05KWmFxeGRGTE9yTmMyRkwybVV4bVdPejFVNytHR2xr?=
 =?utf-8?B?cjhLSHc5Wm84RnY5UWdGVFd1YlVrbzNtcHdyUy9MbGdqSnltYXJ0Zk5UY1dh?=
 =?utf-8?B?OHU1SFl3cUJsSllIMXk4MFJzUXlNaUVYbDcvWWZDdHRnOGJtK2NpRUNDUjE1?=
 =?utf-8?B?OUV4bzBBNUNWT0RwdjBYbjRQSjhNdlRUSGF5SzB2cG1sL2ZxYnF0NGxiWW81?=
 =?utf-8?B?QjZ6WEtYcFJRaVk4U213L0FkYVp2cEp0RHFSbFJybzcwTTNBWDNsdlpCWGZJ?=
 =?utf-8?B?ZWJaRlk5WTJyRHd1bGE1Y2dFRnBCcmtkc2NYVTFicVA4c09vVURFNTR2MlVE?=
 =?utf-8?B?MjZSRVVPaGlLeVFOdGpmNk5TcmtvY3dDa0k4cStSQWU2US9xQ2FIclpjbEEx?=
 =?utf-8?Q?ZARQcVXos5LRSisjCILRupIbztR4DocdAfcFI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXNuczEzUVQ1RmRNS0FwS1o0TlRsNFA4cno0KzduanhtTUNMVU9wMUVvR3F1?=
 =?utf-8?B?TkdjTXRIeVhiYUVmWEhpM3diMEhOd090eWtXeW9jeGN3U2pHWTY3cGVaeTJ5?=
 =?utf-8?B?RTNUbkFMaGZSYnhXWldzUEdoSXE4M1JjSkhZQUZ3M1lOZVhFZmRhREVYMDZS?=
 =?utf-8?B?S09HbnpVaGZZYXFlRlF4WEpjU1NGYnlzL3lYbCtkanFLMlZnLzBYek4rU0xE?=
 =?utf-8?B?Mis0dFB4R2RHNW5PSTBZNk9GelpKQVllVi96Mmhtcm93R0dab3FxZ3dzTTJS?=
 =?utf-8?B?ajZwMjFtbXRTaDZiK0xxaVZ1UHI3TEpUdGdCUVg3aCttTGhYVndmK3cyM3h4?=
 =?utf-8?B?WW9OaGhvd2c0V0RNZ3N1a2xudjJTNjlGaTNFMTF3K2JCNWhXZ0w5VjRXT0w5?=
 =?utf-8?B?OGlMVVhBbXQrMkluY1NhK0hYa2NEeVg2MTFVNHJmcmp2QTBGTjB3V210ZkdY?=
 =?utf-8?B?akIxdDdla3M3eEFTSVJuejRVc2pVTlRpS1NPNjZ0SnZnK1AzUktPYmhRTm8r?=
 =?utf-8?B?NlRsWTk2clF1c29waWtMaVhUQ2F3K1hrbUdtcDNhblBEelNHMi90dSs2YVRy?=
 =?utf-8?B?REFSZGFaNFI2ZTFjTVFqNGZjWDhIc3R2UGNzM3Zkck9GSU5NRENmLzV3NkFW?=
 =?utf-8?B?RWEyY2wxNFQ0NTR6TVBINDFHV1BsbHY4amhZVTlheGd1RUZHQ1RsbVpWYlho?=
 =?utf-8?B?VkZIcEYxcUdjUnE0YWV1NkhxVi9keVM4WlZqZXQzd3VvVFF0VW91M1VXUTA1?=
 =?utf-8?B?N29LRWM0YVF3SmFRR1lsUXhSMWdQUEQ5WERwQmgzWnhKWjVsZzRKUFUrSUZW?=
 =?utf-8?B?ZXdIbHJuVG94b2d3TTBUT0hweDJjaGRoT01yZTUrYzVvK080R1FmUmNPRzNs?=
 =?utf-8?B?RkRjN0FMemkxS3NZN2Zaamkzc09zTjVtNFl1eUlHN3hzUUV2YzZOUUxhWHZa?=
 =?utf-8?B?N1ZyY0svZmhrVE01NmxwSVlxT2xMUGtTNnZvWEh1V2hIWjdJSEJMUXl6cFEz?=
 =?utf-8?B?Wkd2VXN1eWVNNTk0eHQ1cm9rYS9nOXJpM1JQVDNFS0c2Z0dwTi96QVhhSCtK?=
 =?utf-8?B?c2hiN0tVV3NENWZwbHlCdFpBaDdQOUYyYnRQaytrdC9VNmNWUWtyWnJYbWRo?=
 =?utf-8?B?R044YmxIMkdUZW1ZK09ZSXlRdjIxLzVyNVBlRU55NnFkUEs1UGZRQ2Jnd2dl?=
 =?utf-8?B?TVRPV3B0cnNpVTZzT2ZHcFpMb083Y0UxbFU2SnFoTERBMHRPbitieGlhWU53?=
 =?utf-8?B?S21oZ1dQOERFNzhaL0hVTW9JanFhVUs4OEJFSWw4ZFg4bXY1RkthdmpVa0x0?=
 =?utf-8?B?RW4zd1hqQitmN2NyeElMdW9FSTJQMStOZWpCSXdPd3V2WW96REMzZUZZenVV?=
 =?utf-8?B?cG15MTFBc1lVZzVKSEYvNTljR0JGdWhaZTFVRm1LTXhjSXZKa05jbG01cmRM?=
 =?utf-8?B?d3RSYXV6b0MvL3llR0N5U3U3M01HNk9ML0krSmV5emJ3cXBDcXVGWUxTK3RY?=
 =?utf-8?B?cFdGakJEL1FWYWNYdGF4QzZuWlV0bjhqa0FBMzBnTUxGL1o2TCtmS2RKT3RC?=
 =?utf-8?B?dy9zWkI0V1J0Z0JWMU9GaWRZd294NG5Bc3E0OVF6cG0zV01sT2VUNUdGNVpz?=
 =?utf-8?B?cFVlYlNuSHYvZUlGeWc2Vi9lZnEzOFM1UFpMZFBUUDg0WWZHdWhkd3lYak55?=
 =?utf-8?B?SHh4cUdiN0psU0lFbFB5QWRlV3ZkU3VoSGZwclFhcGNQeGhZZzdwbnFnUEhO?=
 =?utf-8?B?QVphZTlkMDRBaXZCaWZvM0hYQlNPQjdBcjNDT09jZ01TM2pmQ2E4eVNHenlW?=
 =?utf-8?B?RGY2UlhtTnorek1lWmc2YVdsam5kNnl1SlJiQ2duSDlmdGZ2MEtlc0RKQ2VQ?=
 =?utf-8?B?Z0VqVkZ1YzhGN01ockZTcTVHTGYvTU9iZ2JNWHprdVNwNm01Qi9nNUxzUXhC?=
 =?utf-8?B?ZkNIOW9tRTFrVE9na0w2RFhCTERzRzUwTEJQUjlYZFg0bEg2MHVJbkNWOEo0?=
 =?utf-8?B?MG5Iay9YUUFDRS9VMTluOGNPcFQwbFF4cjhWVkVHaE94QzBxZS9hd1RiNkdw?=
 =?utf-8?B?Z3FtaGpJV0w1REMza1JQQ1hmU2gweGVFNlFPbUNLSWV2cFVnMnQxNzZNckph?=
 =?utf-8?B?MmRaRDI4SzUrTXpUb3ZWOHBWSDZEdGF6Wm9ZRmZpTkFzdjlzeERJYTVoR2Q3?=
 =?utf-8?Q?pkNbmSizBRByQ9XWlynno9Q=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1714a61-a431-421a-0514-08ddb9a16478
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:48:18.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/9ix0mXRR38FynsZWQKEVOqkh8TkMy+Ruq35pLidZDGtqMwK6Uf60hOT6+c7peMkn6VYpGNIIMegAKfSZ1sTfL/FWUce9rO2S00aXBXjuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8896

On 2025-07-02 15:40, Steven Rostedt wrote:
> On Wed, 2 Jul 2025 15:36:00 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> union unwind_task_id {
>> 	struct {
>> 		u32		task_id;
>> 		u32		cnt;
>> 	}
>> 	u64 id;
>> };
>>
>> static u64 get_cookie(struct unwind_task_info *info)
>> {
>> 	u32 cnt = READ_ONCE(info->id.cnt);
>> 	u32 new_cnt;
>>
>> 	if (cnt & 1)
>> 		return info->id;
>>
>> 	if (unlikely(!info->id.task_id)) {
>> 		u32 task_id = local_clock();
>>
>> 		cnt = 0;
>> 		if (try_cmpxchg(&info->id.task_id, &cnt, task_id))
>> 			task_id = cnt;
>> 	}
>>
>> 	new_cnt = cnt + 3;
>> 	if (try_cmpxchg(&info->id, &cnt, new_cnt))
>> 		new_cnt = cnt; // try_cmpxchg() expects something
>>
>> 	return info->id;
>> }
> 
> Honestly I think this is way overkill. What I would do, is to have the
> cookie saved in the event be 64 bit, but we can start with the
> simple 32 bit solution keeping the top 32 bits zeros. If this does
> indeed become an issue in the future, we could fix it with a 64 bit
> number. By making sure all the exposed "cookies" are 64 bit, it should
> not break anything. The cookie is just supposed to be a random unique
> number that associates a request with its deferred user space stack
> trace.
> 
> With any exposed cookies to user space being 64 bits, this should not
> be an issue to address in the future.

FWIW, I liked your idea of making the cookie 64-bit with:

- 32-bit cpu number,
- 32-bit per-CPU free running counter.

This is simple, works on 32-bit archs, and it does not overflow as often
as time LSB because it counts execution contexts.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

