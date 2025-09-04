Return-Path: <bpf+bounces-67402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3B3B4372A
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 11:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199D6542940
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6972C159A;
	Thu,  4 Sep 2025 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBwgLtCv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352DD292938;
	Thu,  4 Sep 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978323; cv=fail; b=X0tKAfuBZHPWPhy7BhDp+nqzVRCFXysVhpisIQpOrGzxF036y685rRMgk5g09C7mQufsICmNQDxpuH+UayUlX/8vVk3/lZfkO5U4FnbsKmvUTwYPK3cwiZfKuHqJAUGalB0tIoaimIOIRoT37stdq21thyefydxiMcUxQJ1biYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978323; c=relaxed/simple;
	bh=iThBlXKT+dVb4KH8WgBz+D7EDpHAvy9w2gVQVBsIYuE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rNR7PSxWsVgkFO3ikwQ87iF7snAD5B4acBL8DCR2DLcHnX89+BOLr89jh8tVfVL0lF9jKEbRCzwpKMChqVtFzCJ5Rncqy2aGyH35QB+93HcCGZY4osTbdZgNXxjZ9EYdLK37heyQpTUhpW8CwWhdjk4Qoux/clyyDhdqgIQkgkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBwgLtCv; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756978323; x=1788514323;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iThBlXKT+dVb4KH8WgBz+D7EDpHAvy9w2gVQVBsIYuE=;
  b=lBwgLtCvDCJS7yWSM8xfaUGiPasji5eRGgTjsQpP5KaGooQDyAf8jXps
   X9Onsex2P6Dw/+zPHVxKBYIzKcRzKWFWEq6H8lVwC1PWZCUu633MWGEq5
   gzjyQPskkRiOHMxMFWpHgNccjMXn0eH2QnUqRQtd1Qvz5A3rDWblf14Yo
   WNsaNJREHqyCGwGHS1hLLVVJFzNllxLakrbQsZ2pIjEpBgoPGhSuGwkYN
   7WhTfDdNQPmiF0NGIjbYSdRKd2S8AKUUu27XPQR1b4234/Zlh3B4Ybf6n
   7gWdfwuycAjNhDLLZMFfObRcskXwr9wi2cFly7pMOJfWpI5MxoErOmA1Z
   A==;
X-CSE-ConnectionGUID: ZhQTrqKvQpqUXa/W46hAiQ==
X-CSE-MsgGUID: 1g016tOASdOHIFTXSyg4Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59457818"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="59457818"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 02:32:02 -0700
X-CSE-ConnectionGUID: 7CqsjKVNS2G6uqDAhtkCOA==
X-CSE-MsgGUID: /8LM58XJSQOyiDP9akjGXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="171093030"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 02:32:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 02:32:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 02:32:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 02:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2SPmi25J70sVrk344oI8NE6XZBzBla4zM6FVNfZ5GtXWB1gjekECjsxolphKSwQmhCu5NolNIZVLMu97dlBGJPYJVuDi4Kr1jg8yJIbHy7fqvoCfP6bOv/81LqLsymwdjtrZcn479FizAwSe4pkIDN9qYC1w4zMxYrziIm35R4W6TtACdllCtb1HZCYW5Ki0Ck1KdcmxhmV4IMv8BCNoDpCFlq3tOsxeunWdEjlseQnchO2yh69l6bt0dCoVy7Ao8dhVIQR1DksTsYX8rY9fhz9pmu1Pbtq62CnALQkl3uzR1BtMPVB9ZhFzsCzaGrIl6SqXhKXf+JpEaHii3dJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=196uCSd2idR5h31ppWwoI4tHGLO5mB0zWGDqgRQxoEQ=;
 b=F4PEmnnWx0NOzLelP78BHxJ8qtLUToOLzJbBoMGJIbi026ckAFdWTY0Lu3fDFqAPQ6O5DURFPFeojsm87UjbdFmdnuXZzBjL/8ffwZkzIYSBdK0ctpYC0nThpRQi80/dhvVDvcdg/o/DAqnjq3VA2v4AffMIieN8Bo9LNy6i1KiepolaUAr+25rjVwfkk5C4iYwq5MLM0LYRciEgj6ObACMool2nVZzutb0+e0S82TdaOSwepXRWapHoLDir+00A5UVUzaddrZTYcj+6eVskOWgWQXlWvGOiV8YMqTywGRd+OWoP5HXM42v+1OqZazftCn1Kwsee7cgW0wNxfepvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Thu, 4 Sep 2025 09:31:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 09:31:50 +0000
