Return-Path: <bpf+bounces-53624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D477FA573C6
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 22:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4913B28F1
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291F258CC8;
	Fri,  7 Mar 2025 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCLimyH7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A7252912;
	Fri,  7 Mar 2025 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383498; cv=fail; b=PDTvHw5a4xEg1UcChEDWGmAh0pA0C890pPAoB03Kivd+FT+UNEAvzM4sSFSG5mEdtAovFxI/mYIWnq1RaJ/vjbmTpv2doHePSaTUkfOnJ361IuEqt0OzpJKsCsmu9dMEkHTqiewzBcFOLTNlglr88V1LgunUrMHGTQB8IokCkmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383498; c=relaxed/simple;
	bh=vKH/Cv5rrbswrtNBecUZEGh0nL2TNZqOs8+DilUsTPg=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OTaHqW5dh+OrpsVhGsi/09AhzWxrA5JlFOHzRyabmYl1F85cnDFP1hgdtRatjIzJj3SxhVm2XfWb8qfpS5mbHjTiYmzHvcauI66NinSplaLaowHhpIaUAjsTlASzP6mR0x8rCtX60M2GqT+woLNU1ZabSzttrv5vdpGOVLMAblc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCLimyH7; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741383497; x=1772919497;
  h=message-id:date:subject:from:to:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=vKH/Cv5rrbswrtNBecUZEGh0nL2TNZqOs8+DilUsTPg=;
  b=VCLimyH7F36gQBT7ZwCGfIeEhIwBaUzAz6TSvv/U1m29A0A5lcbgeU2k
   qMF5/Lnxa0ydXVSXAGuM+TnoVcqVswSr1NKUuTBUxjMajp5YOaiZQIclx
   qDGs17cn84MjdOisbjckGF/08oQwvyQyHdxDuMPIO4XfXa+VtCvZl3Hyn
   EDJpbXrzR0a3CkKIOfEBpTtqkMXD8Q8xTjRXL0dukH2wwnrOWiDHHtdyz
   Q7izg5jhrYf6VGQMQionh+wb7lZKDLsB8HkW4xKh3M14+Gk+an4evDAxS
   4Ht04JBpNDdh+onXnHQkdhF2XlxfihSUiYeCzhyBnusTbsIMnfm0rbka5
   g==;
X-CSE-ConnectionGUID: ISiybjnxQAy4PJDOwIN50g==
X-CSE-MsgGUID: 3KCEiSoXQLmmGvy1fomoKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42570916"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42570916"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 13:38:16 -0800
X-CSE-ConnectionGUID: zeY/eUsnRJqZIrcWZQdgDA==
X-CSE-MsgGUID: 505YBqrfRiuRrL3l5u4tPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119180065"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 13:38:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 13:38:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 13:38:15 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 13:38:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8RGoyWayZxpAfiMwwTgxwwXKi7Jybzd35T5f4ZT9Kk8TVOiKDcI7S70drF9j4UDmM1HATD6DSjiXdd00+/L+ktXvf3MSApidtB3H8ldrSReR9FY6cktv09lNtyMZ5WQjAkvZsYqsIt7HJymRFk9iF8pLd3ArI7OY8PVnB3aVo1I2eq/ogQ8fLSKWnmTmdz6BRGFccD+C/nWHGnD/LJ8bH+ZNgsqAjt5esGu9h4o21v2RU3rEMkFTmgb03Fmb0SFT03ORFwv27qvarEYZ3lCJ3Bezr2p9pLqBVkbkOdJL3Cd5olSQo4x9slBmvJcfrTN1sPuxJhA2L0G78UwbQuRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0GeIgGSZZQH+zaT/axk9oSUnqhq9GT8z2QrbJAO5To=;
 b=j+XfbJ5k9i1h5Rn3VDu9YTPujFERGNxQI/Z2EoO2DFtkK/YVJUAQxMUICrUS4k1wBbiXOi/O/Vs+7Fz07UT3mUj7iJNoAGLFzBZyEpVUIYf9LzUPrCVvBpviEErMUnxV4of/PfqlM30SDItfUMaWerAAHqYe59N+RNzq9zaQ+srYG6+FaBQjSaeI3voneDo4ArFpvL88sDrXYcA5/7fjmmZBzVK2Sv/3LZAX6IqiIreg1Pyl9Y4Y1qV9a9bj6KLcTBPR3We9PDZApjqS7AQrydRo1UjcHfmWttD9is4loEeMd3MYF3Oo6yfDXSmlBk2G0QDVCLXk0Pj4K5zw1BAdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by IA0PR11MB7741.namprd11.prod.outlook.com (2603:10b6:208:400::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 21:37:39 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 21:37:39 +0000
Message-ID: <8d3bafbc-eb45-49c5-be78-cec96be52f82@intel.com>
Date: Fri, 7 Mar 2025 13:37:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] igc: Fix XSK queue NAPI ID mapping
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: Joe Damato <jdamato@fastly.com>, <florian@bezdeka.de>,
	<netdev@vger.kernel.org>, <vitaly.lifshits@intel.com>,
	<avigailx.dahan@intel.com>, <stable@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, <bpf@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20250305180901.128286-1-jdamato@fastly.com>
 <796726995fe2c0e895188862321a0de8@bezdeka.de> <Z8nRNJ7QmevZrKYZ@LQ3V64L9R2>
 <9ddf6293-6cb0-47ea-a0e7-cad7d33c2535@intel.com>
