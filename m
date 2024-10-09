Return-Path: <bpf+bounces-41400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D02996ADA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 14:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54E71C22D8E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5576199230;
	Wed,  9 Oct 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtUkwdyR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75170192B67;
	Wed,  9 Oct 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478254; cv=fail; b=KFkpDh6fzwF5AG2JFpuaNzbN6Z7VI46r9We2tOTLqHJdUUa0fWgnALi4Riw06Nda1TswT4ZBDqIw8vqpcN1bkn/3zUdKCwBDbUHHD3HW6seQmBCfxv1+53mAoVAsdw4DbObeHRLWcFAwNFKcF6rfSseG4dDNqciMdM9Yik4Dy18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478254; c=relaxed/simple;
	bh=wyR/OiE8u2q4ohSg8h5JZjMA0hbkuvLOR2JpYNtjaJ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EzjULtVkf1yO2mTBl2rF598ci0n6s2T8ir/Do+6ijeDAWoxx6MwVu9l2D+8NF8wS3yv9yG+NeBlEGMXYGoeDnKCiicudTpqwTltsl8RbWhU8+bGgP8+6soELv+VyPQT8Q6s9D5zCYzMWs5yQk19QU37kE0G77yisppuo+GFIzMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtUkwdyR; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728478253; x=1760014253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wyR/OiE8u2q4ohSg8h5JZjMA0hbkuvLOR2JpYNtjaJ0=;
  b=CtUkwdyRE784N/u+FY/B1KUBMWBdreFg6Awkx4S8IsRhlZSR5o8SJhnl
   HGbLilITR1/xnkAegkMiKHL5TP/kXc0kx1pufSWiufRAPkDHw0rhjtkbP
   dR1cxa2ibtRK34XY4D6S3W2e/hcfDSocTZF30rOW2Z53DgBWYyP2PGhiq
   92ivr/SOtgI7G3lAxyWuQoifrkMGuUqXtjTf+U7P1fwqRPQ6F4Q7FoNTr
   tls0ZsGfjQm56lK92Q+ahDuBsnX8P9+/jpnxd0LviwMeqwJcafPYdqooL
   gRlVGe6JegYOdTcRIcTGC5Gvv9M0rmj9YhExQnE766w8Xu1pGSXqpG2sK
   w==;
X-CSE-ConnectionGUID: keFMgldhR4qM/Jn4BGWpzA==
X-CSE-MsgGUID: YBpBoxjiR6a2yiovwsoPGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31666733"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31666733"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 05:50:52 -0700
X-CSE-ConnectionGUID: fHKem2f+SBGtY6bwctDOog==
X-CSE-MsgGUID: 9A/HH0r+TlWfIcadkV82lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="107059908"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 05:50:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 05:50:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 05:50:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 05:50:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:50:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgwHN6jhbfdfo5UMfNtAclCimu7tPgbFt9X1QXoZnpxqU3wnRQ5CKo3/qm7PO3uWX2/1QinFX/F01iPVTFL6VmdaV7/L4FhF02doA2lM8XnhYTdjx62NQ+JMiLMFJUMz2usxhc9hW/xw1UM+SWi5fnAKoxf+qD+xC8hsdqTdSTVNhQMyAxZWP58M/dYfvb1cU/luWVnEOg3d7lrzHwHmLLaEkMZFXd7Pr5cvFDTDvPQTWEted+tJ6mwfn+VUPQWwuHcAvxjvGrgMhb7VdamT/5eB606pQkAdcmjGljZSpO6qcmSwYAhjMkEFToe8rdY/byHK1BxyoHQLtgxNIv0awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO1aZkwBHU8NxenYtIT2xHU7zY1vQF/7oEy10n2ag+8=;
 b=GHgvR/I5aE6Myz3caJL6Rwwxk1IlwZJaIpl+K70tVk74x3e+y+h0OJVg29+jB+iQRCAGgyUvTqsj+ZYx1AH3PB0DvzJ9hFcxNHMfw1K7gM1C/B0/4oXGQChd2AeaWzxbct17y0GyQ7q3+2PJse4ryWWTzRW3JsaXjxURaZTR8Qpwt8Y6aAVPi17rcmUyGjQbNuuMc+2Z7u2AgCAPXm0dDAK9YHzUh839qFwihd0ACYHD7gNJ8JZFLHe3VD3tbL0XhxTf4JurvdCjFy435xV2qroBbW+yBplWtHfSlefbk9roW3Qj7isgOXdyVRt3tp0GhHd323Ay7lsYLZ9uYUuc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 12:50:48 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 12:50:48 +0000
