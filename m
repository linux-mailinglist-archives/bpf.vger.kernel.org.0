Return-Path: <bpf+bounces-14072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E41F7E045B
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 15:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC076281E84
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50618C32;
	Fri,  3 Nov 2023 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9s70OR/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77118643;
	Fri,  3 Nov 2023 14:05:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D770D7D;
	Fri,  3 Nov 2023 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699020311; x=1730556311;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IF4pObGq99rq8S2g96r3MxvBwfaE/rzPV10xIwz+Riw=;
  b=b9s70OR/niLrBhYHCgXtMx64iUXKuGpfzJWF1vqf2DTL388hBazBo7bD
   bdqLJajalYkzvKuJLGQZ5+y5H0/3XhfEsFGtQw9hdAKtWZkSArEWbfRUf
   UEJU7daL0eHSQ9dMmjk0uEhgvny+NfmJqCeCbqziEvxKTxuY83kA7t2kN
   d4zNzMM7vTQpOJFdSkxPvHT4EeStA2nB2+SsrwMO2l0SgWc3Fyv8+YAtb
   ZTOxxUIrCQdbrbtUOrMor0lHTZZCppfDBqVJaEjgrTR99OY/6vebhkm9b
   nlyVBE3KnHDgPuU/3XJcdfWK2cRq8nNUZtEs0U2JBY8f2EZB9un1SjUQx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="391817647"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="391817647"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 07:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="832031575"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="832031575"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 07:05:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 07:05:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 07:05:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 07:05:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 07:05:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW1fAdBiShFor5pQLspJKfRy0EYm+Oa8iHpb2vBj/NE3JWUss8mDX5ejGfd0UJj18O44FpkZfZLR1qpmQJDsX3DcsXM7dr8k/yX/8Tzl/+17Ah4B4I56seExijlwIsZv7LEy4yGdPlB0nIJjefahvPTQSlwUzLku00G9wrVYAByVTLgf0BvrqP3fyf6gzQJLpQvD5YUGNh5f07QYe9W6QFPWFX45RSVQz0iEPWByJScgU+j9mK3mLM498EZf1chWzEWJYChgCZUVyifk6yfJ86B1gbFwXHVMxMNQmI0eXAlpNb4l7OYLHQW0AKpcvrkvKeJrc+vU8hKjqRHJvwt4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDzwY19rGYXR6aKoIfYHhCEEjvA3RlU/iWlGGgw87b8=;
 b=SFFGoclWZuhAYFbM3w8/EKzme/qhpARrua4cOOJx+QAErC8Tuahwqko9GanA5gW0Xu+yq+S0FxjztiGt0hj8UfgOeJuzELM94LfoQXs0gnrOjGo7ypNOwmrhvSRhVlpuQAPZTjIR+vqCd0JrxHj4WbYUGuBzmjgGaxHuWGm9d+bzmGT22/nhBmoZw8dsfTFcyIDc0YnTwllZPYSWN3oH4OrzKtg4I2uLAszNZ1LF1VHSxptA1JL3CP+JnArKRXaeJFf3buIR1vJ1nHn7EuDVeuHz2kKWoMBGlTeILOWzx2Jk+lMGokslcJ1p+1qH1ZgPRZTGiOSw8BC8pGKzDu/etg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB8250.namprd11.prod.outlook.com (2603:10b6:510:1a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 14:05:06 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 14:05:05 +0000
Message-ID: <b6da9739-a6e6-4528-a4cd-f87e8e025740@intel.com>
Date: Fri, 3 Nov 2023 15:03:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] net, xdp: allow metadata > 32
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Eric Dumazet <edumazet@google.com>, "Magnus
 Karlsson" <magnus.karlsson@gmail.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Yunsheng Lin <linyunsheng@huawei.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, John Fastabend
	<john.fastabend@gmail.com>
