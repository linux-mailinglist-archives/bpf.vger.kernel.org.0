Return-Path: <bpf+bounces-42251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F499A1605
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 01:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F151F238E3
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 23:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58431D47B6;
	Wed, 16 Oct 2024 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAGSxKvz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C161534E6;
	Wed, 16 Oct 2024 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729120367; cv=fail; b=EIpySpYxszvqSk9e29FyZa8F284HUhdM6AK0R9ijArYQld1c4Vpf8dR0kwsMH1WGOl27eHIDq/0LDczmxFAhUPBORr0eAQ+5C0We9fb4R8HgjvX0+sbBcd79+6cE4jMeYbHutfpGO4X7etQfTCOkFhCMuIVaS5BZAgPJ192/FQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729120367; c=relaxed/simple;
	bh=I5nj6c9Y3PoVahb0ROb1wcwpeGlbkauI+ljGDHMs4qI=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H75/6xrV0mYDB9ltok9vqoOAAjk4rn3zzi90q9t8p4PhMNv0oaZay6N1wctC9V+0YLI5jIN2sW3Vdp4TVmvv2FinaMqVy/dfOzbKgi4ebyoQGuNR2TnuPBh7DW0ujxKPRCcln0oj1guYNZ5Nr1V2fhA3S+fzSN4o+vB03FY1GYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAGSxKvz; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729120366; x=1760656366;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I5nj6c9Y3PoVahb0ROb1wcwpeGlbkauI+ljGDHMs4qI=;
  b=CAGSxKvz/3WFcO2qSBe9jBKnCXw/2m5XnZqMOLkrwLQuWaDlPj5or36P
   SlJNE1/ABAFim972mF2p9bUcV/WUs346rmFhuN2pvciGUy0RdDNCyEd24
   x7aevrCjtK19ZB+cVopWQTU2f4j0qFytcRxf2dQzt+idWhK7o3GHBGcIC
   ln6Spp4N2CgpXLor2kKaW0CfuV6EyK4RResFqzWhUz54q8LPKnhrhjJKR
   mAI6C2llnd7eGWgjPhoIVgHYEOEPzv5lzh63uBJEyDeDSbvGjqWYyF3G9
   HPkUQ4+1LKOGw5QMyV73WqxA+3UxQ2UImxmAGo63XTg1krr5mshbS5SKp
   Q==;
