Return-Path: <bpf+bounces-1009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E23370B9BB
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 12:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E531280F16
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 10:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C267FBA47;
	Mon, 22 May 2023 10:14:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8CBA25
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 10:14:17 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128EBE;
	Mon, 22 May 2023 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684750455; x=1716286455;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zimm+zlC37q0e2lM4tPRNJJZDUeZb2KE5K/IIwpG6rg=;
  b=d0omnm5iQcJs2Z9VacbC4RPk1J6fS7KHc+0yAv49EDhS36Cjy+NpLfNK
   wth3hpKYPm7xJ1W1IQeUp5odazBbIAyqmNEXFMKJnOkDGUCMrQL0dQA9s
   YUVmu7j7KdkEg+shwIWBzKwNbY+KpSrXfMGIPN+lOselzd8doOJxDBoF1
   HtvmK1iPijll0laUUBM0SoJTQaMoggDnozZ9Iy7NTKalYtGNiByFIhUqV
   Zjs6tPi40jEOtOT+MAPL5Spj4ST025ZpfZp1Zu9kGNNNr81l89DPiUFT5
   J3PEovpCsmAvIdQ0jMQnFjpeN4W2M//HDOpIPYyeMzVw7R1l39I8Nz/Mv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="356109758"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="356109758"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 03:14:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="815627120"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="815627120"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 22 May 2023 03:14:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 03:14:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 03:14:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 03:13:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ab5cSMN1OxT0l0RJ74n3K4FX+JPPt7sHxmjbkYTElDmg2fFBR2EJjI/sWBZanZ5BNIGLn1R844AA20m7NzCwLlhueDkpZK+bD0oh4FgUX3sBEYHDvZZYFlBvQ9iyaYrCn8TLYImOdNeaCPZK/yFEaKoRzbMnC8lLgtxEZx3ZzaBpCDjGSLGS3LF7YrgbZWH/Lalr7NoSzrHS3QZtfoT81ShdsKgKS30SlNk+zcaljt9iFjDdGwi+XjQiNPjnu9LA4H2GXjasPFfXgGXJcW1LNCq8vRAZ5Rzu4D03yKjYponZEispaBvPtnm3/UdahdC+h5//Q/+q0EPwG9+jU+VuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YjnAcqmWFGLNgTQxpgMDJXc1taIffJUP8M+bzTF1xM=;
 b=A7soV3tkqKRqiWCCF7LSgdLkHEefr5ytFNUrB8pSSwPdFOTfs7WvIaHtB3Fl8H49GLOFcQp509CCz7RpF59yt3EG7FU8MjAm1RJkijMMmKWmhDSwDywi9Att5AGXJA4DpgBVcy9NpvrSdqcOlRRNMKkjikL6SZw7S46LU5ELfIpu48wOKsx3HC6stZQ6Q4IYnaiYmZmoHjYGFVnfyfId91uVj6bxAU0rEruY29MUhyfYUbFSxW2GNAZasouj39q2xSdQI1sY/YzskbpGpJsnVeFnQNjd71EoOBcnuQD/NIhitFmpuiF6ZJPp+wQUh0kZU2uSzHT2X/7Xg8JmtE2lQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5471.namprd11.prod.outlook.com (2603:10b6:5:39d::10)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 10:13:56 +0000
