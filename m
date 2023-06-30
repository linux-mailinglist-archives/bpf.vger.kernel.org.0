Return-Path: <bpf+bounces-3820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6187441B4
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 20:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DF0281131
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E228174E1;
	Fri, 30 Jun 2023 18:00:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A9174C2;
	Fri, 30 Jun 2023 18:00:34 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11635AC;
	Fri, 30 Jun 2023 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688148031; x=1719684031;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=I6No3X7aTvv3/Fb2wm+XZJVawfBgr+Yux1gwoweEon8=;
  b=ANvtCDFdVhe3KvPuqG0I9YaUScdG3EE0oNnwdjOgG0cl83MU8Dd5lpDa
   /0mpASk0tdZ4C+j52aN55ZnCAQw2U3e2wcSL0Jl6H2PrrUFREj88bZNZV
   KdZpAmdz0hjielEn9ILlniXmeHa4UDS5WTN1amgZ8hpqEJUV48J+PeCkB
   8qLc8Aqz7qFs00EyjCSIUeTCwr8RwEiwwQYpCOnzKUXhrhl5gDWxht+J2
   bVQ+zLFzOZzlk+y+edMjq5QSdhd0BeD/xW4sTl0abXX64e/P0IAM47TuE
   w2nu7thaoKCcm4ny9k33u+bvzN25yK0RC/JfcTCWviqf1qdmTJ+s4r63i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="428502185"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="428502185"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 11:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="721050396"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="721050396"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2023 11:00:30 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 11:00:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 11:00:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 11:00:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgeCnQDFJsy9CF2mnqlwY1DleywoCSwzoiPNWjKdbCSuR3VWVbuFeo6R362Q5Wy9JfDjsJmz7mUpGz1LE/wfwjhBKtOiHuK6ZY4KmJCvgeOE/+kzvi++LfZeIWFwZ7p54vvcqJYlXEf9uY7ns7isE5Z28sMiV0Em2DaIpwVDTby41kRxwY0YWT2gENDfYvfu3cqoGMDiIlow+4MjedVLrjE1P0uxiRYyJ3tbd4YpJ22r6K0G0HXaCvcJyeuD6dtiNOLQP3HTQe8oY2GJnfwjzE9WBeDWgnVuI99IQLV6XoeNPWhetMPomREorNsLvmN1s73WWzpSfZr4qsTUCHOFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXefHcAoybDEbWtF4Bm8s1hopgugiM6wzY7pXJiI7pc=;
 b=J+IXGn4VffHliDOlZHJnrvfceLi5UBlFj0zHWNyODLhGzq/7/p+AUHmeho4OVyuvJPsaX7P4t1JwkkPYZRu+C3E/xdPisiFcSuDSP2OdvN5S7+ts7wpoTE4/PYuJvFMQHBUE/RT3gOwD8Ll7N8sgwi0GPzy+IfcWCUCKWqAPv0LiDs2XP5rZn3qUkXhGNxqi1hAZqrMBMugjr22YyJm6s2OJqQVI9TioKQfbfhRmn7pzzyTIXrsonbhLusY2bM/iQqRo246CnPs/Qt6VoTri6lTd3Go+JDCzQC6ElE2P74JzTvuAf5LY5d+YEYxj3n/AhpREul4w/Svm/6KVf1/eRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM6PR11MB4577.namprd11.prod.outlook.com (2603:10b6:5:2a1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Fri, 30 Jun 2023 18:00:28 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809%2]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 18:00:27 +0000
Date: Fri, 30 Jun 2023 20:00:12 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <bjorn@kernel.org>,
	<tirthendu.sarkar@intel.com>, <simon.horman@corigine.com>
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
Message-ID: <ZJ8YLASfbw97mUZf@boxer>
References: <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
 <87o7l9c58j.fsf@toke.dk>
 <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
 <20230621133424.0294f2a3@kernel.org>
 <CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
 <875y7flq8w.fsf@toke.dk>
 <ZJx9WkB/dfB5EFjE@boxer>
 <87edlvgv1t.fsf@toke.dk>
 <ZJ3pgau3icByxQxE@boxer>
 <87zg4idm1q.fsf@toke.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zg4idm1q.fsf@toke.dk>
