Return-Path: <bpf+bounces-17993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA8D8148E9
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 14:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BC89B215C6
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31CB2DB7F;
	Fri, 15 Dec 2023 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWWLM34M"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F02DB87
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702646214; x=1734182214;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=npa8aJTqWcGRK0fe1TPjoVKD6Bbwu2DIUerxFr4JHs8=;
  b=DWWLM34MejKuzX1rdbBHNWYsYpK/kxti3WbuHF7I+r0p44fj88+dG4B5
   y8gGFE54COHskrbRBLDqRkJkplc0PsEQFKZgHHrqwsaOdgD6Shcai5Plt
   7cCmalfJqaxYZZ+7z17SbhbKz+DkeMsCfpPopOGdBAqBs3D11GX/1mpHO
   XqzRImUPt6tAsL7qAd7kA7JMIn6Opbvnm13TAEt9KrCRsTEf2i8h3/e1K
   ieGSoFBeLDuAakpOt3MOBheDeyVb4KzXG8+8TGhzhpJp8fwli1/T2unoA
   f94w5Lgsc4lKQ/hRxDEwFQtJ2rHJ9bp00zMqsaM88n+8rpu3XnefhWLxb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="459594689"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="log'?scan'208";a="459594689"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 05:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="750930110"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="log'?scan'208";a="750930110"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 05:16:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 05:16:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 05:16:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 05:16:51 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 05:16:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6HlGHn+GrR9mSY+OH+0vSTBZ/FSh+DP3vJ8uCl7yT19XeCryC55BkxLc49/jUy63GV8t1qQeW/eRbi4a5BABfWEF2zBiBPYxv/PB0zUCsuUBrf47IRsLt9Z39KnAK5lqinJXDLdLQD+D3G3PEixPyCS9ULGcQoeG5/MqFQdy3mP0gNy04M2im1BT9RywQ0mTlDzJcHV8hwxxPIXJ08L+c53pUNjz64rAiH7AvNCh/a7gGUf7iw9wJpHOot5Y9FxfL0kFUVNv7tpKCf/yebM53pYEpSw5AGipUHFsTjbAVZ2rI4iuodxYZ0k7c0Wnlk460dvlLWMoRyWwXZw8eKxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQxM+UqtkYXX2HFhfdSUL7RQMai2OAisnQ0NUORHpos=;
 b=d8kol+OAbXePmz27sW2PZodkURwodQEIs+4Sr4p6Q+YwWWGifU2lJJvbAG3izzKzu1pPu/WmnnA+WcfK2Pav+xKxSEWdCQQINi1dl+nAE16GgGfqJqFeMPGZFylU2QMAe+HOCsJL4hXakQLip6feJ7GYz8aun9VHuWYdczb4DGa6kV5d1xF2OkYCU2/A6CxkVMLm6djVFAjVyqYH6M5XUnkJxZXKbFsV1iYN3EsqK0Q8gp/+k+ts30oIYdvOVxBGZ4R/YMKbSLt+kmxjQsHUn8zOIZZDL1cbjOo/mwZbc7hCXuZQE8eLgVwCdYnmFf6rD8PWpkWHOEdorcw7uxlzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM6PR11MB4612.namprd11.prod.outlook.com (2603:10b6:5:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 13:16:49 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 13:16:48 +0000
Date: Fri, 15 Dec 2023 21:11:03 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Jiri Olsa <jolsa@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	<bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu
	<songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, "Stanislav
 Fomichev" <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao
	<houtao@huaweicloud.com>
Subject: Re: [PATCH bpf] bpf: Add missing BPF_LINK_TYPE invocations
Message-ID: <ZXxQZ3KnlqeCPnxZ@xpf.sh.intel.com>
References: <20231215091826.2467281-1-jolsa@kernel.org>
Content-Type: multipart/mixed; boundary="zUtZHo7NizW+qsCr"
Content-Disposition: inline
In-Reply-To: <20231215091826.2467281-1-jolsa@kernel.org>
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM6PR11MB4612:EE_
X-MS-Office365-Filtering-Correlation-Id: 83eaad2d-8a7c-4b5a-ad33-08dbfd7017ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7gkppcKri3MILqK+kgLj6aVXQ8X5WRVWCxZR2tjrqMMooIBHwi/QskWkjU/0MKuEbEodeWPytW8JbmL9elin841ohDssVJlLON6+IMxFFyCpdABeTGAR4jjPngTveYhx2bcOFGE6depgyWaq4DDsPyFZ+IFnWSO3rq6NBWhOojIqWPe8J6RuVKMeT623qbNnyT1AsWj2prlhS2/AJaiWef3+y4MmFvV8UxzjlGN6PY52K9Si2ZwjMpjwr7d/GHUMpsDuVnoaOafkjeRKBZcBNvBCUyQ2EhfZzXq4Hm8fLbvxWtKfSlcW842B3uG/8mo2qfpMJ/I+Z8s+NIRtXGRb6gBZeYZk8nd1azCzUumY0ihnjfboRXk8X9LwdjXBnpCP6RIWytUWVZ1dm1zCX3p1BjcdRonsQ5FMkSXTRON1E5Y2dOfDGCl+zHIWiMMEbkzH4lxlEFhUAB1bYG2nu11mm2Ic3HRopFLLuNu/orkcZPmCpfciBinMi6cOv4Bya1ohuwaHnVcKuscg3xdWDMiVsrJFjz/Sqv6QsKZ1QmQWW4gbTXboyarSIhbazeyw4nIP7waFcwFzvZyGhS81yV26MYhPQotDVLgY69re5i1sQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82960400001)(2906002)(7416002)(5660300002)(4001150100001)(235185007)(53546011)(6666004)(6506007)(21480400003)(38100700002)(44144004)(26005)(6512007)(478600001)(6916009)(54906003)(66476007)(66556008)(66946007)(6486002)(966005)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002)(44832011)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2h99U7Nu615KBXbITPM/BcDn7AR/pGlqA7w7mN2vBZy6FOB1Obnm2T7S+jja?=
 =?us-ascii?Q?1gFcTXLQCwSHnZYUoReVZfk9EZvvaRmARYQpzoQuYbYVG3m959MYsCZ7pR7W?=
 =?us-ascii?Q?+fPfeUxvnMVvvwiIk+P7bg99sa2AdvnZ8g0S2jt5p1GIzlHsaEhizgpVyrnS?=
 =?us-ascii?Q?Kkkv64KNorat9G+zWtX5L20FH2DwA059mA089ZhdND9RK+3IaSHevWBbbL0u?=
 =?us-ascii?Q?MOGzPvmDPaj3iTQCVJJoy1HxEqcKo7righuK0Y5vv+1Yb+1QrbQ+rguCKt1+?=
 =?us-ascii?Q?PUD+U2qLEpDGmKXyPxgACqbm8RxDXQGOUmtcreErGe9JxzQXvl0dNIBQCFju?=
 =?us-ascii?Q?0Pio6Ig7xi47rrZr5tZkH2AQhtzSy+K9T1uY52QQFOuWe1OAii2D24snd130?=
 =?us-ascii?Q?d4tgdRq9O6TU7T8g7dF8RtqdgF8X9aTnh2Ie+Kf3XV8rjAoyHUGOXn/ZrvE0?=
 =?us-ascii?Q?bMWWrg1Zk1RdvYMVGrg8LjnevDF4+/RjpbbCzOo8iO0UPkexMEFaJlU9vs9U?=
 =?us-ascii?Q?SbfULXIOhJem2y+UT+iXmqBM3F3A4RPQW4C/WL2n1D3BMwat4JIfEHHn3H8O?=
 =?us-ascii?Q?NHLA71RaExYVe2F+dkI9/f8WKrBhaS++OwgHwiO/7/r0Sb6jLqduKxllNwgM?=
 =?us-ascii?Q?PMTaAug5cVIxAdLwoqlq6EN/8+ZigqgaUHt0UHsqYW4Upp5TIg0/NUj21xsV?=
 =?us-ascii?Q?sU0rft26qGVKEBe5/FpEsIBuO22dwg07NwnhKoXrXjkztRXqc5eaBiwZyKQz?=
 =?us-ascii?Q?b/dO1aMbPBNP3HkCMdJjJIGBfUmzwVNbo5coLTmtGx2NNCvuG2BhNFEeoty1?=
 =?us-ascii?Q?mmdOwUE2ipRM6TBdX7z49c+EL23g8Tao812iAjJnhNGESTlC7YZZjA/nxQeF?=
 =?us-ascii?Q?n2hNYZ10SZ9wgSCfCu0mBmi6VfgEAz4pfKBP4mX8PnucdS++CxA9y78PJvEX?=
 =?us-ascii?Q?0/EffGo19ylz53fBIKK+/fPr3/ykCS5sLcOHrPSovVFRtmNs2w1lomZDK9Bx?=
 =?us-ascii?Q?Tb9WMjpdvWRTENkV8Yul4PQ4fCpi/s7T5zuvi+9n2fxTM3j1VdQBXTS6OZrD?=
 =?us-ascii?Q?eq7zdokjLx4JScNRxp8hlZ6snM05NLAFnxEJ8c+g5h8phuUxE7U1A2K/P67f?=
 =?us-ascii?Q?eTGlbKtX84npMqyeH8vGDITA1k2YlWprudXJVXCZC4xlT9M3aOw6X9UMidFm?=
 =?us-ascii?Q?Zd0R1S9WaLjg6pIML51oOX8MzWBZXjMzPjZGV45iH9heO/SQiVn4vnpP6r5z?=
 =?us-ascii?Q?KV3T5s/tcHc5jZ7MYOvJRs6vVAoa0has8Lgqk+lzUCYx8SvBTsAONQ2U22dZ?=
 =?us-ascii?Q?h0KnuQcXqwSUoNqLmb/LzbiwlmhBmoVbvpAJlI+J0dsjqpYL7ysBfycMjjj9?=
 =?us-ascii?Q?WSzFkg4mIMfFXINHRuJgmLXutlrr1FW+851jGHtjAgKOrudm/ZvzG3cABgOS?=
 =?us-ascii?Q?JD79F2bTkB/fdfzmQB9yKpt7FFDjFpMlusUY2lBsEfb7ir5o89+sXbab/jDF?=
 =?us-ascii?Q?G3iFsP0w/vKwRdjCazaDoMoZvexk2xr0dbXewr5wl1VMMGi9rC+VcFIqB6kG?=
 =?us-ascii?Q?NyUHnIGlp15q9XeqVlR+w2hpG5FLZmaYRKppUR18W/HQKoVnINqM/sNcjB1R?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eaad2d-8a7c-4b5a-ad33-08dbfd7017ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 13:16:48.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XmO9GUrXozrO/jz4qxoR8PBsulb8ZO2IkBEyMPqo3JAgERXy2Cilk354Zpy3/G8s71DkzbnTDC8suev8NW4Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4612
