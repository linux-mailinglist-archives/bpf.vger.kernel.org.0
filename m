Return-Path: <bpf+bounces-20599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B1E840885
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 15:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E25B24DE5
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD653152DF6;
	Mon, 29 Jan 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAU7azqg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619BC65BA7;
	Mon, 29 Jan 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538903; cv=fail; b=KieP7oE25giibuoVAgzxXFGumNc/2ruSUPMFP9elsniiUgIVKAPgmaAERaEurcxRmyJQUUjQgfd3fN6tv2Z4130q9ns2ExoBjNFeKz9yzlm6RACRC55v66jCbOgfnsG6qLWd3axpJTbqIf5g0jk9Mlntp5HMRIv8HdXUDX1cJMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538903; c=relaxed/simple;
	bh=PXmEb15lBT1oMuuzaz6EyrAllEYSieD9SVsfmposTAM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IwHH9INJZ94pRHuBWoHrMl88DW/SwXhMTDQ2c7C5lsLPRgIDQgW6TkpKrGzU4Sgqli2mVAd4Q3V3dH9LmU3iiPTBM3qQwHm26EQAVh9B3c4yLfwmzDVa7DQg/j2V4ANfdib6dojggAm0oDgg953akWqUduiknvrOutpVxkKShXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAU7azqg; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706538901; x=1738074901;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PXmEb15lBT1oMuuzaz6EyrAllEYSieD9SVsfmposTAM=;
  b=IAU7azqgVj+HDtmnitkRVIIX0UVLWMtOqiDPFQfDy6CgV1ALJpTpOcdl
   gA/338dxs6WfdaxI8Zx7cMJqQii4KtwvqLpFXE455TezWc6OP4CRThHm5
   aOYeWDj9w2B1s2TVT+hD1Hku2A4eLeAZzMcV/0S+AIrTQIzy3yG9+wBU2
   4o27zkPPRoHQwPvN6etlt6CDs5JLlbZE4YCX2XzKuxs8jLKYW2WKcpQlm
   vGC8hEA9Gd+rePVYZu52ZGfu1W6r/xwI+5TJRE0n1FkRtvIvFHSVzX0u5
   jwqeAWYyhOZj1o8Lj4KvCYXBfeTXOb6sxy2KR1r4ubpqc+ZhLYLe3F8Xk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="1896607"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="1896607"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 06:35:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="878084629"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="878084629"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 06:35:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 06:34:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 06:34:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 06:34:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq0z8MhGQJElVoVNgS7vubRcNR18zOgGHQ4eL3zXBTnJLidyACPvXcsD7lrDtzA+nCqzftSqlmNyQx26MA/7IK9A02FJD4/bKjubP6dH2taydL8YUCVIjJQGNH3vBkWT1cYTgC/2F1soSg7SXg6ZqnRgysXqKLgivW81UqQieSDo73iHa+YPBy84+RHy6DqpGuRqWtVfX9SXGDsYaBUWF+fe4lItyOaXSbe0n3kDaIIc4j/EItHShuYad7OarFblLBRSJqCq8CFAdISYjjxnnko+GmUdif8KhYJVz/xWlpWWYhOAke47S/Hf3cc6+4xuDVQS+CPyftxRgEY9l6rG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVwOixy8je0tu3qWHr6D764JcmTCkGYkEQ4bvkcR5CQ=;
 b=Wql6quz6RyBiTmpo/JECHEso7pIn8e7dtSaRXKoYCS/gncHICzA9smxd5bBZG4m1i+q+nf285qRrOXnO/eEeNfr52TWASEaTQecmAkp4YWSK4x3f0IRjtJewPZ+F1x7uBRoIOPlYFPFLcSyQ5+9olk6Tgz9HQxLOlTQ1AjN9HEzjBWrQ5ksAgxSTYqcOH1hUS9YRN6EiLUK1tonYg8czDkUeO2JCyBxiEcT9hGDT4leBwHF2UqshVM3Vm23LekH/fFU7XE6u3bjcEQF10FxwrH+YaGXEeeSSkQ3aLmI/j4Yt+PoAOzET0aB9nk/zEj4R0wv3x8UxSmeXk0WX5V0eCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB8521.namprd11.prod.outlook.com (2603:10b6:806:3ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 14:34:57 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:34:57 +0000
Message-ID: <c3e314f4-f145-472f-8321-b696e367fb08@intel.com>
Date: Mon, 29 Jan 2024 15:34:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] dma: avoid expensive redundant calls for
 sync operations
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
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
 <20240126135456.704351-3-aleksander.lobakin@intel.com>
 <0f6f550c-3eee-46dc-8c42-baceaa237610@arm.com>
 <7ff3cf5d-b3ff-4b52-9031-30a1cb71c0c9@intel.com>
 <3d9f7f89-9d62-4916-8f3f-a4aaad85a8e2@intel.com>
 <9ab3aa81-294c-4b16-a4e3-97b4fe358be8@arm.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <9ab3aa81-294c-4b16-a4e3-97b4fe358be8@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dd3d3f-4f21-4e0f-9640-08dc20d77788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9vkfU4dsP34Ur39CQIG0Sx94jQe0Rl3j1nMxrCKiDJWekkP8EqgxjBiD8eTPS+nqdQmzRgnWRnqRJ6abpnSYct34jq1BzSU4kWoERMbHZBMEsD1qiC0Qdzow3eQcQFzjRaR8i9crb9BPeOaCrmDzA00w+Ejl8MEPU5S3qcCHhLpS4IahOigZ+f30IyZwTwYcb5bnjGC3PjY36WhjgV0mltuhA2G3Qlk+A6ihUqVmapXEpvUS7xaCkI63a+6aDt4c3MGMbX37zrqFjg6mkQSju0VXQzRBYcmUNwdIZjWcTBAODMV1HcgyDIMBo9JPBQ7Ee9X+tRUcAqtCoEH0GXkp/xyA2Evc3ENzKfYHB82C19QZ1zEW9QKcPmGAKpUMeg/nDYcmgmtM9MMFcVvdguamtb5WpM/IMbSYrsggCOuFYrMNPtBD28MKTjEuFuBxhHzOzbSCZub6fjgwXXCHnMq47rIWvb3E1tmmwOyGIOl0tfbcQrM/IX4GBXcoP9fLmCamac+fW8iCy6I7PnhmifuOOQM+wEv1+wXBU3eVUhKbWiZN0dbMkv1fWRyHmjXFTJWc4n2P+gj5q4ltLACxMgn/Ke4z7sE8XTOMZ5sc3pKqnp/BiOFJ8T+y1nDCLzkik+UO4XuXj+FhgzPabdVErUlbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82960400001)(31696002)(6486002)(6666004)(478600001)(86362001)(38100700002)(53546011)(6506007)(2616005)(6512007)(4326008)(8936002)(26005)(5660300002)(7416002)(54906003)(6916009)(66556008)(316002)(66946007)(66476007)(8676002)(36756003)(2906002)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djRCRnNIZjBRTFBlOGJSZHMvR3hqUU9yZGJ1QmRMa2wxczR4NTZ5dCtGZkVz?=
 =?utf-8?B?bkZxb2Zxb29wdWpuUFVOdkxscm83Rzk5OFN1c0tTb0lqdEYwbXRHcXp4QjNJ?=
 =?utf-8?B?Q2dLcDhpajJnOTlZOExmVmwxRElodHptanRYTytQRFJtZkhFcGtVSCt1YkhV?=
 =?utf-8?B?QjUyL3RqemcvYjJNY0JMU2htZkdvNFY0M0gzdlFsWVIxWTZGQ0t1NDdjYm5t?=
 =?utf-8?B?dUh4aEZKMFpNMGgzVTNWS0dvT3IvMWRJRHhuVkhKWVpUbVdjZXRhWGpBdjBD?=
 =?utf-8?B?dmRqek9NNHEzUlB4NTFjWjNva3lKUXdMcGZ2YVBqR2lDOUF2ZDhZUSsxaUlq?=
 =?utf-8?B?U0tUS3pGM3JUQ21zOWFFWHMySVFRZC9VV1o3ck9QaDdoNkdUUVNBMnJ1OEtE?=
 =?utf-8?B?bk1HVTkxa21NT1JoNVI2Rzd3Z3NRZjFpM1VFRnIwYysrS2ZSNlA3NW5GWmg0?=
 =?utf-8?B?dWE1K1E3TjJIc25teWQ5emVnMmtmSmhLOHBRSnUyMzNDMk1acGNlS0h6RU5P?=
 =?utf-8?B?N2lQYXYxYnBTWHlRNDl1OWdRSXFxamV2dEk2T1lHZjI2S2FhN0JvQzgvRDN6?=
 =?utf-8?B?Sk9NSGJGbWRHZE9iSzE0bS82UkhWMUgycEh3dTlqbjJ3MStrUUdmT2VpYm1S?=
 =?utf-8?B?SlFTQXVBL0JxbjBvSEcvVDBMZ09WRnpyVG90Zml0aW1GUzBCZU1QU3VHOEY4?=
 =?utf-8?B?Zlk0Z25Ubk9VOVpkWWxTQzFHcjM3eHJVZlgyaHhZampJSXA2MDVCdU9tNUhC?=
 =?utf-8?B?TkxVaUozRm5TRm05WGJIaE90SU4zblNLeWViTHRVSStrVXVGWmtEWEhZOFJm?=
 =?utf-8?B?ejJNYy9VVjFrd1gxL0xPa3VwMmNMbFJyNlRpUEpnZWdzcUo5TXJzb1hwMVBk?=
 =?utf-8?B?VVpzeDVTc0IrdTFQSmdDN0MwbklkN2FVRjZlYU1pYlpRbVI5b3FXR3FLS2FB?=
 =?utf-8?B?QzZmU3NJdDUxalljN2xiTmR3SXd1c01Jdy9JWW84TkVCMjBrQndNQkk0YTVa?=
 =?utf-8?B?UFNjaC9zSmZvWlQrUDg0L09JcE41ekd0a1Q2V2dlQ0M5R1JFeUR1YVhjcGt2?=
 =?utf-8?B?V1FoNkszM2RXVWdkdzlONVBqYmVkL2c5blhwRkhsSEhnbVFvT1Uvak9kbk9E?=
 =?utf-8?B?K2VKc2Z1Nkp6KzdzbXRZZ1VmT2ZvYW45VVF6bGVFRXhBdE1pZG5BSE4vSHN6?=
 =?utf-8?B?Z2JXeVhwZ01UVnh2YzYwNjFmNmRRNFhrRk1zVTlaeEdYK1VqOENtTHdSaFA3?=
 =?utf-8?B?Q1VXU0cvWUdsSGFvRUw0V1VBcXhFKzQ3blFMLzBDdHlSdU15ODhUa2txVmk3?=
 =?utf-8?B?TnBqSFIyMHp4TkZjcW1tWjhyRkU1cUdGWDZaZUdJdFF3N28zR011Y1RaaVpl?=
 =?utf-8?B?MlprRStPNUs1S01nY3diRnRyUzh4Z1lrOWNFbmZmNTZrNzRKN3VIMjBhSXFK?=
 =?utf-8?B?aU1ydzJNdWpEalNRMnhTM01kempnNFVJUFI2WEpBUy9Nc0svMjI3ZmFCbXZy?=
 =?utf-8?B?QkcycXhXSlZScnlxWVRUWm5LRnZ6UmJEdzRXbUkxTSs2cVdnVmJ4alZFSVV1?=
 =?utf-8?B?RkJWcTJRQ3NXcFYvcVJwYVVFMXlseld6OXg1KzNLa3pKMlROKzY2K0hxK2hi?=
 =?utf-8?B?elB6d0VYZmFUQUFlS0NTeTJMVzJQVm9IcjVpZ0lUM081M2ZyOEVXVWtkQWFy?=
 =?utf-8?B?TVlXN2UvZ1E3KytQVDdDWXZpUEhkMktZR3JMOWQzWm1HSnMvUTI4MUZ0WWtN?=
 =?utf-8?B?V09KSnlkNGNyZ3lBTGdaSnZUdkFqYXpVY2dMQ043NW15cGlXQ2hCTnZjdVY3?=
 =?utf-8?B?Zzg0cE9TWXNaMFQ5Y1pKRkNSVUJscEZvWUllb1JPVlhqUlM3Nm8zaCtaRmRD?=
 =?utf-8?B?b2FJS1llTnRhZ2RpZWpwVkl4cytaMFBJZENwRUpmQ2xnakJCQzNaNDRkMHRP?=
 =?utf-8?B?aHlNK0NwL05ldmR4eFU1enJheHVyQXovTWxOMi9KQjZBQnFnRkhsL2xubGxY?=
 =?utf-8?B?bjVWUjRWSmVqNjVDc2ZyRW1aV3phbTJFWFFyRDNIQzJJZ05pVmJmNkI3T3lF?=
 =?utf-8?B?eFZtTUZGN2N2Q1VXcXcyK21QNkJWdFQvOWFWTmdoTWs3amwzYWZQRUN0a05j?=
 =?utf-8?B?NnJxRm5ERVR6dFFLK0VXakdwZzR0UDFyUE45WFRVWFZScjFHdTZiSTh2OWFQ?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dd3d3f-4f21-4e0f-9640-08dc20d77788
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:34:57.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtNKmm5XS0NtsYl0o7AcsSShSviygxmt+OEJo+MKsT9BicYlBUhSC74mPuxPIKZ/RuR5td17NIGd3zsJBRzLCIuADntGLYWClNtFmSgdbnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8521
X-OriginatorOrg: intel.com

