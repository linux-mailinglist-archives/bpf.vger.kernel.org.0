Return-Path: <bpf+bounces-7894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E4277E209
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 14:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215971C2109B
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBFD1118C;
	Wed, 16 Aug 2023 12:58:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4010976;
	Wed, 16 Aug 2023 12:58:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E031FF3;
	Wed, 16 Aug 2023 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692190706; x=1723726706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jbien+a97zhD9i+uD7rTezabkOWnOVqxk6DiCTZSanA=;
  b=jQCMyIg6FFji4k9jQGAHRIM5G3Ly9m3vLscaoTn/NA2fyqhadgWVm1Te
   U3ZWoFpOs7q4gRt5+X3Hfd+xJUyzAMyGYJgjDtRT+MfS0eGz/ZjtYklHB
   3dDNvYrF9b7MwenlafR54iBV9WiU2cwv/ZlSJIWfrcOANmE0WsFVINpJ6
   QmkExdadrYn928/ACaMdI43/5EaVAiH0nVGB4jYR6XRs34OU1y78t3oru
   GXGy4f8GJTsshWXYLcxgf45LyLO+TfUI1s7FDdF8FR7XcMQVN2xa7AW/i
   jCGE7R3DN73haNqdSib50F01GiKJU5uCFlMZ+omyD7lzff+yE6HLW5zmL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352114598"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="352114598"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1064814914"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="1064814914"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2023 05:58:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:58:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:58:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 05:58:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 05:58:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGuQnjBl2YPZvM0OP36SaCmhq0H3HioVdLUrHwMoeyaGYvhCFQ62n27iYOpJOLUAVwi5YnmFToD9lG7ZRnb2AX3LvJtYbZ3KPJrbZ/Zvmk7GmpN8EQCmUIZoPHKUKKGdFTlIv7OURzFscp0QZteNC6VEDEewDacb4CY0YncLRlKvcSQLiYDIsu45GRJjJKi7fjH1VhUIypABhkrB7vKtqWDTXczID3EMbN3T+H3rqqw+O17VGLP1TdPWCRicXUEZZd1p4Qb/OiRm2D0HeC38t78gcVlBBzrh/FY8cswFAZRXtOxdO6cvOfOaWfZL/I1vXbxVgIf97SAtn7HkbojquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ajh+zSqXw7dlZHMgkKsPyPUotowfaqQz9XoTRVAw8oc=;
 b=TQdF7DRW+KA3+tFxZyui2K3ZWKBSzNmKVml4p5YU2uN59P76lH5hHDBEw66/jnbYXLWJLcW+xgjlibmRVBzOfWHweShN3woD0km1jo/7uwUUymtLZGZD7NiahqU4UuXkjZoW5YnjDXCEH0OzMcc5kZx7jGbK1pefA+Qkcw9yQFeqRTtWF94qlh/y0CbTp1rl7SM8NEGCauql0VeGfac6aJWn8iS8z0/cG6REIdGDG8bHOvaFJxp+zVOYBRuI3qNO1Nk1GqNGgA9mi2mS6F8izg8QvoRcWfDOJ0BHLgNfyXGsly+8xhMivdiB9ZRPcj/ej28SGiZtNu5sPBI3ul/wdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 12:58:21 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 12:58:21 +0000
