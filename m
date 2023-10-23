Return-Path: <bpf+bounces-12997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9577D2F6C
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 12:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DF52813BB
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 10:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BD21427B;
	Mon, 23 Oct 2023 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjMI5GCH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE5413AF9;
	Mon, 23 Oct 2023 10:04:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E41F5;
	Mon, 23 Oct 2023 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698055494; x=1729591494;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BZMceWAovOgC9dPNtXqEq4CODVVsACiJpD2rHLRLcvQ=;
  b=TjMI5GCHYh/QBg1hWKZGVoVrU5eaH8txa/c0YvMsBXFQRKxF0XR/3Gdv
   c8OfuqRy9FAIBp0HDw0SkfedlXT7zEksBt/a7e9PQNHueSDRwD9QGovzD
   NGBGxeUaDZlQwivEla2dMhyditBsfLxTyLF8acihEiCqXUBN0CnO+PwlP
   0A5Ulgzfv4tgXE+O5TCHaHrUNoVUFo2UZ0idxBkj2kc3+XwtUDxoY8taR
   5zU1/99To5q9K+s4gE0mDLiE0mXvW6OLriQvc/nX0B5aDfJeYkJh6uy0p
   NYqLGb9eS3tpz5s22ipowhSTh0jfwN48LS2nCnoNMoVoyqr9sWjJeJIpw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="417942196"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="417942196"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 03:04:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="848745797"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="848745797"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 03:04:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 03:04:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 03:04:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 03:04:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUTZypVknmBN3U8F9obcfLSR4o/kZR6kwVp5Gq2ukaY3yZ98EVUGaNP6eNHbwb82jLxaaBt1QadMQhRNhEc5M5Z/+VbTGa6laNQ8x6szZGHBQfTSe58aswGlf2bSBeNsCTwCDrX+Ns3Bl+HAea2qqv8PRL0SJm6KyZw00i6Ypm+wVMYQJcT0ufmKaCIztY9l6pJeYB2JKmAwZYyK31h3xqDJXfkEkJbY20RoX9pD7sDPGDytC1ca0NvaVeoVG8uZqfdR2gzKZpDo0MnZ0VqLPlsGILD9AgjIw3imTchvbzUtooD/TsCq4LZ0OLtuTP3Rb63eHnAoJrfFPFsXA6VgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJOR+n/V+PhumjV0ELL+YBZ/V2acDxA1F7/FEyCvJKk=;
 b=KsR1Y1c1OGnC/TIFqPvfVSuPhaoqY52mFGt3dJKrtSKf68YKgjLRfAEStvnb2ZBK8koug8ogn8Sm7thmTBrmxn/Fr3peENWzt2UJMELhv/RwK/71GwN3sVm6/FCiLbiZGHSN7iBM+80IcZtqVndlgp76t2oeIy9EYwyZKE/hpbEmVuI+JlkqUxLTZiMfgQd5n9JvNN6bC4cdStI5YuBrwYZtLTjyUEJJQ3grFlGyxjsNIz4waSEQv1idasZqbHIxR9cFplVDjLikmjdKzRdeCK5u9NwUgdaSrH/f4qJHOb2o1T5w4QQ+hl7IXXbCL0m4kuFoa7Z5LqRJFY9zuyUigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV3PR11MB8696.namprd11.prod.outlook.com (2603:10b6:408:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 10:04:50 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 10:04:49 +0000
Date: Mon, 23 Oct 2023 12:04:38 +0200
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
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH bpf-next v6 06/18] ice: Support RX hash XDP hint
Message-ID: <ZTZFNgTF5MVgZU6D@lzaremba-mobl.ger.corp.intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-7-larysa.zaremba@intel.com>
 <ZTKcZu2PVgVuFNNh@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZTKcZu2PVgVuFNNh@boxer>
