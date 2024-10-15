Return-Path: <bpf+bounces-42024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA7399ED83
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 15:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181011C228E7
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53A21B2186;
	Tue, 15 Oct 2024 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uweq1f4i"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1271FC7DB;
	Tue, 15 Oct 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998939; cv=fail; b=hrT8KX8RJ5vpFFIOL4sGe5m6vGcqLe0FlPMu1mSc+qsBw3X36QF/VvLcY2lGhrmjOZmg8T6KiLIVGB+VKOyAefooVNBXk04MzNMoKzfR5x24uw59pA8MPC+rOJubmLOvt1bh69kS0TFaVmlVG4Dx3egLUh6gXdTWt4Y/oonK0PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998939; c=relaxed/simple;
	bh=hGACWpqsgLqWGe4Wy5s06QXk8hwySZZarwvksSfAo4c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VEcbmIC03sWWQJc3Q51XYz6h1H3gFBHkCBIqwwdKJWdXQQZhMWo+fMnkWqgJE+TD99JsDwMs2mzdcw0D131cW4B+0UU5MDNLRE2Xy9b5qW5lmKy3w8bWi8aSuWeFB3L3hgslRUjr/TpNrO14Us9+bqbzXhkDdst+D2hwLIHIeKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uweq1f4i; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728998937; x=1760534937;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hGACWpqsgLqWGe4Wy5s06QXk8hwySZZarwvksSfAo4c=;
  b=Uweq1f4i7f89zffJLeEWhKfITM4D6YOTpEjpBA3OUbseCKeGrznx95OX
   WJGQrjfI6QPqJw9fg2sryxZEbsEr8jovr4y75rgA8Bh9SkerZXfIGDVR4
   Vh7OIbkNR8mdUsXh8B2kupc3kWFakc5rq28Cx2y+LIJOq28Limg9EN8N+
   f2nm2tedN152c5j7uV+ziB26WqRa588zstkDwFQ2vTVz6v7dxIPAjfCWC
   xfWzhlH9mtYh0gcLSkL+KVJawLX4zCzWGLxVy1+s+baCSFbGgcVaMeR+F
   15gb/iqjBvXnM/J2BCrcQZ9VDfWDyVTQjEKMh6iuiar1U94Oql2Goz8VL
   A==;
X-CSE-ConnectionGUID: e3tlWAmRQYe5HORTS1nOUg==
X-CSE-MsgGUID: 2R3ilNLiQoqdI+HQzcbibQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39767501"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="39767501"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 06:28:56 -0700
X-CSE-ConnectionGUID: oTyK6XAkRMWX8DUxpzMllA==
X-CSE-MsgGUID: wbi6q0M/Rhusx2BIpLUT0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="77510773"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 06:28:56 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 06:28:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 06:28:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 06:28:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 06:28:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 06:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QA4cTg8pNICXTtVrZTQG7T/a7CBZeKBtKUK9t6syutCT4Qxp08tIsEOekz0ohH4p6gvEychO/wp9AMq1VTuydeaDB5EAFrDwC1QV5oKTm8mk3Npagw8HQ5OcEMsVBFp9Gi6fRfKNPaob9palkJmRojXO5qw7csm6EHJsrJUPAP1F2SYDNKlYWNJ85Ym2jEiONvk4ZCuOcv/5+/tWSTkFBkjpo+HPpWu0XECodbDq4A8J35cr740neXDfnTuaVrTACF0F7UgmzreVFRNz6w5XQjVi6hKujQEQVouKiWV7BvpkB/v5KijroHXmRtTkIM1cMiW9sj7iYLnXLnIRaXbhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UG+TbllFAFheMzlYwcuqmVhXKH/uB3LYPKIVbCT3l60=;
 b=SKaQuc4XDm1t5yNYcxXq1rSl8p+EokOzZcK1peKMA3KKqB6s16VwfFrhVgQ0G2oy8HXEEN6ynl66Y3QFag6DLx9MbdkJFOAUaCW3aAzwwrT3wQRJ6hv51G4Zf0IRPE5bO31ID1BGF6t/TjcGpQJSa0n/adgj3b7TluWmV991WJU2oVg8zLZEsjw+lgf4ApNz8/rQqtskdD03/IHdJ7E+a2s1hTNZFvF/AGeUgkU7jLmjD5tHtvOLq1CETu3TWIMVenMD2G+xCUk6EMGevkxZAiWHRCXobMvFGsCAYfeEyrmNVmWfgO26HQn+MGd+AllJ/5Qbp+tqdjKBLuOoJft9+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB8160.namprd11.prod.outlook.com (2603:10b6:8:189::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Tue, 15 Oct 2024 13:28:50 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 13:28:50 +0000
Date: Tue, 15 Oct 2024 15:28:37 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v8 6/6] igb: Add AF_XDP zero-copy Tx support
Message-ID: <Zw5uBZa7+Iy5qD1t@boxer>
References: <20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de>
 <20241011-b4-igb_zero_copy-v8-6-83862f726a9e@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241011-b4-igb_zero_copy-v8-6-83862f726a9e@linutronix.de>
