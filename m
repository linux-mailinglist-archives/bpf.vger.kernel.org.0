Return-Path: <bpf+bounces-51982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E0A3CA90
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4EC3BB69D
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB2C24F5A9;
	Wed, 19 Feb 2025 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4Nr+edr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37A24E4B4;
	Wed, 19 Feb 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998484; cv=fail; b=DHFzb5jQNhQ8zpZ4VRAO58EIsFrZGwC5dSIazsQSGm0/l6IvMBtTI5Z5vGfZpDQDmeP8LqIWn5pVhCMqPFmAksmZxC6boxF/p9rEDGzWwQe6T7stwbPt6jZtD55MzBpk/MVFJm8yyBgR/kY79LgSbRheQBgYSaxwR/QvhR/1nJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998484; c=relaxed/simple;
	bh=xqdd3x1xJhOnUodftc8hB6QvW9IaP5VqP7FcCmR6g50=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YC53QPfaG73z/lweusnlDga5RujBGN4WydR5HhcSIEaT9xbkJfRk/yW0uQt5Uucm5QjV7YEmvIwHNgmi6zgsIso4wo992+LXZpd79u4kxzmv8P44Fm+Fj+Wz4WhFYa95i6hqqG64Jd1RyJBMKbsbrEd+G3zMvX7AvKrrzSlHasU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4Nr+edr; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739998481; x=1771534481;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xqdd3x1xJhOnUodftc8hB6QvW9IaP5VqP7FcCmR6g50=;
  b=l4Nr+edrhJFIi/yG1+mHdOJWykmPVNi0rmSXAPnTJKxYTBzN7ZsU5FYG
   i/JzLIbLXcBl+rL3QXGGaUWecB0cthgIkN8BgXI4zJIAjO6k6TvtWr9OQ
   bJnbn4H24W+E3+DVCNGYORxlP2eQsRihKhjN3Ngnq8tUtgKvn2vm2gRkR
   WGc8NJdp9Fzbb2ZtkVLKMTOQ4V/VXbkCTZiiEZx3pFY5+2C6BVFTD06JA
   KLtrdnxuBRpbQx15B+nVzszpZ/fq0GIFkbTEnfzI4t/R7gBubpAkc6eFo
   IGarrtEyuvg/0J9wN6raGexFAvqhHE+4Nhw5cGsSqLNIgIVtS6qd+iLFJ
   g==;
