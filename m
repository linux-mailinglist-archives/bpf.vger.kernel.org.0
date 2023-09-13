Return-Path: <bpf+bounces-9938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2945479EE17
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 18:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDCC1C20D74
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760A21F94B;
	Wed, 13 Sep 2023 16:13:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859A8F68;
	Wed, 13 Sep 2023 16:13:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6139CA8;
	Wed, 13 Sep 2023 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694621591; x=1726157591;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FQZ+v7dSyScIppZfQIRo/8rW/RXiLqAcn/McWkTQ0sw=;
  b=YHp2Gjqa/eAELB1jLVhLn30Yg+bcYQ6X+xzbEmCqZCVwB2Yn59wQMyr8
   ncj4sfHuao5Kyqy7byRwn5PHBxzObqr6YhYkJgHOvRDwjHKqILJ+Zthah
   AZ5X71sB9QL6wV3iUpV2KK1G2CD0yRTt6DS/5/jvyFUv4cuEWRTtykNdi
   k3HrwSBGCmW3gPTUeRtDU2gnK4rKw8snEBnusRlTnfhEAIf5vFZUmVLHq
   68tuY3n3xFy04bCvGQTtBRqDXwnw/agRQTvLcUrXU8WiHqSL/BEVasDMb
   Yc5+azi2WiiZ31z/dGhIomYZ8W+hWLxEfsBqsSl8kjJT9oiFPIkNBXa3S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363740260"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="363740260"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 09:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="744176690"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="744176690"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 09:11:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 09:11:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 09:11:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 09:11:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 09:11:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg+IfYVC7SyeNZUxXLxnAtjfJg0/kjUvRm0Vv1+txudaGRe3bssq/tweXaI5+Ma9SQKuBREVz25Kj+0nexk4g7+veNk2KWK/fTvYuj9AZLB8wO/t1P2F/SGhG06nxSX6FDtVgGyfJKN5hhdbihBQmRK6sodMofQ7kt+84Z7KzW4fkEErv9WgdUzYtxZdSh4tFeaPIX/aZ1XgUThdtdJbvRuHmJRp1rfM5Zni4Vle3HS9xSvxIcBxQ1vUyv5js61NuiiKOphFGxYC7MQRLB4kYBSXNDk2vwixzvmWFogtyqBx7L7bWG0tB+WXv9K6FdEU3oOczT4ounTkti8Y/tPNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sx1Vt8afAOc8axL9LvVMrSaOFDj+f8EmKCq5Ub145r4=;
 b=PfhUg/QxefbWhIbBwEwAl0FDqPF2v7DkHzjn3sanAiX6tfU6c3jWiUuwF7zbzAzxAeCaQYd8KlwQpmwYlrFlPOuItgCSkrJy6NSkLJHlHevMXntbjw6/9kEp/lpIUdjZrTSp+wnBpl7kHxxT1A1fYnV0xaxDvVN1ke/uJFYIwc7mIXWFRLgpu6CmKmKcBvn83CLCUeaJsZujeENFfsz4NZp0wlChYXA5i0zNdtVI/XVakoEbj5OX1T8GdAbB9l6QW7rCWCOCPg/j0nWVCaUUZkCHAczB2GfxpAFKp2e3FLpMAa1TgkEdeB1SiEzbYc6tp1T62tp5SbyJpUT3cG/c6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CYYPR11MB8359.namprd11.prod.outlook.com (2603:10b6:930:ca::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Wed, 13 Sep 2023 16:11:44 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 16:11:44 +0000
Date: Wed, 13 Sep 2023 18:11:31 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v3 09/10] selftests/xsk: fail single test
 instead of all tests
