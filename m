Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0581741817
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 20:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjF1Sf3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 14:35:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:28567 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbjF1Sf2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jun 2023 14:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687977328; x=1719513328;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4r2hczfcbmpjizKtEXfytPPuruHOKdIKKp92EK6Sy+k=;
  b=JZcsrO97/++9gLe4HzhgEn1wWPvTYyj1asxlG5V/X7uoArrMEMDeq5kR
   0xOXPGiAAQ/pVvSlckviHue+EjaDidX+zafW+tuKg3bnkgxyBZnVFwu60
   QluR3a47mM+WRQBzxyyR1HS8Uo3soDWz6445NkqvevA4MtAdR5nogWQm9
   1qydsJPGTBCYNbE5ydIrLR8y0LV0N6zC1sfZRgOJpM74TMOgsjJS1JNDM
   1oVuxiVKzBOwD1ALluPqZOUaXDNf9pzqCu0qZlVXSoRbf8JXlLcUqmAsW
   QHSqivHeif8HrsgvJK1rs3WfoGPlGqxeuNOdO6RZ6eZmaOyKkDcFilQ6R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="427939904"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="427939904"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 11:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="891136701"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="891136701"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2023 11:35:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 11:35:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 11:35:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 11:35:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 11:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agob0GUG2SjaGK01YwawuXGBTYRT0SNNgqsmTKo3eXtrq6Ki/bLaJDkRAIn3lJ3sqrMNZ7fJ7oxgitzlENFwxgXMIdxhKAtAJSI19h9hvjQsQSUJQhmg1ukiHnEpQRS5daoo2det10H+cXCvX4ZSZAFk+GuICPB+AkPVdtktdhMUZQUgvOL+Xl63g030m1NILQxCtsOzcVrWH09a69FpPN4t8VJd51Y4br5hIMEvhkxu+1SODHyQWnZ8h5Sy0Dm6SJF6wKGl7dpnIa5ho5VwbzG2gJHA4MLqnIyPwDEtmFCBFtRo/2LMyEhsQvGM2JKubfEwTWTbnGiVZqsQRwbUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWRZHGwkxv2Vy45f/MNJLu9Ynd23EWaRFcHTUlf4J/E=;
 b=TVOdubfhLH146PrkGmjxNFpfJSYyesQB2vlNkM3dlUzK59nL6VihhS6ettapTL7qnK4rwhwFEZPnTpM7BYJxZ1LXGMuC6P1rguuxzqn5Z7Na8ldp3KwU97qH6lSdiwpTs16KiJ9qZGbjwJXN88Svrlc2zkH2KIydi8QONkovAoMUM7VQqwefA4Ii4Rls9ZhUnpPLEuI2ynwngWeXgbGbpzQ0//cVZxHBGef10aokyhxVy6UHo97vK90bzE7q+cN6Hw2PCCp6ziS/5TXvCqkapw+kkPWmWWh3vdnSoILUj4utEY/sV1TPDEXqZ30gpYYcwnRxVLMzF/KeElVwprDaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ2PR11MB8588.namprd11.prod.outlook.com (2603:10b6:a03:56c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 18:35:19 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809%2]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:35:19 +0000
