Return-Path: <bpf+bounces-75168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7420CC748FA
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 15:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E57064E2CB3
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F7E33A6F6;
	Thu, 20 Nov 2025 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fhf03jFX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M+uWG9Sv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CC33DEE7
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648438; cv=fail; b=Urj2rH/I9v8V1vYOLT/AWUgYBVNkmH4+MRG2UpyAf2ajf8+1utzqO1twrGdAak+yDgDDW1Fg2eFB6Km7VHJEG/R55X7oAcBlkdy7HOw4V3Xb4m8UBHFZ78Y3nlH2OOjwG03oHg9Sd8jX9NlUwnWQ9mQOegrwUP6HhiHb2Kqi6W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648438; c=relaxed/simple;
	bh=iYdj1Qru/HocyJGRFslhe2vlGeI9y/BxqA3Tzhs3Jxw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lY7qlk09cW7Bh3qoZAW+KCRYMMOntfpg/G2r+AHv61HC0kvDEJ+ZQ6gZPYAb5jXMPGm9TE10G0HCa2N4Ps/UHXGxHN5++e9jIkPtndPquM8BtGJSPWWl1Fb9yKdDwVePtUgEF+5gGx4LaSitKHl0BgG8TNwDHyoMGe8t7MhtbG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fhf03jFX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M+uWG9Sv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCsFH4016364;
	Thu, 20 Nov 2025 14:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XvsdtydBq4EqhP1MhOYy7G1PSwPkmD7NVcIZ8OLHOQo=; b=
	Fhf03jFXnYFMENgTVDf114K02/9copGUW+bbvwxwfdGyutiRqRhc8yvZOs+DI0N3
	QjYm/DCRQH9IGFgPeuBRUTziBmcKo1lc3BCsT3UFSraODEZDniRKhm2UTpVMN71o
	o8HSbZzLM4kVLQmaoHUDU1zdpyXbh9PliNihgeVqvy51xQv3dSe4tG630Udk6izv
	A+A36pCxR1ByULTM0NWW66O39ksL+dDG8cJlrh8yLnCK2ie0o1eHUQKWbBvc6w8C
	7pZ+H1USu31BZM+DFZEtX98srQaFDzE7/gqvyXPYqtKQabwBV5SgbWOiYtilH7af
	XTe2c93hoCrQzVo/4e1auw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1h55b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 14:20:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCjhGW004280;
	Thu, 20 Nov 2025 14:20:21 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybwjng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 14:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkbO8gdZHdDoS7eF4c999ZXeQh3p6L6lR1HVwD/bifzQoJhYlXG3FtmBVAfdwE8R24EIIR/a5dHYPi86HeyOL7p1P+Nid9b/kj/7gMR0eMMSvUdKKjNA4izj34zdwNgWpzSoBkHwe2AU4XniK5Cr6TsBdAIuUH85Rd9aT3qf/VgcZTYVfC6UGnV/Dt+0c7YJ9t8CV8BuwRiAKvXjqmVlmsKJLiU/ecq7sGmU+5WGRrDq48nEsNVOL/Qm6epDCgzjlcE36thwqpWWU4K9mqR6gmIdOjPJLmXQ3p+0BdB4rgxPnJZWVki6z0OmZA/sVK+iHn1oRWXTAxQHC7D3UmYSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvsdtydBq4EqhP1MhOYy7G1PSwPkmD7NVcIZ8OLHOQo=;
 b=q4AYKHRDzp//lvCgKek5aWQRsk/DKBxXxQy+GuTQdKVaC9R4ZBcBWr/9A4FF1DjjXF/hb0C+qC2KeTr3l4VXyFtkqXFhc9YWQ9yqsXg4HACAB+uTdWgx90aTwMd16Yi4WT/DWM7Dq/GSWEhSVZQy1NnyXOvM3nWGIxZWFbCPNh/6b0XfjIlOYwJ63WW6+R5zwmz769coRDe0Pueg/X13SEMnVo5/Wbw0fkUZgabc8cCRKPAZ0KJ6jvfBphSaijA/YKdnEw7bB+h1hdZBMPG1uKM47lrYyIqVAy9Fw2gJrysrIl1vlkO9IFDRna+CnkaeVfpplcAFpjZiP/ReuZygHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvsdtydBq4EqhP1MhOYy7G1PSwPkmD7NVcIZ8OLHOQo=;
 b=M+uWG9SvXppC006LZ3J4CxXjnnYc1xY0FI42sJHKFOTvYaRpNYrI0H3EinpcKSPWxx/RHaziwNzGKsZXOnDFhzZpSDJqTgEoIjwy+Pn3P/5rfLlmfOooFtaMoYTaY9EXWRHLPyODUC44zIUaGkXCR1RDgGRIu6Gtyewj4JKSOo8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 LV3PR10MB8180.namprd10.prod.outlook.com (2603:10b6:408:286::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 14:20:17 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 14:20:17 +0000
Message-ID: <87641066-a837-41ff-acbc-9f4453d0ae58@oracle.com>
Date: Thu, 20 Nov 2025 14:20:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel build fails if both CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN
 are enabled
To: Bart Van Assche <bvanassche@acm.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nilay Shroff <nilay@linux.ibm.com>
References: <2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org>
 <d296ec97-933a-4b19-aa75-714e69b3ac4f@oracle.com>
 <7161e3e3-7bd0-47ec-892d-72a58b06df33@acm.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <7161e3e3-7bd0-47ec-892d-72a58b06df33@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::8) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|LV3PR10MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be0ead7-970e-4a0a-87f1-08de283fedfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHBwMTkzVm1ONGkwQWFzNFpmN2d3bFYvc1RrNldyOE5CM2U4RitxYnkwT215?=
 =?utf-8?B?b3o0TmluZWZGRCt0K3p4L0JVV1F6dE9OUXhjTnRDOGVvS05DVUdsV0pvd0Fa?=
 =?utf-8?B?U2pEZ0FucU8xMkltb0ExSHQ2T1F3bVJsbVdJZzl6M1RtaUpzSXd3ayt1UjQ5?=
 =?utf-8?B?UFAzRSs1ZCtwU0xZVER5YXU2Q09MTDl0Mmd4YXEyOTkra2VQaWZSWUhFUjZi?=
 =?utf-8?B?c1Q3V3lBSi9GMFJEUENMR1o4OEF4SkxOVk5Ba0FHbCt0dmhyeUJadXFxU0xm?=
 =?utf-8?B?ckh6R3FISFYwWDR1RE1tRG1WWnlDUDVFT3JQaVlPTDZyenNQSWVNa2xBNnVn?=
 =?utf-8?B?TUhDM3dTRE44Mkl1c21CSnVHUjF2ajhDMmlKNElVY3BqajliaXo0TEx1dzlJ?=
 =?utf-8?B?NXNYdU5GdEZrbFFCTTJEeFRuZkJZYjByb0NzNmdBYWlhZGJGYVVFQ2gxaTVS?=
 =?utf-8?B?ZzFPeFEvNEgzZmI2bHd6T1JZMm1TNTQ3S28vaDZHWlRpMkJJZFE3cktLTjdY?=
 =?utf-8?B?TDZ1cWdvV3dqcVhGTXJEN2p2bmpRU2VtWkJ1ODRzVVlpQnhLK1IzRDZXSG1G?=
 =?utf-8?B?bTI0bmlSN2lZSG9saFZoOTJqQVJUSDVoZTR3Uk54UjZwTGpqN0hSaGcyUGY1?=
 =?utf-8?B?OU9tQUx6b0tpbU5DUFE1TFRJZmt5NXZ0a0VxakFnckQ3N0UySlpMWGwzNFZK?=
 =?utf-8?B?eGNrV3JEZWpuajFJZnhyZGZuQWVDd0N1K3M2cXpTamYvc3ZZU3hWWkltUEIv?=
 =?utf-8?B?SWJhOTJTbkQ1Y1ZkYUVwMTRTYzZESEdwSzJpMXgxdUdtME91eS9zNjNDTUVV?=
 =?utf-8?B?bmhzVFZ3MEgzVHBveFUzbXVmRzR5czJSVGxnQ2VXRTdhU01kcnZkNGdwREpM?=
 =?utf-8?B?U3FVV3pRNDRyemVYR0xUL0JNd084dkxiME1jUzk1SWRjL1pWOVE0TXVHSXhX?=
 =?utf-8?B?OWRPemJId3RrWjlOam9lbFk1YVhWOTdkdmZ5YmNsZUVDNjFFenpUYlRDa0hQ?=
 =?utf-8?B?VFVhSWVHbUNHT0pWSUhOVWJRbmRQd0F1akJ0dlR0Z1lGL1Q5UmVQMTU5aDJQ?=
 =?utf-8?B?aWdIaGF5Zm9kQkJ5aFYyYm9NSjl4T2ZUd1lMVGxpdTd1ZTRtdmN4dUtNc2ZL?=
 =?utf-8?B?NE1pTTgzMmZaUGNyaDl5bUhXSDh1S2RBUGR5YVRUR2k3MjBtZDgzbUkvWnVB?=
 =?utf-8?B?cVIvbkhxd1NSY2lTV3R6eWdrL3lCMUlnZk9FWWZrbk84U3ZEZVVGSVlHYkVj?=
 =?utf-8?B?OS9Bd0pHSkxJWGFTaDNwZUFFelN4M1p6RnZvRFFoLzNYN3g2VExuTmpHa0I4?=
 =?utf-8?B?WFVlV3dNcW00Ym9TeUZ4OE1qT0VWZCtVUnRTZGk1M01ob2xzdmNSYitxMTNN?=
 =?utf-8?B?dTVnM2pxUDhqWUZISUdkN2NDOTRFM3VQcEdWVldldDBpNDIwS3paOEpldEIx?=
 =?utf-8?B?RklzSEo1czJlSkN1Y0ExRVh5Rk1sM2h0bzM0S0E4aFRFQndvSk0wTzJsMjhP?=
 =?utf-8?B?SkhORG1aajRoaGJhdU1VZXlCSWNXTHBSbjdiNVUzc2NIVjNLcmFEUlRhMFE1?=
 =?utf-8?B?dlhxck13dkZtRTlsUUk3S1hMUGswcFM1Q3NOQ3dqdE9uWkFWcklVL1lqSDFG?=
 =?utf-8?B?NjRMOTB2YWpEZkpEUU1jcTloaFRrRTZTUm5UeGhibUJaS1dLYVh1elo1RGN0?=
 =?utf-8?B?MzlaNnhTVGxUbTE2WlBnOERTOXVHVm55cXlqcHFKOVRLTlVVamM5WTl0Rkxp?=
 =?utf-8?B?NjFINFNyamxOS0xHU3JSWll5em5rNStOZVpCUVVhcjZGM0pXY1B2WEhiR3V1?=
 =?utf-8?B?dkx3T0ZqSnZCQTdOd1Y2dUVxYWtpbGpML0crNUhxUXNQWDVFTklHNE5RR1hW?=
 =?utf-8?B?Nlp6U1o3RzZPOFRSaXVORlByMnRWL1U2NFhRUXk5K0RHUzI0ajRBMWNjYlhu?=
 =?utf-8?Q?EudAZKfmiyufmejReB3V3jgqSQJPGzOP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEIreHE1MDBNUXZZUG52dWZ1TGYzMlBaR3FvbnlERVMyaWhYN3lPMndNQ2Ft?=
 =?utf-8?B?cW91WWZscUpxVEw2WXF6NVhjeHU3Q2xBNHU1TWhUcUV6SDFiZzljalZHK2Zx?=
 =?utf-8?B?aDN6QWVjbXZaVVpCeWJ1dWo3QVlyYjMrY2pNQVFWSDBBR0lFY2NudWZCRDU2?=
 =?utf-8?B?Ky9LWEY5ZkhabnQxcXVpZ3hCWUpSUXp4UjNtZ28rNnd6OVV4SlRBbE5ZM3d1?=
 =?utf-8?B?SkhHa3h6RkJOK1RhZ1VuRUJIV2FPU05wZktDK1Ric0JJWmJocTdzR1BzQUp3?=
 =?utf-8?B?L2M3ZDM4a3pKZGRwQ2Qrd3ZjQ3cwT2RPNWJ1R0dab0ZCYU5BYXZHYmhYSExJ?=
 =?utf-8?B?dzcyWVh5YktVTWZVdkNyR2Q1NGc1OWM5TksxRzVCZTAvenNSUlB0M3JsWm5z?=
 =?utf-8?B?RjBpSlQyZW5SRE5XM1JtejBpZlJwT09CUDNySFlETHNOYTFTZ1hrSzRtMDdG?=
 =?utf-8?B?SGVhdTNzMkVKOEJROHkyS05sTXV3NG5MS01IMEFSTXVUaStnZkNUN0JESUJw?=
 =?utf-8?B?M2Q4dlU1NDEySHZLMU1ZVEYxc0NQQnFUajdwV3NIUnI0RnJ4RHJLRFlXektw?=
 =?utf-8?B?VDB1dWE3SzVoS05CV3VXblhCckRZdTFqa3ozeTIxUzVHVXpNWlF2NVJlVVg4?=
 =?utf-8?B?Sm1QMU9oeWtXTFI1Y3ZURk5BclJqeVpxYWFRdzFiZVNUSG80cklzWkp0YWdR?=
 =?utf-8?B?ZmtWa1JidG1zdjNXMUtSemVMVFZKUW9VTndRamNtRGVHOUsyUlFMaFNiUEpv?=
 =?utf-8?B?d3NWaXVrVUZOZXZBRWIxcDlVanhLYm9tTjdtS1JQRjRzd0ZlUmZDdm5KZE55?=
 =?utf-8?B?cjV4bUtBVW9XM3BlRlZPSmtNbUQ0bDV0c3I0M3RROTVRakRuK1A3aGlHMm1V?=
 =?utf-8?B?UzE5QjdaM2RXZndBTlcvLy9QRmNCYnlJZ2FycEdkSHlmc1ZmaUMrT1pRazhE?=
 =?utf-8?B?R3cvWTNrdTRJVnliYmdoZW5KYldjcEFnL2c4M2djVVd6MWJlbmYxdTN1cEhv?=
 =?utf-8?B?ZjFZMTR4OUZ6VVZFN1pvTnZYaWdldTJRZ0R0VHpVcVY2UXFoZ3I5QU5LSVJk?=
 =?utf-8?B?WHVSSlBSMVNGajV5MkgwMW9iOGYxRGhCeWlNdXZ4NStrT1YzRDgrR214RGd2?=
 =?utf-8?B?ai9WTzlkZ0dEYWJ0YlQ5VWp2dHJFdjRRd0tlUUNaQjRUSUlkVVR2eFBWQ0pv?=
 =?utf-8?B?SXBCYlJnVHZkUS9yaEluM21NQm16aUs3NHpsem03bzhsbWYxMERZc1g1QVgr?=
 =?utf-8?B?blVTdEF6OFcveVNycnBkQ2ludm5ERmxlZnh0L01qVWpjY3EyM2xhSksrMjJE?=
 =?utf-8?B?d0xXeDgvY0dabkZ3ZEFMYW91c1d5UFU5T0pseXQ5eW9QN0poN0s2MlpCYnBQ?=
 =?utf-8?B?TXArVTlzbGcra2t5YnRPNFRuOWhReWszOGlQRHpOcHd2RU1yL1YwV2pSQUNo?=
 =?utf-8?B?Z3pSWDRjbzl4ZmxYM2FXS3g0WlBUN2VZSWxFRkx1bVNEMHZvaGRkcmNoRUNG?=
 =?utf-8?B?Nmc0RlhHbVJxZ2ZLcnBmajhJaVk4MCtpR0dINkNSNkdMOTNpTEVlOFRaeXd0?=
 =?utf-8?B?R2pmZWZ6bDNvK0ZtZk51UEJYT3ZIS2pNb2ZzQkRFZjZBR0RxN2gwSnMzeE9k?=
 =?utf-8?B?LzZJdWhwYkNvSUxxUTNmVHkxS3dTRVlTVXJHSys2RkRaNjQ1ZUxlMjB4dzVZ?=
 =?utf-8?B?Nk9yQWg2RTkzemxSWTRoVFdNcW5qVDYxbCtZc215RVRlWGs3THlKKzEwSzM3?=
 =?utf-8?B?WE1JdlA3WTdjMEFQbW0wYmk5clNubE9QK2s5ZWxIb3FZeXJENmtyZitnWnR4?=
 =?utf-8?B?SmtSbzJVK1pIcngxeHdjc2xNOUhkaWMyY2VtNlRoRkVMd0hLQVVVRWxIRHlR?=
 =?utf-8?B?TUFSMmVVdHZYYWFLZE5CTzBGbHVDaHMvcGZBeW0vTXZmb2xkUnp2aEdDV2Jl?=
 =?utf-8?B?dVBsaE5GWTUrQTRPd1hQOGN4OWZjTEFOODhlRlhiKzZjTmQrQzEvOEVKbTYv?=
 =?utf-8?B?cW5ja0U3YmE3UHdZUjY3MWRpZSt1TFFLUHVaM3ZDT3FvZzBYWThneG5iSlVv?=
 =?utf-8?B?eHptZU9HSXpxMHlsOUhxRys3Tkxic1h2ZVloUThOQ3loK2o5UEV1d2xHV3Rt?=
 =?utf-8?B?M3ZNVkNhNytjRk5pdUxhRFpqVEh6QUUxOWFyaW8zMGp3WUtIQnp1YlNBR3F5?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GawBFjg4RiTGnvWk+0noWPis6CW0rlOX2z6oGkFlT3gG3QgUm+CEUfQob68aSUseg0zhEOfrYKsH8jqXI49dhj2ms2yrOyyWYn/2Fq77NYTgT+2Zcp/3/8ZNrLTOeodANX7PuN1tqfQQj3ZTD4+0prEPJCsaZMWJFNq2VPRXA7cMRWSF9CgdtX5I7YA4ykHyn9DrrGE+KwsoQdr6aYQx1B3eNX6LVPYxoEvFFB3LeqZuUW2r2Adf+trAVA0ukxA9Q9ylVaZDNan1JgniVE8WmJW5MTElTHQ8c3LakAT1VbfV9c3dcCEFJu/If03cMgaQGNqXX1jfrFhQvVitY0s5HWMQQqxs4LHqwN7f3uxHeVl2jViPhoZ7u3Vfh9bRkx3xzN9h8QS96GF1NnQwqihBtRlswzBEtKb3vc1KEXe2b0x2HIftEUfGe1ZTAN7dIoidk7Jv2o5ZvJ/X3WBBUhwozCkR906i9cNN6daVw1YvxzsNyFPP8KGLZFfNY/ycA11/S5+onpxH3uQtiZzqrj1bOs5YhuaL3lO8ZhCLJ9Dknf/2nRTKMcgu+KmPhCxF8fr9g4XZjZ/NEzZbbHzexaH05jJeqpNvjZr1ox7BNJU9krQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be0ead7-970e-4a0a-87f1-08de283fedfa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 14:20:17.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7V8LWKOKNOFs34MOkpoNf+AaU++m63+XHZZUgYCTlSZwAQr4GhPE6K/MDiMvocIF3j4xHfrmn19bK40HuFZBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_05,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200093
