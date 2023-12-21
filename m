Return-Path: <bpf+bounces-18524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13AB81B56D
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 13:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5655B1F24A2B
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384496E2B2;
	Thu, 21 Dec 2023 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJ4ushmV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DE6BB5F
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703160163; x=1734696163;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D4RbFfnkfl2pZVn8mt6TcWBTNBBwfrrK2IMS8VAWytI=;
  b=mJ4ushmV/2Fgyxtg7Po5pRZYncQd4xqguJpexTN8+fSMKSne1hJb0cyu
   UQTIfKM9myF0HELOaGYa3jiY4YS0SiWnvpWXmPa3M8zC4bowGukZUegNm
   Yddr1ac7My7yHMQmFqHCzidl556Jd00aBxXFaGtYVt7CuCYu738skgeqZ
   2ULfxbINYav67pftJRkEfEaShm0zmZAX4Sn0f3UMkm6RRlltiFPQtEnLQ
   8AErN0y2jrMZ2qWk4rJgNazQYyiH1vlLHEwbj+2n9U5rsX1sAjDZQVe4o
   PBCFDals0+rr6q7s2clXg8cpzC+qBS+kAkeralJVWAcpB73saJZ+p+c5P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="395691074"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="395691074"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:02:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="847097584"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="847097584"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 04:02:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 04:02:42 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 04:02:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 04:02:41 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 04:02:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTderrMo2rD7PxthrUX5cBQ3NyUljISl6mr5tNRxkr+keAGxqH9H6WX8iSJCu9LOj0hOA6099rizHbI4gwcI+Nt6wXmUO9deJ3u4kQzTaWhQJJs4kys65c2Joo4cJK9U/n1p+r7KJa6sZLzQWcRsFErnH43ubGfxIdBkLNT82w14mujkGKqteKamZzwjHrgsTfyb2N/17/XGLSGomtnlViBB1Q/LjiJkWrpvLJtZavNbo1mN7slUOH2aElV/df8fPqgrpAD4QJHPR8eLUgAk7L9Q7TIFcndS2dOs8ciyXoK0Y7gnLnvpf/yIqVA3AIRSyhFrZ2+0x/awmmPtx4/ZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suBN+ceA6pRGxuDhFrRUv71hgEVRd6nVtAI7NUyoX9M=;
 b=BL9ACTa9u2FI+27ISaZvR1WlS+B+z9GmpohY1mrHERDEgP/9vabgYnVlvuhRyq9N6qIyMmFSOA9jOwX0mlb+suQBOItURq8qS7cFOb66qJNogzYjPpsVk5K574bwntTs5r59ZO9NsuQDZzmZJ2XDiG3UokqtSdTdpXE2kSZE9QWItUuoMtSsxtk1wt6tGYM3FxxEVTOuq1xqhOjmT1SVF03ZnMhmkavAe3pm8rqRKL4d8YQOVQsjt/qAU1M+wY6an4ipjlk7XmKrFzqsnS6aMTOKLxm0Dw1cng4WQR4rnpP9vie4Idmn/GHhIP9jactclOaQYLKiD8nEg/sklZiSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7874.namprd11.prod.outlook.com (2603:10b6:930:7c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Thu, 21 Dec 2023 12:02:37 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 12:02:37 +0000
Date: Thu, 21 Dec 2023 13:02:22 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <jakub@cloudflare.com>, <iii@linux.ibm.com>,
	<hengqi.chen@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/4] bpf, x64: Fix tailcall hierarchy
