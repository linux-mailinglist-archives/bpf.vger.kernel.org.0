Return-Path: <bpf+bounces-65087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09426B1BACB
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 21:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90613A609B
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 19:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515F121FF2D;
	Tue,  5 Aug 2025 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEiTlf04"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C8156228;
	Tue,  5 Aug 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421404; cv=fail; b=TIfCjxJbS3OgU5Hc136Ho1LbFV5HqMtmUXmJc/D7YLc2jPeSpLmIXtrVSdU54Z/YGOFVLvo19XqD08YzuPq6jwAPgvcL3rkb5FWD5S9Bk6wV5AhFFs2P7/xX7NMxCL198ZJz7J4ckWGznQDus9P8rOcBcMjhTAnTM8u2akyXfOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421404; c=relaxed/simple;
	bh=09KsJ4ad2bNgtPlINpFdnU0XE26ptE9F5SMrcfs/bBc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FWjxYT3bNDMUxpiA2w7RodMcT11oe2yDaSbgDeK2vTEH6XvrmxIZKbhPoyN6rwOdozR4vZxf0vmTRxRE0+UCVHPr8uFduW9g7fYDnkkB47pGFdxbrYTo1R6M3XnoqJz3lyov670q8KYT5nc1nq5Z/HzbK3dUuML3BDnerDNBqbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEiTlf04; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754421403; x=1785957403;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=09KsJ4ad2bNgtPlINpFdnU0XE26ptE9F5SMrcfs/bBc=;
  b=YEiTlf04+XEytpVE+kfpdB3cMLxlr6npTD8vJw7RN0RH1u4pddiXz2fu
   t9iRy9y28Qjd+Uiaafyszyu0pQPs0JDzruo4YMfzOSqJ/ba9nhvhbmrda
   i5pbZ55W0CiSBOP7I8bNRS3duBPfSlqc4AZ4kldQfRsl7xRDfbOpg4eoD
   infLidk8E2O3k4LHAT17UPe4FtbczLxbUCQHIpiygLH4FTLzofbMMh9hF
   dn6zhUluUdJIyH8TVOhJodghnj/ufj0cEeKN+UmdylHnTvc+G9da+oGaQ
   +wJhyYGCE8/Gt7QP6coulsStDtCZls2RPKqStZPzWF8pUXjIWdrJmcWY+
   Q==;
X-CSE-ConnectionGUID: XzsJkddrSF2KwIthual6Iw==
X-CSE-MsgGUID: TDaqBeepSiSvBVoTPNrxKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56444431"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56444431"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 12:16:42 -0700
X-CSE-ConnectionGUID: uW7vT9LHT0yRdkSZ/pfX/Q==
X-CSE-MsgGUID: Na9NclSfQGispFLrnjJ0Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164476189"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 12:16:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 12:16:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 12:16:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 12:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EESsDMbrNrVymZMt7NPN7618E0FY2SxvkN+dm5X2CCGhyGRucUkvvzykShFxsUSUofE8fGBaD9NFmiX+gZpYgfAV0Sn2O9AvvZiQMaTGbXUX1FIHc+SpTzKR4MZ5INnUAVDTvwRb504YgDY8kZZRUXVzKq4yHlp2SWnfAyu5nKMD3f4b0osIzkIADOYs0i8vix5iBydvV1XM2YkejEz+eAdhIEH0QjiNiNYKsyRlaVXBR99cuoBbaF2NgoUuAogOLw/3UYqUeYNz3QjY9Qxw936+uKcLLqkv5BFS+ytlMasNKK2/tURJQNCJ4ug8kUA6uWiZVFNbQeg2mOd7bus3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNVYsQOoREew0bqkEDO6G3EhM0I4EmFxVhMsV0UThJI=;
 b=zOuh59U5y9E5t/BPkU2LoxC1wyyhPS1LIWoVuzXknvFemIskjY6kwp1gDVzUtASpZWzop1X/XWmzDYqQ77ipu8nuC6nHlfGBI1b8cFrHQo+G+MP6CED0QQwe4T8mX4FW9VnG/DSRsUjIipHDK2Oe7L6SPGEe0iidvWUOjj3jQGrCfC52UVoWFyGqpfi8WFVvVFIdqJxZ8+h5YQcuju6tt4RbMCVgPvpqMs+wZlMtYGvxArtspMufmCh9Ln4lmXNm7+yipt2S8Earrz5kBhhJXE3lndFnEUnkmf57qaPzU75sly/ABUjimfD93cJ5psJ3DHRC5rLIbJuxomcBsouoag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN6PR11MB8218.namprd11.prod.outlook.com (2603:10b6:208:47c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 19:16:36 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 19:16:36 +0000
Message-ID: <0a0ed9d4-6511-4f0b-868f-22a3f95697f8@intel.com>
Date: Tue, 5 Aug 2025 22:16:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] perf auxtrace: Support AUX pause and resume with
 BPF
