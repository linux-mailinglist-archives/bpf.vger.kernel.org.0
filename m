Return-Path: <bpf+bounces-16043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42AB7FBA0F
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 13:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DC31C21442
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34490524D8;
	Tue, 28 Nov 2023 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Drhi6aP4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAFCD59;
	Tue, 28 Nov 2023 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701174390; x=1732710390;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XoRrW1+85RfTYjJy58lF6Qt2UsjBmTcp8OO9NFvi8+4=;
  b=Drhi6aP4nl+qt4Bih/ZKxPYPtEDNCpJ5JMVt5qU8N157ZMPrwJqore5t
   SCyRuZzWcgQziWTi99KRUbCO+43UdXqfEscd+ShqLHIe/G1j7m46VC9Ts
   rk+bfqUdm8SzFwrhESx4SKbGDllqNGCltKiFQCmw0FL1c9FSUPW+bqTaz
   146WBU7raASIfC+vcF+jJ04gSskkTRrUmCK8rS4J5wCzAVXDr+LhFe5D4
   G5y0TqpJinGEdbVrqiUZ7GV3Vjg2d0xq6deahCxNzi5k6pAuW/BJ8ML0m
   /jwNnIHVfFA3K4CLMNMhh5yIdwzBw2uKR5z6vPIKxWJT+KaGnN0Wbsb2H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="6111867"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="6111867"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 04:26:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="16608570"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 04:26:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 04:26:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 04:26:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 04:26:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyOWEArbs0MY5dk2swNp9pFV+EDstpCUFIvXjN3pQWdWRgArvUHVqCNq482H9kGoev57sZr3Bq22HWAzVuJZ5ldSRLmkjJtemsB8tFmiqCClFyiSg9MrqQmcPFC0UF1zT0PMlAMfP9QX0g+OMk1TxvwYjXwJAJcMvbrKO/3BN3BywQuxuAE4weWBlfImlwlAl2nm7W4Ap06env+CaWBPz7J9zuR0WNODwUeg6krY0XmC8krBjEFH9QPyXmH17ddaFmcdQ2moiiMdpDVrztyzXZ/njOSsV/w8C3ecE3c5LFBRcQTJGtFQ23UKXvyWxCpLIrKyJ6/O3B26tR3o58ZnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAnT7etqqgYHPvC0AO+JJUNwhXuWZ5V619yhgQceOak=;
 b=kJRBqS321F19BDUAPSEOxdibV+dIibPkoHNVsUS4jC87/rys45jlmRh9UPZMKFdJ29oDAwAn+nHlyV8Z5jijBA3/Vb20IjCpqdYzmWPu+BBZwgB4xi1SmkrEtOuWcdCR0dWvKaMVO4xMm5ziiELOTV8OcbkeQtmcDVxIZrUK0uhWGttkPXzntbIcfnE5K9mKt/y43LAEiuOI/gNsvkOQs65qUvT9Z3fiK+etg8Z3zFR1kfkQAEKtLAQlOqihhvTqvgSUsxJYp3uKIoUi+fbGwg2mH+mrdi9ZWGPnzHjoBw5F9E/lLxHHHQO5knkO4CLk12Y47RzKH9xGD7W5RIlfIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM4PR11MB5969.namprd11.prod.outlook.com (2603:10b6:8:5c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Tue, 28 Nov 2023 12:26:10 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 12:26:10 +0000
Message-ID: <c37449f1-4b23-41a7-a31d-e58cd35a6142@intel.com>
Date: Tue, 28 Nov 2023 13:25:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/2] Allow data_meta size > 32
Content-Language: en-US
To: Jesper Dangaard Brouer <hawk@kernel.org>, Larysa Zaremba
	<larysa.zaremba@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Magnus Karlsson <magnus.karlsson@gmail.com>, "Willem
 de Bruijn" <willemdebruijn.kernel@gmail.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	John Fastabend <john.fastabend@gmail.com>
