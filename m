Return-Path: <bpf+bounces-3950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BA1746D58
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 11:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57931C2098F
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B07D5392;
	Tue,  4 Jul 2023 09:28:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95756A52;
	Tue,  4 Jul 2023 09:28:49 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3867138;
	Tue,  4 Jul 2023 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688462927; x=1719998927;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kfcwQb7aZ2VFPJYNgPKP+erYqoOT12ur9gd/SfjqodU=;
  b=lHIoEBvr2xee6GoKcikABdPlKav57e2ZR/FduBi8VTPiOW/1ZBv7v3Cj
   8L+Hax+d6ZCe+OxIx32x6UyDEvAO+y6+/IrIDncqmwpdOIllp3ZWhqenT
   6eWuaN9dtRo/JguAzUbazbJ7MCjjZvqPamWJIZwIINQWsShPANVkrZ9K5
   oLsFHSYGfzQm0ZqgREO/BjZKo4aa5hZF7KyoCdodgFGOQRyXXDK63jADH
   L+goIYo60CZNlLKROW1ve0zSKXEHKYf181k1Nhdu/qyZGCTFShmAEeZD9
   vprSMo5IoIkeGkAhqXGlAlod0BYy8yCCv5s27OzSfAggJSeEaQxU5bCJs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366562840"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="366562840"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 02:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="808870931"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="808870931"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2023 02:28:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 02:28:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 02:28:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 02:28:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 02:28:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw7/GdJVkWQqsQwx3X9vZ4UdJzljKKV6NCRiLqvrSN7ozf6jTru1XRkDCIrLo3dcRNuFPekiTOD3Tg7cBUnefEXtyPtKhXwkTkTIbAzmczFaJb0mJBoaSTBMjG3wejtUjaA3LEb0vDWRy9jd67nQhaiNBMT6vxioZkLUoKmhKF/lX2OOjV6LL5AkIro1dhJ5O3tSR0Ikcf9Yw34iwOYYl4TrtiW1l4SM9CgnGaEqykUsahPfD16VGUzJA1IDeIfBv5X+7XfcTrdPdsKX2RPsGRNhi/KiJ9JMoxJBAOY51KbN3PwKCILd6dmuc55OQIT1a/FvAmaZbTvBjHLSe6vVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnYiFjeMMacTsqcDu+Ikp+ifaAr5zzEqNFNZFC0nrpA=;
 b=MfXfJ7UAQ/cxyQJrTfsjUp5vTUDNkn4AzaudO1qgm8ZTneDY+wQ9TPvVwqpBexGXgPHjV0sssfhOc83A4T+xW57QLtVLODhRNb0/J7GnhidLD2zAKrcvSv7aJ/buXUCeuYauBwXmJQUvh1EBwdy0ZWEPiUTLifujfh0N/3w57O+RIs0dsCMrDlwPqlgIkHg1AjJ60zamYLfQEoQllNntg+4vAh63MUTqCKtILV/t/gyfyHnDFvuy5OUYAmsUSyotrljBZFvv8hL5IbvOmtH43apj/n5mqYEgaI56Yqk4rKdCBh7Ju5LL6SkfHu9KiCkf+eLutYEWXDedCSrEaIGRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:28:37 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:28:37 +0000
Date: Tue, 4 Jul 2023 11:24:55 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: John Fastabend <john.fastabend@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 12/20] xdp: Add checksum level hint
Message-ID: <ZKPlZ6Z8ni5+ZJCK@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-13-larysa.zaremba@intel.com>
 <64a331c338a5a_628d3208cb@john.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64a331c338a5a_628d3208cb@john.notmuch>