X-ClientProxiedBy: WA2P291CA0032.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::21) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f59374-c757-4b24-eba1-08dced1d4e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N8GXihDxxra36E5ElM3lAPR9T5Dg61nPtB7wAK0VjLva3dkM+UH7D/ZOKXQ/?=
 =?us-ascii?Q?CaBSn3zoVq/CEW6KI4NppN5DHSljQcKKk0p9mDVZmZ20sxwnD0/5i3gULDQD?=
 =?us-ascii?Q?C+XZekMXvWFjOmPFulEaWXLTf/0jNzQdCXVvKh07AEX+SrVSzVi65rx56TKU?=
 =?us-ascii?Q?QaplKqTArLHJncbs92nmoQmoM1uJlKEJcslZNW7x2fE+dE1WBespqFNZr3XM?=
 =?us-ascii?Q?j0dhinJqhHH1hhgR0Q2Bk5PhvMu49z+YaZIsGbK5M93AeNr7hmJrrO01lQAF?=
 =?us-ascii?Q?kVLJS3smg/hCMPjtEF7KYuKKXb2614NNatyMyRf5NIaoO+G1fNIKvJYzLq0B?=
 =?us-ascii?Q?VN/uGSX7dtuLBQI9DjAi8EVyev4dbZ4Q7CEGpg/ALmkKBgcPy5QWQ8cnmsFa?=
 =?us-ascii?Q?8zt7sChSrv+bgV2cCQn++UFj53eh3SSamiYh0zf71u3ch8a+ygVvjCA0ERgY?=
 =?us-ascii?Q?gTINwcLzS+fFEce3+60KepDgsyZN/3rTfHZ0sIjm+VbaSyI4rKsLWfqGGK0N?=
 =?us-ascii?Q?jv9smS/PMTRYLyTs6aHuIb9MbVknjZq+/hNAmyItV8UhiEMqFduAOQ3KeLwq?=
 =?us-ascii?Q?E6RYR+h4Bo4/WhJVBnjvDLHRtXo1uUC2oRATwZgrtKHv9dFTX153Hdn18Q28?=
 =?us-ascii?Q?ykRwQI8NNnbUjEYMtAXZYl+rjg9nnQDDucAdA3DTGc94eu8nxd/w7ZYOOg/l?=
 =?us-ascii?Q?4Ry1WY54e8KX2t/0XYtGNL/N7Bg0FUcg1NChD+uLAA92yBHCSpuuiOZuyTjR?=
 =?us-ascii?Q?MJzLHEEqDgVbAASS9M1IEWGzEvfRI7Fhd39xfaucgLtoD4SsJO7+PoPXapk2?=
 =?us-ascii?Q?CtmLt4BIGP2XgwyZ6FRJRInivTc00QMsXezo+0akG4yH/sH0+Yl1NwUHJBmj?=
 =?us-ascii?Q?fezyF/dCoQj3vPaur4nqSgzjYgu0KEB1IyvalRdOkdklgCoA8m8G/Fjkoetj?=
 =?us-ascii?Q?BlrnDzS/hJD58EP6znf09aBmTyLEQIiVLuG6LdPk69RFbSJ4kc36hG3Zzp0Q?=
 =?us-ascii?Q?lx0mKZARWMZ/K4/zCe0IsmH7mjpZsF/8EX55xqZTzU2DD0IOr/ENBh6sVPrM?=
 =?us-ascii?Q?r7d86XMDZZlNyFtGELEshHby8OZBpfknkjbXGqgn5OPZHa32EvS3bDcCcmpQ?=
 =?us-ascii?Q?5n/ezNSy9fw6J0Lake4VeJrTXsxn8xdaeDIRGoafPDxFTbP4WKxD77KAmJYg?=
 =?us-ascii?Q?UOBZ5he6l+Y1UyUQk0fSnQ/gId9vjB7YTLsQi9f8LpHKM81oMKxsYdwDlxub?=
 =?us-ascii?Q?6MScCcMWkoDpg1lR/oa5ZBITp4oq2cDlMZ9PNlQEfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HuNWAIOYW6KUTLmaL60jdSb0emTyYohVQfFnxoj+1gLSQm8JI0qW1iMnuQI4?=
 =?us-ascii?Q?+PK/G4BUBGU+x2eu+lbIth8lcywUrKsYGmmUjfTnKPDYxxmJ9BXIS2A20pPH?=
 =?us-ascii?Q?XVDokkjRpZF4CSXf5e2m96G0eDb6EKUjVxNVpV/p7w9wuLzYbP+hIPwwgMck?=
 =?us-ascii?Q?Rr5q+WKqMXe8RR1t6LCkPxdtWFqarteMnzKhSXZAtd6kyv6CDC5173/vASE6?=
 =?us-ascii?Q?Hv3j1kJU2S0sPZrePIHWN/CUf0dGvO+CXXjU5Sx9liY+C1llc91uc/ZfF15I?=
 =?us-ascii?Q?6zu4Q743z1UN2FvWwAVlCHFcCTo2G+pBuPK4A9KEOf/tSyPfPKmuK+4wRtzX?=
 =?us-ascii?Q?1DcVdeiZAYCk4F17zTeQRDNPMKDzIZW+f7408BiorMaqtzcVtykufA+BKf3M?=
 =?us-ascii?Q?RctN6Z/WDyTdiZLXqHEBOwQjmMiiiqlJ7ChGbEwe2J+aUzy41Indb+TGNeaC?=
 =?us-ascii?Q?uDHqPpNVAVroi/16ulqUIfZ1FSNkK+jyAKzi0wdoJexr/mg7EQlvY5dYjGx9?=
 =?us-ascii?Q?pfVKP4MsBdkq4gGmeYLhxhewGKhykeaiwJbI+diW0FXmaFmdybnATioi6trs?=
 =?us-ascii?Q?NTDNmusdXI0uV1opAGPUE6b1KaX0T3r2Ht4ma+dKRpVkR05FwYm0JHdKi6OI?=
 =?us-ascii?Q?GVUKI+u/B+1SS+s2ACZtDp17D7Sw6rBW/it7qae1v8zED2Kb3mrToo8vdO/6?=
 =?us-ascii?Q?QPtMkR2CneItKOGVGTH0POIhcK6DeOZQ8hnDeK8dWTAVwcmVnfTAifsXNL6m?=
 =?us-ascii?Q?NApsurnEqDEHirpIpPgblHTuJoAEV7orgA4PZgUOSKZWEBh+VLy5aItYUKHI?=
 =?us-ascii?Q?18L9z+37BSu5KBXrJj+aiPHMkQd7dlMof4IptcjOj7i8WTAHOJ4FjUiF3ZJf?=
 =?us-ascii?Q?3CP4T1x0DJtBYDUBvR89gI7svfPQ6xK7o2iEubhgQa8n761sgnWnIGBmsv5X?=
 =?us-ascii?Q?cdl930ErxPzpt2aH4UMSUKICP0rH1HAwP3yjgQBZZR972hKjpFAdKbapHL9Q?=
 =?us-ascii?Q?yPgPxYnJJkAmC+Ih7NoNJtimGAjkgAZIggTr84+AA3+4NRUN6aBo5fPQlYWZ?=
 =?us-ascii?Q?7p2INzG1JY+CFkZ8WWZrZIwwIJguF0s1DSHeTJeNsj08GCRPzW4J2a3++vDk?=
 =?us-ascii?Q?Se3if2W78GWbEdcrfu0RkxT3wsxbfSFO7M2zIxc8q43nFeRZkk+VGl+/RLO4?=
 =?us-ascii?Q?wkV7s0AtJ8m/Izd48wxldHEminhQxxKuhhK52f70qyT3plf8VS0okWDzdphA?=
 =?us-ascii?Q?RW/YB4Vbx4LMVXLbLnUoMl+w4fG4lmQB1r03EAl3CM6O2kQ03WWw1wXuPxV0?=
 =?us-ascii?Q?qEb65bX9c0qE6bQDExgr8e1jEVetFq+6UwnrBSkp21q06pOF8jBX+fyUMy2Q?=
 =?us-ascii?Q?aoWv9ykpX7zAWfmtQLhtvwmSloQ9ItUJHPKBh4w6PnTcUo4oVzenHy7ZmhFo?=
 =?us-ascii?Q?J4tw+bfYxEi4C5+S0cVW21FTRxzZcPSIWJqUkRKvg8V4j0idOmL+6kazrRa2?=
 =?us-ascii?Q?yINZccHpdDEqye/IGP56/dC0qFCbDyLQtZSVhrQ1kpPGpQEAmKxyu87abOte?=
 =?us-ascii?Q?x9IBY+0aIhDR+59JD1hnu6CuuW4u12xdv1eo3ZrKguqWIOLq5jgVGyE1i/3e?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f59374-c757-4b24-eba1-08dced1d4e4a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:28:50.5747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gp2T34PxjElG9BhetbcYX9rjv9urjse9uTi88lg/QxHH2MSv9JaDVvlG/R2F4h9IVIcgo21GCHOOZiwi+OkTGcNrWvn5FHdwL43ILhKpdb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8160
