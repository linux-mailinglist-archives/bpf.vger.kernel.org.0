Return-Path: <bpf+bounces-64051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55021B0DBCC
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3303AD1B4
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092912EA177;
	Tue, 22 Jul 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XSQRvDA5"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2121.outbound.protection.outlook.com [40.107.115.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1892EA140;
	Tue, 22 Jul 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192293; cv=fail; b=RQuISeainql7W70ptB6GmtZFgZukbCgjNe+duqxMEk1cRPRboFhuj1U899FagMwQLZUk3NrM9OgsHMX4S0x992qH29sjsNRYX6IAiCnogbwZZuelQ9RmbGlfXkK/7rokjJAfUJHZr/ZBENXeXK+zSbjy2YZ9ozctibObDc66RQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192293; c=relaxed/simple;
	bh=LqK8D1MmpH499vnutLW5cDSe/4TQXjEzQ2+9cGK9xaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QBX5mGK+Da4FQq++SMmByvS544MQNo5bUzdcWI1K/E69k+RbmXp4JPTX8S+GWn0mv5AG8AonaCI9X6A8dtyRbTc1Tho1qxGHyYo/6bw7tfFj9S+7fvjVhQBXlN4aYMjT86WrhLvE0cL29WP4WK2zNFusG/ocD7HeikrCM97qC3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XSQRvDA5; arc=fail smtp.client-ip=40.107.115.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K36RNnqXQAHfF5cHiuVet/DUWOtF+Cl/rn7lPHeugLtCut2In0hkj3a9piBqiPY/hmNZdLM9TdzEJp2mMebMnHN/GTJp6lUD6djWpJdfEatnVfKG+6QQ5fKzdv2hIkoLOeLhorZN1tGMo3DHLKgzk47oj/fpujkO4npwDqsFEjcJJp+wo3lUFVG06H9i+de8o8cRWby2m2IWll1K1b4eokcZGeEh3O0WNVRlX7kraK4Qc+X5qvaoBCZiyLj20quUw/5fz39ZTBPb7kDabXvFsOZIUV8iir6Jb5Px1QS5WlvqFFDvWC/VWyViKXZ722c4vCGTgzsGbL5Ae3wa2lNtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMFxLfgKRGQxaTKXNjs6I+VpWM2qMsQkwtMZ0jJI/3s=;
 b=Drf376cbhCP/wkefmMLepgeepIHDr5vJvqCcpyRKy748IQxghOLyT+V4nDD04v9Z6zwcdJWDI5JfSH/xrv0FE7Izj004fLkPV80WLeWAqsZfCkVYxZ9d39pLQUTwSjnEUPvrEri9SfKnlbUAtI2ollFAXiNbxL3poOwv12eczs59M1RzuMvdL29S3Ac+93R1kciSh7pTGaGFSzopZPny3+EnB0q5SYYv+TyQp5bF0GbGovlOgY16J0rQX0Gdr5fgxHmChUlczkPhu1yvGjFTaV74FBAaPL6O5UeeXd0Tsg/8X2uDVwLWuM3ybAVOe1W9YIZO9y4gCFEP7Dczpi9QIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMFxLfgKRGQxaTKXNjs6I+VpWM2qMsQkwtMZ0jJI/3s=;
 b=XSQRvDA5tNfPKBISldI/jKvevFFDlfYHZ1WRXpW0mhhdXW5BVcpp3QVNxvlDkfnTYOJLsO1S75bXfYsYYANaqkvA60TZG1T+rrx1g/pSjfOQCHikiHwZDBzu6j9rwIkqkS6oWDnsdc5QL1taiFU0GolxWxvCIWrbFRdWe3CHNf3qCBIYFCj2itX04a04utcgz+Qz8I5ulOaTNlUoH02vt2ebUGO7vT5icIKuMa+lc6DyPkHatfmeEJhcE8S+E7YoWIa+klLsJSnMVIrZLCq/FD8/Oeg4x8omsfoJD+1FXqrack0OhOinb8TLEH/j5uzqm/kGu7sqNoOPcyo80q6rOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8772.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 13:51:25 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 13:51:25 +0000
