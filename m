Return-Path: <bpf+bounces-11373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10047B808E
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B1DC4281941
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 13:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EC414284;
	Wed,  4 Oct 2023 13:16:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33913FFD;
	Wed,  4 Oct 2023 13:16:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FBAA9;
	Wed,  4 Oct 2023 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696425392; x=1727961392;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=fLeckvmJWcfVmpFYkzAGtU2x2tESFu5IcJQ8KPKVft0=;
  b=BeX3B8qPLRGTBNdU15DN2+S90lYKEDcwJgDSWfLVaeMEbpAlXwDbblon
   Xmd3An95++DN/qH/mf2I5OICwPvnvA9YafVUHqmIuqVLtS7BPuETF1b4f
   f8NBD4xkRnmKMup4YnkoqSmlP93yn1aaaWl55vIBgp+dVpKDwvo5SPl6S
   7pyhC7PnDLlvKMECNhPNr8YyAKEG/r2VfhDj/ZDqyaqjGyDykc+qQ7tpW
   4jU3QIClL1F67GzRDMmMe9RDzsKeBsy1t4k2yx0XNVD5l3iFOJw3EFsab
   SNxTJvMrgeG6nB8Qog764Fi3tpUMsss8zBvNZCpO+Pon0TxHexRdkOC6d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="387032799"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="387032799"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 06:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="727995544"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="727995544"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 06:16:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 06:16:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 06:16:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 06:16:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 06:16:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqD+b3MXQ/lG4DV7zWxcObjpwvloSGypzglG9lfTtR5HmgsyxrKYcSHxwJy64zK9fJ71brc1+Z17PQwvZ4YIiyJf7xkCPXhNdpJXHYCsiqsUlpPjZ5DaLvI2/Fu1+JXvpvH4N3AfPzhG2tpJ5D+4ktz9iKUBRjv97ccRMNUlQIdrp/f+TLxqioDf6O4Pdy1N0Sid19HLaaTB6NtDPHLzpYF/s0FKSW6iGuij+gn8AODK6zobj+0dvKO11fuGO4rnwC3N0RMw4eE1zUVNu7qkVirgfNXfIX/sZZuy0x7qEXGtsZLQPhUXtsK/GvB2O7MFaOL9mo1qGvgD2qIw+eDtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDIiFUFJQeP3buxG7FJXWSpcTXg8XnRjVaDByakUKxE=;
 b=YndT+OrU5CujJQt43wB8by9Jte7Huyh2jnyAMTy3nnbpcqWJLV1DtcVls//DbaNngVLfXubf9g1ZBgBLBPxCsFA6RwfdLkKD4/YRL3I1Cvmk0KsmOlZb1yjwm88xcXqOSYt55l7XKk7+MdwIZGk+TqQoZ8xOkrslQER6l5XHasI4dkMbPSoud4wk95p0s5Y8NxdXHIugR2yRua7EtsPMYKAEmBuiwoDaNam6zYGbanh8QeHIjZIam2+Deeg0KJ7xBmNxgTW1CGrW6lxW+BtrZOEf2F0QM/UdP0LrKxaK+uNvexqqKIYWcQ6LjN1jfi+sZI/n89jt+3AHqd5fS1DG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36; Wed, 4 Oct
 2023 13:16:27 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc%7]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 13:16:27 +0000
Date: Wed, 4 Oct 2023 15:16:20 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>
Subject: Re: [PATCH net] i40e: sync next_to_clean and next_to_process for
 programming status desc
