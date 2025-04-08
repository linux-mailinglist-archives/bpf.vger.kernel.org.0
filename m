Return-Path: <bpf+bounces-55475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97323A812DA
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 18:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C053B8A0405
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50C722FE07;
	Tue,  8 Apr 2025 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+oR42MK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA31A9B3F
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130932; cv=fail; b=IxP0Wf/NL+3r7XM/ppOo9EwOZvkWyNaYpkbsgqvE0ksBfrUxR18BzNqv9GU5XgYGi8czqVf8WETIIaG5VOq8dQ+F9nb/BRFrLzA5oLb16UaVfHIP9Jlszovo3HZK29kTM4dLqhfYjK3rX0b3q4tb26lPi8g5xBqh1x9ZWSu7j3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130932; c=relaxed/simple;
	bh=tsLqRGCMLwCbfBHMoJFPrV66pMRnsg2hLLW9HEpHQaE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pXDs/H8sjBsfjSAZo8ppzK+8it0fz3CMfNDqHXZSDiEjoVA+gF4kZLxOZHrIZFr6uIXWb35dD23lL4ypPDOsuxRk6iOh/mfMzubEPg1/KPU/Y/II5W2eTdnJWc1YNOPzMRk0uoC3aMpM2mZjBGishb4lVvLe1JS4oS0Hd9In18A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+oR42MK; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744130930; x=1775666930;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tsLqRGCMLwCbfBHMoJFPrV66pMRnsg2hLLW9HEpHQaE=;
  b=Y+oR42MKvEq9RtTEXWWslU3GWH+N2oRCcJcb1IcYk/S04EHvYzn8fHbr
   2ubK5k9JVDgwzXvnw/qtBYaMJ+l68/foUY3YF6YKGS0WA6KUn1PYSVmKX
   Ge9whOJj+T53uYKyi2rF+IDg0xpx/0oQ8K45P2qM6QwClbOtt+gGZBmg9
   6vZRcpp1TkuGEcWpHDTO3PlfMhlAel6XxLM7owGzXFSHtPZy7kQIrbJkT
   IG+Chfz1K/6DErWC85/rsXXEKRVaq1LPiHmSsnlCAUfh2CUj817iNP0Ko
   bMMvG3Nm633KMevDhM/i+7B7ESEnnRrKipCZQqWduMUEWVh0Gi7vzWzuq
   w==;
X-CSE-ConnectionGUID: yAjKScMsQaCF0rENOymkkQ==
X-CSE-MsgGUID: DdhyqqtBRN20dnqKjEzxuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44719658"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="44719658"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 09:48:49 -0700
X-CSE-ConnectionGUID: P4TT6aaDR0K+Q1MqQ127Ww==
X-CSE-MsgGUID: TmNMN9hmSReW6eHkn9JLxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="129172004"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 09:48:49 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 8 Apr 2025 09:48:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 8 Apr 2025 09:48:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 09:48:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkcSy3sI4AjqVYyVsTDBuGUgCW2NVWUaHgh912jpUnXIFd8XL46AtQcNUT28WZuS/S+lF0p/YmdHspXLBLFHv5SoPSBrk++4JwuJPvyF3AMbyhrWv9g//2SNNAnk25vhpIgWh8xN/PMsTBRIecGNq8pYfxA7IqwjJaV2tJU84bNgp1dO9DWLmN08JmkOSEBc2J9y3D83civpzXZ9KYWf9BmZkgfG8l//YFevjGp0Lxd/ENzS6rlSsnRLPPyUF+owq7QI/njoXHFSBCT8WK+/Zqho7ZXkifeqnZDCcpoNGpA7fzikZLBXJ5iz0SJJKxM0JwMV/Orkx8UhRpQBhSek/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0Hp5xGQoXXUX9YHd7NfLY135tvdUu3H2K9l33Z6KDE=;
 b=TSyupYgwIeGaQL48QVfTc/AIVXb2opojzBClYkPTQcWJnl1lg7PEosfcK/3m/Mdpk2RD4VzMTYZzQOdRUiCAgqTsWLHTa9MRw6rfsZfYqIarGhnv5PNNGIs8WNXDsx50JHrXlcSh+fgd24bXuPHb78MNULhogHyeDT+CCLPA7mBrSWElM0sRnmgfF9xX7gDvxpudL3LPXyLrZayasUtt1eF1Jl9ZePps+hhmK9Ptch5RH6Tbno/5hYicnXjG1Y2peT/cpPIYpWH+WLkLohBrUi1OrwR7JBb9ORZWCfg+MnqcAJPZU4aSRtWJMdfyFpY77UV1bfi7c1k3zZp5Q7Rxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Tue, 8 Apr 2025 16:48:18 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 16:48:18 +0000
