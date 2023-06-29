Return-Path: <bpf+bounces-3751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B298F742E4B
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 22:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FBB280F10
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1348156CF;
	Thu, 29 Jun 2023 20:29:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F51154A2;
	Thu, 29 Jun 2023 20:29:02 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94F23586;
	Thu, 29 Jun 2023 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688070540; x=1719606540;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UaVVq/WZg8NRO4SM/t/ef1eY76pjlk2/QE0uf2TFNNc=;
  b=TZk4Fy5r8YJdFEWlQrrUsKx30q/P/83bkszzRxAkLq0BfLYlZgIa/lYd
   ZHZLTU1E+rkNJ3ED40QazAPGslEfUwz6QKmlvaTb60Zmd6/1tZxLfmABo
   66IclcDG4H/eroPm15t6k5c4C/gMqeCLAl/ULI/b+RazaWZMV2jswsfQM
   tGpvF24Mh8UURZq4HFvGBEzyzZ51LVGM6cMe3oTPmjH+fhIpZ7ZbP5iLb
   XNdA3MpKeVvwItVfkhXNk6ni+AnGuQLHjhgDcaBU4latUIlKY/zcsiDED
   Xt+SG8C3Ix6rh1qdOhbSVd6EfkpNeDg+ghSRSLbVPl/Djg75Lh2IADFtQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="425909504"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="425909504"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 13:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="1047953241"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="1047953241"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2023 13:28:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 13:28:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 13:28:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 13:28:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyqM9+EwniPoN3bwzYY8OprPRMtR7+hEKxd+iLgSdGn0Q77CzdvOXOHvsRegQ08zWtvxQP1C0pjG5j+LxwC3r8shnJxLVuxY9YD1eg58P344TFBlCjI4l0lNNBc1a0XRtaEm+/T3uJvAFtvyCm/7s3WH+1bAVpKWrUX7LcZXIegUFsyRxPsvquXCuJPvLZbwha6diLOwb0HFYQBl0YW1UZ0dNBFQlWyPim+OpBMYMNq7qmthvVAeqSax90ghGQ9mzebKDDTW8v/sjRpJ/vQWZ1IcYEXOFnPNYcgYlkDBmTMQBPPw1smdg2aRGzc18s4oSNyBI63aHYDGb/JzO2VpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B22GVZIfkZe43MHdxHT6FpUBYd+HcQH5aj3occCZk+I=;
 b=kcK5OH5YeEbxF/QUEQaK3nqellTgCemIdFb+5daEhB1PoqkikbamdxueknY7aQdMvMKFLG8pguZy0u/HYj245sTaPOOwT/2H0GMKSV4L04krsFh2/SNW/LJdJ3jm/QIcjTi2THKx3OQPePHMsOC2y5K9PaFRWlxVKwwum0sud8F4wHxEP57Ztj+hQcyCJVX5A4YqAhh+2UonHFJoXtZR2hFhQIIQFz/zevWlnUdf1Be67V8jAU2cfam40r+8Nb2hRfY3vnLMACREf7GyUEPIyJFuh8dw7OvHu/nLRs5DvNK3b4ZgAIb6W0liHNJR8DHbXINDDAhBmOgpn8rz1KSIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Thu, 29 Jun 2023 20:28:56 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809%2]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 20:28:56 +0000
Date: Thu, 29 Jun 2023 22:28:49 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <bjorn@kernel.org>,
	<tirthendu.sarkar@intel.com>, <simon.horman@corigine.com>
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
Message-ID: <ZJ3pgau3icByxQxE@boxer>
References: <20230615172606.349557-16-maciej.fijalkowski@intel.com>
 <87zg4uca21.fsf@toke.dk>
 <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
 <87o7l9c58j.fsf@toke.dk>
 <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
 <20230621133424.0294f2a3@kernel.org>
 <CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
 <875y7flq8w.fsf@toke.dk>
 <ZJx9WkB/dfB5EFjE@boxer>
 <87edlvgv1t.fsf@toke.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edlvgv1t.fsf@toke.dk>
