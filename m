Return-Path: <bpf+bounces-62704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B209AAFD7BF
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 21:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C076E3A6F0E
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD1D23FC5A;
	Tue,  8 Jul 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bOrvsVLb"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2095.outbound.protection.outlook.com [40.107.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4E23E33A;
	Tue,  8 Jul 2025 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004746; cv=fail; b=pIzKwlCrxG25jo7ccsSetIf2pNEEeLsjRUkbaJMyiibbQnoRyiNEIXbhXF1k8TvFg4fLhFEzsJlFEdCT19cSnmrARksfT8Jw7NQdfo0+3sZ1Xy12/bp49p3cAqt2AcxHQBDp8c+HfgVZBl5+JT5PIMW3+ifYJlF8q5bvz8m21iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004746; c=relaxed/simple;
	bh=IfgaIQjEk+qVoZ1gmE47LO4tYfne8UG3yUkBb5wc5Ko=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iJd6nR/9tyHLzlBhULE3uSD0Ev/142rwBZhdygAkaVFhYt7hDMnDaQL9NcpXRQXlpgkBkF/tlk/QivKaN1yWE8KfnBzcUn33QSJC5RqC+Gi2EVn3oEVuH/T58ateF//4e3f/JMVYCk9JOxElia6kxdNAsZeAMAwDjZBfQCMapNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bOrvsVLb; arc=fail smtp.client-ip=40.107.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0yWNj197IK9p+Mjd5Pnq2NO9TeCDpo2YwSOlvSQLXl6tg/hAWExjqMIQSeM1isD5kwhT2g2xw7vvkUoa672sWTKzxZSk8Ce5YYCUXjgPIOLCddZXpN3wwvvaZaI35NpgfSVrxjedhK8pL/itSrqvsJCRTiWjbTDW/xiTbt8jCWMMQdWIIoOyjwooYJxe7RgY7ZZHDHa0vFS2kJtqBH8+YMrzioiXmBbSJ/vnU6Amcj5p7Vcft2M/VhwY9C0dv1L9Q5cKFze2eYemeO3YF+3gY2ClK7bWgJAfFFfzMOrgX0oRewkCh5DKlb+luqur22wpxnUquMwczHXcX5EtcltiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyuc108M/slhYxHP0f0PI1q+H35A8blhn+0Wns0pyis=;
 b=L32LVVpMOdVBr145oa9eHySn264SK/dhp4eVLf6RUzVhRM5Bl3om5M/a67Wvgh8Q4yWsxc9JgsacQRTK3hcLxnsEI6sNrG0xokfkKkYiAmD750mTjp53eRoo2s7O141gecbMn1ad50koKPi713g831JkZ1KPA25WUwXOLpzd2CHmUSAMj/A62w9LarSKnpFuHvALtEAaDyGlYAFBsKCnGw5AfWF7qY/ObYtJGmsF7vUBZlJgYt+r+rrA6UfAIzcCK8BV5B9FvObPTyy9jgvqAekjei4bZLrp2wepxQfixfDlQiIRW2g+dHtajlCcCVff4iK8y8gu78IDU0VRXojAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyuc108M/slhYxHP0f0PI1q+H35A8blhn+0Wns0pyis=;
 b=bOrvsVLb69x4lotJHlsdOS8Y82wlu1udqdAJmjdiZUeE86oRRWtz27LPIK0JeYq76gG94fwgfPMZId30xYjujBOXDCGv8dxIiPYGxLNtRRLCa0KZjnogl5oVpHg3/lp6owfH4YSWUGUW71Y8r6HtAYG/eLP1XobzrvY6kulohMoh1IVRsD9wPkngH7yd+mslhj9kJJdOsFWhKe/tL2QNn8dWshXjQOASpf7CiQyNZKEHQikP3YbuvSYXRrPigGn7J4V5317+1Iodrn/Rbx5R4hJiNsk+W1EkrGNj6r2ZSYvs+c6qztqX/zL+XdZCW9tSaXA0KnCz5mpJ0zJ6RPX43A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8895.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 8 Jul
 2025 19:58:59 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 19:58:59 +0000
