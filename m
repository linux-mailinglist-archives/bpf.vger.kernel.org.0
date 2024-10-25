Return-Path: <bpf+bounces-43133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 028289AF8BF
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 06:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E154B22586
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 04:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACBB18C01F;
	Fri, 25 Oct 2024 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgvAeHP9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11211DFD8;
	Fri, 25 Oct 2024 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729829179; cv=fail; b=r2uLMxdmxFc4OuEH8Qlwg+sz0vueegXYfsLPQ0hx/UZBtDnKQQGi7p9cZGhKFExOl3Kk73bM6PmRyaZOr0W4FLOFXbUwZ9K0tbTVNso3xclqHqxL3QJh3nGZ2rjOUi58pCaJntM9OScBTCth7hSoEdKUjubYBkxCJ+ppxA2tbZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729829179; c=relaxed/simple;
	bh=TLGPduHHmWz6IfAbNAmHtU9tMvk5QTYcQLPFa+4WRDY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gcVa6GJ0bNRbRz8P4+UfXHYG+6n+rd5bA5BhL7K23/lYdLnZtRQwnotwIax3lXAhGYuZucwzLJEkeubhvKEceJQ34TNOI0ofJsnG1XkKsuqH/ZeNob68dZNBM6noRMC40r798hGQ2SF+njdf7PIJORSqTvK6KxyKyCEqlYRwURM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgvAeHP9; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729829177; x=1761365177;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TLGPduHHmWz6IfAbNAmHtU9tMvk5QTYcQLPFa+4WRDY=;
  b=WgvAeHP9YsQA+kgmKxBeF9T2+Wu6EPLg5FXGLD9XFSYpOPtTZbf+uvBh
   JswYEVwFv89JdVNuBWK/HSNF8GUt2HwnzOOZwHoWpV6pEVPYUh8w/wjoB
   udKXA2679Z5pWoncMLHVo7+s6mfphQaZYFN3JoxI47nDuRMlRsJmAA+Yn
   zL04cTKQVCWatphlA77jONBWmq7Evll2v+8IJhMxfOW/rXJavDNx+ZAeK
   PdwoYC71WRtNlig9Z4tWKoZ2tmPnWNdSpGd98bzvS3xgiQYbVXq5Sdnrm
   0bC36rVeYgcoe+NJOCpVHAYlojtAEc1kUWfi6ahhnQ7ri/UjO2Fjyt3iO
   A==;
