Return-Path: <bpf+bounces-8228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C5F783CA5
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 11:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA1D281028
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C68F5C;
	Tue, 22 Aug 2023 09:13:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11529A0;
	Tue, 22 Aug 2023 09:13:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F5D1AE;
	Tue, 22 Aug 2023 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692695611; x=1724231611;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hxQRDi90Oi4AnDcoHiqQ+ywmPFA51+rPoKLf34YDSyE=;
  b=T5MIc8c1Tpou3bicVtCfAZI9wHLtNE8+NLvjbb7/yhvykwNGRh01YFGk
   ofS3adrcllB39CuDXWbewGCRHSwndHwA71A+M/VhCchwazltoaKtyHApC
   DlX0/xURg3BDonakdQEF1ZbGYAyFd30yVl4tG5gpFOe6P4IkOO0KpjgPY
   FxG8hyj1ZLE+HIagppL8e2OhzfQB0E+cYvZEYGHxnING+bP4WiyQPSK+d
   uKysqiPTGagFltCR/7nrKIQFffRsYEOyc9uWRyAm4fwA4ZQYBMIbDTHPL
   fehx5eaSbCppST54JgOjr/gpduElu8rnGQ83ggJx4yOaqblzT9Sx59zbe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358821630"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="358821630"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 02:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="765672860"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="765672860"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2023 02:13:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 02:13:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 02:13:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 02:13:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9XNZuTSixNSXZywZ5zOJnB/LEq9fuoyJs4nadLJSo/202S397eybVq/W8SKDJOlVvGnjabANAcZDvJiimOeAwE1iPSMsUMAqj1snbDHl5YdksVKv+RvVLPgS1VPSoiOLKZHzWDhr60Wryi7xYItm2nVAVbfL6poNG1h0Xj5AynuTukuB3zqOS/PanCFPkSiIwU3xcbfxGb4Nh572gGT+gwL0BNXCQw4vE9bhQytBOh7SNY0hooOKiXpd9/5oG8LmYwVB4E6tNI+dMwOsCDrOrjw3XqkRzWQJGjiyNGCHK/kb/K76BS979iWtMjQ3Wd1i7c6BrFyQnn9lco9CLnUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKk8cxcCM8+mJ5RQQ11bApOgu9cZnpIjKT4m+VKKH1E=;
 b=j7g8Non51vKrunpMCA/yORBC7BQBURYLuk8cLAcO95QWhBtyycQRv0LrCmUlZGTkFRz/eqUNw3OB+459j9w6wgIK0Jxglq4/k4lTPPREYIKQ0iMSwsx29EIhLU+6TAl2kyinJge06YDHPMwim4KTO+vSmAQ//24VvA7Qd5v70PriSTT0Li6cQVkmJg8yBKzjAn8kOYiVsY7BzzJOt8BO9HERbxLvXHIA8aPQ89/2Fd4lZCiZGY5ugbqTqZ3J/LgeazZxix5L6/3URRQrgh5BfAd2DzWsWCxPIcMDSzAVEjK71CiqlLuHg5X7l7pX+5P3ZH9fZ0ryy94tWHz9Z80cWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM4PR11MB5470.namprd11.prod.outlook.com (2603:10b6:5:39c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 09:13:22 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 09:13:22 +0000
Date: Tue, 22 Aug 2023 11:07:06 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Simon Horman
	<simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next v5 13/21] ice: Implement checksum hint
Message-ID: <ZOR6uoYKRPEKGKED@lincoln>
References: <20230811161509.19722-1-larysa.zaremba@intel.com>
 <20230811161509.19722-14-larysa.zaremba@intel.com>
 <20230817215826.sx7t6mipx7pajuzo@macbook-pro-8.dhcp.thefacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230817215826.sx7t6mipx7pajuzo@macbook-pro-8.dhcp.thefacebook.com>
