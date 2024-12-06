Return-Path: <bpf+bounces-46269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B7E9E6F7B
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE432283670
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2DA206F05;
	Fri,  6 Dec 2024 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfHTn3CY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305BD36126;
	Fri,  6 Dec 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733492980; cv=fail; b=q/Kundb4IKMD2FBoh4Xo4RLtrq/59gA+ItaiMNjpL2JsOODqtPTwBQvbhVOAW3tyfPAVodabkrVIcU9tZfsnhpcrCgK2jTFGjoqcsiXNb4ZlgoUWjBvfrgll5FgLm2Z/GtZQ8RazggtsgoOuRPEiFRumTdUZqaaNr+RBXDQQoIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733492980; c=relaxed/simple;
	bh=y6rT/kesH2/2dNBZYUFhNg8ZPJHv0DpSXKsLImSBm/0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tcSFra1YKTzirde2gpOI7nCTIsLGn5ZUkP4wv1/blw+RBFvbt/gpG+CjmIZOKGLWOfLgcZY+I7NZ4yvj0x/+IFRUuqnIsrg6RAo9lrFI3GELoKr0t9n5WAXTaQPKbOF8wmtbquU4EaT14FPrvHDUSxGwDDeh1KlRY/wCHe8KX1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfHTn3CY; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733492978; x=1765028978;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y6rT/kesH2/2dNBZYUFhNg8ZPJHv0DpSXKsLImSBm/0=;
  b=VfHTn3CYiHIQca3ed0feUlVUTQ90VNI5o0AiEcM37XhqOiCUxSyEPH2o
   QQDN45GpB+btddqrrRYSIYY89xw5ZkuqSAL1/p5dvTtz0tGhpWXRn6dmd
   LQucVLaUeINtn7jaYt0nMLyCZ9m2vGE2zFmjO2n1wPaYa4qZA/W9H53QB
   39BfrqPv/jG617L/iep4YMhJFVkX21xuUuKvfZoCI6+fm9e7zt5wVUaDd
   7G1fueRh/+ZJcS1pEIV8FbXIOCluJpMpbnn7ZxPy9KmAJib2Qse3TSYBQ
   s3Dj8LjyBKCQS6YP+df3AzSNZ5AL1n9Jis+YJx3eVaqsneOcS/A/lk/iv
   g==;
X-CSE-ConnectionGUID: /XzVw03qQsGDaQrtji/JeA==
X-CSE-MsgGUID: f5QxxxisR9CSOAscv6DcpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="51379893"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="51379893"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:49:37 -0800
X-CSE-ConnectionGUID: Uh6IrUZxTumohvfT0G+cAA==
X-CSE-MsgGUID: aZbBjpuiQHCGqoAo2LCxjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="125251006"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 05:49:37 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 05:49:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 05:49:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 05:49:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbUh/fdLLpAJtDusUI8CgoaUeFM7Z/6Oi21+VdMdV0bID8jB6d9nKPOu4kgbDhhNgA5m7uP7ntB1nhaF6RNQS/RmGnEQ4jQtX2RiE1xue1B33VbGUo06Kgg1Ina7cNnCKJX/DiGDzNmYCPKlIvHvew3FComP+uNhZEhJt7ZhJK7e56WLoxH++baETNok7MpUE0wIzq5Jh4FSsLYBvWTrRGQKO9Tqyl0ntyYet0OslS1VPJ3MiYSfDar+NOAQp2M//v6VBJ1lJ0mwCkja0Gsq6fvCXcDpsPHXvNyR3gBSFyy3kTAcQ1rTmRNsCShnwwUJlyRqdcP+7/jSmhpT+yRRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROUGJ+BVlX1ewkJepormhmaRh6RfV1doAAw7NLGfQmI=;
 b=x++qvNJhe42P9FkXJMcXB/wHvi07eVgvlhEvUulW0/BWwcVoPpxGQVR5x+6TYzfOiyhq89DDnph61ZVsB9rf2rhhCKTiXcwkztAs8Y0FlVHAXsg+6X6v1bkE2aLCmcs86klkwE5XN3iVuknmWF99mQI8lAb039bJSvpMmt4B0HIsNPIwJqFCfvrmsf39YB1bwfh1R+/GXjrSVnNVF5qJkiH3JsSdkgzyss5fHjMZVTF1K4nyPBptdtr/c39o49TOqQ8KFpAP4sQxlymRHUbbPtloXQHyHPA5kGdyeZclLV2Q2mLjQIxeIZvrpUD2UYJbzsnNZFOKQsBw6vR7Yzp0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB7112.namprd11.prod.outlook.com (2603:10b6:806:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Fri, 6 Dec
 2024 13:49:33 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 13:49:33 +0000
Message-ID: <f817137c-3f02-4c12-96ef-04b7dcf5501a@intel.com>
Date: Fri, 6 Dec 2024 14:49:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 09/10] page_pool: allow mixing PPs within one
 bulk
