Return-Path: <bpf+bounces-37632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9564895874D
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 14:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD7B1C20EB4
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE9718FDC4;
	Tue, 20 Aug 2024 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcAL0BRr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024279F0;
	Tue, 20 Aug 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158072; cv=fail; b=m5dD0u643DuhcUPv20mlOnpbzhdmjIdrDAhSJ1rehsRAnEZS6Po4ggODCUW+bUjXiRWAr5rtaRQADVVIyEYCL2NYqs7eggoPPTtSTzRH3+HQeX8bhEd6QseBfi9v0HaagUbkxe9p62yv/RLqzxNo8cS5gd/aiNLbzmQWrZxUKIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158072; c=relaxed/simple;
	bh=p0Y9HGPl3fIBq72PnAB+PXsSDX5BnxKcB33scAumLBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DPBiRFJ4cHKLZfCCSn7YBT/voV6vGkTynaSRi60fvZYuyfGxCwmIfG4MNt5RoJT570twV6zFjlEYg8GMHBgEszHxeBBEWTbdKhfxGRp0XRTgaCLnjrlWULeUOrPbpyN6VQr8B5ViNTehDaA4R+Xd5O0SmOHRnfkvFlOacZHjDUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcAL0BRr; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724158071; x=1755694071;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p0Y9HGPl3fIBq72PnAB+PXsSDX5BnxKcB33scAumLBw=;
  b=RcAL0BRrH/mDnNIYUspW7bVQIglq2b4uaySSjU75vDxC/tv0XXdVb7/v
   kp1UMA56CHoFfBKvGu0xSiz5CuuQN3Gtb94XGvp6HPNwPmp+VS9B/ESCv
   98ghxEQayDBBKCxPA3BpgtI2pWXuyUUpKZhRNBjOgRxTDfurqCmIkBpCv
   isPAt00LaI7+uX1AVhkqiR4BsitIXB/68RzvlaNZy2UNiU7yBbv+ok1VK
   E5aIV2W9OiDq8hcSt1gTw0MYPP7cgVuthVsY9rm408I8PbDl5krGycnmz
   Ftbm+jA2k2u8EFyasvUiPYXremjK98A3amTeOBz/zXaaOOVQlu0E5cEh2
   A==;
