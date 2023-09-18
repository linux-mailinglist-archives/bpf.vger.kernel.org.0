Return-Path: <bpf+bounces-10305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE09E7A4E1F
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95F21C21526
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A6821A0A;
	Mon, 18 Sep 2023 16:05:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD16210F9;
	Mon, 18 Sep 2023 16:05:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F4A49DB;
	Mon, 18 Sep 2023 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053157; x=1726589157;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9/GeD4gpWzs4SHp+vam6+XgnFVaqqPSUVubWAwhLXt8=;
  b=DHW0sEQqmy0xlh93hRYpDE0eaXTh5SKphHcpo5tynZMUnYwh1j9CwAQi
   ViGD42YeXpbLdjTc4ZAr8YWBZPZNgVd0C+z4z3rEuZ7TEAzZqj4tkdfoT
   UZkG583pPFnYrhY3Ife3JK1MS6bqyO0jYfzCQ2hztaCEPUXLi1gO9mnQK
   Kk0yBh/OFpPeUtZnFldqRJwmTMnHnTrOksuRQuuFbfp/e6joVt9IIbbF+
   lJCF/XP8GP4CQAkrjqQN3DZMv/oRPyvr87x/9CZ8E+tyoe8uaw48RXDVM
   zznFjWKMYD1oBljvPqfgNHQqar6tiKr8g53Ze71hiDZErFdccs9+ryMJR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="443739942"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="443739942"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 07:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811367388"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811367388"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 07:13:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 07:13:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 07:13:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 07:13:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly1V3GzwnKbtXqhOGMKoBPyZwCTarV6bpPKJpdfU7Qt24L1o8FfAwr+dMQqLqB52Gy0CwDAV1UxmvBsHngD0V+WZyWD3fLZs7+jUPES/xg/EPHOpdOLX2jpISgYiedjyfBF1DPRz7tvDJ5iPw6H4D8pn5Abkv41yBFN9Xo2dD6NHv7v+wvyR7q7tY0LLBYPddIaZWpIfKeeE+Aru1DL7QK9uUbiySgwLf5wee8qroqX5dwf7PE+WSlvHx6YebOQ+OtewF4Eqqde0coi1slCwRwbMo+HkNEr7813f5JFDmBUKuN2tpMY6QOf40FBx8wolEcvbBuUK3587MkhLuS4rcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHveZvL/S8pQ/gYa0N3/zPn/VP++oJK5ADBBhRbv2PI=;
 b=ADmhFwFCdS9u2w+7JuUqr/dz4wQi71d3dvRUTaylfWsKwoJznsIsit0GEbGpANJQMBUDc9eb22JJTP4qhd/siVclTdFbR2V9GSlQFNIBTpPszMxt18/1n1eJuWAUjc5fjNLSP5Z54cxCDYzBrniaA+oJn+SoGRDtxhwMr/QVxrM1DKR1fjhoZD0v5cJ9Y8k3BbtognUs6Q25gBEu42uuClaJy3Uvgf2eq0ur5AAtUdeEdUzKQsejiH9mv0fx98yW5cidUj4aBfpzPuD7MxtFp5oKNweEHN6OnmuwEMGMIpPbX35+0yVRLybEc1gbOvcRhCukVBm+h50mN2FxY0eivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BL1PR11MB5510.namprd11.prod.outlook.com (2603:10b6:208:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 14:13:33 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 14:13:33 +0000
Date: Mon, 18 Sep 2023 16:07:14 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [xdp-hints] [RFC bpf-next 10/23] ice: Implement VLAN tag hint
Message-ID: <ZQhZkiVn6KR2wJpK@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-11-larysa.zaremba@intel.com>
 <0abb29d7-fcad-c014-ea06-c7ec9460245e@intel.com>
 <ZQM0lzXSsseZTmOy@lincoln>
 <3f8f0fd8-b75c-5666-797b-315ebb632ca2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f8f0fd8-b75c-5666-797b-315ebb632ca2@intel.com>
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BL1PR11MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e40787-c19a-4edf-7bab-08dbb851710d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKbJn2E/277vs4wasIdiO6jajd1G5InZIgVKJCqa/y8GXBOlfnRYyVCz1zXrtstqhR85JPEKs5S8T/TLM+H5PcSlQlbi3PDT3E1wX1oVjT0An4OuVjF+A2OzH38q+FuwJkK5lTxnaYBj6LyKjFq0ZAoK2LCIZzPGrVD5FvDXwFdBmo92kymq4F0uncmvrJj6zueQnyelqZRmHUxqyyqXs2kv6jc9zUhZv75kz933dOR3EFE1YRKXWUdKrwnBDbi2ya5bXZhe8B5iMpYFfLtJ3mQhsCdvfON5h4O3G+ACuCWFU8VOF7lJCgPtSiW/fMDu1AjFswfcIakdJ50zc/M0cRXTbPVfvSQBaqddVwaCnlg68Y2eSiLBzA0FFwcvxukuXcz/bt7LpGWdC8BmRladC0IfCf2EPRvBVtIIF2m94r2dSoXOoBap4ayfCKYRtSaTuGR8uOoX+R4D9aaTRXE90j0H0OJwexUXCHfq5Ixiu05frzU+ISH40UiYOC501gWdifNyXKsqg0pN+ehR3YJlaAP1lZY29Eel3jPP4Ag3kvsnVJD0N01lQRmZMPljxA+x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199024)(1800799009)(186009)(6506007)(6486002)(66946007)(66556008)(66476007)(54906003)(44832011)(6512007)(9686003)(316002)(6636002)(41300700001)(478600001)(6666004)(4326008)(8676002)(8936002)(6862004)(5660300002)(26005)(38100700002)(82960400001)(2906002)(7416002)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?znh8PaQk2vAKcqac6+aqUlmeggQ+KtXJuxLvyhb/GB2FfWkbzYY4mgm62WRq?=
 =?us-ascii?Q?AiZwdmUm6flVtIsMEJOe9KK9yr6BgBqN6UUwNhtipJxOTbZrzyRnaSpeZnKG?=
 =?us-ascii?Q?mKbhIQ/hpcyA0DmVnzc1vzSQeZUsVqrA8ECDPrjAAzVC3jl3/GcuQ67SGB88?=
 =?us-ascii?Q?5RyQrQDdZkc4WD6+cz16Afm7RTnEbAqJuhfAzHQa5dLIWWPIB/1bgNHeYMUj?=
 =?us-ascii?Q?Z3FLdAOJOmwhYyhsmUdMa/INQEaOrKaG1FUItv2Sgqt9HBNJI7syZMhycsXv?=
 =?us-ascii?Q?6QPTSWHR1CQ1+GGjlVcTS4xAUTBfdqUW1xcoP2iwL7cjNFBFloG5AvLlUrBg?=
 =?us-ascii?Q?xKVdRw7Z5ac2KCrqs5hLO5ZRsVdiOg2OkewYo/1EajHxEo078a290KCFWDT2?=
 =?us-ascii?Q?nEjRJRgTi39nivzjlubrgq1Rjn0Zs30TMBwNohRRCAY3YLzjl1XbX0csWQab?=
 =?us-ascii?Q?b+D474s7FER7MvaLQD+t7IkRT60spBXjmLCxbAzFdMBDqN+F0Kq30WcfWHmY?=
 =?us-ascii?Q?2xUdpkr6NY4JkuBd28cSbHlOmoCTsdJL9Tarkt32UOBu6nnoL0iuvmLQUJqW?=
 =?us-ascii?Q?z3vDzqTtFSwDwMMe7YV2E1hSAibtm9COiqmFY4+Df5gbKDCJ0Z4JcGhK/veP?=
 =?us-ascii?Q?fmn03fyknM4rm+wopdECwVDE5V2ykVYHadsPGN4RM3yw1EIUjNoufMRIvHUW?=
 =?us-ascii?Q?U3J1akWxNWjeO64isoK7FY0QqIwAlu3pgoz1aqgfN0zYkL4hYP+6W6T80NM8?=
 =?us-ascii?Q?D3j6NUg7bdGMd50BvOMo/mNyWeDDudVaDco40Hx3Hr2r/Yn9zYuvSmLTUAtM?=
 =?us-ascii?Q?YDake1QTvmkU3Yr2yILyl/l0Yb7w7l7P3heWpksE/OegPQESpse2vQfA8R0b?=
 =?us-ascii?Q?M2WFK0sBZCo47VmghZmECMdiCPE6Kc5yfrDluO7Ng3LQGVOL5WYSV/9JmW97?=
 =?us-ascii?Q?eaRWq95L9wEX9swunagpan4jHCh96BQTJuMOyHLVkjNvClx0+CWw2lpUY8/Y?=
 =?us-ascii?Q?kSAWLJ23c54kzlLXb4sn4i+omgzHEe0sFD8V3N9ED94LcP3cylPVJlSGGE/+?=
 =?us-ascii?Q?umKScdPlQJUgV7cUXd7AYMw0tvVzpwapd523Y8XgVNY/2bbbCgg4dC6Rtatv?=
 =?us-ascii?Q?O42uannO7neIb+6xeAXEBcWp80VIolylK84dRADCoz+59HxgDUiTp4sNeZLs?=
 =?us-ascii?Q?QOzzzJA+zQtvh/10IyoEHjcjjuBt7zPIAt9Bq9naIFHgTpsuZ3K12KwuxSI1?=
 =?us-ascii?Q?i9hRdvzks21DE6Gl/mhJ75YvVX++QZlzj1BGiFALP0PPGhWxCcg5w9tAYR9V?=
 =?us-ascii?Q?ivtTDVAcpgxYZ1+qxQVRPm9MEhlJ7qcDev544mz9X9SQI5IVjX5F//QdWKHm?=
 =?us-ascii?Q?lebHGc6nu/be/aDXIqopkIo+4TdJfqoLmGprC+6y+1mJUSD9bwrYd2nyrkFb?=
 =?us-ascii?Q?a+9FIQu5ASFr+EjWn+ovJGZ0whFxly8x4HsyKjxQo1LT2roRsXoZkEt/87+8?=
 =?us-ascii?Q?P2C52b/YmXTBJN/40F5BPnDfLOEAQrGg7KsH+Xi9JhH0OcGDJhPiPOc71cUp?=
 =?us-ascii?Q?kF4kWc0aHWREFdblD4m1s6evizaVJObFy1bCrAxbN22nTZoUGvXJQNqIiVxQ?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e40787-c19a-4edf-7bab-08dbb851710d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:13:33.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WT/1vegEduG5DRmM/v0QNH8EtBdoCbUKXp5H6Y0aCnD7/kIuMGrrg8Mtb6437aa+lbgcW+jU0OavosFMBz7IZejac3EJ1wuxI0KS/VpbZWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5510
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 06:38:04PM +0200, Alexander Lobakin wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> Date: Thu, 14 Sep 2023 18:28:07 +0200
> 
> > On Thu, Sep 14, 2023 at 06:25:04PM +0200, Alexander Lobakin wrote:
> >> From: Larysa Zaremba <larysa.zaremba@intel.com>
> >> Date: Thu, 24 Aug 2023 21:26:49 +0200
> 
> [...]
> 
> >>> +static void
> >>> +ice_set_rx_rings_vlan_proto(struct ice_vsi *vsi, __be16 vlan_ethertype)
> >>
> >> @vsi can be const (I hope).
> > 
> > I will try to make it const.
> > 
> >> Line can be broken on arguments, not type (I hope).
> >>
> > 
> > This is how we break the lines everywhere in this file though :/
> 
> I know and would really like us stop at least adding new such
> occurrences when not needed :s
> 
> > 
> >>> +{
> >>> +	u16 i;
> >>> +
> >>> +	ice_for_each_alloc_rxq(vsi, i)
> >>> +		vsi->rx_rings[i]->pkt_ctx.vlan_proto = vlan_ethertype;
> >>> +}
> >>> +
> >>>  /**
> >>>   * ice_set_vlan_offload_features - set VLAN offload features for the PF VSI
> >>>   * @vsi: PF's VSI
> >>> @@ -6049,6 +6066,11 @@ ice_set_vlan_offload_features(struct ice_vsi *vsi, netdev_features_t features)
> >>>  	if (strip_err || insert_err)
> >>>  		return -EIO;
> >>>  
> >>> +	if (enable_stripping)
> >>> +		ice_set_rx_rings_vlan_proto(vsi, htons(vlan_ethertype));
> >>> +	else
> >>> +		ice_set_rx_rings_vlan_proto(vsi, 0);
> >>
> >> Ternary?
> > 
> > Would look ugly in this particular case, I think, too long expressions and no 
> > return values.
> 
> 	ice_set_rx_rings_vlan_proto(vsi, strip ? htons(vlan_ethertype) : 0);
> 
> ?

Have missed this one the first time, sorry, makes sense this way :D

> 
> [...]
> 
> >>> -		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
> >>> +		vlan_tci = ice_get_vlan_tci(rx_desc);
> >>
> >> Unrelated: I never was a fan of scattering rx_desc parsing across
> >> several files, I remember I moved it to process_skb_fields() in both ice
> >> (Hints series) and iavf (libie), maybe do that here as well? Or way too
> >> out of context?
> > 
> > A little bit too unrelated to the purpose of the series, but a thing we must do 
> > in the future.
> 
> Sure, +
> 
> > 
> >>
> >>>  
> >>>  		/* pad the skb if needed, to make a valid ethernet frame */
> >>>  		if (eth_skb_pad(skb))
> >>
> >> [...]
> >>
> >> Thanks,
> >> Olek
> 
> Thanks,
> Olek

