Return-Path: <bpf+bounces-45438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F2B9D56F7
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 02:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4BB282C1E
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 01:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE2EBA34;
	Fri, 22 Nov 2024 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RK56oF3U"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C367469D;
	Fri, 22 Nov 2024 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732237497; cv=fail; b=UpdhQB/0HmS+nUeXr9hIyRoJPweZGcFjb30MEg8qfUBzAAGh+QU4n6xS1XUUuMOyrvwOQ071Pb4slU0Dx6WAESs4/IvqmgHhwAr/3CV8fVkvGmuhqinm8uCHgI5DY3/nHp6vj6PMmWtGItvf+sEffgG155VROHEXVN+Z0xpBT6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732237497; c=relaxed/simple;
	bh=a2ifA98AFJwHoHyHHPSN2hj/356RGEovCu+EDnXynYs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DfAm46zuSIDvLXnZstQVGtxa9Yh/FWHDKfRqhH4Js5QI9FNJjxNsDzZIyuPnYhEEOQiI5Nky6mrCLhOa/enuD6GfU3nR1B901tVZUWVzFhWiEshSIXCSnkx/tXhQ2WIn1aXerVsmfWZCltu9jkzkTgqzA96O5dHtb4NeiwjW0NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RK56oF3U; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732237495; x=1763773495;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=a2ifA98AFJwHoHyHHPSN2hj/356RGEovCu+EDnXynYs=;
  b=RK56oF3U/s039QhyUGBeErKFAvAaiKn326UMTVyFA/0Iq8tM7CTDzr5z
   tmgA7XaQen0thMcjDxY+8JaKiof8GHrNlg85RxGyUJyRXzuksR1dER55H
   s8wrbhU0EonVCQrbYFTmI3G79u0VaMM+wft8S5z76sgyfGTTK8WYKIdnP
   R7I+eFiVWl9kCBiz0rEigi6kfEFwzd29ZpapcmcFn+TVhkcuwyf4+Drxw
   GBasFXT6NmxqublBTCKFSKon8/pKo7FqAQrRbNjrgqK8uYLCV6OyQRsvW
   a+5kxpKaKw1Hlj93oaxOJrDgcKxF4T/nFs1KKI/XqEifFsoNOWXhJLTSs
   A==;
X-CSE-ConnectionGUID: HAjSJQLARVi7AcuTGPcx3Q==
X-CSE-MsgGUID: J9RP2EetQMazHFpq4vuzPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="36287324"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="36287324"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 17:04:55 -0800
X-CSE-ConnectionGUID: 8WHkzlC+QlOR18TmedaK6w==
X-CSE-MsgGUID: OvCnP+WASaGnD6v7nJGrlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="95503165"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 17:04:55 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 17:04:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 17:04:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 17:04:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xl//qyy8EthW8hawkOSf3BLrOZCuv925Jokd0fiWiO7HCbySOKDftormHFOM0rE98bgD9ZS7p04vjNackh9MVCX9alPW3cg6DEnZRots3Lit3bG8OM6CP1XidMeEX9GYCeENnO/Op8RJ56zn3H6GIboem+V5m67xS5ibbaFOSt05oFwqyaFq+9suXfuywkdKUbNJI3gckZ5RYQotf3m7AvFlH1jwhpbZR1aiNmjrdqp//jlLa9YAZTjt2xlT7k+0RvwZxqOVHgooxcjHWfGbfJ3WNAPTTPa9m5AchITtHqpSwauyZLFroayNYb7D+TOpGD4plyXOVR3C7y8kAVWWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwUW50ngjpj6Zyt51cC4IfzMK7gkxZ1GzbfPfH8h54w=;
 b=aZIZxBQSrJpO0xssTNtrO5wkpa6Po6XTgxDZCREmvnesS+DFWfWW+TruvEuIOo7GOISBXv/yQTtUOlQKlEjRmNIkcmjyjezrP9mWnI5vwdGZ+O4H/VeLu8cjT9gP51sbkXCAYZzmOxe5Ep52ahO0NskUfqZbZ5S1+RLIaRadeOyxt2dGyV9yKo0mPSbA0R4OguMHjODMdkmZ/oql88vYLDehdpEhjtpBD5wWi71+Ae902wQfEEcVw/JYnBkSgV49vcHcIP5Z4QliwU2aIWMT3UXmW1bn6d2nyDAGqfuHPl+ACU1wMXVNYZlhDVxDLTTYScEB5iL26GPu0SmNNIipfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 01:04:41 +0000
