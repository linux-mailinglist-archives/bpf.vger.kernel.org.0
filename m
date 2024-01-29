Return-Path: <bpf+bounces-20600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29278408AE
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D8B1C22F59
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAE9153BD2;
	Mon, 29 Jan 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQ5aMv5/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B8151CF1;
	Mon, 29 Jan 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539033; cv=fail; b=pxmGG6S04KbfKAlfSCVrAufFZYgyQ+3pMcDuXSU6U/QCTODYnzk/ey4cYJ0eyeo3GGR9WxllgMgvoEiiy3QNlLcxDyyW+fiqjqZxJkkwlO+QzDMNKUjPkJc148xU3JnewJ/m6gabcloiG0Ih6nCpE980/qORlNm8uoXNF9bzo0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539033; c=relaxed/simple;
	bh=zyyHSHJg+bH6MvfX6fOJ9jk32YgQWRG3/wxgH7kViyw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eQvYvlhyidETBzs5qYNYGmAc7mQHFf67a5NnkylwtKecmAJdLu3hVDJWmE+urjuRppSf6Mvyi0v7pRN/PpRa0nbgfs7TzBpWaOaUXqWwtE6bGVDSdD5O1idCr7jxKGaI7ORJuQ/CGoQsMBubAwkM8ki2j2BjmD8h7djOMb5EwBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQ5aMv5/; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706539032; x=1738075032;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zyyHSHJg+bH6MvfX6fOJ9jk32YgQWRG3/wxgH7kViyw=;
  b=fQ5aMv5/06tfDzWZe1WvKDmFowjWv54cc10nC6BvomBdlTX9rlfzUAF3
   2x7KxwHXe/9EJuIgtubE8pKeYjA3FN4pjBmB45wFpjcv3K4lttlYYqKIU
   mc6TC6wKcgIHTwbmWomEwmwwSDOroDlhHaKYuEqtWvtM5PQ1foTCiPXSq
   30bRTlcuiFThDnPYCYOmT9ggubBHqhtTfduHJGyEby9IY6eFCc0opPoMF
   xMNaNuX4ospVgPAO1AXFxBONZ6dTCu18L9wYsZo/XuFADlZUnl0p0R5+R
   aNIRxd1YPDrqr6bwo+Tz7snEYW6Yn7/Ea2d9Fkqou08dUGvYZaueNUvnn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2828662"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2828662"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 06:37:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="821868502"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="821868502"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 06:37:10 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 06:37:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 06:37:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 06:37:09 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 06:37:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P51YS3iBN6nDzcUn6/1UzH9UnS9CshfoSysxggEf0GN7T7xU12y5C+SjQG3M/m3J6LalE/RRwioSlUdxMVSKgvW/GcG730IDJnO+aH/iga6Q0w0jO8MhGLGCuzJ/kT9CVKemkzXJS3nwWZjGcGUX3PyBp5YkShNheWuqHAPORfwxRW7GoxDPmHii/4Qxpvx4e7vpP6A0pj51UP0ysqFavqLgCKROr3eT+joYfUzntHjcyM8wG33H+3k72QhrTQUg3XTFyTCebHzFv0fhUV78K77P724TSKpHvH6c75vmWPSHx4VxKDbapbFDsULDsKKYVssBFGgc+mLct8DLqJhyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKMFAGvmU3dGWTbFviwvOIbT/kHZu5d5W5wnQSnaJCA=;
 b=Kdtq/gJZzJSMNCi//bxB6pKUZAF1elTpgmtHCKpuQsvLoXXd70GBnpM+RW98RPSRuNbQVcv1gYh4lTHjWCqeSN97igRFgSOK1q9843CzR2PEhfjC1d52foC0xgfrApbtkrD4TqJup4JmZjp16xvmowEJyBr1Ok2Lz2d5YYIsKF08R3uTMcXF74NtsqFuEzHiw8jHNwdUJDjCxMYlLNZuynRhojm1v/gKS4sHc80tlnytCK56JtLcd3xqEpMCeMivWejJdE7/QvL8GaNfYwEDIQcwQohHM6I4zdDRqSveQ+jRmveSrGoZyC9LEm9UQMUP92BO1Zl2LfmSvgqcQhD03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 14:37:07 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:37:07 +0000
