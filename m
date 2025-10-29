Return-Path: <bpf+bounces-72829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EE2C1BFAF
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 17:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A85A1B43
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 15:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7140033F8A7;
	Wed, 29 Oct 2025 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pyj/Zj5l"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778C3358D4;
	Wed, 29 Oct 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752931; cv=fail; b=Rqh8YdgfkWyL87LOIA0CP9Lm2DIu/JpQDpf829wmukakgslLKZMSx2ydjtRHldW40Kl5I8UkF0fxyZlstpxxU7rt/ECZxU9iWPGyak3TAGv6Nm+Pe9hO0z2C5mxgI3DJsahzKlt75bPTQfHgT1wXLjjRYgNiEMTL1Sj7UEw0WXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752931; c=relaxed/simple;
	bh=DmgrP6/Oh2+8NPoSAjlq5YP8w67og4uBleF/6b/w4Sw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tYUCWIsELs021mlGMSkxRVFUlNzsClQ9NviNzZ9mLUZIwXitMBFqxvHE6ucMD+zGFeGuoIfe3E9ziIUuql5M8J8uarb6iQ6QQxblXLW8tuROYQb5G7xgznjxs5bJEGrnlXr2fFXg3qQORnDhFJAJZPHLYncOvwCENQ20xTlegoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pyj/Zj5l; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761752929; x=1793288929;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DmgrP6/Oh2+8NPoSAjlq5YP8w67og4uBleF/6b/w4Sw=;
  b=Pyj/Zj5l1j0U5qPyDo2D+jwO8vnd8bWKuy5Qhf9KHrgwpMQcjAfM+x9F
   OpVjiT29CnAV2LMFvPaGxnqRe8N8te7SVhHVyyKRJnxuwJw/5jm/qmKv5
   /CwA0+Hi7pL0hPeXAxzDH+5oDzDpw3aYvuDggMo8ql1fVVVglVHUMcEhy
   3zuyLQsvN8SGejM136zUjtqt2tAW4hy/l65xleYoPv2wHhMXfbZOxebxA
   CzmdBP0F+fyR6/f1jzMXzgt29lOBOiGwKRZWs96TnHAobgZ3WK2NUtXGR
   AFFEnQu6Iw5bK9Of9f9fLjGWPuS1OuDuu3RVDgaEO3K3CyUhdbI65JFhk
   Q==;
X-CSE-ConnectionGUID: /azXr4AJSImb/4i9wV1JGA==
X-CSE-MsgGUID: FilgZRVwS+iOUUFPNzl/xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63809276"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63809276"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:48:46 -0700
X-CSE-ConnectionGUID: tirK4HTFSMCjsEUAESjqdg==
X-CSE-MsgGUID: VSaL7zUaRFmPvBGjgfrcNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184892567"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:48:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:48:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 08:48:46 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AENd2RY3Sx0EKUs1Z/RLRJ1f5VcHQudrV8blwO7CIV4kMsOt4791Bq1rS7twkRNZVGNpQxxwrk5vOKA3pYdusW4TzWWlMug1gjtCkG/hxIbw7mLIa4KIyiIRKfWoPunruCMdaA7j07TRQfpXvhAl9H6wWAPmxb91H+fhEqsQMgKr8E88yfKufVYhWWFFAXskJ8EcwarLyk4RmevGUcpfwvV9ThMFPtLMixuOCyCD8xjLQ01CZfIqx6vEJa0QDeAHjUxw8tamfI1vw03FROLs8lBggfYGjjU1ndpIbu6tsvXFHtKf1eW30zvR4WHmuSp28pEAJWh+muBVg9zLbH/VYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VJxG7qdaZMgGletNUWv9om2bXoiFF7kwDODJxh+iJc=;
 b=tcNmy67+2tqqixtRqY98nEZCcqeZMp4hBhY3QJ4vmYt+6ckO4sSt/QpAI8cBo/c61JZRC2x1UvFAS2WlAxaB4BznKZozaGmoUX4fUU+LoLDmkksAyKhOBYsM1ruTKHscYa3h6j1NcKygfVqgfk5rYg1mdC+MUOYzBmNb7jwl0LlnwOUNBnZyktP09DrtUKi5aXxaUw5UR0Cq1iETbIEB6jufIbbO8gpeouZwnGxU4bUH241CNfEC+OfHnVCQNhlcU4l1Jx7MUPpCNv9FLYrLAhXxXWuDCVvMsGUN1k3/MouA/iX5DnnZX4Z4eRMV5uK3T+vr8HsAf85I/Oir/ng2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA3PR11MB8939.namprd11.prod.outlook.com (2603:10b6:208:580::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Wed, 29 Oct 2025 15:48:37 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 15:48:37 +0000
Date: Wed, 29 Oct 2025 16:48:29 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 1/2] xsk: avoid using heavy lock when the pool
 is not shared
