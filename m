Return-Path: <bpf+bounces-66035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B49C7B2CD5E
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 21:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC5A1C25AB3
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 19:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC2B340D95;
	Tue, 19 Aug 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsZOy2th"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734A28489E;
	Tue, 19 Aug 2025 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633231; cv=fail; b=evSxVdiYa1L0bKmw4b8UiFG/f+RZ8dYTyyfk6wV2eoq+1mTtJpD8k3SsplOMT7XTNS1cuUsfHa/j/2EatEnBQOSx67b/Ey8/bsD9ToahQTEfXNDWPX3F+0zmjco7IEOgWkmlJU9RlwdmA60Z2D3TUVqiTKCYY4JalOsJI2f6BkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633231; c=relaxed/simple;
	bh=pbYGFmV5YHD2ebOAidTY3+v6hi5IMvNtK3o72s7qu8E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ml22QWP240iaGprJmq8V8GcGpadSAoBj9cr0yvIdB3fedI17EjvBc6X3ymR5bCIv9fBVF0uY3PtubicJM1KqArolaNwT0FOQMnMojCmhhw2hlH/vAP6TOPBlh9swJ2T0bUJ1vY7mJ7bd/zcU8Nh4d3JfQcOwcbywvPLNn8zVtaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsZOy2th; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755633229; x=1787169229;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=pbYGFmV5YHD2ebOAidTY3+v6hi5IMvNtK3o72s7qu8E=;
  b=LsZOy2thW+udkYK6JD25qSFkiK6Cr5qSalqfBGogaoE4pvIqPoElZqG4
   +qsPxLuHz/BSPZqOIFc2gPWiDYNXPGKhaYPT9ydsZuyj3VNFQXz7Fehio
   Up3/0qUiYIa3eieDwyKKGONUOWit+KopVms9vE48Wp76brrcynGo9aMPS
   Iq4LkQ4If/sF4MRVWs8tEs6oPExWORcwmkUUkO+42F7e1COFEpIAPPqNV
   tLgPC4EJg5LFV2fsrW8fA5wCbMT+VcH1Ek2WUFLKoh9JYsw84OPspxjix
   nd0MyoR2QAcKfvpMoXQ0hKl+TJYcCDxEN+cYtDzE4KGtSgHiSJZ6qEojc
   g==;
