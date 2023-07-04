Return-Path: <bpf+bounces-3997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E7C7478B4
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 21:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA94A1C2082F
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 19:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6813F79D3;
	Tue,  4 Jul 2023 19:31:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144176FBA;
	Tue,  4 Jul 2023 19:31:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2114.outbound.protection.outlook.com [40.107.243.114])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9BE5B;
	Tue,  4 Jul 2023 12:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNuH2xLCPK8QFwcDiCfUurdWJ5X6Jk7+GcWMRBYgkjOR4DEhdP4gvEAO/0riKVMgbzR/7fGFxQccp+Sbu5H4KM0iJnn+JRNyJVWMBJJXyDBi/VbRqEzAA5YLZntClYgtYpsUbpExqRZfyelGcueb79LFs4giMsNvGzdIl8x2ZCrx+5yivpqkCAz58RRUIIqqzg+fBLTZs0B3fSX7A+UP/1nV0ft/FTSTrIS762nmlebByqTSbQaeP/9VUCiuOln872z18PdYgTqoe9aMn0990XlITL1cq+CmFeSWuu55mwGyg0QNduC/lPYEaZyy9nbGFF4KbBgqRzBWuFnQdfsYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHBoWE782Mjab2pPxL77/6NfgaAeSBZTLODvQxs+RfI=;
 b=CfPCdfMUudywDDwVj+aXk5+zMZuQGmnId7otD4hcHfvv4nL4D3slsbUq52Sv2gA9YUdxU3tWL3y2A7BFeYJI2hjfd8yaxXkSsgSFE2DOaRzHmxfp72g9XihSoCGyl+bvA9xdOMXcwc8B4Ps2+A+dApjeLTdpP30ClWaNq9BOmcnup4wQTGqkAvOUj2Nc+HRTTv7RsOlVHaUbzCq1fLeEZJqaUi3X6WxlDPKKjy+L+3t6luhWujy5iIw5uVsYBoqbO9pL1/dDm6KXLqJoV0ErR4moXLpSnVMoZ3kaJv+N8mQGDFOs0ctsb+n00mxxzHDq0N8CLEKeIAvRyln2yx9+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHBoWE782Mjab2pPxL77/6NfgaAeSBZTLODvQxs+RfI=;
 b=tOaP3ARD831FSjFHmrVOXgFLtSLpDoPR6ZDFQsh21HUB6fu2G4EN0GBwxolLBcuYfZxKcpONxCwliDqlPkcvi65e9VnmKFSXwx4ubkyqssg3720/GTuFFDBLaFErGzIPt9ns450zxp6tBkeiXKaz6Ob+7gHbwUJRC5lpgJJfS0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW5PR13MB5416.namprd13.prod.outlook.com (2603:10b6:303:191::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 19:31:08 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 19:31:07 +0000
Date: Tue, 4 Jul 2023 20:30:59 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH 3/4] igb: add AF_XDP zero-copy Rx support
Message-ID: <ZKRzc5aPjVmLQP9k@corigine.com>
References: <20230704095915.9750-1-sriram.yagnaraman@est.tech>
 <20230704095915.9750-4-sriram.yagnaraman@est.tech>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704095915.9750-4-sriram.yagnaraman@est.tech>
