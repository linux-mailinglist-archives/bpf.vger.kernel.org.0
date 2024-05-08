Return-Path: <bpf+bounces-29114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59CA8C0441
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 20:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B0D2856B9
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1747012CD8B;
	Wed,  8 May 2024 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwPTrGTn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140854FAA;
	Wed,  8 May 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715192629; cv=fail; b=fGH04IYABhKDK3T49JXHNWqCe8K+7ayaeCpgB+A+dCXsSunxRy+kob0vl4LD1zdYWP6rSQCdxFSnfn6/rok/t6C9HARsFI6KAyzTutmrY/o9iSEBoL5Rhp1CMqxxZ8qfDUS6wPEE8zb4u4P+/ubIl35RYp6CRe//omoczTHKOA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715192629; c=relaxed/simple;
	bh=N6smB964a6O4lEj+HcoKrOINaw9Ti4MDa1KO7M67HaA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QlASie4OGDA8lf5cqxHxOhLFC4WY349ZYskzX4X2eJMQ0ReecrU5qWZV5MoWfBXC2ExpRD+eEaa5H29LGMiCDd67lVpZK1oTjsCgToGx5rvNAjFmVQNAyS2gVClE3Ej98ytHNcDaw5lzJ0jfq6vSoMDuy/JC0GT1xiHS4k0an3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwPTrGTn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715192627; x=1746728627;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N6smB964a6O4lEj+HcoKrOINaw9Ti4MDa1KO7M67HaA=;
  b=bwPTrGTn5r8EoMldMLxd+a+561DPVeOYWOYHtQ1UK29poEmS7EefhOki
   X7nELJZ6D87znE5DnjWm7osoWuzfGatx61CEMBK06FmrTZAjN+fbRLaDC
   WJjA+RXW1AUVE5ywaiWTvl5wuM3ct5rOJjj+/ZJkIA7qeCDjWNZYJSfnL
   q99H9rJ9/4IDhWJGo1aAmELfiWnaPxOXk0r0k+4RQLniSYW7sjLbInc4G
   FeOZnuWhcWwr+46WDryuOBXhoEGvpaaiJUqK7w5a55qQTJ+Xc1Uw+wOGa
   a0D+753uKFDgNnSNwwbw7Jhigt4dNBbj+EOq+LnXA1xMs1734jcKYwusZ
   Q==;
X-CSE-ConnectionGUID: cNB/sivOScGeZl4+rlpbtw==
X-CSE-MsgGUID: Q+VG/pdvSAyiEH93j/oBRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11230913"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11230913"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:23:46 -0700
X-CSE-ConnectionGUID: X0PDsAK/T3+RUyyhCp6AeQ==
X-CSE-MsgGUID: h2mQ0bnuSYyhHubge7yQBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="59839794"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 11:23:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 11:23:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 11:23:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 11:23:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 11:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJZhDL75JRsxcfjflpNv4TSEsnye1gaYrRCUcNTrVNBM1jg4gAcsvY3uLWgGSfMr3PrIgk59ieWqzx/1MYVCo3bwaQx2HO/O8t1y9CvewgxVfbJnwDnf2I4JyU6+T7X/kseI8kds1rAlB6S5P4LeXF/w3sxuGa+orqWx5wTo1GadVvMjDFRbtmfxvjMf9oHoUKtoJy+KHwo5UCJ3QTg7BxC9mAKCjuZSyvhNQpv5KuTJpIVuS22G5LbQvR8fAaQ0zaXo2IlBgQkklYGoo3PfztHHdmMpEBeJIAo5IGhbNSqiCq/oCm2pRC6RI0fi9upiWoJPrWBwz2UOHbGe7KdNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BzRSkorHi91XEz+UQY2lKzvsyVxwJc4nFIDiYkX2GE=;
 b=gA8KzeHvqpnUcf5ZJqmREY4fIVhxXObDiOfTNkYGjNhw59HputBRvndcNmm6J198IpsH2GiCZN0EwNC2X4vosTF60cV3fVpaNYRqmeeJzxwvzW5dH2XoM3G1SYgp5iGd/xuIhuN4HkqVAqKSTJvGrbsTINJs/1odX4iUKQAHJ5N0NwNWHR0IMWpVzL5Rj+EbxVU2Jo5uW9H3THCv/bFRjb6cFax5I2hrpecD5Br3ZaCk/ltcaSFCykmHDJMKlJxAcYCOUSh2jA+og2AYedVckL+f31tHnzXOb3IisHyNdcmYHC7uBSREDq3E7cIQ+dJ4UIVPtyePsfodHGYxEJYs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 18:23:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 18:23:42 +0000
