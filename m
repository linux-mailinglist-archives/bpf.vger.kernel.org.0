Return-Path: <bpf+bounces-294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D88E6FE0B8
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 16:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F33281557
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 14:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9E516406;
	Wed, 10 May 2023 14:46:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDA16401
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 14:46:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2105.outbound.protection.outlook.com [40.107.244.105])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365A2123
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 07:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYSwTcu5NeZp4z7q5JWS2i3U1NLQFx4m5+h6uJgWUZa4TOI3sCSMPAdQyyFz+dI/AR8RSlbwGYOtZeGusX8yI/tj+Q6HO07GkR7uFDL53U2+GJ9wtyblf2QDL0EpExwpVbTVsx9G4TQcnpdJHxjNcH2oy4GUp7NZjviL5TKMr+qGwXfdt4kmxBI6sgOIMm+ynbhUj/rSwvLhgN03youE2fcbntFOdFQw9+KE3RBUurfzP368Z64p+vp1EWYhmEp7dNOKDqApkiocilDnOv0RPBSLpM/opdFcjqxVqD/ZBHgjunNEkFjprfmTuqKtTk9T8bIDDz7fv3XbuArou8flkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN6daDiyWCFtjvmdDK5dOOKRzsXSxsqAJH+otRYrClI=;
 b=HifTeyZcH1mNo4Omch2e+UQS6VxjU/H4THmc6GpLIcNrcOCnI587iq695QrlVQDyhbgrm0aAK17j1geAx7AYJ3OP1ytM9J7ei4rtjn1eM6l9zTKukvTg07TOq/FXmX1pXDsRWEQx90hyJ6pJ4sH1LkjrB8mrIAOsYpqbDL7dqmScRH98GmETIAUrxDrJ/Ue++/EbBu4Z8AJ7xE7C163+D4Lmb+h96zFQOFhIdVEXGY7Lao5U23BoiJXPkhB/FilKBZks6TmxVJQOTm/8iYktcce/doMuP6JxkMYqUyHl5pJAsKlntRNBCpcLRhcVrl9N0y38Qi8bVkpXtHtKPtG0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN6daDiyWCFtjvmdDK5dOOKRzsXSxsqAJH+otRYrClI=;
 b=GWM3QW04xQcxZSCuCvoX9srNBHEqkkVnXUyQnvi/rgIWk9hm88GkrK/leU8e+g5dqTvrWmA7lUSgbhGHPXZUabxOipQCel0dv0pgLliY6qxLtfh1SSPWHvlwN7QKOh/2n2EZD3wN6O58GmphMJZVpj9hRrGt2zfybJ5EviPMhyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB3935.namprd13.prod.outlook.com (2603:10b6:806:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Wed, 10 May
 2023 14:46:30 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 14:46:30 +0000
Date: Wed, 10 May 2023 16:46:22 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/2] net: introduce and use
 skb_frag_fill_page_desc()
Message-ID: <ZFuuPuTf9Bv6PT/Z@corigine.com>
References: <20230509114146.20962-1-linyunsheng@huawei.com>
 <20230509114146.20962-2-linyunsheng@huawei.com>
 <ZFtYkmvQ01YxHf9s@corigine.com>
 <e78bf687-8b3f-f40f-ac52-8c3ecf7ef40f@huawei.com>
 <ZFuV2MEvcggfeRQS@corigine.com>
 <CAKH8qBt1OUZchURzkOqA=XsHD5iagL9TSN2+UzEVKCT-Sj5Ecw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKH8qBt1OUZchURzkOqA=XsHD5iagL9TSN2+UzEVKCT-Sj5Ecw@mail.gmail.com>
