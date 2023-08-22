Return-Path: <bpf+bounces-8233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5697840CD
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B81280F65
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 12:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFEA1C2B1;
	Tue, 22 Aug 2023 12:28:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9BF4E6;
	Tue, 22 Aug 2023 12:28:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063731B2;
	Tue, 22 Aug 2023 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692707331; x=1724243331;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=41pdVDtVysefg1hbRXVg4ej9w9crgX26ITlfwcKgG8k=;
  b=Nni0VeATkUUS6OOcTjapZf2dniGQ4eg3sva06mOKoyUyS+g5sliNttYz
   89o1Ps5flHsgINgiR5RNYFcBBsxFe6o4SqQWzGqK3Xah8p6CqpgF+edsZ
   r98emVMdZM0+XDOAgdMEEV9eP6MmhZJaPzRiLvD+Gh8lOeoP4LQJpbx65
   etdFkINUkk00LV1+iBSjjYCm33JfEjnh2WOEJu3qcp6dk5zW4edDUIQ58
   Hj8ruId4m42QyP9Q4MY2WR0nnGAsOIOl5PiythRsNX059rbrg1c8vU87r
   WYXuf+rsX1uyf9Lo9II1i3NoEEHp9YDUCq3l2FcwGcqffGT3eya93j9SI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="364031034"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="364031034"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 05:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850595130"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="850595130"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2023 05:28:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 05:28:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 05:28:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 05:28:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 05:28:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLU6+5NxY3S5FcpZZOnMCVf8ILePvGUL375unXQrHVGf29jWwIQxjMLrQmXxuB6R4EszGrGbxqnZmJv8FNkcbIzaEvhgFoJDpkpokfCaPBQzaK4Sr68rwf4dMoF2A47GGLOE1yRk4M/u9NoCD+79mu4chaboQajbaqPQ8mb+wZIGOAuXD17/uLkzdVTwt7mNc1zsF/lBMGNgKlI2Uq628eqa59lwIRlqwNFfcq/pOcq9HG555egb9gM7kcKY8REw94s8hF9FzO3EhGQ6pwYJWLD/K/3BoV0Lnvt/ahMYxq2AAmmnaXt+8qq8LoVGm2ICiq8Zk4wxjppJGLWkLjqajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFpWESin+KbWB5g4ICVDzI9SGqGjWoyOlW9S1m+PwEU=;
 b=ggPPU7FQlcYWNmHK/jekUiFO9bMAF2fv+3IAP8Z4fG3YsuRYBk/4z18fIGINzni2giuTr+e3eTc678sCQbvGMQGmYXwj52pkY7XDhu7AF/+JPZfQGkowyweOWECJFYy5K2XCsYACUs8qV/RNNx3O6jB9zFjcTo8+jK4i5NYbBfQZETmxjX55PmAfKhY8qmcAzyQQpPo2eTuACkHKd7q3YcFRmOIkqRXXGQMIiLoyfXxhlyEo6UpByaY0Bf0aZ5bNWRe9jqHmZ3xtUjcms5635+37DK3dc9slgsvHPRwSqb/fUs/iS2JaqrGkFBX1rGOz+B/9Ma58H0avYilYVh//rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM8PR11MB5608.namprd11.prod.outlook.com (2603:10b6:8:35::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Tue, 22 Aug 2023 12:28:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 12:28:46 +0000
Date: Tue, 22 Aug 2023 14:28:34 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 05/10] selftests/xsk: declare test names in
 struct
