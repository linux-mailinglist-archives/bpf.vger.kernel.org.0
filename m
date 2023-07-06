Return-Path: <bpf+bounces-4218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5423C74993D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F323281293
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B978826;
	Thu,  6 Jul 2023 10:19:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62A185A;
	Thu,  6 Jul 2023 10:19:33 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9E4DD;
	Thu,  6 Jul 2023 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688638772; x=1720174772;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9/QEZI2y9O4Vl+HSROat9W9EqgqLUfzKP2RC0K5q7SM=;
  b=FqVVWbbYM+aTTXqNGH6+XaadIe5KmQlXdAp/lDW4KvdGrbFFewnDjPi3
   5AHQ7LLnjCU8EbbGawNd4ZPW2zv1I6vrK2iFpTr0bfqgH4+jRdJOzEfnG
   EThH81DJxUkeJGArRZ4Ujtvy9v7jp5i4jxuxxLmBvf6UlmCCWoQ02MMGz
   0aI2lGn5v/hrdFVNHVAnixwh4NdipFIrL6nF22nfxJOPBs25dFuzLAGpH
   PSHlqzsdwlQRxLWvx6CPjaoD4FUWP+CUQ3itvXhJzXtV6+79xUuZlBygO
   sp1NQh5l+rSd1IIGOIm2NHD3yp+/jERdtJvEAx2bzKNs4kx/AlSQpLyFD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="348353346"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="348353346"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 03:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="966170309"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="966170309"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jul 2023 03:19:30 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 03:19:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 03:19:30 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 03:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNvSGJVB75ArPd02MAFt10UdAV1DpfWaAwMbpvxGlXII1rMWGAhn1Din7eMw4b5FPbo6vWIYjK0LAz2ckM1l5yLWZAS5MB5PKSp2kFS8wzvm6TxZ2g+6jvZ7WRHMRIeoZy4llyNenmOBPsJDfuMxkctIVwzu2DHbTdRY8cPyP/69/h/vN2iPqYGru6PYDYm4gpbtmnmE1Z2I9HdjgDrVTYZv15CI5s1UC4iKUT2d9MiCqBvQQ1uJk9s+7+Rsq8/o0deDOvbwtc+VWVvrXEo0l8Gv/XqgfUTA37EVLm7jckR/DHV/fdioBoAgaiQa76cAXhKeMsnJvf3ig3pvEFgLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeslJWh/cP5YQQTrRgheePsUZrAxOENz897CjqPpVBw=;
 b=YcBLPCm7K7GOgMnPr9sTOM8slFty2QeXIp2YyfSgRI7LRJixhPoBEBfXkDAe1I6Hdb1CKPV4aJeTWxFmhDqdfnLr75sf2nwphY2dC16zuEz4P+gIAbQ2l8oSzkS4lzCdpxbRT3YMGI5v16ni3nCJxeD5Un9cF234cmN1EbTbq9NRqWsK4KDbal2oeP3dyNljfALKL2Fj6aU5QhbmzRUufbP/KTqbg5ELXvyDbO5DOYopbSF4lt9lvBrG3g5zLWUKvhkSIYKP9MPAdm++Hd9GwJd/x2wsxXYPt/9bsOFatnP4psq87bKj0MqqXpEadzIMXeI06OKv754p0fEp+jCztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB6548.namprd11.prod.outlook.com (2603:10b6:510:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:19:20 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:19:20 +0000
Date: Thu, 6 Jul 2023 12:15:25 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
CC: Stanislav Fomichev <sdf@google.com>, <brouer@redhat.com>,
	<bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 17/20] veth: Implement VLAN tag and checksum
 level XDP hint
Message-ID: <ZKaUPb87TPWqPiWm@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-18-larysa.zaremba@intel.com>
 <ZKWnbfTXp/vyHYUU@google.com>
 <72f31e46-55f7-1e09-bf69-9ebde6f9e732@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <72f31e46-55f7-1e09-bf69-9ebde6f9e732@redhat.com>
