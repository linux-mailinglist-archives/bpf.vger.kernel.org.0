Return-Path: <bpf+bounces-50666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A96A2A830
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 13:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C873A7D63
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 12:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D86022B8AA;
	Thu,  6 Feb 2025 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaSDh7Fa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D212135A5;
	Thu,  6 Feb 2025 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738844133; cv=fail; b=WziMOSJimaalIgoXM1AXF3BhuBX7hDCOv8/MCbEME6/CVq9fPg1FNshoVefc9c+5WPAp69Lmql+Uogmmzahndk096Wb8gzyobEUqhqUAycoetlmsB6QaNCfpyHAxnjlLvqarBBb7NqG8K32PEVLgp5pBwTPfl3aURvVHWMwyhRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738844133; c=relaxed/simple;
	bh=sduliqItnl+/Mj8Po0dS4rhD8e+N++5UPdljKZJFm1I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=huMVI/H+dHou8WG9MujB3/obM7wryGBMQOB9tUUYWMdp6IpRdlAwe7IqyZjfItUGGN0LAudRrLGa2NHq7YBtQc0pblsYnEsA5Hu5lSta0ML4gnRy8tvICmZIFrpX/Z36kJ+TFYTet7RvEe2eQEuWVgivpqHkhHH9fVbc+bQzSAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaSDh7Fa; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738844131; x=1770380131;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sduliqItnl+/Mj8Po0dS4rhD8e+N++5UPdljKZJFm1I=;
  b=PaSDh7Fat0wamjDN6uGOJzailXtxpqsiTuvydpPSVhIc/Zpa/T/cUcg3
   MWScFw/ukcyx+GXpqovNuVdnAbgZ0qnaNAPt9iu5GUI3aOrihd/OM+VFd
   967wjOmMzCiSv+vjI1Bsyjnco34omIIXn8wLZjAtXftEBKVa/0hhHRFD8
   diqhkoMvk0Z1/VPTV9zV/4kQ2KhbWhVGjig6279Wiy3ZF/6sL+smccntJ
   +SK8kibRz0cp0YL5LcO70A+Y/EnxGHc6tocg+fX0bLjdecjYh0NbFZQ0M
   I3SVQRdWYAu52CPks49gbeLug7Ujg8R/0htThDCDDgChg790QuUwaFP2P
   A==;
X-CSE-ConnectionGUID: Ri9SK4uyStaC7q2o+tZvDg==
X-CSE-MsgGUID: 1lZkJjGVT1C/iq9T6sqzXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39138584"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="39138584"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 04:15:30 -0800
X-CSE-ConnectionGUID: FSnuv1IHQ02g17HJ8V6Cug==
X-CSE-MsgGUID: MK1Yi94zR/yUFw762cISQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115279870"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 04:15:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 04:15:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 04:15:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 04:15:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF3PYp/HrYecF41SBDYJ5Lz/v+iObPeRKi0Q9DB/1TqGx2WrpetkRDDTzQ318b6t/yigKY7n5vgRpBkknB1RTmkwUVQSPGQVXcWUxiMIZlAFQ3rwbidbsXTEl5OHpazakowCOHh73WsT7t7GtpOPXpyRUbJSOAa1dq6eab6ExPmke1m7+S11exndJV08L2oKY6I1SuYnFq3nElW9RUze+XidzGW+reYYdnLfMwGiX+pGgadjj1HYMWD8XPwUcuDvx5oDkekDODq0uy+uF0vRQqPPXqS+bxJqbOHXlk/0Z/NVgwpinb8bdCbumgwb4owSJlZ3WvLMQUlZihCI0NInew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUtNmKGMyF1EtpyUXoVU5BPCtw1UnxggdEveqs4awDo=;
 b=b/NILc2y5kAIU132AOGhDJPvKxhcfxWrC1lwiJamnh31Ub4sh60XaludeZXr9t+qfc6bGLMxPHKP/BWngxX+XtMtrEnSXyK8HmnLoxMuF6QggFvhtzyfaDfpKkvy/5GaH49UW02EtwD0YS4zciS3ZPkimpC2JcoZ7Wx78etwYLj+KzmRcy+Jn0XNRgdBcwKtrt1HhOensIL5zYcjHKKzoihVaWi16j/FbTdVIwo0jk6/u4tuzWzfwsOflUvnva7bnODE01ya+g83ICymatrWlv1PooiYi0leas969mWQfe91wM3308FsJTEI9EZGpHtAbvOgcYaR4nnao+w7J4MHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB8480.namprd11.prod.outlook.com (2603:10b6:510:2fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 12:15:24 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 12:15:24 +0000
Message-ID: <fe1b0def-89d1-4db3-bf98-7d6c61ff5361@intel.com>
Date: Thu, 6 Feb 2025 13:12:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/8] net: gro: decouple GRO from the NAPI
 layer
