Return-Path: <bpf+bounces-45579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 377B59D8970
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 16:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1D62864EE
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C5D1B395F;
	Mon, 25 Nov 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZN3LI3MR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206A1922E7;
	Mon, 25 Nov 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548950; cv=fail; b=r+fGDtcaaM3zHCsgGm6cgeEwmiheHQG95ZnGOTOYI779aBG6hpAUFvgmAspl2ljO3PMoVb2qWyayupawyoEuH85dzAUSDys7g8vhvedt79KxoHoY5ob1AhyEoc6C2c7pGO8QmGKJRH98OFg35V22m21N15ExwCrtCIsWKC5hqHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548950; c=relaxed/simple;
	bh=0k8mjuiwryOyjCOz2aRYlkmd8O3jZb63rfpDLabVZT4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NIj2mcXmAbJi4vYsZ8oD6PqTJhd2795kV5Wa4rWOLj/SV6VM10q7nRhnunYSPLSczo0ikJU7lmoQamMVVvD85gy14qM7gON0regGs6T++zZEYJ+WQ5pA0hOuloHnkZ3eVzWlkrsEpOmctUJqiXMqDWCEvmR4zQm6u9i+U6aFPcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZN3LI3MR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732548949; x=1764084949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0k8mjuiwryOyjCOz2aRYlkmd8O3jZb63rfpDLabVZT4=;
  b=ZN3LI3MRQg9Dxw3EztFDbJHoOOi5lCnr6SmKAozvtgQJHLTnOqtMDSzd
   dMZibfKptD2PCG2czFCCAJqu+pw0iz8EeR7z0dkzNNZLeBNVq+FkuvX8v
   PedBW6XIZZJVwPUx+HCdVEj07GoqnsUGnuRBqjLJdbj0Iqu/NpnW8OB5T
   mHu+ubvNoBaPNQiOfjnkBgWljUDF5LDWYUSmRcOxh+rQWLrTZkYNPdbxQ
   wR390T7FOXJSQgc06kWr+KOTJn2r+W/AikTZQdDraQB1cZYa3mUbJI8/A
   jM0QMwyiTLI6g3nlETu3CzNgsA88ejZicveaOm2+uGERSwfXRdtCxNgQL
   w==;
X-CSE-ConnectionGUID: 2mQZS/U/Si+XAYMqpns82A==
X-CSE-MsgGUID: KvZG47A8T52NR10cZIyJbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="36444300"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="36444300"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 07:35:48 -0800
X-CSE-ConnectionGUID: A04E+i/pR6yzZpb+N6swZA==
X-CSE-MsgGUID: r7VSqIq6TKuweaU7e9RYBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="122241713"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 07:35:47 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 07:35:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 07:35:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 07:35:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niLfEdnGCD/8Ma6uTDuCS7x5bsSAd/MSCWzJSg8oPm3oFLRJQN4BzaEqMcLJlKeaC9WOeWCN70gQhMwmx+qj6HiAiE8BlqdIyJdmLSCUfDtzBbN0UKRixERNkb+0wAN0dIiobcoDGJY0IbsZ7JM/gTwg2FkxsWuo3BejfwKSDwy+uxKPw4JXhXsUZgeDR49hWBH/DXHODW0nzEOO17l9R/9kS/0WcrCyMJMmwYFPp4wdATAjHlhjCqbsBzmCtWghUI3gNr8u8zKbxgCIvdSzi2DksJbXQpjQUJhcNBbqoawWPMLMT/+DBLA8VP2jgJISUITPB6J/Pn7HLQPkJFOzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9s63GfHA/Z95OklMCivIBV7xWLBAChYhTVaw6W/gX8=;
 b=k1XvtVIDFrOtIas1w2Zf9ofEltVY4PwkyldZ7sGRpWtP37HTZak9KMY893mwENBxSMUuwkxDCJ0bWlXvW2KfwU7z95vAWt3p0gyNNbPZaEeTsB4rJ1IiiUZc25wnwPhJs+oqz95xeDxfhex9emEm8zBddmdzEPZVi6Nhzyk74VzQ3o8ocAN4MG1Acxdc0Jmzh9XQ7pVdQGYbZ2DfocnQbP4MRFc400HxwbhX3X3lFqAkIGXu2fwOa4cKuY6U+Ojluk9XDZ6TS+nMOwrDTNv2HCUOC9WOtDyoUiERZxsNoCYz/ZFmXbnMuaKhTWwNCfgzgq88cKYZz1QEgpgNGslP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 15:35:44 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 15:35:44 +0000