X-ClientProxiedBy: BE1P281CA0375.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::9) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 296f5560-fe34-47fb-91ee-08db7e0a7623
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1L1JHw8Q2z+KqiOGInP8upTjElbJeK0jrCOMhOkG6oARE7XgrDvxwRGPEa0QEk9GgfPPN85tna9LXsw4hUz4clW9rWZQtc8Q0Njr1L5lYiwyaIRsIcSeSWf7hAiks2oAIWBELvLHsKDhTdFcdVx2+imdR27gy/IsKnpVP4iEOPTwM2FCLIxtO2qYvKINHnAZ22LXmkTXLSyvy9IumrGwLlgofkE8ikCBVtt7Clb+s9fyJOfMTLoiwquy2OQckR3YliqBcu3lSm6Ac/Q5cRx+XHm0aSE60qYzH3wUJFzyl1YbEZaClpxKUQGtUYbpQmCEDvZ0sa/V4Xp0nPDjwZCBaBgLRZrGlr8uHVhhrYFKLt5KgG/qoZWGcplClztpbq7E/BrY0QQGn4trclJ6GhouC4HcyyWjbJ4/L58d93N/eb0DOJKMkPyPOrePsDR8af+Sye2sgVZveukvqoPMAiUlMHIz8r6PMSMYXFMzELvCk8T+gmUFSl4nlZnIgACEUy1qaX5F9IuhYibVMZVXsqky97HqqQxf6DuXO6OZNz0+bw1pQALPkuUSvqJVjDB1ly42
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(83380400001)(82960400001)(38100700002)(86362001)(478600001)(33716001)(54906003)(6512007)(6486002)(8676002)(8936002)(5660300002)(44832011)(7416002)(316002)(2906002)(41300700001)(6916009)(4326008)(66946007)(66556008)(66476007)(186003)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCibBZUxDyW41PfmWFkEh6nbAXaOsZhpJj9crsuEmuQCY4EQhHZ3GkGrUmAR?=
 =?us-ascii?Q?1QZLb/HqAYQcGS1gCLFhLp039OKGsyoc0zfd7FQU9mW4CmgpKCCKxPxJ5mO5?=
 =?us-ascii?Q?n3slg5qiTlMoJJXLyC4SNSxSYHm1Q5A7Hq2/BI+OBUXATCyAHOo+UY294yxR?=
 =?us-ascii?Q?gEHrn/SuiRHl6FJFayGWRKEjnnTTVNjtbLyoun3v1aTsL3UAsmsxDCE5ieMT?=
 =?us-ascii?Q?qw6A6rCQmKLBt1fHJUivl7we2dU4KHoPBBR0LBtaCJj74kIvTf3H52SlL6QQ?=
 =?us-ascii?Q?aNgXi9DiXSdiz2ywn0sRPOpAQHs48N8yndZVS8ScIlTAAZNNgDtYarcwynWt?=
 =?us-ascii?Q?aWm8UkqqWIwf5lyS6u7F/TNMxSelcvZ7jDGqs00sEu9m+0bn3Q5vR7cK5qaw?=
 =?us-ascii?Q?id/qYWJ+2vJXsBKkmsb0bq4WW66eAfSUZOr5UzSP14TtKXriD/8ksZIcVpxv?=
 =?us-ascii?Q?SC60OQS/ZW2jCXk1xDQWLUGPpMcZpCJRxeBWeEk1wFOObxDhB8+I/wHdY0nY?=
 =?us-ascii?Q?9qcrknZI22+uk/9wAHqICEcQVN/xBT26W1n9G9VA0zbDU0tnGzRrEpm3RVlz?=
 =?us-ascii?Q?VKMQB6k6IwiI17jh4zRJmBNKfsV5vWkopO5ywSeiLUfB4be410bd/DzJqf5/?=
 =?us-ascii?Q?LT7V7YlyWkrLkIQsUR6/xDbz5FZxxsKcmrQKUh4M0q3W0TqPUBBnjIJknRdw?=
 =?us-ascii?Q?fkK3yhXfR9hKuKVSfsxxOOTG5ZI45jv8idAp2J6DIDxKmsB5TKTOIMMKXkEy?=
 =?us-ascii?Q?eWpvCcDC3ycOybLpJEUtsvpvYLMDNRI92gICdGEC0xY9QkTjm/00vYBZlYut?=
 =?us-ascii?Q?UJdk96f+uC1eKgrWOh6Ihy3ZoRmm5ZZQza5emE4R+Css1h6ity+mVCUOARYi?=
 =?us-ascii?Q?7EdnctT+LAR/4CKq2lY0Ji2McfKTm5t/20VhEbwwUKlwMqb4OP2DeH8GxqX9?=
 =?us-ascii?Q?VAIBzH3n/5DJtZqvwKjVFcD6nfPCxh4T+Dy0lofPkj4YirBF5YGJWTCPZBrc?=
 =?us-ascii?Q?H4/WVKT8b9Mp4YpylGLdngnWjW50nczVxVwQX3+moy4nxcA3T9OwRtx2AM85?=
 =?us-ascii?Q?qi7bLrOKKFbtZmJoGzZXnCgM4sb6Q8YLQHQHnOtFw2KJiPfH4hGrPd5LX2xl?=
 =?us-ascii?Q?VGqiXgNs2NA+KfMEpazvNbeSMqFMEiWwvHsa4Pr9Zp2P+0ZZkIf+9IVw5IfG?=
 =?us-ascii?Q?0HoGl/H/HlpxBdI9JTY/9e+iCq90j4MkCzs6uLYDkJBijDJUnu1qRUf7X6D8?=
 =?us-ascii?Q?+5p+N57UYJFdJQ3hdVygaY8EmqLXuowpfDdfzfL36AQisYf+EuXsoRxQuA/B?=
 =?us-ascii?Q?mhOQsHyUtL1mUV1Wmw5LDSjVtNAtcxVtMTM/75voOCSp1Ww6V1LoBbqtSOzq?=
 =?us-ascii?Q?xTZiQcuDxNILB/Ix+rF5EtfxjrlUMAp/u/jxpT0WixfjHFcrCXx31bMIvJ44?=
 =?us-ascii?Q?qj5e4pRkyTCjBxP3zX5J4DzyG8KnJ1emjqTEM/Ii23Vr/q+cuW3KibUKf7lv?=
 =?us-ascii?Q?nush0mZNiK4UnMuEzjJWX5cShw43HSndUF9Hd5DYX6NjnwUTEbeWAcSGhm69?=
 =?us-ascii?Q?csSjWU3AwpybVUczwjGPDMDV3s8OO4gTd7PSf4h7QAQhirLkKXdm639LxK3l?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 296f5560-fe34-47fb-91ee-08db7e0a7623
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:19:20.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRXQ6NlzhRn+MEsZKSXnfkwBhgI9Gk7lOZJdA79SOhjn9Yb5xypgBV3uMnT+1Z08ok+y8XoHUNsGtAoeHbCypC7TF7Sw/LLE677bPYgWB2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 11:57:06AM +0200, Jesper Dangaard Brouer wrote:
> 
> On 05/07/2023 19.25, Stanislav Fomichev wrote:
> > On 07/03, Larysa Zaremba wrote:
> > > In order to test VLAN tag and checksum level XDP hints in
> > > hardware-independent selfttests, implement newly added XDP hints in veth
> > > driver.
> > > 
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >   drivers/net/veth.c | 40 ++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 40 insertions(+)
> > > 
> > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > index 614f3e3efab0..a7f2b679551d 100644
> > > --- a/drivers/net/veth.c
> > > +++ b/drivers/net/veth.c
> > > @@ -1732,6 +1732,44 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> > >   	return 0;
> > >   }
> > > +static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tag,
> > > +				__be16 *vlan_proto)
> > > +{
> > > +	struct veth_xdp_buff *_ctx = (void *)ctx;
> > > +	struct sk_buff *skb = _ctx->skb;
> > > +	int err;
> > > +
> > > +	if (!skb)
> > > +		return -ENODATA;
> > > +
> > 
> > [..]
> > 
> > > +	err = __vlan_hwaccel_get_tag(skb, vlan_tag);
> > 
> > We probably need to open code __vlan_hwaccel_get_tag here. Because it
> > returns -EINVAL on !skb_vlan_tag_present where the expectation, for us,
> > I'm assuming is -ENODATA?
> > 
> 
> Looking at in-tree users of __vlan_hwaccel_get_tag(), they don't use the
> err value for anything.  Thus, we can just change
> __vlan_hwaccel_get_tag() to return -ENODATA instead of -EINVAL.  (And
> also remember __vlan_get_tag() adjustmment).
>

Seems like a good idea, will include those changes it in v3.
 
> 
> $ git diff
> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
> index 6ba71957851e..fb35d7dd77a2 100644
> --- a/include/linux/if_vlan.h
> +++ b/include/linux/if_vlan.h
> @@ -540,7 +540,7 @@ static inline int __vlan_get_tag(const struct sk_buff
> *skb, u16 *vlan_tci)
>         struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
> 
>         if (!eth_type_vlan(veth->h_vlan_proto))
> -               return -EINVAL;
> +               return -ENODATA;
> 
>         *vlan_tci = ntohs(veth->h_vlan_TCI);
>         return 0;
> @@ -561,7 +561,7 @@ static inline int __vlan_hwaccel_get_tag(const struct
> sk_buff *skb,
>                 return 0;
>         } else {
>                 *vlan_tci = 0;
> -               return -EINVAL;
> +               return -ENODATA;
>         }
>  }
> 
> 
> 
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	*vlan_proto = skb->vlan_proto;
> > > +	return err;
> > > +}
> > > +
> > > +static int veth_xdp_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
> > > +{
> > > +	struct veth_xdp_buff *_ctx = (void *)ctx;
> > > +	struct sk_buff *skb = _ctx->skb;
> > > +
> > > +	if (!skb)
> > > +		return -ENODATA;
> > > +
> > > +	if (skb->ip_summed == CHECKSUM_UNNECESSARY)
> > > +		*csum_level = skb->csum_level;
> > > +	else if (skb->ip_summed == CHECKSUM_PARTIAL &&
> > > +		 skb_checksum_start_offset(skb) == skb_transport_offset(skb) ||
> > > +		 skb->csum_valid)
> > > +		*csum_level = 0;
> > > +	else
> > > +		return -ENODATA;
> > > +
> > > +	return 0;
> > > +}
> > > +
> [...]
> 

