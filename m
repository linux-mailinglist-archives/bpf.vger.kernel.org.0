Return-Path: <bpf+bounces-42020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDB299E86B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF56F1C22519
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78C1EB9E9;
	Tue, 15 Oct 2024 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8mt3Ed1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F541C57B1;
	Tue, 15 Oct 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993939; cv=fail; b=BeR2VvhFtHDodkWQSkWhJiypk+pUAVqOEmBXyibsoaCeZ0RCeCBbAGe7f+J6/n9+na4OXX99JJkYycqkibJLeWZNHd/ZafVn4tf4c/UU4SXue2/K4dnju6qmqj8AlCjRVeWqpn5xXFNpNSkr9/T1gyvnWHCF1Sg8RzgHj/c3U8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993939; c=relaxed/simple;
	bh=2bp/ZMybGMnZkdJDypKUp+kvYu5dlcFaPTWCJoPvwvw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YKKk8PHOMgJDo3V13flrAa7unR3L87+YG176nXMX5wr6lA/6F7pUHSQiqrowfGUmjBUD/IEYbP3LjULij04+evJNhd97x5WeQRMbWym90vksvb6EBFRGKTec4+iaozmHHlLkY50cUJR0IvaFLK3kCx2K6Wv5Pl6G4i76i8cPIwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8mt3Ed1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728993938; x=1760529938;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2bp/ZMybGMnZkdJDypKUp+kvYu5dlcFaPTWCJoPvwvw=;
  b=I8mt3Ed1ZYa46HIRhgiHFE4fkJOe3NKW/mo0ZUoSA4B9hAA6geJ6cIG4
   DSnl3t74kB0MEW7JbKg/mdvqS6AvQhIvNprFxeEeFoaHgegr/SyZ2GVRq
   2qmIRBjwljfOPlsJXC+vzXUIUXIGnzpPmDYrvv58qx9GsGBfXDOpFqakm
   DslY2IaMgHB7gKpCrvLhZqm+VEXT7+GpBx44y4n/FlZ42qK9b0cD9dTQp
   PdF8GMeow38EMNE96O7JS4U83eceK8FU2x2iqdvgTgBx/2BpKOTK83ucr
   kzKmPCPgCq5LXwfcEhokX2siKBimr55GfSFhTQMKYyh5Y2BCflFPCe/Gj
   A==;
X-CSE-ConnectionGUID: LWcXf+W8RyeqgNEPwFwfVQ==
X-CSE-MsgGUID: 0RrqANXeQKipqMQ+qDtbnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32074002"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32074002"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 05:05:37 -0700
X-CSE-ConnectionGUID: 8eX9PABzT+alDbIxVrCnvg==
X-CSE-MsgGUID: RoyVa/KBRcSOKI3jlBcW/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="78324914"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 05:05:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 05:05:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 05:05:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 05:05:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 05:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4Rx8fDPzAGx80WUSCDzpX1e45Gy9RVX/W4GSe6unhMO5oOdbVQQy+hEgVLsSzEw62d/lIy/qBCm1X9Wm6oSGKN8EzGiWkVc7Cz9qE33Qb2RfGhmydZlsw1YL36+XRKdOlmaVMfgPfrbA0fBpMdIbbZBY/1SGRMD+SqdHNYuWEfGpdk3aIcn+MzgnnQrJG+AfurbfRdXQyDecdfqz6KU4k/FpZXAhDhSDFuWxR6pTKzTp+U1e9woA9QUBTDNbfbXzJKgZghQCCZIJykSxiOLJfagdX55tCSkHEq3KBDPprsrkwKcJtKIfUFXfoVgFG1GlbIjLgdff2G7W+oHGBCMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eqTDtGim9NuO8xDAVrU0i8IaZxNm104OfQdajGup5k=;
 b=NijQ3zNVQXYlFd2Fi+Dzbo19kTgOMMnr9RxwbTdRBvd9lldDw5g1Ququ+4zCYl+kD27SATP9TwnRYHlT2ctUsFX9XN5ccXCc5rCn3keJ/yf6pFLE5VRo8PA3IFUCZLA5yMaSSZ9lbSr3f2rBR8LfPeNzQez2e8IW7FY1LQ+IXBEVw3DtiiSq5gCAJ5iyrmgcAlNBVMQ58km1kJOIGZkGGnP9kVT1xTtsUajfL6P2c+KYikM+m+jHV2hWSIZmb6UzR9FCNfMTjIbEflcnz8TkjgDreXuhIyKxYeLWBUVdnRVCzL0hvAm/L2qziWER7cJd3u7/puqwZ4VscMz7OLI7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Tue, 15 Oct 2024 12:05:32 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 12:05:32 +0000
