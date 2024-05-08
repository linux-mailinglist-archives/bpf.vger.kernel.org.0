Return-Path: <bpf+bounces-29086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6648C0044
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C61B264F9
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E71C8664A;
	Wed,  8 May 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEBeMcPt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3585639;
	Wed,  8 May 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179255; cv=fail; b=MqUbQu9s6ktSIJMQAPSHQGUox9IZ1FQy01DWZf/+hNAiyB3IHjdabAH1oZBMcW3wJ7CQ6FISMK1ADGQyuF4oMo86fBr+695tsGHyH7hBzlxPv7WBi3y+SCpemULyrpH5FYkqtEcaeYoD1+3kPAgZhZGSUknvXTa4sDgCRpIgRps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179255; c=relaxed/simple;
	bh=quSkgWE/S7nC2L+AN/iq5OSFVDohT1phMhll2T3nhXY=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I1vF1SOys2iY7tLJy2LFOzPZv2Afl8nguakM9sdsdKncnN0nEkgfI3ZmPiy9HCmL5MzPsmfcQgSjmF46eeBkgdEdmCekdr8AjyBEVLq/2kaqoveI+p3uw9Qu7MJfGJhPR+hx2fN+aICWg+NwoUo1BzJMcyJr/ZzXc+u0+VSZHLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEBeMcPt; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715179254; x=1746715254;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=quSkgWE/S7nC2L+AN/iq5OSFVDohT1phMhll2T3nhXY=;
  b=OEBeMcPtGWlEbzAGfmbt/jfMIzTnZgZ2WJPbQ7SNRD5jbtlSFaqgZqmd
   zK7FSuQrbXT4wMxiDbANAMa3CbLHOEo/QVPqpjhLLucekTOmInXxF825j
   B/WiLEpEnrtG3NA9J4b3R7dioWfwpZ//hsv4mElSVGFXGlq6tSYoRJLic
   HTjrFr3yxYexznDZzo5LT1gT3jmrJIiOJDU29hfv+RGXozUPjpwNU/xNa
   +UESyQ1F8ab74VUd5U1hUS9rpcisu2oCVkcZMegLTDoSXtIeIkvzN1pVN
   RpGJXMqXHS7ZS3CIa9VE55VH6m7lMaF9zWjt2o8dFhmACeOJxLrSgds+s
   A==;
X-CSE-ConnectionGUID: xb337hcqQw6m5MgdWukknw==
X-CSE-MsgGUID: iQ6huVU/QYe+WCHc7OxSPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="36423411"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="36423411"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:40:52 -0700
X-CSE-ConnectionGUID: Yw3q+8/jQEylfxUdQBcROg==
X-CSE-MsgGUID: Z+YxRLrGToaKRrJTfhe/yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33741765"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 07:40:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 07:40:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 07:40:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 07:40:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 07:40:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU+YJH5SRKrj3ri5+EdUmOMDFBGASLxa3IU9DSacE40nbk4AOv+/hm1ECj+2FdYMDIkhOgZ+6iNOPpVNsPnD3svBbHB5z/VesuFsfBCVIWsE7TLnSd1eT1dorWCdIFUY5OdrtgV67b8e+xC3my9rUBDB5vmHUfX/3KNKALxrhZNT0AT3ZhE3jT7YBPfjdxjB1iBiPCH2ipPfjSHvmdNanGmrJGaMG/IyXoUzcz9h+ARGDmyeG9s/E/DDBnYYziDHWQYVnm+sycC3cTd1garovwDUGVtXPi6wN+yFZve7GzMJRnAYDUA+u/pJDlnYvzgQ+pAlvm5kKx2JOtZwoA7ahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbUVNgskTph+duwXZBWPIUpJZv1p6LiF8D7rJGbDRf0=;
 b=FGF0+DJLOX8NfDxxE6TJaNz4N5Zi/LVaS5zLlPbkLVS04tWrHVwjZPt70I2xFDGZqrRCleBYPfovMfVOLdOp0EfFKXihV7ododWZzXCXFpB4PaxHJDzN2Fn2vgNBYpaTx2kU7KLtvVUpRTwdP0TuuMfTiiDMbN4sd/+oPLg8hvttVSM1HBD4vo8CzMZd0Xb7U06QRSjJBfu/0r27MWUiVhgIOO62YO6dkU21TJuBvzHgG0tW/OcsdKMEqigoAUf8zEhcJIbRNAl1leWJ17K3T+lqTBezNvtD+JT16j2nWg+Iy8fq4IWcUuDmR9HV4Q7myciocGnnZKgKQv8z65Nvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 14:40:49 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 14:40:49 +0000
