Return-Path: <bpf+bounces-62428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B50CAF9A76
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE88E7B825C
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5E020F079;
	Fri,  4 Jul 2025 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jra0swP8"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2115.outbound.protection.outlook.com [40.107.116.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A962E3708;
	Fri,  4 Jul 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653264; cv=fail; b=CI4n8uzwWQjK5npDRdKik74nPYtHP2Vr+Cx9n7CW+JIdoiKAiNFZvZdcLPSMXwvCfHNb+3uiPYd4d9n0elwuIenwDyxLytYeIaI5L9PR8T2Y7BFAQxtvEb7r+tQXciM9BMmnkBoiAlBUyPLHLUzW1ivPrIuZyjs9x7YHT7brizk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653264; c=relaxed/simple;
	bh=tzCOUGq4TLykA6cT36KsXv8mPzGeVuyXtDpRsDuqoGU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RfQf5JxaKKiWr4CBQuVjL5nTlIfYwqZK6jRpNsEJ+je+iPcj0ssWEsa9h4iSlSCOSv6OlBGtxh1ErkwLbK01mjfZVbLbev/wTugrVnn4qmcwSkwFiUfJtPsJVhoIizLrpeHhq4Bvpw37J3NRu7AJeKt2Mf9turiNLcT6J2Zw43I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jra0swP8; arc=fail smtp.client-ip=40.107.116.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fE39vW8sScq7gmCK3Eup2riWXadyY4xKYuZ7PsLpmdNNKuEq9NkEG9zhPTVwn7sbRuaKLNl4Fm9wnwnGcS0JQ0WcV5zl/QxIvD3qKg0NZKUg2B3DoD9V066dJ/o4LVG0XeXnIjMZaciuBs5ph3P6uY2JYJgSvYc/3/js7m8HgvYUkuaNeVDGHuATODMJvfVq0t0zjL5hyptC5+v96kyWWbMVLRPxkxBLXIGlO1D1V2yH8Wj56lmQEVh/RI5Ip3vhkjijKxZw+mqm8XVR3yRIw7Bh673OyaSUw6OgPcM0JyRPGF9BQtvqT1+UYoleB3t/5IuE9jmSIXKT4tti+Acomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuiLrDHqVVeilWFw3lG0/nN+21BRnt2lkrZszUAjWqw=;
 b=fQiDdEsS2kw3xMGr7GDCCbxRT5T/ogSNQ0jfym1fyARQJRqgQWkIE9QRekThhqXVutY9MbZA0+CSCZgKm3/QX5GpYWpdqZd1gPY3k6vyC8ezmbaN92vMi25YprePSDYmXrKPYeLA0tCeriaY50mKupiuJFy9vBlHX3MtMK+657FS6pj4Gc/f2duKY3PC9EDEguIB2i2RoDw7p7e+Uq/6KjXoBgYzrY5LwJDShiIJTmCPbTIxmsz54N45SdWnXiPaZAYg9J0lQRopgu7LsG4sdbNfU0g/Dk15iYKKKJaD+x/WByAvjySwUScecF7ZFRsHXHigtsuCdWzdnmtCBLc0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuiLrDHqVVeilWFw3lG0/nN+21BRnt2lkrZszUAjWqw=;
 b=jra0swP8zBON0qVqoUBctlCgZ9nPWJkIEWNm0WcAlj1rbkw5OnYDllbW4PwoDHH/S6FR+lvh44XCODL6di9w9KWj9EQEJu7BE4faHlqIi4Xm4hw5YfMgxIUBMLM8hl1ZyL+vH3Z6RrkgOFxrpHolH1ORh/mK3pjYwJHsy+0UJO03ZV8ZrAY7sakRooCOWKvAXw9TIcm2srL2NhVoR+7fTYZ6LIvA5vsbE6dowUlkCUWH0gyiIx9M9F38T+BZLQ4GkppAqhEylMsAgeMMOHKKMz+ivvlVoL9v2fIkScR4LCc9Sq4XDpabj5eBexrukYFLd8+3MVTmRyD52zaeDmVVGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6380.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 18:20:55 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 18:20:55 +0000
