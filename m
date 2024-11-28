Return-Path: <bpf+bounces-45821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400079DB620
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 11:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AAF164CD6
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D581940A2;
	Thu, 28 Nov 2024 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InYmGMmO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4C18B495;
	Thu, 28 Nov 2024 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791476; cv=fail; b=eUBVKuPXq/Ivt3td26TbyMn3msRbARQmA1J7FHBhs2rxlum8odzQrvkrMR9zcVEKcvl3L7ZqebPrJDhr+1D0JWRINIFd+wYTjqYZqorz7STT8D2kD/odnOPPBgAUjo/QBB5YMmtWDPoDnkdDWQ/kyx9I9UV2lez1RBM0Mo31i44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791476; c=relaxed/simple;
	bh=2P09w+Cf9zIel4L4y3C4fMm8y9OelrGvYkA/h4DnFjc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rn6GZ57bUndLG39ClOKCUrq0V5irG5xH7H8b2GxtY41f9VjfwC7IpnfWyDCg8rwQHkBnZ7WlKJfXlXmyxq3ssa816jNLkb3WB9bykMTiu4wYhiXQ3yW8eNGvLW3x2dFg7FpKjSEu45n3RYg5zYcyPMeglAeadAPYWjpiH8J2Tz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InYmGMmO; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732791474; x=1764327474;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2P09w+Cf9zIel4L4y3C4fMm8y9OelrGvYkA/h4DnFjc=;
  b=InYmGMmO5Qa9e6SlMGQrYgWW3Jz35GWUUCIn7U8MeOlvxJUwVdIekBbm
   28p3/az8W4XsWDaRAz9ZnIGmP33rG/r6T53ZcLdsXRrvLApypTWlJu08I
   pQfn19iz6Uy7i5/TwWCRiqLvnzCHXWYYWaSnOw4dRGRUME6Xda4zPoZ4p
   LSOUGVqSEhlsPhVQBTZoq9Uv87XvMFH8icKkhg4pQw7o3RVKwdQxu5zBm
   PbnALoFCuOGBSfswoVsfTam9WTj6wRfgtD45N4DcTjoVNqx6Izfev7D11
   gaVGTFhvCFebfa779Ht+QHACnWyv617oAFMDvisEf7IER0rBZ1UCEZqVd
   A==;
X-CSE-ConnectionGUID: 4XCySYkCRyOOY3RUL1w+8Q==
X-CSE-MsgGUID: AltIRFoRQ16KloL52ywQlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="50545493"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="50545493"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 02:57:53 -0800
X-CSE-ConnectionGUID: KpE5fRSIS7e6CY3qPIuX4w==
X-CSE-MsgGUID: h8OKWOO9Ri+w4ApaXAWKuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="92017230"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2024 02:57:53 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 02:57:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 28 Nov 2024 02:57:52 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 02:57:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMc5AS7I9TjiUkkB263RyObZL6xFEXIlW4/Eu3hsSg3c81VRcF5Kcl49UIuFjSLZJDiJf7NRi0SxIbBuaSmhVwW7bM1cpVEspCXcm8H6/hiSJ4UWEizkRYKe1a85ceKlIE47vMC+V83B7sNSuIjU3EIBPrPV1/zsQrSWElNqROGXTnfbWRvpslzFjiyy7FxymUEVAYaLSU8c40BReT8G5CVdDyPxg+GCEnsb+9cHKMeqABmUwJ3s2b8WAMBF0xKyUvxLHjZqXksu+nVt+AaB0j5STKioFd/AKevVFxwPtiDYTJn8+a975yMutgaBW76HqJIWv2csrhK/K48w0U1HCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+EKvBd9Bi/RlI8RAAfMQuQW8xGIM6OFeHDT6sBkGbs=;
 b=EBBWX8xZw/k7lIopvh9IAjk3YwhaLzvoS+6RQvDr1kfPguNUgYifkgMRlhmgiZj81ne1n8N/xpdFxvFT2U2m2TNdAcDJBSTfC2VvFZNsVhfTwWxIkss74YlhBPHN2X7aT6dmSeGtMFBgJMlX1ZWkuepX1fBA7nnZ/c69NU4h6YftwbnlvAtUlu/sHIpooZG4NSoCs1+CEAUe0SMxUCzDzbkjykPN0MxlNr5c588nrqzaTMSNmGYdCo4mSlESU3jr2D2d8PD4r8lcJO6Ek3hkpayDPZIjLnRP0Wg9zbpurMqppn3BjWHUZMEU9fxS+f8nDIWJDIo0tblrPJT+37PsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 28 Nov
 2024 10:57:48 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8182.019; Thu, 28 Nov 2024
 10:57:48 +0000
