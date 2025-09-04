Return-Path: <bpf+bounces-67430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9B0B43A27
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76FA1C21D8B
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64092FC030;
	Thu,  4 Sep 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7BMGwI6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210522D7DDE;
	Thu,  4 Sep 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985492; cv=fail; b=YZkwNcPwAn3zZXujpj37MYie10G4gki178cwRyVmOiVmQXlE3WwMUfNJYgjDKfAOnlhk7nop5yzAbpyZOYJFGayo34/gbzciXCGCiVjrekTh1v5DVt372pJvjE573VdR3vVTwRDd7833xCmmmZqI0qiwyTnyatEWQ/SsDI6fgTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985492; c=relaxed/simple;
	bh=UAymmJbcFyJkCiHzM8I1oGIbbUdO4StgxIoY/WetInI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q4tED4Ye8cP1h/SiXp1b2mqzEnhSO2c0mF9yCduEOpVAb6+m/grC9u9fEgLnG6nT6RVTjZSc7DaFir1wTFrrsvWimA9Dl7W60rqku78zDZ4js5jJNiVPlnJomee7ENGj+9AE2LePfP6dEGudJEJxS4oSgWizIbMf3Gp7wMPO3s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7BMGwI6; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756985489; x=1788521489;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UAymmJbcFyJkCiHzM8I1oGIbbUdO4StgxIoY/WetInI=;
  b=K7BMGwI657vxo99xLdSGA5IlpmRHQsg+z63QYYuGvtea0msWbwBfgtO7
   bVacP/K/tTDwlmWd1JXANQcV+Y2/iU6EHlIW0QDD2tYXMSJ9qQfyn6Ss2
   ze6FBLidMRGZLuKCUnFtSsgorO3BfaRfg8H0klfbzT0RIyV80z0Gr/7iL
   10v6pTTxWEmlyrNqm8LoZ+TU5WOTntIcw1UUvu3tjOSX3quVuPa2I+Gbz
   tas0wnljUi8wuedPWCPt4E4DvCZMG4mZ2sLd3c+/yR/HcbEEZpmY/8bJY
   dGpRTjbW1utQbUj3jgq1cUwwlBgrJxTHB4yLagcNnvozeVTFFGkDE3bMc
   w==;
X-CSE-ConnectionGUID: rHbMQ8jGRyWwxtQ5CJS15Q==
X-CSE-MsgGUID: c5QRTpJwRd+fRFBtSes4NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70748265"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70748265"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 04:31:25 -0700
X-CSE-ConnectionGUID: REkGbVMMR6uWqKECqwc4NQ==
X-CSE-MsgGUID: ZWzDKTsQQTSZmr9u1FLFSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="172237726"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 04:31:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 04:31:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 04:31:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.84)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 04:31:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJf+k2MVkNoB2Ky3BhZmzg+FsAAfaEh6I7dZWY81tt1/qQJNCMINDczZFnZs6zEm2gJGs4Yz0DGP3qE27MTzmvy81GZcL7TDMo/HTxKcr7fI+JhlKTHdI4GQb8vkzdLHAi3BlOjS/Pm6zXoWPAGUaKuoXl38iILnt/7KZzwWDJKl+yW0NC98diHX3g/Akntis6SBfs9xJRGL/ZV1emA3549n4siL7kC+SP3SJ7xypCHG45Y/rTUdf5fLQj2+dNDtATfyA4oIWsNOtDQoOsBj6MKUl+pw3KreIoykzgvbphFUqUoFtOXVa6Ns3r9+PsDM78P82yb8xytzGrdWhEbkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCFXO9J3POjFo9eSYGfAOQjTy/d32YtmlGHFyfBnwkQ=;
 b=ONgHVqh/tSCdEKPOdcc1dQmW5ibqlaq11JFDfFVFdZM2tFtpeE2590+RDaANHokEkk8ILEVgaVSITE6ul8mW5KtSsWpNJIEbm0UQkXewAow7t6gcSGzXMd+SQNw3IfCQ1sHUJJkYscu/k17pzv7/X8HDPRXZbbVkjCj8QIEtD4noN1Cxv3n0coBXJsEvNyUilBnyqWRGk4Eok/mPcqJuAf8X5YcLTrE4IU7iDRKwGXKMIsHomdHVT8ch5JN+J1e1Y1LVqCgVX5mIsfhs+sYioyFDQxRoc5CLtM0YXqTtU2kORkEH//0jMKCBruJ9l6mbZOo5w5ovaewXFTLVoQA3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB8320.namprd11.prod.outlook.com (2603:10b6:806:37c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 11:31:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 11:31:18 +0000
