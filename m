Return-Path: <bpf+bounces-16730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C761080557C
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 14:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BC91C20E43
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD415C8FD;
	Tue,  5 Dec 2023 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRcZLrIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96A6197
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 05:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701781706; x=1733317706;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+FuEyjgZe3Bwy65bMxl5YaczBaqjeEg5tlX5MuiYoT0=;
  b=KRcZLrIQzHLj4G0vKZvJwT2aIqbC43ZCH3ifiLy48PN5w6kKxQ/rJA0y
   0Qtm/+ot46ke5LL7sU+thnYsCJcxozyvYclUy9cU/rneIP3S26jaiACRo
   YVCqLQ5rgl9J13Jc97MCguO4MRRKwza+a70f32pw6QCWiKxn6aN8qAel5
   NbHDGSG9Px9IvS+zcwcAbkPquNAa0ohlV1lsT2FbhF/wbvLU2GHxLnC/f
   sLvnQi3M88+KE6VLTyazJSkTrtopWQyWs04NN+3c96jRyizGhpAbN/Lyb
   9uAfhf0LtOiKqgQSyhWPnLSm5U+XE9l6QVTUfKQwHtyu6SngzTUeU+CfR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="392756792"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="392756792"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 05:08:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="747222495"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="747222495"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 05:08:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 05:08:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 05:08:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 05:08:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 05:08:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyVq8RIdn/p2Jgo4MQh3msZQaWoPTW2mDs8I8+fDjVxcNI9EdpbVmim4Vf/mTHg08Mv4OP2irvURYg+Odnjm6klLmrdZ1ngh6F3BjfTlYt1KqqjPOQA1kOiErodT+YOze18lM6ZigbTYhoWvqmXjc9TxGlAyI5w1q7bTGefx/J5AVHkIiOdnpjaiM9gkx7tURTquS4ete6DmNrifS/VTpyE237P4uc4RDJoi6Mj6XcZnKR2yysIcOfBMw/zDVPe4hLrWcK/dQyrD9BnEm7cMQliLXZ8k51w1sDFOrTH8cDRfRPIDWQdTlzzxwc1Y/5oq+EqYaemSxL3OuPQaCxVxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPRrwPkk5ciDdXP/lhcoW1BjBxhrcfpybevX4hdu1IU=;
 b=YTL89RzcRNuB6Y5v2E1rwHpShvowT709F3zYmQDSxfg/m0WGB9YZ8FNe0aETepgKZs/DV4ddsikpkmam2aGnZ6wN48EgS4hNjGp3zb4k20a1JD0/aRHc6frE98v3C4HAI3MNKFrJDR1f6RCIWA670pS9FOoLvJoJL9Jskbx12odITAweAo7W5e5nWZ5kkr8ZcyxujEvGZh0N4RpLaTE61dCQLRXwkN9eyMdIOx6UQRhrYGAVQNN5RhWeVCFKPst/685xih6cTXEC/m2aZ/jZfQBkjcS5/RkeUUdc+gZEs9IiSIiCn5uC07gaoi8oFfRjWLOdMPQG/WD3fNwd4U90zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB8527.namprd11.prod.outlook.com (2603:10b6:510:2ff::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Tue, 5 Dec 2023 13:08:20 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 13:08:20 +0000
Date: Tue, 5 Dec 2023 14:08:01 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <jakub@cloudflare.com>, <iii@linux.ibm.com>,
	<hengqi.chen@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 1/4] bpf, x64: Emit nops for X86_PATCH
Message-ID: <ZW8gsbqkJwC1x4Cs@boxer>
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
 <20231011152725.95895-2-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231011152725.95895-2-hffilwlqm@gmail.com>
