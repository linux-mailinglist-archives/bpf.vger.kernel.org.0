Return-Path: <bpf+bounces-53458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CFBA54311
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 07:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B60C7A1780
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 06:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B95C1A2547;
	Thu,  6 Mar 2025 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVoHCkmV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAACD19C556;
	Thu,  6 Mar 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243743; cv=fail; b=QKBSVudW00jEa6oo47aWyUUEjdHjMdjkmIn4pmT5HNdYh+Xmm5yAQv/Y1kcVEEFlSNzEa1aCBx9f+luaMfbk9vI03GTlHerjQ8UuNGcb9bdU6MYlWllVAYv8YH5kZmnHYWG/SlRdSasGZoiAvO1kG2BN034XuIxKj5yGR7ZU39M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243743; c=relaxed/simple;
	bh=2yOWv1pVpSK37QKMmjvCwVrYKlT9+oxEGx2uaBznBdA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BqEIQmm/TzAHM5fFOO6qY7178a6mTVmQm9REAEndpBQjhcRwXsq0gzhcVVw8EOIx7CCBZbrUcPrJYTaq2Yw8R32jH2FlTLRBpy6FvPLh7//2NrqWYvjJWAUHc7OjJOp2JMdNttsYxWPI84YCVbiqx0qJGxw2cOjK04zgmN+v0Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVoHCkmV; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741243742; x=1772779742;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2yOWv1pVpSK37QKMmjvCwVrYKlT9+oxEGx2uaBznBdA=;
  b=dVoHCkmVG4jLpus96p22HoHXlOUJAoceqA5Obdm1pKcUPak0OD6dxuGU
   lzrdhnseCLslFjiiqa+zIL6QuViHeGH5d30Lcayk7R1171f+5TeryRG4K
   l/cWoEc37InuFWiHjMXgv6v3eSm92UwW1yrUMI+DTeOJTPDDCPVqIescj
   U9C/tN16Y55ODL1OFrUMf9DP2v4EagLkZufGEmNAWI0BUqCCQLCMrThn0
   +ZUXoeNx847jZ/3KxOxt9CiTzO8hq/0KkxvZmcj4t53/JE7Kc3s7KF3ot
   K9bQXh4hkokDRb7by6Y0YFFJPmbTaGDG1pGbCbiGcVPecT3O4DZEENkL1
   w==;
