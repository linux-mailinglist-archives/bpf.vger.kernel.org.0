Return-Path: <bpf+bounces-29167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A278C0D81
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 11:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291D31C217DC
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC414AD0D;
	Thu,  9 May 2024 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjgaT9W0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2314A629;
	Thu,  9 May 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247099; cv=fail; b=G0mTyfs2aYeGsuFGEeUElK3vW6NQZK9TKQrtrcNvwwn2qIiqKg5Wn1A1D1om5OCkt14KSF62svBNll+t1javcEUwrAPux4iHt7E39DSQrMV9jZp0d4U6N45kiibnaMvIMCWRd2cV4Xz3HOSkN47gluWDn4FeeErEjhFFyzDEdEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247099; c=relaxed/simple;
	bh=L5Jtgp9NcX7p/LkN4Ja2XvaZnbBH0iCPq4yd9vyIwUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kkz7HPCuzaTXmxtnwkNOUtUgpl3x2I+Vqlpw70naq+/pswx03j111sILYyJk4VNti8HZ6AzxMHJQF6phI5NPgmIRBz5nmwXt3/mrllXNj6wWV95djADoZDLgFFmEegQj9vHWthNA9T3ZSmYRXJPPnzcfBpqgbHcRCMGdAwOjpB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjgaT9W0; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715247098; x=1746783098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L5Jtgp9NcX7p/LkN4Ja2XvaZnbBH0iCPq4yd9vyIwUQ=;
  b=MjgaT9W0VdoB6DVyAc15shL/l187ic7P8kD5L/89etEF6RqHdtgkDxzC
   Ak+JnjOPo4CN4EQ8wvjWCbA8PwsOWPlwefa5yBgmfx/m9RB3YFwb6C00y
   UZYZR9fpox79Twv21wgGxN14V0rNNAsbdmmfqS4sOwDn9/QvUPLAMOU6T
   +YOR8cG+87J6V9KBpaToQrfx7MIxmSAgsLQ1zP7IpfaYSM590ih9X43ra
   joANv1/VKWBetjs2ONWk4WxYvVAA2X9ZjxivwVbeUhJXbnDtoNz5ZIzq3
   GipngnlSTeTLpE7edr33+0/I+qIXQ0MElcBCMuQbtsxAx+FFI469Wjy3R
   w==;
X-CSE-ConnectionGUID: DR6SkK0pTYCpXcY+NgTHtA==
X-CSE-MsgGUID: WjDq9uCDSC+ujK3faSvjvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="21725733"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="21725733"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 02:31:37 -0700
X-CSE-ConnectionGUID: 0UG4DiPGTEaIjsNxCoXzVQ==
X-CSE-MsgGUID: EB5kBZUKRfuUvrZ653Mv0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="33715091"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 02:31:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 02:31:35 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 02:31:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 02:31:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 02:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzLfGqxDJpF3LWkEnUjIHrc7/L26Qq9PCACgtec2oZYzmyoK+1aZxzTEkrUwc48cihmtQFFlkIusNheKXURrjZxACZL3Kd7fF1ip+/3Ea9cpCzSpZMhQMUn+u/q82W5dgzcYIh/UyC88Idem5yNYsh8a47GfOXY8Y1Ov3C5CTsPJ6C5cF2wn3kmQt28c8J9QKipkJO7BpsLjJLDqE3e93wHS/1rnRRK0gfMjZrQPy9wYgT3/VIH4pBahetRTEC2vZkOAxGYcb2y9A1boXeO2iI4ui1nEy2i6ZinxhlWXPikFrwJKjqlY2760k7CUNpsN+Ey7SdvQ5um2tT7setCuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5Jtgp9NcX7p/LkN4Ja2XvaZnbBH0iCPq4yd9vyIwUQ=;
 b=X+PVQfA+gRk67Foir2fROUgXx1+gnrgsNzI4B6g9zdVYrIcpjR3Z+Li4WTNmqeRD6uxuTemjDLzAUtbpJZvXxK6pT3SeAIsBAx4SyoNuxnaDV/8DcNwMVT/mXuGjE4Fd9TOEfn38JZLfIyiMiCNEY8+ZvsVnyQB5GOiACxHELB4e+sryKAlXOHUr7O1ywWW8CN9pkeiHJ/v6n8osE4Mgt/RyWv9JceVys7kUYeiq44xc4vYiTJG7PuNd3Glm3r1ED1DudA8i2wttmdGO9bhNGJqFh1SEImmYFx9HZDh+QXIWopM43VMl+1leans6BgTgLnEqkMiHd+rpu3x1y212jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 LV8PR11MB8746.namprd11.prod.outlook.com (2603:10b6:408:202::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 09:31:31 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840%2]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 09:31:31 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>, Pu Lehui
	<pulehui@huawei.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "luke.r.nels@gmail.com" <luke.r.nels@gmail.com>,
	"xi.wang@gmail.com" <xi.wang@gmail.com>, "bjorn@kernel.org"
	<bjorn@kernel.org>
