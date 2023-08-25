Return-Path: <bpf+bounces-8571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E777887C8
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7761C20F25
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120DDD301;
	Fri, 25 Aug 2023 12:50:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A15C8D9;
	Fri, 25 Aug 2023 12:50:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1101BF0;
	Fri, 25 Aug 2023 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692967825; x=1724503825;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nfLilKR2AbCg4/KWie3jmCjAFwS40+OtZQFrShRmJkE=;
  b=ewJU0R7MgzRk4nOu1udVN0Hc+FUdfDyqn3RK0T9IIKKZlCMo9RbI0OTk
   WZ1E401moauZUAWNk/HU3Zap7wkeEVMG0KOU6s+TiZWSGkOPoNZ5xo5qv
   BPx7CJCiPJd4RqfsA9d8PRQeRHhpkC/DnqeuAZrrR2I0LamPIHbD/Jyby
   jJXehyw8OE+CZdqVyt1A8rVJHy8AlUJq+Ee3g904P8g7Jjhh5EoWvyXy+
   DFHrsmmH1D4xezkqMtErIR1t4JtGpc/rNAfsnvUHCpYewlB6EykhA0bui
   JwbBEPaV6bm7bp+wZBYgmaMZWvgfHcaEdqRcPz36sq12kin4XvTvCsICB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="378489190"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="378489190"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 05:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="766946561"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="766946561"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2023 05:49:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 05:49:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 05:49:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 05:49:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7plXgtcPr3uBFOZ7Z7kREpxzGeRIjBEsFvdY95O9TnL1Iwai7EejGHYHYnbuAWwUOOzULwkNvazQInM0u04Lrjf6BarPNzM4SbQpJFP8OAq99nS8MGZxndUT6q0gUotEuuJuql727KhsTEYpC5NoEBT3crJDPFCdSgwH4S6j/ElEU4dsKuTh1pDpYBwxhJSlv03ZgwldAtrBMzjJRbxzq04KREd6mOG7Zmq2fHJ7zHKeL/3aD0dALkEUTTd91UXiGRQy8+Jp4TwW4TvkAmuqvFCfv7u8iTc2uyi1+EVujEnhsLu8/e3my9KhVaS/yHtENcHzFUOhZljASM4/4xG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir829sXxhzm4Yv0a75zR+YZjeAlXloZxHtPIkpC0Ac4=;
 b=E4EfU5OiB5WFBe51cYrWBoxKY2dubonBg8gWE2UxgvLviLQivJRJn+MgJNBExCmpxVlRxsI4SyJ81/ithUE4PF95CkyYCz1NDGBaCcqMeGdWWCvUo+VR3/p8xtv9gMOZDAaZnPtSEpw4BF9MvEvSFt6NewH2WylRH39pb0pTDaPHkVq+8iAT/bTEBv4cx0IzWhtO3OVDg/w2sLsYOtvtzRUwKh1SGztGzY5B53CfZGDU0/iTZpkogMEs+KMz97bBBk7TqZPBwqOGJgoOcrtrushgFsQ8exHUlz6CS5AicBrwSk2FavfkADWOchj6HpoOOeXc8IHUh7R9hQcLinRUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 12:49:41 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 12:49:41 +0000
Date: Fri, 25 Aug 2023 14:49:34 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v2 10/11] selftests/xsk: display command line
 options with -h
