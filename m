Return-Path: <bpf+bounces-35657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070BB93C860
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 20:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EDA282549
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93B73D3BD;
	Thu, 25 Jul 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="le7Ajx/u"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616AC2D7B8;
	Thu, 25 Jul 2024 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932317; cv=fail; b=sf0liLT82c5rhvA1WcocfxDboB4euHY1QBdYb9TPauxAMo6ev+XqEbO6BOgWV/QXypCW7rty95L8JLpwmmHUZ64Ux0ig+bGdc24nF3DRcQYkoqRuiW4BCH20fuiweHiH3HFdsShf/4bSzvNT5XPjULc63nHD6eGqA+ll3HBdWaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932317; c=relaxed/simple;
	bh=QVWbNvxK7+z6JOyw7v2Gl6J8UFVZNllVy/iQQOuCKb0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gykNKJksGqjm5JahyDCb7GJUv0LGgoF6iMJdMUOydwwhTo73Q2qcW7IlIJ0ajgKf1myFZr7DbXNiRbieKfPupjEkVW7sBaAtqMyPjW8Xm2/u2c4vyJx1/e/pXrQP2Y5YTUUiyhJFx9ie4hYFZMR5sYRvZqtbdsz7CIvGBMaacc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=le7Ajx/u; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721932316; x=1753468316;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QVWbNvxK7+z6JOyw7v2Gl6J8UFVZNllVy/iQQOuCKb0=;
  b=le7Ajx/uAEE7icDp7bh9r2qBL+RZLCaeQJouAgw+Sl+l+3N2U2JmU2pq
   zV16UmMyuD611xJ3hN4Aw6zkOARVQMVVXor0Z/9ac4nPG/2Wn4f0l5BSr
   5Jl+mb/JMP5tm7bEuTux+V0VORHQ8KlX5AksFk5qabCadkHI7x85cU+8q
   s7YT9L2+7cbNBRna6s6zTeHJRWPuETMWlO1yQbV9hmulb1uNLmvOrN+Lo
   /3r9hvxdQDhuMJLyyheni04uwN9RxXiD8v4COYtqVwboqRBY6mjEmNKok
   D2IB57IFG4uuoGMkckrTdQc3CkxCiSV9/StAaia+wqGurRdd6PR6Ya1DP
   A==;
X-CSE-ConnectionGUID: zGBbZAoQT2u0lgtHEcy7MQ==
X-CSE-MsgGUID: ZqCXO7JRQvyuhvS/euhsNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="37155906"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="37155906"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 11:31:49 -0700
X-CSE-ConnectionGUID: gK6suT+VQCOIg05/JDZoHA==
X-CSE-MsgGUID: TSYmOMxCRpKb+I4y0mkrng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="52939634"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 11:31:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 11:31:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 11:31:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 11:31:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 11:31:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bbnqe029Uc0IDssst7ffluuwU3zmCRaVUCNW3jpoeouty30PsvPF4/i2Iqx8aydPOyq2ZpqXrcpqOQQiNtwI1bbAJN3oC6N+yAIsnceGVkUygJRLfCvwpoTgcKcLmBlpx2dV8uGMGXER8TSjjx7qiUuSCif2VxlV1sm07OM6YoLJ5s2ZftWJesbj7OhH3zISKPoOh+Fs7vaYhvevQXn0jDu7S/s3uFwCC9Wd5jQkPEfNO2uFJlg2PrnzGitW40afu3plAfgazmRcNlIDLpWWQ67ebu86WUOXYt5YvlN5xa5YGp2FvHIvV/UubKFw1eWW9VePQrzcYNhlI47ZNugODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fEyIKtT5sLZiWEjwWIOFCE0Ug8p8dM2ijWcfaRaOcQ=;
 b=BVnb2UaNKgcnwHi/UHgjyIvr+ULqLK5wEz3RZpnQI8VoBIT3PVRCG8b2ll5fsU1N8NN7F9iKv+blastcQWEpO2DjklVgsvot9BAaqDqdF75dKg3gSCimcd5p9kH2B0wkHSV3qmU2yCCG2Ob5lGvDEkh6qQ5QU1lf9OSJoFoSd/ERRoUYCAPu5JjfyZ7stMBrjcN90ljQYx3ECOFsRShbZMTAWomHgYssZECLXLLdy9nFO20OAVh6+L8cnfoGfx7+765bSpmnwj4DpTmUXISsGfRvBO0J4g33NXwctotMWT18yXla/D9A62CMejp6atDV0suq1yy4aR1ZrWwBIiDOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4800.namprd11.prod.outlook.com (2603:10b6:a03:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 18:31:44 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%7]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 18:31:44 +0000
