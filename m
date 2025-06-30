Return-Path: <bpf+bounces-61812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471BCAEDB7C
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73AA81885305
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67CB272E7F;
	Mon, 30 Jun 2025 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWKHqZro"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAA2727EA;
	Mon, 30 Jun 2025 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283889; cv=fail; b=kyyYRrvm/dzFV+AvEsYMx+wsN6DyHdRkmPo7ck/h4NJy/jWsDI6kIKDdOjrq4xig3hl1EHJTtQ2ESy9uoQ7cavkVIADie1fM94wwYph47AF/epH78GT146cqPtD43nnfvKs0+AMS6iaiCc4oY40F5Uye9Mqyeimmn3QZTIgYRUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283889; c=relaxed/simple;
	bh=kgP+4jxc+FTq0jssfIc5ysvX+RXp+zKhHWvOaxAmgco=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jZ56N8T9FOOoPS/4PhPgA6yTtovWq9JqmFJtSyBrVKJ6rQ5lmKI8bWWtzdQziQz+IQwmBBjUqEiMBDR4u+3Gsxr9jrjhVs5B/NwM29uQjKxympxr2oM+whmmA8KdB4aOiD+B7L5qYcmFW1kFRUndAtdxj1mll51hRvkEgznvSpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWKHqZro; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751283887; x=1782819887;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kgP+4jxc+FTq0jssfIc5ysvX+RXp+zKhHWvOaxAmgco=;
  b=CWKHqZroQp01HV3+vsvwHdIQSRhbxcsKlFu/B6SprPLc0R+NR1DTNUd3
   rLj033JKz6R7jakopvvsdcjDD/FEpt/Q4BiPi0/fbJ7ih+e0vBOqm6thw
   E0/BOuqUewOzi9y8zYrVuNSY4fcMvt5AccTTsxWXGY6jOPq0na0Z611Bn
   ZPRhvbFuTTBwriIPnTbhsC5Eyx1KDHcBsKjErnKtOBHfD45Nrla4l1/Dp
   fnqa+TvKMixuo/Psji99q2UYcFCQZZuH49IJsZ1Dm+AWRbw4dX0rC+hW6
   WMKBL/hDIjNRR+qLWJg95ABPJ+LX0hbfbaxJgKRTpfIZ5zBkW3iUkGnMx
   w==;
X-CSE-ConnectionGUID: WopQjhErQvGMSJDZD1ODgg==
X-CSE-MsgGUID: yb/vEZdnT+OGz6mfX/SjWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53655603"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53655603"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:44:46 -0700
X-CSE-ConnectionGUID: X/ilfro2Q6+gwR2KAQK1uQ==
X-CSE-MsgGUID: HzS29fuKSTms3Mskwlsh2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="190606386"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:44:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 04:44:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 04:44:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.88)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 04:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTXHMgymJ4aZHIKnKmK6UBXV2ihbfkVBPkGZNatdkyECGCglQblIsMx8ZLNgK0amgqQZTgY3MJJvUJz2SoL2SBU43g0CSfWw5KPvoYiAj5Hofes+aWw7ddx3MFqGHGACpWuayj4RHqQijw3F106xXOqpWX0rFRZ8S4OAl8dqBa77iYPpcBzkXTxpPeDAuNQ/k8j9pDCvbX59im+VruY0+D9we9FnHjiDm8xDV5iDZqUhfHqaXau0eAAMKDycCY9RK/jUvHqse1muKOBgJlBdtxP1CGpIkvU2+kGcAIBS+GLjhyVGNH7A4LXndJ5NxEniyNuVmrZyBTPMudd3PKX8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03urOnF0/AS289Ki/rYmY+K9RpU5w81JiPzlQJussW4=;
 b=VN/FRF9bW5VM2zAp/VbjKUdRIX46KA5GDniSNbPoU/I42413cjJv0x6sZSJlTzFAzZWRfo7bwfmrI5ffDmJZ6ut9j1A9X4arxpjjAwpfnCoMBlqLKvdQKOClY21EF7BYDTKUA7daqqZHv/NEKEij95LIIfRi6sE98CqlXW0BcGn/P0j61kyIbxJwuxfSmITBjlkC2+K30lg5qvM/FSEMNq4vXKtynj53WS1x89HRxdy7UGxmRwCg64W5gRf/cu1ux66W/hzoGukrB6m/nnh27Z1mrNxy1hF5dVITDm1e8NVtj6fitUHHnWe6bbnZJpj3uNSgv7bUc+E0oSM+weUjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 11:44:43 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%2]) with mapi id 15.20.8880.024; Mon, 30 Jun 2025
 11:44:43 +0000
