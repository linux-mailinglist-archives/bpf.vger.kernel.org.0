Return-Path: <bpf+bounces-66878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEB1B3AA83
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 21:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2258582F50
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 19:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D402765EB;
	Thu, 28 Aug 2025 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MeWOb5Vo"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2107.outbound.protection.outlook.com [40.107.115.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D22701D9;
	Thu, 28 Aug 2025 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407788; cv=fail; b=HjY3X7cWaM1g/agPMyl3mx2XZ01iMo2DIsB1xSUJIrlsRKRIeTJxQWTScLmZizYXO3bNsLkAIywr3jEPbAjmxd3wprxkuLLZqECTXkfCzBEMBdZONRZsVLUJJh+Q7SIEaK9GYjMUd9pFErrArwfr6OLRHiOWnqRE1AewLJFEJCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407788; c=relaxed/simple;
	bh=OcpHhcnVObd4RIfE9wPLC/oKdzrVu7ToHn7cXOEp/Nk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JN+s4cjECfKiFGQFIf0OJmtLHYjSB1d5dmq8DCvk/wwA001CWGmUR88dpdqwTfF45SHv7/lhbiwECdsVx6NCHuZ9slTT7vapxSrqh8j4JS85vXAyJ4SF9nriorzKIN8h81yspWac03S3RorEV3C8ilPH578pMX2ndPB47QWqe/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=MeWOb5Vo; arc=fail smtp.client-ip=40.107.115.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjSrYlm1nfre0yILe7zjxxklsvQfL8BlE3Fn4b8SkL+6vcHJ0G77IgakKl6VF2n+r7Kk9HZ7ZkPnSLws2gjxObvRCnwc8vWuAD5+GFTGmNYfPY3E7YLhi897k4s+ENnHVCCchGz/YumPk5p9NcReK1EZXdLAfFECviRolook3KnxwEQ9+IlmZYh/NmwMhWZzqk45iOfDUI/bwY95kuKx28o8lnmPevYVqhe3ZbHZs22ts6ABgA6vFlB9nWA27DViO5k+djkLUcxA0c0r/9rM6/GnZmw0Bzb+TzFPd37YdnXRe+fQ/rdYXyQS3x2L9GVnfPNKGAx1oNTAW6z9ecbRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M51RQiESkKt1VPF6fsV/7BT3hmDzvCtcX423imgiIzU=;
 b=FbON8qbNH/y0udOHCGJMayJC0M4NX8RS7rnUeEodEkZd8XFgSpvO0nA5Hsv/RYwNsv6DjMS0U2r/G+37tkUDK/Rt0dvkOp9Ep4rGLSHpugZJ5gM8P9LUtssUZMUHfG5r+x9ELkwFuPlkHe3uDuY0dUdrk74jgASsV5l1U3gyvYHhsLHZkreR8dsWrNVxCSDeL5RGpKlozH4tBDfw45Xp3mgBQwRZxsHN+uoo0d5T+M7tVX7d7N6iqH6u7j0DXLLnZsvkXXLgXBhvaBMQbccbEIKEE6fPuIwc39JXGlof14cK7n+yEMSvXR+5FSMfgePSIeBZ6H3koUpZgpvemFzHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M51RQiESkKt1VPF6fsV/7BT3hmDzvCtcX423imgiIzU=;
 b=MeWOb5VoVq1ROOAGYo7NTaGYgziT+x/efsXoJ80B79MctWiBMs0YvVdtXdgwdx/ptCLSDSDUD84MElN8t5nlgBqR7dyNnLcExUAe/+HOiBFXGUr25Sdovy2sx+wGn6jPXGEwJIV0z0/8m0ep3RatsVDJLvceIlzLqQ+AaQ9lQaBy+cjEvbUwbRli+YVzuTbSz2bnscvXap088PGWBLv0pYhrTmjmfIhXxJJT6PD2hbCU1+35Q16nDlhoKh3w222cNlNT8B5pMOKxUUVU7BGi3JYO9m5MHbjYDASmW+v24xuU/Bb2wpHSaShwmaDIdVDlEcvE1vM9gG4ADNP3cDnLPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8580.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.18; Thu, 28 Aug
 2025 19:02:59 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 19:02:59 +0000
