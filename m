Return-Path: <bpf+bounces-9204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5729791B20
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 18:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E251C20358
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21ADC2FA;
	Mon,  4 Sep 2023 16:07:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F027BE4F;
	Mon,  4 Sep 2023 16:07:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2891B9;
	Mon,  4 Sep 2023 09:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693843655; x=1725379655;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0gJJBPlh3EirInV6XsztpnJTnGa+tBF21/UMmgnk9V4=;
  b=XVWxmc1CY6FHZMZ9kUm22Jt4GMzgVrAdPl8gJKrHASeHZSToPxCWZ7So
   RjeBsUC4jAyWnwaGFyTk+uIIR6u/uIaGkE2RqcDXs6MynSNKZPMMf8NAB
   7SWOUXCpsyli2Z+SDJNgBMRrwYRVk58IRnmASBp+KRxuS9v1DcZfRvgsK
   xh5MFzlDTH0ebJVMhCtz9X4GbNPI5RIsS8d8WioM6bW1ecGCHgw26JYze
   2Vvj3QcfbsqN8Ss2oPdTj4kaVeb1oHMHYMoc4h52+bZwrp7ftrl9q4AOA
   4YKmLj7l8vUzSGi/gXsIouNiJB+ucBXnkG406KL9ehuUD1wwKLVlVQhNp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="443022640"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="443022640"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 09:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="806300426"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="806300426"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 09:07:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 09:07:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 09:07:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 09:07:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 09:07:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk9HMvmBIk0B0OaZ5sezkcW7qPsw7CfgzSA/oRprDRbV9Sr1SiUXSB6BAJvJxXpgn/jI64f2hGBtnQnLBLKDIxMNC/ESKlpQ1FRuD2mH6CX0n9iyP/jZqJ4V7JXCRF95qcuBfOSK17WwwM5gWcpqJYWe7G63owbKroV6L21TWy98TO49XrhvEJEBvVSQm2aEfCWD3+ZaOcp3Yoh2cBy7DcK6W0QKF/G6K3bHfXvGNU86pn0JSU2pgFbk3IxuI3gzHGSZKkhx/yV4WxuKdJ6KykLLH+loC+294m793Y6sS5DZHeHcxoVDpp/51EV+ScNRhD+afPl03ohwbyEivVLyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79SjfbApact5TIsmOmICtY+fbOdfUyjDo5mHHeUZ39g=;
 b=cb38fwhkdXsEeGzU+a14dNgUbJk1c11WsF+oaY8SJvpMqm6BTSHaIyli6s6qS389i0imKM0gLpBed4M0C1xlFGsTtbR8u+6kQCQs0uvOqKnoZ7UvubO4Si9TzgfN7u9PH1aD5sT5ZXPJ5Jdu33czZl/j2Nf/Cr4AWhgTPCk72Bo1/o1PtZigvlhs6ukDShxBIcWBStT28tJR3niO17ow57xJq70KxouAFJc1xUqzlBxJBJ88k6uROjqQXPHMRLzLzS1qs+tQpYEF2Hr9wrTPW3GdY00xg8YN3Der9naPDK4UekhpaN3G6gkALdh9K4sTXAFzSEWYbxRDr+j1aLp2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.32; Mon, 4 Sep 2023 16:07:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 16:07:00 +0000
Date: Mon, 4 Sep 2023 18:06:51 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
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
Subject: Re: [xdp-hints] [RFC bpf-next 00/23] XDP metadata via kfuncs for ice
 + mlx5
