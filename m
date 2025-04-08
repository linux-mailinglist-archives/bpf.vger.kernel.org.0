Return-Path: <bpf+bounces-55476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E26A81301
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 18:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE9388812F
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7CC2397B9;
	Tue,  8 Apr 2025 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwkkFQER"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715B236433;
	Tue,  8 Apr 2025 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131302; cv=fail; b=jZPRR671P+dZL/dsDdyvlM74k7gOfMgPOHwECvyGtL4I4fJI9XloHZrdubr3jENJV6H/TjtEC9jAYeYVzEkmcQAzzRmaqrKwRC/JM/QKI9QDcEhaPkchnb5kp4Thec73mo+jFf3o+W6sg6sgVxIGw+4+lbpfdiym8vFwKF6Nwm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131302; c=relaxed/simple;
	bh=7PRIpc8xYqcil8SSMHV3dXf4KJgvziBkZZTuQm3dla4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tom7NSFv1qpQPBDS6l//pdSiARFp5YAuRcKTGjej9rFHexqt4iJdMGBE6JeDaYDmna50RH+1BTOrJjRK/xVxQY0zm1PonTFcIiHpQEumzKRkbTKu/n47wPgpYZCfDJ/gadm4JH9Q6c1V1EHcJjUrNTwXEROc4glCKFQStM644hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwkkFQER; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744131301; x=1775667301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7PRIpc8xYqcil8SSMHV3dXf4KJgvziBkZZTuQm3dla4=;
  b=QwkkFQERuh81ghnLLOBEP4q1fG/cX/f1vQovFl9QGwh4UqNNxpR738bi
   t5FYX3MC6c1KWuFV1Zj4Ht+CZ82jIPqQInNK6TQKzHv4TlgYJ/mJtAGMP
   Lq/VLWmoS7gnGK5usAySuDnZTMX0XiLFAwUARqgs3BMCHph/0HTK98ecU
   jQqr/DckmKpU0LSQ9j3laqHRQU9ojnWQTntvJxkRRJOHw4O/rGl6e1pz4
   C1lwiXON3rpBcir7H60c4VFjp43cAzQ00BwuVheR1ub7WcKP+HUXZd/pf
   St15Ze5kOR6HcRvc1c5MgtyTXE9TyWnrSGf80J0ICCPS/VNN2BOgL6GFp
   g==;
X-CSE-ConnectionGUID: ijmZHDjBS8aNxZxxVb/v+w==
X-CSE-MsgGUID: eSf+Bcq7Q7mT11LlE7MuqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45463997"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="45463997"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 09:55:00 -0700
X-CSE-ConnectionGUID: Y3hpFluxT8e3cLzY8HunQw==
X-CSE-MsgGUID: 1f2P5ZbRTEygvJsy7FeSpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="128829531"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 09:55:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 09:54:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 09:54:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 09:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldLruwXUuOGcSrsPSEXiuXVl5auiEkRpp6lHSUiFGgx1J7q9//JB19phCP85vei7c1Di3/mPeYkME7zwErDMZmIqHy2bQu+cSLuWd6Nx6OPj7m43gP0wJZUJrfzBrhrFDxDBpgHzHM/fe5QcYwBC2Tk6F2GA6oZO6KTv0OEPAbhTqTCYpivKH4UMaF6cd2mGR3dPtrwjZSeYV0Q9t6m9yzUmCWq08vobZH4BET54gNgdZYa7JGOn350ocNA6g82Z8VrGUVYwNbM1niZwxebicF26oWAUYvmJgufbvhKPr2t3bnceEIb8z1ErFfDAG53/rLVTAaHXaW1DbHlkmVK8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtjaHdNAdQDcR7Y+6evFsWYoSPAoApd7l5+6iJnOrH0=;
 b=J0FY7CFVbimlnN6KKaumRXN5IEy4c2eEvqKcA1Dv236S40J15l1ZJXnaP6BL/nvi/YCT+1QYoCQvN+au3uqteFHxEMw+oaUq/CuI8QGdOAt928V8eG3lU4+fIRVemtDLO75+EwVJW2aWmPGd6rmq9ugyoI8cJoxdh5bKTd3/xh1NjivcstefuO+lL9B2K0elq2ZymTxUgWa/MVnZfojfcOpOaQp7rYWZ2ZPCygLoOeR/oyIetuhHyxi+mFIbSYnkR1DSJRbbHGMkBlLM32gDCP0nfmjw5oGIjIvn60wp7qIncL9PrzM9zU3QE/ElO9C7jno85tgzkuIeEFaLBnIFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB8774.namprd11.prod.outlook.com (2603:10b6:610:1cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 16:54:26 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 16:54:26 +0000
Date: Tue, 8 Apr 2025 18:54:20 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next v4 0/2] selftests/xsk: Add tests for XDP tail
 adjustment in AF_XDP
