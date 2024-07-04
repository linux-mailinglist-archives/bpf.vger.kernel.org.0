Return-Path: <bpf+bounces-33893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0599278F4
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 16:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118AE28E687
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3433C1B3F32;
	Thu,  4 Jul 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcsYhgW+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4F61B3F22;
	Thu,  4 Jul 2024 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103926; cv=fail; b=jnfhm/mWlYezIT4H7FPuSSf42Ecl6pIvlKH1jw5KEwjO3sUDVlIRsobJp08RhhcAsKqEdEgxSvi2LzF7psYdFFGTQDioS8dlq1j1X9Sge/IoqjwSnOUU5yrp9Cxves23EUkIMNcRtQqsaWJ0AIepZlayPjBrvM8Uv4uCykp/KvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103926; c=relaxed/simple;
	bh=8d1gWqQhRraIDi8ei0Jm64KonweyjYs1v9gHjqlUI/s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDeQ9i+5Qmq2tS53vGzkmlM4I7bHOe8R03AFPMrz+ks+fTackGeRK+fb5iRPbXduyXGBObL9KOVU050FyIv0MCcIo49kSUyKESlWMpDH4xG0r6DvL/18uj4db+bUr1w9QFmUWLa0nCaprxvMvF5YOdG4Fv0rsB3JsQda6Rz5BDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcsYhgW+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720103925; x=1751639925;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8d1gWqQhRraIDi8ei0Jm64KonweyjYs1v9gHjqlUI/s=;
  b=IcsYhgW+0NSHloYQUKubyHmgqKMYPiWJqN50xfSloTT7w8LmHiLQfYoc
   tYwSVLDr8f7ymfiJFoSiBG37cmRRjzPPVBjWbgm0xpDyanKJaE3hysLhi
   MbkrivW5VD9H0Rv0YrTHiHcg44zE7jSwnjg0prKfclLsikvYSruupMtyY
   ESe+OKvTmoZhU+IWG2epWK99A3//l85cSQ2zI/PvgVN3m0klfvq6xCxrx
   WvNY38qpITJKv4ZYcvhmLQK6dKTofKlz4STBWykZZetsm88OBRrh2amDU
   luPB8gSTP48nkFZ+GVVKZ7c0syGAiGd5U6c7NpI29DiD9yJnHkQJ/C9na
   A==;
X-CSE-ConnectionGUID: uAau7KsiQImZxecqbVQ6Ow==
X-CSE-MsgGUID: 216dLfPORhyZKtnVnqRBGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28785353"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="28785353"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 07:38:44 -0700
X-CSE-ConnectionGUID: gaP+e1TOQW2Ax623LcIO7w==
X-CSE-MsgGUID: CkGuUy9pSPasOKRJN79zSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77355299"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jul 2024 07:38:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 07:38:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 07:38:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 07:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBZgyh9IJf14gPsopQhBFhi7qmPfCp+IuXNSPNHfoDGekQAvkM4vRpky6k7v3Imc/gZ4caAQgNh3zyJgQ2TD3yTgCZTGA27aFJl+I7u5bM+T+2XfJAPc9XHAUzlsznNY6XoIMtK9JvW9kHoh6Q8zDImWKheBBKEnEVM5MfhwTeKvh4CCVabl3EFZTks06X6n00B6Rq4O5TlpGFhrJ75ajzPaOuNvqswwCI8L1F2EikkvLBtj1vo/Y9+4rQ25r1vrkYaKoGKse6UHxZQuYGoy3h4WjzhXRzmDcdqhe3td7+x0pfNu5DcrwqCyjx8+5pzDU80HZSjNcrBC9DfI3bqkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E0aCtClnHFzLi8uDKI0e3jKOiOg37l50eraxdxn0Fk=;
 b=Muin1foXrgdBU69MgM4830kdsmjAmFxUpqwA94L37Dyyr3fM43jHKVKHZWyb6sfnHyHNkQxLbtK1+AXdfMxiwfoL1UJPUFz6XIo/NFaF9Y+mnuPi5rzJI125/AZ2Dwm/DuH8dh4Gfv+mPvzGsOiHS0Y2NQ9z24/oJqG2K63hqQAt6VTGhEA19VSN2waWtvm8gBiEy6nQgOw5osRGvIi0bG9IQ3c36M/JIWqGcMHdPZqClYjlLoXZvQQgCMVzffPsvMCuDGfh8KOB9pH33u9guL9n+rGkCVDm6L+O+2l7iS+/pvl7FQUewnMsbh3SMvEFvcTuSULi1iat1lR1VD/a6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 14:38:38 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 14:38:38 +0000
