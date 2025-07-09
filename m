Return-Path: <bpf+bounces-62798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CC8AFEBA8
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 16:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795E31C44EA6
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F25E2E6D30;
	Wed,  9 Jul 2025 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Bv7MiVWz"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2101.outbound.protection.outlook.com [40.107.116.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE1290BCC;
	Wed,  9 Jul 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070239; cv=fail; b=NhF7TJrzWedQi64sc3Rg74BtMcLco3SvR/tAodB333ASEpLKi9r2yTAZgY/2hKOgii1Egy3aMF8TPE9lByUGCngMOOPmwhixT30ApMSSVLxHvkbfuCncamQxLeP+OYsaWz1gH3AvlklJf2bemj0plpPvZ19PWJ0JrxglF+PY3ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070239; c=relaxed/simple;
	bh=OJMBHXQaJLpJdIuWRZoU6gU0HUuhLF23RLYxZfVebzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bjwxCdW3UvGy3RsEr1WFlO5HZ1DBLarbiUXNWh1mm2djrrLXzcvvFZ5BdBAkaVh8NzCTGoMcqPE77SV9H9tvPcmODOaMelwxfjwG4qil/KOP/1GheygW5/EudcWGfz0jhUhItdSGEsSVcQZOoeCZpUDtlZe6a0WujLOX9P4a6eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Bv7MiVWz; arc=fail smtp.client-ip=40.107.116.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+kTYlS544wTYuZpLto+B/th8pIjBQcjha4WSH2dQIrvTyIFL6Lq1au/OhF8Y4xdKA4KOo/F4dYpMXOZiiJdzCxioyJHUgVSD2DzZj7uLiGzBhStmwxYCAAMF29j0MdYXzd6UfyYtyFnHFcWdvlVGRvQ7EwwxeYcKMqia23eC3zVWH2dfzZZNjCldL1+7nFpyLwgLuG1A6y8y7ECED8mL+aGl21Q79AVOVNb3GSTLCEix+lm8Ww2rynt7TNJBM5krLA8wLn/r0WvhUUPXJ1FGch7uwWZKxcMg7ttI7zLAA/FF+uEzYGm4qDjKnwkaOH4jis7qo6mWozzZ+YlNolx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dHeKUsC1BiQCfFo2ayERQGteRXl7x/Y53zYzCwsxyw=;
 b=OXW1U+RZ4cCwWwn5mjRZGvIObhaR/kxPvdfaMMey6Rqgj81rQ1AoXf7Io9UVMI0TlKQiPtpS82gd9zTGRwDjmiVXNi6iGf4J74LFLkTeOFeOT9+7La0YOc8N2Ds1UdujYWZhDY63nMAAS3BIPfdla2tQkZoM/s0Uyfy6FPZGRiW6VWeGC/YwOTTBoEgzbAn/5mJc4bNNLVgCP07aVm4RdfP+Hdv0EQa0ItB1x4mRlWQN8ffOYn+wHyfOQXklv3xtd0+oyiN5nl5tpeIxTDOQAa9EfJhhwcop1hqMgT0oymjoF7xMG76MfEIAWHkoFZAhM544EyBncz+b+cpZPMMt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dHeKUsC1BiQCfFo2ayERQGteRXl7x/Y53zYzCwsxyw=;
 b=Bv7MiVWz7J9VcNJJry3qzWZb802Q9L5CJ7U7baSrBWci6SeVuL0f2s/MEzGehErHWKXIlTYulw2Ll9U0YYg1d4NeyhhCRVCc5vx5YlAwzJMPzT1bYtuakM/OhBm5jnVK69Lo+1dAz7OofulUHSHNZN3p9JB3JK7PI9frTYmCsQ7I9tc/JdrYObyFxoBuX+1eSnG4AGXD4FAlq5qaZKh3CCveMKW8neghgT2TdQ6P7OUtxFI96MC8Fh/VKzb2Jl8SW2e3iR+GY1K46JOtiG4lFsnpEiRGQA8a4d65kQvjbpWpvyd7ONLUUXHzeXA25ejKM1INqftTAZAvbEmdFZ/2sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9665.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 14:10:32 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 14:10:32 +0000
