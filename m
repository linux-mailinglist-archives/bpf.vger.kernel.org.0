Return-Path: <bpf+bounces-8234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6A7840E8
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E784281079
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF761BB3D;
	Tue, 22 Aug 2023 12:37:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9E7F;
	Tue, 22 Aug 2023 12:37:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D568CE;
	Tue, 22 Aug 2023 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692707850; x=1724243850;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ANXTv+wGW6HEW+ReIMFjusmbmRLuptqOkzIQ7UD7nqw=;
  b=G3XM187BAWbVFgwcT1Q1EftHtc5j5+SymyAfihQFgBRySwZNMWHTfzOp
   aeK6K4zkyeKcBVoheLKFEcz1giOQTFzDcpeIX7OwFjVzkZvdDyZFqDznW
   QBiX6TNuxK3mW/GgS/fz+Wdo8AJFAWgwkQjqB6pWkwlzKm8cASUfGfnn/
   8TZK/cjRCfiGenPyWFPNIZr0vJUc6BSOotzybPw+6lSNLdiH744X+og4k
   N74JmPB7qLVTiWCvSdpaAaOV5V/Ju0drbQqa5gepSALr8cT7ScZ4Qkeen
   ixaI2UJi+vNqLOFeMmGQA6nk2o4zHzK5qJFfTDc8Anu0bqLchkqETYVb6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376604060"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="376604060"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 05:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="765724286"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="765724286"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2023 05:37:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 05:37:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 05:37:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 05:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyN7ji1jaUpembKi0VAtPPLntUA2t0MuGbcfAFHxpIh9w3UgsY5yanvHybvWu8uzfFUzkFWQlB4dfvy4+p0Nm+Sj2npHEBSuJsB8QW+hl9a7Gv1My8r0Rk6YPNCMXhw2VrYS4b3jI5mPU2/0oIEGnzvLPMqmKw58mIis3oYfeTpR5E4nxiuW9Us73GBNkOyWNir4m6x0GW+3eJuQEmOIFB/91RJ2nX+JbCZFRLi7t/mczrYtfYF8WtYYsiiCBR4f6UeovHkHhwk6xKpC75cXXNjhxfNN0G7G4UZ7cJz0rmAhVEadf6q1yo5s2IHSKjZP+SfQ+OTXGzfflqYO08bUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv0ZsbbDLXL6FORf3VCZcAt5uc6K2S3fhbzKyPEdJjk=;
 b=fOzFpCfydm1UDhcqyuy8liJ29E2lYA4ynZQToty1+IlBbAQh2Vd4AkrczwW5nBOXfU5mNOMFNXeRO1I0PnakiCoXLs5SivVeFc54mmg289sQw5aCNW1dCKnHRnriXY4Qt1Sa7h6LIVwhGQqJG5OA9I+pGitDdE75nLE8GrjRIvE9y/YRSDSVyWfeUZucHIC4jrxFhjO/KgPSYVT1J2RcY9Dw68ygtQwHp2Feyy2rqVOWqrBzOT+a3OGaCXxU1U9fHP90ON7R0DQMlv7FvVA9OadPa+FMg9W0TVQsAM3gEzfX8/ijIo8BXHL6Cc2VePrezwlaUDCECo947yjabUjRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7946.namprd11.prod.outlook.com (2603:10b6:930:7e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.25; Tue, 22 Aug 2023 12:37:26 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 12:37:26 +0000
Date: Tue, 22 Aug 2023 14:37:18 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 06/10] selftests/xsk: add option that lists all
 tests
