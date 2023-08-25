Return-Path: <bpf+bounces-8569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0167887BC
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4F21C20FBB
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2334D2EF;
	Fri, 25 Aug 2023 12:45:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E70C8E4;
	Fri, 25 Aug 2023 12:45:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D57D3;
	Fri, 25 Aug 2023 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692967503; x=1724503503;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tmzKeYfqXHKMJPMfNNW8RmeAjQCk2f8ZDl59jqCTrWE=;
  b=ZFgfqE4yrw+XAqTiz8Kn8FSwZ8A8Bh/n7IQmETxzXgZEW8CwjW011JJb
   4dcR2OgBQLHZBe7nzNW/V6ejur71bOR8RwYSHQDelo8Ln7UEcwP4Arjxu
   Eyp4YfqAFRnvONvlhr9UlHQSYaI1ueAedpoyvxgCKODc0ntP4ee3LYxgS
   33zsZY2yLSzwknBH3bDb6SYsIycPYEtXjUKF22YVjSels5D+txiG1N6Zt
   UW4gkJrF/ic0pXPDGVnZnU/0z2xiZkAlPO1bSSgvj6bdSoYU6iEi0fSLh
   dqaqzs+qBPC5pzVH00rjOlJoViDXXXipcJYUTjtWlqWzUJ5eWrKFhn/vB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="374679474"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374679474"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 05:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="807525383"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="807525383"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2023 05:45:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 05:45:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 05:45:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 05:45:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNqPA/+6BwWhqMqwU316xEDtUcvy9ivWtYsEBIEoJAu19lQ9cc4lbb1xcKHuYVtkvoGgcOYY+Wnb/ODQSvJ/x7ctuxSPEIYDCfqWb4rVUWqNH7mVRHb2j3+JuMhR6XRwiibSWb2eWxgImiao7uKVh71rgzVernoWCBlEeA5N+YrRStmW2fAKNja9W2SD/Pnj+EMESCvWadd1bX66k/bX7XoJWmHExOtQ9ydsMh12iV/yjdn+NWFdKPcqOL/054QgR5XX8+P6VKeoeU9HbeFyP2RTCPc9hlCcHoYNHt0AD9b66ZgjurdMx6bVt+vyw8EYKzep+JA5gNvxpRFe5wj+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMPbAXhBTevmsFmybuQzKYSy0MVhp+mrd95h326c67Y=;
 b=eMwmuGIqpOaH4yCvEDv3BujKzeCoge8Rtb6bozwCvSD/1SVPSDOrnGqO5x4wbMH7vkr0EtuFn1m+JlisP9sYqcKo0ijIpP9s1P5abEPF82+5ipzHwCYx0/MT3iCR3R8pgc3GOeKzckpfw+q8iIxUc7+uI4n43fVTUmgrptJwidDr5YIFzYbXVGVSlr65upCVaTE98eBmiA8VPQR8Y+TKUAdoJaumvo8KKg9LPOMQd4s9moWTv7lrF9DUAR42ECG5+b5xnQrLg7+MBT0MMscpEO/Si/55hJ1fCKl/frmeipohX+uQzwmMVAPVU+mbsZ0+OpJu+/t0npRbyAqvNGFlSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB6403.namprd11.prod.outlook.com (2603:10b6:510:1f9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Fri, 25 Aug 2023 12:44:59 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 12:44:59 +0000
Date: Fri, 25 Aug 2023 14:44:46 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v2 07/11] selftests/xsk: add option to run
 single test