X-CSE-ConnectionGUID: H4WVWoplSFeBgtBqImuJtg==
X-CSE-MsgGUID: r0FqdV1ATkSyHQHrerNnfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59785371"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="59785371"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 22:49:01 -0800
X-CSE-ConnectionGUID: RjI/5xjqROOupKKPKgk56g==
X-CSE-MsgGUID: nvrx49AeSr+n416zoZIeWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="142150198"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 22:49:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 22:48:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 22:48:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 22:48:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXCWCFcQaCJ8VSFrYeiuTvo9ipIJo0mk8HylwelbMNmbpftY9TCFqOWu5FOusVir+6Sop8JxqgEqlzoV8LO/lhp4fn54ai0aT0OKUt2uJqj040GPBOCzp/YMYoyieI3+NkKsaSDyw3yVwOIgeJJ1Ztv4aSjFvRWNZKaskegiM2diOTMcDu97ZOYI+pKq080bfeBoiIV5d2vg/0rnnsnUgIVWbXVBtH8m0gInNwTWO+uLJnGWr44aM42hd7P4HPNltynoRrxqMhJf9Fp13o86/EGdBSRC6w3kj38bSq5ToC4GTPUrWb6hWAtR9PnhJqIucZxJm+RW6rTLnuwsgcIf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vff/GBkwRnwcMzz9kcf9p46ZwHhDb8xh8Zw+DRsW7oU=;
 b=xh8rbbf/w/ZoDzIUwcHkwBpxur0LsYOcx6TVF5ZR5t34yjti/I6n+/Dmm+9cGEA/4J9aWRyMtidQQ+S+SSazHVE4or76W3dg8XEfW4BglL43drb+frHrAczzCyArIYzb76w2nzmyTqGg8qKfwIZLFUS5eEGMEDiagLs3SiyfBoqd/YuSuH3yMHP9i1hRE15ynuJjhlDC6PpASp9eM+Qk1FQJhuXA0cAoMduF6QL6nwNy1m9KhvvbaxWyRlwu7qZT66YOB1n7niABnkBeIxWZAHfnhvquEgHm8bBzZbm5+3kOlB1wFM/usEp1V+5KHb9/PCw/FmAMK0HDewQi4MJd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by MN2PR11MB4549.namprd11.prod.outlook.com (2603:10b6:208:26d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 06:48:30 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 06:48:29 +0000
Message-ID: <bb2b30a1-8ce3-4565-b17a-27148234c10b@intel.com>
Date: Thu, 6 Mar 2025 08:48:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf report: Do not process non-JIT BPF ksymbol events
To: Namhyung Kim <namhyung@kernel.org>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
	<irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>, Kevin Nomura
	<nomurak@google.com>, Song Liu <song@kernel.org>
References: <20250305232838.128692-1-namhyung@kernel.org>
 <d962792a-c852-494b-b35c-e8f83cac7218@intel.com>
 <Z8lEdWxt8CKepTJ3@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Z8lEdWxt8CKepTJ3@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0057.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::46) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|MN2PR11MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: 269efe60-3582-4e09-3982-08dd5c7ae760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azNPVXZUb0dZWmt0UUNBclB3MUxmSW5qZ3YzWDc0VHZQSEZaRi81QVBDOVcx?=
 =?utf-8?B?MFVQZk5Ic2VaL04zWEdEdktFNXlPQ2pvS2gxNXlWTkoyM0hFOU5RcWdLOFpR?=
 =?utf-8?B?MFkySUhpcTFqZ29iRHRCRjVJR3BGY2VJRUwyR0g5SzIxeWQ1cEZwWkhpVkxi?=
 =?utf-8?B?Mjh4TnlibGlLaG94YTRQWjJHWXVhdFdzYmdVRWRHd05maGxSWkVqbTZSUlg1?=
 =?utf-8?B?RVRmcDF3YmNCTWFoamJUdkE2dmFjKy9kQVNPdWsrMzVFOGVDOWNrcFRENEFT?=
 =?utf-8?B?bngrSFJGaC9YMnByZlJKM0l2R3FTSm91bXpvUkEvYmhjMXhuRkgzM3lJV2hu?=
 =?utf-8?B?OVZoTkUrYWZna2RoUzJLMzU0djYwZDM4aTJvalFDRE5oOU1SaEh6bkN2a1FB?=
 =?utf-8?B?UW1Lb0VXNXZDREV1UlZJWHVNQ2hOSStDLzJJeVhjbi85cTUvNTE3QWsxL0xW?=
 =?utf-8?B?ckJwQ3JUVUJmNmlob0NabFJSVWVhcmhBc0lESjhlYlNmSFhGRDNWYlJ0MGsw?=
 =?utf-8?B?VllvcGtOMVEreEVJZHdXZXAxTUJEdDFvYXJ3MXVjZnUyR3lNbWtsZzFibzZs?=
 =?utf-8?B?Q2dGTE1aY1d5azhSZGdvQlZJOGNkN1hjMHpyMGxhaldvMm9MQTZrY2YrMi9Q?=
 =?utf-8?B?U0hkcUdMTExsRE5XSk55RmYwZkU5K3g2RjRZY2o2L0hTUWMrZExUaGttcENB?=
 =?utf-8?B?NTBmbmVMNTlWVDZGM3FwUm0vVWp3eHRaMGRTUCthWGdueDJZQkl5MEx1cWht?=
 =?utf-8?B?MkxZN1BjK3M2ZHg2NEhOTmJiV1krL3UxcnFCWk55c2dkUWVNaHpaWk51V09Y?=
 =?utf-8?B?dnNKTS9nclRnbG1BNTlFUEFlb2lPeFJKUnE5NElCSnNzdFozUWJFZ29wYUVi?=
 =?utf-8?B?QW5HKzkrOWROOWJTYzRGd0dobEdDR25rZ1NwNTlGMXljTnNwZVc3akc0em8y?=
 =?utf-8?B?dzZIOHBhUUorZTlFYkYvamxiRjF4UTRvdnFwdWdEekYxT2NQL21uRHJoQXBp?=
 =?utf-8?B?NFpVbnc0V2xIMkdXODRQWVVVdmo1ZlJ6WEJXSGdaOFU1STVvejlCNjRaUTFz?=
 =?utf-8?B?VHkvMEttTlo4ems0WitwZ1BteE1RRzh0Q0ZDdnlSMmNUL3RjZkdqOFA4VlRC?=
 =?utf-8?B?UUk2UGlORlBGZit1L3pKTjg0VkxQdGNUS0M0OUVwaStnb3dMQ00xRzVYQXM5?=
 =?utf-8?B?WFBZU05CdFlNRndTRWRWVnRXaEJSWWhlMzNNVThxU0lrYUNQSzh3TmhiTU5J?=
 =?utf-8?B?NTB6aGdPTWlFVnMvV1MzZENuWWtYeUx1clkybVpiNE9BS2xJTGxqdVd3R2xI?=
 =?utf-8?B?bnhVRzd1a3NCYVN4M1BSSnozMUJBSUZBanVBQ3U2c2I2bUNLb0FVdnRRVGZO?=
 =?utf-8?B?L2RsMmdzaGxRc0xtSzNURjc2QzJpOTZ6OG1mc0tsNnRrVmdlMG1IVWRUNFFQ?=
 =?utf-8?B?ZDhZa1RNU2t1U2JwdTVqREJxcllVK1BJaTBqdm81SXRqejA2YnZ3QThHL1NU?=
 =?utf-8?B?Q3A4cy9ONnV3Z2Y5Q1JPc0RFb0hiT3NSSVl4cTNsT2JzUnRjNGxJVlpDdVVL?=
 =?utf-8?B?MjN4eFdXbUl4S0VmNSs5WWt6Zy80MmhvSUl1VFNqWkg2NHpyN0RlcTlKNUNj?=
 =?utf-8?B?K2Y4a2FuejRpQVdCOERWajlSUEpFTHcxL0dzcTNsNDlqZGZnei94czBISGlo?=
 =?utf-8?B?Vm9HZy9aSWZ5aFViSGg5MVc4VzBkYzVEOWpkVVlzK2F0RlB0cDNqOWFqM09m?=
 =?utf-8?B?WXdlZnNFenNKWmVVUVBKbGRzTldrWjFaUzhOVjJ3VUF1Z2MvQ0dqQUg2b20x?=
 =?utf-8?B?eUFPSkRzRkNpMEtvZXBPTlJ6ZVg0Y1RYaG92b1JzN0YyVDlaRktuLzk0MUM4?=
 =?utf-8?Q?12SWUT9L7UbIB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnFaVVhyNFBSMDhtTUtEazdjTVV2b1gzQVB6RXR3b3p2NWpHdDYyRjNXdENQ?=
 =?utf-8?B?VS9VQzVyUEJ4WHdCdTJVMEhZLzd6ajBTdHNhTE1JTVBkNG1Ja24wOHpDQnZB?=
 =?utf-8?B?ek1HZVlvM3RGeGRqOGFkWXFyTGY5ZVpjTnRHdjdJaENiQXltM0syR29CbE9s?=
 =?utf-8?B?VGEvanE3MXNRREtmM3d2RHhMOEVzdTRmelBRdWtUSGpaaHo4RUt3L3ZaVnJr?=
 =?utf-8?B?VE9FTVlEamxVYmJMOWNhU09aeDY3dDNOSlB1ZlZCbTVDYjQ0WkliZitzMkI0?=
 =?utf-8?B?d2k4NzFObWFURlFpTXViZjMra2FBd2N6MUNrUFN0OGlWLzRJb3V4a0NVR2h2?=
 =?utf-8?B?YnRwdVIxSkRCd21Ja0M4MEVjU25Ka2M0aTBvRnp4eHR6Y0hTZ2JzcjZXaExX?=
 =?utf-8?B?WHVHOHU1azFiYnFEYzEwbjFNZTJWQ2EwNjEwTXY0bE1QdXRkelJGVFloWWZ5?=
 =?utf-8?B?RnpXUy9obk9IZEltTjdFVGd1Sk5NZG4vQjJkK2FJR3MwRkNlbUM1dnloa0lO?=
 =?utf-8?B?SzFCeEZmVi93QWZWQkR4VHI2SEI0eVlBbFRGcXBhSmFaYjdma1ZSK2dDTDRJ?=
 =?utf-8?B?ZkJQR2s0bnlXbnZrYlJCODNOOEIxZ0ZOeFFEL3U0bEtzZlBNcXh2bWQwOCtL?=
 =?utf-8?B?S2h1OHFiL1plREMxMU45MzM2Nkx1aEY5Z0dOZnpITHhDRy94bzB3eFpkNzkx?=
 =?utf-8?B?TTZSOVZlZWFybThhOUFndnFyZjEyR1F0SnlRdzVJR0c1WllUN3VKOGZqVmsr?=
 =?utf-8?B?eG11YWJNck5wdW5wWjhIWm1QWFZscmNqSldGVVdjdXM1YU5FYnNpczVhSGJl?=
 =?utf-8?B?NFh4L0FwUkppN1dGMEJRTmNibThnQ2JxQjNEcGhnVEtQYVU2SHFWTjI1Y3FZ?=
 =?utf-8?B?aEEybk5MRXl6QzA5bjJHRFllRlFZbVVIUnRXZ2F6QlNMNkVZaVp5a2cyMGV4?=
 =?utf-8?B?SEh5eklPQ2hUdWpoSmU1NmROcDk3U0RNSmQyMkdwcUpRc2Izd2Q3WkFpMTFi?=
 =?utf-8?B?bGZMUkl2NExSYVZidjhVNy85ekNVSTIyTjByU0Q1OTZMMkdLanQ4bVVZRitX?=
 =?utf-8?B?YitLVWhqS1dxejRjMU5pSFVXbWorZVhtT1M0d3hodzVGQlFCSU9YQXQrVldE?=
 =?utf-8?B?YlhEa1RObzVkUHVZQjVyTDhCb0Jtc1RwcUl6VU9pMVVpM3dlT0RFNEVqYkUw?=
 =?utf-8?B?RjRhMThFR29raGkwaUhoNnJvRVJVTnlDcE80TTRTamJhbVhLWDFoUXdzSEV6?=
 =?utf-8?B?eG1SMFFOZVNMeGVZeVdhK3M4ODRWRHlFVEZJUWtDTlhISnpLMkcxM05FZEdi?=
 =?utf-8?B?ek1za3dQaXozUXNtUzJTOXBOU2p5eGFXSCs1VzZENTRQS2J3anZyaEkrNTNw?=
 =?utf-8?B?VnpEMTg2REwyYWxHWExRUkFCR0dPTnc5WTQ3VVcyVWRwWTdqcVN1WlQvRUZw?=
 =?utf-8?B?VFFNcVFVd2lUeHNWdHJEMWdOSmdSRCt0eDhlczJXWWgrTU9iZ25tY3RrZmE4?=
 =?utf-8?B?TmRabXl5amhuREgvc0RMK2hReHYzK1kwMGdIei9xdTJLV0JYNTlXWXpiOFVK?=
 =?utf-8?B?QWtraHN6MjZWZnNUQnpPZVZrRDJuY3Vab1lkSWRaRFBTcnhNQ1RuNUM3OWF0?=
 =?utf-8?B?VWNoai92OXBaNStkUGRHYlNicXhnZURJRHIvL3I4eFBhZStDYmR1dGx5azRH?=
 =?utf-8?B?WXhwTzVtYU1NQWIvdENOaEpCVTRDNjJWbXltTDI4N3c1eGFNNTFCbE1xRmlY?=
 =?utf-8?B?SHc4WUNDN3F6ZElJUGhzVFZUZ1VCREY1N2Z2Z3B6bmpybHJoWXByeUNsRlhs?=
 =?utf-8?B?a0EzS2p0MGVMTzQ1SVNYeDZ6WlZXaHlNRGs4M2dhNklYcDVGMTEyd0hhTXRh?=
 =?utf-8?B?ZWhneHM1T0Y1UGpNT0NiVVhPdUtCZWEwQ3ByZ25jNHp1T2o1aFFHNkNhV0ZZ?=
 =?utf-8?B?c2plTytaVWg4K3czUGU1MWVTa0tzNEROb1c5RmhGZ1pjQVdsbzIrQjR3cUFB?=
 =?utf-8?B?b2s3bU40am4rUTA4WHJKbE9Yd3BZL2dzRlYwUi9UZWZaK0xZdjFJOFpPbnc3?=
 =?utf-8?B?NTdYR1dBUGNaOXNrRU85Qm5KQ2gzamo5ODl4YW9NQ3kwczJ6bFBmQnRxZmRy?=
 =?utf-8?B?cnRsOUd2a1BDLzU1eksrN2RHZ25LbmN0bmlFQUZMMEl5VTd1RmUvWDR4Zm9T?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 269efe60-3582-4e09-3982-08dd5c7ae760
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:48:29.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: th3iR5536aSu/6kzWTpa2SLiopcyi+UhZypAJfz4XfHwwyAYEvkYTjyNxCBPiobhRdBgyoKKDhsCMyagjlh+AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
X-OriginatorOrg: intel.com

