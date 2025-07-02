Return-Path: <bpf+bounces-62189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A7AF62D0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5E91C44D98
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7DA2F3C36;
	Wed,  2 Jul 2025 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Mkm4kYmi"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2097.outbound.protection.outlook.com [40.107.115.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD208233D8E;
	Wed,  2 Jul 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751485397; cv=fail; b=nhPJvUOajXuDkR/6lQyLMuDVm5oz/Sr+wfcRToq9AAty47uTAKAJhT6NhQSxYSaLF9zPf1b0f696yCa58uaCNwVC/+V/ixXwagFnQh+O6rB913/keSN5SfM2stwUV/JgvADC3wEWAk+IvcgKM2s2T6HwBtFiqdqJf7s3d06OmxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751485397; c=relaxed/simple;
	bh=xIGe8iahg+PptqRe0WwkVmcC09uz7aUSC5oeflA3MYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OCm7AHU65rIn56HfXaLZNnkUoisNoFpRsr9MFBPCElnqisbQrtn13rtbzzWgDpnKozXSSTtSf7wLl+sbW7nHdX4NYxkZWGHQLW5zN3+gr+aF2ZKduAM5sQ8DOxveQ+zBYxHRt3+jqAEPfqCPFoVP0TVxlbJacOIfE5ggWz8sUqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Mkm4kYmi; arc=fail smtp.client-ip=40.107.115.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhQnqbMAu+tt3wuliqewO+kJVDQZLImbSFoKG3oy4Eqi9FcTrEkl/EBZL66X3Chkt7wQZuCqX8ixb9KR78HrsX/dRZwzkKwZgq5+WhA/P3p3jXuJ2AGyYWNk9tyyr1IVaGgqkUkQazigvYbi0pdIdGWa/pwYe8b6hbfrqC415trhmDsXEh/VJ5q1unfsnyr0v7sezWdOBu/SNahUxjb2FL0nCvWdx+i/yUe8po+0S3LGpp0cHG1SkWN0Pz/7Ze+7lcifd/6VUEsbQqGpzIc6tKcK9wzqIh91gIO318C9bL3hw2j0SLGvoO/EeRJ6nvTRBVpIq97FHtDm2bpz0NGnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNsFMYlx+dZtaHEn4Ux6fivL58iQ5DroORSp4qTOnrM=;
 b=pb/Qbsbu1+vn+QgQY4VVmdBdtvgOw7T7+wKCJI0hMcReTp5zjPyMWxO5xnw+WrfUCgmea9HjKznXxi3Vsza/vZ9N4uaZvmSjPFtlbkUEMdDaBzDuEOynKNDc0hO9zESfRMIbdkEUayr/UVsFrPSyDHEjLDssWBX/UZEd1ec6G3WH5+Js2fwriosO3SBMfsWdaDdsSfIQjR144LnfRZWzcCwl27++dGtYEBHqlNpaCLzGolSVrWvhJLlpSQNAAfPuQG9m3mrcZFWScGXkYghljWPzVy4hRILtuZTkfyCEEKt55p9wKCVsFrcspL4pXKKtZqxy6WJ95eZipBpRnkWhwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNsFMYlx+dZtaHEn4Ux6fivL58iQ5DroORSp4qTOnrM=;
 b=Mkm4kYmiKPnkHKMTCS5mQTVBZjHhaMJCj1wWAuhJOm5sY4xwWLhEDePc9q4VmEtrjiUY9bMV+xBpyzU47DG99Djzfl/PM+iKOP1kYrZfd9Jiv/9JWSd9fSmL9Ekt+Yuzye4+h/LeTSgR8Z3M4mGrtAqcGSr3Rufn1FTfgHUuu7rYyotL4q00VB0OZEgS5pkpiOnZ6MTkrbEGZzrue9o0tpp0EZ6ixcqlm3TqaQC4y6QgzakBY0OUIsirk1VtUTtz1Lyd0fPlpZ4vJBabXJp+znLEdxcOkVOys17bEoIkHmMJg6SOh2lpzr89teD+GSjzsg6SZBSOEFASokz4eECjQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB5930.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 2 Jul
 2025 19:43:10 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.021; Wed, 2 Jul 2025
 19:43:10 +0000
