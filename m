Return-Path: <bpf+bounces-17424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DB980D4E6
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 19:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599422819E9
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 18:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF384F20F;
	Mon, 11 Dec 2023 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AM2O6qeH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E54393
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 10:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702317746; x=1733853746;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S4vGXp+GSodHSUCZIG0Ay10tmyA+fm7L8npdwLmwXgY=;
  b=AM2O6qeHwvvIa4mhA7aBVQjj6GkbZTgPZRLbvjhuoDTcnalfn+PjNmcY
   AyMWzPgiitZxmB7U6Rv15pafeYOmj5PEuTK1tPdjzBVJd+hlM6R/dy6/1
   bQD6fwWEeFsfJ97XNKuEu5PDtmgWchZJG+Hx9ne8ThgASQh6XVaAhM83c
   lIBxi1e1YLksPtgNACi/vENV3a/cIlojowfdwC33J9Zno5pk8B1wqJx2C
   hcyjYrWUUcPR++l2OjCwCZEP6r4yYcODXtMdSuGWQbB73QPyk4yfJR0mj
   J4eK8JSvpjR4GRZ9e9ZDWA3CgwwYuyk87bY8IOmFBGGI6q4NULO7mzekj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1831563"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1831563"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:02:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="14580197"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 10:02:24 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:02:23 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:02:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 10:02:22 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 10:02:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYpeFi6GjaZEwp2cI9YaaU9fvGYE+QIgfjCI5mH+RONYRuGPYs/ybqN8pEKYH/hvo4CiEXemWcFfZxml9WnrIqsGV2rRqlEygYhMSjdVMOtY4jChmRMaMWPGE0rZo5xMMY8KlJu0dT93BNLs2QDIwgAdtvBD1ImZMIZArby9Bs5ue65RmcTq8hKpjm59cyW67jAjTHfp/yL1baJ4zHfGZTnGmAf6ja1BK8YHSWV0yGZ2Ej4WXUnsoPrY4oi1xYJkrnv7rgD37eDqKthrp6+hmAgnfJRI9FEHtq62sJxAe7r7EkI43WlTaLpJeHMoGxJWkgntB3/JGDQ3vJVV8THw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+ysrkCQ2d1Z0ryIK1itTEbQna7ya96xdY+YeRkYs4c=;
 b=jVcT0NzLF5ME9lewmnDSf15CRdrsHFQhxPqHLilP7Xc0azWILJErC1GX+sRyDxdr+Qa6pLPAVo+cQWzPkMNzp43wNjmiz3ivpCwqiLnDaB4oA3zlfsl1JlPfoEEHNK5ividJQtvDttxQ7Ftu5Ue7eCqUSVW6t77ByJ6q3pn/C/hAcSOEUKZKt7JiWXpMtoBMUa03f3R7+5KY1yDm2maiVJSqIRVzz+nHkAay2QFClD8Ar5BH6GlzGazSHdXmlC4KgKR3es3PnPuKGwQlv3SFM2t/PoxGTi6IxA+j4X5Zoui9rCS3+Fo4r1KhRZDLxZepehwfUcahiPJXB6J5XJv/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 18:02:18 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 18:02:18 +0000
Date: Mon, 11 Dec 2023 19:02:04 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <jakub@cloudflare.com>, <iii@linux.ibm.com>,
	<hengqi.chen@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/4] bpf, x64: Fix tailcall hierarchy
Message-ID: <ZXdOnO8I2a8yvO2B@boxer>
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
 <20231011152725.95895-3-hffilwlqm@gmail.com>
 <ZW+sNudwg5Bc0Gbl@boxer>
 <d144dda7-a90c-4a40-9caa-a48c0e7e7fae@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d144dda7-a90c-4a40-9caa-a48c0e7e7fae@gmail.com>
