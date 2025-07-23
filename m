Return-Path: <bpf+bounces-64176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C15B1B0F6BC
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06E51CC7864
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D92F5C48;
	Wed, 23 Jul 2025 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kDJO7xSp"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2092.outbound.protection.outlook.com [40.107.115.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584772E9EDB;
	Wed, 23 Jul 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283252; cv=fail; b=HvGnU4FfRHNfdUjwvGNKStuWUSPmf2k3YheNMSOhW4Z/7B+i9H6RZDT17dh/O/V5kN9yNdTMVNKngRKZm/0Xedil+X9KUHQp2rARMTyX9XPLS6ULPqoq7clCNrtHpX4NIxoSPQEBZaB3n3Mf+61KYbaSKamNPNKDg/CjMpAhI0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283252; c=relaxed/simple;
	bh=f7aUGNsrSwcqI1z3KsTKFKZNZuNiwoMaGau6s2YjD9s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hAAI5jdsL7veF+IOTReUtgSkaXhI3eozlvpWnBaNklCfvE1nfpoK6elYQ9dY1/Wozm//oWay5+Io/arzOylL7mjzicgiozGegP14hLFJYY+sZpdTrekwYBxc5tZFXZYtNUSECp24uQzu8ZozrICyT4Jd0h86xh0vir7QS4ZDEEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kDJO7xSp; arc=fail smtp.client-ip=40.107.115.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHMTp3sWWStevnyKC5RS4UH/czzh7gE8mWiStt8n56/BdhOQHDEp9ifC0Ogo13fwsQnboopDKUhpeAyWgIoRWEwIvnZ6iw9oLdMXdr0XfFKgaDtLBCpMjpADTc3tzlXQac3fZt+axZtj3aqVqp5gKk6cN6GgEhlMXtxP9pximGxBUri+/0lr3TRXOiTLGTZTifMbTQ2uqhjw2qsLaObt4nLPfydFSd1YUmftMrlkX6+8S2P52QiFKOLSpxGyo2ERWTmz51D5xK8keTmXCtwjb2n0MGnfye9/tDCW/OIlzK5bynEqqi+lLkWt5BhXwReh/hcMkIJ3fansE7QE+EntpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSBoAhZZ21SDzPW1cvsFxs77O4tJKmn5GB+gOGIFd/4=;
 b=rBQAK7A7fOU98HM3u9CbuWjCaMk5kWPwJytf5TXMlD5FsdjhlQU9gsojmRulE/zwjQjvcZwNgx30+7xX8jOgF6O8nq8lhJxt/Yo3XknEZfKGY8ktyyliDxRL+aCBa3EzupmVz5HF1ttbRmCaMxWempsepHcRwFg8nO5YdLJXCOzHbhLqxU1j4l80Rx+Xhp2ge+I3R8WRhwwRlqmTe3tgwvcUI2t+p+cGHifePNRAIsRtiB5cY8nay0/VEDMomV+n+pjcGsPOoa1IHN3CLCBXy0ElquNuMYo4f9kW8LE0RUIzwc8hJ4tgNVXPUgdVqNO0RCcu/hic4ZX4i/vuhM3k3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSBoAhZZ21SDzPW1cvsFxs77O4tJKmn5GB+gOGIFd/4=;
 b=kDJO7xSpdyJiUCkRykkc1yIQsi4Hb+Z3/SvdLZ8RTmVvhNmPZWXkucKJIciX58oGpoSvkvhI/x8PrVtsT05panat53NwN3qfNz/Z9Z9HaaCSTlnv+EembpHC/MJo0+VyH9QMCwsxu5rU8ioxV2DFpDftvUU8j3A0QTJanw3re8enaCHJlfu7RVomJBeo+u7LvbT8xoxYH13+dnDdWImE0hlRP5YHSn5xjFq8do+cEUNA8IdlAiG3V6PR6clJfxGvmjwJP+AJyTQGpfKon7Fy/6xQKLoWOBJj8RVZTqVtP4/RAGdbihj9Tk214I9lITK31FpKZ1ymwo/bg9l833JXaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8279.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 15:07:27 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 15:07:26 +0000
