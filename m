Return-Path: <bpf+bounces-3941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA10746BD2
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3385C280E07
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 08:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D386E2112;
	Tue,  4 Jul 2023 08:26:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4E186C;
	Tue,  4 Jul 2023 08:26:59 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAB299;
	Tue,  4 Jul 2023 01:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688459217; x=1719995217;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MhQbmXS2q/S3dYZUm6KC5lFig4yI0wa9xqzQrmsPcpY=;
  b=EZnHWDiirhiG+k6mSZ7FRKFm0yGfXAGEHABQdwVmHcszcn8qu3Kilm09
   08+iLmhgArK5MZx7QBgrw6q4wZ8aQ6S4Vg94VeakkRO4xLE84+r3rUQCl
   DBU1/u+h+gkTLzb8luujVrPM89MMCco5c9OltIKAyg8eTvasPlvfjYBrn
   tyfCatdtqlArsIHTDee5Zu3AxFfzTpoEN70dNfhoO/NdoCiun6xevQz5K
   wo/vhEbNr/brywHxbD6408W8WhRwqDNhqqrGTvODmB1Es3NStxuJEaq9t
   lRAcfOLr74MOOb1ZODeS87noA92sAoYFsrFT/QGovMSl8O3hpI4ava8b/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366551695"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="366551695"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 01:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="712817814"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="712817814"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 04 Jul 2023 01:26:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 01:26:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 01:26:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 01:26:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 01:26:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJQ6c7wAEBaOx45+zFapI+qLcCrQQVMDxO36Xj90zRLRoVpIpqM3DPrAGSf7BZpd8JiEkMdjBlbrKi+5WLb2yofJ3zdGTi1xDU57qJRnaslIKDUAwm2xF0cWrG7XYX0thvyLVl0aCPZT7c1jJOQNP9SEj/bQSvadiCqHio3CY9E+88Y4KPSQOuw2V15XjICpqYlgaFOafaeivCZ1FlYGMySugY4KAp+AgkFhcqhzq2NmB9Y11vEJkPZ2nHwqkiKnO44IiB7VjSR9ih/B6HZOixIXFsS32sYOqb//N1K8XsLS0gguuwWx9WiPIxzKK9ZJobKoGTH+0r4BxblTN7TgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG6B9DhOali1wWss2Czhv1kd0Kr9P+2dU550ekBx7OM=;
 b=lB0VQ0fxyjd8vkfw3lZ59cw5na1/EpNEUPVcVwWkQTL8uA3Gx3ySCpXHDj15ZLl3FBBnvFJbRdQKn/USn+Si5BX+IAluTq3UvECLeI6NuoCLYTqnBTrM1NujUpfZCkVLIARhgIxYtpMih39FdGzeCFLerTa5LNwHpUluNnCVVlP8LqgBbhsUeBGqzySIF4hYB8ph/I3aFAZtRdiiZHaXY/0tvx/MOLr9KENo/plOOePG8VifSaDjWiT7y4Kw84FrFOX0nsoACKohB2DwLQGqmDn7187emntObK8vRBkEUJJirwSuNTrM8qybziC3dHQ7iMH6yXtIgTFoqiREYTzfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:26:45 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:26:45 +0000
Date: Tue, 4 Jul 2023 10:23:05 +0200
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
Subject: Re: [PATCH bpf-next v2 09/20] xdp: Add VLAN tag hint
Message-ID: <ZKPW6azl0Ak27wSO@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-10-larysa.zaremba@intel.com>
 <64a32c661648e_628d32085f@john.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64a32c661648e_628d32085f@john.notmuch>
