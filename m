Return-Path: <bpf+bounces-64348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49204B11B70
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346D85A48D9
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EFF2D781B;
	Fri, 25 Jul 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0SiqKXB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75E62D46C4;
	Fri, 25 Jul 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437647; cv=fail; b=YexSKoyVezzadZwzU2PYjaQRLVHjBz0t/Xr7ltrZj1PBK3/I451pDW2YS/hF1CDSLz8s9dqsUgd8zbg4qV7uxOXrpEN5dw7+kwylPakTUCQ81BiBvG8/P9do2PdAWphobRb11rHjQ5/BA6zCE520kPanL36YGIYoAwJSAsnd7Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437647; c=relaxed/simple;
	bh=ZuQIsONAhno9Z8WVPM+M85CpCG2l+xuobEJ4spXu5kw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b/104pChOmepuHj1lgl7wTFa/GSBfYRWj74RJs7Fa1Fe2mwfLj/M1GtjM/4TIriS1ymv/j1dwL41LE6xPcJteqp3nyjx8YKIANQmT3Jm0J2nu38D0TZhJsoUh1ytosj129QJrgy9gu591+pGyTS6ErrJoNomVnGCpXU55+67bfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0SiqKXB; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753437646; x=1784973646;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZuQIsONAhno9Z8WVPM+M85CpCG2l+xuobEJ4spXu5kw=;
  b=O0SiqKXB52x33giBY0eF9KizYapBIVTihr0+PkFcXO7BmwvdIloNbwdR
   TKzDY8rsNiqbyxW0hvEuq1s6aN0bD0IYbko64Ju+ZcwVgRGMLj3fwGQIc
   yFY39sq2ldoSZqhu4JRT/tIBNo/YYR7gDT47gVWjvIOH6yGB5zoMTgyKm
   jmp3XpcnaVzc+CBSqxK+PTwow/hCn9swAn6eRjQob4XOfMgO3xLa7j7u7
   D2vs3PZQ+M7PlTms+9vGWqiqZwBVMnFrs9QtSh5+vUyQP911xvGwcxw3m
   ZFD9cL0rWbyLzMY9EgdSanP8+XPEHpE30MgzD5XEQX+S+PD6czmvNardZ
   Q==;
X-CSE-ConnectionGUID: /sPRThsmTTGybvuVToDWXA==
X-CSE-MsgGUID: eWLhrnfvRBK2VuAyA3oHug==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59423627"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59423627"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 03:00:45 -0700
X-CSE-ConnectionGUID: LJeFUwoeSweEexpVj2GUHg==
X-CSE-MsgGUID: x7um8n60Q9e/JJvMezcEAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="197978224"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 03:00:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 03:00:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 03:00:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 03:00:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cG8NYkJ0VqdOiTGZIjRRfw4BQBJxzS1ADlBchCL9waVSnqiZmWpL3yktHxLBJaeBWwa8WkPI90lYwafAPeA843P3ERMp0hRTlFSQwHZLhUTdjDvs5azl7yq3n3LT9pYLuVDV7h8Kkrt9M5TF1kZJpw1JBOAo4YAAaaua2oIX1E6t4lo4gWNfIHbgK0qFEnTFLhdc/CwgXhcvxfjJgZ0P2uslHARgCD/aMINLeoyJBXE3ks66DwPyQbdBDnkiEYARK9FVg68Us6Qf9K4YTbjTlQHwcMzC0qy8bkyzzWglWDJ02zVCJT7yMkRpflzaEr+itUgxg/0zVyr7M+v/jkQVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaXGTNeuWAcglbpVKL7QQcyQni5GOO6xIrwd3LtqVls=;
 b=fCjzaMf7DEcsw0jA5eKV9gxgkPetmHWFzbE1X+gwv/EOXYWJCQa1OQ/Par4MllDnUk27/UMzWbaRQpCyt3/Na809r2tMDbK4Ww0AC+1WjtsfjylbvMhorv2aNsAgc2hAmY6ILx4VXRqXENrwqjgotW8vLAq+bgxw2/FZUAFGHUYd3QWRPHh6Irr/kr0rsIgMQ1dozZ/xgEmDpa8vAIoX87dMzlDfBMAexpVnaBae7RuGaYvdp3uWsznCcpfnC7B4+DpzdMo5uVYRCwbc1g++s1mZ0tYHXa+WmG2Ewu3+T7yFDQxYD8N8lALGBbULKCrt8C2qtsshut5p9mP3CdE8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 25 Jul
 2025 10:00:29 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 10:00:29 +0000