Message-ID: <4c09177b-119b-43b9-8d86-09d4af93c283@efficios.com>
Date: Wed, 23 Jul 2025 11:07:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New codectl(2) system call for sframe registration
To: Indu Bhagat <indu.bhagat@oracle.com>, Steven Rostedt
 <rostedt@goodmis.org>, "Jose E. Marchesi" <jemarch@gnu.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
 Brian Robbins <brianrob@microsoft.com>,
 Elena Zannoni <elena.zannoni@oracle.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
 <20250721145343.5d9b0f80@gandalf.local.home>
 <e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
 <20250721171559.53ea892f@gandalf.local.home>
 <1c00790c-66c4-4bce-bd5f-7c67a3a121be@efficios.com>
 <20250722122538.6ce25ca2@batman.local.home> <87jz40hx5c.fsf@gnu.org>
 <20250722151759.616bd551@batman.local.home>
 <ce687d36-8f71-4cca-8d4c-5deb0ec908ad@oracle.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ce687d36-8f71-4cca-8d4c-5deb0ec908ad@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::23)
 To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c182cf5-3133-45dd-4cfc-08ddc9faa2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXJTL0lLVTFVbmpRUWsrNFJwc2JCMEVnYUhkMWJESWdhV2U3bkJ6OG12YlFy?=
 =?utf-8?B?YURBa3F5cmlKWDZXbzl5a2dQaG9rZklnSzdMNU1vd1pnZ0Qwa3R6eTlHL2li?=
 =?utf-8?B?TDRia1hRaVpyczlOVTFkQ29PQlNCeVhnamd1RkhIc21HN3VkRWV2UHJ0YnN1?=
 =?utf-8?B?bjk3NjVDMWY0U1RJSitNSVJpVTU1TVNZWVlHSkVGSFEzeXVHZVB1dE1aVVdY?=
 =?utf-8?B?c05xdFhZMHU4b1RyTXFlemFLc3lqLzlydnArajAzam9vQU9DdTVWQnVYOTVJ?=
 =?utf-8?B?QUhUcFZjd0xERmtZa25XWlIrR1VlbDZCeU1rWDdtWjc5UlZpSTZZR1kyd2Yv?=
 =?utf-8?B?Tnc5QURSaGpTNGxMK2hYUmhJT0dzbytYNFJqK0I2cTh0Qkp5S1c4VzlOS2lK?=
 =?utf-8?B?S2dCZGJoV1pXUHFsZHdXTEVzK3FzKy9HRHBWeXloNFBXb3p4RDljaWlnL1R1?=
 =?utf-8?B?T0F3WlJRTVJKU3RzZWRtbWtSMXExZ2JkaUMybUVFQzlLM1RlWDBNZXdEMlNw?=
 =?utf-8?B?V0ovaEwzWWVnWktYYVYvOEpWeEdrOGhkdlhzUkxqYmZ5WnVzd0FObFJEbmVI?=
 =?utf-8?B?YUQzVWtaRFdvbXdpbWVDcDBxMVpjSEVkcjBBSWwrWEE3UFVLblkzOHJvWndU?=
 =?utf-8?B?NU9JR3pDWFVxU1hYcklMa0k2UkYyOHV3TFpHa2ZPTjV2dVBqSWhndWdrRTk1?=
 =?utf-8?B?ek9rWlU0T3ZpU0pMRXNFZGVIalVxVFZqZ2EvTENQSzU5Z3RZbm8yNjdPazVY?=
 =?utf-8?B?M21URnNCRzBhSG96akg1VjRmL04rRXlhd1QvK1RFc0YrbGt4ZEpUUFd1Y2Ft?=
 =?utf-8?B?MGorVFd4bndDSjg3KzB3dWViRkNJWHRSZFJ6eEw3QW1FeTA4QU5DdEhUNHZm?=
 =?utf-8?B?MjY5YWNKWnBzT1dZYVMxb0VDVnhMazRKUjAxUDlnVzVnMFlJaHUrZHFJTmZx?=
 =?utf-8?B?QzZDdVVHSHhuZkFlYnpQbm5ZV1h5Z3V2RDJkNzFVeXFQbzUrSXJlZ2dZMWtH?=
 =?utf-8?B?RVRQSmdWWEJLR2VnRzVWQ1ZBN1hZVnIvYzRid3ZSR1Y0Y2JLRSsxaFdKKzFo?=
 =?utf-8?B?NHFwYzNiSWJYRExEclg1WnZtbitNNEJJWU1vMWZKc09rY0dnZkJFaWpzK0Y2?=
 =?utf-8?B?amUyOC9lMitNZDVtdkpvSEJ5MEx3U3RTQTNWankxK1lzM3EzdVp0aU5xdkhj?=
 =?utf-8?B?QjJiaFFCZzdJY3JXbU16LzhDQUdXV1RSTGpIa3R4NkoxWU4vRXhqZDY1Zmxl?=
 =?utf-8?B?a2FEMkQyOEdyVUpCMExoS21xNm0xZHo3aEZ4aTJpaURKd3RlZzNGcWpEZmRo?=
 =?utf-8?B?WlFwYmEwWHV2NjI1UXFXS0sxckV6aSsyaGVrZ0dnbE1DMjN1MXVQaDVKT3Bx?=
 =?utf-8?B?T3h0VTlwT3FNdDhQd2g2YVdLMkZ0bUs4bW0yREdobk1XTGNvNzhGaGt3aWNF?=
 =?utf-8?B?QVBNMGU5UHE1OUp3ejRROTRLdTlMVUIwRkNueXVLMjkxN2diOVRhaFQvRXZr?=
 =?utf-8?B?MmJuaVBIYmRyUUJKN0x0T1JZRWlIam44N0lCQ3Yyd0pkenp2d2ZoWWxiY0dH?=
 =?utf-8?B?RWIvd0R0Nkl6akFLdm85eDRpTnl3UGhVYnh4cFhyY2tKYzJUUzhSZkZRMzZH?=
 =?utf-8?B?QTVZa3MxVmhJNk1QRWlXQW1SeDBBb0JrWTdXVUtNZVBySzFRVkl3Z3hXSWNi?=
 =?utf-8?B?S2F5aU4zUE9aTUVLWE9oK0FydVNoMi9qZWsrOXRJWVdnblVCbVpDMkdtaUFp?=
 =?utf-8?B?eVQvVXdDQ0NJdWIzaWNERDhrcmpaQ01qMTRrSExDaWd4RXd2NkJEdDZ2U3RM?=
 =?utf-8?Q?q3P7OeBPba/BkODLInNgPny7CrtGFpDiZebAk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDlML2tvTVdHRDQ4L2JuQkwrSmJSR3RPOHg2aHJGWlpEUEFLa3RValBpaEpM?=
 =?utf-8?B?bWs2VThyazQwS0IxSDdtN3NXU0hlV0xDa1BhMkRmYlBtM3U0a3NPTWVtNmVi?=
 =?utf-8?B?bklZY1BCUVk3MDNHdXc4T1NhSEFFcTRiaDFsVXVjbEo1dmN6M1Z6dXkzWEdv?=
 =?utf-8?B?a3JlRUR0aVE4OG40NTUxNGdWUmkyYitxTDlINlpjV3piZHFMOE4rMFROenFz?=
 =?utf-8?B?dHBmdEw4SHY2SFBkeDlHMktmUW1mVldNWTBpcXZJSzE4V3BEMktxSjZDLzNp?=
 =?utf-8?B?R0J1MHQ5b1V5MEtSQ0NtbldxTUFJSjNVL1U3OGhxODVmN3paUWhHbGpCQ0JP?=
 =?utf-8?B?TDkvU0ZOdG9lOGMyS2M0TC95MUJZK2ZtY2N6Sk1ic2V3UHh1ZklnREdqUFMz?=
 =?utf-8?B?K3JXdDRCWUhUYzRFMVdtajdNL3BMV0grbFJRSFFUZnYzSVpSb2pTT3NrZ1Rl?=
 =?utf-8?B?Q1A5ZWxaNk53YVIrZGtUcWtuWUwrSE8zODVheEVvV1N6YWlYZkVzMEl3NWpn?=
 =?utf-8?B?enVRaTF4WG9tMldMZW1venNGamRrSnBQQUgya3gyaURtN2NtWkcxak40OW1Y?=
 =?utf-8?B?eUtwYnNteXNKd1F1Wjdnb0s4TDV2Z211WUp2aDlhalo4MnQzZGxrNTQxRGtI?=
 =?utf-8?B?Q1lyR1M0L3B2QklCa2MzUzBsUUxDYkwyQkFzZ0VodE8yV1FVN3FySnFWSDZw?=
 =?utf-8?B?SlcwL09IM0d5Mm0rdm13Wk95ZWZIV2Fadm9HdU04bTJoM2VaL0xSZUJXQTdM?=
 =?utf-8?B?VUZUMG45M1k1c2xRZzUwa1hOM0RicGpocDBwdEwrWXhkajRkN2ZOUWNKUFpa?=
 =?utf-8?B?aEFwREtFSUFBblVUYksxWWVqaCs0UmpNaTd2RDNkVEMyR0NYMWNpZkpyK2xq?=
 =?utf-8?B?NFIyWWFZTE9tL1M1ZzI3VU5VL25QN1NFWllZRm5rWmRmVlhhWDJqU1NoMmh5?=
 =?utf-8?B?WkUweUVyWVJsQ3d0SXJlZU5peUh4L1p4bFNMVUhuaWZRY2tLZjUxTUh4a3dJ?=
 =?utf-8?B?czVEbDQ5aXdWSWhMYzJBbWxZM01OVnIyN3VTSGxqcDlvUXFud2JXOXN4WDlx?=
 =?utf-8?B?M01xczU5VHZoUWpOWk1PZENuS1dvV3o0T3lLQklySnpHTFAwTmxZeHNMYmha?=
 =?utf-8?B?VkpiY3dTdTZQSWEydnRvbkFNRTJDMkpOUXFvd3lvRXNXMXFKcWd5VG5pR3dv?=
 =?utf-8?B?OFJGNVJLZXJGL2pCSjZncE1qZVdIaXdQMmw0N1R6dkVTNHlSQTVTTlJMdVJY?=
 =?utf-8?B?WnllMzc1MU51N3NtQmRtVVpZUlY5UnhLVm04d3JhZXVQM2pFRXUzK0xwNnJm?=
 =?utf-8?B?dWlFTm9va0VQbTJ3TGN6RWc2YXMvOVoxcFhwTkt0MU5lUUxIZzdDbDFTSU1J?=
 =?utf-8?B?TUVya2RIQ0V2dFlnRmlGMHljRVNZSzArNGNsU1NzdGt3RFRJM1haUHMvcFpp?=
 =?utf-8?B?Mkx1NUhLOHdVUVArNWlHbnh0cEh1R0YvNmRUaDFiQmRZZDNJcGU5eGVyTS9H?=
 =?utf-8?B?ZEorc0N1ZEpyK3FTSVdJaS92aFhQeUtKd1lqZUVLejhpYktCUk90b1VXUkFE?=
 =?utf-8?B?cFBmbDZEMWl5UUtQTEVzaGlCN1pYb2xxM0lMNzlBRFA0WFN4c3VxUllHTU5r?=
 =?utf-8?B?Z0krS3hRRCtFZHJwUlY2MlhGQ2kra05OZ01POHMyWjQ2cDdYRjREeFZyN2sr?=
 =?utf-8?B?cGw2Q1FQNEx6UFJKU2EyT1JxWFlabCs4L3lIcmFZQm5PSlZETXU2UnR6S2k1?=
 =?utf-8?B?aWlCVHNGN1M0ZUhmakwxbFpSb05yQ3dudisxMnBvSndtOHFoN0Y4cnc4OVZy?=
 =?utf-8?B?Y1Y0QnRuVmdUS0w2cFF5Yk9GU3p4WTJtYmZZWFFqOTVVcnF1aVRuVmZNaTJH?=
 =?utf-8?B?dCtRQm11NmNvNWhsSkRQV1htVDZiWGNmdXM1RlVGbGM2TzQyeDZhdEJ5YzZ5?=
 =?utf-8?B?YUlFRktSeEtkT3MrenFZUlFxRzVCMkxyMUh1eTE2YVEwUWxJNFRSV2Zwemo5?=
 =?utf-8?B?WUFwUUxvcTVzUnljN0Zqb1VTd2tvMXdyOURGMFNicTU3eEJ6VjlmVitiUWxz?=
 =?utf-8?B?WkV4RXFHWHpWV0Z6VVorTWxaaVN0VWlTYnAzQjlRVUVRMXQxNlZqTk1tNjdR?=
 =?utf-8?B?am5maGExR25wNjltS0Z2Zk1SbHlsUjhrUU5STy94K0V1RUZPOE0yNVFzM2xt?=
 =?utf-8?Q?kSaFY9E4a5JWqctIc0l5XZo=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c182cf5-3133-45dd-4cfc-08ddc9faa2ba
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:07:26.7265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIaFsdW6OvK3iBjo5WzUVCwVZIb1r7jDeQBS21NNrt+ycZzbny6cDGcxFE8of66H7vyMd0h6GfHUBQgd42t1yjv1218ai8n61I+m6YEa40c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8279

