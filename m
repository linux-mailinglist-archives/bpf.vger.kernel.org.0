Return-Path: <bpf+bounces-5343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A35759BD0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63652819AC
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2B31FB42;
	Wed, 19 Jul 2023 17:05:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6498800;
	Wed, 19 Jul 2023 17:05:37 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B61AB7;
	Wed, 19 Jul 2023 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689786336; x=1721322336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HHDa9PI310qyHgG9Z4XgdROytyWZL3XeO3p5aomK+Ao=;
  b=Lnn+/C6uDRSfGQldOzwzCCFaOVNCvJ8NvCo3Jqbs47z8izWQP1sE0t3I
   tD6omQ+INk8X0x3wnyFLqoNcNqFQov1ccLQ/nIbWPINdoC+cYXN8YOH07
   sA0Q1oXCfD8ep6gyNGkTAKjw6YLnJqNx5LuMZN5XFV4w9D58GZzrlm6/r
   CQBtVOIkT7q8t8oJphEPtcL9xX4r4DedKeSPtfbI7krt4aFH+ZIFAID7k
   CNT0d4kCQfnHrQsPUs0Ssg4g7FQFZkM2f7o5FGNuJFOPj019GPk2C7IXc
   TwZ2Kz/8wyrSICMTQARQ8aMPUezw+E+AkI9Z9U4JCvu5sUOx4bfYvgArB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370085959"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="370085959"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 10:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="753771142"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="753771142"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2023 10:05:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 10:05:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 10:05:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 10:05:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 10:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJfO4Xd8nLI4r86UW2ro78IHtH6kP50U4kMIoHInPp59T+4ssC68qdF/gQoKOyUf+Y12uoZnSoiZ1J7rOTZ53D/8bKAoW+4168YAviMtYLpdKOUT6kKv8nx1ojVWHaMZMKwo6tm+1E5SvIFVXD4Xc+NaAlPIkE1HN0+PnX5qps0HWPIUS1zEHTeiEUimweIlvu4q7r7zLLlJlYseEhAkVC7o98OSi1Imd1HOJ8XAOYu6SNo0XLQEvZ8WSsIoKVvU1CzV0LbyQU9TXyFJJtLM9XRYFFyGPoWD4dF1n3gyYgFNd/ylZyNVhjk5vF8LvJCIOao4VKtfnxaBdlDHRDPQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kgXLtYYNz1HGSV6AhFrKkqi0K7k+KPo8G/EhrcDkwY=;
 b=JZMGVF90v9bPjCIdQjIZSsIpdsCgcwepniOqB4r13x1FYn+Qgz9yqMd+xvGLwRDEM8z5jNHPJKfcAgEtLQFcBfFEYCzWebkFCqd0UvuNs8E4gv1P8QPC88gNSUT/jhIxvDLG0phc6Uk+Nwmz5xalqrXEFjmBe3zp3dZA/JS6zZvoTUAf+bfLX0axgFMQbOVlwcHf8X3Rp1OYwxmO6cNCq4XswMQt6fye2AvzH8GLYDmNrP9bEP+gCm1M7RbbpYeMxADR2hRNrQZh4FUz0OUgfqjfdBhX4lQvpUBG5MeRiEoOV0agxDj8UHjc/C2wG/NoTsyroIlfeoscL7PTm+Wzww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH0PR11MB4902.namprd11.prod.outlook.com (2603:10b6:510:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 17:05:29 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 17:05:29 +0000
Message-ID: <46ccfcdd-65cb-e182-9997-6e462c945ade@intel.com>
Date: Wed, 19 Jul 2023 19:03:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] page_pool: split types and declarations from
 page_pool.h
