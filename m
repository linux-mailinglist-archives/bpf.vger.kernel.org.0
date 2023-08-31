Return-Path: <bpf+bounces-9039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F19B78EA51
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCBC1C20A1A
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 10:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1108F59;
	Thu, 31 Aug 2023 10:39:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02218462;
	Thu, 31 Aug 2023 10:39:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2488ACFC;
	Thu, 31 Aug 2023 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693478377; x=1725014377;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NKgN5z7ZFv1+dnhZXuAwUbrc4pPS+vunpOoK29+/JSA=;
  b=e2adjL2sm4E7qdxZEJyIHATaonDOzyAnOIWExz6OjuO3rmaseCEOAHga
   T2ZkEORDLkDMJqlCCqDtlK8TaPliMeNZec+UyTg83NhEYjYAdDIvDNSZQ
   dPG5dNiPJJWcKSMm7IZQfFsq4aKneEejoWNaFxUqPEQdpswWZiJL2H8JT
   Nr4JpVsC8zd2CMLq4nvnT6FDM/yFsR+PqxzXsdUYfSqZ7GreobRuZKpKk
   EJqRIWndTriqkNreGnNIiLA9lfYXYfrvI+hgLn4L72zipjc86/t8Xtjg2
   fZc/Z0OXF7JnmHpQqx83HAQKdbM/hleABWZUDkqWI+EkyS7QgGNTXgZ0k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="378607886"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="378607886"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 03:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="689277087"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="689277087"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 03:39:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 03:39:35 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 03:39:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 03:39:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 03:39:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNv36YIwuZUGYvWGrxWLY1z2c/iUSkW88QTAS4lXh2bwL4I+uYXsQ16fONL+gJnfMgKduwlykU9i/N/uD/VYd7/qhHqvavT54ykA6qIG1Pt3Q8w/LLJStxni7S80JFy3PGmpKabWIcSCQEWu+2YxCvP0E3hG3Ri0A6X+2p1xQvUSo93CDMxYULysQxW1JmoET0+3Nvh5Y+sCKznFZKGNB3rer8sFj6Hh4RUWFTrODq0sC8AhJEDfn7XfT5VqhJypuzQn1J8yIVlUr2Rg+xX/QVpEx7IFXU8VJ1dTfHQ6vBzqscR/XQEVZIuCqkCgQyqpE6WGAR62FMvtdfOtsCPJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxmIpER2hFF8c5HJpvYZaIScVJPmk/gvVJPR2MMKJYA=;
 b=HySFb1mi6Ecx1Wep97iL3nGfCiFJ+ZneX9TBgJc3NDLk+D3RFSn7SrNhTjxDy6aEYkknBs6P1T7kwH1Gmxm0j9ttsTPQ0iP95Op0+i9kBe+ReZv9ixkSiHEEWS83RJlimLFVGZffOFmeRXg0eYSlIgi7GGYn96IESAOtFG/u3/0AwUiqMq5xDlKZMvm/0xON1UoX9xs55zzg7/hBWj97qCViVwVb+NIXYgBJj3wlzUWa+7QrOOd5sUVvgnD6xW3fy61v2mJ+5zDP1MPktJx1qH8TqHnpIRbkiJCpI4SzvMX1KMIqd3maQhxy67z1LGEKK1h6pduZy+ROfnZhg2guOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 10:39:32 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 10:39:32 +0000
Date: Thu, 31 Aug 2023 12:39:21 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <jonathan.lemon@gmail.com>,
	<bpf@vger.kernel.org>,
	<syzbot+822d1359297e2694f873@syzkaller.appspotmail.com>
Subject: Re: [PATCH bpf v2] xsk: fix xsk_diag use-after-free error during
 socket cleanup
