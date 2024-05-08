Return-Path: <bpf+bounces-29087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F438C0049
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 16:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D90B266E6
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED028662B;
	Wed,  8 May 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmDWigeK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF685627;
	Wed,  8 May 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179351; cv=fail; b=Pm6w9BDG3Ax46tB32aWRvesgYdZVuTHWljFpRkM6IAgZWPodmDIvX/Q7q97mYiUGWFdJcWRCd6an1a7g3NH/9bKoNS3Y/EUsYKWxdux3ZRDW+DJDcj6jVRXUq54juugKPK6RxAHsymnYZD6piyftMDhUS18ZYSB88vAkajhov5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179351; c=relaxed/simple;
	bh=/vH9uoaM2/IJdVdt5K2iEL3nrhqOkTyHfJtjqZgLjvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNCDs5qeMMISSTNHe1HcnvIdDHm6Afk3CaESJjzW33KjzPgjUrfeIEIl+d2tzzcdyVY/+boGAe7poqMwKuV++wQnLiQCYXP255WMGNLYV4f0V2saF2nEN1ZQ/iY6WHqNP3mYXyO8e3pZFAkqZvwQ4zS2/Kqh6K6Isk7Cy6XrcA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmDWigeK; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715179349; x=1746715349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/vH9uoaM2/IJdVdt5K2iEL3nrhqOkTyHfJtjqZgLjvQ=;
  b=VmDWigeKyYiTLNmDmD5TOpmvZEUcDrycY1ku9FoNLN9RhnoyHBIcRsR8
   CcAfbkOXTLE0a/hMeT5mkyC7BJrHdUH7kQgdSridbQSX+HoFGvRIQHCi1
   NrdSi6U9kahj1L2psu5Xm2fs/RJYE20evyt3sF4/VL8nuS4KcuKdPp32j
   Hd7fc7CQI4GAHww0LP3uRi/U6wNszhKzjBX+Zcb0V+luVKxO1e6RfBlHw
   oaF6ROaIOlB8s3NgAMrpoWcBPfHiRcevGt4UgpPg/0+tp2JHcYc/13r03
   mHvpkxa/XEIpAr8bHyxakFM/kKDQRwdwVIW1600gbnx8WDSf1h3RzjTg9
   w==;
X-CSE-ConnectionGUID: GGHRpvO/QUK8ju7CNTPmwg==
X-CSE-MsgGUID: pIomFh+2Rru+CexgidDiuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11200181"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11200181"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:42:29 -0700
X-CSE-ConnectionGUID: 13x/88kdQ/ajNw0p85JwEA==
X-CSE-MsgGUID: R1JvHlQ1TQqf7hqeKn3dfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="52121040"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 07:42:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 07:42:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 07:42:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 07:42:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 07:42:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhk2WFeWfpW1Yh5l3tvr5OUazmFxkOHzoGor17dT/1PK24luLVsdvfZhJqh48jsPNSOft/1/4sOZFpJpicV0ndITW5v8G5S8Fk5q+mU23MpPxvAJ6csskODtEqDw81QkWy/uv19APHZttSKB8img8yFA/9A2F2KfOlpZ0Nr6v9ujPg1P5sqLYP+DOyChd2uvGq+zb/+M9cyiaKrd3lhnb+ZbY/v132aLZ27Em5/FHqrjD3yn7laiwtC63jQt0cmHRooIZODXSvOHKwDzZQ2vNXzcWqT4cEa9L5TqJHg5d5nTGSJBxq6JqjVSztLBkCHPKs16CAFgePonE0VdcKAhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vH9uoaM2/IJdVdt5K2iEL3nrhqOkTyHfJtjqZgLjvQ=;
 b=lkAcpT7QIMNZX5IIXygjBToWMl6QAdMb6rJBy0nro7/JFwQhik9S81uzpa4D0X7lZcdPVQPJaAvgvwZzUzmFCVaxWgnV8snV+qIjw5rbZk7LAi2FKxMe9E4v0fZ+Jm4udN2vlzmlgqZHJDjhTtNSY5JfAyLBYCDpJQdk8QRfPRYEmUw0Ry4gBfpjrQ58Tx3yXO+f3rOoSscWq1Nd67uIGZr2AS7OsXZ2J7P4/RNwFF3xUdS3TeWkNYOAuOZLtERIu0vnJOPKNJFDcucNTOFcVlbykgtJ3UxRM034Xl14tctWThkQVqDgV6Boq9/BKkD1G0mO24tIe9O1fZAZ3itixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 14:42:23 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 14:42:23 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: Alexei Starovoitov <ast@kernel.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, John Fastabend <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v1 1/1] net: intel: Use *-y
 instead of *-objs in Makefile