Message-ID: <ZOiiPnQPSwZJZD8w@boxer>
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-8-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824122853.3494-8-magnus.karlsson@gmail.com>
X-ClientProxiedBy: DB8PR04CA0008.eurprd04.prod.outlook.com
 (2603:10a6:10:110::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ae119c-af84-4181-3b72-08dba569178f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuSnAgUM011n79eeTcIxKJ+iW6xLtxuX2CDHv37Je7eurOo3dOnoA+QD6WObxEjFb20Z51Y5roCHuZgogjhtiptMusrgo3KPNYCtxX5JHG2DDUDZzUJNJIr++0+toj4YIJ9Wp02vBNMb8yDIyKPUEnASlQtM9viQmLDPjL2qs1kwanUt0rCXWQ9pnxEjLNf68EesApw79wWRZDKQfLwvTIk+m4w+vzodSywvYbcTRafQs1iBlwMu2wUjjym7v6q+NtTLMKjFpxQRpEYB32KgHzAkQPSrdcEOGuMd+Nvwvr55Db4qgIXb0AJcrYbArwB/0+rIj21IZLpku18fEdMuhvs0ChfvOAhMuyWqKDrXsoqnjP6/ieBjMMB1mEFD298tLAxrOB+jgBLr9H2C1bv7qBkp2HrewteTjID9cQiQkiWLelG16Ika3SY68El5N3nKyacv1QItXfaJxkVBvWLGZmIlDga5uGliSbgE2DOtmjRHEMRlQsv8dTt/5rPPOz4dnJSXl+td5UoUNgvHD3NbC1Coaqf6CQ39j2ZIcepEI/fPs0polcDo7djRnr4Ya6uL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199024)(186009)(1800799009)(44832011)(82960400001)(38100700002)(6512007)(6666004)(41300700001)(9686003)(6486002)(86362001)(33716001)(6506007)(8936002)(8676002)(4326008)(6916009)(66476007)(316002)(66556008)(66946007)(5660300002)(107886003)(2906002)(7416002)(478600001)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I6ql4iWuI02tazOcjZwPG/j5fiJDEVG0txXd2PNwbjuZoESWzwC2qRLEAkSi?=
 =?us-ascii?Q?tmpz8DKqcEcldh8qo53RjPpQPu2uBOA9lkR4pJ/4QmtpQKUfbLeK24LlBkzs?=
 =?us-ascii?Q?OKPbCqMsGJdmSbN3AZOj5J1TeZdEJV6ijdbFMOmSzEBRWsFzJWlvmJ6OdXfY?=
 =?us-ascii?Q?R9gKNo+GHUKwxzhfXiqU+SMpLN7vQb9yp7im/QKVTBgkstVxzX2VNoUcWhj0?=
 =?us-ascii?Q?ibsgfHI5rS+4FPI2TCu9K7DMEjVyAYZwq7GETULQ7apocBnbE8dNobiGmxMc?=
 =?us-ascii?Q?6P8rSIBkU8Iax1ORPQm7OsaBYE+LM03b0JT4gEfmjBZtBJ39JSIoRG7ODz6u?=
 =?us-ascii?Q?FZSY1FG1SS4HFtpNaKnVmWrSIv8lsuylo6tOuGgSYfiC7SPM/21xui36yUrU?=
 =?us-ascii?Q?2/8QrkVPDVoEg0XwjaIjJgq78WT+Q1qTJzAtJ6kty7c7dbdv/Zj8jV7DNhBV?=
 =?us-ascii?Q?02MtHrv836ThX5EUe3DlMJPBhBrCME0GKMkgRzNgkyK6AEFtjHwjuRBK0XVM?=
 =?us-ascii?Q?/NB52zMYMEsG2SFmIUN6peGAhP1dx6UihjzdEgLRbJm5XNLLiSHCYP4X1pIz?=
 =?us-ascii?Q?v3pGlpQ7K1kvv2Nbxeuuoe8iEFDOLRs8K+5/q0egTNlUWpkvP9ba7wJVL0tK?=
 =?us-ascii?Q?1aad1hC8Zh+sKZC4ywtqruM6FbkQf9upi7gEaCquMbMvoE5SzOXVScExTnXh?=
 =?us-ascii?Q?x4mgaN604HslgkbJJ5UzlylmcaPWZYJVCJzPxaMjrnAQByX651JwkORnGzz0?=
 =?us-ascii?Q?zbd3cvVqvIazoxH2cKtDpT3XNVD5RkF9Ot1y+iW4TJrlAs6JszmOyWYLGyqa?=
 =?us-ascii?Q?QPGFHZ/gaHdwlMYeOCW+3iG2qm83QhjwKR1HqBxF6s3LbNF/YrVXEnnAAOeP?=
 =?us-ascii?Q?5T5FV3CZ+o7H/vuvdgojkYyjB1m6X6qR6OzPg2Sd1vBE+xUdaGhihp4o0sLp?=
 =?us-ascii?Q?rKXiwrLf8aWaYqfITyMQBU+4UrphLBfh/nghcN+8GON60n2OPpujbbIDIftI?=
 =?us-ascii?Q?Uj5biOnhGdYSYWu2zqzXpRB2TwK3dRjecLqwMW+5XNXzozwhMBcb9Ujbqm3D?=
 =?us-ascii?Q?R4CLQGEEDr/sXrm9q7TQ++pLjXbs8yLRgSpySVU8I+pnUElXiVf/7tLQIX5i?=
 =?us-ascii?Q?AlRL5tgTvhQ7O0wo1yCewwpVvCb0q+CPcpPGwRoPNScCJlsP51o5AoNwuf+q?=
 =?us-ascii?Q?ls0x9lZ5ZHpOhug5eQ+JwP1o2yOATwgYuZ4N3xJJgJCwsDb0xBqqeW88TcQ1?=
 =?us-ascii?Q?bLnYQie7Kg9vo1IUx9alazNaRyv10EFQMlQ/+3JbmaMVwQURqQlEkDHF63e1?=
 =?us-ascii?Q?5OoRvt0IqI7RUq2SvhnXfY5rLneksnzQ1DH6uF68d3fhtCnGFtqby+B4RuyW?=
 =?us-ascii?Q?exJ3D3s2mZot65ZN9Qc7H0tRWN7v2uwwSzh9961kF+sUIIxuQc4uGIvAIvFc?=
 =?us-ascii?Q?a5v/kzQBuGp/auo2bcM0k4ZucbWC7pAOSMdPrvHLCciJJ9VBbkUF06iTGOve?=
 =?us-ascii?Q?Eg7NSJMnKzMtE1eV9a1nOM4fySBPwqOUGVVcHcfyZ4yXabokYO/1QRn3foFn?=
 =?us-ascii?Q?tD3d11uba31uGZ0HI5C+OXx6T7/ORbjRKRPa1vEKJrzi0ZlddEIu3dV07g9r?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ae119c-af84-4181-3b72-08dba569178f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 12:44:59.0178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV3qZ4uSfnb/+vAs9pNlVmngg0+2gPKpwWceZiT9C+RLYks4qgWZM4VLPocrR+CHs6tDJGqldLLGyWP7Ku+MKf0OK23tRmQEsbWxZPN5yNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6403
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 02:28:49PM +0200, Magnus Karlsson wrote:
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
> Run test number 21, the metadata copy test in skb mode only
> 
> ./test_xsh.sh -t 21 -m skb
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/testing/selftests/bpf/test_xsk.sh  | 10 +++-
>  tools/testing/selftests/bpf/xskxceiver.c | 58 ++++++++++++++++--------
>  tools/testing/selftests/bpf/xskxceiver.h |  3 ++
>  3 files changed, 52 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> index 489101922984..b7186ae48497 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/bpf/test_xsk.sh
> @@ -79,12 +79,15 @@
>  #
>  # List available tests
>  #   ./test_xsk.sh -l
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
> @@ -92,6 +95,7 @@ do
>  		i) ETH=${OPTARG};;
>  		m) XSKTEST_MODE=${OPTARG};;
>  		l) list=1;;
> +		t) XSKTEST_TEST=${OPTARG};;
>  	esac
>  done
>  
> @@ -170,6 +174,10 @@ if [ -n "$XSKTEST_MODE" ]; then
>  	ARGS+="-m ${XSKTEST_MODE} "
>  fi
>  
> +if [ -n "$XSKTEST_TEST" ]; then
> +	ARGS+="-t ${XSKTEST_TEST} "
> +fi
> +
>  retval=$?
>  test_status $retval "${TEST_NAME}"
>  
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index a063b9af7fff..6eca5f95a3e0 100644
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
> @@ -316,10 +317,11 @@ static struct option long_options[] = {
>  	{"verbose", no_argument, 0, 'v'},
>  	{"mode", required_argument, 0, 'm'},
>  	{"list", no_argument, 0, 'l'},
> +	{"test", required_argument, 0, 't'},
>  	{0, 0, 0, 0}
>  };
>  
> -static void usage(const char *prog)
> +static void print_usage(char **argv)
>  {
>  	const char *str =
>  		"  Usage: xskxceiver [OPTIONS]\n"
> @@ -328,9 +330,11 @@ static void usage(const char *prog)
>  		"  -v, --verbose        Verbose output\n"
>  		"  -b, --busy-poll      Enable busy poll\n"
>  		"  -m, --mode           Run only mode skb, drv, or zc\n"
> -		"  -l, --list           List all available tests\n";
> +		"  -l, --list           List all available tests\n"
> +		"  -t, --test           Run a specific test. Enter number from -l option.\n";
>  
> -	ksft_print_msg(str, prog);
> +	ksft_print_msg(str, basename(argv[0]));
> +	ksft_exit_xfail();
>  }
>  
>  static bool validate_interface(struct ifobject *ifobj)
> @@ -350,7 +354,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  	opterr = 0;
>  
>  	for (;;) {
> -		c = getopt_long(argc, argv, "i:vbm:l", long_options, &option_index);
> +		c = getopt_long(argc, argv, "i:vbm:lt:", long_options, &option_index);
>  		if (c == -1)
>  			break;
>  
> @@ -390,16 +394,20 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  								strlen("zc")))) {
>  				opt_mode = TEST_MODE_ZC;
>  			} else {
> -				usage(basename(argv[0]));
> -				ksft_exit_xfail();
> +				print_usage(argv);
>  			}
>  			break;
>  		case 'l':
>  			opt_print_tests = true;
>  			break;
> +		case 't':
> +			errno = 0;
> +			opt_run_test = strtol(optarg, NULL, 0);
> +			if (errno)
> +				print_usage(argv);

