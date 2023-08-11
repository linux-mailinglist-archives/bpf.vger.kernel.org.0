Return-Path: <bpf+bounces-7589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89737794A9
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DF11C21760
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B229E1D;
	Fri, 11 Aug 2023 16:28:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD01171A;
	Fri, 11 Aug 2023 16:28:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4A2273E;
	Fri, 11 Aug 2023 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691771286; x=1723307286;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/hqH9gYFZ2j63rn+PB93z2shfOV9OfucfMdp10CqvB0=;
  b=TBqwqNDvIKz/6/aNYsTWTHB6OlwdOKdIDCIilGixyhNgBy7r23YCvKXY
   Z0oW9/1Ql/F46xvGy02QkFRC6PanN+KRYpXvnHIypszAIZ8i7UDbcD0Pe
   DnGFuNddzj3oytT/iaMuxhdqjn855gYaNfs5mMVtuxTrPxb+jErSgmTVa
   C+Lsqz6t3E3dlR/0DRRuR1ozvljqkCDGbGWWL+mzSwXi8AhVl8pEiyAo6
   LPjmg2uYqvMVX9ysmkCK3hCYMsm3CqYuaQ9H8VqW6wRkfu/Yi2uoomGbp
   rXZQXijSHI5e5Ffs+4nvt2HgZU0aC5FN4SKNbJ97ppQdzvXCBfyZy+dD5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="356673803"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="356673803"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 09:28:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="1063364863"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="1063364863"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2023 09:28:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 09:28:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 09:28:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 09:28:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lb9ffatOBisEjX+ZsHZ/ct7TJf/D7zdVmIAASO4Wxoiq/9gM7n5UXbNzis1d+e3i910MC7xZUTSLVwN5GYVhYrsdEMGO6+R6IY4r1VrUzYyvJ6wTCxQhx8BxAMsLnhJV94tiTQhDrxDu/r4bF4HqHld8KjNt85VRJCS/Z4+ilybw4zSfBxVGkxjGcikuw/TkPpcSIXI65m0KN54P8j5fZmmDkHVEHIx/lIRJggzME2+f1El2cOCZRw0Vkyjw8EH9oafLsDtI4NhvJtAfZB0J65EL8n/RyjzjqDe/5ylaoa8IZ1ziYGUyLs6J5gOtZGmPJmQbmF+jIT5/C4oZv3bygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjS+G7SYmteY6sDty6peSucKDG2jZ49awBKywqEChL4=;
 b=XIAK0Xz0Qq1sz5qFn2fnd01Mo2jTKoJEtv/u/ahNf4pxIYHvqP0VHJ02RozCMuONSwuZ5w59N2nWr5BeLuD6pp4SYeKX3jbosKJH76eA4//2RYwUNcG2xrjAZQzTh/PjDSnAChEPlNh4VLugC7M41PDHo+iIzfmpggfumkHGiX/v/TcREj/8iQpM5Bip68uIvdagG4JBhVUuo1kTG1us/6zueW8pWMaJj2kx5YcGIS/z5VG6ug7KuHtJLfFpZRCZpNqQxFhzW4GW3n5jGVg5y0fOG2fLaD0NPE2EhqbCwIz9yecia1NEnjUhxB3qUOpVGitpEV+03dSQSRU8wPZnxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB4909.namprd11.prod.outlook.com (2603:10b6:a03:2af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 16:28:02 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6652.026; Fri, 11 Aug 2023
 16:28:02 +0000