Message-ID: <f97b6bce-d565-4abe-9bd4-33f5fb2873ee@efficios.com>
Date: Thu, 28 Aug 2025 15:02:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
References: <20250828180300.591225320@kernel.org>
 <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0331.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: dd39e057-890c-40f7-a44b-08dde6658160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WW5jc04zcy9YM0lnS1ZHY05HdjFxM3ljcjlqYzFnWmV4SExNNDVxcWdjek03?=
 =?utf-8?B?NUdkYXdFLzF5VHJsTE5LNmxyUDA3NTJPeXQ4S253Tm1ac3gxUjA4OWQxWDI1?=
 =?utf-8?B?Nld3WU8wUkNLVGZjeWUwTzh6N0d5UFNGTFNMK0ZvNFBiVjFDODc0b0xwRUEw?=
 =?utf-8?B?bEdRR0dzamNReXlqNVp3R0dzcjdwdll0U0RRZXBSckFFWjhEeUE4SkhXN3dI?=
 =?utf-8?B?QytrK2tXRHRMS3dTSlA5Zkp3ZnFyU055VjlSMlFZWjgxN0dxam44RmdIOGxt?=
 =?utf-8?B?SFZWR0w0T213eXJLb09KMFNOS2xWT25tYXNXOTBRNjZtVVdRS2FRd2pHNHZu?=
 =?utf-8?B?OWd2T0JiUDJKOXRQM2JYdW5qaHdIbkpYVFpJS1VmS3dwT0E1TUdJeW93SVZF?=
 =?utf-8?B?SkR4TDdYVldHRyt0Zit5QmNuR2l3eXZIU2g1VWpoR0hEc3BlOHZkM3I0Rlh3?=
 =?utf-8?B?ay81d0R6Mm10QkxneWxERW5vRElDUVFkR005YjY4VWYvS21JdnVNNnk2SXVG?=
 =?utf-8?B?bzhTdXVnWVZLNFVTc1Erb29hQVdoQTJhWm1leVVON0VJWFhQVkVDT0pHU2hW?=
 =?utf-8?B?dmN1VzNwQmoxVE5mUHBwNVNoSFo2dmRvVmI5eGQ2TnpCNnVjdXVxbWx6MmZu?=
 =?utf-8?B?WXd1UGcrQmxDYXZEOWhXU1p3V1d2K1NQRW9mSkt1SDg1ajNPRkMvZmp5MWFG?=
 =?utf-8?B?aUFBaldMdzlvQ09TeVU3aVJMMGJzYjZRb2J2UHZhZ1JiUlNnZW1Hc0FyQmU5?=
 =?utf-8?B?NGdWUnJJcENSSmhCQU9IYWR6ZGZwNFhnU0FwWWQwUFBUUkdQNDFVNjZrTjZL?=
 =?utf-8?B?VHNad3N3c3lSVWxMZGhuRTEvNDBXSUtwMmF6Y2VnY01Kb3BNUmpjcExIM3RC?=
 =?utf-8?B?ODJTZE9Sc1MwQVdMb2Z6K21iUVgvOTZOMGs3elJOQ0U4aDdlTnVvK1phbjFl?=
 =?utf-8?B?MkNYdjFqbC80N2ZlUFp2amZQRVQwMk1qcnVhc0JOdkRic0F6NHI1aXNRZ0FV?=
 =?utf-8?B?VlBOMzFaekllWnhuWnZpOUpISk1YNmtLRmErLzdxd0tiMlA1VG1sRUx5R2s1?=
 =?utf-8?B?VytFU3Nid0gvOHpkVFBkb1BMaWRHYW5sbk4yVjBqMTZWVUxTZ0ZpT3FwUVcw?=
 =?utf-8?B?Wk1WZ0E5U1ZqY051emI2aW1TRnRDSjIvMXZnTDN0cWU5RDZOWTdJTlNxUklS?=
 =?utf-8?B?K2NscXh5TFpNOXk4TG9aTnFJYVUweEk0ejNwa2lIc0lBcm40bWVBR1EwZU12?=
 =?utf-8?B?ajFpMHdvTit1L2UvQVhCNTFBekVtRkhSMzZ1bm9EcmJTTm9DSVJVcjNVYlBX?=
 =?utf-8?B?bm5SaUN3YjI1bFhORmNaZitJc1RZcjRCaWFqUFBXc1Mxc25Hb2YyVk9lYkNj?=
 =?utf-8?B?ZHVQS3FIaUhtSXdYTVE5dEw1cU1RcXJmb2tVUmxwRmZLckNZS0NKMFhLc2lW?=
 =?utf-8?B?eWFGL3FzOTdqR1FuWlJwUTRRb25vblNiVHNyc0tHUStnTkJ4eG05MnM1dWdV?=
 =?utf-8?B?L3V4REd0U09MdnZxYmV2OEUrOHY4L055MDlaTFBmVlUrWWhaOUhsbU5GVjQx?=
 =?utf-8?B?b0NzNCszQXdramZkb2pUMUVoSVVLZHZUMXZhcmRZVHN1bi9FRFZUQWk2aDF4?=
 =?utf-8?B?VVNPZkk0VERuendZR1gxRXQ1ekI4VHlFaXdmbzNyeUErMHNaM2pCaWNvMFJt?=
 =?utf-8?B?cGQybzZ0MXFScWdNcmJSajBWVy9ZeDlVb3h1OC9SdnB0U3NzeFpGbHZlSFBK?=
 =?utf-8?B?dDR2WVdwY1JjN0NuZ2JCaEt6Yy94Mlpqb1FlVGpDR2dNbU0zNW9QcFUvYzln?=
 =?utf-8?Q?nH0LuQHzKFu36OKmmaaidAVYt/wwGYhV2Cq6c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0NWZkZhS2g0MHQyM2VrZFdvbFBZbzhXbUpPbzYzeDhVajR0dks0QWR4SFhI?=
 =?utf-8?B?UlpMR20xenhlSW1FUUtlOEFhUllaeWJab2FRb1JtbWUvNno1c2xkanIvWVJr?=
 =?utf-8?B?YXV2bTlUcVk5aTdRVG5MM05oRnliVmNKZVhxQ1k4S2pBdkh4cDlvMWdnc09V?=
 =?utf-8?B?OWtlem8rYzh0Z2dVYTY2VXBQcmYxNWI0USsyelJCZ1JYNXJtQWpkbUtqOTNC?=
 =?utf-8?B?SDBkWnhFR0l1KzB3eGNVMmtyOWc1M2sxNHoxcEIwdXd4bW5yUitWSHQva04z?=
 =?utf-8?B?TVltMlljRElVMnhmMUlwVk53cS91NngwWUxtVDJmdWo2M3BPV01pclpsbERS?=
 =?utf-8?B?WHpjT3JrY3dkRStrWnNqd25KYkd1cEZ4Zy9kc3V1SllIajBGRjF5cnF3VkNK?=
 =?utf-8?B?OWh3WWJYOFRGemNVSkxzczRHRnJXOHZpcWI3ei9BUkg2QTBtVksrWmFSVXVy?=
 =?utf-8?B?OTJHMmpwWGE3OEtpZHNVSmpjK0g0dG9KTGprSUVZemNtVWVjMXV3V2t4aGRu?=
 =?utf-8?B?SkY1NkpSb0ZobVQ2dFRYRk9CSGpJdml4WHg3R1hra1BrQU9ST21ubHZtL3dU?=
 =?utf-8?B?K3M1d2c1YlRYZFNVRGIrZ3lFRzd0bnNKMHEyeVBoQVFJRTAydkljQkNqVlk5?=
 =?utf-8?B?MlVQckdXVkc0N3ZwY3RRUVBqZXFsRW51NHB2VHdHTzVWZkt0MlYxZ3VCOW1Y?=
 =?utf-8?B?c1RqMVhvbmJwOE9icXAyR0p0ZTFHYzQxVEJhL25kUUtFNEtiZ1NaaUlzcW5L?=
 =?utf-8?B?U0wzc3dza2VhclRtUkxGc0VsT3oxZHJDWFlFeUJrWmt5K2tveG44Z2Nsellw?=
 =?utf-8?B?WXphUUlGRU02bVBHTjJtbDRyUGpOcDNMTmNsVndVeVc5UWRISTVNemZoaDVE?=
 =?utf-8?B?QUx0Tk9Od3I5d2FFYUwyYVBoT1JYd3RicUVOS05SMTRiNmlCanJ1Ry9zbWZB?=
 =?utf-8?B?U2NjcFVLMS9scTk2WHBxTENnN2R2VERTa2tuTk5BZkl5Y2xWU1gyWEtyL01x?=
 =?utf-8?B?ZytCSURwVks5cnNyM2Y1d0dQNldtdENlYk1uZTJCQjhhUUhVdGF5a09YMTNq?=
 =?utf-8?B?VjBWNnBRWDVoYUhmcktuSlVFRXRuWTZsMlB3ZzVoWFRQc2tVY2FuOXlFb1Ft?=
 =?utf-8?B?UGRoMW80S05zOGorK21iQ3RHejBMQlZRWU5zRXhhSzBLSzZSMXBQTC9VVVNF?=
 =?utf-8?B?MVVoYWJQMk8xcDg3Z2szU0lOdVMrai9XdjFhSXo2WkV6VzJFL1Fyb1Vzelh1?=
 =?utf-8?B?MklXNWVZYnlmc1B1Qlh1MlRVa3h1YWJuclcvSnNBYVkyVk5MUXJNT0pGbVk0?=
 =?utf-8?B?WlZxQVZsNkJMOUhJWmsyV2pUNDZRY0Z5RklUUFlMMm5DSWlnODc5bjJqYzAz?=
 =?utf-8?B?WEhWMThpUU9aWE5OYjJ4NWpmVjRXamFlWTI1MFJjckhDQnBrcURUai9EMmdH?=
 =?utf-8?B?eU15cXNOemloRkdHYldtUkY1VDZXNnFldnpWeEJlSDlhRERDSGxPd3RPbG83?=
 =?utf-8?B?b3A2cjBkSktGaitPanpqOThEbTEvbmZvQVJzbXFGT3JzV1d2OWlVc1ZFWFBo?=
 =?utf-8?B?WGRUellVYmhibXlpdnM4eGpaSElrZ0pkY20zMEFmRGNFN3lrQW5VZGhaS2pI?=
 =?utf-8?B?T2YxelZuODNoVC9ubW9GclQ3RS9wQmxYS1kvbVBkUklqOVdLd3RueHRveHRJ?=
 =?utf-8?B?R0k3dWtIWktKbTNwN2tEdEJIS0lNcjhNMTlKSWlXKzVGSEwrNVFVVVlDb01P?=
 =?utf-8?B?eEoyR1JNYXc1ZTNxTnpQUG1SOVZ6Z2UvWXUvUkF3TFp5dC9hT2lyc25yMU96?=
 =?utf-8?B?YUQzbGh3ajg0Y1ZRMnNseWlVU0lpR1pJRGw1c2c0cWZyNStSdkhGallNdXo2?=
 =?utf-8?B?RHF2WjhkeEFBODBHN0pmbnBsRk5WZkw4NVpQdWpxeSs2YzFSbUltN3JFdlBm?=
 =?utf-8?B?S3JJeG9SeERwT2VicDhEc0FRR0V6d3I5bjJnbS9lTi9HY3ExaDBQcHA0ZFBP?=
 =?utf-8?B?VzMyTTlibElaU0dkVG5GdUMwQVFTSG5zVG5pOFUzQjFqWGJiQmQreW84S3or?=
 =?utf-8?B?WE1TSUF0QlhSMjNONzNnWDlvZFB3am90M3pBclNKWmRlT3cvVEJFTzRtd2FB?=
 =?utf-8?B?N2Y4R3RmQ2NPRThjSCt3RzNQb0N1RXA5R0tmei9yL3RYRFlLVWRhNEE4Wmhi?=
 =?utf-8?Q?9RyJdZlo9+J+5lXvmNl7dkM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd39e057-890c-40f7-a44b-08dde6658160
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 19:02:59.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XM4yes9oqSQT2tDTJ5wzcqdcgYdREpMnV9+QAYb6lwmEJzsZrsnIwc4mlKTnqoAhuKRclxchiCobqodnnW84+J9YfSXLNfe0drDSpWFWQJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8580