X-CSE-ConnectionGUID: L69FJCLdSPS2XjUdO7rp+g==
X-CSE-MsgGUID: SmuSQ+xdSE2HbQgiCULVpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68159315"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="asc'?scan'208";a="68159315"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 12:53:49 -0700
X-CSE-ConnectionGUID: L7W4vVXFRkS9ADEP506uGQ==
X-CSE-MsgGUID: APFIT7t2T8uhjjLMEXoOHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="asc'?scan'208";a="173179437"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 12:53:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 12:53:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 12:53:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.78) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 12:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hezeb99YiK5GFUeD5wqQmZ1i5uY50n+ixnydMWvPhOvVR1VoRlM5plLrzYtVA3EVFVrpc0V6cNJwKRECVkIPK/PiOvrove6V60lYYnQBn3m1N/wDnb2MOzuhIcGEV38AQCjMQBLKguHI1Wx+9vtQgCHrV15HvW0VDwnlvlqj8t126Lav5WBXB8fPUIgnqKrvDI4ZBXm2wir0fvzf7Ewzx4kqgE3j5c5N3pfsboCQo1VQjXRhftHQ6EinfbJk+3YW2xN3DjZ9zf339+Q5DNnEHQv/C4Di08lZMWzEfRARZ6IkDfTRIorrhSxt/hpzddgbk5WmSJCCdLjFeXT5BD4JSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZfWL6701XFrVhIPZh6zG/OH0Qh8PE2zI0w7cp7RgpY=;
 b=EuBim2LRa/Nobr0lI2Yggb5c6qmilBgIUDcSVo3+gJEoVQJlB0bVIo2MqP/hvr0QwPg6++ynuxQzCxBKmKKKdHcZKXxt3AiWFjDYKhw7sHcCCaCDa+kQ/eXL65QtjwFONkP9ScR+UIbYD0eGyaeJkTVGEy24y4CWFVeV4KGDQjkaYjq0eMRQoom3fvQYMUEX4raOk7pF9SC9EF5UqOuaDY/PoOuwyATRPNg+7dV+zxUevhMHnZxBBMvMLCFpF+A5X8VYr8yulIEYIzBm9MwIHlFL2WkI3KPBPhG42R8gfGPrVvga3ZP/JQAw3P6sDH/D+nDOrfe8KVycrMqpDt/kCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5878.namprd11.prod.outlook.com (2603:10b6:510:14c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 19:53:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 19:53:45 +0000
Message-ID: <9f9331ac-2ae0-4a92-b57b-d63bac858379@intel.com>
Date: Tue, 19 Aug 2025 12:53:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] ice: fix Rx page leak on multi-buffer frames
To: Jesper Dangaard Brouer <hawk@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <ast@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <maciej.fijalkowski@intel.com>, <magnus.karlsson@intel.com>,
	<andrew+netdev@lunn.ch>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <bpf@vger.kernel.org>, <horms@kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<jaroslav.pulchart@gooddata.com>, <jdamato@fastly.com>,
	<christoph.petrausch@deepl.com>, Rinitha S <sx.rinitha@intel.com>, "Priya
 Singh" <priyax.singh@intel.com>, Eelco Chaudron <echaudro@redhat.com>,
	<edumazet@google.com>
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
 <20250815204205.1407768-4-anthony.l.nguyen@intel.com>
 <3887332b-a892-42f6-9fde-782638ebc5f6@kernel.org>
 <dd8703a5-7597-493c-a5c7-73eac7ed67d5@intel.com>
 <6e2cbea1-8c70-4bfa-9ce4-1d07b545a705@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <6e2cbea1-8c70-4bfa-9ce4-1d07b545a705@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------I9JFRWX4P9t1vbk0bk1m4vPi"
