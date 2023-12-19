Return-Path: <bpf+bounces-18276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE8781864E
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 12:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80F41C23B72
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E9156E8;
	Tue, 19 Dec 2023 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZO2/egZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F1914ABA;
	Tue, 19 Dec 2023 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702985222; x=1734521222;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sEbtD7y8pr0JWcmsG5wxo7tMIztiFI9hZbPxiPPqQ+U=;
  b=kZO2/egZDF73MIKVSIYG9NPc6ZgmKQZaJ/UpZntwKfXLaXeI7V90NxNR
   WdW4vQvMkM2Wq3YJwZdRL3pB4M0tjM6PmZPu+bqF+hQAb8MEyBy1qrY7L
   D5Ue/5L1CKcYeh3gmiUxFBq+QjjUJ3Ol4eH1dT596ku7GnpoQ/Wy9KxuA
   hMteGDqEx0x9bgwnx2LS+0hXKGeEn8MLlpHFtbhK687xsbTcnFrgkgWIC
   ChDuW7EJt1RdNWHbA76QSn6cUiHEwBgZlYLpoarFdjURlQwWjbfSKWN9L
   yNiemsIk5oUB1x4aWXnTsnB4OaWWyH8o7JbUN9gOGUcXwyh3YjW3Y3yeB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="392816883"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="392816883"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 03:27:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="779452401"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="779452401"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 03:27:01 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 03:27:01 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 03:27:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 03:27:00 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 03:27:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqe4E8AyqMf5MnbVVlHzeyC5JnF6fk+sHa2PKbMsgEvRJzYaHJO25RyTQKNRAhbe6SvXR/O/+5jvh/m3xBR0X22v2zjJjI3j3BxzEc9hmWI8IVwd7Fjw6nhs99VXOvcL31TzlTA2GFtg7t/SbR8NrGJoElWelisdOZBoNVcKABKff9fK4cOn1Lg3UEnIzResv39JZNATq9swUIfaqOCGzAfX3InN/aBFWaACQWItmW0RfpcT6CQq5rva8XYIq0IBiEQyZmWaGdxeaVlU/YTaaeYFem6EsPFCkJHITDsJJv2WAAG+uMe4bAMZhUwpC3AnEnvlT1HA4CML9d0kx7btbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyiL0iHrZ+lguT6h73HdpxJdLXMJeOlgbIlAvNCmSuo=;
 b=mto0onqQf9o7o5qaawY2YCoam6tBnyST4cZs/HFeE27nC/kgW+CU1+bmYxok7CvwA75F/qIgSxWIVzbC17i7SVMIzMIx54TpAKvmcMY2lNkNEWwxQrfTAJzR8hVzbMDNU61uUrhZRrgWqpFiQEY0mWoxRsTztw8VCZVjEGiBQvZ+ryE6fs8F7JQ8o0y279pAjBgBw4mvSDqqg1gRZ4L2lCrOrYHeYfkhxMT3+u51dJ+xTGA7y4hTRdPDupMU0yInhmtDRB64RSvxUzhjvBrvp/NVf3bQ24Enrqs0WFQMkZq5EZWBVKONyE9d8+3KX4Toh9qA27rghIsQN/TCJ+ZdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 11:26:59 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9%3]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 11:26:59 +0000
Date: Tue, 19 Dec 2023 12:26:50 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next] xsk: make struct xsk_cb_desc available outside
 CONFIG_XDP_SOCKETS
