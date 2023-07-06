Return-Path: <bpf+bounces-4252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3A3749EC1
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 16:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDCD1C20DB7
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A58946E;
	Thu,  6 Jul 2023 14:15:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655218F74;
	Thu,  6 Jul 2023 14:15:15 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D08DB;
	Thu,  6 Jul 2023 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688652912; x=1720188912;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QLa+zk4Yd+zOFoBPc718KbE21ngEJ/yZQpp/FawrjPc=;
  b=Jg47AVynh176uBEQQkCiDO+D+Z0/gRUVRRBDzBHOy15V6DYgdFUXbtbW
   h5mrr54GnkYX/GQJf155t1c6me5wE1bhbJf7CiNBo2+3zdtdYio6VFRu9
   XVKCJNW/LvYqpi1AFZ2YPXPqPRLt8ZkjAoxhbYPWsOEkNPIpxDYbezgzd
   ZenkrVJ2rlhICzBwE9WLxTRHAiItyr6m1V3CTlm1CsSYiq5KiQP9xU/r2
   5uuPgZv9y7GRguKV1d5v1wZLSSnYP5WkOqojWZafk0KyrTdzDFd2WutUK
   KrQYl8M+8vJkJ5Eae02HlrPewZcxX8lyN9jvCofg1qtXhTyKPgD24+HGq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="363648325"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="363648325"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 07:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="843701383"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="843701383"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 06 Jul 2023 07:15:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 07:15:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 07:15:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 07:15:09 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 07:15:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icO/PqluTfL5kOQmKzKpDzyrtTKC2gWiX+X+XhLj4iEQRtWKH4sFTNgHHALi5RmD6pWPmI9IDXScCgIhIlomww0s+nlLOSzI273H96T706zWF2AAQZ9oqTXLg1kb/751bUVH0JYaIDy1IJ3CYYOixYp4mqqvL557RxfLaD4l4MVYx6k6YKSzzkoPTZJZL54IoI43sSbU4BvoIgAn09fP4npH+bDiFPFFRCDpVFtfAVxtMmxIfztVDqFmKu+KlohhH0OviIrdzVIp7i2moLy5V9DZRmsmR9lAgfMM8bhXnhaqWtjw91lHMOCaXc/OFzAEtNTFO2RvT2byLEOtlcmKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgMrxtJ9H8jnLxkeY1MnODY3CRAJ+9ebTOzcjp+E1IU=;
 b=J0z3Rhf3HUWVW39j0uefe8L8EJeysw/9AfQKhI3peILCndWW+JKfbBgfroq4YO3LvzOyCPU6OCF2lrWRCYr/XBB0FPpsHfBLbCyGWPSB6fh+D8APCEpV1dP4xW6f5hwmbNTMAUYTkaPgNM2QNnNxl4BPiQ6nhAhITaezbyFDZhCpHbvCzjijbBXiAbnpfPyOWWGvPa5QwWSkLM+mibacK1ZePeEUCfxbJIhP3rrNPt5nXmLzOPzFBGodUyXP066nGyx0Qo1uijoaZ31H7kjPcsBCrT6PCd+w+9Fgizy6gMYU7oatewerOHhJ3QYjQoGxU0tzQc7FNsEESSmw1CDzQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MW4PR11MB6862.namprd11.prod.outlook.com (2603:10b6:303:220::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 14:15:06 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:15:03 +0000
Date: Thu, 6 Jul 2023 16:11:03 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 18/20] selftests/bpf: Use AF_INET for TX in
 xdp_metadata
Message-ID: <ZKbLd8brydTvSocG@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-19-larysa.zaremba@intel.com>
 <ZKWq142tp/tI6NI3@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZKWq142tp/tI6NI3@google.com>
