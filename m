Return-Path: <bpf+bounces-74999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A0BC6B456
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 19:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 17910290FA
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470882D9EEA;
	Tue, 18 Nov 2025 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9WVoQf3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658620C48A;
	Tue, 18 Nov 2025 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491547; cv=fail; b=mRNhVc/wJBFsW3zRdiRVSwyRV7OH5+MigK5ZwB58pC3wDs3ZRusoxn0aYfrwye6vPqwxuli65LyA9CqPshVp5dGZBkXgNzDHjZe8sToYezhVtyyLqV4ZrHBMNWHHc5jIyV9b438QHjoYwGAWcwaTbRNaBlx2HGvva5dz2NOOXaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491547; c=relaxed/simple;
	bh=SOCNag4nV2RySpFVG4u+adwh1stm5PIApuhsOuPeShE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eBLC7QwsfHOscQPb7HUI34UkbreOdrVF/vEWVqz/hmZVi8tujnAAsDFXTPeovuSvGP1PvvT40If4n6eTYWp/1iR9CXe+muVljC09PUPOyOBgojS9o6OMsDTBH29loKlCXFYd8yuOKQKtWQGDrR8YwOnZmur5KZP7tQKyLy2xgA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9WVoQf3; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763491545; x=1795027545;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SOCNag4nV2RySpFVG4u+adwh1stm5PIApuhsOuPeShE=;
  b=S9WVoQf3ObQlCe5uApsT4VEqW8tSIgGXMiFnI1EVinZah9mCiwe7rhkI
   HNx/Ndkkv66jMp7orpqRXQyysrWINU8ipjh+rSz7xEXEojIP08W/hvKtV
   TcYouEZUoHe2J/HqBodwfIdfpKDDf6iI6Bs1oSa5hGmidFW8vRcqQY+Tv
   SYjlvHX2aLf0Dq0DPlI0RfNzJP5O7f8Wgp3Scp07JB+gBcSgv65s1y8vU
   bkXcC4zU93EXbhoejoC3cZy9tk4HiOBZsDnhTDdc1nCiLRZ5OB0p2FTvr
   19FTp4IPBFCdp8bqVonfxuNCzK++joc6+RmRXxsryBz4TGviRflhiauxN
   g==;
X-CSE-ConnectionGUID: ffeP1pehSE6T3sm4OlouRw==
X-CSE-MsgGUID: Te261NbnQ9mhawJsz0Tyow==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="83152213"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="83152213"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:45:44 -0800
X-CSE-ConnectionGUID: jaAm2WDbSVSj8LEicSTAdQ==
X-CSE-MsgGUID: Ag0ajZOnRaOov5a8sUX+9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="194951684"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:45:45 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 10:45:44 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 10:45:44 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.41)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 10:45:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNZZB0lWHLkucFvG44jTtMA3xxN/r3BM4mlCUZVhy+6hY9lW6RZCicKeZTydwsA5nqLDZOPFFiMbOYFQCZVR+psGyHxktIJSoKEON0N+NJzW1kiIYdEa+1RuoiifWqU+Nsa+kFQ2hgzuPRi2XQKu98amRVHda4kKvy7FSyFvCFSvKgdyOXLU5He0osiC1THodOKI7xYuht43LevDqFxlKFXPOdttqWSSd/to8MC4eWU5CNygDJPrYWj+88PiIb48bEMpmqZphC3myIM5TI02hjb1YRILHO6R8Kj4jHzuOHqjNAQC12yBPMQJt9rljgxAEaU3uZofNn+fL0lpi1kGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25T4VchGsid92Shirs+n2lE7vMu56E9ZvzGV1E5neRs=;
 b=IpcA9/riZeyjf1A12vBuGg/31BX3+L8vEI58eiCjJLlUrYvIlLHcemQEcPYPbqH+edIp9dHBQwIzxv6n2GnoVP2o0joBim6bQ3P9ayhX+ICJr+Y7e+hZWNkoqCVL9Qf0Tgkmkj2T9NuZgEoE7xqWX8ljV2EtIpJ0SIA9ZH2PRSxH3vS8i9MhfqWZjAcQ3wyu0RoMHmRkg7BBx/4jwRAEUQHq8zeccpukwA29uAfq7vuRc2A/6/U6bA2DkDDZ8wA5KUnapysD6eO3pPsW8fdkxWf4c/ttVQvcPjhF7c62ZO1xci8rXUSGmO9sXgq4wCNcld3X8xL78YU1hBvuj5pyfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 18:45:40 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 18:45:39 +0000