References: <20231127183216.269958-1-larysa.zaremba@intel.com>
 <2fcc90b1-deeb-487f-b6e6-c649bee2e8a8@kernel.org>
 <ZWXB+8FQenT6717+@lzaremba-mobl.ger.corp.intel.com>
 <eb87653c-8ff8-447d-a7a1-25961f60518a@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <eb87653c-8ff8-447d-a7a1-25961f60518a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::10) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM4PR11MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a8320b-643b-4a36-b50a-08dbf00d3437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 787AS8pwL2sV7K+FR+L/Y0nBQNZWBzkLGesUZzKCt9HzBkOdKmcaI3I1BLXr4vtbu4hzGqUD2G5ws10rGz3eu7Y6ftpkxCONZAoj6b9pSJcmIppGmnTkgUpdGvb3nww47D+oDM5GKc4EXztjd4PXU+l13EmTju2OETVbiPydZakEOF7v5zMwDsPSJELr8ujDrd7dYX2zZUCs7s+gqfYZPrGgSmR4g6/qEYJZLRfLkv4RxAqHKV67D3sLykMgXfOFjbybzp5pO6Rkks5+0S3RRWiKXVTsQgEnJ1R8uzhIul4lM/rqx1gFRQbQxiabaPiDihSU8Hvq+lal67UnzqV8k2ozJ+zv0xEMkhRWae+l0/lE7bdFt81SC/dlNQ3T2rlYRHku47pnhk/0ktOl5jUKmw+SfP9XAsJQglFBYXZWiTFh2Ymrirs/pNUFS/sxjif3liL/FZfESuSPae4DU/61wXb13H0muH4U+o72U/m7mbQi7I4vPfP7gUmLWa02imjQFqIz3+VpOhTnuy4rg2nPulwuEF8PJR2F22gE6UI8gfHT5O9I492C8xDWTLryUFsGaH22+PnBEXXLFOsI90wUrAGOMvmIc0Jl5rQIwg9ls5zw4/I/zdnCD8HQqdmIvqWsFpCd5H5DCnp/jIx4RBqE6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(38100700002)(31686004)(36756003)(83380400001)(7416002)(5660300002)(82960400001)(26005)(2906002)(86362001)(2616005)(6512007)(53546011)(6506007)(6666004)(8676002)(8936002)(4326008)(31696002)(6486002)(478600001)(6636002)(316002)(66476007)(66556008)(110136005)(54906003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dktuNzZ3amVJWDFKQTlDZGw1a2VybURWbzJCSkJHTnhNQmRxbTArZzA0dXFO?=
 =?utf-8?B?NisxcVFWZE9PeldnZW44WGtEcElrM3lGNFN2S0hJakticjZZREJMTGFiY2RB?=
 =?utf-8?B?VENSbmNSSzhidVZ5N2phTHRtZzJEekhOUklrSVRBcS9ycU8wWVhrNU4wOTZD?=
 =?utf-8?B?bmZLTW1NTUpZRWtPVEZ2NzcwM0xLbndwM3FwNHVMd25NOVJHWG5JbFdUd1JC?=
 =?utf-8?B?L3l6YXRpNVgxOXI4R1RHbnMyNlp2NXFFY2JNejBER2lxOTRDSWJIVVNtckNR?=
 =?utf-8?B?dEt2Mmgrd05rSHA4aVlrT0d6NnFnQytqb1JUcS9OZXR5aDh4QjRxcVVXT3Vh?=
 =?utf-8?B?ekRHMEhkR0tyVVIvS3JXSEpNbWRhL3lkN1VkbUNZRnVydUZIY2Z1dUJpZGJw?=
 =?utf-8?B?UmdTMnI1bmlSQmJmSkI4S2I0YUNPYTZ6TWNkc2plSVcrRUxrWVVtZk1LZTg1?=
 =?utf-8?B?azhic1JEaTF1SkVZWHcvREJhNEtkcG95U2ZvUTZLK2g5ZEZVQ0pwS0RTOTB0?=
 =?utf-8?B?VlhMQjh4b3NyY3pZMGFFTEI3ejNMMjV5SVFmaDYvdDFFQlV4L1lGRkR2N3px?=
 =?utf-8?B?Wnl4ekhYV283UVVEVkdXTjJsUHM1V1NKMDMzdXV5alFaK2N1eWh0ajdtem5z?=
 =?utf-8?B?djlaK3N4VEVZdFpBUjVqVTZzczFvNGkvMW5sdlRYZEYrcnAwcXNxWUJsZFJn?=
 =?utf-8?B?QnZWZHFuZjRLZHlNU2lBUnYwYTZxSWtZeEtuZjNhVFUzWXUzSFpmYmRaWFdG?=
 =?utf-8?B?S3V2K05JQXRQZHpMUkkrMjYxSHdiT0UxZklrekpvQzNjSW93ckZiaTJMUnk4?=
 =?utf-8?B?bjlYbkdMR0luWVlCSHJOMHVVMnFwSVkvQTlUeGJ6QVY0TktyanE4UC9EbEw0?=
 =?utf-8?B?MEZCMWF2SDl2N0RTY1p5TThsMGZ4UkZJU2J1Ti9XeExLMVV6ODA2NmllMlNG?=
 =?utf-8?B?UmQ5bkloaUxNMGJ2em04dnFjT0pZNmJIUHhhcVNmQlE0Z3YxazVNeUdVd2FI?=
 =?utf-8?B?VHVmSzRYUk8xVFBNVE5jbThZbk9yL1h1NERRclJTWjliektvTFN3ZmFBVmcr?=
 =?utf-8?B?WTFxeEc1Z28wUHRiL0hLZnZxd3p3STdISkU2ZFRZZ3J0UVZUWEtjamRzekRh?=
 =?utf-8?B?a1FxT081SzMzNnRRYjh2anNoUVptc0c0OGNOZFViWFV0L2IyNDlqZU5wQm9L?=
 =?utf-8?B?UGYvNTc5cGxJbHp3V2xDMnJxUjVvMEZVRFdUcVlKRys5MWNvdmFOaXI1eVBO?=
 =?utf-8?B?Y2J3WFdtVWdqbVV3ejU2dWVsODNLNFoxK1YzQkFzWEtjNGxDN09sRHJTRzNp?=
 =?utf-8?B?MGd4UENVQ1o1a3FYRVdZQjhxUGZlMjFISWcwUXZwdVlFdXVieGRDKzVOSlpC?=
 =?utf-8?B?RmkxUW5qUm5JRkNHV1FRd1luMVpQZ3oxWWdMZ2VscFJLZHA2aCttQ3c0NHZk?=
 =?utf-8?B?b0NTdStsWE1GUUJITEh1T0pWaURGRExwMVU2SUlSRHNFZHFwNEp3Sk1xaktr?=
 =?utf-8?B?T0NlbkVGTFpCdlFxZ1hNNFdrNitmRHJYU0JmQ2FrcDh5eGZjdUt3T09wcVl2?=
 =?utf-8?B?YW1wR1ZDOGdlQk1ha0dkUzRRdExkUml0bnYxeDRCdng2WkxjQVJjbTQ3enJi?=
 =?utf-8?B?V3NIZllvVHNZSi9xb0NQYURrWDM1azUyWU5vM1FtS1I3NjdXdDNwcld4dWE0?=
 =?utf-8?B?K0I0aWFCUW8yK0tJZ2VVRklPM1o2ZmtpL284aCtQNTlPYVlQSDlZcEtGWXBY?=
 =?utf-8?B?MDZTWmlRc3YvbE90VjBVeW9TRXl5bDRjMWxwTm1jc2ZkcmIxQzQ1TVJVMHRr?=
 =?utf-8?B?NUxEQ3dZV1FvTUdxS0MrOVc2b0hnd2NUTm9MWTZMOU9icTFlL3dWaDlwVkZJ?=
 =?utf-8?B?NjFXN2xXdkxIK1RxeWpiNU92T0lUMTdNQTJVaVpzUDNubUlMdWk2bEhHQ3d2?=
 =?utf-8?B?U3pHY01kTE5nbnREK0U5M2NqYU5PUm1kdFFFZWxCbFByWXRZV2JkYjJUNFdH?=
 =?utf-8?B?U0x3S3JBT2dPZmlqV3VKZm9BNFNrWldrNForRWx3Qmd0d1ZYaUtra0twTG4r?=
 =?utf-8?B?cTNxeFBJdytJbCtsOTVyN0ZjVVVRMGhlUFdsblJ5NEFnUTNLZnVHcTNpOU9I?=
 =?utf-8?B?WFhSRHlZNmhhWWxjVnRFaU9pVkFYYU5YSTJDdEtib0liWHBYYlRDYW5Ja2d1?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a8320b-643b-4a36-b50a-08dbf00d3437
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 12:26:10.6855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSBQJJWjAaKKoJkfDyuiKzEeZarqLZu07hiboP4O24LNu3ByLd5JzlPelTJk4bwKLmkjrV+R3Dw6pe0YDEalL1HdEqifcS8ytD1NAw9cPxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5969
X-OriginatorOrg: intel.com

From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Tue, 28 Nov 2023 12:30:41 +0100

> 
> 
> On 11/28/23 11:33, Larysa Zaremba wrote:
>> On Tue, Nov 28, 2023 at 11:26:59AM +0100, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 11/27/23 19:32, Larysa Zaremba wrote:
>>>> Currently, there is no reason for data_meta to be limited to 32 bytes.
>>>> Loosen this limitation and make maximum meta size 252.
>>>
>>> First I though you made a type here with 252 bytes, but then I
>>> remembered
>>> the 4 byte alignment.
>>> I think commit message should elaborate on why 252 bytes.
>>>
>>
>> You are right, will do.
>>   
> 
> I'm looking at the code to see if metadata can be extended into area
> used by xdp_frame, such that a BPF-prog get direct memory access to this
> (which should not be allowed).  The bpf_xdp_adjust_meta() helper does
> handle this (as you/Olek also mentioned in commit msg).  A driver could
> set data_meta such that they overlap, but I guess we will categorize
> this as a driver bug.
> 
> The XDP headroom have evolved to become dynamic (commonly 192 or 256
> bytes). Thus, we cannot statically reduce metalen with sizeof(struct
> xdp_frame).  The maximum meta size 252, could be achieved (and valid) if
> a driver chooses to have more XDP headroom e.g. 288 bytes. So, I guess
> it is correct to say maximum valid meta size is 252 bytes, but can be
> limited and reduced further by drivers chosen XDP headroom and memory
> reserved by struct xdp_frame (limited in bpf_xdp_adjust_meta).

Drivers which don't provide 256 bytes of headroom for XDP are
pathological :p

Either way, as Larysa and you mentioned, the actual available headroom
is checked with adjust_meta(), so here we just make sure its size fits
into u8 meta_len of &skb_shared_info.

> 
> 
> 
>>>>
>>>> Also, modify the selftest, so test_xdp_context_error does not complain
>>>> about the unexpected success.
>>>>
>>>> v2->v3:
>>>> * Fix main patch author
>>>> * Add selftests path
>>>>
>>>> v1->v2:
>>>> * replace 'typeof(metalen)' with the actual type
>>>>
>>>> Aleksander Lobakin (1):
>>>>     net, xdp: allow metadata > 32
>>>>
>>>> Larysa Zaremba (1):
>>>>     selftests/bpf: increase invalid metadata size
>>>>
>>>>    include/linux/skbuff.h                              | 13
>>>> ++++++++-----
>>>>    include/net/xdp.h                                   |  7 ++++++-
>>>>    .../selftests/bpf/prog_tests/xdp_context_test_run.c |  4 ++--
>>>>    3 files changed, 16 insertions(+), 8 deletions(-)
>>>>

Thanks,
Olek

