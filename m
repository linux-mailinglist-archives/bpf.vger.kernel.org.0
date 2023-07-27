Return-Path: <bpf+bounces-6079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E338076557D
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 16:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6371C216A3
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86EE174FF;
	Thu, 27 Jul 2023 13:59:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96632174D7;
	Thu, 27 Jul 2023 13:59:54 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175D1E64;
	Thu, 27 Jul 2023 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690466393; x=1722002393;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vkg/mqQ46Y9mPZoc+KaIvbvQ3eb5+VxxTHq4ORYI3ek=;
  b=Hgocs6HzYXLOCyF1tT3W6nQQ0zUw1gsYp1uueaFZfu3R+j/GqPzl0BQ4
   kZf0dM0eMs+967SheDmpIMO+vAPIBKq4a2HzvsIyPZ6yATX1qWyBZJgCh
   6NlohWyPCtpKCsVtiV4lhUOWk+od2iMivc0onBOYkOT/8lZEANgZFDluw
   H3wkcZ21uMA/tbRkE4munKy+X95O8zNKHsqvvdyAsiyE8jDJexqJj4yfx
   ebE8fipTtTfnkd9W1IjccEfE2+7Ed2FLEZEDOxeKPQDyAUJEsbZ+Wpj4P
   p39Ie0rXWFlvBWP62VzGBjfvm0fLCEDZ58AqTSNk5hl9v8+/OX1i1qGIh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454678427"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="454678427"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="762170229"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="762170229"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 27 Jul 2023 06:59:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 06:59:49 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 06:59:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 06:59:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 06:59:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7hhYQbB0r5TBqJnI88bKuzR1z87PK0XaTlKd4R/YIKTxtgVN1nqZj46E8aaqn2evSQVOCGVNqxdWdB09ws1ZfwyCIKA0uQlioVC/SCJ+HmM3ohsXjcQSfa/zt435WXo0II/qTWU7HmnVJ0HlmhJN6zzWCHrJOvFpO7Gp1P9+mlg4WxwOuNVDpNMFJ3SxXnRLI4BUjyGSGOSbQhJ1zdayw4e0fTXWp39758F5CLGkPUOb4icBlCwC1QUmpXPp/XcgO3EvZKzBLzTeJ8JMf5RRZj8fhgxjNnGAj3v7n24WXF/FdnywBOp1tuWlWztWMKfs3Yt+E00CtWpFkrPvO5k2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeaq49+bvkIoz1hpvMcz9h76IMsggF6K7bewtGain/g=;
 b=FUfQnKKLKreusN5vvvCNRNdcJ9alH/SBsJFxVwLmw+U6YJi2xhpD+ronGKslwMQglPZxUseP11FCy31vBG+BZEBMB7t/A5nkBtueQVg8xItrfSOErzV8DQywup1PWhVa4CXs1uAWV5WVbXwZMviw3gtQwSgESSQV//vExxxmTZWHPGjJicQyMg1hdN7sUtUMmDtZ7yYCYIApqDaq9wUWbvKLOqula4Xt8fxYFnV9Q+UFRZoGoRMwaZApRH/QXqgf9zNfkXF5u3f3kZsZC3BYOeun205WYoIGNLyivoZ6z1An/kg3qsTujTGfhnlXSxB3ve6+msKsfWvbGx1xYhKtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BL1PR11MB5367.namprd11.prod.outlook.com (2603:10b6:208:318::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 13:59:47 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 13:59:47 +0000
Message-ID: <39dbeb07-0328-6126-4f38-c1c5dd7e0dee@intel.com>
Date: Thu, 27 Jul 2023 15:58:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2] page_pool: split types and declarations from
 page_pool.h
To: Yunsheng Lin <linyunsheng@huawei.com>
CC: Jakub Kicinski <kuba@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
References: <20230725131258.31306-1-linyunsheng@huawei.com>
 <ZL/fVF7WetuLgB0l@hera> <20230725141223.19c1c34c@kernel.org>
 <a5d91458-d494-6000-7607-0f17c4461b6e@intel.com>
 <20230726084742.7dc67c79@kernel.org>
 <d6dd7cb3-5d06-cc1d-ff0d-6933cb9994b9@huawei.com>
