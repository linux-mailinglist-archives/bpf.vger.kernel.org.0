Return-Path: <bpf+bounces-8668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB4F788E23
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4453281854
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071811804B;
	Fri, 25 Aug 2023 17:58:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E818003
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 17:58:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429AB2128
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692986319; x=1724522319;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qd/jwxlzd2DKF9KNNzX6Lvgjs6mtNXNYSSF2qC1TGbc=;
  b=WEiO9Fr0mI6dvYvoIcEecw6ZdeJMzqiwVInJYk1FTqVk4PT9pqQ02Pwn
   E//CHzbmxJ3XKb4ZfBZRBslMTzdNBZ87oB6DCTX4QyRzPcj5ZtFe07xAI
   LnKvcI0Lpkxj+66w02Ku0r35VrhZYXZdBJNwmUcV0vBi06BFuwzQ4sWa9
   02FzYQ+4Db+tv5FeBiZITznSKmiFWbGX7CoT2z4iXzVrjM8kU75qt6II3
   5Fx9Kp4dhhz7HIIvjWd8Flw2aa9/xT7UCWgXpv2VM284KKZBZq7o+vs7M
   F7aQqBSTRDxngAmBLBBOShwacf39xEsZxfEgZMKoivDrynQE6NuZsgpwm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="438709615"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="438709615"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="687405619"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="687405619"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 25 Aug 2023 10:58:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 10:58:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 10:58:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 10:58:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 10:58:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kswaNXocGG9udtTtKUVC9UFd0Sx/r+nmkRU2wFVQ8qpI6bFopVPj8V2XAyfy9vLKj+zq6WMmDBZFdZohSAKUZv8L5JQ1wUgtAJSURSn+Br4DwKBp7uzwHEIXVERZTJZnzcTXKPqREmmSpM0yDvdM9wBf5w3fd6kGkvVtJXk5GpZR0fwxX/DQ76N62HLbYNxeer1a3Irfpop0Bo9Rq7aaxatJpZZU9+cqGMKug20YQa3stsoN1sDBBqjgJpPMem2T3+/kSqlJJ64QwCGcyL9hLE5ScEkyIa6hshCRgKgftlSBZDyikuNbqZx5L6NhpTeOZbHjhAVBwbb4NqjwxyOTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gd3phIar4khRQb8m27n3LwZg+O0+lFQvMeVxJZwwyFs=;
 b=M2K04B2KHZ1AJR2AX4iXn0KCFMeIB7zKhPSxpXfFb9maOwy3l9q6n8CYlqSuk2RDNQMSiBhZinHdGe6AuQ1XJCtQ62nPxMoSlrmOtnNj1AVZ+oK9i6Hvp07K5mOddWd3lZxWpIkCNsEMLK5W90ILJ8aUIhK7Zr7ZU4QYNlsFLB6NFhQY3Gh7XhukiZYplAjmu+3r3F8tRhFmGWPwyaFZHZZprsXVAK4fi9ZI4wC4OIr8KycQzvbpe0guq/d9hKqMZGP9bEofffiRiRvOl3tXYDmCEb6XgNe0EqVjVLjVJYlRFtx9vitjaN3oQxD7B/7ynoe/ozabGoJoaKAM+qCL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.29; Fri, 25 Aug 2023 17:58:34 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 17:58:34 +0000
Date: Fri, 25 Aug 2023 19:58:22 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<song@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next v3 1/2] bpf, x64: Fix tailcall infinite loop
Message-ID: <ZOjrviql/e/14X4a@boxer>
References: <20230825145216.56660-1-hffilwlqm@gmail.com>
 <20230825145216.56660-2-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230825145216.56660-2-hffilwlqm@gmail.com>