Thread-Topic: [Intel-wired-lan] [PATCH net-next v1 1/1] net: intel: Use *-y
 instead of *-objs in Makefile
Thread-Index: AQHaoUr1jv7NA9QH6UeZBrjzexGKhbGNVpUAgAAN/oCAAAPdgIAAAEqAgAAAg2A=
Date: Wed, 8 May 2024 14:42:23 +0000
Message-ID: <SJ0PR11MB5866F14FA9B7D02BC97942F5E5E52@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20240508132315.1121086-1-andriy.shevchenko@linux.intel.com>
 <6ac025de-9264-4510-ba7f-f9a56c564a80@intel.com>
 <ZjuLW8jA3MuT0oih@smile.fi.intel.com>
 <5ab7ae5c-79d2-494e-8986-d18d4a8e74bb@intel.com>
 <4038b9d4-6618-46cc-bed8-a0ccd1c92cd2@intel.com>
In-Reply-To: <4038b9d4-6618-46cc-bed8-a0ccd1c92cd2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|PH0PR11MB5159:EE_
x-ms-office365-filtering-correlation-id: bb0224c2-3097-4b41-89f7-08dc6f6d12c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Rjh2QUFYd0d5ZDN4R0xlL2wxU2NzYnlpSmFxaTVldW9PdG9LcFpZckUzSU5q?=
 =?utf-8?B?UVIwcFFTVFFsWTdKNHZrMk5hZHFxSlNSSTN3bzFXUTBzWHdJbTlQZlRUVUlD?=
 =?utf-8?B?cGFPektkVDhaRGJkY1U2L3pheERtVmxOUzdMWnA2aWFsbmNCbXpOZklma2pD?=
 =?utf-8?B?bHIyZU5qNSt6R0dxMVBHcjZpbVl3ODFMVklMUmx0NnNaNVpOcW93RExrc3Zk?=
 =?utf-8?B?cDd1RFIyMzlodU96MGNWZU1JMVZpbGpBWDJrVW9IRWU2ZysxR2xZdDFTTGhD?=
 =?utf-8?B?eGdqcnNYUzV2TmY2RDMyZUw4U3lKZndqZGhuTlZPRkxnMGV6TnRWY0FKdDFt?=
 =?utf-8?B?cUxjdWNtKzB6cGVsU3AzS2NUVE1PcldFQmZoY1dudVFKV2d5MlZZcHdGeDYw?=
 =?utf-8?B?Z2RnV2tJa3BBanRKck9vVzNYcVhGSnFSSWhKSmNDU0l2eTZlZkdKZjUxdUZt?=
 =?utf-8?B?V0cvUE5vTlMxaTJ0bm1tRFV2ZU9oSHFYajhmL2pIL1hCd2NrTU5nYnZLYU5B?=
 =?utf-8?B?RUtMdklKdVhqY2VvSVprY29WclhWYWFVTEova0lKN09ocTdDSVRoK21qVlpR?=
 =?utf-8?B?eWJidHZLbWtESkhibGt0OWxCN3oyNEVqWnJVOU54cWEyanFUZEhqZXdVV0tU?=
 =?utf-8?B?R0dGNGc1QlIrdWJqT055V0NIdTR0YUdCbUltaDNJVzBpbDVmV2NVZ2pDNDJi?=
 =?utf-8?B?cUJJdjg3dUh0Z2E0cnQraWJiYUJ0UGxBWE0xbUZ6VTVaTDRYUENCUmZ2bVVu?=
 =?utf-8?B?eVAxUFN3TllJeTl5VEk2N1p4Qk4yd3ZXdmVMc2xwemdhWHZMS1lPSGcrOFYw?=
 =?utf-8?B?RUtDL2YzNkEzdGlOcXhkcFYwNlJpUUlXU2xBTWRGKzM3VU1kcytuNlAybGRo?=
 =?utf-8?B?MjR0MGZWSFllUXR6UnlVT3d2VFVtZjBmTkJBSEtPcUVRbUplYmVjYWxzdFha?=
 =?utf-8?B?NVR3TGxpK0RHNTlJVTA0akVFallaUHpDTnd2bzhUbTNjb01vTnd2UDRhN1ZM?=
 =?utf-8?B?UFhycEJHNktNN21hZ2gvRVdKMVpQL013ajNPREhkSGRLR0NpOEI2TVJWcGV4?=
 =?utf-8?B?cm52UnNoT2swQ0lRRUw4MG5Qd0RISVhMUlBNd05JMlNOSDZUelY3MkFyYS9m?=
 =?utf-8?B?d2lCUXdaa2ExendDODNXK1gwYjZpTTJFTEtha2loY25jLzFPQUovMlBXRHVT?=
 =?utf-8?B?MVA2ZlFOMUoydjlyNzUrbTA5bjIxa3lONW9UNFBDZExjQU56K1A2SlNtMEQv?=
 =?utf-8?B?UkVxWlVPU2tvZUZ4bmpUZmtUWi9DY1JlTEJISVB2V2JFYkw1VHlhbVkrRUdz?=
 =?utf-8?B?UllQdEJCTDdya0xlcUE5S1NvMzBWM0JCbmxiaWc3bUwxN2lYSGFQdmhta296?=
 =?utf-8?B?U2JqamdRSnJiNERpL3pISEdIMVlsYkFyL0NzdklZVzVta0hGTmx4REhORmNk?=
 =?utf-8?B?Ynp0ZVYwenVZRitFa3doZ2JuWGNQNFJYUVlraHRPb0pQaGY2WVd3aXJVUVJq?=
 =?utf-8?B?S0svVTMxNXhCSkZZZW5DdjlHZmhaNUJpeFRuQjNscm0zY2ZIdVF4cExGOHNk?=
 =?utf-8?B?TCtadXhmVzFXZVZTZ085UjBDRFpyUUF1dlRHNmcxa2ZWMEZ6ZEJUUmdsdmV3?=
 =?utf-8?B?cUVsMVlYVmx2VUF1UmFkanBzZGw1Q09JZFRNN0RrYzFDMWExL3NMTmZSQ1Bk?=
 =?utf-8?B?YUJMRzc2Ri80VTZjekpQaHl5cjBkZHVhQUZSc0FjcmhQemdMZmQwWGExNjA3?=
 =?utf-8?B?dG1TTkxJcFFScklBRDlhU1lqR0g2UitKUUFDNnBsRWlQdU1LdjJvc0tXb25r?=
 =?utf-8?B?TlpQYTJNMWljWVZ5K2FzZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2wydEkxcnJyeFZmaXgzR3BDT3cwYWdMeityNUJEcHRrT1ZaelN0ckZCL3oz?=
 =?utf-8?B?YkUwTXZTTklaNDJRajlSQm4xZFNkRXMwcGVhaGxWZFBvSmJWUEdnRjhxTnYr?=
 =?utf-8?B?OCs0MnpGd2ltZjJBUzBiaFZFbEhhbjVmT3llNFpWdGxKZlF6ZTNRbFNtMkFW?=
 =?utf-8?B?YTg1bmdtaElYZkNrVk9ETEJ1eXc1S0NlVHlSMWk4YytETGEwUVlKUWRkZzFJ?=
 =?utf-8?B?Y0UzMkhQUUYwWGl3Z1pNSU5WQ0JsNzl1cTVBcWk1NC8waDZhYkVkMmpjNHdo?=
 =?utf-8?B?enJ3Q0N1SlViS1NDeE15QjgybCtiaGRtV0FnMlVqWnhqZnBWeUVOM1YxcHAv?=
 =?utf-8?B?WjBrQVAydm1BbXpqNXhONTV5c2Q0NVYyZElyaCtoNWFlMWhtMUduTENDZEFs?=
 =?utf-8?B?VDNrVVZGOVpBekdXWU01N1JYTjJuOHdqdVRrWHAwMnVZWUhIRlJhUGRSNzl6?=
 =?utf-8?B?c2hJMU5tQ3EwMFgwcklxZWJ3dUluY0YrR1NmMEhLL3REQ1pRTjVuL0tHeUQw?=
 =?utf-8?B?cmRNcVNMbjE3SElhY1RFMDdmNlBoeHlzQWVpaWRweE53MWRFa1ZYMTlaVXVX?=
 =?utf-8?B?emVGaXFUSU9UWUZINVdKaHBVb2o2UDFrUkVKY09nOUxmQkk3eWRLNDhUcWs2?=
 =?utf-8?B?MXJTYlFJNFdnYUZQQ0xBZ04vRTdXdDZIQXZCY0tyZ0M5NGZpdTBpYk0vZkU4?=
 =?utf-8?B?NG40VVV4REVyT2tTbzFJbXhzSGQzNFJhU2VxZjVKaGdGTnJVZlllWEhiNXBW?=
 =?utf-8?B?SEdjbUVLNDNId1lDYzNsMjJkT0puMzdRVmhuaEZHRlZJcGcvTVZZNDdMbncw?=
 =?utf-8?B?OFozMHlBT0pLb1Q5RVQrZlBoaU5RQ00xRGtCY1Nnei9mUlpwWVE4L0ROeDhY?=
 =?utf-8?B?d2dZdDZaRmgxOTFxdU8wbnFCTGlMRC8xdUZYTXdqTnBzM0UrY3pRZW83Ujk5?=
 =?utf-8?B?ZUluam15ZWNKODRXaW9mVWlSOFRIM0ZNNGpTbWFKOHFpTlBubTl3TTBxZjZk?=
 =?utf-8?B?VFRFTWUyQkRGWmFQZkp6MTVMcWt5cEl0cHkxL2dGdzV2Y2UxTHc2V2VFeGlR?=
 =?utf-8?B?azNKNy9GbWpGTm5kU2NvUEhqSFJBTkk3VEFITkpIdmIxTjZnSzRMRUF2aG1Q?=
 =?utf-8?B?UHEzTHdvejhNWDA3T1ZJVXRma3V2YTByZWVhK3pnbzhxc1VZOWpYU28vTEN0?=
 =?utf-8?B?QVNaWVduYWgwa2NjdnFLdGM3K1VJdnJzR2EvaVJiMFYxWTZicERWdlJsWnpi?=
 =?utf-8?B?L3UzZ0VLMzVQUytrTjVHZzFGTjllVVZJZEt0elFmcVlBVlBKWDV2MUxnTTRK?=
 =?utf-8?B?VkJPZzdodHFSN0RGWkxtMHFjWitKYUR0RExPc0dxTEZlbk1YdWx5NU16dmJ4?=
 =?utf-8?B?RW5UeTdidFBxbTlRNVZrVkRuS1JQT1NtaHQrVGo5OXJkWEtZdXFuUnd1SUkv?=
 =?utf-8?B?RkhuMHhJblJ1ejVwdTBLRHcxelVMV0U1M2dvYVlmR2RWUUdjWVpweTJaelUy?=
 =?utf-8?B?MHNxMWNHNXVxdW1CdGlaUms0dUluZk5JSW0ydlhGdjM5WG0zZkVZZXAycnYr?=
 =?utf-8?B?cFZPWmN4WUZwa3ljTFJGQlJjNHp0N296Wmd5LzBWa0JGZjZ0SFBmU2tWQVNN?=
 =?utf-8?B?RUljM3FjbHFaZzF4TXV2VG1wZ0FESFoxZS9YVDNSdVloUGEzYmE4eHB5NytW?=
 =?utf-8?B?OHZuc2RTdXZ6WXdhZ3hPWjZ3ODhJQUJrOVY5c0RWNFd5b09vS0FYaHBCRHFs?=
 =?utf-8?B?YTZ5cGk1dm53OElnbWZTM2tFMGpFaWdMYUVlYUpJY0hMeVJuVmE5aTl4SGty?=
 =?utf-8?B?dnV6cmlMenlJQzMrTHFKYWlsV0h5R2dSNGFpNlpGM0NxUitMN3U3aVZIdy9o?=
 =?utf-8?B?YURXVDdrcmNFVkhUSmhTcnVGM3pDb3FySGtDVzdrdW5TRkZGVXM2blEyb0ZR?=
 =?utf-8?B?R3dnam9Vb2ppZkk0U0Q5aUI3Zk4rSzg1dTY1SWNvN0JGSlFnUmRzNDhVZU4x?=
 =?utf-8?B?dWROanRsMnNqMFNncit0VTN1a05CczFSazh0eTI1M282aGg3M2Rtb0I2RTNo?=
 =?utf-8?B?NG95R0xyd3FWYjhWTDlneVBtb05kZS82WlVCeExiazZ2bTZaZXk0QnB2djFo?=
 =?utf-8?B?azdtY2x6YUIxSmNOdXVCYjcxVUhySDBsVlJwTVBlWWtZakNwYTRRRWtPSEtp?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0224c2-3097-4b41-89f7-08dc6f6d12c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 14:42:23.6208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbC5odILmHwUJylbhiTCQqBELfAtGBrjxlPaY/aUQ6i70lbP+RblS4ylGE3aGz1JsB/2Omhxh9fPrbPim8Hz969QlcxkssHSqUkeIkx0u1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbg0KPiBCZWhhbGYgT2YgQWxl
