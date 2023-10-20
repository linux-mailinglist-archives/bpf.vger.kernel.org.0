Return-Path: <bpf+bounces-12847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D512A7D1402
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 18:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0B0B21555
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702E01EA8C;
	Fri, 20 Oct 2023 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqLiOuFD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E661EA90;
	Fri, 20 Oct 2023 16:32:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A14DCA;
	Fri, 20 Oct 2023 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697819558; x=1729355558;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0W13LvBElrFaWAMyAgVHin8r2v/tfxr7TRnNzLlc5jQ=;
  b=jqLiOuFDpLGmsGFPfFsMfpHdMGuCb7/eW2nySwGHfmCxWZPlznUlyiPU
   E7KEsQFT1QUheFoaCTealdD5orzZFYDSzIm2Z9kjbSFgJBPLEPXsSqisx
   ftM3GHQ68LPwbvq4wnlL7q1mgMyKOztw6EV0gbbjpVrhadD63FBAH59JO
   7rAI0MvDp02Dn9VMfx4tqFBuAuEKVvXN2gDGdxyIrcEEk4DDIoQr7q8bx
   0lKHOJIdO+xxF7epCZlk0CqzAKAwMIxck+GaEeVcaw93//FD1e4mRWsNf
   +O42NghrkLj9xr03XC5Ygsoks+u120sPV9apLgBGw37FFvyUBJFP1737l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="8091974"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="8091974"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 09:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="761101770"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="761101770"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 09:32:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 09:32:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 09:32:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 09:32:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 09:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu7DtdUKupmd3e/t58Cr/9ubeWlWVu/XgKg/WAW66UUzDxlt5X+cBVSsZ0rLdb7bDxkENlw4QGi8fxX8NQSfTUOioJXs7jk5Q+loEGBsGtgog5iNYFREmTBlgumZRwvSf8QhycwKSS1P0xLR366HBPFUa0Bt0I1kMf6LiZvTdqfDiKrsfIx3o90XkXcOVTStJGSPRbHF/VbxBCtBfELJ5nyhK/xS2Tc4pm7IweQ/MMkGVSuznIY9R3ZeCnTsa6wmXWrr5BkZt7hbBLWENyARbbQSKLK7zuYHqsoNTLxj26sQBKbhBQT0hnIgxWjhSTkEiqh+H0Q2LQZbPu5v0qQu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8HlMiVm7Qtz/9WoYxYfZYOnIbOCMTHTmWElfMFtuZw=;
 b=hlJiIlPMrj7n3eCn/j8VTedQbfdF8ZLnOjUAfc0kTyhNId09w1kxMlmODQIHUhJQJn09bO99qukuvUAPXA5RmFNmUfvs5kuB99SNLFXtbyyg9bkjPyb4ScQNUett5sZ+15pNf6Mq3OoD+IK+90PKjogItTtCTpCsUy4FjKtauO7zHSg8gYonmzfXtE8YkaB98KvArLi3YuFKH+D17JVj7FyCB0FUd5poxE5P2AJ+RsDllpDZ6C934aUkUxerft0ZwpNm50En2/CXhpLqeL4tQAhE+47PRffFBxSA5D/zyCnvWUVMfxQI5Cn5Qs3uAv8yKPCAEQK0qfNjvat12I/QAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 16:32:32 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 16:32:32 +0000
Date: Fri, 20 Oct 2023 18:32:13 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
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
Subject: Re: [PATCH bpf-next v6 11/18] ice: put XDP meta sources assignment
 under a static key condition
