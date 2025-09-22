Return-Path: <bpf+bounces-69224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D566EB91D82
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66395190428D
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5087E2DE71A;
	Mon, 22 Sep 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mx0TTPkj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0BF265620;
	Mon, 22 Sep 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553525; cv=fail; b=jBsjGtlbnDdvZ/x2Z3TZDZKlkxMSu9SSmM8MFFgkIujh0gMg7Yf1HB46fw5MI4chTSjO6ffaRW+fK6dELC5m4FoIz6xUSPg/BwGz+QJbK320w48ED437X2MumufoKIXQpgmm/TChbd9Aj6GaZt9HQcpOra9rWLPN47js2z0usbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553525; c=relaxed/simple;
	bh=ORozxLKBNfVzlernHL/sjF2VEKsc3ICF6Fyo6yqfHD8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ma8ZobH/u3YG/1fDgw7tRxYprDePEC8jH1pHVNmNUueEpF8KkuMKddL96SYPL4p05mpY3anQgeqJPQR8fs7wYr9XeUk1snqP7J8/HrL+mHx2mG+RV2SfXVaJ47JK5RFHRo0MyOmi9DDtl2zYXjMPcJNmi4X18ToRM5dkvTlrCpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mx0TTPkj; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758553524; x=1790089524;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ORozxLKBNfVzlernHL/sjF2VEKsc3ICF6Fyo6yqfHD8=;
  b=mx0TTPkjpaX1b+cxrx0axfntlgVQtdO8eRj05OORUofNViOD85Ef3i+s
   fMSnlsS1rzNj0kJpEfdkjhLy7/S3BJuYzwUUptHMfvyOaoJA4XK6uzi8V
   QbbFuGzau7JtJkLV62i0nAoRUnGSP40vzzXVF+GNiVFvUZGNB9v5kRbxR
   QwigZjMhEID+7CdUo+udERPI+7j14zimRsZ3HqNLd/EINIuSuAifISCPM
   6zi9MhvheFnS8yFm7cNcZEJ+aESOpArMrlrEWxM04InMCJpOwUfrkOLxr
   gMLmLAuudSNqviVU+hpX8mZu1Y/mGtoUehDrUDg5pws052ep8ijwRB2Qs
   Q==;
X-CSE-ConnectionGUID: br5GmSxmSs2RupVVQTf+yQ==
X-CSE-MsgGUID: +V2B7JdiTfKpbazO1isQbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71922594"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="71922594"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:05:23 -0700
X-CSE-ConnectionGUID: /eSR1QpxRX+CvqAiOjGnlg==
X-CSE-MsgGUID: auxZnjaxSVGxxOCcGMKqyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="180512738"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:05:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 08:05:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 08:05:22 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.14)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 08:05:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwach10gDosCKUnkJMoMdMJWMdUCQ6txM6BVVXTjdnA7hrtXz3odV1o3fbOuKgbXVJSlU9A4huQ7Gv1RughU2wUHF/iGdjc3g4l9O8N8RF1H2xva3wao46AhtwHpHXRsr63pAbDxM7YCspuXuk2l4x4N1Wb65mYQI107btAlmVBgdEQSt5nCgWkPgWSYKe1fIjiIUM0+Pxi/K/6boh1PRpXoI83h95WBb0pB6Tn2rzsb0Uyx3rHUGtOT4mlZlGcZl4tWfaY6P2XsOypt3nkqLEAstVE1uM+Zf5dLer0Q6CvExKL0QVB7KIpmNIW2x7LoeKZvsUCK4Oq6RnzUz5PSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxVkOA/+VPR7Uz2EB+ommZAwJ32gnJU218knTKwETEQ=;
 b=CeW2xwgw9TOsiG9mXku9o112nZwqywfA7V9V3Bm0KOXnWViXJqDJqgaFp9EgDEjRMf7Wr343sknT/Rhgd5cV1tXUGZGSIydFIodhQVpXWXot8DVFTI68IxXuwdp8REOgJQ4twPlsp/Z/6PsPMCceqH9laTrPjUJsAK+d2K9kCE06IUgn3KucAD2CO78ERVp96EEOxyUBuFZGDQu5JgyNCLSTMmB06n7gB2MfkhyRHKNif1dIIvY26i98X+o8sijGRRyuG4D/YSoaPmMDmF92EpKjHWwa4nzEi/GNHL+DgOjx8FIStImlwggKL9fCaYL7K0d5nWD0RtXfLEQYHa+eBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN6PR11MB8103.namprd11.prod.outlook.com (2603:10b6:208:473::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 15:05:18 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 15:05:18 +0000
Date: Mon, 22 Sep 2025 17:05:09 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Amery Hung <ameryhung@gmail.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<alexei.starovoitov@gmail.com>, <andrii@kernel.org>, <daniel@iogearbox.net>,
	<paul.chaignon@gmail.com>, <kuba@kernel.org>, <stfomichev@gmail.com>,
	<martin.lau@kernel.org>, <mohsin.bashr@gmail.com>, <noren@nvidia.com>,
	<dtatulea@nvidia.com>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v6 0/7] Add kfunc bpf_xdp_pull_data
