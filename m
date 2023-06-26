Return-Path: <bpf+bounces-3439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393A73E065
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D600F280D3F
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71029460;
	Mon, 26 Jun 2023 13:18:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974AF8F70;
	Mon, 26 Jun 2023 13:18:44 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7321710D;
	Mon, 26 Jun 2023 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687785523; x=1719321523;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wIUM1Aegk3wySHkAChTOW8sjFYWaPO0cvTySIUKbMP4=;
  b=l5t7QtZJJHFHzHFCOywth2fXp0PWoXaSFXVeEErwtaK/P36+ShATXw1U
   wKCKjU4MuEDSLo2VdwdK7If/XDh8Gv2TLYMZgU8hzH6qVlaF3lL67l9px
   liM5xhtD/wwRi2LTq8/8+YBgEO3QqTl8RwlVc+XOoHo1H+L9ktp8dikWW
   vZbOvOqU7VTuLgFDBDWO6s3vd7HisBMfGIDoHM65VGF0F87o05DYYtgxC
   LQeE9NGpvm9HsRoPUbc56QuLnM1iYUQFeTbNsKNnHmOSr7UodwgDt9/aG
   sRqskcV7ikWd/0zpod9Z8w6kW+5ttK7+GMhVOs1ARHaM8d4c+zsSaDvKZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341602281"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="341602281"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 06:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="716139408"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="716139408"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 26 Jun 2023 06:18:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 06:18:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 06:18:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 06:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BycmszIE+kk29dQSEVQOurhHcxZPqA04nvsJTZkeaVHGJDic1lVLXGUb+M8lcLr4pp5QD9q7LIUC1RXB8aPJf6bfxFTIaUy7Ku+p6A/XoYp6zAuGVM2RzBUzxZBdkjc2WaFMIVOEzpWObIuARP/87xE4xG9IKWGf37fGzwAQ3kinb3MUfKpkdMiUTDXBHItQ5AUUDJYeP+zn6HPQzRSZ5r8sWqlHGcfTKbenKGlPSpTZ7MwL8Q3QRQjr4vppdpsWnNUSxObzQFlrsg89eNfyaqkZXcuSbtdpSaRyA8U1dONCr4VPhz9L0v40tW5ceXUR8gEX8vKfWeIaqGg1I26VxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mMl+xWAi16inuyT8rM6jZrl35+3SKYbm2Yp8MXA4sM=;
 b=M12KlT3+JFOL12+iE4cNlDPCCe8Dxz1vdTOXWVeiRvBDTmYDjENp5wHir9bSbd+VZg09x3BWNhM44z0I9NrLzRcT+uSfqxfqWQ5Tv2hUjr0zSrMFXOgls4SPJu/AGr92G7X3EZ1Yy80aZq2pcELkZUiwvvL9FCJ3SrgWVYMDZkgUvND8ld+Rm1hw2k8+SSjCFKEpOUIENZjC7t1s8kRZxjb+ufyYpMK+D6SWOmzrRd5fp8NswJlUlZZXxwMQ4xE6U784FMQ5Nn2pxRS6PDNLFtyB5WKNRlOM0cX/wFt0Pz2HDVACoytDEuEONADikAdh8pnBqY5CuvGTJSj3PsF/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB6809.namprd11.prod.outlook.com (2603:10b6:303:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 13:18:31 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809%2]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 13:18:30 +0000
Date: Mon, 26 Jun 2023 15:18:23 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <tirthendu.sarkar@intel.com>,
	<simon.horman@corigine.com>, <toke@kernel.org>
Subject: Re: [PATCH v4 bpf-next 01/22] xsk: prepare 'options' in xdp_desc for
 multi-buffer use
Message-ID: <ZJmQH+WtPaaI8MCk@boxer>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-2-maciej.fijalkowski@intel.com>
 <ZJSavRFNNvSvoATt@d3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZJSavRFNNvSvoATt@d3>
X-ClientProxiedBy: DU2PR04CA0192.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: a880f57c-f68d-41e1-ad90-08db7647d5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zT8G42C84IgJrQuN2WhAmrWe3yTYI7FRJQLwvsSc4kPz6mTEYg+McigojE9qkPGQLDTxPjH57VtvlMKlWGCX1FJenkP0U3QG1o1Q5JHVtRMCzeLI3Ne4Epgnj/XOpeLDmCcC6yADLqExNPBanHa4FtbhQiN4w2wS21I0xkAE+ea3kpZwH04UfThmyfdrKrspT470gNce16IGiXLmVnA5QfGdD83X6/MyGzYA5i02kYbLI66+j1AgAy5AKryrXd7s+K1poQ68+r5rfQofAf+F1GyX4uCKfr/Tucz7uZkrUGgI59M5TJzhvNmdbjofrjtXLYD2H57nCup6ZZKrNrPfdlmMSKy2BIg5XNdQqm1NYeF+cWK8ai2biChutz6PpiK9BL+dj9g5SPXHniJLW2cxAvhSjSsXJrtUBilDB9EjN6fksJ2O9w4WjbdZBnCp1fJODe3OdLCrCJ+10EmslW2erGVxr4DMS3OjjPGyf8czijQmYWeAKS8VOLNrRALsMhLgKFimgwXlDm9kwUSxdC8+rc3liXDWcg0KrmcWdlLIeorhHalms/QtnVpXnwuZeShemvhILR1x14cDXYdaYclAU925Y8K5AuyECq2FAjfOJck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199021)(478600001)(6666004)(6486002)(83380400001)(26005)(6512007)(9686003)(6506007)(53546011)(186003)(2906002)(5660300002)(44832011)(33716001)(38100700002)(4326008)(66946007)(82960400001)(316002)(86362001)(8936002)(8676002)(41300700001)(6916009)(66556008)(66476007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pDFc2UhkdrltIt7wB0Rg4fY0umeJciB/bxAxmvYGXHJEcuSaapA7vk3Fd/rh?=
 =?us-ascii?Q?unvgDoWh98frD1kV/SyhsnRYm91Zsk+aQkvtMTnwIupFUbfzHJkUDuXSYuDU?=
 =?us-ascii?Q?FsWKibAQAVGc0ogPoyVRU1inl6+dOoRxEPEx3vkBw/u9K9djJfqY0Y77AVpK?=
 =?us-ascii?Q?erG8P+cSARahbMMrN/v3QXpL+/4gLiAKBMoRjD4dXw24r3o64mYxV+JWQ0uM?=
 =?us-ascii?Q?1JQbriZBc6kS/d+Qlna5MplD748Ab+uCky6eL1HFdguJdRzozlF+urWbd1VU?=
 =?us-ascii?Q?I0ZaplPfH7cdh+O+MUWgs2184uFXmwKe+ZH94qMVsgYrdqRR6vWhOiqBZNSV?=
 =?us-ascii?Q?itzqHdcA40V5V7ClV4hjbE8NQDx7vGx0zHBOH8lxOb0c2flNTh4xeN+cpxmA?=
 =?us-ascii?Q?wWPrDQGKu5J8sTdbDP+2JTWhl181ArksBRdck5shvLYPs1FNHU/PhH2AY+rB?=
 =?us-ascii?Q?i3Z6Trve+gs9SLJYOXJ09NP7sfuSdejfMXxws+GVq85e3NxsFg+q2DGMwwxK?=
 =?us-ascii?Q?bIczirP9yK6c7pMK17EzMAS1JLDP3zmHmHteVrHF9Gqjpxeo/IOoFn3Ujumg?=
 =?us-ascii?Q?uNVeS/N9Vl33wgp+J2lSQAI4sR2zlV3E4zcxszfwuK5/D09MHpfsJl17xVdo?=
 =?us-ascii?Q?Oerah7ITHVg3HPkiv1Yujb8Cv/TCWdP3psjS8Nazqjz3eGGWrSqiq8tqyprl?=
 =?us-ascii?Q?adjn1/wdW0pDwEStlSAeKYTcllbD/4iVouUgY9n+DTKrgcwaSt51SZ6Y/Vwu?=
 =?us-ascii?Q?BANVth1tqvtuOSQHJcgcRX9ukEy0CGsOiAjugeRlNKrbuUentQt2yZSrJX3s?=
 =?us-ascii?Q?7MR8xpvMKsavMm+AK5aVthi5KAQllPqa3mGSdjcgqfrecmayrPQmZTIHeP91?=
 =?us-ascii?Q?5sSn4CZcu4JBaHn9kZfoLhXgIuMgPSGLSLUVHdLo2ev4BBNvch4J7+SM1ILH?=
 =?us-ascii?Q?A4pJ2m6mfysMNOwmXN5RcLaXWDOJ8OPW6Zo8AnLvNlUj+9Z9YwsIBQGGtZZ+?=
 =?us-ascii?Q?+2z+5C2WA/JaFn+kFlxSN2Ro3SH+ajKRYKMXqEHYJzwQYwwIutseMEB4FFPD?=
 =?us-ascii?Q?aL8ec4t1FJbsT8PUjeAMDholO6fjP9LLbRbVOCNoTqjMViTHZQ+WOlfNmTW8?=
 =?us-ascii?Q?rqgtdO08iF+hZZggbdiUUrTzILQGzhe6Mroy7VESvcCK0Dlq0Au5mb4Z5h8r?=
 =?us-ascii?Q?lwwYMc+0ujzKale9eLTi0Xt7O1E/KNuE155fiNSWv73MNGOZHENDVh/QErMA?=
 =?us-ascii?Q?U+OA9nkXUkcpp0Ir28W0QzHqeK1DR0z57142qHZPMtebE98BYs3k50KMcUtm?=
 =?us-ascii?Q?lYv7IonzaqEEMdntG2a68OhZVlKR9XBEJIL6DuOCSul3KbBNUsqyNeR0KrSy?=
 =?us-ascii?Q?6J81Dvl8WpQv/xojDdSZNFqYLkoPZe9+Kvj3mCa3YyOhmZKDUNdjlwTKBoWQ?=
 =?us-ascii?Q?oQeYHMQC4IAuV1NTEKlGDyNkRS99/o3PKB9qFGQay0z42Fdkhgfnd/vhLPVd?=
 =?us-ascii?Q?NOV+J07paKmijKS5K7ncNTvwoRxxf4Wynw7X3BWen8iqMFt5+Bm10qK4Erxs?=
 =?us-ascii?Q?pVYDrxx6rhhMR0kDyoB7CSmXj5xnb4vob+52DTawj2j7Kt5WYLa8E8YzBhv7?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a880f57c-f68d-41e1-ad90-08db7647d5dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:18:30.7200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/SWEdi4emWzfdt1voTiLzQyS6RR/IpcX5OGlHf1m8vegeRnj7CANTXt+zp83QA2+iIPZq9Ta8UZcYza3h3H99GigVq3Hm+aFzQWtRG3Uy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6809
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 03:02:21PM -0400, Benjamin Poirier wrote:
> On 2023-06-15 19:25 +0200, Maciej Fijalkowski wrote:
> > From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> > 
> > Use the 'options' field in xdp_desc as a packet continuity marker. Since
> > 'options' field was unused till now and was expected to be set to 0, the
> > 'eop' descriptor will have it set to 0, while the non-eop descriptors
> > will have to set it to 1. This ensures legacy applications continue to
> > work without needing any change for single-buffer packets.
> > 
> > Add helper functions and extend xskq_prod_reserve_desc() to use the
> > 'options' field.
> > 
> > Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> > ---
> >  include/uapi/linux/if_xdp.h |  7 +++++++
> >  net/xdp/xsk.c               |  8 ++++----
> >  net/xdp/xsk_queue.h         | 12 +++++++++---
> >  3 files changed, 20 insertions(+), 7 deletions(-)
> > 
> [...]
> > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > index 6d40a77fccbe..ad81b19e6fdf 100644
> > --- a/net/xdp/xsk_queue.h
> > +++ b/net/xdp/xsk_queue.h
> > @@ -130,6 +130,11 @@ static inline bool xskq_cons_read_addr_unchecked(struct xsk_queue *q, u64 *addr)
> >  	return false;
> >  }
> >  
> > +static inline bool xp_unused_options_set(u16 options)
>                                             ^
> To match struct xdp_desc, this should be u32, no?

Of course. Good catch. It's going to be fixed in next revision.

