Return-Path: <bpf+bounces-76864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF2ACC83ED
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 15:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0652F30E317E
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BC43A5C3B;
	Wed, 17 Dec 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixS77EHi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D333A5C12;
	Wed, 17 Dec 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982117; cv=fail; b=kKUW9jp3oC9Wfitnt5Mmma/xbEQdm0h11MSkA2QmXX8CLsa8WxExkoxI+3uz66hXya9zly3UjCNDlklNbmZGiVPIlKu6Rjo6GjHgxOd/nQpj7JpGRZqFe5yYQgWltmojb5C+jfE4vOCGr4vNNQEcnSG2hRMmA1aqu935UOkQ4+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982117; c=relaxed/simple;
	bh=yjZtLkp0hvEuMkBFRkRVxot/zFhfhTpHO6kbbQw3oUI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GBiWu/GldYLCX7Fb6UIuCd73gnO6sEQSCe69v1FlchtQvcN7Bp/WhcV504q7f2kRivs4IzBfiNyDCXVLJbAPt8wY6mjv55kmo/oRyHABjBHLiiaOnaoyL7AuBpQ0d8kVtzaqVkBxXbzUQJ8kVAYTd7n9/64BM4VJO+QWzsLx+80=
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
X-CSE-ConnectionGUID: Fkg+fOHqToGH5nmluArq0w==
X-CSE-MsgGUID: 7EfXnmuFQLSchAgr+rLLFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67859163"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67859163"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:35:03 -0800
X-CSE-ConnectionGUID: maAxXn6BSqKFIJSl8dvyUg==
X-CSE-MsgGUID: AGIGrypoSVOrWQ/pMxCHDA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:35:02 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 06:35:01 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 06:35:01 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.12)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 06:35:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJ2ZSAmavsLEOKELTkqEGmB09xZkOjmNdGeILh3HE3Zd6JODkTBGTgxUgkd5VyZ/ck5KKd7VWTwtgN1wO00p9uqIEJ1X2JMM5aK/nLsYOsZrDRcBs6/X1bT9B9tX15jjTtTmni5X3D8GY6IfVHCN2MpZYGu8TXtIJi1CjHEZ1F65oHPxMu6N6QEVwcblQAdPZO2XXl4q/hKaDirRlGHnAOcuB6hD45jNd4DAZGUfqo2G6hQRd3bWltF00g7whpU0efY0xdQF8IGfDho8Vuqnp0RvDuUmLl7i+rPdNBPEIVL8z9V/J0jg69RUZNbuA+KwQChLpmA8odL+vk04fiYFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41JLnqfl+85SZb8MrYMj6xKcy5Ud+ZhP1qNBRGf0RG8=;
 b=xzHeeyUHOvgfva7hkKovV6UFRNKHyzlNxK/cYBua3EpAPJMIUP/VRGudy83GiWUZtYaT0BeZHkHpF7O1Npv5vs0IM+5RiXzwl08UEKhAhvUjV89K0yRm/9ojNNy51DDGz8TlGzHAOt9x4Sfma0gmcI3wLAHVvJB1rKsH8+lkO+ATVwby4l0EwyVJj6qMhd7Pp73ne6FWekM2TvPmtZ9eSJ6WjbGyPEt0obe1KE14fBawXRB962xj2HgzdhE+CrrAxkymvSO+uVD4pL0UnI9N83I0GzzOYcrAuDb/cG+au0Vx9rCRjVfztXb/XKh09WLErdCC2u5WwBkAcpueKrWJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6528.namprd11.prod.outlook.com (2603:10b6:8:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:34:59 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:34:59 +0000
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
X-ClientProxiedBy: VIYP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 82464228-1ae8-491f-0ec5-08de3d797496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkdxcENnUDRldERxTXNKRGU3L2RPRXZIeFFIRU40cDVLRUwrMjBoaUVicW1u?=
 =?utf-8?B?MitaWjVlN1Z2ZmRPSVByR1B1T0x0eHZDNmVOaTNVaXFWR1IvY2FPbDZzUVJp?=
 =?utf-8?B?ZHJkMmRrbFl2OFhBbnA2NDc0bkpGNVkwTWdsd3JIYTlVSXZaMk9KbUlGMWZn?=
 =?utf-8?B?QXV5N3NPOGZ5UGJwZm9ySS8zMysyL2ZQTm4xSG5IZzk4VERielpoNCtnTGht?=
 =?utf-8?B?amsxSlRLaHdyVkEyOHV4OEVqTHdadEtiYk43MCtENE00eXhZSUlOZXFoT1hy?=
 =?utf-8?B?OFliS0k2ZlcvUlJKcUh2U2pxNGxQOWpZdnBNR1RoWnRXZDN6ampJWDIwd0Vz?=
 =?utf-8?B?K2d6UGdjVS93ZFRFMUc4QVRQUXpQWDV3VUVZQkQ1TTROMUdHL1lYVndkUEpE?=
 =?utf-8?B?WkdOeWhJSFlZZi95eEtWYXh4cUNlUzRuRmJyRWtycDdPWlc5dXN6UE92aHR1?=
 =?utf-8?B?czkrZDZNNXVHdjhOVnFrUGFiWXlKa1FZZHAwVWk2bktSaVQyMWJvZldFdUZG?=
 =?utf-8?B?R050dDk4bUV3MFl1MTRBRmpGQVhPUE9Hb0tJL1R6djAvd2I0UThxRi9CSDA0?=
 =?utf-8?B?YTlWbVljM3cvOFl5RDBXcTYvM3dtK1Ard2htcGxJa1lnNUJ6NDc2bWk3Rzlt?=
 =?utf-8?B?eTlka3BGNUVtUEtTb1l0WHZZMDZ6Um9LWm1TcTl1VGdVMUJHdmNVaDRxTVdW?=
 =?utf-8?B?OVRFNE1kOTk5WmNFZWQyRXAvcUowbXFCMkhwVXpsbTFkNnhxT05Td2hDSGRv?=
 =?utf-8?B?RXFteGZ5YW1nTmR5ZDdPTHNzSHlBUEtzR1UvNHZGeSsrck9GclNTQWdoRGMv?=
 =?utf-8?B?TCs0QTNYbkdHcDBHZGxKZFFjNVdKa3Aza0lMYXhXSEdTVit6OUdacHZkN3V0?=
 =?utf-8?B?MnZMNkJCQW1UdFZ3SzlEK2pKRWJSOWtQQllNcURsMEtObHphWjBXRlJUVU93?=
 =?utf-8?B?c0lBZ1o1QnJMSFcveUp3cmQ5MHlIRlY1UjVFSW1DYWhCZ1FQc0lBZFpZMGVs?=
 =?utf-8?B?VXZMWDZqNFFVbW15ZTVjQnVoejU1UVlmaDZPYnBrdnBvUXd0bHFpUGp4OG9Y?=
 =?utf-8?B?TmJFb3pJd3ViQkNOdjY0WUx1UVppMmY5Y1NuNU8wSU1kZHQrQTFiNEk5c21N?=
 =?utf-8?B?NEVmdktZMHJUUWtxa2t3YWZ5eXFOZkM4LzhQQTJubVJodEgybkh5T2QwcE5E?=
 =?utf-8?B?NDcranFlMnZBL0xUUWd5ZVpQOURnVWEwR0dVbHJQMnU3VjZCL1ljQXY4WkQ0?=
 =?utf-8?B?NWJFUkd4dVZrS3JFYmpDNG9GUVdjdzdXc25RcE5wQTB2bnd1UE1HcE8rZmdq?=
 =?utf-8?B?OHVGTi9DYUg2ZVl0Q0NaQng0N2M1c1ZFZG1jdC8zTHQvUWRtKy9KZVBISGpP?=
 =?utf-8?B?TDFoYTlxTDFBa21tTjZ5U3JUdHFmR1IrYUdqUnE4cEtJaTMwOG9ZN2dhRWNi?=
 =?utf-8?B?bnkweEJ3dXRSRnA4MENoZnd2UHlGSEtGZjl5aU5JeGkyTHppemcvcTd2dHRa?=
 =?utf-8?B?Y240S2hEbXRDRWFJdS9HVU1od2FlTmZlN1pVRENPL0ZoTVBVQi9PZnhBOTVy?=
 =?utf-8?B?RlZEeCtGemVKRWJxVWFTZVB2Mm9WeDlEQWFhcEtHNG5lWFVVS1RBRmtxd3M2?=
 =?utf-8?B?QklWVUxQRk54b1E5T0tuMW0xcW1LNW1JRTVNaFRnTFNsMXF2ejg1T3RGRUxw?=
 =?utf-8?B?amNBYW9DSXdyMm1lcFR4NW9nSTYzV0ZzQWFJakM1K3dROUczWjhXRFpJcVkr?=
 =?utf-8?B?azY3VDIvcno1dGN5Z1hjZUZTS3dZbk1aQ01kMU50RUNSN0xSc3ZkYURtRldT?=
 =?utf-8?B?bXovbjdLdkhncGw4ZXJSZ1hOd1ZpU1NPSWR0T294a0NLbmc4RTh3aFZ1Y0hX?=
 =?utf-8?B?Z1FnRVBUcWh3Rm53bFlOMi82NnhyMnZNUTRQbi9aWjdPUzRZLzNvOWl0VEh3?=
 =?utf-8?Q?YYkQuDjoQbp8FHqcK8e1W6Jbd3wIELEu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmNBQ1I2SHluS1V4ZzRjOXBrUGpQRW1OV1NmMjUzd292NFRWdjhjbi9JcTN4?=
 =?utf-8?B?bTgxRHc0ZFpBMllacHdvVU5sYWFxSDR2bVk0N20vVUUvd2xDUS9CdzBPSmpX?=
 =?utf-8?B?WlRzbjA2bEFONG82a2J3Vk4zLzkxZ3BHSWVNV28wYWhYV1VBRGhSTG12dkIx?=
 =?utf-8?B?c29zZThlWDUvTmJTV3FlNkNYVCt3TCs2SDdMQ3NnQWlqcm5rMk1ORDVSdVA2?=
 =?utf-8?B?ZmEwWVZaVlhXK0xQT1ptZTR2eG1ia1NQbnp3VTQ4dmppWDFLTFZmQ09MK1Zs?=
 =?utf-8?B?NVNzZmllRFVjcGJMOWNDa25UaHYvRjV0WmdUWmVkOEFnWC9ROTlQTjd1WWRS?=
 =?utf-8?B?T1hvUXhxSHlhY1FXdnM4VVNUelJZZjBXSEdyVjVPL1NTQTlnWk92bnNENW5R?=
 =?utf-8?B?T05KYjBVSDFTMDVubWZKZm9SY3NoTFFUdkNTbHByRTFuV3B6VHNDUzNVSVA2?=
 =?utf-8?B?b09OTlBLRkZKeTA1djFrSGI1ZEZFdmtNNG4ycUZjN1hiWWZQVnI4QUVJdG5E?=
 =?utf-8?B?SjNBRjMxR3g5RWIvdDBka2t2bjloenpycDJRb1dhMG1UdWNyNUV3amNxV1Uv?=
 =?utf-8?B?blQ1ODExVGRZV0xMNUJtVEdlRHlaS3RFZGQrYWhwelFoZnRkRzB2S3d6Y1NV?=
 =?utf-8?B?YjVYQkdaRERrS2Y0YnE1YnBHQTBqYW9Sc29QL3RmMkMrUHgwZHgxNGJDa2RI?=
 =?utf-8?B?QjA3NDBkd0l3dTc0TzFOQUkxTi8zai9TM3BlVVUxa1l4Y0lNaW5PVEozTWxk?=
 =?utf-8?B?UElRZXBESnB4dWIzWmMvd3YycFZOMzBGTytzdzZvNGpVb2d0ekNPYzB4NGNq?=
 =?utf-8?B?dFhicHk2b0tSUU5UTmNQRGE2bTRWaG50WllhWGc3d3krT05NZjZaOTl2dVJv?=
 =?utf-8?B?eGNaV0MzbTVrSEtCZ1NpSDA4S0VrZGZTbDl3RUFOa3BEendJT2F4YnRBaE9n?=
 =?utf-8?B?N1oxc2JGbW8vTkcrOTlMeGtSUDZQOHU3SkFGcWpsb2xGS3I4WUZyenJ6UTJa?=
 =?utf-8?B?YzNOZER2TnBVb05icnRtZFRxdWlmWnVHOURJMmtEUFIwZU1EYjFzQzA4UThC?=
 =?utf-8?B?UHNmYUxuR0xZampPbHZzYThVMjZoa0Z3K3pWSHRVMGFZcWtRMkk3M1FjT3dt?=
 =?utf-8?B?RXk2RnRnN1pEckdJbXlBaEUrajY4cnNmYncrMi9CcFFaWHBBYnBTU1puV1J4?=
 =?utf-8?B?Smh2ZHcrNXQxdERYc05FUkY1czBEbXBlTDZ0enhHWmtqRTB2OGh2ZzhLeVJU?=
 =?utf-8?B?Q2NkajZSMXJXS0xxSjZtUTR1UE5KVnFzTEV2UnFXMGJ6WkxWSnpoNExrUXNp?=
 =?utf-8?B?dmxyVjdHdjRVd2xMY0p4dXZza2V3Z3dQT2ZkT1UwV0VYNUZ6ekwyWFFJOWhz?=
 =?utf-8?B?SGNLbzFvZGkxeU1WUWdHZmJVYnoxbUlrTmh0TTlGN003eFAzdTdCcnNnNkxN?=
 =?utf-8?B?L2IzUjBaSlNNSG9rQlczOE5iM3dsOGo2YWZMRVllRzQzZnlxS2pJRWFhUlBO?=
 =?utf-8?B?SlJNaTNBNFNMdTgyQXNsNWZkSmFyV21IeW1CNjVoVFhGbkd1VzRwUTlrK0dp?=
 =?utf-8?B?VUdSZ1FtMnpzMjVpdnhZRk53RkRxZFRiM3NPa2VrYjRGU3Y1cnd6OTVVa0NI?=
 =?utf-8?B?TU1ESG5Lanptd2hJWjNIbE1aQnJWcDJnd0oyZ1pVZVM0UGFCWHQySW9nQlkw?=
 =?utf-8?B?NzhRdUt5UjlVbW5DM2lPUlVwVEZVeVlXbEZqUHMwemMxY2w5M002VXQrUDNx?=
 =?utf-8?B?OFZCd3l5TWkrRTcwdmlQcHFGd0hESWErNVZQV21vbllpREdhMStaYy9zQUN2?=
 =?utf-8?B?M3pzKzlHNGp1cTNLcy81ZzMrYy95T0owZm9GdFJzS0dCaUh3ZkZFSmVabFg5?=
 =?utf-8?B?SzZHWHZBUDZ3ZlZNcGcvWjdBRE9kZHhhODhlcjRzYVVyRFVPN2lzdVJyaVlJ?=
 =?utf-8?B?TlZMYzFrUWlMYndhMnBiWkx6T3plNXB1NXl0V2ZlN1N2ZHR5MDBhbVVlYSs4?=
 =?utf-8?B?WVNwdjVlVEZyYjdmdEliMmVmU0VIV2VoWmdjekt0TzhmWHgvS05UckNZY0lD?=
 =?utf-8?B?RmtQTWJYVGdzWUFxSW5QK2xyTEFmWXUxQndtTjdoM2pTWU93eGRsSnNyNlpu?=
 =?utf-8?B?UGtHNzFJTmk4NDFKd0hZV1NOdWgwdjNTUzFiU1NqTWhyK3JYMmlBemlBNDAy?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82464228-1ae8-491f-0ec5-08de3d797496
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:34:59.2568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxnyUPYUxnijgvawPn91h59OzHF2vv8SFwWYGYYG9Pdl78hUqYjEFuQ+vGM7iTM8y7vY8oHvpUNzqZvQA/7xS0om8o+2bUlTDAUubgKWR5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6528
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

