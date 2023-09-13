Return-Path: <bpf+bounces-9944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA079EFFA
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE7B282415
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CDF1F954;
	Wed, 13 Sep 2023 17:12:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF43AD52;
	Wed, 13 Sep 2023 17:12:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C21A91;
	Wed, 13 Sep 2023 10:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694625142; x=1726161142;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MaFBAXd9yxC0ajbNe6ZBFypxPRKXKLai+MRplZnO7gQ=;
  b=XLwC7y+nGJyxA/G2z7BVCaYguBv1+tQk8PLMBT0CKbnnU9/U4j37F55R
   FUlWGQvYhs7NijvaCiM3uIbcbjYPHoi9tg2RdKYvSuL28LFZNVfX7IGhw
   oxcP49tOQ4Sr/kdx2jeC04sTl7vfzlDKzsttQRpp27bBCZqx1apZ4OnqL
   kvdMUGVj/vzZkET9LjIIVjXeRfpejd+so+qxI1snjO+dRvLcRuZJYFzCG
   /2e8z/UEZtivHybKpIBFpisrujLzUtoDq+OohDiwxGH4WLktcxG8v9bf4
   cKQMQqxurtJyIXe8VjdU+NHZA1mRPpilz66WYzAq7ENqICAR70T6buryd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378638180"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378638180"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 10:12:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="744198132"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="744198132"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 10:12:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 10:12:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 10:12:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 10:12:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfrGQDvRI07V2Ia84fqW5czdyLuUu4qV5OrC7z6vldJzBJv0R2KR+6jH3+/73j36yvfx0JC3WfnyrDKT8/dJC8hHQ2/byMPFcwwyqzBuajxYY6objHj4L6AfAe6b/M+Sg0r3Yk6NpJcFm3rb50aJ7GUNE3RdGLgy6EVY8hryGVzxTZEJWxOnoff9iV0rzcgMVH/mctSJkHIUTiwubSAnR6eFb8aAn+nNHUegML+y0xy2NuaEUdyOd+EHX6O47EkO4WIPQ7QRgXia2w7O19tfbtqooCOx/KiOGITyI/OdqteKPRAHSM00NnXyRpaJPJm9SvHLIHbb6Pe3AVZQDL/idw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROcwDC5O8NKjogQ5/nLo7jfV4a+ZihXeeYAaUWPWNWY=;
 b=YYzuMHONKg3q5RNj1qgW8UNwIfP6jdfin2AcQZAJQl81zlaQkiJfeqbEH2momwS24A1OuVgolZlmep0xM0NuMyGNY4NqzMFV6456vBrm/zGJOws+EBe1Y2RUeUSwe9jE+tv4haXE/Ogj6ZnkZYqwEvMFkTZz227yRQ8HtE8CNPoPWTWiSXlnS8hrLtPDeBcMivLDO8vSucKzDqSIEbc1n6+2R7so6ruafIDliyUGSBFc7pAvQ63l8Df64JuJ+VuwOwpQl14jtT0MpOnZ7/OtjJxH0wYSglwx6g63ZahQGnYaXQxVQG03pfgKMeyo/DtmItLk/1bG/Q3DkF5tOqoixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4848.namprd11.prod.outlook.com (2603:10b6:a03:2af::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Wed, 13 Sep 2023 17:12:15 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 17:12:15 +0000
Date: Wed, 13 Sep 2023 19:12:02 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v3 03/10] selftests/xsk: add option to only run
 tests in a single mode
Message-ID: <ZQHtYo2i/oio1xbT@boxer>
References: <20230913110248.30597-1-magnus.karlsson@gmail.com>
 <20230913110248.30597-4-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230913110248.30597-4-magnus.karlsson@gmail.com>
