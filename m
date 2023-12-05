Return-Path: <bpf+bounces-16818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7379E8062A8
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75821B211DA
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261F405E1;
	Tue,  5 Dec 2023 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muBw1Bsd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EA9B9
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 15:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701817441; x=1733353441;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ujTp2Xr9S0BVIRT1ia443Qao+WUawLBRxdXOSWuLsIk=;
  b=muBw1BsdDsyOcfeUHOa1EsaVy5z3ixzB8U49vgfr3VoVkX/Wr3lBo2/2
   qdh+Huu+kGch5Stlsoyofe7P+6sRIVAicyEJ+yBbqcDEWp7IOJ4YHramo
   3s7SJ95HcjoHvtDYahSCeAVjnHo9QFX3mg5g3KfU69/5M/BcDpvrCk/Uc
   lS7v6fVe87m24Bfs8i8teD8mtvTpiOp72fhjZboaaHGaMEYVmunuewYLf
   IlRH7gac0vtL/R1JXR8cTBdKfDsFvBLpApwYpZWhTAzE54OOXl52pkpVS
   gQJNLPIiou+x/0hQrtLz5ZE1F0TiisUdTkBuVgfcOqMO1wAFHoP1+VPdx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="384379680"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="384379680"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 15:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="889102989"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="889102989"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 15:03:32 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:03:32 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:03:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 15:03:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 15:03:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtmswZFtodRTm+iLxfoFBzU3hmVGtCaNYSn4kOon3JPyMf+lewtBof1H/mT8kgK7DSno43HEMZXAAvCDuPkIAGsFNUqpBv/hgA5mdGwWDRjxaqMZSrCcBI/7rkxo29/QPV3arWVh03rfl2p/lcl8CGsjcIrd/eME9ECWXpsRgVo3BtXYOeeHq1TarFP8lG5tjS45qsVn0tVFTkIdV/8Dm6//zpMlRsh+LBv4vwedVRIlqwhebjWzGUIuwJnX3YvT4NiBo7KMf0HZZLNIlNb8LuJQje8a7nJaF9PdVCv37FAKzvZkcwLMK25ErBnCB5lOhgprgQLWIy0eB3F8n97PSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg2kUqu6f+P0Xml+IgvcKQ+JlGxWJuU9e1CF9DXJbH0=;
 b=Vlg71KV0umN82xFoCOjyzm1WSXISON/8el+//Q7X/oCSnKRMAsj65kd2td2t9TAkdO4YSVnYY2cvtlXhiIX3z0ynhdszP/amI4oEh7q0F4ncPzGGlTg5GKN7iYfEmldMuogIwSopjHRm5P4Yrt2T4KI8FgF4XqNoJfy+LfmUP3g8TxZ94d4AwomjqUH0ZAPr0hodaDVyETN+rQMepQGyBa5vhb4lbNg0WwwnuY/NFpI4UHP1faQJvpgJwZwzf5zsAS2AkYxBaFMvk+958jN/eGDzTJzBFDuc7Idgj9LB1Ll4fL9P7FmkzKgODpnV4TOBXnFK5u2DuJlV3KjUV42/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Tue, 5 Dec 2023 23:03:30 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 23:03:30 +0000
Date: Wed, 6 Dec 2023 00:03:18 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <jakub@cloudflare.com>, <iii@linux.ibm.com>,
	<hengqi.chen@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/4] bpf, x64: Fix tailcall hierarchy
Message-ID: <ZW+sNudwg5Bc0Gbl@boxer>
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
 <20231011152725.95895-3-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231011152725.95895-3-hffilwlqm@gmail.com>