Message-ID: <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
Date: Wed, 9 Oct 2024 14:50:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
CC: <bpf@vger.kernel.org>, <kuba@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <john.fastabend@gmail.com>,
	<hawk@kernel.org>, <martin.lau@linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<lorenzo.bianconi@redhat.com>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZwZ7fr_STZStsnln@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR03CA0009.eurprd03.prod.outlook.com
 (2603:10a6:10:be::22) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: cced3f12-7b74-4366-ff90-08dce860ff96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S21xTi9iU0xOVDBGSXpoam5Zckl2YkFrWW9YV09rNVh1QmlLejhZeVhMQ3NC?=
 =?utf-8?B?ajhQL1g5VFd2QklmQTVoSnh5cnEwNU9lUlFrQlBPbHU2TDRmNVg0bFNxWndr?=
 =?utf-8?B?NENJNHJZTWVxdVRmeGtPZkQ2OW0wVFVuc0hXKytlVjNWRG1LT01GWGlMYnNo?=
 =?utf-8?B?djVCQng4Rk5hVTJ4ZDRKWFcvakRhNWZoWk5mQkpJU1ByL1BDTm9mY2pVMFRD?=
 =?utf-8?B?dWp2T3ZNdDE4V0huU2o2V2JuM3Q1d0FqbnlVZ2J5SC9LSVkzY3NOMW1RcWZW?=
 =?utf-8?B?T0tBOWs0cUVmK09ZWmdjazFQTGdEUjlWenRMbXlxZGpDaDQ4bEtwTTBOK2dF?=
 =?utf-8?B?OEVYcitLUWZuSXhxZ2wzTFBFVFlFOGtTZkwwbGRqS0pSSGEyY2RXc0Q1NkU3?=
 =?utf-8?B?LzIxbkNNWXA3UjFvbnlIYzI4WXVvdFRPc0VqOHI5WmJ5c3dtTnZtLzByalZP?=
 =?utf-8?B?d3N5eFo5RTBDc0NLNVM2dHVGeVorUWF2bVZQRm4reUZoSGpiOWpwR1Bpd0JW?=
 =?utf-8?B?dThxQXdreXN6dXo3YTRnbi9hTDlldmN3ajdrb2tPRWVQUGlhNk91NXVteW8r?=
 =?utf-8?B?ZlhsVEtoOWNMeUdRVHRYRVVqRGt6M3U1d2JqRDdiTGRZYzNSSW95SmFzanpM?=
 =?utf-8?B?ME53UFZJdk9kbE9pVDFUNVcyZFpTa2Y4L24zdk1Fb3ZBOE9SaVNKKzhOTktJ?=
 =?utf-8?B?Tnl5ZUxSREpaWFVwQmJkMHhlWDFkTS9qRzNwR3dVUVZlZDlrbzhMcFJGdzBJ?=
 =?utf-8?B?K3JKMThTcVNFaThGT04zUHJodHVlcUtsbGZSbm9CQ0xWSnZKY29DdGN2cFlv?=
 =?utf-8?B?UHVxcXJvQ1JIWExJc2tvY2Y0NG9YMmtWOXBVa0pOVGdjSjBzZllQSzhoSHA1?=
 =?utf-8?B?L1hkVlk0aWhYRjBFWUkyOHA1MXExcVBudTBudXo3MGVzMllNR0FSa0VrVWVx?=
 =?utf-8?B?dW9NbnNSQzBJelp6OWFSQTFVVFk2RjFvWjZEbTAyVXJRdElUY2tFOXEwK1BZ?=
 =?utf-8?B?MzdXOFF1Q0tMQ1IwOURCNUpDcVh6NDIvL3FDYlZON0FXR1Z6dGVDUnBEaTIw?=
 =?utf-8?B?eEowNEVTZFk5elpJd3dvMU1VaFh4V3BobHNBay82Y3RWZzlraHhlMmJTdkdl?=
 =?utf-8?B?QWZieXRWUURhZDRKdEM0SlF1eFY4U3hDQjVCbkNpby8yLzBzRFNLZitJWFJ5?=
 =?utf-8?B?WWNyYW93d3lldzYvb2pnc3BQK3k1YzJ3eUJFMk1DbldvMWxGOEhRNnBPajF6?=
 =?utf-8?B?YndJQ1g4ckpjaUhDRXFNdUxFMThpR0VlSGRvRmVLYmF5dGxVZW9LZW5CRmdD?=
 =?utf-8?B?K2hJTStPcDhLRzVHYS9HcURNc0NrK1A2S0ZMV3IvUzdhWEx5YVBNMC9xY1Jo?=
 =?utf-8?B?TSt2RmFHdC91MW5wNHZuT1ZaOTdtdVhDbWtCVWNMM0k2b1ltNjE0ZjI3YlIr?=
 =?utf-8?B?QjZFM3RlOXJWWDdRQ3pDcHJMUjNkV0p1NDIyRVMrdnZsUXdzS1Vsbk1qZmV0?=
 =?utf-8?B?VWVZVCtDNEdSSVVQbG9wZ3kxUmVlTDJFU3UyWE8vTmgyUUlCZjFCRmJaVzdF?=
 =?utf-8?B?em8yTU1HbTVnRkcvY0RNVXVsYUkrbE0wai9zb0k3WUpjdlA5T1JncHE1dVIr?=
 =?utf-8?B?L0lvaEFiSExBSzNNeHRONGthRHZnclJ1R2dsdWp5NXp6MG5WMTVYU0l0a1k1?=
 =?utf-8?B?b2d0T1ZTYlZmTFN0RmVOcURVM0pRMDdLTE1HMkJvWE8zejBkVWdnbWZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlpVzZ1SW5UN2NlMmk1UkdBVDc2MzBCTmcxYndFbUs4em84UCtKUzN6aHVX?=
 =?utf-8?B?bVJUbDdSY1dYNmd5bEJKbFc5V2lOTzJ5RytacG9vcTJsVnducUdEalRhclYr?=
 =?utf-8?B?cFhpeUloL2dNZS9XWVljQlQ4amlrSUg3MEF5ZktMVGphbmV6T0Fhdlh4VGx4?=
 =?utf-8?B?eUNyb0V1ampzVWNVa3Q3SHNDSENNcWtGZ05hKzlhZXZoelUzNVlHdUNBbnVw?=
 =?utf-8?B?bW5jZUVqWFFNTzgvZGxWZXl5R25odmx2dFNxem9jTHd0blExdWNobXJpai9S?=
 =?utf-8?B?VzlyZG9LWGk2K3BQVlM3YlVqZFBlNUlaU1F1dzQ4VVV6MlN3RCtzR2JZci8r?=
 =?utf-8?B?UVBCT2FsRjlWeHFTQkh0NUtEampWTm9mbklaaXg1bzR5cWdZNzltNFIvRXdi?=
 =?utf-8?B?bzVGZ3lFRlpkNlVFbm1zVW8zUFU0WjJQY2VYVkVVc0RMalE0ME9rR3Z2V2pm?=
 =?utf-8?B?MkVMNmpYZytaTVZkUWR5TkY3QVVEYWwvMzBJOHZXazFSOHdhTGhUYVpoZmpa?=
 =?utf-8?B?bFZ3ZW1FcmJ5ellkY25wU25TOHRRZzdkUVd3S2d2alNlaVRBY2R3TWhpamdQ?=
 =?utf-8?B?ZWE5MW5IclVHbW9vSkdhZUlUd3dzTjlzRVFxRmtkLzlDVGJ0OUtTczF0QWZ4?=
 =?utf-8?B?cWtvdXdwa0tadXI3a3o3MVN2K21ZbDV2WU11eDZXVTRxaU0wSWgzYVhBWlZ2?=
 =?utf-8?B?Q1Y2QmRPbHUrUW9HUERoVnhTZ2RXenJmQzZwR2sxNlVBcHphK2tlYzZzdzZU?=
 =?utf-8?B?S2xZQWJ1cEtNMDJrZnJYK0E5UEZhNVo2UGlJZFNlTy92M1FRNThUZ0FrekpN?=
 =?utf-8?B?dFFteWlpUHk0ODlReHh5UVNjN1B0d01tMHNWbEh6eWRBS1NNWVpyZDQ4R2pT?=
 =?utf-8?B?aDYwMi9zMnoyZmVUWG1aQytmMCtOcEhsUG5Va3FVMHNhdTB1QTdVYU8xbVZa?=
 =?utf-8?B?QXAyT0hEUTA1V1hjMGs0bUJueHBxdVJoaHBPNk9lTW1xdnA2a3pYYXJnS29v?=
 =?utf-8?B?WkZKK1dBWHNxRWF6a1NJT2Z1Tkx0ajVFMkh6RGlZbzVGVmhpTHMxWEdKRzBH?=
 =?utf-8?B?QXcyQkFjMk4yNnArdlRRSGduQ1lKeVRraVIvWVpaL2NIbjE4R3FwSmw5R3lN?=
 =?utf-8?B?ZEp3THUycUxQMmRSc2x0dXZ3RmlIakZubmpBeHBOKzYvUEtTcWJRYUU4VHJR?=
 =?utf-8?B?c0hIM3o5K0MrL1NQOHA2ZmhlVk5oSmFwMVZmME5LZ2tueGh5Y1RqK1VqSUsx?=
 =?utf-8?B?ZWVPMUVKc21sMStMYStRSFU4MGk0TTlwOVRzalVwRE5WV0Z5NmxxZURxcVNC?=
 =?utf-8?B?Z3Yza21vUXlaaDZmNEVGbW5WdktKMTE2WmNiT3pnbmg1Wll0ZGhmVzBKNmQ0?=
 =?utf-8?B?VGw0clhJaEhKc3FrS1p5QTQ3UzkzaWpQVlZwdFhhd0hEQzA5UHRKSHh5UXJy?=
 =?utf-8?B?RURCV1owUUwrdjJhRWtSYnh6K2FnaG5OallCbkdNNnhZU3Z3QkkwTXpzN1Mz?=
 =?utf-8?B?R1JGV2REMERTWDhPbVRtcU40UWJ2KzBXcVVHbmFJR1RZR0FoaXdJZ3p1WXIz?=
 =?utf-8?B?enQzNTRyUCt4UEUrb0s2VHBQVlVTR1QrU1Vta3Z1b01vQ3FKNFgzSDMrUVBv?=
 =?utf-8?B?ODdkU2trbitzUmZjbUQ4Qk1ZQVhuM1Rsa2ZHSlFJQ0ZMS1N1Sm5OdXpjSDhQ?=
 =?utf-8?B?Z2huWkpVa1lJTzBhVllwc21DdHA4ZExBc2VBcks1K2YyQVp2dCt3di9ZdG9j?=
 =?utf-8?B?T1d1cHRMY3l1Wml4bmttcnhCLzZWRlEwdzk1ZmZkNVNKRHp5QXY2ZzlTUERi?=
 =?utf-8?B?OS9kWURiZEQvcFNxMVBDNmFYdjZnaFJJOGxEWXZkOEJwMXNpTGxLWWFJQ292?=
 =?utf-8?B?bDJ2ZFUrTUFsQ3ljM04rS0lUQUgvRkVYSFRnVXNnTGdNUis1Vi9yaVRuaDE1?=
 =?utf-8?B?VTFLWlNZb1NoZXFJWGFZdnN4S1lxWDVoZ2orT1kxWCtDRWdGSjZVUFkxL1VU?=
 =?utf-8?B?ZlVZanBXcGg5VTEzb0hTMHlTUmZucW41WVFlbTBhVVZjdEJFcHJNSGc2azkr?=
 =?utf-8?B?Z2N1WkZkMFBFdHNwL2RxRk5SUEVLOGN6bURhZC96a2lzSnRjZCtQUE1YUnI5?=
 =?utf-8?B?RXlQL0pTNXRIdFpvc1UzZnlCU2MvVVVyY2x3NXphb3czNHBHVEtHVWxCSEk2?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cced3f12-7b74-4366-ff90-08dce860ff96
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:50:48.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVijWJXDmOhUx+LTCHUFnBJx7OaaNoVI2Y52MGLkOChg5DuLxKLdoxS7KPT6RbBc7svQNez+X6fDosSyBwfuIg4eOGj+Fh5+JyvmkfMPktg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6879
X-OriginatorOrg: intel.com

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 9 Oct 2024 14:47:58 +0200