Message-ID: <07646dce-dab4-4afe-a09a-e6a83502ac30@intel.com>
Date: Thu, 4 Sep 2025 13:31:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf] xsk: fix immature cq descriptor production
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: kernel test robot <lkp@intel.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
	<kerneljasonxing@gmail.com>, Eryk Kubanski <e.kubanski@partner.samsung.com>,
	Stanislav Fomichev <sdf@fomichev.me>
References: <20250902220613.2331265-1-maciej.fijalkowski@intel.com>
 <202509031029.iL7rCVvQ-lkp@intel.com> <aLlcgDC7s3Dh0NdX@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <aLlcgDC7s3Dh0NdX@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::13) To CYXPR11MB8712.namprd11.prod.outlook.com
 (2603:10b6:930:df::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1c8b9f-91f3-49d3-721e-08ddeba6901e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODdxS2VmSGVzVkdXZHZtUkFjNVBJVzZCKzkzZVk1dCt1M2RHdnpqcllLV0ph?=
 =?utf-8?B?clhJQVcyR1hkWWxTUGIzVGdJTDJqckFsZXFDMHdmRkUvSThJVmJFUk9pZSs5?=
 =?utf-8?B?WlhMbVBONmdENGtVSkJCVUhNdUpKcHJRSUJ3Y1hBOHRzUVNrV1I1RU4wS1dY?=
 =?utf-8?B?ZngydEtaejZkTkNieHNSR1hJWU1NZUVkN1JtK1lLM1JtcW4xWkEzU0pLN0F6?=
 =?utf-8?B?R2dYcDdKSHlSQ3oyMWtJS0pSUDVDZW9Sd2R4c3lxRmVEU2ZGZVBtMTJPOGhN?=
 =?utf-8?B?RkxBRmdmY2VWY0hqZnhqSGZSYU5mVGh3SnpFL1Uzc1ppZUVqMmk4eVRsVkI2?=
 =?utf-8?B?YnJLR1N5ZDY0Vml4TmFxZFQrN3B4cXg0a055RUkvSVRMMGp2OGZ3Z3IyWWVB?=
 =?utf-8?B?NGRCM1RuMHI3TUVsN1RnNW15VncyeHpvbVdYUmpGT0crZW4zQlZ5bmlDVkEr?=
 =?utf-8?B?azFPWklKWkp6ajJZK2h5Q0pJSklneDBiL2p5U2JoWjRQeGdvVXd6eWtjZWVH?=
 =?utf-8?B?Z2ozUHczcm9CU2JRUy9zc25LQkVZaStUdDBoN2xoU1RPVlFsaWFNdzdzdE1X?=
 =?utf-8?B?eWZ6Q0dqZ1NUTWthNGt2QUN3SjlJOTFVZC9rNnpsK1FTWGF3Njc1blpWcnBo?=
 =?utf-8?B?MDdjc1pyOVd1aUVQQVdVMWdqTFlkeWhCNXRNcjlyTHVYUkZpTmFzY2FtZTIw?=
 =?utf-8?B?YTVYR1FWK0tHYlEvbWNua3Q1Zk9ORTIzaU9rWUlLYUphK3lDWG9jQ1BmUkZN?=
 =?utf-8?B?cENaU2FSbVdJWTFIU0x2aUUzMFJVV1h2Qldnc2VmWWFtNDVIcnYxREswKytl?=
 =?utf-8?B?TVdhQmxkdVNvTU1hTHB3b0hIdlZCUDlzUUFjWnpXYlF0N2F1ZFAyd1krdk85?=
 =?utf-8?B?b1E2VGJna3dKZmdRZ2NPcjRkdkVibGQvaXRUZVNkYnFGVWx6OFY3VGJybGlL?=
 =?utf-8?B?U1dLZ1M0ekZ2WmdZN3E3aG85OXNsTUdaNXpLVzZJRW0xTEhMb3lzMHg4ZStT?=
 =?utf-8?B?WlFMMWY5TjlrVXBuNWEyYndkazJMZmN2ZDgxdDV2bkQ1K3U1b3ZMUWRGYjZU?=
 =?utf-8?B?WWJrcVBQb1lWb2xnODlob3B6YVM3ZGhiUXh3L0lSbzE4OVpISXcwK3FHY3RW?=
 =?utf-8?B?ejV0VmpIbVd1bDZJOStmM1E5VjBVOUhUZ3FrL1JjdXhCOVhwbXhCemFwdWJv?=
 =?utf-8?B?WUpCazBnbjE2TUtUQnh1RDRGTTFIUzltRlgrRjQyNXVKeXB1dDVOUk9PeHlw?=
 =?utf-8?B?OWFKYnRZVjc0Z3ZNeHZGS1hJNzViVFoxanpEdEs5ZHBpVjdGQWxLTkc1TzEy?=
 =?utf-8?B?eFBTMkJ6cEI3WWhkMEdSM0locXMvV2Qvdkh5VjEydXRMeXN3SUtOWDMzemVa?=
 =?utf-8?B?N05aelFYZVRJYnBiSGllTEUrMEV0c0xHOWd3RE5FamJTTW9qSm0yRUdGalI5?=
 =?utf-8?B?ZWIyMEt0TWtxbG93aE96Y0tnbWxtSW1SeElSYUJZQ0lZaWUyUldxOVltTmpa?=
 =?utf-8?B?YWZ2WFcvYmZ2cUpjMU9yd2k4dDhzNGVtSHRhUEx3QlFyOFhwc1BhTXRIMFg3?=
 =?utf-8?B?dndGeERTUGhpS243Q2dNMmhBWXIvK0haTVhhZlJSTUVYSTk3MGNZbWlpYStl?=
 =?utf-8?B?QnY0dmtOaDFwWWp1amkvYys5WHlqSC9XSzdzSkVjTDQ2Z0pRRG9Ibmd2b3ZI?=
 =?utf-8?B?enhHRkFNTFA0REZVVjZDZk9aS0JCVTdDQ0RCeFJoU0dCU0k5ZThyV21MYVQv?=
 =?utf-8?B?WmVLdzFnVTJUdzVMVnkzejhnQlF1UU01enJLNWpselV4MDBodjNBNVhYUzNZ?=
 =?utf-8?B?YUhIMXh1b0JER0hXd2c3c0l3NmpodW5JTjArSVgwYWUxaktFb21sWGlDaDhJ?=
 =?utf-8?Q?kiljxCJVB0XYJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2xSZ3Rmd0VlS01UbzZWT2pUSG9TM1hWaDQrUmRsRElxcWlSTXRxSStyTWNr?=
 =?utf-8?B?alNzYmlxL2VDb3l3MUY1VEcxbEl2UXFBRVRRZDlxMVpIZUcvclRXOWRNZ3J5?=
 =?utf-8?B?c0t5S3FKbnBlRWFyVFc3RlJTSEFHelBJY3BvN3FWc2RxL3BTTHhUSUNCdXgy?=
 =?utf-8?B?R1lITHZjbk1qZ3VWWWx5MW82K0YvM2huYnBLTDRFczc2eGpzeEVTQzJleHBk?=
 =?utf-8?B?Q1RPZ1hibmVsZEJaNVJKM1hzak9CVlRualZuWlAvbU9FSjhkRk5MWmdBTDBw?=
 =?utf-8?B?dkNuc2tKZGlyRkVJR1czL1BFUmZyeFpyQkZ4YnVtVWxjbFJyNW44K29mU0M4?=
 =?utf-8?B?T1VzTWY3ZEVobWlyTlFTalJrajdoRUIxMk1kMmkvbnR3aDJNOFJMbjM3RWIw?=
 =?utf-8?B?MFhQT0hBb2UvTXdUVkswZmhHY0xSRFNZTHZhRUxHQWlDQ3BuNmFVV0lLc1N1?=
 =?utf-8?B?MzA1cGt1VGw5V1Z5TG9Vd0dBZ3oyRjNWMC9XaDQzcVdkdDAzVk4zQTR0RSs0?=
 =?utf-8?B?WnNKdlUwNW8rN2NwcU9ESkpmTllRa0xUZmk0bzluMy9kV0dIU09DR0EyeERx?=
 =?utf-8?B?SmNHVXZ4Y0N2RExJaHNQcENYdUx4KzM2OHFHd0UwNXNpWFhnN3RjUUJFY0M2?=
 =?utf-8?B?NW9ScUJqb3UzV3Q1cThlZENRY0NncmRjSlFvOVE2b01HeXErQ2c1VVlHdFdI?=
 =?utf-8?B?TFFrU2FPd0VSVVJDWDdvYmo4dXgrbnJtWTRWTkkvRTUwNXpRZlQxNHJFNzBa?=
 =?utf-8?B?c0plNGxDUmQ4VGpYUlBlYUo4M3VSR3BsYTdpWHNmNVNLYSt5ZnN0VTk4eGVX?=
 =?utf-8?B?STMxVVY5bUFUeDBub0JXeVdJcUllYm9UR0lkSHZoSHNubm9QTEJqY3hCRWNT?=
 =?utf-8?B?MUJ6RWtBNHlrL3dTMW9nNGhVRGlRZzFFcFRIUzdQNFVqS1ptZUN4bDA1aGFz?=
 =?utf-8?B?LzZRN0JPUGd6ZFNNY2ZBQ0Z2a3A2L0dpTE9xYm5GZFUvS3lyU2lOTExvbzk5?=
 =?utf-8?B?U1dPWENFVUZtRlcrSThDODY5bTNHdXV1SHpheTQ4eWw5NUpiemg3Vm4rdU9h?=
 =?utf-8?B?NTY4b3JTMExvUEpObm01TUdabUowZVBMakFjMkxZQWN4blVYUGVrQVZnVCtG?=
 =?utf-8?B?aVljeDhWd2NXTWFob3psR2JwMlU4bGZpbHF1UFc5QkpCMXI4Y2hHSXVJSWhz?=
 =?utf-8?B?RkRQZFk4MEYzWXBxYkVzWU5qVFh1L294SWE2ZCtrSmk3dkVhYm00ZlJIcEFi?=
 =?utf-8?B?NmRuRkZnVTRBdTFHTlBvdjZlRk14blR2L1B2eTNyQ3FheEl1bG9rckh2dEh2?=
 =?utf-8?B?aUhKcXh5dldROC9USE9ueW1acUZrYWVqWkp2TDBnb0JqTWRHSlNhQUtWU0NT?=
 =?utf-8?B?SjhtRXBJaFMvRjVjcnBuczIxczJ5d010WXRaY1NpeTRkM2pTcCtqYWt1MjJ5?=
 =?utf-8?B?ZTN6ajM4QWlBZjZETk85K2FDcHpta3QrWUVmM2FQWVdaSkpSQlNEa1kyeEM5?=
 =?utf-8?B?bmZETDRGMWdMYW1nVGF1SkxyUCtGbHlJMEVKai9aeEtKUVhOZ3BFY3BhT0Fq?=
 =?utf-8?B?UzdWVWhBWmlpTHlnaE9JRjU3d2NVTThLN0VWUE96QVJOd2dUeWFzUHR4Z21p?=
 =?utf-8?B?M0laWnU3RzFxL3pTeHlGU0h6a1NPVUxpVnFKUHRFZFVzWFNKTXNnMzkrcXZV?=
 =?utf-8?B?U3JJQnVNaG5RanZwYUlJcGdITEZjbG8vV0dwZzNsbEtzMHZadFNZOVRvZFoy?=
 =?utf-8?B?OURNUUx2NzNVT29MUGUrTURLaVRuVXBVeFY4Q3ZhemJIRk5uWkhpU1E3YTY2?=
 =?utf-8?B?d1JJYnFQYkI2WWlSeDZ5cThTVDBvM05WYWpTamt0a2t2Wm5kNlJaZlFEMnFn?=
 =?utf-8?B?alFuSGxIeUxVdHBmbHhPYVpGRG1vTXJZRTFaYXVwdXdpVFpKUUt3cW1hNUli?=
 =?utf-8?B?VkRPVklIMXVEY1lBWHdreFJwN1l6SWxFNGtqcHlWS0VuQllYOTdCL056a1Rm?=
 =?utf-8?B?aSt5TitMYk51aC9mY3BNSkE3RUdxUWxxWXc5YnFnNlNDS0wzRzZqWDZaQ1Bl?=
 =?utf-8?B?QVN4SW1FaEE2bTAxK3lPUTgwWVdKRjMralVQR1liZ0tyc0NwVkhhYTJhQzFR?=
 =?utf-8?B?Zy9SN0VDNmZiNlJ0blJhYmM3S3BPcW50Yzh1SnlmTUNuWEtoSDNjN3h2N2hx?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1c8b9f-91f3-49d3-721e-08ddeba6901e
X-MS-Exchange-CrossTenant-AuthSource: CYXPR11MB8712.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 11:31:18.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66S/oNicD5/uEqlnOScHKsmJI80ghNE6nFK7unB4pL/M3tcv/XIvuX3/O9LSf4SRqMf4mIFF5fLYe7HGyJ0BN5pOwwC6rONSB2Z4/HTbYHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8320
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 4 Sep 2025 11:31:44 +0200

> On Wed, Sep 03, 2025 at 10:29:02AM +0800, kernel test robot wrote:
>> Hi Maciej,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on bpf/master]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/xsk-fix-immature-cq-descriptor-production/20250903-060850
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
>> patch link:    https://lore.kernel.org/r/20250902220613.2331265-1-maciej.fijalkowski%40intel.com
>> patch subject: [PATCH v8 bpf] xsk: fix immature cq descriptor production
>> config: riscv-randconfig-001-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031029.iL7rCVvQ-lkp@intel.com/config)
>> compiler: riscv32-linux-gcc (GCC) 8.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031029.iL7rCVvQ-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202509031029.iL7rCVvQ-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>    net/xdp/xsk.c: In function 'xsk_cq_submit_addr_locked':
>>>> net/xdp/xsk.c:572:38: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>>      xskq_prod_write_addr(pool->cq, idx, (u64)skb_shinfo(skb)->destructor_arg);
>>                                          ^
>>    net/xdp/xsk.c: In function 'xsk_set_destructor_arg':
>>>> net/xdp/xsk.c:625:36: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>      skb_shinfo(skb)->destructor_arg = (void *)addr;
> 
> Meh, I suppose uintptr_t casting will help here.

Correct, you need a double cast to convert u64 <-> void *, see [0].

Maybe we'd want to make those helpers generic in future...

> So I'll send v9 in the evening :)

[0]
https://elixir.bootlin.com/linux/v6.17-rc4/source/include/net/libeth/xdp.h#L475

Thanks,
Olek

