Return-Path: <bpf+bounces-64835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923CFB1764D
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 20:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A3A567A5E
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA324FBFF;
	Thu, 31 Jul 2025 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hCDxg9Gq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Egxerhsa"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E120CCE3;
	Thu, 31 Jul 2025 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988246; cv=fail; b=tSbGb0I9pmEqv5bb9w1nLgjvecGn4U6bJBeGCUn1UUJLbQrip+gQxQD5KnW34W1gXPpFJh1KkqUOepgMeVh4dvWkzIKRVz9BTVTTxM1Jzqq0bqNXqPl3J+taAHOwcc7H1VTpCyJZRzcdiPNXJ0vW2keG6cU4GYFIUqppinbYUK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988246; c=relaxed/simple;
	bh=ritesdtElyYyyg2wSaj1VnXw7jyODniDedr+SSv7bXU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fnfWu9w3xcDn+d/ZRT88hSoO0uIK+0z4zJr7MhKqAJlFGcWygoAEXm4D6QsKJfb2IkBopFX0O2KG48As8y5oaExJcHnn/CRF+0pz9STfE10b9RWBtnIpxjKVogmn2r3CTOD0S2VaKs4b0aQNpQeOvVVM9GUrxsvoyB67Z3netNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hCDxg9Gq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Egxerhsa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VIXtHs029981;
	Thu, 31 Jul 2025 18:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=F4RPLM4+vqJ5cVM1RbS69jEXQkwltpwpiUyRI8VORf0=; b=
	hCDxg9GqCPZPIXvFQtqPfC+vALONVqTGAuG+C9S3sfqZBFnOIYBUCEg+zIa3iPmG
	LO5PYJWukVOoxxO2CLHLw3aSrW3hj+fyq1QUqyrDRibqAfKsP5jG7iQi0dnSVivX
	HiXxbiIweXJ6dEeteYoPwZJZ4700tYQ/v4T4ULlVmibIl+oPvmR7RVxyQux3xGrY
	xg9IxArXwuGHppUonp6+biyYaDWVhqJEAeGyaO0u5ZQIbqm5Rbxet0XqSLdvz7fG
	5a4pnUgPedmImNhHt4Jl/KRq0/bqUQPmQLwXmFMu7EmfUuuuoMRBw9mEZ4olSnw+
	UObyq7lLQGtfCRsPkVzuJg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4ecwrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 18:57:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VISXrC020417;
	Thu, 31 Jul 2025 18:57:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfk6tym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 18:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgSO2fCJYQkOwHWvV0WAdNpgTQHp5yFjeS0/ddGgaVL5l4B7nSaORMDGVHFTLIcJ8jiJv/56NDOEh3fNy+QI16Ve4UXbGDZBjn+O/+885hFtD/KbCY3psu7TGGJYNFlRgorQAIBE9TbFG5e5ICab/0CpOdQnmwQ+ZYb4360Lr1J2XuBXMJg2bwlBZvSD345jRJUKiwSxLDMqkyd2D88NUvjlExCwL/gbo/NWmf+Prq+VhASWXtR9mjkqnNGWo2tX6pGQrqmdNOjdZ6zocRoxeTU0EQHJtAFXUtmh3iTIBScxwEMRsKOgyxDFIflQIDV+xiUunPAhSK22Zef0RjWdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4RPLM4+vqJ5cVM1RbS69jEXQkwltpwpiUyRI8VORf0=;
 b=uct9NeNs3P0a2gh04XkpNozUr+8iRacP9E9FhXFOit+2FwrXhtdbDOt59SN+WObdQntNlYxyn7ARqItnqKln7ZA4Ri9Xeufo8xP1rIlpkY1RHcOURqFyeDM9Q3J6TSgnVZAxzVwTLSgOGpjnBlLRix0GltoG3exKnyAwehukw2wb8A/8S1W14WJt6BeVaeoeas7TXz8n+U62k86ihU4x+CS5EcRothf2zg+Viq1MJtAoqVbTZlDuskFlqyeYHK51d0puC90YvL5PDxPKttp9NwDDuLThT1Wr9s0H9uv4qDRjlc6tzOKJEieUMJYzTXO8Ve3ubJzMVPvJHGC3vRx72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4RPLM4+vqJ5cVM1RbS69jEXQkwltpwpiUyRI8VORf0=;
 b=EgxerhsaJPIPQcBm+imksftTzVE8Oo/Rcvi67d0VmYPLQKwYHEqW7XYoL4vSZAAthdgvRATUPRaMPnc1c9ZM/+kcBSBGPqB33Dqs9FCGOS1Axw1ny/+OWmoVPfDX+fnkdOdJ4Cb/EnNu2yyCzQlnruUke/Y7Uq3qimfUNKZ72T8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA3PR10MB8615.namprd10.prod.outlook.com (2603:10b6:208:574::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 31 Jul
 2025 18:57:10 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 18:57:09 +0000
Message-ID: <647eb60a-c8f2-4ad3-ad98-b49b6e713402@oracle.com>
Date: Thu, 31 Jul 2025 19:57:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2] btf_encoder: group all function ELF syms by
 function name