X-ClientProxiedBy: MW4PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:303:b4::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a02fdd-76e4-488d-4b30-08dddf5a1b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3ByZndFNU9VNFIvVHl6ZEl2ZDVCRkNsR2ZOaStmOWpmaUxRSnFWZVFLNGxq?=
 =?utf-8?B?aklWc1ZXZ1BlWWRuZ3RmUUxkdWFqdzQ0MG9EcExIRFkvRldWWVE5YmhjdzMv?=
 =?utf-8?B?cVkvT041TnI1UXFYY3hESlBCWkpmOVpibWFMcG5xNjFFN01SeFh2RlBKUDRJ?=
 =?utf-8?B?b0FlTEtvWGI1Y2hFT215clpHeGRqNlhqT2VsMDYwU0U2V2ZIY0Z0UU14SEs1?=
 =?utf-8?B?NkNzcUVZSHpmOUNTYVpDRU9vMWF6azdCVTJaZndPRTYzTTA5QndFZWp3VldO?=
 =?utf-8?B?My9BSkF1WThUdHVmRFRvVFdyYW1ac1BvZmdCWFppbUdHZWRQVlVNMm16T0R1?=
 =?utf-8?B?SU8wL2k1MitIdnVtUjEzTCtER1NMbzIxM25sbEhpUnNDRHQ1STM2VXNmMm9L?=
 =?utf-8?B?TUwzZEIwSHFQR3dZb1R3U1pvU1lTMWRJNnZZckorTEJpMjdVM2tZUVFNRkxv?=
 =?utf-8?B?Q005L3h6dXkvLytBTE5jaTVaWmdEWkZucWNoSHBHeG5nTm1OWW4yakNtbGZp?=
 =?utf-8?B?UzJmNFM5a0RMblM4dmlIQUREM1o5bUk1TmxMcE5lOER1cVkxWUk4YmRlK3l0?=
 =?utf-8?B?c0o5OWRtWTNqQkdOd2V5blNJN0hBZUNvZEdhT0pKdkVEcjBqTkYwT1pxcGZN?=
 =?utf-8?B?U3JOd0Z6SWJac0lXUVQ2dHlvMzlHck9yazlGMWlmSTlkR2dSbXh3NjkxNXE0?=
 =?utf-8?B?RHJHb3hjOU5Bc05hVk5MaHJBN0pBNnVFTER5ZVgwbGx6ZmNsUzV3RXB0VFNV?=
 =?utf-8?B?Mk1jSkJDRVlVcFpaZDR4SG1MTU1rZU9oQktLSjNPckJpcmN6bXloSjJMV0tJ?=
 =?utf-8?B?SXpjYndQVEVCWThYcG56MmVVY3V1ZDBaY0lBbE5tZGtReG8yTjVxV09IM296?=
 =?utf-8?B?c2lBSW9XRS9MYUVDbWRhOTh1cUNKaXhHNkl2cDVCRXFxZjE4RTJkWXpIbnlu?=
 =?utf-8?B?bzg3ZXdPS1ZzSDcxZnFQU3pmYTBYUFRkTGpNVXE1NGJ1R3F4d2tlbWE4ZGVE?=
 =?utf-8?B?UXFvTVhIaTJwcW9lQ3dBeHRlQ0RMUUhzVjZGYUFBNWNLUXlHOVUycUNvVXo2?=
 =?utf-8?B?VjNSSE9LVDltR0VzcnpJWFNtV3plbzlPY3Mza1F0YzZnYnRvWTl0ZStrcmc3?=
 =?utf-8?B?V25FZzBod1R6QnBOMkpUMkRaUU5hR2ZIQlZrdnN1VnNGclJNRzkreDZJdW81?=
 =?utf-8?B?VVJHelFxODlBREFrdUlJS1Z6MnkvV3lCSnBrakVTeE15SjJSb3FPb2c0S1NR?=
 =?utf-8?B?bUlJM0pLc3RYa0JockZnMDBvYWxXQ21oSzNKQ1pFWEhJVUcwSGM0SXBISFpy?=
 =?utf-8?B?OWlBR292aWhtWEpvQklydUk3K1Q1VEFvalVjZHpOdkFzSkpRZ3JMaDg2RkdQ?=
 =?utf-8?B?dTJlL1lDQzdkY1NVakxVVDIvNVc1MTRYSWNjMG1yNS9qdU1EOTZCd3ZNcjRQ?=
 =?utf-8?B?OUM1NGxqaXl1K0VUVWJ4VnlNbC9qY2xiL1czMU9aQWpma2ZTSUVIdE9RWnpJ?=
 =?utf-8?B?M28yL3FtdGgxS1ZWSU5TaTFHWHR6djdldWlyWHFXeVA4NkxQcWdnUzZGNzhY?=
 =?utf-8?B?T285eW9GaW5mMFE4YUloNWczVWZCemxwcHMwQ0Z4NkxBcjZvcXoyV0VkWEd0?=
 =?utf-8?B?Tzdxc2NzY2RIYlNkZkpsSmw1dE9lMzNqVUQ3ajgwZzhyVHEzOU5pemcvZU1h?=
 =?utf-8?B?RDRMUkE4NTRpd0ZVS3JvV0txK0kyRnhMcnkrSmJQS2NWcFhPOXZJeFBsMy9V?=
 =?utf-8?B?aWM1Q1VDOVA5ZWY4cHpyUEd1d2srR05zd20xbXdmY2d2YUYxMVpyWVFDSkZX?=
 =?utf-8?B?NG9lRjBDU09XRVNtd3Q3RDMvT1hjSkMzaC80bXY2NW5XYkcyMUFvUmlXaXZv?=
 =?utf-8?B?b2xBaEQ3SVc1czZIeElJbjdHSUxFUVg5MCtpNEJ1RHhDNzlVN0dPUzdNYWxh?=
 =?utf-8?Q?O5QDcIC0dlg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlJJeE5Id04zZ1JSdnVoUlZ2SVpmVEkwQmtlek9KOTdndFUyenBIN3l4d0ho?=
 =?utf-8?B?c1dvWFpISnBtY3JBcVprRTBFUVFaNXRIUG0yeENqVWE0LzU2ZEk0TDdRblli?=
 =?utf-8?B?S3VJL0VjVGdPKytsazViZWRkQ0wzZ3I2N3ZVUUgyU1AxMUt5ZlArQUZXbEQ4?=
 =?utf-8?B?djBYbjNaVGVValB4eVFBTG1kQ08reVRTWUh5a3pEajNTT2lYcEZVWkFqamFq?=
 =?utf-8?B?OEpBczJTQ2pEaHo2R0JUeEFGSTd6ellBVzJoL2VFanRVT0swbEtHUkYvV3hh?=
 =?utf-8?B?SndBR1hsVldOampXUDY4M0pqNU05aG1DWGNzNk1jd2tTak4wMklTcWJ0R1hE?=
 =?utf-8?B?UndUSU0yWDBWUFZDcis3Sm13bnhuMlluTjVuYTFDZ0dBbXAwbUJvWERBbGY0?=
 =?utf-8?B?K0pRZHB5dmxhNWM1MzhTWGdnSllvSVlORERtOStjSTNNYnJjNXltY3pBWW9l?=
 =?utf-8?B?dnVkdWtxMjNwaU1aNXhvNUhwSkJBU3VVY3BjQXA0OVZ3ZE9WbTlGanZKdzZR?=
 =?utf-8?B?ZWxQQ0NBdC9VQzRUdW5MMjZuNUhqQVVnOUxzY2xiN0ZiWWkrdEFnYUJIcHo2?=
 =?utf-8?B?L25RSzZ5NWcrSjhiYjArL29JUDllVWV0b1lZQmtvYURlYUt6bDNySENCUVdm?=
 =?utf-8?B?elRCZFdSRjRBUmMxZ2J5SlJRR0lRUGFvcnBaajJFS0VTZ1lZbW9adExDMW0y?=
 =?utf-8?B?ajBSNFlUY05aYUxYQ3hmV2JmV3Yrb29KMXlvZ0xQTFQ4ak1wdDN5Mll6SUZ3?=
 =?utf-8?B?Q2xnZUdwMnZSNDcyOHU5YVZDZm9vKzNvMEJMdkpiTHVzQkw1Z0llSDZyUXNL?=
 =?utf-8?B?M1ZRVWdIMEwwb2o4SGRINXU1SDd6dXB2ZWtuanRzekMwbE1JNjJGdmdpT09M?=
 =?utf-8?B?YjhRbUNZNG8wSHpYRjArdm8vQkxyZ3V5UTJ6bTVqc3BtRlBpYzhLMGM0Y1lJ?=
 =?utf-8?B?QkRGWHhlS3M2YWFHdmMyNDgxUlNFS1d0eUNQUjY0QisrUVo5bmhCVW1pY0Jn?=
 =?utf-8?B?TXkzQis5R1ZJcFB6ZzJNWHFWbS9VNkVBa0h6VkdFVTFNV05BOTFHYzEzTGs0?=
 =?utf-8?B?MktVWUtDYzVtdnMrMUZhMnozWGVQM1E4VmJMNGlpWmE1MTV5NCtYMEZoOHBP?=
 =?utf-8?B?dFRMSEJsaWs2azZZL0sxNUN4UmZOeWMwdGd2dlkxYVEwWVhtTGxSTmhvVXRs?=
 =?utf-8?B?MmNaQ1c5VTg4cXNJSzNwZXpIUVpEUnVkTUtlc1JrOXFDaVhVNEl6MmNURGxI?=
 =?utf-8?B?OXp6dnU4L29MY05nL0hEaDBSWnVQbXc3V2dyb2pkYUdGMTJROUZsdVNzRVhO?=
 =?utf-8?B?Z2JQa2UyaTFDekJZMEFuMEdCbng0anhkaDdTcTNnQzJna2Z2b3AweGJRVWR3?=
 =?utf-8?B?YzB6L3dtRG5yZmZSWDBIZ3lYTm5xSzlaZldyZGpyRXMrVHE0NmxQdDRIaWhF?=
 =?utf-8?B?TU1NVnRFaldJRnM1czRIOG82b05Uei9leFE3UWpOOFcyNURZTlVOdkJRMU5p?=
 =?utf-8?B?QWIyWEpNam5LZzVVb2NYRTd6V0JpMDBGV25wNWdHL1dQNThVYUNKbko4d3l4?=
 =?utf-8?B?MkdPQ0dvMzJXT3VXcTUwdS8zWnVOSGhQUWZ5Z3BISE1Ta0kwd1ZWcnRkVk5u?=
 =?utf-8?B?Q2tldWR1bHZJSWo0T3dNVVl4dXJtaXIvSmlPZTJQendPR1JKR2UvWWgwWHhs?=
 =?utf-8?B?TnJJU2wrSExnZjJnSm9ndnRuUlpOQ1ZRbHgrVlhvdG9WcmpudTNNYWh6OU5j?=
 =?utf-8?B?ODRTR295eXVMaC8wZG01aTBLYkhsMjA0eWZBRnRDLzNxT2dSY1Nac045VHd0?=
 =?utf-8?B?ZnRXK0ZYbWpGQjRpenBBMm85RHU5TW5xc2pjTDZxbU9LWHF6dzJoK1lPajkx?=
 =?utf-8?B?b0NmVWpKUGswVVNhakFIYWdMVzYvOVBzUTZ3ODlzS010UmZoMjZyenVNK0Zk?=
 =?utf-8?B?TGhZQ2hpWjFFZHNHS0VudVNpNkpnZDE1N3R5UFR4NFRja3B2SmhDWHJoV21i?=
 =?utf-8?B?Z3dzM3FFR0M4RUs3M1BGbm9zNlh3Q1d5ZWFERiswMDJ6d1Zwc3R2bUtBeHhR?=
 =?utf-8?B?U1J0VmcwSjhudE5mekFYTzQ0d2pWRU5QS1FyMStYbDJhcjRKNjNvZElEa3Bi?=
 =?utf-8?B?RnZkT1pIM0RUYkwyRW9lOXJDbFBnc0M4RG9yektCOUViT040TnppTUdJVmtB?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a02fdd-76e4-488d-4b30-08dddf5a1b3a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:53:45.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgit3jsAYtih33wpUnSLZdVLeenjS2ydCL4EsWIQwrHxsa+Rp/ew1rc7l7HWaUWeUByBfCUYS8YRkP1g+JKfSy5wGyTr6Bg13HuSMNUvSyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5878