Date: Tue, 15 Oct 2024 14:05:20 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH iwl-next v8 4/6] igb: Add XDP finalize and stats update
 functions
Message-ID: <Zw5agKXFRJ84u1c8@boxer>
References: <20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de>
 <20241011-b4-igb_zero_copy-v8-4-83862f726a9e@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241011-b4-igb_zero_copy-v8-4-83862f726a9e@linutronix.de>
X-ClientProxiedBy: WA0P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::25) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL3PR11MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 892bbfa5-690e-4353-bdeb-08dced11ab3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qJUm+ZmYVdMrtOTQsApncUe4izHxF7lwDeVGUtKmYmssgEwNKDPHk5XB3yGU?=
 =?us-ascii?Q?+CdHOPx/M05LiGtXq40WpRUEK+YWAdYyKiFVymVoJaNsJdJH1tV8X6UZsEUy?=
 =?us-ascii?Q?VMDGwKooqqYrYBEfzeYIoKPmh9FIdqNY+RA1d/xZMCehU+4TH+M74SZk27ys?=
 =?us-ascii?Q?L6liMVHBz8w8hfb0P+q9yitdjR0F25Htcno98QrQ5AoSdzetJPdS6fklTYZt?=
 =?us-ascii?Q?SjseTTxUzhPrUdbS4SnYZAnxF/r262Fqr8BShGSlJVe5p/QJ2QU19HVXDiEw?=
 =?us-ascii?Q?0hsA8qqaNowuALMveFcWEwGZ6jHwMNDE2r17TnLSLrp/LUQwcJhCe1PLlDAy?=
 =?us-ascii?Q?6vYhquxyv6fZeTCMc4jBEz3Htb6FQBetPrM/9I2lSvHn1PM3ZBRJZ8RI2174?=
 =?us-ascii?Q?K33cbj3wffz4K7Pfp75y+1s98GZBTg/RpBw4N/WcOKTRyVtLTFhK7KX4D/P7?=
 =?us-ascii?Q?puCQH4zUr2R1joDgBtbDsoWgPUnVQLVitT2o19huSU/vl+sDpCpE7tYbQgRw?=
 =?us-ascii?Q?v56l/g1jv9MADv1jKxBMGxnlMhZrx5yNS9zBi2dObp/btPw6t+FcdCxNUfXN?=
 =?us-ascii?Q?IqlUXSPCuTsSjN7zj4JiQ0MnN2tpxSG4Hn+LUsrgFS+6WQRJVIlFJEEVWnC7?=
 =?us-ascii?Q?1LyTWsJQV5K3ae9mbE6rFLv2ceB+KaM6GZVREYx/ztrDxjHlIdcksjX8VEsM?=
 =?us-ascii?Q?k1bo4QZJAmhkIsrmYcpU/Fk4QABz3W2hciwsWbTARyo7Ui/3DAE5n4K+0G2W?=
 =?us-ascii?Q?bxwWSuVIPrvHPSTL3YgqLLGza610OYP7oKjFZi7+rSFyn4diDwJow/DcNIRf?=
 =?us-ascii?Q?mDSU83u5zgevTcoGzcvZQtJZOzciLLLdILlk27VCfO+kHKGFqHmsjGmmGRTm?=
 =?us-ascii?Q?JeNTbzhBhSOfWusBKyGc7cGn5lHQ8SoRlt8iTQhAUMHYyEtQ11zmD1el/6bG?=
 =?us-ascii?Q?xLpHgG1OTPzv1HHVLB7HUxhef5el72Fj6XOQfG90FpdeUcr9KAOZXrLG3aaM?=
 =?us-ascii?Q?hGlYWYKRRhr8W79tVUavSbHDgCeFBaRH6nmQO3EIi9acD9dNBoRiDbLV1To0?=
 =?us-ascii?Q?8GmpmSTImIlcRtd4mrRfK8ylrv7oWucz/qQWuiMwMh7QxnSPpBBr4Li71BAS?=
 =?us-ascii?Q?KTp7bzhgKry0Qm97GybgXl6jycB/MGYE8jDLNSukoDHAKhIUnsUZUrA9xPiU?=
 =?us-ascii?Q?UgIFIIu0sxesj0zLeGGD2cMyNmdtA6Nyol+0gtgo0DNXTQPiRz0t4mS+wsDr?=
 =?us-ascii?Q?DPMLA+0MxlpgeAN++2bj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MfuSrqyDinnA7FZEsb5stHOw/l6Jnqjzmwoh1VIU7zgjsLf/HT33ZE71XGzq?=
 =?us-ascii?Q?714HrcLHENSFtuNEVp3Lr6zpgH1JLsojo2WifrCDRNitr7zHqMsxhDRhyvne?=
 =?us-ascii?Q?W6gzUL37k4IA0l9s9tL0G5npF7/EavUWBeRzaTG06qDDKPSzeZGVRmhhxh3w?=
 =?us-ascii?Q?ViFW0oycHHep8UhEF+OsQhD9toAzBnA+FACtuJ5I5KLDa4YqCW5iYUCSi/zg?=
 =?us-ascii?Q?+HWwlBexy0bs6t0KS4RWrDeGidL2xLXnA0s2//iJq1vejeT3lpenM8MvrXba?=
 =?us-ascii?Q?IX05/EQuVOLzwb9yzUC8PHCam5BDZYe73evG+cGEZt/ABUiGe6Tyh01XRmpy?=
 =?us-ascii?Q?q18slBZe/YZeansNaAVYg6jnk354rG3Jk0Nwux2YRq8e3WqFK50ewpGOo/BB?=
 =?us-ascii?Q?MJkZXGNI+U1g4VZtccjKqX/UEHFSEj/AvK09O7vopnA8BFfzY41nn974s33k?=
 =?us-ascii?Q?DLWSsC/8uh1WoyYNjTa8afSIcdYZvcQoFCXoWSiuXjw3RPASXPUHZT7i6rWF?=
 =?us-ascii?Q?bzEQzU1lXM6rGMaMIWvKnsqAi455mMXMsKdko5deFStr5LY15aJvDrppiVVH?=
 =?us-ascii?Q?NRgZiXBD7BXyLRrtPzkM+53xB2WAUMQ0mLnQO3+hfB2qnBr/1iXTQtomsNeO?=
 =?us-ascii?Q?mJy+puTFIkDGAiWEk2fiETYpO6lcQcIOnK3osAEYHZ08wKe0qa+O+P27zY5w?=
 =?us-ascii?Q?IXvXy1oPte3t0GYLdSrodhBrEzFDKfaK9vhcFpmeh8HtRBIOUJgEClQiRXJR?=
 =?us-ascii?Q?z11a7ffAbF2bbkB43HmCmwfJcZ+hgnZLOFXkiV31ESX+h1Slt9o34xgTc7/M?=
 =?us-ascii?Q?RmCFUvHirWwpmxvRlYokSdIEGB9urMuAZy4E68S2a+OgZnMaHEUdq96rYRl+?=
 =?us-ascii?Q?q3KSNYk1ZGQ0fvZTC8YqM4Q/Et+0uon4iDGdHnko/A6poDd4r6PHaju+U2gN?=
 =?us-ascii?Q?GFKPl8A4+F0Yk6gFtaNRiKNIUcF962JSgAPMLhI3k9ARPMJh0okVfDoqYkXx?=
 =?us-ascii?Q?cIl/LFf5J2reXPkriaNYfzYQp9UEmchoGuWpvFA/hZ0U2Egtx4P1d2t/nL2J?=
 =?us-ascii?Q?mzIh464QfHuyUPHaMNyTm31S8GyR8rHtdSfw/bGkIFEo05vEPB9SRhSMuVFB?=
 =?us-ascii?Q?KdcvUvYyU4cj/Rd7ORm6KYpWJ5vL50eLgUL0m2GB8UnBIVI5qkU2WYJlavN/?=
 =?us-ascii?Q?E1fV0+zvoCzmqh6P8JhbYOifNrBZEnN/i9eUVA8me+XpxVA1H38qT18eu04T?=
 =?us-ascii?Q?rBZCXnTDNdzpKHz0UgN+TNJB0k2MBd0gZi6ED5Rg236dnu/i4YS89gnm5ssQ?=
 =?us-ascii?Q?pNxfEO7NkgF4G5oYZ0Nr+Fnwu11f7yEtgorXnFa4fePgzHcVAQVTf2Kk0wLi?=
 =?us-ascii?Q?d77B3MrZOXOWLCWq8sQdL3dsnRuHQ2azYWfwA10/is2Dwy38iTElaG7TD4Qr?=
 =?us-ascii?Q?sA93r5NswpTPvypSW2ybabz6VkqAJXDvTdNMMDLzWCIjx+0fa2tFLSWEqRxJ?=
 =?us-ascii?Q?LvcZuhWx3ODdFMZheEwR7o8TsXdHlU8B6/cMIcjzDxSVF4gyCfUiU5l0ApbY?=
 =?us-ascii?Q?GJMzykytupiPZmJrcwal6IlU5OT6ZcvAonQ4N8WWAmgCrCu78jN3BvIhjDc2?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 892bbfa5-690e-4353-bdeb-08dced11ab3f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 12:05:32.4639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZdWoOdpKo5N2PMVLBeTABrEQffyMLoh7UyO3yvlDOaUKn09O/LjhqFFlFqcZPhzNJYJICUqXsmI1BSNjWsHfEgoih2P2JC0FP5r0qUR7hA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6435