X-ClientProxiedBy: FR0P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::12) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MW4PR11MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca43936-939e-4ac1-b6c8-08db7e2b63bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3iQHDVJtLroVG+sGm9m8p1v/WpCvbsnwgixLX75bEFhVtfBYIMTXg1yQkdWPCq3xJTWN5hHi5HJbvKWzA2BI+pI5yOwMr22V10t6LQQeyltuAesGgOKeMzLgu2w6nu5CFVrIWFbegPwma55X67S5Ak6QfXxhkybFKSGUDjKntPAvcqC8STZFE/w6ljJBDHbyjuN6+V/jwCSRZPi7R/ZuwUAazElFDdkBq6NgbQmbvr2je3deSEy56632kTh15nSInyHyr290tdhpjNGCJCA3pxk8nCI6p13+HzYjtwlEh/BXYztK/JTfSaT0WcEQbF1HV7vfX9qtfQeiNXSMfWxTzSVGPssCiUTGTqgzBjEep+D+KkjtG9UUgqE2f69pP0WDK7uWSHbrnB2/1GX0t8fhOorHLWgApPSH+gkHO0eLKERtxaLMQZ6jcmvegTUQdHE+zEaPBXd+TAp60ZNKjOvyEWZcBK/SXaplRa6tpB5TNOSeHnQpU5WOUmAS2IfRoN5zKR8X7/jywBZNkl6HWgT2OWZ1WF52Sp0puwyiq9eERPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(4326008)(478600001)(54906003)(82960400001)(6486002)(66946007)(8936002)(8676002)(41300700001)(66476007)(38100700002)(316002)(6916009)(66556008)(83380400001)(186003)(9686003)(966005)(6512007)(26005)(6506007)(2906002)(86362001)(33716001)(5660300002)(44832011)(30864003)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uolGYX08g1oSwRBTc4FOGeMLovaoIe1ijgtrgW+8kUUCKfgJHntDvlMXpycb?=
 =?us-ascii?Q?22lTa6pVB8uDNkjjAum6kKrVcKlU+vRfv3sjijn1Kmri7PA7X78FEf17bWX3?=
 =?us-ascii?Q?g6/Zzzi3tfMWSdY0lTjIhb9h+qV2/8HzJsZM2Z/T4dPhcF7o8Gg+ac+89wSd?=
 =?us-ascii?Q?Pq+YhFWqUwEe+2IpFTU/8+CVzPl0Zt4dMQRdTm8UN+BSwrfb12l+z9NiLdDy?=
 =?us-ascii?Q?L2HFZ8vel0r0FG+4KUX9fCMA3Fi45HqgWjbQ0EZ7lnrkGXGdWFS3kPPHSEZ8?=
 =?us-ascii?Q?YZXY/DH6PFSkDzS/ZQ8cD9mOsJoRBsq5KJdNouZvZeTjMmyKwHVhEtSv6pmU?=
 =?us-ascii?Q?2Y6bYWj89JXy6j5/+zpZWsqVXxsZL33wwMeUtqc8g4KVIVDCrb9+zSxIG+v2?=
 =?us-ascii?Q?9kylDBmIymeYVq4NdgjW9XlcbCF6Xh3Kc7qoe4zhJr18uwexqv2JOAG6cVvK?=
 =?us-ascii?Q?1KSxYwTB3d/23cJL679DiKlsXNClyrc916F1jHav4/gdNfMhs6o6cNjiFhQl?=
 =?us-ascii?Q?GpveyZjxsu/IPMk3f9QON8aKftR+yQks5dDcjfjmipYPs8POwA0sJFlqBvgp?=
 =?us-ascii?Q?cpFeCN5HGb/w2FD6H/JcW1urlJe3j1UDZ/rMwZOtMHTjLk6yNbAZ39DSd6K0?=
 =?us-ascii?Q?dHaKN+dXT1A3vv1FxcWLKSaL5OCn6O50T3VIslOlfTs7EKonz8fJpdtawYgf?=
 =?us-ascii?Q?mQINdvjFSLUGWRrN50Jmu4Pqd/XmOhicZcOc1q5s792JD5K6GbzCLB3dwCg1?=
 =?us-ascii?Q?JA97OxMRO4lGLMRamGn9QcpzUA6bS2ehTMiF/AfstmGpM59H/iZzYHpgEwaG?=
 =?us-ascii?Q?4VC0RslsEEy1xFQ7azhVbjHyfzpwTHmmGkuAF5EoXTUsSBP1TpR3AaYO6dad?=
 =?us-ascii?Q?Eq4Gpvp6Gz0CSI2+mum0e688L604/Wvl21g/aQe3B1NdYjhOCvz4KW2ScT5y?=
 =?us-ascii?Q?P8cAqdzBYzdd6sLRgkxVRW4uKrfe635uFtrhJipYOvrPioCxLj2GKeQQEjkb?=
 =?us-ascii?Q?z+sS9Bm/M5ayWEOLzmxwWKezk5x/E3EctPhKUlHjEclvZUENaIvrigpMk72L?=
 =?us-ascii?Q?gzl+ohsziOfCmkS+uq7GKsZuLgn/WQd8M9kzz48PktqQhROTsV9932hFzwSg?=
 =?us-ascii?Q?A9FbiAYamSzqcCFsTnKxuGkPryguveztWtOgthOC/JwvAKlf7YbeW7e25Qjt?=
 =?us-ascii?Q?BhGB+vmZvIuXRIuuqbZVqAdmYMlQpKDEsTK33ghm7LuUdDq8+SwsTkdbfOVp?=
 =?us-ascii?Q?09VAVz7EJEuVTA/OQjdQLzI0P/C24tSo8a/fW0CaS7H+YrpyBpQPNtvBkQE4?=
 =?us-ascii?Q?JLaGFoTMfAqSSEgNxFthJJF4ET4xFwSHF9xG04AEAwwoWneWK6/wRACQ2z1q?=
 =?us-ascii?Q?dCDf2xlRBIZTS0VHmuHQqitdbeJT6DNgUYrhhTOTraBTdpz41ST9umNmtoy9?=
 =?us-ascii?Q?tNFtLW8/xrm//RBVfjXu4yzqJZGjE/pWjwkQ4kL+MLEJkAARdSAM1v5++Ypv?=
 =?us-ascii?Q?Wi+GaoWftlvcYnrqGHfKzDJodnxvBu8nDC50J99HIsT/H4hj9YrU/LSYz74e?=
 =?us-ascii?Q?WTsdbHjtRDRvcxtHHuStTlXMpHSqKkEimC3WiHd3bZitFAGdRs1EZtTQtD3B?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca43936-939e-4ac1-b6c8-08db7e2b63bb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 14:15:03.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TApJkX2XJPndVwrCVXq3aWpMZPusB0g1b+Ep1ZDH0gCJg7QKXJ/iuE3kGITubgm0CwyyQRDIIhnkNRj9EcK5pRX1VLdKoaGj0hBv+3hs668=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6862
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 10:39:35AM -0700, Stanislav Fomichev wrote:
> On 07/03, Larysa Zaremba wrote:
> > The easiest way to simulate stripped VLAN tag in veth is to send a packet
> > from VLAN interface, attached to veth. Unfortunately, this approach is
> > incompatible with AF_XDP on TX side, because VLAN interfaces do not have
> > such feature.
> > 
> > Replace AF_XDP packet generation with sending the same datagram via
> > AF_INET socket.
> > 
> > This does not change the packet contents or hints values with one notable
> > exception: rx_hash_type, which previously was expected to be 0, now is
> > expected be at least XDP_RSS_TYPE_L4.
> > 
> > Also, usage of AF_INET requires a little more complicated namespace setup,
> > therefore open_netns() helper function is divided into smaller reusable
> > pieces.
> 
> Ack, it's probably OK for now, but, FYI, I'm trying to extend this part
> with TX metadata:
> https://lore.kernel.org/bpf/20230621170244.1283336-10-sdf@google.com/
> 
> So probably long-term I'll switch it back to AF_XDP but will add
> support for requesting vlan TX "offload" from the veth.
>

