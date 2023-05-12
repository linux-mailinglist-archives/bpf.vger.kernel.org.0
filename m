Return-Path: <bpf+bounces-399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CE1700954
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202101C21209
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2451E535;
	Fri, 12 May 2023 13:39:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F80BE4E
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 13:39:12 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE93A120B5;
	Fri, 12 May 2023 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683898749; x=1715434749;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DUD17CQvckTw0HRUKlLT4JYEgVMeSjd1gqot1VSrsjk=;
  b=esEkpIyLbD1rScyZ1+FZAAV5QmZIR1Lfzpvhd+MD5vrLDlDMfPWvdko3
   Ed9mN0p+O7Rb9Hwe7n9+A7Jz4kiRlD8HJJZUlY2VrkQj4yAcrZQY+9LJy
   cPKMQE6SjX6r2sNMUPZYGttTj2afBZm1rT2cDkgkr7AGSFD/M1idIFpJi
   XlskpzZKssJNkCqLOvogtqCSN6D5AXyZWf5h808Ra5qOF70PAJze/g7FM
   kW+N+ldOdTaqkeaVytxhHnVxnWeuOPVxDNxkg+OxZWi5qw7XTbpArcEac
   ToMIKoF9uA+2WNuOO8b5RwQPV1KzPk096bzhLr5IGICXYDVak1s+lVkDS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="416422552"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="416422552"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 06:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="1030089578"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="1030089578"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 12 May 2023 06:39:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 06:39:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 06:39:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 06:39:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jexrNu0zmOrRXeR0zDcDaNfSzjD2YmK+jI/uBYYqAMpdaXmZSadF9MrCJIZgStlIMezVPAm4a8hP8eBAXbe8TGs3cyMOV7KwI9Cb9Wu8/xXOJ0Af9BB7s94bI6xrMsUZNzG0/znhO0N4/nvg4edO7q5NkeFRTFDlxfJIof7luRju6mtrY4wSzvwzGR3YWVNrUjSu+ba0XksVbtibN5BZFlAXM+Luvx/Amn/FQcNaGPqEv/CA2+Olm51XNOmdiksxNvnO93JbZhYTvYEjHsvbIePin7BSBUjTq7MmYaYYGJRw0TQZwxvbEqWM3bgrGWcJvGXhiqtxNaKmm9kT/Nihlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O738ZZBa9PAsST9qyb7wNaa943/HAlLNo+P5XVV1UFU=;
 b=lLEeBnxpHn42ykW+QYQG+YHcrlZe6BR6wVkNn6qIXjAJf8Ypu3obd5PiT3Qyvkanv/63eeOm+kbjWhyjlAD3z9hGbrIH6uPkUu/gF1CCgGd+hX3hph1ECH1LW0jQB7tmhhvHpwN1gedt5RoXIzx0h/87AYrFFyfEUa46A/bRN44TDMMKAiVk1y73lkItQSfOuD5tAm9zwvD1G9McsRjWiC9LmnEEsjLGyhasxYwa0oOG+wvdlN4GST4FK0rldU3pEXemAC3/7dzlUwIxx1mcTgY34ex++Z0vJlr+D9uzcm+e0dTjQToKeoAhMmU8YVhpESmZY9Cf4VbY9kAjxGK/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5471.namprd11.prod.outlook.com (2603:10b6:5:39d::10)
 by DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 13:39:05 +0000