Message-ID: <c70b4864-737b-4604-a32e-38e0b087917d@intel.com>
Date: Mon, 25 Nov 2024 16:35:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from
 __DO_TRACE()
To: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	"Michael Jeanson" <mjeanson@efficios.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song
	<yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>, Joel
 Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>,
	<linux-trace-kernel@vger.kernel.org>
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
 <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com>
 <20241125142606.GG38837@noisy.programming.kicks-ass.net>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241125142606.GG38837@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4fa613-e85d-497b-4258-08dd0d66d333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3Q2alBMcHJUZ0lSc1UvVytBNDZ3RjlHM0hkTFlqdjZNVmpKQk9TMmpjaEhN?=
 =?utf-8?B?NUtMS2dkNkNWNzdjcXpNVkpuWEpTVFBBOHZlQzEwaHVEcnp2K3MvNE1iRXc4?=
 =?utf-8?B?aTVBWnk2Zzl5Y2twQWF0YlZieGZySklISHN5aFFtQ2ZZaExDVmlVdG9naGcr?=
 =?utf-8?B?V3lhV1lkRHY3Q2RudTJzUzA4bExxdjBhS3pOMVl3ZU5JbSswRHo1a0VhQ3RF?=
 =?utf-8?B?Sjl6MWZHS1FPSHZ3eXFxaGtyRmZRUnQrU3JCUXBPNjFia2Vnb0ZFSVEwS0hY?=
 =?utf-8?B?emMrdEVScXlVaVlhRmROeVdPNWxwbW1veHBuRXRud0tiNDhrVXEyMXRmakVl?=
 =?utf-8?B?eURhUytqa2J1M05JK3pkSHJ1MklySFkyZllrY215NHcvVSt5ZXpOZExCZk1V?=
 =?utf-8?B?dVFxdTdVaW5tMGcwK0RkbU4xRWxnS1hZU2JlWnJPTEJVdnpZdjlaM1RnQkZC?=
 =?utf-8?B?aHUzSGhRdGFIOVk1ZjZpVUZFZm04WE5nQUc2KzNmWExCaTRTbS9iU2kyZkFy?=
 =?utf-8?B?eko4SnpnMW15b2FvaWFUbGpYMGhtVkhsR3NNQUg1T2pBdWV5VEJzTWJORDFQ?=
 =?utf-8?B?ZXJjcGprWVJ5bUVOOE82a2h4alJTa2U4Q2kyVVFWVjRSZHE4NnZqRDNYYTV6?=
 =?utf-8?B?Wmp6VEJ5ZC9qb0JzTEpveDhwcW5QV2VPWFVzd3ZtKzFrMEZJeS9pdEFHUWYw?=
 =?utf-8?B?ZjlyTXlFVGw5UGFGTGJlRENZbU04KzByYUU4TG5MeW0wQTlTR2dRRllXYmpY?=
 =?utf-8?B?cGs1S3hVQ0ZaK3lyQ09Mb1IvRi94cHZFcHg5VG1ENTZ1Q0thdmFrcTVpQXRU?=
 =?utf-8?B?U0t5R1VyT3N4Zi9BMS9BMzRwTDdXNzMwRWx4S1RBdGkwUEZEdVBQdFc2Njl2?=
 =?utf-8?B?QjQrNWhTeFZHaWVtSzZjOTJQSnMxUWhkeGZYeDJOeDI4R3M1cDdCM3pqcVF4?=
 =?utf-8?B?bnA5bkN4K1JDN0tWL2VxZGxIZ1V5UXVJa3hyQW0xdk9GNlRPZUZxK0VvWFJC?=
 =?utf-8?B?V1dZV1RZVnNtYlplb29CNlFZQXgvSVg4MjNqL2RobFhwS2F6UHJLZ0l3Qmhh?=
 =?utf-8?B?UDVXSjhHNjFUOWRqNVA1MU4xandMa1JTMHZtbkNoTGRlUHllemVxS2NQNjg4?=
 =?utf-8?B?VlhPUmluSVphMUwrb3ZxQkJDVDczaWYvUk8rcDlHbnZQd0NWRE9IZjE0cjVL?=
 =?utf-8?B?aXhzRDRaa2luNEpHb25oYW9YcEJiQUowYVFsbmpnM2cySGhDRFhpVU5DVkpi?=
 =?utf-8?B?S0JyZmlVK3JYbXdNVFluTlhUTE41OWswR3lIV2pkWm5EZmk4M052Z2U3dE4w?=
 =?utf-8?B?ekMya3doYUN4eGphU3p1SCswRG5OM3FpSlRVY2gxM2MzUmxRNVlxdExjdXJn?=
 =?utf-8?B?OXVLV2lZNzdSck1HRWpsWjgwZE5oVmVoem9yR2ZON1VmQ1ovaC9KZFc3Nzlp?=
 =?utf-8?B?UDFqUG9HaHFmQzNVY3BMMDRWYUk2UWVNMkdLaVdhbnh3QTRLbnNhY0xzN3Zz?=
 =?utf-8?B?RlF6OFBOSlJLN1NudUVJREJibjlacEJtc2o4enpuZHFlWGd6N1R4QnRXaHdr?=
 =?utf-8?B?UmpYTnR6eTZvdkZweHNXc1AyMkFwYlU2ZktrM1hYY2hsOCtCRTFuMUUzN2lh?=
 =?utf-8?B?YlJNWjdVeGFYSGwzREU0RHhZUUxHZHdlbG5Kbk5PNVBjeWJRZXhEdHNKSWNC?=
 =?utf-8?B?TFVXb29BMWcwVXgwZFR3cFhiZDFxWW9GaC9sSGVJTnA0U0dYVDlSTlVDVG1q?=
 =?utf-8?Q?L3fwTubY7+RQHx461g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk8rekkxVlNTS1o3UjR0ZVJWL0xtZXdvalFFRzFJZmRIRG50Z2IzcmlrWkJu?=
 =?utf-8?B?eFFEdWxTUUc5SGcrYmh6ZUY2dVdZSHR4c0s1Z21rWlpDSUwyc0dCZHBQeWRI?=
 =?utf-8?B?NFh6TXhLNVhqT2xzSFpCL3pQZTcxUFlmZURJeW9hT3dUQlZLaVk1OG5PdERx?=
 =?utf-8?B?YnVsZ1F3THQwd1VjWEpiQnpPeHNRRmptSVRGRGdwZUxMYllUaFhybzVqUWJR?=
 =?utf-8?B?T2VGLzhaVWJELy9sMFJIcUcwbElVWE9CWWo4LzJFWU5WM2ZXYlhYdDBKdVc2?=
 =?utf-8?B?ZFpRVVByblZ2NjU2RjdydDFyRUFNS1lkT2gzWEdPMlExdStxOHphYTcvZGVT?=
 =?utf-8?B?TmpMa3I5TEFPT1JtWU1Qc1YrdE4weHFLZ2VERXNGSGNvNVRhR0ZvbVE0RGd0?=
 =?utf-8?B?K2h1NVEwOVBqU1JLQkxFNzJVaVdOQnJkM3hzNW92cGdlV2UyR250Vm9CWlRO?=
 =?utf-8?B?MktaZ0JEUE5Wdkp2WnBPci9MS1FhUlhnOW9EOVV6NitFOUViVVY2SDViQXRm?=
 =?utf-8?B?K1IycFpwa2tlN1dzTW1CbFp3NGJhS1p1cHMxWlVoNUpQZmpxcHNYYVJyYTQ5?=
 =?utf-8?B?V1pMUkx5RlhGRGU1cmtiNkFyYjBuTThRMmpnMU5qZC80cG00NmdaeERLdEUz?=
 =?utf-8?B?ZFJnL3VrS2kwbDJtV1l4NzdnRGIxUW9rVWRyVGZZbVFPNzU1d3pZUWFvclg2?=
 =?utf-8?B?akdnTjZvVWh1WWRETjhpUlNOYWdZN2ZvNmZhUEQwdkpQR0x6RDljREYzTXNM?=
 =?utf-8?B?THVOS1NQMUpVNDFuU2hIL0tXNUUwNUZzcEhKTS82K2JaSFJoVVpCQkZmdmw3?=
 =?utf-8?B?V1JyeitUTnRVZk1EK2hXVW5VakVoTEFveHdHZmw4KzN5a2NvY3VoM0k2RHFz?=
 =?utf-8?B?aUxrVEpyYWZKV1UvMGFQcWFTbXRNck5MaE1DcEhmeVpuMkI2UkpGUXR1RUhq?=
 =?utf-8?B?VHlpWUw1MllOSWx4OG5IemdEeXE5Q2Y4anNrUXJhOWVZVkI5cTRIb1NybHVD?=
 =?utf-8?B?eTk2UHVwWTcrU0MvbUlBQ0JrQlpuTWhQSU5HSTdMNGwzOXhQa29QUmZoRG5D?=
 =?utf-8?B?RHhlTFEzNnlWYlc2Z3IzaytKT0hXV1MxK0hTaHVTdTFROFV5UDJOdDliQTdG?=
 =?utf-8?B?T0h2ZXc3UUhXVlJMNzM3RE5LVDgwbkxoUS85OGZ2YjI0OXo3bVB6Qkg1NnZK?=
 =?utf-8?B?MkxPQVVSWkR3RDdGVFBMWVlsTVE4V3Y3ZWxNRVltZGpoM2Z5enZKSUF3aXBo?=
 =?utf-8?B?bzBTY1FISHV6bjN4cDloNDBSVTMrWnRGcE84cU1oVFF5OGZXUEdkamRKRXlD?=
 =?utf-8?B?QWl1blhxQ0d3emJmbllzMHVTOWhvMytBaFpZRXhwNWM1R2xsc1JRNGJkNlVM?=
 =?utf-8?B?eTBMU0h1T1ZwVlhpaVVPRnd3eU93MFBMUkFyWEczSkVycTJzUWRjYkN6UnBK?=
 =?utf-8?B?NWJoYnhLazVMNEh5TWNiQkdnVENYT1h0bGtWL0JCb2dsKzFpcnZDQlhlT3lM?=
 =?utf-8?B?cmphMVpEK2N6LzlmcFU5RWJIQ1hVTksyVEdEWUJmQjhlZW4zUFJZL1p3Rkpu?=
 =?utf-8?B?cDVRcVR2S3dGUk9ZMGFwdnpVU0xheWNHNHN6OVVtbTJIZDR4SDNEdkVzaXFw?=
 =?utf-8?B?ZGJ5WnZSb2kxaGVlc1o0aW9KQVhQczV6Z01Zd3cwMWJUVTk5RWNORlcrVlNE?=
 =?utf-8?B?VG1ZTWpSM2N6V2xFRFl5NjNWelkxVDhFYVFLZmpCSmtWaHBwR1ZTbVQ4ZTQ1?=
 =?utf-8?B?aXMrSkxaWVB5LzFCT2d0SDd0S2JIeWFmMzdpMHREQWcyUG0xUnNxbVBPR3p6?=
 =?utf-8?B?VDdVMm5aNVBHNEwyOVlvbk9iaFFCbjlQaER6UyswZUgzeEpXSmpmWGhuUjdT?=
 =?utf-8?B?OWpyTlp5SjU2aUQ5QmdOMWg3MmpaQlNSbHUwMWh3YUtubnZ2MWQ2dEdOZERR?=
 =?utf-8?B?aU9uWCt1QUhDVEJYalRVakgxMFlqcUYxeGloanNGelN3bG9hN0pNRHltdU9n?=
 =?utf-8?B?L1E0V0pXOXJWbXFUcVlzTVoyQnFEajlMOVgvWDNlQWpBKytDZjFkV3pxSVRN?=
 =?utf-8?B?RHdKYXRscGI1RUorK2tyVlFSMUlxNWViZ0Z6cVlwV2tpU2VOVEJXcUpWOHVY?=
 =?utf-8?B?aFR5OHBvZWhFSHdabXdCVWsvaHJmbkRFd2VaQTBrT0pEZ0Ftd1BKYm9oVzFi?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4fa613-e85d-497b-4258-08dd0d66d333
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:35:44.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GjATQxsEoGx8YHlkJwF/7rps8gVGzI6SmmJKKJxybRqUO11T97AktIiaNIn781NSWfKDTj6G8hmXVizgvREAaV1JJcuiUoYUZboy/d13Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com

