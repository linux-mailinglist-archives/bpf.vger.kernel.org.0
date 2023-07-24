Return-Path: <bpf+bounces-5708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC5C75F2DC
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 12:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B0B1C2087D
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A685C8839;
	Mon, 24 Jul 2023 10:20:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5105679EC;
	Mon, 24 Jul 2023 10:20:27 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6002459D5;
	Mon, 24 Jul 2023 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690194017; x=1721730017;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=giB25X+MmHmu0JIOwML+Z9z6V/k+3vDE0W5XuKxgdOc=;
  b=S+wZUcmNgfubHJOYydPJie5USQnQTstvsXXvi6PR59QwWO107BMFLUsm
   sMiIPMfcwnqz6kK0PjXECx7EZZWroBJZy6eUBGkFwpnR7PnSOKsV8E/GI
   J4x1AC/MgYGKPuFWxXTqskD1BlJ4lniJ0aHF+k4Mc7c6PnDj75WlhFvjL
   nnSIiIt0rcAtGParfutmUhFogcWYDtiq8n9UmJe13PwH56hbtlHQJhkDw
   IHAMne5IUaplWBttGTqP9ExoCKamNoQ3erJp12LmOxv3LqAq6E1nZtkiN
   syXzwDch/buSA30mE68x81ym8dvV4AYaBwy9/ZnHFwvtKALQ5TuDkH2Qa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="364865222"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364865222"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:20:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="760743874"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="760743874"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 24 Jul 2023 03:20:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 03:20:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 03:20:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 03:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx8nEnANOSm3aQ7ZYsbINgocxo5RaQSIapdEWMvKRKyYTQDdrDDYdHf9zIFB6nu6HJcb8FcSi3+26O/KRwufHJxoA523M+9m9uQaIK64US4FRqwTT4dqmy8GNy+EpxFO7YQMyqPZnONeswd7su8YWUg4Bhlqr3A7ptEF/6VtQglZMgWiClu9r/go6arltHqzd8JPtQbINaB7FKX5Cm+Qhl46ezFJWcoFpi6o1eZa8qRYAC4UTuI6npRlD6mGZVqzqJbqQiLcCW5tzdqatNmFI1DTv1fspK5vvQlmIXBvzJsdGfDqLJwkohEGo9/5EIbN9z/4LbexC57hcL0ybAusiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIj0bm54IZuPLBoLAMJqF4Y6Zc5Js1ItxrM9ncaKQLA=;
 b=DfZx5QQqGPGW4tFgiSULNFA2L87uLIBFZ6mzAkoZEZnTsEquUniKOJILtOjpQAwO/7Mz9UfZ4k9cQsLMpOFa0MEthN8mNMKVf7X6VG4O+hJfaXvF01HzR22fANnG1pKPRgaPCcuZQasJWW1HW2N9oL0Yg02aNW/ioSA//wJvTt/vFNb2r8MzN3xECNcDKMCfDz8tIWRzSDalVDIBJfX8v6SUCo+QrHtxgjD4MtRmYatzwqzshjaK5IcZEsYGhkEI50G16LvjoDip4Gb1EXq2Yg2Q2T3XEY6iErWWDMqpXNBnkwVcLrRNIWvQP3LKasXlULb7J7TKUeIuqeifB1C+8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 10:20:06 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 10:20:06 +0000