X-CSE-ConnectionGUID: OostDBXZRLOHukgvmAO5uw==
X-CSE-MsgGUID: eX85cXXcTBuxACfxTGwJ9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="26203612"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="26203612"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 05:47:50 -0700
X-CSE-ConnectionGUID: jNQ5yl4fRESiRTol9S+u/w==
X-CSE-MsgGUID: tcGAnhOPQnGHRplHx+7QLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="91442416"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 05:47:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 05:47:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 05:47:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 05:47:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 05:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZ9xvXSVIxRSFgMlPTolSTjUTIR1FeDavpXAg5UfHYl3XXTRrJf/D4fq2a4l3MqL78SXEfe5pPdCCuJE91EFmErh8oJPVZ/9SpFTe109/OPkZJeSBoBYJQvBeuAM40sAo0UpdnanA7HGN/E3v6bx970dcOxqiQypUY2HfP7tu36yXJvCk/vkL/Ltcbv7JbJ7o3fKxlAOqBdK9MKraPE67ohAQEfKYl5gDGJ2fPw7GhJ+sQucZ34xJIHm1LrEahzh7YWnV/y9Hh/z8XVUq7xsGizB3ctwwv7AvQRkOf7ToTL8CR1OTDHxRYxorlUh7IpbYwzx+x4e33dUnOIVcyy0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOzqhYxxK8Zo2rGOd5/SRdzXBYXEJKvK7HcOfpu7QW4=;
 b=kAVcwVqy7KUPKn0X3pe0L7KM3DU9p60EDMN74aYlTl7mMjymGSgifiyC31psG533F9bkOSqb28/VfAHqh2ESwo0e81kjHsxQvCcMu0JDeaPVfDR0JXQB1tRqfYyANDnU3JWuWju7W2c+80t73/DtJOKQT39URkj4LhZpT6zD5uUBtw2KajfGSG32eW/98GkiW6hqi7itTRB14Dra2WxfPgXcoGTEFM2bX46NcM+fIUz27wMzCJLSLhYZJesbm44odZyY0d5rZt1KoOmtctyfbmoeSLy/kdbZA3J7b5GWeVPyaVuR8TglGAUfoaEEgfTKVCLtyYLk2k2aug4U33pm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB5054.namprd11.prod.outlook.com (2603:10b6:a03:2d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 12:47:40 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7875.018; Tue, 20 Aug 2024
 12:47:40 +0000
Date: Tue, 20 Aug 2024 14:47:31 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>, Chandan Kumar Rout
	<chandanx.rout@intel.com>
Subject: Re: [PATCH iwl-net v3 1/6] ice: move netif_queue_set_napi to
 rtnl-protected sections
Message-ID: <ZsSQY14RCWlG/Bxd@lzaremba-mobl.ger.corp.intel.com>
References: <20240819100606.15383-1-larysa.zaremba@intel.com>
 <20240819100606.15383-2-larysa.zaremba@intel.com>
 <ZsSMt3O4a+Jq0e65@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsSMt3O4a+Jq0e65@boxer>
X-ClientProxiedBy: BE1P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::9) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7ccaab-8c27-4411-0acd-08dcc11646a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o3wICjaWN4Wkaod6HWOfgl+bixe8nyUc897C2KwCBNvLv5JIx9ZAwQiTde1z?=
 =?us-ascii?Q?R38Mx6SYTMdJxjS3feJDLz9kNCHJD2SNzNsnb/SbNZh1LSS0SH+m8tBkROvc?=
 =?us-ascii?Q?62d2gTx6F5+1/PTcGqFVPtu36Z9TgxGr0gCjoxweU7AW+508CC6g4MGjTNrA?=
 =?us-ascii?Q?zWhLmjl6XTaQf5INigDGftD6cfn7PU4IPy4Mqr7Ly9qVpYevM6ZfmsjugdZA?=
 =?us-ascii?Q?tAocHLFHtW9F7xwednc97V1joVBO8tQZOYJYG+ftGHew0UIcKWnaWvUnFLAr?=
 =?us-ascii?Q?/LwAYVekLefTuKoW5PNbX9Tfiry1plZSL+VgD5AjV3axEvO8miy5Ix5MBEE0?=
 =?us-ascii?Q?uTQrZ7jf0Hp42cajsnQZJ8mO+e0vKDLN6oGTKsFKx/tweB64A9I4YSKpvalp?=
 =?us-ascii?Q?EeQeL/q/OjnCgoIvxCoNooLQ4IUT7yUoJH2erxkb2TvtFG4Rn6rBSWCGNiHb?=
 =?us-ascii?Q?13hHnn67xm1ZVWY55+lrWKF4JPRj3IqcMZ7h7LxU+MAKujCVA1jrVcNXsYUe?=
 =?us-ascii?Q?oksHvN7jYFMRTBPCaw3Crc/RM7LONiaLrJ7/aQwU8Ji6GrJEpCzk8qBg+BqA?=
 =?us-ascii?Q?LsdOcqlDyTpa8sG6dvbPNBdrxtbW3QcPNg8l6m3G+t6udjnVe7kejBIx1rv2?=
 =?us-ascii?Q?DRFavNnU8xWAPkgsbkzWriuwQ2Bn55b+lkuXGXi1ENd6UpZ9u5V/UMx37G0n?=
 =?us-ascii?Q?CpLzite9aClrIFJMGEgcZsfQhFurnfNjg97Qi5ZWGmln3Lh49ZAY//XC2oBq?=
 =?us-ascii?Q?PQlfVhGi/vV9A4KE/UzEBW/C/uW4Z95pvr1teaMsDNN7OOLtH/UtssIgVkxx?=
 =?us-ascii?Q?Zi0JwN+kGPS9YYN7d5+wjuGFE/CbsoKHzcFAdbls1vtKBKGIdUph2srkqnAz?=
 =?us-ascii?Q?McGnf0NDjE626mnC/uGcNk06SKyU41sSKTk7xchZDCBOXqjufcqqUV2ZbNAs?=
 =?us-ascii?Q?gJAkFXsdMHHUV3FJMBbuChiti1qYWG2/zsC7Qobzc6+JhmNxM0jVOMXO/BK/?=
 =?us-ascii?Q?bamXH2SiGXMH7otjglUaLT1G01khsbhUfAHlJ6G6bc4H0z+2Tb3ua2YI1tfi?=
 =?us-ascii?Q?HPwE7hU1KpUqezI34/cg0z2If8Bby6VB3w4HO+UtiGMnB5VuEX0dDHK3znjj?=
 =?us-ascii?Q?QCswhxojJZKmDXTAwR30G785SOnXRp90knEp93hcXsR5EPXj8SAR31B28NVK?=
 =?us-ascii?Q?OY9gfrjsNyFjFYSTciI1bYAv9ETdvrxM07YaLUw2tYnIyvcxt9i81s86l2Xd?=
 =?us-ascii?Q?GPKsUokzL3T1w8Nvow6F5PRb/nK+84/Ah5Pmi6xVmkOFCcQMxW0NJMAkMNl8?=
 =?us-ascii?Q?RtBVL0TSAlwfThsKw6DsL4YUCoPEIK+6lUS9Hy8z8YsR2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZmbnCZXAy0olBkxpkEE3AC3Hl1+KQg/6/TDq2hUkSzMor/t5B0aXaAbfHPNL?=
 =?us-ascii?Q?OnJ+w4ZDCOILCW+NARl57+6DbFk7IO9z7GC77JsRBz2LqTdi8WdVnSW5438o?=
 =?us-ascii?Q?RyMuV0rjlyMapO5oSM5q/5vzjttWHQIAPkDmYDN4YbmiLLuqkwGeNwpTkNuh?=
 =?us-ascii?Q?bJogFR5YPzyFv1YhpCtMa0pOa5xd+FI6EKfWhJ/3lXqy9gzGmg5mVM9F6Myd?=
 =?us-ascii?Q?mT1JJFlUi1E1nnIy5MZ8eisQHpxTa1Ynf9cDAVR/Q3FIx1Bgh+OEX3r0sj0f?=
 =?us-ascii?Q?KAEi1Lmo+p+jf6LihMXFL07cjjJMK5b35xzRW9n87LbUWkwG/CMbwY7LAXFz?=
 =?us-ascii?Q?DXM+rrlUxAuZ/uwkP8TBDHjtXwNUIhZE5sGyZmFYS0oPGm3o0TQ6hHsyPfpM?=
 =?us-ascii?Q?KjZYSH7CGeO1aHCF2kfJDrE+x7xE5JBxw9F2MIbzB4USjAovJswX+ATReGr9?=
 =?us-ascii?Q?t+3bcX1bbKMxAoVe2yVszifysYa5PhFAqgCa/xvH3J/+6RBaHH41KsEK6SBe?=
 =?us-ascii?Q?b2ejv/DyS0JMGPRDHLu96yo/Iu+nPgsN1QX/EzBVIsXoptBWOCewYiGwDiqu?=
 =?us-ascii?Q?6cyLFJEqzQWe5Uscfa/RRcetwVSP+xDa59Pp5gpXP9xN/uufUQnsYMxVcwIP?=
 =?us-ascii?Q?JvAqFMOcdYQ9JmN3rgx3Je5ycxHd6wlv5CS9hHLHVMTfRPQVCZqSyI+7LXxu?=
 =?us-ascii?Q?/J0jB5N/rBGqo1ViKNvBQO3vMe20k1mM2FPC3hdblXTHx9v+In8aEX3nZY7Q?=
 =?us-ascii?Q?ZlCP424tKODFPauXouoVP7ifDhyTKB0S03oNsrjK9GheZD7TMteFMghManua?=
 =?us-ascii?Q?Z8k0C92NQexg3qmyeBlSUbui2nINUtl4U8+YQo5To3RGczctmXY/ve2l+JUt?=
 =?us-ascii?Q?BkgT+jEtEBQKlmZmDFNmgikNELK7LMuNsBXYZg2y2Nb0K9uBDzgRq9i+yjsL?=
 =?us-ascii?Q?iXKIgprsdh0S9p5jUOWx3/TO1U5YbCJAcxXqsdxa6ndSZro0Nvyd85bgHO9w?=
 =?us-ascii?Q?+6fRRvcZEx8UOPGQOd8iWD/YIdh1qEYtyi6pTwXsGfCRx2MRT8FzxMQ9YyIV?=
 =?us-ascii?Q?Vv4sLCu3nmytMA9icyPxZlbfeWDoFAaWxlsypfaBnCQdGhWuAxoJRI48qqws?=
 =?us-ascii?Q?OVVk9+MAmiDU8TQjiX3k9XR6eEZlQOjtlcuzcwJKX1Qvsv2AY23HKec423mb?=
 =?us-ascii?Q?4u9WN10f76bxQ7K4+IWotQzm0XVfndX6QkY5NP/QpsLCS1/MfeY5oC8GH0zt?=
 =?us-ascii?Q?84uIZ4jpbFV1Vv8cTNq6/1Ne9vWRRO/CzJKkt1NjsL5M1rw/7r/KRvyAQPbh?=
 =?us-ascii?Q?oPRp6jn4zNREJRyp92aS8nSu2MpDG5SbY30q/N6Z7mnWN6j1FA2ozI/P6Mkl?=
 =?us-ascii?Q?8sBf1VLeH/iOvi8fDSRMPnHnvaDpT3J5OyhFB2hkKM2QgbbxTXgvTdEEtWjH?=
 =?us-ascii?Q?/qQVVi7Yf1qdlga6StdJTyV4vaBXDEj9HI3n7zaIbL/aqyb7jWw9xIIGGK0Z?=
 =?us-ascii?Q?jP+EJ3XQsjy6ogS+BTTcor0i+5pmA5w+hhEsVOrwFpMBWhaWn3lSQ6C2/JVx?=
 =?us-ascii?Q?koAuuWt+wGdzqn5s6IrKK4pzE/jaR6LJ+zYCxE1Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7ccaab-8c27-4411-0acd-08dcc11646a2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 12:47:39.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ve5g0LXMMCb8flo9wmVXgMLuaMk5UmN/LjHDJyUMpAaeqQt3OHbnlb8mnEc/akqXTSgmducPf77Ryi38cB/zloKPwXf4IzK1Rlum0duq37A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5054
