Return-Path: <bpf+bounces-63942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E8EB0CC2C
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 22:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548DF17C58C
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 20:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E9423C8B3;
	Mon, 21 Jul 2025 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fKXNko8N"
X-Original-To: bpf@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021139.outbound.protection.outlook.com [40.107.192.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF1D1EF1D;
	Mon, 21 Jul 2025 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753131531; cv=fail; b=tT2KQR2+QqwuOQ9dQkkjPXljYTHN8v7ufNMxXNIm+LgcRZDcY0CHx9wnbkyIdbU654UKA2uV727/9eUpijxo9mE5mHV16rdiRdlObiHDFvjmB7csoGdoDm0MgI7G3b6y5XFqOWcCyX2ZVNtqYiaQxbqHi1dEfX5c/2pnKlF3a30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753131531; c=relaxed/simple;
	bh=xwr26G8lwZD++CSQ+JFoN+K80hFlqNoL6DDhBzU5AyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QkeQo4/sat8oV/l5dYbTF8XrmdUcxDE10UtnMSCepQGkwWHJp+b+IdpMpwvrr0RJsI7+Por3+XitWvayfRZ4PqQeclSFgshIVJ635JDFxoejlRBLQmRRXi5gBlYSgydsckKt2oQjK368Hg3kCTn2BWgWD/ZHzUYN5VrP21mh1PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fKXNko8N; arc=fail smtp.client-ip=40.107.192.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMVHY1bbOM1XKv4e6hpwNK+LcJKv+oGEdUfgLLzD9TVoGl6QmxZqzsf6qxV5qe3cP0poz8L71XrKzwgjJfma70VGO13yi5DduAFW3JGWt2kq+yUhjWzprBzu5LnvbQt7w014zSR3xOl17juKoYPI6zfZJazbbr2yOqb9KKhU0/EF5xrIFh3TOhNZLYEmiWDDKT9i3UY18c1Jszm2oXfl0ff94aN0FSM12LTaQYJxUAMqoSfCAhpC+7HBOF0ezQ5mOvJowS6EfhqCJfMs5tEfoLmW/03rHfEGhofUXm0BJN98K3lRaPftD9qM6fhE/DWPQrKM5GW5AeSuYykCiTF1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW5DdMZr8Qig9S8agHr7YrPJJilMNjlTHCJz+OcIzDQ=;
 b=P9ZIVJj0wsD+Y77yHqEa28RYWQs+50n9+RxguCi181MPl0XBosVSunUcIlRPE5khUKkojxrm2J0uaphs13AyJMsVgkk1YjQCjbax/eDhhNW4lBnQ6ml7Url5LdrU4WJmb8xjkbCZsDvYH+QeW/3C2eXcy7CTcH+hlWP4xLd9Bwc43d1wrpZrraLrQYglQC4vldG/EPsfFVx7CzGkNWcXNRMkoH/HHCoAxFznc4dH0PO/iIOa0NRWVSNxUbFbz1OPC5COCg0+/jIuDCGjJ6Q+Sz3SkTM04fZKz/DDJ7VOz0Rj2olshc7GV9+JcIFD7qrfKAFlN5t6xYqD+niIiuX/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW5DdMZr8Qig9S8agHr7YrPJJilMNjlTHCJz+OcIzDQ=;
 b=fKXNko8NYyjCoiVJ/iH16CYyb/KTrvJnhb/RVVqgkRGM0j0Nmt74rVsvX/Pa7Pkr6+xsdrYFsMgpzRyx8w2q3Re6zZsFPLSMQEeWyRuQlYLWP1JE8PjC5vmg8X8YJ7uSci6z+L4HcyqNKcKEmzmGen9vSdwTjub8AKu0U9g/5n0Ht4ii3bDElZaAraMlwSFmtQiW58mJflajJkgrAHUmC7FKKE7ExThZrBWlO0vvfNbcfS+uSBNi+YsgoXLDiv6m906heQ9kwbogbORaiRZym4gKWrEC6bR7ZYjXzxWWdLRgc5n+1WCE5tgPbuQAxL84UV1pgkMBUj3t4z07d6KPhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9238.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 20:58:45 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 20:58:45 +0000
Message-ID: <e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
Date: Mon, 21 Jul 2025 16:58:43 -0400
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250721145343.5d9b0f80@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db79be1-898c-4b36-1970-08ddc89961f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjhEM2k1cDNKVjFXRGtFR3JlZFZEZ1hmY05MQ3R1Rk00ZWFFcUVyM01SWGxu?=
 =?utf-8?B?R3dVbEY5NWVIN3lOTmRpajV1VW1sT1dyWWpMeVRSTTFJNmpBVDM4Sjhnb3NX?=
 =?utf-8?B?UEs0NjRKYVhSSzE2NG1YaWN0Wk90S2dnYmg2UjhVSFV4MHRKV3p5MzJQcVRH?=
 =?utf-8?B?MWNYRkwwVDI1Q0IvS2tmNDFPdXlUOWtuTVRraGY4OElEYVFHN1MvYXFUcWZH?=
 =?utf-8?B?V3V0bHJlUWRGQUJNMXNoZGlhMkMvZTJXN0NUTmoxSmxtS3RadlRJanhQaUtH?=
 =?utf-8?B?Sm5KS3lYb05MWW5UZGVkMHhpbFpPYUdSdU5VZTE5VGNnaEt0NS81eEFJaHQx?=
 =?utf-8?B?VE5Uc2RzeEM3TkU2TksvbkNpU0k1aU5GNHVEd1FTd0c0aEw2TVJ0eEhzdzFt?=
 =?utf-8?B?TkRtNUN2N2Y0S1g3ZWJNdnBManE5Snk5b09VVzFPbG90K1k1dFM1dEFmK2NB?=
 =?utf-8?B?TGowSVdJZ05RWnV0WW9zZjJkbmJxQ0pPQWVDR2l6Z25qTUl3d2pray9ZTlhX?=
 =?utf-8?B?aGIyTXBSdHVNdXFPeXdZK3kwRnZyWGJ3anVURDdCeE90WjdlcGdxOTVialRF?=
 =?utf-8?B?bUxXNS9zdFMycmtseUxlRXVWekNpbzhxTEpzMlY4TUUzTElMdEx3WGkxSUFX?=
 =?utf-8?B?bWdlamhROEJScnhabUNxbmxLRnVvODdZYmxwU1FPd0pLOXc1bGY3OE1OZlZV?=
 =?utf-8?B?N1VwaU4zektBelNHTzl1NlRyU0dHU2Y5MnRnWWRoNitmcmRVNGxqdDVsb1dL?=
 =?utf-8?B?TURQc0gvU2N4SEpjWEY4TVJKVU5VdFhKbXNNekt1RGRid1dETEsvWklRU2lM?=
 =?utf-8?B?UUdvMTdmVEl1QldoaG9melNpQlFvOE42MmlUNm1FNEtTWjIrbGJMRUthczYy?=
 =?utf-8?B?MndiVGZ1dlRKSlVUaDJZdWRVTlNmcEFVWVNjSzd0aUVkQTZNanNHQ1BVY2V3?=
 =?utf-8?B?NkJTRzNPUi9xRU5WKzcyWE5HUkpkNHcyTXM4QkFRUTJ5QW1qREluRmhxVmtF?=
 =?utf-8?B?UzZzeDZJeTEwZzE2dkdseEo0ZmtFZHRtMkQ2K2RDWUtwcjYvTlZQbkMxRVV1?=
 =?utf-8?B?Y3QvUXZmemU5VFVUNWtHOGdRN0hIUE9VZmYvV2ptTExQRGRBNmtRLzJPbjdW?=
 =?utf-8?B?dkdGcHRlaFEvWndQRWxtTmdhOUY4QVhQeDFIb3QvaGVZVjlMcTArWElSMTNk?=
 =?utf-8?B?YmRVUlRDL1JUSlhnYmhCZHpKQytieDd6WmgwOWFTQlZOWkxUTDJuRC9wTEVY?=
 =?utf-8?B?MjhKOGkzbjFkK2I3dUJPUlB0bzh5L283NTFsQnZnQkxwZGg5VHc4N2I3K2pi?=
 =?utf-8?B?R1FLNWlackNoaERzanJld1Q1NnAvSFMxQXFSNFlMUk1QT292QmJMdmxBczVR?=
 =?utf-8?B?R3Y5c2Z5QnhtaHpoU3llTnhHRzF6NFJkUWZ0Yk1nSSsxaThROFBlL09EUGZL?=
 =?utf-8?B?elFkSHUrQ2RwRkRGOFBVQ1JaOGhzV1o5QjV1ZkdtWk5sOXVqRm12R0ZkL0xR?=
 =?utf-8?B?dGtMM0Q5L1UzejJOQU5ZZGFBc1hmVVY0dy9zRHE3TEFZdXRNbUhhNS94NnYy?=
 =?utf-8?B?b1FaZTFRRG9lV2lFWW9wVThBR1FyNndBM2thVXBzcHRFWU9TVGZYYmZJeDR1?=
 =?utf-8?B?Q1hlM0Z1MkVPQWc2bjVLRy8zaC9adXNjL2RRT3I5NEZndSsrUWJVQzFTMzBU?=
 =?utf-8?B?dm1hOUFJbkpmTGpPQVJXaEFxM3JNaDR1UFNmaGgxakNuMUVmY3pwYU1QZUwv?=
 =?utf-8?B?dXBJUCtMSlkzMTdneEhaWVp6K2QzOUt3V3k3WGVvbEdPK0NoajJ6UlFFb3dX?=
 =?utf-8?Q?GuUZ1DK7huGKWU40ZvTsAVMq8bWe4aZEzgisI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE40Q2pnN0N0alRLWE1BNGV0Q3ZHRjhEQS90c3FEWHIrUzZKSzZiZC9aRURC?=
 =?utf-8?B?WVpad1JQMTVrZWpjekEvcjlBWERLZWxsTWZlNUFqOVdXa1lkRUVzSjBrbWdX?=
 =?utf-8?B?MHpsYk1yWGFWeS92MGFvVkJQSlB4VzJvZzFxQWZkNmtrNmJjT1FzUEFCMVZJ?=
 =?utf-8?B?TFpUZ3doOGF1cWlBVWlwRld6WktMVHVhRWF4UmQ3SXhPZXdJQXVIS0YzK2NQ?=
 =?utf-8?B?OGdOQU5nZkNGK0pCaWhjbFNYUzg5SEVHZmltWUtZaUxZdmtBd3hkYS9KM3dQ?=
 =?utf-8?B?ZlpWdGxTbFluajdvWTk1ZmlSWVZkNDI2TDFZVk9SaEp1Nk9TR0U4UkQvSC9i?=
 =?utf-8?B?NzVpVDdGaFJJTTI1TGNwcEx3VHFqdmI2SG5qMTVJNis5Y3YreWFWeWhmMUJN?=
 =?utf-8?B?OFliN0NtTURiSjhCL01lSDE5Z0szVkJWQjBYNE9YU0M2UFJETEMycm9GQUoz?=
 =?utf-8?B?dlRwVkQrRnZpQnM1YytwVmNnQmk4UWdKNjhhZlhRcWtmM0lGZVZpTGpWS3ZZ?=
 =?utf-8?B?NTl0T2ZNTEVlcFhFNXE3OEUwc01QbllUMTJHWks0MzB1YzVrazk4cUhPc0Zt?=
 =?utf-8?B?L0RxNXR1bE44UDdIVHRvTi9XVXR2Q0ZZc0t1c3JBNFRQM1A4YnBodjZTUit4?=
 =?utf-8?B?R0ZWbExDV3p5NlAyMmlxcE5CaERLbzN0aUJQcDZkSmw4QUJ4MTZYenRHRjdV?=
 =?utf-8?B?RlpxdHN4Vi9RR1VPU1JWeVZBMzZNbm9iMnFBc0VHcis2RkRid1hXejBPUFZZ?=
 =?utf-8?B?THgvUHBxcE93K0JUVW95TWIzOHk4WFBZc25mcHpqZ0ZwOWp5SC9PZmNxMFdp?=
 =?utf-8?B?bDVtUDg2Njg2UWdRUnNLMW4rSjFCOHB1RHNvRlczVGFlMVg5Rzhlc0NaSnl3?=
 =?utf-8?B?U2FQR0QyU05ETG9KcVV0L25iTVdya3ljNUNUbzNVaDVsMGFoL2ppSEJ2YjBm?=
 =?utf-8?B?N2FPSUJmREw4UjlXU1dvRU94VXg3Z1VTL3ltSFRlZlFmOHhOcVI3aU9QTld0?=
 =?utf-8?B?UFdEdUVzbFJtdVJmYWw5eElsV0JzZXFYYm9YTlZWd1ByOFpQeDI2T3NnWG5s?=
 =?utf-8?B?Rnpka0xhak0zb0F0TzBTRCswMlFVWHZBWXhUaXRja1REdnZlNXpTRjBZcVFn?=
 =?utf-8?B?TEhrU3gyeklENno5TE5zV1U3VGt3bnJraWF6djJ0R1hJK0NJY296RXQxMGV0?=
 =?utf-8?B?SWxFQVljdDF4eWF5UndoTFRFRXpSaFgwaVJOWUlNWFpHU1ViM0g4NUJPMVpV?=
 =?utf-8?B?OStkc0lVYjlhalF2VS9LTCtQY1B2VlcwWUN2d0QyM2FabEx1VmVCdUNoUWsy?=
 =?utf-8?B?R1BXcXM4d2Y1dVNWL21XNWo3YjNmWk0vQUdpV3BpWVpvcS9TSFY4S2JxQVlI?=
 =?utf-8?B?S2ZsMFpoZkYvS0pRbk5mWmdIaTA3bjU0T1V0Si96OWU5aVh6cDlNT0VqZlFV?=
 =?utf-8?B?OWoyMEJHRTlDblJLSzlMUTduVUhLcldlVmJMdHNlVDlrdlVKa3ppU3hnYnIv?=
 =?utf-8?B?TSszUmlNUkNLSHdVQjBLN0kvS0gyOU90eWtaZVduNnFvSFZzRTlLQnJnSzl3?=
 =?utf-8?B?ZWN4NnlFbUNHRTRneUZBcmJmYjRKZ2FYMlExMGRkNTJaUmV1TWVRUjVKc2VZ?=
 =?utf-8?B?NTl2ZU5rVGRJZlNrSDQ3Y3d6RUQrL1ZtUUdKb2EvaUFkTUZUNU91T2w5cmY1?=
 =?utf-8?B?N3V4bHhGRUdhQ1JxWHpFbXVJbnpTTGp5elJvb0xJT2wySkdOa2tJSjUwOERj?=
 =?utf-8?B?UE5MU05TekEzaUh4Vit5WWRiZ1NwbVNTOTRDTUt6QW1CQ0VnQVN5c0RUQjVu?=
 =?utf-8?B?Mnp3K1FYSHJtTFVqMkRZNHpxU3hJQ0VWVFZTaVFvaGVsNVNneFIvT1RJS1pm?=
 =?utf-8?B?L1NVK0czZWYwdmZBMytwQnRkUFhnR2FXWVcwM21IMy9HeXhZd1A2eUU2TktT?=
 =?utf-8?B?WlRhMkhjRFFmeks1ZUVGN2NSbXk0eTdSZEFQMGVSMlUxUmliZmp6bkJSMHZi?=
 =?utf-8?B?TzQzVm5oRnlZSzU1UW9mSWxIL3RyeExLZU96NURhUnMwRFpud3NVcGU0d0ll?=
 =?utf-8?B?WW8yVCtIRnBzMXJRK0lKL0RlMnEwU1RtajNQQlNHZWFlRnNwcnNzaGlTblA4?=
 =?utf-8?B?TFAvL0RnRDBjdGpzQy94QnUycWNtaHBZbDhFZWVuTFBlYXFndDM5NXdoUVhM?=
 =?utf-8?Q?z+iyeoBkeCKgZoY04gDgjE0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db79be1-898c-4b36-1970-08ddc89961f8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 20:58:45.7271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZrr3Vad0s0tX/X0/HsPzZcrUAL/gm4CgGs9m3M+qvINVHpXF0mtEDPdAeyXGzEyvg5e+wIG4s8pPWjTe/YYXjJbxBKF7txCwuimAGjIWko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9238

On 2025-07-21 14:53, Steven Rostedt wrote:
> On Mon, 21 Jul 2025 11:20:34 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Hi!
>>
>> I've written up an RFC for a new system call to handle sframe registration
>> for shared libraries. There has been interest to cover both sframe in
>> the short term, but also JIT use-cases in the long term, so I'm
>> covering both here in this RFC to provide the full context. Implementation
>> wise we could start by only covering the sframe use-case.
>>
>> I've called it "codectl(2)" for now, but I'm of course open to feedback.
> 
> Hmm, I guess I'm OK with that name. I can't really think of anything that
> would be better. But kernel developers are notorious for sucking at coming
> up with decent names ;-)

