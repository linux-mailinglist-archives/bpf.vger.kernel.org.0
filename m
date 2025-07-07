Return-Path: <bpf+bounces-62519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 040F8AFB7E2
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504FB16E275
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE34D21170D;
	Mon,  7 Jul 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMKtoDXU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7AA20E6E2;
	Mon,  7 Jul 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903383; cv=fail; b=TkKl5t8oserD46sIgO1ATdVEQNGFTwqZOVvLoNrbs3AiqQFnI838Ru1FiFlLQLHsdLonbRp1sEZ/8BtKVeE5S/8poll74XbMRv7PJ9iUkqnIAQmKTUuPONydamCyRbxQKDW9fzjqKUaUSP8NaAjjGnFU0VRsY+S182LyVAkV+qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903383; c=relaxed/simple;
	bh=k0te5gEEi9bwId2ty/aBEKvBMSb4ZevDy7ftFkjoVnc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eve9tHUNHzMYQ8VFZuJgOrk2ihLC7/ITB/dUasX5G9AU5DVZhwP60kMTnQ546lTLc6E4V9gIbUn+grKEOVddRzWXRhbZrNH3ZziY56L78ivYEcj3NkkPKPXjL21jAV0yWE8D7RvqnNEVn8hbFvgIgVZJwk6p4KTGMVlsFX3xadU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMKtoDXU; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751903381; x=1783439381;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k0te5gEEi9bwId2ty/aBEKvBMSb4ZevDy7ftFkjoVnc=;
  b=EMKtoDXUGesU+SgGtoJW0FMD91qIVGdssc3dF5czABzZPt1kJjFVC5Cs
   UMmlbp4O5J+XODGDfE7XRdkTHH2DyCxV00cZ0h2x2Jr5j5igR0514E11L
   mtBbgGlkLff6Ia9nWrKJTjf1hJzpSyvBfg75e4jyZC2kIwFOxsWLninOb
   Tppdo/SlLCZCpidbAely4qeFpGp9+tV9NW8Fo+np+BUZ+ufU5KYkJtyvV
   zyBvW2nNmbbKIjU4HkNzJAnNLZ1cdn2Pjw2P/vqZt55XVSZKwFVDBMfWf
   ZLvjmSu+HZzwNwJw5YJ2Wdja5yHmpjsBIIaPPMlfOUEv9klRs1qTSrdDZ
   Q==;
X-CSE-ConnectionGUID: k5r3Yb/jT6S0al0DQbkr4w==
X-CSE-MsgGUID: tpKeHr6CQaCHFkCDtFkRHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64372139"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="64372139"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 08:49:41 -0700
X-CSE-ConnectionGUID: axNcxQ8cRiymzuPHuxuveg==
X-CSE-MsgGUID: OqMonyzhTU279g8STgylLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="154869722"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 08:49:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 08:49:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 08:49:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 08:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEuLkGtJuHHADDQp8RZ8lIoiH0HHZHZW3sSWUDKbB9VHO5jYSxAQoSECS9Q4MxSGAO8+qeP3Y92VOT2huhyc6JESsx2fbUubUOO5I5oF7JQZ6vOoSgZnohW9OzSd0r6qGgn+vCZERr+J5gq7sRofHlAtBQLsrUyS/LgYFSpIHjff0TiJERPPDy2I74ChPSHBzBwgEWg/BWFPQPqtKLzKR2bbwWq8r1rfuvvGaajMpXs16VO+H9fNTuMB10JeYASACmwalxtg0H3Nzvkw1/w7YZuyW9FeR0CqOAmC4TZ2XScOLVccyqjAq3zm4rodaZr7pVgam7K4X4A+sFea2CoZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ugfih6LHYZwhupYVu+y9d3eN5xWNIAOMzdvBrCIF9ws=;
 b=ncBHiXDJJG3cNYLLIMBIoNqLTGhKmwULDTiGL6GU+qf6mwN1s1K0YdcptjTiObSbj1qippB9D3+Jz3kvh47F1PP3clMhUmXOzkg010Qa/GElSsku9IVe3b4svUrESDKhkyUb3dt1lytUYGTBtJP7sQoK+o2JCDrZV6p/kmiF1QAl4RcKB+IbeuTMlixQt1fIlqBkWKpNk00lRItll/Vk4m9Hl1wrflxB//qxmYDgZOQUEe84caSvzCoSA6OHxJtoRTkN1LeT+iqrfRTr+WgeURS6GWK7GN3fGX8Ayblhzc0zqS9d+VT+LEYpKJnWJv7QvQvX8rWYJoP8OegR4Jvd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB7255.namprd11.prod.outlook.com (2603:10b6:8:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 7 Jul
 2025 15:49:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 15:49:09 +0000
