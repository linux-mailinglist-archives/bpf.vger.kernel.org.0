Return-Path: <bpf+bounces-9949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4CA79F039
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 19:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C765F1C213CB
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCF0200A3;
	Wed, 13 Sep 2023 17:15:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1BF1804F;
	Wed, 13 Sep 2023 17:15:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB771FCE;
	Wed, 13 Sep 2023 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694625333; x=1726161333;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=COGt1hCUPY/PGsu183eWe40sT/LGBxX4fL+4YmAOO84=;
  b=mAPXYQWFi0Tl1dopRHBUokmdF4ZurqUjrUiK/hq9AVK9kaK2bjC7m+jJ
   HuICMrZM22JIMi9VV7Io4xGCYjJmz0kWNfhcn0GSO6Fbn2kVQMd4l3MnU
   oFwlrNjXLRStf4I9r/cd7NJN0HNXv37Cu3NxQaMesyKDER+gkR9d6Bsnz
   jSj31J/HPXvF/6setXmtTfh32f8TcorbbYK/QsNt3yNyc2gomDS6Lw7Bd
   mcHJxPZiMJEhH/Cj8Bc0GjHpj/PUGAi8UWAVcS8NjgYiMmuMmgrr6Ghqv
   FWnZgLex5ERPjEnb5huUV0Mmjqx7xXq0Q+Kiukc1fypHcp2O3u9YTqqRi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378639494"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378639494"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 10:15:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="917918843"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="917918843"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 10:15:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 10:15:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 10:15:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 10:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNQg6k58aSc49klwGXvPvDAMTxp0D2PpfGVewuImHIQ/ONsNbyrIy3hsDeEytQdbxNmVurM5sf9yNBqtNEHLAlKirP///Rrtd9Dp4XQoLDr5ZLFAXcf7svEVq0RibVRJDQeL6aGo2MURn15SuDX3lbTVc8YLfBmA8+bBFdS0UOn8VNjthz48I3ub95ASEDYMRPHGknbQ7IwP9ww59nftHL7reWSbM2X9S0FKbqUmC65bmldIUxW3KXrXckds5yx9GP8TqSjBEDA11kKXJ4rl+A4OZicoswci8C1rqoG1BbG7QIIEsYihGrX64B2VliJRx8Y82e2WCOaB3rZ5RBvFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsnfmLzn+4pH6dVWMf/L+O12GW8ID/+xueBkW26oeQs=;
 b=IYvOOHuBALRK8E/IYvH/wGej3SPKK7pwpBWWTd4aa3jIaYEukXDacQoySw+MGyz/c9m3bHe93W83UCpL4X3F0A7+e7RZ1ZDvbHIRRZI9RISWhfUPhjJKAPIvcKW708Uk6+2J7H6uZwsREJuOMBlynB9XvfG3jJy384bc7GVardHYlwPX0VR36Kpu+pRDB2A2YsBZGgv8E91pRTq4T65kEVU5gDmlC9blC7GrmtQYa6TzhCG2TWHoAgkTzFWT5l20+cxkh448mbzH1Uj2/md1R2hkCuSYp2LOnWabX8Qm9TzTfpFDsofxnBwIikE8Gy651vI6HH1PRpAYUALAno2y7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS7PR11MB7888.namprd11.prod.outlook.com (2603:10b6:8:e6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.37; Wed, 13 Sep 2023 17:15:03 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 17:15:03 +0000
Date: Wed, 13 Sep 2023 19:14:56 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v3 07/10] selftests/xsk: add option to run
 single test
