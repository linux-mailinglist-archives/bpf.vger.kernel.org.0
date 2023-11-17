Return-Path: <bpf+bounces-15232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5FA7EF407
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 15:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 533C3B20D4C
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F7632C8B;
	Fri, 17 Nov 2023 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kha2yqp9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C41C5;
	Fri, 17 Nov 2023 06:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700230094; x=1731766094;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2LOVj1bpbZJ/ou44HiyElnlBetM6DE+5bMMZzlvs2k0=;
  b=Kha2yqp907uHIJNFrW1clxe9JK/3Kf9rkc/mOrAF9K9o86G6Shv+sdwf
   Je1eXTnUfN+tpg77swAGAImFqynR+DmqVqDEt9nGaMXgqxqWgdf8A06EH
   te1Orh2jyYqmnvJ+F5oKCsVf2atr4q3ce/Zol0XJSdivGy6CfLdQC/nCx
   vNrknydLPZ2d9YpQ+7VeLKfPRJJINc+L/YcubmxxFVrvkLKLYrieTuOYe
   7MxMvFl8xMP3WRrHdthRGwVPa/Qmqvy0BVjGYh2EhUCctFFnkZkAfg6vs
   89+YkWukBjjl5L1+yd96H54EuWhzJKyXVtmEK9t1cvcmFDH4fzvNl+Adc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="388453803"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="388453803"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 06:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1097107965"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1097107965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 06:08:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 06:08:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 06:08:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 06:08:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 06:08:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzhlsxEJhDaqygoKdPQw7d5zHwnwKpfWk211yQexygSzv2HGBoassenQ2dBnjLdhtVywfRWn1Uxoro/3Bfdp24DOSYQeycBJNjn3WXTroPtmg9X7khlpv/CYMHc+88Lo8A+vudNk4TAY5uYuU6Y0QO4DNsObIcaLRBMZZhvLyAZcA/XIDwxUOxtDryD0uQg+UWDPnp4znuxXT/6dpCuEfEkVLKKonTL5yYTsGKsYh7yqtT0pM4bduJ0EVyFWt2N8WmXgh0kymf5n9N3NF/336PbW7P5UfI5PYW7++OKVQrwTX15+u5DABIfcLnxr2vmMunOvQP7iyxJxpen75tJHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOlBIBpoDMjo9e6IrdqQl9Nz+iC+1WBfvRIawDjYBpk=;
 b=GM/y2hbj/MTkukDmv2Myt+JDVpDDLMI86fG6LAN7kpAeT5xZVbgfTD/gg7BfEAS/A6rczGD/NgPCebZ4miqyCvqMlJ6pzF0zXiaffuCzYwYVCd9g1bCg7dvKCZ8ot5AlAUplvTuicV1H03QJ0tr4Am+Y3EiUmX6fXu3lFn75RXd3dKNlrqx28l5Ovxmbeo70bK3MDJyolkEqrSVcBUNuvRh8RDUywqQbqUOlkk+B0JrXcw4mcdMoKvncr5LY+f5Un4Cpv8hrY+7mq0FrLQUPqamYTGhJLQB1gpR9c6VeSobCshwDBitEMJUjwPLNiCTxcCCv3XvomNPQmpr+XAwaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 17 Nov
 2023 14:08:08 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%7]) with mapi id 15.20.6977.029; Fri, 17 Nov 2023
 14:08:08 +0000
Date: Fri, 17 Nov 2023 15:07:37 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Tariq Toukan <tariqt@mellanox.com>, "Saeed
 Mahameed" <saeedm@mellanox.com>
Subject: Re: [PATCH bpf-next v7 11/18] ice: use VLAN proto from ring packet
 context in skb path
Message-ID: <ZVdzqXDOnfXeBVLN@lzaremba-mobl.ger.corp.intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-12-larysa.zaremba@intel.com>
 <ZVcgBGRwcyaOl+yl@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVcgBGRwcyaOl+yl@boxer>
