Return-Path: <bpf+bounces-55069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D026DA77A26
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 13:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010553A563A
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916F20126C;
	Tue,  1 Apr 2025 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsltWI8T"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0041FBC92;
	Tue,  1 Apr 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508623; cv=fail; b=nBIBs+KynCUt1uM4sB1FE3GJ/GaBwxsYzda0t0gBmfHAaDSZGR61ycuvburUup0M/3gWslnaX4vwVyaBbu4BAlf5b5daagFnrKuKhqSWCPfDlF6xvM9gBVmzCOEoDMf006EIUKJM8aYLlSEFOIOVrSk4CQv3++CgfFe4UXYjA8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508623; c=relaxed/simple;
	bh=1/Q1XzplOMdoF1ru1XaR6wpPHQEJ4Mf6Q9x0iwxe2lY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DaNdwMnwi8Zcj+tz8unCPY1RVz0eq4sMC2vmODBpX0yLoU4gmKIrhxU5uI98TSyih6UeJuj34EXQ8szcC+2fXGc1CoZQrN/b5z9V+hW1HbQahkuix5KQ7JhF8roGcUwfe4I8U0cnIPoPM3WO7dFv9Q2emXeQhpmTiTW/1+dR1ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsltWI8T; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743508622; x=1775044622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1/Q1XzplOMdoF1ru1XaR6wpPHQEJ4Mf6Q9x0iwxe2lY=;
  b=VsltWI8TCgftus99hr5vO2qjvOlce0ehmUPb6A6pcO17hYeU+gYyHJ31
   Lf+2lVPHbaRybWDM9dRgTzZcZco02BD8YwoHVhPx1s9YYqSdrqkYA7r8D
   BkqQFaIaQPiWDt/aCrz/greCFvpYYjcsrr643TyNYGhI8yVl7LO6p8DWO
   67XGT8hk9WkX4POCXnYNu1ILdLObj+riLUQFN/+CgBjEMW0wLLYnAMxs9
   rOVX1vVAurOWMROhJOHG51knVQHhEzD6668dmdTzX5DZGyZgt8auPGRLE
   nzrt0u507A0IsZqDrOuOafG/NnYwUBZqw9wlMvO5uGPTptpEz3F6i1qJ+
   w==;