CC: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "Li, Haicheng"
	<haicheng.li@intel.com>
Subject: RE: [PATCH] riscv, bpf: Optimize zextw insn with Zba extension
Thread-Topic: [PATCH] riscv, bpf: Optimize zextw insn with Zba extension
Thread-Index: AQHaoGtgQt2dALTuk0aEsDxXE25q4rGLuImAgAAUWACAAsxEMA==
Date: Thu, 9 May 2024 09:31:31 +0000
Message-ID: <DM8PR11MB57516A4601E7861FD29064A5B8E62@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240507104528.435980-1-xiao.w.wang@intel.com>
 <6836eb5c-f135-4e58-987b-987ab446b27c@huawei.com>
 <b7421822-4c07-40e2-b2a4-3599ba6b39da@codethink.co.uk>
In-Reply-To: <b7421822-4c07-40e2-b2a4-3599ba6b39da@codethink.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|LV8PR11MB8746:EE_
x-ms-office365-filtering-correlation-id: 881aa84c-9170-47fb-ad25-08dc700acfd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eXVTWHZOYXNDeHhFOXkyZVRnb3Jzd2ZhZkZ2RWJ5Wk9sKzFPUTNjTHRKVjF3?=
 =?utf-8?B?NE52clFLSm44QzBoSWpxZkpoYlhhMCtuNXM3U1g0QVVqRmV5Lzl6bnNWYXVl?=
 =?utf-8?B?UHNIRzJUWk1nR0JEOGQ5clhKenhJWDhGMmUxREVPTHBsRnJ1d2lpTlNsSzNP?=
 =?utf-8?B?L0dXUUEwRnRxeSthVTRYU1ZBd1c3LzJIUG12WU9VakxOMnViMms0TUErWnBK?=
 =?utf-8?B?SHcyTWprcUQ3ZktBaU9Rb09hdUJ0cVZFYzJsUGxsT241K3Rlc1YrclBHOGdn?=
 =?utf-8?B?dFF4eWlyREJHWHBPN1BpeHFDbWJrTWV1NVZKdjBPV2FyWDFYN2VBdDV6OWtl?=
 =?utf-8?B?R3FSZXZVZGhNUWhpTXVjYUp4Um5kdmJaSHZEY2ZYTWJHcFNmcXhBa2k4WVZl?=
 =?utf-8?B?MkFtbXBiT3krY05NZzVIbkU3Zm95Q25Yci9RZ0JRMnUyaUV0WS9EUXc3cVRt?=
 =?utf-8?B?TWMvYmxQTDdLMStSMjJBQnZNZ2lxSzNxTTl6TUNGMjNLREJRUnkzbEU0a0FH?=
 =?utf-8?B?eGdoQ3VnUjFtLys2RnVRL05tdnZDSWlySEFMMUpXYzFUZGhCdWxRY3NVMENw?=
 =?utf-8?B?Z3hRbTZIWmlXRkpwdTFFV0VYRUZ1M0xRQ3puRjU2Q2d2S3p1NzRSMHcrYm4r?=
 =?utf-8?B?M05XMklSUVE3V01WbFZmTG5JempjaENiSkJpTjVTemxNK29ZVTM3Qm9wMTNj?=
 =?utf-8?B?RHB1ekFuM2FYNWpaVTdsOGZBcTl4ZmZ5aFNaUzlKVnVwNFZLUE9TVndqazBV?=
 =?utf-8?B?akpmaFZxY0JseEh3QTdsc3dKZEh0YlVOQ1pKaWxsNmJQUkdIZlBqbS9zQWYx?=
 =?utf-8?B?b2hkM3Q5ZEJRMzhSMEFBRWViTVhKNU42Mi9YNjRSbkRJSGwvbHNidXRDc2xT?=
 =?utf-8?B?K3VaN1k3aFMySTA2VXpxVE83ck9aMEpYbURjdkZKcmxZbzBEczNWVHZTenVn?=
 =?utf-8?B?UFp2OEdoVkV1b1Bnc3pWbEh5RkVwM0R6SU9ka0Z6bm9CVU1EQTRNU0p4WFJv?=
 =?utf-8?B?bk1KTXEyMCtvMUkxWEt0RzhyUnJpcmlUVTlTdlRVUTl0VnQ1aUl4Kzd6L2FG?=
 =?utf-8?B?U1JVRW5NTGNUY205dllPZDEvQ25uREY2OTVOVmQvZFg1V1RrTlpGeEhXcjY4?=
 =?utf-8?B?NUNWenl2eG9yQXE0SUIxL0oxWHRpNHlidVBPQnYxWVpIem05cHRrRGRuYlhQ?=
 =?utf-8?B?azZjZkEveHJNRVFLMzh2Unc2d1pRTWhEdnM2UDVzUzBaM3A5Kzd1SHFKREtB?=
 =?utf-8?B?aHlzN05XL3FuUTY2OE1uNnVaeEZJN0lsSnFUQm42VUpMV3ZqZmhOQkJSL25N?=
 =?utf-8?B?bDhCRjRwRmtoR2dkRDFDb29IOTU0V2xMRHl1KzJsUlpVZjdFMkJtRjlTOU9U?=
 =?utf-8?B?K2phOU44Sms0Q3phVHg1MG9XNWxESmphRFl1ZVBjUXE1ZkxveVM1WngzRlYz?=
 =?utf-8?B?ODQvZkZCZ0RQejZ1YWtoaDB6dTFCdlV3ZUo4RVBZeHEvd3hiaU9jdmN3elNT?=
 =?utf-8?B?Rlg4RjF1S2F3emRmaXVNakRNNUQzNFVDbzVJcERoUkFmWTVHaHNwYldjNUV2?=
 =?utf-8?B?UzZFQlVqRHN5ZmxKZ3BrNDZvVTVvajlaNnl5Mk5VQ3dEZVJRV2wxRkhGaXFW?=
 =?utf-8?B?R2k5Yy9kQUFuVWpSRTZlOTdxdkU2SkdCWGUyTUtMbWZyNllvb2N4NGdGNXlr?=
 =?utf-8?B?VDdYRHpNUWFoa05OaHZ6Q3JFWSs2M3g0ekR5T0loeUdpd3BLOWZqb3hWWjU0?=
 =?utf-8?Q?Du9RYa4nlN2x4zVKMA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFN6S0hQZG5qa2c0dGR1b2sxVDEydU1yWCtMdVhXaURaK21maklrNTNEZHdu?=
 =?utf-8?B?T2ZCL2lSYzdla2tzRFpzaDhYZDNEQXZzeWlpN21TQ2xZemFIdjRzWXI2SDh2?=
 =?utf-8?B?OG5JSjNiUDQxc21SeldDSmwwTHllN0laTGtkcXFzS0orRkQ3SWdDNzdZK2hB?=
 =?utf-8?B?WTgzSDNQbllpVldHSnEvcDhrcWQ5emQvd3BIRkJEczRCa2tNeUZScitsYlJQ?=
 =?utf-8?B?UndwYnc4WnZUUUdKb1JUdzVaZlZMdk8vN1BGV3I3ZHhMeHJRY281SWp6am5r?=
 =?utf-8?B?TDZPRDBxOXhaUmVsSWphNU5GOHliVVpDZmdlcU5qOXIwQXQ1c0RzaEd3dGlu?=
 =?utf-8?B?V2VLdXVCMGFnb0ZEbmRmcEVVcmxHRkRRbE5wQlJNNTRhYzZqa1hsL01GVndp?=
 =?utf-8?B?S0lFR1lDSms1NkV3cElIRDBEZTVVUVhmZ0kyUVBiMWlCWmlZelkycDNmdVdT?=
 =?utf-8?B?UlBneG5xSS9nNUxSVHh0RmVoeHRaNlJXSkl4Ri9haHFSblhUMUsyWFFONzMv?=
 =?utf-8?B?bkNEMUlLRm5SMTZjZ2Jpd2ZqWjgzSDhNYzRBellKK09MQ3RpdjFRaElRMDJY?=
 =?utf-8?B?LytvRjRFYTZRLzBkVCtrMmFlcjJMbE0vVjh0OHdLamEyQjd0Qm9xSHlQOFFE?=
 =?utf-8?B?eG10N0RxUTM5NjBzMnNSNUNhQXUwdUk0YlhlejRudW9QckwxR3BHVEgzV2ha?=
 =?utf-8?B?UGFHa3FDOE5qdDhqOTJJQndHUWgwNHZzdTNaMGxhSkJOaUdHaWd0ZlFmdm5q?=
 =?utf-8?B?cUdFMXp3M0NBQlVNT28vQlZnZ2VETlpkZmtyaC9qMVp6ZXhhU3liNmFvVmZ0?=
 =?utf-8?B?S0RBVWg0eUttTTdicW5KbEdrZGl4S0FibTZxTEhUQnZnOHZXdUN4MGFjUmtJ?=
 =?utf-8?B?T0lmdXN3eGw4aXp1a2gvYVNjRmFPakFPV3UxNk5LRjFkUHlrbjRFU3hLU0pY?=
 =?utf-8?B?SzBKOENRWmtqWmF5b2ZiNjNWNkMxQi9QYTFRK29VUjBZWU11UEUzbms0M0FD?=
 =?utf-8?B?Wlhtb05henVlRm1HUXdXSVpaWEFHenJVci9GZERqTmhLNzg0UmdtQ0lVK1FK?=
 =?utf-8?B?aW1ybTllQmRtQitWUFJGZVZidEliU0R0ZlVhenZudEtEb2dQSm9sUnhzdno3?=
 =?utf-8?B?dzJXb25MT3hGUzU2VjhRS0FRU0NnNFFieTRvL0lSQXhwbTMzNDkxREJPbUVv?=
 =?utf-8?B?UmRJSGNxNisxdGo5VWxtT1hKTmQ2TW1tT1ozdjFNYXd3ZGFlSXdDdkZ6QmtY?=
 =?utf-8?B?QkhmNHp5emFkUDcxVkllT2JFeXE1T2huVS8zYVVMcFFaK2pWcTF1ejh4Nk9P?=
 =?utf-8?B?K1FJU1RSTGhTMGpmaWZrdW9TYXo1ZE1sT04xa1czMjBiT1NoOGlsNGdZSyti?=
 =?utf-8?B?S3hMd0JCVEQzQmRLc2dOWkpoOWlFU2tIcWdSQkdBcFMvWlEzek9EL3lVaGIz?=
 =?utf-8?B?Y1JGODN3MlluU08xbnNPMmpWdEF6Z3p4clNGeXRTZkJqTk9Ga2ZIVnhMeUZ3?=
 =?utf-8?B?WUY3OXhIUFA3TUMrRFNicVByd2p5VUFZUnJQTGx3SUI0ZUVUNnh5N3N4djJx?=
 =?utf-8?B?YTF3VHlFbVpGOU5FMitDS3l3MTRZWCt5cVJ2d2d3TWZrbmtERndyTGhYamJx?=
 =?utf-8?B?amR4RkRNdHlzVXB5d2dodFpJazhsR0ZncUZyeDdwQ0xkYjFJc1JhcEsxTzEx?=
 =?utf-8?B?N1duT3luWXVlZExNM3g4RlFoS0FuemloSjA3N3pla0Y2L1dqSnhxTndJSXRS?=
 =?utf-8?B?VEtoQjM5em5TQnJRQWl2WTJoMHZpSHNCV2ltbStrb2pQWGt5WTluT1huRkcw?=
 =?utf-8?B?b2NPMTkzS2ZFd1NRY3E1UVJtekpGelJxWitZVWRpSFEyeEVzNHRZNGRoS3dr?=
 =?utf-8?B?azdTZU5IRCtSZ1pSUStyTGErVndCS1VRSmFkejQzK1VzYlVXeWEwUHNtOG51?=
 =?utf-8?B?YUR1M0piTGNZRWF4M1B4RjRVSmdzZHEzOTdOUFpaNkRjYVJXa3hOTHVlYXIw?=
 =?utf-8?B?M0dVN3NCQWFiNEd5empqbUNzZVljeWh0TXVzYVRENHpWR1JTcTBUZnF0OTV0?=
 =?utf-8?B?TnJybzd2aWVUL21oaTY3cTQxS3k1ZVl2VDNzOWszTFpTWlU4cDA4WlI1dnpO?=
 =?utf-8?Q?Rf5z38VN+P7PIj9ikT5lgg/uA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881aa84c-9170-47fb-ad25-08dc700acfd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 09:31:31.8214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15/WcTCbuN2cHOd93NuvFhrEK8iks99lsl3wJhl4mniXHfQ4v4OS1Xy7jCWgjRhzX38HRLuHk34UDKYd9MeUcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8746
