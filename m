Return-Path: <bpf+bounces-5975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C35763B71
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 17:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C4D281D37
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE5726B70;
	Wed, 26 Jul 2023 15:43:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707D1DA2A;
	Wed, 26 Jul 2023 15:43:11 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A282AE47;
	Wed, 26 Jul 2023 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690386189; x=1721922189;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8UWgD25TwBKw6wrPYeEDDVHcfGNZMdJSIB299DOtp5I=;
  b=W27NzJjC0MjWEW82DSPhJTudzySGaplkLF2OF0rSmAUJbVp9nhPHMoCW
   ofGBs3ZX5Fo+UVhcV6n16ubpmxetXB25byaVF6Ut6i0kLzH7TsbQf4XM2
   SCidnSXLUGrpWG/Yg3QCnLfAU2QXq122a4XhWpYaSWcr5BbwKftNBAAsi
   fPL4b3l5eZGapdPs79SQmB8Pz4eIRRN2a6ffKB9GzbUjemw0jmvBW3K4w
   xwJ88cOP2pv15ofdg8eFye1igSdKTHOfdsP7qrUmIEQqxUy2oiBp/yYd8
   VDFykuut6M0WZ07iI7IpTjj5CFCpcFNz4kpXLNpyAxog9GSnceMqcJQUo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="434318535"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="434318535"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 08:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="850499194"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="850499194"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2023 08:43:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 08:43:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 08:43:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 08:43:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYxfRjzNFASg/V6mwtpMTLN90z1FONRKfsD6R6ses5evSu8GmBNuKCDnkDtk3ZhU+yvb2EW2P4/lmXVnlv3+dv0IJQXhxBc4plhb5z0RM6fjoDekeBxK8/cQYLZXWsdI/1hqa9oW0frJUVm1w1qF2ilovy86k1pHIuzgWS6+YNGNWzBblv0IpZsfYu+nf9EjDWgVoVXCAPEuszS4oUtOXxfwWn4UyTjk2xwEbpWSL+X39sBc0qMVyTXlVau8oF7TIb9f/zvZQj0k+t8lFPZ6iYwZXUsn2Xufva2dxLUlAwNKRZEh4z4MSOFgAPfrNDD3glQkCuwyk2G9NQA1EPVcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypSj+oZcPc5MWUqkCQ8KBNC3VdYLQIgVzcxTbagMQf8=;
 b=mODANfetP29Ov6vJnXFn2ol47nkBb3LFvGLmqCmZR5fSMKsp3k2WE75782zXX46MSWdD6bbm5HZK3/3DNoMTRXQjdJtNzwHZMFwSp5V3kTCNh3BrwO3Lt7KMlp7Jnlg2oxopl1Wu8hEG7SWLKBQYCCeV+59qxj12p7yXN7Mt9xzICrKt/3RSBvNHw820+C/oKLtIbHWjaAlaoyC4z5ezuLKKOAFPyfsMZHzE2pv9XSAboCkkLvZrMcvuFfyAG39m9BTHE/Fv+Zm8F/KS/k2jq/r3Z3HSS/EkC2BdWsGaL6CCxOkWVnE4Q4KLZynhFvdTsUkIQbuWknn1AiMvTyM8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH8PR11MB6951.namprd11.prod.outlook.com (2603:10b6:510:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 15:43:03 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 15:43:03 +0000
Message-ID: <32898263-df74-1cb9-c639-f46a94311687@intel.com>
Date: Wed, 26 Jul 2023 17:41:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations from
 page_pool.h
Content-Language: en-US
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Sunil Goutham
	<sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, "Subbaraya
 Sundeep" <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
	<lorenzo@kernel.org>, "Ryder Lee" <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, "Sean Wang" <sean.wang@mediatek.com>, Kalle Valo
	<kvalo@kernel.org>, "Matthias Brugger" <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
References: <20230725131258.31306-1-linyunsheng@huawei.com>
 <94272ffed7636c4c92fcc73ccfc15236dd8e47dc.camel@gmail.com>
 <16b4ab57-dfb0-2c1d-9be1-57da30dff3c3@intel.com>
 <22af47fe-1347-3e32-70bf-745d833e88b9@huawei.com>
 <CAKgT0UcU4RJj0SMQiVM8oZu86ZzK+5NjzZ2ELg_yWZyWGr04PA@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAKgT0UcU4RJj0SMQiVM8oZu86ZzK+5NjzZ2ELg_yWZyWGr04PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH8PR11MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: a84b16e4-49a2-4da7-3eea-08db8deeff3a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icTou5HsNiwoBZs214/SRyc9RhlizswErqHBn6fngUmqawHbDAYp3dSUd9GXc5qz0aF7h4DMQqFLPVbedM8wzPseFqIU9ZGtqqbHplKNe3pGxHGza1FiPmWNDJ/DLashGhozXY3cuI33mO4yxgBKjZUNwHaHW/diAV9AY0A1dhWusK+5UFdHauK0FYFGdGgFY3m43EtncxAStw+v9hzqgppRnOEpXGU2bSrTUrkDxS4zuW+3/S9LqYSrmM65FfAIzew6wMgT9HAm1a2vAFbUeNN//o3MGKiiL2an+nDbzsjz8LIfSMYP332nb+TE2NSYt0ZhBeHQeJp9rcQojAOyvLoKgvo2U4PsujmOyGxaz91TaBkiEHo7iE1qWYhmxKrnMTMi5pOGhq5NhQpJSY3d9JOSvW/fu07WpponTWwBG8YZwjbK4yXuYvvUnnLi1+nYDuyg3j1nQEjkS80vnY2hfMGNHVo9qewk6LvHBZSXt8dpUWxmZwVa4LpeD9xLDhi41s2GQj3b70eXS44uwAMz8x7suXTFpEZrGn6Wpn8KGUwZgb2SV9pEMMmL+gwQC32CXudVXAoCq3yoo2ICIQmst6fQuOJlQiWzSvJwImYMvBMC8L931BjxxdKz/8K+6yMW+mXHFU9TFqqJ9nKsqIa/XMwKR3Qd7UWesO1CWl0TGXTOau1vR9ArAsmdGo/eM/l4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(31686004)(7416002)(7406005)(8676002)(8936002)(5660300002)(41300700001)(316002)(4326008)(2906002)(6916009)(6486002)(54906003)(66476007)(66556008)(66946007)(26005)(186003)(6506007)(53546011)(6666004)(6512007)(966005)(82960400001)(31696002)(86362001)(36756003)(2616005)(83380400001)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJKRThIU2xpWEVCWkdNRzNMZXpybjdTQ1VCRW5tUVl6SWdjWTExZ3ZFeVhO?=
 =?utf-8?B?RUxucjRiM2t2VG5VRHEzQ2xjSnhyaWxqS29qdi9JMmpDZUI1OHNoeWgvdjNC?=
 =?utf-8?B?M0pzRVZ3d1U1TXdPbXdiYi9SOHF1eDNWUWRpNUsxYTlnQ2tpblZHbXlNK1hL?=
 =?utf-8?B?UXNxQ3BlLzB6YkVyb2hnWDdnUVl6SkdUeW4zTU5lR0ZzaG4wQ0JzdWFDVWFX?=
 =?utf-8?B?bEV3SW13eVd1RCtBWSs1dC9rQ0NXQXJPZFJtMCtwd0dvLzZraEtlcTl6cjQ5?=
 =?utf-8?B?MHhCYnkrdnFrcEdLZ0E0K1JEUWdBWkltcFM1b2VlSlk2K1NpejU4WUwvOTRj?=
 =?utf-8?B?cVZaRXFsOTgxYUVjK1E2UzdmMDBqZHYvZ1loYVEwME9CcUNUQ1Z3eFdvYzlR?=
 =?utf-8?B?M294MHZML1RLdk5DMWdBVy9PV20yYkNSV1g4ZGl6R01sYU9PK25uNm5kN2xy?=
 =?utf-8?B?UWI1cGlYekZnaHk1WVRqL3NaOGEzNFdPRUxQbnJGellQdHFMK0RkcDNiZFFl?=
 =?utf-8?B?VFFreHlKQy83cW1nbTFVa2dTdURNc1dCL3k3V051OTNYRlZ1ekhTdHB4Tnh0?=
 =?utf-8?B?SHdpUTJmTkFHZUltT2EzVG95N0ZtWWpOc3VPN2lkMnFTaWxXdXBub2Q1SnBo?=
 =?utf-8?B?U2NXNmtQYnNQYkFjYXZNQjAvUC9IeFVPYUpTMURpS0xOSHZNa0ZhUkYzYlNL?=
 =?utf-8?B?SlJtU21HS01MOGxGRXNvaldBMHZ5SU93WmxXeHhhK3JFREsvZmRIQU0wMWZC?=
 =?utf-8?B?bE9VdkhUMmZlcGZuQXE3ZEJzSFZMQ3g5YnFsVU8zQmJXNmRuVVhvemZYaG1M?=
 =?utf-8?B?Nlc5UEwxTW9aVytXdjh5MGprNE5mcHpLdVB6TWdiWUhTTkpJd1hKRXhlRWlj?=
 =?utf-8?B?RW82T0hadExNRTArVW5GWmpkNWxWd1VHNFowcS9idnNaemwyM0RRS2lHTFRv?=
 =?utf-8?B?N3BFc0p4ZFJROUFoT1ROQWhzcVdCTEF3QzNRQWV5a2ZUVWRyc1o2cmk3QXVU?=
 =?utf-8?B?ZHNzVm1YSktaV2NBbmNpZFNZTlA4R0o2ZFpuRUpvVlJMWHZTR1cwOTRVTnNP?=
 =?utf-8?B?bkNDNUFLNm5GYzZhaEdxc0tBcW00N0E1N3l5azZSc042UUwybERBRDBIaHBU?=
 =?utf-8?B?b0ZqdFNRMGFmYkFKemdZNkEraVBuZlh3OThVTTBkdlNYY1JoT2JxcnA4QnJG?=
 =?utf-8?B?NWdBb1JmQjQ4NXdRa1ByeWVnNHVaR0NUQ0pMclZBYnNPWUFVTmk2ajNBU3Ix?=
 =?utf-8?B?UkF2SGN1TisvdkhqTDRKLzVOeHFIaVdlQm9OeUZJQis5V2JFR2V5bzdpK1pO?=
 =?utf-8?B?d1NPTElZaTd0S0k2TlMySk45MlZFUXRTeGVoYnRYWndGVUlBZE1WMFQrMWVs?=
 =?utf-8?B?Y05aeGtLcHhjbmd0eXkzRGFVWnBuc1BBZnRpK2l5MkJlVm91cHVTUHQwZkhR?=
 =?utf-8?B?VElQYXgvc3p3enE0MGRkYXM1cGg3eEw0c0YwN1pDOXZwK2tIUUEwNzdPcjMy?=
 =?utf-8?B?dVBXZnlQNkxiYU5SczNmVUZyMWozbVdldUJYRkNhdy9qdFpNM093NUI0L2pk?=
 =?utf-8?B?U1VhL1BSdzgxUk9OUFFBTXVjREVMVjBFNHRoZ3A0QmpiMVNSY0lsOUR6bDRW?=
 =?utf-8?B?RkFaWmhFODRpNUZxQlRId2lZSVExM2lGVmFZb2lTazFXaXM1aUxobGovSkFi?=
 =?utf-8?B?VVorUUFWem94TkRkazN3MTVrbTRHeENwL3ZxWkZEdGpNdDFiZm5iZVhqbklB?=
 =?utf-8?B?SG5yb05EbmxRNDh4N2hlcjJQS1NaVUJPSHJoZUNYTkhRWVd0b2dNRy9zbEhH?=
 =?utf-8?B?Y3JzS00zZGN2RFlzTHhQOHFjREFRTC9IOEFrbnBaU0VuSjJOaFozU0greEVY?=
 =?utf-8?B?eExvbklYa3BPTjlCdEhIM2U3VTd0MWpFNkQwNFZxSjY0ZkEvdE1QTkNKa3Yx?=
 =?utf-8?B?ek5pTHBHWWlCYmFqK1dWaEtPejlzSDlHbStvN3E0NUdhYjJGT2lPQnJkOFdj?=
 =?utf-8?B?dHEzbjBXRmdkbXl6NjNVMDdQRCt1NmY1V0huZ29aZnNKdnhxTDQvNXVjOHlM?=
 =?utf-8?B?b1lRYWZBRDRHMGpSTTd5cDhCTmtRNGJ4U2x6K0xLKzNkditRREtMZ0hjVk9u?=
 =?utf-8?B?enlvWSt3RHRoZEI1VTR2NG15Q2hhR1RoOGpVZXlMYzlaNjV3SDMvVmtmeFdz?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a84b16e4-49a2-4da7-3eea-08db8deeff3a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 15:43:02.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9uBxchpzXIguKKa6vSe2XLVGJuqbA1dKc48kd2xMNU1B14Qgh713sL0FP1YpePHILCxhFpSZ710gcnA3ywYw5JFBVBi/3dGAnmY9NMyBZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6951
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 26 Jul 2023 08:30:17 -0700

> On Wed, Jul 26, 2023 at 4:23 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2023/7/26 18:43, Alexander Lobakin wrote:
>>> From: Alexander H Duyck <alexander.duyck@gmail.com>
>>> Date: Tue, 25 Jul 2023 08:47:46 -0700
>>>
>>>> On Tue, 2023-07-25 at 21:12 +0800, Yunsheng Lin wrote:
>>>>> Split types and pure function declarations from page_pool.h
>>>>> and add them in page_pool/types.h, so that C sources can
>>>>> include page_pool.h and headers should generally only include
>>>>> page_pool/types.h as suggested by jakub.
>>>>>
>>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>>>>> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>
>>> [...]
>>>
>>>>> +/* Caller must provide appropriate safe context, e.g. NAPI. */
>>>>> +void page_pool_update_nid(struct page_pool *pool, int new_nid);
>>>>> +
>>>>> +#endif /* _NET_PAGE_POOL_H */
>>>>
>>>>
>>>> This seems kind of overkill for what is needed. It seems like the
>>>> general thought process with splitting this was so that you had just
>>>> the minimum of what is needed to support skbuff.h and the functions
>>>> declared there. The rest of this would then be added via the .h to the
>>>> .c files that will actually be calling the functions.
>>>>
>>>> By that logic I think the only thing we really need is the function
>>>> declaration for page_pool_return_skb_page moved into skbuff.h. We could
>>>> then just remove page_pool.h from skbuff.h couldn't we?
>>>
>>> This patch is not to drop page_pool.h include from skbuff.h.
>>> This is more future-proof (since I'm dropping this include anyway in my
>>> series) to have includes organized and prevent cases like that one with
>>> skbuff.h from happening. And to save some CPU cycles on preprocessing if
>>> that makes sense.
>>
>> The suggestion is from below:
>>
>> https://lore.kernel.org/all/20230710113841.482cbeac@kernel.org/
> 
> I get that. But it seemed like your types.h is full of inline
> functions. That is what I was responding to. I would leave the inline

Ah, okay. So this was reply to my proposal, not Yunsheng's. I missed
that ._.

> functions in page_pool.h unless there is some significant need for
> them.

Only in order to not have the same functions defined in either types.h
or helpers.h depending on the kernel configuration -- this is
counter-intuitive and doesn't allow to use types.h when we don't need
driver-facing API.
Those inlines don't require any includes and 99% of them are empty (with
1% returning true/false depending on the kernel conf). What's the point
of breaking declaration consistency if we don't win anything?

