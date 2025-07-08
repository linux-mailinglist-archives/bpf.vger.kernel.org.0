Return-Path: <bpf+bounces-62687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A77AFCD28
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 16:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027FD3ADA43
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236B2DFA2D;
	Tue,  8 Jul 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gF7pHFIo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3832DF3DA;
	Tue,  8 Jul 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984101; cv=fail; b=Xag66HidcQYmLpP3b9ne9oU+7VZVkrV6zv9Hmx2IfVQs2E05dy1qLApvaKsMExd29xkEuMyOfZNlI+jXMB6z8GOTyGPbqHQFhhuDaxzJBA+Q7w0a+X3Xp9S79+5yDkoAOd40taGH9whSPP46b6GL/XQl7sNDPzeyg+O/iom6blY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984101; c=relaxed/simple;
	bh=A3J/uHVWuquKN4IGypDwcEOnGoFmY/n85SeOZZ+Qcys=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C9T2YPBJCWOEqADIgNz9yzD1gjNZyyLZr4hu9Lca516I7UnL6dqXwAZseSoPhdfggSLD4bb20CvfsJg81HCQS1cjDpy/oL/HxlhSL7KhONGBWVEdkJFBNhV/t6EMReU23Ak/um8WJwib1W4Ah/s9cas/ptA09hcnQdkunsXH0HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gF7pHFIo; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751984099; x=1783520099;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A3J/uHVWuquKN4IGypDwcEOnGoFmY/n85SeOZZ+Qcys=;
  b=gF7pHFIoelMLhrqvw2RMzEmLsgUNA89MhGr3siHna2iOQmXRqjluGrEG
   Ih3pQuTEHnwDvS8YYeIybuDgli4zcxJeV3JUKuU+sjnbHrUEuhhUPEhgX
   y5/yaMpJAM4jrjpsXgfMLTOM+BtGdX8sQVtyiRH3cHow2u9JoVrUVhdsG
   XCprtvCGf5+ycpR6EJVDIjocETYhuof/SIjd1axlMrOeQy8noYdLap33p
   OgN08ppwqRehcczT6Kak7bT8atXlxQ6gYbqrAq+vAhk4P/uLaD+Ep64J6
   mBZTL1E38XnrYfHUjnVAN1dDA8+3x7liwCv49eYuOGB56hZrynn/MLdNU
   A==;
X-CSE-ConnectionGUID: HriDA//mSe+gTrxY2dS/Yg==
X-CSE-MsgGUID: o689hBl8QkW9xGIy+m3vzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64920498"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="64920498"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:14:56 -0700
X-CSE-ConnectionGUID: 62LpsG8tQeSrifizHqepGA==
X-CSE-MsgGUID: K6KA2sxPTsifihUWZdA2rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="192699884"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 07:14:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:14:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 07:14:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.62)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 07:14:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bp5/Db7GEZyGExSGRZIJdL2J2YPDaG0HyxSPPhNpmiLZHzB8rBpfEpvh6VrInL4dnC6k2XltkNKA2OzROMxdVWOUYygNBT1bVJ0e4diu6aJCCTMMA1A1XgXCgrAEWKVtd6u0/pdFw6Cp2v4If1oUv6aSd3zENdERM4sQein3C861LqOrPzdQ6WzSRJ510S41hM2ut51urQDjsfpdkQv936YGHz/5F+vCCDhRKnwcQd0LpU7qAV+citxSdFFuSi4s+4+8dDhvXC/Be0jfaM4FqSip0jPA531bCNqqRd6WFgrOtitqaZSRuX2agNQyXvq55GOwX9U8ZkmwW0Daq1eYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMkJJspuln5Z0CLWnECIw8OiId5DUg5DDAL9aakBE3M=;
 b=sZGQRzyyKrKZ6lJrIUiflbOWc99MHBHp8hZSSmethQLWPS+yZYuBf3Py2AeXXOLJXVv9STSA3qKpcyYig45JeqjctBVRC3Uszr1/BsAGp4FmjrJkZyqdOf5w7G+jqjmSc8+ZGolspKqc60H6IpXSfgD17dcE7aQ1nT3w5H01vhaXV6o36r/UTgNa4momhkBwFbISHi1QfRWhKdg/9/n38uRPBLNxxU3pFk3OmYBqJtctW77yOiyBXxMpKgOU1UflmKQfRp1riIKgqsm4bb1J9MQqCVZo3G+mT3yWrGMrNZX1+OyuEsC+RwnlZfANu+3MjCPVnSYdrKw94Mkv03G9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MW4PR11MB6617.namprd11.prod.outlook.com (2603:10b6:303:20d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Tue, 8 Jul 2025 14:14:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%2]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 14:14:51 +0000
