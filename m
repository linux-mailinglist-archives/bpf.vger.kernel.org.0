Return-Path: <bpf+bounces-5525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA3075B681
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54A1282052
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 18:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECBE19BC8;
	Thu, 20 Jul 2023 18:19:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD5319BA6;
	Thu, 20 Jul 2023 18:19:46 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0BD2D4A;
	Thu, 20 Jul 2023 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689877175; x=1721413175;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KKMCYCzDYgAQWtJcWkTOSu/4dLuYklirnMqLgBTOVPk=;
  b=V0ThYGgBwdfMzgLwh9rnogR5mc+b0AvObT7sYgfy8f9xkNFoVuMSwSHt
   HsW70dAaUQZnlABpuLcrwhK1Xq6YSASlDDLNeRHJqY/zfEeR06fKC9oL7
   lEXX607n2UT8GywYCid8rItttx2h8T7QNVNOn04Ex1QVhOwDXK4Crl9FD
   VGkZwSjuSmfLQOZ8P8YK/ewUgNplkvaz5tS5NnamEwKJOIhn223fZtPAa
   +d1z0zrgdlMqL1gMyWcj32yCrylucODakgipKKNd5dS8rO+VU7mZIsY5r
   RCyrecc150yB1inEeJ2CnG9V0flR5CF2byoQjzUgQJF21nGM0cXy/mOna
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="369499504"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="369499504"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 11:19:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="718529349"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="718529349"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 20 Jul 2023 11:19:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 11:19:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 11:19:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 11:19:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHZ2uOjI/bWnApJX43ntFx8CQqPXmsPzZKU113rZdYzVST0n+ypDUbuQCwtZJ01Y1KjJvGBx+r4dOS+uUHszACXpjCzIZ58H5qA9bzFqHgwHk0ZxsCHk6INPtF3T9LN5LOxxcuUpQKr2TQJ0v9K35xMLpScCgHFb7Do5Ds2bB5Hf10TXfbM4rSueF/vtJxc9YxAq0urur+KHWOgRzbrr6ldCtcYlDH6CHP4QigeTU71NLd0jOd2ZKSTRHu69HQD7nT7soprFhKYDgsVGK0zB7FhwrhdCYQMfOtJ5zx3PXdVwbhQKE3SpUgt9KJCHDnOH6DtJsaoa1t7tY3BduKsMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC3QgDpzpLnXPoqFWYt5oEYlS/8PeUPYjB/kmW7F03I=;
 b=Lizc2F6yNzpkAQgh9NOPi1qdQjheOoq1pPtQjQVZhNQtYRklMjPry5yVN/gpk8ysmY0MjT7rs2hZ4OsBxLhcxwvjPaAX/zykQGmdw+idf7HUz0PwlCf73r/9qQTfCN8yyci2NB/w/0894iypFZrJNQYa5YQ5NQxPl1Q+AtNKNrONnnQqpJv93pZbiEtvxew7e4vf4b3OjxgFd83nCkcgPWHZ9+BpEU/5kjcfE1u0dKtWeok6gNFPyzBcmwMGVqqdUaAiXHr4TWT/T28P7y2x10a3Yu18KLj1fopd7p72FdhOqTyOwY4FNDTRrYJ6k4AriIondPW0f6GXJiXJQLNKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM4PR11MB8201.namprd11.prod.outlook.com (2603:10b6:8:18a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 18:19:28 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 18:19:28 +0000
Message-ID: <77b0bd8a-0168-f7c1-9aa0-a40359d2f075@intel.com>
Date: Thu, 20 Jul 2023 20:18:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] page_pool: split types and declarations from
 page_pool.h
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
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
 <0838ed9e-8b5c-cc93-0175-9d6cbf695dda@intel.com>
