Return-Path: <bpf+bounces-48680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8F4A0B700
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 13:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188791881671
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DAB22AE74;
	Mon, 13 Jan 2025 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cS0lsI9w"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E174040;
	Mon, 13 Jan 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736771557; cv=fail; b=BstVXRFzroXkF/QlzTuXGmUnOEZ5wXtnQ6V27KGEi2jrFPRwCNZmdUvdMIsUzpY4Kx1c3emvcM/oMQyEb1ovIsnPe/ewz+ThCvQfT5UXqIjBq2u69tvmWWpMh1fLNHnkVwPYxy95JfagkAin1t8irbaIHZRiO9oIhrGvj4ugisA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736771557; c=relaxed/simple;
	bh=Sp8Vl3ouixEa4OAqZMzUcS1rfvgoQxsgYBgca8HvSfg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RNnqJBWskUsz7iTllYFHPJ70ET1s8qTrqkG+RJsd0vRrRoij1a7hKnAToYS9UpUlp1s+ujA682uf6PK6jeaGH0RwvL5EE5OcTFWev7u3K0m+rFlhIuK1YFJxTCRn1vKnEObmm5ZwgDRUbG5LINcdHicfGZgjwoQ2S6KTq0OT8xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cS0lsI9w; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736771555; x=1768307555;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sp8Vl3ouixEa4OAqZMzUcS1rfvgoQxsgYBgca8HvSfg=;
  b=cS0lsI9wClbGr1IKQilNvHHpas6qHhEHnWC2KeHbx9ww1gpGt7yjxBy/
   CpThgWBSMmQ3pMkyTd+TgnCAP6B47NkCsuFGvTqgCLD1S661+MHBHGmlu
   +uR3y7y36AjVhMa+MCY9Wnn17PSbgQm/W43AGH+ajVd17M7kr5wTM374r
   DI9RbgrO+ekARhXwSwcumhtlOFLjpZhQRQPSKDEGsa98m1rkxrpsmyMf6
   2zBnEHt5TjfW8ORTSQeA2GFK2eYd+a8/6K5/8gLbMJC1xEubQ4zmD3baV
   gkxmdpGGoUQ86IDWeYEqg0mS0QVOWm6wQib/0p9Gi0vL1h52eJTa/L0MX
   g==;
X-CSE-ConnectionGUID: s7YLrZBQQDWafttG2hLdhw==
X-CSE-MsgGUID: nUDdXmgHQbm/NT/3g9F8lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37192280"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37192280"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 04:32:24 -0800
X-CSE-ConnectionGUID: K/zOgKHWRoeL3vTfzWXcKw==
X-CSE-MsgGUID: N4s3Um31RaSN4UHc6U9/JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109608987"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 04:32:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 04:32:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 04:32:20 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 04:32:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS1Vc1TiTL8PrsJEb9R6rnTxyAb99cb28ItkTTjbryijT/AOsnWxfd5CmMaaN6tqoo1SkUYbYmi+JsN5mWGESt3DMuzQW8ewQy2VVB4q/fKA6x9iQFQb/+vJnDv/I8SQjDwaNKtvrwxqPZFhqXpTIeET1AC8R459zCd0sX3kAI1OBJVH1aCl6VnHnROYMWbDODNIxNRmkmmtlZrQ8BSAmaohCdGexZC+UJMMIgirZdYVUaTkp4Ly2er4I7UvHxKabkey6hXnUbeG0GAibJ0wVC1O8aDTwdRhkXYmu/Qzswd8gpptaMbt81Nr+5VbOrv1L9AH2rdXesK06bZllVyhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+w6Q/v7KZ51nrJiTQEesxh8xMCD2WxtPflCVDDM3Ys=;
 b=RUKJGjOPVUtDhMQiE6p/9yEE6fk4yw6BWldJbKjnkJsDe8rVu1YCvinFiZ4GAkh82jazgMRgCED72ayUQJIz5E54tnUUYWtkIekXcsKs3ykXbs9c8ZD0e+qwpu6rpySkg2N+DE1L0/Hj7hRmdn3O1/FkZR/PxYYbm1Soz8H+xWbsGz91Et3d3v/g03pXZP5IjtcbpOhUKD0e8aWndDf/xMrg5+5e4q4BCuUWhlNKhXJAXYyHtiEVaViLWEOeqqPjMbfy27bNA5mEISUgy6Gn7/TRIfYsTcg4rFkJq2h0bexeJi+vjngwI7rA9hW81vRnb0+nJAEUN/Iyi5mLvqWncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 12:32:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 12:32:18 +0000
