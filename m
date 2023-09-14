Return-Path: <bpf+bounces-10063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6917A0B4E
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 19:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6FB1C210EF
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51A02628F;
	Thu, 14 Sep 2023 17:10:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C470208A1
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 17:10:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B201FE5;
	Thu, 14 Sep 2023 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694711415; x=1726247415;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eV2JD3Rjn3EOex8TEdN5XPzNXegQiID0LMnAxot9DXo=;
  b=F8cgEWE4FjkBBY9vybdJ5kKn6y0Q9cRGg06gsYJ2HoZDvxQFpxTfh68c
   NVajIdTIaMJYtezXA7mK7ZkZ69Ghl21q3clzWbKOmykbpbuXmSDcq11JU
   CkeBlIAVIbQmEbnPKB6ebwsHfzxMGc94nQZ5lrwP55Oy+UFX87gQUxNxG
   XbMWxMCBe3f0P2VklvJywW2X/Ohg9se7hKWbAeIl86R86qUQqGkt4BtGV
   4ATG6sr5vxUXQImxDZgdBYrOAdBNwyaTCjbwTO+N8SZIYgY4zs/O8S928
   3UQT8RUR8cfsueMMxh+HqdAV/LDcTx7JEt5BfWypWLZd5uuOmknbVJF5U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381731272"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="381731272"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744615860"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="744615860"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 10:10:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:10:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 10:10:12 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 10:10:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoFS0Pc/9p49sSxzfC0cSyyqVEWa3tjB0hr2WmWRU65m8Si6aWb6k+3qH6yNSljUp0W588HrgHhQmkYmGjpqfrS2V0VAwV/n1E5BOOuaybSYI4L7DnYZHHWBdW410fLLuGxIMfFf0qpi+rVYvHfmV3gUqCWtsd+WYn6rdpds6Sw+MdkHp15e8AugNnGDIJ84xtKQdL293CWKu9A53h/xQ8PToVjXQ3hSUSO9A42atGX+oInnsOfYHHiRaocY22Ut3mqspPgnnj8PwRxcQ9ef5F1w8G8krbWhLfSgA1lYum71RJuSTmEngJRt79ihkPRmH+Xhm98xnK8FMUfZxEJCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eWxw17nHCAgma8znqqc/i83EJUxcpJKKb26CgAdaqY=;
 b=ChlCd1MHAn+PZ/zTys7FQYJYxf6ZyY1hn6cXxcg5DffyXqe7R3JAmriHaD2XOOzzWWvET9s6Ur5XleyvnkaI5wTepc7P1bzi3POwRE6+6Bed0+3n9+f9Ye288/9zKmdc1jt00UuHxM6Cqe9DVvksDWEoyDoA0ed4bWPfXMreohTG/LtzF0QB1mFV/H9E9Om0j1SvKAIYVmJkAy1q2PSRXHaz4ZI0EtpMgRSQ89dibFcarLAyS1gmophCnNtSq/awAtubmnehgd67yyyx5EVF/PXwhiH4gM+VQDn1vZx3AjCRwkfIgo1tjB+lKhgIAG/a/7AMSx5TKVvbfmbG0t4dWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Thu, 14 Sep
 2023 17:10:06 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 17:10:06 +0000
Date: Thu, 14 Sep 2023 19:04:26 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Allow to use kfunc XDP hints and frags
 together
Message-ID: <ZQM9GjMLo32SqxyQ@lincoln>
References: <20230914083716.57443-1-larysa.zaremba@intel.com>
 <ZQM1BUzcZQtXusA3@google.com>
 <ZQM5kt8qHKUH0Iob@lincoln>
 <CAKH8qBuw68AixQabgP5wNfAQBcc0RuVNEyV9rf9vgVi__c4Y9A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKH8qBuw68AixQabgP5wNfAQBcc0RuVNEyV9rf9vgVi__c4Y9A@mail.gmail.com>
