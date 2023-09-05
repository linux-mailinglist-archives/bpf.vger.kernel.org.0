Return-Path: <bpf+bounces-9274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0F792EC9
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 21:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F3A2810C5
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 19:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6E6DDDD;
	Tue,  5 Sep 2023 19:23:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0362EDDD5
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 19:23:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523349E
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 12:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693941775; x=1725477775;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KYsu1OVVxPfmyzpRp6FZTTzEwMzlRKLBCUEJjtk/rUY=;
  b=SVTRpn1+U5JheO/bQI+9TIcWFwwdjdwMNd5tEDY4fnxpUlXf897ZMj1g
   +83GimLQT8cA+ROQUEQvudbnAj3hbMecsnJKja/u0bgzx6RqP21FHkHTV
   bf7q3KwUxtHVdvl7L/+8SaKw4ONDeozDDierycMRvWhktIP522522QDe1
   E3EbeVwaChEXzEVAjTYgxgEAKGM9X0yY+FvRSNKNlgX98cASK4pf/ZUaD
   wiN4rnQbBunNc482FWmKok4BOfTRu5jjMQ9JPVQtWftUkJA+YvJQ/JoIT
   vtmzVGSH2qwuObbxBVI9Az54XPKrYODB1c77qArJmGd9c6ug+ag+sg0Jr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="379602797"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="379602797"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 12:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="987942941"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="987942941"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 12:22:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 12:22:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 12:22:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 12:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTL5Eg4aM6gdJexFE7S3K0hE03xt14qvk8u0c3j+X3VtBDw6Wl3/T2lxWcQS7kyKhdn/gp70Rm/az/RtQyfqouoPo0JR1dZC2onN+Q+CuwxqkdIXxTZs1XtsWH1hkmBmIpsLtxB0C994DGLxr1BNOoPgi8hIqPPdnR1BeHSYK5Plx9XVmrc2nJ5sBPChBoTJoSETESM6VkBCBTov/qggynhFl/i+M7k2tVvwgmZJStILbnvbRDItgrBNSF1+zEWlRgAelHryYr3lhpisnJqtQRBtTrZmQBZhoL7hI74iIeS58p49lM5FFWNlbNiyWphis21PAEzW8P00Z4KmBN0Asg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHguxJLDq4ZaLXsxg/jEbk8RRySbWo/35gb0gbHPXAc=;
 b=cElK0Ectz5I5clTRlRBdTALrT+GW4ei8LeJl6w5pe07sYOYhJbr6QP+aigkQZOIj87dgmWu3cAUe6NuY+xI/KdR3QrUL69x5bDPzRPKmMgi6hJE3LuywTMhNxqfRdomRh44I0h/xWF4PjTZiZchBG+ZjG3Qh1yY1BE4M/6pmt+Ohd688gkOvql8VezNW/axlA0um2Puv24U1XkUjB40RF2WFc8VZAn5nKbvwg646C3PXssW9teWDpT8TBDNs8QIN/sEyvftMRwHqumG7WzZ75s936uMcgnni0IfY1hVHreKRuVAnirDE4VY5M3b4mGT0mkSC0puU341rOTrab7/oYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5062.namprd11.prod.outlook.com (2603:10b6:510:3e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Tue, 5 Sep 2023 19:22:49 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 19:22:48 +0000
Date: Tue, 5 Sep 2023 21:22:35 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<song@kernel.org>, <iii@linux.ibm.com>, <jakub@cloudflare.com>,
	<bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next v4 3/4] selftests/bpf: Correct map_fd to
 data_fd in tailcalls
Message-ID: <ZPd/+49iX6DrSyCE@boxer>
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
 <20230903151448.61696-4-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230903151448.61696-4-hffilwlqm@gmail.com>