Message-ID: <1ba87a40-5851-4877-a539-e065c3a8a433@intel.com>
Date: Mon, 13 Jan 2025 13:32:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfp: bpf: prevent integer overflow in
 nfp_bpf_event_output()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jakub Kicinski <kuba@kernel.org>, Louis Peens <louis.peens@corigine.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Quentin
 Monnet" <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	<bpf@vger.kernel.org>, <oss-drivers@corigine.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <6074805b-e78d-4b8a-bf05-e929b5377c28@stanley.mountain>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <6074805b-e78d-4b8a-bf05-e929b5377c28@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 449b4298-1ef8-4a3b-2e83-08dd33ce5198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1EyQWlTUmdGRWxXa3pzcndrRS8wVW5EQVlOZUY1TWl5SjJtdFNGb2lneGZ1?=
 =?utf-8?B?Z1ZrVEZXYllVTUdCNUhudldlRVo3aVpPL0NseHd0b29SQ25oeFFJcVVnaUYz?=
 =?utf-8?B?YlA1MUVMWnkvWUdBTnBSZTlaL2hHQlR2TkNxcjNiMUplYWhvbTJVYXBJVUp3?=
 =?utf-8?B?ZkVtOXZhV3doQjVocHRuUlRldkJFVEg3TUhzVEhPWVhwdWloRnQ1clBheElW?=
 =?utf-8?B?MDNsODJLRDE0TWUrdUVWWElDRWVQdUNvNjNrMXRUT1Z0N0llMk9aUHljRnph?=
 =?utf-8?B?bWVIeUcyRDlVRzcwc2tDeDVkVXpSdHAzZnp0WHBDaHluQkl0eXU4TTNxTlNB?=
 =?utf-8?B?bDZuRnRjTkFCSmMralZkQ1VjQks2SUk2NXlmN1JBNkF6c3FnVG04dFZKZ1VZ?=
 =?utf-8?B?RS9INjNDTUVTMW5Sejh4aG53cjJYQmlKdUk1dGJnejJWVDRiMFh5K09aMmJQ?=
 =?utf-8?B?MUpwZTJUcFl1ajBYb21TS3gxelZoQVVoT1lkUXFxbjRrYXFqRHlkQ1h3K2pZ?=
 =?utf-8?B?OUZmQ01GNG85RTBrcEt6djk3S2t1VXFRSVlLUEJTU3BHOUhYVFpHZlpFWDFx?=
 =?utf-8?B?NDZMbkNKSVN2VXFMSXl2K3JHaEc0d0d0R0lpbWZFYkdjRlp4eWxWaUpNVzhV?=
 =?utf-8?B?VWNaUll1TE1jVVJIK0JBbjNUTzQyRGRtM1huQjdPa0U1ZFhBUW90RDlDWGdZ?=
 =?utf-8?B?SFN5dENaOTF2eEJOaWsrdmdNZ1dTN3NLaXdZcVF6RzFvMEQ5VC9VY1ExcTJ3?=
 =?utf-8?B?V0VRekN3UC9XNVI1SEUxRHZlRnEwTENGRmM5Z09neGhhdjBHOFIvTHFReHU2?=
 =?utf-8?B?TFpmeWU2dVVtcjluMXhvNU42b2hTbWd0ZVdkdUpTY1d4M29nV1JUeEFUQVFm?=
 =?utf-8?B?Y1h1elJyVFdlaGpNT0RiaFFSWWtISWtibTJ3eTBjR3F4WlpBZXd1QU1jYWFZ?=
 =?utf-8?B?djAvWkpZWGE3N3A5K0hSWXZwODRkVzhsMGdwak1MdEMwYWNHSVg2Q3p4WmFQ?=
 =?utf-8?B?SnVHUjFYVTdCTVBUL2RLK0JoOTN5WWE3Z0RtWklyUEVoWU1CTkVGSmxyTVow?=
 =?utf-8?B?TXNsSVNJbGV3M1pFMUR3QnUxNWpwRzh1QmpnSHFnZ3IrdUU1TEFLeVpkcHpV?=
 =?utf-8?B?eHJ3dnNPN01lWEhwdGNOdWdJSGJXWlFPSkpzcWpma3l1NXFFOHVsckEwMTZG?=
 =?utf-8?B?NENzU0d1V0ZqLysyQUYwTHhlMVhxcXF4YTFLaGlFaUVXKzhJcVZSNk1qcFdk?=
 =?utf-8?B?aU11RmZ1K0N1ZXVmUjJmTmFDai9XRU8yWjZOSjVzNEpScHZZL09FanhKVTFt?=
 =?utf-8?B?MUU3cE43K2JSY21Vb0VsTlhjUS9EOTdYejVLZGVHbzdRWm05MDNkL1BybUxZ?=
 =?utf-8?B?NExlbDBWY0tHNkRtMVdkWCtGY0FYeHg3T1oxM3V1SmhlZVIyR2IyQ2U1RW9Y?=
 =?utf-8?B?NHA1aGR0U3ZWYmZNbjc0NXh3MERNRXJmbTE3L2lDQml6aVRyZFhiZXZPeVdN?=
 =?utf-8?B?aHFTY3VTZ0hBNWRaZlJRdDdEZFlMRTU5OURNcyt3d1V1ZkpVNnNwdCtTK0dp?=
 =?utf-8?B?MXlSNXkwR2QzRDNIQUxhcFhTSUJTajR2ODF0dFB3OXZIdkFiaHVCVmhFWVBr?=
 =?utf-8?B?c3V6bUs1Zmc4OExQSi84eTlKSThSQWVoSlduTDE3U2pROEhhUm9kaHhkZmNv?=
 =?utf-8?B?dG5KbkttVkhCMFduQVNFUFMxdHozS0lhNlFRTVVPSDAvemd5QytPeDRPbEFj?=
 =?utf-8?B?WXdKKzNLemJHRlNITVJ2WU1HM3JnU3RhS0N1TGNVb1NLUGdrdmV0bTNzTGRj?=
 =?utf-8?B?ZEVJVnN5N1ZvUTRubEY4VXk3bWs1cWVER2hQT3A0djlWaHdPa0JQaExjU1I2?=
 =?utf-8?Q?YQYN9RN3pHHgM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHZaVjI5VWsyTS91NlFXa1k2UGNqY0JncVdTQ1N4akhqeGlIMnVWb1VaVDZx?=
 =?utf-8?B?a2tVSEF5UE5ackczNm9QL0QxSGVzZndWWVBncURoT0w2ZlJuVHpOOWhHRkcv?=
 =?utf-8?B?K3dOcTVCb0N0VHlNNmhmcXFTSUEzTFRrbUVQT0EzQjJPQlFlejBnZ2poODM0?=
 =?utf-8?B?S3I4U2d5MDFkUk9nOU9Ra0NHSllvR1UwWnVKTXBGMTE4YTd1bmlma2V0bjhS?=
 =?utf-8?B?Y3RKRjYvQzVSZHAvbHF3UjJnbUFuMGozQkdGZ3ZDYm5keHhXbzRuZlFIZ083?=
 =?utf-8?B?eUtrWlRvM0hVWndhdzFBZDd4Q09BZzFsUnppWE8yTENReUlKTUN3SzV2TXJh?=
 =?utf-8?B?bnJMaldDaFdLeGZLb2IwNVVwVUJuK2lZRkEwa3RlekhnMEM4Uk0wa2lRR0xS?=
 =?utf-8?B?ZHBUV1Ezb3FHNFFjS041QmM1Y0JnQXNJRDdKVW9qM1loWm56Q0poZWJCKzho?=
 =?utf-8?B?eDFtdE5HcktqYzlieDQyaXNkTERUWkNhSzVieEtySnlYMU5Fckx6OG9YYzh3?=
 =?utf-8?B?UC90YkdkSEtraVhPWlF5anBOUTNFTm93endocmcwQmduOExib1o2SXU3QTh3?=
 =?utf-8?B?cTk1dDZQbGlIVXUzR01ERlBmL3lQVnRrZkFUQ1FJaytRUW1LaHpGa2duajNw?=
 =?utf-8?B?Nmc1Sm9meWlWQjVKUjRtM0ZOYTdsTFJTMDZmNDdGbnMrbi9QdWtFaWVlYVBz?=
 =?utf-8?B?U1hSREdDTXB1ZFA3MCtsQlU1RVZhcVVCODljelpYN21kN3Fjb0t4bHZYUEh2?=
 =?utf-8?B?SVhnYzhwallGcDJZYld3QkNld0dlN09lV2dncTAzMjJVRlNoZlhNbU5uQTFt?=
 =?utf-8?B?YmhMc1RZYnBpQ2xzVTBSTDN4WHRjdFB3QjJkWmE0YVBXYTdIR1lCNHdiNmNz?=
 =?utf-8?B?YllzZ3Y4V2k3R3VmaSttTFN4enVrTWt1ZUdNWVV6QTFneG1reDZjUmMvM2pD?=
 =?utf-8?B?eDZLb2tDS0RoWUsxK2VVR01KMUU5aUQ3L0VoYlFRNWhkdmsvYnpwYUF2Uitv?=
 =?utf-8?B?Q1dycHlQUEQzakpBa1VLUm1NZEZYUnl3Q2d6bExNdEZQMG5pVzFGNm9Db1gr?=
 =?utf-8?B?Z3E4eTBpdUxuNUZRencrbDNXa2lTN3lqcUJYMEpqR3hvbUVmT2hIRmJiaW9a?=
 =?utf-8?B?TndveFFhNXJSWDVkTVQrcW1MMFNzNmpxQTdWUWdUWEdDdTF4Qm1qclZsc2kv?=
 =?utf-8?B?anZuVXVYdjFBZ09vSlcvN0lGTnlDcjJZSFJPSXh0RFV5dGU4ZUtvdmgzT2R5?=
 =?utf-8?B?ekF6WHJxMUFuVkNLSXd5RENzM0JKcVlWSDhGN2V5cGJnRUFaVVgxMmVqWExk?=
 =?utf-8?B?UEdZOHhMeTBZanV6VlFsZjlyWlY4SXdjSnlzV3EyUXBoK0pmZ05vUmF0SnYz?=
 =?utf-8?B?WlFRYzg1OXdJUm5iS1F4bUNqa2o0QUYrZCtIN09ENU5sb1kzazZQN0RUS1dV?=
 =?utf-8?B?MGxRamIva2dnQjNxUDBMMFFIL0RYUFpxUCtOQjNkUzNMWURmai8yOEJlL1F6?=
 =?utf-8?B?YUtoc252d0Z0R2lSVFQwTXFEYmxDNGE0SFVGM09TS1N1eTV0MUhkaEJpV0Zo?=
 =?utf-8?B?eVBISzJGemFsQk5Fa2dSYXNhMGdsUnBiTzVBM0RoeGVscW4xN2lJM1lIaEZt?=
 =?utf-8?B?WVovWURMYnEzNkVlVUh3Q1UzblJqWTdxd1Z3QTlSOTBJcWpCREdKWDlaRVdB?=
 =?utf-8?B?ODZJT1cwMzZhQzhLMTBrUWU1TjQxQlo2NC9mNmxBU29zd3BqaHFmOUZCTWpB?=
 =?utf-8?B?NzIxMmp3TjdvZVRrVmp1VFZySTlEZVFURzZoOWZLYlNXdVlOV0x2TVJFSktZ?=
 =?utf-8?B?L09oZmhQNk1RYm1iYnVDVVAwVDRCMSt6aFZiNDZ3dUJ1NDVQUFMvV2s0NldV?=
 =?utf-8?B?aCtwV2dkR0dIUzhQOEZhT2lkWXdCUVNqL01jUTMrWGM2YlB4MkR2RjRUNnc0?=
 =?utf-8?B?d2c2MGtsT3cxSnVxaFNHU293dUkxMlFHRUxBMU9rTFBZTW5neDUvcDl6UHQ2?=
 =?utf-8?B?RXpGTUZ0cGwzbUowOUhFd0NPK2FLMFVWM1Bsb1l0cDFMZVpNWWpWbHQrKzRs?=
 =?utf-8?B?cmhrV1dzaUtvREl1TGJBRnB6OFZjM21IK3dNUXd2dHh1Q3p0cEIxQmtXaXh4?=
 =?utf-8?B?ajFYWCtwUFpCVWgrUlNyMXplZStNS1VlSzY0TzBLc2t1aG1KdEloRkF4b0oz?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 449b4298-1ef8-4a3b-2e83-08dd33ce5198
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:32:18.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRXW9DjMFNwg3PgkD4ePQyKzgp2O5s0Os1T6vmMdz4mIeGbqQ+WUEW/oM3uwZhxAVboJ6ogyfigEUNQpBhylT7nbTUWvQEK3jwllG4awZTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6985
X-OriginatorOrg: intel.com

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Mon, 13 Jan 2025 09:18:39 +0300

> The "sizeof(struct cmsg_bpf_event) + pkt_size + data_size" math could
> potentially have an integer wrapping bug on 32bit systems.  Check for

Not in practice I suppose? Do we need to fix "never" bugs?

> this and return an error.
> 
> Fixes: 9816dd35ecec ("nfp: bpf: perf event output helpers support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks,
Olek