Date: Thu, 25 Jul 2024 20:31:31 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <aleksander.lobakin@intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Shannon Nelson
	<shannon.nelson@amd.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 6/8] ice: improve updating ice_{t, r}x_ring::xsk_pool
Message-ID: <ZqKaAz8rNOx/Sz5E@boxer>
References: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
 <20240708221416.625850-7-anthony.l.nguyen@intel.com>
 <20240709184524.232b9f57@kernel.org>
 <ZqBAw0AEkieW+y4b@boxer>
 <20240724075742.0e70de49@kernel.org>
 <ZqEieHlPdMZcPGXI@boxer>
 <20240725063858.65803c85@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240725063858.65803c85@kernel.org>
X-ClientProxiedBy: DU2P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: 512a2854-96a8-4cbf-ed29-08dcacd808b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QZ0pV0hi0P62G4IJTEdrcA/pCYDnoaY89W/oTW+ptlAKib2OpeBRHqBfeGGi?=
 =?us-ascii?Q?nQkexqeOebUWyVkKX65zg49TH20oV8H0fShs6KGDjc1ugGviz66X2JPAxMPw?=
 =?us-ascii?Q?hOqJ2NI9vPvY5NMsvhCGVMC57FwBPqLmDWbdhBYqgX7L8baPjFaPDz87ksUk?=
 =?us-ascii?Q?2cTgQBzaRtH35q9CpRHZ4avLPbFJv5rXbRK4+VaRj9aiVQEl9DfRDC705Vu2?=
 =?us-ascii?Q?TlNlmQ3rlBJ3rdk1GBiDkKeHzWP7ADHAsOwsMLVNhy2eM5oYnxmsPEKtqnLq?=
 =?us-ascii?Q?UlfTX7SkGaAeO+Lg9MDaqugmqH8xKxL+bEu80BIrnbcOhyUOcHs9raglLPOQ?=
 =?us-ascii?Q?nxhbL/doDjOYsODnK81ElAL5JjAJlW0adOSZpPMMFv0JYeR2TTLmwoX7cM6A?=
 =?us-ascii?Q?FOUmCbrlKL/Ju9lQ48Z84fjXajKl3E6FcGFCC3v8N5ctVvoLjlJTl/uIkkKm?=
 =?us-ascii?Q?/oVkRk15ix7yYB7TyMYiANE8n15jtaZHpJ7c1VXD2fHWyWIjuE9BHtUG+erg?=
 =?us-ascii?Q?pnwyFNJYrzI4WruQd/dJps7gbML7okpNKoNCU2Mw8maLBJW+PuvIfVkR/3X/?=
 =?us-ascii?Q?5yVo5Cc+bLZDzTs3FMm13va9AOkCMwvMh23Iz155W2RlvoTqvrxmi87JVOWy?=
 =?us-ascii?Q?3RAqdS1TsV8FkwX2i9rrvcheCIef0/mnm9diEyOylUchogay3mAyRrrkA7mD?=
 =?us-ascii?Q?rqtiGehPgfy5NfGQFd7lAxJZYDZ9DnW91i5mvnvKptJ0AWt4Vr16KGvfWY0e?=
 =?us-ascii?Q?+sYGsFkVG/Q0nzg8NSLnoohd1CiHOfMz1TMIDaLO8NAotlo+3DeXtliEa6uo?=
 =?us-ascii?Q?O/N19k2xhOlAMnyYp7Bs3QuKPbwge9etqdoMg/2XrReivCm6E3oh1ZHsKd9m?=
 =?us-ascii?Q?Mn3c8TpPtLKcnlYxB/loTDD0Joy6u3mM4SftuCTgOY7pA0f6Ol8Ay1th1RzF?=
 =?us-ascii?Q?+b96u5SxaP2ZEW+Ql5YbsYLd37uTEsIX8QWLffkFNGgzEc/sNWw39MnIxeq0?=
 =?us-ascii?Q?k6CzpqpSW36xgqUy69/5upr+wDiykI/C/4vnlbaQry3A9Z+2URtynht6qoQV?=
 =?us-ascii?Q?0Umo4yULJCkWzHy2np4DG2O5w/06qw87WUTHEM0EPjtpX7WbwrQ+zl/IjqhC?=
 =?us-ascii?Q?9H8BGfdC64U9m+S6km+CoJRzqLx56kADck/NiOOnKjp+OhGaEw7Pu9KzEYtV?=
 =?us-ascii?Q?LjqeKq1TzG1qK+Ep/fDvl5GuRgmq5cvUKtj97qrTpHZKtnaK9iWf8ju85d90?=
 =?us-ascii?Q?hmq7NzprQmokVvBwTKWedyxJPz+/GeYWpN4swX3zO5+R95yAkf8V1JJIi32R?=
 =?us-ascii?Q?02yVLNvtLpafj8kJFGM5AuEOnw/hvjPZxluyK/mCqx9p1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vg6AdGFdO5Svbgu7EozdEk0Aj1dgQwSaf4og46RnzEhN5eefw+pqn+SxXkLk?=
 =?us-ascii?Q?r+MsDnqZznYGCXuN6nROwljvTeB+RxLhdP/5ZHh4ZvSxAPbRPGSqEHgVx944?=
 =?us-ascii?Q?M+jEz2npjMCBjPg6X6AEuAgAEJoOHftqzAWSWboo5zctAwAbejJ4HnWNFERu?=
 =?us-ascii?Q?MzUoTC5+88L5JlyMShOUC5svXyegpAeL1SwhU6ZJXKOcs/ku2NeaWAOCbdMo?=
 =?us-ascii?Q?Ghrx2kiORsgiqGKetZvG9/kqeFkJwUnwtXeTRq0GRXgUeZdAHn1QTOqpF9PR?=
 =?us-ascii?Q?Gxt4oa/AQE82ZEymQyZvB2qqfVk4Zvy8GxTS8c/x3kDSk4Ojh1tqZS3g+PzQ?=
 =?us-ascii?Q?px8YHxtGDQnwLZdkRfgEynuDSsVWOFp8y5MIBBzMhGN/RqsHJDQLOii7lhMo?=
 =?us-ascii?Q?LC4LVGGZKf5VbPVOrthrML0xjgp3XAHj3jKZIyi2knIZE6nfyhlTrsSGtei5?=
 =?us-ascii?Q?krGYioepTehlBKDwADqjbwR0jZ1ornf8Fu/2MEVPQyO3DYly5rTHgmCW17xg?=
 =?us-ascii?Q?0p8lmpMLvcObAHgMeY1r3iNsQ1/Uo6mZGlLGV3+eqWghlTyOkYAFiS3gR50A?=
 =?us-ascii?Q?qjOgxj4M5a/sWq9c0daXGLryATS6lujqvkZkVKiWmsLTCmj8j10pJFltQYnR?=
 =?us-ascii?Q?QxjTZS95OJjOrEVnii5I/l/NEsrtEUA/1nbti+uOVWVfaLwp03r//Xhl/LaL?=
 =?us-ascii?Q?kj+zF+LIU+b4XkVecSklDgbVyHAeLXu5KciStPjsoIBZSSGm7m8/LjmuwHd9?=
 =?us-ascii?Q?o68MGB1vnVnmpwMUg6yWOo921V3vFf0/X16EffpTfXvExOJI21Ong12wyIzm?=
 =?us-ascii?Q?QXxHKgnYrJL2hj01TsaDO6lpP3N8o1WO4s5pm65xoLf+XG/+XWImRMVGBnvD?=
 =?us-ascii?Q?vY9jBExWZaZKRp4Lbfj+PU97GafbWzvrsBGBoCEG9n2ft4agK5j8nPHGIkyB?=
 =?us-ascii?Q?W28JA923RymLdSed3BDjIjGfexAaVHPyr6XjO9K3Y8+NwC+/C4DB/O7mB2tI?=
 =?us-ascii?Q?ZaMvXlBTwc7ruTdEUjJ+i1tAruAECaPOxPoLOjahQTjybhg0ouell+CEJMFK?=
 =?us-ascii?Q?diknhdPeN/5CfALoT/dUTB3bb+Jt66MPlgtlD8gnZHnlOFEQbI24QI5gFnB+?=
 =?us-ascii?Q?W6fE5Rg2bDO2ylVg/Vd9Lm/k9/5wpPbGjag0vhXpA9TQMiBrU5rIZ8I5AXnp?=
 =?us-ascii?Q?yaPNEmUH6fvUi+a4JQzdQSgojxkRI7VPS/WIESFF2DeX6bAeJ4DWL0n7GxVb?=
 =?us-ascii?Q?lKboFZ8aooTPVWG9e8naoB6YN7tgorhCqsQQd+WQ+vicMB1DZIcVClIshUse?=
 =?us-ascii?Q?2jHUNwZI8WM1GsVc2fGk00XStoPidtF4Qxv3zis1cARUB2jzIewP1UF+53HC?=
 =?us-ascii?Q?k3MMrU5Uj0rRdb0n3U2fe+/uBnvk77VD3tHGqGT357yA4WRrxhwj5OJSZBlX?=
 =?us-ascii?Q?lOaO6Mhdja9uLmlunkUEUHp5mDZ70QJ9XC/hPzrxPj8T04eQkhVqKitSElB5?=
 =?us-ascii?Q?t+F9tz4qe72EI0703+Ed7PpYTGxpM1Z4HOxQV7ydL5t09h20N48zQvYixgcZ?=
 =?us-ascii?Q?nMJaRE8wXP8qnnyoywh07LkWRYveMpLpvxLZSO+JDxv/ibeYe8Vy//Ao6XAL?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 512a2854-96a8-4cbf-ed29-08dcacd808b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:31:43.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyATC9xdLoJJUNA6SppJ5tKaTGggj5saEal5lHVWsorfv4iaZfzmcbycWqFkUGD+W6gDmRlfueqqX5CQJ/isLCUnrjkCXBv/nJ5/UXQOW+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4800