X-OriginatorOrg: intel.com

On Tue, Aug 20, 2024 at 02:31:51PM +0200, Maciej Fijalkowski wrote:
> On Mon, Aug 19, 2024 at 12:05:38PM +0200, Larysa Zaremba wrote:
> > Currently, netif_queue_set_napi() is called from ice_vsi_rebuild() that is
> > not rtnl-locked when called from the reset. This creates the need to take
> > the rtnl_lock just for a single function and complicates the
> > synchronization with .ndo_bpf. At the same time, there no actual need to
> > fill napi-to-queue information at this exact point.
> > 
> > Fill napi-to-queue information when opening the VSI and clear it when the
> > VSI is being closed. Those routines are already rtnl-locked.
> > 
> > Also, rewrite napi-to-queue assignment in a way that prevents inclusion of
> > XDP queues, as this leads to out-of-bounds writes, such as one below.
> > 
> > [  +0.000004] BUG: KASAN: slab-out-of-bounds in netif_queue_set_napi+0x1c2/0x1e0
> > [  +0.000012] Write of size 8 at addr ffff889881727c80 by task bash/7047
> > [  +0.000006] CPU: 24 PID: 7047 Comm: bash Not tainted 6.10.0-rc2+ #2
> > [  +0.000004] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
> > [  +0.000003] Call Trace:
> > [  +0.000003]  <TASK>
> > [  +0.000002]  dump_stack_lvl+0x60/0x80
> > [  +0.000007]  print_report+0xce/0x630
> > [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > [  +0.000007]  ? __virt_addr_valid+0x1c9/0x2c0
> > [  +0.000005]  ? netif_queue_set_napi+0x1c2/0x1e0
> > [  +0.000003]  kasan_report+0xe9/0x120
> > [  +0.000004]  ? netif_queue_set_napi+0x1c2/0x1e0
> > [  +0.000004]  netif_queue_set_napi+0x1c2/0x1e0
> > [  +0.000005]  ice_vsi_close+0x161/0x670 [ice]
> > [  +0.000114]  ice_dis_vsi+0x22f/0x270 [ice]
> > [  +0.000095]  ice_pf_dis_all_vsi.constprop.0+0xae/0x1c0 [ice]
> > [  +0.000086]  ice_prepare_for_reset+0x299/0x750 [ice]
> > [  +0.000087]  pci_dev_save_and_disable+0x82/0xd0
> > [  +0.000006]  pci_reset_function+0x12d/0x230
> > [  +0.000004]  reset_store+0xa0/0x100
> > [  +0.000006]  ? __pfx_reset_store+0x10/0x10
> > [  +0.000002]  ? __pfx_mutex_lock+0x10/0x10
> > [  +0.000004]  ? __check_object_size+0x4c1/0x640
> > [  +0.000007]  kernfs_fop_write_iter+0x30b/0x4a0
> > [  +0.000006]  vfs_write+0x5d6/0xdf0
> > [  +0.000005]  ? fd_install+0x180/0x350
> > [  +0.000005]  ? __pfx_vfs_write+0x10/0xA10
> > [  +0.000004]  ? do_fcntl+0x52c/0xcd0
> > [  +0.000004]  ? kasan_save_track+0x13/0x60
> > [  +0.000003]  ? kasan_save_free_info+0x37/0x60
> > [  +0.000006]  ksys_write+0xfa/0x1d0
> > [  +0.000003]  ? __pfx_ksys_write+0x10/0x10
> > [  +0.000002]  ? __x64_sys_fcntl+0x121/0x180
> > [  +0.000004]  ? _raw_spin_lock+0x87/0xe0
> > [  +0.000005]  do_syscall_64+0x80/0x170
> > [  +0.000007]  ? _raw_spin_lock+0x87/0xe0
> > [  +0.000004]  ? __pfx__raw_spin_lock+0x10/0x10
> > [  +0.000003]  ? file_close_fd_locked+0x167/0x230
> > [  +0.000005]  ? syscall_exit_to_user_mode+0x7d/0x220
> > [  +0.000005]  ? do_syscall_64+0x8c/0x170
> > [  +0.000004]  ? do_syscall_64+0x8c/0x170
> > [  +0.000003]  ? do_syscall_64+0x8c/0x170
> > [  +0.000003]  ? fput+0x1a/0x2c0
> > [  +0.000004]  ? filp_close+0x19/0x30
> > [  +0.000004]  ? do_dup2+0x25a/0x4c0
> > [  +0.000004]  ? __x64_sys_dup2+0x6e/0x2e0
> > [  +0.000002]  ? syscall_exit_to_user_mode+0x7d/0x220
> > [  +0.000004]  ? do_syscall_64+0x8c/0x170
> > [  +0.000003]  ? __count_memcg_events+0x113/0x380
> > [  +0.000005]  ? handle_mm_fault+0x136/0x820
> > [  +0.000005]  ? do_user_addr_fault+0x444/0xa80
> > [  +0.000004]  ? clear_bhb_loop+0x25/0x80
> > [  +0.000004]  ? clear_bhb_loop+0x25/0x80
> > [  +0.000002]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  +0.000005] RIP: 0033:0x7f2033593154
> > 
> > Fixes: 080b0c8d6d26 ("ice: Fix ASSERT_RTNL() warning during certain scenarios")
> 
> Shouldn't you include:
> Fixes: 91fdbce7e8d6 ("ice: Add support in the driver for associating queue with napi")
> 
> as we were iterating over XDP rings that were attached to q_vectors from
> the very beginning?
>

