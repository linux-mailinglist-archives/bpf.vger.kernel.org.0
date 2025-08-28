Return-Path: <bpf+bounces-66837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0B2B3A46B
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6C156413C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F2123372C;
	Thu, 28 Aug 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EccnUhJn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A804E221FC4;
	Thu, 28 Aug 2025 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394949; cv=fail; b=pNGZnADqHB2Prkj0S6DRPP1W/nAm6d8We+m5GQkDZrPOWrA+wCXzMEMD1SnzeucwKlMRrPaG6t6qMLPedDrFuPGnfyKwGzJU4SphGzo4YPIvavHfQLypL8la2DDJvQxcmCf0d+kB17L36g91ideOMCRrRhAKi+tMXti3Cg6W5h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394949; c=relaxed/simple;
	bh=7wmnx66VyWvI99TKp4wd0iy9xsxGV83TvdxFXDSiMNM=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vE88PHEvcSeT4vwoMXUp3dHGdYwsUws/i5LdYNg/2IsSTHKHzvAU+uaEjny3DcVb1YfE+Ff9ikB9BcEvFiwp1VZrQps6Y41VDl4UqdyEQrM5JfpSQwBEI1dEyJkSLJq9ovV61G2+XZwJUZC/1Aaeq29m2GINHfcxh/n6CQ4oz6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EccnUhJn; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756394948; x=1787930948;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7wmnx66VyWvI99TKp4wd0iy9xsxGV83TvdxFXDSiMNM=;
  b=EccnUhJnkHzwEIRIcdYgAG3v/QpdGGsLg7yVujyTCw0jJbKSOaaqZ4CU
   jVaY+O+Lh/n4UFini6rHI4d3XqAIANMnomUBDG1j5q/pKbf02yW7S8AFT
   gImMcdX2DLH8xEE4oJWjjCaMbpvvIAXWUO+xJCzn5A43P+2qjEVs/7jjU
   8dSIcfzNw1K7uAq/Nc2mMuFXW3Udgy9c6zf/yoAz2pbSAJuwrblxhdnhT
   odxpqaC3MmkJ4fX5lbFvkw740yAGJznMsvURSkgk0dfPmAOtyIhrPiVQn
   TOYghj5/NgkkHz1XH/bKSJSOGcYH24AD8AK3lNAkjmdk2kxSO47zIjaaf
   g==;