X-ClientProxiedBy: BE1P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM6PR11MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: a4676416-994f-4d05-5763-08db7993e28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tuQhPLvrP6h5tjpu81f6B3A8HHFZVGvVKbRlzml/Qxd88MdgYipd73vz3dFkQmKsOuRy/FPQMKMcVEXk5JR9nkhCmYidf1FhvqAwkuBi/nR8DU5OB/9iztv63fqDkQjsmzqYM6gMHQk0+pJLOaXMx9quhja0yRS4QwQopsq9U6unyu7jzUUS3jD+xjGsC2QwtlawjXmXpFuOynNTCdpy1ErC7QpPniDTYnLF9eKaceHdpWSA3Ekzw/nBk9p3azV1LIAl11T7x+7yI1tecg1+e1ap8871+66l9G3CEum1xtSChwpAPZhdA5e3rP4p11Kjyfd6kUpPFABWGqXmmdHFt0UivXmPrsi1kOFonLR42WfZlumtJ0NQkR9OcYJKMlfryAgGDUCnfrqh6HAfudyWZF/4QC7VOINlcpb1WXbxl+xARWaHqHNz4jtSjoypJammGfB/fng+ID2iMOBrv+h1Zl8HookJW/o7malbtR+SuBLtFtERfAQ7nbABxlbfhWPS3mJMXr8tnhV1qfol3eAMbM8nlonLE5TCN4Qyjyr+r9pWxNSjAo2RUVQKspfAhGu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(66574015)(2906002)(33716001)(38100700002)(82960400001)(8936002)(8676002)(5660300002)(86362001)(54906003)(6512007)(41300700001)(66556008)(66476007)(6916009)(4326008)(6666004)(316002)(66946007)(6486002)(478600001)(186003)(44832011)(9686003)(6506007)(7416002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4LSkErblxM0Kmy+lR0CksaItuNYt7k1L2RCKwyXsbyIN1OWn87KL+K1kym?=
 =?iso-8859-1?Q?v8Sd86Y9HlTMVRmRq2svBFvtoXayR2IvstCPlkHEknewoxyoTOUh7JRFkx?=
 =?iso-8859-1?Q?0WsnrUdFYDeoQlRXk+oCj6OjzudyE8i6rc3DcAdxd94fbYAR4YUHyN2xwX?=
 =?iso-8859-1?Q?GsJZA58yia8M+Yi1Z6ac2/LlCUhhA/lsLCpB8zvnhqJe4H5f1Z7lkjHgSh?=
 =?iso-8859-1?Q?GiSWklmmiS5kmtLh/eXQhso5BX3aBKMiaF/AZwrlhr+Ja8dCDQuNDhZDhL?=
 =?iso-8859-1?Q?d7/wWElwMNo1uF/EwFpIWNtZh7e5Xh+Ua/+H8fwHax+qYEjr/X6fhPXQ/d?=
 =?iso-8859-1?Q?oNbkQOw2cv1RI6tlzrphxJKrIXqT3OIZbpy8kexh62gBoKd9nKv8iZX68t?=
 =?iso-8859-1?Q?8dy44xV7/F2zZ2h08j5xyyotfYjz9Jo1WR8BeH26HBWhNINZQugCAZsJIx?=
 =?iso-8859-1?Q?jSsyQYxXv27dDZBgDDysycYhjMfkRgZPZDTRKsoWlcLYFEQ+4dGLuJhjA/?=
 =?iso-8859-1?Q?oJkDdQ4yFYmXerevz1n1YK+6uxIUjEU7AAl2bSt0PLqEtK+FIpmphz0LzK?=
 =?iso-8859-1?Q?3yxhiI+UarIQ2bheHJObpS/jO4xkIvxp87slyBC3ydfErj53zzcbtYimPa?=
 =?iso-8859-1?Q?kg1ocFp0SDz/Deo9CSeqkaSh9NmWdJoEnJg8OtP6z79GLIwfpsPTvNbXqi?=
 =?iso-8859-1?Q?LN+nOlEYmPKDVEzE8WAboY1IdlU9ElvSo0Ugk+L6WKSbPGKOeQchb7DQ7I?=
 =?iso-8859-1?Q?WB2KN8FFDLe4sHu54VfwqKmIqs6Yibffl5iZHl4cbdTunrzRYDbFtIIKl2?=
 =?iso-8859-1?Q?9gV/Kf53sZJbDz8nlLabj/UrzFISFxdNHe8YfftEpaGZcudoMNa1KIZjRR?=
 =?iso-8859-1?Q?+AWYwI/g8Wbs8eDs42s9Q8ngbteTeOXIZmhNHcjZK5mdVUoFh8coGOA7zF?=
 =?iso-8859-1?Q?5sqjzkPOXkXTJj5sZ8qe7/ur7LJbJBV42bDGgji389WkLFVE+qkZK1Pq1H?=
 =?iso-8859-1?Q?bmmz2jdT7K7DimAveZEdu4ujXYgIjB8jEimlCa6YRXj6eBbxeirbl6NUl3?=
 =?iso-8859-1?Q?ah9gkQy2cnlT0Ko7PDmO8TNrt/CCU1cVEldPIVxHuV7Hj6TwTyXhux0PpB?=
 =?iso-8859-1?Q?rWFvigDlKMdvXSmcTqNDsm+fH77ttx7hQ9pMCvkVQQ/H35iAP1qVtNV8GP?=
 =?iso-8859-1?Q?ZOliJSSP1r6qHqeiR5qPPWyMjd+P8JCV7JcS/zrGR5odn+ozB+LEy9Gvzb?=
 =?iso-8859-1?Q?1nZn2bKD75qSN17GHQWRfLxmkpJzvSs0H7FDAePbOmgDhezf9Q6i4o7Z6n?=
 =?iso-8859-1?Q?9pJwmuloow/rH6uEpA+Xfqo2B6BYSJHccGhA6Thh4SUyolmGmUoeBcSk2b?=
 =?iso-8859-1?Q?9KGB6B9/WKJ9X3ewmyvUnmjBzqCvR3hIDkRuHHrf1z/ORDBQ5nN25JmxDA?=
 =?iso-8859-1?Q?R+RbxHJVQWq//hXh76IxHJqvrrf24QwkpxktB5Zdg02f4dO3a0omH+FFpi?=
 =?iso-8859-1?Q?k36qRCzjOcdDhfX4MxhDxiONZXtDgUtcegg6Cy7j05HZUYKlPPlJs0abwI?=
 =?iso-8859-1?Q?wZwLKXr51phfamkk+aVnX4//gXISP+LWFU5Uqw6+oiRdmbnf61sPQ1XmoZ?=
 =?iso-8859-1?Q?G21V5ZPO9zw4P035VmJW1LRrA/ZSujdC5nStyOO4eOwuVjZqNHN0ZcvQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4676416-994f-4d05-5763-08db7993e28d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 18:00:27.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MO6JxdTeVqwdq67gXJCLApnSOUXW4C2vGios+FuSZLgDbFmX8ClTqXhF0FRyj4Ws0cpM6xa5ieryIP+6J+jTBQjc36AhlvdmE2lARP1QJaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4577
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 10:57:05PM +0200, Toke Høiland-Jørgensen wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > On Wed, Jun 28, 2023 at 11:02:06PM +0200, Toke Høiland-Jørgensen wrote:
> >> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> >> > index a4270fafdf11..b24244f768e3 100644
> >> > --- a/net/core/netdev-genl.c
> >> > +++ b/net/core/netdev-genl.c
> >> > @@ -19,6 +19,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
> >> >  		return -EMSGSIZE;
> >> >  
> >> >  	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
> >> > +	    nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
> >> > +			netdev->xdp_zc_max_segs) ||
> >> 
> >> Should this be omitted if the driver doesn't support zero-copy at all?
> >
> > This is now set independently when allocing net_device struct, so this can
> > be read without issues. Furthermore this value should not be used to find
> > out if underlying driver supports ZC or not - let us keep using
> > xdp_features for that.
> >
> > Does it make sense?
> 
> Yes, I agree we shouldn't use this field for that. However, I am not
> sure I trust all userspace applications to get that right, so I fear
> some will end up looking at the field even when the flag is not set,
> which will lead to confused users. So why not just omit the property
> entirely when the flag is not set? :)

I think that if you would read anything different than default 1 from this
field and your driver does not zupport even ZC then your driver is wrong.
It's like reporting something via xdp_features and not supporting it. You
only overwrite this within your driver *if* you support ZC multi-buffer.

OTOH were you referring to omitting putting the u32 to netlink response at
all?

> 
> -Toke
> 