On 2025-08-28 14:58, Arnaldo Carvalho de Melo wrote:
> 
> 
> On August 28, 2025 3:39:35 PM GMT-03:00, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Thu, 28 Aug 2025 at 11:05, Steven Rostedt <rostedt@kernel.org> wrote:
>>>
>>> The deferred user space stacktrace event already does a lookup of the vma
>>> for each address in the trace to get the file offset for those addresses,
>>> it can also report the file itself.
>>
>> That sounds like a good idea..
>>
>> But the implementation absolutely sucks:
>>
>>> Add two more arrays to the user space stacktrace event. One for the inode
>>> number, and the other to store the device major:minor number. Now the
>>> output looks like this:
>>
>> WTF? Why are you back in the 1960's? What's next? The index into the
>> paper card deck?
>>
>> Stop using inode numbers and device numbers already. It's the 21st
>> century. No, cars still don't fly, but dammit, inode numbers were a
>> great idea back in the days, but they are not acceptable any more.
>>
>> They *particularly* aren't acceptable when you apparently think that
>> they are 'unsigned long'.  Yes, that's the internal representation we
>> use for inode indexing, but for example on nfs the inode is actually
>> bigger. It's exposed to user space as a u64 through
>>
>>         stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
>>
>> so the inode that user space sees in 'struct stat' (a) doesn't
>> actually match inode->i_ino, and (b) isn't even the full file ID that
>> NFS actually uses.
>>
>> Let's not let that 60's thinking be any part of a new interface.
>>
>> Give the damn thing an actual filename or something *useful*, not a
>> number that user space can't even necessarily match up to anything.
>>
> 
> A build ID?
> 
> PERF_RECORD_MMAP went thru this, filename ->  inode -> Content based hash

FWIW, we record:

- executable or shared library path name,
- build id (if available),
- debug link (if available),

in LTTng-UST when we dump the loaded executable and libraries from
userspace.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

