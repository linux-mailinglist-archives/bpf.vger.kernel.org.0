Return-Path: <bpf+bounces-53914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C9A5E2D1
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 18:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7183BD372
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86492571A1;
	Wed, 12 Mar 2025 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdSMUIsO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99381256C6D;
	Wed, 12 Mar 2025 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800371; cv=fail; b=SoYlNyueWozJbE0Pd7bkgtP1iKlJLkwkYdxYs5HxzrS/KdvrvxtI0Zt3E+PEpOpTBmV8tRV9abO1Ba6FH6GkCX5oDCMfFp6Fjqy9p9gk7Oca06Q3r4JB3GtyvAU7WiJcv1vZYv4jB4bBMvr9DPw4Q+8gV+WIFXsRIhof1px8Fqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800371; c=relaxed/simple;
	bh=Spz08Abd+gYVq6X0f7KJ0uYMLjhtpYLtJfDEK/Ia5Vk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RJbmHAOrYFFt7MHw3DxSC3bgk90CiQP2u739x7tn7ZTU/aKgYbGqz9GSjEAyW/xZw9ApwCv5TdV9zRSIAne0+LomiFbFDItDLsmrMRyiLcGPF3SZ6S6zGjUp0OQgSn0yc8IlzBFLW6hS2ZjGVy5FAedxv/lRl7eYGRlXX/A9uYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdSMUIsO; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741800370; x=1773336370;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Spz08Abd+gYVq6X0f7KJ0uYMLjhtpYLtJfDEK/Ia5Vk=;
  b=KdSMUIsOUGg2ZLejadahv9SjRaZ0N56XVqwVlamIgGJ0vV/KjsPOVp/B
   dnlsWs6ZrIXe1cLJcMSecbYNOGOncPV0XpsMYRYns9/dYQLjh6BW+OHqF
   jhu3ShkqADn5StGv84HmY+/7LOSFXwIc4lWJQv4vd0+IWc9KBTzap3Dlm
   MEPb0stxMuetDfpydPkTMnQ9x27kzlq4R6kpnnQbcXul1CatHVrFQjc1S
   qs9XsWOhzWaqG2s5GtOhY9yWpMMA+ZNVP5gur0YiqNwR7G4bm3cDon+9a
   jpDILZgEvw4t1UjGVhAqNbg9fJRSgkSRFDDTBFQzZTgLwqv2cyb32toJ4
   A==;
X-CSE-ConnectionGUID: cQEa/XNqQ/KjgpX8hgH5Ow==
X-CSE-MsgGUID: aJcwVly6SFWArMaa4VgoLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30477111"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="30477111"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:26:07 -0700
X-CSE-ConnectionGUID: TAuQDulOSlOXG5uZJhbkgQ==
X-CSE-MsgGUID: BgEo+5bNQFq8YnDH2udoLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125593643"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:26:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 10:26:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 10:26:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 10:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYfvia1fVXuWgmoqFa3DmMO7BNXzM5Ljk9tg0p1dpqjYS0a2iKb9v4ACJlEkBzTV+Qri7TxQa3s5EJbCcoK94Zso2hVQWahpEzbwl9edvGADLHm+k9ZVkPD/T5nGX1hVZf6cvrlG5eHhE/bGhXI2dLlm/KxMUAoOBgnucQFXiO3vDzviefK59d0EySKXSY+a2oTRJ+eQ9bZzr7p61/LBiKSqxk4mOGTzPBwgJutOKwFChi2gm2fsALD58u6gwOlgr6Ow/XXjFgLtDapMjGtHtFPmTuYBw/0NsdhgW01Hr0OsYbk+hM3qbUVHFKXrQ7CW3eiPTjS8J8CtcSUtR5D8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0u4UYT4EayDDPcK4iyLJBbZdnEJyeCTADxuNjjesFo=;
 b=dVTrPbJJOIbzkUpbWov91MFk/gJ1URj43QJmfiuh106Jr6ed0ecZm2/3+gyo87FvyiJJUBGlXOE8m3Vt/vimSnrwMVsaDCU6TUpCZd3CLhWA5c1jE2oFuw0aelRlxar4MEwnNF6hdOeCoviZ32aH61eVAksTXxlxWlH5OGSJ7K11e2kxDUKf+91HLc2eeB8dNUQjbdOmsaJdrapxxFN9JwoYAVDhlyVrOPOk8yc1LBnV3VJoD6iOMQohZ2Kdh2NDi+uTpKe5RNeiJ6QOgnZhTrxt8lKzBXSA2HefMnj7UqDGtTOy1Lc8mObFFLCydcDrfaKpgMAmBYvL8qMdUB2kNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 17:26:01 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 17:26:01 +0000
