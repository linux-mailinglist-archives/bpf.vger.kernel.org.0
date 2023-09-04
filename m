Return-Path: <bpf+bounces-9203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F75A791B0D
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A0F28101F
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B56AC2F4;
	Mon,  4 Sep 2023 16:00:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDBDC144;
	Mon,  4 Sep 2023 16:00:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA32CD4;
	Mon,  4 Sep 2023 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693843249; x=1725379249;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e9sZd19dBguvKOjeRuBUhzSEE9bSEyBAVy1jJmjNYpg=;
  b=R4+J2HnzMFwVCf42jGciT1GE8+JJrBE0LPHZpvdL880UvuVA9icB5hTv
   M0+mJ0I8WJGaZAVr/lKySqSAeBw9Maa9YFT6csLoHBvvR/oA/5klk/0Gp
   IpKd0GoOU9K47hGf19eNTrb3ju0pryF0+UKs5y5JwB1gymy6s1U7paa9U
   GWXVc9pfjv8r071ZIdZKE7IlKKgB1GWK6ogJ8m4R8rHIBiK0oWv9o1nZ6
   MB1lUbM8oihvWmP6StbdTbqvelAqCaTAXH+Vpf7MlHdbYCfA4lyqqjArc
   c/7WMIB/xZt7Y+z7uotQFk3S+RUKilnNqXrcFpEm7Ld58CQRmpexMtTqY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="356939435"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="356939435"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 09:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="717603599"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="717603599"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 09:00:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 09:00:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 09:00:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 09:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2D9Pf+8Hk1gFeFgIPq+ZYyiMQNi6SJlwqdnuTMqjG3zg8wPmyjH2ms/qhJ78w056b1NB6mRSJM4BWaFRJmxksHUaB1BOuG7rvOkAeoHj8GJ+0+TCHPUl/WLtXlL/383PPx+1rtx0G6eRpOqyebsDu1Dmr5sNEmtHQ1pTcbwlCofmmBV1e4v0986kqjr87oMGTVDQDsusyMHqdO6eYKzGJWQo653EvnWoRr+ePLgBSMNWNCwcaZ6ZGXfPl9LovjadvffxsKXgn5BNHtDkKesMzkvoI6klF5bS2LwttsBekt8lNBFAriAZmFyJfMgfqlmOltXGmxwEddQAJ2GnmwrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znD/WgF+eTb3bTuLtXbsb1VI+jdXriXv20kdmBggPBo=;
 b=nEkUahxpKElrr8U0Gx7qKS5CGosIi7f/DyPrjlKjHzH22a/295UxaW8Lxd089++q6n8FcDZkSdnx+8rDhTSWySFsqhTN/qMMmHRFrzmQrmnfiK/JLLrzgZFYyzBokebvi+S3foX1NulFQC2mmiPtEhD48QNSbGRnN/F3J0QrhDnkaKOB3HojmW5pV/2Ojr2NJudscCdKcUKqP9etzREo3v3CURe470fYZqCWr+OeDaoJo2gF9JZNL43AI/Fmlfc4Xag8jj2FYxqVyV5iDByxRFWdQYTbbyOizEtaJBEnj6WiyskUlz7G43w/ne5JggLfchkL+IzxHzu2xZRkpybsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Mon, 4 Sep 2023 16:00:45 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 16:00:45 +0000
