Return-Path: <bpf+bounces-75856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19740C99EDB
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 03:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E9C0343826
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 02:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DE32749DF;
	Tue,  2 Dec 2025 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bhF3l3rR"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C418A6DB;
	Tue,  2 Dec 2025 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764644164; cv=fail; b=vDwHqDNA0t3WWpR+yRxxFVdFSjBflsS8Qp7juHiYEKfsH2BPDQcOXZuI1HJfqrzQIDsPjoz9ofrJ8UPrr6B6y/muxXteJFV1KMGLRjObqAvmUjTdAlQZ3aJZrgTSmJu5b4TbriUM1L8J/lyEBCQqE4z2Krdjssri1c4ZApDy5Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764644164; c=relaxed/simple;
	bh=fVnaS0tK6fLLEOvLVoe+8Bgei1ytWgNpAsn3i5LvsZo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GrzoR+h6rcP98Cg6hsfeIJk6Z/oykGvdhfaIUn90FDN98TCYnaC06vHhF/lpnYqYajreOIU7OCT10MdSEHeN9dqWYXLdmG9CnWx/vEGwp6F94MURusIGGbCml2KnTNWux046zZIVlnvHfsE/U/hRR4howuaqYBkfRkke/F5eTQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bhF3l3rR; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylA9agp87qx7Hk6JFDhRG8PLvLCMY84aYYIAECjoTdh1zygyrDUU2Ctowp7Yv4pHxOZU9EmseWBU3E7CokscGFzWLXs0+mt25Jh2G6wFFZFRKjFJqqPqWATwoRD5vcaUbVMtFDemtNvBSPXHDFQhcTM7MfgMQqGaxRyX/TNFFvhrFqRYvL01fKt8oBg7ua0ap5tGKDPrO5NrdfDAmQgwDGv0CGsYo0HUvZF4deZcVq9jKVxYI3w4Q85LQohH3gXPFQd59PKla/xz69aufPlGnjHVznxQuRPG/bC/ILrTsTV3Mkq+wOO2N5R/B9lObUfNHsSvUyABzJgcMTGUOP4tzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+cB1RCpFEK5XWd8lx3sUjoNCSLi0K74dFFeuDj0+t4=;
 b=WG6Aj2HYJJ1w8BPfD5mkdsoQS6tKlc6PLvHYliRik6FQ6V8V9pvidko03TKi7XLXBm3FIwD3LSkvi2rFUpy5Mswe0nwkh8PsNeNQPkrm7aHgSTh82ed3Hp4pWF4aZ3W41374KRR+jLMcdffmbCpz8J+Pr1SW6/PjPxYWvRyXmcRzd0leWJ0JB3Tp5XaDmnuUfpP7ag6hfdNnGN+mEbTRAmBdE/gDskXCkeGZV5ymC3NqbydH8HJLrA9MFl2pK4XDsT+J3jMwwtcC1MZGWoJLfVzqCCBadDv8wJh/litRv6yLq43+At8iGKPEQuYvB8f2fV8h5WtL39cffc1zSgMeIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+cB1RCpFEK5XWd8lx3sUjoNCSLi0K74dFFeuDj0+t4=;
 b=bhF3l3rRgfqDZ/S+yGQHWgdT0ePYpkJftx6oYgZ60vVvvDr5nr0JkWSrG5X71qiWbkACm9nph0paU9O/vhKbt0ODzzgONN4tt4G6qi/8fbyD6wzd/ENQyjHDPfOY37Ph8MWtct6NBx3dW+xoO92EqCnaHQhp8DmZyf5lsKNsWKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 02:55:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 02:55:56 +0000
Message-ID: <cdbaae48-8051-4b0d-93b7-d6e0e925b924@amd.com>
Date: Mon, 1 Dec 2025 20:55:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: Documentation update for
 trace_policy_frequency
To: Samuel Wu <wusamuel@google.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Perry Yuan
 <perry.yuan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>
