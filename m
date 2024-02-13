Return-Path: <bpf+bounces-21838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0476852DB8
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 11:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49381C2231A
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA8722625;
	Tue, 13 Feb 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/9cq3wK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A560225CE;
	Tue, 13 Feb 2024 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819626; cv=fail; b=tXF85UNDD/eu/2iTm+dKcvpgXMUH3WLuB1oUf9wcjl+lmBg+EbNNvPIEI5eJ9J6mqlaPolzLtQlAIUn8oaQxpRClZNFA5/EEur99L2b/rck2+Xo/L1q873LHGgPTBgpHdfU6ik9GbW7QJHhiLMkPic00ACIb4p/Ma3Oz8T14iTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819626; c=relaxed/simple;
	bh=qJ616c38Nd/lsKFiQBhQW6QBrUSx385+W3mQTwvF7fQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OPCZjotXdupzQBpPsGSxEr5waXheu/0kCQo3GXTB4PkzYL6a4j0OLlVXbBVmj/8+TnO48YMQYHbtorReS4fVQStp13ddy01rVQsrVGRmCaYGJ2kHO+gTmWtFmn3F80bSOOi1RshjxnoB9DehozdnQZxvPGD0uIkAnWQkUZGB0Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/9cq3wK; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707819626; x=1739355626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qJ616c38Nd/lsKFiQBhQW6QBrUSx385+W3mQTwvF7fQ=;
  b=E/9cq3wKrjCOE/98kBMSdRkpueagAbm1bnm3O6c96FPvY1cL1HlTEEUy
   U699+H8O8Im7Wtfwemh97uFjTDprVLTsac7ERxHOYc9ngNuJ4j6PAlNX1
   FFcDSvJ9ccVkkJph64PZ2u4HdHzgjfKYv8rcVPxrvgHVF4na3XpOIOu4F
   Aq6/C832J2k1b3n23sBem77GbJBmGGWFVqCF7nei8s4VesgTquK4Sifxk
   /utFfNuhuTE1AcJoIjjLvdzE998q1BriI2fPwmC6FH2EzFyn9txHvI1iw
   BD7VpxZIB+2CDI08cmibALXVDM8V6GW4BIZyE+/neONGV8n3Ln7bdifrE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12371474"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="12371474"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 02:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="2774062"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 02:20:23 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 02:20:23 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 02:20:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 02:20:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 02:20:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2gc7JQXiGMLiQfd4GFVp/3c7fWS8SH+OhTjvwfVebYOi+l1gJxhKWp9FqmupQISnwsnB9E0mqyxv5SqsZtku9mAjMXjnVW/IriEwBXTiX0LnxMjHps19UiCOqdyoPIKpYlZMlxil+4vZ/aZqOwBeZOhhVHUhf3uzgwKwk1qIoSk1MkchLdFUL7LA2TglmNk72YV8B08SFEjT82R5Q1bRcooAaIJM2J0TsuRrhKeQ5G8LP0BV5bNDMM3AAf1UBRKuJ/vJVVNChVmxoBTCnaZg+KoC/4rHEDQuYkRvkcwlmA3bY2dgNr3FnES6Ln7jiQXjs5cboaZTmJM8I0XuGFNMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmW0TLoNkjSy8hjiwUtefPViVdD57EF3lP98vlimn2c=;
 b=YAfG5u07aZaNgu0oz5ZR+sVHl4LsgTz/D69IhH0iej5qvXkTL2TJGSuL1cJs3jW4lptqM+G7QWaM6hTVqivga+6hBQVrC6dCK/oV6mJ8Yx2drLoQiXB2VGLR+qGXTrRRVHhGoQdDCVXQ5LBNLnq/qq8trbJnqjqNj6KPm2CULmFgukKUGR3jQdpPbw0zHgpmxRchUd6NRNQ+IY9MaviMIa6elg8VBK8zbVmyQOMgFLl7Dtw65gOzo6yyLPCrhbq7CYn9B0hfh9K0aZrRq8SeJPn6HeXDxBbn3WrrzTdVRg/bHW0H5Pc0QUPJQPqD/QHctO4zXa0eMG2QZ1r+cp/sQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 10:20:21 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 10:20:21 +0000
