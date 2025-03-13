Return-Path: <bpf+bounces-53968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5801EA5FCA3
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 17:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE8817DDB6
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EE626B2D7;
	Thu, 13 Mar 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TczQ94ml"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439A26AA8F;
	Thu, 13 Mar 2025 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884677; cv=fail; b=QuAypmrU1GpnI6nWT9z6CWjV1aMFN63KUyAH4zc7swkRGCZgGQC6w+IIDPe2cvroVAzm20IsJbMiDxeQGSpAQ5bFOJGd0P02dlD8M9Q7+06Tz0PY6MKOZWfoEDTtm5MLTjJheb2G0rtuQPvxlO/JNlt9L8B6LCEIG5SELDeLBu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884677; c=relaxed/simple;
	bh=Z+dyjBqOgaWoliQdlpfgzEu0j5McUJFuQj+ONokhnbQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cr5/7thf2BRb66825Wt82sy2QhDlNR7lAGw6DxLu8yt0rYt1oXQJ43oUsJfeI7N73QXVfDNiYt8Ti7T3NrZvD+yUcfeC/sc0fnsLHUGbi3Z7OzhcD5tXn7EQmWin4QhiP/ydFwqbv1FrB2/CJLtbefffTPVdHxaP8hPClKNrcv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TczQ94ml; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741884675; x=1773420675;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z+dyjBqOgaWoliQdlpfgzEu0j5McUJFuQj+ONokhnbQ=;
  b=TczQ94mliofoGt/ZpjJqWYdwIDj/TpRHdjyOyRPYNulfRF9YtyxwWmJP
   OcDqqNcX0b/CZVgghVMok7yOptqzIWc6azBAFtzPSImS1NDU0zpgbpr0z
   /nYmlEO1G0LyqLYzM4KnlMnDof2DGPtch2VHCXF3HDFd7lD+S3KPZJo9e
   PVUwSNQLBMXuFRrDu5QDtZRrjnf8D26M9QzLHD629U7G7xTKezXMAv54j
   Nc5LWD9KlUPSubC+SuYrTeMveiLrKQxvwiFFEqdskQnn7y5IN1NGwszlr
   v9l1e+rtIHJCGk4DSqthOS6Swh4G+rZgM//3q/ZzwFNxGZSMNxaFYD1Xa
   g==;
X-CSE-ConnectionGUID: LNzm2eKfSNyvN6FyPZe/zQ==
X-CSE-MsgGUID: fWOVJXYpQX6NnsZd6lS9Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42879426"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42879426"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:51:14 -0700
X-CSE-ConnectionGUID: hgWmNrqGQ76t32xETZdIOw==
X-CSE-MsgGUID: iaNi6ct6Ql6qMJsNxVXBcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121004876"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2025 09:51:15 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 09:51:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 09:51:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 09:51:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xa8GYzf88dERT+iLm4qlS+HNXOOl6tb0Vp0BxjNZnS/sUBoigN5CBTrozBaBDduSDIkUCdyghrYT/PE/zYvfAGxbu8sGenLqXAEGH0WL2h0BJItDdXnLnKOBgYTXRvKB6OuN0yACZOdghVbNKjc6gA/+fnbYsE+SLqcfmv2sUDVZBdO/mtA8h1qhR9PNqv4xv/OL9Zh8efJjhQ9jiOHeAl7HtMVNWs1e+L426fPBMWtzZFnH4kO/DRSY20WRGOstpRfmsXBBgME2KbeqFXedK3HKMl4yNgohL3IKPZPylIBChlhyJfGiE8Fs37XDXXq3LZeE+iqKX0j8hJRMzlLjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeE6tFQkS7zaszoqo2vVbS0JdrFkwMgZp/PIMeSRL1U=;
 b=APY+m6gfqPc/BPpCoU5gGvAEwkXU29XSd1aG3JSziML9Ox4ISuyLfRlNVIn8WVKfRMUoCicpHNvQns1FVLhgqAGmdRfX36laxRQroiMdhfVXU2cIUwjVBpmMDoLPhfSvidyXHGCuZ2RWQF2woMm/zqcYVy4WiCj4ZlhqQjSKO7inMpR5wK1Y+rFTJM1SyWqFxB5S/QfOTDw8GN+bC78m16w4sX3E+h22c/jaguX71waiJ9KKcxb3RxP10iYFnMCoXM0zlTZrZQRFagwbyEVJdl0Jqraa6xIxQrSIjS/Cap7op4c/ADQoqmS//IKh7p89QCxONJ5VzVyy4cKR9TfclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB7165.namprd11.prod.outlook.com (2603:10b6:510:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 16:50:39 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 16:50:39 +0000