Message-ID: <6059bf0c-cfe6-41dd-8672-584c9c13b902@intel.com>
Date: Mon, 29 Jan 2024 15:36:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] dma: avoid expensive redundant calls for
 sync operations
Content-Language: en-US
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, Robin Murphy
	<robin.murphy@arm.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Alexander Duyck
	<alexanderduyck@fb.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
 <20240126135456.704351-3-aleksander.lobakin@intel.com>
 <0f6f550c-3eee-46dc-8c42-baceaa237610@arm.com>
 <7ff3cf5d-b3ff-4b52-9031-30a1cb71c0c9@intel.com>
 <0cf72c00-21d9-4f1a-be14-80336da5dff4@arm.com>
 <20240126194819.147cb4e2@meshulam.tesarici.cz>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240126194819.147cb4e2@meshulam.tesarici.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c893fd-9be4-4918-13f0-08dc20d7c491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UOv1NQCPU0ny6SWr436/oH0ZhhN3u+BnMAeyn3cH+xADUpJsWGMUJ8iwItZMdUqd+utBBzakQCwHYQUtRs5YOPy67f2WYvF9awlKcdz2F28kBFV8WNYRNIsS+AKwFNk91iplpXOaDYpi4FVlFc8p9dmylj63uAXnct/SEbJHtm1JWABxKkhQF1JiFQFVwCj2g6jaxEuC43+au0xuEV+hLnUTJxcLx7QNXUYc4DSTLv1Yf23A6oguj21UHSVEwkxyOZYCN0feJ0OANLH2MvileGPGQfvwHY1cNy863E1rXK+mIsyjDHmoTvXOtm03UdRPR6zMypZZ4xIrSY3qvbYNKRxkDWVYGkd42xhI1rjReB4iGTTbpBj9QzxN+1iMEMq1XsDmHvbaUNNtytmEgyfKwoKE05VI0fwGQLOjPSjZ3W743scVM68kI5ZAThvONbGj1qX5lpDexEuKpJ1avxTb9viHEJ19EjmEpRwPkl1W7dwaLqTZOt+xTxrgqAE/2vJPN34/Jb6s/6HlwrQNqW7n3Wz1jez1CrUsajYE/jWEWqRgIg7M3Wph2OZVlE1o8Z9Vc7S+An3OBGuAQV8RAA3hPQ5rmNokG2Pjw71+v95HOz7jvE3cv15gSA3Fn32Zvm819n9Pm/uHFGBe7rir8wYKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(31696002)(86362001)(41300700001)(36756003)(38100700002)(478600001)(6486002)(8936002)(8676002)(316002)(4326008)(54906003)(110136005)(66556008)(66476007)(26005)(66946007)(7416002)(2906002)(6506007)(53546011)(2616005)(6666004)(5660300002)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHdVbjVHMGFVaGpYM2ZKSGdjQkp4YklHaHp2ajJLeVlld0piZmFGcGsya1Av?=
 =?utf-8?B?VGRoTUhvMThLSWlMR2t4TmhIOHQrcDZEeWRMZ21YQmFRcFMrc3V2QUVYVE1u?=
 =?utf-8?B?c2xUaXJQSDNCOGlXbnBFNzIyUytsdkZ1RWx5Zkdob25Gc1NpWUMrU01RWnBt?=
 =?utf-8?B?QWpqQ0k3TWF2aWx4b0RZYWRnTEFWS0o0VFRvekZwakZaZUNNNUdBOXd2Q2M2?=
 =?utf-8?B?ck5NMkNjWm1OOCtxOUZ4NTlpeENPeUQ1ZEQwMnVxYjREMU9JUmVHU25QRmlK?=
 =?utf-8?B?TFhkaTFSNEdzUXZNZE1OT2VUUWJxVW8yOWpJalVGRmYwL29abzRQRWRHUTll?=
 =?utf-8?B?MjR5WnlvTDNwTHhrMktVN0J4NkhKQ0xScXd2ZVlLNWlRWi9HTzN5M29oRlVB?=
 =?utf-8?B?aVh5L3BuTVpMejhqaENsTHBKVXBXUjhyUytaMVdueS90eXc4U2NYTjYvMEVN?=
 =?utf-8?B?b2s0eEJJQlpIUklCbk1xeTA5QXJSck1ISlYyenhkV1JGRGs0VU40d3BWYlRu?=
 =?utf-8?B?Wmx1dlY2QzZiUW85bXF2a3NFVk1aQU43cTZTRHg3d0U0N1NuT3VLZTBxM2tB?=
 =?utf-8?B?bnRlaXFiYWJHMXJZV1ZoU252V2p5YzA1SzNRVTI1RWxiYjk1U1M3Q1I3eHYw?=
 =?utf-8?B?TThrcFJ5ejh2alFralc5c2VuV3ZSTTNERWRvUWNkZWhsM1ZCeTNIcFpvalg2?=
 =?utf-8?B?RlNDSlQ0QzJNOWxrNDdVR3EwZlhMT1AvS3J5S2NuUVNBaFROeEVzNE5KOEdv?=
 =?utf-8?B?TlNyVWUvOFhuU3Z3V0liQ1dBZ1k5Ti9ORk9OckFFSW9lZythdEV2N3NReWI5?=
 =?utf-8?B?SFIzUnZVdlhHTGN3WG9tU2lwS3YwWUltbHpyTWVsOGNqclNXbTkxYUUwc3dv?=
 =?utf-8?B?czlRQ1lPa1puSGpJNlpZWit0STViYjVmaFNVOWQ1NSthQjExTHQxbVJ5dk1M?=
 =?utf-8?B?clZobGJlbjhEYnpjRXgyN05PZFNXUFZodXRZMW1ETlozdkJaYmg4SDZrd05L?=
 =?utf-8?B?L21vTXdXNFVlNkhMdmZvT0dZcjBtYnRlZGZMaFA4cTRrRzBqYnVwT0psWHRl?=
 =?utf-8?B?SWlNQVR3akQ1TGo4K0UxakJYRmREYXVoWVNoeEQvMnl5VFRKZUFFSHpyNStp?=
 =?utf-8?B?THQwcjdUUUoreWtEZ244WGRVU3VXOUF4UldKL0gzdCtjV0hkVk5oRlVvS1V5?=
 =?utf-8?B?LzRURU1VNTJnMjFXUytxVGlycVVGUTlJVmJVaFcyb2lNVUdNVktmclJaQkRj?=
 =?utf-8?B?a2IzRVo0dWVuQXI1SmU5YkFvaVFqSHRYbHp2U29qNjBNaWJGYXkxT281RlhJ?=
 =?utf-8?B?TFZUeUVBZE56VXBwZSthRlY5NVR5bmRSTm1ZK1hLNHE2MmY0TjhVWml0ZXNr?=
 =?utf-8?B?NDVSWXJuYjZSQ2kvZEtOM3FjR3ErVFUyN21STmwxRHJnay9GTDF5UVZPWURM?=
 =?utf-8?B?ZlVPdEFCOERGUDh1QXFJcy81OCswd1BWZlNYMnduNmpEbGJPK1VUTHljbjQ1?=
 =?utf-8?B?bnRLQnFGVjBOOUtWemdJWWxpbkhtaTdlRUVPOHV1V1g1dTliV3AzSEl3bVRM?=
 =?utf-8?B?WUJvcW8wTEhzcmIrc1BIL2ZpYUtHV00zb2N3ckJhUWQ1MER6WEZOellTTXhx?=
 =?utf-8?B?NHNnZXV5Mi9ZaGZFcGpRcUVLb2FoWEpaVVkwRllLSXF0dSs1UEF1aXhKKzhP?=
 =?utf-8?B?cHBJMGpQZXlrYnMvYWJ4WkRJY2pMSW8vMVgrZm9PaHlhcDRYdjhWanlXM0U3?=
 =?utf-8?B?WnE0VnZNWWF3VGYwMElnL2dmZWtYWXJDOHhwMHFDT1FiMmtqSVlZMXI5VE1z?=
 =?utf-8?B?VXBleDBOeTlZdHJEUDhDdm9SN09QSTR5QlBTT0d2akZFSDB6WHRXNTdwcDly?=
 =?utf-8?B?WlpuVnRCREZiWjUrY01WZjJidS8xbVFpNlQ2Y3lDWW5BOU53TUd4OXViQXR5?=
 =?utf-8?B?WFpjLyttTUFBRnB2d1IwRGdOMFZnelhkV2pjOFIxcXBaYkw3VU5NdUErQ1ZQ?=
 =?utf-8?B?eEtwSWF6SVpYRU4rM0hrT0lwaERsdDNBT1gzaTFTWGNyd2tJMjJDTlpjbFUz?=
 =?utf-8?B?ckRVY2xncFBiSnR0bzI1R0NxSjVpVVBEVXpKOUo3V1BTVi9Yb01UdU9WZDV0?=
 =?utf-8?B?aDNRMHdOMDUvWVJsZXVXZFNleUxWVzBmTkJxNU12RUR5UWRyK0VSa1hLTFBR?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c893fd-9be4-4918-13f0-08dc20d7c491
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:37:06.9712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvhUxPaZqiQKYXf9hXoSK3iBJ37we4vXjScmuVuLy5Q7pHcjfpX4Vbw/Qyn/OosM5CX26QRnIkMHD1FPJM2HT2/PiEFX+OfKLZwJCpNt1Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5144
X-OriginatorOrg: intel.com