Message-ID: <5b00e2c6-738e-7025-91c0-315d67422a0e@intel.com>
Date: Wed, 16 Aug 2023 14:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V6 net-next 2/2] net: fec: improve XDP_TX performance
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenwei.wang@nxp.com>, <xiaoning.wang@nxp.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <larysa.zaremba@intel.com>, <jbrouer@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
	<linux-imx@nxp.com>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230815051955.150298-1-wei.fang@nxp.com>
 <20230815051955.150298-3-wei.fang@nxp.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230815051955.150298-3-wei.fang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0481.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::14) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: f53edafb-d6a1-475b-764c-08db9e587834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ct/SceK9cpiIGYX0cXiL0YAfGUXF5a1PFDbZA9zBG1gtAUfF5SBaddHIDSz5eQx5NMcfIZ4fnbCtjc0QeC07B6KY9gcY+Afft6x6ElV+qcoU8y3DLyHa2AKxyapaTNWGsx5cQf8QbSAXNXzwuPiuZiVGamGh52LXOor9wbRBtOhXGI7LThwy0whj7B+sja/m7pmc9Y/Kydd0paaedZnkY73iHIS8VhltFWLE73PsqkT1AF5pkR8dSaffF3lJbtT2RmTigZMw1hlJdKWU1ijgmeJ53+O41txQKFT3G0x71vOvfMSCVsW2Yv50rHKr/oWZGRYXBFYu+ukkAn3DaFbvej8O8N2Iq25rUKTpxqRI5AK30fvzynm5Py3y+lFtDPKQZOmpU9wJ2uYX1wViHU8E/SqDkiUISkOpyiSa9HzPnnHkqFqTZxb3OYElhSzsuUpPcjdpbq24rXgzXOF92Oi3WBvnlMAwHCX3uo7ZiawJgODYUon6rtt29GQNxn2JqGjcyUW6umI6+E7qYaq7hs8Lo4ZbmHqlrdwyu6XtnYUmgpdYCeA0ug2+O1iELN9mw4Eg9IcarVOVj5D3LSHSBnMwkY6oqa93CJ5YAqtnKlxX9aecqwU99aSxUgvNBEstptKTkhyUgJKrH47F1PQjzm50g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(82960400001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(31696002)(6512007)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUZUSld6T05VRmFNZDdxTkJRdEIyZ0c0cDV5dzFUL1paK1V0czJ5dWgxcWpw?=
 =?utf-8?B?eGdLMHJPOVAvMG1LQzMzM2lVYkdsRzZOeUNFUXRnU2EwNk5sMEM1ekFYRTV1?=
 =?utf-8?B?dXgvdDlzMnFSNkR0c2JiS3JNOS91cFpSYVAvc0dNVTcyblhsalpIZlhXOTln?=
 =?utf-8?B?S0JaTkJWYlBTOFYrV3VPZnhqTXh4dmZMd0NTT013NEVNdWFKM25uUVBmU2I2?=
 =?utf-8?B?eUQ0em5VeEVRYkV6OU5hSktGTnduWkdIa0twZ1dSeTR1SXRmZkU3aGw4YUNT?=
 =?utf-8?B?RmFBcFZIK3R4SFA5d3ZTK09TaTFnSEFIUExVbFFrWWg0c3VxOWFGQUZYZWFL?=
 =?utf-8?B?Y1RvcmVGUjBFalV5VituTS9PT3NGRVJHTTRiTFFRM0dyUDhSYXBnU1I0UTU2?=
 =?utf-8?B?c1R3WkVvelFEZFF0ZXlwWUhFYXlqRGh6Sm1pOWFQOW9JNmVsWFd5bGJjRW9n?=
 =?utf-8?B?bGdlaGpyM0tObkpsUmVhK3BUS0hOUE50Z0FzTUZyUllkMGVPZHVFQ3BVNEpr?=
 =?utf-8?B?dWdtSjRwalVWZ1hmN2NTTWhhU1hlNlVSdk4wYU1lVFdVTE9XeWMvNGwzWk5h?=
 =?utf-8?B?bkhnajdjeUJyNUpqVnNyaDZNUXZCKzdzbjBQN05rd0dmb1ZPNW81NXl1TlZz?=
 =?utf-8?B?SUtYSlRKTFZLT3FaUEVxajZHTjBodWpNWHFMaWJQcklnNGVoTVNxM0V1MWhT?=
 =?utf-8?B?OFF5dUtyUnNtbnRMajVXUU9ZYTZCcGhvU2RNejFzQmFvckViNmdFdmxNRWM4?=
 =?utf-8?B?bXJpaGgvVFZpajBOY2lSOUZ3WGJZbmJVQXZwVUVQdW5Qc0dONXR2REtZSS9Y?=
 =?utf-8?B?ZUVrdVplTExIUHRRdXpXSUZWSDdKNnk2UHhMOTJOZ3NadHVSVFBLZFhWYUVo?=
 =?utf-8?B?Rm9DMzQwOEhYUE1hMUhXeDQvL3pQU2FWUmFTNVN4NnFjSkNHRFdtQjV6K3Qy?=
 =?utf-8?B?TkI4RTJGZElMZkE4YUI1bmNxVlRBMmNwS3dHdDNsVEpWQW0zMDJySlFINk5G?=
 =?utf-8?B?NWJTMkNDelIyZ3l5cThDR1ZyOGtHUTNXM29pTVFBU2ZqUzZvL3BlS2NZdTAw?=
 =?utf-8?B?T3ZZWWE2UThaTXI3T1c5b2FTd3VVR1VsMncybWtub0U3UzRqdjNQNllHdzBq?=
 =?utf-8?B?OThoajdSYnY1TEI1amQ4bklMTml4V2YyaCtnSDErd0JaRngwaVJWRTBlTmNT?=
 =?utf-8?B?emdPYTR0Vk1EOWM3VlR1aFR5U2xxVU5KeGtqeVh3Z0pjdmovVmVOc1dCNVk0?=
 =?utf-8?B?T3VNaW5uazRXUWhWalV6YkxlKzl0TUpFWUdZMEVzRVpBejRjbGs0VHJSbzVh?=
 =?utf-8?B?MlMvYjZzaE0vTEJORDhaMHo0eDdaWVhxOVFRTTEvQXI1eVpqeG85WFlIcGlY?=
 =?utf-8?B?bkJnMjFsWkt6YWZNa0YySEJiQmgxVXJDRHd1YmVXVi9YcExaZTU1Ni9VR2Fs?=
 =?utf-8?B?NVFJcUhZcndkMXVkV05ud3h2elNmU200UEMwK3hOenBRbk1VTU16N3B6ZXhO?=
 =?utf-8?B?RDl1NXNRY2MrbjRiWUpwRGhtc0Z4RDBSVURvVEh1dTRuZ2JqYWRvMEV4SVB4?=
 =?utf-8?B?amFQZWJqNG5nT2thd2VoUWhKRGtzbzdaSHcxeVdzUyt1UDZySTdqQktEOWFD?=
 =?utf-8?B?TGpDOERSQVZkbUZ3M3EyVWRWZjM4TWdUMkl5SU8zeDJQRWVHMDh4b0NHNXBx?=
 =?utf-8?B?VXJ3ZHpueTB5SnlQOXgwUzNIYzIzRzZ4VGNmRktUcVh0RVBlWWQwVGxDOFN6?=
 =?utf-8?B?UENjU1h3VExkQVFLNXJZRnVNNis2Wmt2cjVhZkZHZVpMOC9SbWpwNHUrZVdk?=
 =?utf-8?B?Mm1ta0htSm9iZnFXaDRrQ2UvWEdUb2JWM0QyamhWcDBTSW03OFBvdkZDSUxN?=
 =?utf-8?B?UmlsRXFDQnRwWW9JRWxMdnIrL091TDkxQk5BL3lXSXZ0Y0xLcUtwYkdQS2h5?=
 =?utf-8?B?cDBOeklJR3FESW5ueWVGaWhsL2MyZjVnZlE4T1IxUlkyQWRGa21TL3orR2ww?=
 =?utf-8?B?UkJXUFlmeXM2NzI2S2d5UGVIemxicGxlYkhQM3pOMUVIR0lwV1lHYlMrZHhw?=
 =?utf-8?B?THhya3lXOW1nRFM2MmJFMUYzUExUbnc3WkVIc09qNCtCQ1ZzU1lCbysyTXNK?=
 =?utf-8?B?aGlNM3lFcE9sRDRoQzJjWCtseE8xUXpLRFA0cDhFRCtwUEZ4a3lnRXZ6aHJ4?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f53edafb-d6a1-475b-764c-08db9e587834
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 12:58:21.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W34uWwrJql6V6DWByEWJxm3nzYxeqEz/Vlne98Dtueu80i5TGE0ztH90koaIH6+o8Mi/S90mrm37HvbHibUSjpUQkufLByFjFljzK77Mo08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wei Fang <wei.fang@nxp.com>
Date: Tue, 15 Aug 2023 13:19:55 +0800

> As suggested by Jesper and Alexander, we can avoid converting xdp_buff
> to xdp_frame in case of XDP_TX to save a bunch of CPU cycles, so that
> we can further improve the XDP_TX performance.
> 
> Before this patch on i.MX8MP-EVK board, the performance shows as follows.
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     353918 pkt/s
> proto 17:     352923 pkt/s
> proto 17:     353900 pkt/s
> proto 17:     352672 pkt/s
> proto 17:     353912 pkt/s
> proto 17:     354219 pkt/s
> 
> After applying this patch, the performance is improved.
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     369261 pkt/s
> proto 17:     369267 pkt/s
> proto 17:     369206 pkt/s
> proto 17:     369214 pkt/s
> proto 17:     369126 pkt/s
> proto 17:     369272 pkt/s
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>

BTW I forgot to mention that it was Maciej Fijalkowski
<maciej.fijalkowski@intel.com> who initially told me that converting
xdp_buff -> xdp_frame is expensive and we can avoid that on XDP_TX (he
introduced that improved to the ice driver half a year ago). Now I feel
like he must've been credited, but it's too late already, sorry :z

> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
> V5 changes:
> New patch. Separated from the first patch, to keep track of the changes
> and improvements (suggested by Jesper).
> 
> V6 changes:
> No changes.
> ---
>  drivers/net/ethernet/freescale/fec.h      |   5 +-
>  drivers/net/ethernet/freescale/fec_main.c | 140 ++++++++++++----------
>  2 files changed, 75 insertions(+), 70 deletions(-)

[...]

Thanks,
Olek

