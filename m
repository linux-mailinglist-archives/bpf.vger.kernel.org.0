Return-Path: <bpf+bounces-9999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96247A01FC
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615F02820DC
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A5CA67;
	Thu, 14 Sep 2023 10:49:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F63208A5;
	Thu, 14 Sep 2023 10:49:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110D71FD2;
	Thu, 14 Sep 2023 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694688559; x=1726224559;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/sZDf/h/tObYoQB4pYPQ4ToV7vXLU14fH2QF4oxSuxs=;
  b=CJuqSjhshHF6PVtyZyKaCiyFFZuljmbViZv08x3XaWF5Iis6mNyISJ8d
   A0WiS0+NQixdLp+1HpPbRefdb/WZSFkADWUuZPhXS5PLCt9TbYdn2O0EC
   ej6NCEpP/cIHkyc8P+FTgis/fcYKsNz1o2RciCy5OV+Oc8Ws5/LJgWIrI
   q8EgpPPi0+vv/7b+xl+5I1p80vkjXP9RpskVsgzQ1Z7A9YumIhX7AjBnF
   v+MarxL514tThoAH7tbTV+l4dazj2VeBnwdn5KBh0KuLGyOJWbSen2Nxg
   8xBSBl3GDP5K5BeEKG6WDs7QPjs5hIPwERzVriZUwXame3FvNXlGbfM0W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="376253022"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="376253022"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 03:49:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="773847047"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="773847047"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 03:49:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 03:49:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 03:49:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 03:49:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 03:49:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPbu5ASjjc5LEqPUiT0L4TtGXbEYx+Biolx76gzJnj2acQVaL6IghDKRV6p1wPBjPtXMDRp9idDesmiESlR/IPk8Dz8qsmIEpiczVYhtoTEoNkcDfrOPhEIhMsO7R6toJhU1JMFBXtYE64fRmaxOYAUDRcG875DFO42BtyzfPBsSkSx1V2l3x2xMSqxccDtg78C+ZR68ngA3xkLHeDpbhAYYzt8dGnmwBorj2y0mhUbGGF2FkZQGY/jmC2LtdYExoPvirVckOdSOCWX6hUor1c3mQiAxVP8f+NOVdj9tl79xKUwD2LnYImGlyyMOjYAfPTL2Lbi1tMPvW5mAS/RoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgaYPWSQtA6fCZ2KYJN2FkRllt258PcLo0a588gOhuQ=;
 b=GCMYXElvPGukUjeZmxnX0tvV+jSYBMODN81DvlHDSpec3mcwg+SqyykPf5dIXk/tcyCf3wNlHCM1HqoSqtl7kNflPSeiHFrrLmFxDffIRtGj8qmDLM64AiDeoAiyNY2JG5QUyiV3+RESPrwax5D77wEXMdiNfMqLOXvhWRgzTK2C9KrOma0anHb+6z8MTbp1tTXWuiZP8f34+nj6PqY3gVyA8R5I+WbNsK/EP8faVPUHuZUcA+WyVyLWDFQhftcK5Oacz1SZELk0yIlRwUq8sk2KUrsAEKADp0X8DOwJgL+ZOIRtr3fH9GlDWwzeBMdeWvvCApBX+91mUvdXPx94Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CYXPR11MB8691.namprd11.prod.outlook.com (2603:10b6:930:d5::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Thu, 14 Sep 2023 10:49:15 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:49:15 +0000
Date: Thu, 14 Sep 2023 12:49:07 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v4 00/10] seltests/xsk: various improvements to
 xskxceiver
