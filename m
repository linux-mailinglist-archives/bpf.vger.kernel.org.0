Return-Path: <bpf+bounces-45664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D92B9D9F34
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 23:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D000283233
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 22:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9F1C243D;
	Tue, 26 Nov 2024 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQd2+Hty"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CC11185;
	Tue, 26 Nov 2024 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660373; cv=fail; b=NVaVQQNmpkqOoixQx9g/5JDY5d2n7AT3hcU687Vom/9i+F+WvwomaRWnUC2WY3MaAOoCoyh/kGLOypsKNSMd4S0HiCMEayYiMY/4Lf5g0yGlavNBP1s8IbvE+qiHKNNNpKwIvkKoUe8TwYqKFB/hpSff8JLuptnVYwIF/J1KWoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660373; c=relaxed/simple;
	bh=TsNpd/R75tdSMBdUkx4NIeSRmvvhzmDmdwplX6IoST4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NYCK0rkbTbiDEVRCisPsAZReBBhY+/rWHnA52hWCcefs2MmE5r0vWpFc2GklMS43bl0YNtcDIsNB1oVOFAHKWJ937rJ17ICqOC4MS+U6xIUpSGpJy7m7Vk7NITHS9kvjQy1AZa2s8tOUmxm80lV1VEajs3FJmnboIU3FVxzYR9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQd2+Hty; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732660371; x=1764196371;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TsNpd/R75tdSMBdUkx4NIeSRmvvhzmDmdwplX6IoST4=;
  b=WQd2+Hty+d8O+tIwK8LNhbqX1VikW07W7t2nufAQWjcBwLdPBwzzJrtx
   2/tXefsu4i7quE0bgySJSTaegluh8uj7NDwkcT/hml1P2tepMKCVDeZZE
   ra9QYRRpCs/tso42VIn4eTdPrkflEwxlJMNXJEAiuZCfb/XERTXOv9KKx
   rHdhPHi6Baoom8mkkJ606REEaHUgBH/P+cyBOsXUedc/D1HthMXSIbqwU
   xX/Zn1Rv8VyATe0gBmT0Ut27W+UKjpyuk0gvmWSnXmLCoLdMMw8fMAeH3
   cqjWiQx71tggkvdjvsZnEStDY6+SIdeeUeGoq0NgpEQ0ylknS+f/55wDL
   Q==;
X-CSE-ConnectionGUID: D39yuWCtSAKulZkR/eOMiQ==
X-CSE-MsgGUID: 9+vEEmZtQfW86CQn6sgjow==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32589394"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="32589394"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 14:32:50 -0800
X-CSE-ConnectionGUID: 1rNsoTVhTSqXNPLgxQGZCw==
X-CSE-MsgGUID: xwuNWZGLQtC/OVF0/1TpHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="115029826"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 14:32:50 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 14:32:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 14:32:49 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 14:32:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZ8EdFC2tVA8a2XiWqoq+A8dGuiQE8a36GhrQszc1gnJBKF1vXeIN+axaF4+w2Pjwz9PH84tukC/44jvSNOU2i2OqmQeP79aSQl9XA9yxLzy7MIF8VdaSBp784c5KaHi++eUcwbdZmw53Vnw/RcxPS4tAY1Kofo21KHy67v60ZuPAENGxHqSy8OJEXkyN0M6yEgKHXFIlytBkN395gldwsJWpOYm1ve5agWrgMJB2zmSrsU1fa97pU+Hp2tppdMK4/9Ka+JS7uFj+RhZdUwDQPzW1nE9dW9akeYu5aOZAZ+fLWFsKkf7RN7nLQGupY2yKOUHO2d3cYKYXShqbzGyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIcQZmhsEaaUfgZuUAOahlV8jYkaIvxD0wxf18D1cwQ=;
 b=oDQBI/9pX04gC/3/lbI1UphIpawz7h7VfnqpotFW+SVZ4DklmyiI/+ValSAz1EqdDmv2LT6HL6zoaY98pMv5ZNy2asSAVEbOap3JuLJJrB27Wh2QNLK0y2vz7RhuqDJN57B3q5fHwSjvOW2qDg/44C8QJ9glkh8RzTTeGG4AjQLIYJXtx/z1VKb+Q6YFvFu/sBhsCEl5scxgImuqITnPbrk9UlBzPcnu3mEkUOXe7Wp8YOK6aSo1+QQM/xe0xRviZhDTvNtc8PitIBr+E0HCZHOUH8KCBBYw5nZh2ARvd+lmh//twpVw9xA18wNbK9AkNr31P02wo6EpIgPljKE5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 22:32:37 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 22:32:37 +0000
