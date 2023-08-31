Return-Path: <bpf+bounces-9067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0FE78EFDC
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286C51C20AD6
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51863125B5;
	Thu, 31 Aug 2023 14:58:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F61170F;
	Thu, 31 Aug 2023 14:58:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29FF19A;
	Thu, 31 Aug 2023 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693493903; x=1725029903;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a2s8MJXRQD7kxsc2FlKpFMY2mTbJX+Ts1LgntWdr7Nc=;
  b=NxoAVeXIyXKCUD7NzfiXeMI4beZvrwwnJ97hNY0paXTvCTTiSLTBftNR
   ZwdKjX7K19Rl3uyLLTB637qTPD/qnYzLLT4oVLuiKYUcNx6wREMvoa32O
   T38P6xy+1e36EzQASXwarIM89cQwVWUXcY0srV82Cp9UD5iq1a3l3zuMb
   xA8/QGu63IrciUazeJOwANR2A+jPnppXI/LZGGfFiCZBPA9A0GSdWjlI8
   XAErU3E90zSdMTh5yB3NT43yOosRW143575g0i3Fvd0jh+LgIgNzIbSN7
   4gEzDfYZGGNxsPPvjczUlC8ydOmvEpbzO/I5w1NmMxFKbcqhQLzGFLvPj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373371701"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="373371701"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 07:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="829727023"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="829727023"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 07:58:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 07:58:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 07:58:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 07:58:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 07:58:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd22S6AxI1st4aQJTs1VHLmM2Es6AuMOQ9HsbCJLSd67KWPUwqnwxw9RIsdXwxz6R/fl4BL2RKYXiBFpXj9wmmepKMoMRipXm9EybJH+JfJM9ZofX/kYiD9hNjlSmtKUENMhfp+saw5CMMhYgFeJ4eS9mv8WjUKssqiN0aJvMJWWwm4L9NYd6y5PXiLZZYR/iWxkPCbDRjC038iCLZ0mKJbDcbiL+Fa6DBmfDpPBEsC6Y7Pjr6DJRuaIQvKqX6NTJYiR7z3c2fPLzi0dxt64tLL6leJOlOZg7Eej7ezKsgTgf0+OAW+ODTvfGKkMA2j3vGzx215Gv7kv6KNs8TJwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0POIdo5MocCTunBLufCIM0iiITfyEhIHE3Hwb7f+p5U=;
 b=dkFX8jljMW/R9Y9lLye2/30bffy6H/08GL0x8j8p9hHKHGWCuxLouMNkn0v+51mFBxY3mqGMjFN3+a1WIX3BN2WzzpX70q8byOg/AxBCJc6iGZTsmQEUFXPRJTff5fwWZazfz7tE6/0QklL8x1StCdpScqfcW9vLG/JksUdGWMKg2xdJ0Mc1c00c9WYAKk1ZscABDtn55zbtKmXcsGipmZBwxecNaD0XoS36cNbEruKyKzcNp+v4mcuPcpq4XVqceip0htsCGu6tLVQ6Jb5bU4jNztM+LIz4mYhJaQPkwgrKii108cd6IWLQvxxE2VBrft0wtTExpHDbTCqNjS7JYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH0PR11MB7523.namprd11.prod.outlook.com (2603:10b6:510:280::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 14:58:14 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 14:58:14 +0000
Date: Thu, 31 Aug 2023 16:50:33 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
	<bpf@vger.kernel.org>
Subject: Re: [RFC bpf-next 00/23] XDP metadata via kfuncs for ice + mlx5
Message-ID: <ZPCoud8HDxiXXbLj@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824192703.712881-1-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR3P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::23) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH0PR11MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: b298c085-2702-41af-b094-08dbaa32b35a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCVL2UQaW8jfTezeBJhqNx07I0fd+e5OGd9jv2VttJx9CwWzVbDm6hhUJbxwALuxnqvqlnv7/hOO9fJkn+5xbItr7f0JJvZjjMUAG7Zp+EOqAC8SV7LP4bHhD4aT2EuAVfOES+qHWumCGMU2JQqd/JvvdQ/tYlAXtIV0pYZJ9Yc+2nJYIaycy9p3j0WtH6yodM5wn3OcvZpgBnUKC0C95QfSkZR0TTXFbeg1A5ZyATLLZYdPP3VAHRCbF1BUATI4eocJqnZuVqSvzbn78thRLvaUguJEWFOmkA3B8M8PqANILmzWeF+wEJukzy5jFgquH2OF7AELpmnVAyn1FfwuDsRTUMYJneWGbWXWaDORF3KW5DFUKMWKUiAH5kPxyEy+UQfNzumzsbgs2gokLpcETBKFLWGK85p4I+AnqT7OII//6wWeAgLZ0OFJYaBf0c2KUusjogGkaWWaD5CuBCWmhiMnu7YyBIVzgXXU00GY3D/WUg4Eyqkt1JPeGzd4pyF3wP9g440+8AFUhd4tEQ1nxCPAYS40LSRb/maSCdqU2dJLL0ZLozlBeFhoS7JO8COLWBby/6Lp5w+9GkGRqk6JWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199024)(1800799009)(186009)(83380400001)(8936002)(4326008)(8676002)(6916009)(66946007)(66556008)(66476007)(316002)(54906003)(5660300002)(2906002)(44832011)(966005)(41300700001)(6486002)(26005)(9686003)(6512007)(38100700002)(478600001)(33716001)(6666004)(6506007)(86362001)(82960400001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DPal3knckCpP2Xd10T1zUV38D0Dext6+aaJdV5ZIFGa3fO7cOE9JEjD6qDTC?=
 =?us-ascii?Q?62gTA2KFKyTB/LkyD2RoucKHff4mehoK1Z8w5W1RTQ37s1AXMqdgNJeLAben?=
 =?us-ascii?Q?9RK7PH40KntVFSW6sCkgK1TivBvjcBgI2c+iutL/5sFOTUf9hzkZ8fWUXTK3?=
 =?us-ascii?Q?TOqLgaszck3cGxjnwYZ4vSH6ANxSQLVGDlg/0ghmGh1AHzRVsGeD/H0A3dt8?=
 =?us-ascii?Q?5UKOPUtQApDlgIoQY709o8myZTKRocVV2Jj6pOr2/SOKLPaxHlb0Q74oJXMW?=
 =?us-ascii?Q?h1+PEZZckeGDfbe+iiD7bP0Agreifj/6cTJA2yz9D6mJxsOBphz4LLOiGeeV?=
 =?us-ascii?Q?ymnYzelztYjnqqudHDZTw4EFh0asKneM6TTggt0aw1eEo87kU9z0yODMckXU?=
 =?us-ascii?Q?6tIhZ7sD2++sSxtVsCEsIaeiEzGI0tUoMIht9Wmuk/Wd1druXlxh/Su8DkUK?=
 =?us-ascii?Q?ZZH3rVIELFJJE2kUIrqtZbmRh87Px7QVOL5LNuCrm8H1dsLnIfAwCtbA322H?=
 =?us-ascii?Q?lQnKA4zu9O8fNPnHVpW9aqMX+2cbBpLMPkZvFWRlKSu2LTL+kyNSIM8eynlr?=
 =?us-ascii?Q?dpCpIN0eOHBD9vCOa987RawWQddXUJU98tD8WcgRRslgur1lqspu5bPjI+rx?=
 =?us-ascii?Q?ADCa1WTybggmmFzEThUjIAjsAEMsEHCNhh6Fbt9XaR6x7qxKDiHH6n7L4l65?=
 =?us-ascii?Q?Z+LOJphMzXwbYkJmTjyH7xg73PynZB9EwXZk4U8lZCdo1oZprAfsEfaSXNzN?=
 =?us-ascii?Q?Ow59HMzjD7+h/c1+cUzm8muFhMUK0hfQ+xMxQbPDzCj0bfp15UsYF1GiEjyL?=
 =?us-ascii?Q?TbTILmCvKwGHmbSrBK35F2HPV0STytQ0Ut0yc1IEGE4G2YabIPPtK728vYoE?=
 =?us-ascii?Q?xS5kVMobPOb4t0OkUWT4mbESP46kAp9s2C6DQkbkp6N6Ie+CSiq9gEjUpirP?=
 =?us-ascii?Q?62LsdvCBQAghdqWq4yxKjtsUFW8vzlNjYVuBQuJ52rZGwvek0xHHxf/31OHh?=
 =?us-ascii?Q?DINdFA7tpDvw1eV8C8P34bQO7qH8kxN0Eot4xD5lPYP0Gqp2y+tb4V/aIhYp?=
 =?us-ascii?Q?BwfckG2cCuAAKrGda/qgudFReFUIxVs8q5hLGasxWbibAiF5Mp1jmle/W3GP?=
 =?us-ascii?Q?1S9Yxuj/5R0Dh8v/SQuinlgJEgmST7NOfDoo0vbAOOf4iMoWyu4cqjszqVX/?=
 =?us-ascii?Q?GEOnMslFOuDlUxUME/Q3zfVco3+JeZSxcWuKA1JC08MRVIZrMqvgHNqa+hyx?=
 =?us-ascii?Q?WcQbVjG6n427/+Dz9wak+kcJFsvFXsUSwKxmour84ODHdpTwny2uL/5HEMbL?=
 =?us-ascii?Q?rFX6oQDEdYEwF++Qt5cHoMiitcAwmONc8D268IXXJCxkTlm0a3pmfJEt1md9?=
 =?us-ascii?Q?/udAl6GG2Mb8FqN33FeNGn27K4pJTCAI68c2hRqRHCKgEhReYmDXOL+1oJMq?=
 =?us-ascii?Q?onk2d2YeCMDYVsiMMRhL2XNWmx1neNW+jQYgHQ6VCvpvfrAmDaLZ0YQItOSv?=
 =?us-ascii?Q?hbhxn4qJ7YA2GumUekSHrMLmLgXRiw0ejjRh6jHyCrYLKQpfQQIzIRnjceyB?=
 =?us-ascii?Q?JAN/2FeETWUKgxfKwv8UuBrAkq5LZESE9R3VxVHDW3I9b+5Wu1G9QSTDLGuj?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b298c085-2702-41af-b094-08dbaa32b35a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:58:14.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6QF3OvOneiHj2yfDgG2gDECmwcZ00rVQYWcmLfTMCTvQJf1sN+2NTcyozclAIL1pZaj5HfczTiv1OqpyqYv4SFAyEFwxJE/zy5h/C+E9cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7523
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 09:26:39PM +0200, Larysa Zaremba wrote:
> Alexei has requested an implementation of VLAN and checksum XDP hints
> for one more driver [0].
> 
> This series is exactly the v5 of "XDP metadata via kfuncs for ice" [1]
> with 2 additional patches for mlx5.
> 
> Firstly, there is a VLAN hint implementation. I am pretty sure this
> one works and would not object adding it to the main series, if someone
> from nvidia ACKs it.
> 
> The second patch is a checksum hint implementation and it is very rough.
> There is logic duplication and some missing features, but I am sure it
> captures the main points of the potential end implementation.
> 
> I think it is unrealistic for me to provide a fully working mlx5 checksum
> hint implementation (complex logic, no HW), so would much rather prefer
> not having it in my main series. My main intension with this RFC is
> to prove proposed hints functions are suitable for non-intel HW.
> 
> [0] https://lore.kernel.org/bpf/CAADnVQLNeO81zc4f_z_UDCi+tJ2LS4dj2E1+au5TbXM+CPSyXQ@mail.gmail.com/
> [1] https://lore.kernel.org/bpf/20230811161509.19722-1-larysa.zaremba@intel.com/
 
[...]

Is this an OK approach to your reauest or have you expected something else?

