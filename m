Return-Path: <bpf+bounces-4234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1E1749B58
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C3B2812E5
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A415A8F54;
	Thu,  6 Jul 2023 12:06:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1AC8F42;
	Thu,  6 Jul 2023 12:06:08 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F9E10F7;
	Thu,  6 Jul 2023 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688645167; x=1720181167;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F7mJtOnOCj5Y4V22tVM5iUeytiAQYiX6kkpuJpAe2PE=;
  b=h1WdMYAEVAXxZMq8eU+wVr2BO9255yZEuhlcXd25RmbWdGhGTZKDUvms
   b7yrHmRjkdWHgKKLVHQ1xBI8hKVHP5uz5fL78H9x6473Mw3/iPu5sRt/P
   RQsZFoNG1Kc5MjYURl4P4lrA/xJisIrba4bhjWWmYKIoJMdIknx/8cCi8
   awCHxJ2UHIJ6yKwMq4s+4FAJUJAOIe8lB2In34FA7G8sUhTQotCRjBHIx
   JLLZIx8RKne0Yboztt6322LuCKJil5jwiCmwg5Et8as3BLSln4NT0Ucu+
   2xqh4m8IKxCWop8dvmW5aOpawHILb7lofmfUHKDEkI0yM61LyaVzMnLNe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343174272"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="343174272"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="722766831"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="722766831"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jul 2023 05:06:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 05:06:06 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 05:06:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 05:06:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 05:06:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNkKIA+Elq8s4JtGhVaYdI7bv5Aw0QcfXIoFvdys8J2uNj0QpR44RAUegp2iIib3fiCNxsbHg2x6CVlgcPQdYNI041+ZTcgrkvjWLnjySdHwsZnTitp2UfWNjjFUH3Rcu+crEidn8xUu/19oNoXcDLJynqOR7Lz59nJqniNHkcPSSK7cgyrPM49I8p4BCAGt/60pnNpFYptGLSs6+kA+i2uUhruOX4v16B8RdlGuh2Ymz6AOa9Q8thc/ZhLOw2SG5opqPEeNnemFclyq8hkhnvZoEvm6z1BANFoDl4Pq2A3ALjHltYaohfp+9eH039l6E0RrbvZEheqL6TA5yzWZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgOAVpOeEXM8sr9DyNJY1AdYjXXOqry624BnT5LG+uc=;
 b=gQZ0KxR3Tbzdjyj0C9rtypFr2o1Z+qbQW3lvk7pt/Pz5J/s+Dg1ilQS+mk7pOe97p4lB1vqlQhA1fKjBGudy/jeQkCf4AoY3TaNI+9UcN1uLfT9OShjRaqd/XNPNQNuaOGhNTLeXF8R0KHyoL561ZOzLHT+KUvxqg7r1V3Jwdi/m+A3NRk3es0UhjQCfdmp2k5Lrg3Ra2CAkZK6Z5xQLVXoNX7o7PSQmVedSt2XAqNERZs4cAA81p+F4Y3sPwnr4jwUqHRKTq5uwAjpG+PiabLf3B6e0FC22SrfEoXBNKoyJcwZj8ttEie+5S0blJff+saDcFOt10j0StQNQFZ0oxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH8PR11MB7022.namprd11.prod.outlook.com (2603:10b6:510:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 12:06:01 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:06:01 +0000
Date: Thu, 6 Jul 2023 14:02:00 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
CC: <bpf@vger.kernel.org>, <brouer@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yhs@fb.com>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 20/20] selftests/bpf: check checksum level in
 xdp_metadata
Message-ID: <ZKatOMUMTfbhd5Y0@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-21-larysa.zaremba@intel.com>
 <cb8f65a9-30ac-ee6e-3368-e653a72dfaaf@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb8f65a9-30ac-ee6e-3368-e653a72dfaaf@redhat.com>