X-ClientProxiedBy: BE1P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::14) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM4PR11MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: 694c2a6d-d33e-45c1-e64b-08dba2f0080b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5ErlFEP0xVs0sXM2tkGytvy6XjTizYRQlFYToCCTk/e/nNCICvLx1sYHUPheIsh0oqkyot0XakzVPYkrAMHb305+C+vZzqCTd5kXKpq8AWt+aIOEKUlqxAsk54yLeDGzza8JRVTCxQ/uW7O0ou/inxH4/Dc+909ZErks0bwj1Fr+NRq9HT3mOiViL9UxR/SvFUbieHFDs2BDbDdppa3Uqr6wgZ+As7pq7CvIVhCpgPy3BcErs/IHVvLejyHHFSkzzsazXFEeyJ2v33DnF3vm7VFiPZVoJnDTtGosLNnCdsR7DQH9lD2+qytlUYTGMGLhr2cYTEce/dwu8v1IQ//WUm5Ybp5S82KsE3lZfA9tULyRbTpJ9mWEhuxEFUG2nVf4U7ERW2iRsm9hS5NYQ+76nwoGp3HVHnJvdwPvrnH0qMW03MeBlhZ9MPQ/WTu8an+3ZJL6eCEABjnHyHRpuLM7S2Whubcjt6clJQu+IvHCDDM82U4rxjgfrYrPf/S2EXFuWnRpA+uU0AwZk0Exhm/LkElZoXGU6175DdI5FyxaGLaniM/z7jXf7rLBm+jR/XY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199024)(1800799009)(186009)(2906002)(83380400001)(7416002)(6486002)(6506007)(38100700002)(5660300002)(44832011)(26005)(86362001)(8676002)(8936002)(82960400001)(4326008)(9686003)(6512007)(316002)(66476007)(54906003)(66556008)(66946007)(6916009)(478600001)(6666004)(41300700001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DqhFB4D6wIFN06DHYCMI2RooApCx6SYtLYwCFCBIMPJW6uNkxj4+IuK7Um9x?=
 =?us-ascii?Q?XiNEmNYr4xx0wkz3mYSrPauHXt8XUyW7Kl8SMhAAwt+VCRHpKaxEPcu0n2mF?=
 =?us-ascii?Q?g+Ci3ObzZt9AhTP4BHq1S9ba2LDFA9aveyEAPL65jt22K2HEUFLwPReigf/m?=
 =?us-ascii?Q?JuvhZKnbXrfclLQy5O2xhUkSkCe52iGw1jIRezQR+k8CgcuG8uCcERlqJVXr?=
 =?us-ascii?Q?KKj/DUKfYyPVHBJ/yVvciKaqh9GUkznTZCh8HF1lNLcK4rhygntGEsxHtI7j?=
 =?us-ascii?Q?IM+pb1qHWyNcI3ZLCQYbvOlyPSQz2XfuIUuiZMSVsNwcoKzV9nf9nqhB6hCR?=
 =?us-ascii?Q?ko/wpDhsKxtml++R382VI+xmL4O2h+78YvEXaaF7dW6pIW5cO9WzMybp1Jbr?=
 =?us-ascii?Q?PDzio6aI4Zh+ZK3qAkldPb7YBch3hNkugfhMcLTI9boSh9sudk5O36lX58qc?=
 =?us-ascii?Q?E/9RKwy0LswurwKNlFBjx4CDd4nHnOk7xtZXrzae/IeJXskT5l6/XH48URJL?=
 =?us-ascii?Q?6t7OgbESApvRg8iSl1QtXiFJrxGz189HlzmB7oECMZqyTDARLowxYDrerxW8?=
 =?us-ascii?Q?BrJVNj/UQ6ct1FbKhCQZi7tNJVuRPCAkVOnjTrNj40M6Red3yr4t6LzJf+Xp?=
 =?us-ascii?Q?1vhp1GfMR76FsV4kpxX39coUlNLl35cd5e27FNM5Jg/UT5Pgdz0ZEJJLvp1q?=
 =?us-ascii?Q?CnSclSxnn7CcIDU00DpH5Rz4Il4bwnU08s9ClEACNVJz6XUUXeS/l0I5yejV?=
 =?us-ascii?Q?1W/R/hTpoCDN7kdYPQ+AGriBjgxtWXE4dync14hurrWTW6AA7Wm7ursYxsSj?=
 =?us-ascii?Q?XTzw0UnXW6L9uy4JrRKvE/1ojTwt/WiWCPM77aZ+pXMzfF8lDGP/nl0KsK7V?=
 =?us-ascii?Q?K3BpZzLg+/aOJxDMDvdOjLCvVME5y5AtGUYkHPA18uulBWYO5TkY58BByUI8?=
 =?us-ascii?Q?dK5sTpKNeg8JR+iDtV8unYtvXpzn6PPTaKIdxeZuo80OQcAHOtwczeVSLhJk?=
 =?us-ascii?Q?g9B7VX3rzduMv8fia2iToEBKDoeLEC2bL8b29RvAvcD1ExDSOr6cYqdauGwZ?=
 =?us-ascii?Q?kugGnv91rSlT97VZxrZU0gMhrerYtOj0HyMg34YPj5IKxFlFocxGakNsaJuW?=
 =?us-ascii?Q?6wUyVF+ZJIHKaoTwj657DzRxLxV/OpO/fXf/Wc18VoZp14jXrNQhfrOmGN35?=
 =?us-ascii?Q?91O151CjKJX9siG2Hulg8fPUNIyf1DUw7z/aDXKKuTIQaXMF5nctKFnak/Ab?=
 =?us-ascii?Q?Qu2XQIn8y4foJXrxnEjZs/KCdhlxcSu4tdkzjx8K7B6wFMqLbCZBMhJTXjrJ?=
 =?us-ascii?Q?UD5HxJ6rfHS9011rigdGXaN9jSqor/cOXkGk5PjG4R6nBjNR1pbAwU/ot5IZ?=
 =?us-ascii?Q?u3i/XkHJvZ6FIk6U5ltNIPNcwDX1VXF/lu32vLV1rTOOoKnbNPbKLQQodZZw?=
 =?us-ascii?Q?6dnKYRXeWiyqXJfwdZyFxfGGdBYwInsQFUoNyepdHEfownk6F7tOviJjffv7?=
 =?us-ascii?Q?gcrnPPscgsOL42OqlwmzPbGcV6DV8wydqAGRSJ1YvNdkSIiDzcTV6V/2xphW?=
 =?us-ascii?Q?6kM5fe0ZA4VEYNZhfP1HqcV66GBISDkGrD4nUd8bgq+5SMM9UdP4/n7TjYW8?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 694c2a6d-d33e-45c1-e64b-08dba2f0080b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 09:13:21.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2rHYLZDFDtJM1Q+RFWna5SCqeabJlA/RBisXcl8o/MB3B/XpcgX81CmzXCuLpSDHUR14g771VLIi9ErXL4Uz34BZh0n7Sd7FElTQ+8xEZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5470
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 02:58:26PM -0700, Alexei Starovoitov wrote:
> On Fri, Aug 11, 2023 at 06:15:01PM +0200, Larysa Zaremba wrote:
> > Implement .xmo_rx_csum callback to allow XDP code to determine,
> > whether HW has validated any checksums.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > index 6ae57a98a4d8..f11a245705bc 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -660,8 +660,34 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci,
> >  	return 0;
> >  }
> >  
> > +/**
> > + * ice_xdp_rx_csum - RX checksum XDP hint handler
> > + * @ctx: XDP buff pointer
> > + * @csum_status: status destination address
> > + * @csum: not used
> > + */
> > +static int ice_xdp_rx_csum(const struct xdp_md *ctx,
> > +			   enum xdp_csum_status *csum_status, __wsum *csum)
> > +{
> > +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> > +	const union ice_32b_rx_flex_desc *eop_desc;
> > +	enum ice_rx_csum_status status;
> > +	u16 ptype;
> > +
> > +	eop_desc = xdp_ext->pkt_ctx.eop_desc;
> > +	ptype = ice_get_ptype(eop_desc);
> > +
> > +	status = ice_get_rx_csum_status(eop_desc, ptype);
> > +	if (status & ICE_RX_CSUM_FAIL)
> > +		return -ENODATA;
> > +
> > +	*csum_status = XDP_CHECKSUM_VERIFIED;
> > +	return 0;
> > +}
> > +
> >  const struct xdp_metadata_ops ice_xdp_md_ops = {
> >  	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
> >  	.xmo_rx_hash			= ice_xdp_rx_hash,
> >  	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
> > +	.xmo_rx_csum			= ice_xdp_rx_csum,
> 
> timestamp hint is implemented by igc, mlx4, mlx5, stmmac
> hash hint is implemneted by igc, mlx4, mlx5.
> With above csum and vlan hints will be in ice only.
> I'd like to see at least one more driver to implement them as well to make sure
> the proposed API works for other vendors.

I have no other vendors on my current setup :/

I could send an RFC of v5 + a compile-tested implementation for some other 
vendor, so you can see, how it might look.

What do you think?

