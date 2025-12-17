Return-Path: <bpf+bounces-76865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ACDCC844D
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 15:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F283030964A4
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CD02D7DED;
	Wed, 17 Dec 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixS77EHi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B03A5C0F;
	Wed, 17 Dec 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982120; cv=fail; b=Q0uMGd3jTyIiXAkELY40N1VXq5TV1OuEO2mKqEvEbESItI7tJrmwR6q87lJrdZLFwZ0I8d7BodAY5gtjX+cMrObb6D3NrGMgR5T9mSsf1VE0V7EDusmAqM3ykdZjaRvqtd/tOi0SKgGSl4pVgFO41LAyTO2wcvo4oFZctDY0+qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982120; c=relaxed/simple;
	bh=yjZtLkp0hvEuMkBFRkRVxot/zFhfhTpHO6kbbQw3oUI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CIsBrP7nLZdtzWfKTlipNcssC4Uesd5MumvLeoj2FlNm9LW0AttFvBPotXBP+0Yq7lVKeuCosMeCb7YRx2ymzLHGXvATnUNDT6DZrywYsfH9Ox/YCxyVyF9rL8JTtJawEaNPn8GDHxzLyxkikvvUH8INkG501enuR16Hb+JneWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixS77EHi; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765982112; x=1797518112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yjZtLkp0hvEuMkBFRkRVxot/zFhfhTpHO6kbbQw3oUI=;
  b=ixS77EHi8I7sMOfM0rHkQ8f57q3Dz7wf8ERHxGtz6glCGMHZlrQZxdm0
   IgC3qxhmhGXS4z8TZhTA4Jcns/u0XP+JqdW9urDq/4bnYbeEp975ZgxIl
   w0TjlfOQ1In23jqGVKbeJQov65FfTtpGaCnQkc7a/fNfqJGJM7Js4v/+F
   uTxYCMMkasBhk3M796BwyJUuzqlJwo3MXPZn+I5neGe32hQwXHjbFDI4/
   zKzYpaJLAuADfkSo4lHRhOjG+GjGN8dxvlpg/Twx3lAresba1hDzpqf4c
   CNBoaDVcRE5T2bevaKlil9fye4DTsP1eY82BCTKl7CCoB4gT7NMxcUIdV
   Q==;
X-CSE-ConnectionGUID: +DRZqB7mToK4Z31UCJN1Ig==
X-CSE-MsgGUID: zaUnYMeHQReifyr9UFZnDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67859179"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67859179"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:35:05 -0800
X-CSE-ConnectionGUID: wIISuC6lTUWoxvg7MirNAA==
X-CSE-MsgGUID: V1rnJuAvSt65TW6+IsLUxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198317087"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:35:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 06:35:04 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 06:35:04 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 06:35:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7GMe/iw0WhZdKU3Zi0SYKzMJvx2k4jNhND9Rby3Oz+kuYjKXUOb0N56GfragyGgF7uX/2cTFS7rmsa2OOoevQBh0FABw9YM/f7hUKaXpnYejrwZYsi0Bqm4qYcV9FeomJRGuzz/RwR2xhyfN8p/di8JLmQatRwelaXhvNMyVeEA3uMsFn79JgzIjENuKbAte4yntsg9ee7p8xxc4lX9DEKWw+bchrp2YT1989d72VSFNbgI6oV/mb0XdjkK2HLlABETKZ61BVgRz8rLmeFdnvOAO+OTHolMgKaJ1UscVYZffu+bRyWWUZOqgjZHnCN5SnCmcPB7SExl4wXkWCGd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41JLnqfl+85SZb8MrYMj6xKcy5Ud+ZhP1qNBRGf0RG8=;
 b=P4TbkWSXMXHv1vjh1UTFuA6TVLhWcONoPb5aVKvxQD5qMBP7OPI7mc/lmqdLXO1PCx2hzkkkPAZhYw4lj18JJ3RZg67suhnRgP7TCONzbCKBUxQEcoCIFuUrpZUUyYRCGBz7+jNyLF1SuT9Yko2mKrqmt5bS/uGShSfhWNVP4eOiw7CBBD7BlyEMOncS3Oaz/UFQ7WTeB+j1GtUr4sYvhnfQEyXcffgpBSbq15jEEkUvVPlkQvX8E4145Gc8l8O33XG+GPFMuR2Wbo91D9li1IB0ob9DrGtLQ7d1YwoeQxB7+tATvRlvNBy77tDdvR6Yf2a8HnigpULaPr4GQgQFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:35:01 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:35:01 +0000
