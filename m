Return-Path: <bpf+bounces-38955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F02D96CF02
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C19AB23DFE
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 06:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE918951D;
	Thu,  5 Sep 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jInSCDHJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5696014A4F5;
	Thu,  5 Sep 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517136; cv=fail; b=OScB+UAU3qpO4jdk7qbn4/KmUzgfG6I5K7IRmLQrIhw2TQ8GpDiTWuey+NP+xm3vXoDcMU7g5ANIjmr3/uCHZ5I8BHl1FDm7FwbD0RCvyKqEmUYJ/046m9I8WqA5GiawPWzm3q0qxSYzrId0Dbam908BF1R4TMYQQOtUa+lpXSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517136; c=relaxed/simple;
	bh=DW3WTcATpwq0g8wQgWuR4fz8M8EO/blijenUYDxyvyA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DNQi3ZWRliE59Urn3LlkwEdGxwgP7dHLEeRsveIRRz93+4G4fX7nD3XHy/AXtkCNAjhm8gvLcOUZDa6+sYvUFlqWDsN/Zoxg0LxhP2eO3hG1StPSEU3VWNFyk8eQ/RkGR1IkU2697uPM3ZQqnFMdg9PYuVBVm8F1hSFMpCk+RGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jInSCDHJ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725517135; x=1757053135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DW3WTcATpwq0g8wQgWuR4fz8M8EO/blijenUYDxyvyA=;
  b=jInSCDHJ14tW2nAh4W5WogZMYRJzsoNqTOThO1qLgHCpREuv+h63JDxu
   AJBycQ5bS3MxmaqVgAClpnidzGiuvrogP6znStVre6k7a/dILnUghJlxz
   OqunDAzlSK/57zPVLIScj/C1qZ+jED0e2RJ205vzK3UdMc9cydAK5F9hI
   OXGzOqPLWegQRTLtXOGTs/41dedRBz9zGm+ytwVKUausqttY42Kp/++JO
   zJrz26GTCznN3+Lo5QaCDXmSXpAkcgnCmsM1Kc83z284zC/4OnV3Xu7Kp
   pysqzQzZoh+xTlNAKN9CZCn32gq0AvFvdKbAvknxbbdJ+wXtGq8EuMDjL
   w==;
X-CSE-ConnectionGUID: /So8xuzrSBiFcHDbFITiuw==
X-CSE-MsgGUID: 4W2DM+R8Qc2jbztODHlQnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34782796"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="34782796"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 23:16:18 -0700
X-CSE-ConnectionGUID: IqWzMkhtTriAQqy9lyk7Ow==
X-CSE-MsgGUID: 2765AdGoSSWH8lGv/V92dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65351804"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 23:16:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 23:16:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 23:16:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 23:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANvbV1qkwToWwkTUx9V9hzSoy0NPfJpGu1G2NHr1bMVaIei1G9CFNtl8RCkC06mh7fKT5di/LLXE0OzXX+C9I++u51PzD8Smg7I6o4tdhLRJdeA4Sf/v6uZSZLMdQPTLXsKdXEPPEvVCGUEdzAQT06lXtS59oz/WR862SObYpT0mU54WiFA8k44uP/K7q6hWjLNp2g/IiYHnIKxyVRuErzAc7banPx1qAPFtV0ZbfSjAClmveoNPToF0mzNZQXnaRtN66hLumWzicxlux5bdPY7QwpYCHUrtquABoKp9qARtXKFtVFHaKzM/BPq3F/gylYbvXKsXY2rx6ljVfps3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMkELBPri8jzsRybHFFR3gb1A3/WwBQlGL2JfSJVzaE=;
 b=v2PRRTH1xevnYkgkw4Zm1v+twU2KdtYlGHYoTDaYK84gutOMg7qO6apPH1oAUosRyX+a7CVv0IcR/M5yD/MtEl4yRrq1Rc90v7p/4c9RS99OfbK4jg4hxcbQa0GnnnE+V7YbkVjUbw6FDs7owBR5Hnso7yBir98Q7Uiu1vxpOEb3AZo1mjs9c6nXgOnUqGAjw5XNUmmGJRlRsWDnk2MSgx1G/6v9E+AbM9FwprG+pnU9ObgAqrPr3YqqBPspOx0upOVB8odWf73Ly5zXkNdj4/Ve9EFmt6cCpAfXIkbXMgTtcimSOCW2U0k5/l4oaPPBuAcW79aUe2sShva44GidxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 06:16:10 +0000