eGFuZGVyIExvYmFraW4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgOCwgMjAyNCA0OjQwIFBNDQo+
IFRvOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4N
Cj4gQ2M6IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+OyBKZXNwZXIgRGFuZ2Fh
cmQgQnJvdWVyDQo+IDxoYXdrQGtlcm5lbC5vcmc+OyBEYW5pZWwgQm9ya21hbm4gPGRhbmllbEBp
b2dlYXJib3gubmV0PjsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgUmljaGFyZCBDb2NocmFu
IDxyaWNoYXJkY29jaHJhbkBnbWFpbC5jb20+Ow0KPiBKb2huIEZhc3RhYmVuZCA8am9obi5mYXN0
YWJlbmRAZ21haWwuY29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEVyaWMg
RHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IGludGVsLQ0KPiB3aXJlZC1sYW5AbGlzdHMu
b3N1b3NsLm9yZzsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47DQo+IEtlbGxlciwg
SmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwNCj4g
PGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgYnBmQHZnZXIua2VybmVsLm9yZzsgUGFvbG8g
QWJlbmkNCj4gPHBhYmVuaUByZWRoYXQuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0Pg0KPiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1u
ZXh0IHYxIDEvMV0gbmV0OiBpbnRlbDoNCj4gVXNlICoteSBpbnN0ZWFkIG9mICotb2JqcyBpbiBN
YWtlZmlsZQ0KPiANCj4gRnJvbTogQWxleGFuZGVyIExvYmFraW4gPGFsZWtzYW5kZXIubG9iYWtp
bkBpbnRlbC5jb20+DQo+IERhdGU6IFdlZCwgOCBNYXkgMjAyNCAxNjozOToyMSArMDIwMA0KPiAN
Cj4gPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVs
LmNvbT4NCj4gPiBEYXRlOiBXZWQsIDggTWF5IDIwMjQgMTc6MjU6MzEgKzAzMDANCj4gPg0KPiA+
PiBPbiBXZWQsIE1heSAwOCwgMjAyNCBhdCAwMzozNToyNlBNICswMjAwLCBBbGV4YW5kZXIgTG9i
YWtpbg0KPiB3cm90ZToNCj4gPj4+PiAqLW9ianMgc3VmZml4IGlzIHJlc2VydmVkIHJhdGhlciBm
b3IgKHVzZXItc3BhY2UpIGhvc3QNCj4gcHJvZ3JhbXMNCj4gPj4+PiB3aGlsZSB1c3VhbGx5ICot
eSBzdWZmaXggaXMgdXNlZCBmb3Iga2VybmVsIGRyaXZlcnMgKGFsdGhvdWdoDQo+ID4+Pj4gKi1v
YmpzIHdvcmtzIGZvciB0aGF0IHB1cnBvc2UgZm9yIG5vdykuDQo+ID4+Pj4NCj4gPj4+PiBMZXQn
cyBjb3JyZWN0IHRoZSBvbGQgdXNhZ2VzIG9mICotb2JqcyBpbiBNYWtlZmlsZXMuDQo+ID4+Pg0K
PiA+Pj4gV2FpdCwgSSB3YXMgc3VyZSBJJ3ZlIHNlZW4gc29tZXdoZXJlIHRoYXQgLW9ianMgaXMg
bW9yZSBuZXcgYW5kDQo+ID4+PiBwcmVmZXJyZWQgb3ZlciAteS4NCj4gPj4NCj4gPj4gVGhlbiB5
b3UgYXJlIG1pc3Rha2VuLg0KPiA+Pg0KPiA+Pj4gU2VlIHJlY2VudCBkaW1saWIgY29tbWVudCB3
aGVyZSBGbG9yaWFuIGNoYW5nZWQgLXkgdG8gLW9ianMgZm9yDQo+ID4+PiBleGFtcGxlLg0KPiA+
Pg0KPiA+PiBTbyBkb2VzIGhlIDotKQ0KPiA+Pg0KPiA+Pj4gQW55IGRvY3VtZW50YXRpb24gcmVm
ZXJlbmNlIHRoYXQgLW9ianMgaXMgZm9yIHVzZXJzcGFjZSBhbmQgd2UNCj4gPj4+IHNob3VsZCBj
bGVhcmx5IHVzZSAteT8NCj4gPj4NCj4gPj4gU3VyZS4gTHVja2lseSBpdCdzIGRvY3VtZW50ZWQg
aW4NCj4gRG9jdW1lbnRhdGlvbi9rYnVpbGQvbWFrZWZpbGVzLnJzdA0KPiA+PiAiQ29tcG9zaXRl
IEhvc3QgUHJvZ3JhbXMiIChtaW5kIHRoZSBtZWFuaW5nIG9mIHRoZSB3b3JkDQo+ICJob3N0IiEp
Lg0KPiA+DQo+ID4gT2ggb2theSwgSSBzZWUuIGAtb2Jqc2AgaXMgaW5kZWVkIG9ubHkgbWVudGlv
bmVkIGluIHRoZSBob3N0DQo+IGNoYXB0ZXIuDQo+IA0KPiBSZXZpZXdlZC1ieTogQWxleGFuZGVy
IExvYmFraW4gPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+DQo+IA0KPiBUaGFua3MsDQo+
IE9sZWsNCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0
aW9ub3ZAaW50ZWwuY29tPg0K