Content-Language: en-US
To: Yunsheng Lin <linyunsheng@huawei.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
	<linux-imx@nxp.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad
	<hkelam@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Felix Fietkau <nbd@nbd.name>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, "Shayne
 Chen" <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, "Kalle
 Valo" <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20230719121339.63331-1-linyunsheng@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230719121339.63331-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::20) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH0PR11MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 129096eb-a24f-4eff-f0a7-08db887a5a9c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGEvcVJ3O5fHK1y5uRRGSimpQBEIbElyzYSo4J+hjnaT13cVU1A/arlAmhkMgGrmx5xHw7QVyKPDKDaAM5UF85Er89szv8eiOzbhV5T+eELVsuhX4DpXTV/Gi9HFSj0FRbfhDC1dkfzL6ZzPKq6ZhTmqgkTV+7FStN6Co1nZs48ZHF4kqDqaYVFn6Y2UYSVnttTo2P6Bnn9Bno+3VNNxwAld1RKAaW5PNnrb4Yq9ULW4wje7wViZP9roduwIu0bnzbcKZyPDkII9vUx6P8jQp5OK0Ir2vlrzA35Y8qPMcQ6EknCtq93DCUqQXiBSynP4KPJwsv+fNoTE3d7OdLEgU9yo1KIaG+lvH+l/dxNG9xDzMlL0Di0Stmxak0GaxEnRkXOHGGTyg/XFewNN9T1q3TvoNxsu0BNBS2VjoUFx1jPoR4tfXRbsGKxGycyyzsMwpTYVZkfa1t354HaKC2PV2PQpOlKLlmFjlZkPYuhymnh+9g498UUUiWOz7PtlvN28TsQRMiT1zqM+i6Ly3418xw0YjQE3J+JFBP4eJc0n5L2UhgJex43hB4shgyusiypSerizEeFHi3TRiZ2tqTuQBwMTKc1R4j59r2duOmrwqVrO14PHNikztyKELN3LFGLMhfj710TBEYXK+1n1GLnSHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(54906003)(478600001)(31696002)(2616005)(26005)(86362001)(38100700002)(186003)(6506007)(82960400001)(2906002)(6512007)(6486002)(6666004)(7416002)(8936002)(8676002)(7406005)(6916009)(41300700001)(66556008)(66476007)(66946007)(5660300002)(316002)(4326008)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dENpTjNuN2xKVXlQNDJoc0Y0cndHQkN0d3NYNDZDL1RoTk5lOElKNW1oRTE0?=
 =?utf-8?B?L1JsL1BqTERHOE5zMlZzRzZjMUM3V1VKTURzZXBHb0loVGlWK1dNMnlCUDdT?=
 =?utf-8?B?TjBERUZEMkJoRUozRzBiMUpJUTRTTkZmUk8rQk1DcVhLWW9GSWJQenV6N3pa?=
 =?utf-8?B?eFpzQTJlMjhVaVB5SWJCV2x4SnRWR3A5dXViT090TlZOcDlDVGNVNzVtWGpU?=
 =?utf-8?B?bGhhdVptR01VUHN4Mi90SHY1cTVNUnl4V1laWmozbTNLQ0xuSStIOHFMaHVv?=
 =?utf-8?B?UzhIZElleFRnVm5iZUJIVW5LNWlrL2FYN0hFK0MxcHNvYnc4ejUvNld0Rlhw?=
 =?utf-8?B?YklYbmR4LzRHUzhsYVpyTHJHWTZTMDFPNGhiR0xLd0Q4dXhJZW1SYm15ZW5U?=
 =?utf-8?B?S3AvbkFpN2dPTzZtMi9HM2ZITjl2U1ZmNWw0ZlcraTZOWjNIWGZ3b2krdjlu?=
 =?utf-8?B?Z3FiSW9aNTJ3WFQrNHVoRStNbFo4QnFSMXBvOFY0TnpiUHFCb2J4M2JWUTB6?=
 =?utf-8?B?L0FQQ2RBeWQ2d2dVMGJ0QUYwdDFJejVoNkEyWW1oOEc4MGkzZGpyelRYQTFu?=
 =?utf-8?B?a0FwZlorYUxWbGxTaXpDSWQrSm82LzJkY1RqWHZtNXAzbFZjZmVEYzBEZGlU?=
 =?utf-8?B?ZUNOOWNTbzNnMDRnZnp6TXhvUDZkNkdLSXhqZ0o3bUVDa2dReFAxTk12dndY?=
 =?utf-8?B?NlVIU3owVURtdXZWcmZjMCtQN2svQWFsZWJYNXRibkJjejFBMG1yYzZuSFRn?=
 =?utf-8?B?VE1ZaWwweWhXTVFaUnJGWnpHOXEvc1dnbWkzT2IvanR2ZHV4ajBqMlV0enY2?=
 =?utf-8?B?RjE3NExmOUNOOUN4QlRRNUl2UndaS3A5R0NzSG5pcDdWdE1iNTN1Tys5MUJQ?=
 =?utf-8?B?dC9UQVZoMGI2OVBwU0t2MGZTb3k2VVhKYVVEWEl1NWRIVjd3c1dyaFdFK0tF?=
 =?utf-8?B?VVR3cU1PUlh3dGVOSWo5WHAyTEJCK2EyTDRQS2lheWdkOThkSEE5K0N2OEdi?=
 =?utf-8?B?ZVhNdnhxN2xmMGtveHhYTEwyUFpEZmYrUk03Qm94N2k5UDRBU3NlUktrd2p2?=
 =?utf-8?B?bGhSWWJGVjltWTNSMVlubmZ1T0JDM09CaEtoZjA2bDRidEplTUNqMmNJWXJK?=
 =?utf-8?B?RVJzb0h6eWpRaFN0cWZSa1k4VjA3dEhSV016UHZNd0liVHFTK2dHZmZuNU1F?=
 =?utf-8?B?a0hDQjRKUHRsZzc0R0I2ZnkyM25RNSsvdU1tSXM5RUZXR2k0aGdCTElBdy9J?=
 =?utf-8?B?NUlNa2lTV1NTbnN0Y1hFR0h3em9HaVdVZlBDRldZSnpLYkFCK0hoTlh5dG50?=
 =?utf-8?B?NEhFTFBQQ05sSVVWeXJGOWQyNkF3Y2FDMHRKNkxFQ0JzYkdzdStjWUFTb0ZH?=
 =?utf-8?B?ZWdCMU1ZYUdMVjZ6N1R6YzRsTkQzSWJuS3dqVHR5UHk3WnN0RW5uNlBZc0dv?=
 =?utf-8?B?MWdXK2Ztb1U5ellmR1JHMjJGbDhYWVBBMXRzOGd3N1U2SkNtYU5PcjY5ei9w?=
 =?utf-8?B?S2dJSUpZWUdhVTFVaWk1aXgyR05pYnBSUXE5dG4ydmhwZ3VlMkR1c3o3MDRX?=
 =?utf-8?B?Q2NGZWNIUjFDaXZ2WmxpL2ZuV3pMMXllUFZmdU9qMnJNNXAyQTV0K0xwTVEv?=
 =?utf-8?B?MG95SkJnbkpYU0huSGpMUFhBVXl5Mi9xb2tNblNYQWtJMnE2L01NVEJ0T3Bx?=
 =?utf-8?B?OHZhS2RPbDdLNHNwaGxQc2lIZ2w1S0xBUzVwcW5GRkVFK1NibW1UL2krWEpF?=
 =?utf-8?B?aXR6OUxrQ2pEVzRvaXllUFBMNXZyOHh3M3VqNDlNNlZ5TVZDdGhlK0JJcE8w?=
 =?utf-8?B?Q21FZnVoejltSkFQbmpYVHpFb0lRVENTQXMrZ3NCUlVOKzhUMWkrRS9xUUFD?=
 =?utf-8?B?Y3BkUjl0QlQ2REVpR0lvRDdIeGdnc0lQamMwemJvQllZK0xRd2lLTGQ4VDFo?=
 =?utf-8?B?SEhxSlh5bTBXeFQ0eks3c2EwNmlYWWlOaDVUeW5MS0lzVENKSkltVXR4ODdr?=
 =?utf-8?B?SGc3S284SzhrNTMyUDd3b1RJL2lIUGdURzEyRCs0MEwzVlFOOExFeFNmQVVa?=
 =?utf-8?B?RXJ2SjJTaGwvQ2RsZ0hIVmRHVTJRZld2bVg5d09pWXVUS2lCejlBMFdtVVk5?=
 =?utf-8?B?Q2tKWXY2Q0hrNFRQa2IxSWJ4dU4rOEdVOVNQZzFkYXVRVlA0SWVYekgzSlFO?=
 =?utf-8?Q?h6mZJFNKydrTD0YqAdJxwR0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 129096eb-a24f-4eff-f0a7-08db887a5a9c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 17:05:29.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypmIWmlFQgUe5AIEAMwCDAfBtkNGEWGLkUAT+eqATvAr1RG8ObS2FdHCZp/05b8L03HH35ZfS1sg1j29qdh+BGusg9m29coTCa47C2XolBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4902
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Wed, 19 Jul 2023 20:13:37 +0800

> Split types and pure function declarations from page_pool.h
> and add them in page_page_types.h, so that C sources can
> include page_pool.h and headers should generally only include
> page_pool_types.h as suggested by jakub.

[...]

> diff --git a/include/net/page_pool_types.h b/include/net/page_pool_types.h
> new file mode 100644
> index 000000000000..9dc189082e20
> --- /dev/null
> +++ b/include/net/page_pool_types.h
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _NET_PAGE_POOL_TYPES_H
> +#define _NET_PAGE_POOL_TYPES_H
> +
> +#include <linux/ptr_ring.h>
> +#include <linux/dma-direction.h>

Nit: alphabetic sorting?

> +
> +#define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
> +					* map/unmap
> +					*/
> +#define PP_FLAG_DMA_SYNC_DEV	BIT(1) /* If set all pages that the driver gets
> +					* from page_pool will be
> +					* DMA-synced-for-device according to
> +					* the length provided by the device
> +					* driver.
> +					* Please note DMA-sync-for-CPU is still
> +					* device driver responsibility
> +					*/
[...]

Thanks,
Olek

