Return-Path: <bpf+bounces-8996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B923978D7C4
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 19:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420192810F0
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC047472;
	Wed, 30 Aug 2023 17:03:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2A3FFB;
	Wed, 30 Aug 2023 17:03:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0B419A;
	Wed, 30 Aug 2023 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693414996; x=1724950996;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GI1gENhzcGhV34TZumodSxjeWBMj54pPTl64PitmIwI=;
  b=GWnolMcw7lhzpVRUmgmTO3tPXUNdsQXS2LMhi/tOOYw0GGxVCqzSWbOP
   y/7SyKrDcYvA11vQmPegPsQtUIddd0rEClO/s8iZu6qZJCLbrOGZzLmN3
   N3/ChL8oW+++8bInzpiuYARyF9xfA/USkZHG34en9OUkUzT2qs/wZMn1J
   KK/WS2qfmuAaLKwegy5kCsHaHfHIw0Pg2tY6hOKZJtlSj7q6jqi+mfait
   cfge+ThAR6lgPzynB5CGQsS8+z6OrcqqOAaIVNKpLuJ01scrmaXWdSC3y
   G6w9h8/mRaaVmmAg7iZW2/10+zzaWthP7f8iceloNnt2n7A+NdJqd2dyb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="356015884"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="356015884"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 10:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774173171"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="774173171"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 10:03:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 10:03:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 10:03:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 10:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfoUw3xoDyw1uOcM81LIMRmr4ZnSM1YmB8ezxiK+2o5WT8OK5mrbxFFyFNGSMfsRjvybFWkSgjA9vBsnTZbkEQMPmxfVZZvdAtpeR+iS1BGnInTTipa3rkxYOi6kgp1v7LRjxu8v3/8fuhWCGmLQymqh/p+3KI/rmjHLYDdoxEo5ozUZVzFgOY7KYuuxdn31wMDKn6VnWDoY/N3XfHs2FM3imYueM/eIFPtabAC0HjENTpvOEm2ZGDkzpT8ZViBOXuFrgO5FkqQCkr9WPlwJzSqpa/v3agorvT6mQ8xny4QrZl73HPcVDWxcFu1rK1JugE9E3cQlXE+s0gmT51sFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In5ufpnt2W109OVPzAaZea8RyhHozXpHJT/Zeqrs9ns=;
 b=c9psHpscrtTYTKOVpmNyFafZSzTBe0gJ7fk2aURYguZdXlwaSMQ3n862OvGAQCGy1oruch/2rBenveqIVaTlRbR9vEjHwBMg8npl7xZhcbMU8B5mULDkBTXip3AmWFpoCxKLISuK0YmnySNgx4Ll+WHqo+2HeTtrilCPrcLDN12um1fpAJ2qRAoLYowbsA4dYGRkfO8aCCXtXY65n7Xt/vYXB8ldR+ajub2KqZ3uJtW/PJ3BILN6zQLPWO5eVZ686t/XBilKwmAwPHlXw985Z/P/rFffsc+s4eUeE7L+vKiNwP9d0c5IN8yrYYqx/vaIG+0pJNHZ7gbyhin04buEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Wed, 30 Aug 2023 17:03:12 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 17:03:10 +0000
Date: Wed, 30 Aug 2023 19:02:56 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <jonathan.lemon@gmail.com>,
	<bpf@vger.kernel.org>,
	<syzbot+822d1359297e2694f873@syzkaller.appspotmail.com>
Subject: Re: [PATCH bpf] xsk: fix xsk_diag use-after-free error during socket
 cleanup
