Return-Path: <bpf+bounces-7173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4BB7728CD
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 17:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3E91C20BE9
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E59210975;
	Mon,  7 Aug 2023 15:10:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A210942;
	Mon,  7 Aug 2023 15:10:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3096610DE;
	Mon,  7 Aug 2023 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420982; x=1722956982;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BoqlASTseF92+jGlTgnBi6ZtRHs1udtIlBKCP9DyJWQ=;
  b=mZORUNc67BB/7JhVKZuy9JNHhHyd92TUPE+YgaV3yPhg2BY6DejOXxTa
   e0x+g4LjlehJOlMdpTwODJKyuTqklp56ytg0Z9+pI4bgRlIp3P3BfMfTT
   AxoXqT8TdFI0PNNRj61Y2mxEOkI8RqawxkF99kmpFQacbpbHQrhoqlKAX
   ST3AstjZTzSbhjEMFV6x+dQAStAcjg0AHFToN76Rk7TcgHG5E3IHLwric
   ticxdgH557uWvr+DuzNJIwEf45O6aHof+At317qMlIs4ZCYX3kBtfNGBI
   yzYxryTgw8//HgeiVnfJ5gwnJxCPjObOqGjh4pcRFhMCqoy4bIhGnivDj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360655169"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="360655169"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:09:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="760529293"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="760529293"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2023 08:09:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 08:09:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 08:09:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 08:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY42hQ/g9gLKyjlYsUKrm/VEAojCeQLO3pYAA+ad+DjCxY5knC/DW69yF3M9tEAaQUom8FDiCsHYEInTK5znKczlf7uXDbNEVlSKeYKtk6Idln18uhqHJGkXf9b5MmZuD9TgDrwh5T6YPCSQSneJs2K8/W7RNBf04VcxIRMdPDI8SSUcgheLvDr0R5CN6RtbJGzAfm4/9xGtxEHjiv2CCV36kqv5UOLXDLwkRenc86oiB0lo2DE8d+95B6LhkzVsklnxF7n1yLp2R+RXgoRYtan742F/vMVNGsA9vqEf2eU6H2ARa71iuRM8rOJzPj2yTZwJsSm9M9qTHOKZHc6Huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqv1FsIpmz7TZl501lDJHg9ZQD7PZ3UsMgvPkP1V9W4=;
 b=JhkxFlG6VQrUgT8k92jx8r6UrhmADLFz1Thm53CxLc9EwFCueLHnL+nXPNp7VNU08Ax6f19H8UoV/d1is2fTrfyFIZOw/rSarm19RodMZiYdiroxoyzre6axo+/FAChHOCY52TUAiK03RZrwU1grLacji/QMRvmzFkCFNLfOircQKoiEx+UYxixgsgcwTweRCU5KERa8gMzDkV3/e9i8kSum3G1xuU4/JUmU6/F1IH7uy6MeG1ZsMr/mDCeI0BsHS0k2It8sA9K3q4/+0kciQNWlZSSujwYJUgXLeu0hya2ANfCPWaFHwg6KYekY+SJTTxST9zvlO27jZa/bfBmMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 15:09:03 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:09:03 +0000
Date: Mon, 7 Aug 2023 17:03:21 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern
	<dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn
	<willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, "Anatoly
 Burakov" <anatoly.burakov@intel.com>, Alexander Lobakin
	<alexandr.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, "Network
 Development" <netdev@vger.kernel.org>, Simon Horman
	<simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