Date: Fri, 25 Jul 2025 12:00:12 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>, <sdf@fomichev.me>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH net-next 5/5] ixgbe: xsk: add TX multi-buffer support
Message-ID: <aINVrP8vrxIkxhZr@boxer>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250720091123.474-6-kerneljasonxing@gmail.com>
X-ClientProxiedBy: DUZPR01CA0112.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e27564-20a3-42fa-ec58-08ddcb6215d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xrl5JliDnloKOHRfj3eG2FaZ/0nnOx/pw6e/PIlDq2oOkav+tdNO3QJgl0yW?=
 =?us-ascii?Q?KDk046wLgwQ08yOgHnqVD59IT8ICj9I8XcrbGCo2dfoRKoQ8JaVnpFBAgdZG?=
 =?us-ascii?Q?JabkbsVRpHb+DUcmVVmJ9U+aUrf01DjdteMC3ZIdVKUYZFwfIXAp8Itqk96S?=
 =?us-ascii?Q?WgW2EHnD3nk5cUA4yw+y4n24pyUuKdV/MNRzjwCeF/I3zO/nKf4YvO8gyFl6?=
 =?us-ascii?Q?ZUBcclysWy3HCkqor+TR2ZOR9Ng0u/aEV0JRwHsMqKfqEg03Jgq0Q/6xsJo2?=
 =?us-ascii?Q?Dh7FLa2kl3o+ptlsm6q4mVVyRsSbkcgBSXyQX/T/3aDkhAsDWDCcqECevxMJ?=
 =?us-ascii?Q?ALBCNd4RDkGv0QzovbXoVpkqa4Rte79kzsW/m/uSZDskF4ZqEDf8sbJqLVfo?=
 =?us-ascii?Q?15KrJdapxxwpC9Q4umKeAB4kNML/d9Ycj9P6mS2mcDQvqWiFljIQFaTwXX1s?=
 =?us-ascii?Q?jg9SNNrZFAcFDgsVxoGs1rKenc0pxPZlOjJ3Y7cjuuw9I8sPrELvAX7CTWmM?=
 =?us-ascii?Q?MDhlRjVAs79yFVlC32pCE8GtAB2Hx+uD53PY+ip2JETjHI9N/u8uIo38+XCA?=
 =?us-ascii?Q?QWM20YElimCrvwnzAhRJvCI2MigNbG/dCcBWGeUSop6akSJgeMmdo185YE/o?=
 =?us-ascii?Q?JWtnmepsiKjrD7OqdrHNsU7eY2h2ME1H3xlOwLXQnsblwQth+4j3F6R4O3ZE?=
 =?us-ascii?Q?oPZ2lXG1kmVDAVBhniwBqo4vcRJzVgYWKpRX6CA1nLlwkTC80nZQo5htzwrw?=
 =?us-ascii?Q?vMauUEyJfLCb3cWxHh7tzZ9Iq7w4BCMF3lEBc73TqQs5uZdvIelbbAsEFxmU?=
 =?us-ascii?Q?kcmjVjoo7A+O7krtNEZavOlFS8pQWLIaNJ6kxbsCKEa5Hvf55STJAyvY2tJR?=
 =?us-ascii?Q?Sx5lqaCZ8t3/3usKnIbpxQecXiq4/acxcz4yt+J5/3wqqZ2BCRDcW4rjZwOh?=
 =?us-ascii?Q?bf2BJDTShCVVbaiqB//PKmYG8j7IkBRaaxPVFf7iKhfrkiGW/SyvrH2SGuFF?=
 =?us-ascii?Q?gKsyRFtZkiv2HyISrH22rMYZFV22c0+FZxTq+dKNSvLrvEBYB8pmyM7NaYzJ?=
 =?us-ascii?Q?slVVEf/sAYEpq5X15Cmv2dTI0eTccLouKDiHfegDaalHJKYnnAz06SVyDn56?=
 =?us-ascii?Q?Kee3TRQ3lHKgtnQdoNx2uVaIauoYQaxoy/6pSt0mVxJNOSUVFUKdgyGSurBw?=
 =?us-ascii?Q?hNx1K/vaiDky7i9Fm3UvXV8ENbPdMpBnE1abfgoceHsfKRTJGmR0pGbPPfzY?=
 =?us-ascii?Q?jN/dWX8Z7CbFY8HRlC2TIQ4lfMzBhaS0zUv65ZD17+zUt4L8hOLuND/5j+2a?=
 =?us-ascii?Q?h/htfGxojALixiCyizDAPb2s0eiHrfw53cL+meYQrL0JV5E3joanWDjvbPq9?=
 =?us-ascii?Q?lWuLQu5QLCTlngmnGqimmKbi11BbU5jHrej2X+VspVWtxbUpM1+SP8rJXB3/?=
 =?us-ascii?Q?qJYODjWlIls=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HUZwUXK1Adsqyj2EMAWM+dg3E7p1wftRkojEXFsYBaFjYLhggtEA37vjZsyq?=
 =?us-ascii?Q?GJk9xKJJJ4w0yxFr4AHYH95HwTayY3DmYAJI6TPi3Mms4nbmCA0p3jUe/mY/?=
 =?us-ascii?Q?QJiihYKZ1CezsJQELD+vFaet3tbZTy3barlUC2BL8W4P5MJBnamPJWTF0nM+?=
 =?us-ascii?Q?/eY3mD9rJc9wSYPzkyHVvTvcSiSnOi3H21feTsPfZ6RTY7owQIkBbyjm/Tzm?=
 =?us-ascii?Q?fgbuKJT4m9IbP43Bn4XSHc+Y0w89v4vNNil6Dt2PCju7akGgBKTHrYp9Pkjq?=
 =?us-ascii?Q?+vkhYa0ZEAx9ptmM5r17PX3SWA7wfaUsNWxDFFjW4/WATVSdDkNG0HMLph/c?=
 =?us-ascii?Q?BDztLe9tpEeXZT4TXe6TzGq65y4rStVPtcF9lxTM7odr3iSotdGEF/omK/82?=
 =?us-ascii?Q?o8t4Ef2b14lkwgg0um87A1CApvQlzmwrclplWMoGYIbarEd7kW/5/AB4MYb9?=
 =?us-ascii?Q?h513T4AHbWR1WAH/O18jw9AiBgfvTQO5J9woyIjRgJ7on7T1rPUNTk4SKifN?=
 =?us-ascii?Q?bdtx/6C+WnB/v067a6EifpTs0/6UuJqrBYfhFsmYCd22dOOU2mIL1wSdFdzL?=
 =?us-ascii?Q?RlUxRtXf+nP5w7Z5vjSuOAjNhuO1kURrjOubb7uMBe281IOarT0QTc1QVJCl?=
 =?us-ascii?Q?VgX94EqGe7CmqKSPckXnI7trL2U1/npnS1IWaKcjk7rqQ7LX3cyCQBijP09R?=
 =?us-ascii?Q?VkquPl8gRIzq3nuommlZ7MKRECq22wpeS0ay7MdBnfgwhPEyD3SVpdENEqQZ?=
 =?us-ascii?Q?n0ZBNrZYmRHeGlJ9hz90sXspgQEWPAr/6KhJq2O/LYhHCk82VhJkQdsBSlK8?=
 =?us-ascii?Q?0Kx+Onv/1d2k6QX3F6hgdkKlT4Tdp9ocr9l/ozB3gCcfsZi/zbcj+Dh0CiHa?=
 =?us-ascii?Q?CmbJWThLm4deWXm1P1LpHDbytIhRAI86X7z5VQZI1xCxJeeZ96HWM550ehNd?=
 =?us-ascii?Q?Viv8Kfo8vUCd1iP5eO6nj5zePrD8FTGN9ZCkcSPYTpS841lSdnv2PjumQlij?=
 =?us-ascii?Q?a4adq5edcUgmpd90ErDNjhDSBKENAmRQbdW+0tI/EeVq+s99Y0ThXSCnW/G9?=
 =?us-ascii?Q?DZysT6z84h4AVoQZxjb543Xp6Nu34tPxMXywEtQqYC3Er7tTYFUPZY3a7oUZ?=
 =?us-ascii?Q?z0d11vu21i5IeIVxQmUid7gkKmB1/JnhuN1E+SxN1JCmaqAWR1nWAR9nsvwY?=
 =?us-ascii?Q?tftGrlqS9w4Lp4khyzTvUMmvJRHZrZpT5j5UnRmP+eNk7eiAZp5Bthv86iK8?=
 =?us-ascii?Q?DGmXGvgZf4OWIMAA21pYgMuL4tnSVo1/JH8ibWOnlW/YCa4zzVWNcFcUL+zd?=
 =?us-ascii?Q?FLHmpDjOuThLXlDueKXVCoY5xxq40Y8LY8CqeSisBnYahVDLg7gGiPO9oi9C?=
 =?us-ascii?Q?DjzVS38VS89hGClimeTiN344gpiq+2WCgdnbBcKWj9v9vODYINMx2dmgL/fF?=
 =?us-ascii?Q?KcbECc5w5aKBHajXQfa/8WMNDLsbt0VOl9ww4wt9W9lgvdgLLqTpaDKue186?=
 =?us-ascii?Q?gqH/Z1PK/v9xFUO+xEWqfF4HOuBlsNBFdtE+SQTznXeFd3qyGNcQYkSunCvc?=
 =?us-ascii?Q?XD8E+9W+pTt4xbBQHsuetlDwJsA23daPqlT7i9foSCWhIqj75kfF7szsa7gD?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e27564-20a3-42fa-ec58-08ddcb6215d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 10:00:29.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwkALPZ+koJXPifuu9qJf3luyCLH+vVFPI53DggjjX0DBAYpZkRycTiav0Z7ZG0Vni9LYZfpOucV05911JPaQnLiDcFhkjamKCdw+/bkzcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-OriginatorOrg: intel.com