Date: Tue, 18 Nov 2025 19:45:24 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: Alessandro Decina <alessandro.d@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Alexei
 Starovoitov" <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net v4 1/1] i40e: xsk: advance
 next_to_clean on status descriptors
Message-ID: <aRy+xA5xSErIb61j@boxer>
References: <20251118113117.11567-1-alessandro.d@gmail.com>
 <20251118113117.11567-2-alessandro.d@gmail.com>
 <IA3PR11MB89867864D4ED892C677CA8CEE5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89867864D4ED892C677CA8CEE5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: d0439269-31f3-433e-67e0-08de26d2ab7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BJT4y3FzAeEjank11IL2n7FQidMeJVIM4qGeOP9aPGDi8iKANB6pa4wsB156?=
 =?us-ascii?Q?1p23PgQjBuzDgxo6J07d4U23u9fpsRDMf7CFC9S2RBkbGK4u2ljv3HD8LrnK?=
 =?us-ascii?Q?HOslNZxzNRjaXWFmn471BVPKZw4jvZdL3sUGRXjTKDe3FmCojQI5OK0EOWss?=
 =?us-ascii?Q?dqO2ILfE98lvexWdt5Nz/5MHHclkHShq6A7VXEasE3QgVcDTorwzjvTM6sMs?=
 =?us-ascii?Q?KiIysGcMME5a/oTuE9vGUZ+3Qkr12u+X4DLqdejFNxB91bMJIOOnfMSAjEzv?=
 =?us-ascii?Q?6HteLqua2Twa5CwXzirKnYZ8Dx6KLjTYSZ0N0w6dAy+mANRzNuOIqq7zRsyH?=
 =?us-ascii?Q?0HPf17WQsAS+o+9eoHCDJ8EdMK3Y7G2r8gdeg7ncBRByOZCpC+Ok4D9YPVmR?=
 =?us-ascii?Q?XxDE1i2knwbJC41eNVkyLzZnv8Rj25I8yd40Y7mRtNd4JSuvGorVHcqBI4Rj?=
 =?us-ascii?Q?iCtGIxItSBciCK/dtHKLRzzAd14Nfs82WC1bEfLg/hW8n8xLtmmDrNjU1rRt?=
 =?us-ascii?Q?JvL/Ir1M+rqVFx0vGsQT7EM/PXY1gxwi70lgRALJrJUZG9+Jpr2MP6oHQMKb?=
 =?us-ascii?Q?kvcC7VUYn60P04AXC5bj/Y9jK2nAUHGf8xH6Emsjni7OONcEy+yBF7op+Jlg?=
 =?us-ascii?Q?XSJP1VE/v9FWLxNxwyP6Wuwyv2zCFd+ExGtHA3XigDq+4/2uQiu5WAKoHTRX?=
 =?us-ascii?Q?T9/bxgf/zVYF/gUh7LbslLn1rgyk14DZ9hyO3wZrPYbf4EIFLqrLibYnKrJx?=
 =?us-ascii?Q?yWhoN13mT/4fgVU1ugVtrmADVPSlQea9igRzWKB3M+9PTdsm29qRu9NQs2DF?=
 =?us-ascii?Q?hTFiNRKMGROks9+7mQGjVi6BVB7HJPyPfbwvqSlXVxnemyRQk9O7YkR5+8O+?=
 =?us-ascii?Q?OUp/nn1erCwypIIvzAmpFQP6WoAh2cjBms/x8jPCw5KeFnvBpt6d7P4ZrB+X?=
 =?us-ascii?Q?8lXMoEJnkHCD/tHEmRPxmTrIG0Imcj7DDO5O+CazvHPd3olj2ni4k4HiliBt?=
 =?us-ascii?Q?dqn6LTtEQXGFpa3eA+hygsAGPISjv5a799fbRKgX79edFg5w0mUebutlEgcY?=
 =?us-ascii?Q?NaAy3Bb/s2xNR+DCeB0K6SCuPO7yM0F1w+KVjEY28RjBAZniv3ZRl0eIi8v9?=
 =?us-ascii?Q?JzYM6ylZRqc0SDCqZKWUB0FOH35Zh2TzxptQWl3LkNJYYZAVRN64kV4jFJLb?=
 =?us-ascii?Q?4uQicxITtD2mz29cKbVV7bYvQYfS9MHcRkjtYLxKA1K5V1Xd/lOnRVvfMA5P?=
 =?us-ascii?Q?UbikjvhjKmn+hoFprWxh1QxZ5K95baom76fKwKtmYlSimtzlP5TygtEPU8Og?=
 =?us-ascii?Q?BbX6IBNlFdrqU2tQ4GQ9rVPHz2EeO5DtNRvcD3E6Rq3EJwe8sCuC45un2YyQ?=
 =?us-ascii?Q?DfKoIHZ2OI9DFf8DMEbnJqmeGssD5nwxN6w8T3SgBDSGh8ytebebC/vZj0Wq?=
 =?us-ascii?Q?hcaHklIHnmYunyH19KYR8kS402EuKSWR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BFjOoojbn71vbsfjbYMFTo2libGB2ZuSmU3qWFFlmvfahW8VjDd6vzOGUryp?=
 =?us-ascii?Q?TjTZspWj0zh8RUGsBkDgrg9eo/KdsHdpUXeIkH0KY5W/eQl+ARr5R0wLaFSb?=
 =?us-ascii?Q?fe+NO5s+d1OPurNNH9EuiAjMR+Avyp9BwbX1QsmxRpdOgw+NIGgGk+fhM1lQ?=
 =?us-ascii?Q?3Y5I2RzV8xe5wHiyRHGkLfi4AR2R97L3oewaW2KB+jl1Xdo26OQiKe9Ke/se?=
 =?us-ascii?Q?UNXbNmIeywkMAG2b0MuUVk8ft3lUeC6GZzwTVGf/5nATnqOWEkvYNiVx3Yql?=
 =?us-ascii?Q?jcG2jkkxvJwXW8PpeIXmE7WxPW7KLnXmSC9FEsQYxWYZfkiq16AGYADb6Njz?=
 =?us-ascii?Q?9XBpr1vdjFDCD+DbyhRw4g9yfjE58R+LNmTB8jN8htJ8Soh1xlGIGlagj7Sk?=
 =?us-ascii?Q?ntELOIN1EughcYJUmCdqWp/stjFMN4FAV20K/Mz3zvDRCnNtdMUIKW3ZhjQK?=
 =?us-ascii?Q?7qYHhi9bqYDPILSWk1fG8tfIhziyCjKXR7WA/otP9FGiIYVbYjBE9VYYtWZV?=
 =?us-ascii?Q?pDph4Lgw/ZkMr+ue0CYiLqJzXBWSAFiKyVqHkOU98U4kNTahzrrMhjoGavKi?=
 =?us-ascii?Q?gG8wo5ifXs4uQn3DJS2VAifI6Na1n18Iabjxp4W/66Xn88e8Qlxby6W6OHss?=
 =?us-ascii?Q?75+fBrcohIH65owiaKMU3DNM4O9B4Rt9Q75HhmQyj5RyQYBZarX0XD1u53l0?=
 =?us-ascii?Q?JwLXNh0SDlXN+SKwrCt9Wjs0foI5K+eBhE5dPkVhGL7/MP62JogRO7POFxd6?=
 =?us-ascii?Q?hSG2hXbLfFD0MuZXWHlHPaDWfloF2EAkqNN1p57F4Rk9C+7vhcDEvWJB2DxZ?=
 =?us-ascii?Q?LgJkaDG3hUHlazyUc3fAAdQggI4c+fxA11B2Rb13NbjPD+Ae25HbuIHFqPx0?=
 =?us-ascii?Q?UM2XUHPFba0T9cykZvspushZfxvpDxasCdaSp6B86MmPAanvrVRieWmmaDms?=
 =?us-ascii?Q?npVgkM5YGoPgJBmW85mOeBLbdll43qGzzdUxTtLPqSyqmHCqiKk2j5bPvQIA?=
 =?us-ascii?Q?k6lAUQvyqzvGvTPqb/n5fwzZUNMwSf13aFLo4Sl/oTZtMbBW5Y+xfmYB4N18?=
 =?us-ascii?Q?oreBcq3MZDcVImOhPHG8G7gGSv/xpm6k1Qtx4IBOl/xucSJVuJtMQ0k3GecW?=
 =?us-ascii?Q?BL7DeVkdX1NHdQ+ArSqmVgw7vFRGk493JlqKJcGEx+tW/eZxU1tjlynFPHl2?=
 =?us-ascii?Q?hqSioGHctWr/Gvbyl2F8EP+HCUWKCm3qVSSbgDGNc89buYrZW3s13+Jsc++f?=
 =?us-ascii?Q?13aZhMr8wDIq+u0/+Qv8CLmiQpsqYduJgq/hr+wdcuTQcMBx4XfgNpfmMcG3?=
 =?us-ascii?Q?FOpqITexLg7pAXeSQ92HylySP3+Y8cuYLp7MU29SzRAj4Q5i2/yTIKVtiLFa?=
 =?us-ascii?Q?rkGJvv0gwt6PrnyK7EsUuX+BnNsEw9FJ/J5SmxuC0gzoD9q4cxulk7PucMjn?=
 =?us-ascii?Q?z4BAu9Y1g8hI5QB7JiFjZh+JETlDVJ8uTI/UVB8yDwmRNj8C8GYkIs18lAg0?=
 =?us-ascii?Q?gasmQQvzpPkc7YK2r9U9k/z13A7XwJWGP2/jBCbCelVYrkFUXT4IDFFsuONh?=
 =?us-ascii?Q?W8iczbCO8ArsNC72aoBLmabsnGXXT/U7pm8pAmQhF54uuqFjihK+4JZ9peTy?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0439269-31f3-433e-67e0-08de26d2ab7e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 18:45:39.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iRjeplPV7dTOF7wDpAb9VxkFlw+RHWWsJtyYeKyq+Vq2UVaayTryan/qhHdboZ2jaxzdQDkJCPgqeaG5DLbQb853TVLNmMVYo7Tn77W+q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com

