Return-Path: <bpf+bounces-35732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21C93D46A
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 15:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3F6281EE7
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554517C216;
	Fri, 26 Jul 2024 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEUEgvwO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8B1E4A4;
	Fri, 26 Jul 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001421; cv=fail; b=iq5T2fDiF34C2otLOqhJFHwKdH2E3rfPwOWchbCl0Afc0qaS3CqArkrPCf5anKt4UNInu4FJPFUVvV2FYLOzOAYNQ992UIiyy9E2X0kQ6YiM/q4UjgjI9T0AuLzfqp+mGcQS2tDwMLivxotMHn9kXOrmByVa6kjCoZL4xjwL0q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001421; c=relaxed/simple;
	bh=rEw3g73xSJk+2Gl1d6bWT7OlLqhQEwpQJpy1lRdlwNY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hbCVZqsHcz0OJQEtDD6hhONGvKgxjJCh4eN0xtmmmLLowOquoL3OavPssmjwW9jHzwoEkIUi6tEsg8fq590+q9eF6gdhid7TWGsI2fuhtlwGvNWUvKJ9fQA3/qvT2dpJE8F/SlTldh8eZKxAlm/DrbPCCeWtkvFZs6WS/xFVwOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEUEgvwO; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722001419; x=1753537419;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rEw3g73xSJk+2Gl1d6bWT7OlLqhQEwpQJpy1lRdlwNY=;
  b=XEUEgvwOIOdekQ/NmCTfv+Z5gK64o6wSWHZ6PlqNHHvN+xOo5xALkptr
   QYrYf+K4XlTqUiFfhhlQ8dO8E0LSFst0dqnFEZKPkiuybBMIDfZGb7Aos
   I6Wv8+yFACWSa0Gv8umTH9WpB8bdoypyiPm14bQsIV86k0X6OiR7e6Esv
   U1Me80atSinOVVpqLrdC6Wfc9VUw14py3IIFaYiCTQXxDbksTcDX6pfq9
   QB/lZBWbLnGI3OkCCLXRMGobsVL0u86wD/5lBhgYo1lu6CUrJUB1Fatm8
   xsZvZ6INaJvP9UEvwYDvV2xorn7GrjaULBRbTEMmjE2TUCHr+pmPWTj+3
   w==;
X-CSE-ConnectionGUID: KnTyozl8TSKQN3dH29CfaQ==
X-CSE-MsgGUID: NAIM7t/SR7OcWPP4QXJbCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="31181186"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="31181186"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 06:43:39 -0700
X-CSE-ConnectionGUID: 9UKJoz1aSGCIQglM6FLZeg==
X-CSE-MsgGUID: YT9rELxUQW6pfGrOpiyxMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="52956312"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jul 2024 06:43:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 06:43:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 26 Jul 2024 06:43:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 06:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arWVD0xXeWfpxcKnsxCbQpupb36+WJu5qiIrpwhdQzmM4Y3/9CRMvXpI3exgd8yLoFXly7b+ECUNqLuixZeedGJAbjTT9McA7Q5dLNAoyFcvLw06/A9W6UzXSHPqTwPxoupLwfXH9mKa/n5zMpxaabviXQdN/VFzsih2KAp8ftaE4hsnjzjQE/MgQH15u6u1Z5LizSE7P1f1pA/r1oeNFHcxs4B46gVOmiUkkSC/vePKBPgbmHbvIfxvAF6I5jbzanKdqofFcaUFO9K58147o8FS2/Br9WTP2SOiQ4Kt1UcKpoFQTpDJrn51ThW7DcNgPi0xXkVsGfARnXprZsAp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVydkqusS764Z1idw8+m7jIZuE/vEZ1y7sGbqsJkyxs=;
 b=VbeGZVshCbwrlOVqsTVMGUenw3kB+sqrX4/8CjxHL+8fErt5nGARjHfoNJwJV+LM6jiaHS1VAvOdHvYb5QSR6uJ61bKdf5pm/NT0cTi0CtCEfurVE51MEm4SpePSw+AV2xmmym74EQFqheEejQBFpgZ5HMmSQOBLWE9VtUzvUP8GPurKPx/23v/Ep4NXyPGQ7ucwg8Ndde7ERvwf9Rx4Jpk9pR120zEQRXYFlOMXDGIyvg4it96Ng5YwfWJNVAhCKodBDYrfUeKhoMn9PkAM7ydYZNxH1BTfQJpQ8B1cf+b+FAKz5toLvrw6rvb3RVVdBCz7MgwbXjeT2PB9yCBuqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB8413.namprd11.prod.outlook.com (2603:10b6:610:170::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.19; Fri, 26 Jul 2024 13:43:34 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%7]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 13:43:33 +0000