Message-ID: <ZR1lpCB1FqqbdSEX@boxer>
References: <20231004083454.20143-1-tirthendu.sarkar@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004083454.20143-1-tirthendu.sarkar@intel.com>
X-ClientProxiedBy: DB3PR06CA0014.eurprd06.prod.outlook.com (2603:10a6:8:1::27)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 5268b403-ff73-4c53-1a81-08dbc4dc1d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTsPNZybq3d4BBTTvcFVXXNGWdXG2a34Km627L1PaBxs7+jBB/gm93KrWR51/DndvUIh3q70wXhshwizVeytWnjeLucBtpaEDQ+Ks4VNAEY7Qo4h6K/fyo9odf1G1AHgGrCA7cdzAbfrpYESIMOij7gk1FXwjDwqXUooxUUiNm84FH+n3+ySH8itWvVfAeynnYfHuDyqwZPMXeqlbsH2IJNn+3nATPn+orUhOBnSptkeCU6meg8c6C4w0k52vQOXSwoWtjxwVw4HmBnuoOYrN7yJvi/DQyCOMxDrZHY1khBQKMmOG6oNfO/yFE+IsEZLdsk/JnS2O2FgxK7s8vnaE+dXAViRwSqipQLMT7K2fKxSZ+pGZfT6QnJkSpzMH5DQXJiVVcs4nZxpPqL/odeAQSW+3Es7eInc/m+ByPIpWpygrlJXOlWlEnwqCbd6zy+OvnDriH4JJmK/xpVfHS232heDCy+0jqDXzgwdUnMm7bhX5LI9kSORBV6VzeDfJt/zITqblrcX5WDdDuIr4j8T3ryCMOTerJhMTlDgWftKyts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(107886003)(83380400001)(66574015)(26005)(82960400001)(33716001)(86362001)(38100700002)(6666004)(316002)(41300700001)(6862004)(4326008)(8676002)(8936002)(6486002)(966005)(44832011)(5660300002)(478600001)(66476007)(66556008)(66946007)(9686003)(6512007)(6506007)(6636002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TzB9qkiBOM3gCkNfA6rEuUWkeAUVBIZafTBKo+ZHNhJ0QnJgmGqkVl1oNz?=
 =?iso-8859-1?Q?Zenz6ug8ZBXlF5dbdiyCDYpHk9piws2o/YNpr+wkehmISRl6aDB5cx4Pk+?=
 =?iso-8859-1?Q?e3+F6SpGTtazTaDpusgn3MQ7FaH/zRqK/lg4FTf0mCskSLvYOky3zVK2Jq?=
 =?iso-8859-1?Q?m7kyLiBFTvQPEsxpNg5ZZ6DSY8Mhm75hisILmrAjUcv0ucC0mX6Wd8k5GC?=
 =?iso-8859-1?Q?g7nkm2eQu+HG7lG7sLxi8bHqaV+QEo4vZx0/SvaaCFCQHVo3XEHjxRBgQs?=
 =?iso-8859-1?Q?MW0OIVTpny2ejyY7lsHaMvAD2TYmcpoorXw4n/ua7FhV8eKq1yhCocEiJw?=
 =?iso-8859-1?Q?FEhH0CPm6r0pEe/avMMN5CzTa2DGkkmuK0ezPWOneluk502wwmrUYBcnHN?=
 =?iso-8859-1?Q?u1tyQNAwQCwn9x6xwjEUWEzGzCJ+MNPLc2olP7/6qHuSbAw/+hvjnUNMZY?=
 =?iso-8859-1?Q?UOnFtomhwrcWjycYdJH9K9mUoPHk8rlSOamOPASfCn3ihTfSIThnkSvYZz?=
 =?iso-8859-1?Q?skGVHVk4DPqmfeajAF/XsAXGig4XegdS4YfcOHMaks2c5sMgivu+56Mmoj?=
 =?iso-8859-1?Q?kUs/Hy7qqpuhuRlPRLWo3P/AeI36SgnfntuhsdvY9T7e/WiIRDwqRGsoMO?=
 =?iso-8859-1?Q?zYwpDVkytctXQCxD+EOBouX6BPB4Sj6EFCWvYm97/VHIke7nI20grqse36?=
 =?iso-8859-1?Q?lb4Cfmg63rQ2/LFgj9bJn+4erOEHTbuPOSuqZkYZm7tQ6raL/QpIW/weCZ?=
 =?iso-8859-1?Q?QhMc0UGlo9t6yZM7cDUcGhuGRxNtfOl0vSeuQBHN3FWJmDemnf79FjW1Zj?=
 =?iso-8859-1?Q?cSN0g3TQm6kM8o2fBfMZ5psOZDv7EJO/YamP6Kzyr31TAKiu4lsQHqRjCJ?=
 =?iso-8859-1?Q?e7cqEUE5dO/UxwMB1X0Gwyx/L8bL+bhJbbtjKo2fXGy+5J64X8klagw74E?=
 =?iso-8859-1?Q?i7YzvJrILhKJnJIcVIKGNluJvlZs71zLx+zyOT51rQxLPlNjTyi/2hZv4b?=
 =?iso-8859-1?Q?gflmCSWa+fJkJNIeNQF/xWxXxJPcSbGL5hYsXJnpXB6GsDCQs1O8R6L6bs?=
 =?iso-8859-1?Q?rBjGmMk/dQ7yc1wpwhdu2plbCBS9ov68FaBjSD/5XwsoCwGJdZyH1g0wGa?=
 =?iso-8859-1?Q?8Ne49I20K95IvjEVCPDw1ZcLY8eodCzsYcy9WNQUkb/9NpB+xzOmNjgE2R?=
 =?iso-8859-1?Q?VaIEdF6kZ6itWiq+7AGmalAoyEkWhuogTmQ824WmAbCNXdYAoMkp2C6rA4?=
 =?iso-8859-1?Q?uWsITWe44PHlM1N2qZZX/9s966+wY53Q6hClTfCw5iCpwl9TpZO6+1gFOM?=
 =?iso-8859-1?Q?DiyW50wxbSXWudoO8cm/3rXDItxYPPx3DGWG0ZZIeiGN9SewffQf9/as26?=
 =?iso-8859-1?Q?2gXVPpgLN2L8O9wFDwURilpJ1OBGhFJ6YHklisDg+E0T/yD+BUqeV5aOX9?=
 =?iso-8859-1?Q?Ne+9F1GeAznj5chk6SNB2Ws4Sf7Er6PPi+TwEbzWjxI5aqGbddHpvlnisc?=
 =?iso-8859-1?Q?0mQkrjwNIQ0o8TAFhlQriwEnEDSM7dUQaWz0pNcjKbKOHwarzK0IoU9IQx?=
 =?iso-8859-1?Q?4Ib3HE1X75PSuaZy5UncQ7wyGmW0fzHXnZD/ViIh0jzgzvtmHpKy91yxz1?=
 =?iso-8859-1?Q?Q1pA03vhxGG3zBm0DyNKZ1fv6D8B9ypRPuQiPc4rWvhZKxWRn8PXWdnw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5268b403-ff73-4c53-1a81-08dbc4dc1d74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:16:27.0651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fdyGY1HvT6ORY+4rHs4RwoDGCQun4oYgkBt2fRff5OKVodmAOhT8JZR1rcdgEgZldjnfg1ebC9OgJ0OOxb4hMXE3Q7rq5z+kCOEB6yv3Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 02:04:54PM +0530, Tirthendu Sarkar wrote:
> When a programming status desc is encountered on the rx_ring,
> next_to_process is bumped along with cleaned_count but next_to_clean is
> not. This causes I40E_DESC_UNUSED() macro to misbehave resulting in
> overwriting whole ring with new buffers.
> 
> Update next_to_clean to point to next_to_process on seeing a programming
> status desc if not in the middle of handling a multi-frag packet. Also,
> bump cleaned_count only for such case as otherwise next_to_clean buffer
> may be returned to hardware on reaching clean_threshold.
> 
> Fixes: e9031f2da1ae ("i40e: introduce next_to_process to i40e_ring")
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reported-by: hq.dev+kernel@msdfc.xyz
> Reported by: Solomon Peachy <pizza@shaftnet.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217678
> Tested-by: hq.dev+kernel@msdfc.xyz

Could you ask for a name of that someone?

> Tested by: Indrek Järve <incx@dustbite.net>
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 0b3a27f118fb..50c70a8e470a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2544,7 +2544,14 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
>  			rx_buffer = i40e_rx_bi(rx_ring, ntp);
>  			i40e_inc_ntp(rx_ring);
>  			i40e_reuse_rx_page(rx_ring, rx_buffer);
> -			cleaned_count++;
> +			/* Update ntc and bump cleaned count if not in the
> +			 * middle of mb packet.
> +			 */
> +			if (rx_ring->next_to_clean == ntp) {
> +				rx_ring->next_to_clean =
> +					rx_ring->next_to_process;
> +				cleaned_count++;
> +			}
>  			continue;
>  		}
>  
> -- 
> 2.34.1
> 