Message-ID: <12c620ea-4bee-4019-8143-8ecbaeeafc11@efficios.com>
Date: Fri, 4 Jul 2025 14:20:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/14] unwind_user: Add user space unwinding API
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
References: <20250701005321.942306427@goodmis.org>
 <20250701005450.721228270@goodmis.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250701005450.721228270@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a6925e-74bb-4c59-b0cc-08ddbb278456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2dPWFhSMjBhVG9lZ3NRZlYvNXNaaEUwcG9ENHZMTXU2aXAyN0VjaWNzYmdC?=
 =?utf-8?B?R3loTFlyUEpYK3k0MWJrK0t1QUlmUXF6K3NiS0tjYzE2c1pla0p2Q3dzeUdO?=
 =?utf-8?B?MXUzM1BRYVlsSjdPR1VaUU81RWdkUU05YU54Q0pCT3N3KzVrK2MrOE5VanN2?=
 =?utf-8?B?R1lZTy9LU1A2Qnk2REhScUFjL2tLOS9TSkJMYTcrMVU4SzlHUEVRcXk1WW1K?=
 =?utf-8?B?amYyT0xtWmovMCt5Z1YxUnY4QkNWY1h1YkwyQXVteGQxbkVLSnhHMFUrNDda?=
 =?utf-8?B?cUgveThqYnk3V2sxMGV3SGErS2Mwd0JySVFLQVpQMTloTUtTbGM4ZWVTbDVX?=
 =?utf-8?B?SVZMc05pcXF5OE5MSFo3NXFyU0s2YzlobFJJTVRBMVVUYkdMeTkyRDBrbzBN?=
 =?utf-8?B?U1JqUHpJVkd3dVBidVgva3lFWXFHYWNLb1NxbnBzNFNESjNIckJxN3MvVDdQ?=
 =?utf-8?B?ZTRncjFwa2hiOTRIMXhHVDV2RjFPd2pVdmNsM3NhLzluQ3hKa0VSRWhEeVJk?=
 =?utf-8?B?SHFhVnpwYm5DbEJ6dlJ0Vm9neDc3MzVMeWl3ZkZ3RUFVY0RpQVlmNGZaMFpH?=
 =?utf-8?B?TndidFh4WlN4ZzN3bjZVTWdrQjFwMFg4SHhPRVBVWm9oN3VLWHJ0VmVUYzF2?=
 =?utf-8?B?U1k2UnJQaHZIczl3empWY3htTWRoeC9weE8yQVhhS2tkdncrT1gvanE3bkh6?=
 =?utf-8?B?R0xneDcxSnVHUVo4NlNJNnpPc011QzZJNisxU3dRc1k1QmhVMjNGMkRtaFZR?=
 =?utf-8?B?SjVOSXNMY0hZa050LzJaVWVlbHZSb1dFUUkyZ2dPQTlmVjBpckw3Z3NnMXhp?=
 =?utf-8?B?eThQbWRHSHFiUXdPUlZHRXcycWVmZXcrSloxc3RiejlMZVpUekh3dnNBN3Er?=
 =?utf-8?B?MXVZejZmWTRrU1lURVphLzlQV0o1dlZhR25pTFF6L0RvU3VFNS9CK0RSWERi?=
 =?utf-8?B?MDNzSEswUnNrVWV6VC9EMWRnZXlNUnhqMmFXZ2h3UllYdXdUbytIZk9LWTZP?=
 =?utf-8?B?MWFuYU51Q1Q5UDNxNVJxajhjamQyb20vanVWajJQcUplQzFNRmozQ2ppSGVE?=
 =?utf-8?B?d1ZEOXhHV3NnK0w0YUNyZVhaYlVZeDhkbk5ldW5HUUFSUGhZSEpTNXo0TFQy?=
 =?utf-8?B?aXBRWnlVMkNhZ0d2SC9JdFZ2REtUQ1pObUx0V051aXFpTVhJeEZpVHFvUm00?=
 =?utf-8?B?c0M2Mkg1bEk1UjNCa2RRVnhqa2lYRXFMS3B4bncvMFNLMVVOVTVwOEpINnVR?=
 =?utf-8?B?UUtud0s2elhEKzBrWVczdFhOUXJFU0tRcHVOdEJIa1lsakR0NmtzNzloeEND?=
 =?utf-8?B?YmIxYzE4cjE2TjJ4cllEclBDZm1TYWo3eUhUanNzWmcrQ2NoTDFmM1kwUDVa?=
 =?utf-8?B?d1dIUTZGOUFnRW1ZcGhFNEhGZ0xBTVpTbDQ2YldlTU1vdkM0aktkd0swYTJF?=
 =?utf-8?B?SHJkSjRYbFo2aTNrQm94Z3ZJWkhGV3ZGYlhYOXNYWVpQaUJFb2Z5N3hkRC9k?=
 =?utf-8?B?K08wK1FqQloya2pidTFCemZHd0NhUXYzbXZ6YkpGSW5ZWTczNkdsTW5aaTBx?=
 =?utf-8?B?aE12VHZqYVNqUHRKUngrVWFaT3oyeFVxKzh1UEhRZEFUQWd0SXdQTVBBOFRX?=
 =?utf-8?B?Vy9QOFlmcjQ3eGdiUjUydXdsVVJmUklYQWVlcG9TaCt6Mm1GZ2duSFdDYm1o?=
 =?utf-8?B?OGlzbFEzNi9Za01yZHpSS1QyRzFIOTUxVjZyUFp6RkpCSm9PTGNMTGtkT1FN?=
 =?utf-8?B?ZXhLNWYzQzd1Y0pEMGEzak9tbTlpUHcvZlZSL3R6ekZDRVhFN1NZelNENU12?=
 =?utf-8?Q?JCPMjd9FCx/iLtX16/UX4Am6KCszGsUdtkScg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2pqVXhSR3hIMmpPN2xmWGd5c2ltZVRoaHNMU1cxS1QxZXdaaHNNK2kwWVlL?=
 =?utf-8?B?OVFlZVBvNW90c1pKa09LZm0zbzd1NnVJUnNzVElqSHg3MW9CQWpaeVQ0cHJD?=
 =?utf-8?B?VkFoQy91NFZ3MHp6WDZETnphQ3QwaVNnVDVWbU5XZ004Q2RIOE1pRHhWdjVO?=
 =?utf-8?B?TDhMMktsNWF3aTA0RFNuTElsdENtY0tnUEh0RHJkQWpQb0pXYmcyZmhMTE0r?=
 =?utf-8?B?WElUTjR6QlFsbzYrWW5hSEVtR0x0UEJReWEwV1BLeTJuZ1dDOXE3aU52MklQ?=
 =?utf-8?B?SEMwdGRTNTBKZFlKaDljUHNNRGpkQVg4cHZ5UmhsUENlak1tcnJkTlltZXpJ?=
 =?utf-8?B?VTlTZUtneXJ2VUhKUmpsU0h3akdMMFZpaGZtT3pGZVdsRWVNYVVSWWN5SVhj?=
 =?utf-8?B?UTRkZ25qR1kyeVFzM0l4VlVtNUgrTnJsZHJxV2cxeDhOSTRsMTlWVEV3cWZO?=
 =?utf-8?B?VjV5M0Y0VjRDVUtndFNsdjl2WDd1ZS9CTlEyaEtGaUJjSVpqUHZZeUVFS0xE?=
 =?utf-8?B?NlR2a1l0N1kxUHdWSDJJa1duMUFTQXFlSWh0dk94bGRhMEhhTk4zWnFYeGpk?=
 =?utf-8?B?dDhXYURucnNSMFdTTUsraGh4ODBUVVhiTHc0OVlVL0F4YXkxY0hTZ2VrczdL?=
 =?utf-8?B?ekxrSlRoTVpBR0I2Q0RrNGRadVNxRUZvWHJQRi9pN2d6Qkg1YXBEYkNVM0Ev?=
 =?utf-8?B?VUVFdk5weHVBck04bG1Fd2pOUmhadmx5akNIS3U0N04zK0J3ZElVd1BtcHVM?=
 =?utf-8?B?anVEQUFta2l5M0JGN2hEU1BZckxTWWJKaEJLQllRWEdQbmNGamVnOUpBNkdP?=
 =?utf-8?B?MTJQc2I0SmFoV0JMcWQ5TEdFSVBxZ1d1bTFNV3BDa1RoQVBuS0wxSE9UMndq?=
 =?utf-8?B?UEFrWlRkRFlub1EwSkZpNTM4aUFQNlNLY09Ray85T0FsRVRIdmZNTmJHaUZD?=
 =?utf-8?B?cEcwbGczTU1WZnVuQUE4RksyZWN6cDNzK1Q5eTlRMTVpb21jUFdkc1NMbjRH?=
 =?utf-8?B?cGZmaW1mNlZwNllzNzc2azcrRk84VHZkdXJ6LzJVODhIVVVjN1VKQjdIYjM5?=
 =?utf-8?B?bEV5L1FjakI5dG1yYkVCTDZIVXRXQ2g2QTFxbmF5NUl1V3FSQWw2TW45NHVw?=
 =?utf-8?B?TG55UldzMG5yc1hSdzRSL2N3dnJDMmZNYWw4cnJSUFFoMmpSRnlpYmVSRnlU?=
 =?utf-8?B?SlBrK1dmZUhMVEkvSW5YNmQxWHpETmhwelcvR01zUkIxK29oVDdFOEw1TzFW?=
 =?utf-8?B?ZWZJem03ZnpTZnRLbVg2VjlOR0Fic2ZVNzJpM2UvcmxNczVaeHM0Z09GdVFq?=
 =?utf-8?B?QmVJWXFsaGhKamFkbWdEaGRwZUJqUWo0WGNwSW5wM2g1SCsyblMzYVVJTmdE?=
 =?utf-8?B?amsxNExQbXhpbTN4bjZpdnV1MWYvM0ZYeUJXMUNKbXlySzNwNTVpVDl6UzBv?=
 =?utf-8?B?UW1qZG5uRy9mWEp1aVIxVTFncjlmOFRabC8xL0tuT3F4MXJpQXpNakthR1hl?=
 =?utf-8?B?RW9xWVNidjlUSHpKOWNFSEVMSnp1WmN3OEhSTCt0OXdOUWhjR05JbDJ3TWh2?=
 =?utf-8?B?YVQ3K0pqekdnL2VFUmdQQ2p3UVFoRGlxRjVzaEs4dkttUDJKZmJhV0RvcVpa?=
 =?utf-8?B?RWh5MTZWbUVqQjNkdTJuU0l0bVlCek00bXZrRHQ1WFo1djJ2cDBwNEZGQm1N?=
 =?utf-8?B?MzRLTGpMN1ZQQlZXZGlFUFpTa2tYa0ZyUGRYd1IwNWYwbDJnbExINnhxb0xy?=
 =?utf-8?B?WXp1VUZYRkxxV24wNWo0Rmo3dnlSekRTZ3FyUTlkc2dHNHVKUXBjVmVtYlRi?=
 =?utf-8?B?NElKck9TQWJvVGE4aDQyMTdBWURGOVkyN0hQTFBFQ25EbVBSL0hSbTRoTkhO?=
 =?utf-8?B?NEp2SzlyelczVXl3NEJhVXFaQWhSdE5IMDZlT3pleU9KWnp2VDZmZVpReVdp?=
 =?utf-8?B?TTBkdkREUGtLS1dvZGtIdUREcFVPTUlpOGpEcUpUMU5TWkNBREE0TEVXSFJJ?=
 =?utf-8?B?U3ZzMmZsdTFaY0FSK3V0UG5VMHVBZzdhbDV4dzUxRXhyZWs4akhJYjFhT2Er?=
 =?utf-8?B?TWVFaHpoR0lQb3E4L1hjYm9RS0RCdnBMelptaEdSeFF3MjJFbEllbFNCazV6?=
 =?utf-8?B?NmVibVNITUp5UG16dGJaaWJ5YWp2S1NjZHNBZnR1a25oNWVHcVJ3NEE2RFNB?=
 =?utf-8?Q?iPWLllRgxkDSYeZZIKknUao=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a6925e-74bb-4c59-b0cc-08ddbb278456
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 18:20:55.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loCAdmSOePq+m68PINiiDec5aleDCZXfczhmCZft/BHu5uNvlcavAs8E3bTyPMprULH8aOL5OSSzfcgKM0A6YoNwyqrPIh4Pl6VnRfVHhw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6380

