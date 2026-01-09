Return-Path: <bpf+bounces-78379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E668DD0C2D5
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 21:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DCE23014E80
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0F35CB89;
	Fri,  9 Jan 2026 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="o9lUQgcz"
X-Original-To: bpf@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022139.outbound.protection.outlook.com [40.107.193.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67AD2E413;
	Fri,  9 Jan 2026 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767990088; cv=fail; b=tA7QP82tA6cCiPUdVv3L+q59guV2maE1e7BXR3um3103BdIdAts8gB5Sy8CqMJf5E0ojSeKgHrKUB0WMIumQkeDtVDydfuKOSW6UP42joQRV3HqWZILhCQyW49ehuLZGBX1+/LCn9PTK8IJikXdjw84EgSnEhQtCWG/3XC+fMLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767990088; c=relaxed/simple;
	bh=3/n9/6GHYiljqXoD2fyHpKXXcCnsGCz9QD/q7U7EyGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AKcBlYehEtApU+fxFMr5NfleT6TSKXPWD0okSKGqakRpqLELzbmZLH7aqVWNF0x9kLHiydojPjOFLO2U59xSspcl9uE1UprDPrqh2E60H+RzM006bqjhk/RHbrGeHH0K7tM3GmhVugTwFvoasCBMUEijLSCY5G9iI130BmKcNOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=o9lUQgcz; arc=fail smtp.client-ip=40.107.193.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2j9MPOFfeGssy9RU3VEpYmpm3g1mblS0jf8qoirk2zhnHMIEq563d+yORwciDL6ruBJ4yR2VSkUprHl9VGGnun0cGcNCemGj/zZECKj9SItSZy9lLjG/E7qMfXDDKnKjXJOim18kQ4qfFcGMZd48/kxnb+2eV8JhuLTXBWDunShbimuNDaG5++A7/8Tc8PZlO99xMm9bbvBX6pSJ+d8xS8agCmuR5RLRx84+0eornO0bB3eYH0ah4yETUlmbAAc/fr2Onx8lMYwgysVWKt6zRuyIXhn5B7EGAtD+J/uWkj2Ov7jgagZ+5bMihjlojc/Zmqj/9nOYS9M7H++HZxxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Lep/mu9VOEtneMBIgqd7cHhIjSSKeTwkoU3pUPY0oU=;
 b=WMr6eQEhUWfu5i/tIq94quH2QRKatHwkctUgqv+UVoy36qRWQ0FuDOpdvQcOochzCP3dLpuwbpUPLJRbXP7mnk1Pvd6KS7RdxCm53g8yj04gx7EW6wycYhV6xrrP3rQyuc56dTxwuspF8aiKo3DmglalMPO/wyIM6UlM/qRU1sq3mneJLOzHGHTQ8O7CuxWLQ1UAVquPjuubpVf0yXsNFm/5G8DZyRvtOshCOFdjQMf88GcpNa8EjVJAIF+DEiE5CJ75mMJkuaDV4xWSMy/TbHtHl3q87dU2JQwxt7vSwL+vb512RsTt62Ie1dBEhhpQsSPhWAqvIp1/H6wP+Vrvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lep/mu9VOEtneMBIgqd7cHhIjSSKeTwkoU3pUPY0oU=;
 b=o9lUQgczEFqIHf1/BhvHHOeid+3K2hqV61XMUUDgPITfbs7j2vocMSeVmjOL6DPNapawKZNvn0bOCZ8rjMKh8lBJWCmhRwLjfAgFraphivEWF9mmQ+3ZpM+mRXmBLNyzTw4kawnPxe1KjmSIc7GKoJ6nwxJxU78I5wYpGOB9WRp776DMoZHFtBai1u/+7aDUjuq8MuvpnrNDeDNECN7HIpgveSSeAhZxlb1nOgCi8yh/xy0BtXk/pxCbyRwETqz55VG49p8kkItHIdf7nWQiV4lzvl2uP5/xIGG2nvhccOddh3uodsr1vLd+Ri68uC6JpXRDP66NNYnQx1MFatPhWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9509.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 20:21:22 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 20:21:21 +0000
Message-ID: <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
Date: Fri, 9 Jan 2026 15:21:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20260108220550.2f6638f3@fedora>
 <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
 <20260109141930.6deb2a0a@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260109141930.6deb2a0a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0246.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6cd1e7-831f-4a88-545f-08de4fbca72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0xwNWdwbWZSWVRSZ2hZdnVyTXZIc0lkdFlCamVVeUcrckxRNlRIOFNGMDBa?=
 =?utf-8?B?SWlMZFpHK0FWdGtQNGl3ZHBXSTB4U01pcnJLQlE0UmovQ1Nvc0tkelRKd1ZS?=
 =?utf-8?B?a1dwOXVmUXdZNFM3elF6NUVJVVpraS9ZczFhQ24zdXhiWjFWNzZVbUJGR3dx?=
 =?utf-8?B?Kzk0N2JuMjkyOWkrZ1ZlNW1jckFRc1l0UWFVSitkNHRyRURXUHdlL3IzZmti?=
 =?utf-8?B?UmdBWTRKdTFjR3lab3V5dnFDU2hITHN1aE1NYXZwVVVIZnFOd3hRM1M1WC8z?=
 =?utf-8?B?YUkyMTdTWUE0WjBrVHR1YlU4Q2FJS1g4Q3RnTGdyTndqd0hBeWJHWDFUTkhY?=
 =?utf-8?B?RkxzWDZoSE1xbHpFWGJwOXFPOW44REliTW9JM1c2T1dwU2I3R2NJWldLQlJv?=
 =?utf-8?B?OTdRUHV4T1R0clpDa213RTgrcU5KRTRHRzJRWnRKc0FIYVVXc21CMDNzd2Mz?=
 =?utf-8?B?dk8razdMakJXd0NzemowTFFaMHFHSVFHais0V0R6dDhiNVJVVVRjeHgvNTcv?=
 =?utf-8?B?N0NyTmdNUlBHaDZ6ZmVlYUlhYlBHYnBZNFMrNFpNWFZiWmFubFMzNDFWcUV5?=
 =?utf-8?B?aEd5Y0ZlWlA1VDhINDQxQVN6QlduZmhzeWw5TVV4K1pEbWg2bElEQnNGL0tY?=
 =?utf-8?B?Ymo4azVDTHFZZnJFTUpjdm1wV1lOeFp4dlR3Qnk2L2tFWW45VVo1WlArNjlV?=
 =?utf-8?B?b0RXSEJaWmdVeXRBdnFDcndhS0x2cyt1ZHhMZWM1dVpBZkUrVHdnWHVWbGJE?=
 =?utf-8?B?UmQ5TkR2dENzQWhQclZjaEpKNmJlR3hvN0VDazFCd0lmTFM1Y05MR3k4ekZ4?=
 =?utf-8?B?ZmRKNW1BbzNvcExCVnFob2toOVY0UVBLNmJEYUkvVjZDMHdxb1Q4RHpZK3hn?=
 =?utf-8?B?RXBIbmVuUnBmeVdrNi9yc1JqNHp5ZHBlakF0dDEvUnppbnVydTU3SktGYk1n?=
 =?utf-8?B?NzhKaDhqb1FGV1hwQ2djNm5QMjhJQzI0blM1d21lNGc5UnBUSVRxcG1hVkFo?=
 =?utf-8?B?eHMxRXNLTGtOMnRhZ0NPY1Vnb2d2bnJwdXlNSXBJVmJnM0wxc2VqZWplS1JU?=
 =?utf-8?B?SXZEZkJrTEVaSmY5MVI1Sk5NV0dOY1dtTWh0YXVXcjRKd0o1SmtNbkNGdzNj?=
 =?utf-8?B?OWJhMWNCcitaQUNZcS9mZEUzb2kzSlFsNzc2SFpULzBlVWJpS3hjUDdEUDBs?=
 =?utf-8?B?eG5SdGY0b2R4bHIwN3RDd2dFN0x6ZmpTWG9ZdkZLbTNQL1cxQ0FWSzNnRWN5?=
 =?utf-8?B?d0srUzdaQ3pDNXVSbTY0MWNBcTROcXZUUkxLdjdxQUVqamUwYlBNNFlIOWNI?=
 =?utf-8?B?RTgxL1JZdjVEVFZFUWZ2M1lqb0xGd1c2REdyM0hmZis4MFlzK3FrWndhSmxi?=
 =?utf-8?B?dzBhbEZjMzdTM2RrbHU1c1JrMUxLWUNDRENnOVcvUG0wUnpzNHN0VTVCeEtR?=
 =?utf-8?B?cXpDK25zdElSMzY4a2NtekNMSVAyeUlmL3lsNVA4YytBUCtDQmJ0RjJyeWMr?=
 =?utf-8?B?RnVXb2ZkZnVtQy9YZ3dURWpRTkhkUkZ2MFdEcUUyMGk3b3pyTEIxcmxSVXBp?=
 =?utf-8?B?SnQ5VjZDY3ZpdEQyVWVOV3ZWUWVwQkNWS1RqQjFBWk9MQXU4TElia2F2U1Z4?=
 =?utf-8?B?NzRlMGx2clphNTljVnVRQjJCTWR1NE1xWmZRbDNEREFRZ2cwaDhQVFVMTC81?=
 =?utf-8?B?L21GelNpcEJSRFdMYXZheWczdEVjTXpnN0JVblpzSWY4TGhtcHdXREpzRUZ0?=
 =?utf-8?B?UGhZWGFaK21sUlNXaGNCOHN6emZHa3EvY3JGWmJZTEFHZU85U2lwcERVQnM0?=
 =?utf-8?B?eWxMYVNWK3lzSXFOUjZwVWVzbXFRR3l4RTZKVlRnTWZsWmlKbytpcGQvYi9I?=
 =?utf-8?B?NEk4elFKZWFDZ2JDcUwvWE1FTFBWNFFXQjNhZ2h3V1BFV1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEt1RlFISEZpNGl4LzZrNThISHFuUDF2dGREcjR6a3pQZkJMajZ5eWdyTWlr?=
 =?utf-8?B?YTdvc25kT0YzcXV5LzA2UGRsT01vaDZZaG11YUZ3eWRtV1VEN0M2Z1BVRFJt?=
 =?utf-8?B?VjhmejBCa0VhSHo0L2N4SjR4UWtPQ0QvVTJGKzA0NjdvblBpVGc5UWVkU1Jp?=
 =?utf-8?B?eTVWd0R2UlFCN3NNYjRJeWI4cnFPNnlvZ0N3VWNkUkxvdlR2Z0w2S2k1b2NZ?=
 =?utf-8?B?YUlYdjFzMWNnVk8vVHAwdXppbFdpemw4NUZoYXo4c0VOTEdMZGxENHQ2Zksv?=
 =?utf-8?B?VE96ZXpsanpBVkxZdjFuMzhBZ1ZkMWpIVitqT0hYVkVsdEJiSlE1YmNXWkZl?=
 =?utf-8?B?alFWRThnV3R5RE1UQ1Vua0g4cmUwL3dTMFFvQXdsQ2pvcGNDYUNTd3N6aWhC?=
 =?utf-8?B?cS9zQXJBL09qcGtDOHZLOGJOMCtlTFVpQjJlRVRPc3h6ZWN3dWQ5WUVlb1Fm?=
 =?utf-8?B?OUg2ZWduS1ZiTnE2RHZQNkxncVg3T29EOHV6VFl1WEhxOG5Lb0svb0RpMW1j?=
 =?utf-8?B?UUVQYW9YRURLY2lRNGIreHdkcnpPb1ZkNmRBbXFxL29CL01wN29KTkk4d3E3?=
 =?utf-8?B?Skkwa2RHM1pXVjAxQ255azlsWWpyMXlyL0ZQVVp0bG9tM2dBdHdFRHRZUkxS?=
 =?utf-8?B?d0F6WkRjRXRsaThna1RsMldjY2M2Sk5DVG9Za0dvSERLa2wrUlFLRlBXSkhk?=
 =?utf-8?B?UXdMeFhUdklNOHhpUkxCOFBiVnIxRFF6Uyt3QVgrMVZDdlovTUs3eS9iUGYx?=
 =?utf-8?B?djJIYWsvVCtEZC9GY3Vab3liOEEzblArMzc3aXNKOG9QODVKZWpnZVdkaWVZ?=
 =?utf-8?B?S3E4cVVCampRK2JXZ3NLUGpTWmoyR1hVaUJEZmVjRW9rRGJwMVhuQkk2Tm5U?=
 =?utf-8?B?ejR5alJHaFNBK254bUw0cldsanZVdXAyRmZYRTVGajBBN2dzemtSRTJGbFhM?=
 =?utf-8?B?TjRLQmE3OWdMM2pYbDY4ZERiQW5RY0hsMFhPUG9TQzFBUzJDNGdmbXpDU2hG?=
 =?utf-8?B?VG5ONEFHWEM2R05Ud2twN3I1bmRoZnliL0tOeHNnbDdLVmFmQ1BtS1BOMUJH?=
 =?utf-8?B?VFRNSjZCeU9JT294RGYrb0xaQUFSSmRhVTN4SEpyLzhsYkIwWFBCb3JBd05C?=
 =?utf-8?B?c2VhM3I1SFNsSmRPNWJ1aW1ibExoUVVVRE5hK0hiL2trTXlQYWJyN2VmbE82?=
 =?utf-8?B?eUJTTFhNZlZ6ZDlpRkxKY1c4TG1LL3UwSkJjSFA5dEcwRnFJS1p2c1VXMTJZ?=
 =?utf-8?B?QjRvaXAzcHY3NmpPY0FKMWtpR0NZQXFyWVoySU5VUUx4QmtLUnlQSVdpSksz?=
 =?utf-8?B?WjhiMnc4UW1UVlgvZktVTHdyOFZkYzYxRGdhanZkVkhWVWI1TEUvZ05sUTY2?=
 =?utf-8?B?d0Q5UlFkeE10N1BnV2k4bXZzMVNRMDJsK3lUb1VDdFZCYkdqb2RzYi9RTHAy?=
 =?utf-8?B?VGEyQkF0SjFVV3ozWkRqcWtyR1Rpa3A5dVp4VzFRUGU5c3p5aUtOMmtmN3VU?=
 =?utf-8?B?Y2hmNTdoSjVJVVQ1bkExZW9zalJLY05DQ1A4UUllUElCRm45RDM0RHRwTFlx?=
 =?utf-8?B?UzFwTi9iaC9WMDBMeWFqM21MbVFMeFUvYU5SZWh2WHBmb2c5Y0V1RkNTdkxQ?=
 =?utf-8?B?SDB1QVZFbXk1djNDdkZlZEFFczRxMHNET3loZXB0aXZKdXZNM1pYTUZ3dC93?=
 =?utf-8?B?L1NlZmkwU1RLK0hqeVIrc0Q2NWdlWVNOMVZZSEl0U1FvdTFkc1Y3Y2lxaWxs?=
 =?utf-8?B?QUJ3Q3JsS2ttMWJxa1E1YXdpR3ZKaWZ0V3lGTlpITld5K2ROb0dCK0hFN0Nt?=
 =?utf-8?B?QnBHM05CS1cxQTNYWWEzczNmc3lRZTRiMWlxcWlJSXltTFpsSCtrdU5haEVz?=
 =?utf-8?B?OFluWHl0UGpqTE41MnUyRlNzendaVjBETys3dDMxRFhxQUtzWndSR3Z2ZGtp?=
 =?utf-8?B?UkwrcGptUE9JdldLOGZSZmx6ZjFHS3dsdHhnYXpJek0rUkZSTWt1OVBrUW1v?=
 =?utf-8?B?aUxoeXVjaWl0VDFIL0U5UkgrMnliQ2dzVEZYZTBUNVJoaGNRQ2RrVHJRc21Y?=
 =?utf-8?B?QU95d3Ava2w2NU5xVnRnM0hsOHJnVzUyMFFIWW9UNG1VMVFEWTBJdUhPS2hB?=
 =?utf-8?B?cXVhYlg1NS9JcTVzR0tyMkt2TGtpY0l5TW80S1RYVTd0NnNqMVk3RGRlU1Vm?=
 =?utf-8?B?Q2syQUh0RTdyZGhxaG5WeGk3b3VnYnlZVUUvbWpqOGlFa0poZkhYMEhOWE1u?=
 =?utf-8?B?N3pCR0dZbXBCY05rQUtsaDZxQTZxdDAzMHFiZ0pUTmoxdHIrS3UzOHo5Zi8w?=
 =?utf-8?B?MXBKQkdBeFhMSGZwWGF0b2JJMHJWSXl3T080SU1FUU5GdzhybFZyY1dtb3Ey?=
 =?utf-8?Q?S//gPKzoIZ2PXStw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6cd1e7-831f-4a88-545f-08de4fbca72a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 20:21:21.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+0NO3Y8V/voJZKvDvk1G95KRcN1xdnDBIywBdO7VJg42PrbmQkTbT4AaescjDWwlIujWV+NyMofJrNZ6DJDj8LOsL4T0wqjgjI7T5yt98w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9509

On 2026-01-09 14:19, Steven Rostedt wrote:
> On Fri, 9 Jan 2026 11:10:16 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> \> >
>>> We also have to consider that migrate disable is *not* cheap at all
>>> compared to preempt disable.
>>
>> Looks like your complaint comes from lack of engagement in kernel
>> development.
> 
> No need to make comments like that. The Linux kernel is an ocean of code.
> It's very hard to keep up on everything that is happening. I knew of work
> being done on migrate_disable but I didn't know what the impacts of that
> work was. Mathieu is still very much involved and engaged in kernel
> development.

Thanks Steven. I guess Alexei missed my recent involvement in other
areas of the kernel.

As Steven pointed out, the kernel is vast, so I cannot keep up with
the progress on every single topic. That being said, I very recently
(about 1 month ago) tried using migrate disable for the RSS tracking
improvements (hierarchical percpu counters), and found that the overhead
of migrate disable was large compared to preempt disable. The generated
assembler is also orders of magnitude larger (on x86-64).

Creating small placeholder functions which just call preempt/migrate
disable and enable for a preempt RT build:

0000000000002a20 <test_preempt_disable>:
     2a20:       f3 0f 1e fa             endbr64
     2a24:       65 ff 05 00 00 00 00    incl   %gs:0x0(%rip)        # 2a2b <test_preempt_disable+0xb>
     2a2b:       e9 00 00 00 00          jmp    2a30 <test_preempt_disable+0x10>

0000000000002a40 <test_preempt_enable>:
     2a40:       f3 0f 1e fa             endbr64
     2a44:       65 ff 0d 00 00 00 00    decl   %gs:0x0(%rip)        # 2a4b <test_preempt_enable+0xb>
     2a4b:       74 05                   je     2a52 <test_preempt_enable+0x12>
     2a4d:       e9 00 00 00 00          jmp    2a52 <test_preempt_enable+0x12>
     2a52:       e8 00 00 00 00          call   2a57 <test_preempt_enable+0x17>
     2a57:       e9 00 00 00 00          jmp    2a5c <test_preempt_enable+0x1c>

0000000000002920 <test_migrate_disable>:
     2920:       f3 0f 1e fa             endbr64
     2924:       65 48 8b 15 00 00 00    mov    %gs:0x0(%rip),%rdx        # 292c <test_migrate_disable+0xc>
     292b:       00
     292c:       0f b7 82 38 07 00 00    movzwl 0x738(%rdx),%eax
     2933:       66 85 c0                test   %ax,%ax
     2936:       74 0f                   je     2947 <test_migrate_disable+0x27>
     2938:       83 c0 01                add    $0x1,%eax
     293b:       66 89 82 38 07 00 00    mov    %ax,0x738(%rdx)
     2942:       e9 00 00 00 00          jmp    2947 <test_migrate_disable+0x27>
     2947:       65 ff 05 00 00 00 00    incl   %gs:0x0(%rip)        # 294e <test_migrate_disable+0x2e>
     294e:       65 48 8b 05 00 00 00    mov    %gs:0x0(%rip),%rax        # 2956 <test_migrate_disable+0x36>
     2955:       00
     2956:       83 80 00 00 00 00 01    addl   $0x1,0x0(%rax)
     295d:       b8 01 00 00 00          mov    $0x1,%eax
     2962:       66 89 82 38 07 00 00    mov    %ax,0x738(%rdx)
     2969:       65 ff 0d 00 00 00 00    decl   %gs:0x0(%rip)        # 2970 <test_migrate_disable+0x50>
     2970:       74 05                   je     2977 <test_migrate_disable+0x57>
     2972:       e9 00 00 00 00          jmp    2977 <test_migrate_disable+0x57>
     2977:       e8 00 00 00 00          call   297c <test_migrate_disable+0x5c>
     297c:       e9 00 00 00 00          jmp    2981 <test_migrate_disable+0x61>

00000000000029a0 <test_migrate_enable>:
     29a0:       f3 0f 1e fa             endbr64
     29a4:       65 48 8b 15 00 00 00    mov    %gs:0x0(%rip),%rdx        # 29ac <test_migrate_enable+0xc>
     29ab:       00
     29ac:       0f b7 82 38 07 00 00    movzwl 0x738(%rdx),%eax
     29b3:       66 85 c0                test   %ax,%ax
     29b6:       74 0f                   je     29c7 <test_migrate_enable+0x27>
     29b8:       83 c0 01                add    $0x1,%eax
     29bb:       66 89 82 38 07 00 00    mov    %ax,0x738(%rdx)
     29c2:       e9 00 00 00 00          jmp    29c7 <test_migrate_enable+0x27>
     29c7:       65 ff 05 00 00 00 00    incl   %gs:0x0(%rip)        # 29ce <test_migrate_enable+0x2e>
     29ce:       65 48 8b 05 00 00 00    mov    %gs:0x0(%rip),%rax        # 29d6 <test_migrate_enable+0x36>
     29d5:       00
     29d6:       83 80 00 00 00 00 01    addl   $0x1,0x0(%rax)
     29dd:       b8 01 00 00 00          mov    $0x1,%eax
     29e2:       66 89 82 38 07 00 00    mov    %ax,0x738(%rdx)
     29e9:       65 ff 0d 00 00 00 00    decl   %gs:0x0(%rip)        # 29f0 <test_migrate_enable+0x50>
     29f0:       74 05                   je     29f7 <test_migrate_enable+0x57>
     29f2:       e9 00 00 00 00          jmp    29f7 <test_migrate_enable+0x57>
     29f7:       e8 00 00 00 00          call   29fc <test_migrate_enable+0x5c>
     29fc:       e9 00 00 00 00          jmp    2a01 <test_migrate_enable+0x61>

> 
>> migrate_disable _was_ not cheap.
>> Try to benchmark it now.
>> It's inlined. It's a fraction of extra overhead on top of preempt_disable.
> 
> It would be good to have a benchmark of the two. What about fast_srcu? Is
> that fast enough to replace the preempt_disable()? If so, then could we
> just make this the same for both RT and !RT?

I've modified kernel/rcu/refscale.c to compare those:

AMD EPYC 9654 96-Core Processor, kernel baseline: v6.18.1
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_LAZY is not set
# CONFIG_PREEMPT_RT is not set

* preempt disable/enable pair:                                     1.1 ns
* srcu-fast lock/unlock:                                           1.5 ns

CONFIG_RCU_REF_SCALE_TEST=y
* migrate disable/enable pair:                                     3.0 ns
* calls to migrate disable/enable pair within noinline functions: 17.0 ns

CONFIG_RCU_REF_SCALE_TEST=m
* migrate disable/enable pair:                                    22.0 ns

When I attempted using migrate disable, I configured refscale as
a module, which gave me the appalling 22 ns overhead. It looks like
the implementation of migrate disable/enable now differs depending on
whether it's used from the core kernel or from a module. That's rather
unexpected.

It seems to be done on purpose though (INSTANTIATE_EXPORTED_MIGRATE_DISABLE)
to work around the fact that it is not possible to export the runqueues
variable.

That's the kind of compilation context dependent overhead variability I'd
rather avoid in the implementation of the tracepoint instrumentation API.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