X-ClientProxiedBy: BE1P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::14) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BN9PR11MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c00aba-fd12-4052-88ea-08db7c710ac8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmIhP8sPOPWCvk4ZGEdQEOEVAYHQP83wMIbBecDJ1lZNIq5adAZTJPSwpIb/mAdJOtPm2eizVuTMPluJLTFXoQ0PXL9ln0z7jPZOiLrasAb2ST16pNp2FCJjmqpEfmnpo2hqk9hhwkg7fNRUEKe45o/ZSJMHQIeH3f8gt6hzNVf39lllebAlcM6dcOntgG5jgC1Wv8qe0qemYkVGUnZBzzH5ZMtYGpbV8Z+AAT1dhRZZHJttarNynojh1KS3qEl7UDsqf5c2DabaSkP0vJGwrRyr504rS+WJlDPgg5N+Avcqbv4WNCD9jHXM+DTcdUYqayKc97qxWwnRJW6MI2tpDEo4dCzzVNYnLnyf9vcAvWCYG6kQwOzu4XE0iObAcNJbcUKMn8XiQ5Du2Mxnxnvtzz9H2fiG7kARa6+0wiasUcvvk0afpKdS1FIuqGeetBkfHZtyebm8xBnFiAuh0eeYi3ZKf3KQAgU2RYR+0ZUCDvt3q16XuFxKHo/bx/fhRZeoqnjUI4WkbnRgifLPuCdLcP+fkJIgS5O0fviuGJ5jF1p+j28R3uLHKJDPOLHdPjgNqXfcvv+g6YbS95vuc0mTSOp+0S3x7yMR8qY7hMHuwBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(6512007)(82960400001)(6506007)(66476007)(316002)(38100700002)(4326008)(66946007)(66556008)(6916009)(33716001)(83380400001)(186003)(26005)(9686003)(478600001)(54906003)(2906002)(8936002)(8676002)(44832011)(5660300002)(7416002)(86362001)(6486002)(6666004)(41300700001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MI9nzHWfyCD4IN2viwsnf5rN7OuGhhVdtld6QUFYU2BVxZbwYAz5Rjri1r1D?=
 =?us-ascii?Q?hi0hqHmQXCODb0lA7118BeEmkTcqWpttyKA1tvqpscdZdyG9r19t01uC04gw?=
 =?us-ascii?Q?ENG/XQ8Y+GkADyIUuI3nDarvVM43QdvD+Y32bPoR4pJAWRt0x1fVzSAP6TK5?=
 =?us-ascii?Q?NfHQyrubTSF1Bpf9cc/hhYYrJCXkEuzbciC28KAfCkWKIVn/TrXlnzsBrHFN?=
 =?us-ascii?Q?ivAwsr8RAA9TKeCKi9azOUUdUV67s4zmFX5V5wlo1rpxXPHETgbWH7fIM2Pw?=
 =?us-ascii?Q?2YFuFIL0sV81CdwYbEZ4ZctSvaKwGjVyNALPXfUM5JVp80cESVXJje6xj23q?=
 =?us-ascii?Q?XiJR6yxnlSyG+/g0DfPU4nP8acLZ9nCQWYwVS4puYNJZSyImaHdlyUP6maEv?=
 =?us-ascii?Q?JKEM2xk/X9yYYaMFzXST+VwWMWPe+1Ure6aOphPOFzHivCj5lhQiYisibTMJ?=
 =?us-ascii?Q?j2ZHRs7G1zxSUJFHjQqYiVMnly5vHIgGMamMMW2POOToTGxVmXj9Ol1SYBQN?=
 =?us-ascii?Q?ZVAniw95qriSLkPVifGozq+I1fZX62evBITTTBxS8QF9ea4KnusjnECRwxLe?=
 =?us-ascii?Q?Ew+qmWiYtpi+OITb0+LokcaYcHGvhvNyq1crP0Vv/Gjqw+qSp0vnUMgS/NCI?=
 =?us-ascii?Q?kmU4Br9AFJRqfCYhpcMNSP8mOIY/zDjQGaSYgmoobs0W6IBGxbWw9b1sj2xO?=
 =?us-ascii?Q?d14Ru85YnueX9m2Nwet7Q8EYsnPUs6FHK9g4jlFlV97f4dhTr/ZnwdodUXP9?=
 =?us-ascii?Q?3eww+WSAL9+xWj/CFRn0XyOuyJTq2myFYEQkb8HxH1wzU55bTtIWeFvrr46m?=
 =?us-ascii?Q?zNYPK5CthqZIGqXiqs+DbQ5OGHjdrwOaJM0122Z7LWzBzLP2c70nlobwcIts?=
 =?us-ascii?Q?zp7KR/6dyaao/EnNa6swPcaeAd8ZyMn2qeoflpo+C7E9VZlTmEW9ozttHmr6?=
 =?us-ascii?Q?ww9R37dD3+KT2DHPScbD+CRWMxTP0AmBiT6NzPC8IpR6uGi7hNCYWQwpUii5?=
 =?us-ascii?Q?vvsfGwvM5MmityUE0jEnNKwHe0u0qtqug8VPp75zo57/0wzABKBpohACETkz?=
 =?us-ascii?Q?1bYQbPN4Nx8SHCOxkkGeWlkkNBTWApIt6wwgcJKB4+git65Kshnje7rBa5v6?=
 =?us-ascii?Q?hdiCtqlWyhaqgSntjE5cykuMKjkBUwJtyP21p3uSXQNJpbRLaPTPTQB5cfIx?=
 =?us-ascii?Q?zpr7IEdJ/gCuCrp1a6F/rkZS9VP/tQZ/lXNRW7ojrzJoJPZwtbasNUgRpDLf?=
 =?us-ascii?Q?yKVn4+VlyQiSoORpepw/m6z8Yrm9ek4MR4aqAasyXzQhtBMcYW08FB4yJMyN?=
 =?us-ascii?Q?BwfNTwfrxMwxlllet3l+uOYHEOpjumlNaJ5PIEk0QBFkvDOcywzQfsR8Vd/9?=
 =?us-ascii?Q?IW2Rn8Ha69aOL7TdKRLoKI+RHDU8pFCqkgUPtTdXYSu9m2KbS139kqiT9Bsi?=
 =?us-ascii?Q?wz4Cah+EBIRC4OBZ9vTRIzOwTc0NS4urhFLgtZJGHinxFQjApaWk4eaqjfG6?=
 =?us-ascii?Q?LVGQ7wZHcjkORLSR8sjw+zSUyGSyW0eA8IX5t3I041rlepI1NUg0GpQnbECq?=
 =?us-ascii?Q?XPlbdYVAXZmXxdBi/5GLVMDNt8D3hWYavBOlmcXGBm33cWKEeymvq62hwxbJ?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c00aba-fd12-4052-88ea-08db7c710ac8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:28:36.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtGJkgXbTeUIBCmmq+IP73qJs3lOAscVTi4MSBwbU+kMVdXlIsx6EIj4LRyBIMvmQCJujebKYjnhisReI0t/UusBG1OSVa54eJ4BB8c2vI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 01:38:27PM -0700, John Fastabend wrote:
> Larysa Zaremba wrote:
> > Implement functionality that enables drivers to expose to XDP code,
> > whether checksums was checked and on what level.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  Documentation/networking/xdp-rx-metadata.rst |  3 +++
> >  include/linux/netdevice.h                    |  1 +
> >  include/net/xdp.h                            |  2 ++
> >  kernel/bpf/offload.c                         |  2 ++
> >  net/core/xdp.c                               | 21 ++++++++++++++++++++
> >  5 files changed, 29 insertions(+)
> > 
> > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > index ea6dd79a21d3..4ec6ddfd2a52 100644
> > --- a/Documentation/networking/xdp-rx-metadata.rst
> > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
> >  .. kernel-doc:: net/core/xdp.c
> >     :identifiers: bpf_xdp_metadata_rx_vlan_tag
> >  
> > +.. kernel-doc:: net/core/xdp.c
> > +   :identifiers: bpf_xdp_metadata_rx_csum_lvl
> > +
> >  An XDP program can use these kfuncs to read the metadata into stack
> >  variables for its own consumption. Or, to pass the metadata on to other
> >  consumers, an XDP program can store it into the metadata area carried
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 4fa4380e6d89..569563687172 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1660,6 +1660,7 @@ struct xdp_metadata_ops {
> >  			       enum xdp_rss_hash_type *rss_type);
> >  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tag,
> >  				   __be16 *vlan_proto);
> > +	int	(*xmo_rx_csum_lvl)(const struct xdp_md *ctx, u8 *csum_level);
> >  };
> >  
> >  /**
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 89c58f56ffc6..61ed38fa79d1 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> >  			   bpf_xdp_metadata_rx_hash) \
> >  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> >  			   bpf_xdp_metadata_rx_vlan_tag) \
> > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM_LVL, \
> > +			   bpf_xdp_metadata_rx_csum_lvl) \
> >  
> >  enum {
> >  #define XDP_METADATA_KFUNC(name, _) name,
> > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > index 986e7becfd42..a133fb775f49 100644
> > --- a/kernel/bpf/offload.c
> > +++ b/kernel/bpf/offload.c
> > @@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
> >  		p = ops->xmo_rx_hash;
> >  	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
> >  		p = ops->xmo_rx_vlan_tag;
> > +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM_LVL))
> > +		p = ops->xmo_rx_csum_lvl;
> >  out:
> >  	up_read(&bpf_devs_lock);
> >  
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index f6262c90e45f..c666d3e0a26c 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -758,6 +758,27 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +/**
> > + * bpf_xdp_metadata_rx_csum_lvl - Get depth at which HW has checked the checksum.
> > + * @ctx: XDP context pointer.
> > + * @csum_level: Return value pointer.
> > + *
> > + * In case of success, csum_level contains depth of the last verified checksum.
> > + * If only the outermost checksum was verified, csum_level is 0, if both
> > + * encapsulation and inner transport checksums were verified, csum_level is 1,
> > + * and so on.
> > + * For more details, refer to csum_level field in sk_buff.
> > + *
> > + * Return:
> > + * * Returns 0 on success or ``-errno`` on error.
> > + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> > + * * ``-ENODATA``    : Checksum was not validated
> > + */
> > +__bpf_kfunc int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
> 
> Istead of ENODATA should we return what would be put in the ip_summed field
> CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}? Then sig would be,
> 
>  bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *type, u8 *lvl);
> 
> or something like that? Or is the thought that its not really necessary?
> I don't have a strong preference but figured it was worth asking.
>

I see no value in returning CHECKSUM_COMPLETE without the actual checksum value. 
Same with CHECKSUM_PARTIAL and csum_start. Returning those values too would 
overcomplicate the function signature.
 
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> >  __diag_pop();
> >  
> >  BTF_SET8_START(xdp_metadata_kfunc_ids)
> > -- 
> > 2.41.0
> > 