Message-ID: <c2580ef0-3e44-468d-8675-203de5c82ac9@intel.com>
Date: Wed, 17 Dec 2025 15:33:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] idpf: export RX hardware timestamping
 information to XDP
To: Mina Almasry <almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, YiFei Zhu <zhuyifei@google.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	<intel-wired-lan@lists.osuosl.org>
References: <20251122140839.3922015-1-almasrymina@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251122140839.3922015-1-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0006.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afc65cf-8d6e-4a36-32c0-08de3d797624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFZzaVJUZTZxSXlEOTRtdnVyaWhVTGluaXFhZ2VBd3BxazZTNFRXMkpuODJT?=
 =?utf-8?B?azc5UFFxOTZYZVBmU0JPY3NleVJtcFZ3MGFBOTVVQzJuNHYzczdtbW1pMWtF?=
 =?utf-8?B?RzR2UzQzeGpVVVVGcGpZK3daejVrK0FuWVJjbVhpaHRRNmdUOGE5SElXZmcr?=
 =?utf-8?B?a09mRUVvY1dCNHRmaFpFcVF0TGVOYnZwNHVZSkFBZTlFdkRtTjFEVHFkaEti?=
 =?utf-8?B?RDBXaUJoOVpHVDVEL2ZDMlh2b0hzNFJVcXQ0Z2RZS1BiblF4WERYa3RibVY2?=
 =?utf-8?B?VGJiUVFLcVlUczgrekVScEo1cTI2bkFUdVo3RS9zL1QwMHA1ZG9uaXBwSzY4?=
 =?utf-8?B?VkcvdzRuWityb1lvNWZtKzczZTZLelBFT1FrQmc4cWFNVXZidTJXbllQaTRL?=
 =?utf-8?B?WkdTUjBIRExMbTNvaW5MWWlTbDErWCtZQmNSVEUyVlBKWjhLNXBPSHVtcjlX?=
 =?utf-8?B?aW83UE5xRHEzTkNUODR5QjNqd2RVK1FjOTBYVWdSeitSc0RYRjNlZkZlMDJU?=
 =?utf-8?B?TUxwbWsrek03TjFzNGREQ3BaNXhHNnI5ZW5jRjVlVEhMRnNMUUxWVnBTeWRj?=
 =?utf-8?B?dGd3cVhObkF0OEJRZ2Z2ZERPSk53UWZVVm5GTCtVQmg0UnAyN1JxT1FMYlh2?=
 =?utf-8?B?L2Q1c010eEI4cmU1NlJXeDJvRTI3L2tIU1BGbklRRGowTDF1eGtZandIQ0JX?=
 =?utf-8?B?M1g2WHZKbkxDQ2RUdngxcGR3RXNrMmdjaTByQWtGWFNaUzJpYVlRTWl2dHZ5?=
 =?utf-8?B?RjVKU0hOTWtBMmRZQUF3bXcrM09QZ05CMGZFemtqMnF2ZnhzOWNINlBmeWpt?=
 =?utf-8?B?WUxya09aYmdVdnFVeFFYVWhiTjIzV204SUZTVmh5b0tGWnY2VnBIT3cyektu?=
 =?utf-8?B?V1pxTjhzUVJQYllyaUJ0Y0dyc1BOcXhmbnd2WUJCT3UwQmRWdEkwLytPaGF5?=
 =?utf-8?B?cUVZYzMzKzBKd2ZPWkozaTJCWEZscS9ibHdvNng3NTNZRkdwSVZUNnhiL1k3?=
 =?utf-8?B?Y2QzbndqSzhmREt1WVNDMGM4MUdjQ2lJa3JJTTIrRHI4WW51bVdtSks1MDRy?=
 =?utf-8?B?RldyV1NMYmM2YWZURGhLc2Njd3U2SzdKVzQwZ1BRbnVucHVmNXhITy9RY25j?=
 =?utf-8?B?T0ZlMDZYVDRnSVBtdzVCUWxQNUVhMTU0NlBScndXaHoyVkhEUkR4Vk12SC9K?=
 =?utf-8?B?bG1kQ29SVC8zNXZ1V2JWR2xnaWxpNjJSaEFjL2c1M2YxQjh0ODRVbHA3ZlNW?=
 =?utf-8?B?T2w2WU1Nb2ozSXZzTnFvY2RDTnBxblBvNGk5RWZZeXVFbm9nWE5WK2QyeE9T?=
 =?utf-8?B?M1JWaTdJNXZxQ0RkSTVibDJpZCtZUHhjZ0tHN2N0d3FWWC9wWElURUNrOTc1?=
 =?utf-8?B?WGkxb3liWWszY3M5bFRTQnF6RHdwMk83RThmbi96cDUyOXlPZnJ5cCtYTURD?=
 =?utf-8?B?WCtvazZiWVVoaTUwYnhwRmdEdGFTTS9DTHJIcDRBcW8zQ2hSYnplVnZOVFdh?=
 =?utf-8?B?eDdwekprZEJyQy9vbEpwMXZ5L21GdmZnWHQ2b2xZUmJUbDFOSnlUSmkwN3lk?=
 =?utf-8?B?VTM1RTJ0TkU5cTVXR05ZVWEvN0Y3Y2ZvMDJvUnFUdjcxZzdUYTZDYXBaYkEv?=
 =?utf-8?B?dTNYNVBVQk5FQ2o2VEtUMEloTVNBdDRvaG9sL0h1djE2Z3NmS2N6d1VON1BW?=
 =?utf-8?B?SkQ2MjFzMzVMVVBSd2sxR25jL2VsbXVTTjZhZFZ6T2VDNmc0OGp4SDdxQWZH?=
 =?utf-8?B?ZTdnQ2VPbmFiMjQwRFU4NU9uOE1rdERIL1NZZ25RRWhObDQ0YWpNMlVaN2k0?=
 =?utf-8?B?UEhLSVFSZk82RVN6a1JkSE1PTEF2UWQ3MkRYUVE2VkhuZFRnM2R2dEJxZWZB?=
 =?utf-8?B?SEpJWGZHVG4xUmZzMmZHWENJbGYwUEZGYUJ5Q1o5akw0UkdDRU5iR2VTdUJ3?=
 =?utf-8?Q?2qAf78J8JC3RJXhw6f3a5qKKgrXxSxT6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0xyN2NVRkh2N1FDQ1kyUTMxUy9SNW0va2UwUkYzQTl1SkN4NnFsMnRUZndx?=
 =?utf-8?B?YVJzK2F4Z1hxa1c5Z3d3VkQyaDZEOFF3T3JKTXBNejMvbyt0eGVWYmpYSmNM?=
 =?utf-8?B?cHpQY1l1NDdiNFREY2ZmTnlxQjNTRDBwcEgwbWZTVmNVdldmMEVuNXJzUTZm?=
 =?utf-8?B?SldDeEtRb3F1RFFGSFJBdy9POWFOQUwzdzloVUZ4SGw3eXRwYmdBaG5OSkhp?=
 =?utf-8?B?aXdDN0xZR1JIaHRVMWM5NXZwaFFveVREUlAyWlpPV0lCRENiRFBCK3NjeFJt?=
 =?utf-8?B?ajduRFlpdjk2SHdLMGZPZGNuU2RLWE0vdEthMVA4N1ZjRVFua29FVmVvNXU5?=
 =?utf-8?B?eEVNNEJNbGR6QlQwemFQMjRrdm1zNHRNb013Q2N1WXhpNGhBRjBxYnhuQ1ZH?=
 =?utf-8?B?eHJTeHBFOERHNmx5aXJRaUVCanRMVUt1SkJyVk5rNitGWXlsSEJzanU4TDF6?=
 =?utf-8?B?ZDFUVThQSHNPK1hkQnVXUllOeGNxa2ROR1ljS2hRWkJYdWhRZlduQUhiT2cv?=
 =?utf-8?B?ZTRtYVBnU3ExS0pFVUNkOGNIcldlUTNrM2RLSlpyZ1ZaMGlqT0NoUklXWGV2?=
 =?utf-8?B?bWtGOTg5TjdBZTJHdXByYnBSYWdZZmdETGZ0V1Q4Uk1Hb3BJTEZORmt0VFdZ?=
 =?utf-8?B?bzNONXZyNHdoWjM3WXp5S0Rsd0tSRE5ILzdIYnd2MWlQRFkrQUI3UmdEcnlk?=
 =?utf-8?B?WlNHdTJBS2RzVjhTMEZIaVlTaWdWTzNGaWZVWFE3WFg1dC9iUy9ZVVVSWVB0?=
 =?utf-8?B?MDJNQnFVYm5ra1Y3OTdIdlhNaVR2clF4RmQzZGI1Rkw4Ykw5M1RQRlJCQmJ5?=
 =?utf-8?B?a05lZTNGbkxvaHBGZlNSQ0NUS3U3K0M3ZTBodjBqSlN4NG5UYkJvMlNrQWRX?=
 =?utf-8?B?RTFRbm1hd3ZTcml6bHJzNkUya3lDL0tJWk1sQXNKS3JmTWxHTXhkYnk3dHQ1?=
 =?utf-8?B?emF0Njc5MXlHemRvcW1vZWRyTWd6Q0lKZis4L0Z0b3RGb1czazVKTWlFQzFO?=
 =?utf-8?B?cm5TZXFyamJiYnBWU09uc1J5cDNnby8xNEw5cGE3RjJVOEhCVUNjd2Z1MVlW?=
 =?utf-8?B?UGR4QUtyYmRtaEdIRVZNR0VlTU5oUnRVaDQ2bXc1Mnl1c0lKdGZMcXJVYVFj?=
 =?utf-8?B?NHFUVFBoWVFLMVk1UWx1dUpVa2ZGbzBPbmpVTmNvbXpHZGdUZTAzWkpheERv?=
 =?utf-8?B?U09USWYxOEdqZnJFNTV1STUyL3RjZUI3WmVpOUlkTFhYRG1xbkVZVTBWNGhh?=
 =?utf-8?B?Zko0dHZuYjhnNS9SV1RWWnNDU0F4N2tzc0ttTXloYkVsRy9TZjBYN1BwUXc1?=
 =?utf-8?B?OTNlVXhHR3crRmVqcTcrcC9uVXRqRCtSSjlaNFVnSTFzdzdKUEd2Ly94VENU?=
 =?utf-8?B?Vk4rd2xva20ySVhPZjIwOXYzdWZYZXphZitxVTM2QW92eVdaQ3pZbk1ienZU?=
 =?utf-8?B?VFpjNStETjVna1N0UmplL2k1TW5VV2Z0K3VPeHNYMUFWblR6MHhLR1ZHNXVz?=
 =?utf-8?B?d1U0NWF2d3k2QUI0d1lRbmcwV2pTNm8vNTE2MURGbDVyNUF5L0QrM3VGVmZk?=
 =?utf-8?B?TnE5K0xnVmYxNzQrTEFlNjZQVjFFdE9yM3Ava1VuVVh5RUtpSktacWI5OVkw?=
 =?utf-8?B?blRCNmlmY3JrTDN3b1VIZURxdHV6NXhCdkZDZkErdm1XT01kcWxtOXo4NmJw?=
 =?utf-8?B?OGs2dGRkMjY2V3NhLzhJdEhBZThTU0gxYmVJQ1VRTTdWUVVJZGljUVRxdzRT?=
 =?utf-8?B?TldzVjZ0dnFGQ3BZWk9JcXBoUHRMQWJWOWJIKy81SmIrcjl2YWVpR1ZTWWJ1?=
 =?utf-8?B?eC9ueHdMVVlvUEhZNWJNVzkyMEoxZzhqTlZWd0I3N2lhVHZaZVRLREdiamcz?=
 =?utf-8?B?UHdITStlc3g1QkxHSjFJV2RVUWNvbUkxNUFJTlBRcG80QWxYR2Z5dHV1Ri9k?=
 =?utf-8?B?ZldzYnJVUnUvZ2JVNnlkbkFqWFRlMGFDc0dZM2kyRlpaWEpkWTZBUmFnMDZM?=
 =?utf-8?B?NGZ5RW1iQ3dYblk2bHpyZ2dvb0JSRFhRZ3RObDFkTzhDby9GZzMwWSsrNi9Y?=
 =?utf-8?B?KzBua0Z4aW9zeC9tSWpGU2NnRW5OK3VSVUJYWlNxWmZ0dFI0blhmMFh1M1du?=
 =?utf-8?B?bVNrSWRlZEo5Z0ROcnc0OTIwR2NhWjB0RXNFUWRPc0owWmZnS2Vwa0tDR1VW?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afc65cf-8d6e-4a36-32c0-08de3d797624
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:35:01.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1yOX2wqHlAcOk/bsMK6YZ/+p+hEVHSZjrO2wfos+K3KCF1uKtOcCzZ+Lz1DRESfNZNI4I7tniJW31YcjpY22L16NNOeJNhRDDGITXz9Ybc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com