X-OriginatorOrg: intel.com

On Thu, Jul 25, 2024 at 06:38:58AM -0700, Jakub Kicinski wrote:
> On Wed, 24 Jul 2024 17:49:12 +0200 Maciej Fijalkowski wrote:
> > > So if we are already in the af_xdp handler, and update patch sets pool
> > > to NULL - the af_xdp handler will be fine with the pool becoming NULL?
> > > I guess it may be fine, it's just quite odd to call the function called
> > > _ONCE() multiple times..  
> > 
> > Update path before NULLing pool will go through rcu grace period, stop
> > napis, disable irqs, etc. Running napi won't be exposed to nulled pool in
> > such case.
> 
> Could you make it clearer what condition the patch is fixing, then?
> What can go wrong without this patch?

Sorry for confusion, but without this patch scenario you brought up
initially *could* happen, under some wild circumstances. When I was
responding yesterday my head was around the code with this particular
patch in place, that's why I said such pool state transistion was not
possible.

Updater does this (prior to this patch):

	(...)
	ring->xsk_pool = ice_get_xp_from_qid(vsi, qid); // set to NULL
	(...)
	ice_qvec_toggle_napi(vsi, q_vector, true);
	ice_qvec_ena_irq(vsi, q_vector);

In theory compiler is allowed to transform the code in a way that xsk_pool
assignment will happen *after* triggering napi. So in ice_napi_poll():

		if (tx_ring->xsk_pool)
			wd = ice_xmit_zc(tx_ring); // call ZC routine
		else if (ice_ring_is_xdp(tx_ring))
			wd = true;
		else
			wd = ice_clean_tx_irq(tx_ring, budget);

You will initiate ZC Tx processing because xsk_pool ptr was still valid
and crash in the middle of its job once it's finally NULLed. To prevent
that:

updater:
	(...)
	WRITE_ONCE(ring->xsk_pool, ice_get_xp_from_qid(vsi, qid));
	(...)
	ice_qvec_toggle_napi(vsi, q_vector, true);
	ice_qvec_ena_irq(vsi, q_vector);
	/* make sure NAPI sees updated ice_{t,x}_ring::xsk_pool */
	synchronize_net();

reader:
		if (READ_ONCE(tx_ring->xsk_pool))
			wd = ice_xmit_zc(tx_ring);
		else if (ice_ring_is_xdp(tx_ring))
			wd = true;
		else
			wd = ice_clean_tx_irq(tx_ring, budget);

Does that make any sense now?