Cc: christian.loehle@arm.com, kernel-team@android.com,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251201201340.3746701-1-wusamuel@google.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251201201340.3746701-1-wusamuel@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:805:66::44) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f9df35-bf42-4680-f2dd-08de314e50ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0EyUC9iNWpxdFlDcWd3MTU1bEtqNHgxNklOMzU4elpyS1BmMDZGY1FXQkRz?=
 =?utf-8?B?QkRYeUl2OVNONXNjUS9ENHBJR2FtUThxZWRiWGxQcEt2UEtXWjFnbUppUm9j?=
 =?utf-8?B?OXY1d2FZRGw4MCtNWHI4RXVURUlSZkpEMHZyY1ZmM1N6Uy9VRVY1NmdqVWZV?=
 =?utf-8?B?Z2JEUllRN1pnL01qWTBScFlTMXhHZWM2MEw2MEZaTjVDMVgrRi9nemFhZFRE?=
 =?utf-8?B?blNaUUhVbzZNWWJLVEoxTVcwK1g1SDlkWnJaQ3Q0SEVydmh6WXFMdkVuZWRl?=
 =?utf-8?B?cHhZSFZQcGdyd3drVTdyWm9YTURJTGxJREZZalpWNU1xRzMwQTgwZVZrUGVy?=
 =?utf-8?B?dzI4MlJtemUybTBJMENzekg5bUhTaWJxR1d5em94RXVISmJ3R0dWUlJMelFK?=
 =?utf-8?B?dmhQQTl6eGxJelhYaGZidmtxVnV6NFpoQWZkMExtOTFCV1VPZ0NudkdTRDRa?=
 =?utf-8?B?dFFNdkErRVpvU0FQSlJ4S0FRNklnMkZqUWRwUjB5amFUUXg1VUh5cTI2anhs?=
 =?utf-8?B?SlYxYStxYzZpMHpRN1VzRVdIcGNBODM5KzByUkdkWTFGY0wvd1czTkpYUnB1?=
 =?utf-8?B?UjFWRHk2bnZSK1NFTDZjSm1uRXJMdWJLRFA4QldpQmF0ZkNILzA5T2xoQk5i?=
 =?utf-8?B?ZzlyMUxtMDNZV3VQbC9aUXNabUdnNFBtL1VKaDJYUExrN2UxWHlCR2hGT01z?=
 =?utf-8?B?TWNTQnYzSCtjTm50Q1VuSkNVSFpHaHlCMHR1dnVIOTV0QWFlWnN1RjltWjlX?=
 =?utf-8?B?bUNWLzVsa2MxTEk4SWpNMzB0SjNlOUlPckxBcWNHVXBsand0NDYrKzVEWU5G?=
 =?utf-8?B?Ym1hUjQrZzZDTS9wcFpYdDN1VWIwU0xGVEhDdFZoVXAwVm1sSWV5SEg4Ym9m?=
 =?utf-8?B?c0tkaEt6MGZ3QWJkdHpPMzNBckJSbEJqQ3Z6aW1PdEF4N2p5WkFCZmhXb0h4?=
 =?utf-8?B?SVlLS3ZwNFhxNnc0eGF4NENMTGNvWWgyUnZKRlg0cTNEVFRCNUdlNmV2aEZG?=
 =?utf-8?B?cFM5b21ldUxUQ3NLNzJaaG1YV21oZDQvTUR1YXgwUHVnYjJ4ZVhBOG40WVdl?=
 =?utf-8?B?Y014eWdrMnlBVGZURTRnQlQzcnJpRDl5RVNCd1oxaGtBYUlIVjZWbUVxT0Vj?=
 =?utf-8?B?VHpYaVNuZzVJejVxUFVOb09Jc01hbFd0UDFrSVRlaTkwdEU2NGFNZnVRNTZQ?=
 =?utf-8?B?RTZaZGtFbHZjakdoUG9RNHJneUpkcUU2OGkwbGZDa1ZPQjdXNUV2SkZTaEhv?=
 =?utf-8?B?Wkk1QzlBdzlCK0ZUa09xVkpqa09iMjVNL2tWdnptTlNXRWdFR29CWWRVaTI4?=
 =?utf-8?B?QUxqWU9kaWI1QVYxMmVtWldSdTVtenhiVGNaZTVhR1JGVXprT3lGbE5QYkFw?=
 =?utf-8?B?WWNmNEtPTkNVeXgwZmlCTTF5eFNKVXQzQW9ZOUxjZlZBbmFDbENvdGE3OEI4?=
 =?utf-8?B?VnBZYVg5aTNMOVBZcHJGQjRCUllxSXVzamRldlIrZXFKMUNkNVBrOVpFZWRx?=
 =?utf-8?B?eDhEM3JzYXVKZzlNNUpRRWZSbTZUMThJMzNtZFgvVHY1cUZsK2c4QWplMmpj?=
 =?utf-8?B?VURjdEwzRlhhWHhTQ0JVTkxUVU9CT29QOXJCRE05VnI4Qk9aK0JYbitwcTlM?=
 =?utf-8?B?TE5mVnlrZ3ZHVjdpdVVXR3lDSUJ4cVZ5NTdvR2J3aUt0aml3Qksvbzg4Y2Ro?=
 =?utf-8?B?OTlteFg3cW9XOGNXc1BRQkdEQWcwQjE5YzhIVm5xTDNUekhXdmJ4MjRqaXRm?=
 =?utf-8?B?eUg5K3VSb3NSNWxvdlZqSXFJOXJnWUFLaS9KbjZSTkllcmcvaURhSDhXQzRz?=
 =?utf-8?B?MlNNeGlXc0t6UTh3Y2RhbXRxQUtKS0xXSUc3R0xXd3BtbDdkZzFaNGdiMkg2?=
 =?utf-8?B?YU1DbGhhamF2anF5bm9DOVBSRGxPWGFZd0t5NGQ5d3JrSmdQcXJvVUpyMDJw?=
 =?utf-8?B?Sm5Db1ZGcjBqQlRMNFhJZU9NZFNHaGxLSCs1SXJFeXFNYngzZmp4SVlObTZ4?=
 =?utf-8?Q?IZUgdqF30LYQKjNdOQmh9O+AOEetOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXU4bFNPdkFYa0hJUUZPaWNNRlBnK0NmV1BFVkE3dmw5OUVzRHkwOXFGYnY3?=
 =?utf-8?B?K0NWY3hRNXBVWG5wL1hlTnhqSUE1MlNHS2MzbEM1Ym53TzcyY05xNTRGbEVm?=
 =?utf-8?B?T2dBZDZWTkEzWUNvbitIc0p0Z2hpYlpDSVhQUVMzdmxtNlFiUUQ4YjU2VnlQ?=
 =?utf-8?B?UHhrK1FBYW56SVdZM2ZPSXNVaVlhNkdMMTNkQnd3bU85Q0dxc0pPQVE4MFNF?=
 =?utf-8?B?MEZXVWJidStBVnh6SHFsWDRVd3VxRk9TZUQrRTErT3BQU05oR3lTMms4WHFB?=
 =?utf-8?B?QmFmSFduRytMK3ZQZHUrRVFkSlAvN2VVd2tJaE9VUFc2SVV5Y0VzK3ZnbHIx?=
 =?utf-8?B?MGI0K0FrQUxHTU1QNzZNNzBCOTFmTm1LRXhPVVVGNUliWnJpYXBLSkpMcWt5?=
 =?utf-8?B?V1llREFIcFN2RisxM2w1KzhsL3JzTGhvT0hlNml4azhMbmMvZUowamxKZkEr?=
 =?utf-8?B?ZXNFVUF3R0l6Z2ZDVksrektCNTVxNlRZckhaK3lGQSt1YVppUG13bWI2aVpF?=
 =?utf-8?B?WW1qdGxLNXFKUkZiNGhyY2JIL0Vkd1JIMkc5eVVmSUcxSTdVYytWakZSc3JR?=
 =?utf-8?B?QW1BMlV4M0pQeHVIY2FvTmpsbjEvNktyczRWTnhBeGlOMWdsZVBBUlhDcVI1?=
 =?utf-8?B?U2sxNytWRmlPTkJvQmZ3NDVRMUpTMTk1RlpZQVF1RERzVG1FVjlxNUdaSTUw?=
 =?utf-8?B?TjNQN043aGxZa3A4L24yTGtoNU1qM0o3ajN0anl5ZUJUTHM0ZWlOcmVTRTZO?=
 =?utf-8?B?OFFmcTVxc1hGQUdYZW44TWxDcFR1d3RYNlpldGtnUTZHVUFHRGNNa0tWeWt2?=
 =?utf-8?B?ZzNkUk1VTU12T2NxUHI0UUdaLzhJSjlWLzNFY3dmTWJTSk1UeURUVExaYkYv?=
 =?utf-8?B?QUx6YUl0bVI0a0FrQnNzcSt2cUFqQ2F5WUorU3lXMVhlVXp3QTVpODUvclE2?=
 =?utf-8?B?Q2Z1MzF0cndobUV3Qnc4Q0NTb0xKNXByVXR4SUhUK2N3SGk3Ym50VElNQlQ4?=
 =?utf-8?B?WmtTUHBCTjk3ZWs1TVdFd2tWWTFmV1JLOWVHVU5ZdWgyWUNPcXFEbStYOWd1?=
 =?utf-8?B?MHN1RVR2Y0gwTXpDYmNYWFd0MGNRVmNiZzVZRURmelNvN0JuOStONlZ1T1pS?=
 =?utf-8?B?d1Zsd2ZkaXpkaUE3ZklqRUhOQzh2NUNEa0RzamxBM3NWK09qUmRKSUZpUHZn?=
 =?utf-8?B?U1dkUkRGY0o5VnlNbnV1a2RTaERrLzNrNjFpMW9XTjl4ZHJoekhQQkxJQzY0?=
 =?utf-8?B?NEhXZEZPZnVWNDZKNGFZUWJTSU5lZ0NKSTdkOElOSnNzT0tDeCtEVzZ3NG1G?=
 =?utf-8?B?L0NodkUzdHZRcU5rVlA5clk4WXBaWjBMMEM3SUFVUlZjZnc0aHM5MmlKTS9O?=
 =?utf-8?B?dG9XTlRKdEU4clgvU0gvRm9DbnlaVzNVWm1sYWwwMDYzQlBmQTFZY2VOQTNV?=
 =?utf-8?B?bWQxZERjM3hCZGk5WUdxZ3F2ZEc0eEhySjJkWWJJSmovTkJxQnRZVEl4Q2Jx?=
 =?utf-8?B?d1JzQmJWL2ZpYzlWcmdvN21IeFk3Rzl5S0JFendFdjMycmN5L1Y2NW12OUht?=
 =?utf-8?B?cWtmRnV1VmNBSS96MkhYcDlMaEVYQllEeDg1N0VobkJ5OTdneW1aYXd5eXJT?=
 =?utf-8?B?YkQ2cENULzl5VHAzYTYzTW1PN1J5dUNmT2ZhZ2l0cFkveTJkUEZkdmppQTBm?=
 =?utf-8?B?NTY5N0tNZWVmYm1PRFV5em43SmozNzU4Y3BFVWh1RmtiVHgvYmdFQ3IxcXIz?=
 =?utf-8?B?QjlrbWFqblpIazBiN1VZMzc2MWVMWWVXc0daQUsrS0lHNXRlUzNqZW5jUmk1?=
 =?utf-8?B?L1pWWGk5NlpTWDJ6eTlFSys1VG1scEZJWENESGZDb2RnQnRuMUNYZ0tuT0xi?=
 =?utf-8?B?UUg1dUVkNDZhNXZqbzk3eFRyQjB3RjRVQ01URVZXc2Fnam9pSzNMMTY2V0ds?=
 =?utf-8?B?UGk0Qzc5amRSQUJEVWFOUUNYT2hKRTZacTdVU2FlMFhnNzVrVDl6eUN0UmxN?=
 =?utf-8?B?K3czQXdmZGo0OFRXb2ZMdkpHU3MyYzBVZ21ZbC9rNlB5Ym92blRTN3M2cGhm?=
 =?utf-8?B?VGhobUh3WGF3VUlyWk9uemE2cXlVS0x1VjZtWCtFOXBUamx4UGdvbHVmOEJ5?=
 =?utf-8?Q?LK5Gje7SdbftTmY9BQ0Zowbgj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f9df35-bf42-4680-f2dd-08de314e50ab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 02:55:56.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /E93ztQ+ZmqjDekiRYx3FZawiRaqamzv93BfR1joqUm2+0dD3hp4iBd+lJKdnskoVMFlr7xEzcYniit97KZpTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617