X-OriginatorOrg: intel.com

SGkgQmVuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGJlbi5kb29r
c0Bjb2RldGhpbmsuY28udWsgPGJlbi5kb29rc0Bjb2RldGhpbmsuY28udWs+DQo+IFNlbnQ6IFR1
ZXNkYXksIE1heSA3LCAyMDI0IDEwOjAwIFBNDQo+IFRvOiBQdSBMZWh1aSA8cHVsZWh1aUBodWF3
ZWkuY29tPjsgV2FuZywgWGlhbyBXDQo+IDx4aWFvLncud2FuZ0BpbnRlbC5jb20+OyBwYXVsLndh
bG1zbGV5QHNpZml2ZS5jb207IHBhbG1lckBkYWJiZWx0LmNvbTsNCj4gYW91QGVlY3MuYmVya2Vs
ZXkuZWR1OyBsdWtlLnIubmVsc0BnbWFpbC5jb207IHhpLndhbmdAZ21haWwuY29tOw0KPiBiam9y
bkBrZXJuZWwub3JnDQo+IENjOiBhc3RAa2VybmVsLm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7
IGFuZHJpaUBrZXJuZWwub3JnOw0KPiBtYXJ0aW4ubGF1QGxpbnV4LmRldjsgZWRkeXo4N0BnbWFp
bC5jb207IHNvbmdAa2VybmVsLm9yZzsNCj4geW9uZ2hvbmcuc29uZ0BsaW51eC5kZXY7IGpvaG4u
ZmFzdGFiZW5kQGdtYWlsLmNvbTsga3BzaW5naEBrZXJuZWwub3JnOw0KPiBzZGZAZ29vZ2xlLmNv
bTsgaGFvbHVvQGdvb2dsZS5jb207IGpvbHNhQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiByaXNjdkBs
aXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBicGZAdmdl
ci5rZXJuZWwub3JnOw0KPiBMaSwgSGFpY2hlbmcgPGhhaWNoZW5nLmxpQGludGVsLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gcmlzY3YsIGJwZjogT3B0aW1pemUgemV4dHcgaW5zbiB3aXRo
IFpiYSBleHRlbnNpb24NCj4gDQo+IE9uIDA3LzA1LzIwMjQgMTM6NDcsIFB1IExlaHVpIHdyb3Rl
Og0KPiA+DQo+ID4gT24gMjAyNC81LzcgMTg6NDUsIFhpYW8gV2FuZyB3cm90ZToNCj4gPj4gVGhl
IFpiYSBleHRlbnNpb24gcHJvdmlkZXMgYWRkLnV3IGluc24gd2hpY2ggY2FuIGJlIHVzZWQgdG8g
aW1wbGVtZW50DQo+ID4+IHpleHQudyB3aXRoIHJzMiBzZXQgYXMgWkVSTy4NCj4gPj4NCj4gPj4g
U2lnbmVkLW9mZi1ieTogWGlhbyBXYW5nIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+DQo+ID4+IC0t
LQ0KPiA+PiDCoCBhcmNoL3Jpc2N2L0tjb25maWfCoMKgwqDCoMKgwqAgfCAxOSArKysrKysrKysr
KysrKysrKysrDQo+ID4+IMKgIGFyY2gvcmlzY3YvbmV0L2JwZl9qaXQuaCB8IDE4ICsrKysrKysr
KysrKysrKysrKw0KPiA+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKykNCj4g
Pj4NCj4gPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvS2NvbmZpZyBiL2FyY2gvcmlzY3YvS2Nv
bmZpZw0KPiA+PiBpbmRleCA2YmVjMWJjZTY1ODYuLjA2NzkxMjdjYzBlYSAxMDA2NDQNCj4gPj4g
LS0tIGEvYXJjaC9yaXNjdi9LY29uZmlnDQo+ID4+ICsrKyBiL2FyY2gvcmlzY3YvS2NvbmZpZw0K
PiA+PiBAQCAtNTg2LDYgKzU4NiwxNCBAQCBjb25maWcgUklTQ1ZfSVNBX1ZfUFJFRU1QVElWRQ0K
PiA+PiDCoMKgwqDCoMKgwqDCoCBwcmVlbXB0aW9uLiBFbmFibGluZyB0aGlzIGNvbmZpZyB3aWxs
IHJlc3VsdCBpbiBoaWdoZXIgbWVtb3J5DQo+ID4+IMKgwqDCoMKgwqDCoMKgIGNvbnN1bXB0aW9u
IGR1ZSB0byB0aGUgYWxsb2NhdGlvbiBvZiBwZXItdGFzaydzIGtlcm5lbCBWZWN0b3INCj4gPj4g
Y29udGV4dC4NCj4gPj4gK2NvbmZpZyBUT09MQ0hBSU5fSEFTX1pCQQ0KPiA+PiArwqDCoMKgIGJv
b2wNCj4gPj4gK8KgwqDCoCBkZWZhdWx0IHkNCj4gPj4gK8KgwqDCoCBkZXBlbmRzIG9uICE2NEJJ
VCB8fCAkKGNjLW9wdGlvbiwtbWFiaT1scDY0IC1tYXJjaD1ydjY0aW1hX3piYSkNCj4gPj4gK8Kg
wqDCoCBkZXBlbmRzIG9uICEzMkJJVCB8fCAkKGNjLW9wdGlvbiwtbWFiaT1pbHAzMiAtbWFyY2g9
cnYzMmltYV96YmEpDQo+ID4+ICvCoMKgwqAgZGVwZW5kcyBvbiBMTERfVkVSU0lPTiA+PSAxNTAw
MDAgfHwgTERfVkVSU0lPTiA+PSAyMzkwMA0KPiA+PiArwqDCoMKgIGRlcGVuZHMgb24gQVNfSEFT
X09QVElPTl9BUkNIDQo+ID4+ICsNCj4gPj4gwqAgY29uZmlnIFRPT0xDSEFJTl9IQVNfWkJCDQo+
IA0KPiBBdCB0aGlzIHBvaW50IHdvdWxkIGl0IGJlIGVhc2llciB0byBhc2sgdGhlIHRvb2xjaGFp
biB3aGF0J3MgZW5hYmxlZA0KPiBhbmQgcHV0IGludG8ga2NvbmZpZyB2aWEgc29tZSBzb3J0IG9m
IHNjcmlwdD8NCg0KWW91IG1lYW4gdG8gdXNlIHNvbWUgc29ydCBvZiBzY3JpcHQgdG8gYXV0b21h
dGljYWxseSBkZXRlY3Qgd2hldGhlciBMRCBsaW5rZXINCmNhbiBzdXBwb3J0IGEgY2VydGFpbiBy
aXNjdiBleHRlbnNpb24/DQoNCkkganVzdCB3ZW50IHRocm91Z2ggdGhlIGhlbHAgZ3VpZGUgb2Yg
cmlzY3Y2NC1saW51eC1nbnUtbGQsIGFuZCBkaWQgc29tZSB0cmlhbCwNCnRoZSAiLS1hcmNoaXRl
Y3R1cmUiIGFyZ3VtZW50IHVzYWdlIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBDQydzICItbWFyY2gi
LiBJIGNhbid0IGZpbmQNCm90aGVyIHJlbGV2YW50IGFyZ3MuIEl0IGxvb2tzIGN1cnJlbnRseSB0
aGVyZSdzIG5vIGRpcmVjdCBtZXRob2QgdG8gZHVtcCB0aGUNCnN1cHBvcnRlZCByaXNjdiBleHRl
bnNpb25zIG9mIGEgTEQuDQoNClRoZW4gSSB0cmllZCBiZWxvdyB0ZXN0IHRvIHNlZSBpZiB3ZSBj
YW4gY2hlY2sgaXQgdmlhIGJ1aWxkaW5nIGZyb20gL2Rldi9udWxsLCBqdXN0IGxpa2UNCnRoZSBj
Yy1vcHRpb24gZG9lcy4NCk5vdGU6IGhlcmUgQ0MgaXMgWmJiIGNhcGFibGUNCkNDIC1tYXJjaD1y
djY0Z2NfemJiIC14IGMgLWMgL2Rldi9udWxsIC1vIHRtcC5vICYmIExEIHRtcC5vIC1vIHRtcC5l
bGYNCg0KSSBmaW5kIHRoYXQgd2hldGhlciBMRCBpcyBaYmIgY2FwYWJsZSBvciBub3QsIHRoZSBh
Ym92ZSBjb21tYW5kIGp1c3Qgb3V0cHV0cw0KIndhcm5pbmc6IGNhbm5vdCBmaW5kIGVudHJ5IHN5
bWJvbCBfc3RhcnQgLi4iLCBubyBlcnJvciBjb21lcyB3aXRoIG9sZGVyIExELg0KV2hlbiB3ZSBw
cm92aWRlIHNvbWUgWmJiLWFyY2gtdGFnZ2VkIG5vbi1lbXB0eSAqLm8gZmlsZSB0byB0aGUgTEQs
IHRoZW4gDQp0aGUgb2xkZXIgTEQgd291bGQgZXJyb3Igb3V0ICJ1bnN1cHBvcnRlZCBJU0Egc3Vi
c2V0IC4uIi4NCkJ1dCBJJ20gYWZyYWlkIGl0J3Mgbm90IGEgZ29vZCBpZGVhIHRvIGFkZCBhIHNv
dXJjZSBmaWxlIGZvciBlYWNoIGV4dGVuc2lvbiBkZXRlY3Rpb24uDQoNCk1heWJlIGluIGZ1dHVy
ZSB0aGVyZSB3b3VsZCBiZSBhbiBlYXN5IHdheSB0byBhc2sgdGhlIExEIHdoYXQgcmlzY3YgZXh0
ZW5zaW9ucw0KYXJlIHN1cHBvcnRlZC4NCg0KQlJzLA0KWGlhbw0KDQo+IA0KPiAtLQ0KPiBCZW4g
RG9va3MJCQkJaHR0cDovL3d3dy5jb2RldGhpbmsuY28udWsvDQo+IFNlbmlvciBFbmdpbmVlcgkJ
CQlDb2RldGhpbmsgLSBQcm92aWRpbmcgR2VuaXVzDQo+IA0KPiBodHRwczovL3d3dy5jb2RldGhp
bmsuY28udWsvcHJpdmFjeS5odG1sDQoNCg==

