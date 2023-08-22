Return-Path: <bpf+bounces-8236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1D784138
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756ED280D91
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9E71C2B6;
	Tue, 22 Aug 2023 12:51:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897A7F;
	Tue, 22 Aug 2023 12:51:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6374F196;
	Tue, 22 Aug 2023 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692708664; x=1724244664;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KDbuDVPPpvixDJVjm7Ea/lx4yNXO5RTP4UX9Lymkqso=;
  b=NTbbkLul/Zmi8OU+rSOLmHujjEiVMj+4rNMpwA9/PZHiOTviomTokG2a
   7no/oqq6LPNaPGLRM84bsi+6exUgj9Na3THtdRGNSzDTTci+C5Xd85C+m
   rTTfxVcFkRBtQN1vrkyIBM5wr48qLyuT1GrrBVDPqXfXUbPz8QLUPBmAS
   mwmgxnusaV7l8a9Q9EQuSy+9tHlMHqa0cljZ92p/bZ0oHR7CP41Z4vejM
   yd7xVwcUnpC75TYuQn6vRxsYChCVgukzs3n1s6U7AA98b3Iouv1ucXdmi
   t2hCD9Ve6rGjYGwvyKlINfCaWGZTKH3D3mXENN7mbqL1xaVOnA9LEtbjQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373850336"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="373850336"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 05:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="806278643"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="806278643"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 22 Aug 2023 05:51:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 05:51:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 05:51:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 05:51:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 05:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7Ic8zLpNf+qv/vhQCrCLSEzpHOYhNSyBi1aIWVB7WNJdHc04TYCLACy3NyFvOuMHzYBeMjyKIhlrF1YWYE2fq6sFXo2BZo89St5cS70RSqVDKD8E72aAfNpknvTvbCaSGyN3UuBCxRNuCwUJOmRHJlWVX+JD4Qcub1eFnQ8Pl5hEsLixucDBxdjdbooNyWkmlc4syd3YSpgV5pNbzhjX3GbEBw9SzMvD6VzIdjG2mgC4qQ/2UlvNglgXb5mmZICLsKc5xLySkAcstxWaLvW2bMxDijoqEVHH6E/y2suNY2JbIY7XU0csg4kxhjAVHYriqFnVP+Gfd3R5t6owBymsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaStr632cPl88PjXuX3l7gbWwbVdvTsKk00Js14NE50=;
 b=dADggzKSVGMgXdcrjStDb9CZlh6mkDmkrqq0R6iyVmZVt3vijusT+845on8xCCxIv5ldU6sUSrZxqA3AsxabWXCvDzbRiSp31ZdOTTZzFJJa5Ae/3aDViMC1Mp/6SlMUyu50fPfJ+GNWuIC/QmYtoQwnf3CGamutDlE0O1Cs2hnIyPN1K4YJ0ag25du9ERlcB/6/Dyg9MWpqirhutami05qzIkUJOUYbe6TR5nj6PGW9zVNOJIQhFHP1PFJv928YWZWqMUik9BxKOyQov5Fbo24iWYn/6VUe+fJR7KtqiymiWSPRYo0lo/X+zdrF7Ra7HKebm/oz384CGAiQvz/xvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Tue, 22 Aug 2023 12:50:59 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 12:50:59 +0000
Date: Tue, 22 Aug 2023 14:50:47 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 07/10] selftests/xsk: add option to run single
 test