From: Robin Murphy <robin.murphy@arm.com>
Date: Mon, 29 Jan 2024 14:29:43 +0000

> On 2024-01-29 2:07 pm, Alexander Lobakin wrote:
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Date: Fri, 26 Jan 2024 17:45:11 +0100
>>
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
>>>>> However, indirectly calling them when CONFIG_RETPOLINE=y consumes
>>>>> about
>>>>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit
>>>>> rate.
>>>>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
>>>>>
>>>>> Add dev->skip_dma_sync boolean which is set during the device
>>>>> initialization depending on the setup: dev_is_dma_coherent() for
>>>>> direct
>>>>> DMA, !(sync_single_for_device || sync_single_for_cpu) or positive
>>>>> result
>>>>> from the new callback, dma_map_ops::can_skip_sync for non-NULL DMA
>>>>> ops.
>>>>> Then later, if/when swiotlb is used for the first time, the flag
>>>>> is turned off, from swiotlb_tbl_map_single().
>>>>
>>>> I think you could probably just promote the dma_uses_io_tlb flag from
>>>> SWIOTLB_DYNAMIC to a general SWIOTLB thing to serve this purpose now.
>>>
>>> Nice catch!
>>
>> BTW, this implies such hotpath check:
>>
>>     if (dev->dma_skip_sync && !READ_ONCE(dev->dma_uses_io_tlb))
>>         // ...
>>
>> This seems less effective than just resetting dma_skip_sync on first
>> allocation.
> 
> Well, my point is not to have a dma_skip_sync at all; I'm suggesting the
> check would be:
> 
>     if (dev_is_dma_coherent(dev) && dev_uses_io_tlb(dev))
>         ...

Aaah, okay, but what about dma_map_ops?
It would then become:

	if ((!dev->dma_ops ||
	     (!dev->dma_ops->sync_single_for_device &&
	      !dev->dma_ops->sync_single_for_cpu)) ||
	     (dev->dma_ops->flags & DMA_F_SKIP_SYNC)) &&
	    dev_is_dma_coherent(dev) && !dev_uses_io_tlb(dev))
		dma_sync_ ...

Quite a lot and everything except dev_uses_io_tlb() is known at device
probing time, that's why I decided to cache the result into a new flag...

> 
> where on the platform which cares about this most, that first condition
> is a compile-time constant (and as implied, the second would want to be
> similarly wrapped for !SWIOTLB configs).
> 
> Thanks,
> Robin.

Thanks,
Olek