Message-ID: <a113fe79-fa76-4952-81e4-f011147de8a3@intel.com>
Date: Mon, 7 Jul 2025 17:47:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf] xsk: fix immature cq descriptor production
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
References: <20250705135512.1963216-1-maciej.fijalkowski@intel.com>
 <d0e7fe46-1b9d-4228-bb0f-358e8360ee7b@intel.com> <aGvibV5TkUBEmdWV@mini-arch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <aGvibV5TkUBEmdWV@mini-arch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0046.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: f425a107-47c3-417f-f21b-08ddbd6dcfa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXBmYkR1NHJXQm1OMVRyZFZpdmR2c1Ayemhjc29vczhOeVdsTkhNbXJvRjVL?=
 =?utf-8?B?eG9aRTdsYTEvWHl0MzZKTWNXRmhjditwVFlWbUwxbm5FUjdFSTNKNmJpbyty?=
 =?utf-8?B?Y0duSDFUYzlGWm9oNXVjZk52N21xZU9qcThqQkFiZ1lyaGNNYllIY3ZLWXpr?=
 =?utf-8?B?ekhMMkYzdmlWOWlVaVRucGdaMFZ5bmlxcmR5YUhEMmxvWVBoS3VrQ0FYY28r?=
 =?utf-8?B?c08rNyswcGc4TVovdVJacVcrUEs0TGNTWTB1ajE0VTRTS09wZGswMzd1RWhF?=
 =?utf-8?B?VjVDdDRleWl3cTMzZDJ0WGhFQzB6bWQ1WHY2WjROL1A2TkhydUxoR3lzaHBY?=
 =?utf-8?B?MFgvaXc5aGhNMjdYWUNFTExVUUVhWTYrdnBJMG85cmZrN0d2dTA4QXcydXcr?=
 =?utf-8?B?MXlJRVhIbnd0U0NKQktoR2NQLzZIeTJlUzQ0b2lBcXc3TUt5Q2ZSRU9DMEUv?=
 =?utf-8?B?RitHZTYrN1RBcXNDZndhQWk1bmhyZVhPUUNjZ0VFZFBPTms1cUE1aStKYUNP?=
 =?utf-8?B?dlRxbUtMREFFdU5LdXBHM3FUeThIaVJ4VEdYTVhKWDhKQ2x3N3ZkRXNVY2Er?=
 =?utf-8?B?NEtKWFArdzBqNDdOalJkT0N1OTR4YnJtSWVkOTZnM3hwNXRnRUhJN0Z5QmRW?=
 =?utf-8?B?dGpMZUJBSWc4MWU0VkozQ2Q4QWxFWlQyMkRSNnZFekRkVlhCY0FOZGxYbkEy?=
 =?utf-8?B?SXBqODhrOHBJUFJZMDNPMS85SXF5QkVmeXJHZGJ3MTZBWGNyNnhyVnBhRDFu?=
 =?utf-8?B?SFA5UHNxT2Y2MlBLTTI2OXNKWmpIY2YrUTgvRzhvL0h1NEY2VmhYNmpZVjI0?=
 =?utf-8?B?ZUwwUmpRN0VZengyNnkrdi9kTHEwcmNpOWZXc0RIS0JkTms2TnB2N1NiSm9r?=
 =?utf-8?B?bFU5ZERtU1J2dDkyUUxEVWx6N1lGRWYwVVdIZDFIcXR4OHk1Ti9BMnA1SE91?=
 =?utf-8?B?UFdocUVsQ3FMcTlQblpJUHhqcGdDdGRGUzJzNDVaZm02SWNhbkdyUHVMMzh6?=
 =?utf-8?B?VGU5dFJhdnVGNWVtUFFoOU9vOWFZNzJWZVJQcFIzeXU5dHlPb05sOGtxZTdu?=
 =?utf-8?B?MXJnMnErVW9GY29IOXFRTXhwNHloWDMvcHBhSzkvdzhYdC9RbEI5dzdTNFNU?=
 =?utf-8?B?TTI4Sm84WmpEL0I3U0N4WnE5dyt2Ty9ZMmFSMFJqTWdCWGtKN212SjlGQzJW?=
 =?utf-8?B?S2lqT0RKZk5LM2t4aU4xajhUdEl1Vkg0SzhrdXk0MXdLTVU2a1VvUG9EL29h?=
 =?utf-8?B?NTBhYzg1TU1pWmFWNEx2a3RRUXdOS1p6ZG96M1NFSFN6cmdPK1dQbVVVV3Zp?=
 =?utf-8?B?NkMrT0ZoeU5hOTNmaTZkRFd6WWpKZ05OUXNMR0ZDV040cm9kUGp2N0ZQSmdk?=
 =?utf-8?B?d00vYng0eCs1VVhBZm85Z2I2Q2UwOGUyN2hxRTBYY1F5ZklsVjFOdXRWKzE1?=
 =?utf-8?B?VWNCMk5ZY1pKWnFIdkRYaHR4S3o4MTR5QVV5TW5TejAwSytsRFhMdHA3cFJJ?=
 =?utf-8?B?QzJaWUVyb2Rab21JM1ptWEpPWVZ5T01lRjBEUms4Y0lDdmZrcVFaY0JBb1hJ?=
 =?utf-8?B?a0N5bU92OXlNOEZIcTBxZWpXeW9aMERUNGhZSFRaRndhRjZZZXdTZi90bEh0?=
 =?utf-8?B?M2luVzFEaXFBaGlacmFCYXZRdmJyVHRUc3prM092QkMwKzUrUGlZbkM4Z0Ri?=
 =?utf-8?B?VzdVWjdhUFRHV0VKbnBnRUJVbjFIcklRaVVVejhWVW12cmtjUE5JTVZDM0d6?=
 =?utf-8?B?dFFHaWxocm1RV3dSeEs5NXFza3ZJRm44eTB5SS9VV1RTNWNkdFhBQmZkajhT?=
 =?utf-8?B?RDJSNHFZSk5rcTllU1ExcDE3K3dZYlFwRTcybG5VTjlDUkZqU2wxVnUrWGRB?=
 =?utf-8?B?T3lFTFZsWEZtRE1lWnlZd3I2RkFQeVkwUEZXRzZaMlh2b0J0eXJ5dG9JbkE4?=
 =?utf-8?Q?rh0HHm2nGmo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmNNd1BMdkZTbTdmalY4REJUazRvcHlpeVl1cHpDZll5V2xPNE5YZUYvUU55?=
 =?utf-8?B?Ym1QTSsyY3owRk91V0gyRTdVbkwyRjlSYVRBVTZZRi9KY3lmbVJwaXVKL2Yr?=
 =?utf-8?B?eXYvdzA0Nlh3YnJlY09nN0EyYndzWUhMN0doY2s0UTd0bTlKV3c2WjJpVHFh?=
 =?utf-8?B?Q3dkUHlrb2lHZzRKT1F1ZklIajcyQU8vY2hPM3ppU3p6L2dxNXdkVHBaaFo1?=
 =?utf-8?B?K2t3aVFzeHZaZ1pldmcvM1F2bGo4cXNFWnhlZnhPRHZSSVhndWYzUmlOOVlE?=
 =?utf-8?B?Q2NpZGZkYUdmemd0ZGpaMlVOS3dpckQ2Ull2R1VSQjkyRkRVTEF3djd0SjVZ?=
 =?utf-8?B?NmFNN0dPcWtYenI2Rm16cmF5dlJ2U2x1MWdWNzRCMXZEcSszWVVVUHg1WE1J?=
 =?utf-8?B?MnJiNlFMRnljWWxkUWxibUJVWjZwekdkbXh2NC9zYlVlWW9weEE0QUJZSjNq?=
 =?utf-8?B?TnhuaUJlUXh5V3hGdUFJOEh5UW1kZlFGQ3phaTA3NHU1U2wzR3dKS2JXdW0x?=
 =?utf-8?B?aXE1Y2o4QUd2TWhPVXpRS0hzZ3RqbDlGQ1BqV1B3M3AvWnZFREY5RHlrSWR5?=
 =?utf-8?B?YVJGWHY5bDBEbXNpNTJ6Vy84WjFxZU83d29xM0RwWUVpeWhzVSs1dVFuNUVo?=
 =?utf-8?B?dnBHSCtVUXV2bjZFb0Y2eEsvVWlYeWpYdElvdWd2TGRydlBqYVFEeVdqZ0p0?=
 =?utf-8?B?eDdsVzBKcmJ6SG5KZTZqcnhmWmlXclRTeElJNzRWelRjL1VBVDJqMExESFJU?=
 =?utf-8?B?YndOS0RJWjBDdWNQK29YcDN2WGRLV2QzQXFNSEY4QmhnVHU5dUgrK1V5QXA4?=
 =?utf-8?B?VTVQR2tCRG9xYUcvemNod3hka0M2a2VvV2VjalRDTWhrOUh5bGpmWmlkcEJx?=
 =?utf-8?B?UU4vd3UyeFd1NjJyS2VEUTNRc24yMHZ6b3U3NW5kZFhUN2UyZmRCM002eUxk?=
 =?utf-8?B?ODMxU2w4MHViOWcrcjRyMndnYWcyZi9wT2NGdmZyZFFOUGF4SnVTV0s4c1M4?=
 =?utf-8?B?M0p0QWc5a0cxSHIxVnhOUXBJSEZDUGZPcE9BeW5CZ01hVDYrQjQ1UjE3bkNQ?=
 =?utf-8?B?YkVERmJtWTVwQUhJSHpEaDF3eUVjRmU2eWpGSDdYM3FidkF6RzVMTjFPMFcy?=
 =?utf-8?B?dElHc3FZVEg0ZHBFWS9zdU80bVNyaVVWclBVdGNaa3cvOGZQNThxeklFVlVN?=
 =?utf-8?B?MVlxMDBMeS9YY29DcGFCb252TmlHcnZWN2E1N0hGUEdNbHFzeXpIdmxETGM4?=
 =?utf-8?B?WkVqWVhJNnhvbGJFTUpuQnhQOGN5NHhTdDd2OXRrMm1VaHhuZDJCQTNkRkdk?=
 =?utf-8?B?ZFY2SDRzL2N1bWVIMkFjd1ZFeExINTVyeHFBZ0VNdDZ1UnhOeUxJMGc5aVEw?=
 =?utf-8?B?NmZsL3l6bFlndUx4SGZ0eGZiQlkraTVPUVFRVlRXTDI2YlB1TTJGdDkrc2Iw?=
 =?utf-8?B?UHBRVHhPNWZ0eVlPTlNOZ3B2UHZtTEd0RytRSTIyL09tc0p5WXBMa1NsQ0I0?=
 =?utf-8?B?dUx6MWlUSHJ6VnJkaGVqZ0FJb1hWUms2RjR1bFN2Q2d2ZDV4RlFYQTV4MEVh?=
 =?utf-8?B?TGRwOVBqSUFSa0FWODRkODVnRjM5MlIwak5IK1BzRk00alI4eWNtbVIzeUdp?=
 =?utf-8?B?bzhMMWx2TTA5Z3ROcmRyTEp6TG8zRXhxY0wweWdzblphNmRjUnFYOHRrZHVZ?=
 =?utf-8?B?bFFBY2VCY29yVmZRdkZzdk4rc2hoY09aNE9zMnJXMzREV2VFWnhqMmVFU0s3?=
 =?utf-8?B?OEdaZVhjNURFcEM2RlNCdHFxRVB4UnQ1cXF0YVVxVEsrdllHOFByNklEUUZ3?=
 =?utf-8?B?amhOVVFVOHdHSUtSdEwrc250dDFralpmQU9tb2MrVmo1MkRMbHYzYlFkVDJT?=
 =?utf-8?B?NnBidkFzejZiT05ZMTZrVHRGeDByYThmN2pMQ0ZOSEI2ME1jM2k1TlFKMjRk?=
 =?utf-8?B?TW9iOC9CUUJNRDRhbG9sMlJNdE1MZm1sQU1Fa1VEUmt2M0k3WXcrNVdyeFdH?=
 =?utf-8?B?SE9xTm1SNFB1K2xTZFYrTWlUdVZTb3JGNEVnR1lKR2o1c0NFTUVRbDJNMDhK?=
 =?utf-8?B?YTV1c2o5L0xBd0tTNyszdnRkaW9hNFFnNTgxV0wwdTMvSlVyK2RDM0FtYkQw?=
 =?utf-8?B?MXRJK2RzMHF3SjJzTHAvb1J3ZEZ0K2JnVTZxWkFpYVNYTm5YUDN1VkJQSWxZ?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f425a107-47c3-417f-f21b-08ddbd6dcfa6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 15:49:09.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nqrW9qKaNrgLBGHUUABr8kiXJiUnIfkeL5wRnwl4MVsXCBL+d8j8lhXQwf7cjZdfaQ57YTgaeBswM/LZdglDxXi+MlzUZxY5ye6Ass0dwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7255