X-ClientProxiedBy: DB8PR03CA0025.eurprd03.prod.outlook.com
 (2603:10a6:10:be::38) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB4822:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da0b49c-1721-49a2-3a9b-08dbfa735093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPCZTCvuc+sGYngRaOYiN4MZog3BvHQLzzK5pG+bOveP9KzqBe1B+ZclWoZ2gwFo/da6qhCDHg6PKZXshSgJw4c4Uy6PNbwMhsk9ZJN7G/2VINV5LtL3lUJW8fmYKUItKLYYDAfJmYoJsKQ+QdZ8i6zSDfBr4sxA5txA+JZWJZIjzKBHMMOmG1yqveY7x1hmi+0gZK1qfLTVzuyetpgYloOnZsWnWb2oby5fY4+tNx4KEGV8QbWpPq5SKQIC2pLhl3Q+74lW6xl7B9iVIQJD2AjDO1t7b1ZVdxZ3A23fOTryc5xEhWDBHP3YpTST3/qDBsij6JLP5l7wc+x+anhwJhJqchiTARhXY5vsGgEbG0AdVcjf0ETV32e65MECCCrj6KbIuqC6cfktobyQr00RPt2xSHFLw/l+g4lo+ZMzSQ/0tGzv+6XOz3SrZ+Y3AorGRb1Tm6p5Jrocvci9E4BDx7CX9W2u5ruZljFv7oC7vtmIR11jebLAzyDrdHwj0s0J0rDl4K8+QqGgjV/76OrgFbu4gwbMd9F8oSPDhEufuYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(30864003)(2906002)(41300700001)(33716001)(38100700002)(86362001)(82960400001)(9686003)(83380400001)(6512007)(26005)(6666004)(478600001)(53546011)(6486002)(6506007)(966005)(4326008)(5660300002)(44832011)(316002)(6916009)(66556008)(66476007)(66946007)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R+/0YYeVWYVGHD+//3qjShXYbAxcalaVFVlCxcLfN0QBrfbh+/URWb/XajiL?=
 =?us-ascii?Q?y/5eGtXSTGwMkj4mRrFpKyyBJ94l72XK51bQxRihwo8ckH/anxjpoF3jLBfT?=
 =?us-ascii?Q?tEvLluREKEQSO1cMSpffW6e6/b+h2pXzTYei3zmtMAK8w6MEsXyH05npQU9a?=
 =?us-ascii?Q?vk3J9RysL/yil6M5IduzcipMcAxBC4Hd7VkOf/L09u2Tt2PjbMki7lw255Es?=
 =?us-ascii?Q?ejv1AK6zUzSti83GjvwPbaH5M24Xc20mkh8IXCMKTpYH8v16OjhMwk9H7Qjt?=
 =?us-ascii?Q?+eU1bcOX7ARvIYG/Q9RuVS/Tk8MI5KGgu6MBt+m/DvUXbt6q07Q4BNWuYP79?=
 =?us-ascii?Q?0HgjRJvqSPs5GaRuEhJKgJprIvnyLJMRctBZCLte6VHyMYiA8pB9IvVAe92n?=
 =?us-ascii?Q?KiDblyZ/CRKqmG+J3Mkd0h1p/xj6ybHfODNhkiWN2lNEFy/Kevi3FzXS4Rm7?=
 =?us-ascii?Q?LwLK4UPb95UGgZRypfbpzqEN2Y/Ky3ck5pePA8uerJgZNdQ8f+FK8vdVBp/4?=
 =?us-ascii?Q?sN449Lx3ST03HCqI6hZjN+W4nnVXFjhQTWcVqeXahoY19kLVD8LsPUyTEbIi?=
 =?us-ascii?Q?0rxwasBPk2YlV1dZ7YvlK5bryWVJ42obrrryI/zpPdaKtsQbOJAZHHUltG9V?=
 =?us-ascii?Q?JiyjcA8pebvsaNp1SZ82vgAUoVeHwgm9k6KtPGn1v+ygj+jOsbRe3y3/3mqt?=
 =?us-ascii?Q?nJpq4580sqUB+LtIHXkYXgpdkQZ0xy2uxYDfjed6GuUTeaenX6rH3l50u4Wd?=
 =?us-ascii?Q?HSG1pNCSKh8umGvc+DbBfsbtCzk0890qkO8BbYNd97RAAP6BqTjp8sPmJlSg?=
 =?us-ascii?Q?gvDrcL60qf1EfMrDNznxXzKtAYI0mJbuFFNWX0dXn19Cp2PsNgBuhJrZp6EZ?=
 =?us-ascii?Q?S4pMS0GSjvOoVrKBrk6gsaF1lHVNzFST+9YGCLdyz+VlnF8dNLaQk61bEFT0?=
 =?us-ascii?Q?15vuowB8RuA8YE04VmHtSmJ6w5l+Xm4oS51tOryi6Gw7sGZd5IFYGRvZUcUv?=
 =?us-ascii?Q?zzCKqlxQLGh5M5tzhUd1XtemC1oz6j74oGxLyWPq1bU9mAGdF3sE6N5QJb01?=
 =?us-ascii?Q?C96cijiEUnLgaLs1iLpVzKMZMvusYC+ENYYvJGdjAldZIPgGnoSa1z1KyaUs?=
 =?us-ascii?Q?V8dOHmNYNYkgA9N5T495ynjK/qYuyG9f5L0IFv5q+iyQAuAc24Qk01NdBwD2?=
 =?us-ascii?Q?ec6eUZiACrhi/73S6jY7EgPUomA+/LnBygqSaJGfh9/xe1A7rHPnz4zmiBEh?=
 =?us-ascii?Q?7pIsTK7qTVGtVSlkf+Yo6zPajqxgydPB/Vlv+/wYfZ2Q42C7/0I3UWQaXDkT?=
 =?us-ascii?Q?F3eXwl5JtFGhNqoBUUELwL2lKxsXEXY0TMvqQi4cdbabw9YYzPZQxAgvwoI0?=
 =?us-ascii?Q?1V8Ip1gBv0t2JlA4yNUMV0OggIrlLIpyA6wpt2IG/SukBklOaqSGdoyoBnOH?=
 =?us-ascii?Q?bz+Z653BjSQMzkI3Y8z9vgcvLE3zu0pjjCIy3v/EXv1md04HNHv+/JYW1iQh?=
 =?us-ascii?Q?906CYQi/4W8wEwHEEPB8xe30UnoRq1B2D0ir9wMK6D7lW1wpx3o2MU2iE1bW?=
 =?us-ascii?Q?VmTcUFv2WDaxV2BsgVMIgW0gl9d/JSY0ZmqAXa3j02zUlwlAOw1RRXVP3ZFu?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da0b49c-1721-49a2-3a9b-08dbfa735093
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:02:18.5000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkomiGYYIZvnq5NlGgQ4uJxgln6xLSle3Fv2NNFG1at5HLsXzfX911H95IIsVvF4c8Wk+bqohx1r5YQ0GjoBuFriWw0IMmVzess0QHNONLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-OriginatorOrg: intel.com

