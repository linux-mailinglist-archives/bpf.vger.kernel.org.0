Return-Path: <bpf+bounces-20232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95883AB59
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 15:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FF11F22F29
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884AC7A70B;
	Wed, 24 Jan 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vzo6QdYv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA57A63103;
	Wed, 24 Jan 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105166; cv=fail; b=Zrg2vluMkfdWYV0d1nwdG8955VoRkprdtfgQObxDRkhRZ0Htpg+byx+q+oBvQfsBaAVwwlnKUj5kqjlVNO9aJyou7n1TCEACKMO+zzs0iWe/AAvo5yNSpomyeDAYV8FRpATuawNyit27W3MKr/Hb1n2auwF1c6MrsDczC6Gblns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105166; c=relaxed/simple;
	bh=zSBTx8P+VHdOHDPcbRzliAUgR/fZp2uapCVYhp1iiMs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TfZ9hnUjQ0vm3/DvsETJH0OPhHibbfULndc1nRuqH4dt0pW1+HRwN5CGH+KSmtTORovyiI87I6UeFYbSFr9nC5vMRZ1ggurBhf2Yr9EHLj/po+ITUmtBpC021Jp2Ecfx8sxRwQSYVpm6HNV7vTmuDFE0vFTfsqHS0bU+sJ42kVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vzo6QdYv; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706105164; x=1737641164;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zSBTx8P+VHdOHDPcbRzliAUgR/fZp2uapCVYhp1iiMs=;
  b=Vzo6QdYvwvjSqKPgi2ovkH/3s7T4mtCMwstAgmL7fQyOrLpxeCiIN4gc
   PISrn4VJpkMXPrAHpVFEMaVZxFZH70YXNAfrqrMkEL3OhWCrBv9SLX1MO
   RAj4sPVZnAFvzN77InsoRxKnW9YIaSmXTP6U23Gjc7qbKdV9ML7xfVNNJ
   jHPHfNhrVFuQxyjsCBfyKmbnCI9OYOXzqgkckQfz4P5KMUzfI4tirnnAT
   OaHh631HPoiCtzRqzpXiwVQM5Z4gX260npLdztmrmMNL3yP6F9VFUbhfo
   ODctmY0LXuSN+9l3AVcp++UdJki4eaiKjiTp5oqKhcTbQ63i611xb5/VH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15198486"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15198486"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 06:06:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929691112"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929691112"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 06:06:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 06:06:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 06:06:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 06:06:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 06:06:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRVFkXiCd22z66Rk1y81+/burK6RI7kPXSvkyCoE4ME0rrjSzKieA33ZLmcBdk4o68sbXFJJ6NmJZuI/Np9HcV0ahz9NG+9NTwZek/ca5Z9xYHfL8NnKNh+UDJAcxsjsbTSvPIAqnlKPemfmP6d/kbWKSWjJqwxGlrqQiJliN3VzneTdlEf0e2qomNwdIht9f3F3PWeMZwzTcROiHW9R//nkGdQGg/I3KDYxitLl05hOT4j7D3gTd3m9sc87WTiwzCpi9sj2ucZljswZOHHb5NRZUD/zNWJxyQtRTdVEc1FWgMblaceKNWcoKNyWQptdD/nHwEfP8NHpDUGsl0IVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXIRTHcs1vkFhl+7cbkvJxKQnYCfHdX/IimRPKkVgM0=;
 b=giEZ3hcLr81IjitkCqLEmjC/zvd48YvnqbkVSvQhSXEWkPAybBJtUqPMSkR25JgNSmqEUB8eYjzk6nYMF4SyiFJLNtNOdA4tAS8JYiCIbW3HEa01WNUH0f4hJCJQEbpDjevGSy6nmPUa1CQU6ya83icH1WQuwR1XWbF/PSxpFf9XgY60VQJ7Y4v+nrxcK9uurFNqfhBZaw7EUkMEkzJpxJw85cF6wz3XPAxDZ7y0ma2D87MONJ/Jl8zYMh/nbolm8+HD92PDzi8XxnSQzRzhQlStI28V8kyIEIuhcsHn7IoI1pPtAgazKovDftqP4XlRA9l0gYU9NaMqIX2Ge5hHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CYYPR11MB8305.namprd11.prod.outlook.com (2603:10b6:930:c1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Wed, 24 Jan 2024 14:05:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 14:05:52 +0000
Date: Wed, 24 Jan 2024 15:05:45 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <echaudro@redhat.com>, <lorenzo@kernel.org>,
	<martin.lau@linux.dev>, <tirthendu.sarkar@intel.com>,
	<john.fastabend@gmail.com>, <horms@kernel.org>
Subject: Re: [PATCH v5 bpf 04/11] ice: work on pre-XDP prog frag count
Message-ID: <ZbEZOS1PK3ia/8dR@boxer>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
 <20240122221610.556746-5-maciej.fijalkowski@intel.com>
 <CAJ8uoz2w3A7+aOAKWKjdATUgwQ8u10GHAtjodc_Nhp9FALE9KQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz2w3A7+aOAKWKjdATUgwQ8u10GHAtjodc_Nhp9FALE9KQ@mail.gmail.com>
X-ClientProxiedBy: VI1PR07CA0257.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CYYPR11MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf6ec74-7a74-40c6-19e2-08dc1ce59351
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZV5rW/fJ1N6XlV+VrvmZwmgW01P99HysrtQV9I76iWHdGh4WsPGQY/o4bA52ApvITdt+OULsTOBrkOHmkzVReDUVzov2K2FbqqzSaVCbV82gCvkyrBcAv4J7uls3Upz7i9zWzWAVhEQpC+AjZKcHYKb6uitZVopaGWAZm/QQ2fVeBj73lTdsQ/EGkRQyGqYAbhBRMzUNz5fb7b3/vSm9Qwiq3fWxCA4s08uHLjme0RTDeOlrCG2aD8Js3sw8BzSZa7mgwxa7+95VsvQf4l+ymic4K66MmdotzV6saUlEo/qRYajlLur9CWCodoDluV2KS2dJoBbSWmVdubUTJ+lRP5Ubq/zWbHffyO+bxkDHWPn027NK5I54DY+bKaaNXU/36dnkHvSkjcZVQhrm7BrumMkf45OCFbSWJtPOWKgX+da2XCK0Hr/lqhip7w5aaIz97CalFcyIwkgG62RsrZ0ypOy4c+rZLMUSpg0maw34C/gwYgescI7SZqfZvbxKSWuqsFLuS4sbBumGC2w+hkX0RGzxV54eeu8HYdxuGFAhGIddkZWy58rW35LRaTz3LDvH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6666004)(6512007)(6506007)(9686003)(6916009)(316002)(66946007)(38100700002)(4326008)(6486002)(478600001)(44832011)(8936002)(8676002)(26005)(2906002)(7416002)(5660300002)(66556008)(66476007)(83380400001)(33716001)(86362001)(41300700001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k8dA2yxmhZSrS1nttVrU0U90W4s1+0lUCfNYT+HURp19NHvxQZqkfPv043o9?=
 =?us-ascii?Q?58mV4+Lum2Aq4n66NVesfhL30cRyn7W4bQl577leI3NM9unlwicWCFbm/z7P?=
 =?us-ascii?Q?4akV68GHvsBTkleNlJySDQTk9UQpHbzJcKhsZx33DQFwGJ54EsLywbAE6lnL?=
 =?us-ascii?Q?hU0dwCzqNamkhjcoOVah+6rbbaKj6+osxb5zqOSNOYsAlHtAiZutrEya5QEV?=
 =?us-ascii?Q?xANOBqBHwpFwFkD21oeUiVVcdd0Nnxsyu0CHXe6KLJkqsi/BUXj7ObI4qJiV?=
 =?us-ascii?Q?F6EiairV4qvG+f2XPFauONrJi8F+dgENLfHLdgS1n6+3l9uBQSxqmG+4aGkA?=
 =?us-ascii?Q?IUSo7SKLv/J2JCvzRnD0FEjvzXC4CtJiDggvMaIgovdEcXrC6/7uUSBdBbZ3?=
 =?us-ascii?Q?uRP09lQrxrVp5AOmGqCcopgSFiGPSN79C+l83GHYypLhuPZLtf9aT/cF77ph?=
 =?us-ascii?Q?EcFSAReK+EPv6svSz1ZyCMaLr2LrOJzOo3qYWPvPttIgCgzCW7oK+w+baTe5?=
 =?us-ascii?Q?pLaQfwq6ctjmsKNmKShKZH2mUVxO6oCEXiilVGlmfeCR2U6mG1O6Ykt2HEYZ?=
 =?us-ascii?Q?lTKIhJieEuLvfUDB4Ae3ib2SMW6Urrd7XoKNnzNbjk+TtgnJXF2nITiclYou?=
 =?us-ascii?Q?s87CBNRtgx8JFtWkxhQzPdEKh6yidDh6J1518tEkOuwMr+23Cu9PhN16rvZw?=
 =?us-ascii?Q?+GeNJFlSHTEb7v996S7zdVimKHo2B8+VPv3/8pVAlStLbHfF+MtLLf6tJKcM?=
 =?us-ascii?Q?qV0MotHT64rjw7S9+wL8G+fBoLNwGk26AlzXMEAclAdhXxSTdjIP8uXxHwr1?=
 =?us-ascii?Q?u+EuTHDZ2H/sfLqObLQDi9Islxu60DHdBQXTQs0jCnHbAZYQi9PTT9hiDk9Z?=
 =?us-ascii?Q?QeqFfogZpVOCd9jgw+VqgkX9xzBzWZRF6f50BsJXrAAVJ/fHlWyYHdluox8w?=
 =?us-ascii?Q?o4uwi0ezVLWPBiHLq5b6NzTt9IxCCix2v/yLOFWEUhhlLcv+B2fFEEl5ezHt?=
 =?us-ascii?Q?KRGlB8/9QEzl6wF2P88ec89HlxLwK1YUQHDGOfmudXrTO3+Gu3a5HvbsJ4ZO?=
 =?us-ascii?Q?SPniOm1BKZrshPU7OxyTSgAGp3Q5RlwAHzLmLAls/2Yqnsj6Rsr5P8Npj4Nc?=
 =?us-ascii?Q?EztITD6j9OxVcFKNseSfnML28NSa47OyvbNyXRbwlF2PWPMXwZjhAnq/aS+F?=
 =?us-ascii?Q?5TDthNLhA5JwEi4I4sHynaL/Kausts0RFKugABJhVOiHRdpR46ef3FpSNOiz?=
 =?us-ascii?Q?Vt2sI4Zu9ygBd+4rezwJUauQkEPlIGrh6l/nh/+XqLTA9QVUXMTSYad5FzL8?=
 =?us-ascii?Q?MPGew4JgHriZFAMpBAPLTzEchRILSTbRy/+RMmiSndNz+QOL0oRjd66TBkOb?=
 =?us-ascii?Q?OpHv7As+twtsnCxeyLtS8jJgQvKlxEbroE5Liof9Yzj1x0m+95cas1hXvVWy?=
 =?us-ascii?Q?OvuzGgUwJQOa4OovHQQl12KcqXVpCIpOSMYYLXLgis+/g9znQE9hLaH91r9K?=
 =?us-ascii?Q?i7o7xMxbBmzp9rKDR8RxJavObc1aXfl9RotCLKypR9zTLnYfoPcbdp5YJZK5?=
 =?us-ascii?Q?FBG+kgwoACWSwZP7WBgUNhBX/2NlzH8jxcusihBXoOQWd/w/M3NSO/gf6XQ9?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf6ec74-7a74-40c6-19e2-08dc1ce59351
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:05:52.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Zy7aDHP10/e8dFiWKigQ8uuvy+OeGcAGVtL486hVFhzvZ1cvGxMqv9kcBkTv4NVW0dtHAypvQ2uFcBcIwn57X2J0+KlkMaj6VfYTbYl19w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8305
X-OriginatorOrg: intel.com

On Wed, Jan 24, 2024 at 09:37:13AM +0100, Magnus Karlsson wrote:
> On Mon, 22 Jan 2024 at 23:16, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > Fix an OOM panic in XDP_DRV mode when a XDP program shrinks a
> > multi-buffer packet by 4k bytes and then redirects it to an AF_XDP
> > socket.
> >
> > Since support for handling multi-buffer frames was added to XDP, usage
> > of bpf_xdp_adjust_tail() helper within XDP program can free the page
> > that given fragment occupies and in turn decrease the fragment count
> > within skb_shared_info that is embedded in xdp_buff struct. In current
> > ice driver codebase, it can become problematic when page recycling logic
> > decides not to reuse the page. In such case, __page_frag_cache_drain()
> > is used with ice_rx_buf::pagecnt_bias that was not adjusted after
> > refcount of page was changed by XDP prog which in turn does not drain
> > the refcount to 0 and page is never freed.
> >
> > To address this, let us store the count of frags before the XDP program
> > was executed on Rx ring struct. This will be used to compare with
> > current frag count from skb_shared_info embedded in xdp_buff. A smaller
> > value in the latter indicates that XDP prog freed frag(s). Then, for
> > given delta decrement pagecnt_bias for XDP_DROP verdict.
> >
> > While at it, let us also handle the EOP frag within
> > ice_set_rx_bufs_act() to make our life easier, so all of the adjustments
> > needed to be applied against freed frags are performed in the single
> > place.
> >
> > Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx.c     | 14 ++++++---
> >  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 +++++++++++++------
> >  3 files changed, 32 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > index 59617f055e35..1760e81379cc 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -603,9 +603,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> >                 ret = ICE_XDP_CONSUMED;
> >         }
> >  exit:
> > -       rx_buf->act = ret;
> > -       if (unlikely(xdp_buff_has_frags(xdp)))
> > -               ice_set_rx_bufs_act(xdp, rx_ring, ret);
> > +       ice_set_rx_bufs_act(xdp, rx_ring, ret);
> >  }
> >
> >  /**
> > @@ -893,14 +891,17 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> >         }
> >
> >         if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
> > -               if (unlikely(xdp_buff_has_frags(xdp)))
> > -                       ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
> > +               ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
> >                 return -ENOMEM;
> >         }
> >
> >         __skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
> >                                    rx_buf->page_offset, size);
> >         sinfo->xdp_frags_size += size;
> > +       /* remember frag count before XDP prog execution; bpf_xdp_adjust_tail()
> > +        * can pop off frags but driver has to handle it on its own
> > +        */
> > +       rx_ring->nr_frags = sinfo->nr_frags;
> >
> >         if (page_is_pfmemalloc(rx_buf->page))
> >                 xdp_buff_set_frag_pfmemalloc(xdp);
> > @@ -1251,6 +1252,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> >
> >                 xdp->data = NULL;
> >                 rx_ring->first_desc = ntc;
> > +               rx_ring->nr_frags = 0;
> >                 continue;
> >  construct_skb:
> >                 if (likely(ice_ring_uses_build_skb(rx_ring)))
> > @@ -1266,10 +1268,12 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> >                                                     ICE_XDP_CONSUMED);
> >                         xdp->data = NULL;
> >                         rx_ring->first_desc = ntc;
> > +                       rx_ring->nr_frags = 0;
> >                         break;
> >                 }
> >                 xdp->data = NULL;
> >                 rx_ring->first_desc = ntc;
> > +               rx_ring->nr_frags = 0;
> 
> Are these needed? Or asked in another way, is there some way in which
> ice_set_rx_bufs_act() can be executed before ice_add_xdp_frag()? If
> not, we could remove them.

