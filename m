Return-Path: <bpf+bounces-38895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D3596C1F4
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 17:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3EC286B1D
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF61DCB34;
	Wed,  4 Sep 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3Mg7Yba"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486C1EC017;
	Wed,  4 Sep 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462917; cv=fail; b=IWSVSNjDxE+3nLK5PYzobVCGAhDmvAIOsqa9cbyoZG5m73o/Aeg2oVFP7de/l6eu/rWYfxubIp/E2mv2AJJIlTIvRxdk3Npqbw8EIPqyPE7WEdDL/d6Az/THqArg7SmzlcJst4yA0aW8wOdI5h6jWiU6nDDMi46JV96HxLgjuJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462917; c=relaxed/simple;
	bh=/qW/iI3c+noKSgPkb4k8KNC6Dj5fFpH2Z1wegTXRfIo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OTR7vkkZ1fd6wFUX9PXDWaJHRsxH1aJd1MjCtdmRa78/R9vB+XqjCVtWwy1XlWMshJjsF0O8mXvlEwYV5/a1TbO+WRlZWysjI5eS4qED9oYM3lCBLYfeFL1DmDGQAfiVvpsCX27BUqEKvK5UIc56xaddbjqdjJV7+ALWO/KIL6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3Mg7Yba; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725462915; x=1756998915;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/qW/iI3c+noKSgPkb4k8KNC6Dj5fFpH2Z1wegTXRfIo=;
  b=m3Mg7YbauwC2iLCEJiTSN9Pt3uTq4uPZuJ6XfEpiTlxboQEVfh2dzsix
   GTtuof5dSusk3x8iwkCmORnTa1otN1BIgVMoNhDNjorEHHQhC7gEiLDW+
   n+jWzK0a8WpUL+RnbiU/eSTz1K3SH+dZy079GE/03dH4sSFD5rR5f3NMV
   hAs3Q7xu/1/yLNxv43w/EKFDmFDRJ/Ix1U3DnLq2qbpJMvGFeJSTjmfql
   QBNFZamhaLT8QbTF0sBNjicTF6jgtnKK6jTslVc7T6jL/x7l5BJBkEkIS
   utX6t7NyYLKBqK/gyY5ouc3VssbkPb7hMD+nbRB4s0R1gNAKU1/4w4MHT
   g==;