On Wed, Dec 06, 2023 at 02:51:28PM +0800, Leon Hwang wrote:
> 
> 
> On 6/12/23 07:03, Maciej Fijalkowski wrote:
> > On Wed, Oct 11, 2023 at 11:27:23PM +0800, Leon Hwang wrote:
> >> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
> >> handling in JIT"), the tailcall on x64 works better than before.
> >>
> >> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
> >> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> >>
> >> How about:
> >>
> >> 1. More than 1 subprograms are called in a bpf program.
> >> 2. The tailcalls in the subprograms call the bpf program.
> >>
> >> Because of missing tail_call_cnt back-propagation, a tailcall hierarchy
> >> comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.
> >>
> >> As we know, in tail call context, the tail_call_cnt propagates by stack
> >> and rax register between BPF subprograms. So, propagating tail_call_cnt
> >> pointer by stack and rax register makes tail_call_cnt as like a global
> >> variable, in order to make MAX_TAIL_CALL_CNT limit works for tailcall
> >> hierarchy cases.
> >>
> >> Before jumping to other bpf prog, load tail_call_cnt from the pointer
> >> and then compare with MAX_TAIL_CALL_CNT. Finally, increment
> >> tail_call_cnt by its pointer.
> >>
> >> But, where does tail_call_cnt store?
> >>
> >> It stores on the stack of bpf prog's caller, like
> >>
> >>     |  STACK  |
> >>     |         |
> >>     |   rip   |
> >>  +->|   tcc   |
> >>  |  |   rip   |
> >>  |  |   rbp   |
> >>  |  +---------+ RBP
> >>  |  |         |
> >>  |  |         |
> >>  |  |         |
> >>  +--| tcc_ptr |
> >>     |   rbx   |
> >>     +---------+ RSP
> >>
> >> And tcc_ptr is unnecessary to be popped from stack at the epilogue of bpf
> >> prog, like the way of commit d207929d97ea028f ("bpf, x64: Drop "pop %rcx"
> >> instruction on BPF JIT epilogue").
> >>
> >> Why not back-propagate tail_call_cnt?
> >>
> >> It's because it's vulnerable to back-propagate it. It's unable to work
> >> well with the following case.
> >>
> >> int prog1();
> >> int prog2();
> >>
> >> prog1 is tail caller, and prog2 is tail callee. If we do back-propagate
> >> tail_call_cnt at the epilogue of prog2, can prog2 run standalone at the
> >> same time? The answer is NO. Otherwise, there will be a register to be
> >> polluted, which will make kernel crash.
> > 
> > Sorry but I keep on reading this explanation and I'm lost what is being
> > fixed here> 
> > You want to limit the total amount of tail calls that entry prog can do to
> > MAX_TAIL_CALL_CNT. Although I was working on that, my knowledge here is
> > rusty, therefore my view might be distorted :) to me MAX_TAIL_CALL_CNT is
> > to protect us from overflowing kernel stack and endless loops. As long a
> > single call chain doesn't go over 8kB program is fine. Verifier has a
> > limit of 256 subprogs from what I see.
> 
> I try to resolve the following-like cases here.
> 
>           +--------- tailcall --+
>           |                     |
>           V       --> subprog1 -+
>  entry bpf prog <
>           A       --> subprog2 -+
>           |                     |
>           +--------- tailcall --+
> 
> Without this fixing, the CPU will be stalled because of too many tailcalls.

