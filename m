Return-Path: <bpf+bounces-22255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D986985A3CB
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 13:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F02814EE
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA3032193;
	Mon, 19 Feb 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k15q9YEI"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E44328B1;
	Mon, 19 Feb 2024 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346970; cv=fail; b=ci96ZL+S1tuMmGbbpQHtIFyaLzV9PI1fAMb51BJJxn2bNWmFCciGbuBhzSbF0HPIQ2TX5L0ZZeMOugI8CwPLlWZVinAgZf8lzaMhV0c1vJxcF4FHA9/MdKzgP+TfqBSZOTthg3OzdJgzaHftUPmeoTYlWdot8hxCh4/Kz4U5s+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346970; c=relaxed/simple;
	bh=3QkhmzFXKe+RKkyS6WpahY8Kf+tSPVbYfQtaPXJvhvg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jhZ+iUZiuamCTgG+aUqWXpKbUPRhq0mHK8ZLtMEhmhbLZlV6sr1Mgg83j0FtRygB4MLVbi0zFL1XupIZC+1t3Jdp+RMQsrVPPtYQ978lWbbkGhEku4ZoNRX+jZ9fNGs6AWs7DG6TAGIcyMlAJyvjjxeBuUyqslA17HBTUc7gDTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k15q9YEI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708346969; x=1739882969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3QkhmzFXKe+RKkyS6WpahY8Kf+tSPVbYfQtaPXJvhvg=;
  b=k15q9YEI7kosw7e7rpUMThbtqIrA1Q4bHLnjehhqjgIGKNP6A3ZDMcrD
   bI//mIuqTo0QqKENmGWjCkwc9/LLxkFoqJz/8qf3pe/Kj0H6SjSNoCbPD
   TpZyJxUZmxE9YK2YhPAzbNKsSDpi+N8MA/OOo9vL5RpsF6X/rekhYvE/G
   X690FmO+fJ2N0SoEpWce0N2w3e0eZcLpfIMpf6xe+WqONBTj/rxaafiu+
   GWjwwb0n2SfgMwDXNTTQOtwBwSnEM6mEZDSDu/FnWpJ3VZY9W6rf1aYqO
   Aq6O4cvABG95Kxa5zcDqFJbDDtSU9i8kh5kh4yQU5n0Qu/sCcl5xTJvMY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2868449"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2868449"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:49:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9153391"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 04:49:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 04:49:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 04:49:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 04:49:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpA17MzHo8YJsWZI3eUQzlV6ucMgiIlTX0QAd0UgJwAhf3wI4GKnVRlkQFIFc3W5YPWb8POmLzl5KJZLzBc7zWdUHE7U91VvFa5w7Z0pR0cCiJkKn9y94A3XN6UUeVmuID8QGB4ttit6MKGTRc6f5CawCNSgpM2KufbvbGUUUbQe+cR1N9Yl+8jkrn3MbEoH4gpMhRXoHvR7EHTjM8CnBrtNCcXkLdqoHxvX0ztZ9JhndA2bk9nXOkc3E7iIW7GsLmOeF+kS2r9qAf/CIcdolWujom0QK1lyhaYqDxe9PYwzOjFsSLig9KM3GZLK2GVZb3QuNQmmhNKr7AF3DEcA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N0b9tGaHQhr7acJXshZm6i/t512flc91i1ogIOg89I=;
 b=bO9DrxYCp0yitLysRqZ1HeXn9vUaqTDArte2TBLFJd8VjclsNHg9rgJn+BwgDfeIlSYWhnBVyGmRcECItxB2p36/vEUduQNSeVo4WCLE7C7V4ZuQRGNzHiFgGUTrOOyPOcvlctZhJVwUQH5XWeyjWmnq3vXMRMJaVE3yMyVIJbxO/lrK1r9ETQWHdseKRmnYTToYY1PVmhvKFSAAS0IZ8di8M9U7dkGf8LBCacoi8sOEPFL+Ny0TRxI7R1zjD0tiJj6pwOQXQs/rZi36ekOP+KyT9TTjuJ8bH53w94XYjDIkUWXN1PelZWtxpiwl+ps277eB6+ts6Ip9RMEawjVhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB6937.namprd11.prod.outlook.com (2603:10b6:930:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 12:49:17 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::93d9:a6b2:cf4c:9dd2]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::93d9:a6b2:cf4c:9dd2%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 12:49:17 +0000
