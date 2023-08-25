Return-Path: <bpf+bounces-8566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37EE788698
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B656C1C20FB3
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 12:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7ECD303;
	Fri, 25 Aug 2023 12:07:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C4CA4E;
	Fri, 25 Aug 2023 12:07:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E82105;
	Fri, 25 Aug 2023 05:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692965225; x=1724501225;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IUakM02bKxvdtafbvm+rNqU7NgswoKIdF/bWD/glQbI=;
  b=G/rcsTFLoS2Pqeq+Piz0TwLBrs+7Hpo9l+t1mlSTih9Yf0S3faAP1017
   T2TdOiJmdPahrXl6tW4p5x1flyIihf3H6wevBX35H/vfnCgnpILpBLXPR
   gSqfSNoEUSY7EauvjarrANcQgXHTxK3+ejDzOYz6I8yMzQ0EQkNnsEsNo
   a2AqlKXJ3rEsWdAo3YH3mm47e7xrheg7EMqpd1lq6ct826QJuCOloycj4
   TGwtOo3HbhqDr8WpQIgV+dDHNK77GbnxjEI4lzGtttwNHCLjDkw3U3L6g
   rvTH3+XOOrwK6/9iiaf/nDozjs+5FpdrpYCTqWFQ+3zbqpu3eBEqy3Pbx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="405699132"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="405699132"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 05:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="827573441"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827573441"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Aug 2023 05:07:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 05:07:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 05:07:03 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 05:07:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaDKd8DtgYKn92A7OPVNQvooIR9qXYqDX09HOFdz8nhkUdeHvOMA2gVys7QqEYtySPsymK2gDMQwBZujzW0Rk9/2VaW9AL9qqjtpm8p/62w/UBHVCfKNN/jEcDMg/6t9icsoRleoBNoMPv9dkXbGeD5zVa3G7TdILI/fvlQoxgvw35mgokcfpfWsSxHhr6zD++9k3wmkycEMMSwdx+AdxiBlgKMvpSz3BLByPh+H+osDqdklhI3ySQcJiVLijeNehqLo94O87sY33VHwqMyVPSvhOV63e0/XeYLcxtxH32WXRNLQKLkjdJ6TFtS4nhWY/V9o2Ir32zHpaX/5GukEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tOScq2TfKjh7kj2hhzrwbfIuDN6pHcPJB96g1J5SLY=;
 b=GHrPojj7L3WRggo0dz4aL6vNfSRjAQMAf8lgLPBTxlnBftIXCFxkXFvt1UVg72E3lk+P8cwYZtzPznBJ6v8ueSmiJP7fXI6VYNzlbN8iAgbITA3W44w/DGUO0DGScdZ8lAXfHqH534O5dYJ199ObWq6fK5IcLTN/dD9fWheznYqzMYPNIPv9CLfJijxX3zOXQjy7Ro+wbflVVyWWJwguc1OoejZovRGtu+Gu7AmGEw57CjkhiZbPz7/5G91t7gl3GtqWF06ArmGOOocZ2a6vGQXoMqKC0I3YPcRE17Ar7QQr+Rff4t1GgJJYOha/g63eJpl9u5gtfxXcWByYol/oLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ2PR11MB7647.namprd11.prod.outlook.com (2603:10b6:a03:4c3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Fri, 25 Aug 2023 12:07:01 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 12:07:01 +0000
Date: Fri, 25 Aug 2023 14:06:52 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v2 05/11] selftests/xsk: declare test names in
 struct