X-ClientProxiedBy: BE0P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::14) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SN7PR11MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: d359de2d-2c87-431b-682c-08db7c6866e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPw4Lc7F5KFcQgY8bf/xNIu/0kp+v58nDgKrvFbAlSZykSSRbxWVsrWIo56n1MjSBw4zHPw4UrYLrg3fhHTSgHpR3ItHfeNXO8HlS+7JJ+ol94KUFcqy3evpUV5DfZ7Tvw1AulE2XqlpXdM20XYCNQZJtxTTAXHxNh+jAHgWEmS76c7/OQgL0b5z8jLaK6os6T3XnZ0/2Csy0UfMrxm+oDvx09wjLCPp1cMX2rmvYKhdxcBAkm3XqOL4SV5fD4K5t9HLRh2S7wS2Ye7xMsZHtiDIIcDSVYTeanP/ycPNYkG+4YuNtl9ugYfHvTfS1qsJ2BhPEuv27wza6H69AFODva8SLIheLy/d8Z7Is4Zb1e7jp0iFTY3MyREd45CmT2QKEgU85hHrn5QVwGP/7/BG9LKUv+FX/k7PmHxib0hiGLAQTBQ+eoMIy6UwS8WlZxdVFvRJpuxA+Y7WZXYuyu7z3zEV8+eg4HSwN049bcKxsq90+5b+XwKWXbrnms96x5jNvbP9fWJJ7r+EsUNx55lJlQwcrgIJK4O1ez7OrpI0ZhHXxM99s/2umHCCwGVPBpoV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(82960400001)(6506007)(4326008)(6512007)(316002)(66946007)(66556008)(66476007)(38100700002)(6916009)(33716001)(83380400001)(186003)(26005)(9686003)(478600001)(8676002)(54906003)(8936002)(44832011)(2906002)(6486002)(7416002)(5660300002)(86362001)(41300700001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x/wOL8LU+ag2gTJPnwEPoICjLj9ac5Eom2SMdA/OrLXRo7uJ5OjXubJC94eZ?=
 =?us-ascii?Q?Ju6gBryD07QXs5ErSCHCIy45pnFDT/GMmJqmilflLZHtqMMJBPn63+pN98d1?=
 =?us-ascii?Q?jD+qNpgqfjrO8P9zroByIJRLtDNGsdUt54qro1XzE4S0+EhMjd0bnScks/vH?=
 =?us-ascii?Q?tWEeqL+L65LMyBuHDyRAfCyqVcMJM1Y89MXdHMqPJ7qyk8JPjYpDZfsp/Yfn?=
 =?us-ascii?Q?9oma5IBZEiIVR9ewLKxbuGIaGWUX7MO/Mml9iCTVsAL55/o0NdoMDu6RYXNv?=
 =?us-ascii?Q?c90GPTUm2tQqP6QXLWWpsLKPo89KjMLRG9sbRoCu/fBsAY3GGQ82h8I5fVZt?=
 =?us-ascii?Q?NNLdWkvVyAJ6e9O6QFaXIADLNVg9w8Y9jv75tOPt3cgFVZ76HgZSYMdkrcqS?=
 =?us-ascii?Q?v006kHDQ0wY0yC3lfZzHzZdh0NGDffjtipo/tuGJ0Z88sPxSn97UUhriTx27?=
 =?us-ascii?Q?M+ZPwHt0Tn4Mw1zpxKv0YAuuzSh7Sb+rdUONgb19uDksfxeipftoY+637zH1?=
 =?us-ascii?Q?OFWz1t8/810koFDeUWkbfEHI/uSwX9SnTuj0rLB0WN0jEYf7rYEulFREnt04?=
 =?us-ascii?Q?0zLWSwT/1fxMJkV39eFYzxcDmDFu0i3vE/McZENGmB1+/QxPCJlPKfOk5598?=
 =?us-ascii?Q?kjpnGArZ3/V/Us9f3RQ9JRgg5inxcKmJ900D0WCuYVLaY0cjEdB4d7GuxYIT?=
 =?us-ascii?Q?M1aqAkZ9/ehEwlyz2bYSZJr8IUe+nzXFQPW72IgOEBG337j7iTIeApMaZUvl?=
 =?us-ascii?Q?mAbITwey9Pt78iw4sm8Tqoto2uwpvDLpVVTPF3/hQQFr25AcF1dtK8/ZMdRd?=
 =?us-ascii?Q?RmGU2xmRUYdICpTHeL9xRkCfmhDr9FrlReaM45cOLI3oJwUTs1mWrnm1WiYc?=
 =?us-ascii?Q?Q7qhZpJyL4T1CB8TyJw9T3010o4b3uQ1FYAE3/zhjPCSTPx9RJGB/WcFotHp?=
 =?us-ascii?Q?gneSNTZNcqghSfti1mq/v/Zf3W7uN4JWp7tAF4JMRGGG6mYdU1bejC/BioD3?=
 =?us-ascii?Q?ZkOJL3CoS07aq+/c8e719WoBL7bsEY3VLvV+D4XTP6XZJ5Ytb6wuZncpgdfB?=
 =?us-ascii?Q?CyjgdfoxZ9cz32pdUM1YAH96I8rwhWgUNxrmRhi3GCCKPCsH8ZQzNz0bf1wO?=
 =?us-ascii?Q?ikgCZUm9tFmr4p3B2a3zpPpK5hm2Ge44wCYrPXQu3zGsTqZeh3QdhEQbAQXs?=
 =?us-ascii?Q?CQKcmtHAAaUi+Vwkc83YXkrafZ/qMHTFfArfJlwtb6sIOPfmKBx/7BPO8Vaw?=
 =?us-ascii?Q?qG77L3FBFH8ZJgyA7Xt3O/hXjLD5zZLgv3pCSzFF4ugll134W+L1CBdMN3+E?=
 =?us-ascii?Q?dVc54etKT7mOhvcT8TIXnkk0OfooIDxAFsgKa44A/Z2vdT7MhhLipDV76lT7?=
 =?us-ascii?Q?DI1H2YPXbjuHS012GleW9wMkqbbRE2qxAVIHU71aBIgetNgJ70xM9i6Bbquv?=
 =?us-ascii?Q?ygSy7fwANlczx93D00Com3Z2OCWbF1GMx2I2wAcD7Af3ZnhxHcGCLN9kKDFQ?=
 =?us-ascii?Q?csFUFdVDegIWRyih71ki1yAfacC7O3u8lQZMn1rDHbvO7uBPSZ8PEETEHRwh?=
 =?us-ascii?Q?De9QwtV0+R3SfX7wfifSqOD5AyF4EdTN2iKu+NSQKyYrWYdfCdAzdq9/V6mE?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d359de2d-2c87-431b-682c-08db7c6866e3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 08:26:44.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1huj2ILXcetX5dA2A7lPryM7N3B1Zn2sAWYMhTokmQGat08FnSyLF7YUiHmTKn63l8k9RuLWivL5sJ6rJbHVzz4Mc5KnaUgekMryiszUK9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 01:15:34PM -0700, John Fastabend wrote:
> Larysa Zaremba wrote:
> > Implement functionality that enables drivers to expose VLAN tag
> > to XDP code.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  Documentation/networking/xdp-rx-metadata.rst |  8 +++++++-
> >  include/linux/netdevice.h                    |  2 ++
> >  include/net/xdp.h                            |  2 ++
> >  kernel/bpf/offload.c                         |  2 ++
> >  net/core/xdp.c                               | 20 ++++++++++++++++++++
> >  5 files changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > index 25ce72af81c2..ea6dd79a21d3 100644
> > --- a/Documentation/networking/xdp-rx-metadata.rst
> > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > @@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
> >  metadata is supported, this set will grow:
> >  
> >  .. kernel-doc:: net/core/xdp.c
> > -   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
> > +   :identifiers: bpf_xdp_metadata_rx_timestamp
> > +
> > +.. kernel-doc:: net/core/xdp.c
> > +   :identifiers: bpf_xdp_metadata_rx_hash
> > +
> > +.. kernel-doc:: net/core/xdp.c
> > +   :identifiers: bpf_xdp_metadata_rx_vlan_tag
> >  
> >  An XDP program can use these kfuncs to read the metadata into stack
> >  variables for its own consumption. Or, to pass the metadata on to other
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index b828c7a75be2..4fa4380e6d89 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1658,6 +1658,8 @@ struct xdp_metadata_ops {
> >  	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
> >  	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
> >  			       enum xdp_rss_hash_type *rss_type);
> > +	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tag,
> > +				   __be16 *vlan_proto);
> >  };
> >  
> >  /**
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 6381560efae2..89c58f56ffc6 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -389,6 +389,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> >  			   bpf_xdp_metadata_rx_timestamp) \
> >  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
> >  			   bpf_xdp_metadata_rx_hash) \
> > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> > +			   bpf_xdp_metadata_rx_vlan_tag) \
> >  
> >  enum {
> >  #define XDP_METADATA_KFUNC(name, _) name,
> > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > index 8a26cd8814c1..986e7becfd42 100644
> > --- a/kernel/bpf/offload.c
> > +++ b/kernel/bpf/offload.c
> > @@ -848,6 +848,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
> >  		p = ops->xmo_rx_timestamp;
> >  	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
> >  		p = ops->xmo_rx_hash;
> > +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
> > +		p = ops->xmo_rx_vlan_tag;
> >  out:
> >  	up_read(&bpf_devs_lock);
> >  
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 41e5ca8643ec..f6262c90e45f 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -738,6 +738,26 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +/**
> > + * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag with protocol
> > + * @ctx: XDP context pointer.
> > + * @vlan_tag: Destination pointer for VLAN tag
> > + * @vlan_proto: Destination pointer for VLAN protocol identifier in network byte order.
> > + *
> > + * In case of success, vlan_tag contains VLAN tag, including 12 least significant bytes
> > + * containing VLAN ID, vlan_proto contains protocol identifier.
> 
> Above is a bit confusing to me at least.
> 
> The vlan tag would be both the 16bit TPID and 16bit TCI. What fields
> are to be included here? The VlanID or the full 16bit TCI meaning the
> PCP+DEI+VID?

It contains PCP+DEI+VID, in patch 16 ("selftests/bpf: Add flags and new hints to 
xdp_hw_metadata") this is more clear, because the tag is parsed.

What about rephrasing it this way:

In case of success, vlan_proto contains VLAN protocol identifier (TPID), 
vlan_tag contains the remaining 16 bits of a 802.1Q tag (PCP+DEI+VID).

> I think by "including 12 least significant bytes" you
> mean bits,

Yes, my bad.

> but also not clear about those 4 other bits.
> 
> I can likely figure it out in next patches from implementation but
> would be nice to clean up docs.
> 
> > + *
> > + * Return:
> > + * * Returns 0 on success or ``-errno`` on error.
> > + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> > + * * ``-ENODATA``    : VLAN tag was not stripped or is not available
> > + */
> > +__bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tag,
> > +					     __be16 *vlan_proto)
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
> 
> 
> 