You still didn't explain why CPU might stall :/ if you stumble upon any
kernel splats it's good habit to include them. So, for future readers of
this thread, I reduced one of your examples down to:

#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include "bpf_legacy.h"

struct {
        __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
        __uint(max_entries, 1);
        __uint(key_size, sizeof(__u32));
        __uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

static __noinline
int subprog_tail(struct __sk_buff *skb)
{
        bpf_tail_call_static(skb, &jmp_table, 0);
        return 0;
}

SEC("tc")
int entry(struct __sk_buff *skb)
{
        subprog_tail(skb);
        return 0;
}

char __license[] SEC("license") = "GPL";

and indeed CPU got stuck:

[10623.892978] RIP: 0010:bpf_prog_6abcef0aca85f2fd_subprog_tail+0x49/0x59
[10623.899606] Code: 39 56 24 76 30 8b 85 fc ff ff ff 83 f8 21 73 25 83 c0 01 89 85 fc ff ff ff 48 8b 8c d6 10 01 00 00 48 85 c9 74 0f 41 5d 5b 58 <48> 8b 49 30 48 83 c1 0b ff e1 cc 41 5d 5b c9 c3 cc cc cc cc cc cc
[10623.918646] RSP: 0018:ffffc900202b78e0 EFLAGS: 00000286
[10623.923952] RAX: 0000002100000000 RBX: ffff8881088aa100 RCX: ffffc9000d319000
[10623.931194] RDX: 0000000000000000 RSI: ffff88811e6d2e00 RDI: ffff8881088aa100
[10623.938439] RBP: ffffc900202b78e0 R08: ffffc900202b7dd4 R09: 0000000000000000
[10623.945686] R10: 736391e000000000 R11: 0000000000000000 R12: 0000000000000001
[10623.952927] R13: ffffc9000d38d048 R14: ffffc900202b7dd4 R15: ffffffff81ae756f
[10623.960174]  ? bpf_test_run+0xef/0x320
[10623.963988]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10623.969826]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10623.975662]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10623.981500]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10623.987334]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10623.993174]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10623.999016]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.004854]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.010688]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.016529]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.022371]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.028209]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.034043]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.043211]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.052344]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.061453]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.070404]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.079200]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.087841]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.096333]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.104680]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.112886]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.121014]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.129048]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.136949]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.144716]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.152479]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.160209]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.167905]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.175565]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
[10624.183173]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.190738]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
[10624.198262]  bpf_test_run+0x186/0x320
[10624.203677]  ? kmem_cache_alloc+0x14d/0x2c0
[10624.209615]  bpf_prog_test_run_skb+0x35c/0x710
[10624.215810]  __sys_bpf+0xf3a/0x2d80
[10624.221068]  ? do_mmap+0x409/0x5e0
[10624.226217]  __x64_sys_bpf+0x1a/0x30
[10624.231693]  do_syscall_64+0x2e/0xa0
[10624.236988]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[10624.243550] RIP: 0033:0x7fd76171e69d
[10624.248576] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 63 a7 0f 00 f7 d8 64 89 01 48
[10624.270613] RSP: 002b:00007ffe694f8d68 EFLAGS: 00000202 ORIG_RAX: 0000000000000141
[10624.279894] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd76171e69d
[10624.288769] RDX: 0000000000000050 RSI: 00007ffe694f8db0 RDI: 000000000000000a
[10624.297634] RBP: 00007ffe694f8d80 R08: 00007ffe694f8d37 R09: 00007ffe694f8db0
[10624.306455] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe694f9348
[10624.315260] R13: 000055bb8423f6d9 R14: 000055bb8496ac90 R15: 00007fd761925040