Message-ID: <ZOijXlBwnLxxyfFt@boxer>
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-11-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824122853.3494-11-magnus.karlsson@gmail.com>
X-ClientProxiedBy: DUZP191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 176f3d12-ccef-410d-e72d-08dba569bfdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWQeboXiiKoeual/BZYOKEJYn3q43Zxmshu1z4vk3NRj4fHynpChxth/tB4iZ4cyIYxgBciZQTmvepT1x6Z2Fb8LtGWY1HXfrRe+SEJ0zRCGf74RKhfZuCsD1cZfNouIcwY1KLxWD73eg9s5fdgcQCOaQ3EDG0k/XYfy8WHYwOEJbTdQ9j89LxO2/NKa95WRbAiCCwqCclMJ6WHgTlQY/FSguCxzRzu/VahTr+gqHkR6LDd6Ipbye/8TqacTN1bIavRWbYFmj3TUjn07ww+JV8Gzzlr5HCA/p5PUCjzPwii+3BYZZdeYb/6KEq2DtXB8v2/MbFp7Jm1iWWE3wPUtGI3pmo60bn1am/0dQGYjaQIXqQnRlxRp6qGLbUJmHX0FqQLSu8A5zPXTovc02LOfNlovGrV96/5awb83kxIOJeGRKzYgUCFnITR4WD7ab5XOQydSCY4NVE2pgZSkXmV8XH/x9tJCEY108lzyq4JX8A3xM2HSt2/C+Cxlq4FkJ6n5Y03VHteafmryN/Fkn7kvsuSX/FP3fwvO0Kuefbk52n7eA0dLxp12Ljzd9OIbYhCP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(82960400001)(38100700002)(8676002)(4326008)(8936002)(33716001)(41300700001)(6506007)(6486002)(316002)(6666004)(66946007)(6916009)(66476007)(66556008)(86362001)(6512007)(9686003)(26005)(478600001)(44832011)(83380400001)(7416002)(2906002)(107886003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOfN/sXBQ+fQhyP9qPCH1hfDgtpB6Kj/1P4IdGVcdS/yM2e8ba+i5GPeIFDe?=
 =?us-ascii?Q?usgrJcp9NwSzS77RajyyG9K8I/9kU7fDqPlrHjbjKqDDogaeUFscMRSzLKmB?=
 =?us-ascii?Q?LrvCGIt3YTIONQt1pxWXllXVXDuPeGPFPu7//9L4CNDexhwUW3ValH5oIFpa?=
 =?us-ascii?Q?ms5NrODNjsMkzHPVjitd+nljplf5su47IrPa3JION0epTiC80Ninrv1jpL6b?=
 =?us-ascii?Q?mTHqcy65T4U4B2Td+kmXncC+RUbgvmkTmMShJFO6FYlx53gFYM/Vt/sfssji?=
 =?us-ascii?Q?Hi19iOuuFTglVC+EADLEdR0DjoEeQNwo7SAHm8WIMOi/rdmh0mUbCOZVxpVY?=
 =?us-ascii?Q?etftcgKB6glPbQ2cSCYIh+XTRxVTMHxlCF8dPK3E3NATRQwH8ulH2M7DiAyN?=
 =?us-ascii?Q?l/rLyDtdFg0dvRgiiGUHdxjzpzVgb0U/1fOl76wnPDhj9UMkK9dAUZX5dEf6?=
 =?us-ascii?Q?oXkz7fc5YPxTWC3A9XsakG3BcXvnRDJVe5mY9eeMn3MgneC6PYMq3ItUV2wb?=
 =?us-ascii?Q?NzCTbj84f92cYr6Kgt2S0DJ1TYfLYE8U0nTMaFQcyCJ1iwHGiTBgar0JULsf?=
 =?us-ascii?Q?gDsSTfH2M+b34dOgVuxgQ19+uYaTdkhYLN0y6aAhYRTVeHE7SS33vPZJATnx?=
 =?us-ascii?Q?c36jRUAAmCoPWVw/1hAZm/axr/BocliZI4TkVJUUN6aeDyGE1qWBw6nQviPm?=
 =?us-ascii?Q?xrV5+26dwnvhEnlLLX8nwoQzupNk/rY+MrX1YUA2KE04zPZDA/aG20shGf5a?=
 =?us-ascii?Q?Q6qlALVLP+GBztojEId3tWN8aIgeAzhwAfGsR8AdjRq4Z+Zrsvtvs/689TzY?=
 =?us-ascii?Q?ThhS9+AH2g1QONTzvQJuVDXpdUuS7mEzbkY8cAB+jowqkv/ejsZJD1/Lhzxi?=
 =?us-ascii?Q?tVdQPVIbmMIDZCBF3PdyeTSBZ7c3QykwazQ5PB9mJdeeufzixLNoLia/IFSL?=
 =?us-ascii?Q?qnNriESde23d5Ak4SQETk6efyBqlY4axLoJ6Q3NbCsqwb29cqbn+6GVh+KPj?=
 =?us-ascii?Q?kOeJnOPO5sX+Ss0JKVzArJ+bEMXtaC6vn784kILAyTe4ofbPfbRqNfdZqclK?=
 =?us-ascii?Q?uqiNy+Q+gWjX5zIHUuuYakUBj2lENdRoL5BYmOADOL/1nxnkRJltw6219bz8?=
 =?us-ascii?Q?oO9qeJdLapXoWffDnax0fWRNwxoBF/+Nh0juLUTEUV9/hR3CNYFlnSdIZu7y?=
 =?us-ascii?Q?IqfIMXGJoTMLsT2DgtzbMhcUIaPKR7rZ78OMfYVXPY6wjTwuHf6khdaagP3X?=
 =?us-ascii?Q?BHuPGLSgMw1bEXPrsyHXgh+qOAklhpxj9Y/hijhvMBkTlnKX3CLNDsthVlcR?=
 =?us-ascii?Q?m9OLka8VpDeBXn/xqoIjs9ze3/Wec88jvJKRQJSypXavq9oxQC5QclFpbT+z?=
 =?us-ascii?Q?VB2tRqwjXh33XrRZROduyz6Z9FgPvOapwzl6VFyJ47yVH/FdRM7NQ5Wano8Z?=
 =?us-ascii?Q?SbYClXjz5bABs582K2xZKZFxlT6kdK3ffY2mBXM7528crGR7XdRStsdfgDDL?=
 =?us-ascii?Q?tY5VoJaeGCQon1SJJIDXzM+qAPdZSfagSFK4hmLQE/fjCgpp20NEKj77W0Hj?=
 =?us-ascii?Q?rllBlaeE1CG9bSq4YSWp7RYQ+pigNQGrSkpDIauw4C0GZwSg2Aqu2EEQbwbX?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 176f3d12-ccef-410d-e72d-08dba569bfdf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 12:49:41.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6xCdzBs8S8MLDqY8u6BnytEe48e3jh683khvi/48n/dmG5vJZ6uB6ipmjp15r4zITcY9Jfkuq4MrKOWN5ApkUxnwGmgnoYyH5/2Iow8+NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4798
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 02:28:52PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add the -h option to display all available command line options
> available for test_xsk.sh and xskxceiver.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/testing/selftests/bpf/test_xsk.sh  | 11 ++++++++++-
>  tools/testing/selftests/bpf/xskxceiver.c |  5 ++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> index b7186ae48497..9ec718043c1a 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/bpf/test_xsk.sh
> @@ -82,12 +82,15 @@
>  #
>  # Run a specific test from the test suite
>  #   sudo ./test_xsk.sh -t TEST_NAME
> +#
> +# Display the available command line options
> +#   ./test_xsk.sh -h
>  
>  . xsk_prereqs.sh
>  
>  ETH=""
>  
> -while getopts "vi:dm:lt:" flag
> +while getopts "vi:dm:lt:h" flag
>  do
>  	case "${flag}" in
>  		v) verbose=1;;
> @@ -96,6 +99,7 @@ do
>  		m) XSKTEST_MODE=${OPTARG};;
>  		l) list=1;;
>  		t) XSKTEST_TEST=${OPTARG};;
> +		h) help=1;;
>  	esac
>  done
>  
> @@ -148,6 +152,11 @@ if [[ $list -eq 1 ]]; then
>          exit
>  fi
>  
> +if [[ $help -eq 1 ]]; then
> +	./${XSKOBJ}
> +        exit
> +fi
> +
>  if [ ! -z $ETH ]; then
>  	VETH0=${ETH}
>  	VETH1=${ETH}
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 19db9a827c30..9feb476d647f 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -318,6 +318,7 @@ static struct option long_options[] = {
>  	{"mode", required_argument, 0, 'm'},
>  	{"list", no_argument, 0, 'l'},
>  	{"test", required_argument, 0, 't'},
> +	{"help", no_argument, 0, 'h'},
>  	{0, 0, 0, 0}
>  };
>  
> @@ -331,7 +332,8 @@ static void print_usage(char **argv)
>  		"  -b, --busy-poll      Enable busy poll\n"
>  		"  -m, --mode           Run only mode skb, drv, or zc\n"
>  		"  -l, --list           List all available tests\n"
> -		"  -t, --test           Run a specific test. Enter number from -l option.\n";
> +		"  -t, --test           Run a specific test. Enter number from -l option.\n"
> +		"  -h, --help           Display this help and exit\n";
>  
>  	ksft_print_msg(str, basename(argv[0]));
>  	ksft_exit_xfail();
> @@ -406,6 +408,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  			if (errno)
>  				print_usage(argv);
>  			break;
> +		case 'h':

do you need 'fallthrough' here?

>  		default:
>  			print_usage(argv);
>  		}
> -- 
> 2.34.1
> 