Date: Thu, 4 Sep 2025 11:31:44 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: kernel test robot <lkp@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <oe-kbuild-all@lists.linux.dev>,
	<netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kerneljasonxing@gmail.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v8 bpf] xsk: fix immature cq descriptor production
Message-ID: <aLlcgDC7s3Dh0NdX@boxer>
References: <20250902220613.2331265-1-maciej.fijalkowski@intel.com>
 <202509031029.iL7rCVvQ-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202509031029.iL7rCVvQ-lkp@intel.com>
X-ClientProxiedBy: DUZPR01CA0186.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdc6010-07a0-43d4-4754-08ddeb95e040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cl2hYb6UOjxf1arPAZVWhmvekuPsciSpVynZG2OG72uABHamXiwJ9sQayiT8?=
 =?us-ascii?Q?8tPVHS3HzxC07SJqp44fPRGbko8HdGEwlLeMuUfRxJUth17Cs6eJrAbp0Hqk?=
 =?us-ascii?Q?JUX4z6yx9xCaoOg45pKOgt8+q05GCsJvgtTT5BFgPfyuL5zjBIJCDygCc54D?=
 =?us-ascii?Q?yLiGtmvwPJj9Quk7RXh3974SqZlJMf2UFwNAjyE1Bmof8vquAX99FR1c8b72?=
 =?us-ascii?Q?evR+nQ5m6ssYwQg3uKc2R+0t+mcoakJUP647oIx8N4w6NEIX+DkQpX3SytLl?=
 =?us-ascii?Q?jLGPTdEKr/g6DrumGmr+vTJpwkMHek/YzSkCf6h8VPRs6nayGYZe8VEdFUVl?=
 =?us-ascii?Q?U5shtLMIcytsPnpaI5Carlsr5QE3UIfBYB7c3T8ENOTyvh3yMtDZb8VJjsTM?=
 =?us-ascii?Q?naMgAo7JGvzfzG/oDconIrDtpcEX/iJxdGTajo19yy2ofByP93jYeFVp1ksF?=
 =?us-ascii?Q?+ztPDCfYcswosEAdzvCguuV5LI16aV/Fnd/d89INNAUgLkJYgwhujhkhlPMg?=
 =?us-ascii?Q?SL7Z3sedN1734WgfBG8G/o/nObYglDk6THNDJlM82oa8fq0SMbkjONfOTNXv?=
 =?us-ascii?Q?Y/WnqWrKxPcySOyBZNaQDS4+inw6/oBimnmvpWWOdxOOSGJLzXsreqqMMIlw?=
 =?us-ascii?Q?d93R56xUrcu0ZN7jrsrsM8QNnF7/jENXgkLFGMm068bW+QYSzMoLEiDtaoGq?=
 =?us-ascii?Q?c30eeuC9AWhFtYhgAAHT5LQkis6iFFgMcpdmwlTXMI7g0Bol1Dg4fYzX5j0R?=
 =?us-ascii?Q?8Uu7AQYyjytA2nHbjktsBFMIdx6WfIaQYlja/YL2eu882uufhUCta1JphBy6?=
 =?us-ascii?Q?iXX63e7qCxCBbC4TSXcOTpXMDwYYl6A/uwn6bvrK2Dm0EWonF28gkCCxjAG2?=
 =?us-ascii?Q?P/bv+/QerR07m1StXCvC2UPcZCMAzI0ArF67NoAP+mkLtOknKXjl6gs/f77C?=
 =?us-ascii?Q?TdtnW1/QNirukcJbwPvi0A6ThzPSNMlQ4KAskEb4T0rpDvP/i8yuvvXSz2Em?=
 =?us-ascii?Q?c1ulQtZ2kB8G2qFDio49OafzVPO6UorMf0pyuaROv949HizYubXON9O35sFs?=
 =?us-ascii?Q?lwdgfmOwT3ZfougiDwarsKGPaUmMYiOzyV9EqwZ8W1d5+9eWnGXEVxc+Me4G?=
 =?us-ascii?Q?fqPevl508TIHJMKhuSV/oLXexN12eaw0SLZOnGaRTqYlYPkStKwnWONECDBZ?=
 =?us-ascii?Q?K5VsLi6V5/XyFObltMkZ6aqq7jV6b3MCW5YEXW9RVdFBeqzoTgAdcISIeY71?=
 =?us-ascii?Q?2Wcue1jZgiDIY+LyfI/Z+gNA06DIELZDoLAlySRsdHW0qxI7uZ4hn8+BZa0v?=
 =?us-ascii?Q?Ai4q+vsJGBCQ8dmNEvGB0AMAaZGrPmOvmlSWdEWCY8oAEactzz1ENEJqaDAY?=
 =?us-ascii?Q?FKAw0IZUg8B7lLJpU1lQytrNItHu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uWpPIU5CN5L6Hb6+gVP0rxukvMESWOCN6eeMa7Zy6fz7luDxRgVNKZQAaiVn?=
 =?us-ascii?Q?OO19p5WZcD8xym+n7dZjTreIISRKGMpRiZZCLX0l0tWx6zaZ8xKNASznyKWg?=
 =?us-ascii?Q?aovGCtv93yryXziysLEf0ePBUfQTiYxTsnFiyJ/9BXnKTcD/ovz56P8HZ5Q1?=
 =?us-ascii?Q?d45SQjhTfZvOEEpqvfDbVZfRSHJ32WicYnXc4mzw36PJk23SiVQkecPQldYW?=
 =?us-ascii?Q?sQJ1nByPb6mdGZRQ7MM8crlC5xiubNvNq7B0YT8XlUgptFfimfpPe5eESAzn?=
 =?us-ascii?Q?bCbIDECGOMGRuKTpPi10Zsa8laY/gyML8ZBJ8ZtOZvgmFmbAxIJR7rwNFohU?=
 =?us-ascii?Q?9XdlTiC8CPsquDKUY+UmwyDb2rwNnbLI7Dqj18+Gzp8yFbz6G/Ucl8oP3oG+?=
 =?us-ascii?Q?K0verluJolhpBT7W9sB+dVwyiZWrCtoHtqQyFGU+wFCZReTbV0SztUiwOaBR?=
 =?us-ascii?Q?qZ29i5Yb73Ki4iyYblL+Q6u2cBPCv9Mr7lq+SUj5fb2TGdY7akD0ETWcXhvu?=
 =?us-ascii?Q?YRBJDy04ylGFj5UBrPBJXhaO/nt/e6ozk29j0yEjTYG7m9ikstsfSbl4pgPd?=
 =?us-ascii?Q?JKWKsd//e2F6WILDuJTe0J21rMQ6NJPplBrMzpk2VRW6JeZVtYp8Z+1RrqOa?=
 =?us-ascii?Q?63tn5u5a8vnQX1pRwDAliJLIC9/l4vZuhm0QABJzRyMelM8Y1RNJpKWmuSbX?=
 =?us-ascii?Q?Fkzr1H3JG5eh6WtrygqO1olMvkQpLUoA04slCWDaocPcfgIzWz/uXS72mB9h?=
 =?us-ascii?Q?Xcz2XIbB7R48Ik/3WXMQdcWRwH/qNAHBq9cKAlCPIae6dg8+pv7TJpR/bWVL?=
 =?us-ascii?Q?JsnJmv6AMZYEzz4a0dyv0bwUPQqHd1ucaG6sDQfdbOyURzZwGXvHhKVTD2sW?=
 =?us-ascii?Q?mFmQut33lG3/Qh+N5YIQMwEvdoik+jAHP0UROrM0DUEUJdoKCtWMZmUy0dyU?=
 =?us-ascii?Q?w0J6UwzGyrMGBQj4bhypBBg/6u4kwENB/dq/Yk5+tjWonE6hfl13vSl9Q15C?=
 =?us-ascii?Q?g4iwtrmTID1rFpW6KsDDlGmfXu0/nJAYyqbZWZ7U4Vy4YknRzoe8KxrxojWQ?=
 =?us-ascii?Q?62fNanyctc46s0rGgzDeID4diYyO849x7djEaC9uKXZ3/pai/yD54hEzotMm?=
 =?us-ascii?Q?1guFvRiSfuA/N+hJ+nbw04b8h9OaJyTDRTJlhoBYmtj5dZDiyMh3uwTae7zR?=
 =?us-ascii?Q?AzHihF2ZMDA0H54hC0gz84mO0uDWIbGZDw5/UKwL+sMQmKKnuuVzSusex+rI?=
 =?us-ascii?Q?9yBEP8xxtqwcYN/PbSyCBoEe5c3hKHdmsftFU0QocJwbAAv3rridF/4y/MtU?=
 =?us-ascii?Q?gRYbrXpZWe5oUi6peomALuH+DASnXb2rxizp2v5AQPTyUFIFYp4zrcXuBpsK?=
 =?us-ascii?Q?Mnu10OoFtQQR/y/8FwvUrnvWQLJfBhbuWlngZ8XySe6NlaRJDVWh4joqKmso?=
 =?us-ascii?Q?8mwLX5/svbd27XdX/QdmCHst83IC8ZANJP6IxmsQl6DEgkHWfYYeLPxS+ZQk?=
 =?us-ascii?Q?4SBgGail7X48EIHxAZm9MkUt0OdFyY6Dbmwjv5uRnql7ooqQRYcnH12+i/AN?=
 =?us-ascii?Q?PROE9QVo7mD7g5f1sVRMa1xHTbDDCIR4lGe7HUbe4HNb0yT55xlTq7SL3wJt?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdc6010-07a0-43d4-4754-08ddeb95e040
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 09:31:50.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8Rk9IDuvlf1eIqn0MmVgEVDUuKqlLasu3Fb9nvtFjxJfxFZJE4ceAP/A11LalSsqEPJprAFn188NlTIB2IERS92Txujc3k3BOfGl/16IvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
X-OriginatorOrg: intel.com

