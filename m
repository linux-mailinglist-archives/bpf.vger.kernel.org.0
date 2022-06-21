Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1A5529B8
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 05:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245520AbiFUD0S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 23:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiFUD0Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 23:26:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B480717A95;
        Mon, 20 Jun 2022 20:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655781975; x=1687317975;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3UUzmastkjkBvzPlcjmHOA36xjHhroPLJBY7DN/2RPw=;
  b=EgGhSp0gNOTXxhw7oAFMK3udbPTTOu7EA5ACTSuiqt6R55X7rgSgUptR
   W+UyVr8rxVy//A/yaUHADFNHWhvwzTcSZIJwbHeg/LSRLfnsRFqvkyreH
   1LJJ1cflum3yJZelwA+DJ3kCDhCj2dHy8rzuG8mjRWT1gQfkXCy7s8Boc
   KIrLA9d6Axl+xk+zBr66zvSGkld06Uh8mkdLweBBVZ8gtf6ScX9GhPBts
   ggaqSgAuHmEzP7Hii0+TRgAEUK0BV1es83L2DxzQDWF/j4WfkVIx0+ZQk
   PJxAnCKYQmBGX0qj2X3LlS6ze4SoplbOSiOeuw06/Hi8T+Cr/b33yo9zI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="281070546"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="281070546"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 20:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="643406061"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2022 20:26:14 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 20:26:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 20 Jun 2022 20:26:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 20 Jun 2022 20:26:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk+ZFRb4Wlr4pD8DSFwQ3IqUp0WgS89JHGAcG/cQtvu0fSjX9G0zgfaGq0Obsi+hVCc5U2bnnXSgmUQjdcbVjeL3eaeDoDmkYFvrSOchs0oXYT67808vbQIMUiy+iweMm49jws8gAkgTBgGohfFptjVduoP2hYCM2uzJZkz44R+l+6/cPr2npbnbCY7BLYb+j1nAobhyGal1GbN55bbjgZcrOWYm0BCW4MysaXPbxwr8XK0HYl8QZ5YOf/cXJUMkuMWPSizVUtdNeeciVNQKO2jXvMXDtTaaxWbrhNSXLdWsd1ReJlF5Pbs7NdEfwaEj3jwPiMCdwtaCrxDRpJ36pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmAasQVbAUgcOi4O1nGlevxnnh5PpE9CEVXI08LHqQY=;
 b=cS8XXIQ7OuNRKa+rHjp/ww9VvzxoRiCI1l0oXqrcRKnmzocsbL2zI4wQxu8OMZULngG9tRNSuYnHRM7WbWPZs4mt9o/+yAI92a4vxPjzXChzNP6nD9e1OW+znNdPPKqUl07BOTV2W5NhIWAkAHnHJfVBshiu9cWs23w1h0JUB42Lw3MaAm70s+qbKqEYIos76wVyewow/J3zh5d+RQJS7EoPlTDu3yqHSzZAgBw2InqG3jwj2FZKRxRRYLeP6738MoQ0dSrw8X6mc2HPGd+7Gb1L3PxBobyH7QmxBxetYD1dcxGE+BpztxlGZ0Cx3/iSm7Te7tMY2k7FY4MauEahfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by BL1PR11MB5240.namprd11.prod.outlook.com (2603:10b6:208:30a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 03:26:11 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::b513:4291:3790:a5a4]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::b513:4291:3790:a5a4%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 03:26:11 +0000
