Return-Path: <bpf+bounces-64542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E24B140DA
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 19:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97BE16710A
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5213274B49;
	Mon, 28 Jul 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFc3q7wd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1221EFFB7;
	Mon, 28 Jul 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722211; cv=fail; b=u3sOAlHVuYp69GpL7uC6eqwviKwHLRZX2usJAV9IH62SgDvdWLmGrJ8VbWcsqrMhfVqWU/qgtLrxi3921Nh74af0prE2pYURGmwALp8JoVap9e5kcCrW0oaacVT82GqucKYKmLabTu3jbOhn+q0P2ke5p1ppUCmtW8ULwidtQy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722211; c=relaxed/simple;
	bh=9g/arCZyjbxTxbkPhq6Xurz9tw2oHPdJrZc3nBoudzA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fTXEHIm1VRO93vJkt+BaWI1TvfgQXkMqjXRkaLh7cJ+Qz7g4gOBoW2UXXG90bVao9f1CjP7Ir6G9rR4IVvST8ELnx6Zgt3HLAzZVFMc7BsLB5rBoCJ0ZQWiP5iM+PDOCSW9B2w+uNsPpIIsyeBgVzH55lTzA+VfV/1sH2Xbg2uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFc3q7wd; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753722209; x=1785258209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9g/arCZyjbxTxbkPhq6Xurz9tw2oHPdJrZc3nBoudzA=;
  b=WFc3q7wd6CkrakDHv9K9jZdjgVaHJWjkXIiJAnQRI391a8XdRfnbQdTU
   /PVmAHEVCnTSX4GPa4H0XB94F4nPYlqkNdzYr5RqwQf5+4/lsyciKnYsi
   TizqT86SfiK7zs/qMlIyInB+WSnfKpqv2Hb3F/69mD0gYsn0KzNPk8rmH
   1t9aRCCD5NXvwlYw0DFSt4jpCBL5/7Z0wKes2m3d1K4ckQiU/Lz4vO5Ry
   ENT11qWmTCx/Fv5n9WBZcqDlbBDkWcgMCehmGDlqVy0fMiu6RazzkiEDv
   ZNk1ZCq8//DWggmwqipMyvvoNqt/NrMtcZLCHEFJd0OgrB6UsdTje4BZZ
   g==;
X-CSE-ConnectionGUID: VNVfLeAQQdWDfCve2Yy8WQ==
X-CSE-MsgGUID: osiEL3vJShaV5qa8EHF0QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="59627136"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59627136"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 10:03:23 -0700
X-CSE-ConnectionGUID: a5KwmXkMT1aSTIW/6g56kg==
X-CSE-MsgGUID: aSWMunEEQ0mkS+3HP7rosg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166953049"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 10:03:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 10:03:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 10:03:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 10:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZRuPCB256wYMlG9FKcwKz1gTEVqJpVDf0r12MrjfweEOpgQHF6FJHm+PN6pdKcP3bQTKkf+qaKVVKeioB37oUcPovGKCfJM1hZwuh1GmGizWnOLNDj3DCoEnLNSKQp01d0oDFurfJ91tERPXNTQaxNcDNEl+ZOMWoLt81Q7si7zBEB3FtbfWszLX8cQW1YlzfqOhqzZn0WMkXAMznoo6OjzDoQIhC4/BWns2mi/9w8SNgZIPoMsMRyvteQuobHJimA7xrktg5bJJrbQXRSryrW4C8ohD7fyN9q/3GEWoAICtpOzuJRPRrDWiM+KQIRR/zrHLZfz98gNayixb2NLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfeUUM0ninQ7HnxearednL75mb0ljwoTWUfaUgy3EzY=;
 b=A5GlJeFL0Rvtx7rHCDRTdjY0o0KwlD6IKyuDBX0zSuGhmSjsdoj9PkXanaaA/SDykm5sGHZYtw6kEVjLvk2KgaPAfoNnj/Pen0CxG7BYQze7sl3cA3uW/jYTivIwEFb+L0unOBs0H824TnQnXrb6GPDfAUEBC5FSurIMiW0IDmopvegOAmeG7DixS/CECQdQM88aIX11NJw5C+Q/Ak84H164X38sq9BVufxa7a7zUO4eaPnS0jwxVUizJgHWtGjWodQgJx9gOGQZ13JAiUTSV5MvxYV7RkmSIWnm6D9exk1RgHPCDncfWBcjvG/y0goH+UGOf+hp8COCDY+mwyBy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 17:03:01 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 17:03:00 +0000
