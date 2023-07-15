Return-Path: <bpf+bounces-5062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2FB7547E3
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 11:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA87D281F87
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08BB1859;
	Sat, 15 Jul 2023 09:23:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB387FA;
	Sat, 15 Jul 2023 09:23:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2099.outbound.protection.outlook.com [40.107.244.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FC230E2;
	Sat, 15 Jul 2023 02:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF9cBB/zY9f2iD1iJWUB2A78B85wXI3b2bvBjYaXTNB7DKPo0dXPgUeAA1TYcOlJylQfvLxAKLoP63duTCcdM4DUjekq3xRkeC7o9aLem0/7/iPOt8R9o2/KTZ+0Au/MimDM06Y8CE2pJh71tSD6V+fkhseNZY4pgv9JF6XMsVvPVLyetL5X3z/OLn/VEQYwXZv/8zGY1UIamKk81XvK4Vkz32J1QwrP0hkf7AP0xVRRXPwbaWlEAblYehLmJ227JPTSxBcNG1N1cqc+AMBML2EJgAQj1ivLXWsqu3OcuGpTmZdpdEG9quZ54cv96QJcF7BL8OXjzqpPn/uU27mdTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tML3w4lQHK99aBqFhpR9hjq3M2/d25Qp44gde55MH+g=;
 b=O0CmLfTx6Nz5+EtmN6Jj7ptY/xHbzaWvNg2S95CjuOcV1GJEopF6ygI9OySxm90tjjPiI6gr/UTus3uXofdGpuzxFx8qLl1phTqHLt/+NRiE4ZLDZgSTgkBhCwrsd8NwrTde9KzxA3hgv24gFDdySZ49u6xiu8AE/nv2fHmXXLqulzJsqFmK86lqE3y1jS7cC8tt75ry25GjYf24M6fQtIkC2aKOWJSXMCS9vQkeMZbYjikJ/eF0uLSrBSASVTA+CkYU6WjjtbBwi2XvkEX6b6bZlU/pwUm0iSW4TBtp/1E9HpSsxtkrEi2MDo0RUCrFLJxDhmeGHzUu+x81/Gtwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tML3w4lQHK99aBqFhpR9hjq3M2/d25Qp44gde55MH+g=;
 b=Gq9JT/MA/hjjXu1RsZtMuOfVtro8Yr0LqlhpaJHZUb/TpYmsm8yCA7ilVYB/IIbb5AViO7lyWILD+axT3/YA9o1CoAXtacUMNHeIKFZ7oobBBPlM1JS2LpH3h7BAhV/Q/kYraSuYLg57Csz3WGZpEM+R3mgQzkl6yak3xa3nQH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB5154.namprd13.prod.outlook.com (2603:10b6:610:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 09:23:33 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 09:23:32 +0000
Date: Sat, 15 Jul 2023 10:23:25 +0100
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
	John Fastabend <john.fastabend@gmail.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: [PATCH iwl-next v3 3/4] igb: add AF_XDP zero-copy Rx support
Message-ID: <ZLJljUETnhH92kIV@corigine.com>
References: <20230713104717.29475-1-sriram.yagnaraman@est.tech>
 <20230713104717.29475-4-sriram.yagnaraman@est.tech>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713104717.29475-4-sriram.yagnaraman@est.tech>
X-ClientProxiedBy: LO4P123CA0294.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfa5621-ea21-4768-2c0d-08db85152879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K+si+sIePr02Xlb9jmtlOtf5gSnIbHvtarQmyZCfyvWS7LXsScP3vdBN/FKbpi9H2ccT0MXB//7msaZsfsT8iivMx57Xfkq9JQI/jgPQry+qA5B4K4klwTw+pvOAmm7BWqdIKA7QbRaUTgXEs0L+7v10jxf6g0Q/mw5Q9K6J9dAXUBenC8+iYs02uYB18tM7WTiPkbids17HcR5Axv3TQdNPbLhNJPpTZB7JrQzsGQloDYMY7Hcjw8ysUTT2ZMzFs1TjO18Jv3jjRRyz5xj9CSuFJbTYjFX6J2aak2QUT7kHEZVAQQk1oeexeRUeF20ay9rxCpk4YDmTzidNQheQ2jpf+/t6AwDRVcocv90r4X7W7KqK0d4MVVOUtvI9sY/5BLN1USS7Y+Zde/1q4I8OeOvxmaYX6z2X0jiYnah1PT95lap329SWDk4bxw6a/wv+4P+13QrgxQrWFwuCVTKoev483W0+2W69B5HTcqYmz3K0nQPm0/F733u/4qsgL7nTYGdITC/bh8MiLDJtyv3FfMWOWd8tqmaxoRs+JwsQPdIMEMm4QkbMIze0fW98F5tA1K4z3mvx2WDEANjYVEKDjWB4HbMeLfZUOe42J/mV9iQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39830400003)(366004)(451199021)(8676002)(5660300002)(8936002)(316002)(41300700001)(6916009)(4326008)(54906003)(44832011)(66946007)(2906002)(478600001)(6666004)(6486002)(6512007)(26005)(6506007)(186003)(7416002)(66556008)(66476007)(2616005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?42Dpm4jAPNHMaSe1eShn/hdUzcZ12QuthktoiZHdyMD2dLjUAEd65GmZN6hM?=
 =?us-ascii?Q?MvBr0dxXZ9Iq2MEO/iTjhrrQh+PK7ZS1LjcJh4ais4EZvHCHPUoje8Q03DjK?=
 =?us-ascii?Q?pPVlumrgxS8vOgkqfpt4mvrhEkiKl3NppF2s8cuX4x/9UyRbQ7C7NU8vkjwW?=
 =?us-ascii?Q?CXg7B+aQhHFm2NPbGnguPvRyzKFksp105+xocbnQ2Lg/ygY505XZuUD+aiIg?=
 =?us-ascii?Q?PkkT5ai2ubviN4i3yE+ihwOUtkI9pQsWKZpZwK9pYEurhJbpUnAW5eqeIKQD?=
 =?us-ascii?Q?wB87wyiS1LP3o6TqyK79cZG3FwbjcXbnxsInevsz69mtWpPI1zmNu1//5MSo?=
 =?us-ascii?Q?jH1Y+lfDTNbTG/NNwvk0i6tCARyXFeNtccCBe9iLfgKxPEpBYzK8/4MvaU6W?=
 =?us-ascii?Q?Axb+eGZgnQ98jebP425EJRyNcSp4qInl6YSLbwJUujM5pUtsw8+mckOeMQjw?=
 =?us-ascii?Q?9jG/ZNhpss1STWXn4qPzKfVWhrPENZjlNL7CGB6RBTzwikXbKkJjpVXx2naO?=
 =?us-ascii?Q?Ub54qr0vZMDX7QvPBRkixyxvYVgQGUj3N/dvDAyLEJMcik9okNjY2vDLHJaC?=
 =?us-ascii?Q?YSF/QiPvU6XWICFI2aCY2nENhyQF4EfiXSuDQL4mAzFm/WG7d2aJhD5IM4YL?=
 =?us-ascii?Q?FvxmczccrI69YPXhbaAgdWa2uuPw1A8jDKpcG8U442Q9+grZPg8T7TgGlDjd?=
 =?us-ascii?Q?8lFQlBRHBgElH7ooYipFyem7CFS+6+zYqefRmr1al+xsdE0sL16QkbI+jCYD?=
 =?us-ascii?Q?7GXu3GfupirF402fr3sKfdEbEcDWfYuA6BmFDYQvibTFsAr2dOTseVncVuhC?=
 =?us-ascii?Q?N6ZsKyJF5j54hsQ8BGl/oJdEXES9bWr1z+x4m4Meucdfeh5L3apqdxRGRE6J?=
 =?us-ascii?Q?XJ6thJX8tatgpfNWHvcIKsBdKZ2D59Q6S7dZ+BxwWZmFIbRg3/X4+x7460Bz?=
 =?us-ascii?Q?hzsXXWNPWHHh92RG487UbpF3pIttP5f2AD6qxcJ7VpKtPdLh+TV57R/GyDLP?=
 =?us-ascii?Q?M9BwRvf2FUbK2FAytKWIwULN5jFGuWIjj+uBWOQuEiRs7a/lLWkOBASucHRS?=
 =?us-ascii?Q?Vv4oa0fm9HwFUeUWvyqUsIWKcgAWyu3zyBdoYpjjoYFr0pY9LxfYR6eQQyCi?=
 =?us-ascii?Q?XbqL03PbYbm/Ai8QjnbDk+q2ZFrb5GcVyO3snE1mJsbYDeulb1aPo8V6FmOy?=
 =?us-ascii?Q?XI8jOV866i2jJ/0lL5KZRbfd32YTSg+7i5PqldNpIqKj7HivEAQX1to2ZZbw?=
 =?us-ascii?Q?05yIaIfAsJoJ6+XLcm2Rr6u/RZliGzgaubm1TnPbCIJSQkW4kGQvJaLAmoD+?=
 =?us-ascii?Q?uBiaxm1xrZz9TljX1KRVy0QuVEpCH9FwvqyzD9f5XxDpW4GjuTQjTYK0kEld?=
 =?us-ascii?Q?wOCUqdLYGQWaTB5YedBoWEehti+HX1q1XDjwUQ7PH3d1nL8t/WtnEXrbAMi3?=
 =?us-ascii?Q?IWjDUdyTy/ChOWjQ0m40JAjjkWhmBa09f9J2FN2YOAfopVE0wra46jIrkbUH?=
 =?us-ascii?Q?whYflvAMIj/7Lkzl4yQdYUONMjDo+Uab9BDws118nlLVBXGjlwionvnhlRXd?=
 =?us-ascii?Q?O9/7oDDC4/BnO4wCDkBQBrBhxW5irLgxYkNuyFydZGs0GRi5uPXKE0kKwPcc?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfa5621-ea21-4768-2c0d-08db85152879
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 09:23:32.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8epTenpRGs6mbs9Za8HlcG6DU/MliiWf/6TGdl4W4fnKtY0l7oUcnkwykD/X5aWPO6bukosYV5ug4HKrpuzPEQ+PDKyvlHp8IARf5pKjC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5154
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 12:47:16PM +0200, Sriram Yagnaraman wrote:
> Add support for AF_XDP zero-copy receive path.
> 
> When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
> xsk buff pool using igb_alloc_rx_buffers_zc.
> 
> Use xsk_pool_get_rx_frame_size to set SRRCTL rx buf size when zero-copy
> is enabled.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

...

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 2c1e1d70bcf9..8eed3d0ab4fc 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -502,12 +502,14 @@ static void igb_dump(struct igb_adapter *adapter)
>  
>  		for (i = 0; i < rx_ring->count; i++) {
>  			const char *next_desc;
> -			struct igb_rx_buffer *buffer_info;
> -			buffer_info = &rx_ring->rx_buffer_info[i];
> +			struct igb_rx_buffer *buffer_info = NULL;
>  			rx_desc = IGB_RX_DESC(rx_ring, i);
>  			u0 = (struct my_u0 *)rx_desc;
>  			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
>  
> +			if (!rx_ring->xsk_pool)
> +				buffer_info = &rx_ring->rx_buffer_info[i];
> +
>  			if (i == rx_ring->next_to_use)
>  				next_desc = " NTU";
>  			else if (i == rx_ring->next_to_clean)
> @@ -530,7 +532,7 @@ static void igb_dump(struct igb_adapter *adapter)
>  					(u64)buffer_info->dma,

Hi Sriram,

Here buffer_info is dereferenced...

>  					next_desc);
>  
> -				if (netif_msg_pktdata(adapter) &&
> +				if (netif_msg_pktdata(adapter) && buffer_info &&

And here buffer_info is checked against NULL.

This combination doesn't seem quite right.

>  				    buffer_info->dma && buffer_info->page) {
>  					print_hex_dump(KERN_INFO, "",
>  					  DUMP_PREFIX_ADDRESS,

