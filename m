Return-Path: <bpf+bounces-29170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6028C0F19
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074231F22CF4
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C76C14AD2E;
	Thu,  9 May 2024 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jR6ay5Kf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D023D14A90;
	Thu,  9 May 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256091; cv=fail; b=K1CmYmueLFErigtGVMB88onF0551wgua4F8JKCQprNJrK34p+n40+PUrNpY0eQIyOsOBbrNrTau0RkKJG/xAm+Y5CFuL59vnPj3qYM+y9Vf9Sn7hyKixRKQ3bSSWS0p9/KIHP91jcqYHWefqX8l0AolmQTMfNo2/O50Z4cMjvEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256091; c=relaxed/simple;
	bh=ciMFhbCrt0j+WssCqAEmlKTeIXQneEqYsNNxj7w+Gsc=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oCtgffgWhm2t801LBw6TNC2EZTyu26jFrcslu6LfSUXolb+SuhMJBN5iMqdeeSeVfcJpXDgxmpiCi5pWUT/rOKrQ3cDfh7FW5yLe0VrBaS8CtWe4N6gUAKnNzLE9Lws/KGis28nVoXU2e5cjaOTqoYP2jCXksf6TaTreBXeTC+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jR6ay5Kf; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715256088; x=1746792088;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ciMFhbCrt0j+WssCqAEmlKTeIXQneEqYsNNxj7w+Gsc=;
  b=jR6ay5Kfyh/68Sxp1zA/z+KwWZYIZpQpgrDsDOb9wqyvMqfuHmql+xSw
   lPc4ezA42J0PcHn6AFu2hRaTxZfvwizW3no/s50w7GeEoKMNvGfYwVTur
   eluQSzrww3zNOgegjRPrwUa7Ox6Vx1OpB8b2sKDjPCFDVqNyqxagNXK0o
   A3P5JnmkTtQWE3cFL4tmj76Od+eCBxl6iXSPD7Sj53yo7xcSORXM6SeON
   taWDsZDQLmUm+qbWnac7bLMiNOnO2MIsgvRUbsCOuUN+07ZkNo45PEUMP
   2bl0rrvV68cv0NohurUydrl/YYPhf4BS9Tpbtm3+4FK6oRgx0StLcoQk5
   w==;
X-CSE-ConnectionGUID: o/BCSFQ0Qei9Uisiwg1F+Q==
X-CSE-MsgGUID: /p/MvvAdSdGwDjEKbmUjtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21739671"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="21739671"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 05:01:27 -0700
X-CSE-ConnectionGUID: 40C5EGSbTlCBh5lrOmmveA==
X-CSE-MsgGUID: C0614FdyRfm99SpuFzRTRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="29293239"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 05:01:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 05:00:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 05:00:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 05:00:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 05:00:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxqOzGK/NrCYlTJ0BckCn3sEED5rA3PGVvfFFmILKlmbky4K1uw2Oav4oSAilMBZaQrSaI8sickbNAmyzXLMz6holD4EmGFJeMlqyKIYANqsZ6uwsjhT+L+eRauxgsRwLOpCklZPqkhiQTJXK+NvNn/rYkdiPXGi0aOsxO84+AUacrbS7pVzl4pud8czFNHPOt9tRNZHThy6OR0ruJzNoWQU63ZrzurhfJ3kbsX4EMIV1KbuWAc6Bm2LqrtoUc0MPVM3kj/F5sLfWzsLzp2og/Y5+sNRYzy7Paa06eQv3Uokg46ksu3Wcqro/SH44Bsgx7AwNX56K9NqyImxmnIbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IKBjkJG8l3nXmCCaApA9waI/vAT+pLV51ulxf1L9+g=;
 b=IGMiEIl1I+GRu21jIIK9GBeR2JKVHMwcvoMA6W5VbpJAMZmYYk9T5PQK/jBW/k6DBXp//a0fMYrgmybXMEh4EZYIGTsgz7M54ny7xNi5AclrpvfFWjInoVbGAnbD4LB5eAi1+cHGPj3SYebwxGSq6WEHDIuLuySKszFMaDz8WakfxObt210pWvPB1TJoTAl+Y/BFYFk8wGk3d9ed0vwhoDtB64+ivZcYoKMSElkkpHaWdxh8nCtYkF3dWUqr2AsskDJ02trYR+Eco9MFOUSQPjL6q6Hmcyy3d0hPTgwazQ4AsdiZYmyDt6Y3/c9aUotnTC8+MDzw7UIdC5TYKlXwNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB4917.namprd11.prod.outlook.com (2603:10b6:510:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 12:00:14 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 12:00:14 +0000
