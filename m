Return-Path: <bpf+bounces-62178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973DCAF61C5
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 20:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA2448512E
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFAC1DDC07;
	Wed,  2 Jul 2025 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ucb4tZJW"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2118.outbound.protection.outlook.com [40.107.116.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABB2F7D07;
	Wed,  2 Jul 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482041; cv=fail; b=oiTXDdSEnk2uZyGWciZbtYiXPql1RIa+BD1hlFlaZGynAlmLEk6LQb+Et9CRVhRERq12i1Zp5MdkXNr6w/91W+42cvRgXuhgeGr0BOXJ0O9KsrHHa3h/p+NqbQwW0gNFmeC1CHOJLH4OeA7mvE8+tloHB+5sPoXZukavxc9S9J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482041; c=relaxed/simple;
	bh=OJ/d2fM9d7n0Cc7aolAcX5lIiptmAa0Cmzn2W7aCsgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UhkU3mbaKTsc6Ty8LIM8INKinAQHZ8uK+kytxggcJTBpMO/EAMHY+AEjcKfF53OBerOB0Fz8KMrr0nHQDjFrSkM2DmK0S7NYPjdaSeX87U+JNRu4d9hS8f0ZO1JBGG0trRpfqv3lxyF2EzI36S32tidNhBUbrHKoHA5kny5uURk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ucb4tZJW; arc=fail smtp.client-ip=40.107.116.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOyM3/Dx3+xPvdhRwXghVRIYFHA5ex0e4fe2GzyErt6mvjDQfMI5pBsG4gAATkSDxxLh0Mr5OvLySsuAljx1klXrrF0m5FwD1ZqeWnX2VndFaqhpjYgr9toKhS7cNmAq1uVtUDV1rlFI9gFTm4NcVK3P/4+eklJcK2PLtKaxnIQnloYcsQTmtOEvd6DkmRbeDkyvQwmqISpVjlTgxkKxWflbmkwuXX0eL2UvPfABxNKyFL6B/Zj03X2j8xtyyNibezgbDSymRejTdJInrJ+AbRpr1xwmJaeY2K/oqndQG9vmRmJi7GBDQvgqS5Y1IUaiOxxv291ESYlv3B1FpQfbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjKKjye46SpocW9cNeR4isqIwKgrXM5dlxTqtB/QJko=;
 b=qtHofitIYO1VefZ15hNE1Z+M7v7vDFFjcs6gV3EcOpb8wYj4pMQD35WH2s1Cy6yO5cONm5o8Yfc1EiDz2E9/8oU6wbwDN7ECtUCxq1D6GVev8HG0G7Vo0y2ySin/I93Fp56P6i7WuQtgHE/b24Cf3mMLlElB/v/UN8nIc8dSEq+CYPxO9gY8qQpfWLL8t9/kAzrd8/ckFzJbMvJ7FZc0pNjdPqcl7FLtbF8ftDioU3QcHvI8yX/pTxeiGGCVLYpzJPzUk4gMMw8B2Mp4LMWAyePTsBfotNETEFnF2WHgmpXFlA1BsKql1e6PvIZpexTQWMtCkCsao/kc1SNI6zyQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjKKjye46SpocW9cNeR4isqIwKgrXM5dlxTqtB/QJko=;
 b=ucb4tZJWJGUJ2pKN+Fj02B79JVQz9Kvzm+cIzyLo/Bj3vFp3S18Q9bl81VhIbxlwPyuVHOHaI3nmAGnCiE5U20mAcG0ckMEf0bEYE2gwLu5O7eUfLKz6x+kDzjyyhHQvIHcnyPTARfcFBXtYwU/PmyCsx+qT1OxNsukxMJub6ILNXZM2WVwCBBP26h+IaRZw5iOWtydhLhbhCmVEJf4AlhpCCJdRLWtBQi6uMbNFLskjUILotNmThBSOAbLzJ+7iX3i5bTj/ZuXw+qVFVs2Ptp9KmUlzooUQFSKxBI23g2sfG4k0zAlHfGUELG+7aSTO7eWVmRiYrnUub4vDD6qD6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5206.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 18:47:12 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.021; Wed, 2 Jul 2025
 18:47:12 +0000
