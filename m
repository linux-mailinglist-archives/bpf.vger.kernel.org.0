Return-Path: <bpf+bounces-74753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 130F6C650DF
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39C563525CC
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D30A2C08CB;
	Mon, 17 Nov 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOtRfaVX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A0274B53;
	Mon, 17 Nov 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395740; cv=fail; b=q0uORS3VsOsvNmJxlpjvoIbELXZqe1fjoFlRyIJ6P42HoM8Q6TPO45Y5GwZ5LHpYokvxn16Ipe7Na8nUeBG3dX+KHP/luZVQxS/4jI83ZNR2P1Mpmhiun5EWxcJDMJprlUwn8qqxP1KorOaeB2gCBP2a2KPt1rwSDnZXTXPQvKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395740; c=relaxed/simple;
	bh=Civqe0w+0VW6pmuJYRMaKLKULQtFry6bjV6K/pdnHR0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XGxBJ3GiMl0PVNdZKtvFc7eamq6O3F/qvcTBVc6LfAPUMPit40Iemae1AaqG9WUUZrz7TGmVjHfWDOk7kncbT7if5+KlNrWlzwqUcpDerpw7dryiKTgXK55iXPsQqVdsKVh+2zCQg1yMVpP0YncxT99CCrqPk+m/NdYjHl1rhaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOtRfaVX; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763395738; x=1794931738;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Civqe0w+0VW6pmuJYRMaKLKULQtFry6bjV6K/pdnHR0=;
  b=fOtRfaVXRpGDHR6Gp2kE4wai7ukBMzdR6qkiWFbKy9bU88fNs+xVVlQF
   oP3yyqwQ42ZtuY9hrW98XSpqY0WXcDiVqqr5qJGaPWTeTdQT60I7r5pmL
   QUMtFMjyCN6Cu1LfSSGifCi4eWuR6WxBAXTRdy1UDRnG8wTB+WpG75oQ2
   Lq3uJ+fAg0Zh1uGhpFF8cblsuN4rhFH7jPrv5naqKqJiRtWmMdprFy6cA
   5jS1qKZFAJZzs6zTsmv5rfvA1Gc4+xa2kEQdys5ydXAcjJe90lxaXMv0a
   dTf/vdcsA1xm0stYcfU2ug76Wml6f1+VwX+WbCkCSA8kDez9EBJqN6EHi
   Q==;
