Return-Path: <bpf+bounces-64088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0694BB0E378
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC01173A65
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D97280332;
	Tue, 22 Jul 2025 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YqC89PEZ"
X-Original-To: bpf@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021102.outbound.protection.outlook.com [40.107.192.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33994203710;
	Tue, 22 Jul 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208814; cv=fail; b=LHdchgzXqpUWNiKM35mcEHYE4FHQzjDz2Y5ceH97fz1DikApauLw2OVkDlZJJ2djaw6Npvlz2+tNSwB3lLW/HQ4haYZSBfcMWM7p2kEdTVpeUw/kyTNEXKPqJkYAIjCEkT+I5sBcHCmcO0JYBlMRziUZ8uIhK/1tsN5kN45yQXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208814; c=relaxed/simple;
	bh=S9mpLFYpvjvo/RE+y44aYQNKh4ehuP1QWJ5SjCxFByY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PdcUzBgZU3p0NFuvYeAQKbmy3GUBlBlSkmvIvX0rmnv6gLhF+FHD4xVSdiuvPBG3xcicv8nbl2Ar0mO27nMWCym6Fs9EvPUustLUgDApRQCsZAxPELPulSnAzXYvVuTS+i7hnWUVTw7q+CrYFHCtsLpnX9xsNUp5pppM601mrkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=YqC89PEZ; arc=fail smtp.client-ip=40.107.192.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uu9oYiqwn7xEl+6FCtOxBqs64zNq6TLsBLo0F1z8vBjfSzBYJfbBrVzV+ehbqmlZJac+9abEcPu8aFb99vw4ncct+s6aBnjAIGvJGrGUsz2/m89fBbVCO8Z8dJEyzaS3LV85pHehnpC9ImPTz1zNc565zxxm8+gngc/IkOeQrFimNsiLSWn06QGdVUOXSHzWSlGq5h+yUuZp4Bxkr+talJHuTYx/TDgCAcLAxFvUa6BIXlqhX8qV8oGKmItSjPe3WlrLa4c9LPPxEiduvGRGSg0asYyzxd6yCQlqR5aHP/ydu4VsGxLjpu3637LhHaNlfIAqYosJFurrFJjNcYr23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsqMWcGEHicHej9dQZYs7jLW/U3Tr+5lA8mdX9UKGS0=;
 b=vi6gl8ZqoemvWDR0oTew0HytwYEGDiA4xsYXU+R24rN43o/XryGh+8MbTeRYly3mivnQaK7lLeaqdMCbBZJ2ZDp6BK6i7RPTaCFA2rmowqHNRgGiBzXcaspEhYCju9LQ5aFZlQ1Ioi8bJchfCXkmVUUkPcb4mQ2YYb+l876gtfyZ6HEg5wCfqlucVZJq9f2uVEM5lCzrMr2xZC0NRUXXtD6v+ULrI20BdDijFEE4KblsqzJUHYQs3Jdtk0JIzsF6Joes9PTdqJuwkNV7CaY6HlDC/CQLaiGZi/1c2SVfoyaV7Lck20GRBmSz3gBD4bFVwNf3m+Cfl/MymCo5a6cr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsqMWcGEHicHej9dQZYs7jLW/U3Tr+5lA8mdX9UKGS0=;
 b=YqC89PEZh8UvDoxkFOQCuqBUzx/uuC/ghmPJGcX57C3XJjIymUbMeqJmt3xxTf1aKt72BwTUJCg0LoJ2dU2ElTVlM+fTM8fQsH/yttQi89QNh1SI/8ZiWm2UoGr5PEpN/uqKoQLQo6m0eaxDnLx4WSsGTYSPsQUcoFvXjk1jkVjXDuQibYDVHWh8kP7ibAuoK64Hu3nfQFZHQsl7VHJa4GBg3hy9QX/gfOvpR2qPQ3Ltx5oS0GSzuPImtkWxN6NXeIKQN75mNpRq51rwuQ1YKj5TAcXPLpSWDufvHELNnHvFxiX0Zuhzfhnwndca0Nerl1VqmhzLfaga/uy5he46OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6653.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 18:26:47 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 18:26:47 +0000
Message-ID: <af021bce-8465-467d-b88b-8d45d11e0f0a@efficios.com>
Date: Tue, 22 Jul 2025 14:26:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New codectl(2) system call for sframe registration
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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
 <20250721145343.5d9b0f80@gandalf.local.home>
 <e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
 <20250721171559.53ea892f@gandalf.local.home>
 <1c00790c-66c4-4bce-bd5f-7c67a3a121be@efficios.com>
 <20250722122538.6ce25ca2@batman.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250722122538.6ce25ca2@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 317c4955-1469-4b3c-0aa7-08ddc94d511b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjNZOWREUkVDeXl2bTJSL25LZ00wUUlpR1dWREpYNVFTVHNham9ucTVDWTZU?=
 =?utf-8?B?Sm1OaGZjN2U0bzNxNHlhVytyUFowNkM3RnBmZ1JHTzJpblFsbldPY1NycW9U?=
 =?utf-8?B?eW12QjZrMzFPVVpLRy94M1BQWU5nSXRPKzMyYUgrSWhyZEFVRzhCZVlFK254?=
 =?utf-8?B?eVFLcTRWZWxaSTBwTXZlcm96dEdRZXg5NjloNW80MUhFT2xLZTZBSzN4VFVG?=
 =?utf-8?B?MnFIa2lmM2lPSEROcG91RVR3b1FzSkZWZVVYTzRQSzQrSVZDSnFEVXJ4MHhh?=
 =?utf-8?B?YVlhdjhSTEFoT3E1VnQ3YUtzVldUMFVDNDBXakVQMkZxWldoOG5DbytWOWlq?=
 =?utf-8?B?OWJJWlkrM0ZBZWVaV3ZXUDJqcXRyYzFGUVF4N3I0M0pVUW1DMUlMUnBoRnJK?=
 =?utf-8?B?eWxZT1lnV1VLQStnOXZRV3gxd1BLTXdoUHV1YWRVRHpmZVhyOUhVdHdNd0kr?=
 =?utf-8?B?Yno1T1FxSENOL1B1V3JiVDBUaUtjazBjT0N6dkd6RHRGY2o0bEJHWGhKK05R?=
 =?utf-8?B?MVNzSmE3WUFJbi8wMkwzeWlzdXZMbnpVRXhGaG5NODg4WlZsREM4ekQ3WVdQ?=
 =?utf-8?B?NnFWVStwcGZKbDI0Vlp4d3RIU00yUnZGRm4yOUVmblpzNW9YTW9zcjVSOTZM?=
 =?utf-8?B?ZWpPem5FbWtCa2N0d1Z4QStLL2ZDOStTemZEbXpac0g5N2l1NU1TZ21wZXZx?=
 =?utf-8?B?YjBHbk5vQzFaRzl3ZUYyWHpERXdOT1oySzFzK1Q3UE1ySXNwQ2RGUUN0U0RB?=
 =?utf-8?B?Y0hRQWJLdnpGWnlmSTBOSmc3Ym9Sbm5QdHFSS01ZSnhScWJpU3MrRzlkWHZO?=
 =?utf-8?B?ZldnQi9mNlZ6WHRQNWg4T0FVK1VlVnIrMTdPdlZhanFHajdjSlhqdmhqZnlq?=
 =?utf-8?B?WVhES1BOTlBNZm1UeGhackNqazQ5WTkzVTQvVDB2STRhTjY2OXpNOU5mQktK?=
 =?utf-8?B?V1EwTmFERk45eCtqZzgwcWcxa1JvMWkvSEFNUFVHSWNLZ05hdmM4RGU0M2F2?=
 =?utf-8?B?QzZXQWExRGg3R3Eva3VlMGF5ZmVJcERGTElqeTY1WG5ublNQeTdMdDQza1I2?=
 =?utf-8?B?YnM2K1psRElFYVdTMnphcXROUWdPUnVubllpZlVIT3ZPMk1nTWZURXk3SHVy?=
 =?utf-8?B?ZnA0OGhGUmZKaTQ4MXFqdWFWcG5FMmx4WU5oQk5WS2hqSkdMMVVVNmpJL29K?=
 =?utf-8?B?NnlrZ1hCekhhR2ppbU45NE5LeElESklXb0QweEt0TkFUTUpGMmwxSFQweHha?=
 =?utf-8?B?aWlVLzRVZ2xWakducmg3WFdOaUJXcGFHWEtMTGVWd1VFMG4rYWRHOWYwb0pK?=
 =?utf-8?B?NzNvdkI5V0FyMmtnMzJPaVlYa2d3eG4zS3NXL0pubE41RlJHeFVwQnZlc2tz?=
 =?utf-8?B?d3FoYzlOeUhaeTY5bmxldW5UWC9IK01iUCtHTlI2TlBVNTc1Z2RtQVhWSzc2?=
 =?utf-8?B?ZTFzeVJxam5MZ0lDa2Jhbk5kUDAzOWc3czhlWXhzU1hRY2pScmNWY0VMUlkz?=
 =?utf-8?B?VDgzNmpFRHVYNEh1eXZhcy9RcWNvQ0EyRzlKeS9zWHB3eGU2TXRKTGU1Sk4y?=
 =?utf-8?B?cmNRRjNDMUtCMk13bXFUUnI3cXZqa01Ob2RjR0syTGwxVG1kRjAzWmQ0UG1Z?=
 =?utf-8?B?NmNQWTF2L0cvM0tONXF2dGkvN3Z0Um45NUFtdXE5YlJyT1d6cCtyaVM2cE9H?=
 =?utf-8?B?SnZTWFRWQ0dyNitIOXg3cWJLUlZrQm5wUHR1SE1LRE5lYjJUTFVDdkh5YkRl?=
 =?utf-8?B?NnNrb2thWndvRE1URCswZXNiczkzSnRETGFraVJpV3ZvN2JpNmQzbFFTSGV5?=
 =?utf-8?Q?tkOXtxXIWJFiztwVifhNwC/tpDlt0GNbjJsj0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEhCTUdOa2lKUkJpb21jVG9pQWxVbnhQYnJQZTV5MlVXQnQ4WnFhMExSSVBO?=
 =?utf-8?B?LzgrNExzaVVyZDErUEhpSlVBUnZHTjdXOVFJVDRjREh4VkxXbzFLZmxrYVgv?=
 =?utf-8?B?bHhCYU1rYm55am1RcDMvbGdacnl1Sk9saEYzUTI2SnBUWjRKWllCT245T1lj?=
 =?utf-8?B?dUJqR3pQOFNSbVF1NWdObnB0ZGNPSFJveXphdmpYZ2VpU0tyNlh2Rk1BSksx?=
 =?utf-8?B?Z1N4NXE1TkJyQjNxTjRlVWliZG8reUx2bUFaOHBZUkg2ZDkxRXJUSzQ3R3Zi?=
 =?utf-8?B?TXJFM1RtT0Q1eHdwK3JuVWljZVVZSVRSQkw2QTlDOW14cHFDcmtJWWlWbjZX?=
 =?utf-8?B?TVR2em5UemtzMnJPRW50SkNzTzQrdEVBczk0di84TjdjWEZITGx5M21LcnZI?=
 =?utf-8?B?Z0dhd2VMUG8xWU1qMnI5cU1SZU0vMm5xRU9FTGc0ZEFhYWt2aHgrSDAxYTZw?=
 =?utf-8?B?VW1jTzJ3YUEvM0NsMThxRENMaHFKNGRJVXAwTWdkMmtoMWk5akdSZkhHYmND?=
 =?utf-8?B?a3Q0NlgrdlVSWldNV3FSREtXL1U0NmN0alUrRnllbnBIczN6Z05lYjhVNk1B?=
 =?utf-8?B?V29KTlhiaHFUYVRoMy9aRTlxdm5CZFkzTG9lYlIybDRDZlArSzdiMEh2RTNL?=
 =?utf-8?B?OWxiemoraUZ4eDZiZ3MxOTc4MUJwaWFMaTltZ0tabEZFUnd6dGYvOGg4ZnZ1?=
 =?utf-8?B?L2lZZmIwSk5wSXBrbElxRm9EK21wOUV6NGRVWWI5U0ZxUVpDZnN5MDlWNTVJ?=
 =?utf-8?B?WSsremlrUjdCc2dVV012MDZMRE9zY1ZkMVVmZ0diaXU4aDd6bmFTSE5WcEQ2?=
 =?utf-8?B?elcvVnozTFhMYkJ2VEpSdXVlNCtiWVZlWWNWd0pqZkl2MklObXRMbXpkVHor?=
 =?utf-8?B?REFrWTY4NGJ1c2pURUFQQndUd0dWMnV0b09WcWhSSHdyNy9JbE9qMFNkcU45?=
 =?utf-8?B?Z3AxcW9uZG5MdmYyNW1FcWNuU0VMS3lWQ0tRWG04bUU3VkVzdlBiaHh3TjMv?=
 =?utf-8?B?WmlSNkJQdUV5TDhqZDJ4akM3R1gzVU9MS1hYZWxzQlJVU1gvdFRON1A1Ty94?=
 =?utf-8?B?ZC8zNEFZRkZRd0M2Y2RGWldlZDdIVmphbTkrOWVsall5MFBPTm1RYU5hcm10?=
 =?utf-8?B?SGk1ckdiNkk5V0NqNlNsY3BwQ3d2cVpNaUU4L1l1cHQxVjJPVVFhOUFWYUJs?=
 =?utf-8?B?ZFc3MVJScU80RldsVnNiRXdUcjJNbzhJblI4LzZGaWRES3JHT3MxQjM3Y1ND?=
 =?utf-8?B?MkJ5b2RGRFNoRTB0b3RobHZqMmc5OTFoRmQ4blJsc0xrZlU3Qmx6ZEY5NWoy?=
 =?utf-8?B?a3U3aXIzdGFOOFFTWno2dEcrekVybHBud3o4RHQxcjEyV0tsWHRieGZ3TlFk?=
 =?utf-8?B?cWgrbnNEb2wrcHd6b3BERnIvRHBOdHYyZmtJZ0tOSnZEKzZWWE9oYUZ2RGNF?=
 =?utf-8?B?dmxleGNWb2RiU2ZKclhuUjlGUDgyTmRPZXZoUzE4VjRDY2hVOUJZZXQwL29n?=
 =?utf-8?B?TDFiTmNxOUNtTWczNmx0clNscWlBdWh4UVVZV1JURWJRZ2JMZTdqNWZobjNE?=
 =?utf-8?B?OTdPSnNPTlZUTjJsUEc2WlF4UDJ5UFd4MFBGS0tNYUY3ckZWdCtLU2hWRUQ5?=
 =?utf-8?B?MXhlSXNaMmNlTDJ3NHBXRnJCRTN3UEdmWGxzaG1oSWJSSmhmTTVKSkl5ajd4?=
 =?utf-8?B?RGJYRXdHdmY2UUZuc0pTZjJhM2RnTjBKc25pQmY2SDlFM1pFd2VQKzNwRjB6?=
 =?utf-8?B?QUl0Zk9xRm9xZExWbUVVWGVrc2pOb3NFSzk2d0hOazErWHI3WTZwTGlSZmI0?=
 =?utf-8?B?MVVkcU9JT0JUa0FnbUlzTE5ER1FsU01ydWxTSGVkN3hSMUtYOWFHdHIzUEVj?=
 =?utf-8?B?ZStuRkNlK1BzbTR5SlBNcEJlSi9YS0s0WEg5MTBnK1NINFBNNjgrNUZqVDBh?=
 =?utf-8?B?VEVvck56WU1IR3J4cG9GcFlhZDlZN09oK013ZVpROVd5T1dYM1BrdnRaYWl3?=
 =?utf-8?B?Vk1OaFpNb0d4bDIrRHQyYTdXdG9VcW45NW1WYWl3YVVrRmtCVVF5Zlh6dUMy?=
 =?utf-8?B?Rmd3aUs3eDM3bHQ2V1lURU96d1E1eENySzJNZEswOER4UjZiazFtSjJuakJi?=
 =?utf-8?B?U0ZKZDZPaW1XM1hZc0I2dzZSSWRGbDZNMWdjRVh0MGtqOEROQVJXZWxoZmox?=
 =?utf-8?Q?KGCKO721Ln8/UDncux9dpXs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317c4955-1469-4b3c-0aa7-08ddc94d511b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:26:46.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKuc2CYmNqwf/ZaYHeJ7/O0ESgKsZjP2oNwMHsOU4nfJYM+OoMRrxjxyd9n/GVqB0tV9siQHC4Nalvwry+2l5vU9C7x8oTuc8gk2KI8qy6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6653

On 2025-07-22 12:25, Steven Rostedt wrote:
> On Tue, 22 Jul 2025 09:51:22 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> Here's a hypothetical, what if for some reason (say having the sframe
>>> sections outside of the elf file) that the linker shares that?
>>
>> So your hypothetical scenario is having sframe provided as a separate
>> file. This sframe file (or part of it) would still describe how to
>> unwind a given elf file text range. So I would argue that this would
> 
> No. It should describe how to get access to an sframe section for some
> text that has already been loaded in memory.
> 
> I'm looking for a mapping between already loaded text memory to how to
> unwind it that will be in an sframe format somewhere on disk.

