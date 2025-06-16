Return-Path: <bpf+bounces-60776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F2ADBCBE
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 00:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE9F1893284
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 22:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33861DB92A;
	Mon, 16 Jun 2025 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auF1qkGQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1D28F4;
	Mon, 16 Jun 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750112219; cv=fail; b=EPccNLstTTLu63eo+j+VpeA7VM0Z0SzJX9ncsqA8vL2FsM9OWDEp/RghflXiuKAqCzhsrnfDdMJiF8rth3NkzNm9qn/qig5tJ8vEU7dM/PcdDNsDzaDIhnAS++L3ObKvBlDLFO7tMormXO303VATz5uFL9U5tZ2/WbPXMOHAgWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750112219; c=relaxed/simple;
	bh=TsxjG4ikUrqtP9Lsq0sRr9ZKc7o/x7n4PFZG5Is5Dok=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nbLzgi6lJVujnYm3Jdb19qVYlp4xU1UEU7MgyYB28eguC6eBwQPf+mKCkqBresOTo/37sd/eabrbhblSvWUzV0k2l33BaKKR5QeS5M+fKJBzLILX5d6xT0bXPavbiaIPI5r4FHkE9j8i61DHdHYzRmQZgbqYzeNlKdKuMslQmis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auF1qkGQ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750112218; x=1781648218;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TsxjG4ikUrqtP9Lsq0sRr9ZKc7o/x7n4PFZG5Is5Dok=;
  b=auF1qkGQLxJbFV4GYTV49yn0tUrQaqU0kHrOfwKDCe7l2LbpBz1TmUJd
   uxlNU0MdeC8MpOX1Dox1WZ1CLl2YynViHrtLQNCLfD3KkA9Clsz8fyAbe
   FtU0pxlrXIWWthh6h3nkvHIvHk2F072ABfIEU4dO5M5p/vghYL1E9rIle
   KnRnZBL/a8rOvfRGcrvcVbkhHUtVJUrSjMfnyEGK3JK/px+L4lXaG+6ek
   VVSAoUjC2sCqyqfW6TXRWjNkj5bUPT1uVXG0oQSt8MThAd45oJa+Df4b5
   1Wyd/9ibPCfOuaKjdmIJwnL3dIL2UMUklLBIEoTwWKoJWdvFrZdzWqnK0
   A==;
