Return-Path: <bpf+bounces-16036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4C87FB7EF
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 11:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD380282467
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FA44F214;
	Tue, 28 Nov 2023 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLAwhnCf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7445E10CB;
	Tue, 28 Nov 2023 02:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701167627; x=1732703627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eepklXo5P6VHBaxb5lxpB6wpWCHTLosvN66mvFflj74=;
  b=mLAwhnCfAl4ddOgOucgNmq2Fdit2H3pdnJmueLHE87wVwdyCPMkPGP8E
   Xh1DiSBHpFuBtX8O0mezHBgsnzM3WFytbtKQv/Qu8N+g4Z3PXFjCeqFbx
   Xe0enY868l9BmOxE5puMI314thBmITjM5pPmd2kau7Wsq1xOSxTLaxPYG
   wqr95CWpWsn4jX4PJlSl9lBxrxAauUK1VuCgQq2CXhjIcLFrQ7CK8xmx/
   Fv+hwozHhgmWv2XrRIHkE8Dn57O4jT1birH9O2GGYPTGB2Qzzp23IY95U
   aIfwQoYBCDmoxfBtnU2GQ2X0RAha9mYX8YUAolD1M5k70f7Vvesq3/7JU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="457227036"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="457227036"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 02:33:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="744852410"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="744852410"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 02:33:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 02:33:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 02:33:45 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 02:33:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoF0sgDasBDhpBKGy8u0WSX7p2LdWJfhHjJGCfcX+9EjtmFvsDgQbMt+9mtxc5YI7d3S4CUJlNvPaqd1njRAwr9opYLzw9WdlHmcFy4gbDzl71NGeQ4r5c4bmYW8aaEe3NjMiajD8HDcuYVzOP8Q1H5mFSV8d+mDBRYY2q6Ms10MgaK8pWJe+1jPYDSFwY+nhGwfapXHKY5RJBEWlBARCYyHJBbYStdZbh67uFwRGVm18LLE8iH7nBpivvp+xqKJEWQAx39T7xnaZzaDG2z019Jiuh4IRtsTjSiPtXxL54zgt6soVKBwbf0t9EOJLFiPlnSQSSN43SKpTCap1fTFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De9Yf7GHRQntkA/1ls39lwtol2zw1jl+/rKC/MjM9i8=;
 b=C8/jr3J7wrWOvGeBS1Tvt03M0t1SwoxYflA7SkZS6TrvZPrw1bqo1t+b10l+JuwN5ZsNl2n/PY4itXMsc9xB7DdeqI5fNq0xDNUocDOGkfzQYVznVfiX8QZMgLOatNuP1399k+j/zKz+WphS9rKByKQuDVeuqNqrrueJ7EZ4+Yhjwp0Xq99xRajq7EIspW5B46iGbRwdEo1tAbJPWf4nCO+4Kl27diHrunWkRLoCsSDsUP+oG67SY2RVLKyfXYNcsRqWcWTWhb3hGsp3+ilx8P5cFVzlGlCUjfxeExd7LeKz99OQ8+8MSd/BbyUxKhUfZrBdymbIeFeJrmC3TpP7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB6370.namprd11.prod.outlook.com (2603:10b6:208:3ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 10:33:38 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 10:33:38 +0000
Date: Tue, 28 Nov 2023 11:33:31 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Magnus Karlsson <magnus.karlsson@gmail.com>, "Willem
 de Bruijn" <willemdebruijn.kernel@gmail.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	John Fastabend <john.fastabend@gmail.com>, Aleksander Lobakin
	<aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf-next v3 0/2] Allow data_meta size > 32
Message-ID: <ZWXB+8FQenT6717+@lzaremba-mobl.ger.corp.intel.com>
References: <20231127183216.269958-1-larysa.zaremba@intel.com>
 <2fcc90b1-deeb-487f-b6e6-c649bee2e8a8@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2fcc90b1-deeb-487f-b6e6-c649bee2e8a8@kernel.org>