X-OriginatorOrg: intel.com

--zUtZHo7NizW+qsCr
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 2023-12-15 at 10:18:26 +0100, Jiri Olsa wrote:
> Pengfei Xu reported [1] Syzkaller/KASAN issue found in bpf_link_show_fdinfo.
> 
> The reason is missing BPF_LINK_TYPE invocation for uprobe multi
> link and for several other links, adding that.
> 
> [1] https://lore.kernel.org/bpf/ZXptoKRSLspnk2ie@xpf.sh.intel.com/
> 
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Fixes: 84601d6ee68a ("bpf: add bpf_link support for BPF_NETFILTER programs")
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf_types.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index fc0d6f32c687..38cbdaec6bdf 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -148,3 +148,7 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
>  #endif
>  BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)

I tested the above fixed patch on top of v6.7-rc5 kernel.
This problem was gone, it's fixed.
Attached is the fixed dmesg log.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>

Thanks!

> -- 
> 2.43.0
> 

--zUtZHo7NizW+qsCr
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="v6.7-rc5_bpf_fix_dmesg.log"

[    0.000000] Linux version 6.7.0-rc5-fix-dirty (root@xpf.sh.intel.com) (gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-20), GNU ld version 2.36.1-2.el8)3
[    0.000000] Command line: console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg  plymouth.enable=0
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] printk: legacy bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000002] kvm-clock: using sched offset of 520979039 cycles
[    0.000439] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.001831] tsc: Detected 1881.600 MHz processor
[    0.008679] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.008708] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.008728] last_pfn = 0x7ffe0 max_arch_pfn = 0x400000000
[    0.009423] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
[    0.010223] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.015345] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
[    0.016040] Using GB pages for direct mapping
[    0.018329] ACPI: Early table checksum verification disabled
[    0.018883] ACPI: RSDP 0x00000000000F59C0 000014 (v00 BOCHS )
[    0.019446] ACPI: RSDT 0x000000007FFE1951 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.020444] ACPI: FACP 0x000000007FFE17FD 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.021279] ACPI: DSDT 0x000000007FFE0040 0017BD (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.022102] ACPI: FACS 0x000000007FFE0000 000040
[    0.022561] ACPI: APIC 0x000000007FFE1871 000080 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.023383] ACPI: HPET 0x000000007FFE18F1 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.024224] ACPI: WAET 0x000000007FFE1929 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.025052] ACPI: Reserving FACP table memory at [mem 0x7ffe17fd-0x7ffe1870]
[    0.025724] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe17fc]
[    0.026410] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe003f]
[    0.027084] ACPI: Reserving APIC table memory at [mem 0x7ffe1871-0x7ffe18f0]
[    0.027796] ACPI: Reserving HPET table memory at [mem 0x7ffe18f1-0x7ffe1928]
[    0.028495] ACPI: Reserving WAET table memory at [mem 0x7ffe1929-0x7ffe1950]
[    0.029756] No NUMA configuration found
[    0.030144] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]
[    0.030962] NODE_DATA(0) allocated [mem 0x7ffb5000-0x7ffdffff]
[    0.033026] Zone ranges:
[    0.033344]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.034136]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]
[    0.034924]   Normal   empty
[    0.035328]   Device   empty
[    0.035719] Movable zone start for each node
[    0.036311] Early memory node ranges
[    0.036662]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.037317]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]
[    0.037963] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdffff]
[    0.039026] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.039186] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.063239] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.200399] kasan: KernelAddressSanitizer initialized
[    0.201988] ACPI: PM-Timer IO Port: 0x608
[    0.202490] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.203229] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.204095] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.204919] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.205715] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.206502] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.207220] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.208220] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.209014] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.209548] TSC deadline timer available
[    0.210033] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.210571] kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
[    0.211260] kvm-guest: KVM setup pv remote TLB flush
[    0.211751] kvm-guest: setup PV sched yield
[    0.212196] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.212970] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.213736] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.214530] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.215404] [mem 0x80000000-0xfeffbfff] available for PCI devices
[    0.216194] Booting paravirtualized kernel on KVM
[    0.216857] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.218380] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.220972] percpu: Embedded 82 pages/cpu s299008 r8192 d28672 u1048576
[    0.221864] pcpu-alloc: s299008 r8192 d28672 u1048576 alloc=1*2097152
[    0.221892] pcpu-alloc: [0] 0 1 
[    0.222025] kvm-guest: PV spinlocks enabled
[    0.222586] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.223567] Kernel command line: net.ifnames=0 console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg  plymouth.enable=0
[    0.225551] random: crng init done
[    0.269856] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.271735] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.272913] Fallback order for Node 0: 0 
[    0.272927] Built 1 zonelists, mobility grouping on.  Total pages: 515808
[    0.274231] Policy zone: DMA32
[    0.274532] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.275192] stackdepot: allocating hash table via alloc_large_system_hash
[    0.281342] stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.314369] Memory: 1627232K/2096632K available (73728K kernel code, 14095K rwdata, 16700K rodata, 14912K init, 21912K bss, 469144K reserved, 0K)
[    0.317207] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.318004] kmemleak: Kernel memory leak detector disabled
[    0.318869] ftrace: allocating 72459 entries in 284 pages
[    0.343522] ftrace: allocated 284 pages with 4 groups
[    0.348383] Dynamic Preempt: voluntary
[    0.349267] Running RCU self tests
[    0.349678] Running RCU synchronous self tests
[    0.350193] rcu: Preemptible hierarchical RCU implementation.
[    0.350986] rcu:     RCU lockdep checking is enabled.
[    0.351604] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
[    0.352452]  Trampoline variant of Tasks RCU enabled.
[    0.353045]  Rude variant of Tasks RCU enabled.
[    0.353571]  Tracing variant of Tasks RCU enabled.
[    0.354064] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.354941] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.355873] Running RCU synchronous self tests
[    0.395524] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16
[    0.396981] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.404907] Console: colour VGA+ 80x25
[    0.405373] printk: legacy console [ttyS0] enabled
[    0.406358] printk: legacy bootconsole [earlyser0] disabled
[    0.407798] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.408743] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.409299] ... MAX_LOCK_DEPTH:          48
[    0.409848] ... MAX_LOCKDEP_KEYS:        8192
[    0.410445] ... CLASSHASH_SIZE:          4096
[    0.411002] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.411597] ... MAX_LOCKDEP_CHAINS:      65536
[    0.412243] ... CHAINHASH_SIZE:          32768
[    0.412693]  memory used by lock dependency info: 6493 kB
[    0.413347]  memory used for stack traces: 4224 kB
[    0.413970]  per task-struct memory footprint: 1920 bytes
[    0.414862] ACPI: Core revision 20230628
[    0.416056] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.417348] APIC: Switch to symmetric I/O mode setup
[    0.418120] x2apic enabled
[    0.418823] APIC: Switched APIC routing to: physical x2apic
[    0.419482] kvm-guest: APIC: send_IPI_mask() replaced with kvm_send_ipi_mask()
[    0.420334] kvm-guest: APIC: send_IPI_mask_allbutself() replaced with kvm_send_ipi_mask_allbutself()
[    0.421461] kvm-guest: setup PV IPIs
[    0.423034] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.423737] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x363e8c91135, max_idle_ns: 881590568389 ns
[    0.424880] Calibrating delay loop (skipped) preset value.. 3763.20 BogoMIPS (lpj=7526400)
[    0.428986] CPU0: Thermal monitoring enabled (TM1)
[    0.429530] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.430369] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.430954] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.431825] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.432869] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.434328] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.435226] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.436866] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.438029] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.439117] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.440283] MMIO Stale Data: Unknown: No mitigations
[    0.440913] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.442024] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.443077] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.443938] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.444866] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.445844] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.446767] x86/fpu: Enabled xstate features 0x207, context size is 840 bytes, using 'compacted' format.
[    0.558928] Freeing SMP alternatives memory: 56K
[    0.559622] pid_max: default: 32768 minimum: 301
[    0.560560] LSM: initializing lsm=capability,yama,integrity
[    0.560880] Yama: becoming mindful.
[    0.561743] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.562579] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.565933] Running RCU synchronous self tests
[    0.566436] Running RCU synchronous self tests
[    0.568286] smpboot: CPU0: Genuine Intel(R) 0000 (family: 0x6, model: 0xba, stepping: 0x2)
[    0.568852] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    0.568852] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    0.569029] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    0.570248] Running RCU Tasks wait API self tests
[    0.571168] Running RCU Tasks Rude wait API self tests
[    0.571985] Running RCU Tasks Trace wait API self tests
[    0.572731] Performance Events: unsupported p6 CPU model 186 no PMU driver, software events only.
[    0.572896] signal: max sigframe size: 3632
[    0.573540] rcu: Hierarchical SRCU implementation.
[    0.574021] rcu:     Max phase no-delay instances is 1000.
[    0.577025] Callback from call_rcu_tasks_trace() invoked.
[    0.581083] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.582190] smp: Bringing up secondary CPUs ...
[    0.583854] smpboot: x86: Booting SMP configuration:
[    0.584534] .... node  #0, CPUs:      #1
[    0.585258] smp: Brought up 1 node, 2 CPUs
[    0.586122] smpboot: Max logical packages: 1
[    0.586724] smpboot: Total of 2 processors activated (7526.40 BogoMIPS)
[    0.590328] devtmpfs: initialized
[    0.593152] x86/mm: Memory block size: 128MB
[    0.602006] Running RCU synchronous self tests
[    0.602143] Running RCU synchronous self tests
[    0.602760] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.604876] futex hash table entries: 512 (order: 4, 65536 bytes, linear)
[    0.606411] pinctrl core: initialized pinctrl subsystem