X-OriginatorOrg: intel.com

--------------I9JFRWX4P9t1vbk0bk1m4vPi
Content-Type: multipart/mixed; boundary="------------jIDW19T210bV0ebe3ccfcT5i";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, ast@kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
Cc: maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 andrew+netdev@lunn.ch, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, bpf@vger.kernel.org, horms@kernel.org,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 jaroslav.pulchart@gooddata.com, jdamato@fastly.com,
 christoph.petrausch@deepl.com, Rinitha S <sx.rinitha@intel.com>,
 Priya Singh <priyax.singh@intel.com>, Eelco Chaudron <echaudro@redhat.com>,
 edumazet@google.com
Message-ID: <9f9331ac-2ae0-4a92-b57b-d63bac858379@intel.com>
Subject: Re: [PATCH net 3/6] ice: fix Rx page leak on multi-buffer frames
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
 <20250815204205.1407768-4-anthony.l.nguyen@intel.com>
 <3887332b-a892-42f6-9fde-782638ebc5f6@kernel.org>
 <dd8703a5-7597-493c-a5c7-73eac7ed67d5@intel.com>
 <6e2cbea1-8c70-4bfa-9ce4-1d07b545a705@kernel.org>
In-Reply-To: <6e2cbea1-8c70-4bfa-9ce4-1d07b545a705@kernel.org>

