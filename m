Return-Path: <bpf+bounces-4272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DFD74A015
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 16:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4E21C20D92
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B74CA93C;
	Thu,  6 Jul 2023 14:56:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB1A927;
	Thu,  6 Jul 2023 14:56:19 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDBE10EA;
	Thu,  6 Jul 2023 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688655354; x=1720191354;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PkbJgzY3EkNix3LwMRGXUMr978vsWJpaNvXd8w5UPwM=;
  b=CA9AgvhpwA/3r145bMO1Cf2yKz2RLOonz7SlF9Gmzx5YK8drgHuQFNbx
   ZSTA+k/8NmNhbFL1ok2Bo2mH+s4phurKRJRFEISObLLJbEZm5Ebxcz3xW
   3dqMDN7ABUVMeAaincixKe6n1B5STM+GJxZPzLv52krYtkfd1bvJla5LG
   PSoP0iEl2LHr5e6h6KgGrykvc2GcL8GKCBG8Ur5TXILINjHp5pWulJ05I
   EgbZNodTBbBClYIRz0REcGgjOtUTbzZ+CQ2j9DvL0NYeRtP+h19qAs+ha
   uIKhEhMYxdbPNR4XpzuGc4/xnpMMgTC9GNFIth5nydK2LD10/a7f2WGQ+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="348411163"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="348411163"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 07:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="719610159"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="719610159"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2023 07:55:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 07:55:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 07:55:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 07:55:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGj3bG2dEGcab3WMyab3kJWB45B9l6ymXtdYxwNVAj1MGUzO9yO9gscHn61EC9EbroLwnATp2ol7aqoJ05T7GpeDzkpIN/8QEuGbsmfjehYEXCnxGp+hmaJuqK3rlrWzwUiXJ5+AZyux9/9H7hk06bpXN81IYhB4pafly2aDNjw3b3IFagZ2gM+atvPPrmyJEDdyhrse8jWo9nvvU/o4bGfz5Pawl37yANeK4nwxG9P1yqsLLN2DfThaTjyoosYmW1zpBKub8xiUTVQvaMyVlj3T8qyY71hGSYifK2jNks7VETJdMAkt6+HhngCZSz6hQ009qJ09PbTpFBWZFCOP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hebLRoctLHgCvl1y4i/FXvM5AMf6Q/uWowMjuuAdwg=;
 b=VdYIlEv6H5/4ZsDh/9yAtqW3mO99Uw0qtYhWnAscPnYym4JTkzylin3hrFkYorAFUkz0c9uXX0sXmJEHrLR1mX5Lv9uEQLu4dIGAsSZgUUZrniUdtOFnpxThCL1wC36Ti0ACsDmE1WBtphQRfknxaysrddtiKIZCkv5Jp31AwUr3uC3mkERixZ/UB5/8KyU5hSUXseOzA67BblmvFFQaoeJ6j3PQKLgDqXQjRQYL/2cZCL7F3HcJePjD1VwbVqSKwUxDeFTctCfb06DlpupnE2KeuAWNg1cJSbWlSaJp+jhMQlpzKccd6deRuMna8i4knNwn90l/0AqRhAG/UOqzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 14:55:20 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:55:20 +0000
Date: Thu, 6 Jul 2023 16:51:22 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: John Fastabend <john.fastabend@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>, Aleksander Lobakin
	<aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf-next v2 15/20] net, xdp: allow metadata > 32
Message-ID: <ZKbU6qaPUN/gPY9t@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-16-larysa.zaremba@intel.com>
 <64a3386623163_65205208fe@john.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64a3386623163_65205208fe@john.notmuch>
