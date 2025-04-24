Return-Path: <bpf+bounces-56606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D2FA9B00E
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB2E1B81B1E
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B696219C558;
	Thu, 24 Apr 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRxGdiMi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928AA1990AF;
	Thu, 24 Apr 2025 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503366; cv=fail; b=gVluN69Yn+SUDK1su70GxLhGcdFjPmrF1kBU1gR/TAo18fw+Ty7bA1f1tKjCNHpsNVxkn3XcxQhD2TkJOpG6Hr9Qm6QgpgzRXl3yw92oyyOlbfEHDs1EylGUFNOSHfUpf5idos1D0eTuwnovzAC7X3MjN7rh4KxDEYHwD4oZJ8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503366; c=relaxed/simple;
	bh=Pc1nPJULMfbwC9kb4otXSo3dsiDRZt9+UckHVA69hfw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqmreAnCIqhn5ZLu56R2ToDuusiRuKbTcf0RiKC99g9TyZPeBmD0shK+8FdB/EHaxur+A3Wccek1JL0B6brS4mLx+aOpkFf+S/My8RD1SaMxd6vKL4H6mZNenZiRuLyrjDgl7JBPIrkK20CoCPi27LJjthhsdnTiwmY+fcPfqrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRxGdiMi; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745503362; x=1777039362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pc1nPJULMfbwC9kb4otXSo3dsiDRZt9+UckHVA69hfw=;
  b=dRxGdiMiBfGJTX44hA/Iy6/KipaHyJuoihq5lPLthcZhKc1bFKvKzL4/
   hu7qQn7QOlwX+vk8b5O1ygcvDNv8JQj5K2TenTzHv2HrsegVTzBT9nAI4
   NLDcv9iWYS89fskHHXO30dXT6tzhPFAp5GTXxdeqHqqb/MRUpa6oySTfN
   qY3TDLIR1rieGeKzP1msFwUCI3LbqbLZl8IpftaBNjdf+M0Lo4hg2DuSw
   eJG6QJ0sy8HMFsbH2eRKieAKYzpou4Y5dsgKELaf1nblN+mJ4KrYcg0fD
   tvSofOxZ5m38pP7J2Gov6DplMHfwMSDJfKG/Devjh2FL79c2xxMCUUl7M
   w==;
X-CSE-ConnectionGUID: p4J84PeGQ/KQo0P8lUnk6w==
X-CSE-MsgGUID: cJxmJHDXT06+uWLWA/27EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="34759053"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="34759053"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 07:02:40 -0700
X-CSE-ConnectionGUID: lNHUk9dySReSWh4q3RC9ww==
X-CSE-MsgGUID: pEMoCgI+TqOfiHpDEHqtIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132517057"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 07:02:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 07:02:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 07:02:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 07:02:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zyl7NIILexl12AHVLYqMSD4sKp9a9trORVdKjEmG5nCSXcbL6qGT/vhTRwbS9bigmCmbGfmTIDx9hqn2SNgiwcaCyJa9iDQVkk4NuP4qAEZXWZtsCPrzvdhTZRwNb0Q5M3wrs1qORJdMA5jaU2VL4SFGRlsM0jMRjs6aVN9B0ebsrW75Dmqw/BlJE7lnRreYN9ou+DVOQotqeALvEE70Kzbs6xfbils/3eGNO0DXZKQPz8RpDtHJWoa9VR1UyLUA1YEpwJWzV118u6wNJ9zRtqNUF5amepWaugFF3lwWh/7myB8lMNyndzhciaIIjJzkUJpwXG9eoB0tvXctIHCRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUYaYvkkswWL/1bfh5woqbgvIXTA5T8lOTq/rtM+thM=;
 b=d8C6+Dk3zx07Kh7tcfALrKV0mqsKlGWUaFOSpjy/qASAkd6QGJ7kwK3KU7ogLPtmPKWH1HY5izRUVaQud9ZshPRUhlZ2ERuIqeN7UHqejpG1WCDGni84woK0QGaLJQBtI3alr20BTj0aUQx1cRMDRyxfI3aVqDusBjzw7p/iOm9wRZPu5g/xLK1MidsdOHKuivzhU56yJijrjQCnIAAHo/fZIAVbueSPnfqFwTM9t8H0y8+9rA/GO1e2cpPdJoiB1iih0DWLVpOd3bn0x85Lou5KiSmVi3Ut9PtiTJOONTMJGZF41yao5F+nRIz+gV2kUTVc1U8DMPzrYDu8hkm+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Thu, 24 Apr
 2025 14:02:16 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 14:02:15 +0000