To: Leo Yan <leo.yan@arm.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
	<irogers@google.com>, KP Singh <kpsingh@kernel.org>, Matt Bobrowski
	<mattbobrowski@google.com>, Song Liu <song@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
	"John Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Steven Rostedt
	<rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, James Clark
	<james.clark@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Mike
 Leach <mike.leach@linaro.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
References: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
 <fd7c39d2-64b4-480e-8a29-abefcdc7d10a@intel.com>
 <20250730182623.GE143191@e132581.arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250730182623.GE143191@e132581.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR09CA0028.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::41) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN6PR11MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: dcaf8d82-d564-4942-35da-08ddd45498a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFhrMGliZFgvOEtLYUpTU1VzUGd0U2gyY1orNlc5NU9FUUNSZkFvWVY2T3VR?=
 =?utf-8?B?ZXIyVERUZmJTVjl5SmR1b0lveU9MUlo1MzMraGwvUm10dU4vd2twVzRRUys4?=
 =?utf-8?B?NkpRUDUzajBTZWoyUi9YWUZpMlVzOU5uUlZpcHlFRG9XR2xHZFd5bEtraExt?=
 =?utf-8?B?NUkwTUVndjB1aU9uZVdhSmJIU3dLQms1cUcwYVdKTmtsWHA5Q3pINXNiWHA2?=
 =?utf-8?B?TllnbVJFeXBSRGlUYXZZTkp3S0l6VktkRVA0Wm9BT3dkeUJoRFR5blBXdjNM?=
 =?utf-8?B?WUxncWtya2ZkcmJjM3J0cHhHZHZtZllwWnBZeUljSGVIbm52alBpV21pSGhC?=
 =?utf-8?B?dzVQNEZEQlFpTlJIekd6eml0dTB0a2R1enN4ZFVISGNmaStNd3FpZ0FBUElK?=
 =?utf-8?B?UE8xbGZWQTRIUU1CRG9zd2dwc2RvMHY1RTZwMFdXODA4S0FQQ251UlFKWExO?=
 =?utf-8?B?OThQVHdmNjVFbGNESmpLTHZGYWM5Q0FJRFF1YkorNVB3YlpyZjhpV0tpMmNi?=
 =?utf-8?B?TURzRU1kQVBOMEF3STRjVVppTmdCVDdNdVNIL3N0NlRvRkFQT2xIWWQ1eHh2?=
 =?utf-8?B?S2tva3RHQ1o2UmJmT2JNRFVTQ0I4bDJzY1U0cnBaRmIzTkgyL1o2Tms5TEVV?=
 =?utf-8?B?YXhHM2R0SkJJb0ptM01JRjZ5aFQzTDB3aHJwWndSMnoyOS9Fb0ZNUGlSM0sz?=
 =?utf-8?B?ckJtMFZsVW1DVDM2eFJDUXVGM1ZFblBMK0hESU11bGFlcnVNK1hqbGdhZUFw?=
 =?utf-8?B?bkdrSGhnSVpHMGVsdmJBUFNpWGN4c0VvUXAwYVJmV1ZrMU1Nc1hEYnhlZFVE?=
 =?utf-8?B?SzNGb1hDdWJUdmhSOFhtdkVYeWI5ZjI5dlZMZmtwTkNEWUF6NVk0eXorWVpa?=
 =?utf-8?B?aWJoTlUvMDZWSkNFc2xYNHNoQUJGRUtuaGtMNVFqZWJ1QXAxZUZJZExTT1Nm?=
 =?utf-8?B?VWN1aVgyR2VqU1J1VkV6TFltUzdqNEJ5L3lvTDMvaWh0YnhjRG5wem1MOXJl?=
 =?utf-8?B?Q25GQk1DMENUWnd1NHlGOXo3MTByRE0rQjliVDJnWmpFYjl6ckZqVUx4aVV0?=
 =?utf-8?B?MmJ6MEt6UmpQN1lzTXV6emsveTFUUzNMc2JBNmFzaDM3WjJmNHJ0MHAzUlp6?=
 =?utf-8?B?Y3ErTzFZcEU3Z0tDZ1JHUU9aZXFJU1IxdldicW1yTnlvcFgwZEswWitOc3Vv?=
 =?utf-8?B?MGpJUFovV3NLUk9SZWltbzlvVmZTMzJCWERYNTU3VXE3RVEzVGwxMW9JT01h?=
 =?utf-8?B?R0dQM2w1UmUxT01SVWFjSVhtM1hCVHJQOXZ2Q2Z2TjMrSjRIL3VWbkpRVDBr?=
 =?utf-8?B?b3ljSndub0NaeUZyaUZyZkdQQm80L0NBT0tBRTI3Rm4ySGlTbS9Pbzl4QXVq?=
 =?utf-8?B?TC96YUxWYmxGYWJ5emNSOHF4eElOaHJwQ0tZQllUbnExMkdZL2JNTG5tUzlw?=
 =?utf-8?B?em5Sc1FYV1lOdGNiOFdNekcvU2EveDcrdk9xMHFFN1RDOUM4YUJ0S3FMTTFl?=
 =?utf-8?B?Z1BvdVZ1TFU0OWRsV2ZVakdaWnFTVUlwUlZVc2EwNEtXS1YyQ05KZmd5cUVp?=
 =?utf-8?B?N3R0SFNLL2tIaG16WGhsclZZMTRLbG1SeklNUnU4KzhnSVE1dXdqeXIyNWhk?=
 =?utf-8?B?aVhlZkpnU3liaENra08yK2JKZVNxSTdrSzFxZ1hPUUpldnNpcy9ocStvYm9D?=
 =?utf-8?B?eXdiTVpvTkN6MmtNNnJTS0h4NmF2aVdPODgxK2xPZDBFWUFWUEg0d2lVWi9N?=
 =?utf-8?B?RWdHbjZvVmlBYlZoQ2kwTTY4aGE2emRXbmkvQlpuUjRWeEw4V0t6Y09wTVpB?=
 =?utf-8?B?NnBwMXJydThFOGZRd2ZISFI3NDBaYmMyU2Z1QXJCVE5xRTlXTzY2bS9QcEtM?=
 =?utf-8?B?aUl0UWlCcTF0TzBLWHFxMWpHNHg3VVRUZWtJY0h0c0pCcFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBhZ1pUNjVCbE1vY01xTXQ4WWYrU0FKS2NzTDY0NUloWFFsNmhsbnkxMWlR?=
 =?utf-8?B?V1RON0svQmxWcDA3aUV0V0p3SEluUkg4bW5XZmNuVWdiNmxYMzRzWGFKZ3VE?=
 =?utf-8?B?UTBTeGJraDh3TWRCc2NUSExmZG9tK1BKUFdOaVR2RXZFUm9NTkVRdXlSNVlS?=
 =?utf-8?B?UjBHUzRVWTAzNWxWa0M2OWUraTlDWHJLS0xNK2JxdFRBcERZbEtlMXFlOXVw?=
 =?utf-8?B?RUpOcllEZ2YrQXl0cXlFVWVOb3FWdlJsOThVbGcya09YRUlBbVhoUnEyR0pj?=
 =?utf-8?B?b0I5djFMNnhlUFVuNE9KNVZWWWxHViszcGNseGpHcUVqd3FrWlhoVHRobngy?=
 =?utf-8?B?L0RKZU1ZMVJ2MEF0NEoxR1dSRUFPZjFWTE1UTmNXUFpGT3R6ZmRJNlhQTDlU?=
 =?utf-8?B?d1pEbjI3cDV6NGhaN1QyUFFQUWd0TzB6M3hma0RGYW5tQ291b2l2TmRjV0Iz?=
 =?utf-8?B?L1hkWndSQ0VhQStRdjA4VHBWSTBCNXZoVDJjaWpMZ1krdkVpTHdMb1pMRWFO?=
 =?utf-8?B?VVplY3IzcGljM3dObzhqZmZDOHNVSUUrYklYb3FBdnVSUlpNak9Tdk5ibUdI?=
 =?utf-8?B?Sy9SZ2h0Wm9tRVRjMS9MMndKWTNwdkhiSGtUTnZ3U3NLUWFpR255MHhvWmVB?=
 =?utf-8?B?V0pUd1BmL1p5Z21rakZ6QjdpQzVtZkRPdWV4T3doSWRtZkRpUkJCdWdwdWEy?=
 =?utf-8?B?WXpnbXEreklaWVlLZUwxV2VvdDI2Ym1xcXl0cXJ3b05vUzg2OFdHbno3aFNu?=
 =?utf-8?B?RHk3WFZlaWh3RG5PYWxtcG5zbzhyZTBoWHZmekdaazdOTlNPQ2k2eWY1d1lN?=
 =?utf-8?B?bWREZjRTOWIzRG5QZDdtV0VxbW1Ya3Jlb1BsblJGRGlqWkwzSWVLdDUxTjFI?=
 =?utf-8?B?RDZILzFIaHNQdGgwK1VSSUVnSTAyUXJtaHZWRHR0Vm03TlZaK2p4T0NvSVVS?=
 =?utf-8?B?WVVobmxtOEMyU2hkVkZlcXhwNE5pdXVLbUdpSFFpcE5CZ0NMVGNwZnkrUzNT?=
 =?utf-8?B?OEFQWW9Ldm1Za2xNUG5IVFBHQnQrYzVvTUd0Nmo1bE5KNTgwa1ZSaXVHWXQ4?=
 =?utf-8?B?RUZWWUNYRHY3SFlLSGRVbW9Xa3VLSTNqOUtGZmY2UjZKb1NtTjBtcFFZSWdW?=
 =?utf-8?B?bGpLQ3FTSHBUKzJnb1I2YkcvVitZR0N6NHBqZlJHT1FCTWZ2S1VPVEtXWjIv?=
 =?utf-8?B?MkE1UzE0L0ZZVkpvMEpCQytqT0NwUjBwWE0yRjZpVXBocWNoZkMremFTajRP?=
 =?utf-8?B?djZWQWp2K2dKOFNzN2pCNVNEd1ZhV2V0QnFPTkhBaUcydlZxUytVK2dYWXZk?=
 =?utf-8?B?TjFwVDdldDQwZStlcTZycHYvSlRQTlY1WENZTXEvNXV4K2dPSTZwclJQOUx5?=
 =?utf-8?B?Y21Wb0cxQXYwQW44QzVKSmtjRmtuenFNN0l3c051dnBXR0tRUEorRm43OFph?=
 =?utf-8?B?NzhLaUZKaFBiZHBERTRtNE5RVUlhVEg3WXhFWVdDMDBITW1Nb080QklJZVFz?=
 =?utf-8?B?UFFYaFlqaTJOUFMwNk93SkVMNnpLNkxHaTJQUGFzbEt4aDJDZGxEN1FKcE1I?=
 =?utf-8?B?SW1IbnhGbUx0MUNFcjVBdFpLRFhhQTZvTUNzYk1qV0lVaVdOdXBkeVN4NFJZ?=
 =?utf-8?B?djJIKzlHb3FTeklZZ1lBc1p3RUc3YlBObVIzcFZJWFJWMU9wWVFOVjZlMDJu?=
 =?utf-8?B?R3kwUzJndU44NmNkZWpBaWpaei9SRGJoWDVGMzh1eUtSUjh2UlZNRGFVdU8v?=
 =?utf-8?B?V1cvVnZzNC90N084bFMzaXpxK2FTb0ZJM3RPZVhkK2xYaUlIYkttYVRkbXZV?=
 =?utf-8?B?c2NTQ0ZUWTJQSm1QZFcrRStmaVlkWGJCY3dodTd3aGU4dXdBT3ZPTS9Xd1E5?=
 =?utf-8?B?alg1NmlPSFN6UmdOV1AvcHg3Yk1IT0dXZUI3L0kyOFlQOEVHRkF3L3RJYk40?=
 =?utf-8?B?QW1ROUFzeTZRcXhkb2F4VjJTdTVUdG9DU3ZJZERXYjNGUU9tZFBiWHhLOXNq?=
 =?utf-8?B?Q1JwUnF4WWd2WEFkVHZsU0ZPTHI1bU11bEdpbTByenhOQ3ppVlZrOU1IZUsr?=
 =?utf-8?B?VmpjRlZ0NlU1aDVIclhQQUpaNUt0YVhCNUlPRXlvWjBZTGlsTEpmRkc3UDIw?=
 =?utf-8?B?OEVFajgreFozRXdwSFl3emJHeld2ZU9ya0dRZmM1SmNkYnAwbmNxcEZBSnhP?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcaf8d82-d564-4942-35da-08ddd45498a6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 19:16:36.2593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCRzyzro1klSEj742IfF8eBRncja0cGo6O04SUpwOkAZugmzgwt06z66RYArj2WYxfb0w11fSls3D+YaVb2Ijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8218