I probably should have done this.
 
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> > Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_base.c |  11 +-
> >  drivers/net/ethernet/intel/ice/ice_lib.c  | 129 ++++++----------------
> >  drivers/net/ethernet/intel/ice/ice_lib.h  |  10 +-
> >  drivers/net/ethernet/intel/ice/ice_main.c |  17 ++-
> >  4 files changed, 49 insertions(+), 118 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> > index f448d3a84564..c158749a80e0 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_base.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> > @@ -190,16 +190,11 @@ static void ice_free_q_vector(struct ice_vsi *vsi, int v_idx)
> >  	}
> >  	q_vector = vsi->q_vectors[v_idx];
> >  
> > -	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
> > -		ice_queue_set_napi(vsi, tx_ring->q_index, NETDEV_QUEUE_TYPE_TX,
> > -				   NULL);
> > +	ice_for_each_tx_ring(tx_ring, vsi->q_vectors[v_idx]->tx)
> >  		tx_ring->q_vector = NULL;
> > -	}
> > -	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
> > -		ice_queue_set_napi(vsi, rx_ring->q_index, NETDEV_QUEUE_TYPE_RX,
> > -				   NULL);
> > +
> > +	ice_for_each_rx_ring(rx_ring, vsi->q_vectors[v_idx]->rx)
> >  		rx_ring->q_vector = NULL;
> > -	}
> >  
> >  	/* only VSI with an associated netdev is set up with NAPI */
> >  	if (vsi->netdev)
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 03c4df4ed585..5f2ddcaf7031 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -2286,9 +2286,6 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
> >  
> >  		ice_vsi_map_rings_to_vectors(vsi);
> >  
> > -		/* Associate q_vector rings to napi */
> > -		ice_vsi_set_napi_queues(vsi);
> > -
> >  		vsi->stat_offsets_loaded = false;
> >  
> >  		/* ICE_VSI_CTRL does not need RSS so skip RSS processing */
> > @@ -2621,6 +2618,7 @@ void ice_vsi_close(struct ice_vsi *vsi)
> >  	if (!test_and_set_bit(ICE_VSI_DOWN, vsi->state))
> >  		ice_down(vsi);
> >  
> > +	ice_vsi_clear_napi_queues(vsi);
> >  	ice_vsi_free_irq(vsi);
> >  	ice_vsi_free_tx_rings(vsi);
> >  	ice_vsi_free_rx_rings(vsi);
> > @@ -2687,120 +2685,55 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
> >  }
> >  
> >  /**
> > - * __ice_queue_set_napi - Set the napi instance for the queue
> > - * @dev: device to which NAPI and queue belong
> > - * @queue_index: Index of queue
> > - * @type: queue type as RX or TX
> > - * @napi: NAPI context
> > - * @locked: is the rtnl_lock already held
> > - *
> > - * Set the napi instance for the queue. Caller indicates the lock status.
> > - */
> > -static void
> > -__ice_queue_set_napi(struct net_device *dev, unsigned int queue_index,
> > -		     enum netdev_queue_type type, struct napi_struct *napi,
> > -		     bool locked)
> > -{
> > -	if (!locked)
> > -		rtnl_lock();
> > -	netif_queue_set_napi(dev, queue_index, type, napi);
> > -	if (!locked)
> > -		rtnl_unlock();
> > -}
> > -
> > -/**
> > - * ice_queue_set_napi - Set the napi instance for the queue
> > - * @vsi: VSI being configured
> > - * @queue_index: Index of queue
> > - * @type: queue type as RX or TX
> > - * @napi: NAPI context
> > + * ice_vsi_set_napi_queues
> > + * @vsi: VSI pointer
> >   *
> > - * Set the napi instance for the queue. The rtnl lock state is derived from the
> > - * execution path.
> > + * Associate queue[s] with napi for all vectors.
> > + * The caller must hold rtnl_lock.
> >   */
> > -void
> > -ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
> > -		   enum netdev_queue_type type, struct napi_struct *napi)
> > +void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
> 
> this appears to be called only in ice_main.c. It should be moved there and
> made a static function instead of having it in ice_lib.c.
> 
> Unless I overlooked something...
>