Date: Mon, 30 Jun 2025 13:44:34 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] Documentation: xsk: correct the obsolete
 references and examples
Message-ID: <aGJ4ohHA3Cs45wCp@boxer>
References: <20250628120841.12421-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250628120841.12421-1-kerneljasonxing@gmail.com>
X-ClientProxiedBy: VI1PR06CA0152.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::45) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abd751c-6847-45bb-df32-08ddb7cb8147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kg+8Vt6goZ4uo3suyRD06HhHamaYUoqoUlzrdI75ib7EinOaPdEdQL66QXdq?=
 =?us-ascii?Q?5fiRNHXdNbvjkFM+PnIQZ8szCjzcj7JQlkyzNHrPKcNONbRxISy9HwSffc75?=
 =?us-ascii?Q?mJTVsJp8KWcEkthpFv9ladTFdGm67E/BrXA06CknkfbPXfepg9SAmZHsoqmd?=
 =?us-ascii?Q?OayJoY4tcG9UOkM/WAVgs6JeZhJVRLb0+5CFpG1hfB+BbHqrS52uDjdlwe2T?=
 =?us-ascii?Q?wwgz7FmYv3moCDIC3xPqi5vXBjwbdatQxRVmHtdJGogMMZnz48hJx522u0qT?=
 =?us-ascii?Q?FVdefDBhpZEjHDP7XiBRiDQ6ugJ5KbeERnwFjulcjSpRm4pRwzocepURpV9d?=
 =?us-ascii?Q?DuD9kHOoXioxLchNQfFnfbPK7ZXE3KwVwagTxD1ZYVy14FAuilnaJZl26aKY?=
 =?us-ascii?Q?L4LTNi4oBc5CWVjZDjaNf8Zs8oJdws46igkrTtNk5YZRv9rFK4ckjuzDaZ+C?=
 =?us-ascii?Q?hB+lDlWovh3CuPTZJ98ghtXwz9Xyk2NaS5XUWFqFgsu4zV0atCMbk+/42x6z?=
 =?us-ascii?Q?2tNLoMmhSpeAsTIddZEMlcIh8aGDmasNk5alivKS7vk5pwMcx+vKIltK2plf?=
 =?us-ascii?Q?E3GTn1Isi5wqquTg73yF6EByUh/77WpaX5BQD7iqVTLwapXVIQ5otdzStZJO?=
 =?us-ascii?Q?z0EWqYqkZrLx5C08dMAseuj8x2csAcD0lWSu8vnCLg+GL42c3Zd3DdtrAW0m?=
 =?us-ascii?Q?XA7v4bwWyi4CHyIvrqIX270zU+qdCbHR1AlCxI+atT3USC+dCov7JN4kYmXN?=
 =?us-ascii?Q?6anUPRuzzGyb7nl9BBQd+Ayf/hnnadIM3rb8WveAONXhDi9iVNx88JpX8GkW?=
 =?us-ascii?Q?38SDz1WJBjw+PC2pg5wEtH4Ez+Qu2BxmWzsEXnTZmQWlj2tSyeJrijkNGq8T?=
 =?us-ascii?Q?rJHie5hs/2uB60pc4HCdUNZ6X6dsdRWdsHuvrie73aii0+hptpKcfBakGTFv?=
 =?us-ascii?Q?hMfv1lPskAByElBfUPdPrduL0KK2ipk19OuXrXpZ8n/UCIPYx9VLgaimoKlE?=
 =?us-ascii?Q?WV0REmAWZ8NRZP6U2IeENdbvHcJK7nhuSw0FCcyxQagG5IvERdLts55jaA0/?=
 =?us-ascii?Q?OaVdzXpdJ61iV3LW3QyLhfVhG3vMqLhugbAA4de76ioDy4+oT4p9wJLK8RVv?=
 =?us-ascii?Q?YcW99YDJtuPO4zcEZxRYQ8DCPkXY9GyOObYt4uMH8Nrl9tv7vgk9aE1nQU66?=
 =?us-ascii?Q?kcQsNF5ynbAmq7Pub8Q2G2sPKZvgzkDQZm5llXz9Ed6cAwEXJoIOO+H/y6Td?=
 =?us-ascii?Q?j2ly3Od4QoSp0h/ZpUSbqGpeW3UAGC6eYCtZDW8CtZx5Trsh87yAYITbAcwo?=
 =?us-ascii?Q?/ISfzL9C/V47bc/0D0adcgVcVuKerUwAkYktUkj65ehCcqdGwQRcBr8An4NE?=
 =?us-ascii?Q?ZxZzTB3KejonZA4yqafZw6S5EZJlPkdDxewHggPKYMsMi+Ty363UgWN4NalG?=
 =?us-ascii?Q?EQf0eRNouOA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r7SddJWwNgR1rahEKHfZyIh4LosvZ6Za2Pu6H1XlgL5Qcb7LqpKJTg/68+8G?=
 =?us-ascii?Q?pIP42ICv1M1DNkeWuTZVWvrmLvkvaqo5lVVQd8pUL3C7aDzREdoaRdPv0Age?=
 =?us-ascii?Q?oIlSEiIReKLmXi/zpDKt1csfJVzMmMT0GI62N3MhuSFo8ObvL8KMw9W06Slo?=
 =?us-ascii?Q?tb8+duV4rmuAqwVDAsiZgnaVeUl8Egz4EUxzLhwb1tiXO+9JE29syYoOPXcQ?=
 =?us-ascii?Q?GpUpqOV/za36x1V8gn43/PPODv4gQt9P2T8l/zNDl/AZjrq6zciIOAW20G6X?=
 =?us-ascii?Q?yGev/In1tTQdqlw5GW0GYf8SgZ5XuvNY0OxJfCsi6OAoo0qqQZM4wFKkn8N5?=
 =?us-ascii?Q?IOOiQq0qb4QX9dqSacDjafrXwNz/qLC9er6cJ9AtxBBuqcP/iywHQTx+DVz5?=
 =?us-ascii?Q?T8YxNXTAxwIYd2oMimKbJk+NC7JW94+jfYYmrKhZXUWNFRYFvRXq+xYsbu3R?=
 =?us-ascii?Q?2QEtDFdVmwuKNg00lrnlPRpSQ5lj1BLDPMw1SQPhhHFKd46lmOheeAnXs8UF?=
 =?us-ascii?Q?wqkLd7RdQI1EqIAMGuCba/WbMVUqmt6AMluCmwcS+xR2g8+hxkwlStu8KMgc?=
 =?us-ascii?Q?15CfAAmbvXZqtXBxpkSNYHJSmdD0kbR09oPE/XTcMh0QmCTdXxSywN8yYCiU?=
 =?us-ascii?Q?ZKvLLuBqASVk4a55oUvv15fRw37BZRN5t5blGCtPnAtPb7ea+d3X8VsrPrIp?=
 =?us-ascii?Q?pyLj83ja6c8B6SpNVjGvFy2A17y9Q4Y8oFvVegpk+SdTsXZMTb3xUgQALqfq?=
 =?us-ascii?Q?NdreO1O8ViSt6BPTKmXyJ16b8J+XN+zaGdu1MwbBCFD19oojgpFU4/LklASI?=
 =?us-ascii?Q?2huAbul2gTl5HgR49Sd4yBulCDOlFhzzy2mlEkmLOrcHtETPYxRB00cLOE49?=
 =?us-ascii?Q?8mhntDIKYOdBa0fDKM6vZp5e4goV5B3GygXFbZNsiaNjdYONIS5jlGFQ3r8r?=
 =?us-ascii?Q?2aJbPw7RYQSojm2aF2FRl27WnE4iq0Z6L/Ir4l6+k63uifnv4xxLGpW5okrQ?=
 =?us-ascii?Q?Fc7SOkOiCkmcIooEb2XM74Ke3oi2+VXFcUmGQcURRcXXR2fLy2vKrwF1bmd+?=
 =?us-ascii?Q?GAN+VW/r6MnTdfkiSk6UoTFsGo3QxwITs50UykzhRqHap1AZrIMtiu/8g9zG?=
 =?us-ascii?Q?dCfcMpSE0eDNxp+wGY2LOguv6xK2lv5WiJxckSwaZWXvE4Nf/TB8E690kcGS?=
 =?us-ascii?Q?MVo1Av45cW8Nn4dPncKhuYCnU+oxwGAFj7jR1y65pttQQK9FeZb/o6d1sZeN?=
 =?us-ascii?Q?kztFqeE8zvlovh/SOob7Ga02VTLh5p3+YWtmbo570SU6DR1zQoNrd0hrpm9q?=
 =?us-ascii?Q?EDeDCDXtYMUydS5ChPUwZ04Mh54wuMtjV+GhhZWn8xZNQv53yYULuUk2/ROA?=
 =?us-ascii?Q?Djsgsdduh03e70AHu1+gr25yMQH/2vSzvHypuABFMBZYdvlL0NjAKjrl8ZKx?=
 =?us-ascii?Q?633TQAlb7TBLFtfFhs/tJ1ewy8K3I3aeqKEJFE7hNL5Y4tjeCIIFBAtA+XGs?=
 =?us-ascii?Q?r1+7GdrDNs+/mjbzud0/vaC9eNi2tg6GAFWqw8BAMWz+qgSV0CzjfhzJ2iEm?=
 =?us-ascii?Q?iu3SrBH5y0kSBL4/1Q16RxUSLLpxst5lJrm17YYacm2222tE5Wwg1OYnwz7I?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abd751c-6847-45bb-df32-08ddb7cb8147
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 11:44:43.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NS2JZ3XrAyWYGAvY+08xW7My8zkwm3JqwSlht2gVIuXPGz7d4liCoxUUkkvV/drQbk3z9ccIohpPCSQvqqxaumGrpKLXbI3YcnmBIhTqNX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com