Message-ID: <482f6b76-6086-47da-a3cf-d57106bdcb39@efficios.com>
Date: Wed, 2 Jul 2025 14:47:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding
 interface
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wiU6aox6-QqrUY1AaBq87EsFuFa6q2w40PJkhKMEX213w@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: d085934c-ea9d-4714-2972-08ddb998db0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MS9GQis0dVBtYzc1aDVQUkxUeTRLVHZ5dVRiV3JCbUtBSFk4QkFJUWUyY1dz?=
 =?utf-8?B?T3IxZHFnaHk4cnhlaUpxZ0h1bHRZZ2ZuZ0t3Zmp6Z3ZxMzNWSW9iSFQ2NUVx?=
 =?utf-8?B?a21oTVNERXZoWTRnYVpJNmwxMjV0eUFsajc5eFYvR1VzbStGRXYySUtEZ1Bo?=
 =?utf-8?B?SGN4WFNuYVpYeU1CZmN0TkFyNit0WG5Vd0JJWDNCVTdOanRrbWVoVGNob3Yx?=
 =?utf-8?B?QmRHSEtUemVsaVlWajROTTQraklHbXg1ay9FS252R3VVaks5SkxoYllwMlRa?=
 =?utf-8?B?djRZeGtodUV4OENmRStBSXl6Um9HaDAwYUo0ek93Nm9pVDZLcDkzVlBCa0Z3?=
 =?utf-8?B?cnNJUEw2QWtwYWljZXYvb2lLdVJYRHg2aG9WdWxyTzlSbktoSW5Ec1QwUVp6?=
 =?utf-8?B?T1R1dEIyVFpWWDAvUmh3TkVVaTJ6Y0lISllVT3lodEpnTkMraDBDUS84R1BF?=
 =?utf-8?B?OUhDcktlcWJZVTdScTFqc1dJN2FHVFFpS1N0Wm9TRXRJODFEV2Q2SnVwYjl0?=
 =?utf-8?B?d0FsbjA1b0Q1YU9PQ0pzcjAwR00xU1FNM09VRGRWYjMrYW42eFYvVHlzQ21Y?=
 =?utf-8?B?Ly9xdTN0RHppSGlTMXl5NDA3TDRkdFBYMksyVkZZZThvdTVDbU9tR0VXdkVI?=
 =?utf-8?B?WmUycUFKM1lHTkpuMzZ2NVF6Unh0VU1TUDlNWFNsaStuZlk4clJ6NXpXREpp?=
 =?utf-8?B?d3JFRGFNYmVHZUZnc29sTXpTNjFQWU1PYWl3QnlHSEhFa21tM29tdmFoNkd1?=
 =?utf-8?B?N08vd3hFWWZEazgyZk1KT3gzMlFaclVRYzRSaCtUVnczZHFuaGxpZzYvY00x?=
 =?utf-8?B?MEZNUHZiVEdYVWd1RXhmR2VuS3FzTVFPSHBaTngrZEhiaHVZUWJVK2ozVDRH?=
 =?utf-8?B?Q2VmMzZhNkRDSjVWdTV0b3JLeTRxOGFualZqTDFoM1d1QVNUeWo0T1lvRGNI?=
 =?utf-8?B?eGFPTXJwVTJNQ1ZLUlpGcDN1ZDN3OHZiM0V1WWdVTE0raXhIUldiRFYvbE82?=
 =?utf-8?B?L3lrZ256QnFVRi9tMnlQOGM0T0p0a0J5V1o1RzdTbDZNd2tBR3ZpMWlGUzhy?=
 =?utf-8?B?T2o5RFZoQlZrSkRrSVd2bXNqTWZ3bWFacTUwd2lGMVowWDNVREFCVCtPZlgv?=
 =?utf-8?B?UXdwOGg5cTNIcUl6ZFJnUEJobTVmTlZnMHFNOFVkalhPQnpUOTU3VlZvWW1w?=
 =?utf-8?B?TXpBN080R3BvTzhBQndzcGFhQzFKeG1uc2VsQXNGaHJmZmRKMU5jUTRXSGg3?=
 =?utf-8?B?QXdjbUcwcDVkb0t0NG9xeWpIbTFxNXMvL1pnR1dkUlBLQnVYck10UGc4M2c2?=
 =?utf-8?B?S2N1Tk8zcVhNMzBLM1RsbUJjZXRNT3Y1cGl6dFdkL2wxa3FFNWpCYUFXbE1n?=
 =?utf-8?B?cjQ4QUNxa3MvT3NVT1BiVXJMMUQrYkU5d29Ib0NMWU5hVzI4SlQyK2NkWXlS?=
 =?utf-8?B?QmdEaWx5S0FIQkRXU0RiYTBCWnFBaUdobjVHd05CK3U4ZFpCOEF1ems1NVFi?=
 =?utf-8?B?RmQ3RVA3aWNJUEszVk9JMWUzQVBhMFVSbmErc3ZPd1dHWjIvNmdhUTVpbDVl?=
 =?utf-8?B?YVA3RFp2UlVTKzlnRktrd2hUTXhBMlFBMjRLWldyRjArV2Z2WFFLZjN5SVFp?=
 =?utf-8?B?Ym9zYnNUQjA2Q0xtVXdOV3lKR1lHRGlYeU9HU0hIeVdxQUJFS3JybzAvaGg5?=
 =?utf-8?B?NWVzME9tWGkzWFBtZkRzcTJaamhSTlQxOFl4ZzFwTnQveG1hVy90OGhsNmVu?=
 =?utf-8?B?M0E0c0gvOG9mQXFCNzAzL0RYT1JOeWVQWHFHWWsyTW43UlRSYklJaU53RU1V?=
 =?utf-8?Q?X3pUI1Z1CM54CT3LoNtpyZVrmQJGnz7MawqQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tkl0aytCN1ltVHpKbkJyWnE2b1ZiY2VlbEdLL2RVckFYVTF5QUhYeWJpZGtn?=
 =?utf-8?B?MThxWCtuYWNoWXBWRktRbVlwNDNLNzlqVzBpbkszdUV5YVNoTlRpWXMrbURz?=
 =?utf-8?B?RmtxUTJnTWtTdkVrdzdJcDRrRTNkaUNPK09lcTNzTWhmZWl6bnA2TWlTSng2?=
 =?utf-8?B?d3BBRTgwM1BqZEEzMk9xODlacjNSZmJiTGhIMUVnYjVjUmpsanJLeGZxeWQw?=
 =?utf-8?B?Q3JaMWd0UHdIVGdBSEw1MVlRNWFxNkM3T2F5bzR1clJBcVltcFVwSkwyamZO?=
 =?utf-8?B?SHBBTHJNVUlKbzJ3RHBJbmduMEIyd054SENRaUxHNFg2QkpwakF0ZlI3MzFC?=
 =?utf-8?B?YjMzMkV0SmxwZkZqcVMxaDlLTHhlU212M2k4Z3AxUlM2VHRsRGdVUTJWMTFC?=
 =?utf-8?B?NFNLZzU2STlvdlVpb2hmVGt2QThvT3QyaHNGbzdoejlOdmtqbU45NWs5aC9B?=
 =?utf-8?B?eVl0bG0zMnNPMmVHZ1Fud3ZRUHQvYy94VEE3NVIrY3huWlNsWU5MdktrdHNZ?=
 =?utf-8?B?amNaVWpaVWp0V3RPUGFJb3dSRUtJNlRPNnY3MHE2cW1HYUQwM2FNVkJaenpn?=
 =?utf-8?B?cXRoMzlDV0JGZFJkNDFPcmR2YUFhQUxRSDlxSW5nSFJpZHp5dTBJT1RSN0FK?=
 =?utf-8?B?V05XOG5SYUE1c2pHMVkzR2lRVXBMcVpFSnZRZlhud1NLYWRlekM3WHc3Ynhu?=
 =?utf-8?B?N1lhT1dIYysrNjBKWmhYNTJwMlh2bzMxSjlndmtueDFOV1lrNzlwdWlmdjNh?=
 =?utf-8?B?V1NYWkF2bUNOR3hZeTJxUFdReWNUVkR6TFFGQXI3RjZ4THV6SE1JZ092ZWJK?=
 =?utf-8?B?bWR1S0lYMFhaUnFqMktwLzJpTkU0QnEyMFgrRkFHM2lhalN1WEdURHAxUXhw?=
 =?utf-8?B?Q1lTbjlrc252NXBwUG5yY1dyVG1wcGhHdTNTa3dFTTJhcTRMZDU4M2dla3Nx?=
 =?utf-8?B?R3FWNG1SWjM5V0FQNzFPc1FjL0R2SjZ6VGhSdDd5UmxoL0M3bWpIMTM5UHJI?=
 =?utf-8?B?em85ZFFKL0ZqNndtL203U3QvSEJQZHo4clRBNEtjL0VUbG9tOU15bk5WT01R?=
 =?utf-8?B?MFlpQnd3eFVnTTk3Rnk1V0VoNVVNTzY3bFlKWVlDV2x0R2F1MVNlMnloT1J0?=
 =?utf-8?B?T0J2US9CcjVWaFBNa1pXT0FMTVl2OVMrSXR3cHdqY2lEODQ2R05sK1pub3dl?=
 =?utf-8?B?Yng1NldRUEJGTmwwTmE1R1hWamkzV093VjFVT0NIZEJsSThiem51bmdSUUxq?=
 =?utf-8?B?a1RuL2E5VXNaVEFrS2drbmR4dUprazZ1aDk2cXNJZTNSa0pucXJieU5hUUt4?=
 =?utf-8?B?RjVhRDM0OGwrY3FQUm5nSWFKaGRJZ3dRY2lpdGlYVVp0QUJzUWF4R2hYRloy?=
 =?utf-8?B?SVB0aE0zTy9xMDRBaGNhZDM1OUlzZ3Fhdjd0enZEZjVBWGsya0ZmNmZMZlhN?=
 =?utf-8?B?ZlFWNFJlaXBSWE5mUWY1SDRIRzVrQzU5ZlMwdExHOVJxZzEwWHVjRnJFVm5K?=
 =?utf-8?B?NDhFclkrWndiWmh3ZVpQcEliLzNlOTI1d3U3Z2piTGljNTRoeGJFWFlkaHdR?=
 =?utf-8?B?V2k3aFpST09zK0xBM2ZRK3BHc0NiTHhneTkrYmVnbXZSVTJab2ZKOEpNbVlP?=
 =?utf-8?B?b3dvOW1yd28rQnVpZUVDTElpa2NFb0taT2h0QUVEdlVmaVhHcU5CMVZvTFor?=
 =?utf-8?B?WGtCampRTG5HMEtLT3d4NFNKc0VWcERzWFpjNlhNdjlTNmpzcjZWdkZkNVpU?=
 =?utf-8?B?aU9uemRUNG5UM3F5andaTGFEQlQyK0g4NG9LY3plZHpRUXljRVVSQlloK1ls?=
 =?utf-8?B?cWU3WGpiQjdqbVZuSVZzWmZNMXNEZENsZm12c1cybmgzUUhCVjRZbk9vckxG?=
 =?utf-8?B?U0NXaExtTWpSckxrT3VUWXAvWTZZK2lhc1hKMWFNZEhieDd4bGpaTk5Va05S?=
 =?utf-8?B?bG8zbE9wREFha2w5MmVSU3F6eUdINFp3dXNya0p5Sk5yR2FIblJMNnBZcFI1?=
 =?utf-8?B?cHlTVnA5K2g2ampTSkZvN2ltRUY4VEpKbWFTdURaQ3BWZnNOQ0JhM090Wm9D?=
 =?utf-8?B?bW1uLzFsNFFFTW5BRXVZcmpFeWFKOHhqeEZweVVZbkFtNzduS0xndGxEMVk5?=
 =?utf-8?B?NDBKay9RSTVjRFlpYTdOTnJ3NTdCcDB0WTZyV0tjR1BqdWFPYmJuSkh0a2xT?=
 =?utf-8?Q?BWhRvTTfIfT51cy0+9gLLyE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d085934c-ea9d-4714-2972-08ddb998db0c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 18:47:11.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjOn11oB8lXeC7FsEAIkBiw7MOgKK+jyTvoFZ8fErUNtJ8idPM/IF0GQf68ptBURBbmlI1iYX3c7sL4Y1B4B/+QnPRsw9Nu8cbhURhXYy2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5206