aren't you missing ksft_exit_xfail(); here?

> +			break;
>  		default:
> -			usage(basename(argv[0]));
> -			ksft_exit_xfail();
> +			print_usage(argv);
>  		}
>  	}
>  }
> @@ -2330,8 +2338,8 @@ int main(int argc, char **argv)
>  	struct pkt_stream *rx_pkt_stream_default;
>  	struct pkt_stream *tx_pkt_stream_default;
>  	struct ifobject *ifobj_tx, *ifobj_rx;
> +	u32 i, j, failed_tests = 0, nb_tests;
>  	int modes = TEST_MODE_SKB + 1;
> -	u32 i, j, failed_tests = 0;
>  	struct test_spec test;
>  	bool shared_netdev;
>  
> @@ -2353,15 +2361,17 @@ int main(int argc, char **argv)
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
>  	ifobj_rx->shared_umem = shared_netdev;
>  
> -	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx)) {
> -		usage(basename(argv[0]));
> -		ksft_exit_xfail();
> -	}
> +	if (!validate_interface(ifobj_tx) || !validate_interface(ifobj_rx))
> +		print_usage(argv);
>  
>  	if (is_xdp_supported(ifobj_tx->ifindex)) {
>  		modes++;
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

Could we simplify this and avoid branching just for getting the index of
test to run with something like:

		for (curr_test = opt_run_test; j = 0; j < nb_tests; j++, curr_test++) {

branch vs additional variable, up to you but repeated code caught my eye

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