X-ClientProxiedBy: WA1P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV3PR11MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: e0665212-fd11-4d2b-6fa3-08dbd3af7de8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nYrkvdX18AKmOo80W1x0xJMw0WNE6OtXi/OmIIuIaebNVLxVqoE38Rq8dA/+Wh2YqTXuv/HQO3mSEjuU1ZvamYFgFUFMqjlAaTMsZkp0QtOj6uooHwdpIU6cSEp7I/dffd5ixJcJX5Ab2OMoJEKs/ruEDp4vkMEaJLiC7BHmKRUue95AtC3s4qYwrRtNQ8tf5+dXG+0a49sBrQTzo6qxWUozu5vr0CleFAtF4e/ebMtD7jm0AJNtXRWVxQZQUvysasn0GPrUvKTyN13YEHIya0ojahh/+/72LdS51fNukHrfpw+LsqKvRc/sSeOufe5vA+1nLmBrelO7UyPoNqlhgD66iehWE+Zyik0kwzh51Sf4DRFlYtMDbXyjeZ/up0lf4GnqrLn2hR+FbFO2mdfKPrSGF/6bCqBRBmKsMNVp4+520lIUab83OQavmNYVe0VIJt4pC4NwUhVCrYQ8Jyy11k8bq67i0im9dLzBDcNUXZgVcVFR0gPvm8TnF+0TgnM0bqp4wK9lfDgP2ieWzipbv5GnX/8Zx/gh8Y/1LaS1K9vGl4REG7eiJfhtiNIABDb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(54906003)(66556008)(66476007)(86362001)(66946007)(41300700001)(5660300002)(6506007)(6636002)(316002)(6666004)(6512007)(6486002)(478600001)(4326008)(8936002)(6862004)(44832011)(8676002)(2906002)(7416002)(38100700002)(26005)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vzSU5cFrDb88fR7akdCoIkpk/CpbIl64DpHFp56YIMIafjyd5OzQUlUYGUjQ?=
 =?us-ascii?Q?ED+hgo3MJ4iYkJDslXD1NXJB44Ur8A4WwQp1agzefefZvPVWFYzaqnYhlCTH?=
 =?us-ascii?Q?OfZRCJf28DNlgNufYnwdGwWi5nBoJ6fwcq3QDEruQd0xWTyAD5Iqrwvl+FH4?=
 =?us-ascii?Q?gbPFmKiTAMl8ytXjiVs7ykjYYHFQPR80ZVP1JenUYFFg8uuXttLWx4v+Qfke?=
 =?us-ascii?Q?kzc7ggHA9XaAeskgbWPzmuBeMxomCzSWnoICcvWvrDgNGIY11hKSvKOIZzXc?=
 =?us-ascii?Q?bvP0588pJ+wPcBAGU0/EE0W3UhkeqgC7M+kp6HNpOP7Bt+t4pWlGsVEPMGyS?=
 =?us-ascii?Q?Ki4XJR2NmVL5vltKiUxMj7VreaRt/+X6MocJHiLWJPYr/AO2/biIkg/YneP6?=
 =?us-ascii?Q?lmRd35xpnlVMurvAwdwU720QbC8wsKK8s1+lGn6JCJTrJ+vbdP7CAh4qJqFc?=
 =?us-ascii?Q?rj/w80v5z4jd/VI1DIbsJ1RW16Xsce6LjHGGxWmOmiSH24zONUMNMVaNfd+7?=
 =?us-ascii?Q?I4EVETzsmK6p1FSPUWkF32N2ltHBKej6nrLmu3QM5HPLc4ORTfqhxNUVdkNf?=
 =?us-ascii?Q?UoZPH4X25RZ6/OqR2mSAyU2xcelTnM+G79CCKYw3IACyKlyXMPQAXqYGpBRp?=
 =?us-ascii?Q?aoJkW1ka7CIsshrCuVsIBfOnQ+YqU71ggQh01QL/stmQko5fWYln1mtEzKWl?=
 =?us-ascii?Q?N9hWswSMHU8bLAaaGFt+l7+Oth/DmUxPsqWDcP0X3FzhUbVAWLVm3zgCDGs8?=
 =?us-ascii?Q?qRKdA/vtEMGUII4Mdw/wxPsUw4PcuHhUDIXGVS6NGIlZH+6kDAlpBY3CsH5Y?=
 =?us-ascii?Q?lKcpnI4ezHGDGW4FrHBSslAO/wDDHfo8JxO9xyNAg6dTf3PQLQnSJT26z8tM?=
 =?us-ascii?Q?0lZIVmbj7CwEtupEFlZnMVGVcT2beLmGOn6bOKKYJrLZUfoqL4xbk8FjSqsP?=
 =?us-ascii?Q?Y5k7vhwnYW3Vn8QACuAQRdohavhmBa8u5tl4AaXHGQ4DHe8fX1AZJWRE3pXk?=
 =?us-ascii?Q?au3bI87/F6pAYmgr6I4HDXARyKLrAqEdXf5PJ5zCEoGRe0a/UMPQq0R827eG?=
 =?us-ascii?Q?vjSfIROf3g2KGY0cCqfb4oXmKRUNdiVPYuz/FY9/oyBkATKIlvBRFxDGx8tK?=
 =?us-ascii?Q?wZL6k8NntT61BeNTeR4U3ziax3HpqjCtxqAXnMpSNjQb6EGaQ2aHTvapuIeP?=
 =?us-ascii?Q?8xLDKiXFaBlOv4q449DhSqKbzXamqfV2aawdlUOt7ywTDzlFkzAvdf878pVz?=
 =?us-ascii?Q?yRR/WnH+UqZ3yGIr8J29l2Obj4mj0QoA4BFEMGBpvkYivpUuYEwrc0Mmc0Jd?=
 =?us-ascii?Q?hux3QdzYci80SQJGP6lT5DFZkU7WQBMVNee/rmyQS8TuM3/jJqq9xr+e3ZkH?=
 =?us-ascii?Q?aAjOv3wp8LEnj3w2lkENLsBmHIDtKvQSYmB1p/HlwXdrmde3hSm87amZnG4w?=
 =?us-ascii?Q?8nGSsdNjwY/z2+V2d5lgvHRzH7BVkCyvwXW/S4AfBmaqOuotxTNhHEmsCTpt?=
 =?us-ascii?Q?2sPynqirbxdVeJrNDwS2hfU6VlJ/vD563+owxRAf3ibuq1B/3Nn9i8BNcboJ?=
 =?us-ascii?Q?TCYTkkp35whKrzW5C5sQhJc24aLGnViRxbPNVV7uuMUm0swnf9WmBlxNPHkV?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0665212-fd11-4d2b-6fa3-08dbd3af7de8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 10:04:48.9300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pnnX5Tazu9xR0gtnylll41VxWCySwr6FZLgBC+XOy96onWCi8zgf1iaOrZ5nqJ/81ijM4oGd+iO1i1P38JkevjsdqTbU/WietBKCHAqZME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8696