Date: Mon, 4 Sep 2023 18:00:34 +0200
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
Subject: Re: [RFC bpf-next 10/23] ice: Implement VLAN tag hint
Message-ID: <ZPX/IqfeLXcyQjZT@boxer>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-11-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824192703.712881-11-larysa.zaremba@intel.com>
X-ClientProxiedBy: BE1P281CA0377.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ffceeb-d20a-43e1-35d5-08dbad60188e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tim2yL/zoR9aacegiR6CiJjT77uDQlY8PnNAs2IK9cmSX9S8WIU8BW01G6KCewXLDOsvjZwc25IHUmpoH+pN98lOuZ5TQr461VqU4hsK1svrmaCsWZVCddJ2GjZq906rEzsRPPw8Ota0ey/M47FxhcfChnWGOhHB410p2X8GtDE3LBc8O/2hlVj6SHHEhS1hXEJMmVi+0sF5IJPF8BCq0S+87vYC3p9os9ZXnlgdRTibacxMy/u0OSI4bPRok2o/W+WPikGC82RH41Rmt9omwh2ZHoxdGGH2DDd8+wIOZoj5YFqR4n92Ypqfey3YnCuoQyjvvVxKnmoIo6vhRw10/YPGwOFiQ22ukO6bgUmEm1m8KbQvfZB4uiIyPzDF079taoodRSnvdXoDZk0ybfprSdOFkWs9gG0+MPfs5PJKLqNi2n5PpODO8pY+isrozyklGPDpAAn8hO9J6e+T8aG9wEBEuAKJ5vQEFJoCsCDpZ1MIihhllX6ziLbTUskUo3KcjGEUC30dKUY0AJuTxnxNIiH4XgUQ4XLA4P3LLtG1/Lwc24RnqvKROJqAW9rOUvp5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199024)(186009)(1800799009)(26005)(44832011)(6666004)(8936002)(4326008)(8676002)(6862004)(83380400001)(5660300002)(6512007)(9686003)(7416002)(6486002)(6506007)(41300700001)(478600001)(82960400001)(66946007)(66556008)(66476007)(86362001)(38100700002)(316002)(6636002)(33716001)(54906003)(2906002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UVVBiKLQwXfG689IuDQHw9TjeheFOjhOrzh0ZNrPYbJlvel8scBKY0M51r/v?=
 =?us-ascii?Q?9rAN5mQdubWj7dqXtCxYe6nLRx5z47DJmcxaguO4nSgb3VJ+st0dYGhyDJIY?=
 =?us-ascii?Q?ykp5hhCkpd9Y80TR0Kw2BUdCDXy9K3kbz5ENUVjSNlku81OXksaU33ubYTY0?=
 =?us-ascii?Q?cHJxkdNMwj2qWC3D8gKtO3COd4/NcLCJYnD9bvXblcXoSKB6JetdJLwBuA3j?=
 =?us-ascii?Q?bzSyTz0P/4rDZLYJ/C9pYSBypb4gSCAc7L8W5c8V8qU6FahFNr78x4LN3JuN?=
 =?us-ascii?Q?lPo+qN48/JV3Md8FafaI8fhFbCZ15hpyMfNmINSfyOp6h8wWWmFEYg+14dm0?=
 =?us-ascii?Q?slN992rzs4rUev3O1DNndgEM6s1jL0mEQEBW3gnJSItkFnMjZ2sVf9SNZw+8?=
 =?us-ascii?Q?CX+mnQQfXjKYieeNV3TlEhgEzuFBBOiJvBku9DDMuPadMTBb3bjs485KZ5yj?=
 =?us-ascii?Q?y700CXgGAEcDURJtq/ckz13FTzROdbdiHkJdQ756DiVmulwV9XdhTQYIUp3q?=
 =?us-ascii?Q?fpGG3Via2FQwHnkyUAuQjF/bHrn8khIBZAvQ3db6vUpKLB2+zXXfy5fjBoHg?=
 =?us-ascii?Q?LMS54TyFXIUTuoJabdrmIXMCHjWz4bIOsxRIgD0lacHvA1GzoS0Jq4hZTlGm?=
 =?us-ascii?Q?zKQ7qPNiCdpKJbUD5GIxAJsNGaS332/oMm894y07wvhVlWcXDLhSjg0MokFt?=
 =?us-ascii?Q?gwjVMdqJ0UgXjRb7KrCBtf5bm6xoZd1eyIn+MYf8YHhyCl4VzcFXipqSCgvq?=
 =?us-ascii?Q?OGTMb9GQzWdnMVh2PhBUz82eAc9AM9ZyC6yzFB5CZBBkDWHnMxcBGgwmq4+J?=
 =?us-ascii?Q?kaBVNK1L6b6QtRttpHVl6xZMJWd0LKyFa3fYJgZV2XMRFPxp60NUeeqYaa3U?=
 =?us-ascii?Q?36gjVR/Dvo8jyxO/ocSgnKYHGmErmPPH1+81cBl4z8WoVauCrjI7syGMuvnL?=
 =?us-ascii?Q?Hlw4Jwv88TIC8if4VHJzXKPMX1q8PIy9yWlQ2IbS3D3Mz3GDvVUH7yiQF3Kw?=
 =?us-ascii?Q?qPblAkU+BDY9ZO7OlH6NnO9ynEBPVK94hl2IsB8QQNI7MC497px9VZ4kdw9D?=
 =?us-ascii?Q?x9ab9XeOUP7pp2xEcWKcyg+cm9pbC/CKYzJtbGy89KVH8OpfEEkEaDRZ+dn6?=
 =?us-ascii?Q?AZHfk/nFo6wYSOX0pSdl3y0OJ/SZITSxJWxkz5Y3DFZZ7LwJt4r1FR4lucOJ?=
 =?us-ascii?Q?9a4sn12mCGz0VZXxSWe/rafQn0Ze5Y3JI4wZf1Evdi6tZf6Ssyv//AxPw5/X?=
 =?us-ascii?Q?5TgcI8/Lo+VxtYrjG7+SzO6UGmzrB9KDVB1bAY2i5p/djs1QGR6bpYJz23U4?=
 =?us-ascii?Q?bTJwyDsCMVM+WP/W5OKrtefoKUscy4zErPK3BXbxpVpdhe2gfoFmmOnJBNv2?=
 =?us-ascii?Q?hdfGjZL6wqJ6+Q43qqrBDNcfvr+u91AtJuBl+9b6GPes1QHxMhk0uYco+V8k?=
 =?us-ascii?Q?Nc1fqM+3JGcAxg3HMLFH8ufvjybB/STORhpRXT0l5sZ0FtsKPzmdXEyifNty?=
 =?us-ascii?Q?mPqO4GAW51qp5wTXwc6dfD2DlB1dO252eeY/KsPavrypRNaSu/Gx9ZTIbxCl?=
 =?us-ascii?Q?edaJO/tuOwesRCfRtC2Mo0A6999G9xxO8le7WpqfF05MGodl8L/HV11K6dhk?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ffceeb-d20a-43e1-35d5-08dbad60188e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 16:00:44.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iARhWpEiMuXh+VWmcG9X7xggfLnrRKFINARrvXCVpKP+woWwOqtgwCp9GgkZB8v1kLTuUpgovNnVOKuo3zN3bMNwcNjqQER2Llunq7ZU1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 09:26:49PM +0200, Larysa Zaremba wrote:
> Implement .xmo_rx_vlan_tag callback to allow XDP code to read
> packet's VLAN tag.
> 
> At the same time, use vlan_tci instead of vlan_tag in touched code,
> because vlan_tag is misleading.

misleading...because? ;)

> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c     | 22 ++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  6 ++---
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  4 +--
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  6 ++---
>  6 files changed, 57 insertions(+), 8 deletions(-)
> 