Received: from DM4PR11MB5471.namprd11.prod.outlook.com
 ([fe80::907c:ffaa:352a:8913]) by DM4PR11MB5471.namprd11.prod.outlook.com
 ([fe80::907c:ffaa:352a:8913%6]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 13:39:05 +0000
Date: Fri, 12 May 2023 15:36:47 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Quentin Monnet <quentin@isovalent.com>
CC: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	"Yonghong Song" <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@corigine.com>
Subject: Re: [PATCH bpf-next] bpftool: specify XDP Hints ifname when loading
 program
Message-ID: <ZF5A752Z4eu8FAw9@lincoln>
References: <20230511151345.7529-1-larysa.zaremba@intel.com>
 <dd7a4bec-c0d0-4ffe-3bb8-e4d7ab4a01b8@isovalent.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dd7a4bec-c0d0-4ffe-3bb8-e4d7ab4a01b8@isovalent.com>
X-ClientProxiedBy: LO4P123CA0138.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::17) To DM4PR11MB5471.namprd11.prod.outlook.com
 (2603:10b6:5:39d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5471:EE_|DM4PR11MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: be2c6bd2-c74a-42bb-0ef8-08db52ee412d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPSdhveyIaA+2/iaRv0BMEYLeWoefMtFeU44A1jH9fXX9Pknud23PFaRl4RZAbQJJ48BR/Rdl5ESevk8riVkGxBbqrcGPSeqBAh6jTVnSCIX38vfQ3z5yWMvhwkL+ETIqoJtuHLzPEHVSKEuF3lxZxZwVStqiWh0tgYqqZNaEAVPf24H5CDAV4UOl2cj27cSQJ27pj26M++419Ia0iYp7Q9mwKz7SWq3h+EIRLagO7G1qkZ6SPR4petGUHa+TXpTkTKDMGpgseDz/dTa7ilgb5em6fig2ldWdbJyMN3mpIWnOTmTsex/qNBcUTUvkfYPcnbTaJqHiZAdg/th4GOJmRZ+mJJ6Aek/tLN/AFTK9iukMZCTNtFCBLuu6xgjFHNewe3h1wqqmCBPFuY+aTm9r3PIcaZUvzio0h3iBCzo/Hy+LHW7wFSrWAZORx01ArhHYmMDl7e9FXUNjgijp7HgXn2ZHgeovuAImYRagwg4KQwkJnXn9AjmKLhzcbYYiwWcFpLt8d+QLWng80NVzsIo1KEplV7mOMZ30wrjLm+86KLnrbvukdknuDonLE9SWpUX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5471.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(38100700002)(83380400001)(316002)(8936002)(8676002)(66946007)(54906003)(66556008)(66476007)(4326008)(6916009)(41300700001)(7416002)(44832011)(6506007)(9686003)(6512007)(186003)(26005)(478600001)(86362001)(2906002)(82960400001)(6486002)(6666004)(5660300002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H/AOo7aLNVq4sFb9u8Wqhde3m8DMYjkegLEhOQ5OYnEYKjhLvTAvt2ALNdGt?=
 =?us-ascii?Q?TXzLM8HxnVNUx85zwB7cZzJEBssIMJ757baJz6e4b4VSlB0Oapjvcmd7DA42?=
 =?us-ascii?Q?H0+pRrMrN7d3Ae8THeSbCrhM8edCuvDfuhfHa1WMzICrwCQ2ipV1c8CAFuBf?=
 =?us-ascii?Q?aih/kVQMflGHm16VbpX7/US2gNTgKJ21l9oqURUNIGr1/E413pkJaAryB1JE?=
 =?us-ascii?Q?v7qDYFRhf8yJG8ItMz0xuDR1dCqVggSCsofrdkj6EYZJXdPag2ierLzzA2eC?=
 =?us-ascii?Q?2r+3PdQGp9Qz/GOmmXkkKavB5N8ePncSgnEnIvNzqQSI/wAfE1I56ycLIroz?=
 =?us-ascii?Q?+Ng0+btL1U2jYDi4cmE7PMNVSOfFFmIVOjZ4T6pbd5dw6LNy0AdyxzQ/Ww/G?=
 =?us-ascii?Q?wRlh6rWM8euYmrpTB0yalxxMxFKJpMEE4OnCTqN/kkQgk50U9HaZdPh+nwCp?=
 =?us-ascii?Q?og7lPwC4A7cjC8aPh5KkHVvXA80JZ9n2dz44V91PKOse1NadgVpbxc0ELZMp?=
 =?us-ascii?Q?NJJd/q5Lf3JxBT+nyxsjV4toDT+i+QRHa1alOq+Di76+s3DiaHKf1RbMiVVa?=
 =?us-ascii?Q?qSHfAdVf00u/CGXxO8i54KzS2OvLHPTYO3yoFW75enhBFvhagZzKoLpLzdgg?=
 =?us-ascii?Q?3LSPAU75ea0757KvvxP8GNN6V8N6xZqlYEQ6ieb/mGHKif1fmqyhodnlmpfm?=
 =?us-ascii?Q?T6XegZHd3uYjB7EGk+z9Q72ROyNRnEU26RiqVwR+yiKWQwalGTUVMbtQ5rP3?=
 =?us-ascii?Q?GUVmfYmgqaSxrTx4NJN0J1wCQkFc9hHRpmfTMivgnfh+JoZh/FZR508/3yA5?=
 =?us-ascii?Q?t1OJTR/KtrxJC7a88/bDvhsVWZHkShUipmD4f5YbDuitZbuyUPp12ZLKo9wc?=
 =?us-ascii?Q?41QCJCDI4muJdp6f6hNkAwnLjMO5A6l1rWM9x0r4D11qOo5AOzBsEpnGuzfp?=
 =?us-ascii?Q?fPmy9+L0rKKoE8ZnR8p1VuJqhJhpb9HwjQdEtBhowkPpOmZHSvv4kt1o0Hms?=
 =?us-ascii?Q?JG+/JJfsdxJfypuSiaY7L/IDwOc/2+sGKzrVKyACIdAryK7M0eBDHCiHGRfR?=
 =?us-ascii?Q?Qs5n6UMMzLU25NLBWxLbbCjG7nauBSE098ql1PIjBgvVlW1U4KUEPJcA5HYU?=
 =?us-ascii?Q?imUTfXx4s1kxTrr34g6SykL9qbzKK6MG572LwNTkensVZbmWNirhLPFUo0B8?=
 =?us-ascii?Q?kh9bN7fnJEkc86XVA4kjpc2UOhjwqjvCmkr1tIo2w2GNrbdAcak2j9OgJmwW?=
 =?us-ascii?Q?7Lzz5uIYy+8p7ATEDvuDV/iswAWjZ3YI/RvUjGah02SDuZm/iKfZuTpITkza?=
 =?us-ascii?Q?EmKhoowwlCQblV7tRU0bY1O4vK/K7qczHTPhz4lYgNZICc3wmGA28kaNU+M1?=
 =?us-ascii?Q?wMOhjs074N1H9nkza7ZqGyYTtSmO0yr1bODo3+L2cOHzLRmpCycG8H/lwWeq?=
 =?us-ascii?Q?yrqG5tXDWW546UOMTyO08/U4EoCg1TME5Z/0GICK7xdL7Ebqo6+oRdQ41QRL?=
 =?us-ascii?Q?zn+q8YOoyTQbEo6pIyi8wfQncZ9ga9v0IpG1Z09oGF+O+VjJ8sjhtNcZgxOg?=
 =?us-ascii?Q?3D3yxV7NdCCyNdlIWPFhIGwpxjePcO/76rPu0/v2TjPXAcORhvT6ahrkcf2z?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be2c6bd2-c74a-42bb-0ef8-08db52ee412d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5471.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 13:39:05.3959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CN5bVGDPEsI9IqWI/9qtTCjfb9pjXlHyIEelviFfqq58poZfApcsMQc5vvEQh15t1RSjKb1Eoi4aKiC6nAyekvgzAH6UbcGayIcu9QZwmn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6527
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 12, 2023 at 11:23:00AM +0100, Quentin Monnet wrote:
> 2023-05-11 17:13 UTC+0200 ~ Larysa Zaremba <larysa.zaremba@intel.com>
> > Add ability to specify a network interface used to resolve
> > XDP Hints kfuncs when loading program through bpftool.
> > 
> > Usage:
> > bpftool prog load <bpf_obj_path> <pin_path> dev xdpmeta <ifname>
> 
> Thanks for this patch!
> 
> Regarding the command-line syntax, I'm not a big fan of the optional
> sub-keyword for the device for XDP hints. I must admit I had not
> anticipated other another use for the "dev" keyword. Instead, have you
> considered one of the following:
> 
> 1) Adding a different keyword ("xdpmeta_dev"?) and making it
> incompatible with "dev"
> 
> 2) Another alternative would be adding a sub-keyword for offload too:
> 
>     bpftool p l [...] dev <[offload <ifname> | xdpmeta <ifname>]>
> 
> If the ifname is provided with no sub-keyword, we would consider it for
> offload for legacy support, possibly warn that the syntax is deprecated.
> 
> What do you think?
> 

