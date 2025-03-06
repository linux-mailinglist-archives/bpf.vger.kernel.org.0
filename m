Return-Path: <bpf+bounces-53455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506CAA542BE
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 07:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E2E18935D9
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 06:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD71A23A8;
	Thu,  6 Mar 2025 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmtxUNzy"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90719ABDE;
	Thu,  6 Mar 2025 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242317; cv=fail; b=QP5bjWdh2dqVTX3TsVDanBFrvX3jQuA335ceksfU9KTBk//AIvE4IHBcYQjDOuv+kHDZF4qBjzWxZQRjCnuMnR9MkIw2Bssq9wS/5aOSQ9L4a90UibtlxGmV7jX/yCYez9mWFnfAntU4C/rMRvSvLtT2jnTZZXbomMS91LbbTnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242317; c=relaxed/simple;
	bh=d1NOh38XztVkds+D8WH0BVQj1sv21Ju2CKuDfxacRH4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OHQZMrs97T9+el6SVIxklQoyvARncq5xLAh3cuCS9zmI3fDESsNskC5bSzfaMaHqBlaX3msMrNqPM0RfaVQC8pewEar+aI0LVoo0hXr6xOowQ5CBBnFHeFJ9IoubCwxxoClPY75m0x7qGP/HXvrCtTmmL0IZlVDR8O0XpuE2CQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmtxUNzy; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741242316; x=1772778316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d1NOh38XztVkds+D8WH0BVQj1sv21Ju2CKuDfxacRH4=;
  b=nmtxUNzyr9iJbDcu0+c8wWHoKy6kgwm88ryeGd2H0UVZ9FQdHYsxKzRf
   u/UmlyzVtz6yD6A/GH100nZtKrMQGOct26C+uscr8GBcjFvmEfjVUgcC8
   2iSA9iiGSCJTgmgoCXZn/e4udpJOnxvA/U9GFSQwIO4FitLM4SFwZAb/R
   gcuLOFfNXaFDcglO2Y2+vwh85yI67Xc+dE5/J+p6NiIePNRXR0vbmtpGq
   2BHiYMNmehbo+/qPFNpTIzAGVdZxwbsj7V3SDcZM94lHdXBxJQs8iwsfJ
   DwveJy+6BQCpM2D/ghNkPKF1VkUgkiGa9NElvo0Js+0oNgttPYIrVaUHl
   Q==;
X-CSE-ConnectionGUID: on4lkHKyRU26SbQAiosPIg==
X-CSE-MsgGUID: Z+X+mt3UTpOA7fIT+RLi6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52444651"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="52444651"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 22:25:15 -0800
X-CSE-ConnectionGUID: Q9guN+a1Q0in9b7G6x00aQ==
X-CSE-MsgGUID: FV1RJwVHTwKQyLdKVj8KcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="124015602"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 22:25:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 22:25:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 22:25:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 22:25:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUYyfzossU2ECiWtD61YdeJhDFOTSCVP9+l96tw4LXYNWN6rd2aKMhTuFSzJbjfvslyIKuRb7jb6DGiPXdwy0Pla6S1iTnC0lROMT8SmweOQBoyI29IgSz9CdOZVg8EnvgV/0deDf0uEE80MKbXzv3EpYvi3rXSQu/gqv1K41UJHNAsyCCscKhM1n+ru59gVMn49EfUDcWCIP3TCfusmg9iivZe6ZUqYB1dgtQzYPCqUj3EMqqYt7Ii4kXdJdSZmFPqn0ikVvHEblWpPpHJU6lDCbPP82LqZMfhdImSMQM4Gewbh+K/iB40NUKaNIU6xpLYPKwmu4DBhtf1BF4G0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDsNXr4YsSajnhDI49f3Ku+z6yHyXe1FzrwvzJWgIJc=;
 b=KAUPKuOUJ+u7MEyyTRtYR76c/xrx77iQPgew4aLJ6YUt7mwnw5D/PVM4hNVzy1P1NwhUEgpHHhxW8jsfmRNn8ur+c7SyGPY9IGhZWHdfTV/Q8BOkviZwSGw6leGopbNJzTbRF+3qL4nWF1Bwf5e5m80CYQ5YTlwKLa2ueIbhK+LPBZ3+Tj1UZ9HxPOpweQQnKl4b/v/BQ8KR8ayzAWjDR4JexZqBrwlXrx0y+8shMJSSIqAugc2ATtKTCfHKO8GalxdhkiJf8OBhno3UgFfHp4tDOaAkjBVqkIcJSm9RieQhUHvc6uKwG/koATNXQqfd7WweOW8H03yD+RckfH8b5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 06:25:11 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 06:25:10 +0000