--------------jIDW19T210bV0ebe3ccfcT5i
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/19/2025 9:44 AM, Jesper Dangaard Brouer wrote:
>=20
>=20
> On 19/08/2025 02.38, Jacob Keller wrote:
>>
>>
>> On 8/18/2025 4:05 AM, Jesper Dangaard Brouer wrote:
>>> On 15/08/2025 22.41, Tony Nguyen wrote:
>>>> This has the advantage that we also no longer need to track or cache=
 the
>>>> number of fragments in the rx_ring, which saves a few bytes in the r=
ing.
>>>>
>>>
>>> Have anyone tested the performance impact for XDP_DROP ?
>>> (with standard non-multi-buffer frames)
>>>
>>> Below code change will always touch cache-lines in shared_info area.
>>> Before it was guarded with a xdp_buff_has_frags() check.
>>>
>>
>> I did some basic testing with XDP_DROP previously using the xdp-bench
>> tool, and do not recall notice an issue. I don't recall the actual
>> numbers now though, so I did some quick tests again.
>>
>> without patch...
>>
>> Client:
>> $ iperf3 -u -c 192.168.93.1 -t86400 -l1200 -P20 -b5G
>> ...
>> [SUM]  10.00-10.33  sec   626 MBytes  16.0 Gbits/sec  546909
>>
>> $ iperf3 -s -B 192.168.93.1%ens260f0
>> [SUM]   0.00-10.00  sec  17.7 GBytes  15.2 Gbits/sec  0.011 ms
>> 9712/15888183 (0.061%)  receiver
>>
>> $ xdp-bench drop ens260f0
>> Summary                 1,778,935 rx/s                  0 err/s
>> Summary                 2,041,087 rx/s                  0 err/s
>> Summary                 2,005,052 rx/s                  0 err/s
>> Summary                 1,918,967 rx/s                  0 err/s
>>
>> with patch...
>>
>> Client:
>> $ iperf3 -u -c 192.168.93.1 -t86400 -l1200 -P20 -b5G
>> ...
>> [SUM]  78.00-78.90  sec  2.01 GBytes  19.1 Gbits/sec  1801284
>>
>> Server:
>> $ iperf3 -s -B 192.168.93.1%ens260f0
>> [SUM]  77.00-78.00  sec  2.14 GBytes  18.4 Gbits/sec  0.012 ms
>> 9373/1921186 (0.49%)
>>
>> xdp-bench:
>> $ xdp-bench drop ens260f0
>> Dropping packets on ens260f0 (ifindex 8; driver ice)
>> Summary                 1,910,918 rx/s                  0 err/s
>> Summary                 1,866,562 rx/s                  0 err/s
>> Summary                 1,901,233 rx/s                  0 err/s
>> Summary                 1,859,854 rx/s                  0 err/s
>> Summary                 1,593,493 rx/s                  0 err/s
>> Summary                 1,891,426 rx/s                  0 err/s
>> Summary                 1,880,673 rx/s                  0 err/s
>> Summary                 1,866,043 rx/s                  0 err/s
>> Summary                 1,872,845 rx/s                  0 err/s
>>
>>
>> I ran a few times and it seemed to waffle a bit around 15Gbit/sec to
>> 20Gbit/sec, with throughput varying regardless of which patch applied.=
 I
