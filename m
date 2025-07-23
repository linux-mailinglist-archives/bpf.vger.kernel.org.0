Return-Path: <bpf+bounces-64178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBB4B0F6DB
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD173A2BFB
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ADC2F234A;
	Wed, 23 Jul 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dZHgTOKK"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2137.outbound.protection.outlook.com [40.107.115.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC3156CA;
	Wed, 23 Jul 2025 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283742; cv=fail; b=rNq2syR6P0a7pE3H2YR4QVl0VMGzsCvBlwZOTdNazS5JtAAwF8OI4xdZll3yHMcJyc8kgcgrkiy4AeTXLrX4cnYvAhsUpGTtNQHNXJY0tUqanhk4s1swriFE3U3M5Ztvdpl1cRHfCu03KOsUhPVGW0llFCopKG0qGvzlllSdhis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283742; c=relaxed/simple;
	bh=KbrM3Kjt/jcJtTz6tsfp5TmdiKTpszZCgp5vB3Ys1Cg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iDs2oV2ih1uG3+ea6AZkEdorF+KM7QLu6CmQxZraL8Fg4nIRBDcEKsQ221Zg6muZj3Lh/meXMm10sHHPoW2MFdhx4DNZWWQbHwusEnr2ig2mBu1aZrAjz22SJLZdgJOyVq7XNpyeq+3CEURY5A4HDqyl+7Ewrut5gJDJ4znWXOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dZHgTOKK; arc=fail smtp.client-ip=40.107.115.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUfofwzLSl1Hv0bdaZx3kWzyq5oFnpUtyF5GaecVAsFjrL3KT35CH4FkPCKX7xAz5NZJxt0vEvCBWcsxRzyQtyu0uWIXN8k5btEthh+ouRAsnAxBJGiz7Zvk/VJ5xSiGy7B4c1rGkGG264VVpCzyB12npPSLF9clhik+xtjOCASWCJhW6G3PH34Cw3E4+hcreQi1RXecUzwM8tl97SlLlvaWYGH0IM9BAcH0SIVTImnc2OhUgDiSVLnIKMQKu5OrBixLFDWbY7sSXC+HkEA+zmCHkM35IjZTM2fDmzg45Xmfn4xM/HbjYJ1ZRLF0Ucr7Dl7z9F3wZ6Y1mw1GXi93Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nH5SLcqwKD4qIOL6nzAoM74NYEV8fYuR5stNO4ozmog=;
 b=g2fRb3+Un5mwtz8stjbdaZvyiEMKGKS1s0fBitOgtTKprArBJoXMxUI6O9ult740ZqtzlOYbG63cJW2Aw1igvNivQX/6pjNWw9ybPcuZ2OPPH0xd3BgdOr2bOsc+BlsiIwdHHYYL8wxiuqLP9O9MRWrTqTZQ4MpK/qcg3OnBaHeuj4Scoj103iOGYq3kJc/xtBSZfttXVvAZ6dZN4TVI7Ha2MgLu3TPx2g1TB7IDVlcEA7+3buYbH/1KkuXWzd0BL8xtYXRSD9UBl0GdYcM4qsO+sRuDqHr+/kWIoNBmDK69TII5YjOInAF2ckStUl/DOGG+WCLy9X0xK+FxjSCfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nH5SLcqwKD4qIOL6nzAoM74NYEV8fYuR5stNO4ozmog=;
 b=dZHgTOKK49/zM361aVVIPxtiX5uliAJiJVnLfIvosl7WDnc7RbjDY+phX3foqn1U8gl3WNIV8kNLBjP2/DO1iou23M/6vxaZwgd2dh+qCgpmKZkDLd4IocbU2Gry1UOFt3bFAWhhhaNr1hDI5Z8TLhxPMBlnfCQqsm+mKN7YKnS8tpc23arlbkbyeYbyzRt7cSlmQ+dA6awQUyPuSjNAKOkXypkgxn20vZM82HgqlPJs6NQ16YTdD/JtxRuV00edDFNsOgh68EAWdMg1R5yQVUrIdMN9qGJR59B+Nvt3LTE0ftCvGFu6/EsBHIaaKASFqs7iNgLaM7pdAIMRmeCm8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6614.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:71::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 15:15:36 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 15:15:36 +0000