On Wed, Sep 03, 2025 at 10:29:02AM +0800, kernel test robot wrote:
> Hi Maciej,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on bpf/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/xsk-fix-immature-cq-descriptor-production/20250903-060850
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
> patch link:    https://lore.kernel.org/r/20250902220613.2331265-1-maciej.fijalkowski%40intel.com
> patch subject: [PATCH v8 bpf] xsk: fix immature cq descriptor production
> config: riscv-randconfig-001-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031029.iL7rCVvQ-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031029.iL7rCVvQ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509031029.iL7rCVvQ-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    net/xdp/xsk.c: In function 'xsk_cq_submit_addr_locked':
> >> net/xdp/xsk.c:572:38: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      xskq_prod_write_addr(pool->cq, idx, (u64)skb_shinfo(skb)->destructor_arg);
>                                          ^
>    net/xdp/xsk.c: In function 'xsk_set_destructor_arg':
> >> net/xdp/xsk.c:625:36: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>      skb_shinfo(skb)->destructor_arg = (void *)addr;

Meh, I suppose uintptr_t casting will help here.
So I'll send v9 in the evening :)

>                                        ^
> 
> 
> vim +572 net/xdp/xsk.c
> 
>    560	
>    561	static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>    562					      struct sk_buff *skb)
>    563	{
>    564		struct xsk_addr_node *pos, *tmp;
>    565		u32 descs_processed = 0;
>    566		unsigned long flags;
>    567		u32 idx;
>    568	
>    569		spin_lock_irqsave(&pool->cq_lock, flags);
>    570		idx = xskq_get_prod(pool->cq);
>    571	
>  > 572		xskq_prod_write_addr(pool->cq, idx, (u64)skb_shinfo(skb)->destructor_arg);
>    573		descs_processed++;
>    574	
>    575		if (unlikely(XSKCB(skb)->num_descs > 1)) {
>    576			list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
>    577				xskq_prod_write_addr(pool->cq, idx + descs_processed,
>    578						     pos->addr);
>    579				descs_processed++;
>    580				list_del(&pos->addr_node);
>    581				kmem_cache_free(xsk_tx_generic_cache, pos);
>    582			}
>    583		}
>    584		xskq_prod_submit_n(pool->cq, descs_processed);
>    585		spin_unlock_irqrestore(&pool->cq_lock, flags);
>    586	}
>    587	
>    588	static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>    589	{
>    590		unsigned long flags;
>    591	
>    592		spin_lock_irqsave(&pool->cq_lock, flags);
>    593		xskq_prod_cancel_n(pool->cq, n);
>    594		spin_unlock_irqrestore(&pool->cq_lock, flags);
>    595	}
>    596	
>    597	static void xsk_inc_num_desc(struct sk_buff *skb)
>    598	{
>    599		XSKCB(skb)->num_descs++;
>    600	}
>    601	
>    602	static u32 xsk_get_num_desc(struct sk_buff *skb)
>    603	{
>    604		return XSKCB(skb)->num_descs;
>    605	}
>    606	
>    607	static void xsk_destruct_skb(struct sk_buff *skb)
>    608	{
>    609		struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
>    610	
>    611		if (compl->tx_timestamp) {
>    612			/* sw completion timestamp, not a real one */
>    613			*compl->tx_timestamp = ktime_get_tai_fast_ns();
>    614		}
>    615	
>    616		xsk_cq_submit_addr_locked(xdp_sk(skb->sk)->pool, skb);
>    617		sock_wfree(skb);
>    618	}
>    619	
>    620	static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
>    621	{
>    622		BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
>    623		INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
>    624		XSKCB(skb)->num_descs = 0;
>  > 625		skb_shinfo(skb)->destructor_arg = (void *)addr;
>    626	}
>    627	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

