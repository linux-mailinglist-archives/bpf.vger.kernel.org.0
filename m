Return-Path: <bpf+bounces-62804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3BAAFED62
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 17:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF4C6462A0
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F892E7629;
	Wed,  9 Jul 2025 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YpQJ/YtC"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2115.outbound.protection.outlook.com [40.107.115.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25FB2E5B21;
	Wed,  9 Jul 2025 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074101; cv=fail; b=ix7Dg8d3jKpnzyvKUyJX0F7xhsKu2HPxKerKPiSpvhui0AMM3YghnEGbWYJ3C9tF7FddnIDdCHHWZaaVd7uOHkVWQuLsMccpPnKNgYrdtFnExnTB8Ll+EbE5e5YNp1Fz85Q7QnE2Df00QfUfilzVCL0it9YcF4R2U8v2qZZn3js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074101; c=relaxed/simple;
	bh=4jLK90XVibz67ANCCqdCjFmT/c0DDAfu8/Wc09yiWl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J5C2tefnX7XZxe1kCsV1MrNz0flDpIXH+rCaknWBq1LxUyY/1oLgVko/4voVZlK1uxgIA0GEb8Q/A1BbVVrKZuYSTKhKs7UBw8tGJ9z6K32sddYd7kbLpFVR+GR9P95lRaiei5J7xQh/0aXM+afZ76TM6Pg8YTFKk3YFgeAL8Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=YpQJ/YtC; arc=fail smtp.client-ip=40.107.115.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ichAySc9QTlpfPm52nVXKiSshL9LOcdzom6mAFkZUmSCWgc8a+MAmHK281yc9zaON+pkuJNrLFHj7iGmLc5UbF0kwOza3iA9BMwSjH9H4sEk+YOKqsd/9CbHTqC4vjBCQcIFPC3Uif4PLRhhARCvFCxjX2kDV1JuvyOo5e5sQhOujdzelCpL3zS8IxVobhXcE12422Xx2oEAL5d+9jMl0A/DjDIr9Yg43VS4qUSFSIqlkItcN9dVljBCe0yWxzhcFygXmxpt5B/R8Djx+tUrkThNQZSm5YOTn1kY9mcchr+qxEDzxmI5nSC9wWmnIi7CJwTK4jnS5SE6P0x5Dh4nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gY8fsUBvY3gjOcpLOgBRtkX08QTSp27K2e4tl8CauF8=;
 b=SajgXezGSpSHVHOxqVHvensKAtdAP5PPXcuL5WmIxsvQGJ6KigqUtBOg7+FyJTlMSO9/aeHAo3PPrhJbpMAixNBFU2w7/S5kxI3cT2pM3Mtyhk6ulVXKAnhVsRfUJlshUH0j3KUVkeRLi9APcq1vwc2f58Mx3SIA9PBCsf8qNSEzPV3KpbF3/MBY8gh7E7Yomv5TZ6HbKXx61JNd1u+oi9FMCIcoFgiissOxTpoQT8QcsbNZWT3lkRhSONuhIvIoEKVVfMXL3e4b7q4+HXQp19em3NO081UStIBBb5PYw8OXMxpXF1tJflUFMGZArcwP94h0w0iRjpgQgI25Rz6BWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY8fsUBvY3gjOcpLOgBRtkX08QTSp27K2e4tl8CauF8=;
 b=YpQJ/YtCTqSqGjcvk7AlhrI3ZTlxllOq5/eSxC9/YF90tqLBW9bBhAsGdP3qR77Q6pLk+tRgYa6BzHnw6bx88FnKnRQT4ZbeECFg4jiuespdV3ng5jeAFDxX5YsAbRKzpODil3yo0Y/FrYcpQEezt/ysyEY502v60ViiCJoRnxXOTjnLTfboXTMJl6WYi3FITfdvyQZ3rKeBHs92hc9+Zi7ZcYfOdXf/4DcdY1lwbQ6P0A6kqOzHouSL+qksRJq6JExAdwXqjM9uSPE+Dt55FbPLhBR6aBCNREcoTjQWvhKhwQOBNpEyhv7xPXMLmFJa+RqdKNJcdOP5oBtgeRR3Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPFC69460E2C.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::483) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 15:14:55 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 15:14:55 +0000