X-CSE-ConnectionGUID: SfLLjgFgRlWByqmyJHGgmg==
X-CSE-MsgGUID: vPGLTcPZTlySKScP+xrfJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58299356"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="58299356"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 12:54:40 -0800
X-CSE-ConnectionGUID: HY+06/bzSRqtFzrjG5oKXQ==
X-CSE-MsgGUID: ZYOajQ1oRB6ajcYr3Vp48Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114572648"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 12:18:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 12:17:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 12:17:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 12:17:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEH2pbMCWvKAJz9CapGzdP9rWfp6vQmE19J3qZ1TJKCOtz9lGlLOYYXhSDXsltz1R+KRqW5EcHQCDmh+NRBj9s9wS07f6ekekIa80qPZOdkwNq7fTCOYMljdNlclRM7RMfFAM7r102KSgRCd8oYrPUfT75d4dAG/3zWwMmHeLbpVpPKUNrHArElFSN+SFhlAOa1SLW7m+4W1A+txfDeRNec27QNP49+WI02VzyIIT7LOlh6z4WG+1s25x2EQjnSOnsveSbHIeapCmIVqdyTGl7BkIOZteTTm2YjHkin4J1k1/3vD8u2yQ8732bx2MZxnpBNwAxkxNgNnJBbGEcHAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28PcdZHOyhHkQcfruJOTzHmEyytBQBvyA+829bYi0GQ=;
 b=XCZYPQf7fEvYCnXm9UUp3JJerl2TfVKQgvzxeA7yCrFYfLWkIoHkMafNl8rrF+y6W4nkY+J+tNBZgJ3TlowiOdqSjtm3PWv+qp5z2N8kjv9l1i9lLFcCG0WxK1MU6M2/770ux4j+dvJ4mnIWDcPYnJKR5N2qek6X6pR179AxswHiPUcOnvNB1zW1/r0SmW6o/jb5e+MgrpVtHXA9giBlYV0HPqBXlxVJfhKoAYoJqvYPvv8I0pcq1aFjN9Pxcs2ePm1WcYJzymF82GIm37oAFZZ0eigGQzCMxorSycoandp19JeRn8bGRgZ7On+Nf+00RCwiuuFfQuRm4DvyOS3Mig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MW3PR11MB4667.namprd11.prod.outlook.com (2603:10b6:303:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 20:17:54 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 20:17:54 +0000
Date: Wed, 19 Feb 2025 14:17:48 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Gomez
	<da.gomez@samsung.com>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
	<samitolvanen@google.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	<linux-modules@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf
	<bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, iovisor-dev
	<iovisor-dev@lists.iovisor.org>, <gost.dev@samsung.com>
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
Message-ID: <qnfhjhyqlagmrmk3dwfb2ay37ihi6dlkzs67bzxpu7izz6wqc5@aiohaxlgzx5r>
References: <CGME20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c@eucas1p1.samsung.com>
 <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
 <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
 <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com>
 <Z5lEoUxV4fBzKf4i@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5lEoUxV4fBzKf4i@bombadil.infradead.org>
X-ClientProxiedBy: MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::26) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MW3PR11MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0156fc-374f-4caa-8ae5-08dd51227daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjFKb0hLamdHRzdNcEVVK01ocytVcHJDclgxK3RFWFdlQXZjcjZwRXBYY3BV?=
 =?utf-8?B?cXY3dktjZjF4ZG9KbkVkbGJ2MURrU05tUGRpQmpsQ3BVYU5XcFhXem1GZW9q?=
 =?utf-8?B?TU1xUndBblFrVFhxakNJc2I0Z2QwcHQ2TnVXZVBNZ25nNEtaTnhOY09KQWlr?=
 =?utf-8?B?cElpS1cvdTIxNDNhL2FFMzdsTlZpclJmdnl1Y1RkZXptdzdPOXZzZXdia1V6?=
 =?utf-8?B?RFlLeDNkbHNWa0RGb2gySzVQS3BJWUFicW1pblF0Z21PTkU2dEFXeExnMXZx?=
 =?utf-8?B?KzRmKzExNVNaUE8yc3hwRzhSS0trTEs4cWpzTUdoeUVxbEhSWVJVZVBZakl0?=
 =?utf-8?B?NjNQQ25xdEFDSnVBdERIRVlzUkp4NFV3N1pPMG1wemtvU0pqTkFmQklQRDQy?=
 =?utf-8?B?M21pVjkzVmNWK1VDKzB6Mm9ic010MW05UjR0aU1pRFdkYUtmTGh6MDQrUG1m?=
 =?utf-8?B?ZER2TmE5T1Zmb1FSQU4yMTRNYWdxZlVOOUluMEhmS1BQUytYS1ovM1NpQTRT?=
 =?utf-8?B?YjNuVWJQM0JwdC9UU2hKcEdBYmRQZE44b2d6ai95bjhQcldXNFBlcm9IbGlr?=
 =?utf-8?B?VTFFRE4zQ3pjVENrVVdnUngxQnloZXlXSTllZ05QbHVmcFJMMXdraVhxMzlF?=
 =?utf-8?B?OXVRVmJlUEJQblQwSlhQZVhvWUpocTBzSzNpNXc2WWZCRFMrcmw0M2J3K1Vk?=
 =?utf-8?B?WW5YaFJsNDQvM1BvQjhpR25tZlVOd1RYK0dsZTFTUHRDa3dtdkRQYm9nbEpT?=
 =?utf-8?B?ODc4dnFqalZBTWE4Sk8xQ3VjRFIySGxLU2NybHkzVmdUdWVrUVUwbnMrS1BB?=
 =?utf-8?B?R3EwM2ZYVDQ0ZVFBUHdkRmJVa0JHS0F4SWYrTnN3bGl6Y0hDaW92a29CNG0v?=
 =?utf-8?B?d2VPcG5TNllPVE9aVHpqWHBFbjkxNmMxZFVOL2JoNTJpQkhrOEw0YWtlQndr?=
 =?utf-8?B?cVBKS1BpT2lXSmRtWGRIa3Y2eE50NGlsQ0cvbkxYSDZUNjFmaHBYd3Z4M0dD?=
 =?utf-8?B?Vkh1ZVNhSjk2V3FZOHJaci95SlhGVTV0UG9ZOGo3NXVzWnJNaFMzT1hKRVFT?=
 =?utf-8?B?T0pLRWo2ZEFrc29vZnh6ZzlRdG9YNW4wWXV2RkluL3FIQmw3dUtRQkkybUt2?=
 =?utf-8?B?SG1yWFYwUkR6SnRqREtCbUpsY29OZituMVV1U0lpZkhrSUQvWC9RRUs5bkxz?=
 =?utf-8?B?T3JmU25MV1E2dTZOMHFSTWw0WEhKSVpKZVllQlNuUVpXM0pPNWo0dFZKRnJC?=
 =?utf-8?B?N2ZCUWlqTHM5ckN6S05VRnpMbDNoYk9EYW5CRUZtS1NDVk9iMC9hUEZRK1RY?=
 =?utf-8?B?dFIrVjNFQ3VjdUhXMnRkbFB0ZWZJNFF2YkdaTjJZMjA2TmRPNzBVZkhVUnd1?=
 =?utf-8?B?VC9FRHNOTHd6WTJ6YjBURndlK1k4aEdCNjA1NnZnU2tYMm9TME41QnNRaFI4?=
 =?utf-8?B?VmpjQ3N3ZnNDRk1ibEpEYVFMSFRjc1lFWEhmSllYT0ppUXRoUGtxSFdFZTMx?=
 =?utf-8?B?YjUzUGhOOU41dnA2Zzl4Y2RsVmZsTDBoaUJvQlZWRjJwWjI3TWNUV0d3ZjR0?=
 =?utf-8?B?ZzhGaWpzam5vSVNRZnF4QmNaRG9JRVNxeGpDTG1ueWN3Sm1uNFNUeENpSzg0?=
 =?utf-8?B?bGVGYStrOUNNSnhUQnI2QkRTZ0Q0czFSQW10L1NKZTBMOTBSM0V5UmU3S2Zp?=
 =?utf-8?B?dFQ3d1pqRVduTDFLTCt2QXRwUVJCdmNDNk5ITHJZeTQ4VmVTdkl0Z21iVG9W?=
 =?utf-8?B?b0RqcTZVOEtNdEk4Zi9vYzZ3Rk9mUGlYeDZ0bVVHMG0rUndEMFZTckpKaVBP?=
 =?utf-8?B?MndLUWt1ZU0vc2dEZ2h2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGVESlVXcnB5UG9nbEx2Vm1HajBMM1dCeURsYS9vY0xnRzVzS2JMWEZpS2xI?=
 =?utf-8?B?eitDV1lDM2JFNThoSncvS2FLVmtJeUZBWnVjOU9qL3p4cWpiVVBNa2xzUFRw?=
 =?utf-8?B?QTNkbyt3ZEt4NmJQOVd6UmI2VFRsYlRiaGVLeXFDeWZKc21mRytROTRWcWtC?=
 =?utf-8?B?WmM1aEl4VExWTHhJRklOemNHWFQ1RXk0RlZRWnAxdWdNa2l2NDk5WCtMaVhX?=
 =?utf-8?B?QU1XWmxYWHpJVkVxaW5jUjhjYTF3MTZ1WlVhUWw5ZjFuaWhDQlM0TStBc1ZQ?=
 =?utf-8?B?UDRYMDF6b3VTWlhMMWpPZ01nMVRnUWhLN2NCQVlrVzZ1QWtUaVdjMGhKSmx4?=
 =?utf-8?B?TVdSWWFyN3JidFpVRkxsYytQejdOK2UyZ3FwWG5RMVEvcXRKZGQ0SHdvcmYw?=
 =?utf-8?B?V1B0OHRRZHlwMG5LRVJFeEllWExRekpzckpMMkJUYUhUVGhNQnRHN2dEMzBY?=
 =?utf-8?B?OFVRSVYzVncwMU5PWFQ1NE8vNmJSNDIwNFRuT0w2NUpVY29yWks3RStQaHRa?=
 =?utf-8?B?REV1cDVpcU0zOGhDVnFreFU0TWtxekdtaU5DcGlQaFQ1SkJIQWpDRXFIWmlS?=
 =?utf-8?B?MnpXN1Z6czRxb3RJZjBVeXYyQ3NzcFhjeVBlVXk1NUNHNC9wMnBaSUE2a2hz?=
 =?utf-8?B?b0VoQS91dy9ZM3c2NGt5SnVQTnhmd2V1M25GdEJXbWt2T2hZUldoQ2JkZ3JS?=
 =?utf-8?B?NHlBZU1hRnU5OUtGS3FnRUFvc3Z0UG9IREtvYldvN2dOdUdJUkdZYkNkZVlX?=
 =?utf-8?B?c25QOGN4LysrbEVERUdrWHZUK2Myak9xQ1RGTDV3eVR5UzhhZ1RtQ29ham1D?=
 =?utf-8?B?VW9HTTY1NmFNazlCNlowcjlodythV2pwY3hCaFZ0V3NrNFdDQlAyNXA3Z0xY?=
 =?utf-8?B?Z2YwTEI0b09GMDJYZkN4RUpVVm1HemxycWNMVmtUQXZqZDkyR3V2dG0xLzdV?=
 =?utf-8?B?MjhsZHRJZCtZbXE2c3h2ZzR1WHJIVG1QVStvQzZ3OXNDSHpsYWwyUlJVVWhU?=
 =?utf-8?B?ZEdHT3dUUkJYSlFjRVVQa2xUQW42dVVMTlcrQmtWa0YvSjAzb0MwNGpQWEQz?=
 =?utf-8?B?ZTlBYWFGV2FQRHJTZUh2VCtiSlFIM1pEd3JQd1JTNDA1bCt4aWdNU21TczJy?=
 =?utf-8?B?TXFQd1FKc3dDdS9CVHZDL0tMQnlXdTJuK0tDMzBFRTJHT2t3Zm5qaUUxT3dC?=
 =?utf-8?B?YW83OEw4Uy9BT0VWeVhwc1FDbSt1VGNhNjc3dHljWUZUZ0RkRVIzUmUyWWxv?=
 =?utf-8?B?a1hMcGQvQTFjTXlMa2dvSnhMSzZPeVNzWWZKNjBWQ1h4dnBScXhyT2FSbERa?=
 =?utf-8?B?YWtqL0p4RzZ0aTFCcDc0aGxYRnhMU2ErNWZ2bHY1cUNkSzlJR201TlZNWU9q?=
 =?utf-8?B?MHh6d0k5aVNBOEExL3VJT0NlUjcwdklSVTF4dmtXYjQyNkcrWHJOVXBENTAv?=
 =?utf-8?B?a1VscW1SOXRTaVRhRHErWDhEVXdsdXh0MDIyUGllSDZpS2RpQ3RTT05HdG9P?=
 =?utf-8?B?Vzd2bjlXNi9WSzZxTE0vNHFYTStKZ2Z6a2loNWFDaGNZenBxY1A4VFVsYkw4?=
 =?utf-8?B?R2lRNDdNakw3SEZhKzR6Y3hrWk4rRVUrV1JUMmkzYkx2NHZVOTFaRGcycWRD?=
 =?utf-8?B?eklNaHBJWnBEaW9iSWVILy9ydTVTQVRZL2VWMzVta3c2OGJwNnpRbncrMFFT?=
 =?utf-8?B?dlpFWGZMV3d0KzZDcU91aytrbVpEY1dmaTZWOTBJTnNockwwMkRzV0NlRGpV?=
 =?utf-8?B?TUhtQlhodFJDbmZITWh2Zkh0VEh5dFE0QytPWXBTbVQ1S0VFZXFYcjFaYVFL?=
 =?utf-8?B?Ym8xSnB0RmRUdjBMSnB0YkUra3BNNE8vVnJZY3pITkpSZGUwUXBQMDVha1h0?=
 =?utf-8?B?WTk4SzBMS0U4Ky94V0w3T0M0eHJFZVc3cGdPenQvZmxFQWVZdzRWVnRQT3NJ?=
 =?utf-8?B?d2hPM2NEdVY5WVJ3NDBDRUtPdERmU1k1VjBOR3pPYm83dzFJZ2VLRVk2aVo3?=
 =?utf-8?B?ZW1OZk5xcndpM3VlamVRTzFVdXRWdHZobklMT0t1QktBcVdQOTZySCt3NUYy?=
 =?utf-8?B?TXk2TFdHenI4WTdVWU9EVitWR2NWdzNaYnF5U2ZFYkhqbnJxTzQ4OVVWSGtz?=
 =?utf-8?B?TmtLcnEwZlZiUldPWkYyKys3MVppY2o5ZWFsWFl4Q2c4bml6OFJWZkdJME00?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0156fc-374f-4caa-8ae5-08dd51227daf
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:17:54.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mF9JQUvDDaSZF9ln87mheWGmrxUoJBi/e72HG7MHi/VIFTVAvoQwo975H6ak5+UOqKQTWHfQAWwKj0kZbhr1l2AmQJNoVO+uLLxsURdwX4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4667
X-OriginatorOrg: intel.com

