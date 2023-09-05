Return-Path: <bpf+bounces-9275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D130E792EDC
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 21:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF6E1C208CB
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CBADDDE;
	Tue,  5 Sep 2023 19:28:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE6DDD5
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 19:28:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62861B7
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693942098; x=1725478098;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=97+wURU1dO4k4/jkfEIGm49R7R9O56OczWJQnodaMwg=;
  b=XAOjRI/MU947/99yFCfHQK20yky+SE04upaDmY55NfBmXeAH6ojeGU+T
   uTL2JNzk8CvY8PfihC6GkjNy6QggzdZFx7FXPs2Okpr9xtWOizmB+0QEM
   /HiqdJ1N6qiT4s5RQ3D3vbrOnUUkl4W0A58D9Km2/398n7U2gkf0LtIdY
   tdjeJ/li9cnlHaILvwZbj6bRUgtvnfPKb2ZjRPWzDSLhZNtX3mx7LKOWL
   06XbwgwaA2W5eBkbHko7tBjF7BSSoUsnDs8bZ+GNBLLxoo29KzK5jCRmm
   TXoXrhpLI9VvkHLYwSn5evsCeeEW7TW2Pcsapp51gh48AhYJ5ZYD4hH+6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374274684"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="374274684"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 12:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="884427454"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="884427454"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 12:26:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 12:27:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 12:27:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 12:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwdgeQZqa0s4DxrbeUloPMVm6tF8cMSetOzXIQNrxY9b/HYCjPmMRo0r81KKQbbGo4VGgCW7Ir8Ow5Rex1xEIkgKmSjIcCKSxbjjrkB/ex2sI9/bAQ5W8QpnEGBF/S4nKw1s23SgkZ+nbOlSMrYt/IB0Ed1qOA4tloRraH2TBFOiY8EVGc5aQtlhwCig7KjnbgYKnwc8M5krxZwwzxadtf+KGZXHdISMNLJ64dlHeok7rs/TM5puXLDC26HtmTFm05wqQYhIgeW498XuGca9HJlLmdkrz9rGIeflGc5aw90pW82WzSoP3GNLlZKfX7kAMOf52559s83K1giHHgGtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCmK4b8w+jUneVWk9p6jwHhBcVBXlaVK5ggwKRoD0MY=;
 b=nRmL3DFcF7bHmD3+BRmhuYr9erwspD3tuq8DqY+LPr3HG6TNFFC7VvVEeJBKSuUyvfHYEfrA7B9cXttq4MA/wBzm0lqwAnoYGm7SuXRnL5RYULAurIGxZQcA43PrN+WIDLJ4qZEaQgNyOBuSNEy8S3Q/RB0f/3aBVzx14ZPlQAY/cqXWIHtezjT28zrQTzbjVwqmmQoWTnuEVv9ex+7o6O8n74IEoz+3t12iqwxWU/EyF+afIL9UNpxBSYMPIARq6ruhb7/4i4gx3CDyVZC03lr+IWLamRe+RgORRgkzHkA/4r5pjXdXuYh0FHrBp2mhPMrTDfDaGqoJj/RTu343XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ2PR11MB8297.namprd11.prod.outlook.com (2603:10b6:a03:539::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Tue, 5 Sep 2023 19:27:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 19:27:00 +0000
Date: Tue, 5 Sep 2023 21:26:53 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<song@kernel.org>, <iii@linux.ibm.com>, <jakub@cloudflare.com>,
	<bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next v4 1/4] bpf, x64: Comment tail_call_cnt
 initialisation
