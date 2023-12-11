Return-Path: <bpf+bounces-17425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA3D80D4E9
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 19:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75232819BD
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 18:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435754F212;
	Mon, 11 Dec 2023 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhuE/zYF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C16C3
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 10:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702317845; x=1733853845;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=akjonuZgxBZW283q6MDCYAb3BTJ3cGbFc3EbfKOfAlY=;
  b=WhuE/zYFDdh6Iu9DA8zJ+afFWGWkunpl+zbM6bZrKWJ4hTcEeov8Mnvb
   AlNH10gEMPtxWpzmymHQ+j3dafCxr3fdrw0ACT/vVv//Jjp6z7UgW6JNt
   LoIGjQ5zzjtjbQzVMni6vPeHm423G+SOGJFOO7oqsMvRjC6V1WIUywmti
   dsVPI9sigHeweQU1Kv7iK0GJNMy5kKHT60SoEkQCYUoQr3wl4GrdEBCtK
   dqaKPHKtGDlM+yKtXO90KmT3RsNV14Aa37h6xB2l3/iurUFA7q6cVNKdg
   0/WPFvI9BrC3oxnfr+MteOhyNrV44tklSLvQnAOiSAESzoAC+bKq4VvCa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="397474117"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="397474117"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="766470924"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="766470924"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 10:04:04 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:04:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 10:04:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 10:04:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5n3CTF10KxXdqxVror0QecRDeYpgELd7SRyx9FnU1GbXDv6cndWAwQ1kKCcybQQ54/jTBD6br42wWLMRprWMo4BaZXP26T1LfopDI497H9lxrEkpgEgqLQkr1zn562VGNTZVmn5jYNzZRk393mSTTlOTVmsIL+bhprGGJhERtvip6drCL7JCMKCnwxhuARFLyN+0/jqDHgKkNaJhWZzHzIkibX108q7SEl0ZIrI0sCDoFdSA+3PP5sy6ZoB3D4A97AC2Y158gqiOgKQwAdzz/AXuV4r/h7xc+AN6IREVyLMKRUXyxSblbAzQG3PH5+O5FKzsU0eWZzb2S3rl5cjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP9sl/Nsn18JIB/UC9WBLb9JABOhXUzWkqRS2buPu00=;
 b=T7TZUntUg3rszPkcLW/yfFZCOagvyWLGmcywFg/kxcMK4X94tbwRtha9GHNZFy8ou5Kp6ZriGlNds1fA7hytwCHkjwhesAm3rMFYbuRKFNe7P7Oj1SArwNvPRaZ/a5iENzrupSOe9HQW6WZLtrIUPo/EbSkTkrFhjChBTTsJ1mt8KQ7RcsEFwFe9JVnpk3vYWVmkEL/XfTFENRR2n/mFM8Ew6qJFZVI8a/BhCLPOolxEjcw9xh8qS1x7oEZw4/E0/qxw5EjXa2ioXOc8jyOHMTHi32Mkyt8/3RLQgyWqfAIbGA8vbi0vQE4zvBxnDVPsG8859si4Yyw+BYSzLRERbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB7962.namprd11.prod.outlook.com (2603:10b6:510:245::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 18:04:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 18:04:00 +0000
Date: Mon, 11 Dec 2023 19:03:55 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <jakub@cloudflare.com>, <iii@linux.ibm.com>,
	<hengqi.chen@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 3/4] bpf, x64: Load tail_call_cnt pointer
Message-ID: <ZXdPC1pH0tBY85B5@boxer>
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
 <20231011152725.95895-4-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231011152725.95895-4-hffilwlqm@gmail.com>
