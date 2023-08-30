Return-Path: <bpf+bounces-9009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCB578E2DA
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 00:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794E41C2042C
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 22:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F738BF9;
	Wed, 30 Aug 2023 22:52:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA20F8826
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 22:52:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24063E40
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693435897; x=1724971897;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=itPZRPWcQuOYsuf2HFpoBzaybKbcYg1wLDZWM7UcRZc=;
  b=hRpbQYRzqOnk65+i6bh7jcYfMpLJQGOXNj+zTl6cM5sK0wiZujetv36a
   91I6pD5wHbedDgcmyiv6ngn4f3R09u0u4DnQKimRMfKB9F5twMXoRAD02
   c0aWlq7343EYZDSnhqn+kOZ9smkzTochxc8/1GDukD2uyg/AdsV2Z3FPa
   o5CTE3DZ26TsXm4BC1gYbG7CIMQDUkqTiyu9RrpZNN288ZuJkX/ZrAzuQ
   gU+2VgC7A6nLm6YVyfZA6YHpCjB37zgDzsBw5MT0iiSDSnyNiMIjC+x1z
   V3Py5HAThb2hsWS8evpIlCPQpQHwdO0hdyvyeUqzApuwCQJCGInefHkyI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="373166910"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="373166910"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="732819007"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="732819007"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 30 Aug 2023 15:50:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 15:50:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 15:50:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 15:50:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/yGeeIFcpEyH9IT91PRt1Uij7lVbad/X53z+Z/B+wrzXnSwCOxJqM0aXFMflo8A/qou77+bSBT+gUuC/ijCCqsAGMFF5YygVAL3ByPglK0iv3JiiCm1ipkFgEwpK4n04o9kK0sD+//LFbztNVnocaCsfkcYrFuXbArzKKMMSbfjbofgGFshaHXY1ItPg/KNiUjFJxg6QMKNqvxbL73mxFzF65jvVncu1/FbLkaW6RmPpCExYsUhF3y0DAQBj/vsJWQMTZ2MXxBAQK36aWLSns36VP1I2jKsxHgCJl7BjQIAlxVKTYRJwuDQDakvDJQx5Wl6MbTOs0xrGfnXKai5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SjoMXERWvHb2tRvHsYS1M1ygkEcUu4vGyWIN4M4sxw=;
 b=ZeJZHFqi8Gjeb4paHsLUbUCSbNtKMItIsQRE00nWhPEFR4PKowXxI4qmRbEZRj7vAjiWIJkQ2IPUqqFBuyVYgyF+t0GV6crp144y8GHP19RIjkSbef3YkpE6Tv0Nb6FZHTqWRYxFvhiaGLVeG/cMmnTqQ3l4nSFDS0jnPeXUjVgmdGYpSpwCO4Spc18DYcA/RCL+eXpIR1ZJl2Bffg+cgdUGyo0j0pIpGQV2wG62Rv92wmf7lJtixNXL37zTj41zj3WNEKwueGyjMq82QmazGny+rsZejoigv6raGs89pMIXdZVpbKEqrEj1kMhMBznmRvyFMKmGhJAJQ0vNj1Xvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV3PR11MB8459.namprd11.prod.outlook.com (2603:10b6:408:1b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 22:50:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 22:49:59 +0000
Date: Thu, 31 Aug 2023 00:49:48 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<song@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next v3 1/2] bpf, x64: Fix tailcall infinite loop
Message-ID: <ZO/HjKo+x6SU4vXa@boxer>
References: <20230825145216.56660-1-hffilwlqm@gmail.com>
 <20230825145216.56660-2-hffilwlqm@gmail.com>
 <ZOjrviql/e/14X4a@boxer>
 <238be72c-2a19-f675-83cb-18051937d8fd@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <238be72c-2a19-f675-83cb-18051937d8fd@gmail.com>