Message-ID: <1c00790c-66c4-4bce-bd5f-7c67a3a121be@efficios.com>
Date: Tue, 22 Jul 2025 09:51:22 -0400
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250721171559.53ea892f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::28) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 560cd2c5-c181-4d4b-f921-08ddc926d970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1p0T0JxblZuVUE2UUN3T280ZWs1OFIwL1VndDBHbWkrdy9WdnhmbDljVkVt?=
 =?utf-8?B?RGdtc0M3SVc0dUFmMUQxbEQ2aStzUnh0Z2xzSTk2MkQvUnVtaWl5TFIyRFVZ?=
 =?utf-8?B?V2ErWWUyZ3dKRFAzS29hUmdEYS9UK1c3Nm45Wnc2bjlPdHV0L2Z4NkxMdy94?=
 =?utf-8?B?U3JaVitlekp4TjViMkdVaDFUckJ1VUN1YUFSZ0pWMUtNOUZndnJVYjZ2VkRt?=
 =?utf-8?B?M1pLNVVySFB4bTdveXh3R3hYOWxUdWFkNFI1cGRyOU1SWFRzbTY3WmxZbGd0?=
 =?utf-8?B?RHBOMlZoUmlmOVNGY2pCUm1aWkV2d3NiRjNZRzkwSHY0OXRHMzZOWGdkTDRR?=
 =?utf-8?B?UTltMk1aU3l2YUxJc0oxT2lVaWxaSXJHUFZQVHJpL1FlaG9qd3hOL0Y0bzB6?=
 =?utf-8?B?Qk85b0pkYmJUOUtTRnlxOEdJNEdIVGdIOEV3L0JEc1hWeGd3NElOT3N6STRo?=
 =?utf-8?B?SXk1Z1RIcHlrWnNzNFlBaHdDSW80dTd1aWJ1Sm8yWGthL0FOdkZtTVpLU0tP?=
 =?utf-8?B?SUFEU1k0cFhNUzdIYnpCdUVPekZkZUtUVDl0UEVpYWpGalNhdVFtRjEwM2Zy?=
 =?utf-8?B?cGtSS0NkTDEzbzIyWnNVQk1DUkxaaFpsK3U1VVk4bGNPeXh0TDlNbmtzWXY2?=
 =?utf-8?B?VkJLU2NxdVMrRzhiWXhINGNVTGhBS3hoY3BsSGlZLzhsMHJiSTQ2czFCcjVJ?=
 =?utf-8?B?ZlFLYVJBaGhpRGxvNithU1kzLzA3L2czR3hObHRDb3ZCSFFoWWlvdHBPQXpH?=
 =?utf-8?B?eExuTEVUeHVadVdiTHhGc2c5Y2ZkazBQVEtqSU1hTWN2b2VEOGxSU3YxRXZh?=
 =?utf-8?B?VzNQVFhkT2EzSk5zdUplbjU5b0ZFWGhwK1RXdUljZ3kybE44ZEhyTjJabDBR?=
 =?utf-8?B?ZVF1bUNtSFhVOUxyNWtrbndqUXBmNUlxYWY3SXZqa1pueDllaUFFejE1RjFE?=
 =?utf-8?B?clFQUHVCSFlRVDJNTW1WWFB6aUI0ZHVwaGVFMngyUUdxbFJpTXdEa0F3MWlM?=
 =?utf-8?B?RGJ1MzZNcUFuTTFkcXZ5Vi9hYWs0VUYzL1N3UTYzNlBQczAvMjJNLzN2V3pT?=
 =?utf-8?B?dDBINVNqZFgrSVYvQ21iMVN4YVkxcS9JWG5jeGFuWEhXK3JRS1p6NnNnTTUx?=
 =?utf-8?B?cTRTaXZkSE5XSklLVWF6ZDhnUjVDT0h1S0hIS0FPL0h5S2FGankwanJoK1or?=
 =?utf-8?B?MmtoZFA0bjAzZnBBUFl6d1NDRHpKTzdQNElXUHV0SzZqakZlNHh1cmp5bkZL?=
 =?utf-8?B?S0hQTXM2N2xSd0lsN3FyUUNlaXZSbWkyNitLVTFMK3ZXUCtCYzhIa2hIK25N?=
 =?utf-8?B?UzdUekdJeXdOQjdhdFJ0bWdqcUVHQXF4MXVERGc4Y3pNOXkxcS9sNDVOZUJq?=
 =?utf-8?B?ZUxkQWt3RllPWGJSQUZaUUI5ZksxQnpRQXpiaHUyMDArZmhZZWlzK0NSbTl0?=
 =?utf-8?B?dXBzcnpHR1BkNWFKL2J2WkF2cTNVVEFXVmkrTmFTMk00RjJ3TXFmSGJRQ0RR?=
 =?utf-8?B?VTFHNXczVHBnd3ZCSXdCOWlKcUxMbFMzOExPMkNYdWR1ZHNBOHhWQ2xWTVZp?=
 =?utf-8?B?OEFMb3Mwc0pPQy9MUEZ1aGhuMElmU3RzdHhWK3ZiVEMrL0RHM3dUeWdQRlNp?=
 =?utf-8?B?alNsWTROK2NNeE5ud01CM3UwZExWeU1DT3MveHAyeUFwRUV3OWlaUUpYVVdh?=
 =?utf-8?B?ajJRMVRwNWVXVXBLdFpsVldtUzlXNkNjT2p6YlFGWnJiKzEvVmp5SjVJVDdh?=
 =?utf-8?B?eXlqYjF4aldXTjd3RkNLUVQ2K0xBM3NFMHRDeDFrbFVQcTltQkszTzFUcDdB?=
 =?utf-8?Q?3BoZykZO42zQERxnowEM1IoJxy/VUgr+2khpM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVpnK0JQQ2VSMkEwcUtVc3VuSVpIYjN6VG8yK1lLdFpjK2tXbzcrNGFzWHdm?=
 =?utf-8?B?TVRwaHhxUUNHRjNPUlVOVEE5OWRGenBZaWphU2VmYkpTcEZYL3RPWGdlUDN4?=
 =?utf-8?B?b3I0SEJmMjI4QStMZUNXNmgwRElLQjlDRmozdmk3eUpWZU9CUytHbjBjNlM4?=
 =?utf-8?B?dnFLSlFuTzZnRGg3eHNSSG00VVBFWWpLTkRhWFNJV2NaSHJPWndyYnoxVkRQ?=
 =?utf-8?B?dEVMMElpZ1JLWDhFTXhTQ29HQjZFcldFVVV6Y1JPZ0ZCOTZPek5aYUJidmMy?=
 =?utf-8?B?NTVkdTR5Mm1PNUp2MllBMUZDQ3NXSGx5eVV1SUtnU0VYVHpSQ2xIeUQyOGVH?=
 =?utf-8?B?c1dDUzZ0T1VCMXEyZmk2WlNUVHFjT0NZc2IxanR0SVdKZ0sxMFRZZ3BjaHIw?=
 =?utf-8?B?YXFZUG15cGk4aXhvZW9zakd3TXFjWXNvbG5EM3RqeDEySjl0ckcyTE13TmZw?=
 =?utf-8?B?NHFNVld4MllBYjAzOURiaVZlZGdETVdjL282TStpalRpVENXY0xvcituY0pC?=
 =?utf-8?B?Y2JUK1pIMWtWMDhlN1JHOVpTN25uODRoZzFrRzQwMU9uY0h4SWZXUTJoY3Z0?=
 =?utf-8?B?SjIxeWxUdUxCQ1FxcnV0cktjK05QVXFyUVFWUVlSZitRRTBsQzlmOXExOVE2?=
 =?utf-8?B?NU5ZaFZ3MGI2Q3h0RUV2azV3R2lvVFVpeHRobERZL2JkQmM1RkZqUWxscjUy?=
 =?utf-8?B?cWVNUFg2bnB4Q2g2bFpvY1Y3QXdJbHJLOWlLU2N5aVQ0Vi9icElUem1VcmNz?=
 =?utf-8?B?VVhzWExNZ0VKTmtkYXExT2hxT2FhYi9JM0RWOXJnMlJLSmhrVURFRnE4b2NV?=
 =?utf-8?B?VnZsUklwU2ZSNTd4SFNWMWhQL2h1QUNFQ29iRENpbldrNWw2WnJWdjhXd1lY?=
 =?utf-8?B?U0RtYWxxOGF3aXpXNnZEZ2JEeWFDVFlVNWY5ZFNTNlB5ZWhDc1JUcEtPankv?=
 =?utf-8?B?Q3ZTUUxFWExlUzN6R0JpdTY1WjBRUFJiVGdSdlFza1JuUGZhakNOSjlzUXpW?=
 =?utf-8?B?azVGbHVGVDA4VVQxZ05LTDEyRFpsS1ZsWjJ5dFVMMUE2VUxUOTZLdXg1QlhN?=
 =?utf-8?B?WWRFNHVYWngwYUdDUWYzeUN1T0RPUEU1NisvMkJ6VWtEVUIrOUJTaWRBTi9t?=
 =?utf-8?B?cHRVSUxFYUlQcU5JQ2cvUk1XQktJc3lwUitJUXNBb3VUT0pqa0lDd0YyQ09N?=
 =?utf-8?B?MHFicnZ2WnZoMmhuTnFnaU5weUk5TUs5STUrdGo1M0piSENzVnRJMWJNM2ho?=
 =?utf-8?B?YTJTVkh5elpxZ296Zk50RzNuVHc5VDh5WVVlTmlDdy96QjJENFAybzVkNmFT?=
 =?utf-8?B?VUl6a2VxQUlFM01ybnI3MWhIOERRZW5FMklreGhITGZlQUdab0tjc2VHS2M2?=
 =?utf-8?B?NytKK2VoU2pPdmtBN2dxcEVBZVhvTndxS2FUalVDRTkrN3ZaQlIyNW0yUXVx?=
 =?utf-8?B?M2ZnZW1ubTVaVUk3blJFbE9QUm14ZnlrWmxMU1BINDhxbzFNYnFzeWxtN2hL?=
 =?utf-8?B?anh1OUZiR1lHMjE4bCtUbFV5dTlSMzdZUEZmVHB6N1FJT2JLQlhROERBMFdh?=
 =?utf-8?B?bTlHNkRIYStUSmdFaWw5bjE2YTR4UjQxR21DT0t4TVZqVFFwVEJpcnlaZjhP?=
 =?utf-8?B?RmFvMUR3KzFrMFBnZGZSRTZ2a2QrMWtLUFFLekQyT0k0Vlo2dE8zZGswVkdS?=
 =?utf-8?B?NHZGRlB1bTRzWEZ3ZDlOMHBoSklieUpzdExLcyszV1YxU09kdkwwZFpWQ0dN?=
 =?utf-8?B?dGttb3ZDbXJHYms3Q254V25kVmgrR1hXL1ZOQkhqcUhkczhwVVVhYS8zZzBY?=
 =?utf-8?B?N0lPNWVUaVdVdVFHRnAvcDR6aUw4RWhRMVZtVEpESHdSS0V5Q1lDNERmQUxp?=
 =?utf-8?B?STVmeU5XSTZ5R1hsc3NJcytZQmk3cWZ6Y2w2d0gwZmdrVFUvcThTSzlBcHNE?=
 =?utf-8?B?SFZOT2pYU1NCK0phSzM5UEYzTTc2N0pBRklwYzV3MjFMQXltRWRUb2J6NW56?=
 =?utf-8?B?Q1k4QlUzeHpmV3BpeVIxS1AwZVdCcE45N0l1WVF4S0dDL3dyNFhaeHErcXhX?=
 =?utf-8?B?THhjWXVoNmdDMmlGbjYwRTBsc2hmTFhuYVNaRnM3MkNva0x4UkhLekNVKzAz?=
 =?utf-8?B?SkNhbGx3REFhTjMxV25iVEV5QmxBQWdMY0NNR2dvTkpraXo4TXZzUUNUMmg5?=
 =?utf-8?Q?5uAuReMkclq3Pn1dohiSkoA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560cd2c5-c181-4d4b-f921-08ddc926d970
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 13:51:25.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvphvPotWZmjTtGz4RhXDc8RLZSsdKz+OgINUO5O+G6LzZztAHYJ4DMp8amk0PcJVSNkie+OYMwFkHanaUednbE2oovHnWPWkkym6AFmhdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8772

