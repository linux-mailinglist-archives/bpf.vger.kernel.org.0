Return-Path: <bpf+bounces-54196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459ACA6544C
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 15:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B083B5417
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58C24397B;
	Mon, 17 Mar 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyV9ABmm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A31238162;
	Mon, 17 Mar 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223026; cv=fail; b=r6lz3yboL4r8EPi2IAFBKZ2Y2wShrznJPgF9qlnS3+pPZja3DSpcKL2QzmCtHHJASKgU0fZ5320T7MOBoDGG/kMjor5/Ly/O5Hs9Wmc4cPfTjsXHiy7PUczABzGOXYUGajaS5jatL/tGmatU1M2t6G34itnqH0t7q+oxOjlTBRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223026; c=relaxed/simple;
	bh=99U3R6KmO4mfLNpP9wQ5nbG0PQ18fU6FoGIW+poGzCE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s8j7XT6xgSQb9u1t4+7qBH0SK6Sr24+EIOZSkGmySWQ4zmzfj+RxViYiLWlMRSJaWYW5CfIGLkuZXetQUlmf3OLzWw2K5fM2OUgAkp4Jph3iYEip+3dHXbA2LwXBVhQ9NG4FSObaWj/jYiXsJ04w4qPOEcpkDuSPXtTtQtKB8dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyV9ABmm; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742223024; x=1773759024;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=99U3R6KmO4mfLNpP9wQ5nbG0PQ18fU6FoGIW+poGzCE=;
  b=FyV9ABmmAyNqx1AyhPojLEFoxtFIIcOT+Z2z43rsAhAnhBHrNX4FlY4f
   9CRpLE9zzAR0Y4/f8/iQfqw3gwEucPk7VpvLcVBopJ0gmVOQk+ByVsCAf
   dqQikGRoIAfCqjoBUneYu+TLIK8RvDLV0XiTYOeWJezM92/jxhEA1bYCS
   YdQzlequamVmrmxT8ue2bt7GweR+VAYIJmMxG8wtEj/E/7r3jUIRpTKuJ
   MhjbLZGKweC7ylJsNkoELdU589cZmY0f6SRFxW9Ir3NWhUmNwYLlZigFQ
   u8Cdq3Ml+G5exiITKR2eqrZunlkSirqtFHCLd+aOUHFPepdxMH3fmbPCu
   w==;
