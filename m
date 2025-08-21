Return-Path: <bpf+bounces-66241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111EDB2FFFE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 18:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E96F7BB534
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DC12DE6F8;
	Thu, 21 Aug 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIZfm0Pn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04F224AFC;
	Thu, 21 Aug 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793652; cv=fail; b=Tis+oODXWjZej7flT3/CL7vJkeUdB7uLQqaVNDvr5mRvsXQngm7Kq8QobBbIr6vZwR0rl6kDbIXawcngTHiksP4erqxtOsGCUfZZT9LixiIlxFgfYuG6NyTF6oM+46UAld2TzF8zaKuyoK5KVtJMXYV2apcD9S9UObtZsml5p7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793652; c=relaxed/simple;
	bh=TCErlFZl7ViJxAn9rZIuT7mQvlaAd0Ri/LkEU9Ldkj0=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZADNd7F289ei6XqkIz+snbbpAXdCnVPr+oX6n2HqKLIfWaBsukS+jCgAOZxhu4FJwxuugxINDGtm7A14BmDaJhXYnneBLMYGcXHvr95TFYv2JONBumluO1Ok+kMGQX+ZWoCbYsuqOuzitIwCIPidfXC0RHT8AZl9jDGTjj3CeZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIZfm0Pn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755793651; x=1787329651;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:mime-version;
  bh=TCErlFZl7ViJxAn9rZIuT7mQvlaAd0Ri/LkEU9Ldkj0=;
  b=EIZfm0PnblE6R380oUyWN8N4tmYLHf/vo9WE2iGzLXTKve3/2QhCFxEf
   +ysV6klLY14OJf6uNj20YsnCm/YoCFAkv+7uXgGqoAZDli9huaSqwxq6a
   NYnyxXjn4uoEgJ2ftWfG41U9s6brrv60AwNT6W3qqosiW2vSI87lRvOAz
   rKXl2t6mHbQzKcs3SoL3pOwDe9KdRbWM6GazL1zXbtJaDnsVR2dI4ALzg
   Uoq+a6SmZN/9O/R4wE8f71CW/oa/Gr8gIiCCMNL8fQHiw33CsQRNgV5e9
   dyeEJjccWt6UvGGZWlVeN/A5TTcV5MHG/NFQIyXnSh/aY89iQ0GrBNzcO
   g==;
X-CSE-ConnectionGUID: u+W4kbfHTfWjFokzEtfUKw==
X-CSE-MsgGUID: 4aV3R6AuTjykh83olwSGlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58158672"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="asc'?scan'208";a="58158672"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 09:27:30 -0700
X-CSE-ConnectionGUID: kd8M1SKFSB6lYzDr33zzlA==
X-CSE-MsgGUID: 5eSvpNMcSWu+UDSUSXbwMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="asc'?scan'208";a="173790096"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 09:27:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 09:27:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 09:27:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.56)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 09:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+4P4FjJQh3ljsr66bNbMdDmyxaXqvwJgLVzyK1uxWnC/oZxeLj5grM3kK17AJNrVxj3WcWjqJwF/9FPW77KKvquNrpPrF9ZQY2Jpgwic9rwnhGI0rudQrBlNJrLQb2akSjzVZV5Xd4S+kZ6XLPXZrQwhcH7QtOFcvmbm2i8goReKIvUYWizW1IvM3qquDF8A9wvkQjoAaB0cVvmuxreFS595czSoaGFKnDi01OJlaFT0pYNph0ReApEqe4s3a5coiUwCHzwkjioqM27ta3BnZBZp7MzXvxSthxP1icaq6TxuV8vC70xu6/gESNtD//IYUCXtfW1IAudlmu4OhQFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD04mf0EhDRHUEr+7q1HAQShqeJRqzARAzsWxRIq+oY=;
 b=EXiWwf2uG1U+ERoeNeDMK5/GES5qgfDXeQZCGfIcKwm04P6EGAm7Qy45o9ma5MVMR8aWU9vszRh1D7ffSgzntyPJ3gFpnYyG6JiA+af4EjXY+7qM1+zR7XUHZUWrurXpBKmBvZ2DHADcG6he2A/hr5B7FqASnG4VElL6AwizljhksE5ThcuX8vnxMF6GWE7xUGMILZX87obHh27Hgz+4wqDqJt2IVYxiqVD1xKvNuODAM2PCtjSKyZqF0YBbAKqDa4j/iE76Ou8pGpRrMemu0wNqZkOXujBvoT3gORKGnynUuERHk1PSBQ/zst+bDzv5PazS0gdbqVqiIKopk4Ffhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Thu, 21 Aug
 2025 16:27:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 16:27:24 +0000