Message-ID: <d7d840f6-dc79-471e-9390-a58da20b6721@efficios.com>
Date: Tue, 8 Jul 2025 15:58:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
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
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
References: <20250708021115.894007410@kernel.org>
 <20250708021159.386608979@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250708021159.386608979@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bcb31d-2138-44d0-36da-08ddbe59e0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1ZOeCtCMUJINEJPNlgxbjlhdVFwT2YwUTB0OE9oRGFzVy92cXozYWo5OXk4?=
 =?utf-8?B?dTIvbUQ5T2dMN0lpRGp3MzVBTmljckpSblpJYy9MOHZYczZaTk9HdlcrR0F3?=
 =?utf-8?B?bDlMelBSYXdhc1VLSXEvVms2bzNaUXNWUnUwNnJqYnhQaStvcnJGY0VQWFhl?=
 =?utf-8?B?dnFXWmZJQW1WOEYyUnpFU3BzZVl4ZHpOL0ZTTjZ5elhCQmdkWmxncURUTC9q?=
 =?utf-8?B?cmp6Ukh0M3JRSG9CSHE3Si9SeXRRelNXYkZYTWU3Z21lbGhydFQwUVdkVGpM?=
 =?utf-8?B?T25CTkRvQjBSSGt1UFd1WGFqTWhGVSs2SkorQTgzT0h5TjVuSUEvY3RIQnZs?=
 =?utf-8?B?LzJCZ1dENzV5N0dNTDVlckR2S2dkOW9tbGZyKzNtRVduNDExdlIxUlJIcElm?=
 =?utf-8?B?V1kzRTkwSmxXVVNmOVFaRU9EQjY1ZUhFeWR4aWE0UU5EVzNOUkt3UVlrSUVu?=
 =?utf-8?B?eGRRRDFLQTRqMDA1YzMyYzBGcEt4c1E0MUk4c0xLeVV4b213UTNZQ0ZuNHdP?=
 =?utf-8?B?QjVNY2drUThvUjI1bFdjekwrcW1lSDVCU04yUjY2dTA3M2UyMHZUalBqRFBl?=
 =?utf-8?B?OU5yYmtyRnd2d2dmUlNRK0F6ZEplaHBLNW1saHV4Q0MyY24wZisxcW5HTVpK?=
 =?utf-8?B?U3F0VGJBY1Zyd2J3WUdkYWtmbDNSbHJiV1FPOS9haXRTMFM2VjBHa1d4WFdK?=
 =?utf-8?B?K3I5Tzd5Yzg3UTV6TDU3ZXhuOVQwVVdqZnFIZ3lxM255ZUlLOGVRdEVCSm9Y?=
 =?utf-8?B?R1JmdkZVdERUbVo0MDBYNVFrVUtwOHBnejlTQVYwYk9BWjdPZVZrckdlWkI1?=
 =?utf-8?B?c05TTSt1eTZ3cHlHbG5mak1DRkEvOHhFb3JwMWdaYnBFMDRIUjMrekkwMmpU?=
 =?utf-8?B?TkE5em1QQ0U1VExPQnFtU2pmanl4OGR2RldSUjB6blNKR2p1amZqWWl1U1pV?=
 =?utf-8?B?UG02WTVWaEIyM0RncExvU0JmcmJJVXZvM1dnRTZ3YTRUVW42bjNqT0JxdTFx?=
 =?utf-8?B?ajJrdVVoZndWZEVoUVVrK21FV1BaclZURkJqdTl2aU4rMFVYMVlnL2U3VTBs?=
 =?utf-8?B?c01md1B4VDByQ3VNT25mMzY1MEhUUWg0OCtLRGpiZWdralIwQWxVQzU4SEpU?=
 =?utf-8?B?UjhYdElHVlRML0M5T3FZdEE0TlB2c3p1NlU1b09JVkdtdndXRXRVaVNtbUF6?=
 =?utf-8?B?VDRMWXNzRExyUlVkNnhlN3YvYzZ3YVg5K3BGdFN4UEl0MkNUUXRWTitCQ0pj?=
 =?utf-8?B?VERxVmNyU09xNjJxK1hVQTBVUVJQeTRnSkNBZkVldDZlZVp6bG41R2hVSmVN?=
 =?utf-8?B?N0d5cmVDVEpqT0FsZ1o1RHF5V1lBNWtVa0IyWkw4SXZ2QXNqSHc1UTFKZlpz?=
 =?utf-8?B?ZGNVVTRPRk9ZQU1nTk5IWUFzNy8vTkFYcFVEeVFFYmtzcHNVbmxXZFhWZ1Rm?=
 =?utf-8?B?MEtPbklxb3hPV0lRNVhiQmRDaG01Smdza2phMzYrUWM1MXFmM3Btc2Jpckhq?=
 =?utf-8?B?NUhVTkVsOC9PRjNjamkwV0RIamdGbnRkd2hnazZ6T1R4ZTJGSDlpWlRpR1ZX?=
 =?utf-8?B?NWFSTzR4Y3NDSHd1MDhnNXBJT1BDWi9WVHZOcTJOZVFCVXdqN0J5WUtKMndk?=
 =?utf-8?B?NTdtQmF4VFJFVFVWWUZKRVFYVDlpeko5L3IxVXBLcUlsYUl1OVkvMnY4RWRt?=
 =?utf-8?B?eUZUTFJHVmY3QjArSW9rY2FpR2syWGJVdVk0WUowUU8vcGVvWG13Q3R5Z0ZI?=
 =?utf-8?B?VFBrdlJwSmdtUTdVZjdTOG5XKytRYzFlYWVyL29hcVQzS3I5OTE5b3ZCK2NS?=
 =?utf-8?Q?ZdjFfdAwFubndErAFRwnlKqrx2I+vdR+hYQ34=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWtPSWRNQW5yTGNvc05PSFNveFMyaXRYUThRQUptQ0hlVFFadm1rMEp6UzBl?=
 =?utf-8?B?eGNlSTlJSHB2bTkxN1ZUK2QvcXYvdlc0KzRlMWlMTzZDcWhSbVhLNEwrcU5i?=
 =?utf-8?B?YzdLM0cvVDA1aDNpZFZRWVNsTUEzcEw3cHBaN1dnU0UwRDYwMTJ4RXNjRUtr?=
 =?utf-8?B?djBLMlFmMk9BdzlqNnFFbE5JSC93V3RBZWUrTHQ4UGd2RWNxZmRtNGwxa20v?=
 =?utf-8?B?L2ZSekRsWXRURjhVdUJ2UUdtTlcyT2ZReUtxQ1BoM09KdzF5dW1ndXpGY0ZD?=
 =?utf-8?B?aUFLZGtHcGlBZERqWVBuTmRHZzNKOUdHUDZBcHY3aGJKNXZ2YXByNEdjOE81?=
 =?utf-8?B?VjN0Z2o0K1Ywbkp1S0NtcjBSMmhVZlMyQTdNb05QOXhUN29BVHRaZjVCa0hy?=
 =?utf-8?B?MWxmU21maTY1VEIrRnZ3YmtObkJKaFYvOEV5VkZ0ZURKT1hrVGRFQ21YdUZO?=
 =?utf-8?B?M0JRcGJaTUJmTzNPbEdqU1Zrc2FVdTM3TFp0L3ZPL3lKY2tEWVdlYzh6WmJL?=
 =?utf-8?B?ak5jY2hFMVpVa3lyUld3dGxsNzAxVUI5ZUZYeXhXcENHS2xiejRtTGVBMFYy?=
 =?utf-8?B?N08zMTVDN3dOTEI5ZVV1Z2dmeFRNYWhETDJXUG5MUlpjRlgzOTczelRnZG1a?=
 =?utf-8?B?RWhZN3R3bE56QVhFbzA1bUMvT1lTdUEvQzRjN2lPZUpvUE1JZnhla2VaaExQ?=
 =?utf-8?B?ZUgweU9mWk90WDBKcC9uVFZwTFZITEIxUEd1eUpFS1pCZTJBdDFNVDExSHEw?=
 =?utf-8?B?YzJYVjUvZnJyTkVzTjZXbkR2NCszZTkxRzNyRmlEYjc4T1c4VTJzOVVjL2th?=
 =?utf-8?B?MGorbWlJek5DWVg4R0lyeUkvQWVkRlZITHlFYXF0RXE5VlpzelJhRmo2SndO?=
 =?utf-8?B?akNwV3k0VG43RUppTTV3V25tUmdabFJKQnpHRlJTaGNzSG1QcWdpQTNGZEk2?=
 =?utf-8?B?T09hcysxVzlGZFNybllVT04wMjBMUG9mMnlkKzRCdFQ5STgvNHAwMU5FcDNo?=
 =?utf-8?B?V0xkV1dRU2MzRGJxaFA2VWZmYVRXaWpIb2ViTVUwMFpNRUhnbklKSUI2TzZn?=
 =?utf-8?B?YkdvTysvWWJubzJMVkU5L0xlNkdmaS9maFcvbS80Qm4yS0xOVktWWUliSjl3?=
 =?utf-8?B?SFJuY3VmRlV6Q3BlQ3I4YW1iU2xlRWFJSzM2U3Y4VjZqaVkyNk9nQk56UlVo?=
 =?utf-8?B?TWRoU3BNcWxjdlZ4TU1yTTRHQ2ZUbC82ZkoySnhsckdCR1E2OVJPOWxqaGJT?=
 =?utf-8?B?Rk9BQWNuai9TaGpYM0MvWlBUOUxUYUFDZU4zRjJkY1phOHhyWC80TjluUnI2?=
 =?utf-8?B?bVVIcnVlV2NDRmZTQWlVTkJhZlJKSml6SGpYR1ZublNXY0R6dHJQUy9GL2gw?=
 =?utf-8?B?MGhSbG1aWm85T2VaYTFJUzlWeldyVDV2UThmZENJcjNXR3N6dzgwdWR1Yi9w?=
 =?utf-8?B?c0wwVm5zcWUxR09lQUpyVzNHUXdEZmE1d0tvS2lrSEFHSS9GMXJZTVczL1lR?=
 =?utf-8?B?TkJRdyttV3FqWnppSk1qNzFFRGl3bXk1cForUWZVb245a0pudTlQeWFlK2pi?=
 =?utf-8?B?dDRhZjlJUzdsQndud3IxckpUVkFra0hVRHlCaC9xOGdOMm1nOVdDOEp3OU12?=
 =?utf-8?B?OS9OdkRqaHowOVkwclZaM1IzMCtCMHE4RVArR3lnOUMycHRZWjBTejI3dlV2?=
 =?utf-8?B?c2hXTEVDMkVYYzBESCt5eUhzRXFvY29rNEswYlREQld6a0R3MjRlWVYzekdK?=
 =?utf-8?B?WWVXUFgvK3lIUkxTZXlURitPWnVmakpHZW5xMVNFVjRWZlNpQ3pFMXhHT2RS?=
 =?utf-8?B?M20vZ3N2MER4aE84WHdEOE1Kc2ppRTBObmhFTFBOQXVjSWo3VDRxRklYb1Jx?=
 =?utf-8?B?WnRaTzlqYk1sbzcvL2Z2V1VnZXVlZVBGdHd1aUNtYU0rQVZQbzU2RlRpTFZP?=
 =?utf-8?B?Ly9tcUtqeW9lSklseVVsV2tTTm1qaXlQdzJqOFJFOE9QS0phZ2dodmM5Nmkw?=
 =?utf-8?B?NFlIbVpVRUhoQitXM3lySW9HOUtaWWordU54bTg0RGVDakV3dW9QV0FZbytE?=
 =?utf-8?B?bFNqTTRKVllJTFdNSXJGMjJ0cHAvV2RxOTBaR0xGazA3NkxzUVFacUR5TzZE?=
 =?utf-8?B?VmRwQ2d0ejlldHorWXYwRDJ3bTlrdmc0MW1xb0NlTlpBNmliZGg3VjJPWndt?=
 =?utf-8?B?b3F0T2FqRTVzUVVJM2VqWkdxQ3VGeEx5T2hOZk5wZXRZc3NLNXBMOThuakV3?=
 =?utf-8?Q?Lk4IMq+I5v9UkMvR6Sdcl7FUshcBYyj9z161X8ZNiA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bcb31d-2138-44d0-36da-08ddbe59e0b7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 19:58:58.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4bwUDV20YlehFH9X/pPAlhu/K9q+GZallgseWdxTtnDA+NDI9w2dSw9RVxRMvKg6pZFFR3elHVd9WdUz4ShbBmvqpBXtqJsOtbCMu9FRC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8895

