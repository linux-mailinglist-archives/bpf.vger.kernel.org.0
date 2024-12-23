Return-Path: <bpf+bounces-47547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5186A9FAEFA
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 14:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F5E7A21A8
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE32A1AAE1E;
	Mon, 23 Dec 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSawOWif"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E0115C14B;
	Mon, 23 Dec 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734961999; cv=fail; b=ds6vEC4eU3AM6uWfaSVTS5EC7u0mIDKPqNd5UVApWDkgnrvGr0TZgTG/Xb59NjjjznjJjq9hX8egWGgQMvIBI09taYFFSHeq4K8DPmC2a3XbRlrG7VfwBoOTNKAmflie+07khuyGEbRvuG0PCrEVyo1uaZvR2ML3/gMyX4IK6Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734961999; c=relaxed/simple;
	bh=wcUmDpYi3D2ogX3DQX5vASym+FHaFLlq7/mxF7PPymg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=muxpsvSvptT6h8hP6clZlUThDpfZTMP3hJQiQ0sRublpXhY9fUu1ForykPvd6XN/MlSlw1i5nhq/uBciRdAfMaJ/XhOKEXkv0gA3SZcjOolv1W4kfZO8KEJ9A8I7GV8ef8YTJ6iRH+BNQzoNut7VmbtGqKk/Np7YnAUO1K/UnCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSawOWif; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734961997; x=1766497997;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wcUmDpYi3D2ogX3DQX5vASym+FHaFLlq7/mxF7PPymg=;
  b=OSawOWiflprkYkQKc21ARxBDgFpJMEbJnqvvNydWdNADCh559+Slhb89
   ffOD+gBLZqRVaccPfFKOr35FqmaJrjQgc81skQaXwckoB4gbY4y2RKinR
   YLT8bULoTKBc77PXZVLbWyNkywPm18C4rO/tuV28pdIcuxd4WwOBqNZYt
   wvvpxMBlSGzSmKuCPVdf3PnuG1Vv3Ay/NQGYp8ffThvFuQRXnrrf/hHfy
   MPOXs3ZRFIWkSFj93KEiELiUYBVSS2tx+nYx9birAn6TFLBtAfToHJf5h
   O51jQoqSPEQqn1MLH/NwRc6FUpcS2Q37wdctJQ85DSR0BEbCB2cZe9UiN
   w==;
