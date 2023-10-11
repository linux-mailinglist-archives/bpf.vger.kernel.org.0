Return-Path: <bpf+bounces-11914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0F37C5523
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 15:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EF51C20F30
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 13:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF941F929;
	Wed, 11 Oct 2023 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zki4uk7Z"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8A1F5E1
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 13:20:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA66493
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697030432; x=1728566432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WUo6042u6nV09WKbQal9S8/EXQF69el2Y4WuoPQT7OQ=;
  b=Zki4uk7ZFkuJvM3qEEjQ0JNudZtkYseQvWwE6fDeUI3UTpwFKPlQZr9e
   YldBZurwo/PuzX2nK53ptWfQXerazdRqFGWdAMxhi91vPQ7lCDnZ5Smy/
   j5ZqlnCU8xG7zWOcGS4Iu6BQMuymaO/chjyKGtJ5HORS5oeLFicKX8JRE
   HWi9o0Bo33cfFv0dR//WbvQEDYy5DFcX+pofmdv5TMA7t+FMBBS9iMZlR
   lqHDlyoT5PXwFm967bCjTpBdhVvfNvPDLbvRBlwZnGpVIqtuKmPSlV9yE
   OZUTfqK2P4rXTREIUnWc0Y/FLVxmWs30o2Jte/k04Wpw0S475QCAby9nO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="448859868"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="448859868"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="788989263"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="788989263"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 06:20:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 06:20:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 06:20:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 06:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVHzHlb3jqZuoat3J8HZx5zto5sA6kyzttf7HLY7WIJG4ONyfyVkG5AQnV/p5JCymxP6CiNY0tBT64Wu0o3aM/0TGn/R/lPZ2UYClX2FEIgQQ1L2oKRjqAVZktG3YggBGoXiTV60RzgIkMWiw9G2SJEbpc+MBDoi/f6nz61Bt3uRmkogLlm2FfOd7p/eJEwVoz29bqXiq8PrEIZ/6Gtc2IvkxwLDpFPWYMHtFF3wdZ6yoG4FkzhVr7/CDJ6w45kZl7pZyA5TegoTIqvzluuQCbtMpE+wHwUYBEAUQEIDJUkr0bftpYfe7DZmDnCrTmX+CvQsBn7/rdygqFVr6raSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Pe9oxtaIaHBzPzZet4E0yM91wjZyj+QUMWJWPEJX4s=;
 b=bNg3YgdH7KRNAJWhD5mHtnydl4qUv0zde7ccU6w0FbJuwStglrlTpqfI1Ns7VL40CCzCJTEbX3gvXlI8G8kIwWMLXAmTh8XheWe5MTRZtTwU0uIwkZOfiV8qFC2/Qs6mJhSZ8YGj8SPCeyqgG44fDc3+aNMNc+h4xiI/6XTsQ/qzhtUnhxJNaNoXXc1P5Pvomp1/RmgoyrIZz/zBY1Vzjw3wsJte/7NAEl9HpZi7ZW2YVRqB/DpbaahSEKo0WTwu4kOiI02pp7tfhb3PP2+0Zn1DjCLNljecJAIMS9bJZ5B9j7ndVHYMDNFksnKmCj/zitvcU3i0EQZv8Z0swKqSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH8PR11MB7094.namprd11.prod.outlook.com (2603:10b6:510:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 13:20:28 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6838.029; Wed, 11 Oct 2023
 13:20:28 +0000
Date: Wed, 11 Oct 2023 21:20:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Puranjay Mohan <puranjay12@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>,
	<bpf@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [bpf/tests]  daabb2b098:
 kernel-selftests.net.test_bpf.sh.fail
Message-ID: <202310111838.46ff5b6a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH8PR11MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee9c9a1-8852-4b65-1af3-08dbca5cd5ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AmciwUw63v+knudboLlpa6GaZn7dnvF5XVdpYlq2sz/cTZIjE7neICy1fj9H2TFT5u4Sq5UzcdkKEOYsuow/kWu5lVhTVaQKUod5kjsacRozSFn0Cj+7YOZs7zaYS14B87qNMXw+7DQh3c7OiRckOQeC+Hyg/g6p2dw9JOY8C5FRm/+6gMZrK9FtDi46bB2kw4UpHuF0THxEWW2YP7/Bfahts+kJbSOHjleu0jz5fsCvmNmlfYAlTozJSrt0fApaxFRRWwUEkUrA9fVRr0jPlO0KfD3Ah0WCovLgGXGgWN9C5z+ozU9D5gA27b4kAQeJKt0qSDoNOlCkj8yPYsPiWZnbjd1SENlBuJR8ccE3ud/srbY/+MSMu9gSRrVX/eySffPdYYLIWrXV5/lk40wvqE7ga1NYlYfChQOLoNEPTq/619wvOK2cIiGQUUg5thzc5BE7jjNrFIFmGYSF4vV0rT8dZvGwtFTln5rwyxEAcViaN6WToajXPLksWEXbZuyxwmXb9vEpXV3wWcE2NBRb6y7BGJXhnCcYnQrW1ou83l5rHRjEPaZa9T4fAnSQUAh9hKcUQrDNRXGVy/lI6A2zzLkfmtI4T3lcVD+yUD+Tw5AVl7pVClY0YMbt9HPZUV/b7M/Qu6DX5zNCW/pv507PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(26005)(6512007)(1076003)(107886003)(2616005)(478600001)(6666004)(6506007)(36756003)(38100700002)(82960400001)(2906002)(83380400001)(966005)(6486002)(4326008)(5660300002)(41300700001)(66556008)(66946007)(316002)(6916009)(54906003)(8676002)(8936002)(66476007)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5+LF/WiWkyc44iS6gXaRt/ol9k3sAXlclbqeOqYmSyWDijHhI06pAt4bcSm/?=
 =?us-ascii?Q?A47XQvZ5SdTGVHXzDZAxs8TJ2DpEXteT+Ouhd9lJG7+19gerOlM6m6J8nHK7?=
 =?us-ascii?Q?G/Et0WkvvqY9giOffxR35n+Jg/UWLk7g2q/KDAHSCBQPRKBrDf5UCqm5YlDP?=
 =?us-ascii?Q?4GZ/iNjsAhhWjYQexhXK3+4Bq157scXWAl1pbZtKr4ZpnLb0FdXsJQU9ssFB?=
 =?us-ascii?Q?mpLHWSQcCatpq4IfFxk02P1VY3os53Fb7h7BfW86Uiocr/VtgtmF1sHgko8l?=
 =?us-ascii?Q?gcTmUBkVVrEskmj3h3QRBdVJnZfHhYf5TKkiWUMWwsep1z1LGDW8hk1Z59me?=
 =?us-ascii?Q?TV9EM3Qe3I/X9GwTGyv4fF/kzwRcQOUr3U3z8CPkeDhgy4DuEaj5bPWa/yo7?=
 =?us-ascii?Q?nB5GHrYhvpN4wOmXBMOUYMAsLsmW1K9tOpkRJojIGICgRDZRbK69x8B461uv?=
 =?us-ascii?Q?RkPtE+fJANmf4dGODDhStjU8SS9ra3ZrIMpKoU9prEG+Gee2kzuOLXiA3XPW?=
 =?us-ascii?Q?kHSyEnBSpa/DE0oxmcjAscekbMwY4dgbUKqNJRg84NR+NayvnqaXH2rmzT3F?=
 =?us-ascii?Q?EE8XwReMCZtJQnNOGFcJde1+hpM+rMgKqcvnu+AH74r2n5YPjQNiSRyxOyvf?=
 =?us-ascii?Q?7ETAHdtJ3isGXDM01+SIdK1rCg2jtkhc+lYttTaRr1ixKoiXm4EganMj/9Bg?=
 =?us-ascii?Q?2pQEH/a3wIOlpIbunBsq09t2vtcQEFyo2GP3tjVzp9Ld8HbAmF/HMeK+Oylw?=
 =?us-ascii?Q?fTDXMS0dIZ0K8QbQMJCctR7uw47eV83Xp1yvxZMyZAclbHISOyBptxnntA0A?=
 =?us-ascii?Q?dXeUQZpGip5Agyu2x0haPe6xCfa3UbjqXTTQ6+OghEwB8CUBSy/0OFQgfUrI?=
 =?us-ascii?Q?pNqZ0eg5zb4qLsGl4QG/GoFYKgKCwhLmaypDPfSakEEuY7DQZODCSQgHs8Vs?=
 =?us-ascii?Q?SwwG8G1F64TdsHm3+NPYzBzB1JUPdCpm7Wzk66XiF+AWLyGPLfCNkG+LHNjc?=
 =?us-ascii?Q?mWGBghhfQ1SBeW5G7k5cjkW1nv19Hxrcpcvn+Tem+GBBRwKVucLNPDBXqfRh?=
 =?us-ascii?Q?fjOoxUIsK8Rs/RMwK3jQ99QfMElGouCiBA9JE1bzZpmkRa7gPzrXaJy225Ex?=
 =?us-ascii?Q?5mElfSltC5wj9lPJmyH76Q6RIqSqu4QnxQIV69LGd/fIDzRqNkPuNSKGxfaR?=
 =?us-ascii?Q?b3dtqpT924FWNGmMCWxG0fvOorUwDLwGndIhb0i/SUHyPyCEIp2RzjMLcg+j?=
 =?us-ascii?Q?9JbKSk5feaHtR03lAdo7uAMHvwMvb4TKINfNnviZ4nUZPAllKwPn1SrvUl5h?=
 =?us-ascii?Q?uXI53aYDg3VDorH+Ulfhw7arHc+Q16segmOsC1RTx0gx6+jPa7QrjTzTTwkD?=
 =?us-ascii?Q?g9VtgFuaF+mxMVI7q8VujUadVS2viOsXOw50zWkh1M+gmpeJBNB4qPb1BfHo?=
 =?us-ascii?Q?M6MfYYe46ztkBpzfzAujUnzSkL0zePLUOywT4UeEuVVcShSa3SL2n8NWe1d+?=
 =?us-ascii?Q?Sipj8sglmCHXSo3GtyvBpHDOZQcN5He7Nx01QMqqF7fsfnVSXxlmmg4g1J82?=
 =?us-ascii?Q?5yWjezzgBvT/zS2bILGwbjVFTzP79kw1GKvoY9v0fqzsE4MN1eO1XmAIcuwF?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee9c9a1-8852-4b65-1af3-08dbca5cd5ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:20:27.7201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iU3c4H4XULWdCqMUoqDXD6c2vxrKGVOjZmLtFgtzUQhJHoSuNTOnDcWp7iMpqOHkV1fj00Lfu88SZSAc0ujS5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7094
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


hi, Puranjay Mohan,

we reported same issue when this commit is a review patch as:
https://lore.kernel.org/all/202309261451.8934f9ad-oliver.sang@intel.com/

now we noticed this commit is in linux-next/master and we still observed
failure.

is there any requirements to run new tests? Thanks


Hello,

kernel test robot noticed "kernel-selftests.net.test_bpf.sh.fail" on:

commit: daabb2b098e04753fa3d1b1feed13e5a61bef61c ("bpf/tests: add tests for cpuv4 instructions")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 719136e5c24768ebdf80b9daa53facebbdd377c3]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: net



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310111838.46ff5b6a-oliver.sang@intel.com



....
# timeout set to 1500
# selftests: net: test_bpf.sh
# test_bpf: [FAIL]
not ok 13 selftests: net: test_bpf.sh # exit=1
....



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231011/202310111838.46ff5b6a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