Message-ID: <2a85b4b4-a240-4e8b-b2f4-5eede3297082@efficios.com>
Date: Wed, 23 Jul 2025 11:15:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New codectl(2) system call for sframe registration
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
 Brian Robbins <brianrob@microsoft.com>,
 Elena Zannoni <elena.zannoni@oracle.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
 <20250723092620.c208fc0d3b9d800c47f87556@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250723092620.c208fc0d3b9d800c47f87556@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 4833147d-d522-41c7-8f96-08ddc9fbc6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVBwY1gxRk41YlZGbm9RdkF6YWRTY2lwU3k3d1EzRCtTRHJqM2ROTlZVbFpq?=
 =?utf-8?B?cDZod1YxQTVYTWk3OW5qWHRIdFVLQUpXWHpPTVBTQWJTR1BXNDNzY1dBVHgr?=
 =?utf-8?B?aXlCdjYyYVlDRGc2a3BSdEpHQjVrWjczcWFBeG5OTUhweVNJY2NzOGs4cFhu?=
 =?utf-8?B?Q29iaUx5R2FqUTJJdDdJZFNKVTQvak5mRGJEQ2RCMW5mbDBNSExGRzRBb2Ev?=
 =?utf-8?B?R2Y0QlpHZGU0MkMzM3RzWHVWZEtkNzN4dy8vN3ozSHpSQ1NhMVdIT3R1NVlN?=
 =?utf-8?B?SGxVT3VKWFdaK3lISjZ5bytkRVVrRmRQMUZJWEc3WW5kVWwyclZKa0xQaUJB?=
 =?utf-8?B?eW5TczNoVkNlVkFNOHYvcXB6djN0TXRXQkhXTC9VbzVxR2tLMS8wK2RKZkc1?=
 =?utf-8?B?RHYyOHpvYkl2YWpFcVZMcVpiQnpSTXU2alNoZ2V6WWptazlDcjdsYWtXK1lt?=
 =?utf-8?B?T2ZtSkl1QXlGQ0RyVmJBaFdjYkJrLyt0QTNkZExGRDJCUmVVa2REbDFpREVY?=
 =?utf-8?B?dWMvRnVRekRYa2ZBTklNVjI0bVE4R2lpcXVNSklqeXE4RU5RVGlmMmRxOVlV?=
 =?utf-8?B?NHJ2bFJIdFU2SUpDMWRFQ3NFTDdhdk9HVHplYmJacDluU2ViUTZFUGpMSnh4?=
 =?utf-8?B?T3FtcGJtLzAycytZVlpmdGJuRFdFYjBoMFFaOS9kYytwK3I0K0pVS1dkREo5?=
 =?utf-8?B?ZzA2WUxqNmlwTDNQZWR6blBTeDJZYmVoNTJrc282UVBZT3dNTGNJbXNwbG9S?=
 =?utf-8?B?WjNMVjhxcHBtdG1WRXAwK3ArQ0RLMm5JNkFGa2xNTld1TW1ZYy9qTGFDUWQ4?=
 =?utf-8?B?d0g3SGlJL2RSVzZFQi9aUTRlaUdvbStZTVJEVGMyanYyV2N6bStUbURaQkVQ?=
 =?utf-8?B?Yi9RY0JWK1dVcG1vUkhkdHRWNzdqVjR1TGxuSzU1TFV2bTVmejdpc1NNSHVC?=
 =?utf-8?B?SW56cnpSQnZLUkpTZUFzUm1uc0RqSldTMUh2ZzNpRnc0Ym9vYW14UXgyUXdO?=
 =?utf-8?B?Q29KME5DMFVpckhmQjhSSGx2QnBPUGRXeDVleGVHcUxKeGwrUHlvRjRBWExt?=
 =?utf-8?B?YUxKSHd5WnlldW9qMnNjUXFPNHpraTRMbGJoNjhMNGFBSTIxMXdIUVN2SWk0?=
 =?utf-8?B?NnVZaUN2QUROcHhRaFNXQzBXbk10M3pQN25IME4rRlYyM25IdkpjcGUwekpW?=
 =?utf-8?B?VW5tbVpzYll1bTQ1NmcwT0xWMnJyVjhJM1VOWUt6K3BER0RNRHk4WDNLelli?=
 =?utf-8?B?SWdmSHlFTitBaExVaHhkNDNxOWNFN29ReHUzK1k0K1VqYlpnSldHVU1UdXda?=
 =?utf-8?B?SVdpbXA0VGdtcURUS01SUExhNlJBQ0VubzY1ZkRjajRLQllqVHpUSTlFV3RI?=
 =?utf-8?B?bnRGU3RuaWxsMlBnTTVHOXhoNTZXTHVpYlR3dUE5MnQxdUtuU29hVkJxdXFS?=
 =?utf-8?B?TDV0a3NYSTR6MDZOb1EwNDl4TzJWSTdreFJ5S1hhWHRKb0tSOUZGYTZ2NzI1?=
 =?utf-8?B?Vm5PSk5ld1ZGbWc2Y3JSSGhZVmJ0UnMvRWVQclFxM3FQZ3U3N25teWdsYXg4?=
 =?utf-8?B?aTdLUCt0SG9xRGlWWnp0RXJqWDJOZFkwY2RMSzMwb05ZRkFPNkY3cEdkT3BW?=
 =?utf-8?B?cjlzZFU5eCszajFFL29xWVByUUZvWHJiY3M0NXNYKzhrT1BqdnE3S0Vjc1Bt?=
 =?utf-8?B?NmNYUDIzeHpjUlRGWU5YbTlQemdnRGxJcVFqcTlPWXc1TlA0cWhzbUdxWE9Y?=
 =?utf-8?B?RExSQkxsbEFKaTVWc200Yy8xWjg2U1pydG84MTFnbGJFK0E0TlU3bVhRS3dL?=
 =?utf-8?Q?nSPL9lX8+ebmyGQd5unN6W2KRFATx2VRxX3XY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDV6QmpLRnY0dFpCWlJzb3ZtWkxKMEFlampZYnUyTjFnZVdEY1BpYzNQRHhD?=
 =?utf-8?B?ZjNPMWVoTU9RbW5SSUxqZ0lNSXQreUpnUTdUTkxxTGlOYXBIbzN5SE40TFY1?=
 =?utf-8?B?ZXAwZTcrTkRRRDNxVFNDS3Y5T1dBYjFKWVJiK2JlRDN1R3NLSlgxVnRQWnR0?=
 =?utf-8?B?M01jTjBaQ2l2K2RrcTRYUGY2US8zOFlnYmxqcmVTdEhDb2hlbkVFL3dQYXN6?=
 =?utf-8?B?enNzYWhTSnk2V0VvcDhndUpjNTF4dzc3K1Nnc3RWdzVUcnJtanNqVHdwYUl6?=
 =?utf-8?B?Z3VMZlhvRzBJMWZtVjlsSUZKbWlTaGlNZ2tqVTZ6b2FGTVpTZHdKMXVLNVVV?=
 =?utf-8?B?emZzbGt2WmZCMmNDN2lCbk0xOHlFYjFqOEF3SlB4bnJkS05vYTE4YmZEb3lG?=
 =?utf-8?B?b0UyZ2UzZVEvaERCaVc1VlNqNE1MSnEzcjAyZ2hsajBzbjRvMjZ5aEMrOEw0?=
 =?utf-8?B?SlF4LzRzVUwrYjdUNWxaQWo1MmdlbnUxYmFxalVVRk1BRGJZQTlTV0R2Qmk5?=
 =?utf-8?B?Tk1wa3RGV0Y5dmlTUGtVTFZKS2lZRDgrdVlyczhkTWY0YkxuVVY1aWhwbTVu?=
 =?utf-8?B?RDdWOXQ4YmttNFNpbldrVlBQYzVLbmd5d0M0L3JCSlhrN08wWXhoT1h3SWY1?=
 =?utf-8?B?S2VSQzh1WmZLYjMrWTV1dWFzWmRmLzVjYmxNcXovRnZBOEkraENYL2ExYUlF?=
 =?utf-8?B?YWl6VW1tbzRTNi9CZTBlc2lIM0ZCdWRJTmxZTUdRa2dqOXRqSnNId1dta00y?=
 =?utf-8?B?L0JaTzRpd1hyalJJNm1LaWV0VWRiZlhFK3pUVGRWVmk3eS85OEUyV2F6bXZP?=
 =?utf-8?B?UStEUW9OamVtb3R0Tyt4TkdDU0l4d2tpWE5nZEpyZmk2MFVVVlhLVThTTUxx?=
 =?utf-8?B?SDg1amVtTTFFOFI5QUpRa0xPRVcwL245TWFYK1VUM2VINnlhTHBIL1dIYSs3?=
 =?utf-8?B?N0JQdE9CSk11MkRZQXdUNXd6V2t5amZUNkRwNU0rK0NDMllOb1pGTnArVTFz?=
 =?utf-8?B?aTVKd1JHWEdaeWkwczU0UXNGT3pxKzVxNzEzQlNWelkzdXJkZitjT2w2SkNs?=
 =?utf-8?B?eHNXeUtjd3Brb09KRkdjaFIyOGlZUXpHZEhGNDFnR2tUaDV3bUJLNWxjWEY2?=
 =?utf-8?B?T01Udyt6YjJ4S3hZZFAyMXpHbzJVZmlCUll6TFFjMkN6U2NKQUJnQ3J0WTlz?=
 =?utf-8?B?RlpOcGZwTlQyVURxamttdk15TkdSdEw2aGFZd01NRWM3aDNvL2F1dDZEZzdU?=
 =?utf-8?B?VUdob2F4SDI2M1V3dWtZd081MHM3V3BTTmUvMHFZUjE0bTB6VUU3N3BHZG1C?=
 =?utf-8?B?WkxQWFdQdkVqY3I2d3RkU09mYUtjYitZS0lKbVJUVlFQRERnY2xRRmg0Mytv?=
 =?utf-8?B?cjc5d1hLdkxuaDJrYmloRlVET21NU2l5VlVqYTZ2bXhWK05ZdHF4RGgxODdP?=
 =?utf-8?B?NXd2V3M1Vi9PRFJBSVg0d3VzKzFaSlpHUS9CQ3hrQlBjQXBwN1FKMU1Ma3RR?=
 =?utf-8?B?Z2hHWmt5S0hlYzAxaks3engvQmJEWGhiSWlJc3U3VGwxTlNhL1M0MmtFK1g2?=
 =?utf-8?B?aEYzUE5sTzgvRzg1Z3VOeGlhWDR0S1RDU1IwSGZnTUVlekxNd0NhM08yYVlo?=
 =?utf-8?B?djU1YyszemQ1Sko1UWhZOHBDYzRiQzF1ekdWMFlGY0pleVpkU1dZanVvWnhF?=
 =?utf-8?B?dzRDcEd4ejF5cFprUjlaRlJFbXowRXpPL1NhLzh2RmYxMmErZHdKRFU4aFJu?=
 =?utf-8?B?cjhUL203UERSMFN5V3BXUjhjZ3JxQ3JtcGp2TFBJY2d0ay9TYjlacVNqQ2d3?=
 =?utf-8?B?cm1weU1aSklGanNIR0FlRVR5UnRyK09LbzZuQXRCbWdWSHpmVFhvNERWVFpT?=
 =?utf-8?B?SlVBMUxDbWtLK2ZmYWYyenhMdnpGR1RyRnVLTmZjaXFPWTZOZW5SZUJhYlhi?=
 =?utf-8?B?YkxkUXRMdTZXdHlFaFpvbTdLZEtCWFA0SGdDeW1OSXVGS1pCM09QWSt1eXFm?=
 =?utf-8?B?RStyN0lMVHlCWStITEhZcGVCdFBRemhubE0xZkRxdzErTEJkaExOcjdnK0Yx?=
 =?utf-8?B?WHBVcDhxdGk0akVGVHdCSkdDejkzQ3ZHUzl5R1BNVG1XVjQvNjQzZkw0ZURI?=
 =?utf-8?B?cUhDbTUrMGVIM3A4WDBxMFE5bXVkMkNTaThFZDFkVSsrNTZmU3RpZ3llZmd4?=
 =?utf-8?Q?FRRqgPWbKSCmdb2qLn7JUqE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4833147d-d522-41c7-8f96-08ddc9fbc6a1
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:15:36.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Js7XbUKuwx7+Wl0/5OdMicgWFmCvD2K4dFdLhUvYIvaHo3pVPZNLPUE6YXjszAYppoei2v+zEwGXKqUN00A/xGKRaKBEs9oXhc2IY3jYaWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6614