Message-ID: <ZQHuEATwIdONDg9o@boxer>
References: <20230913110248.30597-1-magnus.karlsson@gmail.com>
 <20230913110248.30597-8-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230913110248.30597-8-magnus.karlsson@gmail.com>
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS7PR11MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ce8050-1ac9-4e90-4c78-08dbb47cf7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4WuC5zLHcFX59bg3gWniyYcehKVZG4H1vyVNRbpBXGw29WvcT6GNdnMKrmVMUoxZRmOMtGC04H8FfIdTgp55deXwY6kiB8wnfBtdpEBNbx+1Ktt89IubKq6FbHQkzBc14qazWjl7/gccgmiHc6Z567GdTUguW5EwDqv/FU6kR5chgk+JO7gpy7hfq+XWEO8MAqZBCnG1JAKmspVmduoRzZOaZZVK2aoZ4m+yRmSVMT/Ugy61XDfjiYrayoK8aHF37BcjLzPfMQn6b04VWocNvdvr4MbY68jaeE0z1eEkro3WVX2z5VvkD0MqE31CVZY8/YWxn/r/BWKXDBPtP5/nYDVa7071iVu5DFQek1WOWKPQU/Kdi1keWUSTteDWCsmol4YnJXUJgajLi51dPH2hKjqrAs3cbOT6uGmAT7nfLXF51m3on/44Gtb2e48e+xmCCZ941cAgVlbYz+KCgCyTrGtO7xZ+Lj3pP6v8ldCqsUhNHIjqYjJ1geqjAgBg0dhoejlpMPWuNxMkPEdQxE38lQmd93jPerUP8lMNCHh03HL4xP5LiOw1AM0/IYY77dF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(346002)(376002)(136003)(186009)(1800799009)(451199024)(316002)(66946007)(6916009)(66556008)(41300700001)(66476007)(478600001)(38100700002)(33716001)(82960400001)(7416002)(86362001)(2906002)(4326008)(44832011)(5660300002)(8936002)(8676002)(26005)(107886003)(6512007)(6666004)(6486002)(83380400001)(6506007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5pxOC2Tdij5o2JfHv8AEJmh50VaIhg5NlDQp6uU1U4KQOX1JVNTg7vCyXrq3?=
 =?us-ascii?Q?l2yruB1/YUbD6DbOegey/4byHNAWZV7PD/8/kEMC7/PBgeNBZUSLQDn6iAG4?=
 =?us-ascii?Q?TkR1ALetkqDJZt+ML0PKjTiJ1RmsaJ3ef6+Y9HTdxwagDJFCjuaC3ICnEXGE?=
 =?us-ascii?Q?zvbb8s50gpaQ7XydBDofebQqxf8uiyFfeex6MeAJoMwKd+Oz+I1PqAwc0LKL?=
 =?us-ascii?Q?Pw15eimaVlLyacNcA1OXhzqEVzIqoVx2VDrL1CpHT5hecJBHL5AV5PkTvpsr?=
 =?us-ascii?Q?KoxON7jFpF7vq6z5FlNdKmlshIKIoMYsXCnJHcC9Ctqr9ZGdo8ry+b8dSQLS?=
 =?us-ascii?Q?m0z5BtlQLMNm9XsnOeB3GzIMlvGpIPgBjfzJAf4/wMV0dfoBsFuDJqafUNlY?=
 =?us-ascii?Q?tC1i6v5io1Ipru1H5A8Vr1A0wwX3DJ0575P467t39BePsg7lropz7fczl6Ws?=
 =?us-ascii?Q?CSzctuuBUtoboXENLMDIis8lu9oyvyKPyCeSLwz6l5+/9mv+wDgSsy5HzTnX?=
 =?us-ascii?Q?RMxVbOZpnfXKLOr+SOa7XMqKAffaXisMVCAVgh4U/SmiYHccTQTpT7J3btbH?=
 =?us-ascii?Q?je7IGKFR5u3z/xHdIRJPYGqqqQl+cuYjvstqb1pweCvsWDUtQtwM5AnAbJeg?=
 =?us-ascii?Q?cjJGpGtY5mfTQIY9yq10cgu/AHH/U4yU//6R7j40I6bs+wB62MsKTkebpgJ2?=
 =?us-ascii?Q?i6F75YotNWcsCRZziYWbmDUOkfmdYRDehOhp1a35Ni9BNs2UGx6s0kNWFu7O?=
 =?us-ascii?Q?VAOvpsZGkyZurcWFetWwEV2Ny+56Xwb0RXNy+n+/1/CTMlCrvB2SYg/NqXwS?=
 =?us-ascii?Q?KfbFqRp+Cvkl0XhAFPBWIkQoluYoRT16M9vpa3YnxSAtB0O1m0R7ODk6Kto+?=
 =?us-ascii?Q?O4vYAe9i9Bmob9BdqY/kRWzyvVpxLSfD8vRgR8Qg12V822hqwQX1ZDsrWqnh?=
 =?us-ascii?Q?GnENN0TuNWmMNp28EJDx7ivHFOETgvH0f664hONbyW74oXrlW2BDDKbknPAW?=
 =?us-ascii?Q?BNrG+bVCPGhFSKb/xSQ92gaXO6RaJwNn5Hq5kl5HC+uAVEPJASKJnn5wD2p/?=
 =?us-ascii?Q?LLNpW3qVDXb1XVjd+fltyecnedGuBewYzXnt76W2gAkDyBxK/GryM19BYFHU?=
 =?us-ascii?Q?3cQwnCCs8TcoWcO7CWUgquhJyTyBYjax4oZALgCV9k+Xy97gvLzhJ0oT9ajo?=
 =?us-ascii?Q?3AGVqVdWWy22V08eYlN3sdFhYzHR1jzG+USaySLrJEgenpwmt12rHNv0yu9C?=
 =?us-ascii?Q?miKNPnlcsoWZtNWnOHg954YpNmQ4+X/yJMdEpujb9HRXWekwWua9HmP70zLj?=
 =?us-ascii?Q?plgpfeRTvVxjeDNwzUdvpp4+SHkCzk9WKYwt7qR0M2v3YS8aR+autGRbHxl7?=
 =?us-ascii?Q?rZ5UIXL9mmK8F6zN+FpNlZezbsWWOGtvLDUEliFApghB2+ojg+S0jBotXrt8?=
 =?us-ascii?Q?22/Ou/H2jvw8OzDrQPtM6HwbYHUg2mF23/MqLMtzMG5ukc5B0WZ2g4eEvCpj?=
 =?us-ascii?Q?i0PnkX4ESDfvco2juP6PtbIX/5F09qT+AdDoNZEs31jE78qNLiirkojvWvZ2?=
 =?us-ascii?Q?QlaKW7Wyuocj6upIBJWXihYlIwhozKa5fBjKG68M0IcJSLqMn7gkEuC777NM?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ce8050-1ac9-4e90-4c78-08dbb47cf7e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:15:03.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+fDI0xnBvy9MQ7YofnuD/+mlNjg+sFTrfnKP3ahzGrcYvrjtvFSgpzIJfii4j8cxGWgvqaMxt7vylfMYpiF9DOtinTbDfDCHgK3VZUBlyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7888
X-OriginatorOrg: intel.com

On Wed, Sep 13, 2023 at 01:02:29PM +0200, Magnus Karlsson wrote:
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
>  tools/testing/selftests/bpf/xskxceiver.c | 59 +++++++++++++++++-------
>  tools/testing/selftests/bpf/xskxceiver.h |  3 ++
>  3 files changed, 55 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> index cb215a83b622..296006ea6e9c 100755
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
>  		m) MODE=${OPTARG};;
>  		l) list=1;;
> +		t) TEST=${OPTARG};;
>  	esac
>  done
>  
> @@ -170,6 +174,10 @@ if [ -n "$MODE" ]; then
>  	ARGS+="-m ${MODE} "
>  fi
>  
> +if [ -n "$TEST" ]; then
> +	ARGS+="-t ${TEST} "
> +fi
> +
>  retval=$?
>  test_status $retval "${TEST_NAME}"
>  
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index a063b9af7fff..4d5c53153465 100644
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
> @@ -2380,16 +2390,33 @@ int main(int argc, char **argv)
>  	test.tx_pkt_stream_default = tx_pkt_stream_default;
>  	test.rx_pkt_stream_default = rx_pkt_stream_default;
>  
> -	if (opt_mode == TEST_MODE_ALL)
> -		ksft_set_plan(modes * ARRAY_SIZE(tests));
> +	if (opt_run_test == RUN_ALL_TESTS)
> +		nb_tests = ARRAY_SIZE(tests);
>  	else
> -		ksft_set_plan(ARRAY_SIZE(tests));
> +		nb_tests = 1;
> +	if (opt_mode == TEST_MODE_ALL) {
> +		ksft_set_plan(modes * nb_tests);
> +	} else {
> +		if (opt_mode == TEST_MODE_DRV && modes <= TEST_MODE_DRV) {
> +			ksft_print_msg("Error: XDP_DRV mode not supported.\n");
> +			ksft_exit_xfail();
> +		}
> +		if (opt_mode == TEST_MODE_ZC && modes <= TEST_MODE_ZC) {
> +			ksft_print_msg("Error: zero-copy mode not supported.\n");
> +			ksft_exit_xfail();

shouldn't these checks go with patch 03?

> +		}
> +
> +		ksft_set_plan(nb_tests);
> +	}
>  
>  	for (i = 0; i < modes; i++) {
>  		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
>  			continue;
>  
>  		for (j = 0; j < ARRAY_SIZE(tests); j++) {
> +			if (opt_run_test != RUN_ALL_TESTS && j != opt_run_test)
> +				continue;
> +
>  			test_spec_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
>  			run_pkt_test(&test);
>  			usleep(USLEEP_MAX);
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
> 2.42.0
> 