Date:   Wed, 28 Jun 2023 20:35:06 +0200
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
CC:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
        <bjorn@kernel.org>, <tirthendu.sarkar@intel.com>,
        <simon.horman@corigine.com>
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
Message-ID: <ZJx9WkB/dfB5EFjE@boxer>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-16-maciej.fijalkowski@intel.com>
 <87zg4uca21.fsf@toke.dk>
 <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
 <87o7l9c58j.fsf@toke.dk>
 <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
 <20230621133424.0294f2a3@kernel.org>
 <CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
 <875y7flq8w.fsf@toke.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875y7flq8w.fsf@toke.dk>
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ2PR11MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b760d5-7695-4eec-0665-08db78066c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxefesH6CAlsb/VLo5E9cn4Z0bC18Twb1e7ER7l9eWelHPL3Akn8KPoldC04VO9eq+1bAarIIzwZcsKEEdrXMbO3wCS56oSH8BJDdDBfPiwE1TSjadT1tLY90u88UJTVSOpfWXgE8ionxbh65HGSFtHQgRINZ9lQs43mZbQ7KBa3Y9qFF+MEk7AbVZxeVQyg4flSJi1cx6/CI3jMzuyRao21JcUmeiEVAeJkVMvzOf59O/zAt+BS3SDrJx3f7iLR7rKibL2cwLBRQu2dbnwxvSGZXPo/dS5lu6jA7IyRvpHNBv55zWgipSNNV8ZbNY1ClXmc+OX/eKnzi2kI/EIk53GZ1LhqESLiXAV9epjPLbB94LaQZY/4ZQhtnAmJvAhhd0TS7ndia6Vw1GHs0RTs4WHCZPeoczuvakNgioGRJ9LyTZQZyXohqgi0RFd/hnSXINkpBOIIJTMuV7/TU/OdV2+khseJ5i7Gh+VpVs1oYbvFsQKoqf/boTLa1XD7A31B8KPGyONt1PK4MIkBKK+6bsNfazZhpHiAJMFjvzBp89tEaqozxtMnrDNYS+QlnDlp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(66574015)(33716001)(6486002)(9686003)(38100700002)(26005)(82960400001)(6506007)(6512007)(6666004)(186003)(41300700001)(86362001)(54906003)(2906002)(478600001)(4326008)(66476007)(6916009)(66946007)(316002)(66556008)(44832011)(8936002)(7416002)(5660300002)(8676002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BXM4Htf/VfMflYrb3FRSnp+1e/H10M/t3Q/SMBsuaJ0aFF4N89U1Y0VPUS?=
 =?iso-8859-1?Q?mu/2TVolr1I/I6ATZSpNKiVqsCe2fnxPek1SUeOwCUm2+wdozO4luNEO8a?=
 =?iso-8859-1?Q?oh64311KE+FYxmV9oMcQaV5xsHNNlRcpbTMgHq7HvcSVRUT+8SQO7BWntQ?=
 =?iso-8859-1?Q?iOCu+5CrMZ61Td2F/Nibv9O55Tmamkt+lWyE5OvUN8nTcavYP3h8Zj1t89?=
 =?iso-8859-1?Q?vECKYJiZI4Oeq8THpt2/wlyS+K5D6j9tTNQKCZd9VvZbcUKquDfnE2exgI?=
 =?iso-8859-1?Q?LZnXxM+jwjAwlUa/chi4KWPDrTSag+ZRVvuSF7gQ7wQjrMSYMnnssxSXSJ?=
 =?iso-8859-1?Q?+za03ogcnH8RoLm8AlP7+NbemtR3qsaCW8/+mLTAen0Gsuk+xBUJLy+Sub?=
 =?iso-8859-1?Q?UkGoNRdk7MzmkTn4c9xZPcEBLWaeOcfGZB7RBV2X/KFMYj7Zn8VOSD/xOq?=
 =?iso-8859-1?Q?IZT2ghVr1FMDB4UYQtGRF2vi/dpltwNucFjfRs1dBwLREDWU64LXmHq3XS?=
 =?iso-8859-1?Q?5ost9DiZFdx+ClnWPRLDFawh68vDdq5FlMYoumiMCQXolDgzKbcbtXHGS+?=
 =?iso-8859-1?Q?GgZnucCiy/fS3EZPFivKqwNGubd1lsUuN1UGALsFEdnCRQFUk99APvUoMe?=
 =?iso-8859-1?Q?u19nkHm/Y9Piw/1dSaB3NQcLWKCq3Boe8sy6Rkd3813sDQl8D94UtB01yl?=
 =?iso-8859-1?Q?Z6mGTD493M8Mu0IZlOCSU6gNIKWxo/PIIx4RxeEvbpVGnzryt+nSAT1pvV?=
 =?iso-8859-1?Q?Ea5kgTq6hFcE0wzl6/ETszwmeW3OH5ONUpWwRUcVN6WA133lvfFn7xY3k7?=
 =?iso-8859-1?Q?SvqM9+KkV6L5wo5KctkeryNkC+MgvfwArrug5nzXKaKHy36IVdpoUJYuMn?=
 =?iso-8859-1?Q?eUTIyE3PctRdXRzJUwDgmbTCnSpcv37sfA6Z/oKrnoQ4i8B/i2C50ECz9L?=
 =?iso-8859-1?Q?/gASEDpI28nUaSYba8GO0/TdDdeKXTATdEGVTradNQXurvdVgpWcKXvkao?=
 =?iso-8859-1?Q?yhnFp1ETKO+NZs0nGpDI7aEbuslfcdYvXN1+uhrk3W4rXea3ygGpg3UzOb?=
 =?iso-8859-1?Q?uCqLm/39fsvLtHtqFeGhOdHLqLgvlUDc+DFhQG8rjYYF3iKFN3/RV9M2L2?=
 =?iso-8859-1?Q?93QZUEwqHjJJVY2/XbvQ2RJR1f0Bmo2hHBpVUoipowwy+I/LWabHj2Ky1w?=
 =?iso-8859-1?Q?xgm0s9+knoe70KvG73oEeP8XUpsISKLIt1svSbqpdd9m/SjSLls/hqxzjB?=
 =?iso-8859-1?Q?PJ28V4/G2NmX7K2N64ry9bHxDufL8EmbPK6StovRP3MU1sdeMqHaTl/FaR?=
 =?iso-8859-1?Q?Ir4h3f2eABcCLGWEE2KrZZlQ0y2QzsHGVpTCoV0FKpLncRzD2RwSGkBe4c?=
 =?iso-8859-1?Q?saXRPW22CqweZdd/LcALwDFq6+G+U1jqHWc5/yJqnrHNcNBDoluugTdcVY?=
 =?iso-8859-1?Q?QWZtSmBtx8iZbAI+hDKNl2f40WfshY+7at6SVBTOHl79mzLH1LJhpTYKFO?=
 =?iso-8859-1?Q?p0UeZYr8ypy0eiGLHtjTVF0fD4ygu6zYERfkWMN+Ie5Pk0a/TMnLPEnR94?=
 =?iso-8859-1?Q?HQRi+p+z6RBkkys87QcAb+IHT6dY3l9c/BhNRxPyv26LssnYkyuLNDnO71?=
 =?iso-8859-1?Q?KApuoLsDUc7oTWjCp2GLueTBZKSKsDNhsI6t8as71SBN005s8mGfwDiA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b760d5-7695-4eec-0665-08db78066c97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:35:19.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mcg9dCIng6g4ym42Tvdr9PxACQIYMUH9NVGxY1ilUJg9TDzqDFEGlTWXJLk+SmtmHJSKZlJLBAnSeGIXd0sgoJY4ThJv726hjsIIWeA0XWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8588
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 22, 2023 at 12:56:31PM +0200, Toke Høiland-Jørgensen wrote:
> Magnus Karlsson <magnus.karlsson@gmail.com> writes:
> 
> > On Wed, 21 Jun 2023 at 22:34, Jakub Kicinski <kuba@kernel.org> wrote:
> >>
> >> On Wed, 21 Jun 2023 16:15:32 +0200 Magnus Karlsson wrote:
> >> > > Hmm, okay, that sounds pretty tedious :P
> >> >
> >> > Indeed if you had to do it manually ;-). Do not think this max is
> >> > important though, see next answer.
> >>
> >> Can't we add max segs to Lorenzo's XDP info?
> >> include/uapi/linux/netdev.h
> >
> > That should be straight forward. I am just reluctant to add a user
> > interface that might not be necessary.
> 
> Yeah, that was why I was asking what the expectations were before
> suggesting adding this to the feature bits :)
> 
> However, given that the answer seems to be "it varies"...
> 
> > Maciej, how about changing your patch #13 so that we do not add a flag
> > for zc_mb supported or not, but instead we add a flag that gives the
> > user the max number of frags supported in zc mode? A 1 returned would
> > mean that max 1 frag is supported, i.e. mb is not supported. Any
> > number >1 would mean that mb is supported in zc mode for this device
> > and the returned number is the max number of frags supported. This way
> > we would not have to add one more user interface solely for getting
> > the max number of frags supported. What do you think?
> 
> ...I think it's a good idea to add the field, and this sounds like a
> reasonable way of dealing with it (although it may need a bit more
> plumbing on the netlink side?)

