Return-Path: <bpf+bounces-15235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E0C7EF468
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 15:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050911C20A65
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D2636B09;
	Fri, 17 Nov 2023 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IO4gOZch"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B6511D;
	Fri, 17 Nov 2023 06:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700231211; x=1731767211;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EFhXml7CVHscFI/zYp0FSrO1a227NHsPRizlqOOAmuU=;
  b=IO4gOZchsrHyn6hJMXD4cwnxACAJPC/cFn4siNkoNYJGNSOY+K/88YpD
   cwD0Nkipdr77AB0NZwOmZCItWdD0PLwa/JTkzl/gE/ARBizJipf7ILOVy
   gbu0ia902ArpE/wXP3klPbtEiSFY2Fj7DjrDrYPVakA5szfwnmEF89tCd
   d206zlROVE9V9izHV0vKYqMWW+ArxQ7+3CGwVwmbZAkhXp7E9PN729LrU
   lhavBYTX+ec1ANIyyV28Zfw545ameONuqDglWfQ+PJ9IQEEGwxMat7tsO
   jj7rukSb23sr2kWLvM40Zs7g6yUpPAVPf5/d3VkQrikFfRjbrimhdo7ou
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="9966525"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9966525"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 06:26:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1097109961"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1097109961"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 06:26:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 06:26:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 06:26:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 06:26:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPUUeRtcKh0iOz3QwBKSG4FxwjTRmb/hYSvi4blCGtKA5Hzp637LoXfuMVBb2Fbsf5Ab9Aw6s723KD4exjbrxIx8ckCRXG3Jdodx70XfGszTI49ANYqhPcuNODTxtfDDcdqNk8aIGN9if+orl/0S5mY+oITdumgmdlTMvFxh8Vqo+CV55iQxAOl0al06LNSQd0BdpCizeYwTNNO7xxZ4INDvb68HXNL+iOUKuFNBbzaNmocSxqTLuCzxsRyfjMNOdVg2oENEukWnN7tc17V6XONRvWL1Wd9pf+oYLocOFTqKxRx19SbOSkGwlU9KnilAn6jjzOqJIhcyzSVDRlqJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ2cOGHLs+LzfKQ05Ewk5b5iM32qdNjEAnCeK+KHM+Y=;
 b=SvjtdtPJ0LOBFX5YMbZbXlNmim5QuiJ7M5Xz8W5QpQ/7aRQrObngTcGuM5ay+dNVuo17ccsUNtXyuQ7VVQS/ZetP07LA+OeRIhsm9tUIK3eb/xEQ9VrKFr7i1E6lvGgeLYCRFsChjrL88n3H9mnUH3sIMRdNRD3g5aKNS8eigqbnm6LXlhLbHhKB+3x41uNwYe9jRkI2JoTXl1a1GaOCYtoE3d/pE+2dF7zOn5eDrLT+D2XoMdFfbEpI8OudtL5QF7/LBwlsSE8Bh4+YvNVprepPVMT2wuNRTGNBf+JYYMaEW3SJ9kgPcNCOwiZzX0/aop4J+mNpWJeDzJU4wSUgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ1PR11MB6275.namprd11.prod.outlook.com (2603:10b6:a03:456::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Fri, 17 Nov
 2023 14:26:45 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%7]) with mapi id 15.20.6977.029; Fri, 17 Nov 2023
 14:26:45 +0000
Date: Fri, 17 Nov 2023 15:26:12 +0100
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
Subject: Re: [PATCH bpf-next v7 02/18] ice: make RX HW timestamp reading code
 more reusable
Message-ID: <ZVd4BJlDcdfeiLPj@lzaremba-mobl.ger.corp.intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
 <20231115175301.534113-3-larysa.zaremba@intel.com>
 <ZVYzCRFm6gc4x+VS@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVYzCRFm6gc4x+VS@boxer>
