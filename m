Return-Path: <bpf+bounces-9374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553917944C4
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 22:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF8A1C20AAD
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 20:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262BD11CA8;
	Wed,  6 Sep 2023 20:53:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021411726
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 20:53:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1599E9
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694033602; x=1725569602;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jh4OaMVgzaiiuInCUwxMFV//GLkw6Z/dKA9lliwAyBg=;
  b=aNXHytUhvhyTPWHr+/I5axYK7jZYwcwsXm1Oz9J9pgFcvdekLFIDog0c
   WjoRknNr+aqBXjamht87i3oWDxMW7xrgg/kUB+Cou6/TZG+faOzCOcvGr
   YbTXIg+1MqdByBhyuIk1BqIcztIpWBjWkKz3yEw1qgj7F/V5KrgDM3RYj
   FV0BjVkN+k7DsX56DW1RC9Dd8LcAg6m5ARHKBY/EYkK8PXwwo9KCxk1ms
   0NePtQALXfKvz81vSVNV3GwnozaHHPgYFAfTUNzWsx7SwhPm2UvlVv/Oa
   oEb2jZsq3xFlmEHpGa7qnsvjWv42BFLAAIjWnDgHEyYIlhgYCpjdpmNyg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357494075"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="357494075"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="770960645"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="770960645"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 13:51:05 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 13:51:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 6 Sep 2023 13:51:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 13:51:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcLNCopWvAIVyR9jFmO2LjxbYid+QVPNO6wDvjea8hc0qi30PEumNKSzK/13q3JGaF23jqz/0+YhPfzGFFLW0QWa+lXparhO8RBm+34nPNi7LrIT4IKYymu2fzI8lCC1UzREz/U5yXsmizSHqvwrET3S9375sGdREDlbT7iLtTQ7+gxgJ3tRgQzw/S4i4yBbPRosDrutwVEYmrir/IJUnb6Hka1HhaI6PX2KBDhIkjDECtjJ3cc14RcGs+e/PRwvZX/XFjXSSqpfDFpCI3ygb+2vXUGGeJPv77sCzkYLGeK8IyGEzJpsdj5Dpm0hjBZVdVFxiPnPeK1pnMPtICzedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7P4Dzmomvy8d0fsyqjSLE9bbC3/oOaIjJZM3qRKFxE=;
 b=FSUinJ9svb5LgY/2JKBB4d3to57ebqPvlu66FGWp2q45SGWuR9fngZBXjDpkj100G/UrrOfQYVQwsNOZY2VcWBzSeDykn8A1ckhf07HXgVveq5E6ufUT4S5yWDZ1AqB5m4EEI28J0PwdRgHM4FeUaYlW+XGt3G7YeMku9Zj1GdxbZUySNqPIpbOrLTCyec9WYgdLiqiq7XaYtmm8VP3SV+snhEDdL4qEhDegM2jTi+DwgmDiuAyxnTidrDy9n038UZKqHZJVQolA9ZUweoJ8GcJlNnJaxm2ESm41IqEAQl7hVZ47MKBsuYVIvoFlXa3Hm2G2tU0mpPI/jXiX7+ax+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB7323.namprd11.prod.outlook.com (2603:10b6:610:152::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Wed, 6 Sep 2023 20:51:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 20:51:00 +0000
Date: Wed, 6 Sep 2023 22:50:53 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<song@kernel.org>, <iii@linux.ibm.com>, <jakub@cloudflare.com>,
	<bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next v4 2/4] bpf, x64: Fix tailcall infinite loop