Message-ID: <b3038304-145c-410f-aa74-888225732dfc@intel.com>
Date: Wed, 12 Mar 2025 18:25:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/16] idpf: link NAPIs to queues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-8-aleksander.lobakin@intel.com>
 <Z8rPpsAbm9JXOCxZ@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z8rPpsAbm9JXOCxZ@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a2eb45-034d-44fe-fc83-08dd618af5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amVmQVpITExBYUEyaWJiVDlBcFY5SnlrV0Z5MnprRVc4eWhRNTY4RFJhc2xk?=
 =?utf-8?B?MUNvek5GSzV0ZDczTGc4eDJiRE0zQ2pnMTcwMFljbE82SG1YN3NvRTdpMWJs?=
 =?utf-8?B?WXppRTlId0d4VkYxNnRoUzVad2xJOWQ0QkdOV3dRdXlJb2xWWjQwdXRPeUdW?=
 =?utf-8?B?anhFeTNKKytJRDBvcEF1alFGbU4yZW5mUzhuZlF0R1NvWnZ2NnhaK3N0aXd3?=
 =?utf-8?B?aVBWTUdpODNuQ2ZRWkpYWFYzb0ZHSUpKdFN0MThFNzdHRGpIbTM3Z0RBcENG?=
 =?utf-8?B?SXFaOGdjRWNqa0hCczlWbHI2VUZ6SklNR3VDS2p4ZjJPRklzMjJFK1RkVlF5?=
 =?utf-8?B?QXBtQW1DYllzY0lNei9MSDVKaDNCRGNnQmRZY3hQeTFWc1lQaVBCdERDa0p5?=
 =?utf-8?B?eC9qRUZtcytvTSs2Tmt3TTZ4d2JBa2JXRHc2Y3N1eDZSekQ0clZWQWg1K1BF?=
 =?utf-8?B?bldxOHg2RFFpenpoYkNLb21Pd2l1dVVLMnJsSm9ZQ1RZN2N1UWJUTlEwb0Fp?=
 =?utf-8?B?RVFzb3A1RkNOYzdBa3FmNVlQRDBaSlhyWGpVQmMwQmFET1pmbVlkcWFhRFF0?=
 =?utf-8?B?d0M4QnR5UzBrL3FGd3lXcFZIN1Y5U0hrZEZKWjhHWkIwS05GNlFZblN3OTNi?=
 =?utf-8?B?Qno2ZTNtQWR1U0FGWnViaXZ5SVZGK0NOYy9GYlI1QVVBblIrUXpXUE1aeTV6?=
 =?utf-8?B?VDJHbGYzcE5ORzMvQmY4eWl4eER1aVJTSjdEd2FCcFQ5N3licGw5cmlRUys0?=
 =?utf-8?B?ejMwVjFQM0JZbllMQW1yODRaZ0VGMFNoc1NYQVZJZUUrQ3Z0NzdhNkNlSU5a?=
 =?utf-8?B?emRPbFg0VXVKbU13YnJoTUlrRXJLU2JnNDJIRkgvSk4vaWVLc1FVVUdNSWlh?=
 =?utf-8?B?UHBDM3V0ZmNPTmZSdG5uOVRPcVM1WWU4TEpRc3BZcHQ0VjQyMGtXem9WbEFT?=
 =?utf-8?B?ZHFFdGIyOUR5Kyt4MnlDUnRrYi81ejNaTGhoUzNVVTNya0dMaFpMYzQxdDVk?=
 =?utf-8?B?enVtbWVXTXpYVk42TnVqelBCZTQvVDhkc1h4ZjNJaWNYVS9tU3BjNCtyaXg2?=
 =?utf-8?B?dXNqRllTUUYrZ2hlNHpWSEVYQ2Iyd0g5K3cxUVA5ZVNTUlBacXZoZmh5T3RH?=
 =?utf-8?B?RXMxWHZKTElRSStSSlJXQ1J1YVEyMDJUSEV4TjR4UlFWYUZaQXVJc2Jtak9t?=
 =?utf-8?B?dXh3MStraGphcCt0L3V5cS9WYitNdjAvUmN5a1dYYmVleGlWK0JGN3YyWHZh?=
 =?utf-8?B?dGZ0Qnk5TW5uWFlWcmppRFZxRk9lV2o0K25Uc1k5cWtPeTdsTnVSR2RNYlFs?=
 =?utf-8?B?UE1Wd0FzWSsvbmJEMzB5dm02T0E3UHI5OGMxVkFxOVQ4VmszWTFkenpwZyti?=
 =?utf-8?B?anU1UG9IYjNDdkN1Vjh0d0tqR2VYSVNmdkZpQ0VVcFg4NTFmNStzM2RZWENm?=
 =?utf-8?B?SEVVNGZxbkpXM0Q2cUV0U3Era1BzRm40NVppdXFCSDBSNmhEaGNkR24vRTd0?=
 =?utf-8?B?anRsYThkYUh2QzZ1T3lOMERmaEhsdDVXcVp2VE1yaHo3MVNvNTF3L0VEb24w?=
 =?utf-8?B?RFk5Nlc2dHZNNlkvOC9hd3ZXQ3RmcjAzQ1dWNGxPZ2pUb3Y2aGhFbndScGRP?=
 =?utf-8?B?S2xKK25pTUYxZEMvYjByMzRWWlRFSEZOVlRKMFVLVFVHRlRaZWg3Y3R2NTNC?=
 =?utf-8?B?QUFwbU5oWi95VU9jTVhveS9nL29Id0Nyc2VQQ1N6UzJOOVd0dXJjZjBISVpi?=
 =?utf-8?B?bHlFbW1iMEZhL2o4S0NlR3hXa25oUzlFZ2dNZ25aSXhyWHh4Sk16VGplcEYz?=
 =?utf-8?B?VzgyT2IyMDBnQTdZVjk5NzFxeWlCbmhkQXNOR1N3OVYvaHJONlFKejk1aHBi?=
 =?utf-8?Q?nqUSZEFGGeF1G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHh4azdwV3VIZXlBazN0NDh1bXNMTlNiL0M5ZjI1bmpCM2FLcE90WWR0MEln?=
 =?utf-8?B?MkYrN1NDM2FqQjB6ZVFCR1RzSFJGbXNJTjJma2ZNZE15SFVvWHhNVE5QSkZ3?=
 =?utf-8?B?S0RpdnhoMy9hZUpIZ29lbGlNV1dBV3lxVUtiSmU2ZTY2cHZnNGlhdlZmVDNW?=
 =?utf-8?B?RHFMWXJCV1hsQlRYSkNYVnM5djlrSXlWc3FrNjlLdUpCakwzT0V0V3I3QjVY?=
 =?utf-8?B?QThTQlVYdVlmM3FqaWxocm9WanB3RHE2OU9NejZTUzV2d0xBR3dCWW1SR2Jt?=
 =?utf-8?B?WERqS3RJL2NMSDUwcGZaYW1KNGlYQ2hOZUxHSjFLTitrUlUvUlBWK1haZHd2?=
 =?utf-8?B?ek93OEFZQjBvVXV0VkwwZVJLZHBIblA3TVM0emZXSGpzczdFU3RnWG0zaTkw?=
 =?utf-8?B?TGhWbGRwaWwzSWtBa3V3OTh4bzl6YlJISUNKZVRUdFVWSDlSQWpZcWtaSEIw?=
 =?utf-8?B?NXhBK3g2WFR6djBiSGtkeCsvN0J3ODJ1T2dMZEI5MWs2ajkydDVSS29kM3J2?=
 =?utf-8?B?R3cwZnhlQzE2ZkI3eXRlbkV1VTVKdkROYWtQOWI5SzViZjRLVzNwTXNaeUlo?=
 =?utf-8?B?cHVCRVFyOFlzMGFRMGt1VXJXblkrM0tmZlJxWk45clpxWlRKOUp0U0xLeWRM?=
 =?utf-8?B?TmcrY1E2cExCcExtWWZQOFNoL3RNZWxXYkhWd3k1cVBHakFJZGNpOVQ4MnVO?=
 =?utf-8?B?bXM0OEhzRXc3bXNNc3NTVk81VkhqNE5MM2JBTk5FRFEwKzRSWXVjN05kZGpo?=
 =?utf-8?B?UnQ5Z0tMTHlJY3FjUFhxNkhYOGpNcVp5dWpoSGFFZlhjVDdqNUtEb2Y5M01J?=
 =?utf-8?B?OWVHRE5tZjJvSllydm5wY1ZMbmJ4OUFwVVAvcjU3aVlrMVhaVzA1N1A5ZExn?=
 =?utf-8?B?TDNxdldpenBDY1J6aXYxM04zZWdmNVg5d1lmWkdaVFZNeUNXTlhMdkI2a3hl?=
 =?utf-8?B?aitOUGtDbmJhMm9OelF3MTBnNzBsWlVHZDFqeTlKQmJxMnVVSG1GR2czbWtX?=
 =?utf-8?B?TnM1cTQranlVR1JqVklydHNXNDZ6eVVDdnRSdjBGMHYrVmhiV2RaamJ5OExB?=
 =?utf-8?B?blk2Y1Q3emIxNFVwWXFNNnNpQVUrK3ZGcUhDZXk2eTdYa0hqNGR1Y3pFSFZ1?=
 =?utf-8?B?L3dTR1F1WVQweTVSY0lEOVoxRFhVQUdGaGQ2T05OaHJCNFFZY2VsTFVOak1L?=
 =?utf-8?B?dzAxdE5LcytXRmpzQm5iNnpUMFJPeU9BR2Z2Z0c4TGp2WEVGUnRkajZGcWRZ?=
 =?utf-8?B?ZFRKVkE1ZjV4ZU9zREFYSGNnNCtyU1puYUQyMEhRemp1UUt5VlNoWU4vdXVW?=
 =?utf-8?B?TEUrdHdRNHBGZzE3cUZ2Z3ZnKy9hRENxc0xXQ3BjbVd1ejBMUnA2VVhFRmZy?=
 =?utf-8?B?anN4eGEzdDJWQ0UwL3VWOFBUSmlBaUFtVzdaVnhFcnNrSkR5bTIvU3dFYnRI?=
 =?utf-8?B?WlJuQnQvZ1l5KzlYK1NOSy9ZY0VjZVlMa3RNUEc3RFRnekpFL0VIa3hDZ3BY?=
 =?utf-8?B?VTg3a3d3Rm1yZDFlTzlnSUV4aE5XQmFlNXJ4MktnOTJ3bUxpakJ0NFkwUmMr?=
 =?utf-8?B?QUg2OFp6dXNFUWpZeUY1UENHc0RlSTNSeGQxWStycFBaei91bmNNWU4rNEZY?=
 =?utf-8?B?a25iQXczSk9yaU14czhDSXBtOEJBN3MvdHA0akNuOGQrQ2FyMGcwbEtLb0xX?=
 =?utf-8?B?Y3dRVGhDMWxubmtQa05WNHlqNmVDa291WEVBT0FwazFGQitXOW0ycFNzZ3Jo?=
 =?utf-8?B?dEZGRitkTElERkNZaU1UMmJPTEgrZWg1ZEYwZUtnWWdLbmdEQXEyVTNuUWNk?=
 =?utf-8?B?K1NKQTVNbWlvMUtRczJsd0ZsaVRmVGM4VkNqRTd2M0toWmRSV0s0Rm1iaHVu?=
 =?utf-8?B?czVMYnBidjNXcjM2ZjE5czExcnh3YWovaCtOd2RaVzdtWVBZTmUxSXN6WXJP?=
 =?utf-8?B?SGVwVHh5VlUvMG1MMzFFVTdEcENHMG1yWWZWRURBVGphdFVJZmxId3poUTVt?=
 =?utf-8?B?TEVPalZlNDRGbldNWUttZkFPUDNRVVFWUDdrcEF6ejRSeTJUV01abUhlcTlU?=
 =?utf-8?B?bTZiM0FOU0NRaDJhRmx0MHZ0WWFsVE1iUENWUjI2eWdMaTh6d0VYbUlJenJv?=
 =?utf-8?B?WU14R3B1MWNqTmJadldDb0Era1R5SWxja296VDFYb25nSDJaa3JrY2EwRHVv?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a2eb45-034d-44fe-fc83-08dd618af5c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 17:26:01.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPQU2PBj0qL/mxx9AuUFsKqKWa2XEjjAS0bQJgNndoI5JbFUiN7mzLcgRVW4uvNy/J00SqieVyq9f04PB+Yr4pE32en8t71q6ov5TuQFVts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 7 Mar 2025 11:51:18 +0100