X-CSE-ConnectionGUID: 9J6Ka7EbQJKlNbFseJurmA==
X-CSE-MsgGUID: l2u2V8GZSIifXzbSPvgGig==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52404552"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="52404552"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:16:44 -0700
X-CSE-ConnectionGUID: 37z7tGY6SOqcBnyjaJSj0w==
X-CSE-MsgGUID: AIHNRX/HQPSrTqlu0SeEWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148484943"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:16:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:16:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 15:16:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.43)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJPW/nanSbBpGanu18r+RtpeVsT6sqG+7ABYVstKDVAxcQRjTx/xStSUg/iOoVFxQ0mzFS411WleY9OcoI0RQXdQBQx7bvCsN85woOzH4rcnTctVEIa+Oah+0hONOLO7EILjSb0DOEc+bh72zTOTXF1cgX8WKGrxY5Q8BRo/tRSEeMFjmvUnj77Ldir+Ap088fEGywmQuUhQwhkWgyXgNsB8NiJqkqXYT19rfcXeNaCDqAxxuIM3iYKdwSdY/0LjoMZbUazr+1gjz0P65g4wwArPzdIRmZHa77x479cN8GZ+WgPeGrNRIFMGN3pJSGZvZgO/hQjrL4uhX+eF8pTt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCjejdW9KtVnJrj/ZnTCcU4BZuWbN1qB9lNHdm+TsU0=;
 b=nLCYQAfd++TyrxAjxEGZbPqB4Nmz4gy/J22xKAufkPZtiAgzjiU8pc3n68kHuU8y5cqnerwLKTMWfg3HLrQ9gXllnbZZG+QvTFoEeusucBxaYQEYuZTQW1hCJ3l5/JBiToeIcDz5ljt2QskYXeKm00fUAG5bOILQ3Whl1q/HJEhPCY4IVRshiizIGg9ujuL+CnloS8+cwg3C39yRF0YAurrsBrzNfl1zf6+bGge1nkUhr641qt0s4CEuK5DNTqPVN78TK8TObEMFgKvkMFcMC+NR39OWU3EZ0+0GhVP2a7e29ZU9meiUi0gzchfGty1vMT26INQq1uJ4EdV9QPjxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8716.namprd11.prod.outlook.com (2603:10b6:0:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 22:16:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 22:16:34 +0000
Message-ID: <3c71816f-39ce-416f-9ce7-1f65ccc4c1b6@intel.com>
Date: Mon, 16 Jun 2025 15:16:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix packet handling for
 XDP_TX
To: Meghana Malladi <m-malladi@ti.com>, <namcao@linutronix.de>,
	<john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250616063319.3347541-1-m-malladi@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250616063319.3347541-1-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e01f31a-5706-4ff0-26e0-08ddad237464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REZpbzV5Mzc2UFNOME5BWlRiUGw1WmxsTVVKUVlrYkRQUVRETkNrejBOYWd4?=
 =?utf-8?B?RmY1QjhSQlhrYjMwT3hubDgrV0taY1k5R0RESGlJLzlmRkNTYTVIY1VkWFAw?=
 =?utf-8?B?ZEtUTkY2Ky9JeTBybjIxdzY5cHRiOEJXM1B2eERCSUFpYmI2RE50RTFWMjQ4?=
 =?utf-8?B?Wms3QW8rTEJTREtEaUdLdGtuYW4za2dESjN2UmZUUndHS1kxVTMzWWNrMzZN?=
 =?utf-8?B?dWtOOVpnbjRwWjY1T01vK2tFY3J2cUJqRlJ4aVJDSnFPeFhHVXZUNGp4a0dW?=
 =?utf-8?B?KytiYlhiUjVVSnBsY3QrL21oQlk1VTZuYzFtVjFBeC8zMXZLMHM3UHA0NFNz?=
 =?utf-8?B?VFZxdjdDb2pMMk5BeUVkcm1ZWGFrRDJQdXJoQW1yTDhPNWF5TmU1OVpGa1FZ?=
 =?utf-8?B?aFMzdUJvNEV3WStObkZCY0pNRUtGYi9uaDgweTA2RHJoOW5zaFhFVUNMbVB0?=
 =?utf-8?B?Q3I4czVHcXNZcmcrcy9lUFVmVUsrUE9KMnlDY1EvQWtScGwyUGpqYWE0TCtI?=
 =?utf-8?B?NkZMNC8ydysvM3pXbzNNUm1oTnpsZVJHSkpYbnF2dWFRaGoyc0JPRFVlOG5j?=
 =?utf-8?B?SXRKanZvaytaWVFKZXo5V3NSOW9oeWVWUndweTkyT1RKc1RQb3dPYkh1dmlD?=
 =?utf-8?B?bVNOcFpCZ2NsVHg1V0NqZXM4YTc2NC9od3pMZ2h6YnB1VFBIeW1kTkorL0RF?=
 =?utf-8?B?Y2FKbm9hZlFBRlV3QnJuT1VhdUFtWnpMTE93SzVub2lFYVZPWXI2ckdUOTVu?=
 =?utf-8?B?bWNWZU16Y1VVbktBUDdiaDY4TXVuelBuc3M2MFhzQk5NS21IMUsrNDNVWjd3?=
 =?utf-8?B?dlBzYUF5WDdsWVNqeVJQNGh3cVAvdjNIYmtQdTIvZkxJUWY0aElwVEpFdGF2?=
 =?utf-8?B?NVFxc2dlbHQwdFdITlQ2czBzTUpoc2ZLQ1Nrc3YzY3IyNTMxeGorako5ZEtU?=
 =?utf-8?B?Z0dMc0NLejdCeDZiL1l0OWc3Z0FsWWpIMzZNV0VzVWpCdHVrU1UwTWV6akVH?=
 =?utf-8?B?aytiYnVTT2lMMWVzVTVvS00yLzZ6azdWa0p1UlY3RmVYL1FNaXZwNW51YUp1?=
 =?utf-8?B?cklSbTBnQmg1eTM1a1RJNnJVSlQ4cGcrQXZWZk5RV09xb1ZpMVlFSUlBTVVT?=
 =?utf-8?B?K09nVllVcmNmVXpVdXN1RnV5Tm5LVHl4VnVRbUpFV1RWSldUOVI0T2craTdP?=
 =?utf-8?B?Q1l3ODhRdExYMlZodkZRc1Ryb1dsVGVzOXBGS1QvVWtnd0pmNEFzaVVoL1Bq?=
 =?utf-8?B?aHJQLzZUankzWElRT1hiaE1RTldOZ05UT0V1VkgrM2pwTjUyZ2tiZFJjbHcx?=
 =?utf-8?B?cy8vT3MvUno2MThHTE9HM1huOVlHbEc2N0JnVFZML2YrN25pbkx5V1ZVQ1JR?=
 =?utf-8?B?VDBwM2loZ0JTUG14K1NUWW5hWWt2Wm9GZGwvS25vMFNnODhTNGlSMFVxOEhl?=
 =?utf-8?B?bTF3SkpDREVxMEJLWkVIRWt4YXBZeDI3RDA3T2tiOHNVSHB5YWFDSWVRSWlS?=
 =?utf-8?B?SjNPUlFFNXJET1BWQlc4Z0ZsS1ZrYzhISGo0KzV5ZGdhOEZTYUl4WkFmLy9I?=
 =?utf-8?B?SkdwWDdtd09BSHhHVXNaN3pVWUFuM25BTm81S1BoYmRBYTNYZEZYQ01DbXpn?=
 =?utf-8?B?T1Jlclp0YUQ3QU1EcXNtSkNST0dHelNObFR2UDVWdXVvNGVSNnhVUEJRZ2RY?=
 =?utf-8?B?amdheS9IYkg1c1J4dGhuNlFOTWNjNVlCMXBDcHhPS21WeUNvOEJYV2VtQlpi?=
 =?utf-8?B?UEIyOWUxbkxTMWgvSHBibmx4TnBFSExwUEI5b1ZDQkw4R1h3anBJY05paExh?=
 =?utf-8?B?elN3L25ZWjIraFBnRFkveExZdjZLK21ZdFdEMUpvT0pnUzdsdklNUzQxTmJ2?=
 =?utf-8?B?eVZaU2tPQU1EbUdyQjJUWG9yOTllUTBjSTZlQ2k2RVBrZFBFRU9XNDdjaSsr?=
 =?utf-8?Q?hUQoZ9JEHXJ9bvepVQELRleZgqA5TTDX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU1WR3NBcFk5RkdTYjMxeWNBTC9nSERFYlY3bGZhZ1ZVc0pReW5LTy9JRExW?=
 =?utf-8?B?alRjazVIVGprbHRrRjZMQVIxbkIxdXF0U3diQmttYlBnVVN5QjY5QjBBVnBP?=
 =?utf-8?B?OU9CNno0VVNaRThZK2pBZHpyNWZDMnJCSlVQeTA5VlQ4aURwcElEV2FPMUI3?=
 =?utf-8?B?dnJBUnlKSFJDSS9iY0lxbmZhcHUzbjJkeWxyTWg3MUVVUXFIVjdSMnN0Y1pX?=
 =?utf-8?B?SGFFY2FxNHVrcmRHNVJsTUVEcjZVcURFVjhrSFR4WE1XT3FCckdXNEhBOE9n?=
 =?utf-8?B?OEloZ1RDWUlqb1hIbSsrV0ZDcjRmakt5RXFUc3pxWklaVnhDMk92ampNK2l6?=
 =?utf-8?B?Vm1HeHBybys2dWFPVnM4TkU0RlkvVEJ6U25lSmlYT3J3TnpFSVUwL0t6dGhm?=
 =?utf-8?B?Z3IvU2FQam4yL3VTTjc4eFZEUzdtVHdRejN5RFZ2OGVrYjUzSGxncFd4NVA1?=
 =?utf-8?B?ZHEwaGxDSkM0cTdZb0RzVyt5QUhCL3NDTlR5U0VaV1JuKytaOEdQWUptK1R2?=
 =?utf-8?B?MmFXeWZJcit1WmUrZDBxczBvVGVjUERZRkxmRGdTRVJhV3ZVUlFJS0dTUldM?=
 =?utf-8?B?ODBKUXdWMVppNFkrb0hnRFA2cmtrMGpXNFdycDV3aWxBOFFyellMODgrdGFk?=
 =?utf-8?B?S1ROQldhblFsNUxUQ3R6SFk3MGpaZkJRbFBhN0haOFZxcEJHc211OHVQZTA5?=
 =?utf-8?B?RFh1VVU5OTdrK2N1VU5qbkNOT1kreVMxQUltcjdtcm5TdVorQ0tVQWJ1Wlhj?=
 =?utf-8?B?VWFpWnNqam8yQTJFTitkb1hWQ3BzRmh5ZStWUHVyb0VEVFhFWGxoMzlqcDQv?=
 =?utf-8?B?aUZ1N2tMb29rZ25NT09rQzhPNExtNi9WVnBuWUNYWTFBcVFYdnY4blBLZDZX?=
 =?utf-8?B?QnVyaUtIS2szZXZFWFU2dElvRWNqS29zQzc4ZXFEUk1TcmQzVHJiQng5cjZJ?=
 =?utf-8?B?czVOYU5hVWoxeXhXSEVIeGNGcmtOeUErQ3oranhmUGdrdjBCazUxVldQelV2?=
 =?utf-8?B?WFRsWC91VGJDK0F5ZFBubS9NUDk2L2VCSEZyK1JqekoxQjhMTFo0ZlJtdEFS?=
 =?utf-8?B?dDU1dGsvZEgvUTlFZVRXdU5SdzRHM0xrOEQwL0Q2SEdOYkFhdzVXWDFsMjFs?=
 =?utf-8?B?ZUhreWNpVG1XS0hDTm51c3M3UE1PNUFTUGxIcno4LzVUNjAvK2VlOHcwdmlC?=
 =?utf-8?B?TzEwUEdTeXJkN0ErLzQ5OTRacDJJcEtQcSttMWluSFR6K0MrNk9lU0hmOFVX?=
 =?utf-8?B?ZHg2ODVHYXF3QnFBTUdZdGNNTnM4MFl2UTVOVlloSEg5QXBCKytYdkhYM25R?=
 =?utf-8?B?MDkyMXgvekNZUGIyREYyajBHR204SWxRREVmRHlBakxKM01TMTViZE1pZkZD?=
 =?utf-8?B?QW1LUTJZQkJaUDNTbFhSd2EwSlBUU3lxOU1MRlhvb2VFVmRzVHlkZlZFQWFU?=
 =?utf-8?B?WElVMm5YZEFDcHBsRk91ZGg1bTFoMC9Td3U0VmJNREhnUWxVRUJ6ZUh1Rkhk?=
 =?utf-8?B?dmtZVzV1UE9zU0xGYUEzSFRQbTY4RmlDdk5nVHY3ZVZJTzlOaDlCMjRFV1o2?=
 =?utf-8?B?bkpPTW5nTGQrSVUydXFsUWxTb1VMcmV4TVZDRXEvZmhFclc4VWRiSU13bkQ5?=
 =?utf-8?B?M1ZnTFJzcGYrV2hOV1hFZS9najQ2cm8wVTV5TC9JempqQ3JEYUFPbi9sT1V2?=
 =?utf-8?B?TDRydEY3SnUzbFNVdXo1QmQ2MCt6VStpOVYwRHQvTjFVc21pbVBObFhmeWI2?=
 =?utf-8?B?NEo1eGtpZHpWVE16SXhOR3orSFhtdzIxMFYrZURFd0RhUjJwY0RFQlRCeVVk?=
 =?utf-8?B?MXVqNnN6clNWOTcwOFA1K0NmVGFselh3LzVzR3BLamJOUmJYNUxGblN3Mnll?=
 =?utf-8?B?b3kvSjIwaHhnVVNNeFFGZWVTZkRkRVFseUpIblVET2FVMTJRZE1ZQlhIME9B?=
 =?utf-8?B?eXg1SzhVTVN4MTVibnNxeWFXZTRaRjVNY3dCc1lPTndzUi9zTzZzaDdoTUVw?=
 =?utf-8?B?eXp2aklDOFZ3N3dxVUpSUDZZcVlxRC9NclBCZTk4bUZPSm54dHV3TW0zQmU0?=
 =?utf-8?B?Qy9OSE1XRXJ1UmRpdXAwbmZjOUJNWXRRanl5dEZvYmFlVzlyNmtzc3BEMWNl?=
 =?utf-8?B?Z0FDSWIvblZLUjEycGxuejNUUmtLSHpydEphL2xkd3R3dXJrSGhYRHIvYnk2?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e01f31a-5706-4ff0-26e0-08ddad237464
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:16:34.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PapGhVr7f9CWCG8j2RMZX9BbeMC5BhKWt2TGmYw7seKsW4vnv14Aahhm8xKlanBvC9xEqxsTlHp8tmeMo9hgfFxromUjNNF+eKgzWpSHJJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8716
X-OriginatorOrg: intel.com



On 6/15/2025 11:33 PM, Meghana Malladi wrote:
> While transmitting XDP frames for XDP_TX, page_pool is
> used to get the DMA buffers (already mapped to the pages)
> and need to be freed/reycled once the transmission is complete.
> This need not be explicitly done by the driver as this is handled
> more gracefully by the xdp driver while returning the xdp frame.
> __xdp_return() frees the XDP memory based on its memory type,
> under which page_pool memory is also handled. This change fixes
> the transmit queue timeout while running XDP_TX.
> 
> logs:
> [  309.069682] icssg-prueth icssg1-eth eth2: NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 45860 ms
> [  313.933780] icssg-prueth icssg1-eth eth2: NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 50724 ms
> [  319.053656] icssg-prueth icssg1-eth eth2: NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 55844 ms
> ...
> 
> Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