Message-ID: <ZYQpTm9SmTkGBNI0@boxer>
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
 <20231011152725.95895-3-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231011152725.95895-3-hffilwlqm@gmail.com>
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 166f2278-1481-4830-fdab-08dc021cb8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPY6dnctZ7ew/eIGkW1abNInwOGx4PUuz5TDj+6fuucJGIpy1oclekPRAsdcmdvBS9BgDeKm5fbiZgAWtd7/SuZLG66vfXNjSgF3e82kx1YCerC3+wp2g5jzVSHDLK3MyxfKb0F/BDW7KKLRLSkAFrIO3z53J540Esby1mW9mLXHKPnk++HSs0LXYJKLIHHXqpFjHZnQiqCGq9P8KNx3CpMj+imTWXO41fJvm6GfWGkUtXyt0hAlJ6x5yHF+I0wpn4x7J3IUYYNLaG7W/6rhxvRkoKnFLwL67AIFcdATwjOnAqs1SFG9ZkEZLTuhsjnLv8B02O1Ppj+CeagDqBxdoG7Jnt1jDeT/TueQ4VdxgxgsOUvv9JCzwW0n6lV2FRuDsOIrkRqo+JnTrS3HBGXOKsSbyEpqlZVOzomZi1jWlUl6YJb1iDOeRXqNHX4UESHCAJvYrYS9/O1+K2l3LdfkOZn153mmrPbOs1y/yFRJ9tN/DQTdA4sEMLwrQzjiVoIi9jlGjabo3A7J7Q8kpHVvffyOVGok2iCz5CpR8YKiq85TreWgDny0FnsohPpAIS/S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(9686003)(6666004)(26005)(6506007)(6512007)(82960400001)(8936002)(38100700002)(2906002)(86362001)(6486002)(478600001)(8676002)(4326008)(41300700001)(83380400001)(66476007)(33716001)(44832011)(316002)(5660300002)(6916009)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s1+SFEOTCMqBrGJUYnQf+ADwt+Q7LpgUTzT/Sl4VO5sc2SCsKZJaUwvcyg+8?=
 =?us-ascii?Q?bEIft3ht83Xnf9wWyaaZyPIvh+RS7CRqp21U3as3UqOFrpwexzvFG9dx4ivY?=
 =?us-ascii?Q?cryryWGADWoofhMEv7G2mNVbawH8zn5mSvtGQxOoolUyWb0jgQmjTTGGyg2A?=
 =?us-ascii?Q?0gA0ayj55Rw8oOhb6AW47WzoTzH1UvRZrRlYKCGoWY+hhK0s/ORXE1q/Qcev?=
 =?us-ascii?Q?RcEqh31rFvXwmOzoQUbNv7po9CjCSBkw5FDlFvr1dzg5LBhJ8BDczJilachQ?=
 =?us-ascii?Q?Cynyt0m2KH2LlFlX6HyfDBHE07du1z76iTfYN0BoBQaKNBJKrH2gYay8O7BS?=
 =?us-ascii?Q?6rAAOR6kPB0t8f9+/BN1IwjhsTyXVFAd6tmH+H0jiAu6z78/k9SN4eS/4P3U?=
 =?us-ascii?Q?JmV884Cw30n6C0CVDUDYnj1arBXJWGnQszlo+6Df5KYI4VqgT8Yidwc1yvwf?=
 =?us-ascii?Q?nevdHjkeSel4QMHKhNrVmo6FjLgyXRa1bSSaKat1VdXHbCO3B1xVaKoAZArt?=
 =?us-ascii?Q?+q53vROKQbit4dgV0M+08jQ6LQr+ru51fo/7NTS7ZwCefO9yJJgFkjOUu3L1?=
 =?us-ascii?Q?eDjYB1HMrmnwYv5VHkGzxo33sEmGwmKE1wL7jP2qz3ggW/lK5lXl11RMiB38?=
 =?us-ascii?Q?BoQvKnGMcU8rbNA5CgQ819Z5EkIDFimqrxrB3SLMff3B4d9qNih3ST48KXsZ?=
 =?us-ascii?Q?HI8KRyBwaiLQXXhBl/PRPSAcZlKua0GfutYiyIhr2KVm+p1XjbrwgEq7KtxW?=
 =?us-ascii?Q?B8E20rOMPW/y1zqWy1P1eMMuUH3en+zWTe9xGM69zUATaFQK7F+cyHv7H/x1?=
 =?us-ascii?Q?fh0AQviaZ01t7oKCUKAjp87NrpV/0rCIjEOfQUw3d7/wJ9NrQDHoiJbZa7S1?=
 =?us-ascii?Q?J7BQHX9S0JXVIkWpVULAVhSSHUsa/SpL0xqFrx70/OfguVsX+V4Y7HYO50ke?=
 =?us-ascii?Q?Bve37C1gIZhRPK+5CgHHl4J8rbuiTml5t4dlikZ6hJdiZBQNpTVmALZ8aMJv?=
 =?us-ascii?Q?l6oW9XpgYtZeuFVrYWBN6aTM8YWQfQ5AEfIAnhGiD8PmB8Fo5UNNZcmKzeYg?=
 =?us-ascii?Q?0lyrKZdsFpZWzOZKjQ5vWSigGbRqGfXvrR1P5efGB6hNlIjXgd8NShVvakta?=
 =?us-ascii?Q?jPlriuKMe6KgqnwnX/nLckEkTzwe2C5PpXFEkwK6RG+Af4ytuj/PlEDeYBYd?=
 =?us-ascii?Q?jht3QQGTiLHER7w++1Qi/GKcNYXhi689ZJQeb9DUALlDyrXIEIlZme08fPnC?=
 =?us-ascii?Q?cPDEzFK9J0wf56mMy81utlvef661fMMoaS7IGPWOqHTo0l36w4lAysBlT6Pz?=
 =?us-ascii?Q?LOF+9dtzQgrp22huK6gkE7nq797C4zWH8RdfzoHMqWSDXu3Zc/wWnkrLg1sc?=
 =?us-ascii?Q?OBTZHWJNcF1jebQO4wS9fdHye4K6jw30LaOZI2PWRqSQKs2FmbaQXyw0OIQo?=
 =?us-ascii?Q?E0WXS8hiLqlf8HlOZRf1B1qbKaS+nDLq1UZZGYPAuD8O40zjI39IfuMOBnSD?=
 =?us-ascii?Q?Yvn5GVrnLWhj8O7gKHdRNT5PJLufbR4sq6TQZXPz2pJiwuxNeCPohwEt+EDu?=
 =?us-ascii?Q?OOKciYoTGT8QwVraJpxRfBFG/ewcKMWuOJaOY5y7G7K4iZmAqjgaMecEfL9u?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 166f2278-1481-4830-fdab-08dc021cb8eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 12:02:36.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ManbUvVlVfLTYvOhg31ncgAwX1SQ3SNUsrA30xEFovRWBDCt5xksLSRBrloXG3utCISTeVUaq3bSR7OS0Fnl8ZmqXJtiLC4L95S2uOqmpmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7874