I think first option would look a little bit nicer, but I like the idea to 
deprecate "dev <ifname>". In my current version, forgetting to add "xdpmeta" 
resulted in not very descriptive errors, this may confuse new users. So what 
about:

bpftool prog load [...] xdpmeta_dev/offload_dev <ifname>

"dev <ifname>" syntax would still work, but with a big warning, like this:

  'bpftool prog [...] dev <ifname>' syntax is deprecated. Going further, please 
  use 'offload_dev <ifname>' to offload program to device. For XDP hints 
  applications, use 'xdpmeta_dev <ifname>'.

> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  tools/bpf/bpftool/prog.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index 91b6075b2db3..a9cb96d99277 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -1517,12 +1517,13 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
> >  	struct bpf_program *prog = NULL, *pos;
> >  	unsigned int old_map_fds = 0;
> >  	const char *pinmaps = NULL;
> > +	__u32 offload_ifindex = 0;
> >  	bool auto_attach = false;
> > +	__u32 meta_ifindex = 0;
> >  	struct bpf_object *obj;
> >  	struct bpf_map *map;
> >  	const char *pinfile;
> >  	unsigned int i, j;
> > -	__u32 ifindex = 0;
> >  	const char *file;
> >  	int idx, err;
> >  
> > @@ -1614,17 +1615,25 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
> >  			map_replace[old_map_fds].fd = fd;
> >  			old_map_fds++;
> >  		} else if (is_prefix(*argv, "dev")) {
> > +			__u32 *cur_ifindex;
> > +
> >  			NEXT_ARG();
> >  
> > -			if (ifindex) {
> > -				p_err("offload device already specified");
> > +			if (offload_ifindex || meta_ifindex) {
> > +				p_err("device already specified");
> 
> I'd add a note to tell somehow that offload and XDP hints are mutually
> exclusive. I suspect not all users understand these well.

Ok, will do.

> 
> >  				goto err_free_reuse_maps;
> >  			}
> > +			if (is_prefix(*argv, "xdpmeta")) {
> > +				cur_ifindex = &meta_ifindex;
> > +				NEXT_ARG();
> > +			} else {
> > +				cur_ifindex = &offload_ifindex;
> > +			}
> >  			if (!REQ_ARGS(1))
> >  				goto err_free_reuse_maps;
> >  
> > -			ifindex = if_nametoindex(*argv);
> > -			if (!ifindex) {
> > +			*cur_ifindex = if_nametoindex(*argv);
> > +			if (!(*cur_ifindex)) {
> >  				p_err("unrecognized netdevice '%s': %s",
> >  				      *argv, strerror(errno));
> >  				goto err_free_reuse_maps;
> > @@ -1671,7 +1680,12 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
> >  				goto err_close_obj;
> >  		}
> >  
> > -		bpf_program__set_ifindex(pos, ifindex);
> > +		if (prog_type == BPF_PROG_TYPE_XDP && meta_ifindex) {
> > +			bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
> > +			bpf_program__set_ifindex(pos, meta_ifindex);
> > +		} else {
> > +			bpf_program__set_ifindex(pos, offload_ifindex);
> > +		}
> >  		if (bpf_program__type(pos) != prog_type)
> >  			bpf_program__set_type(pos, prog_type);
> >  		bpf_program__set_expected_attach_type(pos, expected_attach_type);
> > @@ -1709,7 +1723,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
> >  	idx = 0;
> >  	bpf_object__for_each_map(map, obj) {
> >  		if (bpf_map__type(map) != BPF_MAP_TYPE_PERF_EVENT_ARRAY)
> > -			bpf_map__set_ifindex(map, ifindex);
> > +			bpf_map__set_ifindex(map, offload_ifindex);
> >  
> >  		if (j < old_map_fds && idx == map_replace[j].idx) {
> >  			err = bpf_map__reuse_fd(map, map_replace[j++].fd);
> 
> Could you please also update the following items:
> 
> - The usage message for "bpftool prog load" near the end of prog.c
> 
> - The related doc in Documentation/bpftool-prog.rst (command summary
> near the top, and detailed description later in the doc)
> 
> - Bash completion (for keyword "dev", look for "_sysfs_get_netdevs" in
> bash-completion/bpftool). I'm happy to help with this one if necessary.

Will do all the above in v2.

> 
> Thanks,
> Quentin