References: <20231031175742.21455-1-larysa.zaremba@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231031175742.21455-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0365.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f94bc01-0ff5-4814-0b59-08dbdc75e153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kVFofVftNEb86oav7SfI3xYOnOX4BOP4WXBMvltI7YL45HRvKSf+hRuYWzLRNS8aeC4GtOWReMPDzdQ6p//JcCEefvTWo3K7OXDi+06eKWD7Q0m3gn/EUIr5c8Jp5Fqg7KCWHn25pEPrQDqC2w5JqEDTkrf7LZy8f7Czu0HOvJoLpjWSsNzwD/bOUSqq0d5XayFX9bQkAygG+QdIXpiWmlPgfQY70w8mYc9uriqRYNltDRkyJ7VFC+8pV8hxAqnNOSz5/Z4cwxTOTwusEH3u+fFnIra0572vhVykqB0vfnSm6OH0msIepp0zY9DwRcU8jsNmTlMoL91n7zbLT2O/ndOaaR0hf/A0Frjy0/yTqJ8/UavIc0i4lzfFnnMNHRcxph3BkYHvnhhDQPaV96WkFYbzFzQp8Z+6oTPUy3itfOYjjDZY7AuWoA6raqWLSHx5P4rrVMQIMbpGxBB7fKA3brRSlCxPHhr5cdtZke8FvvPL71xyX8DMnoaoL7OPDavWi8qsuyOmNSKo7GCEIgy/YbRvGD1ddLlmmru5OncvkNLP4u+VsPll86reCXRhGrbECJ/bKaxw8r/G9k71dvW1Gsb+bz/M2bm/JcDMFw1YWyc50zCqnr+4CxG1kOkJ+Qb4uzGHrxR9NXOGSEOvv60lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(82960400001)(5660300002)(8676002)(6862004)(26005)(4326008)(8936002)(4744005)(83380400001)(7416002)(2906002)(6512007)(478600001)(6486002)(31696002)(6506007)(6666004)(2616005)(31686004)(86362001)(54906003)(66476007)(66556008)(66946007)(316002)(6636002)(37006003)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elNzMW1QQkNpUXorSFVSN3liVE13bzZFZ09mNzBqRktEU3dYNHh0WWJUWTNQ?=
 =?utf-8?B?MVAycVpueUNRTGlXMEZOUVhIcVpvRG03Zmh6N213UFQzUUtaMW9POS9HcmhL?=
 =?utf-8?B?WkM5a1U0cEgwQUdTTnV0dmhMdjNxazNsS2prUEFYK0trTTNxQ1hXOU8zQVRh?=
 =?utf-8?B?aVRPcm4zMy9CcVp1Yk04RFdyS1J6Vi9XWmpzMlFGUXc4MDkrM1E5ZEk5TXZZ?=
 =?utf-8?B?QlcwT1VkZGs5VVp4M2ZMN1BuVnl0OERnR2xudXpoMmc0Y1RkNk1LeVdmSmxp?=
 =?utf-8?B?V2F1UkRCWnhpaTVVSHFTSW5BaVZjTlVWSzR3cDdoS1RyMU13cWp6SFVmOW56?=
 =?utf-8?B?YkNsclB1RkRESnlrOGN4bTQxNnYwdUs4RTBhM1BpcjhkSEdNZWoza01oMncw?=
 =?utf-8?B?NFVTY3htMk11YWppOSthRnBLejZPQTR5RmQ1NXp1QW9pQ1VzZXM4eEFqbHhC?=
 =?utf-8?B?VzRiRUxNeFFOMHcvdDRkcEduc2x6YlB5Z1Q5eG1SNDRyMzM1ck52OG9GNTJJ?=
 =?utf-8?B?N2ppL25FMVpicCtPL2tLNXR5aG4zbC9rbzN4WG44dWRlbTUyemh4eWlKUXJK?=
 =?utf-8?B?MVpWRXBoWDRieEJGWjVZYkdWaEF1bXFmcnFnTjBGSTVWdkdESTUyL1YzU1pT?=
 =?utf-8?B?ekRKQWlad2ZrbGx1UVo4YU1sNDREaEk0VStjUmxrUUszUUZvY2lKdUtwR01v?=
 =?utf-8?B?aDFvRDlSVSs1NSt3WEtQWGw5OXpKS1c4SEVSaDJDZ3YvbFZCRS9ZRnZydmI1?=
 =?utf-8?B?blB5WlAwRyt3VnNtSWZRaVMzRGNya1VQaFppVEJhQlRtSWdjdTBNaEVNU1p3?=
 =?utf-8?B?eGRvcnZtNmJUdUFnM0FXTmFleWVjQngvb2txN0hnWDdyUzBhUktkUGk4SjM5?=
 =?utf-8?B?K1dTTkhXZ1J6QXhZMWlSU3hTOUg0azkzdDA3UVhRanY1Y0pCNE1wNXFWV2xK?=
 =?utf-8?B?R0pqQnkrUnBxcGMzSnR3b1FlZWY2ZkFYaVpIOWNGdHppWm5RZXlHK1o5S09Y?=
 =?utf-8?B?Sm1qMkxHRmJoaGNVb0NsSkpCL2ZidzNSM0VISEdIZWdZK3k3VGdwMm0rUTNm?=
 =?utf-8?B?M1lHcXhFVTJyVDNXSEFVVmpZS2pleHNLbnlsVjJHNzMycTBlTkVnRDJMeDNJ?=
 =?utf-8?B?TXgzNHlURGIyRW51c0MrU3drQ1hJOGkwYy9QR1ZMdlNSYjZJY2V1UVQyU2kw?=
 =?utf-8?B?RzNXQXpnTFB5NVJKNi84c0RaOTlXdVVwOW9Ycm0yZFlTWnVzTUozcE82Tk82?=
 =?utf-8?B?ejlFcVJBSVljVnlmSXpaTFVUakJWVGI5U0lXaC9qWmJBLzYrYkE0a1Q3Mmhy?=
 =?utf-8?B?OHlqZ2oySVhLUVlpOXpHdTdINE9BZHd6MG5JOU1raU9GTGswMW8yQUlac002?=
 =?utf-8?B?UUxnQ1ZFNW9pV05IQ0d3VUQ5S2RzcDFCSjBkSStMaWZDMS8wdy9uQzVaL0pP?=
 =?utf-8?B?L3F3d252RzJjcDd0MHp1c083a0F2Tzh6STlSSERraUMwZXA4dmlWbFM3bUtF?=
 =?utf-8?B?amNyTTJxeGRpNVgrS2xnNFJ2KzBocnpLRDhTcVVLZEVURDNMV1hEZTNOMXox?=
 =?utf-8?B?SlE2M0F0NitkRUZXNTBNNmhlSUVwNXJEbGQ3QVFnRlcvZzBFRGIxWGUwNUhI?=
 =?utf-8?B?QkNYSUR1ZHg1T2FIQVpiNnBTMGgySkUvR1Bha3FZMW9kbkFDSllvR3dwcmxD?=
 =?utf-8?B?N0VHdWtiSlVMaWFxQWRXSlVWcVl4UUpSY1dMMWFsWXJQT2JHWXdQVlZyaVRF?=
 =?utf-8?B?SEZYVG56MmRneEpTUm16Zmsvb1Q3a1BrVlRNUFBhaitueXEzZ3NpNVUxcHVS?=
 =?utf-8?B?NS9XVW9kWHZTamF5dHFuemp4bFJkZ2Q2bjhGdUt4OEdQQ2plV0NrNmIyZzZB?=
 =?utf-8?B?bjVXeU5CaTNDYWMyRXBaV3pGR3h4MHlhallHK05oL2gzdkJhWVNZaXY1dmRR?=
 =?utf-8?B?K1h2WGFwMTJ3RG41TTZ1V05rb3VMRFE3ZkZ2NG1sMDBkcjhFNWxKK1RYckdU?=
 =?utf-8?B?eTVnSE1Ed1ZJUGJ5TlVHamcwTyszdzNPbkhzaENyT0lTdms3MjdXMk52Q3U5?=
 =?utf-8?B?NzJaTFA1MTBzZEE3ZVR6WG83Uk5ONlg3Zm9JdnEwOFVXTGFjeVBmRmpPbFZy?=
 =?utf-8?B?L1ZDMzMzZmh0OTVOdURWajhLZ2Jpb2tPQVdOQTlaVlNReW5NaCttYmVVVW5h?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f94bc01-0ff5-4814-0b59-08dbdc75e153
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 14:05:05.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKGK5rLPo1a6jyHTBJ40WSWidrYAZpIDQjf7G9OsYKNVdv/sece8hf52Xh1+7D3TIsoDZ1ucOBcOtGezpJcJaq9HjzvAO9rIUwHsw38EVdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8250
X-OriginatorOrg: intel.com

From: Larysa Zaremba <larysa.zaremba@intel.com>
Date: Tue, 31 Oct 2023 18:57:37 +0100

It doesn't have "From: Alexa..." here, so that you'll be the author once
this is applied. Is this intended? ^.^

> 32 bytes may be not enough for some custom metadata. Relax the restriction,
> allow metadata larger than 32 bytes and make __skb_metadata_differs() work
> with bigger lengths.
> 
> Now size of metadata is only limited by the fact it is stored as u8
> in skb_shared_info, so the upper limit is now is 255. Other important
> conditions, such as having enough space for xdp_frame building, are already
> checked in bpf_xdp_adjust_meta().

[...]

Thanks,
Olek