Message-ID: <Z/VUvPIxGVJ5dRic@boxer>
References: <20250321005419.684036-1-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250321005419.684036-1-tushar.vyavahare@intel.com>
X-ClientProxiedBy: DU7P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f0ab17-f78f-4e6b-6ff5-08dd76be055c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0eeENEwJxi81K/QiC8+7aTz5JZpXoxrDVN6oD1dvIp5mRdKhpOzNaKZbN1fs?=
 =?us-ascii?Q?26Ia6HQqbLl6/6SehHGKTg3dlZtGje41BgYsuMpsC+C3mAGSrIKA4IowHBt7?=
 =?us-ascii?Q?/BXkr7D527Fin8tkMVzXaj86MjzzgkoWuHT+AgXbCw7VzisYIsraNMzUteoF?=
 =?us-ascii?Q?JAs+GCf8uvKB5eXcTZDHkY1YHvLx0dgAu+Ijd52/cJiLv2PegV4kqYf23vx/?=
 =?us-ascii?Q?x2ygkg5OErGt7CD25tHTHhw5Nqo3nu+eoGYJnGf84pMbCfAQ8uSzH0Eu8Cs/?=
 =?us-ascii?Q?4qqCiFFzZnJC5kqUVC7Bw9+Pha1AmDQXRq0OIevotG2fbFs50USiQHwrY/Px?=
 =?us-ascii?Q?0+N0lgVkV06gUYaQpH01GHC0srg6h8R1QT938dbX6JGiMT50Lpe/ftOhuPdJ?=
 =?us-ascii?Q?tRiicYbCbrHJ9Wf4FrHIz6fwRjUxBLFVy3ZWP838YV9AH4fFobh+DWdr0ZNu?=
 =?us-ascii?Q?QVh0HjXCgtciHBH3NHfskr27ySN6HLPcf2v23mNt7PfVwe6+YwpfQH6Bee5l?=
 =?us-ascii?Q?uRA23P/+TfpxGkdnM94wmTh9xgmEqLtYzgoHyV/0rcu4DPIXoWOcagp278jz?=
 =?us-ascii?Q?aYZ2/+hmIdN4c0jPRQUS+MlxOjTGF8Yvrf25OkJpwGXDhicZcGnsrGZN6XAI?=
 =?us-ascii?Q?QQ206s20/4ANV8tVQvUAIE7aS3ytNJzoLllfZa/v859XsitVg95hFsR/fdcY?=
 =?us-ascii?Q?e+6jQHXF2QnSjOojcK50wWF1Ja2+AS14PjtjZtAPbGYt8i7rglk4U3F4DMli?=
 =?us-ascii?Q?k8k36INr8xoy02o3A2LV71T6EG1Sq1pX0PLm7vwF54z0Ss+QqflkAvK3k0Bs?=
 =?us-ascii?Q?TnTV8JYLiyHVQGQAYFovT6zGx7sWD/dXHy81q3rcf0v5Meg9+IZzIDR25c2y?=
 =?us-ascii?Q?X6HCNCBOYAQvxYtOVS608tLd9pGeoahDZm/7SmqaP428bkMpLji4mu29aV3s?=
 =?us-ascii?Q?Jcu4My9trloietMAWju2ptZKlNLHUUkSQHj3YUIIMm1v0CY1BVir/qkKwl6D?=
 =?us-ascii?Q?zvHhf1ukb3jVDJ+Ti5Dha34i5nPWk7uqgoiX++3kf2wZ4yb6EdgzlolPgs56?=
 =?us-ascii?Q?9AUUa/gZAf5uRsw8gkdvueU/8MrvSZwrxQU/y8xRMLIeq5fVBtOzc6u+98L/?=
 =?us-ascii?Q?OnC3DnZ1U/1KRrNtob5JYFrh/uhaSKd7LxmDXrxk/I2i636r5ZAYhB7KoZ8A?=
 =?us-ascii?Q?frfS+414Wsv+qz/87ciVi3QsYqXZIaGvebxcBZnDODQqOpcajNueKaWFub6D?=
 =?us-ascii?Q?OrbCX5MOcS01IEaO9rMDrvmX9PUGuySTZNqEDmQXQal3nuhQtEfzDywucLMc?=
 =?us-ascii?Q?6/LS3hyuYzABGFDshSQk1AlE0BnPVGfYiYljZuVp8YOLT4/Kbtf+P+o9k1Mn?=
 =?us-ascii?Q?tXG07zFaPs6PkpQfmJ+EWMmbq6Oc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GI9oxkxnAPOCZ7DV+Ta4IUeAXguclf8aTsvx2PQXsrmvq+FKkKztolcW6RXA?=
 =?us-ascii?Q?FpGsW/mXVrIlpJkGNxvxOtE2ohfTN0V3TaHOkOX+OP5OJ0LBAnUndAQNnXgS?=
 =?us-ascii?Q?Be4qAyIhUEfCTnC4nWDYFPZ/5ZaxW8ZZxno63nTCQwpWolRMjveoko4FWVwD?=
 =?us-ascii?Q?8y7zYdb9E9gB7lvf+Mql+L9SpSwRlMg3O3Td6ptIwNr9VPX6RMTrix3yb6Bu?=
 =?us-ascii?Q?l0Lw4BGrQUTRS4IolHWWWUGx8bKaPOjqjmrIvPwbG7mOgmPTfAyGUl/3r4ZC?=
 =?us-ascii?Q?KMEWzjKzGcihHNmeoDYWk0teTcRXJgwyHRz4wxB8RrmHab15QmMVLVkSVZFv?=
 =?us-ascii?Q?j16sfK9ndRBJkW45f3DpOaBcEKZFZ4xeicBsWxLaOJuNkxuXQoA25nHXopLB?=
 =?us-ascii?Q?DkFYZ6LcaOAzxIc5o4RNzoLXzHF7i3qvg5Mltz3ryJR789YglbyaUjwANpg+?=
 =?us-ascii?Q?uo5SOJXLktMxpZj4GNL1Up0YawV7b/C4aXO1m2pRIhzYOxrJK4VF45N3Qae2?=
 =?us-ascii?Q?G1Q6MEvQ7i5tjzJkXPxpKKVmXcyWxo5NpGsopoH+Nx8RgkQrgE09zS0NsgH9?=
 =?us-ascii?Q?AfGfhMyIR1U3PxmGS6y611yMkN0EHdAEK4DuGyoiPZhEkaZvRaYtU8xReUX9?=
 =?us-ascii?Q?XIX3NvA7N3PkCvF5PNOnWka0msO3EztuxTNievvS++duE6N06JsIOVJD3vAQ?=
 =?us-ascii?Q?BixgUmH06iDsj5Zvu0bZt8wgu4xngkLwHaRGjdPznXpA7BzRp+V7l35dgTCO?=
 =?us-ascii?Q?5EOOtssWRiNPaNcwwFAWSHCvi/rutRcswAcJc7Fmyh968S/N9F212G1Htlzy?=
 =?us-ascii?Q?VPtTX/a5BfI7kMm8gCibEZKvl/Xn0Iafat+W7EgVnDUzu5CnTXyOg1tAGViD?=
 =?us-ascii?Q?OUQYWkaboeB3K/LroKRvgtBGp02bl4pAL3WaQf92UnOcmZqhFQMCfbLNKfTx?=
 =?us-ascii?Q?xgPM/Kn9fGB7F0fdAEQNk8Nwi0UH4MiJU4EoCTeyd/NpO7B9LcSty/KDZcUe?=
 =?us-ascii?Q?EW/nLa3uzmIKsj+cP/aGg7bv3dWQVf0NKhyB55zeZXO/80fxF3zs58Z4k9Zn?=
 =?us-ascii?Q?dt5T/A9A/5J4MHodFjefkHkowy+DJttxPeXsyybPHUcwz3HJ3vISMvoqX2ob?=
 =?us-ascii?Q?dUH2lH//5gMxqI/R3hYdJYa461EkAIwhEeiOT8/h2frGDqHnh2x0o+0OlFcF?=
 =?us-ascii?Q?lwQ0n1k8YnXh2MC26Cs2K2K2c4o5u/YjQyhKb26vssdryZqZkWkVqAGAK6PO?=
 =?us-ascii?Q?zsL+m0bn5rwIQ8Kge+pQJG8sSSomAF/I0zkX+4rqL1o/x0j1FhL8qPuhX4MJ?=
 =?us-ascii?Q?fmBatGJ1ggwR/ci0zxUktTQ1SmxMfv53l+eVVt9sKXwmtEa7akua3ynSj35V?=
 =?us-ascii?Q?G1TXTa+fODpVc/mFeIiuSYX0C0N7ZCEevriEfbe7B/01Qz71SSMiohPebI0O?=
 =?us-ascii?Q?gJvjImoX0jXjN+9iaTfMfN7ARDNdj+5d7erQcj0+1OLkbFtZGkrLIor1sWjJ?=
 =?us-ascii?Q?CrQgXJcF+rhh03srIBFRr2T127Eq5XysOsFfd1JqAfQ9vqj6wDbIe14RTmGT?=
 =?us-ascii?Q?VrVbzEIvQ2M+XX2Dm+EY77j4b4erxy+lijDyzl8J2mnWgm+ityD6cFak7XTZ?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f0ab17-f78f-4e6b-6ff5-08dd76be055c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:54:26.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0CtYfo63+o6c55/zAdpyOOhQ3zHh6gM1tlWTASATPcYLeLMhtviFH0ODma+kvvGY+tev25clYeQReiZXB4p38+vaY7iEgLaRge54XWOPa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8774
