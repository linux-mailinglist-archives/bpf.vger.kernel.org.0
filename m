Return-Path: <bpf+bounces-9221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21675791CBE
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 20:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DFC2810B3
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44305C8F8;
	Mon,  4 Sep 2023 18:23:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD421C02;
	Mon,  4 Sep 2023 18:23:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6EA10E4;
	Mon,  4 Sep 2023 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693851792; x=1725387792;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oOusIl7GZZ9+AFXUZgsW7R4KYjIFU769EYfEQsB4Ir4=;
  b=XBDsmgVF7sqw/1D3FF+kUVRbBO5oEbrZsoe3i8NKwReRMeuvdgNkS5ss
   +cIqe1WSxPV6kKO7OpG4tiZDnUcJ1S7GT0GY8PbidQFT2N5QsPmTRwHrz
   S5ov5vhmBDZ84PiOmz6FSiOjG8xOgXFLthffznBaUI+F/S0wU9kalCwEo
   Kkoo9E4e7Usw7z8e6pyqds1/KeWhcW+8Og5F9UqsjL2HYLHfTKczH3mpm
   +1xTCnUQiWVYhmOUTPKVBGY6CZRumgYxju+k67zuDV4bv5C9FJKivA+FM
   fCVl1cCpkqbw0o+254nqqyCE04JLbkYHrR2xDKnBYs93jsH0ShaopEw+U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="379358723"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="379358723"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 11:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="775932172"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="775932172"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 11:23:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 11:23:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 11:23:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 11:23:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 11:23:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/gfJY836tK0ax/a5zrqWTQLAO2VHA+6kEqfItcbpPSjusrLdqrWd1N26euHIt9vHL56/V55Jd+bTBBknaIP6B4mwL9bhLy5JQgYmUaBE565okO4I6BAcKtdc1jhEOKoV+Yq9kOwTLRZye5CctIfCxl9tGY1ol2ZK4vipYk6HzStHIMzaTc6GfB0QxtQ6ykgPnxciIbms2LYEimb8kK8QGfSuhjQJ3VogMcHufrBv3m7uu0d0aZl1Tj3GEgwvn1bDQXq0FgX5sfZp5GG7JiFRoAOj7o34x5EnHzFrl2BOJeJ47W1qLHWWkQ1WsUSMUKsP2CXYWTeUvgx1T/esFyggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7Rmy5vb+zX1eiN6QxDcgDV6fVSaxAghV6cTNv9Ogo4=;
 b=e3zhf9ld0k6uTjSg++JRuvKnFDf6uzO8OnRBC8q3dWz4H2vgFyZmYpZVu+FTo8F3qAB60lcVmsqAD9xrZQHY1fL2RBAYTjtOKF3Z/Bdlu5DciOtfv2Ty0zgD7fa92Y5vqy6QHfCIe8dKjqLvfb26338bImSKohe6AhY7tg1AJ0E63ka4iaRS1O4AU8bu/wBGBIAuTWUfNaFCsH7lhxNQwIZcK6w1dAc6b1MaoZMWdY/HNWO9hQOiQiwcaffGPlD+aTdUV7/SXdC6CQwMzQzlBXapKAYaa8ce2dsgJOnJNBdo5boEJ7Fs65PRrg4WI4dr+uEZf7cZiu6AMAY8fX5q0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 18:23:07 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 18:23:07 +0000
Date: Mon, 4 Sep 2023 20:14:51 +0200
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
Subject: Re: [xdp-hints] [RFC bpf-next 08/23] ice: Support XDP hints in
 AF_XDP ZC mode
Message-ID: <ZPYem2d1DkeI4rvO@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-9-larysa.zaremba@intel.com>
 <ZPX7A6Vp+Nxk54St@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPX7A6Vp+Nxk54St@boxer>