Message-ID: <707898da-a3d4-4cdb-816a-6a2e5a3cb03d@efficios.com>
Date: Wed, 2 Jul 2025 15:43:08 -0400
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
 <47a43d27-7eac-4f88-a783-afdd3a97bb11@efficios.com>
 <20250702152111.1bec7214@batman.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250702152111.1bec7214@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 07af6954-33cd-470c-78ea-08ddb9a0aca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVJYeFhSVE5aVThuODJrRWNMZUZPS0lYUDJzdHBJRThhSGx0QUpzTnF1L1hP?=
 =?utf-8?B?clBJc3RMY211M3BzbGxBeEFjbHJoczJTQURQaWhsVWs0RlNEWUN3akJPTjRL?=
 =?utf-8?B?cCtkQVErVDZ4TVg0WUpTMENSd1NwZVFMQUovNVVQVzc3bEVQNXhnRTJlTitU?=
 =?utf-8?B?K0hmRkRZVGp2Yjdtb1o3UXpiNkFFZDRJbVExZGROLzluUXVnSXU3eWY4MU9I?=
 =?utf-8?B?WkFTRTBaZzVkYThYQnZEbUJhNkVCckdhMXB0ZzR0dEI4blg4YU0rbGZoYWV1?=
 =?utf-8?B?UGRVejViVGUxejB1cU5waDJGVlJOcHpFd0o5Nnl5dHZxYWJyK3VVcEZlZG9C?=
 =?utf-8?B?THFzVWtpaWlDVGo4b1orRDBDRkRlaXYxd3RRb0Jkclg5ZmpEN3UxN0ZLWmdl?=
 =?utf-8?B?YTdKUC9iZEtXQnJ2SGxZejhERnBLWXpLRDlZb204QnROYkVCMFZ0NGVGemYz?=
 =?utf-8?B?d2x6K0dXWnd4eEMwaUhTVHFGcVQyZ2VlcGlKWmxmd2RHdmR6RFZNZ1pOQld4?=
 =?utf-8?B?R2NMUUdESnN0aUM0ZHRmOFpWdXBEWGxUWmZCcEtRZDRPRFlwUlNxL3VObGY5?=
 =?utf-8?B?aTM5SHhyRFVMM1h4Z1d5anlkeFNpMzNBNzg5OW5SRTFGUmI0MERaZWdheFRC?=
 =?utf-8?B?QXFxR09IWGtNQmE3aTdpemZhRjc0STNHajM0WHBmVmlIUW1odUtxa2Z2MDJv?=
 =?utf-8?B?RHJ2bi9wOXc2eXh2RVk4ZVd0eUY2MFZRRHhOWldqT0VGTkVGamQxSU9QNDNH?=
 =?utf-8?B?cWFiMTIvZzUzM2NpT0xtdnBOSUZkS1VEVE5vdXNteUxTK1NWa3p2d2xuNkNT?=
 =?utf-8?B?Y2NDNEtFZE1TV2NpTE5IYURpbDBPSFZiT0dKNXRPejJOTkJUREs1ZVRlVkhz?=
 =?utf-8?B?dFpULzhtTjZENGlJVitxS2treVY5aG1WcG1FMEI3R2QrV0lxcEltM2dmS1F4?=
 =?utf-8?B?TVF4Q1d0T2p0N2xBYWZFM1ZuTXV3d2lNdjlBTW1yVEFGNnFSMWoydTlvZDVo?=
 =?utf-8?B?WEJBUTliZ3psd0o2anBNWENCdExJN3M2WFErdWpyUzM5UVpkQjU1Q1VHT09Y?=
 =?utf-8?B?OEJKU2I5TzcwN3ROcHBxVmlDQ2RZNUtZbHlDMFplSFEzRnd6V3F6MGZlWERv?=
 =?utf-8?B?Y085Y1BFaUoreDFWUDVITE90eFdXZHp4SHZDZ05aWWNmcHA2RFFmNTZFZm0z?=
 =?utf-8?B?UmE3cXVsVjY0VkNuWFY1MmdwN0ZJMzVTaUNidWhXakN4SXk4bzF6VXhMd2Rp?=
 =?utf-8?B?YU83V3AwWk9seE8zREhhR3UrUGNKZ3hiby9QSHl1cVlBVDFPK0lUUjFsaGJx?=
 =?utf-8?B?TXd2Vi83YjFhczgrYWFZYTdyK1hEQkZZamt5cHREMWJ4MHQvNFNlTVViV0xZ?=
 =?utf-8?B?RHZBM1kxekFJUjVKN0MyVERmNlIyZGRwQ1EzQUJkZDR6MUZTbk5neDh5SGVH?=
 =?utf-8?B?Q3k1RFFYdUhvUm9TbkdOaEdWaG4rMFRiTmVKNWlhVmhsaGJaMVlDYktraE1m?=
 =?utf-8?B?ODd4ZElvb2pNNFI1Rm1xT0ZBaHRCVlMrcEZNMGhyLy9XaWdaTmN6N3Q4dkVu?=
 =?utf-8?B?b1dCY1FQUFVialVHL1JrR0xUSTlPcTljVFI4NHN6MFQ4ZmdHKys3ODBGbTRO?=
 =?utf-8?B?RUpDT0dVR0szN0E5VEtWMzhobFo1UlZqcjVvR0QvbVpjZ0srL0l3YVBWNExw?=
 =?utf-8?B?Q1I4NTUzRHlzUForc2xJZmZHalpTZHNjbU9SdlZRR05RVVk1Q3RHVnowWGh5?=
 =?utf-8?B?T0ZzQW5XWGQ0TFdJcTNFbCt1NnpFODZtSk9SZUF0RlNIeTJ3QWRDcmFQOFA4?=
 =?utf-8?Q?2/w/Bkf5NAKzq5iF9d8dD2J4tfZoZQO5emdcI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGNaaG1Cai90dXFsZ3p0WmRzTjhxL0F2RWV4VlJnU29qUUtTN0ZZNG9WTHFz?=
 =?utf-8?B?NG9UQ28xWmhwREpEZml2Q0xrcVhBd1crQUZUZlhkYldkNm05WnB6ZVROcnlw?=
 =?utf-8?B?U0hYd1VhOFpYR04ydlM2RFpkMDlWVWpiQzBkKzk2Sk94bmFpc1E2WTRXUkox?=
 =?utf-8?B?ZllzKy9ySkhKSkpKTUhFTXlOMDdxbUx4d3ZGK0lrWXo4N2pHNlowOU5PdVgy?=
 =?utf-8?B?TUVnQmJxOUZYaFJCRENFUEdZZTJHZG5TdG1IOVVhVkl2VVFXbkd5R0JZMUlO?=
 =?utf-8?B?TVdJQzQ4djBMY1hKQ2FTOHhrVDA4NFQzUEx4aXpQQ3JmWlhubmViYXg5aUR1?=
 =?utf-8?B?cDQxN3NhaThqUjdxZXhPMXQ2aVg2cnVMUWtnelNESVdqdTdtUWp1Q2NOR2Iw?=
 =?utf-8?B?eTBQN21DV0o3c2VRVHNSTkRlaWd3ZWIxbnRsczYwVE1qTy9OSjdCUHdVWXJu?=
 =?utf-8?B?Q1hnUFk3U3VJYVdVRDM2ekN5UG5YVDhQQVZ3ZTNkYlJWczZsQUtXT1Q4RzZv?=
 =?utf-8?B?NzA0aFJjOUwycGRiZkcvaEZsOWNPN0k4b0p6L1NIYURwSTVDUW9tVWdSME9u?=
 =?utf-8?B?bTRZVnFCOUN6NXVyUWU4M1JBRWV4b09vdHpBVW1kYm9mdjJhbXpLUVE0Ni9D?=
 =?utf-8?B?bTBTYUJyVWsxc3pjUlJCdzhMeGVON3p5SVZMdEdUakVaNjhPSEtxOXBlQjlN?=
 =?utf-8?B?bFZYb1ZOV0I4ZGV2OENiWThteVFBQmQ2S1dkVnpWRG1BTzdpT0c0TEQ4QmlC?=
 =?utf-8?B?UTJ4ODEwNWRpT1hkMko1YTF6VTZoR3B0Zk9tbzR0c3VXN1paWEpYY3BOeHEw?=
 =?utf-8?B?aWd6YU9kV2Qza1Btd0hMMGxKRWc3ZlFINStPSlhrbGpyYVFlTjN0U1FNUkFk?=
 =?utf-8?B?Y2xzK0lsbHVxRXltc1lvZHFZRzBaVXRHOFhoV2hOczFzV1RBMUhDZC9YM1Zm?=
 =?utf-8?B?UmdvMmRBcFBpSnl6ODFJVU0xMk43bEtyeXFBdlE0enlPSVVOTFI3dkVnczE5?=
 =?utf-8?B?Q2hxaDFBVWFJMGJRSDF6TXZWcjQ0RVpMNWR6eEFzV1dJYVZOYlFZS1NHZU0z?=
 =?utf-8?B?djVIVlZ0aTQ2Z3RYWEZOdWZxTS9zRmtWTW5hVDhRVHh5M1V2UjV2Z0RER1hU?=
 =?utf-8?B?bUtrdFk4NmNkZUVacmNYeVdQdlpuZXc4NTFJMDJSd0dubFlkdzBwa2kyMjFo?=
 =?utf-8?B?Y2I4eFFIWVRscTJEZ0IySFd2NHUvd2pzZTNXUTlnanJmOE9kSnNsS2pjS0x4?=
 =?utf-8?B?YmxIeDFvdGptZlNkT0VnY094a1JSanphd0Fwelh1OXlOb3UrSHpRL2kyOE9M?=
 =?utf-8?B?eWMrM1VXUEh3MDFoam50Qzd6VDEzVHlaSGpZcWx6UHYrQWRBN3Fjd3gxdDFP?=
 =?utf-8?B?eHkyOUVWWGlHR1VzNVZ5NWgyaDVFRDloVE5lMFJ0QTNlaGhPNExWOWlFOWYy?=
 =?utf-8?B?VE9oNllacmtFWjM1Y0YxdFgrL1dRVWhJZXdCTm1zUVNsT21raUcvZUpTRDlT?=
 =?utf-8?B?eWdWZHlZeUg2RVV1a3c5RGpPOWdQSzc4ems3ZVM2WndHQ1VsdkIrT1ZaQkNp?=
 =?utf-8?B?eU8yakhWb1l2d1lTOS9XQzlGc3Z6ZWdlMjNyNEZjQ2ZXVVlhQ2lydVVIVUNR?=
 =?utf-8?B?YXZaUi93SEF3ZXFEellWOFlSeVJyU2wxWjF5dVV2cVcwNHJNVUo3T3lvRFZr?=
 =?utf-8?B?WUZxS29neDBlQ05VcmY3dUxUZitpYnNPYUdTdFk0Q3AwSy9yS3NzVVhZNUxW?=
 =?utf-8?B?ZmZoakFtSHZ4Y1FuUnFLai90bHBySGs4VkdlOThmcnUrTEdxd0NQcWh5c3pL?=
 =?utf-8?B?MWNOdW9HRFRaVzhnY0JGSTYrK3d4UktSSkpEcGxOMDM2eG42M3h5bE1mUGVj?=
 =?utf-8?B?bjdmWk8zOHpadjNXNWhMaUNSN29DcndNOGZaM3BhcDZnMXFONUVFYjlTS3hn?=
 =?utf-8?B?eTV3OHEvNEhNeDhZcW5HWXhzM3pMeFNVb1VPWWI0TVR2TDdGZGQvcWhpdW5U?=
 =?utf-8?B?YWJ4eDZRMy9VTmdPd0l0YzJ0VnZpNm5LSDVSWnpQRW93T2dFS0tPcUp1czRC?=
 =?utf-8?B?M1VhQWdDVVNweUpKU2V1NUpFenRmZ0JJcVpZSklScUFRYVNIUTZkenA2VUdE?=
 =?utf-8?B?b2M4YzlGTVVZL0JoQ3VDd2NINU9nSytTemJmdHAybUZGZ0xjV2kvWTIrQ2hs?=
 =?utf-8?Q?hBevqy9F1WjFGu9XHwO1fu0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07af6954-33cd-470c-78ea-08ddb9a0aca2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:43:10.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuRBDJ31Q7+zfvW6eDBFNSyj/CCU3k/Wp6kvK9R+KBCJosDNBZPtQDz8PlsVOcYFO8wkJeOmyqq4Qxp9eQCF6qX0QVyghw3kLmwo1Gyi4fQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5930