OK, so what you have in mind is the compressed sframe use-case.

Ideally, for the compressed sframe use-case I suspect we'd want to do
lazy on demand decompression which could decompress only the parts that
are needed for the unwind, rather than expand everything in memory.

Pointing the kernel to a file/offset on disk is rather different than
the current ELF sframe section scenario, where is it allocated,loaded
into the process' address space. I suspect we would want to cover this
with a future new code_opt enum label.

> 
>> still fit into the model of CODE_REGISTER_ELF, it's just that the
>> address range from sframe_start to sframe_end would be mapped from
>> a different file. This is entirely up to the dynamic loader and should
>> not impact the kernel ABI.
>>
>> AFAIK the a.out binary support was deprecated in Linux kernel v5.1. So
>> being elf specific is not an issue.
> 
> Yes, but we are not registering ELF. We are registering how to unwind
> something with sframes. If it's not sframes we are registering, what is
> it?

I am thinking of sframes as one of the properties of an ELF executable.
So from my perspective we are registering an ELF file with various
properties, one of which is its sframe section.

But I think I get where you are getting at: if we define the sframe
registration for ELF as sframe_start, sframe_end, then it forgoes
approaches where sframe is provided through other means, such as
pathname and offset, which would be useful for the compressed sframe
use-case.

If system call overhead is not too much of an issue at library load,
then we could break this down into multiple system calls, e.g.
eventually:

codectl(CODE_REGISTER_SFRAME, /* provide sframe start + end */ )
codectl(CODE_REGISTER_ELF, /* provide elf-specific info such as build id */ )

> 
>>
>> And if for some reason we end up inventing a new model to hand over the
>> sframe information in the future, for instance if we choose not to map
>> the sframe information in userspace and hand over a sframe-file pathname
>> and offset instead, we'll just extend the code_opt enum with a new
>> label.
> 
> This is not a new model. We could likely do it today without much
> effort. We are handing over sframe data regardless if it's in an ELF
> file or not.
> 
> The systemcall is to let the dynamic linker know where the kernel can
> find the sframes for newly loaded text.

I am saying this is a "new" model because the current sframe section is
allocated,loaded, which means it is present in userspace memory, so it
seems rather logical to delimit this area with pointers to the start/end
of that range.

> 
>>
>>>
>>> For instance, if the sframe sections are downloaded separately as a
>>> separate package for a given executable (to make it not mandatory for an
>>> install), the linker could be smart enough to see that they exist in some
>>> special location and then pass that to the kernel. In other words, this is
>>> option is specific for sframe and not ELF. I rather call it by that.
>>
>> As I explained above, if the dynamic loader populates the sframe section
>> in userspace memory, this fits within the CODE_REGISTER_ELF ABI. If we
> 
> But this isn't about ELF! It's about sframes! Why not name it that?

