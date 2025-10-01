Return-Path: <bpf+bounces-70087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EDCBB0C1A
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379047AF5CF
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D03025A33F;
	Wed,  1 Oct 2025 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ejakw7P6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FD1EDA3C;
	Wed,  1 Oct 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329767; cv=fail; b=jih8DK7a6dn5hhboOmY1iYj8Vv1Xv5dDUqE6wzXGfF2ibI1AXDloHbsmlmsfN3AIMeAjxU6y5ANPUQblo+z+2OVkSohEJYO+z7+yjAUv6nxiNtqUVMFy4f+DnbSGwpsVI8H3qKgEZ+BPXXwHK9Cl9WYt2HHkCZGAHD8drUG2NhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329767; c=relaxed/simple;
	bh=vF5jWCGWK2mt57oya/HI9d2fDmxPFkgZCL2xrnWWNdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=exROFZcfvVgFGYwrFDXWdV10mdSYpxRkR1V1j9J166ladcPkn3B2DNrfEDINY4YmCcQtQwsSLDzlLty24rANpTj1L3/VSVHL8KmpWgAMseheV5QFOMVrMsC4BLdNVz9pAPomRzgE4KW0RT6/X8LIDu0LOFjtWKhFcJAABT8ioEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ejakw7P6; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759329766; x=1790865766;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vF5jWCGWK2mt57oya/HI9d2fDmxPFkgZCL2xrnWWNdc=;
  b=Ejakw7P68Xr5PR7P1bF8l6KrfaZqGqxNLB5mwGaokeYjnfXxPR84wKZQ
   8fw8X6zbSWFkrwBHHd1IsnngxibRqP7veG2XePDL3+PFB8LCFwfaADsBr
   1JqjcGUl4mThwYmgxFAPAho7L2s9q5bCGz+KfD/kBLJX458O3lIYaMI3w
   Z6/vTwbGXJaY2c7zLSP/BSQ/vk9xvB/K45HAJIAXovkVxIwrnwOYh9lkb
   CFBSZx3+kzjS+NBT438Z5vbDB6mCktvU6DsJ2r0MewR0AvWiE6jfYYeZb
   IWfhkqSXlWPnjUePGGRrP2Rq5iXIgqTB6/obHUVFGbiWDGSnx46FMMGSR
   g==;