From: Mina Almasry <almasrymina@google.com>
Date: Sat, 22 Nov 2025 14:08:36 +0000

> From: YiFei Zhu <zhuyifei@google.com>
> 
> The logic is similar to idpf_rx_hwtstamp, but the data is exported
> as a BPF kfunc instead of appended to an skb.
> 
> A idpf_queue_has(PTP, rxq) condition is added to check the queue
> supports PTP similar to idpf_rx_process_skb_fields.
> 
> Cc: intel-wired-lan@lists.osuosl.org
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/xdp.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
> index 21ce25b0567f..850389ca66b6 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> @@ -2,6 +2,7 @@
>  /* Copyright (C) 2025 Intel Corporation */
>  
>  #include "idpf.h"
> +#include "idpf_ptp.h"
>  #include "idpf_virtchnl.h"
>  #include "xdp.h"
>  #include "xsk.h"
> @@ -369,6 +370,31 @@ int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>  				       idpf_xdp_tx_finalize);
>  }
>  
> +static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
> +{
> +	const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc;

Sorry I know it's a late comment...

Could you please you the optimized descriptor structure from idpf/xdp.h
instead of the regular one? To be consistent with the Rx hash timestamp
function and give more room for optimization.

> +	const struct libeth_xdp_buff *xdp = (typeof(xdp))ctx;
> +	const struct idpf_rx_queue *rxq;
> +	u64 cached_time, ts_ns;
> +	u32 ts_high;
> +
> +	rx_desc = xdp->desc;
> +	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
> +
> +	if (!idpf_queue_has(PTP, rxq))
> +		return -ENODATA;
> +	if (!(rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
> +		return -ENODATA;
> +
> +	cached_time = READ_ONCE(rxq->cached_phc_time);
> +
> +	ts_high = le32_to_cpu(rx_desc->ts_high);
> +	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
> +
> +	*timestamp = ts_ns;
> +	return 0;
> +}
> +
>  static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  			      enum xdp_rss_hash_type *rss_type)
>  {
> @@ -392,6 +418,7 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  }
>  
>  static const struct xdp_metadata_ops idpf_xdpmo = {
> +	.xmo_rx_timestamp	= idpf_xdpmo_rx_timestamp,
>  	.xmo_rx_hash		= idpf_xdpmo_rx_hash,
>  };
>  
> 
> base-commit: e05021a829b834fecbd42b173e55382416571b2c

Thanks,
Olek