On 2025-07-21 17:15, Steven Rostedt wrote:
> On Mon, 21 Jul 2025 16:58:43 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> Honestly, I'm not sure it needs to be an ELF file. Just a file that has an
>>> sframe section in it.
>>
>> Indu told me on IRC that for GNU/Linux, SFrame will be an
>> allocated,loaded section in elf files.
> 
> Yes it is, but is that a requirement for this interface? I just don't want
> to add requirements based on how thing currently work if they are not
> needed.

The ELF-specific optional fields I am suggesting (pathname, build id,
debug info) are useful for tooling. AFAIR this is what gdb uses to
find the debug info associated with each binary file.

> 
>>
>> I'm planning to add optional fields (build id, debug link) that are
>> ELF-specific. I therefore think it's best that we keep this specific as
>> registration of an elf file.
> 
> Here's a hypothetical, what if for some reason (say having the sframe
> sections outside of the elf file) that the linker shares that?

So your hypothetical scenario is having sframe provided as a separate
file. This sframe file (or part of it) would still describe how to
unwind a given elf file text range. So I would argue that this would
still fit into the model of CODE_REGISTER_ELF, it's just that the
address range from sframe_start to sframe_end would be mapped from
a different file. This is entirely up to the dynamic loader and should
not impact the kernel ABI.

