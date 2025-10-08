Return-Path: <bpf+bounces-70627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1079BC6DEF
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 01:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6BCA4E05D3
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 23:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42582C2357;
	Wed,  8 Oct 2025 23:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9eaDXef"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC03E2C21D9;
	Wed,  8 Oct 2025 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966414; cv=fail; b=ZIkE0GhzjUWWUcNIPnRr3gkVNYVoxDvcy5uLCJvWDicaJrz5aR9/wVvst1sRHSAULB0OrelUHk18uD9NYZW4tAwFYnDqmLSdvKhXFQBQkDj/dR4MWBq6JUDiMWh65Y4J5rbZ0Z6G1KQf/bW9wYrrH+1ajBQVktR51dsQ9SMISNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966414; c=relaxed/simple;
	bh=+Z+jl3sVvWG/OewqdtuXYAKFNenCjH7QOOdUPjb7gRE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aazF06sV0o8dS7FnKNoN+TK+5kZ6nDbBnGWhn1lMQTLa4Ae8WJcC8J8jtO46PScCDncgY0jeAmoglY4lrmDGlbhkQKdB1hegsCD6x2GIBuRNTZ37b613UK4JbCd3sr2ZJK+5Mlb0xLvVSWuyrHO4IkmC2KROJ5i7mmy/idb1nq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9eaDXef; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759966413; x=1791502413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=+Z+jl3sVvWG/OewqdtuXYAKFNenCjH7QOOdUPjb7gRE=;
  b=R9eaDXef5YNKd6EnXoIjUj2dPORtU+Vt5ETwK9XosLS/EadSOdCwbG8R
   yWc+3y9/3KkVoE0VtHrkvIbIvEGA2MVQ3JqctbZY+xf60JNShSpeAFphk
   k3JnPTalpmzF/iUkv1li8ukZWauT3SxBWYZCncK4wBcCe//MTR3wOhcYC
   yZ3DVopASDTymCNP0cekMtpSHabhplm/8L2OwaZ1HvQ69/tLEiuR+OkP5
   KMzsx43hWxcMROn1QOiBusL9JLJQbuOb6Z1FZdmv7BqMmlK8Dq1jrV8Ul
   g7ApuhPOASLq/vBRYZzh2llOez9RNmIRH9m1URdphej2/8DzvSSuJKGgi
   w==;
