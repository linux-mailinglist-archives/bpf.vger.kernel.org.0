Return-Path: <bpf+bounces-50769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636AA2C51E
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 15:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC0818807F0
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB5A23E25D;
	Fri,  7 Feb 2025 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YV39tmD3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2681DED70;
	Fri,  7 Feb 2025 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938164; cv=fail; b=G4e93F5so4kbZ3SXNcgW15Hf2bk2+1bMOStO8A/lXW/qtekHGtnGWkvInoZ8hoVLBIW3tUc9wSTCj49blNoQOkdpSNq49rFFDH49wGeKWzy2xJNXUOETsOkMu7+ufNkOsAuzA7QizGLoEjwE0hxBlGbPKIq81RdkpvutdCVt40Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938164; c=relaxed/simple;
	bh=jG13GHnFTXwwKdQhkqeFXeDaWQr+jC7j6TxX7Y/dbgg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uzh7yWZI9PC1uPhimtaRXTqzItJsB8RJG9JbkO2YKu67Tp7U2E/WKm8cTuj6vbXsqwustk1IQQcpOdZPCC4j+c7a/RUIvp50S4HkHco1N1/Z0MtCmNU7dC4V3Cj8xpmFy8+k/j2yhwQhGd+epqAkjAsP0/FGlloAyKpwbbR8dHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YV39tmD3; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738938161; x=1770474161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jG13GHnFTXwwKdQhkqeFXeDaWQr+jC7j6TxX7Y/dbgg=;
  b=YV39tmD3+7evbQR/y+pNx6ZMYZmMcqkSQmN5+CYdkDXcD5qJS47UyRFU
   gQofHHWkQ1kjHw6DnYhEJgY4J3DaZAulvexCEKrM8Xefo4CF2KPAbxBEi
   d4gRP9GRe92NqcLGEOyEEG1Tmdogbv2TPMPPgiYaMzICqiNMhyvaSo9tM
   sShM4n7txxusRCxjfCBUuSelumEDsjz4C4Jd3MyIwfQduyOhY9InS1ZoA
   PIdUzC4DxG1LhP70bTlt6GN1MuyQMaV/7J9n5A9dBN8Wh4XF3Igt40Fp1
   b2RHdJi/Jrh55Q6ABLSpzyu9iT/KJb5bQ1dtGvEpYhdOzYBflGFghuK/D
   g==;