Content-Language: en-US
In-Reply-To: <d6dd7cb3-5d06-cc1d-ff0d-6933cb9994b9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0490.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BL1PR11MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d98772-1def-4d27-0b83-08db8ea9bc88
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76nVXKNjGOHCi6teynuK/J/GkbVZFACOpyFcD7cllnkiisVTYEmsaNALIfXHMH5NE9NVYQkP5rUDE2MZg3w5LmOFuR4A9ehv+AVoa7l8cMlsRBDemhKvseBh5kMXEmd8KZUx1RmyL/FUCYhzNoFC9T5e1bBk+UcZSE9Wq0qjR01Q1j7f3hc6eR2L/k440T0Y5lhYlVyGm7EsotM8VhQYTYxnbIqLRdkVaF7caUnHvxGxzwtuHmsaZWoI9rYHUyHbZTLKQaZ4Y73ohoi9pAuwgf59E2XG3h5p54QaTRQhoIDtfjC71w+S0drwkbEYOyB06TWpgojdo5BLrnHTWuo8CuG1BQX3Bxj47bnuLs9tuwAOWuEJ/ZXhNHZSiBWayDpEIzHiC3RONvJiOcUUVDEjmvGsNjB2DYaemf/gIr0rXgrLNBB3aPqrDTA73z6uzhIDNFurWVyep7Ks/3F+ppoFG3KrnjOok4Mb2gHwDsAM/gT8vpETs+YBEz3wZUoiRvbcU6B6x7ABbybmsCM07GjqHx2snZAR1T3ONcoNgO47jRPgoKEk9lOmfJNIp2zkXwpNCaLR3PbACYHp/tioao4WFfor+bfQtLHIdcSYPtawCbiKV+i9P3Cle4c7NanQzMcQ1OmzlaXEn9S86x8U1NHNEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(86362001)(31696002)(38100700002)(186003)(26005)(41300700001)(6506007)(53546011)(8936002)(6512007)(2616005)(83380400001)(31686004)(966005)(6486002)(6666004)(478600001)(82960400001)(5660300002)(2906002)(54906003)(36756003)(7406005)(7416002)(8676002)(4326008)(316002)(66556008)(66946007)(6916009)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZqUHRnSThVMms4b2lpU3hqN050RkxQR1hQQldwNWxrTG1uU3BCSjcrUnZa?=
 =?utf-8?B?aVhWT3lLSW91WWxMVGdpcXViTk45T3NjaHVLdDN1RlJvQjdyM1BWNWVuTE5X?=
 =?utf-8?B?TW5xOVVRaFNETk5EUDNYMmsrZVZHWVFQS0NLcE5iQm9lQjFPdGg4cDdpRlpq?=
 =?utf-8?B?VXR4eVlxOE5DMTNINlBUMjk2b3Y0QlFRVlVsWmNNVVVJUUdkd0k0MFhyNzJF?=
 =?utf-8?B?cmxLZEVTa1puVHZUTzVyV3F4cVc0UlJYa3FVTnVydUYvemh0SXdVM3VGdUJp?=
 =?utf-8?B?aUZuL1VnLzAvUGJNMWQxSWNvVkZtbWdkZUhVazFZaWExeEZDcm8xV0Z4VXBt?=
 =?utf-8?B?bVplOEdvUCs4aWhYaHloeDlNRnRyVkN0c0pwNXhYL1BGMVhRU2Y0Q2p1M0k1?=
 =?utf-8?B?UVR4eDNiSVFjOWpmUWpCUUVPRDRQK3I3eklwWW5PY0k2QVh6ald6SGNYRC94?=
 =?utf-8?B?Y2xrV2hhcGdmTFRkSUNlMStvNjY0LzlzYVlUZEVtdEg5TXNBanhZZjh2ZEJP?=
 =?utf-8?B?a05Zcm1zNjBPRWdBMVhKYnJlbENHbzVYa0xlb3FaUmxIRzJ4V1Q3b1BBeXFE?=
 =?utf-8?B?T3pQS0hRQ2EydmxCcGV2NUNSSE5HanVhYkozZ0d5TkRRYitOL0RzQklBV3VP?=
 =?utf-8?B?UmhSdDcyZmVSbXc4OHk5OXdLWnc3Nm9kVFB4TE92UlJzU0h1ZXhTVjFwcHdE?=
 =?utf-8?B?NlY5UllFZkROTDkwODc0SXhJQWNuNGk5MC9OdDdFcFhDaVVqOG96ditWRGJX?=
 =?utf-8?B?eU95dWEzMnpDVzZCeWFQbWlVSjlFczJvMjFaTnkyTWo2ZFFjSldwTUxpK1dC?=
 =?utf-8?B?ZHBBTXV6Ykxlc05RYStOcFYzSS9qT0NHQzlUY0w2b3BqZ3hUQmdaYjNoL3pj?=
 =?utf-8?B?b1JvLzlnTmNIdXBlcjFEMnMrUmdsbjRhOFNKNGJtNE5IZGZtbXhnWnVhZW42?=
 =?utf-8?B?T0hKNkpxdFBmWndqYjJDc3c4THp5alg4MHhyK1h0aWFUTVlmRlhUcmxONWR3?=
 =?utf-8?B?Skw0QUQxdlR5YlE2cDlaOUFOcUVMdTYvZ2lwVGFyRjQzbVNhck9QaklIRUxi?=
 =?utf-8?B?Wml6TUJKQk5LOVVTZWw1a2dhU3liMWIvS2YvWTZPeU80ck96a255Wk13LzFQ?=
 =?utf-8?B?SS90ZmFtbVhvRjM2N3p1ekZ2d0dub0kxNHpZaDAzaTBBWXVsVDhPMjRuSHhI?=
 =?utf-8?B?Kytvd1l0S3RnS3dEeTJVbExaSzVKWWVxU3gvRTdXMFlDVjBKMEkzZ3lDRVow?=
 =?utf-8?B?U2xGYUhPbEhOQUdWa2hmdGp6SVQvVDFLYi9tYkNONlpKamlWOFU3RmpQT3R5?=
 =?utf-8?B?NVFsTUkrYjBQV2RZcnRKTHN6c09LSVROOVl4VEd0cG1MaVNRVDVNeEx6dDgv?=
 =?utf-8?B?NWltKzZ0NFQ3NWpGb1NrN0NodE9idWFCRGhvcTA5ZW9Bcjc2SjJxbjgxcTZC?=
 =?utf-8?B?RmVZOUV5dEZLSS9xWDg5UWlGdnBqcmZJL2wrbE9rbTR4amRKeHNLYkFEelRj?=
 =?utf-8?B?VXVhMXJDVFJNMGx6ZVhiMEI2Sml0cklGQVVFVzBsU0FENXVwTjNGN1NPaTBP?=
 =?utf-8?B?cTcxdVZ5a0Z3K2JWR0w0MmgydEJMcXRuRGR0RlJ6Q013b1hrKzhDZFllUW50?=
 =?utf-8?B?U3J0MnlnZktmVUxhUkZFSi9LakVLdHJSeDNLNTJLSHNTTUJqc3dyYUNDd2JV?=
 =?utf-8?B?WVJTaUVSVkRSTnNGQzQ2aDlDUXRYdDdXK1NPUG8zd3VaUFdQMUNvdVF4NTBv?=
 =?utf-8?B?NUlhcjY1d1R4VDArRTVRUWtHejcranlJcWFrTGFaU0MzTWJDVHVQNjNGRXVz?=
 =?utf-8?B?NjdzMEV4Zkd0UDVOU1c1dGVSTUp4aFFQVFU5YUZLajltWHhJbVBWUGtWTkpZ?=
 =?utf-8?B?SGZybFhIa0NyeDFpcjlJREM4ZWZBcGdmVFdiQXFBRDcxbWxpVjRCZUNVWlVH?=
 =?utf-8?B?RTIvMGtUQTRPbEdUblh6VG81M2tCb1NReWp4V2lEVDhNcGN4UzRVMEN0Zndm?=
 =?utf-8?B?Zm5ZSENvZDdoMGZzWXhmYXFWT2hMeXpTNk8yN1I3WkJ0T0htWVZhTmEwdW5q?=
 =?utf-8?B?NW9OSG9iaC9kM3BoWi9SN201Qi9EaTErMm5iZHhwWFc5WGRZMUgySGxnczRB?=
 =?utf-8?B?VWxUbUNVZThkWXZ0dlFnaEVScFRkdlZxM2tmaGtDY0xPejhVZDhlOERNb29P?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d98772-1def-4d27-0b83-08db8ea9bc88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 13:59:46.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJGpfMmt53gVlqXY5XhYBjn4QAeyyQ29VOjYcAVhn52DDn8ycdH2n9CL22yD0cHNFlplC6PM1U8b1Zn/nsaOniMnQUuaHPcV+9NplS3jON0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5367
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Thu, 27 Jul 2023 19:47:23 +0800

> On 2023/7/26 23:47, Jakub Kicinski wrote:
>> On Wed, 26 Jul 2023 12:48:05 +0200 Alexander Lobakin wrote:
>>>> I prefer the more systematic approach of creating a separate types.h
>>>> file, so I don't have to keep chasing people or cleaning up the include
>>>> hell myself. I think it should be adopted more widely going forward,
>>>> it's not just about the page pool.  
>>>
>>> I have this patch reworked to introduce
>>> include/net/page_pool/{types,helpers}.h in my tree, maybe someone could
>>> take a quick look[0] and say if this works while I'm preparing the next
>>> version for sending? Not the most MLish way, I know :s
>>>
>>> [0]
>>> https://github.com/alobakin/linux/commit/19741ee072c32eb1d30033cd4fcb236d1c00bfbf
>>
>> LGTM!
> 
> Hi, Alexander
> It seems you have taken it and adjust it accordingly, do you mind sending
> the next version along with your patchset, so that there is less patch
> conflict for both of us:)

Sure, I'm planning to do that, just had some work burden. I'm sending
the next rev today if everything goes fine.

> 
>>
>> .
>>

Thanks,
Olek

