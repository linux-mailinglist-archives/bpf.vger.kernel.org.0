Return-Path: <bpf+bounces-27655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E38B04FA
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 10:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0201F24559
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AAD158A3C;
	Wed, 24 Apr 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMRaYna4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE32157489;
	Wed, 24 Apr 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948779; cv=fail; b=ZWklTppENWi9Vp8w67O1OXSNaNJqgX9haEodnGALn+LbnRyL9VA6EIFTq6e9in3MYynLparuBuZrtUIFjZQAZqTP0ie0cVGjw1XAW49GSx85hzcbz18UHZm9bRLMdHYjbOs18OsHjVtcBpNbB5+xOO9SM10z102gP0Y66/Z36qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948779; c=relaxed/simple;
	bh=C+Vy4YfQAtVg9uH56ArWlS9iy7lkeJ1S9+1NGuZwgWM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jgU/UY9cjlooSdH3g85qRLuSehH+65fjX3po25MKRhHmWbOM2NPXhSP7lIQIglBU9RFmVS34/x9JK8bO4Cgvdt1UNoR1V+NM40gShjNPCfqtnG63YafvZOD1npEBPKRYA+pNBGDM+n6yBg47PHaojdXdp51g9fTZuLHxv4728IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMRaYna4; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713948779; x=1745484779;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C+Vy4YfQAtVg9uH56ArWlS9iy7lkeJ1S9+1NGuZwgWM=;
  b=iMRaYna4l8sBhoVyZkXvGaUKdNGv+hYZHlgkMupaWe/XuVY5rSHvqZUn
   sQOagwB5SWRPe4GyKsCwHay7tHM1/EZGVjoizEt0H3OwXbaJuL1KfQnwU
   s9g8gT0dZYIuFC1HJNJJJdWYWhKwjw6UDGmOoBvTPb45n3rOrNBGiAxq1
   urwjPhL7iSOnRXFG7VEZa7N4koQBlYE1+6dBwAmafUObnEHvAKR+OJSVQ
   nS5Sncaw8pk41xivVSW7c1UxZLTlSGZQ6D9DTKmqTjY0vKzjEI1usOQjV
   NGdqKJQfW0UuTw2SIa60N5FNv8qLa/E2GdggpK4zQyCEoilfwOU8u8PcZ
   A==;
X-CSE-ConnectionGUID: POFn9qr2Q5i+rqG2W98QUg==
X-CSE-MsgGUID: jEJe06XOQlCDz/O77ZktWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9731884"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9731884"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 01:52:58 -0700
X-CSE-ConnectionGUID: wG0F30RPQ02f17q7EX95oQ==
X-CSE-MsgGUID: LkyH/iBXSa2kHq3rOt+HxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24612625"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 01:52:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 01:52:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 01:52:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 01:52:56 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 01:52:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naAflIjurmRaiRif2yTfwuMsrn6DDaAdjuPllUTzEs/oGPC9iS+CqZWrXdJ5w1yoAg9IBPswb5VRPKaPCBz/J2F9Clkpk9O3J+mudzhrSKVFvh/WUnO2xEQkIrBRgrF6MlJ3N1aOI4s4Aqu9oC5IAbyc/AFmTOusRFcTGEXXKsRGlRve1OGJaPiZfSWUt41NWvYvqv8mIi+g2PFJz2usHDGCvXzIzOWio2R0s5YzGfdZelsVS07s0SEEuQKN4u+wEGAq3URtfOOL/0GpKoQ1xI4nqv9no4zPd43bm81QsE8ziQHF+Xyc2EvyzEUY9UxAIWEysAuLspylSkgP8XxEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubKi/BaVcblmg/jCrDCHV8TKWYXDPlyqQ8bNEoEHZXc=;
 b=GpdS7O/OKe776ZVFMRzb6rW4EgcdhUqftyqr9aKGByhU9OXGiwDXSn3lUbnkuEQHDm4I8PYnQLo8WbQaboVaHyXPclNNE89w2pUG/BCjgPDTBPNdiz7Y8hXQzcvznKQkmZkxi0PzqSx577CYBEHJTxpQY6YUsnwQhOPPDCyttKWcTExUXxaCOE5HNLgmp4ccDSQpca1JVPK9di3B/uSImkcHgysB87g2n6NzzRaOMXlM62JjRCTJ6DNDoVC9MNj1JLirFss8zT8GYAkF1v/tKA2UaM1kURHAfY99Ut04t7809JPEb/uhWme1uCyXshYU85faMNOVgiFmJnbRtH3MBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:52:54 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 08:52:54 +0000