> 
>>>
>>>>
>>>> Another thing we could consider doing is looking at splitting things up
>>>> so that we had a include file in net/core/page_pool.h to handle some of
>>>> the cases where we are just linking the page_pool bits to other core
>>>> file bits such as xdp.c and skbuff.c.
>>
>> I suppose the above suggestion is about splitting or naming by
>> the user as the discussed in the below thread?
>> https://lore.kernel.org/all/20230721182942.0ca57663@kernel.org/
> 
> Actually my suggestion is more about defining boundaries for what is
> meant to be used by drivers and what isn't. The stuff you could keep

helpers.h is to be used by drivers, types.h by kernel core. Mostly :D

> in net/core/page_pool.h would only be usable by the files in net/core/
> whereas the stuff you are keeping in the include/net/ folder is usable
> by drivers. It is meant to prevent things like what you were
> complaining about with the Mellanox drivers making use of interfaces

You mean abusing DMA allocation function by manual rewriting of device's
NUMA node? If you want to avoid that, you need to make struct device
private, I don't think it's a good idea. Otherwise, there will always be
a room for exploiting the internals up to some point.

> you didn't intend them to use.
> 
> So for example you could pull out functions like
> page_pool_return_skb_page, page_pool_use_xdp_mem,
> page_pool_update_nid, and the like and look at relocating them into

update_nid() is used by drivers.

> the net/core/ folder and thereby prevent abuse of those functions by
> drivers.

I don't think there are that many internal functions, so that it would
be worth separate header.

Thanks,
Olek