Message-ID: <ZPjmLSmR95NzPw2k@boxer>
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
 <20230903151448.61696-3-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230903151448.61696-3-hffilwlqm@gmail.com>
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd92238-de80-41b1-c711-08dbaf1afa01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzhOYkG4f9vCWUkbdnswybm5TmhzDp8hnvRF35azpsaOrpkuVZEOkJMTuJOon/5CNVWcYc8S3vyEGuJXVR/QE1JE+xLUocHy6oLFke1HwwaLzj1ecLw2d5P2oDAT6dDPy2o8Q2MAiCFVtfUPyow4G9BMBQ8KyA14mIrlbwwYmJZAf8z9TJYVNQ/GqbOazECfXJr4GZtFlqIPtYxJhZBIHfV9+3qMliuJq7Tad68l29M3v4fuwSesz6yHLalo+yVaYTYORIlYAcgifC9JN4M15JjETreU7n2qAkkGk5PjkQZmyWFEWKuACY9hXDu0pdTB9k3FuMH/YzAD2vUhfL/2MP9NGKKGgNsysw8HZkYMHvNTWI+9gqhgFDGRx7vyX/gsxceDCxJMJvwp86VmkKow1UY/QQxD+iO25hzEgiEBIXQoYlg/n+hDzmMo7KyXXl3jLH1ROdVOEpJ1RkbPH6yAC6f3JBl/NoflQbWusj02tyue1MxJOv9Vs/q61/1ZXydQmn5CxiKfeitYukKsQkhNUIe72N3Q+S9daw+/pwtBSEw2TfySF/UDVZMIjI5f887y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199024)(1800799009)(186009)(8676002)(8936002)(5660300002)(66556008)(316002)(6916009)(66476007)(2906002)(66946007)(44832011)(4326008)(41300700001)(6506007)(6512007)(6486002)(26005)(9686003)(478600001)(33716001)(6666004)(82960400001)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/LNbhnYJ4kSsO7XdYRCreA9MauzI8lgkitou2KOtDTkGbjUaCYgMdVfXCNef?=
 =?us-ascii?Q?9YabzDqHezLhZIcGNxRsAiQIQIYezuePN0etMLakg4MDp2i6KYTVycL6siIM?=
 =?us-ascii?Q?1QSYqvjXlWPYJN3n99GDryTpB0fYGVn1ckynA/yoasQe7R+8f3SdTthxV2jk?=
 =?us-ascii?Q?KUR+9wTS11bkWRrV/dcaboWOq6DDTKITyum2FfDEL8qz0Xb5IAEXuFuT26TK?=
 =?us-ascii?Q?lxKCQqDfJuP3htXD7MEl7/oil3q0p0vtLzxR+kmr+CjsFL9JpNqvNtZWUpGy?=
 =?us-ascii?Q?6oYXlid8Ej7AZJV6j9aSceFCF9KNTf+u/x+0XtAp3vHor4sqnbeCx1XK5X2F?=
 =?us-ascii?Q?Utw29vUdVNT99Ut8DUbab+tP462xvMbEs6qksaE8JIcH9nzCXUeq3JwmFqd/?=
 =?us-ascii?Q?/Sik9CoybIGrTh2hNr0Fz6B0psXGmb35wgQ7jinZktr75w/Qx58LvqGKhIfg?=
 =?us-ascii?Q?fxSroXyYcvKOdGFDFQcqGSkNn12LFFTXmL+TX0gffYLCaYc/19MqN7US0bRg?=
 =?us-ascii?Q?2rkcMXPD9i6akQF3DD+iYe5iy2kHYgry9lG2KADouvyhWnc9l348xXACuWML?=
 =?us-ascii?Q?VYaU/4535KV09nS+VZAy9zbWYwLVjxKmIMy9moMnWdamgXdReXZiOzHf/nli?=
 =?us-ascii?Q?E2uePzgpULtTrSUkCpKlRDF3fXtZliPp0fLR4AOzu9YktmU6RTMq5WzN4GcP?=
 =?us-ascii?Q?dpn8BQMzyjWKCqnOmOtgOZc7u0M1EDM5HrAvYUV38UerMm1v4oCtouLWwsL3?=
 =?us-ascii?Q?BbNKC9cEwnyc4hpcSoqtGbuivrToUEPVK6qfg5xbAQ++m+3pkaZhbzv2UYwW?=
 =?us-ascii?Q?aXoD1hOlbboP7MZIz3bdTClLH4gbgbS1IIyH2cB3mdYdyLX3ZFaZcg0S3nwh?=
 =?us-ascii?Q?YsGTwUTvaewIANy6t2xC944I+dwGk3GRo8DrD29G62cRwUaK4mTFv+NGZ5G5?=
 =?us-ascii?Q?zkc0yJ+hP9m6ViP0t411IRe3ZAHs7xM/4PdLhkXcRWDnJoTw3z4dZ4bdcjjs?=
 =?us-ascii?Q?QXuE4JkLIt7Ry7BrhDcHw+Q2MTwr1UWERIFK6kBFPRSusE9z3Zg/F0HGRhJa?=
 =?us-ascii?Q?TPMl47w316N8vtNchoG2/wpT2HLJWNbglgBLwpBIDYmvQgZc9C9rmAtxPG8M?=
 =?us-ascii?Q?/CqLoc2hOWcWJvHsQWgOoUPm2nuzfPiSwBfcnd7K6gwOo5t53Laey8VfjUFz?=
 =?us-ascii?Q?dVrjdj47qDkbBeg6eskiTIQVI3UjOcR4aVJbg8SfL9unrG+38EAOSTocMD0A?=
 =?us-ascii?Q?OipHEgH+AMHYtGM9lLgZGXa1OcbES5+AyZmy11+PL74OVp2dBd7YVVLqk+tN?=
 =?us-ascii?Q?gZOddWeLaufTcGtjNgsgUd4fKzFr7/HTe0JLPg/NgkHjM7W+pQqLSrNXahcC?=
 =?us-ascii?Q?a3FjWi1RV5rA2VBPOwKv5UhflWHpBwTfbRB6YUq/b+mrJJ52UkYuo3+hrc4P?=
 =?us-ascii?Q?jPDt0egQzObgofr6Rfpyr0+ZZGXRAHC0HcSi0YYEjhmLClSLGkg/ljG2UfHV?=
 =?us-ascii?Q?plg1nFelZuHGaVLKiEYdHA2ncg74JX25qGwbF6kEU80x8if1/O42eFPo9UTt?=
 =?us-ascii?Q?iAWjFNYvGSLxn8sM/TsYg/WATSzFeZ+pFYIXEHnomgB9+FTZT3Te6H3rlkXU?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd92238-de80-41b1-c711-08dbaf1afa01
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 20:51:00.2620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwWGpfafkuYb0jtpDDPypAAQr0I1gOSxyN9mQc2rTLL+t9WdTFBwGSw6XUtFmjuZMcRywkGqhnOPZseX3k/siDxSK+Uo8lyW1bO5X2bcMQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7323
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 03, 2023 at 11:14:46PM +0800, Leon Hwang wrote:
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
> 3. The tailcall calls the subprogram's caller.
> 
> As a result, a tailcall infinite loop comes up. And the loop would halt
> the machine.
> 
> As we know, in tail call context, the tail_call_cnt propagates by stack
> and rax register between BPF subprograms. So do in trampolines.
> 
> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  arch/x86/net/bpf_jit_comp.c | 28 ++++++++++++++++++++++------
>  include/linux/bpf.h         |  5 +++++
>  kernel/bpf/trampoline.c     |  4 ++--
>  kernel/bpf/verifier.c       |  3 +++
>  4 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index bcca1c9b9a027..2846c21d75bfa 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1022,6 +1022,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
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
> @@ -1627,9 +1631,7 @@ st:			if (is_imm8(insn->off))
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
> @@ -2404,6 +2406,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	 *                     [ ...        ]
>  	 *                     [ stack_arg2 ]
>  	 * RBP - arg_stack_off [ stack_arg1 ]
> +	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
>  	 */
>  
>  	/* room for return value of orig_call or fentry prog */
> @@ -2468,6 +2471,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	else
>  		/* sub rsp, stack_size */
>  		EMIT4(0x48, 0x83, 0xEC, stack_size);
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +		EMIT1(0x50);		/* push rax */
>  	/* mov QWORD PTR [rbp - rbx_off], rbx */
>  	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
>  
> @@ -2520,9 +2525,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
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
> @@ -2573,7 +2584,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
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
> index 4ccca1f6c9981..765da3007106a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19629,6 +19629,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  	if (!tr)
>  		return -ENOMEM;
>  
> +	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
> +		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
> +
>  	prog->aux->dst_trampoline = tr;
>  	return 0;
>  }
> -- 
> 2.41.0
> 

