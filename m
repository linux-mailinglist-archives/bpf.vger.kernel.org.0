Return-Path: <bpf+bounces-29084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC748C003B
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 16:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32875B225FF
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0C58626F;
	Wed,  8 May 2024 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWuVIJNs"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3FA7EF06;
	Wed,  8 May 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179192; cv=fail; b=TsA0zrvlJcVv2AmMxBLSYZEGePxIERYXa7cAJ6ruhJsDtbgj96EGVYv3i4puM2w4ASS0ts7MbHjfAmcWqrjCi+1PZ9iFFwIScW+CmSlt8GYAYuLb4vMEFlZA+EgwkNlgQf9N3vMano4cmJ6XGUaXFbzcZJvJlSPH8T6y/+x3vyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179192; c=relaxed/simple;
	bh=MwOqXxMJqPcVTfjdg5wjbvT5KNENXzBH9F1z33cp5BY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MhoVV2jPcf7MHLP5t69V169uzVJIKWE7g7pHUf7ErNVksUs8YA7WjpGn95PGyOYiySJui13gzP81BNZk6FW4bp+mrf3GWexvd6rAFDjlcfekkOMWFqjIie6In5/qY0IEjfoNfdPYvU10rcIvkiEniXLX1OpFvEfRUQRQyDqdbN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWuVIJNs; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715179191; x=1746715191;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MwOqXxMJqPcVTfjdg5wjbvT5KNENXzBH9F1z33cp5BY=;
  b=bWuVIJNsLbdxAAEpA9tZEQyL5nEdrd4MfkZ4nmhYyDUFqWWaEtsX+uJg
   /ZfIyBDwSRxp1vIGV2wILeMz+Yy05CnZkFtewKHarlks/6IEL9S773HyQ
   W9RBpOgCX3gfFk4MN4k8U89g5hyBrOlPTdZNNIeKUFEs04Jw1FZ7qB0mT
   ek998rYTVcgAAHFfc4z+bFoLrbkmOo8fOL5Ufup7bfK43pJy6q0K0F7lX
   l3ZyeD9RY02/hGOP5DHAtMmr7XL3IetS+3l8H6wkrr/mh3dZGHqeFjiYi
   S6di92saazn/NVa0c1hnJeSdyvhq1yFKaLL0mJrJmDQbMm/v9tHCwHUej
   Q==;