X-ClientProxiedBy: WA1P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::23) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 67244343-66dd-42dd-d5e2-08dbeffd7b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RilpswJL0i0PmxBXNCNzDmLGPS60hqByldZhK80i3mwBcwuIJOulm1L8uQMNILkGrcVs+CSh7ljESI2Jvn/QKFJN2L5p1IcyD0/aUpIlLm27frQDSHi1R+ClP5v8cyiHtO2KS+XgqUcw5dTUiSmQvshc0ZURWQBInBzRyvR3R6pmP1oMTcklAESoEzIHvZFT0MvUTZONxFE+twuQHAmR0Ep/oQmjGKdIBeEVnNqAV4bPZ02PT3qOPZwkYN2XmRoYwgBy26ZPv0Wr47pfZhUOvc89z8RC6DUh6P9iNa7A72nkpjehUzo/or1JcjPhGTeTS1jmQZ2aohUR+aZafBwdyCS+C2ijP3MGnhTNOYPdREqdMiFouqK41D6RgZ1rH1FKu0axrI8VrGAe114REc4LpZalfyWZ8Kw/G7LrBppJTAwLzN988k/cZUfy+s1YBzQP7pcmX8UZYH50lPYk/M8CHVml55TanX3iGAvx4LOI32EV0byz7zJrfXY6iFSQMmtCjPAJaf//s9BuZZk8PV28+8IPKQxJf/TR8ASyRdIG1xX3ZaA2VZXnU2ySVFKynopm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(53546011)(478600001)(26005)(6666004)(6506007)(6512007)(5660300002)(107886003)(83380400001)(2906002)(7416002)(4326008)(41300700001)(54906003)(66476007)(66556008)(66946007)(316002)(6486002)(6916009)(44832011)(8676002)(8936002)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tqQyd2n1ZAkcJRAgsaxP0EYT9rUNYaT9qNuT4L20OSNN1Ulb18An3l2EPcls?=
 =?us-ascii?Q?hYpurkzIKbDokOEf/1ZnlkOiW3DN5L7DPjPBAY5ZGguqZvl5IjWdgFPFYxWI?=
 =?us-ascii?Q?m6WKdWTEUQmyQdhFWjQhkxU8Y9DCerIZQfbTy76IIoXhgzIlZoqf0/87XOud?=
 =?us-ascii?Q?XjdS9AmHAMjlfARgllU1f+fpSWX4UG+wAXXWvBRpmn8MjaPLCG+W8McpYfgA?=
 =?us-ascii?Q?RPKmeYYfJmeARLt7L+I0/+ln0MnlIrZOeKHv4frmy4q96iXYFXW48zGax+GK?=
 =?us-ascii?Q?8aiT7TFUX/GJg7jbtfYvo9S4DObw8mpjNE6IC/5KMDoRIwZjSXfQ3dyVihOE?=
 =?us-ascii?Q?S7FBKde+CrnrW4N38y3b5r/8reHvLH/ugPB6OfsuxFSUD6cX2Me3TfgRs5EW?=
 =?us-ascii?Q?3Nl8wADNjEumob3dc8ehriDNgh0itEcQnNVAoI9qrw8XIlG/H275ahLuy7Uy?=
 =?us-ascii?Q?sRonF8fbSPydswzuakVPQJXLX0uEHtdmx8rP7M2peuuSS8B/BC7XXh8VNMSl?=
 =?us-ascii?Q?MXYCwklWdfDS5tOBkj7gV3Zq2aANKTonup2SvOOfYS4Vfw5RgbSH1QW/nbww?=
 =?us-ascii?Q?O765Z0oKhTJLtITRNhN4XhKsbZw0y+Izv5NBcgBB419YZJPKr9U4FZNNdhTc?=
 =?us-ascii?Q?2/1fDllnc0l7fq1SrZvJns0tag/GnoGUGFkB2XlKZ7PawyBVOCEe74yJWf53?=
 =?us-ascii?Q?9rc+znUJXmerjU7NftUy5K4NvK5COHme00U+KnOxPf1w1u8NjYfVqz/SouZd?=
 =?us-ascii?Q?DBrOMe6YbSSxFrdK/er2QBcy3ZFf2XIdtMUsYWhe1v4IImLkKCiQB3yvf/rr?=
 =?us-ascii?Q?FcvvEQVMH5MZ/cDay44BgDS7PbnWPSW99of9cph7Hcxeni7RUj6vZy4v690j?=
 =?us-ascii?Q?eF1oQeLcT+gtT3RRfNyCSgsBjRnK1GnkMfH+fflohLFXVDrrHLLSPpJK+ycP?=
 =?us-ascii?Q?LrYyyKcqu3iQuP13tUXth9dsXZtUIYeKJ10mHVuAp7p2sxPpSy7Sg/Qth2lS?=
 =?us-ascii?Q?/9nnL5twmVjBjMyVZgyg6+MKGC5/uln08UiPTGO6j5xryvswzyNisFgP1vVJ?=
 =?us-ascii?Q?6TtnhZhzp/HViWTbWdlMxhdoM0oO+eleCtk4knC5CPJEUj846TA4JCszILDb?=
 =?us-ascii?Q?eIaHh7o7bh9PTOmFG01evPOrv12ImzIpz1TpJ1aBt+EJEuXZAbiutSOpv5rH?=
 =?us-ascii?Q?MbM/Sd49omOGH6cIo373kg99L1DJQEwGWS4wznHjDRponQ86tdUkvmumwsm/?=
 =?us-ascii?Q?JXsq3sMwqu/zz8b5koF/OaENwn7+oc0GM1t4fsv9nFfi6LztOlKWTKC0RHPW?=
 =?us-ascii?Q?lOr4WO8G4UzfCnMJJY8Xkx9D1rP75Pd7AowTKeJ5QKW1X4/VjTiIsjt/2li7?=
 =?us-ascii?Q?ZQ/0XYN8rhEXFdgOyxlkn4rZSU0TSjA1UzomDy4htmK7zlig8KEftN03LYI3?=
 =?us-ascii?Q?cfhNvEBPEWa9fu9uczXPtWNyjKppBrMQZvo8NaK8QZb7Cg9xOvU1RjrTC7eu?=
 =?us-ascii?Q?rrUB76zD7X+aMLzvdSxJtIgIoFD3/TiQVn/u8uCd1c3gHmMTKWBviJCEhYON?=
 =?us-ascii?Q?FMUM5xmiGCpY4YnItpUQ99yKyvjHnFTSd1L2dqN+dGm3ewWHzE8bOXDhsKJ9?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67244343-66dd-42dd-d5e2-08dbeffd7b4f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 10:33:37.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOQEoFINzD5EKboXuOcrEyBLpnJqy2NkTt2xrZnS0JVnD/NOqHcGifHbuWlxivhVxsF+cewuM2t1oboCBc0sS8E9Tok+v+5AABIxa5KY4GU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6370