>> actually tended to see slightly higher numbers with this fix applied,
>> but it was not consistent and hard to measure.
>>
>=20
> Above testing is not a valid XDP_DROP test.
>=20

Fair. I'm no XDP expert, so I have a lot to learn here :)

> The packet generator need to be much much faster, as XDP_DROP is for
> DDoS protection use-cases (one of Cloudflare's main products).
>=20
> I recommend using the script for pktgen in kernel tree:
>   samples/pktgen/pktgen_sample03_burst_single_flow.sh
>=20
> Example:
>   ./pktgen_sample03_burst_single_flow.sh -vi mlx5p2 -d 198.18.100.1 -m =

> b4:96:91:ad:0b:09 -t $(nproc)
>=20
>=20
>> without the patch:
>=20
> On my testlab with CPU: AMD EPYC 9684X (SRSO=3DIBPB) running:
>   - sudo ./xdp-bench drop ice4  # (defaults to no-touch)
>=20
> XDP_DROP (with no-touch)
>   Without patch :  54,052,300 rx/s =3D 18.50 nanosec/packet
>   With the patch:  33,420,619 rx/s =3D 29.92 nanosec/packet
>   Diff: 11.42 nanosec
>=20

Oof. Yea, thats not good.

> Using perf stat I can see an increase in cache-misses.
>=20
> The difference is less, if we read-packet data, running:
>   - sudo ./xdp-bench drop ice4 --packet-operation read-data
>=20
> XDP_DROP (with read-data)
>   Without patch :  27,200,683 rx/s =3D 36.76 nanosec/packet
>   With the patch:  24,348,751 rx/s =3D 41.07 nanosec/packet
>   Diff: 4.31 nanosec
>=20
> On this CPU we don't have DDIO/DCA, so we take a big hit reading the
> packet data in XDP.  This will be needed by our DDoS bpf_prog.
> The nanosec diff isn't the same, so it seem this change can hide a
> little behind the cache-miss in the XDP bpf_prog.
>=20
>=20
>> Without xdp-bench running the XDP program, top showed a CPU usage of
>> 740% and an ~86 idle score.
>>
>=20
> We don't want a scaling test for this. For this XDP_DROP/DDoS test we
> want to target a single CPU. This is easiest done by generating a singl=
e
> flow (hint pktgen script is called _single_flow). We want to see a
> single CPU running ksoftirqd 100% of the time.
>=20

Ok.

>>
>> I'm not certain, but reading the helpers it might be correct to do
>> something like this:
>>
>> if (unlikely(xdp_buff_has_frags(xdp)))
>>    nr_frags =3D xdp_get_shared_info_from_buff(xdp)->nr_frags;
>> else
>>    nr_frags =3D 1
>=20
> Yes, that looks like a correct pattern.
>=20
>> either in the driver code or by adding a new xdp helper function.
>>
>> I'm not sure its worth it though. We have pending work from our
>> development team to refactor ice to use page pool and switch to libeth=

>> XDP helpers which eliminates all of this driver-specific logic.
>=20
> Please do proper testing of XDP_DROP case when doing this change.
>=20
>> I don't personally think its worth holding up this series and this
>> important memory leak fix for a minor potential code change that I can=
't
>> measure an obvious improvement on.
>=20
> IMHO you included an optimization (that wasn't a gain) in a fix patch.
> I think you can fix the memory leak without the "optimization" part.
>=20

It wasn't intended as an optimization in any case, but me trying to make
it easier to keep track of what the driver was doing, but obviously
ended up regressing here.

@Jakub, @Tony, I guess we'll have to drop this patch from the series,
and I'll work on a v2 to avoid this regression.

> pw-bot: cr
>=20
> --Jesper
>=20


--------------jIDW19T210bV0ebe3ccfcT5i--

--------------I9JFRWX4P9t1vbk0bk1m4vPi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaKTWRwUDAAAAAAAKCRBqll0+bw8o6EaO
AP9KH7zT9duavHEew+Mai9pIe1YcNyp1PdeplZ0af+Xv8gEAuAHY6+TIFqONk97iJOt+EP2g7vCn
lH8X7bdqYzC2pgY=
=G87V
-----END PGP SIGNATURE-----

--------------I9JFRWX4P9t1vbk0bk1m4vPi--