Message-ID: <d962792a-c852-494b-b35c-e8f83cac7218@intel.com>
Date: Thu, 6 Mar 2025 08:25:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf report: Do not process non-JIT BPF ksymbol events
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang
	<kan.liang@linux.intel.com>
CC: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>, Kevin Nomura
	<nomurak@google.com>, Song Liu <song@kernel.org>
References: <20250305232838.128692-1-namhyung@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250305232838.128692-1-namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::9) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|IA1PR11MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9f6cc7-b734-4b35-60c7-08dd5c77a47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDhLMk1EVHg3SnVxYThwcVN1L3FBK2ZRbDB2bmxGRDFIZVJuU1ZLNStwMWY5?=
 =?utf-8?B?RVV0MWhJUHdhNjRmWnlwQTNGODZkaWFBd01KSWs5TzJlbUlMZ2l6ZlJDaWl1?=
 =?utf-8?B?a1FWdzB5bkFMVU5uT0JReGIrSVB2ME9uSzBxbjNVcEphK3kybmdBYmNEL3lq?=
 =?utf-8?B?Y1NrZjdMMzFyVks3YWFhbDMvQTNGU01pcE51NVRkc01wYzZHK2NFbldzYklT?=
 =?utf-8?B?K29jUjdyVUNWWnRPQThZaTcwOGdaeXgya0ViS2cwdVczbE94aTJzd051L1Bo?=
 =?utf-8?B?T2pRbWs5enJGRHN3aEw1TXN5cTlCTWZWWnUrdnNXYjk3QTdjNnVJQ1ltTXlV?=
 =?utf-8?B?ZXYwZ3oyVmFNZ21RVGxMWVRsVUU2SEg2aTZHaFR5K1BMWEdVbEMrNHRBamV2?=
 =?utf-8?B?MytZTjZuS0tSZHgzeW9PSDBVWjE5Zk9NNnluUmZUWTVqbDN4dzIvR1IrWFJP?=
 =?utf-8?B?Q0RFV2I0bmdkaVNLY3hlUkxhVndYbzdCaDVxK3J6YWpWcFR5VklNSjBzTlNL?=
 =?utf-8?B?cXlmQTY1L2ZUS0NDUWZrK2RZRkxyajY4RWxzaGtJcEx5c05oUHR1M2xCOEZa?=
 =?utf-8?B?TFhjRmQ0OElkemx2bDhlOEdGRzBZSkNRbC9XelUzTEZveFJrdTFpaUtqRTJk?=
 =?utf-8?B?RlBONjhBd1lDM2V2NUwrZ0Jla0hvZzhmeWtUUVltTzBNRDArY1pvNmZtSGVv?=
 =?utf-8?B?bDNSMTZXaklFWGl4ZHJYdUwwRHlKRlI1WjNyRzNwenBtUk5BTXN3T3FqbTBv?=
 =?utf-8?B?aG5FV0RvdTY2c2pVR1ZLRGpLeEVreWtvUFQzSmpsRXZ3M3M1K25HcThzRndq?=
 =?utf-8?B?eHB1Q3g4ak82M2hBSk15NkkyQkU0WHA1WnZkcmlRbktBeUErQTJIQTBZaXE2?=
 =?utf-8?B?Yy9UckxrOTZYVnRrZElzTGt6SmpPQmJsbXgwUlA4K0hXOE4xbFppT2piN0NV?=
 =?utf-8?B?NjRsUjM4bVk2b0xSTDdRMk9UMWJNVXpXSmhCcWtsM2F0WU1POXh0OUtjZzli?=
 =?utf-8?B?TEdDMVVwZVZsZTMyalB2aGNTWUErMktaMFhlMVFpRG9DbjUwTlgyRFdtVnlH?=
 =?utf-8?B?N0NITEpabU9zb1ViM3Y5Y3lpdEc5dk1nUTRaUkdtUVc0a1p4QUJPTFhNcDlP?=
 =?utf-8?B?UFRvN0FRSm11ZmhuUGVDZkQ3WE9ZTE5QbHIrNjRxcXpFaGpqSmdCb3pLQkpz?=
 =?utf-8?B?WlNxSTFzOU9XQngxTFJzMzR3cWg1N3FNU2VLUHZaV25PaGZqb1F3T0RweUJx?=
 =?utf-8?B?eG1rNWtEeUprTS81L2o4NWJyRkNnRkRjR2dnMnQ2cFB5OXExeXk4T0NvcHoy?=
 =?utf-8?B?K2xUZ3BwY3hiL1g3TDdNNnBxUlpVb0hNc2R2MGdLYktxcWJ4aHZ5YzJDZjFv?=
 =?utf-8?B?R3pobjJPM0ZPdDd0NmlkQWs0bG42Z2d5UlJVMS9Ec1o0cXlCeU1IZnUxdlNO?=
 =?utf-8?B?VHI0WWozdGljUTFaYTlRU0ppWmRSbDlUME43eXVGektvMnVYcUg3UkIybHox?=
 =?utf-8?B?NjlkTU12THR5SmNIa3NjSkJ6YURnSjhqdmFwVU5VdUxHT0QzKzQzQU9RQWZZ?=
 =?utf-8?B?K0lqeFp0UXFJemxNeGUwaFBwVTJDTGdqclQ0MEpUTUJLdnpkb3gwbm1GUnFa?=
 =?utf-8?B?Y0QvOS9YbmhBNS9YT2N1RFZMdGZXMVBXaFJtR3Zsa3lYUzhManBCR0FFZ25r?=
 =?utf-8?B?UnVPUFlyYkdJQ2FPbFlXN1cwRGk4R0dtZnVoTXIrN1RDZGNYZDRoaU9kUmpS?=
 =?utf-8?B?NFdRZzJsbmFrU1J3MytEbDVIQUoxUjlnc3JlNHpwOG1tYzA3QzIxZHE3YVV3?=
 =?utf-8?B?bUFXOWd1SDZBWmQwUFdkTFZVeGNieUdOTUhHTDNiNlR1RlV5YjlEUjYyWkcv?=
 =?utf-8?Q?FdIN/r39i7roi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDFDYmF1Wk1Lek1jOG5ZcFRaaW1rdzVoUENMcG1pZEVDajlVbDQ3aHRuTnlx?=
 =?utf-8?B?cTZBclkrRkU4Yzc1ZEpzL0tyb2NFZ3VWY2YvZk9zbUgzVS8xZUtIN2xiVnE0?=
 =?utf-8?B?Y2hsWWR6SjVFbEpUWXJrMW1JVlEzN3lrbFdzaW1zek9ZSk1KMVdnM2FxUXc2?=
 =?utf-8?B?VGpVdkhuL1NxbW1YeVZPa013aDNKVkI4bHMxMjVqdnZUSTRFb2plZzVZai9t?=
 =?utf-8?B?VjFtUmxJNkxtKzlzSlRPN3JFUm94eWxHYzYvaTV0SUo2cmtCLzdXUkFoR2ho?=
 =?utf-8?B?ZHNBRnF5bG5wd1ZMK0FyRHlKVFlLRmJJT3VUUnhCNllURWppcVJwNWJOVjZt?=
 =?utf-8?B?ZzJDUkVJcFdaa29LVmYzYlE2WGtxekVBTHREUmNRRDJBcmVLNnorWmR0eTc2?=
 =?utf-8?B?U24wbVA3TzAxOEdxM1J2ZWZuWWx0UTI4a0pDbGh0S3QwTCsxUzgrZXBKMC9h?=
 =?utf-8?B?THBUTG5qRzFFOC9RNmJzS2s2QmxSdHZKWHBSSXQwVUFsNFRHOTIvSEE1SWoy?=
 =?utf-8?B?Q2tkVEc5bXE2MUdKR3AwTmIzRHAvWldqaklPdE9aLzBiTnRqTDlWSU1FT3pN?=
 =?utf-8?B?WW80eENxOEV2MlI5S0w3Y0VoQVY4NmhzUGFnVGNWMTd4UUtzM1ZRMHpJYWxs?=
 =?utf-8?B?UThEWTBWZUxUcjlOQ01tUjllbWhuWEVxQ2w0RG1TQ0tvbGpoNDUxQmtCdFJu?=
 =?utf-8?B?N3lxRnJDUExtL0cxNEpxSnpyM1ZpQis3aFladjhzS3IrdWpNbUUzUUxNUU1r?=
 =?utf-8?B?a3FBRk9DTXdUWDdhbEMrd3lidXo2YWQzbWl3Wkhnd1hiS2ZMOEhET1pnTlJC?=
 =?utf-8?B?eWpxSnl3ajl0dWFYS045aEpHL05BVnF4NHFOeXNPUmFBSlFiQmtxdnpJQnRY?=
 =?utf-8?B?MThsSXdWeVBaTDFxTFBRa1lsS1FiWE8xUG56WDBza01HOUdXbmU1UnI3bWRC?=
 =?utf-8?B?S0pwZ2EwdzZVUjlPbytsWXEwdEx3NlNWQlFlM1IwN3VQMHV1aWhpNDZHU3lG?=
 =?utf-8?B?Ri81Q0ZEZEFzM3VucE1GTStMbDBCRTIvdEJvUFhyaVFyUStZV2dBZVRWSnpL?=
 =?utf-8?B?Rnc1MTJzcUMyMnJ2Mk16Vyt6cDdud283dWo1Sk8vMTJQNlhLUnRWOUg3elNC?=
 =?utf-8?B?TnQxdVNCODh5RzhkWkcwUFZ1UE9rcE1FeTRqRS95N1JsYjhKbldvR2hySng5?=
 =?utf-8?B?cElRc09PQUUyRitsWG9LYUtmN2VvSklOdE5lbGM5QS9xTExXajh6c3NGQ1dy?=
 =?utf-8?B?NUNQWjRGRW1MU3ZKd2c1ZlRZSWdmc3duQ1JBTTlOUUQ1NFpHcWpXMFVkVExX?=
 =?utf-8?B?Ykd4ditYbTM2b01OMHZrb215S1hvbWFkOFlkVHlTOWZTbHcxc05DU3c4WWxT?=
 =?utf-8?B?ZEEyM3ZOUVhTNFhWaW10Y1YyVUx6RlRsSlFYMkQ0eGM5cUJScXFTNnZPVTR3?=
 =?utf-8?B?M21uK2FaUERsYU12TXRXZkNQSkRSSE1PQzRuYWJxbTlZc0J1QVQ4SitnOGor?=
 =?utf-8?B?MmY5a0pHNEZ1NDVaamVZbGVjcDBvWlpQVlBnOUFkNG4yMmZINXVlNFBGMjVQ?=
 =?utf-8?B?N1k1b3dzZEdoYk04c1ZzZitiSVRndFRSdDJIWUxGUFJYTldpU0twNW5yNFJi?=
 =?utf-8?B?emM2QTJPclFDYytiV0M2bFgrUUlmT1JqUVJaM2xtWTVrVnJFSDJVUHp4VlI0?=
 =?utf-8?B?ZDlWMnN2amgvQlBMNmlGWGZnOEJGVkl6Y0tTRnRJN1c3V2F4dHYvMmJmQ2hx?=
 =?utf-8?B?MlN0anhiWXhMYXVFS2wzL0hKaVhNT1ZkTjQxVllrN1VHODlPR0lrTWE4R1NM?=
 =?utf-8?B?eHRlUDJ3K2UxR21NWFBpZkVBcFZsOS96b3JFMzJoZW1PNk9PMXJhL3NGa1NX?=
 =?utf-8?B?SEhVUmh4R0xpeWxHV0pUbE1wb09Eb3cxQjNuZVFNL3k1Znd1RzRSU0ZsWlhB?=
 =?utf-8?B?Vk5DYjgrcnk4RzNRcm1xYUIzRUNXTS9WNExMMWVuc3NDcGFGUEdLSzFjU0Ur?=
 =?utf-8?B?dFhRYy9ZbUZVaTJ3OGdpbjRZV2JSVVRlRkNYcWFobEVPc3BKQ0Y0TTJHRkJs?=
 =?utf-8?B?aUhyYkFaVUxWSm1iNGJaTGl5YkVUeWNZcmxDd1F2MlZEWDhIMElHWHM5eEFi?=
 =?utf-8?B?bUozTjc4R0NOS1gvSUk3VW1UMnZQb25JS1Q3NE9oU0xjSUpHYlFsOS9INUhw?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9f6cc7-b734-4b35-60c7-08dd5c77a47d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:25:10.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpdCnKh8Zu4/4PTPhQz8UKbMUayrbVvcDSo2r5YEAnWHMWF8Shd8iJLUqQ6nEV42tq8dhLqEuaztJHkbXLsDUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