X-CSE-ConnectionGUID: mSCRXoisSwKA6+xTmSMy2A==
X-CSE-MsgGUID: yqsBEP9bTdWs/YYC6vEZSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61563165"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61563165"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 07:42:45 -0700
X-CSE-ConnectionGUID: Y3RIiXtRRsafZsgOACfR4A==
X-CSE-MsgGUID: xNi87avjQyqhMxLsVOQL3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="183980717"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 07:42:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 07:42:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 07:42:43 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 07:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1kZZ66Pl3DJbNgY05uLjlTIABUndXgGn2CIMEwr2xKGU+hA+tgLZsg7Tg/xied05coj71x26xOViq+gNnVGBhOp/vV/HDcwMkBq4xKmsCFJJIQ9OR/H123tH8tmq8bTF9zfpoCnSFVD8TYekXYmUS5y9XvH50zjwOTIRekeosCfRXB7fBlxk4gsYF6jhPN99IeV/V9a1mOV2sxDpAgXmkMRYG9G2lxLpetrYuCooYFjtW4+yMXOvPr19SX1bYC9DP09pzES2m2viof7Rnixqau6uFUpsJVzdR940lkV1Fpf/GdM07orLANOoAbH6rsrzADh7WRngaQYCGoVFR1Pnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja4uIzGyqz2De9pT7t3k9k6VNplP84LXnVY0+VJAlIs=;
 b=Y5EQAWdovj2jj82fLE28CWPmx6fi3u0oHdF776MXs1qHHWW2EGcY480bnFmmNuaTZMXTZMGPLW43VSZY9WXDUfSitKqhKKMnRlgxB75aLcTRjxu1fUNQsxG7eNv2fFWlV97wgr2q3KCWyg+TMFQYPN9KKsMg61yRBZDsMiPZoFeXJN6Y27nBkMqY0w5VrBD65Vi0okrrS5YtYVfrO21gGaXqU6J+OlhWD93DeXKpd1elUuHHdBAl5OTeXGahuCWMwLDqyUwx7zNvk0nkjj2EinchhkBXKgqjRLB7aOsTLybB5vQv0iR4e/FDO6k6OwA+4yg9Slo4bUF7jPAZoVtzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB4994.namprd11.prod.outlook.com (2603:10b6:303:91::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Wed, 1 Oct 2025 14:42:36 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 14:42:36 +0000
Date: Wed, 1 Oct 2025 16:42:29 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Octavian Purdila <tavip@google.com>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <kuniyu@google.com>, <aleksander.lobakin@intel.com>,
	<toke@redhat.com>, <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>,
	<syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>
Subject: Re: [PATCH net v2] xdp: update mem type when page pool is used for
 generic XDP
Message-ID: <aN091c4VZRtZwZDZ@boxer>
References: <20251001074704.2817028-1-tavip@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001074704.2817028-1-tavip@google.com>
X-ClientProxiedBy: DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: c62411be-ede4-4bfc-778f-08de00f8c353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UrMQgeFCW3JqKBNvWOigheFEtE4Bvsm+Ka0E6Rm6nmMbv4rzlSXpU6fJsTpA?=
 =?us-ascii?Q?L2IS1U2JsNQYjWuiAgaZGVvo2IPqY1Vy94UDAhhTyu4nLl1e1QDLM693ksjX?=
 =?us-ascii?Q?jaiM0jKYhUcUGmebwGg4fwqctdIm6eIxWNrHIbdX54IV+1zpWWk7x0U0TM8K?=
 =?us-ascii?Q?LQxpo1c+nLPE9u8SID5Kn+GyCNi9axKQCp4LtA+MAx5L40TiTQ2Lzcv7HHQx?=
 =?us-ascii?Q?z+PCf1KC+yde/wOqw2mURcGCDuf8KRGNuhnap+z3FH84VyrE4xFLDfR0+z8L?=
 =?us-ascii?Q?2KSRSOHNr//A0BdJJ0YR/hWwhiM49d7OaSWO5oBt0fX91DUtfFobOi2/XfY4?=
 =?us-ascii?Q?OjBTsC2CeLuwfSo7i3RqSa0F/QbgL08VU0f8rMlqIEoQCygty3FGNtRd8FUl?=
 =?us-ascii?Q?Xj488katxPxYd/0O/WvoCoQ89/Lcfg1T3xuwRmHIDEOeUWQY2h+vnk0iRsud?=
 =?us-ascii?Q?yO5MjsU8+zAesMMCq8M8JxiThlC9DRfYwvO3xfoAIMcr2kt5oN9mBDRFrAwY?=
 =?us-ascii?Q?yI0k50H7tVQrgXNUXv1gNeabRsYTDnZyLjBY/oRCRgILPVDdC+s1APRTf94t?=
 =?us-ascii?Q?loRWizF0GHsBsbnWEzqO7O4xre+R1DCCppdxSSPlbK98/rI23o0m/1n6feWi?=
 =?us-ascii?Q?3YhL/DHiuwpPk61AnXGWWFpdTGhccVYlVd9FuXYW9EQb5sc1xWrBuk2XqDIl?=
 =?us-ascii?Q?usKTpK99cQoLAeY+sdjh8TYTmnppwDlb6hwy/E3uLQjiayIirfCt+0ipSJr3?=
 =?us-ascii?Q?UlAscP2yjIRWp5v+3yxDLH19oi7GXxm6La0edKSXEeb4YkBkV/2rMGK+xhsp?=
 =?us-ascii?Q?u5o5Sei612cbA4/jqcFi2BIdG9qpflnWGiv1qx96NdMaddmC0gxzn8EB7bFN?=
 =?us-ascii?Q?GzBdLdwQ4mofic/1Z1KaddimaJrBYoA4ai5LjkKKkmqcTT3VZ6Hkdgp8PxMz?=
 =?us-ascii?Q?I4cFmqIFSZpLq8Vv6uCtMfSMSiakbQT/ujA7xffgyLB8Qwi2FhX9Bw5F/nse?=
 =?us-ascii?Q?uxaOg3KrTwJR0jXv8lNLIGZBSPAxR64xUXN0/TNJGSnnonoWiupUqxIMIiBW?=
 =?us-ascii?Q?b4KmnJCrgAHaRSrxn13nXU4AjLghHm7TphbfYEsRYd6hYQWD+lunXcEkHztO?=
 =?us-ascii?Q?yeh1fa6c5LwP+et0CE4o9F4LR2ci89UIfHVK5tI7KTfVPUd0JIt2T6JVHvVE?=
 =?us-ascii?Q?3RJd5w3RN35OlPuQ9xDbcsGfyQUaAUt9sDBkzWTpjl0/9RNnQXtUQ2Ihbak8?=
 =?us-ascii?Q?MPrU+atWpxRns1Sj8t0g79HngjOSVHXH9/RdQ+7szWddN3T+/jlSPhjco+ML?=
 =?us-ascii?Q?sdRmOVg5YTA+t68r9/iGLCn8YVxivHjBfZDmCAaik7s7r7yX4NWGFfs+Nywq?=
 =?us-ascii?Q?wZ104ZEnFJugNJ2nO414e8pPkqKJ92Qaf5LUj514V6hhw4Nzeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfaatYfyDKx0ZXDpZeMvHO3AYcpGz5S36oe4BEjTUBmAOsf5nRGPFgpIsYU4?=
 =?us-ascii?Q?Cc91YxCN/3JH3F0UHd7CieSOERh0P/+gXk1h3ceOhmcdOI1TtbUFIBe9wLf8?=
 =?us-ascii?Q?O59ka0vArUZ1VsVGXx1+N01nOInTwS0rQgpck3gjR89Riw4m2A49s7CSvBN0?=
 =?us-ascii?Q?g2zTfgKantoUUiPM9To2+9mPGlCdKLTFRBr6sxIwu7SV3CHeNhh9Um8m+AZH?=
 =?us-ascii?Q?7vOHOAE46bctXhqXmJ4G58zRr9YWaKY8C2lEt7dvxYf41MF6K5fsEp/iWkH0?=
 =?us-ascii?Q?O8c2KV42ijFOqlIo0DfAvn3+blbw8wL8TPewVtpPr9N+OS+6uCPBy6VPHAIw?=
 =?us-ascii?Q?3GWE5W1qdM4RSQBz/PZ2+qPYep0lDpDzdrsXmage9g9f3lzCUEvGFNZ7LjSe?=
 =?us-ascii?Q?mChgv43UVhRrJcT7UdByd5u44bu8Pqzr753735McLk1AqnT1YcD8n04Qu2Xj?=
 =?us-ascii?Q?23vTKWsFCEEIfS3nLuO4PxzcPS22JWVwmN+Y5iKIZqpLT2LkZUwHFEy64kc8?=
 =?us-ascii?Q?zktu6rSUYCGHinH6u+olI6l0LnD7aKhgkXQqDNE0p7z6ABZoyx/wOgA3/XXh?=
 =?us-ascii?Q?26wyNkZpHEOXruS94W+RmScumnAZJHiW0tudkygvPK/xzlA+tlSEdUfQxjUp?=
 =?us-ascii?Q?VjADqkmUqZ5RUtIadPUoYmYD8w1vu55rxuNKCNtR/a6V+iaCZaiU/Cj2lE5d?=
 =?us-ascii?Q?gz5Rt9p+1FS9ZVrrilK+5NYAbzS9OiUbhceQrlx1fDXfS4xuaf7tA60kDJf/?=
 =?us-ascii?Q?6gDPjI+7fNlr2pn36LDQN/w+gRDPNhvbL5FBmQSLlSyfMs0iGvOsoE+KidZQ?=
 =?us-ascii?Q?asiV75zrhzsKA+EKuqaHp11j6AU4Qmj7liuuRgFMacoUujYoXLzI5ZA4t+4h?=
 =?us-ascii?Q?NoQX0SlzYh6FcxcmMb3vaVsIWnHQVK1Biw+NE3bJbaeL07Jf3aCDUpzE2Wlx?=
 =?us-ascii?Q?ZULAZrouy4VhuQlE89HNmGGp+SL1Zcj0pLQMsuQtNurq/CW036wakYOEpHML?=
 =?us-ascii?Q?ES/oegs5xm4LaBql6GheG3Xoxu6r8VXbi7kQvmGAlTuBkqii9y9fP93PcHnB?=
 =?us-ascii?Q?f8RRWnvIJMy5nZq73kMgvAPdlfLSkvZGRu43LqczR6SzRsCRpSQJ5xJu6erk?=
 =?us-ascii?Q?jBwx9BNiYhoP95f6xjXtmaoh+f5nHqYXedu1+s42akMMVXH1XZJziHxdbOVA?=
 =?us-ascii?Q?GCBTk6Dq7ZLfQR1aRbXgD0xPjy/2c97hYMCFnEPJn+CBMHFzeIxykrl3i5Nz?=
 =?us-ascii?Q?I92c3m3Q6tELgCU7xdHIq/GXtX2k4PP+6dT+NZPH1i/Tb57ZNefxE5a35J5k?=
 =?us-ascii?Q?cFdoyMy47UgI2ClOMEuW8DbUUHHmWCL9t4I2CvHuHz9FgoRDLF6HBPqAPfU2?=
 =?us-ascii?Q?EEaZTDL+dDzRnvdPxPkYI7W0iWskpbZHoG8F3xMcL6XTw7zZ+4K+U7T0ech0?=
 =?us-ascii?Q?BWakmhlvp9EamLnhVtMOW5nvo/QidiZqxMA5XWbbRkTjQ6Me5NvMsrYmHIcr?=
 =?us-ascii?Q?aPPqZqMx1VgA1cireeUI20BBXsSu1IWSAm7LfGbh6GpHiaVwmZGyL5qtl0aL?=
 =?us-ascii?Q?JEM76tIRy/BajBZiabyC81WAJL1NvRYUbRNSL+1o9f4Ln1ly9rwkwzSOye2U?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c62411be-ede4-4bfc-778f-08de00f8c353
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 14:42:36.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqtSafx5y4A/PO8q0ZtO5zGTF7ub8DBGJ0KhIfckgt05+UWHPIkcwltlyFwbFgTDj3xYcdRNnfpm2edAozZVkFcgJB/f0kMbW7knC2Bukpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4994
X-OriginatorOrg: intel.com

On Wed, Oct 01, 2025 at 07:47:04AM +0000, Octavian Purdila wrote:
> When a BPF program that supports BPF_F_XDP_HAS_FRAGS is issuing
> bpf_xdp_adjust_tail and a large packet is injected via /dev/net/tun a
> crash occurs due to detecting a bad page state (page_pool leak).
> 
> This is because xdp_buff does not record the type of memory and
> instead relies on the netdev receive queue xdp info. Since
> netif_alloc_rx_queues only calls xdp_rxq_info_reg mem.type is going to
> be set to MEM_TYPE_PAGE_SHARED. So shrinking will eventually call
> page_frag_free. But with current multi-buff support for
> BPF_F_XDP_HAS_FRAGS programs buffers are allocated via the page pool
> in skb_cow_data_for_xdp.
> 
> To fix this issue use the same approach that is used in
> cpu_map_bpf_prog_run_xdp: declare an xdp_rxq_info structure on the
> stack instead of using the xdp_rxq_info structure from the netdev rx
> queue. And update mem.type to reflect how the buffers are allocated,
> in this case to MEM_TYPE_PAGE_POOL if skb_cow_data_for_xdp is used.
> 
> Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
> 
> v2:
> - use a local xdp_rxq_info structure and update mem.type instead of
>   skipping using page pool if the netdev xdp_rxq_info is not set to
>   MEM_TYPE_PAGE_POOL (which is always the case currently)
> v1: https://lore.kernel.org/netdev/20250924060843.2280499-1-tavip@google.com/

Hi Octavian,

per my taste this patch is a bit too noisy. I believe we could compress it
down to the following lines:

diff --git a/net/core/dev.c b/net/core/dev.c
index 93a25d87b86b..6dff28e98776 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5269,6 +5269,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	orig_bcast = is_multicast_ether_addr_64bits(eth->h_dest);
 	orig_eth_type = eth->h_proto;
 
+	xdp->rxq->mem.type = skb->pp_recycle ? MEM_TYPE_PAGE_POOL :
+					       MEM_TYPE_PAGE_SHARED;
+
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	/* check if bpf_xdp_adjust_head was used */

Here we piggy back on sk_buff::pp_recycle setting as it implies underlying
memory is backed by page pool.

mem.id is not needed for our case as AFAICT it would be needed when
unregistering mem model from rxq, which is not the case for system page
pools as they will persist until system is alive.

Thoughts?

> 
>  include/linux/netdevice.h |  4 +++-
>  kernel/bpf/cpumap.c       |  2 +-
>  kernel/bpf/devmap.c       |  2 +-
>  net/core/dev.c            | 32 +++++++++++++++++++++-----------
>  4 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f3a3b761abfb..41585414e45c 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -78,6 +78,7 @@ struct udp_tunnel_nic_info;
>  struct udp_tunnel_nic;
>  struct bpf_prog;
>  struct xdp_buff;
> +struct xdp_rxq_info;
>  struct xdp_frame;
>  struct xdp_metadata_ops;
>  struct xdp_md;
> @@ -4149,7 +4150,8 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
>  }
>  
>  u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> -			     const struct bpf_prog *xdp_prog);
> +			     const struct bpf_prog *xdp_prog,
> +			     struct xdp_rxq_info *rxq);
>  void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
>  int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb);
>  int netif_rx(struct sk_buff *skb);
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index c46360b27871..a057a58ba969 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -145,7 +145,7 @@ static u32 cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
>  	for (u32 i = 0; i < skb_n; i++) {
>  		struct sk_buff *skb = skbs[i];
>  
> -		act = bpf_prog_run_generic_xdp(skb, &xdp, rcpu->prog);
> +		act = bpf_prog_run_generic_xdp(skb, &xdp, rcpu->prog, NULL);
>  		switch (act) {
>  		case XDP_PASS:
>  			skbs[pass++] = skb;
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 482d284a1553..29459b79bacb 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -512,7 +512,7 @@ static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab_netdev
>  	__skb_pull(skb, skb->mac_len);
>  	xdp.txq = &txq;
>  
> -	act = bpf_prog_run_generic_xdp(skb, &xdp, dst->xdp_prog);
> +	act = bpf_prog_run_generic_xdp(skb, &xdp, dst->xdp_prog, NULL);
>  	switch (act) {
>  	case XDP_PASS:
>  		__skb_push(skb, skb->mac_len);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 8d49b2198d07..365c43ffc9c1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5230,10 +5230,10 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
>  }
>  
>  u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> -			     const struct bpf_prog *xdp_prog)
> +			     const struct bpf_prog *xdp_prog,
> +			     struct xdp_rxq_info *rxq)
>  {
>  	void *orig_data, *orig_data_end, *hard_start;
> -	struct netdev_rx_queue *rxqueue;
>  	bool orig_bcast, orig_host;
>  	u32 mac_len, frame_sz;
>  	__be16 orig_eth_type;
> @@ -5251,8 +5251,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  	frame_sz = (void *)skb_end_pointer(skb) - hard_start;
>  	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> -	rxqueue = netif_get_rxqueue(skb);
> -	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
> +	if (!rxq)
> +		rxq = &netif_get_rxqueue(skb)->xdp_rxq;
> +	xdp_init_buff(xdp, frame_sz, rxq);
>  	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
>  			 skb_headlen(skb) + mac_len, true);
>  	if (skb_is_nonlinear(skb)) {
> @@ -5331,17 +5332,23 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  	return act;
>  }
>  
> -static int
> -netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
> +static int netif_skb_check_for_xdp(struct sk_buff **pskb,
> +				   const struct bpf_prog *prog,
> +				   struct xdp_rxq_info *rxq)
>  {
>  	struct sk_buff *skb = *pskb;
>  	int err, hroom, troom;
> +	struct page_pool *pool;
>  
> +	pool = this_cpu_read(system_page_pool.pool);
>  	local_lock_nested_bh(&system_page_pool.bh_lock);
> -	err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, prog);
> +	err = skb_cow_data_for_xdp(pool, pskb, prog);
>  	local_unlock_nested_bh(&system_page_pool.bh_lock);
> -	if (!err)
> +	if (!err) {
> +		rxq->mem.type = MEM_TYPE_PAGE_POOL;
> +		rxq->mem.id = pool->xdp_mem_id;
>  		return 0;
> +	}
>  
>  	/* In case we have to go down the path and also linearize,
>  	 * then lets do the pskb_expand_head() work just once here.
> @@ -5379,13 +5386,13 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
>  
>  	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
>  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> -		if (netif_skb_check_for_xdp(pskb, xdp_prog))
> +		if (netif_skb_check_for_xdp(pskb, xdp_prog, xdp->rxq))
>  			goto do_drop;
>  	}
>  
>  	__skb_pull(*pskb, mac_len);
>  
> -	act = bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog);
> +	act = bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog, xdp->rxq);
>  	switch (act) {
>  	case XDP_REDIRECT:
>  	case XDP_TX:
> @@ -5442,7 +5449,10 @@ int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
>  	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>  
>  	if (xdp_prog) {
> -		struct xdp_buff xdp;
> +		struct xdp_rxq_info rxq = {};
> +		struct xdp_buff xdp = {
> +			.rxq = &rxq,
> +		};
>  		u32 act;
>  		int err;
>  
> -- 
> 2.51.0.618.g983fd99d29-goog
> 
> 