Message-ID: <aNFlpcGxd9yI6qLJ@boxer>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250919230952.3628709-1-ameryhung@gmail.com>
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN6PR11MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f3a64b-148c-46dd-a070-08ddf9e9715d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sg/C84mD2TaqZCUtIsZwpbH7WaxHA5JsM3CfoIOU3vCJCHEQ1k8rIKD99DZ8?=
 =?us-ascii?Q?HRGpeIS4CyfbK8E/Tx1hKQKv6v/wT/riu3BHzFCg027PxQGrgfXSxOj3qcWH?=
 =?us-ascii?Q?+zlXHQrfGQMHmaqy3nS2z1HCxSFlkPM2G0q/NOCIClpt9bPwMWMRpoFOaDMD?=
 =?us-ascii?Q?kdYuf3O9g9M/fWVP2O7OSAM7COyjB/pb1bJ4DEZ2WsLDN6tOejcCshn/AMXm?=
 =?us-ascii?Q?7qBXqv4Z0yBnaZPHYrCK7f924UeWUjW9Xjkp1Rn3UwS7gS862E75utsf2Z2z?=
 =?us-ascii?Q?0ifIfARQmtPcTyzhUOBsbeIJLS/uj5NxrcylkBgcymM7dT3aokB0bgUUSzCw?=
 =?us-ascii?Q?y9GazUVEVuoOJkPv/ETkn6BKH34dhztpCr0PDVHys6bS2gNjkZjn8kc4ZZ/R?=
 =?us-ascii?Q?Z47TzKwQF1t++QaXk2AuHhZdWPeXZbT4uuGIp67Cqr+ps5Oz8sId1Hdp6vrC?=
 =?us-ascii?Q?AwegjYq1Q4sIZ+TtCs8MlFRTP2MMnDT1KhONPvvcBmfqotmZOI8GfOfDnTRy?=
 =?us-ascii?Q?G6VbSHhD9zym1Nfmr1hGqcZJH7fD3SqdFg6AC7L54LeCcKo88Mz0nhiE2zXZ?=
 =?us-ascii?Q?D9daPyofmZITlId86eoZ6l607IpFNo+8i4rGEtcoLQfVN908jS5pZ6XQmimo?=
 =?us-ascii?Q?othg0JbmtGsQPCeLR86Es/XVMCgkS8uaklNziNd0dr2bHvrHUSQIPCWeJJEs?=
 =?us-ascii?Q?sVxmNfY3tsmXJx3/D24THSnk37u074jBe8LA1wOP1DTecO6K1XJO6xxfD032?=
 =?us-ascii?Q?5+pE7rwPm9BLGOKJ67YPOdMp/iW7u9w3ortlb/tzrtyMJ2RDiXuUhD3IIj0e?=
 =?us-ascii?Q?RZttWT/zXmkIRpUZmkyMMlUMO4k740//UJMEwO2PfA/CHiVaquidQireO8TA?=
 =?us-ascii?Q?fQqqY3bLu10C9IBFHaRBQYDrox7kqJlE88tQ4dUYHYZ6uPycXbIXLuZ8MYEi?=
 =?us-ascii?Q?1fSSujzh+ZZfIDJtTo/ARvvbjvnjNoXRIe4qMuE7YD8/SJoM3Ie9851s94s3?=
 =?us-ascii?Q?TZkes7zK3grPTB8/mM1HXkNzFefFP66+u4sotdsBRej28Vg5prjnqMDbj5pq?=
 =?us-ascii?Q?KULBbdcfM/Ip7kzM/zKKZ3kF6QIZCb/D6tuaRvCyo91eYbgXRMagi//7NivO?=
 =?us-ascii?Q?K5sJuYu7ZAOeDb8/ZLOEDZOb8JD3yGSNGVMnS+vDa3pNOm0eGyhBJe3C/Qe4?=
 =?us-ascii?Q?7Uo+ruzRNkgIORjYAdiyvWHXQS9OiXykDyLGmawPGAqRFnVlNko3pYwHHQrO?=
 =?us-ascii?Q?BuS1wULgnFyoAZD7tBHnwosedQSKUUptcWSAF67rJzZ5dTOLwpFTwBlp+E7W?=
 =?us-ascii?Q?h335OROt3IlxmNwXRBp36ib8D/ve61ytFLhrFCJ5IvJWfxEciwxGWgTGQKeg?=
 =?us-ascii?Q?edT2i8v5MttLfq3uecFp4UwaVGME?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIqcdR4RcjGx5Xm+fqOpDi3oH2HJt0Dsib8XYKdiELmrW/2xzfjScMBTsIKl?=
 =?us-ascii?Q?v5JIv4CcrG3GT20EWMW6U4iPbVvQTWPC8Bcy7NZOMoUALD5LJBA/ejI4OZHX?=
 =?us-ascii?Q?CSD1fFwXWad/nx2sOCUTJe65dMI0OL1YGoBCSiAiwhjxUHc3dpTGI1THlTuJ?=
 =?us-ascii?Q?hAQTjY18yyCkZwlFSy2MMzRMPpooINXB3w7M6HJwX19klya0zfAlCX/88IP0?=
 =?us-ascii?Q?slidvsqVQSMIX5yWInez0H1mq/qKNZkOeNbvwHS026Ky8TiJbOvug7pjmeOH?=
 =?us-ascii?Q?cUmMQG6tuanE1qc4ChrxgpMlhXG+Pub/kPlpkAUj/XVQN8lP3SnkN2Tk2HCX?=
 =?us-ascii?Q?aMehOTVYRLkZRuz7fq6odvecHnsubXRMi3U8ei9wy5+UNoTWg6Jl2Lzes/zM?=
 =?us-ascii?Q?k3VFNFpjVxJ+5ys43pgO81haQwSq2ituO34FHJZ9QS9tu9W2djIxFi/GnW7r?=
 =?us-ascii?Q?ooIw8vKbYNXjbAo+V62tjAII5ev5mhiXfqtIVoUEDuqYABBiXKFnMzNpm3Rx?=
 =?us-ascii?Q?VtYo5VPPoRq6uHRY8aqErdIg4GY0VFkGNPOhkhZ2jMXISB25ddIzHCzH6LSF?=
 =?us-ascii?Q?REeOAqpvUwimKx/IW8jRZwZmo+4kc17c71SNrRRsnVLJ8i8DqcJISUYP2OVC?=
 =?us-ascii?Q?jlodGm9FUdPVGPY+sXunqzXSjhqsqSWHEvX9jigdbK0qcuhksErdvlE5O+2i?=
 =?us-ascii?Q?vaSG3T2JPCMX50b5hgGvU/f+ksJ5TgJ3qtu6YRpbvf4eMzWz2WlsXOQisZjF?=
 =?us-ascii?Q?/JaA937v9Qos9/dgwNOyigiy3XxuP7DHP3KVvW+IhjPNx1/zUe9C0a1ZoSjW?=
 =?us-ascii?Q?hUvuSo/HyTWTtm6NfqgTh2+xtCwL45N6UUWh/zLlOmeEiA2VgU1mKY4a0LO5?=
 =?us-ascii?Q?9DP7h26uQYMu1dP9tRvrUnWLV4po7tYmtdZ3tvvfg/bF3ppcUzEQeJIn5/tq?=
 =?us-ascii?Q?mI6Zz2FOfpScbQuc2fBtpb2h4ljQsYuyGoA9TCRFlpAJ5ta0SZtF/7pBNqB8?=
 =?us-ascii?Q?pz1fIjjFx5FsDbGz6JqSesQ2T8sjb3aH96CCFSYV3fVYWgpbH3J+VXF90PSg?=
 =?us-ascii?Q?t4IujILC9GSMODLUp/q3gZJIgiNVM7hWaeY3K59kzhJjhHnoJnww1ido1e9f?=
 =?us-ascii?Q?877658QRlW5Pqb/EHiKaGdoUNui6AjW2wG1G7zDhubFNLvBIgTyW4QHl4+VS?=
 =?us-ascii?Q?U6wMSS58fLbI2GVS3OqPRIU1wvwXAMyWD6x7NFYYfqvWG3hjAmRd9VjEUBY6?=
 =?us-ascii?Q?849ShmwCrcGVhbvlhe1Ru9Mh8q3ko3jcQqg6brf8rRZ4/k7n3ndCyUsCFvqv?=
 =?us-ascii?Q?dp4pjzWaCuApW+0SU40pc9RWj9D1xI1yEnWIMjwHhYeJF9OEYCMJglMw22MW?=
 =?us-ascii?Q?sC25vL6s/4loQj0sn6kGmYvehCp8tYtkOsXIVR99G4+jkksk951PxIL6p53N?=
 =?us-ascii?Q?NlFBLVhzbHPlSJTvW6tJpiZgkycjF0eV96QhtP0EqCYW7n0CbE8kiPIpOJeY?=
 =?us-ascii?Q?ravtKePN49+ssfXk6XE9V0Ew/3UnMWfCQkBcbAmtSb1EDWR0+Jq3FmyYTeqS?=
 =?us-ascii?Q?zRXzq0/2J9SkKywf989c3s1kuP70hCY8Jh9p+TzTKMnJnb4R5+WU0YOTU8Ht?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f3a64b-148c-46dd-a070-08ddf9e9715d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 15:05:18.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcvqFdOAOUC3u2Mej5uyuyxHm3FPKoEpVJHyYpaI8ok7kPWpMSWpn0Os0CIdSTd2+xZmjpWBdM42knNqXNBMW5E8clcvnEj1KxOPgAg+1lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8103