Date: Tue, 8 Jul 2025 16:14:39 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v2 bpf] xsk: fix immature cq descriptor production
Message-ID: <aG0nz2W/rBIbB7Bl@boxer>
References: <20250705135512.1963216-1-maciej.fijalkowski@intel.com>
 <d0e7fe46-1b9d-4228-bb0f-358e8360ee7b@intel.com>
 <aGvibV5TkUBEmdWV@mini-arch>
 <a113fe79-fa76-4952-81e4-f011147de8a3@intel.com>
 <aGwUsDK0u3vegaYq@mini-arch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aGwUsDK0u3vegaYq@mini-arch>
X-ClientProxiedBy: DUZPR01CA0296.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::25) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MW4PR11MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: fada24cf-fd25-4fc4-3484-08ddbe29cdc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MffrP+QSMJ0JL0xlZm258ubP1wcz3qvfgi/sRWz2blMGRFhky/trapA4R09w?=
 =?us-ascii?Q?c47RIMeCG4MInfcRlgHZ/vYfMGAPjwZyzyQgwCDEOt2ASf0OIiwZx3uci447?=
 =?us-ascii?Q?WkJfWeXsKLmiAZ8XhOqGJqIAQWrWuxM0q9LkgNxw5J1Q8Ix6YKF6IQ6kF6au?=
 =?us-ascii?Q?jjdCK15meobww5zwp1Z6svfzD/7e9j/JYaugbNaujtXbwn5WxWRB3ib2w6nU?=
 =?us-ascii?Q?SoJk2n4GxpmOqTAw2kjuRbXaugGOVZN2oBy0sYjbhVoA3fsomYHtUEpbIzwe?=
 =?us-ascii?Q?BGk1TyfH8yDjOwGOatw0RDPtFU8HbVL1+sytMcQjbPzC46kh+9Q4CZQ4Eamv?=
 =?us-ascii?Q?X1PVOo6IhbQmcEsmW8BkHzsIuYxu6BvM6m3MzJKfCmXcQ2mbTjh30InFIQiZ?=
 =?us-ascii?Q?DeBBjcGAVxQyX226nIGQQyDOMM8WCHQKvqLQNga8MmkXVcDNjFmkNylxw2Nt?=
 =?us-ascii?Q?QxjF+XHIjRNtEAoy6pjLfWbByujvh9873TfXTcZUaGjP0U87PWbdjceRU5wN?=
 =?us-ascii?Q?44YandTOoLzE+bHrARRGPpCnfvxBX3LC+XqK+gkPfEqe1XRQ2Yy2JsNGP0i2?=
 =?us-ascii?Q?HNe7qtRMLLDtUvN7WU0+EcSuYxAgkgqJaQ8U8m//qNT1pcDH7H8BMcdFYXRf?=
 =?us-ascii?Q?Xcd+10T0TkN9N+5Yu4eAYVA7LMgNrUcPKG6Fxt1srLMr6R6KDcSPd4owYAgl?=
 =?us-ascii?Q?LF7sX2ZAH8EzeuKG/YJX7qQ6NhHU1CfDGCi1Tqo69XWmsdBnjI35VKTcUv8O?=
 =?us-ascii?Q?0847h83WThMENt7P3kX6j5OWwkx8+t65JycBWP+Im7CNP7F6wckzlLgrbf7z?=
 =?us-ascii?Q?igau4VLEApCMWZn/R47q+D5omyFVILFWFYg1iyY8NcpNRyccTqhem1BidVs7?=
 =?us-ascii?Q?8erQbPc5IymNvZdrOx+6zuxcF9IXTJsbaZ2+ApZM/Ga8Ea8KAwMCBae3WeLo?=
 =?us-ascii?Q?1fbGnLYKFX/G/lthnnmQBHbJFe6BXTAe+VkGtwkYbvs8n6hznytD62qcj4d3?=
 =?us-ascii?Q?D75FIOBQ8jR9egR4gaD4L4TvOBqL43zelTMM1bybUOjAqEVSDJYL6hE1OP20?=
 =?us-ascii?Q?rc0AorfTFImpkVaWhmxfbAG0Wd+tNtsE43INHkzCwxqaM08MqAok+okmvZpB?=
 =?us-ascii?Q?2+thASkZokt4LFaPoBCs6Om0gRqKVAnLVtCkWLzr+sSSnDKXDkdCJ7g9jRRC?=
 =?us-ascii?Q?Zls9YXVrmZN4IdZzXahNOI2OdYKKompljAegOKX17IoOoVS86UeJOd4TTlBj?=
 =?us-ascii?Q?p1Iam8a1DWewGkeJ5sfJUA/uoREtGIx2yughAytXVeEags+ciAP2UfGa048g?=
 =?us-ascii?Q?SD7yQxvbnoGZNktVBQpCggw+3MhCQpkjT+d1+2ftXDEe0O7niTx3i24uWeHV?=
 =?us-ascii?Q?pacqQfprbuQhQFeJX3ACrTqJJHNDC4bq5CcX1z4RS+DAiEAMKJfBFB3rl+Hl?=
 =?us-ascii?Q?iEAe+QxVae4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z+qnOJdtfgD4hxfXWk0ssVhNhp2E8MwoTutoUPkUYISei4C9l6TpAiujgv0J?=
 =?us-ascii?Q?ftfWmooOH4xD4BCCYxMQkc9EIy7UugYQ8o7n06Sq9TMtC+FNClyzMBh8sLHG?=
 =?us-ascii?Q?QeJFEw/pyEKtBCfGgBeVBCqAt5NVFCfCP+dytMxCfv+4epRAz1wY6jN/GwIA?=
 =?us-ascii?Q?qq8xA1bf/kGrG/eCFobLvakzT+Fe/wuwg3NFZV3KvNVaMknxfwpANXJGZyWZ?=
 =?us-ascii?Q?HCCblCGdwPMlBZoy0K1rUARyB43zkpbPqeBbg89YrRRiFhxqk5i8IeFYuh9a?=
 =?us-ascii?Q?VHP0NyCcW22aO7rHQbUN5jF7DLIH+HvgBgiOfrCYYWwCoNop9egY9cKc4smq?=
 =?us-ascii?Q?B7ZtUPs8pBuIHLhSebO0nZ4A39QU6+yAID4gPdriO31Nkownq6ECb2yguWYU?=
 =?us-ascii?Q?9QayKkD3exN8MNg8K1uzYNm/Oadjz/eYDTOETX58oDr9Zds4yIq2QOsTobGj?=
 =?us-ascii?Q?jXLTYgWIfUoYZUq6FOVALGEEvkx2Pc1/+wfo6QE+Dj+SYP9YcUPowKYU2Ipi?=
 =?us-ascii?Q?YqOGARyOCisDfeg/DjIvj/Wyi/a6ZWhpXEhLogz3Ln/YB+tbjwLFxqkjKw1T?=
 =?us-ascii?Q?xEwOHngNbACPIUKG3gNgKpMpVo1+TnsBs6eVt43ucL0fOsSTWJNPemhRbalV?=
 =?us-ascii?Q?XM8M496I141e/r4q6xvLBY/yS8OM1aVvPqI36Wff7wTRIVVeF5c+45Wnzued?=
 =?us-ascii?Q?t24wqL080wIS8/+k1dfFQPIaF0RxAKiV3WX63br2s449EKBDYCwuE+L5A7Jg?=
 =?us-ascii?Q?9MKayGRfyJVyCKd5xBfLTEhK2J4opV2DZvcBIJx2l+vysFlbfPN5AbgIl2h8?=
 =?us-ascii?Q?NWtyw7S0tquU+XC7XmLs5aaEPM8vg3+MgED8xFibu7yZbQYHV2LCMm1ZD6rV?=
 =?us-ascii?Q?znIoqCDh9QkNIyXSWNlasvIpkXHd36P+PqpJRFKpPzw9wwHIU41pCpk2XW0+?=
 =?us-ascii?Q?4+kd5LlBaBN3WtKMfsbtNG8L6b76Mg1LRrQkF8ctW992KC+WcUaXD3D5k0fY?=
 =?us-ascii?Q?/gxO02RW5ZmLdf8gJWNhJ2WVb15Sc4z6Lbc7DQHY6t/h0BceUwfoxRl/4rk0?=
 =?us-ascii?Q?HPhu9vwkt0wollW8wVzutpqltJZIvN0XuORBWr+YC1HM+KBgraVbl8RhWlXs?=
 =?us-ascii?Q?2HxqS29h80hUW3yc0ZsWB1O7xmVqjMbQpqIva8cJUmEk+lwFDTyrZpMLq8mP?=
 =?us-ascii?Q?BKgHDrW9MU3FT3mf+42bU2UNsgdFprIezobErnAjFDK7RQM87wkAa/SdiVj1?=
 =?us-ascii?Q?QE019wWY3oxvj6NtffnlZ9GU3huQaszT30g3QiWEu8sfzmkpaKJntOK89CZc?=
 =?us-ascii?Q?uHJ9isVP2wr7hcfuqRUINFq0CJVojz9AZtWDZs0tJPH+NoES7Yz+LDCj6CWs?=
 =?us-ascii?Q?DskEPBPJb9vL+Gtx88DTJjY7ZbWT5CAIrgz8slBdBwBccxDxqyBojOa/CKOX?=
 =?us-ascii?Q?JroSApDtY69L4yN/IAyJNzCzibttecg5uv0CMYNkWohuqgi4p/i+ZsBt5zLa?=
 =?us-ascii?Q?Mi3f+3ThrlpqKRkbclNK9KBiJtDlmkiNHsM5B9IQUV5YKgh4UnjqZfu3UHOH?=
 =?us-ascii?Q?JRfBb7JPP/VlNPa0YkLrBbh+DZ1E5KQV5zVqwHBoiuRBC3ma/vH/eDR/Z/Me?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fada24cf-fd25-4fc4-3484-08ddbe29cdc2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:14:51.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQYl6lI4/EKAPAv61ND6I4bDBm6eMOoufjTgKorzb7uoBqC1UxRxswR3MqBQCqT4/7vaJGl9h2vqdk75vNsbUBHg+IIFflM3OHFnG2dvzPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6617
