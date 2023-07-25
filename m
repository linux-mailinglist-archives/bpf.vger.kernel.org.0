Return-Path: <bpf+bounces-5861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212676223F
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 21:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6212813F6
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C792263DD;
	Tue, 25 Jul 2023 19:29:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C074A1D2FD;
	Tue, 25 Jul 2023 19:29:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2127.outbound.protection.outlook.com [40.107.94.127])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7092102;
	Tue, 25 Jul 2023 12:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7oUtmOHoowqFTlLIeo70t4aDqba3c19mH0e5Wz2A8lX9rt1mlL7f4aZ9vL35DYkeZsu98DCjesaJMWQp164CKYWqCieg/NBSH1nbpoy9bYV/ArGTHEOW39PkHNowFgsniKuOIs9BNZdMJGBAiVYgDg6F4yIDq4wuD4T+jcRxg3KYGBr/a9DtZGzf/4lpyxlstNm4fxJmdykcjGR+K9zXmWDHMRJ0BYdZeXP9tJ2WCNZ7pdlZBoSt6m7LyhfQYDn/Gmn/RsF92kKavExY2h2CUjNStKzKGfNcK+Ye73JIDEhycphSnVw4/4ckhHdKSreMpjpnHJVqjkJh+jlIOtuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0+PvhASDGVSSlm/IfhCpZnqP9ZeLFSZjKnT56l6gbs=;
 b=f59ZO+VlZNlbzaiKm+V0ja6EZfQuCBj3w+G9teMWWZtWDX0zvRYPG7d2MPxgHXFCE3MbkAMo+ZKuO45FKFc/DBzjVrkJBAJP7aFBdPl6Ud3VEItKnQZ2byIQHe/hLkmYh3hQjrQgGo+FI+whPmONF5313vz612GX6kiCjXEQr0ydskeub39zy117vUx+UyeioE5ib8yz3KVtFmbURuLG4DVPGg5jKrxV2hJu+Oo082u45XeLuCDozHfCiE+lAH3a6dDl/dKmZTI//d18ExJrHQsVBDcRi6WpZx7MRKNGuewbaqNiR4sTYNTJCNFbJBFTGYuvhhd6wUVQ19VUOY1C6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0+PvhASDGVSSlm/IfhCpZnqP9ZeLFSZjKnT56l6gbs=;
 b=QIUfbXmcnxj9Nf5X8pGU/nsnx9olCINccicdOUTvWRmV0/J7ZkKYEU6EhjNbLbvHVfMsuP1ttD8S8bDTJqv4BcWxzBdU83Ul2WLgZvR4XfOv3e3TF5gZRTZoVRhjLSAnCRUWEg0jgpDZzxrW9jCZpVtfRA9cvldXPr68kZqhDSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB5014.namprd13.prod.outlook.com (2603:10b6:303:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 19:28:43 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 19:28:43 +0000
Date: Tue, 25 Jul 2023 21:28:34 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org,
	toke@kernel.org, willemb@google.com, dsahern@kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, hawk@kernel.org,
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [RFC net-next v4 2/8] xsk: add TX timestamp and TX checksum
 offload support
Message-ID: <ZMAiYibjYzVTBjEF@corigine.com>
References: <20230724235957.1953861-1-sdf@google.com>
 <20230724235957.1953861-3-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724235957.1953861-3-sdf@google.com>
X-ClientProxiedBy: AM8P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: fbadb3a0-d2a3-445f-ecc2-08db8d455b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BLV5JPyWbEsjFbzzsmNij9lvl/L/OOg/imLrj+oBsoPkiJjXkLBRc79LpyvxpyXIz5JoYvrY1JZw8f3JmvyU6N9RxqDM5Ch6uqTYz9sIFQ3BHVQDVrHc9VjCd9gYviQVstHHFwE61VcbSFTNJmLfxpW41RNUcOtATGDGM+G3ur6lQcdIGS5mFJpCvg0Y0Q2enxTAPafEEENX5pGO8XCWoadQRMU/Z9jFozkiJm2ruSf2xqIx1Sabbh9y5cOyzMC1K4ATSzQvInzZeWsRDwh7wmYL02QtoT4FkM+ZJRkfN8DmPFYsv8N2Fd8+Ed12h42AAoNOHFOoeyLtEqT+g7v1Z5HsFR5VHFIW7PJ3dNh4Va/o/9JCuRbjx781Z49s709vNiF4fxA15F6KXIk4VY2llGVNslE2DCYL6UJjqsE8oPnJdYpPb94LPegf10NNaHyxGGuzhTu/lRlZw4fEJ6B+pBW9V/tpfiUEULBbka49DUB5a3SY+9wDzxnH12kqZbN6SyhPn/RYsvmKSjzi/gGosmFWXnJvutjC0m6zwunAA8M2o0qEw7tD1p0tCVNkoHp3pR8YvxOuMibf13FVcrfYCVUlwO4zNbo9SxRw520S1aQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(346002)(396003)(39840400004)(451199021)(6512007)(6666004)(6486002)(478600001)(38100700002)(41300700001)(5660300002)(8676002)(66946007)(66556008)(8936002)(66476007)(4326008)(316002)(6916009)(2616005)(186003)(6506007)(86362001)(44832011)(7416002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jJBVFRCxqxVICLvlWf0l5yBajOI6eB3Q5xxEAZTp47gc0WEfcFNxtxZ5t/DE?=
 =?us-ascii?Q?z4oboFuuiDFTUHlj48G85Pn4phu4cuU8qQEVmfOW+f2CZQNC6NMDdaRTv9Es?=
 =?us-ascii?Q?0P5V2uHjLN6k+ZVGURPo0oAZFivqHYHNyHK+oP9c+GzIVGf+xrSEge9dFeEn?=
 =?us-ascii?Q?Zh2olDciVIBSBX8NstiaX6nnNJafwQ58PXbxUKw0JfZ1vbfSwaAgS7rdfAUy?=
 =?us-ascii?Q?Qj8wEO44BVwuBvBhSKZDgkGNvPGaPvOVI81mBCP/pOOuqIO5IR2fNpvY8ky+?=
 =?us-ascii?Q?B5kG4aUH8Riyf1oCNfHNI8UzQ7EMEU+OR3SKYm2uTFh2NgT/xWz3l7O3BmnQ?=
 =?us-ascii?Q?EtgGqIllnZIl3gLAsouHDR6DO6OGF4VghmZpN3jUmnDL5qHYv0knupjlTF/C?=
 =?us-ascii?Q?8SLV7ZWZ35xTCI7i8FvKPpyZOUARQAoZKKka9VuLRpTspHADggStF2QOTYfW?=
 =?us-ascii?Q?QFcC1anQo8PtYuQ93iLahgIGfUlACrRObfX/1uZRDwKLFchzFgLjFM+CC8Bs?=
 =?us-ascii?Q?TBsTAG56ur06GgGJJoRcabT6UcOY61dYQJwD3yslfApoAmZ0rXT97hCuBxAd?=
 =?us-ascii?Q?BNKildj1h78pb+Gufa6JrggNF/lyS2o6d1wlPxO8PAp4Ahd6LWx7D4KZtr86?=
 =?us-ascii?Q?COm+PsvtXb4kjMtKa+UL2VybPYq1kD7imA/Z8j2ciCJ0se0harmk7kG4astd?=
 =?us-ascii?Q?w5u+gR0AN2zwtJ37DShnIaX3AsGGUvduxJKZHkPvt82U7c5A/sQw7w1nqSDa?=
 =?us-ascii?Q?GcdAlT0bMikByaho2tW6D1cDAxTCWuCX40yFUsQnpkNyigq9fRK2D976RtE/?=
 =?us-ascii?Q?eVT0j3Nb2s7oGJnwYx/0xnClQ4orUIguMoFNHaRltTV5vWfaYxPUGAEBZqz7?=
 =?us-ascii?Q?i72UlSO7QNuyX+xHJCt7/eCD/XOA3HHurBB+Xmk88ZJ4bxKESB1LFyWyYARa?=
 =?us-ascii?Q?6yh86+MYGzQtEGjU0WiMUmi7Do0nydQL22ohi8Y09hCmAsexo1saV3XmnMQg?=
 =?us-ascii?Q?sT2L6PwrMxt37QBWTvapQ1DZ4F02p7FaWfl++p8CKFxrfi9JmgOMok4WpR5L?=
 =?us-ascii?Q?i/71PDzpylC52BW/R0r5M31OKIdfLlktzQTXZf6xtQxYRYUipYYmIpYCbJtu?=
 =?us-ascii?Q?Zzr1AgSHpn6TkRvXXeu0fxnC/lnrcZHu3IAUSQ74oG0qF1XoyFDv6MU2uOpR?=
 =?us-ascii?Q?J0Wvz5smrms7X44s4zbifQShdMfxmYjPpMtsnKmyhIrTiKElRQ9IqrXgkfSH?=
 =?us-ascii?Q?QR3kW2Ds1PtPB0ayCD+I4xNygP/Wh5vj7UCCozbC+tmq1iEhhTCLctixFknr?=
 =?us-ascii?Q?5QvFj02EOEZP9ZgdsYnYvfz1itAhaRzp1c8MzU+OVhmebXeYcIFJ/0YbsxGf?=
 =?us-ascii?Q?r5Nlnkxzs0qz7it42V4Jk3C6C5stoFU/3OlfVqO/ok/2od1/MWdh66ghgpAn?=
 =?us-ascii?Q?B1xIRUyffvfbO7S+tfTiuyjl5hL0goXsRkafv9Li6HQIwiw1SYewHtlxIZhI?=
 =?us-ascii?Q?GWSLrQY/dg1bKAjbqo/2f+yquEr8KEsBsi0E4o2zIH8nTYnOeS7tbZBeOwV/?=
 =?us-ascii?Q?orcgw+X4PkstKQInkJ+DFxjptZpA0fpstRU9YsrYht+s5+fVee+fhHTs2hiJ?=
 =?us-ascii?Q?/KECJzhQXXMe6qjU/hLwrdK0gsz7RtLOZ815vojQIEKGs1uoxz3MdN7ala+h?=
 =?us-ascii?Q?mz86hw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbadb3a0-d2a3-445f-ecc2-08db8d455b6b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:28:43.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rk/hcr6kZf0zQablcjqSKixARM/xVbbBqqVSXUBhyRYT87fRd1lm+Cei6FjXgai+FjDz/blCt3X4qDjjce2ozK+iWURE+en6ZNgQp7/zQ60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5014
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 04:59:51PM -0700, Stanislav Fomichev wrote:

...

Hi Stan,

> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index bf71698a1e82..cf1e11c76339 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -37,11 +37,26 @@ enum netdev_xdp_act {
>  	NETDEV_XDP_ACT_MASK = 127,
>  };
>  
> +/**
> + * enum netdev_xsk_flags
> + * @NETDEV_XSK_FLAGS_TX_TIMESTAMP: HW timestamping egress packets is supported
> + *   by the driver.
> + * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
> + *   driver.
> + */
> +enum netdev_xsk_flags {
> +	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
> +	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
> +

I know that it isn't the practice in this file.
but adding the following makes kernel-doc happier
about NETDEV_XSK_FLAGS_MASK not being documented.

	/* private: */


> +	NETDEV_XSK_FLAGS_MASK = 3,
> +};
> +
>  enum {
>  	NETDEV_A_DEV_IFINDEX = 1,
>  	NETDEV_A_DEV_PAD,
>  	NETDEV_A_DEV_XDP_FEATURES,
>  	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
> +	NETDEV_A_DEV_XSK_FEATURES,
>  
>  	__NETDEV_A_DEV_MAX,
>  	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)

...

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c

...

> @@ -626,6 +635,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  				     struct xdp_desc *desc)
>  {
> +	struct xsk_tx_metadata *meta = NULL;
>  	struct net_device *dev = xs->dev;
>  	struct sk_buff *skb = xs->skb;
>  	int err;
> @@ -678,12 +688,40 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  			skb_add_rx_frag(skb, nr_frags, page, 0, len, 0);
>  		}
> +
> +		if (desc->options & XDP_TX_METADATA) {
> +			if (unlikely(xs->tx_metadata_len == 0)) {
> +				err = -EINVAL;
> +				goto free_err;
> +			}
> +
> +			meta = buffer - xs->tx_metadata_len;
> +
> +			if (meta->flags & XDP_TX_METADATA_CHECKSUM) {
> +				if (unlikely(meta->csum_start + meta->csum_offset +
> +					     sizeof(__sum16) > len)) {
> +					err = -EINVAL;
> +					goto free_err;
> +				}
> +
> +				skb->csum_start = hr + meta->csum_start;

hr seems to only be set - by earlier, existing code in this function -
if skb is NULL. Is it always safe to use it here?

Smatch flags hr as being potentially used uninitialised,
the above is my understanding of why it thinks that is so.

> +				skb->csum_offset = meta->csum_offset;
> +				skb->ip_summed = CHECKSUM_PARTIAL;
> +
> +				if (unlikely(meta->flags & XDP_TX_METADATA_CHECKSUM_SW)) {
> +					err = skb_checksum_help(skb);
> +					if (err)
> +						goto free_err;
> +				}
> +			}
> +		}
>  	}
>  
>  	skb->dev = dev;
>  	skb->priority = xs->sk.sk_priority;
>  	skb->mark = xs->sk.sk_mark;
>  	skb->destructor = xsk_destruct_skb;
> +	skb_shinfo(skb)->xsk_meta = meta;
>  	xsk_set_destructor_arg(skb);
>  
>  	return skb;

...