On 2025-07-02 14:21, Linus Torvalds wrote:
> On Wed, 2 Jul 2025 at 10:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> To still be able to use a 32 bit cmpxchg (for racing with an NMI), we
>> could break this number up into two 32 bit words. One with the CPU that
>> it was created on, and one with the per_cpu counter:
> 
> Do you actually even need a cpu number at all?
> 
> If this is per-thread, maybe just a per-thread counter would be good?
> And you already *have* that per-thread thing, in
> 'current->unwind_info'.

AFAIR, one of the goals here is to save the cookie into the trace
to allow trace post-processing to link the event triggering the
unwinding with the deferred unwinding data.

In order to make the trace analysis results reliable, we'd like
to avoid the following causes of uncertainty, which would
mistakenly cause the post-processing analysis to associate
a stack trace with the wrong event:

- Thread ID re-use (exit + clone/fork),
- Thread migration,
- Events discarded (e.g. buffer full) causing missing
   thread lifetime events or missing unwind-related events.

Unless I'm missing something, the per-thread counter would have
issues with thread ID re-use during the trace lifetime.

One possibility to solve this would be to introduce a thread
identifier (e.g. 64-bit thread ID value) which is unique
across the entire kernel lifetime. This approach would actually
be useful for other use-cases as well, but a 64-bit ID is not
as compact as the CPU number, so it is somewhat wasteful in
terms of trace bandwidth.

Hence the alternative we came up with, which is to combine the
CPU number and a per-CPU counter to have a cheap way to keep
track of a globally unique counter using per-CPU partitioning.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