Message-ID: <24f1f083-92cd-4576-ac1f-2c53861ebc3f@intel.com>
Date: Thu, 21 Aug 2025 09:27:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] ice: fix Rx page leak on multi-buffer frames
From: Jacob Keller <jacob.e.keller@intel.com>
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
 <9f9331ac-2ae0-4a92-b57b-d63bac858379@intel.com>
Content-Language: en-US
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <9f9331ac-2ae0-4a92-b57b-d63bac858379@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------OIxOs0yckFctxbEsTtd10jBK"
X-ClientProxiedBy: MW4PR04CA0335.namprd04.prod.outlook.com
 (2603:10b6:303:8a::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: de8e6a34-695a-47ff-f08a-08dde0cf9c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2J4L0w0TE82bWI2d281MFhkWDZZTVlUam9XREdLU3NxYWEzd1ZwZXBzNkw5?=
 =?utf-8?B?T2FoSVJhdDFoMzlQNVJJaXNnV1hWeTRxQWhHdjRlbWc2dWJ6c1ZrWVRGQ1dj?=
 =?utf-8?B?NkJXR1B4QWVNU3VjT3NtaGJqMnJBRVh6d1FMTU04NGJQR01JWThsVWtqU2Nv?=
 =?utf-8?B?NjJHUDdrdnhPUGM5S1NxWGF3Rm9EZ0FUMXZOQTNXL1JWMitsb3pISU0yeTFH?=
 =?utf-8?B?SE5DQUNLWlNXS0lyd29sWXdheFR6aEtiTDh1WUhxSU40Z0tqSEE3cFRQc0d5?=
 =?utf-8?B?Qk5TbEYyTXRuVk10SThEVWhlZGtwNDZLK3RSd3BVSFJSbzF6alhKTmJTOVFi?=
 =?utf-8?B?SmJDaFBtMkRGUFB1UjUzKzI0MnVFUE9aT21RalBzejFXL2l4NForanhFQ0sy?=
 =?utf-8?B?dlVnVE51ajJMd1FEcFhyTFNCcVNXaVc3RHNCZ1paMCtBM1lPa1l1Vm1TQllB?=
 =?utf-8?B?TVhDQVhzV2dBT3VjaktnZW5JQlVUNy9qenJrU2FvdUZBMHIyQVI0dG1RNlFx?=
 =?utf-8?B?aFJqMXRHaTYyK0o3NGxkODliaTBEWjAyTlJpbHQ2eFN2QkJEblB6bngwQk1z?=
 =?utf-8?B?NFR4Uks0VlJDUXI3TjRjQlhrdXF1UEFua2NGaGxZcktjeG0yU1o5MlY2Qmww?=
 =?utf-8?B?Z3FSd0x5NG94VGpzU1IveXNvYXdleEN2SzgzdmphMzQwMzljR3VnZWRIUGtV?=
 =?utf-8?B?VlV4UjIxR1RDbExVd3Q3NXpPY1dKeDl6RzEyOHlqVGcrWktNNXFzeEN4YkZq?=
 =?utf-8?B?SU9JUnI0OUwwRUNIQklxMFNrMGFrU0hPNEZNSUNvKzFjcVY0d0hOU1lnd2J4?=
 =?utf-8?B?cTRCUXErb0IxU0F2cHFDaml4QnJzeTN6MXBHcndOcEhsaUxxKzN0ZGFrQlZ2?=
 =?utf-8?B?VVpTSHZrZkUvZFBGMlpUVTFWRVRNNmNiMmxTM01rSEswUmI2MUs3WFBYcW1U?=
 =?utf-8?B?c3U1eEdhT01yRWtmUDlTeDVzb3RuUlYvZzFLZXJ2VGZySG5DZkF2WUxWOWhS?=
 =?utf-8?B?MjJtdUNUbnBkZHdRU1BwamxGNy8rM2NWRE1Za3VlZmdwT2picGRmRk1qWUxD?=
 =?utf-8?B?Vjh1NTVVY1VaYnZDZ0k3REZ3eTdPV0RvN3Z3K1RBVEpCcTh2bjFUWDZEc1JH?=
 =?utf-8?B?N3c1UDVvRXFJenBUMjVYRFBPREN2Y1hBOXI4NVNtNm4yalExVjlrc2tOWnZG?=
 =?utf-8?B?dW5WWDlhYzVTak84cHR0WjBnMDNEaG9HNjVTYlViU20zRGNRVjA1TVRkTWtL?=
 =?utf-8?B?RGdZZ3RxUjNiN29wOFB0VlVaTm5pVVpSUnJBaW9qZzMwT2tDMkEwaXd3RDhQ?=
 =?utf-8?B?a3p5UXZndTZXSUxEWUM2WDdiTkcyQWp0ZnkwK04ycnJnMXVaRE9wVnpOTkZl?=
 =?utf-8?B?K1NZbVk4VjFMYWlZTllQbTMvQXFPazNOKzBrZjZ6QjhtMmVKTHg3M0RUUnlu?=
 =?utf-8?B?d2d3L2FCeUtPbjdKY2tuRzJRbXU5dFVMS3Yva3RQc0VpdHcxU0owYVpVVEYy?=
 =?utf-8?B?WWhsQmRxaTM5UE5KTWx3bnZqS3VnMHU2SnRhd2ZIS0RFbUtKMk51UDF2SXpQ?=
 =?utf-8?B?Sk9xOHBrS3BYS25mUTBRNmF5S2t3VWtuZUJFYllzQnVNekNpeDVWaVB2Wm03?=
 =?utf-8?B?bmxMMVlleVk1c0tQSVBsMzlQZWdTZlNlcTZIUGsrMk1mcW1oai9udkExMXBJ?=
 =?utf-8?B?OWVuY0VmTnRVMHJ4c0tYNUV5RXhjR0p1cDNPUEJVTjZzbUpIaVBNcXJIOGQ3?=
 =?utf-8?B?eDlGanBleXV0Z3BDYjI3VlhDOUEyNGJVZnZDdzdhMzg3R1d0NzJrc3VmR1NK?=
 =?utf-8?B?MVc5TWw5RjBod3NMc1FxWG1tSENqTzQ0RFlFdzRVNzZhdXAyUllGVFQydDRC?=
 =?utf-8?B?TERSK2I5azZ6eDBOcTk4U3V3Z1lrRlgxOG1VaWprdndOaDhzTnd5Y3RSYkNv?=
 =?utf-8?Q?ZHMAHdO524Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1BiMExhbmdwcm56UEFHUUoxbWxDdncraGVMdTc2SG9RUFYyelE2Qk9CUWlw?=
 =?utf-8?B?bG1hUVIrNDZBY29KbGtHYUN6U2hJV3dwVGliK2FwNENwWTZOVVIybVo3bGpS?=
 =?utf-8?B?YWRBT1lzSzQrUTFsMFk1LzQ5WHdJSEZRTkdBRDVmNm1BNlg1cnZsUVlCTmtz?=
 =?utf-8?B?d0pzOElDRmRaL1lUS2VhSHVEWDZrNHZYR2dlcWFnUjI3cFpkcUEzNFJRTnYx?=
 =?utf-8?B?ZzI0c3I1MDVuY0RDQ2x5VXVPOStGUVRoRm83dFRzZkVpYXplc1B3MU90RnhX?=
 =?utf-8?B?VDhROWpoZ3NhcmFHaHlmQzdhaThSdWw1V2t5RURWcE1TUlVYOXM1K1lHZE5H?=
 =?utf-8?B?US9CazlHdW1YY1dIVWNOQjlKdW5RZ0JVbEI0UWdhZzVjenpsZFdMM2NUWXhr?=
 =?utf-8?B?U2hyWGdycVJBTUJOTElsY1drcFJPckZxV3lzMXdRaEk3eTBEenpSMFNqU1hy?=
 =?utf-8?B?Z3hBT0RwNkNvWWJLRTF5bE5vQTJnaWtMM09uMXhxLzZha29IUWkzWDlzKzFl?=
 =?utf-8?B?UVFBMzRsSXBNb3ZPUEsrRUtJQzlTYnEwc0Q5RWdidmlrMWxaMVdpL3kwM1Zy?=
 =?utf-8?B?VG9LaHVUOUs2UUtWbGJLTFhZZjZaMC9kNDU5L3ZSOUduZlFLUlBOZmw2QzlS?=
 =?utf-8?B?ZmcvazZwV3FXcnF4d3piUzA1KzdWeGV1bExWdVNWSTd4QisrcGpEL1pnVU5N?=
 =?utf-8?B?VDNrRnBqaHh5aXpBdUQwODhLb3QzdDlMV3VyTFVTZkxKeWlGaTM4T2Q3MGg0?=
 =?utf-8?B?MEJNOTRBbThId3d6blpQUllFNHN6NmpZUTdValNHUXZWSC8zV3dNdGFLc2Q5?=
 =?utf-8?B?elpVSmFBSVdLdkF6R0tVdG10Y2hmTW1wWXFCWUE1bmQ3dXRic2N4Ri9yT1Bj?=
 =?utf-8?B?TjZjK0swZ3F6ZkJRYnJIdEFmWnRlWTBoSFhkdzkvN21wTmxESk5kSk1rTVhO?=
 =?utf-8?B?ZmJkcklWL1FVWWpROFF5UnUwRU5qVzlGdFNDUGowNnQzdXJlbWpHVUk0UEtS?=
 =?utf-8?B?NnhhOEhvcTBCci9LcDJ0OTRmVXkweTVrc3VkY2dZRnRFSjhTYWNPK1Qvd3pQ?=
 =?utf-8?B?U3lZSTZ4UWc1S1NBbG5oM2ZDaVl1ZnZ6ZDZmY0orNFJsZDllVlNJdUtrbmZS?=
 =?utf-8?B?M0hLQjBZaEtXM1dKVHgrZERSTnU1aXI1MUdPbWlZemkxa2RKSStiVUVlUHVI?=
 =?utf-8?B?bnRjUkVsRFlNVkNIcWFUNjNnU1lYMDdYdlBobFBlSG5acU1xSml6UmhKWjRB?=
 =?utf-8?B?ekpZMmdvb0RRK1dST3VnbWJLVGR3QmJISFhHTllPWkZBOXVRR25XeTQ2VnBK?=
 =?utf-8?B?TS83d0ZQQU1DdkhNeXpLT3AweW9IZU5wWFplUlRSYW5GemFGZXhmVVEzaTk2?=
 =?utf-8?B?aEpWSzVTbW9XaGhYclhpZjFUbWRTbGhwdDRsQzhIV3dQeGtua2wyNnBVSTlP?=
 =?utf-8?B?NCtoQUdROFFEbHVJbjZUVU53VjVUWXNOZmhiNTVzWGM0UkVnUjVEc3dZT3pw?=
 =?utf-8?B?RzYyRlJLUVlUVHBBMExHQVkxckVZbFFJQWxOWHJmb2JvNlJFeXp3dnAwT1Mv?=
 =?utf-8?B?N2E1SXM1K3VWK0FwS2h4NUplZ0Nkd3Bqb1lLNEdWY1MvUlVnVWhiOXdncm1m?=
 =?utf-8?B?SEpMVWQ1aHI2dDdMaHNYeWc4YmFGaTlQU2l3MGM3YzFuNHpXNGJnazh3Y1hJ?=
 =?utf-8?B?UGNUWkpHcmlTVFNsenNSNmxZRWdyMk5NMnorcERxL1pZTDJWZmVYVUpIRjZq?=
 =?utf-8?B?cDA4R3B6UWRBL1Q5amVXcnprRWN6OXIwbmNWbGZEMUR3ZVN0Y3c5c2RrQkVH?=
 =?utf-8?B?TDRFMDFRR1BhekQ4UzRtYjRvSjNYL0VlRTQrcXkrdjJ3Vm5GYTRrRzhVRzVy?=
 =?utf-8?B?UEU5YmwzeUZCUVI4eUJvTFI0RUNXRGR0UWZpaXJ1Y1NkejFsU3R1RmxKRXBp?=
 =?utf-8?B?SHVtaFdtQjJqRnhzZHV5N1dLdlZKeVJodnZUSDdTbXRSbGtzbjVWbkpSQUx5?=
 =?utf-8?B?MS9EdFV2YmNvVGMvOHBBRmYwaXZzN2N1a2g2Y3lxR1lSVGRtVDBNT1FpTktT?=
 =?utf-8?B?OTZqUjJGQVRobGg3MEVkY242MkhOVDR2WW12QVhUdnFiN2F4M0JoTXVjMmlP?=
 =?utf-8?B?NlYva2hKTnNaNi9WMVFNeGRUZEIrRHkrdlNqYU4rMi80QTkyVXMxeVJYYmcy?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de8e6a34-695a-47ff-f08a-08dde0cf9c42
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 16:27:24.2505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKGsSmYRP2xinhyYFHUbGmPrd3biE6S2KaUuiGv63oCizuBW2wNwyk4oUdY5g+aYZGjDLVEgJE07QTIVg7LpdRsrDOPOQiCw+6pOZmPNrC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com

--------------OIxOs0yckFctxbEsTtd10jBK
Content-Type: multipart/mixed; boundary="------------LG9VdP1B13xcSWR8n540cToO";
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
Message-ID: <24f1f083-92cd-4576-ac1f-2c53861ebc3f@intel.com>
Subject: Re: [PATCH net 3/6] ice: fix Rx page leak on multi-buffer frames
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
 <20250815204205.1407768-4-anthony.l.nguyen@intel.com>
 <3887332b-a892-42f6-9fde-782638ebc5f6@kernel.org>
 <dd8703a5-7597-493c-a5c7-73eac7ed67d5@intel.com>
 <6e2cbea1-8c70-4bfa-9ce4-1d07b545a705@kernel.org>
 <9f9331ac-2ae0-4a92-b57b-d63bac858379@intel.com>
In-Reply-To: <9f9331ac-2ae0-4a92-b57b-d63bac858379@intel.com>

--------------LG9VdP1B13xcSWR8n540cToO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/19/2025 12:53 PM, Jacob Keller wrote:
>=20
>=20
> On 8/19/2025 9:44 AM, Jesper Dangaard Brouer wrote:
>>
>>
>> On 19/08/2025 02.38, Jacob Keller wrote:
>>>
>>>
>>> On 8/18/2025 4:05 AM, Jesper Dangaard Brouer wrote:
>>>> On 15/08/2025 22.41, Tony Nguyen wrote:
>>>>> This has the advantage that we also no longer need to track or cach=
e the
>>>>> number of fragments in the rx_ring, which saves a few bytes in the =
ring.
>>>>>
>>>>
>>>> Have anyone tested the performance impact for XDP_DROP ?
>>>> (with standard non-multi-buffer frames)
>>>>
>>>> Below code change will always touch cache-lines in shared_info area.=

>>>> Before it was guarded with a xdp_buff_has_frags() check.
>>>>
>>>
>>> I did some basic testing with XDP_DROP previously using the xdp-bench=

>>> tool, and do not recall notice an issue. I don't recall the actual
>>> numbers now though, so I did some quick tests again.
>>>
>>> without patch...
>>>
>>> Client:
>>> $ iperf3 -u -c 192.168.93.1 -t86400 -l1200 -P20 -b5G
>>> ...
>>> [SUM]  10.00-10.33  sec   626 MBytes  16.0 Gbits/sec  546909
>>>
>>> $ iperf3 -s -B 192.168.93.1%ens260f0
>>> [SUM]   0.00-10.00  sec  17.7 GBytes  15.2 Gbits/sec  0.011 ms
>>> 9712/15888183 (0.061%)  receiver
>>>
>>> $ xdp-bench drop ens260f0
>>> Summary                 1,778,935 rx/s                  0 err/s
>>> Summary                 2,041,087 rx/s                  0 err/s
>>> Summary                 2,005,052 rx/s                  0 err/s
>>> Summary                 1,918,967 rx/s                  0 err/s
>>>
>>> with patch...
>>>
>>> Client:
>>> $ iperf3 -u -c 192.168.93.1 -t86400 -l1200 -P20 -b5G
>>> ...
>>> [SUM]  78.00-78.90  sec  2.01 GBytes  19.1 Gbits/sec  1801284
>>>
>>> Server:
>>> $ iperf3 -s -B 192.168.93.1%ens260f0
>>> [SUM]  77.00-78.00  sec  2.14 GBytes  18.4 Gbits/sec  0.012 ms
>>> 9373/1921186 (0.49%)
>>>
>>> xdp-bench:
>>> $ xdp-bench drop ens260f0
>>> Dropping packets on ens260f0 (ifindex 8; driver ice)
>>> Summary                 1,910,918 rx/s                  0 err/s
>>> Summary                 1,866,562 rx/s                  0 err/s
>>> Summary                 1,901,233 rx/s                  0 err/s
>>> Summary                 1,859,854 rx/s                  0 err/s
>>> Summary                 1,593,493 rx/s                  0 err/s
>>> Summary                 1,891,426 rx/s                  0 err/s
>>> Summary                 1,880,673 rx/s                  0 err/s
>>> Summary                 1,866,043 rx/s                  0 err/s
>>> Summary                 1,872,845 rx/s                  0 err/s
>>>
>>>
>>> I ran a few times and it seemed to waffle a bit around 15Gbit/sec to
>>> 20Gbit/sec, with throughput varying regardless of which patch applied=
=2E I
>>> actually tended to see slightly higher numbers with this fix applied,=

>>> but it was not consistent and hard to measure.
>>>
>>
>> Above testing is not a valid XDP_DROP test.
>>
>=20
> Fair. I'm no XDP expert, so I have a lot to learn here :)
>=20
>> The packet generator need to be much much faster, as XDP_DROP is for
>> DDoS protection use-cases (one of Cloudflare's main products).
>>
>> I recommend using the script for pktgen in kernel tree:
>>   samples/pktgen/pktgen_sample03_burst_single_flow.sh
>>
>> Example:
>>   ./pktgen_sample03_burst_single_flow.sh -vi mlx5p2 -d 198.18.100.1 -m=
=20
>> b4:96:91:ad:0b:09 -t $(nproc)
>>
>>
>>> without the patch:
>>
>> On my testlab with CPU: AMD EPYC 9684X (SRSO=3DIBPB) running:
>>   - sudo ./xdp-bench drop ice4  # (defaults to no-touch)
>>
>> XDP_DROP (with no-touch)
>>   Without patch :  54,052,300 rx/s =3D 18.50 nanosec/packet
>>   With the patch:  33,420,619 rx/s =3D 29.92 nanosec/packet
>>   Diff: 11.42 nanosec
>>
>=20
> Oof. Yea, thats not good.
>=20
>> Using perf stat I can see an increase in cache-misses.
>>
>> The difference is less, if we read-packet data, running:
>>   - sudo ./xdp-bench drop ice4 --packet-operation read-data
>>
>> XDP_DROP (with read-data)
>>   Without patch :  27,200,683 rx/s =3D 36.76 nanosec/packet
>>   With the patch:  24,348,751 rx/s =3D 41.07 nanosec/packet
>>   Diff: 4.31 nanosec
>>
>> On this CPU we don't have DDIO/DCA, so we take a big hit reading the
>> packet data in XDP.  This will be needed by our DDoS bpf_prog.
>> The nanosec diff isn't the same, so it seem this change can hide a
>> little behind the cache-miss in the XDP bpf_prog.
>>
>>
>>> Without xdp-bench running the XDP program, top showed a CPU usage of
>>> 740% and an ~86 idle score.
>>>
>>
>> We don't want a scaling test for this. For this XDP_DROP/DDoS test we
>> want to target a single CPU. This is easiest done by generating a sing=
le
>> flow (hint pktgen script is called _single_flow). We want to see a
>> single CPU running ksoftirqd 100% of the time.
>>
>=20
> Ok.
>=20
>>>
>>> I'm not certain, but reading the helpers it might be correct to do
>>> something like this:
>>>
>>> if (unlikely(xdp_buff_has_frags(xdp)))
>>>    nr_frags =3D xdp_get_shared_info_from_buff(xdp)->nr_frags;
>>> else
>>>    nr_frags =3D 1
>>
>> Yes, that looks like a correct pattern.
>>
It looks like i40e has the same mistake, but perhaps its less impacted
because of lower network speeds.

This mistake crept in because the i40e_process_rx_buffs (which I
borrowed the same logic from) unconditionally checks the shared info for
the nr_frags.

In actuality, this counts the number of fragments not counting the
initial descriptor, but the check in the loop body is aware of and
accounts for that.

Thus, I think what we really want here is to set nr_frags to 0 if
xdp_buff_has_frags() is false, not 1. A helper function seems like the
best solution, and I can submit a change to i40e to fix that code,
assuming I can measure the difference there as well.

Thanks,
Jake

--------------LG9VdP1B13xcSWR8n540cToO--

--------------OIxOs0yckFctxbEsTtd10jBK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaKdI6gUDAAAAAAAKCRBqll0+bw8o6Hop
AQCMiAKRdWCinUuy5ZRDccYMy/zKdQ9jJXYdDRoyrQweUgEA9pFtjv3Rw16qrIQYPcB9RVUrZxlD
GgF9Xmd+QeC2NAM=
=5FjZ
-----END PGP SIGNATURE-----

--------------OIxOs0yckFctxbEsTtd10jBK--

