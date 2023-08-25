Return-Path: <bpf+bounces-8565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7680778868C
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3DF2817E7
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E83AD2FD;
	Fri, 25 Aug 2023 12:02:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A381CA52;
	Fri, 25 Aug 2023 12:02:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856DB2102;
	Fri, 25 Aug 2023 05:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692964937; x=1724500937;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FWqhV6kd8816KKmpfWwlA7mn2i9z2Nr8KFnT7G3Nd5Q=;
  b=jEdy0fTPOEx9R5Q4NrA4bvAIoZ4dt9u+EA9FvMsFyIem/81zsUw7td/T
   nNm6I9n0abO5mmp4fp0y7zgxba0688+ZS4FBcFUtYhbzctRYB6yTyNQoi
   XBqbH3KnCZWPdNyIDs1ISO0U3LqnEvqKmUosA0INrnGQejdGBckFLbdcF
   EQXElnT4Zur+p6+AVCK9FPJ5tUmMsgWRd4K3pn1iFd88ZSm+J5fK3XsPp
   XsJFey2LoHFMDjV1fAfCz2GUzHosakGQ50lmik5wHgpNdTz3whrA6GztG
   1bQHMH9j9V63YltfB0l98Hm62BwUr/IOQp3Wx5/MjpUCN0zzerPHUnHzg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="405697703"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="405697703"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 05:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="731046247"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="731046247"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 25 Aug 2023 05:02:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 05:02:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 05:02:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 05:02:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 05:02:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z22ZMqGc8WqGWJ6yMnlrux8Ewx/WfQvgbuJtAO0adJoPtGVBpVogfN0aUPvYl1YkDxYjablVhHiKTbSssXlRvvQyFlQkfZdDdoONxrd2MWOt8tiOckbPz51ijhN0N/HvE9B9lq2PkoDTMVmaJUsMojZkALMAdA4dGwsfuVrgnWLhqtBJwS7qskjDX5yl+oi8NxXJkoBKmThGcGOHiM/fOo0UUWYYq4tUj9JxyzXCHaiA9HX2LnZ/m2iMvrMRVdPFvIDcD/jGkQN35EVcr3qf4e1idUT9fCM4XGcEyaRioHGgZJUGp+WUf2mYdmv7TpUxTRZo/T3rn4q6G2TVCiyvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu2YtEZnN+ZNrL/mcATAY/i/TpdtNvbOBwWnzTjnjCI=;
 b=UIwfA2rPxF4JO21wAvIYzdCvgkLOsFvpvcLX7Qpf/h9O91CibFP6PqOvUdhuOpqJ9kgZhw7LrH9Q6L5chS1HILJYHCK5irMt9JnJio37CVIWzbHwQvdq8j68G7hUTR8DGdYYBtW9jz5gYndzM1k1yuLuI4fIbtEY0Hkash2KQjAegwVudnaL55x0m34n8UtwH/zw0UDjBrwtd4xYdOcopS0Da4o6wZaK5JupZyy1nRgfNYpvzren1RlCpTNj1JxCap9+sHS3HX1QxiNywnhj8P9U6tdn+qEvFdS30Xmxt3ic47pMEfHJmhmzZ0PUF2rFyl8rCNyl1MBSxrG/ZAz0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6472.namprd11.prod.outlook.com (2603:10b6:8:c0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Fri, 25 Aug 2023 12:02:12 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 12:02:11 +0000
Date: Fri, 25 Aug 2023 14:02:03 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v2 03/11] selftests/xsk: add option to only run
 tests in a single mode