In-Reply-To: <0838ed9e-8b5c-cc93-0175-9d6cbf695dda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0347.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::19) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM4PR11MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e49f74-eed5-47ae-7f93-08db894dda90
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRb+ZVc+dk9LuaMfHmdpFc3U9KrWv0FeXQDTEjsKhDjzWiIvXa5aDGs/Ngl4Vyz4RbQy0VPBOtAjAyLJl/Jyo4B9zFjduSDtk/dc1fE2S2DphiItlipQ5+yd7ZiCUr6pwHxdpYXOiHK9zCrbrUbUdp9bgKV/+RViyywwH7vyRzuxXcVQXEmRJwtfT8XMiRbgaZKMsfx4FbZPPRGYGbcJX9kn/MFxwEm1PPFx1pTuu+QerBKCkGjmQLhyvidrRNWRNisA+UF0GJ0Yy0y0FaskFuvQ/3azCNVNsGqe8WcJypO4f5RG/OC/z+Utr9TaE+l4LN4SUbISLsJeT37sdjY3Ijv7l6MoNujYW4K1GC7MGWSvgTGRETKzlPb1GQN697vguUILW+g8xKMVg8ecHlEb2xrXe47nlWYEa97iBwnsWai/fHpGqhpAnWkMHfdMcpglpGTUYYlTQD2CamPUVgKa8HFfuGtMBCj3eLd8uc8pMd1qqyVhFNuPrYAYa3z4tga7kYfrXotgDvyb2i3TRUy3FiCbNAackx6G/roR2EZMvxiOX3qHOba2tIrDwmOijX3BDU73UVQCaxsbC2S9BJsdKY8gdJxAdhvtYOmq16at254jcU7wKHD6lUcV3Nlsbr4mC3n2+b4zLXMCKHqhAovJeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(478600001)(2906002)(6512007)(86362001)(82960400001)(26005)(6506007)(2616005)(38100700002)(31696002)(5660300002)(7416002)(54906003)(66556008)(7406005)(36756003)(8676002)(6486002)(6666004)(66476007)(66946007)(6916009)(8936002)(316002)(4326008)(41300700001)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkNmSnNMbWJUUmg5aHlsN0dPcjZvT1diUXhEWjY3S1Q2VDBUeXZkSVYvTE4z?=
 =?utf-8?B?T3p1NnlHZVdRYUIzeUp3SEpZWlpIakVUK2NOVUFqZkg5dFJOc1FMY0tWUHF3?=
 =?utf-8?B?RkgvTXpZaDVFNzZzcnNaQ1k4eDMzRVJTc3NOTlJaVzkybUpwSzBBeVd5YVR4?=
 =?utf-8?B?cVNuc3lLNmp1MytRZ3hsU2dsOWJGS2FiVE5HYUpHMGNmVDZ0eUFGYVJHRU9G?=
 =?utf-8?B?T3FEaFErcitPWjU0UWFNRi9uL3lPU0lNN1oweUlMK08wVVR4TisyQS8rN0xj?=
 =?utf-8?B?c1BoYWZ5MG5CNTljd2w4aGd6dnhCTEhZc3VMV2NRTjlXdDJVZUlNcitIREE1?=
 =?utf-8?B?NWpOREdkZHZtR2RhNHR1dVROZyt2dTl6aHROSkNqanlrc1dQUTZ5clppdUwr?=
 =?utf-8?B?K0ZsOXFLcVJqSUxydzFvRWNFTWRmbGR2RFVaUXpxaldYOWtvbldMWUFRR1lQ?=
 =?utf-8?B?V3JxOHdyeTduNWhrcFVVM25YMFE2Zmx5LzZzNldCazRDZWRJNkZ4WktEbkhJ?=
 =?utf-8?B?amQyNmJmaWswNkVGY3BNbkVIazBzVDhkblVQd3ZrUTdSVE5SZkNXRlAzUmhU?=
 =?utf-8?B?TmUweWVrTklUVXBCTFd3aU0vZS9MbFZKRWJ4eUgzYTF5R3JhSDFSbUM0RXpG?=
 =?utf-8?B?RFltaTRBSEFkWWdTbXFzMURjaG5rLzBTMlFIbFkwajZsTi9EdEZUK3lxYW05?=
 =?utf-8?B?ZVZmWnZVdDhsNm5DMTRPamJ3RUorN3lQSGt6aEJVVUFHNDVvOFJhTldDcXFI?=
 =?utf-8?B?VmYrUmlIMXE0T3Z0dytqUnM2SjRIOXhwRVJkeWZsejVQWE1rSTYyV1FvRXBM?=
 =?utf-8?B?TEQyb25rVDlkZ1Jldkt2aGtIWHdUSlpJL0VVNDhvNXlaQTk2eldINmg5Y0Fp?=
 =?utf-8?B?b25pWndMVmN0YmdTVnhPWjlLVDgyLzRRdm50MitUUGxUakpTR29qOGcwazNp?=
 =?utf-8?B?WU8wL3RROTE1ZzBmeFBhcVNSbmpnS1BPK2xlMGt4MkFVdXl3YWJaWWN4UWp3?=
 =?utf-8?B?T2UxTWR1VExjWkltQWVLSU9CbFhqdVRPRzJmbjVkU1dFQ3ZzYnExbWZ6dEc3?=
 =?utf-8?B?TFBReEVIcTBTbm96UGx1ZjF4N0hPc0taQjVVL0ZYUkdMdVM1aEpTcE44bnUz?=
 =?utf-8?B?cUk0QVhJOXg0SEc4TEJObEd1bWVYUHp5T2R2NmIrSE5zUUdyNGhsTS8rZnpM?=
 =?utf-8?B?dXoyYlk5bWZVTU1XRGY4RS9LeG5hRUFQa1pleElPVlpld3h1eUJxWlFRaUti?=
 =?utf-8?B?M1NUS0RFTnFDNkV2UDBRQ2x0RE4rcXBpcUVEMGVXaG4zc0xFTThPRkpJN3hI?=
 =?utf-8?B?MmUyeTJDRmE3cFplaUh2d2txUzlZS05NZWh6WVN2Y3Q2OFRsNitBZnlScEUy?=
 =?utf-8?B?MTUySWJvKzJDYUFMNGlmN3lmZ2F1UXhqUDc3dWlWZnR5azM4b1NxK0I4Ny9M?=
 =?utf-8?B?SURmTlQ5bWZ3Uk5nRHJRUEtqWDhpRk1MVW0yL3dpRkVTOU40WkVjZHVyVlZK?=
 =?utf-8?B?OXdQNmtEQXR4dTRHL1NpOEFlSW9sOVVkVGl2ZzVoTFNoSE1mS08yMEV0d1Ni?=
 =?utf-8?B?RWJaT1A3bnFsV3RFTGlSS0NKMmZpU2tZNFQxYkY0djNwdk42WVZ6NzZVaW5W?=
 =?utf-8?B?SVBBNGhMU3liTHZpWjVMMC9rYW5SRkgwWTlSTXhqU1c3NXJRZkI5RGJTbEVi?=
 =?utf-8?B?eU12OUt1T1RFcE5wVWkyZ09lK3JiS0ErK1I5MFhhVlRXM3pLd204N20rcVY1?=
 =?utf-8?B?OVdLeTVVeENHOFpJMnE1eWM3aHBGVG1Vb3BNMWR4d0FqMnpEbVlTWmVCRm5y?=
 =?utf-8?B?MFJZaVZ4T1RFQnhGa3E4Wkczc2ZoVGhRWk0xUWFRWER5d3B4Tk93WkxYMTl2?=
 =?utf-8?B?ZjhidWh4NFM0aGczNm1LMmI2eFA4djM2aE1GSllBakwzbER0VnNSMkFJWVd5?=
 =?utf-8?B?Rzd4N083Y2M5VElnWGhXbFk2cnpQbG1EL2tEbnJCVG12L3VVZGxwVVRWVlI5?=
 =?utf-8?B?UVdCcTFVVFl5V1JCTHhFZkNUQ2FJeUZBZ1UzME5qYTk3cUErT2dXZWI5OS93?=
 =?utf-8?B?a3dTS3RnSnFPUGZxYWFWeCtLbi91S2cxeWd4RUt3ZStYV2E2alRLMDd1Smxk?=
 =?utf-8?B?YVNYL1J5YUhhZzJMSVV5NEcwRHk5VGxjS2lmUVl6cFJiMTZVSFhWMTdIdll4?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e49f74-eed5-47ae-7f93-08db894dda90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 18:19:27.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAV6TQDCCyE7hmtUyPmYH7usq2TxYTTvEqJtktfa5xPcRwnL232Y0v70JP+sqbc9lUyMNJXUZxd1YCe3OMZZgSyBSRoLll/nHhAxQSz1Hqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8201
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Wed, 19 Jul 2023 18:42:17 +0200

> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Wed, 19 Jul 2023 20:13:37 +0800
> 
>> Split types and pure function declarations from page_pool.h
>> and add them in page_page_types.h, so that C sources can
>> include page_pool.h and headers should generally only include
>> page_pool_types.h as suggested by jakub.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> Nice!
> 
> Let me take it into my tree, I assume it's safe to say it will be
> accepted sooner than my patches :D

FYI: it's already there (since yesterday), including your hybrid
allocation series, so for the next revision you could take it from there
to not rebase it one more time :)
...except that seems like I have to rebase it once again now that you
change the patch to add new folder as Jakub asked.

(it's still the same iavf-pp-frag)

> 
> BTW, what do you think: is it better to have those two includes in the
> root include/net/ folder or do something like
> 
> include/net/page_pool/
>   * types.h
>   * <some meaningful name>.h (let's say driver.h)
> 
> like it's done e.g. for GPIO (see include/linux/gpio/)?
> 
> Thanks,
> Olek

Thanks,
Olek