X-CSE-ConnectionGUID: F8OdTh+WRn2A/YB1jVZRGw==
X-CSE-MsgGUID: uSmOjld2Q2OcdqvjTucxvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76269106"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="76269106"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:29:07 -0700
X-CSE-ConnectionGUID: 0HlISSprSEOGhJeQxDK1Nw==
X-CSE-MsgGUID: zUVM3fqMRBqs0YtZsUSikg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170317318"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:29:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:29:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 08:29:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.76) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:29:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EP4N5zCGjUa/MJMHeYvcA9qdLJ1YcCEkFqpJMBJdOjhJuKrpUPZA/PnIw4r4JCZMtoq3pfnVSMm/+1Bi1OTodLmwh51slmslD2COXeBe/wL90kF+OTXx0czCWTMtfCYTtXGOO10iv9UGrwA70H4Zm5RjdfxNA9jMhXlj3yTA2vnpjK1dHUQCvzxx9qRP/+jX0yVt/tDoa125prdznbCR9rw4NggYSDg/qwWUdC8pUEdQ63/5AVFOpUVjlc00rjGFxDIAPdhfpsvWgdvLeR9nbvNFDOzsWrqwiR7ALgTXBUw0TSESsuOHHjEw1ewXSVMK3zscdpaHxOJMaJRKJTw6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc7kqHwtpRm4zr5p/XcpKWi+oKWgJhBsfF/p5UQpm4g=;
 b=VnMQkUH1EhubKRhPsl3G9JKMeU7zdovwKieGN7ca6WwfxLEddLHQS1DG8tjD8V9HIKHXiZM/1aNuQNE3nD9p2bkoaVvpO2XlLNOnONFycdp6qblUe/hLQP+tqQ5aA+VVd1xWl2M/mU3qgHKdge8rRnd+C5ZTqnQUXh8dzyoTHxIJte5dUDLw2ShlHy8U03E/zUmzeRCx9s0jo2Il1T8WGmnbwwrSfAwRbzeTZSjYMKxrYhqtmJS5tXmivuqV0gmI+D8R+nh2jOMDc6hY9orhqvZuMgtkoKGt1F0ex62O7Ar4ivkL7+ssWHBxQmqgo9Yhq5KRU+xdxHTnPXAiX4a9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN0PR11MB6159.namprd11.prod.outlook.com (2603:10b6:208:3c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Thu, 28 Aug
 2025 15:29:00 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 15:29:00 +0000
Message-ID: <f0c0a512-900b-4d12-9e59-5fbcd35ed495@intel.com>
Date: Thu, 28 Aug 2025 17:28:53 +0200
User-Agent: Mozilla Thunderbird
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2 5/9] xsk: add xsk_alloc_batch_skb() to build
 skbs in batch
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	Jason Xing <kernelxing@tencent.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825135342.53110-6-kerneljasonxing@gmail.com>
 <951bc347-0c33-4359-8d15-0e5e054b951c@intel.com>
 <CAL+tcoCBTS0T-DNRjC0k2pH+qveM6=OHQ98eatp7nG5g1DA=bA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAL+tcoCBTS0T-DNRjC0k2pH+qveM6=OHQ98eatp7nG5g1DA=bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN0PR11MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7e5376-a2ee-4b7e-6674-08dde6479c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1lLR0t2SGlHVGRCK01EaUdQSm14ZEM2ZTZ1N0ZWTFlmN2J5OGdPWElDbmNr?=
 =?utf-8?B?MUhpbUNvRlFIcnZRZS9xaldhT05QR0JJR1BNYnViMSt2MExYOGFWdmJ4UDYr?=
 =?utf-8?B?bHc4SUpBeDJoM2xjN2FzSVJVVis3NG1zalJvQXlUMUFHZnpqMEN4ZTh5ejdq?=
 =?utf-8?B?K0VGVnFnRXMvZjRzS0dHSzN5MXg0bm9TWmo5U3BBbjFPSGo2ZEtZbHFPZnhy?=
 =?utf-8?B?YjdRK215M3hrRkVZbEFncENjSG5hQ0thL0ZIaFlBUzFwZWN3bFlmYWpGSDlO?=
 =?utf-8?B?RmRsNWREZXNkTEZZMExnLzZYQW95aEhMZUw3V2hqU0lBeks2V3NPRjAzSXlF?=
 =?utf-8?B?UkJKbEJEQ21na20xZ29SVmRiNi9uc2t2LzNsMDMyTmVheFdjdmZKRlJlWlpl?=
 =?utf-8?B?RXNnT0dJajNmNENXb20rNVRlb0hTRExuQlVhWUgyT2NOSEpRZUhRbUdlVnVk?=
 =?utf-8?B?ZFpYTnVjck5LelI4eHhKSyt3T1B4blNhcGlUMG01Tm5YalY3R0N2M0h3UTZ0?=
 =?utf-8?B?eHd2L2RiVnJvU29JdERPTzluM2pZbkFXT29meHV2bmE3YnplRFNuQ1UxSXJH?=
 =?utf-8?B?NzZhd1prS2dKNVlldEhCd1owRTYyQi9XYVlCaFZveWJQNXFEaXMyZ0hMNmVm?=
 =?utf-8?B?TXdwby9pNzNueDd6VmxRRXIzNjR5bmFKcUcvcWoxRk5kOU9xMHdHTGNNajdQ?=
 =?utf-8?B?cElUSWVYYTZzdFMxZ0Z1WExIc09YQXA2TExvcVpEV1lqWGlqTDdVU2ZlUkNO?=
 =?utf-8?B?ai9ma1ozNEcyS1lrTGVianNMRHZIeUFiOWVoVzB0U2QxNDJ3UWRKU3Z5Vm1P?=
 =?utf-8?B?MFBFRkdPMGN0VXgrL2dVaTEzVnhnT21NVk5ISUhaY3kzRkorZEM5bUJTd2R5?=
 =?utf-8?B?bU8wSUM5Smk0K29zSjRSUDIyLzM1RWZLUnRMeGM1bzMzZENBWk5Pb05scnEz?=
 =?utf-8?B?NHBiSDRLZEdma2VxNjJqWmFVQjlmUGI4TUhGWjJRZjBMZ0xrd3l2aGMvOHFa?=
 =?utf-8?B?em5pYmdFTzBBMXROZkQxaEloUG0rYjJId2xlcDRLbm9abHdPeWdoRGZSbi9J?=
 =?utf-8?B?R2tPSHNTUE8xcnlXaytNQms2aTd0ZCsxdjJ0ZVM0aGUra0ZQUGIxeDBmU2FQ?=
 =?utf-8?B?ZkxIc1ZUZGdMV1dRMWhtWHB6TVUxUVZNSWNtcFFjUEhMYVNSZzlyckVxbVUy?=
 =?utf-8?B?SVdmTklTZUxQTnV6UlhLeERNRjBoN0hFVWhvMHJuRExtZUpjWjM1Yis3elJR?=
 =?utf-8?B?aDE0bTNndm5JTHQzVzZ1MWNnTWd3S3NLa1NEeXl5TXArMzNTUThVTjg5MzZY?=
 =?utf-8?B?Smw3TjM1a21MMDRmVlVFUm5Jekx4TkhVVndBSk5EQ3d1UUkrM3Y2NzlHb1hG?=
 =?utf-8?B?aEJHWUFVYzhZakhOVnVhWWs0NE05VFl6OHhGc3ZBN3FsY0luTUVPWTBId3dE?=
 =?utf-8?B?cjdDZGRBNWtHUlI2Um1pa3J6bnlhaytqMlV4NnQzalE3V3luME9HR3hVNVZX?=
 =?utf-8?B?Tlh1UzFuOEh3RVBVdGtnMjJvdUlwNDBtV2Y4UjZXTVUyUC82ejZXMnZySWVN?=
 =?utf-8?B?QWJ3RnZEVlpJazI3VXlPOVJ6Z29rSW0xTXMwSDNFOUZCUDlrQ1Z2a01WR2NS?=
 =?utf-8?B?SUFTbk11U04yaHJzQWFsTXhtZzJwSXFRem9wNnJxUzJTQm5EQm91RExwYkF0?=
 =?utf-8?B?SE41QWthNmJtaWdLakphS1pGdkxhY1hld3VZcjhRSmF5VFlmVEQwakNDaG0r?=
 =?utf-8?B?Z2Z4WHVnOTZiRkRYRlArd1NYdW9rdGRHWU54a05tbERBa1krSzhMc0w1V3l5?=
 =?utf-8?B?aUloTld1TmZCanNBeUZDYWNiTHY1VnVCWXFSRmNyU0JKU3p3RTdIRy9UK2Vj?=
 =?utf-8?B?K0NvV2IzWkZvUkRvNzhlaVNzRkFsdEZMZGs4T3JhdnpnOS9Wd3hBVWZtdmds?=
 =?utf-8?Q?5j3j9Ht76S8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2hzMVNuUVRieUdtZEU5S2hOMVVla0plQjRDZ2JJVitzU2xZNndmR2FHR1ZF?=
 =?utf-8?B?TUVxYTZGZUxydS9YTGwxODk3Z3FJMWx6VUhNb2pJb3JQRmI4UmVKUmszaW1W?=
 =?utf-8?B?dE9teUd5MTY0WCsrdzFvK3kzYitUUWJmNEtUbUVvNTVGc3ZtdFF5L3NXUVIz?=
 =?utf-8?B?WDRBT3piMkRjajVxQkJCMWViaTUvc3JYK0hvUG5hS0h1SEJEQXNWWHBKd0Q4?=
 =?utf-8?B?dndNREhwVS9hVC83TzV0eFRSbDJHbE1IL2ovaFRDM0ZWS2p5UmFXZDNuLzNk?=
 =?utf-8?B?SWdaSlNpdndmcys2QU5DK2p1WkhsWEl6alRoU0ptaXpMczhFZExZNHdxR01Q?=
 =?utf-8?B?USt3cEk3bW9OWkJibk5ua1UvWkQrRmRBZkF3M3pVYnJqQ3VGLy8vUEUva05Q?=
 =?utf-8?B?aWYvRDQvZnlxYmc3WGp4a3hlYTlud0lrakxYMmJ3amMxdEFzUnVIU0dIWm03?=
 =?utf-8?B?Z0phK00zVkw0d0JVM21tSnN4S0o2UFE3OHovYkQvQ2llYkExV3dBUUZIOWx0?=
 =?utf-8?B?YWp3MEFadkhNUFhKaXJpZlJrQnRzNUc2cjQ1alkwaEFmMjR5WWxWUURJMTJh?=
 =?utf-8?B?SHZoSVFoN1E0bkIwRncxUUQzelN2ZnpoUXJEaWtCbXV6U1RIQTJJMExGM1VB?=
 =?utf-8?B?U0dEbno0WTZOeU90c0pWVmZGRTJOK3lsYUJTK0c3eFBDQlp4bTBkZHU3d3RF?=
 =?utf-8?B?NlMyQklkQk56SVhScXcrRTZWUFhJNFQzMVlDWFFrOG1oQ1J6MWYrQk8zVStP?=
 =?utf-8?B?cTlHeE8rRDRaelQwWjJIQlhLMWNoNjJ2S3FoV0RNZ1hKdTRkYk83MnEwMzli?=
 =?utf-8?B?aS9qcERjaDV0TkdOdkxMK3d3ejd0SXJuZFVRMUhKVVRKUFZaN2d1KzlnMDhH?=
 =?utf-8?B?MFF2K2Q4dnV4aU5GMmFQc2NRVkN1dE1jU0lBV1BtWlVDSGg3VkxpditDbDdx?=
 =?utf-8?B?M0FrOEJFV0JXb2N6S0YwSGoydm9ybCtpL0JNMkNKQ0xaTHVUWGlOMlp4US9x?=
 =?utf-8?B?MjdCK0xTenhDL2pOcXBzRi8xSzlkOUZZS1AxUVpFeWFpUTgvbzVSaHNWamFE?=
 =?utf-8?B?WkhBbERuR2swbjFnVGRZcnNaV0llK1Iyclp5OWlLRjlTeVZPZSs0eFVHdm5W?=
 =?utf-8?B?cmdXMHd4UmEzV09YbXlna3NiQ2RDMlZnbEhRU2M4bjU3OXJ5QlRyeUZjaGhG?=
 =?utf-8?B?SHg3L1BqOHFSdVp2dmh0NVl1b09obnM4SFAyM2pySWFFeFRIMHlLQ1RRTkN4?=
 =?utf-8?B?TW1VSnoxODhpMWxiQ1dFWWdOTHZ5S0pkekhhaWRrSnVQY3I1VE1vWWZlSXB2?=
 =?utf-8?B?SzZEUmljSVloWUtoVDl0Yy96YVdxVHN6ZzhaMGdsdnl1dXV3Um5JVUFiZGZr?=
 =?utf-8?B?OUxBSmdKMmE1SWxLc295N0VWOUl5NEM0L0lKNThqemJsanFBczFGSTZMTWg1?=
 =?utf-8?B?MjJ6OHJVOHVWSk91MVhoc0FGSHBpRDRseldMQWhkc1BnN3lpU29kZlZLNnpz?=
 =?utf-8?B?MFA4SDBNOThGUTdiK2J3eUJKMWlYMldCVSszaENmK2wya1pkcjJFSkY0d2FB?=
 =?utf-8?B?WHAwSm1GeEJlVHB3K05SMEpqblRDUmYxSnF0MW5pWmRxcitWd0NpOGJMenc3?=
 =?utf-8?B?UnRDWDdUZElDcUF6cUpUTjlUNVcrVW12dUhOVzZzVThIdjl2VGRIaitranZn?=
 =?utf-8?B?cmpqT1hOaExlZ2RhaFZzRVlIbWJwMHdiVGhFa1cxRlpRU011dURLNXg4SEtV?=
 =?utf-8?B?ZW1jMlRhakRpcmpjay9lOFp2YzE5eSthdS80WDFrZXlMYUhPOE1JbXhNQUxT?=
 =?utf-8?B?R2FoZVJQbXVIbllqUmpxL0FneWxvZ005WnFWWkVQS0RzTW1KMmxsemJQNWJM?=
 =?utf-8?B?eXRLZ0xXZE1Icmg0ZGtMbnpDVkFRbnpYWkNyMUZObWZSYVlIaG5jN3kwcFU3?=
 =?utf-8?B?YnBwakdIaHFJOWJ2RHNvQktSRHJJWkNxYmJRQVJoNzkrMDFYcWRqdDlVT3Q4?=
 =?utf-8?B?RCtzaFVUT2hvcFFtK3h5eWpUVlhVTzh1bzJYSWV5UVRyU2ZubmprS204SWVQ?=
 =?utf-8?B?RDdHRXNmbWJENmpsQ3o4ck9NQ0ZGZDIvenhYR1gwRURwZUpPbkR0eEM1a2lJ?=
 =?utf-8?B?UHc4MXR1eDQ4S0ltT092Mnp0WUp4d3hKaGNlbVZOOExYQ1RDRDk4WkN6Z0dP?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7e5376-a2ee-4b7e-6674-08dde6479c73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:29:00.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HmIzT0AKKkL3tcvbiRUry4wCt5mMs/N2F68/xHKEAFNLCiWvOnOvncMWn0QADVtI3GypZDTFiCmA1B0MMto3B5y8TgagR+2phZJOCgN1zA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6159
