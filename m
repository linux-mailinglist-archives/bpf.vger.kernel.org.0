Return-Path: <bpf+bounces-73005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B839C1FF91
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 13:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A0A188E782
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 12:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601042C21FA;
	Thu, 30 Oct 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjNrlfwW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E0213E9F;
	Thu, 30 Oct 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826647; cv=fail; b=KoQVOXHH4nAFbr3jQsnf2hErFeulluSIyFlipmU/76YpiKzk/gny9iqzntzxKtYmxrDWWjaj8aYCtMvlR5eOteBO4hKc6e3NsCR6yu23jE9bM26VPWZbprwU9gEW8pUOFOTEpkoKAdwJQlHLa1+5hejE8uC45rqDeNVsBMgYDIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826647; c=relaxed/simple;
	bh=Dd7/lTV+T61l0DAvRGmHskgmVHcLatd20bwai+x74J4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HOZ9kY4aBpVZeabQazfxbjfYAKapCbZWpspZqbGwM8lDbWT1HkSyzGqszJM2HYdIJzn7qUp0q2HRcwmIVEQ8b5rMS3/BgYiapkZEnyHUTuOdUEBOVi8O6iFjKTTkFPX1y+2uZ5nu2V8ay58ZI7wa0kBSv1NNBxz7k+RbJAAwOtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjNrlfwW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761826647; x=1793362647;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Dd7/lTV+T61l0DAvRGmHskgmVHcLatd20bwai+x74J4=;
  b=EjNrlfwWNgsY7lddgwqMyZ0wCbCpJwYr7cAwoapR8cYAKK/Q2CYed41P
   0WvRi1T/a6odQbuG4O13mlilL8oR22kCiH+7ZMXL7muoIn9+EDc4Gpdsq
   KvW2f1H132SmAKrt5u3aK8Gvtb7P0Av/u4qvuN2D0M7CxF1TJXlurZghE
   YKE32U7rfnzEnCgPyb5v3tA/RejQHh7CGV025hl175B2R3X2psdS0rz6H
   Z1CNR0+Jf2qdpUeki3Rtoc9qLkoDUxIWe32sTJ3znDjDJ79dtxoBbuGAF
   bc4UZCidVLxoQK56xka0DLAc694es8yO3R2h2aBngbCxn/8qiTTzuiNN5
   w==;