X-ClientProxiedBy: AS4P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::27) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB3935:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a2514c-0edc-4a22-7fe5-08db51655714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N/rUTy4OjJXxj+QORg4Gxqyj5zJZffV1e8DShcGLZMRFndRJI5korC8QTOd6k4vxba/EZ9IO2jAIRbuPw5CQo8c5fr1W892eDdHkOEzibOMtVx8nYcrhFNMIaaepHfuP71gQ38hDPLFqvwVw0l1JeInFmMRFvsXOPTPJ8Ioj+TZdO/2uN/jj53CVvEY2Gp4T0vaANWSZHeLNw15w9I7dbbry3AJlOq9wffQqjHlY4wmiAyp+1Ko9zn/2Pa9U/HOlI8t3/JofZozl+skLu2hc0M0K/kAvRpgD//phM+HKyjeVSug49K2SFxmBfdVkVyksBNDkeiXtCDoh96icnq9bNeSm0QCXdhNh2cZmoOJpPMPmaxaGOoPCkeRjv1bo5tMwFBSww8Bgr2ObAAZXBdBoEJpzsDJuFOZFVxJQzbkHJPx2R5ifVziMWEkJLPHbbLSrU8bOv7fSdtjwzxrStmHOTz1+mMYhpMMWjhdgSo6xxnNeMLWVnaWfu6E7gM/26OSRU7TxNXSjOkuKT0dOzUl1MwUrDiWG2TZPQnYZsdOPc+tVa2Jn5PFDDA7d+A8NGia6Ec5f7hRyBNNhsLDLpwinUNjufkXcK4YXXifiFPcQlA0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(346002)(376002)(396003)(136003)(451199021)(66476007)(4326008)(66946007)(36756003)(83380400001)(6916009)(66556008)(6512007)(53546011)(6506007)(2906002)(186003)(54906003)(478600001)(2616005)(8676002)(38100700002)(8936002)(6666004)(6486002)(41300700001)(86362001)(5660300002)(44832011)(7416002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU52SFlDYlZBZUhQYlh5L3ZJVm5kYThaOW9Vais1QUs2TUd0aGlvS3doTG5s?=
 =?utf-8?B?S05NZGd6cUUwcnh4ZUxqZExjOUgxQy9TeUlhZDdtMjRrVjU3YzdTRDYzak1n?=
 =?utf-8?B?dkw3T2ZJTlpZb0VEVllhZTc3M2ROT2p0Um9QdmtWK0JZeGxjUXNTcGVycGR6?=
 =?utf-8?B?WTNpd1JBbHRsTGQ3SzFWbWFVT1cxckZKNmY4dkxJU2krYUQ1dVlTNjNsZzhx?=
 =?utf-8?B?OUo5eFAxNi9wY2NtUUgxeVZ4ZkF0enNFUlhhWm5iTnZxY3JBVmVEOGlKVFV6?=
 =?utf-8?B?TWtwU1ljR0ZEMmwwcHhDbFRxTUM0U0twbFpXMXMyTXBEWE8wTm01ZnJONTNE?=
 =?utf-8?B?aXJWd01iV2wrWEdhai9ER3JCVEFia2g0TXhzU0hmMldzR3JNdDQreW9nK1Vi?=
 =?utf-8?B?dmR0Mk1qVHUvc1RscDk2V0RDMU9mb0hJeGRkWEdqM3g4amVlWEF4ckcwaGtT?=
 =?utf-8?B?VmtiWWpTanFQUWRSREMzbG82VlUxL1FkajVqbkg2NDRmKzRRUlFnSFE2dGdJ?=
 =?utf-8?B?WXBFakg5WFhDa1p1MitBdDRqU1VYWWFReW8zTjMyVFhqTkJPeWp5VUx4cVE4?=
 =?utf-8?B?Q05NaEU1VDZMY3g4QTJDd0d0MzdZNk1XVXZSeElSWE5zVFdVWVZld1FyZzZL?=
 =?utf-8?B?VkFUNjVwWSsrV1pTdTYzMnhvSldDTlB4b2ZpRFI3RGtlMUhKL3NtOEZhWmV1?=
 =?utf-8?B?ZFJLRHVFSFNCVlA3OFlNL3dBR25DQlovSDIrUzJycDVuanlrMHVtM2ZPMlZk?=
 =?utf-8?B?cEZmUEtRNlMxcFFUbUo3dWVMQ21ISklHdkFzcjdyNmVFbm9kRCt6QW8wcmgr?=
 =?utf-8?B?MU5MN2wxc1pFaTlRQ05adCt0OERTUTNxUko0RityK3UvY3BxcDRIR002SUdl?=
 =?utf-8?B?TktsckIwaEZ1SjlrRk9VWjd5dEdXVFIxRHFadlRBTGN1RUNyc1BhUk5KbFZ5?=
 =?utf-8?B?NDE1Syt5N0ZSaTFrbXRnbXowRmYvMGNwbXA4M2RhMGdmeXF2ZzhBcUtMSXB1?=
 =?utf-8?B?V1lHL2YyTXF5N3A4cXlKMUd5NE5JMk5RNjBtUTBQSittb2lDWStaU3h0VjRS?=
 =?utf-8?B?NmFhV3ZUa2ZxVWZyc2xjN204RlNjeS9tQjAxVDJ0dUVpZ2VYdTNhSlE5eHlp?=
 =?utf-8?B?MFpuNzBIMUplWDd5bHQ5dTRWcnd1K3hncUpVbjA5YkZUSWFnNXVxY3pqTVh5?=
 =?utf-8?B?VjZZejRxRlJlU2VHNlhCM29qLzVYUkQ2V1A4cStKMUU2SnFLZWY3WFdOS1lI?=
 =?utf-8?B?dXpNVkxrYzdlbzlMVTdIQlVBMUNPTnhtOTAxdG9VVDIyL1pXK2lMMnA2bGg2?=
 =?utf-8?B?aDBFajl5elJLbmZjMkdtZGE2SjVyTWdmcjEwY20rdkxQNmZMS2lPZGpQQUgz?=
 =?utf-8?B?bW9PNnpYdjFON2dpT1ZEVVhreFpGVjVYc01jREFLTkhGYUllNVJHSGI4cWR3?=
 =?utf-8?B?QmloUUNNcTAvZW81OVlYbkt6M3NJR011bHJXa0dqcDVXR0ZOVTR1SmVxVmMv?=
 =?utf-8?B?OTYzZkJIQS91c1YyOFVzVmxGdldidHVjNTJCV25rd2pWMnFSTm1kSXR0aXRn?=
 =?utf-8?B?VnQxdWs1TFJ5cWNuK2g5V1lCUW4zT0Y0WFhnNnExOWpXM0M1SEViaXBwUVZG?=
 =?utf-8?B?ZWVpL2J5ZjJBSmNWNVRNWVg0RDlEZTNiZkpMdFBXVWVGUGFKRFJqakNYYWZl?=
 =?utf-8?B?QTNZU1hoM2Foc1VxbGlGbEhJS1J6WHk5N0cwcmR0c0dUSW5uaURrd3ZqcGtB?=
 =?utf-8?B?Y1kra2FrTnJCZlhVSG5seEl6UXYwVEhkdFFBajMrM3IzazZNN0N3UUV3NE5Z?=
 =?utf-8?B?OFFjNllyRU50V1FkaTFhcFh0OG9DV1Q0dTRWSE1HWHFXRzJuMjNVTWlhT3o1?=
 =?utf-8?B?RU5LNTVwMlFkOXlYWlBzVmJtemVsNkNWN0swcEF0S0cvSmw1VERKcndNbFln?=
 =?utf-8?B?QWZmS2Z4QjkxdWd3eXhDU3ZuZGdsaittZkdhZTRlL3lEN0NzV1lDa1NPUVpi?=
 =?utf-8?B?aGtjNGFabFNPSnBTZWgwa1VCelRMVUloeCtmaFVYRTVMOUpUK0tYUUZ2d0JE?=
 =?utf-8?B?Y1hTcEVLZkhobEhiWjd2RlZYRktwWnp6OTdFUDN2blZhOFZtd3prSExQaVNl?=
 =?utf-8?B?MUx2WTNzWTRtUS9HYmtjVW1ZZmk2dTc4eE1Gak5oTkE3dmlKMTV4YVY4NXNN?=
 =?utf-8?B?QjBEaTBmekxKVjFqcGNJNGQzKzIyWVV6NWNCRGwyYkZZRm1PR1BTQ3N6SExr?=
 =?utf-8?B?em03Z25pbWFZTC9wOENvYmZ1SkRBPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a2514c-0edc-4a22-7fe5-08db51655714
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:46:29.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7caqu69ytsroQ0Sh8z/YJQ8fh87XmavN6D1heY/hg2N+7PPg0GqAkiaucsHSsa6HkkTx7RHksg9MRciX4LeCy8kVDH/YqUUKyfd6caesKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3935
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 07:27:50AM -0700, Stanislav Fomichev wrote:
> On Wed, May 10, 2023 at 6:02 AM Simon Horman <simon.horman@corigine.com> wrote:
> >
> > On Wed, May 10, 2023 at 08:07:36PM +0800, Yunsheng Lin wrote:
> > > On 2023/5/10 16:40, Simon Horman wrote:
> > > > + XDP people and ML
> > > >
> > > > On Tue, May 09, 2023 at 07:41:45PM +0800, Yunsheng Lin wrote:
> > > >> Most users use __skb_frag_set_page()/skb_frag_off_set()/
> > > >> skb_frag_size_set() to fill the page desc for a skb frag.
> > > >>
> > > >> Introduce skb_frag_fill_page_desc() to do that.
> > > >>
> > > >> net/bpf/test_run.c does not call skb_frag_off_set() to
> > > >> set the offset, "copy_from_user(page_address(page), ...)"
> > > >> suggest that it is assuming offset to be initialized as
> > > >> zero, so call skb_frag_fill_page_desc() with offset being
> > > >> zero for this case.
> > > >
> > > > I think the question is, what is the value of bv_offset before this patch.
> > >
> > > sinfo seems to be part of the 'data' kzalloced in
> > > bpf_test_init(), so bv_offset should be zero too.
> >
> > Thanks, that sounds logical to me.
> 
> +1, doesn't look like we do anything special. We just allocate the
> page and assume zero offset.