Message-ID: <ZTKrjU0a0Q1vF1UU@boxer>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-12-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012170524.21085-12-larysa.zaremba@intel.com>
X-ClientProxiedBy: DUZPR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 03840049-7ff0-4f31-1a25-08dbd18a2894
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+lmh2I2UmXBEDUXUtGYLSU4PgrhpFEr0KwpCd4aYvYkpErzHhTulfw3LF+iH0yQxOODtmpwV+f5uZX+aXhq8fOACCmQeIcBGv5w1l8MM7vLXK+YayZ6IKBrixST6m4csKQ85joUz+NeqsW7gyOEBp2UWnI58FfmrdKek9Y1LTZJlRmS7fsb29jWAMDShcK+O8xT7OcaJ8g7xUqwiGvZSHzzfa175uF7gj08oZVN+1HMYrpUKgbS34MdaFbLUTJszUj+3Q6IaR8FHnKnMQfl3IQ2a2NzbCbzvVqphTH1bXpuZJP1CwjcIU0tODoMheUEem617mI0bZTM4JI8oVMWfc1YCJ/KrQwkhGJxHb7UZf6o1sEO0PQTfUb+4gEeq4QLMUTog0ZCsz7wYbnqNmfr5ogPkdnyJLvWo1JTcwirRe/z/BW2SIn1vDk5azRqJ6O09Q9HJ30GyvoIbVPttT6itDhEE5YxUAKtTH4N/lLjPIPEhLhKuRkgi85pb3ngfN/r0fuOeBhfBWTLl7lwkRZ4eidbsxDCLHvmWSlwkAIhOn2OatuBp5ONNAYDWLqvxe52
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(33716001)(4326008)(38100700002)(86362001)(6506007)(44832011)(41300700001)(6862004)(7416002)(2906002)(6512007)(82960400001)(9686003)(83380400001)(5660300002)(26005)(6666004)(6486002)(8936002)(66556008)(316002)(66946007)(478600001)(8676002)(54906003)(66476007)(6636002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/7A9l/NPdiomT+uroBjkY31xc4oZwtWPYR36vKGtgyIZZoZ4udntpLL9KOOf?=
 =?us-ascii?Q?myHooVxLp/SaA+Yu8x10cUkV+lqljyVj3JuBT17vVtp1tG35QosoEg7BW0EY?=
 =?us-ascii?Q?krjiq/AZ96mqJjmVczC0S14yzfQu82jtHs+40jWdFZnL62IGNsCzBMq8tZog?=
 =?us-ascii?Q?k4QvAmmCz5cPNqatZF2YWbUa4G238yqXpkx501BXAPpmybr6Y5zwjKs+pZrS?=
 =?us-ascii?Q?duEcFq+42+x/Be1a+Q0AdAsFY7uK3IDQRDMp93TepBtR2aGSPj/VdK9suRYh?=
 =?us-ascii?Q?es9l5p1KY2x/t2Vcf+fAn0/AJGTTLpcAULfulCKGxcPUHCQ8nnBDEAGyAkgT?=
 =?us-ascii?Q?PxPa9nWMAwbH25iNNOceh9zCJKxJBEM5JsQSrVEPKM0l1NpcJuVU9fhlrM/O?=
 =?us-ascii?Q?yHE0/MGur6PoHOTEehnng5W/eZaOoZjqYUh39Y/uaNy74urgTBt+MWBK5L1G?=
 =?us-ascii?Q?/bgXsD2OIP9fs360eaAC4V3xwmPKykXevVh9ghLa5ZBh2bTaWrELx2liT4/6?=
 =?us-ascii?Q?OIZAUcDhl5e8sKl3Eg7qkWz+kgb4o49RFwrCbcaC+XttfEhb91/H3uN1OpWt?=
 =?us-ascii?Q?1hhJmjSwScHUzLTrBK+KJRva6WUa6SDTAp067N3fxc2y/CWwEWaRB448n9kE?=
 =?us-ascii?Q?zGGH4vegHQrOBSjPuNTktru74T/js1i3rnURTbi9iXEKgl9FTGM+biivFsCY?=
 =?us-ascii?Q?Ne8KCh7/VM30+XTNjALCicxpFtOryupfUp06zWBiFjkk3AdtknGCFKpejX4p?=
 =?us-ascii?Q?caRT1q9FpjS22Z1fof8KEIlo5xo8ETaay8UmQszz5e0OChH6rtByB42+ROQD?=
 =?us-ascii?Q?JGwIK0PpQTqlGkMHcD849l7ZMC4sm1lqDkwRZ5eNzheER9v7qRJS9TGWGtmx?=
 =?us-ascii?Q?0tlKgX2tmYJZ+DldDDunBa4Hv0vKKRIDtHJQq/dYvgxucKKOk0vwZgI3DiV3?=
 =?us-ascii?Q?SGf2JOiUHbhmDJQN5BpddA/SiZHO0e/GfXISonjFtWAX9ErnM2r+hffh0THD?=
 =?us-ascii?Q?vW4j2zgYbooe3WCCEvK9ECG8PQWVKi8hYZc1iFJfHK++RrPy7lwKkE3pkXEk?=
 =?us-ascii?Q?VhyWO9MKDOH/sDa3ByaGCFiLYUKThzvbpqoHjSCN4S55Jm29buEpfOAdGWcH?=
 =?us-ascii?Q?xF8hJFgLmlqOqeTVa14n41M/IqE50xY5isErDlqWudFDSfZgCuB5iKdSjbJO?=
 =?us-ascii?Q?9EYJafVTubNSXrkN3/O8zYse9tnf1T/uXQ1UalOMW8zBrFf7mSWhiUvPhdVJ?=
 =?us-ascii?Q?qzA3/3MP6Pg3ujSDnToop68szytFRLoYtr7kJzpwv1O15kFU1Hc5XiSLFQfu?=
 =?us-ascii?Q?fx8CLoqj4DTcVNWRL97Iy4Tx7u2OUfmekOIxJHQ2PEfEM8pjoPoCv6k+GWpi?=
 =?us-ascii?Q?SBbEfkn169JmRmyiZkPckecimRbTUVCJI6IJAV+MfJzXTNJaYlivPf8Kbp2A?=
 =?us-ascii?Q?Y7ZeOPCDB8U0a1MdO++BIAnzYfbOtHICDv+Nv/S3qhYEii/Y7lmxRQeZfIIa?=
 =?us-ascii?Q?YGVPenuPKTCfgyDkO0UfPq1bO5XFDgjxkhZuPw9yRh8PslcRwW5Y+cp2N1wo?=
 =?us-ascii?Q?5GSt08uwexRf8inz/gOU2qF0LVAEFLNNH0QzfMzoRGs8N0yKXikpOSgHPnEn?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03840049-7ff0-4f31-1a25-08dbd18a2894
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:32:32.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joayqGzATytnKSAec49wmJUmgtYF6BN5tdyG77509TmImDfnzaFSyDIxY9u0loa6HQPL4icZDxM5yaMKYyUa9bFhUElf5ljuNdeg87RRSSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com

On Thu, Oct 12, 2023 at 07:05:17PM +0200, Larysa Zaremba wrote:
> Usage of XDP hints requires putting additional information after the
> xdp_buff. In basic case, only the descriptor has to be copied on a
> per-packet basis, because xdp_buff permanently resides before per-ring
> metadata (cached time and VLAN protocol ID).
> 
> However, in ZC mode, xdp_buffs come from a pool, so memory after such
> buffer does not contain any reliable information, so everything has to be
> copied, damaging the performance.
> 
> Introduce a static key to enable meta sources assignment only when attached
> XDP program is device-bound.
> 
> This patch eliminates a 6% performance drop in ZC mode, which was a result
> of addition of XDP hints to the driver.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  1 +
>  drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c |  3 ++-
>  drivers/net/ethernet/intel/ice/ice_xsk.c  |  3 +++
>  4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 3d0f15f8b2b8..76d22be878a4 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -210,6 +210,7 @@ enum ice_feature {
>  };
>  
>  DECLARE_STATIC_KEY_FALSE(ice_xdp_locking_key);
> +DECLARE_STATIC_KEY_FALSE(ice_xdp_meta_key);
>  
>  struct ice_channel {
>  	struct list_head list;
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 47e8920e1727..ee0df86d34b7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -48,6 +48,9 @@ MODULE_PARM_DESC(debug, "netif level (0=none,...,16=all)");
>  DEFINE_STATIC_KEY_FALSE(ice_xdp_locking_key);
>  EXPORT_SYMBOL(ice_xdp_locking_key);
>  
> +DEFINE_STATIC_KEY_FALSE(ice_xdp_meta_key);
> +EXPORT_SYMBOL(ice_xdp_meta_key);
> +
>  /**
>   * ice_hw_to_dev - Get device pointer from the hardware structure
>   * @hw: pointer to the device HW structure
> @@ -2634,6 +2637,11 @@ static int ice_xdp_alloc_setup_rings(struct ice_vsi *vsi)
>  	return -ENOMEM;
>  }
>  
> +static bool ice_xdp_prog_has_meta(struct bpf_prog *prog)
> +{
> +	return prog && prog->aux->dev_bound;
> +}
> +
>  /**
>   * ice_vsi_assign_bpf_prog - set or clear bpf prog pointer on VSI
>   * @vsi: VSI to set the bpf prog on
> @@ -2644,10 +2652,16 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
>  	struct bpf_prog *old_prog;
>  	int i;
>  
> +	if (ice_xdp_prog_has_meta(prog))
> +		static_branch_inc(&ice_xdp_meta_key);

i thought boolean key would be enough but inc/dec should serve properly
for example prog hotswap cases.

> +
>  	old_prog = xchg(&vsi->xdp_prog, prog);
>  	ice_for_each_rxq(vsi, i)
>  		WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
>  
> +	if (ice_xdp_prog_has_meta(old_prog))
> +		static_branch_dec(&ice_xdp_meta_key);
> +
>  	if (old_prog)
>  		bpf_prog_put(old_prog);
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 4fd7614f243d..19fc182d1f4c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -572,7 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  	if (!xdp_prog)
>  		goto exit;
>  
> -	ice_xdp_meta_set_desc(xdp, eop_desc);
> +	if (static_branch_unlikely(&ice_xdp_meta_key))

My only concern is that we might be hurting in a minor way hints path now,
no?

> +		ice_xdp_meta_set_desc(xdp, eop_desc);
>  
>  	act = bpf_prog_run_xdp(xdp_prog, xdp);
>  	switch (act) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 39775bb6cec1..f92d7d33fde6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -773,6 +773,9 @@ static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
>  				   union ice_32b_rx_flex_desc *eop_desc,
>  				   struct ice_rx_ring *rx_ring)
>  {
> +	if (!static_branch_unlikely(&ice_xdp_meta_key))
> +		return;

wouldn't it be better to pull it out and avoid calling
ice_prepare_pkt_ctx_zc() unnecessarily?

> +
>  	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
>  	((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
>  	ice_xdp_meta_set_desc(xdp, eop_desc);
> -- 
> 2.41.0
> 

