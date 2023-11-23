Return-Path: <bpf+bounces-15742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25F37F5AA7
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 09:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C943B20F60
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BC71CA9C;
	Thu, 23 Nov 2023 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="io8Gwbtr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC515F9;
	Thu, 23 Nov 2023 00:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700729864; x=1732265864;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=hYb+L9/0ObbT9a7FjwBoKSzRV1KYpKDCQH+fK8KoBbA=;
  b=io8GwbtrT6v32EhZSoE9UcWRBr0+q+zFbGW+uljDLKv63HWSoH/uMVax
   ijzE1PhaCRca5jD9JQE+m7v1mWIfp0tD9VE8tQfLID7hnRZqaBDBA16tw
   8MTiXNGi5Ch0+ieEk+xRHAA3OOP9ITPKxzGSyEwzCGfip5TlgNn0D/yQ4
   3wDytypTvdaXKOalurtzxbPLDrH+3UmR4i3XmNBYpTLYhmH13nLmCu7dT
   FBrfXHW+1EsECIqQDYcnqjvZg9KE5yayZh/fz6FsVft5wqjORRueb5PFF
   Sl94YFLd/YByJ1RTwNsAc7UC/tMc6srG5fdiUHqfrCjL+uT++92y1yvut
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="392002455"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="392002455"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 00:57:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8597661"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 00:57:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 00:57:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 00:57:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 00:57:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfH0j/jD06LSt8yeRLewxjUK/9vOo9NtpJKOw4crlmgYgxrfqGrAuM3jbS33GIRgTo8nAIHYgBqGIeD/l9ZEb2sFqM8fSkUThab+GYVZsRpgD3EQlVOBEylNw80kVJ3n0MF8oNnmEheFrGEU6v2iZ+ue8uPr26jgfnnfTmMyIp3hGEnm27/TxJsgTRsT4PQ5K31pCyXyeHDEt774pCJdz7dI08mwibEPm02IB9gpZxa2sBzUctLKtKd00TR259rO2dUetROQjwfkgDC4IaWVKZwL1NrEU5DXTi9b+adH1qMNaj/iTQJFX1+UewVR66ldDWEKRfWzQrSjvWeJ2isN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyRnAoNT6fjZs65wOH6Fe8Ms/0NpqYB9+NbRqTKEDO8=;
 b=Gvn3QIppcOJPdExFIxn9EwjboYBRbDc6JPUv4FNZCceQLWnPUR5kadMHwkwnLmn/zFHHc6k9jkhYsP6Rugv2DT2KxJmtyQGh9TVxDhnmbKtEjAPBI/NbJvJcAPy0Jr2MGXSnUeyZh4uRR3K7lePqrhGJVPuHXAjCbF0bjOTBGreooTgRqE+DsxQVcwkRbGKEWBAE3fc9doIYTgh9w/3frPztQrArySpzePJ1sBc6XAvWBFx6M3DrlVZ56B8pJpTD5bNakxYBWBmAHcPgBL9TjVXj3FEnJc0qokyC1wolCG+/GyUMBy29NG2DmyCbhK+pRp1eHOiO+RdQD85dysWi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DM4PR11MB5440.namprd11.prod.outlook.com (2603:10b6:5:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 08:57:40 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 08:57:40 +0000
Date: Thu, 23 Nov 2023 16:52:59 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <oe-kbuild-all@lists.linux.dev>, <andrii@kernel.org>, <ast@kernel.org>,
	<bpf@vger.kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <edumazet@google.com>, <haoluo@google.com>,
	<john.fastabend@gmail.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <martin.lau@linux.dev>,
	<mykolal@fb.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sdf@google.com>, <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 11/11] selftest: bpf: Test
 bpf_sk_assign_tcp_reqsk().