On 12/1/2025 2:13 PM, Samuel Wu wrote:
> Documentation update corresponding to replace the cpu_frequency trace
> event with the policy_frequency trace event.
> 
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com> # amd-pstate
>   Documentation/admin-guide/pm/amd-pstate.rst   | 10 +++++-----
>   Documentation/admin-guide/pm/intel_pstate.rst | 14 +++++++-------
>   Documentation/trace/events-power.rst          |  2 +-
>   3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index e1771f2225d5..e110854ece88 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -503,8 +503,8 @@ Trace Events
>   --------------
>   
>   There are two static trace events that can be used for ``amd-pstate``
> -diagnostics. One of them is the ``cpu_frequency`` trace event generally used
> -by ``CPUFreq``, and the other one is the ``amd_pstate_perf`` trace event
> +diagnostics. One of them is the ``policy_frequency`` trace event generally
> +used by ``CPUFreq``, and the other one is the ``amd_pstate_perf`` trace event
>   specific to ``amd-pstate``.  The following sequence of shell commands can
>   be used to enable them and see their output (if the kernel is
>   configured to support event tracing). ::
> @@ -531,9 +531,9 @@ configured to support event tracing). ::
>             <idle>-0       [003] d.s..  4995.980971: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=3 changed=false fast_switch=true
>             <idle>-0       [011] d.s..  4995.980996: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=11 changed=false fast_switch=true
>   
> -The ``cpu_frequency`` trace event will be triggered either by the ``schedutil`` scaling
> -governor (for the policies it is attached to), or by the ``CPUFreq`` core (for the
> -policies with other scaling governors).
> +The ``policy_frequency`` trace event will be triggered either by the
> +``schedutil`` scaling governor (for the policies it is attached to), or by the
> +``CPUFreq`` core (for the policies with other scaling governors).
>   
>   
>   Tracer Tool
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
> index fde967b0c2e0..274c9208f342 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -822,23 +822,23 @@ Trace Events
>   ------------
>   
>   There are two static trace events that can be used for ``intel_pstate``
> -diagnostics.  One of them is the ``cpu_frequency`` trace event generally used
> -by ``CPUFreq``, and the other one is the ``pstate_sample`` trace event specific
> -to ``intel_pstate``.  Both of them are triggered by ``intel_pstate`` only if
> -it works in the :ref:`active mode <active_mode>`.
> +diagnostics.  One of them is the ``policy_frequency`` trace event generally
> +used by ``CPUFreq``, and the other one is the ``pstate_sample`` trace event
> +specific to ``intel_pstate``.  Both of them are triggered by ``intel_pstate``
> +only if it works in the :ref:`active mode <active_mode>`.
>   
>   The following sequence of shell commands can be used to enable them and see
>   their output (if the kernel is generally configured to support event tracing)::
>   
>    # cd /sys/kernel/tracing/
>    # echo 1 > events/power/pstate_sample/enable
> - # echo 1 > events/power/cpu_frequency/enable
> + # echo 1 > events/power/policy_frequency/enable
>    # cat trace
>    gnome-terminal--4510  [001] ..s.  1177.680733: pstate_sample: core_busy=107 scaled=94 from=26 to=26 mperf=1143818 aperf=1230607 tsc=29838618 freq=2474476
> - cat-5235  [002] ..s.  1177.681723: cpu_frequency: state=2900000 cpu_id=2
> + cat-5235  [002] ..s.  1177.681723: policy_frequency: state=2900000 cpu_id=2 policy_cpus=04
>   
>   If ``intel_pstate`` works in the :ref:`passive mode <passive_mode>`, the
> -``cpu_frequency`` trace event will be triggered either by the ``schedutil``
> +``policy_frequency`` trace event will be triggered either by the ``schedutil``
>   scaling governor (for the policies it is attached to), or by the ``CPUFreq``
>   core (for the policies with other scaling governors).
>   
> diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
> index f45bf11fa88d..f013c74b932f 100644
> --- a/Documentation/trace/events-power.rst
> +++ b/Documentation/trace/events-power.rst
> @@ -26,8 +26,8 @@ cpufreq.
>   ::
>   
>     cpu_idle		"state=%lu cpu_id=%lu"
> -  cpu_frequency		"state=%lu cpu_id=%lu"
>     cpu_frequency_limits	"min=%lu max=%lu cpu_id=%lu"
> +  policy_frequency	"state=%lu cpu_id=%lu policy_cpus=%*pb"
>   
>   A suspend event is used to indicate the system going in and out of the
>   suspend mode:


