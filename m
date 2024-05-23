Return-Path: <bpf+bounces-30360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0578CCAFE
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 05:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB61B2223B
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 03:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1113AA37;
	Thu, 23 May 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5UWh4VU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973D7EF;
	Thu, 23 May 2024 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716433878; cv=fail; b=C05dqdcUBnHrAaQbnGrL3+rWnR63JvoMAmL3GSODdi2k/F6YNNm3xpM6pUcHZ5GZJiciXTCK6JHqf4Qm+B+6h7LObAU5ZW6JF/Hm+ohGASJXbj5EMMXYJyHRqmr95Tivb/cWnqZ6X/U+bsSmuvHklIzxXnDqqwG/fcMKRfX29Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716433878; c=relaxed/simple;
	bh=JshyzCH51kHzKZCaYPg6ron54107HUg1skAOCvKn1GA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qT+nEYo8ajGG28DeNC4xUqIQAG8gEI3+86nhqPgTujRlwoRst39+LvoVAw6R1wFUmoIDRbdN5NeD2qpGj39PQSyWUmxIYMazi4ksTXYMJpC/mmvRIC8z1yQ4qwK1AGWdJxM0KlW9igl4YfDm378ov6L3gDjBIMo7uLte4YQigcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5UWh4VU; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716433876; x=1747969876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JshyzCH51kHzKZCaYPg6ron54107HUg1skAOCvKn1GA=;
  b=F5UWh4VUnNr9gG2DAu6tQ1FP/s8ZuZfFOInFvXBBcgSmtrtkEMFWw5LL
   e/YJho1el7WAc+g0I9mTXcOMfSZ6A7wxEIbGz4qrfv6mvwAGap1VQ50AX
   kp1vwjcp+wpQYKxTJIYBLnn6fA2B3NfComwtwAa/JARvtCv5DtaNqR6Rk
   yxycwXPCsBnyCXdUuAZMriqCRKBVtW+8/3BXHZ4DT7isZokOeUNrbGTOa
   vGm8l8ySh1M3yzr36U0gtWXIc9NEuUd4oxwNL9wcWL0qDPUbj56zuHLAH
   1cWBuYt5n2B2pv0OZelyHDHlNI5rKpiiaJqyEpqRSw47wXZIXnYeYxi+5
   w==;
X-CSE-ConnectionGUID: 7nQWrECATC2ki+3eHorzrg==
X-CSE-MsgGUID: INaI43ztSkW8eNB8XAgjYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="24131855"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="24131855"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 20:11:14 -0700
X-CSE-ConnectionGUID: +ZnlFyYQTCOfBs/9HT3gYA==
X-CSE-MsgGUID: 9vqWTz1zRr6f2wWxejaIDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="56751437"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 20:11:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 20:11:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 20:11:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 20:11:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 20:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1StSuznGoqDrWJZ2K+4bn5sDX5gH3Lut2Pq/SO0IaK67DqJNfASfKvQX0DMefIwAFtK9y19B0kuQMbgVsjfJKdcHKDJsXLLaj2/xGo8eY1C1bypDmFkdx4szk6PgFOrCT0UvZH2XM67tR+qSiOh3gNJIyrxGqS/aj2zKsWtY0OyiFoNS3Zl3E5tAAFotyt+c4gwYIP9pn3ql8HoKTP6MIekxhfBt0bhEfbblNEQJgVRa3fxFqctUUKj1G6Nz8+Yq1OZ52IggtaRXPNeERjiq+YKl5iBBh2/stWvEvTqargEixFy1zi0ylTJ0y/UMZ79z3mS4rLb2dwgEPam+xNJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JshyzCH51kHzKZCaYPg6ron54107HUg1skAOCvKn1GA=;
 b=LoohQs6T8KrcPpWGcfN1kyfVMP4GtqsB7o25nlyeVOXgLzwardVCKvatGrAoPxKyHrvbfPOJLDShsjXLka5nwWaTNlzN+IueAoywQIc6J18L8aDSpdNrjWpaVknpi02Crf/3WIZDlJjaNi32rKmnke1eF1UrlFGU5AuyUDfZWCTaOKmLJy8vLnnEr5ivdXcvimcTqDKeIVKEKkWbdfEcg8T6TzBmbUs87Z3jLjwdqrDo2/1TM9DD5gvcpg/kFA+XhR8NLZrvK0QYVdjLyeErckzeOlfmwUHTN20duZpNPw/mC2enfWEWP+f2GaLfyFd1gYs+rt04v89Br1CEsSA6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Thu, 23 May 2024 03:11:06 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 03:11:06 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Pu Lehui <pulehui@huawei.com>
