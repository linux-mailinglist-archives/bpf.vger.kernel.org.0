Return-Path: <bpf+bounces-64766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C817FB16CB8
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 09:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105EA7B5725
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 07:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0229CB5A;
	Thu, 31 Jul 2025 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnbAiBSU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA629C35C;
	Thu, 31 Jul 2025 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946798; cv=fail; b=AGtQARVumYiPPCHSlNuxQFUrp4swja9k9e6TVUMJz9CQYGwZtcizt2oJ9BhKXLcrN63NVoVd3lXrze9PiERW3YtO4sY1EOy2i+lgCRTmaF7zlnKCG6wmIJ+57/2uLQotqPfU5qElTDThIMGVt0g9PtK/3w08q6ooT+4nGJmgCkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946798; c=relaxed/simple;
	bh=yQssFTrG5M9C4SBUVyfFhE9yYtk1FgIJ4skm7hnzAOI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dqiz73aUJ8yMazMbq5JyqCv4n9tYrg0sG/D+sg2l33U3+pbR5DqHBqmGm8nu4E3tx2RAXeUBOD1caxfjs263tOsmCpESU9ugiSja95vWtFWF5vTfnSvdePwXz7fh6+zF1Mprh0U1Sobqr+KFB1w4XcpkBpDQ7yTWvL5u0lzK2TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnbAiBSU; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753946797; x=1785482797;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=yQssFTrG5M9C4SBUVyfFhE9yYtk1FgIJ4skm7hnzAOI=;
  b=CnbAiBSUfEMQeVEAAzV+8AwtYRdvE/VMQdO4c92tIiDQ2isvIzR0Qtp+
   dsnAse8yT0t/LGJ86ItQO8McAumzlV8YV32I4JE6HBIfNDyXu1MFpyJGm
   6q6s5OqUuiCg+3jZOONy5gcz0KlT12RR7sZzx1qyQGHkgxTgdAkZrzRRR
   nYuH1niRa2yxngJSqnFO8p3lKzPJatnl+bIE6dREXmENryJgZioAVnBk9
   AgbCWTUY00KmFEdwmuX45gZa8uB/qBU4PRKqZdtvKMyvSjbfSymnGOLpe
   mN8oQ8qEgAvbJzLXkP8kl9S3ZDw/fM3T9Kel8+o5fOiCiKaTz4Xk12I/h
   Q==;
X-CSE-ConnectionGUID: J11/xZ9TT6SZJVvGAifDbw==
X-CSE-MsgGUID: xprnlnUWT1uK0rgrBPYGSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56337969"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="56337969"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 00:26:36 -0700
X-CSE-ConnectionGUID: uzAwyhXERh+xgLp7NuW63g==
X-CSE-MsgGUID: 5wU0uanvSBWtmcAdxnXngw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="168588516"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 00:26:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 00:26:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 00:26:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 00:26:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNQg9ziJ2rTxdMlc6YFNoqObeYLlIKr/ka9ghbWfivp4ApbUi1FkweQkFC7h1meRCqddTf6OU0tUmnulxzbEAxD+XW5zSSFZFu/+XImwR2uGCj8x6Sn4qtNGUBVy8x/nB+A4LNgSH5mmYWaK9obnONhAHf38R5HkIpynD3O99KFTdsZRwxKdMHonwEp6vyclyanYSIk11D/tQTmLsK9BhoE88jn0GnV6fwmIc+5pbe0Sl8DxV/PCAaNIMDvhxaLR7hk6qeDilGCVt9uUXGK13vtBxh8eN/KMYIfxvhVGmFki1JlFWltditEYbaYL5X+ibchVFWRkCt399LKsFlJq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ef1Dx0RAUWSDp5PrR9xYuvpYk7zpagNQm91cVgpP+E=;
 b=CZcjARAM86uSKcvMnC/A/NIsT+ib1GzgbgENjH/XLh+gqXZa/EmpbJR/SE1rRkGUSxncVXHW+DF7U7NpxRwWPRQfAX9DbMPknGqfpoQgF1A7r9KVlis5yI//3u9LLWgULSRDgveIAphh6Atcf6KZ3XlcM2wuF/Ut3YB7Y2UYGCl7knSNS5+f3raU61LYWElKs/PopAado7F1XySTJv9OkUQLU5HEle0AGQq6uT21ZwhGDC+giJPVHpKRdI5ZNVivZkodBqDArYpHD8U3JpmNZW6EU39Ql4MOgEDJPnYpZeZn9+RQqgMHkAOJIuRMrlHjYFw84uMhBT+7RBPxfmaxNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BY1PR11MB8055.namprd11.prod.outlook.com (2603:10b6:a03:530::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 07:26:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 07:26:18 +0000
