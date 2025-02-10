Return-Path: <bpf+bounces-50996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F510A2F22E
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 16:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD2B1630DD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE0E243956;
	Mon, 10 Feb 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmjDyzEB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1A241C89;
	Mon, 10 Feb 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202796; cv=fail; b=DxrWcwlRE/hPkTtN55IclfTCZOecXt1zW0U54wEArO7URbgV+9jea/TwJHM0gHINq6AkOYlc+d0YpaqtGBSteSxcNQCYQ61O5xO9nrbaLFmZGSO39+gpwkzlfqPXxJCq6LPhIBWMrcPFKiUtBujsBoSpsSzA2Fgk8sUmHQeKqJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202796; c=relaxed/simple;
	bh=nxY+2aduu4hYme/4OWiYXbTXl2NrQZ4RgStD3YbvjBU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+IrZTqBimLSqxtwpcypmjHD6S8zgTEfXFQ/fXeRGonuV3SFcNEjpKFzjtqkfeezwKy1zW+eefg6WacKM4U4XIt+QVxMDgELYwVX37KJDoVHliiAaE1Z3Eb/CeedXgSvRpy+1IyO2AwXElO27pkrsbUGup4xc7Iky85Wnyr+cWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmjDyzEB; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739202795; x=1770738795;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nxY+2aduu4hYme/4OWiYXbTXl2NrQZ4RgStD3YbvjBU=;
  b=NmjDyzEB60eB9uiAdV9gfrgNR2Vd7rnpLRe39P4MqVnRVTE2RKq3B6q4
   2cehBGaYsvaO3AphrblZpq0988jI1o1NFTPqsF8m6o5yJ2X/oC/AwtQa2
   9BNQAn9JTgxfxmOuGzyIUSAsvObRDqcAUoH1D3HLXQ6Fc0utT6AbFy+cx
   xcw+ZQHwwjJOpQJLSGwzFCtgIsEA//ZOTITXVewVR09aVlWkjVoWGDLS0
   34L7rPZE/USdIouDT/55A+AIZI6R/B1x0Hfh9MDiZ1GaFEkhJAfoFrAIo
   4gwUSdilL+zf+u2jBiHQqoz6NQ7WAy/bs6HVB1c8t3WKjKGTKgAP10OEn
   w==;