Okay, here's what I came up with, PTAL, it's on top of the current set but
that should not matter a lot, you'll get the idea of it. I think it's
better to post a diff here and if you guys find it alright then I'll
include this in v5.


diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index ba69c3196980..e41015310a6e 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -42,11 +42,6 @@ definitions:
         doc:
           This feature informs if netdev implements non-linear XDP buffer
           support in ndo_xdp_xmit callback.
-      -
-        name: zc-sg
-        doc:
-          This feature informs if netdev implements non-linear XDP buffer
-          support in zero-copy mode.
 
 attribute-sets:
   -
@@ -67,6 +62,12 @@ attribute-sets:
         type: u64
         enum: xdp-act
         enum-as-flags: true
+      -
+        name: xdp_zc_max_segs
+        doc: max fragment count supported by ZC driver
+        type: u32
+        checks:
+          min: 1
 
 operations:
   list:
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cd562856f23a..f3283e16fae5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3377,7 +3377,8 @@ static void ice_set_ops(struct ice_vsi *vsi)
 
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
-			       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_ZC_SG;
+			       NETDEV_XDP_ACT_RX_SG;
+	netdev->xdp_zc_max_segs = ICE_MAX_BUF_TXD;
 }
 
 /**
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 08fbd4622ccf..3078a0879309 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2247,6 +2247,7 @@ struct net_device {
 #define GRO_MAX_SIZE		(8 * 65535u)
 	unsigned int		gro_max_size;
 	unsigned int		gro_ipv4_max_size;
+	unsigned int		xdp_zc_max_segs;
 	rx_handler_func_t __rcu	*rx_handler;
 	void __rcu		*rx_handler_data;
 
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 1f0bf76dade6..bf71698a1e82 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -24,8 +24,6 @@
  *   XDP buffer support in the driver napi callback.
  * @NETDEV_XDP_ACT_NDO_XMIT_SG: This feature informs if netdev implements
  *   non-linear XDP buffer support in ndo_xdp_xmit callback.
- * @NETDEV_XDP_ACT_ZC_SG: This feature informs if netdev implements non-linear
- *   XDP buffer support in zero-copy mode.
  */
 enum netdev_xdp_act {
 	NETDEV_XDP_ACT_BASIC = 1,
@@ -35,15 +33,15 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_HW_OFFLOAD = 16,
 	NETDEV_XDP_ACT_RX_SG = 32,
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
-	NETDEV_XDP_ACT_ZC_SG = 128,
 
-	NETDEV_XDP_ACT_MASK = 255,
+	NETDEV_XDP_ACT_MASK = 127,
 };
 
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
 	NETDEV_A_DEV_XDP_FEATURES,
