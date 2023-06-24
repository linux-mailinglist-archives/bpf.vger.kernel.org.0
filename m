Return-Path: <bpf+bounces-3373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDEC73CC90
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 21:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD611C2031A
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 19:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C12D79E1;
	Sat, 24 Jun 2023 19:28:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3179D1;
	Sat, 24 Jun 2023 19:28:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2126.outbound.protection.outlook.com [40.107.243.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC9E1987;
	Sat, 24 Jun 2023 12:28:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUSYx7MbLT/FSVRvr0uJj2xs82UALNhFnJo7M7vCyjrHfNexKbJVoDqeYxQ4+lHl21Gc5tsSr/+7E0jabOPEXgrdkMROkI+cO1OmI9ZTqK6JETywejN8fKg0bfNkRYSZi4swkdR/uyJdDFf1hFd5DPmV/bzsePy69YGSVZqDo9oYIVQFb/7CqMF8ctDk/OiqLXVh2PwirZL/PJ0/nvd9MWHIYdhJkVM4vYt7S58895MH2nUpqJms2XQ/fEZ2OHGggID37WIv2mWuOx3HV3CwyD1Ey7GWo7yEtXQa/jTIXe5PrmT+6NsreB6COjnwUQ67T7wQoX35QLpQcMJC3ujTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NZJ/cR1pqaBqiklhlehBd6ud6juhl6p8JPNrZjyABI=;
 b=l5QJgQW90i7iW+x9sSae4Zbz6+JgP/7hFj+gQn9LDqN1NgSDb1TG21Rckiv2dYiJ5HIVpzpCThPEVDbsU13lsf+/1HixxH7tnrUVJMc6+gVPhnKI5Uwg5CRF1fu1PyEQpFPmxwAWhsf4W6yPF+XHMvftgBQ2IgPErzHnBUdjH5Paa7IDnvgI0h/W4TvWpxmOB3PqFZzd4T8aP4qRz9vI2I6gF809USjjK63w6XQwoHnemUjXlvJ+2Z9awJIJZvZ6vPT+OzNupfuzLubnlBVKkOpXVbm4SyyLBQ48XZewMPLuuBtGHNpmGDWIvDPFOm4nDLg7k1DxvHmsHG/NYtEXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NZJ/cR1pqaBqiklhlehBd6ud6juhl6p8JPNrZjyABI=;
 b=jJVn23Y7SdGpH/bn9C+wVcnNBW7koDZY/KINeJ3EjjrJZ/16JbZ8adds8smlxZF5fbzBqNzsaCaOsAdjxcJBRioxCm66qz4KzxyOPJFJ3TaJsTqeSsj5Lpwltp0pTmV1bqhbfUxYZiTlyV6N6PCo1Ubqz+ZJce3aPDVA1cVxg6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB4045.namprd13.prod.outlook.com (2603:10b6:806:73::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 19:28:49 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sat, 24 Jun 2023
 19:28:49 +0000
Date: Sat, 24 Jun 2023 21:28:42 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] virtio-net: reprobe csum related fields
 for skb passed by XDP
Message-ID: <ZJdCW4pxTioTPKJn@corigine.com>
References: <20230624122604.110958-1-hengqi@linux.alibaba.com>
 <20230624122604.110958-2-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624122604.110958-2-hengqi@linux.alibaba.com>
X-ClientProxiedBy: AM0PR02CA0167.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::34) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 644f029d-cd0b-4d69-d711-08db74e93c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3m/hmUH7IhoEfKc2bbyfdqTwRCnaf5MWyFCD/3eYa4+aG5gtEuy2fjzm/6iQ2aEJDOamOyLSnZFfi+MyrVtOdTxTKXzpcjbfnnYdLzC63gbFZw8shRhoSZi4FKi6/rCWc9LWINRPcNxo0M9d07KCfHQ4BIqD2WLqtWELQnkM9fbMHt1Y4XWsgv9GlZf9KSlr0fbRfowEKYI9PUFocMaIxfdj7KkOHGS3g/OVTnjQ2mk2YDgU5aMXaVQDQ1gWWFsDlPoCfInSYGyMkSQkglDKisWIBzXrnWQdFKFtaA3FKmfDUl6x1kPLAllaqj0ryT5//uaVqKETxucVMtDrN6D/Flwab+BJADRlbMGGg7OI2wiYVUu5Jx5nguemxp/q/m+1XM53aBxF77Fe/x9o0oH6MHUPFeIF8ORUVqbhLk3cqt6CUjuEn+cHD/uMWSuQ8N9RI02le/LMgJrjxXccMs2FDF2ETyptaZPABxPekj/qo/CSH5jrCG5v2S1AuV+i2mV6bn3LvofkNxNvPyPwmJQXoonAsbcwAlrJ2WV2S1k6ka0JcfUvr1c7Ngmdn/QhHXWqUxEyRgjJdSfBmLKEf1XtuJpYTVgNCPjhPYQTNi7SaPA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39830400003)(396003)(346002)(451199021)(6486002)(478600001)(2616005)(54906003)(6666004)(83380400001)(6506007)(6512007)(186003)(4744005)(2906002)(5660300002)(7416002)(44832011)(36756003)(38100700002)(4326008)(66946007)(8936002)(8676002)(41300700001)(316002)(86362001)(66476007)(6916009)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tplMCDMM8W0ZgC4XRvgzhyYAo/AvqtFYYCnodynVBBTgH3nMHx8iIxBuT0+A?=
 =?us-ascii?Q?ANIiznTbFb6qPes9IvqIHLVuuQGoI6IuhL0LOjS/i4Si+OmNEKG9hQ9MTVu5?=
 =?us-ascii?Q?VT+gjbF+RBw2F3PQhzYTqqjidT1jZ2vW7kDMxyoOg5VSPf98yFQdhvO5Haiq?=
 =?us-ascii?Q?JOP0BThKlKi+Su9ia03T9TyXxO8M6S+k1ak/IRBoguW5F9W41Rr+nYvJZXkn?=
 =?us-ascii?Q?GRn8ZmqKgADry327l8iYsYFBnHeoQIz4Xr+TbvrqRMewjX4y18cI+oY1AM3J?=
 =?us-ascii?Q?Ahywvvl7DdYq9nr09KMTGM7K6Cx7CPi8I8brxLzmfYS51vUS1+varQkRFhSz?=
 =?us-ascii?Q?SGKGZXaBhGq9xExIPbwQzVWrkCL2wGxbGVtO1gbr8KGGZhSgIFUbaMKLnomE?=
 =?us-ascii?Q?TY/uhiD60hCDXv3nEnfS0gBByInmSYZvfkP8XiFqMqetz2x2Tq00gveqJjIM?=
 =?us-ascii?Q?8NnXlGUAxC+NYGUIkbgwDEDXJMcrZ/RFSMOXIxjwydGmsLEhsxUk5/TcEBCN?=
 =?us-ascii?Q?eUhMrhUbPNE0irD1jrcRgL5aM157EW5orIXr4AuzCcPck5cVovTMQzFHV4tl?=
 =?us-ascii?Q?ObpfetB5HdjP2gt5a/bsg4Yu1t0bnFNisBgPdnvsR66F5tzDZLPwbn+K5FA9?=
 =?us-ascii?Q?0OvIMIHZaDorQEJNN1vDOrVjT5E85IBvxoW98ubCYPdcZ+DNma9sNgV+5jBG?=
 =?us-ascii?Q?+hGjAlcYXTKtDVQxNei4LFPlP7tdI8McjVKzPI+ySNYssny2bT87vFCfMDUv?=
 =?us-ascii?Q?9vIEkEtZk7/4e+D7xuLloauyOaDKt+CNjhIyrcQGbvNIreQoz9SkB/EzjXQQ?=
 =?us-ascii?Q?jIc2t1/CmFe1qcpaXKoMk6lOySji3iV1YYmYuW3N3rTpEbjB3gJMfPuCkwe6?=
 =?us-ascii?Q?EbQOFLMR1TSUavmcK4CLGhD0M9EFkXdXKIoX513bYDhFL1UT4hobdEKaAFyE?=
 =?us-ascii?Q?W9im5ZI1jP8LQG0TOE4LTAaKzGpI0C1ACoy5QwUyPTNNpW1Vz5AWGH/Q/ktF?=
 =?us-ascii?Q?AfzM/JaULv7wrP9/mYH3ee3jqQ04DhPRieQv98Rw9h3azcuhFVNuHQhnJke8?=
 =?us-ascii?Q?RXeFtVN74q0RzE2Udd5XbxDglRQp5b5qmqtSTxGL4lDzAo4kFg22hk+BrzW0?=
 =?us-ascii?Q?c7rYrAp6ReGkxvHGjgjWb9kt5SlNYpCTR5RDxhrI3/dytbOQNIIoEOiVs2zr?=
 =?us-ascii?Q?X1fuYcjTO1BpYAlBTTyapGNBtmG5cVvk3ujs03i1s0zxCOTPBvK5Em5vP005?=
 =?us-ascii?Q?c0QFwt7aMMYjaHBAE3z1m5zzBv/QPLe6iUiH5lqXxW4pvhTkoKm5CFW8oD7S?=
 =?us-ascii?Q?TfOkwQfw4Qr2/KMqZOASzbBZKKsw8xnAdzvFYhNjTrTwDi3lPpHgpMkPVI5F?=
 =?us-ascii?Q?Fu+QQ1YPK7AXV1wilr+j3KBiM7iCv7ufk3fQQHHhxJkUMN7Z5T3GdFSxchHi?=
 =?us-ascii?Q?+yurLoeBZwqED+E6QCX22g3x3MuPA4jk+z802GVkjbGr8WzLccsmItvHxAc+?=
 =?us-ascii?Q?F2Ip8WqHW34rTWcTJTqRqnlU1Kk5klfKW/hjKTujlaV8jzewwdk+AG2hP9xs?=
 =?us-ascii?Q?W0PLZr6oVYeskeLutEVUNYmuyWPiEgOZL3fc8bbQyCbULFxk2/E9hv9waoNz?=
 =?us-ascii?Q?azB7DDwBaZ+2+sGJiOUIDDk4t1B2Ay4UN0zqjACoOboMHW+0uhNa4sb+GWqc?=
 =?us-ascii?Q?n0N1CA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644f029d-cd0b-4d69-d711-08db74e93c71
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 19:28:49.5532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LSbo37cpOKlAUvT0LCZZ5fL7lm5kA6Drjyj2rRHhxFWZQ54LbkL99zljvOYG2F2d6LN3sxe407jKsPlR9s1l1jzjKJ4LOGcrWdE6d7jJmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4045
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 24, 2023 at 08:26:02PM +0800, Heng Qi wrote:

...

> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> +				      struct sk_buff *skb,
> +				      __u8 flags)

Hi Heng Qi,

Unfortunately this appears to break an x86_64 allmodconfig build
with GCC 12.3.0:

drivers/net/virtio_net.c:1671:12: error: 'virtnet_set_csum_after_xdp' defined but not used [-Werror=unused-function]
 1671 | static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~

--
pw-bot: changes-requested