Message-ID: <ZQHfM9ZyGkjmzmTF@boxer>
References: <20230913110248.30597-1-magnus.karlsson@gmail.com>
 <20230913110248.30597-10-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230913110248.30597-10-magnus.karlsson@gmail.com>
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CYYPR11MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abf1c72-81bc-4456-f12e-08dbb4741fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boqCigx4ARghASUFVMFDnImvZw0YqOkhV7RiP0EHYH59a9jOs4qRiaoiRvZWPEh9HX7GaJ8w2xRU7uFoEdP70Dg2vmVV7QQ1jhAAWqCBV+pE2H/+icJFtrTri/vlJ/dDSxF+QKkN2fzNXRoFmpn7fMiFz4WhBSXXvW+PJtN0n2/+yw4Wt1ep8hTrHGjWaj30SmUaHq9lWS3/PjiubAiMN9gIIlnZuaFlIh6eBJ7RWj5Q6q8gP7N3/PlJIIM2tO7X2NdINh0ymiSp2NVhj/p1tvGorIDRUf7zZdYj2ixPRMz19AeipF9T10GWcybGXnppVTwjP0D4s/keo/yWrldMWGNsYvTpufiERKtXFu5t0CickkE9hPdbCJFWcBEaSEHoS8ri3L7/klVAiKMCr0W5PqwT9OalJ/d18lhZHNwwo1eyCySXIDIgqqxhyCiRrSJYWSN2uhL/bDvWHx/lV2MRg9ePRFiiHYAdKeb5Ba3oAvidesFXD0AMVCTpRYmCihTbMLUwR9I5b/MwokjaEQOlxJeZWJwoASsQRM7fo+cY7bgXG4qYYdfc12QJYd0NnI6z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(186009)(1800799009)(451199024)(26005)(2906002)(83380400001)(6512007)(9686003)(107886003)(6916009)(316002)(66556008)(44832011)(66946007)(66476007)(4326008)(33716001)(8676002)(8936002)(6506007)(41300700001)(6666004)(5660300002)(7416002)(6486002)(478600001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8dqGuOvCnyjifLMGw/UGDTSiK8OkZkZx8ViI/UBa0oZhNn2pSiTZZm4bD2+x?=
 =?us-ascii?Q?g3p/2dVnuNnz27PgFcSID9Ix2vMfvM9oq5gKIURpKPvOimSCg7855LsXsfI2?=
 =?us-ascii?Q?WMHmwQv5Y/ZC9Z8FPKtDjxDEPSP3MY+Yriz+wXJtih8YFCzTkemsaUft+Z54?=
 =?us-ascii?Q?TNLeEkSPf3rqS1iZjyMswdS33EWb1DSmVxenOu0APc33pEm4ZrlKpQpvaJc9?=
 =?us-ascii?Q?E535qgWwXR7X3u0NaTUzkP1U5jhjvAIj7/+Q2qRySKIc5WoQ8+7QcyMiKhS0?=
 =?us-ascii?Q?DGMfUfwrkrg3xSHXUk05KdKs+SjlZMg5Z1a+vc+olLxWV+a2Os4/a04OIn4c?=
 =?us-ascii?Q?bt/ofB6PyJaRlgML/qImzmdwJ2XLlapZMapqwdTxkWopvC1ghuL58O4eFnmy?=
 =?us-ascii?Q?O1lMxofWQWZajkRVzzRJXUyLYtATOUKK9y+4FNn6zN8CFuOntF0kltSlk0AA?=
 =?us-ascii?Q?Nvb6s+ar89670hpO796aIPFedk9GQZtguJa7FRukEaKaUSdkXb3MYZIvRyCg?=
 =?us-ascii?Q?1hsq1LV3dN+8fTdOLBkzhM5Fo5o/RY+vxy1ew8KoT8XIrcxwfyD9UZ9whf3R?=
 =?us-ascii?Q?x6s7K5HRGKSsNN0Trwwg9PHXMlvOJK4nnHMyYtGojekviLIfr3LEo52fjI9N?=
 =?us-ascii?Q?4BVDb72EvWugaj6uMBs0Re8OaUlm2vwEri3In5klYAO0EATKb74IBXCYjIzH?=
 =?us-ascii?Q?TaPdNDX6mqVBEd4meaVxT2dwirJrg3b0oi0AlsAKJ+AI3bwo/UnevWinx8/G?=
 =?us-ascii?Q?mBPjqq170/SRzFxiU/HNrD4mN24IaFvp8Fp+enZ/S3ZPRCyDkoPo8AqQu4XS?=
 =?us-ascii?Q?ubtfCSPh50n9Hd62lyBQiVXpEu3Qp2jzlj6AQOzXEnMzS5Ntfp9etsEVfM6b?=
 =?us-ascii?Q?7t9ZHYFLOcbQykO0IQWr7l5H3WIjt8K4Yfeg660v/oIK+S/rziL6f8hufTdY?=
 =?us-ascii?Q?qH3SdgLA5P5qUQV2o/pA+vQFFrxSvWR7q6BxAYCDfuZz7yWb31claHm5Se43?=
 =?us-ascii?Q?VGJoP1HQsB1YrzOPY7ibNHwHbLFLov2Fh4osYndC76ynmV2AVldu+JobVHX4?=
 =?us-ascii?Q?v1lCNVFgekxphN7mUXIsQVsWJQQOUXE2oMdoHNGrmQPc3CoBkej+TxH9m8d2?=
 =?us-ascii?Q?BhYIxix6VyHQSbIWeZ5/M0Kw1WJM1w2TeGjALaZUCmBG8ToK+l7GX3j8LDGW?=
 =?us-ascii?Q?/TYGN5gkL8Z5vJQRbMXfLLaPm2O33bd/xG3rWt/TvQwmQYxb4g2Cz88ZwDb9?=
 =?us-ascii?Q?Y8mbfbKTy3MTvZDhc5UP3bZJ3nX4na3W/iCRAIZ2ZU2vYxtIZUNN+WeDiRZK?=
 =?us-ascii?Q?hfxTK+agstd51yxnLaKj8v4B6zzT9wJ2qF3c6Ed7ZkzOVd4NBzAxGTwH8Pcz?=
 =?us-ascii?Q?o/USiH4tbdZR6kD3/4KLPO3QOVXyNpE8F6dXImk/xtXq1eIWb+muLLo7Veye?=
 =?us-ascii?Q?VBwWa4CSxjbkKWNOQLbbeJZ4vUj1AR4L1nJr01K2PIgsqkVtCPr7nriwKncX?=
 =?us-ascii?Q?0iHMAHQEXRrhXMNjR2lwKO3IBQcP2eJ7Hbl/HutCc3Yc17i8y1kVPJluq8sN?=
 =?us-ascii?Q?H6FaxTl1peIzaRx4UoSmu3B9HegoN/f3EHfu7Qc3T7lg/N5eu9kB9krY8+Mc?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abf1c72-81bc-4456-f12e-08dbb4741fcb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:11:44.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGy1Umt1qu5DgskN0zAoNeI6KcbgLMNEbpcn+fOa1L29+UMqj7rf1JK0iCiatCrL+QsZ+tBO4Kf3LdMwRfPQ0fM2DyK/2ISPq1yD58wF5pY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8359
X-OriginatorOrg: intel.com

On Wed, Sep 13, 2023 at 01:02:31PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> In a number of places at en error, exit_with_error() is called that

hmm...translator interprets 'at en error' as danish language:P

> terminates the whole test suite. This is not always desirable as it
> would be more logical to only fail that test and then go along with
> the other ones. So change this in a number of places in which I
> thought it would be more logical to just fail the test in
> question. Examples of this are in code that is only used by a single
> test.
> 
> Also delete a pointless if-statement in receive_pkts() that has an
> exit_with_error() in it. It can never occur since the return value is
> an unisnged and the test is for less than zero.

your fingers got funky over that 'unisnged'

> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 70 ++++++++++++++++--------
>  1 file changed, 46 insertions(+), 24 deletions(-)

