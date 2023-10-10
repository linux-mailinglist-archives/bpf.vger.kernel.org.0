Return-Path: <bpf+bounces-11815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7208E7C01C5
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 18:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8611C20D69
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8E02FE0E;
	Tue, 10 Oct 2023 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9ucY0Zr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30D2FE01
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 16:35:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C368E;
	Tue, 10 Oct 2023 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696955746; x=1728491746;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=00orKZ10ktIIVdPT28ukB5GSc3X9GzTL+hncMwkoJnA=;
  b=H9ucY0ZrQm7ZeDu9+/X8uaUq8lmlpzqwjCwd8TTVCR9/IWnPHKtyOoJW
   hSMPM/yjuKWTDrI1dJDJ+2HMeE7zsKmxwuSMDF+H5JS3MYDbPeUN+6Sbn
   0fPDoztDjdGjneAcwgK4y+rzUDRJEwou8BQmSMbJoOU6vZ94RtJ9W6y+A
   szlM08H9swt+f8UXIh5+kkR3+4/ShOhIj+QWJRcOOIERlGQlK2zVgDwsf
   d9mwHpkczUudtqGoI9XGlMHbGUpGJWHqsjTq9hykmRiWfLP2TUXj4pxvA
   sf5AQoDgL7hfzXTLAFRQ0ZRjrHtmzZ5xPaqK3G/W8WRSoCnk4kcq69sLb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="6007792"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="6007792"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 09:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1000765311"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="1000765311"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 09:35:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 09:35:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 09:35:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 09:35:41 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 09:35:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+ZPZN3QflhEXE3zyh0I4N6mLN1lz+S2C/dYLIwTBsiaXrfi3ZmkYtarbdHWdMOnbH35qSLfB+Kg2nkeaA0aASg9o+07GXPHZFoVdIPnd4jTBzWuhsplh2aKsqafRhM5rwZuR41kI8a4bgXrpALi1uwrgR3S3zGqSod9TkWMZsCvBdnKCvti23z3E8p4RBi8rX8Q0VciROXecCld7vonrmuU0VIeFPF2DurwYEImNlKpmm5f0w4Y/ZflFO7fHqwyZuU94r9aSlOmtMGP/Lq1f7qhvVTF8eQWzlQvVjTcZH/8BjfrfNrzfxylZpgLhQBlf1b7QR/Pw4UkDupagN7BiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBjcGlxO/T/AQSj2VbZrt/N6dhjH4a5bBMR8hFFD4us=;
 b=OKCz1Nvtf3pY4q2lbjBDuyAHsiJuXsBELb55IikEeaFJOec8MThoGmPlbbltx+gSnUCbOkduWz4fxahN9ufKL5pY56Hpbz60b5S4ZFM+aiVBnFu5IzzEWPSS+gA17rqAjr2I4jKPDs3LmEkUSNrrBOQkKJoSNLCOLF0yaqq5avCRc4ckKiAPSqBdziRyMP3n8GM/tIlN0RNyqecAvV5VC7ZmCOMu11WPldK1HY+pKPMDCnVMmHqS2jTfcQdyxUA98PetIi7yvkbyKXnE9OYZ/DFtXaQce3qvqCikPpbZxppl3iEvBLeqON1fWU9yo5MlbXSi0w6uUJXCBno8RTaOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 16:35:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:35:40 +0000
Date: Tue, 10 Oct 2023 18:35:31 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii
 Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, "Yonghong Song"
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, <linux-kernel@vger.kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add options and frags to
 xdp_hw_metadata