On 11/25/24 15:26, Peter Zijlstra wrote:
> On Mon, Nov 25, 2024 at 09:18:18AM -0500, Mathieu Desnoyers wrote:
>> On 2024-11-23 12:38, Linus Torvalds wrote:
> 
>> I tried the following alteration to the code, which triggers an
>> unexpected compiler warning on master, but not on v6.12. I suspect
>> this is something worth discussing:
>>
>>          static inline void trace_##name(proto)                          \
>>          {                                                               \
>>                  if (static_branch_unlikely(&__tracepoint_##name.key)) { \
>>                          if (cond)                                       \
>>                                  scoped_guard(preempt_notrace)           \
>>                                          __DO_TRACE_CALL(name, TP_ARGS(args)); \
> 
> So coding style would like braces here for it being multi-line. As
> opposed to C that only mandates it for multi-statement. And then the
> problem doesn't occur.
> 
>>                  }                                                       \
>>                  if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {             \
>>                          WARN_ONCE(!rcu_is_watching(),                   \
>>                                    "RCU not watching for tracepoint");   \
>>                  }                                                       \
>>          }
>>
> 
>> I suspect this is caused by the "else" at the end of the __scoped_guard() macro:
>>
>> #define __scoped_guard(_name, _label, args...)                          \
>>          for (CLASS(_name, scope)(args);                                 \
>>               __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);       \
>>               ({ goto _label; }))                                        \
>>                  if (0) {                                                \
>> _label:                                                                 \
>>                          break;                                          \
>>                  } else
>>
>> #define scoped_guard(_name, args...)    \
>>          __scoped_guard(_name, __UNIQUE_ID(label), args)
>>
>> AFAIU this is a new warning introduced by
>>
>> commit fcc22ac5baf ("cleanup: Adjust scoped_guard() macros to avoid potential warning")
> 
> Yeah,.. So strictly speaking the code is fine, but the various compilers
> don't like it when that else dangles :/

At one point I had a version that did:
	if (0)
label: ;
	else
		for (....)

but it is goto-jumping back in the code
https://lore.kernel.org/netdev/20241001145718.8962-1-przemyslaw.kitszel@intel.com/#t

I could switch to it again to reduce noise like this problem, but such
change would be to essentially allow bad formatting