To: Eric Dumazet <edumazet@google.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu
	<dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
 <20250205163609.3208829-2-aleksander.lobakin@intel.com>
 <CANn89iJjCOThDqwsK4v2O8LfcwAB55YohNZ8T2sR40uM2ZoX5w@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iJjCOThDqwsK4v2O8LfcwAB55YohNZ8T2sR40uM2ZoX5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0029.eurprd05.prod.outlook.com
 (2603:10a6:803:1::42) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2531b6-ae51-4b5f-4d1d-08dd46a7eee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWs1dmcyWFJDRjlRSlZSNXZBSmxDUzgxaTFqOVYwYkIvdVhvUHczWEgvTVZT?=
 =?utf-8?B?T0xFSHQzMFFOQ0wzbTY1djI3dUFIUjU2dnpUVFJSZkFhUEVUMFk1VjhYSXM3?=
 =?utf-8?B?NGE2OHRWeE9lN05Gb0xoRE9GS0JGYWVHbXZxQ1p3TVA5VkQxL0l0VUJjcWNy?=
 =?utf-8?B?UFh4dm9OYTVvSFZFeU9ISTdqQlZPUGE5SGNEc05VUTdCdXltMlJKT2psRUlh?=
 =?utf-8?B?cmU2YzZ5dUZlRGRCaVdyRXZzcWJZKy9BRFg4RXd0aDBId3luYWlLc3JzN1ZM?=
 =?utf-8?B?MkVnczIyR2V0YWdHc2F4T08rU3F6amdtWnp4bEVHajQ1WnlRK1NwOTl2WVlr?=
 =?utf-8?B?VGVoOURnbjNtN2Y0Lzc1b0kxZklkd2x2ZTJoU3NoTjllNWVuTWRaSGEwdTB1?=
 =?utf-8?B?d3RCWU1HQjI0b0N3QjZMbVMvT2RZNHNBSytSdjRzaVQrMWJqa0NEWVExQ2hE?=
 =?utf-8?B?NWJoSy9ZbHJLcVlxcDgzb0pjWVROQ1Y0UUhHZGc0a0xyUFBUM2VWcVQyYS9v?=
 =?utf-8?B?dEdlWDQ2c2dueS9oV0EwR2VYN1U0OUNSUk5mVzd1VFZINW5pZkRna1g2Qisr?=
 =?utf-8?B?QkI2eVNRc295MUJtZUhNRHlDNVB4L25JeUd6ai94TDhqeExveTdidk1KTEZE?=
 =?utf-8?B?YVl1QnZiZEw1c1JxME10b2d0d2IxSGpSUm1MTUEzN2x1bTY2OEtCRW9GUzJP?=
 =?utf-8?B?Q1VOcG5OcmtuTUY4MVNaeXBZU1ZnTDlxSzJZejlxYnhYdWlxNjdGa2w1dWho?=
 =?utf-8?B?Z0RwTHdUai9Id1V4YkZLMzZ5NU43WnlkeEV4NkkyejIvRno3UGJncUxuMmR5?=
 =?utf-8?B?MXNpWEhWQ3B6TTQrMWNFek03Um1HcnEyb2JjK3hnakZoQ2twL3E5dXFBUVd6?=
 =?utf-8?B?TkVCWko4VlhYMndxV2FSV0ZRU0VvQlFOK0FvSlZSMXdyaWZxQ1JpRzBab0tG?=
 =?utf-8?B?KzNubzdBUnNacEJPWVQvR2tOc0Zqb1V5N2pyckpQb2NYc1BRLzZra0JnTk0y?=
 =?utf-8?B?YmM4aHF3M1RjcXhZU0YyRHFqVmorQ3VJTXh6Ym9sVllxdC8zdjlZWll6b0lj?=
 =?utf-8?B?OFp1cjRqVFVmbndlTTBiZ25GUWw3eDlxYVRYbnluV1JuZkJDR2J4S2xMOUwz?=
 =?utf-8?B?M3NaRENXamFzWVp6R0NYYzFDT3M5SWYydExCR1M3WE9uclY2Tm50WFhoekc4?=
 =?utf-8?B?bVJMY3dhVklhNU96WWF4Y2VzdFlpYkxBRm96OXJZWTdFcEhBcUNIdEdqeC94?=
 =?utf-8?B?YU9GY210WnY3L2F6QldCSmVKcHRRZXA3Wm04QThkVXBlWUs3VVJlL2pSTEQ5?=
 =?utf-8?B?WnJkekFTUDNnQnFpRG1xUDFMQWViVU5jd3hFTzJnbEQ2djlnamkydVRlQU5i?=
 =?utf-8?B?MW05UC9YZzd3N1VreXl5bkZWaDhGdldEUko5d3FvU1FTR24veTVQY0FqL3cy?=
 =?utf-8?B?VXBpeWNCS2xOVmFPR2NPaXZ3UXBQQWZCRjgvUnAxRkdzbW9IeFNhQmJSWmJJ?=
 =?utf-8?B?MU90OTJDY21iOGE5YkMxL2xkd1RHMTZiQkNZcTNYbHB2bXZJYnlRM1N3NFVk?=
 =?utf-8?B?NEJ5WXBkZGFWdGxCUFZiQU0yWXNkY1B3cjBkR3RwRXBzTjZsK2lqUWM0RnVi?=
 =?utf-8?B?ZXpMYmxFS3FXeXp2R084eTdsSEZkVmNEL2Z3cnYrQXdOVnYyY0M2SGN4amh4?=
 =?utf-8?B?UEdiVy9ybURGY016bXkvUnhsZXJLbktPYjZkSUxpOHJtdS9xOEVxZEtuNllW?=
 =?utf-8?B?QlZ0ejlpUlJCQjJUNHlwZXE1d2lpWDRCS2pvSmJXS0JMRzYvRzIrYmNsQ0xq?=
 =?utf-8?B?d2hOQmRzeTVXcmNiWENvUWM2RG1sNzVNQitOeloycjZRWUlCYXZiZUd0YUoy?=
 =?utf-8?Q?iyx1sn2DcLWDg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1drL1ZnWFlxT3BtRHVLb0ZJZE56TlVkc1pQcjBWbFV4RzBVU2FDQ2k1TVho?=
 =?utf-8?B?R0d5cGZxMlI5YjUxclE3NmRqZnBWQ1lwMjZ6elZUTXV6TEdtbWRIeG54OWN0?=
 =?utf-8?B?dU5QSkw3TldIZHBCQm5USXlLYlR0VnhhZG1NcDZ5SHBaemVDQ3czWVg0L01R?=
 =?utf-8?B?TE01MDhsNGZLbFhUYmhqNTQ1eWxyK21zYzFBRUlnaElqWS9aamVMQ2dVVGFv?=
 =?utf-8?B?MWtYYmdKVlJWUmg2ZnorMzVLSGZXQU80WHFMZEt0K0pBZmJhUXlPZCt5Smox?=
 =?utf-8?B?bHRyNXp1RkpwM1UySjhTZFVxbGpWdU5qY3JLQ1pLUXo3UWdBQU8xVU9FTk9E?=
 =?utf-8?B?dHdtWUl6bTk5NWhsaFh3b1o2VThpWlRkL1hBb2psd2o3R1Q1UittRzExalVT?=
 =?utf-8?B?MENLYnJZL25IS2V6NnRuT0FZMmRVMVlYZFZacjVqRGd4SUJBUGZvMmZZdzU0?=
 =?utf-8?B?WGVKWjBocE5nRTRmcXZzUThqUkpVZ05hVjcrYTNFekJqUnNQWWZXcWwvdUdE?=
 =?utf-8?B?NzdaMFFJWE95RmRhQlJlbHhCWi9PZHoxd3JJb0p6aGhONGt1ZnBwRlFOUVZj?=
 =?utf-8?B?WXdLMVJVaXdNbEw4cFpGSC80eHljd2pDSkdlU1lGYnhnSFViMzByWGhFU3VF?=
 =?utf-8?B?cVN1YlVyeDBIVFFaZ2dDTWRrZFNJRmlIU2VsSExxL3lZNzFodHdkU011TUhm?=
 =?utf-8?B?MzNvRFJXOWVrdVJCUWxmeHNaS0M5c3hJYnVVUUlicU1PZ3hrTkY3YlpKWktN?=
 =?utf-8?B?NmtSYWJaNHNDVTkra1pnL3FKeXZ3UFEvcGNQeG8xMlcxYVpLMXpjejdKL2Y2?=
 =?utf-8?B?YSttcTVxYi9LQm9zL3VxSHRWNngrME1wRzlHMzVTbHg0SkVyVzhZZUJhOWVx?=
 =?utf-8?B?TmdFa25sOUpPa3R6Vkl1QVphSFhOWHBWTFM2MzdTblhMTUZ3cER0ZjZJK1h6?=
 =?utf-8?B?T3U4RWNUaEtOZDVSOW0zb2JNK2pIaEp2SzBQNWFUK2pjbkpOK1JCYXR6d1lJ?=
 =?utf-8?B?eVdxU29pUDVjUUdHampzMmhyMGxhSUhXN0dUc0c5TTNtZ0Jqb1RFb3JoblBY?=
 =?utf-8?B?cEhTSkhTNVRqS29Lbzc2UVNQTFl5TWptKzQvWDV1NmVhaTF3bWl0bGE1UkZu?=
 =?utf-8?B?U0JJNktCUFNCTnkrLzVoUGtLV0g1SGh3Y3FJV0twbTFPc1VHY0RhaGczYlRF?=
 =?utf-8?B?ZmcrZ3VFcnZlOEg0VjBZODhnZHVzSzUrcmFzWklRS29xVHhZQk1UVzNXS1F5?=
 =?utf-8?B?UURTTnYyTkkvak5sTTZxU3NDa1pBSWZ3bFhGeGpyaWdvTmY2Q1A2dEVPUExz?=
 =?utf-8?B?dzBoNktyWHEzMWFMUG5nMHNQWnhrcDFqbkFNNVI4T3E4SzFEU1k4eGNjRGNL?=
 =?utf-8?B?UFg1dXMyTGxOZHgwbXRQUVJROTlPc2tWVkxDa2VqYzdqVDdsWHVFV2FraHYw?=
 =?utf-8?B?TmtVRWk3YlNOS0NlT3dMQzBuV0w3L1FaQVpsbmZpclpmT1V0NVhRZFlyTm1j?=
 =?utf-8?B?aGhXZ0JXcUZlWE9JcXR0ak1SY3gzSTAxR1IyMHVCSU5XTHR3T1RjRkt0SW83?=
 =?utf-8?B?cjJGQ1FRdjJnZzhIbm9JU3lhSldQRk1QVzVFTk1uTDR6Y1lKVTBFT3JpbUp6?=
 =?utf-8?B?VWppODQ5QlIwQkQ2dkJPRldpakJwbEJyWW04aFByclk0cHIyVDRGT1YxL2JC?=
 =?utf-8?B?L0ZlQ2lxMERScDZkbm9uc0VJc0pZaU1VSUFVUFZxMUNhbVM5N0tmci9TNFlq?=
 =?utf-8?B?dTFFY2YvY0Npa1EzeWZrV2dESERieUVUdis4eXlCM0szNWVhd3YrcWx6TGxI?=
 =?utf-8?B?Sno3TmhtNzdXaXdnNkthWWxZN1NnRnpQQXFxOEJ4M2FYQi8wNmwwWWFMUUMz?=
 =?utf-8?B?Vjl6UGRHcXg5UjhVUGhTQzMxRXIya05aZldEMjNpTmtsb3YzTjZsQm5oUFhx?=
 =?utf-8?B?R3lTNHNFbzZKWm1kRnJKK1lwcHcxQjJtclNYQkNZT0JMRnVyK0xDaGtMczNR?=
 =?utf-8?B?WDlZdnVOc2VhMW1nMVlHeVNpVjlqYUt2emxiT0dVNjhZRUVLcTJvcXhtUUtt?=
 =?utf-8?B?RFU3a1c1UkdHSmVTWlRmbGFzemhkQ3dPb0kvSGJBcDh0VTZaeU0zd28xVkh2?=
 =?utf-8?B?VzNqekx4cnc1TFJGczBMNzVHNTJQSVg5eUVBWWZxK3orbUNjV3QybWNaVlZi?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2531b6-ae51-4b5f-4d1d-08dd46a7eee8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 12:15:24.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtgQCibdRUkabsLbaSnnp1kTiZKOKf+FgxsJczlGM21LrFjkYpjEP1G9DWLYOA6X7TMt7fVt8CtRk7upC0BzFF6LYzrP28w+vm3Kwbjjm6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8480
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Feb 2025 18:48:50 +0100

