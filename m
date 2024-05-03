Return-Path: <bpf+bounces-28543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D9D8BB43F
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 21:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D9C1C20AA1
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 19:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58F158A36;
	Fri,  3 May 2024 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AULhwV6U"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A213957E;
	Fri,  3 May 2024 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765105; cv=fail; b=Exu7IWedNYhv84cb0ZqoRrfxD2zJb6vquVzHdsapMDE7xDmHT/sdpKvQXtjdBBeLPD+Qb7stM9mQEyNn7y3eB8YV/0N2TVD38M15wCI+LldDcm+flToKeNd79dN1UaygFNzwXz6DyeHuqUA2a7RcOcq2QXAwzyyKDvSSSpeor2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765105; c=relaxed/simple;
	bh=cB1g9yShoIeB7D/S3En+8zv0N4QEyImp+mVTNcNx2uU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SFh9oVc2OFbEx53+rSt3eWRyhiTK7NcMXbekbPig/ZLnSz8Z4L+UobPOadLGhpJldAl+l0/5ep1gD5UIdg56IA8+cnRjLxzHPUn5/JTsAorku5pP2EQySMxhkTVxrelryrbMMARLK5WTywB7dnX0PDYp8Vy59I5FIMnsmXbj1bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AULhwV6U; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714765104; x=1746301104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cB1g9yShoIeB7D/S3En+8zv0N4QEyImp+mVTNcNx2uU=;
  b=AULhwV6UjvRhaWxdzcd+C7PL7pV9cIJRGtCTMqQt/Y4wBpRJsTfO/bHZ
   PFuSzJud/Q+LRPsIi1ahOUtLSl6d/rGXLNF/tZd1oG5YWewA9J8b5tq0W
   6wTZvd3xZO6jqBie0cX4Mv8wpdYPsUobu3K2Bd8mhLz1SoWI8YQnjBTJ1
   +BnK7EDqs1hWdYBheO+0nwn6j3mMyscKXXA1Wit05KPFOH3uhj4rETUYn
   pTQz+r3QL1EuPYitbTQFgyQJnlYbMv6xwVM4hYjG1rGo46Nfj6ke2Tujp
   MWWDWUY6fVYnBPeIhLlmCAoi2baG5uyQr7owaeVeflhOAGgt5hfjs0ett
   Q==;
