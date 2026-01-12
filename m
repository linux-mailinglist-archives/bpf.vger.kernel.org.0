Return-Path: <bpf+bounces-78542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5CD1250A
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 12:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459A2308739D
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFA42D8DDF;
	Mon, 12 Jan 2026 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hvc5m2Px"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072913563F6;
	Mon, 12 Jan 2026 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217482; cv=fail; b=Pzkw8vUuYl1t1kRxh+ztyW4bHB0eCWSLDapy4+6xmdCgs3jxXHBXWLrYS3WuDmQ10EmvATfYrljOY15JB1KPmestA9MG5k0WlcZWeW6U9D/C2kYQ6BET7FvUlqWNc7DDsyHlmhhM5GesAk8C4kwTa9lyLvJmo/RCyhAbEkhv0Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217482; c=relaxed/simple;
	bh=hhAlMcve0AF0c2VvzYpM8V8e9E0YorwRaHmYebyoI/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mMjqPhhSukq5jYVaHkLwtqIfT4LnU/RFu8Q4ntdZcmyPx4vSPZ4KavA+3hkHNJGl6IxSkwJM1B5VvFc/zYMEL8sQ8ePs4+tVqxIBE5e/QlpYJ0KMUzYv4TgoJxxBMgdGrHkbv7dIr34TI3216tM2AT8y5JniGi1zVo89LrRHZq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hvc5m2Px; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768217478; x=1799753478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hhAlMcve0AF0c2VvzYpM8V8e9E0YorwRaHmYebyoI/k=;
  b=Hvc5m2PxsHhtbYSumFIO7eyecNpvdh0iovL7wsthUKHiRRbi+m8Gg/m1
   8OC35axlIXw8Tw3vhI5NvHMkc7kuEWQN56/p9vIIvdrogwsZVWQcJxsVu
   sBmCAMpM12Mdu6PNJVPrDIYX61RvMydFz+OxokjMy6kmijrWM5X/ez92q
   In7DuQ4238xYX0dgPhW+7i+zEW9IZTDF1YL8v3CtFmEoLN+Fn9VBaFJjl
   wJjlWEr41aASzRPYvEWKeSvQJnJO3lqiNExJfYi1+S5kChveZV2FLRUkY
   BwGKvG7/QY/L/FAf+DfX1EAeTZs5kqFL0ZSOwiyFzFL+VNRX8meFB0Fnv
   A==;
X-CSE-ConnectionGUID: O/K5mH0mQ/OAfPf7SY81LQ==
X-CSE-MsgGUID: ZDsjBcwhTsalssYIxR9eCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="73120317"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="73120317"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:31:15 -0800
X-CSE-ConnectionGUID: o2QZ5u1dRgCpqwtQA/Oe5Q==
X-CSE-MsgGUID: tDr4Zip5RqCdJzXCCcY4Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204752213"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 03:31:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:31:13 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 03:31:13 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 03:31:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiJm15dIt1eXAPAADYtOvJ3TrDHi3pcjvV3DqjNVHj3OSjwlQv9Y0GprTM4gaHlbDY2YfuqtApweRYX3NWEQD23V1r+/aznETEOXB58oaev1yrnJ11VXLBG9NXp+CkouUIMSxUM15lOw0UHddSXUxm3oBfIYo9Gbd3FE6zuhvHERMzm7VvLba/JlkrAJnI7Gv4Rjc4j4yTFK/LxHQunFzSw9JXk5d3Av5h40X4Sn0PGJu0fHkTAoaRYdybKq47urTdFGLUAPZePp8OJwDjX7kRZlY/gjQ1R769LK4rX1WYHzjmrWZ+m7izyFF8dh2LeEVHWlHE9mtX69DotVrZWMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhAlMcve0AF0c2VvzYpM8V8e9E0YorwRaHmYebyoI/k=;
 b=q/NbpSSw76Ny0dPSmQ0h+Pc7UCQQ/bbaEl5p+Y1OatQuLFZv4udywy0c3NCDO2srzT33qq0PuawDv3pWk6qb51J+QGwgY0VXiZTMuIZCg5BqE2JCLi4WciG4xSv2dBhyF6J8VBH/8p9Oiohlt/l9uLr5DmC5RnzKKIZCA+ihdP70eRI6Vs/GWCv2f6ok0gqeOGJGK0QS6Pjdo+/2vmLlciHORRLPOw1VLLVbyefTszj6ogyvjd9G+XFTmoofObwne7U07DTnz0o1XVt29w2r9/3tUz+gPhxFeNfsJJJAfiZlsqKA0yPjJXWq93tkKCDB2uWNZk20eGHQ0fsGLUDhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH3PPFD6B8A798D.namprd11.prod.outlook.com (2603:10b6:518:1::d51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:31:11 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:31:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 04/10] igb: Call
 skb_metadata_set when skb->data points past metadata