X-ClientProxiedBy: WA1P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::21) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: fc83d3a9-9647-4566-0edd-08dbe7769fe4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fu4akbJ0YIq9TOzQ4yhcS87XjUdNQDuTbgg9jrKOtk5OcklK2QR6o3tNcJ2eOucP6zISQYNBQEKaVK9wD8jiJDbx8b+V1Lq/0WinLS124qcLYijVQGHWrkqmQxup3TcI3EiNyapLwDrXajDKcyinpDgqB17n+9kvDyVH0uzi5oBHsN1FI/t17NwVgEPEmI9N843mZQBcNeHaLpJ3dEOFZ+HPBtUuIh7iI6ilw13YECclO3gHXZg0Km5kBuAzMxNFXi7SHJO10XVuGCCj/IxXP/gMSqWnXp12TpC/uTXXEnUAiHAJjC2cJH3sBOhdLVDk4ED56fADGLUa1IDLznPF+vzwNS6eCaTlKFtVJs8kLRsW6dMJWBTMc2KnIyN+phH81ZWcyQlzT+T8KKkeCJISVmBcySyDNtXqkGvRQPXOJGeocKV4fKSmyK8ukBM3mjgv2dTqDhRDN7u95Exh9RfHAgdMgb7UJosxQePAkFpZxMh1M9EVdBEwgNKY3sVR/csLepZF5Rn/hn2RPxsXf/pOgd7OSOR9UKvHdFCHFk/jcnKWoc0pBzJDGbEMm0tsjLFW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(6486002)(6512007)(6506007)(478600001)(6666004)(41300700001)(54906003)(7416002)(4326008)(66946007)(5660300002)(44832011)(66556008)(316002)(8936002)(6862004)(6636002)(8676002)(2906002)(26005)(66476007)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1fWd4g66MGnBmGlKqtMAG3s3e7EMMc00ccREMWnGJ00R1FSiKR1QxV/QEsRP?=
 =?us-ascii?Q?kyU5ggk8ECGlize+bcEj5so5kLr11/C5uUaR3B/OSVIoQ7drmj21L82cLvq2?=
 =?us-ascii?Q?UoDAlsMf3w1lrbdE3RgA02pgyOJXHTZvxFVa1g7eX6Dal5xOC4OfOLsRg91a?=
 =?us-ascii?Q?cc8/6FqxHigAdCxWCDJZIIlvSNbfBSUBNSbtK5mhZmFJWPSqKSTdTUf+W6m+?=
 =?us-ascii?Q?it42pdF5uBf+cCtgqxYlowbNljZcccfVRSDFxa7YNH5oVKJ/gck1l0FScPv2?=
 =?us-ascii?Q?aLxmPHJVgFt+v+fxyJ7/KuEzvHjpvbB366c5ULlblEjTfqb+NK8lmAjHRVh9?=
 =?us-ascii?Q?/4QcpJcEmXhRe0q2K5m3j7yTJXJFIF6zXZYzP0iGI3hli0+FHmRw3F0F6dJl?=
 =?us-ascii?Q?OEbole42O0g9NEGhfs7eNgKuLmtrc4NqcSPVRBROXtPY0uuAVxvfW7IaY/7y?=
 =?us-ascii?Q?ptAEdZr31nZXhqdupLYSadL+Sm5PxZ86I3ljW4UYvObKyDGNUCGQNIjBotAz?=
 =?us-ascii?Q?MSD5abcfDTtw1NzgpgjIFekM6HUe1kLvfHsgeLZ9lmTHoUV/qhdXHASa9M+q?=
 =?us-ascii?Q?DQaid7OfG+RowL9JgRAvMvhqLvfjcoDnt5qD7TdmCCXQ9UPx4EzTa1h7PRlQ?=
 =?us-ascii?Q?2gtFdRYIWTWu8vSMLXtG2KSJAfxS77L3+/W/J/oDOB7N6EM2vhcPMbGC9bVL?=
 =?us-ascii?Q?2W4hORi7ktn6+VvpKkfklDbSw7N6ipOKRQ2JQAB1YW3NHek91swueQ4KQrHm?=
 =?us-ascii?Q?ruaVQzX5EzfqTt2kb4Vpzy7lvVH8IUS5RIu3jZtsDNpdIAWwmT/3TlQb7OVU?=
 =?us-ascii?Q?WpxKJvFMYrSXMOMIAbh3zrjV4LfjDc1fRkumRbYIarBbUH7NkFIrAb48C0Q3?=
 =?us-ascii?Q?BFnCvWS9ZCOkN96F0e4Bu/gBza+5r/+mL1CKarAhAa6P8bCStlEZp7/0PP3y?=
 =?us-ascii?Q?G2l6rmiQggYVh7srSTmTFoCL13vc34cZzmLZU8lnwCTZXhcD8Dn7BOury1Fv?=
 =?us-ascii?Q?Jwv1oeMkHRZalWyzhAgkrN9IGEzaEyXhm5dGzFr6adpPo5TuUtdwLF3QctLU?=
 =?us-ascii?Q?1BrU8VLluuGI7ucK1V8C61CRzCsKWY6ELd6BBVomFhJaMsj469eLy8aaYtKd?=
 =?us-ascii?Q?uzb3G1DM+HywBRyK+5n/2Hcx6FJKUkjaNU9wnvzCzfV5+3pnOJ/fNylXahOZ?=
 =?us-ascii?Q?EKzEdRfGESpEMOF/tAwE2VMU5Ig01stD46UKiq5ofv355mlE/xu/gPNOm45s?=
 =?us-ascii?Q?cAI16+izWFYWi2LE6r3REsJKn/R06u9soEHZQDFrpS8nFPqhdKVNBWXPTBAU?=
 =?us-ascii?Q?qod64X2xsVyJ5Lheqi54Hf2yG2S2jKNKDatx2mrNQmBRamJbdsoEU0wrULxJ?=
 =?us-ascii?Q?bbbx4od79xII4pIsbcoAQh3fHTjzdLpy8VsP7OsW/K+XHVJaHHx+JwEpwTRm?=
 =?us-ascii?Q?FG238d1eCWli+IvM+r4PPC+vs3jeI4e43hcDrNwj+CtvK5lF7q/SFMdT5Mkr?=
 =?us-ascii?Q?nu9PATKUyDDpGAq04ASwENz1RYrl74VpT4H6DUIwJ9ztE7LuwjmKlXq2O3Vt?=
 =?us-ascii?Q?x0FjWXKxg+rX/+Pt+nb/UqRM/TjvCaYCGk4Qx6zef4rMgmp45i7ffvb+vCj5?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc83d3a9-9647-4566-0edd-08dbe7769fe4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 14:08:07.9049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JI0ZnMU+f+Q9+VVvMZPKYqz/Ab0PtwNGrwjgCjtpJhVjyBdQSe8XSAUR5Xa7MK9oD0FZ+Jk/punUA4bmVEaYRCPUDfjij7SoLhlE//h1WeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com