On 2025-07-07 22:11, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Now that the sframe infrastructure is fully in place, make it work by
> hooking it up to the unwind_user interface.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   arch/Kconfig                      |  1 +
>   include/linux/unwind_user_types.h |  1 +
>   kernel/unwind/user.c              | 25 ++++++++++++++++++++++---
>   3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index c54d35e2f860..0c6056ef13de 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -448,6 +448,7 @@ config HAVE_UNWIND_USER_COMPAT_FP
>   
>   config HAVE_UNWIND_USER_SFRAME
>   	bool
> +	select UNWIND_USER
>   
>   config HAVE_PERF_REGS
>   	bool
> diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
> index 0b6563951ca4..4d50476e950e 100644
> --- a/include/linux/unwind_user_types.h
> +++ b/include/linux/unwind_user_types.h
> @@ -13,6 +13,7 @@ enum unwind_user_type {
>   	UNWIND_USER_TYPE_NONE,
>   	UNWIND_USER_TYPE_FP,
>   	UNWIND_USER_TYPE_COMPAT_FP,
> +	UNWIND_USER_TYPE_SFRAME,
>   };
>   
>   struct unwind_stacktrace {
> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 249d9e32fad7..6e7ca9f1293a 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
> @@ -7,6 +7,7 @@
>   #include <linux/sched/task_stack.h>
>   #include <linux/unwind_user.h>
>   #include <linux/uaccess.h>
> +#include <linux/sframe.h>
>   
>   static struct unwind_user_frame fp_frame = {
>   	ARCH_INIT_USER_FP_FRAME
> @@ -31,6 +32,12 @@ static inline bool compat_fp_state(struct unwind_user_state *state)
>   	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
>   }
>   
> +static inline bool sframe_state(struct unwind_user_state *state)
> +{
> +	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_SFRAME) &&
> +	       state->type == UNWIND_USER_TYPE_SFRAME;
> +}
> +
>   #define unwind_get_user_long(to, from, state)				\
>   ({									\
>   	int __ret;							\
> @@ -44,18 +51,28 @@ static inline bool compat_fp_state(struct unwind_user_state *state)
>   static int unwind_user_next(struct unwind_user_state *state)
>   {
>   	struct unwind_user_frame *frame;
> +	struct unwind_user_frame _frame;
>   	unsigned long cfa = 0, fp, ra = 0;
>   	unsigned int shift;
>   
>   	if (state->done)
>   		return -EINVAL;
>   
> -	if (compat_fp_state(state))
> +	if (compat_fp_state(state)) {
>   		frame = &compat_fp_frame;
> -	else if (fp_state(state))
> +	} else if (sframe_state(state)) {
> +		/* sframe expects the frame to be local storage */
> +		frame = &_frame;
> +		if (sframe_find(state->ip, frame)) {
> +			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
> +				goto done;
> +			frame = &fp_frame;
> +		}
> +	} else if (fp_state(state)) {
>   		frame = &fp_frame;
> -	else
> +	} else {
>   		goto done;
> +	}
>   
>   	if (frame->use_fp) {
>   		if (state->fp < state->sp)
> @@ -111,6 +128,8 @@ static int unwind_user_start(struct unwind_user_state *state)
>   
>   	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
>   		state->type = UNWIND_USER_TYPE_COMPAT_FP;
> +	else if (current_has_sframe())
> +		state->type = UNWIND_USER_TYPE_SFRAME;

I think you'll want to update the state->type during the
traversal (in next()), because depending on whether
sframe is available for a given memory area of code
or not, the next() function can use either frame pointers
or sframe during the same traversal. It would be good
to know which is used after each specific call to next().

Thanks,

Mathieu

>   	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
>   		state->type = UNWIND_USER_TYPE_FP;
>   	else


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