CC: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "luke.r.nels@gmail.com" <luke.r.nels@gmail.com>,
	"xi.wang@gmail.com" <xi.wang@gmail.com>, "bjorn@kernel.org"
	<bjorn@kernel.org>, "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "Li, Haicheng"
	<haicheng.li@intel.com>
Subject: RE: [PATCH] riscv, bpf: Use STACK_ALIGN macro for size rounding up
Thread-Topic: [PATCH] riscv, bpf: Use STACK_ALIGN macro for size rounding up
Thread-Index: AQHarArIeseTFgIJskauI1Gs51fBIbGkDPkAgAAYdIA=
Date: Thu, 23 May 2024 03:11:06 +0000
Message-ID: <DM8PR11MB5751D22AF1FF43D1D56F3288B8F42@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240522054507.3941595-1-xiao.w.wang@intel.com>
 <e769b8a5-dd11-4cf5-95bb-4399dd836113@huawei.com>
In-Reply-To: <e769b8a5-dd11-4cf5-95bb-4399dd836113@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CY8PR11MB7010:EE_
x-ms-office365-filtering-correlation-id: d64d891d-a309-4763-1d00-08dc7ad5fc92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UXlhSVVnS2FMZk5tWmwyN1l6aHZmcExXMS9ySkVNc3pCU3piK3A0Mk0wSnV6?=
 =?utf-8?B?TFZLbVphTzNsUXVFaGZ4ak5xRk5lQWZSUHpIQzVFQ21iUjRORGRlZk96OFRl?=
 =?utf-8?B?MXpRV2Q3Zm4yM0RMc2kyalBPT0pqYW1KaW5aQjlIVW92bEJFSlJzdWVZNzRs?=
 =?utf-8?B?NzMvY0FUaWR0NHFWRnhVOW50dytVbUxEdkVuZ0JPakpVOTBNaHRuWFBPWkpl?=
 =?utf-8?B?ZzVLemJSb3U2OTh6MzlyY2U0bGpIS0NiY1ZSTkRoS0U4NmYwWXBVTTZBUXI2?=
 =?utf-8?B?cVRDT2FjajRSejhDSWxYWFQ4d0xaTEJWTU43YTJxTXdFSEVyWGNNTXhxOWtT?=
 =?utf-8?B?NmtVN1BJRmJiVnZzenZkUDFVYkdPakZwc2JyLytSK0RTT2ZyaXc2VENuVERa?=
 =?utf-8?B?dkV3eWUrbDQ3VXZPbVhHZTBBYWFtcFpGdTFocVd4b1lkdUlOZHhsem9VQytO?=
 =?utf-8?B?RGtMUVVQTXF6TTZuc05TQnBua3RkaHJ6WXE4L28vN3VDU3FDZWg4b05TSjNR?=
 =?utf-8?B?aHhFR0FEYU1NSmc2bTVPRmdSRkgvRWFlTEppSnRnSjdTS1pLeGZ6K3paZjhz?=
 =?utf-8?B?L2NVSWpZS2JnNVpPWFZ3SXFzblNkVWtYK29kL3loMWF4R0w1RFRBY0l3aE1Z?=
 =?utf-8?B?M0tIZk5PZkZGOERjdXNuc3hqOUF2T3JFZTlwTzNnY1dHQVp2VTlZYUlhZGgz?=
 =?utf-8?B?a2pOQXo4T0lSd21Xa2U1UVZpUXJWS1ZXRUdybDBlVDNreHdCUVloNERnaTd3?=
 =?utf-8?B?YldQTThud0RKTXN5RGtweHZITzh1T0tuOGlaS29jQmF6R3lRSlZEN3N0OGpn?=
 =?utf-8?B?YzZ0cDBwRWRBbGNHK2Q5NHZmZ3ZRZjQwL01DRTZHUk1pUENTalpHMytjdTFz?=
 =?utf-8?B?dktDWUJvVkFvM3ppaWFQeTJwN2N0Y0IyYk9KSCtRN0RaYUdnLzNvTHBldmFT?=
 =?utf-8?B?OGZhYStRY2tkcWxDVXJyZHR3QUVHSEVhRkd4V0JONWRlbG81Qzh4cWF3Rzkr?=
 =?utf-8?B?ejkwNFBoZUtFVHluSVBOYmh4eWxtQm5iT014Umw1eHhQNEVqVFRVc3VVUktv?=
 =?utf-8?B?ZVoxaENMUVdJcGVpa2w3UEJ5dWpHRDd0bzllNGsrRlRmSms2WTRzS1p3Z3pp?=
 =?utf-8?B?bERWY0xIWWszb1FuNlNpOStJamQxU2dualVXS25VQ0FIZmZiRlRYVzJQaThI?=
 =?utf-8?B?K2JXTnpSK3dFME5ETTdqdlRrL21pYVdYSHlBakZRanJnWEhEV0k4dkNMMjBv?=
 =?utf-8?B?bmJwckZnekhYMm9CV0U1bHhUUzlqa3JnRkE2dVdOdUU1enNhdjdCbDlyazAx?=
 =?utf-8?B?QmEreWF4OW4xbHU5ZWppaXVSVnBvRTZKbWdBUVNxUlpXZ0dwTFNxd1J6NlND?=
 =?utf-8?B?bFllVlpsNE4vclM5bGE2Ky9vR09tVXI0Nys3WklVbVRWYjdpMENaYTZKa2tx?=
 =?utf-8?B?NVlsQnpXOEdrYjd5YUtsNjFKU2hRd29ZVjVCQmg4SnFLZXlSbVdBWERNNjdH?=
 =?utf-8?B?WnBoais4SUlxdy9KTDVaTVdlUjRGRlZzWHRQaFpyZkJkTHdVbmZBeEZ2UytR?=
 =?utf-8?B?TllLUnB5akhDWU40ZUlwSTQvU1doSFpPZkY5VVByY0xBMkxkWTIvRUxwdk5H?=
 =?utf-8?B?VCtobEdoUVNhQ2o5OUFxdDEwZDBsT1FzcDUwSGlwaTJ2Mm1zOTIvQ0ZBUUNs?=
 =?utf-8?B?enEzM1RBQUlTM1dxWFU1M2U3ZUJ1WUgwZENEZDhiL2IvamROVE11WXpBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0xZZkZMSVJTNjFyc2NZU0pEZzZGZUx1NmZzMSt0eTlCVDRvNWxpbE54Tzkw?=
 =?utf-8?B?Z1VtRG9xV2x4c3FES01qZHdZOXBWK2V1L0dqWDVjS2Z2Y2ZSOGJ4WjFrYlJI?=
 =?utf-8?B?aUpudnNiOGt5ekdXZTFPK3FJSzJ5bWozeitseFExSVE0SVRaWkQ5K054bElw?=
 =?utf-8?B?ek5iZ200cFFQcFZQenBLUjd1RHFxT3lKRUVKRUVhWjJwK0R3NlJLYlVIOXdh?=
 =?utf-8?B?eVQrZzl3SDBNU0pJbTFwR1hZQW5uV1lPN3Ivd0NUUVZlNm5CS2ZqNjlMMUhQ?=
 =?utf-8?B?NjVOdWlZdEpEUEtCS2tBR0JwWkFHOGhzSTVrMEtEK3JqS2VyZzlKZW1Fd1Bv?=
 =?utf-8?B?NFpGWTRaUzRkRXpvVCtScjhLUzdqUEtCNjQrbkk5eDh5V1pwTUc0Uk1HM2cy?=
 =?utf-8?B?eVVBcUc1R0tIUkEzWC9kTmdib3o1MTJxT2xRVHVWVldPS3RwZDBPaytmNjY0?=
 =?utf-8?B?ZE9FRnNaKzlNRXozOU0xQndvd25XZGxGSXltWG1EdUowclFPTnNXaDNlb0Nl?=
 =?utf-8?B?N29FS1dqc2tUQU9VY2w3VHU0ZHZ5Rk0rYVRMWDEyVWg3eDhRQzBibElBK1NW?=
 =?utf-8?B?YVp3R3pOQi9aVk1KcElYWVdORHBabDFxVlczcEJhNkxFU0F5cVRJdTVucEw1?=
 =?utf-8?B?Z2tWdWRkV0pzdUFNVFcyckRPbDAwaXNLbElKY0lnbFBaREw3eERGbnlHR3Zw?=
 =?utf-8?B?VnB3UGptUGpnWURqdDNDRk8yNHowRkZ5bnNLWno3Y2RhSldaeHZRTStzVW5H?=
 =?utf-8?B?dDZKb0VIYzl3Q2w4akgrOE56M2pCMFQydHhrSng3dFMvNkp0ZTJWNlJMUk5q?=
 =?utf-8?B?dldwUDFkbGYxdG5nMTQ3OVBmVGd4enRVTlB0SHVBdmFTQXNKQk9HVXpaVkxT?=
 =?utf-8?B?b1E3TVNZemRBVzhTREdPM1RBcjdOdkFnMGJtTi9rSzRyVkt0M05uLzJ2TWov?=
 =?utf-8?B?bE9nVlpETEZITDJHak1NeVBCUE5OMG1nOU1MK3pmQ05SSEZpWGtBZHIvS3Jm?=
 =?utf-8?B?RWR6aG1nZ2liWVZxYkdUeDhUeW9ya1pRRVNNU0NydDVNVzk0SERDNVpuSEFa?=
 =?utf-8?B?ZkJ3WlZ0aEtQT3U0eDBzQy81NUxFWFR0L2s4MW5SSWRnK0NMOEVmVDZMd1Ix?=
 =?utf-8?B?RkwyTFRBU1A5RFJDNkt2ekFTS3VFNFR5ZW1YLytlcjRVS0tSMEI3ZG9hSTJn?=
 =?utf-8?B?UDNsZ2Y3Z2FlclBmdm1GNDlHSEU4UEp2bUVLOVp6OUNNeEluVVZNZ1lWUWUw?=
 =?utf-8?B?US9ES2JIMkRSVFA0Zlc4Qmc1WXVVQTNQckVzNEZGbFBITGE2dnV6akU4MWpa?=
 =?utf-8?B?MTNtQmtjdGEwdS9RTmYzaHpUZGVMN2NYYmZmRGx6ZGZVQUF2Q1BGQjA0R2kz?=
 =?utf-8?B?R1M0a2RyK24rSXZsSDdXbkFVek15RVJUcEVseHRYSjdDUVMrNUp3dEpJOEth?=
 =?utf-8?B?ZGZzcEJaMVUrczY4WUFSdkkwaXZwekM4NWVuREZsZmR5UEh3OUpoVndmWi92?=
 =?utf-8?B?ZDVGR1cyTHFjTkRsLy9MTjVXTzZvanU5b1pvb2Q1MnhxVVZSSzVjdlpGMTVp?=
 =?utf-8?B?N3NGSEtsdzNOTUorUGJaS2E1dWFzeTNKcEN2OGRtNlBPMWZJbWE1MDlYU0hP?=
 =?utf-8?B?TTBITElteFlpY1pJaTVuRkdDNDY2V1BEL1lNZUJNSHgyUE5ESE45UDBTSTlW?=
 =?utf-8?B?aVhHaUIzVnJXbGtDRmZaUzVWZUpvSE5JM2ZlN1Uvb05IanJCTnY2bERpSXdm?=
 =?utf-8?B?SVBCQTN1Q3B5c1J1dXQyeDROeEVIZlBRbWlWU0ZMQkRYM2oyYmhwRU9DSzhY?=
 =?utf-8?B?MkdRTXZUbzNqU3hNb3FXdllBNG1hZUJ0NWpwZW9zNkx2ZEtmTHF6VG83NU5t?=
 =?utf-8?B?aWg4dDFPdDZsaFh0OTZYQ2JLNnA4Y3d3SnNlajFESGU2NENUd0hlT3ZJSU5N?=
 =?utf-8?B?cDJsdG4vWVhYbGk2S0dmTUxkRWhTWXNMbXJBQ3RiY3J6OU1jNURuMmRCaDda?=
 =?utf-8?B?YkcwcTE1a3ovUzFMdnV1L0xQcXhKVWFGMjgydGtqazNPSW9tQVJzRWE0WEZG?=
 =?utf-8?B?NDlHeGlNdWVHUmxCSXdLMnJjdERJRHhxLzI4eUd0bUNIZStiSUh1NEQ1aVlm?=
 =?utf-8?Q?LoI9Nf1ogRSYoCxA39Gb40AO0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64d891d-a309-4763-1d00-08dc7ad5fc92
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 03:11:06.3758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVHmfH//1EgyJA0rd7jbbqxNhbq+2Gb4uJ2/jWnRHLOg9R831EyEhuRpHCgfd/H8MqsTw7vfSGmKYotMwP64jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUHUgTGVodWkgPHB1bGVo
dWlAaHVhd2VpLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSAyMywgMjAyNCA5OjQzIEFNDQo+
IFRvOiBXYW5nLCBYaWFvIFcgPHhpYW8udy53YW5nQGludGVsLmNvbT4NCj4gQ2M6IHBhdWwud2Fs
bXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOw0KPiBhb3VAZWVjcy5iZXJrZWxl
eS5lZHU7IGx1a2Uuci5uZWxzQGdtYWlsLmNvbTsgeGkud2FuZ0BnbWFpbC5jb207DQo+IGJqb3Ju
QGtlcm5lbC5vcmc7IGFzdEBrZXJuZWwub3JnOyBkYW5pZWxAaW9nZWFyYm94Lm5ldDsgYW5kcmlp
QGtlcm5lbC5vcmc7DQo+IG1hcnRpbi5sYXVAbGludXguZGV2OyBlZGR5ejg3QGdtYWlsLmNvbTsg
c29uZ0BrZXJuZWwub3JnOw0KPiB5b25naG9uZy5zb25nQGxpbnV4LmRldjsgam9obi5mYXN0YWJl
bmRAZ21haWwuY29tOyBrcHNpbmdoQGtlcm5lbC5vcmc7DQo+IHNkZkBnb29nbGUuY29tOyBoYW9s
dW9AZ29vZ2xlLmNvbTsgam9sc2FAa2VybmVsLm9yZzsgbGludXgtDQo+IHJpc2N2QGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGJwZkB2Z2VyLmtlcm5l
bC5vcmc7DQo+IExpLCBIYWljaGVuZyA8aGFpY2hlbmcubGlAaW50ZWwuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSByaXNjdiwgYnBmOiBVc2UgU1RBQ0tfQUxJR04gbWFjcm8gZm9yIHNpemUg
cm91bmRpbmcgdXANCj4gDQo+IA0KPiBPbiAyMDI0LzUvMjIgMTM6NDUsIFhpYW8gV2FuZyB3cm90
ZToNCj4gPiBVc2UgdGhlIG1hY3JvIFNUQUNLX0FMSUdOIHRoYXQgaXMgZGVmaW5lZCBpbiBhc20v
cHJvY2Vzc29yLmggZm9yIHN0YWNrIHNpemUNCj4gPiByb3VuZGluZyB1cCwganVzdCBsaWtlIGJw
Zl9qaXRfY29tcDMyLmMgZG9lcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW8gV2FuZyA8
eGlhby53LndhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgYXJjaC9yaXNjdi9uZXQvYnBm
X2ppdF9jb21wNjQuYyB8IDYgKysrLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gSXQgbWV0IGEgcGF0Y2hpbmcgY29uZmxpY3Qu
IEkgdGhpbmsgeW91IHNob3VsZCB0YXJnZXQgZm9yIHRoZSBicGYtbmV4dCB0cmVlLg0KPiBodHRw
czovL2dpdGh1Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL3B1bGwvNzA4MA0KDQpPSywgSSB3b3Vs
ZCBtYWtlIHYyIGJhc2VkIG9uIGJwZi1uZXh0Lg0KDQpCUnMsDQpYaWFvDQo=