Message-ID: <fd7c39d2-64b4-480e-8a29-abefcdc7d10a@intel.com>
Date: Mon, 28 Jul 2025 20:02:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] perf auxtrace: Support AUX pause and resume with
 BPF
To: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
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
 Leach <mike.leach@linaro.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
References: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR03CA0101.eurprd03.prod.outlook.com
 (2603:10a6:10:72::42) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|LV2PR11MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d95155-7c39-44c8-0b2b-08ddcdf89af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDA4Q1dtM0tQQzNNWjBISG9LR1NOVS9YWElQcTY2bGtTY1NxTTd1Y2ZzZHV6?=
 =?utf-8?B?QUpsVzkvTmNDTWJLUEpBYUlVZ1ZCYWE3aWhoOHF3NVpCM0szUCtISXdWRWJF?=
 =?utf-8?B?K3N1TVFZZUM0UG9yMlpaZHZKN1B1NTd3a0NiS1AzbTVnKzhYcThDZk9aMk5X?=
 =?utf-8?B?QjNzb0FuY3Ixa0lSYm1jRzdvR0FjQjUxSWtXT1BsZEg5V3kyRmJlSk5ZR1Uw?=
 =?utf-8?B?cUp0Vkx1RXdiczh4S2NYWUl0d2g0cUtVUFNOSE9mUEtVK0IvUzdjNEVKWWt0?=
 =?utf-8?B?Qi8yR09RWkI5YUZDS1NWMVZDYnZGYXpjbktzL1Q4TllmdmNBVlFnS0FPZElQ?=
 =?utf-8?B?RUd6TjdZZVkvVHIvUkQ2Wk55VzNENmp5TkF5SjRuMnRrcjFkUXM2WTJjNWtz?=
 =?utf-8?B?T2xnNnR6V3hwZ0xRLzROb3o0RzFucWJ6bE1uYWdZanpabzh5SFVpWjRBWEFl?=
 =?utf-8?B?Y1JQYnMxOG82bSt2eXpQWFV4eGZUUmMyamRNRXRMWXE4SzhzV0RTbHJMNFp6?=
 =?utf-8?B?MDdJZ1JzVGVPdmpyRGxuc1h2cVFRZ2lBSThwY3dUQWd1cGFTM2xPU3lPTGhL?=
 =?utf-8?B?SU0wdEhseFdBVkF0SUg4cmhXQmJSeHBTaVZ1TWt2WkRtR2pqMVBTM2VDL1JO?=
 =?utf-8?B?b0xxaUZlL1RINnRRVlFhM3FtQnlhS0h6ZG5HN0Z4MGdWNTgzRmp5Sk9JRmEy?=
 =?utf-8?B?anRnaUdNUXA2eUorR3JSWFRReVEvTVpyU1NoV2IyV0tUTDM4VW9vZUJ2NmVs?=
 =?utf-8?B?MlFCTU5ycHUvZE1rQ0lmU29MYkpVbGRIK3VCNFlzcDhBVnhsY1hLOHVOY1Rn?=
 =?utf-8?B?dlZzVnIwd1ZFZVhrM3p3QlJybEwxWm5RcWdZb0FjWUQ3QlJyKzFHS2p2Y1dB?=
 =?utf-8?B?M1NJejEzK25RRll1N0dIa2N3NUVmZENFREw3MGRxTlh3TWYveEJWaHpHUWg5?=
 =?utf-8?B?b1RabTlLTVIrSHllbzNpRFNiZE9ZcTZoNFZySnVmY3plY21JVTBGMUxBZXQx?=
 =?utf-8?B?SVQyRWI5M2N5K0pOdG5POG5sKzFaTmJpMXM4QnFmYi92NmpiaTA5dUNxektX?=
 =?utf-8?B?aWlLNlZUUUcvWWo5NnZhcjFKdklrYUVSc3JDeWdxd25tL2Z4RXZVUkk4QVpD?=
 =?utf-8?B?S0g1cWI4R0lzSFRUaTQ5L2luSkppU3BFczFuZ25STHo5TkQ1Y3Q3NHh0VWZH?=
 =?utf-8?B?dHJqbnJxWmJOSUlwT1JNWTRCVjV5ZkZyMGZaUzBkdjV2Sm1uOUY5YWxJakRY?=
 =?utf-8?B?M1hKRUplUTZ4RHVkTjBRQjQxRStmMFFmbDFCUmw5SGluM05IYkp3eW4veVp3?=
 =?utf-8?B?WjVqeVk4RDhTUkdSZ01yQmRSc1gwL2FVTXZyUDlyRVJxU1NLdFNTN25sb1ZB?=
 =?utf-8?B?c2JtbHlLb0ZweDNaSlZDY2hxQUNTeWpDNFh2SXVoaEIybC8xRytnUzRaVG1w?=
 =?utf-8?B?bE1KdlFhVHo2SmNqR0pGTnRaY2czUDJ6Y3lWcks0ZjZBNDNtWXdzb0ZkV1BW?=
 =?utf-8?B?TkY2RG4yM2JjbDd2WU5DUG9JYVYyNkFBUHhLUkZySDM3N1ZiRVAveTRrak5m?=
 =?utf-8?B?VHZrSW90WVVtRHFKUDVwRzlSN1lEN2k2ZWJvYXE2N0JXZnhPMmg0UzdPbnd0?=
 =?utf-8?B?Vk9wNGN0WnZDdGEyWHdKR1hmM2ExQ1JnZ3dpejVENGZBVnVQSEU2RjFTK0dS?=
 =?utf-8?B?TGhGd2p4Q0lQSmpBVTJKVnd1VmM0WFljbnl6N2dSM1piK3BpUU45amZiVWs2?=
 =?utf-8?B?SVlub01YK3h1ckdxS0FDMnB3N3RTeGJZMVRmYmttVHBaQjBOd3V0a3RYdHM3?=
 =?utf-8?B?YzZ5REtpUVNNN3MxL2E0OGsyWUNkNkxOcU45WjJCekdDeVZiR2gyenJQMXc1?=
 =?utf-8?B?YmF5RkFJTmI2dVVlaGF0Z0ZHUmkyT1l5blNaOHEvd3diZHBhdUs0dnFmUVVT?=
 =?utf-8?B?a3JUYWQ4d0pzbHFOQm5UN3M4blJZdFFZOGVhQTgrUlVyUndLWHByZE1WYi9r?=
 =?utf-8?B?aHhOcGZ2RC9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDB1Z0VVbW1PVlU4aVlxaGVPWVJvUUx6b09DNC9sM1hkT3FibW5UbXZzaWds?=
 =?utf-8?B?SGhFdHhubUNSNEloWkZ2ejZLbnQzSFdaRUZnT0JCUGpQeWJ0YXdTNStoR05F?=
 =?utf-8?B?cndvL1IrQW45NW1xOXdSanhYN2o5UFNGTGJ1ZkRjQzFnL2NkclBETnBQalU5?=
 =?utf-8?B?dllsTTk3dTdBanhhZUtKYXYxVFQwb21TWGpiRmE3MXl5YUhLejJwc1NzU0x0?=
 =?utf-8?B?WldWMTZvOElyMi9pc0R2NG50Y1BiMWNXdWg4azJ2QkZpNHAybElUOS95WlRz?=
 =?utf-8?B?SFJOSERxVjE3cHFibnFOUjB2OXlqY2xML29kVktiOU9vSnNiQkw4LythZ0sw?=
 =?utf-8?B?eFJuQTlsRFBOWVNuRmhBdmVqVFk5dmwyMjRqb1YvVVdYUCs1SFJwaE9XN0Ju?=
 =?utf-8?B?b0tQQytaQjJUUFYvZzdXaHcrT0owLzUzRzRBRlVrMnpQOGZsOFJ6SG15eDFL?=
 =?utf-8?B?WlNzMXowc0Y3UGFrVlljRmUrMjNnd242Ky9sV1R0TE5IOWpEM25oUnJVVWFP?=
 =?utf-8?B?M1lzUEgwV3pCTTR2S0Jxb0JCc0ZtMGRjQnFZV0lIWG8wb1BZT2FZVDhHeXNF?=
 =?utf-8?B?Vnl0OERmRms2aCtwQlB1U20xdXI5TkR6M3pLdnd2Rk9UcTdoSjhrQ21rY3Zh?=
 =?utf-8?B?Tnc4VVBHTEpYc2NLUkNzOGs3Q2dHdk9TN0NCd2MvdC91eFE5ckJhY0FRVlo5?=
 =?utf-8?B?ZmRCb0JrUXdtcWFSb3FwWU1EQjJVYmJ3M1JkZUo5T3FXZWRhOEo5WEhrWjRS?=
 =?utf-8?B?OFFYbGplT0twT2JGNDB5anNyYm1VYUM2NmhTZ3dEYXpUQ2FaZGxzL2YyMWl1?=
 =?utf-8?B?RGhmc0RkQmdMZlVNSSt4bGRvN2s3c0dlS1pzeWJ5dnlacFJXMFkzWE9GVUlJ?=
 =?utf-8?B?cTlQNGNpU1dYOGhOazZ0UGpqa1gwRmV3dkozeVRFU1M3ZFpFTmZJWGY0MENy?=
 =?utf-8?B?eFNFU0RINjFJbXh1bW1mbEszb2dlM2RWc3Z5NmZ5aUIzc010NzZ2VFF2c3Fx?=
 =?utf-8?B?czFPYXFuYXNmUklmQTNsWWVMRlBKM2VsdmN0OEFCcHVlWWtJckxaVXhMSi91?=
 =?utf-8?B?V1lSYzZxYlZOT2FDOXc1Nm9GQ1BnNGdseGlhU2FGVi9YaG5HWVlwRWQ2UGpw?=
 =?utf-8?B?dkRmT1JRM2I5aTA0M1dNYllydXlRRTFWb2piRTU4K3A0clA4bzM2VHA3RXNa?=
 =?utf-8?B?ZTFHSExDZUZ2T1hkcURVZkZsNGRNdm0zY3QxWjlQYnVnSVNvdnJsdzVVWUY0?=
 =?utf-8?B?WVhoVDc0a2ZwU2lnN2kzSEtYa0tSREdnY1lhTHRxOWhsYXVHNDROQWg1Vmht?=
 =?utf-8?B?S3NmbXpJVEwreHBMb3NjNGNpeG96RVpKUitSZjJSbkVPTkJtRUphSXdIT0x6?=
 =?utf-8?B?Nkg5aFBQQXZ6aEFzYlU4YXZJSVBxMGRCaGJUZE0wcWdVNit5cG04VlhRQi9m?=
 =?utf-8?B?RlFtbG1GUUp4UmJ4Smpvc3FUZ21SRng2K1IwS1BYVC8wbC85YVh1d2pQSS9n?=
 =?utf-8?B?bUFMUDFzQnhMOXo2WU9NOVVOeXo1ZXBWY3JVdngrejhRUGs2Qi92NHhoWTFU?=
 =?utf-8?B?b0hPTWJCUUNJSm01NWVjZzhIQ3YrVm5IQWsrelBwdXREMGFxZDBTYW9BRXNx?=
 =?utf-8?B?T200VURQdXJLZHhJU3RRd0tSdnRHZnN0VWVpR0ZEVHlqZStoTFJiRnZQWGFu?=
 =?utf-8?B?S3dzV3JZbFZIM1Y5aWxsdWE0SW9zWGMyTWtnY205T3F2eG42NHIxeWpremFa?=
 =?utf-8?B?OGFnVEJiazlaVzlYNXBXZ1VMSnhabmdTRnFNSmh4TmFNZDB0WmpaN0tyL1p6?=
 =?utf-8?B?WXRueHR3N1NZLy9ENGZYb3VUWjVHMEtGbDFxZjhINSttVGk4Tk1iOXFSbi8r?=
 =?utf-8?B?OVp2OGY4eFVrRkNPNTRzT3BySkE5OTcvYm5NaHFaTVE3MjE5YitDWDVkNWJC?=
 =?utf-8?B?TC9hclhZUVg1dDIrNmpNNW1KMlJHWVowbjZtUy9jakx6Q2pHSnRSYzM5NTcx?=
 =?utf-8?B?OUNic0VSQmJheG9oZEZjemg3a0F5NXhsN2dtRDBUaFpPR1lGQWFJMHJtRDZH?=
 =?utf-8?B?M3k2ZDNlN0FkYWxTUlgvN2RQaEVUTnl2c3kvZThVVkIySXMwbUt0bXJWRFpi?=
 =?utf-8?B?dWtMQkpqdDZmajdlRUdGR1JCK2pSNmMzSi9hQWZqZjhuVWZCSVpZOEFpVk1U?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d95155-7c39-44c8-0b2b-08ddcdf89af1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 17:03:00.2300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrywR6UuXs/wxez/wHO5HMiedIWq2H257/bCE5mtiCND+8PpQFzx3JKYlKWdTUa0clnxv7CR7llo7/OrY8aApg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-OriginatorOrg: intel.com