To: Jakub Kicinski <kuba@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
 <20241203173733.3181246-10-aleksander.lobakin@intel.com>
 <20241205184016.6941f504@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241205184016.6941f504@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 995bd55b-da3e-4c92-b9e5-08dd15fcd05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDQvOXFkTi8xZjU1b3YzS2VsOFEyM0w5c1FSUExsbGh2aGdWSkpOMkUxL3lR?=
 =?utf-8?B?TkIxeXFlRXBLUUlrWVEvei9sL1hLaCt6cDJNZHdReUxJRTczRE1WTDQyZS9o?=
 =?utf-8?B?L2IzODNYNktQcDd4dmlaTy9oaWRwKzlISklyWVRCd3cvZTQzbUZZUGdyWEhl?=
 =?utf-8?B?MC9jQ21QSlRLSEYxNFl6d0RQcEFpV25rYjlzWGMvcmdPVUN1eStNSm5Hemdr?=
 =?utf-8?B?NGRVYmhrR3hadHBKSFVuMVhWb290d0d0dHAxMVp0Vm5oUEZDNTgxVDJhZElq?=
 =?utf-8?B?QUZXUDZxRjdIa3pOR1gzVHlIbnVDVmlzVlUyQkt5KzVibHlnanhOcjd3UCtU?=
 =?utf-8?B?RGFjUGV3cGNHN25MeXZjVE8yY1prOTU5TTJmWTVYS3h6dkJVM3lJWFQzWU5j?=
 =?utf-8?B?ditrQTk4R3FoRGxCVStXRUpyenM2UHd6VlN5emxFTEhxYlRLaXlCOFVHOVB5?=
 =?utf-8?B?M0MxUkZRVGgxcHYzcVgwWHFDdEZzbWpqclViMmN6ek1SaExRK0V3NmdmaS9M?=
 =?utf-8?B?ZE4vYW43QzQ1WEFQMTMyNjdRRFgxbXRNL1B0bVRsMkJYR3g1YzhINXJiends?=
 =?utf-8?B?UVB3WXFaOFlmZG1ydlFpY3pSTEZLNHJQOW9JKzBTMmQzVmI3TWN6Wi9xc1JI?=
 =?utf-8?B?QmdrSWRMelUwbEZ6dkVTT3RWWmx6QU5kRGt2b09pa216QnpWMExzK1JPOCt3?=
 =?utf-8?B?MXlNV1B6SXJYSktFRitObnhzS25DVWQ3S1hReDBLQk4xYWhOd2t3MVZ6VjJO?=
 =?utf-8?B?TkxlczBzY2h6L0JCcU1FSzVPNjRDWmVZTGJXNkhHYjQrcm1Hd2dLYkJqOCtQ?=
 =?utf-8?B?TUp5SFBQUmRScHNobXVaL2FHd254bGNFRlVndUpJRHZVRWswNThESEpGZm0w?=
 =?utf-8?B?NXhvNHA4YkFsOVovWmROVG15M2h2dVlYbEs1QlNJd0pwMDNjVGtzZitnUVho?=
 =?utf-8?B?YUd0WDNGcHl2OGFkQzNPV1p4WTlJRzVYeUR2dCtXNE1abnlsbjhYN2J3YnRn?=
 =?utf-8?B?WE1UV0cza1hZVXRWazNsd0h3ZTF0UldiRVVYZ1Z0dWNRZVhLQ1VjUnZxdTFo?=
 =?utf-8?B?UTR1MXlTbHU2NnRIU2REK3ExTGk2VDFBcDJjUzA2ZVI2ZWVxVmpQTlFLemRW?=
 =?utf-8?B?VTdzanNXa1hiY2JTZHAzWC9OS1FSeVBFRGFKZkg2NGhJL1VRdk13d3JlYWdO?=
 =?utf-8?B?UHVESkVLVFJSWGJjWmJoVjRBemlTamZzNTVpUUErOGEyZENBeXN6TUovRW5N?=
 =?utf-8?B?NnYrYmIya2MyNTVENENTWm1BeVNtRnlpMm82R2dKUjNza2h6YjlLbHgzWEkr?=
 =?utf-8?B?amU1K01QY1VpY1J0cHhkb1RXdU92QXhMVFFGZURFSGsweFNhVFVZLzBsczQ4?=
 =?utf-8?B?dEgxUjFRR0l3aWF1S1RMaEhZR0lucVNWRVQ0S0s1SEVGOElxK0RaenRpdzNY?=
 =?utf-8?B?Vk4zdDFpNVloLy9VcGloZUNCWWY1N1A2ODhiMXloRlRvaFNKTDJzZTBjWXoz?=
 =?utf-8?B?VS9CbUk5UjBFUzNqeHlBTkJMbjFpckpGRlZDU3NHNnZQSXRvWGsxZGdUQWNI?=
 =?utf-8?B?b0tOZnhxMHdKSlZtVEtPbFFkaGtKcWdGcmg3UVZUTWU4QXk2TlhTMTFDTm1p?=
 =?utf-8?B?Rk9kSnVQbGRXWmVyT1AyNGJtczd5V1JvcHNYN2J1OWlVT0ViOXptRHljaTZy?=
 =?utf-8?B?NG5hZk5JNTdNajZFK3MrdG5DL3R2V0NoZTNGSzlobGxyem9NZXh6dTRDV3NC?=
 =?utf-8?B?eWdXQ3BRNzhZdzBsRHNNTngrdS9EWUprNXRZVWF1bmt2bzVWbERqenN1bHpE?=
 =?utf-8?B?TVhEb1Y1M25oRmhzZmdZQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1ma0lpeGtORERZdm16Rk5iRG1aSEhadGdvUkt1dnBJKzhvS1UyY0hieWtB?=
 =?utf-8?B?Tm1yQUFkd2xLY2N1MGVpWXBTZ1NBeVk5NkJJWUhNYk9JcDJNYmx5ZTlQaHBm?=
 =?utf-8?B?M0czOFlBaHpKSHo2UmMvWTRtbkJ4dStkZHRVTXhqaVZlOU52cjVqY29EcXFv?=
 =?utf-8?B?ZGp6YUNpaU1hdzh3aXdVM2JFdGhzeGx1Mm5ZTEl1RXVWZ0JtdGtHT24yM2lM?=
 =?utf-8?B?S0RsSStuZ2hxODJUTVhUTU9YSmUzY1JBOEJDK2FIN3M1dGh5WG45K1R5SEtM?=
 =?utf-8?B?b1BmSnR3a1RPQXN6VHFOb3BIMVFyUzRCWHNyMmV5c20yeWQycTBYcE5KQXJ3?=
 =?utf-8?B?U2xWNmZuSjFqRk1vWTA0MUNwQlB3UXpOYko2ZSsrYVNiUjd1dS8vZkZMQVQ2?=
 =?utf-8?B?aThMbzlUMnc5ZzBwMTBXTlJRdzNORDlxNEZuQXBUbzJBNC9nelpBN1lFcHZi?=
 =?utf-8?B?SGc3OVZzaDdYS2Jydk1naHNUTnhlUzArSkV4alNua2t0TWlBekpkbHdDT05i?=
 =?utf-8?B?U0NNN3lEVnErc2U3eXA1WWc4R3o4VTVJQ0JzVnJiV1FDcis2RnI0OWFtZXJ1?=
 =?utf-8?B?cVYyWGl4dEswamZNN3Nsb3prS0tQWHprd2FTQkRGT3pCb2tsb1c5QkwvOXRB?=
 =?utf-8?B?SExwRkU1MURBZ0dISTB1bDhha0ZDVldDYmRuSlNYVXY2dTFJc1N4bEI2clFC?=
 =?utf-8?B?NGdwbmtZOGNseVRuUU9hMnlubkZhNmovOUl4M2E4T1k5cXNzdFVqYkZPUHpL?=
 =?utf-8?B?QWcwNnhsbkpEZzd2cWVXSzlSR3dNcHBodzRtV3k2VkRNajVsSzQrVnJCTndt?=
 =?utf-8?B?Qjdpd2lVWVZMblcxVjIxOE9waWtnWjZHUnJuZ3NzRUxHVm02U1lkTlNlVTNo?=
 =?utf-8?B?cFUwa2FsZ3Z1R2xqMDZhenBMWlYrVUdtOWFka1QzS2ljNFJPU3lYODlYWjVm?=
 =?utf-8?B?VkcwaEFpOFV3U1pHNGsydFdhV0tIVUtJTisveGlCWXZSTDV1S0xNNnJoRksx?=
 =?utf-8?B?Vkh2R2RXdDNZVjlodVpPMHVGMkc0RW5VN05uYm4xMnBBVy9PbmNRN3ZIcFpw?=
 =?utf-8?B?V2duYjRqV0VmZHVWNk96QldhZ1pQMUpDaXR1cUM1VXp1dG5EcjF3YWs5dXVF?=
 =?utf-8?B?OXE3bGFPcnB0anB6K1NwY29XaDNqZWZscXVLOGNvTlZjQ2tYVUYxOXNlTFU1?=
 =?utf-8?B?VzN4MkMwSFhtaVhvMDdJN2ZqdkRJZEt6T1RLMTgwckZpS2VQZ1BmNy9rbDli?=
 =?utf-8?B?MzBqN3pUZE03czVNUDA1ay9hbmo4bFBSTWdqLzR0TGd4M0pOYW55L0VZWnBZ?=
 =?utf-8?B?VW9lbnhOS3IvSmJ1RVZEMkxlVWJTMVNNYlB6U1VKTUtzT05ieVZlNlA0M252?=
 =?utf-8?B?K3lGWVdESkdKL3EzejkxWUVvT016WDVaVUphaE0xVmVSQ2t4VjNjdlRockNC?=
 =?utf-8?B?ZHdpZ2YvSmQxdk9XajJaREwxa1lEbnMzdWU4eHBDdi9NRmJpdEFoamlUQjQy?=
 =?utf-8?B?UThSQVR2dThFdGYxMjNZd2lNcGZTSmtoS1A4Q041Z0gzTEt6dXZmVkpWaW55?=
 =?utf-8?B?SkppeE13bHYvWEhnRlNocXZlVFFzcStNMjNFRUZyMEwxemNUcUN0UkVnK1ls?=
 =?utf-8?B?ZnpacG9iVVhsbGxSVkF5RjRlQ0w1UjMxRjh2WUt1bmM2WlFHd3FZSUZnandG?=
 =?utf-8?B?VkJDOWVPL2tJeEk5YlJTMnNnVG85Y3J5N0oxSnAyK3F6Qm1TS1VFbUw2eVlq?=
 =?utf-8?B?UlpBVjc4T09zaW5GWldGY0NYakRiTVFKdWNta1YzY2xsNWdnOXN1dlBjQkVm?=
 =?utf-8?B?V3NPd1RvS05xZUVMc0JGL2xKODJxdUQweU96V09vUlZGT01mbDNRUGFLUy81?=
 =?utf-8?B?SjVqaE1KNnVsZ2pOZE1VVUJpR0djMmNRbURRd1BiR0xlOGthY3FGMDVPVWRj?=
 =?utf-8?B?VXJKSjFxN0Z6MTgxQzl5U0NWRTBOLy9GbHdpazdoWWRkdjE3Y3lQZ202ek1P?=
 =?utf-8?B?YkkrWGlZcDA5YVdSQ2VINGIvamRRNjM5SmR6SlprSkcxWVh1d04wR2N5WEJ5?=
 =?utf-8?B?VUNOaWVoa3NZOEdxdjJnUlYweXZwUHdSVjZzUXd2S3RYMjUrNjFUMlJGNTM5?=
 =?utf-8?B?bGhWS3hhQnozbVpZTC9rUWFJZFNKRVA2czN2eGRXWnVYNTFnY05weUZ5cXhM?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 995bd55b-da3e-4c92-b9e5-08dd15fcd05d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:49:33.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0HEwrH3t6C6SUmLWIm/cpKTOgKFdNVNAav+5yzsseLRoSx9cVzlgM0vwt+jblW33SGjmEd/z+yf2bsbHgVFT0EdBrIJACOgD1pw0/hdZLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7112
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 5 Dec 2024 18:40:16 -0800

