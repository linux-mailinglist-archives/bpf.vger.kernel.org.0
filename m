Return-Path: <bpf+bounces-66665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BF7B3850A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81443BF698
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41471A0BD0;
	Wed, 27 Aug 2025 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk7guf+y"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442D41760;
	Wed, 27 Aug 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305190; cv=fail; b=mopKsV5mJjk8dUvEES/NORkjuXl/sGeEAK3oTwxIVOvb+EiWa1Y6Y3HLE7DlzH1JZwEdgPcAzcj6p+vS1lBCBESkjPbPdf8rKHA7a7fzkuuNzePxDWZ4ujgjCJL1gda8wg/xP0oTFC3bMSA+kyJ07MtkbAIDhugyEiXtkE4uPas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305190; c=relaxed/simple;
	bh=0wfEug7gABAzkiJ9gTbIyNz+5cya/to0fNf+PMdF8qI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EkPwk8pdtsn899mxXVpZTlnEhjjaPVlsiJUdnYUffzIEfQu5uLe5G5EpQe1JY3fmIs8csKCtfu0KY5OzaS3EDT/O5Xy2TcUmX6Jp2qHq/jmFcfIbBzFl2nxchcEo6LAEPROjKtpmzLo2WfteRJR7/SAdM+SsCKaI5DVnmIPYSNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hk7guf+y; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756305189; x=1787841189;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0wfEug7gABAzkiJ9gTbIyNz+5cya/to0fNf+PMdF8qI=;
  b=Hk7guf+yTJhZpy9wuoKreQJLdt8Sv+hpTCPlNSE2/zSMpVUaGVeivt74
   CefKk4EbdidenrQym/aSNGx0vISTCQBqp0oqtjUz+HQqdsGDed9jDgenA
   Z/4yWXZJLAq8zanRP3qRUcX4bTO7IYMHr9fVB2+ujML8hquJQwSCFI+2R
   7ik087TOAFiuG5tKc/F7TU3zRo82lMfOrOUzQKvdeFW5E4MmEdCxb3l1s
   yLbK7sd4jalnlSGEBljL/a/OIrnVv1zjEgSSstcJGrMx4bYKbdFPaj+wL
   eo8tHvtzz/w/wuULH51JIk3Rghr7z+Cs7TGgku++kQUGGCkWUCvQY0TCN
   w==;
X-CSE-ConnectionGUID: 2I3YTRh3Srq0ROicz9LUjw==
X-CSE-MsgGUID: leyQuu8SRZKdIaBJaoRYiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58498218"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58498218"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 07:33:09 -0700
X-CSE-ConnectionGUID: RqoVb3AdT9C1lvu315o8eg==
X-CSE-MsgGUID: SITR//X0Ra2ksooQIMQT7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="193509083"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 07:33:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:33:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 07:33:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:33:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qy6JzUkhSsKfdO3yUPE5L8n3qbwGI81Cxz4wpLTOWr6wz0JShWrMwFh+2J+wBIEsJnU9B7WaMeEjdzOqO09uqHaKHFS9bM4CR5iOMugut1P5Ko/y9JIcP9Kra4A4g/wt8aqXxIMWLVaEkul8cD7cUxCT3jkPJ/ZtyS9KhZAUA4wo+7/PUgISxJMFk+u8aOUH1Tn2eMKLloc7oEpAx1oz7gCaOy0nWHjsORiVHg2ki0ikI6+cDxLmCnXkp/f2JpGLChbBzXZwZsESCNpijCZRUfBI5rM1dSt3PhHyz+hKEV0nS6XYOsARqDzEjnqVCRuGIEpqJvn6heGNScaZfYVlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=254iKYZT1sc0OBJf1oVbnZ0apfsEbABbrkQDp+xO0ZY=;
 b=Zn4wQ4yCxvxGqKKplUp0N1RlUHm0rJj97igEjj8tuAZbZqYS8a/DJPFTxjcCmnaeWRmaudqMV+yWclhBWY7/u9KIMBV3zDjLPUV4vrTRXiggS+4Up17jG/urC6ISdZe4UyvMVLd1Em9dlYSE+dgni9LagM5GrxBl7ODPhnNcf0xVR7MqV8egpLHWibL3kdu87e5zTE3EwiCulZ2Ru3bO1n5n1H3+Us2OLtAgSDlZy5mAsRgiD/vzmu3F5KkjOJURtM0bHznIhSSn8WJaDCtcab4MywQk6GDL9u7EZ2xq659u1gp6Ylp88MobUl63ibGMsV/Eh3CM9c/rBHYiuwdrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Wed, 27 Aug
 2025 14:33:02 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 14:33:02 +0000
