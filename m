Return-Path: <bpf+bounces-74923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16072C68203
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B74634C73B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 08:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED6303A1D;
	Tue, 18 Nov 2025 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/WiBrgN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368262F12A1;
	Tue, 18 Nov 2025 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453110; cv=fail; b=UbJbzzFRvuB/Tb7tQsOVhQJqIIjFXxCMG+N6DX989s6fllSN/kcfctQeuJhvcz/oUxvbvOwiEunwzTJGpKC6/XTDQ1YepfHzCS3TNh/Dl5pq4LYf9zVHGYSAVk2dep7lTa8QAAg8y5SZbAXApdl2Ac7+ZIAYxjRK7s/bwJKBYio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453110; c=relaxed/simple;
	bh=hbbU+TtbMYR3lBK2E5Na0eXSkA2z4tZsE1UihPqUCeE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uuaPZxle1bUjQGE0ihL4l8eoc+Pt9I9sawTwb2lkbdeh5Uipg/UdtE371Pt2fBS6dlEEyzPyPKTZEaqrOjUBcrkDcaUIIpk77cq3AmewPHaq6slmZs8B5C0yDyFqzsfWNky/bxmk9loaGBvtpX/oLGofkEDQgMRy7RVcjy0xCKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/WiBrgN; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763453109; x=1794989109;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hbbU+TtbMYR3lBK2E5Na0eXSkA2z4tZsE1UihPqUCeE=;
  b=m/WiBrgNXJ6m2KbAIgh/b1ehk5FwFWHXAUjjgexT0/mDIZDGGLG2Q0R3
   noh36RQ2g/7OWGuMZt5NyVyAE6lZBTfDyhfexRMy2mLbRf3SH+0QLGvob
   aE9s6ryTiHzkbH16o20quEW3yLIJ0hPUJ7K+4KuSQhSyZWe1657/f1JhY
   myjI9J91xXU+qNbn5ESVPa1+f8xsrO9LEdlPf0jfpYiHkCm4c8MbWh7Aa
   bc1GeXuhUkRTy6yQ6OGecbI3wQe3MFf5inFbelpqGk/JfqcXGPCvuMhE8
   KjFUG98MBaF0Qk+OnFPUXPQlOzOupv/7KdIbly/P/NgMXtwBcnDW6ofb3
   A==;
X-CSE-ConnectionGUID: qqYNo4gtQxihcGX4JbUDvA==
X-CSE-MsgGUID: EIruosdaSn2hm7crsGLwGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69318875"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="69318875"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 00:05:08 -0800
X-CSE-ConnectionGUID: voexoeGDSsGy4sIrWCTSPw==
X-CSE-MsgGUID: 0LZEIR+ZTzezOD/noPvZYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190487939"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 00:05:08 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 00:05:07 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 00:05:07 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 00:05:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIDnD2+1/3/VE/Qmpg3RZCdZs4H2QeoRsJNPXP3+XEH+ykj6nhgt8Yq5EqKwHAPNf6u59vIRxOIYuuLCFNULUYMouj3ygGZF3B1iRXrlQHi4JZMcOBqd+O2QVBTxDykSqKMWDQb9POmyLNTM65YG06oiJ6xJF7OvgvOHUcmtkyDtZs0I2iE26TvPB2G+8EG0FtHaVdzuoKb5PJkBz3eTJ/CV3ZOV3vnxUsDjnIYjDZFkoJo5BANQ7jEktAVQx1fjwlcHzJV+N5tHPSUnBgSxTN7TuQtcfdrDb2CnF3e4GkMNMfwxfWU08bMYPaKSEo9/9wtKCYTponvKAO/jTW/0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHAtWysSNa2v2q3bSMRZR+d7BX63ASU6sRh1DH7QEoY=;
 b=MWfL9oq4aoAYzTRPa0p/U+Ibp4IkgW1SN1qGiWd9+ZZp2aZjkHdL0ES17AqGJtEktbexX5d9mzB4x4sOyOIZw8v59k2DHyF/VLgVeXW0UhflMNqLnosAfgeL/eTSo/DdBWZLhLO6c3Z1rafD2WqKz+k1wWWbYy8nGmoADX14x7OI98+EzpqvkSmvJlGC5JN5Co+81iFRKKZclWkf0YZa8A4CeB1kwerz5SFidDW1ZLxuO3T+5eStVxV0e5pwClinurAcxXEMCGlBvdBHmBeHFVv2GawzHAZ/HQyZqnprhnL1/OVu2Tq9Vc2s3U7xM4HX+H1mfab1Gw9kIl7v+Bcc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Tue, 18 Nov
 2025 08:05:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:05:05 +0000