On Tue, Nov 18, 2025 at 01:13:33PM +0100, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Alessandro Decina
> > Sent: Tuesday, November 18, 2025 12:31 PM
> > To: netdev@vger.kernel.org
> > Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; David S.
> > Miller <davem@davemloft.net>; Alexei Starovoitov <ast@kernel.org>;
> > Andrew Lunn <andrew+netdev@lunn.ch>; Daniel Borkmann
> > <daniel@iogearbox.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Jesper Dangaard Brouer <hawk@kernel.org>;
> > John Fastabend <john.fastabend@gmail.com>; Paolo Abeni
> > <pabeni@redhat.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Stanislav Fomichev <sdf@fomichev.me>;
> > Sarkar, Tirthendu <tirthendu.sarkar@intel.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; bpf@vger.kernel.org; intel-wired-
> > lan@lists.osuosl.org; linux-kernel@vger.kernel.org; Alessandro Decina
> > <alessandro.d@gmail.com>
> > Subject: [Intel-wired-lan] [PATCH net v4 1/1] i40e: xsk: advance
> > next_to_clean on status descriptors
> > 
> > Whenever a status descriptor is received, i40e processes and skips
> > over it, correctly updating next_to_process but forgetting to update
> > next_to_clean. In the next iteration this accidentally causes the
> > creation of an invalid multi-buffer xdp_buff where the first fragment
> > is the status descriptor.
> > 
> > If then a skb is constructed from such an invalid buffer - because the
> > eBPF program returns XDP_PASS - a panic occurs:
> > 
> > [ 5866.367317] BUG: unable to handle page fault for address:
> > ffd31c37eab1c980 [ 5866.375050] #PF: supervisor read access in kernel
> > mode [ 5866.380825] #PF: error_code(0x0000) - not-present page [
> > 5866.386602] PGD 0 [ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI [
> > 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted
> > 6.17.0-custom #1 PREEMPT(voluntary) [ 5866.403740] Hardware name:
> > Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3.2 03/20/2025 [
> > 5866.412339] RIP: 0010:memcpy+0x8/0x10 [ 5866.416454] Code: cc cc 90
> > cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90
> > 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <f3> a4 e9 fc 26 c0 fe
> > 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 [ 5866.437538] RSP:
> > 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286 [ 5866.443415] RAX:
> > ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 00000000000004e1 [
> > 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI:
> > ff2dd26dbd8f0000 [ 5866.459454] RBP: ff428d9ec0bb0d40 R08:
> > 0000000000000000 R09: 0000000000000000 [ 5866.467470] R10:
> > 0000000000000000 R11: 0000000000000000 R12: ff428d9eec726ef8 [
> > 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15:
> > ff2dd26548548b80 [ 5866.483509] FS:  0000000000000000(0000)
> > GS:ff2dd2c363592000(0000) knlGS:0000000000000000 [ 5866.492600] CS:
> > 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 5866.499060] CR2:
> > ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 0000000000f71ef0 [
> > 5866.507079] PKRU: 55555554 [ 5866.510125] Call Trace:
> > [ 5866.512867]  <IRQ>
> > [ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e] [
> > 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e] [ 5866.526022]  ?
> > srso_alias_return_thunk+0x5/0xfbef5
> > [ 5866.531408]  ? raise_softirq+0x24/0x70 [ 5866.535623]  ?
> > srso_alias_return_thunk+0x5/0xfbef5
> > [ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800 [ 5866.551493]
> > __napi_poll+0x30/0x230 [ 5866.555423]  net_rx_action+0x20b/0x3f0 [
> > 5866.559643]  handle_softirqs+0xe4/0x340 [ 5866.563962]
> > __irq_exit_rcu+0x10e/0x130 [ 5866.568283]  irq_exit_rcu+0xe/0x20 [
> > 5866.572110]  common_interrupt+0xb6/0xe0 [ 5866.576425]  </IRQ> [
> > 5866.578791]  <TASK>

Something is odd with your editor, it would be better to preserve the
formatting above.

> > 
> Commit message lacks test description.
> Please add how you validated the fix (kernel version, NIC model, reproducer steps).

Repro steps would be nice to have, rest would be rather redundant to me.

> 
> > Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.
> > 
> > Move the common logic to i40e_clean_programming_status and update both
> > i40e_clean_rx_irq and i40e_clean_rx_irq_zc accordingly.
> > 
> > Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> > Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 59 +++++++++++-------
> > -
> >  .../ethernet/intel/i40e/i40e_txrx_common.h    |  5 +-
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 14 ++---
> >  3 files changed, 42 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > index cc0b9efc2637..fe2190f4b9bc 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > @@ -1386,22 +1386,36 @@ static void i40e_reuse_rx_page(struct
> > i40e_ring *rx_ring,
> >   * @rx_ring: the rx ring that has this descriptor
> >   * @qword0_raw: qword0
> >   * @qword1: qword1 representing status_error_len in CPU ordering
> > + * @next_to_process: pointer to next_to_process index
> > + * @next_to_clean: pointer to next_to_clean index
> >   *
> >   * Flow director should handle FD_FILTER_STATUS to check its filter
> > programming
> >   * status being successful or not and take actions accordingly. FCoE
> > should
> >   * handle its context/filter programming/invalidation status and take
> > actions.
> >   *
> > - * Returns an i40e_rx_buffer to reuse if the cleanup occurred,
> > otherwise NULL.
> > + * Returns false if what is passed is not a status descriptor.
> >   **/
> Please use kdoc Return: tag.
> Kernel-doc is incomplete, please also document what 'true' means (status descriptor processed).
> 
> > -void i40e_clean_programming_status(struct i40e_ring *rx_ring, u64
> > qword0_raw,
> > -				   u64 qword1)
> > +bool i40e_clean_programming_status(struct i40e_ring *rx_ring, u64
> > qword0_raw,
> > +				   u64 qword1, u16 *next_to_process,
> > +				   u16 *next_to_clean)
> >  {
> > +	u16 ntp = *next_to_process;
> >  	u8 id;
> > 
> > +	if (!i40e_rx_is_programming_status(qword1))
> > +		return false;
> > +
> >  	id = FIELD_GET(I40E_RX_PROG_STATUS_DESC_QW1_PROGID_MASK,
> > qword1);
> > 
> >  	if (id == I40E_RX_PROG_STATUS_DESC_FD_FILTER_STATUS)
> >  		i40e_fd_handle_status(rx_ring, qword0_raw, qword1, id);
> > +
> > +	if (++*next_to_process == rx_ring->count)
> > +		*next_to_process = 0;
> Consider using u16_inc_wrap() instead of manual wrap.

I don't see anything like that in kernel. Did AI hallucinated for you or
is it something from OOT realm? Or am I missing something.

This is a method we use throughout the whole driver. Even if such wrapper
exists, I'd rather see a refactor patch that addresses all the manual
wrappings, not a single one.

Let's keep it as-is.

> 
> > +	if (ntp == *next_to_clean)
> > +		*next_to_clean = *next_to_process;
> > +
> > +	return true;
> >  }
> > 
> >  /**
> > @@ -1971,19 +1985,18 @@ static void i40e_rx_buffer_flip(struct
> > i40e_rx_buffer *rx_buffer,  }
> > 
> >  /**
> > - * i40e_get_rx_buffer - Fetch Rx buffer and synchronize data for use
> > + * i40e_prepare_rx_buffer - Synchronize the buffer for use by the CPU
> >   * @rx_ring: rx descriptor ring to transact packets on
> > + * @rx_buffer: the rx buffer
> >   * @size: size of buffer to add to skb
> >   *
> > - * This function will pull an Rx buffer from the ring and synchronize
> > it
> > - * for use by the CPU.
> > + * This function will synchronize the given buffer for use by the
> > CPU.
> >   */
> > -static struct i40e_rx_buffer *i40e_get_rx_buffer(struct i40e_ring
> > *rx_ring,
> > -						 const unsigned int size)
> > +static struct i40e_rx_buffer *
> > +i40e_prepare_rx_buffer(struct i40e_ring *rx_ring,
> > +		       struct i40e_rx_buffer *rx_buffer,
> > +		       const unsigned int size)
> >  {
> > -	struct i40e_rx_buffer *rx_buffer;
> > -
> > -	rx_buffer = i40e_rx_bi(rx_ring, rx_ring->next_to_process);
> >  	rx_buffer->page_count =
> >  #if (PAGE_SIZE < 8192)
> >  		page_count(rx_buffer->page);
> > @@ -2450,6 +2463,7 @@ static int i40e_clean_rx_irq(struct i40e_ring
> > *rx_ring, int budget,
> > 
> >  	while (likely(total_rx_packets < (unsigned int)budget)) {
> >  		u16 ntp = rx_ring->next_to_process;
> > +		u16 ntc = rx_ring->next_to_clean;
> >  		struct i40e_rx_buffer *rx_buffer;
> >  		union i40e_rx_desc *rx_desc;
> >  		struct sk_buff *skb;
> > @@ -2480,21 +2494,15 @@ static int i40e_clean_rx_irq(struct i40e_ring
> > *rx_ring, int budget,
> >  		 */
> >  		dma_rmb();
> > 
> > -		if (i40e_rx_is_programming_status(qword)) {
> > -			i40e_clean_programming_status(rx_ring,
> > -						      rx_desc->raw.qword[0],
> > -						      qword);
> > -			rx_buffer = i40e_rx_bi(rx_ring, ntp);
> > -			i40e_inc_ntp(rx_ring);
> > +		rx_buffer = i40e_rx_bi(rx_ring, ntp);
> > +
> > +		if (i40e_clean_programming_status(rx_ring,
> > +						  rx_desc->raw.qword[0],
> > qword,
> > +						  &rx_ring->next_to_process,
> > +						  &rx_ring->next_to_clean)) {
> Wrap the call to i40e_clean_programming_status to stay within 80 columns.
> 
> >  			i40e_reuse_rx_page(rx_ring, rx_buffer);
> > -			/* Update ntc and bump cleaned count if not in
> > the
> > -			 * middle of mb packet.
> > -			 */
> > -			if (rx_ring->next_to_clean == ntp) {
> > -				rx_ring->next_to_clean =
> > -					rx_ring->next_to_process;
> > +			if (ntc != rx_ring->next_to_clean)
> >  				cleaned_count++;
> > -			}
> >  			continue;
> >  		}
> > 
> > @@ -2503,8 +2511,7 @@ static int i40e_clean_rx_irq(struct i40e_ring
> > *rx_ring, int budget,
> >  			break;
> > 
> >  		i40e_trace(clean_rx_irq, rx_ring, rx_desc, xdp);
> > -		/* retrieve a buffer from the ring */
> > -		rx_buffer = i40e_get_rx_buffer(rx_ring, size);
> > +		i40e_prepare_rx_buffer(rx_ring, rx_buffer, size);
> > 
> >  		neop = i40e_is_non_eop(rx_ring, rx_desc);
> >  		i40e_inc_ntp(rx_ring);
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> > b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> > index e26807fd2123..21d9ed878bf0 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
> > @@ -7,8 +7,9 @@
> >  #include "i40e.h"
> > 
> >  int i40e_xmit_xdp_tx_ring(struct xdp_buff *xdp, struct i40e_ring
> > *xdp_ring); -void i40e_clean_programming_status(struct i40e_ring
> > *rx_ring, u64 qword0_raw,
> > -				   u64 qword1);
> > +bool i40e_clean_programming_status(struct i40e_ring *rx_ring, u64
> > qword0_raw,
> > +				   u64 qword1, u16 *next_to_clean,
> > +				   u16 *next_to_process);
> Argument order differs between header and implementation (next_to_clean vs next_to_process).
> This will compile but is misleading and dangerous for future maintenance.
> Please fix argument order to match.

Good catch

> 
> >  void i40e_process_skb_fields(struct i40e_ring *rx_ring,
> >  			     union i40e_rx_desc *rx_desc, struct sk_buff
> > *skb);  void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring);
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba5..f8accc266c2c 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -440,14 +440,13 @@ int i40e_clean_rx_irq_zc(struct i40e_ring
> > *rx_ring, int budget)
> >  		 */
> >  		dma_rmb();
> > 
> > -		if (i40e_rx_is_programming_status(qword)) {
> > -			i40e_clean_programming_status(rx_ring,
> > -						      rx_desc->raw.qword[0],
> > -						      qword);
> > -			bi = *i40e_rx_bi(rx_ring, next_to_process);
> > +		bi = *i40e_rx_bi(rx_ring, next_to_process);
> > +
> > +		if (i40e_clean_programming_status(rx_ring,
> > +						  rx_desc->raw.qword[0],
> > +						  qword, &next_to_process,
> > +						  &next_to_clean)) {
> >  			xsk_buff_free(bi);
> > -			if (++next_to_process == count)
> > -				next_to_process = 0;
> >  			continue;
> >  		}
> > 
> > @@ -455,7 +454,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring
> > *rx_ring, int budget)
> >  		if (!size)
> >  			break;
> > 
> > -		bi = *i40e_rx_bi(rx_ring, next_to_process);
> >  		xsk_buff_set_size(bi, size);
> >  		xsk_buff_dma_sync_for_cpu(bi);
> > 
> > --
> > 2.43.0
> 