On 2025-06-30 20:53, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Introduce a generic API for unwinding user stacks.
> 
> In order to expand user space unwinding to be able to handle more complex
> scenarios, such as deferred unwinding and reading user space information,
> create a generic interface that all architectures can use that support the
> various unwinding methods.
> 
> This is an alternative method for handling user space stack traces from
> the simple stack_trace_save_user() API. This does not replace that
> interface, but this interface will be used to expand the functionality of
> user space stack walking.
> 
> None of the structures introduced will be exposed to user space tooling.

Would it be possible to make those unwind APIs EXPORT_SYMBOL_GPL
so they are available for GPL kernel modules ?

Thanks,

Mathieu

> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   MAINTAINERS                       |  8 +++++
>   arch/Kconfig                      |  3 ++
>   include/linux/unwind_user.h       | 15 +++++++++
>   include/linux/unwind_user_types.h | 31 +++++++++++++++++
>   kernel/Makefile                   |  1 +
>   kernel/unwind/Makefile            |  1 +
>   kernel/unwind/user.c              | 55 +++++++++++++++++++++++++++++++
>   7 files changed, 114 insertions(+)
>   create mode 100644 include/linux/unwind_user.h
>   create mode 100644 include/linux/unwind_user_types.h
>   create mode 100644 kernel/unwind/Makefile
>   create mode 100644 kernel/unwind/user.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4bac4ea21b64..ed5705c4f7d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25924,6 +25924,14 @@ F:	Documentation/driver-api/uio-howto.rst
>   F:	drivers/uio/
>   F:	include/linux/uio_driver.h
>   
> +USERSPACE STACK UNWINDING
> +M:	Josh Poimboeuf <jpoimboe@kernel.org>
> +M:	Steven Rostedt <rostedt@goodmis.org>
> +S:	Maintained
> +F:	include/linux/unwind*.h
> +F:	kernel/unwind/
> +
> +
>   UTIL-LINUX PACKAGE
>   M:	Karel Zak <kzak@redhat.com>
>   L:	util-linux@vger.kernel.org
> diff --git a/arch/Kconfig b/arch/Kconfig
> index a3308a220f86..ea59e5d7cc69 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -435,6 +435,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
>   	  It uses the same command line parameters, and sysctl interface,
>   	  as the generic hardlockup detectors.
>   
> +config UNWIND_USER
> +	bool
> +
>   config HAVE_PERF_REGS
>   	bool
>   	help
> diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
> new file mode 100644
> index 000000000000..aa7923c1384f
> --- /dev/null
> +++ b/include/linux/unwind_user.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_UNWIND_USER_H
> +#define _LINUX_UNWIND_USER_H
> +
> +#include <linux/unwind_user_types.h>
> +
> +int unwind_user_start(struct unwind_user_state *state);
> +int unwind_user_next(struct unwind_user_state *state);
> +
> +int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
> +
> +#define for_each_user_frame(state) \
> +	for (unwind_user_start((state)); !(state)->done; unwind_user_next((state)))
> +
> +#endif /* _LINUX_UNWIND_USER_H */

[...]


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