Message-ID: <ZOSp8sbkrN5TOLN2@boxer>
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
 <20230809124343.12957-6-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809124343.12957-6-magnus.karlsson@gmail.com>
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM8PR11MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 3663f0ce-2d74-4aa5-1905-08dba30b5462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LnKsg23E1DVcuaWXUcI+KgnLNWSdRAyF4g6c6nIEbdLWf3t2BvRP282UauD6vaCkyAWL5qIDKxIgTAU5ABnM7L5PfC8YcFZeVmsJUTaC6NuMoe4EalUNMc2oAZlwRDM4XxQCULsvUye5aeY4E01NmpCPwl7PQrsgLAHerOiOR9XaE4tstKxgaWqaQc5phqqz4bTsXcj92ecTA1dIBXnXGqTqgVzu/pEVZWufjeCm+Eu86ACQywtnaKPUtGd2ttAT4BfDido652n3rAhzm3NZKxPWrrd0q5b6bn85kp3Ec2N0aETLq0Thdi1NAuFFFvZRHRm7JizC+fn5v3/WZYcaBRdrgOEO7fzAdqKPa3asZQhFblxlRYBLDNxz+IbZ/t59A0jIrSxVC76g/lfk0OBLNH1qYc6E7k3iEFLV86All8atJyJ3LHWT++bonDXaYTp84ppeTAncnid42fem6VbpwqCuMzcirwSVGJo36LDr5s+LAnsKARwetPDHjDDwHIoAkJZIl3MfvF++N10Wpg/CXhQisAQiDApTJ8Sa5KPychbDmr+Oxa+zczGS5LlTgKT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(316002)(9686003)(66946007)(6512007)(82960400001)(8676002)(8936002)(4326008)(33716001)(41300700001)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(30864003)(2906002)(7416002)(86362001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QVsGbHBLWK3xwwjQfTsKGRImcnH7rYRFXmjgae8CuRKwCOuCQGhd6u4V1EeA?=
 =?us-ascii?Q?4InPEFNYeJxxIOnQssZ7BO44bvXO1PEd7qh2b4V0rDVGGE2IGxLDef7jBjER?=
 =?us-ascii?Q?B5WMpyQdLWHTAkpvItRrsBqmt6gEPWtYygx3m+rpyc68WmMIt/gQEBr+ZS17?=
 =?us-ascii?Q?o7YD2LHesuEtrCn9VVmbxWUv/k0cLDuv1fibf+PJCkyA9vJ6L1p9OSxCZB1F?=
 =?us-ascii?Q?DcLyPTn1Osm9aIASMf0W/6RlwXHXmzhBYkZWHoXdm1XaOZUukbgf9Z9cb40x?=
 =?us-ascii?Q?sw6pKxECVNBEwdL94DAXO36LxiOGZCC/GsSij4LWy2TRARkP+iDiJsLsydlf?=
 =?us-ascii?Q?GC3Yi5RErXD+RM5nHNcxOXS8/kob0ELDmIpRmfbF/UA4yOTa0WmwVwKKwb18?=
 =?us-ascii?Q?fJzThYGqiSRKF+/t9WsnUprOZ32wqqi6vvVIY2eSdfHomXOC37jo9PjuaHVS?=
 =?us-ascii?Q?9IJUy12TBXHr5DYnVFpzrmwMCc+ZqtKaJK9gwn44pHANWya07N2tUmAUXrpZ?=
 =?us-ascii?Q?i4zybjqxp+yKT3qA4f0smz8iJRGZMrdgJiFJB4xtj09CmLzqEaw1x32XRmOd?=
 =?us-ascii?Q?5+mQrOUguivbpA1dFH9RzEGackMXqNiAlRwWk7QJg+Luwv0tAf5I1tLICFzK?=
 =?us-ascii?Q?yaSl4wzj+aEkeZNsOAdx6UmBHkavnojnIsxqw4DNMe1RP7BzPBIp8YIrlqzI?=
 =?us-ascii?Q?QWDFfELPcKt7Xvixy3hiNmMXZykktYnwhBsEljUxzOJAjnoS6o1nIRNT0rQK?=
 =?us-ascii?Q?DzwdqBAI8keUkg9RTfrhU4nyk8l8XIwHxCmgN9wiXUn9oQRVR824MiOIXatp?=
 =?us-ascii?Q?3owT/fNRorvz82/ztGitOumfuX6VmZ2k1am/4wzbVGep5lkW4Q844fxYJ+jS?=
 =?us-ascii?Q?r4nGMWrQKN6vBzC862MGcmwY+Vcy0p277zXxbe7CnSYW5k3cCTaqWVOQSoEn?=
 =?us-ascii?Q?yPB7Q1XKTQ1FLsYUFpLKIEpseIhuDgkhPVl6GbPIVzuBJP2YGx1cpGiwcw8a?=
 =?us-ascii?Q?LG+PePkvOuoFPlbVSmZek/jRhEHXQDPpGB6AwXoeY4O7e9yP5hygw9bzHXgP?=
 =?us-ascii?Q?vcB5V5jU8AuBN6jeixpEnhQv5K6giIq1eZuCZ74+b1G/fQlEBsyAlLX8w29z?=
 =?us-ascii?Q?wewk40dI6AM1EwykgJHmDlZkxB3ev5NzAc35qYNkHMB2+8AkfN0/mG2lX0pe?=
 =?us-ascii?Q?gbY1fYkZmDyVux+kzCIJ1lmsXEa7KSZ6GHF2Dc3nfEhNdBrcDYgOnOJa4K9Q?=
 =?us-ascii?Q?/el2l6CFAAjT3apodHTWaX4x2dSCMWnNVl8TWJHOMZYAyh8h0xQ90W5miROT?=
 =?us-ascii?Q?ld3/7x29syiKh3qCIcCZvPaYGY/4LV3ko5AXe2MtxHT8V2XnDzm8Zay8mw1O?=
 =?us-ascii?Q?JR5alIs+jjf6939eakJE1Zs5cvv24aFBvy3jtUxm7nyv7B1jPTjHGJT4d5iq?=
 =?us-ascii?Q?Mea5xOjDE5OMXd4NPKt50b88aA7+6CLO5hWkzNbt1lPasjJWcsidvu602tWV?=
 =?us-ascii?Q?dDy43reefSwJY1QuR6hgdvVIoUTZEDAY0+T+5YzSWYWTCWvQuuEjj4C3sBX1?=
 =?us-ascii?Q?4kFKIr0hOpzi4z6cvL5SS9hd5WtSVbHP+3qD0MCCEi3hmbpU9s34PqEPES5i?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3663f0ce-2d74-4aa5-1905-08dba30b5462
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 12:28:46.0729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYXr0GHckFIByRHgozcYyg0EbKQEm3IZiBf3C7pFtBsXgwtl5OIeBvoQcUPMFF3/PrCzhKarSz/7dZZXn6qmu8FexcuHWY44uPn5+fKAIGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5608
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 02:43:38PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Declare the test names statically in a struct so that we can refer to
> them when adding the support to execute a single test in the next
> commit. Before this pathc, the names of them was not declared in a

s/was/were

pathc was caught by Przemek

> single place which made it not possible to refer to them.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 191 +++++++----------------
>  tools/testing/selftests/bpf/xskxceiver.h |  37 +----
>  2 files changed, 57 insertions(+), 171 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index ee72bb0a8978..b1d0c69f21b8 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -447,7 +447,8 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
>  }
>  
>  static void test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
> -			   struct ifobject *ifobj_rx, enum test_mode mode)
> +			   struct ifobject *ifobj_rx, enum test_mode mode,
> +			   const struct test_spec *test_to_run)
>  {
>  	struct pkt_stream *tx_pkt_stream;
>  	struct pkt_stream *rx_pkt_stream;
> @@ -469,6 +470,8 @@ static void test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
>  			ifobj->bind_flags |= XDP_COPY;
>  	}
>  
> +	strncpy(test->name, test_to_run->name, MAX_TEST_NAME_SIZE);
> +	test->test_func = test_to_run->test_func;
>  	test->mode = mode;
>  	__test_spec_init(test, ifobj_tx, ifobj_rx);
>  }
> @@ -478,11 +481,6 @@ static void test_spec_reset(struct test_spec *test)
>  	__test_spec_init(test, test->ifobj_tx, test->ifobj_rx);
>  }
>  
> -static void test_spec_set_name(struct test_spec *test, const char *name)
> -{
> -	strncpy(test->name, name, MAX_TEST_NAME_SIZE);
> -}
> -
>  static void test_spec_set_xdp_prog(struct test_spec *test, struct bpf_program *xdp_prog_rx,
>  				   struct bpf_program *xdp_prog_tx, struct bpf_map *xskmap_rx,
>  				   struct bpf_map *xskmap_tx)
> @@ -1727,7 +1725,6 @@ static int testapp_teardown(struct test_spec *test)
>  {
>  	int i;
>  
> -	test_spec_set_name(test, "TEARDOWN");
>  	for (i = 0; i < MAX_TEARDOWN_ITER; i++) {
>  		if (testapp_validate_traffic(test))
>  			return TEST_FAILURE;
> @@ -1749,11 +1746,10 @@ static void swap_directions(struct ifobject **ifobj1, struct ifobject **ifobj2)
>  	*ifobj2 = tmp_ifobj;
>  }
>  
> -static int testapp_bidi(struct test_spec *test)
> +static int testapp_bidirectional(struct test_spec *test)
>  {
>  	int res;
>  
> -	test_spec_set_name(test, "BIDIRECTIONAL");
>  	test->ifobj_tx->rx_on = true;
>  	test->ifobj_rx->tx_on = true;
>  	test->total_steps = 2;
> @@ -1782,9 +1778,8 @@ static void swap_xsk_resources(struct ifobject *ifobj_tx, struct ifobject *ifobj
>  		exit_with_error(errno);
>  }
>  
> -static int testapp_bpf_res(struct test_spec *test)
> +static int testapp_xdp_prog_cleanup(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "BPF_RES");
>  	test->total_steps = 2;
>  	test->nb_sockets = 2;
>  	if (testapp_validate_traffic(test))
> @@ -1796,14 +1791,12 @@ static int testapp_bpf_res(struct test_spec *test)
>  
>  static int testapp_headroom(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "UMEM_HEADROOM");
>  	test->ifobj_rx->umem->frame_headroom = UMEM_HEADROOM_TEST_SIZE;
>  	return testapp_validate_traffic(test);
>  }
>  
>  static int testapp_stats_rx_dropped(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "STAT_RX_DROPPED");
>  	if (test->mode == TEST_MODE_ZC) {
>  		ksft_test_result_skip("Can not run RX_DROPPED test for ZC mode\n");
>  		return TEST_SKIP;
> @@ -1819,7 +1812,6 @@ static int testapp_stats_rx_dropped(struct test_spec *test)
>  
>  static int testapp_stats_tx_invalid_descs(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "STAT_TX_INVALID");
>  	pkt_stream_replace_half(test, XSK_UMEM__INVALID_FRAME_SIZE, 0);
>  	test->ifobj_tx->validation_func = validate_tx_invalid_descs;
>  	return testapp_validate_traffic(test);
> @@ -1827,7 +1819,6 @@ static int testapp_stats_tx_invalid_descs(struct test_spec *test)
>  
>  static int testapp_stats_rx_full(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "STAT_RX_FULL");
>  	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
>  	test->ifobj_rx->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
>  							 DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> @@ -1840,7 +1831,6 @@ static int testapp_stats_rx_full(struct test_spec *test)
>  
>  static int testapp_stats_fill_empty(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "STAT_RX_FILL_EMPTY");
>  	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
>  	test->ifobj_rx->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
>  							 DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> @@ -1850,9 +1840,8 @@ static int testapp_stats_fill_empty(struct test_spec *test)
>  	return testapp_validate_traffic(test);
>  }
>  
> -static int testapp_unaligned(struct test_spec *test)
> +static int testapp_send_receive_unaligned(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "UNALIGNED_MODE");
>  	test->ifobj_tx->umem->unaligned_mode = true;
>  	test->ifobj_rx->umem->unaligned_mode = true;
>  	/* Let half of the packets straddle a 4K buffer boundary */
> @@ -1861,9 +1850,8 @@ static int testapp_unaligned(struct test_spec *test)
>  	return testapp_validate_traffic(test);
>  }
>  
> -static int testapp_unaligned_mb(struct test_spec *test)
> +static int testapp_send_receive_unaligned_mb(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "UNALIGNED_MODE_9K");
>  	test->mtu = MAX_ETH_JUMBO_SIZE;
>  	test->ifobj_tx->umem->unaligned_mode = true;
>  	test->ifobj_rx->umem->unaligned_mode = true;
> @@ -1875,14 +1863,12 @@ static int testapp_single_pkt(struct test_spec *test)
>  {
>  	struct pkt pkts[] = {{0, MIN_PKT_SIZE, 0, true}};
>  
> -	test_spec_set_name(test, "SEND_RECEIVE_SINGLE_PKT");
>  	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
>  	return testapp_validate_traffic(test);
>  }
>  
> -static int testapp_multi_buffer(struct test_spec *test)
> +static int testapp_send_receive_mb(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "SEND_RECEIVE_9K_PACKETS");
>  	test->mtu = MAX_ETH_JUMBO_SIZE;
>  	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
>  
> @@ -1979,7 +1965,6 @@ static int testapp_xdp_drop(struct test_spec *test)
>  	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
>  	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
>  
> -	test_spec_set_name(test, "XDP_DROP_HALF");
>  	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_drop, skel_tx->progs.xsk_xdp_drop,
>  			       skel_rx->maps.xsk, skel_tx->maps.xsk);
>  
> @@ -2012,8 +1997,6 @@ static int testapp_xdp_metadata_copy(struct test_spec *test)
>  
>  static int testapp_poll_txq_tmout(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "POLL_TXQ_FULL");
> -
>  	test->ifobj_tx->use_poll = true;
>  	/* create invalid frame by set umem frame_size and pkt length equal to 2048 */
>  	test->ifobj_tx->umem->frame_size = 2048;
> @@ -2023,7 +2006,6 @@ static int testapp_poll_txq_tmout(struct test_spec *test)
>  
>  static int testapp_poll_rxq_tmout(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "POLL_RXQ_EMPTY");
>  	test->ifobj_rx->use_poll = true;
>  	return testapp_validate_traffic_single_thread(test, test->ifobj_rx);
>  }
> @@ -2033,7 +2015,6 @@ static int testapp_too_many_frags(struct test_spec *test)
>  	struct pkt pkts[2 * XSK_DESC__MAX_SKB_FRAGS + 2] = {};
>  	u32 max_frags, i;
>  
> -	test_spec_set_name(test, "TOO_MANY_FRAGS");
>  	if (test->mode == TEST_MODE_ZC)
>  		max_frags = test->ifobj_tx->xdp_zc_max_segs;
>  	else
> @@ -2139,13 +2120,11 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
>  
>  static int testapp_send_receive(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "SEND_RECEIVE");
>  	return testapp_validate_traffic(test);
>  }
>  
>  static int testapp_send_receive_2k_frame(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "SEND_RECEIVE_2K_FRAME_SIZE");
>  	test->ifobj_tx->umem->frame_size = 2048;
>  	test->ifobj_rx->umem->frame_size = 2048;
>  	pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> @@ -2155,26 +2134,22 @@ static int testapp_send_receive_2k_frame(struct test_spec *test)
>  static int testapp_poll_rx(struct test_spec *test)
>  {
>  	test->ifobj_rx->use_poll = true;
> -	test_spec_set_name(test, "POLL_RX");
>  	return testapp_validate_traffic(test);
>  }
>  
>  static int testapp_poll_tx(struct test_spec *test)
>  {
>  	test->ifobj_tx->use_poll = true;
> -	test_spec_set_name(test, "POLL_TX");
>  	return testapp_validate_traffic(test);
>  }
>  
>  static int testapp_aligned_inv_desc(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "ALIGNED_INV_DESC");
>  	return testapp_invalid_desc(test);
>  }
>  
>  static int testapp_aligned_inv_desc_2k_frame(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "ALIGNED_INV_DESC_2K_FRAME_SIZE");
>  	test->ifobj_tx->umem->frame_size = 2048;
>  	test->ifobj_rx->umem->frame_size = 2048;
>  	return testapp_invalid_desc(test);
> @@ -2182,7 +2157,6 @@ static int testapp_aligned_inv_desc_2k_frame(struct test_spec *test)
>  
>  static int testapp_unaligned_inv_desc(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "UNALIGNED_INV_DESC");
>  	test->ifobj_tx->umem->unaligned_mode = true;
>  	test->ifobj_rx->umem->unaligned_mode = true;
>  	return testapp_invalid_desc(test);
> @@ -2192,7 +2166,6 @@ static int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
>  {
>  	u64 page_size, umem_size;
>  
> -	test_spec_set_name(test, "UNALIGNED_INV_DESC_4K1_FRAME_SIZE");
>  	/* Odd frame size so the UMEM doesn't end near a page boundary. */
>  	test->ifobj_tx->umem->frame_size = 4001;
>  	test->ifobj_rx->umem->frame_size = 4001;
> @@ -2211,13 +2184,11 @@ static int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
>  
>  static int testapp_aligned_inv_desc_mb(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "ALIGNED_INV_DESC_MULTI_BUFF");
>  	return testapp_invalid_desc_mb(test);
>  }
>  
>  static int testapp_unaligned_inv_desc_mb(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "UNALIGNED_INV_DESC_MULTI_BUFF");
>  	test->ifobj_tx->umem->unaligned_mode = true;
>  	test->ifobj_rx->umem->unaligned_mode = true;
>  	return testapp_invalid_desc_mb(test);
> @@ -2225,109 +2196,20 @@ static int testapp_unaligned_inv_desc_mb(struct test_spec *test)
>  
>  static int testapp_xdp_metadata(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "XDP_METADATA_COPY");
>  	return testapp_xdp_metadata_copy(test);
>  }
>  
>  static int testapp_xdp_metadata_mb(struct test_spec *test)
>  {
> -	test_spec_set_name(test, "XDP_METADATA_COPY_MULTI_BUFF");
>  	test->mtu = MAX_ETH_JUMBO_SIZE;
>  	return testapp_xdp_metadata_copy(test);
>  }
>  
> -static void run_pkt_test(struct test_spec *test, enum test_mode mode, enum test_type type)
> -{
> -	int ret = TEST_SKIP;
> -
> -	switch (type) {
> -	case TEST_TYPE_STATS_RX_DROPPED:
> -		ret = testapp_stats_rx_dropped(test);
> -		break;
> -	case TEST_TYPE_STATS_TX_INVALID_DESCS:
> -		ret = testapp_stats_tx_invalid_descs(test);
> -		break;
> -	case TEST_TYPE_STATS_RX_FULL:
> -		ret = testapp_stats_rx_full(test);
> -		break;
> -	case TEST_TYPE_STATS_FILL_EMPTY:
> -		ret = testapp_stats_fill_empty(test);
> -		break;
> -	case TEST_TYPE_TEARDOWN:
> -		ret = testapp_teardown(test);
> -		break;
> -	case TEST_TYPE_BIDI:
> -		ret = testapp_bidi(test);
> -		break;
> -	case TEST_TYPE_BPF_RES:
> -		ret = testapp_bpf_res(test);
> -		break;
> -	case TEST_TYPE_RUN_TO_COMPLETION:
> -		ret = testapp_send_receive(test);
> -		break;
> -	case TEST_TYPE_RUN_TO_COMPLETION_MB:
> -		ret = testapp_multi_buffer(test);
> -		break;
> -	case TEST_TYPE_RUN_TO_COMPLETION_SINGLE_PKT:
> -		ret = testapp_single_pkt(test);
> -		break;
> -	case TEST_TYPE_RUN_TO_COMPLETION_2K_FRAME:
> -		ret = testapp_send_receive_2k_frame(test);
> -		break;
> -	case TEST_TYPE_RX_POLL:
> -		ret = testapp_poll_rx(test);
> -		break;
> -	case TEST_TYPE_TX_POLL:
> -		ret = testapp_poll_tx(test);
> -		break;
> -	case TEST_TYPE_POLL_TXQ_TMOUT:
> -		ret = testapp_poll_txq_tmout(test);
> -		break;
> -	case TEST_TYPE_POLL_RXQ_TMOUT:
> -		ret = testapp_poll_rxq_tmout(test);
> -		break;
> -	case TEST_TYPE_ALIGNED_INV_DESC:
> -		ret = testapp_aligned_inv_desc(test);
> -		break;
> -	case TEST_TYPE_ALIGNED_INV_DESC_2K_FRAME:
> -		ret = testapp_aligned_inv_desc_2k_frame(test);
> -		break;
> -	case TEST_TYPE_UNALIGNED_INV_DESC:
> -		ret = testapp_unaligned_inv_desc(test);
> -		break;
> -	case TEST_TYPE_UNALIGNED_INV_DESC_4K1_FRAME:
> -		ret = testapp_unaligned_inv_desc_4001_frame(test);
> -		break;
> -	case TEST_TYPE_ALIGNED_INV_DESC_MB:
> -		ret = testapp_aligned_inv_desc_mb(test);
> -		break;
> -	case TEST_TYPE_UNALIGNED_INV_DESC_MB:
> -		ret = testapp_unaligned_inv_desc_mb(test);
> -		break;
> -	case TEST_TYPE_UNALIGNED:
> -		ret = testapp_unaligned(test);
> -		break;
> -	case TEST_TYPE_UNALIGNED_MB:
> -		ret = testapp_unaligned_mb(test);
> -		break;
> -	case TEST_TYPE_HEADROOM:
> -		ret = testapp_headroom(test);
> -		break;
> -	case TEST_TYPE_XDP_DROP_HALF:
> -		ret = testapp_xdp_drop(test);
> -		break;
> -	case TEST_TYPE_XDP_METADATA_COUNT:
> -		ret = testapp_xdp_metadata(test);
> -		break;
> -	case TEST_TYPE_XDP_METADATA_COUNT_MB:
> -		ret = testapp_xdp_metadata_mb(test);
> -		break;
> -	case TEST_TYPE_TOO_MANY_FRAGS:
> -		ret = testapp_too_many_frags(test);
> -		break;
> -	default:
> -		break;
> -	}
> +static void run_pkt_test(struct test_spec *test)
> +{
> +	int ret;
> +
> +	ret = test->test_func(test);
>  
>  	if (ret == TEST_PASS)
>  		ksft_test_result_pass("PASS: %s %s%s\n", mode_string(test), busy_poll_string(test),
> @@ -2395,6 +2277,39 @@ static bool is_xdp_supported(int ifindex)
>  	return true;
>  }
>  
> +static const struct test_spec tests[] = {
> +	{.name = "SEND_RECEIVE", .test_func = testapp_send_receive},
> +	{.name = "SEND_RECEIVE_2K_FRAME", .test_func = testapp_send_receive_2k_frame},
> +	{.name = "SEND_RECEIVE_SINGLE_PKT", .test_func = testapp_single_pkt},
> +	{.name = "POLL_RX", .test_func = testapp_poll_rx},
> +	{.name = "POLL_TX", .test_func = testapp_poll_tx},
> +	{.name = "POLL_RXQ_FULL", .test_func = testapp_poll_rxq_tmout},
> +	{.name = "POLL_TXQ_FULL", .test_func = testapp_poll_txq_tmout},
> +	{.name = "SEND_RECEIVE_UNALIGNED", .test_func = testapp_send_receive_unaligned},
> +	{.name = "ALIGNED_INV_DESC", .test_func = testapp_aligned_inv_desc},
> +	{.name = "ALIGNED_INV_DESC_2K_FRAME_SIZE", .test_func = testapp_aligned_inv_desc_2k_frame},
> +	{.name = "UNALIGNED_INV_DESC", .test_func = testapp_unaligned_inv_desc},
> +	{.name = "UNALIGNED_INV_DESC_4001_FRAME_SIZE",
> +	 .test_func = testapp_unaligned_inv_desc_4001_frame},
> +	{.name = "UMEM_HEADROOM", .test_func = testapp_headroom},
> +	{.name = "TEARDOWN", .test_func = testapp_teardown},
> +	{.name = "BIDIRECTIONAL", .test_func = testapp_bidirectional},
> +	{.name = "STAT_RX_DROPPED", .test_func = testapp_stats_rx_dropped},
> +	{.name = "STAT_TX_INVALID", .test_func = testapp_stats_tx_invalid_descs},
> +	{.name = "STAT_RX_FULL", .test_func = testapp_stats_rx_full},
> +	{.name = "STAT_FILL_EMPTY", .test_func = testapp_stats_fill_empty},
> +	{.name = "XDP_PROG_CLEANUP", .test_func = testapp_xdp_prog_cleanup},
> +	{.name = "XDP_DROP_HALF", .test_func = testapp_xdp_drop},
> +	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
> +	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
> +	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
> +	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
> +	 .test_func = testapp_send_receive_unaligned_mb},
> +	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
> +	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
> +	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
> +};

can you move this to a header file? looks weird to have these declarations
in the middle of the file.

> +
>  int main(int argc, char **argv)
>  {
>  	struct pkt_stream *rx_pkt_stream_default;
> @@ -2437,7 +2352,7 @@ int main(int argc, char **argv)
>  	init_iface(ifobj_rx, MAC1, MAC2, worker_testapp_validate_rx);
>  	init_iface(ifobj_tx, MAC2, MAC1, worker_testapp_validate_tx);
>  
> -	test_spec_init(&test, ifobj_tx, ifobj_rx, 0);
> +	test_spec_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
>  	tx_pkt_stream_default = pkt_stream_generate(ifobj_tx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
>  	rx_pkt_stream_default = pkt_stream_generate(ifobj_rx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
>  	if (!tx_pkt_stream_default || !rx_pkt_stream_default)
> @@ -2446,17 +2361,17 @@ int main(int argc, char **argv)
>  	test.rx_pkt_stream_default = rx_pkt_stream_default;
>  
>  	if (opt_mode == TEST_MODE_ALL)
> -		ksft_set_plan(modes * TEST_TYPE_MAX);
> +		ksft_set_plan(modes * ARRAY_SIZE(tests));
>  	else
> -		ksft_set_plan(TEST_TYPE_MAX);
> +		ksft_set_plan(ARRAY_SIZE(tests));
>  
>  	for (i = 0; i < modes; i++) {
>  		if (opt_mode != TEST_MODE_ALL && i != opt_mode)
>  			continue;
>  
> -		for (j = 0; j < TEST_TYPE_MAX; j++) {
> -			test_spec_init(&test, ifobj_tx, ifobj_rx, i);
> -			run_pkt_test(&test, i, j);
> +		for (j = 0; j < ARRAY_SIZE(tests); j++) {
> +			test_spec_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
> +			run_pkt_test(&test);
>  			usleep(USLEEP_MAX);
>  
>  			if (test.fail)
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index 1412492e9618..3a71d490db3e 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -34,7 +34,7 @@
>  #define MAX_INTERFACES 2
>  #define MAX_INTERFACE_NAME_CHARS 16
>  #define MAX_SOCKETS 2
> -#define MAX_TEST_NAME_SIZE 32
> +#define MAX_TEST_NAME_SIZE 48
>  #define MAX_TEARDOWN_ITER 10
>  #define PKT_HDR_SIZE (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */
>  #define MIN_PKT_SIZE 64
> @@ -66,38 +66,6 @@ enum test_mode {
>  	TEST_MODE_ALL
>  };
>  
> -enum test_type {
> -	TEST_TYPE_RUN_TO_COMPLETION,
> -	TEST_TYPE_RUN_TO_COMPLETION_2K_FRAME,
> -	TEST_TYPE_RUN_TO_COMPLETION_SINGLE_PKT,
> -	TEST_TYPE_RX_POLL,
> -	TEST_TYPE_TX_POLL,
> -	TEST_TYPE_POLL_RXQ_TMOUT,
> -	TEST_TYPE_POLL_TXQ_TMOUT,
> -	TEST_TYPE_UNALIGNED,
> -	TEST_TYPE_ALIGNED_INV_DESC,
> -	TEST_TYPE_ALIGNED_INV_DESC_2K_FRAME,
> -	TEST_TYPE_UNALIGNED_INV_DESC,
> -	TEST_TYPE_UNALIGNED_INV_DESC_4K1_FRAME,
> -	TEST_TYPE_HEADROOM,
> -	TEST_TYPE_TEARDOWN,
> -	TEST_TYPE_BIDI,
> -	TEST_TYPE_STATS_RX_DROPPED,
> -	TEST_TYPE_STATS_TX_INVALID_DESCS,
> -	TEST_TYPE_STATS_RX_FULL,
> -	TEST_TYPE_STATS_FILL_EMPTY,
> -	TEST_TYPE_BPF_RES,
> -	TEST_TYPE_XDP_DROP_HALF,
> -	TEST_TYPE_XDP_METADATA_COUNT,
> -	TEST_TYPE_XDP_METADATA_COUNT_MB,
> -	TEST_TYPE_RUN_TO_COMPLETION_MB,
> -	TEST_TYPE_UNALIGNED_MB,
> -	TEST_TYPE_ALIGNED_INV_DESC_MB,
> -	TEST_TYPE_UNALIGNED_INV_DESC_MB,
> -	TEST_TYPE_TOO_MANY_FRAGS,
> -	TEST_TYPE_MAX
> -};
> -
>  struct xsk_umem_info {
>  	struct xsk_ring_prod fq;
>  	struct xsk_ring_cons cq;
> @@ -137,8 +105,10 @@ struct pkt_stream {
>  };
>  
>  struct ifobject;
> +struct test_spec;
>  typedef int (*validation_func_t)(struct ifobject *ifobj);
>  typedef void *(*thread_func_t)(void *arg);
> +typedef int (*test_func_t)(struct test_spec *test);
>  
>  struct ifobject {
>  	char ifname[MAX_INTERFACE_NAME_CHARS];
> @@ -180,6 +150,7 @@ struct test_spec {
>  	struct bpf_program *xdp_prog_tx;
>  	struct bpf_map *xskmap_rx;
>  	struct bpf_map *xskmap_tx;
> +	test_func_t test_func;
>  	int mtu;
>  	u16 total_steps;
>  	u16 current_step;
> -- 
> 2.34.1
> 

