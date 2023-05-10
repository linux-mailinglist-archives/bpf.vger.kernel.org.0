Return-Path: <bpf+bounces-285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF7A6FDE34
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 15:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09422814C9
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 13:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145D112B6E;
	Wed, 10 May 2023 13:02:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3A20B42
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 13:02:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2102.outbound.protection.outlook.com [40.107.94.102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D038E4C
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 06:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1qku/uhF5LtQWXLyj5NFHgvbphGHFCjaUAl4+8SZp9ElJXf4UmJq5q+wDd93056MgoYpkDg3TtDhMGtvWwVUvQ3gGuIeZKV9E9MpdR2L6pCO7hragf0C56u6jzgw8qzeJy5xX9AmItLjkbK7NqH+4OMYZvPGDv++LgzEEGF0ydWW6YfF3oUCB6jqAmjcyU4CCIXzhwvIjYNxsCgwFLdsKXxhd8fqfXFv8JEHv2hGVVjR96L/aABQ/XUG9SJLUqTWDw901Fku00zb8anjKWZSTyVLZ1Xa0el+RcfNNs4oKqsGcN605W7IqGflPCfxyxzWJMaKBpp5/GkEw5lusSz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dACha4u343yXiZ2VmUl8j2scrKjzGDm/Fw8lGBBVeiQ=;
 b=EluaqD/4xrCtuFWbVreNlb+X7r0e+8IHhdDMRW+BeW67XCxTPUn8w0kgkViVBC7y0YtnmVuslgIXViwYBkEuQ2nYXn53CDVC++fTk0Ay0e5FpLrPYk9ZoUynzo+A0eZwdtkUjwprnxXI0iY54JfuA/41tsc1cz6T9b2A5SP8D+2lJTfeIMC04O++sxVbBUW4D2rRhnn6N1Dn/pTNXZT8JJuiL53VSe21I0HogVE/cON/ymiU5oAeoq8Q7cf54/1L4ecIHUlDmgUC04x46LWdc6Xwdse3d572nL1ibXoceI6RAtK/PhDTwwBiToAs9c25PpjEQGT8wKJH/JWd37gdJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dACha4u343yXiZ2VmUl8j2scrKjzGDm/Fw8lGBBVeiQ=;
 b=VwCzuCfyL70UIKLMZW9Et1gFDyR7Cl6cV+Cn7FiMdzhx7aFigPh7iGBog+/sxAvaGdVIDd15hHxNrVhVPY7eRupLeXKds+cg8hEbwn1Q6+C9nZ7WvnK/12zv51+HeqHR3MmMGWpMKRFbbQHkRKd82ELkuwY7HnGsNLytCGygFAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BL0PR13MB4452.namprd13.prod.outlook.com (2603:10b6:208:1c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 13:02:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 13:02:23 +0000
Date: Wed, 10 May 2023 15:02:16 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/2] net: introduce and use
 skb_frag_fill_page_desc()
Message-ID: <ZFuV2MEvcggfeRQS@corigine.com>
References: <20230509114146.20962-1-linyunsheng@huawei.com>
 <20230509114146.20962-2-linyunsheng@huawei.com>
 <ZFtYkmvQ01YxHf9s@corigine.com>
 <e78bf687-8b3f-f40f-ac52-8c3ecf7ef40f@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78bf687-8b3f-f40f-ac52-8c3ecf7ef40f@huawei.com>
X-ClientProxiedBy: AM4PR0902CA0013.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::23) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BL0PR13MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d3bc36-4461-45cd-31e8-08db5156cc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VmLxUbyBGoNS18a4Tg8qQD8eGrpl+Lvw8FGfrgee5/MKPJVKkNBNSLP4lw980fiBiKZ6laBUcAjC4iJAiFEtNbaFIhIpBsJ35YI9ldoVLvzDZAYk95j93jzm6x1LalgQPBtbRNkPNHzjE9ieHQThsejdkBZZMK5mmMHzUZk8f+Od1n+GCQmsQkR1bAnSsKKbB7ECGN2AfYwfVbwVkwCYP43wZTmXWQrkpRX1Jo/YTlXg0atk/Z2oRX07+2Nx0A4y30xqegilYDBKOs0kruEVu7lD1DP8Gz2pDDf2CI8WDQgv7pRnpQVTbkgYsMPIHwnL5WiULUkirxq9nizyhyI5tABPtoD3alVYqw3LnoM5EiEY8fArUlnbTPFKdlALLkoWJCLCUxeQDqWDZrBmmf8lCacKNITHpebFeu0X0y/kmZzS4czH6KamUZcr9wkqkWW5kaU4xFOYUnd6GVjA+tLXi3jFnjfbim65omcQVK+eltNLBMjB8kul9Tdue7SASvYzyN1R863FAxoPegGw1/R6s23upCUCWKaJDFmcxFwRk6vX+Ay5umwjcikMUapBWeXm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39830400003)(396003)(376002)(366004)(451199021)(4326008)(54906003)(316002)(83380400001)(6916009)(36756003)(5660300002)(2906002)(41300700001)(66946007)(66476007)(66556008)(86362001)(6486002)(6666004)(6512007)(6506007)(53546011)(38100700002)(2616005)(8936002)(8676002)(186003)(44832011)(7416002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zcyyScXq6xKaP5nQrKrgnG2/R9Cw+1YHx6B91AvfI7yI9hKbXGDrbQKwH7kt?=
 =?us-ascii?Q?9SncgZ/K04ediOA+7toP2jyvuYAx4/7TgizN+y+DOW2BMF6/nLNXlUz9p3jV?=
 =?us-ascii?Q?g2iqky0HplH7NiAzsdzaIpyEhEeEoME/Romnvppt/3RxcZzwHvHstHttYdZ8?=
 =?us-ascii?Q?3lRtgASdHn0kvzMzdjuzSoMRo4+T6f13DikIBXfXGevA2rKJnbbfFfSM+5XA?=
 =?us-ascii?Q?BkvG71x0qA9PVHmqsrAz86UCmWzHZzkxsQ3fMAtnbb0phUy5t+4jxCIjFGyA?=
 =?us-ascii?Q?MeZP428rrQ2fVfwpib/rG3MeYF2c9jI6umtChwxXPhHNRMt17BNxH5UYBgYh?=
 =?us-ascii?Q?DiIRcjXU3ylF4OUZKEctyLZZBaggeeNtBHg/kf8pqm90nebq2PZMu3nXftnx?=
 =?us-ascii?Q?BsftT94d+38HsJ28rpPU+syK64KtQ5PWkpbRVIbN41xN0dVN3xgUiLE7slI4?=
 =?us-ascii?Q?hx6214E7i3Bc91XqTFckm8MATbqLHOCwzmgWsSgVslusP1N5Mor3TValSEQH?=
 =?us-ascii?Q?uauYLG4eP4spihbd/zZNP8071U+DmLK5F3ljIem99ojvePjx7ZhH2xk11A3u?=
 =?us-ascii?Q?rwcqm9p1nqDY4vrA+ynzqWFBfezW9G0fUB/BrhyXbVK8w3EQcjKY/a0xaoue?=
 =?us-ascii?Q?JD/nwoJ2XRxB/KR6AhFRxg9FnLhEYjEcCBJ/dF7WVc6ihYE/9X0RpTxqUeDK?=
 =?us-ascii?Q?gbKD3Ba2yIfNX+NyTP4WZ3Xf1ZXNg7VUcGv7ByAKHzPbiH/zb69S9b6Cl53Q?=
 =?us-ascii?Q?UCBcUel1KTJri5jqFFXgzMTeMUVHk+l96MeXsT7xEsNnjg739fysRBFjLA6c?=
 =?us-ascii?Q?BrJ+gaO2r7k8bLixylS3hyzaokYdq4I/BYt0nDGBCKeh5cjIO7DoPsmW3oLP?=
 =?us-ascii?Q?DzPq0pO7OKeN+BUsxVknlVvZJBw/KwAnDM+OtlRAjr/7xB+1nmBH0vWeWLI+?=
 =?us-ascii?Q?i8dMrdbaKCcDfaB4gait5rxIS/LrpEBsrH6vP6T2FZyuV9k/Of1QMe0j/PUw?=
 =?us-ascii?Q?4ki5W8UAtQvvrAmYHfZsNTrLdoEilT7PhviZRY0l+Cpe7ZUsfxqZIRzpWEwq?=
 =?us-ascii?Q?Db43iTXP7Gsi6X7qW1TFtmb+2A7wRbnUDl+WAx12honm8K1hjf2qw3L07i+L?=
 =?us-ascii?Q?TwDRHHKqlemZt5fI8ejciBukpjBBB0zhia+szdtbQtvDFjbWRwixhyYKI2ZH?=
 =?us-ascii?Q?kgKyD4Hk1FzyPjiYMLVMjdhItdYQNgXdIHOouLT9/8z5/jgt1qQIzQ1Xcsnb?=
 =?us-ascii?Q?9tRr/xPghtRk+YCBfMN5sk9A4d0IW5dmDG3xwnWyj3Eq/AuRJddqx+D75ZSm?=
 =?us-ascii?Q?LDn/iaAuCqKqezx+PJFnqYvCVeFoB7/BTx/Ndy4oducSwwT0/tGjGoZEKvBb?=
 =?us-ascii?Q?PC9/JkxNShxcFBQRxbbC7NARWArr9hp9xnn3Sh07zjeBXAY014D6YhkiwH/B?=
 =?us-ascii?Q?+bvsfYjBhJsx+vIsXsUiUuoYw6jE7zU1t+/eVU1RpYOiuXImRhW3x9eHOPf2?=
 =?us-ascii?Q?FoAY9dhS7kGbGpZ0Trgl/M3S+3S036Jd3RR7ufchG01byX27r4AudJlFtG1U?=
 =?us-ascii?Q?hJycOYATi4j1onfqFRb1BGdci4k/KHdRR4kQf83otcedgFDGZF030+c3Qarf?=
 =?us-ascii?Q?R9XuXik8Mq/fkAXfLd5ggQspPVliqJPu/Cz0nV4TT2HDtsXLXn3ANIPzpqcC?=
 =?us-ascii?Q?HORD5Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d3bc36-4461-45cd-31e8-08db5156cc1b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:02:23.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GIrpIy8oV3bakIB03MpdrZ0Rp2PM/sN80PIldO7W7sUvniAv4wV9BVrroH0tkCdB4bJtCdIYfI5oA/5gbr7eqTVVELde3fg5K/BLXtxl/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4452
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 08:07:36PM +0800, Yunsheng Lin wrote:
> On 2023/5/10 16:40, Simon Horman wrote:
> > + XDP people and ML
> > 
> > On Tue, May 09, 2023 at 07:41:45PM +0800, Yunsheng Lin wrote:
> >> Most users use __skb_frag_set_page()/skb_frag_off_set()/
> >> skb_frag_size_set() to fill the page desc for a skb frag.
> >>
> >> Introduce skb_frag_fill_page_desc() to do that.
> >>
> >> net/bpf/test_run.c does not call skb_frag_off_set() to
> >> set the offset, "copy_from_user(page_address(page), ...)"
> >> suggest that it is assuming offset to be initialized as
> >> zero, so call skb_frag_fill_page_desc() with offset being
> >> zero for this case.
> > 
> > I think the question is, what is the value of bv_offset before this patch.
> 
> sinfo seems to be part of the 'data' kzalloced in
> bpf_test_init(), so bv_offset should be zero too.

Thanks, that sounds logical to me.

> > Lorenzo and Stanislav, do you have any insight here?
> > 
> >>
> >> Also, skb_frag_set_page() is not used anymore, so remove
> >> it.
> >>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > 
> > ...
> > 
> >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >> index 738776ab8838..30be21c7d05f 100644
> >> --- a/include/linux/skbuff.h
> >> +++ b/include/linux/skbuff.h
> >> @@ -2411,6 +2411,15 @@ static inline unsigned int skb_pagelen(const struct sk_buff *skb)
> >>  	return skb_headlen(skb) + __skb_pagelen(skb);
> >>  }
> >>  
> >> +static inline void skb_frag_fill_page_desc(skb_frag_t *frag,
> >> +					   struct page *page,
> >> +					   int off, int size)
> >> +{
> >> +	frag->bv_page = page;
> >> +	frag->bv_offset = off;
> > 
> > Maybe it is slightly nicer to use skb_frag_off_set() here.
> 
> Yes, that is good idea.
> But we need to move the definition of skb_frag_off_set() before
> skb_frag_fill_page_desc in order to use it, I try to keep the
> patch simple for reviewing for now, so I perfer to not do it
> now if that is ok for you.

Sure, that is fine by me.

