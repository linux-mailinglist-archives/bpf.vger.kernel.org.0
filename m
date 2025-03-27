Return-Path: <bpf+bounces-54814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA06DA732F0
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 14:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36743B2E1C
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AC3215165;
	Thu, 27 Mar 2025 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCcPzgYU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15064C6D;
	Thu, 27 Mar 2025 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080546; cv=fail; b=YympDt7bk6RIePTAaM5r417OMYDmPXk2XoXFvJhejOmcO5p7JWVK7w6X7HExunpOc5Oiqgt9Lg/8+pqwcEQ2TD89iSIKYmrADLUou/I7kwO+7OciRmjLm39R5KQlE2LzVqlB9GYwsH/TmROnMUwLr5hadmrcKuT+VO+y1Cc3J6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080546; c=relaxed/simple;
	bh=MFwtDRTg41/x2Mb+rRNlSN7ED+n9AlKcpsnGFSy7YNU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OkHuub7cq/0Bk28LhbFcZsF20BNaBbPtZCzgUOTwtgo5A8AL9SwMiRtOAIGjcpndrFqM0CepupCd/MmFLi+DrPDXIATK9EbV05rW/waMQ1bB5xZY1t04l9qaeD6j0J7J+m7g35xW8LKGeeSUbvmKjUcorCZy3qId7gFjGGBL8eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCcPzgYU; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743080544; x=1774616544;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=MFwtDRTg41/x2Mb+rRNlSN7ED+n9AlKcpsnGFSy7YNU=;
  b=CCcPzgYUutQzN2lDxFhSt0olXTVSRYOBVPDHz/+T40dqvmqadW3TkpUZ
   GrE2coDGY2gbcODARCeHRGIJ9pTZCFYuVHgVLwwM2QhU6nxZla3EIAH9l
   oTbMuYdUYEbh3kSdKGGlbDMYHwttx0DX5cbB/+3vQjmsTmEOpdIawmEuE
   GMVsZN8m0T7ocdS4G/QYgE5bsgKGmnKPb2Ni3+Rvq2f8+6qFiE1IBXETR
   Tf4ReLtRjuBmIhsA2BcuO0W944pi/ABdttK54DEtPKLGCDwGU4W3qmGc/
   ZiFIXXHGM8YiszDKlq6/5SqP3mqsjb6mtnWbu6oqZM9xTMv73TwZrJ1YT
   Q==;
