Return-Path: <bpf+bounces-8570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB427887C2
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F1A1C20FC7
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9532CD2F3;
	Fri, 25 Aug 2023 12:48:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA6AD5C;
	Fri, 25 Aug 2023 12:48:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A991FCA;
	Fri, 25 Aug 2023 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692967722; x=1724503722;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U6dP7796ZkK7/SAw98V07YK9BHbCpMaSG3Ec+20rYeM=;
  b=jUAN4iEGK/lZdXhHWi/MuFIIVzitJIgcwqYcxoKckMOJMcnKpwMbL4BF
   +WOG4Yc9/CmI2Xj2P02a841ejAi54BnzzX7qTxa56FpTfgc66lhXEhJIJ
   QSkzAJc5gYMYidlhzAp5FguZrlm1Ifc64zHe4XfRHrFUIgoqyhi/kLDfY
   /DH5/XbwUmwqkiw2QqlJk5D7Olg+R01XAhtHNtbtIc5yLihbnq80kgLU/
   MNMlBJrqX6vizKrnS0jFK4uNPKwLBxY9ILByaAtw/pLJhcHnvWuh+bph2
   HB0oliaqCRhkV8VvdOCOlEdud8tvmdX2DWMQmckLD+0aZvfhYcqIg1CHa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="378488746"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="378488746"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 05:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="766946393"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="766946393"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 25 Aug 2023 05:48:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 05:48:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 05:48:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 05:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHGUVVZb/qnL2IbU3DpC0sa/y8pNr7Ebdqf7NOJ8SPdJKTkd6Y/TD2YeET6Cg06COnO/VSwxC7AN2FZZVNmbfoh/bjGuhi9sc3jHNERCAvxva5jaXZ7fCZMkLBo31XH2j05dp97V7Ervt8sJs6DdOgFa90k5nFwDqB6gwG5JvZPg7OqCG73A5oe41lDCDJpgSpmpmiusNQGQcJk9/4vga0iUmdJFeWfkJe6ENuEAqzcoRDuFYGQzG8h/lXwJn6D/m8yh9c6cw9nyXohOwnfDR061qSpSugA1OuNhyRAl0jltuGx32l1X0vrbAFxjgk6hFbuoNhKRSK5eLiU+4rZDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3C1THDijrEXH1/cZvVifA5s5x1qtWKYz+2o8OO4Qlw=;
 b=DPkGqqrItpsppryBaZ0+kdeW6ETA7cGVhiCzsoRaUoUu1YzvY9vd5qGFEHX/n/nrQBWJKLZDnTotF4wyQPAWPGWIbquYpGsm5FumEma8jr4qIwrzF8WP/t6cS6i46LvpXovOiiVWm/0l8dyVvu/n86Roocm541EobF9AK0AkPBE65MqHcpBxT7L122yJN6kyH2DLuo45x12v5l8IaaDOVexxbSzMbwaghe6sV74SlhZUWLU6u1hum+vl0Pz7jzj6j2TIPQrOml4Js55a1cah+2C6li8JhxfkifhhyI87wkkbubNyLh5V5w9N5E35wj4C2/r9mm6TkDyVL26R02N0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 12:48:38 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 12:48:38 +0000
Date: Fri, 25 Aug 2023 14:48:30 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v2 09/11] selftests/xsk: fail single test
 instead of all tests