Message-ID: <939e13b0-be32-4ec9-a40f-0ad421f63233@efficios.com>
Date: Wed, 9 Jul 2025 10:10:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Steven Rostedt <rostedt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
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
 <39cf3aab-7073-443b-8876-9de65f4c315e@efficios.com>
 <7250b957-2139-4c03-9566-a6ed9713584e@efficios.com>
 <20250709100601.3989235d@batman.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250709100601.3989235d@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::37) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 190ae59a-0ca1-4473-8152-08ddbef25e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGhabFRmUWZtcnZvNVdEUVlYRlZYS2lsS1RZYnNrTlZ4Z0hQNExqWTBkWEsw?=
 =?utf-8?B?UWkxSVAvSDJHdFVnbEhzQ0xyVGpIemM2VnhVUUN6Z0ZmczlxL1dqWjRVbFJH?=
 =?utf-8?B?UEJudkcwWm5URFhaWG80VmNnc0lYS2RXV2NHbzA4ZDlwQkc1Um1qSWVxT0to?=
 =?utf-8?B?L2pTbXpiWGRrVklkTFQ0Z0x5T0pOQWxaa3BGb2JRaHZkb2VQTlNqdjdoeDdD?=
 =?utf-8?B?Y0VNRWVHODY5SmVnNlFSK1NpYmN5b3hzaXV0cVdmV0pOWEsxNHVpd0ZsNzFu?=
 =?utf-8?B?L1NIeFN6R085TFNZbFRqN0FpdmhyU0w2MVdEb3JabHB0c3ZTanQxQ2VLc2VQ?=
 =?utf-8?B?eFpKYTNaejlBSnc1R1ZqY2hPRFJHRWlRVG1uTk4xazAyOUxqMUd1alMwQktu?=
 =?utf-8?B?b0s0VmhHejVwUG84Z1NySjlVMHg0MElmQ1kwV3pZdS9ub3kvK2ZLVGxBT1Nq?=
 =?utf-8?B?MW1iMHcxWkFUNStja3JjRmlSZkhtYjQrNFRpZEYyY3VYZ1d0NUJiZlhtYW56?=
 =?utf-8?B?eDhnSUpVdlNKc0luTkFiMW1Hd29YTHlnQVBXOGtqUkV0WFBQM3VXSWxnK1Iw?=
 =?utf-8?B?Tmhub1VHeTQzV3RURUtac1NiK0RTRmhhU25lWlNIQ2FpdkcvV1pNbzN4Z2c2?=
 =?utf-8?B?TUUyWE5MbU11ZWo0WU8vNVFHYTE1andmdHJOSy9XMEtXdzNxMm1yUjdvVjN3?=
 =?utf-8?B?MDlYUWFZVFFxM3h3ZUwxSGpTUS9DaXNuQVY3YW5sQVVrY1I5M2QranVMU0RO?=
 =?utf-8?B?NWhNZzUwaDFLYnpDdjN4NE1aT3ZWeGM1QTgrOHZZejlyMWczQWRPd3hpaElm?=
 =?utf-8?B?QnQ0VDlGUHI1Q2oxSzRXM1VQRFQ2R1ZLT2R6RVpyNlZ2b0p5YXc2d1JHVlFM?=
 =?utf-8?B?eHhxNExrSmExTnFVME5RY2Z3UnBBSEFFUWw5ZDNBdFlPZExMN1ZtLzVEcWRN?=
 =?utf-8?B?RlFvNmlNaUZ1K2ZHN3Npd0VuNTJoNWZCa0JNSHMrWTV1cWJvWTlqS3lLMU5t?=
 =?utf-8?B?eXpkQVd5UTRTRWwvTXRlbkhMSVlHdng2Q2tnZDRzRFhvWWVWL1RUei9Yb3Z2?=
 =?utf-8?B?OHl2bk94VUhDUVJqakhUd0ZBRHB0aTZyai9hUVNoWjROdzBjbkpOdjc2RzJa?=
 =?utf-8?B?a2xydTJ4SjN5S3ZOOTdoSlVWWTdLbjBGbkx0a0wvdnlTaVpGaERheXUvY3RZ?=
 =?utf-8?B?dEhrQjFjamJNUWFOY1p5Q2VQTkM2UFRRbm1ObHNEVnpBYm1BRTAra1pteko0?=
 =?utf-8?B?ZmpxKzgrWTJQTWJIUnNHSXpjeEllMk1SR1FadndkbUlEY2tKS2gxaEpSYVRJ?=
 =?utf-8?B?U1A2dnFOVjZpRHVhZEdrYm0rb3pSNm8xUWljTVVhekRIWllMYmZpdUVQL2NW?=
 =?utf-8?B?LzVMMlpsSGhMRkt6OERpaC9NaXFkMUMwaWJqKzJJenUzT0lxLzVrLzJkN2Uy?=
 =?utf-8?B?TFFRV0xOWHRQcjQrekNLZVB5SmIrZzRKcFN5eUp4bUtMZ1JKTTdHTFkvZlFH?=
 =?utf-8?B?UzFpQ2pFN1M1SHI4enpuTHV3dTA0cE9vU2x1N0w2dStKUnJXKzFrbnNiTGls?=
 =?utf-8?B?YXdVczB3aHlhV0tKc2w0ZW9XaGdrWDU2MzZFc29landLQWhJViswdzRFSTNX?=
 =?utf-8?B?TXM0R1puVEx3RURVVStadDR4MEh5ZnMyYVFOMGtnMTNZRGpDd24yWXRiSjhv?=
 =?utf-8?B?dGdDeXNXZkdQMVBiRE1zQXlBZjlIQ2U3Nm1xbEVEdFdOOGlmU05oMWVKVmZH?=
 =?utf-8?B?dWVyZi9LY2Z6ekRrTnN4ZnlsSjkwMmx0RjYrTG4vTVBGbHNCeHlSUUllRER2?=
 =?utf-8?Q?lz5uDMWlhlHKCEhcxXpxygUqCIJs3CBmxr0SU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3VKU0dBV1V3bmRtZmdTWVp3dGIvc1RDZkVzbVFBWThtVFFWU3BIN3lpWFlt?=
 =?utf-8?B?WkFBaDlBUkp0clRTWDg3NHpEVDFSZWZNY2ljMHEwNjExTFZGUCtuWmE0dmRw?=
 =?utf-8?B?Z0szTFVub0EwVUlFS2xaTVJHdE5Bc1hHdEJKb2hiQldoT1JVeWE0c2lqQ01M?=
 =?utf-8?B?eEY3b2QvOXRhMjltNTRWTUowdmttS1Jpd2tOYnJUblc4bDl6VzkyQnc5WFJy?=
 =?utf-8?B?b1R3a1RxK3c4T2Nwck9pQmhSU09zVzlwcE5mWmhEZGZNcUhWdHA3S1hOU0Ez?=
 =?utf-8?B?K2c4MFc1d0QxWEtvU3J1UU1ZY3c4Nm9nNDBrUXF3RkhCa3Brem03ZldSK21q?=
 =?utf-8?B?ZytiNFQ2ZzRsK2VKcEQ4S05MTWJVeTY5U0tRR1d0eXB2eTZXTjI5TUIvNTg1?=
 =?utf-8?B?S0F2ck9LaGNlS2NzczRyRWZjYjFsL08zL294aEFpbXJFcEMrS2lRLzBqeDJ2?=
 =?utf-8?B?UDY1K1RpVE9yTm5ZWGRBTEtBK0cwZEVMMytLd0p6UnIwVEhZelR2QmdWd015?=
 =?utf-8?B?UG5xRXgrZXJrWW8ySXN6bmtXd1A1NWhnTzQxOUlzeUFxWHFxUmZnWTM4aFF1?=
 =?utf-8?B?S2gxZlA2cGlBOFNNL0R3OHNzMTczMnBTQklONEpzWk11Z3JOZWFkTCt4V0p5?=
 =?utf-8?B?SnAxU3lqc1hFTVZNYXBVMTk3NG52TTFYQytNV01uaVdWamhBSm5WT3dYZGQy?=
 =?utf-8?B?RFdkNG4wUGEvTVU1cEtkNVhJcHZiNUdsbkhTdTlxeW52UTlNenVncnpTeEpw?=
 =?utf-8?B?b3JiY0RKSlVmNjVEaUo0UHNtUjN2NDRtUmpnNU8wM01GeGNiNS9uMlRHbGwy?=
 =?utf-8?B?WjVQWTBxcE9MWS9uSkY3cW5zM2lrVmZqLzBpV2JyaURuWS9Nbi9SMnprS2JI?=
 =?utf-8?B?R013QVAyZ0lrM051QkJvU29zeHYyS083UkV3enkyVlgrclplMjhVUWVRaUZy?=
 =?utf-8?B?RkNPSWZJOFhhdG1KaHdYblYvQm9OY2lCeDI4ajFGRXFTdndHczFZWEQzVDJJ?=
 =?utf-8?B?TFI0Q21ZWFI3SnZxRGpFYjdpQ1dwZDBZWEJuYnJWNlczTUVicUpXZktjbGZM?=
 =?utf-8?B?bHZZVk9CL1IyS0syOUlHNHhjS3N4elk4VjNMZGJpR3dHNzRFUkE2bWhOTDZL?=
 =?utf-8?B?RzUybmlzNXM0KzFvUFdQLzQ1UXFhZVlBcHBOdTZYOE5tQXprR0V2VUh1NnJp?=
 =?utf-8?B?bG5rOVVZV3pZd3BmZHc1Rzd2L0djTCtRQmJqNnRUd1JwMWlBdFBpTWxXUG9T?=
 =?utf-8?B?M3U4cEtvYlRpVHJhVGdCZ1pWVHVkWTRIVzVJWTVaMHZKQ2E3OXJld2dIa1ZJ?=
 =?utf-8?B?bm00ZzkwOFVtQ0dyaHBrSytWRHRvajRzMlMySVRKUTVKdlpoMzNacDhza1Fu?=
 =?utf-8?B?a2N5ODN0YnpCTjhKWks5c0U3TXh6Vit6Z0g2VUtjYm5lQkUzK0hYSGpUbEtI?=
 =?utf-8?B?RktIR0JKUStJVWVLVTY0T0Zudy9MbmdRaXFOU1NhVmdiTnduTjVkTGpmSHBs?=
 =?utf-8?B?RVdDNGtCK1l5ZCtXZEUvei9GRmZyMFFuaVQzQzRiRVpvSVFsYXdUU0lWMTYw?=
 =?utf-8?B?YWNJbDJvRG96SFZDR2ZJOVJYM3dobXBJdkNueDFsTUpXdk5jMnhTL08rK3Bv?=
 =?utf-8?B?MWxTbTRuaHVrTEpzY3ZQSHdNTFo2WEkyRjc1SVdDd3c4UytFYzRIa3B3VXBY?=
 =?utf-8?B?NGtLcDlITG03aGhocDF5UnRXMzNxSTNISzZGQWYxZ040QzBOeUxrdFYzRkhh?=
 =?utf-8?B?eHRObEtQMTloYTZnVWtRTTYvV1dQc3M4UUQvVTlFMFVWeDlGVlhFTjFOVzk0?=
 =?utf-8?B?WFl6MDNlN2cxcDZoWnIyRFVYSGJsZXhBVzYwZ1ExVEdxT1p0TTZCdGFiM1Nq?=
 =?utf-8?B?aTZKL3JGUXowakFXLzBxUE9QQmpQQ0tWZksvZFU4N0M0RFR5NGlmWW1TaTRG?=
 =?utf-8?B?SnVJaTlQNWtCem95T3gxVEYrNFpZM2ZtdXZOR0xUMXdSMHliUnhuU1ZSdys1?=
 =?utf-8?B?ZEZHMUVnZk0vQ1hxT3pGa0JFaml2VEdUMkdEVUR4aXlVZG8zSmF5Q3RvWENQ?=
 =?utf-8?B?eHdFRkdzY2h5RXNSa1ZOZnc3UWFjYm1qVVlCYmRvNUxzT3pkQVdqSHdQTkxv?=
 =?utf-8?B?ZkdsSVIxT0FuMTBVZDQ1bk8xblNpYVdvQTZxaE8vWUordThDV1dUUjZUSmxq?=
 =?utf-8?Q?QasSNirGHL7a8fHB1UaANoo=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190ae59a-0ca1-4473-8152-08ddbef25e0d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 14:10:32.6855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psB8ZxSNKLW0/34cZurdDYF7n5OQPBi7DhP3VcGlkfh3NHkMYPr7r2IBomd2LgIIy21IfWqhAxLYSnOkSwHq0iJWdF/xuMwB8aHVZrwi4Zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9665