X-OriginatorOrg: intel.com

On Fri, Mar 21, 2025 at 12:54:17AM +0000, Tushar Vyavahare wrote:
> This patch series adds tests to validate the XDP tail adjustment
> functionality, focusing on its use within the AF_XDP context. The tests
> verify dynamic packet size manipulation using the bpf_xdp_adjust_tail()
> helper function, covering both single and multi-buffer scenarios.
> 
> v1 -> v2:
> 1. Retain and extend stream replacement: Keep `pkt_stream_replace`
>    unchanged. Add `pkt_stream_replace_ifobject` for targeted ifobject
>    handling.
> 
> 2. Consolidate patches: Merge patches 2 to 6 for tail adjustment tests and
>    check.
> 
> v2 -> v3:
> 1. Introduce `adjust_value` to replace `count` for clearer communication
>    with userspace.
> 
> v3 -> v4:
> 1. Remove `testapp_adjust_tail_common()`. [Maciej]
> 
> 2. Add comments and modify code for buffer resizing logic in test cases
>    (shrink/grow by specific byte sizes for testing purposes). [Maciej]

Hi BPF maintainers,

could we merge this patch set as i have acked the patches? Or is there
something that stops us? I suppose this might have slipped during the
merge window?

Thanks,
Maciej

> 
> ---
> Patch Summary:
> 
> 1. Packet stream replacement: Add `pkt_stream_replace_ifobject` to manage
>    packet streams efficiently.
> 
> 2. Tail adjustment tests and support check: Implement dynamic packet
>    resizing in xskxceiver by adding `xsk_xdp_adjust_tail` and extend this
>    functionality to userspace with `testapp_xdp_adjust_tail` for
>    validation. Ensure support by adding `is_adjust_tail_supported` to
>    verify the availability of `bpf_xdp_adjust_tail()`. Introduce tests for
>    shrinking and growing packets using `bpf_xdp_adjust_tail()`, covering
>    both single and multi-buffer scenarios when used with AF_XDP.
> ---
> 
> Tushar Vyavahare (2):
>   selftests/xsk: Add packet stream replacement function
>   selftests/xsk: Add tail adjustment tests and support check
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> 
>  .../selftests/bpf/progs/xsk_xdp_progs.c       |  50 ++++++++
>  tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
>  tools/testing/selftests/bpf/xskxceiver.c      | 118 ++++++++++++++++--
>  tools/testing/selftests/bpf/xskxceiver.h      |   2 +
>  4 files changed, 163 insertions(+), 8 deletions(-)
> 
> -- 
> 2.34.1
> 