X-OriginatorOrg: intel.com

On Fri, Oct 20, 2023 at 05:27:34PM +0200, Maciej Fijalkowski wrote:
> On Thu, Oct 12, 2023 at 07:05:12PM +0200, Larysa Zaremba wrote:
> > RX hash XDP hint requests both hash value and type.
> > Type is XDP-specific, so we need a separate way to map
> > these values to the hardware ptypes, so create a lookup table.
> > 
> > Instead of creating a new long list, reuse contents
> > of ice_decode_rx_desc_ptype[] through preprocessor.
> > 
> > Current hash type enum does not contain ICMP packet type,
> > but ice devices support it, so also add a new type into core code.
> > 
> > Then use previously refactored code and create a function
> > that allows XDP code to read RX hash.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> 
> (...)
> 
> > +
> > +/**
> > + * ice_xdp_rx_hash_type - Get XDP-specific hash type from the RX descriptor
> > + * @eop_desc: End of Packet descriptor
> > + */
> > +static enum xdp_rss_hash_type
> > +ice_xdp_rx_hash_type(const union ice_32b_rx_flex_desc *eop_desc)
> > +{
> > +	u16 ptype = ice_get_ptype(eop_desc);
> > +
> > +	if (unlikely(ptype >= ICE_NUM_DEFINED_PTYPES))
> > +		return 0;
> > +
> > +	return ice_ptype_to_xdp_hash[ptype];
> > +}
> > +
> > +/**
> > + * ice_xdp_rx_hash - RX hash XDP hint handler
> > + * @ctx: XDP buff pointer
> > + * @hash: hash destination address
> > + * @rss_type: XDP hash type destination address
> > + *
> > + * Copy RX hash (if available) and its type to the destination address.
> > + */
> > +static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> > +			   enum xdp_rss_hash_type *rss_type)
> > +{
> > +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> > +
> > +	*hash = ice_get_rx_hash(xdp_ext->pkt_ctx.eop_desc);
> > +	*rss_type = ice_xdp_rx_hash_type(xdp_ext->pkt_ctx.eop_desc);
> > +	if (!likely(*hash))
> > +		return -ENODATA;
> 
> maybe i have missed previous discussions, but why hash/rss_type are copied
> regardless of them being available? if i am missing something can you
> elaborate on that?
> 
> also, !likely() construct looks tricky to me, I am not sure what was the
> intent behind it. other callbacks return -ENODATA in case NETIF_F_RXHASH
> is missing from dev->features.
>

Well, we get RX hash in the descriptor regardless of whether NETIF_F_RXHASH is 
enabled (I have tested this), so no point in checking this in the hints 
functions.

Regarding `!likely(*hash)`: we have already discussed that valid `hash == 0` is 
very improbable, so there is no harm in treating it as a failure for the sake of 
consistency with other hints functions. Basically I treat `hash == 0` here as 
"no hash in the descriptor".

But there is an error in this code snippet that I see now: there also must be a 
check that `rss_type != 0`, otherwise packet has an unhashable type, which must 
result in `-ENODATA`.
 
> > +
> > +	return 0;
> > +}
> > +
> >  const struct xdp_metadata_ops ice_xdp_md_ops = {
> >  	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
> > +	.xmo_rx_hash			= ice_xdp_rx_hash,
> >  };
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 349c36fb5fd8..eb77040b4825 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -427,6 +427,7 @@ enum xdp_rss_hash_type {
> >  	XDP_RSS_L4_UDP		= BIT(5),
> >  	XDP_RSS_L4_SCTP		= BIT(6),
> >  	XDP_RSS_L4_IPSEC	= BIT(7), /* L4 based hash include IPSEC SPI */
> > +	XDP_RSS_L4_ICMP		= BIT(8),
> >  
> >  	/* Second part: RSS hash type combinations used for driver HW mapping */
> >  	XDP_RSS_TYPE_NONE            = 0,
> > @@ -442,11 +443,13 @@ enum xdp_rss_hash_type {
> >  	XDP_RSS_TYPE_L4_IPV4_UDP     = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
> >  	XDP_RSS_TYPE_L4_IPV4_SCTP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
> >  	XDP_RSS_TYPE_L4_IPV4_IPSEC   = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
> > +	XDP_RSS_TYPE_L4_IPV4_ICMP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_ICMP,
> >  
> >  	XDP_RSS_TYPE_L4_IPV6_TCP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_TCP,
> >  	XDP_RSS_TYPE_L4_IPV6_UDP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
> >  	XDP_RSS_TYPE_L4_IPV6_SCTP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
> >  	XDP_RSS_TYPE_L4_IPV6_IPSEC   = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
> > +	XDP_RSS_TYPE_L4_IPV6_ICMP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_ICMP,
> >  
> >  	XDP_RSS_TYPE_L4_IPV6_TCP_EX  = XDP_RSS_TYPE_L4_IPV6_TCP  | XDP_RSS_L3_DYNHDR,
> >  	XDP_RSS_TYPE_L4_IPV6_UDP_EX  = XDP_RSS_TYPE_L4_IPV6_UDP  | XDP_RSS_L3_DYNHDR,
> > -- 
> > 2.41.0
> > 