X-ClientProxiedBy: BE1P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV3PR11MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 814d2125-15f4-4220-efb1-08dba9ab7086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4XBH8GBQzbXd09jZZvmUiwQmbGQUG0lVvd5/jLW43FwfTibqjB+0gojWuDCFo249nEo4mvr68JzzuXrBpe/216L/4wIyq6o3/uK7aE6TkgA30RDrUjM2k+7oawpsaWM90dBHisUPzT0mDNXeB7oK+2AleEZsQsu8JuiHD8Yzmi3dp4+f0XAuviuGtaG2DnbAgJUvIL5El/ZplB83DhGf0M77lke2OVZG3kePphzkQds2ieFCkQPEry/4e5QyyTsxhUkaoRsqEau6Qa92J8N1zYciAxGuppgOse4OT8FcQdJjZ97apy0bABT8hceTI5korgsIdnNZpeC6MWfJDImGNoF9ZKUtrYiEMBNF6InoAm8oDSVMC16bmplXg2mTgQIdRJ7RWl2h8mILRHFx8D4TqYk6395Ucn7sIr6YLzLvQ4+S4DKR2ceLAtTtBMoNxWbm/jGWkiVZnlU/TudYFr9TayL7/GJ/RwmYx8KUwq5KsODyINNQ2mb30rX0atPI/A2lCs/NUDtt85785agQ+PhF6Cf3XJ86xueZBkqQIBHXKHU4hHzzX7C+GPoHEskUHgz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199024)(1800799009)(186009)(6512007)(9686003)(316002)(38100700002)(41300700001)(82960400001)(5660300002)(4326008)(6916009)(83380400001)(33716001)(30864003)(26005)(44832011)(8676002)(86362001)(2906002)(8936002)(6666004)(66556008)(6506007)(6486002)(66476007)(478600001)(53546011)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lIMWZRr8U5FKkiKpD/Eu+oZdNKRCUl6btFXhfb7V383zRgF1q16Wxd0hdFD3?=
 =?us-ascii?Q?sXMMtOc9EOZGP6cNiYKh9F37/5e/Xhu2bHy4xPINptqrMH0hovbU7G8nuaR2?=
 =?us-ascii?Q?5H3QSrd83FJ0V+8u5FXrEBZ623H5CtKGik9w+cGL6hqAPk1wWNF87QimOBnr?=
 =?us-ascii?Q?cjrfbiVFSgRtD0kq6LU/zQdpk2AdSHscVJxcuV8y6IfqWFdRZmj0bAgDlEi1?=
 =?us-ascii?Q?sLoS2YtYc5Qbrw56R6AlApnb2u4QDjXr5IuVewt+K5y9XS5iVxifISpeV1Am?=
 =?us-ascii?Q?lNtmwhDo5ampZIirzD65IbUeqxt4v379TaBFBc0SP6vVLncNYSEN9H9aJZ9o?=
 =?us-ascii?Q?o+QoaSk89dO7GO0Y4YfUuJHvP7eYdNdK9Er8DJ4VQWCJdRXUZA5GlMymNU06?=
 =?us-ascii?Q?TTkdaFTVc3dFPz4OYs0lubal/GAz6pqf1Iy3aJGg+rDThBXi1NYAXUU1Gp2d?=
 =?us-ascii?Q?ik9tm3yfY15P1iw/MczzYB4so9vNUDf6pK8kgMQyDsgXu+SW1MpFThJS/gYE?=
 =?us-ascii?Q?IR7MmzmXvPV6Q6Dpa2V+NA4oopx5QLnz07jl7u31tCQeN9VVTEbQ43XwK1th?=
 =?us-ascii?Q?O1Itm0FQM35wFLfDe5rh0HPYjN5bHgovdHtwEty1pAb7SuAPZzSg+V8gdPfX?=
 =?us-ascii?Q?OY70fI7E+8pEL5jlSwNnyels9f3EpwdFrQX1A4A4Wu0sFYUyPU0vTSb+fqTQ?=
 =?us-ascii?Q?q677WasOBl+6ZQBcxGYN9m9ltVVUoU8/kvG4e9wQ0MNZuAbVBat+no9/wDQD?=
 =?us-ascii?Q?jbmoGikqTM0ZgZyHZ1Cy8B08D1WE/Gs9V3zGfKa1kBtcDxk1cO4d0yHzu9N2?=
 =?us-ascii?Q?1nSx4TvjEoOa5v/MlJ2gJczvTHXSf2sPe54mU3PcbM8yF5sbcBfeiwnUbBDE?=
 =?us-ascii?Q?Cl4kGtY+GT28Sahknt7hgQSOWbrlOlbVgz1alQnhl+8TNqBR8DtPAzG/li4E?=
 =?us-ascii?Q?dqaxidFKU2kwXHRGxLf4P27go1fZyUwbr23ckNktVxl5YMKNwzihOd3TJ/y7?=
 =?us-ascii?Q?prNcmcWCHnw0iQ8TvezS++FRBugd8doecgUbkXNP5fitmAI/bq1q4/eFIOto?=
 =?us-ascii?Q?0EEBHbouqN0c4oDygdryu/hRnkZDTKzqYmbpmdyrnDO7cyWZXAFOlmK9mqAl?=
 =?us-ascii?Q?XEr//HmM9fFbuW7qKuUNb5macMPdl9ISV34/aaAcI4ArNRn9kbiulU2jP2XO?=
 =?us-ascii?Q?yjN5GEw2xoBXSl40lrFRlcmDm7R+IMNiSuPleIWxNXHCitTkEQkw0R0kcutw?=
 =?us-ascii?Q?V+lDJ9lAumrjAO6zyj47bkZgSLN+nKXjtdkK3F9shB+q1BRP0pyCUSvlmj7i?=
 =?us-ascii?Q?COVJpDEfIFt7+nzEhkW8jqhEiMKTM6CEb1uI1T9/DVRRmurGu2JCx2cC70xs?=
 =?us-ascii?Q?F+S/kn8yZEXMjZPBsLMOl0eqPoSOd7A59DvrPHa5y9u/zk91+EuSbnuonZjA?=
 =?us-ascii?Q?UNQiwyZaRJaVNAQffkx7XfWBfj5X2b6VDwkIGW37giGsLA9kczEjI0WpezIm?=
 =?us-ascii?Q?c3KWWi1zhjtSHMNAruJZchVWUIQBeQLL4oJ/3zWknMiV6sZc8eF3MZ8xY76G?=
 =?us-ascii?Q?4exfJA+IkgeB/08/5tyDt/fiE7bg2NhAWCKwpvwybH85p2hfiY6xNRGNhP21?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 814d2125-15f4-4220-efb1-08dba9ab7086
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 22:49:59.8076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4+x2glnUGwOeePbCgvvN0k0L2iAd1SXJJgi3tuuTJ+cmNuUt3hv/FXE/XmuzgjeYCbANLcfxWwVp6Hdzv7oap9rkf+9auH1JgHirgnL30E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8459
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 26, 2023 at 12:03:12PM +0800, Leon Hwang wrote:
> 
> 
> On 2023/8/26 01:58, Maciej Fijalkowski wrote:
> > On Fri, Aug 25, 2023 at 10:52:15PM +0800, Leon Hwang wrote:
> >> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
> >> handling in JIT"), the tailcall on x64 works better than before.
> >>
> >> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
> >> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> >>
> >> From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
> >> to other BPF programs"), BPF program is able to trace other BPF programs.
> >>
> >> How about combining them all together?
> >>
> >> 1. FENTRY/FEXIT on a BPF subprogram.
> >> 2. A tailcall runs in the BPF subprogram.
> >> 3. The tailcall calls itself.
> > 
> > I would be interested in seeing broken asm code TBH :)
> > 
> >>
> >> As a result, a tailcall infinite loop comes up. And the loop would halt
> >> the machine.
> >>
> >> As we know, in tail call context, the tail_call_cnt propagates by stack
> >> and rax register between BPF subprograms. So do it in trampolines.
> >>
> >> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> >> ---
> >>  arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++------
> >>  include/linux/bpf.h         |  5 +++++
> >>  kernel/bpf/trampoline.c     |  4 ++--
> >>  kernel/bpf/verifier.c       | 30 +++++++++++++++++++++++-------
> >>  4 files changed, 56 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index a5930042139d3..2846c21d75bfa 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -303,8 +303,12 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
> >>  	prog += X86_PATCH_SIZE;
> >>  	if (!ebpf_from_cbpf) {
> >>  		if (tail_call_reachable && !is_subprog)
> >> +			/* When it's the entry of the whole tailcall context,
> >> +			 * zeroing rax means initialising tail_call_cnt.
> >> +			 */
> >>  			EMIT2(0x31, 0xC0); /* xor eax, eax */
> >>  		else
> >> +			/* Keep the same instruction layout. */
> > 
> > While these comments are helpful I have mixed feelings about them residing
> > in this patch - rule of thumb to me is to keep the fixes as small as
> > possible.
> 
> Got it. I'll separate them into another patch.
> 
> Thanks for your rule of thumb.
> 
> > 
> >>  			EMIT2(0x66, 0x90); /* nop2 */
> >>  	}
> >>  	EMIT1(0x55);             /* push rbp */
> >> @@ -1018,6 +1022,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
> >>  
> >>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
> >>  
> >> +/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> >> +#define RESTORE_TAIL_CALL_CNT(stack)				\
> >> +	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
> >> +
> >>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
> >>  		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
> >>  {
> >> @@ -1623,9 +1631,7 @@ st:			if (is_imm8(insn->off))
> >>  
> >>  			func = (u8 *) __bpf_call_base + imm32;
> >>  			if (tail_call_reachable) {
> >> -				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> >> -				EMIT3_off32(0x48, 0x8B, 0x85,
> >> -					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
> >> +				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
> >>  				if (!imm32)
> >>  					return -EINVAL;
> >>  				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
> >> @@ -2400,6 +2406,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> >>  	 *                     [ ...        ]
> >>  	 *                     [ stack_arg2 ]
> >>  	 * RBP - arg_stack_off [ stack_arg1 ]
> >> +	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
> >>  	 */
> >>  
> >>  	/* room for return value of orig_call or fentry prog */
> >> @@ -2464,6 +2471,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> >>  	else
> >>  		/* sub rsp, stack_size */
> >>  		EMIT4(0x48, 0x83, 0xEC, stack_size);
> >> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> >> +		EMIT1(0x50);		/* push rax */
> >>  	/* mov QWORD PTR [rbp - rbx_off], rbx */
> >>  	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
> >>  
> >> @@ -2516,9 +2525,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> >>  		restore_regs(m, &prog, regs_off);
> >>  		save_args(m, &prog, arg_stack_off, true);
> >>  
> >> +		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> >> +			/* Before calling the original function, restore the
> >> +			 * tail_call_cnt from stack to rax.
> >> +			 */
> >> +			RESTORE_TAIL_CALL_CNT(stack_size);
> >> +
> >>  		if (flags & BPF_TRAMP_F_ORIG_STACK) {
> >> -			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
> >> -			EMIT2(0xff, 0xd0); /* call *rax */
> >> +			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
> >> +			EMIT2(0xff, 0xd3); /* call *rbx */
> >>  		} else {
> >>  			/* call original function */
> >>  			if (emit_rsb_call(&prog, orig_call, prog)) {
> >> @@ -2569,7 +2584,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> >>  			ret = -EINVAL;
> >>  			goto cleanup;
> >>  		}
> >> -	}
> >> +	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> >> +		/* Before running the original function, restore the
> >> +		 * tail_call_cnt from stack to rax.
> >> +		 */
> >> +		RESTORE_TAIL_CALL_CNT(stack_size);
> >> +
> >>  	/* restore return value of orig_call or fentry prog back into RAX */
> >>  	if (save_ret)
> >>  		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index cfabbcf47bdb8..c8df257ea435d 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -1028,6 +1028,11 @@ struct btf_func_model {
> >>   */
> >>  #define BPF_TRAMP_F_SHARE_IPMODIFY	BIT(6)
> >>  
> >> +/* Indicate that current trampoline is in a tail call context. Then, it has to
> >> + * cache and restore tail_call_cnt to avoid infinite tail call loop.
> >> + */
> >> +#define BPF_TRAMP_F_TAIL_CALL_CTX	BIT(7)
> >> +
> >>  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
> >>   * bytes on x86.
> >>   */
> >> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> >> index 78acf28d48732..16ab5da7161f2 100644
> >> --- a/kernel/bpf/trampoline.c
> >> +++ b/kernel/bpf/trampoline.c
> >> @@ -415,8 +415,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
> >>  		goto out;
> >>  	}
> >>  
> >> -	/* clear all bits except SHARE_IPMODIFY */
> >> -	tr->flags &= BPF_TRAMP_F_SHARE_IPMODIFY;
> >> +	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
> >> +	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
> >>  
> >>  	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
> >>  	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 4ccca1f6c9981..6f290bc6f5f19 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -19246,6 +19246,21 @@ static int check_non_sleepable_error_inject(u32 btf_id)
> >>  	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
> >>  }
> >>  
> >> +static inline int find_subprog_index(const struct bpf_prog *prog,
> > 
> > FWIW please no inlines in source files, but I don't currently follow the
> > need for that routine.
> 
> Got it. It's unnecessary to inline it.
> 
> > 
> >> +				     u32 btf_id)
> >> +{
> >> +	struct bpf_prog_aux *aux = prog->aux;
> >> +	int i, subprog = -1;
> >> +
> >> +	for (i = 0; i < aux->func_info_cnt; i++)
> >> +		if (aux->func_info[i].type_id == btf_id) {
> >> +			subprog = i;
> >> +			break;
> >> +		}
> >> +
> >> +	return subprog;
> >> +}
> >> +
> >>  int bpf_check_attach_target(struct bpf_verifier_log *log,
> >>  			    const struct bpf_prog *prog,
> >>  			    const struct bpf_prog *tgt_prog,
> >> @@ -19254,9 +19269,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >>  {
> >>  	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
> >>  	const char prefix[] = "btf_trace_";
> >> -	int ret = 0, subprog = -1, i;
> >>  	const struct btf_type *t;
> >>  	bool conservative = true;
> >> +	int ret = 0, subprog;
> >>  	const char *tname;
> >>  	struct btf *btf;
> >>  	long addr = 0;
> >> @@ -19291,11 +19306,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >>  			return -EINVAL;
> >>  		}
> >>  
> >> -		for (i = 0; i < aux->func_info_cnt; i++)
> >> -			if (aux->func_info[i].type_id == btf_id) {
> >> -				subprog = i;
> >> -				break;
> >> -			}
> >> +		subprog = find_subprog_index(tgt_prog, btf_id);
> >>  		if (subprog == -1) {
> >>  			bpf_log(log, "Subprog %s doesn't exist\n", tname);
> >>  			return -EINVAL;
> >> @@ -19559,7 +19570,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
> >>  	struct bpf_attach_target_info tgt_info = {};
> >>  	u32 btf_id = prog->aux->attach_btf_id;
> >>  	struct bpf_trampoline *tr;
> >> -	int ret;
> >> +	int ret, subprog;
> >>  	u64 key;
> >>  
> >>  	if (prog->type == BPF_PROG_TYPE_SYSCALL) {
> >> @@ -19629,6 +19640,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
> >>  	if (!tr)
> >>  		return -ENOMEM;
> >>  
> >> +	if (tgt_prog && tgt_prog->aux->tail_call_reachable) {
> >> +		subprog = find_subprog_index(tgt_prog, btf_id);
> >> +		tr->flags = subprog > 0 ? BPF_TRAMP_F_TAIL_CALL_CTX : 0;
> >> +	}
> > 
> > I kinda forgot trampoline internals so please bear with me.
> > Here you are checking actually...what? That current program is a subprog
> > of tgt prog? My knee jerk reaction would be to propagate the
> > BPF_TRAMP_F_TAIL_CALL_CTX based on just tail_call_reachable, but I need
> > some more time to get my head around it again, sorry :<
> 
> Yeah, that current program must be a subprog of tgt prog.
> 
> For example:
> 
> tailcall_subprog() {
>   bpf_tail_call_static(&jmp_table, 0);
> }
> 
> tailcall_prog() {
>   tailcall_subprog();
> }
> 
> prog() {
>   bpf_tail_call_static(&jmp_table, 0);
> }
> 
> jmp_table populates with tailcall_prog().
> 
> When do fentry on prog(), there's no tail_call_cnt for fentry to
> propagate. As we can see in emit_prologue(), fentry runs before
> initialising tail_call_cnt.
> 
> When do fentry on tailcall_prog()? NO, it's impossible to do fentry on
> tailcall_prog(). Because the tailcall 'jmp' skips the fentry on
> tailcall_prog().
> 
> And, when do fentry on tailcall_subprog(), fentry has to propagate
> tail_call_cnt properly.
> 
> In conclusion, that current program must be a subprog of tgt prog.

Verifier propagates the info about tail call usage through whole call
chain on a given prog so this doesn't really matter to me where do we
attach fentry progs. All I'm saying is:

	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;

should be just fine. I might be missing something but with above your
selftest does not hang my system.

> 
> Thanks,
> Leon
> 

