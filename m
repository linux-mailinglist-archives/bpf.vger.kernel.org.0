Return-Path: <bpf+bounces-10054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F028D7A0AFA
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30101F24AC2
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC2241E8;
	Thu, 14 Sep 2023 16:39:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41431C8F3;
	Thu, 14 Sep 2023 16:39:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6C1FDC;
	Thu, 14 Sep 2023 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694709551; x=1726245551;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2TTZEnfjEl7Mv9fnKuQlClWnIYsaGEpyUg+ZjAa42y8=;
  b=nDqMc6sVxEw5VAuRNRRkZWtu38F4eJopOiuakEdjXL064bOTX9XtyGJm
   Pl4aH8t3URrP9G8CU5yghJDZ/bzYvhi4gJ3xZpMDCjj0SVWaui8feLNkC
   85hKbLAyblIVMHhwUwIdNyI6ivNL2yP7R/LdOOostZeLibVeTteXq+uWl
   oOgipoZEJpDHrRR4QoVvLRue38rZ39JbWJUy/QyitklrWSe1t+/1VOhm5
   v+nUqnsY6OUhVDu7+yGUFYKcLPJ/g6/Cgijhxq0ZuHgkbd12Wt/gvtvlN
   ZrlpIMsvxnhsh6RWBISpclBS8xWqOXWFOI8OaJhOGkXoTaMJBwe7DIsR+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="409950596"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="409950596"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="1075460512"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="1075460512"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:39:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:39:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:39:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:39:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:39:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu28g94ty14RIW5rUucBZSImBbUU8V62v7dOaKW1PscSLdbAMaPNQrppBzgwz9hxieE+PmxwO6U4uAtOCRgW+Lfr5QQNPP4RovopXj/ZddEhBcbkBtK6QYr4+4u6PSI/R3KGUXcWDlNKtXWvDZ2qwXrxC30uj5DOGY9BM2OL59WLVNaezax6GCMAFvKvAee3q5v/8nEg7D3eKRRnoB2ClWUjPKJUsqSMaQyHmJ3gDkYdhrbijGaVoieg+QAIopRkDriEcgFQKXpDhVYYs/AFao5ed2FIKV8al5Vo6ogydMSVOsJjV+F6IG04CEBQkLKjnzWovwPI1j7jv+hghhP+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvfmi/vZKyj79hQRucxX+pt/64q9H6Bf1A40iFyubSk=;
 b=dIw/huCv32mPGKwqpmevFe9C/ktk5XTcUbvF7MjoRWp3Q6SOI1jnwyocb905ZPMT0JD+FpwJ0kzYzMNcJe4dVeF7jefE7s+EuwZyxLVJuTxpIEWR5DE78RsD/0pVDm+TuCmxu9QQiRMEF00bnmDyMhNWyRLmL/lOxCEeyXRsyvuA/kcgvkzq85gTULNZqNAtdjuy4A3MvcXO7YWjj04WFaB3sOvEZpm54awIqGjjIWKFlhQEbw3/dethzTm5CboYuoOBSoywaNC5U8H82rS/q0sVCUYRmTgMMuVMvhfhWdhSkjYDxTFbPl7pBdAFDrWINOzmRsG9ljklfozbvqs4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 16:38:59 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:38:59 +0000