Message-ID: <d9bcfec8-c73b-4781-9d49-93f8dd4c1bbc@intel.com>
Date: Thu, 28 Nov 2024 11:57:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi
	<lorenzo.bianconi@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>, Jakub Kicinski
	<kuba@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, David
 Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com> <Z0X_Qv24e-A4Nxao@lore-desk>
 <3f6e4935-a04c-44fc-8048-7645ae40b921@kernel.org>
 <8d485cfa-eee7-481f-bb73-d00a76d2ab1c@intel.com> <Z0hMWCi6GRrpX8KU@lore-desk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z0hMWCi6GRrpX8KU@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CO1PR11MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: 290c57b0-42de-4991-7cb2-08dd0f9b7ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tkh4bWl4MzJ6RHRIMUdiWEFRbHNaRGRFekJwbDhPaktubkg5anVyOXd0V3ky?=
 =?utf-8?B?NXN4RHZtNjhqNkRwMmVSRUVHak1qZHcrSkd4ZmtoSUpaSzdadE8zL0R6NlpE?=
 =?utf-8?B?QmtnRlhkK0Z4V2VUUXpJMWZ2Vjk4bzRYVmMrSXNjelgxMXFlL3VFUlE0aW1B?=
 =?utf-8?B?dnJXSmlESlFMQ1o4ZUMzaldvNGlIMzJIVS8vcDNDR0lGN2hPWVF5djl2UXFq?=
 =?utf-8?B?S3RpclduS1RwZDhTdlpEbDBlVi9OSjB5MUwxNWRhU2xOV1VkTnRBWGZYOS9O?=
 =?utf-8?B?YzFYUktpTS9hK0MwWHJmeGlxUE1aMmNPdlVBWWJRK2RRNmtEVW9oTzdHVWpM?=
 =?utf-8?B?Q3B0aStmdE52TG9IVzlOZFdrTGhDTzBKN1NUOWlzUk5iV21JRTVPVS9CaFJl?=
 =?utf-8?B?WnVlby8zMDdlRmZ6aUJTcGt4ZHpiYmNqeTNqczVEQmwvMEtSUi9xWXVsOGxS?=
 =?utf-8?B?THhrTlhNanZtU3k2Z2hIV3RqSlNGTWJRR3VxbVA1SVN4L1RGdGYyQXMzS0Rp?=
 =?utf-8?B?Ny9WSFpEMDc3T0pPaHhTUEFqeC9OZlJjUXJlRXdGbE9ETGFwS2s3NG1pSGl6?=
 =?utf-8?B?TDYvMzV3RS9wU1NaMUFyNlFOMmxkQzhWQVM5NHpTNXFpNzlBMEh1NGljTEI4?=
 =?utf-8?B?UUszTUZiTGxMVU9admpmS2xqNXREaTE5S1QzSlJaSmVabnVLTkpZUTJtTEdX?=
 =?utf-8?B?NmZXdGxZSzhrV3hoMHdHK1IzWE0xQUtnOGRlQXdha1F5UFJZVmFOVmJxcTJD?=
 =?utf-8?B?WkI1NDMvelR3UzJRNG5TOWhvV2FqMDhBUFI2RDRSdklhQ3RERmtiNEFvSzZn?=
 =?utf-8?B?NHlhNzZXZTd2bEwvNUtHYmhocVlQOGtTWlR1c3M5QzlJa3VsbkZZbUhmaElX?=
 =?utf-8?B?aUZZU2NiUmRZVUN2TnF2bVNzR2ZhZ2ZRMEpheTNYNEFhdDVwOUFHbGh4T1dF?=
 =?utf-8?B?UmxFUHBCNm1TVUgwaUgzelZvcjhQcG5hTDM0bHBSK25URUFNOGFGYTRCcVdS?=
 =?utf-8?B?ZVhkbFFwcCs3OFdNbjZaUEVUQ2prTkxTcmxKZkhYYWI0OXhROEpNazVxaGRH?=
 =?utf-8?B?RWtVZVQ5RkRYVjJEYnlUa3dURWY0ampPTjdlNGtqelBxRC84TERTb3BlbWJ0?=
 =?utf-8?B?TXdsQVNQdU81T1Z2QXczNEszczE4bUFJNDRodDV4QXhzWGkvMG02UlNjcFNS?=
 =?utf-8?B?cGxUcVJ3YTQxZndwc05CUXFwMTRpM2VnSjBlclJxVU9yNlhHUzJVTFk0WFNK?=
 =?utf-8?B?Mk14aU5CcVRMVU9mSG5wMHl4dUxzWmVyNi9uOGIzM3N6L1NXSWkxUmxwY2ha?=
 =?utf-8?B?UlZWS2hMbTk5Z3R5OGJLd3pXazY4OFFjdE1oeUNDelBsbTNXZGJBRm84YXAy?=
 =?utf-8?B?eG5qSHFQWXcvZVF4VGpaZDRXc0RUSUJuVWNybDN5N1lwTzJ3eHFKcEJ6Umw3?=
 =?utf-8?B?U1dUSFByWFZ1QWFtU2UveUpxUFJTMTJIaXE0NThrNC9PM0hqOHE4YUNJakZo?=
 =?utf-8?B?OHV4dlJjYjNLUmpTdXlVcElpTHVJSUlvUjV6K0pUUkd5QkpOV2NkUk81Mllj?=
 =?utf-8?B?OW5teExianVvSlBOcHVyUGRPNWFwL05IajVsMnQxcWJEdHg1RTZFV3lIeGl2?=
 =?utf-8?B?RkhYMFZGdXVpbVN2RmVNcVZsWml1cmMwRVE2bWRURDE3enFJMmZ0QU81Z3VV?=
 =?utf-8?B?bnNyc25weFAvd3JYMXBBdVdsNXVDdWpmelJnRWY3akh3L0NhQ0tFaHhQbGdY?=
 =?utf-8?B?QnNkRnhST2JSR2lHWEQ0VmkwbUJQdXQ5RkR6UDRlOTM2RXhsdDZ3U0QwNGhu?=
 =?utf-8?B?ckVES25MTTI5aU1pUUtJZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnZTbUFVcDVnbS9HZDUvNWxGK3B3Rmx2ODdYNlJQUTJkTVJGcThZeWx2cHBp?=
 =?utf-8?B?TDU5aE9ITGNHNGk2TVZEYU5JZjFKdFo4RVZicEtxU0V5NFZ2cHcvM3d3eEVS?=
 =?utf-8?B?UjZBNVZ5dHdvUHhYWG9sakxVY0JST0I5YzkyS041MDQyWnhDT0JBdkhsZ2th?=
 =?utf-8?B?b01OUWlaKy9uSEhEWnFwTm9scDhVT2pqa3Vsb1NYbEFvSkZibGR5K2Z2UVRr?=
 =?utf-8?B?ZHQ1cmVyWWxDNzhJRTZFY3hPVXNrWXU1WENqbUNDbHJUTGdVaU9kQkV3cTJa?=
 =?utf-8?B?VCtpS2hOUWVuNnpaSjVKblZBaGI4NHhjbS96ZE1vdUZCekpGZngzWi85M2Vh?=
 =?utf-8?B?YzF3dHVvaVMvSlhkQXB0TVdTS3ZFOFpKK0huakNhc3pmaGQ0dk5kRTMyWWhw?=
 =?utf-8?B?Z1FaVE11ZGt2SHRSSG04Q0tOZW10ZmoySkxrLzUwK0Z1WWNGVStHbjV0dG5D?=
 =?utf-8?B?Um44dkx0MVFiY09qMHBnQ3BGM29PUTNKR1R3REtFeHpFRWd2ZWFWdDFrRzR5?=
 =?utf-8?B?MlVYYlN0Q29IQXpaNmR2U0dVYnU2a3FuYXA0RGtPeG9xQUtZejY1TUxaWVE5?=
 =?utf-8?B?TlRZNncrb2h4Y1RBMThCWGtiQlBPSDFIbzVWZ0Nmdi96OC9Dd2dBZmFCbnNh?=
 =?utf-8?B?cjVpOGNVOWJPa2FKMWpjWlpxTS85Y2JmY0w4NHpGblg0SkVxcW1wRGlEMXho?=
 =?utf-8?B?NVlBUFdkTjlINEEwY2hPYzV2R1pnMnhTalJuOGZQQmdTTDhpQ0tHdkhGcXpQ?=
 =?utf-8?B?YmtWSldjUTROVnFyU1lpbDE5RStoT0Vtem1QWi84dEtSUG8wZ1owcm5pc3lE?=
 =?utf-8?B?YnEzRmpDNGhwOFRFVUJyK1hrKzkzem0zZ1B6NVZ0bng3ZmI0SkZ3VE9kTjRW?=
 =?utf-8?B?MjFiK0JOZkxoM20yaVRiV2J5WWNWOWE0VS9sU3VFYTJ4N1cvaDRYSTFoSXZo?=
 =?utf-8?B?VzlkbGVEbjY4ZEdJTmw4Um0ycjdtK3Rja21UQ1RjVzVlcDZJYVh4UlVMK1Jz?=
 =?utf-8?B?bWtzSWpVVkJoUTJlN0tmY3pOU0lVRWp1NHYvYXZMTmk3NWRTQzcxekd5SDNI?=
 =?utf-8?B?Tk45VWZ6cVZyTVkvWFZMMXU3UlF6YTZTa0ZxVG1xZjViZlBmYTUxQnZsUWY4?=
 =?utf-8?B?cE0xd2k3L1JVdEJqaFVueTBiM2pyKzhBWEd2SWF3OUdHMjdnbUk1eXcrOHVR?=
 =?utf-8?B?elhRZjloU2pmRFp1UWhUdThiclg0ZDlJOSs2b3dOdXE1V2FxSEpWNXhYVk13?=
 =?utf-8?B?ZXJ2YWxwd00xS1hTYnBGUnA4V0pTYUdjUmxuWm1jZGlCL0FqUWlrOTVQb01a?=
 =?utf-8?B?YVJ6VEZ3bmJNS0hvWG13U0VzYjR6Q2lxVlhINDR5Vk03eGxhWlpnNHhpcFJj?=
 =?utf-8?B?TVRZTVZYTEIvbHcvQ05WSDhNNzQrZEgyQ0dNdmJMaWIzSjBTeDVBOTZYU2RP?=
 =?utf-8?B?R2hIRzdFSTJyZ20vTmgwcDdCVHF5K2YxMGR2bGhHYXZUc1dYejZlWkswakV5?=
 =?utf-8?B?dE5uQUlRTnhBYjRTczZFWGZHaVp0cGd3VE0wU09ucDc5WmRLZkZqNlVHTkxa?=
 =?utf-8?B?OHRkTnRRNjBiK25MTEZIcVdlQTNkNndtVzNkQkVzeXZnVmdDelpKWXBheWx4?=
 =?utf-8?B?ZjFNekVjVi9BdUFjMko5ay9ZYWlmK2pTUVhsL0UrSGFES0ZOMjlVUDhsd0Zi?=
 =?utf-8?B?R2tzM296NUtBbGxhVEJtNy85UkNjVjF2ZTh5MDJLeGErQjkzb2g1Z0RQZlNs?=
 =?utf-8?B?ZGx5V253RmtKNlNvTkEvR216Q0YxWG5oNlBaRUdqSG5WdGh6MzE3cCtmWUJa?=
 =?utf-8?B?U01INjdpQU4vcmVCbm8yRERNUkI5MldvT3lMb3ptVEd1QThtN1MyZlRMcFZ1?=
 =?utf-8?B?anBQYXpFblVUbGNCaFVqK0FROGtEaGthMzBrODM4OVZONGlVYzYxVnBlYUlV?=
 =?utf-8?B?TGM1YWxVV2NIbmlBNDFOQ2dOM0pNdGRkUlY4cS9ab0p6VVh4cEw4SnJJMVRn?=
 =?utf-8?B?QnR5eU9OSC9UZm12enBuYU9jemdGdzBqeFIyZ3cwVmFnWkl2VElxcEZqZEVv?=
 =?utf-8?B?VVBnVmNJU1lkYldFNC9vanVPMzkxanBoaWgxblllNXpOSytOcEVhTnhjZjJR?=
 =?utf-8?B?MHJ3K2Z4RFJoWTlhVUxBdFRRcUU5Q2o0SDRua1B4YkUvZlU5UHVkaFFPd1ky?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 290c57b0-42de-4991-7cb2-08dd0f9b7ef3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 10:57:48.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaELLkZg28SRiiETAwUE7hum2BCXxjS7MVR0hHqrkofEET85a8ptIrXjdcmt7Q6D5X1jJfOxUIL0t6PQmigMkBzEW72vLxDK1Fw+XIqEye8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