> On Wed, Feb 5, 2025 at 5:46 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> In fact, these two are not tied closely to each other. The only
>> requirements to GRO are to use it in the BH context and have some
>> sane limits on the packet batches, e.g. NAPI has a limit of its
>> budget (64/8/etc.).
>> Move purely GRO fields into a new tagged group, &gro_node. Embed it
>> into &napi_struct and adjust all the references. napi_id doesn't
>> really belong to GRO, but:
>>
>> 1. struct gro_node has a 4-byte padding at the end anyway. If you
>>    leave napi_id outside, struct napi_struct takes additional 8 bytes
>>    (u32 napi_id + another 4-byte padding).
>> 2. gro_receive_skb() uses it to mark skbs. We don't want to split it
>>    into two functions or add an `if`, as this would be less efficient,
>>    but we need it to be NAPI-independent. The current approach doesn't
>>    change anything for NAPI-backed GROs; for standalone ones (which
>>    are less important currently), the embedded napi_id will be just
>>    zero => no-op.
>>
>> Three Ethernet drivers use napi_gro_flush() not really meant to be
>> exported, so move it to <net/gro.h> and add that include there.
>> napi_gro_receive() is used in more than 100 drivers, keep it
>> in <linux/netdevice.h>.
>> This does not make GRO ready to use outside of the NAPI context
>> yet.
>>
>> Tested-by: Daniel Xu <dxu@dxuuu.xyz>
>> Acked-by: Jakub Kicinski <kuba@kernel.org>
>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  include/linux/netdevice.h                  | 26 +++++---
>>  include/net/busy_poll.h                    | 11 +++-
>>  include/net/gro.h                          | 35 +++++++----
>>  drivers/net/ethernet/brocade/bna/bnad.c    |  1 +
>>  drivers/net/ethernet/cortina/gemini.c      |  1 +
>>  drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |  1 +
>>  net/core/dev.c                             | 60 ++++++++-----------
>>  net/core/gro.c                             | 69 +++++++++++-----------
>>  8 files changed, 112 insertions(+), 92 deletions(-)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 2a59034a5fa2..d29b6ebde73f 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -340,8 +340,8 @@ struct gro_list {
>>  };
>>
>>  /*
>> - * size of gro hash buckets, must less than bit number of
>> - * napi_struct::gro_bitmask
>> + * size of gro hash buckets, must be <= the number of bits in
>> + * gro_node::bitmask
>>   */
>>  #define GRO_HASH_BUCKETS       8
>>
>> @@ -370,7 +370,6 @@ struct napi_struct {
>>         unsigned long           state;
>>         int                     weight;
>>         u32                     defer_hard_irqs_count;
>> -       unsigned long           gro_bitmask;
>>         int                     (*poll)(struct napi_struct *, int);
>>  #ifdef CONFIG_NETPOLL
>>         /* CPU actively polling if netpoll is configured */
>> @@ -379,11 +378,14 @@ struct napi_struct {
>>         /* CPU on which NAPI has been scheduled for processing */
>>         int                     list_owner;
>>         struct net_device       *dev;
>> -       struct gro_list         gro_hash[GRO_HASH_BUCKETS];
>>         struct sk_buff          *skb;
>> -       struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>> -       int                     rx_count; /* length of rx_list */
>> -       unsigned int            napi_id; /* protected by netdev_lock */
>> +       struct_group_tagged(gro_node, gro,
>> +               unsigned long           bitmask;
>> +               struct gro_list         hash[GRO_HASH_BUCKETS];
>> +               struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>> +               int                     rx_count; /* length of rx_list */
>> +               u32                     napi_id; /* protected by netdev_lock */
>> +
> 
> I am old school, I would prefer a proper/standalone old C construct.
> 
> struct gro_node  {
>                 unsigned long           bitmask;
>                struct gro_list         hash[GRO_HASH_BUCKETS];
>                struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>                int                     rx_count; /* length of rx_list */
>                u32                     napi_id; /* protected by netdev_lock */
> };
> 
> Really, what struct_group_tagged() can possibly bring here, other than
> obfuscation ?

You'd need to adjust every ->napi_id access, which is a lot.
Plus, as I wrote previously, napi_id doesn't really belong here, but
embedding it here eases life.

I'm often an old school, too, but sometimes this helps a lot.
Unless you have very strong preference on this.

> 
> Less than 30 uses in the whole kernel tree...

Thanks,
Olek