X-CSE-ConnectionGUID: 2hmn47WORIeeUI92iRg6wQ==
X-CSE-MsgGUID: uOkNsUIpRMaX2u6bDg/Awg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="46084755"
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="46084755"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 16:12:45 -0700
X-CSE-ConnectionGUID: Cyz68gxkQu2+cGENvCK3vw==
X-CSE-MsgGUID: 7P8ZGnxARf2upaKKunnbEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="78028453"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 16:12:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 16:12:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 16:12:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 16:12:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 16:12:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIP/9pkcZi+X1/VgodNQH2XzK+s9bIIL9uEQslUUG/sMSo6dv04UnhTlZYWr+M10uxXE7MPtRxVHZ3Ps5usbmrZLR10RpmiKhxZbv0RSho6DvB+MCgGPlg0rio2VIEVfqZ1D74oa7UeZOV4/yoFBArN2l28s9H4h/VBuijcxGtQankIU+sPVGrAUETsnL80dcPt3l9GUW64pQsku0UtxCYIKGOv+9OQEsbU4yXJxCwQubiuneOeVjaoD9QASrS2E60cWZPJqPrxX1SbHBNwMi8WN7awbQgLZ4lnhQrlGAEmipteRD/xpwLFSJmJi9wvCy2Ob7FHm+Dpa6+a40qDWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0msjQuQ72aZCgWI4bPci1fKv37rSdE1j/Igu03cBV6M=;
 b=B+Z/vKvdEqkWWzN4xsc1RJAjHcDLe0gQl9j20JFyfgbN2tHHi1Wq5rEd7LsickiHoz/k5M0yLCBrSM1gH1yx6KXLllSkhq2HvbPbIN/i7m4HrkEuqcK19fV4XoHez6xU8VCDJDl5nWMViMXfjACOdEsy65tLx24BP9ZD6aDwINKb1kJ3koBFgF3+BUn20en46w8fUESfBX7JLjBLsRmukVTFMf2P/WfTCVvvHPU9sYpKIpjbk6ZF+mJSrXOZaI6bxQ/SrwyLh8BalV6AEHxNBsWxMWkKc5A76xm7xs3XOvmyC69Wc8lVBcetwFZ598acJyz922ApWG/i6QBvLT5x/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8586.namprd11.prod.outlook.com (2603:10b6:a03:56e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 23:12:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 23:12:32 +0000
Message-ID: <f8bcde08-b526-4b2e-8098-88402107c8ee@intel.com>
Date: Wed, 16 Oct 2024 16:12:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix passing 0 to ERR_PTR in
 igc_xdp_run_prog()
From: Jacob Keller <jacob.e.keller@intel.com>
To: Simon Horman <horms@kernel.org>, Yue Haibing <yuehaibing@huawei.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<andre.guedes@intel.com>, <maciej.fijalkowski@intel.com>,
	<jithu.joseph@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20241016105310.3500279-1-yuehaibing@huawei.com>
 <20241016185333.GL2162@kernel.org>
 <8e4ef7f6-1d7d-45dc-b26e-4d9bc37269de@intel.com>
Content-Language: en-US
In-Reply-To: <8e4ef7f6-1d7d-45dc-b26e-4d9bc37269de@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:303:8c::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: f33441a8-bce3-4fbb-7e04-08dcee3803b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am4vRlVrM2VTNUV0VXBxY0JrUnN6ekNhZmRUL2F0MjZGM0xFYURHNDNBN1JW?=
 =?utf-8?B?U1pXbURqcTR0R08xZGFaeUxoSGFVMDNFZERoRWhpU05SdDhJZDZyblVNZk1G?=
 =?utf-8?B?cDFmSytWZHhaNnV4QkNzSHpxZVBoVERMeEtIdm5IOU5oQnlGMUt4Q0loMEhM?=
 =?utf-8?B?eDhHRGMrWU5sVkVJWTVxM3lYck11UTFpNkhmN3NzNndXTzV4OFRoYVJpbjdI?=
 =?utf-8?B?Y2NhZW5EWndIUUlqa0VsUytLbkE0cXVyWlRvQzNUazdUdjFqWmZLT2hMSmJv?=
 =?utf-8?B?bnhMV0x1YXF3YU9xL0ZPdEs3RnV3V1FVQnVyaXE2RGlZL1dKaUhxbVJyTG9u?=
 =?utf-8?B?c0hNM3QyT3krTTRoYldvUmU0Qk1OV2k0dnM4Z2FMRVF1Y1VnNi9UM3ZxRUxl?=
 =?utf-8?B?UjhsNTkyeEpwMWVTVVpaZWFEWFpVeFhKQW5HUHQ5MjBKRHd4Y0llRVd1RER4?=
 =?utf-8?B?cTNSSkNRU3VZTWtEbyt4WnY3Vm5tQUQrbzQ5QnpoTkVyb3ZrUTk0YmtNOGpy?=
 =?utf-8?B?NWZETzVvYm5PclNRbU1IWStYVCswdER0clZXWmJrcXN3RWQ4UDc3YWFhMUVS?=
 =?utf-8?B?Zk11MkZOZHFhV3FpVExBdXB5eWNlZUVjVlE0UFE5eEczNDJBR1YzL2N2Z2VH?=
 =?utf-8?B?STl0UFRtVFRtaW5QS0FmWWZTb01RM05YSVdpSTFQdGl4QTQ5bVJ6aUk0cjJW?=
 =?utf-8?B?VGF3bG1meVdPN3FXYUZoeEJ1Uk5PcEhrQTB1d2FPNDI3cW0zMzhFU1VzZEhP?=
 =?utf-8?B?bUpZdThvOVlZTzJWUndJR2tmYVYyU0tDTnNUWVhLMFJwVUN2NWtHZjlPVmNH?=
 =?utf-8?B?cDdRMVFUL3JrSlZHRTdoL1QrSXEzc2JYek5oMGdaK3gvSjZJZS9wOHB2YkQ5?=
 =?utf-8?B?eVQ1a25nR1d4TFJ6OTY0bDY3ZEVzK3BtS0FjOGFVd0IvM3Q0WVJ0d2duNXdq?=
 =?utf-8?B?bVRhdngwNXZxVzZzMVEvd0RyNjhpQnRybUNpTHNHMlZoRml5RUE5eFhZV1lB?=
 =?utf-8?B?eXgxN3c3b2pDRWpZWlhVaEt3dGFsUkp2Z2RMSWZHRkUyS1ZWT1E2RUgvUGV1?=
 =?utf-8?B?ODNmYWlRT3YrOWcwdUZwbmREUXJUcVZCVE1qNFdzcE1lUUxxQkp6NjA2cmpQ?=
 =?utf-8?B?SHUzT2VHa0Z2OEthZDR6ai9ETUsyTjA1cHRWbDVvTmUvU2RIZ3VBRk5lVlAr?=
 =?utf-8?B?WkJRdmxFY1ljZWN1R09GdEpsMU44RVZjZytTQUxhd2hQeElIL1c3bWV1Q0g5?=
 =?utf-8?B?SENtVmo2YUhDcXJhMDBTTzloMTZ0d0pqQnRQTFFhTXBKTHY3b3llK09jSjlO?=
 =?utf-8?B?Yks2Ry9rd2RUNnpoZy9zVUoranplUnU3Zm5JV2l6ejVkM0ZXbEFLYTl0YzZk?=
 =?utf-8?B?Z0JUSkV2ajVOUW5pV2ZoekNlcjVlZHcwelpPZy8vREpvaDhWYjZzN0ExMDlp?=
 =?utf-8?B?Y1JUbFRyNzZ5SGdNYjJkb0FuR0dWN3VLK2VKbnQ2Z1g5Zkl0UWNQRmRwTWwx?=
 =?utf-8?B?bXBnWXZqczQ3Z1FxT0V1cXZMR243NmNobUhmVktKZlEweWxVNHhORVJuTjV3?=
 =?utf-8?B?UUdia0dxUlFmb2tBOWN1R09MWDQ1RmE5ZS8rbHplaVIwN0VTT09KK2U1eFds?=
 =?utf-8?B?UjFpQ1kvajFNMmlrR3dVenh4ODZXS3g1Ukt2ZnI5U0k4NkRvZDNpU1kzTmg0?=
 =?utf-8?B?eEUzSnM3WTVuNWJkY0JVTUI1UkFEbnJUWFUyb3MrRElLaDRGR2EzVzgwWVV2?=
 =?utf-8?Q?tVe0q/aaAEyl1sHwjzh3KZ3S3G31yHA327Z/egz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE1tS1FtcWFmRHBjVGl1RU5vNkd5cWxNWjhyRVBabHNKSEtEZkE1Mm1uOGts?=
 =?utf-8?B?SmQza1ZJRHIxaFNTeTNDSm12cUdIVzFEVlRjWGRwaS9zZUxNb0xnMk84UDBr?=
 =?utf-8?B?dVVkRGxzY0ozRFlpOFF5N090TGRXV0NkOG9VSmlBTGFWSHpoRHRSZXRtN0l0?=
 =?utf-8?B?K2lpTzV2Z0Vtcm01STNMSXFsMHNidlhhdWxSeWR1YWhrQWtabkN4STlyNk0x?=
 =?utf-8?B?c0l1UUNYZlVpbUkzN2ZpWm5BMytDZFV1OWI1WlhCV1M3SmFVd1Q3akFGZkdD?=
 =?utf-8?B?YjQ4VVMyZnhFNVNFNjdXUm1YRmtvZzNNTW1nYUlMN0VvZndWUS9ZSWlWUStk?=
 =?utf-8?B?TEJLU1ZjTktaa2tzd3VKZHp4VDBRU0djeDhhQy9teGFMdENhdjdaMktxNWox?=
 =?utf-8?B?SmRtTXRsQ3lwcWJ3MFRuaUpyRjE0U0hqbXpPSWVpbmMwQjdXOTFNcDRDSUNN?=
 =?utf-8?B?cVN5MWswdnoyb1BKZmowVUNmdEdPekZwT21oMEhxVVFHY0svYkNraUJyU2kx?=
 =?utf-8?B?alNTM01pczc3cERDUFJPMjZFRm5oY1VtbFg2ZlJNdEZBRVcxV3BKc2F4UVM3?=
 =?utf-8?B?Szk1WDd0ZmJIWi9xaUpXNk5hVUc4QW5WMnhxRjlPcCt0L0QzMWdQL2ZPL0FQ?=
 =?utf-8?B?a1dBRzI2UWtPQ0ZKdjZLVkpvTXhab3hJMHRkVzJ2Rk0yS0ZLbHVqSWc2akxZ?=
 =?utf-8?B?UzdQc1ZlbWliRjlzMWRtK2NXbDFwMkJyd2pGYVhva3NVeUNNUytlaXpmNUI4?=
 =?utf-8?B?dHNPclMrdEtYYXFLUXJrRWRNZldIRUNmaWNZZy9YTU4wcGE3U0lkc1FsSmhs?=
 =?utf-8?B?OG9HY1FwRk9BOUFVVUQvK0RzU3dFdTgzeEZVdGhLL1IvWXk0dHBBN1RTemZS?=
 =?utf-8?B?UFpIby9wUGlHcWFEN05XU0oxV3NoSHQ3VVVBdTVva2MxeGsyZmRETVlyLzZ1?=
 =?utf-8?B?cjk4TU4zUXVpS1QrMGV6VlNOY2hlSVBKU2dWS0VYOXNXdzhiNG9FVVgyY0hG?=
 =?utf-8?B?TlllWnpGaDVjNmJNM2NKck54bFUyWElXU2JPOTUxcTAzNi9Jc0xhQnNqVytj?=
 =?utf-8?B?N1NIbU5KUDI5c1VvMldsYk5DQU9DZ1oxbU1YRittNSthaHRRamo0ckZIQ3dv?=
 =?utf-8?B?R0NyVW0veXRpaGJXTDFsbU56cVF3R09rVmgwWlVncExsc3FLTVRlQk5RdUIw?=
 =?utf-8?B?Rys1T1FXTE1HbTNZdjIwUjdFaFE1QkxqbFFJR2JSeHVnWWNCaE9CMEFQWEsw?=
 =?utf-8?B?d05UZlZhWVg5MndQMTk5TVdGSWIyV1RkWHYrSXRvTFBjM09Sbk4vZTBwZ1Uw?=
 =?utf-8?B?V2pqa2d1T0xvc2hZOGpQMWttak1xMHBPZTJvV0MxbGlPTFZ0aFM1TjYyUHJa?=
 =?utf-8?B?ZU9aWUp2eEdDT0lLaC8rVTJWdVZOYm53MVJNaU9kbXN2VGZzTTh1VkM0cHhp?=
 =?utf-8?B?S0NldUNvMWZZajRUdDR5RnFzMkNlWXM3VkJIZ1RZZnU1SUpQTE1yNEZqZ2ox?=
 =?utf-8?B?WEd0TS9mSzJYUGhqbTJHdmpkblRDK0F0cCtaVGxJd0Y3ZmgyRDB1dExXd0No?=
 =?utf-8?B?eUJHTS9VRllvYmtOeVNnVGdhOXVubDJaMzU4dGJyc0grZlhRQUJHaXNLNmdR?=
 =?utf-8?B?TFNHTnQyaDdLRjlJenFxZTdDZUEycCsyQnphVU5yNnFFdXpKZW1TdGtOZnYy?=
 =?utf-8?B?RHZnSlcrUjh1Z2J0T3ZVeG1UTTlaN1lEVmUrbGRZZjZQNXNhcDF2QVg5a2R0?=
 =?utf-8?B?d2I3UEFrNStXclc0NDVqNUJRaU95aXo2MW0xSHRnR2RCM2FKaWdiNjdTeXRr?=
 =?utf-8?B?RCtjMjFFY1k4am1YMGRZMTBtZVpzMG5KcWtkLzNxYlpreDd4SDFiY1RjYXdC?=
 =?utf-8?B?NmUvSkNtK2pEVWk5cllJLzYzRkJkdEQyWkt3MDJNOHduajBuTXoxVXVQcUd5?=
 =?utf-8?B?WEVtRTJuMVkwMUlnaDN4VDJXVmJFODMvREdZWHB3a1dvUlFoaHpPeWtNL1RS?=
 =?utf-8?B?VGdtSWlLOGFJQWhSNjFFNCthbUpodUV4MDY4bEdmL3Jtdzl1SGh3bzJRckJs?=
 =?utf-8?B?UG9FTUw4MHl4VHEzeXJ5NzR0Z3JPMkNra09SUGp6Rlh4RHNCbUNQQ2NhQ0FU?=
 =?utf-8?B?UnVoUjNLMUVYTEc4THdZaSswVG4wVGE1UWtHSGpyb2J1aWJwV2JoajhNbkM1?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f33441a8-bce3-4fbb-7e04-08dcee3803b6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 23:12:32.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXqUGdbqtsGWSzmhyAyd3gnXkSbzUI0kDG5u87jXz5jLc3lCHv2+GoPMGf/sHAgIG/V+CNlK6ZGiStFnRRuuxMhSqmnjWr6RyQhdadjuwbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8586
X-OriginatorOrg: intel.com



On 10/16/2024 4:06 PM, Jacob Keller wrote:
> 
> 
> On 10/16/2024 11:53 AM, Simon Horman wrote:
>> On Wed, Oct 16, 2024 at 06:53:10PM +0800, Yue Haibing wrote:
>>> Return NULL instead of passing to ERR_PTR while res is IGC_XDP_PASS,
>>> which is zero, this fix smatch warnings:
>>> drivers/net/ethernet/intel/igc/igc_main.c:2533
>>>  igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'
>>>
>>> Fixes: 26575105d6ed ("igc: Add initial XDP support")
>>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>>> ---
>>>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>>> index 6e70bca15db1..c3d6e20c0be0 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>>> @@ -2530,7 +2530,7 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
>>>  	res = __igc_xdp_run_prog(adapter, prog, xdp);
>>>  
>>>  out:
>>> -	return ERR_PTR(-res);
>>> +	return res ? ERR_PTR(-res) : NULL;
>>
>> I think this is what PTR_ERR_OR_ZERO() is for.
> 
> Not quite. PTR_ERR_OR_ZERO is intended for the case where you are
> extracting an error from a pointer. This is converting an error into a
> pointer.
> 
> I am not sure what is really expected here. If res is zero, shouldn't we
> be returning an skb pointer and not NULL?
> 
> Why does igc_xdp_run_prog even return a sk_buff pointer at all? It never
> actually returns an skb...
> 
> This feels like the wrong fix entirely.
> 
> __igc_xdp_run_prog returns a custom value for the action, between
> IGC_XDP_PASS, IGC_XDP_TX, IGC_XDP_REDIRECT, or IGC_XDP_CONSUMED.
> 
> This function is called by igc_xdp_run_prog which converts this to a
> negative error code with the sk_buff pointer type.
> 
> All so that we can assign a value to the skb pointer in
> ice_clean_rx_irq, and check it with IS_ERR
> 
> I don't like this fix, I think we could drop the igc_xdp_run_prog
> wrapper, call __igc_xdp_run_prog directly and check its return value
> instead of this method of using an error pointer.

Indeed, this SKB error stuff was added by 26575105d6ed ("igc: Add
initial XDP support") which claims to be aligning with other Intel drivers.

But the other Intel drivers just have a function that returns the xdp
result and checks it directly.

Perhaps this is due to the way that the igc driver shares rings between
XDP and the regular path?

Its not clear to me, but I think this fix is not what I would do.

