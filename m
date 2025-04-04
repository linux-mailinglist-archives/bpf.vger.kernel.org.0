Return-Path: <bpf+bounces-55342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3C6A7C15D
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 18:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A76217786E
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371362080E2;
	Fri,  4 Apr 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJzhwzZw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BCE207DF4;
	Fri,  4 Apr 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743783305; cv=fail; b=k/0lUfZT13Fb2L/soUiTIXJlcroajCHwCHnJDE40A5cLgNqq+DzJ8ePWzX1mKvC6k+Wspp06mQWsl3brkyB2kyfvRykxbQD13MrxU/lFV/0BDIUvHhQJUQ62YZq+D6bnetxYAxrg73ELdrRWzC+x4cCMpSoELHpzEiezbTze2S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743783305; c=relaxed/simple;
	bh=VoCKAdL9xc9wDtp1o0grhVioqa/qoRRylsr7ytlPmVo=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TKsChtxMEr6MCW+9sMi3D6xTMrOFgYRDD8T60RVHwgBjTaOrd48Gc3vQ/TkwlPVpqpjbClBOJIPzwsZcO+tE5Cb/emKi5Nd3BtdpKmkEisJmQLXL2HUq12VvR+y6Flqk8UPZt0Pr2n8tXP5FG1cEhyRsX2jksFBvlKgNn91r9Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJzhwzZw; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743783304; x=1775319304;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VoCKAdL9xc9wDtp1o0grhVioqa/qoRRylsr7ytlPmVo=;
  b=MJzhwzZw7b5vctvoPNwtODgRkC0VdP9LiZiVJGOXFs+6oqn7bi7JzjCU
   +nGap6zvhZujvJShuaEVU61pMJaDE0wYZ/ka7X0ksFCfNfboNNPTvYwRe
   tF3jV5nYyq58Yzs7hiFA7jgKiwPt48bxVmf2dfcH9mjF0vHBg95R8WMyY
   Uq0xp0BPm1wmijABWrMQXY1PoH1Q9YRN4GJCkHWT/oeULQqEgDcdUv5BH
   hyex0N1+JkvAqWruNV+pJA1ou+lD5Tnmr5sJXf79DeQzPwplhP853XT2n
   LInFiaiG6PNOevib/2qwmAhlweUxYLXWFn+qY8dqd5xgDtmhfzxI0Snlj
   g==;
X-CSE-ConnectionGUID: PxeaHd9RQpahY4Gmd8bJeg==
X-CSE-MsgGUID: nRn+5yjpR/ej7RWKywzt7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="70599775"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="70599775"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 09:15:03 -0700
X-CSE-ConnectionGUID: v1weHHKCSSekLHHW1SN1pQ==
X-CSE-MsgGUID: 3l0bjKGGSV2gjSJSdIS80Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="128265687"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2025 09:15:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 4 Apr 2025 09:15:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 09:15:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 09:15:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcgMaKqxHTjMjJP/pF94c1bo9kEzy694wjlTDXGvio6cGOI9UWv1fATq5T853uyNCO+vDzbtR13KfVJnSziTd1N9ItbRC1qpj1sDawiAc2avgDTWKfLE9tdTK1qNue1OaVfy89Dzr0nHHOgaMHNzASNf1rwo4Oxwqh9B27aKZXfV0M9BaVngd0MAtEn8F1+sFm1bJr9vYZB3JFHB1sPiz5WEBltg0KzSb6SBVcZQtmraYNEbkWq8kJSf2O/cb/30HHzPC/RcppEemZTeNfLu2C//jNwupDEoO2Ux/IrSw+3DFZGaDRB1u9HG/Db5t9pjxt/N3nNjteNWrl1F9/WkwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4+v+8zJAsehNe98w9Q3mTHl9wUDSG/NmRxZobDIE+4=;
 b=XmuCmd9FWoBVVxpGlbdAV029imGggbI5GUQ/EuR85NlPy7I7/sLJ9xGhRdtVu1ihiA2BtOHN+JrgiP6D+tS2Q7sVDSyUKuTo8H0C8T4u6TOieIY5AD4yvNEQq35vRIUgqfHS851cn8d5fttQmnqkhN1ubezi1piWOFif+VYFgJPoc6PneU2RDvfALRoip9uiNtUnp1LXXm6DrdXcYDn4/M56gTOZF0KQXtz3tjIxc2GS36UUY9uy767A8Q5MFG3UsNIVBk0T/2CIpJ97uIrIhOkxXpq2/y6Jv3Z8GfXYWqoT57froBdewmJo4b40EGvETGSAXRJ4MXz2ld4sMNemDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.45; Fri, 4 Apr
 2025 16:14:59 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%7]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 16:14:58 +0000