> Very nice in general, I'll apply the previous 8 but I'd like to offer
> some alternatives here..

Great suggestions, I addressed most of them already and the function
looks much better now.
One note below.

> 
> On Tue,  3 Dec 2024 18:37:32 +0100 Alexander Lobakin wrote:
>> +void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
>>  {
>> -	int i, bulk_len = 0;
>> -	bool allow_direct;
>> -	bool in_softirq;
>> +	bool allow_direct, in_softirq, again = false;
>> +	netmem_ref bulk[XDP_BULK_QUEUE_SIZE];
>> +	u32 i, bulk_len, foreign;
>> +	struct page_pool *pool;
>>  
>> -	allow_direct = page_pool_napi_local(pool);
>> +again:
>> +	pool = NULL;
>> +	bulk_len = 0;
>> +	foreign = 0;
>>  
>>  	for (i = 0; i < count; i++) {
>> -		netmem_ref netmem = netmem_compound_head(data[i]);
>> +		struct page_pool *netmem_pp;
>> +		netmem_ref netmem;
>> +
>> +		if (!again) {
>> +			netmem = netmem_compound_head(data[i]);
>>  
>> -		/* It is not the last user for the page frag case */
>> -		if (!page_pool_is_last_ref(netmem))
>> +			/* It is not the last user for the page frag case */
>> +			if (!page_pool_is_last_ref(netmem))
>> +				continue;
> 
> We check the "again" condition potentially n^2 times, is it written
> this way because we expect no mixing? Would it not be fewer cycles
> to do a first pass, convert all buffers to heads, filter out all
> non-last refs, and delete the "again" check?
> 
> Minor benefit is that it removes a few of the long lines so it'd be
> feasible to drop the "goto again" as well and just turn this function
> into a while (count) loop.
> 
>> +		} else {
>> +			netmem = data[i];
>> +		}
>> +
>> +		netmem_pp = netmem_get_pp(netmem);
> 
> nit: netmem_pp is not a great name. Ain't nothing especially netmem
> about it, it's just the _current_ page pool.

It's the page_pool of the @netmem we're processing on this iteration.
"This netmem's PP" => netmem_pp.
Current page_pool which we'll use for recycling is @pool.

> 
>> +		if (unlikely(!pool)) {
>> +			pool = netmem_pp;
>> +			allow_direct = page_pool_napi_local(pool);
>> +		} else if (netmem_pp != pool) {
>> +			/*
>> +			 * If the netmem belongs to a different page_pool, save
>> +			 * it for another round after the main loop.
>> +			 */
>> +			data[foreign++] = netmem;
>>  			continue;
>> +		}
>>  
>>  		netmem = __page_pool_put_page(pool, netmem, -1, allow_direct);
>>  		/* Approved for bulk recycling in ptr_ring cache */
>>  		if (netmem)
>> -			data[bulk_len++] = netmem;
>> +			bulk[bulk_len++] = netmem;
>>  	}

Thanks,
Olek