Date: Fri, 26 Jul 2024 15:43:20 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <aleksander.lobakin@intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Shannon Nelson
	<shannon.nelson@amd.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 6/8] ice: improve updating ice_{t, r}x_ring::xsk_pool
Message-ID: <ZqOn+Lgr2DoEae6d@boxer>
References: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
 <20240708221416.625850-7-anthony.l.nguyen@intel.com>
 <20240709184524.232b9f57@kernel.org>
 <ZqBAw0AEkieW+y4b@boxer>
 <20240724075742.0e70de49@kernel.org>
 <ZqEieHlPdMZcPGXI@boxer>
 <20240725063858.65803c85@kernel.org>
 <ZqKaAz8rNOx/Sz5E@boxer>
 <20240725160700.449e5b5f@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240725160700.449e5b5f@kernel.org>
X-ClientProxiedBy: DU7PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::23) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0be193-cded-41d9-e9b7-08dcad78f0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5oYB8ePVmvUYzh/qd6b8iFHiHBvI5eqS0DekxIdGNVT4RgZSy6qk5L1mJkkv?=
 =?us-ascii?Q?NhsBKIAx+yt60AiJXyL9Keq+kiSbh0iMaKOHgAaiQzq9so9/jzG+Lh4YrTkx?=
 =?us-ascii?Q?Y15syioXbHo9GYXMQ2wZfs2YaC/xwSXMcwPYM1bSYOSezSj4rz3jw7wYdQmj?=
 =?us-ascii?Q?/iiiL5odXiA6eYpzVUl0q/tza2lLpBPQL5VXXkvnyFc2Kk1TTbsza6Dpe08t?=
 =?us-ascii?Q?H67WM5j31fC47H4El59eu1rimBZJwNZL/nwE4r/vnj5it4ZdmQjisCCU6YU1?=
 =?us-ascii?Q?rwrUIMomuGgdd8CD9kIdT0g4mueAFxPXCy/J18KengcEQBXh9FDsGVhoM+IT?=
 =?us-ascii?Q?4mLREJSYLISLpavGLtIzRyv4jjRI9eisl86S/MHD0tJAl6AcexgJMjnq5nPS?=
 =?us-ascii?Q?cH2Y5E7sTz6td+4Z2oYFyvS5U7uXIZhDxK63ouDvvaqBCyVqX21KPBNzxU/2?=
 =?us-ascii?Q?pYFGsfKVkdIjbd3zlw+WYw9p93l0e9wbcgXVhMM/wIT+REjS7rgyRYtx0aOH?=
 =?us-ascii?Q?4Uen5daSlPdM2RlBUQTfwdvzJr+nWJVW0OeN44SlGHV2d2vUJJQFtSCx9zyw?=
 =?us-ascii?Q?KLNkS5fEN7Km5Kw17OjRktOUwv95wX7pGkhgJeKdkXXYGs1k0HWZzYNgs2U4?=
 =?us-ascii?Q?Dd+/cSoM26d++XYxOyd0oxNzMsvjMOpo5H4ZdDH4baPDS1+yImY23MAl6ta5?=
 =?us-ascii?Q?rZyXh+qRQvpNiOgtcX/P1wY+PfS3Ix3hQChsAOxs4joaJYr6Xq75o7o/nUHU?=
 =?us-ascii?Q?3rYrU/zFjS6IHXrXeLpUFFMNBV8MXFOS/IqREd3PEXoY/TpZDr0gyJjVlruA?=
 =?us-ascii?Q?geit/OdWJKFCv10ZnRldW0jHXis0q79j9O6Pytrg4T5MjtebeaI0/uTVN0tj?=
 =?us-ascii?Q?NEPSJb4JRASovolVfDH3CpzLbYdVsgepcySAhZRT4Ax6AcwaucyaJKG2wpSO?=
 =?us-ascii?Q?wlG31DHTZOr90oln8tVgdLr2bvBnb8OHY7KdlkViFhhRbeB74oWc1NIsWRzH?=
 =?us-ascii?Q?l/2Qz0cdzd+73gMFmn2o3kU5Wo29XwYl7S/3+ZAFd2gkp3Ey9JjXiTN2jg/1?=
 =?us-ascii?Q?OwVck9s3TkzMAM9ZIBw1oU2g4G9DUgDWRxOoCjWw6fauQLI4K3f0UPIEbKxj?=
 =?us-ascii?Q?ZfPS8YCGA2HZpGDJgoiJAU6spBZzw2cjbMe9wDi0n9j9oEfhOiL3SZZ3crtV?=
 =?us-ascii?Q?WLXG+Y71qoN0hNe1+vcWzjIrzqYoRDVdTfx1+70yf+vTlP8MQFL3BkY3EnEo?=
 =?us-ascii?Q?kEIlPuxNvbC35Si8eTFytwVpoaXiXT0eH4F6q4K38ecwS5kFgSqBZ07DyzZ5?=
 =?us-ascii?Q?CCb67FxhP0E0aCt9j0vm2fUXLLtM7RFWPyLHxO0dU8amvA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UpAU/TGDmkKTd2hwfuYhUUhQrXFig+buka4Ew3CS6mnhC2AFF/If10tWkaTY?=
 =?us-ascii?Q?o4hzyqtHNHINM3fVyMfGO3E+zaqUyUgY7/iJlti15m1q9dFkFNAlvg+eBswA?=
 =?us-ascii?Q?DVXd07mlsb1eRyy+bYbMFLKrWQhxcCb/5drnOEK8roDOB6k/+mljUqsr33rB?=
 =?us-ascii?Q?SenJL8SGGYfdCshKXSZ/jc7VpAFXpmY1vbG1w3qJDdNKxfyzBfeVFcOHQbTZ?=
 =?us-ascii?Q?jhdMipSPEWODZ4vfjPR/q7OGorj5raLHMFoElGUSQoD327kSARHdzUglaWv9?=
 =?us-ascii?Q?51ICtkyi0qtJitPLd5H1fi5dpitAufMmY9e5c6C6HKPa3UMKIoH3iI7wKEfJ?=
 =?us-ascii?Q?LHIqeZ+1CqlIECOiS1WEHhO2mPvnnBw0X4TAhTbMgPMup8csrsqzWLTABelq?=
 =?us-ascii?Q?qu/O64SJ9UNrLs4bSCct27Ck0Zj18R6ENu9J8hTg96maTb/s+VSgC/6cCadf?=
 =?us-ascii?Q?FxtWQNOoQ1dYr5DMyclj75Ewa02hfcOuVpZre4xMTgg8GItr0gOBueSjfmWz?=
 =?us-ascii?Q?F0Zx2MCFKuURKEYyfUtt+4E4Is2AavYM0x8DRBtDZNFmcINW4bgPNFW/QS7N?=
 =?us-ascii?Q?TtLoKg0gBfAo4kIRSee02H9ACTCk6L9Ty63TUt8ObwDINYtvMAnhxvzJE6rP?=
 =?us-ascii?Q?e4YV6Jbd8xvv5WJtsRp8IjRkahMWz9kCG3pZuea9ojaU6uTmBwpUtISiyKWC?=
 =?us-ascii?Q?H3DKL17yDZk/XBshq1EAORuk9jqnmYCjFPe2VMwySYxisDlqhWfY+4ZqpOjZ?=
 =?us-ascii?Q?whEx+hdFZG8WtW+mXA5JSa+77EpbdLBOhU721W8jW0w3AVeI+d5059LPmO/8?=
 =?us-ascii?Q?jfhF60HYLR74DBANRo77bxS/d7DrNTAUvCmqPrO04wi32Ge3Gfawz7SY8m0c?=
 =?us-ascii?Q?BxYjwsom6pSWribHBzIO3ydb82/zEV5UrfnyDuY5tGd/eYSARiaxiE0cFK7T?=
 =?us-ascii?Q?57e/u+oV+jZigQUg9MsSt9CSnkaypEXCl1UHqCRrMaMT0LQf2g7Klc02ga/N?=
 =?us-ascii?Q?OOjAkx0nGoPl2rvBQ7c0zFEHrY3NUOs5jgnfWpbJEi6H/Sx4BWJbs9S7FJJO?=
 =?us-ascii?Q?hbHy7z2ChLRW5p2lNaSjP1YOulA/DtwE4HQcPj0qE8rdAJZ04pqHAL/WnI9N?=
 =?us-ascii?Q?NDjOQ7pe40QHGFCdjE2yDKgdgr9B6waEc/x1zJTM9z9tlm5fUKXPTm1kKXa+?=
 =?us-ascii?Q?gK+xCfwX+sjNJzLiqPwvSmLYa7RYRxRdHJ3OgV9Ewm2w28kkZZD+ALbrY0tP?=
 =?us-ascii?Q?PLE9Bvyga+mxICaAOghcLhkf/f1/+RV8f4aVqRIaGbU3ygIWr1A1uPvY7u5B?=
 =?us-ascii?Q?WRcpNeJeibfzz4K5HfiMzyilep2MGvyTmeH3JU31+MF7I4pPpjFIPHpOLMEE?=
 =?us-ascii?Q?60RKx+wvwJwy1vlaQydmxjOrNHQa1QPhMZsk60ep5rvE7fHVEyLuxQLrsB32?=
 =?us-ascii?Q?kZfsZfMTd0u5gffjHBTIT2ESu6yMYZtpqPbdTHTYsr3jTSCv3g93KnJwedF8?=
 =?us-ascii?Q?9ZsnAkAK+15YaJoCfrrQpvwENXrwCWw/mZU447AG9hmVlkFLamCWe5dVPbIa?=
 =?us-ascii?Q?oKfWVqd4SHW9jhjFM3QeEQnXsoLF8RaHMHuGCD9xhjzDrbH2ND0p3gUDJTkb?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0be193-cded-41d9-e9b7-08dcad78f0ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 13:43:33.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXHYPGlHiUqjfFEGRKKhdD/RErwqLwhPHL9wo3FQKABQlv1ZsJU48tpL6gwrQ+5AdK0IurItk/wVtGMHyiqj67DBeJAyiPebhlpgH5EJBIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8413