X-OriginatorOrg: intel.com

On Tue, Nov 28, 2023 at 11:26:59AM +0100, Jesper Dangaard Brouer wrote:
> 
> 
> On 11/27/23 19:32, Larysa Zaremba wrote:
> > Currently, there is no reason for data_meta to be limited to 32 bytes.
> > Loosen this limitation and make maximum meta size 252.
> 
> First I though you made a type here with 252 bytes, but then I remembered
> the 4 byte alignment.
> I think commit message should elaborate on why 252 bytes.
>

You are right, will do.
 
> > 
> > Also, modify the selftest, so test_xdp_context_error does not complain
> > about the unexpected success.
> > 
> > v2->v3:
> > * Fix main patch author
> > * Add selftests path
> > 
> > v1->v2:
> > * replace 'typeof(metalen)' with the actual type
> > 
> > Aleksander Lobakin (1):
> >    net, xdp: allow metadata > 32
> > 
> > Larysa Zaremba (1):
> >    selftests/bpf: increase invalid metadata size
> > 
> >   include/linux/skbuff.h                              | 13 ++++++++-----
> >   include/net/xdp.h                                   |  7 ++++++-
> >   .../selftests/bpf/prog_tests/xdp_context_test_run.c |  4 ++--
> >   3 files changed, 16 insertions(+), 8 deletions(-)
> > 