Message-ID: <3f8f0fd8-b75c-5666-797b-315ebb632ca2@intel.com>
Date: Thu, 14 Sep 2023 18:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [xdp-hints] [RFC bpf-next 10/23] ice: Implement VLAN tag hint
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-11-larysa.zaremba@intel.com>
 <0abb29d7-fcad-c014-ea06-c7ec9460245e@intel.com> <ZQM0lzXSsseZTmOy@lincoln>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZQM0lzXSsseZTmOy@lincoln>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0417.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4e1b88-835b-41d8-0f03-08dbb541187b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L82pafZ4qRQzDcLrG9x3Z24QQKpnXWbRZ/pLu2IbyxG1EC/XHiPUC44iVLTSHNcPiOod4qbCNJGjZRGL+NQPvrXIHouRPbDeH8Zo99yxSzRcYzoX2blQqO+P679/Pq/ZoHdviKIkZeJn+5Sey2bSyT+ZRxAV8TT/p44y+nGhGxFwgW0oHBmUQ+UvEiyjoZU9MLQIRg04cUbAPg/j055/adlfRCXMpy+JmxjLsS1BIwGxv98c7Q/BTY2ZI5a+vPX+GP8bwjqdAVRu3PCL7bBuuwSFoHo4XXhFsjPt1I99tb5vYkqEqSf3F4QUc+m5p3DDDbnOSnXxhj/vFpQfwIJ44ECyVHTZnIMjP9uc62a9/jcIdZYKCvBV6NMDUQMmUSJvQZx/U0tD+qW8jXb4QbVMt7WsnsDe8ZqWXtwvrV2dak+lrz3rLr0odMCjJqna8oahK3IW7oOtrIDtpxvWcBBadndNxgYwqjILDmcoo7BrqzZ/UoGSAaSntCmw0V96QplfXTvEGT6mFDSEkb/hLnUc3OQnrq7GIwhNezH0j2tu73w6KS3txX67K/KMpe5LGp8qSdaBGnY/U+LrNEb+LTNvBFPRTDLLOXiLG1phgKFt1zZH988OkeC4jD8ntGjlo/pQ+cwzRdEePuNJqqNLz4D4VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199024)(186009)(1800799009)(66946007)(5660300002)(6506007)(4326008)(6486002)(66556008)(316002)(41300700001)(54906003)(6636002)(66476007)(37006003)(31686004)(6862004)(6512007)(2906002)(8676002)(478600001)(7416002)(6666004)(2616005)(26005)(8936002)(82960400001)(38100700002)(31696002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEJZNEkzRzUvKytWSWVyMkQxTXNXQkRnblVpSEtKOFhSNXQxaVU0OFEwTUVF?=
 =?utf-8?B?bTJqWXZ3SHpqZUFoWjlyWk1NTCtiYnZ5Ri9pcEluUnloRHJLb2xZUTQwZm9D?=
 =?utf-8?B?dElUa0Z1ZXpkU0NNVjM4bEJPMzF6d09CYW5ITzF6SEVxK0ZwQUMvYUFMeDE5?=
 =?utf-8?B?SFR5V3ljRFl4QVZyNCtPWENGcnNid1d1TGhNNjFMOXUrRThWMFBlRVFlY2Uz?=
 =?utf-8?B?SUFCSmh5d1o3amJ1U0JOaWEwL3B2UXFHdVBUVW1NbjBmY3l3VzhjbGNUc0RR?=
 =?utf-8?B?Rk9BbVk5T1JRVmNrRjdjRnRtQUNMSFY5eU5BV3hLSVZNZUVsVHcwVWdITXJi?=
 =?utf-8?B?RXpYR2JrbDlDQjFnTng2c3pCN2lGd2NpMk1SYnVnOFJBaXA2SVVGRll3MFNp?=
 =?utf-8?B?T1Vvbkg5Y3BUUEJ2aHgxTGJDVVhoZnhVdEs5VmorVlAvd0t4WFZtSHY5L1E5?=
 =?utf-8?B?bjl3ejNYQWFUZGVvSW4zWTRBWi9DQXFNMXdjczNpYW5kOUU3eHUvMFM5MFN5?=
 =?utf-8?B?T3ZIME5NQ1p2QVM5ZzdVZXpVVWN1S2VxRXpSc0dMbGM2aXVON3VmV0l2UGdy?=
 =?utf-8?B?a1EvcVZ6OWF5RXFTZEt1VkFjODllOUNiaHRkNW4zUnJ1WmQwNHJlakRtaHlM?=
 =?utf-8?B?UWxMRXFpV0dwb3IxZ3JBTWtKR0FKTXQ3UEJLMFZkaFg5SVNGNVpueGcxY3NF?=
 =?utf-8?B?bnNtYkNhZW05R2VjT3lDTVphT0laUzRNQTk2b1lOYlBoVHJtOWl3dVVRa2lu?=
 =?utf-8?B?dlcwcEN5clhYUzE3eHhEZXI2MEZtbWxsTVdiVVU3TisvNTBnNUI2ajdwYno5?=
 =?utf-8?B?MHRRQUZSbkcxdnBSeHdDZVVGam5ZUDFURllPNnVjcE10RVBycGlJc0x3dXVr?=
 =?utf-8?B?T1BNR3poQ1MzZVNtckRFK0EweUo2Qzg3ZkVhSDdsdHZrNFhveVRKWDhDVGph?=
 =?utf-8?B?Ky81cHpSUDlxb3N1Q25WWk9VNmlmZWN5Tm11WG9BVml1eEJWNy9JektlNnl2?=
 =?utf-8?B?b2Y3eW5wRkw2Q3RZUXU1OFFVOVh4aHdKck1OV2xLejR1V3FGRUtaU2IxM2Y3?=
 =?utf-8?B?S2NYWW9qVjYzOFJ6b0w3d3lWcWRLVGJoQS9aUVRyR3haVTJpeVQwUFlTMklN?=
 =?utf-8?B?WktRSHpKVFZBZ0M1bEwzLzBTUm54ZnVzSHBxOTV1TDNGdjJhV0xSZnlTRG44?=
 =?utf-8?B?ZkEzQWt4YXA5TEkyTlVJT0s5b2V1Q09YeGRvV0hyQldwNHlRZmZSOW9Bcmxv?=
 =?utf-8?B?SzFsa2VUa1lMVEYzUlhFMjk3VlJMUm5vTi80ajVEZG8wd3ZqV2JQU0VxV2dq?=
 =?utf-8?B?SWJCM0RpdW1BNmRVeVgvSklGQzdYR1d6eWRZY052cWRRejdSRkNNR1Axenkz?=
 =?utf-8?B?OXd2OG5GT2VWZmZqL28rc0tPaUZjdTJWR0FXN0tHalZVbnUwK0JKMVFPQ1Bu?=
 =?utf-8?B?K1crbWszdFI1MEVtUDZHY001UUF3U3RyZFhKY0RHNnF6VldxaWlrMzYvMVhw?=
 =?utf-8?B?eWRsVlo3bmZQeVNFNTByWExRVXluaFVkak82RmVjdUptYUQyOFRBYUZBeEFx?=
 =?utf-8?B?UlYvUFROMmJXV21kZFVpRERrL2xYWUNMbHloZGRKbk9hNS92ZXg5em9CYjBN?=
 =?utf-8?B?dHMrSTRZVmo2L01kVU4wTEZxbVZQOWRoS1hyQVB3aXRGZkhuSTFXLzBTWEJ3?=
 =?utf-8?B?Z09SdFVWcnpYYzFNdFdmZG9rWGdleWVsZUR0aWZHSWd3Y2hWQlZQWTNEd01I?=
 =?utf-8?B?MDgxNGkwODRXZkd5SUdLaUx2Z0RlbzNGT2R4VlBZQit4anVZOWpkTTV3R1NJ?=
 =?utf-8?B?RXVESURMZVBDc0Z6bDNyUDN3RmtHbnFCTGowTU9scnJtWUpuZ1huMVM0bHBz?=
 =?utf-8?B?cHNRTGthb2hsODc1U0ZDZWl0RVY5dVMwVk85NzhDZmdJRmxMVDI3MFBXNTd1?=
 =?utf-8?B?aWYzd1BaV1hpdVBvZE42UWY1QUhFRHBwZXYvR1hLMXpHRHMwY0VqZHVTckFI?=
 =?utf-8?B?S3pxbFRxVXlVTDdjNXE1ZEVYMTVEazFwb1lSSHBBMVFLajFORDVBR1k3Ymt1?=
 =?utf-8?B?a3h0SXY0VzMzajExd29yWVN3cWc2NW9uYjExM0lEbGhORTZENEZybHlWYTRF?=
 =?utf-8?B?UC9kemE3SVdqM3JDT2YxdW92QWtxdHBoVWROTTcxOVg2ZGYxY1JIQnRIUVYy?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4e1b88-835b-41d8-0f03-08dbb541187b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:38:59.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfiiPSsgFzbVisDq+UdzYpEdxRnGIMaDbGjkkvWLtjbRoU3j6lYMUjLxolLXgz0vm1r+MCOSFHJMjzJZbV7Mc6oopjXQEZiyoBR/lZFLey0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com

From: Larysa Zaremba <larysa.zaremba@intel.com>
Date: Thu, 14 Sep 2023 18:28:07 +0200

> On Thu, Sep 14, 2023 at 06:25:04PM +0200, Alexander Lobakin wrote:
>> From: Larysa Zaremba <larysa.zaremba@intel.com>
>> Date: Thu, 24 Aug 2023 21:26:49 +0200

[...]

>>> +static void
>>> +ice_set_rx_rings_vlan_proto(struct ice_vsi *vsi, __be16 vlan_ethertype)
>>
>> @vsi can be const (I hope).
> 
> I will try to make it const.
> 
>> Line can be broken on arguments, not type (I hope).
>>
> 
> This is how we break the lines everywhere in this file though :/

I know and would really like us stop at least adding new such
occurrences when not needed :s

> 
>>> +{
>>> +	u16 i;
>>> +
>>> +	ice_for_each_alloc_rxq(vsi, i)
>>> +		vsi->rx_rings[i]->pkt_ctx.vlan_proto = vlan_ethertype;
>>> +}
>>> +
>>>  /**
>>>   * ice_set_vlan_offload_features - set VLAN offload features for the PF VSI
>>>   * @vsi: PF's VSI
>>> @@ -6049,6 +6066,11 @@ ice_set_vlan_offload_features(struct ice_vsi *vsi, netdev_features_t features)
>>>  	if (strip_err || insert_err)
>>>  		return -EIO;
>>>  
>>> +	if (enable_stripping)
>>> +		ice_set_rx_rings_vlan_proto(vsi, htons(vlan_ethertype));
>>> +	else
>>> +		ice_set_rx_rings_vlan_proto(vsi, 0);
>>
>> Ternary?
> 
> Would look ugly in this particular case, I think, too long expressions and no 
> return values.

	ice_set_rx_rings_vlan_proto(vsi, strip ? htons(vlan_ethertype) : 0);

?

[...]

>>> -		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
>>> +		vlan_tci = ice_get_vlan_tci(rx_desc);
>>
>> Unrelated: I never was a fan of scattering rx_desc parsing across
>> several files, I remember I moved it to process_skb_fields() in both ice
>> (Hints series) and iavf (libie), maybe do that here as well? Or way too
>> out of context?
> 
> A little bit too unrelated to the purpose of the series, but a thing we must do 
> in the future.

Sure, +

> 
>>
>>>  
>>>  		/* pad the skb if needed, to make a valid ethernet frame */
>>>  		if (eth_skb_pad(skb))
>>
>> [...]
>>
>> Thanks,
>> Olek

Thanks,
Olek