On Sat, Jun 28, 2025 at 08:08:40PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The modified lines are mainly related to the following commits[1][2]
> which remove those tests and examples. Since samples/bpf has been
> deprecated, we can refer to more examples that are easily searched
> in the various xdp-projects.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=f36600634
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=cfb5a2dbf14
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  Documentation/networking/af_xdp.rst | 45 ++++++++---------------------
>  1 file changed, 12 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index dceeb0d763aa..37711619e89e 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -209,13 +209,10 @@ Libbpf
>  
>  Libbpf is a helper library for eBPF and XDP that makes using these
>  technologies a lot simpler. It also contains specific helper functions
> -in tools/lib/bpf/xsk.h for facilitating the use of AF_XDP. It
> -contains two types of functions: those that can be used to make the
> -setup of AF_XDP socket easier and ones that can be used in the data
> -plane to access the rings safely and quickly. To see an example on how
> -to use this API, please take a look at the sample application in
> -samples/bpf/xdpsock_usr.c which uses libbpf for both setup and data
> -plane operations.
> +in ./tools/testing/selftests/bpf/xsk.h for facilitating the use of
> +AF_XDP. It contains two types of functions: those that can be used to
> +make the setup of AF_XDP socket easier and ones that can be used in the
> +data plane to access the rings safely and quickly.
>  
>  We recommend that you use this library unless you have become a power
>  user. It will make your program a lot simpler.
> @@ -372,8 +369,7 @@ needs to explicitly notify the kernel to send any packets put on the
>  TX ring. This can be accomplished either by a poll() call, as in the
>  RX path, or by calling sendto().
>  
> -An example of how to use this flag can be found in
> -samples/bpf/xdpsock_user.c. An example with the use of libbpf helpers
> +An example with the use of libbpf helpers
>  would look like this for the TX path:
>  
>  .. code-block:: c
> @@ -551,10 +547,9 @@ Usage
>  
>  In order to use AF_XDP sockets two parts are needed. The
>  user-space application and the XDP program. For a complete setup and
> -usage example, please refer to the sample application. The user-space
> -side is xdpsock_user.c and the XDP side is part of libbpf.
> +usage example, please refer to the xdp-project.
>  
> -The XDP code sample included in tools/lib/bpf/xsk.c is the following:
> +The XDP code sample is the following:
>  
>  .. code-block:: c
>  
> @@ -753,27 +748,11 @@ to facilitate extending a zero-copy driver with multi-buffer support.
>  Sample application
>  ==================
>  
> -There is a xdpsock benchmarking/test application included that
> -demonstrates how to use AF_XDP sockets with private UMEMs. Say that
> -you would like your UDP traffic from port 4242 to end up in queue 16,
> -that we will enable AF_XDP on. Here, we use ethtool for this::
> -
> -      ethtool -N p3p2 rx-flow-hash udp4 fn
> -      ethtool -N p3p2 flow-type udp4 src-port 4242 dst-port 4242 \
> -          action 16
> -
> -Running the rxdrop benchmark in XDP_DRV mode can then be done
> -using::
> -
> -      samples/bpf/xdpsock -i p3p2 -q 16 -r -N
> -
> -For XDP_SKB mode, use the switch "-S" instead of "-N" and all options
> -can be displayed with "-h", as usual.

Hi Jason,

these commands above should be kept as-is imho and we should point users
to new xdpsock's location:

https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example

> -
> -This sample application uses libbpf to make the setup and usage of
> -AF_XDP simpler. If you want to know how the raw uapi of AF_XDP is
> -really used to make something more advanced, take a look at the libbpf
> -code in tools/lib/bpf/xsk.[ch].
> +Xdpsock benchmarking/test application can be found through googling
> +the various xdp-project repositories connected to libxdp. If you want
> +to know how the raw uapi of AF_XDP is really used to make something
> +more advanced, take a look at the libbpf code in
> +tools/testing/selftests/bpf/xsk.[ch].
>  
>  FAQ
>  =======
> -- 
> 2.41.3
> 
> 