Message-ID: <ZQLlI5Ege5zLnRU2@boxer>
References: <20230914084900.492-1-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914084900.492-1-magnus.karlsson@gmail.com>
X-ClientProxiedBy: FR0P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CYXPR11MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcbf415-f758-4ea2-6aae-08dbb5103d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bodisd1MnKuAEHVL1ZKqv5fg4QvZG954xDDWBQ12RKsp38dS7T5nnD8E+V9ZpgPvjBkV0Ue5EWCU+79Dt6gBKBJU86Rn88y5FfCG5+BMHbtdaq3JHSB68tUo7WpF+UJCIPbwBWMkOfBvTyVr6SrOqTp7jcDUSPNggk7rRl/jF+yTLcuNwRfOBtKo9Y8y28E2JwbnrE1tL1k3Sx9KIS+l+AAsqGDl3DKf5mxDYY/M9Yv7FpKv8K03snG4XfA9vx8uXX0rSLJ75RUFWaWrRCZThL3C6WoLQIoruWufNkY1q0z3/uX20wC6sAbk7YB6bPKWzDwXJ80GK2P13kUQruAnBfPXhfnCW0J82OidEQP7TMKXNC68EUExRoNhLJiahG1seI1VhuWWzInLofE/vIY+nO+rz2yD8zs6Aj+XG0MjQ4htwR+PWH+MncGdtOUZuekhw/lXcWTDJYXwT8m/VVrOPgZFC4ADyphEwzowDt5IeR/5N/QUbCHW7lRIbF5133QvUzVDX/Q2/O5BZuaAvG7ZGiewFUMUF3TITL5baG/fuTkfWRECIehJJRMS0rEHtByW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199024)(186009)(1800799009)(2906002)(26005)(107886003)(6916009)(66946007)(66476007)(41300700001)(66556008)(44832011)(7416002)(478600001)(5660300002)(316002)(8936002)(8676002)(4326008)(6666004)(6512007)(6486002)(6506007)(9686003)(86362001)(83380400001)(82960400001)(38100700002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iPQGGUwrd4KSD4oizO/kRnVm4Lx9aBgeoWSiKJRqfd1QRVBzwqh2oOV3vliz?=
 =?us-ascii?Q?v2+BWHRyuCQkuQkxjDgAdD5+Fab8XCMn3NNe8Xc+TfkGdXw6MJn+uLu0CBR0?=
 =?us-ascii?Q?pnI22dqTKef1D92Te7/JgbgHX/LHCDjtEHTzCvBy5nnntrOgs+Uz/yJ/zxPP?=
 =?us-ascii?Q?oVQnXDVwb5cuLSg7aJVOHFF9sAp7Y6oHGs/b8uAEDiy1ikdGBR/JRJUQhsQr?=
 =?us-ascii?Q?6ia7lajt2RaPOXTtwOFvYSieD34pgusS+HFjTCRv1DjbWm+tl6jd3rkqoNVw?=
 =?us-ascii?Q?63Uv6VazB0nep8PoTLCJnmAH/wmSLXUt6VIhcCRQVnDQS2+oMpWuAy2WOD/9?=
 =?us-ascii?Q?0FH82k/Yx8o0Pk7+xFR6EKEw+kJbom4dUbQ4tWIaJg90yy0FGDQ/3PcGQSRI?=
 =?us-ascii?Q?ajznZmc1laASOGO5KRsXoQhe4ENVC24KT0Lenhm0GAJHST4gxY7uIO/mg/wk?=
 =?us-ascii?Q?trJt2L2lqqU9trWzSFfcHZw/6LG+WHtddzGOpZnkKkRtOOWB+GYboc0tBbiP?=
 =?us-ascii?Q?/gpBH4Tq6kiUlcwYRguxG4UJhmL1oubeisbOo508vm5Z4trBeghKRQPo5fPQ?=
 =?us-ascii?Q?9PzOBeA9TTeingRwYFfzVIQFVbejbTAUvL5BppHNZ0wGS9M+7cxOvn+qkEJW?=
 =?us-ascii?Q?SruPW0npMWaBjaIoFKFsO7jCZMRjNUWV6y2rsbgIdr0h8LWYdeYIkmrt4lO9?=
 =?us-ascii?Q?potY1Y5Fd+MRR80tja/Y5J/HWTu6S06dOcCr0WgiT3gWS9olqocktfdIK1d4?=
 =?us-ascii?Q?GTmGHjVizHJyn0RutXKRNMEY8L2d3PjJIlv8H3IDzz26YOCQi/Si4U295Q/O?=
 =?us-ascii?Q?Bs0JB+8uxIjDUCf9m4v5WbEYX+pcoqyIB1DqbHVz1Xt0bCEFDWVVIRFGUSxQ?=
 =?us-ascii?Q?cXAPml3ovv+mS/cHpom+4GG4pj5SDf/n49MwVs61zoLnJMuPDijzf2CdJKEO?=
 =?us-ascii?Q?KUDNpCnJWtoLNFbBibbybgY300UIjIKwDtaVafjX1RHEryzqPt4zdrTpi8rG?=
 =?us-ascii?Q?0DY3AGoYvNR3+4J8GpvxfG92OP1VjD3dPUDOMcJqx4VVvchk3MgqPNwVyfbg?=
 =?us-ascii?Q?wdaFSybRNML0/9xYzTUf3bozru8UnKh3C3j1eBifoDak2SIaUZCeA4gGIUYQ?=
 =?us-ascii?Q?J+Lk8fBNhH4+VREybfIOPGKeSG3X4+YKRU8h9TSx1goURpqyTtGDw6I1sHDO?=
 =?us-ascii?Q?kNqh08Gu0UWNc+mvsucmOwwefmKg0N8miA6jD7QM1EZxJ3i/+S9OU3D48XrX?=
 =?us-ascii?Q?R0msIJEReMsyLXZg/qy+TUyOPdjAW+4SfZ2XbU0yfEZEWmZ3jGqH0ODEKnHP?=
 =?us-ascii?Q?p/HbQAq4N3cvx7S4kcImAGbqcWrffnCiHpkiEYniY18IRcFZfdtbS4k3AdpB?=
 =?us-ascii?Q?qq9yyknA7RpGSHogyxWsycfsUVewVVX6kxqS81YJPzaCSZ6eH2usQhePxOSS?=
 =?us-ascii?Q?si/KKRWjdQ9Tq3N3on6u8eLEdj6olsR1jByFbhyUPMLCbSqTSrACk/wvRMpo?=
 =?us-ascii?Q?D81Ogx1gZkXtUd29UrBPsEXD0oG0UqBORr7v7C874BY9+EUFFKkUTZT1FmgU?=
 =?us-ascii?Q?HTZ9lXNspWJfctfO2wnAeBku5ot+UX+IyfIodGDRmLGqKox9HK9k2Wjkrsz2?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcbf415-f758-4ea2-6aae-08dbb5103d05
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:49:15.2180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj8unEEY/0DE1RbhlP23oEgpRy+YrmbhDJoGBLQoTm0psttnyyggM//e0UdOprO5qpu+ByRjLD9UGoHbzK+zl6RJifkU5E0QyWaGCI2Lq38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8691
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 10:48:47AM +0200, Magnus Karlsson wrote:
> This patch set implements several improvements to the xsk selftests
> test suite that I thought were useful while debugging the xsk
> multi-buffer code and tests. The largest new feature is the ability to
> be able to execute a single test instead of the whole test suite. This
> required some surgery on the current code, details below.
> 
> Anatomy of the path set:
> 
> 1: Print useful info on a per packet basis with the option -v
> 
> 2: Add a timeout in the transmission loop too. We only used to have
>    one for the Rx thread, but Tx can lock up too waiting for
>    completions.
> 
> 3: Add an option (-m) to only run the tests (or a single test with a
>    later patch) in a single mode: skb, drv, or zc (zero-copy).
> 
> 4-5: Preparatory patches to be able to specify a test to run. Need to
>      define the test names in a single structure and their entry
>      points, so we can use this when wanting to run a specific test.
> 
> 6: Adds a command line option (-l) that lists all the tests.
> 
> 7: Adds a command line option (-t) that runs a specific test instead
>    of the whole test suite. Can be combined with -m to specify a
>    single mode too.
> 
> 8: Use ksft_print_msg() uniformly throughout the tests. It was a mix
>    of printf() and ksft_print_msg() before.
> 
> 9: In some places, we failed the whole test suite instead of a single
>    test in certain circumstances. Fix this so only the test in
>    question is failed and the rest of the test suite continues.
> 
> 10: Display the available command line options with -h
> 
> v3 -> v4:
> * Fixed another spelling error in patch #9 [Maciej]
> * Only allow the actual strings for the -m command [Maciej]
> * Move some code from patch #7 to #3 [Maciej]
> 
> v2 -> v3:
> * Drop the support for environment variables. Probably not useful. [Maciej]
> * Fixed spelling mistake in patch #9 [Maciej]
> * Fail gracefully if unsupported mode is chosen [Maciej]
> * Simplified test run loop [Maciej]
> 
> v1 -> v2:
> 
> * Introduce XSKTEST_MODE env variable to be able to set the mode to
>   use [Przemyslaw]
> * Introduce XSKTEST_ETH env variable to be able to set the ethernet
>   interface to use by introducing a new patch (#11) [Magnus]
> * Fixed spelling error in patch #5 [Przemyslaw, Maciej]
> * Fixed confusing documentation in patch #10  [Przemyslaw]
> * The -l option can now be used without being root [Magnus, Maciej]
> * Fixed documentation error in patch #7 [Maciej]
> * Added error handling to the -t option [Maciej]
> * -h now displayed as an option [Maciej]
> 
> Thanks: Magnus
> 

for the series:
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> Magnus Karlsson (10):
>   selftests/xsk: print per packet info in verbose mode
>   selftests/xsk: add timeout for Tx thread
>   selftests/xsk: add option to only run tests in a single mode
>   selftests/xsk: move all tests to separate functions
>   selftests/xsk: declare test names in struct
>   selftests/xsk: add option that lists all tests
>   selftests/xsk: add option to run single test
>   selftests/xsk: use ksft_print_msg uniformly
>   selftests/xsk: fail single test instead of all tests
>   selftests/xsk: display command line options with -h
> 
>  tools/testing/selftests/bpf/test_xsk.sh    |  40 +-
>  tools/testing/selftests/bpf/xsk_prereqs.sh |  10 +-
>  tools/testing/selftests/bpf/xskxceiver.c   | 535 ++++++++++++---------
>  tools/testing/selftests/bpf/xskxceiver.h   |  44 +-
>  4 files changed, 368 insertions(+), 261 deletions(-)
> 
> 
> base-commit: 558c50cc3b135e00c9ed15df4c9159e84166f94c
> --
> 2.42.0