X-CSE-ConnectionGUID: 77nC4NMVS1Oe2sLBGUl/Kg==
X-CSE-MsgGUID: a3euCIktTp2RRimDLBkLKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="49733561"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="49733561"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:33:32 -0700
X-CSE-ConnectionGUID: +5N8TNtkSIab2K6ia7mhAA==
X-CSE-MsgGUID: B+90/PXjRtG5V56nUTNYbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="211212921"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:33:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:33:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 16:33:31 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:33:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdF2HLiNYMjfT9yIFaPGy63FxTBYOffofIorsHBYL9arXAREme8XebRPH6xvN9/r+iYA5WZxqJu2oYUZXcUGDZOch+utiuNxwNSBthaNAEALt3jm9D+ZlAAa3ADqiyWUj0LKdqjh4q+ww7LD7ei1EXU21rXn5YH0hGnkXmsMbChUEUjnFybu5MPVwR6He6YtXNrrklX6qrOFri0Zc3737ToFByzKOyaGQq0yTbkKp+vNFY5AsPDdplelaRhLzGA3nZey8VZiP+KHrR1ySOzfdfoi7aSgE8Gz9QJxMxvUPROYkqTq6GGJfEG/47jLQ1Ld6ZfCpkpJ2c97d1pdy3pdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Z+jl3sVvWG/OewqdtuXYAKFNenCjH7QOOdUPjb7gRE=;
 b=gkDTkFU7S+8CznhpjeQaYakkPtedcV0/UGKloWhl5APFLvw9FmkooUgUNlIp4BtmD1ybN8eLzxFAV2yIuIdZ8EzMkPJFjbEw01dfAkBuF5e5WDFIcBJOlk22LMsuTkFvejLJsuEdRv2lvwKRLmQzPeXLt/FuQY2VVovNKI/ckvPqKCuO8J28TxAeUpBIE6LC4v7g0z76f57CzKTlCTWhhnue7rjrIogpnMTbVX6wBSsbILOOGTK64qYF7JbnJj5GooKWztyKE9HxC/SgvkWXzmzWtkrq1dwjNlh4BC4Brl0sZAZL5ft5Me6V4wzPf1+bkal2PUbUwbxzzjCvgjFlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA3PR11MB9226.namprd11.prod.outlook.com (2603:10b6:208:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 8 Oct
 2025 23:33:25 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 23:33:25 +0000
Message-ID: <a237d474-715a-4b84-8bbb-0691e4568d13@intel.com>
Date: Wed, 8 Oct 2025 16:33:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 6/9] eth: fbnic: fix reporting of alloc_failed
 qstats
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <bpf@vger.kernel.org>,
	<alexanderduyck@fb.com>, <mohsin.bashr@gmail.com>,
	<vadim.fedorenko@linux.dev>, <jdamato@fastly.com>,
	<aleksander.lobakin@intel.com>
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-7-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251007232653.2099376-7-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------1fOP9uQsVSdHJBF0OIqL1OwO"
X-ClientProxiedBy: MW4PR04CA0255.namprd04.prod.outlook.com
 (2603:10b6:303:88::20) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA3PR11MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acb86f0-4e79-4358-755b-08de06c313a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEREUFQrVDBYTmlNbVNCUXBZYllYbTNpNTl4RW9uMzN0Z3pOcVFEaUdnZjNz?=
 =?utf-8?B?anhBWVBkUmxVb2g0V1ZaeC9UUFdoTSt4clJ4UG9kOHE1d2FQOWpWMkxsZHA1?=
 =?utf-8?B?UThEZEQvcnpSdzB0VWJTY0VCb1FMZ3M4MHhEVnJqRmdiazhMcTc3elNnaFU1?=
 =?utf-8?B?RXZKSEl3UkdLN2U0R1JSblF5REVCRHY0cjFTZDY5OEo0UWZlN3BraUl3dFpL?=
 =?utf-8?B?VHlXSzBMRUhSOW5CcnhXL3lpRlFYZ3BqZFJLclBHTzhwQ3paRkhwQ0lyY1Zs?=
 =?utf-8?B?aC9LQjNLZGttNXZjNGpPS0Fkc0JGb3dCS2FvYUNMeSsvVEhmYW9PT1FOV3g1?=
 =?utf-8?B?Q0xnS2tJeGN4YXJXZEZhT0NOZ3B2UFlYLy9HNGtDM0NhenRUV2hwM2NDZDFq?=
 =?utf-8?B?Wi9DYXYyNVZuVGRuZTlybGtUcEJBeHNhdlZGK2YvZXB2RGJ4aHJoNkxQVksv?=
 =?utf-8?B?YXlwSGVpcXR0T3V0VWF6TW01elNzdzNLeVRQVSt5SWtxUVgyMzFUQlJraCt2?=
 =?utf-8?B?Njk0ajdOQzdscnMxUkQrcCt3MnRTVkl5ZFZXR0Fremx4WXc3Y0V1QmhXcGRw?=
 =?utf-8?B?aU1FNE1uYWY1TytOWnIxaVl6NzV6V0FIbExPcGV3UnphVjNyeTJRNDArZlQ4?=
 =?utf-8?B?WWVtVDZHMHhNcDZxZ2NDczYxeWhPdkdvc3RUWEJpWjFlUXQ4dlVYTWpHSDdx?=
 =?utf-8?B?WTlRQlc1SFUxUWVOWUlJRHlEcjdHcHNMek9HKzUybDlnWEVtaGtpNXkzZmx6?=
 =?utf-8?B?WFk2NC9IZ3IyUmp2aGc5TzNCSDViTTdqaEtlaVNvMGVWa2J0U0NhenNsa1gy?=
 =?utf-8?B?bzlhZW5DRVlEMW9vUHhmQSsvVWFhdzhDY3B6QUJUVS9LckxjaVdoTzNIWmxv?=
 =?utf-8?B?djRweHZtWHhUdVhzOEtjdVJ3TU9LQU9ISE1YVlc4cUpjQzIwU0syQkV1S3Jz?=
 =?utf-8?B?Y05NdUM3cDI3QVhYKy9VOVpJa2Rma25lUStmYm9YWU5PSUhiN3BTYzM0a0Y4?=
 =?utf-8?B?SHBRWHhEa2xqWHowUlJxVi9DVXk2SnFISEZvbm5OU1ZMUWc1MGtYNmtDYnhj?=
 =?utf-8?B?SERuWXloc214Q05EamsvRVJjcDZBbnRpM3ROYzdvSUJOS0hPU0ZTZm1XT0Ny?=
 =?utf-8?B?ekZpcFFnZmtHbko0cVllNHJxV0VKUEZodGhiVXpTRHg3ZWdDOFlrNDdvRHJE?=
 =?utf-8?B?N0d6WHhnT0pvRW1xNmNSMFJCM1ZnMjFtN000azNJRmkxUnd6bXlrUzNwY3Nl?=
 =?utf-8?B?OFJySnZVT2N6MmJLVURSOTRBRHhwMEliWkQ5NVJGbGZmMk4zQVJDbmI4ZmxB?=
 =?utf-8?B?NmQ0cnNxbWVMZm5XRDJ3SGpXbVFhaGdXYnlKNTdiUzRodkpaRkpMWVcwL3dR?=
 =?utf-8?B?KzFGdW81TmlPZXp0dStOUVlYLzJUSGZSbTA2alJ4QWNSKzFvRFRwZmlFemxy?=
 =?utf-8?B?WkdJYm84dmNlQzY5Ri9qYjl3UnAvdGtyYTNVU0VRcmFNelB0eUVaTFpjN0tY?=
 =?utf-8?B?Tk01cWMyNGxUakU2Y1ozOG1sZ2pQSlJoQWVDMWtqQUNaVVNUTlEzYkVDVWsv?=
 =?utf-8?B?NndHRHFPUDM2RldDRFNhRFVMOEx5YzNhOUk3R2FQSXIyTHVsNlIyN3B6eGcx?=
 =?utf-8?B?cm14ZTNqSjNpUkkzUWFuVVlzbU9kRmV6UVJCWlpudWp6VWtPMUVFUzN4bUJo?=
 =?utf-8?B?STc4cEZSY0U5RmRFdmt3SnFWNGI4VjhxcWJCbGZhK0pkcktnY0FSczl3NlNZ?=
 =?utf-8?B?WTM4UlNvWlB0QTBOMjZPSXpXczk3NkY1OTNRd1l5V0FjS0tOOFViK255cGJU?=
 =?utf-8?B?YjFLTHlSenY5aVFoak0vVnpOUmhYYnQwMzI0Y3BGaW02WWp1V1UvQ0ZrbzVx?=
 =?utf-8?B?SEVwbDdiS2NwWW1ab201R3BYUGRrK0FrQ3pFREErM3B5TW1yYUFDcHF5VStq?=
 =?utf-8?Q?KAI3nWF4A6lbL9V0z0dQJnCnE0GBG4Rq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjUzc1JJbjJuZXFBdGZwWEtZSGtyajJrS3lWZGZjbHplVG5zVHNiU2pWKzhq?=
 =?utf-8?B?UVlxeW1IcGJZNkpyeUc3U2dRQjI1bmxoaXNDa3hHYkU1bkhmS1ppd0tvaUpF?=
 =?utf-8?B?MHNiVHgxcStGb1BEb04rMjhEMjRwYWpJaTBCcndncm0rZlAwL3hYNDg3SG91?=
 =?utf-8?B?aWVGMlRJZHBKTGJGR1JJbXM2ZFlaeU1GTUc0NjI4N3hwcGh2OUJTRE1HVE5G?=
 =?utf-8?B?ckFIRTVlZ3JvYjQ5dVRDczBDc3B6VjJseUtxYTRNbW8xbHdkd3BvMGJYYXgw?=
 =?utf-8?B?UDdPSzlHeVZrb0xpZjkwUjQxbzZEaVV5MTd5THUrTVgxeURIbVJuNUtha3F4?=
 =?utf-8?B?RnlYaVJaVWZ5VkhCcndEb1NlMllHL2VobTJvT3hsZk9KNUZUNnNYWitEZHk1?=
 =?utf-8?B?dkd3MlpzejRudi9MMzcyUlJ4cXo5ci90UHBpODdtQ0Jzd01RT2haZ1Y4cWsz?=
 =?utf-8?B?czNwYnZYcGNGUkN1c0JyZjducWRuaEorOUp3QmVMNHVIY25DL2YzTm9Uc1Ix?=
 =?utf-8?B?U2QyUVMrbXhUU1ZjamM5bVhReGxudG4vTGZiSjZhcjFvVXJTMG15ZmNSazVU?=
 =?utf-8?B?MmRIajdObndVQWl4Z0hYNDQ1YUxJNVRhNmNkZCtXZU93dnd0MStPbUs4d2tD?=
 =?utf-8?B?QUU3NWU5SVNqYmpGcnk4ckhKK1ZxL29EYm5NNVo4N2lIcnJZMkRSbW1yZjIy?=
 =?utf-8?B?aVFsWFM5R290SXA1ZWdJeE5CTHFDNk5PeGVHa21TeFFDemptVUVLWVlhSXpy?=
 =?utf-8?B?eXBaVGZhUm1WbGZxUk54eVZXQ1owQVRqMTNzTW9VbFFWV3lKYktHTllDTEFu?=
 =?utf-8?B?dGhmbzIxNS9FN1dKQUpJOVVRZFB2NE9TRThnQTVrUkpFTEoxeGNkdWRicGU0?=
 =?utf-8?B?VnNHOHVtdHRtSEFXWWk4Y2JDZkpnNHA1ejM4YXlySWhENFdFQ0UwR2xEZG9P?=
 =?utf-8?B?UWZpQkZWRDhVUEJxRFZXdk5QbDRDK3VRQ3VGN2YzTkZPdkcwdFZVd1BXS3dD?=
 =?utf-8?B?elNHNkliYXIzY0JBTGxGdWQ5a2JaTVJTa0FROHVWSnZ5czJDelBrOW0veFlL?=
 =?utf-8?B?TDFxRkJ1UUZzYjFEd29xT1lhaEdpTk1QMXQxR3dqUW54Q1UzRU9rNG45NDVy?=
 =?utf-8?B?U05nQ3BCbWZ4QzNXaWZaNE5aT3c1UlpXeUtaQkZHcFkzNUt3RFlRVFA0b3Qy?=
 =?utf-8?B?MUxLTGVEbDVrS2owcnZHMU02TDVVZkdSZDhmM0pKTGRVN0NqZXhtT0lER1dr?=
 =?utf-8?B?V2swSjFVL2pGMmlYb0FxK2NRQU8rZS9qanVISzZxcEc3VjAraTFwTEE3OHJq?=
 =?utf-8?B?aEJ3cHBuWTRJSlZuRlVGVDFGT25Id3FXR1lmcERZV3QvNncxM1dRMVVUZEhQ?=
 =?utf-8?B?YitTZjZDa2xBK0tpQVJSeTQ4RGVpeUE2bVhVNDNTUGhhNzZuZ0pPSERIVlFq?=
 =?utf-8?B?SmV6Yys5U0hWMHc3TmtxWlhmdk10U0dDTG9Jd21RQVJmWDBWNldYZzNTa0po?=
 =?utf-8?B?YmhjNHpZcTV4YXRrdDdzUnV4d21SU3lxYlFjSENYZkFZUnVyTWZrUCtOZDB6?=
 =?utf-8?B?UzVQMHBxekJIcTg4L3FTVlZybzUvRzl6dXkrSnoxekxxWEllTDJmWWhzdlFh?=
 =?utf-8?B?MnZTUk96ZEg1R2I3bk5tZnMxQVJWNmhLWFZPcFZBd2swT0NlWlpSYlpnWlU0?=
 =?utf-8?B?bWZ6eXE2SVBnZnRVNGNhd09SYlY2Zm8rNGE1bjR0NUFoZlFuSHFnU0NoS1Ex?=
 =?utf-8?B?dFpZeVlieStzTTBHam0yaGpRZC9iaDBWMjN5VjlvZFdTK0E2OVZtMGJkM0FU?=
 =?utf-8?B?S2s4OURENWswaFphbndVdHR5L2JJTDJDODdKWmVTQ01BcDBFekdwTmRUYTlt?=
 =?utf-8?B?TUxaY2JLU09DdkU2eFd5RnNKTVlEUGN0UXF3ay9vSllScm5NRVU3UThicDMv?=
 =?utf-8?B?VThDZ3pTKzRLdkFKRmNZOS9NS3pPdWk3TDB0dXF3TGx2ekNORUp1NXlydVdB?=
 =?utf-8?B?aFplK09KTjhWcWdkU0VwUGlMQldDZTlxUTRyOGdtZkc4ZlNJUEY5NGV2QW1t?=
 =?utf-8?B?aGtMaTIwUFQ3QmgyakQxMHRtaWtDd0UwdXdEWFlROGZpd2dzL254TzFCWkFN?=
 =?utf-8?B?dFFSZjVKbmtic0hlVWRMSUpycE5pMW02eDhNSHA0WDNSVng5M3V5SUx5cWNY?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acb86f0-4e79-4358-755b-08de06c313a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:33:25.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvPVBfD7EJf/vQSfkD9YKq7dkyjBNEB29MOsXkTxJlBBiErVjcKt6+qMxsZ4fPkvsO6GlhzlXqoswranieJy+ZJtUjWHp+6unWP7k4CdC1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9226
