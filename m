Return-Path: <bpf+bounces-52867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43151A4961F
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 10:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3451E165B16
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841725A65F;
	Fri, 28 Feb 2025 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6Ugg3Ba"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCAE2580F8;
	Fri, 28 Feb 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736701; cv=fail; b=qWdM/ARmPXw/rj7J6SSWy8VemVX/jZkxRGqSCNcfswWqstyig8CHGiMMZIxlVCPV1JBwkk8Vqn4wdxFwGozextgiYP3ken6fV2CYQAz9ZImFEbQgFxRsV4HzMpT3Jtbe0ld/vB+UDWL9x9sziGyFskZsUdIcz4xhPj4G4DheNGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736701; c=relaxed/simple;
	bh=66BlordStv/kQO5p8h24z+kpTj9L0YhniosDSrWwR3c=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5f/kCdvcd1r7qsg7tDiMZRtlX2K5GR3lSyx9FPmdONpwi4jpGgPBLmdmSJafPwzAFTH1BnHmDnhX80D7BcNwqaQ0PNM65ImjF274Jmhj9ryd6DY7VDnc9zfCTMKh4d0s0IwliIiICIEe9uJRI0qe3HXfXndXZH2+JLowm1w11k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6Ugg3Ba; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740736699; x=1772272699;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=66BlordStv/kQO5p8h24z+kpTj9L0YhniosDSrWwR3c=;
  b=d6Ugg3BaIiKdLVs9O2lxUDPHD8gWxH2eeirdL6JKVHxQewHAUaCniq8A
   mjn8CMAHdhQOtc67S/q5qUq7LCkg7O/zX3/cjgzRUGmwlzZ+JiqMhNSpC
   VmeeqFjgpPTn6/6AwKoVECmnx3MwBxnAFK1cL0JqZcuKhfRBFd5WM6GKl
   7PqFFw3D1Jgu45KHh44l8TwtrQYEXAABcqEI+kTOI/nOErqEA+OXs2DIw
   s171Qdj5k5yQESnrRNh5ksEo09LxFcx9XV50hcbMmwhODLD0fYs6dhLzM
   LXCoqe+gjd45flhvIWOXff7u5a6/IuvakEeSQOI82sMHq7jZDDj1XH06L
   w==;
X-CSE-ConnectionGUID: tTrxSujZRTK6RC4Am+Ep4Q==
X-CSE-MsgGUID: HcZid1jpQO+S+fjhxCtJTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="67037973"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="67037973"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:58:18 -0800
X-CSE-ConnectionGUID: GaX3GrRPT/yzfE7asOm6gw==
X-CSE-MsgGUID: SOw8Vg55RImD+ZSuhbXFLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117060953"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2025 01:58:18 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 01:58:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Feb 2025 01:58:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 01:58:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zz33nd1Rc7SRqkqTMGI86scED5dUfFqNJDSkYdXcqmmXTbbPBfrpW1FcIhF+CWVs8twUd5CXxK0CNVLmVI4fxc4Wqoy0B75ESafa+kh16nha6fXmmGziqeSsns8L7jIKxSlZyXK3eTZnzyj6nCUhxQwG+WcwWpX8mJbA7TwNTQYXl4k9adA7Q02N5wAbI+U2fbLRrSWdx4Zpp08MNFroFMEzH6zQtRBVEMw1214suuCwGvKM2cND2IpLE8hTi7OGVI9P5e3X0FQvMft8mbUGykzDfsnIT46pkTI7n4YpKiIrZDbM04iyYCm8bry18YVESiDlMzBtazUAg1gXIAL7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvPb5zFt8dT/rASr/3io3WRTQBT5AqC0JvVUdIDqhbE=;
 b=IvtD10MEpMhb4nt+euoZOY0nDZYdSd8u4ixePgIdukzSbLe9/ymR22j6dA64mx4BiOlA72Ju6ANtXQXcaM4FWU7VPGy6Dnb3t8Hp+fToBRTg5aXKiDpYn6HoRTvbyD9PV9MszALDOETrILNzhQ1VOqptjOlNywVPXbUZLtoSA+aM5VtdsohSP7xSoI0c0RNAsM9UKzYmrG5Q0Wt5GJtXVc5ZKsdF/ajAlHziQ/cE9ikdKpjFqH6WwQHrsfu07rwNLn11zVCTI7lLLtXlJQL9NWHtFgUSUtG1XLBQtR0xvMjh71ud/PQb36uRnuX55sLZQbINfkTg6XLEOKxy1j54XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 09:58:08 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 09:58:07 +0000