> On Wed, Mar 05, 2025 at 05:21:23PM +0100, Alexander Lobakin wrote:
>> Add the missing linking of NAPIs to netdev queues when enabling
>> interrupt vectors in order to support NAPI configuration and
>> interfaces requiring get_rx_queue()->napi to be set (like XSk
>> busy polling).
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 30 +++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> index 2f221c0abad8..a3f6e8cff7a0 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> @@ -3560,8 +3560,11 @@ void idpf_vport_intr_rel(struct idpf_vport *vport)
>>  static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
>>  {
>>  	struct idpf_adapter *adapter = vport->adapter;
>> +	bool unlock;
>>  	int vector;
>>  
>> +	unlock = rtnl_trylock();
>> +
>>  	for (vector = 0; vector < vport->num_q_vectors; vector++) {
>>  		struct idpf_q_vector *q_vector = &vport->q_vectors[vector];
>>  		int irq_num, vidx;
>> @@ -3573,8 +3576,23 @@ static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
>>  		vidx = vport->q_vector_idxs[vector];
>>  		irq_num = adapter->msix_entries[vidx].vector;
>>  
>> +		for (u32 i = 0; i < q_vector->num_rxq; i++)
>> +			netif_queue_set_napi(vport->netdev,
>> +					     q_vector->rx[i]->idx,
>> +					     NETDEV_QUEUE_TYPE_RX,
>> +					     NULL);
>> +
>> +		for (u32 i = 0; i < q_vector->num_txq; i++)
>> +			netif_queue_set_napi(vport->netdev,
>> +					     q_vector->tx[i]->idx,
>> +					     NETDEV_QUEUE_TYPE_TX,
>> +					     NULL);
>> +
> 
> maybe we could have a wrapper for this?
> 
> static void idpf_q_set_napi(struct net_device *netdev,
> 			    struct idpf_q_vector *q_vector,
> 			    enum netdev_queue_type q_type,
> 			    struct napi_struct *napi)
> {
> 	u32 q_cnt = q_type == NETDEV_QUEUE_TYPE_RX ? q_vector->num_rxq :
> 						     q_vector->num_txq;
> 	struct idpf_rx_queue **qs = q_type == NETDEV_QUEUE_TYPE_RX ?
> 					      q_vector->rx : q_vector->tx;
> 
> 	for (u32 i = 0; i < q_cnt; i++)
> 		netif_queue_set_napi(netdev, qs[i]->idx, q_type, napi);
> }
> 
> idpf_q_set_napi(vport->netdev, q_vector, NETDEV_QUEUE_TYPE_RX, NULL);
> idpf_q_set_napi(vport->netdev, q_vector, NETDEV_QUEUE_TYPE_TX, NULL);
> ...
> idpf_q_set_napi(vport->netdev, q_vector, NETDEV_QUEUE_TYPE_RX, &q_vector->napi);
> idpf_q_set_napi(vport->netdev, q_vector, NETDEV_QUEUE_TYPE_TX, &q_vector->napi);
> 
> 
> up to you if you take it, less lines in the end but i don't have strong
> opinion if this should be considered as an improvement or makes code
> harder to follow.

No no, it's actually a good idea. Previously, it looked different, but
then this stuff with the CPU affinity embedded into the NAPI config got
merged and I had to rewrite this in the last minute.

> 
>>  		kfree(free_irq(irq_num, q_vector));
>>  	}
>> +
>> +	if (unlock)
>> +		rtnl_unlock();
>>  }

Thanks,
Olek

