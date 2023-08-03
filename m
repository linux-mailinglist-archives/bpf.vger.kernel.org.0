Return-Path: <bpf+bounces-6878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B043276EEB3
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 17:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DE91C21595
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C510D24173;
	Thu,  3 Aug 2023 15:53:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F1823BE1;
	Thu,  3 Aug 2023 15:53:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F62E6B;
	Thu,  3 Aug 2023 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691077985; x=1722613985;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GBSOgfZbReQpu5ZvNi4M0MSo5+sLzaAb3JtiIaY7CDU=;
  b=MLs476AFYSYuZrQp9ONAW6ihD4UFTTFOtuaNueADCeBAE+OuuLJ78HAA
   Q9Xh6NIIzd5Jd1IQg/VQPtYiV7nhL508gR8TTK36Xcw7wVvfDJjAY/V55
   F5K5qFocDKGxNXJWJkwduUzWYUbd48xTHzd3WbXRkR+1QIl83Xk6rB370
   rRwNRNK5PWxVzgZ3lG2XxxkQZAV86PB2Le3p1GHb9wiInPXj7E/QsEr2S
   gMb7MDAev5ZukhLp/i+HcyQE2uCM/qooftKZ2xprPVZvWxTwGaHaNly/8
   gcFwsE4VCufDK0vTEaWL46/t9IU5eE2vHA4k6JllsecPJOslUphybEuig
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="400866254"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="400866254"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 08:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="795030392"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="795030392"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 03 Aug 2023 08:52:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 08:52:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 08:52:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 08:52:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT/7Q98c9nDoboD1FWGtxOBiZY8fnFWitM0RrR/j2IQXwhzlgVkd59enrUtAMGV/O+FKM3BO6z7VGiJiJWaewS0g9vkcRjGG0mtTLgfD/Lv9ZKesMoW53dPympgZS5PnvMEo8yWDm+u0WRuzaAlnq87OjGV5jkwqX0W9nxWZuyi1cFs4j3vrZm+gJcjiz4sC3HNZxyoRc1wsNSTYLJw9cATnY4BLwuD8iMNUshYDa7k+JdxtNvc7Fo6eIxWS09uDb1vKEoP7G+PteLqlJcq3eEWsUjmwAvPmgRVypUeIxH+GdekJT6OYVxO9a/yQ8OehPPCjVb6FZ7dU5/3rxyb1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONIK0nifoALjFgkG4GoihxUO239Jc8PcxSM2X3WFKcE=;
 b=St+5L/O55jas5/2RXfY0QlvsJrUE8G7X2vk5Mfw1eVYfgUjTAURlZk2cUiF8VPI1Ji8YrALYsEvMKqjqBlWfTojcRxCGofvqV+W8vAtlGL9f/jOvlYSCCqGkXKV5+pTNyJw3IfPFog7ZDVpj5Qn38gW/2Bvt1ZLpbPVrAjLS5yjcFOVfm7w00AsBlZguuR8lPuN4Y1VMUDaKG3uH/SSN2WE1KCG10Bgr9cx9EXBqRXRN3s+hNzHDS1SkCyJ1HvVPjN1NnvkqSpNuEL81ukuhkz4agmM1hNNQmOghE/LtctRvn+NynfD2GwCVNgGXhAy7GaOM9oU8J4WGwXJPAu0J2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ0PR11MB4813.namprd11.prod.outlook.com (2603:10b6:a03:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 15:52:40 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:52:40 +0000
Message-ID: <b67d4e91-9802-57f1-462a-38000a6e159f@intel.com>
Date: Thu, 3 Aug 2023 17:52:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 2/3] net: move struct netdev_rx_queue out of
 netdevice.h
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <ast@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<hawk@kernel.org>, <amritha.nambiar@intel.com>, <mst@redhat.com>,
	<jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<gregkh@linuxfoundation.org>, <wangyufen@huawei.com>,
	<virtualization@lists.linux-foundation.org>