From: Alan Maguire <alan.maguire@oracle.com>
To: ihor.solodrai@linux.dev, olsajiri@gmail.com, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        eddyz87@gmail.com, menglong8.dong@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, kernel-team@meta.com
References: <20250729020308.103139-1-isolodrai@meta.com>
 <79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com>
Content-Language: en-GB
In-Reply-To: <79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0073.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA3PR10MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1e5a36-a2d1-4407-6e15-08ddd0640d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkpERUlBQW9JWldsUWMyWHJYcGJIUkFrUSthOVVWOFd0V2NaRE8ybWRpWmhl?=
 =?utf-8?B?MFFHREpQQ25MeWhFbEtDZFhnbU91alZybktaSUU4WDZYUkxpTWJKL1lIZTBo?=
 =?utf-8?B?Nyt5UkdPb1lXUnZpMVI0OGNHMlBINVVhU1AwYjE5QnJWMC9LcThObGFuSlhu?=
 =?utf-8?B?NHkzZ05UMVgxLzNDUXMzR3ZCWkhTL21Hd0daekQyMVd5emE4VldZYWtDekVY?=
 =?utf-8?B?TjNlR3lRTkFUL0ZEU1lGenJ4dGZJUnZrSGhZV0xOV1hDVWRwclR6ZDdTT29C?=
 =?utf-8?B?L2hmUkdVTGpFUjRpbUx2OElaK3g2TUl6dlFGYVBMYlgxT0luV1lwMkVqN3BM?=
 =?utf-8?B?QlFzanRXeHlUVUZEU2NKbTYvYXNFNUswa3ZtMkdvSk1QQU9UZlBnOVVIK0xi?=
 =?utf-8?B?TWxkSWRBOTVqa3NlcE9Wa2QrVnJUcnVvaEY4dGNsS0dTNUFhMUllcVFpakxv?=
 =?utf-8?B?WDJPdVJlcTFNY3RnZXgxK3krY0hEaTh0eFA4ditRUHpKN2h3S082dU4xVkh6?=
 =?utf-8?B?Skt3WmRlbERXUCtLY1dOaTJZV1pFWnQ4K1pTRTZVSm13cTdxRzM3SFM3b09p?=
 =?utf-8?B?TWJrSCs5VStrUEMxMHlaMHRyclBkSEVRWVlLYmVEVks0a2Y5UE9QZkp3dDV1?=
 =?utf-8?B?cVV0aWI0S2NpbVVkOEZaNEFYUDN5UWt3YXlrTjRFcTVCTFB1emVtbjBoWDBn?=
 =?utf-8?B?V3lDRW9QZWVaeGhhWFFTZTcxNnpwY0RKeWZ0MzgvRnN4M3IwTFNpdHRlR1Bn?=
 =?utf-8?B?cnBneHc5SXJ6WFpGN09La0Y1cVVlcXRwUjNOTFlONUxYdXZ1OHBxNk5hSFJh?=
 =?utf-8?B?L1VLSzlGUUZzN2QxN0VZUHVhOXZYR2xWSENSbEFqYnpJYzFOa3pKMXhNUEZR?=
 =?utf-8?B?NGRkTjF1WU5XcU1saGdCTmdUWmtJMW1DMzBWOEQydTRMUlVrL212WHlyZnZL?=
 =?utf-8?B?aWhVc05jQVhrRlJ5NWlGZk5iMVNVdDBYU1FWdkNCVXh4dG5iZ09neEhjTW9F?=
 =?utf-8?B?VHAwZ3BtLzdkczI2Q3dLdXJwb05lUU83QjdaVTB0THh6aW9ocS9DNnlaNXdW?=
 =?utf-8?B?RUF5Vk1iTEYzd2RtSTlCeWlGVEZqdXFzdkM4d2xKbzN2M3d2em91eUFTOFdj?=
 =?utf-8?B?bjRwN1pjYnRRNS9zTkdGUjNNZFpVTVZQb0ZOMVFzUDdjdWlIT3NWZGZiZ3U5?=
 =?utf-8?B?ZlpGNnhIVU44czZLWmJZWWJ0SWYxU0pRRXZwaE5NWjlVVXBITUpVWTFIVmd6?=
 =?utf-8?B?Tkx4aFNNRERwOEdjVVRLQ0hOd0FaM29ZWEYyR2lmUXpqTlV0OWpTNUh4ZEV0?=
 =?utf-8?B?dTAyWVpkZ3FOMHNWaGdvbFZZaFJocUdVUHRNQ3BsVmQ0MVNsM1ZSNjZHR3A2?=
 =?utf-8?B?YUxqc2FhMUJtTGlKdnM2TG82L3dtQyt3UzhPakdVSHdQYUFFR3lsQVdORFNO?=
 =?utf-8?B?R0E4QmdhMUVKN082VWYvQWErT0VtOTU0Nk1yK3RTYXhpOG9DKzBNYVY4V3l3?=
 =?utf-8?B?MnN2YnB1SllTU1ZiVFlyaytNZ2x0Zm5UMk9kNnZNYkZOVndtODBBdnBqTkJr?=
 =?utf-8?B?WWlURFhWbkxGQkpMNVlkU3pmc3pjc1BuWGo4Rzg3RU84azNsK2szZEFHOVFm?=
 =?utf-8?B?Zm1SRmNzWDdFbjVNamRPb05ZbW5xTUQzMDFHaVU4bFp1dTlDWGVmNkg3cllv?=
 =?utf-8?B?R1JxUU9RaE02NWJ4Um01SmpaYjhjblcyaTE2dWI2bFJhbm8rYmdSNEhtWUNw?=
 =?utf-8?B?TFVCaXdwOUNlcEdVL0prWGJBTFVqb08rNHlpU3RTeGlUWmFKQndSY2JrTVhy?=
 =?utf-8?B?VkY4ZnpIU2wwMS9OS3E5aUpTSVBXRU9rUmRJSldGQkV5amd0Z1RDc2R4SjJ0?=
 =?utf-8?B?elBJNmk4SXcrSjRHbmFRRmYzaXNHN2VuT3J3ZndsNjYxcVNiRG95OStNeTIw?=
 =?utf-8?Q?8ckx2jQ8K9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2ZTTnNQUnEyZ3BCWTQzbWJHRnJmZm1lKzFoSGExQWRmOTNIMlFLMnQramdG?=
 =?utf-8?B?eFM4Zlp6VUlpeVJMWnltM1pUVkJ5OWZHVG9jVG0wV2kwYjZMTXRKdUMvQ0Yr?=
 =?utf-8?B?cjFhU2VhMEZSREFYOGtkQWxoZDNVWUxGOFRGVWx3Mk1TdGI3VEg4SmJqdTY1?=
 =?utf-8?B?YkI5dDlsVW9iS1IxMW51cnZHUzFLbGd3Mi90ckFhZUY1eEwrN0NMazd2MTN5?=
 =?utf-8?B?bTZaQncrb0VKc00wQXlwSUVoalBwdmxIQWlGemo3WC9lRkJtemdyWE5FU2xh?=
 =?utf-8?B?YWlsbWluYTUyWGNoRDk1NlRXbHg2QUl4N29mQXdxdW81OENRL0EydVR2T0dJ?=
 =?utf-8?B?WkcrRTluL29LdmZEblBUcGlxbTM5UFVkYWdrTHBVWTlXU2tGKzJldThzYUNR?=
 =?utf-8?B?Zy8rMUdFN1FHM3BxemNiOVVURlJWTGVPTzU3N2FQOUEvdG83T3JOdW1kYTh5?=
 =?utf-8?B?WFlxNExMNUxLRGtScy8vNDNGbnlQMzZoWHhGRE9xV3h1bmZmd05QVFpDaURk?=
 =?utf-8?B?UmMyR0hBL1d2N3lVUEpscTBMVEFrUWdaQjYzTmJvV1p0bzVjSW82YzI2ZHZI?=
 =?utf-8?B?dWV2bDluVDRqdFBSZ2pwcmJNcE9HTUppMlFwQUU0aWhna3ZYdkM5bzR3VFJN?=
 =?utf-8?B?bm40eFlNZ1RuRHNVcnRSRng4S2ZXemtEZytrMnFONDBxQXJPYUJLeUUxMUw5?=
 =?utf-8?B?ZFc4YkFPeDJia2IyR1Zkb2kvSWRCNHBtZVloN0h2L0RZZ0xJWTNyRHNRZUk2?=
 =?utf-8?B?am4ySzdQQ0prbDRTRkxnck1LbzBHRURrRnVyS0ZFUlQ5Y0ZlSjFXeEZsbVZ0?=
 =?utf-8?B?eUorZGVUbEFYMXBlcCtOeXRHOEhlQi9DUHFaTVdBY3hReDVpdWlzUHM0clEr?=
 =?utf-8?B?aWdVSWhGZ2xadHlGeGxjUnJ4NmxBZ0k0eUxuRG1sRFJQUkdEbGhlK0xKTmFB?=
 =?utf-8?B?NDI1TmtkUFpPTW5xSnU4eXlpRUNrcWZmTW13K01OS0IzZm9wUmJIblBzUkQ2?=
 =?utf-8?B?UUZrRWgza2N3TnZ0cHJERWxvaFVZUjBIakgxUmJKL3kvN21tVjFFSDhickhl?=
 =?utf-8?B?TXRnMnpaSTZLZ1VzRXgraDBXakxJckxESjY2WndjN3QyQTFza0wzL3lUNVZE?=
 =?utf-8?B?UDJtQTZNcG5DL2FaMFI5MWFUQ1JuNjROV1dUNlZKOVRHRExyVnl0RzRDaXps?=
 =?utf-8?B?d1lNaFMvWkNOemswUm9vZzB3QytMZGFaTUU5MEtRbUZZcVUwOFo0YjNmUEha?=
 =?utf-8?B?T20zMDZ5a2hCSCtoTmtCU1lYVWp1TEFodWRXRGduRDM3aWlNanNMUm0ybUJ5?=
 =?utf-8?B?bEgwanZDdWNNMlJQYmVxNW9DUFRTdmRQdWg0U3h4aEQ1cE9RRCtza00raE54?=
 =?utf-8?B?cDdJN3J3MitQcEJybCt2bnNvaU04eGloUGcyMCt4Qm9FUFE1dTJzdFR4U3Va?=
 =?utf-8?B?V24xdlN1VTgrVGFGT0lSUS9jemNoTWNyWS9leXErb21UT29BTnhpemZ3U3NZ?=
 =?utf-8?B?blNlNkZ0NmdIWjE4ZnFtYTNLdXBEWEpQcER5dS9qYjdMMWR3K0E3MWpObFNt?=
 =?utf-8?B?RVhxR2M0TDV2NEo4VkZ5bVdhU1F5eXB1T2FUYmwySlJkSy9KUzlub1JqOThz?=
 =?utf-8?B?ZXUwNS9yL25nZGhXNWRUbUF6UjAyUzR1TTU4Q2ZHeDlkeitTVHhjUkhRMWFk?=
 =?utf-8?B?L2ZreU94NGMwbnJSbE50RE5ld1ZKaFhocHZTRG5CY1ErdU1HMTdzV1U0Zm5y?=
 =?utf-8?B?V2IxY2ZUdW1pbzdWYmN1VnJHU0NEOXdPT0RpakJzdFZyYWZ3dzJsL2svVVEr?=
 =?utf-8?B?UWZIc0VtQ0kwVjVVc3FraTdtcDgxa0RyRVJiWE1LNjdiLzBWV0VuS1pwd1dY?=
 =?utf-8?B?bVNmejBwWm9SRWs0cDl4VG5QRk1SQXJkTXFuVkdSNFRhUGZSNHNZZUlES1Bj?=
 =?utf-8?B?a0k3ckxPMTUyYTNrb1F5QjlsMFpSenVzSER6d3BzTHAwNFo2ZnVZeS9adWFC?=
 =?utf-8?B?T0dUMTl1ODdLdm5HbzJLbmx1VEFreDlxazBuU2lRZTVFNTh2TENyM2JmbUg3?=
 =?utf-8?B?QVV6RjhrQzdlc3VEMUl3blF5N21BT3NuRHErb3AxS3lmVnpKTmxkdStqODFt?=
 =?utf-8?B?cWhBUTE5VE1PeHRJeWtVKzFrdzQwWlVzeXQ0T1RZeHU3Q1pGWjkyVjlDRWRR?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2D5NbIFjeUotv+D/dnVoYj/gJ+pMz9zocItSwwGydlC0fIVdfHNbYC8HKsOjyBfVm9epKBf5hljRGY7fCzUnaZnZ18aEmDMcZZ8jj/QN8aP3+qOkO+TBenMuXL//GX2A/h7JH72ANJ6AA4GVaUJnLbJXUkJ1iy60n78cpNtRisGB4zZLcQpdX76Tv3goFF5VX+7BPElYWGxHmz7ct+wb+3qFRQbveYQWqFyTgXnYVwRbxhYU1gWbYnaoyDjPpaIGOlF4cnkB/c/q+ccgnYM2uWX42Y1fvKa6NIQ3OnjWsbdgDYeUpSGEIh7LZkhB0LmrzJdRt3ITaJ4xz9HAJVxgf6IBpHEstRlwFuBTvNQsl+dzO6ClNy+Yz7D//uPpOPKlIZWRv5IKzjeZPn+dU2tKChaxtwYuD4+8WXqooTGBKi1H+0jvZHnZw6uVEh6VC477xSF4x3XhbmH/Nd5cx35v4CmQojKME/Vqdp7eFHwZbsPvPwlKzu6A1R+ZjOj2oOWBufje8gvnTxpvh6podK+E6mHuZKZJ67+JZncK/ficUfTh+fMbYwW0N9fVXT3iYijHKObeDwId4X1GozWZJ7SACnnTwD/NDrLwgjHzYEm3hbM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1e5a36-a2d1-4407-6e15-08ddd0640d43
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 18:57:09.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hgs7+TokCFr5P+qSXb5x0xEHvCczDZLeO6nBImLVUa1yUBLupG8678EXs+NDOrRd10REzdaoKMrJoE1o1iK2lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310134
X-Proofpoint-ORIG-GUID: fhVFyBkf1gHpZxxN414U89BxDxkKDj_2
X-Proofpoint-GUID: fhVFyBkf1gHpZxxN414U89BxDxkKDj_2
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=688bbc8a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=PRt8C0QHhmmqq0EN1YgA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:12071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEzNSBTYWx0ZWRfX3vjRMqRrIn+f
 ZdPeaExQ7SEiPwIoVAsLvJh1RBLb1HBO2Hj5c6y1/AStihwF3ymplbpnVTsOr1tOwFLmvywffYx
 3eNapWHfEHxjexndD5I1hDBVIUm32NQVU48fRhAsirCyr2qrNIdWv5jjoq5W29WmQ954lQFZAw9
 ljCxA9r9LgnAt272tK/tHQuVK29TS08OEJ24+yCBGO8UkH5aO9p8p80vVJhAXfb0IaVNnrbghOJ
 P+0R2tFD4Ag9E674lE/j9XmodUT+8zX/MaY5ZtKnj3h9TDSrPknsimJi43tQKK8RzDXnlRF9s6u
 NvdMJ9BbI60k/08y/u2V9twJcz/9+DK+IOjD9cbYkZ61CZ4mQM5BoMn2zOvmYzvJlaUj/gJFJzw
 HgIql/GS9UMit3pNL6Kx/IhPmwXJVmHqElercKqI/ZK08Q8PO8WiKB6/cPJ40/6BkX1zF8/q

