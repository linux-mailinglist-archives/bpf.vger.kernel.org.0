Return-Path: <bpf+bounces-9199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BAD791AAB
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F4E1C20340
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D5AC2D2;
	Mon,  4 Sep 2023 15:32:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5773D8B;
	Mon,  4 Sep 2023 15:32:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6221B1AD;
	Mon,  4 Sep 2023 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693841558; x=1725377558;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=piNuXjwtfKZrp9qOB53r7rQlohKkmEVFKLyFZbl56zE=;
  b=OxNg6eRVvlCD1QWEsuWLTD4gFytgBIqQLIsehmXMNPGiP1Kf5f0zsXS6
   aMt6r6fMEMEe5Wkokdl0iAKtGrTIoNnvA354aSfvLp/pEkuKec12m1bUA
   tUpOpzpf8UA/aTHDFVmSe42NnTsWWekw0WMJVjgRrDCLiI51y/A4jjFr1
   LWGL9IzaZ5E/8YmSauB50GeGmsQRIXLMqM8tj2lAgVpQVOb/gJBRQqX4D
   8GATYYLcMRKqV9ySJUYHnQw0NrPrIaL6gjpU6MYJLwpQbkNHG39R0hKlL
   lToh4nm4nDxUaj5Q6qGqVE/FEWKYJParPHLTYkJJsfXCYVRHoyGeKvy2m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="375512500"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="375512500"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 08:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="770035916"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="770035916"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 08:32:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 08:32:35 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 08:32:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 08:32:34 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 08:32:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiHqFK5L5NgkTAzUk6HNjpN5i2ho9vCK3E2Vwjww3LOtRd1QmKBkDlGnPz5f3oGe8e+ODhp3Vf+5ITIbCey6LXzYKurfsFhnWzdL9Tphmdu+fUSdY8A+f/WFxlBW+7Ei9cksZ5QClBWPWPhaYJh4Xpz/kQHKCaDBH6Jkq4Wom7Sr/ehBYLbKNSFehwwPTli8BA1nZUqwsMUgIFubwHW/tUTW9c85K/HwG3GVOoiFACr4AdtaS8PUPNUCGS68cnBeka+E9DnXSVp5J0ZAmqd+iQnuiUI1LpyKg62LB4c6va2089pyqeQ/CsRn3Z81qDxRe9YaoqIwkJq4SpgGteH2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDa+PQ1AoQpvLUQmgDgL1ulr0k4FbVanooiI5307zAo=;
 b=YE2KZd3vuzDatiDVTvf5i0OzVKTrJltU4opDCLZ8jUP479wmdWxhWgRXvc+lUxPpst5n4/aEJuY9mYCnyfIgUA8vD9Ck5cwPtsIVtJhEfIUBB0J/pHSSFmsIwpZYLVdfrWkCm5ztqbAMy8d4C04UIHXtD3W7i97T2OsS4AZ/GfA3RFDQaRycMWPE6FJw1Z86sIXinsJybl1KwYOv9PpILNU99SH0VG+1nBfVRBvNgvJUmJlhJn1kWUguptzxD4g/Rk9K1jL0ucA8Gam7UZqZkjAajJuohspOgb360mJvqAaGExyFdoWZl5qX/KhncaXZLgdx+qJhD5YsVvpdVSS+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB6573.namprd11.prod.outlook.com (2603:10b6:a03:44d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 15:32:30 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 15:32:30 +0000
Date: Mon, 4 Sep 2023 17:32:14 +0200
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
Subject: Re: [xdp-hints] [RFC bpf-next 05/23] ice: Introduce ice_xdp_buff
Message-ID: <ZPX4ftTJiJ+Ibbdd@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-6-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824192703.712881-6-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 21548cd9-f9ab-468d-acd9-08dbad5c26bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjuPoVgMIYluFP3vRhIiEjPawipyadiAgBiiXs2Nf1Gk2srUCfv4cPfbllSRA7ZDWkSAygfARjbc7b7B4K7nvUS2jnfWDDEBwr43pmWulUyPEZMDqZXJxxK2bAFWB5BB5jPtoxKidOzZtE7tU240yFvAIW4qK5SyYvZ6lgmWbfBrD+cIXtbtm2PKnZvwEtESpu21mWigIsl0AtoiSLAdcb84JS7YlK9DiOVwmlksz+/H4hYPFD0AdBoK3Gn6U5snQPrlW6QAZsw3sZtMf34jUnik7tERbmpyyosgMjE523io1K7Pd8qeo2Vm0ryGfk7FSiXWnTx2kFLNStttFD8Kukg6TIbWF67GetQUXa2fSLIUF3XuzVEbB96bvicGQoyrweWGI6/HfIUILFfDbufrLK7EmHsV27eXzq68tgET0CDuW9d/BhrA8v+7va2HlbjK2VvZ4esZAz4Ng/sWm1/Hj5fkFda5teUuiI+9hb15iuuhXLFwRhI7fx/iOh6l4NRAZZyfeD2h+9Aav03x54qfvXN1WFlpwk8jWUjytYTwALPUGijYDRcA98CdPNDaaE0KSZtlsR4sEHDuLkKxcH1vwh8w+/+qydMNrgf2e/TPkDQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(136003)(346002)(376002)(186009)(1800799009)(451199024)(41300700001)(7416002)(6506007)(6486002)(6666004)(478600001)(33716001)(82960400001)(83380400001)(26005)(6512007)(9686003)(38100700002)(54906003)(66946007)(2906002)(66556008)(66476007)(6636002)(316002)(86362001)(5660300002)(44832011)(8936002)(6862004)(8676002)(4326008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PoYwc1fbQj66guMgKgbDYhSDjI9Dw4LLzC7k0uGZQ6o2bDj6SQr7PNF3QYCZ?=
 =?us-ascii?Q?8lKrWCdYk7a1zYg3TbCSGtXi12csEwnRgzOZdfuXRy8FJg1hrg1Dndh9+uiR?=
 =?us-ascii?Q?b9iCbm1Vg0RASEOsuYZjNDvdL9++dea8i7GUXmkagk0vzX7E6oIexWoGs15g?=
 =?us-ascii?Q?Vqgc+hcpS+s4kjQZ7ESMIt2ldwLVcyzOQHI4Onr7E2IsJe1erOUal5MZR8ZD?=
 =?us-ascii?Q?vYeLwn0AJ58KIhXeIEXuLQgVbxf0FVf79lKR64KW1kPSUhQdXVT+xSX59vvo?=
 =?us-ascii?Q?wai5+zxVc4PPSFS2Nh+l90rbcyFkVch9KRrpgDdGfA7Qvr5yUdreMIOOrmVB?=
 =?us-ascii?Q?b4tkfqzqqSF/SH7bdNweqmXM1uT7ELPLLXzImGobpE6hOMMo1jY0KBbVX9ko?=
 =?us-ascii?Q?xz6ZrT1kLf4hcwqMvYZS46Bcmj/VsQNLGRbc+SrjyinJgBs5zx7LY/QmR1Br?=
 =?us-ascii?Q?u3leWSe1auBhulK+9tce2XGzVPXX/DE1rDVoa66WXt7VmEMS/NG5oueExPbp?=
 =?us-ascii?Q?Ncbmcg4Pr2pQTXyXr9MTT8xmVFkCt4Lx9gHGWxjFPL//CSRD+dULrKHvtP5m?=
 =?us-ascii?Q?29rs0eoWrYTlRJM/OFx+tghHhnoZX/YwI6Kh4b9wly6o32edR3xhTmt1G1vZ?=
 =?us-ascii?Q?q3rJGU/A+1BfzuvXQ3Ueg2+TyW9SWzcIt8nLGBTzJqNspGLA6n82SeBHutP9?=
 =?us-ascii?Q?8sx11QyUeUwNGXhiHPvs0toYJvAXKO/p8NCqRknrE+3ohiWainnR9x1/vUUC?=
 =?us-ascii?Q?+H4eluJbG/vIjYbzCP55cS1UXIe/IZ3UgQW3XZj9VZDDZzHtMXXMWhl0GC7u?=
 =?us-ascii?Q?AKTuCnDT7yYVYElcMFmCJgw7jrUqEVJF6u5bSsFOwzY2Yd//P+NT+MnsLYDA?=
 =?us-ascii?Q?YkvD9U5tT743NMPVOoy8oGRuanF7DJuVO+SQqfr6LZjTKOaEvRm2fy182zDC?=
 =?us-ascii?Q?1AtWf5dYGCiSJkK6HZQkfpVqMAHuZEbCDXSfpw0BUxY0/I8vPXjIVPsal/Hz?=
 =?us-ascii?Q?Vk6VdB5u5bD5qGnpduFTD8o8YsQZIfkLCk0s7gpbLh0JAR2O85yU0sECuGPp?=
 =?us-ascii?Q?1yBKvmXrRNy5FXLtv3t/hdFQy73qmioVhOCcDMoP+4lY3ABR3R7whMgPVpcM?=
 =?us-ascii?Q?s9SYU9ouP6bTXZkoUDBVmIXg4qht7ybkcC1fEve2i5u6a5Mk5bZiVF6Xij4t?=
 =?us-ascii?Q?kKC7WoTULJ6JtBZEk/tsxFoS3tF3BfZ+5GIsL5uWBp0y4C8c/s0It+H5F2HI?=
 =?us-ascii?Q?0LHVYxp83jvOmtS0e3E6OKYFVBwW1+oaK3z85SvYjjo2/q5HDNrbrYVX0M9r?=
 =?us-ascii?Q?4GJLCe6r7GSzbAxug3UXangaSVuRlJ25C1iSikzWoXSKDGXP0Qs23ItRKQPZ?=
 =?us-ascii?Q?nP6IeGopgowJrvQoXKkI4Nfve54veIP3+aLO1S0jvmxc6cHxSpoYkUZqq7fJ?=
 =?us-ascii?Q?zmIgeBNCSTfM98QeDt46idY23nvGIRAo+xEOhIyek3ry/3QxDU4o5Gh5N5CY?=
 =?us-ascii?Q?Cj1yFbA7EWnpwZ1S7MmRfYNNlWRLhALFrakGzRE2sThksuUeMW2raqhw06Bb?=
 =?us-ascii?Q?Hk16bsZlgV0cJ1y+nGsk2lMHZ4+ihEv2GSojvsoSX/TWnnDA3h8WJWOOMvbr?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21548cd9-f9ab-468d-acd9-08dbad5c26bf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 15:32:30.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UbaU+R8wPbK7KC5Gzs3M3V4K8BTELa+8/ZSBZfvGxzVPddvUGUHm5TQnf612+5f39CjRZDLxcdAU8uXujKmDkvj4hkWNZH7DcrAB9vBgFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 09:26:44PM +0200, Larysa Zaremba wrote:
> In order to use XDP hints via kfuncs we need to put
> RX descriptor and ring pointers just next to xdp_buff.
> Same as in hints implementations in other drivers, we achieve
> this through putting xdp_buff into a child structure.

Don't you mean a parent struct? xdp_buff will be 'child' of ice_xdp_buff
if i'm reading this right.

> 
> Currently, xdp_buff is stored in the ring structure,
> so replace it with union that includes child structure.
> This way enough memory is available while existing XDP code
> remains isolated from hints.
> 
> Minimum size of the new child structure (ice_xdp_buff) is exactly
> 64 bytes (single cache line). To place it at the start of a cache line,
> move 'next' field from CL1 to CL3, as it isn't used often. This still
> leaves 128 bits available in CL3 for packet context extensions.

I believe ice_xdp_buff will be beefed up in later patches, so what is the
point of moving 'next' ? We won't be able to keep ice_xdp_buff in a single
CL anyway.

> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++--
>  drivers/net/ethernet/intel/ice/ice_txrx.h     | 26 ++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 +++++++
>  3 files changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 40f2f6dabb81..4e6546d9cf85 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
>   * @xdp_prog: XDP program to run
>   * @xdp_ring: ring to be used for XDP_TX action
>   * @rx_buf: Rx buffer to store the XDP action
> + * @eop_desc: Last descriptor in packet to read metadata from
>   *
>   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
>   */
>  static void
>  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> -	    struct ice_rx_buf *rx_buf)
> +	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
>  {
>  	unsigned int ret = ICE_XDP_PASS;
>  	u32 act;
> @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  	if (!xdp_prog)
>  		goto exit;
>  
> +	ice_xdp_meta_set_desc(xdp, eop_desc);

I am currently not sure if for multi-buffer case HW repeats all the
necessary info within each descriptor for every frag? IOW shouldn't you be
using the ice_rx_ring::first_desc?

Would be good to test hints for mbuf case for sure.

> +
>  	act = bpf_prog_run_xdp(xdp_prog, xdp);
>  	switch (act) {
>  	case XDP_PASS:
> @@ -1240,7 +1243,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>  		if (ice_is_non_eop(rx_ring, rx_desc))
>  			continue;
>  
> -		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf);
> +		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
>  		if (rx_buf->act == ICE_XDP_PASS)
>  			goto construct_skb;
>  		total_rx_bytes += xdp_get_buff_len(xdp);
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index 166413fc33f4..d0ab2c4c0c91 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -257,6 +257,18 @@ enum ice_rx_dtype {
>  	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
>  };
>  
> +struct ice_pkt_ctx {
> +	const union ice_32b_rx_flex_desc *eop_desc;
> +};
> +
> +struct ice_xdp_buff {
> +	struct xdp_buff xdp_buff;
> +	struct ice_pkt_ctx pkt_ctx;
> +};
> +
> +/* Required for compatibility with xdp_buffs from xsk_pool */
> +static_assert(offsetof(struct ice_xdp_buff, xdp_buff) == 0);
> +
>  /* indices into GLINT_ITR registers */
>  #define ICE_RX_ITR	ICE_IDX_ITR0
>  #define ICE_TX_ITR	ICE_IDX_ITR1
> @@ -298,7 +310,6 @@ enum ice_dynamic_itr {
>  /* descriptor ring, associated with a VSI */
>  struct ice_rx_ring {
>  	/* CL1 - 1st cacheline starts here */
> -	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
>  	void *desc;			/* Descriptor ring memory */
>  	struct device *dev;		/* Used for DMA mapping */
>  	struct net_device *netdev;	/* netdev ring maps to */
> @@ -310,12 +321,19 @@ struct ice_rx_ring {
>  	u16 count;			/* Number of descriptors */
>  	u16 reg_idx;			/* HW register index of the ring */
>  	u16 next_to_alloc;
> -	/* CL2 - 2nd cacheline starts here */
> +
>  	union {
>  		struct ice_rx_buf *rx_buf;
>  		struct xdp_buff **xdp_buf;
>  	};
> -	struct xdp_buff xdp;
> +	/* CL2 - 2nd cacheline starts here */
> +	union {
> +		struct ice_xdp_buff xdp_ext;
> +		struct {
> +			struct xdp_buff xdp;
> +			struct ice_pkt_ctx pkt_ctx;
> +		};
> +	};
>  	/* CL3 - 3rd cacheline starts here */
>  	struct bpf_prog *xdp_prog;
>  	u16 rx_offset;
> @@ -325,6 +343,8 @@ struct ice_rx_ring {
>  	u16 next_to_clean;
>  	u16 first_desc;
>  
> +	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
> +
>  	/* stats structs */
>  	struct ice_ring_stats *ring_stats;
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> index e1d49e1235b3..145883eec129 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> @@ -151,4 +151,14 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>  		       struct sk_buff *skb);
>  void
>  ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
> +
> +static inline void
> +ice_xdp_meta_set_desc(struct xdp_buff *xdp,
> +		      union ice_32b_rx_flex_desc *eop_desc)
> +{
> +	struct ice_xdp_buff *xdp_ext = container_of(xdp, struct ice_xdp_buff,
> +						    xdp_buff);
> +
> +	xdp_ext->pkt_ctx.eop_desc = eop_desc;
> +}
>  #endif /* !_ICE_TXRX_LIB_H_ */
> -- 
> 2.41.0
> 