Message-ID: <01543bb1-b504-42b5-bf64-154a55e7bf33@intel.com>
Date: Fri, 28 Feb 2025 10:57:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v6 2/9] igc: Rename xdp_get_tx_ring() for non-xdp
 usage
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
References: <20250227140158.2129988-1-faizal.abdul.rahim@linux.intel.com>
 <20250227140158.2129988-3-faizal.abdul.rahim@linux.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Furong Xu
	<0x1207@gmail.com>, Russell King <rmk+kernel@armlinux.org.uk>, "Vladimir
 Oltean" <vladimir.oltean@nxp.com>, Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>, Suraj Jaiswal
	<quic_jsuraj@quicinc.com>, Kory Maincent <kory.maincent@bootlin.com>, "Gal
 Pressman" <gal@nvidia.com>, Jesper Nilsson <jesper.nilsson@axis.com>, "Andrew
 Halaney" <ahalaney@redhat.com>, Choong Yong Liang
	<yong.liang.choong@linux.intel.com>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <bpf@vger.kernel.org>
In-Reply-To: <20250227140158.2129988-3-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::8) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ca9035-536c-4e46-e3af-08dd57de66ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ti9BZVRmVkZydy82R3Z1VzRyYkVodXlxeVZSS1ZkUTAzZXJWR0VtakpmMlVV?=
 =?utf-8?B?NkJOM2gvQzRxQXFkb0paMVcydEJFUWtHQ1h5akE2UXRZNXlnbjVQcEpSd25K?=
 =?utf-8?B?cEV6S3NTQjc2YkFBNERrUG8rOEFDQ2EwNnEwNndOQmpRRExCWGxVeFVOdDlS?=
 =?utf-8?B?Mmx6d2xDQjhMdmRsNExPY1RQOTFSTERselozU0s1SFd1WHlTQmdITk92SjhQ?=
 =?utf-8?B?eTIxc3AzUTR3ZWhTdFo5Vzdic0J2MnFib3V2VW93T1lMai9UaVNJalBMT1JM?=
 =?utf-8?B?d01uMkxaSVBqK3ZRalI5TjJXdGE3eGN4VTQrV2Y0ZDFlNGxHdWpnREdNbFBN?=
 =?utf-8?B?b3NVUzFubFpHa016TVh4aHhVMGQ4MG9qZkdGbUNPV1pvQW1pSkFjVUJwZGdl?=
 =?utf-8?B?dkJBSUg3bDFJMHpHeFo1OTRDaHFQUFdaaHhkejFYSm1mZitwbU4yUXF5WGIz?=
 =?utf-8?B?c2hqSnNtd0ZmWktJdGpGeGIzeHpWMFpWTERIV2d4RG9lTW5HTll5MGU0Y1or?=
 =?utf-8?B?MnpabTgySUNxdW80dS9kaEtKY3B4bE4wNHFJK3A0aGNCVDRBblA4MzlwZkZn?=
 =?utf-8?B?VUJYYUg0dWFIVC9BbVViSzZlNVBzWGpkcDdZYkd0aWNUNkIvMlBZMitaTEV2?=
 =?utf-8?B?bzNmb2YzOUlOOXBDTk1iM1NwVDFWNTZYTUpyYU1oTSswUERkZnBqdElQWUJy?=
 =?utf-8?B?U0doT09FSzFBeWRnSzR0cm9pcGVaSG9sMlVtYWYvOVlaeW9XWU1xRzRRc0xX?=
 =?utf-8?B?bElRblY2c3llQ1BIVlJtU0V4bUE0ZWdtUGVkS1pnY3EvNFhFL0hmeFlWWVBQ?=
 =?utf-8?B?d0RwL2Y2My83ZjF5KzdwWTNwcFlKd1VEck5JblJYa1pEWExLUWxsT1p3QmdU?=
 =?utf-8?B?WVIzcTFHVjNjMXRXVEU2WHAxUUZOUGZKTThPcEtSdytDZ052TCsxWXZQQndU?=
 =?utf-8?B?alBwL3ZyWDVOS2tDbWNVR0RHVkRJZHVBKytPMXlwcGxwM2ZKbnZXc0pQTjVY?=
 =?utf-8?B?d01iOU9aZTJsbVA3U2w0WEwwTHFNMVF1LzFTZndETjhUeDRFaDVNRm9FelEx?=
 =?utf-8?B?bmx0RzdXWllRRHFVQmYvVi9mcFdKMjU0ZXk2c2hQYVp6OGlERUVOMGRVY01L?=
 =?utf-8?B?cVR0MndNcWNkbUpCTExYUVVSSWxxUGoxWG9jUXZIbzZ1MHB0V1I0N2pxaytX?=
 =?utf-8?B?d0czQnhVY3AxRjBMZDNzN2YxSFBlWC9WNTIxd0YzQTlkU015YmR2ZkRSaGkx?=
 =?utf-8?B?YjJIdUs4d2diODl1bXg3aGZ5OXg3L29pNHV0bDVXVHd1aURLRFFjOWRMcnJ5?=
 =?utf-8?B?VERSQWVON2o4K2tpVWZ4Q3ducWtoeFJ4NXZnaFV2WGtlZDlJNW9qK0xnSHl3?=
 =?utf-8?B?aW1MUFhxdFAwZ28zSGIyZzlvWTc2TXhCMy9pM3NMTTdGOWpGL0pLNVdwZnpv?=
 =?utf-8?B?cXdjN0orckY0REZESS9XdnY5ODlLdkdod3djMVR5RUN0R1BwdkpCTUFuQVRz?=
 =?utf-8?B?aHRkbXRGVTBpMHQ1bVc2dUNzV24xVm40QTFLNzc4THZxYzE0ZFZrbnVuQUV6?=
 =?utf-8?B?eVRzSTVJNHlndUxnN3dhZ1BkVmRsNVFrUE1sRHp3TzZlTGVBZkw2SW5XcVMx?=
 =?utf-8?B?WlpzLzkzN3ZqdHpoNk9RdzBpR0YxN29CeW02Yk5VNHJ0QzNkbDlUaEZoYU9m?=
 =?utf-8?B?dVRKNmpPSFpOdnQvNGtHNlVwZkFEemg0aS9YV0pjdThPOGsxbytYdE82WWY5?=
 =?utf-8?B?YWJjMHlrb083KzR4RHJuZXptVVo2YlJmcDlYc2RIRHlhQjBpNWlJdmNRa2xP?=
 =?utf-8?B?M0o5ZVFHcjN6NnFxOURjeCs5VDNKMmdMTFQ4UWFIcHR1Tnd4OHhtYTlvVnFv?=
 =?utf-8?Q?hAt99WtCPOwEA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzAyNTFPYzJuWXNlalVlbzkvRVRvUVZiMjArb1NWRkZmTWZpQlN4cVgwaU5C?=
 =?utf-8?B?U3pkUU91bmo2QzRnN3hBUVcyNFd3MmZtcXkxdnEzQVJtN3JUK3hNMnNKcWxw?=
 =?utf-8?B?RHFQZ0NQS2xiZEVaTEhNL21rK3EwQW5CWFNCMHZ2MkJOZ214TDFTTFIwWlo1?=
 =?utf-8?B?M0VZRE1LQVpKUlBmbzlTSnhVVzl1am9HdVBKS2tVRHdXb243TE8yYlkxS21o?=
 =?utf-8?B?QVJZVFozUzdrTCtJV1hzVnRmL1FUZGNmNlF4ZSs2eVVwUjd0MXJGcVJaTW5T?=
 =?utf-8?B?REJyZHJqWVlSblR2TnZURzBHaEVlZ2tFS2FmZE5TY0NPL2ExbzZhREsrOXR1?=
 =?utf-8?B?aHRrZUNHcENQYUsyRG0zdlJZRFhqRUR2K0sxZWdNamYvazdXTXZTRzlTakpw?=
 =?utf-8?B?RHA4RzNPZEh0bzYwU2VhSVkxRUJyWWFzYytZMDE2N0RaUmVqNEI4RkFrSXdF?=
 =?utf-8?B?Ujl1bTFwNWRTMXVTTGpmOXRDaEgvbFN2UkdwWHhIWHU3cC9MV3FhRFZIanVv?=
 =?utf-8?B?R21sSGdLL1Y3NVVYYjZ5TnF5cTNZM2JaTDVPNDdET2VkSlJwUVl5RktxbVNX?=
 =?utf-8?B?ZUZPaTgxTWN2ZThUN01Ld2djMFlUblJhSTkxRS9NWGFJNTlsaUwrZjV6Sm1N?=
 =?utf-8?B?cFRLdnBLYWg1RUhRWThBbFFyTTNxODZ1QlBxa1c4NWZKZVZDQTlSVkpQaVo5?=
 =?utf-8?B?NWs4RlJyWXN3d3l3QXdZd01CR2hNTms3S2FkV3VyeUN6RldMa1RML3JKTW1X?=
 =?utf-8?B?ZGhrK0R1bnlQU1lJV1U0Z1oxY3ZqeUJTM3dMVXVLTVJEcVBCYTVmTmF3M29z?=
 =?utf-8?B?c1E0ckU2V0xsQnJVY0VRcGJpOEFKVUJWb3FCSTlreThCeDhnU0FkeEgxWmFt?=
 =?utf-8?B?S21VRmsyaG5EMHBuZm1lQWk4VkJ0LzJFOHl5QmZReXBRYTVmWEx1eWFsNzlX?=
 =?utf-8?B?TUFwUVBOOTAvS2FEQ1JSQXM4RU5oZzlVcEpGYng4QkcvTFg0THpIR2RXUXJ2?=
 =?utf-8?B?bjBPWGFDeVo0TjRrNnZob0RlVURGWWZDYmN4MUwybXNCRHlhb0RlNVVBeDlq?=
 =?utf-8?B?WlArVVFQaEJkbGdKVGtZM1hiUFNZM3JvR25OZnlqS1VIQWlQT2MrN2xaWUlw?=
 =?utf-8?B?cVpYYVJ6d1VJUnJKMzdJNllwQVRhN2U0RVBNcjVBWXU3Nm1yY0x1Y3BMaWs0?=
 =?utf-8?B?Umpjd0dHU0ZBYWVsLzN0em5LZ1g1OHg5cFZjR2oyNUpSWkZEUnorZTc0VC9B?=
 =?utf-8?B?WkxJancwVlJ4ZzJZaEtGTHB1d0dOZkxFT1lOWDVqNlJNUkloUVE3eWIrL1cy?=
 =?utf-8?B?VWhQUVJaZmhyWVlCeWxFd1dBNi92U2JHeXVNN1ZRRGR5N01YeEFyU0x2SjZa?=
 =?utf-8?B?R1g4aE5hZ3NENnExR01iUEdoV2ZkTGZiMXh4b1haVXZCSEdycU9XOTYydmNr?=
 =?utf-8?B?Q2JSOHpNd0xmSThqR21hLzNuRlF1NUx0T29aR0hFZzU5bzkrOVlSOFBPTjBo?=
 =?utf-8?B?VEl5T01lWUpVbkF0Ulp4cGFrZThYYVAvUzJLelZrQzI1UWJFUmk4QWhXeW5X?=
 =?utf-8?B?VU5lejRvRXNaazRLdUR3VUp3UjhSZS83ays1VHpFZnZ0Sm9WVWo5cSt1Zlkx?=
 =?utf-8?B?cFRTT0dPNVhuTitwSm1VMkg3ckRVTXRhM0x6b09NZ1F0RHlTVkF4d3BDYjVa?=
 =?utf-8?B?T21PT1hCOEdzY1NIZHVDY1NhQVdlOXFrWnNsY2UvNDV1eHJ1UTdlaGROL1Fk?=
 =?utf-8?B?dTdveGR3SjhuVE1pWGhkb1lxZHRlWms4ZGlaWHVFdStWMFBhY2o1ckxVTktw?=
 =?utf-8?B?YmMxOXI0SGRBZnpObWxNZmlCZ2s5WXhUZDZQeS85aWJEei9DZFJEdngramlJ?=
 =?utf-8?B?ajBSVWQyWHQxb2ZIcVlGZENrdHlZSFBydGFGdnJmNmlxY0dobmFST0JWYlNH?=
 =?utf-8?B?TW15ZmQ5WUx6UzBuMmo2K1lsT1hlSWQ2dmFEYVdxY2RDeFViZ2IvZFNXZlBK?=
 =?utf-8?B?Q21wc3ZHMXZhSjdDS1ZTSGtoQ0VFejlobkZNTmp1QS9jb3dOaWpuVHIzMWpq?=
 =?utf-8?B?TFJUaFlhSjBqQlhteFM5TCtpbm5zTS9kcWNROEtaZVFndU03bXFFNVdTZk9S?=
 =?utf-8?B?djlMV0szMVlHRFhHMDk4OEFsdGt3TlRCeWk3WTk0NzVyWU44d1BiUG1PY0pE?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ca9035-536c-4e46-e3af-08dd57de66ab
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:58:07.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n56qqqySPNM+OIOSjUa0eOGGmJef6QxUZlKyOnxy8Xm5zPNm7uEUXVdoMNjoGwHelPifdQnVqTHTemlGU4Fk64fYvyuZba90BvVrT0aZmT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
X-OriginatorOrg: intel.com

