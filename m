Return-Path: <bpf+bounces-62275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37ADAF7413
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5A6565ACB
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F22E5417;
	Thu,  3 Jul 2025 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qf9v9lTb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ACB265CDF;
	Thu,  3 Jul 2025 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545589; cv=fail; b=fFdR1EWdd8XCjxUl6tcJ61qI4JdlCv5WbUeYTvBCkeK1UkNlq9DGNgxJx9Ms6iK+m2M7kKi0702QKOj52O3FlhyDprDv4AB3WKOUhzT3xto9teBOv1mNGZAdIzqDqblKHxvt60vAxKcNp8iUvc8P+xPN67t3XC9PuRkliiXFZV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545589; c=relaxed/simple;
	bh=8SEoKFAdYRU0e1kXn+DSOA5JAkzhPkkYNlB9PgEziAs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F9WKkpOdSSPr3BHnJgsTlvLcO/KR6iHdW4M7zGiKEUx4YqbE8Gs++gzgVQGEEAFSH6vJJ3Z/GI5pnYLx8GkdeGHAeIJJq0xARKl86Pm/Vrydwe6E4JpjZz+TlGVBvpQyKDE+EzAgP2OWd99hb7upMJuDYgyqjb6VZ/km9S7Hsco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qf9v9lTb; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751545587; x=1783081587;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8SEoKFAdYRU0e1kXn+DSOA5JAkzhPkkYNlB9PgEziAs=;
  b=Qf9v9lTbgEY0d3cewN4Lg4Do5F3MPy9EKoSJ5frftU+oyhOoUvwcTHPj
   y6qZ3QxULFL9QM8KJgnGcf+c5hJramQE3Rk0zA+pQmeyPlxImzqSR9rTK
   xu/2i8fEYJG9vctgCaFFWCIUNYLTvBEavGXG+38Th9MS/K69MlX0GrDF7
   76W4XQJPIZ2zEtdHoIdK5K2hdc8QRy3aC7BELUmmRrSzS5hUs6hpHCNCw
   dYy/KIsNAoap9ZrXO7UNbas26GAytYU+CcIrXWce4mw0Y2RgVvldJ+Wwe
   6X+BNK4IzU5CZjurxoNij0UgZM1uSkfHbQt2VoS34EzQTAqWJefDAzO6R
   g==;