X-OriginatorOrg: intel.com

On Fri, Oct 11, 2024 at 11:01:04AM +0200, Kurt Kanzenbach wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Add support for AF_XDP zero-copy transmit path.
> 
> A new TX buffer type IGB_TYPE_XSK is introduced to indicate that the Tx
> frame was allocated from the xsk buff pool, so igb_clean_tx_ring() and
> igb_clean_tx_irq() can clean the buffers correctly based on type.
> 
> igb_xmit_zc() performs the actual packet transmit when AF_XDP zero-copy is
> enabled. We share the TX ring between slow path, XDP and AF_XDP
> zero-copy, so we use the netdev queue lock to ensure mutual exclusion.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> [Kurt: Set olinfo_status in igb_xmit_zc() so that frames are transmitted,
>        Use READ_ONCE() for xsk_pool and check Tx disabled and carrier in
>        igb_xmit_zc(), Add FIXME for RS bit]
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  2 +
>  drivers/net/ethernet/intel/igb/igb_main.c | 61 ++++++++++++++++++++++++-----
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 64 +++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index e4a85867aa18..f6ac74327bb3 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -258,6 +258,7 @@ enum igb_tx_flags {
>  enum igb_tx_buf_type {
>  	IGB_TYPE_SKB = 0,
>  	IGB_TYPE_XDP,
> +	IGB_TYPE_XSK
>  };
>  
>  /* wrapper around a pointer to a socket buffer,
> @@ -859,6 +860,7 @@ bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring,
>  void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
>  int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
>  			struct xsk_buff_pool *xsk_pool, const int budget);
> +bool igb_xmit_zc(struct igb_ring *tx_ring);
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
>  
>  #endif /* _IGB_H_ */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 711b60cab594..5f396c02e3b9 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2979,6 +2979,9 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
>  	if (unlikely(!tx_ring))
>  		return -ENXIO;
>  
> +	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
> +		return -ENXIO;
> +
>  	nq = txring_txq(tx_ring);
>  	__netif_tx_lock(nq, cpu);
>  
> @@ -3326,7 +3329,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	netdev->priv_flags |= IFF_SUPP_NOFCS;
>  
>  	netdev->priv_flags |= IFF_UNICAST_FLT;
> -	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
> +	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
>  
>  	/* MTU range: 68 - 9216 */
>  	netdev->min_mtu = ETH_MIN_MTU;
> @@ -4900,15 +4904,20 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  {
>  	u16 i = tx_ring->next_to_clean;
>  	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
> +	u32 xsk_frames = 0;
>  
>  	while (i != tx_ring->next_to_use) {
>  		union e1000_adv_tx_desc *eop_desc, *tx_desc;
>  
>  		/* Free all the Tx ring sk_buffs or xdp frames */
> -		if (tx_buffer->type == IGB_TYPE_SKB)
> +		if (tx_buffer->type == IGB_TYPE_SKB) {
>  			dev_kfree_skb_any(tx_buffer->skb);
> -		else
> +		} else if (tx_buffer->type == IGB_TYPE_XDP) {
>  			xdp_return_frame(tx_buffer->xdpf);
> +		} else if (tx_buffer->type == IGB_TYPE_XSK) {
> +			xsk_frames++;
> +			goto skip_for_xsk;
> +		}
>  
>  		/* unmap skb header data */
>  		dma_unmap_single(tx_ring->dev,
> @@ -4939,6 +4948,7 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  					       DMA_TO_DEVICE);
>  		}
>  
> +skip_for_xsk:
>  		tx_buffer->next_to_watch = NULL;
>  
>  		/* move us one more past the eop_desc for start of next pkt */
> @@ -4953,6 +4963,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  	/* reset BQL for queue */
>  	netdev_tx_reset_queue(txring_txq(tx_ring));
>  
> +	if (tx_ring->xsk_pool && xsk_frames)
> +		xsk_tx_completed(tx_ring->xsk_pool, xsk_frames);
> +
>  	/* reset next_to_use and next_to_clean */
>  	tx_ring->next_to_use = 0;
>  	tx_ring->next_to_clean = 0;
> @@ -6486,6 +6499,9 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
>  		return NETDEV_TX_BUSY;
>  	}
>  
> +	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
> +		return NETDEV_TX_BUSY;
> +
>  	/* record the location of the first descriptor for this packet */
>  	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
>  	first->type = IGB_TYPE_SKB;
> @@ -8260,13 +8276,18 @@ static int igb_poll(struct napi_struct *napi, int budget)
>   **/
>  static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  {
> -	struct igb_adapter *adapter = q_vector->adapter;
> -	struct igb_ring *tx_ring = q_vector->tx.ring;
> -	struct igb_tx_buffer *tx_buffer;
> -	union e1000_adv_tx_desc *tx_desc;
>  	unsigned int total_bytes = 0, total_packets = 0;
> +	struct igb_adapter *adapter = q_vector->adapter;
>  	unsigned int budget = q_vector->tx.work_limit;
> +	struct igb_ring *tx_ring = q_vector->tx.ring;
>  	unsigned int i = tx_ring->next_to_clean;
> +	union e1000_adv_tx_desc *tx_desc;
> +	struct igb_tx_buffer *tx_buffer;
> +	struct xsk_buff_pool *xsk_pool;
> +	int cpu = smp_processor_id();
> +	bool xsk_xmit_done = true;
> +	struct netdev_queue *nq;
> +	u32 xsk_frames = 0;
>  
>  	if (test_bit(__IGB_DOWN, &adapter->state))
>  		return true;
> @@ -8297,10 +8318,14 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  		total_packets += tx_buffer->gso_segs;
>  
>  		/* free the skb */
> -		if (tx_buffer->type == IGB_TYPE_SKB)
> +		if (tx_buffer->type == IGB_TYPE_SKB) {
>  			napi_consume_skb(tx_buffer->skb, napi_budget);
> -		else
> +		} else if (tx_buffer->type == IGB_TYPE_XDP) {
>  			xdp_return_frame(tx_buffer->xdpf);
> +		} else if (tx_buffer->type == IGB_TYPE_XSK) {
> +			xsk_frames++;
> +			goto skip_for_xsk;
> +		}
>  
>  		/* unmap skb header data */
>  		dma_unmap_single(tx_ring->dev,
> @@ -8332,6 +8357,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  			}
>  		}
>  
> +skip_for_xsk:
>  		/* move us one more past the eop_desc for start of next pkt */
>  		tx_buffer++;
>  		tx_desc++;
> @@ -8360,6 +8386,21 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  	q_vector->tx.total_bytes += total_bytes;
>  	q_vector->tx.total_packets += total_packets;
>  
> +	xsk_pool = READ_ONCE(tx_ring->xsk_pool);
> +	if (xsk_pool) {
> +		if (xsk_frames)
> +			xsk_tx_completed(xsk_pool, xsk_frames);
> +		if (xsk_uses_need_wakeup(xsk_pool))
> +			xsk_set_tx_need_wakeup(xsk_pool);
> +
> +		nq = txring_txq(tx_ring);
> +		__netif_tx_lock(nq, cpu);
> +		/* Avoid transmit queue timeout since we share it with the slow path */
> +		txq_trans_cond_update(nq);
> +		xsk_xmit_done = igb_xmit_zc(tx_ring);
> +		__netif_tx_unlock(nq);
> +	}
> +
>  	if (test_bit(IGB_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags)) {
>  		struct e1000_hw *hw = &adapter->hw;
>  
> @@ -8422,7 +8463,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  		}
>  	}
>  
> -	return !!budget;
> +	return !!budget && xsk_xmit_done;
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index 22d234db0fab..d962c5e22b71 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -465,6 +465,70 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
>  	return failure ? budget : (int)total_packets;
>  }
>  
> +bool igb_xmit_zc(struct igb_ring *tx_ring)
> +{
> +	unsigned int budget = igb_desc_unused(tx_ring);
> +	struct xsk_buff_pool *pool = tx_ring->xsk_pool;

Ughh that's another read of pool ptr, you should have passed it by arg to
igb_xmit_zc()...

> +	u32 cmd_type, olinfo_status, nb_pkts, i = 0;
> +	struct xdp_desc *descs = pool->tx_descs;
> +	union e1000_adv_tx_desc *tx_desc = NULL;
> +	struct igb_tx_buffer *tx_buffer_info;
> +	unsigned int total_bytes = 0;
> +	dma_addr_t dma;
> +
> +	if (!netif_carrier_ok(tx_ring->netdev))
> +		return true;
> +
> +	if (test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags))
> +		return true;
> +
> +	nb_pkts = xsk_tx_peek_release_desc_batch(pool, budget);
> +	if (!nb_pkts)
> +		return true;
> +
> +	while (nb_pkts-- > 0) {
> +		dma = xsk_buff_raw_get_dma(pool, descs[i].addr);
> +		xsk_buff_raw_dma_sync_for_device(pool, dma, descs[i].len);
> +
> +		tx_buffer_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +		tx_buffer_info->bytecount = descs[i].len;
> +		tx_buffer_info->type = IGB_TYPE_XSK;
> +		tx_buffer_info->xdpf = NULL;
> +		tx_buffer_info->gso_segs = 1;
> +		tx_buffer_info->time_stamp = jiffies;
> +
> +		tx_desc = IGB_TX_DESC(tx_ring, tx_ring->next_to_use);
> +		tx_desc->read.buffer_addr = cpu_to_le64(dma);
> +
> +		/* put descriptor type bits */
> +		cmd_type = E1000_ADVTXD_DTYP_DATA | E1000_ADVTXD_DCMD_DEXT |
> +			   E1000_ADVTXD_DCMD_IFCS;
> +		olinfo_status = descs[i].len << E1000_ADVTXD_PAYLEN_SHIFT;
> +
> +		/* FIXME: This sets the Report Status (RS) bit for every
> +		 * descriptor. One nice to have optimization would be to set it
> +		 * only for the last descriptor in the whole batch. See Intel
> +		 * ice driver for an example on how to do it.
> +		 */
> +		cmd_type |= descs[i].len | IGB_TXD_DCMD;
> +		tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> +		tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> +
> +		total_bytes += descs[i].len;
> +
> +		i++;
> +		tx_ring->next_to_use++;
> +		tx_buffer_info->next_to_watch = tx_desc;
> +		if (tx_ring->next_to_use == tx_ring->count)
> +			tx_ring->next_to_use = 0;
> +	}
> +
> +	netdev_tx_sent_queue(txring_txq(tx_ring), total_bytes);
> +	igb_xdp_ring_update_tail(tx_ring);
> +
> +	return nb_pkts < budget;
> +}
> +
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
>  {
>  	struct igb_adapter *adapter = netdev_priv(dev);
> 
> -- 
> 2.39.5
> 