Message-ID: <aQI3TfFZPPaWQOS/@boxer>
References: <20251025065310.5676-1-kerneljasonxing@gmail.com>
 <20251025065310.5676-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251025065310.5676-2-kerneljasonxing@gmail.com>
X-ClientProxiedBy: VI1PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::25) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA3PR11MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: af6a5dba-ff61-4558-4ca6-08de17029fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sQ9t/i12T1RyXWNTvg3j7Z4gSHs4IyR+oLrigUvGMnc1DZ8PK+yP9JBglQKo?=
 =?us-ascii?Q?rd1fbAJjKA8IB3EsOYCjdml2PFsrPjLWobUfHyWmcjrs8nj43iy4tOg2F0pU?=
 =?us-ascii?Q?DI5oatpS47TRPSyG8SzAfqt4t/nmHiiCjcUnr9NT/ZoSiBj3VHIuG3U0p2GI?=
 =?us-ascii?Q?/xLQom2BATqkE+uzah4PX30pcxcSqGypQv7eMuSmmPjUmdjNNsVxkiCPwNov?=
 =?us-ascii?Q?tkpZ62GP9WcAeptUCZ5/CeZLw8m1m2NruwdX8Hu/poWYEfRjrNeRimR42nCz?=
 =?us-ascii?Q?h2Nd94Fr470wHYVJ8GYdh7Gs8Z5G51NMkbwQL0IBQepSOxyO+w2LWCJczRkw?=
 =?us-ascii?Q?AasJDIl0h1o3HwyTe4rlg9WCN6f/BDp1+07S6D3V+juUJItPEmuReP+aVGBE?=
 =?us-ascii?Q?NaqTjqKRUrQWhwm1nI43py+fFjqO8xnQdYRk9VzW7dC+vwbIMj6cw0fG4Q83?=
 =?us-ascii?Q?1Xy1A6c0Otazpm3O18RbhbL1l0FMTk/K4bBGX7lUkVB1bGU16m46w5mHrRFt?=
 =?us-ascii?Q?gWDcMmtSM1iRCvHjPNESqFW4dScp4isgQnTSrGvq2jTgSfGun6YDFYGZaolR?=
 =?us-ascii?Q?cIBOINSbJrW7R9NUnyQTDXUEGwJRy/pX2HlrIq5JcvA5yY5ZBzZe1auZiQqH?=
 =?us-ascii?Q?JHfhjJjmAa1wIEF1FSz298PrP8H2kcH/ADJF70vFi+BCw8cukjX2BNUpzOEw?=
 =?us-ascii?Q?H2pAGrWpkSvT90swv94PmfHTVbRbjSh+/lPOCjX2Bw79wv1vlch8D5AhVmFx?=
 =?us-ascii?Q?CveRp8GOqSU5tdz1V59JcbNfuIFOB0fylT/4Hf3as3tD6vXIfy6eMIiyxJxH?=
 =?us-ascii?Q?FgHQpO4A6gu4EePbxIINaRucgS3o4Fk1FeFZLZVAxIkc2jVQZK08+EjX2oDW?=
 =?us-ascii?Q?qK6zTgTu2Auoj0yeQrO7rKhLWaX9Kz2z9r9Fz6qjXsyy2mTyR9GSVTu4YOV3?=
 =?us-ascii?Q?uSRx5ZB9obyoBGT7jd+4nyltX+z7Jf6qJHF1H3mcHvtFFkDqrEUvs42BJe53?=
 =?us-ascii?Q?4+FAhQcshoiGURiOrhBzzz7wsekdM97RX9Rh2zXr7cRh0iVrg9FFlLTJC8Zu?=
 =?us-ascii?Q?C31OLbmFsWgrS2TyIxhbSi98hYDuS218o69u9qpq/so06F5QOD+yMZilWRna?=
 =?us-ascii?Q?14wfdZFVUbDLFzUBboNuw+Nh4rHPkkih15gAkLF1eslHr1If9Kz39l+Mhc9/?=
 =?us-ascii?Q?3JxMJH1MYoPwjzqJCwzyRKkfB1BRJDl1O4M0socqDrPIyiMbw0LaxvyEccBb?=
 =?us-ascii?Q?dinWXwCafEOhqPmk8l/OGwUCeiID0n14qaYd5ZV3xqnUbAxA4pb8XuXxeiWR?=
 =?us-ascii?Q?TeuAU+1EtbRjK/1PenXu+LBLMYpxuiS9hC0qboFohfQRMD9pdV4xs54BZKtD?=
 =?us-ascii?Q?1FFwabsVT+fqBWnLOpf2DAD6mLFAqb9M0TO7lH2Dz6lFqfaoc+D+zQudk6Fl?=
 =?us-ascii?Q?EDcreNLKcuAEcXtz3Y6Ux1xAVjsLgiCW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HynET+GlWb3i30hSax8TgX5YMW897wiQyuXSs0zHyMFzg5gyNKtecfBdrFR/?=
 =?us-ascii?Q?ygtGc/GuIMg7KJwMoa3oMDqiBJ6/SmnMMHqwySulyKdO7oy8Fo2Xs+DU52dV?=
 =?us-ascii?Q?X6dawbWnI0ktc2xDtOgWnhbkAp1EH2gXs2zfPOezX2RAmBYnJaSdojMGjCR3?=
 =?us-ascii?Q?BARuwsiVQEN2L93vRi1pLxcafGYmXH1xPMWRPVqMmY3K2coSuzhcltF9QW0s?=
 =?us-ascii?Q?7970KVilktjDOeSLIgmb7yMFAUauXzCTucW0NGr3ePE6PgoGi5KKEydWLmiI?=
 =?us-ascii?Q?prgnkd41fmOsc6Yb+zBSlCwyu4m4PVXJhHMqwM0u36BIUom1mqxJUyy0anWJ?=
 =?us-ascii?Q?F99O6OCFEtbeBAJVy97BGo9TQOw5ou+zA2nYwhu+D8FRx67UhgarED+8JWIW?=
 =?us-ascii?Q?FJ6eNA16H02bnZrbufUO/R2qw+4cMR8kOa9PUq5q0h3Wf8mLhxG4x44MNZaL?=
 =?us-ascii?Q?lMXT8eLFHc0MJ4x9SUtp4qGdb9x0fZIQBwSmIrAnUelCIacfS1ppKTycWJDY?=
 =?us-ascii?Q?6OrdhV8TVS99K1RRZoB2slaeKojqs956Z2S10l/6jcqCfhfM92+EhamIwV6r?=
 =?us-ascii?Q?3r/B9xEaKh4iz5xD1Lysprb2pBW559EhGPEYyCAt8DMSgGpM/ZvZsEFttcx5?=
 =?us-ascii?Q?KHQ8uXwsgSgsgGXhympuM8cvkllmxEH1b42YkSfU654aOXpTcLp3+OfEGOWA?=
 =?us-ascii?Q?XfP7JCHrwAmpEt1T1Z1R6ub9OFCMFoExXHIuveLeK0OjnpNs6oB85eOqaUqr?=
 =?us-ascii?Q?GFQMg3I77wkyqKELbu54ydeK2Dt0gWt+ltxtDRl55USVzBlGX8DddFNWpuK7?=
 =?us-ascii?Q?WZ/7XeDsbI3G03Awu9Rvq8kt8OgdX2DWEKJpBhXCo8d0Z24rPAprOAZi3I8R?=
 =?us-ascii?Q?/eGT/aTCvAH7kizRRuFcjig0iyBqofWvKKE0dZksSFDsDi0jk00d5KmzSvRd?=
 =?us-ascii?Q?by+gcsZAaeZN3Kf+YZ5O7/ZVlnTfMzL0JRYfYyka1TBBwlxZk4A+sSxriGgu?=
 =?us-ascii?Q?uCKxqI1MVKouV9n1DmI2iHWYzoFYRNkca64LK2vmLZ2qI0BY5cKMluxo46lq?=
 =?us-ascii?Q?74Mv9TKRThriH4ZVxdvkum0lOyjucb/FoF3wXWolPIxHSvoqUOzXCbXSOw7i?=
 =?us-ascii?Q?ukvIcy8fFt697kFH5kch5cIU8glHMwvLP8L/CVhH7aw6rrd7bDMFz1aPU8T5?=
 =?us-ascii?Q?g6Hz/HZLwldaHtX2+c8tg6MdqdBURvGYrLMVUFGfp12nwyRFWY+YdTHWdr+/?=
 =?us-ascii?Q?Bh9bilxUpAi4gGcpY4rGAyRTtmIlJNQ3+ICWsgNMMTHA8gw8hCiUqKcwtm+c?=
 =?us-ascii?Q?RXWCy4/jg9NvQKGaHV3/9bFjQOeTigUwiCFJ0kAKeU1DlRsFISZ4ZdKOQDJW?=
 =?us-ascii?Q?Gd2HSQXNJTp4qcFwlEL4Cx+0uL4fDI47oKHBtUYtiux4WFFIiob/Bx9SPBpy?=
 =?us-ascii?Q?2vNFUZh/GHK/2o/Ntm6fuGGhRU5heT426YagZPFqWFKTncxpLDp/ghisd9CR?=
 =?us-ascii?Q?jP1K/XA3MFerxux/jeZeKYoeIqQZLf3lkl6wfUpBUor+Nu88+vH3iKc65jey?=
 =?us-ascii?Q?+BNtFu6/ttmj5mat4JzdrSfmJHJxm5A0XlS4Tc1sTUqWUPok5SH5X6HBjyrQ?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af6a5dba-ff61-4558-4ca6-08de17029fd5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:48:37.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qum3EHNBT4SyBzgGCs0oRGMI2GjU5/+Jk5oSVaYW+0ME9tj/ZazjWo2ksS3QK0GH0qMfAr0bmTvLEFBdBrJkoi0lZTyXyk8OYC2CvYJJjvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8939