Message-ID: <34e2c7f7-4d83-4e5c-af56-d91e68b3e7e1@intel.com>
Date: Thu, 24 Apr 2025 16:02:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xsk: respect the offsets when copying frags
To: Bui Quang Minh <minhquangbui99@gmail.com>
CC: <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250423101047.31402-1-minhquangbui99@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250423101047.31402-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0093.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 6359eec2-61dc-47e6-b919-08dd83389e55
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWpZQXBoU0gwTjdJV0xlU2ppakh1UnBvS3R4RHg2UVQ0bGhNNitqK1RjWEVR?=
 =?utf-8?B?Y25ocDZ1ZlcyWHR3U0dGbGtsY3pTK1Rsdi80QXNoeWpZemZIYzBvLy83dkc5?=
 =?utf-8?B?ZDN4eWp1U2o1azRLOWNaRzYxUE9zdk56NEUyZmNRRFVLSVQwT21xY1VmeVNz?=
 =?utf-8?B?ZXBjM3l1c01sdHR4OW5DQVE3WVF1bEprTDBmWmpqRE4zUGhvbmR5SnV0YUNT?=
 =?utf-8?B?dW1MbFZzZjk0QzdnVTk4bUc3RjBoNnhTN2ZGbHUrQjBaUEZzMG1XbXpEM2Jj?=
 =?utf-8?B?SE1jZkROSmJqME9vL05ZNEpXTTcwR1k2alBOSytvcFJFTmdmeHBvMk54SjFx?=
 =?utf-8?B?TmtyMEJKTjZPQmVQQmFmdWpPbEVSZkhrTXc4L3lLTC91ZkFyM1dWSmxRWEZu?=
 =?utf-8?B?aFVqUUR6QlNrYkZ3YWZTZHBqa3Q5WVVoL3k1OEJRdzFXa09Wdk9WMWlWUU9Y?=
 =?utf-8?B?L05pejFPNlovRm5MNmduWlg0S0hKakY0RnVaK2FXM1V4YWFWMmY5N3dvTVlQ?=
 =?utf-8?B?VGFkVitIYlFQSW5oZzNNYTQvSUZvNVdJbzBwejhQSjlrT2czUHhzaUVsZ2Ru?=
 =?utf-8?B?UG9qalZGdUJCeEFDNHFCa1g0bUhZU3RVNHNBUytEYWdqdHp0cUNVbGtxSEx4?=
 =?utf-8?B?TXhPZE1Ga1krR3A1TTU2SWhqWnRNbjlXQUR0eTEwcmphZmFuYnArdHRyWEtQ?=
 =?utf-8?B?dWpZdnh6YVVDbGl6NUNlUXNhSmowVGp0UkRnZkZ2N2UrbFVlN0hWdndsaEpY?=
 =?utf-8?B?Y0RBalVoUG5iSzJFNlJ6S055ZzdlWGRFN2tSUU1YL1dpTDNRd3FNV29tNkFV?=
 =?utf-8?B?RWt3T2lUSitDaUVDRHhDMWt0VWJKb1lVR0U4TDZsRDhiUXYzV0Fkdldpb1Z6?=
 =?utf-8?B?bVZVOHpBMW4zaGUvVnRTZi9yYTk4YkpvaERTZzJQZTBWVkRGQ1lodDRwWWpQ?=
 =?utf-8?B?L2UvOTZxenRNVjNsZUhCdjcwSTF6NEFGdEUvTzZKc2lmV3FrSjZEdUVoUDk5?=
 =?utf-8?B?OGVmQkIxSzBVZytmVVB3Vk54RWFDSjdPTjlocG9SZkJSN0VOOVBiVkFkdDVD?=
 =?utf-8?B?aWpzUmk0SE53QzFteEhtNTFaSHVJQ0pza2FCdExnSEJWNzhwM3h5eHUraUJt?=
 =?utf-8?B?djN3UGNpWk9la1p3MWtrMmlQbXhKY1F2b0JvbTNUT3k5ekJOYjBGbS9QNjcx?=
 =?utf-8?B?T1drVGZ1MVcvZ2t3dVQyU283ZFpVcVVTUmE5MkY4ZlFHZ2JFZS9CcEJENmlD?=
 =?utf-8?B?RU03NGxqWjlSTEdrdTk0NHdRMmFEZFhQeS9Db1Q2WHZ4RkpVNXYzeVFWZEFo?=
 =?utf-8?B?UXZSRmhWOHpvYkxKNzNUZ2tSN3ZKUGpUTTF1YXgrQ05FZERWcHJqRUwreHh0?=
 =?utf-8?B?UmFnTkZHT0ptOVN4Z0FxT0JTa1I2QVV1cGRUbVZYWStPS3FOMGJmS3lyNjJq?=
 =?utf-8?B?bHdWdXJYK3ZBeGJhVVFiUVozWkx6c0lPeXZoaHR1T2VLeVFsNmdiVWI5QnY2?=
 =?utf-8?B?bHhtT3NpNTFjbEZFMUdOdEpSNnRCOEhKY2NSZWgzTk1kaXFpYlE4YUZQV2Ja?=
 =?utf-8?B?SElCOS9XTTdCUng4OEFnRWw5cGlnalY0NlVjT2tlcFkyOHhvV3BJRmF6c2dk?=
 =?utf-8?B?UXBibk9ocHM3Y2plUjJjdWI5YlNkYWQ4S2R2RWNZS0hSMkRTSGpuS2NIVGR0?=
 =?utf-8?B?S2YxMzVEQTNNWTNCdHNnL0pDN2FleU9XTTNUSUZFd3NOTTdLSVpycTdyV1hR?=
 =?utf-8?B?aGZaQ21pcmo3UHlPZnFIc1p5N1NqcjhxTTd1dWdjQ2h6U0lta3JzS0dmZG9B?=
 =?utf-8?B?NEZsbStGSFJLUmJpUzJ2a0RocDdhVW9KbC9jM29BL2c3TUxsZVZuallYRVMz?=
 =?utf-8?B?S2VJc0dob1JWNzgxTzNZTE0zN3BGNVlNV0wxUUdBYTdSdUttL0pveWhMcHNX?=
 =?utf-8?Q?wDH9dutS+gw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdaR1NWNE9mTjdpcjl1ekJidVJVTzRzMUd6eVBERnhwazFnb1Nkb1JVRzhh?=
 =?utf-8?B?Z1hTMHBFd3liT2FzaFZLanBEdmV4MmdzcTVBL0hzcnBjQytxRkJPUjA3WDBD?=
 =?utf-8?B?Ynp0dGNMVkNlMlR3aWJNbHNOMFhyRVJ5RkEvaGgxemVpRUwwQTA2czJ2VkpH?=
 =?utf-8?B?U3ZCVXdiUk1NTWRmU0JHTXR1Yi94TVZBRlFKeWdmMFU4b1d0ai9MUEdiM0JW?=
 =?utf-8?B?L1RyVmZEU1BGR1V6WkVvQklXaXR4YTYwUXAvN3NHdGhCWXcyVmYrN3NncFdn?=
 =?utf-8?B?c3A1MDBYOG9IcnVNd1JCNi82bEFLV3NLb0tqK3pyYzc1VHVDZkp4UEVkN09S?=
 =?utf-8?B?ZlVDQ3dXNm85ZlB4aFR2dGd1UEU2OU1KRTRtQ2tYWkVRWUV2RkU5THZPMktW?=
 =?utf-8?B?SER5dnpTcEgySTNFU0RscTZrZzF2V1pqYjhIbnFZanU0OW9RT1Bod1pITnE3?=
 =?utf-8?B?TXRmQlVDdktiMVZSSEEraTlnOG42L1ArN1VGVm5CMGZjVDd1eGlmQ2FzUUFs?=
 =?utf-8?B?Z0VnK3o3SU1vVEc4L0JIQkEyK29DYXRzd082Mm5BUm9NY1p1Y2tNaGdvWHVs?=
 =?utf-8?B?QWRaVWFKL2hKTndOSk1qL1dldzg1TjZ0OTdmaEg1R0NLdE4wNlEyOCsrRHFh?=
 =?utf-8?B?Z0poQlVobmR5N1cwOElZdlN1Sjg2cHRyV0JqdEhsSnAySGhIb1RqbTRlWmZY?=
 =?utf-8?B?RkJZRFdNM3UzN0dmZXhnb2tQQ3NCSnZkMHU1WUlOTG53RUl1RUxLWDNpQ0Yv?=
 =?utf-8?B?eUNDMHhEV1EzbFlYbW1BeGhrM0FicXV4blVCZTUySi9QakVDRVRIY3VzYmF3?=
 =?utf-8?B?Z2FUdmd2VjRyd2pvMEU4SG1EbHExMW04aE81TEVjMk9yVHFTZnBBODlwcUNy?=
 =?utf-8?B?ai80cnQwelEzMXhNUnh4L1QrbWVPMHdCeEtpYS95YnhuOUFhdkVSV3BGTjY1?=
 =?utf-8?B?aElkaFNCVENralZHMUh3UHByaE9aTWFwdlN2a1Z5MnFpR3BwUjdmWmdTendv?=
 =?utf-8?B?MkFUSmNiNWI3dURZSlh3Zy9uQTNrVGsyK1ZndnVLQXJDOG5BeCsxMWNBeUpU?=
 =?utf-8?B?YUlienoxNlM4TjRqQUhpdlgwNW9BUEtURFZZeXdaRmErL0N0S2VHQUFzMUFF?=
 =?utf-8?B?cDFid2Zldk91M0R3MFBNbnZoOWJ6WnRHemNuK2kyK3h3eXZCWk5DSDg4cWZx?=
 =?utf-8?B?VFlielp2cHZieFdkclppS0ttR0VRbkIwVWZjbEJzRmYzeVVLbUlhY1djTC9R?=
 =?utf-8?B?aysrNDBVSzB3a0lzVktiODB5eXVlYzdJNzYxRmdURXJMWCtPbWc5dGxpdWZR?=
 =?utf-8?B?RDZRcGQ2OGhBVHVWeVdWNkdydVVuYkRpZFdXTTRLYjBvTW1iK2l4RnpLMlRS?=
 =?utf-8?B?N2hvd1FpMG9xbzhSVkpkWExtTXZkc0FwYjgwYnJ3WWR1SHNWcnZOSlZMVXFC?=
 =?utf-8?B?aTVZWWs1N0g0ZXlwWVNjT3p0MDJYSUtLcnlZSHI2WGJUb2tPbXNYR1J4ZGZl?=
 =?utf-8?B?MXp6c3dBcTk5YVdUanM1TEh5S1MvRll2WWFKbnNONVhsTC9ld0VEUEVMZlp0?=
 =?utf-8?B?UDZJalVBZTdzU1h6ZkczMkJoR1JDSDNoakRXZ0p4WDJMS0YreVBaL0FuOHVz?=
 =?utf-8?B?UFFkQTBMaWNXaVdETUxQdVgxbG0xak9Yb2tNSlVBSVhUdUQ4M0FBcEFTbXJy?=
 =?utf-8?B?dXZwRkRPOXVLOS82ODRRN2FIOWsvbFhyc3pWc3prQzZ4dmgvRHBiVlVGWUNj?=
 =?utf-8?B?NHB4ZjNxbFgwNW9oUU9tNDJmcERNMjViNEpNMGpuMXpGeHdWdlpvcG9ZTWFa?=
 =?utf-8?B?WDV6OEhBbHRXZ2tlRGkzTzFEUStCL0NlWm1Oc283ZTdFMEJBaXkwZVRrRGJs?=
 =?utf-8?B?RmRway9FdTQzbnIvb2JDWXdlbnNpK2w1RWNWNVNNbHFpelR3QXZEKzlpUDhn?=
 =?utf-8?B?cmZOSllPc29kcnZVNFNGN1Z2eUU2a2RENnROTEF2dHMvaE84Nk1uUXlFd1NM?=
 =?utf-8?B?bEZ2eHhZTEJTMUZUWWlOZHVzSW9GU1phY2dmd0M3Nk5aZkJ1TXVCSkpJL3V4?=
 =?utf-8?B?V3h0ZkIrVnExeGxaMk9hSnR0c3RhTWF0MGNWb0REdTZQa0xDWTBmbmNTWG1D?=
 =?utf-8?B?TnI1RkhoSmRseFFUcE9GcWljbm9UM1BHelNyTFJwNG1ybExId3VwOG9kaU02?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6359eec2-61dc-47e6-b919-08dd83389e55
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 14:02:15.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfQ1veTs2RxSAmMLTsrhU4QfCnGNt+NGYp3w6KH8anP40cvet34sE7MmnporXSSN8Qhs+TSh8UyFSfwT3OXBkpEZYnJ5DGJVmCKbGAx8XDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com