X-OriginatorOrg: intel.com

On Mon, Jul 07, 2025 at 11:40:48AM -0700, Stanislav Fomichev wrote:
> On 07/07, Alexander Lobakin wrote:
> > From: Stanislav Fomichev <stfomichev@gmail.com>
> > Date: Mon, 7 Jul 2025 08:06:21 -0700
> > 
> > > On 07/07, Alexander Lobakin wrote:
> > >> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > >> Date: Sat,  5 Jul 2025 15:55:12 +0200
> > >>
> > >>> Eryk reported an issue that I have put under Closes: tag, related to
> > >>> umem addrs being prematurely produced onto pool's completion queue.
> > >>> Let us make the skb's destructor responsible for producing all addrs
> > >>> that given skb used.
> > >>>
> > >>> Commit from fixes tag introduced the buggy behavior, it was not broken
> > >>> from day 1, but rather when xsk multi-buffer got introduced.
> > >>>
> > >>> Introduce a struct which will carry descriptor count with array of
> > >>> addresses taken from processed descriptors that will be carried via
> > >>> skb_shared_info::destructor_arg. This way we can refer to it within
> > >>> xsk_destruct_skb().
> > >>>
> > >>> To summarize, behavior is changed from:
> > >>> - produce addr to cq, increase cq's cached_prod
> > >>> - increment descriptor count and store it on
> > >>> - (xmit and rest of path...)
> > >>>   skb_shared_info::destructor_arg
> > >>> - use destructor_arg on skb destructor to update global state of cq
> > >>>   producer
> > >>>
> > >>> to the following:
> > >>> - increment cq's cached_prod
> > >>> - increment descriptor count, save xdp_desc::addr in custom array and
> > >>>   store this custom array on skb_shared_info::destructor_arg
> > >>> - (xmit and rest of path...)
> > >>> - use destructor_arg on skb destructor to walk the array of addrs and
> > >>>   write them to cq and finally update global state of cq producer
> > >>>
> > >>> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > >>> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > >>> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > >>> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > >>> ---
> > >>> v1:
> > >>> https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> > >>>
> > >>> v1->v2:
> > >>> * store addrs in array carried via destructor_arg instead having them
> > >>>   stored in skb headroom; cleaner and less hacky approach;
> > >>
> > >> Might look cleaner, but what about the performance given that you're
> > >> adding a memory allocation?
> > >>
> > >> (I realize that's only for the skb mode, still)
> > >>
> > >> Yeah we anyway allocate an skb and may even copy the whole frame, just
> > >> curious.
> > >> I could recommend using skb->cb for that, but its 48 bytes would cover
> > >> only 6 addresses =\
> > 
> > BTW isn't num_descs from that new structure would be the same as
> > shinfo->nr_frags + 1 (or just nr_frags for xsk_build_skb_zerocopy())?
> 
> So you're saying we don't need to store it? Agreed. But storing the rest
> in cb still might be problematic with kconfig-configurable MAX_SKB_FRAGS?

Hi Stan & Olek,

no, as said in v1 drivers might linearize the skb and all frags will be
lost. This storage is needed unfortunately.

> 
> > > Can we pre-allocate an array of xsk_addrs during xsk_bind (the number of
> > > xsk_addrs is bound by the tx ring size)? Then we can remove the alloc on tx
> > > and replace it with some code to manage that pool of xsk_addrs..

That would be pool-bound which makes it a shared resource so I believe
that we would repeat the problem being fixed here ;)