On 2025-07-09 10:06, Steven Rostedt wrote:
> On Wed, 9 Jul 2025 09:51:09 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> One use-case for giving the "current_type" to iteration callers is to
>> let end users know whether they should trust the frame info. If it
>> comes from sframe, then it should be pretty solid. However, if it comes
>> from frame pointers used as a fallback on a system that omits frame
>> pointers, the user should consider the resulting data with a high level
>> of skepticism.
> 
> That would be in the trace sent to the callback. We could add something
> like the '?' if it's not trusted.
> 
> But for now, until we have a use case that we are implementing, I want
> to keep this simple, otherwise it will never get done. I don't want to
> add features for hypothetical scenarios.
> 
> Currently, the traceback is just an array of addresses. But this could
> change in the future. What we are discussing right now is the internal
> functionality of the user unwind code where I have made most of theses
> functions static.
> 
> The only external functions that get called during the iteration is the
> architecture specific code. If that code needs to know the difference
> between sframes and frame pointers then we can modify it, but until
> then, I rather keep this as is.

Indeed it's only kernel internal API, but this is API that will be
expected by each architecture supporting unwind_user. Changing
this later on will cause a lot of friction and cross-architecture churn
compared to doing it right in the first place.

Thanks,

Mathieu

> 
> Jens, is there something that the architecture code needs now? If so,
> then lets fix it, otherwise lets do it when there is something. This
> isn't user API, it can change in the future.
> 
> -- Steve


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