Message-ID: <ZOijHilmP7/ljwKq@boxer>
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-10-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824122853.3494-10-magnus.karlsson@gmail.com>
X-ClientProxiedBy: DUZP191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: 5007dba0-0cb7-43ec-7ae6-08dba5699a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQOnBe7NXsqqF8QVNMyh8l4TkjEmCe5cvEDjYjsfheYPBeYGnBqrUanxWFALRViHJ1nS0RK/k8DGYppevRX4f7/ujvnnVC20JSGW8HUVKYztZIUh/ytOrsWO0DMibXx6fBXbCY+ZreKEQ8DBKOVyoxqpEcqP+OCKQ7c0pkh79a8U9u7pY9PbGwXd6EERlXQs74kk8hZ8w7Byw8yE8Rw060MEsCxumraShpT7jhRVVZyc1VZxbhLsqvXrc76BDSuIH5Bkqi1OyLj/rNRgSCOq8ABtT7MrCvF0ScgT/noth4SJVQtKok0KIi13/1vy+G3CFYm59UhaW8LNCenjhXV88n25VUrQ9w4d3IMvQbqJcBl19WJmffW8nPTc22DFNzV0BxhfYuK+AQZRh7tgpw/8xM7V6xcuN8pikUYjFAKBNOGBhwmAAhyj4gMYhr22NT5W0HLe34WLKJ2XEiGzkbOvnR7qD+BYkbdfS0I9dcRRJxFIjz65kO23mWkf4pqsuNlMndNuMkCUprzenkHo3F1zH8xShJj/G4JjS2Ms6agHZMgMUiYSP7EulMugvJ8mZ65H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(82960400001)(38100700002)(8676002)(4326008)(8936002)(33716001)(41300700001)(6506007)(6486002)(316002)(6666004)(66946007)(6916009)(66476007)(66556008)(86362001)(6512007)(9686003)(26005)(478600001)(44832011)(83380400001)(7416002)(4744005)(2906002)(107886003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HTD+VSieTZX1WWxHaQCnjLV9mY76FDlfxJucy7LLt/CW+yRIkDqnZqz1C8R8?=
 =?us-ascii?Q?zlO5iKPr9T7SK+S2PXUvsXCG8716+3vMCgzYKU40o3c5G+RzvGUTpmmUzY6r?=
 =?us-ascii?Q?FFOTY6Ansu6Vswq4qDQph7KNktNFcye+MWupGTdH7hf+mDsWZzrQD7BckQs3?=
 =?us-ascii?Q?lkxWYD2jutptcXZcrql5wLLhnCFoRJ565e2GV/AsJ8RCUCoWbj662fR8ntoZ?=
 =?us-ascii?Q?hWk9rtgp+OCGbHU551l9/G5ZZgTaq8E0u6sAUPkzpXmv5SLA7E5yJQ6+ZpqH?=
 =?us-ascii?Q?XxmhNLVBDFgYFAXEYyI8/tivMkI5meZeQOiUqCXzHVjs0jL3/mY8tmL1GL9W?=
 =?us-ascii?Q?mVT+lVUH7RnV79IWeixy3cAK/0xzD5g1sWmn3lDCRHCWam+5xLmGeo1yQDh5?=
 =?us-ascii?Q?fBHka1dfMrZiQWfR5L0I4tjGMv8bj38aJF9Euzi5X2lkUJg53q9Ir7qx7nQU?=
 =?us-ascii?Q?g5FxkXUTB/bGAMKeQW5Cak9rQV9BDW34Dae/JPEXD903asxg7FnXaFg7VWG/?=
 =?us-ascii?Q?UH487UFROwxRlS1xb5Z8+l4b0mfvKKX1ogFrK1Av/a/D3ZTPDqQvW6ZcC9lL?=
 =?us-ascii?Q?Q8T8R/DA/1pjsleqph5yApMx4/qwU+vRCP+cBUsQ3R/fKYAh4yBWwuDkfsZp?=
 =?us-ascii?Q?ADooYYUo6Hsw2ybOai3SKTHzm9hsGWhj4Ji5NmVqWJhR6o1M87uUweqjfNZg?=
 =?us-ascii?Q?+nxo5GYjfqmcfvlESO9imsfi5rPVnD9MlcZ10A2/2bLfEO1RzVd7+wNDuQ8U?=
 =?us-ascii?Q?+/Fz1ToPgtuE4p2aTr36BB+FcSSouEBSZ4rgOoAT0Og0wjjiBz36SN7dPn+X?=
 =?us-ascii?Q?z4JWzqnDqQg/wu2M16iY1176YKK9EfOAEQ/BvWL7varKrKjG3H92KrWhRkgT?=
 =?us-ascii?Q?UGWW4SMFmBf+BFFA4urQL2YIhmNNGoS3LPwtZlbhsCJZcCU2J0akCxSo/Xin?=
 =?us-ascii?Q?PMrFM857c7Vt4//qScSllX3sCly/nvi6gkUNcPskJ9+YXvlht8IPNjIJFk9s?=
 =?us-ascii?Q?8i230relZlTEf6IN3qJizRjqbdewSXi7AZzqkgBSk55qz6swmqP2M+2ey9Rj?=
 =?us-ascii?Q?MWacoMxiOY/RGhTmOY4d4C15sRVXaVQNifmQ100NYpavYg/QeD4jVfz880QJ?=
 =?us-ascii?Q?h7EYedL9zbA+nyy3IXEcyOI8HymzwrFwUFxAUZZF22bChvJGtXFNwkXuAZcy?=
 =?us-ascii?Q?iXfaaMAlxR68P19lUUhgEM+GD6uLAg7n2H+cVUT7CYY3NJJVy/rYdtPLeSdG?=
 =?us-ascii?Q?XS4aSlkJEAOObgJvgtsh4Ap/wuVVLVLHGjGN/ALjkomQt2U4CoXhQPK/uaZU?=
 =?us-ascii?Q?Skia1vRKeY+wsY5vbkdkShWBDBb4aAVsFb1ANtS/Lwg7fe4lcO9V7Wi6jiOD?=
 =?us-ascii?Q?ob8STSeLO5QZe8+Y2A5XtZbZbjmGLyy510uR/0tg0TjQHjgwuYnpWfZw1LLz?=
 =?us-ascii?Q?OEGuSeru6DoXO3AP4RlKNDBeWgSff6bWyf8HS0idLclJBiZZm0POhoa7ZBMh?=
 =?us-ascii?Q?JHs+7o61auOdpFyd2Qv85NcSL4yrsk+2zknTS71S7xLTWnm+zshBu38k4esT?=
 =?us-ascii?Q?vNIwDSxTFU5rkBZsFxI6joSNOh+vLoaOdcBIuYS/j+yvmPbv1GekD6PXUbyr?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5007dba0-0cb7-43ec-7ae6-08dba5699a2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 12:48:38.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHybsZkCynefUjcaAYYN7G+I7HcIeQMCeTfUfrDw34UpIIEV5BN67J6asSs9oijHa94TJBDhMadmDs9OTTjPZETXRFY0My4IoZWCeQbxtMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4798
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 02:28:51PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> In a number of places at en error, exit_with_error() is called that
> terminates the whole test suite. This is not always desirable as it
> would be more logical to only fail that test and then go along with
> the other ones. So change this in a number of places in which I though

nit: s/though/thought

> it would be more logical to just fail the test in question. Examples
> of this are in code that is only used by a single test.
> 
> Also delete a pointless if-statement in receive_pkts() that has an
> exit_with_error() in it. It can never occur since the return value is
> an unisnged and the test is for less than zero.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 70 ++++++++++++++++--------
>  1 file changed, 46 insertions(+), 24 deletions(-)