On 6/03/25 08:45, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Mar 06, 2025 at 08:25:01AM +0200, Adrian Hunter wrote:
>> On 6/03/25 01:28, Namhyung Kim wrote:
>>> The length of PERF_RECORD_KSYMBOL for BPF is a size of JITed code so
>>> it'd be 0 when it's not JITed.  The ksymbol is needed to symbolize the
>>> code when it gets samples in the region but non-JITed code cannot get
>>> samples.  Thus it'd be ok to ignore them.
>>>
>>> Actually it caused a performance issue in the perf tools on old ARM
>>> kernels where it can refuse to JIT some BPF codes.  It ended up
>>> splitting the existing kernel map (kallsyms).  And later lookup for a
>>> kernel symbol would create a new kernel map from kallsyms and then
>>> split it again and again. :(
>>>
>>> Probably there's a bug in the kernel map/symbol handling in perf tools.
>>> But I think we need to fix this anyway.
>>>
>>> Reported-by: Kevin Nomura <nomurak@google.com>
>>> Cc: Song Liu <song@kernel.org>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>  tools/perf/util/machine.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>>> index 3f1faf94198dbe56..c7d27384f0736408 100644
>>> --- a/tools/perf/util/machine.c
>>> +++ b/tools/perf/util/machine.c
>>> @@ -779,6 +779,10 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
>>>  	if (dump_trace)
>>>  		perf_event__fprintf_ksymbol(event, stdout);
>>>  
>>> +	/* no need to process non-JIT BPF as it cannot get samples */
>>> +	if (event->ksymbol.len == 0)
>>> +		return 0;
>>
>> Are all ksymbol events BPF?  Maybe it is OK
>> for PERF_RECORD_KSYMBOL_TYPE_OOL also.  Perhaps adjust the
>> comment in that case.
> 
> Probably, but I didn't see OOL with zero length yet.  Is it possible?

Probably not