From: Petr Tesařík <petr@tesarici.cz>
Date: Fri, 26 Jan 2024 19:48:19 +0100

> On Fri, 26 Jan 2024 17:21:24 +0000
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 26/01/2024 4:45 pm, Alexander Lobakin wrote:
>>> From: Robin Murphy <robin.murphy@arm.com>
>>> Date: Fri, 26 Jan 2024 15:48:54 +0000
>>>   
>>>> On 26/01/2024 1:54 pm, Alexander Lobakin wrote:  
>>>>> From: Eric Dumazet <edumazet@google.com>
>>>>>
>>>>> Quite often, NIC devices do not need dma_sync operations on x86_64
>>>>> at least.
>>>>> Indeed, when dev_is_dma_coherent(dev) is true and
>>>>> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
>>>>> and friends do nothing.
>>>>>
>>>>> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
>>>>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
>>>>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
>>>>>
>>>>> Add dev->skip_dma_sync boolean which is set during the device
>>>>> initialization depending on the setup: dev_is_dma_coherent() for direct
>>>>> DMA, !(sync_single_for_device || sync_single_for_cpu) or positive result
>>>>> from the new callback, dma_map_ops::can_skip_sync for non-NULL DMA ops.
>>>>> Then later, if/when swiotlb is used for the first time, the flag
>>>>> is turned off, from swiotlb_tbl_map_single().  
>>>>
>>>> I think you could probably just promote the dma_uses_io_tlb flag from
>>>> SWIOTLB_DYNAMIC to a general SWIOTLB thing to serve this purpose now.  
>>>
>>> Nice catch!
>>>   
>>>>
>>>> Similarly I don't think a new op is necessary now that we have
>>>> dma_map_ops.flags. A simple static flag to indicate that sync may be> skipped under the same conditions as implied for dma-direct - i.e.
>>>> dev_is_dma_coherent(dev) && !dev->dma_use_io_tlb - seems like it ought
>>>> to suffice.  
>>>
>>> In my initial implementation, I used a new dma_map_ops flag, but then I
>>> realized different DMA ops may require or not require syncing under
>>> different conditions, not only dev_is_dma_coherent().
>>> Or am I wrong and they would always be the same?  
>>
>> I think it's safe to assume that, as with P2P support, this will only 
>> matter for dma-direct and iommu-dma for the foreseeable future, and 
>> those do currently share the same conditions as above. Thus we may as 
>> well keep things simple for now, and if anything ever does have cause to 
>> change, it can be the future's problem to keep this mechanism working as 
>> intended.
> 
> Can we have a comment that states this assumption along with the flag?
> Because when it breaks, it will keep someone cursing for days why DMA
> sometimes fails on their device before they find out it's not synced.

BTW, dma_skip_sync is set right before driver->probe(), so that if any
problematic device appears, it could easily be fixed by adding one line
to its probe callback.

> And then wondering why the code makes such silly assumptions...
> 
> My two cents
> Petr T

Thanks,
Olek