AFAIK the a.out binary support was deprecated in Linux kernel v5.1. So
being elf specific is not an issue.

And if for some reason we end up inventing a new model to hand over the
sframe information in the future, for instance if we choose not to map
the sframe information in userspace and hand over a sframe-file pathname
and offset instead, we'll just extend the code_opt enum with a new
label.

> 
> For instance, if the sframe sections are downloaded separately as a
> separate package for a given executable (to make it not mandatory for an
> install), the linker could be smart enough to see that they exist in some
> special location and then pass that to the kernel. In other words, this is
> option is specific for sframe and not ELF. I rather call it by that.

As I explained above, if the dynamic loader populates the sframe section
in userspace memory, this fits within the CODE_REGISTER_ELF ABI. If we
eventually choose not to map the sframe section into userspace memory
(even though this is not an envisioned use-case at the moment), we can
just extend enum code_opt with a new label.

> 
>>
>> If there are other file types in the future that happen to contain an
>> sframe section (but are not ELF), then we can simply add a new label to
>> enum code_opt.
>>
>>>    
>>>>
>>>> sys_codectl(2)
>>>> =================
>>>>
>>>> * arg0: unsigned int @option:
>>>>
>>>> /* Additional labels can be added to enum code_opt, for extensibility. */
>>>>
>>>> enum code_opt {
>>>>        CODE_REGISTER_ELF,
>>>
>>> Perhaps the above should be: CODE_REGISTER_SFRAME,
>>>
>>> as currently SFrame is read only via files.
>>
>> As I pointed out above, on GNU/Linux, sframe is always an allocated,loaded
>> ELF section. AFAIU, your comment implies that we'd want to support other scenarios
>> where the sframe is in files outside of elf binary sframe sections. Can you
>> expand on the use-case you have for this, or is it just for future-proofing ?
> 
> Heh, I just did above (before reading this). But yeah, it could be. As I
> mentioned above, this is not about ELF files. Sframes just happen to be in
> an ELF file. CODE_REGISTER_ELF sounds like this is for doing special
> actions to an ELF file, when in reality it is doing special actions to tell
> the kernel this is an sframe table. It just happens that sframes are in
> ELF. Let's call it for what it is used for.

I see sframe as one "aspect" of an ELF file. Sure, we could do one
system call for every aspect of an ELF file that we want to register,
but that would require many round trips from userspace to the kernel
every time a library is loaded. In my opinion it makes sense to combine
all aspects of an elf file that we want the kernel to know about into
one registration system call. In that sense, we're not registering just
sframe, but the various aspects of an ELF file, which include sframe.

By the way, the sframe section is optional as well. If we allow
sframe_start and sframe_end to be NULL, this would let libc register
an sframe-less ELF file with its pathname, build-id, and debug info
to the kernel. This would be immediately useful on its own for
distributions that have frame pointers enabled even without sframe
section.

[...]

>>>    
>>>> };
>>>>
>>>> * arg1: void * @info
>>>>
>>>> /* if (@option == CODE_REGISTER_ELF) */
>>>>
>>>> /*
>>>>     * text_start, text_end, sframe_start, sframe_end allow unwinding of the
>>>>     * call stack.
>>>>     *
>>>>     * elf_start, elf_end, pathname, and either build_id or debug_link allows
>>>>     * mapping instruction pointers to file, symbol, offset, and source file
>>>>     * location.
>>>>     */
>>>> struct code_elf_info {
>>>> :   __u64 elf_start;
>>>>        __u64 elf_end;
>>>
>>> Perhaps:
>>>
>>> 	__u64 file_start;
>>> 	__u64 file_end;
>>>
>>> ?
>>>
>>> And call it "struct code_sframe_info"
>>>    
>>>>        __u64 text_start;
>>>>        __u64 text_end;
>>>    
>>>>        __u64 sframe_start;
>>>>        __u64 sframe_end;
>>>
>>> What is the above "sframe" for?
> 
> Still wondering what the above is for.

Well we have an sframe section which is mapped into userspace memory
from sframe_start to sframe_end, which contains the unwind information
that covers the code from text_start to text_end.

Am I unknowingly adding some kind of redundancy here ?

> 
>>>    
>>>>        __u64 pathname;              /* char *, NULL if unavailable. */
>>>>
>>>>        __u64 build_id;              /* char *, NULL if unavailable. */
>>>>        __u64 debug_link_pathname;   /* char *, NULL if unavailable. */
>>>
>>> Maybe just list the above three as "optional" ?
>>
>> This is what I had in mind with "NULL if unavailable", but I can clarify
>> them as being "optional" in the comment.
>>
>> Do you envision that the sizeof(struct code_elf_info) could be smaller
>> and not include the optional fields, or just specifying them as NULL if
>> unavailable is enough ?
> 
> Hmm, are we going to allow this structure to expand? Should we give it a
> size. Or just state that different options could have different sizes (and
> make this more of a union than a structure).

This is extensible. The size of this structure is expected in
arg2: size_t info_size.

Each "@option" label select which structure is expected, and each of
those structures are extensible, with their size expected as arg2.

> 
>>
>>>
>>> It may be available, but the implementer just doesn't want to implement it.
>>>    
>>>>        __u32 build_id_len;
>>>>        __u32 debug_link_crc;
>>>> };
>>>>
>>>>
>>>> /* if (@option == CODE_REGISTER_JIT) */
>>>>
>>>> /*
>>>>     * Registration of sorted JIT unwind table: The reserved memory area is
>>>>     * of size reserved_len. Userspace increases used_len as new code is
>>>>     * populated between text_start and text_end. This area is populated in
>>>>     * increasing address order, and its ABI requires to have no overlapping
>>>>     * fre. This fits the common use-case where JITs populate code into
>>>>     * a given memory area by increasing address order. The sorted unwind
>>>>     * tables can be chained with a singly-linked list as they become full.
>>>>     * Consecutive chained tables are also in sorted text address order.
>>>>     *
>>>>     * Note: if there is an eventual use-case for unsorted jit unwind table,
>>>>     * this would be introduced as a new "code option".
>>>>     */
>>>>
>>>> struct code_jit_info {
>>>>        __u64 text_start;      /* text_start >= addr */
>>>>        __u64 text_end;        /* addr < text_end */
>>>>        __u64 unwind_head;     /* struct code_jit_unwind_table * */
>>>> };
>>>>
>>>> struct code_jit_unwind_fre {
>>>>        /*
>>>>         * Contains info similar to sframe, allowing unwind for a given
>>>>         * code address range.
>>>>         */
>>>>        __u32 size;
>>>>        __u32 ip_off;  /* offset from text_start */
>>>>        __s32 cfa_off;
>>>>        __s32 ra_off;
>>>>        __s32 fp_off;
>>>>        __u8 info;
>>>> };
>>>>
>>>> struct code_jit_unwind_table {
>>>>        __u64 reserved_len;
>>>>        __u64 used_len; /*
>>>>                         * Incremented by userspace (store-release), read by
>>>>                         * the kernel (load-acquire).
>>>>                         */
>>>>        __u64 next;     /* Chain with next struct code_jit_unwind_table. */
>>>>        struct code_jit_unwind_fre fre[];
>>>> };
>>>
>>> I wonder if we should avoid the "jit" portion completely for now until we
>>> know what exactly we need.
>>
>> I don't want to spend too much discussion time on the jit portion at this stage,
>> but I think it's good to keep this in mind so we come up with an ABI that will
>> naturally extend to cover that use case. I favor keeping the JIT portion in these
>> discussions but not implement it initially.
> 
> As long as the structure is flexible to handle this. We could even add the
> JIT enum, but return -EINVAL (or whatever) if it is used to state that it's
> not currently implemented.

Sure, we can indeed initially have the JIT label, and return -EINVAL for
now.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