From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Wed, 23 Apr 2025 17:10:47 +0700

> Add the missing offsets when copying frags in xdp_copy_frags_from_zc().
> 
> Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  net/core/xdp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index f86eedad586a..a723dc301f94 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -697,7 +697,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>  	nr_frags = xinfo->nr_frags;
>  
>  	for (u32 i = 0; i < nr_frags; i++) {
> -		u32 len = skb_frag_size(&xinfo->frags[i]);
> +		const skb_frag_t *frag = &xinfo->frags[i];
> +		u32 len = skb_frag_size(frag);
>  		u32 offset, truesize = len;
>  		netmem_ref netmem;
>  
> @@ -707,8 +708,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>  			return false;
>  		}
>  
> -		memcpy(__netmem_address(netmem),
> -		       __netmem_address(xinfo->frags[i].netmem),
> +		memcpy(__netmem_address(netmem) + offset,
> +		       __netmem_address(frag->netmem) + skb_frag_off(frag),
>  		       LARGEST_ALIGN(len));
>  		__skb_fill_netmem_desc_noacc(sinfo, i, netmem, offset, len);

Incorrect fix.

page_pool_dev_alloc_netmem() allocates a buffer of skb_frag_size() len,
but then you pass offset when copying, which may lead to access beyond
the end of the buffer.

I know that my code here is incorrect as well, but the idea was to
allocate only skb_frag_size() and copy the actual payload without any
offset to the new buffer. So, you need to pass the offset only to the
second argument of memcpy() and then pass 0 as @offset to
__skb_fill_netmem_desc_noacc().

Thanks,
Olek