Message-ID: <ZYF9+lhYT1i7dvDT@lzaremba-mobl.ger.corp.intel.com>
References: <20231219110205.1289506-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219110205.1289506-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ1PR11MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e684319-c093-4d13-6180-08dc00856a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ingCBJxeKzNdt6gvfNwDW0RH3qsIA8jDRtEBuuPZ1RkvkkCId0Z7MnP5mGVPTg5kN96zI0DxtwAMRnDarQgYuBKGlWfIvrymPiPrPM0t+uECXRBIGF16djyt80mbw/HQWBjWw1WIzH2troTEqTp2PjS/24wkRUl21NcqITyxLB/8Q5aEW8RFBpI/w+bPafG8FuZe2NhVdUPeLyf/Qnz3TD+1HlcovnwrLeeOPSHTUKFQDKa9gFFjK4PSmBYN4FbCEQagVWXwpk/2c5lL3/9pB2q14jyW6d0W2cqPgV6gwCTLYMGax2UXeesGjL2DVcxcRctHpkRpM01kup3k6Pt6cm/eTTjueLLB0/7F0hM+HIeSGkXi2EIQPqwkj24rIH39twLeLTJFhWf7d1+QKHA+SMj4U9daHaodJa8VCuJ36MR5QKVmlDTaKgDfXj4iYDrB8MRwAxOlTKw/DCyfWOBmojHPzI18nAXFJEHPD9hqsYpSAVU84ylHAkdDd9kYQSxv6rY9nGTRp7ZbbnuTNY/msK/mPXBRzhFbiacDv442l4sb6g9p3vnKTPw4XfifTbw19uEwUeg44M8RISvEXZla9IIGZJPapyhf91uxwxBPPnQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6666004)(5660300002)(4326008)(6512007)(44832011)(2906002)(8936002)(8676002)(6916009)(316002)(66556008)(83380400001)(54906003)(66476007)(66946007)(7416002)(82960400001)(41300700001)(478600001)(6506007)(6486002)(26005)(38100700002)(966005)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UdJ9kqPui9hFCSRSm8GVlf1BwuUB6OxsWGFuYX5maM7xzVr9DfwYXf3jFWKO?=
 =?us-ascii?Q?OhAjvcTJgC4IkX3ytgOlxn3qDCyK5r2mmbZ0govK6k/gCS2TD5WBQ0UbK58E?=
 =?us-ascii?Q?GvBJEIDDYvsC9etYERlYZhJTUUYwKqvX5tLkhSdEdr+Y82olKnzlRizkz2n9?=
 =?us-ascii?Q?SDsuA+7rsuIs/FWhTpxHXxqFcLAMtN+ftMZjqc7jglySU5VcG8NNjLedV+84?=
 =?us-ascii?Q?wJ362haOQaIq62UaFiQXm85aUMAEToQmeMlvaFAB/8W2bAt78vtDGjYkNWbe?=
 =?us-ascii?Q?uVEidJboBroStyjJ5hYq3S8bmjWy5doDrc/J4C58bsRK2zuO4BELirYw+CvD?=
 =?us-ascii?Q?LjcKZhGSLEeUdcCfkwSLmkDkqidV2yzN+Tb2vdX0SBXrfglZq57zyU19GACZ?=
 =?us-ascii?Q?07DGGZX98h2rKZ11eDFYDtDXpWyltLsML4HwhZ35DBSjGRSMLnd2hbJAKQ+L?=
 =?us-ascii?Q?y0tTtw8PbLI6tIqMkrKNmAm5m7IkMu9LM3jfOTmgKZh6cijciQFOThVFQP9G?=
 =?us-ascii?Q?mVLn1KhHO6d5k3iR/Pjc/mT3EeFdv2Uh53033AxeFvTuUAXT53XE2ljqBFbH?=
 =?us-ascii?Q?LUZlQoHOEhNJZgn60LtX9AEbUoE4s6wjApOHGBVG/pThVg7yNlWEm6Uxlfap?=
 =?us-ascii?Q?KMx8QiOerX+fti8afUzXZFFIBCkF8trZj9mNaAN17IjTX+/vIcOFatX1/dl/?=
 =?us-ascii?Q?m0seqPPaVc/2mQGjFumaY1MoM+Jp4TNZ6fKZoga1ww4B5anj2o5Mi5+pRZVy?=
 =?us-ascii?Q?evDQxm6tDlTIM+ubxFNl4xbfxejtAz1+Om9hKOXhKbczP5ta6hWyY0fpiKOd?=
 =?us-ascii?Q?i+eQqQ4ORq7ltPqL9vp6hl9N1GeFTzKVKo8wb+eGHh6PsNSwIBQBGxC5v827?=
 =?us-ascii?Q?n1/O3e7eU4jf4Tso67fFXfNlmVY3FOSu/IbDLCu5PNSEPDzuqprieJmNqxh6?=
 =?us-ascii?Q?NP+6KwlzWOoMm1BTDASFjHB40NKgKLSnQNgsxE9yfAaakOHfZzkKdPOV7aqm?=
 =?us-ascii?Q?xFa+X+TefvO8DwZUakf/YNLYQUg1ofln7Xw6AtU4/ph7shCcvo7tGC0PTzmA?=
 =?us-ascii?Q?ZBoC9fWKBcpLHOfMg9x6MBLcMWDobUmMkcQe8Qd7DEXuHxCA/xxLzrQFN8Gy?=
 =?us-ascii?Q?QjaXiD3s7XeE3hbJhntv1p4iRuncTg2pPXCP5//Nz2Hg1S/srXiPt1cm2OiX?=
 =?us-ascii?Q?feabsvPsrIdwwVhNa2iGBMGg9AS9PoyzSPgx5tX+sIHhHNJwZ0ioP5IgOZwv?=
 =?us-ascii?Q?Jw40OKKPmE74e6h/prSYk4uxZTpryD4uaGX77G3w19DYV7c2X3lrBhDp4mwO?=
 =?us-ascii?Q?mgyODxJw8AWG8/TFK4AJB9+Odyz8+I/qPZ2k5LVVdWzcSveD2RB703ubrNm3?=
 =?us-ascii?Q?mJ/1cJKDLZ8zICwzD4bSHseLjuwmqpFJBauRfoE9vQLhuxKRWAE0g1k9QMnz?=
 =?us-ascii?Q?JNoRAU3biOZck/7OYJKYsgL0nk1WsqB3Jv5ZU9ebfnDF6bpe8u7MK0UMAHCe?=
 =?us-ascii?Q?HgHsfft8EUm41hO944jFY+DbWP38DPjSWhMvZGEt8Oh+tb6mtxhRkOutR3Zi?=
 =?us-ascii?Q?Bn+qQRpfnvPOrQLhLNOlm5tDGz8F92sunBbqIxbEc6AXZk2zLQG2vQH9WtSw?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e684319-c093-4d13-6180-08dc00856a10
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:26:59.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0l2Qoak5/p+UUThtiVlJ0IVRqR/jdD6Q2KX/6BqfKGQ5V2GfemeHO7lwi8r0DbRAKLs+qt9nwnpSwqdpdWGOis8WyJgrpBAAlTvzj1Pl0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6084
X-OriginatorOrg: intel.com

