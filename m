Return-Path: <bpf+bounces-42288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA219A207F
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 13:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7942883F4
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 11:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72A1DB548;
	Thu, 17 Oct 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUVh+WBJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E8F259C;
	Thu, 17 Oct 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163034; cv=fail; b=FEEzqiH7jhmGwh4/hLZ7qx2/Lpq1wnpjqVzxCkLZ6Daw7AE1prbZgaQshi1opY0M79jiaHQ57jpufAhGw+wgu98wtDMpkTDrhpwWXdfX6H2ZNVYhEL8UX6+Lq63m2aPCqmXIRi+AhBwUrF5HQUbwvzxEAR7R4mTJsOf50v8weO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163034; c=relaxed/simple;
	bh=d/P2jy1Gv09ur5rqioxk+wwqBMB2comEWapwTRpHhuQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G/iE82rJpxvQoOVTvV2/GAlrLWEJvMHqwRar5Rljd47rtBDIh8ycCxuElnOEGi5X1ZlgWChqOs659n4BkT7E1l48VX92inLbe/mStFJ9Bg/T8hzKF5smOKiEcJiKzsETSBLj6+bRIq3b+4yms1/QlYAhcSg2oYDQD/10gR0FMS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUVh+WBJ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729163031; x=1760699031;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=d/P2jy1Gv09ur5rqioxk+wwqBMB2comEWapwTRpHhuQ=;
  b=RUVh+WBJOHyozEh7MWvJT9TQ/gYwRFEmKkONyhRe5ytDZFTQX+YfhcHc
   0UNCKl7aq1qYaWD8YilRikDZhsZ/TDyPN6T7091DbU3eoli60BcPzhNqo
   7Yoh/WHmYhauJ9JoWIkpW2Y6vOcbvn/OZ9TsGbzHmF4n0XIXYiD9QUtTC
   Ix/Rw0BuZmFBc7rRQhp9ufHJHniY4ByPPsilKPQCqSlfAQP+Jd0CzoNZo
   9S/zb4NZYGwDuk3dvCacIg48Y0jmAxTipu2C/A4utapezu0ZzXZuzYlxE
   bD9eWRbzVi3Hsxx7hyx+F71UBRRkmbo0lVuCXkTg+im1RMQQq7SZw5NrG
   w==;
X-CSE-ConnectionGUID: RShwpHg8S428RWVyAT2dbg==
X-CSE-MsgGUID: 5WPjFKPfSDeA2z94VAw2wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="16261302"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="16261302"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:03:50 -0700
X-CSE-ConnectionGUID: wJK+AluuSoy4AHTGUhy3mA==
X-CSE-MsgGUID: wHo9E0n9RgaLXK+x5cVZGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78552996"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 04:03:50 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 04:03:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 04:03:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 04:03:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 04:03:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 04:03:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHnAGCkCSSp+f9JwUKNzMqcVRADaOW/Rdg9Q3zJQm7H12L2lnYlVa0gjpQABsA/DPTAgnahKyU0FFUg8mm7eJPBE7PMMGd2DicVYZis7Sdsk0eOuPJuuQakZxGoDTJgtkRzw3mCCR/oT6wdwjgyt+uQT82QJovfiR9gq4u4No7TfhEAiat0BSTw+4B3PKBCHO9hHxwMHgwgNzx2mKlWgUKpMRPCKoOG0dD/WOH1u9vqYgTkcUsgaCva/QcAm0LkHd1uf09c7eUMfclNuikcqEeiNen/G6j01XOA5qGKCsOZobAP+U72D/90YZJMl5Y1Gvp0xEjDRyrEC8gjFhNl3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1kGIj7vgaFyHyi4lOnQdRIhhZIHoVut51L3inYo9Lo=;
 b=K8wewjugpSI94IgAhLZmgOcRu2Zi1gT6r8JyW6/F67L+sy3b3UCn7q0Y9SclJVweXUkzBQb3A+9JUz7uHIm0MY+fzgHxB54AjvQeS9divG8oT4holxK2+3Fx+AhxLJ5f35Ze9+xkw3tUEs5gkuOicd8YhMyT/2IrbJFZ168NR+z6y1IXVGoH6ULDxvW0twfb1M1WhHWz7VvYky+v2REHnUP2JAiNzBgSsb8VSdrak/sFWZDwy87RBtToQq5nK4NHTqJDMjxyIxnhv2T5P2kj3Ar+rVSDtAUfS27Y0U4jZ2M7xRBP84cNZOOvMBbwydVvGjbzKOaJZ6ZwRn61k/BFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Thu, 17 Oct 2024 11:03:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 11:03:46 +0000