On 2025-07-22 17:04, Indu Bhagat wrote:
> On 7/22/25 12:17 PM, Steven Rostedt wrote:
>> On Tue, 22 Jul 2025 20:56:47 +0200
>> "Jose E. Marchesi" <jemarch@gnu.org> wrote:
>>
>>> I think glibc could "register" loaded SFrame data by just pointing the
>>> kernel to the VM address where it got loaded, "you got some SFrame
>>> there".  Starting from that address it is then possible to find the
>>> referred code locations just by applying the offsets, without needing
>>> any additional information nor ELF foobar...
>>>
>>> Or thats how I understand it.  Indu will undoubtly correct me if I am
>>> wrong 8-)
>>
>> Maybe I'm wrong, but if you know where the text is loaded (the final
>> location it is in memory), it is possible to figure out the relocations
>> in the sframe section.
>>
> 
> (FWIW, What Jose wrote is correct.)
> 
> Some details which may help clear up some confusion here.  The SFrame 
> sections are of type SHT_GNU_SFRAME and currently have SEC_ALLOC| 
> SEC_LOAD flags set.  This means that they are allocated memory and 
> loaded at application start up time.  These sections appear in a PT_LOAD 
> segment in the linked binaries.
> 
> Then there is a PT_GNU_SFRAME, which is a new program header type for 
> SFrame.  PT_GNU_SFRAME by itself does not trigger the loading of SFrame 
> sections.  But the .sframe sections being present in the PT_LOAD segment 
> does.
> 
>>>
>>>> In the future, if we wants to compress the sframe section, it will not
>>>> even be a loadable ELF section. But the system call can tell the
>>>> kernel: "there's a sframe compressed section at this offset/size in
>>>> this file" for this text address range and then the kernel will do the
>>>> rest.
>>>
>>> I think supporting compressed SFrame will probably require to do some
>>> sort of relocation of the offsets in the uncompressed data, depending on
>>> where the uncompressed data will get eventually loaded.
>>
>> Assuming that all the text is at a given offset, would that be enough
>> to fill in the blanks?
>>
> 
> Yes and No.  The offset at which the text is loaded is _one_ part of the 
> information to "fill in the blanks".  The other part is what to do with 
> that information (text_vma) or how to relocate the SFrame section itself 
> a.k.a. the relocation entries.  To know the relocations, one will need 
> to get access to the respective relocation section, and hence access to 
> the ELF section headers.

So AFAIU we have three main scenarios:

1) The dynamic loader allocates the sframe section, and possibly applies
    relocations before passing pointers to the start/end of that section
    to the kernel.

2) The dynamic loader only maps memory for the sframe section, without
    actually populating its content. It would register the sframe section
    to the kernel by providing a pathname and offset allowing the kernel
    to find the sframe information and populate it via the page fault
    handler. In that scenario, the kernel would be responsible to perform
    the relocations. Ideally the sframe layout would always contain
    offsets that are relative to the text_vma base, so the kernel could
    easily do the relocs. Is that the case ?

3) Variation on scenario 2: the sframe data is compressed in the file.
    The page fault handler is responsible to uncompress and apply relocs
    if need be.

Am I missing something ?

Thanks,

Mathieu

> 
>> As the text would have already been linked into memory before the
>> system call is made. If this is not the case, then we definitely need
>> the linker to load the sframe into memory before it does the system
>> call, and just give the kernel that address.
>>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

