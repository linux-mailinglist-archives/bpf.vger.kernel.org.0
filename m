Return-Path: <bpf+bounces-62185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66621AF627B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C0B4A7CD8
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84122BE624;
	Wed,  2 Jul 2025 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="raKGYmru"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2124.outbound.protection.outlook.com [40.107.116.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884B1E489;
	Wed,  2 Jul 2025 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751483572; cv=fail; b=BjDHUgik7FEKVC7XRRYuqa7ZMpbOjflRKM/XLebh96fQ0hw8lw0siThRz+0pzfihY2rfTMah7ztaxpemxEO4c9aEKRs8YDKMS71r03C73fncLrQ6dqkzH2ofVy6+bU5eX59xeMviYHOLLZ/lng3xx16kgc6+rqKc98cGy9ofWrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751483572; c=relaxed/simple;
	bh=81To0TSfiE/hXd6tneSBXvu3YcBb5Y3JY6QF7a8GANQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hZ0WxzPgSTQVtmHQj99pGq+buPQPeBhXS5wkzn0gXoJA2WJS0j9izuicyENEgws726nKv2PWajhFs00ansUQAz7rf/IBWbzlmRpZ646a5lls3+SXhzGl1yONjIVI1qhHAudSUScA14tHkUOdIApZyFQsk11Tz7xPpZG2ZbyKsQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=raKGYmru; arc=fail smtp.client-ip=40.107.116.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWMFsq0BKfq1R68Xjs+fBWexYMDhb/g6ektFHIYUElwoAvkst0bIZ0GCDyBME8Zc1WPq/zsRMYIA/MyDMIyLUBVBg5ygnY2CNp0JK+K8xhdQ8uUXL97qSj3oiLY8F0De93cXAoJhAqR+Zn3uMpGkswFELOdumem/Z6hZc3+PpkoTc/anpKhKq/VWGvwLVmNB4LafaZFTHGCMaNPOzd2LVRsACOpq0U0gkMsI07c8bBvNFOlP5V5v4556keRJxcCJdyAlQh7d1kKXOQOPqhuvfcTPNvLaY+1KRVqL51SGozWlzRStD1m0Yd/oDCOkbQf65GqN1u8eGkZupeBB0bz5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaTsPBdk7Zzb+eikuQj3qRWinhQZ4VlS+2e2uJXAhZM=;
 b=Cp2eXJDyvxNCqTV0LUTmKD7Ce2NPEJc/9vwlwyr/ZdjWzDxoY8w8q6ElWYaRE5NH6cF5RtPzk4HQIWK8GMvvbxHbKUy7FNf3V64Tx07C+uTkfZKFX/GyVWwmKRtWC3nN5l1vfJdfinHsO+iMOtW6dX/drbByl0FpW76NEFybu6bXcNVmWszz1ChmsYAmjIx2wEomsVshPD1sYgpkQT7NxE23M90cdhmpSVrkwHallM4WCJ2Qx38IqxND6ZLxI67ErSsbgkjFcw0pydlcqsXfwpnFDMKOwBxSVzE6Ajek80R8TPahRtI4Tc3L8V9Vy/r5ta+EqQnqqfGNXwnwFaFRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaTsPBdk7Zzb+eikuQj3qRWinhQZ4VlS+2e2uJXAhZM=;
 b=raKGYmrumrh/AQIsNAmzvEt1DZEpGpGye3vSL3LaFmtgMLJND6tp4AMhvt6huTtgyxnlOsmldj8fpP1t/Lx3VHk0F9RzWOFlLpQJEd1+2xyIP6aEqjkpqwAgES0Snne+bBVcd8n5N7wAHSpTzkozhnzseF0usTG9mfT4RWaVQ6ow60tXK77ycsQfEpGcw6dWkH6kQw+kmkSSgHFId0Vc4MNL207ajxEJLoSSDdjcmxuuU7hE1hR3/MEHEThH9OS7frykQc4tR1mnopY2Vp3gwNJ3p3/kD2SlyhPjO9NvzRSfiC6CJfF161mgCeIIZdMpf6V5Iejud/sWjHnh+/zcew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB11336.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 2 Jul
 2025 19:12:47 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.021; Wed, 2 Jul 2025
 19:12:46 +0000
Message-ID: <47a43d27-7eac-4f88-a783-afdd3a97bb11@efficios.com>
Date: Wed, 2 Jul 2025 15:12:45 -0400
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250702150535.7d2596df@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB11336:EE_
X-MS-Office365-Filtering-Correlation-Id: f614eb56-85d2-4deb-111e-08ddb99c6e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0t2K2lsTWU4dUU0OE1EbU0xc0VIUGJ0cVFMS2xJbGU0WHIxQTNJUEYzN0cx?=
 =?utf-8?B?QStvVDFmUjJuVEI4UCt2aDZCVU5HcmhPUzBVUGJ2UVhJVzlkWkMvK0FYdkVa?=
 =?utf-8?B?OVhjMGJIYnV1WUhoOG9pUmpwcU5ROHY0R1QzdC9wUVVCcTAzOHRWOE5GcU1L?=
 =?utf-8?B?azRTUHgwS0V0MTIxbkE3NmR0TTNTc0hnZlluQ3piQ25RaWJxYThLRUtwcUE4?=
 =?utf-8?B?L0RaMXg5WE1aS3NGQ2JYQ2tYMVNBTk5rYjViWlNTdFBXdVZmdGZhWXVXMFU1?=
 =?utf-8?B?TnRGVmNOMkFISnRESDRoc3NTNW5xSVhzWFhGaVNic1V0emRsQnYrcmN3TkRE?=
 =?utf-8?B?Y0U5a3o2Y25GcU1PaTFnNFZSUTlsNVVwQ094bEJqYkFWMHZqdk1TRjlUMTdD?=
 =?utf-8?B?bmVtVDFFajRsY3U4QTFpRmxGOTZGcWFhWnJpVXZyOGswRzZaNWtjUTdUSVI3?=
 =?utf-8?B?c3MvQmt6M3hCbU5zK0YyUHMyV1J1RW9RTU9TK2lyZDF2TFlwZjY4ZEgvdVFB?=
 =?utf-8?B?b0M5dk1VS2tHUmcyajJOQUF5d0lKcENaRkM5QVpacjJzbmUxekV5Vm9VMDJX?=
 =?utf-8?B?OGFxTVVvT2VWRlJSd29pN2JRVjlTZ0dLOUsrYTVNUkJYRC80M3JjUlJSekZC?=
 =?utf-8?B?M3pLVmJnZnAzaWgzeFRuM1hSZmNPNlBhN1BWeTJkN3dSekgxTkU3QjlJYU9l?=
 =?utf-8?B?dFlNbkhKaWdxSjMzTXg4MFdka2QybkwzR1FTVUJHNCtVaXdjQUF3bU1oazVF?=
 =?utf-8?B?QUthWG45YnNWKy90Rjcyb29VMGdTa2NSbmc4d1FUaW92M1NZRzVEOWswS2Zx?=
 =?utf-8?B?N2xrRWpkRnJTdnUzcW1GNVhzSC9OK2I4bEFRQjBzakhEQjJIVzY3YmtXcElJ?=
 =?utf-8?B?YWFZTUNtUWQxbGRoZHRoY243b0VBZ3hrRFpzcmwwVzRzb1E4YVZsZjR5UElC?=
 =?utf-8?B?ekVkdWxBYW9ZSDZSNGNNMGhDcG4yNVZSU3ArS05vOHJIWW90bFNTOFJCeFFa?=
 =?utf-8?B?WjhGVnhkaTR1VTlYOVZKNm9FNUgvSXR0VDNoblNpbU5FNUFrQmMzQWlSaFJQ?=
 =?utf-8?B?K2RuTDNjcE83d1JpRjJFN3ZDUmxoakRlcGFUNXpJUmxxWVM3MU1OU0IxTlN2?=
 =?utf-8?B?dzQwdnBTRHV1SkhnRm1SRzBsNXJIUEJhK1NueXlEcENBTnROQjZCNEx3bzF1?=
 =?utf-8?B?WmRNU2ZkQXdwU0QraW54bWloaWlRdHYzMjNsdnZNNU1tZ1RwQUhHWi90TjdX?=
 =?utf-8?B?L3NreTdEdjdIeG00NmdzMFQ2T1VuN2hLTUVGZXJYOXU5WUNMVGhmcUV2TnQz?=
 =?utf-8?B?a2lucE9QWXRvQWJDMCszQ1k4WmhYL1dKbkdzMlpHWkRsMmpHWTJkblorRlYx?=
 =?utf-8?B?Q2tFbTl4ZFo2QXJCdGs2NXlVZnd1bEhyN3Q4ZHVMcGJ0S0RrTUx1Z1ZaTHl3?=
 =?utf-8?B?MTB6d25KbTUrUU1qYW5nQ1dTVEZFcEZUZTZydzFWQmZ0VUo3OUwvRm1sN3dR?=
 =?utf-8?B?cFUvandCNEhNVWgyTm16TlpQcWRNaEc2MDZHdnBrai9QRkV3SHQyZWZDN2hW?=
 =?utf-8?B?dWNjTHZ4NTdWSHBIZU9jYXVQRENoZ0tGY01qV1dsTDg3QVhqMlNtMGNiNlNZ?=
 =?utf-8?B?cXVoRzM1YTRCcXhRV0RKY1NYQS9qd1ZvUk5rWm0yNnlMeVBpSkVFcklNbEpH?=
 =?utf-8?B?K2VQTVB1Y3N2cUVDTmowcnJZdnRQQnJXRmdwbUcwM3FOQkV4WTBuOTM0VnVl?=
 =?utf-8?B?d1dSZE51SjNjeWs2RXVOOWQ0VUE3QnNiNml0VS9IbXVRTUdDYXBodk1POEJ1?=
 =?utf-8?Q?qUYaAbFu4eR4cLYNBBqUf3T7BR0AusCYHLDk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2cvT3A2WFoyNVF3dy9BQmdkOHV0a3VDb2FoQlphSkpLSnc3K2tKeERtNDBl?=
 =?utf-8?B?UEN6RGppbGlYcjJKRTcrN1F6OVloQjcwd0xOaWtNNFo0UStWV05YcUYwbi9W?=
 =?utf-8?B?cVB6dUVPYlY3aFhacnRmTjVsbXRUaXdpdzZKd2lzRGxvQithQ3FKbTc5Nk5U?=
 =?utf-8?B?N0RsMzFJUjg5cWNoMHI4WndLUlVGaHpvKzEwQ3F3K0dWYWdZaG1wRitSUGFu?=
 =?utf-8?B?Mm5sdFRTRjhDWlNtTy9SbHVXanl4M3JVMzZja2U1QnhRRCtoRHExZE9RNkVm?=
 =?utf-8?B?czl6WjYwQ1ZjVUMrcGlUcmVlSWoyRWVRbzR6K0t6RjdDdkhjM3dkaVJvbS9Q?=
 =?utf-8?B?Yk8wTno4ZWphRmRPMlNTaHBvWkZuOHZMSENQVHdlb1NSWjcrK0hQMEhtT0lQ?=
 =?utf-8?B?dHptcGRkYU40ZGhQcW1hUmRBTGxZbXE5SW1va1dvcDFOQ1JnNW9saTlzMnRY?=
 =?utf-8?B?Ry80VDRJaTV6U3czN1Z3M1RhT1kxbi9pUFZ4cXRtbXdsb3ZOUVcvNWxma3E3?=
 =?utf-8?B?Z1NOOUV3VDU3NUMzOVRqRzl3YjJVb3ZHaHhCaE9nMHZlREthbm9GeFlXd2Zm?=
 =?utf-8?B?QngyZUdYdlhxcHZncFVNckJQYlIzR01ZbjlFUTlzQnhCS0pLUHFtTDNYS1o0?=
 =?utf-8?B?bWFXMDNvZWhWTUtuTVdWRHVBck5NTmFweEZKVjFNSTd2THlVNkI0OWdFTHJS?=
 =?utf-8?B?Y2t2SnphdFNMOHZJcTJvdi9JYzZsS1JIWGwxTjY2VFhRR0ZZRTZlWjIyU3VC?=
 =?utf-8?B?QmhPVUF5aXMyRy9IMzdVQVFCMVNGdy9ZeWRwbHQrQVcxT1NXK25HcitpQjZD?=
 =?utf-8?B?VjdQbzRtQS94TlJZUHkxbkczT2VxQjQrQnhjSjBDZFNFTFp0Z2IrYmd5YUxN?=
 =?utf-8?B?eGRYK2J1L1VyUEJ3R01xVFlOS3pYanhPOTdQNGhIUk1UenBvUTVDK0crUm5s?=
 =?utf-8?B?UHBvL0JsT29LNzVGU1A4cnhWUEZxN0dKbmJYV29QS0NhNXVUMk9hMTFCWlp3?=
 =?utf-8?B?ZzRGUG10OStNOU1IL3IzelBhbGJ3T3RXMDk3djljTnBPYnlsZUd0dDB5S3dv?=
 =?utf-8?B?YlZLSXdxMnB3TTVqN1JDV2h4M1IzZzNOUjlsN2Q1M3dKZnJtNWhJcUdvYlZN?=
 =?utf-8?B?cmE0cXZxcU1EY3VCUnVPajF5ZHVQbS95RGZxV3FuSXFnaWlXMlVqVVNpbjNH?=
 =?utf-8?B?S2toZ0lObUxkY0xEY0ovS29pYnFKZU1xY1dDWXBYNEtkM0UvdklZV0dQS1Bl?=
 =?utf-8?B?UkhqV051elYyS0hFeWZoUmFsRVRNUHdNQk13a2lrbDRGUnppRHBGRWE5WmJu?=
 =?utf-8?B?S3ovVXNacm1ZVFhlb05yQnhyRmJxUkp5UU1Ody8vZk92eW5jb1B2d3RkbGRl?=
 =?utf-8?B?K3pTMFJNUmhjSEZ6YjZLbkdxTkZ1NXJkak9aQ25rK3dtOGkrLzg0Z1I1c1dr?=
 =?utf-8?B?UzJLVGMxVUs2L2x3RGp5K1R6Q1VzUW9lcWRNVm41ZEh0ak9sa28wYTU5dHQ3?=
 =?utf-8?B?WDNlbnlBbEJ4eFFQbkwybTJQaUhCc0lIUDJtMzJZaEVkYVhaL0hUL3BCeHJY?=
 =?utf-8?B?ejBBUjcxUFBQY3dhQXVGcDdPamRHc1JhOUlFakVvWEFTai9idmFvbWZhSlZj?=
 =?utf-8?B?Qk5oTVZsS0ZEN1lpV1dKYm0yVXlzZjhZbTVaMm8wbmh3VXU1Nlc3WDA0aFg1?=
 =?utf-8?B?L0VNSUFxUUJUWXdtNmNIaW5wZjBGNGk1bHBTbWN5S3AvcDhNdXJIK2xxR05r?=
 =?utf-8?B?V3I2VHVQR012c2V2RW5SSVBsbVd0OU8vejVhL2ZxOHUwRFVlcEIwRENyalVv?=
 =?utf-8?B?S0dPem5STWkvOXN4dDhGUFo3bVBaRUtldU5IVnZoa3ZYa2wwUEErd01kMkdp?=
 =?utf-8?B?eVd4NzFMSmdsVGhIcGExSnc1dVJyUlZyL0dueUJXZDV4ZTRrSzBZSldrbFdZ?=
 =?utf-8?B?TkhxTndPRm12K0p6RllZZXV0M3k5bjZWMFhTMmZ1c1ZSWEJuaUNBc1o1VXJP?=
 =?utf-8?B?bnQ2WDdINUxFNFpzSG5ZZUFSSFd6TktNb0VGZlNyVEpqSFE5T3F1d09KVWUw?=
 =?utf-8?B?WDAwSUxqbnJUeEd4azN5ZitQVERqejMwYlR6djdnSDEwREVoUkxzQnliVFli?=
 =?utf-8?B?QnFqS2VIZTczNi9qaWZLMXhFalJTMCtRU3JDcGlSc2RVSkFDVHRVTDJvR0ts?=
 =?utf-8?Q?vSzXsew2b8Emw/AqSYwytIE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f614eb56-85d2-4deb-111e-08ddb99c6e00
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:12:46.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sz3kPczBSgvUCb0naS0nr6ETyYAlmsM+387gUrW+2kHUO95zqGPKIo+Cdcn4qm+SVEwQDS2y/TerpMYA2R/QgukA/YBpAkfZYEQnYVrsNss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11336

On 2025-07-02 15:05, Steven Rostedt wrote:
> On Wed, 2 Jul 2025 14:47:10 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>> AFAIR, one of the goals here is to save the cookie into the trace
>> to allow trace post-processing to link the event triggering the
>> unwinding with the deferred unwinding data.
>>
>> In order to make the trace analysis results reliable, we'd like
>> to avoid the following causes of uncertainty, which would
>> mistakenly cause the post-processing analysis to associate
>> a stack trace with the wrong event:
>>
>> - Thread ID re-use (exit + clone/fork),
>> - Thread migration,
>> - Events discarded (e.g. buffer full) causing missing
>>     thread lifetime events or missing unwind-related events.
>>
>> Unless I'm missing something, the per-thread counter would have
>> issues with thread ID re-use during the trace lifetime.
> 
> But you are missing one more thing that the trace can use, and that's
> the time sequence. As soon as the same thread has a new id you can
> assume all the older user space traces are not applicable for any new
> events for that thread, or any other thread with the same thread ID.

In order for the scheme you describe to work, you need:

- instrumentation of task lifetime (exit/fork+clone),
- be sure that the events related to that instrumentation were not
   dropped.

I'm not sure about ftrace, but in LTTng enabling instrumentation of
task lifetime is entirely up to the user.

And even if it's enabled, events can be discarded (e.g. buffer full).

> 
> Thus the only issue that can truly be a problem is if you have missed
> events where thread id wraps around. I guess that could be possible if
> a long running task finally exits and it's thread id is reused
> immediately. Is that a common occurrence?

You just need a combination of thread ID re-use and either no
instrumentation of task lifetime or events discarded to trigger this.
Even if it's not so frequent, at large scale and in production, I
suspect that this will happen quite often.

You don't even need the task IDs to be re-used very quickly for this to
be an issue.

Thanks,

Mathieu


> 
> -- Steve.
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

