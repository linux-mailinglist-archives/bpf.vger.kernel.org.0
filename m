Return-Path: <bpf+bounces-55997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF14DA8A5E2
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F417D44396F
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299B92206A6;
	Tue, 15 Apr 2025 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHfvWSGl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5338F7D;
	Tue, 15 Apr 2025 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738956; cv=fail; b=qwaHotDxaquQhnA4T2fTr5/kg8n6yCh0tMeGj5fho0gnNKXm2+Kbl2KkdmS3br/2GcE2o8E9QAlmeciXUkQe5muc5lxXbagJgWFQTDmD88AFCt8Z8jbvbxTTOReD150CzFawnyMt2z5tgpTRMdt8BAOoXmXraBPN80sl3xqWFQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738956; c=relaxed/simple;
	bh=44PzqW9Ay72BAL9LFocUkvg1BNz2FTbtOhD1rny5WBY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YK/76GcPNJlm2IBOOdIo6QSVmKOnqKkeF+X+TxUogGWYkUCUJ3LmzPSqiXYZU1K5ulp4vXQtQOYBfj0H4W+MeRtmbaH0nMKLEd2fVHjurtjnsqiKlmoEd6/1J50ut/VnqtIs2rbpEpFB4DLOIC3FD80/JRRiNML3BKtJCDLHcrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHfvWSGl; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744738956; x=1776274956;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=44PzqW9Ay72BAL9LFocUkvg1BNz2FTbtOhD1rny5WBY=;
  b=AHfvWSGlCEcWTS1V0IBrIWSkaf1dYEiV+sJP832r1Os+ryAiMT9SedQI
   XVysDfUFD96Co/S352nF6FjvW/j8LGlHqht5hSXI6soLmB6PV07Frt09v
   STdxZjeHSVDau+nAS5D0WVl1ey6EqWdKv/nMC/HnJQdXfCYMePEW9yR6f
   nRqZPGoAdNuf6Dw/Rxp6c9mMn0cQeZRI9EwLuKnJRNu9yO3wW85WJSnPj
   B51Rr+ly7e0T+p7TO7OVtv6vZSBKfSDMSoVNx6Oi4LLJaRw4LqHmY5kHE
   9Dv10Duzu3AIZDiJWIfr4YKXzZFwv7axF+5T1z/T+wUBCf8WLWgaeMt6T
   Q==;
X-CSE-ConnectionGUID: iIQnfHzSRtmwYF+bqzVAwQ==
X-CSE-MsgGUID: SzQV1Wu1TLS4V+mCL+mn8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="63665257"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="63665257"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:42:35 -0700
X-CSE-ConnectionGUID: CUzYZ+JyT0K6H3f+QShRnQ==
X-CSE-MsgGUID: VhQCG+ojSu+WFzf1GdRMEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130726378"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:42:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 10:42:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 10:42:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 10:42:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEwmWXWeDMa7loR+ZzxGpypumCtV2WSK41HytSJsMJPDEFsotS6wNGN+xhx4RUXsiEbEJKQttiVY7IoR/yrUhe8dMOGGOTi0JJ2M8oXxl/EXO81S5e4B6ciScr7OL8Hh38Ms830CV57Lgfjbf/zyljXdTOgvpFaDiXpnsd4s0wHlraRQIStFZfttLTQg331Py9KVfKsL/OkdXJoQ6LLdDvE/6I7m5cQijQ+BGp8JdVtH9nGQJT1wvY8wgzzoEsfzOBAsJEuA7bmQWb/mG9TUMLFHFKTU9El6uuZatrANAj05vTU0jXIQ/R7O1oUnokAXijRJ0BCX89Dhj+oj1Kvimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0V8VM2vyr//jKthe+a2qM6YYsx0QqQUIBlQneciM9E=;
 b=nYvm/8GR/Dtyr1/pgV6/RdM9giT5uQ7yVKr8VaEhmTF/q14P65sHblR/GHUTfwIUruoYUxmvB5SbR299vuf5S121ddsu82TmBt1AOqyrsSPH+XUVC3VKJYCrP0m5f5LRq1bgQgnXwObOdOhro4rsvVCbEKpGjV5px7K6gpnblghjcZl+7MBtwF3mx9SNSxGzV4Z9dHu6b9gsMtHMWXLlVJi1X+fHXKlXNjHlcEfTs2TLkkNL9sdScXTsZ0+GBQnc1iKQ/GEJZlV+FQ/87xo2mmfxL707j452K8mrNwerdwKaZri+BpiT8V2MmLYwyMFq3ysrm7iZcstAJX4+ELtw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 17:42:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 17:42:29 +0000
