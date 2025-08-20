Return-Path: <bpf+bounces-66102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F283B2E4A0
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 20:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C86A27642
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 18:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5F027A44D;
	Wed, 20 Aug 2025 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXVoU+C9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF125A347;
	Wed, 20 Aug 2025 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713057; cv=fail; b=Aj9RJzQSOFfaxPW3R9QF7xR8JlykWeQuBMkph7XJdWqMiipVFBc7U1IRCihlyx7rkfftbQnoyOgXUSvEklPiYT8qTN60AKYo84k6c+5bvqq83uRejlZbmY6wNQVUbpK0w6whDpdT5eyw3YOgXQ3g6SwD7+MsvjA7ose9essWwUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713057; c=relaxed/simple;
	bh=kalWnHq5yyYRtwAOnWyTDBhCG1BmjKNJT5TUb9MBIX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jq95DNujYyIfYTthiLAf88yMiH6g/jveGe7wbwJHsj9l8gXQUOh2l+F8Phms6BV4xG6KkkTKuvtoji3Ve1z71FL0WUSQT3T8D9escWazB3EiiWTm+MWSKn3Vielek0UOS0evw1Qe/cwQZRJnWwR7exUQ4MG4d6QBnJkpPzwBfDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXVoU+C9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755713055; x=1787249055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kalWnHq5yyYRtwAOnWyTDBhCG1BmjKNJT5TUb9MBIX4=;
  b=DXVoU+C933HSSplMXm+h6T70Z7cWhOIjZM9rvs4rSiw6vvR0VVK/711o
   8NQUQikqLhufnV72+ao5bSb0m2S7C2bjyL/fcS2GLRFTRj/GfYEhkWobo
   s1fXsckZZ1xNgHY9dHgQDdh80LE6WcfvjAG2/f/MaL3KL/tUbQ5iKG6K9
   ohc0HOfCWJm2bTLzEmpW0DnyaAtU91F1K+dnMMEy0FjqwzGJP8VCE2eus
   FwFObCvhIk0/Lp+bLw1XSbP1dRFnYrPF/epZxsdAtjtfQrgsa1YLBg+n1
   7yNFJa+saoz8OpXWIDkLJsv4cD0DBs73arzR7DY9/PTlG6fHt60q8s6aI
   g==;
