Return-Path: <bpf+bounces-5722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63375FA7E
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 17:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFFF28123C
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73056DDBD;
	Mon, 24 Jul 2023 15:14:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6AA8839;
	Mon, 24 Jul 2023 15:14:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2120.outbound.protection.outlook.com [40.107.94.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08FC12F;
	Mon, 24 Jul 2023 08:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yeu96kc3BEWEABHL1DQ2hdvPWbmqU5Z4nb40hTv/rNko7VJIphN6Di1lXN5nztzg5Tvv2WGnXxCKzAv6i3pTAF+kW4Cyoep2/M8l3vofywmUgXpjBAD4LZuSG3FnsOS3SjGNOgoCHzrvt366NHqmzT2kiTFNHLETtebCAweu7R2H3qryWRaZh19pUfRdsQVyeydwPeznNRIlgC3oykk+O0yjuP+BPUNLOcPYKbAPces3/tACkF16zBBBEqKwqJOn5cBGqg3NNQKzbmTcfbSaZe2hL6Ky035Y4jisrcDik96pO7AuFzpaAU4YcHULM2cXR/pIkxtuTEUMX4MHOm7Xxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ko8vwzn7rJbzVj/grkCsigEnZ0wf/Zc2zL4N2Nm7KBU=;
 b=BREVmN/8aFmgdOfzINHZrkJCLMnQvlmiNqdJFUPijtf3iihCqVjaUXCGrS1Q19QlaTUCUBha3O9++0tkaWYq22/Q967FWVodIz4rh3pGp+tHqzJWpLQAuaglXVlcb20W/R9UNV4iYhrKNKnWWjlJw1039wapDuPIcfxKonuE28JaMt/Q+9aLHw8nZB/15CBd8RBAqew1bOFO4V8YlLWvRHjYUFDcHd/bZbSjFJCWs0ct/Lb9q5SQ+zYLQs/okx4rkX/lCSPQPFHCygarOOr0lO3YAU/yfc7g7SGNclmhW1LCzXOz1Hl2KTci8GF7xS4P/7sLMPwRSxrqG029gcBl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ko8vwzn7rJbzVj/grkCsigEnZ0wf/Zc2zL4N2Nm7KBU=;
 b=urLp//67b62r0XCJi2kR5lFLPE5V42VnEVRaE7JqmJbD75/7bg12RjG2zdVibTCUe+OwecAiWqY7SlsjlzSPrbDxrr56eEedlmqscuVNvq22P5TXPvrTcyKKFlqhwi6A5KB5d0D37ji9md9f/7OvvOeCllkJZulmPtKSihLgc0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by LV8PR13MB6327.namprd13.prod.outlook.com (2603:10b6:408:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 15:14:12 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:14:11 +0000
Date: Mon, 24 Jul 2023 17:14:01 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] page_pool: split types and declarations from
 page_pool.h
