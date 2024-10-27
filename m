Return-Path: <bpf+bounces-43256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253D89B1CF4
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 10:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0D5281E9F
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1ED136658;
	Sun, 27 Oct 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ba/Wzdbo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC48A45948;
	Sun, 27 Oct 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730022590; cv=fail; b=Zrit5dDYbP4CZIDXBsOLjDOk3lYwDWaatRBUJdKc0+jQgFqK5OTOsJWGYLHnZ1+lLbO5YqUdv9FuOmkgr8uW/tZSDpVtEnGa3Gf/3a0jfc/r5N7l/OKLtW38r9C1ZIQmH62XtezSQqm1U+c/sH/TAxSmGJTtnmfd7GC+h5vJF7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730022590; c=relaxed/simple;
	bh=nffs2oNGSJEoaU6UdGnC7ax6B8XaR/2vPlc0yJOQkrM=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=gZtMqV1t8iyHITxWMwaMYab/JCIi1ZxGkLz52wJUUMtcp17KZysUkKfa03meXccn45h7B5amEOW0DoYxgMtVRM+LLx8hzj3zKSCzFzEv7pbMjUOiD1MDYu/Ri4aNlgUGCEo8xEQH0YvmwbD+uxK0m1QWP7pkB5NKMAJ7sJSWPXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ba/Wzdbo; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730022588; x=1761558588;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nffs2oNGSJEoaU6UdGnC7ax6B8XaR/2vPlc0yJOQkrM=;
  b=Ba/WzdboH7xPwDfE/y/1QHLSJM/Jacbij1bbUv4Uy0BVObCTXzVSmEK9
   8guXZm4b6hCmj7zJHdgjhGLu6E06h8vlX87x39ITBuK8uxFNWAWrpimpX
   Ru4IYAskUXcYZ2HEL3sYnJ6UtHlfk3izufBSmrvyLCW7at1KbYmRqzura
   uBL4zZhVggIwwwWAx72THrwf/HEIh5D95vkDKDLg6RAvn3jrpDXSt5RGG
   7FoFG4XGajX5gSnFNt2uRnSMHdOfg9RdAxaQDNhmDBDi1WEtQa9sxIsyI
   qSE/eA5tOccmMRS13AYienZr90Re8s62qSVoN0VaQUSWAIyWTimyOgmmn
   g==;
X-CSE-ConnectionGUID: g5tjm2PPQeC9jevU44qRIQ==
X-CSE-MsgGUID: OF1WXyUSSf29C6RX/h8RRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="33438486"
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="33438486"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 02:49:48 -0700
X-CSE-ConnectionGUID: x/hAhiAcSmqvRd+uQ+8ISA==
X-CSE-MsgGUID: P7BLRlIDSW+50FkJ5sG7Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="104662517"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 02:49:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 02:49:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 02:49:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 02:49:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QL4Xn9geVofZjZVgB2+lQzyP1OUcFMIDtoKuNegMK3uidgv6LNfmuVgjXF744Cq80xvEW1q1qO06Ks/wyMHDaA6r6wnC7/Q/yerV3Fn5jG4naswsPwMYRykZY+DxBH5hzD4Q5gTJNkmzgCN0BiMz2YEekwuq04L9hGBfShm4ux2rAiYX66lsdNrg1zJY84PRM2qophqSU2HEk5cQ2+iAeNwjgtEZugvVXgvBcD+Z9EZpZMQZkFRFfcN6db58CnjEtGqCyhb4xqqqphoohQJcP1WAw3NVmUNgax/veqmP6RMZ4rygTtL9wNjR4C4fvkc4Nlo2odl7ubCDmL1yMpWZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRp8Q9j5BngJ4BR7LbiI4WzH6SqwF8S2yDtA+UDwYMg=;
 b=yhKn0CyxXjtqsIe7Iyi7sd7zZv46v5e5/a/3qWTt+Z5aIShAyk4avwnWvgAVfC4xYJRXygya0hmLoqRreIGgeEywdzlJbP/peL/GsSOI7IbPp/qPy4Ro7XdaBVUE2pe2WNlaI8KX95jv8xo6t/3ytjRWvD1H++B3YEMABYbnhQbr5HWzbMVaNmIVqJ60WKOomPjfh5WkLMZRtW16T9jrqwE81BoDGsZs7bvjQUg3zuVXqgLRkzoEDIFjr33WikFS35x/4Nh87kgMuwpYxyhlBT6epy+dep5g1eIhuL01X04fuXdET0Su3o6UXoFP1/HK6Vdm2zHrRjCH2u66g4hKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sun, 27 Oct
 2024 09:49:41 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%5]) with mapi id 15.20.8093.018; Sun, 27 Oct 2024
 09:49:41 +0000