On Tue, Dec 19, 2023 at 01:02:05PM +0200, Vladimir Oltean wrote:
> The ice driver fails to build when CONFIG_XDP_SOCKETS is disabled.
> 
> drivers/net/ethernet/intel/ice/ice_base.c:533:21: error:
> variable has incomplete type 'struct xsk_cb_desc'
>         struct xsk_cb_desc desc = {};
>                            ^
> include/net/xsk_buff_pool.h:15:8: note:
> forward declaration of 'struct xsk_cb_desc'
> struct xsk_cb_desc;
>        ^
> 
> Fixes: d68d707dcbbf ("ice: Support XDP hints in AF_XDP ZC mode")
> Closes: https://lore.kernel.org/netdev/8b76dad3-8847-475b-aa17-613c9c978f7a@infradead.org/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

This probably should go through bpf-next. Other than that, fix looks fine:

Acked-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
> Posting to net-next since this tree is broken at this stage, not only
> bpf-next.
> 
>  include/net/xdp_sock_drv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index b62bb8525a5f..526c1e7f505e 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -12,14 +12,14 @@
>  #define XDP_UMEM_MIN_CHUNK_SHIFT 11
>  #define XDP_UMEM_MIN_CHUNK_SIZE (1 << XDP_UMEM_MIN_CHUNK_SHIFT)
>  
> -#ifdef CONFIG_XDP_SOCKETS
> -
>  struct xsk_cb_desc {
>  	void *src;
>  	u8 off;
>  	u8 bytes;
>  };
>  
> +#ifdef CONFIG_XDP_SOCKETS
> +
>  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
> -- 
> 2.34.1
> 