X-ClientProxiedBy: LO4P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::14) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW5PR13MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8a151e-d86b-4919-df49-08db7cc536df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AzkIGEzT7whjKX3t/qt/1G6svZH7RYUMjL4lFBP/sNMLZXpqokROYganoT8mQMWR3fEJy0UnN3wSVBXj7yj3/BFbEbmhepMLatT5f2MeQEbz/x5LqKKPgM0VZDQSZCVAb9DE9R+sEJfN3dHsEb8PH0j8NulZ/LiYa4Z8J6UGUuSMhbXb/0qVZwvht1V8UxsyzL4ukaB6/+YmJUetfG+zYnSPRUzqHkgzUUj2e2AvsKI22fTSWyEVqiL5UsZXNGrVUkiWz3wTG5FireuCqqZwMT/dALgJt5LDw7jNTSyrpR+hRMullAb2lr/HDtQwCVrCT5cCWz86L5iYBhZYhFmZKv5Dl4pgm8FrP2RD0wrIrpTb1KXPQfDiuGYHWi7534N92oLWiJp0K0trtrgJRNr2zs865rr8nksFg9v1JFyMO+ru0CihcMsZrinL7O8Q9N12xJsAwk/YJgNbOKUZsHQNQedBUUNjRs60D3sV8RTuU/RYkXO2YSiNvU1RYausyWpNZGKD3u4zWIRwYY8Gj0KRXpL/2KzcW1d5u7L+EvZQ+aNWLoX3WJwTj8//j1wtSSIqQ48WypeUiOr6mUT3FlwU26jDg7gl04fJbCJyB4FloJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39840400004)(136003)(376002)(396003)(451199021)(4326008)(316002)(66946007)(66556008)(86362001)(186003)(6916009)(6512007)(66476007)(26005)(6506007)(83380400001)(966005)(2616005)(2906002)(6486002)(38100700002)(6666004)(7416002)(5660300002)(44832011)(478600001)(8676002)(54906003)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VL9Eu2CJmAzYaijFa5NiOwvd1OxjHc/TmxrnVBxbsuHWC1KC7Lzu9MstPJiv?=
 =?us-ascii?Q?GbwC2N1DynVatcq+tKH0kBziVn5AugXu9tc7lmkmFI7/XmpyPsWzbgqmixaZ?=
 =?us-ascii?Q?6+AIC/Iek0QJQY/in3lNT4ryOPdqoXJFBj2yeS9sNIkn5xOtfjfgat+mtXI7?=
 =?us-ascii?Q?pbCbsdhW6iiz191MKlfXZbXnC76bLcQ2rC1UaPywSMuZweGdEoqX4yHWSWpf?=
 =?us-ascii?Q?MN85tDNFsrdkY8No4JdoLztt/h1qyhhC1ituymUnczPGNOR+5RdoYLloJgv7?=
 =?us-ascii?Q?RoUqW9kmO6JRT9uwFpJy6oWNqpjpTgIAtE2/YypDKtfYM9wBw75xM1wMQKKA?=
 =?us-ascii?Q?9ew7JcG7dN9uMs5jCUaGcD556lVkn80FlMKXvwXrHpXc0b9Naagj9XT6YWsc?=
 =?us-ascii?Q?WnVjyyhhir7OXW7i18oUc3z935sibW60+wcsPPCRGbJijM1szTvAyj2CzzVQ?=
 =?us-ascii?Q?UlMa5VORpvM8x0rvO+RhsdPDMxHWjvC+ENmRHYErQ2FtVRS2i6VVTXVhyzhy?=
 =?us-ascii?Q?iPRLvgEZfPlaxsBu9NfW5Fw93sDhWqf7F7xvKAMDg3pE13894nPHos8rs68/?=
 =?us-ascii?Q?Iagf0DgwWCex63AjmR8yRnF4BqFVJS90i81cJ4KypRVaGpUkh0v/eD8Bijrr?=
 =?us-ascii?Q?jfXho/5ZsjPIz4uDCYNbQJfPYV7oCLnc4FCtY8rRobLW2biEwmvmVqwvBFAq?=
 =?us-ascii?Q?oExnCKej5qAB4NreIhQl00mzn3qqMc0NEqfWhFqPs/A6/7L8COzzdzEninCG?=
 =?us-ascii?Q?HLq66AZsVZdbRyihZjLNu/aFSyEnvvOMM1pHh+UsjtReOXwnDDCq6+Ce3In+?=
 =?us-ascii?Q?3n1BCF4yQYgNJNue1cchfxs5x/WrdFplrKusYp1C35CydBEf3DqYTLuVDopj?=
 =?us-ascii?Q?Y8ZrSDn1FhRt88Ob8zO9AA0C2u+JZbLihKLTtnVt2cUe26zbo5IlWdz70KFs?=
 =?us-ascii?Q?Iz7f+fzxAguE/VdSZh7ZVYsphmf+LuV9TR/j/f7o8aFTtvbacnRfoW+b/0AL?=
 =?us-ascii?Q?EG/KStwu1BWAD8Xdptszw5v9YaEwuEtn7bZoODlPUXx/qrplsg//5rTX2E/8?=
 =?us-ascii?Q?cDhR9xumnx8yLJlG3TsJ56lEnr0ed7rOF3zYxQW7n/RRfwgENBLqsgIDO7O6?=
 =?us-ascii?Q?7Ko8WmurmFFBjrOXimmWw4KndmK8lPZZk/F/AnjdRGqyRO0EhOLYUXXzjY1E?=
 =?us-ascii?Q?/w1jAlzT24rPuQTzwBiitcUMlX/HmRL/bhHHWBoVkVZFqDlxQqQ9nlUfEHmg?=
 =?us-ascii?Q?LnUMnWnfn1YjzEp5orPysssZO+mMavW9q94NkRXSi/PPF3m4ODVTSZo7Q2ro?=
 =?us-ascii?Q?4yf6H204K6fQ0eGdojiQyZ0o/wTdElgytLit4lvyGZdSAqTWhwIpltVdYqc0?=
 =?us-ascii?Q?4LxTOBLslXdZEdEMQrkeA7fIxSmpKyfRnmuEDfr68aTh1dqmvSE3GQAUlOH8?=
 =?us-ascii?Q?hUv6VCyMVXdo4MQI0G9ADagCYcGP4bPThQuXuI8c9quO4imKpPdBin8V+OG+?=
 =?us-ascii?Q?U+RgiZ7oxww3z2DDiOFCrF2Ue2cHJztW79p/etqv88CRUOh2wXQWsUNsUYfH?=
 =?us-ascii?Q?BqdpVFlSPQLEoh2LokbzyrEucuoGQeGaE52UfNepKDfarcAF0FPBnM6NdfIq?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8a151e-d86b-4919-df49-08db7cc536df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 19:31:07.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pB9uPwgNnKW3czEn9tKPqTjC7dvOczL8xNiTG1L0X1UgUscmM2FMqrJ8SK9uIilmtLXeynUiUMvBwpPpPg97+B3+YVi/WeStGySYzTyFk08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5416
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 11:59:14AM +0200, Sriram Yagnaraman wrote:
> Add support for AF_XDP zero-copy receive path.
> 
> Add IGB_RING_FLAG_AF_XDP_ZC ring flag to indicate that a ring has AF_XDP
> zero-copy support. This flag is used in igb_configure_rx_ring to
> register XSK_BUFF_POOL (if zero-copy is enabled) memory model or the
> default PAGE_SHARED model otherwise.
> 
> When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
> xsk buff pool using igb_alloc_rx_buffers_zc.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