Looking at assembly code:

entry:
ffffffffc0012c60 <load3+0x12c60>:
ffffffffc0012c60:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
ffffffffc0012c65:       31 c0                   xor    %eax,%eax
ffffffffc0012c67:       55                      push   %rbp
ffffffffc0012c68:       48 89 e5                mov    %rsp,%rbp
ffffffffc0012c6b:       50                      push   %rax
ffffffffc0012c6c:       48 8b 85 f8 ff ff ff    mov    -0x8(%rbp),%rax
ffffffffc0012c73:       e8 30 00 00 00          call   0xffffffffc0012ca8
ffffffffc0012c78:       31 c0                   xor    %eax,%eax
ffffffffc0012c7a:       c9                      leave
ffffffffc0012c7b:       c3                      ret

subprog_tail:
ffffffffc0012ca8 <load3+0x12ca8>:
ffffffffc0012ca8:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
ffffffffc0012cad:       66 90                   xchg   %ax,%ax
ffffffffc0012caf:       55                      push   %rbp
ffffffffc0012cb0:       48 89 e5                mov    %rsp,%rbp
ffffffffc0012cb3:       50                      push   %rax
ffffffffc0012cb4:       53                      push   %rbx
ffffffffc0012cb5:       41 55                   push   %r13
ffffffffc0012cb7:       48 89 fb                mov    %rdi,%rbx
ffffffffc0012cba:       49 bd 00 7c 73 0c 81    movabs $0xffff88810c737c00,%r13
ffffffffc0012cc1:       88 ff ff
ffffffffc0012cc4:       48 89 df                mov    %rbx,%rdi
ffffffffc0012cc7:       4c 89 ee                mov    %r13,%rsi
ffffffffc0012cca:       31 d2                   xor    %edx,%edx
ffffffffc0012ccc:       8b 85 fc ff ff ff       mov    -0x4(%rbp),%eax
ffffffffc0012cd2:       83 f8 21                cmp    $0x21,%eax
ffffffffc0012cd5:       73 17                   jae    0xffffffffc0012cee
ffffffffc0012cd7:       83 c0 01                add    $0x1,%eax
ffffffffc0012cda:       89 85 fc ff ff ff       mov    %eax,-0x4(%rbp)
ffffffffc0012ce0:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
ffffffffc0012ce5:       41 5d                   pop    %r13
ffffffffc0012ce7:       5b                      pop    %rbx
ffffffffc0012ce8:       58                      pop    %rax
ffffffffc0012ce9:       e9 7d ff ff ff          jmp    0xffffffffc0012c6b
ffffffffc0012cee:       41 5d                   pop    %r13
ffffffffc0012cf0:       5b                      pop    %rbx
ffffffffc0012cf1:       c9                      leave
ffffffffc0012cf2:       c3                      ret