On 25/07/2025 12:59, Leo Yan wrote:
> This series extends Perf for fine-grained tracing by using BPF program
> to pause and resume AUX tracing. The BPF program can be attached to
> tracepoints (including ftrace tracepoints and dynamic tracepoints, like
> kprobe, kretprobe, uprobe and uretprobe).

Using eBPF to pause/resume AUX tracing seems like a great idea.

AFAICT with this patch set, there is just support for pause/resume
much like what could be done directly without eBPF, so I wonder if you
could share a bit more on how you see this evolving, and what your
future plans are?

> 
> The first two patches are changes in kernel - it adds a bpf kfunc which
> can be invoked from BPF program.
> 
> The Perf tool implements BPF skeleton program, hooks BPF program into a
> perf record session. This is finished by patches 03 ~ 05.
> 
> The patch 06 updates documentation for usage of the new introduced
> option '--bpf-aux-pause'.
> 
> This series has been tested on Hikey960 platform with commands:
> 
>   perf record -e cs_etm/aux-action=start-paused/ \
>     --bpf-aux-pause="kretprobe:p:__arm64_sys_openat,kprobe:r:__arm64_sys_openat,tp:r:sched:sched_switch" \
>     -a -- ls
> 
>   perf record -e cs_etm/aux-action=start-paused/ \
>     --bpf-aux-pause="kretprobe:p:__arm64_sys_openat,kprobe:r:__arm64_sys_openat,tp:r:sched:sched_switch" \
>     -i -- ls
> 
>   perf record -e cs_etm/aux-action=start-paused/ \
>     --bpf-aux-pause="uretprobe:p:/mnt/sort:bubble_sort,uprobe:r:/mnt/sort:bubble_sort" \
>     --per-thread -- /mnt/sort
> 
> Note, as the AUX pause operation cannot be inherited by child tasks, it
> requires to specify the '-i' option for default mode. Otherwise, the
> tool reports an error to remind user to disable inherited mode:
> 
>   Failed to update BPF map for auxtrace: Operation not supported.
>     Try to disable inherit mode with option '-i'.
> 
> Changes in v3:
> - Added check "map->type" (Eduard)
> - Fixed kfunc with guard(irqsave).
> - Link to v2: https://lore.kernel.org/r/20250718-perf_aux_pause_resume_bpf_rebase-v2-0-992557b8fb16@arm.com
> 
> Changes in v2:
> - Changed to use BPF kfunc and dropped uAPI (Yonghong).
> - Added support uprobe/uretprobe.
> - Refined the syntax for trigger points (mainly for trigger action {p:r}).
> - Fixed a bug in the BPF program with passing wrong flag.
> - Rebased on bpf-next branch.
> - Link to v1: https://lore.kernel.org/linux-perf-users/20241215193436.275278-1-leo.yan@arm.com/T/#m10ea3e66bca7418db07c141a14217934f36e3bc8
> 
> ---
> Leo Yan (6):
>       perf/core: Make perf_event_aux_pause() as external function
>       bpf: Add bpf_perf_event_aux_pause kfunc
>       perf: auxtrace: Control AUX pause and resume with BPF
>       perf: auxtrace: Add BPF userspace program for AUX pause and resume
>       perf record: Support AUX pause and resume with BPF
>       perf docs: Document AUX pause and resume with BPF
> 
>  include/linux/perf_event.h                    |   1 +
>  kernel/events/core.c                          |   2 +-
>  kernel/trace/bpf_trace.c                      |  55 ++++
>  tools/perf/Documentation/perf-record.txt      |  51 ++++
>  tools/perf/Makefile.perf                      |   1 +
>  tools/perf/builtin-record.c                   |  20 +-
>  tools/perf/util/Build                         |   4 +
>  tools/perf/util/auxtrace.h                    |  43 +++
>  tools/perf/util/bpf_auxtrace_pause.c          | 408 ++++++++++++++++++++++++++
>  tools/perf/util/bpf_skel/auxtrace_pause.bpf.c | 156 ++++++++++
>  tools/perf/util/evsel.c                       |   6 +
>  tools/perf/util/record.h                      |   1 +
>  12 files changed, 746 insertions(+), 2 deletions(-)
> ---
> base-commit: 95993dc3039e29dabb9a50d074145d4cb757b08b
> change-id: 20250717-perf_aux_pause_resume_bpf_rebase-174c79b0bab5
> 
> Best regards,


