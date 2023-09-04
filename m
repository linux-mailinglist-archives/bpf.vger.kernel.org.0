Return-Path: <bpf+bounces-9220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D13791CBA
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 20:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1CF28109B
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B40DC8F7;
	Mon,  4 Sep 2023 18:21:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30731C02;
	Mon,  4 Sep 2023 18:21:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F271AD;
	Mon,  4 Sep 2023 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693851664; x=1725387664;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+1dVQzf2elryf0E7GkhBk5PJiZ/15SB/ZbybmiSNyRw=;
  b=dk06lSKDIaHuvKnrNuTKdeCjMY+L4+ZeyQMjszSeIlCfY2EJQOVejCGc
   5hxyE07krQAjbjNdqDmpIeI38vG8XYAJw6eLf/kt6jxtoyloNEnCKFQfP
   io+hdBM9Mz6tGQK5nGaLZpx7XDkP/AJI2FznCEOUliacayDxVLevFeKyC
   8GJAmcHpo3rpyeBWtZVoj1EqfcjXPV4A4gDZHJQhKJO5t8GICoBymvmLR
   +D0L3o5bqMC9Cy3mMSW+qlkd/E839++X9In+mlkInm4mwtOmKT1wg7yjc
   e79vTTv8F96QGajtE/EDWrp8cgzh5mWyDBpkit0qU9eS7xC1aNwoP7aXD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="379358568"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="379358568"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 11:21:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="775931691"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="775931691"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 11:21:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 11:21:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 11:21:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 11:21:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPrCscPSDCU3EEfP0ghKfKxFJeMKXEkXKhcZ9EDnvv11SNgpjv2Zoz9sdlZG1vsuZ1vOcTt2lpK6uKZI/TQEhiX2F0pFCaLZfqBkD/HxbRpReMXnOHlYgP6z80imePVR5y9xf7vbUUZMbjVpXiJPOquH5wqU0UeOz2shGuk37AJ8PLQhhg/chI2fnLKI76F9wO3WXQjgR7Y1LP4m1rC8z0DSoi+kQoyKvbfRCBN5Zo1OH/Vxebg8dFgN+8Veor9GrtR9emsjVokahxqSx/DE5+QIMwCaAUKiVSfU/SBilMG0HY1I0IkqGWcCTmVAe00bMPOvcL7EmTTbQn6xZWsKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOF1cgmEKkoXbqmq2//PR/6saA1o2rewiQ57ZGcHil0=;
 b=NqJe4dFtLNdZLaY7HUPZlVhPIIl+UF3sS7KAxZdmloowxIg7R/qnAMZu4P/0Rw8f8rBak0FJE3s6GcY6e1EVrXPlJrqGWAjNLlYhQnINjlzErCypFrlnh3RuKhA2M72/0xGdHETKy1yYsJc8x/H1VkTX1DOXCszgHYL++f7OPN+5Mbu3j6zm6VzCWz1Iciae9PkXy+cbyk2+CPvFGXJUIB0i/51FS/JIweGe9tj6vKKQiKzw1vFMq3yCPIOBKFDfq1UpW37g5Es2a8ASOlYKRl2JiGJ6JC3WmHTynqFsL1suLI3Lt/87Tt4/yzCOf12poOVCERlfokwxU6HwmWtQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB7753.namprd11.prod.outlook.com (2603:10b6:208:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 18:20:56 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 18:20:56 +0000
Date: Mon, 4 Sep 2023 20:12:41 +0200
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
Subject: Re: [RFC bpf-next 06/23] ice: Support HW timestamp hint
Message-ID: <ZPYeGW3b4J9G5rjT@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-7-larysa.zaremba@intel.com>
 <ZPX6BXF9RIA0KxQk@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPX6BXF9RIA0KxQk@boxer>
X-ClientProxiedBy: DB3PR08CA0026.eurprd08.prod.outlook.com (2603:10a6:8::39)
 To SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d255afc-6402-4d40-7001-08dbad73ae25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2k8/zlWFW9/kOQuenNbyHY0LicMhi9Fy/rkVZn9okKCQfzr8ou1C9N8Wq4ElCotAoPSekD5UwinIvUn1b4JAdTbevNu8+FUZQaNQBX8DQTqCUz/u21CTTdQCUwd41GNzFi1Sd+toBok1I2OHaWVVTyUpTxBeB5ID0TDHfdBsmPD6HG5uM/bO4lUoD2xfCoTop0UhDvkCWKTitW+MjTp3brNjwjlBr0l9fQcWEuVsroF4P1uP2N0hBXvEWgZNil+f/hL1O9b0abIhh5UKRQ0UJc0pi9bGR4sbSaiL4WaarLJJC1nIczF6Nh/pU53JknoOUsDtZWQPeLL64FJPH6vhF+kI164PUqPD878c5dId4jvESO9+NlJY5nGWGzYOez5qER5N4ghqdLqZV6WsWD/la8eg2sea5UZvoydeRGwbBaKCg74JnCppm4vu8usWQGh9li1iAQ0xYSayo1QNsucL8BMxu97FPqg0JOZY98WC8cLkLs6IIikiRJurcd0H1CSiZx9RF0kYzIjVx/3Mr6o/x4cj/DWOU/vpsfwT57ejJFk/lwqkuv2J3oN9a85C271j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(376002)(346002)(39860400002)(186009)(1800799009)(451199024)(478600001)(6666004)(66556008)(26005)(66476007)(66946007)(6506007)(54906003)(6486002)(9686003)(2906002)(6512007)(33716001)(8936002)(4326008)(6862004)(8676002)(6636002)(316002)(41300700001)(7416002)(86362001)(5660300002)(44832011)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gvap+bEf3xN9gKyHr4+D1qJYL3xqgh8A3iihZv8tJnaC80lNenmy1sQug6/y?=
 =?us-ascii?Q?CKKB4SFnw95ANLCyEVO0hsaTS+gAiaVVEi+CUt30eM7oJWTWy/8OzRxpoVkq?=
 =?us-ascii?Q?Wdg5hF47kSrDLbXnWPA2cxJzGbMpbbR/4MSYjiqXhhnCAeBKWOERcq+YTerQ?=
 =?us-ascii?Q?zWyd5srayl3gFQ425r8qT9jEx9PB/VWABQqmNfkadPhlDEGi4tLCh/dVON63?=
 =?us-ascii?Q?JV1SKlHpK2Mr/bWsuc3BXHsZf21YFMGTvaAXyKauaYhRwP0jwzhJauv+D62t?=
 =?us-ascii?Q?jBsLhYJb5xevh1GyUnz5OdVcKFlQjeEQe5SOXe8xIM7g3PxxCOHsUWnA1tnO?=
 =?us-ascii?Q?vhX5DC5GzbAHS+sZcaCsmYVcGWm0rEU4FQj1X+GW1zpm5sN0AA2JR+GiOtOy?=
 =?us-ascii?Q?6p0Njf8A40SLdsDOI4/Yneaz2VZjXey7aemmOn0UONHNvUTtrTfepKbOLdCl?=
 =?us-ascii?Q?33a/pq1QpMxiS1/AIex9aG4Lcu8DVwYnbdH31K/j3SKmphwPE4RdVfXgy371?=
 =?us-ascii?Q?c/we8TsaSjlQISlyEbX+LYJbgacadINKKMtz7xb1eyBxasHwMM9LzAB2AQac?=
 =?us-ascii?Q?T4Wc9dd1aCD460l7kF1Qhe5uoOO6CYNiYjbOnQvdQYCgkZzdp+B7t9OwNmll?=
 =?us-ascii?Q?WSP0dBUTc7lTJkjTM27Vc45nwGeHlKoB1zT8XVh1o5Whd96lV9lq71z+Zf8W?=
 =?us-ascii?Q?MmUGVFdVfgdt/OxpgWGiIsq9VuTIn0Xjd5JCIsGakXTU18NSJB+NMU6JlzVH?=
 =?us-ascii?Q?k03PnlM1Ngmfyxp4s6TjasBiZ604nZZOdK33/CC0KMlSQKzV9s1mBImQxcHO?=
 =?us-ascii?Q?FrylI0nE9yo/TrSrML+J0ocfi903UohhnJD4u7lME5z1d4YY/tStvlEdvMMy?=
 =?us-ascii?Q?hDnMSYSN81cLN6a0n1kO+iIXU8eB4U4IwS69QJ4P+L4oftIuYXCHjhEtOYWP?=
 =?us-ascii?Q?W11gOfletZQr85Ant/Rnr1qvXZEKbzSN9x1p5E0xjUhogwyX6o37OJL4J8Hc?=
 =?us-ascii?Q?S8385C+0R/Mwu+z3phcmeLdX5sAStxEZPkjsJHFmN1w3V7IJAWP6oHqJdBI5?=
 =?us-ascii?Q?reS7KQe6R20Jho9g10e9lvwycWZtRFXkBBMljtYEAgEDwSk7mR7e8+O/0NQ5?=
 =?us-ascii?Q?ywiMPWKhJyq9aYoSkHrXLqQLwJ0fWQgPpmKQOMr3XkkjTLMpxA0+DOHIB4dj?=
 =?us-ascii?Q?CTNgGbNXxwJvUNfvHR839X0PmH37B+Wv5rzKRsg5vgMn+jGMojtxbsMXv6gV?=
 =?us-ascii?Q?zp5Uws5iZ3ZTtSabOJztgrzNHzG3Mz0ia0fzARM5uiQQ6hM6ojGqVUhBYjid?=
 =?us-ascii?Q?iYfHGKSU7NQfBfkV2LFWiMtk6SDo8vZIrXd7OEHm1/BeMAn5F2Z8dLx/voFZ?=
 =?us-ascii?Q?YwL3u/R/dkPf6y/zD0V0ZJPp86qOF2Qivgx8885JsqbocHKIOr9G/a8mRBnk?=
 =?us-ascii?Q?+0B7ShQJB8GOcyJ8Q6QmSeE/zmqT3uMIeKX4wnan9cT1V5LLtybLT7HptXjJ?=
 =?us-ascii?Q?SAWt4QvE1x2Id6JXSBPbMrrKtTIl3JauS5gJZDkhjkINBRSyhPmtkTYoptTN?=
 =?us-ascii?Q?mxpf8740UdDyGrZ57s7PPvJnCORwi8frsjOP39yS1Xb/Saqw3LgYODGOktlM?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d255afc-6402-4d40-7001-08dbad73ae25
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 18:20:55.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eD0b/Y/njkT9IhYWD43iDhWbCsX65akJjNhHOeXeY6VpVwXEby7uFxViow2TfOPP5Ak2CkJwSg05Qmb71w6peLSlmnBSP/DUpwk2QFZAzQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 05:38:45PM +0200, Maciej Fijalkowski wrote:
> On Thu, Aug 24, 2023 at 09:26:45PM +0200, Larysa Zaremba wrote:
> > Use previously refactored code and create a function
> > that allows XDP code to read HW timestamp.
> > 
> > Also, move cached_phctime into packet context, this way this data still
> > stays in the ring structure, just at the different address.
> > 
> > HW timestamp is the first supported hint in the driver,
> > so also add xdp_metadata_ops.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice.h          |  2 ++
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
> >  drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
> >  drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
> >  drivers/net/ethernet/intel/ice/ice_ptp.c      |  3 ++-
> >  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 ++++++++++++++++++-
> >  7 files changed, 33 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > index 5ac0ad12f9f1..34e4731b5d5f 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -951,4 +951,6 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
> >  	set_bit(ICE_FLAG_UNPLUG_AUX_DEV, pf->flags);
> >  	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
> >  }
> > +
> > +extern const struct xdp_metadata_ops ice_xdp_md_ops;
> >  #endif /* _ICE_H_ */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > index ad4d4702129f..f740e0ad0e3c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -2846,7 +2846,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
> >  		/* clone ring and setup updated count */
> >  		rx_rings[i] = *vsi->rx_rings[i];
> >  		rx_rings[i].count = new_rx_cnt;
> > -		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
> > +		rx_rings[i].pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
> >  		rx_rings[i].desc = NULL;
> >  		rx_rings[i].rx_buf = NULL;
> >  		/* this is to allow wr32 to have something to write to
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 927518fcad51..12290defb730 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -1445,7 +1445,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
> >  		ring->netdev = vsi->netdev;
> >  		ring->dev = dev;
> >  		ring->count = vsi->num_rx_desc;
> > -		ring->cached_phctime = pf->ptp.cached_phc_time;
> > +		ring->pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
> >  		WRITE_ONCE(vsi->rx_rings[i], ring);
> >  	}
> >  
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 0f04347eda39..557c6326ff87 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -3395,6 +3395,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
> >  
> >  	netdev->netdev_ops = &ice_netdev_ops;
> >  	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
> > +	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
> >  	ice_set_ethtool_ops(netdev);
> >  
> >  	if (vsi->type != ICE_VSI_PF)
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > index a31333972c68..26fad7038996 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -1038,7 +1038,8 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
> >  		ice_for_each_rxq(vsi, j) {
> >  			if (!vsi->rx_rings[j])
> >  				continue;
> > -			WRITE_ONCE(vsi->rx_rings[j]->cached_phctime, systime);
> > +			WRITE_ONCE(vsi->rx_rings[j]->pkt_ctx.cached_phctime,
> > +				   systime);
> >  		}
> >  	}
> >  	clear_bit(ICE_CFG_BUSY, pf->state);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > index d0ab2c4c0c91..4237702a58a9 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > @@ -259,6 +259,7 @@ enum ice_rx_dtype {
> >  
> >  struct ice_pkt_ctx {
> >  	const union ice_32b_rx_flex_desc *eop_desc;
> > +	u64 cached_phctime;
> >  };
> >  
> >  struct ice_xdp_buff {
> > @@ -354,7 +355,6 @@ struct ice_rx_ring {
> >  	struct ice_tx_ring *xdp_ring;
> >  	struct xsk_buff_pool *xsk_pool;
> >  	dma_addr_t dma;			/* physical address of ring */
> > -	u64 cached_phctime;
> >  	u16 rx_buf_len;
> >  	u8 dcb_tc;			/* Traffic class of ring */
> >  	u8 ptp_rx;
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > index 07241f4229b7..463d9e5cbe05 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -233,7 +233,7 @@ ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
> >  {
> >  	u64 ts_ns, cached_time;
> >  
> > -	cached_time = READ_ONCE(rx_ring->cached_phctime);
> > +	cached_time = READ_ONCE(rx_ring->pkt_ctx.cached_phctime);
> >  	ts_ns = ice_ptp_get_rx_hwts(rx_desc, cached_time);
> >  
> >  	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps){
> > @@ -546,3 +546,27 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
> >  			spin_unlock(&xdp_ring->tx_lock);
> >  	}
> >  }
> > +
> > +/**
> > + * ice_xdp_rx_hw_ts - HW timestamp XDP hint handler
> > + * @ctx: XDP buff pointer
> > + * @ts_ns: destination address
> > + *
> > + * Copy HW timestamp (if available) to the destination address.
> > + */
> > +static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
> > +{
> > +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> > +	u64 cached_time;
> > +
> > +	cached_time = READ_ONCE(xdp_ext->pkt_ctx.cached_phctime);
> > +	*ts_ns = ice_ptp_get_rx_hwts(xdp_ext->pkt_ctx.eop_desc, cached_time);
> 
> having cached_phctime within pkt_ctx doesn't stop skb side from using it
> right? so again, why note read it within ice_ptp_get_rx_hwts.
>

I have answered to the related comment for the previous patch.

> > +	if (!*ts_ns)
> > +		return -ENODATA;
> > +
> > +	return 0;
> > +}
> > +
> > +const struct xdp_metadata_ops ice_xdp_md_ops = {
> > +	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
> > +};
> > -- 
> > 2.41.0
> > 
> > 