I am trying to understand what are writing to %rax when entry is target of
tailcall. rbp comes from subprog_tail and we popped all of the previously
pushed regs. So what is exactly causing this hang?

(I thought I'd rather respond just to let you know I'm on it)

> 
> > 
> > Can you elaborate a bit more about the kernel crash you mention in the
> > last paragraph?
> 
> We have progs, prog1, prog2, prog3 and prog4, and the scenario:
> 
> case1: kprobe1 --> prog1 --> subprog1 --tailcall-> prog2 --> subprog2 --tailcall-> prog3
> case2: kprobe2 --> prog2 --> subprog2 --tailcall-> prog3
> case3: kprobe3 --> prog4 --> subprog3 --tailcall-> prog3
>                          --> subprog4 --tailcall-> prog4
> 
> How does prog2 back-propagate tail_call_cnt to prog1?
> 
> Possible way 1:
> When prog2 and prog3 are added to PROG_ARRAY, poke their epilogues to
> back-propagate tail_call_cnt by RCX register. It seems OK because kprobes do
> not handle the value in RCX register, like case2.
> 
> Possible way 2:
> Can back-propagate tail_call_cnt with RCX register by checking tail_call_cnt != 0
> at epilogue when current prog has tailcall?
> No. As for case1, prog2 handles the value in RCX register, which is not tail_call_cnt,
> because prog3 has no tailcall and won't populate RCX register with tail_call_cnt.

I don't get it. Let's start with small example and do the baby steps.

> 
> However, I don't like the back-propagating way. Then, I "burn" my brain to figure
> out pointer propagating ways.

I know that code can damage programmer's brain, that's why we need to
strive for elaborative and easy to understand commit messages so that
later on we will be able to pick up what is going on here.

> 
> RFC PATCH v1 way:
> Propagate tail_call_cnt and its pointer together. Then, the pointer is used to
> check MAX_TAIL_CALL_CNT and increment tail_call_cnt.
> 
>     |  STACK  |
>     +---------+ RBP
>     |         |
>     |         |
>     |         |
>  +--| tcc_ptr |
>  +->|   tcc   |
>     |   rbx   |
>     +---------+ RSP
> 
> RFC PATCH v2 way (current patchset):
> Propagate tail_call_cnt pointer only. Then, the pointer is used to check
> MAX_TAIL_CALL_CNT and increment tail_call_cnt.
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
> > 
> > I also realized that verifier assumes MAX_TAIL_CALL_CNT as 32 which has
> > changed in the meantime to 33 and we should adjust the max allowed stack
> > depth of subprogs? I believe this was brought up at LPC?
> 
> There's following code snippet in verifier.c:
> 
> 	/* protect against potential stack overflow that might happen when
> 	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
> 	 * depth for such case down to 256 so that the worst case scenario
> 	 * would result in 8k stack size (32 which is tailcall limit * 256 =
> 	 * 8k).
> 
> But, MAX_TAIL_CALL_CNT is 33.
> 
> This was not brought up at LPC 2022&2023. I don't know whether this was
> brought up at previous LPCs.

Was referring to this:
https://lpc.events/event/17/contributions/1595/attachments/1230/2506/LPC2023_slides.pdf

but let us focus on issue you're bringing up here in this patch. I brought
this up thinking JIT code was fine, now it's clear that things go south
when entry prog is tailcall target, which we didn't test.

> 
> Thanks,
> Leon
> 