X-CSE-ConnectionGUID: ElkEiTBXT76ru/E1DJp0gw==
X-CSE-MsgGUID: qRxdiI4XQPStsRndDUmPEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44426011"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44426011"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 06:02:23 -0700
X-CSE-ConnectionGUID: mXV9d3enRrmrWW0JS6iW5g==
X-CSE-MsgGUID: wtyYtTndQCKUyQ1w6SQjYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125350223"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 06:02:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 06:02:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 06:02:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 06:02:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVUMkG7LAO87cS8s/+8D8BAXT3z3kCuvHO4BxxOcuoRFbRS+yM0JiOXgJUUfKWHVLe1rThxkamNvF+E1epHvDxIntC0fHxbV5g4lMzgxBgfabHo8qrgfziOy9AcRWcvin0pKt+wI0y29L4us+nDlsdxzVSV0h4S04IjXpOj37t64cB9Xek69g2TTBRpbKNDVr6B5/UVQpjqtEbn0hDLRHI8ZZPLYHs/+7sWgXFxv/7ltOXd71UThfYqFEKyhmGJc2iWzcWSTztHtCKsOC/yOr1wZ5Ff1IFfqKKXKrJVdbnE8hnJEnxaa32vM8vDR1YhMaJT2swOeeaP9qCGDA1qWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVpZNMFVRmfQmo/zfBKYgLcIw2dKRFknwxdfhN4Za8Q=;
 b=v43pNsX57/on2lQxNLaZ5Qv5mHe6kTt1FL3IPU84QriC21+R+Xkeo6Qd16xU8VjG1ixhxtfaYXQrnaoUsSI0rODrXZtjACAzkkzyZYUhkuiy8kRmKT0VnoAb5Bk44PjBI3cp7jz2ZdVKLoCvVezOMz2uYI4fTFtSCECwtWJgRP8tRNE6wkFX3veSmx7rC5OAYaEUQSaWpstBvbYC3n5FzCZ/yix+/ouBaZi+yKVQKmRbfwWgZplx2byRl0OanW25dwvFmDJsrYiaA/0tkzx4BKhc4J9puPkpHPZDNRuL/ESBJGTA1/80T0yiEQZ9y4hNGQW5eTvYkfIhBK4HNVlTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) by
 CH0PR11MB5217.namprd11.prod.outlook.com (2603:10b6:610:e0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 13:02:17 +0000
Received: from DM4PR11MB6310.namprd11.prod.outlook.com
 ([fe80::c07c:bc6f:3a1c:b018]) by DM4PR11MB6310.namprd11.prod.outlook.com
 ([fe80::c07c:bc6f:3a1c:b018%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:02:17 +0000
Message-ID: <f2a8ede9-52fa-4f69-8ab2-3290171bc886@intel.com>
Date: Thu, 27 Mar 2025 15:02:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v10 10/14] igc: add support for
 frame preemption verification
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Furong Xu
	<0x1207@gmail.com>, Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, Hariprasad Kelam
	<hkelam@marvell.com>, Xiaolei Wang <xiaolei.wang@windriver.com>, "Suraj
 Jaiswal" <quic_jsuraj@quicinc.com>, Kory Maincent
	<kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>, Jesper Nilsson
	<jesper.nilsson@axis.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Chwee-Lin Choong
	<chwee.lin.choong@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Serge Semin <fancer.lancer@gmail.com>
References: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
 <20250318030742.2567080-11-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250318030742.2567080-11-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6310:EE_|CH0PR11MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 094be9cd-445d-4c8e-7798-08dd6d2f9a1e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEc4THgzNzFUT0xSYVNXMHhjbkt0R3JwOWJmcmxIZ0FISWNmYTNFMDQ4MXFD?=
 =?utf-8?B?SmhFRDhHS2E2eENQK0pJbWkxNU0vbU9hSk4vTHRtSnZCV0MyR1NLdU1SNzd0?=
 =?utf-8?B?OGdaU2NRMWdBZU41MU1DMnBDaHZuNkZSbnNDamc3dkR2MElxREoxSmVKNnZL?=
 =?utf-8?B?cndrQ1cxVkpsMDRjM0t1WjdxZnFlTGw1MkZPUTNzOUkycDgvSUE0UHVhL2pt?=
 =?utf-8?B?M2xzdHp6My9sMnNULzdBMHU4R3N5d251Z29TZWNxOHU2Ly9pVFBwcWxBUXB3?=
 =?utf-8?B?ZHk4VXcyL0JZeXNGWXhKS3MxeThlVHlsLzY0SngyVFVDNXVTaklHRDR5NC8r?=
 =?utf-8?B?QzJUZyttek5NandiSnFVT1BkUEdsVVlzNzdZTFg5c3hUOGtwZWplbWgzMHE0?=
 =?utf-8?B?dS9oSktsaGFVTThkbVhJdDZOL1I2KzFlNmNyblNoVjdtSm5TVnZUc0pNTkll?=
 =?utf-8?B?dzRSaUE4QUJEUEpCV3AyZG9NSXZxZ1orcVhzcjZmNGZ0bjBpOTNpYzFWRk1V?=
 =?utf-8?B?d2VjcVhwdTVNNys2SUxKMHJmZlFQeHFmNTVuQlBiUXlRbHdDaDRYc3NUdU0x?=
 =?utf-8?B?TkRoMUhwYkxDcEVYejhvYUlLbmNJS0dhMW1VaWhpdVI5TjdIZkRWMXphTE4x?=
 =?utf-8?B?WnlIYkNncDNpZnpxc1N5VVlvcHFTQWhadEtkRllqZGVHcW5KNjNaZnZXZU8y?=
 =?utf-8?B?MmRncUkzei9YU2w1U3kzaWl0Mjg0MnJ6K1llZ3BaU2Y1NFQ5SS9OM3NpRG5u?=
 =?utf-8?B?VDM1RjU4UFMvRTFwNnVpdlhJbjhqR1JuR2UycTYvL1VBaWlPRndkMjVuazgx?=
 =?utf-8?B?VWJ4U0xMNjdJcGNMWVRWOGxWbUxpdllXcisvWjE4M25YamprT0M3RkYrOGRL?=
 =?utf-8?B?RmdPZzJUZFlZV0NxTlZlQjd4U09mS2graEZwZ1NhUUxzTVpOZXJzSzl6WGpU?=
 =?utf-8?B?ckNjRE9OMEhvQTc5cENEMWl3dmFTRlJueU9VWmFWVjNvb09KL0tXTVZVbXVP?=
 =?utf-8?B?aHI3cEhTcEYraERBazJ5Q0p6VGpWV1A1anovUVNvL3FUcm9wYXRSN3FsdEdY?=
 =?utf-8?B?aVE1RzV4YXl0TWhqNVRMYldYTi9GanFkZGgrQTMxU1dKK3lHQlpPTU1zc2Iv?=
 =?utf-8?B?TnJXSTN4MEZwWTN6L3FwdnpoK3hPeU9RRnBCRzMzTTYxME5OZzk5WFg1MFNH?=
 =?utf-8?B?YkRMZmJxc3NaRGhuT1NsaWhCeTYrNWw3UUgzNEx1UkZZdFdEdGlPRUR1QS9o?=
 =?utf-8?B?bm9NMkFIQzRTSTNsb3NiYXZHV0FsUlkwcmo2RUg4VEUzMGxEN3pORmVWOGdU?=
 =?utf-8?B?UGxYb3hGMEJOQWNobkZSU3NwdmJTcEpDMTFjVDROOTlENFNRUlRQMlRYNjd4?=
 =?utf-8?B?QmlvRFE4QTRNRmJOa3ZpNEVRbmpLZ25qOERqc3JMSVBRMEhiWnJJYzZzL05Q?=
 =?utf-8?B?S1VaTVk4U01tdjc0YjhDNCtTTkdtTUVzYXhyeTd5VTljZVEyeHlxTEdhZC9J?=
 =?utf-8?B?Yy9PeGlRc1VwVnliVEhnMHJ5Y1BOY2JmWHc1K0htLyt3QkgwME11V1Z5cDRo?=
 =?utf-8?B?WndiaUdXdm52WmNMektNOVI5OWhyVlR6RTBVZkFkL3M2bTM4TUoydEgrUHEz?=
 =?utf-8?B?M2F4YnpYY243RFlmcnliWXZvMjBHUlVzZjlNL2tPTm9Ld2k0aG1hTzhBZzgz?=
 =?utf-8?B?S0RJUWhXUWFwSjJFQS9GWHRiQ0EzV1BFUnRhMFlXWi96ZGlzV3hlL2ZtN2U3?=
 =?utf-8?B?M1FIWE9TM1VRc0ZzRjIvbFNsaVFSSHZuRms0OUlyUThwTzVQUUlRU0xXUUps?=
 =?utf-8?B?bVlkRFZQOHVwZkU5RGF0ZzVzU2Y3S1FMQjIzd2FjWlNybzJvRUs2M2EwWGhl?=
 =?utf-8?B?SnVkY1FuSW1xaXRJLzIrSlI0WFV5YXhiU1VrdXpMUkZBV29hSktiZzBKa1Jv?=
 =?utf-8?Q?GLzGcTyXoFs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6310.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czkrd2RGcU03VU5uNFdoUThhelNrUXJTOXNrTC9TQ0U3eUpKcGlYM0Rkd3pr?=
 =?utf-8?B?NVFUMWhJenl0QllwZVpWaEFiVlFLeDdOdGtaelluWEpDYlUrQmhSb1F3OUFj?=
 =?utf-8?B?Y2NNcWdrNHZBbTl5T2k3Zmh0VWdmRzZoNkZpZUo4akc4MkM2bzlSOTNIVkN0?=
 =?utf-8?B?azRaQmFpZ1lGaUk3Y2crbExuRmQ3TFE5TThyVzcvVVAzL1RQYmdMbmdEWGhB?=
 =?utf-8?B?RG5FaEh4anA4Q005Q2NKMURzYmV1NC9WcHljT3IxeHR5UzVQZVhIM0F3VEJU?=
 =?utf-8?B?MmtXaUtLWld1L09GdGJHc3hub0Q0SWpRb0VaU05pdlliRVN5SFJRUGkrcVBN?=
 =?utf-8?B?dG5KbGZjcFJOV1NhVXRwZGdkNFpiVE4yTFBuUFZoV0VYaGxCcjUyeFB4QTZF?=
 =?utf-8?B?Q0t3V0RaUEVNSjdOeVY0eGl3QkpGUzFOTStKSk94T0JZUlpNRFJtNVFQWGk0?=
 =?utf-8?B?WS9LYkM2bk4vcmg4b2wwdWdyTUJxbng5T1l0VEx3dWVqK0tML0tZTWpFMExi?=
 =?utf-8?B?ZU14dVdiNkJhRnRUSWxQMjZqcXBVOVVNb2RodzdtTXRrdXQwbHA2VGhpeTM1?=
 =?utf-8?B?Y1BmR0VJL2NrUENqMG1WWWJORFBWSm42L1AxcjUxc2RSN0R1Z3VuaS9mMmMx?=
 =?utf-8?B?L1lpaGtBYlFldENhY1RMNUs0NjA2VVdOZUR5YXp5eE5ydncvL01TUVNxZ29L?=
 =?utf-8?B?MWprM0dJYXFnSTErQWlseldMNWt2YklJNVJHaytPU2FtVFVQOEVWU3Y0cVdX?=
 =?utf-8?B?UDBTVjlPMS9jWmJiMCtqSlJNM0tYcEdJRGYrMVpyWVp5VW9CY0FTdXFwWVB3?=
 =?utf-8?B?RUxWSENqa1ROdE51NE93ckZzQTB0TkNka0dwRUtmKy9ERUI4ZHRXMWkxRW9X?=
 =?utf-8?B?SDNMc242NTRWU1dpR0x3czNEcWl3V1IrSWRydGFzdlZuaitkUWlEbHViVWhF?=
 =?utf-8?B?NmNxQ1FKWkRFU3pLNFE3SUN0OG50bU1RRUFuM3AyTVIwYTNWTHJnTTAvZnBG?=
 =?utf-8?B?TEtrV1lMUXUxWTZnMmo5RUhKUC92VkkwSGZwbjlFaHBrUjJIRklsVmZQWk5M?=
 =?utf-8?B?S1ovdm16MXdJK1RqazU4b2Uxc2FXa2pyQjBhZzVTMFkxY2dPb21pRGsycHNj?=
 =?utf-8?B?Qzlrd3N4UFBXR2J1dTh6Mi9ZbnVScG0vYWdpNHV3L2JvaDRZYmZsK0NPd1hB?=
 =?utf-8?B?c2R4MnE3RXRnUFFZL0VEbDFVb2loKzlOQ0cwTlJFd0ZXa1FSK3ZDMlVqa0Ra?=
 =?utf-8?B?L3ZKbzI4M1FybDMxUTJVbWVjU05kVVJyUVExRDdjMjJXaGtmcjF4bUM1VU5O?=
 =?utf-8?B?d0ZoT2ljd2VuWHkyS3pQWHYrVGZFN2NqNTZCQk9naG1mOHVGOGNJeXVWaXBO?=
 =?utf-8?B?ZkFqYVAxTnQzb3lhc2hrZUNxdkhZcnRuaVN4QmpwOFpKTXM0LzNTWnhDaXdt?=
 =?utf-8?B?a2NzRnlmdGY5OEhRYVpiUTk3Vm9MMDVFWUZ2dWJuNE4yQjRCWHF6OHlqUVpj?=
 =?utf-8?B?WDBySG5ORXJ3cG1SVURZRDVtaGp4K2VqT1haOFFWQjREUkRxMVlRWVJrYVkv?=
 =?utf-8?B?S2VhSFYwcDR4Wjg0WWxqbnlZa1A4cWN3bkpjOUpOVjNiWnBlMlBYbUhUa2JX?=
 =?utf-8?B?TDFtVys3S3RHZ1BVcm9OZ1VFUDR2SzljUHpMaG9wdmRxSDdvY2pqOVhlSzRm?=
 =?utf-8?B?OVRuTW1iWW0rN2Y2bTZjTUJwcW5nbVNlSlRYcmFET3lISkpyQlpxbkJuRXdi?=
 =?utf-8?B?bEp3VG5lQXNGNTRzazZ6eWxweS8yUnQzeUtUYllWQXRZbUpJYytpcThHRG9w?=
 =?utf-8?B?WGt3S0N2NTVaa2JsYThkMnNRTzZuRzVpVVZicVJSYXc2cW1kc2RkNlpRcWVu?=
 =?utf-8?B?SVZDcnYrUERGakh1S2lpUCtzZDh3ei9JbjdLdkR3aTA1dUREa282Rlh3ZHZY?=
 =?utf-8?B?b3RnVWlEUCtFOXhPcFlYcmFWa2FVM2pYRHFqRzhxTzJOekxpZU5xZVBieVQz?=
 =?utf-8?B?ZEtnUHdmOW9hTFpGaWg0dlpqQWdWQmE2bGVabW4wQWFEY3c0a3pVTW5ZY0sx?=
 =?utf-8?B?UmVNRytWNkZzeXJuQWdLRFBpT2RxNW5iOE9xbW9aNDBsVU5wcVF2N2kzaHZr?=
 =?utf-8?B?b2M1WE5kZ1F2djZ1cGhDYW8rR0kvNVY3QlAvWTFqOUp3MkEvUndMTXJwdnRE?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 094be9cd-445d-4c8e-7798-08dd6d2f9a1e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:02:17.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +go+wOeUFG5xEQhHUIb27djCc3UsuCjgIt+COdlZR7akyanC0BSuG7tEQRqHnP4Vqu8sUAZxgkP/wvo5mLMQgFa2/PFZqO+tvL2kLcw5CNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5217
X-OriginatorOrg: intel.com

On 18/03/2025 5:07, Faizal Rahim wrote:
> This patch implements the "ethtool --set-mm" callback to trigger the
> frame preemption verification handshake.
> 
> Uses the MAC Merge Software Verification (mmsv) mechanism in ethtool
> to perform the verification handshake for igc.
> The structure fpe.mmsv is set by mmsv in ethtool and should remain
> read-only for the driver.
> 
> Other mmsv callbacks:
> a) configure_tx() -> not used yet at this point
>     - igc lacks registers to configure FPE in the transmit direction, so
>       this API is not utilized for now. When igc supports preemptible queue,
>       driver will use this API to manage its configuration.
> 
> b) configure_pmac() -> not used
>     - this callback dynamically controls pmac_enabled at runtime. For
>       example, mmsv calls configure_pmac() and disables pmac_enabled when
>       the link partner goes down, even if the user previously enabled it.
>       The intention is to save power but it is not feasible in igc
>       because it causes an endless adapter reset loop:
> 
>     1) Board A and Board B complete the verification handshake. Tx mode
>        register for both boards are in TSN mode.
>     2) Board B link goes down.
> 
>     On Board A:
>     3) mmsv calls configure_pmac() with pmac_enabled = false.
>     4) configure_pmac() in igc updates a new field based on pmac_enabled.
>        Driver uses this field in igc_tsn_new_flags() to indicate that the
>        user enabled/disabled FPE.
>     5) configure_pmac() in igc calls igc_tsn_offload_apply() to check
>        whether an adapter reset is needed. Calls existing logic in
>        igc_tsn_will_tx_mode_change() and igc_tsn_new_flags().
>     6) Since pmac_enabled is now disabled and no other TSN feature is
>        active, igc_tsn_will_tx_mode_change() evaluates to true because Tx
>        mode will switch from TSN to Legacy.
>     7) Driver resets the adapter.
>     8) Registers are set, and Tx mode switches to Legacy.
>     9) When link partner is up, steps 3–8 repeat, but this time with
>        pmac_enabled = true, reactivating TSN.
>        igc_tsn_will_tx_mode_change() evaluates to true again, since Tx
>        mode will switch from Legacy to TSN.
>    10) Driver resets the adapter.
>    11) Adapter reset completes, registers are set, and Tx mode switches to
>        TSN.
> 
>    On Board B:
>    12) Adapter reset on Board A at step 10 causes it to detect its link
>        partner as down.
>    13) Repeats steps 3–8.
>    14) Once reset adapter on Board A is completed at step 11, it detects
>        its link partner as up.
>    15) Repeats steps 9–11.
> 
>     - this cycle repeats indefinitely. To avoid this issue, igc only uses
>       mmsv.pmac_enabled to track whether FPE is enabled or disabled.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Co-developed-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/Kconfig           |   1 +
>   drivers/net/ethernet/intel/igc/igc.h         |  12 +-
>   drivers/net/ethernet/intel/igc/igc_base.h    |   1 +
>   drivers/net/ethernet/intel/igc/igc_defines.h |   8 +-
>   drivers/net/ethernet/intel/igc/igc_ethtool.c |  21 +++
>   drivers/net/ethernet/intel/igc/igc_main.c    |  52 ++++++-
>   drivers/net/ethernet/intel/igc/igc_tsn.c     | 146 ++++++++++++++++++-
>   drivers/net/ethernet/intel/igc/igc_tsn.h     |  50 +++++++
>   8 files changed, 286 insertions(+), 5 deletions(-)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

