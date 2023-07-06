Return-Path: <bpf+bounces-4270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA441749FE4
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804D92813B3
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6DEA939;
	Thu,  6 Jul 2023 14:52:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D076A924;
	Thu,  6 Jul 2023 14:52:41 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0952D1725;
	Thu,  6 Jul 2023 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688655147; x=1720191147;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6IiGwvREJ7dHDEeC4DJhlc02DA5toSFa02EMoFFU9q8=;
  b=Z/mzjq/YuhuQKNFcUDTqR0BBwsSNhgn4lFZv/dAX8XdYZUhOfhjX7UAD
   nyUOF2qr2cUWSUzIOpSsp73knfApX+RHQNsAwGmJh9LIdJUKsoaxQo0Gu
   BOPOfgcyfvS/nWYFkbZNybCwT2lYPljzJIRFcgw06p4hA09WcsEG3zYmN
   ru5Ctp0yB5LhSOrP4cAtpDbWROOnGiv2DWlLW23+kmmNOQKuf5JfwBW9y
   kAPfQ6Ic9I5XvnHuWm+BNdhp+b97JkEh4ovZa2ZSuBSspqa+DewEqBK5Y
   wPbjQ2E5ebvMD+E0g0rFpqenDLUNvP3s9GVgg8JGL+g/hY4oakmMi55ds
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="427300524"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="427300524"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 07:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="809662566"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="809662566"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2023 07:50:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 07:50:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 07:50:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 07:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iub/KmKjpzP0249YQKNJ6OxnEhLPXSSuTjzWTyMHoND48/vvqBwlc/vzS0E+NmOecpX886hGbxoF5w+v7CoxfRxYCSbjL0sBmCyTvUJFJk1rJZtTFY6sMyPBkxhT+mLNjttJQLitSE8M1mbDJUG6U0MC/VVv0xIbhwSmWE5bgZwje/Pxc0s0dmdpwdFm497GPICgOYfQdtOxlYp7bLxbzUw6Sz7kdhH7JXvbys3hvnrVifh/TwzDMkxniCsn76GZMeovwr96LRcAWok58MjaBf1rW6c7fzDyjcK9mau+6fvx0mqA2I+NIW/Z5u95jH+x5Wu8QHR0bE/WOPa+EelqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXXZ19P4hy2r93JsNpxgMcz6jejnPy2LiviwQxHkNOY=;
 b=HYvEF2ODg8nsRL5DmzrufRkv627F+wf/ugxual3Ed3qK/8XkwKBJKs3nmefKVojVReJZ5q36GXDv6tqHKsHwWA7/xguTK2P7x0SFqiTA4gPzoL6CrKR5+6+S6AKuQepbIjpbp6ZCzQfKhckTjIO8K2ZMFmNTnVG3x5uBl7LDwAs/K8gyKwKf2qo733juNjAUDK4ezA1VuImRdoP/WFSp9or/svtoQjAHR384SyCUQTVndgRiuF8BkGZ1b4ay55qBx5JqllryUL4oQaJtnYnYNCsi+Sx9mLIvvALZs92uq3GH9UuuHnfMjM38Fq9aJhdU1BHdi4xnMS+07BptXhLLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 14:50:30 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:50:29 +0000
Date: Thu, 6 Jul 2023 16:46:28 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
CC: <brouer@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
	<bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH bpf-next v2 09/20] xdp: Add VLAN tag hint
Message-ID: <ZKbTxDKCRlnJxyf0@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-10-larysa.zaremba@intel.com>
 <64a32c661648e_628d32085f@john.notmuch>
 <ZKPW6azl0Ak27wSO@lincoln>
 <f7aa7eb6-4600-cebf-bd09-d05fc627fd0d@redhat.com>
 <ZKP8KRy04IqyHXuI@lincoln>
 <e0050610-ee6f-7c3c-a303-7cddc73cff7c@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e0050610-ee6f-7c3c-a303-7cddc73cff7c@redhat.com>