X-ClientProxiedBy: DBBPR09CA0011.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::23) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f1b397-23c6-4002-c5de-08dbfa738d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqOytXyOHXwPaoo//cLNvjYwzDrl1pqa3YE8J8N8K96wzg5TA2Z3p7YXl+5bBzGhRyDYINe/Zz88r7DmYz5wcunpPpbKYUeHw/Mh5EMm1CAEp5QyIS6iaL6jdJxLFmfmxA2+6CTw0XazC/SZjnXfYhj8wNRoJVv7Z0t0LH6Ea/AkDEz21o54vbCO4IcuFNjvzG9Mj85YXY5ltzXRa5rEsfpxEo3oWJD6rHH+o4FhTUgQQxzpxzR4CTjeFoN4byepPT3fgqmKHktTvrWIdbW6VsbSvj49B9D51eVUW2zgRiAjLI+SYMH128AWeszlgUn+oBADOMeJx++5TrwsKk3KixvkoAqeBqJd9nLjOrbkQyH7s10iEtxtXSiSGMxtpVIw1NxjWFcAB71Ag8L/SdvqhBKfMYX0DPV+bSIkEVOKhBU31xI1UKmIiXfTOeckIompfZ2DTnINUeP8m1fWm64StKvcU4nFL3kQ3/gvez6xuDWMCRmI/rmZzDKX3zXzqaHNjVXRl4f09MRhUyciQwirce0rlG1Fj9mf1qpUR8Pj8744X+xVBqFhEvXlgmn9KxuU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(6506007)(6512007)(9686003)(6666004)(83380400001)(5660300002)(44832011)(33716001)(4326008)(2906002)(41300700001)(4744005)(478600001)(8676002)(8936002)(66946007)(316002)(66556008)(6486002)(66476007)(6916009)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9wxNAmbNanAXgPw7AYPlB5vIV05oOOdHeUAjxQ3OVYIkd3fZZa83747Vrfs?=
 =?us-ascii?Q?oLoE6cmBTPqAP2NXK0JFoitm8Xt5cul1xZEpr4OJ0Ymk+HpKs6d5OzFZ+KRH?=
 =?us-ascii?Q?N1roI5CJq2KmRUairM/k9lD6lTJaq3G9Ir5A4vQr/U8pTrARooi+31lPvnIe?=
 =?us-ascii?Q?lvN1PTmVTUu0MV3/SrqVmv6z1ofkI0qjSBCz5vaOJaip2WyzscwukH7lSQNc?=
 =?us-ascii?Q?02NlbT1WYBwXo+LA+5VBjH3EZJAgOzn+c3YMgKx0UpeEhYi9Drcm0McIdvlv?=
 =?us-ascii?Q?VAgbX7wdlCF5gePsQuIXG7ukQRjG1X5Ei+/ZOSM23qn2oU/AbpXcMFvuUiyS?=
 =?us-ascii?Q?/tOMTlPpfzFWs94VNnXvxX/6Qlm+5Tswcm9nVLbWjpJKEH69DICRnBFZa5UL?=
 =?us-ascii?Q?XvEIdc0HqsE/g7uSSLhkKbIomQgssIjLW3LIp38XRI2Zt+7v3x4LFNq+utcA?=
 =?us-ascii?Q?gAtOBD5CLTQKPQksb8P85Q8Xr2JY8ctyQB29bWzmCBMs3ppboJRqxjuSx/YK?=
 =?us-ascii?Q?w/W2uMf/uyfUlobgRSLUcfwUbS8l2PS/PDpr1zTPuquL/kFXmPOI4tldRD3q?=
 =?us-ascii?Q?MhDpSjFf6irJflRX0wdbW8PRwmTVovfQ92t7PcnXcxQi+E7fZMl8y+Ht71y2?=
 =?us-ascii?Q?YaclDEurPpdyi5MyK8O31VF7bYJeskV5NeRVvWO3X+7S+DEj3LQEsVLlDV+W?=
 =?us-ascii?Q?rWqslqcboAz4vxefIrigseAu4D6w1TsKrfVIjWRYyysvphXN+otwRD1/UDZS?=
 =?us-ascii?Q?vw+pSPJunTh/Kbi/y8/DWmWyrqfoH5AfXON/RiC0u7zwkhs3iKXLyXvydYJ3?=
 =?us-ascii?Q?E1HZaVxwxabP4P3roulX/bE450rcQRUB42zElVRrGN9m3cQp4QI6UtVMtWC5?=
 =?us-ascii?Q?H84fS2a22sAkOpkpylk8CPcPCXnmoXpzRKe9jI1pIi82aBjzXqDhMXa0H9gG?=
 =?us-ascii?Q?eJF5npIxprmoPmpcOzbhZzyQyUf81jwQodTXDa6hU5i4xdOvSESAvKwtRRV/?=
 =?us-ascii?Q?f+TT7v2gvch42pRZP1fjNmvR6eppdfGsmVh4Td/oUFPOYcSAmwRmDlUD3GnG?=
 =?us-ascii?Q?eKajmSuYuyAaOdLuASaxloNIavl6aoiMPKEZsCgg1r3vbli/I3r19NbbKf4N?=
 =?us-ascii?Q?25pqNID6j3k1XD1QoVirWp4CR6BASIHWHx2ntj20MAlPIN5y7HtWn9a10jXv?=
 =?us-ascii?Q?7HfSSINacYVlbwR/b8QPWPt6IdsaTKg4IInyiNAkg3PH52AKttztKxViVh35?=
 =?us-ascii?Q?KTGThnTc0U9O6EGjhztgNhhNOwwIf776SraSk0jxsLuaOWq+oj3MVnLoR+Lk?=
 =?us-ascii?Q?J4VapRFCb7taqtBhDVozTuPFeYECZi4EK6awuQirKAoLzzy+7+eGB1Byrb13?=
 =?us-ascii?Q?aclQNP9Xk7RF32Kg25jdyft3pVIElm1r9/vC44MMAYdNa1t+l5NE9NBdfrEi?=
 =?us-ascii?Q?UAGYsd46g3p/R5JY19CoYm4lqqDhNz4dahqOLoarrEJtib7kODtnOKZRCiH0?=
 =?us-ascii?Q?D+UVbrQzWNFxlWoeQyvNoA2ej+QpvT+lKISCtHAVFGafR4c/2dBojMP0A1U3?=
 =?us-ascii?Q?xAqZLlVH02uoTW4uZgW1xqDpM7HiQW+JBww6VB9JVQkjLkftBLsNn0fWmOdj?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f1b397-23c6-4002-c5de-08dbfa738d9f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:04:00.8533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZPWtPjCwzUpl7HYQujjMoGokJ8W2EhfDxTPOlCsCHuJvkmLfPRpKf4ZCSc0f9MXM59i21H8pjp1FJt1hM/ZC87ZEIH4THZSgvALkUyPyWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7962
X-OriginatorOrg: intel.com

On Wed, Oct 11, 2023 at 11:27:24PM +0800, Leon Hwang wrote:
> Rename RESTORE_TAIL_CALL_CNT() to LOAD_TAIL_CALL_CNT_PTR().
> 
> With previous commit, rax is used to propagate tail_call_cnt pointer
> instead of tail_call_cnt. So, LOAD_TAIL_CALL_CNT_PTR() is better.
> 
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>

IMHO this is out of the scope for this set. We are going to target the bpf
tree and this patch can be send to bpf-next in the future.

> ---
>  arch/x86/net/bpf_jit_comp.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