Message-ID: <b28c02a8-8263-47e3-ffcf-51c992f03d30@intel.com>
Date: Mon, 24 Jul 2023 12:18:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] page_pool: split types and declarations from
 page_pool.h
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
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
References: <20230719121339.63331-1-linyunsheng@huawei.com>
 <0838ed9e-8b5c-cc93-0175-9d6cbf695dda@intel.com>
 <7e9c1276-9996-d9dd-c061-b1e66361c48b@huawei.com>
 <20230720092247.279d65f3@kernel.org>
 <f5d40062-bb0d-055b-8c02-912cfd020aca@huawei.com>
 <20230721075615.118acad4@kernel.org>
 <ccb728be-832c-be93-2023-6a5c78c53e6a@intel.com>
 <20230721182942.0ca57663@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230721182942.0ca57663@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0251.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::16) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MW3PR11MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7478ff-2e68-479d-d798-08db8c2f8d2f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIC6d87GTbwJ8Jeha9IuwPzZi+4eiTTrPVV2zl+1YEaRZKEG1lw2o3uxffc4e3cZVMVIL4J6R7yELbbT73RnDpFNpEADa/4fRkDFfJQbWRlrc7Qz2begcp2LkjqXrTm9GR4OCOR3zOemqU0AikJE8UNHr1si1/52dgvDynAwl0roTQBv1Z23ROz8K8nfvnzMRoX3padWE4NahmKDnuaJfyndCFECBY9MyVhYR/M+8wRmWA/679x9ZQxG6XlJ+oe22jUTqf1R5aYYpa1N6+PEK5HRlQ3uR6NyyihOsmorOkCaMi65sLZcKN5OlxFYjUthFJA8wNH13nxkVbm7U5kOSBKNlZI2KdSwwo+In6N+RUneT49B9JZ8YXTt4sy3gGuLR5IL6m18OWy5TBvZ8UZ6L8P9a4EcpC9RRPbx54czPtrhvVOVO/g/+el6NkGAONY1JeI6xoC7LCWczB6Fl5U+a9ADycqWpv2QojHHk9R8GBwio6KX8RsjNGiQTHn9ApSjKVzRI4UEjUc9GvQ/lT/1E+ivvxL7sZd1Zy8JNjj8DdJhDD0HVTRU9sWi36MbxPD3CCMSogxX0krLaPD620f5CqVIXPdXCIBy6FVNJaAeM0JCOxB12emHMr591WYC/sYtADTEH87qUs+ytUkQ93USaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(38100700002)(66556008)(36756003)(2616005)(7406005)(7416002)(8676002)(8936002)(5660300002)(54906003)(478600001)(66476007)(6916009)(4326008)(316002)(66946007)(41300700001)(186003)(26005)(6506007)(6486002)(6512007)(6666004)(2906002)(4744005)(31686004)(31696002)(86362001)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHJEeEN4eE14SWUydmJ3RjBzMEdDZUU0VVQxb3A2WG12MWJNZWN2eUN0SHBv?=
 =?utf-8?B?b2gzSGRtTERHNEROSEpKMTB4c3ZXNEVlcWlGTTB0WnBwQmxYejRrZFBxdmQv?=
 =?utf-8?B?T2tIbUFVWWY3UXNYR2lrMGROaUsxclFzTzZ3SzVMd1loaytjUTVkUER1Q3Ay?=
 =?utf-8?B?WEVLakZTNWd0RUQrYjFjM0tvellGRGZWV2dSdjBZT0Q3REVqbVJjTWhKVytQ?=
 =?utf-8?B?QnVUV3JRY1ptRTdpM1lYVWxLdkwyYTZVRk84V29vMTUrTjd2M2hpbXNtdjJV?=
 =?utf-8?B?RjdOdHpieVV6bmdDTXBNaVJTQ01QSVlDMVVJZHhQcG03ekNWTytvV0VSRkpi?=
 =?utf-8?B?N2NoVkd3aVNqWEliQUt3TkJMNC8wTlJtZW5MbkcvU1kzYkEvSzFMZStGYmFi?=
 =?utf-8?B?Z0Z3cFV5RWxrbTVERWtjdlBtNXgwTVJSa3VSNTdkMWFIYzVkL3Fyd3dNUHFp?=
 =?utf-8?B?NmdpaUcraXRlTzRMTGNIVC92T0xzdG9udmIvaUdTZ3BTaWNPUzlwaytEZE1R?=
 =?utf-8?B?dEVNcVhjbWd5enhOc2dyaXRraWlZZEZPS21HTGFFTU5nOTVPREN6cXNRcm1O?=
 =?utf-8?B?QjVqNXJQU0ViaGU1YXArNHhzamRjV1h1N0gzaEhjQVNOY2JYTWV1ZjJxQUZE?=
 =?utf-8?B?dlJkbVFwZytGNXFOUXFySnNzcUs0UktjRTRPZWw0dnk1MDB5bUNpOGNFemIv?=
 =?utf-8?B?bWxNMVdBOGZyNW1VeHV2bDVjaGpLeldEY2xMZUpRakFRSTFsUXF3VHFmSHRF?=
 =?utf-8?B?TTdZc0dpNW1nUzlzNTlmcml5VXd0Zkp6Rzh2NVdjZitNTnZvM0ROSmM2QU14?=
 =?utf-8?B?RW8vekluOWNBeWQra2grblpMemNlT2s1blVEWVhDQVljZmdwUkZCaVN2L0ZN?=
 =?utf-8?B?TGMvOE4zdWQ5MkRJVThnckEwQzFTOHFPc2NPTHVvQ053S2p2TFJSQ1VmL0lF?=
 =?utf-8?B?a0tQQk1yS3BMOWhaSzBEc3diVkZzZit5cThoNkRIUldrKzQ0RUs0ODZ1V0hL?=
 =?utf-8?B?RWRCMUFIcHQ3dnAwK0ZWYXNjR3pqOEc3UDMySE1ZVVJWMUlaejlEdlE5VE9G?=
 =?utf-8?B?b2hiNHdGS2c5bnRqZ0wzTm56RnhLeHlvRUQyNjNiS1E1UXN3aEtDRWcvOVlN?=
 =?utf-8?B?YUpBTHp6R0g4VytDQjNLa3EzUFlvb01ud3RoSEp3dUoydGc1dmM0c2EycHB2?=
 =?utf-8?B?RUNwMEdjb1gxODEwd1JwN3Nzdlc2eGkxanJlMEU2U3dHR3MzaTJPaUlDc0NE?=
 =?utf-8?B?U3dKRUVrZjJZWXdNcjIvdGR4b0h1bFFMckkvcEVWNncvckhVN2xSRElvdVJq?=
 =?utf-8?B?SjlqekVuUjdEd1grdS9OQVRwWlBHV1UyQnY1ejVUaGp5UkZrd3ZDeXZzdzBS?=
 =?utf-8?B?OFRKbUwrZUFGaXMvVi8rdnN6TzBmLzBHZGhCREN1SW5hS1lZclllYWVxRVJs?=
 =?utf-8?B?RFBtSjlrTkFxZVNWUUF6MlltMVh3dXg4czJTdjBWNHJRL2QrTEgyaEg3SnN0?=
 =?utf-8?B?aVEzbjFvRHdtdkx6dXFjNlo5Q0pZaUdPajBQQkEzSFhOaHVMRG5mMHBvL3k5?=
 =?utf-8?B?dTRVL25UN1hXTzdYZkdpUmp3Tld1UjVyOStSNjg1a0J1MmNaaU5tZXlUZHpP?=
 =?utf-8?B?YWNQU1VPZ0hqVHRMMTUzVm9kS09yR2FZY3lRZzA0d3VVcGNCN2x5YjEyT1I0?=
 =?utf-8?B?M2xCeXI3WURlSGFNZmlscDlUWG9HMzVMdlJsUG14VXRGY3pUVEhoR1VSZnIz?=
 =?utf-8?B?MkxxZmFyZzAvczZWUDlUK0tMTWMzMk5ZUzkwWnFDeDBkSDc0c0hHS3l3WkU3?=
 =?utf-8?B?K2NUVm4xNTB4R09waVd3NGw2TVFNUVNyc1JmbExGZG9NQkhHT3BQM3B4Q2RV?=
 =?utf-8?B?azY4TEs4QWhaTjNCUjdZa2MyaENqSk94OFdIK25yWDFuNm5iU3JaYjNSM0F5?=
 =?utf-8?B?QzlURi9yaUFwbXdXaDRiQjArMWo4bGt4QWt1RThXR0sybXpIckY2T09TeEVI?=
 =?utf-8?B?aHYwZEZLYjRzVUxjU2ppelpZTXZDMHhQL1lmWUdQM2hPQVp4NzdZeHJkTktP?=
 =?utf-8?B?Y0lIZmUvakE4SkozVG9oK0FlRWpkS2NXeUI5Q1kwb2d0VGd0S0syMC9EdFVP?=
 =?utf-8?B?V1BGaXJVNlFwOFo3VmNrQi9lYVV6MUJIbjFySjlpR09KaHcyMkZxbCtad0Fr?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7478ff-2e68-479d-d798-08db8c2f8d2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 10:20:06.6307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TL2Q7TyOIolAbY79Cl04XWkcrxHCPh+pXCIucwP/RSnfKmHbPXpJeBfqHNIbnfq9WldxPzNpdpjmld6vr5BhWYbiOGEULWQu6ap8yzFBfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 21 Jul 2023 18:29:42 -0700

> On Fri, 21 Jul 2023 17:51:17 +0200 Alexander Lobakin wrote:
>>>> More specificly, yon means the below, right?
>>>> include/net/page_pool.h
>>>> include/net/page_pool/types.h  
>>>
>>> Yes.  
>>
>> What I meant is
>>
>> include/net/page_pool/types.h
>> include/net/page_pool/driver.h
>>
>> I'm not insisting, just to be clear :)
> 
> I thought we already talked about naming headers after the user :S
> Unless you're _defining_ a driver in driver.h that's not a good name.
> types.h, helpers.h, functions.h, dma.h are good names.

Ah, sure :) I was mostly talking about

include/net/page_pool.h
include/net/page_pool/types.h

vs

include/net/page_pool/helpers.h (or functions.h)
include/net/page_pool/types.h

I.e. whether to have a header with the same name next to the folder or
place everything in that folder.

Thanks,
Olek