X-CSE-ConnectionGUID: gd1HIv8bQvWDsv+yJkI+xg==
X-CSE-MsgGUID: Hg790r27Ta6AcSSEufL+BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="48618355"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="48618355"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 04:57:01 -0700
X-CSE-ConnectionGUID: SKuvaNhIShCJt7O/LYDysA==
X-CSE-MsgGUID: oY30/f5hQ5aYG3ZYo94m7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126880931"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2025 04:57:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 1 Apr 2025 04:57:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 1 Apr 2025 04:57:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 04:57:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG9Od8HMxxznFOvP2qk16yGlBFoBxUvK/3M9zlld1DZxiexEcD/+etegdu60kJo3VvV3ZDrEDsEyMd9QxLN7DdJxstRPBGAJ8xcTmSBZCB/vTDYyZxbARaXN/fLewgrpzuj8ibRlVEZ8o9ZTj4bo5ieWioPSajYn1PVWhxv2WdL29HrU5t/BSd2J5mEAG5lVXu2KF4Yu1yERg8xer42KFS4wpXDZjml7/pz6GMsdwkBK+qd1Yv+Oiz5Rslce4H+aSxvc643tc97ZyKf6f4XuwP4Qd9YbOP3/wTX3UdwP0P5GcZ/e39U96ju11dDDkEvyYHhljOOJnXkd/2rbyffOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfOqHxmxImBldwv3Hb7AcGcEcKoABzZvhC0vSTzUQOw=;
 b=dbRJccRjGJ24IekSmDxkG4F/tmWDP/ML93cTUHzZ+Kv5hR64EfX1BYQs7eQd638VA0JWtWInYGJvbLGyr/vc+qbIWDmS5I7F1f9GKwaVs2UJxUpOoCkl3C3QB3IWH447H6WIHBrUBn8L+b3CUCY9k561FytzR0CYqnc5kh5RhK8A9vf6DIU5wQkELWyPQUd6BfPAW2STX2FIQOV8wK/KX1wAsQBHbOVyzhY7aZl8s1Tcy+1eEH/U9VRO1PCKlNEKcjQQt9/s4nxz/WXZWFlaI8QjKKaPQpuqG/2LKrfG+MYq5JPbiQt+TZL8Dq0ksk+MhvufV/7pjN7VEWU4R9jOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW4PR11MB6887.namprd11.prod.outlook.com (2603:10b6:303:225::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 11:56:44 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 11:56:43 +0000
Message-ID: <d3dcd3e1-c6ba-4756-bd8e-273e727b635a@intel.com>
Date: Tue, 1 Apr 2025 13:56:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Yunsheng Lin <linyunsheng@huawei.com>
CC: Zhu Yanjun <yanjun.zhu@linux.dev>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Simon
 Horman" <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Mina
 Almasry" <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
	Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
	<willy@infradead.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
 <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
 <b75c5329-0049-4c9c-ba79-a1132d848d5d@linux.dev>
 <b87a14f4-181b-4a82-9d71-2750699601d6@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <b87a14f4-181b-4a82-9d71-2750699601d6@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW4PR11MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: b11145d2-14e5-4018-f04d-08dd7114457a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M21BSHRXU2I5RDh5ZzN3eGpYOE1qdllocHlUOWExV21aa1loSEN3RTFYeHpQ?=
 =?utf-8?B?Y2xRU09zZ1I5UDJXMnJ0Slo2dWd1K0dVdUtoNFdjZGRWd3pIalJFZ0hiNFBL?=
 =?utf-8?B?L0JLRW9ZM0l1LzhJbGZ5VFlxSXJNQms5ZEkvcEg3SlRseGZkU1RSd0pKWDAw?=
 =?utf-8?B?RHJ0K0NseERxYlh4UC9EeDVkc3UvVFVNaHJqWGFvTEZTU0puZDE5NFBwZ2Zl?=
 =?utf-8?B?RUJwRXBwQlpzZ0NIOU9IakpMNEMyeGFwLzYrTW1zMHA5U2F5Tit6RFZEcUVZ?=
 =?utf-8?B?VzcwTEVyaWVtdUZwd3dQMDBoU2IxaFVRUW5nVjE1VmM2eVUvVHYrTHdubkR2?=
 =?utf-8?B?cHRudkJ3YmZFaHlQOWVGVzRUdExVYm5GeVVoTncvK1ZzbGtocnN1Tys3Z2hu?=
 =?utf-8?B?YmRDaS8ySkVzeUdBVkgvVEcxV2pWK3hZdFVxaUd5d3hGL2ozc0h5NCtlcitU?=
 =?utf-8?B?dE1jS2prWHhGUnVqZy9DRlNmZmlPcHNNdk1Oc0pKbnBVeHdNam8vYklrVzB5?=
 =?utf-8?B?eE1MeUE2SnJVL0pNTWVRZ0gzeVRSaFhDR1A1bTFjY2NZWGJWNmo0MDhMd0pK?=
 =?utf-8?B?akJnL2VKcEFML2ZidzlhY3VOSjlEdmM4Q0xjWG9xWVNydDFwZ2JnMFQ0UUF2?=
 =?utf-8?B?WWF3T3dTTXc3eXFnZ0k2d3NzZStnSk9pa2dmZjBiREhXNENJbkJkOTJMWHNZ?=
 =?utf-8?B?bERHWFJRVEJ0bVRQUmsycXdrT0xJL1laWUl4Q1RXTzdQdTVPTzNrVVJlaGRN?=
 =?utf-8?B?eGMvbmFSRlkvOFJ1WnBZWi9oOG9MbzlkaGRVRVRlVTJtcHNXUjJPeWthOUZr?=
 =?utf-8?B?MWtzN0ZTQ2w3ajhSNDhnK2Y1cVRTQnFlYUJFVjZ1d2hpR0F5YXpaalFWd0Z0?=
 =?utf-8?B?MWZPeE12bkd0K2NvbkEySU9yU0M3eVhydVVCV055eEtrOGxqbDNER3lPSTJC?=
 =?utf-8?B?eldVZFRMNXJXTzNxMnNQeWxoTVc0NGtJR0JubjhSUmFxdFhRd041dDZoSVV0?=
 =?utf-8?B?Yzg0dGFwYTJvUzBKYlBxMGxSQTczdTFFRG9pSU4rNndOZGFjYjFCcndobHZG?=
 =?utf-8?B?bU5lQ2NXYmduWnIvc1MraWtVa1B3eFBEM1BpVk1QVEVWVVJCUFBIU29ydzlK?=
 =?utf-8?B?VldDTzRFYzJuakx1SHRsY2tkdzNiRmJhMlNRS3kzWnM0cHMxNFNOVE1ic0hW?=
 =?utf-8?B?R0RXSXoxaGpHU0lWS2JQbmFkTGtNanpkejRnbTZ3b05CS3VmRlo5Y295ZGJw?=
 =?utf-8?B?cXhNTkZwRlVvdmNWUEhxaW50TjJvSzZCeFl1SS9iN3JZb0VaN1VlS3pTUjNL?=
 =?utf-8?B?dldENWdqK0trcGF1eHVIUjNzcGJoNGpDeWgzYVIzdDBKMlBkaXphRDZFZC9W?=
 =?utf-8?B?RXdLQktxeUpVM0xSdVJ1UkYxcnoxTTBMZGl3YVNhUXlubnpaVDZ5amIvN2hI?=
 =?utf-8?B?U1BBbUtGbmVNNjRlVDFhZnlEeGdPWnhKdi92ZlZFUXZDeVhoZFExbTJOcmc4?=
 =?utf-8?B?WUo5YzB2am9QNmdvZjY2WnpZNEg3MUVmSjF4RzBqcDdxd1c3Y21ndXNkVEE1?=
 =?utf-8?B?L2cxN3MrelpZNHBnRGUwQ2VFVFFrQk1wYlpQRUY5ZHp2b0hwMXdzZDRndEZ3?=
 =?utf-8?B?QndTeGh1KytPQ3lwbmZOb0t5aTloR3I2Y1BNOVlTZ1QwVEwyOStpeHdmREls?=
 =?utf-8?B?R3djRmQ2dWxMdTIwdXgwTWxUZUl4WGFEWHBVa1RpWmtHYjNTMUxDaUd5VnB2?=
 =?utf-8?B?N0ZQcFhYTzBja0p6WXA2d0VrM0NENkZHUFNmcDNleEg2VTNpV3BpejB2VEt0?=
 =?utf-8?B?SmYvckIzVU80RCtoUmwzZEpPaVVPT2RvdFdONXJickRPZU1HM2dtUWVpS2l1?=
 =?utf-8?B?eUtkSGFUWWdNYWdJSE1pMWpHSWlreCt2YVMyV2ZUME9uMHhKNUg0QlB0NUpy?=
 =?utf-8?Q?mb5r66Dyn3E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlpWcXUxWmE1aXNmSkQweFVnMDVxelZ2TjFpR0ROV25VR1ZFeUJtbkNac2hB?=
 =?utf-8?B?TVhYM1d6SDdabkZZdGc4OE1oTDYxZUZXeDk4U0VYUlZOMkd0SnZEMVdxQ2Rp?=
 =?utf-8?B?bW1aRHVsN3lITFJkZEVCczZxVWhuVXFjRmVBZmRmR2s2azBVbStLU25hUTI1?=
 =?utf-8?B?amFxYkpwVnNyS0VpZktVcDc1aTZtZkptK0lmaldLQ2dHZnhKYktHZCtHQlJT?=
 =?utf-8?B?QlhXbGwra0NhTDRVMDZMZGV3TEVDUWZsU1BKRUN5anhFRVAzaXpKWkppNUNz?=
 =?utf-8?B?LzFqbmdpS2hpbGpQSWg1d3o0Ti9iRG5SNTJ3d3NyUkdCMytLbHdYc3gzcFlW?=
 =?utf-8?B?cEE2WVFobTIwN2VZSmZtNEVVb3ZrUE8rWWRHcFJVVUoxcjA1Z2NObW80Nit6?=
 =?utf-8?B?WEV0aGRWTGJYVUtQT0ZRajZPMW5yQVdaTE5qdng2ZXBDd2R1YnVDZU9rRzBO?=
 =?utf-8?B?SjVXbmNmWmhqeFhzazdmbGhBRmZUZGZ5aER3TXJ2d2grWFVqRTBESjQ5TjEz?=
 =?utf-8?B?V2NtN1dUSkh3aFN1NE16a0JtQ3F2M3lzV3huOXY3U1lBQ01GUzd3K0wzTE80?=
 =?utf-8?B?N0VhUGNLeUZpVDYwekNDaDJvME9vSC9qUkx5WllDSUZzbURJWEZxNWZ0cmJr?=
 =?utf-8?B?ZENoS3VLV3d0bFNMVVdtaHBQRW5MMnp3TVdHcHZyaVN2cnJ4NjZ4K3VDOU91?=
 =?utf-8?B?QXE4aDBrRStYakhUMTlLcDdNeElDYnZhSW81WkptaFBzVUF3UmRHeWZjaUZK?=
 =?utf-8?B?MGdDeUFsa29yaHBEdEJRYkxiYmJOQ2lTUkFqb25NL2dWMmxqWTdETW1wMmI0?=
 =?utf-8?B?eHZUVjAyL3UzVXlkN3JZOTFTeDNQTHlNeGFaWE4xUlpuMHdIRVBaNGprVmlj?=
 =?utf-8?B?VlZEaHpSWGFwRkJJcUpsdWJwSFdkWDdZNnJZeUVIMGg1U2lRa2UrSUdjMTlp?=
 =?utf-8?B?SVF6QWV0ZFg5SnlURVptQk4wcEJudTBLdVRTQi9WUWozNW9tQVdaMFgvWlFr?=
 =?utf-8?B?RHFiSXA3eWk0VGJncnR2RVpFbmsyc3BmTWQwaWd1NUFlOFRHRUtScDJYNVJT?=
 =?utf-8?B?RGtJN0FRMHdxWE9oRmJBU2VhYU8wNzJ0cnBUM1FObUc2d3pVZ015MFFsNnZL?=
 =?utf-8?B?WU1lV2Q5cGxlbmlTNmFYSHNmY1gwZHQ1YVJMQlN4bGp1QmYwZGYzNHpvb1hR?=
 =?utf-8?B?Y2pqYk9KTlVTTUQzUXNlZ2NNVkh1VVVvaTAxQ0RCeGlsZXJQKzg2STNnWXhL?=
 =?utf-8?B?SDJLenZkY2Qzb0s4aXZCSVk1WHhEZ21PS0xSakVpUjRxeUNpYUQxamlYNllM?=
 =?utf-8?B?ZE9FNEhRTVB0c0pIckRlZzhLUS9tQzlMSHQxWGhyR3VwMldGc1o2aXNtT0dY?=
 =?utf-8?B?bzFNSzNyWlRHdnBWbEFMSWg0OURBUmhSWXd6Zkdxb1BDd3dnQ1FRV3htTlIr?=
 =?utf-8?B?NHZMc201TG91UW9SSEJMZlVyU1dXcGxNRy9YRUl0YTFreURCeWFHZ25TMVJV?=
 =?utf-8?B?L3c0UWw3STkvMlo0UktYSnlxeWZSS21CeFd5eU1YOTR5bUhKNDBmZVg3cHV1?=
 =?utf-8?B?UDArbVY1VlV0YnBncnpaSGQxYnRtSSt1c3BIa25YeXh6WStjQlNVMDUvKzR1?=
 =?utf-8?B?Mk5DNktKYXlQTWtsOUd3by80b011cTFMK0lMWUJnZ2kxMWJGUm1jSzBoeURr?=
 =?utf-8?B?U3FZcUJvMHpucnJnK29IbkNqKzRpWDhXZzJqc05UMWlNUUNhOE1ENlE5SkN5?=
 =?utf-8?B?RmNVT1JTeHJhYlAzSlNMOTNDaGlGNzFZY2o5SW92dForQ0FSYnpUeVdrWnk5?=
 =?utf-8?B?eTJnU2JNMDFGRk9Sd0t4UitvWXRFeG9IcW1XNXVBM3h3ZTMvbFVXelUvNjBu?=
 =?utf-8?B?QjVEMENZUFVVaWorMHV1YWV0ZHMrMlJoNXA5ckwxa2V0MWRDSm83bFZEazNP?=
 =?utf-8?B?VFFVTFlvYUFOemlsOUdSazFMdHpRU1BRcE1lWFFZS2orLzBVbUZ6UWVtejhG?=
 =?utf-8?B?SWI4Z3BkcTFSSDFRaE10Z0pMbGNnMSs5UE41SXZMTW8xUmVyc09SVkdXVmp2?=
 =?utf-8?B?Z0tSNmxLdXJsanZGUElnWUVLSXIrWFhHai9qMEg0aUlmRGRMZW5HVWRlb09k?=
 =?utf-8?B?bndwS3ZWbC92SUVyLy81UFB1UVYwNWcrQVNSTno4TTFLSmxMa2Q3Q0grWDE1?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b11145d2-14e5-4018-f04d-08dd7114457a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 11:56:43.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJ9C50u/vrxHB82tui59u3HnIHgKT3fA8acLy84M2xnVB+IK0rY4v5ey5hwVWMxGK1TwD6kmY0Rppt9QowTN4vUcpvA8Xwho9GAcSTiSodQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6887
X-OriginatorOrg: intel.com

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Tue, 1 Apr 2025 17:24:43 +0800

> On 2025/4/1 1:27, Zhu Yanjun wrote:
>> 在 2025/3/31 18:35, Alexander Lobakin 写道:
>>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>> Date: Fri, 28 Mar 2025 13:19:09 +0100
>>>
>>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>>>> they are released from the pool, to avoid the overhead of re-mapping the
>>>> pages every time they are used. This causes resource leaks and/or
>>>> crashes when there are pages still outstanding while the device is torn
>>>> down, because page_pool will attempt an unmap through a non-existent DMA
>>>> device on the subsequent page return.
>>>
>>> [...]
>>>
>>>> @@ -173,10 +212,10 @@ struct page_pool {
>>>>       int cpuid;
>>>>       u32 pages_state_hold_cnt;
>>>>   -    bool has_init_callback:1;    /* slow::init_callback is set */
>>>> +    bool dma_sync;            /* Perform DMA sync for device */
>>>
>>> Have you seen my comment under v3 (sorry but I missed that there was v4
>>> already)? Can't we just test the bit atomically?
>>
>> Perhaps test_bit series functions can test the bit atomically. Maybe there are more good options about this testing the bit atomically. But test_bit should implement the task that tests the bit atomically.
> 
> There are two reading of dma_sync in this patch, the first reading is not
> under rcu read lock and doing the reading without READ_ONCE(), the second
> reading is under rcu read lock and do the reading with READ_ONCE().
> 
> The first one seems an optimization to avoid taking the rcu read lock,
> why might need READ_ONCE() to make KCSAN happy if we do care about making
> KCSAN happy.
> 
> The second one does not seems to need the atomicity by using the READ_ONCE()
> as it is always under RCU read lock(implicit or explicit one), and there is
> a rcu sync after the clearing of that bit.

IOW, are you saying this change is not needed at all?

Thanks,
Olek