X-CSE-ConnectionGUID: UlJFKN5ORey3oBNyO7qnLQ==
X-CSE-MsgGUID: Yacs0B8RSZCI/yCwfkT33w==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="45564963"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="45564963"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 11:04:14 -0700
X-CSE-ConnectionGUID: 9TFNv1lCR1+bWuyzdO1YMQ==
X-CSE-MsgGUID: /IAQbvWyTxaquVRBJUagBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167402160"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 11:04:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 11:04:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 11:04:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.73)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 11:04:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kplkwxTEOGztICf0q8I8ySpr+og6g9iDuBpLkgmHqKyqDd1mHyuQaxB8kBF8exh8oBZq+aIMGDUFjP1N9GDP3pCa654ouOVPB2yCYGyQOVyrac0KMyy2tSJLJnR2lR7HPjPpcSDhcl3d2Q02UXVa55T6E6nsDZDHt74peLnGC3Py9FB4bbwDDU3Olm1mFpIdS72usPPhumvOwi+H6TzDoX1+HNrWrqu3Ntn0ixoM6aEPgZXbxq9PGtwP3RNPTmoGV5s4Zt669nY1GyvvGGL6wSSh30Q/emMu3isZ/GxeOcgg59WKsTOfVD19vI1aDWvLM5Kj9aX4ZECBwpyxk/qrag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kalWnHq5yyYRtwAOnWyTDBhCG1BmjKNJT5TUb9MBIX4=;
 b=oLbHSIJchZCefMbsPNEEql1ZDPPKt9ZNsNo7Sc7i0QDKW2TYm+06JM1VPibZu+VLSg/MF80SxlRJknEYMiDJqPEIcfRNnptqmeTwfnJl+D20yxOA1PpW0EyXcy1kSbeVhhfBgYxD9aJ5nVXHAUaTakLrUGoOulwrshGuNkkHuHEkkIrspdqY/ROIYHWA4i7J4xGvSzn52ao669yePlpBy+gDcv8EgN1vNw9dpooDeRqi1hy8KBChnXytXs0NKR+xE8HPytfkunjy5t13UipUzTCcVGu+bIfdcUeWFtEz6vP+ximVLuNIEd+UVW68cq/7FEjdX6b36hwcYX8QN6fQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO1PR11MB4772.namprd11.prod.outlook.com (2603:10b6:303:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 18:04:11 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 18:04:10 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "alan.maguire@oracle.com"
	<alan.maguire@oracle.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "mingo@kernel.org" <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "David.Laight@aculab.com"
	<David.Laight@aculab.com>, "yhs@fb.com" <yhs@fb.com>, "oleg@redhat.com"
	<oleg@redhat.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"thomas@t-8ch.de" <thomas@t-8ch.de>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Thread-Topic: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Thread-Index: AQHcEc5LWQgc1WQMikmopLJo2+WQ07RrstqAgAAUyoCAAAPpgIAABMyAgAAFsgA=
Date: Wed, 20 Aug 2025 18:04:10 +0000
Message-ID: <447af60b944e0f7a8ddf012973029430af834b2e.camel@intel.com>
References: <20250720112133.244369-1-jolsa@kernel.org>
	 <20250720112133.244369-11-jolsa@kernel.org>
	 <20250819191515.GM3289052@noisy.programming.kicks-ass.net>
	 <20250820123033.GL3245006@noisy.programming.kicks-ass.net>
	 <9ece46a40ae89925312398780c3bc3518f229aff.camel@intel.com>
	 <20250820171237.GL4067720@noisy.programming.kicks-ass.net>
	 <62574323ba73b0fec42a106ccc29f707b5696094.camel@intel.com>
	 <20250820174347.GM3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250820174347.GM3245006@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO1PR11MB4772:EE_
x-ms-office365-filtering-correlation-id: b4fab206-68be-4aab-55c0-08dde013f701
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WGVhSmxvMm1IRGdyaHJ2TGpsS3J4c05SL3EzQjh1THJDdXhvUFV0aUNwZ2Mv?=
 =?utf-8?B?clI1eWpVQ0ZrckhFUWV3MFJJWmxvV1Zlc3d0K0lHc24vNStIeDRsVUIwK00x?=
 =?utf-8?B?K21LZUVMZ1NaZW9WUk9xaFZmMG1aZ1cyWEdxMU4ranlBUzFMS0FoVEVEUHJQ?=
 =?utf-8?B?ZmQ0M2U4ZjBTN0NKdFlscUxtSExBQ24wYzIrWk9FUzBuOVdaZlNUL3llRDlh?=
 =?utf-8?B?MkR6UHczOXc5SzM0NDloS0lhL0ZHUWxIczIyeTNCRllqdmEyWm9BZG5sd3Vs?=
 =?utf-8?B?SUpqSEhZQXJlbzlIQ0c2OTgyakZ1QXBSaDdGdGd2ejZUVzA1Q0dzaVVjemZm?=
 =?utf-8?B?SkJoRzk1cW9jRGM2cjVTRWZkSFU3SUFzWVpxbDZpa05LQU5DeC9uL1VJM0dm?=
 =?utf-8?B?QXdydGU0Skh4SjUyY2pMVDlkMHNkZzYzS0hpZUh3WGxiaFRiUXFyVnFiUmJ4?=
 =?utf-8?B?WVhkWWE0RWgyVEN3UW44MEFtSUJDVkJqa1RyUWpDRmRlVjZjZVh3MVByTDBC?=
 =?utf-8?B?eW5hb2w4Q0V1aWVFcStQNGMvV2Q1eFlsS1dLVjZOMXo2V0NWMDNjbzRIdmdQ?=
 =?utf-8?B?Q2N2MWhNVDhoY0RLeFN6akRVOGhhOE1PbFFQaUt4T05xSnhkUVN1UDRwUEZr?=
 =?utf-8?B?WUV3dlZtRE55alBkQjA4eWNZU0dWUy8xS0FvOEdUL1BMTk9sTHNhT3FmK09h?=
 =?utf-8?B?Y1VaOE16SlJJRzN6MWpOUlUzUVFNdjltdVhBNldITnV1S0RvOXVHNlIyQzJo?=
 =?utf-8?B?b0ZhcldncVkyemJHbWlxOXJlYkMxejBiNHZJZy9LVGxMT1RlQnNXa09HSG5h?=
 =?utf-8?B?cWxUU0VUSzJkYkd3K253K2p0ZkhVeE83eGxpZzBtQWwrSktwd3FXZ1pka3kx?=
 =?utf-8?B?aHBUZGYrMmpQOHlGdncwNVlxc0l1Q2Z4cWE4enprczJJaUdmQVljNnJ6VTd4?=
 =?utf-8?B?N2xBNEI4cUE4K0JLcjdjSmJzZ0twbHJ6eHBHTXJabEpBYnpQUTYwakZEWSsy?=
 =?utf-8?B?NVozcEcvRlJYcnhlUlFuVkdCa1JrdHJJbTVTUkVzc2haM2xmVjZCbXpSNE1H?=
 =?utf-8?B?M1MycGxUR25ERnB4OTdONnk1eXpoMi94T2Y2cSttQXg5RDBMNFJVT0FpeXhu?=
 =?utf-8?B?SFhsdzhxM1FBazRKZFN6RWxDMG15Yll0VS9ydTNNR1ZjQUpJY3JsOFVFZVlX?=
 =?utf-8?B?cnVtbk9qUk5tSHNyaENYMWV4TGFqL3JocWVTR2hzV08vWEdjenhOUTVrNHkw?=
 =?utf-8?B?dTNxMXUyM2xpd3VoRUhwMGdWWnI1blY0V1VtbEprZ2pKSVhZdGgxSStwV0Jy?=
 =?utf-8?B?SUVtalB5WUMyUUJwR1h2QXF1b2g2bFJyUnJHTTlIeXhRVU50clhZRHMzWVM3?=
 =?utf-8?B?aVgrOWZHWE16cC9lNlRaUEJub2wxeVp2dWlYVWZhYWJmRnRmNHZoM1V2WHBK?=
 =?utf-8?B?Yjg1Mk1KTHl1aGtnV21McHN2cmhKbHVpUVBaa044M0llQWtvR2ZtL1FkRks3?=
 =?utf-8?B?ZFE1WC9pMnZNN1FRcVpTOWZFZzUyaUhPMnprTEkvVndTVk5KWG0rQnZiOXBU?=
 =?utf-8?B?cjI3bWNMa0JwQ1RVYThIY21Udnp2NjZqeDN3RlBFdnFJVXZqK2tFcVh1dEhs?=
 =?utf-8?B?M1I3VEpVOEpJakNvWWMyOVRYNm1Tb0FuYzVPL2VoUlZwK2dJK3VYT0pUbFlq?=
 =?utf-8?B?TkZLT2E1NGdYQ1hLTkJPamJhem9Cb3R3cGZ3OWdvNkdoZ1BPM1JqSE9ZWURv?=
 =?utf-8?B?ZUY0cDREZ21xTUlkSkdRLzFuNjVCSi9ubkhFaG5QT0hvVW82eDUxclNHeWVJ?=
 =?utf-8?B?L0xvSW8xYzRwZk1UTHJqRnlFWWVickxYUDZmcm8wcHBUdWxsMGtzeGdiaXA4?=
 =?utf-8?B?TmljQktiaGZMZ1hlcUJwa2VIWVg4Z3IwNWRnaitVdmc0QlpqTm1pTFFyMW1T?=
 =?utf-8?B?dnU5Y0NQR3h1MG8wU2tJVEdSdXgra2gvSWNJTjdnSmNCUXIwUEVFWUxFb08v?=
 =?utf-8?B?VkxON1FDaXhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVMySmh0cUZyam9ObTRienRmZVIvSlVPd0RtelV6c2llRTc3TzA0OG90Q2Va?=
 =?utf-8?B?dHNMV1Y3by9jNE9YWnRGRDhDYjJ2VnBIRC9ZOWllVG1xbmhHUXZuOGcxWXNz?=
 =?utf-8?B?NDJlR29JQ2Rmb3lTeWY1dGFteHFkWHdDejZKZGkxV1Z1OGl4Y01PNXJ1QzdE?=
 =?utf-8?B?eWI1UHdKMDhPdXpGYmVyN0xpNUZTTzNhYnZ5OEc0VVZvdCszZEJxMU5ZYkxm?=
 =?utf-8?B?eWhFTzdJYlBQaWZuVU9WSFUvQXJBNWkwWnVaSVdSa2prUkNHaldDUHRkSTVI?=
 =?utf-8?B?U1BSbFZhSVRoTEJuY0w3WUhHcGdhNVhqc1hqOWx0MlkwaFZqWi9YQ1ZpTy9Y?=
 =?utf-8?B?SXFwTHBTbUxzU0Vra3Vtck9jMWp4YjVzNDRZdDdkYXdFdkE0K1NqZ1N0K0t2?=
 =?utf-8?B?WCtPTVVvbStVcHVTMWtpWVBmWVZ6ZjNVVFNseWNXNndMU241OW1CTlRpUGZi?=
 =?utf-8?B?dnhUN3JJTUU2SGxNek5LT1ErbTEzUmhHM0ZQNUk2QnJ1TFA0R0NmT2ZDWUQ4?=
 =?utf-8?B?NnIzaVNNS2NsOUV3UE0zZ2w2Z2hpSEtKcC9ZalNORENXQ3dxRCt4SmNUZitQ?=
 =?utf-8?B?ekxSWlUzczBTVDRKSmV3TjYxMG5VT0ErSG9MdnprTHh5OTM4aHZ4bFNicnBI?=
 =?utf-8?B?UXZnSDJrNFBCaS82Ui8wN1JVTkNPNXBJaDJzTWRRTFQ4SWpudm5GRzRvZTRt?=
 =?utf-8?B?NnNaTE5ndW0zT3ZKTmR6TkFNUFRGSGRxY3ZOSzVDVEdmaWpMeWpLTFhRdHJ0?=
 =?utf-8?B?RnZraFYwUjZEclN2dnphZ1g0QUtDQnM0Wm1TdXJqTUFBSWRneDZsaXl6ek1P?=
 =?utf-8?B?KzRXbXRNUHNlTVlYSnhudUdydXpZc0FmVVFpVEdLbC9XaStEZkgrRVFGOEtM?=
 =?utf-8?B?bEVVajUzZ0FHbUdLZkJNN0habDZYb3ZURzVtSGw0bmJINWtYRGM4SmZrUCs4?=
 =?utf-8?B?VXprdUNrdk5sdFlvenJpNFg5c2p0clN4L3FYZzVsVmJaYjVVNXlhV0Nzemh6?=
 =?utf-8?B?RFNDK3oweHRwMmFUbk1oS1h1Z3BZeTEyTWJFdkM5blF1cXFpdk5aSDMzYUFH?=
 =?utf-8?B?c1ZlK1ZpTUk5SG1Oc0p0em1kcnhRbkZ0Q0kyQThOdUFDRjVBYXhHVndDQ1R1?=
 =?utf-8?B?Nnh6NGJxNnJ0ZnpHWTRKUzR3Q2piWXFOb3YrNTZKWkJmVWJ1V2xyUlJkcFpO?=
 =?utf-8?B?eTRBdjRSUnhVMnNVUHpsbjdOUmtBWnhYZ0YyMTd2S3pCR3dwVDJ3cXMvRHcz?=
 =?utf-8?B?L3c3MHgwUDQ0U1NpWjdiNHdKQVBQY0psV0lBazZyWWNIcVVtQlI5Y05mdm9i?=
 =?utf-8?B?ZGEyVkxkcHcwTGtxL2lmbWVXWFhVUGZ6RWhCUXlRN2czMWFBcW4weHNLMXRZ?=
 =?utf-8?B?OVE3dUc5cWFrWkZ0cGMxUU5yZVlDSTI2enV2ZklMVi9BT2JOWFhnT0NydTlh?=
 =?utf-8?B?bklSZFVrWXRFM2lJZFJKWUFjRnAzYmw4VllmdTQ5ckVPLzZPVnh4SFpIY2tC?=
 =?utf-8?B?cGlsZ2NPVGlkT2NlTFRRL2xBM1NVazRRaVlRcG5sYWtJNkxadTVmNFY4WlRR?=
 =?utf-8?B?OEMrejZRQWM2ZGluSnVwaThEdlFGLy94UmdWTWFURmkraWxWYlZaeWtjTmsw?=
 =?utf-8?B?WmN2bGw2UHdkVlpVTytIUVk2MUxZWkJacTB6VXRjTnE4SENSeHM3MnUyTnBJ?=
 =?utf-8?B?UklkT29LbExWRDNWbk1xM1BzM0t0VXRpMG5pWm1Cc1R3N0ZzT3BFZjlFb0ZT?=
 =?utf-8?B?cW9NYkdyQ3hyV1RiNWQ4aTVTYzhGaklnMXR1Nll3YnJjeXZzZ0R0c3V3aVVz?=
 =?utf-8?B?dzkwMzAwOUp1ZTliM24wWmFQY1htOGZuUno2OGpHeGdnR20vZ3lWVkZIM2Nm?=
 =?utf-8?B?NEVkeXFMNjlyTnFYL0x6clpEMVYraGE3RkxIcjBLTTlnU3pwaFpUSGc4WGVp?=
 =?utf-8?B?Zk1RdzJYQnZKVS9GMmUzQjJrTmQ1OVlCZkhxTWQxY1FzZUxSR1ZIdndBcVVT?=
 =?utf-8?B?MTNhbFpNU3NrRW5NNkxBMklvR2ZyaWtFd2pYaUVWRXpWaFlBSTB2am1kNjQ3?=
 =?utf-8?B?Z1hWektMM2paS2FBNkpnM0k3bXMxSzdqTk0rdllzb25DT0tFampDbC9Tb1M0?=
 =?utf-8?B?dlcySGtrS1QxU2dKOGxBdUZSNDhQU3JHV09mNDI2bDZKbFpjL1dVOUZQcHhW?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <773C442DBE82B44FACC5C1FA30C9F531@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fab206-68be-4aab-55c0-08dde013f701
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 18:04:10.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d27JhJKqQcRBacrNh4ErkGgVoPrkOHFMaB4xDc9hU/oJiNojwqCcsNzJNbrAMZolJOWmGzc30Ole0Vy9FqGHVBJcaxSOapu6FdHEJy6iR6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4772
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA4LTIwIGF0IDE5OjQzICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gWWVzLiBCdXQgc3VwcG9ydGluZyB0aGUgc2hzdGsgaXNuJ3QgaGFyZCAoYXMgcGVyIHRoaXMg
cGF0Y2gpLCBpdCBleGFjdGx5DQo+IG1hdGNoZXMgd2hhdCBpdCBhbHJlYWR5IGRvZXMgdG8gdGhl
IG5vcm1hbCBzdGFjay4gU28gSSBkb24ndCBzZWUgYQ0KPiByZWFzb24gbm90IHRvIGRvIGl0Lg0K
DQpUaGFua3MgZm9yIGV4cGxhaW5pbmcsIGFuZCBzb3JyeSBmb3IgYmVpbmcgc2xvdy4gR29pbmcg
dG8gYmxhbWUgdGhpcyBoZWFkIGNvbGQuDQoNCj4gDQo+IEFueXdheSwgSSdtIG5vdCBhIGh1Z2Ug
ZmFuIG9mIGFueSBvZiB0aGlzLiBJIHN1c3BlY3QgRlJFRCB3aWxsIG1ha2UgYWxsDQo+IHRoaXMg
ZmFuY3kgY29kZSB0b3RhbGx5IGlycmVsZXZhbnQuIEJ1dCB1bnRpbCBwZW9wbGUgaGF2ZSBGUkVE
IGVuYWJsZWQNCj4gaGFyZHdhcmUgaW4gbGFyZ2UgcXVhbnRpdGllcywgSSBzdXBwb3NlIHRoaXMg
aGFzIGEgdXNlLg0KDQpJdCBkb2Vzbid0IHNvdW5kIHRvbyB1bmJvdW5kZWQgYW5kIEkgZ3Vlc3Mg
YXMgbG9uZyBhcyBpdCdzIGp1c3QgYW4gb3B0aW1pemF0aW9uDQp3ZSBjYW4gYWx3YXlzIGJhY2sg
aXQgb3V0IGlmIHNvbWVvbmUgZmluZHMgYSB3YXkgdG8gYWJ1c2UgaXQuDQo=

