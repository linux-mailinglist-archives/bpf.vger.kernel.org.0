Return-Path: <bpf+bounces-7174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C87728DA
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 17:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1550F281075
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6236B11182;
	Mon,  7 Aug 2023 15:14:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E3FBEB;
	Mon,  7 Aug 2023 15:14:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90E110F6;
	Mon,  7 Aug 2023 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691421271; x=1722957271;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tFRtnrwbs43QWLfH+UTnK3A5Ylp3/BHZ+uNwWsZKaEU=;
  b=LMorK6lUr0vucwpJKFcbsnNFWY/acT8b/gjP6kG51FIBSopX1bGmtNXF
   WTQZE+OjJGEQJziODQz3NEO2dcJwauMdvHVc2O/J9O5vt920AfJZcUxoe
   3aPc+ZTRYD6TBxgfqOdT31yXyVuBeHbiD60fr/3pPTfvZpLSDzmZzCkGo
   CneXGa1Ugb5wfpSAiSyvCcVF2wJ9JNi30m9bW8iSx91FrZQ3A7s/YXyyO
   60V0XmyN7CFgbJq/5JDYtEIa/NkjAsmq7DAYT05sA9d22IAAwNuzw01my
   fyKs7ruZXcauxwOdsiKkbEjFt2tdCrz3zVnRl2RXz/Iz1VS/YVErXi3Jb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434418343"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="434418343"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="854693553"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="854693553"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 07 Aug 2023 08:14:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 08:14:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 08:14:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 08:14:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 08:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8tdK5KxwjrnV3YAR1i0NpslYhKgni7WziGjQafLl91OUnzBamgdI/4k7ZdZYuicZk3QlyL+qll6kInKRG94Wa5IjN7lZA4zzkFwdgImRiINocyyzV9ZqA9b+2OzxE6vrHwc/l9NVJNiPCgNH6Yfb5P8nfiKH2KCqaMIkR6QmE8o6XXzbpZvKeGSqUpFRPfZ48fZENs3dJY2jxemYLAsa36O6M7BIyiODL0ZEcHahq4sC5sETAxdGzh9hTNvCcXwRVO0mZDGzCpNiFKFq4s4fBaNVrjxNpLeaqocmrJM3vMH7s3D9UaJ5/ENzaaCtW5CHszpIF9s5E2HY+IErBOoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCMbs3mkMcS8l3A1NQGJNRWVB8C+EExM0HUiY3eGFUk=;
 b=huRZsRU0S7iB0hHUGRpItIJYRkF+o9TMr/HrdsZpIpTzyTZUG0T2a8IHgECd+tKPSCS/s89lNTr9eOOka3JQWNhxlwtHk9eNGAjQow4ES0UaTTvEQG5tUH1QKNob8qQNqftfAFr9iRUvK5gX9VtObDBa939cHvqs9juAN1Qmdfk3ipuEAmNk8mzzoa3P16ztc4okIuTiKhJOBaghZwYnOS4OEzlWf1wvGRNX3liztHSifTynSBzYcPZjj8JeKImOAKD0sh/2yRwlVSLTIeonKSTb7psw7wl8YYbgfLWpYvNgROJoXmgsg/5hD6gQhhNnJpftrHXryQbb+veHDcuZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 15:14:19 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:14:19 +0000
Date: Mon, 7 Aug 2023 17:08:36 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Ahern <dsahern@gmail.com>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, Network Development
	<netdev@vger.kernel.org>, Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