X-OriginatorOrg: intel.com

On 6/03/25 01:28, Namhyung Kim wrote:
> The length of PERF_RECORD_KSYMBOL for BPF is a size of JITed code so
> it'd be 0 when it's not JITed.  The ksymbol is needed to symbolize the
> code when it gets samples in the region but non-JITed code cannot get
> samples.  Thus it'd be ok to ignore them.
> 
> Actually it caused a performance issue in the perf tools on old ARM
> kernels where it can refuse to JIT some BPF codes.  It ended up
> splitting the existing kernel map (kallsyms).  And later lookup for a
> kernel symbol would create a new kernel map from kallsyms and then
> split it again and again. :(
> 
> Probably there's a bug in the kernel map/symbol handling in perf tools.
> But I think we need to fix this anyway.
> 
> Reported-by: Kevin Nomura <nomurak@google.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/machine.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3f1faf94198dbe56..c7d27384f0736408 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -779,6 +779,10 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
>  	if (dump_trace)
>  		perf_event__fprintf_ksymbol(event, stdout);
>  
> +	/* no need to process non-JIT BPF as it cannot get samples */
> +	if (event->ksymbol.len == 0)
> +		return 0;

Are all ksymbol events BPF?  Maybe it is OK
for PERF_RECORD_KSYMBOL_TYPE_OOL also.  Perhaps adjust the
comment in that case.

> +
>  	if (event->ksymbol.flags & PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER)
>  		return machine__process_ksymbol_unregister(machine, event,
>  							   sample);