Message-ID: <ZO92QCe1s7yUiHRR@boxer>
References: <20230830151704.14855-1-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230830151704.14855-1-magnus.karlsson@gmail.com>
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea48b06-aa34-4c99-fa0d-08dba97afd04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHuTHTkcp74AM4JbyDk+ef/FO7fQ0PWjAhhe5Zn+O/3r09sKn4t378BCQlQuC0eJrhRdCYjZO7KiqecFGCXCg5/hb5EtkFgfXD5Q/LOx/5K9b7nrjJiEnN5gl64ivbuawBL/yrTuN2kWSJFA4fx4NpMRlCxTP15ZV2OW0ESOMylwqJA9NdtLGfsEdJLA56h9Xx/dk10UOt1BCCq045rULR/iQJRMy7Vdqn2wCescQWr1mw9giggJdoQMln4fTpY87IQeDbOCsOexwJIOyJU5A54VQ3q+gPX+HFy74vmDlRlKmpwJ1K73iSRg1jlxWNjNZD6vTgxE2SaB8Kri+mah9AADbm8gPlr0/lf2cZg4vmitsi6i/Cra0WzFloMmOxZJVt8VXmHy0qZkZO7Cb+GqzgK/QX43TsXE/xltm8t+UlViSawat70pP47MmttAr1uHAsZmGtAyS+iVkTBiir2twoLLhJOW2MyeAazMB0coFxJM8R2a0EnxcBRFTLTyL+WORkUN+owUb9Lxhuyw7cn1IyrX4gtDXeHos9j77tZyJWbk3Ixzm73C4QCHehVAXxK6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199024)(186009)(1800799009)(478600001)(38100700002)(26005)(66946007)(41300700001)(6512007)(9686003)(83380400001)(66476007)(66556008)(82960400001)(6486002)(6506007)(6916009)(6666004)(316002)(44832011)(5660300002)(4326008)(8676002)(8936002)(86362001)(2906002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?96jOhnd3uSjrJ/AaEiNzqOSrZdgGiwtlBA5RcbXhn5m73iL+0M6RDYvE5ZwV?=
 =?us-ascii?Q?wy2bfCYPVFNb0DswiVQXX6mV/CVOSwGVqa0yJ9poouhJSLo+P40N0YZgU5Rl?=
 =?us-ascii?Q?TXKAQQOJYTBR0yCn5otJT0kYhM5RBm5M5W0k1R/fkWX18ftz4oiejCHxaEUU?=
 =?us-ascii?Q?Sl/4/8p9rRFLYJAoNSZZpl/PQXeva3zbiQAA9ey8qtX/ffKZ7SoFlgPCjQfx?=
 =?us-ascii?Q?4saHw2DFl2oPF4lVpPsWxSePs0Pfubdw/4A54if8+bEWa+LiBRt9PD7ET/Fc?=
 =?us-ascii?Q?HzrLIWxPvUCWvDW1xV1JbLBDh022kSrXAh9vDnvYxWAxdaXdN0gfqRb96npk?=
 =?us-ascii?Q?YLJ0Vld/r4I8krUaOcASlDSB3+N3VFUXlBrqOxoZBy3T+abKA+n0/PzQwQCv?=
 =?us-ascii?Q?FJ83WBBIi9PpRddYtz90uFMtN1gh95KtGKD1KRF2NiWpn9muh9DWJ4801lNm?=
 =?us-ascii?Q?1adEJSN7MzKwU46TZXLb/NwMrRWjUtmrzBGr9E+istWzi8Xz1PRXOJ3c0mhq?=
 =?us-ascii?Q?OtmwkyfRy5jjhZ9JSINQ0+/wWXHkMCEP9mVsFizpyd15Tkt9hym0my71y88Z?=
 =?us-ascii?Q?q4TmliQB82y66MDFB3OpcnIYjEUblz7mVfbIJh4rZWX81xercbramdO4r0Jz?=
 =?us-ascii?Q?bdOj+OVQSyrjtb+N3G2ZeVrm9K3heg4cgBEVK2xj9lnisPQ7x8WLkiuBYg4d?=
 =?us-ascii?Q?3nmL6lpqjZVCciykVogc6w+9o7mXTq8tMsVMK26DhFnUfPT1apSWqLDBT6X4?=
 =?us-ascii?Q?DZpSXInT9sN6bCWnpshRx9OXxvejaf6Zn+lYS2WtZlkEkDl4FiJwJj0TvTxg?=
 =?us-ascii?Q?G2JhohKFXKZct1yS9W8hcnBouPcnUwVoCYZrn3eCHjqbIeso715hOjz+6/47?=
 =?us-ascii?Q?QgFDh9T0aQYbdUuGxU7dGCajHzuPSji8p0KCzMxUwCoIdO53GWQ07vZZri64?=
 =?us-ascii?Q?GuakIU3VjXG5Bn+XGES5q4YDzsODg0fmgZl3gHO8q34r5yPqaOqvjRgj+SnJ?=
 =?us-ascii?Q?VIgigef3OHAAQKPRmuKcGi/YQfhmOFWKl+XuzdgNNjWsA+BzXYXzuVqJS+Ng?=
 =?us-ascii?Q?WfkyTFxdx1Jyly61RSyvz4KNEfG9SZoHqj6NcC747+X/WLSo0Yr5XWDfnq6q?=
 =?us-ascii?Q?RdpS3u/aurz8RLNAdcBetE35cOHQ1bq6DDodFynUkSyF/k38LVsD96f9TOS1?=
 =?us-ascii?Q?SwGOsn7AsB8Go1XsUbaneU0zBc4FTp1oKJ1LP6faB97U8dgAiVWrdm9hiG8Y?=
 =?us-ascii?Q?N8iY61c5EVaRNJsu3qW8kNpcvKi2P9ixS5KN4031L4C6cV+9UjUPxBiE+HTI?=
 =?us-ascii?Q?zUmqv8aKxmCFHOeQpmraBUCPxxq6SBoXX6wPGyj3g66s2jpy68UXOvH+/SHZ?=
 =?us-ascii?Q?ySh0lG/86HKfcPs8nNY0kb74o05DCJGhHo/g87UNFGCCNkRvkctN8dcAizMf?=
 =?us-ascii?Q?e0yyNDWGMQoCAGeSeJnBcyTHUmBT9pYbXMmVZyhFe/RhCHBvDJkFqYp2i8+w?=
 =?us-ascii?Q?mTf95mepRCHPwPqfltrAjSwWtCLlye3JhkXp/5skYR+5jqMymHBJPdRIJFln?=
 =?us-ascii?Q?4i/6PZW8sBtvg5UB7PyGoUb7g/Us2G0ijyHhAhZC/EW/2ksKrXHJ2W7iWKHP?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea48b06-aa34-4c99-fa0d-08dba97afd04
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 17:03:10.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZsSKdeVbUJ6FWKCSvAQIoWTBAwI8i7duuRxOkq0pwQbB1po6BIgiqIvb3qjJ/ZocBcMG26o65Z/w0+r9mfAvn3nxL6y95fxWK3Xsb12HIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 05:17:03PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix a use-after-free error that is possible if the xsk_diag interface
> is used at the same time as the socket is being closed. In the early

I thought our understanding is: socket is alive, we use diag interface
against it but netdev that we bound socket to is being torn down.

since xs->dev was freed but not NULLed, xsk_diag_put_info() uses this ptr
to retrieve ifindex.

> days of AF_XDP, the way we tested that a socket was not bound or being
> closed was to simply check if the netdevice pointer in the xsk socket
> structure was NULL. Later, a better system was introduced by having an
> explicit state variable in the xsk socket struct. For example, the
> state of a socket that is going down is XSK_UNBOUND.
> 
> The commit in the Fixes tag below deleted the old way of signalling
> that a socket is going down, setting dev to NULL. This in the belief
> that all code using the old way had been exterminated. That was
> unfortunately not true as the xsk diagnostics code was still using the
> old way and thus does not work as intended when a socket is going
> down. Fix this by introducing a test against the state variable. If

Again, I believe it was not the socket going down but rather the netdev?

> the socket is going down, simply abort the diagnostic's netlink
> operation.
> 
> Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")
> Reported-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com

Nit: I see syzbot wanted you to include:
Reported-and-tested-by: syzbot+822d13...@syzkaller.appspotmail.com

> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  net/xdp/xsk_diag.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> index c014217f5fa7..da3100bfa1c5 100644
> --- a/net/xdp/xsk_diag.c
> +++ b/net/xdp/xsk_diag.c
> @@ -111,6 +111,9 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
>  	sock_diag_save_cookie(sk, msg->xdiag_cookie);
>  
>  	mutex_lock(&xs->mutex);
> +	if (xs->state == XSK_UNBOUND)
> +		goto out_nlmsg_trim;

With the above I feel like we can get rid of xs->dev test in
xsk_diag_put_info(), no?

> +
>  	if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
>  		goto out_nlmsg_trim;
>  
> 
> base-commit: 35d2b7ffffc1d9b3dc6c761010aa3338da49165b
> -- 
> 2.42.0
> 