X-ClientProxiedBy: FR2P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 442e2d92-63be-46ad-8a20-08db78df75f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kS0U8JnIv5euvKheyje8c66pC1V3h3j4x+1QY9o/Dhl2AKbwotT3WMF9xt+b2G1qW+dseKXTqOe3uPBEYazm2Oz5memd2W9wIZ9Ya4oOzbo3Ajtx3zIunqWnf+T0IgSOOAVlKw/WVVIvK/zQ8gdIn87L2aAwAMPFcFuqisR5So0urDPlOyEMhsbRw0ndb0sOKRh5WtIsYiAZqRKaZffEed27v1NWsbA6EV8AwV2/HfDlX9C/2+MKPck9NFzOla3jqxkQAe5OUZC1xYLCcOX3ewsOActYkledKWamDW1KpHTYbRTt2M6kGhhLbXdpMfmLRIWitQj/hj2Xj2v6Gzci96lGZcAk06d/odXbvN6oHIYoAsput1vVZtv2qFgS6e3TA98X+EWvH3RWHx4fj9G3e7NR0WWgAFhl1lcmuXY7f58uX4fZLPcCBerBbfK+j9PNkgMUhK35MB73GxE0xeqdAwV5NBi4XokyfBJcav4erjyLXAfTWqpgGg4H1rG0UNgpm5FGClBC36TlARDlQbyCe2xCWbpuvPsDqbLImJMBX1a/oHkRk8xWn2c6l320rDEV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(39850400004)(376002)(366004)(136003)(451199021)(44832011)(7416002)(5660300002)(66946007)(66556008)(4326008)(66476007)(6916009)(478600001)(316002)(8936002)(8676002)(2906002)(6512007)(6666004)(66574015)(54906003)(41300700001)(6486002)(186003)(33716001)(6506007)(26005)(4744005)(9686003)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wrhh809u8Z6zvJcr3rWIKryxQXRxG4cedKEm1phHKtQSpJZkfJ4AYSEfy/?=
 =?iso-8859-1?Q?KHJvq3Hiq6wsJlw+hIp7rMng44m4d9eiFHlQgzI15Gab6H4F3cYXRnTmsB?=
 =?iso-8859-1?Q?3SootMfS5dedrJLaui+kVQM4S6cBOaV4p9WedR8eBRjxTAfk8Gmazq8EW6?=
 =?iso-8859-1?Q?KCPPIETmLtIAqeT5PUs/mNt24kD5dRH4GLz/VO4VBYhwgiBfn1qqajiyWv?=
 =?iso-8859-1?Q?+DsHH9s176K2S7vNp+Cx5EvhWXwXAB5WOsXgyX9dBogQGsflqXTreC4U9K?=
 =?iso-8859-1?Q?ETWnAP6EyewTk9lRsIRwMvYwir3buo8JJK+VCdYoToP6sBOo8waGv9yfL3?=
 =?iso-8859-1?Q?Rc916oKia2gO8B2dy3xHYjzkgD0uVMweiFtKAm5jo3teKajV5EJSEMmU1c?=
 =?iso-8859-1?Q?HduxM6jTKfzjzz5ToAcbK9md+rpAODk3IYLYQSvR/4KmcthUGmyeLK0wla?=
 =?iso-8859-1?Q?MKU4hwoIumH2j6NFIFuoUxzgYF1PStAOGj4EqWPQiCk+OcA5036Oxch5hH?=
 =?iso-8859-1?Q?4uAHsF4Kv5uHljx/VfHVpy1eGBDCLAdpB79YlHppVAHm0nvgvrC8+/CmbJ?=
 =?iso-8859-1?Q?3Qsd+98cbfYMoF05H26qQ+fjmP1QrcUWoNxYdK/6CHwkdVdS6gU5Z0/k+6?=
 =?iso-8859-1?Q?cR7XRmA+ZnJ/ShZ3y+OXkNpxXEqjWXOWO5g+yvKWpxje1vhl9g55bQn26k?=
 =?iso-8859-1?Q?46UCXIiBegiJp6c++vE60nn8HD/du8qfdmhiZjF34zMhK2n2LQEK1dVdkU?=
 =?iso-8859-1?Q?f9N9cy/jzK++lPUc2OABahN+t8jmxw4F3UkdwZQvma589CpEWnMbCebV1B?=
 =?iso-8859-1?Q?P+4N59oH8u/gFShAlx23W42zdOlIXxfbrerYo3Ry/wCxDGggpqKrzio7gr?=
 =?iso-8859-1?Q?nBhxrPXjFEILNaxTG8iheCdEy6WDHo7RK8p7gIzrRT7+VzOzQqu0UP5cGX?=
 =?iso-8859-1?Q?9BdQgMMU8uWzDrdoBiO0jLUoqlw2JswUJg/FJD5smIDQBy1acG7+zeAJoA?=
 =?iso-8859-1?Q?EwyjdclE1QA9XRRGKJtH70OqmSTmq4WjeRp+3QROuMVXErQUDMq13ZIEyv?=
 =?iso-8859-1?Q?79YycIabytCG6o3fn/jFdXQRzXjW2pFW69Fdwdp+sDFAqZxM3gA5/yf88n?=
 =?iso-8859-1?Q?fX5U04NOQPLD40c0TIkF2tSInMauuNFNKho8W4CsGKHCvUnnuFDmDfb7bP?=
 =?iso-8859-1?Q?2xYj9ZS9F2bzab5d23iuCCJ7r3s/EJ+Zgvpc3F0mvElEzSMR35Yo+dwEka?=
 =?iso-8859-1?Q?uJY19cXnVFeu9/5zF9SMrgGu0kAMURQobU6Tj5sjumGRyOaByeUh4AQ7Zl?=
 =?iso-8859-1?Q?Nib3PaICDiVN5XS7YVOr1iYHOiWRLUtl2lPla6OglWMXrOINZ39XtUcSem?=
 =?iso-8859-1?Q?5eSfRko7u1TpniWh7BWHc78ijb8SE3J4VE7Mt0U3zHytTF/RBU88yd012y?=
 =?iso-8859-1?Q?ZG+kJwCiwdkGzoalngjp02yeGrwtfS/0agGh76dZf7cL5bZNMBT0zNh0yk?=
 =?iso-8859-1?Q?PyL76eR3ww8H0pe0Hux2zERktwY9LhZu1tnSubJq1Wn6F13v1cq8bYL5s1?=
 =?iso-8859-1?Q?Yg2AK8mKwmghLLsuGBlMMJlAdDvKlZ7Wy7by54+X2jjX0dbI5AzOtG7qv0?=
 =?iso-8859-1?Q?Ahnl2ZyH1oQbiFGojMkHf/94vhXsbhkDpNtODS9wyv+X+6RFPS0izZzQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 442e2d92-63be-46ad-8a20-08db78df75f2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 20:28:55.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbsbX1l0GDrJ7MtIuVcNiOT7kzQJhxJnSnZ/hUWWGJs4LKIqlIfV+2VWiW+gBdy1uC3V7D24kG0yWLDLCdPiYM2RKLHBRmt8q9gIui4llMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 11:02:06PM +0200, Toke Høiland-Jørgensen wrote:
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index a4270fafdf11..b24244f768e3 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -19,6 +19,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
> >  		return -EMSGSIZE;
> >  
> >  	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
> > +	    nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
> > +			netdev->xdp_zc_max_segs) ||
> 
> Should this be omitted if the driver doesn't support zero-copy at all?

This is now set independently when allocing net_device struct, so this can
be read without issues. Furthermore this value should not be used to find
out if underlying driver supports ZC or not - let us keep using
xdp_features for that.

Does it make sense?

> 
> -Toke
> 
> 

