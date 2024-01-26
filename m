Return-Path: <bpf+bounces-20409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6983683DF16
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 17:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE537280F6F
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 16:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D90E1DFC5;
	Fri, 26 Jan 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCaT0jML"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C241DA32;
	Fri, 26 Jan 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287526; cv=fail; b=K9YD+/l+cn2cu3ScnBlNnBU9YTzfx3Kv33WC7Hwkgzy672hhqoG19ODBfHhKOP9B+1b4tcH6/S4tI/P9YRqHoffN/h/f8B1/FsMDuhRmYCYRWA0JcGFyS7TqQ7ZCxeWzOTVbetFnniNK+smkzHftK8ir0nmgi+zbPcIwOVdUl6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287526; c=relaxed/simple;
	bh=csnxOkAFsxeXVIzy5BiaiZ1yUFymu0Mh7a5U6jp0t/4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0VQRdHK9UbJcTCSvrThNEKkDNKRrebCJN7YuCcjS7qeG4fALh24VMXM/RGjFL6K7yozat/RfG6JgXMsdUisJNNo6bkNNhlZvCTBJdRMgYCAVBkqj6e3BBNf3aFdzfRNJLWxgF/BmQS0EyBeIMLlx2KtNlv10D1lrPgbzcokgAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCaT0jML; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706287524; x=1737823524;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=csnxOkAFsxeXVIzy5BiaiZ1yUFymu0Mh7a5U6jp0t/4=;
  b=iCaT0jMLGEGq+54ChVe1WLl1jgTGcaySsnmOiiYyonIJbK/0qZ6xUvia
   jsqwDvbWSv6u3ww0FXbKpnY2ZgYe7fsTlVLiSNH5YaQWR4Dv+9d6tDplA
   YFtC0gZXhlFxpHLMKgWdkGsZkS8+XCXFo3hixXwkNQmzh+XKBeH7eYQA9
   1LDODLeOy9GkRThKsIbi6neFoRtcBw3yHvyTzjiJkVrI7t6JFa9Q1wybu
   VEXsE01BxfKOPj7iC9HDxDzMNsitCP9QvsCwhaE9XMByrGdfIEVP52kHa
   OUSlXE52J+o+p30TMkHqqK29LygGjW+Yt9k4ZTIeGb/2Zy7YpPiIU3qPf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="402170836"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="402170836"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 08:45:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2702648"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 08:45:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 08:45:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 08:45:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 08:45:21 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 08:45:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZekSk0O5YLcqYoTVtm2r/6cwLsgYvS+tstjH1UaeDGg1M4xcP6+avTScc3zZyamOhkEcmDZAUN5fDEfiFqFiUyAQS7wrFeBWjS0Q18+3Wvc8vkTaiXlo2/j5DKkbTj5yojeJtuZOQiHi3mqH/DRqqCYAzAMpoIOk4mI2mP+nhqNzBEANuFcNJsxe048vZtXOEx6G8hg21Fg+n6n+fODCfyloeOtB/9E6ne6Pz8ch2zmWajgzFAI28AWoc9Rl9Iht1X4zLvzH/ggCvXeUwUDBBAxKlJ7lo9wtmYrBHdHG/MVbUwCSW45Du4CJzOHgdFHJHcojpq0dsLcTKNL9PZtBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVRdgb5FYIcWK1Vw6hpinZrTS1r9D3kl+7TuIEcn+EM=;
 b=YTK1PKAqDUu4B9OL1gayklByz+2NnX+886izmwI2Td6zMBsT+D4Cyqv1RgKQf3+r7cdgOiPomcIm5/hUmHGfc3boUDdVjcr/Q1vfUa5ZwYjzPOihvvcfSn5EiAk4HmkPyMMesQwdL98J2nV9mGVNIza/LNGuSmseN3Hl1BrIHgWGZ66jTA/06C0x06HujzZWg18ZfeB10QjOn83p/GmLOkrrRtONCQoVE6F73LaK7amz1ZsJ9Ju+XfOL+0bW4E2wEcM0ZIHLgZ8/kUOqHHKowqdk5AMoqqxITY/WOwPh5JBTB3cX0+h0V8Zmvfn/4QGbMWd1wFPGYyelUo9kYmbuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB5918.namprd11.prod.outlook.com (2603:10b6:a03:42c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 16:45:19 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 16:45:19 +0000
Message-ID: <7ff3cf5d-b3ff-4b52-9031-30a1cb71c0c9@intel.com>
Date: Fri, 26 Jan 2024 17:45:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] dma: avoid expensive redundant calls for
 sync operations
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
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
 <20240126135456.704351-3-aleksander.lobakin@intel.com>
 <0f6f550c-3eee-46dc-8c42-baceaa237610@arm.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <0f6f550c-3eee-46dc-8c42-baceaa237610@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 192237bd-7d4d-4057-ebf2-08dc1e8e2e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZVGPNQyqtbXWa/OdcuZeHgWn1qrmr1SfLTkEBP/o4Kam2b76dlt7ZiHrvmFEqo0qPWDqkzy6N950DaIbMswTBGxyO6s3R/2tjB98cD+YJgbF2whRepzNOZZIINb244f3C2v2MyO6tN8F+D74BWoxLbptYTbXEwfTd+A4TY/tawsQghuzIPMyGcMWKcJfdv0+ushkiXH0esIxELGt1kfuwA3qCkmjvcjWzcSwpBv2QCVRt+N3rpnpIB+BnwfLzj38z3glY9ciJFPqTClqy4yKv6zUOTOJ1jskFBL/jP/MarGC+pcU6nPqDNvKFfOYdrafjT7OfC1rA8OdfiwxvkZV9HlwNindkexmLVVXu1Gr1Akt7BmYNAgL7DVsy+tw2ot0kb/KleqdmlA72D2fJp+OwkbAxeY1ecwreCdrnEkIMv+rAppFdkL8ujQoeW+M4BIN50kRLwG35h6BdYqmr6n+KRjjQp0R8dBDbNwOkld0MOJiKQLhV4yZhW8+BibZVnVEeD5I37l33zPD9GE4Z3JTFKiVS/hjQaWrchTZiN6qTuvo0Vz3Qafp+u3WjiNL9tqECsSSbIGoAGTxD7mi67BYsAgtGn3OFfxGhTJo99ZGW+kcvB2voE4J6EbKQgSwV/h+f+iT0AzoYSbYa7iAwg9xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(54906003)(38100700002)(82960400001)(31686004)(6506007)(6916009)(66556008)(66946007)(478600001)(53546011)(66476007)(316002)(8676002)(41300700001)(6512007)(8936002)(26005)(31696002)(2616005)(86362001)(6486002)(6666004)(2906002)(5660300002)(4326008)(7416002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N09ObXFOdzFyak9XamVqMmR2dHl6VmZkWVlEQkpPWnkzdkhHa29ybDI2SVU4?=
 =?utf-8?B?dHJEWTVzZktxcSsrUm5QZGJCVGs0TUxoM2xDS1VoUmhWNlR5YytVeWt4cXB3?=
 =?utf-8?B?a29HSDcxaVBqdmxtN2VYV1JBeURib2t0MFByL3c4ck90UWR1YlU4UUp4cnZn?=
 =?utf-8?B?ZGV1RXM1d2Y5RURFZ2lUVW9maTFxc1ZFTUVpdHhYMFZlVCtXZFljQ3Jra1VV?=
 =?utf-8?B?MDM0MmtXSElWbllOb2pKN3lBeHVNYlJzak1TSElHU09IWEJWc2ErSFZLMDhl?=
 =?utf-8?B?bVhPNUxLOG5NYmdGVGVnYk9ZMWdsL3ZlUlpqbUpHUktWdWcvU2llSFlBdnFV?=
 =?utf-8?B?eHI1Vm40T1QrTkZOejBOMStDMmk3Q0UrMUI5T0svZHhiZ1JxVEZSblRPWWYz?=
 =?utf-8?B?UDJpS2x6TnRVcFJtWmJRd3IrQnE0OUgva2JtSjExQkxPT3NZbmtrTUt5V0Ey?=
 =?utf-8?B?SXpxL216V281dVAzU0NjSUptYzRqYjRDSjVvSlJQN3dSSjlSVFVnTVZpdkh1?=
 =?utf-8?B?Slc0bUZneTAxcWg4M2JhQjVSdFpsZXd4UmdSQllWcEN2dDNuT01BaUdObFlv?=
 =?utf-8?B?eitvQzUxOTNyOHFxNlFxeGhiVDY4VERQbVV2VGdaSExhYURUQlhlRnVWTUp3?=
 =?utf-8?B?dDRQKzRMcUhGS3d1SW50MExnRFlSU3kzQThhT2VNL2VZenA2ei9TcnZmc1cw?=
 =?utf-8?B?RWt5RHluZWxhcXUyOE93b3IzVTloSExkcXZWZVFGREpkR01VRUk0YzExekV3?=
 =?utf-8?B?cmpIU3EwbjNiS01MTisvV3JQbGNDUlNhbXlhaFZCSVJuN1E3bENJL1JZNGti?=
 =?utf-8?B?aGpaaTd1QTVhbVV2SHdTaFA5R0lFNUNSNFB0M0EranVvYWxyS1QrVWF0dnpn?=
 =?utf-8?B?U0g1NUNKaldGcWtRQjc4b2htWlZ0SDhRL1NSbUZoNWJ4eTBtS0VTYWpMbE16?=
 =?utf-8?B?dkJ2NUpoVHVJRFhBWVYzM3pQa1RVb21MQ0tNeVZZM0JYblY2TlpUcG56L2lX?=
 =?utf-8?B?aEV0azJEanQ3c0NzV2I3ZEhHYWQ3RmM4TXNQVGo3U0dUR1BnNDVJV05LcVJV?=
 =?utf-8?B?UHpnQldtc2hDeVozV2tWS1Nxa3JiWEdwcmRCOFAzN1E5RWd2cmh4N29iNVZL?=
 =?utf-8?B?bjdvTUJuMys2d1V6OGZ3TGcrTWJJUTFKQWtYU1BHbEgwY1Z5OS9hWEs4K3Vu?=
 =?utf-8?B?K0VFenNVSVJFL1lRVzdmUVRxVzhwckY4UEE4V2VSUmpHYlpRYTN0UVloMWk0?=
 =?utf-8?B?dnZtMWJhVXpUa0E1bkZldi80cDJPYnZBSkh1bnNFaE1STEZMb2RMaTZKQjNi?=
 =?utf-8?B?eWJjRSs4T1NHQU1sakYxYnZ3ME9kQUF0M25zeWN6aWtHNjVHMytMSW5JNWN6?=
 =?utf-8?B?YjhiUkR4K3N6dEJHNFl3aDRkNWxVYkJuK1VpajBDNENpNTNNNkJtTHdzRTBW?=
 =?utf-8?B?Mi8rSTEwUGVPaU5QVFJHYytRVUdWQ1YxNG96cENHNHNXd2RtWVFjaitRR1hk?=
 =?utf-8?B?QXJ0NEpYZ2ZpY1JzODN6dzdORjVIK2dLOVdsSFgzVEZqQmdvS1BRcHlPS01i?=
 =?utf-8?B?eEFoWkFzb3RqMXUzeHNOWXlLZGNOSjB6U1B1YkZZb1E2dTdXVmRYeFprd2pr?=
 =?utf-8?B?dytYWFRJNEpkQ3RvVUxTL0J6ZjE5eCtINmplNHNrMGFQcEhUc1VTMUdTdEFC?=
 =?utf-8?B?Y1R1Qk1HY3BDbjRxTVNNTWl1NEhOenFjR2FFbEQyRzFPTzRCbjE4cGo2NE9W?=
 =?utf-8?B?RTRqR1ZTRGExYzRBZy9LRGw4UFJKVjQzVW9DTlBSQTRHemdxTDJJSGRjcWZ1?=
 =?utf-8?B?R0lDRFNEU0FXYnZQbUg4WXpKcVkrVkN0NXVKZDJKNWk3Zm1pSmNHc2pKcCtJ?=
 =?utf-8?B?Z0tlbEdSOWJ0SEZ6K2dOVmhwSzBrYXQ0VGJKT1VKWFNFUXBwT1F4ZjhLNzg3?=
 =?utf-8?B?L21SRXZtbWNuc2xrS1ZiZW0xNlovYzVDMmNGQnpnL3NaMzM3eERkczhhaFNj?=
 =?utf-8?B?ek5TbFhBMWNVZmN0YzhXWWpvWStTMW1lVzQ0T1ppcVY5bmN1M1Z5cG91UWxm?=
 =?utf-8?B?djVNNU0wRmZxc0xScU5lREt3L1F3L0kxZ3RuZ1ArVmUzMkwwVm5walBsdzlp?=
 =?utf-8?B?Yk1aSE1qYmhUUzNoTzdtS0I2cjFzZWxERGc1amhna2ZRaXFpM1pOQkdZekYr?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 192237bd-7d4d-4057-ebf2-08dc1e8e2e55
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 16:45:19.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDD6rduNondL+j6BmlsfBOPHXB+CWMsUueaW++my07KaOlmKzOikXI6I4fo+8IejDViwgHG8xlbY8ihhgEJ4O/z4h017ZBgLNlKBT0MkHPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5918
X-OriginatorOrg: intel.com

From: Robin Murphy <robin.murphy@arm.com>
Date: Fri, 26 Jan 2024 15:48:54 +0000

> On 26/01/2024 1:54 pm, Alexander Lobakin wrote:
>> From: Eric Dumazet <edumazet@google.com>
>>
>> Quite often, NIC devices do not need dma_sync operations on x86_64
>> at least.
>> Indeed, when dev_is_dma_coherent(dev) is true and
>> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
>> and friends do nothing.
>>
>> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
>>
>> Add dev->skip_dma_sync boolean which is set during the device
>> initialization depending on the setup: dev_is_dma_coherent() for direct
>> DMA, !(sync_single_for_device || sync_single_for_cpu) or positive result
>> from the new callback, dma_map_ops::can_skip_sync for non-NULL DMA ops.
>> Then later, if/when swiotlb is used for the first time, the flag
>> is turned off, from swiotlb_tbl_map_single().
> 
> I think you could probably just promote the dma_uses_io_tlb flag from
> SWIOTLB_DYNAMIC to a general SWIOTLB thing to serve this purpose now.

Nice catch!

> 
> Similarly I don't think a new op is necessary now that we have
> dma_map_ops.flags. A simple static flag to indicate that sync may be> skipped under the same conditions as implied for dma-direct - i.e.
> dev_is_dma_coherent(dev) && !dev->dma_use_io_tlb - seems like it ought
> to suffice.

In my initial implementation, I used a new dma_map_ops flag, but then I
realized different DMA ops may require or not require syncing under
different conditions, not only dev_is_dma_coherent().
Or am I wrong and they would always be the same?

> 
> Thanks,
> Robin.

Thanks,
Olek