Date:   Tue, 21 Jun 2022 11:25:58 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Song Liu <song@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v4 bpf-next 0/8] bpf_prog_pack followup
Message-ID: <YrE6RqnQuXD8OB9N@ziqianlu-Dell-Optiplex7000>
References: <20220520235758.1858153-1-song@kernel.org>
 <YrBV8darrlmUnrHR@ziqianlu-Dell-Optiplex7000>
 <CAPhsuW5oqJKHUr6wwbFyC8DFyawKr8djuv5Bjk7FEQ5dnKDGyw@mail.gmail.com>
 <YrEfghUwr+IO2MM1@ziqianlu-Dell-Optiplex7000>
 <CAPhsuW4eAm9QrAxhZMJu-bmvHnjWjuw86gFZzTHRaMEaeFhAxw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPhsuW4eAm9QrAxhZMJu-bmvHnjWjuw86gFZzTHRaMEaeFhAxw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0146.namprd04.prod.outlook.com
 (2603:10b6:303:84::31) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 053d8911-d547-479c-d3b4-08da5335c9d7
X-MS-TrafficTypeDiagnostic: BL1PR11MB5240:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL1PR11MB5240776183CD9F441002607A8BB39@BL1PR11MB5240.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVZgeUlB+86OUJnGyyxQuY23zUm9oPLFlxX2NJ5II1WJjbPmXmXdtdNW+6wBEh2gmnxWSo1hnpjtMSG43vVwLBLfLnM9XfrC2DTVMOPUzEQuH1/AAyfRNlJvb2Hveg+Ex92M7ekdDwmPE7M5RR/fLZ8ZlLVcIRZEhxgLQ30PoT033f7Uk9fCHpG6dFbHyDT8PC4L7xe9mwSmHa+N4XYY8pwYD/ibmrUjodgsVbvsgipsWFDmNWZhJnlI3y4UmTepsLN7lrBWRyE2od6m/KrEox5UAxD7lK9u5Jwqtc8SwQM4yYWgOcR6KLe5j39KDGaJNn+6h5I2xQLgItRtMcXDK4HYN/rpCTONZjaHGykl5HzTZQV5+5/mvHufJTQ/liv6hWDLIV5tGOcaebXbbMCWYiNeppQHKjJfoqv7nhF9jtekVaz8CN59uLE7emOZYJ+2BuSdo7AiDXtxuBDnUjn/RJ5c+bpHARxGrmxxgLav/Y6yBjjTQfbaFijRUfAowO7OC4oglxS2L+xkMU3cXt5TtXkXWhE4y8tGQpvz4f9Tc0bjOi3ZkJjrv4wr9qYavUaG5A0pS1eGuKHk7fWYCrg6Dzxs0XrRjRhWZz80zKqaxMB/a9gA3Lw8fHBe33v10re+9DfXD2Yh+0XtY22KoPztnJbZUExPdLdqvgoXbz8HT0yRq+bYsCS9uXhvDDDEXteVTsm3CJEZsZcNJNHJpPu86g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(376002)(346002)(39860400002)(366004)(44832011)(4326008)(53546011)(8676002)(66946007)(316002)(66476007)(66556008)(33716001)(6916009)(54906003)(8936002)(86362001)(5660300002)(6666004)(7416002)(82960400001)(6506007)(38100700002)(6486002)(478600001)(41300700001)(186003)(6512007)(83380400001)(26005)(9686003)(2906002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d9tHbD9IUM9vgvGc3XV5YzNoOJxFgKuQOtxmhBQ/aBqkJKeKAiV8Ap9Pk8HF?=
 =?us-ascii?Q?+LzDmmkOUnpm5iR3oskBWmplCiv/1fufoMIcRpBgG6QVclEKSN9HZUBFJBnT?=
 =?us-ascii?Q?O9/RZf+UvJsGU4ZrWlaAaFRZSBdod699exzW4OIGqHSp1+2z/Of93iLRVMlD?=
 =?us-ascii?Q?ykxKEoc4YhYtDx75Xmf4HUrTQ6sA3AHOAtGwHoZtRneGRRMrAiEIiX1ZBocx?=
 =?us-ascii?Q?3VEig+WDuqPSCZWqpTbqkIskYcUKryTnwfWwIgfpBbqUQ2SsNn5635kDjDIy?=
 =?us-ascii?Q?nmSEkvMeFS0ww7YIx8k+eNoBYJCyvvormbXGQQbhrmSA4h1jRBBoYV5UjqDO?=
 =?us-ascii?Q?KCMgK1PoJcR/7HSxvhN9R4SqtilyCVxtjKiaG+y4aAVStKddJUsXNUkBjvLc?=
 =?us-ascii?Q?9kXKPJQ2kYsANxDTL8V1Q7ga9UaRAEgCzMUy9Ta2VuLz7GTnsF3vSbrP/Ljs?=
 =?us-ascii?Q?65zZgHrDlS+MiphE12NgOuFOG0iZwsUtbbsGzpU3pIosqgwyVb/ndQCfjqUu?=
 =?us-ascii?Q?Qzb5zYdFOJ8b+NI6n8dxLRlfUzoQV9R71BULfGcVqSttWGSMlQGWNMpsTbg/?=
 =?us-ascii?Q?f05Q6wr9A4tDQrBkoITb4ycVdjQTHusmwwLpaX/kGs0xMzBQu0N7bysLu/GX?=
 =?us-ascii?Q?kEv5tSFzkb4SM5y/lb024yzAukoy8wRwDB80XvUQW0F7/FkXLXmrvzLzsauH?=
 =?us-ascii?Q?AAqSgLY0od+CfUFRC9pA7oCBq3jWyK9sD+lQ1s8Mo0O7W9gS+EtbUVzJei1t?=
 =?us-ascii?Q?jg0vnyfXBkabrqbagTvlCDMQXTYtM9vForw5jQsmZQDCob8r3gk1/Sh/2hYV?=
 =?us-ascii?Q?vD8R6Fz/nTpNuxmzUgbO3D0SpmMqsyFuxnyDmxnN0+EFC4cO9YnLYiOTPBOx?=
 =?us-ascii?Q?YQKGmlF44u7KpmVMiD5Z1aIRCHaGSb0XrUi1nzOYAOUS5j/M2xni5xPdl8/a?=
 =?us-ascii?Q?M+1Tnu4ngSLEi3s1VAtog0/FHsSYLu4u7+wXd/wnbezakGgN3dyGXZvsCp1B?=
 =?us-ascii?Q?uMdHMmgFD/v5XjSLN+7vWkp/b+1LAXLX9R/4NFJGELFEQwDWRMPySckaDSMy?=
 =?us-ascii?Q?kMB81ZfntyXRM4cCSWoOOdoDBzhcuc6LAG7357rh3DrnyrDi0400JWvqNo2f?=
 =?us-ascii?Q?R9zF8aLFwBRG2kQbOvTq4qvZgD2tU4tcFT8cx51pOKp5/nnHmX8vuuqZ8k6/?=
 =?us-ascii?Q?h4nkmWEJjpHYgWnVw9H9vxl3lGvFVkAyL/J4f18kTURWMGx3RwwJwsLnVDAi?=
 =?us-ascii?Q?DReYKtADgeY7n5Y+LJJ+eVwblIs6URlgawCXwR67yvnWaazaIhGd4j8G0AcE?=
 =?us-ascii?Q?d7AeA5HtniC+s+6ZKjCfXP0C61YUf+ICulaMfMh3hOrUkqS8Tt8F11SDl0fm?=
 =?us-ascii?Q?VdU70MCDbgE1Mjo84NcaFDk3iGyagiACFfNKSM9VQ8Ir0hJrQrqrtW+D9ot4?=
 =?us-ascii?Q?IzgLJJ3LLo58VXzRttJVog4Ea8szeLYjgQ2GQEgUdsI47iaa9LIrul3OUIhj?=
 =?us-ascii?Q?FU5I+2/mcDdf63OZI1lm1NOkpiO9hA7tMazhOfupjqDMfhBNba8WNdhh3/XC?=
 =?us-ascii?Q?BunXhgP+CLG5PsOHS2dp3HVpTECKE5XJ8lbvEauWb7nD0Eb6NSizsaCMhkou?=
 =?us-ascii?Q?gbu1ZrawVAeJFryX23cXB+kJ/fVUwZdASiAxG3MRgX7aURFx22Emp6u7YGi+?=
 =?us-ascii?Q?IBXbRiLVeGuPuUvVAigZvj/IpZr1catGHF96DPvNrB6GLm29/lI9c+B5a+Ce?=
 =?us-ascii?Q?LPkL3CFUzg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 053d8911-d547-479c-d3b4-08da5335c9d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 03:26:11.5301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaQT80VpGiOwWLPQJT+fGWiwyOZaMLZWMXUV9xzKnG/ZUb+UTLYqglKYs+vfs2NBK0YAhF0s+sdrx+zQ/WfLBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5240
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 20, 2022 at 07:51:24PM -0700, Song Liu wrote:
> On Mon, Jun 20, 2022 at 6:32 PM Aaron Lu <aaron.lu@intel.com> wrote:
> >
> > On Mon, Jun 20, 2022 at 09:03:52AM -0700, Song Liu wrote:
> > > Hi Aaron,
> > >
> > > On Mon, Jun 20, 2022 at 4:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
> > > >
> > > > Hi Song,
> > > >
> > > > On Fri, May 20, 2022 at 04:57:50PM -0700, Song Liu wrote:
> > > >
> > > > ... ...
> > > >
> > > > > The primary goal of bpf_prog_pack is to reduce iTLB miss rate and reduce
> > > > > direct memory mapping fragmentation. This leads to non-trivial performance
> > > > > improvements.
> > > > >
> > > > > For our web service production benchmark, bpf_prog_pack on 4kB pages
> > > > > gives 0.5% to 0.7% more throughput than not using bpf_prog_pack.
> > > > > bpf_prog_pack on 2MB pages 0.6% to 0.9% more throughput than not using
> > > > > bpf_prog_pack. Note that 0.5% is a huge improvement for our fleet. I
> > > > > believe this is also significant for other companies with many thousand
> > > > > servers.
> > > > >
> > > >
> > > > I'm evaluationg performance impact due to direct memory mapping
> > > > fragmentation and seeing the above, I wonder: is the performance improve
> > > > mostly due to prog pack and hugepage instead of less direct mapping
> > > > fragmentation?
> > > >
> > > > I can understand that when progs are packed together, iTLB miss rate will
> > > > be reduced and thus, performance can be improved. But I don't see
> > > > immediately how direct mapping fragmentation can impact performance since
> > > > the bpf code are running from the module alias addresses, not the direct
> > > > mapping addresses IIUC?
> > >
> > > You are right that BPF code runs from module alias addresses. However, to
> > > protect text from overwrites, we use set_memory_x() and set_memory_ro()
> > > for the BPF code. These two functions will set permissions for all aliases
> > > of the memory, including the direct map, and thus cause fragmentation of
> > > the direct map. Does this make sense?
> >
> > Guess I didn't make it clear.
> >
> > I understand that set_memory_XXX() will cause direct mapping split and
> > thus, fragmented. What is not clear to me is, how much impact does
> > direct mapping fragmentation have on performance, in your case and in
> > general?
> >
> > In your case, I guess the performance gain is due to code gets packed
> > together and iTLB gets reduced. When code are a lot, packing them
> > together as a hugepage is a further gain. In the meantime, direct
> > mapping split (or not) seems to be a side effect of this packing, but it
> > doesn't have a direct impact on performance.
> >
> > One thing I can imagine is, when an area of direct mapping gets splited
> > due to permission reason, when that reason is gone(like module unload
> > or bpf code unload), those areas will remain fragmented and that can
> > cause later operations that touch these same areas using more dTLBs
> > and that can be bad for performance, but it's hard to say how much
> > impact this can cause though.
> 
> Yes, we have data showing the direct mapping remaining fragmented
> can cause non-trivial performance degradation. For our web workload,
> the difference is in the order of 1%.

Many thanks for the info, really appreciate it.

Regards,
Aaron