Date: Thu, 4 Jul 2024 16:38:22 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: zhengguoyong <zhenggy@chinatelecom.cn>
CC: <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpf, sockmap: Use sk_rmem_schedule in bpf_tcp_ingress
Message-ID: <Zoaz3jhyf4VCRjTz@localhost.localdomain>
References: <ae2569fa-f34a-40d6-9a03-33a455fbb9ea@chinatelecom.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ae2569fa-f34a-40d6-9a03-33a455fbb9ea@chinatelecom.cn>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SN7PR11MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4b16f7-59ed-45d1-5af0-08dc9c36fe2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FtPXJ304cf1PU3urtfE4+7QNLnifpz7PKSdKlxb2cUCBgD+RPFzJ9lYdm7U3?=
 =?us-ascii?Q?8U/Dn+PyO3q+P5OT+Ch4uhhKiO0u0v0S/HCCLeXl1RX54AJamLihd5/Lfce/?=
 =?us-ascii?Q?geWjoJHemTburKDnQt8jiAln46pNk0U+MXoBirPTFtb/Ca2WEyLgeZhZbVnp?=
 =?us-ascii?Q?cUFVk9M4I5dhoFzVVoY52YZrg+vH8L+GpYK6o6l+Kf1CoQ+EYETT9acSzP6o?=
 =?us-ascii?Q?rJRHJnYJvGXKGOeA1gskyyxxTW7ZX0taHIqOiG/bT/bKka+JdXlDMBQ7hxv3?=
 =?us-ascii?Q?8qyiWhCXoMOHOtFS5g/ZoBjvL4awGh2sqkrF6h8NRsClmijXG8Sj55B8392t?=
 =?us-ascii?Q?6LtGVpzvH7P2xZvNFAEWQKFMItbI2NuM6zz/yg4QXmqM/rGOO7cnXXV8gT9Q?=
 =?us-ascii?Q?1zcM9Fr19UX7npjXuTwxp0GypAOjmO96N4l//IBqj4qDQB4cPeobxc6NMTxz?=
 =?us-ascii?Q?yNF7n7oCPx+I39N1U2Ab/VGWlgMr1VjieEU7nL5mxVRb4LGImy3WYBfHwMQy?=
 =?us-ascii?Q?J8qkR5RcUG8aKBRat7OFe25yV9fTRP5oNc5oan3zhnV1Wyt/GkgETJ3fO076?=
 =?us-ascii?Q?pFYUlfRFpwUo6iT3Hme4rkcI9+3nPPurAZs565T+pPi8NZ6kv/kgakUPi8/3?=
 =?us-ascii?Q?5k6TpewvPaMauLVkaIh0uOXpHaSY7n53fPnMl1JTT5B4DbM2DnYi0++5xBen?=
 =?us-ascii?Q?diI1Wn7O6nXMZV0ReuxHojs/dZM394+yVVFRAKDPg/za4O66TkbQ2zPdh6pK?=
 =?us-ascii?Q?Pjw1rw6/5dJpXZy039mvivbSa2+EkXNXzPT0SpNKdC6hxlDrEKbJ57UFtIEi?=
 =?us-ascii?Q?aS0lqfnRHadHxL22seOSv6IfYxWxP+jUbf3fIDUK4pNkU7c0p9PGyNEfFVhV?=
 =?us-ascii?Q?RkvvulLbfByTNmmPS7QD2dtLxL5tkqqgav8Eip2QfIDlX5vQxhY2r/5po/qr?=
 =?us-ascii?Q?2Dq23jCfMyTZoOQezwSx/opgdHpsOAFo1m1ccWtDeYbKRVLfTF+x8Jx/45nO?=
 =?us-ascii?Q?r+olkKp1sPAGI3BTWqCUxQcoTF8N82EuM1qHONFBzBoxsWYsoqbBGTKb/AAp?=
 =?us-ascii?Q?LoNtLdSljSSAttY2p9yRVYDQ6KvTE+u7NnpLU3v0+SpnAC/3RevWSvsYalHW?=
 =?us-ascii?Q?Quh0/rs40AA+42ln2AAO0zbjus63lpSoHf7I1kXov+fOoEcUt3LzHFFmhATc?=
 =?us-ascii?Q?i5+prHNiDTmkGzovRVCPOiND3aXO+evFzs4h1FABneoR8wBMHzc5o5+a+eGS?=
 =?us-ascii?Q?juugTMXGNBbab9Gpah/G0tgJfcMgUWgCxVeb4N5JhIM7Swr7HWx2vX2Ndn9C?=
 =?us-ascii?Q?Zfo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZoTjDQ545F2URabuKguAr28eReaEU5UgrGeOq9FfNX/AhsAXr3knS4JKfFKD?=
 =?us-ascii?Q?rprkivXl9LuLKtZbhYShtFchsYySnk+A2SxE7IaKN7Ha/ON0PWv4yHVVWlzI?=
 =?us-ascii?Q?os0rfCigz+WC/Mfa2ZffMmBZ+1LlYO6wSwt1624+iHbcJTm5nFXjOUSd7fAM?=
 =?us-ascii?Q?KN9XfA+1hoF1QdQYnu1onx71AgLiipouyhZ1yZ3YQs87CZ1QXHvA0tdIyJdQ?=
 =?us-ascii?Q?3D2x3SODiGBGJvk3U8U7Be25mIVSDzMqFj7DshmgzoEa5bVxtr6E0xzuJWGk?=
 =?us-ascii?Q?zDLSP4oSh+mw4vJFLsbWYBzBQlRtzhrdo10hRec0Sx/yN0Zufmn6qZFBpdfE?=
 =?us-ascii?Q?94AU/gpyVTNfqhYWyFmkN2/787VYQAykdWDK+2ixGVnjeA45ZlUYldW/nW7j?=
 =?us-ascii?Q?RRioCBmog1IXklBiezjmLj0Tg6i/wtUyYRfkgp5e5cMCeaTvB9Vdw3FVWrv1?=
 =?us-ascii?Q?6JE0a9IMVBvx041eRzQpeB3saTTFrI3Hy9yxVU3ENme5jqXiF3gxZ10Sadnp?=
 =?us-ascii?Q?jssKXJt2a/dOiuLdIevRFjYFd/7TsQMnRqXkY4324jQx9Fb2uBmA82AhqtOH?=
 =?us-ascii?Q?QaPm07HqVdZaj0xVfU30Nbw6Kgdh0HUsa0sFHVssy8Ex3djUuKmvKKF0Dn9m?=
 =?us-ascii?Q?WvHNl0sVJbYCcHqsskk+lKd4FyLJ4gk6F0JAjwV7LLiwBUKI/QJRZp7vqroe?=
 =?us-ascii?Q?kVvGg9QFwAd+1NYQRAOPjhG6CF//IteQ9z4F4dpwaiKQHb7ROYkfwNGPWrbN?=
 =?us-ascii?Q?RJsl00IuHGtmsA1u7MzjzTjQR94VNjkW4HPKh1MIqrfXUXcEQJR2bLvnSTKP?=
 =?us-ascii?Q?2kOz0vkJW03MIJJMKy+RXjCoATyMwm2qd7ZoalfrNwZgG/qCY0qI27X6HnN1?=
 =?us-ascii?Q?wX930OJmxFQ3VybUaRFagJHy4yN7NmZYm/NjnKXMmv/sthKqERlPedJUZheQ?=
 =?us-ascii?Q?gh2AhENzE5q9snEJXSPFbEmlDwAe683VqiCLQh7unpiy5rpUtJI2Gmvom2i2?=
 =?us-ascii?Q?RcoBU3bleZYACBAb3j4sJ+YPIO01g0J5Zwnv14TRAnJjuk55pS0jnmSNaVdp?=
 =?us-ascii?Q?ELJXHCVRQoCphgqln9W6X3B60yUuoBh2R20nD2iGj16IBaYJBtwSasp0jnOO?=
 =?us-ascii?Q?KKmYuiDAHaZxctK1Y+9Tk3nG0w33VOWOC7MaJK/S8xHDGGGFlduWDoUiIGks?=
 =?us-ascii?Q?gx1tqFoSDhIfRtTn7HOTWfj157t1Ur5o2EVthdH5nOZCplvJqaLvoNB4lBCh?=
 =?us-ascii?Q?nMp3Ci3s0oLgW3OtpiBjvZHIdFUCusm/AyEjJMXr29DTbKl9OFJbEu8diA9f?=
 =?us-ascii?Q?YSW1h5swOGwEWFdpR85zrDm5vOuUBODImU+OBeuiufQAw5WF+KcjfNott+su?=
 =?us-ascii?Q?ap0XNugSB43LIMrx3FW0wYs+2By0W7+WdD3NnKSxTgcTirlkphuaCF1himbY?=
 =?us-ascii?Q?6rVk+l631ENRcxGWfgMM5kezO1PtLmo/O/Wjy7u6erDFWo9gyv760lJSbrlt?=
 =?us-ascii?Q?z6u51tz2mnYRsNLFe0VimpyCGihv/JRgHYORO5nQaA1FYYkA+dp1oFJr2Wxv?=
 =?us-ascii?Q?aomOLb0HRThe8qzX0IiV8U1IZiIoDIvxH1cKUp829AMsDpDEsmBn+QGEbQWl?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4b16f7-59ed-45d1-5af0-08dc9c36fe2a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:38:38.7107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Tas1FJXAVicVY8QNGMQat+A7WM76J4iKdQgc1c4IEVBGDY8u/1gGvYLbFO9XxxAuwFGgtFLKGZpwV/O0J7dOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com