X-ClientProxiedBy: DB8PR09CA0017.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::30) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY5PR11MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 613b626c-e697-4679-0d72-08dba594e645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSEDGQj+SF4am41JV9hQzLhZ0UrDunmuXi/qTRdd3N5Jq2RVefJCMCqJZME2rp64UsFrhKYzBqq2n/U8U2YtVOFssJesjurxV9/I6disPiDH83+ZwfG5YWuR78bL5skbLsuxKwc4uYIq/XT9P4ndv+8wVrqkkrPsC8ZMv3SRI2JCu5HBwvCWrfFDETzVWNk+wFVnrdhpNoTtHpNb707Sn0NbwKL6VJDSOCaROZn4Ym/QWWwl3Xr/Wx0yPp92knk8WU34DWtbhsJLvKBpvIPFP916bU77cuiCpjXyH+jC9Uvbgsb2upPNo40KoYLYxYqCuLAID0rlCGkUH9+xTiS3FFy/+tjp4VBQLEAozcBMK6L0cDNWB8UEJkl6m0fpD3nubPhDhaVMXX/pECoeUnstkmqJFj29difdRL1RWnoMKxe0Ldm/q+aKaieilifpsHglf8HKbB0/P7OiRP/aqeIr7dT086BhOFYk8dlCBs+zKbhAAR2ZjOjlKHo6xudN4yHEknvVa3ul1dlbuomyXnbSDXEpYqzy3LgHUejF+Pw6yw+TP2bxSxbXZaPD9mIs6uOM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(376002)(39860400002)(366004)(1800799009)(451199024)(186009)(44832011)(83380400001)(6512007)(9686003)(26005)(478600001)(5660300002)(2906002)(8676002)(8936002)(4326008)(82960400001)(38100700002)(66556008)(66476007)(66946007)(86362001)(41300700001)(6916009)(33716001)(6506007)(6486002)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?raYDOqmVz1YCFX/QFw3VlSU4dOrKu+E9CCkGn/gFfcHnIjzrJtRUxdldZDR5?=
 =?us-ascii?Q?U4DWM6f7Q10fJQxWCSJ3krUMT6htE7M2Aw/q5cNZIf5H6HsfAt7wPqi2rm1V?=
 =?us-ascii?Q?4N0EK7LN7rAz2+qgSndIAsULAR2A3ir+WPRfSFabrry9rs99IVzVhb4u5iip?=
 =?us-ascii?Q?L4KY4aWrfObI1HozRNtuVRfUjXGp2a9bDSdj6mebrrFz6ysvj7OBE6A93uDD?=
 =?us-ascii?Q?duJYnMj2fQ+xtId+nWgpOarH5+I3cRZwsjLK/GznW1VMdYsjQWe6sHj+p9Rs?=
 =?us-ascii?Q?s6RJqiBb4OXCcYMPcquIsohfzCV62qIMYdmzXIKyuU6+285GysSd7X6PlAXq?=
 =?us-ascii?Q?Vg6xAgwsAEb8ryXb0JYc2D6YcAfpB9zgdmdjL+d6hKfA+bWIXmQiyz4LWj32?=
 =?us-ascii?Q?zhX/lQUKXu7eyyuC8mn1i6MUqr1wuzsNXPdtHWTFuG0+WwEIMBJzJMZpCY98?=
 =?us-ascii?Q?fH6qLJ03BgUpCzj7zyzDUoAmMBx0pBFYY0tvsqYmR602X85wP2vgBZ2Hvyaa?=
 =?us-ascii?Q?PqaJJ9or3kjEht8c4H4v3ttVyuyu4oPiji8tJvhJE2EvRUWNeSNQeju9Ikjd?=
 =?us-ascii?Q?rl5DzuDqKGpTmW8OAqZm62AHBfMCDr1FipXzOEIAtnCy+iKlovlseUMVFo90?=
 =?us-ascii?Q?Nj6zvZala2OusP87GKhVLaOdyrCRJEJIlqr8wI7OBQkfKNDhaY6nCMkeN/c8?=
 =?us-ascii?Q?ZvHKicv7Pw21/YydxoKmL6zgjkCWKjS2NMUc2C3thPQZA0GCzXtzUSTWkiLQ?=
 =?us-ascii?Q?S9ZWdv6zDCgH6rEpbeodiRas4NhuTdbL9vrz4kVCAFQWGjeMMIBFf/PuruyG?=
 =?us-ascii?Q?t7DlYicmewoSkHfv9S0QqYeOeH8+1C/tlS08/MyNme7oV8RZ2AYXYmXUSPH4?=
 =?us-ascii?Q?ZSWWblmZ7qpHt1C+Gepm09kGjqRPfkuam41EH2vSh9GqR8Gl6esCb+44ylOj?=
 =?us-ascii?Q?MfSF5/cDSgNS2P8JLnc2h2OwQhIb96gnHu6rhpKQTaUGAa+RcKDV/RZ3/62u?=
 =?us-ascii?Q?9lUU26yVwor7CUy8kD2udbdMXW7dVBH0txLp7mY57HYsd1ks2rs+XU1yevAF?=
 =?us-ascii?Q?cW53MnoREwSP84VdZSiW0+UirrqWGDp0Ift0nMRf9Kqu96uVCBTqCH1d0Em5?=
 =?us-ascii?Q?bAt93x+L3+GhWE/N4ao6dpdtqbQqjK7aT8e5EDvwidUezlV+vEqPMyTKUBkP?=
 =?us-ascii?Q?fluo8unwZSohnpbDQrxdKY0kS37rYCHuFDqeXo9aIvQtpWVq3h4OU/+/fLvy?=
 =?us-ascii?Q?TZ11ZTmHO37o78ycGOtobmdXwKiBPWeAu6LEP3fxVh7HOkV7jhnXj+9vH+pg?=
 =?us-ascii?Q?MxBa/sp4BAL9oBaIUd/74Jn/iNQl0/3G1Ki+DIXRuprh1AGeE1cG06trKw2E?=
 =?us-ascii?Q?/KBot6dVkqFej1wXTsIFSpDstjZ1zCitNwZnFq9FPjnT47Knou+MF6Vmcyus?=
 =?us-ascii?Q?TTqJJypo7rmm2XCJJaGqogZUCRUuWlF9cD58Vx7H06vzSePR2QgEyyQuXNE+?=
 =?us-ascii?Q?p3Ok39NYPxtpnwoYvlEFDvJEmCaIbwWMLdJl1j77Zhgs9WF2/+JheV1eWT2E?=
 =?us-ascii?Q?Y7CUTsz15URaIqGmdAoOmlxQkZpAbzTD4L860zvfWDR5qITKsb7WW64BQJMT?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 613b626c-e697-4679-0d72-08dba594e645
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 17:58:34.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNYzEG7ooMJs+r0IIzgLiZMTx1F8NRPqy9TFNvugPqeWtmlRyXmXF700SYFwHRwgwQXhTKv+mgSMYJV2E6C4hGqhYfBOOMx+tpFqpyB8EjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 10:52:15PM +0800, Leon Hwang wrote:
> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
> handling in JIT"), the tailcall on x64 works better than before.
> 
> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> 
> From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
> to other BPF programs"), BPF program is able to trace other BPF programs.
> 
> How about combining them all together?
> 
> 1. FENTRY/FEXIT on a BPF subprogram.
> 2. A tailcall runs in the BPF subprogram.
> 3. The tailcall calls itself.

