Return-Path: <bpf+bounces-29689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1318C4D20
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 09:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387E9B20ED9
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 07:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30C212E75;
	Tue, 14 May 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwUyxSwq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A0111AD;
	Tue, 14 May 2024 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715672172; cv=fail; b=SEMuZkh3o9trN36SWKce6KzFrWEz9OsHyDGM0/i0nL2R7DXiSJLkIq2dpKlqosOhqp0U8FH5mGpygPWvJYqoKDIkxTRrCzvgg2j9XytinP2fLBO+6a14doOhUyIVgLxhujnT8hG3pDX3tCGWiHKsG7dpQcGGosHbFLfqvVaZo70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715672172; c=relaxed/simple;
	bh=44T0KR7swBNc4t8JXmgGgMbX7mtjb2K6dZYXjWNCtIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lkPS3pGxWJMLVQSvnkDXKQBzvFDeZWI9IPzvXalDf1ykzh1GopoFBucJSGLC0xFxix0jVcVMy+wRfUWQPgMMrRiwctlg2XpkFFJhk27l3ExuOibJ07NHch0JKFqzdxQaPYYPe7MeH4Nz2jcLoinKgF3QWSEPFlRq2fNMUBN0Um4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwUyxSwq; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715672171; x=1747208171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=44T0KR7swBNc4t8JXmgGgMbX7mtjb2K6dZYXjWNCtIE=;
  b=NwUyxSwqN+kN20aLvyPbl1IxN5m6pGWEc96p4LZvu1hFb3VOwivFbtIA
   HJHduEjsLuARI3RJJoBPzYhhQgl2uEu7nQman7WqpIhQvdnWLxk6dKId6
   82w6ymy6kNg33hvUwI9FcG4cpp8LO7oNHAPnf7l3i2VshRhlQiymH4fnL
   F43C37PwvFk4aLW/K8d2HU7KDNGb3PKCs5yKmW8dBJ1ccz8EvX88SMw2I
   utn+7f4de9DuALNudqflwlBHxyM2ePQw5hKFpsCpQnnZ58U9lWBl3mmvj
   tTbIcaFPTnnBA2lEt/eVpJoYysWJhwgUgjWoT5dh5c+oEFuSFIcRSeWHG
   g==;
X-CSE-ConnectionGUID: GJOpRY8sQSq3pkGWjQ+IoQ==
X-CSE-MsgGUID: CekFBChWSG6y0X5DXDtkBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11768949"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11768949"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 00:36:08 -0700
X-CSE-ConnectionGUID: RIfGoa1FTfCd6yZL1M57zQ==
X-CSE-MsgGUID: UYt/O7/jTiCc0tRFcYyQVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30609849"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 00:36:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 00:36:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 00:36:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 00:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMlmnh3/4sMF5BnDmPt+L+I8ecMBkCXxU2w8z9N7u7P4vVICqJRVFPVwJfMrxDhtdypDFehKGyxG/1BtU/IdxsZr9nmrB9RB2BVK0GNewdEUxuevdKj5vnOY0Sx2LQui8ceiGhLgg2y6gZvw9ABZIG43qPfjseHYVyDedtvQibxOEiG+dUvfQcgL5j/V0kzigV4uVI4EncjeyEr27RTD9BhJFDwS12krnl/YxTpLm7I/wr+tRqp3P6aMpkZxupJTM7/u+g3X2q328xD3bRk/Al/xuY29yWXm4Ml59yReVMhZg3YOSXTvS48CQZ0TOANOPSX6qv4ewyUGdPVy6jER6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPpefHqeHsTTrdsxnIrPLsG+iF1UartQbfEhRN7b2QU=;
 b=SHCFU2L1MowhYaJ6naQ+7tb9SOMAZHtwVdM7Pe9hHlMn6oNH41KHFjsLAROHvsWfCm51+Reh/+FTn7PF5rb6k4qwWKB8tup7iU39zgyHL5zdLHD+qnpMfvV8AIOHvSYIV5+ZKhak8l0w7ma8qFCZ6pwYYYDhIYicwhEddqbVaV0JwVTAq34FGnbJ+HfEfaLp5EIgadfiMa5QkhcWlQAK+wvSPMj6x2e5BYWWh84Fe1Ai6HDKNmnwnXtg9lWwlF7D74Wg60XNjXrZsH69EbaJA0VLI7zTG8PPffzwb+RMaMhONVF0B13JCuvZgr9uFxB/5uKcLIsCcc1eA3rxN/sbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 07:36:04 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::abaf:6ba7:2d70:7840%2]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 07:36:04 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Andrew Jones <ajones@ventanamicro.com>
