Return-Path: <bpf+bounces-10053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 404367A0AF8
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913B6B20DB3
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829B2137E;
	Thu, 14 Sep 2023 16:38:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9485C8F3
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:38:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CD81FD7;
	Thu, 14 Sep 2023 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694709517; x=1726245517;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q13P+TwoQ9X/6o3EuzVHfBxN3lzJcsdYr0ovW7FuUuA=;
  b=I/xaKb8KQIdFgmHq43AfJwPAewxHrj10AQZ9lW86GiV+4PKMSrLkHjBO
   LRq/waB9OFh4wqcWzxPgG2beCCNm5n6Q+wxQ32LxBmcqU/Puk37YTw55Y
   bqAiieJtF33bC03ZtW/z7Mv+I7k6dyq0MX4oZgTL+cOqdezkGAzeKwREV
   HLGjpm7W0a/l12z0v9juPK27YRSoHoq2mFiF5cAmXUI4986KxGBzhJF6u
   C9NE2GMoEBB1nVw99p/cPUOWzgXM5uEVFNyJW7zPnJha8Oejs5PoIsrbj
   H8ocOYF1VU1r6M/HJu96c0c7TUHDflgjfKIEU+QeX6GgVECSdbadD4hih
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="445446693"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="445446693"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:38:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="779724132"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="779724132"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:38:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:38:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:38:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:38:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVUIn/4HMizqdzcHNLfavGuMIUoeL1MOZM0OhmQyT9TWJA6cN3oM79q0rdgCV8e1UO88h5TV+QAc6fhKBktlti3iho6nwDlCOW26DqxZZqOszkwNue3BT4FWvPC+79YkzHGL0ikXaBNJH+u8bwX2GjSayrRFOxZv97OK+2GBiFlnCpwad0/m0iSp6vW7ozGJkbfE1CweOpaNuQnArpTh/OPkIFgH/FFA7btYa7eTpPZz5HZfc2ACA9c7Rvrug1XTNGWKO63Bg6EMA0vsixVvcWEmiT59gcVK6DepbWqcJDR7cYLDHDVM3vq/0jvwkJNIrdbYh7XlO6rUnETUgV8hFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhAC9/KauI/tFv2sZC2i2ZuBgaysy760qbT03bxVUGg=;
 b=JnwCdo5ZxojvROtJYhPvvVwzLrT4usSqUMHAc/s6RX+83AVOS3rf1361Lyta6wR1EhG4KoMnyo2E8JD0D0QaLa2weXh5Iy6+s2dbGvlDQFI8JZbb69yhvWjIJ56Swe060UzeOOk+SfCIF+zjfqJsXJ+au6vp22Pb+2WHdRORCNaY/jQKDZInLCMMC9r3tORwePNMs/7N3/z482PsKIWZuf6DA0BLhSZ5EB3/N4HaVYHrVvtGzShIttrRG3jUG29S4+DmWfpxq1+SNK5XWWh+1O07qoWsDpCqPm7xPvCACu/PSB4HBnqUSkpwR5i1KENNFQhphP9bjeOjgDVGEU1/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB6940.namprd11.prod.outlook.com (2603:10b6:930:58::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Thu, 14 Sep 2023 16:38:27 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:38:27 +0000
Date: Thu, 14 Sep 2023 18:38:15 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Allow to use kfunc XDP hints and frags
 together
Message-ID: <ZQM293Gdx//GQPzA@boxer>
References: <20230914083716.57443-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914083716.57443-1-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 747b16b4-35eb-4781-9e2b-08dbb5410589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JqzavsxHsKbPkb6TKdCKgHDCgPiTkCiGGD4pJhnsITqc10R1F+OYooajYNbd+PH30OAchMoA2d+gkmwK64Df1hx+OO1gvpvB29KAA7t+zzPCqVJnmPwpwwGF+/60zlysyXFyDOLx26z8A5Iqsvc8hrC1SYQpseejLN2Ee6u0qD3L50quAGddvZU0Qxw4CowaB+FRLyB4u9vsrzXYr2zls2NaRm22uNktMuNt6cv5PWENRZ7q/ub5/W6he595RGbsKo908grkfT85gsyYKG74gondxsmLEZbymHe8gUpLtzJmShZ6+S1ffBEtOOJSKx5tyQq2qe83uYtymUu76hiPeocqWB4AoxHw5xfdhvWU86eJ1ftpKKJLZxUR+AciZj+o6y420Z0YwrsGfchR0yL1fL0y7T8ZuTvrRKbH06HiiR43CxhUr+dfPvnoVB0sO2mRrS+637TUFTrigLAUlO0anBQDZMt9U8v0zuT4SSAIc1SL5mxSAxwHDH0LTJ/h2YTqaPOA26bozcdjbNaUzVmj/8nta65/LuL3jAI2oB9kD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(376002)(366004)(39860400002)(136003)(186009)(451199024)(1800799009)(8936002)(4326008)(8676002)(6862004)(316002)(86362001)(41300700001)(33716001)(66476007)(66946007)(66556008)(5660300002)(6636002)(38100700002)(54906003)(44832011)(83380400001)(478600001)(26005)(966005)(2906002)(82960400001)(9686003)(6512007)(6666004)(7416002)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/sNFuEfNQn0pAPPqAsWbiArHweQ0jWTfA6FCw9NSigij3W+rvlpjxUkVFvs?=
 =?us-ascii?Q?b/qqEMHZEK3vYGEHk9ZUDctfp+npSx8R3cVVJGiNI74ACjnhXKfIfPafh1S5?=
 =?us-ascii?Q?d2s5ems7at9dX5NsJ1RUdzhUWeFnuuRY0W2NuB+SHrhdL7rj3+zxP7JRgYQ/?=
 =?us-ascii?Q?c7Qgoun0RsHq4T8RKNMZV+0n1eNNGsVg2h/aK+DqMVwYhq2hu2kCvpo9DJbK?=
 =?us-ascii?Q?RcbEconFmy+QFW/L1qHCwNRwRCJYVmSJqYhltS//RSZKNP81LKJi34XDtvaw?=
 =?us-ascii?Q?xVICUXa0fUEFhJoPWM7i7YVb2cLsl4kqTt8zwYIbPjj196ptcpthDrmHAggx?=
 =?us-ascii?Q?EklXW2myVIF0+ACtebMedAFLQQDNBAVNR+gZYYmjcgiZl/HwbnuQkEfaQ53o?=
 =?us-ascii?Q?yk2o4pjUKVm8xbWBzUG9WNwtZKv8G2NmHEQAvi5/vUwZZtDPky3Uv/hXYhFO?=
 =?us-ascii?Q?4RD5iVDJ9z8ZcuRkcdmYM3k2AUUikcDGduFxgnTwCJsly9ypzu6Ip9+w3+6j?=
 =?us-ascii?Q?bEewvRXleFCjESPS7Mah1CTFTciGNo7jzh++7JC41iMEJZDbbQ+K7NQ9XS3n?=
 =?us-ascii?Q?AkifQdTGxzDYr68NIbOOH01hQWvhIdeb+7kENrTG7WUnZzs2maWYRtROE1hN?=
 =?us-ascii?Q?/CZ9s1hssYQEIKpucUXi6cqy4MpkIlT0W7kw4x4255XovT/zsZ5olLga9gI9?=
 =?us-ascii?Q?FTuAg0gCIZWCCGI1WiDEvFcNitJhdld+ZAH4qPibea2IdO6uRH1BGlfeHPsW?=
 =?us-ascii?Q?951zaw7LczmUo58q9CQPQUD0XxKOHXs5miHLLd0cBLcYwKW9zLIysLvsvAGJ?=
 =?us-ascii?Q?CmXZh7PqIjpJ+1fJbuM7DfYBl2ryuX10+1DTgQTQXrAbeBT4Uv7wGoRMONFl?=
 =?us-ascii?Q?dINDOUbSkLie0sfpfglrDJY9A0b/9d455ueVwnX5y5HH8QLMtwZd7s0+dwVT?=
 =?us-ascii?Q?7qzcXb7ksKZANe61WV/wDtvIsVIpuYMWbwFdCrOaaitUuwGueWLpgEjgrMTb?=
 =?us-ascii?Q?aim40AYmTkpQr0oJIeX2w5iNl8xVvQ8MIn7GvQngurBQcA50caDMk6mF+vGn?=
 =?us-ascii?Q?cSbSsMmmuymw3pUI3rj1OVSJFcKJnM8Zw6BTrgzdkur6ywHeLkpREOlBAhr3?=
 =?us-ascii?Q?GaOoqWo1OyOp/25t+pfVVc/ZCS9x0ZR+UzSxJ28GHrVQM/YwMpbjnezJCyqd?=
 =?us-ascii?Q?/LI2JZNb2STasYlEIkiw5AwSXVcsYY3LaYNlBdKmS0xFV4yXriH+TFPuGUsO?=
 =?us-ascii?Q?8RUL5GDVeHuZZx8PFIOMRME3U9mlSEWCpB+sMiKuYiu7nRMN6i8pFW0bCysQ?=
 =?us-ascii?Q?Yy+P8KZXa+49Q5Nx+4UJ+k897X46mSrs8PF3MvN5H1DX7FvtYWcHc9aVEohi?=
 =?us-ascii?Q?KyAILtCYA1xsi2Uk14T/Zzr6VKGH7QgNfNBl+uBiMaKNVkVQwba5r5hB1ejh?=
 =?us-ascii?Q?Rn0eUEDS6T2IHumoxp8CP4yqIzuw6G4KIS/KeSbDn0pULdbIASQTdJJWQC3r?=
 =?us-ascii?Q?zd6UHmidaU7wUM+sXIXfBtoz1Rndtp15Gf4n1D5lq1s4BMTLpuHvViM5e8VC?=
 =?us-ascii?Q?pKjFu/naVJ7r0FqpW2tmCNQ5xzkc5bGT3uZoVK6aST1SYUpRRSncphyACuZh?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 747b16b4-35eb-4781-9e2b-08dbb5410589
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:38:27.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju9Fo7lQ7QYhHaUs8kW91oWibJ3tt08wtxnotREOHBUg921Yi450CDPgnWohnPiokwLAXn/cf44DEC2+q8yQ+8QgoJRylHavxwr3zrFpBc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6940
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 10:37:11AM +0200, Larysa Zaremba wrote:
> There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
> cannot coexist in a single program.
> 
> Allow those features to be used together by modifying the flags conditions.
> 
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Link: https://lore.kernel.org/bpf/CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com/
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Though it would be worth spelling out something in the commit msg about
additional check you're adding (frags flag can't go without dev bound)

> ---
>  kernel/bpf/offload.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index ee35f33a96d1..43aded96c79b 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -232,7 +232,11 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
>  	    attr->prog_type != BPF_PROG_TYPE_XDP)
>  		return -EINVAL;
>  
> -	if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> +	if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS_FRAGS))
> +		return -EINVAL;
> +
> +	if (attr->prog_flags & BPF_F_XDP_HAS_FRAGS &&
> +	    !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY))
>  		return -EINVAL;
>  
>  	if (attr->prog_type == BPF_PROG_TYPE_SCHED_CLS &&
> -- 
> 2.41.0
> 
> 