...

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 391c0eb136d9..f4dbb75d6eac 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2013,7 +2013,9 @@ static void igb_configure(struct igb_adapter *adapter)
>  	 */
>  	for (i = 0; i < adapter->num_rx_queues; i++) {
>  		struct igb_ring *ring = adapter->rx_ring[i];
> -		igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
> +		ring->xsk_pool ?
> +			igb_alloc_rx_buffers_zc(ring, igb_desc_unused(ring)) :
> +			igb_alloc_rx_buffers(ring, igb_desc_unused(ring));

This construction seems a little unusual (to me) as the result of
the ternary operator is not assigned. I wonder if it it would
be sensible to follow a simple if/else pattern here.o

Flagged by Sparse as:

 .../igb_main.c:2016:32: error: incompatible types in conditional expression (different base types):
 .../igb_main.c:2016:32:    bool
 .../igb_main.c:2016:32:    void

...

> @@ -4892,7 +4917,9 @@ void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
>  	 * at least 1 descriptor unused to make sure
>  	 * next_to_use != next_to_clean
>  	 */
> -	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
> +	rx_ring->xsk_pool ?
> +		igb_alloc_rx_buffers_zc(rx_ring, igb_desc_unused(rx_ring)) :
> +		igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));

Ditto.

...

> +static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
> +{
> +	struct igb_ring *rx_ring;
> +	struct xsk_buff_pool *pool;
> +	bool if_running;

Please use reverse xmas tree - longest line to shortest - for
new Networking code. Likewise elsewhere in this patch.
You can use the tool at the link below to help.

https://github.com/ecree-solarflare/xmastree

...