[    0.608115] *************************************************************
[    0.608861] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.609891] **                                                         **
[    0.610782] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    0.611526] **                                                         **
[    0.612345] ** This means that this kernel is built to expose internal **
[    0.612860] ** IOMMU data structures, which may compromise security on **
[    0.613733] ** your system.                                            **
[    0.614625] **                                                         **
[    0.615490] ** If you see this message and you are not debugging the   **
[    0.616326] ** kernel, report this immediately to your vendor!         **
[    0.616865] **                                                         **
[    0.617575] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.618331] *************************************************************
[    0.619084] PM: RTC time: 12:58:56, date: 2023-12-15
[    0.623774] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.626167] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.627195] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.628262] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.629012] audit: initializing netlink subsys (disabled)
[    0.629797] audit: type=2000 audit(1702645136.817:1): state=initialized audit_enabled=0 res=1
[    0.632956] thermal_sys: Registered thermal governor 'fair_share'
[    0.632966] thermal_sys: Registered thermal governor 'bang_bang'
[    0.633839] thermal_sys: Registered thermal governor 'step_wise'
[    0.634621] thermal_sys: Registered thermal governor 'user_space'
[    0.635622] cpuidle: using governor ladder
[    0.636887] cpuidle: using governor menu
[    0.637831] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.639493] PCI: Using configuration type 1 for base access
[    0.641364] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.736853] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.736853] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.736865] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.737532] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.741318] Callback from call_rcu_tasks_rude() invoked.
[    0.744853] ACPI: Added _OSI(Module Device)
[    0.744853] ACPI: Added _OSI(Processor Device)
[    0.744853] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.744853] ACPI: Added _OSI(Processor Aggregator Device)
[    0.773913] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.783193] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.784046] ACPI: Interpreter enabled
[    0.784633] ACPI: PM: (supports S0 S3 S4 S5)
[    0.784862] ACPI: Using IOAPIC for interrupt routing
[    0.785517] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.786450] PCI: Using E820 reservations for host bridge windows
[    0.789006] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.848125] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.848852] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.849684] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.850991] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    0.860002] acpiphp: Slot [3] registered
[    0.860646] acpiphp: Slot [4] registered
[    0.865122] acpiphp: Slot [5] registered
[    0.865755] acpiphp: Slot [6] registered
[    0.866384] acpiphp: Slot [7] registered
[    0.867015] acpiphp: Slot [8] registered
[    0.867693] acpiphp: Slot [9] registered
[    0.868323] acpiphp: Slot [10] registered
[    0.868970] acpiphp: Slot [11] registered
[    0.869631] acpiphp: Slot [12] registered
[    0.870293] acpiphp: Slot [13] registered
[    0.870929] acpiphp: Slot [14] registered
[    0.871583] acpiphp: Slot [15] registered
[    0.872216] acpiphp: Slot [16] registered
[    0.872882] acpiphp: Slot [17] registered
[    0.873542] acpiphp: Slot [18] registered
[    0.874180] acpiphp: Slot [19] registered
[    0.874822] acpiphp: Slot [20] registered
[    0.875506] acpiphp: Slot [21] registered
[    0.876190] acpiphp: Slot [22] registered
[    0.876846] acpiphp: Slot [23] registered
[    0.877091] acpiphp: Slot [24] registered
[    0.877755] acpiphp: Slot [25] registered
[    0.878442] acpiphp: Slot [26] registered
[    0.879140] acpiphp: Slot [27] registered
[    0.879815] acpiphp: Slot [28] registered
[    0.880489] acpiphp: Slot [29] registered
[    0.881104] acpiphp: Slot [30] registered
[    0.881758] acpiphp: Slot [31] registered
[    0.882313] PCI host bridge to bus 0000:00
[    0.882748] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.883465] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.884163] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.884866] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff window]
[    0.885625] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.886406] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.887283] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.907760] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.910549] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.912868] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    0.914124] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.914861] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.915523] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.916245] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.917538] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.918531] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.919270] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.920611] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.925572] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.928810] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.932699] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.933056] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.955958] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.957256] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.958837] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.963644] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.997368] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    1.000130] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    1.002777] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    1.005364] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    1.006802] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    1.012853] iommu: Default domain type: Translated
[    1.012853] iommu: DMA domain TLB invalidation policy: lazy mode
[    1.021188] SCSI subsystem initialized
[    1.022010] libata version 3.00 loaded.
[    1.022411] ACPI: bus type USB registered
[    1.023096] usbcore: registered new interface driver usbfs
[    1.023791] usbcore: registered new interface driver hub
[    1.024457] usbcore: registered new device driver usb
[    1.025290] pps_core: LinuxPPS API ver. 1 registered
[    1.025832] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.026858] PTP clock support registered
[    1.027870] EDAC MC: Ver: 3.0.0
[    1.028677] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    1.032866] NetLabel: Initializing
[    1.032866] NetLabel:  domain hash size = 128
[    1.033332] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.034196] NetLabel:  unlabeled traffic allowed by default
[    1.035558] PCI: Using ACPI for IRQ routing
[    1.036025] PCI: pci_cache_line_size set to 64 bytes
[    1.036121] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.036144] e820: reserve RAM buffer [mem 0x7ffe0000-0x7fffffff]
[    1.036498] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.036852] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.036852] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.036861] vgaarb: loaded
[    1.038317] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.038872] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.055092] clocksource: Switched to clocksource kvm-clock
[    1.072206] VFS: Disk quotas dquot_6.6.0
[    1.072778] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.074409] pnp: PnP ACPI init
[    1.076045] pnp 00:02: [dma 2]
[    1.081215] pnp: PnP ACPI: found 6 devices
[    1.105351] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.142242] NET: Registered PF_INET protocol family
[    1.143656] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    1.146343] tcp_listen_portaddr_hash hash table entries: 1024 (order: 4, 73728 bytes, linear)
[    1.147404] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    1.148301] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    1.149492] TCP bind hash table entries: 16384 (order: 9, 2359296 bytes, linear)
[    1.152684] TCP: Hash tables configured (established 16384 bind 16384)
[    1.154260] UDP hash table entries: 1024 (order: 5, 163840 bytes, linear)
[    1.155221] UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes, linear)
[    1.156571] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.158577] RPC: Registered named UNIX socket transport module.
[    1.159298] RPC: Registered udp transport module.
[    1.159817] RPC: Registered tcp transport module.
[    1.160330] RPC: Registered tcp-with-tls transport module.
[    1.160920] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.161669] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.162348] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.163019] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.163775] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff window]
[    1.164519] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    1.165865] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    1.166505] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    1.167285] PCI: CLS 0 bytes, default 64
[    1.168576] ACPI: bus type thunderbolt registered
[    1.169718] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x363e8c91135, max_idle_ns: 881590568389 ns
[    2.421297] Initialise system trusted keyrings
[    2.421967] Key type blacklist registered
[    2.422859] workingset: timestamp_bits=36 max_order=19 bucket_order=0
[    2.423652] zbud: loaded
[    2.426389] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.430695] NFS: Registering the id_resolver key type
[    2.431574] Key type id_resolver registered
[    2.432188] Key type id_legacy registered
[    2.432878] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    2.433933] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    2.435686] fuse: init (API version 7.39)
[    2.437053] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    2.440335] 9p: Installing v9fs 9p2000 file system support
[    2.449408] Key type asymmetric registered
[    2.449900] Asymmetric key parser 'x509' registered
[    2.450587] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    2.452002] io scheduler mq-deadline registered
[    2.452895] io scheduler bfq registered
[    2.455482] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.457609] IPMI message handler: version 39.2
[    2.458303] ipmi device interface
[    2.461043] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    2.462484] ACPI: button: Power Button [PWRF]
[    2.465362] ERST DBG: ERST support is disabled.
[    2.467757] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.468646] serial 00:04: using ACPI '\_SB.PCI0.ISA.COM1' for 'rs485-term' GPIO lookup
[    2.468675] acpi PNP0501:00: GPIO: looking up rs485-term-gpios
[    2.468682] acpi PNP0501:00: GPIO: looking up rs485-term-gpio
[    2.468688] serial 00:04: using lookup tables for GPIO lookup
[    2.468713] serial 00:04: No GPIO consumer rs485-term found
[    2.468720] serial 00:04: using ACPI '\_SB.PCI0.ISA.COM1' for 'rs485-rx-during-tx' GPIO lookup
[    2.468732] acpi PNP0501:00: GPIO: looking up rs485-rx-during-tx-gpios
[    2.468739] acpi PNP0501:00: GPIO: looking up rs485-rx-during-tx-gpio
[    2.468745] serial 00:04: using lookup tables for GPIO lookup
[    2.468750] serial 00:04: No GPIO consumer rs485-rx-during-tx found
[    2.470151] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.504606] Linux agpgart interface v0.103
[    2.507488] ACPI: bus type drm_connector registered
[    2.520550] Callback from call_rcu_tasks() invoked.
[    2.534066] brd: module loaded
[    2.550611] loop: module loaded
[    2.557957] ata_piix 0000:00:01.1: version 2.13
[    2.609892] scsi host0: ata_piix
[    2.611861] scsi host1: ata_piix
[    2.612826] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14 lpm-pol 0
[    2.613834] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15 lpm-pol 0
[    2.616396] mdio_bus fixed-0: using lookup tables for GPIO lookup
[    2.616408] mdio_bus fixed-0: No GPIO consumer reset found
[    2.617353] tun: Universal TUN/TAP device driver, 1.6
[    2.618722] e100: Intel(R) PRO/100 Network Driver
[    2.619387] e100: Copyright(c) 1999-2006 Intel Corporation
[    2.620272] e1000: Intel(R) PRO/1000 Network Driver
[    2.620818] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.775386] ata2: found unknown device (class 0)
[    2.776236] ata1: found unknown device (class 0)
[    2.777278] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    2.777871] ata1.00: 17196647 sectors, multi 16: LBA48 
[    2.778807] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    2.781182] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    2.784696] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.785816] sd 0:0:0:0: [sda] 17196647 512-byte logical blocks: (8.80 GB/8.20 GiB)
[    2.787778] sd 0:0:0:0: [sda] Write Protect is off
[    2.788283] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.788496] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.789433] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    2.790474] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    2.797453] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.813819] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    4.252803] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    4.574783] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    4.575495] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    4.576294] e1000e: Intel(R) PRO/1000 Network Driver
[    4.576728] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.577379] igb: Intel(R) Gigabit Ethernet Network Driver
[    4.577888] igb: Copyright (c) 2007-2014 Intel Corporation.
[    4.578616] PPP generic driver version 2.4.2
[    4.579979] VFIO - User Level meta-driver version: 0.3
[    4.581978] usbcore: registered new interface driver uas
[    4.582697] usbcore: registered new interface driver usb-storage
[    4.583596] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    4.585319] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.585856] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.587559] mousedev: PS/2 mouse device common for all mice
[    4.589767] rtc_cmos 00:05: RTC can wake from S4
[    4.591870] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    4.594097] rtc_cmos 00:05: registered as rtc0
[    4.594674] rtc_cmos 00:05: setting system clock to 2023-12-15T12:59:00 UTC (1702645140)
[    4.597068] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
[    4.598341] rtc_cmos 00:05: using ACPI '\_SB.PCI0.ISA.RTC' for 'wp' GPIO lookup
[    4.598363] acpi PNP0B00:00: GPIO: looking up wp-gpios
[    4.598371] acpi PNP0B00:00: GPIO: looking up wp-gpio
[    4.598377] rtc_cmos 00:05: using lookup tables for GPIO lookup
[    4.598384] rtc_cmos 00:05: No GPIO consumer wp found
[    4.598689] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    4.599837] i2c_dev: i2c /dev entries driver
[    4.601339] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    4.601806] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[    4.602593] device-mapper: uevent: version 1.0.3
[    4.604598] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    4.605457] intel_pstate: CPU model not supported
[    4.606208] sdhci: Secure Digital Host Controller Interface driver
[    4.606988] sdhci: Copyright(c) Pierre Ossman
[    4.607684] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.608346] ledtrig-cpu: registered to indicate activity on CPUs
[    4.609358] drop_monitor: Initializing network drop monitor service
[    4.610470] NET: Registered PF_INET6 protocol family
[    4.616870] Segment Routing with IPv6
[    4.617341] In-situ OAM (IOAM) with IPv6
[    4.617856] NET: Registered PF_PACKET protocol family
[    4.618646] 9pnet: Installing 9P2000 support
[    4.619561] Key type dns_resolver registered
[    4.622254] IPI shorthand broadcast: enabled
[    4.671736] sched_clock: Marking stable (4652016490, 19182345)->(4677606007, -6407172)
[    4.673768] registered taskstats version 1
[    4.674913] Loading compiled-in X.509 certificates
[    4.727424] Key type .fscrypt registered
[    4.728043] Key type fscrypt-provisioning registered
[    4.735970] Key type encrypted registered
[    4.736622] ima: No TPM chip found, activating TPM-bypass!
[    4.737426] ima: Allocated hash algorithm: sha1
[    4.738202] ima: No architecture policies found
[    4.739069] evm: Initialising EVM extended attributes:
[    4.739851] evm: security.selinux
[    4.740298] evm: security.SMACK64
[    4.740826] evm: security.SMACK64EXEC
[    4.741376] evm: security.SMACK64TRANSMUTE
[    4.742064] evm: security.SMACK64MMAP
[    4.742484] evm: security.apparmor
[    4.742852] evm: security.ima
[    4.743294] evm: security.capability
[    4.743693] evm: HMAC attrs: 0x1
[    4.747698] PM:   Magic number: 3:878:986
[    4.750060] RAS: Correctable Errors collector initialized.
[    4.751511] clk: Disabling unused clocks
[    4.753730] md: Waiting for all devices to be available before autodetect
[    4.754303] md: If you don't use raid, use raid=noautodetect
[    4.754777] md: Autodetecting RAID arrays.
[    4.755153] md: autorun ...
[    4.755646] md: ... autorun DONE.
[    4.768069] EXT4-fs (sda): mounted filesystem 088740a9-c8b4-422c-999d-a804eb68a4da ro with ordered data mode. Quota mode: none.
[    4.769467] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.
[    4.773602] devtmpfs: mounted
[    4.792324] Freeing unused decrypted memory: 2028K
[    4.794671] Freeing unused kernel image (initmem) memory: 14912K
[    4.795301] Write protecting the kernel read-only data: 92160k
[    4.797212] Freeing unused kernel image (rodata/data gap) memory: 1732K
[    4.845430] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.845838] Run /sbin/init as init process
[    4.846049]   with arguments:
[    4.846054]     /sbin/init
[    4.846058]   with environment:
[    4.846061]     HOME=/
[    4.846064]     TERM=linux
[    5.007858] systemd[1]: systemd 252-15.el9 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL )
[    5.010135] systemd[1]: Detected virtualization kvm.
[    5.010507] systemd[1]: Detected architecture x86-64.
[    5.017333] systemd[1]: Hostname set to <test>.
[    5.228637] systemd-rc-local-generator[122]: /etc/rc.d/rc.local is not marked executable, skipping.
[    5.640287] systemd[1]: Queued start job for default target Multi-User System.
[    5.666368] systemd[1]: Created slice Virtual Machine and Container Slice.
[    5.672228] systemd[1]: Created slice Slice /system/getty.
[    5.675231] systemd[1]: Created slice Slice /system/modprobe.
[    5.678252] systemd[1]: Created slice Slice /system/serial-getty.
[    5.681342] systemd[1]: Created slice Slice /system/sshd-keygen.
[    5.684647] systemd[1]: Created slice User and Session Slice.
[    5.686443] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    5.689372] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    5.691034] systemd[1]: Reached target Local Integrity Protected Volumes.
[    5.692402] systemd[1]: Reached target Slice Units.
[    5.693493] systemd[1]: Reached target Swaps.
[    5.694387] systemd[1]: Reached target Local Verity Protected Volumes.
[    5.696163] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    5.698346] systemd[1]: Listening on LVM2 poll daemon socket.
[    5.700666] systemd[1]: multipathd control socket was skipped because of an unmet condition check (ConditionPathExists=/etc/multipath.conf).
[    5.756234] systemd[1]: Listening on RPCbind Server Activation Socket.
[    5.757382] systemd[1]: Reached target RPC Port Mapper.
[    5.760536] systemd[1]: Listening on Process Core Dump Socket.
[    5.761865] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    5.763479] systemd[1]: Listening on Journal Socket (/dev/log).
[    5.764965] systemd[1]: Listening on Journal Socket.
[    5.766485] systemd[1]: Listening on udev Control Socket.
[    5.767767] systemd[1]: Listening on udev Kernel Socket.
[    5.776232] systemd[1]: Mounting Huge Pages File System...
[    5.785036] systemd[1]: Mounting POSIX Message Queue File System...
[    5.796187] systemd[1]: Mounting Kernel Debug File System...
[    5.805779] systemd[1]: Mounting Kernel Trace File System...
[    5.809076] systemd[1]: Kernel Module supporting RPCSEC_GSS was skipped because of an unmet condition check (ConditionPathExists=/etc/krb5.keyta.
[    5.810139] systemd[1]: Create List of Static Device Nodes was skipped because of an unmet condition check (ConditionFileNotEmpty=/lib/modules/6.
[    5.818420] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    5.829691] systemd[1]: Starting Load Kernel Module configfs...
[    5.838745] systemd[1]: Starting Load Kernel Module drm...
[    5.855631] systemd[1]: Starting Load Kernel Module fuse...
[    5.872310] systemd[1]: Starting Read and set NIS domainname from /etc/sysconfig/network...
[    5.889400] systemd[1]: Starting Journal Service...
[    5.964401] systemd[1]: Starting Load Kernel Modules...
[    5.999993] systemd[1]: Starting Generate network units from Kernel command line...
[    6.015283] systemd[1]: Starting Remount Root and Kernel File Systems...
[    6.016892] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
[    6.033623] systemd[1]: Starting Coldplug All udev Devices...
[    6.063223] systemd[1]: Mounted Huge Pages File System.
[    6.064807] systemd[1]: Mounted POSIX Message Queue File System.
[    6.066239] systemd[1]: Mounted Kernel Debug File System.
[    6.071675] systemd[1]: Mounted Kernel Trace File System.
[    6.074263] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
[    6.081307] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[    6.084417] systemd[1]: Finished Load Kernel Module configfs.
[    6.090205] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    6.095678] systemd[1]: Finished Load Kernel Module drm.
[    6.099848] systemd[1]: Started Journal Service.
[    6.119764] EXT4-fs (sda): re-mounted 088740a9-c8b4-422c-999d-a804eb68a4da r/w. Quota mode: none.
[    6.298052] systemd-journald[144]: Received client request to flush runtime journal.
[    9.655473] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   22.405801] repro_bpf[627]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro_bpf[400000+1000] likely on CPU 0 (core 0, so)
[   22.406747] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   22.410474] repro_bpf[630]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro_bpf[400000+1000] likely on CPU 1 (core 1, so)
[   22.411308] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   22.428087] repro_bpf[633]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro_bpf[400000+1000] likely on CPU 0 (core 0, so)
[   22.428836] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   22.446280] repro_bpf[635]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro_bpf[400000+1000] likely on CPU 1 (core 1, so)
[   22.447277] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   22.480866] repro_bpf[640]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro_bpf[400000+1000] likely on CPU 0 (core 0, so)
[   22.481916] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   22.486431] repro_bpf[643]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro_bpf[400000+1000] likely on CPU 1 (core 1, so)
[   22.487543] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   22.551619] repro_bpf[647]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro_bpf[400000+1000] likely on CPU 1 (core 1, so)
[   22.552706] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   22.575290] repro_bpf[651]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro_bpf[400000+1000] likely on CPU 0 (core 0, so)
[   22.576334] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   22.599257] repro_bpf[654]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro_bpf[400000+1000] likely on CPU 0 (core 0, so)
[   22.600264] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   22.636689] repro_bpf[658]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro_bpf[400000+1000] likely on CPU 0 (core 0, so)
[   22.637818] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   22.830788] Pid 682(repro_bpf) over core_pipe_limit
[   22.831171] Skipping core dump
[   22.838086] Pid 684(repro_bpf) over core_pipe_limit
[   22.838463] Skipping core dump
[   22.849038] Pid 686(repro_bpf) over core_pipe_limit
[   22.849410] Skipping core dump
[   22.868343] Pid 688(repro_bpf) over core_pipe_limit
[   22.868685] Skipping core dump
[   22.885217] Pid 691(repro_bpf) over core_pipe_limit
[   22.885517] Skipping core dump
[   22.898246] Pid 694(repro_bpf) over core_pipe_limit
[   22.898563] Skipping core dump
[   22.915789] Pid 697(repro_bpf) over core_pipe_limit
[   22.916117] Skipping core dump
[   22.922895] Pid 699(repro_bpf) over core_pipe_limit
[   22.923318] Skipping core dump
[   22.931818] Pid 701(repro_bpf) over core_pipe_limit
[   22.932172] Skipping core dump
[   22.944683] Pid 703(repro_bpf) over core_pipe_limit
[   22.944963] Skipping core dump
[   22.961696] Pid 706(repro_bpf) over core_pipe_limit
[   22.962128] Skipping core dump
[   22.972708] Pid 708(repro_bpf) over core_pipe_limit
[   22.973106] Skipping core dump
[   22.984789] Pid 710(repro_bpf) over core_pipe_limit
[   22.985067] Skipping core dump
[   22.996400] Pid 712(repro_bpf) over core_pipe_limit
[   22.996718] Skipping core dump
[   23.012834] Pid 714(repro_bpf) over core_pipe_limit
[   23.013224] Skipping core dump
[   23.024791] Pid 717(repro_bpf) over core_pipe_limit
[   23.025178] Skipping core dump
[   23.031011] Pid 719(repro_bpf) over core_pipe_limit
[   23.031422] Skipping core dump
[   23.037228] Pid 721(repro_bpf) over core_pipe_limit
[   23.037611] Skipping core dump
[   23.057556] Pid 724(repro_bpf) over core_pipe_limit
[   23.057951] Skipping core dump
[   23.068869] Pid 726(repro_bpf) over core_pipe_limit
[   23.069285] Skipping core dump
[   23.089127] Pid 729(repro_bpf) over core_pipe_limit
[   23.089520] Skipping core dump
[   23.097066] Pid 731(repro_bpf) over core_pipe_limit
[   23.097475] Skipping core dump
[   23.119841] Pid 734(repro_bpf) over core_pipe_limit
[   23.120229] Skipping core dump
[   23.132292] Pid 736(repro_bpf) over core_pipe_limit
[   23.132692] Skipping core dump
[   23.148858] Pid 739(repro_bpf) over core_pipe_limit
[   23.149246] Skipping core dump
[   23.161139] Pid 741(repro_bpf) over core_pipe_limit
[   23.161539] Skipping core dump
[   23.169484] Pid 743(repro_bpf) over core_pipe_limit
[   23.169865] Skipping core dump
[   23.183025] Pid 745(repro_bpf) over core_pipe_limit
[   23.183443] Skipping core dump
[   23.198861] Pid 748(repro_bpf) over core_pipe_limit
[   23.199332] Skipping core dump
[   23.211277] Pid 750(repro_bpf) over core_pipe_limit
[   23.211666] Skipping core dump
[   23.231371] Pid 752(repro_bpf) over core_pipe_limit
[   23.231770] Skipping core dump
[   23.244563] Pid 754(repro_bpf) over core_pipe_limit
[   23.244944] Skipping core dump
[   23.253835] Pid 756(repro_bpf) over core_pipe_limit
[   23.254216] Skipping core dump
[   23.265155] Pid 758(repro_bpf) over core_pipe_limit
[   23.265574] Skipping core dump
[   23.273407] Pid 760(repro_bpf) over core_pipe_limit
[   23.273797] Skipping core dump
[   23.280557] Pid 762(repro_bpf) over core_pipe_limit
[   23.280933] Skipping core dump
[   23.291666] Pid 764(repro_bpf) over core_pipe_limit
[   23.292053] Skipping core dump
[   23.299803] Pid 766(repro_bpf) over core_pipe_limit
[   23.300193] Skipping core dump
[   23.311458] Pid 768(repro_bpf) over core_pipe_limit
[   23.311861] Skipping core dump
[   23.318847] Pid 770(repro_bpf) over core_pipe_limit
[   23.319652] Skipping core dump
[   23.327983] Pid 772(repro_bpf) over core_pipe_limit
[   23.328378] Skipping core dump
[   23.337109] Pid 774(repro_bpf) over core_pipe_limit
[   23.337522] Skipping core dump
[   23.348248] Pid 776(repro_bpf) over core_pipe_limit
[   23.348648] Skipping core dump
[   23.363545] Pid 778(repro_bpf) over core_pipe_limit
[   23.364071] Skipping core dump
[   23.374426] Pid 780(repro_bpf) over core_pipe_limit
[   23.375040] Skipping core dump
[   23.394092] Pid 782(repro_bpf) over core_pipe_limit
[   23.394577] Skipping core dump
[   23.436467] Pid 784(repro_bpf) over core_pipe_limit
[   23.436795] Skipping core dump
[   23.486204] Pid 792(repro_bpf) over core_pipe_limit
[   23.486614] Skipping core dump
[   23.495417] Pid 794(repro_bpf) over core_pipe_limit
[   23.495855] Skipping core dump
[   23.514408] Pid 796(repro_bpf) over core_pipe_limit
[   23.514825] Skipping core dump
[   23.527504] Pid 798(repro_bpf) over core_pipe_limit
[   23.527907] Skipping core dump
[   23.538677] Pid 801(repro_bpf) over core_pipe_limit
[   23.539110] Skipping core dump
[   23.546012] Pid 803(repro_bpf) over core_pipe_limit
[   23.546411] Skipping core dump
[   23.558200] Pid 805(repro_bpf) over core_pipe_limit
[   23.558616] Skipping core dump
[   23.566030] Pid 807(repro_bpf) over core_pipe_limit
[   23.566422] Skipping core dump
[   23.578226] Pid 809(repro_bpf) over core_pipe_limit
[   23.578619] Skipping core dump
[   23.585529] Pid 811(repro_bpf) over core_pipe_limit
[   23.585919] Skipping core dump
[   23.597544] Pid 813(repro_bpf) over core_pipe_limit
[   23.597935] Skipping core dump
[   23.604326] Pid 815(repro_bpf) over core_pipe_limit
[   23.604765] Skipping core dump
[   23.620546] Pid 817(repro_bpf) over core_pipe_limit
[   23.620968] Skipping core dump
[   23.624924] Pid 819(repro_bpf) over core_pipe_limit
[   23.625321] Skipping core dump
[   23.634868] Pid 821(repro_bpf) over core_pipe_limit
[   23.635292] Skipping core dump
[   23.642543] Pid 823(repro_bpf) over core_pipe_limit
[   23.642980] Skipping core dump
[   23.654409] Pid 825(repro_bpf) over core_pipe_limit
[   23.654795] Skipping core dump
[   23.660758] Pid 827(repro_bpf) over core_pipe_limit
[   23.661203] Skipping core dump
[   23.671108] Pid 829(repro_bpf) over core_pipe_limit
[   23.671862] Skipping core dump
[   23.682467] Pid 831(repro_bpf) over core_pipe_limit
[   23.682882] Skipping core dump
[   23.691815] Pid 833(repro_bpf) over core_pipe_limit
[   23.692207] Skipping core dump
[   23.700477] Pid 835(repro_bpf) over core_pipe_limit
[   23.700863] Skipping core dump
[   23.710148] Pid 837(repro_bpf) over core_pipe_limit
[   23.710551] Skipping core dump
[   23.717620] Pid 839(repro_bpf) over core_pipe_limit
[   23.718006] Skipping core dump
[   23.728723] Pid 841(repro_bpf) over core_pipe_limit
[   23.729101] Skipping core dump
[   23.737528] Pid 843(repro_bpf) over core_pipe_limit
[   23.737920] Skipping core dump
[   23.745111] Pid 845(repro_bpf) over core_pipe_limit
[   23.745511] Skipping core dump
[   23.754583] Pid 847(repro_bpf) over core_pipe_limit
[   23.754981] Skipping core dump
[   23.767403] Pid 849(repro_bpf) over core_pipe_limit
[   23.767670] Skipping core dump
[   23.775577] Pid 851(repro_bpf) over core_pipe_limit
[   23.775989] Skipping core dump
[   23.786091] Pid 853(repro_bpf) over core_pipe_limit
[   23.786504] Skipping core dump
[   23.791611] Pid 855(repro_bpf) over core_pipe_limit
[   23.791949] Skipping core dump
[   23.801849] Pid 857(repro_bpf) over core_pipe_limit
[   23.802267] Skipping core dump
[   23.807563] Pid 859(repro_bpf) over core_pipe_limit
[   23.807991] Skipping core dump
[   23.817198] Pid 861(repro_bpf) over core_pipe_limit
[   23.817690] Skipping core dump
[   23.822668] Pid 863(repro_bpf) over core_pipe_limit
[   23.823284] Skipping core dump
[   23.829166] Pid 865(repro_bpf) over core_pipe_limit
[   23.829697] Skipping core dump
[   23.843656] Pid 867(repro_bpf) over core_pipe_limit
[   23.844037] Skipping core dump
[   23.853450] Pid 869(repro_bpf) over core_pipe_limit
[   23.853868] Skipping core dump
[   23.862344] Pid 871(repro_bpf) over core_pipe_limit
[   23.862712] Skipping core dump
[   23.873467] Pid 873(repro_bpf) over core_pipe_limit
[   23.873843] Skipping core dump
[   23.887411] Pid 875(repro_bpf) over core_pipe_limit
[   23.887788] Skipping core dump
[   23.898533] Pid 877(repro_bpf) over core_pipe_limit
[   23.898917] Skipping core dump
[   23.914121] Pid 879(repro_bpf) over core_pipe_limit
[   23.914506] Skipping core dump
[   23.922522] Pid 881(repro_bpf) over core_pipe_limit
[   23.922892] Skipping core dump
[   23.933736] Pid 883(repro_bpf) over core_pipe_limit
[   23.934145] Skipping core dump
[   23.947341] Pid 885(repro_bpf) over core_pipe_limit
[   23.947718] Skipping core dump
[   23.952137] Pid 887(repro_bpf) over core_pipe_limit
[   23.952523] Skipping core dump
[   23.961769] Pid 889(repro_bpf) over core_pipe_limit
[   23.962153] Skipping core dump
[   23.971269] Pid 891(repro_bpf) over core_pipe_limit
[   23.971645] Skipping core dump
[   23.978810] Pid 893(repro_bpf) over core_pipe_limit
[   23.979237] Skipping core dump
[   23.988070] Pid 895(repro_bpf) over core_pipe_limit
[   23.988443] Skipping core dump
[   24.000479] Pid 897(repro_bpf) over core_pipe_limit
[   24.000873] Skipping core dump
[   24.008699] Pid 899(repro_bpf) over core_pipe_limit
[   24.009084] Skipping core dump
[   24.016756] Pid 901(repro_bpf) over core_pipe_limit
[   24.017159] Skipping core dump
[   24.026198] Pid 903(repro_bpf) over core_pipe_limit
[   24.026569] Skipping core dump
[   24.038278] Pid 905(repro_bpf) over core_pipe_limit
[   24.038668] Skipping core dump
[   24.044419] Pid 907(repro_bpf) over core_pipe_limit
[   24.044847] Skipping core dump
[   24.056696] Pid 909(repro_bpf) over core_pipe_limit
[   24.057108] Skipping core dump
[   24.067422] Pid 911(repro_bpf) over core_pipe_limit
[   24.067794] Skipping core dump
[   24.073724] Pid 913(repro_bpf) over core_pipe_limit
[   24.074106] Skipping core dump
[   24.086216] Pid 915(repro_bpf) over core_pipe_limit
[   24.086596] Skipping core dump
[   24.095485] Pid 917(repro_bpf) over core_pipe_limit
[   24.095873] Skipping core dump
[   24.105347] Pid 919(repro_bpf) over core_pipe_limit
[   24.105740] Skipping core dump
[   24.115802] Pid 921(repro_bpf) over core_pipe_limit
[   24.116189] Skipping core dump
[   24.148131] Pid 923(repro_bpf) over core_pipe_limit
[   24.148515] Skipping core dump
[   24.153331] Pid 925(repro_bpf) over core_pipe_limit
[   24.153744] Skipping core dump
[   24.163391] Pid 927(repro_bpf) over core_pipe_limit
[   24.163798] Skipping core dump
[   24.172173] Pid 929(repro_bpf) over core_pipe_limit
[   24.172574] Skipping core dump
[   24.180339] Pid 931(repro_bpf) over core_pipe_limit
[   24.180746] Skipping core dump
[   24.195249] Pid 933(repro_bpf) over core_pipe_limit
[   24.195665] Skipping core dump
[   24.203909] Pid 935(repro_bpf) over core_pipe_limit
[   24.204329] Skipping core dump
[   24.214220] Pid 937(repro_bpf) over core_pipe_limit
[   24.214607] Skipping core dump
[   24.228011] Pid 939(repro_bpf) over core_pipe_limit
[   24.228435] Skipping core dump
[   24.239873] Pid 941(repro_bpf) over core_pipe_limit
[   24.240257] Skipping core dump
[   24.260286] Pid 943(repro_bpf) over core_pipe_limit
[   24.260687] Skipping core dump
[   24.274402] Pid 945(repro_bpf) over core_pipe_limit
[   24.274785] Skipping core dump
[   24.279960] Pid 947(repro_bpf) over core_pipe_limit
[   24.280344] Skipping core dump
[   24.295262] Pid 949(repro_bpf) over core_pipe_limit
[   24.295688] Skipping core dump
[   24.316289] Pid 951(repro_bpf) over core_pipe_limit
[   24.316691] Skipping core dump
[   24.350810] Pid 959(repro_bpf) over core_pipe_limit
[   24.351130] Skipping core dump
[   24.367555] Pid 961(repro_bpf) over core_pipe_limit
[   24.367972] Skipping core dump
[   24.387471] Pid 964(repro_bpf) over core_pipe_limit
[   24.387766] Skipping core dump
[   24.395322] Pid 966(repro_bpf) over core_pipe_limit
[   24.395600] Skipping core dump
[   24.403806] Pid 968(repro_bpf) over core_pipe_limit
[   24.404122] Skipping core dump
[   24.413433] Pid 970(repro_bpf) over core_pipe_limit
[   24.413803] Skipping core dump
[   24.427391] Pid 972(repro_bpf) over core_pipe_limit
[   24.427784] Skipping core dump
[   24.434222] Pid 974(repro_bpf) over core_pipe_limit
[   24.434614] Skipping core dump
[   24.439699] Pid 976(repro_bpf) over core_pipe_limit
[   24.440084] Skipping core dump
[   24.451512] Pid 978(repro_bpf) over core_pipe_limit
[   24.451897] Skipping core dump
[   24.460715] Pid 980(repro_bpf) over core_pipe_limit
[   24.461081] Skipping core dump
[   24.473206] Pid 982(repro_bpf) over core_pipe_limit
[   24.473585] Skipping core dump
[   24.484560] Pid 984(repro_bpf) over core_pipe_limit
[   24.484948] Skipping core dump
[   24.491403] Pid 986(repro_bpf) over core_pipe_limit
[   24.491758] Skipping core dump
[   24.501484] Pid 988(repro_bpf) over core_pipe_limit
[   24.501888] Skipping core dump
[   24.508004] Pid 990(repro_bpf) over core_pipe_limit
[   24.508507] Skipping core dump
[   24.517353] Pid 992(repro_bpf) over core_pipe_limit
[   24.517741] Skipping core dump
[   24.526468] Pid 994(repro_bpf) over core_pipe_limit
[   24.526910] Skipping core dump
[   24.535400] Pid 996(repro_bpf) over core_pipe_limit
[   24.535800] Skipping core dump
[   24.547460] Pid 998(repro_bpf) over core_pipe_limit
[   24.547846] Skipping core dump
[   24.553223] Pid 1000(repro_bpf) over core_pipe_limit
[   24.553629] Skipping core dump
[   24.566007] Pid 1002(repro_bpf) over core_pipe_limit
[   24.566405] Skipping core dump
[   24.577884] Pid 1004(repro_bpf) over core_pipe_limit
[   24.578259] Skipping core dump
[   24.589486] Pid 1006(repro_bpf) over core_pipe_limit
[   24.589883] Skipping core dump
[   24.605224] Pid 1008(repro_bpf) over core_pipe_limit
[   24.605674] Skipping core dump
[   24.621100] Pid 1010(repro_bpf) over core_pipe_limit
[   24.621704] Skipping core dump
[   24.627674] Pid 1012(repro_bpf) over core_pipe_limit
[   24.628243] Skipping core dump
[   24.660108] Pid 1014(repro_bpf) over core_pipe_limit
[   24.660512] Skipping core dump
[   24.692324] Pid 1019(repro_bpf) over core_pipe_limit
[   24.692629] Skipping core dump
[   24.706471] Pid 1024(repro_bpf) over core_pipe_limit
[   24.706810] Skipping core dump
[   24.732129] Pid 1026(repro_bpf) over core_pipe_limit
[   24.732525] Skipping core dump
[   24.744968] Pid 1029(repro_bpf) over core_pipe_limit
[   24.745415] Skipping core dump
[   24.760087] Pid 1032(repro_bpf) over core_pipe_limit
[   24.760493] Skipping core dump
[   24.775418] Pid 1034(repro_bpf) over core_pipe_limit
[   24.775820] Skipping core dump
[   24.785690] Pid 1036(repro_bpf) over core_pipe_limit
[   24.786079] Skipping core dump
[   24.814909] Pid 1041(repro_bpf) over core_pipe_limit
[   24.815513] Skipping core dump
[   24.860010] Pid 1048(repro_bpf) over core_pipe_limit
[   24.860328] Skipping core dump
[   24.866709] Pid 1050(repro_bpf) over core_pipe_limit
[   24.867027] Skipping core dump
[   24.879787] Pid 1052(repro_bpf) over core_pipe_limit
[   24.880081] Skipping core dump
[   24.888815] Pid 1054(repro_bpf) over core_pipe_limit
[   24.889123] Skipping core dump
[   24.897781] Pid 1056(repro_bpf) over core_pipe_limit
[   24.898468] Skipping core dump
[   24.909116] Pid 1058(repro_bpf) over core_pipe_limit
[   24.909544] Skipping core dump
[   24.913565] Pid 1060(repro_bpf) over core_pipe_limit
[   24.913910] Skipping core dump
[   24.920908] Pid 1062(repro_bpf) over core_pipe_limit
[   24.921338] Skipping core dump
[   24.934355] Pid 1064(repro_bpf) over core_pipe_limit
[   24.934738] Skipping core dump
[   24.947378] Pid 1066(repro_bpf) over core_pipe_limit
[   24.947760] Skipping core dump
[   24.960079] Pid 1068(repro_bpf) over core_pipe_limit
[   24.960478] Skipping core dump
[   24.969843] Pid 1070(repro_bpf) over core_pipe_limit
[   24.970232] Skipping core dump
[   24.984177] Pid 1072(repro_bpf) over core_pipe_limit
[   24.984572] Skipping core dump
[   24.994380] Pid 1074(repro_bpf) over core_pipe_limit
[   24.994764] Skipping core dump
[   25.039398] Pid 1082(repro_bpf) over core_pipe_limit
[   25.039800] Skipping core dump
[   25.081360] Pid 1085(repro_bpf) over core_pipe_limit
[   25.081770] Skipping core dump
[   25.096764] Pid 1087(repro_bpf) over core_pipe_limit
[   25.097170] Skipping core dump
[   25.107376] Pid 1089(repro_bpf) over core_pipe_limit
[   25.107799] Skipping core dump
[   25.119438] Pid 1091(repro_bpf) over core_pipe_limit
[   25.119838] Skipping core dump
[   25.127922] Pid 1093(repro_bpf) over core_pipe_limit
[   25.128322] Skipping core dump
[   25.149626] Pid 1095(repro_bpf) over core_pipe_limit
[   25.150011] Skipping core dump
[   25.206698] Pid 1103(repro_bpf) over core_pipe_limit
[   25.206975] Skipping core dump
[   25.235627] Pid 1105(repro_bpf) over core_pipe_limit
[   25.235943] Skipping core dump
[   25.328792] Pid 1120(repro_bpf) over core_pipe_limit
[   25.329134] Skipping core dump
[   25.367788] Pid 1128(repro_bpf) over core_pipe_limit
[   25.368117] Skipping core dump
[   25.379473] Pid 1130(repro_bpf) over core_pipe_limit
[   25.379852] Skipping core dump
[   25.389859] Pid 1133(repro_bpf) over core_pipe_limit
[   25.390155] Skipping core dump
[   25.395403] Pid 1135(repro_bpf) over core_pipe_limit
[   25.395704] Skipping core dump
[   25.404748] Pid 1137(repro_bpf) over core_pipe_limit
[   25.405106] Skipping core dump
[   25.413396] Pid 1139(repro_bpf) over core_pipe_limit
[   25.413705] Skipping core dump
[   25.420764] Pid 1141(repro_bpf) over core_pipe_limit
[   25.421061] Skipping core dump
[   25.431471] Pid 1143(repro_bpf) over core_pipe_limit
[   25.431864] Skipping core dump
[   25.445225] Pid 1146(repro_bpf) over core_pipe_limit
[   25.445564] Skipping core dump
[   25.456240] Pid 1148(repro_bpf) over core_pipe_limit
[   25.456554] Skipping core dump
[   25.464002] Pid 1150(repro_bpf) over core_pipe_limit
[   25.464303] Skipping core dump
[   25.479025] Pid 1153(repro_bpf) over core_pipe_limit
[   25.479397] Skipping core dump
[   25.484963] Pid 1155(repro_bpf) over core_pipe_limit
[   25.485284] Skipping core dump
[   25.496477] Pid 1157(repro_bpf) over core_pipe_limit
[   25.496862] Skipping core dump
[   25.503229] Pid 1159(repro_bpf) over core_pipe_limit
[   25.503647] Skipping core dump
[   25.513990] Pid 1161(repro_bpf) over core_pipe_limit
[   25.514363] Skipping core dump
[   25.520769] Pid 1163(repro_bpf) over core_pipe_limit
[   25.521158] Skipping core dump
[   25.533992] Pid 1165(repro_bpf) over core_pipe_limit
[   25.534385] Skipping core dump
[   25.549398] Pid 1167(repro_bpf) over core_pipe_limit
[   25.549706] Skipping core dump
[   25.557868] Pid 1169(repro_bpf) over core_pipe_limit
[   25.558205] Skipping core dump
[   25.574469] Pid 1171(repro_bpf) over core_pipe_limit
[   25.574790] Skipping core dump
[   25.583533] Pid 1173(repro_bpf) over core_pipe_limit
[   25.583851] Skipping core dump
[   25.624431] Pid 1178(repro_bpf) over core_pipe_limit
[   25.624767] Skipping core dump
[   25.699362] Pid 1190(repro_bpf) over core_pipe_limit
[   25.699693] Skipping core dump
[   25.728514] Pid 1195(repro_bpf) over core_pipe_limit
[   25.728836] Skipping core dump
[   25.734044] Pid 1197(repro_bpf) over core_pipe_limit
[   25.734337] Skipping core dump
[   25.795527] Pid 1208(repro_bpf) over core_pipe_limit
[   25.795814] Skipping core dump
[   25.812591] Pid 1211(repro_bpf) over core_pipe_limit
[   25.812925] Skipping core dump
[   25.821453] Pid 1213(repro_bpf) over core_pipe_limit
[   25.821798] Skipping core dump
[   25.834028] Pid 1215(repro_bpf) over core_pipe_limit
[   25.834344] Skipping core dump
[   25.852342] Pid 1218(repro_bpf) over core_pipe_limit
[   25.852635] Skipping core dump
[   25.864582] Pid 1220(repro_bpf) over core_pipe_limit
[   25.864894] Skipping core dump
[   25.874741] Pid 1223(repro_bpf) over core_pipe_limit
[   25.875141] Skipping core dump
[   25.890203] Pid 1225(repro_bpf) over core_pipe_limit
[   25.890592] Skipping core dump
[   25.902593] Pid 1227(repro_bpf) over core_pipe_limit
[   25.902994] Skipping core dump
[   25.917165] Pid 1229(repro_bpf) over core_pipe_limit
[   25.917615] Skipping core dump
[   25.927998] Pid 1231(repro_bpf) over core_pipe_limit
[   25.928427] Skipping core dump
[   25.938810] Pid 1233(repro_bpf) over core_pipe_limit
[   25.939286] Skipping core dump
[   25.947780] Pid 1235(repro_bpf) over core_pipe_limit
[   25.948200] Skipping core dump
[   25.954248] Pid 1237(repro_bpf) over core_pipe_limit
[   25.954676] Skipping core dump
[   25.965137] Pid 1239(repro_bpf) over core_pipe_limit
[   25.965551] Skipping core dump
[   25.975340] Pid 1241(repro_bpf) over core_pipe_limit
[   25.975728] Skipping core dump
[   26.002512] Pid 1243(repro_bpf) over core_pipe_limit
[   26.002933] Skipping core dump
[   26.041502] Pid 1251(repro_bpf) over core_pipe_limit
[   26.041822] Skipping core dump
[   26.076476] Pid 1253(repro_bpf) over core_pipe_limit
[   26.076804] Skipping core dump
[   26.091268] Pid 1256(repro_bpf) over core_pipe_limit
[   26.091571] Skipping core dump
[   26.102642] Pid 1258(repro_bpf) over core_pipe_limit
[   26.102997] Skipping core dump
[   26.146706] Pid 1263(repro_bpf) over core_pipe_limit
[   26.147022] Skipping core dump
[   26.154084] Pid 1265(repro_bpf) over core_pipe_limit
[   26.154398] Skipping core dump
[   26.169797] Pid 1270(repro_bpf) over core_pipe_limit
[   26.170145] Skipping core dump
[   26.213816] Pid 1276(repro_bpf) over core_pipe_limit
[   26.214138] Skipping core dump
[   26.234166] Pid 1281(repro_bpf) over core_pipe_limit
[   26.234500] Skipping core dump
[   26.245960] Pid 1283(repro_bpf) over core_pipe_limit
[   26.246293] Skipping core dump
[   26.264511] Pid 1286(repro_bpf) over core_pipe_limit
[   26.264922] Skipping core dump
[   26.277980] Pid 1288(repro_bpf) over core_pipe_limit
[   26.278286] Skipping core dump
[   26.285458] Pid 1290(repro_bpf) over core_pipe_limit
[   26.285784] Skipping core dump
[   26.292410] Pid 1292(repro_bpf) over core_pipe_limit
[   26.292734] Skipping core dump
[   26.299131] Pid 1294(repro_bpf) over core_pipe_limit
[   26.299531] Skipping core dump
[   26.305852] Pid 1296(repro_bpf) over core_pipe_limit
[   26.306211] Skipping core dump
[   26.316162] Pid 1298(repro_bpf) over core_pipe_limit
[   26.316551] Skipping core dump
[   26.325270] Pid 1300(repro_bpf) over core_pipe_limit
[   26.325655] Skipping core dump
[   26.335101] Pid 1304(repro_bpf) over core_pipe_limit
[   26.335445] Pid 1302(repro_bpf) over core_pipe_limit
[   26.335689] Skipping core dump
[   26.335876] Skipping core dump
[   26.344539] Pid 1306(repro_bpf) over core_pipe_limit
[   26.344940] Skipping core dump
[   26.352657] Pid 1308(repro_bpf) over core_pipe_limit
[   26.353015] Skipping core dump
[   26.365783] Pid 1310(repro_bpf) over core_pipe_limit
[   26.366178] Skipping core dump
[   26.370586] Pid 1312(repro_bpf) over core_pipe_limit
[   26.370952] Skipping core dump
[   26.380014] Pid 1314(repro_bpf) over core_pipe_limit
[   26.380370] Skipping core dump
[   26.389643] Pid 1316(repro_bpf) over core_pipe_limit
[   26.390039] Skipping core dump
[   26.400481] Pid 1318(repro_bpf) over core_pipe_limit
[   26.400851] Skipping core dump
[   26.408680] Pid 1320(repro_bpf) over core_pipe_limit
[   26.409079] Skipping core dump
[   26.415507] Pid 1322(repro_bpf) over core_pipe_limit
[   26.415881] Skipping core dump
[   26.421713] Pid 1324(repro_bpf) over core_pipe_limit
[   26.422089] Skipping core dump
[   26.437364] Pid 1326(repro_bpf) over core_pipe_limit
[   26.437761] Skipping core dump
[   26.445046] Pid 1328(repro_bpf) over core_pipe_limit
[   26.445438] Skipping core dump
[   26.450339] Pid 1330(repro_bpf) over core_pipe_limit
[   26.450752] Skipping core dump
[   26.458260] Pid 1332(repro_bpf) over core_pipe_limit
[   26.458672] Skipping core dump
[   26.467016] Pid 1334(repro_bpf) over core_pipe_limit
[   26.467732] Skipping core dump
[   26.470469] Pid 1336(repro_bpf) over core_pipe_limit
[   26.470835] Skipping core dump
[   26.482857] Pid 1338(repro_bpf) over core_pipe_limit
[   26.483258] Skipping core dump
[   26.488606] Pid 1340(repro_bpf) over core_pipe_limit
[   26.488990] Skipping core dump
[   26.495008] Pid 1342(repro_bpf) over core_pipe_limit
[   26.495564] Skipping core dump
[   26.504168] Pid 1344(repro_bpf) over core_pipe_limit
[   26.504555] Skipping core dump
[   26.514518] Pid 1346(repro_bpf) over core_pipe_limit
[   26.514880] Skipping core dump
[   26.525089] Pid 1348(repro_bpf) over core_pipe_limit
[   26.525498] Skipping core dump
[   26.535895] Pid 1350(repro_bpf) over core_pipe_limit
[   26.536286] Skipping core dump
[   26.545950] Pid 1352(repro_bpf) over core_pipe_limit
[   26.546319] Skipping core dump
[   26.553696] Pid 1354(repro_bpf) over core_pipe_limit
[   26.554059] Skipping core dump
[   26.563826] Pid 1356(repro_bpf) over core_pipe_limit
[   26.564248] Skipping core dump
[   26.575353] Pid 1358(repro_bpf) over core_pipe_limit
[   26.575742] Skipping core dump
[   26.581620] Pid 1360(repro_bpf) over core_pipe_limit
[   26.582008] Skipping core dump

--zUtZHo7NizW+qsCr--