Message-ID: <ZNEHuaY+9LWzfZMt@lincoln>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
 <20230728173923.1318596-13-larysa.zaremba@intel.com>
 <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
 <64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch>
 <CAADnVQ+vn0=1UT5_c628ovq+LzfrNFf0MxmZn++NqeUFJ-ykQw@mail.gmail.com>
 <64c661de227c2_11bfb629493@willemb.c.googlers.com.notmuch>
 <ZMeSUrOfhq9dWz6f@lincoln>
 <CAADnVQJPgpo7J0qVTQJYYocZ=Jnw=O5GfN2=PyAQ55+WWG_DVg@mail.gmail.com>
 <64ca59bfbb1cd_294ce929467@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64ca59bfbb1cd_294ce929467@willemb.c.googlers.com.notmuch>
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH0PR11MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 970b39df-c21a-4fa3-293d-08db97583c5f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvZTD9ux/aPFm6dH2bSKOz9pwBZ4S1Mr2bk4E+CKqeZeis6zX11vnz/P2wFjBVo/zhCmhh1dCj8uCYy2qGEb5/2sWaBwrI09EhVvh8sPgb9b3Ov1vwQdLE0sPjvKH8MYCZ2ik2UDGyii+DEOmXgXVtOKIvTy/HN3zemGx1bWY29CQEjM/WeaVd+4DLmVcw7yyLf+RpZfYc1oduWyBLC8BB5G5lyKHVFd1hMz3mGWlrhaLltYWxrgiWZnsgUeywRlLXumXMUKNH7rgaoak0MJK/XUBrTIqe2lamcYBt7TiUQrTjnji0NnVGeR5CilDgIwb3l+KqNnQ7jWAAJRJdbPjSGnUUeX0pOoVzC1ojhSuHz2H7JXbpNr/ZOycRt6NWKVIr48snfixmSfJLGGCu55+7hg1Dq3EK2YqbSSKlMhhjyysyLSH/MTtOAa+5Px3RgbfZv0Lqj64/eMNSNVfef66nnzwcI0YpOf63CyC0m3hUwpn84q4R48agIWFQIVKVBwfzR81cF68pmuW8bb3sxoTNKIGYV8sqs8GcNSNi+zO5L9GZyg3e/8rxANPvT6wcyKGfRwJvEw0enw22J7cTMbkwYhF72h3uzH5KTG6z8c3fU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(39860400002)(366004)(396003)(136003)(186006)(1800799003)(451199021)(41300700001)(26005)(2906002)(44832011)(5660300002)(7416002)(8936002)(8676002)(478600001)(6916009)(86362001)(316002)(82960400001)(6506007)(38100700002)(54906003)(6486002)(33716001)(66476007)(66556008)(6666004)(66946007)(4326008)(9686003)(6512007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Emh2PrOFU0rprkjYcwoMMGfqh1+TG43DJxxY+Y1nlU3flMtF1VgMTBbq5INk?=
 =?us-ascii?Q?lABSmCNEPxtOzaz7A1ApATwsINr3szONdovmMNdh+tWhZgx3kU0d9ug7n8kI?=
 =?us-ascii?Q?96YYM69Qcw/eEoKfgO9sZHbVFmoe3DSNQ+X74YT2UEfNkCt9YNzBXsXstPsS?=
 =?us-ascii?Q?LRNb5IUJDaXhwYyyU9B0kBgVb/1IbkpGj4shJJC6iKlUGeEnPW2oE/s4+N4y?=
 =?us-ascii?Q?NdiVNO//b4Xk+mCqH51+KooimEe49UOtp7Hsq0K98DYjboteCZhDu/v6bIW2?=
 =?us-ascii?Q?GESK2VrKOypO6BUPqJHbBsqoiFkPZZJoqyBUn2JkjTDTRrZySMABBdPuA++J?=
 =?us-ascii?Q?/CvzfMYaiX+vsuz5M6R0S1yARoEd0GJmvlEr2ETkCkm05DEqFTXUIssI3y4v?=
 =?us-ascii?Q?3/Bko3OlqKBuR+A6zM3dCof5Mwwx11STlZgIokwHIkKJ4K81FLfb9m0L+Dj3?=
 =?us-ascii?Q?gFrP2ubzTTyC2R27bl8QXXu5dYOLBIPyoOlV3yxE2iYpXw7ywb9LX7WN00EN?=
 =?us-ascii?Q?6b0Y1HJQ9OSGNbVScxFKsgi1ppX/bWnD3Ukx0ATXDOhLrkz0d0YeTw5UlGVE?=
 =?us-ascii?Q?DGj2x9vdEhZIcyOHvLyZ8yJC/uA9epkbpF+pXXFIuxmaaKckSci15dohKCVs?=
 =?us-ascii?Q?T+XAb6i8680H0BaJ90TE1aP/GjWBKqKxt4eQyVJCXDSXYl9ECi6O5+zJ/UmQ?=
 =?us-ascii?Q?tMeKgpbx40X7Io6YTBggTm7nvSPKFvJpvmMSpPNPaQCl4f78uvwlcf3EfpSl?=
 =?us-ascii?Q?6Mtib7S1aYLC6lY9a3FbCnWPclU5+t7l9Li7DJilvGVc0m6siZjtTXUXNPBG?=
 =?us-ascii?Q?I9IfAhGG8Fk40Xt4Js1OyKInYur/CN2tnWqgF2U44n4xrS+WvL5sAJOnxnJV?=
 =?us-ascii?Q?qtyJQbO8RJ43Azn9EdEpEyfV4tllZJRQVBWz6S1si7qgFqrwb6U1dHDAW8C8?=
 =?us-ascii?Q?2QFyd0ML1TgZuLqkvzoxd3EODA3spLv7yro+LbC+KBpv8A1+1nrNu/9KrbDr?=
 =?us-ascii?Q?qiG/kGfPxraYpY/ci5ar9qBhOov67VDXvztQXnjQ2YBIKEZYoUHbi5pUhW4I?=
 =?us-ascii?Q?7jFgXaCZzWV5kzbND40mNeRJK7cKFRRQ7jv197zLjitauKLJcffoKmNXmmYF?=
 =?us-ascii?Q?iACLIG7CfvelxaaVL+m31AuEia2vghuRhXyny0Mk8Vzrg2AN+Og87eMCvcYC?=
 =?us-ascii?Q?QkwQ3OD3aJOXnhlQQsojuUTGWC9ft1kaL1a4yJRkUMV7DaotCEC6TPDHPrWZ?=
 =?us-ascii?Q?hMR35SdxrDBS/+YWz08xIjf1dm1Scp09kL46G+EdwOiLolYSw5iCxrXOGrWo?=
 =?us-ascii?Q?P8p45AhN+LVYXprSzzUH1rk/pBTvXkdqPeVxNisAkqtC362cgE2M5xoSVRvc?=
 =?us-ascii?Q?jAQK27PkqhmExyWlA8RnPmb1lUj3ge2aQbWUn5/6vq2aEAtF7M/eqgoANBHX?=
 =?us-ascii?Q?UrG9rIL78YA1Nf3T0VYe432uEIjhbAUx91kYIxQX47iIJCd1NzmlPbAb5uNV?=
 =?us-ascii?Q?yTMTaHBsNEhLji+pOeyXSKsLK+z97NgkiY0IJeWM/mXMRYIP4FPBHr3umEbc?=
 =?us-ascii?Q?vHqaql/a2p0tNkwQmWRL9DT+aKcBhjFDNQWWjVlCYTPG6c7RJSZvh3M+V+cc?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 970b39df-c21a-4fa3-293d-08db97583c5f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:09:03.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwARI00mBz1I4iP0SUoq8QPP683zTGyBujsp62q2U6TfSkKlGrrVgVh/f5ZJpYfkreEJdc2UO3ldDbrALqC/dAEwYBdp6LHD7vXeNtAvmVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 09:27:27AM -0400, Willem de Bruijn wrote:
> > No. What I'm saying is that XDP_CHECKSUM_UNNECESSARY should be
> > equivalent to skb's CHECKSUM_UNNECESSARY with csum_level = 0.
> > I'm well aware that some drivers are trying to be smart and put csum_level=1.
> > There is no use case for it in XDP.
> > "But our HW supports it so XDP prog should read it" is the reason NOT
> > to expose it to bpf in generic api.
> > 
> > Either we're doing per-driver kfuncs and no common infra or common kfunc
> > that covers 99% of the drivers. Which is CHECKSUM_UNNECESSARY && csum_level = 0
> > 
> > It's not acceptable to present a generic api to xdp prog with multi level
> > csum that only works on a specific HW. Next thing there will be new flags
> > and MAX_CSUM_LEVEL in XDP features.
> > Pretending to be generic while being HW specific is the worst interface.
> 
> Ok. Agreed that without it we still cover 99% of the use cases. Fine to drop.

Sorry for the late response.
Thanks everyone for the feedback, will drop the checksum level concept from the 
design.