Received: from DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3]) by DS0PR11MB7444.namprd11.prod.outlook.com
 ([fe80::fea8:e53a:7a96:7fe3%5]) with mapi id 15.20.8158.021; Fri, 22 Nov 2024
 01:04:41 +0000
Date: Thu, 21 Nov 2024 18:59:38 -0600
From: "Olson, Matthew" <matthew.olson@intel.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: Improve debug message when the base BTF
 cannot be found
Message-ID: <Zz_XeumgS28UAYaZ@bolson-desk>
References: <Zz-uG3hligqOqAMe@bolson-desk>
 <CAEf4BzY8DhvdgRg0GKEfhJ1HHtFGhgDqVNG0B8F6FAyd_c5+0g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY8DhvdgRg0GKEfhJ1HHtFGhgDqVNG0B8F6FAyd_c5+0g@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:303:b8::23) To DS0PR11MB7444.namprd11.prod.outlook.com
 (2603:10b6:8:146::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7444:EE_|MN0PR11MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a52ddbb-f491-4965-b86a-08dd0a91a4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU9tNmZEbjhnMXpmWitzZmRLN0ZDQjNSaTVFTUF0bjZ4N2RFYVpaMFNrS2I0?=
 =?utf-8?B?NXN0Z2NKUDFRMkNXaERqaXlKUVV6UVZ6UVRRR2JmYVhnOGIwUGVFQktQVWhJ?=
 =?utf-8?B?VHdLN3FhRVgzMnQyYzliYTRDVWNsZmp4Q1BFd1BEMmpGeW1NWGJwc2ZmZng4?=
 =?utf-8?B?TEJvMVZiMmduRkJPTE9WTFhsYm0rNGgwaHFXcWxxblE4U0dCWTJ4RFFmakpN?=
 =?utf-8?B?UmQrdSsvN01MRGppUXdSRTRRQzlwR3BibWlFRlluTy95ak5rR29hNlB3S2Fh?=
 =?utf-8?B?SmpiTVdwaEVKbjRLY01wMnErWW5OeHNFM0VIOUxwVUxtOGxGa1Yzb1h5dWNy?=
 =?utf-8?B?RDR6dFprNnJMN1RXd3JBN2x1ZDZaNnFZeHVra2pCRU9HV0prdlFtZHNrR0ZG?=
 =?utf-8?B?bEl2UitDaWVzcjBkMFpNajlnK2o1WVhmNjBtQVdTd0ZNMGZMSFVxT01ScHpy?=
 =?utf-8?B?dTB4WVN4emlqM1NxdUZpRXlqQUxTUGgyV1RzdHFVNCtLRjU4Yk50enlDdmpt?=
 =?utf-8?B?b2pMd3dLOWhiZmt0VjVVQ1M2Wktkc0hOTjJ0Y29IOXVhVWpwRWwweTQvLytE?=
 =?utf-8?B?Q3ZkSXJDV3BaeGd0Z3JYdkVnb1dweXYwNktKY0lRd0NKbmVYbWt0bDFoZ3RQ?=
 =?utf-8?B?cHFFL01kV3gvbEEycmRPY3dZcFNNdXBvR00yS2ZPTXVQa2E0U0tFUXFWd254?=
 =?utf-8?B?ZjNkSjVNWFUydTRXbzRzQzNweEl4cFBlMVJMNXZod0NtcEo3ZDErYXIxZVRF?=
 =?utf-8?B?cmEzZ2s3bENxWVVadUZ1WDd2STFzdVplcHFYTEtBQllSUVlOaDVxaFVBRnBG?=
 =?utf-8?B?UWVVa2xSN3BGeWM2emQ3VnEvb1hSTTJDRHA1dDZ3dldRS01BZzI4bldCTUJB?=
 =?utf-8?B?V3Jxdy85UGp1bzBCR09WTjBnSjUyRHlpazdGUG5DTjgxV2t6VjZYWHBPVWNa?=
 =?utf-8?B?WFd3d3NER055QWptdTVlb1NweThjRGo0bHlxZHJYQTNpTm5keU94RExCL0FS?=
 =?utf-8?B?TnNlbWoxUWZEaDNyQ0l6SUUxZ0hUS1lsYkJ2Tm91ZjViZk1CSW9IbXlXa3FF?=
 =?utf-8?B?RmtZSU5aWHdlQ1lzU1ZWUDdVSWhtaTJjYjRJZkF5eGYxeVNudW5GTEYwVDV2?=
 =?utf-8?B?dVVIYmZiNGJxUGkrL1VIaFlHUWQrbkplMG9PTHJGVEZEVnJYMXhaQWdMcEJr?=
 =?utf-8?B?WDczN3N2NWpWdVBUdDduN2lGR2Q3WVlCV3kzcWRFVkE3aTVYWTRjUmFUTE5a?=
 =?utf-8?B?cmdvT3VhM0NpQlUrSmd0SGZPR0UzT1FNaU1MUGw2RGNwSDZrYko5c3dSNVg5?=
 =?utf-8?B?OEFIaVRQNWVwOW9UYi84Zkw4VmZERFZPbFRCVzNTZ0ovUXhxUEkvdFlpYVU5?=
 =?utf-8?B?MEJyM2poNmxDazVkN0Q5NGNKUkNVa2g0bEk2elNuZHJrb1IyZGI2ZEFzMGdY?=
 =?utf-8?B?UGN3UWZtSFZKNlBTS3VzVjV1WFlOM3BLK0VaRU5GVHc3QWgva2JORWdnTW1x?=
 =?utf-8?B?bVRYRi81WElQNUw1aXljUUVLOVJlWXRyaVhscmVwZCtBZkdITm1kYWtWMVdY?=
 =?utf-8?B?OThXMFVaV1pKYjRPblFNWDgvUi9zMUM3RGlTaHZ4WDQrc1o0RmpPQWRQb0R6?=
 =?utf-8?B?NGZDV2RjWXVIekR1aG9rRElLZmF1TDRpZCtZZFpoTWlSekIzTFliY2xBMjNX?=
 =?utf-8?B?MExvTFNlRGljQjRJcU1zUGEwSGtWWlBlL2ZCUWsydVhFdGVWcnU3ZXNyeTdM?=
 =?utf-8?Q?Qblat/LErZarck3r8ypvVE6iRpLK4JvXvb5NySF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWlKZWpXYWRybjgzWGZvM2RxT3RtdktPSXUvTnhoZktDeTFRVHlZVHBteDl2?=
 =?utf-8?B?dGFCT3VCT2N5cFBRQ2xNbzUyMktrM0JqSDdzWHBpeEhMbXF2NnhYYllpMVBx?=
 =?utf-8?B?Z2RpemRyOVVicUl6MG4ybXVDdnUxMTRrb2o1eC80MzlaSTh6R294K29iazkv?=
 =?utf-8?B?Qk91RGtqcjRZVHNYdFRrbTBSOVhUODRjYXNSb0FtaERLSDRML1Q0Ky9ONGdP?=
 =?utf-8?B?UEVHanpMWEowK3JtcFoyY3AxcGgzWm9EcCt2OWl3SXVxdkFMVTJsU1dYSE5Y?=
 =?utf-8?B?M2dkRU1JY21Hd2hGNGo2MmpIMnpoRlhtVHRnYlp1SXZFdCtrdFN4bHhUelRa?=
 =?utf-8?B?Qk5ZazFUWEpIbkdnbmVTNHZENEJOU1A4UmltLzlDeEl0ZlEzbG1qRUdLcFNw?=
 =?utf-8?B?ejI3RENHMG9qU09BbHk2aTRDWDc3YVMzcHBadHFIbnVBY3Z0MDA2M3FQOWNI?=
 =?utf-8?B?eWZ1ZWdRSG9BaUorK01QbjJuTytpSy9NSXBxS3pzSktJTXJKK0dBTHQwYThh?=
 =?utf-8?B?Tm9OK1JkOHgyRkh1YmpoV3JFTXQyMHc0WWY1bXpHTmxhbVlpWHpRNUI5ZWFL?=
 =?utf-8?B?MVBUaUdvd2VOYXdYMHhvTHEzQUhBNWdmbHhVYjM3Ymh0RWFtMndJWEdzaTEr?=
 =?utf-8?B?WVNkUk5KcGFlendtNVp1bzROK3B1N1JvWnBybm9HQk01M09nNDlHalpPYSsz?=
 =?utf-8?B?VTdlZCt6d1Iwakl4MEE4ZWVyeTJ0RXEwek5pQXcxY3I4VHFQRER1cjRxRks0?=
 =?utf-8?B?elUxV0pSZWpGd2xuektZa3pndFRJR0d0cVlPQ2xhQ0JlcFdQbmhwdSs0aTA5?=
 =?utf-8?B?dFZEbFdodlQrM1JiU2ZOMlFlTlBpeHlwUVh1bXFrd1RVUHVjTUZuRHpMV2ww?=
 =?utf-8?B?TkQwbWQ5cGlEeUUxVnFWY0F3UlJ6MDVUQ2RJUXNhZkd2eTdRNk52R0dZbEJ3?=
 =?utf-8?B?U2x6dHcxSW8vT0dyOXBwb0ZBRmg3ZkZnYTVDRzhCZGFUeVRYd2d3bTAvdVVZ?=
 =?utf-8?B?MzlEYmFSMG12dHI4V3ZsN2dGYXdLN1pGWk41ejJpWWJ6VDJtenlVNkNlYU9P?=
 =?utf-8?B?dElGU3A4c1BKSG9DYlhreXRPZjlpT0FNMGZBRGRqTG43azl6NmFZMi9CeTl0?=
 =?utf-8?B?eFh2NjRaeHlhYzYrM2Nza1M5UEsxV1JXbXRzMmcvcVFWMXhtbXpSNlRyMDFv?=
 =?utf-8?B?czJiVy96Wm5LbFJJRHlUbmtUeDBoVTZBeW1JdWdnOGFxNm54SWx5a2E0ZkJ0?=
 =?utf-8?B?dGJaUjZPVnV0ZS9lTHlDcWI0T3dWWHRXazljcVUvSG5Xdm1JcWdOM2dGMWxx?=
 =?utf-8?B?QUpFVUdFblBPU3ZzdGoyb0lyMkF6YnlXQVZ4SnZHSFRXbmVyQjllVGxJVTBn?=
 =?utf-8?B?MU9DakE3Z2JZNUJKaU5XeWNhMVRhVzVhT1hwN3FqdXBucVBBdjNYalZHRElU?=
 =?utf-8?B?ZitjWUE0ZmRlVjF4Qy9UNmdZUHlZWjlzUGt3S2c5S0VhMjViQ1lEcFRCOU9H?=
 =?utf-8?B?NkczYUFSMml6VXFHYXNOVDFuUUZPUmVIWVlQWDlnUnl5YmZMeDRuU2ZiaXBZ?=
 =?utf-8?B?TC9OQ1h4ZXFNSU9BRVhhVEJRU2FiQ1QrQUQ5bnU5S0xoTENiMVhxN0tUR0g1?=
 =?utf-8?B?VGNjcEpKVGFxQzAxY2tCeng4a2dZYkZhajJNUlpQZlNGRFBDZlJxTFZFeWFu?=
 =?utf-8?B?T052dHlLVk93cE1CbVJuNGZOSml2S21vdll4NEpkellFMmcvaDBrdlNDYUVr?=
 =?utf-8?B?MVJjRzRaTkJhbzA5SHdhTVh6MVA2a2RDYlRHNm14QUdic0ZSdFdYODBMdUhF?=
 =?utf-8?B?di9DbjZ1UHJ2MTR4UjVQRkE1UGJmR0kwVDJsdmhScE5RQnBEMlVPNitOdGhh?=
 =?utf-8?B?Rks1ZUpra05VRE51SXE3eXNGVVZBSkxRYkFvZ0lBZFpLR0tYSCtsU2NDUG9S?=
 =?utf-8?B?dzc1bFRvTHMzdS9TZWY3N3drT0cycmhicXZsSGF2WWN5S0tJcGYyVFBLanNX?=
 =?utf-8?B?aTZabXFPdERWT2hKZ3Azby81REhtK21OVlYycGlkY1RpR1NVcXBqVzRZekpH?=
 =?utf-8?B?N0JqNDY1TjFCK1h3Z1VuaFBTeFZnVmxQNzV5RXpYaW9TTHJZTG12ZFBubkJy?=
 =?utf-8?B?RGh2Z2gwKzkybzVmVE1ZbVNUN0VsbG05dTZBSzdzbXBRMXU1aWx6WHh2N2lV?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a52ddbb-f491-4965-b86a-08dd0a91a4d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:04:41.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PaO8IxSw8nIW4iGQsQCf4Q7tvMosHOHhttzBv19bbLpH1aBp3k7rPP/7XTjztn5RoVYCL+Wk6zOhPViaUvmkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com

On Thu, Nov 21, 2024 at 03:55:15PM -0800, Andrii Nakryiko wrote:
> On Thu, Nov 21, 2024 at 2:08 PM Ben Olson <matthew.olson@intel.com> wrote:
> >
> > When running `bpftool` on a kernel module installed in `/lib/modules...`,
> > this error is encountered if the user does not specify `--base-btf` to
> > point to a valid base BTF (e.g. usually in `/sys/kernel/btf/vmlinux`).
> > However, looking at the debug output to determine the cause of the error
> > simply says `Invalid BTF string section`, which does not point to the
> > actual source of the error. This just improves that debug message to tell
> > users what happened.
> >
> > Signed-off-by: Ben Olson <matthew.olson@intel.com>
> > ---
> >  tools/lib/bpf/btf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 12468ae0d573..1a17de9d99e6 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -283,7 +283,7 @@ static int btf_parse_str_sec(struct btf *btf)
> >                 return -EINVAL;
> >         }
> >         if (!btf->base_btf && start[0]) {
> > -               pr_debug("Invalid BTF string section\n");
> > +               pr_debug("Cannot find base BTF\n");
> 
> Well, the check indeed checks the well-formedness of the BTF string
> section. It is specified that the first byte has to be zero ("empty
> string"), unless it's a split BTF.
> 
> Base BTF being missing is just one possible reason for this condition,
> so I'm not sure if it's completely accurate to specialize this error
> message so much. Perhaps maybe emitting "Malformed BTF string section,
> did you forget to provide base BTF?" would be a bit better.

That sounds much better; as long as it hints that the user should
check if they specified a base BTF or not, it's good with me! Thanks.

> 
> pw-bot: cr
> 
> >                 return -EINVAL;
> >         }
> >         return 0;
> > --
> > 2.47.0
> 