X-ClientProxiedBy: DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA2PR11MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c5cdb1-d8bc-48ae-4dc7-08dbad73fb6c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +88vKcpOaEBeCLGGakTK74OdTAbZS03Gqbo46Cm+MVJZoc+sFfne8Qd+QFMgJLmQMSnI7t0YePFIlRm8vK4M2k5VI3SZXomX9ucdpmzRqKdeugULQp1n3fE22uPyUd3TOGIw+04Rb7W2dhzmVLuYkrZlW0JvQh+gXnj0EWRwia5MENJiGRQxyYggwxnFrJSQidOIAoWa9WtBY18/eGz2B4y0uNxfdOX5sX9+x1aPaE1vSk/70C0s98Bg2hAwBxk6hQ0fUlX+V9oRx6CYT5f7zQNzQYyH4NSBUlICR/e2rZ6oyw4euVC7V96yjYzAeu6Z3jKbB2fX/TxM/uq6pSuLNgCmuGh2Pjh+yYaswXjDoui5CQkq1+0OOxTo+qHRI1znT+SBX7NT/hYazWR9lSg3dilZQMOr+oIn+r2c6G8pAKyvhglQs/uwpr20iZLNtnv3pZgwbNuI3N/tI1SrOgCekCaIYigRsZtt9Chwy2DW3l7XD25xVKDSAoHuT7nGMtUMsLAX7F2aPaSJuYcLsulT6BSuVla8kDFBBBjSVUzWZt5fI5O0HffMfQ8U4O0s0kfv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6506007)(26005)(6486002)(9686003)(6512007)(86362001)(38100700002)(82960400001)(33716001)(83380400001)(44832011)(7416002)(41300700001)(8936002)(66476007)(316002)(6636002)(66556008)(54906003)(4326008)(6862004)(5660300002)(66946007)(8676002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JwBImgyJrdyZ4F7WlbgYfeeoP2/Aefris49li+Fnd7tF1o4pek8TUM5g6eK5?=
 =?us-ascii?Q?iB3Uys51vHV3l/3wE+OGd7G1VbPe4HRug4ZfZpEmFS4HtjHNRk04yosUodqC?=
 =?us-ascii?Q?vJdz2abso0F5EgLwae25OlNojJlRwc4cXHW46Ym7Oc5x9FjvdSJ3x59jjJak?=
 =?us-ascii?Q?OKbqGROzHoHC6+GI78ijLI6ZgCC49zeFr98kyDM6tss9UchDLtkm2odvgWwi?=
 =?us-ascii?Q?CvUxqsoXke1gj3mWJM8eZyQGQGUrfCls8tGoPMBN0yjFOJntWXTisDrG0AY4?=
 =?us-ascii?Q?Vxr0x+A2bFzb44ENU3aXDA9ENqxo67EW+k45W8p6Lcc0XV3DuZELgFaOEQrR?=
 =?us-ascii?Q?TcDilxjSsl1o0gpeZ7J4xVAcp/ceRq8ticESu8zROjWODTaLfbe8tLLMgznR?=
 =?us-ascii?Q?nDPTh938qm7ey2A0Z5sVgNYy+oKu9dLGgojIZWwAzZ62CAmmq+KPfoHwzrqU?=
 =?us-ascii?Q?i7MbghcSEzaMl0MCnqSA8GrHK0ZahuiymN1yXrqI+GfvkFn/6grPqUsYcusq?=
 =?us-ascii?Q?SPnP3RLl252/bLNfV5Zj+wBQs6Fsx0Eh+e5RDzpZe4vVHJ2xve/6L3Q1OLqd?=
 =?us-ascii?Q?BGivc1g4MFO8lDnrF4NqotzP5yzX9jMSy5V9qxH6ZYDuFbFTcsqDQ1tV1sxE?=
 =?us-ascii?Q?pd8a1Nr1Mw5WjEoLygZTb0p9KGF8fKJSbLOkTEJyfSk5vJFdLIpiYgInDm4P?=
 =?us-ascii?Q?Z/uUnNjSPambnFrXA1SbMwzLTUmI8nP++H61GBPZ+mz5+aActsEHlPlbPsNX?=
 =?us-ascii?Q?SFAp3ERSVLW4vrKI2rI2zCwSyLoVHzbI3yhtijjdjxYHLYkJwQy9HBiiAar4?=
 =?us-ascii?Q?JAW7N107cxLYL7p47Hl+1dJzLE/98Z0oOWjOi28UfQ84mUdF2iICK7RfgzXE?=
 =?us-ascii?Q?wX9plAFSiH7p9Po40/JPBmO1PXU5bCkrmjwEqiWcs8zDt1sUiOrFTL3qaCl7?=
 =?us-ascii?Q?/ZasAvVpbrkqF9AdjT5dC6K9PPhIc4d88ZCnF9M2vlCPRQzmC2OHlM1ghnr1?=
 =?us-ascii?Q?GLiI9cI2uB1ftHLZzRWgtDtdyBiJoq2adblu6t7Vzeqtc3lrTikvx9G+j9T3?=
 =?us-ascii?Q?qczHGY0cA793elJj8a3ZsoZ0iJtEiUlD5ijrnRchkUde1GcCe2tKg5E73LM1?=
 =?us-ascii?Q?Z3WnBBFZbNiPyasyT7DhMOBWD9edeSb6RBE727cNAWg5LdmDXN449QFAEvbv?=
 =?us-ascii?Q?sVyl6NvXw4wukd1oBkbEPXl21SaW4GduiTxCFH4vq4O6e+NWra9CxV7KbzOM?=
 =?us-ascii?Q?zoPhxZV0wqjRQN+UDJyhCIz4OKp7n6qzdrxxKOGWojUnVjcEGG920bvcZrC5?=
 =?us-ascii?Q?luXrmjQFVzXKBoCqjXB9DqNVUJv8PEumCsWdJR3hwVTNfzP64M2Yll6PJf6F?=
 =?us-ascii?Q?kE02m7xZgizCC3GHaJwBP02FvqNoO2e1CcQieUOpp0gNqY/V11AIzvou95xA?=
 =?us-ascii?Q?TLQQMOzLQQgAc3ntpQY6VyCfFrUIIkJ/ZEQIE8LIK5+8cr56dnj9MgiZgSIm?=
 =?us-ascii?Q?aBZ0fwNcb1Ub5re0LWfc8JI9AfUHp0lg+mntxJwt3HZTFOvkmUrOMQiJJfDY?=
 =?us-ascii?Q?InW2JpqaOrWYAUxPoHilWP/aRPE4GaaSkUFz9QndSAvwuigw5j+7mL3iTCZP?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c5cdb1-d8bc-48ae-4dc7-08dbad73fb6c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 18:23:07.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+RBrzzUrefUXFhYR0pUqRVi1ZI7WBPHTqCInu8HvSv6EfMR285gvdbzOwhhavT71q4ov3biw2yU8rxdtI6rHPhuDtusyw6MUgbKy824L3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 05:42:59PM +0200, Maciej Fijalkowski wrote:
> On Thu, Aug 24, 2023 at 09:26:47PM +0200, Larysa Zaremba wrote:
> > In AF_XDP ZC, xdp_buff is not stored on ring,
> > instead it is provided by xsk_pool.
> 
> xsk_buff_pool
>

Will correct.
 
> > Space for metadata sources right after such buffers was already reserved
> > in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> > This makes the implementation rather straightforward.
> > 
> > Update AF_XDP ZC packet processing to support XDP hints.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_xsk.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index ef778b8e6d1b..fdeddad9b639 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -758,16 +758,25 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
> >   * @xdp: xdp_buff used as input to the XDP program
> >   * @xdp_prog: XDP program to run
> >   * @xdp_ring: ring to be used for XDP_TX action
> > + * @rx_desc: packet descriptor
> >   *
> >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> >   */
> >  static int
> >  ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > -	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
> > +	       struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > +	       union ice_32b_rx_flex_desc *rx_desc)
> >  {
> >  	int err, result = ICE_XDP_PASS;
> >  	u32 act;
> >  
> > +	/* We can safely convert xdp_buff_xsk to ice_xdp_buff,
> > +	 * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
> > +	 * right after xdp_buff, for our private use.
> > +	 * Macro insures we do not go above the limit.
> 
> ensures?

Yes :D

> 
> > +	 */
> > +	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> > +	ice_xdp_meta_set_desc(xdp, rx_desc);
> >  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> >  
> >  	if (likely(act == XDP_REDIRECT)) {
> > @@ -907,7 +916,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
> >  		if (ice_is_non_eop(rx_ring, rx_desc))
> >  			continue;
> >  
> > -		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring);
> > +		xdp_res = ice_run_xdp_zc(rx_ring, xdp, xdp_prog, xdp_ring,
> > +					 rx_desc);
> >  		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
> >  			xdp_xmit |= xdp_res;
> >  		} else if (xdp_res == ICE_XDP_EXIT) {
> > -- 
> > 2.41.0
> > 