> > 
> > Nice idea BTW.
> > 
> > We could even use system per-cpu Page Pools to allocate these structs*
> > :D It wouldn't waste 1 page per one struct as PP is frag-aware and has
> > API for allocating only a small frag.
> > 
> > Headroom stuff was also ok to me: we either way allocate a new skb, so
> > we could allocate it with a bit bigger headroom and put that table there
> > being sure that nobody will overwrite it (some drivers insert special
> > headers or descriptors in front of the actual skb->data).

headroom approach was causing one of bpf selftests to fail, but I didn't
check in-depth the reason. I didn't really like the check in destructor if
addr array was corrupted in v1 and I came up with v2 which seems to me a
cleaner fix.

> > 
> > [*] Offtop: we could also use system PP to allocate skbs in
> > xsk_build_skb() just like it's done in xdp_build_skb_from_zc() +
> > xdp_copy_frags_from_zc() -- no way to avoid memcpy(), but the payload
> > buffers would be recycled then.
> 
> Or maybe kmem_cache_alloc_node with a custom cache is good enough?
> Headroom also feels ok if we store the whole xsk_addrs struct in it.

Yep both of these approaches was something I considered, but keep in mind
it's a bugfix so I didn't want to go with something flashy. I have not
observed big performance impact but I checked only MAX_SKB_FRAGS being set
to standard value.

Would you guys be ok if I do the follow-up with possible optimization
after my vacation which would be a -next candidate?

Thanks,
MF