On 2/27/25 15:01, Faizal Rahim wrote:
> Renamed xdp_get_tx_ring() function to a more generic name for use in
> upcoming frame preemption patches.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  2 +-
>   drivers/net/ethernet/intel/igc/igc_main.c | 10 +++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index b8111ad9a9a8..22ecdac26cf4 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -736,7 +736,7 @@ struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
>   				      u32 location);
>   int igc_add_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
>   void igc_del_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
> -
> +struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter, int cpu);
>   void igc_ptp_init(struct igc_adapter *adapter);
>   void igc_ptp_reset(struct igc_adapter *adapter);
>   void igc_ptp_suspend(struct igc_adapter *adapter);
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 56a35d58e7a6..44e4f925491f 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2444,8 +2444,8 @@ static int igc_xdp_init_tx_descriptor(struct igc_ring *ring,
>   	return -ENOMEM;
>   }
>   
> -static struct igc_ring *igc_xdp_get_tx_ring(struct igc_adapter *adapter,
> -					    int cpu)
> +struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter,
> +				 int cpu)

nit: you could squash the cpu param to the prev line while touching it

>   {
>   	int index = cpu;
>   
> @@ -2469,7 +2469,7 @@ static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
>   	if (unlikely(!xdpf))
>   		return -EFAULT;
>   
> -	ring = igc_xdp_get_tx_ring(adapter, cpu);
> +	ring = igc_get_tx_ring(adapter, cpu);
>   	nq = txring_txq(ring);
>   
>   	__netif_tx_lock(nq, cpu);
> @@ -2546,7 +2546,7 @@ static void igc_finalize_xdp(struct igc_adapter *adapter, int status)
>   	struct igc_ring *ring;
>   
>   	if (status & IGC_XDP_TX) {
> -		ring = igc_xdp_get_tx_ring(adapter, cpu);
> +		ring = igc_get_tx_ring(adapter, cpu);
>   		nq = txring_txq(ring);
>   
>   		__netif_tx_lock(nq, cpu);
> @@ -6699,7 +6699,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
>   	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>   		return -EINVAL;
>   
> -	ring = igc_xdp_get_tx_ring(adapter, cpu);
> +	ring = igc_get_tx_ring(adapter, cpu);
>   	nq = txring_txq(ring);
>   
>   	__netif_tx_lock(nq, cpu);