Message-ID: <fcb3cf6d-7d5c-407b-aa20-63e2590cf56f@intel.com>
Date: Thu, 13 Mar 2025 17:50:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/16] idpf: remove SW marker handling from NAPI
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
 <20250305162132.1106080-10-aleksander.lobakin@intel.com>
 <Z8rbkpRca35brvij@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z8rbkpRca35brvij@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e049b4-c034-4a11-f707-08dd624f2f00
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmxpRDhPV1pXL05laUVoa21FSFRYZDIraGpLY2JxNlVqb2s4ZXNReGorWHN6?=
 =?utf-8?B?NXdQWDFYUisxSUJTOXNndXhRUFllR2ZMR3VUMGVyMnVaaE9wblhvQURha2JV?=
 =?utf-8?B?d2hEaDBOTWtrdm1qMzZsTXh5c0hlSVZ3WnNlcW1QYjlPN2c3R045T1dTdXFq?=
 =?utf-8?B?em5oVEFIdnJKWUtnMkRTb3MraUhnVElPakpERW83SmpiblhhM3JhS29peDVX?=
 =?utf-8?B?bEJTZEI5a3JVNjMybVdSVVZWR1hDMTExRWRaOENGWUNNYkxFa0JOV090MUU1?=
 =?utf-8?B?NWtaak5Wc0tBa0Z6WjBxRHhZZGdscm84OGFoQVAyNHdXbDdBOW8wNi9Tb2M0?=
 =?utf-8?B?OXlPKzZMdHJTWkRCdnI3YTNNV0Eyck02OGZzKzBtR3JsSFJhV0tXTWkvZEI5?=
 =?utf-8?B?VUNQcDU3QS9QeGdab3FsOGhDUlZpSmFybFVkaEswMkxaZ3MycDN0SnJzVDdz?=
 =?utf-8?B?L1VvY0V6RjVNN0l3emFCMVV3cUUycGpBdmJFcHkwbjhMMS9BM3ZIRVpRaTdt?=
 =?utf-8?B?WWhFNTV4NFNvMEx0RlFHbEJ1S0NiaVBmUDloTVMvRDRvWDNBOVp3bFUvbFA2?=
 =?utf-8?B?SnNqUkp4WjZGZ1pDTmgxWGlQa0NmN2dpckgwQi9NUjhqbW9vRUpZZzdZakZO?=
 =?utf-8?B?enVwSy80R1JCSDc3SVREZnNtc3pBc2x0UndsMGtBQTZHL2lDdy9kM2FxWFJL?=
 =?utf-8?B?SXhiMThSZDVraTBaMFlyK0ZQUnRRdWdwNlI1a2o3ZXQxcWhweVp4UDZOZ3Mv?=
 =?utf-8?B?Y01vdC9HTG8wU25NbXRmd2owa09DY0pDdU1aTElyRUtiVkV6YkJ0U3krcFlC?=
 =?utf-8?B?QVRkeFdOckY0VlZVN1V0R1pDV05EWWpISWF3Z1J5QWdRYXlQakFEQzZaRXhz?=
 =?utf-8?B?Zk14alF1aFlXNGxMQmIyNWVNcy9kVXdZVThTVmErV0VTM3gxcE5XRzF0cjhr?=
 =?utf-8?B?Uy9iYytSVDVKSmJKOVB6SVZTTHVOZWpXQXVQcmtKK01RWEF6c20zb2htOC90?=
 =?utf-8?B?bmZaWkFzVjhiQ1pRMUcvbUJDWUFBWFdiU015bWFmckNsbzEzU2plOGhQWEth?=
 =?utf-8?B?Y2JzRGQwUVJJNUNCUjB4TVdqaHNRZlRrUzFOZ2RKc2NKcjk3MGxCNThIWmJt?=
 =?utf-8?B?T1Q3WDl4QnJuM3Nmb3lyYUw4N3JORVlpWHM1cU82cEZ6Q2l2a2M2VTA5N0hZ?=
 =?utf-8?B?V2ZDdkd0Y1dEYU0yc0ZYZXdTTHFXNjB0YUdLaUhtbkxaWlowd2dVWFJqL0c5?=
 =?utf-8?B?RUlIWU1iSElMTVFFYmQ2WUpQRmRJRVBYcDVZUXZvM08zYTZZbmJ5Vk5XV25O?=
 =?utf-8?B?WitvUzQrd1NHNTgwdmdwTHA5T3JpOGVwSWtqaFJna2lidDdEWmNsU2FSRTM4?=
 =?utf-8?B?QTU3MDA5OHZ0b2dNVGNSUVdlQzNkZ3ZyazBkeitTTkFTTjRITWFjYTJsUjMr?=
 =?utf-8?B?cVZSYkVJTGpITng2OS81T2g5ZU9oVG5vVW9EQ0t3VjBUdlRHT0xMUHRHcmlW?=
 =?utf-8?B?aHdWWWJLWVVTOU9nNTVYK0lxczZtQmFPL3AxQjMrVzNiK0k4SjFWbnVmOHdi?=
 =?utf-8?B?L3hSTEJUMzhoVEtIYmE2S0Qxd01hU3RKVVN4bkF0NFA1SEtUWEhrQ0t2cGxH?=
 =?utf-8?B?WSt4aVpoYmNyd3RTYXNiemhjZTluby9LSWNLSjB1b0VmMllKYk9QOEpKaE5F?=
 =?utf-8?B?Y0gxZHJCK0kvYktaMlBhZHhNdVVwZVdPSFM0M1B2ekZqRG96TDVZTUllRGdT?=
 =?utf-8?B?clVHRVg0TSs1UUZ6TW9tbm1zbzllaytOVGFHZUJHWEJXOXdKdTFETjBLN1R0?=
 =?utf-8?B?YmlXNld6Y2d1a1FlSG1JdUdoUXJ2bm5rNDJDRms3MFc0Tm1Gd0RyVDJoRmJw?=
 =?utf-8?Q?Fe5tghBRIPqt7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNYclo0T0s2OVY1SS9hTUFEWHhwL2xxNHJ5N3ltNWZrdWNJWlc4U1ZNVG9L?=
 =?utf-8?B?ejFLMDZ6eTZ5T3owYXk5UnVxS0lYNmtUcmt6QllxbzM3cUNXU1lJWUYyeDlP?=
 =?utf-8?B?c0tVL1hpL0xQYjBvZGNxUDFHTW0zK1J5K3grenpKdlBKdlpmRU9RcHIvNFg4?=
 =?utf-8?B?WXBxaHVodjNFZXBZK1ZTSVN5RHdLM0J3Vzc3NTBHS3luYUpMVEhXOXFtVTZS?=
 =?utf-8?B?cVREcHVENWxFVHlZdURHVlNrNVNNblJXSDRFcnNyYnR6K3B1YjlXY1I4a2Vv?=
 =?utf-8?B?MGFaQ01hYjNOWDJUSFY1QThrY2k2Ujh2Tmw4M0dUUERJUGsvMVlSZVVWRHdM?=
 =?utf-8?B?bkViWjNwb2d0azRBeXYxUm85Q2lJakJKUVovaGpUMHBrNnc0dE8yVzE4SExv?=
 =?utf-8?B?S2ZYYTZGWmxlUk80VDJNWjFvK1cwamFjbDdSUU1RWVFzUUo5UElOeGV2ZlAz?=
 =?utf-8?B?SG5ycHJGU2xxbUJaa2Y0VjcxaDIvZ1B5Q0ZnM0pCWUlMNittMXlJTE9NY3BE?=
 =?utf-8?B?NS92RGR4WFBPTGtuemJ1bE5zU2tnUkhrVVk3bWVtd0w0cFhDM09MOHl4VTU3?=
 =?utf-8?B?MkFrR0NxQWpqcjVwTVlnV2g4UGZGQURlNmZLdHA2MkNlQnZTSmcvMGZoTzUx?=
 =?utf-8?B?MmZXMzdtWDVXQ1hwQzl4WXRUMzhnb3NTMW50ajh3bC8xS214NUcxNEVtdHYy?=
 =?utf-8?B?czlwU2FJOWhZTnoyWmVrTUJYbXNsd2V2c05XWk9RN0QvdFNkTXNYTlczVVJn?=
 =?utf-8?B?ZkhlUURzQ2ZpVi9naUkvODlIMzdMUnAvVTM4OEpNREV2dWlBK0p4cEhqa0Jp?=
 =?utf-8?B?YStVcnMrcVBBVFVKc1BGWnJGYzc5SzVDS1ZmSGF5QVZjWGhCU0ZpSFBicTNQ?=
 =?utf-8?B?SkppM0xlamZ6b2krR2kwWERQZ1FBMlhOaGVnME1vNkN5ZUVYSXFVOEd2azFP?=
 =?utf-8?B?SzhpQlZTWGluQ01xV1hVMmFZQTM5R25WUzdCZ3lOSXdzYzNrV1J0RERRdlNO?=
 =?utf-8?B?YTdUV2gzanhWY25tUXRRU0gvRnh0UWxzblYwYjRrRk9Xbk4vbzRSNWF1WmM3?=
 =?utf-8?B?WHI1cGxYN2tid0lXVmloT0xjZmNVT3VRaTRkRjE5Ri9EQUdYRFZMMVdFVy8x?=
 =?utf-8?B?NzczZVN1TWROdi96NTJTMlVrcytuNmJhbFQrSS9kRTBwcktuOUlnNis3VVN2?=
 =?utf-8?B?dVBaaytmN0xPME1PVzZ6MHJVdU5jZDNTV2dDZ1JrOXZicTlRbElMUDVTMnBO?=
 =?utf-8?B?VjJITU5vYWVWeFhUeFVBeEhSRnR6RlgycGN3M09vNzlSUWhKMFNYUGRTaGxI?=
 =?utf-8?B?RUEwcDFqRDJJZUhTd0ZubHFSOGYyRVM3ZnY3MzZkMDdVaW1BSlEvc1hmcnNw?=
 =?utf-8?B?WWdDRjFXQlQ0K1FCSjNMWWViUHRnaGYzTzBHMXBONk1ZWFgwc1dUUHRwNkN5?=
 =?utf-8?B?M1RlUEgrUzFRU1E3ZDl4dFAzYWlrQ1FxOU9ObkloTExzL0lqalF3VU5NZ2ZS?=
 =?utf-8?B?dXZ2VElBVVVwTjZoejYvUnpIcDNWNHduc2JoWExzNG5NUjNuQmdObWhRZ2Ev?=
 =?utf-8?B?S1kwSHA3TFBQaENDM01jb2ZKSUJOdE80WXFaSWt0UHc5dm1iL0lvRFRuaFB4?=
 =?utf-8?B?UlVRbk1kWW5wR0pRV0NrdXRGdHdXdFE0bTlsUC9aUHlJbTZPMnVlTWZiRS9p?=
 =?utf-8?B?L2JCa3B1TWNFOTEzSnQvczVWczFuNzFPcmdCVE9tSDFzUVl4Sm5Ob0dLRFRY?=
 =?utf-8?B?a3ZaalhLeVVWaExveDBMMVBVci9xTGRGVzBrTG5kcW9XVEFrSkpaejVhZmZs?=
 =?utf-8?B?RzdwVFJjdjlydlIxNDcvdXpkTjI0SU1iTnZBZm5YRnN2R2dXVy9aQ0pzc01w?=
 =?utf-8?B?cVN6YzJ6SHFmYm9Cc05qdWJyT2MySlN5OWNQa1lKY2FwR2Z6TXo2WkNoTHBO?=
 =?utf-8?B?enNMOEJZRnUxK3J2WHNyakdIcGcxNmZ4ODZ5bE1vVkhqR1FSYk5seTA1b0xM?=
 =?utf-8?B?ZnA3UXQwdTQ0RUFZVk1DN0RheE11VGNNSlluVXhIZ3hEOWdJSVhwaDJxSktu?=
 =?utf-8?B?Tk8zcGN2K0dCUjhLem5BSFlqOTNhaDVxYUM3V3UvaUZHWkQ3dmdNVk9hdlNu?=
 =?utf-8?B?TURPSElyc3lGVUVzZnl6d21uVGsvYTRMblQvVFhsT2pDRFZOdjJvWkZDYTNU?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e049b4-c034-4a11-f707-08dd624f2f00
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 16:50:38.9519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ksg/wUKtrbSHaX62z56Dm4hb3e6km5pMGm1to3PbNY0mfpUUY7YjblEvxzwAoBNtuDn+V5yTTDoryUGiJXkom8uBUHak3JGLat87MejduQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7165
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 7 Mar 2025 12:42:10 +0100