X-OriginatorOrg: intel.com

On Fri, Oct 11, 2024 at 11:01:02AM +0200, Kurt Kanzenbach wrote:
> Move XDP finalize and Rx statistics update into separate functions. This
> way, they can be reused by the XDP and XDP/ZC code later.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  3 ++
>  drivers/net/ethernet/intel/igb/igb_main.c | 54 ++++++++++++++++++++-----------
>  2 files changed, 38 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index c30d6f9708f8..1e65b41a48d8 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -740,6 +740,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring);
>  void igb_clean_rx_ring(struct igb_ring *rx_ring);
>  void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
>  void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
> +void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status);
> +void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int packets,
> +			 unsigned int bytes);
>  void igb_setup_tctl(struct igb_adapter *);
>  void igb_setup_rctl(struct igb_adapter *);
>  void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 341b83e39019..4d3aed6cd848 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -8852,6 +8852,38 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
>  	rx_buffer->page = NULL;
>  }
>  
> +void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status)
> +{
> +	int cpu = smp_processor_id();
> +	struct netdev_queue *nq;
> +
> +	if (status & IGB_XDP_REDIR)
> +		xdp_do_flush();
> +
> +	if (status & IGB_XDP_TX) {
> +		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
> +
> +		nq = txring_txq(tx_ring);
> +		__netif_tx_lock(nq, cpu);
> +		igb_xdp_ring_update_tail(tx_ring);
> +		__netif_tx_unlock(nq);
> +	}
> +}
> +
> +void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int packets,
> +			 unsigned int bytes)
> +{
> +	struct igb_ring *ring = q_vector->rx.ring;
> +
> +	u64_stats_update_begin(&ring->rx_syncp);
> +	ring->rx_stats.packets += packets;
> +	ring->rx_stats.bytes += bytes;
> +	u64_stats_update_end(&ring->rx_syncp);
> +
> +	q_vector->rx.total_packets += packets;
> +	q_vector->rx.total_bytes += bytes;
> +}
> +
>  static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  {
>  	unsigned int total_bytes = 0, total_packets = 0;
> @@ -8859,9 +8891,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  	struct igb_ring *rx_ring = q_vector->rx.ring;
>  	u16 cleaned_count = igb_desc_unused(rx_ring);
>  	struct sk_buff *skb = rx_ring->skb;
> -	int cpu = smp_processor_id();
>  	unsigned int xdp_xmit = 0;
> -	struct netdev_queue *nq;
>  	struct xdp_buff xdp;
>  	u32 frame_sz = 0;
>  	int rx_buf_pgcnt;
> @@ -8983,24 +9013,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  	/* place incomplete frames back on ring for completion */
>  	rx_ring->skb = skb;
>  
> -	if (xdp_xmit & IGB_XDP_REDIR)
> -		xdp_do_flush();
> -
> -	if (xdp_xmit & IGB_XDP_TX) {
> -		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
> -
> -		nq = txring_txq(tx_ring);
> -		__netif_tx_lock(nq, cpu);
> -		igb_xdp_ring_update_tail(tx_ring);
> -		__netif_tx_unlock(nq);
> -	}
> +	if (xdp_xmit)
> +		igb_finalize_xdp(adapter, xdp_xmit);
>  
> -	u64_stats_update_begin(&rx_ring->rx_syncp);
> -	rx_ring->rx_stats.packets += total_packets;
> -	rx_ring->rx_stats.bytes += total_bytes;
> -	u64_stats_update_end(&rx_ring->rx_syncp);
> -	q_vector->rx.total_packets += total_packets;
> -	q_vector->rx.total_bytes += total_bytes;
> +	igb_update_rx_stats(q_vector, total_packets, total_bytes);
>  
>  	if (cleaned_count)
>  		igb_alloc_rx_buffers(rx_ring, cleaned_count);
> 
> -- 
> 2.39.5
> 