X-CSE-ConnectionGUID: /VFEtaU0SvWGHxXfsy3AvA==
X-CSE-MsgGUID: 7vdOf/rrSNGt5GdTo68f6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29263239"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29263239"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 21:06:17 -0700
X-CSE-ConnectionGUID: 31lEy2PFTC6nGlSusj033A==
X-CSE-MsgGUID: srwF12IKT2GvdU6eZFobLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85349256"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 21:06:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 21:06:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 21:06:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 21:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3mlfgmUBis4IT4MDvUCzTu9577HShlx86aHmH1ubD51s0hBATVTUmXa9p9vkeWhtpGvvla3SIrn46N2afNncgZvTq33ubPvg0Ck7tkFJaanQtxAw070W7JDM+P6rUYMxGoFTw3SBtUQ5Ynd75B2dz2SXNNX6JwOvhCowKvSSmzaQH4cR5Jl7ZH5SpRSYip9kjWYDkjtugqAnnMmxgHAFuT+guviVP9Q2cQOTmfWv8MpearjM9SYXMoD4JjG/0x4AowBAlb+8Y90x88UcYWtFS48S57NF/vixRLzqdFnMwUYRanqoZeZTQI9e2qhiJy32ctTu9TGqdXqyf1AKcaHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKqjyZQrIN9aKekIzjdFn04fHP4WD6TOJ9xJP7wxxNY=;
 b=nwXemQY58F9yjRGqWJdTfr/g5XHcJtq/yY1hVgh3A/iK5q34bm2sy17bOHU2RbkwcjnqUOTwgaEmhRa9eWnjPjMbPKJRqkuRzCKumUyNds0GZ2TQdBect+Vlpjn66OmrgDHhvxVsbZu+gIVuXH2x1umQJOGGZTgJVS0YicJYK5czCKnZVpYcxv2k9n5dr8hiA/O0I8+NJorhQmK+j3+AP6DnUZ6eN6+H4/YPhUrm6x+9D+Lrjqnqik7CmXwbuYuO3szfcS6KhmvWolnvDSgoP05piCxXtd0tz0y3yqKMZ1z+a17QNbm3AK3DSGvsMKrfontnOGQDYG4A9FpI1BCF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH8PR11MB8257.namprd11.prod.outlook.com (2603:10b6:510:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 04:06:12 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 04:06:12 +0000
Message-ID: <1c9afb23-fcf8-4401-af06-4a0b2dcbb135@intel.com>
Date: Fri, 25 Oct 2024 06:06:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: intel: use ethtool string helpers
To: Rosen Penev <rosenp@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
	<bpf@vger.kernel.org>
References: <20241024195647.176614-1-rosenp@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241024195647.176614-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH8PR11MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: c74dfb00-410b-4840-0c65-08dcf4aa5d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGMvTm5CdTFteEJEM0R6TjRsVzhJZ1o5aVhTSHA0Y0pscklHTHphaFp2R3Nk?=
 =?utf-8?B?MGtaM3c4cGluRFByMmMvaHZyRXk5bjYzMTlGY1QybDZ3TkJLdmM5M0RxRmNQ?=
 =?utf-8?B?VG4zR3VCbnQ0WnFMMDRSZXpWVlVCaElxUTNyYmp4TC9lMXNHR2wvU0IzUitK?=
 =?utf-8?B?YWllZEMrb1FJQ0ZaWkRlQzE1Vkl3WThROHFUVmFhVFNZTUVTMWN2MndwZVlI?=
 =?utf-8?B?WjhuNEwvcVFwZkNNZktsbGpzTnlMc0xQaGVmSndjWDU4NkNjWWpNMmt5TjJH?=
 =?utf-8?B?UFFmN3ZOSTFvWXFzQjJoWnRuQ1VIT1NFQ2JtWDNkNVMzRmVGVVhrWjd5c0xM?=
 =?utf-8?B?cGg0clBCbktSUnlubmx1YnRrNmIzbG9aRVdhSXdqVWxUNG05cGx0bUtLd0Y4?=
 =?utf-8?B?eGFEOHR0dFpjU2w4UzBQZHAvV3hwM3ZYVXh2QmNnNUY1MU1QYVlxMWNzeU9q?=
 =?utf-8?B?cnV5VzRhT1ZRbWNRVnFxcjRZZnNDVjhLT3VVNnJlV2NWMGNxVlkvSlZ2aElM?=
 =?utf-8?B?L1Z3c0F2UUlWU1pXZXFMazVyZkFBYUlTTENvcU1EeGU1OCs3aFJZY01lL29p?=
 =?utf-8?B?MXUwdzY3c2sxRnE4STVBRXZpUzE4dGR0SGltUjR1d1BzQ0F1QVVsQlBiZ2ho?=
 =?utf-8?B?OU9LL3NWQnFDSUo1aEVhdXIxV0g4ZkdicXFDbXhEaS9TWU1RVGNjeEZKa3M0?=
 =?utf-8?B?dzVQdkRuRENzSGxBclp5TmdGd3E5N3RNQUwvdjFQb2YwcG5rdHhhU1pmWjll?=
 =?utf-8?B?K1BHdkpORXlNaWMycEZZOHgvRWEzcUF4aG84eXNCdmpVblJzL1hKcE9vZEk3?=
 =?utf-8?B?dm1NSlV1UnJNR0dzZ0p4NGpSOFA0ZkNlRnhpK0R0NFJ2ckRVZ3J4Nkx4UG9G?=
 =?utf-8?B?M1JGOXlObzhnZUl0S3dsYmpkSm44MVdHcVhuMi9NVit1RnVlMUVDbTBFRmVE?=
 =?utf-8?B?VWV0L0I3QytoWG9oWlRIaVZMeGJGN00wVWp1c0l2NjQ3Y2E2cHloSEJBemFt?=
 =?utf-8?B?ajhUb2ZmOGt4WVFOSm1EWEZvU0ZrRlBDRFR5a28vWHZtalY5ZFMwbkIvbHE1?=
 =?utf-8?B?d0NoMkpIbUdBcVBtV29WS3hza3RVeTJUYzNsVmJreVJXOGxyWktaR09aU2F3?=
 =?utf-8?B?WVlaUnEwSWM3SjBJUURnalYxK0hWSW0zWVR5MFN1eUQrZGRzRElYZmo0bW1B?=
 =?utf-8?B?aGlpR2QxMHhpY2djQjBEMzBWdUw0WGkwRzlTSVRZczl0NUk5Y05mQ2NIWSty?=
 =?utf-8?B?TGtKSm4yajcwcTNPeEQzNUVrbjF1WWxFSHFOdGxzZjVkdC9IQnp4b0dHL2NI?=
 =?utf-8?B?NVN1VG90aG5HcHdGOHRFRWZGOXdveUpKYXZBWkx4Z0U1cS9CV214am1qMzJI?=
 =?utf-8?B?SXlsQlFWOTNLaGZmaHFhOXJyaTNNMkFqYW5GVmJBb2xDMTRCVmxTUjQvYUZs?=
 =?utf-8?B?OW1OZVhsYnZtbTRYRkQ4aU82VTg5b3cwZGFkZ0ZTU0U4Z1hzVFJwNlpXbUtt?=
 =?utf-8?B?RDJHYWZBd2VIUk9rOWhUM2FFalhtMUNMemIyQVFIQTRMeTV2TkY5c3QwZDJz?=
 =?utf-8?B?WEd4ZCtwbkNCZzFWN1gwa3VlMWwvTlg1Z1IwdnUzL3NxQmtUa0NVSXozYjho?=
 =?utf-8?B?RUYyL0lzNXZ1MGpteXFKb0k4czdGS3VmcFdoNXZGV1dMS2pIb3ZkMFV2OHh3?=
 =?utf-8?B?K0ZTQUJuTE5aTUpINm9aTDRCS1dtbVVSUU5oSndIbXVLc2VmTEw2blptSnJF?=
 =?utf-8?Q?1KBFbPlhpOYtCjVwLKhx+kYIWmhygSL8rErTOax?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHRmYW40YnRQZWp5SU4zOGJsRVR1N3R6VW1lZWpyVUdrZjJFclErWDVxQnBT?=
 =?utf-8?B?OGxKSThiZXQzaVpoMUFWVFlaT3VqYTNDWFpCbkRRVDFHbVoyR1B1ZjNoWFJ1?=
 =?utf-8?B?L01id0ZrUUJQQWR3UjJQd3YwYk12K215MHpjVUtsRm11cFl4aHRlUG5BNHZ3?=
 =?utf-8?B?dUVJNk8yK2dhY3RzY2NKbW9MRDZKSmZWMHljREtVdkc5RW5PUElOSWFZeUIr?=
 =?utf-8?B?OVVIMVJzcTBVVjRWTXA1VUYvYzYvNGhYZWJyNVEwTHdhN3daQkhobUVaWkJq?=
 =?utf-8?B?UHVxZUMrQ1B4T2UwbUp5MVBjUjloTkZDOUlXNHZrdEJMSHNWUUFoMkdiOUR6?=
 =?utf-8?B?V0NwVkx3RFJnck1aYTNTK2k2REVZSVNxb0pPblpYMEMzOENKd1dReS9CRWFD?=
 =?utf-8?B?R21aYjVXd3M3WnBUd3hjL3k2bkZtZ2pGUXlpWVBRNHl4SDBqTXBPQkx3YVFv?=
 =?utf-8?B?SHRYMUJyZG96bHZGd3dCb2VTRkFydGJWOGJETDBtdVdqSUtOcHpoeTgwV0tw?=
 =?utf-8?B?SkJLc1BXN2RBbDQzcHo0Vzd1MWJUR0RUNXFhU2dBZWN4c2RHS3BXWksybm9G?=
 =?utf-8?B?V2pmTXp4cW1FNUU4RlBXVHY1a1VhMFBucW9LMmp0WlRMRmorVnFEb1ovZ040?=
 =?utf-8?B?eHZyM1NHemtzamhLUXJhNnZiblJLazNGVHlMblYrbmFJamR2bWNUeXMzK2cz?=
 =?utf-8?B?YXFBTGVoY3lBOUQ1OUYrOGxNU2JlY1pOcFNydTJEb2dHV3l5NUZEL1pSRndD?=
 =?utf-8?B?MytYOVZSM3N0RkJsT1R5L3VMVEZzYko3VnZIOTZXYXRBRnFtcThWOENSbmNl?=
 =?utf-8?B?RlZ1cFlsMGZLT1gwRUJjNzdiRHI2Zm1XUGMrbjZMV1QzMit5YzZ6dFAvZG5l?=
 =?utf-8?B?bkpBeFYvK0VXT3R3cFlXMW5wbmlibmNDQ0I5eEF2Ty9FcVFRbGp6bTZFN2oy?=
 =?utf-8?B?Z3dLdFc5cDhHWVBIK01ROFZlczQ5Sm1zcVdiVXZhYUQ5NTJuVnhpMlU3Z1VW?=
 =?utf-8?B?UHcrVk5hTjQ4d2JuY3gxK2p5dWc1bU9GajlkckNzdmppNmtDZWpxS21yNGtC?=
 =?utf-8?B?RzVhZU15Qzg1VG1NUmFrZitqdHNtYUV0S0JmZXo4V0dhdWZmTUxjOTlGZEhi?=
 =?utf-8?B?TjdUSmZua2tOdmdwbEdVL29WcG9HSHROTzNyelQ4V29MZEdwamJkaHlQK2RJ?=
 =?utf-8?B?NnllOFRXSjJiZHJvRVBKeElnamhIU1o4SXBwdzU4ZGFGVDFLN1VLeHZzeUhQ?=
 =?utf-8?B?T0VKZVBOUTY0MEhLcEx0WWJvN1hHOTF1Y3VpOWlaaVRKNXM5YmJPUjVEcVE2?=
 =?utf-8?B?cTVlNXdWTE85eXFNMlQ0VEo3QlhEciswbXpWV05GRlQ2MENxT0RjN0lEQi85?=
 =?utf-8?B?S2QvV0cwOG1uRytaZ3JCZXVoeDNLdmlTdmpIVE5WTW4vYXJzbXZ0WkwweUpM?=
 =?utf-8?B?VUhsUTM4UkVQZ2hHV1pBbUtneC9jT3NFRG5sUGNPWUJWUFdaNk1OMURrRmlu?=
 =?utf-8?B?MXF4blZlZVhIY21aK3U5Qnl1eWZyYU5KZUNGeTVqNFowblUyankyNUYrbzQ2?=
 =?utf-8?B?MFd3b3QwRFhxczhTZHVXblVmRFd2eG5VZzY4WERSUW9rcVdobkVLRUtKdDQw?=
 =?utf-8?B?emk0aWxQejg5N0NTSFF2WDg1dzdCYzRaN05QcCtYVVNhc3pBWnp0d0pvYVdm?=
 =?utf-8?B?NnI1Qkp2cnZtSnRsSUV4ZzFyaXIwYzZ4b3Y5MXp0RjhNVDFPTHp1U0NRNEJm?=
 =?utf-8?B?QkdEaXNqWlAzMWJPWGRtQkYxMWFNd1hKK3hiTTFRNlBNZWplTmEwK2g5YU9O?=
 =?utf-8?B?bVJaUjd0M25EMVNMWkRvc1BKRWh2MitPd1piL2pMR0JzOTUzZFJEVk51S0Fu?=
 =?utf-8?B?WnlmMUJINDhPOVFiekdxV3pVQTM2ajU2aWJxWFMzc0hCNURUM3RnZHNVVDhh?=
 =?utf-8?B?R1hUWDBpK2pWb09td1VqQm92RFhTeG5hY1pORlUxOVE5T0x4SDAzTEtpVDEv?=
 =?utf-8?B?Zk1ZT0syelljWnpHWVVBOTlKYlJubjM4SzUzMVR6cU1zUW9qWTA2WW9LL2da?=
 =?utf-8?B?c3FkMjJpVnJZMjE3NVlhNjJPVlVKanl0NDZKU08wWjN1UC9pQWFiS09zbTIr?=
 =?utf-8?B?Y0toSXhTRHJINytWZldDM3VPT1VGMjBRU0VMNTJvZGtselVDUGxneDdyU1N4?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c74dfb00-410b-4840-0c65-08dcf4aa5d35
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 04:06:12.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzF06pfWRi/P1reyCbUgfO/WXC1MibLauHsf2yzfQy1L2JgKBUdu5AkE3PMJ6X2Tq2nDwSQjtAP+Q/8kdAwioV6n/lD1Bdm/JLk9XNbcpec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8257
X-OriginatorOrg: intel.com

On 10/24/24 21:56, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.

Indeed, thanks a lot!

Could you please tag next version as [iwl-next], so it will be easier to
via Tony's tree first?

Codewise it's good, just one nitpick from me.

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++---
>   drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 +++----
>   .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 12 +++---
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  8 ++--
>   drivers/net/ethernet/intel/ice/ice_ethtool.c  | 37 +++++++++++--------
>   drivers/net/ethernet/intel/igb/igb_ethtool.c  | 35 ++++++++++--------
>   drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 ++---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c  | 36 +++++++++---------
>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 32 ++++++++--------
>   drivers/net/ethernet/intel/ixgbevf/ethtool.c  | 36 +++++++-----------
>   10 files changed, 119 insertions(+), 111 deletions(-)
> 

[..]

> --- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> @@ -122,7 +122,7 @@ static const char fm10k_gstrings_test[][ETH_GSTRING_LEN] = {
>   	"Mailbox test (on/offline)"
>   };
>   
> -#define FM10K_TEST_LEN (sizeof(fm10k_gstrings_test) / ETH_GSTRING_LEN)
> +#define FM10K_TEST_LEN ARRAY_SIZE(fm10k_gstrings_test)

this line is not strictly related to the stated goal of the commit,
fine anyway for me

>   
>   enum fm10k_self_test_types {
>   	FM10K_TEST_MBX,
> @@ -180,17 +180,19 @@ static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
>   static void fm10k_get_strings(struct net_device *dev,
>   			      u32 stringset, u8 *data)
>   {
> +	int i;
> +
>   	switch (stringset) {
>   	case ETH_SS_TEST:
> -		memcpy(data, fm10k_gstrings_test,
> -		       FM10K_TEST_LEN * ETH_GSTRING_LEN);
> +		for (i = 0; i < FM10K_TEST_LEN; i++)

for new code we put the iterator declaration into the loop, do:
		for (int i = 0; ...

ditto other places/drivers

> +			ethtool_puts(&data, fm10k_gstrings_test[i]);
>   		break;
>   	case ETH_SS_STATS:
>   		fm10k_get_stat_strings(dev, data);
>   		break;
>   	case ETH_SS_PRIV_FLAGS:
> -		memcpy(data, fm10k_prv_flags,
> -		       FM10K_PRV_FLAG_LEN * ETH_GSTRING_LEN);
> +		for (i = 0; i < FM10K_PRV_FLAG_LEN; i++)
> +			ethtool_puts(&data, fm10k_prv_flags[i]);
>   		break;
>   	}
>   }


