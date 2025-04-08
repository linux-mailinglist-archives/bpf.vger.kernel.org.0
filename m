Return-Path: <bpf+bounces-55459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075E5A80CCA
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A8A189FC35
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974118E743;
	Tue,  8 Apr 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBePSFlU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06EF17A312;
	Tue,  8 Apr 2025 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119755; cv=fail; b=tnN9GJoeIsv8Atu1FN0x8DsADUVJHjrKpa2RnM+VrtD8biEtN4N/Wc9SJljHU7Sf8jCazTAw2cxdfWrbzp1/JSJ9eW3Ehky6J6R439vYvWIWbbub4cVaweYhuzaFn3xvYZmEjh+FcIJIhetbY4LSeI0DedcRyh49pFKFmodeuo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119755; c=relaxed/simple;
	bh=YjwECXWOXq3JIT+jJW6H5sytBeHZ9ZlkZvgR7mQU4Dc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZxvS5hOfAk8MYhVqm1CAlHSKHI7W3b5+FJzxT2M+3ab8p+lv6N3ZY9Il7H6m5ey4hGqjQlEF2el3HtDGpQb2nU7NQr46T3v2/CbN0n9Pkb6zFIy0mNgBkZAhqiNNhiAjp47y1zmZsBr7ziAOPOdnr9bt3JiC947dXrOQ5mTCfc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBePSFlU; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744119754; x=1775655754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YjwECXWOXq3JIT+jJW6H5sytBeHZ9ZlkZvgR7mQU4Dc=;
  b=QBePSFlUrF5aKowE6v/s4XYj2T/Tn1J/oDGrlmNgdW+QmRHTR3nBPjm0
   fxySQG7hXwsPCng6tnb0uygB0G3jum5VsNCIUCCFUPifOiZAgLxoGF8tr
   allpv0ofyXgEQJoKE9jR1NTVRET843+SiD8bL1KvgCGX5xTZQsfIEa/hc
   HO5UAsZkphVFvP6B5Sd30gKOoaLDjEtBwN6RW1/+/r9vwBCRdlyaDzmWR
   ERxYYnbpRctN6KJYojRJfNyngSqnvnhcazBVgnBu4gY76/SjsYptfGP10
   mN6faKYSBeYUVpMUgvT1qN085Vx8HDPcwbdkqDKi9ob6OnIoAUkkavLvv
   A==;