Message-ID: <ZNEI9IqMOfH+smbo@lincoln>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
 <20230728173923.1318596-13-larysa.zaremba@intel.com>
 <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
 <64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch>
 <CAADnVQ+vn0=1UT5_c628ovq+LzfrNFf0MxmZn++NqeUFJ-ykQw@mail.gmail.com>
 <64c661de227c2_11bfb629493@willemb.c.googlers.com.notmuch>
 <20230731094322.0edd5c6b@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731094322.0edd5c6b@kernel.org>
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f906b4-8d7e-4a12-99bb-08db9758f8ec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGW7FJbxqA6LHjhkb46KqVoxbWHqH5VWWM2amxQmzv/IlGaGD/uIDzv9otkOBYNv0bshQ/vbPcAnHVKcSx/FOX/pYVkzYOn1Ops1SfxyllX2L22li8nOZECdeIPqXcISxTMgyQZEhnASn978xL2ccIoZw9dtpkKYUAIaV+d6b6Js/LYpKfHyGiAuAqLPeMpKjcoKZkPAds6Y7Q0Z5156uLHKtedJyc/pMRH+MFSmUolrGmPQZ+ye5y4EhUzTvl4oGRVUsiw/k/C0ep16XcwbSIirq2lCziP7m7IOEdo09iMauJLGdR7/zuk0glshuTu7UZ1c4loLxKRic/L2dq4Ww3HeGZZ0jPf8+I6lzM8THStMwI7Amyq3fZKQRK8Z5r0yb/U/M4/Ol5NJV3HmuWCJ0v8U45P/dTGVvh3XcZ9w9Ukq44/g9L8CA+8vulG36lpIDGv56txv/du1pKupxfhUkwFUYOEvCGFz8LauBDQza3G0y8nmbfXZqceW0+2eHli27dOtKr6pCaE7FRwwj0XhDG4sMTzGlwUIlNsAS0DNbA0qBPKRXcxTg7miTxIlz5ii4JxZiaN128ot7LeGSHc+mGYwzZp4h5IyIwRKYBoAhL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(39860400002)(366004)(346002)(376002)(1800799003)(186006)(451199021)(38100700002)(5660300002)(82960400001)(7416002)(2906002)(44832011)(4326008)(9686003)(6512007)(33716001)(86362001)(6916009)(66476007)(66946007)(41300700001)(8676002)(8936002)(66556008)(83380400001)(316002)(6486002)(54906003)(26005)(6506007)(6666004)(478600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oWKE08vyM8X5IF81tJQltDhAmCeRCk5nSaNxtj2hkIfLJdgUeBGTWT6MUQ80?=
 =?us-ascii?Q?8Qbozx9bkjn0tfq0sDNkorCqTXIfBJQ9s/K7BqbMba0auUfcQ9gsqnAYAPVF?=
 =?us-ascii?Q?HT26HEku0DBa8Akt+m3Vbo1rROG64StFOTHROcvkkRyXtCtuUf3TVH3Rzf0e?=
 =?us-ascii?Q?kxLQNf6KPTE6mB/E07YqkZ1hOx7/unrXrCJ7JFhD8xxQpE00RUE0OA6aC/Uw?=
 =?us-ascii?Q?+b8mirbbu4CRz6iNInKtN41TOM2zUWjBsLcztereyxOJHkU0trhCeZ/wwI63?=
 =?us-ascii?Q?iLgVolRvC++84tBtpFS8vjxBc7JozXeHEjMSWlpCiBYr5OoOD3gtGRSkcpwZ?=
 =?us-ascii?Q?0fWfrEax/nj15NU8gI8gLRmCEsiPd6hKx9UY+WjOMcVjQaH4uBHp1JNORczq?=
 =?us-ascii?Q?sDROnzSAdhfxbuqhD7TqCmvQ3hagHLfNCzBilVxpznVvevCnh85OqLHLUrsU?=
 =?us-ascii?Q?VIEFpwPoG8qnZnak9H0lnbeaUq1EXbt7iwNKyuULZYoHWQbInfpvf3GGrYb6?=
 =?us-ascii?Q?H/wc8pAnuTiHbs4vpUVMSwjSemDg3VaWPX36FXd2qQgrez5BkY9l68ujPOfx?=
 =?us-ascii?Q?FHmHmz+5ZFV8diAhvsjgQIQBzc6Zzuei1gF92VjF8h7+sLpfhgUegx6hWHgB?=
 =?us-ascii?Q?OcB6+z9v8Gg6rszPNSX20htRe1CeSUhqxU0UWUdvFGm8v8Av10kRpn2Oq2EJ?=
 =?us-ascii?Q?csEfgjp8sRO5KQtK0cGOiL99UYA0mUgsxK/36OHcX/s5mjJwL89LvFdpjBFu?=
 =?us-ascii?Q?+0mDPr8zqx3IAYhA2ACDXyMYrDc2N5tUp3lZ81wVHA+zQKhhWaIFnyrL40lA?=
 =?us-ascii?Q?d66ceAtfzmGuQED0VRZAlkp7AmcFq+tp6tNM7+juGJog5xq0nLMjiTjremPY?=
 =?us-ascii?Q?8nHVn3ixvAblWmSN8Uj4/Lk0omtM3baibuZ0aM8iBW0SInEiFraXB3EcwQyK?=
 =?us-ascii?Q?8LwH7082mUUZ1IAWBknI4EYNl5LJ1SDp7kvotuAb6h0Rsh/gbx2GLIOpF9tn?=
 =?us-ascii?Q?bN3uQMUAsDJyI86OqPQE7qFecAFg3VYf0q4EUImMytVLkTFaR4+ty21EZOtF?=
 =?us-ascii?Q?08gG13GX9jw671oMQaFGV6LGRRoc05qWSHkX/PXTKs0AVmvj6m7t1X0gLqMr?=
 =?us-ascii?Q?UA3PWRKNMYpFMRNFFV+0no+vPC8+E6Mj2Ea/bCYWIAax16QhfVrIH1RbMqUa?=
 =?us-ascii?Q?Oo+Mg2Dc/iPGyqYZ+ldr7ROQsR81bEcJGaTVH+M3NznEeujP4/mnPX9mQB72?=
 =?us-ascii?Q?cfiUsUgRrju8BO8oUvfVJK/Dn9qObonsci0J36qeUx0RA+8Spfu1GdbymV+X?=
 =?us-ascii?Q?JBY0z34Nu/LL6LhUYjC5bt3iuCv9qRQ+rPSARB5Eca0y95I19eYSyO6zbgNh?=
 =?us-ascii?Q?Gx9TqDhNVJXSKzE1Sk0kTPPmwTqyHBwIPyQ6a/Jx04Ae0DkcmrQgUhrVZPsk?=
 =?us-ascii?Q?yDbe49Cl9yVPd3iAd0ksiIX3eE3f5o5hpvl95lPvFe9u1QZ7m6G0HUNv5owd?=
 =?us-ascii?Q?bdSweSwKDhTvBOj0hA+bVzAxX7e/9zLEXBRLp6pvxeRz/e+xNd0SBtzUpj66?=
 =?us-ascii?Q?F5MAUo+MGe2CVDCJMf9K5//dG2C9Dyzz4GjdIftQtRMeGJyFZf3q8AL1Cn2c?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f906b4-8d7e-4a12-99bb-08db9758f8ec
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:14:19.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nq+/s3BRkq3VM73LZDx1XQMzPzEtCL40l3khcTqXUvNjxDmIFd7vhNjrI99SWQAs4TFJVZmhC27vXxOCcIj4bz2gYNLdTmp/jg3hzdDLCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 09:43:22AM -0700, Jakub Kicinski wrote:
> On Sun, 30 Jul 2023 09:13:02 -0400 Willem de Bruijn wrote:
> > > > This levels business is an unfortunate side effect of
> > > > CHECKSUM_UNNECESSARY. For a packet with multiple checksum fields, what
> > > > does the boolean actually mean? With these levels, at least that is
> > > > well defined: the first N checksum fields.  
> > >
> > > If I understand this correctly this is intel specific feature that
> > > other NICs don't have. skb layer also doesn't have such concept.
> > > The driver should say CHECKSUM_UNNECESSARY when it's sure
> > > or don't pretend that it checks the checksum and just say NONE.  
> > 
> > I did not know how much this was used, but quick grep for non constant
> > csum_level shows devices from at least six vendors.
> 
> I thought it was a legacy thing from early VxLAN days.
> We used to leave outer UDP csum as 0 before LCO, and therefore couldn't
> convert outer to COMPLETE, so inner could not be offloaded/validated.
> Should not be all that relevant today.

Sorry for the delayed response.
Thanks a lot for this feedback, it became a gateway to deepen my understanding 
of checksumming in kernel pretty significantly.