X-ClientProxiedBy: BE1P281CA0433.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::21) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BL3PR11MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aeb758f-49c3-4e79-a70a-08db7e30572b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16uHoVt2RCu8nwfNzSHbpVt1MlfyUrwlSPfjRVBKVIj9gvc6Fo3u82RGYwarHreHuwY/PjhKScgK/zX5LzNHld+d5PZdjsxlkg75WFP9kbA37eY0toJV5fEDYrulwzILH2VKVsIlE18OEI4DP9YqnhodcOlVQPk7RbBcZg3MOHs986M2leSX8j2P8dyLtN9rb5Js+vUcnJCubwtEmQ9qUlUOApDuGynIRoLB/8oBlZozquH/ivr068gBsuY8UwIKwLziLkXffkcImttH40NCkDR2nWDHsvmiHKV3bFOL45YLiLEqfQ6jakR7BdZ2onm8m2+z0znVUkqsqnCGPRfUbv3NIvsjF6w0z/06u6AKqzJoYYl/1StSzf5afO4tShRS3qQFvfQuefH0J+iS+WklDqqskynp6zpmNuEI25KrH+D0ezqimX8hptR2Pe9pCjL0dJHSgZqPkNhfosqL2FzVfgP/P1SVUHaMDQ4eU0g5C7FkZMwnGUR/eJOHkOH8z7SfFaK8EM7GZG8MzuMJCnH6+Kdk5cET7MIQEAZ8do/9jIPSE/GpGKiRyGWLmBaRV821J8rDIel02Folh4FeLdT0ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(478600001)(6486002)(54906003)(6506007)(26005)(9686003)(6512007)(966005)(186003)(2906002)(66946007)(33716001)(41300700001)(316002)(66556008)(6916009)(4326008)(66476007)(7416002)(44832011)(5660300002)(8936002)(8676002)(38100700002)(82960400001)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yWCVnJHQ/J7OynEub48pmqJDAnuwCCoo/fzCdmUgI1DgAYdqHbznZymcPokK?=
 =?us-ascii?Q?dTboSF/zZPolcCF8pITj7qIFWa7W4SLfKyKxJ2JR7TH38NMx5VKc6HD040yQ?=
 =?us-ascii?Q?0qNs8b5NTCXRene0qIYb+5WWsj8OLSBg1pprQrP66aATGqdR5Vop0B1BLG7s?=
 =?us-ascii?Q?UJfj0ZDn8Vo7yl41ara6SKrDR/g8/s2HNRe8Z90sqz9cpACSSzqHtNl/yvPF?=
 =?us-ascii?Q?TgtieMGkkHqNzzk3cvh2woxb2yCYJxIaeXcAX0R4R57ceA6LWSO4QJwcYZi7?=
 =?us-ascii?Q?9bs525c1h6P5stK2NUc2o/RdJacawMxikL8fgkCozdUfg+2mFZ9J8I5OW8Pw?=
 =?us-ascii?Q?jcjpdEKGrwdeuA1x9AIA283wrlbZtA2yGAZ5pJNvXJijW85gctxHVFtqzOHi?=
 =?us-ascii?Q?4adLhFb4/pNm1NpV+2N9l4WVaKH7AOJZ67nrKlFWUiaSei2VyzstKStBPVTS?=
 =?us-ascii?Q?uWmNe4Gph4rIURA3+mXA6z6msfcixga1O+pSB/K2xnB0tT4h/YWjzDzI065v?=
 =?us-ascii?Q?OpGTvfiAzw6LcYa6XugEyxU0JebiqoWOTlTtHy3EeOSOEmJ1zPtFxCzcY2HO?=
 =?us-ascii?Q?CGF8DGbXvvEoma4Y2uI6Ss/jXIpBw/mlJ51zYiYOjfmfNi+TohpE1quGi/bl?=
 =?us-ascii?Q?+e1LqLB7z6otKam4HvgE+0kMkZWMgq1yiwy2SwjBYgsIMnl72qUnYlm2cXoW?=
 =?us-ascii?Q?H+y20gtL/kUhifNzMNBVU9tSFqONCEOP3pUo/uJADi1KT1OjOyuu2OOw8DyV?=
 =?us-ascii?Q?aVFHsvupRwC5QY2SZLrZ6F+1nyRhlH5qxaszswhRH42pT6/hYmf5gnUV2PUw?=
 =?us-ascii?Q?t033GSbjpxvl+CYnnzhbrBkDvIWgaakkUF4pfzdherupH2Yb2opYOZSHwgU3?=
 =?us-ascii?Q?qS24AlKF4SANay0wWpVnVQj5JGduNVan3TOD6tigAG4ARZn7fyZPkCqnmitM?=
 =?us-ascii?Q?V1Xu/6nfRQ5Erc8Ap2dJIXvOBeJdJeW0HrdqnLVhxBm90alsQl2/1Pnw9S+q?=
 =?us-ascii?Q?jRHUXbdYsnUWswmGl6Saaw6ilXBkQPno8g/APDVTPon/cp3gILgCKReKPiA0?=
 =?us-ascii?Q?WABVNY7rScLQU4/ofO4aepi0J19lEGMgTETucLhjqgqQYLJ/b04OcRg0xCtD?=
 =?us-ascii?Q?lo1LZw9VoTLbVDcPllIrsVd1pUP/cliTJTJZPwtp+7I3KtC/1d5V/EctYGjU?=
 =?us-ascii?Q?oEQBgsmah1RpUkG9eYEEBA4orKOfCa37GBg2L/+5Y/b7ymH+8F+bEcIPnC4w?=
 =?us-ascii?Q?1Ovc6RXmoJ+NYOtWiExNzxTjwNjkm1ksmJQ3occm/IXamQOBGKP5U15/yioz?=
 =?us-ascii?Q?0UEMk+UICcWM0jtedfV03KBVKY01CB217q2ANtp2PLtzI9zM6VwyyS7Mi7j1?=
 =?us-ascii?Q?Tret+DhnnEqtg27jz0FYRhELyjk+P4Oare0o+bc2smuyq1rKNNsDNoopECVZ?=
 =?us-ascii?Q?IbCAZGsEU/SnvFCXV5K+mUGiSr8OMGi5IXj/aMbtmWv0tz1q1ofw5XCB0MJb?=
 =?us-ascii?Q?K4ddOzBuh2jT2OSwWVKHrZlKwaWLik51OipvyhA8BU1pL4j1/prMZ/AngOYC?=
 =?us-ascii?Q?i+GNccijKimPmWLp+pWN2uIvRgWAPcn2S2Yer6LGM6yuck2dYUE55+x37Wxg?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aeb758f-49c3-4e79-a70a-08db7e30572b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 14:50:29.3832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3x37iZsYZ7OcD1Ef+g/cCuTO7x4m2JJu3D6ardhS1ws4b1dqY6aVTWB5R/vyDdFiDM2B+2ZWYNjZJKxXRwIK21TwehluFJ7/nzfDGlfTdRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6532
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 04:18:04PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 04/07/2023 13.02, Larysa Zaremba wrote:
> > On Tue, Jul 04, 2023 at 12:23:45PM +0200, Jesper Dangaard Brouer wrote:
> > > 
> > > On 04/07/2023 10.23, Larysa Zaremba wrote:
> > > > On Mon, Jul 03, 2023 at 01:15:34PM -0700, John Fastabend wrote:
> > > > > Larysa Zaremba wrote:
> > > > > > Implement functionality that enables drivers to expose VLAN tag
> > > > > > to XDP code.
> > > > > > 
> > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > ---
> > > > > >    Documentation/networking/xdp-rx-metadata.rst |  8 +++++++-
> > > > > >    include/linux/netdevice.h                    |  2 ++
> > > > > >    include/net/xdp.h                            |  2 ++
> > > > > >    kernel/bpf/offload.c                         |  2 ++
> > > > > >    net/core/xdp.c                               | 20 ++++++++++++++++++++
> > > > > >    5 files changed, 33 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > > > > > index 25ce72af81c2..ea6dd79a21d3 100644
> > > > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > > > @@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
> > > > > >    metadata is supported, this set will grow:
> > > > > >    .. kernel-doc:: net/core/xdp.c
> > > > > > -   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
> > > > > > +   :identifiers: bpf_xdp_metadata_rx_timestamp
> > > > > > +
> > > > > > +.. kernel-doc:: net/core/xdp.c
> > > > > > +   :identifiers: bpf_xdp_metadata_rx_hash
> > > > > > +
> > > > > > +.. kernel-doc:: net/core/xdp.c
> > > > > > +   :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > > > >    An XDP program can use these kfuncs to read the metadata into stack
> > > > > >    variables for its own consumption. Or, to pass the metadata on to other
> > > [...]
> > > > > > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > > > > > index 41e5ca8643ec..f6262c90e45f 100644
> > > > > > --- a/net/core/xdp.c
> > > > > > +++ b/net/core/xdp.c
> > > > > > @@ -738,6 +738,26 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
> > > > > >    	return -EOPNOTSUPP;
> > > > > >    }
> > > > > > +/**
> > > > > > + * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag with protocol
> > > > > > + * @ctx: XDP context pointer.
> > > > > > + * @vlan_tag: Destination pointer for VLAN tag
> > > > > > + * @vlan_proto: Destination pointer for VLAN protocol identifier in network byte order.
> > > > > > + *
> > > > > > + * In case of success, vlan_tag contains VLAN tag, including 12 least significant bytes
> > > > > > + * containing VLAN ID, vlan_proto contains protocol identifier.
> > > > > 
> > > > > Above is a bit confusing to me at least.
> > > > > 
> > > > > The vlan tag would be both the 16bit TPID and 16bit TCI. What fields
> > > > > are to be included here? The VlanID or the full 16bit TCI meaning the
> > > > > PCP+DEI+VID?
> > > > 
> > > > It contains PCP+DEI+VID, in patch 16 ("selftests/bpf: Add flags and new hints to
> > > > xdp_hw_metadata") this is more clear, because the tag is parsed.
> > > > 
> > > 
> > > Do we really care about the "EtherType" proto (in VLAN speak TPID = Tag
> > > Protocol IDentifier)?
> > > I mean, it can basically only have two values[1], and we just wanted to
> > > know if it is a VLAN (that hardware offloaded/removed for us):
> > 
> > If we assume everyone follows the standard, this would be correct.
> > But apparently, some applications use some ambiguous value as a TPID [0].
> > 
> > So it is not hard to imagine, some NICs could alllow you to configure your
> > custom TPID. I am not sure if any in-tree drivers actually do this, but I think
> > it's nice to provide some flexibility on XDP level, especially considering
> > network stack stores full vlan_proto.
> > 
> 
> I'm buying your argument, and agree it makes sense to provide TPID in
> the call signature.  Given weird hardware exists that allow people to
> configure custom TPID.
> 
> Looking through kernel defines (in uapi/linux/if_ether.h) I see evidence
> that funky QinQ EtherTypes have been used in the past:
> 
>  #define ETH_P_QINQ1	0x9100		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY
> REGISTERED ID ] */
>  #define ETH_P_QINQ2	0x9200		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY
> REGISTERED ID ] */
>  #define ETH_P_QINQ3	0x9300		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY
> REGISTERED ID ] */
> 
> 
> > [0]
> > https://techhub.hpe.com/eginfolib/networking/docs/switches/7500/5200-1938a_l2-lan_cg/content/495503472.htm
> > 
> > > 
> > >   static __always_inline int proto_is_vlan(__u16 h_proto)
> > >   {
> > > 	return !!(h_proto == bpf_htons(ETH_P_8021Q) ||
> > > 		  h_proto == bpf_htons(ETH_P_8021AD));
> > >   }
> > > 
> > > [1] https://github.com/xdp-project/bpf-examples/blob/master/include/xdp/parsing_helpers.h#L75-L79
> > > 
> > > Cc. Andrew Lunn, as I notice DSA have a fake VLAN define ETH_P_DSA_8021Q
> > > (in file include/uapi/linux/if_ether.h)
> > > Is this actually in use?
> > > Maybe some hardware can "VLAN" offload this?
> > > 
> > > 
> > > > What about rephrasing it this way:
> > > > 
> > > > In case of success, vlan_proto contains VLAN protocol identifier (TPID),
> > > > vlan_tag contains the remaining 16 bits of a 802.1Q tag (PCP+DEI+VID).
> > > > 
> > > 
> > > Hmm, I think we can improve this further. This text becomes part of the
> > > documentation for end-users (target audience).  Thus, I think it is
> > > worth being more verbose and even mention the existing defines that we
> > > are expecting end-users to take advantage of.
> > > 
> > > What about:
> > > 
> > > In case of success. The VLAN EtherType is stored in vlan_proto (usually
> > > either ETH_P_8021Q or ETH_P_8021AD) also known as TPID (Tag Protocol
> > > IDentifier). The VLAN tag is stored in vlan_tag, which is a 16-bit field
> > > containing sub-fields (PCP+DEI+VID). The VLAN ID (VID) is 12-bits
> > > commonly extracted using mask VLAN_VID_MASK (0x0fff).  For the meaning
> > > of the sub-fields Priority Code Point (PCP) and Drop Eligible Indicator
> > > (DEI) (formerly CFI) please reference other documentation. Remember
> > > these 16-bit fields are stored in network-byte. Thus, transformation
> > > with byte-order helper functions like bpf_ntohs() are needed.
> > > 
> > 
> > AFAIK, vlan_tag is stored in host byte order, this is how it is in skb.
> 
> I'm not sure we should follow SKB storage scheme for XDP.
>