Message-ID: <ZSV9U0ti8otbZKen@lzaremba-mobl.ger.corp.intel.com>
References: <20231009160520.20831-1-larysa.zaremba@intel.com>
 <ZSQvMr3-lY9uTzn_@google.com>
 <ZST8OTwh+6y1S170@lzaremba-mobl.ger.corp.intel.com>
 <ZSV2HwOhuNr3XLbv@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZSV2HwOhuNr3XLbv@google.com>
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e4b677-7859-4837-2244-08dbc9aef06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lf808aRjst10F/MJRW4IrU2N8OAJ4pdZZ1AuzIxvIe2foEblTsw6OH33gFdI8NEi7DVHDdzr3zs7A6tPbTfdALyHJYvPSbxWBNNAkAnoHI8DIfH/a11/zlQB5x5JGxMhWSNPnTy3MtefWxvnyUpw1n52Cj6zJ/BmPlo6+jK+7IDTQlFPOi3iZbxaALzVcyZ9/o93oP0ISdcifrv6WCTaWgYxaeqmGVetwsuG3s5JJxWZyzOGVeXs+vZBjWWGnTUB9lo9gXNwSdFPJ8xCbbqqBVZg4nvZ24sElG3AX2QOaFv/n7jEFMLDJOuRIGyaPVfdUgAPsNEJwl7qj6I5FHwtrMD2NtSMDD5yImZ3vM8qjbzAICDhUmKah6lGVIg+quKNBoTigaLn+9cWvca1oFt3UqCaagqfkNFNb35TF1nlefAvsvvyzxmcqE5hkXF4tHB+vD8uFHPQmvLsjQtRyJQo0IZpyPMC+oZB3Pvhudgm0nssf+sRW1zzpyteLRWCWLXH7eEHPdVfJF6yH9q/+dFhrbWHJpMvcRVcbsZuWltIB06QOsIf7HvRXicBM70LMw8FDswfFGGKPL5IwQn4tNvHbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(107886003)(6666004)(478600001)(6512007)(6506007)(38100700002)(66556008)(54906003)(6486002)(966005)(26005)(66946007)(66476007)(6916009)(316002)(41300700001)(44832011)(4326008)(8936002)(8676002)(5660300002)(82960400001)(7416002)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kygrb6Q94iQdQ0TedGcohm6r1zrH28ZpA5IrNLoD2Sg7crcaTcMOj9VnNxUU?=
 =?us-ascii?Q?2GVkIy324vW/OnSM5sjKni1vGbZgXFtTV1pWB1gXVd6yior0UGDdJv3NvkUY?=
 =?us-ascii?Q?tb4PI30TEJILBx3sQuqEX1TSNtuCNQEZPhScqgpczo0ZDbZy7Bf8GObSaKJO?=
 =?us-ascii?Q?ZJ0Ik8T3B3SEdJiNTzBGm84TFfxWU7fI4DG7LG+vdUscWqKpJ1Z03QNYqsQM?=
 =?us-ascii?Q?B3YakhJKk8wrnhL2QKpBWJEXSzvxQLfB1wqf+3b+GeX9izAQmWrGE7wJLk+a?=
 =?us-ascii?Q?0+9m+lb1tCDLaahkHa6lLQ0ROCp240rRwCZNielysoxl5/t0n65wRxYwMk7q?=
 =?us-ascii?Q?CAp4Bidpd3Ntk3OKUfGfi2VBga8cTDLqu7nFIe2ilo0gwnu45hulWGTUKzPg?=
 =?us-ascii?Q?4vuxkY6z8S+3XbF2qFHPgDBgQ9xhbLz4UHaAgJpDqMNKpa2SWnvlQS6YTTB2?=
 =?us-ascii?Q?pMEzcBoQ/xCvwnNivYfsFDCBLkFGag399IJR1cEVCl1IFKJciV7lBjXo8X2Z?=
 =?us-ascii?Q?TK+p6aK0huqc1axmXPbMx0Y2ho7RAZ5OK67fyA2vgZdKama7B9EJn/ccMYwe?=
 =?us-ascii?Q?6kB3YD55vJLA+7HKoc35mjGCNQWitJ2+xLwx6xqYmyhXRw5wNXLOUK9RZk1l?=
 =?us-ascii?Q?e7oUT0qNgrhSFyNhZHRjOQtoMhqeOhPCamfrBeMB54CBUSbDEUSsGvql5+Dq?=
 =?us-ascii?Q?Ixu1SLOEf8xKQmQ5HOtqoWZhxyE+1Dl+ogpcD+gRwH17mqnEH99sSb+V0Xp/?=
 =?us-ascii?Q?3ZhTKk8RcgIW94iXauRz6Zz6vXVKTTWYfuD/eURp1GFfVb1VmfxdZbQ9VRXY?=
 =?us-ascii?Q?nS7kCWQzTwP4j02e+p6zXzDqg2Xk3v0ed2giEic4KF4g82kI6vRBWOJhlhms?=
 =?us-ascii?Q?GVWa66Mv4Q28TARxuVLub6qZOGBGTkwO0j9+zX/xjs+RAkoZUZFVpQ/Jga7c?=
 =?us-ascii?Q?GNkp0NOZYDljF60xUgwBzENgxMbNMAQ66DFnkP5neTptbEh+E0voywo+7VA5?=
 =?us-ascii?Q?pNO+XIFsh4AJxKsSkeoHCu8jRLhZ8tXik8lEqBIpUmwfrOAbsulj3olxnQT7?=
 =?us-ascii?Q?aGYyD+m2ZGjQS34LmyHB3/A/eGyzcRZgMHIWHSpXOuOWGw36i4Co0D3E1B/N?=
 =?us-ascii?Q?bsqoQADcAyPvIxBpfTNrX+mg/OcsF8Iv129JXIfUSAV+wIy3tH69Z82tAsU8?=
 =?us-ascii?Q?+A9kJ+mw3AH2IWpJT2PZnY0+3aS09iO0RmDx8K8ZCTU+T1JGUiiKkQiFCx3p?=
 =?us-ascii?Q?dxiWg9sE+Y6nrAtnPnSjDnlcvSA31bLkWVxcCKLHHpo7I/1XKms5190AMK6P?=
 =?us-ascii?Q?C9/fx32VAPXcjTIJtwUDVycfHWdezjdgeBZOveZN6iXIAkCd6gnwSMhRtHRX?=
 =?us-ascii?Q?QZuKxCBFL09MQVT1vCQ/XTNNQRuqYIyZBhQ0TLAsJ9H3r07qHxVPZv4FLmTN?=
 =?us-ascii?Q?M4e8suw/9GktvM9M2b1U6yJIFbccX80lhBG5dMFREzJFRPNuWLPNH2sWlkei?=
 =?us-ascii?Q?wdDpjaa5mUm6RcOCkqOzGXqw7JWSngxCpzQXSsAEeUVXe9F4+y7/KlBJedf+?=
 =?us-ascii?Q?myt3zd6M0RKjolexqWIwbQDtZzReNck5q0SfR25y6zh7QwE6ZJ+I4LQdL9YI?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e4b677-7859-4837-2244-08dbc9aef06f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:35:39.9472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kl1dz4dPZHp9TFIJ43aAWq8oXTSyWvTJ6m6m8Lc/7MhEC2/wx3qUYn2bd9e8k2pnL4C1PisF5lN69NPlk+8i1kQSojjyEgDG5YHSEa+AJ7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 09:04:47AM -0700, Stanislav Fomichev wrote:
> On 10/10, Larysa Zaremba wrote:
> > On Mon, Oct 09, 2023 at 09:49:54AM -0700, Stanislav Fomichev wrote:
> > > On 10/09, Larysa Zaremba wrote:
> > > > This is a follow-up to the commit 9b2b86332a9b ("bpf: Allow to use kfunc
> > > > XDP hints and frags together").
> > > > 
> > > > The are some possible implementations problems that may arise when
> > > > providing metadata specifically for multi-buffer packets, therefore there
> > > > must be a possibility to test such option separately.
> > > > 
> > > > Add an option to use multi-buffer AF_XDP xdp_hw_metadata and mark used XDP
> > > > program as capable to use frags.
> > > > 
> > > > As for now, xdp_hw_metadata accepts no options, so add simple option
> > > > parsing logic and a help message.
> > > > 
> > > > For quick reference, also add an ingress packet generation command to the
> > > > help message. The command comes from [0].
> > > > 
> > > > Example of output for multi-buffer packet:
> > > > 
> > > > xsk_ring_cons__peek: 1
> > > > 0xead018: rx_desc[15]->addr=10000000000f000 addr=f100 comp_addr=f000
> > > > rx_hash: 0x5789FCBB with RSS type:0x29
> > > > rx_timestamp:  1696856851535324697 (sec:1696856851.5353)
> > > > XDP RX-time:   1696856843158256391 (sec:1696856843.1583)
> > > > 	delta sec:-8.3771 (-8377068.306 usec)
> > > > AF_XDP time:   1696856843158413078 (sec:1696856843.1584)
> > > > 	delta sec:0.0002 (156.687 usec)
> > > > 0xead018: complete idx=23 addr=f000
> > > > xsk_ring_cons__peek: 1
> > > > 0xead018: rx_desc[16]->addr=100000000008000 addr=8100 comp_addr=8000
> > > > 0xead018: complete idx=24 addr=8000
> > > > xsk_ring_cons__peek: 1
> > > > 0xead018: rx_desc[17]->addr=100000000009000 addr=9100 comp_addr=9000 EoP
> > > > 0xead018: complete idx=25 addr=9000
> > > > 
> > > > Metadata is printed for the first packet only.
> > > > 
> > > > [0] https://lore.kernel.org/all/20230119221536.3349901-18-sdf@google.com/
> > > > 
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >  .../selftests/bpf/progs/xdp_hw_metadata.c     |  2 +-
> > > >  tools/testing/selftests/bpf/xdp_hw_metadata.c | 92 ++++++++++++++++---
> > > >  2 files changed, 79 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > > > index 63d7de6c6bbb..8767d919c881 100644
> > > > --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > > > +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > > > @@ -21,7 +21,7 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
> > > >  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
> > > >  				    enum xdp_rss_hash_type *rss_type) __ksym;
> > > >  
> > > > -SEC("xdp")
> > > > +SEC("xdp.frags")
> > > >  int rx(struct xdp_md *ctx)
> > > >  {
> > > >  	void *data, *data_meta, *data_end;
> > > > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > > index 17c980138796..25225720346b 100644
> > > > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > > @@ -26,6 +26,7 @@
> > > >  #include <linux/sockios.h>
> > > >  #include <sys/mman.h>
> > > >  #include <net/if.h>
> > > > +#include <ctype.h>
> > > >  #include <poll.h>
> > > >  #include <time.h>
> > > >  
> > > > @@ -49,19 +50,29 @@ struct xsk {
> > > >  struct xdp_hw_metadata *bpf_obj;
> > > >  struct xsk *rx_xsk;
> > > >  const char *ifname;
> > > > +bool use_frags;
> > > >  int ifindex;
> > > >  int rxq;
> > > >  
> > > >  void test__fail(void) { /* for network_helpers.c */ }
> > > >  
> > > > -static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
> > > > +static struct xsk_socket_config gen_socket_config(void)
> > > >  {
> > > > -	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
> > > > -	const struct xsk_socket_config socket_config = {
> > > > +	struct xsk_socket_config socket_config = {
> > > >  		.rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > > >  		.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > > >  		.bind_flags = XDP_COPY,
> > > >  	};
> > > > +
> > > > +	if (use_frags)
> > > > +		socket_config.bind_flags |= XDP_USE_SG;
> > > > +	return socket_config;
> > > > +}
> > > 
> > > nit: why not drop const from socket_config and add this 'if (use_frags)'
> > > directly to open_xsk? Not sure separate function really buys us anything?
> > >
> > 
> > Considering there will also be ZC/copy option, I thought it would be good to 
> > separate socket config creation. After giving this a sencond thought though, 
> > for now options would control bind_flags only. What do you this about removing 
> > gen_socket_config(), but introducing get_bind_flags()?
> 
> In my pending series [0] I ended up adding bind_flags argument
> to open_xsk. Maybe do the same here? This also lets you drop
> global use_frags (if you move option parsing directly into main).
> 
> Or maybe add global bind_flags if you want to keep separate parsing
> routine (read_args)? Doesn't seem like we get anything by storing
> separate use_flags/use_copy and then construct bind_flags via extra
> get_bind_flags()?
>

I like the option with global bind_flags.
  
> 0: https://lore.kernel.org/bpf/20231003200522.1914523-10-sdf@google.com/