Message-ID: <ZOiZXIHo1rOt+tNS@boxer>
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-6-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824122853.3494-6-magnus.karlsson@gmail.com>
X-ClientProxiedBy: DBBPR09CA0004.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ2PR11MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: b95619a1-0eb8-4eb7-0743-08dba563c9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcIymqiaP8cKpP1EpQ4gQ+KLtIUfVvaumYzLkPPy1Tm7aYORfvAWulSQGbvKTBnnfFMH9HZ1wPxCO0xY2Ykanr7DWaVrYodutGFl+8OB7JPkB+Iz/q879a9zlbxniE8+HpTrOqSkpU7TQZ3yacbfMpAma+w+2r+JamAiQDWfTYvDcRSIJHl900cZLStlVd5sdyd/uicD559bwV+OPKgbt6eIARN2ESm6W6v2z7oGxJN7LMaEfk8ClSrmsc3Rr48EXZPzVXTcpfx8ZBzsaDcZjEWm66i/ctHMEyv3ZV+4RnO98sx6768CReYLCWPIuCK1j4G7X6P+NUqu1k8IWBqopmUfKpkOG7sfQXA1s+ITxEuOumLsqwOZMGBZRNQmvo9SbSeScaf6QKcgxD6sCzpdKjfAV3rmtqp0e+39IyqYl4hNOTMbyF0w1reRNBesa+g5gFlL/JaQ5GRzgipwEPg5Pl+LhAlq8WDI1nfeP+IGFl+YQapjdzA2KZtdF4WEWJ/n39D55T/Wh/1+FQ2ky0s2SyBzI019WZzLCZQ44haddrSq1CLaSHxndmgZHZS/KpZ3DRtRbqSqwroiM0UG7ZNPNQ81JuTEG5FrTu7ctrxt8YM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(366004)(136003)(346002)(1800799009)(186009)(451199024)(107886003)(5660300002)(8676002)(4326008)(8936002)(83380400001)(7416002)(44832011)(26005)(6666004)(38100700002)(82960400001)(66476007)(66556008)(33716001)(66946007)(6916009)(316002)(478600001)(41300700001)(6512007)(9686003)(2906002)(6506007)(86362001)(6486002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zZNRerxQ4vMT++lHq5PBnWR9vvbj8Ieo1GK/ut+/pRpQdBxBq/FyqHipNuGR?=
 =?us-ascii?Q?d6THgd3mpEZpd9jqWbq1DE6+hFPw/ytOVmTw5R7NBsKn7b7j1JzBmITczTE3?=
 =?us-ascii?Q?7BP+sST7pb8qao6E2o7DBcxUFmCdu+S8ea10mO3y5r+mtcEA0gSrnoRgsTQ4?=
 =?us-ascii?Q?UTqAJ5LxymCmV5xgdbeRDTH3V9++cpJbL6+JqLNea1Gen6R6bO+ulxgAhBOH?=
 =?us-ascii?Q?Yu7DirlS+uCv7aGA4ckMw5C6BHktDeGh2Dr53c/wWOGA7TcMZ4LwlQXXWsPe?=
 =?us-ascii?Q?+zZggFvVUjdskwC9lIhKT16uARO/P0FMtCUF42AOVXaZovHykM9p4gNGGyFF?=
 =?us-ascii?Q?CJEctLoV2mKguQbTHNfd2YFV+9rZu3wLJFbLrLNRfXnFunf6+ErG7aif3135?=
 =?us-ascii?Q?2PrI8Q/bAccU2lTai8SDMScvHKWJRIhC9dEy3mgLiP7PIrmyJ3xf3NfKaVQl?=
 =?us-ascii?Q?18LU6nrJEb4c54ZVxZxRZ3XA74hyFwbg/+5KRaoPBB7kCPN0tn483dCFebhw?=
 =?us-ascii?Q?EV5zFjkt7BsV1IlBvPvTH+YM2nPpG62GVL46anV/tgZcMcAI4Hk+REJAbXgQ?=
 =?us-ascii?Q?w/SyKZ3M1sQ65LsuK8e/PUSY/mC+zsxFEn7gktII4JYlwURIudf64vyykUnr?=
 =?us-ascii?Q?/TMl9bZQihLglzBm78NDEAMcUX1bs6fQPdz8gc9yeIzpBn/hA/yKthKXo0d/?=
 =?us-ascii?Q?6/D1lRuisZFBXPAuOEhOVH+6FzKj4ROCvADrbeB0Ge1AXtuI96WjsDuIbSAW?=
 =?us-ascii?Q?/RwLoN7YSF+XPScdGtYRtKKVTTYJxOSYcAIVTwuC8JRfEpxylMYw1xAJ/IXv?=
 =?us-ascii?Q?EiiTJl8I+vpVgNQElIfbNmOiH3eLPnEinZ3qWjkOIMVQm5WO3QhhXclu9nDw?=
 =?us-ascii?Q?0LeyRFLbr8K75CQ9zLqdUkgrKjSKbE8v7XthDX/602K4AkkUBPWQmzwur1+Y?=
 =?us-ascii?Q?rldY6SfritBg1rEEUQQGAqT7I09gSczCjV6i0vlK7mUV63hAC9vHMEHNbXci?=
 =?us-ascii?Q?37JCDG7JerWJjQV8nNx+JIieGAnFUpVGvbxaulXbbTX53HIgaCgQ6ZZWxpMR?=
 =?us-ascii?Q?sC94+ajaRKISa6+3haFP+lBeBDxaDf57nT+ZM08AkYc4VxHAedoPJwn7QffN?=
 =?us-ascii?Q?mEC1yO6atnYyhD0J702g3ZsWW1vJvAQi+DvF5oAzorQqn3IuTwLeBoxPvlYY?=
 =?us-ascii?Q?XjI1OZBobH1/zR8LSZZcwMHLeluHI8JTQ8yL1O15eZO1m9Gnl77PUUhQgJvQ?=
 =?us-ascii?Q?gP+3D7DykhU8HGkj4ciwtSi0zF+dxAlkpYimHKr6rl4TC5bInu8wB2DeqkNA?=
 =?us-ascii?Q?X3Mgm8iyUSO6v5GyjKUproKXaA6BxxSRRX/qFySyPlcZDBIbWsofPpHWJHqN?=
 =?us-ascii?Q?1VhCZvIShjk+w2c3T0gfvSyR4aMwKpNOtgphXFkvRWFYs8bPsfQaXAdIe27L?=
 =?us-ascii?Q?jBFOt+4rlCTfbRtZ9ofFHn/ePNzf4j50NIfh3kgZ6q5fUzhBuu6a2XSK4OUm?=
 =?us-ascii?Q?FWDOZ99x88muTtnEmUfkmWWqfb0+NQJTFTP/5k+7y4L1sa9Nm6aTmUQHWUbe?=
 =?us-ascii?Q?F58bQ8ix5WL5jpVtULWUKYmq47Vd/SfODAIzYZ/ncKwNbeQN7jQcgzmEiiHs?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b95619a1-0eb8-4eb7-0743-08dba563c9fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 12:07:01.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WX2t7HuBv+3R9JK3EPJDBO1PELKPORkLGScUQe3GoUXW7ew/n4l0EuMvbQGdi4A1CZtESN369iNDbJOWbxa57j9V6XQEojBxH/XwpY+nwxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7647
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 02:28:47PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Declare the test names statically in a struct so that we can refer to
> them when adding the support to execute a single test in the next
> commit. Before this patch, the names of them were not declared in a
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

(...)

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

To others, I was asking on v1 to move this to a header file but i missed
somehow that we also set .test_func here so this would require us to
un-static each and every function which would in turn cause the diffstat
to grow significantly. IOW let us address that later.

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