Message-ID: <42ef4bd2-0436-4a1c-b88c-73101dbbf77a@intel.com>
Date: Tue, 26 Nov 2024 23:32:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from
 __DO_TRACE()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	"Michael Jeanson" <mjeanson@efficios.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song
	<yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>, Joel
 Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>,
	<linux-trace-kernel@vger.kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
 <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com>
 <20241125142606.GG38837@noisy.programming.kicks-ass.net>
 <c70b4864-737b-4604-a32e-38e0b087917d@intel.com>
 <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
 <20241126084556.GI38837@noisy.programming.kicks-ass.net>
 <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>
 <Z0Yz6xffDjL6m_KZ@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <Z0Yz6xffDjL6m_KZ@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::27) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|LV3PR11MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd8a1e4-0c4e-4fb9-4462-08dd0e6a3aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TU0xakpyQ3hWRUovNVl6Y3l6NnpQdUxQOEpZUVdQeG5QbC9MbXRwcmFza1ZL?=
 =?utf-8?B?b0hZbXNDWTBxN2YyZnpCUDhTZzNKQUprNnZkRXl6RXJ0WktPeWZuK0tSZDR0?=
 =?utf-8?B?UEpFRG9Qdkt1dFUrVDJTL1FkMXZuQUsrR01LL3pINjZEdTRkblJSeUt6dEVz?=
 =?utf-8?B?RS9XTWhPbVg0T0U4eU5qd0IyVEdnVkdIWUtZbytTcVF6UVcrUHRtWDVoL1Jz?=
 =?utf-8?B?M2MxbEc1YXlLNW5vZnJjZENjbWhMRWJUNkdkWDJHNmJSYXNCT3l6WEtmRnND?=
 =?utf-8?B?NWZFRmJPdnJsaUVLZStISTZPc2VoamhIUlAwQlV6bmIvZDNjMTBrUzR4NFVE?=
 =?utf-8?B?dUo4TmpjdHU5eVB1TXJQSXp1YkRVS3JSaHQ1VTdNOEtwRUxaa3AxeFVxYUk2?=
 =?utf-8?B?V1gyUjdSZjNHT0VYeGNMYlNpYzJQSUJsc1ZUTE1peENtb1NWa0ZGRjBoR0Ra?=
 =?utf-8?B?MExIaGwzTUZHWDZobG9QMVIxTzJrNWxYZlhkYTUxYTZNSjhVNVdjb28wU2Vz?=
 =?utf-8?B?UDVnRHpsaE5UQVBETzVCZUFIM3FaSGk0aHppdlNaMmdEOE9OY0NSaWU5alNp?=
 =?utf-8?B?akw1SUNxUy8ySjZiY1QvSmlrUGtMaWxTWXU4WXdxbGJzR2d6cVo2KzZQVnNs?=
 =?utf-8?B?UnprdWV5a3NJM3V2VG9CTzc4WlQraU1VMWRvbDVSU2ZsSlRqQ1JQKy9xYVlj?=
 =?utf-8?B?NVlWMzZPTEJSZmtlZlpaVk55UTM0YnNFeUR5YzNwcE52aDV3L2ZGeUlzT0pV?=
 =?utf-8?B?Y1ZpOHlEYnA0cGtvSm5oNG5wL1hOY0ZCRmV5Uys2LzJhaDNjamRNOHR0Q1Rp?=
 =?utf-8?B?c1kvQ3lnc21QWlNSUmlVdHlpYXBsN2FWSHhOYWVJWDlwNjdPMm1HMjlSN0FU?=
 =?utf-8?B?SSs0cUpJYS9VVXhpMXllcFBkSlJ0NjFwSmtjVG5NRDVCdkh5VjBjUmtKdmRr?=
 =?utf-8?B?amIrNzVHMTg4UCtwNjFHOE8reUk0R2ZuRE1FSkZOVG1ZbDZRTDJoSG9YZGc0?=
 =?utf-8?B?bzhDZyt2TUJKT0kvd0JSRmF0d0VYQm1zbzEwcCswMDFoN0k3ZkcvbFNLYklx?=
 =?utf-8?B?S1dQQTRnZG91TTdVSkRydVBwVjVkTC9uZnprZTdVVUc0b3ltTTRDaEhvMktm?=
 =?utf-8?B?SjFzVzZsRStLallUODh6OXZ5ZlVzUkxuZGdwNTdEUEtMSDA2RmZKVlBUOEk5?=
 =?utf-8?B?SmJvVGpkYnFqMGRjc3UxMkdJSVNaVHhJQWxRK1JCTzkwVVAybjA4ZVV1ZmUr?=
 =?utf-8?B?cHdqZmZ0ZEQ1ZnR5QmQ4aGhRSllPMlZlUFArS0ZMNElVK3RTajd6MEFlSVBr?=
 =?utf-8?B?R0NZSWlqMkZVbDVxZ1dtbU96aFNveHIvMTlyTHo0ckhsWlUwazJGRCtLQWll?=
 =?utf-8?B?d0hzZGJibkZ6dHRBT0hWOTZwVTFURGxSMHlKcC9YVU9DRTYrNnFteDdNR0F1?=
 =?utf-8?B?bEF0amhKMmxqWVVhRmFyNjZFcDNwNjhrQmpGeCsrT04rS3IxRko5a1E4L3RP?=
 =?utf-8?B?WEg5Wnh0bjZ2eXVVcmUxbGlDcFg0a25hNDZDZUM3VUNhM29MWm5ybWhLSTdN?=
 =?utf-8?B?TmVsTVhYVXpLSzNnaE5FNEQ2Z3F2czF2SG9uZHl6K2s2bEpFd2ZVVGl1VE8x?=
 =?utf-8?B?SDFwUFhCdC9QNVplMUhVNHROTjQ1NEdFSmpZd2lHY0NZS2FncTFJQ3JJZEs3?=
 =?utf-8?B?YlBWWlRPc3cwczRycFJycWpLbWtmcHd2SmJUNHdPeDkxVVhLVTV6eGUvemVO?=
 =?utf-8?B?dHNEelNRZkFwVDRINUY4TmNaVEdUejU2ZHZ4bkdWY2N5S1kyS3JuRmNvZ2tx?=
 =?utf-8?B?MmduSlVFLzd5bXlwRlhIQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWlRRlJRbjJQcjRwTkJ0ckFNQm5ITFovWnFORGlKYTBtcTJROVc2S1k1Um1j?=
 =?utf-8?B?U3lwVW9KV1lDMll1Q3hOVDhBekpBRkwzMVV2Qm1GaGltWHlENzl5Zm55MTNX?=
 =?utf-8?B?V1Via3lmNm1Cd1g2dmhZdExMbDBlVmVzRlNHVklEMEdITWJwSzBIaVhGVzBE?=
 =?utf-8?B?NFNVVk9xVzBmNUQra1lUMnh0SWpsSjBGVTg1b09hMjNlSWZNUkpSV1hhQk9K?=
 =?utf-8?B?dVFobm5XMmJ6RXoyZVdTckFrdmtOWDJVWDIvVWNQMGNEdTZyd1NqbmZKV0tl?=
 =?utf-8?B?czFxQ2VlRHU5OWN5cmxUNjlMSkQwak1XREtNbS9zRXhNUE1zczlreHREcVVH?=
 =?utf-8?B?Q1E0bG1YT01HT0taZkczcDVKV29Cdk95QnI5QmJCN010ZGVTbHJGSkxSRDhC?=
 =?utf-8?B?U1RWeEdPSDlEZmRQTHA1aDVlUG9vb2RBTnFnRXE5M3BsV1UvYjZLM1dBNEVw?=
 =?utf-8?B?RE9Mc1NjV01OOXRjYVl2ZU55cklrRTlHb2V2c3FmazcxUDkzR3B2dTQra0RK?=
 =?utf-8?B?NDFITXBoUU1JRFAySHIzaFo3cUEraFJlc3lpdmNUaTlsOUxCaVRXMkxrcHZr?=
 =?utf-8?B?MTdDU0dDV1JUZXVCbTFTK0thSkgwcDVkdDlUN0NnUWNhNzVxUEpnaFA4bmxF?=
 =?utf-8?B?WUxNTUE5WGVsZTJBYWRWc2QvYkduSnhLaWdyd1YzTVVuWEVmdzNmRzlCbUlB?=
 =?utf-8?B?d0doNzZHSmZNWU15UTYzNDNEb21lRno3ZThYcU5hbmVVVDhaYjVwalBnRWw5?=
 =?utf-8?B?dnFvU2IwSFkyMjFuWnF2eHc5a0xtNmhGelhyVnU4Sm1aTW1zRGNHTXlDcVF1?=
 =?utf-8?B?aGFGV3dZQzEwMnZLQ0VmN1E5b1dCSFFENzFYb1FWbUIzYnBPZnNpRXRQTDJG?=
 =?utf-8?B?QkJBeE5ZMWVOZ0Y2eU1pVkdnTjVrcUVhR3h3SldGR0RhcUxXM0h6UjA5MWIw?=
 =?utf-8?B?ZjBSOXpOdDV6ZG13bDdUUXloOEVXV2thT1pIWWs4UGgrNVBMT2VldFBscE16?=
 =?utf-8?B?VlBDSGVCSEVVak1oSmExUDRFaTY1aGNka0NkdjZlS3llbDZ2MTJBbG1rYjBX?=
 =?utf-8?B?VEN6RUhjM2ZwT1FFR2oyYmsvMktGVGZFeU8rd01QMS9HV3N4eGhzbE9oM2Vm?=
 =?utf-8?B?Sk5nSWpKbmw4dXBPVXdPNlUzSjd2MTFKY1V0YW4veW5zb3c4TkNITUVpOHQr?=
 =?utf-8?B?YWZzZzZnR0YwejlTb0RPVDIwbHBZUjMzMmRuR3Y5ckpkcUw4eWpkYStGWDJH?=
 =?utf-8?B?dVdlOEhWcWlpWEZkT2ZKeGJSL3gzbzl4NVl3VXl4RVdGUXhROUNvenZtRlND?=
 =?utf-8?B?VS9jenFQR3JkdkQ5cnlNQnBDenEvbjZGS2gvWUxJeURwUWkvaUN0VkJDU2Vz?=
 =?utf-8?B?ZlRrRG9sNmRqU01zZHZkTVZCRkIzMTlnVi9ncHJFNlBEak9NTDA2TDNyeFdS?=
 =?utf-8?B?UUJHdFVpQzBJckJSZkRJcExCZHVSc1cyTFZLMlZ6czVZNUdDNnphb2E2cU5M?=
 =?utf-8?B?RTg2ZHZLOFo1RUhUZHJ5dXRnb2dhVEd3Yng5Snh3SGtHNkgrSnFYcDlpcEdX?=
 =?utf-8?B?ZFpFOXR3ZHNVcmhHOENrRXp6TjJtVHpmbjdHMmFjNEtNZ1M2UWJKd3VJaXl4?=
 =?utf-8?B?WG1vL1BCc0NnOGtSTi9uc1FkT2U0dVlQWVE3eFhvcXVxQ0pxdVN6OHQ4TGR2?=
 =?utf-8?B?L2lSMldqNUdmZ2dZOTdwd0hFRSszb0ZxYWlRd3pXTnhmLytkeStsSTY0K3dy?=
 =?utf-8?B?Z01PUUVoTGdsUnIyQlJmbkdJdDhFY3VWbG45aVNoUHlCNjdSS1FncS9rRWRY?=
 =?utf-8?B?RVFXYzRQUEkvbjdzVFZEc0NSaHJEaEdNbEE3TVNIdDJqR3NvVm93UkVjc2xZ?=
 =?utf-8?B?RDFwSGduZUJuUEtkd2lXcnpMaTcrUXdkajYvbkZSYUJNeXBIa0JlUUV6TmE5?=
 =?utf-8?B?cjZhUWFxTExTY3RqM0NCV0s0cjlvdEtMUEJPWEs4UXkvc09rMjdaeVRyTy8v?=
 =?utf-8?B?UjNRZmdtOXh5Zmk0MmUwTlJiTjZWLzd0TmpvcTl2eDJnSUhabW1xNkt3c2M1?=
 =?utf-8?B?UkhZQ1VHc1BXR1dodU1sSXhVb3k5Mmk0U1VnTTFGSTBnU3RjQjYzTXhjRXY0?=
 =?utf-8?B?WXYvWEh3U1k4Znl3ODNVUE9YandhWlViai9XdzQrVWF3eDJZczU4c2dpMTQw?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd8a1e4-0c4e-4fb9-4462-08dd0e6a3aed
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 22:32:37.5976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiNNfxAcxtoPzDNogNQy23ZQPjEp5Vk6023Zif34A40nGVBGEWuGWyuHn7OT0jyvfI5U/b5mIvO04aRGIaTAIM9yVduCLI38rTxr0TtfjDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8695
X-OriginatorOrg: intel.com

On 11/26/24 21:47, Dmitry Torokhov wrote:
> On Tue, Nov 26, 2024 at 10:13:43AM -0800, Linus Torvalds wrote:
>> On Tue, 26 Nov 2024 at 00:46, Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> Using that (old) form results in:
>>>
>>>      error: control reaches end of non-void function [-Werror=return-type]
>>
>> Ahh. Annoying, but yeah.
>>
>>> Except of course, now we get that dangling-else warning, there is no
>>> winning this :-/
>>
>> Well, was there any actual problem with the "jump backwards" version?
>> Przemek implied some problem, but ..
> 
> No, it was based on my feedback with "jump backwards" looking confusing
> to me.  But if it gets rid of a warning then we should use it instead.
> 
> Thanks.
> 

yeah, no problem per-se, just "a better" choice given properly formatted
code :|, will turn it the other way, to have less surprises for those
not stressing about such aesthetic all the time ;)

--
BTW shadowing of the goto-label is not a -Wshadow but a -Wfckoff level
of complain; I have spend a few days to think of something better,
including abusing of switch and more ugly things, -ENOIDEA