Message-ID: <3dce41a3-e5a9-43e7-b918-ecb8d688ea1c@intel.com>
Date: Thu, 9 May 2024 13:59:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] dma: avoid redundant calls for sync operations
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig
	<hch@lst.de>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240507112026.1803778-1-aleksander.lobakin@intel.com>
 <CGME20240507112115eucas1p117bc01652d4cdbe810de841830227f47@eucas1p1.samsung.com>
 <20240507112026.1803778-3-aleksander.lobakin@intel.com>
 <46160534-5003-4809-a408-6b3a3f4921e9@samsung.com>
 <b4632761-3ec6-4070-a60e-b74c1bfdd579@intel.com>
Content-Language: en-US
In-Reply-To: <b4632761-3ec6-4070-a60e-b74c1bfdd579@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0018.eurprd08.prod.outlook.com (2603:10a6:8::31)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8ab2f7-0d32-4938-5970-08dc701f963f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dExrQWdRS3lHRDZlM1pTVzFwbCtqTjRvV01GTER3VGRzd09TLzVoYjducWdW?=
 =?utf-8?B?MnQ5RFJHVERBdVM0QW4wY2tUbWl0T3BIa0NmcnhkWWx6UjYwUTZCYUFFeEsw?=
 =?utf-8?B?NnFxLzFzL2hkeG1KRGZiclpGTlJhS0F6ZTIxSEVQalFMWmQrOHZWVXFrSUlm?=
 =?utf-8?B?TFpCbzN3cE8xc0VmVFlkMGc5dWk0R1psRDRKdTZ4SXNNVjZDVWp3NUdjaHVj?=
 =?utf-8?B?MmtnT3pqait4UElBeU5yNEwxK0ZDNXBLV2J4bjc1dmRzUHpiRjh6LzgyeG9E?=
 =?utf-8?B?dzRzektUVGlOUE5BUzAwVlQ4a1R5SGVXb3g3S0ZYMVdLc2hLakhzVHV4WkdY?=
 =?utf-8?B?NUNRV3ZrNEtqdlVrZDBPdFNDSmg2OUpYRktmVHVjNTkrT2UzelhpOGFhbEhM?=
 =?utf-8?B?Q3c3aVNoTE1FSWl5MFI2OW00aHFhWmUraHhYZ3B0NlhnVVBVdmtFaFhOOVE4?=
 =?utf-8?B?Y3Q1UE5JRTR4NVB0V0xrdFFRc1k2TkNNT1AwZnQ2dUgxaFdmYzY0bWMzc0JZ?=
 =?utf-8?B?Z2FHL1lVVkxrbzhTaThxaDNzM3JlSThsYTBnaEZtS3djVUdNd0hyOGQ5YUFB?=
 =?utf-8?B?UnF3dzJUWklBZWJUcHhmOHVqaU1FUytySGZxVkYvUDRwbkNiU2lPbGh5cE91?=
 =?utf-8?B?TWs3UEtsSUhDb0Q5Qy81TVlkWjd5ZU51ZG5XSEVMMWJxS05HeGV6L0YvQU9p?=
 =?utf-8?B?bEZIcm5VdVpnWUIyYWJCQ0Q3eTk3WWJuV1hxT1REcDJyZG5LNjdXdmZRYTFS?=
 =?utf-8?B?REEvdnFFNkMyc2o5ZlRWNkk0U3lGaXI2aXFjVEk5d2djZnQ3dkVyY0FGNC9w?=
 =?utf-8?B?T2tuY0xVNk5jQ2tGUmRQRXV4cjJHbml5MFdTd3I0cktxWFpWU0s0aFhST08w?=
 =?utf-8?B?ZFhXSm4rdUQySmRuU2ExaFAzRFQ2b29MOW51SzVVV1pYL3NiRzVTT1NzUjB1?=
 =?utf-8?B?ZXVDQW91ODM2VXZMbmJzY2tQVTg3UGFZME4wai84cUZWY2VQUEF3SUQ0ZEQ5?=
 =?utf-8?B?MHRvbFdDUEpqN3lJYmIvNURkWGZ6LzdReVVNOEw2bjdJSCs2NDFjb1loL3c3?=
 =?utf-8?B?RDlUWHp2c1RvSVEzN2FBOXd2VWR6RUl4RG8ybDFuUXJibU1kSm9xbE12TXJE?=
 =?utf-8?B?dU1JSXJGN1FpU05kSEl6L3V4OCtkNnVCcjZObEVMcE0yaUhoNFNHTWRmdjJk?=
 =?utf-8?B?bkJlZFRtRnhxbHdLUytUOExrdTZwVmN3OGFXeGhLekxnWk41czZtMytBNWVa?=
 =?utf-8?B?RkdvOW1qbFZCYTlBaTRVbkd5d3ZBRkkxRDlKc3NORFFqbDB6S3RBb1RJYXo2?=
 =?utf-8?B?TnBKenR0Q2s4aEQ2a2FPM09DYS91b2ZpbHRQclVkaFppWFN1RGJWQmgvbUdy?=
 =?utf-8?B?MXljZVB4SGxSRjlFbnhMYkhCZXJQb1VDMUZiQ09JNGpFbWFpYmtmaFA5YVls?=
 =?utf-8?B?UEVhYW5teXJjdklwRkp5c2dOSnJUQzZ6V0RxNEZYR01vK3puSTRERU1HVk4v?=
 =?utf-8?B?N0h5a1pzSFlYNFg2Z0RFWER5b0ZLVnZJcy9UL3RTTU55bkZlenVFZjk0YXdz?=
 =?utf-8?B?bFJnNW1ZVkxqcWRZZUVEaDNRc2UzOUExTnBuMytBWk1OMWFXTDF0UDNmVDFK?=
 =?utf-8?B?MFFwY3lya3I1NzBzQU41WDBjTXRRSXIxL0lzbG5qa1M2V2pINmVjdERHRjNk?=
 =?utf-8?B?QXFYc3hJeVppL2NlZ1EzZjlGVk84VENYVXRDMEpCMllJRlhRcGRyNzN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2RkNkJVbUlNcTFNUjZETS9oQ3gzMDBvTm1hRVpISXZjQlJDUmd0YTJNemY4?=
 =?utf-8?B?NnhPWTBvQ3J4WGMwMVYvUkduMlpHTlh0ODRReDdDampSYjNrUkk0dWlnaFBS?=
 =?utf-8?B?eDFsSHVXZ0V3SSt5bHBybTdGNjFrNG1PNXdlZWQrY3pZOGg4OFJDZnBocWt5?=
 =?utf-8?B?UXFMbE1CdW9CWGR2eHV4R3JINmczdkpFUnlTMUMvSW9YUHV3OTFwRVlDQ0FI?=
 =?utf-8?B?Um4yRS9XQzhXY0xPODE0WkIvT0JWVjBHdkZ2QW9BQ1hIUDR4eHBFMHE1Y3VB?=
 =?utf-8?B?NHYrTFo3aVFudUx6cWlwd2xicjdzQ1dnTi9pWitrbDVCVUt0UjJBRHNxSDhh?=
 =?utf-8?B?OFFteFdPMlRZeGMzc3lJdXM4WVo4YktYTnhaS1JtRGF3S2xZbzU1L2pFUDJz?=
 =?utf-8?B?SWFvczBFL2N5b25CeEhGUUtxU3NyVUwzSitoRWp6QVkzWk95VE81OG9hTlhI?=
 =?utf-8?B?VTM5aWk2cW9JMUhhRmN5UVpXZHluZXV3eEQ5Slo0Qm9wTnUvc1pFVFNibjBR?=
 =?utf-8?B?YVJSdEIxK3VtV1NYcWp6Wkd5Q21LSHJ6NzZzckJQVkFHYXBVY1h0U0ZRUUpt?=
 =?utf-8?B?elRpTzVwb3FybGF6Q1F4M3lPK2NKMWpEKzJROEZGNEdGQ0JRd3RaUE5jMEhh?=
 =?utf-8?B?YUNoeE54QWlhREpvK2t1SmxBeXdGVEFaOVFEZ1VxekhMa2tyUjRON0EzUXlJ?=
 =?utf-8?B?b1hSUStiQ1pvMHQ0ZXlETzdOTXpuT0pjdmIxZDVSVEJsNjA4azZZcDlvL0dn?=
 =?utf-8?B?cEtFOEw3K3YvaWo3c3dvNE1IbUxTbzZtNXJzdjF2NXZBMWM2elhUbTZiaHll?=
 =?utf-8?B?b1kwTGRwb0FTYlRIc3pYbTdGZnV5YzZUc0ZKMVgvMzRxT0ZIbW96U0xiTEF1?=
 =?utf-8?B?UGdjUXVGMG5uZEt6MXFzYlNYMjN2RFYzelpNZGJIUGNKVFY2SXgwbXZxc1VM?=
 =?utf-8?B?SFBBUkJhSVpoVUtVaThXWG9XNFlKUjFsek9oTmZoQmRBQlp6NEtHOWJ5eUtp?=
 =?utf-8?B?UDh3djBrMWV5b25aZCtEYWtlWWJxZnFUWG93VVJXSnh2MmwwMmVKSlRMaTky?=
 =?utf-8?B?NU5MQ2UvZTAzVVoxRU95UG1ueUFVMldtZmR1Yy8wdUtNck5IbmpYMTZKZHdp?=
 =?utf-8?B?ZWNkYndtenhFZGxFOHlleHFTTFVJcitzeFFpcHJjUWhIR3ZSa08zNnVOb1J4?=
 =?utf-8?B?bFdkN2YrcyszaHRtU3o1NzlpV2hMVXVJcDNucXRlTXM2RkZMdnRVRWp1VzRi?=
 =?utf-8?B?cmUvNVFMczBaaHB2OERHdW5mRGVZMmtrRFg5QVI3VFZ3MmloSmVvaUIxQWdN?=
 =?utf-8?B?SVFBTHhBNWw5L1JUc3dTTlNBSVR5ekpuYXNBbUxQcGJtQUpTd1V3cVlQNTA1?=
 =?utf-8?B?YlR3T0xVS3BIbHA0MklWbDM2ek9DYkVBS3VBTFdXL0pWclJxQ0ZLdjFxZUhF?=
 =?utf-8?B?S1h3dUhibldtTmN5cndGTC9HbkgxZnllc3dRTzFWcytNVGFJVEpWY2hSTlRD?=
 =?utf-8?B?REpISTM4RXo3QUlNaHo2Q2V2UFRjMTIwUy8vRDZsVHFmOHFZT2dvbVNMd1FX?=
 =?utf-8?B?UjJvWitJTkpod2l3S0liYzdDc1pkaWdGSFNZTTVENE5VZ3BaY1NPMmc0TXdS?=
 =?utf-8?B?RTJZb1p6cHFXL1NTcHpCWUw5bFRtaUllT3IzSjNOTkhPazNjTnZZaFlxSnBN?=
 =?utf-8?B?Z2NHZ1l1dGd5OUg3SSs2eXVORlFTOXJsYjZOUm9manUxVlU2V2lBeU50MHZ6?=
 =?utf-8?B?L205eWFZWlFYQnloc3lJQ1UrQVlKWDAybE1adVFmKzYwMVpObThhUXRvQlNH?=
 =?utf-8?B?QXord0NRQi8rd2Y5eXppeVcwTHNMb0RrQ1Q5cWY1MlFXZ0NTL05FYVdVVVVi?=
 =?utf-8?B?Y3JJbDVDNDFxS0JFQStaWTlud2Q5SitCamMrWUlHK1hpVXUrZE56Z3JHeVVo?=
 =?utf-8?B?YytqZ3o2b2NZMlYzNFdQc2JNbm9adzJnc3F6QVgrOEFnUG9CbmVXOWR6ZWEz?=
 =?utf-8?B?ekRpbWJpUE84NWVhMjRKZHZZOHlROXFOQVNzRC9qYncvT0NsQWFIWWp6RzhT?=
 =?utf-8?B?SmR4aTB3ZnYrTzVCU1JDS3pyMldkYjJCVUw5QUtEZ3hneHdaZFNPa3A2b3Rq?=
 =?utf-8?B?am40Vm0xVG9SbDV0djRoTEFsSFRja2ljcWRpNnUwU01kcTByZlk2NnVycXJ2?=
 =?utf-8?Q?nrZWdy/NFiqIsRBXWEhYB2o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8ab2f7-0d32-4938-5970-08dc701f963f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 12:00:14.8262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rp2SjCauwSVjT7+jiX3xVtWivn8rxc8DzY8shb5mXt7Y0US1KYl+kY15g5Tc2zBLHZJz0B5FuOQbi/gbyZNKPj0ZrDLoNREY2CeodTV4Qsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Thu, 9 May 2024 13:44:37 +0200