X-ClientProxiedBy: BE1P281CA0289.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::16) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH8PR11MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee354fe-7dfc-472e-ae21-08db7e195c99
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTEyHhi7FDYTa1Ne/zRpL8jt/TTxDFU61F7MW12eeVgJo9TJofPGB/FnbeIMS6yfdq+TE3n91fq9e+MxnX9hGOzOp4aJBmxu0rwCNf1fCpTTVATOrOQzlgXNXzN8cdPM2QZOCCVLJueS7D92imSVpqiC8Da4xZhrCwQ9/rkzB3YHWXEoSIFWWROkS1GufphGUEaWKctKB3aaiBtfA3didk24cHlRuGTcRa78nHN/YmA84YlDFSmA0sheXape/DmNVpAoiDPK/XrKqcGnxvsLaB1K2bSgZpSaMEKm+1RqZkrwYn7Ei0mFUcL1Cq3oswjHZyY6FhV3BYTOMj6nJEHLxDjB66gV9d3IAe4WPwwTyIm0lNJ6KbkK+1VwkdDHnL2YG8B5xFgraV7o5hi++NjptS+6ndMXoSAYT0BjkS0ZNAeoCKt4uSSkbvecjnGgiSPVbIIECxdeHDjDXZjUUdy3uq4vDtgxMCdl3VLIP7JTj+e2Vus0RNVIxMWquK9pa/dw02l73BXaRK7/zMxlReX2lqMTyb00OmvTAjE7tcS4WFQqdFMyJvlRMW5sMpLh7yOZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(33716001)(2906002)(41300700001)(7416002)(44832011)(8936002)(8676002)(186003)(6506007)(478600001)(5660300002)(26005)(6512007)(9686003)(82960400001)(86362001)(6486002)(316002)(4326008)(6916009)(66946007)(66556008)(38100700002)(66476007)(54906003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bqKCKiyfkxkmcmGvHIkn/TfU2Z0FLhQ3UnWLTrrXAXgFhf/g0gRTkHyKuSS4?=
 =?us-ascii?Q?QB5ZYCJ7yWB9sSJgcLhM18ALtKAG8JocgBsKTmnwhSmTDxvtKqilUDP/ykl+?=
 =?us-ascii?Q?pZW8qEAJzuGCZEeyWAWl6g3a8pFrjRp1CBaDlCjQ0N08oEtHLtioUWKf1g43?=
 =?us-ascii?Q?fnJw9qkKwkI6UZ+pEwkDJFUhZyZ4W4BGEcbyic0L1X0bRhzW0XXTKaQHmBRg?=
 =?us-ascii?Q?6dhPOFtukmXFabigO5MamN/Gy8UA732CWye+maes6lbfZAHfsflNEnyTgyuc?=
 =?us-ascii?Q?Uiy/b2SVwHcPOWLW5FgQv1q5Kc22slzfyFIFKDCJhrNhtR7iYm0jb/Hr93IU?=
 =?us-ascii?Q?SblLZ4nmD6v55v8LOruSUeWiArFODSsg6arOVWXV1K3QWddjFs+tw9DaepHI?=
 =?us-ascii?Q?xwROrttqF/d5b+FzFp0W0RKO6U8vxoqM0jrzyZrYtIeG6pHoN2Ezyh+uHIrD?=
 =?us-ascii?Q?OCTdcqpyZ2yxF35xo0GmHlw+WOTM752M/rHFmOQBSUuxqMsG1QFBzu0atMJJ?=
 =?us-ascii?Q?zRWZwfT0gRJZ6lAeJloHDYKAA/8kzkt/pa5iZTFAnl+vzIpkMlfdJ+DfPpqT?=
 =?us-ascii?Q?JbDw86amtwkSND6zzOOG2BwJIDTeA1KNAntmugnI5l4Kis9ylJxneGe4fssl?=
 =?us-ascii?Q?Oxcym52Gbj3XtJB9vMidEL+YERBoG/VbRPFiVUcj2wTL4BPpPd1lycU9Oc59?=
 =?us-ascii?Q?kju6RiSxmV/RWBuJQo0qp505i/ne5jfwiebgZOWhR6IZWFbDtWM/i/560CEp?=
 =?us-ascii?Q?+UEGk6BlwAZVotV9P99Jwr0a+ggO3UNT1bstDPvu26dsr1px2OJQ71IcqHyU?=
 =?us-ascii?Q?i6Wbz91evvp1lSUC17RRjSDcmnBP36MCJ9eb2dJUdCl2wXYkgZSifflkua/P?=
 =?us-ascii?Q?TXrYfLjCwpzGc/SPpLfHB0mGL1RZXLUFjenhLfG/gMpaO2Ksm7u0OZ00qFz4?=
 =?us-ascii?Q?57z+AXEqHpvQP3vrENDKr3lGDNoe5xYUjE5Lr/Z/sEaLyiAazAgV4wc4yNIe?=
 =?us-ascii?Q?ftmcGVFqKLyuoh02f4umBOtHmKFUoPyqqRwj8RS3pJiVx+eojec693LsNDvo?=
 =?us-ascii?Q?Z0F5xkvmixv817U834xAHX06d1kJhxkbZiAJ99Do79Svn+oNya2Gj1Q96c2l?=
 =?us-ascii?Q?IWEoEKTyBBD5M3mUr8KzszpYOhEyeD6rPuxngI/rEu6ocuhT2SK0+d5LQRkM?=
 =?us-ascii?Q?i2h5QGJ5wRmuWJ4W7wydrVWE5Eb1enxidmtqLgUqLBii3Xgeu32uD1g84SbL?=
 =?us-ascii?Q?YfJ1g6hg96vHdzKTk3LgxvkOXJQDBUb1eJ9G4pK+YMK0oYr9CHo2XBISS1FG?=
 =?us-ascii?Q?6g3B+Ydgoh7GlVuYwZtV6Wkx0Wt8Z4W6e0vUMVOEyAvZdXYzVXXg6YravERg?=
 =?us-ascii?Q?1XTrOO5Y9XJuI4Jrho7Feyy8/jM54dwMXCsejxbYSns64Rqy8W46lcJuUhGN?=
 =?us-ascii?Q?Tk0oQdJuZ8AqOfk4g5Vd0LxBcEfIoRKybEd93bZEaVUcqDjJdtU5fMJ3LwLt?=
 =?us-ascii?Q?Es3UaJ9jiL/kQu0uwPs/dBs82EWbPBeMuzYLMIP6KwAErtrWFTUKg5/ilg5D?=
 =?us-ascii?Q?zOZHadpPVzbaXwqllk76sVAPcngfyLFEsnNcRsnnP2ORoezNC1Ub7CUF70zh?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee354fe-7dfc-472e-ae21-08db7e195c99
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:06:00.5609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/XPLeTZRXeVuKacuk4Hpj59fZNQeYgpH16iDo/5Uk5XeWyih7L3E0sUBVZThLzpOXkmU42uBdDXzlfUsqVIUAnuU87aPEYGrkq6lnouwJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7022
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 12:25:10PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 03/07/2023 20.12, Larysa Zaremba wrote:
> > Verify, whether kfunc in xdp_metadata test correctly returns checksum level
> > of zero.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >   tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 3 +++
> >   tools/testing/selftests/bpf/progs/xdp_metadata.c      | 7 +++++++
> >   2 files changed, 10 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > index 50ac9f570bc5..6c71d712932e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > @@ -228,6 +228,9 @@ static int verify_xsk_metadata(struct xsk *xsk)
> >   	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
> >   		return -1;
> > +	if (!ASSERT_NEQ(meta->rx_csum_lvl, 0, "rx_csum_lvl"))
> > +		return -1;
> 
> Not-equal ("NEQ") to 0 feels weird here.
> Below you set meta->rx_csum_lvl=1 in case meta->rx_csum_lvl==0.
> 
> Thus, test can pass if meta->rx_csum_lvl happens to be a random value.
> We could set meta->rx_csum_lvl to 42 in case meta->rx_csum_lvl==0, and
> then use a ASSERT_EQ==42 to be more certain of the case we are testing are
> fulfilled.
>

I just copied the approach used for timestamp. I think you are right and I 
should have make the new code better.

ASSERT_NEQ(0) is also used for rx_hash. It would be a good idea to go and fix 
those too, but the patchset has already ballooned too much for me, so I would 
leave it for later.

With ASSERT_EQ for checksum level, I think comparing it to "1" should be enough. 
Do I guess correctly, the main problem with ASSERT_NEQ is uninitialized memory?
 
Another value that is less magical than 42 would be "4", because csum_level 
takes 2 bits, so it is the smallest value that does not correspod to 
any valid checksum level.
 
> 
> > +
> >   	xsk_ring_cons__release(&xsk->rx, 1);
> >   	refill_rx(xsk, comp_addr);
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > index 382984a5d1c9..6f7223d581b7 100644
> > --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > @@ -26,6 +26,8 @@ extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
> >   extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> >   					__u16 *vlan_tag,
> >   					__be16 *vlan_proto) __ksym;
> > +extern int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx,
> > +					__u8 *csum_level) __ksym;
> >   SEC("xdp")
> >   int rx(struct xdp_md *ctx)
> > @@ -62,6 +64,11 @@ int rx(struct xdp_md *ctx)
> >   	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
> >   	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tag, &meta->rx_vlan_proto);
> > +	/* Same as with timestamp, zero is expected */
> > +	ret = bpf_xdp_metadata_rx_csum_lvl(ctx, &meta->rx_csum_lvl);
> > +	if (!ret && meta->rx_csum_lvl == 0)
> > +		meta->rx_csum_lvl = 1;
> > +
> 
> IMHO it is more human-readable-code to rename "ret" variable "err".
> 
> I know you are just reusing variable "ret", so it's not really your fault.
> 
> 
> 
> >   	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
> >   }
> 

