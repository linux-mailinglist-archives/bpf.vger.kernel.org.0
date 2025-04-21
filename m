Return-Path: <bpf+bounces-56312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9EA9531C
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735133AE1F7
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A941A3150;
	Mon, 21 Apr 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IlVpUYmc"
X-Original-To: bpf@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020136.outbound.protection.outlook.com [52.101.191.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510784039;
	Mon, 21 Apr 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247242; cv=fail; b=oTO+1v8iSKmGiodOu9r4E8D/nc9r2LrlPe0s+lZeGNWimXp9FZRl3NTMpqVcda1yqjGxxw+hcpMZJeJsvqYl7YRaUaGdOjul8Mss/4LBH8/SDwuclvsPzOWhKF/Dc7+O33uP2Q4Tr0tKR1NufI+DvOvBq3wAy5bqOxhBmlwb4lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247242; c=relaxed/simple;
	bh=nqPQ1ue/tUL3Oa/VYqSvWoR8pI0ufLtodP7qf8kp7Fs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DqZ5oXBtXNImTGWH8ARxRpWlCk6wfy5YvASyh2zuAjRddw250Do1CWjyvmyhNtuY8d7MyATXycDolcsZmuTSwW/C1On9le86SEjcfJmo77q0N07J06egwj0yc+/C8xueXVy+ylNu2X21+T6XaHFv6SIYIVy/BPYOCdURQv3y0wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=IlVpUYmc; arc=fail smtp.client-ip=52.101.191.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofImpv1wpC2IIJr4leycOJg8zTjCNr81yXJpII3LSecdMhcxpXSuRP0I1Jf+HTkXx02uil139vI0ne3VhojTg5DISSaSRXjSKr/JBeFvuT5rYX+RlUkJeKHfm89Byl6l6aQjjyGy0W+6258sitA3KhJDzP/XC8BS34vBy7s+zSuOyfpBzm7UAS/krX0dvdbPid2S+F4Z+gTRtaegGp81Gvz3Ruvq/fLDoQqhbivT9u26w6XI8qL5PffuLyLk1MRFvzgjd2xCOYe5yxfJWDjVI8s1LgdQTcfe8MD/xGTwHlUYuinEOZcDkWb9+8SrgzM2XI8wXsrvvwR/9GWkgxF7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuJA5Nw9k74JvmBD8wvLFX1NMWsNEwujI6La9UVDg7M=;
 b=GL8GNjlalgk5jZb4Yl1wiq6hpguMCtSXztKzTsaA62Gy4yzEvCCe9fTjPa0zFDTmkcaIqkVgP57kWYbXCSu7bE7U5UW9uz4Fec9ANv9B9M2IQTJbWvFi9BcF79ApIbzwN3J+T7Po/x6J634WevacWz3/7aPdBHmlUV8pK7HM+jGdUVbORPa+Upm9Uk1WUTSJaUNioZ9MK7PzIHMcvHcCxv4XjSUb+GOt6IOQhm0vzzPNbPntdtMy1doK0XzuuqFnzB4GW/C5Ng1aHTSS0Mz19Vx1kycEzY52efkzEICKwRNcvOsUs+xaGWz6+tCaPqZY4wHI1xiqtTK3Ew6WswBN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuJA5Nw9k74JvmBD8wvLFX1NMWsNEwujI6La9UVDg7M=;
 b=IlVpUYmcnlHIqz9tRIjsJ/XCvqo+IoZkTMGMPv98DtMXBW9dfsOwQ50xiDY1FeSNWddpohE/MxRTtuxdfYqNmfjkKFlJJgtdHe+j4lK6xpRgt3YlND+TEfd8d1M+KJyehpiB3K1/3kCvAdvQpkBPiYTpjVdUDPecijjbwFC/dho9BdTaSvGUHqn4cCk1/Z3oZNcHhum6GbQ5Tz1OGucsyGW/BaXahvtv7yGYhQPXSI7mVVQebS94Z2RYMytVO1mJKIPYWWGW4yxmF18YNmnqxn4qQ5S4KENlYOe2gAawHuztGoBYeMu0N9GOY1MllsnjKmd2rJG8vBfONU4xhtBnvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10237.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:78::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Mon, 21 Apr
 2025 14:53:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%7]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 14:53:51 +0000