Received: from DM4PR11MB5471.namprd11.prod.outlook.com
 ([fe80::907c:ffaa:352a:8913]) by DM4PR11MB5471.namprd11.prod.outlook.com
 ([fe80::907c:ffaa:352a:8913%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 10:13:56 +0000
Date: Mon, 22 May 2023 12:11:12 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Quentin Monnet <quentin@isovalent.com>
CC: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	"Yonghong Song" <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@corigine.com>
Subject: Re: [PATCH bpf-next v2] bpftool: specify XDP Hints ifname when
 loading program
Message-ID: <ZGs/wOvSaM3Ackzx@lincoln>
References: <20230517160103.1088185-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230517160103.1088185-1-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To DM4PR11MB5471.namprd11.prod.outlook.com
 (2603:10b6:5:39d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5471:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 370fec5c-bd15-4a29-b64d-08db5aad405c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFG5l8aLYVGcNR+N6YW5t4QSzvcAU43fvKfkXFnXe+0bwxc/hme//4IlD91YW4njdzssEHquMBeWwgOWAe74GehNKtdQnmqWUKZ9cP4AqkkFWdiSMadYkjgAXcDGk9UjZT5p5BDACPJNNLZGhNd/jBoEEjabqYcGEFVnBzNpY2wFmOHl5fzUebKBzKW4wHzGKliseIqLGNCFYexAjGWdzpXW4h2/ZycB90T3Nls97T0ta9AqvGpR++JCQn39ec/jf2sVaA58CQp2uSaROrS8SxOKpywWXZOpmOGNCX6Vw4vTsWsEdkbSnOn58dbVUii6Dq22+FanDQXfF2UCk+ou6/XfPfMTFDsyaUDp9vNxjEElkpV5r9x2/QALsKJP4JqTIdLDyat4B2SEQX6JDSR+y1HA3txEtJp5iNfgqHyqPlRAv4kW/x/d3I09+ttUNtBMOrjom0WH26qFEbkB5xN0UDv6Or4eMVFos2YZI1/QFd6nm7MWq2e0ZuN9J6wIFHCyt88aUeVtXg+SLdJFuBHXEow2ZXLxhSZJifHDLjJlZeydlY77KWWJUOIOtOtfHGC/mLlTcuiVPoObjf8NBh7ODw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5471.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(8676002)(8936002)(44832011)(7416002)(5660300002)(83380400001)(9686003)(186003)(6506007)(6512007)(26005)(33716001)(86362001)(82960400001)(38100700002)(41300700001)(6666004)(478600001)(6486002)(966005)(4326008)(6916009)(66946007)(66556008)(66476007)(316002)(54906003)(2906002)(30864003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OHmqlyZEuBLFO06bmcmIyqGi3+HNETnhlE0egHIRBofLhuecpjBdILs4BOYf?=
 =?us-ascii?Q?Ag3iguVF52vDvlrWJe+Ross3uWaJ5XKgfh3L23CLA51jPwli+ai5yQwghT8p?=
 =?us-ascii?Q?0YlmwaobFdQjj+5/2EmTTDkzpvDRLDSBhWvcpv12kG80Z8+JQIE45t2bUOhS?=
 =?us-ascii?Q?2MENjZohkKUUStcHoif1QUABur+GMLi7KQm2Ta49l89vR7jR/T5OcfIxHloY?=
 =?us-ascii?Q?tUpNDaK1YGxdVh9TUIh2QNoSLm4dgmHUqg7p5jnywlwcnPtqaWNAaQDcM9vY?=
 =?us-ascii?Q?jp/h41c3+JuWIVDoewaiINkNW0UsegNmRThtAmOJ78an9wKTCuc/wqAzXTTw?=
 =?us-ascii?Q?O8BwsuPVaMfdD948noKJffD2XZlnuH4rlWa3Iii1/jL+sxpi4L4FHEbXUR9S?=
 =?us-ascii?Q?YH3CDloz1veRnPivIvrv7RXPi1hq1MOffaFkQh44hDSl7RqEx6ystXav2lPm?=
 =?us-ascii?Q?5n27Z7ushFVSfXmLhXHpA2gAbDtRvtNtKNEpIzXfSeG6RH9h35RlXLsZzEHR?=
 =?us-ascii?Q?TrkHjakTjBusE89r5pft423viB27u/L1wVkdyafHEJkxt1RPLizfLHI669N8?=
 =?us-ascii?Q?jvqRq1jq0TZir/QmKLSELO6Pr4A5R7oQ+0cgssFVE7IRuvjPblPhHjUmnqc5?=
 =?us-ascii?Q?nt2IPva2zDLz+AXPiytm8fUM7hFyDXsQIeDcIiPY7d2hSpWskxCMc9KwLA7G?=
 =?us-ascii?Q?ZxZ+PofUZkF09GIED0tHPqrL5lf3oy5gWu8IGHXGEGG7wQdqKare1ydzfZtn?=
 =?us-ascii?Q?GMU5UQkZSU2MpamtDw7PKuXvzjQtqEplv9Qez/plboin1221NAUvQ5z/GW3c?=
 =?us-ascii?Q?64KfugS+rhAQwUiAjtxYox68KbnIA06u4YlogXLEakljZCCq7c6EzCb5Yj8d?=
 =?us-ascii?Q?gO9EMgnzn7ZCqZNQ3W11fBd9YzBG5krgttZYh1BiFzvCO6LpnkI9JdWVPAe1?=
 =?us-ascii?Q?yxmhvlI4CRT+uthzLPA/Ldcmkd0t7QTKsSfkwR1FCMskPA+9Akjxo9xIJ0cH?=
 =?us-ascii?Q?+HmIXT59PKsEFRQMeRScynZ8yyItM2RgQiD9HOxNJSfT9fM3aZWoWJMStD6U?=
 =?us-ascii?Q?ExY01csvbstvSGuNoPbhz4vxwf3grEh4LDUzsHcEym3BibZY0YABNsndAjUC?=
 =?us-ascii?Q?yFoBUzKVTYc65P0rr1WlFGIImi/zKrwt2dV99UQWf+FdxBvm54+FZsi7N5uw?=
 =?us-ascii?Q?cLk1y1wKtqYODssvWpXwNDCYnXj/U5kOtSu6KXnBgshguyHMlYX8G3AiSy0s?=
 =?us-ascii?Q?UN+ZE35YZooJVvRmzoUptSkPaqFGBhcJgDSJ3CdBC5VNsV0+W0sD6WiqLzHx?=
 =?us-ascii?Q?Rs8Ee4VuIIg4yZaq9pWg/+NcG0aPCqFto15m/BPUiuNtusqR/ky3CxC2Gv1j?=
 =?us-ascii?Q?s7jPMz1H5aunanXGgApamt4W0GfZqRHJFG/MGZlG3C4/YTdG/WuSBG08oi0d?=
 =?us-ascii?Q?3iSzvaYWvWRlbMYbPya3O1VjT5BuLvietVBytWWK66NsF+tbKUoFmckQe14c?=
 =?us-ascii?Q?x71WCzJRS8kVBNfatCWqax+bPV1F4aTQ+k3c9Zt3OnBQdQi6HJ7jMNBmWuhy?=
 =?us-ascii?Q?Fj2SRdc2ckTYS/bGRznCQl/asoDHrnsDs4TuMw97ymxrYRW2cTtVYs+Ay3I8?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 370fec5c-bd15-4a29-b64d-08db5aad405c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5471.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 10:13:56.2074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oSjSmnpsYp4Co/UKPoMSMPHC65NyDLTAqlsTSIGJbch/1RjunkUcpAXmO5u4VlZ1WC//cOI0xsnne5cdU02Sz7x+856JyQg6w0gkUeEiB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf/vmtest-bpf-next-VM_Test-16 [0] has failed without any log.
Maybe it would make sense to rerun it?

[0] https://github.com/kernel-patches/bpf/actions/runs/5030713342/jobs/9023468565

On Wed, May 17, 2023 at 06:01:04PM +0200, Larysa Zaremba wrote:
> Add ability to specify a network interface used to resolve
> XDP Hints kfuncs when loading program through bpftool.
> 
> Usage:
>   bpftool prog load [...] xdpmeta_dev <ifname>
> 
> Writing just 'dev <ifname>' instead of 'xdpmeta_dev' is a very probable
> mistake that results in not very descriptive errors,
> so 'bpftool prog load [...] dev <ifname>' syntax becomes deprecated,
> followed by 'bpftool map create [...] dev <ifname>' for consistency.
> 
> Now, to offload program, execute:
>   bpftool prog load [...] offload_dev <ifname>
> 
> To offload map:
>   bpftool map create [...] offload_dev <ifname>
> 
> 'dev <ifname>' still performs offloading in the commands above, but now
> triggers a warning and is excluded from bash completion.
> 
> 'xdpmeta_dev' and 'offload_dev' are mutually exclusive options, because
> 'xdpmeta_dev' basically makes a program device-bound without loading it
> onto the said device. For now, offloaded programs cannot use XDP hints [0],
> but if this changes, using 'offload_dev <ifname>' should cover this case.
> 
> [0] https://lore.kernel.org/bpf/a5a636cc-5b03-686f-4be0-000383b05cfc@linux.dev
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
> Changes since v1:
>  - changed syntax from 'dev xdpmeta <ifname>' to 'xdpmeta_dev <ifname>'
>  - added 'offload_dev'
>  - deprecated 'bpftool prog load [...] dev <ifname>' syntax
>  - deprecated 'bpftool map create [...] dev <ifname>' syntax
>  - updated usage message in prog.c
>  - updated usage message in map.c
>  - updated documentation
>  - updated bash completion
>  - mutual exclusivity of xdpmeta_dev and offload_dev [0] is now indicated
>    by errors and syntax documentation
> ---
>  .../bpf/bpftool/Documentation/bpftool-map.rst |  8 +--
>  .../bpftool/Documentation/bpftool-prog.rst    | 11 ++--
>  tools/bpf/bpftool/bash-completion/bpftool     |  7 +--
>  tools/bpf/bpftool/map.c                       |  7 ++-
>  tools/bpf/bpftool/prog.c                      | 51 ++++++++++++++++---
>  5 files changed, 64 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index 11250c4734fe..3b7ba037af95 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -28,7 +28,7 @@ MAP COMMANDS
>  |	**bpftool** **map** { **show** | **list** }   [*MAP*]
>  |	**bpftool** **map create**     *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE* \
>  |		**entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] \
> -|		[**dev** *NAME*]
> +|		[**offload_dev** *NAME*]
>  |	**bpftool** **map dump**       *MAP*
>  |	**bpftool** **map update**     *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
>  |	**bpftool** **map lookup**     *MAP* [**key** *DATA*]
> @@ -73,7 +73,7 @@ DESCRIPTION
>  		  maps. On such kernels bpftool will automatically emit this
>  		  information as well.
>  
> -	**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] [**dev** *NAME*]
> +	**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**inner_map** *MAP*] [**offload_dev** *NAME*]
>  		  Create a new map with given parameters and pin it to *bpffs*
>  		  as *FILE*.
>  
> @@ -86,8 +86,8 @@ DESCRIPTION
>  		  kernel needs it to collect metadata related to the inner maps
>  		  that the new map will work with.
>  
> -		  Keyword **dev** expects a network interface name, and is used
> -		  to request hardware offload for the map.
> +		  Keyword **offload_dev** expects a network interface name,
> +		  and is used to request hardware offload for the map.
>  
>  	**bpftool map dump**    *MAP*
>  		  Dump all entries in a given *MAP*.  In case of **name**,
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index 9443c524bb76..dcae81bd27ed 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -31,7 +31,7 @@ PROG COMMANDS
>  |	**bpftool** **prog dump xlated** *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] [**visual**] }]
>  |	**bpftool** **prog dump jited**  *PROG* [{ **file** *FILE* | [**opcodes**] [**linum**] }]
>  |	**bpftool** **prog pin** *PROG* *FILE*
> -|	**bpftool** **prog** { **load** | **loadall** } *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
> +|	**bpftool** **prog** { **load** | **loadall** } *OBJ* *PATH* [**type** *TYPE*] [**map** { **idx** *IDX* | **name** *NAME* } *MAP*] [{ **offload_dev** | **xdpmeta_dev** } *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
>  |	**bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
>  |	**bpftool** **prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
>  |	**bpftool** **prog tracelog**
> @@ -129,7 +129,7 @@ DESCRIPTION
>  		  contain a dot character ('.'), which is reserved for future
>  		  extensions of *bpffs*.
>  
> -	**bpftool prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
> +	**bpftool prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** { **idx** *IDX* | **name** *NAME* } *MAP*] [{ **offload_dev** | **xdpmeta_dev** } *NAME*] [**pinmaps** *MAP_DIR*] [**autoattach**]
>  		  Load bpf program(s) from binary *OBJ* and pin as *PATH*.
>  		  **bpftool prog load** pins only the first program from the
>  		  *OBJ* as *PATH*. **bpftool prog loadall** pins all programs
> @@ -143,8 +143,11 @@ DESCRIPTION
>  		  to be replaced in the ELF file counting from 0, while *NAME*
>  		  allows to replace a map by name.  *MAP* specifies the map to
>  		  use, referring to it by **id** or through a **pinned** file.
> -		  If **dev** *NAME* is specified program will be loaded onto
> -		  given networking device (offload).
> +		  If **offload_dev** *NAME* is specified program will be loaded
> +		  onto given networking device (offload).
> +		  If **xdpmeta_dev** *NAME* is specified program will become
> +		  device-bound without offloading, this facilitates access
> +		  to XDP metadata.
>  		  Optional **pinmaps** argument can be provided to pin all
>  		  maps under *MAP_DIR* directory.
>  
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index e7234d1a5306..085bf18f3659 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -278,7 +278,7 @@ _bpftool()
>              _bpftool_get_prog_tags
>              return 0
>              ;;
> -        dev)
> +        dev|offload_dev|xdpmeta_dev)
>              _sysfs_get_netdevs
>              return 0
>              ;;
> @@ -508,7 +508,8 @@ _bpftool()
>                              ;;
>                          *)
>                              COMPREPLY=( $( compgen -W "map" -- "$cur" ) )
> -                            _bpftool_once_attr 'type dev pinmaps autoattach'
> +                            _bpftool_once_attr 'type pinmaps autoattach'
> +                            _bpftool_one_of_list 'offload_dev xdpmeta_dev'
>                              return 0
>                              ;;
>                      esac
> @@ -733,7 +734,7 @@ _bpftool()
>                              esac
>                              ;;
>                          *)
> -                            _bpftool_once_attr 'type key value entries name flags dev'
> +                            _bpftool_once_attr 'type key value entries name flags offload_dev'
>                              if _bpftool_search_list 'array_of_maps' 'hash_of_maps'; then
>                                  _bpftool_once_attr 'inner_map'
>                              fi
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index ae9e822aa3fe..f98f7bbea2b1 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1287,6 +1287,11 @@ static int do_create(int argc, char **argv)
>  					  "flags"))
>  				goto exit;
>  		} else if (is_prefix(*argv, "dev")) {
> +			p_info("Warning: 'bpftool map create [...] dev <ifname>' syntax is deprecated.\n"
> +			       "Going further, please use 'offload_dev <ifname>' to request hardware offload for the map.");
> +			goto offload_dev;
> +		} else if (is_prefix(*argv, "offload_dev")) {
> +offload_dev:
>  			NEXT_ARG();
>  
>  			if (attr.map_ifindex) {
> @@ -1431,7 +1436,7 @@ static int do_help(int argc, char **argv)
>  		"Usage: %1$s %2$s { show | list }   [MAP]\n"
>  		"       %1$s %2$s create     FILE type TYPE key KEY_SIZE value VALUE_SIZE \\\n"
>  		"                                  entries MAX_ENTRIES name NAME [flags FLAGS] \\\n"
> -		"                                  [inner_map MAP] [dev NAME]\n"
> +		"                                  [inner_map MAP] [offload_dev NAME]\n"
>  		"       %1$s %2$s dump       MAP\n"
>  		"       %1$s %2$s update     MAP [key DATA] [value VALUE] [UPDATE_FLAGS]\n"
>  		"       %1$s %2$s lookup     MAP [key DATA]\n"
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 91b6075b2db3..3b77986f0fb7 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1517,12 +1517,13 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  	struct bpf_program *prog = NULL, *pos;
>  	unsigned int old_map_fds = 0;
>  	const char *pinmaps = NULL;
> +	__u32 xdpmeta_ifindex = 0;
> +	__u32 offload_ifindex = 0;
>  	bool auto_attach = false;
>  	struct bpf_object *obj;
>  	struct bpf_map *map;
>  	const char *pinfile;
>  	unsigned int i, j;
> -	__u32 ifindex = 0;
>  	const char *file;
>  	int idx, err;
>  
> @@ -1614,17 +1615,46 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  			map_replace[old_map_fds].fd = fd;
>  			old_map_fds++;
>  		} else if (is_prefix(*argv, "dev")) {
> +			p_info("Warning: 'bpftool prog load [...] dev <ifname>' syntax is deprecated.\n"
> +			       "Going further, please use 'offload_dev <ifname>' to offload program to device.\n"
> +			       "For applications using XDP hints only, use 'xdpmeta_dev <ifname>'.");
> +			goto offload_dev;
> +		} else if (is_prefix(*argv, "offload_dev")) {
> +offload_dev:
>  			NEXT_ARG();
>  
> -			if (ifindex) {
> -				p_err("offload device already specified");
> +			if (offload_ifindex) {
> +				p_err("offload_dev already specified");
> +				goto err_free_reuse_maps;
> +			} else if (xdpmeta_ifindex) {
> +				p_err("xdpmeta_dev and offload_dev are mutually exclusive");
> +				goto err_free_reuse_maps;
> +			}
> +			if (!REQ_ARGS(1))
> +				goto err_free_reuse_maps;
> +
> +			offload_ifindex = if_nametoindex(*argv);
> +			if (!offload_ifindex) {
> +				p_err("unrecognized netdevice '%s': %s",
> +				      *argv, strerror(errno));
> +				goto err_free_reuse_maps;
> +			}
> +			NEXT_ARG();
> +		} else if (is_prefix(*argv, "xdpmeta_dev")) {
> +			NEXT_ARG();
> +
> +			if (xdpmeta_ifindex) {
> +				p_err("xdpmeta_dev already specified");
> +				goto err_free_reuse_maps;
> +			} else if (offload_ifindex) {
> +				p_err("xdpmeta_dev and offload_dev are mutually exclusive");
>  				goto err_free_reuse_maps;
>  			}
>  			if (!REQ_ARGS(1))
>  				goto err_free_reuse_maps;
>  
> -			ifindex = if_nametoindex(*argv);
> -			if (!ifindex) {
> +			xdpmeta_ifindex = if_nametoindex(*argv);
> +			if (!xdpmeta_ifindex) {
>  				p_err("unrecognized netdevice '%s': %s",
>  				      *argv, strerror(errno));
>  				goto err_free_reuse_maps;
> @@ -1671,7 +1701,12 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  				goto err_close_obj;
>  		}
>  
> -		bpf_program__set_ifindex(pos, ifindex);
> +		if (prog_type == BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
> +			bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
> +			bpf_program__set_ifindex(pos, xdpmeta_ifindex);
> +		} else {
> +			bpf_program__set_ifindex(pos, offload_ifindex);
> +		}
>  		if (bpf_program__type(pos) != prog_type)
>  			bpf_program__set_type(pos, prog_type);
>  		bpf_program__set_expected_attach_type(pos, expected_attach_type);
> @@ -1709,7 +1744,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  	idx = 0;
>  	bpf_object__for_each_map(map, obj) {
>  		if (bpf_map__type(map) != BPF_MAP_TYPE_PERF_EVENT_ARRAY)
> -			bpf_map__set_ifindex(map, ifindex);
> +			bpf_map__set_ifindex(map, offload_ifindex);
>  
>  		if (j < old_map_fds && idx == map_replace[j].idx) {
>  			err = bpf_map__reuse_fd(map, map_replace[j++].fd);
> @@ -2416,7 +2451,7 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s dump jited  PROG [{ file FILE | [opcodes] [linum] }]\n"
>  		"       %1$s %2$s pin   PROG FILE\n"
>  		"       %1$s %2$s { load | loadall } OBJ  PATH \\\n"
> -		"                         [type TYPE] [dev NAME] \\\n"
> +		"                         [type TYPE] [{ offload_dev | xdpmeta_dev } NAME] \\\n"
>  		"                         [map { idx IDX | name NAME } MAP]\\\n"
>  		"                         [pinmaps MAP_DIR]\n"
>  		"                         [autoattach]\n"
> -- 
> 2.35.3
> 