Content-Language: en-US
In-Reply-To: <9ddf6293-6cb0-47ea-a0e7-cad7d33c2535@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0340.namprd04.prod.outlook.com
 (2603:10b6:303:8a::15) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|IA0PR11MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bd6ac7-0588-4035-3df1-08dd5dc048ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnhpTjhjNzVtSDJuWTRqU3Z2cmJoQWFPUVROQm1QN1Z4MWtaYy9pYnVRVmQ2?=
 =?utf-8?B?b3BUUE1yWU9Vam83bjU2SnZOMDM2UGFCQkFyUTVvZ0c1MGpjb0JLWGhGdVlY?=
 =?utf-8?B?d05NSGdFV2tUQkJEU0VNZGtXcWsvQlNqSFduS3JGQUE2RVBsZ3o5bzV4Tmc2?=
 =?utf-8?B?UnJFTEQxcGVrRE40QUVNZFp5eG9pWVVFdDFOMGErdVg4M0RpS3NPUnBvNEph?=
 =?utf-8?B?RE56REQ0Q3p1akdXTHhTaFFHSlg1WjE3TnRjZ05Fd0tuK1VCc0FGSjlMTWcw?=
 =?utf-8?B?MGF4Sk9UWityb2x3MERKUXFNR2RmL1BSWHRzc3JHRW5pOVU3SnEvV1c4L2RN?=
 =?utf-8?B?dHlyQjNORDEvc3NVSUxUSUIxVFdzRWRkem9xbm9UaERKRUlzRHQvMmxINFly?=
 =?utf-8?B?Z0loOXJWa1JFL3ZKbi81MmVPYVZPZ0FHY0V4UEFNUWg4ZVdxM3VDWEpuZjE1?=
 =?utf-8?B?Z2JBNzNvc1E2Tk94SDdoTGg1ZndOeXZYc3Zoeis3ZmxwSTF6aHZiT2t2RmdW?=
 =?utf-8?B?NEJWR2N5VktUbTJJNFBHY3I3bEljYXpHZXdLSmFDRU1zUkFrM2c3V0R5bFcv?=
 =?utf-8?B?S3ZDMkRiUy9XdExvODg0YndqYndzdEpNSE9BaFE0a0hhb1JXZXhSc3U5c0Z4?=
 =?utf-8?B?U0RzN0N2UmVITHlqek9QYlFFQXRQMjBMUnkrWGFvYlYzeVZPSVBrL2MzcEFv?=
 =?utf-8?B?MDhvbDNhNmNNaVFodmQzbitiSThBdHY5TVJiR0ZMeDBLRGdEbEl5NmpUa2Ew?=
 =?utf-8?B?Z3NldlBRMUp6VTBCSXZ0WlpDUWF0a0tTM0FYNFBMT2VQYlVUelYwbzJyQTFr?=
 =?utf-8?B?Zy9IQ3NrK2dyVWFaUlNHSmMya2h0aUtVdUp6bjNrcjRhbDkvWkc3K2F1TUZN?=
 =?utf-8?B?Rm5hdmJwMEZNMlhaMWcwZlVKTVd6cTlVUStBQ1lsdmhuMDJ1Z0F5STVCYkQv?=
 =?utf-8?B?TXpOSzVmRmpMdUZrTkYwTi9peHhIck1mK3pxWUV2TlkzdnZoZUNoTXRHek5N?=
 =?utf-8?B?VTZmdFNWY1AvcWJETFNleU1vYmNhWEJkQkVMUXYvQXVoR0s2ZUNDZTJGbFdy?=
 =?utf-8?B?Q2ppeFFCM2pCZVViUlhpSnFFd0JpOVU0Y3VOVXRqNTdHYkExZDdOckpoT01O?=
 =?utf-8?B?eURQYjNXWC9YeVJRSkloZUgraktZOGJnaEZzMHRFZGdwM08rSnRqT2trUERO?=
 =?utf-8?B?Zk52TFd6TGhCNUhSYUNiYlE0d3hOcGtLQzE5ZWJWeXBEZ0UvcmhiYjhuVis2?=
 =?utf-8?B?ak1mLzFhdEpabWRLWnltZ3drSWt6bFdZdS9HYjZYN0VNd1dzR2twSjdMcTVG?=
 =?utf-8?B?bEp0OGRzRW4wUVNaY0FKNURFM1pYeUlVMHE4b3Bnb0gzczdkeDUwOU1ZbTVI?=
 =?utf-8?B?S25ZbVVmL0dMemIwc2RGWUhEdklKYVhISG94Q2gvUll0QlJhd1FNUE5DTzhT?=
 =?utf-8?B?ODlYaUgvdUtDSFhmVzRGeHRaRUl0ZTBjeE0wMS84U3dVbkxDVzNvZFlja2V5?=
 =?utf-8?B?S01YZHBBNU9vTjJOT0oyWWdLUURGV0xTN0FYWVZ0dFBsa0c3Zzd1TG1zNWRj?=
 =?utf-8?B?S25uWDlMUWQyV0QwWnNEWVVQUDZ1WVIyMzllSnNidzhxWE54TjVqcERvZit0?=
 =?utf-8?B?Z21SUmI2QUZiQTVLc3daMG11WGJIZlM4eHF4c1gwQVBiam84VEpUQUZiL2Jk?=
 =?utf-8?B?NTQ2ckVvYXEvbU4xM0Z1dnFJKytWbk1lU3JRSjNseGovcEFmekM0WW9sRDNr?=
 =?utf-8?B?Y0E3c3FOY2MxZ3FueE5FUTVJWEt4OUJFMFNOSTVEbDFMMWNERnpheWhITVJH?=
 =?utf-8?B?S3BHWCt6UzFRNEpGY0dzZ1phUUFZanZnQTFLdTYwTmVCR2JYcHNCNHBxdU5C?=
 =?utf-8?Q?9dEYJBqUQJYxt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE9qYnBheWZBZmRpRS9TRXFDUHBqMjladUpoL1d2QTRxNjVSNndWeUdjMW1F?=
 =?utf-8?B?UENBVmt4ZFkwZWQ5Ky9hMlVtVUhVNDh6clVYbGNNajB1dkFYZUdodWc2Yk5q?=
 =?utf-8?B?Zm1kWFFSN0tFVmNjS1NOQ0M5K1JQTnlvMXFFSnZnZm5NOC9ueGxmcGxvS3JI?=
 =?utf-8?B?VVpjUytEaW9qSUVMNTZHdytaV1N3Z254eVFxZFpkVzJJVjhoRGV1ZmpKVnJz?=
 =?utf-8?B?RTl6V3pLSHp1cFJ4Q1RRS1FuMjJ2NHNXeTJNbkJGQmJWa0hZaGdWdlc1VDZr?=
 =?utf-8?B?SGppUHQ1NnM0dWc5aUVNaTdYdkw4aWFIcHUxWFBoYU1JczlqMXhCdktkSFlk?=
 =?utf-8?B?OVJuelAySjkzTDBQbXlINTBmYi9DWjI3cElYcmRHaFhUNnBpd1Z0VHA4REV5?=
 =?utf-8?B?TkpNSE5uMFY3N3JhMzh1MW1nVlI2S0EweVpYWnBsenhXODR1bms0R2lvNWdy?=
 =?utf-8?B?NCtBWUhNMlNaWUpsbXlYSkNCd0tWaDBDckpWcVk2MExGMnlnczVvdW55YkY0?=
 =?utf-8?B?SGlSQ09KeG55L2Uvb3pZUHhOOHh2Q0FuM3M3TGJYcWpMOWwzYjFsdjg1QWpz?=
 =?utf-8?B?UnZDcFJkTnFTaGtGUWo5U1d1WmVoMnNtdGRGR2xvMC81azRLamozZnBlSDZB?=
 =?utf-8?B?K2tpZzBwY04yclpscGc5UURMdVhOTjVzTmxBWmZlL0xwVytkTVNnVTBCRjVw?=
 =?utf-8?B?OEpuc3VNTWtqZ2hucW03ZiswMG5VekZhYWlIT3Z2RDFCVjViME55NkJ3Y1lD?=
 =?utf-8?B?S3kvVWFnc3FsSjB3RFRhOExmbnVYUmM2M0c3SlZidHRWdStuaWxwLzVmdWZQ?=
 =?utf-8?B?anM5ZGtNVGJ3cXMxUFMxK3prOGtESzBnSG90eHlTaWxEaVE0djcvQzZwT2xk?=
 =?utf-8?B?SHRVRWFuQ29WZEpicUJYT2psRWUzMFY0Mi9UN25NTG4yeHU3L2ozRmVaR2Fa?=
 =?utf-8?B?NTJkeVI0c1hSMlZWdE5pMzZ0ak1hZDVCUUQyY29WdzN2c2d6U29qZU1sSDdY?=
 =?utf-8?B?bUR6QkdpTW1VenV1Y1FQblJORGdNRnh4ODNuTjAzODJpQ05NeVpUVnNxRStW?=
 =?utf-8?B?OG9tUlZRbnNzNGQyd1pBQmhZRS83akI4U3FRRGJicGRVMU1xWXZVbzhnWkRo?=
 =?utf-8?B?QUVqejhBREgyMk9YTkJpK0NpNDJpUDlFR1M4NlhRL01rY1doNWc0N3pvcUVJ?=
 =?utf-8?B?VUJYZHpzWGtNaTlIY0hKSVJjV09xajl5a2lNdHBRQU9mb3FiV3RBYlB3Vnhj?=
 =?utf-8?B?bm5WK3VwUElDTzRJNTB2TDhYQ2E1eUQzcDhiSkZ1Q2xSdkJjWWV1L0c5Qldl?=
 =?utf-8?B?VjdyNjlOZ2k2cnBEb2xnY3hUa09RNnlBWHQ4MkszMTJtYlhIbk9jNHF1cW5Z?=
 =?utf-8?B?bnhLSjNub3laUytrSEtHZEJkTG85MTZjdVZGaWhtMStSanNWWlQ1ZjFKdjlx?=
 =?utf-8?B?eDEwOEIrMCtHSUgvaTNPV0ExcnFydzR6RUVyTVJxQ0ZZcjBvWjNTQSt0QWhS?=
 =?utf-8?B?Yk1MTTJXL3BzMFM2LzIyOWt2aEpqZk9xOEJmc25VVmoxVXRRTytMaUY0bWFO?=
 =?utf-8?B?aGE4Z0wwZ1NtVk9wamVHbWV4VU50MGVGMEc1WFlNK2F4THVFOVJ1VFNQR1U1?=
 =?utf-8?B?MllkM1pMeXY2Tmtobk5Wc2ZoYmJRVHJtbFBRY0VLVzl0bm1qWTZscStHRWJz?=
 =?utf-8?B?ZzlCaUJMblZNbGc4ODVnQUVIcmJudVRzc2d2R2Z4U3FnckxVYWEzUzdFcE9y?=
 =?utf-8?B?eXRKMWUyTnZJZGZhVlJic3Jka0lCcEtXMlhCQVR6VHB3djczMmw1NmhXRUcx?=
 =?utf-8?B?MUltL3RKUmdyWmViTUduRjZBeURtenNsRHl3K3dySlZvM2kya2s0UkRFaDNi?=
 =?utf-8?B?ZVlSRWpkWEtWeEdFd3krVkNINXZUTy9iUXdNazUzYXBzeHI1TWIyZmxDa1ho?=
 =?utf-8?B?cmNGYk9HMnhkS2E4RDdJN1FGTmFjeHp3U2RIOFYvemR5VU9Ca2IyTVc3V2tH?=
 =?utf-8?B?Q1J4a1lvRFl5aFNPNXdxZERmOEYrTmRRbE05ZjIvK013bjJBYnRPdjNXeVdE?=
 =?utf-8?B?eUlVQ2VzQm0wVHl0YlFxd0E0eGk2RkVzeVZBOXFUWXBnU3c4bUtER2JYOHFS?=
 =?utf-8?B?cFBCa2RKWTd5WUJJSEJGbW83ZWxNY1hENWdkZ0x4T29pRlZoQk9Hd1kvTVdB?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bd6ac7-0588-4035-3df1-08dd5dc048ae
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:37:39.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dRp1hU6bDwf1UXVygTKFDVu94cAENN2h7BY9XEMPciRoZIQtJXjZUA5414LrwMS5t94fuU8Oj89jpcPAp3lAO73glFyb3ItQEfSJpMnG84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7741
X-OriginatorOrg: intel.com