Message-ID: <d7780007-6df7-45f0-9a08-2e6acf589a6f@intel.com>
Date: Fri, 4 Apr 2025 18:14:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"Simon Horman" <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Mina Almasry" <almasrymina@google.com>, Yonglong Liu
	<liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-2-ad34f069bc18@redhat.com>
 <3b933890-7ff2-4aaf-aea5-06e5889ca087@intel.com>
Content-Language: en-US
In-Reply-To: <3b933890-7ff2-4aaf-aea5-06e5889ca087@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0109.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::38) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|IA1PR11MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 07532704-8f46-476c-e9c4-08dd7393d882
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjlQdkQrSE5jZUNVNnhVRm9Qb2xEdHVhREJYQlJlMjdzMmZFSjc3Z0FZeW5k?=
 =?utf-8?B?ODRWWGJtRmdHMjZSZEdicExGcVV6d1hGZklOaWJpcUVVRm1DUVQ3aVZWRkpW?=
 =?utf-8?B?S2JZSy8xVytrNmc5MXZlU0l5WDZweEhDSzB4cGpBNlIzL09PeG9XNUYzWFRQ?=
 =?utf-8?B?eTI0eXVQNUR2QnJHbDVmY21LUkZsZk8zRWZzZk0yYVNWTHJpQkVJWXo3UzRO?=
 =?utf-8?B?RlhmSTlPLzdXZGhGa1AvZW9TaU1lenNpR0huVXhKU3pPTnhpWUtyWEtVcm0w?=
 =?utf-8?B?clhpOFNhUnBUY2RsTmpxazMzY1J0UWgyTmNKQ2NJQlRTeDUwdklNZTIxazdq?=
 =?utf-8?B?YjlpWVE0YTc1WXRyeVVLc09JanNqWHhDRE1rT28rNDZid1BtTWxPdlFRUHdR?=
 =?utf-8?B?bUlBNlR2WFNpaGQ1ek1qVCtyV21ZZStaUDFXdUJsSC8yclNuOEZ1am0ycWV5?=
 =?utf-8?B?d01BTmZyS0cydXBHQmJmS3dsaFZKYllvK1AybnU1SVhxN2JDbWRpRnEwSFZi?=
 =?utf-8?B?Q1JkNmZZOFZMVk5lRVAyNmxjcEZUemx4clo3dkZlampkaHNJeXRQTDZtYUJT?=
 =?utf-8?B?OERTYk5qeEpQTnQ5V1RkTFpodXJtM2xNSU9lVW52VzJnVFFaWU14NDM5bFh6?=
 =?utf-8?B?ZWFxZ3g3S25Sd3lxajM0RzFrSTJhM2ptV0NWdlVabU9pMHhML0ZOSXZPQlVO?=
 =?utf-8?B?dkpxT0NTdm11cmhKalFjKytTdHF2aTJvZWJrazFUK3pZUzdUNjdVeWtQekVt?=
 =?utf-8?B?UFJPWXk4RHAwSWtDVWNrZVlrdGdkWERneTB2WUwzY0Q4ZkRZOEd6VmY3QTJo?=
 =?utf-8?B?dWxxY2RnZDNnYzdZU0I5bVpraVBYOHVrcEg3N1FzbFFwWVRLZlArNXJ6UE1l?=
 =?utf-8?B?U3NwRVdpSlhDS00zNElISitIUlpjOUJrRVRVSTZpdS95akFiS3FYS0tjNHVZ?=
 =?utf-8?B?UVk3TjFqeCtRM2tsK0VPY3lFek0zY2w5N3UyOVY1dnM5RmxOOUd6dkJOWHdF?=
 =?utf-8?B?Q05jZVpBM3MxYUs2RGxzbFV3QUMvZzVXUlRhc1ZlbnRoR3pxY0ppQWNtVDV0?=
 =?utf-8?B?MlIxYzhBYjVqZ1VTR3RkTXRhdVpIQlN4YXZ6Rlo2YTFzNFJRdGNXUjZsczJI?=
 =?utf-8?B?RjhHbW9MbmVNcFdEb3R2Q2EvVVR6cWVJbng3ZGc2aXM2c0FZYXJLYlNrcEhT?=
 =?utf-8?B?bTE3dlBodXBkQjBaMUh4dUtseS85WmdzMjFiSEhQN1B6aFNUMXI0eS9sbVdp?=
 =?utf-8?B?ZndQdmVtbHVRN0RKcG9xZU02TVJGWTZpNjlKYWxCTk5rd0xoOW1UK21ySm96?=
 =?utf-8?B?VGZ5R0JEKzlyREtkbGJDZ0ttdHBWcC9yUDIrb2V3SFVkSmNGaS9ENmpKM082?=
 =?utf-8?B?aHRvOElBeWRFMnA5WnNLTXpTSjZtWlBsMWF0SjVsNFBFSVJmcUFITlZVdmRr?=
 =?utf-8?B?NmhWQ0lFZWlDNDA0NEYybEwxeDJ0bUZiTDBYMWlkNyszOGRMSlpyQytnR2Fu?=
 =?utf-8?B?YUZ4UmlJWktZL001bGc1SjU0bVdrOUUyQ3dKSG9SbFJHSHZrS3RVZlVNdnd3?=
 =?utf-8?B?ZHY1ZTNhQTZsTk1ZM1FqQjd4REZHL0xLeTJQcHBXN2NxWjNVcEhkS0FvRlZn?=
 =?utf-8?B?QTlaVWZrTWtHdHUyVVBTSit4TzhlcmFIbjg0cmwwVGE5WFF1Skh4QWpIU3JV?=
 =?utf-8?B?cStwM05wckl2cSt2Y044K3FRbXFTcmVnRlcrN2pMdDN2VHFrVHgzY2N2clJU?=
 =?utf-8?B?RXlDalhsNmsvaGdmY0srYUFSTGxuY2dIa09wSzNvZWhHZDBibEJNMUVBd05D?=
 =?utf-8?B?dW1rRC92cXdrN09NREpPVkUvMDJhRW5vTUZUM0RoVkI0V2MydFYrekZTcys3?=
 =?utf-8?Q?fFdnAFzhV1tPk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d094dTFRUnNiMWZaTkFOclp1UGJDYTVudEphbVd5by9HUFhVZXdGMEVsdEdN?=
 =?utf-8?B?M0JJRS96WWNqeThHNTA4bXhQQXRvSEVwQlhhNk4zUzZNb3RGWXR0cDdnYUpL?=
 =?utf-8?B?clVOS1dxZlhLSW4wV0ZXZXcrN21sWFhpeGtsbk5ybmQ2eTZtMExmRUN2ZlM3?=
 =?utf-8?B?bDZ5T1A5ZTJiWTFpWEtNN3RiOG1Zd1dFK01zVXpaNlVFRkVRZnowMENldkt2?=
 =?utf-8?B?NUJjaCt3U3FNSUNqaHBQcHdpV21XNko5b2thVVBnM2gxRUs5SldHUnk1N2hm?=
 =?utf-8?B?cDI1eW9zVG91MmRiSGlRcUF6a3hpeGJvOE55emI1c00wTStUN25KaHAyc1Zp?=
 =?utf-8?B?dnNveDhXa3JEMDhYMFZCZzAwYi9lU29yTU1PQisxMDEvTjJYSTYxRE9acTVt?=
 =?utf-8?B?Ym10d1hkWnhBcHhqaHpOeWdLaDAyR1gzelUvMlJSSFJGOUt3YU51REd4emVv?=
 =?utf-8?B?MDdGK2Z3OXAwNXNUeFI3a2tDSWZLTnFXRmg1b0wxMi8zUEZVSDgzendWc2Ns?=
 =?utf-8?B?aHN4OWxnMUF3MW16SStuZER5S3EyV1hRbFdZUmFId0pJTWdqV2U1ZENaNCs4?=
 =?utf-8?B?Z1RUc1pPeEFaVnZ4ZVVsNkMvU01QejU5amNTMG44amY4VHorQmVDYnVnc2VW?=
 =?utf-8?B?QUR2ckJGVlN3aWxvZktrR2dwS01NdFdLcE5DU2k0N1B3VFhPQkF0TzhVTnU3?=
 =?utf-8?B?ZFBkdXJ0WTFObFg4MmdmUmRIWGtwQlBMU0ZNMUJuMExBcmpPQ0kvWVJndnJL?=
 =?utf-8?B?QXBlWHRpeVZweHExWGFlYy95bFZ1REp3RDhRL1ZLU0RGZVZ5MGlpK0pGaG1r?=
 =?utf-8?B?RmIvMjdkRzRMQVVWczFhTmd4OTZBL2oweFJ0eUpzUzYzSGQrdHBWbUcvMFRr?=
 =?utf-8?B?bGNHWlVLNFBYTE1pb2VoYWEzQk9PUEVlWmUvcWtRYkY4NkRFV0pkWXJqWHM4?=
 =?utf-8?B?a0JmTjdPV2YzQU1JYnFEU29VRTU3aUZlbTBYS2Vva1pmd2RKMzJ4MXJNeitE?=
 =?utf-8?B?cnpwY2F4bnpkVEFKb28rZ1JZUnVRVUFNVkgvRWF6TXUvWDF4aWhtZlltT3JI?=
 =?utf-8?B?ZmFYVTNnN01ERXBnbmRnVzJ0dzUzUklvRWd1ZkZvZndmZFNOU0ttMG44WkdF?=
 =?utf-8?B?V1ZsSjJTc3J2V2x6OUg5TG1aS1VkVmo1RFU0LzF1Tmo1N3JPT3E2VllVMlh0?=
 =?utf-8?B?Nk4vYVQzTFpLVWkzN3JpVVFMSW5raU9JdmQxUit4UG1DUG04Z2ZDWElweTcz?=
 =?utf-8?B?ZWJIeVAxcDcxL0VTcVBwVXFKVGxaRFRPL0tCWlYybnV5d3FrUmdjNXBlYTFw?=
 =?utf-8?B?VVYveDlsWEdoVWFGTUpFZ1l1Y1E1ZWdWK2ZzbE9JajBZK0FCVG5JK21yMDhV?=
 =?utf-8?B?ZFUxWmFIZ1VJZWVIU1JWRG9SVWJCMit0MUNqR3JMb0dYRkp5aTY4aXhzeDlR?=
 =?utf-8?B?S2g4WWtTcGFlbUR1SmQrcGd3d0dZd1ZSOExRZFlLTjIwamRneDU3TS9TNGti?=
 =?utf-8?B?WlowaEJjTnNYcDBkVyttTUJDbHgrVjJXemtMOUViMk5QZEFPTU1PdHNDNlFK?=
 =?utf-8?B?T2ZqRUZwRGl3OHU2M1VadHBiVlhKYVVzWW5IU2RLRFpzQTJHOU95Z2k5VCtz?=
 =?utf-8?B?R3g4cSs0cVQwYmhzbWppQXVBSy8xNUxpaEd0ZUFnQTM1SXdKZGZJOWhDWEJT?=
 =?utf-8?B?cVU4N2ZYeitqZGc0NTBwS0JqaERxNjVndjY1WmtXcGJOZmxPWE8wbXYyYzlS?=
 =?utf-8?B?RmZrcVduZ1pKaWZ2ZkRHOXppV0JOUlVOOUdONDYyL09LOE1nL0ovUXdqU0NP?=
 =?utf-8?B?dlhJSzZ6RC9KcGRWRnNXRlFvZTEvWjRwVkc2MEEyMFlyU0tKSWxiVElsUVBL?=
 =?utf-8?B?MWo2Mnp1cVVjQUxQNi9DQWp4TndMVEEyRitNRTR1U3ovcjJZcnNkZnBtekVx?=
 =?utf-8?B?UmhYbUNzaGJiZ0NTbWYvVXFleEsxNmMwbXJOeFZuYko0UHpOelRXNG5QMHN3?=
 =?utf-8?B?TnIxMmJ2cThRQzhrQldiYmt4cWZRRUF3T3l4MFJKVDhVRHlRbVhhaGtLdVhE?=
 =?utf-8?B?Smc2RTBGaTJzME9hZ1lCYk5sL0JZRUkybU5ZeFpiTFphbmdZZGkrNXFGN2ZR?=
 =?utf-8?B?U2ZqM0NrOXZ1eEp0cy8xSkpYVWFMSTQ4V1VjNkhCWFJtYnY0emk1Mk4vdFNh?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07532704-8f46-476c-e9c4-08dd7393d882
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 16:14:58.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lPyemqyDlpRp5nOc3tMhchgjzy3QXsPkNPda/3hOczCysVgkKBp3eAxLnuNbp/Ky7L2MCtSFueOdWeIcfgYYI819q3rbY+CbeRrnTP4jW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Fri, 4 Apr 2025 17:55:43 +0200

