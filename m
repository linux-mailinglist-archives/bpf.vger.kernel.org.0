Return-Path: <bpf+bounces-9216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4AC791BAE
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA0C1C2092C
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 16:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A266C2EE;
	Mon,  4 Sep 2023 16:37:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1001C02;
	Mon,  4 Sep 2023 16:37:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FDF9D;
	Mon,  4 Sep 2023 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693845445; x=1725381445;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UDoKC5kA3eYV5nwX6WtQ3qWZ3ssX2vDDIUp0DJzujfc=;
  b=eQxfDFG5gBCSHJF1N2MqDgOe3Kw03Y5LiATUctFKwSM3lSE2sZ7z2/Tf
   sZotCtPDQcoQys781zC0T+1+KFcYhPlQjnpLaCXBCdebqVlJKzgYP/oYE
   E0jrDkk6oFp2LAxsYSyj54HENFKk+AbD0pd8S95wpAa4wVDyfR2a7fdEh
   u0EdN37UGJRmS1o6gQ2YdMuoRXhBqT1qhUKxCJUlkVjgtmmriGU7T0p5A
   L9bNBb2uv6/hwjygn2EeHWAdnqohqih/O7MyCzkgQHdvlkrEHbBeTrwBR
   EYacYkk01eDXrrJH9R0E4euoCewoDPj4aASK3asRyDylHCWM37fe33qdr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="361668148"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="361668148"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 09:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="743990693"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="743990693"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 09:37:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 09:37:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 09:37:23 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 09:37:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjRVCDD/xC3srEHK0gqZxXWLeXRTUujtOqzMqphtIDonUqM7Fxsdw6ha5veGAU1s6YxehCdr9xB8U3C1+GNYAnVVdxDkddIk84LAhRWASm9DY5a5XdR4CmN/blxz4XxJSxSKvJO8Jjl2vZ7RE/vegd5dCyNe23Ln416RhKSexBv1r37w6UCG9uMZZi7kHVgAWLcPwdLA7/yKjHUyd6PrlkdsqaYIfmAS/MGDbycfMo313q1PFGPLSuxbu4L3dMvlzqftPtgVfXx+eKPMV+zgOtsfRH8SrNbyajnzSn6Vuf8IgbSJFr6Y6Zu+KB23SolxMh2EYaOd06eiQ2col4BXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwyzYpbyIAfhipKdpMUTwYEGgabJnuD089hWPrFncKU=;
 b=NMuxLCdFz5ol8h+jxQ1lD/UbhXtFDeONKX+l4q1zDQ8FOCzA5rP7sOlrL0DkOATSop4yA5llOX69req33PmU/1HypKt8sKCuxlLojW1D2hrO8zClSrZR8mTL/Ay5W3iXoAIXn3/Uix8a/zYkUBTrmp1cE6O3twcc4ymkf3vwSqVTnbzOEleTOJo3ND8InYf19D0YkDR8agxCfRKDsva2WuAIaGM8v9RlViPEjIh/G72BNGjlcZNr4FXoDkI/e+3jWL7OQktDoqXwLc02mYr8nPg98OV2Sc3CNVX5vCiNQYczR7rHUBXPuaPa8hvLAFKMkDv+hh+vtxDij8CX9NtH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM4PR11MB5280.namprd11.prod.outlook.com (2603:10b6:5:38b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 16:37:20 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 16:37:20 +0000
Date: Mon, 4 Sep 2023 18:29:03 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
Subject: Re: [RFC bpf-next 02/23] ice: make RX HW timestamp reading code more
 reusable
Message-ID: <ZPYFz2QTytn+wTmG@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-3-larysa.zaremba@intel.com>
 <ZPXwIOxfiNNZ55+W@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPXwIOxfiNNZ55+W@boxer>
X-ClientProxiedBy: DU7PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::20) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM4PR11MB5280:EE_
X-MS-Office365-Filtering-Correlation-Id: 1076dd0a-e79f-418e-db93-08dbad65339c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGp6ftkVSHtWNGOoaUScVy4lsAOxfBO7yhwnIrFKJFHLzMUQaIxeL2VLvcWZqshtMSoVnsKwqpwcb4LHRRZFUZyctoGRC4MQXtSgDV9Lb3zQNgF2uoCEQ/iwiHlxasM8MCrrSAm62EyzgElXrmJcXzvcU1WwNqjA6t19W9Oh9RmfSJoEGbEsRaEx2a031+VFZR90Y+KsBMnZOxSJAsTaKto4xux2OSqRMUdW+BYrbuhnl11Ia2/5LiwUrny3kYh3t8aq7bK6HL0/KtzVoI5YbM2Cr+7wQ/WfDNEfSEz3Kuo7QuOlBnKUKpIStzjCEcsDsfFl4oRni98NKaU1esT7oZXuN7x8s97K/OWfuh/jLqQ8kf/ADs2SzKOwgB+CGRerNyPyId9RQN3wt/AYhzupbI20oaRJ7UJFShN89eEKY/DMRl5sge6H8kLQivq3V4oGQ/dFFVpjzCYeohI8Yy1YtLrH2tEMF3uWk+8BTyjUo+iAKcVTpV3xyfA2f0QCZtAh5hIYOTdZ8/3+MRsONPcg6QeaGHImubNZzfuW+sq+jRAEAXtFvgIcmvy+txs6zQd/vSsln9F3ScZS3CdkCoBiXSWMqLCbuiMxu7IMdtsh1C8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6506007)(26005)(6486002)(9686003)(6512007)(86362001)(38100700002)(82960400001)(33716001)(83380400001)(44832011)(7416002)(41300700001)(8936002)(66476007)(316002)(6636002)(66556008)(54906003)(4326008)(6862004)(5660300002)(66946007)(8676002)(2906002)(6666004)(478600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DQoVkaaSFfAzRE0OiiJNQnajx+aqdnOcgexEOl5emQb1xI1acmcUyUY1ndBO?=
 =?us-ascii?Q?a6dLw9aPtN2iFOjpUTi3DYFz6b+WhyRpq4hGFFx+TUscx7iGY936KZ4y/U8Z?=
 =?us-ascii?Q?OJtSJ19cViDUICy+9iclOLgnnqIELa5Ek2C8vQuV11JLiNJCCsfldoZ9ilpM?=
 =?us-ascii?Q?F1DxmiTOL59+0cnyPIOWsomo543a+Wke3FVtPGTbpYVuqtIqthdHs81iBSyR?=
 =?us-ascii?Q?BHq+a6Ao2abM3BW2App4ozafvt0PxrTZb9xK+iXCzWegxUQqL1wmJ87iLfEE?=
 =?us-ascii?Q?QzgFUmnnTDwMZlZPO/x7Ftm1RCLuFPFu/vFZUS6OBDUKCTwKElVc9iHz7+KS?=
 =?us-ascii?Q?RCzTLdETelgp5IxIezyqitbX0eTOlaQ3wGKu7Psrl3F4Ta+cwAMHPwp96OuG?=
 =?us-ascii?Q?Wlz6MhVVOAl9i/2fUIo2vOzBTMYFMV0Xpdy1fHYSjz60lRK1mld5yjQb9igv?=
 =?us-ascii?Q?egbiCDWuDG4LfvPEzzjlvxUWWfTbc+A/1l+kVb9kcpOnRN+nYLzFzkMuQKhO?=
 =?us-ascii?Q?/cVSsvMGyyhFMRg5xHek8ScwVFImq4r3Q7bQWtt75RrcIsIGQWq5Uo3aKcxA?=
 =?us-ascii?Q?0urxgCbfzSVhWclrvUyP4Wvl/WjdM/Qo1tdD4NetM/+JtOLMqCuvPtFRXomL?=
 =?us-ascii?Q?ye0wouz3FM5dlKDR5UvoUZKqS3ZJqBvFmW2bEngZ4Esv8JNYN3O10MVA6VVA?=
 =?us-ascii?Q?6zLOIX+AtfBKyRgg0cScWmp/IRgmWl836btxj9WA+zjBB7MFqoBntjSgj7hH?=
 =?us-ascii?Q?SbBz0U2AYKhjPKP+491pPhDiLKmxnCmeVNiFWkrTxTg9BMRqeiM/FNbTefkc?=
 =?us-ascii?Q?W5plDhqEBzAPqHD9pwD226v7CTM44HqoWVPNNHDZ/XsnkQyOgFaphGxR6ZPp?=
 =?us-ascii?Q?opt4w+rSQ8p6mIsyX5mIwslJeDRLjw/UB6QV5G4JQLtQY+R/x8WxJLYXyjRS?=
 =?us-ascii?Q?L+n9joxczVVbAZKuexwIzG4ZkmFXgqUqIoWlfYRBQ+a0GG/F4TsXeC4/sSt0?=
 =?us-ascii?Q?fLBcnv2smsFM0DSlM/eNeUXXqrWxCXjNLDRgNXOCjL3nxk2IXXRT+PsSi9/3?=
 =?us-ascii?Q?0pHCLszvB2oJxr+wO1gBu7dTd6GFEih1czXsUfTiHxqUEVFMhOrhI4gZlulD?=
 =?us-ascii?Q?3SqTo0NRAs8e9QFN0mw3yVQEJo0GQsKvSr4rHZIPHB8lYZJFwVf9VDKfpJLU?=
 =?us-ascii?Q?q9fJEqZHOQeD5ypeTUIMRX8c0sTRf6h60/N9bgz4wN3lW+n2VcmHoMV4C46w?=
 =?us-ascii?Q?PVVpEQZ4USq9852xKD44QlWB7m3jhSuTWU2HwmzGITYGSsiRqsIXUnr7uuk5?=
 =?us-ascii?Q?OIsrzOpY/Sp0Ecjwf2pSHK7kS6s03yf3OHRaDYFxp38AUVWC8MCts9kXuPwZ?=
 =?us-ascii?Q?9srqB3ykJCw++AbsjrBpa2Byryl/aNWEHe4BJofujKoHujrgTzDPe07fIBTr?=
 =?us-ascii?Q?nUljpiW6Yq3vnC70jn8Yny30BssLf8CBAIqrUMsOZDyHms9HuU+xi8klCzoY?=
 =?us-ascii?Q?tiUOaHIuc0R4LCHla9s5qYysdJyBizGMAur3KvruZB27WnZxkoZQi7E4hej3?=
 =?us-ascii?Q?FZEnSt9nazlriC/p8zMR9KhbmzyRCM0KC0xDK3lFQ9Pq3LFt/UUooKAM0kFY?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1076dd0a-e79f-418e-db93-08dbad65339c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 16:37:19.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJeQrujdzbVQK8G1l4h49FTt73UrsfwGBgO9xrnT5svHRJk250FVp+XzjLqA1st+oXUBTWhicWx/k1cytg8Yt+NyC9jdhKS36+f2SWlKPps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5280
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 04:56:32PM +0200, Maciej Fijalkowski wrote:
> On Thu, Aug 24, 2023 at 09:26:41PM +0200, Larysa Zaremba wrote:
> > Previously, we only needed RX HW timestamp in skb path,
> > hence all related code was written with skb in mind.
> > But with the addition of XDP hints via kfuncs to the ice driver,
> > the same logic will be needed in .xmo_() callbacks.
> > 
> > Put generic process of reading RX HW timestamp from a descriptor
> > into a separate function.
> > Move skb-related code into another source file.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_ptp.c      | 24 ++++++------------
> >  drivers/net/ethernet/intel/ice/ice_ptp.h      | 15 ++++++-----
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 25 ++++++++++++++++++-
> >  3 files changed, 41 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > index 81d96a40d5a7..a31333972c68 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -2147,30 +2147,24 @@ int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
> >  }
> >  
> >  /**
> > - * ice_ptp_rx_hwtstamp - Check for an Rx timestamp
> > - * @rx_ring: Ring to get the VSI info
> > + * ice_ptp_get_rx_hwts - Get packet Rx timestamp
> >   * @rx_desc: Receive descriptor
> > - * @skb: Particular skb to send timestamp with
> > + * @cached_time: Cached PHC time
> >   *
> >   * The driver receives a notification in the receive descriptor with timestamp.
> > - * The timestamp is in ns, so we must convert the result first.
> >   */
> > -void
> > -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> > -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb)
> > +u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> > +			u64 cached_time)
> >  {
> > -	struct skb_shared_hwtstamps *hwtstamps;
> > -	u64 ts_ns, cached_time;
> >  	u32 ts_high;
> > +	u64 ts_ns;
> >  
> >  	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
> > -		return;
> > -
> > -	cached_time = READ_ONCE(rx_ring->cached_phctime);
> > +		return 0;
> >  
> >  	/* Do not report a timestamp if we don't have a cached PHC time */
> >  	if (!cached_time)
> > -		return;
> > +		return 0;
> >  
> >  	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
> >  	 * PHC value, rather than accessing the PF. This also allows us to
> > @@ -2181,9 +2175,7 @@ ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> >  	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
> >  	ts_ns = ice_ptp_extend_32b_ts(cached_time, ts_high);
> >  
> > -	hwtstamps = skb_hwtstamps(skb);
> > -	memset(hwtstamps, 0, sizeof(*hwtstamps));
> > -	hwtstamps->hwtstamp = ns_to_ktime(ts_ns);
> > +	return ts_ns;
> >  }
> >  
> >  /**
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> > index 995a57019ba7..523eefbfdf95 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> > @@ -268,9 +268,8 @@ void ice_ptp_extts_event(struct ice_pf *pf);
> >  s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
> >  enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
> >  
> > -void
> > -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> > -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb);
> > +u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> > +			u64 cached_time);
> >  void ice_ptp_reset(struct ice_pf *pf);
> >  void ice_ptp_prepare_for_reset(struct ice_pf *pf);
> >  void ice_ptp_init(struct ice_pf *pf);
> > @@ -304,9 +303,13 @@ static inline bool ice_ptp_process_ts(struct ice_pf *pf)
> >  {
> >  	return true;
> >  }
> > -static inline void
> > -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> > -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb) { }
> > +
> > +static inline u64
> > +ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc, u64 cached_time)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline void ice_ptp_reset(struct ice_pf *pf) { }
> >  static inline void ice_ptp_prepare_for_reset(struct ice_pf *pf) { }
> >  static inline void ice_ptp_init(struct ice_pf *pf) { }
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > index 8f7f6d78f7bf..b2f241b73934 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -185,6 +185,29 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
> >  	ring->vsi->back->hw_csum_rx_error++;
> >  }
> >  
> > +/**
> > + * ice_ptp_rx_hwts_to_skb - Put RX timestamp into skb
> > + * @rx_ring: Ring to get the VSI info
> > + * @rx_desc: Receive descriptor
> > + * @skb: Particular skb to send timestamp with
> > + *
> > + * The timestamp is in ns, so we must convert the result first.
> > + */
> > +static void
> > +ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
> > +		       const union ice_32b_rx_flex_desc *rx_desc,
> > +		       struct sk_buff *skb)
> > +{
> > +	u64 ts_ns, cached_time;
> > +
> > +	cached_time = READ_ONCE(rx_ring->cached_phctime);
> 
> any reason for not reading cached_phctime within ice_ptp_get_rx_hwts?
>

Not at this point, but later for hints, this is read from the xdp_buff tail 
instead of ring.

But maybe it would be actually better to leave cached time where it used to be 
for now and instead later in hint patch replace rx_ring with ice_pkt_ctx in 
ice_ptp_get_rx_hwts(). I guess that would look better.
 
> > +	ts_ns = ice_ptp_get_rx_hwts(rx_desc, cached_time);
> > +
> > +	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps){
> > +		.hwtstamp	= ns_to_ktime(ts_ns),
> > +	};
> > +}
> > +
> >  /**
> >   * ice_process_skb_fields - Populate skb header fields from Rx descriptor
> >   * @rx_ring: Rx descriptor ring packet is being transacted on
> > @@ -209,7 +232,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> >  	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
> >  
> >  	if (rx_ring->ptp_rx)
> > -		ice_ptp_rx_hwtstamp(rx_ring, rx_desc, skb);
> > +		ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
> >  }
> >  
> >  /**
> > -- 
> > 2.41.0
> > 
> > 

