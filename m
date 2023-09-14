Return-Path: <bpf+bounces-10044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4C87A0AAF
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC6FB209D3
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F7219FB;
	Thu, 14 Sep 2023 16:22:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDB18E28;
	Thu, 14 Sep 2023 16:22:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F2710C7;
	Thu, 14 Sep 2023 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694708521; x=1726244521;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c6Qc2adxTI2WXoFs1eM8ut59EpOk6L59lnppL5M8T7s=;
  b=TZBhfh7sGR94HTQGhmfepIPyoXJ0pbuB2GhDiF9IGIBwbzBn6SP/iWBf
   W2Df7ozM4439vqTmFpHrl+8DMKYvItWwgJ0hgs3ZqOueuO91PkYFw1uDV
   WK/AZnQwceSgDKviK7byLT2XGcnFfbikLIT/kZsZo+6ESRfpkRzKBpw8N
   WFQskTiTA4VBThNa7wgRyt0Aw0l5oCry/HK3Vxu5t/H4qbfSdZaW9Kg04
   Kp7gBCbDkXFbL2gJoHZv4yJNFgIITYPVaD77R4wZvO73K3CO3nmFqGpp0
   hCYnj5peRcEipZ+HA0V88pgikEYuUwLch73QJ7GKCr70WKn/Vns6LmpZK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="358421463"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="358421463"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="887881589"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="887881589"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:21:00 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:21:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:21:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:21:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Siiy+TObcsE8odPd/StYGhrSVhIPGE8h/LjBQja5IuQSHhvqV/jSZ+5ZJnNNaxyV2EoKsD5XlhPbWchP3OKk+8Ymv8YFb9KzVVcwSGJdzbp4J+PqzxliIXU2zpWrZ6A7cGreuBaNK0Q3NIV5MOYfudzYjig5cOavW048jXK3uW/sSDYnfpanQhFjeEFY2jUof7en0TWVzlvDc27Odcm3/+nD0BSU6VLOB0FaZum2P56jLBoLSUG4oUsjsgg8dorjrpapqlE/SgHRRWGiWt3H9WiaoITgx3q/QpnI3YwRIddSqt0uPFErUGPAOwlNKn3Uz2uYJPz6LjzKO9J7MeMajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kuFd8UvnzdIyWn9avd13xfOHId3bBtkSNaM+2gx/uM=;
 b=iYMPzaSou8Yh4VRdqQWdpZQQEBRBtyn66VB5Bi5DKeMrRKeHNkH0KT7RmuJgVmnS8sgxQLFG1vE2PKKM1sK9uPgeQz5mwq4fOmv1caKz474FhTmxS1DVeGZtlRXEvsTrj11Kx3Oa4gWN0TZeEul3yt74r0/+1PDrJo+Mj5erravEBCGtB2Xuu7+mDrJW4rlJ4i9xNUMqqYRPDWF6bisdnAB6RWNSgyfafUB79UHZLi+HtvHokRC7GgiJ7/7nNgUpzTx4NVO6EQMpawqNEe01gqpdSsBpL5dbuol3LfzdVM4Of7wQ4KlQSpMpayh0pzTl9yVzgusvpd2P5Xipfgdkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CYXPR11MB8731.namprd11.prod.outlook.com (2603:10b6:930:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 16:21:30 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:21:30 +0000
Date: Thu, 14 Sep 2023 18:15:47 +0200
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
Subject: Re: [xdp-hints] [RFC bpf-next 01/23] ice: make RX hash reading code
 more reusable
Message-ID: <ZQMxs1XSQOQN5kBI@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-2-larysa.zaremba@intel.com>
 <eceeb36a-6621-b0c3-371d-e617023fb0e4@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eceeb36a-6621-b0c3-371d-e617023fb0e4@intel.com>
X-ClientProxiedBy: FR4P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CYXPR11MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc3db6b-21ac-4723-2903-08dbb53ea74c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DcreoruNryE9haH5pHst5pQLQ5oFCtg9G2rdJ8QNqxaGm3qcu+8FJs0JGMsWCFJt6ni785bZ8YFSjZyNke3J6inGE9CkIKAitouRKkkD2FqdR0UJ/3X9wI8w5/1wwEOBwCtzlL+YEwF4/w7zw/H02qtCp1uXqmgUT6nSlgYW4uhlqCL0+ehHHzBNtU+P6Zmo63XuYKWItd8goWb6ve3F9Ddoh79GUK134m/DyNuNcfT7u3AZOykr2ZdFuYiYkmvWQmSpRkJPsnESBnNKIDytD0Avxwebk3H2lgAHos5+w0pJL5lw5PZS7RhtovPQwZYTiPxoD5XkwBsx+2JMStFZTwz4o8hx/wVhx+HaClIePAMR4ziUXJdOYfwKzYBEJQd4PMr82CoGIYRIGSs9pX/EFfCHPf5qNKInc57jqnke9gX7nQc3TIDuyayhw/mW2lFhpTrGgbPVH9DSz6pmk0JPo3P8Ets3tfDNjz6kMWiYtUKPuFGqWV4v9P4bK+VbjyfSuNynGT6BF52q8b6hdzcbTqNre268UxlfX/Ssciwmih8w5isExqU+IPhiRWYA/RUa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(1800799009)(451199024)(186009)(33716001)(6506007)(6666004)(6486002)(8936002)(66946007)(83380400001)(5660300002)(2906002)(41300700001)(478600001)(6512007)(7416002)(66556008)(6636002)(26005)(54906003)(44832011)(66476007)(8676002)(316002)(6862004)(9686003)(86362001)(38100700002)(4326008)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WZ3zR70S6U0P+k/LxvUUyryd7s2ZmEioWcrcJapDehHOadiOOwVJR0BTsEUD?=
 =?us-ascii?Q?y4vKjduKqgZkXB6qPVuOoWvDsHyXX64Mdv4GZ1M3pqFGAonTmQIGWBOUiLii?=
 =?us-ascii?Q?hVa6L2TkXYCJFeH1WaTCSIFmKqRFDktP6pBxKA4DBNyu8GwsEGlNUlwiqHnO?=
 =?us-ascii?Q?26CRUT/kcrLJS7D/3wVXUbI4jHOzpXf6u4jxL23ac2/sdNYBWNtgtMyIwVRZ?=
 =?us-ascii?Q?vTY6cF6NahKREa+bVJS16qvYE/l/fi7VX8RC1V6qzd7wsVbTaDtzwrr+o5vT?=
 =?us-ascii?Q?OJBJNO5pXORTGRxWA1ThpDc0ao8YyVveoQHDm6pK2PjPP8et+qIJPVWCMDKN?=
 =?us-ascii?Q?BT8baGVqTrn0BICfOaI9sYFbMT4deNNdbWmd2IQS6TtgIxHGIhLUSSTHdr0+?=
 =?us-ascii?Q?mYOAuJjNixcnc9ryNP+ShvoyHnhhoeZBG4cSKarUg1hZirGeXq042XE/CS/s?=
 =?us-ascii?Q?18gjTXwbc+LvbZeN9oFYqhdWSa0qf9VrtDC7n+qMT22YVc0UkI4dWj7lCg7c?=
 =?us-ascii?Q?B0SJNYXMOXjH+h3zMnPeDVeIzMoQ6P+ALyHbmqj+gkfb2kkPPYTIIwQENA00?=
 =?us-ascii?Q?QnkTn+3T0VrWb5EcUYokHmvy71SbdqeTurqiBF0aGQAqbrtuj2GPGnDPHloj?=
 =?us-ascii?Q?QkzZ2bwCJvv04oTAEeqf5dU5jOYtJFSXL/g4Uy+NAP+avxqm9thpkXIKxsda?=
 =?us-ascii?Q?/cVx1mrvMyDe6LxUtTRosUbC1B9pu6Lnwbhm2LphOgbItUXP6gIW7MQz1sCE?=
 =?us-ascii?Q?3Ib8pboaJRDemQtmpnyNuU7YYrajEUlCD81c58dAP7uGYBrhP5TZSpcVClNL?=
 =?us-ascii?Q?aSDOZGXWrwSOv9dEcdQdV9FzWgf/BUgvE41uVwA78A+jpdp045QGoHOyhgE/?=
 =?us-ascii?Q?Fe19IoVzs0hLr1WSBZHG6mm1018G1hYtWwHzhIz2Gje/Jj0671ug7/uvXAuw?=
 =?us-ascii?Q?rDkk2LPRsBnMVwA8LIqwZpEJvgj/oeN6fhTxD8DZFAXTKh8RK6Zhz42HITib?=
 =?us-ascii?Q?S1mqBgkGuqv48NbzE7CSUbhsG2A+LRlvcy87bItirhWSVg7KZQh4uJfC39H9?=
 =?us-ascii?Q?kdAo7sFfeNvRr1NqCPZsgg+YajxD4JKdLHL9CXKdmkgF+q8NJB5l9gwy2bT4?=
 =?us-ascii?Q?OiZrzH+QlNU+ysUn0d4wzsmGFiphI665cjPSubK5e8N3P3FVb4o+sTIYzn0f?=
 =?us-ascii?Q?S7O1XQcpWtsyZjV3/2/BHgqob4r4M3HIElHd1yGktSbOx+xJvYsyd3RZ8iy6?=
 =?us-ascii?Q?uQvLqxyRnArf9aqYbzUbnuQ70Ts72kNSORKsViaiZ+NZZAtz4iTINtDyNQAl?=
 =?us-ascii?Q?vUOzqpEpK6aN/Oa+4LmAB7Gig5/ZHUJTsRg4YnGzUHQES5echm4gXUAIzof8?=
 =?us-ascii?Q?BvBOnkB0BIux3ensiPUoRj6oKi1zzKnm/lVaHW6ArZH91Vf4YVXk2WhE3qRf?=
 =?us-ascii?Q?13fPBDWOydXUSuVwEeEcK1jAdO60wwBguMS7OWPuufkRPOS5/7twCn55vRUf?=
 =?us-ascii?Q?OfpXS2i9icaBoIE65qV0rQdr9miYjPujGNZIfRi/Y2uLGrwIO3slZH9mAuiF?=
 =?us-ascii?Q?uWERcLRDu0lua0CCsQdqzZT1bcbN/TxncoW4ACgd6jOog3hWQ1ppwSmt/t19?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc3db6b-21ac-4723-2903-08dbb53ea74c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:21:30.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEJnDj5GZes4djJHzyivmsUbxH+o1AEF3qKa6TuVllqgV6v2ZQIXMgzRDAgp+b4zTEB0NfV+kh+tchrtRsspPs/WZf3f/vbo/Da+KYES7e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8731
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 06:12:23PM +0200, Alexander Lobakin wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> Date: Thu, 24 Aug 2023 21:26:40 +0200
> 
> > Previously, we only needed RX hash in skb path,
> > hence all related code was written with skb in mind.
> > But with the addition of XDP hints via kfuncs to the ice driver,
> > the same logic will be needed in .xmo_() callbacks.
> > 
> > Separate generic process of reading RX hash from a descriptor
> > into a separate function.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> I like the patch, except three minors above,
> 
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 37 +++++++++++++------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > index c8322fb6f2b3..8f7f6d78f7bf 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -63,28 +63,43 @@ static enum pkt_hash_types ice_ptype_to_htype(u16 ptype)
> >  }
> >  
> >  /**
> > - * ice_rx_hash - set the hash value in the skb
> > + * ice_get_rx_hash - get RX hash value from descriptor
> > + * @rx_desc: specific descriptor
> > + *
> > + * Returns hash, if present, 0 otherwise.
> > + */
> > +static u32
> > +ice_get_rx_hash(const union ice_32b_rx_flex_desc *rx_desc)
> 
> The whole declaration could easily fit into one line :>
>

I agree
 
> > +{
> > +	const struct ice_32b_rx_flex_desc_nic *nic_mdid;
> > +
> > +	if (rx_desc->wb.rxdid != ICE_RXDID_FLEX_NIC)
> 
> Not really related: have you tried to measure branch hit/miss here?
> Can't it be a candidate for unlikely()?

I have not measured this, but at least in my test setup, I have never seen any 
other rxdid, so unlikely() is a good idea. If it harms some particular 
applications, we can always remove this later on request :D

> > +		return 0;
> > +
> > +	nic_mdid = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
> > +	return le32_to_cpu(nic_mdid->rss_hash);
> 
> I think the common convention in the kernel is to separate the last
> return from the main body with a newline.
> To not leave the cast above alone, you can embed it into the declaration.
> 

I am fine with leaving the cast alone.

> 	const struct ice_32b_rx_flex_desc_nic *mdid = (typeof(mdid))rx_desc;
> 
> This is a compile-time cast w/o any maths anyway, so doing it before
> checking for the descriptor type doesn't hurt in any way.
> 
> 	if (!= FLEX)
> 		return 0;
> 
> 	return le32_ ...
> 
> (or via a ternary)
> 
> > +}
> 
> [...]
> 
> Thanks,
> Olek