Message-ID: <951bc347-0c33-4359-8d15-0e5e054b951c@intel.com>
Date: Wed, 27 Aug 2025 16:32:56 +0200
User-Agent: Mozilla Thunderbird
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
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250825135342.53110-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0274.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH0PR11MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f3b0cf-b6d1-466f-6853-08dde576a0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWFwOTU0Z0QyWDlmcXB2UkRmUDU1ek1hbWt2KzF6emlkRXhGR1lsM0R6VFU3?=
 =?utf-8?B?enN2a3NjS2hEOG5zTjJjekJlcjUwSDJ0cG91K1g4czBMRDdWOVJ4MTFWS2hn?=
 =?utf-8?B?WTExZnY0ZlB5ZGdKRUJTU2lReStSSjRhUE9idEdmZVc0NS9MU3ErU0tzdDJh?=
 =?utf-8?B?VTNvNHZRMFFVQ1p6RWh5dXc3MjliTlBubDJqTDlqdkpabUMwejZZSyt2UTRk?=
 =?utf-8?B?Z0dPNGxROE5LSS8zblY3bTNyUlVzd1pjNjU2OWNnR3EybElNemU5ekg2VDVq?=
 =?utf-8?B?VU5IVG8yeHRaRFFxc2NGTDBaTmF5R1BnSUd1ZGd3c1JMcVYrSSsxK3A0MTho?=
 =?utf-8?B?NlA4cjdQb1lvaHJHMU9SUThpUklEQlQ1dkx4MWhLdUJKS3RMZ2hzT3VkUGs0?=
 =?utf-8?B?YVRvVml3V3laVVg5QTArWE1kMjJMNWtrQkQ3cXZVMjg1UkRmV1Vtb0U3NDh3?=
 =?utf-8?B?NTJOMS8vUzI2UENxV2k1bnc0TXNKYy9mU3JRWlhBc3I2N2xBd05Qb2Q1NmJZ?=
 =?utf-8?B?LzJ5UXNhZWdibFhmcWc4Z1R3SG1mei9kUFozdndzZzdTN0RhQ0JWU0h5d3Jn?=
 =?utf-8?B?KzVaUkRXZE5KRjA4SEFvVVdBVTZyQWhCRm9YZDBVbkw0NCsrbkNHN0ZKWElF?=
 =?utf-8?B?ZkJyQTRJcWxqMUJCekxaTmdqaUhhaS9hMEl4NDQxVEh6elFZNHlkMnZ6QUVk?=
 =?utf-8?B?cXgyL0VpdG1rK3RZQnR5bXA0Nlg5dUVCQlF2VEk3Qk9vS1ZnSCt5UlloeTJi?=
 =?utf-8?B?bTlVckpNWDgxU2JuYzdwUEpNZEVIekVhOXpySE0zU2svTmJaL0doYzF0b3o5?=
 =?utf-8?B?V2NYaWtKenpaeHRjNDJ2Wk5ZejZUMlpCRHc0ZzFCN3lOcmgrRmxMcnNpOXdH?=
 =?utf-8?B?ZGRadmZxWDFTQTZpeGd4WTBwQkwramVVNng1QTUyVWVWd3RNZE10NzZ2MUJF?=
 =?utf-8?B?YXVNWHo2V2ZqTXlEUithNEozb1BwMy9ZbWVLTlprSnptdHZwTVRxN3JSVUo1?=
 =?utf-8?B?YTBscXd3UFZBVXJjSUdsaHFsZW15ekRxK0dVMW5NZHk1RDdCOS9id2hSOW9Z?=
 =?utf-8?B?K09sRlFaUk5rbGhsS3pTUlB4ajhSS2ZqT1g4b2hFdE90c3NEaFhueFV6QitN?=
 =?utf-8?B?eFB4TVJSNGcyR2xEMDN2T241aEsxYVdWQW9LUTNNcTE5QUtqUDRtTkh1cWs1?=
 =?utf-8?B?cmwzZ1B0emdIMWlSU3Nib3VQNlRQYWVpNkd0aVlGeVIwb0NhSXVFUFF1YVkr?=
 =?utf-8?B?VTFtam16aHY5aHJReFUxMFhJWkpDNUFiZzZwL01CWm5lRytwaERZbEoxczJX?=
 =?utf-8?B?SkFFdmduU2NDRHVqVlV5THBGZnpDbVNScFNQVUY2S0h5UzF5Qnh3eCs2Ukx1?=
 =?utf-8?B?ZW5qdytid3cxWVlNQVpGTmhERDlNSnRjRmR4SENUak5ObElHc2tiRVNqTTMv?=
 =?utf-8?B?MStBNi9LUXpVMXJNMmZ0czlzY0RGeDA5Z2hpUTVkdnJZS2sydW15dElaUWor?=
 =?utf-8?B?QnhaclRldlNZUmVtanp2NWkveitYbitvczdWMkhCWkY1YVg2UUhMRldERUZG?=
 =?utf-8?B?TWtPRDFIaUpGM2tWREhHR0R1YU5xc1JVQ3JWbmpmd1NPVEJVTEhIQzhWUm1Y?=
 =?utf-8?B?OU5GeUtzdXZsVmdmN1F2ajNBQjlTaHQ2OStoZU5yOTczN2N5UkdZMW1zWUdU?=
 =?utf-8?B?a1pWTVJDMTBWSVdtMnE1RCtsNGJWeTFuR21JNkhvM0pLSUp4VVpyVnc2OUFI?=
 =?utf-8?B?Mm55TFU1b3laS2Vxc0pRTVNaSDZhZlkrTzIyRk5JWXZrdzBuZUd0U0pablRs?=
 =?utf-8?B?OEozVnRmSWJGb3k5Z2VaQUdMeWY1KzZkR0QxY0FjcitnaEl5K2NYS2JxdmRH?=
 =?utf-8?B?aGtuUXNiOUc0aGtrSnBWcGZmbDV6RkZuaFF0VkpkR01VNWdXaGE1SjZoVzlQ?=
 =?utf-8?Q?FvM5vw/1O4U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3MzUDlSaDkxZFJNTXI4WGN2N0FCc0pEeWQ0THZaNFRYdVFWL0M2d2VIUFd0?=
 =?utf-8?B?cFlXSFZKT3NlVU5pdHY4THA2YVNySDUwUEh2aVlUWlo4RTRkaVZZRjM0NHNn?=
 =?utf-8?B?WGZ3OHJMN2NYc05kOGJkdE1tczVObzQ0alU0OUI4aEEzT0l2Vy9YMFR2U3Qx?=
 =?utf-8?B?c2hKR3lJY2Jhclp1b0ZHK3VyRy9JMGNRVStWMDFOY0ZQZ0VCNFJJZzhYRG5B?=
 =?utf-8?B?L0dLaDgwL1ZQRWtMdWt3bElSY0gwWENvdjFtZmxFVEIrYXdDSytCUlRXSnBR?=
 =?utf-8?B?QUhtWStIU1F4QmF6RkxYTUI0bEhyMk90anJvazBBa05pM2JKMitkYnNZcmRY?=
 =?utf-8?B?ZzUvTHk1ajN5aVJrNGRPOUxjL1ZYUnhlZmJWRE9Edkx3ZnlrMmo4N1BVN3BN?=
 =?utf-8?B?TXY2MkhVNWUwcUFNU0w0Qm5zM2s2UE5Kb25TNlVrT3NzbzZlanFMRHZTWmVT?=
 =?utf-8?B?RmhkcVNqSm9lazg1a2Z5czMyWWVVY0RLdkFkdmkxcktkV1J6ckU1RGJoUy90?=
 =?utf-8?B?Wk81RUowcE9ydjVrUUNCbGo2NytXc05ZRmdJNFh2bWw0UTY1bkl6ZGdLQkN0?=
 =?utf-8?B?RXlMa0hpeFR6UDljdEN2cjVXaVdxNUJ2eEsyYXBMUzhFSVdRQ3BuQ2F3Rkk5?=
 =?utf-8?B?b2lOUGE3Z0Z3YjVHaGJMdU5qYkZIU05iYU5sUTJMN1YwRW56SnVVUlhPNzhL?=
 =?utf-8?B?TC9lbHoyQ2tzU1Q2bFYza1RXeUhSRDlLRG44WnN5RzA4RGpwcS9ScEdoc1dp?=
 =?utf-8?B?Rm5IMDcyREIzM3RmL0xkR0p1VEZORVRnVTljeGNLdUQ1cndEY2oxNThCa2hu?=
 =?utf-8?B?ckFMb0c5ZjJnQjh3c2tNOGE2dHpmR1VGN0p1Mm1BUkg4SkpnNFpOdzR6c0Ix?=
 =?utf-8?B?MXRjeGxtYmtSdkJuV1RMRjdzNmFrTGhydjEyTlpUYTJlVnRFdUNBY3lBajBP?=
 =?utf-8?B?aWNNVnNmRFJNZy9HUDlvTDhsdjJnaER0L1pFd3RRdHIyZVN5VFRBRitGZkgv?=
 =?utf-8?B?ZkRyaFc2d2U3eDVnNDVGMHhaQkFkeFBDa0Ivc3RqVXZtNXp5QVZxanN3Vms1?=
 =?utf-8?B?cDRvcVE3RW1yQklEbk9pNGVPRitqcjl1VlI4WDlXNkF6T0Z4bE0zUVNRczlY?=
 =?utf-8?B?bUhWVlIyOVVRemIvdFB5bXBuNUV3bU5lcG9zVU1UK2dYUERIRVZtdE5lajNK?=
 =?utf-8?B?RU55VVY2TENtc040dU5hMFhyMGFYanBoN3dCSmZyT3pWc2M2QklCWUR4WTFT?=
 =?utf-8?B?UTcyS2F4ZGVOUXlodUhqWmxac2U2K3FmbHVjcWZyU1llUm5JMWJteURlRUsx?=
 =?utf-8?B?T3docDBZaGNYdEdlTCsxb09UTTcrSHVrbGFxZGRkMzJNYzJRVVlBb2Y0cHlp?=
 =?utf-8?B?UTQ5b0plelFrQ1lYajNoRy9NMDFTMGV3L0haQk5DTVlMUHZWbDZPV1hpenpY?=
 =?utf-8?B?aXRhTFlOQ21EZGd4QkFQVzA5UmJCWmt5alNoeHJSN0RraktJWG1POFRLdy9a?=
 =?utf-8?B?ZC9rOG4zY0FUUzY4RE5oU2dXcmNiL1lyMmRJYkE1Rm9zSE5rTTNzaTNCY09y?=
 =?utf-8?B?L0JnOHRKMTk4U0RLSFQyNGZQeFhnN0lZSFV6aE9JVWVEWkJIbEJZUkZ4NlFT?=
 =?utf-8?B?RWZQbkVtemNJSUxmeG1sUWFOcGNSd2dWWmUzQ01JTWNVTHk4UlkrWStqakd5?=
 =?utf-8?B?QkVFdlcrbEcxVDdUU29kL2preURWN2Q4WG84azRjUENGbzZyUXRBckVaM04v?=
 =?utf-8?B?eVlWa1dZOTdMNmZ0NHZyLy9aR2EyMWwrdVJ4WTBuNXplcXpsSEFSbnpRU2Z5?=
 =?utf-8?B?d2NpTGdPTmpnRkRoNDM4Z0dTdWNkTGtLdUY4SkwvYlhLbHZXYTdWUFhtSzVC?=
 =?utf-8?B?TG5XQWgvYllxS3FrWWVFSEw4dHZPZ2RmTGZkZDFWU1JuOVpKK2FGYTRUdTBE?=
 =?utf-8?B?Zk10R0J2cW1HeUw1VnZNaWhRMFc0WDdvY0kyaG9UZWhSRDZ4QU03ZWhyMW9l?=
 =?utf-8?B?YzkwNy9pbHo3Y1hoQndUQlkvOVdHR25haGJIT2UyRGs1MitJZkNlVklyOHYr?=
 =?utf-8?B?NWJrQnB0T2lkc1BPa2VPMEphQ0s2N1lxcUFkZFhhWHl3ejhUS1Y2TGVNYktw?=
 =?utf-8?B?Vm1mT0R6NUVQWjl4UzlpbzNYNk5QbklSMUJQSGUzWVorQng2K01QQVBleFFT?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f3b0cf-b6d1-466f-6853-08dde576a0aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:33:02.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvgFJGbeMnUgcqjcYeQtPTDKR8wWUUnvpk48YSt4FsIfA91BkYmc3N0OIZtY31r+ySPeJRJFoadRKY7pTdkjcdt1kzqf3s5yKGrlOVWjK4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219
X-OriginatorOrg: intel.com

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 25 Aug 2025 21:53:38 +0800

> From: Jason Xing <kernelxing@tencent.com>
> 
> Support allocating and building skbs in batch.

[...]

> +	base_len = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
> +	if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> +		base_len += dev->needed_tailroom;
> +
> +	if (xs->skb_count >= nb_pkts)
> +		goto build;
> +
> +	if (xs->skb) {
> +		i = 1;
> +		xs->skb_count++;
> +	}
> +
> +	xs->skb_count += kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
> +					       gfp_mask, nb_pkts - xs->skb_count,
> +					       (void **)&skbs[xs->skb_count]);

Have you tried napi_skb_cache_get_bulk()? Depending on the workload, it
may give better perf numbers.

> +	if (xs->skb_count < nb_pkts)
> +		nb_pkts = xs->skb_count;

Thanks,
Olek