X-ClientProxiedBy: WA2P291CA0034.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::7) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ1PR11MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 77600b7a-63e3-4c26-39fa-08dbe7793a01
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJinElf7mRbY6v/3jrOBtKpFQvja25dTT9noKB/kmc0Gy87y6U1zhjgtyKA+0U53cPSprZ5fURDXKNvUrhguktzeJ9VOUDIyWO1ByuStvozDYNgwvcICUAG1MmXuaS41wc5mFOEaJ7QhitWTv7lAin4SbCF23eidInnqR8+Xz52H8Kgl3CmBd4G/LiH3q0LTvBXxa8QndlFHcmOADOaZgtfWXGWsy0qj7aj1yiQcayTddrR8P2ioo2HUsnHglYRYw5WxVW+7qTGX+EptKJMxppW6HlQq3uSpZHSpgAMebM3x4w3CDX9FC6LNwURHAK2SYqgbuAPgrfZkefwocCRXufO9Gps+FMn/WFPZm5408HqnVZ1bespoKK8KnBzf2HoHysDBMH5UjbWwraJfUayPcWXYsNPbM8yBtCg3/1wLpiYBJZ56i6nIz9T9DxrlrRR3QtWAVc1j89OL2rqlrCaD7psKp3e6ehbAmrdhg1LE5eIlV+M5p0Nwq1QzsjT0Odi2ghl3Bjd/OnQWSz7NPPA2jpDbGDiB7gf9ANT72MYVY6orsmU8/B941n/trT+d1bLa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(83380400001)(38100700002)(66946007)(54906003)(6862004)(8676002)(8936002)(66556008)(66476007)(4326008)(41300700001)(82960400001)(26005)(6512007)(6506007)(6666004)(478600001)(6486002)(2906002)(44832011)(6636002)(7416002)(316002)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Muc1vSPpEnnFuwoGpLqjeanV4aKNorZfF7OmnODyBQKXMEvb+B+tOCA/xsRt?=
 =?us-ascii?Q?ADZBRTiHkswNVBO2jAn9o1SpJ/cOmGaQ7NKOc0LMp0p69OKQi4AoFzRFR33a?=
 =?us-ascii?Q?XO/OfVeGIQsMSOCh2p1BSjUXaRVJ55veqkmr+Yx/G3oAhLQrN0UHvRkltl4U?=
 =?us-ascii?Q?mHqg9lI+kO+BlyUhrGqghcFqkn382CT28rCGirmFf4SS3RBeJ6u269ffr5gD?=
 =?us-ascii?Q?sPomW5zvIyGqMv19KHJE7rEU92l6k4DZCZ2wBwAtXGvHHwZ0vpxiXmoV8zsH?=
 =?us-ascii?Q?DwniHaL6jf33eyy2nP39tOR4sABqOVNqchdHAqfrbTmbzzMujE510ZULqXHD?=
 =?us-ascii?Q?PvO5dIokdtgks8uPYdXEWmjol5E5+kfNd3HjRssz7uQQJyecaK2SjlWUje/U?=
 =?us-ascii?Q?/Y7I9thO7bFpj1tb9nULB6xPGlsetsTxi5mQY2XxaBoGx/CJqdZ+eDoAQr75?=
 =?us-ascii?Q?x8JJDfiC/WH7PzkKJ/fLQv9JTyLYDeKnxSYbH44+NUlqVfHFz6P/K7RbJMCm?=
 =?us-ascii?Q?FrHWBiY9nGJj08vE2/yUlFb1bdwYmFDNo+mVjN4EtTxj8pfiCxGqE29WCY5a?=
 =?us-ascii?Q?S+nYhUDqnGSrFCuyVGrAwwwOGOn/5qFfsl5O++bqX11FLCBapxt/9QI72EN/?=
 =?us-ascii?Q?aQKeXpVm+8cwNmeyCMniKuJcBtzTCyPfMwuGGw6HaNAzLtbdBg1xCVBhC2h7?=
 =?us-ascii?Q?vu7YotBkCwQL4c7H4b/ySGp3afj4BKyez4ji9HP7ZhNPO0cnfelwHByhWYPY?=
 =?us-ascii?Q?Sy0yzA4zHsM1X8vMLWY2wfzD8Zge82WDjY8wDRuJmBs/6yg10UlMPgrFszO0?=
 =?us-ascii?Q?c6UP28yzGOiBPQpY/f8d4e6vgphXJF2kLv1I/RaajHOQgkeUM77KZtL2m3/J?=
 =?us-ascii?Q?X/JAMTJVSdTkm/1dbeU9wFadBBIXS+zhifshUU3O+TR+pudOVnXR2yCx3ZkW?=
 =?us-ascii?Q?6XL3Cd//RsO9z60pahVjD4RzuN+RJmoTSadOPigWjWraJ8F1soXQXjkkBT9u?=
 =?us-ascii?Q?wG+d1heaiuos1KqIfWGUuY4XWblt8wIKBUJYLFKnTVXbOgZpGqrGmKwULMWz?=
 =?us-ascii?Q?PKUHtKXasVtU0vsrploNqfI9OlwmlodmWWwqiJjYR9GCgw5tPy6cFS6S/SZY?=
 =?us-ascii?Q?pfWPHKwGesoFlAyZB5hnCK3zPVrGqtG8wSs4+5mHT71d8EKTzP4VUF3iGGbM?=
 =?us-ascii?Q?AYrrf+VydVINVg6tJqhXJIYYe97Mr1CmE1yeQ9nB7lf1dGrkCgjOu+dEjNou?=
 =?us-ascii?Q?sC1XF2WlffdmYYsSDiR0RMDqgfWNlX36R+IvmPB5dKfYDKlTzTx7OvRgxO3K?=
 =?us-ascii?Q?SgVJo+YQSqIn9cmjuoSVXT9fOuutVdvr2mqPEfeJ7m/aleJY/OHvidrIwJTa?=
 =?us-ascii?Q?ztsYUs6LKvwPn3BuZOT+3DL+E8bDHmAArwooHpfZm/xH01471Jrn+bptk6LG?=
 =?us-ascii?Q?Y6BDQejrTO28HhMnGTbcUwDAKvA8shbtqgA9581nsyDofWsirlPZCWsIyY6F?=
 =?us-ascii?Q?OSBdfetlR8AjVbM6wcB3nRYdwh+wDnG7lKdxw69+1p+C928tpmQTPqz47g8y?=
 =?us-ascii?Q?s7jOHgRbOpykcrKXDrjoEJMXu0x1F4mGWStd7+vipmvgNmBUpH1TP9oV5bx9?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77600b7a-63e3-4c26-39fa-08dbe7793a01
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 14:26:45.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPQsfCt0HrIDmH2aKn1Tggkv4Ui1vgLHHjS9oGIrLHp45p7rQSXNaTRCLjxR6wWJwv/0N8GgnbrL00qnZRK8+OE4yQZKEHX59pln/hUepPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6275
X-OriginatorOrg: intel.com