Subject: Re: [Intel-wired-lan] [iwl-next v4 2/2] igc: Link queues to NAPI
 instances
To: Joe Damato <jdamato@fastly.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "kurt@linutronix.de"
	<kurt@linutronix.de>, "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
References: <20241022215246.307821-1-jdamato@fastly.com>
 <20241022215246.307821-3-jdamato@fastly.com>
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Message-ID: <d7799132-7e4a-0ac2-cbda-c919ce434fe2@intel.com>
Date: Sun, 27 Oct 2024 11:49:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20241022215246.307821-3-jdamato@fastly.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To PH0PR11MB5949.namprd11.prod.outlook.com
 (2603:10b6:510:144::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5949:EE_|SA2PR11MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: cb34f557-9ef8-4931-0550-08dcf66cad8e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3YyZ3R3dlUvekNMdVRGcnZLS1h3VzlNN0xCZWdPMGRNWEZ5NzRRbFBwSERI?=
 =?utf-8?B?NkxTWWV5OS91enkvT1doeFRUbWNRQTdpUUtzMGtySmNoRjNOQ1ovYkErWFV5?=
 =?utf-8?B?aVRPS0xidnlHR2NsdmdVUDAwVTRxaVNNNlYxRXVtZnpvMFcrWTI0OWpGbjRp?=
 =?utf-8?B?NHdBRHcyU0g3MnNzNkVSc1YxSTlwZ25pR2VoTWp1dGFkeHhaU1BudzVyd0dJ?=
 =?utf-8?B?S0taU2tPYTZkYmxFK3pCUEVVWS9mZ1pBRGJZazJsbFV2dVNnbHI2ZVZSMnBo?=
 =?utf-8?B?OXNWcjlTb1gyRjBNVlFQTStnYjVCa1FHSWtSVGtSQktzWUszN3M1VGkxMzkz?=
 =?utf-8?B?cHF5dDMwNTJXdXN0dmhOMVk3K3ZSU0FZZzJwWjAzbHFBNk5NQzBQZDVMMEYr?=
 =?utf-8?B?dmpkMllidi9aaFBZVnZWbG9sMFdpR1JsV3FBSWsyWkwrRlBIckZNSVV5ZzdO?=
 =?utf-8?B?T2lSNU0wZEl3bXZoOWt6V3FRNDFwbWhNbHRZZVE4aktHNmdGZkRLa0hxYWZJ?=
 =?utf-8?B?NFl1akpsaU9ya1lDanlnVXphWCtYNE94cCtDQnpDTG1oeStFcDNSM2NkUXlM?=
 =?utf-8?B?Uk9LWDN4em50bEdKODh1MmxYZlJYNGlGU09aNExVYk1OZGlqL1ZqS1paQXlQ?=
 =?utf-8?B?L3BxY2RWTXdQSkljQVJaOXluUjFybFNJWDg3ZHhNblRITjdWMG5hYTFnMnQ2?=
 =?utf-8?B?NW1kU0FDSzhtejhFMTgyeFZpMW1CSDR3WXprWjRWZGwyUEtSK0dUZ0ZWWWRj?=
 =?utf-8?B?VXlEK0hOTHNZT1RESGlteEhXSVJFdlJyZGo5bUtMQytGejFMcGFKSjc1NllZ?=
 =?utf-8?B?M09ZRHZmelNscE5aeVQvWXNhT05UdWpUM2lYVWRjMU5hVkRNOWhRSTExakp2?=
 =?utf-8?B?TnUzOVM4S29aTmtzeTNFTHFDa21VeSt5RGtjQTF6dmRuNEgxK1JnSmVNcWhq?=
 =?utf-8?B?MVhqMGdKd24ySnlNQ0svSDNITlZ6Qk96c1VTY3FycEJwUEgzS3dyM2E1OVRW?=
 =?utf-8?B?a3BITnR4eXVodkxqOHBTMGFCa0pmTDQwUEYrVjJvRlBMNVlQK1hJaytRVzd2?=
 =?utf-8?B?TzBGbHhkdmVOcVc0cmoxWlhsdGtDSkRiRWpxWDFzMzFOYzFrMWFBeXpZSlkr?=
 =?utf-8?B?VG5iZmNmWiszL1RwYnhjV0tPaEwyMWpONm1qOHJGanRhWFZsQzY5SmV5eE5P?=
 =?utf-8?B?UTRDbXBPSXFnMkliS01maFptL3MyN0xHOGdBajl3Y0VmTjRKMENxY0lLNnFo?=
 =?utf-8?B?a0tsK2w4enAraEFVV254b0srMzhZMXpsSEFrN0VObDd2NTlEUWFicEJqeGIx?=
 =?utf-8?B?YmRMQ0pPYnJWcHhnUlZVb2VPNGJRdGxlbzFmTTdhbFVvRU5nWmFXaTl2OWFa?=
 =?utf-8?B?dHB6TlhuYkViOGpqZGJhaktrTkYyaHliRUxPY2tBbyswNDUwNnBMTm4xMWU0?=
 =?utf-8?B?QkJIcFVrZ3czWFNyTzVIMzh1QzlOVG9JaE14cUlyaWRqc3JpQnI3TVZxVTU5?=
 =?utf-8?B?T2FOZS80YjdORldvVVdDbmFBd2VFclVmdmduL1NWb2xhWTZCN1hVZkFncG1u?=
 =?utf-8?B?VXhZTmYyOEpFM2d1Ty93YlVTekRCMy83ZEROUmxBY0RoUGdBbGRzNjEwTHV3?=
 =?utf-8?B?dDJYUExPeFY4WEpHK0FseHRmVFhRVUxmNXlzQk9Wd1Q4OE1CbWZaaFphNWdD?=
 =?utf-8?Q?qJiHLqI0BXOeluXHXmYm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTNuakduU3VZaUMzbEdJTVZrNmRmNXZDc2VtcUQrQmJlNWZqY01YZ1BJd3Z3?=
 =?utf-8?B?Skd0U25zejF5ZXRXOGVtc1RxSEVzaWlxUEk2SGV3ZGNrSSt2bitNTkZVL0FD?=
 =?utf-8?B?cmN0MWdMb25Bd2ZmVUU3NUU2RmxUMkliY0cwc3JGckVWa3BraGlQcy9ueXdq?=
 =?utf-8?B?UmxWT0ZmMXlTTjJWWlBxS1lIUi9zTEM4ckpacVNmT28zbm1zRFExb3FLMFo2?=
 =?utf-8?B?ZEtOVEdKUGM2OHhZRWF5VTJ4MERqU3hCRC9nRytOUEM5QVBlZFl4Wi9OWkFZ?=
 =?utf-8?B?SFpGZGl6YjY0TksvUmNWV0gyZk5aY3djaWU3TGpFZG1tNEppWjliaCs3TFdB?=
 =?utf-8?B?WjAxbitjZms4dE95U3RqbnQwRUp3VlhXTEx5VEVoOVZtMTFZeGZqcXhWOUxB?=
 =?utf-8?B?V3FzOUdvU1Y2a2l4WmNGWlRCQTBLd0RWdDNmRjBSWUsybEo1eC9UbVZEZDFx?=
 =?utf-8?B?ZytsbXJIa2ZEVnk2STVuUkdoR09IbmFmc1dDSFpTMmJGazJ1QmhLTVZzR0hz?=
 =?utf-8?B?cVV4YUJ3VlB0UWk3SnVSWE4wUndISlBVU2NFdm41Sm45U1hOVS9oOWJEWUlt?=
 =?utf-8?B?NmJuYWNtb1JVUHdEL1hMY1hVMUJlbjBUbm9kQk15SU91OFYva20rVlY2VGVU?=
 =?utf-8?B?UU5RTzBCZko5MUpCbmxvTEJaK256eGdQMGtScTZEejQzZTZ5d3hkNHJEbkhT?=
 =?utf-8?B?NGdMTmo4czZEbGs5SWVUSUtFbG1haU1PWWpocTl1ZzgrWjhLN28xS1IyeHhO?=
 =?utf-8?B?YW9MUGNCNW1pUnREMTdGclM0eUsvWlhlTjUvTmxjOHp5YVZWcGkxMFJNQ1cz?=
 =?utf-8?B?eVNyZUNNZ3JKMmRxZUZRQU1sK0ltV0xyeFBOWlNtSG1ldnRGZnBHK1QzU1Zo?=
 =?utf-8?B?TDhiOXU3eEhSUnlvNm0yZ2tqQ0o2cElWTVZiN3puenZOdGhDQTNhc3orcGx3?=
 =?utf-8?B?bXp6ZndGaCtDQVpZeE5OOE9vNE10REVKTFl6RHU1cmUzTnRnMkVhK3IwYzJ3?=
 =?utf-8?B?M0hCSXVVY1lBMWRnTWxjWWV0RXBtKzFndEhuMzNVajZxSzREcG1ia2dlN2dF?=
 =?utf-8?B?NGxUMHk1alp5RlZyTkdpbURzRFI2TFc5Vmt3NXVEaUdBUUc5NGxXeWlOSDJL?=
 =?utf-8?B?RDRER0M3T1hueW5rWlJHall0bnFrYjlpbW9XMUR5UzQrYWFWVXk3RklnK3I0?=
 =?utf-8?B?Ni9jNVpWQjVNcnZ6cVZaNTBBaUZ3TkllbDJlcmxxRkdRWkRDSS95WnNJanFN?=
 =?utf-8?B?QTgrZmRxbTN1SWozTkxCRXZqc1pSYVVUMGdmUHNQS3UzaGNWUGJjOTFXMlJq?=
 =?utf-8?B?TEtYZys2K1JXbGNUYXFxRjlqK3BuNmNXeTBJQklPNjZEMHFld3pxUGV5aU0z?=
 =?utf-8?B?TXg1SUdLZTRMMjA2blRKa1ZveUVZdUo5Q0dobDF1ZjAwUTlFVmF4eEtqSlFL?=
 =?utf-8?B?WWxObGNtbUF2dGNPL1lGN1BKOWpFaEVGc3lkUk5ET0Z1UEEvcTZEd3VrZWZn?=
 =?utf-8?B?S3lOdDBQT2Y3ZDRZQXV6cEV4dmxqM2tHNVJISStZUkRjVmtuYlIrenpNdzd0?=
 =?utf-8?B?ajRmUTRoZEJ3M1FTZEFXNUwvR3lBQ0RKVFFJUkNQcnFnMEtmemhoMlFhM3Ar?=
 =?utf-8?B?RlBTZWxMeHNnQVhTRFFLclJjL29uYkF2WEhpN3Ewc1lSdDVhdFBKZ0pLdEdJ?=
 =?utf-8?B?MU5oOGYzcDNFZHF6T3AyL1RzTFgyZWxOM2lDaGtZNUhrTG9rcTNLUitiYWVZ?=
 =?utf-8?B?TDNEaWUvLzNYQ1FOcHNZT09uam9sTXc4dk5aYnFRMTkyNnM2TlNSblpGcjdn?=
 =?utf-8?B?MFdYRnRjVVpTTDZOdCs3WU1lL3BIWTEvSjFpbmtZUFhyN3ozU1ZoRXpjdmdP?=
 =?utf-8?B?RzJlMjJPSWlJODc4S29IdG53Qk4wNGpaenBLTEtENTQ5S0RuaHU3eVlhbjNQ?=
 =?utf-8?B?QTc2S3JjbWZEaytpZkk5dmw1cnl2RVA3a045dWhtM2E3WDVBQWpNVEdrTVNp?=
 =?utf-8?B?UlJUUzF4bmZpRXZGNGp5QkVjRlV0N2w3ZXpyZC8wUERWUk4rK3prOVRkZGEz?=
 =?utf-8?B?WC9kMFdzVnlobnZVL2RpbGZBd2dLSFF6elNVNkk1NUhzL2I5b0tuYzBpRHlt?=
 =?utf-8?B?MjY2cVZEZnZvbTFiRi96dTFsTXVacDlFSnBTOTJLa1VzV2NCTG91Wlo4TWJt?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb34f557-9ef8-4931-0550-08dcf66cad8e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 09:49:41.1494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLL7kYNACSm+LLF8Mbl7bBFL2Fg+hbqfCf92tgm1PdqDqEFtNgljn7Ku669HpmExwZxVHojaHQvSDu5QcNL7Nf9G5tsdum1FaPdeCRXnbRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com


On 10/23/2024 12:52 AM, Joe Damato wrote:
> Link queues to NAPI instances via netdev-genl API so that users can
> query this information with netlink. Handle a few cases in the driver:
>    1. Link/unlink the NAPIs when XDP is enabled/disabled
>    2. Handle IGC_FLAG_QUEUE_PAIRS enabled and disabled
> 
> Example output when IGC_FLAG_QUEUE_PAIRS is enabled:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                           --dump queue-get --json='{"ifindex": 2}'
> 
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>   {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
>   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> 
> Since IGC_FLAG_QUEUE_PAIRS is enabled, you'll note that the same NAPI ID
> is present for both rx and tx queues at the same index, for example
> index 0:
> 
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> 
> To test IGC_FLAG_QUEUE_PAIRS disabled, a test system was booted using
> the grub command line option "maxcpus=2" to force
> igc_set_interrupt_capability to disable IGC_FLAG_QUEUE_PAIRS.
> 
> Example output when IGC_FLAG_QUEUE_PAIRS is disabled:
> 
> $ lscpu | grep "On-line CPU"
> On-line CPU(s) list:      0,2
> 
> $ ethtool -l enp86s0  | tail -5
> Current hardware settings:
> RX:		n/a
> TX:		n/a
> Other:		1
> Combined:	2
> 
> $ cat /proc/interrupts  | grep enp
>   144: [...] enp86s0
>   145: [...] enp86s0-rx-0
>   146: [...] enp86s0-rx-1
>   147: [...] enp86s0-tx-0
>   148: [...] enp86s0-tx-1
> 
> 1 "other" IRQ, and 2 IRQs for each of RX and Tx, so we expect netlink to
> report 4 IRQs with unique NAPI IDs:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                           --dump napi-get --json='{"ifindex": 2}'
> [{'id': 8196, 'ifindex': 2, 'irq': 148},
>   {'id': 8195, 'ifindex': 2, 'irq': 147},
>   {'id': 8194, 'ifindex': 2, 'irq': 146},
>   {'id': 8193, 'ifindex': 2, 'irq': 145}]
> 
> Now we examine which queues these NAPIs are associated with, expecting
> that since IGC_FLAG_QUEUE_PAIRS is disabled each RX and TX queue will
> have its own NAPI instance:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                           --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>   {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   v4:
>     - Add rtnl_lock/rtnl_unlock in two paths: igc_resume and
>       igc_io_error_detected. The code added to the latter is inspired by
>       a similar implementation in ixgbe's ixgbe_io_error_detected.
> 
>   v3:
>     - Replace igc_unset_queue_napi with igc_set_queue_napi(adapater, i,
>       NULL), as suggested by Vinicius Costa Gomes
>     - Simplify implemention of igc_set_queue_napi as suggested by Kurt
>       Kanzenbach, with a tweak to use ring->queue_index
> 
>   v2:
>     - Update commit message to include tests for IGC_FLAG_QUEUE_PAIRS
>       disabled
>     - Refactored code to move napi queue mapping and unmapping to helper
>       functions igc_set_queue_napi and igc_unset_queue_napi
>     - Adjust the code to handle IGC_FLAG_QUEUE_PAIRS disabled
>     - Call helpers to map/unmap queues to NAPIs in igc_up, __igc_open,
>       igc_xdp_enable_pool, and igc_xdp_disable_pool
> 
>   drivers/net/ethernet/intel/igc/igc.h      |  2 ++
>   drivers/net/ethernet/intel/igc/igc_main.c | 41 ++++++++++++++++++++---
>   drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 ++
>   3 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index eac0f966e0e4..b8111ad9a9a8 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -337,6 +337,8 @@ struct igc_adapter {
>   	struct igc_led_classdev *leds;
>   };
>   
> +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> +			struct napi_struct *napi);
>   void igc_up(struct igc_adapter *adapter);
>   void igc_down(struct igc_adapter *adapter);
>   int igc_open(struct net_device *netdev);
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 7964bbedb16c..04aa216ef612 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -4948,6 +4948,22 @@ static int igc_sw_init(struct igc_adapter *adapter)
>   	return 0;
>   }
>   
> +void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
> +			struct napi_struct *napi)
> +{
> +	struct igc_q_vector *q_vector = adapter->q_vector[vector];
> +
> +	if (q_vector->rx.ring)
> +		netif_queue_set_napi(adapter->netdev,
> +				     q_vector->rx.ring->queue_index,
> +				     NETDEV_QUEUE_TYPE_RX, napi);
> +
> +	if (q_vector->tx.ring)
> +		netif_queue_set_napi(adapter->netdev,
> +				     q_vector->tx.ring->queue_index,
> +				     NETDEV_QUEUE_TYPE_TX, napi);
> +}
> +
>   /**
>    * igc_up - Open the interface and prepare it to handle traffic
>    * @adapter: board private structure
> @@ -4955,6 +4971,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
>   void igc_up(struct igc_adapter *adapter)
>   {
>   	struct igc_hw *hw = &adapter->hw;
> +	struct napi_struct *napi;
>   	int i = 0;
>   
>   	/* hardware has been reset, we need to reload some things */
> @@ -4962,8 +4979,11 @@ void igc_up(struct igc_adapter *adapter)
>   
>   	clear_bit(__IGC_DOWN, &adapter->state);
>   
> -	for (i = 0; i < adapter->num_q_vectors; i++)
> -		napi_enable(&adapter->q_vector[i]->napi);
> +	for (i = 0; i < adapter->num_q_vectors; i++) {
> +		napi = &adapter->q_vector[i]->napi;
> +		napi_enable(napi);
> +		igc_set_queue_napi(adapter, i, napi);
> +	}
>   
>   	if (adapter->msix_entries)
>   		igc_configure_msix(adapter);
> @@ -5192,6 +5212,7 @@ void igc_down(struct igc_adapter *adapter)
>   	for (i = 0; i < adapter->num_q_vectors; i++) {
>   		if (adapter->q_vector[i]) {
>   			napi_synchronize(&adapter->q_vector[i]->napi);
> +			igc_set_queue_napi(adapter, i, NULL);
>   			napi_disable(&adapter->q_vector[i]->napi);
>   		}
>   	}
> @@ -6021,6 +6042,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
>   	struct igc_adapter *adapter = netdev_priv(netdev);
>   	struct pci_dev *pdev = adapter->pdev;
>   	struct igc_hw *hw = &adapter->hw;
> +	struct napi_struct *napi;
>   	int err = 0;
>   	int i = 0;
>   
> @@ -6056,8 +6078,11 @@ static int __igc_open(struct net_device *netdev, bool resuming)
>   
>   	clear_bit(__IGC_DOWN, &adapter->state);
>   
> -	for (i = 0; i < adapter->num_q_vectors; i++)
> -		napi_enable(&adapter->q_vector[i]->napi);
> +	for (i = 0; i < adapter->num_q_vectors; i++) {
> +		napi = &adapter->q_vector[i]->napi;
> +		napi_enable(napi);
> +		igc_set_queue_napi(adapter, i, napi);
> +	}
>   
>   	/* Clear any pending interrupts. */
>   	rd32(IGC_ICR);
> @@ -7385,7 +7410,9 @@ static int igc_resume(struct device *dev)
>   	wr32(IGC_WUS, ~0);
>   
>   	if (netif_running(netdev)) {
> +		rtnl_lock();

This change will bring back the deadlock issue that was fixed in commit:
6f31d6b: "igc: Refactor runtime power management flow".

>   		err = __igc_open(netdev, true);
> +		rtnl_unlock();
>   		if (!err)
>   			netif_device_attach(netdev);
>   	}
> @@ -7440,14 +7467,18 @@ static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
>   	struct net_device *netdev = pci_get_drvdata(pdev);
>   	struct igc_adapter *adapter = netdev_priv(netdev);
>   
> +	rtnl_lock();
>   	netif_device_detach(netdev);
>   
> -	if (state == pci_channel_io_perm_failure)
> +	if (state == pci_channel_io_perm_failure) {
> +		rtnl_unlock();
>   		return PCI_ERS_RESULT_DISCONNECT;
> +	}
>   
>   	if (netif_running(netdev))
>   		igc_down(adapter);
>   	pci_disable_device(pdev);
> +	rtnl_unlock();
>   
>   	/* Request a slot reset. */
>   	return PCI_ERS_RESULT_NEED_RESET;
> diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
> index e27af72aada8..4da633430b80 100644
> --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> @@ -84,6 +84,7 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
>   		napi_disable(napi);
>   	}
>   
> +	igc_set_queue_napi(adapter, queue_id, NULL);
>   	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
>   	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
>   
> @@ -133,6 +134,7 @@ static int igc_xdp_disable_pool(struct igc_adapter *adapter, u16 queue_id)
>   	xsk_pool_dma_unmap(pool, IGC_RX_DMA_ATTR);
>   	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
>   	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> +	igc_set_queue_napi(adapter, queue_id, napi);
>   
>   	if (needs_reset) {
>   		napi_enable(napi);
> 



Hi Joe,


The current version will cause a regression, a possible deadlock, due to 
the addition of the rtnl_lock in igc_resume that was fixed previously.

You can refer to the following link:

https://github.com/torvalds/linux/commit/6f31d6b643a32cc126cf86093fca1ea575948bf0#diff-d5b32b873e9902b496280a5f42c246043c8f0691d8b3a6bbd56df99ce8ceb394L7190