X-ClientProxiedBy: WA0P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: c2541c83-ca19-4ba0-9f7d-08dbf5934088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8K3l+5x2di4nldZ3fqo+8aXp7HNCJ99YurADeeeB/Vt0evvUzUNV2nfLtSBeWrD2cuc+Jct5bhJsXIO+FOPk+vM7ymDMEDfBAlamFiQgETZfZoVHeNkb00pOKx+vzXizEwfjR2z0DsIZLnwjySayjEYOBMS5WwCJsTsm7343BaeqEtLvBbf4pDnIp4/7j88HT8sLjIudTwV2ExH00LbMRBxrTvnKmqsNwbYYADHLKnJsmKt06x1iSeFXnaTSypY484VWlaubRKm7gjVDZ4Wc9F5kWIR38xeLwaTahZuMVaddsvvbFwPbDQErYPYUtJkXuzpsm1xLF2eE0sMMKo9Oh1oGno/QYINQdmzDBKG6sNC2r+xAcdtHCyTXdd/chZTsmvGfuYDZnBjkyPewEFLfqJue9D5CesW5WUxzQ8CbVE+V6An8mx4+4AdSLeJyuBCfvRvwHIk1TerN/14qs1VbJrlGFZOJeLm23tZIylVSrKQEbuMQpFfk+etGTaj3bDDRchh0md+Gr3WRp4VEIPF49jiUOEwMoi8O8MUDEXPatz7v7flNdOjLv0pfzk9Ycjb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(9686003)(6512007)(6506007)(6486002)(6666004)(478600001)(66946007)(66476007)(66556008)(316002)(26005)(83380400001)(4326008)(8676002)(6916009)(8936002)(82960400001)(44832011)(5660300002)(2906002)(41300700001)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aQmc/aiz3+ID5lmGVIydaS9UTJjIi57TakA5XUrKrVlwSnbKspD8f+QtS4Is?=
 =?us-ascii?Q?NdKF6SdyMuMf5Qf3cxEWjM6K8OfR4pVaXm1RA2L1u5HfdMw7zgcYZuwMkqek?=
 =?us-ascii?Q?orWKDaKvEqN8CeB8DnX5S5pjUmbiUoGmH4fsmcksiR7XHnMEe9f9CZx6jcQT?=
 =?us-ascii?Q?rPJ5a9gKoG+9t5lYBSpuRiT/VAQZV7jOk5fUDMt/+rZA4XlMPHO3u6JY1ki0?=
 =?us-ascii?Q?RDwK1TUmw3C0LxNNwbqR2VBjSZhoB91srWKXNEdce6F5oL1K1S9H/znfaH9f?=
 =?us-ascii?Q?lBVDGEwPiGRTbYkvB5T5g826cCib8c2e1940mLfF1qtTKPbR+MUPB2GZtpND?=
 =?us-ascii?Q?i+4wrQlrvNGsuKbxExwTWtVxp5z6W6ycWXo8NeEIcQPYkh6bDzkJZo0ZMgTw?=
 =?us-ascii?Q?Joqz+zU3DjpC6OELNpZ5/N5Kzi4cXY0/ZM1oMlHkshAV6lCfl8FUYoYt61le?=
 =?us-ascii?Q?1d+xVJ8FnHJDruXnDMSfHywjaymPrG9tv/sXuyvPNjdgnKWD5+dxatMk2dC4?=
 =?us-ascii?Q?TBGDcCJ4HHZ3KMk7GEgUpkLoqCpxbItipM6qo6531CJOo/IHy67gEsmHQVHU?=
 =?us-ascii?Q?V26B0Whtgo3Z9xYQyJ1v+mwtDgxIiq+YagkLXZrpcp6K+qNaROoXLS9eF5XM?=
 =?us-ascii?Q?uvpoEkbxrPhMoTxMHrLxBvAya9sQyFyXWBZlEtL7DcyVp+ysFozmrd5yBe7m?=
 =?us-ascii?Q?rOfwPsWB6y+m8FZ4gGZ40dD0TMkIrKQLn/7wK4sGTWS2JGvv2dMhJIZF34mr?=
 =?us-ascii?Q?B5hOoe9zyKFxaySipdwvIbUIUzEpzWKTsaBdSy5S53spBQlK48pZCVwBCW3s?=
 =?us-ascii?Q?b+imeQd/H+JIg+NW7XmJA65snDR7uDk6ME0gzYlIJLQGxAt029GzoLpfruL3?=
 =?us-ascii?Q?BQDV136WLlfd+Rb6flKk6+rzoc9bslaFoIbrrGHMPPK1OzogjXKlAowWsq2A?=
 =?us-ascii?Q?Ao5eqsA5nySrMPS/cRcTtsZmmSXapvb+4p1uu2hQtdsr1Ujn33vRtcLsEfu8?=
 =?us-ascii?Q?Pa70tcc5kLnPP0eIQGCORksvAuj3/ZFVU5sNqcf6ZXOTpXUpqI5DJdxOOB4G?=
 =?us-ascii?Q?VxWSLz4o7INoPu77tFdzi/pjXiTSBSx7S9XqeP2kcLcTrXyXJpUSMaPrBb+7?=
 =?us-ascii?Q?9XOaR3LhgzN1aic9wBqEHd0saJTfYbiFVtGh7NBViOukgozDdrt1j1jUNNcm?=
 =?us-ascii?Q?O0pBGrpgIeIEj/aOPbgLW/mM3bzqrzDoqs0+dYnLhUPt5qSgU7f609H/HyhU?=
 =?us-ascii?Q?bIwxl7U3MOGtSrPlfomE7S7DrUqynY7Uz/KfaOlrDbqNbCllT4FdfVDa+2OZ?=
 =?us-ascii?Q?2xzxPmw3zXNdIjNbLuQNtvyXa86u5ufxGkifYrWisMoyhVSqj7XcLzA6zSot?=
 =?us-ascii?Q?nX1CFfNuhufCuVK7iRTOaNkKcXFpaulKDXj99mTVp7RTN9Rt25bWiikH0n7l?=
 =?us-ascii?Q?ck7tsHtQYh4trW3mAKpG4ec5g5FWI8tVuPfe1rKRbAzAwt2ikWiKM6WQ+Z7A?=
 =?us-ascii?Q?mS2rl8ZA6JKbjLgfyRFcH44j8+FSTsECbmHyBWtALkSKOO2waEjEzGnD7gCl?=
 =?us-ascii?Q?EEXZQeVfCYaObp1aWY97hwOfqDj2rTlNv8esWVqPVUIweIZsGszc+rMDacHG?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2541c83-ca19-4ba0-9f7d-08dbf5934088
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 13:08:19.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PH+3j70W+mYp4Vii/G6On26TViWSUfFUmCocXzBMiq9/C1Rj1AAIBX52hebOwOHPjJWqc9AvWCECRFtQ/9iaM2tvad6VnBJADny8c3CHMds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8527
X-OriginatorOrg: intel.com