X-CSE-ConnectionGUID: ETR4QGvxS+OAvVyGEB9bLA==
X-CSE-MsgGUID: vsyDB5byToGskmGsmH9skQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="36423228"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="36423228"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:39:50 -0700
X-CSE-ConnectionGUID: M47Pbhm+SXK6a2H9waqmTQ==
X-CSE-MsgGUID: SqiIU76mTV2LsqPGwNdecA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33741244"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 07:39:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 07:39:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 07:39:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 07:39:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 07:39:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8BAhdGpQll+HaeC+Zy9gkGtqUe/GXwdbSKSt6CqPenMcyQWacQPYIfmR24mtGOw5gaTcEs3swWWqawxnm7p/fsHyLDcvQpjNt+Q3b+KQkNlU91r6+/IvhPaZpbL0wimSpftfYYISdJoobbCtG4RmSjOkW2nb8Ru8gQPMAdbsk9qlWAzwkDBSzxGINI90FejNMjtJK7OANn6gZj1JkrWG4jnNgkqeZagq590Nmt8oXCp8qcmQlRfbkf5Y/xI8XXBRxevVY5fRj4cX5hyJmHCAUX1VichumHOh3gyP5yK485qszm4nLVeHDQPHtNsqg2kuPPewS1/3j6UoijKgxf6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V/9IK5GgLteBC47L6JFSG0XwCnStgIyfTF00RoKNBM=;
 b=gKF3qXGdtRrO+LKIQDmpuvlxIJPWiHji9g7Hx4lHFNtAk8VbikJ76gx/prXpAXn+7BtNrdqFl9t+LJtkkqy7T8ivspddw6bdMrtrd/hitYskJVLODQ1up35DbIT2MMk5tksbAP6Iwg/A159AHObBUStlEsJyt6iiKkQZdR0WESVBsHs/kaptnZPIdUcc985DkMH2206hECadaUBAqdEKyDOcMWsOvdzRJzIUS2iOwrJpfKG3gCLWGhzZapWq5isnm5FD+fvNHO/jyTro8zYRgkGEjbyzlI2YPk5MMO051qVpdHABsxdQfI9ddGEvsA17FVw2qU17ebnY2ueWg41P4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV8PR11MB8485.namprd11.prod.outlook.com (2603:10b6:408:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 14:39:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 14:39:46 +0000
Message-ID: <5ab7ae5c-79d2-494e-8986-d18d4a8e74bb@intel.com>
Date: Wed, 8 May 2024 16:39:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: intel: Use *-y instead of *-objs in
 Makefile
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
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZjuLW8jA3MuT0oih@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV8PR11MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cfc678-3f0d-4bac-c668-08dc6f6cb513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R28zMUtrdlBPcVZjdTkrTjhKS05KNzZMN0lkTm9tNmt1eFNQbnZSVHpSNXNM?=
 =?utf-8?B?UWlYaFFQZG8xSzB1OVFGdEpsZWhnbXRPWld0SGdYWXRoRkJONklUSmMxazAv?=
 =?utf-8?B?Y2s1YUtCRCt0b1VrZk44UWVBMWNiZTEwTU5KdTdSeDVrYTZLT3VZTDNPQVAw?=
 =?utf-8?B?SSs1dHlKT21hMFBVYURncTY4RUR2aDJFbnhZdVk0YWNSL3VEbWdhRVdVVWJi?=
 =?utf-8?B?RWFDQTZSZWF6Ujl4ckljOVNEQmdQVlNrK2RSTXgyZVc5dWZybE1QVXhMYVVo?=
 =?utf-8?B?UG5pWmthZFhwTmdZTXhPRVB5eDdKc2RHYkllRjlOUldiUStNWVBwcHRsd0Fz?=
 =?utf-8?B?bEFBYVA4V2Zickc2UGh0aVllVytDazRyR2xpRGZ6cWtzenRHaHVUNDlzdnlo?=
 =?utf-8?B?YndiNG53Zmk3Ri80SDJYWHFhNW9xMHFvdnoxNmJGTGxIOEk2VnphdlM3K3kx?=
 =?utf-8?B?MHh6eFdlTGpQdnR4NXdEUWJ0b05vSVJLYVpVV0JDNnJKUGNHZEtqU1lWdzVM?=
 =?utf-8?B?bTR1WFJNTFA5eVF5RXVRblE3ZGxjRndZbFQ4MXA1WStia2MvTWt3RnRuTmZI?=
 =?utf-8?B?OVpUVzhHeFRHc01Lc1pReEtHK1JMQkQ3ZXVaZEE3bEk1S1N3VFVCZVBaUWdJ?=
 =?utf-8?B?ZkhVd0FIUE9TeTdKZEo1a3kwRzdjdUYwYlcwNmtTOEhRNThyWnhSZE5UR3Ez?=
 =?utf-8?B?OExlSXU2dkZWYWoyM01uVTFqb2NGVytrR2RnRzJjMEhkRS96eWFsdzhld1Bn?=
 =?utf-8?B?TGQ3NERSVk5KMkc3WHBHaGF3QmtjQS9oNW1HaDNaM2xjaFZGY1ZpRTN5YlpO?=
 =?utf-8?B?NFpCMnVmRTFWMnBrSG9vNUNUUXF4bVRZcnRTYXNpUngwUWFRL3JsSlFaZm94?=
 =?utf-8?B?YW10bDdKZlIyRTNNQXZlRndIK1o0aGV2ZVBWQTdkKzRVVW5jdnJTbUI1WE9a?=
 =?utf-8?B?Y1k2VytTM2hlR2J2Vk9vWVJxUDdJcHhsdzdKV2pHdWs2UWM0Ukg2RXh0bzI4?=
 =?utf-8?B?UXFmeUlteEdPcm9UbUZMRE1HeEpjbXd4Q1lvR3VuZTFOblpObno3UTBHQzBl?=
 =?utf-8?B?Z1AvZU9lUDgyck1nR1hQZXBGQmRrME1nZXJaK3ZkWWZoZThhVjFFMm9ZYkZH?=
 =?utf-8?B?Q1hkZjhwc0QyWW5ZSEF5L04ycGZPZ0Zmd2F2UFAyT3dnemhSZStYUXZOTEVJ?=
 =?utf-8?B?c3BRbVQ3ZDlzemxmNzdPbkN6WFY4TTVaWFNFOE90aUN5ZlJQNGI5QWNCVG92?=
 =?utf-8?B?NzMwd2E5UU95N1J2RGM3eE9uUThDTjRubmZiamhVbExUTlBjdlExR1U2WXhl?=
 =?utf-8?B?aFBOT2k0MmpscHFQU0RNS0IxNXFkelN2TU5HZmVSakg1S3BVWXJ0aGExaWZY?=
 =?utf-8?B?M2doSWJqZ1dwL20yYnZsRFNTVHdzdExlM3hybVREVlJDMGV1L290UUdmN1hi?=
 =?utf-8?B?NVJnQkV0UWwyN1c1dHF3b0tqTlFWVFFDcXd0ZHhGME9KZEEyQXhqNStKcERP?=
 =?utf-8?B?TUFPbVVHYVZZVEQ5VzdJMzh4c2RTcTRkOHpTbU9yY2VlOWtTaVhhVmY4RzYv?=
 =?utf-8?B?Y1c1WGdZajBtRnhtZGVnT3VERllTSU9jTDhBOTdHTFJ5S0pxaEVQcy9vdTIw?=
 =?utf-8?B?N0lVd3o4S0dIanZXbURaUlpWd1RhQWM5MmRLU2xZbGIwakJqR09xUmJRYmcw?=
 =?utf-8?B?ZnJoV3ZRellHYlhmY3JqeHg4MThVZkdrNHJZM0JSdlpIcWZSSUlQUVNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEZsQ2xPRGlwM2lTbGM1SVZ2REJTdHBFMDZPRk5wbVB3VGMwbzlTV0tZU1dL?=
 =?utf-8?B?QUk0Mi9Nemd1SHpCb0JtVGJxR2cyZjNFdytFRmVmTmtncnlhTUZZQnA1dDVD?=
 =?utf-8?B?SHE5L0tDN0llTHE1NXJIZW5ocEdod2lMZE9IS1BlL0xwS1Bmc29KTXc4eUJW?=
 =?utf-8?B?cGhQV0w1NjA3VkRkRHBQTFA3Y282ZnR3L1lrYURWMjBZTElDcmRnUXpUNVBS?=
 =?utf-8?B?R0x4T0tzUm1CdmsxNlNScndRNDJTVGZkNFY3b0dhRUNOS2dqV1FLNXZhWk1E?=
 =?utf-8?B?YWZ3M3Nsd2Z5aUpnK1NUNU9URjZmTXYrelM2eG1YMWdnKytOWklBSmVaSUJK?=
 =?utf-8?B?cktFZDIzU3U4b3cxVXZwTHNqekEwRVlOSG1LMU9mMVNqVkFib0FrODNEZXow?=
 =?utf-8?B?aE1WY0ZZRURvcnNyMXorYUdEbVdhZUFtOFc2TjF4UThUenRZVVdWWnluRkJl?=
 =?utf-8?B?TU9DWVYrVzU5UC9oU3JsVktwMG1DU0luM2xjaW1QNWl0dWFnWWQxYmZqVXFs?=
 =?utf-8?B?WEIrSHg5dHgxK1p5R1g2V1dZOFVSL0Q0Q1k4ODdUZGN0bWpaS3BrOVhrSnNG?=
 =?utf-8?B?SEt0dXFTbTFIK1o5NW9qdW90dlN2NFJHQWlUSG5TRElLZm1ZOVhaYUl1Z25F?=
 =?utf-8?B?SXVGU05PRjJxc1oyZS9GVkRhU0Nzc3hkaEE3am90bVVCeXpzY0JYR1FVd3ha?=
 =?utf-8?B?b1VVcmRwRVZGQithT3NwKzJTV2Q0VDJBanRwVEk1K0lMQlpaSm5pc05VaVJ3?=
 =?utf-8?B?bThkbExXVFFrc3loRzBScUVQSE9IYlF2T01ncHA4VGo3L0dZTzJoZmJUUEky?=
 =?utf-8?B?YVJyT3V1U0hqNkJkR0lTVnlFa3J5L3Rob2ZYakorRkxJWjUrVkJINmNWQSto?=
 =?utf-8?B?WFFLd1ZNUFF6RU41emVIdUdSZFEwcVMzR1Y4RDNvMWRMSCtjR3hERkJCOTBp?=
 =?utf-8?B?MWNPOHhLK1gzdmk2MXBCaFE1NTh0Y2NrblljNE9RamdhWEFOakprSmVCbk1t?=
 =?utf-8?B?NlBkcUg0UE1DeUZEWE9zdkRUd3lEaDNnWTJ6RUdadlRQQ0F2dDUxN20vdXdn?=
 =?utf-8?B?ZWFOL0pwQUZxdWZoWmFqSlVaOGVlK1l4SWtjbnl3VURHZmFPZWdFb0RHR0tM?=
 =?utf-8?B?Z2xScDlkNVd0aFRzRklDZmprUkNqUEg2cjRKSTlzMWVKalFZZjl2WFp6QURE?=
 =?utf-8?B?ZXlIM2hnQ0VkQWk1emRGajV1S0tZSjJpL1p4a0cvQ3k3Wmw3eFB6d29iWXhX?=
 =?utf-8?B?Y3Q1bmNpR3BKY0lTWnRkeUNrRERjWHkxTmc1N0ZyRStybFNOZzk2TWpQU3Jl?=
 =?utf-8?B?VGJocThwYVFYTlQzMVhPR0kxZVlyZHljQVJSOCtSK3BnSWtwR1RyeUFwcXVE?=
 =?utf-8?B?UU9XQTVHZmFhbERESVpzeUlRbE11SHFuUVdqWHJHaW5GSmZrb0UyUVpmRlB1?=
 =?utf-8?B?Rmx1YmcwYlhwK0VJSlRBMSsxMXBCalEzbnJPUmsyVDBMd1BSSWg4TlJYUWRi?=
 =?utf-8?B?amlFZzNGNFJ4b2hGTVRtWDVFRTcyc0lkayt4MFZQbTJ2UTcyOFo3VXhlN2Vi?=
 =?utf-8?B?OThIYTl3MmV1NjVZQzlQL1phTUxFR1FmMWV4RitmRU5DL2pGMExULzBTeGVP?=
 =?utf-8?B?RHBTWExSVEtOOUxISkdZWmR4NTFLQnQ4S0U4ZjlGTFNIVWk1aUhaWDQ1eEUz?=
 =?utf-8?B?SWhHdzRncDgvdzJGQjUrNW1mZGlkeGFxcXNock13czk0NG1TTUZNZmV2cVY5?=
 =?utf-8?B?bFZFK2t5ckZINTNOeHhwblVVbnhIZHdGV0dQODJOaXJ5Yzk3NG1TdlZ0bDJX?=
 =?utf-8?B?NUNhM2xjQzM3RzByNlNMR3ZIMnR1UkljemJ6SWxFT3c5TDVtQWxqTFpEckdK?=
 =?utf-8?B?VElyQjNWdHU5Nng3NURnL1htMzRpcXIwVkhxNTZ4bmNWdzMyRTlwTmM5bXRZ?=
 =?utf-8?B?V2ZaRk9oSDhwOC9EVDdjRzl3bkpjYld1ZVAwTjdvVklXV3lQQlNEbE1kb011?=
 =?utf-8?B?TzhrR1FFUG1HTTZsRlMrUVhQV2l3YlZpOU51Z2JGcnhkRkhxTnZsTWdGNkJu?=
 =?utf-8?B?UTFudEsvK2xHRG14SjhhTGdrY3kvN3h2Tll3K0FlTWxMQnQzQTJMSWZtTGFV?=
 =?utf-8?B?S2FBNFBnTXdwM0I4dDdtTXU3ZHVMMUNUekpqWFRDRjA0MU55MUpOOEhqT0xD?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cfc678-3f0d-4bac-c668-08dc6f6cb513
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 14:39:46.8017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMSAp2aqQnDqRMtb6Y85+dUIJCwUjLa0MsVMUtOWyouzSSpmsMbEwmxQL4jy22rH5fSTLr53qCWu3uOXc/IqZaR2PVbjhAVrhTrPlngLPsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8485
X-OriginatorOrg: intel.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 8 May 2024 17:25:31 +0300

> On Wed, May 08, 2024 at 03:35:26PM +0200, Alexander Lobakin wrote:
>>> *-objs suffix is reserved rather for (user-space) host programs while
>>> usually *-y suffix is used for kernel drivers (although *-objs works
>>> for that purpose for now).
>>>
>>> Let's correct the old usages of *-objs in Makefiles.
>>
>> Wait, I was sure I've seen somewhere that -objs is more new and
>> preferred over -y. 
> 
> Then you are mistaken.
> 
>> See recent dimlib comment where Florian changed -y to
>> -objs for example.
> 
> So does he :-)
> 
>> Any documentation reference that -objs is for userspace and we should
>> clearly use -y?
> 
> Sure. Luckily it's documented in Documentation/kbuild/makefiles.rst
> "Composite Host Programs" (mind the meaning of the word "host"!).

Oh okay, I see. `-objs` is indeed only mentioned in the host chapter.

Thanks! Good to know.

Thanks,
Olek