I understand your position in wanting other "types" of sframe registration
in the future that would cover compressed sframe files. Because of this,
it makes sense that the registration becomes specific to sframe, because
we would not want to tie all "elf" registrations to a specific sframe
ABI (mapped in userspace memory, within a given address range vs pathname
and offset).

> 
>> eventually choose not to map the sframe section into userspace memory
>> (even though this is not an envisioned use-case at the moment), we can
>> just extend enum code_opt with a new label.
> 
> Why call this at all if you don't plan on mapping sframes?

If we split this into separate registrations (sframe vs elf), then it
would be fine: registering an elf binary (in the future) could be done
to explicitly register pathname, build-id and debug link. And this is
independent of sframe. This could come as a future new code_opt label, no
need to do it now.

> 
>>
>>>    
>>>>
>>>> If there are other file types in the future that happen to contain an
>>>> sframe section (but are not ELF), then we can simply add a new label to
>>>> enum code_opt.
>>>>   
>>>>>       
>>>>>>
>>>>>> sys_codectl(2)
>>>>>> =================
>>>>>>
>>>>>> * arg0: unsigned int @option:
>>>>>>
>>>>>> /* Additional labels can be added to enum code_opt, for extensibility. */
>>>>>>
>>>>>> enum code_opt {
>>>>>>         CODE_REGISTER_ELF,
>>>>>
>>>>> Perhaps the above should be: CODE_REGISTER_SFRAME,
>>>>>
>>>>> as currently SFrame is read only via files.
>>>>
>>>> As I pointed out above, on GNU/Linux, sframe is always an allocated,loaded
>>>> ELF section. AFAIU, your comment implies that we'd want to support other scenarios
>>>> where the sframe is in files outside of elf binary sframe sections. Can you
>>>> expand on the use-case you have for this, or is it just for future-proofing ?
>>>
>>> Heh, I just did above (before reading this). But yeah, it could be. As I
>>> mentioned above, this is not about ELF files. Sframes just happen to be in
>>> an ELF file. CODE_REGISTER_ELF sounds like this is for doing special
>>> actions to an ELF file, when in reality it is doing special actions to tell
>>> the kernel this is an sframe table. It just happens that sframes are in
>>> ELF. Let's call it for what it is used for.
>>
>> I see sframe as one "aspect" of an ELF file. Sure, we could do one
>> system call for every aspect of an ELF file that we want to register,
>> but that would require many round trips from userspace to the kernel
>> every time a library is loaded. In my opinion it makes sense to combine
>> all aspects of an elf file that we want the kernel to know about into
>> one registration system call. In that sense, we're not registering just
>> sframe, but the various aspects of an ELF file, which include sframe.
> 
> So you are making this a generic ELF function?  What other functions do
> you plan to do with this system call?

All those I have in mind are part of this RFC.

> 
>>
>> By the way, the sframe section is optional as well. If we allow
>> sframe_start and sframe_end to be NULL, this would let libc register
>> an sframe-less ELF file with its pathname, build-id, and debug info
>> to the kernel. This would be immediately useful on its own for
>> distributions that have frame pointers enabled even without sframe
>> section.
> 
> The above is called mission creep. Looks to me that you are using this
> as a way to have LTTng get easier access to build ids and such. We can
> add *that* later if needed, as a separate option. This has nothing to
> do with the current requirements.

I agree on the mission creep argument. I disagree on the stated intent though.

For LTTng, I'm happy to grab this information from userspace. I already have
it and I don't need it from the kernel. I figured it would be most useful for
perf and ftrace if you guys can directly get that information without relying
on a userspace tracer.

So considering the fact that you'll want to introduce new sframe registration
methods in the future, then indeed it makes sense to make the registration
sframe-specific.

> 
> 
>>>>>
>>>>> And call it "struct code_sframe_info"
>>>>>       
>>>>>>         __u64 text_start;
>>>>>>         __u64 text_end;
>>>>>       
>>>>>>         __u64 sframe_start;
>>>>>>         __u64 sframe_end;
>>>>>
>>>>> What is the above "sframe" for?
>>>
>>> Still wondering what the above is for.
>>
>> Well we have an sframe section which is mapped into userspace memory
>> from sframe_start to sframe_end, which contains the unwind information
>> that covers the code from text_start to text_end.
> 
> Actually, the sframe section shouldn't be mapped into user space
> memory. The kernel will be doing that, not the linker.

AFAIU, that's not how the sframe section works today. It's allocated,loaded.
So userspace maps the section into its address space, and the kernel takes
the page faults when it needs to load its content.


> I would say that
> the system call can give a hint of where it would like it mapped, but
> it should allow the kernel to decide where to map it as the user space
> code doesn't care where it gets mapped.

AFAIU currently the dynamic loader maps the section, not the kernel.

> 
> In the future, if we wants to compress the sframe section, it will not
> even be a loadable ELF section. But the system call can tell the
> kernel: "there's a sframe compressed section at this offset/size in
> this file" for this text address range and then the kernel will do the
> rest.

I would see this compressed side-file handled entirely from the kernel
(not mapped in userspace) as a new enum code_opt option.

> 
>>
>> Am I unknowingly adding some kind of redundancy here ?
>>
> 
> Maybe. This systemcall was to add unwinding information for the kernel.
> It looks like you are having it be much more than that. I'm not against
> that, but that should only be for extensions, and currently, this is
> supposed to only make sframes work.

I agree that if we state that "elf" registration has sframe_start/end
as a mean to express sframe, then we are stuck with a model where userspace
needs to map the section in its memory. Considering that you want to
express different models where a filename and offset is provided to the
kernel instead, then it makes sense to make the registration more specific.

The downside would be that we may have to do more than one system call if we
want to register more than one "aspect", e.g. sframe vs elf build-id.

I think the overhead of a single vs a few system calls is an important
aspect to consider. If the overhead of a few more system calls at library
load does not matter too much, then we should go for the more specific
registration. I have no clue whether that overhead matters in practice though.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