Message-ID: <0812b7bf-bb66-4b0d-8615-964cb5181de9@intel.com>
Date: Tue, 13 Feb 2024 11:19:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/7] dma: avoid redundant calls for sync
 operations
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Alexander Duyck
	<alexanderduyck@fb.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240205110426.764393-1-aleksander.lobakin@intel.com>
 <20240205110426.764393-3-aleksander.lobakin@intel.com>
 <20240213061120.GC22451@lst.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240213061120.GC22451@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8fcb46-efa8-4c0d-5cc1-08dc2c7d6204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8olqO3YoNniCPgsVgcZ5gPiNaENQFXITx2L9DMsvXI3VhW+xXwkcSfiKXKvOXkhKAs5TzAsk44/cQRljP8oP6Iye5m3qCg4ac+hU+Ro03L1XzFNykDZjIVKTiya+1rOvAqSeLTxmRC74AEkOlaqgiss/DWq7l6d9I5gMlVlo5RRf5izsE5qCHlw1ovwnbdGyEWF6lt/YHOz8SqW1pB/n2K3PNFJzaY8GqhFFF617/Cp/B9Y7Hi+zbaSkY8M83KOpQD68EDqGMoIxRoAt283OEz1qSm20HyTgXZwtcATjY4RurW49Byrx/AVkvN3juXNTGfXqEvnuIVcZPo20sfPyl2tP+yQzeZXKT6cnSue0brd5X9XcvX6VJGiicpuf5+4bwX/Z38OF/xgRvryDNqzH1jCZciuINI4TMYJEWpDhBdkZypiOC/jbgxnkNOJSj/KL02YItn9rhqBxgeF7D8X3nQZ0wh6/UCCIRh5zgiDgKktsY9+wkx7VksBLJA/+hROqViexHVO3Q0Ss7SSOh5/LZykCx+VqjBagzXp2wSW6auJA7OlJgXcaNcUm5QaBTBka
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(2616005)(26005)(31686004)(2906002)(4326008)(6916009)(66476007)(66946007)(5660300002)(7416002)(8936002)(8676002)(66556008)(478600001)(316002)(6486002)(6506007)(6512007)(6666004)(54906003)(86362001)(31696002)(82960400001)(83380400001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWdrK29Od0lCWDkveTRNRGczdzBGSGtmQjhDa0lNMERSdnRFVXBTaERERW5L?=
 =?utf-8?B?VXVHbWhGOFhiZ2pXd0ljMS9CblBJV2tHY1NsTC9VeTg1TUNLakxBZ3IvdHMx?=
 =?utf-8?B?eFF6OE90d0RYWHpTZUhOZXhKcFF5VnRDMlZKOExyb3hCNmpSZmVSTkFuaGFS?=
 =?utf-8?B?UEFmWGZtdTVnbk5Db3JkdzdKYXZZMm5PSkFTR055QVVXdktoSFpNWTNKZkl2?=
 =?utf-8?B?ZzAzbGxhMnY3T0FCcnBXZ2RtanRsbW9SSVM4Mk0xKzd0YWVGczNIazhCUjJK?=
 =?utf-8?B?SXZLRFJ4eDFSUEFIeWMrQ2FKQ2RwQ0p6bXRLbTI2czVJaXhKM2tOQnRvL2ZC?=
 =?utf-8?B?cDVuZi9Ma1dYZWtMTWNmZEFlcVZuUklUU1FHVzFLREdkSzQwamtGZGFQOFE4?=
 =?utf-8?B?a2d5UEc2VnlVSE40R3hMK09lWHc2ZHpQUUwxQXkwZjJ6bkJEVDBLdkRPMG94?=
 =?utf-8?B?REh4SWtlOGpYQm1GVlpEU29XTHNLR3J1RWltdmNhd1BrVElPMk9IM0lJaU00?=
 =?utf-8?B?UWFnY3NmaVZVUWdLR3J5a2k0R3JzanFiUTNmSmkxWWxRenZUZHhBM0QyY0pq?=
 =?utf-8?B?MTRxcjdZTEVTaCszcUpzMzRKOVBpM2NSb1l5L1dPMjJ6NzNmM2F3Q0V5V2hG?=
 =?utf-8?B?ZytCMzJtN0UvaWUwQ20xNU1SekpidXVVeDZrZUVpZHByYk5lZ3lkcGYxczgr?=
 =?utf-8?B?dUVBMEVzU2pqcHhPSFUvWDdMb0tCNHZYSkN0S0tQNXYvazd2RDluYmdyRTNn?=
 =?utf-8?B?RWE0ck5tZmhlekcrNEZwR010K2JOcFlHb0lPOUlWTUJEWXFnVDNPS094OXJY?=
 =?utf-8?B?Y0hXTVNDaVZJQVJMVlp2dzNPOGlFK2FkVjRhVHY5MzlSK1RKNFI3aHoyMWpI?=
 =?utf-8?B?N21kMno1RUR0Zk9sWDRGclFIT214OUZuQkZDZFNpR1IvbG9CZWNVZlNjNmV3?=
 =?utf-8?B?SG9QZURKdHcrMlFJRXpWdm9SZUMwK2VKZlZONTZDLytCTEt4bUlhd1lHeGRU?=
 =?utf-8?B?c2paYndCMEJFcDNpMElEZDZJZENBV2trVVhRSUFyaE9HTDEwREhZZ3ZWemtR?=
 =?utf-8?B?TXQvWGkwTHFpTmc2cURQY3Bqc2NEdUFteFNzbjBRalFWYm1CT1dUNm5sYm5G?=
 =?utf-8?B?YnRpRU9HS0hQMDhGOGJrWmJhSlYzSE95TTJ1M3NwWmpWSFdXWkdmb2xwempC?=
 =?utf-8?B?Uk95VGhuZFlqa2NuS3pVc3E3VDJvLzZqVXFvenRWWDRmZWFKRFV0WnFQUVZF?=
 =?utf-8?B?ZERiK0t0VHV3OG5CQU9Qb1RXVmlFTTNZd1k3OThEb0FNeVplRmNhamdWVWdC?=
 =?utf-8?B?ZVlzWDJFMUJBU1hDOWNrQTJLSHFGMzVKdUwyMGJBZkZBNUxUUFZSSmZyZkpa?=
 =?utf-8?B?dWFJVi9RZThEOU5XMzgrMXFaYmdDalBPMi8xWWZseHpkMG1CWGNEMGNPNCtv?=
 =?utf-8?B?cXJDaGpIQlA4TXBRbnA5UHdXK1N0NlpYd3VIbnZwNktBclJhTlh0VzB6ZWZ6?=
 =?utf-8?B?MTdrRzZmbFkyUHVaL2tudithRHlhU3l6Yi92MG02Rk5pMS9ITlVhQ3I5YnlS?=
 =?utf-8?B?QjYwdmZ5WVNGZWo5WFhqZTU1T2ZDU0N1SkYwMUdDSUVEelJYMHNvRENUaGZj?=
 =?utf-8?B?Ym96K3Byd09IRUx2QzEyOFViUG1rZlNxbzdFOUZIU01vUEhoMFUwNDNOdWc0?=
 =?utf-8?B?RG02VjZucXMwelZHbHpDODM5UGlxcUw1VzNkSk9sekh3V3BuaWtXdUxZT2tQ?=
 =?utf-8?B?bFRLL1B1eWtqNWorbGpJc0h3V3hNRWVvdzJoVm91WmFJVDNlNHJPQXlCd2g1?=
 =?utf-8?B?djRKKy9weHYwSTR1cjVIbTFMemJ0WTR4bWNhNUpDTWhiSDcvMy92STBRY0hE?=
 =?utf-8?B?eXJnaG1DN3BBNEhNTjZ3bDBOejJlMk1qcXVUL05IcStTaDNteENqajJiU3pq?=
 =?utf-8?B?S1hnSW9paGM1M2ZJbXVqbC9WcGZPczk0NUlvQnNIY2xlOGxQMWlpYXJaSGpN?=
 =?utf-8?B?Rm15dExJUFZSWVN2KzBWSXhrZFFmbFNmMEJDaGorYUpXbGE1RFo5TU1ZZXQ3?=
 =?utf-8?B?ZGhDMXoyK2N5L0x4aEMxdmRFNTYvZG83Y1lVR1lwMW9GekExZ3RvbEhNcHN0?=
 =?utf-8?B?all3VDcyL1JpUm5FMVp1VFZ0MmFrMHhRandNMWtFeUR6VGFUT1g4Y2t3K0Nw?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8fcb46-efa8-4c0d-5cc1-08dc2c7d6204
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 10:20:20.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNGbyWctGP+YMnfzY1O691QPouS62RBVI+OU8EHW96edIQTalLm4pV5vRqrt13n4mue82MitC7eYiVWOjVtu4Iav+AbjiE+srkfwPP+DLhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
X-OriginatorOrg: intel.com

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 13 Feb 2024 07:11:20 +0100

> On Mon, Feb 05, 2024 at 12:04:21PM +0100, Alexander Lobakin wrote:
>> Quite often, NIC devices do not need dma_sync operations on x86_64
>> at least.
> 
> This is a fundamental property of the platform being DMA coherent,
> and devices / platforms not having addressing limitations or other
> need for bounce buffering (like all those whacky trusted platform
> schemes).  Nothing NIC-specific here.

This sentence is from the original Eric's commit message, but I'll
reword it :D

> 
>> In case some device doesn't work with the shortcut:
>> * include <linux/dma-map-ops.h> to the driver source;
>> * call dma_set_skip_sync(dev, false) at the beginning of the probe
>>   callback. This will disable the shortcut and force DMA syncs.
> 
> No, drivers should never include dma-map-ops.h.  If we have a legit
> reason for drivers to ever call it it would have to move to
> dma-mapping.h.  But I see now reason why there would be such a need.
> For now I'd suggest simply dropping this paragraph from the commit
> message.

That's why I didn't move it to dma-mapping.h -- in general, drivers
should not call it, so it would be a workaround. I added this paragraph
in v2 as a couple folks asked "what if some weird device will break with
this optimization". I can drop it anyway.

> 
>>  	if (dma_map_direct(dev, ops))
>> +		/*
>> +		 * dma_skip_sync could've been set to false on first SWIOTLB
>> +		 * buffer mapping, but @dma_addr is not necessary an SWIOTLB
>> +		 * buffer. In this case, fall back to more granular check.
>> +		 */
>>  		return dma_direct_need_sync(dev, dma_addr);
>> +
> 
> Nit: with such a long block comment adding curly braces would make the
> code a bit more readable.
> 
>> +#ifdef CONFIG_DMA_NEED_SYNC
>> +void dma_setup_skip_sync(struct device *dev)
>> +{
>> +	const struct dma_map_ops *ops = get_dma_ops(dev);
>> +	bool skip;
>> +
>> +	if (dma_map_direct(dev, ops))
>> +		/*
>> +		 * dma_skip_sync will be set to false on first SWIOTLB buffer
>> +		 * mapping, if any. During the device initialization, it's
>> +		 * enough to check only for DMA coherence.
>> +		 */
>> +		skip = dev_is_dma_coherent(dev);
>> +	else if (!ops->sync_single_for_device && !ops->sync_single_for_cpu)
>> +		/*
>> +		 * Synchronization is not possible when none of DMA sync ops
>> +		 * is set. This check precedes the below one as it disables
>> +		 * the synchronization unconditionally.
>> +		 */
>> +		skip = true;
>> +	else if (ops->flags & DMA_F_CAN_SKIP_SYNC)
>> +		/*
>> +		 * Assume that when ``DMA_F_CAN_SKIP_SYNC`` is advertised,
>> +		 * the conditions for synchronizing are the same as with
>> +		 * the direct DMA.
>> +		 */
>> +		skip = dev_is_dma_coherent(dev);
>> +	else
>> +		skip = false;
>> +
>> +	dma_set_skip_sync(dev, skip);
> 
> I'd just assign directly to dev->dma_skip_sync instead of using a
> local variable and the dma_set_skip_sync call - we are under
> ifdef CONFIG_DMA_NEED_SYNC here and thus know is is available.
> 
>> +static inline void swiotlb_disable_dma_skip_sync(struct device *dev)
>> +{
>> +	/*
>> +	 * If dma_skip_sync was set, reset it to false on first SWIOTLB buffer
>> +	 * mapping/allocation to always sync SWIOTLB buffers.
>> +	 */
>> +	if (unlikely(dma_skip_sync(dev)))
>> +		dma_set_skip_sync(dev, false);
>> +}
> 
> Nothing really swiotlb-specific here.  Also the naming is a bit odd.
> Maybe have a dma_set_skip_sync helper without the bool to enable
> skipping, and a dma_clear_skip_sync that clear the flag.  The optimization
> to first check the flag here could just move into that latter
> helper.

Sounds good!

Thanks,
Olek