> On Wed, Mar 05, 2025 at 05:21:25PM +0100, Alexander Lobakin wrote:
>> From: Michal Kubiak <michal.kubiak@intel.com>
>>
>> SW marker descriptors on completion queues are used only when a queue
>> is about to be destroyed. It's far from hotpath and handling it in the
>> hotpath NAPI poll makes no sense.

[...]

>> +/**
>> + * idpf_wait_for_sw_marker_completion - wait for SW marker of disabled Tx queue
>> + * @txq: disabled Tx queue
>> + */
>> +void idpf_wait_for_sw_marker_completion(struct idpf_tx_queue *txq)
>> +{
>> +	struct idpf_compl_queue *complq = txq->txq_grp->complq;
>> +	struct idpf_splitq_4b_tx_compl_desc *tx_desc;
>> +	s16 ntc = complq->next_to_clean;
>> +	unsigned long timeout;
>> +	bool flow, gen_flag;
>> +	u32 pos = ntc;
>> +
>> +	if (!idpf_queue_has(SW_MARKER, txq))
>> +		return;
>> +
>> +	flow = idpf_queue_has(FLOW_SCH_EN, complq);
>> +	gen_flag = idpf_queue_has(GEN_CHK, complq);
>> +
>> +	timeout = jiffies + msecs_to_jiffies(IDPF_WAIT_FOR_MARKER_TIMEO);
>> +	tx_desc = flow ? &complq->comp[pos].common : &complq->comp_4b[pos];
>> +	ntc -= complq->desc_count;
> 
> could we stop this logic? it was introduced back in the days as comparison
> against 0 for wrap case was faster, here as you said it doesn't have much
> in common with hot path.

+1

> 
>> +
>> +	do {
>> +		struct idpf_tx_queue *tx_q;
>> +		int ctype;
>> +
>> +		ctype = idpf_parse_compl_desc(tx_desc, complq, &tx_q,
>> +					      gen_flag);
>> +		if (ctype == IDPF_TXD_COMPLT_SW_MARKER) {
>> +			idpf_queue_clear(SW_MARKER, tx_q);
>> +			if (txq == tx_q)
>> +				break;
>> +		} else if (ctype == -ENODATA) {
>> +			usleep_range(500, 1000);
>> +			continue;
>> +		}
>> +
>> +		pos++;
>> +		ntc++;
>> +		if (unlikely(!ntc)) {
>> +			ntc -= complq->desc_count;
>> +			pos = 0;
>> +			gen_flag = !gen_flag;
>> +		}
>> +
>> +		tx_desc = flow ? &complq->comp[pos].common :
>> +			  &complq->comp_4b[pos];
>> +		prefetch(tx_desc);
>> +	} while (time_before(jiffies, timeout));
> 
> what if timeout expires and you didn't find the marker desc? why do you

Then we'll print "failed to receive marker" and that's it. Usually that
happens only if HW went out for cigarettes and won't come back until
a full power cycle. In that case, timeout prevents the kernel from hanging.

> need timer? couldn't you scan the whole ring instead?

Queue destroy marker is always the last written descriptor, there's no
point in scanning the whole ring.
The marker arrives as the CP receives the virtchnl message, queues the
queue (lol) for destroying and sends the marker. This may take up to
several msecs, but you never know.
So you anyway need a loop with some sane sleeps (here it's 500-1000 usec
and it usually takes 2-3 iterations).

> 
>> +
>> +	idpf_tx_update_complq_indexes(complq, ntc, gen_flag);
>> +}

Thanks,
Olek