CC: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "luke.r.nels@gmail.com" <luke.r.nels@gmail.com>,
	"xi.wang@gmail.com" <xi.wang@gmail.com>, "bjorn@kernel.org"
	<bjorn@kernel.org>, "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "pulehui@huawei.com"
	<pulehui@huawei.com>, "Li, Haicheng" <haicheng.li@intel.com>,
	"conor@kernel.org" <conor@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: RE: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba extension
Thread-Topic: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba extension
Thread-Index: AQHao0tSYAL6LqZaWUWtv7jZE6ZoR7GVZY4AgADuVMA=
Date: Tue, 14 May 2024 07:36:04 +0000
Message-ID: <DM8PR11MB575179A3EB8D056B3EEECA74B8E32@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240511023436.3282285-1-xiao.w.wang@intel.com>
 <20240513-5c6f04fb4a29963c63d09aa2@orel>
In-Reply-To: <20240513-5c6f04fb4a29963c63d09aa2@orel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|MN2PR11MB4695:EE_
x-ms-office365-filtering-correlation-id: 5adb08c8-8b8f-495c-367a-08dc73e882ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?Windows-1252?Q?KrM7LRyZ1K28Qo4UgOVYzgOFpaBwg9RzFzNh46FQ7JLsQIEx4MN7x1so?=
 =?Windows-1252?Q?aOTPkJgAjYmDRxU3VMirpOKjfCQ2jEHP1w+gsxxIDW/MZ8OYWZ09Iv0b?=
 =?Windows-1252?Q?Fau/1LA1SllXcmrwBXgJZcQNd9iSzBP6+6nOBK/2zvLkd9xEaqPQ2Ewi?=
 =?Windows-1252?Q?xX1TtObvEKekyMdrBgIasBhHZMOF7M8I8UYE18kTpws2g3DO8G+JrcUT?=
 =?Windows-1252?Q?wbiuAOyUYU4Zpt0Jjn2ENwRdpoZXQiw5NiuYzb8Z/+xs2bt0u3cK90cm?=
 =?Windows-1252?Q?fPuuA74XP7gv3Hcf85eJ0dmQ5S+j/SpdbrjfYM88tFWfcBO/yN62PkKZ?=
 =?Windows-1252?Q?xQ+K59zzphq7i6cDbCZP7/06/vmFWkPlxkmIcDlNKlAE4Lx7bx75eXOK?=
 =?Windows-1252?Q?vxjYYM2m6qmWCemEKq8JiWlvXLbgHB65TfMhSv+sd8kovihmI3lO4Lyt?=
 =?Windows-1252?Q?j54eRkIjtMORNBTRkwIcgxue+2eyFJ8PM+pBgnfaIwCw/2ySKb6F/YFx?=
 =?Windows-1252?Q?vLenrizUevYAFTm76eU2QU/1Yq2D0/8QutqAZCkvABSvcxFhxn67UFWP?=
 =?Windows-1252?Q?hCOH3RdKVf3g/hBfJofyomBrE7a49zkToEY1/JJPWfQ91wAH73jqPoFk?=
 =?Windows-1252?Q?u0ncX37msdAXhb7+aEsEZB4jdf7yZwJ1U0/WzhAJ6sbdXIHWpqEj5iEO?=
 =?Windows-1252?Q?B2vUhtMvk4cza2gJgM26YSgt88OcAZtq8Lw3gjn+8Sstpi6K2i1QsObR?=
 =?Windows-1252?Q?rgnX2ePXfKptRI/egKJZUJCTEJVC8Nr5rcJ6tiChD8miEwsVpH+YtKoe?=
 =?Windows-1252?Q?ODcK7YAplBi2aEuZbm3RTBoBevKa2qa2gX+qoSgeFUzZXzddA6g2SBfB?=
 =?Windows-1252?Q?UA7yvoKLFJKdaSm/CSr0LiIPePFKpXwFXqx5xw56JSzIlORXNvj7CUy3?=
 =?Windows-1252?Q?4fynQn577CW87hEhuGficOXVZCx3UQDQOZ/T5xjgaXgZs+W10K4zNnSq?=
 =?Windows-1252?Q?cf7xZ8vTeHluKB0REM4MDF3OlIycLdtmc5ImE4BZ6iOBqumZ/6ao20wP?=
 =?Windows-1252?Q?QfBzUoXPZ3FSyJL3EDdKS+L6K5k3bKFpP5UTi8FzyUUPcTFDHXeQWeyd?=
 =?Windows-1252?Q?VAQHmcvgT3eneh6U/zgdA7xkKlBMC87FXjfstdTHlXsnkiujn6A4k80P?=
 =?Windows-1252?Q?w5qExZFecjWCXus+WoyK0Dfmp/2hs1S2shD+1JZc8LSHskDoKFu9ZSYu?=
 =?Windows-1252?Q?y+TgV0bl9jEq2XAs/2Ont9b+A4UkCfmFxzSt39sA6UtYy3gl7yLBaYkq?=
 =?Windows-1252?Q?BjvoEGbRFyZCMJ9OCqiGfTvinva8oOAKHPUAw9unu0RsP2CouuKFDXnY?=
 =?Windows-1252?Q?xThW8vwL7ijxgFBXJanylQW+RsHAZeph+T9CDCtA4f4Cf3N1fOQ2WnkN?=
 =?Windows-1252?Q?jB1yJySzoW77CHnP6U1nxA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?VBn4WNQIgZl+7960aGDjhq1y/SmOf8FGSHukCM0BNWsDriHZL73H+gwe?=
 =?Windows-1252?Q?cItNN54SHcxT6NLBAoHUJ0UEbdXnNJ6kXzp/syxlfvcsokIFhFlhsun5?=
 =?Windows-1252?Q?5p4V2GVMW9w+/f+zYzLm36UEK77kGIakrMKeHQVZ7YcoMeX7t0apNTel?=
 =?Windows-1252?Q?n99rgT66PYsncB8oYUi1iEjMb6b3D09hVGnZKj4SOx7a5t2raXCQx038?=
 =?Windows-1252?Q?UXt5q1hZZxNaNnaibsto5OWXLgnBd8zuPcC/5Yyarmj6AOxUr5hAYS+B?=
 =?Windows-1252?Q?s+qet79ZgzHkmgAQ2UOjWln1H0HIbF0kAMpT9jKNSai8MBtmSbiO7k3Z?=
 =?Windows-1252?Q?em9WSQ10XFclqwaY/feRwC6HAzAuYBS9kLiyBnUhdIum0EpGmFqxkYsg?=
 =?Windows-1252?Q?bUrI9slK8kHZSJSZ0ZF1zYahJaU4cyiIQVcVEH/18schF/PTbZGPNk0t?=
 =?Windows-1252?Q?ABDNQNdiI/a3RKvQ1Q+1PvUyvurDcdYwNCB+VyMpR04wm44cWNHYQ41n?=
 =?Windows-1252?Q?LpNqjqT3XrjQP1iqzbneRXqaA7jENgPD7fIrXcoeYsN9z0Ow01XZVhyj?=
 =?Windows-1252?Q?0Tazv1K8zYnqtp711e1jtmkvTvxzZsKr0VbiJ5evrP+X0bF7FfauivHs?=
 =?Windows-1252?Q?+WxnDOSykGSZLyUKP5q74D6PhdlaRYDPVRFfIBIvc9hoAA5J9V+j1TaU?=
 =?Windows-1252?Q?HhMyL1ZfS7HWvUfT4InCa4P7UEPUOoAnkmoENTLBbxPahT91ArcX3J/8?=
 =?Windows-1252?Q?BCFJ4Vbk/2L/kmXEhZsoCZaGRQKP1k3Orv//OERL01YHxNr6sxx9FhL8?=
 =?Windows-1252?Q?OgiF0Eo5vaqOGMOTQHNgabSIGtYTj3cBQT5abjqDC036ERHTII9TMjX3?=
 =?Windows-1252?Q?8FFUAbt85kQAmIeUEKhBR0ZXjj9mvcRWDiTKxyuN95r6UAbQmk0UDzl8?=
 =?Windows-1252?Q?BFKUXEz0i+OL5gJpvxDyGT63LKi4tPvJlUv21a305kZIhZwwTM3aaYgm?=
 =?Windows-1252?Q?2O9Olxr7Doz5uPuyMoGWdZBlpU1gBx1Q4JbFTlBBAqkm3D1VATNeaaop?=
 =?Windows-1252?Q?VympOurFNFfWdwHTm+j5cSKbIXL3sVW8bqe9J4S1qB2KfRZaN0Y1GWZa?=
 =?Windows-1252?Q?w4hjaSQVCVkF8yi+lcvb2z+2NlzTafYW2Jn/jA9yudLrE8mzBWBv4CKd?=
 =?Windows-1252?Q?FICE697fu5KTjcdiEAy8/IM3ZSiCZhLUg6fENl69o9LfsItvQMbhVCeJ?=
 =?Windows-1252?Q?/guzrYqGMh2HiLCsRrA+HrA0NgnLNoXBLF4dGQpAGclC9dJSM8lIjPqu?=
 =?Windows-1252?Q?9h0IoMiT4xHpHSCqyr6P/seDe4zSukr9V8Y2zQrKngKobkmBg5crL9kr?=
 =?Windows-1252?Q?l3B+XVQXtQISz2BH0TwvY3t+xayMYJIxT1/hoNSwWWyoKpibtpp4mQZS?=
 =?Windows-1252?Q?R+JPflvu0J7nBS9GhBt9D5dGJ//DwvlDxZymJ4hPF7pn0/w3mpI8praj?=
 =?Windows-1252?Q?/Gd9Me2KQoFTSMHya5W/tOwRw53XlHihvTfKHxshFZIS72v///6QvWZZ?=
 =?Windows-1252?Q?K1cf4faPD6xqILasmpoXOws5IpyJYQF+UXnORZENAtty9AosuFfP1ZCc?=
 =?Windows-1252?Q?KR9K0gzHh+JkroUN4IxEkA08Tf4V1PCZd8eZZZl+BK8V9pJPlPgUkGDa?=
 =?Windows-1252?Q?ofl+BZ/wbS7EBiQVvP8jApzqjTrD8LWt?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adb08c8-8b8f-495c-367a-08dc73e882ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 07:36:04.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cE095cX+YFWOcy2wOnpt84E1n7VzCkXdELt0IgDwC6sCqB2jK/umpT0KhdVo/45tx2t8jwPwazyd67b1KaBciw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andrew Jones <ajones@ventanamicro.com>