Message-ID: <0cd1637c-91b7-4029-b3df-143b7c9e02ef@intel.com>
Date: Tue, 15 Apr 2025 10:42:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/3] net: ti: icssg-prueth: Fix possible NULL
 pointer dereference inside emac_xmit_xdp_frame()
To: Meghana Malladi <m-malladi@ti.com>, <dan.carpenter@linaro.org>,
	<javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <richardcochran@gmail.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250415090543.717991-1-m-malladi@ti.com>
 <20250415090543.717991-3-m-malladi@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250415090543.717991-3-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0343.namprd04.prod.outlook.com
 (2603:10b6:303:8a::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: bde7e469-4527-4641-dba2-08dd7c44e4e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjJVeGJrN25qSzJUNGxLSEcwV2pmc0R4SXJiUWtSenhDcDdOK3pSWUtKa0ZQ?=
 =?utf-8?B?dk9hRTJSdU8rNSsyU1FBMlpLZTEvY1ByK2laUGtwS0dmaFRlWnFIckU2aHkr?=
 =?utf-8?B?ZDFRME53VU1JdDFtTXkzSDJSbS93bWQvUXlQN243UUlLS1FGcWd0QWdYV284?=
 =?utf-8?B?Tm5PQmJsc0VNeEIwekcxWkhvcHVTNWVjY1c1cjNLallLV1MzZlRVVldrN2cw?=
 =?utf-8?B?cVRlMCtQOFJBbXN3WDdrN01QL0VWUTdKZjRJSE1XV1BINVkvdEpHVDN1RTA5?=
 =?utf-8?B?cWdxdzdOWGpQTm9RNnBUMXl4cVd0bzhlWFE0ZG1XRzZ0RVhGQjdjQjhCSDN2?=
 =?utf-8?B?U0pBeDVXcWNyaTBHeU5kRG13bHpqR3ZaTHluQ2hUN3VHdzN4TUN5b0pSUUhE?=
 =?utf-8?B?Tkc1RDRCbmZwRzRnTDVZZUpOR2xpMlhMS1dCR3J0WElWQms3ODBTSVJKdDNX?=
 =?utf-8?B?SzlIcnR5NE12eWhHTjNDUy93Tzk2SWJzNk9mSEladHJsNXZQTGZpSm10SFZz?=
 =?utf-8?B?YmNKbjk0UDk5M3FqVjFiYlRDT0xucGxBMmJUc1d2UXFkZFV2SWs3aUR1aHp1?=
 =?utf-8?B?WUlzd3puc25XQnF4c1hpRTg5SUV6dGRyb0VweWFlaFdKRXNzZFpQemwwRjNy?=
 =?utf-8?B?NEFsd21TblVKVkFaaERBb3ZBdk4yMmtsWUQyY2hGeWMzbmV1WWNNSlIrSU10?=
 =?utf-8?B?NnRHVWdJbjhDcm1ackMydnNReXV1T2ZIY3p1bmNhdTVaNHBJclpwMFI5ZDhZ?=
 =?utf-8?B?ZUhFZUcwMFlMeFd3QTh3bkZoWmM4bVJ5V0lna2x2eE1vM2xTSEt1dm1RRFo0?=
 =?utf-8?B?TjlsVCtCWW9abGhUMzlKN3Rub2s1WHhwV1FDb1VoUTMzdENrY1o5S0pXOXVj?=
 =?utf-8?B?eU9OMUhkTThsY2pEbnViZ2dKZmVpaW8vbHRoQnRwbTN3eGZGWlgwZ2x0dVVT?=
 =?utf-8?B?dFhsMldPdEZ0MXJ2eHlpdkp4Y2xpSjdtcVJHdFk0dE5pOUNrVDhXNG9CRGhv?=
 =?utf-8?B?bHBWa3I1eXRoNWVIQ21LRTRYVkNaV2lIVmFCU2JJSlY5NWtEdEhrU2VsRXdm?=
 =?utf-8?B?ckVKYm9rRVQzZjBXRGJDaHFjWk5zRWFEandPL1lzZW5keUFveW10eEh4L0lM?=
 =?utf-8?B?Z3lpSFFVUGY0SlBhOFhCN09lTzR0QjJNVnZQVHdURHNVTjJDeWozNnltNkQ4?=
 =?utf-8?B?NTBzdTlPT2F3U0gyQ3orK3A3TEtHOWNmK0hrQkd0TjUzRlJzQ01TNi94QXl0?=
 =?utf-8?B?TXhHcnFsQ2pTcmtaM3cxZ2JSWEVXTXQvVXdjR2JhS1RWZzYyQ3FMWk14bWpD?=
 =?utf-8?B?TWlza3lZSFl1L3NxYnRSTExzWTM5TjVUdkdLWXhtRExqcGlMdnRDRFJRVExk?=
 =?utf-8?B?Unk5eTN0enlRbGJuU0xqb3lwbFllRUpIcEo0WGl6UDFmeW1Bb0VlbGYvZVI2?=
 =?utf-8?B?TjBmUDRHZW5CRTB2c25zdHhnMCtSSHpJYjIyRFdZZHRvcHh3MWpsaWVlNGVI?=
 =?utf-8?B?bnNLNWxXNHkzSEoyMW92cW0rMjUyeW8vUGhzZXlSZUF0azlWMTRablZDbkJ0?=
 =?utf-8?B?ZUI2L2MrWWdib3RlWnBYV05qUGpVUFljUUlLMzhQMzY1WXZtZ0ZvZGN5SUN5?=
 =?utf-8?B?amxmM0RweVdzWTdiZ3ZnYnAvWDZxV2ZlNHE1dWxYcXJUQm9OR3o0TnU3SWk0?=
 =?utf-8?B?VHZ2czdKRlAyelM4cUg2SGdnOE1VcHE0MVBvQlFieDFiVUFDVytiUHplSlRH?=
 =?utf-8?B?YWhhMlUwZmVnSXZOV2lVODhMM1hyT2RRMWg4eXE4K1c5cHZLMzd5K3FoQ05O?=
 =?utf-8?B?QUltWnViYnQzb2xrQkRhalBVdUhxRWZSY0FMQ2tMcXZEdjJJbVN3V1l5aWxQ?=
 =?utf-8?B?bVBqRG02N1ZkNTQ5NXFRQ3NOaDZ3NHg5S3o4cUR0WHFPVnRRMkphOUNLL0ti?=
 =?utf-8?B?ejdlUThjQXQySm54QW1oZ3E2Nm5mZW8yd05xYnNGdWRzWTQ3RUc0dHV4Wkha?=
 =?utf-8?B?QS9vOEh6OU5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVlaSXFMejMyb29paCtXa29vMWR2OVNIYWxDbld0dXE5eU1WU3ZIUVlwLzBW?=
 =?utf-8?B?Q0pMUFZZVElSaGFJM28zS1UvbFgwY0t5d0psazNvVUtiZ0hxWkhXM05VYldF?=
 =?utf-8?B?ZURydWI3WWU3YUoxWDJwMFh3K29GT1J4dXErY1BpNHl5aUM4Q1ZsYm1mK3dt?=
 =?utf-8?B?OHRwVXQ5aTBTSzZMeW51NjVoOVI5eWR2Z1NyQ2NaVW11STZYRDJ4ZFIzbmgy?=
 =?utf-8?B?dVN1ZTMxb1Q0SGFLMitac1FkODFPKzdCVlkwclNXWk52N3JDSklGYkJaemdP?=
 =?utf-8?B?VEdvRVR0OCtXUkh5eGdPVzdkY0dmdGUvUmtLZnMwdjhzcjRZWHNuUkJaNkNo?=
 =?utf-8?B?MHBUT05vclZCQVJTTng3U2Q3a0NFZDdHclAzTkNjT1o0QkJnQVZBVGkrVGpy?=
 =?utf-8?B?MVJRRkMxSTlFOFREejRReVAvL21zMmV3RWF1VUx4UEIwSFRvRGkyWCt6dTBU?=
 =?utf-8?B?NHdPcmdzbWUvNklYb2w0bzlVUEd3cVllLzR3eCtJQjQ0ckZlM01BZzdUK0FE?=
 =?utf-8?B?b24rUmdkVDNOSWJzVjc0c2g0L08rb2NtdW1sWHNJRFdhSmN5b1F6SnRHY0kz?=
 =?utf-8?B?TWp4Mzc3WEZORm9FTGhlNWFZTEVWMVd1Z2RWdkNBM05VTlZYakNkZytmcUxr?=
 =?utf-8?B?Tm1vMGF2d1g1U2pHNzV0VnpzMmtrQnBIZThRbDRWTDlKK1BneFU1Z2YwcWV3?=
 =?utf-8?B?ZmxEWk8zVXV5SFRWS3JRSXRBTlNOcWl3THp1UXpTM1dHYlZQNy8vditVNWJI?=
 =?utf-8?B?OXJ5RHFrSDNUNWttWjZNc2cvb1NRbisvd2xTSVpHaDFpNE05WU5mRGRHSHFq?=
 =?utf-8?B?bHhTRVNOVWFmd3psVU9KYXNNK1d3aHNadDUxNll2UkdVRzZ3UVdjbkJGdVZ0?=
 =?utf-8?B?b1Z1dDJTQ3ZtaFJmRlhlVXUrSEkrMUU0b21zOURXdHlBNUNtU292VUFmZVox?=
 =?utf-8?B?dVBCZnMrbnp2VEI1L3hqWXIzajI1YjFVMVM1US96QlJlb3B5a01aaWdLY2pp?=
 =?utf-8?B?RHNGUzB1eTZLUVFCNWtRZE5WMjIxOUJxY0pPMlVEcXpkTHNiY2NYMHdRTjRF?=
 =?utf-8?B?NXUyd1d1TWRiRHN3MmJvemV2bWJPMjZ3eHBpU0RBTjArRStPWGg0UzBGUWVF?=
 =?utf-8?B?U0tXVmRQaGd5TUNJYkZub2VjNlo2aHhBYVVhTnlIWjNIU01xTUhPREg1UFht?=
 =?utf-8?B?cm9aWkFmWDdoM2tsK1JjQmlkSnBtamhFN04xdCt1cmxsUmJCZlNObk9qZ0VX?=
 =?utf-8?B?c2R1aFNWeWl2S0hkNmYvZ2VCMlNLWUkrRlJJZFhyN3d3MHBZdWdtZjVJL1JH?=
 =?utf-8?B?dTMzaWwxOWtiek5SdlhZTjhmeTdLWGpQd0MxcHRTZVNVU005NU9NMWR4M2Mr?=
 =?utf-8?B?eDM5VXh5Ym9HRWgyVit5dm4vZEMyRE5zd3VtTk1sbWJMVjhTbGdGSHVDSG1x?=
 =?utf-8?B?eC9MYmFXcno5WS94Y212a251YUVDRll5N0lWZi93Q0pOTjdmRG9meUlHOGl0?=
 =?utf-8?B?eTkwckJjMHhFeDFURnlBRzdLdXFSSUJlUE9PYXdXbCs3Y3VkNGJRUW9jaEV2?=
 =?utf-8?B?USt6S21vN2FsT0xaTDR2anJ6L1BoaXBDbzF4WHY2WHZ6UTl5dk1kYXJZeFl3?=
 =?utf-8?B?Z2NnTkZOeWZjeFZjT1NscHdBTlFvSVl1NlU1a0U4clQ1alB3L053MWhnQklw?=
 =?utf-8?B?R01Zd1BRa1VCREF0VmpVOXB1aVlyc0VHa1U2VXZra1RSeTl3cFRBWk1LSjZS?=
 =?utf-8?B?WUZPWG1zWnJtNUpwSDQ2M0xTT1k0MHh3L1U5bjlJZVFHQnoyZ2E4LzNKUko0?=
 =?utf-8?B?Q3RRKzhCOEJOVit0OWw2Ukt4eVJyODQ0QVR0WlRqcjA4Z1lrRkNETDlYQTE3?=
 =?utf-8?B?UWMwaEdONThDYVNTWDdtTktwcGsyTWpPNXJHWUZzVFBZSkZleS82a2ZqdXpF?=
 =?utf-8?B?aWN1dzlUMU9WNTNqSmFMTGp3NXB0YnBwZDNHTCsrbGNZMXNXbXFEbGFQSkc1?=
 =?utf-8?B?K1hnamdHN281eEhCOXU1SWc5c3Ezb3ZGQVU1SXVtMnpiaXdHL0lOaytNL3Z0?=
 =?utf-8?B?elZmbVI4bWRWajgydjF3anJEZi9WTnloV1piK2QybHdoS0Rmd2JqTnlQbzU4?=
 =?utf-8?B?VnM1V1prL0VFVW1yT1kvWjlzallacXpHaVNLSFRhZG5UL0xWV1FkYXMrNW5j?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bde7e469-4527-4641-dba2-08dd7c44e4e3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 17:42:29.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4tLcnuwPGgy4NVB5ifKPalbWXlquNufAiP54dgaBtT07VMbFdK2gIRA3sC6dERzUpjcz26eCZCxE+otFWeCEuN/DWJEmgvgtqflZLZFzI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com



On 4/15/2025 2:05 AM, Meghana Malladi wrote:
> There is an error check inside emac_xmit_xdp_frame() function which
> is called when the driver wants to transmit XDP frame, to check if
> the allocated tx descriptor is NULL, if true to exit and return
> ICSSG_XDP_CONSUMED implying failure in transmission.
> 
> In this case trying to free a descriptor which is NULL will result
> in kernel crash due to NULL pointer dereference. Fix this error handling
> and increase netdev tx_dropped stats in the caller of this function
> if the function returns ICSSG_XDP_CONSUMED.
> 
> Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/70d8dd76-0c76-42fc-8611-9884937c82f5@stanley.mountain/
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> ---
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Changes from v3 (v4-v3):
> - Collected RB tag from Roger Quadros <rogerq@kernel.org>
> 
>  drivers/net/ethernet/ti/icssg/icssg_common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index ec643fb69d30..b4be76e13a2f 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -583,7 +583,7 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
>  	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
>  	if (!first_desc) {
>  		netdev_dbg(ndev, "xdp tx: failed to allocate descriptor\n");
> -		goto drop_free_descs;	/* drop */
> +		return ICSSG_XDP_CONSUMED;	/* drop */
>  	}
>  
>  	if (page) { /* already DMA mapped by page_pool */
> @@ -671,8 +671,10 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
>  
>  		q_idx = smp_processor_id() % emac->tx_ch_num;
>  		result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
> -		if (result == ICSSG_XDP_CONSUMED)
> +		if (result == ICSSG_XDP_CONSUMED) {
> +			ndev->stats.tx_dropped++;
>  			goto drop;
> +		}
>  
>  		dev_sw_netstats_rx_add(ndev, xdpf->len);
>  		return result;


