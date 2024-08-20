Return-Path: <bpf+bounces-37653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E0958FED
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 23:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DB928613B
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 21:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00FA1C57B2;
	Tue, 20 Aug 2024 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abcXIet1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9613D189BB6;
	Tue, 20 Aug 2024 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190486; cv=fail; b=nS66or3yC+Sxn8WdcgJOBippeVPWuj/1nmiDo9hxXRXbnU1nHHoke/EnKObKmO3zKVkcAQc5TdDkccXSxQ3UKIpNa7NSU2UEEqX4gayCypMDVniktEdSObjwdjHWas7CotjpwqCBjki20PpykehB7z8/rykpEgZNSoqa9/8Q4DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190486; c=relaxed/simple;
	bh=mFLHHCvCYPdh/5pGuu8hv5IPz2nSdDPBGE2w5NZvdvA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GlM0yKO4rDZ9Ki8MJegIgB3iRergDwtMm6ScA0XiMxADqkDIO2a8jx7wIu7cnO/p8V3IudAqx/ZgbqbrtUfuqm0vPV/xlT0BQTMrPnSEhePfqlxt0izD0JdvPEcvF29vIHl2YEXelpeWdIomKAXUoe3PhZeMSPuT28kVO2rzNIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abcXIet1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724190485; x=1755726485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mFLHHCvCYPdh/5pGuu8hv5IPz2nSdDPBGE2w5NZvdvA=;
  b=abcXIet1aaRR79VYF3w5LvcTocImXPVt3cwn+1nKCRqDv94zY3Y4juqL
   yF/Q8RtOW2hUhaCZzb02BxFMnTgEeyUqnyQ6w/EdzNkFct5k1mmELHhMe
   3mIbFkj7djo3BBhZxp0HeN6fNYxGeFJh02ctuZhBNP/HAfTWcuVRpFQiM
   ImCQ7Jk/OpptkQo6Ps0Yiw156lwv/mOGeKlNBcfuxrhrDuhVG5AJsh3Nb
   TARasCLLkfpoIzyO458qoHeCMJNUcOtx6YpiksWZQGxfmLbs57PSZix6Z
   aRcu6rKUYjHLl4XlXX5Ff5pOduz5PX4Ezm/akJsHbzjSXg6XpyEdOKPhP
   Q==;