On Thu, Nov 16, 2023 at 04:19:37PM +0100, Maciej Fijalkowski wrote:
> On Wed, Nov 15, 2023 at 06:52:44PM +0100, Larysa Zaremba wrote:
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
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> > ---
> >  drivers/net/ethernet/intel/ice/ice_ptp.c      | 20 ++++++-----------
> >  drivers/net/ethernet/intel/ice/ice_ptp.h      | 16 +++++++++-----
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 22 ++++++++++++++++++-
> >  3 files changed, 38 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > index 1eddcbe89b0c..a435f89b262f 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -2103,30 +2103,26 @@ int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
> >  }
> >  
> >  /**
> > - * ice_ptp_rx_hwtstamp - Check for an Rx timestamp
> > - * @rx_ring: Ring to get the VSI info
> > + * ice_ptp_get_rx_hwts - Get packet Rx timestamp in ns
> >   * @rx_desc: Receive descriptor
> > - * @skb: Particular skb to send timestamp with
> > + * @rx_ring: Ring to get the cached time
> >   *
> >   * The driver receives a notification in the receive descriptor with timestamp.
> > - * The timestamp is in ns, so we must convert the result first.
> >   */
> > -void
> > -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> > -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb)
> > +u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> > +			struct ice_rx_ring *rx_ring)
> >  {
> > -	struct skb_shared_hwtstamps *hwtstamps;
> >  	u64 ts_ns, cached_time;
> >  	u32 ts_high;
> >  
> >  	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
> > -		return;
> > +		return 0;
> >  
> >  	cached_time = READ_ONCE(rx_ring->cached_phctime);
> >  
> >  	/* Do not report a timestamp if we don't have a cached PHC time */
> >  	if (!cached_time)
> > -		return;
> > +		return 0;
> >  
> >  	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
> >  	 * PHC value, rather than accessing the PF. This also allows us to
> > @@ -2137,9 +2133,7 @@ ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
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
> > index 8f6f94392756..0274da964fe3 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> > @@ -298,9 +298,8 @@ void ice_ptp_extts_event(struct ice_pf *pf);
> >  s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
> >  enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
> >  
> > -void
> > -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> > -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb);
> > +u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> > +			struct ice_rx_ring *rx_ring);
> >  void ice_ptp_reset(struct ice_pf *pf);
> >  void ice_ptp_prepare_for_reset(struct ice_pf *pf);
> >  void ice_ptp_init(struct ice_pf *pf);
> > @@ -330,9 +329,14 @@ static inline bool ice_ptp_process_ts(struct ice_pf *pf)
> >  {
> >  	return true;
> >  }
> > -static inline void
> > -ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
> > -		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb) { }
> > +
> > +static inline u64
> > +ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
> > +		    struct ice_rx_ring *rx_ring)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline void ice_ptp_reset(struct ice_pf *pf) { }
> >  static inline void ice_ptp_prepare_for_reset(struct ice_pf *pf) { }
> >  static inline void ice_ptp_init(struct ice_pf *pf) { }
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > index 17530359aaf8..c4dbbb246946 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -184,6 +184,26 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
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
> > +	u64 ts_ns = ice_ptp_get_rx_hwts(rx_desc, rx_ring);
> > +
> > +	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps){
> > +		.hwtstamp	= ns_to_ktime(ts_ns),
> > +	};
> 
> could this just be
> 
> 	skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ts_ns);
> 
> ?
>

Seem so. The previous logic was basically:

memset(skb_hwtstamps(skb), 0, sizeof(*skb_hwtstamps(skb)));
skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ts_ns);

So it was changed to a more nice-looking '= {}' construct after Olek's review.
Honestly, I've thought memset serves some purpose, but after actually looking at 
the structures it does not seem so. Also, not only intel drivers do such thing, 
seems like some historical artifact.

TLDR: will change :)

> > +}
> > +
> >  /**
> >   * ice_process_skb_fields - Populate skb header fields from Rx descriptor
> >   * @rx_ring: Rx descriptor ring packet is being transacted on
> > @@ -208,7 +228,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
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