On Tue, Jan 28, 2025 at 12:57:05PM -0800, Luis Chamberlain wrote:
>On Wed, Jan 22, 2025 at 09:02:19AM -0800, Alexei Starovoitov wrote:
>> On Wed, Jan 22, 2025 at 5:12 AM Daniel Gomez <da.gomez@samsung.com> wrote:
>> >
>> > Add support for a module error injection tool. The tool
>> > can inject errors in the annotated module kernel functions
>> > such as complete_formation(), do_init_module() and
>> > module_enable_rodata_after_init(). Module name and module function are
>> > required parameters to have control over the error injection.
>> >
>> > Example: Inject error -22 to module_enable_rodata_ro_after_init for
>> > brd module:
>> >
>> > sudo moderr --modname=brd --modfunc=module_enable_rodata_ro_after_init \
>> > --error=-22 --trace
>> > Monitoring module error injection... Hit Ctrl-C to end.
>> > MODULE     ERROR FUNCTION
>> > brd        -22   module_enable_rodata_after_init()
>> >
>> > Kernel messages:
>> > [   89.463690] brd: module loaded
>> > [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
>> > ro_after_init data might still be writable
>> >
>> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>> > ---
>> >  tools/bpf/Makefile            |  13 ++-
>> >  tools/bpf/moderr/.gitignore   |   2 +
>> >  tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
>> >  tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
>> >  tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++++++++
>> >  tools/bpf/moderr/moderr.h     |  40 +++++++
>> >  6 files changed, 510 insertions(+), 3 deletions(-)
>>
>> The tool looks useful, but we don't add tools to the kernel repo.
>> It has to stay out of tree.
>
>For selftests we do add random tools.
>
>> The value of error injection is not clear to me.
>
>It is of great value, since it deals with corner cases which are
>otherwise hard to reproduce in places which a real error can be
>catostrophic.
>
>> Other places in the kernel use it to test paths in the kernel
>> that are difficult to do otherwise.
>
>Right.
>
>> These 3 functions don't seem to be in this category.
>
>That's the key here we should focus on. The problem is when a maintainer
>*does* agree that adding an error injection entry is useful for testing,
>and we have a developer willing to do the work to help test / validate
>it. In this case, this error case is rare but we do want to strive to
>test this as we ramp up and extend our modules selftests.
>
>Then there is the aspect of how to mitigate how instrusive code changes
>to allow error injection are. In 2021 we evaluated the prospect of error
>injection in-kernel long ago for other areas like the block layer for
>add_disk() failures [0] but the minimal interface to enable this from
>userspace with debugfs was considered just too intrusive.
>
>This effort tried to evaluate what this could look like with eBPF to
>mitigate the required in-kernel code, and I believe the light weight
>nature of it by just requiring a sprinkle with ALLOW_ERROR_INJECTION()
>suffices to my taste.
>
>So, perhaps the tools aspect can just go in:
>
>tools/testing/selftests/module/

but why would it be module-specific? Based on its current implementation
and discussion about inject.py it seems to be generic enough to be
useful to test any function annotated with ALLOW_ERROR_INJECTION().

As xe driver maintainer, it may be interesting to use such a tool:

	$ git grep ALLOW_ERROR_INJECT -- drivers/gpu/drm/xe | wc -l  
	23

How does this approach compare to writing the function name on debugfs
(the current approach in xe's testsuite)?

	fail_function @ https://docs.kernel.org/fault-injection/fault-injection.html#fault-injection-capabilities-infrastructure
	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/intel/xe_fault_injection.c?ref_type=heads#L108

If you decide to have the tool to live somewhere else, then kmod repo
could be a candidate. Although I think having it in kernel tree is
simpler maintenance-wise.

Lucas De Marchi

>
>[0] https://www.spinics.net/lists/linux-block/msg68159.html
>
>  Luis