Received: from MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::3f63:c727:6606:c089]) by MN0PR11MB6280.namprd11.prod.outlook.com
 ([fe80::3f63:c727:6606:c089%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 06:16:10 +0000
Message-ID: <b5120c1e-4312-40da-8c11-c0af035dbbb5@intel.com>
Date: Thu, 5 Sep 2024 09:16:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] igc: Get rid of spurious interrupts
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Kurt Kanzenbach <kurt@linutronix.de>, <sasha.neftin@intel.com>,
	<vitaly.lifshits@intel.com>, <maciej.fijalkowski@intel.com>,
	<magnus.karlsson@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<bigeasy@linutronix.de>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>, Mor Bar-Gabay <morx.bar.gabay@intel.com>
References: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
 <20240830210451.2375215-3-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <20240830210451.2375215-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6280:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f85f37-160f-423b-76f8-08dccd723c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UU1FVFV3M2t5ZEF3MFdXRENPc2M3SUFSNE5MZnhUb0JzZlVTaHZXMElOQ05M?=
 =?utf-8?B?VVA4SE8rM2owR2xoclhhTDUwa2dqanlLVUpsaStwamsxU3FlUkJUNk9yTnBY?=
 =?utf-8?B?QWQ3S2FETzVtSkcxNWZTUGVqWXZSbkFXM1B5QlFlU0FjVnI4RktlMmVrc0ps?=
 =?utf-8?B?WEhmTnExa2EybWVwQlJJUnJhVEYzK3R6ZjByZHRTYmhZTGVpOGNRdm8yY2d6?=
 =?utf-8?B?VE1PbEVsM3NtYlFJVkxxWDZmWVNCdzdUS2JkemNibnFUU0NWZ3Y5S1pzMXNh?=
 =?utf-8?B?UXBRekxXRnQwYXVVZFpEOWNiY0tiZnFkWXl5YlVsbFRCNDdmTjlHdzFFeEpp?=
 =?utf-8?B?TVdaWWQ5Ti8xWWJ4elYwWXNGTDR4VTlyeFF0ZktHWkJTY2NZL1NQSXhIVFJW?=
 =?utf-8?B?QzBmVGsxaUZHMzFpMktGOCtZU0gzRGZDVHlRTVNoNVpEOTRmR3R3UWhOREk3?=
 =?utf-8?B?MzhhQ0xsT2FoMmxnbVZjTmZLc1hOR2RSVmtNTE9MYXZISzhwSUtmc0h1Rkkz?=
 =?utf-8?B?aEVQckhwUmlCMG1ySGFCak1uQjZUdGNqQVBTN3Vib1B1TkoxaDZ5TFBXeVBE?=
 =?utf-8?B?VDBxTzRVaDdDOXNYeThXeFJjOHUyRHZNdndjR3k1dGU5NnhMcDl5M3dzWmlK?=
 =?utf-8?B?M2N0blpXU3kzYVpGMTM5K2c5VVVNdXZheWhtVlZIeG5Kb3Bod09rK0tzYjMr?=
 =?utf-8?B?WUdnS2QreUROTHA5VlBVMlF0cnR3VG1HL25BS3kydDJHbWxYN1IwNGZzK08z?=
 =?utf-8?B?cjYxWXB5cVB1dlZDeS9DWUhUc2ZxY3gyM2E0eEZib2ZVTmYyUWtPbW05MHdy?=
 =?utf-8?B?VnQ3NmxIbFBMTlZlQXdXWlBJdlJWZEVkdjliUk16Mk1uWG9XckNId29NbW5t?=
 =?utf-8?B?RlVwYno2K2JBMCtwN0tNS0lXdjlMcThnWTVQMElWd1dhbm84R2wveFJ0TkdX?=
 =?utf-8?B?ZkZNVW9ZZG1jT0xsWmdmOHFHTE5SUEpEZFpJK2tpUzdUNXFaMC9uUS9RVXIz?=
 =?utf-8?B?c3RXcno2V0czZHQ2R3FZY3ViVlJmNUgrMFM4eU9GNTVIdFk0UXdhS29UNExE?=
 =?utf-8?B?WGw5MXhyODArd1NRU0svWUhWODZKcUd6Y2xZNmZTLzk5NW1OL0Y0Zi9tcGpt?=
 =?utf-8?B?YW9uK0JCaHovR21WWm9kd3grYXIrQWpLR05uY3V4UG5RZmY1cnRvemJEYlVV?=
 =?utf-8?B?MUhNUTFRaENGdmlBTHpLaTlUMitLcHhiODNDSnBSYWtXZWRzUDJKWWpUd3ZW?=
 =?utf-8?B?MjdXR29IWk9iR21EWXVIdGZkU0JRTUdrRkcvMWx3ZEcyeHc1UVBXQUtXZTc5?=
 =?utf-8?B?Yi8yY3dzakNIcm9valYwaFpSalVtaGZUTXQrMElqak5CbloyUlRFYjJpY05S?=
 =?utf-8?B?QmxPRnRHNnFVdlhFb0FLeXluTkxQRUZkbjlvY3k4cTVJTXkramhtRzg0UzRi?=
 =?utf-8?B?NU5QQ3FEN1VQTEdXSTVNYjBISXRUNVhlbGRXeUQ1TG5jdVBVTEw2cllDVjk2?=
 =?utf-8?B?Z2ZiTEtBR3lVYThkVkNrRDZlMk1HSXVTN2ZZd1dzbEt2cEV4ZlBIS0lraXBU?=
 =?utf-8?B?aFByOVFsNTVocG1lb2JIcnh4RWdMK3d6aGlqMngzVkszeWxmZXBySlZPN3F6?=
 =?utf-8?B?OXgrd25FVnZZYllmeXNzYjN6WXZXQlpzTFdRbXlyVERRaVZSRVp6NTRJb0FB?=
 =?utf-8?B?NmRybU42OHRXRysweTd2ZllWV04yemE5Uk0zdjVhRjUxeVVFaGE1MG4wTkFL?=
 =?utf-8?B?R3BzaVJIc0h5OWNVUjRtMWhkSElFN1BTUTljOUg1aXVWZlpjMWdZZWJlR2JG?=
 =?utf-8?B?VlhUMGtQRzZuengzcE53Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6280.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVREL28vVE0wbE5GNlhHNFhIV0FsWGs5WXRSMmtDUmdGeElUaDRHclpyKzZ4?=
 =?utf-8?B?c2xoeTdCRkpyODEwdGQxbWhnU282SWo0M1FCNGZWMVVXcERvNmpHWStObHB0?=
 =?utf-8?B?L1RnN0lqdXRhelpTKzhrbTFxT1VWN2VUcERaaktoMWQvbHQvenMxUVZzMjEy?=
 =?utf-8?B?d1VhRmJReHZ6U29LcCtSV3VWWXhjbkZtMTBxRGZTbmhpanM5ODdaZUJ2NytB?=
 =?utf-8?B?YmJFeU0vcHU1a3MyTjB3NHRtKy9KYU9LdkkzcFpySmNrUkc4b0FhSmF2SDdR?=
 =?utf-8?B?blBpakgrV24yN0YwNnQ4YlpCQ0wrNDdWYnNUQm5hYlB2TVUranIvQ0I5V1pV?=
 =?utf-8?B?c0Mvb3FuNExvZ2JxVEd2SnphZk45SlNWMEN4R2k2azFYcm1MdmJ1Q1RSTXZM?=
 =?utf-8?B?VXNFSnR0ZVBDdjAvMkpiK3ZzTXRKcUExa2ZIblZDT1A1alQ5bmdxVWFSRk84?=
 =?utf-8?B?bi9nbXF5ZE0wbkJQU2JZQVhLQ3lLRkVhYWVVekRCOUJGWkIxL0tYSzBiajNO?=
 =?utf-8?B?dWZMd3pXMFNvdDN1emVaR0t3MjhIQXcrWVpTL1lRVWpMWU91QyswTW96QWNm?=
 =?utf-8?B?dmhZYTdiaWxWQ0pTcElzUFhMTnIraXlZMTV4MkNaUFNITStnZHR6QXc1bGRK?=
 =?utf-8?B?aHJsd3MzYzg0dm53Lzdrby9zUnFPcW8yV2ZMdU5WaVpCTlFCWHJPR04wc1Vw?=
 =?utf-8?B?NmdzL1hXVHkxUmZzTFZGTjQ0bksyUHYxajBjekVPbUY0aVAzYVlYYTZRQUpI?=
 =?utf-8?B?VSt3OG9NQVNRTGJwaURJWVlkNTgvdUxmTzB2M0ZJbFQ3Z0N2OER2MVNGZ2Nz?=
 =?utf-8?B?TmtwMFlNeGRKQXg4N0RrbUhCZXBGMGF4MzNKcVhGY0VvMkNoTEJjek5aV3Nt?=
 =?utf-8?B?dHhFaGFlaFBqSmFKRDAvMTlUQ3B4eUU3UGREZXBUVEVSYk1xd0doT3hzbVY1?=
 =?utf-8?B?Uk8ranBLQ05xTk45Y3FDeGVHQkdtUThmeWZrUHNsY2F5U1dSVFdKN0ZDcGpE?=
 =?utf-8?B?eUd1YmZTRzBna3ZLYnlqRkQ4aTU1UG44dnBnOERZQ0h6NkFhTVp6OExxV0Zy?=
 =?utf-8?B?cE5ESUNJc3krcGJCL0RhWXVDckFxU2FUMENiWmk0bE1EQWFIQm9JQ0RFamEx?=
 =?utf-8?B?dE12WUJTdkRhV3Jjd2hSVElVUG5WUkZwNDZJVHRwVCtDR1hCa1dJWWtSRjlj?=
 =?utf-8?B?OWwyVnVITUZ2SUxzYXBFSnEyNFFkNm1mVGFxbnFPK1ZhY2FWTFhOb3RheC8r?=
 =?utf-8?B?ZEU5UW9Sd1pWMUlQUDdiSzQ3T1FDS3lLWEVYWnhoZnhBZ0dRZm03WEdoVTNM?=
 =?utf-8?B?TFcrTDE5bDNpaUxuOGFsNUVyWjR4SFhISmVLZi94Um0xQ1NXb0oyS0t4T0NP?=
 =?utf-8?B?Y1dwZnNRWlRaZ25mRGN6MjkzTy9kM08vd0dyby9Zc2wyTE9aejAwNU43TnVu?=
 =?utf-8?B?R2FabWFVQjZkdjhWcTlSb3pkV3pqdWE5U1lxWmxQUVNDV2tLdFpnUDBaL3RQ?=
 =?utf-8?B?Mkt5RktiNzN3aHQyMGwrK3gyaUM3RElHQk5GTGZJUVA3ZURIUzc1N1ZQYmQz?=
 =?utf-8?B?Nm93R3VHeGVHcDRPS0VtbDRudDVIdW5pQjVkSThKUGs0UmxCSDJZRHJ1SGVV?=
 =?utf-8?B?ellJVVdyRzhvWFArMW8vT0Mxdk8zZTVTWDdMMmZHK1NBR1A3eGVUVW1EV0JY?=
 =?utf-8?B?RGkxbjlreHpUQkVNZllNT3MrL040S2tPYzNyNWg3R0tmelNWVklEOVBUU0xX?=
 =?utf-8?B?U3lvbkcxSGNIY0E2Ukp0OFdSckN0NWNSOVNsTnZDcXZFRy9TOXBteHEvRjQ3?=
 =?utf-8?B?OWRPQWdEUlJUc1pzblhDMktRdlFHbEtJaEIxZ2ZkU2UxY1V5TkdVTDAzb3dN?=
 =?utf-8?B?S3poTm5xRHRMakFKWlJvRWtUV3hONG8wM3VIeU5kZWg1d0FBNEt3TDBpc2xV?=
 =?utf-8?B?bjc1Z1U4Mnl0c0tWZVA4N0lKZU5MMUY1SVRxWGx3ZmNFb0ZLUFBTdzU5MG16?=
 =?utf-8?B?MHJGbmtkancvUDlVSVk2YUh4OG5EYU1Jb1RnTGlFN1VLVXpVeWFadFF3MWJv?=
 =?utf-8?B?QnlWV1BnbDNHbkU2MFpJS01ZaHNYVEpoSVBUMjZkcC9UYW1FampaVVAyR1dz?=
 =?utf-8?B?VUYvdWV3Y0U1VEJZVGVTVGs0dTZxSi9sYVkvZXpXM00zdEdvaWl2Q2RwWjVE?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f85f37-160f-423b-76f8-08dccd723c1a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6280.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 06:16:10.0033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/jGXbRPB0U2JubnckJxI9Wba/3nQWU9ALwPvD9q6lDgtH+dzQk49BIDXehJHpsXUFYPQVUzmYipFoT1znPOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com

On 31/08/2024 0:04, Tony Nguyen wrote:
> - wr32(IGC_ICS, IGC_ICS_RXDMT0);
> + struct igc_ring *rx_ring = adapter->rx_ring[0];
> +
> + if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
> + clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
> + wr32(IGC_ICS, IGC_ICS_RXDMT0);
> + }
I have some concerns specifically about this code (Legacy/MSI interrupt 
case). The code only checks the IGC_RING_FLAG_RX_ALLOC_FAILED flag of 
ring 0. What if the failure was on another ring? It seems proper to 
iterate over all Rx rings in the adapter (I believe igc can have up to 4).