X-CSE-ConnectionGUID: iWh2C7XKR9Ke57L5JoYSfA==
X-CSE-MsgGUID: JzFRxO6ASQu4/GAhogDUHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39485943"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39485943"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 06:22:41 -0800
X-CSE-ConnectionGUID: wQSlQ8xcSTquizPB2+Fmsg==
X-CSE-MsgGUID: EoeMq4XvSs+L/LvSrN7/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148745952"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 06:22:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 06:22:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 06:22:41 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 06:22:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9H8Wke7DFgfUq75AX6fFWcUn2WP0uH+ScBZK0yLoZmx5NWKMStYarCaKdVY7RMNj7sS3djBjnTZPr1dLOfn92h5poNrckhj82eOZ7HEG5axwC9w6rSrjDGV20dxcZuSXlvi7YKasjLtYvYN/kGScTerym4rp2gWt3W18Cu/YorYjp9owqcOl6Xqa9ztmkt4nhajQvZ+TPtixC/7FwdKooOPPDeNgGd8Gz2wmJeJXEsZrZXIaVcKUbmyhJi4IbxZxPb1xaAnlyYrL1EfSb7z6XzFPeeT9smb+pH99G4xCaTiKiy8pahkQQsn/lKJVK4ziCq7Dgnh1K2H6CyS8eu3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8wq8Sv2UXxAO/6pbZjpQdkJ49kgso/Jydq/0wvdBZI=;
 b=KpVYSr9ENCxeR6t/veWbLqRbV4dyoDjVWgrlbzSamWZ0WkXciBR2z16F6ajTiLHObyk1Og/4k3QV1pphojLqQdiIFZpf9HR7N0w2Xze35njsTgYb+Yy1w1ow7JSYvHvbVFDmO+TSpE+BlBvCMjRpLw52YiuouhPCEISgvq3zSfP8XPFOi8GMc8VAJ8m+K26y3Ib+psr4CM19fZX5Yd3ZqbbCq7dnZuGt4nmYC9VH7xYHbmgm4032ZARJ3LWujIQPWn5KwTdUggvY2WFx+S20k/82noEQFEs+FIXhU4dCmj/5R80zSkNWN2OPfkk3Qe7rWk0AbzY6EDhcQvmERQyvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB7302.namprd11.prod.outlook.com (2603:10b6:8:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 14:21:55 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 14:21:55 +0000
Message-ID: <eba70511-b6eb-4ff2-ae1a-183fa626d60a@intel.com>
Date: Fri, 7 Feb 2025 15:21:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/8] net: gro: decouple GRO from the NAPI
 layer
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
	<edumazet@google.com>, Kees Cook <kees@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu
	<dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
 <20250205163609.3208829-2-aleksander.lobakin@intel.com>
 <CANn89iJjCOThDqwsK4v2O8LfcwAB55YohNZ8T2sR40uM2ZoX5w@mail.gmail.com>
 <fe1b0def-89d1-4db3-bf98-7d6c61ff5361@intel.com>
 <CANn89iJr1R4BGK2Qd+OEgsE7kEPi7X8tgyxjHnYoU7VOU_wgfA@mail.gmail.com>
 <3decafb9-34fe-4fb7-9203-259b813f810c@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <3decafb9-34fe-4fb7-9203-259b813f810c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0025.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::14) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: e981a9d4-6223-4f61-29b5-08dd4782c636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHJZMm5ncnQ0bFNqWFRpYlROdllZUE13dnJ3R0hiRGlPM2VibVRQR2JSUEZs?=
 =?utf-8?B?Mm5JTTFncGM2MWNVTldpSi9nR0JocVlxNEFzK3huQjlib1haSjlLVWY0Nm5H?=
 =?utf-8?B?YjlsblZnWXNuRjludS9UZWxVeE9pcXFuWlJKcUloS0ZiQm1NcW02b2dzdG9T?=
 =?utf-8?B?RGJmeUphVUE5bkhaSW13WmtRaCtIeWNuamc5SnhPNUFiVXpLSFd3N0JTWmJh?=
 =?utf-8?B?Wkg0ci9zWDQvTjdydnNYa0xubEpaL29Ld2d5azIxUHdHNE1jZjBHeEorSjJz?=
 =?utf-8?B?ekp5UkdSU3hSem44NXdMYm9rOThZL0REZ1FsSEVhSnQ2bVQvUTVJUUVWanR5?=
 =?utf-8?B?QjdML0phbnR0VzFlZXFYcjh1WnJ0OFNrbkkxZ0xXU3c4dG1YZnpCUy9tT3Vt?=
 =?utf-8?B?RXJOL2pNMmk5a0pMNUpTV20rK3VPTFRuT3lMVzZlSWw0RTNVQkJJdnUwWFB2?=
 =?utf-8?B?NDFwSjFhdXF6SVRIa0NVai8vMGNzbWNrb0lrM1hxRktTQXNUd1lsUlZmSVVV?=
 =?utf-8?B?ZHh6Yk52K0crbHlHL0VDd2lNZVQ0K3lIZ3pMU2FPRlhIRjZqQWo2VmJwVkJB?=
 =?utf-8?B?SHFJMzEreWNIMG5seDJaSmZld052QllpekxDdjBlREpWSXVGbWUrWnExYXJr?=
 =?utf-8?B?VzlJNUF1U3FRSUpTZkZwRE13NThxdHVlRnVXaDNmL0d3ajl5Rm93U2FnOVJZ?=
 =?utf-8?B?bnBRSVg4L05mNWg0dFJKNndBMXdmSUN4VjB3ZDIra1AyaGNMODFFZmJUMnl3?=
 =?utf-8?B?N2NNQ2tOV09DMDNWU1BZd0FIWG0rcE85dTQxT2hnRW5Telk1a0JaaGRPV3I1?=
 =?utf-8?B?MG45UGlyczQ5bEJ3UWw4aUJpazArNWxYdlFhNkg0TUVvMFg0U3JoWWtmUU1M?=
 =?utf-8?B?a3RaTDR5bDdzbXBKUGtBSlYxaGVlUVRQa3JXQlgzZjRHNWVGMC83WkJpOC9G?=
 =?utf-8?B?UTJJN3QzS2ovd2IyN3N5dGRNeVF3bEcrczJ3amoyOHdIdVNiNVFqaFc5Ujh0?=
 =?utf-8?B?dHRQM3U1eDZ0Y1g2elVxUXlQM2lINjN5OEZHMExVMTRRQjN6dUhvdVpjaUNk?=
 =?utf-8?B?Q2V4K2dPMGdUOW9OSDRLM3hhT3JHUlRWNDZ4K3ptQXpNRE9HaFJKbFlLNUlz?=
 =?utf-8?B?dWxNTk5seElhTDdRVHQrSFZSL3JxVjl6MHVuSE5tdUlQdnRyMjNLVkxUQjY2?=
 =?utf-8?B?WDRROVl6Tm42K1lJYzZpTmQzRVNKd2F4cFVQQWpQTm5Udm1OeUcrUFFYcm1P?=
 =?utf-8?B?OHFUTFB3ejlPQ2hrZTViRzZLaExmSTZLOCtBWnh6aU1SZVUvT2l4R3RIZTJj?=
 =?utf-8?B?Y2NoQzJuRmtjbithMU53cC80czVZcDhJVUxxWEVnYlVrUUwxYUxYNkdwUzVh?=
 =?utf-8?B?ZWJ3ZE1ZS25oTXc4elRHOGJNbTNPVlJUV09DeXNUVk5CMWNtcG03bmswdnIv?=
 =?utf-8?B?NzV5TWhRWCs1WjQzMmg4R0F3a1h5N3poMFk1SE9qZ1cwYkd2TXdVSGROeHJB?=
 =?utf-8?B?UkM3T1NIQWcwc0l5UHZyNHE2VXowYWNndEhoWStsN0p1ejlKdW5oWmE5a0Jw?=
 =?utf-8?B?U1BzN3JXRlNUdlRtZ3lESU40SWdXcFpkeGwyY3RHb2JDNE1VWG1US3p3WXRk?=
 =?utf-8?B?MlJFSVRpR21VWVZSZHpWZXFZSENjdGQ2MlZ6MDZGc1IySUVndUE1OVphaWkz?=
 =?utf-8?B?aGlIRjIwY1Uxck5NV2lvWjJUZ2ZHV05nalJheWtZT3ZMRkNqRWgrempMSmla?=
 =?utf-8?B?YSt3NFRhRWUvNkFicm9LVElvRUFtNGZ3clFRN0k5dExtSU4vY1I5ZnRaeHZv?=
 =?utf-8?B?NzJuUlNDb3M2NVBWTnJMSU5jcXcwMVh0WDNCVDlYZjBKTE9zRkM4NjNVV0Uw?=
 =?utf-8?Q?nw1ecISQrwipr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTJIbnUvTFVMT3Z6UGp2ck9SdjBYS3JnbnZLY242TjNudUlFWklKV3dhb0FW?=
 =?utf-8?B?b0l2MEN6QzhicUxKQVl0WHNBWldLMnZMYUppNGhyMW5QL2RPYXVDSEJDeG05?=
 =?utf-8?B?bmF0bDlIZTNOOVYrRVRrUzdoWmVTRWpTVjVsMHd0NHl1d2x0WWZUVnZwZWk3?=
 =?utf-8?B?R2ZhY2VTT0dlSjFTbDlrRHV6V2tjejVxM3BqY25mSVkxM1NCYVpTZjdMWFFK?=
 =?utf-8?B?bEFiUHBoQTlXQXEyeWlKeE0zcElTL1FxR3ZJSWFkRWhoR29uR0tEK3oyVUNZ?=
 =?utf-8?B?NFhMWGlqS0diU3N4b2d4dlJuOFhoSkRTWXNxSTB2eWE3LzRaUHBVMlBIbFhV?=
 =?utf-8?B?d3ZqMnEvaUd6OHBVVmkweTlWOXBCMkNKeXBhTnMwTGZ0NmtIbDRMSWNvRTlU?=
 =?utf-8?B?K3lEcDVJc0tRa2c2bXpVRW53QjlJWnNxRVYrU3laMmgzQUErTDdEQ0ZZcjN3?=
 =?utf-8?B?R1hUTWtZMFREUHFGQ0hlYkVoVnJTRXpUbkN3NThzd1pScy85bmE0akptd08z?=
 =?utf-8?B?bnJORDcyeHdmQkhERk83RTlvN1dGQ0Y3a0hMa09xR2U0NGMxV3BpdUh4RXFI?=
 =?utf-8?B?SjMxdkt3TEJFOTlWU1JSQWRxV0t6eUgrSC82Q3RYbjM1S05TbHdyZXBaYXBo?=
 =?utf-8?B?bkErUVp3RGhISmlxVnFCVm9YUEVlTWIrU0RaVTNud0ovVDZqV2FOdndjc3BJ?=
 =?utf-8?B?LzFqY3dpVjBiNTh2OGlvYUxEUG1kM2tQeFhldG5xVmJSZnc3dW5wVERWZzFz?=
 =?utf-8?B?a2h2VDJhVFVjNndLTFEvajcwNkRPUzl0d3pIaHZBNUhRbk1xNWxSelF1K0Vv?=
 =?utf-8?B?L3F3UGtFYTExdUp1b0pJWVlKT0RXQ0crY0o1dTNoNml0NmtJK2dkOWJwRjls?=
 =?utf-8?B?S1YxSDFrQnVqMTA2YnpvZnZna1Znc2pGSldhVmVxYk9PdzJwaS94UjFtQmYx?=
 =?utf-8?B?MnlPaFV5KzBvUHVDYjk4enFxUmhaWGJ6Yzk5aVJhcEZSZzRMYnc4MmhsY3hD?=
 =?utf-8?B?SnlXcERYS0tXekkwQzhIa3BqUzdubHMvbU9BRkREVmRHTHR4VGpvN0YxWnc5?=
 =?utf-8?B?RmZDcHNLTFJZck1EUGl4Z1lBYVg0ZktiU2d0dTFlb24rK1RDcHgwb3NneEVk?=
 =?utf-8?B?MHl6cndpeTM2dGNNMnJ1N3NnTzRxVTdkdkxaQmx0cFpMWWZPZGI1SGtGQjFJ?=
 =?utf-8?B?VmI4VDFPeGdYYWYxcHF1N2FEU0FnWUlJcW9uL0hCK0J5ZERiNytFbWJuRFdB?=
 =?utf-8?B?OE4rRFU4TmxPdVlFOHVmd3lPQktsNnIyVU01cG1DZWtkRUJZWjdscm5XUDZK?=
 =?utf-8?B?QkROQWRTbXBFUXUxUGlYNlJUYWtlUkUrOThJSjZZOFdxV0UvZGQzZit0bWNi?=
 =?utf-8?B?bkR5ZFlzeDZERHhVS1JKOEUzanE4eWxkOG4vZE0yQ2Ztc3QwZjV5Ty9VYU93?=
 =?utf-8?B?QVhNKzYvR2ZwVFVldTh3UVllbzNNVXhaVFFwU0dLcnpSMFRsUDJELzE0VGFR?=
 =?utf-8?B?WHNpN2pCcWlXZ0o0UUhWaTRnMVJLNDlsai8wd3d3ZVJvMTJ2aHh4allucjNS?=
 =?utf-8?B?NkNMblR6NUNHRHpZUlFzL1VVMDZkZVBIS3ZNZ0UzSGp0dmp6WnpzREs5b252?=
 =?utf-8?B?dTFNK1Z4d1hsMDRBdDgzdWp6aTIxSXlrWitSNytGSmFROVYvNER5TDFMaHM4?=
 =?utf-8?B?RVlzU0dmWGZNUlZuSnRsVmdpOGh0TUQ5WXRmT05aQlk0WllxMUUwNEJPTGQz?=
 =?utf-8?B?UVM0Q3FDRmx5OC9kYmM2Q2p5S2NDOFBxL3M4THdYeWdZYVdnTGRjS3dFaWJp?=
 =?utf-8?B?VDRYeWRCYXd0M2tzMzJzRUhQL2JGa2dkOEVlbDJMRmltZ3dWd2dMZjJSOW0y?=
 =?utf-8?B?ZWRBdVh1UGFsNW41M3FveXltQjRuV29MejNmdjFnVmpoRnp6bTRDUlowUjRI?=
 =?utf-8?B?VTFSLzVrRVJqbld6SHhTd2toQlNranBQYmxVNVhKYmgvTlhsOVduRHlSelpT?=
 =?utf-8?B?TTJlVnVUU3V1dmlaUk1nRExqVnowVTkyNjNEbmc5RXFZU2QrQ01oQ21sQWlm?=
 =?utf-8?B?aWdGVzkzL09uY2JRQkxDOVlxZCt5Z3FuaWRTNFljMllPd3dFcXNlTVU1Zkk0?=
 =?utf-8?B?ZDJnMk1SSk9ybk9JV3BxSjhIdDJZYVBKZ3F3bmdmSFVXVUhodEFZV3FER014?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e981a9d4-6223-4f61-29b5-08dd4782c636
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:21:55.6765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtpYXUrZ4eKiY3HVfD7SCZ00aar/8LPcAZPRVCMLpUMTrvZEwqM/ILr6KMxstONLP0GKyycjPFGfN5QYHj5asXvHw6mIoarcQ3iIcBUIM8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7302
X-OriginatorOrg: intel.com