X-CSE-ConnectionGUID: 9BEJz5OMQ3iOiT1c/ZvnNA==
X-CSE-MsgGUID: aBDqoaI9TMyuYR221TQWKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63664953"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63664953"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 05:17:26 -0700
X-CSE-ConnectionGUID: TCX8tQwGQ4uZwtXNmHJMQg==
X-CSE-MsgGUID: ZlG6UH8QSqC3VIShmHAkSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="190013489"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 05:17:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 05:17:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 05:17:25 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 05:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhpdsSOZAk5JCobWlqp9LBY2x643rZrmqueC3jCxymHHrvvSvEJ6GzlGiYHBXymxG2lRYSTH3mam6CAVcnY2t2OUbrj8OwHPG60nAV9M3HT/iF4Lc6PzICJbjjmtxxOdo2ioBieDdMOhN/vjqTxjzcE+Cdm6gTkyi+77Bm9pzhOqY1eRzG0yvGVo8TdWQb0O5Hiaye60IrKS3AoT2b0W/Bx0d5tDUKbK0ETVBoVlKjw2BVaRehgxVmcBW99KlnJ4lXJMxYz84Zm58UtzX/KBxRMyUNlR/KnK1DdjUfDeJwu6CdNW6wWd+G6GFnnDlPSu0vQTPKPR2L5vjEDSpjhN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJxCgjDWF5p5Nbh/kNGXTK+eukq1WRYsTW/eeYtUnPk=;
 b=dUwbt+lTHlM58C77r3ziaBze+N7Bm/lxnVfQ4iXFW4y9Tj+8XtpIpgWnwatt72xbc2DnPDTwxuVC++hTGVOESVhrVFnBK31m5GWnfXKl5D0JgDFvri7D5522BW3ZfH9VsS2JeBG4HUBSdFRhT6ivDQXgDGtSkOTz61z4pZwhKpCdejgsGdzzl7p7lUlNW84iF906bWjRWUDpY06Gz9YksgtvvSYVYjEb8JGPxNeYSmcg85++LeYRzD5jKlsnwxS/lGUsT+VmDClZ2UOCgXrLnWzLftv8ML/KZhiDGlWbzUd8VGLJqYwum9rBN2RalC1ilR4dyvQoNhlXTA6ZhkzTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7336.namprd11.prod.outlook.com (2603:10b6:8:11f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Thu, 30 Oct 2025 12:14:30 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 12:14:30 +0000
Date: Thu, 30 Oct 2025 13:14:16 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<aleksander.lobakin@intel.com>, <ilias.apalodimas@linaro.org>,
	<toke@redhat.com>, <lorenzo@kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v5 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <aQNWlB5UL+rK8ZE5@boxer>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
 <20251029221315.2694841-2-maciej.fijalkowski@intel.com>
 <20251029165020.26b5dd90@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251029165020.26b5dd90@kernel.org>
X-ClientProxiedBy: VIZP296CA0021.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cda8da2-5f89-4311-2a4d-08de17ade0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c/0RUa4dk/GWQoxLAKyOd6EM3PmOXFPPbc7m7ciELVcWLnF9zDeCTsQEivm6?=
 =?us-ascii?Q?uBEu3GMetoIxpedbv6Ci3w1PbxnRL2wwITGU6kTNBhUdSqaQouAunaMTcL4A?=
 =?us-ascii?Q?7R3Tnf9Sdussl2WcRdCVe56F+CwC0AygbTw4S3Iv+H+syr4X9sGNm1ObqhlW?=
 =?us-ascii?Q?PDozyL/9bzegkN/+8RZ9fcDlIMF8n4jRImzrTGtRV64VAIBV/XmmVlFhzXPg?=
 =?us-ascii?Q?PMrD46KBLI59yXA4fk2Q+e9Qy75tDvfNoDUtWSuSApkQWyHS4rUk42+eGVWV?=
 =?us-ascii?Q?kKlUqyapo7BGo2782nKRkwTdBPp64huuwtaPHKj5W8a1eob9McOkHa734R6m?=
 =?us-ascii?Q?kqmCZuBUiNScbOlAMU6+eK5QldprGDbJcul0Z2O7vn7hIah5AoV2VrqLk6it?=
 =?us-ascii?Q?T4H0jG5jUZFIzPFqQSWwDDjGOw3hKwP77uI4ywZwCzGK0pzPSGrgbv9gDZok?=
 =?us-ascii?Q?7Rop1kl9S3MHjWu9i9MIzX+d0XmIMQR7fwl5Id98PT6oLhRDmXsgQCGmap4h?=
 =?us-ascii?Q?kEyvEy57QJlJsfmlkiJH3XWXjwPVNb+zMZbFrarbSkxlR+LpSHJhN4QkQPEL?=
 =?us-ascii?Q?OwqO+ET2279EIC22faK7A4L4UNiL7jiBV7LDQTKXFDuCxtCbb8qjcQGi+ABN?=
 =?us-ascii?Q?ayIZUubOUUJ+bFqk3U5EFYoF4PAhxNpd3wPCeS1kiwbH0BJqkFiT+sfOVmji?=
 =?us-ascii?Q?dSRqaPXdvmWaTh7TSI8BTe4a7CAgjtKlQAcAPPCOHTanCnjiqFfFrZfdtmSr?=
 =?us-ascii?Q?cveErytUCDH4a+2889u8lzTeD7Z7GJr6ilsaYsmi/fFO47qMQ8A7RKX9gG0u?=
 =?us-ascii?Q?mf2nrB7ze77SxHQimhQaGCAx8pwLTMG58fzgtGQzrIwNIySh1Rsnp+ghI2eh?=
 =?us-ascii?Q?garuFyl1CTDj2XuV2kLjNEvVJcrdusb/6+tm8HlWOljtTP62dlx3Pn4/1gHx?=
 =?us-ascii?Q?OCIZ7Y855PypBhUZwtahjaXaLb4YdsxE88uKEOy8/dsYsi4/2JSwkBRbVPwe?=
 =?us-ascii?Q?WbHNfuShdAfHwzvMSIzaT+q5SuXvVSmgt3b5kqJwcvcNcntaSw+apNWVTxdv?=
 =?us-ascii?Q?zaod0cJ/4gJGUt27rwIe3yAhxeXrJAhChG+0rsQRK9ZBI/3ZXjQynO035gYH?=
 =?us-ascii?Q?QBVhzk9IeJXwGYTfWeu9J/FGJ7xEDUOWItWAn1zG/9iCyEh5xu0r5EfOyuwa?=
 =?us-ascii?Q?hTlROwyKNybVenfwA2DDRZg4Ti+WSI++l/hsBN0hshsNE3TmPWtCHpOINAIU?=
 =?us-ascii?Q?y7FrNH/U1uP5p8byIpXcDzqs/Kbdz424anjp9NjbtXD7B2A+GWp1kBhs+H8M?=
 =?us-ascii?Q?M06CiM5Gw+wUJhbKoOGfPyWfzrMQVckMjiXMKgJrZ2oByaoBc/3Im0HLXG0w?=
 =?us-ascii?Q?f6HtNPhsmYYJ3B7YspTswqCy5xjeqy5cmN1RiaGKLJC7piZ9vji5qlE3irKh?=
 =?us-ascii?Q?zL8K3hHp0nHoQG9S1lS60ID4FkxcSfb9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j/Z10CumPx1yxrGr3VveBGkln0sFY4DRjaiwZstQqEMr7vGAVA9FdAOWa6NW?=
 =?us-ascii?Q?smdRyRueHpLzmapzAGBudbtGAc5UA9Y0EWE8Ao2I80ndET/rYTmCnwsWMpjH?=
 =?us-ascii?Q?XhC7V3JeD7Jc3uWj2Fb74AbQIZN+CPFB6xDqpQqI1dHAj4Kz4SNd8zYg/Uxb?=
 =?us-ascii?Q?Pk1Ad9FsK7l2UnRh8YDAAUkbyWBs/wKaWw2QDJfleN3rZrj7URS4TPA5wrS3?=
 =?us-ascii?Q?dybUTQUfQL4huVVcbVQnbLrqjNPrQM8YVdJvWRsMzO/bKGRI6sf3kShysnPI?=
 =?us-ascii?Q?EqFeqJJt2lbXe6TS+Acvjojg6IhzYASqvHME5vMfcIGfaLArTrshZF4OwW1A?=
 =?us-ascii?Q?ypycmCBdAiFvpTSS0Xs+GfKSDxzD4AQMseSBt5T37VzEnOPARH+O98eWCm4q?=
 =?us-ascii?Q?2Yo9Oxwmu/JRCAW6kBBuJUWKefiBjUJ/GAimAIChsp8EHUD+wmx+ly3F4rrw?=
 =?us-ascii?Q?Jh8ePKLrHE4sz/6tAp6V7Qljqq7sVpMlxDcdtGEJXv//ckA3kkOXbb9wNhOP?=
 =?us-ascii?Q?YR9WdFJzTurhkOQMiOgdf7tlPq8WoXnI6cZOLrO/U4A2ea96Ax6yOyyQxsPt?=
 =?us-ascii?Q?1x4L/5JboZqsX9W2jDye//mayM2LH1rs11ZKyfoaoEE8TcG/+XqBzUdVs1xt?=
 =?us-ascii?Q?grDhV9HKWresIE+BTTJJROB98391i5UuAs+Ukm3ztH6M8JJUy8i/LtTfkKbh?=
 =?us-ascii?Q?BQ9b6VmHH60xgtPfOaYE3xweANfpVWxPGFPD/wSh/ECERbX4cnbkig9AU+3F?=
 =?us-ascii?Q?TtDr9BF4ilkPodWSDf6MLXyIxMgU/ylHBRuvzYMz5STapcitll/hGjmnjO6j?=
 =?us-ascii?Q?SUQ2ZmwsnxQRRTdZQ8yditdDKHFpJk3BtVmubPx55wJ+Qf+PIqhRam1nloAl?=
 =?us-ascii?Q?L97LJ9RdMYyiL5bJF3d2uH4t7dLxoDvIgY+p8vS0ZrE3jgxOR2q9A53Y84WX?=
 =?us-ascii?Q?kKWHpLpk83k5X1B4uuBZUs91YLG0bytXXQX+WS64zcX41lf/TngdREJuKDhP?=
 =?us-ascii?Q?oiviNjjf6lcLuvH/2NeTroU99Phw+sgSrwlW97jtSL+WpwkxJGPUGEC82xtb?=
 =?us-ascii?Q?383QFvdO9lvVbN/xEbebxPQ2kVFDptQgw74/z+RSqq4siAI1LnRtI0Gagkix?=
 =?us-ascii?Q?Y8yGA9EcooZr128VJwtXXUhpgzuoR2NT95fxaUn5WHrji6tHjUwMLcjYol3r?=
 =?us-ascii?Q?EZKW/H+ieoy3Qo2gPejTLUNcIvp3DOPfg8olj3WXQhbHJi4B8hvZdZglOidb?=
 =?us-ascii?Q?hpBW3QIIu09J/agzoPnbkC7v1sV+KQTnIaE4Z8GkgjMMR4/AdnghSPeOFJWR?=
 =?us-ascii?Q?tvv1OBVLkVLReyECPWgpnFQFQbzjgCo4YZ4ZOEx2SfcaASzib5aUZSq4Sgqs?=
 =?us-ascii?Q?M9a2XvZQRZbqkDcUrQDrK5UnsDCDGgvgpLOon8tFztSLunca1OltL+oWu1rO?=
 =?us-ascii?Q?gnhk2wpxUAZQQHXqr1n/KGEa3jsxA7T4Dt2RILeDkwElPQiTyNajhMkJXcbu?=
 =?us-ascii?Q?YkVJncl6ET2RiMVxPdR5cRNZdpGUYgPne7Dx+6PTuTiF/pqYfZmSOnLlRx/7?=
 =?us-ascii?Q?DcsjxscNFYZG6cp64zw3fK/ucaxdvUrsHQnNtz13cDsF5G8M6BZ8NWeFaSG5?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cda8da2-5f89-4311-2a4d-08de17ade0ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 12:14:30.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pG6OCLqFVVrNBO8R9b6M5pjYf0iwAzhcVoR3u5J0GFi5QRq2h+dtPtlILJd+t/lhdELCWjf66sfVZf6quWgfdfoJxd+b5pDj/67/2q7WggU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7336
X-OriginatorOrg: intel.com

On Wed, Oct 29, 2025 at 04:50:20PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 23:13:14 +0100 Maciej Fijalkowski wrote:
> > +	xdp->rxq->mem.type = skb->pp_recycle ? MEM_TYPE_PAGE_POOL :
> > +					       MEM_TYPE_PAGE_SHARED;
> 
> You really need to stop sending patches before I had a chance 
> to reply :/ And this is wrong.

Why do you say so?

netif_receive_generic_xdp()
	netif_skb_check_for_xdp()
	skb_cow_data_for_xdp() failed
		go through skb linearize path
			returned skb data is backed by kmalloc, not page_pool,
			means mem type for this particular xdp_buff has to be
			MEM_TYPE_PAGE_SHARED

Are we on the same page now?

> -- 
> pw-bot: cr