On Fri, Nov 17, 2023 at 09:10:44AM +0100, Maciej Fijalkowski wrote:
> On Wed, Nov 15, 2023 at 06:52:53PM +0100, Larysa Zaremba wrote:
> > VLAN proto, used in ice XDP hints implementation is stored in ring packet
> > context. Utilize this value in skb VLAN processing too instead of checking
> > netdev features.
> > 
> > At the same time, use vlan_tci instead of vlan_tag in touched code,
> > because VLAN tag often refers to VLAN proto and VLAN TCI combined,
> > while in the code we clearly store only VLAN TCI.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 14 +++++---------
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
> >  2 files changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > index 63bf9f882363..a1f5243299c5 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -246,21 +246,17 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> >   * ice_receive_skb - Send a completed packet up the stack
> >   * @rx_ring: Rx ring in play
> >   * @skb: packet to send up
> > - * @vlan_tag: VLAN tag for packet
> > + * @vlan_tci: VLAN TCI for packet
> >   *
> >   * This function sends the completed packet (via. skb) up the stack using
> >   * gro receive functions (with/without VLAN tag)
> >   */
> >  void
> > -ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag)
> > +ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci)
> >  {
> > -	netdev_features_t features = rx_ring->netdev->features;
> > -	bool non_zero_vlan = !!(vlan_tag & VLAN_VID_MASK);
> > -
> > -	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && non_zero_vlan)
> > -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
> > -	else if ((features & NETIF_F_HW_VLAN_STAG_RX) && non_zero_vlan)
> > -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021AD), vlan_tag);
> > +	if ((vlan_tci & VLAN_VID_MASK) && rx_ring->vlan_proto)
> > +		__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto,
> 
> Umm... pkt_ctx.vlan_proto ?
> 

This compiles both ways. I have put pkt_ctx into a union.

> > +				       vlan_tci);
> >  
> >  	napi_gro_receive(&rx_ring->q_vector->napi, skb);
> >  }
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > index 3893af1c11f3..762047508619 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > @@ -150,7 +150,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> >  		       union ice_32b_rx_flex_desc *rx_desc,
> >  		       struct sk_buff *skb);
> >  void
> > -ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
> > +ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci);
> >  
> >  static inline void
> >  ice_xdp_meta_set_desc(struct xdp_buff *xdp,
> > -- 
> > 2.41.0
> > 

