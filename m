Return-Path: <bpf+bounces-62796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FABAFEAC8
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 15:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B77C1C811E3
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 13:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5D2E5417;
	Wed,  9 Jul 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rk7Y1ecQ"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2126.outbound.protection.outlook.com [40.107.115.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F22D59E4;
	Wed,  9 Jul 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069078; cv=fail; b=U7o50GKVsG78GQvaE6FxibXeeRQJbMLDxot2nUeQP4DWD1JpRKv41OarfqFAAbeWuvhDMmfF3rxMswylnXYeT5DiQxRIWLAu6YzPa+5cW3Q/jRbz9yO9xYp4nWxfp+VhO7BdTzAtUaJ3fOqzBi8EkS+Hfw8uLYixfga/QFtnUN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069078; c=relaxed/simple;
	bh=ELgG3Mwqm7QoeF3cHhlgbYfpyAW2QI95qkenccQ6E+g=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m0vVPggjil9ezCyVaHENQwkvANN24MdI2ykAKCGTbfT819A2DOUdeTAz+iVkj6gG+NQCZhIPCyDsoobFqWkYulODGXExa/0gPxpiB/E3tePLLvvW+3bK36ycc3ae1Ff6sX+ZXrCYXNGFql9kG0wqCq/q7FnpM9BRWpgYdwT4E1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rk7Y1ecQ; arc=fail smtp.client-ip=40.107.115.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBkHdEEQ7ZpIYeDUFs7toXOm7QNQiookLPWE3YqMZA+6dtOKP/Bm7aHUbmkQFYZUaPRfEwsvgeqDqV+jQh2Ji1LiAjbbElPv07wRRUY1aloDJX2d9IK/gz7ydFjlbDkfr1p4VRgPZHW6Zt/coEexcOSacewuuDr2dm6no2TJO8twXe1SD5fHGZH2/eYWP4guH9HKzbnE8oUeRxHhh3O9cmSh65Ra4Uz3/j8UfpIRbBZpQ84NLIBSxqPNjLLw3FDVrHssa2gJErtkwwd4Azdj/AXi07jT5SkGRBR7poaYLAc94roMJ2ToB31VKxo9iNhA5WMjoobWte1Wx4beZItFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjlq6jlXaZFFMCTIQymdPLAiy+xVmHbf+mBkule+tOs=;
 b=M9MZ8BB9rpCZmzGe/Ho1pXd7cDzFRlDofS30MtIsU50b9phGFNv32Rn3cyvsH1ysnl8LcwXJBd0PeXzpD5hugQEsLFbY+2NVcVfyQsLREOKi/Po7wJxU/Q3m76M43zHcFMN37vNeuLMrD357yPEkLtQk5vJMQQIoLmqQk4iplXpVDPd154/UGlLw6L24s3AHrTO+/afDuOg9A0exvjfVY5QuGrnSom9auGonAV48uewZg+qPJtqBPE5IP113BniD90fprCemXrTlHjcT6U7xi3yFNT9g9PsWS9aOfa0NhT8FN02lOa3clF8oQZ5tNjzb+l1B2Yswx2I3pzIxPzSivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjlq6jlXaZFFMCTIQymdPLAiy+xVmHbf+mBkule+tOs=;
 b=rk7Y1ecQbuVOSGTfRCWGKEptnwkZENjlKwcz5mPP/mcJsr6IIVnqEtKX21AFTtl0xY10qGQou1APYb51isMcMO00cNIrAkMVGZGi3S6KPo3LzQUej5MvB3gnFUskwNoOfZHVT95Wr1ceoKybxZdalHQ3nLd9qy+3BSTN2cJu7qEDjUuaTy5ecdG5PMvkeHUB2LxPVPT8BXhD6oz0G3wk5rJ+yV23brA0KiywrAa+mYC3bR80ib9Cq84JdN3sSWBcxlj9UzcMiX3LdRmOyp5etgcHQhePDaUlkZpPWCpsAQwo8TCFN+X4/S10X+XbYwgH+3ExPAFpD8jWa5lB79lJVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10536.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 13:51:11 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 13:51:11 +0000