Date: Thu, 31 Jul 2025 15:26:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Leo Yan <leo.yan@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	"Jiri Olsa" <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, KP Singh <kpsingh@kernel.org>, Matt
 Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Yonghong Song
	<yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Steven
 Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, James Clark
	<james.clark@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Mike
 Leach <mike.leach@linaro.org>, <bpf@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Leo Yan <leo.yan@arm.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH RESEND v3 5/6] perf record: Support AUX pause and resume
 with BPF
Message-ID: <202507310818.a05d2380-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250725-perf_aux_pause_resume_bpf_rebase-v3-5-ae21deb49d1a@arm.com>
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BY1PR11MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 8828c5fe-b05d-40c9-de1b-08ddd0038a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LXcwRl+b2UYB76nxumsSTZ/tH8rHALZEgtHLcGNRAR6GhAVBD21At3i0njGf?=
 =?us-ascii?Q?sIMv7f2wuKVyhUJm0POuFBBOtBqcg4bVPuq5iDwkDMlUxPSQMk+dEEJbBRrP?=
 =?us-ascii?Q?0d/u3RmfC3o5jT6p6zFO0RJFO98YZMVRLjD2P+nY4QvxbXSd1sybTU+bFBc0?=
 =?us-ascii?Q?/P0I7lcEygSvdYJbAsS8FdVNc27ND9jXU7xKmXcKp5//x+BFzFPY0gjB4ntc?=
 =?us-ascii?Q?UFAKvsqKJZaJFpFy2+SS9y94MEDUC/Uq94JVskys9XkBh3hMOXTHZMPG4gpe?=
 =?us-ascii?Q?fPub4xvg87D22Xr8FFeosh9t46j7uCPDmB7iJq0x3wT/HtxxRDagDaEBUIEf?=
 =?us-ascii?Q?I6P+rEIwX2cyv1ZBupvfKYAMaGwRnWoeXmP8UYapyZF8Rv5hxxGnc/tpWhF9?=
 =?us-ascii?Q?Zl/vbF/GyTyazuoy2jKCzAw9k/+trZD57YIGERgrK3DGSEj0MN1jqBphrFLB?=
 =?us-ascii?Q?nW/T/a30hlFPRUxqKc04Jhgv3U0DqesKoS7ejueV0wi+7NbrLfvgS1UP7Cjf?=
 =?us-ascii?Q?J8zRmfnmPwzDvfehPxK1Td1hCZPGKu42XED5ZUXPbpjRotM2B3SqCopXcDE7?=
 =?us-ascii?Q?tLKbLY8ThNY+FOGnWGfH981RrbOftksYJydkjhMiuWIDhogDSRZNF/A+LTJR?=
 =?us-ascii?Q?mVQZK+D18351vO1RoNdGOxkCckZED5Ojq0122A7phpFrUK7ak/1FTcP8B5dw?=
 =?us-ascii?Q?V9Pjjdj/PyKSiOZ+U6uv32HtI5r/QFXUB47lSjpwhVTD25NoRxDw83PTNkUs?=
 =?us-ascii?Q?Pg9zdiW5FErZCdecpYX6PXx6Gkjx2aSDUym9EhwlaJZjCbdSSF8YXGtTknfv?=
 =?us-ascii?Q?s8blZ5n88QDVZCT8HI3e+82TIcBXOfubKq4niPygCJOrQprMGZP+3zitCbHh?=
 =?us-ascii?Q?y/zKylYUnwdDpon0/t81aV1aBbVPjEbaUFAu9Zzr+b2wBgGLy2k7ndNXODy0?=
 =?us-ascii?Q?i4wbgFlqOu78dB8lYVPsKV/OKm7p/FiQw0KayCjtupYgn+tu2swomSglM3Dq?=
 =?us-ascii?Q?8fMHabVmSaDxhX13mS5TTCIOQw10ffLVps5B63WCWGhRCbVPIrt/L8qX2Ydb?=
 =?us-ascii?Q?CnDoZaog66nQ109VJCtfVWyKLn2FTKZWfyvokbML2lJ7d8KyS30tcHnJifWz?=
 =?us-ascii?Q?06DSrGVIQbhPS7hWNC74qsq6H794Y5QIB92fIj5x9GXPQrlckAwMe8UK8gTF?=
 =?us-ascii?Q?nBersDORLw2wmtLazErn2dhTS4+97QlviCrrFvuSMNZ5+qu7wBgc/l77ITJ6?=
 =?us-ascii?Q?ledIt6mDdyZGO5daDngCd15RsMcOmi/XYP1qGhc3kfQBE4Kxpq9RXnZcT0BB?=
 =?us-ascii?Q?067+xlYaU6xH+fPo25caCt+ynPQeinCRBdexzLRowcyhUczSVzFb4AflSGwX?=
 =?us-ascii?Q?NyuY5hDlKsN9x0MifyN+Nr+LuEOb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6eeo+S/3bO2+ejViZK0PN7NdXmqKi28jfzEM/SSeH/wwArbZfU6YdcgytrP/?=
 =?us-ascii?Q?rjPLpdbgsH2cEMhttmxs20InN2pWMnagzYCoe5wQFkFjtXTVtRoK8pEAfnWU?=
 =?us-ascii?Q?3nMeC1AGs+CoHDK1jzdnICQCqx4iH++X1CNikFefEDhOWb1gWrrq/6GxcPbJ?=
 =?us-ascii?Q?y52HdtFRo92mRtqQ11EmxGIvDksZNJM35p+pq7e6litm+QgOmzVGMiQGmhJ9?=
 =?us-ascii?Q?8umpFkLd3BWmsawuErAPfh3X43Qbvn+eRjIfclllBlL2RGn3XKvufjbMyrg8?=
 =?us-ascii?Q?fHRwFuGB0e0xQYIkRI2C9/Ba+olmArFVE2B0F4G3N9tZSJff7VOavJJ+xHB+?=
 =?us-ascii?Q?y0kPJNdU1bW1C5nBHMP6P7G36SUF3BYCjAscMXzq/hH24/7i/RJIXtmQTx/K?=
 =?us-ascii?Q?9p5ithZP6lXShUldSef5qse+hCladc4XGo7GcQnt9UZ+f1I4vDIHcwhOvNvr?=
 =?us-ascii?Q?9lyo+ZI+ZvvRqAHMlBdErCONzVJjCOD6SpDZv4ViGg5QSHH1xfsdhnOrJ77z?=
 =?us-ascii?Q?RlxDniW0VucNiRoZ1V3xSjPChEsqnxx3lLAsA0orubf//pAyZx3e5M3W8l2k?=
 =?us-ascii?Q?9hU/ewhAOgUGzpDTUOWf+PBtSf5kSFW2+Z4dVJRs7I0nW45m4ak4HjbRE8gr?=
 =?us-ascii?Q?Lf10ElxaNPoaQVlju9Be/uJmqTYSIbakiAD/bBJCHB5PnwuEMfiTr1O8YghL?=
 =?us-ascii?Q?NuDSV68Vya20GHLWtG6LNiX9fAh5/BjcyvTHFQGrvRaKaIVXTDexqZ9sme17?=
 =?us-ascii?Q?kkNA60DBoeGyobGjXqrlnMHcMfg6M0MlSJlZz6itluv+sAa+myW/x0DoL8zj?=
 =?us-ascii?Q?oUCxyjWCd5hH0t2P4k0JYfjx+TPmB6M2aCovghp96rjd7+xuLr5IdOj6HI4M?=
 =?us-ascii?Q?wGiTARm2+CKOBZZIEmMJvh7h+5OgQj/YQe0RpVAyzUHcfYoYWbu0kMcTNmte?=
 =?us-ascii?Q?5KE6zP7QpktYq++Ox1/jGaJ8jwvSW2tnDVvkdnrex6wt6KffM+JND6q+cwu4?=
 =?us-ascii?Q?JOSgO9FKSOzOdhrSpj014XfhzaPz1fv0iLXbALKzuzlm+8AedILcY5L+/+T5?=
 =?us-ascii?Q?OQWIJ3x1wFOCKYL8cDOyA5t2nqVqS6iepOn+GktNKkknzpMqTl3wYWwe0w6s?=
 =?us-ascii?Q?IJAMsvC0Qx8bAEPy10OEXt8Wi1obuUa0blD0zowjvaJkhS6w7wvBqhZPBS6m?=
 =?us-ascii?Q?F4mFPhfqh8hC2HYxJT9xvts/2yANQvigEYSarX2Y1mSi7YLmkIBXou7QXF9U?=
 =?us-ascii?Q?jhegpPqKajoIerKMdI6wf93a4LlnWx8+w4qC5mOr5bgWPSKFoMDsnmd2vCvm?=
 =?us-ascii?Q?7RRvv/St+TwUKiU7j4Qtg/ef6GUGmtlmUxsqfNCzzHmoRNJny9SiqtJZBxFI?=
 =?us-ascii?Q?UUMjSpsFBoNSSVa6imbHEQ0VY9w6NaoC9dJ0iFAbqPNwf1zCTfJ4BV9M+sVR?=
 =?us-ascii?Q?kZQIzQvvseZahBBAcOXCRuNm6RDk8t+OxYpyAIZGuolG/9c7SFfj7oUe4ZoA?=
 =?us-ascii?Q?3GdslZCW2lhD6n++MYNfURndROztfgmaiukbsPK+eOa9thok0UGZANybyCRp?=
 =?us-ascii?Q?7SbWiFt98F6Psc9AF4E0F9hMQ7iJ9pLr27OxauKKiTOwIPP1zI5rP4I7w3U9?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8828c5fe-b05d-40c9-de1b-08ddd0038a58
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:26:18.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsUn+bxINBNNgxwqwCIKfqEosfmRt5TcCQbZ2sDWMdwzu5i/cmzwEw76GAY9fufkj6ZLhYoIXJCiagAQv1A4Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8055
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.Convert_perf_time_to_TSC.Perf_time_to_TSC.fail" on:

commit: e350af63969b875598f0656a20d801bbcaa7bd76 ("[PATCH RESEND v3 5/6] perf record: Support AUX pause and resume with BPF")
url: https://github.com/intel-lab-lkp/linux/commits/Leo-Yan/perf-core-Make-perf_event_aux_pause-as-external-function/20250725-181647
patch link: https://lore.kernel.org/all/20250725-perf_aux_pause_resume_bpf_rebase-v3-5-ae21deb49d1a@arm.com/
patch subject: [PATCH RESEND v3 5/6] perf record: Support AUX pause and resume with BPF

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-01



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake-E) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


besides, we also noticed other tests failed which can pass on parent:

90bef873a01451e8 e350af63969b875598f0656a20d
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :5           83%           5:5     perf-sanity-tests.Convert_perf_time_to_TSC.Perf_time_to_TSC.fail
           :5           83%           5:5     perf-sanity-tests.Zstd_perf.data_compression/decompression.fail
           :5           83%           5:5     perf-sanity-tests.build_id_cache_operations.fail
           :5           83%           5:5     perf-sanity-tests.daemon_operations.fail
           :5           83%           5:5     perf-sanity-tests.perf_all_metricgroups_test.fail
           :5           83%           5:5     perf-sanity-tests.perf_diff_tests.fail
           :5           83%           5:5     perf-sanity-tests.perf_stat_JSON_output_linter.fail
           :5           83%           5:5     perf-sanity-tests.perf_stat_STD_output_linter.fail



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507310818.a05d2380-lkp@intel.com



2025-07-30 19:06:25 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-e350af63969b875598f0656a20d801bbcaa7bd76/tools/perf/perf test 64 -v
 64: Convert perf time to TSC                                        :
 64.1: TSC support                                                   : Running (2 active)
 64.1: TSC support                                                   : Ok
--- start ---
test child forked, pid 7359
Using CPUID GenuineIntel-6-9E-D
evlist__open() failed
---- end(-1) ----
 64.2: Perf time to TSC                                              : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250731/202507310818.a05d2380-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