X-ClientProxiedBy: FR2P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0e61e3-6d6c-4ed9-c080-08dbb47c93dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDY3sfhVE8nF8jDnazdp18jFLB3rwGN1NqUV8Ie20/BYYqBGfwtgqDA2jQ1jZrZAkWUn7NBShI1rj/rDG7GXwX8qJFeHA804OXNUhGdOrzV+mgo5CrMZv97vukoFOIyhksaZjNGZ8SG9QVlDJvhvAEnkAhMGRvRqWAJhoZytUoRianaU9tc9OJnooUvBDlMklqcwvRZd0x7ocz7rGMVzY1FqyfNXNYD7cCHAK+OKUi07Nc/TEauwSerBATO5Tcatf8VXoytH4+mMPnfe++uEmB1XT2JRsb3MtUcq/JU8G2++3unGbQA2JND+q08ZZGGAvHeMBFR3tjw01/XopGyOJVJNZF0FwhR0pw80Xx1egdgj+jczp2o66sU0LujL1esvgSgNORrAxVgrN7PJihOwEy8d+I+BTBXl7RvXSoLDLR/t4r8I4yJWXfdjUFR2iBAuYrWdFVVZuAVCgMdiyL9sYMkTlmQar9mGgIDWOnlHWHKjCpxih3D9a5daObawMetWS0x/qAZ/uuJxNcQ/lTYIx9sVbGncv7zLjDojBiAFJOS5FkVJ6417bY4/qxNNJ+oI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(346002)(376002)(396003)(39860400002)(1800799009)(451199024)(186009)(478600001)(6486002)(6506007)(6666004)(83380400001)(26005)(9686003)(107886003)(2906002)(33716001)(41300700001)(6916009)(66946007)(66556008)(66476007)(316002)(7416002)(44832011)(5660300002)(8676002)(8936002)(4326008)(86362001)(82960400001)(38100700002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sBO0MF3Z/247FzbIRk/6Me0x2TyG+hpBQQqCT2eQ7oUfuGOORF/9DMjuRX34?=
 =?us-ascii?Q?ZiSyMtc35u/ITWm1KyR0nI9RWUnAjLVShOobPsFItzDR3yMZDUl8TPmRnYLC?=
 =?us-ascii?Q?FuVEhDDwb0Fxv9Jg6Tvd6epA5wdmUAUl29BnohG6tjjtu3xjDep3m7IpYHUy?=
 =?us-ascii?Q?iF/3hl+GX/cc5DAA3qKQpSFIBR/Eqwiv9EtobpfVCqpCKyuHpyvNt5YMz131?=
 =?us-ascii?Q?hmjz02X1KsIrjnq1HJoL6fiGY0HLPFJ+1GjoCeJNtl2gJAQePtas01t3Z/sR?=
 =?us-ascii?Q?6CbR/jG+Iw/bdzaN6ETaYJ+T5V8J9nm+SnoSkCzsYByI69QPueK2m5ZGcuWk?=
 =?us-ascii?Q?7bYRWVX050Dvvy6Wz07KUx9Qh91R1Y5Sf+RWQ3vGjUJBNPBB5EiMIPB/vAd0?=
 =?us-ascii?Q?U8FYFk6wXqE0rXbFD9S2y6mnoXKUUlgUhkBMaIbizBXgPhPqG2mA+qm5ghGZ?=
 =?us-ascii?Q?6krJO4rA76LC7RqClv6njkGDYmqFdwxkCYzd5SvK1dhnl51sH3gDGPQDidGA?=
 =?us-ascii?Q?bHMdzfOFsGBHoFP1WEJs+hlSuS1IxKBl5/qeCto1wVy2j2mpS7HEoLfC3OuO?=
 =?us-ascii?Q?MT9XMCHhPewFsBdrwmiDV2Kt2a+0ixzQpb6tbnk949n7vyn7G6oxroPReExF?=
 =?us-ascii?Q?FuTmpziHbyGV2vNvJ4TlAVautv7ht9yzw+8ImVnZ6Mb6MRWYxh5ZPUBWEr6H?=
 =?us-ascii?Q?17seOBWFuyAWHTG1TmmkBw8hBCp5O6xhYqj/3erhTlIugZTTBjbYshfdepZ7?=
 =?us-ascii?Q?TbOv/MuWnUi5XZT7Ql8p2AmuFcT1Q3WeHJe54rAxoFf/0qsASvnEjPldaqBs?=
 =?us-ascii?Q?ORB9z9QnDgIjnC/2HrtHRcZvg2as3SAifVCGBTOLcnYmiKU54rbN02ipQw+G?=
 =?us-ascii?Q?CAebuoy8urOx2mwWaZJrrUpOzN+G2rF/Krz8xwG7qDNacj6KRYc5cFPjP/eP?=
 =?us-ascii?Q?zJ3FvvFK+vDdYt5zusTTKuWDXtg3racI/XmZe5FHJKAX/mky0YZbjilHDMtj?=
 =?us-ascii?Q?kPbHj8lhqp6E9CCTOofd/Db+5GwXQt/k23GVgKC52SXPPOWQ32pmL6iSOPXc?=
 =?us-ascii?Q?DM67ptEY8YmoI0rLMpMHV3p3pH1iz9vOGrsR9vwlZo6Wdqb+CJ+tKwE3uqLn?=
 =?us-ascii?Q?zWHA+siQOdYcuNek+TyY/CgPuuHm6oVKYxwBDq4S+1PRpnv/Qvens0E16lMo?=
 =?us-ascii?Q?mhI7esQXEANzacBR1WWoRn0FMmz6IYqdTqqp4lJ0s5driP6qemue61jSBOjm?=
 =?us-ascii?Q?Nt2BWUuc59eB1XHa/L2F5a1lZdGFIVAj1wMwCW58mh0iRhjFJ2b56v5TXEbT?=
 =?us-ascii?Q?Rit8Bjus+5jsLQphxYwpqeRqkSCIgTt6jWo/GtlqVo4J3SFJakS59jB2980Z?=
 =?us-ascii?Q?OhfYpCO3D7RsfvJteFtwaPSU6/Q0kyHI+Rm7KXckBm8MLc9SuQ487Eakxiat?=
 =?us-ascii?Q?5knAccS+ZpbzPDM47S0RTbDUvHya8F5u9+iKQVaLwawkkx7nXO6SOF9koOfA?=
 =?us-ascii?Q?OvdvEsSrF015FnZfWzw0kX6zxaohVsIkgw0BEGK0T306tAQt28bqD10CLrki?=
 =?us-ascii?Q?iL95Si17z43OYGEw9/5MRE5yuOKCrNFywU1yzciR4ecd8+brtOSTvQlLwv8u?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0e61e3-6d6c-4ed9-c080-08dbb47c93dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:12:15.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQnFoyIHes9jBOGLkNVDullaG4g4lwDQk2lsj5ShocQs//8C8NeweJxzk/ZhvQ8BJDT3P591pK7jkyFj9dbrjpXBcrsygzYf+Uz9GEc5JGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4848
X-OriginatorOrg: intel.com

On Wed, Sep 13, 2023 at 01:02:25PM +0200, Magnus Karlsson wrote:
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
> index 2aa5a3445056..85e7a7e843f7 100755
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
> +		m) MODE=${OPTARG};;
>  	esac
>  done
>  
> @@ -153,6 +157,10 @@ if [[ $verbose -eq 1 ]]; then
>  	ARGS+="-v "
>  fi
>  
> +if [ -n "$MODE" ]; then
> +	ARGS+="-m ${MODE} "
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

with that logic i can type -m zcafxdprocks and this will still fly.
Sorry for being such a PITA over this but couldn't we simplify this to

			if (!strncmp("skb", optarg, strlen(optarg)))
				opt_mode = TEST_MODE_SKB;
			else if (!strncmp("drv", optarg, strlen(optarg)))
				opt_mode = TEST_MODE_DRV;
			else if (!strncmp("zc", optarg, strlen(optarg)))
				opt_mode = TEST_MODE_ZC;

as one of the next patches moves ksft_exit_xfail() to print_usage which
makes the braces in branch statements redundant. Using len of optarg
solves the -m zcafxdprocks problem.

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
> 2.42.0
> 