>> From: Lorenzo Bianconi <lorenzo@kernel.org>
>> Date: Wed, 9 Oct 2024 12:46:00 +0200
>>
>>>> Hi Lorenzo,
>>>>
>>>> On Mon, Sep 16, 2024 at 12:13:42PM GMT, Lorenzo Bianconi wrote:
>>>>> Add GRO support to cpumap codebase moving the cpu_map_entry kthread to a
>>>>> NAPI-kthread pinned on the selected cpu.
>>>>>
>>>>> Changes in rfc v2:
>>>>> - get rid of dummy netdev dependency
>>>>>
>>>>> Lorenzo Bianconi (3):
>>>>>   net: Add napi_init_for_gro routine
>>>>>   net: add napi_threaded_poll to netdevice.h
>>>>>   bpf: cpumap: Add gro support
>>>>>
>>>>>  include/linux/netdevice.h |   3 +
>>>>>  kernel/bpf/cpumap.c       | 123 ++++++++++++++++----------------------
>>>>>  net/core/dev.c            |  27 ++++++---
>>>>>  3 files changed, 73 insertions(+), 80 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.46.0
>>>>>
>>>>
>>>> Sorry about the long delay - finally caught up to everything after
>>>> conferences.
>>>>
>>>> I re-ran my synthetic tests (including baseline). v2 is somehow showing
>>>> 2x bigger gains than v1 (~30% vs ~14%) for tcp_stream. Again, the only
>>>> variable I changed is kernel version - steering prog is active for both.
>>>>
>>>>
>>>> Baseline (again)							
>>>>
>>>> ./tcp_rr -c -H $TASK_IP -p 50,90,99 -T4 -F8 -l30			        ./tcp_stream -c -H $TASK_IP -T8 -F16 -l30
>>>> 							
>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>>> Run 1	2560252	        0.00009087	0.00010495	0.00011647		Run 1	15479.31
>>>> Run 2	2665517	        0.00008575	0.00010239	0.00013311		Run 2	15162.48
>>>> Run 3	2755939	        0.00008191	0.00010367	0.00012287		Run 3	14709.04
>>>> Run 4	2595680	        0.00008575	0.00011263	0.00012671		Run 4	15373.06
>>>> Run 5	2841865	        0.00007999	0.00009471	0.00012799		Run 5	15234.91
>>>> Average	2683850.6	0.000084854	0.00010367	0.00012543		Average	15191.76
>>>> 							
>>>> cpumap NAPI patches v2							
>>>> 							
>>>> 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Throughput (Mbit/s)
>>>> Run 1	2577838	        0.00008575	0.00012031	0.00013695		Run 1	19914.56
>>>> Run 2	2729237	        0.00007551	0.00013311	0.00017663		Run 2	20140.92
>>>> Run 3	2689442	        0.00008319	0.00010495	0.00013311		Run 3	19887.48
>>>> Run 4	2862366	        0.00008127	0.00009471	0.00010623		Run 4	19374.49
>>>> Run 5	2700538	        0.00008319	0.00010367	0.00012799		Run 5	19784.49
>>>> Average	2711884.2	0.000081782	0.00011135	0.000136182		Average	19820.388
>>>> Delta	1.04%	        -3.62%	        7.41%	        8.57%			        30.47%
>>>>
>>>> Thanks,
>>>> Daniel
>>>
>>> Hi Daniel,
>>>
>>> cool, thx for testing it.
>>>
>>> @Olek: how do we want to proceed on it? Are you still working on it or do you want me
>>> to send a regular patch for it?
>>
>> Hi,
>>
>> I had a small vacation, sorry. I'm starting working on it again today.
> 
> ack, no worries. Are you going to rebase the other patches on top of it
> or are you going to try a different approach?

I'll try the approach without NAPI as Kuba asks and let Daniel test it,
then we'll see.

BTW I'm curious how he got this boost on v2, from what I see you didn't
change the implementation that much?

Thanks,
Olek