X-CSE-ConnectionGUID: YfHTVaZGTjyMMkri8Y4KNA==
X-CSE-MsgGUID: Gn8urY0fT8qqzEPV/ZXqug==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="79304628"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="79304628"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 05:26:27 -0700
X-CSE-ConnectionGUID: 7TPV/QXsTUq1NrRFWDzGdw==
X-CSE-MsgGUID: L3Rm95HvRg2im7RW4LhLfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154000926"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 05:26:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 05:26:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 05:26:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 05:26:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6zLviLEly3gZUNDQe6O+eFpHiFyNJf8bKosHVBUf2cLuvoIIdNJJyCrvivISoAfVTIzZakwVWpB9CmPTWIHj28+IuxfKewtsCfVS7ikafE1N57XH4tfZRixwLH4kR3DzYSWg0PNiiDRoz6Oj4Ifnmb2ha/HJ8aOJgGgSz9txMSVntibVpCSbo7FKcyDA/SeijRJhA7cJZZE6aUmVImacth3pBUV7MkREQk1mBxEMmIn3S/uASt7USXW2YdeVTA4Qul7rgdeciKPYMmNNmQAjrAXPpNiR4djDhXOWx+SeMekE4rJOpsY66gErUWVuFAMypeJo2UmfzULtFNJtIYRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6sBoIHrymef4ffOoNLoQKGNKUpLE1fbI3yt76OMu7Q=;
 b=AcPaLvLGr52T/YKMq3X5PD/SqhZKIpoD1p6suyJ8coPWk0K0SLz4V4iCGjWBaYMQJRKINtX2UXpPWK1c97uOsFAw69R18nyqaJoAW5mjsRo9TgjAmCjz1ybaW2ghkUdPnbNkj5fvAeQY/ZU305/9Mr4zYBWJIjY6vllOudw4LOkpzMVFjgpufVGXKQllgVy2RTcW/BXkZmHUSvkNZe+e/a1a6jH6Y/BT7wkM/qQi2srGEjKLEQmWPQqLmwPtaUwYrf2f/Y6CZiHDX/5s4n07R6sr5Sg7JYobPKBBfHEoTw3gXr3S9/RBt+mtvsZgp5ZrquUhDFIGlwiwCV5kX5H5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH8PR11MB7120.namprd11.prod.outlook.com (2603:10b6:510:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Thu, 3 Jul
 2025 12:26:08 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 12:26:02 +0000
Date: Thu, 3 Jul 2025 14:25:33 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Message-ID: <aGZ2vcgz/sqFWWHN@boxer>
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250627110121.73228-1-kerneljasonxing@gmail.com>
X-ClientProxiedBy: DUZPR01CA0232.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH8PR11MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: bd09682e-0a85-43a9-b15d-08ddba2cbf41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EwKdQbzUJHp7Nq37cfQYknh3+6k6ncWv5vavlapDgiae7QbmchS8uk3rKREJ?=
 =?us-ascii?Q?zG3ncrr6f61Fof6geQljtmTbYlTa1XHi1+lYEXnfHPyYq7+cxA5zrGYJmUrQ?=
 =?us-ascii?Q?uc68QXv0j338LVoRQk9Lbh+582/F3R8Ng0k3CkMX24Iu40ynt7QiJI/fWkNZ?=
 =?us-ascii?Q?HUqbibZv7jvkNosWv3fqchGD+YaeATUhkfVk/o2uniifht8rVIfXfiX0swJR?=
 =?us-ascii?Q?RhF+vlHO2o5LQfQ2gp0N6qEmS/7SrgsT2DH94xQHyYXftrwpC3eRInOCRcU2?=
 =?us-ascii?Q?EQBXRMZRd4pjEZWHxeQ9IkwWME8ySQlDgbxyF9SODoS1cC0FmKwiXCG2uPxi?=
 =?us-ascii?Q?19Q/DTR6fAUw0MbkP6evnRYRrt2hg58j/yuHAO2WdLYixgrYvMrVf0VGxqxZ?=
 =?us-ascii?Q?QHyUQ+Db32x70w2yzQ1xui/fmQh4OrmUXIibL85cKdviThHfZEfnMFIxRxER?=
 =?us-ascii?Q?y7azj5KDjt80CkGZutT7NhEsEgUDAGnJ4ae1cxyzEtWs40DqJ4qK2njdfe+A?=
 =?us-ascii?Q?vU5/mgCOhrFpFwYu8LYOubuKNtsMmQgSiXCViwUbOsjAyu7ZN02zd5lGhj7+?=
 =?us-ascii?Q?dW13OIf3dmPKNZChF46EWgo/5Ourt1qiN858gi05O/4aUDDVUDR2pG46CzUu?=
 =?us-ascii?Q?UjnpUhtLrJzFNoAih7hEYwDCUbIpfhJbE8avub6+KQ+u6Ucze2LP6N8ML4o2?=
 =?us-ascii?Q?wKcQeHissX1HZkbH4Ah3+kT3bSVDDZc5qmN9cZBgYMZw2TsQdfwGs7Uhw6dU?=
 =?us-ascii?Q?WxrcAQqeJ62o9E9vjgSMaK/jGaXNrXpIF4vBQbf2qXojsXKP0DLSUomy6OdZ?=
 =?us-ascii?Q?lHsOM7LL5Oiip4WWvT01XBCmscCuX+3j2dsoeSBSTiO/Y/9vYxLBmtm1SDZZ?=
 =?us-ascii?Q?EK7rfjOTfprvI0evKCRZPtondNfS/jBc//TzhoPbSPwGjssD4YOewbTu9yX3?=
 =?us-ascii?Q?tLuzIo88av6QoOyPEc9p3DT3I4jS5EKkBg6raRj4EjZWmUVdW7AlHNgm5QiU?=
 =?us-ascii?Q?mb9Qv6vBMb9aoZYkJYve3AWT51TTcU5B5vfgpWhoPvgpdVPyUrd+g5259muj?=
 =?us-ascii?Q?HPby26xguMMr565RAlZ5NlJ5rXmw8j+ZNcm8BVYVA6eI8MlTEjEJLhjOC58g?=
 =?us-ascii?Q?Br4yfXe+1ryCck/oCeZpjfNYxGILqjHc8oF7Ej2qZtNczwjzneykRccKICZk?=
 =?us-ascii?Q?47sgUj3eB7E/+dXF956iRRiKaNcvIh0PhSiDhqPzHRQDqZP+9P+xie3eaQW6?=
 =?us-ascii?Q?SNwWX9EgOkMalUcxVTR/MX85pbtEvq93rQrXzip8PzbWVBPv57Gwov77CsBN?=
 =?us-ascii?Q?bA0Bw1x7a/HCZvEaZy8nS25toIZhR0QQx7vlk5wNAh8EFZ6q4MsRIn9ulf6/?=
 =?us-ascii?Q?W5vwwKSbpC6uhEb6pfkq4wyiVRnJTexFvAgWLo/rYO3YuaOZBesV8gG8oLdr?=
 =?us-ascii?Q?3CFqDef1PSA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pDEmWWMqFcE5MyUZ/sHKd7FAYcQNTKk+EqtQaXpjZywoe2/shuv1TB4e32d+?=
 =?us-ascii?Q?xrs9heF8XAa1TVHl1IrghpSqUAF9K99QUCpgdPMXhdyXSliPT5cuPf8lsVUC?=
 =?us-ascii?Q?Ed9P6sldNkg+sVxBS+XtOq8PLyHY3zxgpualStvf3C2hJJU3f+311jRF4fsW?=
 =?us-ascii?Q?FlV67sSen4FGhBsX1PznC9AQSynzoCGaOcxHaURfsrzYFFDHdaOazaU3GzQd?=
 =?us-ascii?Q?ysHdN/uVeoCwGGAQaJ445g4+P84ho8lyrUPwU/oShy4ataLxJ2uufVXt6yI+?=
 =?us-ascii?Q?iynDeBYw1iT49QcLUPvgrFXt7EsYEB4tnTYC8R9Vq5qBDJ9D07fLt70z4EYR?=
 =?us-ascii?Q?qTgFNPAIGhhVQHcN5iUSkw9NkGURVauwG6O8gyeY4MMfRLvLMkitPmAaVNK9?=
 =?us-ascii?Q?U4rx5mcVVceXjS6a6/aHmcul63+TGFaSYedcPNukcFd7g5FnIy0XVQAXANHR?=
 =?us-ascii?Q?1DYhsXasWWm1afnvLMiABDH1CcYve8SICc0WwvioWgHmnF2Y5LJJJPCg7AHg?=
 =?us-ascii?Q?y57fkVJdAHtV6A4SlaT1nx/0Vc9Zar6xQB2VhXmGj/zL2MNSIZJaJxkxkQfs?=
 =?us-ascii?Q?/9qzHeLEZLkas/RQWABbSPjJY+eOa8TnkgWF8M8l4F/L1vdrW7l5Fr+LDIjW?=
 =?us-ascii?Q?SjP5QN76qXODakKHQ+bS5vQZGA7mVuazCyAlTOnseKigliX41+VQSIRjV+o9?=
 =?us-ascii?Q?zjqqUXgoD6XBdDVr9prtluQOPQAGNdlRGIwCacrFgJaFRhtwcXdIDtIxA+Gy?=
 =?us-ascii?Q?lwm2NsyYikNZfSb2hoM0ANv8BuBjvrDNVV+AwsEzxeZqhI7Ev55eoxQN3E7n?=
 =?us-ascii?Q?AxyxAznvm8CPoOTcaCow5aQQtf6q7cQWvz2Ahmp7CMI0DnU3taLQKU1d2lgj?=
 =?us-ascii?Q?8tBvb0+vjcLl1WMK6ZZ4wkNmg3aAYbD6ojWgAf4YhJ6Sn58e4KB6r/egc3jv?=
 =?us-ascii?Q?weW0VlF8shmY5VrqMpEraDNbjxGe67HYjYuNb0tfNNuAQhVtYwSXyJOj5fOs?=
 =?us-ascii?Q?9repHd4CzsWoIoMQDyFVQHIdG42lriOSVHtA5AR2tL/GPppw8Xp7YNz1yg8D?=
 =?us-ascii?Q?cUgGoqjqjSnL2tpwZIi3/Wg+nfEPMu40akGtIKkNgX0/WHKqpUhTyTtddkpS?=
 =?us-ascii?Q?OZSryjXp46UJLRXASbL9a/Q6v8u/HA8Vh7CQIQp9qcFEDTo8Pqw13KA/wZLW?=
 =?us-ascii?Q?WiDGycEWqz0JB1kk04yOZRQVHFkdHWHmqeTR95VJSUIZmNkYR9N3O3MFzYJa?=
 =?us-ascii?Q?9xTsRfVDdtMUF9Bq9u6z8ThPweAiVc7J6aiZAyR2XsrOa066h1UmHwpOsryw?=
 =?us-ascii?Q?UOnqDHSX6zPpcWyVRjpVmEVEjQ6B03ETcn87hAc1k9nVCpUPsINsUl7lG3yX?=
 =?us-ascii?Q?E1tl9qZJtSjro85dPbTBQHrsfbytSX5/LCNjCqlWRCnEckYIG31TW6P56RhK?=
 =?us-ascii?Q?XW8XzTrgHQc/fXkmRSvOjlS8Y7Kqijo52DasCzQE+0XzULCndqiEeMIJnVSV?=
 =?us-ascii?Q?QrE9qfh2OBWZbSTzJ3yqNhr0kc6ufH1L1/lFv7EsZBW16pbGfPKRQraPAG8z?=
 =?us-ascii?Q?s51eZoL8v3KAF8wetGc0R6uOgk2NYlnO8rwIOV7t2RW5b0WR5sYE0nvVX8g/?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd09682e-0a85-43a9-b15d-08ddba2cbf41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:26:02.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTkYYbS0R+25M1o/aCb+jAZGQPBnXnbuETkBGNx+3jUXxuDV2zwwiMZyaxIP76mAzgLWqfhl9xdjvkrX2NFzxP/y3ZF/OA6/rmSe6T/3WIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7120
X-OriginatorOrg: intel.com

On Fri, Jun 27, 2025 at 07:01:21PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch provides a setsockopt method to let applications leverage to
> adjust how many descs to be handled at most in one send syscall. It
> mitigates the situation where the default value (32) that is too small
> leads to higher frequency of triggering send syscall.
> 
> Considering the prosperity/complexity the applications have, there is no
> absolutely ideal suggestion fitting all cases. So keep 32 as its default
> value like before.
> 
> The patch does the following things:
> - Add XDP_MAX_TX_BUDGET socket option.
> - Convert TX_BATCH_SIZE to tx_budget_spent.
> - Set tx_budget_spent to 32 by default in the initialization phase as a
>   per-socket granular control. 32 is also the min value for
>   tx_budget_spent.
> - Set the range of tx_budget_spent as [32, xs->tx->nentries].
> 
> The idea behind this comes out of real workloads in production. We use a
> user-level stack with xsk support to accelerate sending packets and
> minimize triggering syscalls. When the packets are aggregated, it's not
> hard to hit the upper bound (namely, 32). The moment user-space stack
> fetches the -EAGAIN error number passed from sendto(), it will loop to try
> again until all the expected descs from tx ring are sent out to the driver.
> Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency of
> sendto() and higher throughput/PPS.
> 
> Here is what I did in production, along with some numbers as follows:
> For one application I saw lately, I suggested using 128 as max_tx_budget
> because I saw two limitations without changing any default configuration:
> 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> this was I counted how many descs are transmitted to the driver at one
> time of sendto() based on [1] patch and then I calculated the
> possibility of hitting the upper bound. Finally I chose 128 as a
> suitable value because 1) it covers most of the cases, 2) a higher
> number would not bring evident results. After twisting the parameters,
> a stable improvement of around 4% for both PPS and throughput and less
> resources consumption were found to be observed by strace -c -p xxx:
> 1) %time was decreased by 7.8%
> 2) error counter was decreased from 18367 to 572
> 
> [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v6
> Link: https://lore.kernel.org/all/20250625123527.98209-1-kerneljasonxing@gmail.com/
> 1. use [32, xs->tx->nentries] range
> 2. Since setsockopt may generate a different value, add getsockopt to help
>    application know what value takes effect finally.
> 
> v5
> Link: https://lore.kernel.org/all/20250623021345.69211-1-kerneljasonxing@gmail.com/
> 1. remove changes around zc mode
> 
> v4
> Link: https://lore.kernel.org/all/20250619090440.65509-1-kerneljasonxing@gmail.com/
> 1. remove getsockopt as it seems no real use case.
> 2. adjust the position of max_tx_budget to make sure it stays with other
> read-most fields in one cacheline.
> 3. set one as the lower bound of max_tx_budget
> 4. add more descriptions/performance data in Doucmentation and commit message.
> 
> V3
> Link: https://lore.kernel.org/all/20250618065553.96822-1-kerneljasonxing@gmail.com/
> 1. use a per-socket control (suggested by Stanislav)
> 2. unify both definitions into one
> 3. support setsockopt and getsockopt
> 4. add more description in commit message
> 
> V2
> Link: https://lore.kernel.org/all/20250617002236.30557-1-kerneljasonxing@gmail.com/
> 1. use a per-netns sysctl knob
> 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> ---
>  Documentation/networking/af_xdp.rst |  9 +++++++
>  include/net/xdp_sock.h              |  1 +
>  include/uapi/linux/if_xdp.h         |  1 +
>  net/xdp/xsk.c                       | 39 ++++++++++++++++++++++++++---
>  tools/include/uapi/linux/if_xdp.h   |  1 +
>  5 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index dceeb0d763aa..253afee00162 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -442,6 +442,15 @@ is created by a privileged process and passed to a non-privileged one.
>  Once the option is set, kernel will refuse attempts to bind that socket
>  to a different interface.  Updating the value requires CAP_NET_RAW.
>  
> +XDP_MAX_TX_BUDGET setsockopt
> +----------------------------
> +
> +This setsockopt sets the maximum number of descriptors that can be handled
> +and passed to the driver at one send syscall. It is applied in the non-zero

just 'copy mode' would be enough IMHO.

> +copy mode to allow application to tune the per-socket maximum iteration for
> +better throughput and less frequency of send syscall.
> +Allowed range is [32, xs->tx->nentries].
> +
>  XDP_STATISTICS getsockopt
>  -------------------------
>  
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index e8bd6ddb7b12..ce587a225661 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -84,6 +84,7 @@ struct xdp_sock {
>  	struct list_head map_list;
>  	/* Protects map_list */
>  	spinlock_t map_list_lock;
> +	u32 max_tx_budget;
>  	/* Protects multiple processes in the control path */
>  	struct mutex mutex;
>  	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index 44f2bb93e7e6..07c6d21c2f1c 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
>  #define XDP_UMEM_COMPLETION_RING	6
>  #define XDP_STATISTICS			7
>  #define XDP_OPTIONS			8
> +#define XDP_MAX_TX_BUDGET		9
>  
>  struct xdp_umem_reg {
>  	__u64 addr; /* Start of packet data area */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 72c000c0ae5f..41efe7b27b0e 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -33,8 +33,8 @@
>  #include "xdp_umem.h"
>  #include "xsk.h"
>  
> -#define TX_BATCH_SIZE 32
> -#define MAX_PER_SOCKET_BUDGET (TX_BATCH_SIZE)
> +#define TX_BUDGET_SIZE 32
> +#define MAX_PER_SOCKET_BUDGET 32

that could have stayed as it was before?

>  
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
> @@ -779,7 +779,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  static int __xsk_generic_xmit(struct sock *sk)
>  {
>  	struct xdp_sock *xs = xdp_sk(sk);
> -	u32 max_batch = TX_BATCH_SIZE;
> +	u32 max_budget = READ_ONCE(xs->max_tx_budget);

you're breaking RCT here...maybe you could READ_ONCE() the budget right
before the while() loop and keep the declaration only at the top of func?

also nothing wrong with keeping @max_batch as a name for this budget.

>  	bool sent_frame = false;
>  	struct xdp_desc desc;
>  	struct sk_buff *skb;
> @@ -797,7 +797,7 @@ static int __xsk_generic_xmit(struct sock *sk)
>  		goto out;
>  
>  	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
> -		if (max_batch-- == 0) {
> +		if (max_budget-- == 0) {
>  			err = -EAGAIN;
>  			goto out;
>  		}
> @@ -1437,6 +1437,21 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
>  		mutex_unlock(&xs->mutex);
>  		return err;
>  	}
> +	case XDP_MAX_TX_BUDGET:
> +	{
> +		unsigned int budget;
> +
> +		if (optlen != sizeof(budget))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&budget, optval, sizeof(budget)))
> +			return -EFAULT;
> +		if (!xs->tx || xs->tx->nentries < TX_BUDGET_SIZE)
> +			return -EACCES;
> +
> +		WRITE_ONCE(xs->max_tx_budget,
> +			   clamp(budget, TX_BUDGET_SIZE, xs->tx->nentries));

I think it would be better to throw errno when budget set by user is
bigger than nentries. you do it for min case, let's do it for max case as
well and skip the clamp() altogether?

this is rather speculative that someone would ever set such a big budget
but silently setting a lower value than provided might be confusing to me.
i'd rather get an error thrown at my face and find out the valid range.

> +		return 0;
> +	}
>  	default:
>  		break;
>  	}
> @@ -1588,6 +1603,21 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
>  
>  		return 0;
>  	}
> +	case XDP_MAX_TX_BUDGET:
> +	{
> +		unsigned int budget;
> +
> +		if (len < sizeof(budget))
> +			return -EINVAL;
> +
> +		budget = READ_ONCE(xs->max_tx_budget);
> +		if (copy_to_user(optval, &budget, sizeof(budget)))
> +			return -EFAULT;
> +		if (put_user(sizeof(budget), optlen))
> +			return -EFAULT;
> +
> +		return 0;
> +	}
>  	default:
>  		break;
>  	}
> @@ -1734,6 +1764,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
>  
>  	xs = xdp_sk(sk);
>  	xs->state = XSK_READY;
> +	xs->max_tx_budget = TX_BUDGET_SIZE;
>  	mutex_init(&xs->mutex);
>  
>  	INIT_LIST_HEAD(&xs->map_list);
> diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
> index 44f2bb93e7e6..07c6d21c2f1c 100644
> --- a/tools/include/uapi/linux/if_xdp.h
> +++ b/tools/include/uapi/linux/if_xdp.h
> @@ -79,6 +79,7 @@ struct xdp_mmap_offsets {
>  #define XDP_UMEM_COMPLETION_RING	6
>  #define XDP_STATISTICS			7
>  #define XDP_OPTIONS			8
> +#define XDP_MAX_TX_BUDGET		9

could we have 'SKB' in name?

>  
>  struct xdp_umem_reg {
>  	__u64 addr; /* Start of packet data area */
> -- 
> 2.41.3
> 