Date: Tue, 18 Nov 2025 09:04:58 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alessandro Decina <alessandro.d@gmail.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Alexei
 Starovoitov" <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Tirthendu Sarkar <tirthendu.sarkar@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <bpf@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aRwoqgw1KFX+H6ci@boxer>
References: <20251113082438.54154-1-alessandro.d@gmail.com>
 <20251113082438.54154-2-alessandro.d@gmail.com>
 <aRcoGvqbT9V/HtoD@boxer>
 <aRgysZAaRwNSsMY3@lima-default>
 <aRtPXS8haLNHu8H1@boxer>
 <aRwUGnyFBxrkjGl7@lima-default>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRwUGnyFBxrkjGl7@lima-default>
X-ClientProxiedBy: DUZPR01CA0293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 0359c7bc-d9e3-42d3-bb90-08de26792edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L/cOOGPZPaY3JwNUKJYvKkjvBWNUYdkSgINjhZInp+hNCbGp5XoKiIOOEuWD?=
 =?us-ascii?Q?9YLtIHSpPMXpoMaz8or1Q2QGUHJGrfB9/Tx5vE5WA9tOqMwFr8y3mvsRnpDq?=
 =?us-ascii?Q?WtOCxrO5hg9YR/pOlY4XG+wVdqd3b5pCOQJSwNBZjk48UUdK0UE8FHP25Faa?=
 =?us-ascii?Q?aTOfaCsI72H1rKLB/ZOUMJXqpXIm+mWAZ5dbdDqQdMHHgjorKzO8FB0FHgdw?=
 =?us-ascii?Q?Zr1KQcfA1IflPaKAcjM5KEKdhWTch68LcocWv4PuJM6UCCX4lVMe+nle1kwH?=
 =?us-ascii?Q?c1+RRTTUTveA1a814elLVrNAf9Imj3EOu7GbA5zYigt7hUpoHAXPdKxqv/Fl?=
 =?us-ascii?Q?qHYD2VValQX+DfofabbQEdXq4nXh249BqoCM16ozmzBjLw7HAIhmWs1GxIe4?=
 =?us-ascii?Q?HS2OgGjJqLKsa19dlTvEo9JrhlcMIQ3dAkw9dP+r96SV4G3DGYlRsdp9M0wo?=
 =?us-ascii?Q?r5wWx5Iqv586QwMtBQFKPwXZAVjaOwh4fTIpty8pudWzTCqvyIipEytiapna?=
 =?us-ascii?Q?qozO64auHPR7wqta0pYgncnN/8jZQOJYwCqRwos61AdK1KesPwWlJ4xsQYtI?=
 =?us-ascii?Q?TYq0ytcwLZMYAdbWHqNqgHowpf6UGyDz/9ONbOhjjZEJbwHRyQ39wq/klhER?=
 =?us-ascii?Q?uuLSgW1FYRAfB+C9/0ADR7myOyTGhGuBcwFoMrR9h+Mq3oAHg78RGDuFNgyG?=
 =?us-ascii?Q?/UWbEZ3jF1GBFArubwJXRCKCJbqPonLSvzB0L4UstmrrAjD0uooN6ojv+Sgz?=
 =?us-ascii?Q?FxkLHPQQ+hu9/58ASexR08O50l6ub4Z/vpkwlFtINWitlG4ChhJ0T/rPIddv?=
 =?us-ascii?Q?dkpifTlMM4QBsvowe9KdK6TSfP9r0mOsoIscZroPCeXNaUMAprd+skkfPnia?=
 =?us-ascii?Q?1kQNkCKTrbZ2o1b6y+9AsZv+Fe0CqVpePXvhX2Uy/KPf8PlIbwXkBSl9C4yv?=
 =?us-ascii?Q?ji+ed0MYXkXBCRB2cCcVy04NYasdKs0t3NJcjhibUkoslJvUBe/bD36EhQaw?=
 =?us-ascii?Q?/B/B6B6d0g9LTQjvqlPukNe+hOjwPwRicLqffzOhnFV+wPqQ57kvODUqfgnw?=
 =?us-ascii?Q?r2kaOdNxj8AjccpvwMjxM9aBOaIbb+3p3xu3bfIPrh5R7cvt6FVSgPQ4YbpM?=
 =?us-ascii?Q?GjpNsM9UcZPufE5PnthDnjvhe7+E0OWGluj1xBU/WcmmhVv2lyifDWcCpyZx?=
 =?us-ascii?Q?w1NzBB6C2+TgYfgTe8obes1t4wm2V7GBBklE/hfpV1TrjnzxJLeQaUP8A/sD?=
 =?us-ascii?Q?g4gcY4jDl62MFFPJzmDlM9IrnaUdTfVLYngYCi0M3OP6XzNBCIS29G2PUJM7?=
 =?us-ascii?Q?JhFwd1KwghODRwgeFBRPhykmkJvaGKIP0+gN2ZPkYhb0tm5vnJH7RciqkHCQ?=
 =?us-ascii?Q?RELojMBd/KfLl1qzHhgQZ2175WMhInGxiBBJd0mCCrvSAjJaDuBroh9GcJWX?=
 =?us-ascii?Q?qULH67OwYbOr6qzq2hQONEbgWU68+icx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qEyh2p3dZiGr+hYBZuWebB64zDrCofdPw4toJzUFHTeAOlU+sGBeoVQ8jF4b?=
 =?us-ascii?Q?rFOSTfo3GK7ILxxwD/ycFlF4P3xRRpj15+rUSvWExKU0EgpUAlko6luy8T21?=
 =?us-ascii?Q?4H3lifmfl2mNuRvbxR6dMXCqIxPXfSDg0JyLAruGD0Ujyet1/o7UUCPE3chh?=
 =?us-ascii?Q?EG/56qg8xi6sXBMqy547PbwPrH4RpQrejqZuFtWxh/knDJlvYrwyJq80yYhw?=
 =?us-ascii?Q?JUIyMQq3GIC41tgPWGdxtHtx0UYqqSC+iE6PnPaTX76C0PmY/hRD2zkMErt8?=
 =?us-ascii?Q?pg85c1ga2xtX+bev2VZWJYK8zvxf6HzsdLdqX5BtlYk4izDSxJQBGs4bYhXs?=
 =?us-ascii?Q?Ac6pv6NRdHBixvmXnoaDZKtwAWEGIxgBavzmnFDuzK+bQthHZD5/Kn66qEa0?=
 =?us-ascii?Q?jakEZxfHhV5+wIwPhGOETw7vmyAZ1TOOid7MBlNpnuTRGnD9ZZHlxSrHMF8g?=
 =?us-ascii?Q?pBqdcaizAC/Gf1/XWWVw4xZzdTesgduuzQ5rrQYglkU6SLTi1ov8lpE7Ftct?=
 =?us-ascii?Q?nmCY3Cfojq/aM09pJtm0FosY7lgROBHLUbQglu69A56MTaur5tgX666741a2?=
 =?us-ascii?Q?iG61m/zWh/R3hg1QuWlgZiMVrKi8HK2/ZCcnQ8iP8QhUh9p7DoqXIQD5dXZV?=
 =?us-ascii?Q?MbcNc688/SmXyGIKcktA+0m9kM+RjHsSBn+9EkiRjPTS9J0sO3j3K1e+tIxz?=
 =?us-ascii?Q?sYuwlsekzGSZkovLLzJgz5YdRGv1VuvVYzLTwj3H8JyjZadJyFf59LhsfpKv?=
 =?us-ascii?Q?smaKtWXzHx1ScuEbUfZB5NKeZVTtgDPrWCzIE2qkpe9w/g5lofBVSVBEV7l/?=
 =?us-ascii?Q?O5yVEs0cjaVzf84I0Ir7GSKOuP3Hyuq0rcEPQlj2T9PbabzF4meB3/0U4VvT?=
 =?us-ascii?Q?KwXzwJvmDH3EGXsCHfLpEepsNuGsHqDrYjpyiOEvdeVu5JxTxQMsAtwZZF4u?=
 =?us-ascii?Q?Rp/8UpnsTgzceHXxfELLHjfvCUFsHs9oEZuUnLN7ZJu++7yxTKaECbkv2xo/?=
 =?us-ascii?Q?VqBQmZB05w+bRUvxSt3gBBlN0XS61j8PN1APigpFM1ppcYPg6YPd2GsbTNON?=
 =?us-ascii?Q?MfOj4SVpxTomibjHY5sFdQVeeRRMHfbOizmx7zxHtn4XycHZEgEc17J0VyEl?=
 =?us-ascii?Q?BoO+tStKgJWqnp9JuTLhXA0TWZSu/vnjNlbXezn3pQUqbNQJQwZ0ToZeopwg?=
 =?us-ascii?Q?PPORseP0eAeB0U5nrfY60KLdEWmYmVEVIyPfs05pAraf4NzWWvOyEgiifrGI?=
 =?us-ascii?Q?F5mn6I18H6Il8tvGi0/R82OirZhvHNIb4xWg0o3caW9m73lcmrwSI4ULt5Wa?=
 =?us-ascii?Q?QRCUsqiyv/hlltUXDT+ndV9GZ2/JDwlSj60rthIKsYJeml7fvSPzzQoT1+9D?=
 =?us-ascii?Q?ES4/1o8cuMtUKnPAy09RAQ+gCsP2p92o81HMbOTk1jSEQaCAw6ZOa7UQONks?=
 =?us-ascii?Q?zza20gi22s71QXaVe8l/mS0CXqNULJKOtuOySRlnC1DJUjASbouMG9HwB+bd?=
 =?us-ascii?Q?TBjxUVok4KaBFSSJRuAmzcOMiZpWVDy4ss9xQbWGkKUvBmA5+5JXPYdJRWVh?=
 =?us-ascii?Q?M7Tdh+TeGPidiVToE4OALgLQv+sPUggEVJHbAd2HtssDniEM67TAvrR6/7zT?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0359c7bc-d9e3-42d3-bb90-08de26792edc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 08:05:05.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKGYkJ2x+mY1YGYQ95ZzuOvrTeP+7+WNUZZBAu0QD4yuc0D74aIIRJZrl+hJKJWUbUhDCcJzvJntg0SYqt0OQGIoFqnco18rHzrEhOl0RFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
X-OriginatorOrg: intel.com

On Tue, Nov 18, 2025 at 05:37:14PM +1100, Alessandro Decina wrote:
> On Mon, Nov 17, 2025 at 05:37:49PM +0100, Maciej Fijalkowski wrote:
> > This revision is much more clear to me. Only thing that might be bothering
> > someone is doubled i40e_rx_bi() call in i40e_get_rx_buffer(). Not sure if
> > we can do about it though as we need to use ntp from before potential
> > increment.
> > 
> > ...maybe pass rx_buffer to i40e_get_rx_buffer() ?
> 
> Surely the compiler isn't going to actually reload here, but yeah not
> great code wise. How about I pass it the buffer and rename to
> i40e_prepare_rx_buffer to better match what's happening now?

SGTM!

> 