X-ClientProxiedBy: BE1P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::8) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MW5PR11MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: a35b0915-6d42-4407-8693-08dbb5457198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PiWcihmYbrGKbyzm0ThBqxFDgI9T8ZVVvrc2HOi0S5Ou+YKgzaNC+4weh9qQsifBfthUihbh6SpYmWOqhiFLIRXUBARwHoicIRJzNcofIjq8YRLaAIYL2GeBZhQU+W6lLhYwjYetmTkzKbiqOApEa1gc5mCS5WG0mW59bMjFigEe9cOdCUmviZX6HxOAL4EB7X5i0PbFNi8ZP3ekY4adtktDkHTuzvSra7DgBz9nBZL5p/OCLu38Lsz8gYuMIk4+CiRSDW3RZv4G9p76jJwztMHNLVjuqIjn4n3GxwtmxhiR/+VjWpHu2skeGVhMGGUquROYdEl1NY1v4a/s5ediQnAeRWUrwDrXgLMOyncSmPhAvw7nSBva8+mYh2yS2hc9YqV9BqJu3FyH4n4baAK2yzO7tsb5SFKR9kBnJOOzBnxUcakXWTsQFey4oZRqXAE1bbJkchj7ZvyrMz0m//eKaS36pI5HYAeZCPF3WkU0HDqjxZnGMU2UOz2AtzvcDuYTqxqB1ZwCfYijr/xTiNIzI1EIHFkMWZe7C7VhqYERYv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(136003)(346002)(376002)(186009)(451199024)(1800799009)(6916009)(316002)(41300700001)(4326008)(7416002)(26005)(66556008)(54906003)(44832011)(966005)(8676002)(8936002)(2906002)(66476007)(66946007)(478600001)(5660300002)(6666004)(6506007)(6486002)(6512007)(9686003)(53546011)(86362001)(83380400001)(38100700002)(82960400001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z054UkpBSW41RGx4ZHdOdDNwb0toUVZXMCtsdzZ6dHdZWDJSd0t5cU5MTU1L?=
 =?utf-8?B?SjV0LzEreHJXZ1ZCNVBML3BWZW1nNCtuZ0o2V09UclVhY0o2d1VtM25JREs4?=
 =?utf-8?B?bGJielNVa0hCZ2Q2U1BmN25VVVJldmpaWllPaFFrbWdUUWQwUGtOWVMwLzIw?=
 =?utf-8?B?cmU4REhBdXduTDNXWHdHU0E5a0NKcHMzcW9CQ0JXOVNGRCtoelFUYUcyRFY1?=
 =?utf-8?B?dkthbWlGSjV4ckxsTFVLODkrM2prNStHeXhkZWNudVFWOWVoUzFaN3c2OGFN?=
 =?utf-8?B?YWh5M1gweERsd200dGRiSGpDaWpGMURmQkZ5Rm0wbFY0QUxneFoxcDMwWWVh?=
 =?utf-8?B?THJ5d1FZR3Qyb3dkNW9BMC9hdGM2RnpwSGZ4UG8wTFV5alZFMmg1dUZRbDJa?=
 =?utf-8?B?NmlHWEgrTWdOOHd1UXBLOHl0UXJBTlQzMXMwdEwvWUdKU0Z5NjZTc2FDZ2ln?=
 =?utf-8?B?TzNPMldIem1teDJkOUwwUG42NkRRZ0ltaUlQMFJWUkxocldNbU9maUUxNWtr?=
 =?utf-8?B?SCs5QXRqQ3gzYmVKMHdwTEpqUWVnMUdsdnIvS0txL1AyVzlyUUFQbWx5T0VX?=
 =?utf-8?B?ODZ0ZGN3VEpSWGlsUHBBelFFS0RYT1VRQUZDQ1h3ZExUcDlvaHJPUFIrVWY2?=
 =?utf-8?B?dHZ6dmdHWkxwU3BvVHp1T2h4U1BjTG1MeU8vSDJVVW1MU0tocFQrVjhmLy9D?=
 =?utf-8?B?U1k3akl0ekgwSGZnRFlXMFcrc1FhWjIrTmxNWmQ4VVExV3laTW5xN2RWZ2pM?=
 =?utf-8?B?QjFDM0xWRmFlSXR1ZmE3YjBkSU9BYmVjaEtwbVk5M2NBYVF0aWtibXMyeTNY?=
 =?utf-8?B?ZHpQQkNvQXo1TFh6cUNBOGoreWV1NDZjZkJiZUNXa0M1cm0vWGkzbGx4VFBx?=
 =?utf-8?B?OHR5cUpXSVhqWG5vanVTWE1mK2dlcXFHQ0JLdFllTDdTWXNiYUJZRGh5dzZ1?=
 =?utf-8?B?VHRLUFB1b1dtREtza0FwSDJJaElPbTlvRUxhZ0wwVGxjZDU3YzFTRFVsRnRX?=
 =?utf-8?B?Q0NTSm1ZTzFyeGRUVTZhcDdGL2h4NGFSaVhlWEIvWmVaZXN4c0NoTm9TbzEx?=
 =?utf-8?B?ZTRaVTR5R2N5Y0VSY1dFMHE2cnVoL0d6RmhsNCtzdU1RWm05dGM3cGdrdnJy?=
 =?utf-8?B?Vno1aFdjR2Z3aUxjbkgxaXJJeWRqb1hmQmtDSzdvaDNqWlRBVktxbVRPTUxN?=
 =?utf-8?B?V0RhSVMyVGJaUU04WU9TNlprKzluK29ZWFZhWm9pZVNyN0M5WndUNFJTdTBK?=
 =?utf-8?B?L0taY1NRNzNQSmsvWlR3S0xNRXN6N01Ha0ozeVRqMzQ0K2g2TDNpczhqRjQ0?=
 =?utf-8?B?L3Vua29ON21ZT2lOSnJjV01Gb3RIeVhlSUdwa0dqMkFHVk01djZibU1RZndB?=
 =?utf-8?B?cXlHRlIyTERXZnZaYUdUZ1h1aFVPVjNpclhxU3JML0lwRXdhcXQwWnRmblJh?=
 =?utf-8?B?NEo5dmtxb1BJZzNET0JYT2pzcjVsbkZoZzEvbnl3T0thWjE1dlRhS05oSnUz?=
 =?utf-8?B?U1JFYmtxWmtuWG0zZjJBVk1iWGpndVF0NjdwWWc4RGFjRWNZUU00NEhKb2Qv?=
 =?utf-8?B?Mmw2cVRTYXpMdGVtbStRR21LNkRETTVtWGpyRjVZd1V2K1pRdlgwVFdsV1FY?=
 =?utf-8?B?bDVYSE4vR1c3eU1TV1dIZXpHL3E4SzVNWGMzbEtvV3JBbit2L2l1NzllN2ZF?=
 =?utf-8?B?R2hMQ1lqSUdZZU5uclRaS09lbUd4aFFxdzN0bkNSSjZ2N0pReFBGN1J0eWM0?=
 =?utf-8?B?RFhYVHI0M3kvT2diRGIrU1pVL3NNbHZoZ2R6OHc1QkhBVFYvZ21meDZjNHFj?=
 =?utf-8?B?QXBNNENKV0JZR0hrSmNnMWtWSVk2WDZvaTJwaTBYeC94dE4yYVY3R1VOSk1H?=
 =?utf-8?B?cmRyR01QVU9iOW1SUU5FU0RwYjhYbnJwcjRPV0NyTUFBRE54dTVhMjBtMVF6?=
 =?utf-8?B?N21yV2Z1ZVpYVXZBakFBMTRSSDgrSUhNakR0RTFpaEoxWDI3VmRVMU1lT2NF?=
 =?utf-8?B?QzI4S2ljaDBxUnphS2U3UksrMU5pQmZPekNlRjhWT3pLclVZclVMSDRXb0lP?=
 =?utf-8?B?YzFwQWpxQjNjOVRJZ1doSEdXVS9OaU03dXBUR3g3aU0zSmh4K1JVVGJSYmhV?=
 =?utf-8?B?dzI0My9CQzE1SjQ2c1RMcW5DYytZc1ZOalBEQmFqdGM3dXhPMFVYb1NoU2Yr?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a35b0915-6d42-4407-8693-08dbb5457198
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:10:06.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzs+6yoDZI9HuUG2ke9rqNh7DJ9A4nrVZAS+8pVZG10POgDs6uHRuefEEmldgJjKE07accVNtj1ZFnKv3P7hR7PTMQVTcdFjL/iH3eiYK04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 10:05:47AM -0700, Stanislav Fomichev wrote:
> On Thu, Sep 14, 2023 at 9:55 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> >
> > On Thu, Sep 14, 2023 at 09:29:57AM -0700, Stanislav Fomichev wrote:
> > > On 09/14, Larysa Zaremba wrote:
> > > > There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
> > > > cannot coexist in a single program.
> > > >
> > > > Allow those features to be used together by modifying the flags conditions.
> > > >
> > > > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > > > Link: https://lore.kernel.org/bpf/CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com/
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >  kernel/bpf/offload.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > > > index ee35f33a96d1..43aded96c79b 100644
> > > > --- a/kernel/bpf/offload.c
> > > > +++ b/kernel/bpf/offload.c
> > > > @@ -232,7 +232,11 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
> > > >         attr->prog_type != BPF_PROG_TYPE_XDP)
> > > >             return -EINVAL;
> > > >
> > > > -   if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> > > > +   if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS_FRAGS))
> > > > +           return -EINVAL;
> > > > +
> > >
> > > [..]
> > >
> > > > +   if (attr->prog_flags & BPF_F_XDP_HAS_FRAGS &&
> > > > +       !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY))
> > > >             return -EINVAL;
> > >
> > > Any reason we have 'attr->prog_flags & BPF_F_XDP_HAS_FRAGS' part here?
> > > Seems like doing '!(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY)' should
> > > be enough, right? We only want to bail out here when BPF_F_XDP_DEV_BOUND_ONLY
> > > is not set and we don't really care whether BPF_F_XDP_HAS_FRAGS is set
> > > or not at this point.
> >
> > If !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY) at this point, program could
> > be requesting offload.
> >
> > Now I have thought about those conditions once more and they could be reduced to
> > this:
> >
> > if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY) &&
> >     attr->prog_flags != (BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS_FRAGS))
> >         return -EINVAL;
> >
> > What do you think?
> 
> Ah, so this check is here to protect against the mbuf+offloaded
> combination? (looking at that other thread with Maciej)
> Let's keep your current way with two separate checks, but let's add
> your "/* Frags are allowed only if program is dev-bound-only, but not
> if it is requesting
> bpf offload. */" as a comment to the second check?

Ok, sound good to me.