Message-ID: <202311222353.3MM8wxm0-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231121190134.73447-1-kuniyu@amazon.com>
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DM4PR11MB5440:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c77c87b-1a85-4ff9-aabe-08dbec023f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MO+r4WcoBxzUkHDv4kY6dst2RdMNAoIAyNxn9PhpRNNkmo8kS11QkIdvsNXZMTIkqMj2bocv3DNMbJXdRdXpa/m9IIeW7NgftRmehywp9jDMszPOXdlbEgE/+ILl/RfLekfLN2C3JxV3aO85PXbKmWdF32cnJvj2LEA+Ao0qycpmW4e/kkeT3fHWdCyCia6kQZK61uuEZLpoSZyIzCA+0YzDVScnexeC43Q5J2AMTqkRVOpEfnXe00tsrq1vfGK/x72aWlmVtd5mZ0AyesltAwrt5+U1xsG1bj40IhSMztEID3Jqw2PCQKy5jbRp/j3j7gvn0yRDdFzqeTxJbWGSrlwbOOKrtFMRwyK6NCLHgCGuM0x0i3jOgUPwR6d3D1bFZqUkj3RD3iKkMdaAkhgXj3Uj5CprSqBcwtBTI4Yxekkk5DtqsMEeaJmIoL9yie2SyN5Len2FiPD6ENc/WpSlkSJ+hBXD/EW1m/WQwYU+kSkXDViVuXoI4iyA/5JS6cpYfM2UUNLYZuHoWCorjuQ5oTyE5gpuud/FPs+VYgH0XyVyCX6yfjNV/mjx6ds18BgaN2CfFSgSgZY0yoQfOH1Fyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(7416002)(6666004)(4326008)(36756003)(8676002)(8936002)(2906002)(86362001)(5660300002)(41300700001)(38100700002)(82960400001)(26005)(6916009)(83380400001)(6512007)(1076003)(2616005)(478600001)(6506007)(6486002)(966005)(66476007)(66556008)(316002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KAWJpmQOJYkGXOoYlwA1PYbiGFOvA61EfSRPAk2GT+zIJIybS9uMBi5TZN1U?=
 =?us-ascii?Q?yj2XmL9UNZJ3aBEFI81bx2sy3o+71n1rq1hXSJcECeZuay4yT87ZoH0/YC/P?=
 =?us-ascii?Q?Dx/MLKNbhG7ml8MrnHiywigphrYBDKjMvzrfj4Ncv8GK7eODB9x8RA8osybp?=
 =?us-ascii?Q?rJgMDczNar8D27aTEEzzbQcK1hOTbpPetR8f4hWJlAmc16xwFH8+YajTfygx?=
 =?us-ascii?Q?ckDpE6b2SOZvbCJmDw/MrO1Rk6ZqZEI9O7wC4UX7uChq0O/RjRcfyK4Zc45U?=
 =?us-ascii?Q?4cjFrtFMWg6n/zjPw42jB+EY+GCQ2UWzvwYfBESL61LAafRrtyw4Jk94dxpq?=
 =?us-ascii?Q?haQAziDbBtb1lW1YRG/LmGwjCJFlXUD+LaxTeMMBYiKWGsxnDfTjMZjU4//d?=
 =?us-ascii?Q?4WCT6qR5Vu7YTl8SD1cL6VAAhZy1Xd4pBSKDu2APX1gUJ962wTzqQhMy1W6q?=
 =?us-ascii?Q?6OKiRLLpw/Xu/EawrtAtspVFfrt74eGApOzlu/ktZRT/RFvV54fbFCULlR0/?=
 =?us-ascii?Q?0oBFasKnwiuHaKNC3wuS1f8nFUKTtgsZ9hPKG7J8zWWtZ+jy87mJpiUMlw0V?=
 =?us-ascii?Q?YgFTom0i8zVQDSESH4MJ7k6xSxM2+pwlAxbLqPCVra9jr06f9noEU8x5B2G+?=
 =?us-ascii?Q?JOuQ4DE77awVfanQpPsiYl7gtZDzksb0FQFOApNibqib0lDx97Uc6n9/UE1W?=
 =?us-ascii?Q?zLGXVOoCeGQxI6N5l0slekrh0NuVNA+R9Yv7JMePuYuvbf4qiyKe1SE5gL+Z?=
 =?us-ascii?Q?i8kr/cDmpFm5BJe/WvKPqM/Qp8bda2gDIhyqBC0ysNRsSwTLNeA9YI5N69HV?=
 =?us-ascii?Q?n/3lZ8zCrrhYNLok5wTEYJfIgx7WA4aHDdzzgC0SWUZnKHoU05OUZA7/u4xk?=
 =?us-ascii?Q?maTdkuTzHkUBpaAFF+bIEdCMyjIi3SBEVxTL68wHjzLFAG1KTxHcVQDQW3p8?=
 =?us-ascii?Q?FzNlrgQnyp6X9rprc2b7Dy0VBunLldrTsc24HHbfvqcUcMiXmtVxGKAJZqNz?=
 =?us-ascii?Q?ydwvKVBiwQdoTwpdDVJYq7V+MfwH6E6T1Ozaa+P5MyK/DGfXo/bW4qIOSSCV?=
 =?us-ascii?Q?tZz3tUwOYVM/zcHSwjxinQOUkPIbLnc0G9wZM1WSmOvkdm7JQV65wt7ozbkC?=
 =?us-ascii?Q?+gyxCksSGF5uDVHfQ/L6/JnBPJNazW8mLZl6O7SfVPNGEDDk0gPQ1cv7D2Co?=
 =?us-ascii?Q?lT8mWwNXGWRxSLhFedAq/gAFNbLylfJqa4RDM4EqGXkc+i7AEQnHL2GcVsZq?=
 =?us-ascii?Q?LaoCPESCWPr553UiS8fDWT1VPce7dzhBmcbzB5sdYpMywnX5zold1sJ1U3gt?=
 =?us-ascii?Q?0BGrB1e5IWrKe+/W/kfexWEFOswb085EslIiOmfkY7JxfImlLTm/Ppv/aMcx?=
 =?us-ascii?Q?U4UcIA8CExryVyvcjdZlTwLHd6xS3DL/RK7tMLB9xKc1lS72xq38EQHQ+uI4?=
 =?us-ascii?Q?somUcCqlt9UMH4L8sFdvzq8YIVTVVe34JAK4r3caXl4AiICSNgAwDgVEe+80?=
 =?us-ascii?Q?oUYr+Ef42eaZudqtxjj+vZcXBzcCx2T0Ji0wa7TckBGyWD0EgXiFwmK904pq?=
 =?us-ascii?Q?4//JWqBIOlcEMWlorhwWNCqqVF1u+OQJ53yOSgE9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c77c87b-1a85-4ff9-aabe-08dbec023f35
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 08:57:39.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSGximCflB79KDLMEv34ipUm17kMezFlkHcnO1t7Zmfjm2OO02vbOlM4HGOlKAAwZq+6qA8fNxsCtfLJN6XrPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5440
X-OriginatorOrg: intel.com

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Clean-up-reverse-xmas-tree-in-cookie_v-46-_check/20231122-030405
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231121190134.73447-1-kuniyu%40amazon.com
patch subject: [PATCH v3 bpf-next 11/11] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311222353.3MM8wxm0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311222353.3MM8wxm0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> progs/test_tcp_custom_syncookie.c:63:31: error: field has incomplete type 'struct tcp_cookie_attributes'
      63 |         struct tcp_cookie_attributes attr;
         |                                      ^
   tools/testing/selftests/bpf/bpf_kfuncs.h:60:8: note: forward declaration of 'struct tcp_cookie_attributes'
      60 | struct tcp_cookie_attributes;
         |        ^
>> progs/test_tcp_custom_syncookie.c:514:57: error: use of undeclared identifier 'BPF_F_CURRENT_NETNS'; did you mean 'BPF_F_CURRENT_CPU'?
     514 |         skc = bpf_skc_lookup_tcp(ctx->skb, &tuple, tuple_size, BPF_F_CURRENT_NETNS, 0);
         |                                                                ^~~~~~~~~~~~~~~~~~~
         |                                                                BPF_F_CURRENT_CPU
   /tools/include/vmlinux.h:104429:2: note: 'BPF_F_CURRENT_CPU' declared here
    104429 |         BPF_F_CURRENT_CPU = 4294967295ULL,
           |         ^
   2 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