X-OriginatorOrg: intel.com

On Thu, Jul 25, 2024 at 04:07:00PM -0700, Jakub Kicinski wrote:
> On Thu, 25 Jul 2024 20:31:31 +0200 Maciej Fijalkowski wrote:
> > Does that make any sense now?
> 
> Could be brain fog due to post-netdev.conf covid but no, not really.

Huh, that makes two of us.

> 
> The _ONCE() helpers basically give you the ability to store the pointer
> to a variable on the stack, and that variable won't change behind your
> back. But the only reason to READ_ONCE(ptr->thing) something multiple
> times is to tell KCSAN that "I know what I'm doing", it just silences
> potential warnings :S

I feel like you keep on referring to _ONCE (*) being used multiple times
which might be counter-intuitive whereas I was trying from the beginning
to explain my point that xsk pool from driver POV should get the very same
treatment as xdp prog has currently. So, either mark it as __rcu variable
and use rcu helpers or use _ONCE variants plus some sync.

(*) Ok, if you meant from the very beginning that two READ_ONCE against
pool per single critical section is suspicious then I didn't get that,
sorry. With diff below I would have single READ_ONCE and work on that
variable for rest of the napi. Patch was actually trying to limit xsk_pool
accesses from ring struct by working on stack variable.

Would you be okay with that?