X-OriginatorOrg: intel.com

On Sat, Oct 25, 2025 at 02:53:09PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The commit f09ced4053bc ("xsk: Fix race in SKB mode transmit with
> shared cq") uses a heavy lock (spin_lock_irqsave) for the shared
> pool scenario which is that multiple sockets share the same pool.
> 
> It does harm to the case where the pool is only owned by one xsk.
> The patch distinguishes those two cases through checking if the xsk
> list only has one xsk. If so, that means the pool is exclusive and
> we don't need to hold the lock and disable IRQ at all. The benefit
> of this is to avoid those two operations being executed extremely
> frequently.

Even with a single CQ producer we need to have related code within
critical section. One core can be in process context via sendmsg() and
for some reason xmit failed and driver consumed skb (destructor called).

Other core can be at same time calling the destructor on different skb
that has been successfully xmitted, doing the Tx completion via driver's
NAPI. This means that without locking the SPSC concept would be violated.

So I'm afraid I have to nack this.

> 
> With this patch, the performance number[1] could go from 1,872,565 pps
> to 2,147,803 pps. It's a noticeable rise of around 14.6%.
> 
> [1]: taskset -c 1 ./xdpsock -i enp2s0f1 -q 0 -t -S -s 64
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..76f797fcc49c 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -548,12 +548,15 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
>  
>  static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>  {
> +	bool lock = !list_is_singular(&pool->xsk_tx_list);
>  	unsigned long flags;
>  	int ret;
>  
> -	spin_lock_irqsave(&pool->cq_lock, flags);
> +	if (lock)
> +		spin_lock_irqsave(&pool->cq_lock, flags);
>  	ret = xskq_prod_reserve(pool->cq);
> -	spin_unlock_irqrestore(&pool->cq_lock, flags);
> +	if (lock)
> +		spin_unlock_irqrestore(&pool->cq_lock, flags);
>  
>  	return ret;
>  }
> @@ -588,11 +591,14 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  
>  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>  {
> +	bool lock = !list_is_singular(&pool->xsk_tx_list);
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&pool->cq_lock, flags);
> +	if (lock)
> +		spin_lock_irqsave(&pool->cq_lock, flags);
>  	xskq_prod_cancel_n(pool->cq, n);
> -	spin_unlock_irqrestore(&pool->cq_lock, flags);
> +	if (lock)
> +		spin_unlock_irqrestore(&pool->cq_lock, flags);
>  }
>  
>  static void xsk_inc_num_desc(struct sk_buff *skb)
> -- 
> 2.41.3
> 