X-OriginatorOrg: intel.com

On 30/07/2025 21:26, Leo Yan wrote:
> Hi Adrian,
> 
> On Mon, Jul 28, 2025 at 08:02:51PM +0300, Adrian Hunter wrote:
>> On 25/07/2025 12:59, Leo Yan wrote:
>>> This series extends Perf for fine-grained tracing by using BPF program
>>> to pause and resume AUX tracing. The BPF program can be attached to
>>> tracepoints (including ftrace tracepoints and dynamic tracepoints, like
>>> kprobe, kretprobe, uprobe and uretprobe).
>>
>> Using eBPF to pause/resume AUX tracing seems like a great idea.
>>
>> AFAICT with this patch set, there is just support for pause/resume
>> much like what could be done directly without eBPF, so I wonder if you
>> could share a bit more on how you see this evolving, and what your
>> future plans are?
> 
> IIUC, here you mean the tool can use `perf probe` to firstly create
> probes, then enable tracepoints as PMU event for AUX pause and resume.

Yes, like:

$ sudo perf probe 'do_sys_openat2 how->flags how->mode'
Added new event:
  probe:do_sys_openat2 (on do_sys_openat2 with flags=how->flags mode=how->mode)

You can now use it in all perf tools, such as:

        perf record -e probe:do_sys_openat2 -aR sleep 1