X-OriginatorOrg: intel.com

On Fri, Sep 19, 2025 at 04:09:45PM -0700, Amery Hung wrote:
> v6 -> v5
>   patch 6
>   - v5 selftest failed on S390 when changing how tailroom occupied by
>     skb_shared_info is calculated. Revert selftest to v4, where we get
>     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) by running an XDP
>     program

Hi Amery, could you shed more light on this? Would be nice to stick with
BTF approach as it looked clean to me. Was this due to SMP_CACHE_BYTES
being different between archs?

> 
> v5 -> v4
>   patch 1
>   - Add a new patch clearing pfmemalloc bit in xdp->frags when all frags
>     are freed in bpf_xdp_adjust_tail() (Maciej)
> 
>   patch 2
>   - Refactor bpf_xdp_shrink_data() (Maciej)
> 
>   patch 3
>   - Clear pfmemalloc when all frags are freed in bpf_xdp_pull_data()
>     (Maciej)
> 
>   patch 6
>   - Use BTF to get sizes of skb_shared_info and xdp_frame (Maciej)
> 
>   Link: https://lore.kernel.org/bpf/20250919182100.1925352-1-ameryhung@gmail.com/
> 
> v3 -> v4
>   patch 2
>   - Improve comments (Jakub)
>   - Drop new_end and len_free to simplify code (Jakub)
> 
>   patch 4
>   - Instead of adding is_xdp to bpf_test_init, move lower-bound check
>     of user_size to callers (Martin)
>   - Simplify linear data size calculation (Martin)
> 
>   patch 5
>   - Add static function identifier (Martin)
>   - Free calloc-ed buf (Martin)
> 
>   Link: https://lore.kernel.org/bpf/20250917225513.3388199-1-ameryhung@gmail.com/
> 
> v2 -> v3
>   Separate mlx5 fixes from the patchset
> 
>   patch 2
>   - Use headroom for pulling data by shifting metadata and data down
>     (Jakub)
>   - Drop the flags argument (Martin)
> 
>   patch 4 
>   - Support empty linear xdp data for BPF_PROG_TEST_RUN
> 
>   Link: https://lore.kernel.org/bpf/20250915224801.2961360-1-ameryhung@gmail.com/
> 
> v1 -> v2
>   Rebase onto bpf-next
> 
>   Try to build on top of the mlx5 patchset that avoids copying payload
>   to linear part by Christoph but got a kernel panic. Will rebase on
>   that patchset if it got merged first, or separate the mlx5 fix
>   from this set.
> 
>   patch 1
>   - Remove the unnecessary head frag search (Dragos)
>   - Rewind the end frag pointer to simplify the change (Dragos)
>   - Rewind the end frag pointer and recalculate truesize only when the
>     number of frags changed (Dragos)
> 
>   patch 3
>   - Fix len == zero behavior. To mirror bpf_skb_pull_data() correctly,
>     the kfunc should do nothing (Stanislav)
>   - Fix a pointer wrap around bug (Jakub)
>   - Use memmove() when moving sinfo->frags (Jakub)
> 
>   Link: https://lore.kernel.org/bpf/20250905173352.3759457-1-ameryhung@gmail.com/
>   
> ---
> 
> Hi all,
> 
> This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
> pulling nonlinear xdp data. This may be useful when a driver places
> headers in fragments. When an xdp program would like to keep parsing
> packet headers using direct packet access, it can call
> bpf_xdp_pull_data() to make the header available in the linear data
> area. The kfunc can also be used to decapsulate the header in the
> nonlinear data, as currently there is no easy way to do this.
> 
> Tested with the added bpf selftest using bpf test_run and also on
> mlx5 with the tools/testing/selftests/drivers/net/{xdp.py, ping.py}.
> mlx5 with striding RQ enabled always passse xdp_buff with empty linear
> data to xdp programs. xdp.test_xdp_native_pass_mb would fail to parse
> the header before this patchset.
> 
> Thanks!
> Amery
> 
> Amery Hung (7):
>   bpf: Clear pfmemalloc flag when freeing all fragments
>   bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
>   bpf: Support pulling non-linear xdp data
>   bpf: Clear packet pointers after changing packet data in kfuncs
>   bpf: Support specifying linear xdp packet data size for
>     BPF_PROG_TEST_RUN
>   selftests/bpf: Test bpf_xdp_pull_data
>   selftests: drv-net: Pull data before parsing headers
> 
>  include/net/xdp.h                             |   5 +
>  include/net/xdp_sock_drv.h                    |  21 +-
>  kernel/bpf/verifier.c                         |  13 ++
>  net/bpf/test_run.c                            |   9 +-
>  net/core/filter.c                             | 135 +++++++++++--
>  .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
>  .../selftests/bpf/prog_tests/xdp_pull_data.c  | 179 ++++++++++++++++++
>  .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
>  .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
>  9 files changed, 463 insertions(+), 40 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
> 
> -- 
> 2.47.3
> 