Message-ID: <7250b957-2139-4c03-9566-a6ed9713584e@efficios.com>
Date: Wed, 9 Jul 2025 09:51:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] unwind_user/sframe: Wire up unwind_user to
 sframe
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 <39cf3aab-7073-443b-8876-9de65f4c315e@efficios.com>
Content-Language: en-US
In-Reply-To: <39cf3aab-7073-443b-8876-9de65f4c315e@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10536:EE_
X-MS-Office365-Filtering-Correlation-Id: efa49b0e-d5c3-473f-8117-08ddbeefa9db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ujk4bUtrWmJSNVJra2VPdThmcU1UOXFoWFJGNnhhZzFlOUsxY3lWdGlraDMr?=
 =?utf-8?B?ckVxVXAvUld5V0ZpZForTXVQM21QTVJ6L2pYNnVUNnlNYVd6azlLY3hpTTF2?=
 =?utf-8?B?MjA1MlFZRGhyQzRWMlZNR2NlL3lJWGtCeDFtSVVtTnV6c0ZFdzdLTW9QMDJM?=
 =?utf-8?B?ZXBZZ2lqQ3dmbWFYMlFlaXBQQlc3VmxWaUVOelRRVkNLYzRvVVJ6OVdKVTJM?=
 =?utf-8?B?NTE5MGZjMHZSWW9GdVIrZXA4Q25VbU9HeFFzTW5HSEJrRExMMDM0U05QT3hP?=
 =?utf-8?B?RnNoclFyQytrUWZxT3hlUnp1RGVXMTFSWWpWczc4cW9IUEFXN0FveXAwMnRu?=
 =?utf-8?B?VTdpdnBZZnJqOW5lTGYvUkppQWRnUnZwZWVOUlBPUjl3WkI3dTNDdW9nYzEv?=
 =?utf-8?B?RWhuYnBJbzl6YXNtODUzVVdmaVRCN0xZYkVUTmdoQWsyeWJiaUE0MVV6SnMr?=
 =?utf-8?B?SVMxQUphL3VVYlNWWFpCSFZVQ1lJL2N1V2lldHBNamJDcFdWaHlRUFhCejFS?=
 =?utf-8?B?Mm9mYmhObUx6UVdjTitpT2RyVUdQdTdNZnFRaGNVSzA0MjUxK2JaVHRMV1Va?=
 =?utf-8?B?TmpjQXdxd25nNHdkTjh6YXlzYnVRNFUzRVMxRUtIRHFWb214cWVUK0d2RWQ3?=
 =?utf-8?B?NVlVbUhTdzczQlVQTU1sQ1g1UExtOTRoM1htaVU5NDlUVFRJVDlyT3BJcWcz?=
 =?utf-8?B?bi96Q3g4Y0dpVFZnN0pTdWJDcy92SWZhVmp4cUgvMThmTTFVMSthZUcxblpa?=
 =?utf-8?B?WVgzZDAwSUE3aXVlOGpRK1hMZWxUZ3VOblNqZ0R5Y3lYR3k2VlUrTENkRm9a?=
 =?utf-8?B?eW1BSEk2YUZuS3VtTEFRMFFxUWFoZ0ZwTzZ4YjltekRMTHhqYVBBd1NGQjRs?=
 =?utf-8?B?ak9sdUN2cUQ3YUVwdHd3NWdJakdrZHo3dFVsT3NTNGlhd21VR2hZd0l0YzdK?=
 =?utf-8?B?Rkhrck5JUVcxV01BK1hlVTVvVml3cVZTSXBRL2M5U1FLZW1RQTVURVljQk9F?=
 =?utf-8?B?cVMybUxjS0VtY0lhZzRMaTFoK2RnSitkRXdRMktHMFNvb09LTHNFdUJBT0pK?=
 =?utf-8?B?Z1ZRTDJPeVBwVUpJNjVKekNRYmFGdkZhMk1DT2N2RHF3Uy9INGpEdkp6U1ds?=
 =?utf-8?B?SHkwOTJoaUhwak9vUHk2ZmIvbHNMNzNBU0hYMzZXNnlqbWx4UEVJY091bDIr?=
 =?utf-8?B?dFpUeTQ5OGQrTmQrRHBYYy9IZi9BSlVhTGZvNXZLaDFROTJJYUVzN2lOV0lQ?=
 =?utf-8?B?VDcvb2tpWGdkVGQxK0t4Y2s0NUtoemlkOGRaVWdrRUFiN1hqNFNic3RCcWpD?=
 =?utf-8?B?RkN6dG83dzU1Wm1MSk1sUUVZekRIR3Z4dGI0S1VSZzZPaVV4UVZzRUc3elpB?=
 =?utf-8?B?eGNWQko3L0RUTXBxaktmbUxDZnRpZ1N2ejFLSjZUb0xnMnA1dC9abmgrTDhZ?=
 =?utf-8?B?Smd6ZHJ2cElHc1FHWFNOcW4rbjN1ald2UTlvUVNFS09ETlVtUXFMdk1OdWRE?=
 =?utf-8?B?T1VOQmJMZS9sNWNUeEgzaWVSWm56V2k1VUN6NWcvRGwvL2hJeld3OW1Dd1dB?=
 =?utf-8?B?Qk15Z1hieTZMYzVsQ2JlQ1NaRTJMVEtaNnlzZXZwWmw4VG81WXZ5NVVCU1ly?=
 =?utf-8?B?dkJ2NThnUkdLYkUvSU9VS0hIUUp0VU50WmVkSnZNUFZKYTNBZThBdjY3cXZ2?=
 =?utf-8?B?RkRrVWlTeTdYSmVKdllySnBzM09rRDFha01FNGRuRnQwSWc3RFdjVVhBMVRJ?=
 =?utf-8?B?eE1vdThwNTArS1NsNEorMUdnY1kvUDI0dS9ubmx2eUZCWHlRNUF5NXNETEZG?=
 =?utf-8?Q?wDQvmueR9ykpi3+vOr4fPGQAiA25UVNwPBmaA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0FzTWMzUnc1dk5UYzAwM3h5YzU3dXJuMGFVbWNpRU9yMURWN3RnNTUxTHFW?=
 =?utf-8?B?dVI1SGVGb0ZOK0EyRU00bWF1WUQyQS9kMVREWGV6KzlqaWcxZUh1TGV4OWNz?=
 =?utf-8?B?dFpwL0ZjTHZ5ZWQ4dGZsWncxN25ZTEZjYzN4eE5vRmZwN3l1eHExNkVTd1R5?=
 =?utf-8?B?TjNlcWNZbnBzeThqZFlGYjRxVzRaVW1HNjlPc05wM0VSY3JOUXV3NTZRbUNy?=
 =?utf-8?B?Rkp0RTRQMG9UZlpjajVtaHdaWUFEMnhIS25MaDUveWtwdFkwRnl1RGc0TEda?=
 =?utf-8?B?cVZobjB6RXovL2pRamI5NlBSbFBJRDJJSkcvSTFod0hTRjE2aFVxb0RFYVBy?=
 =?utf-8?B?cVN4WGs5M3FJa2x4dmk4VWdGZFJoSE9LUXRBekJaaHBHOXpJOEV0NE1YN0hh?=
 =?utf-8?B?ZzJIVHlSN3k1ZVVhcUlsS3gxNWNyS1VZMXhiQjFma29IVDZIQWFLOHQ3OVJa?=
 =?utf-8?B?OFM4bkczUGNJQU15Ny9yY2JCa0l4VWcrdW9uamxuWExQanNCOFEvZlRIT01w?=
 =?utf-8?B?NGhucE5PN2RuNGpUWGlCK0NOY3ZJVFJqNVlQazRFOEFoQnJzMlFrSWc4cEZj?=
 =?utf-8?B?Z1ByWGF4OFZkN0NkN2drZ2ZLYXlOS2ROeFRuYXJCUm9UN3Btb2ROQWdlbmpT?=
 =?utf-8?B?QXM5UWt6UDZGb1VCek03ek9pL0FIZGtKeHA3MEJxWWtQUkZwVDJHL0N1bDdN?=
 =?utf-8?B?OXROQys5elJjRUREdEVaQ2h0LzlQb0haaHY2bGk3aUp6YjZERU9vMGYzSDRv?=
 =?utf-8?B?Ym5LTEV6OFFpQW03TUdrTWhOMXA0TmZRL0xXZnc5SENaWFM5UytTcDFiZTRW?=
 =?utf-8?B?QTRGZkxjK2t5T2MrYVd6SHdYa0toVGNhaTRjcjhpaGZ2VjBKN1lVZzFneVl5?=
 =?utf-8?B?cSsxaXhPblBqcGQ2bXVRTXllYmttMGRjRnc0YnVNSm41SUtHOXpKemZYUlY3?=
 =?utf-8?B?WHd1eEd5WVRwYUNQMVBDN2RNQXFVSE9aZEpoaVdvVlA0dXBDcFNuRndsSzY3?=
 =?utf-8?B?b2pWbWZzR3lrMlpoUkpMNTlMWjhmWGM2Zjc2VjBUbzgreXZTSVQzYS8zQnRC?=
 =?utf-8?B?WXZ6VmM5YUUvUzZqeDB1TEJUL3NwdmJjMFBDUTZYRUFSZ21MYlFlQkJtYjQ2?=
 =?utf-8?B?OTNpY3hVeHVwQWRwNnI3cE1QVit0NnEvQXBhQlhGN2lMOFZXSXlCbk94RFBR?=
 =?utf-8?B?T3dnZ3hyUkR5dmgrR2s5V3V3TjdFL0U1VjBDMjY4UDV5THFvbEY0UEpYSTcx?=
 =?utf-8?B?bWhMZU9qb0QvMkhtdTVSMSt5dnBGWjk2WUE3Y0hpVkRIWEYrRVRQaXdUaW5t?=
 =?utf-8?B?RFNWcGpMUlFSUWhpMlhxT29MeFNaM2dpeFJtUkJ5SFArdlUrK0pvRlBvZ0Vh?=
 =?utf-8?B?OU9iMGRXTlVtT1RId1JycVhCRXhwemJybG9EMnFsbS9FNlZhZVNpWFJEZ0Vt?=
 =?utf-8?B?VDFhSjdQL1RuN0tRZmh0SnFjdk9xb295M0lXTVM3V1NGR2xub1lBMzFGZWxE?=
 =?utf-8?B?dU55dnBEUGpLempsR0ZYVFhOWFRNU0pUcmJibWxzMG52MG5oeWVVbFk3MUNG?=
 =?utf-8?B?RTF4SkovcmVJUm1NKys3dzM0L1hubkY3c3NFMW9BdnZQY205dEJ6eHpSQjd0?=
 =?utf-8?B?L21Eb1lMbVp2T25sV2lTNVlBQ050ZDFiL0QzbElDL1N4bTN0bnZyWEE1QmM2?=
 =?utf-8?B?Vk1UV3dBeTZhcjcxL1J3aTN6Q1NiZ0VIam5kdXlFV0xFTlFvMUVHdGVVNzJO?=
 =?utf-8?B?V0lZejh2c2x6aGJHcGhSMjkyTUgxUXZTOTVWUFR3MjRsUGUvU1NoU2RjTEVO?=
 =?utf-8?B?SkVpZDkxYklaYWNkTTlLVFhnNW91TmhjUU1FMHMxM3A0a0t3UEE1MFMyUVBY?=
 =?utf-8?B?RUV2WkE2cGxIL1hlMGxld1dkWmh2Qk9odzlab2QzdnJyODdaM0VQeHJxVXZx?=
 =?utf-8?B?OE0zQVZ5Vmhuem1zSUZsb1NqQzZ5QUhHMnBwbVMvTi9UVlh0eWIyR1BFRW9y?=
 =?utf-8?B?dFFwc2JKUlZUTGoyWlBZTitDTGFtaXRzRkhPVy9tYzBMdU9rcENOa0tVYmpn?=
 =?utf-8?B?Wk1lamFQR01LbzZaNUd4VEJxYlRqaVI4NU5VcGZYMi8zeXk1VEFPSFV0Z0hQ?=
 =?utf-8?B?RTVURnFHdzJmNmJaMWtLWFhuZDBFekg4TitJbEREbkdYblVScXJRaU4vcDBm?=
 =?utf-8?Q?ZhfEVdAEH66nnweN/iH7+5Q=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa49b0e-d5c3-473f-8117-08ddbeefa9db
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:51:11.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OZ4wNZ2oHDCR9XMO2OgUGS3pAqGspReH0TJqoFpHJ8CYGhqLbFsghVAKMSDVVY8RxdS5ECKKgbmlQ7afP1B1jo4Wd0aKXycYr0hX8DMIRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10536