Message-ID: <ZL6VOQ4SL/Zk0FdL@corigine.com>
References: <20230719121339.63331-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719121339.63331-1-linyunsheng@huawei.com>
X-ClientProxiedBy: AS4P195CA0004.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|LV8PR13MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 703a2687-4c5b-4ae3-a049-08db8c58a29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cIbzEvJAX9LAgudA/o3TwKgXNcAf1+H+FXnWHHKYgnqRLoo0hKj52kltMX9IrGgEaVAkWMxuW+UbtHqvNNgdRvmyTr8G+ljEZ0sop0oqWlkyZFj0A+TVC7IJC78WfUV3QLx91oOKqEzCgATubA9Ue5aSG4O+KkJtjTYB2ds26rOOfS4ZIAqh5r+QMmZiLAQrEMUF/WD05PIthXAFiI3MfvGmHWfHA6NxspRjIzrhRTtN+yWgJJlyaJqKVUVuBe5Og+97h3++qIzyjLnnEMeA+Za1BvHMt5bH+50xsmLkav0UP4vH6u55uZmIu9TNRRRdx9PWulKkUNKTXoxRJMJOaE5REzgazpcWcp0lf5K97VuRwWdv7XVFF2DPkby+JG64ncR1WTj0IoA9dhCZmwDkRbpHV4Kwh3Wf3wDMHsVU2/MOHt1qJdes/6FA6opD6T2gxlPvi7PmTaVJqGQtczmqrN7EAJSDr/QcFx6ijWFTiBwWaGPUzQplfW4M9mwdsWVT1Cr2zEm3n4+p4VCgjR8kUXJIfaLFxVDTWIxHeU2bg6i3hbeUkEz1i1HCubPjtRqcy75+j562ns5Wz4mfa/XtLLe46cq1yCcGkWBWbmzEt0g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(366004)(396003)(136003)(376002)(451199021)(2616005)(2906002)(83380400001)(6916009)(4326008)(316002)(6512007)(6486002)(66476007)(66556008)(66946007)(41300700001)(36756003)(478600001)(86362001)(54906003)(6666004)(7416002)(7406005)(44832011)(38100700002)(186003)(6506007)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xr+4hcT7qxOhgbnNIH0azMmxXB2W/isDy6HaKKBseG3mWUWWySwjmm9qSojA?=
 =?us-ascii?Q?bQZhfJ8mkUbJhCRT0R30mbfI+TkEFt8Ja+MZJt2cRa2TjWuTuWp8Mfx7ka5C?=
 =?us-ascii?Q?Dtfr41N+eZSwOMPLe3U7k5T2VGnhy24r+qgcu4tFaYwqz+eg2erJ9lwZHTDB?=
 =?us-ascii?Q?sPwlMUziziXOGHV00jXlN+xu5hp/53LsE5VrdXd3wz6MzU/ntV8gowoQ3YG1?=
 =?us-ascii?Q?37qRJGQiIF7jJmbtqukXQ+6DCUWEY/9cFOEx6dQRnG9Zh6sbzdlYKySKOxdD?=
 =?us-ascii?Q?mE+1p4WoAE8f62TVV+zj9LbgNHbthZs5ucVLtKAHKe5gn5ZOm6BbWJJHuVXp?=
 =?us-ascii?Q?Xc+llWMkHmlp4IB2eYy6h26VqMKmeiDsxIsAvDGaYGjNukwY+WZLGLSvKNRa?=
 =?us-ascii?Q?hE4TQO31BoVCu1DBV64/krP/AL9A5gQRFDZeNwF9NCNwaLsDBn+P5ZZp/t79?=
 =?us-ascii?Q?0VJw3Z7DfbmF4OL78I31p5k+dXrV9RHOn8wVy7UYIYGpQPIPl7gsFlqApsk0?=
 =?us-ascii?Q?4RHpmM6NEl0mRzuwQxevGuyxNzMdA41qF5oGSBTWl3HdE0p9lEgDXlQhxWOx?=
 =?us-ascii?Q?oGigb5K4NbD9JCsCvFQWsC4aRYaTwmzNQnzITDog8sP4napwFjEkk+3kEucq?=
 =?us-ascii?Q?N9gAEpujSsvlfUIzNDInoPfgcvB0ewubZIGEfhpw9sweTzwmRnmqpd7XK6YT?=
 =?us-ascii?Q?jw7MG/UBmLrk/ROUzptbk4ObSjh+M7uC0pNC7n9Hv+Abh/D4f/zUmfV1PJoH?=
 =?us-ascii?Q?ScSLMcv2xxxQsSBokU8SLlf02C70fcRrhOsw3e9rj0/msxc3V3Gc3ZvyIBsI?=
 =?us-ascii?Q?PwGhXwOpAXVkNXWcLK9DNasV/auxhcquTQDa/Ca1Kq+//Ypvth9hfFaoOlYm?=
 =?us-ascii?Q?xb0BDXDGBp5gS1NLFtFQZqMlssN/4IUJUR6S7RFL2CX/ZrptUX9qPOh7I6je?=
 =?us-ascii?Q?R3at2uIII8KWqyYMiC98iwdUM6YGhDNEhu3MwF3+mpJFvfzFJ2KpmlCrmX4O?=
 =?us-ascii?Q?U7+qJwa72RqzfwjcZ1onmRTeJapRSYcYn4j1zMKgWFd1CVobPlp2UwrMXrLG?=
 =?us-ascii?Q?13N7+oFwm8E74wBcBEqmdywtyYF2rIx+NiL/0+2/PR79ckHttXYEGYYQ5H00?=
 =?us-ascii?Q?oWmEjk36shXmd0Z1LTjyDq5rPDppLdSYfOLBk4Z7MvxDdTXkIbQl6TUMRHPN?=
 =?us-ascii?Q?Qf31Iuvge/8EJWoW1/83Lwmhm7JrkGtHxWKyLqqEpGqC2b/PB/xyDBbZMcop?=
 =?us-ascii?Q?PpX1POowMBqkK30zZGn3wYWNJhaQ4omwVkZGwmaAiz2ISK2V3hq1mFgh9Nj3?=
 =?us-ascii?Q?i/0tPQNMz3h918t5UL7wme5BzN8EkwuuipRqRCErc9RzdaESlZMzbEmaEF+a?=
 =?us-ascii?Q?RNLSG1k4V8TedwdrW1M1cMGTwGWiWI27Whsx+U1wcJylfihtdS/Goz+k/EXx?=
 =?us-ascii?Q?G+aSnUCZE9ZOlkXaijRZDa19R94mNoCWIdd8wENRaDImLWAxLvYMm6cNljhm?=
 =?us-ascii?Q?Zwi1Dsd9I1FrSWPU+NkhVLDuc8saZs82RMDsilLPdDmUypCkd3xm42vvcc9R?=
 =?us-ascii?Q?iOJ1/zlDBU6BRJ2OL+QNpqZf8wiTYelcsciDf+2SX1CQlCcmSZOG1wxUlZfo?=
 =?us-ascii?Q?clj3Xw/BWjXkGrLT0ikvfYOcIfb6uPNy7K82WKJDePSrhfjG3X50AU09G6p6?=
 =?us-ascii?Q?x9HWFQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703a2687-4c5b-4ae3-a049-08db8c58a29b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:14:11.8034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUULMGDwLbjrB9E/FEYipY9gZtI9SegOsVLUp8VRN2GgvXETs4ppg1tnzX7rXde9yppUsKN7wZROZElcX/VaHW753nKX7B+P63pfSv8UMWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6327
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 08:13:37PM +0800, Yunsheng Lin wrote:

Hi Yunsheng,

...

> diff --git a/include/net/page_pool_types.h b/include/net/page_pool_types.h

...

> +struct page_pool {
> +	struct page_pool_params p;
> +
> +	struct delayed_work release_dw;
> +	void (*disconnect)(void *);
> +	unsigned long defer_start;
> +	unsigned long defer_warn;
> +
> +	u32 pages_state_hold_cnt;
> +	unsigned int frag_offset;
> +	struct page *frag_page;
> +	long frag_users;
> +
> +#ifdef CONFIG_PAGE_POOL_STATS
> +	/* these stats are incremented while in softirq context */
> +	struct page_pool_alloc_stats alloc_stats;
> +#endif
> +	u32 xdp_mem_id;
> +
> +	/*
> +	 * Data structure for allocation side
> +	 *
> +	 * Drivers allocation side usually already perform some kind
> +	 * of resource protection.  Piggyback on this protection, and
> +	 * require driver to protect allocation side.
> +	 *
> +	 * For NIC drivers this means, allocate a page_pool per
> +	 * RX-queue. As the RX-queue is already protected by
> +	 * Softirq/BH scheduling and napi_schedule. NAPI schedule
> +	 * guarantee that a single napi_struct will only be scheduled
> +	 * on a single CPU (see napi_schedule).
> +	 */
> +	struct pp_alloc_cache alloc ____cacheline_aligned_in_smp;
> +
> +	/* Data structure for storing recycled pages.
> +	 *
> +	 * Returning/freeing pages is more complicated synchronization
> +	 * wise, because free's can happen on remote CPUs, with no
> +	 * association with allocation resource.
> +	 *
> +	 * Use ptr_ring, as it separates consumer and producer
> +	 * effeciently, it a way that doesn't bounce cache-lines.

I know this is moved from elsewhere, but: effeciently -> efficiently

> +	 *
> +	 * TODO: Implement bulk return pages into this structure.
> +	 */
> +	struct ptr_ring ring;
> +
> +#ifdef CONFIG_PAGE_POOL_STATS
> +	/* recycle stats are per-cpu to avoid locking */
> +	struct page_pool_recycle_stats __percpu *recycle_stats;
> +#endif
> +	atomic_t pages_state_release_cnt;
> +
> +	/* A page_pool is strictly tied to a single RX-queue being
> +	 * protected by NAPI, due to above pp_alloc_cache. This
> +	 * refcnt serves purpose is to simplify drivers error handling.
> +	 */
> +	refcount_t user_cnt;
> +
> +	u64 destroy_cnt;
> +};

...