On 2/7/25 12:56, Alexander Lobakin wrote:
> From: Eric Dumazet <edumazet@google.com>
> Date: Thu, 6 Feb 2025 19:35:50 +0100
> 
>> On Thu, Feb 6, 2025 at 1:15 PM Alexander Lobakin
>> <aleksander.lobakin@intel.com> wrote:
>>>
>>> From: Eric Dumazet <edumazet@google.com>
>>> Date: Wed, 5 Feb 2025 18:48:50 +0100
>>>
>>>> On Wed, Feb 5, 2025 at 5:46 PM Alexander Lobakin
>>>> <aleksander.lobakin@intel.com> wrote:
>>>>>
>>>>> In fact, these two are not tied closely to each other. The only
>>>>> requirements to GRO are to use it in the BH context and have some
>>>>> sane limits on the packet batches, e.g. NAPI has a limit of its
>>>>> budget (64/8/etc.).
>>>>> Move purely GRO fields into a new tagged group, &gro_node. Embed it
>>>>> into &napi_struct and adjust all the references. napi_id doesn't
>>>>> really belong to GRO, but:
>>>>>
>>>>> 1. struct gro_node has a 4-byte padding at the end anyway. If you
>>>>>     leave napi_id outside, struct napi_struct takes additional 8 bytes
>>>>>     (u32 napi_id + another 4-byte padding).
>>>>> 2. gro_receive_skb() uses it to mark skbs. We don't want to split it
>>>>>     into two functions or add an `if`, as this would be less efficient,
>>>>>     but we need it to be NAPI-independent. The current approach doesn't
>>>>>     change anything for NAPI-backed GROs; for standalone ones (which
>>>>>     are less important currently), the embedded napi_id will be just
>>>>>     zero => no-op.
>>>>>
>>>>> Three Ethernet drivers use napi_gro_flush() not really meant to be
>>>>> exported, so move it to <net/gro.h> and add that include there.
>>>>> napi_gro_receive() is used in more than 100 drivers, keep it
>>>>> in <linux/netdevice.h>.
>>>>> This does not make GRO ready to use outside of the NAPI context
>>>>> yet.
>>>>>
>>>>> Tested-by: Daniel Xu <dxu@dxuuu.xyz>
>>>>> Acked-by: Jakub Kicinski <kuba@kernel.org>
>>>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>>> ---
>>>>>   include/linux/netdevice.h                  | 26 +++++---
>>>>>   include/net/busy_poll.h                    | 11 +++-
>>>>>   include/net/gro.h                          | 35 +++++++----
>>>>>   drivers/net/ethernet/brocade/bna/bnad.c    |  1 +
>>>>>   drivers/net/ethernet/cortina/gemini.c      |  1 +
>>>>>   drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |  1 +
>>>>>   net/core/dev.c                             | 60 ++++++++-----------
>>>>>   net/core/gro.c                             | 69 +++++++++++-----------
>>>>>   8 files changed, 112 insertions(+), 92 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>>> index 2a59034a5fa2..d29b6ebde73f 100644
>>>>> --- a/include/linux/netdevice.h
>>>>> +++ b/include/linux/netdevice.h
>>>>> @@ -340,8 +340,8 @@ struct gro_list {
>>>>>   };
>>>>>
>>>>>   /*
>>>>> - * size of gro hash buckets, must less than bit number of
>>>>> - * napi_struct::gro_bitmask
>>>>> + * size of gro hash buckets, must be <= the number of bits in
>>>>> + * gro_node::bitmask
>>>>>    */
>>>>>   #define GRO_HASH_BUCKETS       8
>>>>>
>>>>> @@ -370,7 +370,6 @@ struct napi_struct {
>>>>>          unsigned long           state;
>>>>>          int                     weight;
>>>>>          u32                     defer_hard_irqs_count;
>>>>> -       unsigned long           gro_bitmask;
>>>>>          int                     (*poll)(struct napi_struct *, int);
>>>>>   #ifdef CONFIG_NETPOLL
>>>>>          /* CPU actively polling if netpoll is configured */
>>>>> @@ -379,11 +378,14 @@ struct napi_struct {
>>>>>          /* CPU on which NAPI has been scheduled for processing */
>>>>>          int                     list_owner;
>>>>>          struct net_device       *dev;
>>>>> -       struct gro_list         gro_hash[GRO_HASH_BUCKETS];
>>>>>          struct sk_buff          *skb;
>>>>> -       struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>>>>> -       int                     rx_count; /* length of rx_list */
>>>>> -       unsigned int            napi_id; /* protected by netdev_lock */
>>>>> +       struct_group_tagged(gro_node, gro,
>>>>> +               unsigned long           bitmask;
>>>>> +               struct gro_list         hash[GRO_HASH_BUCKETS];
>>>>> +               struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>>>>> +               int                     rx_count; /* length of rx_list */
>>>>> +               u32                     napi_id; /* protected by netdev_lock */
>>>>> +
>>>>
>>>> I am old school, I would prefer a proper/standalone old C construct.
>>>>
>>>> struct gro_node  {
>>>>                  unsigned long           bitmask;
>>>>                 struct gro_list         hash[GRO_HASH_BUCKETS];
>>>>                 struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>>>>                 int                     rx_count; /* length of rx_list */
>>>>                 u32                     napi_id; /* protected by netdev_lock */
>>>> };
>>>>
>>>> Really, what struct_group_tagged() can possibly bring here, other than
>>>> obfuscation ?
>>>
>>> You'd need to adjust every ->napi_id access, which is a lot.
>>> Plus, as I wrote previously, napi_id doesn't really belong here, but
>>> embedding it here eases life.
>>>
>>> I'm often an old school, too, but sometimes this helps a lot.
>>> Unless you have very strong preference on this.
>>>
>>
>> Is struct_group_tagged even supported by ctags ?
>>
>> In terms of maintenance, I am sorry to say this looks bad to me.

I get that it's not in good style to impose "new style" on the old folks
(esp. Founders, Maintainers). I agree that our drivers are just a random
sample in the pool of drivers, and it is not clearly a win-win to have 
us experiment there with "modern practices". But this particular
contribution from Olek is for benefit of all. It will be also a great
example how to use struct_group :)
I hope that we will get more struct_group usage, it's really great
mechanism to keep/pass only a part of the bigger struct (and zero/don't
care about the rest).

>>
>> Even without ctags, I find git grep -n "struct xxxx {" quite good.

I also use mostly grep to find stuff, including the ` {` "trick".
And I do add wrappers when it gets tedious, here is a one for tagged
structs:
function sgrep() {     # here is the pattern: vv
	grep -EInr "struct(_group_tagged[(]| )$*( [{]|,)" |
	awk '
		/{$/ { print; normal = 1; next }
		{ tagged[tag++] = $0 }
		END {
			if (!normal)
				for (t = 0; t < tag; t++)
					print tagged[t]
		}'; }

awk resolves the complexity of "struct something," being sometimes
a parameter of a macro

> 
> compile_commands.json (already supported natively by Kbuild) + clangd is
> not enough?
> 
> Elixir correctly tags struct_group()s.
> 
> napi->napi_id is used in a lot of core files and drivers, adjusting all
> the references is not what I wanted to do in the series which does
> completely different things.
> 
> Page Pool uses tagged struct groups, as well a ton of other different
> files. Do you want to revert all this and adjust a couple thousand
> references only due to ctags and grep?
> 
> (instead of just clicking on the references generated by clangd)
> 
> Thanks,
> Olek
> 