Thread-Topic: [Intel-wired-lan] [PATCH net-next 04/10] igb: Call
 skb_metadata_set when skb->data points past metadata
Thread-Index: AQHcgnTl3sToLRKVnEqA7s2ihJ746bVOaOuA
Date: Mon, 12 Jan 2026 11:31:11 +0000
Message-ID: <IA3PR11MB8986EB1D8857ED6FAC84DFA0E581A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-4-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-4-1047878ed1b0@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH3PPFD6B8A798D:EE_
x-ms-office365-filtering-correlation-id: 4515c817-be5c-49d3-c251-08de51ce1650
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aG5zY1g5OFBkNEFxVjU2dDdvd3ZNWGhVNmZ6K3Zhcm5GbkRJTVhzc1c2MTFz?=
 =?utf-8?B?WkRZZzVQMU1XeVUyMUFscnI2Q3VxVVpJQTJXaW5LWEozaFNocnVOaUxqdEFw?=
 =?utf-8?B?MWpOTGFIbVpSOE1CUCtRQ3pML3Q1QklTdE5mbjR5YXp3VnprM25WTXFvVm1Q?=
 =?utf-8?B?TU1sZFpRem5pWml4NFFBd1NJeXVESFdWSy9KRHJaTlZ4L1pDZzk4bWR2Q0g1?=
 =?utf-8?B?TWFvd0RWV0hSM3RROWg1UzI3SGpxcTJFVW0xbUVoY2xTekFJQ3o0RkVLVlpO?=
 =?utf-8?B?M3NIam45VlZWd2loZ253WGd4eFFLdGsvU2JOa2Z4V2hBUHczeTZyTW42dXVj?=
 =?utf-8?B?NU1WVkR5VmRhUnpBY0REbUl3U3ZLaWR5VjVyeElzMU5TVXFQazJQdG9tallW?=
 =?utf-8?B?aE5JREZ1aC9SS21HM29QbG55QzRuaGtUdVFId01ueHhXLzhiTjdpTk83WHJm?=
 =?utf-8?B?VXRoT3NNY1Mvcy9KMTZJZFVHaU1jVzNzWm50SFVyRTlhT28vRmhmL0ZBUXEy?=
 =?utf-8?B?MGYrb3ZWTVBYMWRZOTluRkJuM1BZVkJQaGFWV2hsVzZoQVJNMDNpVDZCcjVx?=
 =?utf-8?B?ZGdsNzN2akx6b01jL1BNeEgydlVyYWx6R2VGaWlGWGtzOXNadExJa3lTUjQw?=
 =?utf-8?B?czdqVWRPUDV4d1RXY3l2WmRoYUdrRStoVTZ0QTQrZytyN2tFT1lacldQODZF?=
 =?utf-8?B?ajNvL1JxT2hXTXRGbWZza1ZranJ0ZTV6bXRFVStQeEF4L3VrQmR2SHJOZ1RV?=
 =?utf-8?B?ZmU3SHZYcDdmekhad1ZKdStzVmFEK3FpT2xaeTd0TFZGRzJsU0QxeTNtRHhW?=
 =?utf-8?B?QTJrcE5Fcmh4bDBzUUxBUEI1cFpNbGJ5Z3kzKzU0b01YZmdlbHNFcDNxODZU?=
 =?utf-8?B?dmlTdXNmcGRzbHlidUd3RVptaXRCZ1JJYUhKSHk0U0JZVTFITVFKRjJsVTZB?=
 =?utf-8?B?QjdDTDJvdjRWUTNCNU90SkxRWWdUKzlkbVl4SjJLKzJBMTZ1UVZ3SS9SakZF?=
 =?utf-8?B?cjkwZGxsd3BtQ0kyd3BZaVNLQTVvbGNEY3VGcUhIRTlsVnBVU2ZLK21Ia3BO?=
 =?utf-8?B?bnFvNE9UbENtLy9aQUVWWVlDWGlFUlMvR1JmYk9xdWxqUTArTDROaGFUbjBG?=
 =?utf-8?B?SjQ3eTM4U2d5amhyM0lkV1dZTU5HbkdUMFVYa3pCKy93K0kwSjZyVHZHb0VE?=
 =?utf-8?B?VnZPallSbWE0MzJaK0NiNzFqVnZKRnVxMk5yb1p5MHk1TXZwcUp0QTNvMXRQ?=
 =?utf-8?B?QlFORUV5dm9PR0VZaElXK0RBTm1VWDZIeEtPbFloZnRtQ2pRdTlrNUxLODdS?=
 =?utf-8?B?M3dDL01qWWhCbGNDVWhTcjBaU1lpY3UzcTNKTjdNRE14QlRyTWNIbjFVc21J?=
 =?utf-8?B?Wm9QS2M0RWR0ZVh6UHNZNmhwMHNTQkZwZ1QvbVVuUnhCQnVua2hZbjd1bUFM?=
 =?utf-8?B?NVk5RUJPL3owaEpmQVRadnhKaHhzUCtJZEVoNm5RRC9VSTBwTkJnMTdqdVlK?=
 =?utf-8?B?dGJtY2xSUFRtdHpadXBXWndLcUY4VzhUTkNKTHNVb1dJWXJIWGh6VEJ3Kzho?=
 =?utf-8?B?NmhxYm1IcFVJQlhia1ppQlM0UnhobFQxM21iejNpVWpUUnA2UWFMY3N5ZU01?=
 =?utf-8?B?NmpkL0NTOVY1N3VKd2FYeXNlVkRUVUdBNFN6YkRpWDhINkZmOC9JMXpkZ2Fj?=
 =?utf-8?B?WExOSkkvL2duY0hmUllDRXpmL3V1NlgvYVY4UmJ5WEFUWTdnTFFyeG9sOU9i?=
 =?utf-8?B?aDh3c0U0OFRmZnJtTkpvY2JWMkROZzZzSVZoT0RNU05qMUx6ZzBmdXc0ODIz?=
 =?utf-8?B?aGJtbWlNY1dtT2c1dVRyZ24yVlV6MlFySEk0SWd0STAwWStUT2M4UThLUjg4?=
 =?utf-8?B?cmgzcDBNTGsxU0JMV0trRFY5SGE0eU9zTzNBM0gyaXRHeUxhUzRBUXhxK3Qv?=
 =?utf-8?B?cUhlTFN0NWpEU3lwTXozSDVidXBXYlFZTWwyd25vMkdBSUd4cHpneG5JdzhG?=
 =?utf-8?B?MTJPSTM2Tm9maThjS1VMK2c3RTcrMjBsdTl5QVRHOEdPWmRaU3BuOW1MUWhI?=
 =?utf-8?Q?kqxJUh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFJSbHdHVzVxVjl6R3gxVzEzaWhtNGlldlJpNXBocWgvSUNJeVBQc3lUTmp1?=
 =?utf-8?B?T2FraDRJSERDS2VEK01GYXloRzNWTzdLNFJjVnlSZFFOcGJqVnRQSGpHME1l?=
 =?utf-8?B?ZVpUakNJYWdUUjlZMGh2ZjNoR3IzZkl3S2lGSHNqaU5FeThOaGFDdG03eG1H?=
 =?utf-8?B?cEE1VlBYZTgweGI4S25Ja2NaUVhoR2laR2U3d1NmM0h4aTNYdTdlSzBoeVNz?=
 =?utf-8?B?TDhrdlNkcXNWOXk3ZFUxZmt5emZjTXZpV2J0TENCdWIxYlhTYU9aNndLbjhW?=
 =?utf-8?B?TDlqRXY2K01EWi9OTUM5cmNKeXB6bnE1c1BnN0JNd3h2WjZXSWFuSUduV1pI?=
 =?utf-8?B?RDNCbzFTSlM5Y0NaWXRTT3BFT2xvL0ZRYlpuV2dEWjl1aXJvN21DUTRaN3Jp?=
 =?utf-8?B?NEhlalg3TG9mNmE5dStrSlhBOWJBRE5va2VwQUtsZmtNYUYrRE5pbm5IMStL?=
 =?utf-8?B?Q2MyNEtjMjcrUHM3KzNzOXI5UmtVRFIvRzlsUENVWTRicWQ1dnZQQS82L1hu?=
 =?utf-8?B?QjNKUlNYTlBGR3VJcWRDRUtJc1Q2UFFzaHMwb3dwTy9FRGQ2aTNhVk1Pa2V3?=
 =?utf-8?B?aWFjSXA4ZHlzRXNwbUtzYlFHUU9xOHh1cDBDSzllcHpGOXdmTC9IbllMMnFx?=
 =?utf-8?B?Yk1XeDRscXBUeFR2WnkvR2xQMkovZ240SUlhaXhwdm5Rbmo5aWp5U21sMUhu?=
 =?utf-8?B?UGtWbWlYZDN3Uk9HREFvQ09RdFdRU1JXVEVqNTFROFlMTEh2WGdLZkMwK3pz?=
 =?utf-8?B?ZGwxYzFKc21IempoalBERUoxTTNYMVBMUjlSUERhNmZnTi9SanpYMFRWdGNu?=
 =?utf-8?B?WngwV2gvQTdXam94R3VYdmgvc1hqL3ZObE9GODA0ZlBxSElJN1NKM05LZEIz?=
 =?utf-8?B?M3Z4S2gvVzZPYWx0ZE16ZExKNDhabTNIVkRCSkU0ejdsdEJtK1JDb3FpeEdp?=
 =?utf-8?B?UFU3QStaaW80b1k2bTFDWmNISWZsQzBVQUNCZHlKUFRaNzJ5UVFHUTA0ajBW?=
 =?utf-8?B?WlcwK1RKQjRZOVlweC82djRTMXQwblB2bnFOWTlJdnREem92ZlVjMWRxejRE?=
 =?utf-8?B?TkI0d1JBbGMzNlZkcWR0ek1NR29abG1XU0UzZnBXTjRQM1hncTlFMG5xdTVC?=
 =?utf-8?B?VzhKcy9kWUp3STNkM0NwN0VUMENmNUdod29OOGtSaWNSVHdvYlhxSzR4L2JP?=
 =?utf-8?B?STJrTHp2YlFJbGMxR1JMZ05vd3dpMkNOazViOGpFNVk1UWE3dHAwYVVBUWRS?=
 =?utf-8?B?OTl1eHFuazJwN0puRzhOUndnMGZqclNjeGY5K1VCYU9HNEJHZWJxUWIzbE93?=
 =?utf-8?B?ZFowR0NrM1V0TWQ1d3Jkais0ajVLN3htVm4wdU9GTVhBaUdhRWp1STRmQllI?=
 =?utf-8?B?OC9IZ1dpdTJVUWtJd0dMVm12MlFBY0hYdWVtbGZvbXA4SC9pb3hwUmhDVkdB?=
 =?utf-8?B?dlMxajc2VkJDZlJVTUJKcU1IcWtLN2JuNjByczhUV2JvL1BJM2huUzdTZkJ5?=
 =?utf-8?B?L0JRMjR5cENIU2ZLaVVrYnNRb20rMDNFZnpCWGFNWVBnUHZkMUh6UTc2eHRM?=
 =?utf-8?B?UndqM1JyRUxxMFhGc0hpVkpna2g0UUVjbUJQZDRDeHhRWFZSRzFteEltRis3?=
 =?utf-8?B?VmM3V01vZExhUTBFVWkrWmw5OHFuN3h3YnlkNUNlSlRvalpmQzh3aHhiNFFF?=
 =?utf-8?B?ZmZKK1VYVFFkcDhQYVc2TExQNWd6Mzh4dkxlL2UzN1h2dGNlbkFoN1N4NklS?=
 =?utf-8?B?WXVBRFd1cHpudFQxalhNcXVVbzd2b3BnaUdreS85enJUUlRtQVNrbm5YaENU?=
 =?utf-8?B?dTIzK1N4RFY4aWVudGtnWUtENVJvb3V2RFNPYW1BZU1NcmEwNVp4Y0hVNXpP?=
 =?utf-8?B?UzNTOTcxanFVSitFTEJHOU5CN0hyd09RYUN0SStpNXgxV1hHQ3FDSzN4RjZR?=
 =?utf-8?B?NFJJNE1pSklobjUrTXJpVTMzYzhBZC9wTEUvZGk2NW53QzFVWUNFd2FxblNQ?=
 =?utf-8?B?ekxaMWhIOVBhaEEyZ0h0cmd2T1BoV252QWJJRHUzT1hhZXN3bVFld1V3RFQ5?=
 =?utf-8?B?eWNiNjl4RGdzTXkwc0k0dTQwUUlxKy8wRytGaml1aWFVMnlpOXVOSjIwVEZm?=
 =?utf-8?B?NDhPZ1YxdVRZSkNrZEd0VUszZ1VxMFJFWkIycFZEMUlGVjJNc3JyTkhPNW5Y?=
 =?utf-8?B?SXFadVc3dGNrYVBLVWlvSC9XaWVuMFNaZmFlaGJuS2xmbGYvMWx1U0EvT2tP?=
 =?utf-8?B?Z1NjS1AzQzQ0YWs2a0g2Z2dSTUlBVXRLbzJkMmtyZUdWSTJMQ1BoVUV3eXMw?=
 =?utf-8?B?dDMrUFpsSFM2VlU5V29qM2JQbHJzUXlmME4xeUwyL3RRYVVrMEh0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4515c817-be5c-49d3-c251-08de51ce1650
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 11:31:11.2137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wf0Mn9wv0GoyvWMayGoqCt88zMGt8J8fwQXvbAxNttTxeW3WLQaTux0yx/Y1HGf/IE/42b4hqA5TqhBjPRQAC2mUKgMd2yQSj4yPEbTPf+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD6B8A798D
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFr
dWIgU2l0bmlja2kgdmlhIEludGVsLXdpcmVkLWxhbg0KPiBTZW50OiBTYXR1cmRheSwgSmFudWFy
eSAxMCwgMjAyNiAxMDowNSBQTQ0KPiBUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzog
RGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxl
ZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz47IE1pY2hhZWwgQ2hhbg0KPiA8bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbT47IFBh
dmFuIENoZWJiaSA8cGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbT47DQo+IEFuZHJldyBMdW5uIDxh
bmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5n
dXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6
ZWxAaW50ZWwuY29tPjsgU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBudmlkaWEuY29tPjsNCj4gTGVv
biBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBUYXJpcSBUb3VrYW4gPHRhcmlxdEBudmlk
aWEuY29tPjsNCj4gTWFyayBCbG9jaCA8bWJsb2NoQG52aWRpYS5jb20+OyBBbGV4ZWkgU3Rhcm92
b2l0b3YgPGFzdEBrZXJuZWwub3JnPjsNCj4gRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFy
Ym94Lm5ldD47IEplc3BlciBEYW5nYWFyZCBCcm91ZXINCj4gPGhhd2tAa2VybmVsLm9yZz47IEpv
aG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+Ow0KPiBTdGFuaXNsYXYgRm9t
aWNoZXYgPHNkZkBmb21pY2hldi5tZT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3Ns
Lm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsga2VybmVsLXRlYW1AY2xvdWRmbGFyZS5jb20NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDA0LzEwXSBpZ2I6IENh
bGwNCj4gc2tiX21ldGFkYXRhX3NldCB3aGVuIHNrYi0+ZGF0YSBwb2ludHMgcGFzdCBtZXRhZGF0
YQ0KPiANCj4gUHJlcGFyZSB0byBjb3B5IHRoZSBYRFAgbWV0YWRhdGEgaW50byBhbiBza2IgZXh0
ZW5zaW9uIGluDQo+IHNrYl9tZXRhZGF0YV9zZXQuDQo+IA0KPiBBZGp1c3QgdGhlIGRyaXZlciB0
byBwdWxsIGZyb20gc2tiLT5kYXRhIGJlZm9yZSBjYWxsaW5nDQo+IHNrYl9tZXRhZGF0YV9zZXQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYWt1YiBTaXRuaWNraSA8amFrdWJAY2xvdWRmbGFyZS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl94c2suYyB8
IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfeHNr
LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX3hzay5jDQo+IGluZGV4
IDMwY2U1ZmJiNWI3Ny4uOTIwMmRhNjZlMzJjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZ2IvaWdiX3hzay5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lnYi9pZ2JfeHNrLmMNCj4gQEAgLTI4NCw4ICsyODQsOCBAQCBzdGF0aWMgc3RydWN0
IHNrX2J1ZmYgKmlnYl9jb25zdHJ1Y3Rfc2tiX3pjKHN0cnVjdA0KPiBpZ2JfcmluZyAqcnhfcmlu
ZywNCj4gIAkgICAgICAgQUxJR04odG90YWxzaXplLCBzaXplb2YobG9uZykpKTsNCj4gDQo+ICAJ
aWYgKG1ldGFzaXplKSB7DQo+IC0JCXNrYl9tZXRhZGF0YV9zZXQoc2tiLCBtZXRhc2l6ZSk7DQo+
ICAJCV9fc2tiX3B1bGwoc2tiLCBtZXRhc2l6ZSk7DQo+ICsJCXNrYl9tZXRhZGF0YV9zZXQoc2ti
LCBtZXRhc2l6ZSk7DQo+ICAJfQ0KPiANCj4gIAlyZXR1cm4gc2tiOw0KPiANCj4gLS0NCj4gMi40
My4wDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25v
dkBpbnRlbC5jb20+DQo=