Message-ID: <1f2eb3d5-649d-4723-af89-ca625070877d@intel.com>
Date: Wed, 8 May 2024 11:23:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/1] net: intel: Use *-y instead of *-objs in
 Makefile
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20240508180057.1947637-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240508180057.1947637-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b94b992-1481-4264-de13-08dc6f8bfd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm9UUng3VXB6bkhUN3RTV0x6UXN0ckZHZFFBQUQvSGk3bTRONWl3Z3htYXNs?=
 =?utf-8?B?SFp2YTN4OU1YSHM5Zm44R2V4WDVUb0E5bzhsNmdDdGhyWlpvNi9XNmpQdGJm?=
 =?utf-8?B?V2lBNXIvVFVtamxhUm1ZQ1YveWpTR0tKazd4c3dwVHovRnhjOUREQlJoUEhs?=
 =?utf-8?B?VHFGNUg1N05zc041MjFDWGR1ZCtXTm54K2FSUWNrN1BVeHNHT01TMkFwMGNp?=
 =?utf-8?B?QTEvdXJMVU9kVDRBY0FIQkpQSFN5NER4eTI4Lzc2ayt5cUk4akI5SmlFWGgz?=
 =?utf-8?B?TlJyZ1A5ajkvc28xZyt2Q3liWlhuZFhCL1R2VnVCbERQSWpTRUVRK1l0NFJn?=
 =?utf-8?B?L1ZiUU42ZmtCZGVJYzBod1ZXTWE1RmtmMHVpcVRjNFZNWWZHL0xUWUdxbUk5?=
 =?utf-8?B?amY5WFl2cXRSZjRPZk5ZY1E0RzlkWjRPVkdlaVd2dEZyVXZSQVJ2ZE5lenN1?=
 =?utf-8?B?U3cwM3dTVCtyOGU0TVNZak9wa1JaZ2RVeTRmVHFqcElFMlVoNnFJMkZ1ME9K?=
 =?utf-8?B?QUdjL2pFNXZtVFVrNlMrd01HWldZeFE1dGJ5YS9LSkYvaXdoaWhNbG0wMnlZ?=
 =?utf-8?B?cnBpNTBVOGk2UjdTelg4N25VL2J2R2Y4YXR1VEZUN05XRWlHSHlLVkxvdlBR?=
 =?utf-8?B?K1NYT3B3WlZMQ094Y295VVZnWmM5M2YvN1FvOTBMcU5oNmZTaVZXa2RmMUxG?=
 =?utf-8?B?WG03VXRNSjdYQ3ZQbU1JUHFHaFBIUis3SC9ZUjJyQ0RiTlMxNElwZlhwaWh0?=
 =?utf-8?B?WGNmTUQ3d3FQa2MvWUEwR0RxY1FJd1dLMTN4eGNTOVNycCtGbE5UdWFZT2x6?=
 =?utf-8?B?SlBxZkREOHNYR0JJcFdTUi91bThWNFg0TndlN0hRNDk0VFByYWdYSVdoUnU0?=
 =?utf-8?B?aGJhYitHYnEwMDVydnpnUGw4N0J3czRqYkg3bmFSTVNaaE9jbzRRK0JJd0VX?=
 =?utf-8?B?NE01WHBIMmxFUU1kaUlVNDVLNnJPcllEODVCTVNLL3VkMlRQV2EreCtEUDYr?=
 =?utf-8?B?TkxnY2FUbVNWSUlwZmhqV25YRzJFd2dCWEw1cG1KZ1F4aFZ6U2ZDWG1YdmxX?=
 =?utf-8?B?UUJ3OFowNEt5bEFaRFUyQjNDRFlNNGVGemM1c0svVGJWL2FkZ2lacFJCR1I4?=
 =?utf-8?B?L3UvbUMxTEw1dExQemUrV2FTRldLZnZwQ2RUaGppaFd4SFhLNzdhODhsTVRn?=
 =?utf-8?B?OGthdUlucm5HZU1aWkpyRVJGeFZzQnlIc3JpMDRaQWNZdGxyYmpFZ1I3c213?=
 =?utf-8?B?a0FjVEtHQWQvdXgrdjhIUldTMUhSdER3dkRlVVVjNmNRSGNIaENaeFRFYWx6?=
 =?utf-8?B?aThqcnVGVWcwQXlYbHdVcVhVTWpkMDNpbUhhNk91SEdXcFNycUF5OWRwamRY?=
 =?utf-8?B?a3dmS2lreVJtQStwdUNVSFJYRWttMSt1V2VxZ1RscEdXZXJhdmxyNlYrQUhu?=
 =?utf-8?B?eVlodGRIbkJsUDBHV241VlpOUStIM05Uay9VSHpHeEtzSlNuWFFZYlAvYXZx?=
 =?utf-8?B?QlZzQTNXcUlGOGJGLzMwWktqR29YUXVXcVpKS3NTWWU1MHMyMlpnaXF0N2o2?=
 =?utf-8?B?MUVMZEk3NFhEWnduR0lXb3hiZDI1dllWWEYyLyt2K0dqOVJ0cEpHRWIvZDFZ?=
 =?utf-8?B?RjBQYXIyZEFMVHVma2owNXl5aW40dXpxMkJvMmF3ZjBQOVMxODJDNFhGN0h1?=
 =?utf-8?B?NEdKQkNhQVRUYlNxTzVCaS8rRWFDTUlxWjZZeGtxaWhtbmdjZkhCMnhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkRSK1EyMUtySGhCNnZ2aFVrcU9TN1RQUXlVcENKTEc5SkE5ZUhoL2xDWU9G?=
 =?utf-8?B?c3RvYW5UOHUyN0d0b3A4NTNrODFSYnhNdjBnY2dhVnhCMlFoV2lodzBvT09E?=
 =?utf-8?B?QnpUdDNKVjlSVGcwbDhnSWZEUko4c1BZOWRQSkpaaFVwVks1ay9jNFVXOE9M?=
 =?utf-8?B?bmNWYlBzcWlKNk5YS2k0TTltWTg1MWZUdEd6Y2xjYlA2TU5uQ3FSUDRPeVlO?=
 =?utf-8?B?SFZUei8xVVFkejRWeHF5eklmek5PWTUyNnVWbnhsa1dsUU01WGZveGl3WFY2?=
 =?utf-8?B?V0JJVE8yN1M1UC9iNjQ2ZDFzTmFsMi9WYWY4c2pMdWtiNUdnL0Yya09CNjJ1?=
 =?utf-8?B?aGs1N2hVVjNqUDY3US92WEdOSCtjN1ZTWUpkN21PaEFuL1FaM3lQUVIxNFJp?=
 =?utf-8?B?OTZNY05KYzdQVFl4V3luOFQ1TGFLRnFUN0dEWXpCK3FGWXNjUkNPQVFJTkJj?=
 =?utf-8?B?TjBJVkYxMXdTS2QzRVFSdDVNaDgxd2J0bjZHeGhobm56Njh0em9wQ2pJUHl6?=
 =?utf-8?B?dkkrQ05xOTRldmFOQWs4N1BjN0k4QXFscmZtbFUrZXJqYkNFa2VDMDZpTGlR?=
 =?utf-8?B?UER6eUFzd1pFVnU5RkM4RkZyYmN2c1BGd292QnoxVWI5MktONVVaRUNhOERM?=
 =?utf-8?B?a2tyTEpIQms5aWhrbmtraWR1K253VHV6aFFsUnVHeXF3ZFVwN0cxVUtMZnRn?=
 =?utf-8?B?QVB4am1qOTI2ZnkzZmhHWFBwcDJvZG5keHFud0IvOXJoUWJRV2hzTlR1SUkw?=
 =?utf-8?B?L2EzMm84M1M0d1puVVFueVhBM01oUmo2VWlHcnk3dlpITkVOVlJRWnljNFph?=
 =?utf-8?B?WU5EZG5VcHh4RXhiTlpFMWtJU1JkQ3RWVUFxRXFHTGl0Z1MrMytuRS9WdDJo?=
 =?utf-8?B?dERWVTNzQmdTN0cwQkUyNHpOdmZwNms4djVrRitoYVpnbTBnR3NpY0VhaFFl?=
 =?utf-8?B?Q0NJQTRVNG9FOElUanJQSGxaU3BBRnZOcm5tVjQ3cTc3Z3o4MVdsaFRWK3lV?=
 =?utf-8?B?em1UejA0bDllcU9qcHpmaDBFRDlRb2VEakxKaWJNS0IyOE53dXluYm1wY01s?=
 =?utf-8?B?S3R1TDBVczVQK0ZnL2J5NUFMMlRNWDhOOW12b09MNzZveUZpZllEZGZhSTJ2?=
 =?utf-8?B?azhJeDlIT2M3ZVl5Mzl1SC82N0NFMVh0V1JZVDY1b3hidFpHM2tLUjI3M2tF?=
 =?utf-8?B?RkJpQmdpZFRvQ1Y2Q1pSVUE0ZE1mNXlmWDdRRXI1K1oraUtFK1pPL0RUc3NU?=
 =?utf-8?B?M3VBSEREQVJlZmpXclJiRXVublZCWlIrcEtGS0MrUGJKTk5iNERVajRFY0Vx?=
 =?utf-8?B?b0xaWkg0SmRaZXB2YnJQWXFLZmNpcDFpLzlDajErMUl5N29veVZNc1oxSE1K?=
 =?utf-8?B?aXN0clRQSjJucjBtc1lWVldBb0dCaXJqNktiMjdQWkQ5Y2IrL05mcUxwbE9o?=
 =?utf-8?B?emZkYnVNYjNES1BpN3IwT1VQZ1JnK3VyWm9xanBkcm9JdTVDZFN0SmE5VTBk?=
 =?utf-8?B?WG1ZR3UwVHJBeUYxQ1lTbmxOc2haWWVBT2xFeDRjcmNLci93d3M3WTkrdWNR?=
 =?utf-8?B?M3hvcHNQbEdQWjV6R3ZKN25xWVBtTVNBTUhQVFVjaVhjWkVNelhOaENXTHBR?=
 =?utf-8?B?aDE5Y0FsV2xXaSt5WS9BSGJhZjl5NTA5RGV2VEdEWGphaHlMWW1mM09BanI0?=
 =?utf-8?B?T215aThxUmhXemJubFAxbmEzZHhDMXk3TUx5Q20rR1NxRWVvUVJGYUNZbWcv?=
 =?utf-8?B?aVE2Y0d1bTJtcUdTVVEycUdPSGV4SVVKeXBLZlhiTTJPQ3dFTXNNYmVJZW0r?=
 =?utf-8?B?azZoWkdxeG1XTFhKdnIrVzlKc1BHKzd2NEFkcEwzd2Yvdm1KNnc0TW04bmQz?=
 =?utf-8?B?SE5CQnZmaU9lUW5hcFY1MEVnVTB1UnZyOHd1cElaYTRreFJ2NS9WbnFYbWN5?=
 =?utf-8?B?MG5xWm1UNExDMW0xT1NmMU5PYjh1V3FUNzVremk5WjdDcmpnMVpIYmg2a20x?=
 =?utf-8?B?VElmY0RzTHJCeE5NWXlneVpKQ1pFOFltL1E0UUtORzVBVnZ5Zndsa0RnN3pI?=
 =?utf-8?B?dWd4NC9Da2l0ZnRTSGtHWGdjaVNPWTM1MWI5aUoxdkdKSUU0enJGWTBkWnk1?=
 =?utf-8?B?MjlaMk43ZjVTZmEvSk9TSkhXN2JtS2hadXNmTENIcG5WK1VvSmRzalkrMExC?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b94b992-1481-4264-de13-08dc6f8bfd43
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 18:23:42.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2PLTcsTkqw3e6QB0VrVrE11ONb0rUrAx8u/fX3+2AMDQC4RggMw8ApoqX7nNx2PKhpJS5XmGqPLLH1ez9CcQ21qBCN5K++rSq7bKW5zAPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com