X-CSE-ConnectionGUID: hF38rhIkRK2l9GbGkzC0FA==
X-CSE-MsgGUID: 81lIwoRzQ6+9LAwlEtL0zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="47213877"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="47213877"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 07:50:23 -0700
X-CSE-ConnectionGUID: Atlu8HJLS4qXSCBMR3Sabw==
X-CSE-MsgGUID: YeEaTcKcSX6aJwHJzeSBpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="121912261"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 07:50:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 07:50:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 07:50:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 07:50:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcdM2FNKW5ZyiCqxTr3Lz/GGa2tPGYnW+nPupzK80M+JJQ//D8/cH/XJ0QuqpvpcF18iBrsL3eCXzx2zcKsd2wbWYQfNOdgVqts0x6SLdVKmrUquJgMcn7eAY/vZeQ6F2XsSFH11amhf21aDZUsKTrYpFYBuPMT7MYGbhXZ1Os0gsz6TC1qe4jpqaGWIfPfTeI030wKPGw6QiME9268Dxl4h8cAEQz2s2f38FSjhX9HTRT0MnQ3uDRGlmiHDuOnna/HVdBsOMPsLUZYg1+Tf99TXff6Eqczlrv8pH5wluM+oLQesShroi5xxv9F36vCkod+1/pooJQdzK3yoHxwxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WIJ+8TBnZgt44xIupXMy1EKcwd+joAjI8dAsqjHLCw=;
 b=vK/jfHClk3GdZezG01/ZQmVqPlUzEC0o0mBaJGO9gDV5aDqhXN1Xw31rAMTRKPqCmazeFhHmFNXCV6mKlnyGmwPAIEt5SQDPWDzUl18ioQj9IVuqU99FN6YJwpgAO2Xfr3YeDlnoovDExqqzPMECSqY6TUFg/P0A8v6jM33MAByVDbsxAX8D5cGEtZFqK98HKl2VlK4XHsSP3T8O+HySk6ZySoUcfO8gtxs2pqFjVRivFMZM68Kar/sPpYqbOnQquz5NOP7gTiM/PGkkGz8VmBCS3UqIxYxfREOen4czumb6+Q6aIHRyhEz4nnTglc8DRDVM5YYT3cyG2UILV5y0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CO1PR11MB5060.namprd11.prod.outlook.com (2603:10b6:303:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 14:50:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 14:50:18 +0000
Message-ID: <a49604cf-0181-4e91-920d-206a799f67f2@intel.com>
Date: Mon, 17 Mar 2025 15:50:11 +0100
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
 <Z8r0MagKeUNHwfQk@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z8r0MagKeUNHwfQk@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CO1PR11MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: a92efb4b-3d41-449f-51b7-08dd656308ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnVMS0NuVzdBQkxHVWxnRjh5Yjg4OEtxSlMxNkxvYldCK2J0dktlT2RDRmNh?=
 =?utf-8?B?Z1owRlh4OHpMOHMxeldjMU9mSFlnS0VmcktFUDQyUzlReXdmOC9rRk1VSG9Z?=
 =?utf-8?B?b1grQVF0NHBiU2JEZnlNQWtDTVJyNHdrWS9pUzVjblhIaFcxRkluWmJUNExG?=
 =?utf-8?B?dDUrc3F3R1lraUhub21qQWVzTHNoNUVNanJNUU1TbnJvaGxBQXBFV0xLRUZV?=
 =?utf-8?B?UXdRcjlnd2RPOGdxMzFlbmNGU1oxREJpOUl4Nnk4SWtKMWRvWmZZTVBXSmxl?=
 =?utf-8?B?RjFMWVFidVVoRUFOR0JtMHl3M0Z3MUVsNEkzMWhsRDBzZ2xoVlZDVFZFOUNX?=
 =?utf-8?B?YVVCbFRLZmVkbUdaQ0FHdU5LbVdxVHFQbyt0anFvcTN1bHVrYmZpNG5vT1h1?=
 =?utf-8?B?VUZrMHVINFo5TElreTZPWGE1K3ZzVHZoSzE3Z1ZVdG93RHNkVXkvS0ovbnFz?=
 =?utf-8?B?MTFrWUxKWDdaMkZreXBLOE1ja3RPd3ZJZmxTYU83Z0xIRXA1TFlxY1VCaXlj?=
 =?utf-8?B?dEtmMU9CMDNBV1ptUnNaTDRtOC9IR0RBOU1lSS9rTStXYlJXSHpWaXhIcFcx?=
 =?utf-8?B?Y3BETXo5QTlucWFKVTZialpFVHVjTHIvVUltSWxwYXdpTnZZaFliMnZ5WVl6?=
 =?utf-8?B?clBFM084eStyTDhqL1Z0Zm4zS0VIeXJMd2tMdnhPbkkxanRRQTJlMERlNjNX?=
 =?utf-8?B?b1RtVDRyNm9uQ1phWThZcitiSHZPUzFPL3k1MnkxZzdDY04rL2daL1NQUTRr?=
 =?utf-8?B?Z0RpUm0vU3ZKZEJGVWlSZWpFY09QUVlPQy9ybFRpcnNRYndpNzIvazRGNUg5?=
 =?utf-8?B?SXBhUkJzUG5rYmpuYXp5NCs2UVJKM0k3RDZmUlowaFQwbnRPK2hucVd4bzFP?=
 =?utf-8?B?SEhtY0JyNURsMDdHZjJIbnhZWUlYQzE3c0ZuN0l2WFlsRk50dVlsS25iZXBr?=
 =?utf-8?B?elJaUnNtMlc3Uk0xTmwyZVJ5cytZMC9QdGpRRUlNeVBtK1VLWk1mOGc1Yksz?=
 =?utf-8?B?dDdObGJCQ2EySXkxbGMyVDRmWEh0b0hNWGQwUnFkOXRVT3lDaWVqWm9ha3ZO?=
 =?utf-8?B?WTY0VldBblJYajFIRlkvOGVnVUdqS0prdVFFNWZ2LzZmV052UTJNMm81aldO?=
 =?utf-8?B?NzlRdVNxUmJna0g2aVZYU1BTMTJpNFdwMWdnTnlZV01HUythNjFhdWtiTWpD?=
 =?utf-8?B?aGVpbG5LRXRybk15K1FwTkhGN2J2ay9waWxVbVVSNllwZXdjdjFyM3BWMGlE?=
 =?utf-8?B?SDBMNnRwOWlzVkdTSTZXTENOcUx2NzVSVnZHOUxnRTJLeGZhWjMyVldveHNk?=
 =?utf-8?B?ajh2REZEYS9QdWNscVFGZDdNMFBBZXlMbTE1L1Z0UzByMWtWam5obDArRUFT?=
 =?utf-8?B?V1JQMTV6emI5cmYyOGdiNDc5QXhxeDVjYlcyTnBmdVVuZWhCSVhsTXdOUnEy?=
 =?utf-8?B?bU02ak5FNHhma3hLLzV5bHVqOGwzV2hXR3NuY2lKL0NNcGwvWEZXaHJJdXIz?=
 =?utf-8?B?WVYyVkh3cVJiMm1mZ1JCL09CQ3krWkh4Q09LWHB4UUlwRnF6MGEyb2tyazVQ?=
 =?utf-8?B?U2Q4bnZGYnlIUXFHZnhUQWNieDFLNGwzcTF4S3NBRXJpQTBxS0djaTF1VXVR?=
 =?utf-8?B?WHNIMUpyaUpNQmd1cFcxZysrRmpBUzgyK3lUcnpBZWtpSkxGb3pnU29IcjVD?=
 =?utf-8?B?QU01YUpTRGdOK0R3YlJKMGFVanVnSCt6K2hmTklUMkIxdm1iYktpNUliZXky?=
 =?utf-8?B?eTB1c1BUYlFka0xvZVNQU3JDc0NtZ0JjWW9wVmZ3YXVab2ZwcjExT3VtSTlO?=
 =?utf-8?B?ZHYwZmhlcUJsWmVzWWpqUk0zeGQwbWdXaFpqZjR5bnVnMC9Mc3h0ZHdIT2FJ?=
 =?utf-8?Q?mUqvo0mTMa0nr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjE2TE5sTjlFU0dna1A5SXpEZ0NWdUZ5SW5STzY1YXVpZHNLbEdiMHBRektk?=
 =?utf-8?B?bE5lajljendqaVpIa2lydmFXdWpVTlYzeGJhUnh5M1h2S2U0UjNUUHE0ZnlN?=
 =?utf-8?B?RkNvcVp1Y1RSTzFCci9MR3JoNmM4M2ZsWmpQWnlkckwvZnZ0bjZ1eW1GVmNZ?=
 =?utf-8?B?UjNDeWRVbW1wcDRPK3VqaFNlTjI3Q09VM3hJdXFLLzNDK2ljK3pBTllFMTZT?=
 =?utf-8?B?TXlUejJIUzJFN2grcTB3RmVOZEVzRFljajU1aHdQWmthaUttd0V1T0xOSjlF?=
 =?utf-8?B?Vytwc0tMMnAxUVFOYlNQYUZWZ0dhekREZ1hYZjlkZ1daS05WY3ZhWUR6ZkJ6?=
 =?utf-8?B?bDJNTjU1Wnh0RXc2UU5ESDkvOTNzanJPRjhIOVRESGIyd1N2aXRLQ3paVld2?=
 =?utf-8?B?R09LWldpS2tGRkh4Z3FGVVJ4bjBiQTBMV2MvOVMvSjJVdkVJM3EwNFJ5T3BK?=
 =?utf-8?B?cDlmU01rV0k3MVNiakppdHcwNERkaU9Jc004Qmgyb1ZKc2NPQVgxaGNScXNK?=
 =?utf-8?B?QUpMTTVJY2I4eGtJS0FhL01MOEhuOWN1SjJMbVFIaE40Z29qUDRVL0djTkpG?=
 =?utf-8?B?OFI1R0lWc3RsUndEbjVLNUFpTldOVXdsN1lZdlRaTStYbGJmR2U2VGRKMkY4?=
 =?utf-8?B?YzYwd21PeklDWk81TGp5bFJ4NVY5a2dXR0FJKytGMVBoNlphKzhYY2E0emNV?=
 =?utf-8?B?NVcza0Z4UENyNlljZ0JEQk1oN2ZHM1phQ01LTkVSaEVSU3hjcU9kZGtmYWVr?=
 =?utf-8?B?UWpsRU9UU3h6UVRCVHltWlpCUmJBbHpNa21lQlB2WUQ0QVI5ZlhBeGRJTkky?=
 =?utf-8?B?RXFxZGxnTjQ4bkZ6c1lFc0grdUFVOUQzcTE2Q2p3ckFPMVJ3djg4WUtId1d4?=
 =?utf-8?B?OXEyeFNpZXVMVzh1Q0hjUkE5RzhIckljRmN4QVV2bGJKQkdLcnlKbzVtNGVT?=
 =?utf-8?B?RmxiS3dzUll3QlVOTmo1U1JqbFhkYkkwSm5PZ1Z2YmxhVXZUdEJSNUx2RzFS?=
 =?utf-8?B?c1hISGJianJOa0FGWGZsY2lITzd6U005NG0vaFp4bnpvRHh0RU1XY1VRZkI1?=
 =?utf-8?B?NHl6a0hXbUNENVVpVEsrY0NUMDlwY3B6TTRmVXdSL2pLbnBVNXpSazRvTjBN?=
 =?utf-8?B?dHQrSTFHbDl2S2Q3OWRnODJEMTVyY3ZpWjUrejNQZG9YQjVzTmNKZ1FCV0xs?=
 =?utf-8?B?RzJKaDQ4R1h0WURLb2EwcWJZaHB0emZqMk5LVzhuMFNldzJ1NXlmZDZEelQv?=
 =?utf-8?B?ZUhJV3hGeHFiTE9sYVRHd29sVE1XdEpaMDZRTWs5SHl1eFo2YmNscWJEbW5K?=
 =?utf-8?B?MWUyZlJ3aEtYekUvK3pNM2djbzl1b0Roa1FOL1lma0ppcXF5TWVYeXRPUC9a?=
 =?utf-8?B?NlBuUG1hNHc0VWFiTEY2ZS9SeG1QUVRPN2pEeGo1eE8zc0RFU2tyRlJ4bUFm?=
 =?utf-8?B?SHg0dktvN1Bjb3NOcU1rbjlWRGFkYUNxUkwvQ0lYQk9zU1drVTVpSGZQQzcw?=
 =?utf-8?B?c2pMdDhnZjNhRC9oa3JwcWlOYktPZVFGMmFQWFdZU256SzViRE93bVRWQUFk?=
 =?utf-8?B?L2ltZ3JLTG4zVThMa21velFpMjVnTnZGZ1hWNVRuOHRRMDVqdUUxNWJlcldO?=
 =?utf-8?B?dnF2ZURWcDdyM21tVXNZMEU0QU5yRkM1U3RubHhkNzd2UUpaQkRnZU16OExv?=
 =?utf-8?B?ZjR0Qkd1WmRsc0FmTTZHWk91czltM1pSSDFVMmdUb1VIU3FwRGM3dDNWYnNJ?=
 =?utf-8?B?aCtJM0JxSm1OMnYrWEJwMGlwR3V4dHBxU0tOd3NnaUl2SHErcmVzVUpxS2RM?=
 =?utf-8?B?NFlkM2NTOTJacjQwKzZYd0FGTHBrVjAwS1F5TEJkYW9Vd3MrNDZVZHUwMjZN?=
 =?utf-8?B?L1NndjFOZmtIajN6OG5SWVBhVGM3am1ITmxYZkVlWGx3SjByZUtXZXdGeXEz?=
 =?utf-8?B?YmMvL2t1Z1dNelZiMEwxRUxreWhqZkRreHZBVWJ1Tk9uaXU2S0RDaHFwb3JF?=
 =?utf-8?B?MlRXcExNLzJkZ1U3TVZPa2hOWms0SVJ3dStZckgwUExxa0o1Sk8wcTNGRGg1?=
 =?utf-8?B?M2g4QlZkNlc3Ui9aVzBKb09iNWNwUG4wZUFuSU8yRDUzd1ZrczN1Nk5MejVD?=
 =?utf-8?B?NGkzc2ppTG1tVHBBMXcyOUxMWUZWaWQzaE00ZUFQQ3JOdFM2VlFlcmtJU1FF?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a92efb4b-3d41-449f-51b7-08dd656308ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:50:18.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: METCJvPr3mxPMPfvIdH2OV3ByNqhbnVggYu+KN4jnLsTWPGzoDmCBm569gGcuYgR8jY5fcHaeYLJJng6J/JuG1zvEirgAUfihRuRAwYZU5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5060
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 7 Mar 2025 14:27:13 +0100

> On Wed, Mar 05, 2025 at 05:21:27PM +0100, Alexander Lobakin wrote:
>> From: Michal Kubiak <michal.kubiak@intel.com>
>>
>> Extend basic structures of the driver (e.g. 'idpf_vport', 'idpf_*_queue',
>> 'idpf_vport_user_config_data') by adding members necessary to support XDP.
>> Add extra XDP Tx queues needed to support XDP_TX and XDP_REDIRECT actions
>> without interfering with regular Tx traffic.
>> Also add functions dedicated to support XDP initialization for Rx and
>> Tx queues and call those functions from the existing algorithms of
>> queues configuration.

[...]

>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
>> index 59b1a1a09996..1ca322bfe92f 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
>> @@ -186,9 +186,11 @@ static void idpf_get_channels(struct net_device *netdev,
>>  {
>>  	struct idpf_netdev_priv *np = netdev_priv(netdev);
>>  	struct idpf_vport_config *vport_config;
>> +	const struct idpf_vport *vport;
>>  	u16 num_txq, num_rxq;
>>  	u16 combined;
>>  
>> +	vport = idpf_netdev_to_vport(netdev);
>>  	vport_config = np->adapter->vport_config[np->vport_idx];
>>  
>>  	num_txq = vport_config->user_config.num_req_tx_qs;
>> @@ -202,8 +204,8 @@ static void idpf_get_channels(struct net_device *netdev,
>>  	ch->max_rx = vport_config->max_q.max_rxq;
>>  	ch->max_tx = vport_config->max_q.max_txq;
>>  
>> -	ch->max_other = IDPF_MAX_MBXQ;
>> -	ch->other_count = IDPF_MAX_MBXQ;
>> +	ch->max_other = IDPF_MAX_MBXQ + vport->num_xdp_txq;
>> +	ch->other_count = IDPF_MAX_MBXQ + vport->num_xdp_txq;
> 
> That's new I think. Do you explain somewhere that other `other` will carry
> xdpq count? Otherwise how would I know to interpret this value?

Where? :D

> 
> Also from what I see num_txq carries (txq + xdpq) count. How is that
> affecting the `combined` from ethtool_channels?

No changes in combined/Ethtool, num_txq is not used there. Stuff like
req_txq_num includes skb queues only.

> 
>>  
>>  	ch->combined_count = combined;
>>  	ch->rx_count = num_rxq - combined;
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
>> index 2594ca38e8ca..0f4edc9cd1ad 100644
> 
> (...)
> 
>> +
>> +/**
>> + * __idpf_xdp_rxq_info_init - Setup XDP RxQ info for a given Rx queue
>> + * @rxq: Rx queue for which the resources are setup
>> + * @arg: flag indicating if the HW works in split queue mode
>> + *
>> + * Return: 0 on success, negative on failure.
>> + */
>> +static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
>> +{
>> +	const struct idpf_vport *vport = rxq->q_vector->vport;
>> +	bool split = idpf_is_queue_model_split(vport->rxq_model);
>> +	const struct page_pool *pp;
>> +	int err;
>> +
>> +	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
>> +				 rxq->q_vector->napi.napi_id,
>> +				 rxq->rx_buf_size);
>> +	if (err)
>> +		return err;
>> +
>> +	pp = split ? rxq->bufq_sets[0].bufq.pp : rxq->pp;
>> +	xdp_rxq_info_attach_page_pool(&rxq->xdp_rxq, pp);
>> +
>> +	if (!split)
>> +		return 0;
> 
> why do you care about splitq model if on next patch you don't allow
> XDP_SETUP_PROG for that?

This function is called unconditionally for both queue models. If we
don't account it here, we'd break regular traffic flow.

(singleq will be removed soon, don't take it seriously anyway)

[...]

>> +int idpf_vport_xdpq_get(const struct idpf_vport *vport)
>> +{
>> +	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
> 
> please bear with me here - so this array will exist as long as there is a
> single timers[i] allocated? even though it's a local var?

No problem.

No, this array will be freed when the function exits. This array is an
array of pointers to iterate in a loop and assign timers to queues. When
we exit this function, it's no longer needed.
I can't place the whole array on the stack since I don't know the actual
queue count + it can be really big (1024 pointers * 8 = 8 Kb, even 128
or 256 queues is already 1-2 Kb).

The actual timers are allocated separately and NUMA-locally below.

> 
> this way you avoid the need to store it in vport?
> 
>> +	struct net_device *dev;
>> +	u32 sqs;
>> +
>> +	if (!idpf_xdp_is_prog_ena(vport))
>> +		return 0;
>> +
>> +	timers = kvcalloc(vport->num_xdp_txq, sizeof(*timers), GFP_KERNEL);
>> +	if (!timers)
>> +		return -ENOMEM;
>> +
>> +	for (u32 i = 0; i < vport->num_xdp_txq; i++) {
>> +		timers[i] = kzalloc_node(sizeof(*timers[i]), GFP_KERNEL,
>> +					 cpu_to_mem(i));
>> +		if (!timers[i]) {
>> +			for (int j = i - 1; j >= 0; j--)
>> +				kfree(timers[j]);
>> +
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	dev = vport->netdev;
>> +	sqs = vport->xdp_txq_offset;
>> +
>> +	for (u32 i = sqs; i < vport->num_txq; i++) {
>> +		struct idpf_tx_queue *xdpq = vport->txqs[i];
>> +
>> +		xdpq->complq = xdpq->txq_grp->complq;
>> +
>> +		idpf_queue_clear(FLOW_SCH_EN, xdpq);
>> +		idpf_queue_clear(FLOW_SCH_EN, xdpq->complq);
>> +		idpf_queue_set(NOIRQ, xdpq);
>> +		idpf_queue_set(XDP, xdpq);
>> +		idpf_queue_set(XDP, xdpq->complq);
>> +
>> +		xdpq->timer = timers[i - sqs];
>> +		libeth_xdpsq_get(&xdpq->xdp_lock, dev, vport->xdpq_share);
>> +
>> +		xdpq->pending = 0;
>> +		xdpq->xdp_tx = 0;
>> +		xdpq->thresh = libeth_xdp_queue_threshold(xdpq->desc_count);
>> +	}
>> +
>> +	return 0;
>> +}

Thanks,
Olek