X-CSE-ConnectionGUID: XoEodwqHT+GpbFpuyIPEJQ==
X-CSE-MsgGUID: SDzc5e1KQuWUp4a5L6IKyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24323311"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="24323311"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:15:13 -0700
X-CSE-ConnectionGUID: /mfMkFFRTGqy7owj8VEHPw==
X-CSE-MsgGUID: 6soFbsGfRs6jvELw+h2POg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="65338293"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 08:15:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 08:15:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 08:15:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 08:15:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 08:15:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZZpYIRoc1guKB6OXv6tEg/rq+c8MT132seWrthLod7VK1VG3eTrWz9pTtK40jz+6ZNsJjgaL9HNvHRTU8lsvosKj37t6XolGkVUBr5T/VUckyN/mXo3JMwnLTjl3ZBFvn6AHmHR44GDuE47B/jGRE9PHP/WLBQej9Yu46Rblmq125WM+IR5RFi1AVHAQdd53HQEr/lspD1ZAQsNOMDoxOOpblpVhTkOH8thD2oaQIEt6qMK6h7FqDNVkRaTs0XR7XQ1EMq8zsRjY9Z5JQQTi0zIYcGwAD3ogvtppgq5pcOQccbb9+jwWW/6IQAJvNF3zomeVysi9TlDrZBqvFnA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUBlLwCzJatdhj3t1u8q61iHkl43TodZ2i+00JTWYV8=;
 b=QFAZYeVYYqPnlwjQePYtuZlTyuWvNRAKRiPrr5YSa7kU298rWCcSKyExUbewk6Mscq6Onxl2TdxvhihZX+pypUfgRUyBXW2L7rpx1q5GVg0GR/jvXnaPHGUFJZKi8qpw/s/DpP6Si/7HJ2JXZDBOBlk/BPkNrpNwaQgitvOIK9dCLMCscU/i0osYinSs8Shn8wmO4XhQbUt4643bD6hcOeBKeQdYCkPueTgEjh/YUAcLm7ZaTE1qcFQ9etV3vAaTpfJSqGEfnBd0YaSRcTPRvbna0eqyh/O3EXHuCMhTqFW9T22YANp9BZCiBgi1A7guHQ9T36D+OcpwWs0nlydMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB7469.namprd11.prod.outlook.com (2603:10b6:510:286::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 15:15:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Wed, 4 Sep 2024
 15:15:09 +0000
Message-ID: <03634fe4-8c2f-432e-ae6e-08928d167b1f@intel.com>
Date: Wed, 4 Sep 2024 17:13:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/9] bpf: cpumap: enable GRO for XDP_PASS frames
To: Jakub Kicinski <kuba@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, John Fastabend
	<john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240903135158.7031a3ab@kernel.org>
 <f23131c1-aae2-4c04-a60e-801ed1970be8@intel.com>
 <20240904075041.2467995c@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240904075041.2467995c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: f568211b-73dd-470d-48a9-08dcccf45da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVFZY1BuTGhpWkZCcUlHbVRUVVVRaEhmQVB1K1NQQmJUR1Y0S3I2U01IdHNZ?=
 =?utf-8?B?bCs1bktTRCt1dzRoUHh5OXUzWWZ2NTJSbWtFc2Z6YzVDSzNJR3pJU3ZrWE9V?=
 =?utf-8?B?L0h1VllLd0MvWUxuLy9pU2FOQ1MvckFNczhTMjBlUEJYaWNFRmp4S0RRcVlh?=
 =?utf-8?B?V2hwcVFiMW9NTnhVN1J5NVBxYXlJaytmeW9DYmdKUmtDOGxtdWNOME9kWGVZ?=
 =?utf-8?B?eDhXeHhJd3dsNkxMNytvMDNIRU40M1QvRnV2UzlKUzBsZkI0aDllL2xYTHlE?=
 =?utf-8?B?Q2xzaDRtRVkvdUZrTzk4MjRjZ3lIM1QyaGNJZjFNUEtoQzRTNE54SENqMzdQ?=
 =?utf-8?B?elNlN1RvUjgxTHZYbFQxNExvVHVKMmVHbWhycEdpV2VXdkRoTTdxVCsrc1lK?=
 =?utf-8?B?b1BQcFQ4YU9KbTh6cTdJRmQrMFFJVFQxSjR3TjFKa0VSQ2lSMTJQSWtrMHFu?=
 =?utf-8?B?VXdSdk5xSzVON3NOdzVMVWpRU3hsL2RZalRLUTBHQVBBVHU0K1lsMm52TnJ0?=
 =?utf-8?B?enFCNk0vTm9iTDcvWERFZjA3TU5RYWFNREwybzUvdDl3dTR3R3RtdXhNcVdZ?=
 =?utf-8?B?ZmpNQUdWVllaOWtXSUNlQ3JiS3QyZm44ek11UU95dGZ4eDE0UHdDYkoyQXlK?=
 =?utf-8?B?eHVoTVlUK1JSQm56ODZHcW9oSjBKTE9ubWhScWJmREo4Vk1KeDdub2JBREM4?=
 =?utf-8?B?ek5aSHBqTlQzV1I4WUpuUEd0YXExQytLZENKSENkZHpnQUk0UHlyaGFQKzNy?=
 =?utf-8?B?OUkyY1Y2dE5ObjJxa2ZXZDl1L2VzZVBXYVExL1pGVHJwNC9GZW9iZzYwLzlR?=
 =?utf-8?B?aytEdzRHcFlybmRaV1prQTZLQ29lK296RWwvRnFGbFN2MWVQaGhWc2xVV2la?=
 =?utf-8?B?cURGU3NOTXZMTWJxb2Q5WEhIZ0hIT3NscGRZa2R6WVZSUmFvcmcrUUlpQWNP?=
 =?utf-8?B?TDVxdnp5ekVVajNKYUdINW96UXRTZWRIQTRJUG83VTRVUU5iMVlodUdlY0Zn?=
 =?utf-8?B?LzJpaG5MeFdwZkJncGN4c0RsbnV0cEJVdnl4cjZDMStyRXVZT0xKVXBlWTRR?=
 =?utf-8?B?SEpRRnE0WWF2UDlPRWR4LzR6bDdiZGgzdCtkNEQxSkJwKzBxZjNZcUNJNnN4?=
 =?utf-8?B?b1JNNngrSEhwZGVxT2E4VVpJMzh5RnQrUk4zaENhRkJKZHAra2hxMUgxeGQ1?=
 =?utf-8?B?VlUyU0lrd2pGWlloTDVoOWphS3IydTM3Z2FZTm5GMkNDMlh5MHZyRzVVSHBU?=
 =?utf-8?B?b3NnZ0l1bXI1ZlRMUFVicm9FYXFybjBKeEdZR2NtOVNFQTZTSjZlMDErUElG?=
 =?utf-8?B?dEVwK2twRVBvN010VGJSYytJLytEZjRiYjEwUjh4MTVsajlVd0lNR3piSTJ6?=
 =?utf-8?B?RFVYRmtQQXdaYTJjUVFsTUtRRmJ0bUw1NFJYZm8vNmE0YnJtUFFNTEZBQWl6?=
 =?utf-8?B?TW5SSTd1TGUxYjQvK3lJS3dhNkkzL25DK2x5R1J5d0NRZEEwb2liekZXK01F?=
 =?utf-8?B?TzVBTXdUYkZmTWdod1Zpc1QxeVJqb3JTSEpKYks1T3NSKzBGalhWQU9zU0Nz?=
 =?utf-8?B?ZTFPeVdsdkRWWnlQcHk2VXpzM0J0bHE1TDBFengycGtZeHB2QWFHa0QrMy9G?=
 =?utf-8?B?eFJPR0VIa015V2pPLzlpemluYnh3bHIveFVuV3ovRTltKzNEMkkxeHQxZmV1?=
 =?utf-8?B?aFdSVUROUjBCWkZqNW81TjVCdlpEZHY3ajhXQXoyenoxc0x5L3J0WXFodnJM?=
 =?utf-8?B?Y2cvaDJITDNicVk0VlN3ZmN6b0k0NlBmZkxtcmQrWDZJQkVqRnJ1RVZSQVk2?=
 =?utf-8?B?K2NOekxyVS9lU0M1cFFSUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE9QQlgwL1VnRWNpQkF2RFhmQ0htaS9ZdEhZSzd6R2RGU2NETXpEcU5RSnVl?=
 =?utf-8?B?WWE5cSt0RElCZ2l1UTA3NEI1d1NlRFB0QXZ2cmp1aEQwN0JGRWk5WW8wRjhX?=
 =?utf-8?B?SU00Um10SDNHN0tNR3lVc2xKcE5BM2tLYzh3aVlLYVlmOXFpRFNZNnErem5t?=
 =?utf-8?B?d0xvaWNhTmpsVzdPdjV6LzlTU3JtODNrNDJYam1hQS9IRHRMay83dGxKMHN6?=
 =?utf-8?B?UHp4d1NCY0JFdUdmTVhZdGxqUW50Z1lWOWk0TFJZUGt4K2V4QWVKVnRiVDU4?=
 =?utf-8?B?bkZieXhwV083eU5aZlBsNk5lN0JHSHl1blFndy9SWXhtZzB0eXBpOEdmdkt5?=
 =?utf-8?B?U0E5YUkzV3BYN2hWVTdoNDJSRzM3SHhmUTRCZkkzaWE2S1U4dnROY3hmNHNT?=
 =?utf-8?B?QWZxV0tySUhJN2pYbjc1aitvRnEzWktNclV6ZjBvYzdhZ2VTRVF1b0I5dm4x?=
 =?utf-8?B?VXpObzVzRlJBVUhqcm05MVNjRW92a0g3YS9wc0pqamtlaFVZRnhrcDFVZ1FD?=
 =?utf-8?B?SzZUT2JzSXFyZkVINUI3THY1OWFjakFTTVR5SjRHaG5JN0hucW5IR2pRMWU3?=
 =?utf-8?B?Um1rcDg4TGJOWkVXTUxuNS95alN1K1F1TTFMN3N1TVFVaGhyWVkrOU5oVkNw?=
 =?utf-8?B?Um5OOXJGUHhENXltM2RTc2wwNE9YaWVtU3pmOVMzUkMxZytCSlhNOVNGRjlq?=
 =?utf-8?B?V0ZrbG5XQjkzNmo2MmhuVTFRREpxY2owU0IvZ1dMbElYSlRCUjNrSWJWSmll?=
 =?utf-8?B?SFUvWTd6MFIrVTNXMHJydmZsd0xQZFNWRDdENEt1cUNZMld1QTZFTHBjYVA2?=
 =?utf-8?B?WXNrV2RVdTFqYUJwazMxSzFWRzhRa3pzLzhvYkdCZUcwU0xaWG51eTExNnUr?=
 =?utf-8?B?K25ENjZZUW9lZ1JoQXFDTG9PNmZaaDN1UzNBbWNUbDlFQ3p4NVplUTNNdm5K?=
 =?utf-8?B?cjA5K0JIaTRTWCtvUFk3L25qVHkya09MQi80TnJNcC81N1lnWHVqTWlzeHZs?=
 =?utf-8?B?NmFoQWR0Z2NOMDNOQXJqTUROM1ovOW9WeitsZFIwb2t5bVdaUTROTHd6Z1o3?=
 =?utf-8?B?Y000NTkxSFZXSUhNbEpOanloUGtQakJtK3ZwamduY3BqdFUvNlBoYTZHVUE0?=
 =?utf-8?B?bmNnT1h0UXlYTm5nVG5McThGYk4xNmpLTVdlQXBLdm1FbWM3Y1kzYXhqS2xI?=
 =?utf-8?B?VTgyZ0M1bDFTMDJ3YVhuQUplbEZGa2FiRHdwdW5JN25sMGxrUCtpWDNpcERP?=
 =?utf-8?B?RUxOSWxGbjZOM2dpZHhETHFCaXpUTmJvSmpFY0dlNkN1U3ZrSVQycHFUS1lB?=
 =?utf-8?B?U3k4Sm9rdzNLOW5rYzVRVHFrN2dURkwybFhtTndydmtFazM5ZmxaN2MwQUpa?=
 =?utf-8?B?a2NwT1laY3Y1bTBjMEVsd2I1MC8zYjUwMnVDaWV3a2pJNnE3QkE5Y1lCNWVJ?=
 =?utf-8?B?NjRESlc2Rk1Pc1dvRFFMbXExb05pZFNTcmh5OEdsWmNxTlJsTyt4L085Qk5z?=
 =?utf-8?B?dzVTc2tQNDN2MUx2eGpCc3pFcHV0V05HcVBrOEVFNWczQ2pGeFVLZEpWM1FD?=
 =?utf-8?B?WmRZUnhEUXUrWk9jV2JuUDdsRFFYT3Erb1AvZ1BCcUZHUFJETEthbktuenJX?=
 =?utf-8?B?QkEvZWRrNW9qd1pVMGp0RkxGaEFUM0dRdlhsVHNmazR1aUNYT3YyUzN0WTgw?=
 =?utf-8?B?R1VuUzlDSVZYeU1TL1dMZGFLT3FGeTJhVlNTYmlkTGppK243aVQ3UU9BcmJr?=
 =?utf-8?B?bDE1aTcxWGNVeEVEYWk0ODVCSU5TWW9FeWlMbFJoMW82VFU3bmxTclBEOFg3?=
 =?utf-8?B?ZTZTMFRlTGJvSDBJVzdhMUxxZ25lb0VKRmFjUGowam1qUHZ2SW1Eb2JscEdh?=
 =?utf-8?B?WVpMemFZTllldlRnK21UcEhWWkp6RmZ1OUNjemV5SDJFVU5QQ3F3SU1OTFk1?=
 =?utf-8?B?blRHMjY3UXI2TUdRRDc4S3dGa3c2M0FBakJBNUdrZTlDR1dRYi9wWHNmZmwr?=
 =?utf-8?B?VUNrdmxjcGFySk5nYWljelAwV1ZFL1R5OTZvRlB0aXZuUnpLaGNQZXlUdnBy?=
 =?utf-8?B?ODl1TlFkN2FuSzJkTHpzT05GNTdHakpzSmVsbzg4aS8wU1hNKzUzRFh6NFAy?=
 =?utf-8?B?RTdYYldnWUxuenVoT2ZkTWN0dG05a21GZXRlUkt1dGZFZUhsM1lLOFNyRTcx?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f568211b-73dd-470d-48a9-08dcccf45da4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:15:09.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9KhfG7+pPcch8D5BzSmQfHDF39anXCnNQhPdR1+/WoKg8jMsO11GRGDu3OQaN0wsz63P7BUFiMadIwZka3ZSY7hspkhEZMFLYiO4KX8CWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7469
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 4 Sep 2024 07:50:41 -0700

