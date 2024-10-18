Return-Path: <bpf+bounces-42416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86779A3E38
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 14:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0ABA1C2367E
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 12:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65269208AD;
	Fri, 18 Oct 2024 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7QAc2g/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC718028;
	Fri, 18 Oct 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254088; cv=fail; b=bi4YH+yatFhE31+fpBxsviaNXp07wfTNFIqDUa8x6MYrbwfrvHcm0hDgVxxoKTt1ufIejoANDW+ICL+kFnt1BlP0E4wxIsvvhOei8d9b8uUx/ieZbHxroI16D6Y989GRe/N4tsE6rNrr7G6vypiElSlvHK9MQKeUW3UtLhQbrZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254088; c=relaxed/simple;
	bh=vOaXVw8hv+jxpgvf7i9ilP4dgE4Tlh44PwWrrScQgfw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zk3oGTHJD4EBqVBtJaeER8oLxnz4DHQ058+HGDsWZhfH+KwHqSQ+KTW1UaCaAfqFngLfdnDAfL/jBK8xRoDt52votfQVp7stTztlXh2keca3Cb1WXIvOhXuTYKGvZmClID0VM5fPiPpfJlsyKlQny20TWJvmIbmzirDoSamCFDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7QAc2g/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729254087; x=1760790087;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vOaXVw8hv+jxpgvf7i9ilP4dgE4Tlh44PwWrrScQgfw=;
  b=l7QAc2g/TchqZlhVU8YT5jeNirSmC0q0ifQHogekobrGMisfVBgnU8oG
   yWhg6YTTFMc/+jzg/g3afH8LdJL4BLS6aDAUZS2T6Inmm8bzQsZW9Cif4
   k1AWhDl8pv9kGeZuX9+kde/HyTz315l18sfXL62dSPvFwXFEZ9vjBPtp0
   NU27YNLsnexkPjvlOfFujcPbP/I4IBWWEd4OSUD7D0DIWcvcWkmEcd0Fv
   WHPGzXX0jqmm7MqLe5AZbriQnpnaRE5e2bWIiPG63JaIbwHmni/m3bbFc
   dQ6oObeZCnH17dkRhVA6Gfk1erxQAzoV/fysyQZYu+dynJLPtOZJswypD
   w==;
X-CSE-ConnectionGUID: 8QjnvhOaTBu+tb9z3NKhmg==
X-CSE-MsgGUID: Ib8+8paLS8KAeQkHo8yo/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28888928"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28888928"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:21:26 -0700
X-CSE-ConnectionGUID: Cv145CrvTlqlhxSScQPqiw==
X-CSE-MsgGUID: KoPbG03TTS2414PrkxotVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79203182"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 05:21:26 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 05:21:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 05:21:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 05:21:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 05:21:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 05:21:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsWS6pXYWnkjhWAJNxc4lKSUOajMOoEoeJeP68sU7sp4kQbmVyRHlq32syNLH+vRdh+raBha9uTJdfs6JKpXF7juVc3mgLPc9MbiWNhkJX6YTlKY6WNm+eFkXjuy5qAf9NdagGCgyCmyrrsFPGJSEQmcX0NasUxRcM0LyqxgASnMbpydXLvX4hynGN/2AFlisfS11zP+5+bPvyllpHIP5FzYUMzX7jJpPQtBP54UMaq3jYimZ31vA8QG+shxRM0IOOZmzDytHRye3rYprNSPqAjIJa2+6ZeG55EJuh1Tce/XCYLcy3wTe+cs5/ooby3NGq5xh0ApfTRPIP2nCHsDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEBDJDvuIsX7+YgELuxoaPcM/T1clL+M2JJAm6jRcQs=;
 b=E0b8AQNtmJYSMqmq29tmYHXnfX/43iZ/oWH/Q/cpE92IRB70XH700Uqg6OZdcNK9sxdMuTeM5ZS4sP/dxiL/gB7J1m/nLqo5OOARC56hFwwFgCMpfGcZBfYPg3tFwLIFeii5wIL9HzRec6pN/OmDRW8esh1f5R4jpbJMd/78eOPyYhuqOQDJxO2VfpejbJZhlPjI/WWMNys4pQU9Lrlfi13QgaANNWarsEWMdzYCDWaO+33rU0KrGCYgiXjJ5eabGnuvubnwDlHqLU2uzCl1LMK+L64Edy5zOTJiTl+c3SXg/otgzqf5yZsXXNPLu4O1vz3N0ULrR3NEgIcSZwgvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM6PR11MB4737.namprd11.prod.outlook.com (2603:10b6:5:2a2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.23; Fri, 18 Oct 2024 12:21:23 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 12:21:23 +0000
Date: Fri, 18 Oct 2024 14:21:15 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Yue Haibing <yuehaibing@huawei.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH v2 net 2/4] igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
Message-ID: <ZxJSu8uIaAF23MJ4@boxer>
References: <20241018023734.1912166-1-yuehaibing@huawei.com>
 <20241018023734.1912166-3-yuehaibing@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018023734.1912166-3-yuehaibing@huawei.com>