X-OriginatorOrg: intel.com

From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Mon, 7 Jul 2025 08:06:21 -0700

> On 07/07, Alexander Lobakin wrote:
>> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Date: Sat,  5 Jul 2025 15:55:12 +0200
>>
>>> Eryk reported an issue that I have put under Closes: tag, related to
>>> umem addrs being prematurely produced onto pool's completion queue.
>>> Let us make the skb's destructor responsible for producing all addrs
>>> that given skb used.
>>>
>>> Commit from fixes tag introduced the buggy behavior, it was not broken
>>> from day 1, but rather when xsk multi-buffer got introduced.
>>>
>>> Introduce a struct which will carry descriptor count with array of
>>> addresses taken from processed descriptors that will be carried via
>>> skb_shared_info::destructor_arg. This way we can refer to it within
>>> xsk_destruct_skb().
>>>
>>> To summarize, behavior is changed from:
>>> - produce addr to cq, increase cq's cached_prod
>>> - increment descriptor count and store it on
>>> - (xmit and rest of path...)
>>>   skb_shared_info::destructor_arg
>>> - use destructor_arg on skb destructor to update global state of cq
>>>   producer
>>>
>>> to the following:
>>> - increment cq's cached_prod
>>> - increment descriptor count, save xdp_desc::addr in custom array and
>>>   store this custom array on skb_shared_info::destructor_arg
>>> - (xmit and rest of path...)
>>> - use destructor_arg on skb destructor to walk the array of addrs and
>>>   write them to cq and finally update global state of cq producer
>>>
>>> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
>>> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
>>> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
>>> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>> ---
>>> v1:
>>> https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
>>>
>>> v1->v2:
>>> * store addrs in array carried via destructor_arg instead having them
>>>   stored in skb headroom; cleaner and less hacky approach;
>>
>> Might look cleaner, but what about the performance given that you're
>> adding a memory allocation?
>>
>> (I realize that's only for the skb mode, still)
>>
>> Yeah we anyway allocate an skb and may even copy the whole frame, just
>> curious.
>> I could recommend using skb->cb for that, but its 48 bytes would cover
>> only 6 addresses =\

BTW isn't num_descs from that new structure would be the same as
shinfo->nr_frags + 1 (or just nr_frags for xsk_build_skb_zerocopy())?

> 
> Can we pre-allocate an array of xsk_addrs during xsk_bind (the number of
> xsk_addrs is bound by the tx ring size)? Then we can remove the alloc on tx
> and replace it with some code to manage that pool of xsk_addrs..

Nice idea BTW.

We could even use system per-cpu Page Pools to allocate these structs*
:D It wouldn't waste 1 page per one struct as PP is frag-aware and has
API for allocating only a small frag.

Headroom stuff was also ok to me: we either way allocate a new skb, so
we could allocate it with a bit bigger headroom and put that table there
being sure that nobody will overwrite it (some drivers insert special
headers or descriptors in front of the actual skb->data).

[*] Offtop: we could also use system PP to allocate skbs in
xsk_build_skb() just like it's done in xdp_build_skb_from_zc() +
xdp_copy_frags_from_zc() -- no way to avoid memcpy(), but the payload
buffers would be recycled then.

Thanks,
Olek