My bad for not reading your series. Amazing work as always!

So, 'requesting vlan TX "offload"' with new hints capabilities? This would be 
pretty neat.

But you think AF_INET TX is worth keeping for now, until TX hints are mature?
  
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  tools/testing/selftests/bpf/network_helpers.c |  37 +++-
> >  tools/testing/selftests/bpf/network_helpers.h |   3 +
> >  .../selftests/bpf/prog_tests/xdp_metadata.c   | 175 +++++++-----------
> >  3 files changed, 98 insertions(+), 117 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> > index a105c0cd008a..19463230ece5 100644
> > --- a/tools/testing/selftests/bpf/network_helpers.c
> > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > @@ -386,28 +386,51 @@ char *ping_command(int family)
> >  	return "ping";
> >  }
> >  
> > +int get_cur_netns(void)
> > +{
> > +	int nsfd;
> > +
> > +	nsfd = open("/proc/self/ns/net", O_RDONLY);
> > +	ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > +	return nsfd;
> > +}
> > +
> > +int get_netns(const char *name)
> > +{
> > +	char nspath[PATH_MAX];
> > +	int nsfd;
> > +
> > +	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
> > +	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
> > +	ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > +	return nsfd;
> > +}
> > +
> > +int set_netns(int netns_fd)
> > +{
> > +	return setns(netns_fd, CLONE_NEWNET);
> > +}
> 
> We have open_netns/close_netns in network_helpers.h that provide similar
> functionality, let's use them instead?
> 