X-CSE-ConnectionGUID: YfA/ERufToeU50h5Cbemug==
X-CSE-MsgGUID: EgiH1pwySlWUCseq6Av42w==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="42629930"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="42629930"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 07:53:13 -0800
X-CSE-ConnectionGUID: oNIvvpECSEyfuj4QAgDlEA==
X-CSE-MsgGUID: VymW5GxeQYSZ0PQXVagLPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112183172"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 07:53:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 07:53:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 07:53:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 07:53:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7VKmWBAhxzF2PnzEuwbkh4/vZd0inwjdenPHwqx9k+NFA+pwGUNO514rH+X+Xx4VTFv8hgauWSr6RL3oL17NRgapBrpKQkLPivfUvyNutnINQn5x9foa3+09ZQTTkggA3/jf1OkcNvrAavQ6Dpk83Gdb4wI1dDgOfF6lPKJFtOlXNI7zEHkjrYmzi8eoUuNvPvqUPRZ7LCKIioBHQnA0EdEvx8k/23ydZgCbsa65k7mIZ5dIreR+E4+b3yR2UvVq20SOmYrG7UFIph0FtJU7+JNiQwdYO0wqHkQ6hBm3S2DjTBeRLNEJlceWCe+rtxYsf4t9ZhDpAdaFoIifqL8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wzw8j3pbdypLDB8L58TPx2aZlKBb3ueZhe+tw0w431g=;
 b=F2T0G/JwFF6LRj986iXRRwRxc0E0q8ObKaca52g5A47Mm8fD2AbOinTO4xgwrCzMqCPVRZLv3tNHQXI5npUJ14CEx4rJrQ6B5FjfgzG6aYjzlKmYFTRGDQ2/IUVUoelcDhi8mmvckIbFia0andy9rhUjc4hZ0UaKnkFhslZrTJ1/VOoMZC4FEO33qyrbXpfKWDs8a821yG+DVhwFAJq4fbx1cFq34Vz2TqwBjZc++ogtHICdZ4maQLQ6dBbeXIm4HI8WZn+397HhZdO2cKJOpdyqEhC3SquwI4T+6qFN9pdjc3gE6ojjPJPJCFEB602XH605AMNztlriCD/O5LgkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB5876.namprd11.prod.outlook.com (2603:10b6:806:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 15:53:09 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 15:53:09 +0000
Message-ID: <fa01e28e-b75d-4d60-b10a-ccf3e544ff1e@intel.com>
Date: Mon, 10 Feb 2025 16:49:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] unroll: add generic loop unroll helpers
To: Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, "Jose E.
 Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
 <20250206182630.3914318-2-aleksander.lobakin@intel.com>
 <20250209110725.GB554665@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250209110725.GB554665@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0093.eurprd09.prod.outlook.com
 (2603:10a6:803:78::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc9d21d-5233-4302-4687-08dd49eb040e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzhnN3JBSVR3Q2RXNmtKSHkzc3c5Q3hObTV4eTcwZm9HZW1Mdm5DZFYrTlow?=
 =?utf-8?B?WitpZTY1UGNqdC9kdFRaT3hGeWRPWm8yaStZc0Z0cWIxcC9qN09FMWI2bnhH?=
 =?utf-8?B?cnM3a2p2WE96YVhhekNBOGNiREIxUEpxcWpLbUJ3R0dja0NZSWJ0dEhNT3l6?=
 =?utf-8?B?OEZDeGx3eWFGcXVoYS9SRmNCRmNCYnk1R0wvQ2JRUERIOE1NU1R0VUN5ZUsr?=
 =?utf-8?B?a242dThrU1kwbzd0Z3F3c2tvWTVVcG1VSGQ4NmtGYlVOYlFwYmdxVHdnNGlS?=
 =?utf-8?B?ZWJvbXNCd0h2L25tQ2JraXJJQk1mSmNqWE5RektqT3hNUUNnbm01VXhQM0RC?=
 =?utf-8?B?TmdxeWMrc3pvbHZiQ2JaWElCWHBEOHF6TWlPVXdJQlQ4eUxsL1lnaVJuVkxK?=
 =?utf-8?B?VzN1ZERTT1pXYThOMEJycDVpOU9BSFFjb2JlMlovR1BTMGRBUnprRFlWRkNY?=
 =?utf-8?B?ZTVKcnpTZ0VkemR1RzEzY1J5R0RGLzZHWFFDZ3ZNVTZBamVoeTJDMm5peE5n?=
 =?utf-8?B?NzNpNXdFL3lCUUNSRzR0V1dpeTVTV3ZMVmdYd0pEeVJsZHh5MEU2dStQR2tW?=
 =?utf-8?B?OWlDQmxWLys3WHVkR3o2TzR0aE5yalhrNndDdldycmQzZm5RaXBlMDN6dC9T?=
 =?utf-8?B?VTd4R0tDS01kTTVQMzQzbTZYN200RDRNR2JmTjBoc3dUd3V3TCtFdUdTbzZ0?=
 =?utf-8?B?OVY3TFZYU1hPQmllMCtkVVlnL0lGeXdTRzZMdStvUnp2TFhoSTlnS2VqbTRw?=
 =?utf-8?B?VTNmVG12Q1BQTXg1WWFBN2E3NXkxK1M1RHVVRUQvalpESGdxc3c1KzVUWUdB?=
 =?utf-8?B?UFZDUjc5SjUwaU9iL2oxS1JIbUVXc1FBUmR5RE8vbDVhMnlkQjE0TVJObXR1?=
 =?utf-8?B?WjcwZWVZekFvejJZYTJFcGZFd2lSUVZIaWVCOEljS0ZJQTRSZHVQc2tNWlh1?=
 =?utf-8?B?cXFoMlRsSkZJelgrZDlyT2t5aWFYQll4SEJDWjRvV2hGd2NmRVFrNFYxOTUv?=
 =?utf-8?B?RHdKZlNLZmpKaHVXOS9hM1g4UDh4QjIyNDkyYTdheVI0bzJCSXhFOUhrWGxn?=
 =?utf-8?B?aGpzRWE2Mlh0UENGMExtRlBNak1JZ1VBQU1OWlJZcW5mdEdGTUZ2TGlmclBG?=
 =?utf-8?B?VWpQQ2RoQ3VMN2VLcUNuK1paSCtmZE9NdXNWOWJWdkpmQU5VNzlMSU1WREJZ?=
 =?utf-8?B?ZEtSYVh3RXpYd2RBYVVpdjJJNitkcUNlVFZEY1l3Nk5oRUl6ZWJ0RFU1dXFL?=
 =?utf-8?B?ZFFJTXg3V2NWa05ScVFTYXZOTENQRi8yc2dkTDdYYkN1aHNXekVoN3NRMDVq?=
 =?utf-8?B?MGdxTklVMHJVb0F2WU5pS204bm5UWFlucjJBeHhwQkI2V2hoREk4QTZMc3V4?=
 =?utf-8?B?bFlSck56dmZWbnNzMU1XVHNmeWQ5Uis1QTVsc0dXVXVoalpQVjVKUi8rNkMr?=
 =?utf-8?B?eGEwTk56STNWbUduQ3h1RVZGaFpVNk81OFdoZmhEMjBCMndsOTdlYllBOE1F?=
 =?utf-8?B?RGNlZHpnOThEcFRUWXZpU1RFVVR0STRGbENRTnNxNjh0Q1JBcFZNcXgxRHB2?=
 =?utf-8?B?RW0vem84NGkxWDFvMExEQUE2Y3h1dHJmR3FtN2JlL1Bqb25jU1ZFSk5TRU9w?=
 =?utf-8?B?aHNGRm1iNkgrdDBrb0hRVEo3Vzh5VklwN3dxbHFwcFhsNDE2OFBFdHo5K3Bn?=
 =?utf-8?B?ZlYyeURsWHA3Z0g0eG45cVZaMzljbW9MWGVGbzZwdXVzQTA4SURVYmozYlFw?=
 =?utf-8?B?b1lnaitYZUZONWtRaWJheWlhVStoU2pHY3dnc0lHWEkvNm5GSDNlR3NKZyto?=
 =?utf-8?B?cHN4U1pQb3VJWFJkdnpDS2l0VElBY2s5bTFOYVhJU2JUUk55MXZiRWFvSzVF?=
 =?utf-8?Q?hOKwzHafQXktU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdjb2RrUmRiTHdhR0xkUzM4QkZiNEYzZUczQUNEY0F0NzR1ME9wcmhNUDF6?=
 =?utf-8?B?c1RUcFhydm9kN080L09YZXJ3TkFtZVBiRDNQV01wZkxzdU0xbDgrYjJ5QkV1?=
 =?utf-8?B?NkFDMW05YTJ4RFE3cFVTWVJmOHh1cDMvMXpIQzVmUU9INVF3cERtNW1RUEY1?=
 =?utf-8?B?MUJjdERjdVJaeTZzTml3ZmcxOW5HdEtwNmptL1cwODBrbmRLdWI5RHBuOXFT?=
 =?utf-8?B?Z29qZU05MjdUK2FBL3lOV2dhc2JsNzhMS1lHaDZXWHprYmVFUXFSZGlGMVhU?=
 =?utf-8?B?N2JWZVFWUENRZUkzZktUTktSQTBLQ3RvU2dyR1FGYVpUeG9GODU0dDl5RnE3?=
 =?utf-8?B?SnkxRTRkTjUrNmlKMWw2Wjd1YThlTnhGaXVSOUR0NlNHWXdqTzhpbUxqS0s0?=
 =?utf-8?B?dGNkbWlBZkxnQWJNVVNZZHZ0UmoydldvSUg3NXhteHhSKy9jWkVFK0xFQlhH?=
 =?utf-8?B?S1JMY091ZzNFclpIbitLbFBlTjBCSVZnUGIxMjI2dnA4NVQ0K0lBbjRPQWdO?=
 =?utf-8?B?cVJsYTNaN0ZPWXo2YWFaSkJRMTRhalNRa0I2SURIVHN4aUFnUllVQ29Fbk1D?=
 =?utf-8?B?WTczRjd6OGNCNXM1VGhIWkRpbUhIYnNkb2hibGNBMUJYa2Q1bnkvV0tnajZl?=
 =?utf-8?B?ZkJIUitFOUtmVGlKZUxpcFRSZnlFR2NLdXRFZG9YZVhlbUJlVHRITWJnL3hS?=
 =?utf-8?B?TGZ5M2JxS1NxMXdBT1JLMXo2NnZPT09TVjZZdU9BNnBBZ0cyWVNaM1p3bGN5?=
 =?utf-8?B?Mm1pRmI2TDVXMXZuR2NsbHB1eHF3enozYUdNQWo3aEViSkRvYkJCNXRJQlNq?=
 =?utf-8?B?YTRXQTBlOGxzblJHZ0FGVjdleXlUa2F1WUhMOVNWWVNsVFpKZUUrY3FXLy9m?=
 =?utf-8?B?TDVEemZMQll4dHdXakE0cUdmbGRNcHRiNTZkekxKMGp4UWlaQjBUR3ZDODdC?=
 =?utf-8?B?U0p4NzczOGRsbDJyZFlYSkVjQW0vTi9rWVJ4bzQ0UUN3NHZtcmVTZ0ZBMEtH?=
 =?utf-8?B?czk4SUs1UDM5RFI1c0RqYjdPYkIrWWdkd2pkdnhvcmdIUzRXQmkzcHpxOEQ0?=
 =?utf-8?B?WkRmNnRoMEVXUEMrK1hvcnFqSy9SWWZxbG82Y2RnL1d4dXRiYVVnU1FxUzkv?=
 =?utf-8?B?cVpNZklwaDFHaXp6US9VK1hwNkp3T3cxenlkcXFzdUhrTjk0MStnSnFoL3lY?=
 =?utf-8?B?K2MybUt5VXAxZTVqcEtHRlVzV3FMdHBmWGZyYTZLT1JYdEVUTUIvVERFMkZk?=
 =?utf-8?B?STVmQTFLeFBDanJVcHhuVWkxL25TS3Z4ZVFVL3dtRUZrbGNsMldWS1NIaUNW?=
 =?utf-8?B?Mkw4UnhHTjdOdXpMNnJJVEIzcVNSZHdSbk5STlFKekRDaFM1VldTbVhVRmw3?=
 =?utf-8?B?NnhGaW5tVzM5Y2plZ1RzUks4ekQ3cENjalQ0QzMwcWc3MHhNajJkT1VWbWta?=
 =?utf-8?B?L3B4T3NlSzFRcU1tNmYwK0lEcFljZ1Y0VXhzTVRxVEpveGEvYUgwODF6Ullz?=
 =?utf-8?B?WlZiN1hGTUpScmJzWUJrVjNuNElNNUllTVJldk0vZ2QwMDdzOVlFdUE5Skd4?=
 =?utf-8?B?T1MzTHQrbDZZSlM1aTNuS3kyLzBrUWVtOVRsV2RCa20wd3JQVnJacUYzcUdB?=
 =?utf-8?B?VEFZOEl4WUpwdXV5ZER6VDJ4QWk5YnBwbmoxY3BNYlR3VTlUOTFkRzNYYlNE?=
 =?utf-8?B?VUJBMmcxQWd4RkZvRHlJanFmYjZsS2hXSVd4Y1JQR05DZkdxekxnbm8yVTZu?=
 =?utf-8?B?N1BzU2QwcVFQdWJ6TG9QUVpnQzl0dmIxQUJSTjB5T1l6bHhQSXBIT1Mvd0pS?=
 =?utf-8?B?YnozMUYwRXFvYm1zTGlNNkRxMFM2Q2ZUeEFlcENqYlhWOVloaEwxeEdJazF6?=
 =?utf-8?B?NlBiRWRaTE43WTdwNXZLSHMxaS9BVmRxMWpoV0pBdy9pbEo3cm9EMXVJV21Y?=
 =?utf-8?B?WHNITGdZSVYvZk5KelNHQ0Y0WkwrZnlpb21rZzJhRHQxWmZvWnk1RlFaK1V3?=
 =?utf-8?B?WEJkalZ4aGRVblhSY2xwQ0dxUmhDaUtTQTc1VXlZdW1OWktSelRrVVlpcERK?=
 =?utf-8?B?NklvTGNJaDB2MHBoeVdnRkdpUnRicnN0TmpTWkVyNHlleURwNVkxeVY4MmZ4?=
 =?utf-8?B?QTk0UHRmSWYyQ2pnem1PRVVQanVaY0MvYmVpU1FJeUZzTWljdXp0WVBoME9J?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc9d21d-5233-4302-4687-08dd49eb040e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 15:53:09.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7mS2Px6VdFS+LMhJQY1HL3JCzbwgygtaVQCNV/tdUC11UWZg/KboOctEgeFp6FvpWgmnOcwCzZs/lMp6HvjhCE0lpI1L3cF/zDVMLZyuBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5876
X-OriginatorOrg: intel.com

From: Simon Horman <horms@kernel.org>
Date: Sun, 9 Feb 2025 11:07:25 +0000

> On Thu, Feb 06, 2025 at 07:26:26PM +0100, Alexander Lobakin wrote:
>> There are cases when we need to explicitly unroll loops. For example,
>> cache operations, filling DMA descriptors on very high speeds etc.
>> Add compiler-specific attribute macros to give the compiler a hint
>> that we'd like to unroll a loop.
>> Example usage:
>>
>>  #define UNROLL_BATCH 8
>>
>> 	unrolled_count(UNROLL_BATCH)
>> 	for (u32 i = 0; i < UNROLL_BATCH; i++)
>> 		op(priv, i);
>>
>> Note that sometimes the compilers won't unroll loops if they think this
>> would have worse optimization and perf than without unrolling, and that
>> unroll attributes are available only starting GCC 8. For older compiler
>> versions, no hints/attributes will be applied.
>> For better unrolling/parallelization, don't have any variables that
>> interfere between iterations except for the iterator itself.
>>
>> Co-developed-by: Jose E. Marchesi <jose.marchesi@oracle.com> # pragmas
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Hi Alexander,
> 
> This patch adds four variants of the unrolled helper.  But as far as I can
> tell the patch-set only makes use of one of them, unrolled_count().
> 
> I think it would be best if this patch only added helpers that are used.

I thought they might help people in future.
I can remove them if you insist. BTW the original patch from Jose also
added several variants.

Thanks,
Olek