Date: Fri, 11 Aug 2023 18:23:26 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: <bpf@vger.kernel.org>
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
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next v5 00/21] XDP metadata via kfuncs for ice
Message-ID: <ZNZgevBivplTattb@lincoln>
References: <20230811161509.19722-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811161509.19722-1-larysa.zaremba@intel.com>
X-ClientProxiedBy: FR2P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c1baf7-4a90-4ff1-f128-08db9a87eee4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lc9sxA9VWmeh2nsHSVrL1Nb9ad7Z4DE+xdttFbrggVeLLkIgCyT3FL/38fC28ecPN+bzggA9qGmMMBG/kLOCYNg5tYQuJ/H83yggWSjuQ4J0YdaaF1Gj5jV51tG9y7kMe+09JPqxknT7QITv1/sZ1KJdW3XBQ3d7AOQ2WaxNFs4CqoeoyYSB+Mx1NXOva9uuMXJadExeoOKH0VPwXucHAU+U85552gwIfNepZ6UJC1SiIwkWIAvXTFw+eaEzAaK5zkS4+jApf7ZM/cQF1llTG0lYie3fdh0WHVfShtsEHs1sK76YxDmNEdOW5xaqUNz5jeuxBDAKRPiD57F+21G93y8h2/abdEjnM/0ytalx61x+i6kGV85Eo2hG4USeV2W9hZ2M2bO6kScgtsePyG1HyHqKiJfagLf5zgENzW9RAv//FM0c1PFLY+IvMGuCtvLeWZC0sFPnL1hORMzgctQ4yKyn0rzYHyRqXyfizCzLAv9kxD4oK36Eq28fwJVXz1BqMwpcrA6nj/LRTaVQAI+gMSXi2DydDnSgQyOQUPraCllmLq+to9F56nXWRlryhxp/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(186006)(1800799006)(41300700001)(66556008)(316002)(66946007)(8676002)(86362001)(8936002)(558084003)(6916009)(4326008)(7416002)(66476007)(5660300002)(2906002)(26005)(44832011)(6506007)(82960400001)(54906003)(6512007)(9686003)(33716001)(478600001)(38100700002)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vvc7Un7YgqNClL1lV9+CGU9REYvMjE8T1H7Bia+JxbFiRuf/DQZh/RTRDt26?=
 =?us-ascii?Q?PIzou5hr3lo9bxv4tUdsKFY3D4RtV+B1F/r7w8IX3wgN/vUSbpw3xIc6fvE0?=
 =?us-ascii?Q?dNhAvv79pQK0SSQH+lRamvCxhsATR+QNTdgiqlwQC/Yk8Zq8N5J7wZ6zYtaH?=
 =?us-ascii?Q?fSRZV//QzRJ8Ly/tyL4Hm43piiPxh4kiAnHaQs5dvMvADVQ6NhpGHeAtcuiL?=
 =?us-ascii?Q?x82DM7+/jH6fIVn1IT0qPJRgAzPa2wezqqWh7Ri0p7ESlQlrzPJqCHc5X/FP?=
 =?us-ascii?Q?WuOsfnnwzK96RS/jbnYItmtVtftf2dwSXaGMedZThiA84x9bJkGFdR6yMIxX?=
 =?us-ascii?Q?dz3CAozN9AlQOSywr4tq/2amJci+YS33hvymeK/tV8Zt/Y1ZxWdTxjIZ9FLu?=
 =?us-ascii?Q?v7SGEg4v5bPm0e6c76cgTNmwF5bhm9T7I8f8xvbsXAec0q7qj4iRekjjnUed?=
 =?us-ascii?Q?f1lcZZ1hSYrjnjfDGqtH1qDKQ61g5nHPKqNz8h766o8rd7ihkl1VEFDoXXRg?=
 =?us-ascii?Q?9tfrG3pl17D1r00MxRnN8k1897XOeir/YudhzGRPyj85Q5+hH53dZ0D+waI+?=
 =?us-ascii?Q?QHjdVMfLXD0hEhyHnm0aLoE9TjI44620ncC8w9O7A+ufJRr5/u2/aXzwUgbP?=
 =?us-ascii?Q?yuAuvHk3L1j4ingdXSUqW81j4Y1xqfNibzI+ntk9ZAjGZw/gLiYiovbZrrYq?=
 =?us-ascii?Q?Z4+OudUZ9mJ9DjDWqFJkErUlMpA4D6SuBc51bPeVvmMRuzd+lGHW8btKJzfM?=
 =?us-ascii?Q?lbjeJVUIw/xHkXgiaufjOkBZMTJDEtkYzA44FFhKZRqaVmuGlk2ZPNlpU1dL?=
 =?us-ascii?Q?vw5KnDzRL1R9oFuSBg6szkp2Nt665lVBHzQBPt3KZT79KI4eIl88Nfwx2La7?=
 =?us-ascii?Q?TkKh32gVJVL23QljTz7Q0tg0aivj6BK948P4R1QFxSkPQVPRMO/DYJN1rgMN?=
 =?us-ascii?Q?SX9UNWb6wmPAlk9ptEsL7adwDsL5PSir5nwjB+XnTznRTR3VftOFCJHMroAl?=
 =?us-ascii?Q?dysO6cA7lx4WcsHImMg2MamrpQEyM//sl0+Ny9frXsNHvATqEZLWR2BwlKjC?=
 =?us-ascii?Q?PqBuryN5q6q29o8VgL3qoNvo6aesQGVEzIjND9DCXNJ4+CM2AMkD3KMLJWDZ?=
 =?us-ascii?Q?/AdZuna83HBBHUs7FWssAxLB1INrln6QNXat4qMxzXYSpvYYZGTFffnz+4A0?=
 =?us-ascii?Q?xhU3oKTFHur7nNG5YxVTO3s5h+sHUl1sRM11NOfMDFjewkGAg8qakdcObdFz?=
 =?us-ascii?Q?dz8eJ2YmVXEmkEGJPZCy4fEmjtF6p4Og5s5sux0vy8TZZy8yVOtQ+Sj3ypbL?=
 =?us-ascii?Q?zWvXw+e/lAsAxAL3o06SN00KpPRmvJ9aQ6cExVCiTPhwj9hTTjr3vVVdGdv8?=
 =?us-ascii?Q?pXeFI4Q5l1ISiRdtmhPLesZaRvgum5tuqas00RFOGBgr6VJLaWnHjpLjoufA?=
 =?us-ascii?Q?iPXJVwId9G8WQtE1E9eQ80vvQCKjX1YRjN37CMLKKQ4+lH9y+EOYNK0DpkbG?=
 =?us-ascii?Q?KfDZKSF+xmuEbXOymendZd8nX7fhgvaMIotly9jyYvIvDv2k3EXcDdl8kgMa?=
 =?us-ascii?Q?pOsP+BZbA7VZYtRhbFGP2B+76P8KTmd6e0GkwGXTRHem6wmpwp7X0e2gWUKb?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c1baf7-4a90-4ff1-f128-08db9a87eee4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:28:02.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxAFJaxdM8QyhaTc06UmTfcK1QqJZ+QiICkaKePsNVFdBpusuD8gIRRnd9m/yUGDlQ08ApH4qTZzEFPNuLyzAZKXklh3SHqu4eI7k6JOBHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4909
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I am going on a vacation for a week from now. Will keep am eye on the 
discussion, but respose time can vary.