> From: Marek Szyprowski <m.szyprowski@samsung.com>
> Date: Thu, 9 May 2024 13:41:16 +0200
> 
>> Dear All,
>>
>> On 07.05.2024 13:20, Alexander Lobakin wrote:
>>> Quite often, devices do not need dma_sync operations on x86_64 at least.
>>> Indeed, when dev_is_dma_coherent(dev) is true and
>>> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
>>> and friends do nothing.
>>>
>>> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
>>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
>>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
>>>
>>> Add dev->need_dma_sync boolean and turn it off during the device
>>> initialization (dma_set_mask()) depending on the setup:
>>> dev_is_dma_coherent() for the direct DMA, !(sync_single_for_device ||
>>> sync_single_for_cpu) or the new dma_map_ops flag, %DMA_F_CAN_SKIP_SYNC,
>>> advertised for non-NULL DMA ops.
>>> Then later, if/when swiotlb is used for the first time, the flag
>>> is reset back to on, from swiotlb_tbl_map_single().
>>>
>>> On iavf, the UDP trafficgen with XDP_DROP in skb mode test shows
>>> +3-5% increase for direct DMA.
>>>
>>> Suggested-by: Christoph Hellwig <hch@lst.de> # direct DMA shortcut
>>> Co-developed-by: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> ---
>>>   include/linux/device.h      |  4 +++
>>>   include/linux/dma-map-ops.h | 12 ++++++++
>>>   include/linux/dma-mapping.h | 53 +++++++++++++++++++++++++++++++----
>>>   kernel/dma/mapping.c        | 55 +++++++++++++++++++++++++++++--------
>>>   kernel/dma/swiotlb.c        |  6 ++++
>>>   5 files changed, 113 insertions(+), 17 deletions(-)
>>
>>
>> This patch landed in today's linux-next as commit f406c8e4b770 ("dma: 
>> avoid redundant calls for sync operations"). Unfortunately I found that 
>> it breaks some of the ARM 32bit boards by forcing skipping DMA sync 
>> operations on non-coherent systems. This happens because this patch 
>> hooks dma_need_sync=true initialization into set_dma_mask(), but 
>> set_dma_mask() is not called from all device drivers, especially from 
>> those which operates properly with the default 32bit dma mask (like most 
>> of the platform devices created by the OF layer).
>>
>> Frankly speaking I have no idea how this should be fixed. I expect that 
>> there are lots of broken devices after this change, because I don't 
>> remember that calling set_dma_mask() is mandatory for device drivers.
>>
>> After adding dma_set_mask(dev, DMA_BIT_MASK(32)) to the drivers relevant 
>> for my boards the issues are gone, but I'm not sure this is the right 
>> approach...
> 
> If I remember correctly, *all* device drivers which use DMA *must* call
> dma_set_*mask() on probe. That's why we added it there and didn't care.
> Alternatively, if it really breaks a lot of drivers, we can set
> dma_need_sync = true by default before the driver probing. I thought of

Or invert the flag, so that false would mean "it needs sync" and it
would be the default if dma_*mask*() wasn't called.

Chris, what do you think?

> this, but the correct approach would be to call dma_set_*mask() from the
> respective drivers.
> 
>>
>>
>>> ...
>>
>> Best regards

Thanks,
Olek