> Sent: Tuesday, May 14, 2024 12:53 AM
> To: Wang, Xiao W <xiao.w.wang@intel.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; luke.r.nels@gmail.com; xi.wang@gmail.com;
> bjorn@kernel.org; ast@kernel.org; daniel@iogearbox.net; andrii@kernel.org=
;
> martin.lau@linux.dev; eddyz87@gmail.com; song@kernel.org;
> yonghong.song@linux.dev; john.fastabend@gmail.com; kpsingh@kernel.org;
> sdf@google.com; haoluo@google.com; jolsa@kernel.org; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; bpf@vger.kernel.=
org;
> pulehui@huawei.com; Li, Haicheng <haicheng.li@intel.com>;
> conor@kernel.org
> Subject: Re: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba extensio=
n
>=20
> On Sat, May 11, 2024 at 10:34:36AM GMT, Xiao Wang wrote:
> > The Zba extension provides add.uw insn which can be used to implement
> > zext.w with rs2 set as ZERO.
> >
> > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > ---
> > v2:
> > * Add Zba description in the Kconfig. (Lehui)
> > * Reword the Kconfig help message to make it clearer. (Conor)
> > ---
> >  arch/riscv/Kconfig       | 22 ++++++++++++++++++++++
> >  arch/riscv/net/bpf_jit.h | 18 ++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 6bec1bce6586..e262a8668b41 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -586,6 +586,14 @@ config RISCV_ISA_V_PREEMPTIVE
> >  	  preemption. Enabling this config will result in higher memory
> >  	  consumption due to the allocation of per-task's kernel Vector
> context.
> >
> > +config TOOLCHAIN_HAS_ZBA
> > +	bool
> > +	default y
> > +	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zba)
> > +	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_zba)
> > +	depends on LLD_VERSION >=3D 150000 || LD_VERSION >=3D 23900
> > +	depends on AS_HAS_OPTION_ARCH
> > +
> >  config TOOLCHAIN_HAS_ZBB
> >  	bool
> >  	default y
> > @@ -601,6 +609,20 @@ config TOOLCHAIN_HAS_VECTOR_CRYPTO
> >  	def_bool $(as-instr, .option arch$(comma) +v$(comma) +zvkb)
> >  	depends on AS_HAS_OPTION_ARCH
> >
> > +config RISCV_ISA_ZBA
> > +	bool "Zba extension support for bit manipulation instructions"
> > +	depends on TOOLCHAIN_HAS_ZBA
>=20
> We handcraft the instruction, so why do we need toolchain support?

Good point, we don't need toolchain support for this bpf jit case.

>=20
> > +	depends on RISCV_ALTERNATIVE
>=20
> Also, while riscv_has_extension_likely() will be accelerated with
> RISCV_ALTERNATIVE, it's not required.

Agree, it's not required. For this bpf jit case, we should drop these two d=
ependencies.

BTW, Zbb is used in bpf jit, the usage there also doesn't depend on toolcha=
in and
RISCV_ALTERNATIVE, but the Kconfig for RISCV_ISA_ZBB has forced the depende=
ncies
due to Zbb assembly programming elsewhere.
Maybe we could just dynamically check the existence of RISCV_ISA_ZB* before=
 jit code
emission? or introduce new config options for bpf jit? I prefer the first m=
ethod and
welcome any comments.

Thanks,
Xiao

[...]
> >  {
> > +	if (rvzba_enabled()) {
> > +		emit(rvzba_zextw(rd, rs), ctx);
> > +		return;
> > +	}
> > +
> >  	emit_slli(rd, rs, 32, ctx);
> >  	emit_srli(rd, rd, 32, ctx);
> >  }
> > --
> > 2.25.1
> >
>=20
> Thanks,
> drew

