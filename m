Return-Path: <bpf+bounces-75349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45817C8173F
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03DD04E515D
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6513314B75;
	Mon, 24 Nov 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VYmK+Atb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CEE2D59F7
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999894; cv=fail; b=VlL84cJ+T2nUlyp30hb5Cmgp+beTaabaM40trcDwcIJ0WeXtMrCfVQj7zWR3Fp8kT49M7XE8dZpKs4nVoUlUs3D4b5LOxRPUyvkG4mxT67paMiSQrDPYUYeFyMgPHd+t+mrKEAqUniowwOzKM6j0v2dwC5SsdKGiVBGaO2L1FS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999894; c=relaxed/simple;
	bh=Pr3AUUfavi1dyQVIAm5ozbpxyGSoyoW2Iq4eJMJdik4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Id5WCuhiOQkxjg0TlFxjXRERhuaI37Yf0ekf1bCZPdCQbiWP9jOgocObFrAWFMqNI62AqI/AT3gRCMs0nQ7CSHN/3ZSk7RXaBLzRRJna7ofU9sa2ZVZN/IVs39Q/6O/09Cqc4AxgtdQflkYm8JJPXgAPhHZj+yIY+b/VQfvTknY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VYmK+Atb; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5AOEnQmZ043725;
	Mon, 24 Nov 2025 07:56:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=TdKMaZm52OT16FEwI8iVB9Ry22kTWK2NqOpU4Lceqk8=; b=VYmK+AtbwjnJ
	WxnE/0lsNMyk7svXH0EcpTdGzZtAUawv9cXinmcEjgR01nLgtUHNtoKV/NODkrGP
	KaNKZ/3Pf0OQiWm8mGwBOWOHKgMre0ZcMuV3EBEJWaxaO4aw07QZxZ++7EOn6IIg
	Cio+s4XCussaqht8H3IS/Wl9pn0IYy4idGOvwoDl4QaMdVaHG9NjXy1WPUdawvJS
	QEu7uLajjyhCx+0PfTJVBAnBZlmCWmPM8W8vt/lk3tdBjVsL1fFqkzbY4+kQYqNG
	p/Yo3JNZnqztykYNTqnSllywxHpWt2f5Qc8zCqiG5j+SOJRYQzaqr6Imf65S5EgN
	1+epYg2n+Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	by m0001303.ppops.net (PPS) with ESMTPS id 4amsfd0gpj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 07:56:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0AOJqgqtKTzh781cIDY8Unq4F50Ms/Cwgd9AS4pPvUxSli8lMxfQ3ziblJwr5+6JDqvZ4WRbU4PZ/t++jYehIxRZYknb56U8sbf7tjAt4fpYl/pYeCSlxpKw640GHXHiWQKUNrs796jdwqkGVH0oq4weLAf1PUZZ77+Z/zeX8ByjqQacYMRWQ6yq6c2tDNpPLXMl8x2U01t159tNdJCznr+Lb4OvGyi0sv0OTEFePO8K6b/E41WqQZk1s/oQ6VEBxcXugYGmjMQ7bYEK3wFENcvvaoXbJ4zZ9p17fXAzkxG62TcGDZ403NG9OXI3gHvS+FiuWn9wNST5g65FGgg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdKMaZm52OT16FEwI8iVB9Ry22kTWK2NqOpU4Lceqk8=;
 b=JUyBGnbU8rxPO4RS0Fbt9xmHiDDOGyEYv90gYTmcOR0UA8xrRae34FB4PufMFH0oqVbXv2zXsLO+5G8iiNVq8PMH7pdmkXyhl7uBW6Rmoy2W0Gg9WKWhzNXZ6iuCoD7MVpEan/B6KfE4xzCnIDHy6vD8IUHWWeLuWa2xAGXfa03viix/RZWTlLIWATkyf8KgVAFSorizKsTCE3a2OopSDywfL9CFw5Z4vDJ1eqiuwifQeWtlA8jDdKnuBCT2EyPptFzWMO9hn31hEiegn2LFhmbJhZ6yKuFs9O5aJCRPTmk7B2cpS2FavDc+R7iYSVn6BZycrw8Do4jhCf4to8+Dqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by DS2PR15MB6857.namprd15.prod.outlook.com (2603:10b6:8:32d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Mon, 24 Nov
 2025 15:56:36 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9343.011; Mon, 24 Nov 2025
 15:56:36 +0000
Message-ID: <0b55b083-987c-44d2-a3a0-a4dfa9a078e9@meta.com>
Date: Mon, 24 Nov 2025 10:56:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: cleanup aux->used_maps after jit
To: bot+bpf-ci@kernel.org, a.s.protopopov@gmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
        ihor.solodrai@linux.dev
References: <20251124151515.2543403-1-a.s.protopopov@gmail.com>
 <02181509c0573bc63b5c111cb1dadb0e9d1577ff5465dcaaa902181a0fdedc3c@mail.kernel.org>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <02181509c0573bc63b5c111cb1dadb0e9d1577ff5465dcaaa902181a0fdedc3c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:408:ee::14) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|DS2PR15MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ce0feb-6b94-47bb-b1a2-08de2b720c45
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHh0cU9sYTZlZUthb1BLdVloZ3FEKzJqV1dMbHd3SFBDTDJmSHRyV29YVnZk?=
 =?utf-8?B?SXp5ZU51Z25uSDhVTWdIK3hVOXppN1pCNXMydXJ2YlBORXZPVHZTZnhldHRj?=
 =?utf-8?B?Nm9VSkhGQlFyWTQ0WHBPbmg1bGpZcWd4SG9FUWlnamI5SmNDRC82N3VCQm9t?=
 =?utf-8?B?OHdqQi9jdDRUWjFaWFhEcDM2dU5BMW9jWldTMEZrcjMzSGZ4YUFrVTI4Ryt2?=
 =?utf-8?B?QnRPU2lPQXF3NHQ2dFA3NFpOOHF3dFF6T2ZITVRNSUdJU3R5OHZyWGg1Q1Br?=
 =?utf-8?B?SXBjYm5NM1JkNkpCVXdjY1VBWDA1Z3JVV1RXdTRjek1zb1dQRjZITUdTZk05?=
 =?utf-8?B?dTdTUk1jZ3pBRVh1Nkc2aEROUW9kTWpyWERIS0NWTW5UL0tuMXFJbHkwVWtG?=
 =?utf-8?B?NWhUd0xZbUpiaTBjczdJeUdDUFdVT2RzMHIrdmRia2JaT3hGZDZWZHFsQnRZ?=
 =?utf-8?B?cjh3SXZoYmpDWmM4b0JLVFZVdHRVQ2FCRHNXcHYrWk9pTnU1SDNXbEdsMEsz?=
 =?utf-8?B?OUJFOVRhd004MDNCWFYyZ2pmTEJ3b3orOThxSDloYlNHRzJwTnpNcCtKN2Fs?=
 =?utf-8?B?WGZsZnVXN0dmaWwwWUJJakFkZWhmSFhOaXMxenFCOE9reTF1ZStkdzFmY1ZS?=
 =?utf-8?B?ejNIejA1dnhPUHVoME5uVUd2aU9jdVJRTTdWRFFRWUV1VldOblh1Z3RUV3Y5?=
 =?utf-8?B?Zmc4YzZGYTh6Qmg1ckVLMjdMTTNjbGFGZGpqQW9WUCtTakFZcUlPc2MvZjZ1?=
 =?utf-8?B?UTZMSC9ncUJacmx1UWkzR2NUbG1EU1ZvN203YU1oK1YrdHNQSVlJQWV4QXcv?=
 =?utf-8?B?QVZCZHdadG1XM3dkcFZqTGNaOHlWZThzMGRSWjFvaXhoQXdTRWRzWnFyQzRi?=
 =?utf-8?B?WUQ4WnFYWFFQT0Q3QmhzNm53MGN1SG5qY3V0NytoTTdLdmwrdEtvWDQ5WmIr?=
 =?utf-8?B?MUhMMlJmNGNUcllORklwMVRieFNIYVVneHhnT25OemRYbGk1Mzc2K2ZjNnJl?=
 =?utf-8?B?dEc1dmJyK1pid0V3NzErMWJRSC9EYVYxTkI2SGtTaVFEK1J0bTFkME5qcHhF?=
 =?utf-8?B?c0pCMThzN0Y5R3luTGFySVRiTURlYlM2SG9ZTHRPYkxoRm5Xdnp0V3lCd1Qx?=
 =?utf-8?B?c2hQWTNBUXVpaS85VVZKUDJqQlJlY0xMVy90Y2pRcEwxbXJVVXd3clJ1N3lj?=
 =?utf-8?B?U1dvK0ZsazVUYlltcG1ySVlvTzB4eFNZNkxYZlV6RUNEMzBpL2pTeXYyeVhX?=
 =?utf-8?B?UDY3NDlwRTFEM0VCL1NkNkIxNTJjV2JMREdpak80RVpSUXNQU28wdlU3UlBW?=
 =?utf-8?B?Z0I1dFozZjdRb0dVTVdQTFo0d3YrdlM4dDA2WGpDVzUxcEdSVUxVZmlXaEN1?=
 =?utf-8?B?RVV5aVU0UThRNU4weUdOWnBQL09HN3QrNGhMckNaVFJTc0lDL1dGQnB3QkZt?=
 =?utf-8?B?dDhBOFZhN0VTTHVocU9vVFFSZUcvRFhRcjBxQThNenB5a2RhRnV4dGJxSFVm?=
 =?utf-8?B?dVFSL1IreXQ0SDNBMi9zeXltd2pwVXRhb20rNFQxSGc2bEx1c0R3dWJkOEFQ?=
 =?utf-8?B?bzhJQ2hSRjBIemJpNUdSUnBlc3ZGYkhpNDFuS2N0MlQ0TzNTR09aR3hpS2ZB?=
 =?utf-8?B?L0FpTm5aTWVDMnBhMTBIMVpPUEUxSDZIWnc2eEFLR1FHMTBzNk9ieXN6UE50?=
 =?utf-8?B?SXZaUjJSazl4bFNra0wrQ2FGQThPYmxJTmdDN2thcDY2QnRtZzFibk54a1pz?=
 =?utf-8?B?MXlmdllVVEdrUE0yd2prS3A4TzRJc0k1Qk5NUzJsUG1Wdll0UjFYem5SMTZn?=
 =?utf-8?B?UUpaMGZ6RHErcWV6b2J1RytJWEF5bEt1NllQdkliellnZmZwZFl4S1NFM3dG?=
 =?utf-8?B?YU1xQnZ3SUF6eDNSd0xKb1NRUnYwV3JLdFQrL0ZjY2cyN1BXVFZiQ0tSTXpu?=
 =?utf-8?Q?a9+Aw+BQotLoUtTG0KiLqQa9MEcSiUro?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGNESnFEcG5BVmorSDJtdmdFVDR0Nm5SSnlhUEh3Z29CMUx6K2tsTS9FU0dC?=
 =?utf-8?B?R3JUYUxKcEdKSU40bmlrUWlUNFNQUFNPUnY4MGR1Tml4eDZnaFU2Z2Mzb0ly?=
 =?utf-8?B?bUNwY2tmQldHcm54dnQ5KzM2Z2gzTFlYbEJHQnU1V3lCUW80bTc3OURDcTNV?=
 =?utf-8?B?YjV3WUFzbjZic0NWQWR2aVZ5UGs3TWdSMWNpS3lGN1dmNW1OVHZnT2J1RFB2?=
 =?utf-8?B?TnlVRnNxREtPUHEvOXUxb28zYUxLcFZ6VmhWckt0bEVibHR1cXpWd2hXcFZq?=
 =?utf-8?B?dHFpWWpGR1paNkpuKzdKWE1pLy9BUmMrUUEyOEcweXdwWHBNV3VOdkJyMzh1?=
 =?utf-8?B?UnpTUGtQWVUwOVp3OUhNSWxnVzhuWm9NMUk3Zy9qZXM3M1lkUmZ0d3NySEQ4?=
 =?utf-8?B?dEIxRVY4OWxsaGh0M3RBR2FBM0R0VkUrajRiT0RtbWF2RC9mNHhvQk9LYzhq?=
 =?utf-8?B?NEI5N0EvTTVxSGpYRTJWRlQrL2JERGJvQ3kzTWlzd2hDUXJlcllHaTZOUG9J?=
 =?utf-8?B?MEkxakVaVUdvRWN6ZGhnckt1ZFhXcFhqbHo5OUNhNzhkR1ZSTmlyczd6VG9V?=
 =?utf-8?B?cjgrbEgrKzBFVHNOclRuL3hNVHlweXIrbmtzQThva0w5bmo0T3RCa21zckNj?=
 =?utf-8?B?cm5Fc05JYmZRUDNuV3BBNVdyZUlwSis0T1ZZTDRLV0RkNUg4Y2RQVUNUSCt4?=
 =?utf-8?B?YW12N3RsZlN0VWs0UjZUbVQwUHdQVUV2dWhWRmxpdnpNVUJRck5OUVM5YmJq?=
 =?utf-8?B?SG9MVmJvR0Z4Mk9DcWdGV3MvRjJra1NmWk44ZkFwLzNQVHlZbTZzRVRkcGs2?=
 =?utf-8?B?M0xwdHVHMWllU0dQRjZLNjlFdmw2TXZaUDdjSEVlN2dscHhzZU9SK2t1VnRk?=
 =?utf-8?B?S0ZpU1FxaSsrSXJ4L09kdDN2NGMxY0JqVHZtQ01oL3huKzE2NnJ3OWJSdVBV?=
 =?utf-8?B?bDJsaU9RZWxneWlJNUlyK04rNzVveHdTVUtFb3gvZlk0cldubW03V3Y0dGU0?=
 =?utf-8?B?cTQ2TXNaVUpoK1FSRkg2L3p5SEdPVkg5Q24zRzhSL2RCYTlvekdVSFY5ZHE0?=
 =?utf-8?B?TmlzMEltdEhBVm8rR0N4ZEc3TllMNjBjbXo0Q3M3TzdHZzYvdUc2N1ZoOXk4?=
 =?utf-8?B?eUNUdGNNRmtoUXdGeG9NVWx4eWQ3M3Z2V1FGQWo4ekQxUk5DOTQxLzVmanlY?=
 =?utf-8?B?SGJTTUE0R3Fndk1PdE9zWGQ3TForQzl1QVpDSStsVUJoZ3pJRDlrNTNRTTVJ?=
 =?utf-8?B?dGRRblIxcUZ2ckVWcmk1T2IzYjJ2aGRUUFVHZVdWM1lYZm1JNXZ4QTVoS2ZP?=
 =?utf-8?B?c0haQlNrYVVZbXhFeS84N3paM3lDVDVnRm5kc2l2V2dQMnFsd01leEdYQjBi?=
 =?utf-8?B?RE1ia3NPWE5BaDBxd3ZoVXZOZzJ5TGRDcVVzcTRXc3JHK0E0WnByeFVnd1Fi?=
 =?utf-8?B?cVF6emdSRTJPUWRUK1hMb3NQa3hMcU04eFJSMmRuNkIwWnBRU0k1V0pLbHpP?=
 =?utf-8?B?WjdPamhVeHNuamMzYTRGY3ZPOU5WcGxVMUJRTjNKL1VNbzNFL0pWTTRNZG9H?=
 =?utf-8?B?VUhGK1ZWd3RsMnJmbWJONDlYdWJPcGtHZFN2TnhCSVJHYVlCUkZEQzUySFAz?=
 =?utf-8?B?Q3hrTXJ4TzMvU1luWXNXTmRXTFZJcUpFVVZrS25qcFpCZXRadGk3SFlpZTA0?=
 =?utf-8?B?N2k1SnY1Ym41T3FJV2Q3eTN4V3YrUHppMGRRNHdMSU5WQUNLUzZ4Ty92SmJv?=
 =?utf-8?B?OWVhdnJqOEppWHNHQ0ZSWkhXYjhVaXRZME95eVlnQ2VFT3dyZEFuYUJONWps?=
 =?utf-8?B?UWdka2xxMHRwSVloVXJENk9LT1kwNDYra0V1NmNXQjF3NlhWWjVaNzBhdDdX?=
 =?utf-8?B?cnVIRDdDQmNZT0kvTm9GdWVyYnpkVEpyVFVrUnFPSkh2UXJmUk9DK3ZwQ3FV?=
 =?utf-8?B?QldVQ3Z4ekhlN29HZDdpNXBNeUs3SHpPeXRoQW4vdzdPdFIxSUowQ0JudExH?=
 =?utf-8?B?ajgzK08rcGlqOW1QQXNPaEprZVNKazJKRmprZFdoQTYxREMwK01zWFc5Qm9t?=
 =?utf-8?B?dGMrbElOOEdvTUFzMHpjRWhmdkNsakcrT1hOV2RKSnQva2RMVHI2WDIrN0Yx?=
 =?utf-8?Q?qFlPVx12wGWqVJtp1JLuE91am?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ce0feb-6b94-47bb-b1a2-08de2b720c45
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 15:56:36.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmnw6kRZowFh9Sa3QYee+NSpFEyp624gJKfpbDj8GwU4avxY0YGVQTMX/FCIiqjl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR15MB6857
X-Proofpoint-ORIG-GUID: smnaAOWgWh8JLRdlWMKWhF1o_pQikkzW
X-Authority-Analysis: v=2.4 cv=a7s9NESF c=1 sm=1 tr=0 ts=69248036 cx=c_pps
 a=021mb8W6rIxzgUEI7A/+3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zOaW0LGjGl0qoib7EIAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEzOSBTYWx0ZWRfX2g57HtoRNvbs
 6HIYlSEuSi1j8sVnR0PVBLfAnk703MR7haed76tGaRh+SuWZNHjOw2g2MXYgZI9duar3ByW1SlX
 xBQTrktewVXkJ1Aual7Q9Qb6zrJDPmwg9ekfV3ntfaFwfRWfu8FwIl0jVLc+9hfEydw26DE4E6Z
 /AJAwPmadn3P5O3IvKSDbwfe9X+Lp8+GESmYqqXjqgP04yw7tcIyCxNyxc8/+I8Zlron8n2yUBs
 jXYN8oGOlWnjfrTV3fwlAwX42SRdbiy+Okb9E9gYaktMJD6lqSh2OoxmdQx92MEKWwUd9HoRTF3
 54MojZUgEtkMkmuWpcNdQ3WbPxswl2s99wr78Dx/HyntXZDBZlkadz3iw55K6DlkS7bfg3Uq1UB
 L24Jg2Nj2RiUv2h2V8kufzek5geYVw==
X-Proofpoint-GUID: smnaAOWgWh8JLRdlWMKWhF1o_pQikkzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01

On 11/24/25 10:30 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2e170be64..766695491 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -22266,6 +22266,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>  		cond_resched();
>>  	}
>>
>> +	/*
>> +	 * Cleanup func[i]->aux fields which aren't required
>> +	 * or can become invalid in future
>> +	 */
>> +	for (i = 0; i < env->subprog_cnt; i++) {
>> +		func[i]->aux->used_maps = NULL;
>> +		func[i]->aux->used_map_cnt = 0;
>> +	}
>> +
> 
> The patch correctly fixes the use-after-free issue. However, this isn't a
> bug, but should this have a Cc: stable@vger.kernel.org tag? The bug being
> fixed affects released kernels where bpf_prog_free_deferred() will call
> bpf_free_used_maps() on the dangling func[i]->aux->used_maps pointer,
> potentially causing kfree() to be called on already-freed or invalid memory.

I took a pull request for the review prompts this morning that adds
Fixes: suggestions and verification.  If Alexei or others here would
rather have this disabled for the BPF reviews, I'll make them default to
off.

-chris