I am afraid that if you would have fragged packet followed by non-fragged
one then ice_set_rx_bufs_act() would incorrectly go over more buffers
than it was supposed to. I think we should keep those, unless I am missing
something?

> 
> Looks good otherwise.
> 
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> >
> >                 stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
> >                 if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > index b3379ff73674..af955b0e5dc5 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> > @@ -358,6 +358,7 @@ struct ice_rx_ring {
> >         struct ice_tx_ring *xdp_ring;
> >         struct ice_rx_ring *next;       /* pointer to next ring in q_vector */
> >         struct xsk_buff_pool *xsk_pool;
> > +       u32 nr_frags;
> >         dma_addr_t dma;                 /* physical address of ring */
> >         u16 rx_buf_len;
> >         u8 dcb_tc;                      /* Traffic class of ring */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > index 762047508619..afcead4baef4 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> > @@ -12,26 +12,39 @@
> >   * act: action to store onto Rx buffers related to XDP buffer parts
> >   *
> >   * Set action that should be taken before putting Rx buffer from first frag
> > - * to one before last. Last one is handled by caller of this function as it
> > - * is the EOP frag that is currently being processed. This function is
> > - * supposed to be called only when XDP buffer contains frags.
> > + * to the last.
> >   */
> >  static inline void
> >  ice_set_rx_bufs_act(struct xdp_buff *xdp, const struct ice_rx_ring *rx_ring,
> >                     const unsigned int act)
> >  {
> > -       const struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> > -       u32 first = rx_ring->first_desc;
> > -       u32 nr_frags = sinfo->nr_frags;
> > +       u32 sinfo_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
> > +       u32 nr_frags = rx_ring->nr_frags + 1;
> > +       u32 idx = rx_ring->first_desc;
> >         u32 cnt = rx_ring->count;
> >         struct ice_rx_buf *buf;
> >
> >         for (int i = 0; i < nr_frags; i++) {
> > -               buf = &rx_ring->rx_buf[first];
> > +               buf = &rx_ring->rx_buf[idx];
> >                 buf->act = act;
> >
> > -               if (++first == cnt)
> > -                       first = 0;
> > +               if (++idx == cnt)
> > +                       idx = 0;
> > +       }
> > +
> > +       /* adjust pagecnt_bias on frags freed by XDP prog */
> > +       if (sinfo_frags < rx_ring->nr_frags && act == ICE_XDP_CONSUMED) {
> > +               u32 delta = rx_ring->nr_frags - sinfo_frags;
> > +
> > +               while (delta) {
> > +                       if (idx == 0)
> > +                               idx = cnt - 1;
> > +                       else
> > +                               idx--;
> > +                       buf = &rx_ring->rx_buf[idx];
> > +                       buf->pagecnt_bias--;
> > +                       delta--;
> > +               }
> >         }
> >  }
> >
> > --
> > 2.34.1
> >
> >

