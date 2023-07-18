Return-Path: <bpf+bounces-5167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827DB75809C
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 17:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348E1281602
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5D9101C2;
	Tue, 18 Jul 2023 15:16:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE5F51D;
	Tue, 18 Jul 2023 15:16:40 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CDC173D;
	Tue, 18 Jul 2023 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689693392; x=1721229392;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Md3Zw10iEpXZQkpZ4bS1aamLyNurM7L88kvVUrjEr84=;
  b=TRhapqgE0v7LoOaRTVz9+gzYKQ9cPRpbwDfLff47jSLAmDbSQL7jaJEB
   Mgx4k/f8Z30CU87jTu/wILpd/nRiLAVrec+XfIAmZCCVToJhghJh7bwka
   3zUTf8uRpWjcjPQD1k0Pui8QjtJlsAD0tGZkEuoxWBzNaG+n6xwXvY7Vf
   gSOWRvqDw1X0GVj0M6DM30avwuKFz854EpeNKDYKFsvgAdKvrnvI5kN0K
   hEKltTr/ICSjl6z1TtS8dP0JB9TGiD980G1XpWyIBrM6JD44R+ttp51FU
   Aw0Cw09b9az/G4OM3D8eJx5KIp7TALK3LXOxskG9avjqRdI52gBYFmRjX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432414829"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="432414829"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 08:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867113956"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2023 08:16:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 08:16:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 08:16:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 08:16:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 08:16:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRQCXuCnYnz20s4s9u70pDXfXPMAHsl+kpKX0vNgg3qQ4I95a9viToj+L84Vg1I0XTWsAmd1tafhrlOFu4SzKJIZ8AivZ88vaKaGNZAw7/okCnsu7oxcW/6javovGXL0uB4O4NP2fdFZIVowRuRuOUWA/ZOByrRqILMfkOYeeC4e2aLNjvf+VIiP6Z7MgGbQ4vr9f8uXxIxupbrUAbl8/HUElGwPHJMm6udoUSMYjel6y//pIxBK+fr5fhiUVC6DEfWWg5eFZlRRWthrFRM1qnN0W1I0bJyLCRuIZtR5kwLPBKOH0Rkm8kfmenZ4h9AUkMU1aQtgWPkcxw+1MmuFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxkLUbIah9CRTzXyzJHh/zRxCmnvxewXrPScBWdfF+s=;
 b=TQnIwuoLIo6DaMCpIR+Zcxs+sBRgurJS60zM5dVcZPqv4/YHYron5z97pC+zOkqyf8zwF6oz7XKItiaQY3ZzkiKauC8s8HDnE63mbfHwx0r8FY6w7M4rPZ4+lEqWlGU+xvh+sXbOySj7POGgsmOXoxQWfT6/GM6BRwYpebTDE7vhzS2Vi8jW8LBbjzF80jBIZoW+UzCZo43rljUh8ZBH08iF89Dxskp2fhlmgjd1Ku4gSxzf0E5G8hfmkUTkMobUBjH1ZXSMw8UmChMCFK3xlPFD6TrucqKCu5c+ocLOua9P+aoO/lTNqv/scj/nlL2G+8VkjALGQUdc47Yz66EOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SN7PR11MB6993.namprd11.prod.outlook.com (2603:10b6:806:2ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Tue, 18 Jul
 2023 15:16:27 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:16:27 +0000
Message-ID: <fa3dc82a-fe5e-a90c-6490-1661f1bb43d8@intel.com>
Date: Tue, 18 Jul 2023 17:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] net: fec: add XDP_TX feature support
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <xiaoning.wang@nxp.com>,
	<shenwei.wang@nxp.com>, <netdev@vger.kernel.org>, <linux-imx@nxp.com>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230717103709.2629372-1-wei.fang@nxp.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230717103709.2629372-1-wei.fang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SN7PR11MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 801106b6-d68f-474c-eb0e-08db87a1f4d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70RnviRcI2hJg1hRVxoOgsp2r9Qw/U6JVyU9DV4B9VW6ovSaLfLhKnM68zNrCoFm1iazL2YlQTQw0/4K6A5c/AstqGPRuvdbMxfaKoUMiEIO5hzwZq92vuUU0SXK5fUr8UQL+KcrwUMDCxfyFpZ/F84aEcoLv6gqYYdHQzovy9iTLM+3b18OBFo+EfSQoJER1nW51WD7C2UwREb5ZgeTfCShYsYkLwIqe8mBAGuEkQ3ySeGn6NnWbrO1HWSxo0xf1aShY6hx4WqIBTNbv7lxF16hxFlPXIeN1lP1Mg3lemzgeurnw0uf7lAS1QqqPCGO/+ZLzKqYQ5i2Ga+YbwXvo5h2CPWpQ1X0hxmCjNVaG6kgqQ8ZbOmnA8glegpwY7LMuxTySeKAFjcgC0CuwnmeGNiPVFVqXdp3uA1YCxC9RdOjcYEfEHy5BaGEPbYbEr82OHyQfQFpJ16++9dyYMnzHlmrssOaWOzFLAxGMc8yZvbVXbCeuBp8ldAjJdvHNoAY6Hz6lb0oe5F0nwNlPcmmtnUdu1l19AnCX0L91XsER5u1aeCoxL9n5qltFnlTTOrlu/SYazOINOmmG92M8N10uORHo/hb9yO7dvR0xQP8Jzd/1WThVxcqROxmjHff4EstBHH8qFpapjmAzw9+FJon+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(316002)(41300700001)(66556008)(66476007)(66946007)(4326008)(6916009)(5660300002)(8676002)(8936002)(2616005)(83380400001)(86362001)(31696002)(38100700002)(82960400001)(6512007)(36756003)(6486002)(26005)(186003)(6506007)(6666004)(478600001)(31686004)(7416002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHlRV2plYzFKZWUxMm8zWC85dis5eDdZMVBFcHF0UUc5TGRlOXMzdWZJWHBB?=
 =?utf-8?B?Z0N2b0RLV2hXbjlQRHpVNmFYUjRLclBVRWIya3crOTF0bkt3WVoxM1F2K0ZR?=
 =?utf-8?B?ckpueTNacVNFWWhFUzRRbGw0cDRlK2YwSEwwN2p4clJYK1FHVmZRY2hRTEVi?=
 =?utf-8?B?UXNPa2VPMkNydHdFVElFTU9iRXRaWkVLV0llMTh4cFlPM0YzT3RyeCtDeEdV?=
 =?utf-8?B?VXBDdEsxa1pDVUdxZzZrM0xmTjFqbUFBL2NXdzFxUWQyb2dmNnY2ME1OLzV1?=
 =?utf-8?B?ZWc4WGZtRC9kT0EvNW9UMlhMdzAyKzJjWEtFSjg3SUtOYTBzM24wSUhpdXdE?=
 =?utf-8?B?Q3lCS1c3T01vRGsxVGtQNm94ZFR6Uzg1ZFhjbVd0TnNJeXZEenpNRWo1dWRN?=
 =?utf-8?B?TVJOLy9mc0dQSG1MZE9WbDd2TytXaW4zZC9EOHJWRFdwYUxldVFyK085bm9W?=
 =?utf-8?B?M0p5ajNYbXhNdHFNMnFTS05hSGtFUDNHdzE2YnRwRHB1M3hxZ2ZiYlpUK1lC?=
 =?utf-8?B?MXpvenJaK1pQTTV2T0U0bkUrQ0Job29HMTZNMXRvMklEUCtxdmZrUXlxVm10?=
 =?utf-8?B?RGh0a0o3RE1GeERFa2diQkpHaVZwcm5LaE5wbnZzRk5SYzdhYXI1cElZV3Av?=
 =?utf-8?B?UXlZUnpQR1pMTkpLNHVvS2FtWW5LR01qRHVtblJiQXJUTVJlbkdOS0pYMmpP?=
 =?utf-8?B?bkF2QUZYMSs5ZWpEK1JlaE1jVXJlTDJjM2g3TkxZZEpRNytWWEV5UkNNdWhB?=
 =?utf-8?B?NVNiWXRUQjlmSmVBdkc0bU5lVmUrU0lkNExXalAyekhmTDlFMTBwdTk5YXY4?=
 =?utf-8?B?OEVsdktsL2VSM2tGNVlXWFZ2RVVQNlljSlpFWXBqdXhVWjlWZlVTZ2x6OTB5?=
 =?utf-8?B?UktHRTBQYm9MdWN5OEV2V2labVdjdVIya2czaEY2UGs5Z3lTL2p5bDlQaFRV?=
 =?utf-8?B?UnRBMlo0VVQ4THdzNkZwVkdRZDdwRjZtNjF0QTJsQld6aER1aWJhWVk3ajFi?=
 =?utf-8?B?VWJzWWxxZ25BN0V1Q0NSNHpSanpMTk93VEdDNjlIbVZmbzFmZktGUkNxK1I0?=
 =?utf-8?B?ei9HTzZibVdXNUVzN0Z0VTYvbHNFV3hQMkR1bEVKYnMzaHEwWVRpMW9uRk9K?=
 =?utf-8?B?MGdXN3ZqdGFVY3hsQ3AyTkhYNU9mbU14TnZaTjR3eXMwL1VxaHNSTU51UGlP?=
 =?utf-8?B?UVIydWt0cWovR3B4VVY2Y0hya0FlMk1oKzk0VVoydHNsZHhKUWQwTktaR3dX?=
 =?utf-8?B?a2FzamY2djhUblBKc1VPYnA2V3gyY3VUV0YrZFdESitGazdham40RkpsQStn?=
 =?utf-8?B?Zzl6bW55Q0xac1E3Sy9DUTRPN1Y3TXhYNGN4M2pMRzB0c1B4OUZJR3A3RWF4?=
 =?utf-8?B?WFRER0ZXbG1Dd001dHhCT1RpdDF5NGM4TXVVKzZlZng1b29kVXNlbHRiS09O?=
 =?utf-8?B?blFvd0JJaFZvUWM3eUJBZHlwc3NrNHQ2Wjc4ZllaL3R5K2d4cVZDSGx5NC90?=
 =?utf-8?B?a2huRTJXV3hjQWNPU01wWnhFVW51K2Jpc0FHd2J1d2lFSlJxQ1Rta2l0M0Vu?=
 =?utf-8?B?aFh1bitXNlF1cXdjclMvcW9sdFpNczNTTkJsWERDOVY2cVJScGZFYUhRcjlQ?=
 =?utf-8?B?VTljNVdVb2sveTVlamo2bjV3dklwdkh3OTkrb0hCRlRaZUczUURtRGZTdG5H?=
 =?utf-8?B?ME05dXYyYVFPK2M3b1FobWttSGluVTRXeWgxNitlNk9BME5ocW9pcHhTL2Fi?=
 =?utf-8?B?STU1REJwTUkycnlJWDV2ZmU1TUkraTF0Q3JzbXEybk42NEtXVm1leHBCNG5L?=
 =?utf-8?B?SDR2RGUvMjR5dGJwWFhhd2U1WXZZQUFDVW54QzErWXVJdkl4eWpEVjlIRU9s?=
 =?utf-8?B?dldhdm5POWZESUJNWG12cTV0ZCswc2xkZlFCZ1RwdzFHZW5CQXZGTnNnTXly?=
 =?utf-8?B?VlZhdHZmNk5GbTNGdG1nd2tObDNZRDVBekNpMkxUNXd0QU9wbHdIN0JzTmt3?=
 =?utf-8?B?bW52azJEeE4wU0U5ZWw3aWhBTXp2eWhGeHhxQ3VNSzlZNnRFQVdqUlljWUg0?=
 =?utf-8?B?NjJQUzZXaS9LRC82YlRqRURSUDNMTnc1S1QxblJFaUllS1pCQU1TZnRta1VT?=
 =?utf-8?B?blBTUVhrTG9EVk55cVV4VW02TElPalNZM0gwUFdUVHdnOGFFWnhmTUszbmRp?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 801106b6-d68f-474c-eb0e-08db87a1f4d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:16:27.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgyN13z39qLsJ1beLQwg5nr2zd0SXDwJ5XDU9PrtuvToQJYsJXqgWxQF2NKdVS5asTfmAxBOYa+lGNOyH3PHfeh9WsbAJ480aMep8OkAEak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6993
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wei Fang <wei.fang@nxp.com>
Date: Mon, 17 Jul 2023 18:37:09 +0800

> The XDP_TX feature is not supported before, and all the frames
> which are deemed to do XDP_TX action actually do the XDP_DROP
> action. So this patch adds the XDP_TX support to FEC driver.

[...]

> @@ -3897,6 +3923,29 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>  	return 0;
>  }
>  
> +static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> +				struct xdp_buff *xdp)
> +{
> +	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);

Have you tried avoid converting buff to frame in case of XDP_TX? It
would save you a bunch of CPU cycles.

> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct fec_enet_priv_tx_q *txq;
> +	int cpu = smp_processor_id();
> +	struct netdev_queue *nq;
> +	int queue, ret;
> +
> +	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
> +	txq = fep->tx_queue[queue];
> +	nq = netdev_get_tx_queue(fep->netdev, queue);
> +
> +	__netif_tx_lock(nq, cpu);
> +
> +	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, false);
> +
> +	__netif_tx_unlock(nq);
> +
> +	return ret;
> +}
> +
>  static int fec_enet_xdp_xmit(struct net_device *dev,
>  			     int num_frames,
>  			     struct xdp_frame **frames,
> @@ -3917,7 +3966,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
>  	__netif_tx_lock(nq, cpu);
>  
>  	for (i = 0; i < num_frames; i++) {
> -		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
> +		if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) < 0)
>  			break;
>  		sent_frames++;
>  	}

Thanks,
Olek