Thanks. I'm happy with this patch now, FWIIW.

Reviewed-by: Simon Horman <simon.horman@corigine.com>

> > > > Lorenzo and Stanislav, do you have any insight here?
> > > >
> > > >>
> > > >> Also, skb_frag_set_page() is not used anymore, so remove
> > > >> it.
> > > >>
> > > >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > > >
> > > > ...
> > > >
> > > >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > >> index 738776ab8838..30be21c7d05f 100644
> > > >> --- a/include/linux/skbuff.h
> > > >> +++ b/include/linux/skbuff.h
> > > >> @@ -2411,6 +2411,15 @@ static inline unsigned int skb_pagelen(const struct sk_buff *skb)
> > > >>    return skb_headlen(skb) + __skb_pagelen(skb);
> > > >>  }
> > > >>
> > > >> +static inline void skb_frag_fill_page_desc(skb_frag_t *frag,
> > > >> +                                     struct page *page,
> > > >> +                                     int off, int size)
> > > >> +{
> > > >> +  frag->bv_page = page;
> > > >> +  frag->bv_offset = off;
> > > >
> > > > Maybe it is slightly nicer to use skb_frag_off_set() here.
> > >
> > > Yes, that is good idea.
> > > But we need to move the definition of skb_frag_off_set() before
> > > skb_frag_fill_page_desc in order to use it, I try to keep the
> > > patch simple for reviewing for now, so I perfer to not do it
> > > now if that is ok for you.
> >
> > Sure, that is fine by me.