Date: Tue, 8 Apr 2025 18:48:07 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
CC: <bpf@vger.kernel.org>
Subject: Re: [PATCH v2] bpf: fix possible endless loop in BPF map iteration
Message-ID: <Z/VTR14/96xh9D8L@boxer>
References: <Z_VHqKdPYm0DhyRQ@bkammerd-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z_VHqKdPYm0DhyRQ@bkammerd-mobl>
X-ClientProxiedBy: DB8PR09CA0029.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::42) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA0PR11MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: 1405e9ed-bbfd-4d02-0f32-08dd76bd29d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XFsS38jfo/CjEVDkzlggJJjrVmHXGeRLsM/YKdkQ4jZjEapR7YLkzggbUvjX?=
 =?us-ascii?Q?/mwAZAhEbw45J2AjyFP/Zj/4rZeSpqnG3cyLeJ7X0DPCwzpYTvDv7Xo8O8gk?=
 =?us-ascii?Q?GVMO2t36HuhqW4y8uJM1BihC/Fe2bwwJ+OBJaGCZyiOGxZyyuN4PGLPcUNwq?=
 =?us-ascii?Q?aC5iZ1VthtQjjbR+RghZfO8Bqa4nxE6bIb2OKffvtV8glOyPqyw5P80wFRzW?=
 =?us-ascii?Q?Tqi1nu3cZ5UDwdNFui5n3YiutVwyfOqGIYQVHzBZfanWmpVuaGB0BOOiB+ym?=
 =?us-ascii?Q?gs05nVvrlxIOZS+higTvu1Zi+MjjJAIZIjukUiUsbGfcEo2ovNhY3t8TcIFx?=
 =?us-ascii?Q?CPiWHk1RwNyjY9u+AMG6iF+btBQvVHS/jSby4UG9f5I7VMT7rBNTBYwfnSlH?=
 =?us-ascii?Q?8oVsxkNEwevHs/+KxzEk3vkCWTyZoFgpkZMGQoEt7OnAQCsoAnXmP1q/p5Ub?=
 =?us-ascii?Q?BGnrOQEoeqHVp5KPc8RqPAiqs0d4wYGDEYGgBNcdFvaYVO315tVqTqUer8fQ?=
 =?us-ascii?Q?Dq9Rj6cnXPYZ0cpwAj9LRWxitj1TqPNud9wfgNbmc9vFla09A1Juk1F8b0Vj?=
 =?us-ascii?Q?ZVC56IPcxiHvP/aNKAfDFgbaQiZ4U88Crb9TP6aUwtQz+h8jhU9i/2e6JyZH?=
 =?us-ascii?Q?GtbUkHfNPz7OJ+UxIRZjDkglrMvHkk6mzSZ4kuu5Oa1fl5XVgNXUyhSKnO57?=
 =?us-ascii?Q?GNzd9KKEKgSsNfwuXA4x4IFXvhCNL0gr7asjtpbDrLr1pqxcHqKhE81/hbd8?=
 =?us-ascii?Q?LVFMQkjzdbhE/KzBjuNObaPflreDjPoBvZdu6fYhYemadAjTlZljqaxHdMTz?=
 =?us-ascii?Q?YvAdx4KDsKD9e2cGNBQE2sTBNGh9nqJ4eZFiNYaCL0MQzzRXmxMHbG4VfM5e?=
 =?us-ascii?Q?WixH3XuFOUOLnw5pE46g/UtmBiWo0oJJPkeXN8NgVSh0tLy0sN+8P9RFecXV?=
 =?us-ascii?Q?M2kdDn8o/250LbxkLGrjEp97JMtXYXxWYsp+oxWZxuSweou2XB0c2ri9jk9n?=
 =?us-ascii?Q?M+oIUu+EZn2nX5+DFinNPNtVQ+HEY0yG90NW3Fm1e+OcXU1U4yCBK4QLOjhR?=
 =?us-ascii?Q?lrYJBMYbJLLui8esDn4A/nNMmxqLrTrpboRves1JJN35hsqtwVdZHuMvTWLJ?=
 =?us-ascii?Q?/M8j9Ul9D01hRBmWatisjnHAkVdVDmsHNyUP8XaTbFlowPK6ixxaOO26TqP9?=
 =?us-ascii?Q?Y7Dq/XUcdTDLaJ/vR1cczoQQ3a+ols+vaamC+eaRrwdcQHp9U7YsWeKob+4f?=
 =?us-ascii?Q?nSCt9LucuALaYgkwY9SqCtADoeCRNZNFoPbxA5k+U8yQsISXjsyQUaEoZrr9?=
 =?us-ascii?Q?hNlzirKtK5TtBQyANK73AOclbnbt4BJ7u1hoQjD12jZdeNU6jXXZ/6oxEa4W?=
 =?us-ascii?Q?l8BOGywdL/+PMVE77em0mCOEmEMX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EX84eOuoBcY/lZ7/YnVpM42NbOoereEH9RPSvUz7IdRcXJ4/EkbHPqn/k+w8?=
 =?us-ascii?Q?0F+RfLZ2cUO5WXoW+8wjg+yfclAm2pxiKW/GTCOGHYeFjOwfvmKl+WLGgGLh?=
 =?us-ascii?Q?JQBjX2+61UMNhHGNf74n4t5AEnijagKLEr0vEkTjuyU8oErOmt5BkVLDjr+q?=
 =?us-ascii?Q?beZaylExOPQcr/zqHr4XZubzYKz84U15ZPOEyii4LHdS90WGiFzuas5F78hv?=
 =?us-ascii?Q?0MWOS3tNQJI5L9qoHKP/lT5UDPjgkmJPczdedZKGrRqlvQEVJqIj9966Vcbu?=
 =?us-ascii?Q?V7hoc8lWTa4x75d3S9xTNPxQOdafLETppho5/sAfGkiybwNGkFyJ0yJXhdVI?=
 =?us-ascii?Q?appVyoh5MbL+b1agSLgA5pQghrt8Ds4Ra4TUN4e+OXS/1NFxRPLow7X9XXgo?=
 =?us-ascii?Q?8fnb8CReA6bd4dS5q8Er4VwuMv50+9c0WL3drTax1+xZ2ahxWR/kH47NWmBr?=
 =?us-ascii?Q?BCJv/bdpZ20X9ka9/na3Xose0daXJD2J9aZVb8egQX2D6E2S7q8smmmv628r?=
 =?us-ascii?Q?+XfXj0cdsm65y+ZzVrglwS7AOsfM23tBXcFM9A3sXgsbXHEOkTob/Xb7rZVw?=
 =?us-ascii?Q?VkWKLVPHsCvXzvybOsbEAuB3Ner9kGUPTNkspTO++s4pWzYc+TAcEUi06cYF?=
 =?us-ascii?Q?Un2Icf5axrBA/emIf5sgxEiNOFqbItwtguGEPIvHSg44Ls6RAsNTDyeq8eSx?=
 =?us-ascii?Q?NDaZf9JkInuMCnEBacRPSYb3bme1XpE6S2WlWtb7dSUeHvqQdFO+MoO0jlTt?=
 =?us-ascii?Q?ganlNywN/5g2FezSeZ6OA5rDVp1o7E3T028LL7sGqY1s1IjxMeddZj4i4ZxH?=
 =?us-ascii?Q?hTh1YAk4f0yJxYuW+lexlXXQsjvm36gFmiGN5fMH29MVFKxwjhTUD7dXtXvC?=
 =?us-ascii?Q?v9zVFv8DoF+HaIPJ8j7M++/dq5FB8QZqklIbxIk5l8nMNRZvFxlGL/eGhPeP?=
 =?us-ascii?Q?fOIezge13d+GxyAOcm5cEXBoLDerKTiWHlrBoelCB7kTL3Jeai+CW0DWqssX?=
 =?us-ascii?Q?isoH9BAwuSdOBaFDecoja3z0cfEyncCqqWSQT0DxCdWIvOAHto5SZ+5uvqWR?=
 =?us-ascii?Q?1cRX0yTFMnGUDCLQ0AqXx9XtVJzyEcm/+2huuTOuRmE44NWh/rtWWE5R7ftz?=
 =?us-ascii?Q?egv4QBNmZ0+2zJQqBYNBwjiPbDn+96NjEHVY98Ftts+tDQ3cWd1ZwLMrDLYx?=
 =?us-ascii?Q?v+q5elXVOh/V5FX9kOKkx+/kOLWE7iwlNaEUauo9P1o05LXpDLwCyRAtrJi2?=
 =?us-ascii?Q?XPpVzNrboJ8scqVUQuVoOt3X12j1PRt/h8sUHCasL9OeR7dMU6bVHMnlQcoX?=
 =?us-ascii?Q?4Ui9hHUh77U1p6kTFE580M4BVxgxAZ3FzN05im227nY6zf0fEvfrvCuBOQy7?=
 =?us-ascii?Q?oXm1mPBVubBbpKAwHT4OZO0JW9iy1CBUQyBB4sPLFuXjMLh3kmBX/ycw4eiX?=
 =?us-ascii?Q?PGsb2FgGb1Ib8/rb3mzJxbVMjZv5mAwSo7z6IZWZ02SKVFhv4TMlv+1ykslb?=
 =?us-ascii?Q?m6z39D+HVR/DD5ETH6Muz3Nc5otcdgcSDTBDiOiY/Jvux38yXwCCsfrl5gNs?=
 =?us-ascii?Q?GZ86JQbDn6gDU56xZWV8ZWI0X8bStey2cOlY4jI/ofSZYnhMvsLj/5SV+tkO?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1405e9ed-bbfd-4d02-0f32-08dd76bd29d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:48:18.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQIASge8+tnTZzDm98FFPQh/sIatmfh/tD507evk02/fWONEkBaIzj7wUPpcFMLSz1VUC1urpnAPO1Wvs107qU698dYP7uMFeHLmA5pjyaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 11:58:32AM -0400, Brandon Kammerdiener wrote:
> This patch fixes an endless loop condition that can occur in
> bpf_for_each_hash_elem, causing the core to softlock. My understanding is
> that a combination of RCU list deletion and insertion introduces the new
> element after the iteration cursor and that there is a chance that an RCU
> reader may in fact use this new element in iteration. The patch uses a
> _safe variant of the macro which gets the next element to iterate before
> executing the loop body for the current element. The following simple BPF
> program can be used to reproduce the issue (v1 typos fixed):

Hi Brandon,

You need to provide a Fixes: tag and target the patch towards 'bpf' tree.
Plus usually a good thing is to include a splat you experienced in the
commit message.

https://docs.kernel.org/process/submitting-patches.html is your friend.

> 
>     #include "vmlinux.h"
>     #include <bpf/bpf_helpers.h>
>     #include <bpf/bpf_tracing.h>
> 
>     #define N (64)
> 
>     struct {
>         __uint(type,        BPF_MAP_TYPE_HASH);
>         __uint(max_entries, N);
>         __type(key,         __u64);
>         __type(value,       __u64);
>     } map SEC(".maps");
> 
>     static int cb(struct bpf_map *map, __u64 *key, __u64 *value, void *arg) {
>         bpf_map_delete_elem(map, key);
>         bpf_map_update_elem(map, key, value, 0);
>         return 0;
>     }
> 
>     SEC("uprobe//proc/self/exe:test")
>     int BPF_PROG(test) {
>         __u64 i;
> 
>         bpf_for(i, 0, N) {
>             bpf_map_update_elem(&map, &i, &i, 0);
>         }
> 
>         bpf_for_each_map_elem(&map, cb, NULL, 0);
> 
>         return 0;
>     }
> 
>     char LICENSE[] SEC("license") = "GPL";
> 
> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
> 
> ---
>  kernel/bpf/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 4a9eeb7aef85..43574b0495c3 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2224,7 +2224,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
>                 b = &htab->buckets[i];
>                 rcu_read_lock();
>                 head = &b->head;
> -               hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
> +               hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
>                         key = elem->key;
>                         if (is_percpu) {
>                                 /* current cpu value for percpu map */
> --
> 2.48.1
> 