I think following SKB convention is a good idea in this particular case. As I 
have mentioned below, in ice VLAN TCI in descriptor already comes in LE, so no 
point in converting it into BE, so somebody would use bpf_ntohs() later anyway. 
We are not the only manufacturer that does this.

> > In ice, we receive VLAN tag in descriptor already in LE.
> > Only protocol is BE (network byte order). So I would replace the last 2
> > sentences with the following:
> > 
> > vlan_tag is stored in host byte order, so no byte order conversion is needed.
> 
> Yikes, that was unexpected.  This needs to be heavily documented in docs.

You mean the motivation, why it is so and not the other way around?

> 
> When parsing packets, it is in network-byte-order, else my code is wrong
> here[1]:
> 
>   [1] https://github.com/xdp-project/bpf-examples/blob/master/include/xdp/parsing_helpers.h#L122
> 
> I'm accessing the skb->vlan_tci here [2], and I notice I don't do any
> byte-order conversions, so fortunately I didn't make a code mistake.
> 
>   [2] https://github.com/xdp-project/bpf-examples/blob/master/traffic-pacing-edt/edt_pacer_vlan.c#L215
>

In raw packet, VLAN TCI is in network byte order, but skb requires NIC/driver
to convert it into host byte order before putting it into skb.
 
> > vlan_proto is stored in network byte order, the suggested way to use this value:
> > 
> > vlan_proto == bpf_htons(ETH_P_8021Q)
> > 
> > > 
> > > 
> 
> --Jesper
> 