X-CSE-ConnectionGUID: M2pnl9BfTsOkYnUDEm/Ouw==
X-CSE-MsgGUID: yn+6HWSjTpWeuCQP6jPg8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22053015"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22053015"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:48:04 -0700
X-CSE-ConnectionGUID: u2Lyl5/STDmWl0HbrfF5Aw==
X-CSE-MsgGUID: msTUTH+1TySL902mD6MYVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60574429"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 14:48:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 14:48:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 14:48:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 14:48:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Opxs/Z17DKOnu/4Q0mQuV4wwENSsvvYBArT/RYiSSBy1sYz8DIEf5+wxH+4JxJUouYWLs5midJ4amecyIl7ogr/9nbfahqTHrWf1uiEWcc5+bKsoIWoxbDIGV/jLyaRYUCMC0xA0g23RyFfQaxxIa7FCOwYsRoyyemj2oJiozdArapxnpKTlndAchWjkKJiploec4SEmWKOMJyVw8kezaNCadiW3I4hL2fH9hB4NhvzrV49y/ClBGj1Os5wpfTQuWT90kRrqPeNj7b126ScSAqzNIOp6njihfY+wyJzzRcnPuflRpCVYKdwuO+or+XsI0N6vjvM2We2KxHkQ3eeb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/zisJJ4KPnY4JEQI6f4k3oyHAWKZB/F3iyUnMz/tOg=;
 b=rMhrpl1Ku5LddGsMStJ5BnEcl8tCJgfByvrjrZ589UDfwL6hdGLYpisyXVfi3lBfm4e/7L9YuBjry/TfftGN+LEHQqqvj1QvVWFYah4TgFYhE/2sGKoyJp7Za6xC2aYp5NS7D/rdJ7VSGAEUJpEGWhOM0xcdG3RCKJEwXUCmRlikHnX0X5swbo/oVmnx29m+e6Vy4OILrEA29mHQPTGs1EOtYFqYWUwr/b5vEkaBMdd4c/ycNwo86ZX3Yyw3z8g0fy8JRVTzb0zz5snv9mY69V4YkoydcZSCCbsg5ALVLucmjZrZtGEbV/uevAJiL7KUJa/BG0pOzDuRXyDJJXeTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5258.namprd11.prod.outlook.com (2603:10b6:408:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 21:48:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 21:48:00 +0000
Message-ID: <22766b4f-88e6-46d1-ae02-0f0911385911@intel.com>
Date: Tue, 20 Aug 2024 14:47:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnxt_en: Fix double DMA unmapping for XDP_REDIRECT
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bpf@vger.kernel.org>, <hawk@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
	"Somnath Kotur" <somnath.kotur@broadcom.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Kalesh AP
	<kalesh-anakkur.purayil@broadcom.com>
References: <20240820203415.168178-1-michael.chan@broadcom.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240820203415.168178-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:303:b5::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: 2102f499-898a-4e1c-71b4-08dcc161c309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cStUbi9QdGEvNUVVd1VCcUxkZXI1T0RFNjBrK1poMjU4QUp4bHBORWcxbUUy?=
 =?utf-8?B?OVJ4Wmc2L2RNekxsZDgyczcyY0tFT0xHUzJjWkpvakVDOVNRUjJBR0RJeWhk?=
 =?utf-8?B?SGhneXB4b1ZCZjl3bVRGL25wN3VjR3Q3RitIUnBwcWhkUU5MQVpqMjlHREhH?=
 =?utf-8?B?NzJCRmJRQ0UwdnNjV1ZjckJQM0VNZjNDYVBuWW1SVy9qRHVMQVVxaTE1Yjgw?=
 =?utf-8?B?UlFhYnpjazdQZGFRVXlpQjJxMVh5TWxaZHlIekQySGZOSGlqS2EvL2wvbmIz?=
 =?utf-8?B?ZnNPUVMwTUNTaWpaeXk0NmdDa0xnOFMvVUh6ZzBKOGsrSndjM1JVcmtKMFN6?=
 =?utf-8?B?K1poaGVrVktUNVlGNWRMdjArVTJISFowcmFLWmNkZWc4dERCbG11OVZLVk1k?=
 =?utf-8?B?alErMU5yditRZFIvYmtia2J4c2J6bDJ5UXZtOWxnVVN3czE0eDRPUnl0Z003?=
 =?utf-8?B?WHBJbFo1QjR3WnN3L2RyckRuNnFUMnFlaDBESkQ2Z3lDa240V0poZVltbmFy?=
 =?utf-8?B?WGRCYk1vb21DcVVnZmdvTlV6YnZMcUVnRVB4SHYzKzUxdEgrelA5Z25CWWF5?=
 =?utf-8?B?cHZMQjVXZ0JUMkdYaGNsMkxVNXMrQ0ppby9FYTBuN085M0hjS0xSd1RYcTA3?=
 =?utf-8?B?N2FIQWJ4c2tuZkRocHNKSzZrM1Rvc0dsTGpWYzdSM3IyNkQrYVFYV0VzaTV6?=
 =?utf-8?B?WURQbzF2SHJBbGEyaUZ1SnFPRSsrV3kwQTVMclF5TSs3eTVXLzdTbEEva1NS?=
 =?utf-8?B?ZHloWDJobWxlTnVqZ0VZdnZaQnJQekc3dE9rVThreGh1M1FBV1FPN3lKbHhD?=
 =?utf-8?B?b1RxamlkM0RDS0k3Q3g3RFFHa0ZHNTBaN09rWGVCWWZnOW96TTNLcVBIOGpC?=
 =?utf-8?B?UlRpcTIxV2hDcE1PbmlySExSaVRwZDVVMHllWDhCYllpSVVZaWhrenFRSGd0?=
 =?utf-8?B?UG1ab2tmbmE2M2FlT0RCSDMzbS8zNVVmQWtOWjFHSW1OTWFad1BHVWxLdEcr?=
 =?utf-8?B?NXY3SWI1RWtjUnFCell6cTBpQ1pMUjRTZ0FrU2VYeG9mcVFJaFAySjd0TEFt?=
 =?utf-8?B?Q3NvY2pHTW4waGhhbTNNdTJTdm1JTG5WelVLVUFIdkpFMkp4OGV2MnlBc2Nn?=
 =?utf-8?B?MTdkSkxabzRJb2Q0UFJBUnpFTXBYS2E2UU12L01LMlREOHNqR3RKdWM3ZjFo?=
 =?utf-8?B?ZHIxOXhLSzFzWEFXZWxTcGE1dTdxTk4yV25TTVF3U243RjIrcStMSDhrVkJ2?=
 =?utf-8?B?MnNmclV4ZllVMlJrK1BpVjBjRzEzYjZ5QTY1RFRiUVB5VUNXNVltbTBsS0ls?=
 =?utf-8?B?N1RhTmxMczdjU0lPTy9JZlA5dW1ZZjNnM3NYbStqb2MwbzdIWjdpZW5ETkVm?=
 =?utf-8?B?ZnNGM2hidWtsSmMwc1Rrbk8xOTlrRGx1ZzZQaFMwaFMwMWgzYzNMc1dMTnJ4?=
 =?utf-8?B?OW5hL2J1bkpqV0ZmMm43VlREelAvOVVJVHMwZ3BVZDRjWDFpVDQyVHRnMm1u?=
 =?utf-8?B?emVtdXRjOUdBN24wL0V5OFFKYVdQYmtzbEYzQTR2NDlxSHBYaklkUno4aVZa?=
 =?utf-8?B?NEpoRElGbllOVUM4QzdCallKUytJYlJaaDNOeVFId1B1UFJBdVJ0Sllwa3ky?=
 =?utf-8?B?cE5uVy9VRHhJanJwMXpmWlRxS3VPeVhubU5vMVFYd21vODkyVmNjRjVoUUlG?=
 =?utf-8?B?T2VlZ3p2K3Jkb3hkeDhvT1Jtd3NBSWRzdG5MZEJ3QjdWd0JxWTdVK2lJTmFw?=
 =?utf-8?B?YVNXb2Fya2psYXl3eXRHNGxDeVNxOWFxMVRzZlVBNGszU2dWbnJZVHBycjZD?=
 =?utf-8?B?eFJYTVFQeG0vMG9xbVhtdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hzNXgwQWsyZmx1cVRWa2dkdDRMc2x4Vmt0dWFrK1p3Y092TnNRZ1ZoSENP?=
 =?utf-8?B?bEtNNDE0SXYzSktCdmVueFR4ZFhvYTdYWXBUZHdVUjhVREF5MnB5MEdDcDRJ?=
 =?utf-8?B?YjdqNlFWQXVIemwyeHlFazMwWkU5aUJDSTEvTkpDMGtqYm9WWmdQb25hYUw2?=
 =?utf-8?B?Q0ZzMENZU2VHN1U5SDJWcXZtQVNUN3Vlb2d5cm00RjJhZlpQak0rei9nazl1?=
 =?utf-8?B?RE1WbVFTdjgrdFdZbzdHQnJpYXJwWWlOLzJlRU9XcjZWWkVOQzFadTJSR1pM?=
 =?utf-8?B?eXFXelh4TUw4S0xGbjRodElmM1RSMTIwZWV4RUxuclc2K2x6UFltMTVrbDZP?=
 =?utf-8?B?TnJqUGYvK3VJc2dZbTNHRkZqaE01RjBPRm12Si95VjhTSjBmemM2aTVTOUNR?=
 =?utf-8?B?RU1PUEptdUhJNm9YTm82bjlubzJjTHBUbXdHTG5vUlpvRUE4Q3pNRmJaSDJZ?=
 =?utf-8?B?a3dZSytaZm80MHBaeXptVGt6c0RwZlNFL0UxclFWZnBpcXN6SzM2ZjZVa3FS?=
 =?utf-8?B?azJ1Mi9CWlhCZGdNQWdKdGFOQk1LUEhzMmlQcDQ1aWpDK3VwWkZrc1BlZVg3?=
 =?utf-8?B?bWFwc3lHU2FpcklIb09sZUdiVnppMWtxQ2FFSXc2Mmh3UVRyOWs2TFo3Znpz?=
 =?utf-8?B?b3AzRE5lS0htSE5IbE9sMnAvWmRhRzlEQXAxLzB0WVBBTGM5QmduMDNNalVx?=
 =?utf-8?B?azFTK3crNWlhRWtYdzBwbnBYWUZobEd1dDJJYnNtUy9idEVHcDdQZFVCdVdK?=
 =?utf-8?B?dXZNcWVYd0I4YTNJS3NraXZsek9pK1pTTXZXNG9SaVU3V29mSTVIWEErYVI4?=
 =?utf-8?B?b3JKQVlNaHBMZlA2MS9MTjNGYk5uNG9DMm1KUFdhRDlidU05MVZ2ZExEM2V2?=
 =?utf-8?B?bmdPU0dxeThmRzNIWERHUVlXSkdsNEsyQUwyd1BvUEpnTnhmNUlEWnlRekkz?=
 =?utf-8?B?RE9manNnY3J5Q08zN211b0lxQ3U3c0R2Y2ZLMEZUZWNVSktxY0pqbzhKQVpa?=
 =?utf-8?B?MUFweWU3QnNTZFBWK0UwRkE0SWgrY0cyK29sbWEzU0x3bk5acnFtSjM3YkU2?=
 =?utf-8?B?ejk5c1hNZGZyU0IrNElCNmpmbk5UMkhVdFJCOExBQ1NWaHNHTytaNE9GcFJO?=
 =?utf-8?B?d3VNcGFJVVl1dXQvcUJhMFJJQlFDQy9vUVEwT1dDazEwTUxYUnAzdU50ZHFr?=
 =?utf-8?B?RWZLdllUWmI0ZEQzVVBuYTNZeU8zWGpWbTZtOW9ncGdWeVc5YUpSQzY2eXNM?=
 =?utf-8?B?OHVSYWIwb1JlcjNhSFplbHVIUUl6UDJ3TXFETy9OVnZ4cVFacEdaMWNzQVFJ?=
 =?utf-8?B?QXdqSmQrNXhKekFtRmJYNmhiR3BtcVQyeUZmdmpxMWF5VjM1TjloRGVzeFFi?=
 =?utf-8?B?QlpTVk83ZmtxdUpKclJFckVROXJhL0FwVEtZcUVTQkhrbzF3RmIyQ2NYaUk5?=
 =?utf-8?B?SFhzRmtoNGs3cTVrTU4yeHVBbXlDZm82YkRlQWRNS094ajU3ZE1mTEs5amJ6?=
 =?utf-8?B?TkFzQUlkMWxrcm81eUU0dEIydWNVWHJUbWlrRE1COXVISFR5SXU3NG1TUWtY?=
 =?utf-8?B?dEoyUjBhaHVCWVBKVUlQcDE0VkJzU1FVYW4xTXkvRDZreFh0STJFTFlmZFhE?=
 =?utf-8?B?SUQ2aEhLVHd4WWxpVFdwaStzWElTdk0yMXFQQ1RoU3lRYnFQMDAvWjVoUm0y?=
 =?utf-8?B?Mi9CWDhUeEdUQTJHc1ZBZTNIUDNTRUFETGI2QUY2MmdzbkN5eW9NellKMjU1?=
 =?utf-8?B?ek5QVEtXeDNpWU9VNjZVdHozNyt2T2VjYkJzUnI0VE9UeUR3MVgrR1p1QW5p?=
 =?utf-8?B?dmZoOTl2NTVuL2ZOTjRXSDZDeUtnTEoxNWZxb3M4bXVySjcrOFZGa0xIWldq?=
 =?utf-8?B?b2U1aXo3MjRvd1E5SjJXT0ExZGhFK0lyV2J5ckhOaWw3bWtyQ3JEVUtEWHlB?=
 =?utf-8?B?cU40L3NUTFlIcmlPcG84bG9WZ0d4YU9CSUZwc08zRjVvbE9SWG5JNXpzTzlp?=
 =?utf-8?B?dFBNVWZyZHBISXNNMElFKzN2ZDRFTFVMTWNYS1M1K0tpMXozVUVSWmtwaCsz?=
 =?utf-8?B?bWFGeERHQmZyT1NqTFJyN0VyWFI5SGVqdlZsVTZLNlQ3OGZQMW5PYlFNbERj?=
 =?utf-8?B?YVNsZ1FRMThkclM3bjN2OUhnR2NMenhpUlNXcHBub3hTZjhyMjJXQTRFcUdC?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2102f499-898a-4e1c-71b4-08dcc161c309
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 21:48:00.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZ3UvbaraIwj19ELqYNJCRMsfcf/kTIhc6muJwcnOGw8mkUsjPJOjaDiixph070X+JA7ZDAlstq0405JJl0njHVahQexvVfw9t97EhZ6GD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5258
X-OriginatorOrg: intel.com



On 8/20/2024 1:34 PM, Michael Chan wrote:
> From: Somnath Kotur <somnath.kotur@broadcom.com>
> 
> Remove the dma_unmap_page_attrs() call in the driver's XDP_REDIRECT
> code path.  This should have been removed when we let the page pool
> handle the DMA mapping.  This bug causes the warning:
> 
> WARNING: CPU: 7 PID: 59 at drivers/iommu/dma-iommu.c:1198 iommu_dma_unmap_page+0xd5/0x100
> CPU: 7 PID: 59 Comm: ksoftirqd/7 Tainted: G        W          6.8.0-1010-gcp #11-Ubuntu
> Hardware name: Dell Inc. PowerEdge R7525/0PYVT1, BIOS 2.15.2 04/02/2024
> RIP: 0010:iommu_dma_unmap_page+0xd5/0x100
> Code: 89 ee 48 89 df e8 cb f2 69 ff 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 e9 ab 17 71 00 <0f> 0b 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2 31 c9
> RSP: 0018:ffffab1fc0597a48 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff99ff838280c8 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffab1fc0597a78 R08: 0000000000000002 R09: ffffab1fc0597c1c
> R10: ffffab1fc0597cd3 R11: ffff99ffe375acd8 R12: 00000000e65b9000
> R13: 0000000000000050 R14: 0000000000001000 R15: 0000000000000002
> FS:  0000000000000000(0000) GS:ffff9a06efb80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000565c34c37210 CR3: 00000005c7e3e000 CR4: 0000000000350ef0
> ? show_regs+0x6d/0x80
> ? __warn+0x89/0x150
> ? iommu_dma_unmap_page+0xd5/0x100
> ? report_bug+0x16a/0x190
> ? handle_bug+0x51/0xa0
> ? exc_invalid_op+0x18/0x80
> ? iommu_dma_unmap_page+0xd5/0x100
> ? iommu_dma_unmap_page+0x35/0x100
> dma_unmap_page_attrs+0x55/0x220
> ? bpf_prog_4d7e87c0d30db711_xdp_dispatcher+0x64/0x9f
> bnxt_rx_xdp+0x237/0x520 [bnxt_en]
> bnxt_rx_pkt+0x640/0xdd0 [bnxt_en]
> __bnxt_poll_work+0x1a1/0x3d0 [bnxt_en]
> bnxt_poll+0xaa/0x1e0 [bnxt_en]
> __napi_poll+0x33/0x1e0
> net_rx_action+0x18a/0x2f0
> 
> Fixes: 578fcfd26e2a ("bnxt_en: Let the page pool manage the DMA mapping")
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