On 2025-07-22 20:26, Masami Hiramatsu (Google) wrote:
> Hi Mathieu,
> 
> On Mon, 21 Jul 2025 11:20:34 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Hi!
>>
>> I've written up an RFC for a new system call to handle sframe registration
>> for shared libraries. There has been interest to cover both sframe in
>> the short term, but also JIT use-cases in the long term, so I'm
>> covering both here in this RFC to provide the full context. Implementation
>> wise we could start by only covering the sframe use-case.
>>
>> I've called it "codectl(2)" for now, but I'm of course open to feedback.
> 
> Nice idea for JIT, but I doubt we need this for ELF.
> 
>>
>> For ELF, I'm including the optional pathname, build id, and debug link
>> information which are really useful to translate from instruction pointers
>> to executable/library name, symbol, offset, source file, line number.
> 
> For ELF file, does the kernel already know how to parse the elf header?
> I just wonder what happen if user sends different information to the
> kernel.

AFAIU, the kernel has an elf parser that is uses on execve when it
executes a program, but the dynamic linking use-case all happens in
userspace. The kernel only maps memory and currently does not know that
it contains an ELF file.

The objective here is to allow registration of shared libraries sframe
sections from the dynamic linker.


> 
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
>>       CODE_REGISTER_ELF,
>>       CODE_REGISTER_JIT,
>>       CODE_UNREGISTER,
>> };
>>
>> * arg1: void * @info
>>
>> /* if (@option == CODE_REGISTER_ELF) */
>>
>> /*
>>    * text_start, text_end, sframe_start, sframe_end allow unwinding of the
>>    * call stack.
>>    *
>>    * elf_start, elf_end, pathname, and either build_id or debug_link allows
>>    * mapping instruction pointers to file, symbol, offset, and source file
>>    * location.
>>    */
>> struct code_elf_info {
>> :   __u64 elf_start;
>>       __u64 elf_end;
>>       __u64 text_start;
>>       __u64 text_end;
> 
> What happen if there are multiple .text.* sections?
> Or, does it used for each text section?

That's a good point. I guess we could theoretically have a shared
object that has more than one text range, in which case we'd want to
register one sframe section for each of the text range. (let me know
if I'm misunderstanding something here)

This is an additional argument for having an sframe-specific
registration rather than an "elf" registration for the sframe
use-case.

> 
>>       __u64 sframe_start;
>>       __u64 sframe_end;
>>       __u64 pathname;              /* char *, NULL if unavailable. */
>>
>>       __u64 build_id;              /* char *, NULL if unavailable. */
>>       __u64 debug_link_pathname;   /* char *, NULL if unavailable. */
>>       __u32 build_id_len;
>>       __u32 debug_link_crc;
>> };
>>
>>
>> /* if (@option == CODE_REGISTER_JIT) */
>>
>> /*
>>    * Registration of sorted JIT unwind table: The reserved memory area is
>>    * of size reserved_len. Userspace increases used_len as new code is
>>    * populated between text_start and text_end. This area is populated in
>>    * increasing address order, and its ABI requires to have no overlapping
>>    * fre. This fits the common use-case where JITs populate code into
>>    * a given memory area by increasing address order. The sorted unwind
>>    * tables can be chained with a singly-linked list as they become full.
>>    * Consecutive chained tables are also in sorted text address order.
>>    *
>>    * Note: if there is an eventual use-case for unsorted jit unwind table,
>>    * this would be introduced as a new "code option".
>>    */
>>
>> struct code_jit_info {
>>       __u64 text_start;      /* text_start >= addr */
>>       __u64 text_end;        /* addr < text_end */
>>       __u64 unwind_head;     /* struct code_jit_unwind_table * */
>> };
>>
>> struct code_jit_unwind_fre {
>>       /*
>>        * Contains info similar to sframe, allowing unwind for a given
> 
> Hmm, why not just the sframe?
> (Is there any library to generate sframe online for JIT?)

The layout and size of the sframe section is fixed after it's been
registered. The jit unwind tables are meant to dynamically
grow as the JIT populates additional code. The goal here is to make sure
JITs don't have to issue a system call every time they add a few
functions, otherwise the overhead becomes a significant bottleneck.

Thanks,

Mathieu

> 
> Thank you,
> 
>>        * code address range.
>>        */
>>       __u32 size;
>>       __u32 ip_off;  /* offset from text_start */
>>       __s32 cfa_off;
>>       __s32 ra_off;
>>       __s32 fp_off;
>>       __u8 info;
>> };
>>
>> struct code_jit_unwind_table {
>>       __u64 reserved_len;
>>       __u64 used_len; /*
>>                        * Incremented by userspace (store-release), read by
>>                        * the kernel (load-acquire).
>>                        */
>>       __u64 next;     /* Chain with next struct code_jit_unwind_table. */
>>       struct code_jit_unwind_fre fre[];
>> };
>>
>> /* if (@option == CODE_UNREGISTER) */
>>
>> void *info
>>
>> * arg2: size_t info_size
>>
>> /*
>>    * Size of @info structure, allowing extensibility. See
>>    * copy_struct_from_user().
>>    */
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
>> [1] https://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng-utils.debug-info.7/
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