I would be interested in seeing broken asm code TBH :)

> 
> As a result, a tailcall infinite loop comes up. And the loop would halt
> the machine.
> 
> As we know, in tail call context, the tail_call_cnt propagates by stack
> and rax register between BPF subprograms. So do it in trampolines.
> 
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++------
>  include/linux/bpf.h         |  5 +++++
>  kernel/bpf/trampoline.c     |  4 ++--
>  kernel/bpf/verifier.c       | 30 +++++++++++++++++++++++-------
>  4 files changed, 56 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a5930042139d3..2846c21d75bfa 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -303,8 +303,12 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>  	prog += X86_PATCH_SIZE;
>  	if (!ebpf_from_cbpf) {
>  		if (tail_call_reachable && !is_subprog)
> +			/* When it's the entry of the whole tailcall context,
> +			 * zeroing rax means initialising tail_call_cnt.
> +			 */
>  			EMIT2(0x31, 0xC0); /* xor eax, eax */
>  		else
> +			/* Keep the same instruction layout. */

While these comments are helpful I have mixed feelings about them residing
in this patch - rule of thumb to me is to keep the fixes as small as
possible.

>  			EMIT2(0x66, 0x90); /* nop2 */
>  	}
>  	EMIT1(0x55);             /* push rbp */
> @@ -1018,6 +1022,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>  
>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>  
> +/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> +#define RESTORE_TAIL_CALL_CNT(stack)				\
> +	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
> +
>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>  		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
>  {
> @@ -1623,9 +1631,7 @@ st:			if (is_imm8(insn->off))
>  
>  			func = (u8 *) __bpf_call_base + imm32;
>  			if (tail_call_reachable) {
> -				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> -				EMIT3_off32(0x48, 0x8B, 0x85,
> -					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
> +				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
>  				if (!imm32)
>  					return -EINVAL;
>  				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
> @@ -2400,6 +2406,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	 *                     [ ...        ]
>  	 *                     [ stack_arg2 ]
>  	 * RBP - arg_stack_off [ stack_arg1 ]
> +	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
>  	 */
>  
>  	/* room for return value of orig_call or fentry prog */
> @@ -2464,6 +2471,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	else
>  		/* sub rsp, stack_size */
>  		EMIT4(0x48, 0x83, 0xEC, stack_size);
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +		EMIT1(0x50);		/* push rax */
>  	/* mov QWORD PTR [rbp - rbx_off], rbx */
>  	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
>  
> @@ -2516,9 +2525,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  		restore_regs(m, &prog, regs_off);
>  		save_args(m, &prog, arg_stack_off, true);
>  
> +		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +			/* Before calling the original function, restore the
> +			 * tail_call_cnt from stack to rax.
> +			 */
> +			RESTORE_TAIL_CALL_CNT(stack_size);
> +
>  		if (flags & BPF_TRAMP_F_ORIG_STACK) {
> -			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
> -			EMIT2(0xff, 0xd0); /* call *rax */
> +			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
> +			EMIT2(0xff, 0xd3); /* call *rbx */
>  		} else {
>  			/* call original function */
>  			if (emit_rsb_call(&prog, orig_call, prog)) {
> @@ -2569,7 +2584,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  			ret = -EINVAL;
>  			goto cleanup;
>  		}
> -	}
> +	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +		/* Before running the original function, restore the
> +		 * tail_call_cnt from stack to rax.
> +		 */
> +		RESTORE_TAIL_CALL_CNT(stack_size);
> +
>  	/* restore return value of orig_call or fentry prog back into RAX */
>  	if (save_ret)
>  		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cfabbcf47bdb8..c8df257ea435d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1028,6 +1028,11 @@ struct btf_func_model {
>   */
>  #define BPF_TRAMP_F_SHARE_IPMODIFY	BIT(6)
>  
> +/* Indicate that current trampoline is in a tail call context. Then, it has to
> + * cache and restore tail_call_cnt to avoid infinite tail call loop.
> + */
> +#define BPF_TRAMP_F_TAIL_CALL_CTX	BIT(7)
> +
>  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
>   * bytes on x86.
>   */
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 78acf28d48732..16ab5da7161f2 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -415,8 +415,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  		goto out;
>  	}
>  
> -	/* clear all bits except SHARE_IPMODIFY */
> -	tr->flags &= BPF_TRAMP_F_SHARE_IPMODIFY;
> +	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
> +	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
>  
>  	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
>  	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4ccca1f6c9981..6f290bc6f5f19 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19246,6 +19246,21 @@ static int check_non_sleepable_error_inject(u32 btf_id)
>  	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
>  }
>  
> +static inline int find_subprog_index(const struct bpf_prog *prog,

FWIW please no inlines in source files, but I don't currently follow the
need for that routine.

> +				     u32 btf_id)
> +{
> +	struct bpf_prog_aux *aux = prog->aux;
> +	int i, subprog = -1;
> +
> +	for (i = 0; i < aux->func_info_cnt; i++)
> +		if (aux->func_info[i].type_id == btf_id) {
> +			subprog = i;
> +			break;
> +		}
> +
> +	return subprog;
> +}
> +
>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			    const struct bpf_prog *prog,
>  			    const struct bpf_prog *tgt_prog,
> @@ -19254,9 +19269,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  {
>  	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
>  	const char prefix[] = "btf_trace_";
> -	int ret = 0, subprog = -1, i;
>  	const struct btf_type *t;
>  	bool conservative = true;
> +	int ret = 0, subprog;
>  	const char *tname;
>  	struct btf *btf;
>  	long addr = 0;
> @@ -19291,11 +19306,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			return -EINVAL;
>  		}
>  
> -		for (i = 0; i < aux->func_info_cnt; i++)
> -			if (aux->func_info[i].type_id == btf_id) {
> -				subprog = i;
> -				break;
> -			}
> +		subprog = find_subprog_index(tgt_prog, btf_id);
>  		if (subprog == -1) {
>  			bpf_log(log, "Subprog %s doesn't exist\n", tname);
>  			return -EINVAL;
> @@ -19559,7 +19570,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  	struct bpf_attach_target_info tgt_info = {};
>  	u32 btf_id = prog->aux->attach_btf_id;
>  	struct bpf_trampoline *tr;
> -	int ret;
> +	int ret, subprog;
>  	u64 key;
>  
>  	if (prog->type == BPF_PROG_TYPE_SYSCALL) {
> @@ -19629,6 +19640,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  	if (!tr)
>  		return -ENOMEM;
>  
> +	if (tgt_prog && tgt_prog->aux->tail_call_reachable) {
> +		subprog = find_subprog_index(tgt_prog, btf_id);
> +		tr->flags = subprog > 0 ? BPF_TRAMP_F_TAIL_CALL_CTX : 0;
> +	}

I kinda forgot trampoline internals so please bear with me.
Here you are checking actually...what? That current program is a subprog
of tgt prog? My knee jerk reaction would be to propagate the
BPF_TRAMP_F_TAIL_CALL_CTX based on just tail_call_reachable, but I need
some more time to get my head around it again, sorry :<

> +
>  	prog->aux->dst_trampoline = tr;
>  	return 0;
>  }
> -- 
> 2.41.0
> 