Message-ID: <2730ae6d-b8e6-4464-b623-b1dd6a2e3110@efficios.com>
Date: Mon, 21 Apr 2025 10:53:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
To: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <olsajiri@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, David Ahern <dsahern@kernel.org>,
 Juri Lelli <juri.lelli@gmail.com>, Breno Leitao <leitao@debian.org>,
 netdev@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Gabriele Monaco <gmonaco@redhat.com>
References: <20250418110104.12af6883@gandalf.local.home>
 <aAY9pcvYHkYKFwZ5@krava> <20250421095817.49c433b7@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250421095817.49c433b7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0244.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10237:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6e7879-dec2-428c-2277-08dd80e45499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWVpZUluVHo4WUtSRWM5VmFJaTIwQktkaXNia00vSTJ0a3o1VXNBeDlZTGNS?=
 =?utf-8?B?STA5TCs5MjhBcmd2YWlxRzVocVNrazR6b2luRTVValJUVVpGWnE4d3Z1Z0dR?=
 =?utf-8?B?dStYUFhRd1hJODNXWmx5VlVLaXZTelhJZ3NpZW00ZHEvS0FDeFRMcVhXblhR?=
 =?utf-8?B?VFhjWk51VFFROTJtVFBidDVDQXpkRlA1MTJQZGdReUhtR1VPVSsrdlJmUXZW?=
 =?utf-8?B?VWZ1Y1hrSlVrMkxGSUR2Q1pSSGFzcXlGN0JJOVBVMTA0bVJmNFQ5S01QTm1L?=
 =?utf-8?B?U3RRZ2RSRWNhYTViVjEvRGdhWStJNFN3NXBxMXBVbkZjcURpR1c3Y2tqOW8y?=
 =?utf-8?B?eGNndFNPd0kySERhSCthSjhMemFCNE0wUXM1eTNMZitZREZKSHhzbGwvWFpN?=
 =?utf-8?B?TVFwK3pQQ0hiQ0xMcDBOTmd5Vi9yaUtsR2lIQUxFYUR1UmJUYTNiOEZYY092?=
 =?utf-8?B?cGVEajU2UW8rUklHR1lEaEdjRWltSEFtbm0yZ1FadFA4Q25iMUZlK1dYQUN5?=
 =?utf-8?B?SjhSdlByc0Z0ZDEvT2kwVUU4R0FNRlNONTBYWEdnWTZHQXVSd3pYYmM2YU5H?=
 =?utf-8?B?U01PRTZsa0kybE1RWEUxUy8rYjFTZkZndHRvRGxLWnNEOXBxVWxKZWJxM0FY?=
 =?utf-8?B?NHhwM2pNUEZOUDEvYk42TjlwdEZuc1hqNStjcVpsTGlwT1pNeVRYcCt2N092?=
 =?utf-8?B?T0dHMkZFanJSeGxJc0pXc0hSaDlLZ2lUZUxCOXBXdU40S0NkbURvZSsvYmI5?=
 =?utf-8?B?WjlxMkxqSWFjMXV0WENQdW03NDdzNi9Wc3c0NlZyRWVITlJQRWNCV1NIU2dE?=
 =?utf-8?B?Mm5RUWs2UWxBTGRRQVcxMk1MY3k3R1pGLzF6K2Rtd083VTlDU2p5bGI4bTVt?=
 =?utf-8?B?eWZWdHRKNllIM09JaTV1UWNvYjVxWkozODVSRUFyVTJld29rSUpTbHBoYlpX?=
 =?utf-8?B?cVQ5RzZXQ1RwU3l1bUF4L2tJeTkreWszZis2ZkFCTlR5enRndnNxT3VKaXhD?=
 =?utf-8?B?NGFaQ0xYRitGcm9QWHpvaCtqeHFaTVdydjFGWnB2QkY1bCtKOG9VZ0JST1pO?=
 =?utf-8?B?OTFtWkhHOFRSM1V2aEZ2NHM1TDRQR2FUTHlqcVpML1Irc096dEl5UTFpNEJq?=
 =?utf-8?B?bm5XUlB1S0E3a29GbCszdDdtdnRCdHl4TFFwRFBQeHJrUHFHbWhSRjZyZk01?=
 =?utf-8?B?Umw0djRpb2JiVzUwLzV3anJKTU1PVlpoTlJRTTF4dXh4TktXNUVpc082YUlk?=
 =?utf-8?B?eWsxK3RBbURkL0x6WlhuMXdUT2szRUttMmNBcDBDNmVmWWkycTd5MnJHUnA5?=
 =?utf-8?B?RkszZlh6SzdrWXdrd1QzTnJpWnMwaVh3SmZ1REdIcVJ0SHZXbys5YWg2MFp2?=
 =?utf-8?B?OVJacU1peGhjSU1qLzl4UXo0RVU1b00wS0dXR0lBTXJtQS9KQTY4cVpRakRC?=
 =?utf-8?B?TmVRVFVsVDNZOHRpcjdiN2lkQ2hDb0t3VTJHU0V1S0VSOVUyQU5xR0RFNUQv?=
 =?utf-8?B?VzV0aG96VUh1U25mMzdLNWhFdEg4amJEc2l6WkdiYkNBRllFL09lOWVHbThz?=
 =?utf-8?B?SDh1dHpWWk8rd25qcTJndEs4RW9GckJOZHJNdTVSZGE4QkN5c3g0R3ZlbXJ2?=
 =?utf-8?B?VGlua2lxc2RoM3BSaEthTFVBUktYbTlYTzhFY1oxUkhXRmNvRjBZbkdZSHNU?=
 =?utf-8?B?ZzJxdlNMdkJWcXJCZllob0IvV0VicTdvcDFReHFrOFdjcWRIUndKd1VtZGdS?=
 =?utf-8?B?VWFtZUw0dC9kTktYMkFWVnVLdnp3T1E1a3d6UVdyYlRYVmNONTZwc0JDT0Nh?=
 =?utf-8?Q?2ZK/OUCSKZXHASGN6cafZsKo7IBD67Z6P2JDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2JqOWFGaFZ1bERGOUtSTlJPVHQrS2IvYjZUNkFNY21icTBrR0k2cFpadmxv?=
 =?utf-8?B?UWpiOFo4b2FScUJwWWtSbS9rSWZkbDJURS9oRHZmVTBlY2FZRXNSQWpNWEpY?=
 =?utf-8?B?TzBBN1BEQjVwVGVEMEpJVVk3SVNXNC8yK3NTWWVYankrYWtrT0llL2kwQVZx?=
 =?utf-8?B?S29MNXgxSDdZRU9OUGZlT3dYYjlWaDMzWldmSkxCck1mejhFRHNyT2t4WEti?=
 =?utf-8?B?NmlhaUtGNHBKN2s3b3h1N0RIbTg0bWViWlcxN3lYYlpnWXQ4bWg3ZThuNThT?=
 =?utf-8?B?QW11MnIvSnNuR3NtVlowYWZsWDkwTnpSYm5lbWZsNzBXcFZNWVUxcWtaN0RG?=
 =?utf-8?B?anZZbG1FaGI5UnVxS1BIMVlld0lWQ0dOSHM4WkNVdmYzTCszWGJRMXV0L0R4?=
 =?utf-8?B?cGthNzdpaWpvZXpnc0dJeTV1WFpMOVNqb2FhdUhudjVpSDhlRU1vQVEvdGxi?=
 =?utf-8?B?Nnh1RVZrZU5DTVJHMi9ZZzF3SnFsMjN1VXcxUHUyYmlseTFuUEdLZGcwdXVz?=
 =?utf-8?B?YmxYSU52RTZyZGFYbElPWVIyc2FaLzU5L2g0VDMrdTB5ZEpETUVUVDBwN2xW?=
 =?utf-8?B?MTZkckRqK2EwOUZnQldkYmtPMFB6N3VuWUY2SHUwbTRiUjNqcnJIUXBNemow?=
 =?utf-8?B?TEppSklVbjcxQWE2cEc0KzFRL2V0R281eUJQQlF3WEJkYktoMmhXWFMyODJT?=
 =?utf-8?B?eU9XSnRQeVFuL1JnUjhCT255RHV5cmtJbVRRVEtLTEt3c0k2S3NjTURxU3ZY?=
 =?utf-8?B?OGxSQUdLR25aUVJkRElsVXlQWXNuaFlYcGJxNXdjZGdmb2Y0YzJXMmd0Sldt?=
 =?utf-8?B?NmlYTU9Ic3NtWlBOa1lGbHVuTFVQTGhFcXdJUlZoNEVyM0ZZVnYyVkxYZzJI?=
 =?utf-8?B?bEFkK3gyWmZUanNOaVMrUWE2dlNSQXJteWpWTEdGZ1hsOEFqaVpOZHRGNHM3?=
 =?utf-8?B?RXhHV1VXU0ZqdUtjZEhTK0srdzdXb2l1aFlEMjJOZ0NXV1RKT3FNTnc3cy8y?=
 =?utf-8?B?R2JNMU41dkxnYm84Y24yaU12RkVCMm5YWUdHREpZRytNci9Bb0NQeVJVV3hx?=
 =?utf-8?B?cDNabFdkVzlMZ3VOV3ovMkQzU1JjRTVYdENJY3ZBT01oWXQwMUZERnNnS3c2?=
 =?utf-8?B?MkJXN2IzcVN2VUZwcER6UTZ5YXNLdW9qdjhWOUpYcVVsNVk5ZTFSZEVSTFFt?=
 =?utf-8?B?Q1RlOWtURlFVNnFwRmxpbTVsUmR3WG8yWUJ0SktZTnJwdnU3ZHpIZGYyWEpQ?=
 =?utf-8?B?Z1U0QjRabnpCTm5HN0RvYlAxd0p2QjRhQmhHWHhPcXZoWTlwUVkyazdFcUJY?=
 =?utf-8?B?QjRRdHRpWjVCdlpjTnRWRFlKN1B6dDQ1WkswdzRaVVlmeGY4eXJPMGtPMlNh?=
 =?utf-8?B?cFA4MzFUdmM1Vjg5bTRQUk5OYzB5TlFSZnUxZGpZVll4LzVTUVQrTDNKanJ4?=
 =?utf-8?B?bFhNUWtZaXNZVnYxSUtuSTNWV0ZvbjRQSHVTR2xvN0JlbFA0WWtBZUdWMkNY?=
 =?utf-8?B?NFI3WW1GQjB2Sk5GWWhoeS9NVmJDbGxZTVQ4WUcrWFdlNGRQRVFMTmIxWWU5?=
 =?utf-8?B?ZzhlVTdWQUF6WW9QWHdTanhPRFluTWZCMFBCRVRMMCtvYU5XWnFUSlZQbDdS?=
 =?utf-8?B?aE1lc2cyMUZ2S1NBUXJmckxhUi8ybnJpcUJGQzVwMGlvSFo5U1VmMDU0Rlp5?=
 =?utf-8?B?azFzUC9pbnNBMElJa3B0N3EyTk1tOEs1aENGa2FnOGptdTA4SGltNUp2cnIv?=
 =?utf-8?B?ZldLa1Q5UWNZU1lGT1gwc3VxMDB2OU5wK2V3MGVOUi9TTmFyUHFyZ0l4dUxa?=
 =?utf-8?B?dlgvR1dwTDF0dFFKOS8wNmZDOWZhL1MzZWIvNnF5WFo3Ti81bkZaRkRkQk0v?=
 =?utf-8?B?dFFIRHRkY05wa3YxWEtFRjBBTSsybTFCc3c2VjlJSmJmMzFURzc0K0dWdEsw?=
 =?utf-8?B?S3dQV0JRbDZEZmdpa05zTDdKNXdXWHRFNkE4QWh4SmFZUzMvYUxTcjl2RHBI?=
 =?utf-8?B?NTVIR2dJenU2SFVuempPZFFWODJnZUJCRk90UW1XZi9DNGRXc2lWcTJ0T3dY?=
 =?utf-8?B?eDBReEZGdFc2ckd2bFFCMVhWNW5RNlBCcmNBdG0vb0lKZVdHUVZhYk1oQ0s4?=
 =?utf-8?B?QnViYmxlTzFMLys4ZGV3dnZtL293TFBFZUFJV3Uwd0RnYmgxSGVVL3VscXZ3?=
 =?utf-8?Q?+YfZsVnk+qVVyceI0/p3WWo=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6e7879-dec2-428c-2277-08dd80e45499
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 14:53:51.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ckftoRn1fJaTd0CsV1NrKzVoig5lGpR6ZxaAAaBsnEtxN5ijUw8whdYFe2Kv2RBzChJ35V6EJfA3ea4nkYCiDJtWUXbNu5qFjUAtsfR73g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10237

On 2025-04-21 09:58, Steven Rostedt wrote:
> On Mon, 21 Apr 2025 14:44:21 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
>> hi,
>> do we need the change also for DECLARE_TRACE_WRITABLE?
> 
> Probably ;-)
> 
>> I needed change below for bpf selftest kmod
> 
> Thanks, I'll fold this in.
> 
> I'll make a more formal patch if nobody has any objections.

No objection from me:

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

> 
> -- Steve


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