Message-ID: <ZOSr/muPbfiGAw+M@boxer>
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
 <20230809124343.12957-7-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809124343.12957-7-magnus.karlsson@gmail.com>
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bf47fb-77ac-4dab-9499-08dba30c8a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBS6ivzFAWiX0j3qK0RRTLwgrg4foJG3YMy4vdJ2Rd9DNUHl7WcteEy2LUR+4LSGsGh91+dzB+qg562iiqn0lH+uevFM2EQo5X3jdm+CIBAwGVU3Mv39uA/Ln2jEtzCWWKMXwkMoGq3nHsYlRvnRvC6RvdFj6BpTgN4zp1tvso5zdzqM5WM0dKyMfaY4W7phRqCVCQNW4r96iHObGhfPhEv5ouJkE6PFOU6SYCSB96xTQdU45hcoP9p1nXjdLsm/rdKz6+4L9oKbGcI3lWCD4Xl5u4W4ZvM8wUbdqhTBMX8nIJhPHagekEbs7JQY7MedjSWbT7pT8ChElkTLiR2dEi8v/ZP/tTlcW6sAHX9pnnlQY0Cirrsr8hos++QAoJE8vvUOkaa9EZtVGN2dhzVZL4RSkkblelMEueHZgBxsJKS7EUASrUIWvef2Faz2hTBvPPO6S6TQXto/O1wnUlLx4kpRH/0HdXAkxKgX0A8N7IxXL8gDvqeBsvWJOv+r1qQD4WpETbkn5sFlxIbyjAz3A7dCuo42gi9PXb548m8i04Us7037gtcNIbyBmZ/m9ErL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199024)(1800799009)(186009)(44832011)(6916009)(2906002)(66476007)(316002)(66556008)(66946007)(8936002)(8676002)(5660300002)(4326008)(7416002)(6506007)(6512007)(26005)(9686003)(41300700001)(6486002)(38100700002)(6666004)(33716001)(82960400001)(86362001)(83380400001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FU4mKJHgEMv3fBs4dyLI4+1fUPzwAwd/OWOI8SLtaJOaFse9i0hRF+TYFYdj?=
 =?us-ascii?Q?D64r5gMgz+2+OM/WqTQVeZgrSGsm2rA6ppMalgXHCsUFkA9ZSAOd6wsovYck?=
 =?us-ascii?Q?+kgcemkgygJFJS6Ax5RaXepk/i/BWBUUDFkW/GBDaY8sGp0sF0A20q1RAZl1?=
 =?us-ascii?Q?+VKNduyZRadPsoBrsmBBfSXSIMGIiLu8v1oVUJ3Yt/JYSmgWIZznVLKleFhM?=
 =?us-ascii?Q?CGxXSM2Gj9TJUOrPqvCn/AYu/WyuiahKXdEdXYt7TcGldt8w3jUJngencc7A?=
 =?us-ascii?Q?ZIUOB/adTrIc3vwLm88hYnJ1pfmBHx+DJ3hcJKyGO26+GK7LZu2JP3+0zjFI?=
 =?us-ascii?Q?qsCugLADRQe52Fjql2wXG2TRLZX3Ta587a2KRuh4LRLRUn1107i6yUmwn+Tv?=
 =?us-ascii?Q?xMVehdFu6yvWGBpbBG6bAbAp6slXfuuFb29u4iRvU7px9e/htE4JFJ1Yn33O?=
 =?us-ascii?Q?aHjyK7tRODm7GMqgjcETHwacwEhAoYhXoP38HrPL4f+DMwAI+tlBiGacJpZw?=
 =?us-ascii?Q?QCscg8OGTVe6Ri5PAX9P7YGWiEFLvdZ47Uken661KIIiWQY/xBDgrus5i6h0?=
 =?us-ascii?Q?IH3EXOmkdHzG++XJrZapog2p2TagRuFmiNFM38s2dm2UYDNTWbcyuioM7JXt?=
 =?us-ascii?Q?ugW8RnirIhdiKHLWSlxFXBK3LOb/BvbFQoqa+9qJpNmX5t/xeSWDwuj7gcEU?=
 =?us-ascii?Q?tx+bXMJQYiJ+SEZYf6j4ymw1KQHoHJsBhU6ysRntJCH5QErccDnOCMupj+o/?=
 =?us-ascii?Q?s/tMlK6wFt+ALWYUTRztSCpMlABoiWNOHNpiB/jBAFVncUImWxDGpLEATdDB?=
 =?us-ascii?Q?Km52gC0sa1wxRza61zs0zlWZjJ9cG1J1bnXYz0Y8EsiPt8iGKOLL2/4wH65n?=
 =?us-ascii?Q?pT+5j/9N1UDlIfbQ1VWZsP9aDqImsf0O/mwsTFUMc39w0IUrHNGKm/a4S3Wx?=
 =?us-ascii?Q?2Y30JFhOPYSROUyjhffMdKI9Cy4KJg4Kqm7NAwNdU8auymbcKfVuWPtAV8Tn?=
 =?us-ascii?Q?QEwyqmKAL5fl7m8Tbmh8ra4j+cdBzf48+OKeoazFzn2uUserpf1JG8LYYEEj?=
 =?us-ascii?Q?yUWIVlOJpaIx1WdAtssFlusrrOEU7Sc9ou8Cj/IuCDAhEscEuMlLaEvyShIG?=
 =?us-ascii?Q?Hs21Bxet1gdkw53YPMBHcb0r7BwSFX/Y4F9omxRnCmRnTsRqMOn1d5pX7Zb3?=
 =?us-ascii?Q?ROR4w1ixcLAS0Fge89WLkGJNsR19rHursXUDlup41ucKJk8QuL8xItSJJ93F?=
 =?us-ascii?Q?nLPAYV4uLEMdUHU0vtwwhp2xSXFK3FHnCDbwgTYCNrsTM29E+gRUFNcUfLHo?=
 =?us-ascii?Q?+ZPyQHdYHc0AsXCVdwTMZ003SBpuT/NCmdTFBji5ve4hoqCiWv/mwVr4qTY5?=
 =?us-ascii?Q?+u201KTmYZ9nkM/hdpIvaSzq7bl1Cm/B3MZnLFrwPguyU/LO1rkvX8WXhmca?=
 =?us-ascii?Q?/TsB5F6woqLBuGTIDA/GdGuKscmXKvOtScRcZXxVpUlQYf1VUelsj+mFZZry?=
 =?us-ascii?Q?1QtOol7dBJYX0x89lASVDWSpFXmjmmhKQXTj+cWQWcIFGHzDT7o7faDpMeIT?=
 =?us-ascii?Q?hMbre9gtqtsD+LaEGJTTQnAUoafKaQZiUJr4aOEWanOAEEvvzhVBAa90lvUd?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bf47fb-77ac-4dab-9499-08dba30c8a7e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 12:37:26.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +14ZY57A66pPYlDsw3xyFWrn6DQ0kGfOA1Wle8g27CDfsUbe/o1RvW3vE0xchIJf8N4FBzOMxur4hof03IKQL0NChUAm66YBiG46w+3Dddw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7946
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 02:43:39PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add a command line option (-l) that lists all the tests. The number
> before the test will be used in the next commit for specifying a
> single test to run. Here is an example of the output:

I was thinking whether we should have a way of combining -l with -m, but I
believe there is only a single test currently that can not be run in ZC
mode (rx dropped) ?

> 
> Tests:
> 0: SEND_RECEIVE
> 1: SEND_RECEIVE_2K_FRAME
> 2: SEND_RECEIVE_SINGLE_PKT
> 3: POLL_RX
> 4: POLL_TX
> 5: POLL_RXQ_FULL
> 6: POLL_TXQ_FULL
> 7: SEND_RECEIVE_UNALIGNED
> :
> :
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/testing/selftests/bpf/test_xsk.sh    | 11 +++++++++-
>  tools/testing/selftests/bpf/xsk_prereqs.sh | 10 +++++----
>  tools/testing/selftests/bpf/xskxceiver.c   | 24 ++++++++++++++++++++--
>  3 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> index 4ec621f4d3db..00a504f0929a 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/bpf/test_xsk.sh
> @@ -81,13 +81,14 @@
>  
>  ETH=""
>  
> -while getopts "vi:dm:" flag
> +while getopts "vi:dm:l" flag
>  do
>  	case "${flag}" in
>  		v) verbose=1;;
>  		d) debug=1;;
>  		i) ETH=${OPTARG};;
>  		m) MODE=${OPTARG};;
> +		l) list=1;;
>  	esac
>  done
>  
> @@ -157,6 +158,10 @@ if [[ $verbose -eq 1 ]]; then
>  	ARGS+="-v "
>  fi
>  
> +if [[ $list -eq 1 ]]; then
> +	ARGS+="-l "
> +fi
> +
>  if [ ! -z $MODE ]; then
>  	ARGS+="-m ${MODE} "
>  fi
> @@ -183,6 +188,10 @@ else
>  	cleanup_iface ${ETH} ${MTU}
>  fi
>  
> +if [[ $list -eq 1 ]]; then
> +    exit
> +fi
> +
>  TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
>  busy_poll=1
>  
> diff --git a/tools/testing/selftests/bpf/xsk_prereqs.sh b/tools/testing/selftests/bpf/xsk_prereqs.sh
> index 29175682c44d..47c7b8064f38 100755
> --- a/tools/testing/selftests/bpf/xsk_prereqs.sh
> +++ b/tools/testing/selftests/bpf/xsk_prereqs.sh
> @@ -83,9 +83,11 @@ exec_xskxceiver()
>  	fi
>  
>  	./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${ARGS}
> -
>  	retval=$?
> -	test_status $retval "${TEST_NAME}"
> -	statusList+=($retval)
> -	nameList+=(${TEST_NAME})
> +
> +	if [[ $list -ne 1 ]]; then
> +	    test_status $retval "${TEST_NAME}"
> +	    statusList+=($retval)
> +	    nameList+=(${TEST_NAME})
> +	fi
>  }
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index b1d0c69f21b8..a063b9af7fff 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -108,6 +108,7 @@ static const char *MAC1 = "\x00\x0A\x56\x9E\xEE\x62";
>  static const char *MAC2 = "\x00\x0A\x56\x9E\xEE\x61";
>  
>  static bool opt_verbose;
> +static bool opt_print_tests;
>  static enum test_mode opt_mode = TEST_MODE_ALL;
>  
>  static void __exit_with_error(int error, const char *file, const char *func, int line)
> @@ -314,6 +315,7 @@ static struct option long_options[] = {
>  	{"busy-poll", no_argument, 0, 'b'},
>  	{"verbose", no_argument, 0, 'v'},
>  	{"mode", required_argument, 0, 'm'},
> +	{"list", no_argument, 0, 'l'},
>  	{0, 0, 0, 0}
>  };
>  
> @@ -325,7 +327,8 @@ static void usage(const char *prog)
>  		"  -i, --interface      Use interface\n"
>  		"  -v, --verbose        Verbose output\n"
>  		"  -b, --busy-poll      Enable busy poll\n"
> -		"  -m, --mode           Run only mode skb, drv, or zc\n";
> +		"  -m, --mode           Run only mode skb, drv, or zc\n"
> +		"  -l, --list           List all available tests\n";
>  
>  	ksft_print_msg(str, prog);
>  }
> @@ -347,7 +350,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  	opterr = 0;
>  
>  	for (;;) {
> -		c = getopt_long(argc, argv, "i:vbm:", long_options, &option_index);
> +		c = getopt_long(argc, argv, "i:vbm:l", long_options, &option_index);
>  		if (c == -1)
>  			break;
>  
> @@ -391,6 +394,9 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  				ksft_exit_xfail();
>  			}
>  			break;
> +		case 'l':
> +			opt_print_tests = true;
> +			break;
>  		default:
>  			usage(basename(argv[0]));
>  			ksft_exit_xfail();
> @@ -2310,6 +2316,15 @@ static const struct test_spec tests[] = {
>  	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
>  };
>  
> +static void print_tests(void)
> +{
> +	u32 i;
> +
> +	printf("Tests:\n");
> +	for (i = 0; i < ARRAY_SIZE(tests); i++)

Nit: I believe you can do
	for (u32 i = 0; i < ARRAY_SIZE(tests); i++)

> +		printf("%u: %s\n", i, tests[i].name);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	struct pkt_stream *rx_pkt_stream_default;
> @@ -2334,6 +2349,11 @@ int main(int argc, char **argv)
>  
>  	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
>  
> +	if (opt_print_tests) {
> +		print_tests();
> +		ksft_exit_xpass();
> +	}
> +
>  	shared_netdev = (ifobj_tx->ifindex == ifobj_rx->ifindex);
>  	ifobj_tx->shared_umem = shared_netdev;
>  	ifobj_rx->shared_umem = shared_netdev;
> -- 
> 2.34.1
> 