On 5/8/2024 11:00 AM, Andy Shevchenko wrote:
> *-objs suffix is reserved rather for (user-space) host programs while
> usually *-y suffix is used for kernel drivers (although *-objs works
> for that purpose for now).
> 
> Let's correct the old usages of *-objs in Makefiles.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

FWIW I applied v1 and v2, and got only the following range-diff:

> $ git range-diff net-next/main use-module-y-v1 use-module-y-v2
> 1:  0e5c43eb8e36 ! 1:  2cf60c46b7a8 net: intel: Use *-y instead of *-objs in Makefile
>     @@ Commit message
> 
>          Let's correct the old usages of *-objs in Makefiles.
> 
>     -    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     -    Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>          Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>     -    Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>     +    Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>     +    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
>       ## drivers/net/ethernet/intel/e1000/Makefile ##
>      @@
>     @@ drivers/net/ethernet/intel/igbvf/Makefile
> 
>       ## drivers/net/ethernet/intel/igc/Makefile ##
>      @@
>     + #
>     +
>       obj-$(CONFIG_IGC) += igc.o
>     - igc-$(CONFIG_IGC_LEDS) += igc_leds.o
>     +-igc-$(CONFIG_IGC_LEDS) += igc_leds.o
> 
>      -igc-objs := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o igc_phy.o \
>      -igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o
>      +igc-y := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o igc_phy.o \
>      +   igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o
>     ++igc-$(CONFIG_IGC_LEDS) += igc_leds.o
> 
>       ## drivers/net/ethernet/intel/ixgbe/Makefile ##
>      @@
> 

This matches the changes described w.r.t ordering, and everything built
properly when I tested it on my test kernel tree.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

