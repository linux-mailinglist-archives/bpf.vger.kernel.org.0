Return-Path: <bpf+bounces-69535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97374B9989F
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FF91B243D1
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582C2E5400;
	Wed, 24 Sep 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FPC9hTcV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GDkWoVkX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293682DF703
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712125; cv=fail; b=fiuG0OrhlTNtt5YVDGcLuUPeEPQd4wwLS8tnhjMOJKZh7Rzotx/O3Wihjnu/eGEQo/lsYLtH+1LmvVB9z0GUsP6WDfnGk4kXUxR6bo9iwlYJIjT5c/iGZFuaazknNj0hxenOsOGtQwsUqX0ZtmI1DMzxo7Ti0MCeONwNKl0F56U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712125; c=relaxed/simple;
	bh=NJr5YgdcU01xlXqVXmHhge83hanowb86+gA7qF5Cav0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R/ONi3/2Rg0gmukg5UT7LYtaqOGJgcPRCTOFUBxQOiv7yFIG3VLzhaE6Jr+SDJw9zZf0lmZU0Ya6Q9eWBVkw3gVPXVGHEKXYIwN9D3/+CEhTyukvOmSNsM0NZYj7SqzCM1y7O5HOGzsTskvhfRfE8WeRgV96uz8HWdIgxpni83w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FPC9hTcV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GDkWoVkX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9MrAt010966;
	Wed, 24 Sep 2025 11:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tqYpJLU/HNhfCmYjjXMj5f2TnDoD8U0C3fG9dOyhmTY=; b=
	FPC9hTcVekZFP0jQQBpcLwWwOMYv/r/MJ/8vKSVu+N6sX7Bt6tYkCv+wC8RG+C+Q
	F5VNgiqRDlrj+MpRG4PowNWY0z8wrcLMqZZ5GJwJqG6QT4QRYfduq5cCqYaMfrRJ
	FdAlx2qVfvhOcBeGl9a7wHzX2A+9p4GJC1qs6d1Dmlkobsfjm+WuLJcmAcYdo2fc
	rPlsyMjJwBukfxiTUmS1BTps45KRhFvNgP3gH6lf8GyGOLZdvDYKyVQOxnvIidLm
	upUxoN3PbejFntCSW4CzoMN/z9tY85wTANP6Ff+0ob0R01KMP4easMbM1DHE/j0h
	rTADEJfmkEO6NeyR6qrs7w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdqcfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 11:07:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9baLl033020;
	Wed, 24 Sep 2025 11:07:59 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a6nkx3gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 11:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ok/Gat5g0+T43v800+sXHPcfTe+n1QQ6+PExoo8SJ6cJ7YvTJBEmxpFzLKH0G8ucJKyBc2RTuiLg/5t2u3hcJWwzivgZnJYALqKurTZsrCPx9KQo6P/Ddz3L4IhCTJlU+uzOCia1rYfkZWhtv7EeBxPD1630FzvDTDeGUrM7ULFxzp7MfDs1P0sqXzYTy61szYXn7mvU2Qn+B/hJtNEWaAPqJNY05q5oN+weuR9lPwAY/VHGCbJko5grKltxVpY+GgEPjhShWVjYyPs9v7+lUJ61G0QUXn3OwFFhAFcxkB0UiL4ufHh9znsxOrl2XvW09juJny1B9nFv9t+mCuN9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqYpJLU/HNhfCmYjjXMj5f2TnDoD8U0C3fG9dOyhmTY=;
 b=sjBB8LDhVrm8y3r6JpQmYI9jkGfYwEqGDKDQJ2u8Z0UL6/3I86jY4bBNjGdQLvW6YCAY6cC8jkqjmoe2wZ7c4XUU4EV9iRsFhhptdPutPjhCS1H2MRKGaKM3zEzcn0jmkHeYcFv2rYA3hYr4AFbyFfzKS+/PSp3PFfLzNCZvhSLdJHoDmIn4BIAfIdS7/UKSA2VXK9/MSv59JHaTRlFv/ZQJPd0YSYzevKZjWExCWlGMM/cEt8uow9LbehAkHYHSDGx0u/AEK+iul7EnyFadPJvuTt11UZgrYtThk3iSFIBmYsZZ2453avl9+CO2wUqDNaPRM0YLHfOA9qzh0rxjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqYpJLU/HNhfCmYjjXMj5f2TnDoD8U0C3fG9dOyhmTY=;
 b=GDkWoVkXaYohcj/igRWCMNCFI2jTIGCkZ876zNMXZjpC1rtlkQ9xm517JUgpDNm5ypHqquSJ22dUHy28NDdmNMDS4visqSAQqgF1aa09tDQTmXIyq9lLrbssFSGmJJ1KiTmipxVilv5oMeQfxu9pmkPnAfqJ/m2FLlFiPuwRVJc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN2PR10MB4319.namprd10.prod.outlook.com (2603:10b6:208:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 24 Sep
 2025 11:07:54 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 11:07:53 +0000
Date: Wed, 24 Sep 2025 20:07:47 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH slab v5 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aNPRA0WJJkNMnxbc@hyeyoo>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-7-alexei.starovoitov@gmail.com>
 <aNM-Esr0v_95qmEa@hyeyoo>
 <CAADnVQ+7W9MBG5i-r1Bh+ya=xN13LTVLN+EYwzP9dhVo4cUnjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+7W9MBG5i-r1Bh+ya=xN13LTVLN+EYwzP9dhVo4cUnjw@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0202.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN2PR10MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ec501c-ca47-41f2-c986-08ddfb5a9bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjlxYWZacTVyS0NBYnJPRmJZVjFUcjNGNXVrUHUxQ01RWkFoK0JjU05XKzFX?=
 =?utf-8?B?a1Bqa0VXWUFrckc3U0x6ck8wNG9YMkpzMWF5a2ZaU3J0RXpQeDNJK1h0dFlw?=
 =?utf-8?B?RHVqS29obklOUUhncVpqRUZyNERyaDQ5RmUxS0ZvV0FwcUNLTkRxY2tZZzJ4?=
 =?utf-8?B?RUR1YVpFUmgwdGFwUVZtZDZCbW53K1p5QzdNcUFzQWd6R1JGWEEwVU5LVWpr?=
 =?utf-8?B?MUtOd0R0MDhQL3RWZmJselBHRWJKbHRqZVYxSVlWc055UHVHQWpZQ0RzRTRJ?=
 =?utf-8?B?eTEwaWxoU2Z2aFhGbkgxM29PUnZDeWs5NFNUUEFseWxPSTEyTC9qUE9DeVlE?=
 =?utf-8?B?dm41RmpYQTR5Q0NRLzJmK3lxc0lZSXBTa1Y2SnYybjV4blpHOVJqaG50Z1Nw?=
 =?utf-8?B?SytsWE16WmRibFBNanZPeGxTdEpvbUNRS1VTd1JUZldxM0ZPa01RWkhGMWZo?=
 =?utf-8?B?ckZheUZKUktsOGt6Mldka1hQc21rcFcvd081WWVDU0tSRlpCUEtnK25uVjFN?=
 =?utf-8?B?S0NlWG9WSnA2aGRGb1FPY1YzcnBvMGIwSGVmN2puZFdRSGhzcXJGb0xNOVpQ?=
 =?utf-8?B?QmpIaDlPbzhVaTFFZENlbjMrNm1Eb3hsMTBhMEtrNUpYSndPUEpiRy9oUS9J?=
 =?utf-8?B?a2IvZ3F5T0RlQWM2V1I3ZGRHVCs4ajJkeWRMYXV5SERmUDJFMGYwUVZMZ2FP?=
 =?utf-8?B?bW82N2Vad1VwYVRoZXgwZmcyZzFYZGRCcmV0Q2xtU3RhaHJHcW9rOHdsV2Z6?=
 =?utf-8?B?b3MyVVoycjVINHdndWdJT2N3NVpwWWlxd1E1bms5THIrTGxzZmxSMUVZU2NM?=
 =?utf-8?B?RkVMMGorQzk3OEUwYWxBeWRhb1VMVFllbjVWMk4rNnVidVpJSWJ1YVRGcDVN?=
 =?utf-8?B?NitSRlJ1VU1CbkE3ZFZGT1BmWjEzN1pVOHVwY2pIbzZwTFFyOFJndVF1d0dz?=
 =?utf-8?B?RlI5Tkw5Umx0bEltVk90UzhDRi9NSWQwU1ZWZVlIZ1ZxK2RzQzBVQkVvZk90?=
 =?utf-8?B?Rm95TEh2NnJQY0I1eFJDMWZDdHI3WnR0aERZckF4dmpIM3FscGRTc1pzMXhY?=
 =?utf-8?B?SlJKY1QvcE1YQlkzQ2JTRnBETmdxdjhFRzE5Y2JOeklwOWliTkh6SWQyNkJy?=
 =?utf-8?B?YXI4OU1lMzhzWFBSa0JBWUY1TkYxbnQ4VHgrNlJKVEkyNWpTakhjSVZNUzZq?=
 =?utf-8?B?WEdpTHdmc0ZTT3JGQmVlUzNwWmdwS2c0aUtwTWxCeU9jU1ZXRzB6RjJuelZa?=
 =?utf-8?B?VE1rS2o2dEVmYzFyWStCb2dCTE1lazd5a2FRRTA4SjBEcGlHUFVTNzlQM2xi?=
 =?utf-8?B?aVcwNjRZMUFJdEVNdDRQL3pLcWczcTRrdERTZzdNWExWZlNJSk9TaDVwNVVJ?=
 =?utf-8?B?MS9wVURaYlNrQytZNCtObUZFTmZBWWI0T3ViU0xSSTU4TGoxK2RPdmlETG5u?=
 =?utf-8?B?bDdtanh1VjVWaFF6bGpsOEUxUU5pT1BCLzZBa0JJNWVkNVJXdXpVSXBJZElo?=
 =?utf-8?B?VzRkV3M1ZjRaMGoyU3R6Y3lsRnExMzVTV1BqNkF4YXROaDJuYlFmd0FEc2Rl?=
 =?utf-8?B?WXdhZEVmUnZxQWoyN0IwbXd0MUZMcFcxYm8wbzAzZWF2RjhGdjZWbDRydURY?=
 =?utf-8?B?NTlxY2F5RlBFQ3o3R0kyekY4UklWby84QVA3SG44dGRFUGRsR1F4ZHFLaTZW?=
 =?utf-8?B?RzNJUWdtTEsyaXM0MWFvUHorZWVSaUhwK2tNL0xxMkhmNW1iSnZvbkxPR0ZF?=
 =?utf-8?B?REl1S2FEYndLUXN5YzBkazg5cC9tZ05mSDBxdCtSZEwrMWtLTHNMTHdaQktM?=
 =?utf-8?B?U0ZpUW5HTWRlS0trVy9YTzZ2K05QeXROTGx1RHNtQ3kzRDZvMG5VeXV0Mkli?=
 =?utf-8?B?N1FxVUpEOTZlbUYvSHNYL2kxTFlVU1lWZjMzNWdrTlBKMklQM3lPQm90Vlg3?=
 =?utf-8?Q?J7JScdKbJWE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0c3QUlmVnlrMjFrMk52WXovVXdjd1puSGFLWFhEd0gxYll3SEtBTHpPN2Rm?=
 =?utf-8?B?T0pmRWxNdU1tRlJsYi9waWp6aDBqUnl5dUJjbEg4bTRabE84bVdWOThqR2Vy?=
 =?utf-8?B?Tm1hbzR3K2J2RHQvTUNDcEJDWk5oVnc1dGUzQVc2OUkwMGMvRExESFlmR3Jy?=
 =?utf-8?B?QWJLZWd6MExCQ3FqSUpYQ002MzJwNCtPbWpuSXZMTVBkVVBncVp1dTZreTZF?=
 =?utf-8?B?bWRVbHRVZVlJS1F2RWsvYTBwL0JiUmZaUXMvRThqVG5yTGlQdHQ0akl1KzQz?=
 =?utf-8?B?cU4wYVdDR2FKSXczNW9WdkNETlM4OTNPQkdPeVdMVVI2UjRmZ09UZHM5ZWxV?=
 =?utf-8?B?VHVxQ1hvb3hIM2VObEhBLzUzOVpWV21uSDVtS0VmSzh4QTVYYnNNd1dBTTQ1?=
 =?utf-8?B?NW1IKzYzM1FpdkdlakIxQ0k3eWJTYlNYVzlMWldkeVdaeGxpMlpES3pJU0E0?=
 =?utf-8?B?QmdQbnJlWW9wY2d3UTFRbXY1OExmOHYwTzJSSWNRS3BBSkJuT0ZOVnh5dDRG?=
 =?utf-8?B?V3pKa0FIbnlCZ0JMak9HOVRpTHFVbWNsdG1uK3ZpaGpTS1J0Y1FhTDVPUUJJ?=
 =?utf-8?B?Vlpsd1BuOWZCdXNlV1RXVW0vMDlzT2tFcHFGeW5vQ01VbkJCZEMrUm1UUFBD?=
 =?utf-8?B?MUkvdFVCbDZzM2dLVk16QkpSYlhpeThQdDErTkd5d0VXMkpnK1R0cFpqbXpt?=
 =?utf-8?B?SGhKS1A0eTc4YWw1U2dxNjVKbi9RZXhOdzdsRzZOakI4dnB5MTB4UlpMSWs1?=
 =?utf-8?B?OXdLektTc1g2RzRBWWcvQjg2UzNQdmhnSjlkMGJiSzBuMU1pMmRqeXFNZXEv?=
 =?utf-8?B?bnRhS01MQmNMeTUrdm0vL3dyQ2ZjdHlhYVA4MVlUK0dubE9PdmtaQmFOTW00?=
 =?utf-8?B?VEE0a1NUL1BlZzBoOVlacmNnTmlXK0dNalRhbmV1anBzakxzWkxxeVpGZ0JI?=
 =?utf-8?B?ZmZoS0FNeEFhVmgrNzB3eXlsR01rSDNlb290MEZPcTg2UEZqdU9TK0h2NVJt?=
 =?utf-8?B?OWZJSkx0UlBZeWI1UlBrQ1RibHh1Sjdvc0ZUNjhBVFJoM1h3ZENtbWg4TEhD?=
 =?utf-8?B?MU4xdnk3d1dzNzVZUE5yUEtzYlZCSkYrV0JIQW80ZkZ3WmoyekxYL1pmcFFa?=
 =?utf-8?B?ZWlJWktEdW4yMlBuK1NudzZ3d2FFcGRsdTBBTlFIRmFFRjZveEtYNzgxVXpG?=
 =?utf-8?B?Y1pNdmpocTcxZnpwck5ucy9pV01SSXNoaWhFYmZtMlcxY1VVT0tzTEhNYVh4?=
 =?utf-8?B?OUtjTFVDdFZEeXM2SzdiaGV3ZUswVVJNaUF3M1lFUmNtcDAwVms5UXU1M1FJ?=
 =?utf-8?B?MDN4anZIL1VuTjVOQzBlbUpmUDlzdzM2c3o2c3lrblV4UmIrejErZXRadGNI?=
 =?utf-8?B?dWRUdGh6TFdRb1hibG9UdmJnNHlEZndLSnV3UmVCZjZNdU5Od1NBS0xUOVpy?=
 =?utf-8?B?Y0RpUDBWcXRJUG5jSHNIL3Z0VTdqdDRYT2ppeUZoQVVaWHFya1UvNVFqSlBm?=
 =?utf-8?B?cmJBWHhqMjlETUFKTlJaa3BaVmVtV1ZuVDZzYTVlSWdERkVZTmpabWppc3BF?=
 =?utf-8?B?SlZJak1lcGxCR24rVEo4K0tsRlJpN2ozL3h0WlFSR0o3WWhXRzRyUVY0dFJs?=
 =?utf-8?B?bVZFWXZQYkxyWFY4b3QvK2h2QjlRN3o4c0ZUR29pQndiSFdLbGszM2V4ZHEw?=
 =?utf-8?B?SWdQQ2plRngzUjlhdFBjK1RJS3NVWXhHUG50RzBCdGtIWE0wWUVvT1BZcndv?=
 =?utf-8?B?QkhIYUU1elBaODFUc2l0cGtwVDI0U1FLVk03d1FaWVFxNlMxaG51WFZBbnB1?=
 =?utf-8?B?aE53U0hKRVJTYXlGTjU4RmV4bTlpVk5QOTY5RFdGQU9MLzZXRFVJTzJNSjJY?=
 =?utf-8?B?OGhzd2RMRnN0bFJjSSt3STU3azlVcUJQNC9tNzByMTZ2OXF0R2RXMEQ0bWVa?=
 =?utf-8?B?SEV5OW56WS9OWmxoWDVWZ2lPVlMxTFBnUmp2MHE5ZnZiaTFoRExQdUl3TGx1?=
 =?utf-8?B?SHFYSGVuVFZtU0lxbUdScmVqNEdDSExCUjZ2QnZaQWVENzZrcHZyZFEvUWRE?=
 =?utf-8?B?OXc5RUhFNU9CMjkyczV0cGRjbGRnVWxWTzFaSlFGb3I4dkw3RTRHY01Idjlz?=
 =?utf-8?Q?jsmO30Sc4H4LSqBiulaMCj8Oj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YKxksCewVoduqU9siD/7dHf6rs7mo4xtApceMnxDU7D/KkgtAorFqp79lfGSM4As0CngDT7YZm0fMABvY+7tmJJWqEixJ/V/twTWKVJeti2/GqX/d0LKB9W2h595dhcQJlMbpxZ7mtkihy7QpY88l50DK0uuLxPcVLy+bCR+RbJhGbPuqclghMYUKUnFICUxxHCsgWQwA+L8vE+uiWDWIplyvpgQUK6bHAppboLfGWLUtn/A2kYpjGTvg1Sop4CZH2ODI35N5kKDpm6NzE2ita40/ICapuZwsuU77fvZfp1Tr5xyAQ+533NOt6XohJu0Y6LGrdDwn6Ip+H0t25NOJzd5TUpKsaYlRHuGBRDKvZVWj9lXgVpPWOrmQDm/feclk97R9IH2vfP5ux6U/opkVbIR6XB7N9VPycIOLUUMWSFiiwyKH4P3j7o8CatgFQu3xU5vZoJ3bw8riJAOsx+8zuC3o4N+JvimyU7mfurOP3oNF++6Qq6EbsksiiHK5qfbUqbYku/Id589eUKmunthcXm9Q7Smjw7HM4+/3C6S+xljbz+paakaodSCYLshRyuKVyyJUDpNPANSdQJ4ZSNQ+fEmOYvX17zmXNvu2KfP37k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ec501c-ca47-41f2-c986-08ddfb5a9bc2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 11:07:53.8523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3gPNWtkMADYWJujum9ixCXUNeeK8xZgbINZeLh+mRvSixqISoISEMaT4XVB2QS9bDj76qbmA+PMzcAFGzg1Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240095
X-Proofpoint-GUID: yyTdiIlZxKivgudVcBDon64meNJF8iXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfX3YnVwiGL+Dhd
 BpNr0WhW6dglS/R2o7JvwsKtxGMfQcCJo3iR+R+VHq7ug0rkQ0smUrUAndVauGINz/GbnwQv/mT
 T6y2IQ3lywmjX0L4asnSWnxfZSZFhVvQpN13Z2wwE7oyAIWvp1THYQ+DTzjwI1juvc3DidiPDU0
 AbQIhgrSHFQKWGK+ldWpi4acJ4kzuwzbx3IwXZm+dN4i1+KmOpjcAe/NPbF3GE1XGMyaZOwota/
 3cDSgSHj1SJ29ZQgp2VSX0A1n+PEaktVyThBwexWHqUQQBs8RGLk3NB8AN5+omCcBtrbUcDQJX6
 vPdpRdT9NT30FYiYa7u5jyz+ETy5GL8zeksRdFV3r5kMHkQgMF0lvC+/CytKfik7QN+JqZQ8XbP
 vsbsnA6UFh1EdLhy6tYAR7MWBKi3cA==
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d3d10f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=aF9CUgAn8DS7y_QNA6YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13616
X-Proofpoint-ORIG-GUID: yyTdiIlZxKivgudVcBDon64meNJF8iXa

On Wed, Sep 24, 2025 at 09:43:45AM +0200, Alexei Starovoitov wrote:
> On Wed, Sep 24, 2025 at 2:41 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > On Mon, Sep 08, 2025 at 06:00:07PM -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > kmalloc_nolock() relies on ability of local_trylock_t to detect
> > > the situation when per-cpu kmem_cache is locked.
> > >
> > > In !PREEMPT_RT local_(try)lock_irqsave(&s->cpu_slab->lock, flags)
> > > disables IRQs and marks s->cpu_slab->lock as acquired.
> > > local_lock_is_locked(&s->cpu_slab->lock) returns true when
> > > slab is in the middle of manipulating per-cpu cache
> > > of that specific kmem_cache.
> > >
> > > kmalloc_nolock() can be called from any context and can re-enter
> > > into ___slab_alloc():
> > >   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
> > >     kmalloc_nolock() -> ___slab_alloc(cache_B)
> > > or
> > >   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -> bpf ->
> > >     kmalloc_nolock() -> ___slab_alloc(cache_B)
> > >
> > > Hence the caller of ___slab_alloc() checks if &s->cpu_slab->lock
> > > can be acquired without a deadlock before invoking the function.
> > > If that specific per-cpu kmem_cache is busy the kmalloc_nolock()
> > > retries in a different kmalloc bucket. The second attempt will
> > > likely succeed, since this cpu locked different kmem_cache.
> > >
> > > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > > per-cpu rt_spin_lock is locked by current _task_. In this case
> > > re-entrance into the same kmalloc bucket is unsafe, and
> > > kmalloc_nolock() tries a different bucket that is most likely is
> > > not locked by the current task. Though it may be locked by a
> > > different task it's safe to rt_spin_lock() and sleep on it.
> > >
> > > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > > immediately if called from hard irq or NMI in PREEMPT_RT.
> > >
> > > kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> > > and (in_nmi() or in PREEMPT_RT).
> > >
> > > SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> > > spin_trylock_irqsave(&n->list_lock) to allocate,
> > > while kfree_nolock() always defers to irq_work.
> > >
> > > Note, kfree_nolock() must be called _only_ for objects allocated
> > > with kmalloc_nolock(). Debug checks (like kmemleak and kfence)
> > > were skipped on allocation, hence obj = kmalloc(); kfree_nolock(obj);
> > > will miss kmemleak/kfence book keeping and will cause false positives.
> > > large_kmalloc is not supported by either kmalloc_nolock()
> > > or kfree_nolock().
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> >
> > On the up-to-date version [1] of this patch,
> > I tried my best to find flaws in the code, but came up empty this time.
> 
> Here's hoping :)
> Much appreciate all the feedback and reviews during
> this long journey (v1 was back in April).

Thanks for pushing this forward and incorporating feedback so far.
Cheers!

And hopefully nothing serious comes up 🙏

-- 
Cheers,
Harry / Hyeonggon