You are not missing anything, but I think there is more value in keeping the 
set-clear functions together and ice_lib.c is a good place for that.

> >  {
> > -	struct ice_pf *pf = vsi->back;
> > +	struct net_device *netdev = vsi->netdev;
> > +	int q_idx, v_idx;
> >  
> > -	if (!vsi->netdev)
> > +	if (!netdev)
> >  		return;
> >  
> > -	if (current_work() == &pf->serv_task ||
> > -	    test_bit(ICE_PREPARED_FOR_RESET, pf->state) ||
> > -	    test_bit(ICE_DOWN, pf->state) ||
> > -	    test_bit(ICE_SUSPENDED, pf->state))
> > -		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
> > -				     false);
> > -	else
> > -		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
> > -				     true);
> > -}
> > +	ice_for_each_rxq(vsi, q_idx)
> > +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
> > +				     &vsi->rx_rings[q_idx]->q_vector->napi);
> >  
> > -/**
> > - * __ice_q_vector_set_napi_queues - Map queue[s] associated with the napi
> > - * @q_vector: q_vector pointer
> > - * @locked: is the rtnl_lock already held
> > - *
> > - * Associate the q_vector napi with all the queue[s] on the vector.
> > - * Caller indicates the lock status.
> > - */
> > -void __ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked)
> > -{
> > -	struct ice_rx_ring *rx_ring;
> > -	struct ice_tx_ring *tx_ring;
> > -
> > -	ice_for_each_rx_ring(rx_ring, q_vector->rx)
> > -		__ice_queue_set_napi(q_vector->vsi->netdev, rx_ring->q_index,
> > -				     NETDEV_QUEUE_TYPE_RX, &q_vector->napi,
> > -				     locked);
> > -
> > -	ice_for_each_tx_ring(tx_ring, q_vector->tx)
> > -		__ice_queue_set_napi(q_vector->vsi->netdev, tx_ring->q_index,
> > -				     NETDEV_QUEUE_TYPE_TX, &q_vector->napi,
> > -				     locked);
> > +	ice_for_each_txq(vsi, q_idx)
> > +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
> > +				     &vsi->tx_rings[q_idx]->q_vector->napi);
> >  	/* Also set the interrupt number for the NAPI */
> > -	netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
> > -}
> > -
> > -/**
> > - * ice_q_vector_set_napi_queues - Map queue[s] associated with the napi
> > - * @q_vector: q_vector pointer
> > - *
> > - * Associate the q_vector napi with all the queue[s] on the vector
> > - */
> > -void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector)
> > -{
> > -	struct ice_rx_ring *rx_ring;
> > -	struct ice_tx_ring *tx_ring;
> > -
> > -	ice_for_each_rx_ring(rx_ring, q_vector->rx)
> > -		ice_queue_set_napi(q_vector->vsi, rx_ring->q_index,
> > -				   NETDEV_QUEUE_TYPE_RX, &q_vector->napi);
> > +	ice_for_each_q_vector(vsi, v_idx) {
> > +		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
> >  
> > -	ice_for_each_tx_ring(tx_ring, q_vector->tx)
> > -		ice_queue_set_napi(q_vector->vsi, tx_ring->q_index,
> > -				   NETDEV_QUEUE_TYPE_TX, &q_vector->napi);
> > -	/* Also set the interrupt number for the NAPI */
> > -	netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
> > +		netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
> > +	}
> >  }
> >  
> >  /**
> > - * ice_vsi_set_napi_queues
> > + * ice_vsi_clear_napi_queues
> >   * @vsi: VSI pointer
> >   *
> > - * Associate queue[s] with napi for all vectors
> > + * Clear the association between all VSI queues queue[s] and napi.
> > + * The caller must hold rtnl_lock.
> >   */
> > -void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
> > +void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
> >  {
> > -	int i;
> > +	struct net_device *netdev = vsi->netdev;
> > +	int q_idx;
> >  
> > -	if (!vsi->netdev)
> > +	if (!netdev)
> >  		return;
> >  
> > -	ice_for_each_q_vector(vsi, i)
> > -		ice_q_vector_set_napi_queues(vsi->q_vectors[i]);
> > +	ice_for_each_txq(vsi, q_idx)
> > +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX, NULL);
> > +
> > +	ice_for_each_rxq(vsi, q_idx)
> > +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX, NULL);
> >  }
> >  
> >  /**
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
> > index 94ce8964dda6..36d86535695d 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.h
> > @@ -44,16 +44,10 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
> >  struct ice_vsi *
> >  ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params);
> >  
> > -void
> > -ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
> > -		   enum netdev_queue_type type, struct napi_struct *napi);
> > -
> > -void __ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked);
> > -
> > -void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector);
> > -
> >  void ice_vsi_set_napi_queues(struct ice_vsi *vsi);
> >  
> > +void ice_vsi_clear_napi_queues(struct ice_vsi *vsi);
> > +
> >  int ice_vsi_release(struct ice_vsi *vsi);
> >  
> >  void ice_vsi_close(struct ice_vsi *vsi);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 66820ed5e969..2d286a4609a5 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -3537,11 +3537,9 @@ static void ice_napi_add(struct ice_vsi *vsi)
> >  	if (!vsi->netdev)
> >  		return;
> >  
> > -	ice_for_each_q_vector(vsi, v_idx) {
> > +	ice_for_each_q_vector(vsi, v_idx)
> >  		netif_napi_add(vsi->netdev, &vsi->q_vectors[v_idx]->napi,
> >  			       ice_napi_poll);
> > -		__ice_q_vector_set_napi_queues(vsi->q_vectors[v_idx], false);
> > -	}
> >  }
> >  
> >  /**
> > @@ -5519,7 +5517,9 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
> >  		if (ret)
> >  			goto err_reinit;
> >  		ice_vsi_map_rings_to_vectors(pf->vsi[v]);
> > +		rtnl_lock();
> >  		ice_vsi_set_napi_queues(pf->vsi[v]);
> > +		rtnl_unlock();
> >  	}
> >  
> >  	ret = ice_req_irq_msix_misc(pf);
> > @@ -5533,8 +5533,12 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
> >  
> >  err_reinit:
> >  	while (v--)
> > -		if (pf->vsi[v])
> > +		if (pf->vsi[v]) {
> > +			rtnl_lock();
> > +			ice_vsi_clear_napi_queues(pf->vsi[v]);
> > +			rtnl_unlock();
> >  			ice_vsi_free_q_vectors(pf->vsi[v]);
> > +		}
> >  
> >  	return ret;
> >  }
> > @@ -5599,6 +5603,9 @@ static int ice_suspend(struct device *dev)
> >  	ice_for_each_vsi(pf, v) {
> >  		if (!pf->vsi[v])
> >  			continue;
> > +		rtnl_lock();
> > +		ice_vsi_clear_napi_queues(pf->vsi[v]);
> > +		rtnl_unlock();
> >  		ice_vsi_free_q_vectors(pf->vsi[v]);
> >  	}
> >  	ice_clear_interrupt_scheme(pf);
> > @@ -7434,6 +7441,8 @@ int ice_vsi_open(struct ice_vsi *vsi)
> >  		err = netif_set_real_num_rx_queues(vsi->netdev, vsi->num_rxq);
> >  		if (err)
> >  			goto err_set_qs;
> > +
> > +		ice_vsi_set_napi_queues(vsi);
> >  	}
> >  
> >  	err = ice_up_complete(vsi);
> > -- 
> > 2.43.0
> > 