X-OriginatorOrg: intel.com

--------------1fOP9uQsVSdHJBF0OIqL1OwO
Content-Type: multipart/mixed; boundary="------------80hcG8vvYedKd4StXv0YWSVB";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 alexanderduyck@fb.com, mohsin.bashr@gmail.com, vadim.fedorenko@linux.dev,
 jdamato@fastly.com, aleksander.lobakin@intel.com
Message-ID: <a237d474-715a-4b84-8bbb-0691e4568d13@intel.com>
Subject: Re: [PATCH net v2 6/9] eth: fbnic: fix reporting of alloc_failed
 qstats
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-7-kuba@kernel.org>
In-Reply-To: <20251007232653.2099376-7-kuba@kernel.org>

--------------80hcG8vvYedKd4StXv0YWSVB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/7/2025 4:26 PM, Jakub Kicinski wrote:
> Rx processing under normal circumstances has 3 rings - 2 buffer
> rings (heads, payloads) and a completion ring. All the rings
> have a struct fbnic_ring. Make sure we expose alloc_failed
> counter from the buffer rings, previously only the alloc_failed
> from the completion ring was reported, even tho all ring types
> may increment this counter (buffer rings in __fbnic_fill_bdq()).
>=20
> This makes the pp_alloc_fail.py test pass, it expects the qstat
> to be incrementing as page pool injections happen.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Fixes: 67dc4eb5fc92 ("eth: fbnic: report software Rx queue stats")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------80hcG8vvYedKd4StXv0YWSVB--

--------------1fOP9uQsVSdHJBF0OIqL1OwO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaOb0wgUDAAAAAAAKCRBqll0+bw8o6KrV
AP9+1iK0QGRY14go7oCLTVP8SPVj1bZtMRqjXls2EpJQvQEA7up29bogD3nTJ+OJ6tX6s6brs76W
qM/c2UslI1PXCgo=
=5ySX
-----END PGP SIGNATURE-----

--------------1fOP9uQsVSdHJBF0OIqL1OwO--