X-Proofpoint-GUID: GxRa_idZiY5jEDlj23eqtyz2WKStmowW
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691f23a5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lELW0XcdvlkGBX31ot0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXwv1fJrGDbaUx
 aq8w+fa0M4+0hUIQj9LjLk/j98PXB4pR0nDytnrUcXkLlMXSqWyr3IVJ7c/rXBb9zA3XLdu7GFn
 qgVXATBLcPmDIRFhEUBhrZTqGFk8SCsGIq1nsT4RVoIj5+aFvqXv7I01bVmjWLB51K5H9PVFB9K
 62HO43DM14Vk2P78GnnJETflfXacW3M17Wp7ClM3k1898+84qBdAsLsXni/OHNi9vtEnENr9M7I
 CY65CfDsu9pN4j4GhcXVDO6LFgWINjNtvNMPSqz4jnpjZ7kACJVkNZWP5fABtsc9GtGiZahUxYI
 JHGHpuwDVTduTxtO9yw37FCZi9wygwjI/Ewfpf2FQKS077e7vRIGT/qnavcFX0AwPPYIIT+6mnX
 W4uNa0fzMbiz+GT3LqK/l6SrRYhYYw==
X-Proofpoint-ORIG-GUID: GxRa_idZiY5jEDlj23eqtyz2WKStmowW

On 18/11/2025 16:47, Bart Van Assche wrote:
> On 11/18/25 4:07 AM, Alan Maguire wrote:
>> hi Bart, thanks for the report! Not a know issue to me at least; I tried
>> to reproduce it with pahole v1.31 + gcc 12 and no luck. Would you mind
>> sharing a few additional details:
>>
>> - compiler version
>> - pahole version
>> - full .config
> 
> Hi Alan,
> 
> My answers to your questions are as follows:
> * Compiler version: gcc version 14.2.0 (Debian 14.2.0-19+build5)
> * pahole version: v1.30
> * Kernel config: has been attached to this email.
>

thanks Bart! I've reproduced this now with gcc-14.2.1 + pahole 1.30 and
it is also observed with latest pahole 1.31. Investigating now, but if
you want to work around it in the short term, disabling CONFIG_WERROR
should allow resolve_btfids to proceed even where duplicate types are
present. Hopefully we will have a root cause/fix shortly though. Thanks
again for the report!

Alan

> Thanks,
> 
> Bart.