Message-ID: <ZPYAm9oq0SZ7VEvO@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824192703.712881-1-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b3f2d8-07aa-4e00-0d42-08dbad60f85e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wf80EOuuGPYHVAj9zDJYw4mvU909tawQDf00vvl+5mkNiiz5WvIw1koR6M6BNGWdCNhfTaFl1W3CuuHjFMIn57VvvFt0e2+hBrUJLRIJ+GtSKNNaUCSKOuYDaZ0jdCY8j68905UKPE610j9Alrh3X19t6yLBZrSkw6nHjSUUTHWf0pOGq9ULqhs/Fql1C+iS9oL279aLg1otKQVI04hZFD4kkDmL0JkIGgfhUlalHva7uwJUe4N3HfWCqDcRlNI38feycMLrsTiJxPRg/t+kZMEQkHLmHIlCgWvz8IQ8OhlordopvfSdZ7msOuXDTbmTVfAmcKPQGtpPITF9cNIkXFNCMK4j9H/MWm1iP/aMGeniAgufPf9WV5X1T+NMs+9N5YyWgKpV5MydwX8NOKNVrSwV0aMcr0JReyfJ9FyBk7WP1v0QaOO6CzCYXJtS2I2K86fQYrXEPDhW8Ha5i89ElReP8lvbDdp55+HeEID6h4DOUG0fRaSEotX08UZlpr3Zf/4FkM8/d4Ty9HEsjKIBX4pCAaJ5BAWAhMldajQCWVn/RDP+4EUwmq2U1tSrFL28aar+kydE394ob8cDzlHzww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(376002)(396003)(346002)(39860400002)(186009)(1800799009)(451199024)(7416002)(41300700001)(82960400001)(33716001)(478600001)(6666004)(86362001)(966005)(83380400001)(38100700002)(26005)(9686003)(6512007)(6506007)(6486002)(2906002)(54906003)(6636002)(316002)(66476007)(66556008)(66946007)(8676002)(6862004)(5660300002)(44832011)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cLJUrgPnOsl4NQ9Z2XH86NxrbSl3+jVNQ0goWXipyPTVHKWlljtOsRnAclmk?=
 =?us-ascii?Q?2z4zUcyabnNwINqrt8PLuGDGThLpCRO3Rtaov2sZGzb0hdyXYATdiZOJvPha?=
 =?us-ascii?Q?UpK9VPWSgNmZcAhzxCvfpzU1ZfYHn+lEXBaOrg4nv5VpLncozsEHO5A4NCnS?=
 =?us-ascii?Q?ruyZPy1msN+bEYfeY+OS9xk0tDZsHf/etRak2s1AolAn+f4IWIc4gj4hbSyr?=
 =?us-ascii?Q?3mtVWUv+1KcfkTLHRdrJ6SfhGaE65Hwd918mqojzQMyfmisMscEqQlPnmivp?=
 =?us-ascii?Q?+emyWV5ZAeg34xylTtGWSCG9ufnsBz6/MBpzCq6+A4Qmtm6zeiJ2MvdYyu5w?=
 =?us-ascii?Q?8dAR6fwZzVU1TEEdUfP/hMr7me8kkRNr1cokyIL87OQLuPt0zVUDPxSTkxVj?=
 =?us-ascii?Q?WWC9iLHTF/uCC0zcMrbp/z21kqwed8AL6agZq15bHD6yW4ocvuz214tNS72g?=
 =?us-ascii?Q?nQ4qgyng40Zh1Cyuxmy4ocL9QweqTdzrS8NBt9H5KL3FutHQaYPD3Y2bslir?=
 =?us-ascii?Q?jESrl1d/H8WsL8koTnBaaAc6x4xQt1/pH7zAQqCTl2wm5MGCnQmEMaMsyP9Z?=
 =?us-ascii?Q?svnIjc1f4ggEOuaACr6p7EbLMsle7EmLiuMcYsd/BfKYubfFkwswe7kb6F1j?=
 =?us-ascii?Q?wZqiEX8kPZfypZX1BvqQoVA1f4rZhoFbIIQSOe+6shndaQUnV39nZeQNpCfd?=
 =?us-ascii?Q?oKEfWVJxhR7D33gwZ8xOPLtzW7tb/8elJdZCovWCO9y6G4yRZrOzqcnCKOG1?=
 =?us-ascii?Q?eQ/oPfGHKmk4d4IgBVdZU79NVfYmWNiLeiEI4TR0xR+KO6ZQ+De0B736Fic1?=
 =?us-ascii?Q?34IHSaTDknWpb3gXPDml+/34H0mZisOnQACwlah0JO49rTzIj7l6iy1xbEon?=
 =?us-ascii?Q?ggRFLtS+eFNK2vFW5TVlKLdmmoRzSoQ3uwcSsak3tKH/y9oOMnyldtkHYcst?=
 =?us-ascii?Q?JVk7k27h/IP1+lTc8ITtzqIwNcJtLEHGTwqnAew09gGfjsn8uPS2h0J/cx5G?=
 =?us-ascii?Q?ACVcIaX6rUdR0kUs2LF4nEHW5LXKmCEBZ5NICS4xzO95X5H82U/C7XAtg+mz?=
 =?us-ascii?Q?JQlnyWyvIGQaCTbu+EZSdfi6BnS9qogATjwzDZqyIt4Zx30u7wl3LWYVpk35?=
 =?us-ascii?Q?sdMLaxWrP6EeBD0RwOVeOZrGUrhTGgB/m9GMOsMucxJcJxELDxdK4wAScntP?=
 =?us-ascii?Q?0YHE0PpXKUuXcezQmzRjOvBK7qGCzRyVwpTzXz+dNylM4MW0m8AIzMatlniX?=
 =?us-ascii?Q?SdXvg5/qXwxr5S7QIN0MQWtKZHRMEk9+OmQDSGg5CRH52GHMqH3JVw//cQJB?=
 =?us-ascii?Q?u4RKkdT8pw45ZiPh8EjxYhr3sgT2LrX44niTSNcR1UlSUf1639r/Q2gSGZnL?=
 =?us-ascii?Q?h5K97puk5Gp80rxSyJUMVTefkQo/jAagzF3zdjAMAi9WKOOQNGXs43s0+1gl?=
 =?us-ascii?Q?Mj6AsqWErd078cUuWb4wZunGEjT8nDeJ89JmiCRsg4RaP5wh2vrGbkzZF6fy?=
 =?us-ascii?Q?oS2f4xU5LLwaQaJiMNHrwAMatMzpgEsPJGfJpjYi0sI94PUdH0kwh+lAdzMf?=
 =?us-ascii?Q?EIloiEADjXMpngQgNKgrSHIMzZniTFpRsSx42vUeAFo6PdVttJja7qHbLxwa?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b3f2d8-07aa-4e00-0d42-08dbad60f85e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 16:07:00.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zovW1oqZfg5jnypuw95pKqrgC0qV+Z9503GSeyz6Z8goXDxSY8Xq0vyXPgY6HiacGr+CCiXOscmOD+A9p3R5hULDdOX9uJlLiZSyQ9gro0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 09:26:39PM +0200, Larysa Zaremba wrote:
> Alexei has requested an implementation of VLAN and checksum XDP hints
> for one more driver [0].
> 
> This series is exactly the v5 of "XDP metadata via kfuncs for ice" [1]
> with 2 additional patches for mlx5.
> 
> Firstly, there is a VLAN hint implementation. I am pretty sure this
> one works and would not object adding it to the main series, if someone
> from nvidia ACKs it.
> 
> The second patch is a checksum hint implementation and it is very rough.
> There is logic duplication and some missing features, but I am sure it
> captures the main points of the potential end implementation.
> 
> I think it is unrealistic for me to provide a fully working mlx5 checksum
> hint implementation (complex logic, no HW), so would much rather prefer
> not having it in my main series. My main intension with this RFC is
> to prove proposed hints functions are suitable for non-intel HW.

I went through ice patches mostly, can you provide performance numbers for
XDP workloads without metadata in picture? I'd like to see whether
standard 64b traffic gets affected or not since you're modifying
ice_rx_ring layout.

> 
> [0] https://lore.kernel.org/bpf/CAADnVQLNeO81zc4f_z_UDCi+tJ2LS4dj2E1+au5TbXM+CPSyXQ@mail.gmail.com/
> [1] https://lore.kernel.org/bpf/20230811161509.19722-1-larysa.zaremba@intel.com/
> 
> Aleksander Lobakin (1):
>   net, xdp: allow metadata > 32
> 
> Larysa Zaremba (22):
>   ice: make RX hash reading code more reusable
>   ice: make RX HW timestamp reading code more reusable
>   ice: make RX checksum checking code more reusable
>   ice: Make ptype internal to descriptor info processing
>   ice: Introduce ice_xdp_buff
>   ice: Support HW timestamp hint
>   ice: Support RX hash XDP hint
>   ice: Support XDP hints in AF_XDP ZC mode
>   xdp: Add VLAN tag hint
>   ice: Implement VLAN tag hint
>   ice: use VLAN proto from ring packet context in skb path
>   xdp: Add checksum hint
>   ice: Implement checksum hint
>   selftests/bpf: Allow VLAN packets in xdp_hw_metadata
>   selftests/bpf: Add flags and new hints to xdp_hw_metadata
>   veth: Implement VLAN tag and checksum XDP hint
>   net: make vlan_get_tag() return -ENODATA instead of -EINVAL
>   selftests/bpf: Use AF_INET for TX in xdp_metadata
>   selftests/bpf: Check VLAN tag and proto in xdp_metadata
>   selftests/bpf: check checksum state in xdp_metadata
>   mlx5: implement VLAN tag XDP hint
>   mlx5: implement RX checksum XDP hint
> 
>  Documentation/networking/xdp-rx-metadata.rst  |  11 +-
>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 412 +++++++++---------
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  23 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |  27 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.h      |  15 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  19 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  29 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 343 ++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  18 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  26 +-
>  .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  10 +
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 116 +++++
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  12 +-
>  drivers/net/veth.c                            |  42 ++
>  include/linux/if_vlan.h                       |   4 +-
>  include/linux/mlx5/device.h                   |   4 +-
>  include/linux/skbuff.h                        |  13 +-
>  include/net/xdp.h                             |  29 +-
>  kernel/bpf/offload.c                          |   4 +
>  net/core/xdp.c                                |  57 +++
>  .../selftests/bpf/prog_tests/xdp_metadata.c   | 187 ++++----
>  .../selftests/bpf/progs/xdp_hw_metadata.c     |  48 +-
>  .../selftests/bpf/progs/xdp_metadata.c        |  16 +
>  tools/testing/selftests/bpf/testing_helpers.h |   3 +
>  tools/testing/selftests/bpf/xdp_hw_metadata.c |  67 ++-
>  tools/testing/selftests/bpf/xdp_metadata.h    |  42 +-
>  29 files changed, 1124 insertions(+), 459 deletions(-)
> 
> -- 
> 2.41.0
> 