Date: Thu, 17 Oct 2024 13:03:38 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Yue Haibing <yuehaibing@huawei.com>
CC: Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<andre.guedes@intel.com>, <jithu.joseph@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, <kurt@linutronix.de>
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix passing 0 to ERR_PTR in
 igc_xdp_run_prog()
Message-ID: <ZxDvCoAo2puufMiH@boxer>
References: <20241016105310.3500279-1-yuehaibing@huawei.com>
 <20241016185333.GL2162@kernel.org>
 <8e4ef7f6-1d7d-45dc-b26e-4d9bc37269de@intel.com>
 <f8bcde08-b526-4b2e-8098-88402107c8ee@intel.com>
 <672730fc-2224-d5fe-87d0-7dc9b00bf207@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <672730fc-2224-d5fe-87d0-7dc9b00bf207@huawei.com>
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8cd4f2-28c1-429d-ed2a-08dcee9b5ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnljQTdpL2dYaGovOEhVTzEzNjdiVVVQSmxEZm5lWmQ0MUNadXdXZ2ZvUDda?=
 =?utf-8?B?elk4M2g2MEZ5U3dVL3BtTGNyZFhjQUNHU2JLakxHVElWR3Z2ZTdjSUdzK21N?=
 =?utf-8?B?ZHJRWVk0MnhBVVo4RGh3RWtsL25MditqMC84SFF4RHd4TFBTMUZwTG4vdnU4?=
 =?utf-8?B?cEUydzNsSUsxZTFaYUxsbXY1cERaU3VzQXBhbjR1MEFobjliZTFnc25hWStS?=
 =?utf-8?B?Nit6VmtVbzNIYlpxWVc3K0g3WUI3amdNTWt6ZmJpKzErRkRLcmdLamkrY2d3?=
 =?utf-8?B?RDVWMGJZbVZMbWZyTHBBTE5adGVNY0ZQc2V2dlpZVUkxeTZ2dTExZGVJMmZh?=
 =?utf-8?B?RVhvcExTaGNtVW5GczR1K0JiMVI0clQ1VnBjV3c1OHU2ZXVwa1VkQy9GSjBJ?=
 =?utf-8?B?K3VzSFgvVTlxRzY5VFRnbVo1NDMxeFpqdmFocjh6bDJnWTFRSUJ6N1Z2U2d3?=
 =?utf-8?B?T3dIeksyTWNJdXJtVjE1RHJjcmhHcW9MbVBTZmNHcFlkOU04M0tKZDVIM2xG?=
 =?utf-8?B?VFNqbEZZRytzMy9QMW5Cc0k5TS9wYnE0YURqd25VZzFnaWlsQlB3aHJKUmFS?=
 =?utf-8?B?clRKbFJINXRHZ0NvdkhLbHJQaEhBeTI0MXdzb0t1ZTNZMDZ0NmNmbUJBK2tp?=
 =?utf-8?B?WE4zZFpDamEvVmtjQkNKdkZxMFcyMEVJSUZPYTJXMHRQV0J6SGNrbVRUTUdI?=
 =?utf-8?B?dC9rMnFKbS9FV3B3TzBTaGd3WldOSnJ6VXg1RHllNDZ0YTZuVG5GYW1qaDZt?=
 =?utf-8?B?Tit1bDlrd2JXUkVPNEg1Mm1tam95dzltclV6MElyVzI1NVZtTFhFbThiSElE?=
 =?utf-8?B?VlFpZ2tKRnBkUjRNdXdsM3RUQ1hGY0kzbTVIZXZpa0UvaWdnanhZQ29oMGxZ?=
 =?utf-8?B?SkJtV3dtb0I4eFRUaVdiRUNXV3dUaExLOWs5Q1cvRmZyT1hFTlFBeFVTME81?=
 =?utf-8?B?SS9OTEgzSnhiUGQyVU84SGVXekJYNnhpb0RadlgzRzRsdHBIYnpjZ2lnVXkv?=
 =?utf-8?B?NmgvdW5wT0VDbU02Q1UrL2dRQ3BpaFA2STg0S2J1RHF5c0NzbEhHN0t2N1Fm?=
 =?utf-8?B?NzJwQlN5OU5HSlVwblNLYm9BMUdpSmltaVgrK3c3L0FwNDArdlg2Uk5xL0R0?=
 =?utf-8?B?bCtObkxWL0Z3azZYdWlCUjF2UHRuaGRGMFd4SHI3NGpmSCs0Rld2cUtrRlRi?=
 =?utf-8?B?R25QZDRZZVZPVUxoNmlQdXVFNDI5WlZnWDRqSW0vY3lEbk9PcHFJcjNodGtq?=
 =?utf-8?B?c002eWJKM3VPQWVhWFFrT0pzd3hqUGYzdXlYczc1SFB6TldsYmpkaVNVeFlW?=
 =?utf-8?B?NW5qY1oyd2grWW5IMkM1eUl4TkJObVNVQWlNMy9LazFvVEZzYVhjNWw4dUhx?=
 =?utf-8?B?WGtZOW5hdSsxbGxrYnI4Mnlma0RZSEE0SG9nZjZYWVR3YmhQY3BEMDdwanND?=
 =?utf-8?B?QW1JQStuWWIrS2dXdS9JV0dsenN5RHpWQm13OURJL3p5Q0FKNnZtUExaRDBN?=
 =?utf-8?B?ZWJTWXJHeE1lN2ttb0EyN2ErY2lva1g2czJRVUxFTFp6bGVZNFJYa0NSMWJn?=
 =?utf-8?B?TTIxdEtYZkt5eHdvUkg0ZHdoY1hZbXlIVVE4SEhBVkhQTlprS1RwZnBuZitT?=
 =?utf-8?B?S3ZxZHdWR1E4bWx5aDRBNlZ0MXpWRlliVG5yaUJ5SnJ3eWIrTW9qVmEwMStO?=
 =?utf-8?B?c2JvSXZVSCszeW0rbXRtZjltVjNRVkJDYUFlK2JRZjRhM0ltdG9LaHc1SlA5?=
 =?utf-8?Q?j3P5i3IMTVWgWIfPqKpA3IqU+oEUL/1hQJYUo60?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVpUTnFaZ1V0alZyNlpqVXJlN1Y0WVhVRXJjeUtWZUJzVzZiakwydEI1MEJo?=
 =?utf-8?B?STEwUElDRGtPT2ptVVhLVFErUDJCSWZnbkZORmtCdUtJSHhzQkhMbzNxY1E0?=
 =?utf-8?B?am92UHBRSTFSM2xPMkRxdjlLV0hiOFllVjB5RlUwTDNiK21lSGZKVFJMOXdv?=
 =?utf-8?B?bVZQT3V1M1pVUDBscXA5WUVhZTdFZnJibnFoSkVtOGV4eGhDUEFsVFFIbnJH?=
 =?utf-8?B?OWlCWm1CcmZTUzBwNDBzUCsyVVRvQzZrWno5aHkrQytwTGxQdlRuMUVIZS9I?=
 =?utf-8?B?QTFaRU9pRE1vZGsrampHNlpzOG1uZ0tNejNFd1BOSTFlYkxJRVlWYkJaQTRw?=
 =?utf-8?B?L0d3bkVYVldCSllBV05WOThBaEtVeS9DL2IxSzRMc0FDWHJyd1luWm9jU3NR?=
 =?utf-8?B?KzZZN3BTNTZ3R1dES2N4UklFbUMrY0VjUEUrSjhFcGJNbmljb1E3dHNXdXdw?=
 =?utf-8?B?Ujk5Z2xHRXVTMzdxTXY4amdZMXZjNmIwTHFINDF2eHdqQjVUc3JhM3pha0Fh?=
 =?utf-8?B?ZGNHSitkRGZnTktoenMzL01LMkIybEQzNHd4S0srQ0g5ZWE0NEZQYXBtNmFo?=
 =?utf-8?B?dm82WHpUSnFVejZHOFFTbTlxZ1M5RTlhQldQbUhEY21QL2RrTGZRMTNHczFQ?=
 =?utf-8?B?WCtUZVZmU0YwUmkyKzdzbDkrN1VPQmFzc2Nib3hMT21Fb2tGN3hWMWp5ak53?=
 =?utf-8?B?anQ0VmdLMS9JZ3VDRi9NbzJkaHdONHlDQjJubmt6ZUNpQ08xVWtwWGduYjJ6?=
 =?utf-8?B?b21OQ016akpQQnlKTzBORFhSZzNJYzM0N05iY0JNQ0loeU9rOTFyeStCa2w1?=
 =?utf-8?B?VGZ0N1V5eDU2bXR1czA2b0tSTWpTMGN0ZFV1VmhDNTUvdStFZlAzZVYyeE85?=
 =?utf-8?B?MzJUeXdubnBiN1I0eTdVWFRNdUR0bVJKQ3FRR3lKUGNtV1RzdHNJU2o2a0pz?=
 =?utf-8?B?K1ZFZm81bzFHSHQ0VGdyRWxRNGRlSTJmZWtFOU5FT1U0UFB6amYyanFpam1O?=
 =?utf-8?B?UTBoa2F5NW1lUWRpSkx3eWVxQ1IzNjhYOEFyLzg5YVNGdDNiUHhnbjhld2lp?=
 =?utf-8?B?Q2lkSGc1ZDhRbmNIbkcyeHdhWVZzY09kUWZJK2psRVNzUC90WTFnQWs3Nk0y?=
 =?utf-8?B?VlNFek1zOE5GeTkyd2ljVEJiWHRHaWhEeVkySWtiODJpQnpmS1JGcEJLSS83?=
 =?utf-8?B?bnFLT1BkSDRlRTIxcjdFRHZnUkxnY0ZFd0lBaWg2dlJzSDd0OWRiMWJuZmpx?=
 =?utf-8?B?bk4vbnFwUE5aZ0l6QTZsTmxoc203VGdrL0lGOVZia1JGY3RXQnpIOXJDRTNi?=
 =?utf-8?B?R1ZnbW41NDBoeXlZVWFPSTROU2pCY1ZHZzFKTmkrTExvVnNpVlNsRnZKQVpj?=
 =?utf-8?B?UTU5U1MxSWs3VzRTem5kdGJnTTgwZ0QvSkJpY3F0WHB5Q09NQzZNaW5DZDFU?=
 =?utf-8?B?K24zSER4eng5NFp0dSsrMW1JMk5UK1A5YkN3bWJiT0tGSjVxK3ZLM1dWdXQz?=
 =?utf-8?B?YVY1YkVWYXBvZTZmTzQvNHE3L0xpaGNsbWUzL085cHVxNGc0ZllxM3hxUkF4?=
 =?utf-8?B?cUhkR2hjUnBybFhsWkxGZEZxOUpJc2dHajVycEtUNGYrVFQvZURINzZNQTl3?=
 =?utf-8?B?SkhyQ2Jzb2tZc1dQMW9XNkttelM2d2FjdnI1TVh5Z1hDbWZrZmtXZnVtMVR5?=
 =?utf-8?B?QkIwcEM3QUJ6dzRHUHcyMEg1c1hMRGRRTVpwYWpHRWFJK2doQmt1QjVHRER5?=
 =?utf-8?B?VWxpZVQ2cnF3N2ovVlArN2tRbHJueVpRRmM4bXFSWW1QZDM0WHVaY2pxZlNt?=
 =?utf-8?B?SzlDaEZYSE1tTzIrQzZaRWhwenNjYTczTmZ1TWJjZkVWcDVGeFd1dlJPcmJR?=
 =?utf-8?B?Mnd2Y1dtQ25PQUh4dnFHYi95NEFnYm1jRjVxZjBtRDFxMmtpcjIreGo4ZGg3?=
 =?utf-8?B?M3F3MWhOaFVHbjRtZUp0eXNWSno0dGVoWnNlMmZHenJvM1JxSURYVEFrK0ow?=
 =?utf-8?B?aDVzRGJtU2NNTkxXbDlURUtYZU9rZVpISGRWZ3VzRHVEQXYzb1BkNFBWOUhs?=
 =?utf-8?B?US8rNjlhVEN6WGpCM2cxUUJ0OUYvLy85aUUxdlZLbXlkaEJjWXk0alhPTUJ0?=
 =?utf-8?B?UFZDUW0ydStoTXBQaCt6bFM1M25JRDBJc0gzc2tGYm54T253dUFtb0M3c1ky?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8cd4f2-28c1-429d-ed2a-08dcee9b5ed7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 11:03:45.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFDDARBN/gwUL+NSrbP19mkxTOi5MBPnuPLqWvvFeBDMUfuHtnRiCLGTU2XcQFrX7G389ADsjQxO1bNaIS1s6G9KpIXNsn32pHCCwMY8SUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com