On Wed, Oct 11, 2023 at 11:27:22PM +0800, Leon Hwang wrote:
> For next commit to reuse emit_nops(), move emit_nops() before
> emit_prologue().
> 
> By the way, change memcpy(prog, x86_nops[5], X86_PATCH_SIZE) to
> emit_nops(&prog, X86_PATCH_SIZE).

I find the subject of the commit a bit bogus. Could you change it to
something like:

use emit_nops() to produce nop5 instead memcpy'ing x86_nops[5]

I also feel that you should be consistent and address other spots that are
the same as the one that you are touching in emit_prologue() - there are
two more from what i see.

> 
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 41 ++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8c10d9abc2394..c2a0465d37da4 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -304,6 +304,25 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
>  	*pprog = prog;
>  }
>  
> +static void emit_nops(u8 **pprog, int len)
> +{
> +	u8 *prog = *pprog;
> +	int i, noplen;
> +
> +	while (len > 0) {
> +		noplen = len;
> +
> +		if (noplen > ASM_NOP_MAX)
> +			noplen = ASM_NOP_MAX;
> +
> +		for (i = 0; i < noplen; i++)
> +			EMIT1(x86_nops[noplen][i]);
> +		len -= noplen;
> +	}
> +
> +	*pprog = prog;
> +}
> +
>  /*
>   * Emit x86-64 prologue code for BPF program.
>   * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
> @@ -319,8 +338,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>  	 * but let's waste 5 bytes for now and optimize later
>  	 */
>  	EMIT_ENDBR();
> -	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
> -	prog += X86_PATCH_SIZE;
> +	emit_nops(&prog, X86_PATCH_SIZE);
>  	if (!ebpf_from_cbpf) {
>  		if (tail_call_reachable && !is_subprog)
>  			/* When it's the entry of the whole tailcall context,
> @@ -989,25 +1007,6 @@ static void detect_reg_usage(struct bpf_insn *insn, int insn_cnt,
>  	}
>  }
>  
> -static void emit_nops(u8 **pprog, int len)
> -{
> -	u8 *prog = *pprog;
> -	int i, noplen;
> -
> -	while (len > 0) {
> -		noplen = len;
> -
> -		if (noplen > ASM_NOP_MAX)
> -			noplen = ASM_NOP_MAX;
> -
> -		for (i = 0; i < noplen; i++)
> -			EMIT1(x86_nops[noplen][i]);
> -		len -= noplen;
> -	}
> -
> -	*pprog = prog;
> -}
> -
>  /* emit the 3-byte VEX prefix
>   *
>   * r: same as rex.r, extra bit for ModRM reg field
> -- 
> 2.41.0
> 