X-OriginatorOrg: intel.com

On Wed, Oct 11, 2023 at 11:27:23PM +0800, Leon Hwang wrote:
> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
> handling in JIT"), the tailcall on x64 works better than before.
> 
> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> 
> How about:
> 
> 1. More than 1 subprograms are called in a bpf program.
> 2. The tailcalls in the subprograms call the bpf program.
> 
> Because of missing tail_call_cnt back-propagation, a tailcall hierarchy
> comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.
> 
> As we know, in tail call context, the tail_call_cnt propagates by stack
> and rax register between BPF subprograms. So, propagating tail_call_cnt
> pointer by stack and rax register makes tail_call_cnt as like a global
> variable, in order to make MAX_TAIL_CALL_CNT limit works for tailcall
> hierarchy cases.
> 
> Before jumping to other bpf prog, load tail_call_cnt from the pointer
> and then compare with MAX_TAIL_CALL_CNT. Finally, increment
> tail_call_cnt by its pointer.
> 
> But, where does tail_call_cnt store?
> 
> It stores on the stack of bpf prog's caller, like
> 
>     |  STACK  |
>     |         |
>     |   rip   |
>  +->|   tcc   |
>  |  |   rip   |
>  |  |   rbp   |
>  |  +---------+ RBP
>  |  |         |
>  |  |         |
>  |  |         |
>  +--| tcc_ptr |
>     |   rbx   |
>     +---------+ RSP
> 
> And tcc_ptr is unnecessary to be popped from stack at the epilogue of bpf
> prog, like the way of commit d207929d97ea028f ("bpf, x64: Drop "pop %rcx"
> instruction on BPF JIT epilogue").
> 
> Why not back-propagate tail_call_cnt?
> 
> It's because it's vulnerable to back-propagate it. It's unable to work
> well with the following case.
> 
> int prog1();
> int prog2();
> 
> prog1 is tail caller, and prog2 is tail callee. If we do back-propagate
> tail_call_cnt at the epilogue of prog2, can prog2 run standalone at the
> same time? The answer is NO. Otherwise, there will be a register to be
> polluted, which will make kernel crash.
> 
> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 40 ++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index c2a0465d37da4..36631129cc800 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -256,7 +256,7 @@ struct jit_context {
>  /* Number of bytes emit_patch() needs to generate instructions */
>  #define X86_PATCH_SIZE		5
>  /* Number of bytes that will be skipped on tailcall */
> -#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
> +#define X86_TAIL_CALL_OFFSET	(22 + ENDBR_INSN_SIZE)
>  
>  static void push_r12(u8 **pprog)
>  {
> @@ -340,14 +340,21 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>  	EMIT_ENDBR();
>  	emit_nops(&prog, X86_PATCH_SIZE);
>  	if (!ebpf_from_cbpf) {
> -		if (tail_call_reachable && !is_subprog)
> +		if (tail_call_reachable && !is_subprog) {
>  			/* When it's the entry of the whole tailcall context,
>  			 * zeroing rax means initialising tail_call_cnt.
>  			 */
> -			EMIT2(0x31, 0xC0); /* xor eax, eax */
> -		else
> -			/* Keep the same instruction layout. */
> -			EMIT2(0x66, 0x90); /* nop2 */
> +			EMIT2(0x31, 0xC0);       /* xor eax, eax */
> +			EMIT1(0x50);             /* push rax */
> +			/* Make rax as ptr that points to tail_call_cnt. */
> +			EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
> +			EMIT1_off32(0xE8, 2);    /* call main prog */
> +			EMIT1(0x59);             /* pop rcx, get rid of tail_call_cnt */
> +			EMIT1(0xC3);             /* ret */
> +		} else {
> +			/* Keep the same instruction size. */
> +			emit_nops(&prog, 13);
> +		}

At first sight it seemed to me too invasive but after trying out few other
approaches in the end it is elegant.

I wanted to avoid a bit puzzling call insn in the prologue with a following
prologue layout (this will be based on entry prog from tailcall_bpf2bpf3.c that
was the first one to break):

ffffffffc0012cb4:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
ffffffffc0012cb9:       55                      push   %rbp
ffffffffc0012cba:       48 89 e5                mov    %rsp,%rbp
ffffffffc0012cbd:       48 83 ec 10             sub    $0x10,%rsp
ffffffffc0012cc1:       48 89 65 f8             mov    %rsp,-0x8(%rbp)
ffffffffc0012cc5:       48 c7 04 24 00 00 00    movq   $0x0,(%rsp)
ffffffffc0012ccc:       00
ffffffffc0012ccd:       48 8b 45 f8             mov    -0x8(%rbp),%rax
ffffffffc0012cd1:       50                      push   %rax
ffffffffc0012cd2:       48 81 ec 80 00 00 00    sub    $0x80,%rsp

So we would have hidden 16 bytes on stack at the *beginning* of entry stack
frame. First thing right after rbp would be tcc pointer so referring to it
wouldn't require us to take into account stack depth. But then if we
follow with rest of insns:

ffffffffc0012cd9:       31 f6                   xor    %esi,%esi
ffffffffc0012cdb:       48 89 75 f8             mov    %rsi,-0x8(%rbp)  // BUG, overwrite of tcc ptr
ffffffffc0012cdf:       48 89 75 f0             mov    %rsi,-0x10(%rbp)
ffffffffc0012ce3:       48 89 75 e8             mov    %rsi,-0x18(%rbp)
ffffffffc0012ce7:       48 89 75 e0             mov    %rsi,-0x20(%rbp)
ffffffffc0012ceb:       48 89 75 d8             mov    %rsi,-0x28(%rbp)
ffffffffc0012cef:       48 89 75 d0             mov    %rsi,-0x30(%rbp)
ffffffffc0012cf3:       48 89 75 c8             mov    %rsi,-0x38(%rbp)
ffffffffc0012cf7:       48 89 75 c0             mov    %rsi,-0x40(%rbp)
ffffffffc0012cfb:       48 89 75 b8             mov    %rsi,-0x48(%rbp)
ffffffffc0012cff:       48 89 75 b0             mov    %rsi,-0x50(%rbp)
ffffffffc0012d03:       48 89 75 a8             mov    %rsi,-0x58(%rbp)
ffffffffc0012d07:       48 89 75 a0             mov    %rsi,-0x60(%rbp)
ffffffffc0012d0b:       48 89 75 98             mov    %rsi,-0x68(%rbp)
ffffffffc0012d0f:       48 89 75 90             mov    %rsi,-0x70(%rbp)
ffffffffc0012d13:       48 89 75 88             mov    %rsi,-0x78(%rbp)
ffffffffc0012d17:       48 89 75 80             mov    %rsi,-0x80(%rbp)
ffffffffc0012d1b:       48 0f b6 75 ff          movzbq -0x1(%rbp),%rsi
ffffffffc0012d20:       40 88 75 ff             mov    %sil,-0x1(%rbp)
ffffffffc0012d24:       48 8b 85 f8 ff ff ff    mov    -0x8(%rbp),%rax
ffffffffc0012d2b:       e8 30 00 00 00          call   0xffffffffc0012d60
ffffffffc0012d30:       c9                      leave
ffffffffc0012d31:       c3                      ret

So even though it would seem more obvious while looking at prologue what
is the intent behind it, this would require us to patch the instructions
that make us of R10/stack, which in the end would be way more invasive.

After all, for x86 JIT code:
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

but it is a must to have a better commit message here.

Thanks!

>  	}
>  	/* Exception callback receives FP as third parameter */
>  	if (is_exception_cb) {
> @@ -373,6 +380,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>  	if (stack_depth)
>  		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
>  	if (tail_call_reachable)
> +		/* Here, rax is tail_call_cnt_ptr. */
>  		EMIT1(0x50);         /* push rax */
>  	*pprog = prog;
>  }
> @@ -528,7 +536,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>  					u32 stack_depth, u8 *ip,
>  					struct jit_context *ctx)
>  {
> -	int tcc_off = -4 - round_up(stack_depth, 8);
> +	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
>  	u8 *prog = *pprog, *start = *pprog;
>  	int offset;
>  
> @@ -553,13 +561,12 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>  	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
>  	 *	goto out;
>  	 */
> -	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
> -	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
> +	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off); /* mov rax, qword ptr [rbp - tcc_ptr_off] */
> +	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);     /* cmp dword ptr [rax], MAX_TAIL_CALL_CNT */
>  
>  	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
>  	EMIT2(X86_JAE, offset);                   /* jae out */
> -	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
> -	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
> +	EMIT3(0x83, 0x00, 0x01);                  /* add dword ptr [rax], 1 */
>  
>  	/* prog = array->ptrs[index]; */
>  	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 + offsetof(...)] */
> @@ -581,6 +588,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>  		pop_callee_regs(&prog, callee_regs_used);
>  	}
>  
> +	/* pop tail_call_cnt_ptr */
>  	EMIT1(0x58);                              /* pop rax */
>  	if (stack_depth)
>  		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
> @@ -609,7 +617,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>  				      bool *callee_regs_used, u32 stack_depth,
>  				      struct jit_context *ctx)
>  {
> -	int tcc_off = -4 - round_up(stack_depth, 8);
> +	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
>  	u8 *prog = *pprog, *start = *pprog;
>  	int offset;
>  
> @@ -617,13 +625,12 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>  	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
>  	 *	goto out;
>  	 */
> -	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - tcc_off] */
> -	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT */
> +	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off);   /* mov rax, qword ptr [rbp - tcc_ptr_off] */
> +	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);         /* cmp dword ptr [rax], MAX_TAIL_CALL_CNT */
>  
>  	offset = ctx->tail_call_direct_label - (prog + 2 - start);
>  	EMIT2(X86_JAE, offset);                       /* jae out */
> -	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
> -	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp - tcc_off], eax */
> +	EMIT3(0x83, 0x00, 0x01);                      /* add dword ptr [rax], 1 */
>  
>  	poke->tailcall_bypass = ip + (prog - start);
>  	poke->adj_off = X86_TAIL_CALL_OFFSET;
> @@ -640,6 +647,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>  		pop_callee_regs(&prog, callee_regs_used);
>  	}
>  
> +	/* pop tail_call_cnt_ptr */
>  	EMIT1(0x58);                                  /* pop rax */
>  	if (stack_depth)
>  		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
> -- 
> 2.41.0
> 
> 