Message-ID: <ZPeA/XoEQn+OCk/l@boxer>
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
 <20230903151448.61696-2-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230903151448.61696-2-hffilwlqm@gmail.com>
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ2PR11MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e4559e-2810-4f0a-9c7e-08dbae46135f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +o0vaN+W8HN2b0VcQRrganuu3DgFR/z227H1Hy0FO/sffN+wlcGFnFNRRZ+Ut4249KwctIUzsTXTEM/9n9/wiDLhEhj6M/Q5FHxiexjoJOBsnSEZ4V1Q0I40Zr2a4yvigeXtp7/wpSuwXPoXUPVhnIuMtXLU+2IV5PENPVECS7BpNxvntTFUuIbmgPwFhgk7SX2najaUeH+HMu+jxY+XVtXvFM3uU6Hh3/MoyrofYb2BR299YKcOzaQuRPEj5htJi9bkxvsJHSmA9wfvSfIPJlWv48/hooKbU5ReeS3FYsxu1Z4QrBdAUsKqpjOfHjcq7KfRNy4ygIN5B6BhKQDO+xncoEbn8yrYSoUPaxU957KQY5+stV1wEaqSUhMVsxM7bec8vcYmw5UdvUG3o3e+gTKXeB5mFsJymi1aTaR8f2nCw2JX/h3HHRxwFaYUtqTYQZk5CDBQWusfStd9RIk0VRFkiqo+hhWdkm76LL/yfBKkJC0hYClmjIAQuFGsbpNzT80/KakYURnpiuQbrJRWNtTDEF7vAKgdi6mTNlBGOhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(376002)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(41300700001)(33716001)(82960400001)(86362001)(6666004)(83380400001)(966005)(38100700002)(478600001)(26005)(9686003)(6512007)(6486002)(6506007)(66556008)(66476007)(2906002)(316002)(6916009)(66946007)(5660300002)(8936002)(44832011)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V4EXu7NWumRKKXKmMhzhl37rag28IHej76ZPQQmaZC4UjOdgH1Vzd7Xj4Fh/?=
 =?us-ascii?Q?03eUsCC/98uWKnAraNKM8DSsEnXMEUU6+AH3+1e/rqYWZ6UXrRbz9tNcb+TV?=
 =?us-ascii?Q?BLHDJAcglB3tGN3E3oe5H6BCebs+st6JWZfqEL82Pc8TyAq/O/X0aUlE3vrz?=
 =?us-ascii?Q?z4EShJkqAY7G2gs+o4WpJdoJnbIuTAK1JPWgKf9XZDxfALDXdCyCaeMg0bG5?=
 =?us-ascii?Q?ZQIvY9EGGeWbIKLOTbnsIVHyZ7pxRnn6a8j5v9IJyk68XpqyueBVYXdc0rCE?=
 =?us-ascii?Q?UA7JniJpD4zVbkYvh16N/1cCYfNE+y26gg4U8f4c3cmcCeKAHg5bgLOYJco8?=
 =?us-ascii?Q?VgoH2HVxmjNKNIUNU5IR7L0MrCBhlgdk7ru6H6Jo23tPSYwYCm4w30Royzvv?=
 =?us-ascii?Q?bPx+vdPnjfDBTH+Z3qH4s6azwdxn76olQ2wdcJ1zdyuELz56SjsmaR/DVAb4?=
 =?us-ascii?Q?GzJAsyIJQG9T3m7kxqFhKVk+QE7M2idUj0Fdvvh7G3MHwu1l/KDlQ2jo9J0Y?=
 =?us-ascii?Q?Vosfpk2hFoOXx07rHP4LTLzD9ZHxuN8sbUMx2/pySqAJTThU1m2gme6OUihA?=
 =?us-ascii?Q?4BZWQHMIIhLf+AGRb/9V09ENr4spzNL+UbimvQhMEiQ1ZEVXeOiIz4iJHI13?=
 =?us-ascii?Q?37VboPSMpoOQW39AsWK9qcQQd7JsUET6KbKBmcx+w7x83+oWJp4zK/UCIKdS?=
 =?us-ascii?Q?NjKQBU6Z9EbRs333iXEXoVjjuRRGqMIC1GBCgnSHs5mcIpcTsdjHEwc1y1Rw?=
 =?us-ascii?Q?ti7LV4i+bv3v7hZqjYgvfxcSVJ/vw/LRw+qiamAV2Fb1MV8OcLrdFFjqxzPx?=
 =?us-ascii?Q?oglujPlweQbGfzIn7ue8v3qnAtwRHWNqEd9vmxmIgERVV5Dy4FuvcGJQrI+/?=
 =?us-ascii?Q?3VfbCRH4exPqskf8vn1xgAJeKzY+F0JSTIkIr0/Mmf0PJmsbu+6I1McsCTgj?=
 =?us-ascii?Q?EpzLxjCTYeTS3sAubq/ZIfFvbg/u2JGfunKTEUocTcjjQRczQbDslQmPweJg?=
 =?us-ascii?Q?i0z3FFjcxSqeUCqnySHy3splY7HcQx6U7tFITWICDq1YJs2Fwh2BWy5FWxLA?=
 =?us-ascii?Q?GOOzEiVn+uqG5cG5oQcCj8pFtwm1MV3FY9ajIMD40MIvYDvRQcZ2a7XHW/Nm?=
 =?us-ascii?Q?xNKxpM/7XZvojimf0qN5j+BvMBgaP6/lLGqYndDqg9v5UuiwtlkEzIAFmh1z?=
 =?us-ascii?Q?k6+Ih0Qzqj/WkqZXXVlRe25gzHuX9w9Tz92nJv/ACE7AeZjwP3TNmKDw/4Ty?=
 =?us-ascii?Q?qHCI/Qm16/cf8Zb+IAGjZ6bwcZUbO7S30/HNiA9TfL5oF5Qg0PWRlysFUI2E?=
 =?us-ascii?Q?FNumi628G9GnimtXH0kd+teEc1tB7xXNbslz915A8eGH/JbaGKP8HiO1ailP?=
 =?us-ascii?Q?TFojjRchTbAZgrtQ4LVY+9dsriysCJrPYhipJrMrslMjfN+hS9/5TqAii0Gi?=
 =?us-ascii?Q?BzsyVKXltCuuJO3e6uheCXSEe8WTzxAeaKOdbPlN1+K2QSvLZswaOGJTCaR5?=
 =?us-ascii?Q?V8qx3tr+j2LNqAx4wXzdLyipdWj5W7IdRyS8b81pC/CPkgDoYO1c/wq58NUz?=
 =?us-ascii?Q?h9LUQE8A/1UBcc+fXs8UzcKv6RoovydNE5R6/7k6OKJ+S9MeyZQpVVrTssVS?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e4559e-2810-4f0a-9c7e-08dbae46135f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 19:27:00.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mb76fnZ6+4wAkugO+yQQmyMws0K85axUg8lz2592ljngA/rIZgykc/UkDNFZ/d+8k41nQ7Xzaubyc5+YWKO0zkCBbS0nzz4VaPnHiLzcuqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8297
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 03, 2023 at 11:14:45PM +0800, Leon Hwang wrote:
> Without understanding emit_prologue(), it is really hard to figure out
> where does tail_call_cnt come from, even though searching tail_call_cnt
> in the whole kernel repo.
> 
> By adding these comments, it is a little bit easy to understand

s/easy/easier

> tail_call_cnt initialisation.
> 
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>

I was rather thinking about dropping these comments altogether. We should
be trying to provide fixes as small as possible IMHO.

Having this as a separate commit also breaks logistics of this set as
the fix + selftest should be routed towards bpf tree, whereas this
particular commit is rather a bpf-next candidate.

PTAL at https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html

> ---
>  arch/x86/net/bpf_jit_comp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a5930042139d3..bcca1c9b9a027 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -303,8 +303,12 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>  	prog += X86_PATCH_SIZE;
>  	if (!ebpf_from_cbpf) {
>  		if (tail_call_reachable && !is_subprog)
> +			/* When it's the entry of the whole tailcall context,
> +			 * zeroing rax means initialising tail_call_cnt.
> +			 */
>  			EMIT2(0x31, 0xC0); /* xor eax, eax */
>  		else
> +			/* Keep the same instruction layout. */
>  			EMIT2(0x66, 0x90); /* nop2 */
>  	}
>  	EMIT1(0x55);             /* push rbp */
> -- 
> 2.41.0
> 