I have divided open_netns() into smaller pieces (see below), because the code I 
have added into xdp_metadata looked better with those smaller pieces (I had to 
switch namespace several times).

> > +
> >  struct nstoken {
> >  	int orig_netns_fd;
> >  };
> >  
> >  struct nstoken *open_netns(const char *name)
> >  {
> > +	struct nstoken *token;
> >  	int nsfd;
> > -	char nspath[PATH_MAX];
> >  	int err;
> > -	struct nstoken *token;
> >  
> >  	token = calloc(1, sizeof(struct nstoken));
> >  	if (!ASSERT_OK_PTR(token, "malloc token"))
> >  		return NULL;
> >  
> > -	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
> > -	if (!ASSERT_GE(token->orig_netns_fd, 0, "open /proc/self/ns/net"))
> > +	token->orig_netns_fd = get_cur_netns();
> > +	if (token->orig_netns_fd < 0)
> >  		goto fail;
> >  
> > -	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
> > -	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
> > -	if (!ASSERT_GE(nsfd, 0, "open netns fd"))
> > +	nsfd = get_netns(name);
> > +	if (nsfd < 0)
> >  		goto fail;
> >  
> >  	err = setns(nsfd, CLONE_NEWNET);
> > diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> > index 694185644da6..b18b9619595c 100644
> > --- a/tools/testing/selftests/bpf/network_helpers.h
> > +++ b/tools/testing/selftests/bpf/network_helpers.h
> > @@ -58,6 +58,8 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
> >  char *ping_command(int family);
> >  int get_socket_local_port(int sock_fd);
> >  
> > +int get_cur_netns(void);
> > +int get_netns(const char *name);
> >  struct nstoken;
> >  /**
> >   * open_netns() - Switch to specified network namespace by name.
> > @@ -67,4 +69,5 @@ struct nstoken;
> >   */
> >  struct nstoken *open_netns(const char *name);
> >  void close_netns(struct nstoken *token);
> > +int set_netns(int netns_fd);
> >  #endif
> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > index 626c461fa34d..53b32a641e8e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > @@ -20,7 +20,7 @@
> >  
> >  #define UDP_PAYLOAD_BYTES 4
> >  
> > -#define AF_XDP_SOURCE_PORT 1234
> > +#define UDP_SOURCE_PORT 1234
> >  #define AF_XDP_CONSUMER_PORT 8080
> >  
> >  #define UMEM_NUM 16
> > @@ -33,6 +33,12 @@
> >  #define RX_ADDR "10.0.0.2"
> >  #define PREFIX_LEN "8"
> >  #define FAMILY AF_INET
> > +#define TX_NETNS_NAME "xdp_metadata_tx"
> > +#define RX_NETNS_NAME "xdp_metadata_rx"
> > +#define TX_MAC "00:00:00:00:00:01"
> > +#define RX_MAC "00:00:00:00:00:02"
> > +
> > +#define XDP_RSS_TYPE_L4 BIT(3)
> >  
> >  struct xsk {
> >  	void *umem_area;
> > @@ -119,90 +125,28 @@ static void close_xsk(struct xsk *xsk)
> >  	munmap(xsk->umem_area, UMEM_SIZE);
> >  }
> >  
> > -static void ip_csum(struct iphdr *iph)
> > +static int generate_packet_udp(void)
> >  {
> > -	__u32 sum = 0;
> > -	__u16 *p;
> > -	int i;
> > -
> > -	iph->check = 0;
> > -	p = (void *)iph;
> > -	for (i = 0; i < sizeof(*iph) / sizeof(*p); i++)
> > -		sum += p[i];
> > -
> > -	while (sum >> 16)
> > -		sum = (sum & 0xffff) + (sum >> 16);
> > -
> > -	iph->check = ~sum;
> > -}
> > -
> > -static int generate_packet(struct xsk *xsk, __u16 dst_port)
> > -{
> > -	struct xdp_desc *tx_desc;
> > -	struct udphdr *udph;
> > -	struct ethhdr *eth;
> > -	struct iphdr *iph;
> > -	void *data;
> > -	__u32 idx;
> > -	int ret;
> > -
> > -	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
> > -	if (!ASSERT_EQ(ret, 1, "xsk_ring_prod__reserve"))
> > -		return -1;
> > -
> > -	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
> > -	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
> > -	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
> > -	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> > -
> > -	eth = data;
> > -	iph = (void *)(eth + 1);
> > -	udph = (void *)(iph + 1);
> > -
> > -	memcpy(eth->h_dest, "\x00\x00\x00\x00\x00\x02", ETH_ALEN);
> > -	memcpy(eth->h_source, "\x00\x00\x00\x00\x00\x01", ETH_ALEN);
> > -	eth->h_proto = htons(ETH_P_IP);
> > -
> > -	iph->version = 0x4;
> > -	iph->ihl = 0x5;
> > -	iph->tos = 0x9;
> > -	iph->tot_len = htons(sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES);
> > -	iph->id = 0;
> > -	iph->frag_off = 0;
> > -	iph->ttl = 0;
> > -	iph->protocol = IPPROTO_UDP;
> > -	ASSERT_EQ(inet_pton(FAMILY, TX_ADDR, &iph->saddr), 1, "inet_pton(TX_ADDR)");
> > -	ASSERT_EQ(inet_pton(FAMILY, RX_ADDR, &iph->daddr), 1, "inet_pton(RX_ADDR)");
> > -	ip_csum(iph);
> > -
> > -	udph->source = htons(AF_XDP_SOURCE_PORT);
> > -	udph->dest = htons(dst_port);
> > -	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
> > -	udph->check = 0;
> > -
> > -	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
> > -
> > -	tx_desc->len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
> > -	xsk_ring_prod__submit(&xsk->tx, 1);
> > -
> > -	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
> > -	if (!ASSERT_GE(ret, 0, "sendto"))
> > -		return ret;
> > -
> > -	return 0;
> > -}
> > -
> > -static void complete_tx(struct xsk *xsk)
> > -{
> > -	__u32 idx;
> > -	__u64 addr;
> > -
> > -	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
> > -		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
> > -
> > -		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
> > -		xsk_ring_cons__release(&xsk->comp, 1);
> > -	}
> > +	char udp_payload[UDP_PAYLOAD_BYTES];
> > +	struct sockaddr_in rx_addr;
> > +	int sock_fd, err = 0;
> > +
> > +	/* Build a packet */
> > +	memset(udp_payload, 0xAA, UDP_PAYLOAD_BYTES);
> > +	rx_addr.sin_addr.s_addr = inet_addr(RX_ADDR);
> > +	rx_addr.sin_family = AF_INET;
> > +	rx_addr.sin_port = htons(UDP_SOURCE_PORT);
> > +
> > +	sock_fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> > +	if (!ASSERT_GE(sock_fd, 0, "socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)"))
> > +		return sock_fd;
> > +
> > +	err = sendto(sock_fd, udp_payload, UDP_PAYLOAD_BYTES, MSG_DONTWAIT,
> > +		     (void *)&rx_addr, sizeof(rx_addr));
> > +	ASSERT_GE(err, 0, "sendto");
> > +
> > +	close(sock_fd);
> > +	return err;
> >  }
> >  
> >  static void refill_rx(struct xsk *xsk, __u64 addr)
> > @@ -268,7 +212,8 @@ static int verify_xsk_metadata(struct xsk *xsk)
> >  	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
> >  		return -1;
> >  
> > -	ASSERT_EQ(meta->rx_hash_type, 0, "rx_hash_type");
> > +	if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
> > +		return -1;
> >  
> >  	xsk_ring_cons__release(&xsk->rx, 1);
> >  	refill_rx(xsk, comp_addr);
> > @@ -281,40 +226,46 @@ void test_xdp_metadata(void)
> >  	struct xdp_metadata2 *bpf_obj2 = NULL;
> >  	struct xdp_metadata *bpf_obj = NULL;
> >  	struct bpf_program *new_prog, *prog;
> > -	struct nstoken *tok = NULL;
> > +	int prev_netns, rx_netns, tx_netns;
> >  	__u32 queue_id = QUEUE_ID;
> >  	struct bpf_map *prog_arr;
> > -	struct xsk tx_xsk = {};
> >  	struct xsk rx_xsk = {};
> >  	__u32 val, key = 0;
> >  	int retries = 10;
> >  	int rx_ifindex;
> > -	int tx_ifindex;
> >  	int sock_fd;
> >  	int ret;
> >  
> > -	/* Setup new networking namespace, with a veth pair. */
> > +	/* Setup new networking namespaces, with a veth pair. */
> >  
> > -	SYS(out, "ip netns add xdp_metadata");
> > -	tok = open_netns("xdp_metadata");
> > +	SYS(out, "ip netns add " TX_NETNS_NAME);
> > +	SYS(out, "ip netns add " RX_NETNS_NAME);
> > +	prev_netns = get_cur_netns();
> > +	tx_netns = get_netns(TX_NETNS_NAME);
> > +	rx_netns = get_netns(RX_NETNS_NAME);
> > +	if (prev_netns < 0 || tx_netns < 0 || rx_netns < 0)
> > +		goto close_ns;
> > +
> > +	set_netns(tx_netns);
> >  	SYS(out, "ip link add numtxqueues 1 numrxqueues 1 " TX_NAME
> >  	    " type veth peer " RX_NAME " numtxqueues 1 numrxqueues 1");
> > -	SYS(out, "ip link set dev " TX_NAME " address 00:00:00:00:00:01");
> > -	SYS(out, "ip link set dev " RX_NAME " address 00:00:00:00:00:02");
> > +	SYS(out, "ip link set " RX_NAME " netns " RX_NETNS_NAME);
> > +
> > +	SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
> >  	SYS(out, "ip link set dev " TX_NAME " up");
> > -	SYS(out, "ip link set dev " RX_NAME " up");
> >  	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
> > -	SYS(out, "ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
> >  
> > +	/* Avoid ARP calls */
> > +	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME);
> > +
> > +	set_netns(rx_netns);
> > +	SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
> > +	SYS(out, "ip link set dev " RX_NAME " up");
> > +	SYS(out, "ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
> >  	rx_ifindex = if_nametoindex(RX_NAME);
> > -	tx_ifindex = if_nametoindex(TX_NAME);
> >  
> >  	/* Setup separate AF_XDP for TX and RX interfaces. */
> >  
> > -	ret = open_xsk(tx_ifindex, &tx_xsk);
> > -	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
> > -		goto out;
> > -
> >  	ret = open_xsk(rx_ifindex, &rx_xsk);
> >  	if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
> >  		goto out;
> > @@ -355,17 +306,16 @@ void test_xdp_metadata(void)
> >  		goto out;
> >  
> >  	/* Send packet destined to RX AF_XDP socket. */
> > -	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
> > -		       "generate AF_XDP_CONSUMER_PORT"))
> > +	set_netns(tx_netns);
> > +	if (!ASSERT_GE(generate_packet_udp(), 0, "generate UDP packet"))
> >  		goto out;
> >  
> >  	/* Verify AF_XDP RX packet has proper metadata. */
> > +	set_netns(rx_netns);
> >  	if (!ASSERT_GE(verify_xsk_metadata(&rx_xsk), 0,
> >  		       "verify_xsk_metadata"))
> >  		goto out;
> >  
> > -	complete_tx(&tx_xsk);
> > -
> >  	/* Make sure freplace correctly picks up original bound device
> >  	 * and doesn't crash.
> >  	 */
> > @@ -384,10 +334,11 @@ void test_xdp_metadata(void)
> >  		goto out;
> >  
> >  	/* Send packet to trigger . */
> > -	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
> > -		       "generate freplace packet"))
> > +	set_netns(tx_netns);
> > +	if (!ASSERT_GE(generate_packet_udp(), 0, "generate freplace packet"))
> >  		goto out;
> >  
> > +	set_netns(rx_netns);
> >  	while (!retries--) {
> >  		if (bpf_obj2->bss->called)
> >  			break;
> > @@ -397,10 +348,14 @@ void test_xdp_metadata(void)
> >  
> >  out:
> >  	close_xsk(&rx_xsk);
> > -	close_xsk(&tx_xsk);
> >  	xdp_metadata2__destroy(bpf_obj2);
> >  	xdp_metadata__destroy(bpf_obj);
> > -	if (tok)
> > -		close_netns(tok);
> > -	SYS_NOFAIL("ip netns del xdp_metadata");
> > +	set_netns(prev_netns);
> > +close_ns:
> > +	close(prev_netns);
> > +	close(tx_netns);
> > +	close(rx_netns);
> > +
> > +	SYS_NOFAIL("ip netns del " RX_NETNS_NAME);
> > +	SYS_NOFAIL("ip netns del " TX_NETNS_NAME);
> >  }
> > -- 
> > 2.41.0
> > 