Message-ID: <81df4e0f-07f3-40f6-8d71-ffad791ab611@intel.com>
Date: Wed, 24 Apr 2024 10:52:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/7] page_pool: check for DMA sync shortcut
 earlier
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
 <20240423135832.2271696-7-aleksander.lobakin@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240423135832.2271696-7-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0061.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV8PR11MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4ae2c0-6e65-473b-249d-08dc643bee63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm9DSk1SdmhJL05KTGd3OE1OSDRxYjJza1A3aWIwOStqS0p4bi9FZzNVbUhJ?=
 =?utf-8?B?U2R0bGk1YlBDWDhwd1g4cWFVanZCejJSSDc0UkIveVJ0ZnJjSGxndzhVVlB2?=
 =?utf-8?B?Tms1dXJ5M2lQeXdVbVBpZ1BsOEVXc0VQR2VORG9LYVlGS051bUJsd080L1BW?=
 =?utf-8?B?YVZwYjJiZENjOWhWVzQ4YlNNUHNQdHZ6T3drMlpiRmZnUHBTK1BHL3VlSkdZ?=
 =?utf-8?B?ZVptSHVwVmpFby8vUFhzQkRpcSsrcG9IeE5kN09VMUNCTW55NnZ3dzVkb0ZJ?=
 =?utf-8?B?QnZQRzZ5MmRNWVkzS3RiNVJrZCsyb0NxU2VjNjVZbEFDNW1Ib2NpOUIzSElM?=
 =?utf-8?B?eUJ3MlhQY3dZVWxWU2gwSVhuTEI4V1dxRFFZS2s5d1lub3RDM0NVZ2R6dzZF?=
 =?utf-8?B?NWNGcDVkRjJuNEs1eW9SUDI0LzlVUVFUMDJRalZISEpNTGRsUDloR3o2bHoy?=
 =?utf-8?B?WTVlM0h1Y3FETTNvdTNTNG5PaTZoOG9lOUNXK3NXYktsZllabHhZaDZIaUpn?=
 =?utf-8?B?MHgvamw1RVpYcis1bWE3bWoreWVVNzdHd1paSk9WbXJTUzJVMUJRUmV3VnF5?=
 =?utf-8?B?NWZPblVlUk1vY1ZwWDE0Z21CeEpaS25WaTJXWGY0bnYyREtPb2dobnplRFc3?=
 =?utf-8?B?ZmJUTTArSmUrZSsxUUhaWng2UDdLZzgrdXQwak04VVMvVEs4WTJvVTVWaXU0?=
 =?utf-8?B?WkFqT0l4NGsrZXAvRndNeTBRUGlrZ2N4SjNkMFUxT01VNUgyUVNuVHlTMWJv?=
 =?utf-8?B?VzFLeTJZVXg1T0FaVENIbE5WZVdwTC9XRTJMYi95VEJmaWJRWXhDNWcyOWF3?=
 =?utf-8?B?dEEzK0lYM2FtYi9NUURwMTJHUnlPZXJsT0ErSFVkUEE0RWtXb1dnR1JwNEFX?=
 =?utf-8?B?bHdSSDVvZThmYzRDNXFBTDZmZE1WNXhxM2JaWXVYUmtYRW5sSTNNYzhib0ZW?=
 =?utf-8?B?NERNMFNueWg2QTN0Z09XWnBsVlFRWkcrMThpNnRxY3V6T3RQMEx4UGdJeGd6?=
 =?utf-8?B?MlhYMXFCRzRHb0R3TWJoK3lNTkJ2YlpIYTJsZ2V5dmhHckFqcE9EWWNxZE0y?=
 =?utf-8?B?RE1pb280ZVF4Vk1vOE9nQWdWalB1cnp0MkltRFhaYkN3WTlBS1lLZ09mMjhm?=
 =?utf-8?B?NmRJY1hndE43VGlHUzFYWVVTRmEzdXcyTWFDOVRIK215RGtvYUxWekhpamhF?=
 =?utf-8?B?ZlFTQmFsYk8zdFk0NUd1QTFTTlpvZFFiRzlUZjNsMGxSTmhIcmZiL0ZEcDFV?=
 =?utf-8?B?NXVyMlc0bFpveTAvOVE0SE9TQnVocGpLM2FlVm4vNE1naEhwdUhaZUhhMngy?=
 =?utf-8?B?S2xoUFNuaHpQYVppUDFjN0Z4WGtrZlNoOElyQy9lTmg3LzVxU2ZxQlNETWgx?=
 =?utf-8?B?QklwZ1lkL3p1L1R6Wk5EbVcvZmsrcjNUeEVYOWtxUk8zbjErYUtCZlh0S1cx?=
 =?utf-8?B?VVI0c0toNDhLZkVWVlA5MG9Ob3B1NHVvUkk1bFBkYXlmbnJtaWJCWE9ybDVn?=
 =?utf-8?B?SVJUOWU4Nk5ZdXd2V0s5WS9zcjFiYzZuQ3RoazU3aEVyUUJ2VjZSdVZXR3Iz?=
 =?utf-8?B?YWJEY0ErT29pWkxERytabGU5Z3FDd3NFc294NjZnMG9LOXNrR1U2NERTdCtt?=
 =?utf-8?B?QXZRaDdIMWtKTXVRYmNIcE42MlNmajNiZjJrT1dTL1BYZTFPUnB2d252M0gx?=
 =?utf-8?B?cExnWTlRQzFoQjZaY0RkVlhSdFJBTUJWM1RwN2JnbUs5YWxIOWtlM2ZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3dUd2lOT0gxSWx1TlI2TG9pQW5uR0RVQ05BWDEzNVY2MjdidGhVbmxHcnp0?=
 =?utf-8?B?VFAzZmVBa0ViV0RWUlF6YnhCTUlrVVVLUWF5d2hQTEpQMmJxdGtPWmt2Y2g4?=
 =?utf-8?B?SjF0dU51dUwxQUZUeE40cDNDVlN3MzZoeXVxV0dQQjFiZEhoQmJWeFdGQVNq?=
 =?utf-8?B?S0I2MmtlWnRXcXlkQU1ZMlU1NGdXdHdhenBkRkI4YmZneGdSZW1aVUpIUTEx?=
 =?utf-8?B?ZzNZOEo2SUZuanBPVk41Vk9RREoxbFF3U1QrWTYvaFNGcm02SENqNVNRc01H?=
 =?utf-8?B?bUFOMm1qV3NtUnFvVlgrTnFvc1Ztc2JPY3dtS00ybVc1NVR0ekRVc2lYUzFp?=
 =?utf-8?B?bEVXVEJrTzRrcXhtNXFudnRCSndvOEx6ZkZrcjVjai9zUC8yTWZqcE1UMkg0?=
 =?utf-8?B?MUg4b2ZhTy92NS9uNWVRU25Gc1IrMkJiTTRLTTlhOXJncnRRRTVhQ3BDNFV5?=
 =?utf-8?B?ZWVqOFltNXQ3YnZNL0t0ajdvZ2JraVNVRk5rWHd0MWxvdWdlOXBwWlFXU25L?=
 =?utf-8?B?OHAvRVBxVlRFZEZRTjZlOFB0bS9lQm1aTkpoNm9RaWRMaTgzcGZDTE1XZEkz?=
 =?utf-8?B?bndpZzllL2hQZHRGZzR0ejA1cnhuVHNWS3FmNlRYSHhwN1N6SVZlOUw3Qy8v?=
 =?utf-8?B?ajQ1WkVMQmpLNzNxVGRLQk1tT045ZlJrMmhoc09pRy8wNlJLU1lRTHlYcHVU?=
 =?utf-8?B?Z2lvY09acXZrZG1aMkRiMTlXeU1tY2FMd1FjdEd1cEIwd2VvdDRzNGVaL3lZ?=
 =?utf-8?B?aUF5VEc4VnAzckVxRGJDUEYveHRRM1hhSXRwVzM3dXNQcG44bnNuY3BXdUZP?=
 =?utf-8?B?amxlRmVsZnpUbHdSeGFITUVtYjNpcUNwWktmT1RFSjRZeWdtMkhSN1JlVHJx?=
 =?utf-8?B?UU9GeFUxeDd5ZTJGK2o0cGxycWRNa0RWb0Qya2xSem93dHJmc1B5VllDcVpQ?=
 =?utf-8?B?MlBlNW4ya3dsUTFGQ2E1SXRicjBRMGw5blFpdUszbGltZjNUcmJSMjU1Tjhu?=
 =?utf-8?B?WUV2UUFvdTlaVW1IbzdTcVB3YVB2ajdtWXloQllIR2JqMFFvZktSaG4yeDh4?=
 =?utf-8?B?U1ZOcmFZRU43UUpPTWFQSU1RcDg2dkxyT2J1YmljQzVWdjJyLzRWT0NkMlZU?=
 =?utf-8?B?ZmMxaFpBNFJERnJzMzFFbkU0TEg0RGJvT3ZjUVFXRVk1SzhtS1NNa2FlTTdk?=
 =?utf-8?B?OEJTRXRIZEVqeWFVTm5EdDNyZzMzT1prR3hRVDJ2a3hxbzFwSE5UZjNVTnVR?=
 =?utf-8?B?eHgrSktTcnl5a0hvQ0tXMkNIYlU5ZmlFUGJaU3lWUGIza2czT3VEVldCOXo4?=
 =?utf-8?B?bW1ISmxnU3ZRcktSN0NyNHFSYkxQTHZBV0Z5NlZHVGdreGVPbGp3U3d2cUp2?=
 =?utf-8?B?aFVudlM2N2MxeEw3UzFqZXBVN1FvTWs5YldlTnBuVCtJSjNldUFQVzdsZkhO?=
 =?utf-8?B?NWN0SitteVhyNEtJT05jMjhzdE02VVZERDFtN0ZqbXhIYXVEcnJQbjR2cGVh?=
 =?utf-8?B?Y1dhdEJpVlp3TFRjeWVwRUkvUDJZOWFFZWZjek1pNTFSenNOcVpIVVFlZHRP?=
 =?utf-8?B?OW84Mnd6b1pFc1ljM1Y1cEd1bUI0ZTFJSE8vYkJPbXdnakcvL29nMnhva2Vs?=
 =?utf-8?B?VHRvcFl3OXlZSUZuTVR6dzE0R2hMbjBBcWI2TmRoR2hjaWhZTkNOeWVmZ3NG?=
 =?utf-8?B?VzNiQUEwMWI3UFNXSzBnNjFUMytlUWxkRStJMzJTNUdDSExiQk81blR6cXRC?=
 =?utf-8?B?SFVUeXluUVdXL1F5M2ZmaGxkdjJYbkQ5VWlaTndOaE1YcHBudldwaGVOb3Fz?=
 =?utf-8?B?UlhSdEY5eVQ0ck8rZy9WSlhzek11bWFqVkhLZ093OXVFZXRuMWFibFBYYUx2?=
 =?utf-8?B?SFJtcDl5elBReXN6UHlUK1NaYWZYYkYrR2ZwOXBpNGZBZUwrVG5ndU1UQ2cz?=
 =?utf-8?B?K0F1bitXSjFuZXdncWYvNU9sYiswWk1Ka09WTlBoVS94eTN1cDdwR0UrRVJl?=
 =?utf-8?B?SXdTRk5zNUZ0a3hybkt4TGtFUnIrUnpPVGp5SUNBNjdmandnbXJPV0VDVnJF?=
 =?utf-8?B?aXh5THJVVVJ4UXFacHY5YUxGVmhpMmMvNkphMFJTQS9HdmpRQ3pIbHY0cFE0?=
 =?utf-8?B?YVdiZVhBQ3lWZ053ZEVLQUxYK0IyWWFjZW4yenN2RWhlK3hkWHRBTmFwUVpu?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4ae2c0-6e65-473b-249d-08dc643bee63
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:54.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jI1ylxAw58YMcsrtKok7GV7YeMRmfebSlZcmQUwmFTr3V3yx2tgUwt+gpD6ENA96Ju1iGuqNwPQo7mxllmifEGwTmyQMjfmn0sfrqFH0xmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Tue, 23 Apr 2024 15:58:31 +0200