Message-ID: <ZOiYOw0eSsU6dfRX@boxer>
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-4-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824122853.3494-4-magnus.karlsson@gmail.com>
X-ClientProxiedBy: DUZPR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3a71a6-4838-4a72-e0b1-08dba5631d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+t1UmsPJrPtWl5Hb2J9kQ2ERNND4jOZM8t4QmKbLIkBumXenPp2u10bVj+t7jM07eShTm3ulR6wIUHzwVOuYq26rKFIHQ7pZuyBtaS3DjK9MmRH73a6De+Pm/Qvf6dMoPaHIRrQMJFp2fhwKzuZdt0xClWV8cQXsL2UFYTLrvERYjmGGFDPE9neG6XxL/D4Z27Xj6jAHF8LfAufHkKrG4SZeQdAYdWfHEIB6/YU0MlF8EsDTYSkwjol/xMuoxR5kSfCH//aZiU8vKsf6R9XwDlrZdyYabRpGiivIdYP9Fzz01p+//BZii+zQPvG50pA00jlepiL9b+GUcNVi5caADmy23dgNkbk3NM56C3HubE7AnpDonlpTftnZqlje8+gGG3Lk5hmc2Zof7Znau47SvmZDPIE9Gf1T4Lv/cRwUQxxe0T/h3RoQljWeiFnVRWRu/FG0vbH4gr4Go74fEQE+ujEjGYBzfZswY92wuA6ToPYoorTW02GObRVH79STWNwcAMppSZxHfOcqvjOPiGkh7/XgOXw1oeO2yoFDGMtiqwdZzrQsHYlfMkq4zrXPrgC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199024)(186009)(1800799009)(66476007)(33716001)(66556008)(66946007)(316002)(82960400001)(6916009)(478600001)(6666004)(26005)(44832011)(38100700002)(41300700001)(86362001)(6512007)(6486002)(2906002)(6506007)(9686003)(8936002)(4326008)(8676002)(107886003)(5660300002)(7416002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CyyqZ2WJlttSr3EcFWFu7xGxAg5B3/K3o7nyiF3OAdjAtJsHAvuXFfcrDAY6?=
 =?us-ascii?Q?I3mLUvgMIR422a/EqQefhiTTDpqRenwphNyAGaxmBCAdMWpBhSTRXvyd4yut?=
 =?us-ascii?Q?9oGdsxvMNiI/ilDrcEAOD5ikrzV0StrA9dWhsZJeKfvXvnC00wXvMdGvAa6N?=
 =?us-ascii?Q?NDN7WXLx88QdQ7aLO0+KfBFV7Q3JPBwRYUf8XFKQ9nuULl3S/8yOGdeRkL64?=
 =?us-ascii?Q?E/qRRP5Kp3k/SWPgCv8L/+liCl/V7b9ltz50AUIaAjCtxEcUH49PdPq/8EIa?=
 =?us-ascii?Q?Z5PR8gD6TJkFuUYuvQZKgJGZQ7cvihUTWjTUmldbzaNNR2hBhHX73rpu5lxJ?=
 =?us-ascii?Q?GIdaOeNk0GJno3rb8OdNjwJ4PiZHT063ZYG8cOO3vGRzl2GsWu15S97fxZmK?=
 =?us-ascii?Q?BRw+YlY6u4Rah/+LAY3UO6vu3XAkh+A3EekAdfOut3mGMO7G4YsCMsm8JECR?=
 =?us-ascii?Q?dhem6UTzppT5tmSnKOfYJv+W5isEJ6+uC+ViTbrJw5Qr28g/wHOer1tkyMyH?=
 =?us-ascii?Q?tj9pMvhFJccpPSSpRlU12GcuANlnTkaac4njNogvJnZIE5DsCEWi72Nb2mWg?=
 =?us-ascii?Q?vVXBAcgyzgHDGyW11pxSW9WLjdDwyv23votS2CCB4ZqmelqLqbFaAI+04h7M?=
 =?us-ascii?Q?GFbCBxFgpZLpVeg/G2ZVPYkVbV41+cWAz2zNxVvjN7vPhbG1m5sDLHoh0Qsf?=
 =?us-ascii?Q?6/1eI+tC9nOcbCrb/9PtzsV3XKan49RCMXReF69l8P0sDjGBB3BmMlCga2uU?=
 =?us-ascii?Q?p92AyRluCHa+2A3iwv5lvHu/oM0QpqCW93RVLkCWDK5bFk8RSioR/DG3d2sv?=
 =?us-ascii?Q?+HXpNBfelMRE0TOxm3AKVEEiroCY4Ze/fTaxdWpqDGsxhfaEFb2ImXwccjQN?=
 =?us-ascii?Q?Weok+hLyMkXliLaqrKSkpROIw5u2y6RuUnZaydjLeVeUknqVLiPkrYOkrpfl?=
 =?us-ascii?Q?6skrv+twobj1xIwwp09g6m3d/5Tz1yP1Zl/PBf0UYbKojTkFBN9jvix7QZaZ?=
 =?us-ascii?Q?42v3Z/xJdj7XzNJMnAfW6mZCCPXRlRQQiDFmCM1fHgt4XOIpe7Y37ddH8J5c?=
 =?us-ascii?Q?mX90b5vhUaYC8SnRj7qX9/SAwuZgkBAMDTTOxD0xIoesKjLPMOQpulEQjL+h?=
 =?us-ascii?Q?uctZJEzI1CV7sMxLD7wtkn65LWm3ofvSbScTgI5p3G6oqZjacgbrovO116Yc?=
 =?us-ascii?Q?SEXvw6Q9XfrAdIX3WzfyEEC0I82W+hcUGVM21kVHEPlY/vj59/B1cGGtNyfZ?=
 =?us-ascii?Q?sBi/qpDx8y1ZWenteItWS8GLE0UEbbeEWcexKXZTOXziBVORYxsEX1EWEvDg?=
 =?us-ascii?Q?45ahiPduPBWc0F/03ZVViir6ZPGir0CnIkj3D4g/Bu8C+qRjoIovdrBBrlta?=
 =?us-ascii?Q?t+iS/SyZ6vwoIO8Yfcj7gmLw3l30PMjdOdW+4QRIr+SDZhRy8Tmzl/7+afdu?=
 =?us-ascii?Q?8eLPEWkG9VYRqRm4+1ZS0MK4LZOdjjH3X47+y8UCMalkSrs9bLTOU5qT4HXr?=
 =?us-ascii?Q?qKjvXth7Dlrj914obVu3D+lCOqSVv3JaZRVswg+LEJclFT71JdN/GG7T6Z8g?=
 =?us-ascii?Q?QkB1CDuL3iylNu1/ahvElOeSGEBm8laXc7f61ha0C7VuSVodeEadDwXNDrh0?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3a71a6-4838-4a72-e0b1-08dba5631d41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 12:02:11.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qu5mU/LY6D2Tt/FFBbZOvOpOZxRkmOF+c/SyEtzfZh62Mr8ZAKwAY2fxtL7tO7Xxn2Wst6IJru/NaIfD514GrX5oqbJvV4csesIWcqyJ7E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 02:28:45PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add an option -m on the command line that allows the user to run the
> tests in a single mode instead of all of them. Valid modes are skb,
> drv, and zc (zero-copy). An example:
> 
> To run test suite in drv mode only:
> 
> ./test_xsk.sh -m drv
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/testing/selftests/bpf/test_xsk.sh  | 10 ++++++-
>  tools/testing/selftests/bpf/xskxceiver.c | 34 +++++++++++++++++++++---
>  tools/testing/selftests/bpf/xskxceiver.h |  4 +--
>  3 files changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> index 2aa5a3445056..5ae2b3c27e21 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/bpf/test_xsk.sh
> @@ -73,17 +73,21 @@
>  #
>  # Run test suite for physical device in loopback mode
>  #   sudo ./test_xsk.sh -i IFACE
> +#
> +# Run test suite in a specific mode only [skb,drv,zc]
> +#   sudo ./test_xsk.sh -m MODE
>  
>  . xsk_prereqs.sh
>  
>  ETH=""
>  
> -while getopts "vi:d" flag
> +while getopts "vi:dm:" flag
>  do
>  	case "${flag}" in
>  		v) verbose=1;;
>  		d) debug=1;;
>  		i) ETH=${OPTARG};;
> +		m) XSKTEST_MODE=${OPTARG};;
>  	esac
>  done
>  
> @@ -153,6 +157,10 @@ if [[ $verbose -eq 1 ]]; then
>  	ARGS+="-v "
>  fi
>  
> +if [ -n "$XSKTEST_MODE" ]; then
> +	ARGS+="-m ${XSKTEST_MODE} "
> +fi
> +
>  retval=$?
>  test_status $retval "${TEST_NAME}"
>  
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 514fe994e02b..9f79c2b6aa97 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -107,6 +107,9 @@
>  static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
>  static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
>  
> +static bool opt_verbose;
> +static enum test_mode opt_mode = TEST_MODE_ALL;
> +
>  static void __exit_with_error(int error, const char *file, const char *func, int line)
>  {
>  	ksft_test_result_fail("[%s:%s:%i]: ERROR: %d/\"%s\"\n", file, func, line, error,
> @@ -310,17 +313,19 @@ static struct option long_options[] = {
>  	{"interface", required_argument, 0, 'i'},
>  	{"busy-poll", no_argument, 0, 'b'},
>  	{"verbose", no_argument, 0, 'v'},
> +	{"mode", required_argument, 0, 'm'},
>  	{0, 0, 0, 0}
>  };
>  
>  static void usage(const char *prog)
>  {
>  	const char *str =
> -		"  Usage: %s [OPTIONS]\n"
> +		"  Usage: xskxceiver [OPTIONS]\n"
>  		"  Options:\n"
>  		"  -i, --interface      Use interface\n"
>  		"  -v, --verbose        Verbose output\n"
> -		"  -b, --busy-poll      Enable busy poll\n";
> +		"  -b, --busy-poll      Enable busy poll\n"
> +		"  -m, --mode           Run only mode skb, drv, or zc\n";
>  
>  	ksft_print_msg(str, prog);
>  }
> @@ -342,7 +347,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  	opterr = 0;
>  
>  	for (;;) {
> -		c = getopt_long(argc, argv, "i:vb", long_options, &option_index);
> +		c = getopt_long(argc, argv, "i:vbm:", long_options, &option_index);
>  		if (c == -1)
>  			break;
>  
> @@ -371,6 +376,21 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  			ifobj_tx->busy_poll = true;
>  			ifobj_rx->busy_poll = true;
>  			break;
> +		case 'm':
> +			if (!strncmp("skb", optarg, min_t(size_t, strlen(optarg),
> +							  strlen("skb")))) {
> +				opt_mode = TEST_MODE_SKB;
> +			} else if (!strncmp("drv", optarg, min_t(size_t, strlen(optarg),
> +								 strlen("drv")))) {
> +				opt_mode = TEST_MODE_DRV;
> +			} else if (!strncmp("zc", optarg, min_t(size_t, strlen(optarg),
> +								strlen("zc")))) {
> +				opt_mode = TEST_MODE_ZC;
> +			} else {
> +				usage(basename(argv[0]));
> +				ksft_exit_xfail();
> +			}
> +			break;
>  		default:
>  			usage(basename(argv[0]));
>  			ksft_exit_xfail();
> @@ -2365,9 +2385,15 @@ int main(int argc, char **argv)
>  	test.tx_pkt_stream_default = tx_pkt_stream_default;
>  	test.rx_pkt_stream_default = rx_pkt_stream_default;
>  
> -	ksft_set_plan(modes * TEST_TYPE_MAX);
> +	if (opt_mode == TEST_MODE_ALL)
> +		ksft_set_plan(modes * TEST_TYPE_MAX);
> +	else
> +		ksft_set_plan(TEST_TYPE_MAX);

what will happen if i run zc mode for a device that does not support it?
what will happen if i run xdp mode for a device that does not support it?

I know we will do nothing and exit gracefully, but i am wondering if
xskxceiver should catch it.

>  
>  	for (i = 0; i < modes; i++) {
> +		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
> +			continue;
> +
>  		for (j = 0; j < TEST_TYPE_MAX; j++) {
>  			test_spec_init(&test, ifobj_tx, ifobj_rx, i);
>  			run_pkt_test(&test, i, j);
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index 233b66cef64a..1412492e9618 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -63,7 +63,7 @@ enum test_mode {
>  	TEST_MODE_SKB,
>  	TEST_MODE_DRV,
>  	TEST_MODE_ZC,
> -	TEST_MODE_MAX
> +	TEST_MODE_ALL
>  };
>  
>  enum test_type {
> @@ -98,8 +98,6 @@ enum test_type {
>  	TEST_TYPE_MAX
>  };
>  
> -static bool opt_verbose;
> -
>  struct xsk_umem_info {
>  	struct xsk_ring_prod fq;
>  	struct xsk_ring_cons cq;
> -- 
> 2.34.1
> 