On Thu, Oct 17, 2024 at 11:55:05AM +0800, Yue Haibing wrote:
> On 2024/10/17 7:12, Jacob Keller wrote:
> > 
> > 
> > On 10/16/2024 4:06 PM, Jacob Keller wrote:
> >>
> >>
> >> On 10/16/2024 11:53 AM, Simon Horman wrote:
> >>> On Wed, Oct 16, 2024 at 06:53:10PM +0800, Yue Haibing wrote:
> >>>> Return NULL instead of passing to ERR_PTR while res is IGC_XDP_PASS,
> >>>> which is zero, this fix smatch warnings:
> >>>> drivers/net/ethernet/intel/igc/igc_main.c:2533
> >>>>  igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'
> >>>>
> >>>> Fixes: 26575105d6ed ("igc: Add initial XDP support")
> >>>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> >>>> ---
> >>>>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> >>>> index 6e70bca15db1..c3d6e20c0be0 100644
> >>>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> >>>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> >>>> @@ -2530,7 +2530,7 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
> >>>>  	res = __igc_xdp_run_prog(adapter, prog, xdp);
> >>>>  
> >>>>  out:
> >>>> -	return ERR_PTR(-res);
> >>>> +	return res ? ERR_PTR(-res) : NULL;
> >>>
> >>> I think this is what PTR_ERR_OR_ZERO() is for.
> >>
> >> Not quite. PTR_ERR_OR_ZERO is intended for the case where you are
> >> extracting an error from a pointer. This is converting an error into a
> >> pointer.
> >>
> >> I am not sure what is really expected here. If res is zero, shouldn't we
> >> be returning an skb pointer and not NULL?
> >>
> >> Why does igc_xdp_run_prog even return a sk_buff pointer at all? It never
> >> actually returns an skb...
> >>
> >> This feels like the wrong fix entirely.
> >>
> >> __igc_xdp_run_prog returns a custom value for the action, between
> >> IGC_XDP_PASS, IGC_XDP_TX, IGC_XDP_REDIRECT, or IGC_XDP_CONSUMED.
> >>
> >> This function is called by igc_xdp_run_prog which converts this to a
> >> negative error code with the sk_buff pointer type.
> >>
> >> All so that we can assign a value to the skb pointer in
> >> ice_clean_rx_irq, and check it with IS_ERR
> >>
> >> I don't like this fix, I think we could drop the igc_xdp_run_prog
> >> wrapper, call __igc_xdp_run_prog directly and check its return value
> >> instead of this method of using an error pointer.
> > 
> > Indeed, this SKB error stuff was added by 26575105d6ed ("igc: Add
> > initial XDP support") which claims to be aligning with other Intel drivers.
> > 
> 
> Thanks for review，maybe can fix this as commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c")?

Yes please get rid of this logic. Historically speaking, i40e started this
and other drivers followed, but I chose in ice implementation to avoid
that :)

Kurt, if you'll be sending next revision for igb xsk support, then avoid
the logic we talk about here as well, please.

> 
> > But the other Intel drivers just have a function that returns the xdp
> > result and checks it directly.
> > 
> > Perhaps this is due to the way that the igc driver shares rings between
> > XDP and the regular path?
> > 
> > Its not clear to me, but I think this fix is not what I would do.
> > 
> > .