I agree wholeheartedly. ;)

> 
>>
>> For ELF, I'm including the optional pathname, build id, and debug link
>> information which are really useful to translate from instruction pointers
>> to executable/library name, symbol, offset, source file, line number.
>> This is what we are using in LTTng-UST and Babeltrace debug-info filter
>> plugin [1], and I think this would be relevant for kernel tracers as well
>> so they can make the resulting stack traces meaningful to users.
> 
> Honestly, I'm not sure it needs to be an ELF file. Just a file that has an
> sframe section in it.

Indu told me on IRC that for GNU/Linux, SFrame will be an
allocated,loaded section in elf files.

I'm planning to add optional fields (build id, debug link) that are
ELF-specific. I therefore think it's best that we keep this specific as
registration of an elf file.

If there are other file types in the future that happen to contain an
sframe section (but are not ELF), then we can simply add a new label to
enum code_opt.

> 
>>
>> sys_codectl(2)
>> =================
>>
>> * arg0: unsigned int @option:
>>
>> /* Additional labels can be added to enum code_opt, for extensibility. */
>>
>> enum code_opt {
>>       CODE_REGISTER_ELF,
> 
> Perhaps the above should be: CODE_REGISTER_SFRAME,
> 
> as currently SFrame is read only via files.

As I pointed out above, on GNU/Linux, sframe is always an allocated,loaded
ELF section. AFAIU, your comment implies that we'd want to support other scenarios
where the sframe is in files outside of elf binary sframe sections. Can you
expand on the use-case you have for this, or is it just for future-proofing ?

> 
>>       CODE_REGISTER_JIT,
> 
>  From our other conversations, JIT will likely be a completely different
> format than SFRAME, so calling it just JIT should be fine.

OK

> 
> 
>>       CODE_UNREGISTER,
> 
> I wonder if this should be the first enum. That is, "0" is to unregister.
> 
> That way, all non-zero options will be for what is being registered, and
> "0" is for unregistering any of them.

Good idea, I'll do that.

> 
> 
>> };
>>
>> * arg1: void * @info
>>
>> /* if (@option == CODE_REGISTER_ELF) */
>>
>> /*
>>    * text_start, text_end, sframe_start, sframe_end allow unwinding of the
>>    * call stack.
>>    *
>>    * elf_start, elf_end, pathname, and either build_id or debug_link allows
>>    * mapping instruction pointers to file, symbol, offset, and source file
>>    * location.
>>    */
>> struct code_elf_info {
>> :   __u64 elf_start;
>>       __u64 elf_end;
> 
> Perhaps:
> 
> 	__u64 file_start;
> 	__u64 file_end;
> 
> ?
> 
> And call it "struct code_sframe_info"
> 
>>       __u64 text_start;
>>       __u64 text_end;
> 
>>       __u64 sframe_start;
>>       __u64 sframe_end;
> 
> What is the above "sframe" for?
> 
>>       __u64 pathname;              /* char *, NULL if unavailable. */
>>
>>       __u64 build_id;              /* char *, NULL if unavailable. */
>>       __u64 debug_link_pathname;   /* char *, NULL if unavailable. */
> 
> Maybe just list the above three as "optional" ?

This is what I had in mind with "NULL if unavailable", but I can clarify
them as being "optional" in the comment.

Do you envision that the sizeof(struct code_elf_info) could be smaller
and not include the optional fields, or just specifying them as NULL if
unavailable is enough ?

> 
> It may be available, but the implementer just doesn't want to implement it.
> 
>>       __u32 build_id_len;
>>       __u32 debug_link_crc;
>> };
>>
>>
>> /* if (@option == CODE_REGISTER_JIT) */
>>
>> /*
>>    * Registration of sorted JIT unwind table: The reserved memory area is
>>    * of size reserved_len. Userspace increases used_len as new code is
>>    * populated between text_start and text_end. This area is populated in
>>    * increasing address order, and its ABI requires to have no overlapping
>>    * fre. This fits the common use-case where JITs populate code into
>>    * a given memory area by increasing address order. The sorted unwind
>>    * tables can be chained with a singly-linked list as they become full.
>>    * Consecutive chained tables are also in sorted text address order.
>>    *
>>    * Note: if there is an eventual use-case for unsorted jit unwind table,
>>    * this would be introduced as a new "code option".
>>    */
>>
>> struct code_jit_info {
>>       __u64 text_start;      /* text_start >= addr */
>>       __u64 text_end;        /* addr < text_end */
>>       __u64 unwind_head;     /* struct code_jit_unwind_table * */
>> };
>>
>> struct code_jit_unwind_fre {
>>       /*
>>        * Contains info similar to sframe, allowing unwind for a given
>>        * code address range.
>>        */
>>       __u32 size;
>>       __u32 ip_off;  /* offset from text_start */
>>       __s32 cfa_off;
>>       __s32 ra_off;
>>       __s32 fp_off;
>>       __u8 info;
>> };
>>
>> struct code_jit_unwind_table {
>>       __u64 reserved_len;
>>       __u64 used_len; /*
>>                        * Incremented by userspace (store-release), read by
>>                        * the kernel (load-acquire).
>>                        */
>>       __u64 next;     /* Chain with next struct code_jit_unwind_table. */
>>       struct code_jit_unwind_fre fre[];
>> };
> 
> I wonder if we should avoid the "jit" portion completely for now until we
> know what exactly we need.

I don't want to spend too much discussion time on the jit portion at this stage,
but I think it's good to keep this in mind so we come up with an ABI that will
naturally extend to cover that use case. I favor keeping the JIT portion in these
discussions but not implement it initially.

Thanks Steven!

Mathieu

> 
> Thanks,
> 
> -- Steve
> 
> 
>>
>> /* if (@option == CODE_UNREGISTER) */
>>
>> void *info
>>
>> * arg2: size_t info_size
>>
>> /*
>>    * Size of @info structure, allowing extensibility. See
>>    * copy_struct_from_user().
>>    */
>>
>> * arg3: unsigned int flags (0)
>>
>> /* Flags for extensibility. */
>>
>> Your feedback is welcome,
>>
>> Thanks,
>>
>> Mathieu
>>
>> [1] https://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng-utils.debug-info.7/
>>
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