Message-ID: <4d2678be-e36c-4726-83a5-ae9a3a0def55@intel.com>
Date: Mon, 19 Feb 2024 13:49:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/7] dma: avoid redundant calls for sync
 operations
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Alexander Duyck
	<alexanderduyck@fb.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
 <20240214162201.4168778-3-aleksander.lobakin@intel.com>
 <3a9dd580-1977-418f-a3f3-73003dd37710@arm.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <3a9dd580-1977-418f-a3f3-73003dd37710@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:10:52::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d24e8f-dc5c-41bb-031f-08dc31492f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m9GUgYFwip3AWisQuPr4i70wkt2NL9mZBEcisXgyzmS61uI5QugHrnag+PAIqsRTX+gusZ89KABz7j2xC6bUTMpbLQvdX0W6dJwyDXg+TAdYfUViJSNQdIz1qxTg4fnbAu4zBvaKORYJTfb0N+sMOmEHfkBUcfY5QE35WcjGwZnyIaYYBhbFdASAmyBi3z+kXZHadrKJQuq6QCAWYqxtxTsktA65KfAc0l80Nip8mOiYJHr61RcKWYzwBP7EkL4dHi7hLetCJBfuR/b4VP298iR1zC3DF5LW2f6pIR9YYJeA0HJz9Kc6b9RAEmIa/ezPNWzOuoYtC2Rk8hgSRP2+Hs+DfWtT/B7rMfdYBz+bgZkKZTTX7bzSUywoysnIVlp8FP6/9Pul5YF7e+C+080xK11H28Fgh5d0G0xjAovUFzBg1p6ERlkwI83R687sBptvP2SGw4JbwrDdkYHuGy2VqC4+pc7pzpgaXMNGZY4cMXkcrqj1xIF/vKe3SvXG4XRnWjAQ6yBTTx0cnfoxNUBvpALaXmBBakN9crEhtHOGris=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cER1ZXlTNEVEazUwYUkvQTNteUZKaW5VcTZiTmluajRsZ2FZeURMZjRkdWZy?=
 =?utf-8?B?QUI4dXp6K01SYkVQQVlnSndrZmVNOThhVDFtcUJzbGl4bi9rd01SUEJBT3Qz?=
 =?utf-8?B?dTF5V0xZWm4rbnlwMEpwVnFHQ2EwNUhkNVpkeGFJM2k1ejhOVHFENWJtb1Ax?=
 =?utf-8?B?YjVmb3NJZ2V6cVRRc3dhY0Uyem1nM2JWbGxjTnhUNGxoK0hYYkZITURkT0ZK?=
 =?utf-8?B?SXRqUHZSd2RpRC9wQVFweGZNRmNmVWtFUkV2WGNQWHQ1S1ZEZWxlOEszNXZC?=
 =?utf-8?B?bU1vSzhaQTNnbnhRRm1uakZoTFdpSnZWdUJHSmVRQnRFeHdtVWRmaHdTeGhW?=
 =?utf-8?B?cklsUmNEN1p4b1VGT0dWR0pLb2wwekFTYkZpTmJKWFVTcFliaXBva2k0WGtY?=
 =?utf-8?B?RElZakY2bFNIZGJqaXpLYk9tMGtYbG5kMVRSaXJ5K3lrZU05RVhlL1dYZmVX?=
 =?utf-8?B?WlNVSmNJdzN6QUVRY05tSWcrYk9XaGU1NkY5K0NnSTdrMk5PejdoZjRHb2F6?=
 =?utf-8?B?RGpBNndRazBEVEV2Vk9ranFoSWp5NEpkWDBwSTVLckZRY1VXMUhlN3ZqNEtw?=
 =?utf-8?B?TzdoMHplTlhwRXdWbzRJQ0wwUnBCaHhoYjdBRnBoQkhMYXl0bEpYMi9ETU1i?=
 =?utf-8?B?UEcvaGpKQ1h6OWNNTVBFZ095SzQ4dUkvR2ZUY3BJVDFZYkdWcitzcXd5anFJ?=
 =?utf-8?B?a0xRS2YvZ05oR0JBd0ZlUHdhd0dkb3RRU3JWUEVYNCtTM1grbXVlWWxBMHdK?=
 =?utf-8?B?eVpxenB1WEpSZjlIbTlqMnR5R0R3SytuYVZtQ0lIQmp2S01rdWdwR1NFNDVw?=
 =?utf-8?B?RmVSVi8vTk1mVU12QjhKYWZqby9sS1NMU0Z6NmpDOWpZZ2pqZnZWdFNkbElE?=
 =?utf-8?B?U2N6UUNubFhlaWpmc1FpbExNbk1Wc3NReVpudEpMcUhVUExqaldpblArK3Bh?=
 =?utf-8?B?REQrZEE0S2dmYVMzSWlhSWpjdFR4TzBEd25RaHBUQUc4NjRKTGtyditKSnc4?=
 =?utf-8?B?RWRuREZ6cnp4TmlmbFFSYWRLSXVHd254b2hEUGphVlJjcko5K1d6N21hY21K?=
 =?utf-8?B?S1FLak9CYmFRMG1wUjBVekhJYXhRMGE5M1psZGcwR2svZnMwQmg3Rkc3QzAx?=
 =?utf-8?B?T2dGZWc1bjgzc1dLQmxwZnI4RWttaEcwMDRGUkc3MDNFbkpOTDFLSFNkR0lh?=
 =?utf-8?B?RWsxVmxTcC9GQkhQZUR6MElhSHlaVk1TVThWM3N2T3RHREZ2Zlp3SFNNV1V5?=
 =?utf-8?B?Nks5c2JNdVpLdGVPNXg3Y3FNbmd3c044QlJkcU82TFJpaFdYb1cyVE5sUVRo?=
 =?utf-8?B?OExKL1VpSGhDcG8wUFFGeFI0UUZaM2ZtN3c1QnZrVmxraFBRVHlZby9TM2dN?=
 =?utf-8?B?d0UwZTBjbG5mYWtpSm94RVJxc2w4bkZHV1NDNk5iWTZRaWFJVUhyS0U0TkJs?=
 =?utf-8?B?d21qOVRzUng3VVFuM3grYWJOVC9zVzRocnRLcGlDbjNONFV5djZpTENaUlJu?=
 =?utf-8?B?M0pMMDVEcVIyMnYzZzd0SEtEeTYwVkpXTG50ZmFKQjRJNkNBdEZRRmlYVlFn?=
 =?utf-8?B?NGZLSWZ4Zmtjb2sySDQreDZjaXpwOVZHZ2ZxaVlBdXJpRmNOMUVFdTBoTURU?=
 =?utf-8?B?cW1kWE0zQmlRU2NhQ0NTUlMyMlZYRlpYbkVhb3dKQjFXVUVuSWxlRjFTd2xQ?=
 =?utf-8?B?a1Q5cVp1R3FoS2FPMmdueUZSZ3MzVEFSd2cybmlvakx5TUkzRGl1VW9GOS94?=
 =?utf-8?B?ZGpTdzdnYzlKdEk4MDNDRUJvZXVqZDV1YkFiWFlQSUNWYUdHZTNCRXpYNGZi?=
 =?utf-8?B?TTh0bEtSQnJIWGpvKy9qQTZIY2R3RWtxcThwNFlWYklKdDFaZmlKQ0l4Z3NP?=
 =?utf-8?B?a2RzQUl3Ulg3cHk4dHljMjVOcVVYQldvRGNjdTE1WHFQamdiZTVmSjBFYmxC?=
 =?utf-8?B?UCtjaTNTdEFibW5iQWJxa2dVOXJaSnFGK2szOGd6RG1Gd3FyQm9qNmUxNG8v?=
 =?utf-8?B?KzN3RWRDYUdiSlEwZ1pENHNScGQveDlpSEVYSnkyaUNzQjY2MWR1d0lGcWkz?=
 =?utf-8?B?QnNwSW9ZVHRqVzg2NXlsRExzQkkrTlk4MjVaRWRLZGpZUXJRU1Q1cGl2OEkx?=
 =?utf-8?B?YzhTRWJZcTV6d3B0K0RLYmJyWm16OFVydDF2TmlPdmFIUml5S1ZyUDgxeXdB?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d24e8f-dc5c-41bb-031f-08dc31492f3a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:49:17.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMLJfA2WHKZH/T5nc6m6ZC/L/FOYX+RR9MHuHYAIomowJvf5YBH4yfnKDPHDLjfa/r+lOpfOsTDBsfsSVns5QIoc+I0GIFe7/bFKhekqYrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937
X-OriginatorOrg: intel.com

From: Robin Murphy <robin.murphy@arm.com>
Date: Wed, 14 Feb 2024 17:55:23 +0000

> On 2024-02-14 4:21 pm, Alexander Lobakin wrote:

[...]

>> +        /*
>> +         * Synchronization is not possible when none of DMA sync ops
>> +         * is set. This check precedes the below one as it disables
>> +         * the synchronization unconditionally.
>> +         */
>> +        dev->dma_skip_sync = true;
>> +    else if (ops->flags & DMA_F_CAN_SKIP_SYNC)
> 
> Personally I'd combine this into the dma-direct condition.

Please read the code comment a couple lines above :D

> 
>> +        /*
>> +         * Assume that when ``DMA_F_CAN_SKIP_SYNC`` is advertised,
>> +         * the conditions for synchronizing are the same as with
>> +         * the direct DMA.
>> +         */
>> +        dev->dma_skip_sync = dev_is_dma_coherent(dev);
>> +    else
>> +        dev->dma_skip_sync = false;
>> +}
>> +#endif /* CONFIG_DMA_NEED_SYNC */

[...]

Thanks,
Olek