X-ClientProxiedBy: WA0P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::21) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7bac28-80ec-4cc7-cf7b-08dbf5e66543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELqK0WGJxvzvyjr5vTgHW55yysxhEqei2COtdWIclcR9XgqqXYuaJe7iDbYop+LA0cdijJTRjECrhmHLsWUg8dmp9801/BjUiQ/9+hrgWWnRalLRqE615pJArd4LqV1Su4A8TyWDOZ14VRPMzBti8X1y/c/mBHxCNhmeoM6/QTU7Be8nheAxhKvng53/R10xpatEdHj/AvCUK0N9M9hAG8aTzCddpKfuY6pFmoBOhZzs/dlJE6c4aHgTZVf8o1zudyxPozYJ3lfzB4CLIrmbFxcJZChXbw7Cotsuo+2Gvqnwnlkx7vZ2B3m2o/GZ249nlOyb8s/pE8WHhsVP3KGT/Yw97gWWKqdwhhhvnG2EXJZW1FlHCpHvabn24HD9atfdr3b9Ues6SFsA1OfiBCyJnu5KZKTKBIi1YzEMmtXn0Qyhjw72/9lTHyi9qPghv8Gw+5qUM0yS0Y5CQHF5wFwVKfZxl9OYBtUSY0o6pP2y6ol6mFk9kZDJqvzeGm/RENSV97lE8Ahqj9X/B+FycauFNiNcVYritOBQo/4VXrQwSoczbiS/F2xhkAmP2WUOYUZ8FORdd0td9bUzEg9kNb2NBH9T+s5Xqp/UbOy6I3hKhRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6512007)(9686003)(6506007)(6666004)(6486002)(478600001)(66946007)(66556008)(66476007)(316002)(26005)(83380400001)(4326008)(8676002)(8936002)(6916009)(82960400001)(44832011)(5660300002)(2906002)(41300700001)(86362001)(33716001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNynSgF1+8Ftme470D67wV+35W5lWh2f+iXu/FR+BZ87mAh5NrwTdU9ekRfq?=
 =?us-ascii?Q?HIjjSvrrf7vIp3OaNYhnGNggMo8MLEDA7hotbXIhE5L1I+OcEX698SJ3+C3j?=
 =?us-ascii?Q?r9p5vWpy0dFTDMQeGPy4sn7yWSyGKRdln6jBnfnRs5FNFMHoCnxCIc1KnbU/?=
 =?us-ascii?Q?3rfx+qQZV4s8KqMlhFxD/RvjDXTFfGSJFV1XWZdZVFKoEg0BO/uMrCfOK30O?=
 =?us-ascii?Q?VXyzT2LPBeyKWzms+9Ls3Ly096I3s5jNrSqWx7E0mBIP5YqbOpNB+a8mNRuD?=
 =?us-ascii?Q?RNtBjmIY6pZl5N1aRP8KqS+FrBuz+fNCzYVM8FBKyYYXWQQOcqdIGcn4a1xY?=
 =?us-ascii?Q?8Xe8jB5Tndklzhc4Ebsw25kHMjU9hWa2kpXxWv11IeCGIbxl7fTAQr3cOO6j?=
 =?us-ascii?Q?oobrUVZeJhiqoczpSIUkjpxLU0d0HYRGBRIB87Y/Qp6ZmJAguri530Ro3vES?=
 =?us-ascii?Q?6uFkjljrBOVH9OHO5bAFk00gMp9UzyF3/VEZVO459O7uCcDgKOcp5DXjNVWZ?=
 =?us-ascii?Q?BMJsC/wH6oPcIMcNYrtfnyCUk1Xa+Fb9ONV7CKYB8OzB3dp7yTo3At9RGobU?=
 =?us-ascii?Q?qPtjkTl0NBpVMsl9g0WqH/vhg5LPiEtkIhf0CzirPIbqJ049CxinuOc72x//?=
 =?us-ascii?Q?Duts/ap8bQTLOzh4qI5XOx899KmjnNwSMa9/rGuqc5WW9ByFZPVBORbGwlaC?=
 =?us-ascii?Q?XVTJwpWH8HTc4qiPW31in47wLnN+7iy1K2ksWxHjs6zpJ5a35rOclhj0KPuc?=
 =?us-ascii?Q?M1lAQyloeNDjEtgMTG3CxmXWocLSSCnvj7JaCmIy1dButxzl83CalGmPn3V2?=
 =?us-ascii?Q?0QbTWcC8qYH6yrx6kHfE8HZ5YvQcpbufq1rUBcC2J/LSwCKy61Q4Lp+b0IM4?=
 =?us-ascii?Q?KlTPc/FVOCxHSTV/3yRb4e7AyCblQNDr/r8I+PmlfHCl+MDNnVfSFJtYqr4J?=
 =?us-ascii?Q?OmjuviRbIJjOTiOyZ2txwnDb2XAR/hufQ61l8gIEX7Q4e3oOP+ANS6/8wNBu?=
 =?us-ascii?Q?0vkJTiBhnIEMyfW8hx9v2Ky7wUzy5Omyq/z97NKIH/ZFRlGPjMmXOcCCKc5o?=
 =?us-ascii?Q?4QC6e+tdzAmJcxtsO4yYwGayRklwWCpY92vnF1dWEMgAm/oJc5ltJ6noAfPL?=
 =?us-ascii?Q?AvFsEmZ9N0VefyaQH7krkfIUwK1lCDZvb/00RhefmRpyDVqwYzofGtU7YikA?=
 =?us-ascii?Q?FOxKeTeokw2GeqrNQtyPsx0NdMEtASk2r3u3yvQ2uLbFjY7zpJ9WH5wL7540?=
 =?us-ascii?Q?XJUXyQMyzdya2LYvMLeqa9Ix67b+djnUtlzoiSozvoLNkg3LT61HuXwQjjzr?=
 =?us-ascii?Q?4TuTxJ03fQNNvDOSpBaTt0GCBgUlp6BK7n/uWwjfrlreTH6GVkbdkE9AJoTc?=
 =?us-ascii?Q?TRJbGtN47h8u46JDnYeWQpBqg7tHLD284MRoUJVY4ZXPLlUm15Qb/m7ishyq?=
 =?us-ascii?Q?afLUfazrlg6dTmM+4aYkWc1/JN4+3cvNi5eoTXJDWrccmKDDuKgfLrq4pLjg?=
 =?us-ascii?Q?AaCNGPYQyWJ+mQvEgdQQD2SOlB/lu0USIe7AyB4Lr6lAJWbXK60KeesTfJc0?=
 =?us-ascii?Q?CyAmWn+LIQyFpsNP9/B1j8M6OqGy0PDflPzl4pqGYTBPGHMiihx8zswuTF2N?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7bac28-80ec-4cc7-cf7b-08dbf5e66543
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 23:03:29.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr+yO4YR/RFSa1VkFJdSI3ACDpFZ7AgeDTdMRRc9M7zAxMkF8aFDE2kWpI7j/vhFqeCjKG/2V1FDf1GLUTvFWcK84w4RE0KrRF0nNlL02mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7381
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

Sorry but I keep on reading this explanation and I'm lost what is being
fixed here.

You want to limit the total amount of tail calls that entry prog can do to
MAX_TAIL_CALL_CNT. Although I was working on that, my knowledge here is
rusty, therefore my view might be distorted :) to me MAX_TAIL_CALL_CNT is
to protect us from overflowing kernel stack and endless loops. As long a
single call chain doesn't go over 8kB program is fine. Verifier has a
limit of 256 subprogs from what I see.

Can you elaborate a bit more about the kernel crash you mention in the
last paragraph?

I also realized that verifier assumes MAX_TAIL_CALL_CNT as 32 which has
changed in the meantime to 33 and we should adjust the max allowed stack
depth of subprogs? I believe this was brought up at LPC?

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