X-OriginatorOrg: intel.com

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 28 Nov 2024 11:56:24 +0100

>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>> Date: Tue, 26 Nov 2024 18:12:27 +0100
>>
>>>
>>>
>>>
>>> On 26/11/2024 18.02, Lorenzo Bianconi wrote:
>>>>> From: Daniel Xu <dxu@dxuuu.xyz>
>>>>> Date: Mon, 25 Nov 2024 16:56:49 -0600
>>>>>
>>>>>>
>>>>>>
>>>>>> On Mon, Nov 25, 2024, at 9:12 AM, Alexander Lobakin wrote:
>>>>>>> From: Daniel Xu <dxu@dxuuu.xyz>
>>>>>>> Date: Fri, 22 Nov 2024 17:10:06 -0700
>>>>>>>
>>>>>>>> Hi Olek,
>>>>>>>>
>>>>>>>> Here are the results.
>>>>>>>>
>>>>>>>> On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>> Baseline (again)
>>>>>>>>
>>>>>>>>     Transactions    Latency P50 (s)    Latency P90 (s)    Latency
>>>>>>>> P99 (s)            Throughput (Mbit/s)
>>>>>>>> Run 1    3169917            0.00007295    0.00007871   
>>>>>>>> 0.00009343        Run 1    21749.43
>>>>>>>> Run 2    3228290            0.00007103    0.00007679   
>>>>>>>> 0.00009215        Run 2    21897.17
>>>>>>>> Run 3    3226746            0.00007231    0.00007871   
>>>>>>>> 0.00009087        Run 3    21906.82
>>>>>>>> Run 4    3191258            0.00007231    0.00007743   
>>>>>>>> 0.00009087        Run 4    21155.15
>>>>>>>> Run 5    3235653            0.00007231    0.00007743   
>>>>>>>> 0.00008703        Run 5    21397.06
>>>>>>>> Average    3210372.8    0.000072182    0.000077814   
>>>>>>>> 0.00009087        Average    21621.126
>>>>>>>>
>>>>>>>> cpumap v2 Olek
>>>>>>>>
>>>>>>>>     Transactions    Latency P50 (s)    Latency P90 (s)    Latency
>>>>>>>> P99 (s)            Throughput (Mbit/s)
>>>>>>>> Run 1    3253651            0.00007167    0.00007807   
>>>>>>>> 0.00009343        Run 1    13497.57
>>>>>>>> Run 2    3221492            0.00007231    0.00007743   
>>>>>>>> 0.00009087        Run 2    12115.53
>>>>>>>> Run 3    3296453            0.00007039    0.00007807   
>>>>>>>> 0.00009087        Run 3    12323.38
>>>>>>>> Run 4    3254460            0.00007167    0.00007807   
>>>>>>>> 0.00009087        Run 4    12901.88
>>>>>>>> Run 5    3173327            0.00007295    0.00007871   
>>>>>>>> 0.00009215        Run 5    12593.22
>>>>>>>> Average    3239876.6    0.000071798    0.00007807   
>>>>>>>> 0.000091638        Average    12686.316
>>>>>>>> Delta    0.92%            -0.53%            0.33%           
>>>>>>>> 0.85%                    -41.32%
>>>>>>>>
>>>>>>>>
>>>>>>>> It's very interesting that we see -40% tput w/ the patches. I went
>>>>>>>> back
>>>>>>>
>>>>>>> Oh no, I messed up something =\
>>>>>>>
>>>>>>> Could you please also test not the whole series, but patches 1-3
>>>>>>> (up to
>>>>>>> "bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse skb
>>>>>>> array...")? Would be great to see whether this implementation works
>>>>>>> worse right from the start or I just broke something later on.
>>>>>>
>>>>>> Patches 1-3 reproduces the -40% tput numbers.
>>>>>
>>>>> Ok, thanks! Seems like using the hybrid approach (GRO, but on top of
>>>>> cpumap's kthreads instead of NAPI) really performs worse than switching
>>>>> cpumap to NAPI.
>>>>>
>>>>>>
>>>>>> With patches 1-4 the numbers get slightly worse (~1gbps lower) but
>>>>>> it was noisy.
>>>>>
>>>>> Interesting, I was sure patch 4 optimizes stuff... Maybe I'll give up
>>>>> on it.
>>>>>
>>>>>>
>>>>>> tcp_rr results were unaffected.
>>>>>
>>>>> @ Jakub,
>>>>>
>>>>> Looks like I can't just use GRO without Lorenzo's conversion to NAPI, at
>>>>> least for now =\ I took a look on the backlog NAPI and it could be used,
>>>>> although we'd need a pointer in the backlog to the corresponding cpumap
>>>>> + also some synchronization point to make sure backlog NAPI won't access
>>>>> already destroyed cpumap.
>>>>>
>>>>> Maybe Lorenzo could take a look...
>>>>
>>>> it seems to me the only difference would be we will use the shared
>>>> backlog_napi
>>>> kthreads instead of having a dedicated kthread for each cpumap entry
>>>> but we still
>>>> need the napi poll logic. I can look into it if you prefer the shared
>>>> kthread
>>>> approach.
>>>
>>> I don't like a shared kthread approach. For my use-case I want to give
>>> the "remote" CPU-map kthreads higher scheduling priority. (As it will be
>>> running a 2nd XDP BPF DDoS program protecting against overload by
>>> dropping packets).
>>
>> Oh, that is also valid.
>> Let's see what Jakub replies, for now I'm leaning towards posting
>> approach from this RFC with my bulk allocation from the NAPI cache.
> 
> I guess it would be better to keep them separated to check what are the effects
> of each change (GRO for cpumap and bulk allocation). I guess you can post your
> changes on top of mine if we all agree the proposed approach is fine.
> What do you think?

Sounds good as well, I don't have any preference here.

> 
> Regards,
> Lorenzo

Thanks,
Olek