References: <20230803010230.1755386-1-kuba@kernel.org>
 <20230803010230.1755386-3-kuba@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230803010230.1755386-3-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::13) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ0PR11MB4813:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfec865-86f1-4a7c-a996-08db9439aa88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wK09Gnq7CCws80XBm1TKgEq/PQGZK6qCjVRd0eJSS1D439hGUYkDr5BkzUQqtzgwSMDI98/3+efl89iMLGnNS8o+3nRLKQE3NbvfUzAB36JsQAJ0F0YGiRunDg6FdmE8NoOPeL+menyJurBF4pTUQixbw68ZF5KrzF8Hn/6goLfKoA5mEVGWoDb/yCvcRCwuFgX5md3JmOA+LLGws+nJCnA8CFzFj6oj0KLarrBzCbE9QY9ULViPgvnw3gx7wdd3Sj4ShCPNH0iJteZhZRIIxRFkFIqK3R1egitfWiKywmssIAqSON5bb0NQGFyTuGbOEvgRgaj3rW2+U5iIShGcM2u34gjyT23b9nL7PmE1xV40j4fgCAro1amn1qZ590M8Y4jhhzhxlBt/GL27EDtxQxvLUjReqju3P7v4/N+Ea9VnIGUoX6MRut0m8Ae5+/Ma7CLqkh2wvlxjXAb9za/k6d5nqsNct2QHgjfJ6zvbR4m9UNgEc+TuN6Fv6o0oW+Pv9F85y+q1J0RtDZGR8Fvj3Mc8Yiom//Ux3oQYfMC4PXarESMhDPa1eUm5yNbHgx9k7pBC2La9Fr0jfw0R47JNTxyoKOR3KZdum4x4U6DI5SZZ6uDxe4sUQ8m1xjWr77okdTFfNBxlAU4Z8K0neE/tDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(2616005)(6506007)(186003)(83380400001)(26005)(8676002)(66476007)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(7416002)(8936002)(41300700001)(6486002)(6666004)(6512007)(478600001)(82960400001)(38100700002)(31696002)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q29SVC9CWmxQVmRXa09oOWZqRXRkRkVIeGZWRSt4SHhCZHFUMTliRlQybEhm?=
 =?utf-8?B?YXd4NWo2RU5XOEI0T0tVNGNwc3JqbWl0TFp0MER2d1FRTXo0eU8zaHNycTJS?=
 =?utf-8?B?KzEwYzFDQTM5eC8rc1hSejRLRElQaGoyL2JhUmtKTlVoZ2RGa05Jd3RyK3Bj?=
 =?utf-8?B?R3dvdmt1aDBXcStVSTAxQWVFRDZhRWtDWU0vTFNPOUs3ZTBxRHJxVkpzRmV5?=
 =?utf-8?B?YjJUWEtRR0hZblJuMFZIZlVTZGpUTFVEcXhIYlp0aFVpVkZjZXBDWUVLZERx?=
 =?utf-8?B?T2Q0WERjWGF5N3FJMUpIT3RvdDVCUGw3R3JDWXRvRGlNU2hDbUNjM3p2QWYx?=
 =?utf-8?B?QXNxM0NyMTJDcnFMTnQwMGVXRmZmNFhRUHVCUXBrYnpkbnBUdjd2MzFvRmkx?=
 =?utf-8?B?Y2phZEs4ZGpzSFRteENaSUwrZmVUeHBqNjd0K20rN2dGYVNIREZJdnZ1U3NU?=
 =?utf-8?B?bHlXRVg2Vi92b3FXVTJzeTU0M1lvNGg4VitTRTBsUFVJOUlkSVFxVHlaU1ly?=
 =?utf-8?B?WGNBWDlQZzA4ZGpPczdDQWdycHd3dm96T0dtTW5KSmZiV3BidmlaNm9kRDVU?=
 =?utf-8?B?S0I3Sm40Z0FJYnpNMEdmd29VUnhneW1FeHllMmxlanJMcnJrOE1MSkh4SUFW?=
 =?utf-8?B?RWV5Y1d0V2pMWXdGUGNXVm9UcVpDY09pVlQvMjR5R1dHOUhydmQyMVBRdDVS?=
 =?utf-8?B?RE4vWFNtN0tnaUxzbVZDWnlwaU1tSE5VclFUTUJFYUs5aFo5eUgwaXIvbmQv?=
 =?utf-8?B?bS9ZOUpmS1lkQWZmTE91VE5UNW01cWkvc0t2QmRSb0JjUzNHRTk3eHdHOERs?=
 =?utf-8?B?LzNEbUdxRjNqbThPTEhzaFczdkJBQkMxOWhseVBOVlVEWUVLZ2l0d05tU2VV?=
 =?utf-8?B?NHd0Y1NMMzFkSVJFbFh0L3VNOUpWUTJFQTJNOGZEMDBnbVMwODNkQ1JERWJG?=
 =?utf-8?B?TlZvSGZWMlNnaVRRdjIvZ1QwTUdMZEUySzhoSkswRmQ3UGRyWFlZMEhJdDUy?=
 =?utf-8?B?Yk9sTHRFN0szSS83cFJ6dGhZR0FNTDhHUXNtSWNlQmFDdXQ4VlJQbFVEN0xF?=
 =?utf-8?B?MjZSdVE2RGkrclQzWHFITlp4V2lhSGdPSFptMHVKQ0l1cmpkcnN0V2hSS0kz?=
 =?utf-8?B?QUxpU29ZSWRnUnI2ZzE4NXd5NDlLNGRHN0I0Z0Jsd0Y1bDlMdENCUzQxazUx?=
 =?utf-8?B?Sm5TVlhmRHRDK21xYWZkTmJDcmtGcjhtdXJFZ2FpSXdwTFVtbmEvTmJwNzhU?=
 =?utf-8?B?RG9wYitYZFJ6Q3lzVFZCd0JVOWZpSDF0ZTBDY0VBNHQyRmdzNXl3OTNIdTN6?=
 =?utf-8?B?bnlNTjdGc1FnbmNTQmpxOTdlR0xTbmxsbURCQnNYSU5TWGpucUhlSHd1Vi84?=
 =?utf-8?B?bEdFL3NpV1ZhWjBjUkRKaml2OVRTcHkxMEtrRUZEQUwvK2VRQ3ZzU3E3SGla?=
 =?utf-8?B?V2lJdS91cVZ1SDFldFE2MlRpelZTam9UOC8zNmVucFJ5Q0lObjVpSlFtbG9I?=
 =?utf-8?B?NndScFh1NzJyUHFNcGdJa2dDSjNwZTRucFRpNGNyZTlNcFZlYThYUTI2ZEEz?=
 =?utf-8?B?aWg1bStvTGV1WnZuZGpOeVpNMjlIL1FjZFptZVlxRUlBT1VPVXlEMmZ6bWV5?=
 =?utf-8?B?ODdiM3JkbnhYWVB4SHBWNmxKMVdxTU10aWMwb280Ry9NdUFvU1ZWT2hWZEI3?=
 =?utf-8?B?cm14SE1XTXkvbVFCSGpzbnEzSURPQzhxaU1EbHE3NlZSRnhoMFZpeTN2UWla?=
 =?utf-8?B?Zmw0eXhTQjlqYndYRTllUzdudGxEcjNhdnNRRTdlOW01aG1EZ0dkdXlnR2Rt?=
 =?utf-8?B?UHNyOGVwN1IrdTdwNE42dmc0Ym42T1RubExBOSt2NDhKbmEweHk2djJDaXo2?=
 =?utf-8?B?cERMTTc3UGk4d3VkeE0zUkx2NTlPczNhUHhjbklhOFhqZkRraG5PbWVWcWwr?=
 =?utf-8?B?bEptWHVRNkJ5Zm5FdVozcmMyek9mYnFkRWJmbk0yUDhxOVNKVmJ3VnEwVkFH?=
 =?utf-8?B?MFVPblNVRDlmVStaOUtwZlpYbWUyRTcwSldVVTFFMnFPVHpuUWlUNU9NTkwx?=
 =?utf-8?B?ZTZYMHFPU1REcWRtbmU2ZVN5UU9xN1RaYkxySGt3NVRBMG5vcVU0YnFJVEhm?=
 =?utf-8?B?eE5vNjZaSG9vdjlGS29BSENIbzRaL1F4Um05MFYrQTcvd2hnSDdnT0lOV1li?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfec865-86f1-4a7c-a996-08db9439aa88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:52:40.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHWOtev4+6tK6ucBbPDz2Yh6NYxZwbyH2WBbrJpqf9RnHfA9KzFsRXD5cgiQvKZ17V+4PArOJFB3vPBTTmUww+R3UUxF3b1oVSpaJPySARQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4813
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed,  2 Aug 2023 18:02:29 -0700

> struct netdev_rx_queue is touched in only a few places
> and having it defined in netdevice.h brings in the dependency
> on xdp.h, because struct xdp_rxq_info gets embedded in
> struct netdev_rx_queue.

[...]

> +static inline struct netdev_rx_queue *
> +__netif_get_rx_queue(struct net_device *dev, unsigned int rxq)
> +{
> +	return dev->_rx + rxq;
> +}
> +
> +#ifdef CONFIG_SYSFS
> +static inline unsigned int
> +get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
> +{
> +	struct net_device *dev = queue->dev;
> +	int index = queue - dev->_rx;
> +
> +	BUG_ON(index >= dev->num_rx_queues);
> +	return index;
> +}
> +#endif
> +#endif

Looks a bit confusing :s Could you separate then by a NL and leave a
comment near each one with the corresponding definition? Like

	return index;
}
#endif /* CONFIG_SYSFS */

#endif /* _LINUX_NETDEV_RX_QUEUE_H */

Maybe Alex could do that when applying, given that there are no more
change requests.

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 7d47f53f20c1..0aac76c13fd4 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -20,6 +20,7 @@

[...]

Thanks,
Olek