On 2025-07-09 09:46, Mathieu Desnoyers wrote:
> On 2025-07-09 03:58, Jens Remus wrote:
>> On 08.07.2025 22:11, Steven Rostedt wrote:
>>> On Tue, 8 Jul 2025 15:58:56 -0400
>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>
>>>>> @@ -111,6 +128,8 @@ static int unwind_user_start(struct 
>>>>> unwind_user_state *state)
>>>>>        if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && 
>>>>> in_compat_mode(regs))
>>>>>            state->type = UNWIND_USER_TYPE_COMPAT_FP;
>>>>> +    else if (current_has_sframe())
>>>>> +        state->type = UNWIND_USER_TYPE_SFRAME;
>>>>
>>>> I think you'll want to update the state->type during the
>>>> traversal (in next()), because depending on whether
>>>> sframe is available for a given memory area of code
>>>> or not, the next() function can use either frame pointers
>>>> or sframe during the same traversal. It would be good
>>>> to know which is used after each specific call to next().
>>>
>>>  From my understanding this sets up what is available for the task at 
>>> the
>>> beginning.
>>>
>>> So once we say "this task has sframes" it will try to use it every 
>>> time. In
>>> next we have:
>>>
>>>     if (compat_fp_state(state)) {
>>>         frame = &compat_fp_frame;
>>>     } else if (sframe_state(state)) {
>>>         /* sframe expects the frame to be local storage */
>>>         frame = &_frame;
>>>         if (sframe_find(state->ip, frame)) {
>>>             if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
>>>                 goto done;
>>>             frame = &fp_frame;
>>>         }
>>>     } else if (fp_state(state)) {
>>>         frame = &fp_frame;
>>>     } else {
>>>         goto done;
>>>     }
>>>
>>> Where if sframe_find() fails and we switch over to frame pointers, if 
>>> frame
>>> pointers works, we can continue. But the next iteration, where the frame
>>> pointer finds the previous ip, that ip may be in the sframe section 
>>> again.
>>>
>>> I've seen this work with my trace_printk()s. A function from code 
>>> that is
>>> running sframes calls into a library function that has frame 
>>> pointers. The
>>> walk walks through the frame pointers in the library, and when it 
>>> hits the
>>> code that has sframes, it starts using that again.
>>
>> I think Mathieu has a point, as unwind_user_next() calls the optional
>> architecture-specific arch_unwind_user_next() at the end.  The x86
>> implementation does state->type specific processing (for
>> UNWIND_USER_TYPE_COMPAT_FP).
>>
>>> If we switched the state to just FP, it will never try to use sframes.
>>>
>>> So this state is more about "what does this task have" than what was 
>>> used
>>> per iteration.
>>
>> While there is currently no fallback to UNWIND_USER_TYPE_COMPAT_FP that
>> would strictly require this, it could be useful to have both information.
>>
>> Or the logic in unwind_user_start(), unwind_user_next(), and *_state()
>> may need to be adjusted so that state->type reflects the currently used
>> method, which unwind_user_next() determines and sets anew for every step.
> 
> I concur with Jens. I think we should keep track of both:
> 
> 1) available unwind methods,
> 
> 2) unwind method used for the current frame.
> 
> E.g.:
> 
> /*
>   * unwind types, listed in priority order: lower numbers are
>   * attempted first if available.
>   */
> enum unwind_user_type_bits {
>          UNWIND_USER_TYPE_SFRAME_BIT = 0,
>          UNWIND_USER_TYPE_FP_BIT = 1,
>          UNWIND_USER_TYPE_COMPAT_FP_BIT = 2,
> 
>      _NR_UNWIND_USER_TYPE_BITS,
> };
> 
> enum unwind_user_type {
>          UNWIND_USER_TYPE_NONE = 0,
>          UNWIND_USER_TYPE_SFRAME = (1U << UNWIND_USER_TYPE_SFRAME_BIT),
>          UNWIND_USER_TYPE_FP = (1U << UNWIND_USER_TYPE_FP_BIT),
>          UNWIND_USER_TYPE_COMPAT_FP = (1U <<  
> UNWIND_USER_TYPE_COMPAT_FP_BIT),
> };
> 
> And have the following fields in struct unwind_user_state:
> 
> /* Unwind time used for the most recent unwind traversal iteration. */
> enum unwind_user_type current_type;
> 
> /* Unwind types available in the current context. Bitmask of enum 
> unwind_user_type. */
> unsigned int available_types;
> 
> So as we end up adding stuff like registered JIT unwind info, we will
> want to expand the "available types". And it makes sense to both keep
> track of all available types (as a way to quickly know which mechanisms
> we need to query for the current task) *and* to let the caller know
> which unwind type was used for the current frame.
> 
> And AFAIU we'd be inserting a "jit unwind info" type between SFRAME and 
> FP in
> the future, because the jit unwind info would be more reliable than FP. 
> This
> would require that we bump the number for FP and COMPAT_FP, but that would
> be OK because this is not ABI.
> 
> Thoughts ?

One use-case for giving the "current_type" to iteration callers is to
let end users know whether they should trust the frame info. If it
comes from sframe, then it should be pretty solid. However, if it comes
from frame pointers used as a fallback on a system that omits frame
pointers, the user should consider the resulting data with a high level
of skepticism.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
>>
>> Regards,
>> Jens
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