X-ClientProxiedBy: FR2P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: 039fa375-9503-4586-b4ee-08dbae457da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4+ePIJScfRANA2UIes09lrz6XHipgu8AJZgfSyTDBpfolBJqUj84nJUUST4Mj8BrvRHWueHTBfcl15Est8yNRi1eH6eUv3e07k3O1Bfy6JdsSopeEyI2Sa5qXhbGtFQq+UYu+jIayiJ57WQSwMwBWW4EaZ9nFZ7jVCsaGkvwyWSTIzVPKNWG9xRYO38pQ0n1TUcze32HBLBVy/I4ZwNbbI/Jp0C8fY+VmwRckyHvEeWsuWfnv/RLXhuwNbhNk0QlrNE1hq0T4dhSytrGEiIu0pcgkApeK097crOOX4s5ujLiDYCp70OVUik+UVYlt93vWfaVxVISutzLzKA4D0gM3cgFPHL4L2knV0nn6IzpQLV79vdfWcyQY8mq8w1btWnc+FAGB9XhYR6DeVn2KbHlV0FDCk4PUkduSzudy3nur9NiHHdupocviDN+IIz8p88yRdfVfq4wYbIMaWpjBB328z9bQxCS4bM+I2yj+mB5IV4A2GjCRHcmS9HeCTtkThrD76o/FJeMi63g6Zcjb3FsSzv0mtFBixd+9tpcew3wN88Lv51xtrjtwK/G/L0V2rs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39860400002)(376002)(136003)(366004)(1800799009)(186009)(451199024)(26005)(38100700002)(83380400001)(66556008)(66946007)(86362001)(33716001)(6506007)(6486002)(6512007)(9686003)(82960400001)(478600001)(6666004)(66476007)(2906002)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(41300700001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HRAKz3xrTzv45AIStxAPrYcrBohBXaEMBQ6KyEwbSrfK6gq6NKLX2D79u4Wa?=
 =?us-ascii?Q?RKtmekVUA6BCpeu/zH/rbWuOzSg05HN2XKzsLeoETeU1m3V2ocooUR1P61IP?=
 =?us-ascii?Q?tQfBeiDSf1uq/RGbx+2B1Ala8dQGSFuXK/gwvCEK4p+SqzC7GKfXHzEjo9UY?=
 =?us-ascii?Q?EkxHQfGBhFyDR2JcXqyciEtFfuf7/zjPG/9+48b1uazXVV/9/uLPlxNjD2aR?=
 =?us-ascii?Q?6YwXI20eHLyJj8ydkBMu4C0vNHIgg+qIxFY3sVCSncKGTSm2WWtdAULd/vwN?=
 =?us-ascii?Q?owhU2P+scd6bkvQ5dYs8asWfDt9Rk2dCsOa5hWt7g2eI/AdY7G/obLbQqk2k?=
 =?us-ascii?Q?VP45v6wIt0zFCL/TBTTITab3Qf7rErVyAi2EWdAzWy5yt2rmfjtyp1WXzdrN?=
 =?us-ascii?Q?HlASqNPb0/pN0roqFHyHfPLwFbmRPSljStvRMR/kQvGPDeX0deZbp2pbnT4m?=
 =?us-ascii?Q?B8/lcIIWr7enTJpTyRaRgjSiNugJNc9s126KueNBWEUZmuSM1qGQVFugypYV?=
 =?us-ascii?Q?Bbngfgg3ywH+pB8FE0RbmWyNqcp0/sHTQKby3gyhkhfa63+eej1ozZyTMS6H?=
 =?us-ascii?Q?cAZjZ8rxHRT5179Wbuo3Us6lbMDwGI8RX06/9Wbyq/vSXSdBYylV55N8eEkO?=
 =?us-ascii?Q?sgm69AgjumjNmmEYECDWAhDIfJ+IpuGqmjCd23B4l/3hi11xwQpyMGyQ3P7M?=
 =?us-ascii?Q?9FD+6yquy0rKszSO7TeXe5JFZ/gcfpqTxbUCVzwkmHgD8ZtMjSDqaFWVbWaO?=
 =?us-ascii?Q?sn2PlyaCWtsDhq3tash4ElGZzkqG4eDcnxfSPdq3MtZsneW3PMoh77R5LwaO?=
 =?us-ascii?Q?Zem1qbm/ryJaDDEvwf0DiE8aomtDSFfTDbwJQThmGZeLC04m9U1ocMh+ZO3f?=
 =?us-ascii?Q?qYDmmAGRZYb+3a10Cfnqt02ScJTsIABxy0ZsGWAtylVbyU0wfoNLMiBw+Yfm?=
 =?us-ascii?Q?0PJYDLstcBBt18vqhroLMYr4f6ANkBHCVDVRY2zBGhcyDhqVjCcHmuBvX+ez?=
 =?us-ascii?Q?iVNUKS1hEz4k4VXHz6akitZHOofWIowJlJ63X3e5/5nJyaoNt6fECG0qvbYc?=
 =?us-ascii?Q?zXkvkIkVAJ8hbfqjQWBujHXvMDvebDhqbJvhttzw2++sCsOvEoDnldVjjSge?=
 =?us-ascii?Q?Rs0fKXRcJYuBOZSkES8qNrhXzQvZ+2EqdBSj3Sf3N8Y9yI9/qhcXXSc5hVIe?=
 =?us-ascii?Q?kDlElr9vcANOv5ltAtMjYYqmh4gpC0nuv3A/EAL992F1FA20MrNi3HJSNi2X?=
 =?us-ascii?Q?N3N1gxUpe4m5NnpoxbVz96sabyH0zvEfx2/xvhxGk1Su469e7Y0V2GWMPdBX?=
 =?us-ascii?Q?/mzT0uceU1Kn7LE21B2eyG5qC6FBo0IUSdTthSHYoJXiuP6k/dfObXhQ2Jt+?=
 =?us-ascii?Q?knOYrvEThJtTM6cwzYL0xFK54s1ecxvV/O4RlVjd0kUFx6zl+gIRAsCKvH+6?=
 =?us-ascii?Q?gu/uK5GZzR9cqwJ1kMWttUB6ciPlnKgooGQyDDU2y+dVsULkZeLS3Iogt0gw?=
 =?us-ascii?Q?xwiHXa1GFy6B0Y9RprDEY8yeq8qT2xrcCzAxwFEn9xmwvZPUZ6K9IvqM/BkI?=
 =?us-ascii?Q?Vdn38XdP5XuVfM7IjAB8qM2fdASG3l4v39JGfeEAbRFU4v6RTg4LIE4UrV1F?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 039fa375-9503-4586-b4ee-08dbae457da9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 19:22:48.9134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9zdcOw4SlsACSadDPmdU6amFpw4SxzQARgKSBrrWzyZXKS8goFCsxp2YQey6ixjkc9XfRJAcUGFpeE/ZQwmCyHY5PoLs46cqRjjEjc1McE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 03, 2023 at 11:14:47PM +0800, Leon Hwang wrote:
> Get and check data_fd. It should not to check map_fd again.
> 
> Fixes: 79d49ba048ec ("bpf, testing: Add various tail call test cases")
> Fixes: 3b0379111197 ("selftests/bpf: Add tailcall_bpf2bpf tests")
> Fixes: 5e0b0a4c52d3 ("selftests/bpf: Test tail call counting with bpf2bpf and data on stack")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>

This could be pulled out of this RFC set and sent separately to bpf tree,
given that Ilya is taking a look at addressing s390 jit.

> ---
>  tools/testing/selftests/bpf/prog_tests/tailcalls.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> index 58fe2c586ed76..b20d7f77a5bce 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> @@ -274,7 +274,7 @@ static void test_tailcall_count(const char *which)
>  		return;
>  
>  	data_fd = bpf_map__fd(data_map);
> -	if (CHECK_FAIL(map_fd < 0))
> +	if (CHECK_FAIL(data_fd < 0))
>  		return;
>  
>  	i = 0;
> @@ -355,7 +355,7 @@ static void test_tailcall_4(void)
>  		return;
>  
>  	data_fd = bpf_map__fd(data_map);
> -	if (CHECK_FAIL(map_fd < 0))
> +	if (CHECK_FAIL(data_fd < 0))
>  		return;
>  
>  	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
> @@ -445,7 +445,7 @@ static void test_tailcall_5(void)
>  		return;
>  
>  	data_fd = bpf_map__fd(data_map);
> -	if (CHECK_FAIL(map_fd < 0))
> +	if (CHECK_FAIL(data_fd < 0))
>  		return;

shouldn't this be 'goto out' ? applies to the rest of the code i believe.

>  
>  	for (i = 0; i < bpf_map__max_entries(prog_array); i++) {
> @@ -634,7 +634,7 @@ static void test_tailcall_bpf2bpf_2(void)
>  		return;
>  
>  	data_fd = bpf_map__fd(data_map);
> -	if (CHECK_FAIL(map_fd < 0))
> +	if (CHECK_FAIL(data_fd < 0))
>  		return;
>  
>  	i = 0;
> @@ -808,7 +808,7 @@ static void test_tailcall_bpf2bpf_4(bool noise)
>  		return;
>  
>  	data_fd = bpf_map__fd(data_map);
> -	if (CHECK_FAIL(map_fd < 0))
> +	if (CHECK_FAIL(data_fd < 0))
>  		return;
>  
>  	i = 0;
> @@ -872,7 +872,7 @@ static void test_tailcall_bpf2bpf_6(void)
>  	ASSERT_EQ(topts.retval, 0, "tailcall retval");
>  
>  	data_fd = bpf_map__fd(obj->maps.bss);
> -	if (!ASSERT_GE(map_fd, 0, "bss map fd"))
> +	if (!ASSERT_GE(data_fd, 0, "bss map fd"))
>  		goto out;
>  
>  	i = 0;
> -- 
> 2.41.0
> 