+	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
 
 	__NETDEV_A_DEV_MAX,
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
diff --git a/net/core/dev.c b/net/core/dev.c
index 3393c2f3dbe8..ef46e0c622e7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10652,6 +10652,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev_net_set(dev, &init_net);
 
 	dev->gso_max_size = GSO_LEGACY_MAX_SIZE;
+	dev->xdp_zc_max_segs = 1;
 	dev->gso_max_segs = GSO_MAX_SEGS;
 	dev->gro_max_size = GRO_LEGACY_MAX_SIZE;
 	dev->gso_ipv4_max_size = GSO_LEGACY_MAX_SIZE;
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a4270fafdf11..b24244f768e3 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -19,6 +19,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
 		return -EMSGSIZE;
 
 	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
+	    nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
+			netdev->xdp_zc_max_segs) ||
 	    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XDP_FEATURES,
 			      netdev->xdp_features, NETDEV_A_DEV_PAD)) {
 		genlmsg_cancel(rsp, hdr);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 826709270077..bb035722000e 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -193,8 +193,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
-	if (!(netdev->xdp_features & NETDEV_XDP_ACT_ZC_SG) &&
-	    flags & XDP_USE_SG) {
+	if ((netdev->xdp_zc_max_segs == 1) && (flags & XDP_USE_SG)) {
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 1f0bf76dade6..bf71698a1e82 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -24,8 +24,6 @@
  *   XDP buffer support in the driver napi callback.
  * @NETDEV_XDP_ACT_NDO_XMIT_SG: This feature informs if netdev implements
  *   non-linear XDP buffer support in ndo_xdp_xmit callback.
- * @NETDEV_XDP_ACT_ZC_SG: This feature informs if netdev implements non-linear
- *   XDP buffer support in zero-copy mode.
  */
 enum netdev_xdp_act {
 	NETDEV_XDP_ACT_BASIC = 1,
@@ -35,15 +33,15 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_HW_OFFLOAD = 16,
 	NETDEV_XDP_ACT_RX_SG = 32,
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
-	NETDEV_XDP_ACT_ZC_SG = 128,
 
-	NETDEV_XDP_ACT_MASK = 255,
+	NETDEV_XDP_ACT_MASK = 127,
 };
 
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
 	NETDEV_A_DEV_XDP_FEATURES,
+	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
 
 	__NETDEV_A_DEV_MAX,
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 754da73c643b..fcd36435af36 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1090,6 +1090,7 @@ struct bpf_xdp_query_opts {
 	__u32 skb_prog_id;	/* output */
 	__u8 attach_mode;	/* output */
 	__u64 feature_flags;	/* output */
+	__u32 xdp_zc_max_segs;	/* output */
 	size_t :0;
 };
 #define bpf_xdp_query_opts__last_field feature_flags
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 84dd5fa14905..c473375d6b7f 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -45,6 +45,7 @@ struct xdp_id_md {
 
 struct xdp_features_md {
 	int ifindex;
+	__u32 xdp_zc_max_segs;
 	__u64 flags;
 };
 
@@ -421,6 +422,8 @@ static int parse_xdp_features(struct nlmsghdr *nh, libbpf_dump_nlmsg_t fn,
 		return NL_CONT;
 
 	md->flags = libbpf_nla_getattr_u64(tb[NETDEV_A_DEV_XDP_FEATURES]);
+	md->xdp_zc_max_segs =
+		libbpf_nla_getattr_u32(tb[NETDEV_A_DEV_XDP_ZC_MAX_SEGS]);
 	return NL_DONE;
 }
 
@@ -493,6 +496,7 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
 		return libbpf_err(err);
 
 	opts->feature_flags = md.flags;
+	opts->xdp_zc_max_segs = md.xdp_zc_max_segs;
 
 skip_feature_flags:
 	return 0;
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index f5eed27759df..20f5c002e97a 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -2076,7 +2076,7 @@ static void init_iface(struct ifobject *ifobj, const char *dst_mac, const char *
 	}
 	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
 		ifobj->multi_buff_supp = true;
-	if (query_opts.feature_flags & NETDEV_XDP_ACT_ZC_SG)
+	if (query_opts.xdp_zc_max_segs > 1)
 		ifobj->multi_buff_zc_supp = true;
 }
 

> 
> -Toke
> 