> On Wed, 4 Sep 2024 15:13:54 +0200 Alexander Lobakin wrote:
>>> Could you try to use the backlog NAPI? Allocating a fake netdev and
>>> using NAPI as a threading abstraction feels like an abuse. Maybe try
>>> to factor out the necessary bits? What we want is using the per-cpu 
>>> caches, and feeding GRO. None of the IRQ related NAPI functionality
>>> fits in here.  
>>
>> Lorenzo will try as he wrote. I can only add that in my old tree, I
>> factored out GRO bits and used them here just as you wrote. The perf was
>> the same, but the diffstat was several hundred lines only to factor out
>> stuff, while here the actual switch to NAPI removes more lines than
>> adds, also custom kthread logic is gone etc. It just looks way more
>> elegant and simple.
> 
> Once again we seem to be arguing whether lower LoC is equivalent to
> better code? :) If we can use backlog NAPI it hopefully won't be as

And once again I didn't say that explicitly :D When 2 patches work the
same way, but one has far shorter diffstat, we often prefer this one if
it's correct. This one for cpumap looked correct to me and Lorenzo and
we didn't have any other ideas, so I picked it.
I didn't say "it's better than backlog NAPI because it's shorter", the
only thing I said re backlog NAPI is that we'll try it. I didn't think
of this previously at all, I'm no backlog expert in general.

> long. Maybe other, better approaches are within reach, too.
> 
>> I could say that gro_cells also "abuses" NAPI the same way, don't you
>> think?
> 
> "same way"? :] Does it allocate a fake netdev, use NAPI as a threading
> abstraction or add extra fields to napi_struct ? 

Wait wait wait, you said "NAPI IRQ related logics doesn't fit here". I
could say the same for gro_cells -- IRQ related NAPI logics doesn't fit
there. gro_cells is an SW abstraction.
A fake netdev is used by multiple drivers to use GRO, you know that
(popular for wireless drivers). They also conflict with the queue config
effort.

> If other maintainers disagree I won't be upset, but I'm worried
> that letting NAPI grow into some generic SW abstraction with broad 
> use cases will hinder the ongoing queue config efforts.
> 
>> But nobody ever objected :>

Thanks,
Olek