X-ClientProxiedBy: WA2P291CA0037.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM6PR11MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3c49ac-8684-4f4f-831a-08dcef6f612f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YT8FV1ln454wIhJAHQcN45QXbOzqrT0yjb8ScJ/zyO6KYfUZO4QZIoDxI+1A?=
 =?us-ascii?Q?px+ovYu7iZe6+m+OX0qf+UCU00S/Q6SrP3hxJl6URUb9S/hh+stMuwx3sEsK?=
 =?us-ascii?Q?yoTkjizXxj4g4jWJlx5CEg4hHY+WtlNoYwvAn+lw3OlnZKgYIyD1vPSCOx68?=
 =?us-ascii?Q?ymRPEbaFLOBz8FFr+ytpcFqaNULyaOS+7XnDTRXzHDhnOqMy2Ayig9qPS2J+?=
 =?us-ascii?Q?0nAxxvWkK/GYd10HSZ5bLhPteXfI79CG5+fwRpkbZwBdbgEi7KcRfOp6S0KB?=
 =?us-ascii?Q?gifrAZirqSyJ+2KOMcAvfhvGzK6eX7F5fr+Bg4oe+Tm3yCzUvGnDZI2TxGhA?=
 =?us-ascii?Q?yNdtmI9FAdR32TNJwqjdvp1IMpVE1216l5tGrl6Tim2B7r6Ieyat97dJi5Zi?=
 =?us-ascii?Q?HHVfar/fG4hJQ1XQvokoG7c/+jXooh2JuVqDU1NDQSp+Y+7uGn2HCIqqb3I7?=
 =?us-ascii?Q?FBhtxq1V36VwNCjPPsN+YetJUUaYFo6LDNRiUoPBFfou1mfX3q1i01FYkc1c?=
 =?us-ascii?Q?odpSeYR0d8Ae7z7AvB6PaXr7ZL09/VWU9uibssyYEfaMZd4Crn0cVQHMtcT5?=
 =?us-ascii?Q?Yl3xrfevQLoOvzZwzcPxplbpZbRdAvfKWl2ODj+USLdDQByNu2JGsFnSgNON?=
 =?us-ascii?Q?ajTgCsWmWFZ3wWe3TuAnUo2zOeHp8jsnJp14CQjqr71cMYaLaHSltziwer/H?=
 =?us-ascii?Q?FAaoyB0Z8R/3h4+XFB6d2qdQCL1Gik1NTHQACBd2ZJ7GH0bi+VnDPoQhaGnR?=
 =?us-ascii?Q?3rhs1Wg07Iu9K07SLNQ6P027jpSsqVo1I8FA6Ut5H7PJ4N0uKCLHeFkiJd72?=
 =?us-ascii?Q?7+crZc1+0vBOiHnF/A2N877Vzv4oC7HCdLAt30wXdJY1NjaS5iPpS1It8VwB?=
 =?us-ascii?Q?m6ron8bRtMBBp/A1WBYOH6pB+cEI9eZtZGFCbh7xRHKTlODr7SOpcdySa5Ea?=
 =?us-ascii?Q?Ie+mXtAM8l4lB4aTItmFgupCrmkT0QT484C3/8W4VEg3pJtumVZC2Byzvsxu?=
 =?us-ascii?Q?QF8wLklgNuNKi0R5C5SLMz1dHG4jUyM97YjJvQ1X+IZLtzTy35dCGY9Nu+Xy?=
 =?us-ascii?Q?MMjhBwlatK4CZhP0BdL9xnuCCAXq/QXQb95v02XF8SuhjcstUJ3U0ebr15aO?=
 =?us-ascii?Q?I9CkxeapKVZsysJk7d3kfYNa+O1lRr/G+SA6i8FuB4f/fF9nMA65fweyLssP?=
 =?us-ascii?Q?Qk6X8PS9tNAWLgHwzKs+K45A0NZw8e84rWHFtkwvIRnPIxdMA8wjtGmjPqp8?=
 =?us-ascii?Q?v1FAtuzzfBuSh+ZTWYTNeYFzntE1SnEsKLngpY1scO7zGvuYE0vN7z5bB8um?=
 =?us-ascii?Q?3t7PLvRpIJ00/ycYWmgRPu9+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HjnToust8AiWtBWpKcwMBOZzaYmfmDrtCoAoXgNnCGk7vlLvZCJP05IGunhg?=
 =?us-ascii?Q?j1sHPIiid1W8w/0D8HM0jyc1Jf1doOREhLzY7OPq6zD2G9CC3ElJu4FJk+wL?=
 =?us-ascii?Q?cLs5VsEW2Sh9vO3FLmuh6Zu7V1HIypPW9Kt3+SJRASQ+RgvLNAtUEnmkCcjB?=
 =?us-ascii?Q?0QRMhl8n2Pz3Gy1i2zGajTAUDcbkiIG/oB1llMsOs3zli+TejOuFLWw9N4P8?=
 =?us-ascii?Q?clW9hklk2QXl3I8Hjgj3G3gNe7g/x/lzUbPQN414YSGbCIvZH4ekSl+jYGvw?=
 =?us-ascii?Q?7HtELCaHAekh8hl7ZGCnHBpusXEAe3sN6r+1TdbpbrqOu5hp+Y7i0HO35tc1?=
 =?us-ascii?Q?llhbRv30VxC/Q1mDzT/7CTVpymxioC1OfvP9odBArI/kFpmYA1nwaQq9t0LE?=
 =?us-ascii?Q?TWUEaT/82hFSH8ViWiNBqY4v2Dpz8OAmZf4s8WSO8K8O6ydV8las3T6Yvio0?=
 =?us-ascii?Q?U6U8wMMmn/zhAcjcm+ZB4ycGDdpJ6Yups8NVVqK1sxqNJWfGLLYuzKFnSJe8?=
 =?us-ascii?Q?SMtdTpHoG4l4Q/ldbQBUqjCr12kMozFE5T7tYFF055+Upn+fY+QuNmpGG/F/?=
 =?us-ascii?Q?q//Dr1tcZVJn5xThQIiA3rETI+f9OXgilWNK7l+XviOIKtOZ2Q2A4AnflZdZ?=
 =?us-ascii?Q?45WlYumW/9yWCmx+efogBz8XEUeBc9XWfHkfZ+n4HuAuLZE1LHusetGoiaNw?=
 =?us-ascii?Q?hmk1hJ2w0OLWZcYygFN9H8aDgfxPCsStLy3DnTqzXc0gpOsv2xwfTMl8mShd?=
 =?us-ascii?Q?RRdtNEKPkm8Qsql8RFneqMQN3VfqRiLX+vxlaoHfSEj/5np16inUQJrLb4Yl?=
 =?us-ascii?Q?eT+hkBoy4zXY+nxxMn9Ps1OZg0/VdXarGoTSgss4l9fy2kfi+tG99YszT4hR?=
 =?us-ascii?Q?CCgMaPL6n0aWp3GSzj7k7Ki3yl3F5CX7oqwT9vPN6rU+ONQ3/rj7Gzoxqc0Q?=
 =?us-ascii?Q?b1JPjQbbkGh5uOyhAp9iMLXepxI8foq9CxzX9rSJp6cH8HoGjIOQhT1dwmTu?=
 =?us-ascii?Q?KwfKdF6B8oFPMIeinSbbkOBCOhYeMjKV1ghHegXXBzpPveQkg7y3YZAAOq6W?=
 =?us-ascii?Q?ItuMF82B7EOSagoHoRU/QIPNivUnPy196be8SU8U5Mz9tKG1QRCxRL4rlMP1?=
 =?us-ascii?Q?fpTq4cj5lraKKUtY+qTjMIIpmf4uh4tBTg0YdBvECgTgzBeC4sIw2RQ+sYnM?=
 =?us-ascii?Q?W3dV9PeOE8FO23b9+MV3HGMrglMw5+QdIa1qYX1qwiOQcYWKXb0e3kJ6qSqU?=
 =?us-ascii?Q?xxUG6tOgEYmm1Psq0GRa5zhTUjK4+/xCZ1lXNwqxv4bkkZXq1Int6AGiNvaJ?=
 =?us-ascii?Q?yOZbGXFVJ+n/8CzxXCqWgDr2cR9erHU3xLKyWfLk4A22OXTHyRGX2M+mDybZ?=
 =?us-ascii?Q?kPQq59jJhiaSfahPNcMT2X+VgF3PEIqRAwJEPSrjeVE+QFMazGekLpCSVy+m?=
 =?us-ascii?Q?7QjnDEjOkpBi5E7jCO+4Iu46qeWw8Tt0S+2I2BBZZJwQEzdbzBKUOaldj9s0?=
 =?us-ascii?Q?W0n7De17G/k84sYHEMkAiUlKcz4ZK/ocekGbE4hjOxViwt8bujZzXVZdfVJW?=
 =?us-ascii?Q?vxt4ENXl3jZLWuD6FHkuLihO26TpeeVm9W98vUWn4HsbeCReMi7vr2QrsgXX?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3c49ac-8684-4f4f-831a-08dcef6f612f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 12:21:23.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VW6lt/zz79Q/sCST5Bhfnb6st1OZFwEPUKPeINfN7xv1Y1p8mjebj17AyUKhVeadnaWV4funzD3A4kMGWLnp0cLfeLalvosd2N+y+6i6BBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com