X-CSE-ConnectionGUID: chiBpKjBTvKlYmj4HQk3wg==
X-CSE-MsgGUID: WI8JcrUsQXGc/n7zv85Dfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10802129"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10802129"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 12:38:23 -0700
X-CSE-ConnectionGUID: i/eBckQ1Tp6JHuUVN+QZ3Q==
X-CSE-MsgGUID: /0TDC2/qS8m+ky32Lkuqrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27421241"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 12:38:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 12:38:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 12:38:21 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 12:38:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FazcrYkoDuHK/Y6mXJZ84RHXvFM4+0iuX6Tu3+JjYomapWVPqndxnWJtnpVlY1LEqF6vy11Cl6YDL0rzUmfbKpWzM/2A+Iz7ktbHU0t0Idji90VKVRhctya/B7MLMbU2iLRhpBnjA3f+z6Rpl4sEAokP7/kQotWPD31WODZBuMPzi9olZ63K1tj0jIv+D5hsjmCidouosyUwIGb9SY+6ItQF+eLcDSRDYgY8j9ah+SvqrLVGlBW8Q3rlXtquNShlywVi4E2C+oWhOVN8KLxIRzr/x652/pYqBW2Xz1QFUr/QmbbUGtGgh66DRwgeGU6ellfROOASijamN2/9sfAinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB1g9yShoIeB7D/S3En+8zv0N4QEyImp+mVTNcNx2uU=;
 b=A3+kpxnVpQN3MwEKsXXDU4dEf7lmoAa1YQCIVGeI4+iDlDQFkhI5q4NnJj3gYu5Rsc+GUBbunuuEmzfQvfctuc5x8FkhLFt4lCViCPL80OohLDrc5VWX+4Sq6PGUIqbrcFxkiCh/At5DOZgjfyvVDLFqTbW2OILLmd8wcBFbuBmUWX8wFj0NdpoChBBnF87290A0kAGUzs92d8cF/JGGnqpNmjdlhMXYALoVJKGCxI7++n0ziN1MPqLkdkf4LnePal+lBfthqF9CgUS8qC3sHhEteKw3Vof/CyBSvW+4Ak5tIJa/F6cQl2qZCr9Fzvj7d281Et6FWx22FkkgkWtwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB6725.namprd11.prod.outlook.com (2603:10b6:806:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 19:38:19 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.7519.031; Fri, 3 May 2024
 19:38:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "olsajiri@gmail.com" <olsajiri@gmail.com>
CC: "songliubraving@fb.com" <songliubraving@fb.com>, "luto@kernel.org"
	<luto@kernel.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "yhs@fb.com" <yhs@fb.com>,
	"oleg@redhat.com" <oleg@redhat.com>, "linux-man@vger.kernel.org"
	<linux-man@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Thread-Topic: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Thread-Index: AQHanU4GpcFda+6iuUm0ZMN/pIdOBLGFejyAgAAvKwCAADlUgIAABY4A
Date: Fri, 3 May 2024 19:38:18 +0000
Message-ID: <6c143c648e2eff6c4d4b5e4700d1a8fbcc0f8cbc.camel@intel.com>
References: <20240502122313.1579719-1-jolsa@kernel.org>
	 <20240502122313.1579719-3-jolsa@kernel.org>
	 <20240503113453.GK40213@noisy.programming.kicks-ass.net>
	 <ZjTg2cunShA6VbpY@krava>
	 <725e2000dc56d55da4097cface4109c17fe5ad1a.camel@intel.com>
	 <ZjU4ganRF1Cbiug6@krava>
In-Reply-To: <ZjU4ganRF1Cbiug6@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB6725:EE_
x-ms-office365-filtering-correlation-id: ebcc986c-75bd-438d-55b1-08dc6ba895bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aXFmT2pkc2NlR1pZK2pIUXpxZjZNUmE3WXJ3SnErdTZRcnl6dXB2U0hCS2Q5?=
 =?utf-8?B?d1huY3pvb0MyWTNGeTlsTEhxYy9OU0FRWmkzRUtpS3FxWXY0SnU5VElxdkNC?=
 =?utf-8?B?MFdYUUhCNDBIbTlHa3BnMGh4K20wbmhWOEtsRGMwcVlBc1NxZjFFVW5ScjNP?=
 =?utf-8?B?U293ejc4NFY5YWlaUHgxQm40NldiYUdwV0dTSE80NCtBZHBLMFFDa0NFOC9C?=
 =?utf-8?B?V3Bpc281MkFWaG00MlNYSGhvM1FuSjdraEtkTEUwQ0ladnN3MjBDdFE1YmQ4?=
 =?utf-8?B?a1FJTVZYdVJES29VSTJFbG1mRk13L0pTWnJWVkh4OXp1cXk3MGNsbDVHcHpS?=
 =?utf-8?B?dm4vcVlNNGZ1U2VGWHhKOXRrb0lmMFRha2lqd0d2cmZDc21uN1FpM0FyemxZ?=
 =?utf-8?B?cFBBMVBEdVY5amMxankvYXlCYUlUOXhhMFRsT29YcTBNRVlJK2k1dHM1Y2c5?=
 =?utf-8?B?eHJLbkRYa1ZjcUhEQzNoM1pyWXE3ZUUwSXl0dHBpalRrMkYvWmJBUERQUWo2?=
 =?utf-8?B?QXBkUnRrYkdyaXByTmNCRUlDbXpjdkwrWUFkV2R5emxiUWRwRkN1NE9NaVAz?=
 =?utf-8?B?TklPclVrbUM2N09XVEpuUkRqa1JPeHlwWEl5R2tWSEx1cnhyS3RtcEJ6Zmpo?=
 =?utf-8?B?T1BvbTUyd1NnYThZMXJPb0w0c01xbkViKzBDK1l6NC9kWCtzSnEyVkFOcW9L?=
 =?utf-8?B?YjZ1dEExaFFyUEt4d2c3MXZZVHA2MW1CSWViYWgrR3JaSDJSd05HcHJlb0tj?=
 =?utf-8?B?SXpqSTlueFpyV0l3QTUxOVZGbHJRRnQ5V004dmlTVHBqQkZKbGRibkg5TGxB?=
 =?utf-8?B?TGJXVmxzZTlub2ZtNDcvbHliMU9MQWtmUnVlWnZJMWZNaitvVlczQlQycDUw?=
 =?utf-8?B?dWVEVDM2c1A3UEQvK2RhTVBCbmJQc1JIanV2RWY1WU5iWFpXMzJVZHdLNmNa?=
 =?utf-8?B?bU1HNjlWTUV0WGR6dFk2MU1QNy9vcTRmNlM4SW5uMHMvUHI3cnhVRmZ1OWZp?=
 =?utf-8?B?WWxtTUx2TVlNV1lUWmZxWE55RE9ibVBmMWFyM0N5dFB0c0hhd2E5WklDcU1o?=
 =?utf-8?B?TVJWZm05OC9nR2dZaVVZNXhSaVdUVllHcklCWnRTZkcrSVhiRFhKUTl5NjVy?=
 =?utf-8?B?UnkwMW4vbkZnRWlBWWlHbXUxYlFMRzN0UXpuQW8yT2w5UEo3RTF5K0RORmpW?=
 =?utf-8?B?VEJQUGRXWm5lZE9lWUszSzB1R1hNa3hFZGIwYXdZV1pEcXhRcjZzSmtqMzZQ?=
 =?utf-8?B?Y0xVWXB6VGpuRFVJdjlaYWN0TEs3U01VUXFoeDhNQ01UUDNGcUlxSzU4T0c4?=
 =?utf-8?B?N2V0TG9wVDJsL1NyVitxcnpsbHpmTUw2UHpnK0FOcGJtQUpsWkRLTmFPM3kw?=
 =?utf-8?B?ZlJlOFRHUzI3WWJtRFJ6cDJxeDVoa1QzajlwdDdUd1NMRy9vRHBvczVxZU9W?=
 =?utf-8?B?eHR5T2p3ODZlTWEyRmVlODBUTEtNNnp6L0xsdkc5RmFac2piOUhmVm9YYVhT?=
 =?utf-8?B?NWd2L0FJYU14eUtIcFBRemZpTDBISDduN1IxamVFWVViV3d5MGdjQVdWYldN?=
 =?utf-8?B?VlJVRzYyYnQvQ2dEK3VnL0o1eFI2T3pCTG9zazJFVXdUa0dpTmhwUS9VU2hi?=
 =?utf-8?B?b2ZVakFSNUVTZis5ZGJPZUhxaGpycE9sdHJYUnFlNWo4Q3RKOHVFeFFPQlRQ?=
 =?utf-8?B?alJBR2daVC9xQUhxUWpxcUloeVE2N1N5a2N6VkRIOTNacmlHczgzeVZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXhlODRyK0wzRnp1SWlQMmlwSXA1SUJHQlBsd0dpbm5BT1poRHMvUjRHOUdk?=
 =?utf-8?B?MDVLQ01nZXJZbjNiOTdkMEx3MlpGaWxrS01yK3RMNDlIYWtCaEdHR0xPTzUx?=
 =?utf-8?B?citIbkd1OXB5Z2JNODZGdlY2N2tBNGhkYk9ZM2poRzFqWkFXOUM2Y2V2c1N6?=
 =?utf-8?B?cUNjU3NQS0NIbTZ6MWFyYUc4Um0rNjNGb0RmMjRJM1Y2THBNM1pWK0xPaEUv?=
 =?utf-8?B?djF6UHAyYVdkTVpoUDlHaytQOVl0empiMks2Z21yckxPbklGK0NSekRROTRh?=
 =?utf-8?B?UTNkKzhtMlFLSXVHM2hKdVFiZE9uNXB1enBQaHlhSkpBTG1DWmg3WkRSNWJ4?=
 =?utf-8?B?cHhhaFZGejYwd0pkNnlhZ1dWVFFGc2F1VGNLdmRaVHRDWldHTWlLZHJSRlBB?=
 =?utf-8?B?YmdwZzVIVnQ4eXkwemo5bkt5TFVaem9pdFVFUUozSlpHNjQxZWMvcW5qYUtH?=
 =?utf-8?B?Yy95Q3JpZUloVkw2R2doRnppS1dxRTBZdWczVGhzZW1wb2pUL2hVQ1E3Z3M1?=
 =?utf-8?B?a3pQRmNmc2c2Q3NtSWZWN0lybUxVUmNOaXpZLytjY1F0N3grWml6clhIQ29o?=
 =?utf-8?B?QkxNQmFvSEt6cDFYY3lOTUZpdUtFa3RNczQxeWpNektxd2RoVXBOcFZndlJk?=
 =?utf-8?B?VkJzQlRMMXI4UU55K2Z5bnUxQzNiR3FuR2Q1NzhrQW5RTlgyUUtGMk83Qm9Z?=
 =?utf-8?B?Y1JHUTArdFAvZFkxaUR0SktOL2dXR1N6UkczU05Nakt6aHM0SVJGMlordHVB?=
 =?utf-8?B?TTlJVUpKVlZlSTlOdXZDTVdQZVo0UGRqajZqcEExekxIMXBUU1RiSDA3RGdI?=
 =?utf-8?B?VjRhVHd4K21ZN3crREQ0SWt3WTM0NGZMdGN4VzV3RllZOW02dVZUbjk4RlNa?=
 =?utf-8?B?dFRlN1JOVWZxalNXSzNKNnJ3UmdBUisyQ01OOUF6ZjNDVjMwM1JqNzFBZHVZ?=
 =?utf-8?B?dHlJWnU0N0RWYWRYQVlrcGdpNkdPMk5vNTRtRW9jUTJmNnp1NUNITDNwQ0h6?=
 =?utf-8?B?MmlnMjF5dEVpZTN1ZVNBTTI3bG1uUk1nVVJpVGd0UXh3SVZobWhzc0d6eW1E?=
 =?utf-8?B?RTl0eVVYMFZGMVcrM3ZyVU1aL3FrbS9zOXdteVkrTU4rb2JQTnFFRjE5YS8y?=
 =?utf-8?B?U0FtUnBjY1VHSG1FRWIvZ3pnT2tQcmtTaE1MbSs2dlVvSnZFWmtrMElNYnhD?=
 =?utf-8?B?VEs2VGFabS9XOUNXcDFCajZSbEJWckxnWTV5MEsrV3J5dExqSmdFUDh5WkNo?=
 =?utf-8?B?VzdLeEt3UVVNN0oxWThjYk9nOHRIeERxWVpPOWR1NkpuZ0lObzh1NkRjU2Uw?=
 =?utf-8?B?Ly92SGhkM1E5c3U5VFR4TzRTeWZMNlFtK2o1MjgrR1BrSG8wVmxaeitJM1RQ?=
 =?utf-8?B?V2xYQ3BoM1pXYzhzN2JmRTFZY1hheGRXM2NVUjlPd294ZDhON2dWUTF0a01M?=
 =?utf-8?B?VlVRd3lFV1hoYmxqb3pxVFN5KzVveVFhZEZCVW1YSENodXB2VDdQYVdRTjIz?=
 =?utf-8?B?cjhDUzF6bGN3WVhmZEJOcXhsTkZPdHEwQ1VJSEFKQ0Z6L0NHSWZVOGwydE93?=
 =?utf-8?B?dzM1dXVUaHpsdWZHbUM5VjRiU0p2cVJhTjF6bkgvMXpLQm9yQkJEc1h3L2gy?=
 =?utf-8?B?UWJCMEhlODBKTUY3eURJZjJldnNLMDNQdmUzU3MvRStzV3BtWDZ4dlc1dlls?=
 =?utf-8?B?NmlLeWQyeklLaXZzTkdLdUxXQmtmdTFuTkV5KzgvZXJNR0ZZbysvNmJ6bllE?=
 =?utf-8?B?ZEYwTG5VTW05ZlBxMWp4VWdveTVaUGh4RkpSQnBPVFFsM1FkYmRLZXcxZmlw?=
 =?utf-8?B?anMvSml5bmkweW5JTEtkcWtCd1UvTWZpUUM2MkxJUnhlM1Awd0tUc1Z0OUha?=
 =?utf-8?B?cXUwd0x0MWhUdmE4ZWd0YndOMGoxVER6SFZtSTJadlhWRDB4MjFvVzRpR1p0?=
 =?utf-8?B?TE5XYitIT08vaEYvVlFHallMcnQ3TVlBNmlaU0RFeDYzZ0xmWXVaSDNxKzhm?=
 =?utf-8?B?Qll4eGNkWG9pMS91NUMzYk1iTC9HbW8xU3NNVTZuY1FhSnd4OHpqZk5rYnJY?=
 =?utf-8?B?ODRFdHl3VlFyNW1Rd1NoajFtSGU2ZEVVTjhvTGdXMmdXZXJ5Z3A1YVRLVkdZ?=
 =?utf-8?B?dmxUUFlxNCsrdUxHVXRhbW4yYVZLMDd6N09weEJVamU3RWtGOWVpQ3pUdmlz?=
 =?utf-8?Q?vvgjJql9pofwQhRiRhuZVuA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB3679E696137B4EB7BBBDE07AB3A94F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcc986c-75bd-438d-55b1-08dc6ba895bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 19:38:19.0221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTki1asemeN3Y7gabE6IpZpLuGSmzzWeOdik621ApS2loU6TMW2+utwwpA/C2huPakwOfafEZemAGj5WYo32qS8w80bvy/qilzuyxFvjw+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6725
X-OriginatorOrg: intel.com

K1NvbWUgbW9yZSBzaGFkb3cgc3RhY2sgZm9sa3MgZnJvbSBvdGhlciBhcmNocy4gV2UgYXJlIGRp
c2N1c3NpbmcgaG93IHVyZXRwcm9iZXMNCndvcmsgd2l0aCBzaGFkb3cgc3RhY2suDQoNCkNvbnRl
eHQ6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL1pqVTRnYW5SRjFDYml1ZzZAa3JhdmEv
DQoNCk9uIEZyaSwgMjAyNC0wNS0wMyBhdCAyMToxOCArMDIwMCwgSmlyaSBPbHNhIHdyb3RlOg0K
PiANCj4gaGFjayBiZWxvdyBzZWVtcyB0byBmaXggaXQgZm9yIHRoZSBjdXJyZW50IHVwcm9iZSBz
ZXR1cCwNCj4gd2UgbmVlZCBzaW1pbGFyIGZpeCBmb3IgdGhlIHVyZXRwcm9iZSBzeXNjYWxsIHRy
YW1wb2xpbmUgc2V0dXANCg0KSXQgc2VlbXMgbGlrZSBhIHJlYXNvbmFibGUgZGlyZWN0aW9uLg0K
DQpTZWN1cml0eS13aXNlLCBhcHBsaWNhdGlvbnMgY2Fubm90IGRvIHRoaXMgb24gdGhlbXNlbHZl
cywgb3IgaXQgaXMgYW4gb3RoZXJ3aXNlDQpwcml2aWxlZ2VkIHRoaW5nIHJpZ2h0Pw0KDQoNCg==