On 31/07/2025 15:16, Alan Maguire wrote:
> On 29/07/2025 03:03, Ihor Solodrai wrote:
>> btf_encoder collects function ELF symbols into a table, which is later
>> used for processing DWARF data and determining whether a function can
>> be added to BTF.
>>
>> So far the ELF symbol name was used as a key for search in this table,
>> and a search by prefix match was attempted in cases when ELF symbol
>> name has a compiler-generated suffix.
>>
>> This implementation has bugs [1][2], causing some functions to be
>> inappropriately excluded from (or included into) BTF.
>>
>> Rework the implementation of the ELF functions table. Use a name of a
>> function without any suffix - symbol name before the first occurrence
>> of '.' - as a key. This way btf_encoder__find_function() always
>> returns a valid elf_function object (or NULL).
>>
>> Collect an array of symbol name + address pairs from GElf_Sym for each
>> elf_function when building the elf_functions table.
>>
>> Introduce ambiguous_addr flag to the btf_encoder_func_state. It is set
>> when the function is saved by examining the array of ELF symbols in
>> elf_function__has_ambiguous_address(). It tests whether there is only
>> one unique address for this function name, taking into account that
>> some addresses associated with it are not relevant:
>>   * ".cold" suffix indicates a piece of hot/cold split
>>   * ".part" suffix indicates a piece of partial inline
>>
>> When inspecting symbol name we have to search for any occurrence of
>> the target suffix, as opposed to testing the entire suffix, or the end
>> of a string. This is because suffixes may be combined by the compiler,
>> for example producing ".isra0.cold", and the conclusion will be
>> incorrect.
>>
>> In saved_functions_combine() check ambiguous_addr when deciding
>> whether a function should be included in BTF.
>>
>> Successful CI run: https://github.com/acmel/dwarves/pull/68/checks
>>
>> I manually spot checked some of the ~200 functions from vmlinux (BPF
>> CI-like kconfig) that are now excluded: all of those that I checked
>> had multiple addresses, and some where static functions from different
>> files with the same name.
>>
>> [1] https://lore.kernel.org/bpf/2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev/
>> [2] https://lore.kernel.org/dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/
>>
>> v1: https://lore.kernel.org/dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/
>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> 
> Thanks for doing this Ihor! Apologies for just thinking of this now, but
> why don't we filter out the .cold and .part functions earlier, not even
> adding them to the ELF functions list? Something like this on top of
> your patch:
> 
> $ git diff
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 0aa94ae..f61db0f 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1188,27 +1188,6 @@ static struct btf_encoder_func_state
> *btf_encoder__alloc_func_state(struct btf_e
>         return state;
>  }
> 
> -/* some "." suffixes do not correspond to real functions;
> - * - .part for partial inline
> - * - .cold for rarely-used codepath extracted for better code locality
> - */
> -static bool str_contains_non_fn_suffix(const char *str) {
> -       static const char *skip[] = {
> -               ".cold",
> -               ".part"
> -       };
> -       char *suffix = strchr(str, '.');
> -       int i;
> -
> -       if (!suffix)
> -               return false;
> -       for (i = 0; i < ARRAY_SIZE(skip); i++) {
> -               if (strstr(suffix, skip[i]))
> -                       return true;
> -       }
> -       return false;
> -}
> -
>  static bool elf_function__has_ambiguous_address(struct elf_function
> *func) {
>         struct elf_function_sym *sym;
>         uint64_t addr;
> @@ -1219,12 +1198,10 @@ static bool
> elf_function__has_ambiguous_address(struct elf_function *func) {
>         addr = 0;
>         for (int i = 0; i < func->sym_cnt; i++) {
>                 sym = &func->syms[i];
> -               if (!str_contains_non_fn_suffix(sym->name)) {
> -                       if (addr && addr != sym->addr)
> -                               return true;
> -                       else
> +               if (addr && addr != sym->addr)
> +                       return true;
> +               else
>                                 addr = sym->addr;
> -               }
>         }
> 
> 
>         return false;
> @@ -2208,9 +2185,12 @@ static int elf_functions__collect(struct
> elf_functions *functions)
>                 func = &functions->entries[functions->cnt];
> 
>                 suffix = strchr(sym_name, '.');
> -               if (suffix)
> +               if (suffix) {
> +                       if (strstr(suffix, ".part") ||
> +                           strstr(suffix, ".cold"))
> +                               continue;
>                         func->name = strndup(sym_name, suffix - sym_name);
> -               else
> +               } else
>                         func->name = strdup(sym_name);
> 
>                 if (!func->name) {
> 
> I think that would work and saves later string comparisons, what do you
> think?
>

Apologies, this isn't sufficient. Considering cases like objpool_free(),
the problem is it has two entries in ELF for objpool_free and
objpool_free.part.0. So let's say we exclude objpool_free.part.0 from
the ELF representation, then we could potentially end up excluding
objpool_free as inconsistent if the DWARF for objpool_free.part.0
doesn't match that of objpool_free. It would appear to be inconsistent
but isn't really.

I think the best thing might be to retain the .part/.cold repesentations
in the ELF table but perhaps mark them with a flag (non_fn for
non-function or similar?) at creation time to avoid expensive string
comparisons later.

On the subject of improving matching, we do have address info for DWARF
functions in many cases like this, and that can help guide DWARF->ELF
mapping. I have a patch that helps collect function address info in
dwarf_loader.c; perhaps we could make use of it in doing more accurate
matching? In the above case for example, we actually have DWARF function
addresses for both objpool_free and objpool_free.part.0 so we could in
that case figure out the DWARF-ELF mapping even though there are
multiple ELF addresses and multiple DWARF representations.

Haven't thought it through fully to be honest, but I think we want to
avoid edge cases like the above where we either label a function as
inconsistent or ambiguous unnecessarily. I'll try to come up with a
rough proof-of-concept that weaves address-based matching into the
approach you have here, since what you've done is a huge improvement.
Again sorry for the noise here, I struggle to think through all the
permutations we have to consider here to be honest.

Thanks!

Alan



>> ---
>>  btf_encoder.c | 250 ++++++++++++++++++++++++++++++++------------------
>>  1 file changed, 162 insertions(+), 88 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 0bc2334..0aa94ae 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -87,16 +87,22 @@ struct btf_encoder_func_state {
>>  	uint8_t optimized_parms:1;
>>  	uint8_t unexpected_reg:1;
>>  	uint8_t inconsistent_proto:1;
>> +	uint8_t ambiguous_addr:1;
>>  	int ret_type_id;
>>  	struct btf_encoder_func_parm *parms;
>>  	struct btf_encoder_func_annot *annots;
>>  };
>>  
>> +struct elf_function_sym {
>> +	const char *name;
>> +	uint64_t addr;
>> +};
>> +
>>  struct elf_function {
>> -	const char	*name;
>> -	char		*alias;
>> -	size_t		prefixlen;
>> -	bool		kfunc;
>> +	char		*name;
>> +	struct elf_function_sym *syms;
>> +	uint8_t 	sym_cnt;
>> +	uint8_t		kfunc:1;
>>  	uint32_t	kfunc_flags;
>>  };
>>  
>> @@ -115,7 +121,6 @@ struct elf_functions {
>>  	struct elf_symtab *symtab;
>>  	struct elf_function *entries;
>>  	int cnt;
>> -	int suffix_cnt; /* number of .isra, .part etc */
>>  };
>>  
>>  /*
>> @@ -161,10 +166,18 @@ struct btf_kfunc_set_range {
>>  	uint64_t end;
>>  };
>>  
>> +static inline void elf_function__free_content(struct elf_function *func) {
>> +	free(func->name);
>> +	if (func->sym_cnt)
>> +		free(func->syms);
>> +	memset(func, 0, sizeof(*func));
>> +}
>> +
>>  static inline void elf_functions__delete(struct elf_functions *funcs)
>>  {
>> -	for (int i = 0; i < funcs->cnt; i++)
>> -		free(funcs->entries[i].alias);
>> +	for (int i = 0; i < funcs->cnt; i++) {
>> +		elf_function__free_content(&funcs->entries[i]);
>> +	}
>>  	free(funcs->entries);
>>  	elf_symtab__delete(funcs->symtab);
>>  	list_del(&funcs->node);
>> @@ -981,8 +994,7 @@ static void btf_encoder__log_func_skip(struct btf_encoder *encoder, struct elf_f
>>  
>>  	if (!encoder->verbose)
>>  		return;
>> -	printf("%s (%s): skipping BTF encoding of function due to ",
>> -	       func->alias ?: func->name, func->name);
>> +	printf("%s : skipping BTF encoding of function due to ", func->name);
>>  	va_start(ap, fmt);
>>  	vprintf(fmt, ap);
>>  	va_end(ap);
>> @@ -1176,6 +1188,48 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
>>  	return state;
>>  }
>>  
>> +/* some "." suffixes do not correspond to real functions;
>> + * - .part for partial inline
>> + * - .cold for rarely-used codepath extracted for better code locality
>> + */
>> +static bool str_contains_non_fn_suffix(const char *str) {
>> +	static const char *skip[] = {
>> +		".cold",
>> +		".part"
>> +	};
>> +	char *suffix = strchr(str, '.');
>> +	int i;
>> +
>> +	if (!suffix)
>> +		return false;
>> +	for (i = 0; i < ARRAY_SIZE(skip); i++) {
>> +		if (strstr(suffix, skip[i]))
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +static bool elf_function__has_ambiguous_address(struct elf_function *func) {
>> +	struct elf_function_sym *sym;
>> +	uint64_t addr;
>> +
>> +	if (func->sym_cnt <= 1)
>> +		return false;
>> +
>> +	addr = 0;
>> +	for (int i = 0; i < func->sym_cnt; i++) {
>> +		sym = &func->syms[i];
>> +		if (!str_contains_non_fn_suffix(sym->name)) {
>> +			if (addr && addr != sym->addr)
>> +				return true;
>> +			else
>> +			 	addr = sym->addr;
>> +		}
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
>>  {
>>  	struct btf_encoder_func_state *state = btf_encoder__alloc_func_state(encoder);
>> @@ -1191,6 +1245,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>  
>>  	state->encoder = encoder;
>>  	state->elf = func;
>> +	state->ambiguous_addr = elf_function__has_ambiguous_address(func);
>>  	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>>  	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
>>  	if (state->nr_parms > 0) {
>> @@ -1294,7 +1349,7 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>>  	int err;
>>  
>>  	btf_fnproto_id = btf_encoder__add_func_proto(encoder, NULL, state);
>> -	name = func->alias ?: func->name;
>> +	name = func->name;
>>  	if (btf_fnproto_id >= 0)
>>  		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
>>  						      name, false);
>> @@ -1338,48 +1393,39 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>>  	return 0;
>>  }
>>  
>> -static int functions_cmp(const void *_a, const void *_b)
>> +static int elf_function__name_cmp(const void *_a, const void *_b)
>>  {
>>  	const struct elf_function *a = _a;
>>  	const struct elf_function *b = _b;
>>  
>> -	/* if search key allows prefix match, verify target has matching
>> -	 * prefix len and prefix matches.
>> -	 */
>> -	if (a->prefixlen && a->prefixlen == b->prefixlen)
>> -		return strncmp(a->name, b->name, b->prefixlen);
>>  	return strcmp(a->name, b->name);
>>  }
>>  
>> -#ifndef max
>> -#define max(x, y) ((x) < (y) ? (y) : (x))
>> -#endif
>> -
>>  static int saved_functions_cmp(const void *_a, const void *_b)
>>  {
>>  	const struct btf_encoder_func_state *a = _a;
>>  	const struct btf_encoder_func_state *b = _b;
>>  
>> -	return functions_cmp(a->elf, b->elf);
>> +	return elf_function__name_cmp(a->elf, b->elf);
>>  }
>>  
>>  static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
>>  {
>> -	uint8_t optimized, unexpected, inconsistent;
>> -	int ret;
>> +	uint8_t optimized, unexpected, inconsistent, ambiguous_addr;
>> +
>> +	if (a->elf != b->elf)
>> +		return 1;
>>  
>> -	ret = strncmp(a->elf->name, b->elf->name,
>> -		      max(a->elf->prefixlen, b->elf->prefixlen));
>> -	if (ret != 0)
>> -		return ret;
>>  	optimized = a->optimized_parms | b->optimized_parms;
>>  	unexpected = a->unexpected_reg | b->unexpected_reg;
>>  	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
>> -	if (!unexpected && !inconsistent && !funcs__match(a, b))
>> +	ambiguous_addr = a->ambiguous_addr | b->ambiguous_addr;
>> +	if (!unexpected && !inconsistent && !ambiguous_addr && !funcs__match(a, b))
>>  		inconsistent = 1;
>>  	a->optimized_parms = b->optimized_parms = optimized;
>>  	a->unexpected_reg = b->unexpected_reg = unexpected;
>>  	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
>> +	a->ambiguous_addr = b->ambiguous_addr = ambiguous_addr;
>>  
>>  	return 0;
>>  }
>> @@ -1432,7 +1478,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>>  		 * just do not _use_ them.  Only exclude functions with
>>  		 * unexpected register use or multiple inconsistent prototypes.
>>  		 */
>> -		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
>> +		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->ambiguous_addr;
>>  
>>  		if (add_to_btf) {
>>  			err = btf_encoder__add_func(state->encoder, state);
>> @@ -1447,32 +1493,6 @@ out:
>>  	return err;
>>  }
>>  
>> -static void elf_functions__collect_function(struct elf_functions *functions, GElf_Sym *sym)
>> -{
>> -	struct elf_function *func;
>> -	const char *name;
>> -
>> -	if (elf_sym__type(sym) != STT_FUNC)
>> -		return;
>> -
>> -	name = elf_sym__name(sym, functions->symtab);
>> -	if (!name)
>> -		return;
>> -
>> -	func = &functions->entries[functions->cnt];
>> -	func->name = name;
>> -	if (strchr(name, '.')) {
>> -		const char *suffix = strchr(name, '.');
>> -
>> -		functions->suffix_cnt++;
>> -		func->prefixlen = suffix - name;
>> -	} else {
>> -		func->prefixlen = strlen(name);
>> -	}
>> -
>> -	functions->cnt++;
>> -}
>> -
>>  static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *encoder)
>>  {
>>  	struct elf_functions *funcs = NULL;
>> @@ -1490,13 +1510,12 @@ static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *enco
>>  	return funcs;
>>  }
>>  
>> -static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
>> -						       const char *name, size_t prefixlen)
>> +static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder, const char *name)
>>  {
>>  	struct elf_functions *funcs = elf_functions__find(encoder->cu->elf, &encoder->elf_functions_list);
>> -	struct elf_function key = { .name = name, .prefixlen = prefixlen };
>> +	struct elf_function key = { .name = (char*)name };
>>  
>> -	return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), functions_cmp);
>> +	return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), elf_function__name_cmp);
>>  }
>>  
>>  static bool btf_name_char_ok(char c, bool first)
>> @@ -2060,7 +2079,7 @@ static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
>>  			continue;
>>  		}
>>  
>> -		elf_fn = btf_encoder__find_function(encoder, func, 0);
>> +		elf_fn = btf_encoder__find_function(encoder, func);
>>  		if (elf_fn) {
>>  			elf_fn->kfunc = true;
>>  			elf_fn->kfunc_flags = pair->flags;
>> @@ -2135,14 +2154,34 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
>>  	return err;
>>  }
>>  
>> +static inline int elf_function__push_sym(struct elf_function *func, struct elf_function_sym *sym) {
>> +	struct elf_function_sym *tmp;
>> +
>> +	if (func->sym_cnt)
>> +		tmp = realloc(func->syms, (func->sym_cnt + 1) * sizeof(func->syms[0]));
>> +	else
>> +		tmp = calloc(sizeof(func->syms[0]), 1);
>> +
>> +	if (!tmp)
>> +		return -ENOMEM;
>> +
>> +	func->syms = tmp;
>> +	func->syms[func->sym_cnt] = *sym;
>> +	func->sym_cnt++;
>> +
>> +	return 0;
>> +}
>> +
>>  static int elf_functions__collect(struct elf_functions *functions)
>>  {
>>  	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
>> -	struct elf_function *tmp;
>> +	struct elf_function_sym func_sym;
>> +	struct elf_function *func, *tmp;
>> +	const char *sym_name, *suffix;
>>  	Elf32_Word sym_sec_idx;
>> +	int err = 0, i, j;
>>  	uint32_t core_id;
>>  	GElf_Sym sym;
>> -	int err = 0;
>>  
>>  	/* We know that number of functions is less than number of symbols,
>>  	 * so we can overallocate temporarily.
>> @@ -2153,18 +2192,72 @@ static int elf_functions__collect(struct elf_functions *functions)
>>  		goto out_free;
>>  	}
>>  
>> +	/* First, collect an elf_function for each GElf_Sym
>> +	 * Where func->name is without a suffix
>> +	 */
>>  	functions->cnt = 0;
>>  	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_sec_idx) {
>> -		elf_functions__collect_function(functions, &sym);
>> +
>> +		if (elf_sym__type(&sym) != STT_FUNC)
>> +			continue;
>> +
>> +		sym_name = elf_sym__name(&sym, functions->symtab);
>> +		if (!sym_name)
>> +			continue;
>> +
>> +		func = &functions->entries[functions->cnt];
>> +
>> +		suffix = strchr(sym_name, '.');
>> +		if (suffix)
>> +			func->name = strndup(sym_name, suffix - sym_name);
>> +		else
>> +			func->name = strdup(sym_name);
>> +
>> +		if (!func->name) {
>> +			err = -ENOMEM;
>> +			goto out_free;
>> +		}
>> +
>> +		func_sym.name = sym_name;
>> +		func_sym.addr = sym.st_value;
>> +
>> +		err = elf_function__push_sym(func, &func_sym);
>> +		if (err)
>> +			goto out_free;
>> +
>> +		functions->cnt++;
>>  	}
>>  
>> +	/* At this point functions->entries is an unordered array of elf_function
>> +	 * each having a name (without a suffix) and a single elf_function_sym (maybe with suffix)
>> +	 * Now let's sort this table by name.
>> +	 */
>>  	if (functions->cnt) {
>> -		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), functions_cmp);
>> +		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), elf_function__name_cmp);
>>  	} else {
>>  		err = 0;
>>  		goto out_free;
>>  	}
>>  
>> +	/* Finally dedup by name, transforming { name -> syms[1] } entries into { name -> syms[n] } */
>> +	i = 0;
>> +	j = 1;
>> +	for (j = 1; j < functions->cnt; j++) {
>> +		struct elf_function *a = &functions->entries[i];
>> +		struct elf_function *b = &functions->entries[j];
>> +
>> +		if (!strcmp(a->name, b->name)) {
>> +			elf_function__push_sym(a, &b->syms[0]);
>> +			elf_function__free_content(b);
>> +		} else {
>> +			i++;
>> +			if (i != j)
>> +				functions->entries[i] = functions->entries[j];
>> +		}
>> +	}
>> +
>> +	functions->cnt = i + 1;
>> +
>>  	/* Reallocate to the exact size */
>>  	tmp = realloc(functions->entries, functions->cnt * sizeof(struct elf_function));
>>  	if (tmp) {
>> @@ -2661,30 +2754,11 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  			if (!name)
>>  				continue;
>>  
>> -			/* prefer exact function name match... */
>> -			func = btf_encoder__find_function(encoder, name, 0);
>> -			if (!func && funcs->suffix_cnt &&
>> -			    conf_load->btf_gen_optimized) {
>> -				/* falling back to name.isra.0 match if no exact
>> -				 * match is found; only bother if we found any
>> -				 * .suffix function names.  The function
>> -				 * will be saved and added once we ensure
>> -				 * it does not have optimized-out parameters
>> -				 * in any cu.
>> -				 */
>> -				func = btf_encoder__find_function(encoder, name,
>> -								  strlen(name));
>> -				if (func) {
>> -					if (encoder->verbose)
>> -						printf("matched function '%s' with '%s'%s\n",
>> -						       name, func->name,
>> -						       fn->proto.optimized_parms ?
>> -						       ", has optimized-out parameters" :
>> -						       fn->proto.unexpected_reg ? ", has unexpected register use by params" :
>> -						       "");
>> -					if (!func->alias)
>> -						func->alias = strdup(name);
>> -				}
>> +			func = btf_encoder__find_function(encoder, name);
>> +			if (!func) {
>> +				if (encoder->verbose)
>> +					printf("could not find function '%s' in the ELF functions table\n", name);
>> +				continue;
>>  			}
>>  		} else {
>>  			if (!fn->external)
> 
> 