-----8<-----

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4c115531beba..5b27aaaa94ee 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1550,14 +1550,15 @@ int ice_napi_poll(struct napi_struct *napi, int budget)
 		budget_per_ring = budget;
 
 	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
+		struct xsk_buff_pool *xsk_pool = READ_ONCE(rx_ring->xsk_pool);
 		int cleaned;
 
 		/* A dedicated path for zero-copy allows making a single
 		 * comparison in the irq context instead of many inside the
 		 * ice_clean_rx_irq function and makes the codebase cleaner.
 		 */
-		cleaned = READ_ONCE(rx_ring->xsk_pool) ?
-			  ice_clean_rx_irq_zc(rx_ring, budget_per_ring) :
+		cleaned = rx_ring->xsk_pool ?
+			  ice_clean_rx_irq_zc(rx_ring, xsk_pool, budget_per_ring) :
 			  ice_clean_rx_irq(rx_ring, budget_per_ring);
 		work_done += cleaned;
 		/* if we clean as many as budgeted, we must not be done */
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 492a9e54d58b..dceab7619a64 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -837,13 +837,15 @@ ice_add_xsk_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *first,
 /**
  * ice_clean_rx_irq_zc - consumes packets from the hardware ring
  * @rx_ring: AF_XDP Rx ring
+ * @xsk_pool: AF_XDP pool ptr
  * @budget: NAPI budget
  *
  * Returns number of processed packets on success, remaining budget on failure.
  */
-int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
+int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
+			struct xsk_buff_pool *xsk_pool,
+			int budget)
 {
-	struct xsk_buff_pool *xsk_pool = READ_ONCE(rx_ring->xsk_pool);
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u32 ntc = rx_ring->next_to_clean;
 	u32 ntu = rx_ring->next_to_use;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.h b/drivers/net/ethernet/intel/ice/ice_xsk.h
index 4cd2d62a0836..8c3675185699 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.h
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.h
@@ -20,7 +20,9 @@ struct ice_vsi;
 #ifdef CONFIG_XDP_SOCKETS
 int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool,
 		       u16 qid);
-int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget);
+int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
+			struct xsk_buff_pool *xsk_pool,
+			int budget);
 int ice_xsk_wakeup(struct net_device *netdev, u32 queue_id, u32 flags);
 bool ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring,
 			  struct xsk_buff_pool *xsk_pool, u16 count);
@@ -45,6 +47,7 @@ ice_xsk_pool_setup(struct ice_vsi __always_unused *vsi,
 
 static inline int
 ice_clean_rx_irq_zc(struct ice_rx_ring __always_unused *rx_ring,
+		    struct xsk_buff_pool __always_unused *xsk_pool,
 		    int __always_unused budget)
 {
 	return 0;

----->8-----

-- 
2.34.1