> We can save a couple more function calls in the Page Pool code if we
> check for dma_need_sync() earlier, just when we test pp->p.dma_sync.
> Move both these checks into an inline wrapper and call the PP wrapper
> over the generic DMA sync function only when both are true.
> You can't cache the result of dma_need_sync() in &page_pool, as it may
> change anytime if an SWIOTLB buffer is allocated or mapped.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  net/core/page_pool.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 6cf26a68fa91..87319c6365e0 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -398,16 +398,24 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
>  	return page;
>  }
>  
> -static void page_pool_dma_sync_for_device(const struct page_pool *pool,
> -					  const struct page *page,
> -					  unsigned int dma_sync_size)
> +static void __page_pool_dma_sync_for_device(const struct page_pool *pool,
> +					    const struct page *page,
> +					    u32 dma_sync_size)
>  {
>  	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
>  
>  	dma_sync_size = min(dma_sync_size, pool->p.max_len);
> -	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
> -					 pool->p.offset, dma_sync_size,
> -					 pool->p.dma_dir);
> +	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
> +				     dma_sync_size, pool->p.dma_dir);

Breh, this breaks builds on !DMA_NEED_SYNC systems, as this function
isn't defined there, and my CI didn't catch it in time... I'll ifdef
this in the next spin after some reviews for this one.