Message-ID: <ZOSvJ7o9gmPhl6Mx@boxer>
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
 <20230809124343.12957-8-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809124343.12957-8-magnus.karlsson@gmail.com>
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db98afd-9151-49bd-30a6-08dba30e6f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bYVYKgow1bcJn+9EjRWM5rKeVFPHyybjjI7CPeFHTXJahj/vcGiyCW7UmxDmJrHPsaGeA0BVRMmbTuu5bHuIAYUYvs5NZGTxUCEDgpk2tEOjaeUoDdECSonS1tjYPtbaf77xo5sVGuPShF4e4frClGYuDoZrfYWRmawyQp8FilXmQI1WuPbT6S3/tOV7TbK/GgpOtuVUhxuioUSuvoa0oYsNaRNfQIQhe6ibb4meyH/rAQKw5aKIteXoGnBnVSgUYc7hzJrWVP/HlPlhHir6GR2N6H6cR+UsvE4lxM2Cv5cNJMqAqjQq2nuUUMccNODGpfbTLFb9nvKhR/ICbWYhMZcw5hGvO6+Vh3tHJH5RK6aVes51lIoEQHtCKWFKNDtn/IaoP2MAiHvdKiG+vSIgYfqMX/Z4C/tB5bnezBPWOvunytnV2J7dQ5al06R3Hreczu43RYxRakM6iF83DbC7KMg7+jAZYA8c3Q0x1emGsa6lhGe+DassQwVXlXGJf89lvj4NaFoUthraXv++jmi40KZmlN2K1WDwfVeJdBohEH03VcK3hJ4FAP9INcpqCGHw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(316002)(9686003)(66946007)(6512007)(82960400001)(8676002)(8936002)(4326008)(33716001)(41300700001)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(2906002)(7416002)(86362001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLWNPXEXOPbK7eD2GerWxD0OiiUwOD/SC5CYeDZCJ/3y8BI/+GH85xfR9rnn?=
 =?us-ascii?Q?3Z666JQP8y12b6ldu565v8wnIClkkyU+j9vz3D6CNa2rP7pGlkBYNM/wnI4P?=
 =?us-ascii?Q?M2PMM0FrSn83Eqib/BA1ik0h994uOcm7yW/WTIg6N65RCB2rrFgpb/zq1sV+?=
 =?us-ascii?Q?iE1izJkUDy14Q08Dlsa8baC2pPQEvv8XpnbUZiyYXzIuFhrxNyVh31eKEbwM?=
 =?us-ascii?Q?wruMzHoc3w+V/IxQjNDik/NRfATjluqmyFsAhPBWaSbDd4sHMSzGOXNwUhts?=
 =?us-ascii?Q?H7vctnOJFoRGa7ycESilBXgFnx1RHtpLf3ja21i8rA/zv7SEwaD3vp0qt+WE?=
 =?us-ascii?Q?eLWx+W1SCQz9KIj+IO5whi+87qx6+QMOz2IH3yl4lwgJdNKVLJeXAu4LT9hx?=
 =?us-ascii?Q?UV9P/GsmGC51tsijzgT4TwDZfo//ppT8PVzAu6GzHovHiq0ehrd5qwRccilq?=
 =?us-ascii?Q?fmiT3GPfqqeBv5kFsvNk1zOgiJOiOFMy5NncLv0KcFjBFrApnsU5sPq3Vyvr?=
 =?us-ascii?Q?fTlWATHf/dWiPVwq5e6U8et08PXE3W+FievIkhBGHiDFOSVFHC8yxpb4CBQX?=
 =?us-ascii?Q?vMcpRoKkYARUOChFQ4yvBntSYtfh8Rs7cQVym/effYJPIZ2ucVOzOmyRFLau?=
 =?us-ascii?Q?+7ORknvLfnwGmIZ0X3aH9KPSjumruAZPzpQnFvSjDIQDpzf7NIfMMUkLsNll?=
 =?us-ascii?Q?xH0nVUZfLdlyGgblTv2qPjwMmvucM4x1OaH8c3saLt0fFSJd1kl8QCt++lDP?=
 =?us-ascii?Q?UBl3zOFG4g+LiUkie9JtDb1JbjyV5O0qfb6xEV3XaLwJC2CSg0LG8k9Kc7tf?=
 =?us-ascii?Q?Dz7Io50sPvglmmIRZdnDVAyeCJxs552aoc29COjWJrkmmFAdFp/3rd512mAy?=
 =?us-ascii?Q?xHLnj1KfNn9nFnmpWyIM5w7s1yGUByxJqeV/+Em3RJ2pdt/98rGeUb9rncAp?=
 =?us-ascii?Q?xxL/qQUFui79L7ZlYI+ajl/vUBcSkPScIGCpdao0f+xkvz3LaQ94BP/9MPnq?=
 =?us-ascii?Q?9rCDbPW3lbcfmlXDwrOrZ7j7pWSGUQz3w2gReIjhy3+zON/ZTCjcMGs2ASdW?=
 =?us-ascii?Q?bdxst2T+KyoF/YSkV/CjEuakVWdeOBZsP5h0yuOkeG1uJ5JtafbXdfLFBsv9?=
 =?us-ascii?Q?5Rt8O9rS79W09Ku5T9vGpbHeN3wNDb488b+2yynRGLH2LVTwZ49SHJapf3hM?=
 =?us-ascii?Q?ce1l1RfIxwMWZ9zykfDlmpVP/g0HXfh9pDxKdCuPnIwxnkE38zzUV9f+D4Tk?=
 =?us-ascii?Q?Qjd+SyUpjnOyBmecdAh2t7twHDCDajclLU9jxBnjVF8WA/Fqa27xSR/UMw4O?=
 =?us-ascii?Q?Rb6VUwvlJF3h1nR8XHzxE7Gr1rTPHrGQMqTEzbBHfTRAIzvBdK4fWZ14xB2J?=
 =?us-ascii?Q?wjV9ykfLX67/5whrEYFBDKBxJsL23FAz8MAMIEnlYe3ix4BnhlA8IHQYgtMW?=
 =?us-ascii?Q?QHoWMIONGuw7P7V26QI6MM4wp72+TeFU30fYt9ulPlanIiIMHsPZOXP+GZnP?=
 =?us-ascii?Q?vJ/yPtEJVLnHfUcd1ewx7Jz2dv70rQxGcilP4bWdgpwpBx1lMBKcHPI18TQt?=
 =?us-ascii?Q?0UnQzL3F/NDVFGrHNlqkAPRrnEUHuSiPq5TAi6Kj4fDVh9iUCKxbYHqhNRpW?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db98afd-9151-49bd-30a6-08dba30e6f3e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 12:50:59.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NeN62xMdcRHhpnn/wfqWh/QO3SPdikSWb/pa1dnlSpaFBHzVxqesGp+uMzBYmuJpNlh2dGMJMFbaTpzW2MWY7OQIlaUA+W32D0gKhS8OoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 02:43:40PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add a command line option to be able to run a single test. This option
> (-t) takes a number from the list of tests available with the "-l"
> option. Here are two examples:
> 
> Run test number 2, the "receive single packet" test in all available modes:
> 
> ./test_xsk.sh -t 2
> 
> Run test number 21, the metadata copy test in zero-copy mode only
> 
> ./test_xsh.sh -t 21 -m zc

for above you have to provide -i $IFACE as well

> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/testing/selftests/bpf/test_xsk.sh  | 10 ++++++-
>  tools/testing/selftests/bpf/xskxceiver.c | 38 +++++++++++++++++++-----
>  tools/testing/selftests/bpf/xskxceiver.h |  3 ++
>  3 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> index 00a504f0929a..94b4b86d5239 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/bpf/test_xsk.sh
> @@ -76,12 +76,15 @@
>  #
>  # Run test suite in a specific mode only [skb,drv,zc]
>  #   sudo ./test_xsk.sh -m MODE
> +#
> +# Run a specific test from the test suite
> +#   sudo ./test_xsk.sh -t TEST_NAME
>  
>  . xsk_prereqs.sh
>  
>  ETH=""
>  
> -while getopts "vi:dm:l" flag
> +while getopts "vi:dm:lt:" flag
>  do
>  	case "${flag}" in
>  		v) verbose=1;;
> @@ -89,6 +92,7 @@ do
>  		i) ETH=${OPTARG};;
>  		m) MODE=${OPTARG};;
>  		l) list=1;;
> +		t) TEST=${OPTARG};;
>  	esac
>  done
>  
> @@ -166,6 +170,10 @@ if [ ! -z $MODE ]; then
>  	ARGS+="-m ${MODE} "
>  fi
>  
> +if [ ! -z $TEST ]; then
> +	ARGS+="-t ${TEST} "
> +fi
> +
>  retval=$?
>  test_status $retval "${TEST_NAME}"
>  
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index a063b9af7fff..38ec66292e03 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -110,6 +110,7 @@ static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
>  static bool opt_verbose;
>  static bool opt_print_tests;
>  static enum test_mode opt_mode = TEST_MODE_ALL;
> +static u32 opt_run_test = RUN_ALL_TESTS;
>  
>  static void __exit_with_error(int error, const char *file, const char *func, int line)
>  {
> @@ -316,6 +317,7 @@ static struct option long_options[] = {
>  	{"verbose", no_argument, 0, 'v'},
>  	{"mode", required_argument, 0, 'm'},
>  	{"list", no_argument, 0, 'l'},
> +	{"test", required_argument, 0, 'y'},
>  	{0, 0, 0, 0}
>  };
>  
> @@ -328,7 +330,8 @@ static void usage(const char *prog)
>  		"  -v, --verbose        Verbose output\n"
>  		"  -b, --busy-poll      Enable busy poll\n"
>  		"  -m, --mode           Run only mode skb, drv, or zc\n"
> -		"  -l, --list           List all available tests\n";
> +		"  -l, --list           List all available tests\n"
> +		"  -t, --test           Run a specific test. Enter number from -l option\n";
>  
>  	ksft_print_msg(str, prog);
>  }
> @@ -350,7 +353,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  	opterr = 0;
>  
>  	for (;;) {
> -		c = getopt_long(argc, argv, "i:vbm:l", long_options, &option_index);
> +		c = getopt_long(argc, argv, "i:vbm:lt:", long_options, &option_index);
>  		if (c == -1)
>  			break;
>  
> @@ -397,6 +400,9 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  		case 'l':
>  			opt_print_tests = true;
>  			break;
> +		case 't':
> +			opt_run_test = atol(optarg);

how are you protecting against something like:

sudo ./test_xsk.sh -t asdasd -m zc -i enp24s0f1np1

?

> +			break;
>  		default:
>  			usage(basename(argv[0]));
>  			ksft_exit_xfail();
> @@ -2330,8 +2336,8 @@ int main(int argc, char **argv)
>  	struct pkt_stream *rx_pkt_stream_default;
>  	struct pkt_stream *tx_pkt_stream_default;
>  	struct ifobject *ifobj_tx, *ifobj_rx;
> +	u32 i, j, failed_tests = 0, nb_tests;
>  	int modes = TEST_MODE_SKB + 1;
> -	u32 i, j, failed_tests = 0;
>  	struct test_spec test;
>  	bool shared_netdev;
>  
> @@ -2353,6 +2359,10 @@ int main(int argc, char **argv)
>  		print_tests();
>  		ksft_exit_xpass();
>  	}
> +	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= ARRAY_SIZE(tests)) {
> +		ksft_print_msg("Error: test %u does not exist.\n", opt_run_test);
> +		ksft_exit_xfail();
> +	}
>  
>  	shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
>  	ifobj_tx->shared_umem = shared_netdev;
> @@ -2380,19 +2390,31 @@ int main(int argc, char **argv)
>  	test.tx_pkt_stream_default = tx_pkt_stream_default;
>  	test.rx_pkt_stream_default = rx_pkt_stream_default;
>  
> +	if (opt_run_test == RUN_ALL_TESTS)
> +		nb_tests = ARRAY_SIZE(tests);
> +	else
> +		nb_tests = 1;
>  	if (opt_mode == TEST_MODE_ALL)
> -		ksft_set_plan(modes * ARRAY_SIZE(tests));
> +		ksft_set_plan(modes * nb_tests);
>  	else
> -		ksft_set_plan(ARRAY_SIZE(tests));
> +		ksft_set_plan(nb_tests);
>  
>  	for (i = 0; i < modes; i++) {
>  		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
>  			continue;
>  
> -		for (j = 0; j < ARRAY_SIZE(tests); j++) {
> -			test_spec_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
> +		if (opt_run_test == RUN_ALL_TESTS) {
> +			for (j = 0; j < ARRAY_SIZE(tests); j++) {
> +				test_spec_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
> +				run_pkt_test(&test);
> +				usleep(USLEEP_MAX);
> +
> +				if (test.fail)
> +					failed_tests++;
> +			}
> +		} else {
> +			test_spec_init(&test, ifobj_tx, ifobj_rx, i, &tests[opt_run_test]);
>  			run_pkt_test(&test);
> -			usleep(USLEEP_MAX);
>  
>  			if (test.fail)
>  				failed_tests++;
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index 3a71d490db3e..8015aeea839d 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -5,6 +5,8 @@
>  #ifndef XSKXCEIVER_H_
>  #define XSKXCEIVER_H_
>  
> +#include <limits.h>
> +
>  #include "xsk_xdp_progs.skel.h"
>  
>  #ifndef SOL_XDP
> @@ -56,6 +58,7 @@
>  #define XSK_DESC__MAX_SKB_FRAGS 18
>  #define HUGEPAGE_SIZE (2 * 1024 * 1024)
>  #define PKT_DUMP_NB_TO_PRINT 16
> +#define RUN_ALL_TESTS UINT_MAX
>  
>  #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
>  
> -- 
> 2.34.1
> 