$ sudo perf probe do_sys_openat2%return
Added new event:
  probe:do_sys_openat2__return (on do_sys_openat2%return)

You can now use it in all perf tools, such as:

        perf record -e probe:do_sys_openat2__return -aR sleep 1

$ sudo perf record --kcore -e intel_pt/aux-action=start-paused/k -e probe:do_sys_openat2/aux-action=resume/ --filter='flags==0x98800' -e probe:do_sys_openat2__return/aux-action=pause/ -- ls
arch   certs    CREDITS  cscope.out     drivers  fs     include  io_uring  Kbuild   kernel  LICENSES     Makefile           mm   perf.data      README  samples  security  tools  virt
block  COPYING  crypto   Documentation  init     ipc       Kconfig  lib     MAINTAINERS  net  rust    scripts  sound     usr
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.067 MB perf.data ]
$ sudo perf script --itrace=qi | grep -B1 instructions              ls   37607 [003] 36109.137560:               probe:do_sys_openat2: (ffffffff9d2276a0) flags=0x98800 mode=0x0
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9cdc3834 native_write_msr+0x4 ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9cdc3836 native_write_msr+0x6 ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9cd26728 pt_config_start+0x58 ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9cd27727 pt_event_start+0x107 ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9d0d5a04 perf_event_aux_pause+0x114 ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9d0d80f7 __perf_event_overflow+0x197 ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9d0d844d perf_swevent_event+0x12d ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9d0d8738 perf_tp_event+0x188 ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9d00fad6 kprobe_perf_func+0x256 ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9d00fbbd kprobe_dispatcher+0x6d ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9cf80582 aggr_pre_handler+0x42 ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9cdbcbb2 kprobe_ftrace_handler+0x152 ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffffc12440f5 ftrace_trampoline+0xf5 ([kernel.kallsyms])
              ls   37607 [003] 36109.137562:          1                     instructions:k:  ffffffff9d2276a5 do_sys_openat2+0x5 ([kernel.kallsyms])
              ls   37607 [003] 36109.137563:          1                     instructions:k:  ffffffff9d4c3d60 hook_file_alloc_security+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137564:          1                     instructions:k:  ffffffff9d4a5050 apparmor_file_alloc_security+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137565:          1                     instructions:k:  ffffffff9d42d400 cap_capable+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137565:          1                     instructions:k:  ffffffff9d4a4b70 apparmor_capable+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137566:          1                     instructions:k:  ffffffff9d42d400 cap_capable+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137566:          1                     instructions:k:  ffffffff9d4a4b70 apparmor_capable+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137567:          1                     instructions:k:  ffffffff9d4c4e80 hook_file_open+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137567:          1                     instructions:k:  ffffffff9d4a5aa0 apparmor_file_open+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137567:          1                     instructions:k:  ffffffff9d31fb10 ext4_dir_open+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137567:          1                     instructions:k:  ffffffff9d4cc740 ima_file_check+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137567:          1                     instructions:k:  ffffffff9d4a5960 apparmor_current_getlsmprop_subj+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137568:          1                     instructions:k:  ffffffff9cdb76c0 arch_rethook_trampoline+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137568:          1                     instructions:k:  ffffffff9cf80670 kretprobe_rethook_handler+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137568:          1                     instructions:k:  ffffffff9d00fe90 kretprobe_dispatcher+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137568:          1                     instructions:k:  ffffffff9cd282c0 pt_event_stop+0x0 ([kernel.kallsyms])
              ls   37607 [003] 36109.137569:          1                     instructions:k:  ffffffff9cdc3834 native_write_msr+0x4 ([kernel.kallsyms])

> 
> I would say a benefit from this series is users can use a single
> command to create probes and bind eBPF program for AUX pause and
> resume in one go.
> 
> To be honest, at current stage, I don't have clear idea for expanding
> this feature. But a clear requirement is: AUX trace data usually is
> quite huge, after initial analysis, developers might want to focus
> on specific function profiling (based on function entry and exit) or
> specific period (E.g., start tracing when hit a tracepoing and stop when
> hit another tracepoint).
> 
> eBPF program is powerful. Basically, we can extend it in two different
> dimensions. One direction is we can easily attach the eBPF program to more
> kernel modules, like networking, storage, etc. Another direction is to
> improve the eBPF program itself as a filter for better fine-grained
> tracing, so far we only support limited filtering based on CPU ID or PID,
> we also can extend the filtering based on time, event types, etc.