> +}
> +
> +static __always_inline void
> +page_pool_dma_sync_for_device(const struct page_pool *pool,
> +			      const struct page *page,
> +			      u32 dma_sync_size)
> +{
> +	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
> +		__page_pool_dma_sync_for_device(pool, page, dma_sync_size);
>  }
>  
>  static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
> @@ -429,8 +437,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
>  	if (page_pool_set_dma_addr(page, dma))
>  		goto unmap_failed;
>  
> -	if (pool->dma_sync)
> -		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
> +	page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
>  
>  	return true;
>  
> @@ -699,9 +706,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>  	if (likely(__page_pool_page_can_be_recycled(page))) {
>  		/* Read barrier done in page_ref_count / READ_ONCE */
>  
> -		if (pool->dma_sync)
> -			page_pool_dma_sync_for_device(pool, page,
> -						      dma_sync_size);
> +		page_pool_dma_sync_for_device(pool, page, dma_sync_size);
>  
>  		if (allow_direct && page_pool_recycle_in_cache(page, pool))
>  			return NULL;
> @@ -840,9 +845,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
>  		return NULL;
>  
>  	if (__page_pool_page_can_be_recycled(page)) {
> -		if (pool->dma_sync)
> -			page_pool_dma_sync_for_device(pool, page, -1);
> -
> +		page_pool_dma_sync_for_device(pool, page, -1);
>  		return page;
>  	}

Thanks,
Olek