X-CSE-ConnectionGUID: Mh8wix75TV+8OCSBJMep5w==
X-CSE-MsgGUID: +4TWkYSTQ0ml9Xf+SJLXEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65334986"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="65334986"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:08:57 -0800
X-CSE-ConnectionGUID: M2IxdjHQQBmwosLwpQzfkg==
X-CSE-MsgGUID: T0Fhj7baRQ2zK3kIdAkR8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="191284640"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 08:08:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:08:56 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 08:08:56 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:08:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAFgBvEQ8eNl6QsLU+ADNbncIOIpwi9QlYt7mREKRgCEgwAFsK8u8adiaUiUOObDWfSt1pCkhUQQvIOK9PDWIK3wgA9rVsRvbMsJ0nQ5VfE5UB9LlXi2k6XUxc+OKFYL+Pj1pxBgJDeee/ZDMSJJRRnqfZ4IbxArPbxXQV8RgIErFIP+nVYzr5Ljj9OQmxdr7tb4iBORwWkoMivQ0WmoLXa6FRu50BZ9GT+dmgeNqKBLsooTB6s19Hl+MHgI3hk18re4KJYQ9xpha6XPcuAFKuTCGw6LxZprLUKJr1y3h0aIG8WA9DzaCxNrRC3sgyd0OwyKlSS9J8Di7+XR1vtb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxnCPjvL8N5eqgSF7huRkHV112uAXYHeI4vQSbEOMiw=;
 b=ULNNNwgGhFhXAus6WwObGbGT3Vehq36STihxOJuiS5vOUTDIri+yglsJBPSeBolppC4rggAZlZawrguNK0h5D23lAvnXSSekfwnBgjlK850DRuBphg4KBm42baaOGHk/d9xZpo19F6Qo5uxi4XGzuy/wN1SRA4+JUF5uEr67yuHBacZPCru9LznUNQQoLhzZlH1zPG3/vE7ZemX99CPiFXvG2nOQFOzY2H0NYZ2cJo+tr9rezt9vv9sv2xFlOG5tefCcPorvCxYRi5429eYPv3kNPRVWNU4FN05JIp58qn5egMCX6GtAn6GZQc1t4JRzpV/wZxbbr1g8+/Do3EfxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB7153.namprd11.prod.outlook.com (2603:10b6:a03:48d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 16:08:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 16:08:50 +0000
Date: Mon, 17 Nov 2025 17:08:43 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
CC: <netdev@vger.kernel.org>, <csmate@nop.hu>, <kerneljasonxing@gmail.com>,
	<bjorn@kernel.org>, <sdf@fomichev.me>, <jonathan.lemon@gmail.com>,
	<bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Subject: Re: [PATCH net v3] xsk: avoid data corruption on cq descriptor number
Message-ID: <aRtIiIvfVwJCmcn1@boxer>
References: <20251030140355.4059-1-fmancera@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251030140355.4059-1-fmancera@suse.de>
X-ClientProxiedBy: DUZP191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 61732164-64f8-495a-83f3-08de25f3987b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9xLr/PxsWXsX4yZ2d8q9uuDJFtU1O4d7FjkWv+T+HmbuQLHhhPt81NUdiQDn?=
 =?us-ascii?Q?QS9v+HDydamyPbKNfv//wZQj/4xalbME/lzpesca7bnaz60ehlAr9M6TBjjd?=
 =?us-ascii?Q?Dzeuq1e7quc9FFxqJioMk29y+ifqT/kS8zBdp6ixF5WlQ+ScAxUphCruAD6l?=
 =?us-ascii?Q?pkOM9pomnfi2b66oyMLJHoBNp4Ll8ee28gMrG/RKabmaeu6l4PsAt6Ecr/iI?=
 =?us-ascii?Q?yoJNxb77qYdW51nIs9Jez83WTLOm2fVVVgD3rJan5Yar4cA85KTcyZg48UUI?=
 =?us-ascii?Q?r8m8ozSJik2uS6h7x3RlMhbm1j39GKGrqf/z+TPIA4Mspj5JHZL0/x9lQlkl?=
 =?us-ascii?Q?SZVZWU+7ZKeGCXrohpgDOS7lE7k+FPcneTeOR6T9ECXghsV1q78GnmDRLPow?=
 =?us-ascii?Q?EM5Xsnctp2HhZlFTAtKR0IIU102D6/P6eXAVeaF5A7iQ+qq/2BzHupwwhBZc?=
 =?us-ascii?Q?FEFIEZAqWE/NEz54NU1b4Hw1iGk9muDvl83u7bKNJIOh+n5Bs51DQyaNuM28?=
 =?us-ascii?Q?6WprbTGZ87e+cY1WzDcmzKaXQr/52M9qu1XNqcnv/vhXWEd4CbGTdSrGUyAE?=
 =?us-ascii?Q?gGVFUH0gSvgUuPIrHy8hNsjMxl0VIGUWQXefk0dKoWvVjbd/xFzRXYvwEQH3?=
 =?us-ascii?Q?MYzZ1Is2PX9i76WbyDCXsjxUj/9yjpkC1/L9olFdvKK6xemI+jTsuDE8+f/J?=
 =?us-ascii?Q?/geC/YuAE5Sj33Z90YsYrvVtZjfQEznMcgUMkGh/n88HPqdnZbT5p9a33p8E?=
 =?us-ascii?Q?WpG3UM89oXgSUTJlpMUEwWVLaIc/F5nEpEgrxfyvDxRQIaq7GNYLTYQq6hD3?=
 =?us-ascii?Q?KZ/3ys/O6lwZ73zSbWDOduB74EBvdH2gYl66XmNwyAYMetPZZKF9XxxUfMDi?=
 =?us-ascii?Q?2wqHocvJ7Ui+oWTfLXXQgJtXCrhPnRA6mrfH6RVjw500Pifd2Il/K3gqCgja?=
 =?us-ascii?Q?kGOhd6pUVxVtQnikU4sw48QbmMgc2uiJChRgtoowotwMJokfnjw7i/9Jfsog?=
 =?us-ascii?Q?ZPldSUrgqHSnyY3RaQ4eNP10lW9/qGfUikxSzC8uke1dIpiu2q7MPtZv9B02?=
 =?us-ascii?Q?csg/6L/GByza+mvyWfAPMQmCdH52maHyFVlcBFetn+vGClHNHbd5dmxJfhEr?=
 =?us-ascii?Q?/DJyXkM9qtvp3NrbDgLtzwda2Gp8kL/Lc5BzdxJ+XKAWv/lN79C0rFWHwdTY?=
 =?us-ascii?Q?oFgApv8XiNyZUmXA7eZZI6aROZaRoY5BvWN/OvJ4wtTl/h2p1Pc0VjeVYn2O?=
 =?us-ascii?Q?XBsYbJ0aiArMyFMQS3y/c1vPOiK0CJxK6EQxorqVv5/1UhO3griD5nPsfAP+?=
 =?us-ascii?Q?Yfs9Yszn55lSzvxp4nhHw2Bwv/6cu3MHdfBr60wlLzKHKNS2Leba963ZgE7q?=
 =?us-ascii?Q?ycJ80ONnVyN9unCMMy7Tv8O3eoF2BqBxXDnAnYefVLj37EYupDEqFjTbYZjs?=
 =?us-ascii?Q?J/wTJd6CNz6NRfWDXZgog3ElZNxXD5q8vS7iKOInscheOrS6+R/a2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3plw2hTPSoFq5XHqEIJVDO1v/T0hUeGLVJSs0Us3ws7S8qpxRG2SZFlfD6zG?=
 =?us-ascii?Q?jvIatLe6kUg6UAujIRPCe2MUq4oq8V2mHCrdGjaqchZdtvw8m0XIu+esbGPK?=
 =?us-ascii?Q?6aOi1daFu1SzLtpqRTXQ3o2246E3uBsQjHM+0+skTtmWCgaz8IKOSbPLIxuX?=
 =?us-ascii?Q?ds8QHAQC66hFMeYzQATVcMHWo5l5Z7LcmuZpxZYoNxdXx7yk+V3ujD2rD/xB?=
 =?us-ascii?Q?CVZs3+dst9CCSRJo5p7+t8QTpZfkrB565W/zsZDOzsabsx2tn11jtU4At3NU?=
 =?us-ascii?Q?RXDlcXnAAMKgqW3Ho+2yRyz/1XSE4t/XtWUmmOyttgNQ4BImrdcqFFLP4IJw?=
 =?us-ascii?Q?z5lVZukFVm9m7pZiluUTChWA4KDHs2BKx1vVCK6xuw0sRcgoptEiJrr/eKt2?=
 =?us-ascii?Q?B67p9zz7f38vXJs7B0zjSj8exyIvibF581U4zvn1LTyifL8sHhbd01/ayLYz?=
 =?us-ascii?Q?97OrtokZWlWmvKM0O/apTgsG9PPuRfoVmvbnnOPlh6SDbhBUvRK9FSzwlmxn?=
 =?us-ascii?Q?IfBdc1SMf7sae9tFbBfGoYcs4f0avu8+5reG4AjLr6yfldjzJU/Sjw+zbNKS?=
 =?us-ascii?Q?NQ6W5z3cuOVOEoymV1OP9w1yqjrk1bYR5s4G94HnJHHiE8iwuno83y+gxgGu?=
 =?us-ascii?Q?l2O7hz0tnAtzyvUpqItAZjP/G/+Y1OCJZB3L1ZtcRHU9gmEBJ4nwWtUqfVF4?=
 =?us-ascii?Q?Qx/boiddYg1hOSKIzRkQe/ukBOP2qrWsl90fGZ6Mfj06eTdJb2z3gCUzIcQf?=
 =?us-ascii?Q?xTyA8Lzia719y/wWFLL23gmndSeBYKq8D0+4+O4bZ1Z8rfsx0XCXEcVNcMla?=
 =?us-ascii?Q?1FDLXZDHdOk5/9d0+osNTwYVbZeSdFdL1VoEYb07j3vrEPqdQlgnScDsa+Wn?=
 =?us-ascii?Q?AH+n8xq6t5o7Lek3e+U+PXdBaF1/29cXkZMLWzdqd4GxRQwZ73p7MkWHPImH?=
 =?us-ascii?Q?3qw8XRJb7pUraC4w6bnl1o5ntLh/L53WYANij8yLOD3CZMmTK9793TkY1xIa?=
 =?us-ascii?Q?1U8RUaOE+YObLc6OcmgAfTIKVcCtFxipF11bWgNRN0WXMX66h7mlUF8ZYxEQ?=
 =?us-ascii?Q?39WPxmjmR7eTYZbqt9Ch3WBhG2unwudUZAVAwaAZ3jaMXtyeGdzFf8KT8NRh?=
 =?us-ascii?Q?udO5joCxnE/g+UFlupZaanWKiQTpUc+NK8ZnZ3pyPoykH/2r+MM3goqnpiGx?=
 =?us-ascii?Q?ZTHLYvW/H3f+SZLEfasqnxq9exDG75jv6fQzgOvwDOSE/9PSXQPJmpWZHuMq?=
 =?us-ascii?Q?TeF3n60dY6Sog6DQyMK8Br1heMbomlo0nLqycX/JaLuv6JQOaHDiWKVjAc8U?=
 =?us-ascii?Q?NsYStOVwX+LHoSDJGvAxd2bqXCGKkHi+Mj12muzHzs/DRLm8YZ8DaTTE5q0Q?=
 =?us-ascii?Q?3krT+MHZ3DfHV3QPbseWo4CGxiZmusMiLHhcCw49CiZqpbZdYLRdGc5AgB55?=
 =?us-ascii?Q?mmrebQzs+YKfYfBVyytZPCDr5W5KbEsEQbC2R54YI0Fa4sGxrSOdX7BkQYzq?=
 =?us-ascii?Q?gkfnCynvFvlrcJu5g1Vycr+L7IDLjAaVmHqr7NVQgHOYIP8S5x6Odpdc3hgl?=
 =?us-ascii?Q?K7THIXaBmEdfSIqy1QYOFK08cHzfWCKRdY82o0zC1shSKnSkFlI56ESmuSkE?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61732164-64f8-495a-83f3-08de25f3987b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:08:50.5690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyZDpTnOvkUu2sHuJO0EXGkiI+zCeuSg3noI5fPFCPc+K1thLjNr9a5tcczw+UCGVQNJ15fgnfC6nVU+zsn81N2J0XhmYP4OomD7BvYpwag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7153
X-OriginatorOrg: intel.com

On Thu, Oct 30, 2025 at 03:03:55PM +0100, Fernando Fernandez Mancera wrote:
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
> 
> skb control block shouldn't be used for this purpose as after transmit
> xsk doesn't have control over it and other subsystems could use it. This
> leads to the following kernel panic due to a NULL pointer dereference.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>  RIP: 0010:xsk_destruct_skb+0xd0/0x180
>  [...]
>  Call Trace:
>   <IRQ>
>   ? napi_complete_done+0x7a/0x1a0
>   ip_rcv_core+0x1bb/0x340
>   ip_rcv+0x30/0x1f0
>   __netif_receive_skb_one_core+0x85/0xa0
>   process_backlog+0x87/0x130
>   __napi_poll+0x28/0x180
>   net_rx_action+0x339/0x420
>   handle_softirqs+0xdc/0x320
>   ? handle_edge_irq+0x90/0x1e0
>   do_softirq.part.0+0x3b/0x60
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x60/0x70
>   __dev_direct_xmit+0x14e/0x1f0
>   __xsk_generic_xmit+0x482/0xb70
>   ? __remove_hrtimer+0x41/0xa0
>   ? __xsk_generic_xmit+0x51/0xb70
>   ? _raw_spin_unlock_irqrestore+0xe/0x40
>   xsk_sendmsg+0xda/0x1c0
>   __sys_sendto+0x1ee/0x200
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x84/0x2f0
>   ? __pfx_pollwake+0x10/0x10
>   ? __rseq_handle_notify_resume+0xad/0x4c0
>   ? restore_fpregs_from_fpstate+0x3c/0x90
>   ? switch_fpu_return+0x5b/0xe0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>  [...]
>  Kernel panic - not syncing: Fatal exception in interrupt
>  Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Instead use the skb destructor_arg pointer along with pointer tagging.
> As pointers are always aligned to 8B, use the bottom bit to indicate
> whether this a single address or an allocated struct containing several
> addresses.
> 
> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Fernando thanks for stepping in and providing this fix!
And thanks Jakub for ptr tagging trick.

@BPF maintainers, please apply this patch.

> ---
> v2: remove some leftovers on skb_build and simplify fragmented traffic
> logic
> 
> v3: drop skb extension approach, instead use pointer tagging in
> destructor_arg to know whether we have a single address or an allocated
> struct with multiple ones. Also, move from bpf to net as requested
> 
> Note: tested with the crash reproducer and xdpsock tool
> ---
>  net/xdp/xsk.c | 130 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 74 insertions(+), 56 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..d7354a3e2545 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -36,20 +36,13 @@
>  #define TX_BATCH_SIZE 32
>  #define MAX_PER_SOCKET_BUDGET 32
>  
> -struct xsk_addr_node {
> -	u64 addr;
> -	struct list_head addr_node;
> -};
> -
> -struct xsk_addr_head {
> +struct xsk_addrs {
>  	u32 num_descs;
> -	struct list_head addrs_list;
> +	u64 addrs[MAX_SKB_FRAGS + 1];
>  };
>  
>  static struct kmem_cache *xsk_tx_generic_cache;
>  
> -#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
> -
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
>  	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> @@ -558,29 +551,53 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>  	return ret;
>  }
>  
> +static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> +{
> +	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> +}
> +
> +static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> +{
> +	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
> +}
> +
> +static u32 xsk_get_num_desc(struct sk_buff *skb)
> +{
> +	struct xsk_addrs *xsk_addr;
> +
> +	if (xsk_skb_destructor_is_addr(skb))
> +		return 1;
> +
> +	xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +
> +	return xsk_addr->num_descs;
> +}
> +
>  static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  				      struct sk_buff *skb)
>  {
> -	struct xsk_addr_node *pos, *tmp;
> +	u32 num_descs = xsk_get_num_desc(skb);
> +	struct xsk_addrs *xsk_addr;
>  	u32 descs_processed = 0;
>  	unsigned long flags;
> -	u32 idx;
> +	u32 idx, i;
>  
>  	spin_lock_irqsave(&pool->cq_lock, flags);
>  	idx = xskq_get_prod(pool->cq);
>  
> -	xskq_prod_write_addr(pool->cq, idx,
> -			     (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
> -	descs_processed++;
> +	if (unlikely(num_descs > 1)) {
> +		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>  
> -	if (unlikely(XSKCB(skb)->num_descs > 1)) {
> -		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> +		for (i = 0; i < num_descs; i++) {
>  			xskq_prod_write_addr(pool->cq, idx + descs_processed,
> -					     pos->addr);
> +					     xsk_addr->addrs[i]);
>  			descs_processed++;
> -			list_del(&pos->addr_node);
> -			kmem_cache_free(xsk_tx_generic_cache, pos);
>  		}
> +		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> +	} else {
> +		xskq_prod_write_addr(pool->cq, idx,
> +				     xsk_skb_destructor_get_addr(skb));
> +		descs_processed++;
>  	}
>  	xskq_prod_submit_n(pool->cq, descs_processed);
>  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> @@ -595,16 +612,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>  	spin_unlock_irqrestore(&pool->cq_lock, flags);
>  }
>  
> -static void xsk_inc_num_desc(struct sk_buff *skb)
> -{
> -	XSKCB(skb)->num_descs++;
> -}
> -
> -static u32 xsk_get_num_desc(struct sk_buff *skb)
> -{
> -	return XSKCB(skb)->num_descs;
> -}
> -
>  static void xsk_destruct_skb(struct sk_buff *skb)
>  {
>  	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> @@ -621,27 +628,22 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>  static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
>  			      u64 addr)
>  {
> -	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> -	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
>  	skb->dev = xs->dev;
>  	skb->priority = READ_ONCE(xs->sk.sk_priority);
>  	skb->mark = READ_ONCE(xs->sk.sk_mark);
> -	XSKCB(skb)->num_descs = 0;
>  	skb->destructor = xsk_destruct_skb;
> -	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
> +	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
>  }
>  
>  static void xsk_consume_skb(struct sk_buff *skb)
>  {
>  	struct xdp_sock *xs = xdp_sk(skb->sk);
>  	u32 num_descs = xsk_get_num_desc(skb);
> -	struct xsk_addr_node *pos, *tmp;
> +	struct xsk_addrs *xsk_addr;
>  
>  	if (unlikely(num_descs > 1)) {
> -		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> -			list_del(&pos->addr_node);
> -			kmem_cache_free(xsk_tx_generic_cache, pos);
> -		}
> +		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
>  	}
>  
>  	skb->destructor = sock_wfree;
> @@ -701,7 +703,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  {
>  	struct xsk_buff_pool *pool = xs->pool;
>  	u32 hr, len, ts, offset, copy, copied;
> -	struct xsk_addr_node *xsk_addr;
>  	struct sk_buff *skb = xs->skb;
>  	struct page *page;
>  	void *buffer;
> @@ -727,16 +728,27 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  				return ERR_PTR(err);
>  		}
>  	} else {
> -		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> -		if (!xsk_addr)
> -			return ERR_PTR(-ENOMEM);
> +		struct xsk_addrs *xsk_addr;
> +
> +		if (xsk_skb_destructor_is_addr(skb)) {
> +			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
> +						     GFP_KERNEL);
> +			if (!xsk_addr)
> +				return ERR_PTR(-ENOMEM);
> +
> +			xsk_addr->num_descs = 1;
> +			xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
> +			skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> +		} else {
> +			xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +		}
>  
>  		/* in case of -EOVERFLOW that could happen below,
>  		 * xsk_consume_skb() will release this node as whole skb
>  		 * would be dropped, which implies freeing all list elements
>  		 */
> -		xsk_addr->addr = desc->addr;
> -		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> +		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> +		xsk_addr->num_descs++;
>  	}
>  
>  	len = desc->len;
> @@ -813,7 +825,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			}
>  		} else {
>  			int nr_frags = skb_shinfo(skb)->nr_frags;
> -			struct xsk_addr_node *xsk_addr;
> +			struct xsk_addrs *xsk_addr;
>  			struct page *page;
>  			u8 *vaddr;
>  
> @@ -828,11 +840,20 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  				goto free_err;
>  			}
>  
> -			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> -			if (!xsk_addr) {
> -				__free_page(page);
> -				err = -ENOMEM;
> -				goto free_err;
> +			if (xsk_skb_destructor_is_addr(skb)) {
> +				xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
> +							     GFP_KERNEL);
> +				if (!xsk_addr) {
> +					__free_page(page);
> +					err = -ENOMEM;
> +					goto free_err;
> +				}
> +
> +				xsk_addr->num_descs = 1;
> +				xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
> +				skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> +			} else {
> +				xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>  			}
>  
>  			vaddr = kmap_local_page(page);
> @@ -842,13 +863,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
>  			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>  
> -			xsk_addr->addr = desc->addr;
> -			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> +			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> +			xsk_addr->num_descs++;
>  		}
>  	}
>  
> -	xsk_inc_num_desc(skb);
> -
>  	return skb;
>  
>  free_err:
> @@ -857,7 +876,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  	if (err == -EOVERFLOW) {
>  		/* Drop the packet */
> -		xsk_inc_num_desc(xs->skb);
>  		xsk_drop_skb(xs->skb);
>  		xskq_cons_release(xs->tx);
>  	} else {
> @@ -1904,7 +1922,7 @@ static int __init xsk_init(void)
>  		goto out_pernet;
>  
>  	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
> -						 sizeof(struct xsk_addr_node),
> +						 sizeof(struct xsk_addrs),
>  						 0, SLAB_HWCACHE_ALIGN, NULL);
>  	if (!xsk_tx_generic_cache) {
>  		err = -ENOMEM;
> -- 
> 2.51.0
> 