> From: Toke Høiland-Jørgensen <toke@redhat.com>
> Date: Fri, 04 Apr 2025 12:18:36 +0200
> 
>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>> they are released from the pool, to avoid the overhead of re-mapping the
>> pages every time they are used. This causes resource leaks and/or
>> crashes when there are pages still outstanding while the device is torn
>> down, because page_pool will attempt an unmap through a non-existent DMA
>> device on the subsequent page return.
> 
> [...]
> 
>> -#define PP_MAGIC_MASK ~0x3UL
>> +#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>  
>>  /**
>>   * struct page_pool_params - page pool parameters
>> @@ -173,10 +212,10 @@ struct page_pool {
>>  	int cpuid;
>>  	u32 pages_state_hold_cnt;
>>  
>> -	bool has_init_callback:1;	/* slow::init_callback is set */
>> +	bool dma_sync;			/* Perform DMA sync for device */
> 
> Yunsheng said this change to a full bool is redundant in the v6 thread
> ¯\_(ツ)_/¯


Under v5, sorree >_<

> I hope you've read it.
> 
>>  	bool dma_map:1;			/* Perform DMA mapping */
>> -	bool dma_sync:1;		/* Perform DMA sync for device */
>>  	bool dma_sync_for_cpu:1;	/* Perform DMA sync for cpu */
>> +	bool has_init_callback:1;	/* slow::init_callback is set */
>>  #ifdef CONFIG_PAGE_POOL_STATS
>>  	bool system:1;			/* This is a global percpu pool */
>>  #endif

Thanks,
Olek