Message-ID: <11e4392a-75ee-4248-9b70-2d6c32c818d9@efficios.com>
Date: Wed, 9 Jul 2025 11:14:53 -0400
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
 <939e13b0-be32-4ec9-a40f-0ad421f63233@efficios.com>
 <20250709102904.18cfd2ff@batman.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250709102904.18cfd2ff@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPFC69460E2C:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f8b42f-b869-4eaa-bdf0-08ddbefb5c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUVUaSs1Wmd6akNucE1VZENOdjBpMks0TEZVZnAxL3BXMW1qYkR1K1RNUC9S?=
 =?utf-8?B?RCt4dlEyOHI2YTRycWZxWUlleFM3QlhrS2hhdkNFNzBhcWRWalk0MllZZkph?=
 =?utf-8?B?c1UwU3ljQkJ4cUx1Ny9RcCt3bEtaOFVGVHBrOEVRTVc4TzhEd0hqQlgycmRR?=
 =?utf-8?B?R0kzSXM4M1hRS2VicVphY2xiWGc4c3BFNWVlN0d5Z0NnY2UzK0NWd0tiWWJE?=
 =?utf-8?B?bW9rbWhIM1BnOXZ5SXRCcGdTQURMcXdaOUNyWTlCeWlLL0ltOHRqMWhuZDFt?=
 =?utf-8?B?OFVMbUxzcmJBM0lvaFhndlc3amVQaCtuWnU2MXNkSG1mZmJuOUxoRjdaRGVJ?=
 =?utf-8?B?TEpzd3Q5akFveUJtbjZYeVpaSXhyeitRb3VrdXBmaGhKMEhMRFJaMUhXV0JO?=
 =?utf-8?B?NXo4MkdmWjFoNEhrSXQxWmc5Vm1qYVNSOVNNWU05TWVMWlBJaGw2ckFLNm14?=
 =?utf-8?B?cUllcjRjVEk4SFNzL0UxR1JQTGtpNFQ3MklYb2ozUlVBZjdCS3B4V1AxRm5s?=
 =?utf-8?B?MnZuNFU3dnhRcTMwT0JNd3VudjZJeWxwbXg4WStVOGkwTDRlSlVIRy9mZjk0?=
 =?utf-8?B?YnVaY2Y3UEFxQ0tJS0l6WDkxVTFVcmlSOXdkTFpKUXF3NlFlRW1BS2dzSW5j?=
 =?utf-8?B?bnU0YXkxQ3FGR1MyVFFFUmE5d0hoLytjdEZKc05PczJKQjBsSTF0UWVwUzR3?=
 =?utf-8?B?Mk41ZVdrVkVudVR0SEQ1SFROQnZXRVJxSnVncExLeGRFZzVGTVRTa2cwblhX?=
 =?utf-8?B?YzhiTHpnTk9zTXo1WVEwVjdqZmp1QVhKN3RheXVVazNXNnB5MkdoTnlmYlYx?=
 =?utf-8?B?djhXUE5RRWJvZ2dwb1pqVW9LYUtyTE1kS2JpdmkvVzFRdXp0Z2xpVkF4VkV6?=
 =?utf-8?B?K3JVN25YSnBVeWhGWHZvdld6UXdOWXlnNGt0SEo2UXB5Y2t1Nm5BZWZKOXJu?=
 =?utf-8?B?b0lrVUM3alZJbWJMZmNSMkN1L1Nnc3lmYTl2R3FmamtUdFRqdFdQWFVnRzBp?=
 =?utf-8?B?ejFWT1hFTnA3YVdzYnpYc3ZuT1ZOL0JBaEtQc0JBOHk1Tk9OckQrbUhYakY5?=
 =?utf-8?B?b0N0WFZja1pOYnhiY2tyUEFIcmZrR09vMFNNbXZYU1dSMXZPa2ZSaSt5QTEx?=
 =?utf-8?B?ZVRFWkVXRitCNFdOZTFjcjdJRVQ2S3l4UkVsYXRVVkliZHpVa3JpdkFCZTI0?=
 =?utf-8?B?azZoVElncG9sN2ZRcGUwOW44ZW96ZG40Sm1RUGlmMzRRSUNNQ29EVisvMncx?=
 =?utf-8?B?dlQ4bkxxVFNSWm8vZHYzeGdLVUowNWVJaXhZNmVFbTVwV0NxS0l1UWJ1dWxP?=
 =?utf-8?B?bW82bDB5OHNvYkRiRVltc3FTT3VPQzZuQm4vSkpWUmhwa29tMm1lS0VvR25p?=
 =?utf-8?B?UG8vVTBCclNBVDkxNi9TOHBxQ3hrd20vamJWNFFoc3NOdExZa2doZE15YlQx?=
 =?utf-8?B?bmo2UnNKSmZxNUlsTklOWDFwd1JFTCtGNDc1UGRsSWZjb2puU1JIQzc5Z1Bx?=
 =?utf-8?B?dWRrRE4zMU5kd3k2aDdCSG1MUEJhS29yR2NLbndZS0d4em9LanppY25SbXVM?=
 =?utf-8?B?VVNBYzE0Q3E0d1BCNlNUOVVhRzdUekg5blRsZzVtclhhOWNES3crcXhybDAy?=
 =?utf-8?B?c1ZIVy91LzJFMDcvRktoK2RjbnJCemZ0TFA1VjRDakIvdzFlOFpHdW15MERY?=
 =?utf-8?B?aUduOS9XVDJ4NmM3WEdIWkRGdmxqNUFRUVdmTW9pSFRBZE9OYUlLL1ZzYkwy?=
 =?utf-8?B?T1JtbFhybElsZ0V3WWlLQ0RhcUx0dE5LZUNqK3Y3aXNweW9QT2ZvUlBBckhK?=
 =?utf-8?Q?L/aRZorR+3pDwY2NVAea7r/nidUZQ/4KywHTc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVlZZzdsNUYvNEZJeFFLajB3RHJZbDNKWWRESXpoaU9wL1ROcnEyRVFDenI0?=
 =?utf-8?B?eWtQcEFOckIySnNNUERGWFRzK1ZJa1U5TzgyTGVWcHlXT3hsQ2J0ZGhFT1V6?=
 =?utf-8?B?SWhVakNmSzh2Y0s5MmoyM0NMOUlsYnlrMG4yNDNGYVZnUEpFZ0F2WmpIbzNv?=
 =?utf-8?B?aUluTmNYRm1nVTB1WXlKTGNaeFd1eHpUSUNibnU4RittbVA0UEY0TDNOcmpY?=
 =?utf-8?B?MXVxTlpqeUQ3OHFFN3hhV1RyQ1VZRDJQZC9yUTVzK1dOdi8zdHJRQXNvVDhL?=
 =?utf-8?B?SE53L3h0bEJGeTBod3ZIUFlSTW1OVWc0V2RFeEdnQTR0cHNSV1JlWVJ3bFlS?=
 =?utf-8?B?RnF5YmhYS2NURXk1S3liUHBMaHZuRUdlRWFNTHpXREcwNERINnNZeEl2eUtG?=
 =?utf-8?B?R3NmR0UrUU81SUorNGp2Sm8vQ2FMRUVwbXlhZlZQcmo4M3ZGRHpGN0txS2JK?=
 =?utf-8?B?M0xTOHI4c1g5bmd5YmFWc2xwOUNuVkhMTGh6ZXVwY3B5SVhYVjJPRnNMMXZL?=
 =?utf-8?B?MkNvTE1BaGdIVU1tejhiZXVXc2FWQUNmMmZJZTFGY05aWkR6VWZDNzJTZUtv?=
 =?utf-8?B?bDlkNk9lQjljdElNK210dXNFMk5hRkdabGtXSTdmbXhqSjJtUVBSVDJXYUY1?=
 =?utf-8?B?d0VCVzVtVS8zb1I3VldrdUw5azIwaHdSU0tLSkpsTjRnQlRFZ2dvZENERmpJ?=
 =?utf-8?B?WUo2WU9HVkF6VDU5UTNHcUlQSzBBU0JXMFpHTmk0WFUzQW9kU0ROYzBFZ0tR?=
 =?utf-8?B?SXY0cE4xM2JDR055S3FuQ2w4YU5aMnNRTjc1akI4eUlFQ2ZlK28vK1ZmYnQv?=
 =?utf-8?B?TUFjN0JDYVRBQk9ieFNIY2RZUUluMldJNTIwYllPZTdJZTdBT21OemI1VTI0?=
 =?utf-8?B?amNDL2Z1VER1bCsrNE5pbExxTzBqOXIxNGdSUjVFWmRIdmxOMTBrTkh3YUdm?=
 =?utf-8?B?S2JWL0ZIWXpqOEN0WUcybzJCcU5aT1Azbzcrd21qcDdEWnd4RytsNVhmc0xX?=
 =?utf-8?B?UzhPZDVYZVNBL3lqU2lOSXlOaWdBOHZ1cEFHMEdST1hZbjNDUlJKbDNadHNo?=
 =?utf-8?B?emxFcEVaOFlhOElRT3c3UWVlSUFhOVdIMXFrQzFLdFJsdE1rR0V3c3ZZSHFZ?=
 =?utf-8?B?S2VWL2RlMndmTmVHc29SZFBJL0NxU1l2UWNyMEtmRGh3dFpFR3NVNFJHL1Q0?=
 =?utf-8?B?NDhDcllQVlh5ZWJKWDVsSjNnV3QzNUl4TlQ4QjFrT0NOM2grc0R2NkVwQ1Qv?=
 =?utf-8?B?ZXRaM1JIL1JQdm5iVW9Ja2NOblZpdHhyWForTVpsbzFwV2VnSS9DQXZtendX?=
 =?utf-8?B?a2tJL0kybDQvN0xiU0Z4RitxL2I5QWVEUTIwckVTYVQxWXdKa09XWThocGVV?=
 =?utf-8?B?QzFtWTdjeDFhSjRqaXVna094SmhEd1VxYlJ3cVhPSkxjSURZdHFHRmkzdjJp?=
 =?utf-8?B?ajI2R0F0T1dpdEZ6NUVDS29VNE00WnF3QmxPeFREdkRBRWsvaDNCeFpLcFdN?=
 =?utf-8?B?Y3BjbFJGMmFwcUNodzgvdFBjeHQzWXBSaDFIQlJIQ0xhRUVJSll6ZHh0Sld0?=
 =?utf-8?B?TWlPYWl3YWRlTE5DbWVhNUc0QnZwOG9GQkJZLzNIYmFMdDhya1VDVVpTcWpG?=
 =?utf-8?B?NFQ3OHZ0RnVJS01ZSHZna3hrZWkrSjM1RzArMGZQUVUxS1I1b3MxVWlNN0pX?=
 =?utf-8?B?aHdjNFhPM0IzLytlcGxKTnphMnNMaHVRWDA2dFp2SEUrRGFLRStxbjlxYnFF?=
 =?utf-8?B?V3dKeDBKRDFGcWowb1Uyc3VQZmZ4NXpSMTdsVnBxUzFKNDQwZFpqaUI5OGNk?=
 =?utf-8?B?RVVyMDh4VTROWFNUdXJ3Um4zbHVsNVFpZlc1NEN6cVhCTHBnN1c5WFhzbW1R?=
 =?utf-8?B?OFBOME9CWHJQa1A1eHpHekozUkpnR1NMempJVmZjYTBLb3lEdVhaSHNPTUor?=
 =?utf-8?B?M3h3SXRjQ1gvUmkzMGQ1d2k5RW10QTlvNGhQT3ZlOHloUllrcEFPcUtPUFg1?=
 =?utf-8?B?Q0lRUmlvMTRuRmdvZ2JtelpyS0lPeUZxdVU3OWFQVnN6OHczRXBRS2l6SjU0?=
 =?utf-8?B?T1B6MVk0dGp2RHFuRDRaaXpvL0NkNkVvR042bjhqNWkrMXZZWFQ1TTFyQ096?=
 =?utf-8?B?MEw2TTJLQzNXYlhuZzdjQ1ZYRUpFclpNMEpraGZYKzRDbjRyaVBwN1V1TDBB?=
 =?utf-8?Q?FUGY3E2h64NM2yio3HBAKN4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f8b42f-b869-4eaa-bdf0-08ddbefb5c5d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:14:55.3706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rd7o+0bioG6A7tThkvrk8+IXjl3HW+E+lsrAGZrRrXObwaeOnqFiM7fpDaFkhD1u9cf+4Cgi05Jh8Iub9bVOf0boBdTAGdC0ZkK2lfGboNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPFC69460E2C

On 2025-07-09 10:29, Steven Rostedt wrote:
> On Wed, 9 Jul 2025 10:10:30 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Indeed it's only kernel internal API, but this is API that will be
>> expected by each architecture supporting unwind_user. Changing
>> this later on will cause a lot of friction and cross-architecture churn
>> compared to doing it right in the first place.
> 
> The changes you are suggesting is added info if an architecture needs
> it. That is easy to do. All you need is to add an extra field in the
> state structure and the architectures that need it can use it, and the
> rest can ignore it.
> 
> Again, I'm not worried about it. If you want to send me a patch, feel
> free, but I'm not doing this extra work, until I see a real problem.
OK, I'll do it. As I look into the existing state, the priority order
appears to be incorrect on compat mode: if we have both compat mode and
sframe available, COMPAT_FP is preferred. I think we want to favor using
sframe first. But then if you select "sframe" in start(), then you don't
have the "compat state" information for the compat-fp fallback.

So the "type" logic is all intermingled between "fp vs sframe" and
"compat vs non-compat" there. My changes will clean this up.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