X-CSE-ConnectionGUID: E4NgAk7QQPup2axJy3gGGg==
X-CSE-MsgGUID: RI4ok05nQqOprFvsS5gAhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="52828941"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="52828941"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 05:53:15 -0800
X-CSE-ConnectionGUID: 82ORAHm4S0SKnsdr2SsTZQ==
X-CSE-MsgGUID: 11YM2XsTRUiVvq4SFP1MfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="99431004"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 05:53:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 05:53:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 05:53:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 05:53:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/NwpeDmLUI3B8PL/Fh8feNdSr8Lf/33oM9YhhZnhru3OkEAdeOgY0o/14l0V3IzcfZnXHx7ihfZ44JLHHCCVbhihnEE4MqndYmnrnI3bOglmmRKcmGUP0H/MjDW+fWihpGPJhZwG7rOnhp782BAiouqbe50yqKsQP1dtkIM81j7mYilXbU/KWVulF5WNkyUOR/swNHRXxpie5vaRB7tPmpsrs19eeHXpmn12e4Df9twhMUgmLQuG4st/nkhDYkPT/hOa3JlMv5nhgKYKS2pIujW3fBK3sTUM1Y461b5c69AOeVoYvy+zgQTRoR6MS4NydGGl3lcQm+ImYWDa+wJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwJhWFDjOhoRGFk8aDyfARB8KJx8KAGMHS9gkbcbsZU=;
 b=tZRnpXlCLBlbzE4SDEtiTVYr2nlsd912E9SgDUt22bczfceF8LMqPOMmVUviphrdaOdUvrSXoahThA66kjalKha+z7VjKNRVdbws2xLMrASitJvtvkxRwvQBfjlupzdRdEOAsIkb4COHjNfwvX31LmZokEDPSiVzoMcus/tTyJACtuyoA+4YusXI/4+kgPVtvOByXcdIFf7G0OGl5CrlnCivdhmpRGQW/IImsDp2ltax78BMORo/t300tsbRGyY13SvOgG2x+Viy0ndPVFMdScvSZLaPWJ/dYuigJuIscX3uezXVGLXWIjys/FJY7b88B8zZqtKyWS60DsqK7q1bCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4194.namprd11.prod.outlook.com (2603:10b6:a03:1c0::13)
 by SA0PR11MB4736.namprd11.prod.outlook.com (2603:10b6:806:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 13:53:07 +0000
Received: from BY5PR11MB4194.namprd11.prod.outlook.com
 ([fe80::9d17:67a6:4f83:ef61]) by BY5PR11MB4194.namprd11.prod.outlook.com
 ([fe80::9d17:67a6:4f83:ef61%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 13:53:07 +0000
Message-ID: <8b993e58-290a-f852-2f53-dd14e7be0cce@intel.com>
Date: Mon, 23 Dec 2024 15:52:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 1/1] igc: Avoid unnecessary
 link down event in XDP_SETUP_PROG process
Content-Language: en-US
To: Song Yoong Siang <yoong.siang.song@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Vinicius
 Costa Gomes" <vinicius.gomes@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20241216073849.3555825-1-yoong.siang.song@intel.com>
From: Avigail Dahan <Avigailx.dahan@intel.com>
In-Reply-To: <20241216073849.3555825-1-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To BY5PR11MB4194.namprd11.prod.outlook.com (2603:10b6:a03:1c0::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4194:EE_|SA0PR11MB4736:EE_
X-MS-Office365-Filtering-Correlation-Id: da35eb70-b2aa-422b-5dde-08dd23592111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjFnUWxRMVljd2p6Q2xBV0FBN0wxVmpINW14REozcG8rbGw1L2QwVlNFbFNP?=
 =?utf-8?B?QU5aN3ltQzJPbnJocDZNYk1LODdXN2xweGdoMmRqNXlWWGRaTEdNaDl6UWEv?=
 =?utf-8?B?TzZQSzZ0bjVUU1VMSFJLUm04NGJpSFdtUXZwZzlHSGNNSENZYUxUMVpsdTBy?=
 =?utf-8?B?L0FEN2RYdk1zbStaTVZXR3hRelN4aDJ6elZ0Q211R29ZUXNRZjUvNDBPZ2lw?=
 =?utf-8?B?Z3ZaSzZ4alpRVzFxT0M1WWc3RTlENWM2VGpvRldhaWZsNGZRbmJ5bDNJdUpO?=
 =?utf-8?B?MkhZMHBmRTRXN1NnZitKQm13TmtMK2ZQaFZGSTN2R2JkNW53eE12N1RoS1Nn?=
 =?utf-8?B?T2ZVR0RoV1lndWdSTWNuSm0vK0pGNlk2dXkrZEJUY0d3eDFpTWs3VnVIVWV2?=
 =?utf-8?B?OXFwZjhzd3ljd05sYU0zUHBLMDJEVXFZcDFsSXRvcytaN3VOYkNxeUc1Qlkv?=
 =?utf-8?B?L3RaTDBWKyt1NjdjUFcxam1CZ051VkhYd3lETzR3eTJUT3AwaUhxalU1L2M0?=
 =?utf-8?B?em9QQ1BabWpSYTZIUURhNU1ZZWVjaXhlNkk0dWRJRExQbjNDUy96Zi8yMlJZ?=
 =?utf-8?B?RHQxVWVwcC92Z3ZDS3FWTk4zNUlEeTVGMzZGSW02T2FNVXpGVEZaZVdkTFNR?=
 =?utf-8?B?dnB2T1Fhbmhkd3RDemVEdXlSUWhMdHVUQ3FZbSszU21uWjh5Z0oxMEFHODZH?=
 =?utf-8?B?djN3QUtMekFyRGFMOEV1SzhuUVZrYk40c2xaWktIZ3I4QWducDJyL0hiSklF?=
 =?utf-8?B?a0ZjZnUyWE5UQWxTajZvcC80WGVCWDRxNXFkZWV0VzBUTmRCZnNXWWc4T1lR?=
 =?utf-8?B?QTgrRVE4R0Y2LzlDMDJRUUJrWGpBLzVFcW9zVGs1UjlsYXFzalRmeFVBbDls?=
 =?utf-8?B?RXVKQmtWbTE4LzV2NnNnZVFnTG9NWk9aVTFqYWFrL3hXRHBFQXdobkFhNlh1?=
 =?utf-8?B?VFZIMGh2Y1ErV2lNeFNUYm1qZDdPWEVrMkVxR3lNMWg5VGpZWGhjV3dRby93?=
 =?utf-8?B?blFkWkdVUGozRXdFWmEyYk1MeXpMTGl3Ynk0b2RRUzBvNzNuOUVOeUcwT1NC?=
 =?utf-8?B?Z3ZUeU81TmY4L2lydUl1akRqZlVSdWFpNGJydWZsWlZvTmtXT3Zrdk5NTkNM?=
 =?utf-8?B?dElEZFdWRkdYcUErTTRTbUZpUGxMRXo4YUp2N0VUODBvcEVFbjNyNzR3Zm1E?=
 =?utf-8?B?eGFEbWNtWmZCKzBkM3BXRDNIbk5zRjlJK1p4WXRXV1kzZW1VMlJPTW9mQitw?=
 =?utf-8?B?clNmd2VZVTArRzQ0OGV0azBHR0lGTyttdkRxVEQ0Yk9WNmdRNzk3Y3puM2Nt?=
 =?utf-8?B?aFYrNUY4ZTNUSzJYT0Ezakd0ejlzNjhxWVlBWlp6a2ZUbm4wYmVydzVQbnpP?=
 =?utf-8?B?TkExYXMwSDJnVXp0NUFoU01QNU9Db3dSeFc0d1dRaUZXYS9zQmZnUitSVGtT?=
 =?utf-8?B?bnJTazZ1TkVyblJ1ZXJuR2FWMmdHWTUxY2dZTm5ES3ZYRnI0cXBSamFCNmF3?=
 =?utf-8?B?WVg5YXMrT1I5Z3NySGF1Q1pVUXhhYXpSQ20wVDBZQzBDeDQ4RW9FS2lNdHVU?=
 =?utf-8?B?RXBFZzBWZmIwMXFzdkgzM2I2N3BjdlI0K2haa2ZOalNaeWI2aGI0aDZvYU03?=
 =?utf-8?B?bUNHM3R0MGpvSXdXR1BMTUJQRnB4TXB2OXd4eDdQbnM0d0p6QXpGMGkxUjlY?=
 =?utf-8?B?VTdLU3didVY0M01PU21rcFk1a1RxaTRHb2JPWVBhalc5QXV0L2xDZGloQWEx?=
 =?utf-8?B?c2tQc1dHV29TM2VJSnBPTU81OFZzN2lTVk1RR01sblZOSWYxODhLb0YwaFl0?=
 =?utf-8?B?TjNKcm45cW5LcG9ZL2o2OC9XMHBFY2lYVE9SNFUxSkhqaGF2KzBoQ05mdXp3?=
 =?utf-8?B?UUFyeWlyc1ZhckpVQUg2bndIRW9HeDJqT3pEdjlvMmpYY1FOaTBheHZicHFj?=
 =?utf-8?Q?Y2jEwrQ4rc1SQKWVF0iT9fbpqeOTwBWp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4194.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlNidTZGZGI4TS85VDYvelVKclZ6NUk2NXlNbVJnbC9oSmFtblFjOCt3WFlL?=
 =?utf-8?B?cjBrbEFiOG9EMnJ0UlVrcGZ1SWZyQjA0WXlDU2hCb1d0amRxKy9vRUFlNVJy?=
 =?utf-8?B?UlNvTDhtcXorNlZRckNOQ0oxVVRNU0hhT0hSRndGRC91WitocUV1SmxiKzdX?=
 =?utf-8?B?bDVWdjA2WmdRSklIOWZ0WVhWTitLVERBQTlRS1VDYWtId291UlZOUFJPOHMx?=
 =?utf-8?B?Q1NEU0M3dWUxUzRvdFI4bXhyZlFtWkhqVDRmS0lUbUlkYndrSEhsTWYvSHBN?=
 =?utf-8?B?M0xvak51RGVjeHlyck5JbFc4bHFpOVVlUHJxeno0T0trSm14eklxdFp5SjdC?=
 =?utf-8?B?aEZhV0NUSUQwamZWUXg4dEQ0QzhzQmdtRUlyeFJ0RDlIaVM0aHVRREMvakJ0?=
 =?utf-8?B?NmFudzJwRUV6OVdIR0p1U2RTSkxJZFI0aSswN2VFUnkra0JrU1ZGTHA2d0NM?=
 =?utf-8?B?VFMyWDNzdmduNyszMFZHRjA3QzduZ25hY2ZXMSt2d1ZpR1FkM0psWllpbExH?=
 =?utf-8?B?QVQzVnBkdlVEOHVvc3Mwa0JvYlJleC9KS0xSeEFOa0RhcWtyWGlYMGpTZmlH?=
 =?utf-8?B?Ry9OVCtucWFmenB4TUlsL2FaTlN4Z01YbXRnYzIxMGxoc2lzWnZ2c3B0NkJX?=
 =?utf-8?B?MzVwcnhHL0tmTWx2Ymt4U3JnK0VOYTZtcTNqcEdUMkJIa0xTRitXSjh1UC93?=
 =?utf-8?B?MTJwVjFQVStLQ016TDVVQktRdW8raTBmOUx4dGdHS0lEcDFhK1cwY1RsODZC?=
 =?utf-8?B?dTFINFo0dUoySXNZa3RBcXNveEhVeTZTVk12VFNRQm9Ca3VnQ1dUaXNkaHVs?=
 =?utf-8?B?bll3UEtoUjgzbEpnSHRBdlAyWktXSk9aajhGWXFpaDZmWU9ZM1VoL3pKbTlD?=
 =?utf-8?B?WUttYzFlZ0F1eXo2UjJSL0ZWK0RnV3NvNEdia0ZBSFg5L0xBY01vVDVoVTNr?=
 =?utf-8?B?MVZpVW9yZGJuZTdKMERxMnlOdnQvM2ZrSllOSDNtb3AwYXFvWlJHYklQK1k2?=
 =?utf-8?B?S3ByRWVRYjRWenY3bU1KZUZUWExjdUtHM3hLK3c3QzBMTXV6TG5vY0pqaTZ0?=
 =?utf-8?B?TjJyL1lva1ZVeU9SQW9aQktzMGFXZUZxT3k5YlRNUGtsd1ZLUHRQakhtcXNp?=
 =?utf-8?B?c1FIN2JFc2VYVTQyUWJObWpGYWVlRGdJRm5xTUV0Wi9wQmNpcE0wUHZsVlV1?=
 =?utf-8?B?WEVzVkpoY2FkblF6N0hjc08rQXNSazZIQThJSGZTNWFwM3VDTmorWU91Ym93?=
 =?utf-8?B?TE9veHp5RkZwWUNvME9pczhoakcreWJpWTA2ejZacGQ5YlVvcWwrT2djV2oz?=
 =?utf-8?B?aFpzSC94eHAxcUpCVmlaU2xKcktRbEJZSXhMN2VXMzkwRVVKQWR6R2ZkMm1m?=
 =?utf-8?B?Rk5CUnVNT0xxWVJ6QjVRc2J6dnVkLytOTExlOHFtbko4dXphdnUzckxCWmxZ?=
 =?utf-8?B?S1dIYkJFM2lnK0FlOXVEc2pZNUhITmJFaE5JeTNCRURHTkdwRG9KNjhWZWhS?=
 =?utf-8?B?STM3NTJyZ2pRRHY2bXFneTJRcU5YeTVrK0lHemlTUGR0b0NkdFdmbFBoRzZJ?=
 =?utf-8?B?emRRRmpuQTU0WGltRDd4cDJrYWxIbGtKaHRuNUsxaUp3Q2pZVUNRVy8zczRC?=
 =?utf-8?B?T3lMRkd6ZmpoM3Y3UHdKRzFFTmJVWkZGQkhNb1RKak9KTUhIbjdUNUJlY2JB?=
 =?utf-8?B?YUhva0djK0Z0SEFuMExmSGpNRlZFanZPVDR4YkJ0eXdMYWlCVDNaT1k0Y29w?=
 =?utf-8?B?c1hkamxmalE5cWIxekM1TVF2QjFjcm9xOU5pMmFzaFJhUDNIYk9CbDN1VjR5?=
 =?utf-8?B?dTNTQlgrbm92LzNMZDI5eEFYRm9oNmtkRmpqakZPL1lFMHhFSnY5U1B5T1Ny?=
 =?utf-8?B?WUplWlFUQlV4dVhWV0NTRUdwbHVQOWRWemNUY1liYlJ5bWlxRFk1dkJERkl6?=
 =?utf-8?B?VWJlbkFyM0cxTmpFUjBENkNTUHA5T2pQUmhFbGg3S3lSa1pOc0dLQzdyZE9I?=
 =?utf-8?B?YVRpc1ZrTXMxMEI4aEo1dHQzTk56YkUrT2Z1ZjJxK3FHY29Od0dJWlBiWHVt?=
 =?utf-8?B?WHhYRG9qS2p3eUNRYVVNM3hQTHNSUnF5WHh0bERHL2ovSmRHZjNhQTNhd3By?=
 =?utf-8?B?ZHpHSnN2M1FMMktxdjdjMXVBdE9EWVBZRXRtVGJZY3N5Sjg1TTF5SjgxaUIw?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da35eb70-b2aa-422b-5dde-08dd23592111
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4194.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 13:53:07.4119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJyIqCGax8oEKmJYIP9Emee+WMJ5ynxXarEcns4dLLNI3pYAcb9RqXvicQwh4/nonMYri9yvq+XP2bMAg6PgeaANBfQ+3damDhHHeinogM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4736
X-OriginatorOrg: intel.com



On 16/12/2024 9:38, Song Yoong Siang wrote:
> The igc_close()/igc_open() functions are too drastic for installing a new
> XDP prog because they cause undesirable link down event and device reset.
> 
> To avoid delays in Ethernet traffic, improve the XDP_SETUP_PROG process by
> using the same sequence as igc_xdp_setup_pool(), which performs only the
> necessary steps, as follows:
>   1. stop the traffic and clean buffer
>   2. stop NAPI
>   3. install the XDP program
>   4. resume NAPI
>   5. allocate buffer and resume the traffic
> 
> This patch has been tested using the 'ip link set xdpdrv' command to attach
> a simple XDP prog that always returns XDP_PASS.
> 
> Before this patch, attaching xdp program will cause ptp4l to lose sync for
> few seconds, as shown in ptp4l log below:
>    ptp4l[198.082]: rms    4 max    8 freq   +906 +/-   2 delay    12 +/-   0
>    ptp4l[199.082]: rms    3 max    4 freq   +906 +/-   3 delay    12 +/-   0
>    ptp4l[199.536]: port 1 (enp2s0): link down
>    ptp4l[199.536]: port 1 (enp2s0): SLAVE to FAULTY on FAULT_DETECTED (FT_UNSPECIFIED)
>    ptp4l[199.600]: selected local clock 22abbc.fffe.bb1234 as best master
>    ptp4l[199.600]: port 1 (enp2s0): assuming the grand master role
>    ptp4l[199.600]: port 1 (enp2s0): master state recommended in slave only mode
>    ptp4l[199.600]: port 1 (enp2s0): defaultDS.priority1 probably misconfigured
>    ptp4l[202.266]: port 1 (enp2s0): link up
>    ptp4l[202.300]: port 1 (enp2s0): FAULTY to LISTENING on INIT_COMPLETE
>    ptp4l[205.558]: port 1 (enp2s0): new foreign master 44abbc.fffe.bb2144-1
>    ptp4l[207.558]: selected best master clock 44abbc.fffe.bb2144
>    ptp4l[207.559]: port 1 (enp2s0): LISTENING to UNCALIBRATED on RS_SLAVE
>    ptp4l[208.308]: port 1 (enp2s0): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
>    ptp4l[208.933]: rms  742 max 1303 freq   -195 +/- 682 delay    12 +/-   0
>    ptp4l[209.933]: rms  178 max  274 freq   +387 +/- 243 delay    12 +/-   0
> 
> After this patch, attaching xdp program no longer cause ptp4l to lose sync,
> as shown in ptp4l log below:
>    ptp4l[201.183]: rms    1 max    3 freq   +959 +/-   1 delay     8 +/-   0
>    ptp4l[202.183]: rms    1 max    3 freq   +961 +/-   2 delay     8 +/-   0
>    ptp4l[203.183]: rms    2 max    3 freq   +958 +/-   2 delay     8 +/-   0
>    ptp4l[204.183]: rms    3 max    5 freq   +961 +/-   3 delay     8 +/-   0
>    ptp4l[205.183]: rms    2 max    4 freq   +964 +/-   3 delay     8 +/-   0
> 
> Besides, before this patch, attaching xdp program will causes flood ping to
> lose 10 packets, as shown in ping statistics below:
>    --- 169.254.1.2 ping statistics ---
>    100000 packets transmitted, 99990 received, +6 errors, 0.01% packet loss, time 34001ms
>    rtt min/avg/max/mdev = 0.028/0.301/3104.360/13.838 ms, pipe 10, ipg/ewma 0.340/0.243 ms
> 
> After this patch, attaching xdp program no longer cause flood ping to loss
> any packets, as shown in ping statistics below:
>    --- 169.254.1.2 ping statistics ---
>    100000 packets transmitted, 100000 received, 0% packet loss, time 32326ms
>    rtt min/avg/max/mdev = 0.027/0.231/19.589/0.155 ms, pipe 2, ipg/ewma 0.323/0.322 ms
> 
> On the other hand, this patch has been tested with tools/testing/selftests/
> bpf/xdp_hw_metadata app to make sure AF_XDP zero-copy is working fine with
> XDP Tx and Rx metadata. Below is the result of last packet after received
> 10000 UDP packets with interval 1 ms:
>    poll: 1 (0) skip=0 fail=0 redir=10000
>    xsk_ring_cons__peek: 1
>    0x55881c7ef7a8: rx_desc[9999]->addr=8f110 addr=8f110 comp_addr=8f110 EoP
>    rx_hash: 0xFB9BB6A3 with RSS type:0x1
>    HW RX-time:   1733923136269470866 (sec:1733923136.2695) delta to User RX-time sec:0.0000 (43.280 usec)
>    XDP RX-time:   1733923136269482482 (sec:1733923136.2695) delta to User RX-time sec:0.0000 (31.664 usec)
>    No rx_vlan_tci or rx_vlan_proto, err=-95
>    0x55881c7ef7a8: ping-pong with csum=ab19 (want 315b) csum_start=34 csum_offset=6
>    0x55881c7ef7a8: complete tx idx=9999 addr=f010
>    HW TX-complete-time:   1733923136269591637 (sec:1733923136.2696) delta to User TX-complete-time sec:0.0001 (108.571 usec)
>    XDP RX-time:   1733923136269482482 (sec:1733923136.2695) delta to User TX-complete-time sec:0.0002 (217.726 usec)
>    HW RX-time:   1733923136269470866 (sec:1733923136.2695) delta to HW TX-complete-time sec:0.0001 (120.771 usec)
>    0x55881c7ef7a8: complete rx idx=10127 addr=8f110
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
> V2: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20241211134532.3489335-1-yoong.siang.song@intel.com/
> V1: https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20241204120233.3148482-1-yoong.siang.song@intel.com/
> 
> V3 changelog:
>   - Change commit title to be more specific. (Paul)
>   - Use unsigned int, instead of int, for array elements. (Paul)
>   - Fix grammar mistakes on commit message. (Paul)
>   - Explain why igc_close()/igc_open() are not needed in commit message. (Paul)
> V2 changelog:
>   - shows some examples of problem in commit message. (Vinicius)
>   - igc_close()/igc_open() are too big a hammer for installing a new XDP
>     program. Only do we we really need. (Vinicius)
> ---
>   drivers/net/ethernet/intel/igc/igc_xdp.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