On 3/6/2025 10:31 AM, Tony Nguyen wrote:
> On 3/6/2025 8:45 AM, Joe Damato wrote:
>> On Thu, Mar 06, 2025 at 05:27:38PM +0100, florian@bezdeka.de wrote:
> 
> ...
> 
>>> Btw: I got this patch via stable. It doesn't make sense to send it
>>> to stable where this patch does not apply.
>>
>> Maybe I made a mistake, but as far as I can tell the commit under
>> fixes is in 6.14-rc*:
>>
>> $ git tag --contains b65969856d4f
>> v6.14-rc1
>> v6.14-rc2
>> v6.14-rc3
>> v6.14-rc4
>>
>> So, I think this change is:
>>    - Correct
>>    - Definitely a "fixes" and should go to iwl-net
>>    - But maybe does not need to CC stable ?
>>
>> If the Intel folks would like me to resend with some change please
>> let me know.
> 
> Seems like the only change needed is the omission of stable. If so, no 
> changes need. I can take care of that when sending on to netdev.

I missed this comment [1] when I responded; I can make this change though.

Thanks,
Tony

[1] 
https://lore.kernel.org/intel-wired-lan/9ddf6293-6cb0-47ea-a0e7-cad7d33c2535@intel.com/T/#m47dd425fb4de4c1738839c2f8253ec51718d299e


