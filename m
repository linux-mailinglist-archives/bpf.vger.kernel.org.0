Return-Path: <bpf+bounces-64091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79755B0E3AB
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847271755B0
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151C02836A0;
	Tue, 22 Jul 2025 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="okDyoxNC"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2124.outbound.protection.outlook.com [40.107.116.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81ED21516E;
	Tue, 22 Jul 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210181; cv=fail; b=l8HvN6yvIiVJQ4QZrnyTx3OXqKej8bHbf1TVs7nNWPaZ+VhW6w1O9MwL+ZJXunlhSc9T5j0V12dTRWjNp4VTwA9w9moJlPnp/U37slUjcat6u3UyTBgsrZu0xdQIhqNmr3MJg36pjnZQd6zMQUjxaW4lt05rRbR4lMBh2DW3Eyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210181; c=relaxed/simple;
	bh=MlEo5k/WhXIuuSk+1ioiVlU4hB/u4adYdliyisQ450s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OGSTgKXNb6UC0x0FGArCmNuvjSZcAZCGVkLNksa+W5cdxS+vgOT6vQPiICHt7jNlY/85rNbfbkUrrJOwIyYN1TRN8ZFP4rBJPfDPBQ5YfLhbJGpgwoGzX7NK8bftXHIRsioy4QUL8twym7WfwG9lZB97ANbzpuvorCa1k+Ick3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=okDyoxNC; arc=fail smtp.client-ip=40.107.116.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSOyUQNZ/3SUeF/tQIt3ui32YEUA1rr3L1OGoxmjvGJLqj373QtgYOHD6pZ8b6uYt3BCBZm4rlKqKzXrEQx3bPhCQRaND60PzcoffllTWdoG1LKgCMz3euyN8rvtLk+VnEdw3ez2f4N81pZp1Xu32ZWyB79cgby5q5XbRBV4bhZiFoFkTh67Zqm7frLFECn05s90MYnH8iPIL+tZkD0QuZYhNYsJaJHCkqC/4aA3o6G1TJn2IdZemBr/4OMWNGfWLjmB94Rq0cFzZ/77dP4MxwcvKXr52ZLZLPpuXbU1n0ztb1mMOu6aXU8u2YlIRImEpBLXpuRD9/2YtEWUpf+IUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3ZoLVMZykS7ffW2YIf6F6XEJFt2SyTn+JhE6ltYXnY=;
 b=YLV031wVfUjTNYBlGeKAmn1ZsRsw3EjHv4lKpOPVx0ux6twVOunLBXDVz2DaseQv6Ow9BwIWornSzMRYwDQKxMMkTaBE1f0vUP89LOhEBajbbK7zIosOGIyhRhp6xsSIg0jge9Tqcdu/2kJsCbc+vElYSsbh/+jpUs2Dx/STxx9LIqJsQt0TO/hTdDxTCV9N48nAnBC1jN0s8R8/3YPPXPH1LCeRqIqlQguNufP6FCwS2C5QDkJAPQ+W+5FmqHc+RGpnVEvah8vMnTR7qD5g3mjTYNCaAq/BK8a9DXbkw0ESnTF+cmPj11jJfnWWMiVveD+s1kN3vCWNUXfzR1F3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3ZoLVMZykS7ffW2YIf6F6XEJFt2SyTn+JhE6ltYXnY=;
 b=okDyoxNCic5XfkIQAaDNk8SAFdcAN0tCMp2mPYFrM+VchH9W5CaW/1o1Fw4rnjPk/kc3Wgo9AgD1FLqvkBIK9r6vD7UrBWDpZY6FfEAPr7LKV4jWKL42zq6DFBrVtZGz5w2eaFfrJrGlVrC1FYw93P2M+M8WO+qYHDwAuew4sL06VpQKaaLKchuq4p/LlZ4y/28df2KdLQyvW7Sz7PgfSO1mzrunP+mj8AGkjKCWQBZvjgEs977CmaG6YlNNK4K///OjB1n1TiHie9sia2OofB9FRuVYWLzpC5TDjA6uQq0oDwE630tKw8FptwtFjPUWIoJLIqz4wLWYbw7+1lxHzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPFA62BABA4F.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::277) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 18:49:33 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 18:49:33 +0000
Message-ID: <79b59f16-3f77-4e94-ab85-dc454b1df18e@efficios.com>
Date: Tue, 22 Jul 2025 14:49:31 -0400
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <69d09381-2315-4c95-ba5a-28d148ffd19d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPFA62BABA4F:EE_
X-MS-Office365-Filtering-Correlation-Id: a42defca-8f95-493e-b34f-08ddc9507f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTEzZ0h6V3JhTGJyTnhKb3J4N0hJbTc2bmVRZ2R5S3pNL2p1WWlYbm9tOHFI?=
 =?utf-8?B?UUNQT3RzY0J2UDBhdlljelhZQ0o5d0ZjNmtmaldnZ1pucVJPaDcwai9DTUZ2?=
 =?utf-8?B?NjJQcUZrUVJaKzZzQW9Qam5YN0J4K1RaelpTamkxR20rZmJqMGdvSGgyVmZM?=
 =?utf-8?B?Uy9ia0tIVEJ2WFpKdm0yTWF5amxQVy9lMVdjNVZJUlNleWMvSTRiRE82LzlP?=
 =?utf-8?B?OEs5d2czelJkRlQ0cEEzK21DMno0Q1E0cVEyU1A3NXhZVW9Tc0VpWHA2Umdw?=
 =?utf-8?B?UU5FYXJwZlMxRm9Xc25ML0RITTdyRmJGMWpJMjBVSlE3UFg5RE0xQ3BJbm1Z?=
 =?utf-8?B?dnZSenhOSkFNb05PMU1MbWZnR2RRU29TNmlMTzYxMTgyR0tYbXZybW1KZXEw?=
 =?utf-8?B?RVVYblVDbURuSHNCemt5YXNicThuT3BwNktkVDh4WjF1TGlQVVhpK1Vxam1h?=
 =?utf-8?B?emhQT0FWZHZYOXQzY1gxUDdsQnhIdVdXaWRnWUNCeUQxNnc3ellEV1NwOHdo?=
 =?utf-8?B?TTFtVThWVldHaG9BcEFBV1ZjL3JUeWFKOVN1RHFVMWh5bm42K1NJY1dXbWh2?=
 =?utf-8?B?YVY4QlF2Z08xM3ZFQkdmRk9hYk95Z0ZqY0FnRmVtNmlUTE9XRWRDZzhZd1Fz?=
 =?utf-8?B?RVBQdnpHWXFoaU5oUFZJcklISTA2Y3c2WHdHeDV6OGc2VnNJQUtjcGNRcmpO?=
 =?utf-8?B?T3F3Vm5KdkYvMTlvZ0UxN3puRkcvRS83WVZzK2NuRGlXMDNMVEtaL05UK0Nh?=
 =?utf-8?B?Y3VZY2VScDBHZllUV3BYcTFKMkkyOGRwUlBpbHFLMEF6RDJxUDVrcjh0QWhk?=
 =?utf-8?B?Q1dkZjAvWDk2WDlsMmdDOGVHYU9mNnk1SEkvazZ1ZmlYU0xxTGxzRnVUbnFy?=
 =?utf-8?B?eE5jNVMzWnlSTXhPZGtEZWl2UCtST0F6N0JTTnFqVG4rMXhjcHJaOGl3RTFy?=
 =?utf-8?B?b0o5NFJjMEpMd0E4YkhMR043a0l0YTZxNTA2dE91Z0FwSGh6QlNscFVaelpR?=
 =?utf-8?B?UFA0Q1RHdHZWZ3VTNStpVlcwSVVFS3N4SHhBVTRLN1QwRjlOQnhlTEx1UlI4?=
 =?utf-8?B?am5HcldMOWlzWkZyYWl5dXc1N1FPWHlPYnZrYm1xdnY2TERTdGNVd3RtUnRS?=
 =?utf-8?B?YU5EZDNaMkk4bVB4eGRVRERMUjJoV01iVHdTa1Q2SGtkZnZ5NGhqdTBSUVB5?=
 =?utf-8?B?dzJPMjJ2SnBZSTBQUlJUcHdMejVpZHFVaDV2ZWVRSE8vcTZLdUtjbXhqQWRM?=
 =?utf-8?B?YlJuemYrWmMycDVmOWJrOHI4SXFjRzFjc3JoV3dPUE82Y252YWNiSXV3dW4r?=
 =?utf-8?B?Ri9QNnhOUThhR0svdllZQ0ZhTzcrRGx1OXZzRXJ1ZGdTb2RUYmxoLzRzeFk2?=
 =?utf-8?B?LzREcG1LRjlWN05WUkhtd2RwOFlsK1FOY2VFZDlyM3hVUEFMWlJXSTZ2MkN1?=
 =?utf-8?B?Zk5pRVY0anFlTVdvUTRGWnk5b2xIblVpbk1Lbk84a0wwbXJ6TEZhZmVtUHZ6?=
 =?utf-8?B?STFLWmVpSkczTWJqTUF3c2wycXMxbklsTm1sYTR1SUJJQW5uUnVodE1MQmt3?=
 =?utf-8?B?NHY5T1NnYjQ3blVlTkNmUVNaK3VrVWYzZjRSWVJ2ZmdETnZFZkRJU3RvNlpK?=
 =?utf-8?B?bCtoNDN1NmE5NURPU2ZkVjI5QWY4WU1nREhtM3B6OEtZcHR3eE5iZXBMNkQ2?=
 =?utf-8?B?Wm5yQno3SVgzcDY0WWk3K0piMXJkYUZzc29qMlRPbkJqQlVNS2pLcUEvRk1h?=
 =?utf-8?B?cGxXUzV6QzdDVkExYURUYUpmRVU0Q0RrVVpmYm5jQUdCeVNkdUpYMFRVdE9D?=
 =?utf-8?Q?G188NzWaFFqifvq7L5OCMet/zbNCu3D4jEKuI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk5NY095cjRkaXVsNit5a0tzME5DWjNSUFRobDEvMmF1YlNjQkVyam8rSkxG?=
 =?utf-8?B?eDV1TDlqL1BWdS9KdmYxSWtTNURrekp2T2pUbms2QlpBbHpCcU1vZWU0ZG5a?=
 =?utf-8?B?bkpBclFLeDlEOGJwL1NOb21OYnFBKzR1Q0pHUWJ3am1ZT3FiNThNdU1VeERp?=
 =?utf-8?B?Zk1tbUhOOVFNeitRZEVsRFRpNUEra3hyYmZMV0xzdzY3ODFCWHoyYVRiQWxy?=
 =?utf-8?B?U2tzS0JsTW1FMzVkTi9LYzVrWUFydnBUS3ppZ2w1QXFaYzlhVjM4Uzl0R0sy?=
 =?utf-8?B?V2g4aExtMDhGMzJvaC9MS04xWE1YTUwzYVFTekhrbWdPRkV4M1hPcmxOUk9D?=
 =?utf-8?B?cHRmZ3A0VStCeWhWQ2ZtdzhTSS9XR1grUHNoV0s2bE1td2FEVlFZaFVtWDdR?=
 =?utf-8?B?QzcwYkhINXRTVlV5SFUycEZ0dER3RjFMQ1BzdjQyQUdOdDRib1lOZGNtS1Z1?=
 =?utf-8?B?eVRwMFVEbW80YVVycjNJcmkyQWN6NGgxSEwvTnZpM0t4aGduT2RSN2dSSFUy?=
 =?utf-8?B?L0QzS2p1bjlrRmsyb216S3FrVVVBQTRXWDhaNURoeU5WU2grbTg3a2RudWsr?=
 =?utf-8?B?djA5aEQvMi90V0tpYnR3ZE1lQlArcUpabzh1NVN1Syt4S210L1NpMGlnN0t0?=
 =?utf-8?B?NWlabzJLRkdzRW5xVCtRWHhvK25rcEprR1FLcTB5anpyMWFYMEpMVy9raUxu?=
 =?utf-8?B?OTdadUhzbEpYOEZIS3RIV1hCR0hESE96ekhMbXN0NWpLckYzRCtQcC9CN1pZ?=
 =?utf-8?B?VnJ4Y3F3RkJXRFhsazV3aGN2WS9CKy9lUDExY0tJVnZ6ZkhmL21yZ252cEZk?=
 =?utf-8?B?RHNTRk1samJ0SXNkeFl5MTF2Z2dndStPUjFkcGNQOGszMm1BMWtlVjRyd2tC?=
 =?utf-8?B?RDYxNWdUMGhtc0c0ZjJYQTdETzlDQlJXcFdydldMbGFIYlBYam01eHExelJx?=
 =?utf-8?B?czVTYmxGTDhZY1hvcDlabGIrWkZ2bkswZXBOZWRtWE5QQ0hOeU9jSERvVitT?=
 =?utf-8?B?OG92QUl5YmNpM1VBVTdCdTR4RE4vMWZRRVN6WUpQeDBxUVlxV1IzQnJtb1BS?=
 =?utf-8?B?c2s2UEM1UEVOZ216cjh3bXEvUWV2a1A3Y1E0RHdmQi84RFI2d3hpcy9PRWlt?=
 =?utf-8?B?MHpJMlBtWDZaUlNRWk5pOXd0OEozQ2Z3c2JEQ2FEZ1FrS3JBNmlHY3dpcm9C?=
 =?utf-8?B?K3NxK25pdGJZb0s0eXlaV1Frb2I0dkJobWI4emZ0a1hrMzlUdmlLbEJqeFI5?=
 =?utf-8?B?dGFYcnVwWWtLTVRkbEVrRmNnZEZpMmg0QitwK3M3dUFnRDF1Q2s5RjZPRnNB?=
 =?utf-8?B?QjZYL282L2VXVk9relE3UElMb2MxNS9USnBQS3UzM0liVkRDYzJSajZrZW1P?=
 =?utf-8?B?MTdrcXBhS04xSExHSUtDbFBSK2xWZDdkZHB3N21wUkoybTVTUkptMXhkRjZ1?=
 =?utf-8?B?TkEvSVJabVJBYXhNYmFVS3FuMWxrM3V6b3JsTGk2TTRJY2V4dFpmNEFpVXpO?=
 =?utf-8?B?akswVlVkSEVnU0grUElVeG1Ia3ZFVm1LWHpDL1lBUm9tWFZBdDg1aVFMK3Zo?=
 =?utf-8?B?WWJoOVFZcWlaMjV3cVQrTndOWjZuTVlGQncyaTdtTzl4TmxtbzdrbDVEa2FX?=
 =?utf-8?B?UlBXc3ZxOXo4V3lFUlY1Q1dvMTdUNi9aVnFzNzFrZS9tbFA2azZQTUdSY25Q?=
 =?utf-8?B?WkFvTmE0VllzbU9PZk92L2JVK1R2NjR2TUplckp1bGF6K0RhcW1OYW1MT2dZ?=
 =?utf-8?B?VzVoUzNZQ2NidWl1ckVZTW9Lamk0elFoSElOcHBzSXlMdGhwdmFBaUVmd0dx?=
 =?utf-8?B?TysrdmVaTXlqYkdjR0VNQWNYaDdYVmlZZUlRUkdlSW5LMUtKK0pYTDRMRklx?=
 =?utf-8?B?RlBheUw5dVVHWC96S256RFVTL2JVL1E4cW5YZXNtdWI4RXQzbituSS8xUGpG?=
 =?utf-8?B?NDhjcitsTUg3MTJ1Mmx2NStVWERYcVlhMmN4VXdRTkVySDVwdzJSMGI2SFlI?=
 =?utf-8?B?UXQ2S3VzQytSSWRXM1lyckVESGREWWg3SFpEMjZsY0FCOCt5ZGVZQUk4L0dZ?=
 =?utf-8?B?VzdZT3lneEdkd3h0UmJwbU5QQ0FINll6eFVNTUdDODJmNWVIbzhzeGJMaXhh?=
 =?utf-8?B?Q3FLR3VmdGxLMUQ0dzQxdWhOeWVxdVBRSlQzbS9LRFF0aEVCS2xoeFFqLytk?=
 =?utf-8?Q?hV270NNC8El4mA7fqYJ1MyQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42defca-8f95-493e-b34f-08ddc9507f97
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:49:33.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvoRDt12LXWWejfka/TpqSbScbrmkj12jrcww7xXmE5dHSNLBRXVF6/BsATqEUJiXnTow1CXHim+rRZLcagIdqhfXoO7H//RHNweMeK7reM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPFA62BABA4F

On 2025-07-22 14:21, Indu Bhagat wrote:
> On 7/21/25 8:20 AM, Mathieu Desnoyers wrote:
>> Hi!
>>
>> I've written up an RFC for a new system call to handle sframe 
>> registration
>> for shared libraries. There has been interest to cover both sframe in
>> the short term, but also JIT use-cases in the long term, so I'm
>> covering both here in this RFC to provide the full context. 
>> Implementation
>> wise we could start by only covering the sframe use-case.
>>
>> I've called it "codectl(2)" for now, but I'm of course open to feedback.
>>
>> For ELF, I'm including the optional pathname, build id, and debug link
>> information which are really useful to translate from instruction 
>> pointers
>> to executable/library name, symbol, offset, source file, line number.
>> This is what we are using in LTTng-UST and Babeltrace debug-info filter
>> plugin [1], and I think this would be relevant for kernel tracers as well
>> so they can make the resulting stack traces meaningful to users.
>>
>> sys_codectl(2)
>> =================
>>
>> * arg0: unsigned int @option:
>>
>> /* Additional labels can be added to enum code_opt, for extensibility. */
>>
>> enum code_opt {
>>      CODE_REGISTER_ELF,
>>      CODE_REGISTER_JIT,
>>      CODE_UNREGISTER,
>> };
>>
>> * arg1: void * @info
>>
>> /* if (@option == CODE_REGISTER_ELF) */
>>
>> /*
>>   * text_start, text_end, sframe_start, sframe_end allow unwinding of the
>>   * call stack.
>>   *
>>   * elf_start, elf_end, pathname, and either build_id or debug_link 
>> allows
>>   * mapping instruction pointers to file, symbol, offset, and source file
>>   * location.
>>   */
>> struct code_elf_info {
>> :   __u64 elf_start;
>>      __u64 elf_end;
> 
> What are the elf_start , elf_end intended for ?

The intent is to know at which address the first loadable segment of
the shared object is mapped (elf_start), and the size of the shared
object mapping, which is the sum of the size of its PT_LOAD segments.

This allows tooling to easily lookup which addresses belong to that
shared object, for any loaded segment, whether it's code or data.

> 
>>      __u64 text_start;
>>      __u64 text_end;
>>      __u64 sframe_start;
>>      __u64 sframe_end;
>>      __u64 pathname;              /* char *, NULL if unavailable. */
>>
>>      __u64 build_id;              /* char *, NULL if unavailable. */
>>      __u64 debug_link_pathname;   /* char *, NULL if unavailable. */
>>      __u32 build_id_len;
>>      __u32 debug_link_crc;
>> };
>>
>>
>> /* if (@option == CODE_REGISTER_JIT) */
>>
>> /*
>>   * Registration of sorted JIT unwind table: The reserved memory area is
>>   * of size reserved_len. Userspace increases used_len as new code is
>>   * populated between text_start and text_end. This area is populated in
>>   * increasing address order, and its ABI requires to have no overlapping
>>   * fre. This fits the common use-case where JITs populate code into
>>   * a given memory area by increasing address order. The sorted unwind
>>   * tables can be chained with a singly-linked list as they become full.
>>   * Consecutive chained tables are also in sorted text address order.
>>   *
>>   * Note: if there is an eventual use-case for unsorted jit unwind table,
>>   * this would be introduced as a new "code option".
>>   */
>>
>> struct code_jit_info {
>>      __u64 text_start;      /* text_start >= addr */
>>      __u64 text_end;        /* addr < text_end */
>>      __u64 unwind_head;     /* struct code_jit_unwind_table * */
>> };
>>
> 
> I see the discussion has evolved here with the general sentiment that 
> the JIT part needs to be kept in mind for a rough sketch but cannot be 
> designed at this time. But two comments (if we keep JIT part in the 
> discussion):
>    - I think we need to keep __u64 unwind_head not a pointer to a 
> defined structure (struct code_jit_unwind_table * above), but some 
> opaque type like we have for SFrame case.

What is the reason for making this an opaque type for sframe ?


>    - The reserved_len should ideally be a part of code_jit_info, so the 
> length can be known without parsing the contents.

I've placed reserved_len within the unwind table because I planned to
have the jit information for a given range of text be a linked list of
tables. Therefore, if one table fills up, then another table can be
chained at the tail. Having the reserved_len part of each table makes
things easier to combine into a linked list.

Thanks for your feedback !

Mathieu

> 
>> struct code_jit_unwind_fre {
>>      /*
>>       * Contains info similar to sframe, allowing unwind for a given
>>       * code address range.
>>       */
>>      __u32 size;
>>      __u32 ip_off;  /* offset from text_start */
>>      __s32 cfa_off;
>>      __s32 ra_off;
>>      __s32 fp_off;
>>      __u8 info;
>> };
>>
>> struct code_jit_unwind_table {
>>      __u64 reserved_len;
>>      __u64 used_len; /*
>>                       * Incremented by userspace (store-release), read by
>>                       * the kernel (load-acquire).
>>                       */
>>      __u64 next;     /* Chain with next struct code_jit_unwind_table. */
>>      struct code_jit_unwind_fre fre[];
>> };
>>
>> /* if (@option == CODE_UNREGISTER) */
>>
>> void *info
>>
>> * arg2: size_t info_size
>>
>> /*
>>   * Size of @info structure, allowing extensibility. See
>>   * copy_struct_from_user().
>>   */
>>
>> * arg3: unsigned int flags (0)
>>
>> /* Flags for extensibility. */
>>
>> Your feedback is welcome,
>>
>> Thanks,
>>
>> Mathieu
>>
>> [1] https://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng- 
>> utils.debug-info.7/
>>
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