On Thu, Jul 04, 2024 at 12:39:01PM +0800, zhengguoyong wrote:
> In sockmap redirect mode, when msg send to redir sk,
> we use sk_wrmem_schedule to check memory is enough,
> 
>     tcp_bpf_sendmsg
>         tcp_bpf_send_verdict
>             bpf_tcp_ingress
>                 sk_wmem_schedule
> 
> but in bpf_tcp_ingress, the parameter sk means receiver,
> so use sk_rmem_schedule here is more suitability.
> 
> Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>
> ---
>  net/ipv4/tcp_bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 53b0d62..88c58b5 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -49,7 +49,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
>  		sge = sk_msg_elem(msg, i);
>  		size = (apply && apply_bytes < sge->length) ?
>  			apply_bytes : sge->length;
> -		if (!sk_wmem_schedule(sk, size)) {
> +		if (!sk_rmem_schedule(sk, size)) {
>  			if (!copied)
>  				ret = -ENOMEM;
>  			break;
> -- 
> 1.8.3.1
> 
> 

From the commit message I'm not really sure about the intention of this
patch, however it seems the existing kernel implementation is correct.
Changing sk_wmem_schedule -> sk_rmem_schedule breaks the kernel compilation
because those 2 functions even have different input parameters.

Please see the Patchwork results for details:
https://patchwork.kernel.org/project/netdevbpf/patch/ae2569fa-f34a-40d6-9a03-33a455fbb9ea@chinatelecom.cn/

Thanks,
Michal

Nacked-by: Michal Kubiak <michal.kubiak@intel.com>