On Fri, Oct 18, 2024 at 10:37:32AM +0800, Yue Haibing wrote:
> igb_run_xdp() converts customed xdp action to a negative error code
> with the sk_buff pointer type which be checked with IS_ERR in
> igb_clean_rx_irq(). Remove this error pointer handing instead use plain
> int return value.
> 
> Fixes: 9cbc948b5a20 ("igb: add XDP support")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index f1d088168723..50c23dfcf304 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -8584,9 +8584,8 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
>  	return skb;
>  }
>  
> -static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
> -				   struct igb_ring *rx_ring,
> -				   struct xdp_buff *xdp)
> +static int igb_run_xdp(struct igb_adapter *adapter, struct igb_ring *rx_ring,
> +		       struct xdp_buff *xdp)
>  {
>  	int err, result = IGB_XDP_PASS;
>  	struct bpf_prog *xdp_prog;
> @@ -8626,7 +8625,7 @@ static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
>  		break;
>  	}
>  xdp_out:
> -	return ERR_PTR(-result);
> +	return result;
>  }
>  
>  static unsigned int igb_rx_frame_truesize(struct igb_ring *rx_ring,
> @@ -8752,10 +8751,6 @@ static bool igb_cleanup_headers(struct igb_ring *rx_ring,
>  				union e1000_adv_rx_desc *rx_desc,
>  				struct sk_buff *skb)
>  {
> -	/* XDP packets use error pointer so abort at this point */
> -	if (IS_ERR(skb))
> -		return true;
> -
>  	if (unlikely((igb_test_staterr(rx_desc,
>  				       E1000_RXDEXT_ERR_FRAME_ERR_MASK)))) {
>  		struct net_device *netdev = rx_ring->netdev;
> @@ -8879,6 +8874,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  	struct xdp_buff xdp;
>  	u32 frame_sz = 0;
>  	int rx_buf_pgcnt;
> +	int xdp_res = 0;
>  
>  	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
>  #if (PAGE_SIZE < 8192)
> @@ -8936,12 +8932,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  			/* At larger PAGE_SIZE, frame_sz depend on len size */
>  			xdp.frame_sz = igb_rx_frame_truesize(rx_ring, size);
>  #endif
> -			skb = igb_run_xdp(adapter, rx_ring, &xdp);
> +			xdp_res = igb_run_xdp(adapter, rx_ring, &xdp);
>  		}
>  
> -		if (IS_ERR(skb)) {
> -			unsigned int xdp_res = -PTR_ERR(skb);
> -
> +		if (xdp_res) {
>  			if (xdp_res & (IGB_XDP_TX | IGB_XDP_REDIR)) {
>  				xdp_xmit |= xdp_res;
>  				igb_rx_buffer_flip(rx_ring, rx_buffer, size);
> @@ -8960,7 +8954,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  						&xdp, timestamp);
>  
>  		/* exit if we failed to retrieve a buffer */
> -		if (!skb) {
> +		if (!xdp_res && !skb) {
>  			rx_ring->rx_stats.alloc_failed++;
>  			rx_buffer->pagecnt_bias++;
>  			break;
> @@ -8974,7 +8968,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  			continue;
>  
>  		/* verify the packet layout is correct */
> -		if (igb_cleanup_headers(rx_ring, rx_desc, skb)) {
> +		if (xdp_res || igb_cleanup_headers(rx_ring, rx_desc, skb)) {
>  			skb = NULL;
>  			continue;
>  		}
> -- 
> 2.34.1
> 
> 