X-ClientProxiedBy: BE1P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::6) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee95014-721f-4368-c249-08db7e310445
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjaX2Ioc630yZvIKw9kf9DDQPY++IJEcrZvD22Q8Iv73pKKPCg7zXT9YBGpwfqO+if14rPCwOQGv7bULNgLT4d6DyovArOZPq9YzTZQlkiF49Vb8jdkLvoy/M7DsBs1f22gh5RERHfXxsO1T/FQgGh6KJRmxqwT02fChppxsm+wdSopZH3cEwddClvz8FeD5A9ezQf4K3chMM4eSrvCFuoQgItoFtMuTrpLP7bNwwrLqUv/pIsLOF5jdLAcVV8Iysf3JaGBYubcgCTQCmsBpuyzwBak//nLwygTKrWmivxB3Rt38cuMbp4xY+WsYN9/77dUvTPagM6if080avjvCNXobXKWlYqO69XLs8taLe0F1mvfDOlIOCvdxDtTWME/LYH3YeCM6d+HHhWGvvwanPLHYA+jaKlzO+GmfqlZjpCggITj6rZdLfbkVc8AAcx+YT3KNhzJSB9fxVwbKV6Rp8O6Yh2RQXkrOKDkiP6NhNeEETyr1Ls7p0+uOFb/Ylu9qcp/7OQAD/y7v/BVApPmoBwMrWOjB48Y3FuT+MF1eKPV863JJsrDaq+UvwdmBzWA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(38100700002)(6486002)(478600001)(54906003)(26005)(6506007)(6512007)(9686003)(107886003)(186003)(66946007)(2906002)(33716001)(41300700001)(316002)(4326008)(66476007)(66556008)(6916009)(44832011)(7416002)(8936002)(8676002)(5660300002)(82960400001)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1IzxMkbS2Dxp40id+Ldsv1jw5TgLiBUpoLvOQhDFLUMv0PY5gfo0FlaRl75?=
 =?us-ascii?Q?Qj4Ae778BDAGb9t0enkk3d4dh6C+CBWOFNqYASox3HMDQXmL2JjCQ3HeTCSY?=
 =?us-ascii?Q?9Ntrxc/F/dldyN6ftwgYRxBXnK/bu8Kgv8rPIxwTqqGB7S0aoGzy3NxSgPDf?=
 =?us-ascii?Q?hiWHTMY5YdHlNzXMjhrhntMtQ59goysFlibJoXcMsWN1LGXruYUssHJ07417?=
 =?us-ascii?Q?ITzngErDk/LELTaYQ7BeRU5YiMOH+gy6c6eDS0W25yXcksEhaUz7B/oE+j+D?=
 =?us-ascii?Q?GOVYqNwwf+SAU1flyMjqtCIFWHg6oNN30uzwGal8JMAGOWN0FdZpbSVNoJ7f?=
 =?us-ascii?Q?liFw1oDthVEzIy/Bc7t2yRROD7jjf5Ny2ToaINTeCX0AnfKbxSxLuZY9Jcmk?=
 =?us-ascii?Q?kp5yp7yS/Ibybhgjv8RMiVynwJSJuJyU1bP8OGW2NXg8cFWTXAlkobUct4rw?=
 =?us-ascii?Q?ViutHMeaqP/qz7GbrrOobrlTFT3yhft3yfxLpyLYv7MkYpZ9INWE/Yhl9B/g?=
 =?us-ascii?Q?O5KsO0VPMvtC2vWKy9UUzcprWAgZNovs2BkEwbyNSIUbnpl6Bb38LVsQQ082?=
 =?us-ascii?Q?6EYmfITjXcHuo1ABbwzzx8a+Kv4fTzJ93+lOmGd3yxWd4o9BxzDQppw1P2QP?=
 =?us-ascii?Q?i26dbvBnvKZe9LQP4BWhUQtw/PCiHo1s4fMn91fy9mtWqmiyvMM6+yA6Iaoc?=
 =?us-ascii?Q?BCvCGPWmkpqTVRRoz577Y3hHC+piW7e4BdSkYVxQ3ojAHbCrPcDK/zqFNlFO?=
 =?us-ascii?Q?QzfJP4TVGsFBQMFjFWcA4QQBWrPMWcy797kIsgN0H5aTsMNeG5ztU5N7p+CI?=
 =?us-ascii?Q?7nolajoIlu8Den4siAGkg9EMrJTd4vmaHJdRYzh33y0SC9Rn7vVZxnv+JP9Z?=
 =?us-ascii?Q?6nuZUtPoMzfNXqx4gUq4tr0zRgX0HyEieiIUf2sUIQqcq9/7GRNlk5PWydkV?=
 =?us-ascii?Q?/vBSrGGFV4AhFMPQCB14ImjpLey6EFiffPcpVyGbE4nFEDvzpjgKJb64s+d0?=
 =?us-ascii?Q?EkHZhHBBCxA6TLaccNn9BiSphEmxGyWmh4oUVBaFZWhYUbSo0XqDzwjVP/9Y?=
 =?us-ascii?Q?UAOkwAwyBDaaZNvIjp+BtdK5qOGaMvX1aGE1d7t8m8dowPhXp6RvCdnAaTir?=
 =?us-ascii?Q?QDmoCOCS+ArJcUSRChmXK0jF4ay7p0saJFoK56lCnu4ZhKkMrTxYVl3uFNS3?=
 =?us-ascii?Q?oUAfGD7kBKpb4zX1slpVZ6lWB33V01kefsqR70ZpXPS/OcQUZQ1DRnCv2Oji?=
 =?us-ascii?Q?arE9wf6DOWqqLi5BX1KAsQfm68HF71+iVek0Fc/ZDecCfss+kB1t3FWkr6EQ?=
 =?us-ascii?Q?//sZias0ys6pUmZRMAWHm3S3h6eUBJ4TJq9wA5eQwfuDi8/LEuPCz2NIJ0DO?=
 =?us-ascii?Q?4llORq2pcKvab8C8rFSRlIrvzEPrr9bcRwkYu8ns/D9xlpz813EFJLTVz6OJ?=
 =?us-ascii?Q?R88BSR9gUnEg+O3YaovAWPThcsXzk2qMYFdD7fRRWZtqitkSKNaW8/SDjW98?=
 =?us-ascii?Q?VIDDGBcMMrtgw0q/c4WrIfSmjaWyijw7QUG2tCxYL49s+fFho5ZbND+i/zqn?=
 =?us-ascii?Q?uipZX88LBDJLk1n0hkuVWDwlUPGROmq5Jgm6SmeMV43cWvMLGMEWzSCoY+MH?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee95014-721f-4368-c249-08db7e310445
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 14:55:19.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4LZKwxGyaPJLCbZUPgzJ0ntB8UYs6DTnG71W8nm/ZWHwErWl0XE7r1unEZlEWcheP0dMauOyNYWAlJHeLreN+ZdgG9ixr8gv5MJO/HkD60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 02:06:46PM -0700, John Fastabend wrote:
> Larysa Zaremba wrote:
> > From: Aleksander Lobakin <aleksander.lobakin@intel.com>
> > 
> > When using XDP hints, metadata sometimes has to be much bigger
> > than 32 bytes. Relax the restriction, allow metadata larger than 32 bytes
> > and make __skb_metadata_differs() work with bigger lengths.
> > 
> > Now size of metadata is only limited by the fact it is stored as u8
> > in skb_shared_info, so maximum possible value is 255. Other important
> > conditions, such as having enough space for xdp_frame building, are already
> > checked in bpf_xdp_adjust_meta().
> > 
> > The requirement of having its length aligned to 4 bytes is still
> > valid.
> > 
> > Signed-off-by: Aleksander Lobakin <aleksander.lobakin@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  include/linux/skbuff.h | 13 ++++++++-----
> >  include/net/xdp.h      |  7 ++++++-
> >  2 files changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 91ed66952580..cd49cdd71019 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -4209,10 +4209,13 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
> >  {
> >  	const void *a = skb_metadata_end(skb_a);
> >  	const void *b = skb_metadata_end(skb_b);
> > -	/* Using more efficient varaiant than plain call to memcmp(). */
> > -#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
> 
> Why are we removing the ifdef here? Its adding a runtime 'if' when its not
> necessary. I would keep the ifdef and simply add the default case
> in the switch.

Seems like Alex has missed your message, but we discussed this with him before, 
so I know the answer: Compiler will 100% convert it into a compile-time 'if' and 
this looks nicer than preprocessor condition.