X-OriginatorOrg: intel.com

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 28 Aug 2025 08:38:42 +0800

> On Wed, Aug 27, 2025 at 10:33 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Jason Xing <kerneljasonxing@gmail.com>
>> Date: Mon, 25 Aug 2025 21:53:38 +0800
>>
>>> From: Jason Xing <kernelxing@tencent.com>
>>>
>>> Support allocating and building skbs in batch.
>>
>> [...]
>>
>>> +     base_len = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
>>> +     if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
>>> +             base_len += dev->needed_tailroom;
>>> +
>>> +     if (xs->skb_count >= nb_pkts)
>>> +             goto build;
>>> +
>>> +     if (xs->skb) {
>>> +             i = 1;
>>> +             xs->skb_count++;
>>> +     }
>>> +
>>> +     xs->skb_count += kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
>>> +                                            gfp_mask, nb_pkts - xs->skb_count,
>>> +                                            (void **)&skbs[xs->skb_count]);
>>
>> Have you tried napi_skb_cache_get_bulk()? Depending on the workload, it
>> may give better perf numbers.
> 
> Sure, my initial try is using this interface. But later I want to see
> a standalone cache belonging to xsk. The whole xsk_alloc_batch_skb
> function I added is quite similar to napi_skb_cache_get_bulk(), to
> some extent.
> 
> And if using napi_xxx(), we need a lock to avoid the race between this
> context and softirq context on the same core.

Are you saying this particular function is not run in the softirq
context? I thought all Tx is done in BH.
If it's not BH, then ignore my suggestion -- napi_skb_cache_get_bulk()
requires BH, that's true.

> 
> Thanks,
> Jason

Thanks,
Olek

