Return-Path: <bpf+bounces-63603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD99B08DED
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAC0188FCAF
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 13:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED1E2E0925;
	Thu, 17 Jul 2025 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nhsKXxxE"
X-Original-To: bpf@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021141.outbound.protection.outlook.com [40.107.192.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99CB2BE059;
	Thu, 17 Jul 2025 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758088; cv=fail; b=YdYfIJ76A2nIKkc6KIPM/3A7kOR/A6XePdUGImtuwEo+l200LDq/AYIyTCVjeFCyq7ghe0wd+vlvt5ayT/t4AnY5OP7ElWx1RJN4pDDFjCOckn/6R1bHan0G4r1ElcT29y9cahhHAXxHgD3/MyloZPL6QLcJRZbG5cS3kc9DLCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758088; c=relaxed/simple;
	bh=NllZaBBg1ICoEoqvW1c+FHMoBEwWAKcvD4DbGpRNiy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CmI6nuh37HehCjBoJdqqB7DZBAWtcDFqlUlXU6zxqD8MEFRb/Of71RI2gAvLITjt2++KspcyHECpzGak8+Cym4f0qgaytDKFu5nX8pLimODR09W/LEaYmEusWWdNnTXJh4UV9AlCkkUexFVyup8Wniymup8MmJj6PLnoYsQREMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=nhsKXxxE; arc=fail smtp.client-ip=40.107.192.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmmo9Qy9GiLLXeHQGAIwm6OEbnK9Qf/pvesBr9lG6cdnPMq01xP4SgPyYliUVH5d8ZDuh1Z46bkgOAdDyIU1PYlkSzf2WV6+dOF+wJl8Rz37KpTyBBjImEvDvwkXYvoTIoXFHxxIM04EiKwI9FF+uf1Uem6IIEPophN1QhIeYpV0yBwxM7tJMib/ZFaTU1If8ZIgXnsCe/mQldlhrjX+GyISwviqgS3z5B/Ei0F7DdMt9BI0gSPhbTi2R8VtPjFDh7LCLvxdmwu8YCCiBQ0Jip+jhNQz9zuoI5jYiGCKiSnS2TKhQqEMgQKBN1IYrj1mwdHtU8muiz7fnSs2sqoJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiX2oupdB9ELCTJGX2Wu88Xt2QjZS+B62BgEVcLLB9I=;
 b=hpSRfnTIo8gJrRy5y37wnuRK+idfAJmf1cUEZX+NkYAViUDmnKfF/GVVDjNwSVUmunJ6MKqF061g7+UkCvwnkYczQYlEYm6Ga+Mv4uqWu0wua5DqDVh60jezfWDOfeZeJlHzq/qeGBl0f1tIIQXFAwuhb6y0T6L9mseIJUUsIN9tX041/P7iyyuz7piU1K4brdbqui8WNRtApnGJCAmmhX4CvtRc0I4YmZZqi1XOL+tEH2UJpklPesmLERVXiK7xWQqoT1IU3pr9F7J5azxt9lUmN/U/Xd1+AfvBaUmOUuNNyZx4TTlN6CLTnHBl+PFp25B/DMOK6+KRNWK0sTvTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiX2oupdB9ELCTJGX2Wu88Xt2QjZS+B62BgEVcLLB9I=;
 b=nhsKXxxEFE9Gmb/MiXio0OibZ4XA8s9Y2KD0tHKxH09K/nVTsgNDimBGa7eYdyEsaiBIoBjH8PQJii+vY/Tr6XMhgHEgkFM6JaRbrWIpJUBea32RJR3sCg8mvOkRrVMh5YZrZ1KNjmzf1HVnzPT9jTvRkAwHPKfd+7Ar22VvGHx4gpIllDntDVdGxH/95xXddOSx/HUsnel8NjISNQHDkKDxCVhIyfybLFQ/N/eTqq7c7kgntVWwTAyjbdd7u5mRzGpPdZLBwCeRIhQcXqmg2fxnDRfRIuK+kZZrkOHlHuRbnsFJ3dcAiH7dMkg46T9H8Bw30kWk2ysCG0e8Xfmhug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5918.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:58::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Thu, 17 Jul
 2025 13:14:43 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 13:14:43 +0000
Message-ID: <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
Date: Thu, 17 Jul 2025 09:14:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, bpf@vger.kernel.org
References: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0178.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: ad458306-8146-44d8-4a7a-08ddc533e4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGk1SVVyTDIvS05aT3lWcGdyc05meFA1ZjVFRGg1eEZaMUoxeXJLSkZ0Lys3?=
 =?utf-8?B?QjRjdW9SL0FIYzRXdFpZQVR0ZHJrZm9YeldjTXNTeEtBeFFtY3liUS9NOE1R?=
 =?utf-8?B?SDJTYkhWeTBFU0RBcDhGRGNpeXpuMjFrb09sR2RWcFBZNW1JM2F5TTZCbHBK?=
 =?utf-8?B?K2FrVWg0L2VDQzJUUGhJVEorYXFZVHJEV2Q0SzVDNmQ4c0l5UFdlZEpvWElq?=
 =?utf-8?B?ZTJ4L3Jod3Z2ZDFIZ1BQVjNJVGhBK1lXM1kwMmliTkhxcGVjYVJtL2tCOWJW?=
 =?utf-8?B?dk9FZXZPUnpHL2xZN29pZkV6Z1BhTzdLanBjL2Z1VDlCd05zZGd0NzhsRk83?=
 =?utf-8?B?SGdXMDh4NGtuUUlabHNHeTNKUjZBYVBJM0d3cGpRMlcrU1NMdEdVYXlXT3lt?=
 =?utf-8?B?cjBBczlEUUdDdnVmK25XdVhLT29rcjNSUFlrTThzT2gxVFRGS1RYNjZFNUdT?=
 =?utf-8?B?a25BVERKVGZSQkdYN2dRTW0rSHEzV0JoQjFQbjdxT1NCcFZ4bGtKcys4VEVn?=
 =?utf-8?B?eU5uNENrSWNiSmhqK0diOXJpbzhCZ0JRS1R4ZGVsL3Faam92c2xuODk3dm14?=
 =?utf-8?B?OTk1b1VCOG44Ny8wc0YxMXlYSDQxYStoODd5STdwM3FWTGhUYWRFUUplWGRp?=
 =?utf-8?B?SXkvenVqcDE4bFlRa2pOUmlwbzBTRDN4NXYxTVN2bmlKODB5N0prQ1FsbFJr?=
 =?utf-8?B?WGRmNUhDNk9raFd6RWlsdkUxU0lZQkFiZ0R5ZkRURkpSaWNWNU5WY21mSkdU?=
 =?utf-8?B?RTd1SEdWcXN0aHhQeHJEQUNpZlVZcDc1V0JtNlBVcWJEdkpmbmIrcGZncmln?=
 =?utf-8?B?bzRKWGY4T3RjZVB2Q3hPcEVVSkxPZDAzTUNYdHFUZTFOWHYzR1o2SjJ4MGNZ?=
 =?utf-8?B?K1JFTVNNUnFGcnpJOS9VWUhGNUVoQkR5RWQ3Z3M0TkZNakM4d0xjcW1VaEVp?=
 =?utf-8?B?SHRncHI5WUxFZ1dpNjdDaWFsalo4T1ZhK0I1UXRkYUNvSTRuQjNPT1NYSmxy?=
 =?utf-8?B?azcreE5rVVFkRjd1N3JQR1R3Sm5DNHMraGRmWU50ai9sWlRTSEJ1N2Y4RnpH?=
 =?utf-8?B?WDZzdU9qdjVEM3dhMS8zN0FQd3VtaUF0WW8wZlp1SnIxa2t1RHRhNU5QKzM2?=
 =?utf-8?B?ZkM3MGRMWXJ0dWJmVTBGWUhtMXRoWVJSbTAwR09GTnkyKzFTcTd2anprYld2?=
 =?utf-8?B?eGYyajNyYmhmR09FZkpFckF0bGRBOTQrcXVmcWFjZkRoOGVKNDk0Q3crOXVB?=
 =?utf-8?B?V0h3dmFoejlJU1BkMVVFZWVqamx0RWdTUWFHRkJnVjNFSG1xYUhkWm1DL3lK?=
 =?utf-8?B?NHN5WW1wWFdpV2dMOFEwVTkyRjlRdWoySmVTOGpaUDlhenZNTFN6NXZmMmdy?=
 =?utf-8?B?djVLZkZnSzI1NldZRWZ5MUpKcldKVXI3U1NFUnpWNHR6cy9sL2hJZ3kvMHZG?=
 =?utf-8?B?WGhCekJVMG82cFJtY1B5cFhvRVZ1dVNyTzN2RGJLODZVb1FUaWJzTHNwdE9B?=
 =?utf-8?B?WThMNkpSTjdZUmlDbDNNMG95MGlYQ0E2Z0xtS3NDaERCM1U1dG5wbS93SzEr?=
 =?utf-8?B?R2crMDc4bVlPMEJxN2VJZXpheFFjOWRBeEt1QUViaEEvaGlZdzBDYmtOUkh4?=
 =?utf-8?B?VWtBNDFVWW1mSVNsN0JKMTl6OStqcWZSSGFhaHB5cHkyaTR2SGFhT28rNERY?=
 =?utf-8?B?VWkxeTNDOHZBNUR6SnZxdzlnQzMxK09WWUp4M1FIQVlnRlJWQUFGM1FNcXdx?=
 =?utf-8?B?OHRscXBIdlBHQUZFdHRqdUtwZjRWcnBVMUJaRjdoclFpU3hFazBIa1BZTEpW?=
 =?utf-8?Q?+2XVwK992GY/gl4HbWiI1/Od6STY+HBAJlAU0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NURGVUtvcVVadEhZMGZ6aHN4R0VnckNlTTdBUlJyeml2Rm5OeDUvT2FsRHlW?=
 =?utf-8?B?N1JRTGJYSDJYdW5OWXpBMzFpczVvaUw5aGtGWDhvL2NXNENnMTV1NmtNQW13?=
 =?utf-8?B?dU0xRTVFS0xsLzd3NWhHeUtUNkE5ZFFSRUx3aDJjRDRxRm9scm9oY0VaTDRJ?=
 =?utf-8?B?MW8rTENlSU5vZENyYU5keWxjSU9WMDJMSkpYL05GY1Zad3hsK2ZXU2ZMVEFZ?=
 =?utf-8?B?T0pPYU5veS9HeDNhV052SDErOHJLejNWS0xjT3ZuUmx4UTJHNFByN2ZENjZx?=
 =?utf-8?B?MUVNTkxaT3dNckpoWVpHUDJ5MVBBNkJ4cEtmL2xubWd2bkZjdWE4QTRRM3VR?=
 =?utf-8?B?N1JvMDFhNHV2bGpQeWVScEswV1NHQXhwUWMwb3RpZE9HbllxVGZ5a0NoeU9M?=
 =?utf-8?B?VEl0OTZXaHRxdlRnbnJDWDU1YUhnMFhOK1VmWkJTZkRWZDI0bW9ENCthb0Zs?=
 =?utf-8?B?K1YxNnVESk9zdWtySlBIbHJRMjJJNW93dVpPMCttN2FrbnE2bmZYRWZkeUQ2?=
 =?utf-8?B?dXBINEhtcUVINXRvRTh5U3NKNkxVeFBubWhwSWgwMFU4SHg1ODVRV3ZDZWNK?=
 =?utf-8?B?UEFqVXJ2TmZRWHF2U1NyUFZ3dDMrajZLR1ZueCtCMVI5R1l6RTl3cnRHZlV2?=
 =?utf-8?B?VGpxSG81dmNkeEFZWUdjRjE1Vk93THpvNXdiWDcwaVNTSW1Yd1M5Q3o1TWt3?=
 =?utf-8?B?S2IwSmlZUURQU2pCa1B1S3BVTmJ5Qm9sYkVCQlExMnMwM3RUa2Q5SUFVdkhj?=
 =?utf-8?B?MWs5WVhpemdvbFU2V0pHSm1TdTVFYVg2TG5rTFMvQXgzVFc0aFFjRTd4K1B4?=
 =?utf-8?B?UlgwMlh4MmY1cWdYUTRLbG9ZUjBCM0NkR1Joa0NHamZyelcyeC9obWk5cEp2?=
 =?utf-8?B?RHFSV21ncmRwYUdMdmNwdkFqUGZvMlJiR2YrdVVzZUxyTyt4QmFtWS9hcjY4?=
 =?utf-8?B?ZFNPRk85WEl4c0djV3BJK0NaWkd5ckR0VCtHeVdxZEpmN2pGcmtmYzJacENT?=
 =?utf-8?B?U1ZJTzNUYnh0ODJpNjJMVmVUeGJhWllib2I1VHkxOUFUdzUzKzJwYmVzV2pV?=
 =?utf-8?B?REFYbTNPTkM0b1c2Z2RpUEF6UGZ6dFBmK0hsSVFRS1lFOUIxVSs4T0FuSSsx?=
 =?utf-8?B?S0NWU3NPZ0Qzc1hpbm04V1plS0VKLytlbGpSSkV1a3VaZTlMbENWdGxFNXR1?=
 =?utf-8?B?eGxGVzh0ZkxtRDgxb1dIbnQzQXR1U0paZjByeEtYSlpTOWxsT1M3SjBQKzI4?=
 =?utf-8?B?YTFiYTRmRWNSeUhTVlMwZlBxbUpWSkNvek96T0s4YmNqbnEvb0NRSWhLT2tV?=
 =?utf-8?B?bXY3R2ZoWjdrR1krOWNRcnNmYkhiUEY2aFhvQzlmTy9IcWI2aFY1MnVnVFp2?=
 =?utf-8?B?Z2p1NkdlQWdudllDOVp1U3FTbm54Rnpxc0Y4NXNQWVpZb2NsU3NQOTY1d1pE?=
 =?utf-8?B?Rk5kK0dSd2FuVWc2aDlId3RMUDJPSlZVelpuR3NrdU5pNjJ5aVZ0RVRueWJ6?=
 =?utf-8?B?aEdUQzJiTTd0OU1yR3cvS1pDaEtlbnBvaEVGQnA1c0s3QTFiQVhrSWVCcTBt?=
 =?utf-8?B?Y3JJWXRuQUw3ZmVjS1ZMM00xYTFSNVFBS24xZjRkb1RWVjRKdk9BRTBZOHFT?=
 =?utf-8?B?TXpqVGVKQURJeHV0QWZtMFlnTk1vdUpVVnhwOHRIWDRyUmlrRWFSUktNNER0?=
 =?utf-8?B?UlpGR2o5L1pkTXgxUzljdTlQeXNGb0FLQVM3VVBzSUdiRnI2SExVMXMrVXJN?=
 =?utf-8?B?VjkwTy9DbWNVbGx0bm82L25SVUpRYlBINWlWTlNGTVBNeDI3anhtb2MyMitZ?=
 =?utf-8?B?d1BjVWR2NVVKZ0g3c1MwNWp4Z010VHZkdWlpSXFPQW1wZXNOWTgrVmVBWDkr?=
 =?utf-8?B?TEdadFk1SVNKOXpBMzRrY1lhMWVRUm9oWkJJT1RDQlZOT3FwaS9RWFJNOEdi?=
 =?utf-8?B?UWdKQ2VvRkxnaFFXSGFlRkZiL3RDOWxTQkt2SnI1N01ldkZjVGxKSUMxUGJH?=
 =?utf-8?B?REZ1disrcC9QMXA4UkFxdnQ0S2U5alJoMGpBcEVHY1NpZTRSMzdyL1RaRWta?=
 =?utf-8?B?T3JFbHlQbmx4N0ZXbHIzV1ZZUm55SmVoZitGTlY2a21KZXIxcXVGSHFBZEZo?=
 =?utf-8?B?YkRYYnl3bFNscEpkM2FYWUsvcEhEVEtJOHNKeFJHUkFOMFFkRE9TTHFJVHJE?=
 =?utf-8?Q?FOpXvDAxwxXE3n4lTyJQj7I=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad458306-8146-44d8-4a7a-08ddc533e4b2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 13:14:42.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQKu7ihLl8PjhhXZvyF53LMQjFuXggoRR1g6Z2oMx0pR2ANeQhxa71Df5txbMYbRasJM5HAPIqwXMjD6HeJ49heyanHOMuZAe0Zes2nyw28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5918

On 2025-07-16 18:54, Paul E. McKenney wrote:
> On Wed, Jul 16, 2025 at 01:35:48PM -0700, Paul E. McKenney wrote:
>> On Wed, Jul 16, 2025 at 11:09:22AM -0400, Steven Rostedt wrote:
>>> On Fri, 11 Jul 2025 10:05:26 -0700
>>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>>
>>>> This trace point will invoke rcu_read_unlock{,_notrace}(), which will
>>>> note that preemption is disabled.  If rcutree.use_softirq is set and
>>>> this task is blocking an expedited RCU grace period, it will directly
>>>> invoke the non-notrace function raise_softirq_irqoff().  Otherwise,
>>>> it will directly invoke the non-notrace function irq_work_queue_on().
>>>
>>> Just to clarify some things; A function annotated by "notrace" simply
>>> will not have the ftrace hook to that function, but that function may
>>> very well have tracing triggered inside of it.
>>>
>>> Functions with "_notrace" in its name (like preempt_disable_notrace())
>>> should not have any tracing instrumentation (as Mathieu stated)
>>> inside of it, so that it can be used in the tracing infrastructure.
>>>
>>> raise_softirq_irqoff() has a tracepoint inside of it. If we have the
>>> tracing infrastructure call that, and we happen to enable that
>>> tracepoint, we will have:
>>>
>>>    raise_softirq_irqoff()
>>>       trace_softirq_raise()
>>>         [..]
>>>           raise_softirq_irqoff()
>>>              trace_softirq_raise()
>>>                 [..]
>>>                   Ad infinitum!
>>>
>>> I'm not sure if that's what is being proposed or not, but I just wanted
>>> to make sure everyone is aware of the above.
>>
>> OK, I *think* I might actually understand the problem.  Maybe.
>>
>> I am sure that the usual suspects will not be shy about correcting any
>> misapprehensions in the following.  ;-)
>>
>> My guess is that some users of real-time Linux would like to use BPF
>> programs while still getting decent latencies out of their systems.
>> (Not something I would have predicted, but then again, I was surprised
>> some years back to see people with a 4096-CPU system complaining about
>> 200-microsecond latency blows from RCU.)  And the BPF guys (now CCed)
>> made some changes some years back to support this, perhaps most notably
>> replacing some uses of preempt_disable() with migrate_disable().
>>
>> Except that the current __DECLARE_TRACE() macro defeats this work
>> for tracepoints by disabling preemption across the tracepoint call,
>> which might well be a BPF program.  So we need to do something to
>> __DECLARE_TRACE() to get the right sort of protection while still leaving
>> preemption enabled.
>>
>> One way of attacking this problem is to use preemptible RCU.  The problem
>> with this is that although one could construct a trace-safe version
>> of rcu_read_unlock(), these would negate some optimizations that Lai
>> Jiangshan worked so hard to put in place.  Plus those optimizations
>> also simplified the code quite a bit.  Which is why I was pushing back
>> so hard, especially given that I did not realize that real-time systems
>> would be running BPF programs concurrently with real-time applications.
>> This meant that I was looking for a functional problem with the current
>> disabling of preemption, and not finding it.
>>
>> So another way of dealing with this is to use SRCU-fast, which is
>> like SRCU, but dispenses with the smp_mb() calls and the redundant
>> read-side array indexing.  Plus it is easy to make _notrace variants
>> srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace(),
>> along with the requisite guards.
>>
>> Re-introducing SRCU requires reverting most of e53244e2c893 ("tracepoint:
>> Remove SRCU protection"), and I have hacked together this and the
>> prerequisites mentioned in the previous paragraph.
>>
>> These are passing ridiculously light testing, but probably have at
>> least their share of bugs.
>>
>> But first, do I actually finally understand the problem?
> 
> OK, they pass somewhat less ridiculously moderate testing, though I have
> not yet hit them over the head with the ftrace selftests.
> 
> So might as well post them.
> 
> Thoughts?

Your explanation of the problem context fits my understanding.

Note that I've mostly been pulled into this by Sebastian who wanted
to understand better the how we could make the tracepoint
instrumentation work with bpf probes that need to sleep due to
locking. Hence my original somewhat high-level desiderata.

I'm glad this seems to be converging towards a concrete solution.

There are two things I'm wondering:

1) Would we want to always use srcu-fast (for both preempt and
    non-preempt kernels ?), or is there any downside compared to
    preempt-off rcu ? (e.g. overhead ?)

    If the overhead is similar when actually used by tracers
    (I'm talking about actual workload benchmark and not a
    microbenchmark), I would tend to err towards simplicity
    and to minimize the number of configurations to test, and
    use srcu-fast everywhere.

2) I think I'm late to the party in reviewing srcu-fast, I'll
    go have a look :)

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

