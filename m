Return-Path: <bpf+bounces-5626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAEE75CCB6
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 17:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D28E1C202F1
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 15:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AC21ED47;
	Fri, 21 Jul 2023 15:53:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9531ED25;
	Fri, 21 Jul 2023 15:53:55 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B21E3C2F;
	Fri, 21 Jul 2023 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689954809; x=1721490809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yodEFnGZlGujUkKv50OWn70ICwYXjxcUSTuqqxjBSPQ=;
  b=EpiSBS6p5uaXZXZ7JNB+OxmEW4+4Lcfjd3o7/GpjgPMsieTp73PxtrLx
   lZWbWxZaO6DYVb1T9f43KsbsVb9FDbJyeDfkP7eh5ifpPZViTsIF3zY8r
   Ud162rziCIWMcXnSG6MB5zEKCvroqz86gAaxSTz6vnlkPV5O1TV66i6Kj
   Jo/dspUq2Ev5KKrk/bG2nWlid7SGNna0/FI2pzmtirAyCscIqKwbUhorg
   JbtNBkwVYamxl3Cov/zQoXziLBKjeAZHdh5vpnLnA42rHIvrsJp37y9nq
   Wh5nbKsu5SswTkVzEecgMdxMcibifI9OOS8cPBFwmXfCepMZOEo2PQwTE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="357044447"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="357044447"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="702098205"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="702098205"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2023 08:52:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 08:52:34 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 08:52:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 08:52:32 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 08:52:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXDRvqv3zqWf9Gq+CMZintAusnTJ12PvbEMZ7nYzzutGh+7y1crXyykCkjg/0GgYoBcBfGoSrV02MuyJgtRbBtc2U5CEJPaQAW6+PhMcoZkgIAvDitAC//3jssvHvhJuYYMB7BXss7edyMGcR0MTraYEy8/iutYMNPIsgtKRj9a2AP3O9gIP+TFLhDVUkvZ13HW+ZQ55OC+vvk7zDf1g0m1rthFPxxhmY9iffy9fFFm7oJkqAsz8Wee+yY1TTht/hVhu9LJnxd9F28burlqLU6ZAD1vZzdIzh7u37GWyIbNZ6yn5rltqptGfYjw0QWgTZgf8jGaun5jdAFLFPHa6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8II4X3lXtucyX1Ab5YifNEecvgN9WvjLx5z709Kj/Q=;
 b=O7sMmPU6tyay/SRICzEHZMCi0sDZ+1dhAPC5HhSzH9nzDLljR3hL77DzcJhTDrOiQkQQ2lcpOCbGSCNKiHSlclfg0Bz124A1fiQbBiNF+OHEseGn5PQhxSdSxqT/3wytZsyP0m+b+6biRRw56iHwVDIfq+Deci5J9T9WbtzNE66KTFw+V995bp+L69JkYQd6Niqo53fPGmPJ3TMNFkxVpNqsRR0klksOUgV1y95GVQ8vKsJ9oobv5i0wzJJR0m9EFxVa53lQBZTZqhn/LsfgF+jWo6UsE1gQmE/fnjHqbnnankb50LVi+KBQTwWmWZ0TQESTm8dfchKo1QC+nmYMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB7753.namprd11.prod.outlook.com (2603:10b6:208:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 15:52:29 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 15:52:29 +0000
Message-ID: <ccb728be-832c-be93-2023-6a5c78c53e6a@intel.com>
Date: Fri, 21 Jul 2023 17:51:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] page_pool: split types and declarations from
 page_pool.h
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Sunil Goutham
	<sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, "Subbaraya
 Sundeep" <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder
 Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sean
 Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "Ilias Apalodimas"
	<ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20230719121339.63331-1-linyunsheng@huawei.com>
 <0838ed9e-8b5c-cc93-0175-9d6cbf695dda@intel.com>
 <7e9c1276-9996-d9dd-c061-b1e66361c48b@huawei.com>
 <20230720092247.279d65f3@kernel.org>
 <f5d40062-bb0d-055b-8c02-912cfd020aca@huawei.com>
 <20230721075615.118acad4@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230721075615.118acad4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 877191d8-17b6-43a3-da7a-08db8a027cc3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XamEHMGU00iU/GPWT5YFUps00A2dD8Cn6ssZpbZ196PpVCPYdDROlQyUfi1Nx4gYV73O72uKJrARYa/xww1fv6CaVoCD/qH14bKnp4agOzcUB8e74bEfYG2b53KLDzOz22i9adK1/BsiP0uBv68r4pJiKGhB3K/tQXEwbo2FG0uT97KZ/GQwb7cTwl2l8sui5JmUaHpJiXRUK9P9MgGJ5rMXWuoEwNn+9PvQ1fFw5AFFuP334CBHPp2K+tTt5YSuR4UCrXMQ5YRoNDC7sWc4q+xs3eqUXlx1Vr6FV/vDk/feOWydYjJ7PleY0H+0avBoT5c3wx9atHFiFFFFhEiiOrG8kGYy+QZSeTew7SnaAnNjsYGOWWwVLDI/cAzl+3s/aUAZGAp/J50ineXwHLhFnMZrkFfBwcZu7NzJ0BjDfcnrt3FHOIrTpeKN6r1K2qla1aG/RX9ocRjaoAX+aA1yN1PvHeH8uD/L8jisfTTi2A5Xd4vP/AJM0AJxtQJOb3ov3mfL8hr2m7AMIjZB7mjN051oOJpX3EN56EwFD5aGfAasuP7hkgh39H0Q57aQ9/dPXTIDjICMs7gscUb4HnXnKXawp4ydHdr3Hry0OklWKGLzq4pnEBGDu/TRP9YVnXGRbbAnzNZQgVl0S/kGSxpKWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(316002)(4326008)(66946007)(66556008)(66476007)(38100700002)(6512007)(6666004)(6486002)(31696002)(86362001)(110136005)(54906003)(478600001)(4744005)(2906002)(82960400001)(36756003)(41300700001)(2616005)(31686004)(5660300002)(8936002)(8676002)(7406005)(7416002)(186003)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHVVKyswcFVqZTFYWlFpeGxNNDhRdzNUWGh1Tm5reVM4bnZsbmh5QnFpMTdD?=
 =?utf-8?B?NnFXaVhtTU4welJDanRqS1lxVmRWTHhCRGJpdWN3QlpjYS9Tamxkdm9adGtV?=
 =?utf-8?B?Kyt5OE52NS95TWdrNFQ3TmFVSllsaEdLOEcwL0NWc1FDQWpLRzdSZUdXZENB?=
 =?utf-8?B?Um9jMDZCNEt2N2YyRG50SWFHV1Zid3hFLy9uUVFUZ2l0Tmx1SUpQV2lFcEwz?=
 =?utf-8?B?WEZ5NGZ0V05XMm5KOVNWbTd5Vk5lTVFDeE5ZdHlDL09pemUrYzVOWjQrVEx6?=
 =?utf-8?B?RmlQOXBVRVdlanV1WC9wb0ZYOFdZaWIwQjNUeEhFYmx6ZFM2a2lpb3ByR1ht?=
 =?utf-8?B?SnhzZG5hVVJJckFVZ01ENnpma1hNQmsrdjdNeUo3S1haSXVqNzBwMTZuZTFT?=
 =?utf-8?B?aTFwMlEwVWxUMnpSRDhvN1NJWnNJRldjL01iZlRVeDNCeUNPY01TZnZ5WVQr?=
 =?utf-8?B?MDMzaEZzREljTi9xeGowaDVlQ2cvb3B0R3RFVjBxcTlyYkZHTjlodUUvbThj?=
 =?utf-8?B?R3M4dTJVamVIaXFCV1hCR3dhdFNMaW5NY2xmR0lSTE9nWEFpbVpKMnprWXQx?=
 =?utf-8?B?ZDk3cWt1RmhVdXYwdkpaRysxT0tTaDdleThOb3Zoak9CMFFURnc2MlV5L1RW?=
 =?utf-8?B?RTl3WkNmMXU0TmFOZGttY1hvbmRHWEt1eHhnaThjT3daVW9WbVQrRlduN1p4?=
 =?utf-8?B?bldXK2dBcmI5QUNVSWtwQi9TV09zdExWUTlZVlhhbmVyUjVHaHZkaHVBWE8x?=
 =?utf-8?B?c29pQW1tNS84UnZaZ0pGUGZlamROMFBJRStnYXowSHIrb21mWHdZUTcrM3dL?=
 =?utf-8?B?QUVkdWNNN1FjbWZ3RWM0OVdGUFNEKzNiZFc5UlhXRGdSUDdNWndiVHpvNGVO?=
 =?utf-8?B?R25adnVHN2orbjRvREhYMXRwQk1QOG1BTzh2YnFNRXhDRXZLcmJ6LzZTUFM0?=
 =?utf-8?B?U0RsdWM3NnNYWGVkQzJ3TmcxYzVEQkcvMUovR0thcS9OZkFZU291SWF4YWxx?=
 =?utf-8?B?N1I1M0g0VGlnTkI2VGtjWHhHN2dOVW5qcGNBZWJsa1lYT2RVL2ExczQxYWpJ?=
 =?utf-8?B?T0RoTWx5OXRBMFBuZkUxU3g5QUFoMjFPbFRTSHgza0JPcHozVWI4bHhtemx6?=
 =?utf-8?B?V0VvbG1iWUc5WjREcWU0R0N1OERXTlF0d2g5Z3lKMldiME9ucmJOOGRwYk44?=
 =?utf-8?B?NXkrVUl5QTZUMENLbFVlSDV3REZDbjhBcDNYbjkyT0tPeWkxUUJOWmp6clhC?=
 =?utf-8?B?WmtsamQrSTU0R2tRbmJ5dHlBMkNwU244VGppNmdFN0dSUDZ0ckVVZzE4OHVL?=
 =?utf-8?B?bTdVQXR0RzRBb09FSG1HL0wwOFM0V1draGo4VmJ6c1FCbHE1VmpxbFNmYjUy?=
 =?utf-8?B?azUxdGUzVjdvdDRuZSsvZ1VFa1B5UlFiUXNKMXFXZHVUZTAyNU01c1FhWjBS?=
 =?utf-8?B?NGQ3RjFLNHdKZ1ZxTk1wMWNRT3gwSmFTd1VqblBxT2dub01SUU1Ia09kaFlX?=
 =?utf-8?B?MEorQzhjWWVoRjBmd1VVY0FoV0oySFhlRUlBZmNhOVNmRE9UVXkra2k1c09R?=
 =?utf-8?B?MG4rOEkxQ3EySlhrc0dJaGRZcmc1NWRvUFYvdW9rdGlWcklsRllhOUdwMVBC?=
 =?utf-8?B?Y1FUdyt0WFNZUWlaRGs2cUwzMFhSbldHWEpYVzVVZGx1UXhYdlF6SU8wRUl3?=
 =?utf-8?B?R0lpQ0lZdkUvTHpaSjcvTWNSaGk4MGdJVkcxWlE4YlhlQ0NIcmNaKytUc2NT?=
 =?utf-8?B?Sm1LUWJxdkZYZEd1dXZqOHh4L1htYlBHbHZvSUtwSmdCVFQwUDFoTzE3N0dR?=
 =?utf-8?B?Y2NBWk94VDJPOS9iQUVOZFBLdG5rUnR3eGpwNUduRHRpTVlKalFvUnhqeU1P?=
 =?utf-8?B?S2NnRTRwbzFDRzB4RGc4RFhJdFowNG0xSE1NZ0FuN1JwU3hSRTVnY1RyblQ0?=
 =?utf-8?B?OUsrQUN1cXk1NkNNZFpwVDF6eExEU1ZWRURPa3hRcHJjNkc1MHVseVBKaE5s?=
 =?utf-8?B?QzIwZG5XVVVKTG9LbkI5d2o3QjI4Y0MrYWpUTjFIRXhrUTBBdDYzaStFRktD?=
 =?utf-8?B?THgyWHByWXVlejJ6T3B6a2x6RDZrOWlwYm9ISm50cDNhMm0rTGJMTGQyckZo?=
 =?utf-8?B?NmNCR01WdVdXenY2V3pDTkJyVTdLbksxZHMxSVZ2RWIxRWpXbmFVQU5BRUZy?=
 =?utf-8?Q?jfS/Wu7l8cVrvA12V3G+/xU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 877191d8-17b6-43a3-da7a-08db8a027cc3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 15:52:29.4137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A49SaXnk3GU/Yu80RSbZeqviZRJdnXylGu+uisQVR18MEazOjLB+ypkLKEQ+co/nqw+8925MRxabIz8NNaZbQpP98eij353NFMst3VW7HY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 21 Jul 2023 07:56:15 -0700

> On Fri, 21 Jul 2023 19:12:25 +0800 Yunsheng Lin wrote:
>> Just to be clear, include/net/page_pool.h is still there, we are not
>> putting page_pool.h in include/net/page_pool/ and renaming it to
>> something else, right? As there is no that kind of uniformity in
>> include/net/* as far as I can see.
> 
> Like many things the uniformity is a plan which mostly exists in my head
> at this stage :) But it is somewhat inspired by include/linux/sched.*
> 
>> More specificly, yon means the below, right?
>> include/net/page_pool.h
>> include/net/page_pool/types.h
> 
> Yes.

What I meant is

include/net/page_pool/types.h
include/net/page_pool/driver.h

I'm not insisting, just to be clear :)

Thanks,
Olek