Message-ID: <4038b9d4-6618-46cc-bed8-a0ccd1c92cd2@intel.com>
Date: Wed, 8 May 2024 16:40:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: intel: Use *-y instead of *-objs in
 Makefile
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Jacob Keller <jacob.e.keller@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
References: <20240508132315.1121086-1-andriy.shevchenko@linux.intel.com>
 <6ac025de-9264-4510-ba7f-f9a56c564a80@intel.com>
 <ZjuLW8jA3MuT0oih@smile.fi.intel.com>
 <5ab7ae5c-79d2-494e-8986-d18d4a8e74bb@intel.com>
Content-Language: en-US
In-Reply-To: <5ab7ae5c-79d2-494e-8986-d18d4a8e74bb@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 435d835a-ad3b-4296-3c7b-08dc6f6cda5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm1LVElWR0Q1dXJWL2NQOWVkVEhLR1ZkRXY5eko0MFBjUzNxNFJhL3A0QlJK?=
 =?utf-8?B?ZURpZDJ0UnlFb3JJeVB0RW9LVDFqN25yeWpIZTZEVEljWXprQitZVDNTSk15?=
 =?utf-8?B?UXBmUS9iZUhzVTFwTnk3QlBJRVgwclI4SUx3MVBmQUhUdGQvRWxBOGNSVjdT?=
 =?utf-8?B?MGlidXhvOHp1WDZXWTM3MmNVM3ZrMlFrS2xoOVhnQVgrOUMxRmRWaDdRcFdE?=
 =?utf-8?B?cks3ZnZKUkV0WUZMc0ZIdGZ1amF6SlNmdGV2OHpscFBKbGNpNk4vZVJPa1JY?=
 =?utf-8?B?NXI4TjRlZ0k3M3V1RmtSSm41VEN4a1pDY2hYWC9IZFYxZ2Y2QWhwTG0zZWRU?=
 =?utf-8?B?eklaZUVneGk0R0N0VVJXeW9BcWZ0dVpVL1pHZmlnSUlobzBrUzd6UXowR2ZI?=
 =?utf-8?B?TGZMZDJsZkoxbldLQlkvYWc1aU1rYnpubTZuclZVVWJINXlqaVdqL0todmZy?=
 =?utf-8?B?cmJyRTE5M0tYNVFGSmxXUzBKSGYrUjRHOUFteDNwV3ZiSmx3elZzUWphV2p2?=
 =?utf-8?B?bFd6dzU0YndKZEJzUUpFaUV1cFdLSUlJVUZJaWlEc0JsenJKQUVpQlhwaVdu?=
 =?utf-8?B?dHozdEc4VFJjQmh1L1h3SG5oeHJCZU5nYjU0TXkraVZ6SEwwV3BuT0RDYmZO?=
 =?utf-8?B?VWI5dUlSOFJKSlZDc1hyejhQbEJIdlVQTjdmcmkwWDY5NnZuNlZmZHVUR2ky?=
 =?utf-8?B?djJJQVY4L2FKSWpTMVFTYkNUQW5wZGtsRGR3b3lFLzJvTEVTR0w5eXpuSElp?=
 =?utf-8?B?cDZwSmNIbFNMbEo3Mjd3d05CNmRwS3FlRFFRREVVUjZOQVhvc2ZiSWxCNUZl?=
 =?utf-8?B?ckMyNlVIekxPMGpqZm9EOHhYUGp6eUs3Nzh6bStVdGJoRFNVS0h1QUkrREhX?=
 =?utf-8?B?UzIxZmhjVmRkZVJvSE56M3dIWWVOYnlIdGk3WkhyTjBjbUxYTGFGb1F0dzlt?=
 =?utf-8?B?OVRTOEtDV2cxV1dMM0Q3bER4SUdBUzk5eHpkeExRVE9xUVp2MGt0Q2V3Q1R4?=
 =?utf-8?B?ZGtoOXVRSkVnWjJuTlhxN1RUQm1Ybm8vNWNsVkdSeFV2aVpnYkZlTmRFd3VD?=
 =?utf-8?B?dmhnSzdRYUtFYmw0cGRaY0xBdUJqcm1GdlpuN2MwYXNFOElqRk4xeHh5MXht?=
 =?utf-8?B?VnRkc256QVJHbmNxYU9uMTZIZHZ6Y0ZmZFVyMHVnZks2Tk1QdkU1MnlIR0hE?=
 =?utf-8?B?MnVTUkR3RU9lNjNFVW9hL0JHWXdhK1B0aVNVNVBOS0dSNVJmRUt2SmUyWkg0?=
 =?utf-8?B?cWdPeXNaTXlLajFsMHFLT0RDVGwrQkRkQW9Gdy9semlYZGVaUDlqZEp6NExn?=
 =?utf-8?B?ZmpDZDh6QWhrMXF5RXBFR1BHYUhYQnJtaEVadDJHOFNUTjI0eXR3STZGa3Yw?=
 =?utf-8?B?Y2tnay9CcjZuWDhtWFk1NUU1TDhqalJkZ3JIWExDV0FsMUxIaG9QTkhlSDVS?=
 =?utf-8?B?NFRySWozMmJRYm5hT213OFF6eEF4RVloZjVPdVIyVERjdFM4b1NKK2M2dXhx?=
 =?utf-8?B?MDNIYVo0N0NuamJ6Ukp2VVhOOEVpcFNtRW1NdkVzR2ZLdjd2RVIya01tcWNV?=
 =?utf-8?B?SE1XZUVRWlNWYnk3cWJudjlFL0Z5eWpoWjdBTjNlVkJpbGFqUmo5ejFFeGlC?=
 =?utf-8?B?TEJEQzNmSDhKYkhuYmw2czM0bXlYaXVQcS85dzM4cXFMUjg2SnF4RnJWZWJa?=
 =?utf-8?B?MVFjdW10alRCczhCZndiVjN5YjIrYzJiUXNPZGV2QTl3YVMwbGNIQVhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0J3Qy95OFBwckZVZ0RHb1pTL1R3d2pMdk5weDlUV2I2YXcvaHExSmRkd0tn?=
 =?utf-8?B?ME9LdzNFcHl5djk3NzFrcU9MYXdrNE1NeSt6bHE3YkQybmVBZ2Jzc1o4T3da?=
 =?utf-8?B?am9DM1lVQ0FEUzNWN1VVWnhXVGh6WXh1bFoxYVhVT3QyemY2cWR2cUtGRjdj?=
 =?utf-8?B?dFhpVTg4L1lUZDlwdERUTkVxTVgwQnRrSDNhOTFaSDlzaTlrMXAxb2tGMm1O?=
 =?utf-8?B?dENVaXZzTlozQm11enhESloycGkybnVJR1pNaS9uSmtTQk55WDVJOUZSeDd0?=
 =?utf-8?B?L29sUUd1dUh2QyszSWZyZUtmM1dBdjh0bGFzd2hiOXpRMEcwZzVyVHdOOHJx?=
 =?utf-8?B?S294S28rOTQ3ZzlKMUM4MzRJUVBRaHJlZVJvWlVFVXZJWDdoY0R5cS9QQ1A4?=
 =?utf-8?B?aXRIZDR4ZWFBb2o2Q1N5Q0RPa08zZHhrSkdwZ1p0UGEyRHIrWmZhcjJQM1E0?=
 =?utf-8?B?YXlKMlhaQzN6N1lscTE1a0pidWhUZkFYNkJkaVdZYUNzMjNyc2lFSzJZQmRj?=
 =?utf-8?B?RWhnSEkrNEY0ZW43a0YwTkVleU5QRzhES1JZcGhtelpRblRiMWlRVi9nTENj?=
 =?utf-8?B?dXpzQzhDNHVEeitwSWpYRUFYd0h4OWRzeFFWK29XU3N2UGZ0RjUxRGxyb1lY?=
 =?utf-8?B?M1NUTlY2SmZKcGdXYWlGZ0VtWks3N3ZOVUVJbWJpYVMwWUFEMUk4SUhTWDZE?=
 =?utf-8?B?TkFyakhSNCtOenN6YUl6dmx6dmw1UUNIazJwYTBUVWw1bTZOU1Rmb0czbEdJ?=
 =?utf-8?B?eTBPSWNMMXV3RkMxTlNwd1JGY0FWMmFuRmd1Y0VsQlRiVHdaK1dYdVN5NmVv?=
 =?utf-8?B?dWdJbDY0KyttYU9iOEo4WlVhWnFQYXUvYS9mZ3JvYTZ5TzhmTnFvYzJGZG9R?=
 =?utf-8?B?SWFkczRxa0lTRS9LM0NBVEhSOW9rYzlwa0EwUlBZQXI2QVNncEZSa3ZGSmU3?=
 =?utf-8?B?K3FHY0VobzRRMzgvR3ArcjB4dGM4THl3cFR3enBrVlJibVdGZ3dnOSs0TzQz?=
 =?utf-8?B?cnlkWWJYR0pNeUNUeWJJVm5tTUxUNFBBcHJ4UE5Uc3Z4dFFheE82MEtoOWdS?=
 =?utf-8?B?TXlQRUtJd0xFK3RkMStMNnBqSWtmZ3FmdGRrSHdKZERISzFiQk1FcGI1VzA2?=
 =?utf-8?B?bnN0K0ZDMkhKMEE4Tkp4dC9qa0dseWRtS0laT3MxL2gzaEk1cFhLRVM3R2dV?=
 =?utf-8?B?RWdwQTVyWDdMTHM5Z0NqNzlCR0EvclczV3FrZlFyd254UDBvUzN0RytZT01s?=
 =?utf-8?B?cnFMRmgxMjhERytwam9kQmd5T2xsUllTUW1SdzdyS04wVkhYZ0NXRzhZUkky?=
 =?utf-8?B?M1ZxeWRzNUo5aGNJZ0w0OTFRRjhpZmJsM2hTV093MjJVN1RueWVMNEdFdkFR?=
 =?utf-8?B?NzFpOUR4alBzekU4QnZJS2JNT016RllRUWFrdzJTYzN5U2N4eHVIZUZuaDFy?=
 =?utf-8?B?ek42U2NtOHlDWDQ2aE1FRU9ITTRzaDNXcVN6UGRoOHZpcjErOXpaVCtWQXBT?=
 =?utf-8?B?UnFJc2xTK0lSUEpHcTFCUGFmL1luZkRycVgrbHdFQmhuVi8vM1pNd1RLY1Yy?=
 =?utf-8?B?YXVVVVFLYkdKb09rNUg4ekt5S0xLK1JuaXgrMGdsWDNVMVVmWUdTOWlPWHpK?=
 =?utf-8?B?SERtTUl6eGlTdTBUK0JPMkNzdWNFazgwSytEb3lZcnJ3c3RCRGdza3dYRmdi?=
 =?utf-8?B?dmVDZDBvd3cvN3ZYako4VmxGbURJTm80MWtzbkNpKzVrS2syM1VYVU1OQWRC?=
 =?utf-8?B?czdkc0FHcy9Ib1VoQ2o0b0x0cEhPRGVXbTVUdkJidTRFSE9BMy83Vy93Sk5s?=
 =?utf-8?B?WTFUazFLaEY4bkl6VWw4K00rMDlWeDdlOUx6WkZmVGxpOFhNVlBjWkZOcjQy?=
 =?utf-8?B?TlZrS0xhZHFLalBQSEMvVFlURW5oZDZSV21VTGxYQ1dxMjdSdjUzVFR5cUpz?=
 =?utf-8?B?K1ZsaER5Y2lhRmE5UFRoUGhRSjg5MTBOUjZMUkQwNXdJRzJmN0U3eVRMeXJ1?=
 =?utf-8?B?UXVCV20xV2JrL3ZuVVlUS2IzNlJmbk9uQTRaNFJSdWVGdWgxWFlEaVZJUmRV?=
 =?utf-8?B?UUFvdE5ramN5V21SS05rbXBQUnJyNXI4NnpFcFMwYWYvaERhMm10QTlHRWRj?=
 =?utf-8?B?L0tBUFhLa2NyeUI0VGdSeS9abXE3MmtFOW5JR3JGaWZxV0JpQ05jNGtjZEIy?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 435d835a-ad3b-4296-3c7b-08dc6f6cda5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 14:40:49.2915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HA1d+LKjEpqUwyaCTeymAsVqvPfauQk6sNMiFPkAB5zzPD/4ZtStA8g0X+cp6VWsWEH1ddJyIpfbJ3k5moiz9Z3aF6H0FHDTg6CNdE8fzPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Wed, 8 May 2024 16:39:21 +0200

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Wed, 8 May 2024 17:25:31 +0300
> 
>> On Wed, May 08, 2024 at 03:35:26PM +0200, Alexander Lobakin wrote:
>>>> *-objs suffix is reserved rather for (user-space) host programs while
>>>> usually *-y suffix is used for kernel drivers (although *-objs works
>>>> for that purpose for now).
>>>>
>>>> Let's correct the old usages of *-objs in Makefiles.
>>>
>>> Wait, I was sure I've seen somewhere that -objs is more new and
>>> preferred over -y. 
>>
>> Then you are mistaken.
>>
>>> See recent dimlib comment where Florian changed -y to
>>> -objs for example.
>>
>> So does he :-)
>>
>>> Any documentation reference that -objs is for userspace and we should
>>> clearly use -y?
>>
>> Sure. Luckily it's documented in Documentation/kbuild/makefiles.rst
>> "Composite Host Programs" (mind the meaning of the word "host"!).
> 
> Oh okay, I see. `-objs` is indeed only mentioned in the host chapter.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