On Sun, Jul 20, 2025 at 05:11:23PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Use the common interface to see if the desc is the end of packets. If
> so, set IXGBE_TXD_CMD_EOP bit instead of setting for all preceding
> descriptors. This is also how i40e driver did in commit a92b96c4ae10
> ("i40e: xsk: add TX multi-buffer support").
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index a59fd8f74b5e..c34737065f9e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -52,6 +52,8 @@
>  #include "ixgbe_txrx_common.h"
>  #include "devlink/devlink.h"
>  
> +#define IXGBE_MAX_BUFFER_TXD 4
> +
>  char ixgbe_driver_name[] = "ixgbe";
>  static const char ixgbe_driver_string[] =
>  			      "Intel(R) 10 Gigabit PCI Express Network Driver";
> @@ -11805,6 +11807,8 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
>  			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
>  
> +	netdev->xdp_zc_max_segs = IXGBE_MAX_BUFFER_TXD;

Hi Jason,

nack to this as you would allow fragmented frames on Rx side which is not
supported even with your patchset.

Generally ixgbe needs some love, i have several patches in my backlog plus
I think Larysa will be focusing on this driver.

please stick to enabling xsk batching on tx side.

> +
>  	/* MTU range: 68 - 9710 */
>  	netdev->min_mtu = ETH_MIN_MTU;
>  	netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE - (ETH_HLEN + ETH_FCS_LEN);
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index 9fe2c4bf8bc5..3d9fa4f2403e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -424,7 +424,9 @@ static void ixgbe_xmit_pkt(struct ixgbe_ring *xdp_ring, struct xdp_desc *desc,
>  	cmd_type = IXGBE_ADVTXD_DTYP_DATA |
>  		   IXGBE_ADVTXD_DCMD_DEXT |
>  		   IXGBE_ADVTXD_DCMD_IFCS;
> -	cmd_type |= desc[i].len | IXGBE_TXD_CMD_EOP;
> +	cmd_type |= desc[i].len;
> +	if (xsk_is_eop_desc(&desc[i]))
> +		cmd_type |= IXGBE_TXD_CMD_EOP;
>  	tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
>  	tx_desc->read.olinfo_status =
>  		cpu_to_le32(desc[i].len << IXGBE_ADVTXD_PAYLEN_SHIFT);
> -- 
> 2.41.3
> 