On 2025-07-02 15:21, Steven Rostedt wrote:
> On Wed, 2 Jul 2025 15:12:45 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> But you are missing one more thing that the trace can use, and that's
>>> the time sequence. As soon as the same thread has a new id you can
>>> assume all the older user space traces are not applicable for any new
>>> events for that thread, or any other thread with the same thread ID.
>>
>> In order for the scheme you describe to work, you need:
>>
>> - instrumentation of task lifetime (exit/fork+clone),
>> - be sure that the events related to that instrumentation were not
>>     dropped.
>>
>> I'm not sure about ftrace, but in LTTng enabling instrumentation of
>> task lifetime is entirely up to the user.
> 
> Has nothing to do with task lifetime. If you see a deferred request
> with id of 1 from task 8888, and then later you see either a deferred
> request or a stack trace with an id other than 1 for task 8888, you can
> then say all events before now are no longer eligible for new deferred
> stack traces.
> 
>>
>> And even if it's enabled, events can be discarded (e.g. buffer full).
> 
> The only case is if you see a deferred request with id 1 for task 8888,
> then you start dropping all events and that task 8888 exits and a new
> one appears with task id 8888 where it too has a deferred request with
> id 1 then you start picking up events again and see a deferred stack
> trace for the new task 8888 where it's id is 1, you lose.
> 
> But other than that exact scenario, it should not get confused.

Correct.

> 
>>
>>>
>>> Thus the only issue that can truly be a problem is if you have missed
>>> events where thread id wraps around. I guess that could be possible if
>>> a long running task finally exits and it's thread id is reused
>>> immediately. Is that a common occurrence?
>>
>> You just need a combination of thread ID re-use and either no
>> instrumentation of task lifetime or events discarded to trigger this.
> 
> Again, it's seeing a new request with another id for the same task, you
> don't need to worry about it. You don't even need to look at fork and
> exit events.

The reason why instrumentation of exit/{fork,clone} is useful is to
know when a thread ID is re-used.

> 
>> Even if it's not so frequent, at large scale and in production, I
>> suspect that this will happen quite often.
> 
> Really? As I explained above?

Note that all newly forked threads will likely start counting near 0.
So chances are that for short-lived threads most of the counter values
will be in a low range.

So all you need is thread ID re-use for two threads which happen to use
the deferred cookies within low-value ranges to hit this.

 From my perspective, making trace analysis results reliable is the most
basic guarantee tooling should provide in order to make it trusted by
users. So I am tempted to err towards robustness rather than take
shortcuts because "it does not happen often".

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