Message-ID: <ZPBt2RdiWstRa5WY@boxer>
References: <20230831100119.17408-1-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831100119.17408-1-magnus.karlsson@gmail.com>
X-ClientProxiedBy: BE1P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6bad05-9a01-4efb-5948-08dbaa0e9002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7kFwx1DpNcmuWaixDAseygZaCpeZuWltZXRiMdbMdcViqt5IQGGff4KsNwacDek0rCkiile7E58g/L8nWYfEfO4Sf4YaA8GnQex1Po7RG4HoaeeRT8nQrgPpPtPI4sv7BQjGrMOYBxcj8Az5lGfA68rwQfIiAmqYNjY57mRyPJM5fb4ChBETPSpEW8gwYpJvR/rbk0/XhNP/6HUHmoHemnYcKJNnNG/j/1iczeWWNOiDxJtpnfA4GRxFhAfZD7YkCYNApMTCPFgclbJekXZY+lfaraoQz6hB2kDBnQflHurS9ocIYem0V356vf+tR8oHHUGBKu1B0ZoM+difDCuZPsP/eGHI0ewlFdXLX6CGMFcA9HlvzLXbg3ZpLMsc3leDTH+Jeh1lBQIG+ipqDRoHRgskb0FidAZzS6qnJhPw3P8D11yubXdV8Ixhn0CG5ArhAg0r8lYwfcONLM+5satcY/YnWkpS+R2ddPth5K0bbrOrCOVsKShQHtG26l29s8MBVvt6wkM0qIKn1FX/tN5purHDSQJ8QmBZ4cu0GfHRmGmJ3vnjB6/H2s7HkQe61tLd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(186009)(1800799009)(451199024)(6506007)(6486002)(6512007)(66556008)(9686003)(6666004)(86362001)(82960400001)(38100700002)(8936002)(478600001)(8676002)(66946007)(26005)(66476007)(4326008)(44832011)(5660300002)(41300700001)(316002)(2906002)(6916009)(83380400001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nvxe+rdW1zfz0IBZnhyLAf48k/XH89AxeDBFkVVKvQXKhIxQvWd2Umkc4NQ0?=
 =?us-ascii?Q?ibOg4JH6EAkoHP4dT7yB0/2l8JG11m7IVt1kcmd9C34YA8fHeasGisEfN6K8?=
 =?us-ascii?Q?XHY8RIGxqBb/bd9rBkAkhh/qUNnMtnDnlkqoTzlafHD7csu5wUrdX9HrolmJ?=
 =?us-ascii?Q?PbdoC9fTXP3JBbizTM2r2n7ZHwekILzqrit6ZglBqFQP7LZg/PFH0EkL215k?=
 =?us-ascii?Q?kfumCu4NehvUAntjwktdDQDJs8KVli1Hitu2hWNhf6sgtAc+9JkqrM05og7V?=
 =?us-ascii?Q?mcmMtX2thYR5gqGK5UnaNMkiek8wuZf6OB68uufh2ZjakwDWH19yDdUHkJmG?=
 =?us-ascii?Q?CXdLVSgm4858rUXKJeEEV/u2Zcidb6Cx34Zst+xmOQvSPktJhwtCJWPUD/S6?=
 =?us-ascii?Q?pcn9bjSrWEKf1enSFuYMwfFXDsg+rkXyYWydm4IWaV0EnwyAPfFin2VOwDsc?=
 =?us-ascii?Q?w4r8qLmQEDEhTaDOWf0yqxXitoYfmVGquykgcRr4vLQMDBAfqObkdnOQsR6D?=
 =?us-ascii?Q?YGRv3a5hDNl9BY9WVmFbVgCwEY8Tsi1LjJAiOm9H2WZtNHdNyetPHViQd3Ox?=
 =?us-ascii?Q?AH7flRQPLs5awoO2ovK0GK5HemcSJJzgSOAgOjRqbrNl0fY/i1lD/+VACUZz?=
 =?us-ascii?Q?JaYqcVy8FHquF+I8wKTBsIMbGG6T2d9ErNO+Q2J0kSlcvGJDlynjxQrEOH7c?=
 =?us-ascii?Q?q847ZoyLH4ZdaytquOVpA3RHHqfi+wQvhxNNZia/EKiBx1GAHHnDKSYdMr8U?=
 =?us-ascii?Q?3d4pGEC1oMeX4j9U0cElYEdzV2jqOv/kVaevUn1PHLMozKqKvg/72yb4v7ZG?=
 =?us-ascii?Q?LxlWeNLTjHOS8ZRG+Q9cqkVd4r/XlQu+ueM3b2cGvZh2DcTHhtCHTa6qHD2L?=
 =?us-ascii?Q?l/9jY8OogtTnJRiGQgNU+3Uz8rKpUXh9xTtazI+ft+0Mw4oHL1yn5iIHhvud?=
 =?us-ascii?Q?6H9HWHobAK/IWvLYMJVqVR9xCd4lcx5ZvLw10wxQsef0j1Ae1GZIwl2hq4ja?=
 =?us-ascii?Q?DtY8ZPK4/D+lFAlVHQzHJ51oxy8B0Dld63mf3WNxcp1cvP4tGW4Psh/tk0Hk?=
 =?us-ascii?Q?FdVHFC+a1OSq2Ug/oJuzUGb1Ag0btbBlewSrWMJ3mcGFoPfzJPaYDQ0O7zt7?=
 =?us-ascii?Q?DQTVnD7QfNNUNwzjyQed7+ODdFlOocCe8gj7k/qU9Lai39eBTAkw/22fvoB/?=
 =?us-ascii?Q?gzjg+1mzZxx+awWiVCxnCJYE8O/8JvXyXwsB39pfBxr3vo/fpXlV+3rproc2?=
 =?us-ascii?Q?eFtazHhu3nJDdBSraFVMXa0mif8jS72xIuJ32r6SEBxLeAngms12IXG4cWV0?=
 =?us-ascii?Q?W/dfepa/mRzZPt+5ZRa6ZKv4BYcp/EfFnUs/yD+Cw6rzrIXt/93QKSemfwLH?=
 =?us-ascii?Q?KTPl5ufvwDiBs0RaERD47+0aTvR6GB2Ke1bvdhZQmvaoCZyobuYTbG/qIP8G?=
 =?us-ascii?Q?XW+sg4WQckSLfBbpdbNgmraP8352THTs/PhArwJk4CsXeguBnNFZynB+ZAUX?=
 =?us-ascii?Q?0p247JlNIRYw/fiAXmQGe42TJxWcp3+nD313j/Oy8yU0H3pdTokxZCUrs6E1?=
 =?us-ascii?Q?UkYxffxOy9FhvIqUMKsDCDTfHB/0RgyDxK7XGWNvxvfnsOiS5YvKnVcvQQJ7?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6bad05-9a01-4efb-5948-08dbaa0e9002
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 10:39:32.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFrM3ibrqcyfrCWSRLMoL2Futu1sL8M0wJxC6I1nSU0o1M92gNlYInbuC/nXRBWec/lAynd6Ctdg808EeW2bSBQYkP64ixW9oWww082xV8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 12:01:17PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix a use-after-free error that is possible if the xsk_diag interface
> is used after the socket has been unbound from the device. This can
> happen either due to the socket being closed or the device
> disappearing. In the early days of AF_XDP, the way we tested that a
> socket was not bound to a device was to simply check if the netdevice
> pointer in the xsk socket structure was NULL. Later, a better system
> was introduced by having an explicit state variable in the xsk socket
> struct. For example, the state of a socket that is on the way to being
> closed and has been unbound from the device is XSK_UNBOUND.
> 
> The commit in the Fixes tag below deleted the old way of signalling
> that a socket is unbound, setting dev to NULL. This in the belief that
> all code using the old way had been exterminated. That was
> unfortunately not true as the xsk diagnostics code was still using the
> old way and thus does not work as intended when a socket is going
> down. Fix this by introducing a test against the state variable. If
> the socket is in the state XSK_UNBOUND, simply abort the diagnostic's
> netlink operation.
> 
> Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")
> Reported-and-tested-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
> v1 -> v2:
>   * Added READ_ONCE for the state variable [Magnus]
>   * Improved commit message [Maciej]
> 
>  net/xdp/xsk_diag.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> index c014217f5fa7..22b36c8143cf 100644
> --- a/net/xdp/xsk_diag.c
> +++ b/net/xdp/xsk_diag.c
> @@ -111,6 +111,9 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
>  	sock_diag_save_cookie(sk, msg->xdiag_cookie);
> 
>  	mutex_lock(&xs->mutex);
> +	if (READ_ONCE(xs->state) == XSK_UNBOUND)
> +		goto out_nlmsg_trim;
> +
>  	if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
>  		goto out_nlmsg_trim;
> 
> 
> base-commit: 7d35eb1a184a3f0759ad9e9cde4669b5c55b2063
> --
> 2.42.0