X-CSE-ConnectionGUID: 44z23zq0QJ68+RDZCTQldw==
X-CSE-MsgGUID: R/LgxlVYR1yI+iiKhuBB2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44801762"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="44801762"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:42:21 -0700
X-CSE-ConnectionGUID: oGiML78LT6iSgdkMyxsCDQ==
X-CSE-MsgGUID: 0pyPUjqVTgyXIsEgG2JAbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="128786874"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:42:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 8 Apr 2025 06:42:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 06:42:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 06:42:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGeiVM4S3ql2NYEIKgpuWRBy3njBhM76KAkEZw7Atsypkfv+KZvEY3wdYYPWWLGm77Ds3FF8xxjQp7V/5N8mMSRbBbH9SmZZja90HoxYyF8joV1uNLzQRonNreBkP2Y6Ra8Wze3J+rzeFxf+AYk1USpHvr/yoqKvGO/WYtreGteYIvxHyq4yrQYPCmThvB39ipFKHIDkuPQsSoOrxpcYMmRXX1Gds7dUmZFuD4EPiRCQyhUnf0m/RhpB9kLuWbPYBJxjL0Vt9XTWcO/4P7NrlurgVvUzSPErp7TQVpAsOjKO0kSXMfuYcIgeWqvz2yS3wR362GhuP1x0xCEo3WiYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX0NefFW77hjhxbxhO2Ag/q1gkamJKcaWwMR5CtUHGA=;
 b=IzeqwDZ2ba0zAfhZsoc/yipRbKXmjzZNapvuRsv9Wbkf2y2GXxCCIO6tgt0pME9w3Y8sAwn32rWoGa+V8JQoXLEIwocTyeB2FqjTn+7vWX5Ff2hyybk/XRcG4i1zhr73q0sFC6vC1YMyPcrj97aB2pV80iFTjKqWtBoy55eKW27/GzZpoWz3MOqfbMKdfjM4TSknScsTP1Ir9LIVqO45fExzxuEeC9zHiystxNlMt+hfYSFt3ryeXeb0lD4wgUG6Vsnvm5aZqXFDaLYBu5GnHMWtx5lV+rPN2Fssg8c+cQidfF4KFRCa/sfGQ752+N2uxWwxlx9MqK7TMr7V3aVB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB6370.namprd11.prod.outlook.com (2603:10b6:208:3ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 13:42:14 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 13:42:14 +0000
Message-ID: <c5bb9cdd-c971-44ba-a1d6-dbe04792cd14@intel.com>
Date: Tue, 8 Apr 2025 15:42:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/16] idpf: prepare structures to support XDP
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-12-aleksander.lobakin@intel.com>
 <Z8r0MagKeUNHwfQk@boxer> <a49604cf-0181-4e91-920d-206a799f67f2@intel.com>
 <Z9rw8ZuoIhuT/dBb@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z9rw8ZuoIhuT/dBb@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0004.eurprd08.prod.outlook.com
 (2603:10a6:803:104::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: deeb0825-b376-405d-bf0d-08dd76a32bd0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnFwMlVQVkZ0WmJXTmJnMTJLT0dBVWlTUVZkc3AwTXIwUzZaUSsrQ0M1UzVv?=
 =?utf-8?B?bFFmQXZVOXZIZVNOY1JmUjBkZi9qejVsM1c2T3lkdThUa3l0cmJ3WFJwcGNi?=
 =?utf-8?B?WXJ5eW93ejJXWDBKOW9FK1FsSFBSOTVkRG5kb1UrN1RlbU1qU1dBTmJ4eUpZ?=
 =?utf-8?B?N1huejg5cC91S0NDNW9JeGlRRGo2c0pEKzB1ZitKbTdvZTRYcVl1UFlzYXJE?=
 =?utf-8?B?RkZoSVlBTTRDamJxZGJhd1dyYmw2Z2Z4eXhxdk83aXVQZWlJMERLWFpsR1pF?=
 =?utf-8?B?RWxpZFdkUndwQVRlb1RYSFFBdWcxZnZEZ2RkUDFmTHFvL1NFQzlLenQ4ZHdM?=
 =?utf-8?B?SzQ2YVpRbEdLdlRndjRiTk84ZW5uWHg3ckxIek1pcXdlL0hwaGdxMXh4SW02?=
 =?utf-8?B?bC9OQ09vQ3hwQkFRenFWUzRKZjVSbUltSys3SlR2YWM2VU14RFVtbXB4UG9Y?=
 =?utf-8?B?T3ppTUR0Nis0SnNqSXM5aTdML0w2ZXhwRXJGa0FJLzh0WmY2czd0ZkNVZ3Mv?=
 =?utf-8?B?TVBwc2ZzVytadXZqQ2Zxd2hTUHFVTkx1QVZZN2FqSC8xUXlnZXNXWWpYTHR6?=
 =?utf-8?B?eExYUi83MGVia0tvcU5vRFVrMENQQ2dhZnNBWWZ4K1Q1UWJDV1h5Z3RDVWlF?=
 =?utf-8?B?WHdkUFAwbkQxZUNFWlRRVlJsdVA5Q1dPRW9jYWxuK2lYY2ZlaHRQU2xNZ0xZ?=
 =?utf-8?B?NkxHNC9xL001eEdtWFNEVnN0bnB5eHdHME0xTi80KzlQTUhkS0J5bXdYS29y?=
 =?utf-8?B?L3NQVjI2dkxjaGV4dnhWaVZEeUpKT2FvbWhqMmtCNHFnK2pmekZUS3lieW1G?=
 =?utf-8?B?SEVRaHVLVGlCVmRrcTFRVVNQaktnNFl4UWVvV3RYc1Rub1hKSEJqdTB5ak8w?=
 =?utf-8?B?WjlacVl4YWwzakIxNzVXaEJPOTJFSDV4MG00K0hOWjcwTjN5YUppcml5UFdX?=
 =?utf-8?B?VkRkRk1wWE1KLzdONHd2VW1uM1RyYUNKUXV6MDJoNmRTOWFKdGJvLzZXTS9x?=
 =?utf-8?B?SjNCMmlIaGNHSGdKbm4zYjF1UTUvMW9OTGpLSG1LNmtaVkZwQytNNHRMYTF4?=
 =?utf-8?B?TzhabW5iV2g1M1RTbDdDRHdGR0VJcmduNVp4eVRsY1BDMzdISDNIVVE4NXZi?=
 =?utf-8?B?V0tsYWhRaVhkVzFZSnFwTXNHYkNxSCs3K0NUUnEweDJZZGZBbHFOdmNHUHMw?=
 =?utf-8?B?Z0RSU2hGOGtlOFFkUzRIMnZYQ2VNaC95ZFJ2dzFUTnd2Q2pnZE1OeXNUVm9L?=
 =?utf-8?B?dUhNY0dFeUNhejdPM2wyQ1ZSczRDVzBVc29hVHJnbTFFL0hsYzJ3eGlaendI?=
 =?utf-8?B?SUJiS1JvQlo4V0VraTFMUXRWcWxHUFBMbDhHZjRCekQxSHZVbmlmRFRsallt?=
 =?utf-8?B?OGhtUEp2c05qZ2lwOUVmcU5wdWs4NmlVcXlaUGtLRmV4WnRoMG1veXNpcnZ1?=
 =?utf-8?B?eXM2eFZFYTA0V2J1S2dZVUNqL245QWlhOXJiSzczR1NTeXk3elFKZHBFQnpU?=
 =?utf-8?B?RXhLclI0dStLSEp3T09HODdmVkJ3MWVORm5HUlRSV29HSDZUVWREcEFkUjNM?=
 =?utf-8?B?NHRwZTZKOHNBWncwckYxdGtDZDd2RnU3NE4rNGg3MlIrNmNkZG1JQVkxUDdW?=
 =?utf-8?B?enVzWTNXb0NWdTRHZTBuQnhGcEdTRXBnM2M5L09UYTYwUHY5aEI2ZjZnMDZN?=
 =?utf-8?B?Nk9lWlZLK3phTC9TN2lUYWdXV0I5RWp4WWFNQmlPM3pjY283Y0lzT2JXWXpB?=
 =?utf-8?B?V3c5ditLbzhpVHBtVGRCaEtiRVhSN1lmaHZsVTU0eFhXYWRPeFowaWd6eWZZ?=
 =?utf-8?B?bUpYWGdzZFNYMUFWN3JRQm43dGZqUHl0aUsrYkxoYVdFSTk5YkRzT09GVG5K?=
 =?utf-8?B?L09GTEtSWnVtREJ2V0tWOHNQbVpGTXhxZHB2L1F2cVZiUkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blhoU3VUZnY2REc0QW1QNFR5bzJJR2ZGKzFSSlA5TWtFWXBPa0F4S1RYeGM5?=
 =?utf-8?B?bmk4eTF2RkRmNlNOeDFBTGp4VmwrdWVHV2Z1SnpQMFJhaHE4WHBTN2xuTTZI?=
 =?utf-8?B?ejVORmJtakFaS0d1THpSK3V3Wmd5YTdwdkh5MU1kdXk2TTNKSVMyNU5XVzcy?=
 =?utf-8?B?Z1pyck1KQzBDQlZlOTZQdlhpNXdPSEUwQ2gxdU50aS9HaTBPaFZqaHErT0Zp?=
 =?utf-8?B?cnlMT1E1blB0UGhWMlVxcFVxcjlhMFJjM1Nva3owRjdhcitPS0EyV3dMMGxP?=
 =?utf-8?B?SFYycis5b0ZTL3JqeWttQXQ4SERVbS8wV2lhc3hHMHZ4Z0JTUzBrbnErMHpu?=
 =?utf-8?B?Q1pQRWlBNkthNHlxWDE2TnRzQmd2S2Voc3FESi9WVEV1M0hlTXVrNFhHRWxT?=
 =?utf-8?B?QWtkSm1iU2tSMVFnZ1RYdHo3L1dkbnkyUFJVK1RpYkRHVHhZRG5LTk12Qks3?=
 =?utf-8?B?L0pZMDNqdkJwM2NiWVU2RE9sNGZ0Z2lOZWRJbTNnb1R5TW5PSUNxN2xIakpT?=
 =?utf-8?B?ay84dFVQWUlIaGE1cnJ1WWpzcGphelVja2xSSGdjTjIwdU5Gb2N6VWxKRy9n?=
 =?utf-8?B?cHRTQjV0YzVreHMvSG1qSnc3L0hBNEVlZk04Y3E3akRYWWs1aHAwSEhScE1M?=
 =?utf-8?B?QmJxVkVUOEZvdDNMMHVLdmZUVUI2em1SNnNvb1Q4YWxZOGdOVC9QY1hNaWdw?=
 =?utf-8?B?Ymh0bWNrNVhVT3JPckhuUjFsOHNHYmpwUEpzWUo5WGplRCsvQ3J2eWswT1Z3?=
 =?utf-8?B?U0wvNlpDNnNOM2JHemF1Y1NoMkR6TDhxU2kvMUM1N3RQclhZZkVNUFl3c1ZL?=
 =?utf-8?B?bHVsZVJVeC82RkFFekVDK2V5MzFmR3owZktsaytVODRlL1hJSW1MMm81NkVs?=
 =?utf-8?B?S0pxZDg4aDZTQlU2UDl5WmRwTVNwbW1BYzdNcUpCTytkTEJ0Z3gvL1R3WHY4?=
 =?utf-8?B?YkhvSGh1V2hxWnNIdFNUbDZhcURBUWkwLzBtTEtGRVZZdWJPL1FIeU9vcFZC?=
 =?utf-8?B?U0lZbGF0NFBXdnNZUURJUnpZVDV3WlNVYldldGJGeGJVSGtnaXRJZnk0VmhH?=
 =?utf-8?B?M1ZDcWd0UEdYMEpNZUpUUk1DR3FHSXR6UDlPeXB3eDJHb3ZRSzhnamgrVzhq?=
 =?utf-8?B?UGhYNXhZZEU0RFNhWU5aSXg2bTR6aVN6TlQzUkJIVE12bERZclFLQ1hvWkMy?=
 =?utf-8?B?dDAxamt4V3ZqVlU5RXEzQUdpMFNjUWkwaVlBRmhRamM2b05KZzBMY3hmaGdr?=
 =?utf-8?B?Q2tnSHQwdnhTUEk5cTdTTFNwb0RMaGVFRTBsZTVTK3J1NG1JaFZrRXQyRkI3?=
 =?utf-8?B?VlFXRWluWTNleEpKREdmMHhVTG9lMUJ0dTB3amRNVHpWY3N3ZEZmZjJLa0c3?=
 =?utf-8?B?MFUra3c1eDlkcjByY0lianJYZjVKTExKWkdrZG9wZVg1QkVxZXhFN085eHRx?=
 =?utf-8?B?dlYwYllHNjZ2R214ZVNaSldhcVJaMUxFMHVPTTdoSjdaakdPV0F4Z1VOY3Zz?=
 =?utf-8?B?ZEMwZWlSZFZFVUZTaEIrU1FuYWx0QjYxanFiQnFLamRJR3Nkcll6VmVuN3hE?=
 =?utf-8?B?MWpFNXY0VGh5Sy9IVTZ6QmhFUWpZSXBtdFhkdkFyczdldnVTbHZIYXFZQ2to?=
 =?utf-8?B?ZE9ZK2tDQUtoYUNjNmJEVnNWVGJmL2hCYURvd2I3UG1qbTNjdVBCVGZRYjZF?=
 =?utf-8?B?QmVCblBGay9pQlBFMDE2MFpaOWxHRW5DR0wxVDh6aUIwbUI5TndLMmpHTnJO?=
 =?utf-8?B?SkVpT0pyUnI3cUZYaVhZd2VLN2xLeGhtOUFMSjlXQVBVblpqbFNicjFpVzND?=
 =?utf-8?B?OEhOUThKdzNiL1BEOVExVjEyNExpZWJwOThHNlJzUFR2cE1uNGJpRnNsT1BN?=
 =?utf-8?B?aW5FQjJidEhDS3NueWl1aDJNTXNDVkQ0cnJKZ09EOUtpcjd4bXl4VGtXdFoz?=
 =?utf-8?B?Vi9oRlhlciszd3RQZUx4cnF1SzNZZ2lnR2NzNEFtdTNaWWtHbU9EQUU3VmNv?=
 =?utf-8?B?blVOYzh0Y1RqNmVwWEJ1L3pLQlhLc0xEYmJLRDBBNmZ6THlVdmNlTkM2eFBO?=
 =?utf-8?B?c29ST0VidTRXem80dTVDTGRldkw5Ti9udzJZdit3aHlEUVdDUWhpRTJoNW80?=
 =?utf-8?B?TVhwelh6V0NXak1IZElMZVlvalNvQmpmdU82N2VjRE1Kalpjc254MmY0RWJt?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deeb0825-b376-405d-bf0d-08dd76a32bd0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 13:42:14.6688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SJPiWEGOKsu7DQAD9niCGY+lqwvLDl27t6aG36GHHT4HBI460q6pSOnWAYIkdnwywsUEDwohIwoUDwGy2/s1s4NIj1AtfYzRzicK/a8J5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6370
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Wed, 19 Mar 2025 17:29:37 +0100

> On Mon, Mar 17, 2025 at 03:50:11PM +0100, Alexander Lobakin wrote:
>> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Date: Fri, 7 Mar 2025 14:27:13 +0100
>>
>>> On Wed, Mar 05, 2025 at 05:21:27PM +0100, Alexander Lobakin wrote:
>>>> From: Michal Kubiak <michal.kubiak@intel.com>
>>>>
>>>> Extend basic structures of the driver (e.g. 'idpf_vport', 'idpf_*_queue',
>>>> 'idpf_vport_user_config_data') by adding members necessary to support XDP.
>>>> Add extra XDP Tx queues needed to support XDP_TX and XDP_REDIRECT actions
>>>> without interfering with regular Tx traffic.
>>>> Also add functions dedicated to support XDP initialization for Rx and
>>>> Tx queues and call those functions from the existing algorithms of
>>>> queues configuration.
>>
>> [...]
>>
>>>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
>>>> index 59b1a1a09996..1ca322bfe92f 100644
>>>> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
>>>> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
>>>> @@ -186,9 +186,11 @@ static void idpf_get_channels(struct net_device *netdev,
>>>>  {
>>>>  	struct idpf_netdev_priv *np = netdev_priv(netdev);
>>>>  	struct idpf_vport_config *vport_config;
>>>> +	const struct idpf_vport *vport;
>>>>  	u16 num_txq, num_rxq;
>>>>  	u16 combined;
>>>>  
>>>> +	vport = idpf_netdev_to_vport(netdev);
>>>>  	vport_config = np->adapter->vport_config[np->vport_idx];
>>>>  
>>>>  	num_txq = vport_config->user_config.num_req_tx_qs;
>>>> @@ -202,8 +204,8 @@ static void idpf_get_channels(struct net_device *netdev,
>>>>  	ch->max_rx = vport_config->max_q.max_rxq;
>>>>  	ch->max_tx = vport_config->max_q.max_txq;
>>>>  
>>>> -	ch->max_other = IDPF_MAX_MBXQ;
>>>> -	ch->other_count = IDPF_MAX_MBXQ;
>>>> +	ch->max_other = IDPF_MAX_MBXQ + vport->num_xdp_txq;
>>>> +	ch->other_count = IDPF_MAX_MBXQ + vport->num_xdp_txq;
>>>
>>> That's new I think. Do you explain somewhere that other `other` will carry
>>> xdpq count? Otherwise how would I know to interpret this value?
>>
>> Where? :D
> 
> I meant to say something in commit message how new output should be
> interpreted?
> 
>>
>>>
>>> Also from what I see num_txq carries (txq + xdpq) count. How is that
>>> affecting the `combined` from ethtool_channels?
>>
>> No changes in combined/Ethtool, num_txq is not used there. Stuff like
>> req_txq_num includes skb queues only.
>>
>>>
>>>>  
>>>>  	ch->combined_count = combined;
>>>>  	ch->rx_count = num_rxq - combined;
>>>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
>>>> index 2594ca38e8ca..0f4edc9cd1ad 100644
>>>
>>> (...)
>>>
>>>> +
>>>> +/**
>>>> + * __idpf_xdp_rxq_info_init - Setup XDP RxQ info for a given Rx queue
>>>> + * @rxq: Rx queue for which the resources are setup
>>>> + * @arg: flag indicating if the HW works in split queue mode
>>>> + *
>>>> + * Return: 0 on success, negative on failure.
>>>> + */
>>>> +static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
>>>> +{
>>>> +	const struct idpf_vport *vport = rxq->q_vector->vport;
>>>> +	bool split = idpf_is_queue_model_split(vport->rxq_model);
>>>> +	const struct page_pool *pp;
>>>> +	int err;
>>>> +
>>>> +	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
>>>> +				 rxq->q_vector->napi.napi_id,
>>>> +				 rxq->rx_buf_size);
>>>> +	if (err)
>>>> +		return err;
>>>> +
>>>> +	pp = split ? rxq->bufq_sets[0].bufq.pp : rxq->pp;
>>>> +	xdp_rxq_info_attach_page_pool(&rxq->xdp_rxq, pp);
>>>> +
>>>> +	if (!split)
>>>> +		return 0;
>>>
>>> why do you care about splitq model if on next patch you don't allow
>>> XDP_SETUP_PROG for that?
>>
>> This function is called unconditionally for both queue models. If we
>> don't account it here, we'd break regular traffic flow.
>>
>> (singleq will be removed soon, don't take it seriously anyway)
> 
> ack, thanks
> 
>>
>> [...]
>>
>>>> +int idpf_vport_xdpq_get(const struct idpf_vport *vport)
>>>> +{
>>>> +	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
>>>
>>> please bear with me here - so this array will exist as long as there is a
>>> single timers[i] allocated? even though it's a local var?
>>
>> No problem.
>>
>> No, this array will be freed when the function exits. This array is an
>> array of pointers to iterate in a loop and assign timers to queues. When
>> we exit this function, it's no longer needed.
>> I can't place the whole array on the stack since I don't know the actual
>> queue count + it can be really big (1024 pointers * 8 = 8 Kb, even 128
>> or 256 queues is already 1-2 Kb).
> 
> so this array is needed to ease the error path handling?

It's needed to store pointers to the actual timers which are allocated
one by one to assign them to the queues in a loop later.

> 
>>
>> The actual timers are allocated separately and NUMA-locally below.

Thanks,
Olek

