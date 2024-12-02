Return-Path: <bpf+bounces-45936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29369E08FD
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 17:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5B7B24D47
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5F209F46;
	Mon,  2 Dec 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TiMUpIts";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cUAEEjm+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43D2036FE;
	Mon,  2 Dec 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150098; cv=fail; b=SJsaw3i+QuQIK8xLcskFvwM/KYt8zhf8O6t8TycDCoB/wbhh9CcwTpGYFEAiCHB/GWwqy3zwETGGKavl5cTIB/8vN6XtFhUMym++3lEqb0IlisdWrz2xk5nQTct7BgkcU7jcmqDb6PrzTp4WFuw5VtqHKuLRorWGs+qe+vI+bbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150098; c=relaxed/simple;
	bh=d+SoxhkW8f8uE0l48mGNLT8WQDqrIdWIpOTzO2NO4d4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qKhG0/qiUF4hBYY6lvMQ2uC2MUDzoyk9W3BBzO4vOIpLqR62M2a6Umhud+EptWn7gBnrdyf7HW7WtSum+3kiGiRHHWwetD28WygTy6FRrloglpTYcabp2SRFpgmRxWGXTujNJLhnDMQl/hfmTxj8J0BYtNweFKdB43Q0++pWqhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TiMUpIts; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cUAEEjm+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DOvID012253;
	Mon, 2 Dec 2024 14:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=se+Gm1byjJBlhjhmHeJLKywVHoOAasSeUfPisZXQthY=; b=
	TiMUpItsyZg1XK8bJ7LfejawfSbLyVlab/kLAZ36EBu1AjaIJyecS5AD3Cvhb+aU
	JkQXqOr5ZegR0EB1bkS3N77kjvqBzOKsi+R/DHbcU6ECtdvLdKYZoPfAkKZFT9zZ
	ZULwHuii2bmQoYnWLag182aDxuYOklOVLJaP696WTWMQE9/oX3MwhqXmsYYs5U9M
	Dq35fmPj2UVo07pV8LM21oaTChjvFeQlZ6el/vTcm56W/0DuULxH7/6/OwgKW3QR
	F3pHZtulLUCNZXEF6uRubDorfsoiNwf7pP+ns1CrqU/koOXP0dNmzh20uJ1mGCmN
	F/rYU2ljy8bgqWNy7xOXDQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s9yudvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 14:34:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2D4X7l000934;
	Mon, 2 Dec 2024 14:34:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s56mwvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 14:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6YkbdK5DFREEguHnSJP+0X/LYj8KxwTHmCePrPQQmk38B3ojRiglkryucZFbtH0e+jZPQNBTQCPYsx7PvqfaAyL/ruOayFr02JJrDNumMNsClsy20E/TgfelnzpVqkmloAXE/OSaCJOJRFvWw4tsZRxHSCZjVPPmBzCZ1wjCRbxA0UyquKj5aH/IhHR+6iwIlpFhHIQvXfsMItj0RKs29g91w3ZcPl8Cqk/8apT1rx8IGSdbHAu+Bv9n8Rc/7EvZXXdmzAZQFpo3G3+2NO8QM1zNKketWJ2Qux8ks12QGCvKez0pbWlTdb7xGT4MWndo47NdKqEmR9//ssPi1kkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se+Gm1byjJBlhjhmHeJLKywVHoOAasSeUfPisZXQthY=;
 b=piLmtfIubh2k73TL8hcz/hR2v1PPWamk5x/qg1pgGXs6lfMac/IFR1J/akZZjJ5FGKFbepcyW1AwZqndmuplwapyvmIWi6Z4vQdTFrobd63o58wcX1G7X4SfdjNva3eRK8CCsTgUx6lmQnOMKXWfCoUnU658pbfp72DvyDcRGhblBcP90p96CmnJE9UCC5w9NSCgF6oGz06ZDYdfUNtgnLu8jcPk1SljIVAFJvGkofs1e5hZYNbDRGIPGwuxJCxJmc+kU4Dglex2sfEGsYTxz7cjTV09pCegUW2tXbshL6FbE5r0mRBf8hwmDHzg1Ij/zgXS9IJ0cZXbyReSXOscSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se+Gm1byjJBlhjhmHeJLKywVHoOAasSeUfPisZXQthY=;
 b=cUAEEjm+QJAIIVUMWcbq7no9CbWx44L3oFifY7SzvPapbGfVWPRb2pCKmrVLwXCgLyx4f15+SPE2HfhKrsvx/26ZOGYmzbMxh1IRpkuJ3zzYlqy/OuB49ZKHU42EgxQxyzjWq8nIDyoEhEQ+tXaHHuRQu3q1mRUiyLYbVms12QA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB6415.namprd10.prod.outlook.com (2603:10b6:806:25a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 14:34:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 14:34:41 +0000
Message-ID: <d693964a-053d-418f-b34d-d652b8712508@oracle.com>
Date: Mon, 2 Dec 2024 14:34:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/9] btf_encoder: store,use section-relative addresses
 in ELF function representation
To: Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@pm.me>,
        dwarves@vger.kernel.org, acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
 <20241128012341.4081072-3-ihor.solodrai@pm.me>
 <60f195235812389d44c009a7fd97a6a12aa48b17.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <60f195235812389d44c009a7fd97a6a12aa48b17.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0101.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c8022e-554a-4a86-27fd-08dd12de74a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amdaTkt4bTVIVUk1VW5yb201TEpNMlNqUW5ScCtpMjZrdTBzYjRNSjQ0VUFX?=
 =?utf-8?B?OFpOdFFBTDZSRlozTFBLdXU0M3Fvakgwc1RRZ3NZemZNVVF4OEs1NUFMMUJk?=
 =?utf-8?B?YURlU2gyWk1QWTQralQyOEE0K3RiQllRVnZDZ29xdVNDcTFTNE53T1RwWitR?=
 =?utf-8?B?R3dBNE1KRW9HM2c2Zmd5YTRQdkU2YWpHYWk0WkxXRW9qL0hFRndVMld0ZTVv?=
 =?utf-8?B?K3ZZVVpUT2h0NWRrM0QwMWRXRVJZVFBMelNDNk1PL2hSWnlvanJIQ3EwQ25Z?=
 =?utf-8?B?di9DV1dWaVhJcW1ONy9pWlZCRTQ5b2xCTDJ0aFVYeVRmclhVM3JoQjlDNVMx?=
 =?utf-8?B?WE8xY1QxWWJ5Q0tMUEloZmdTQXBLUWFBdlZWSThjRzRxUENqUEk2QXpaMW4x?=
 =?utf-8?B?RFZIbTlsWUFxOHBuWUMrR1A0NHIyUklsRzZQUWZScG8xSDkwcHBOYTNxZ1Yz?=
 =?utf-8?B?ZEIrMXhrT0trMkYwemFqY2dtdnppYWQ1TUt0eXY1c01wdVdKQjZUeHBlbE1h?=
 =?utf-8?B?UkZseTVzdmh0cVdNUW5lc2tGQmtzU0ZJM3RERHZnRTZLRFNkU3dtRkg4ZXc3?=
 =?utf-8?B?Y3ZlN0lLcjllMmxPR0YxVGJ6NXNTd01BWi9XYTBvYzMxRGtNOWsvVVZOeVBO?=
 =?utf-8?B?Q1NLaHRva0ZZQ0RvdXJSeDY3SEpVYlRRQVZqd3o3bGhXdWpOQWZjbENaaXJr?=
 =?utf-8?B?UVZYZi82eVNmL2FsblBJdGxxL0V0ZEdlOHNTbHhBbEZYeXlaWWM2UzdzbEFN?=
 =?utf-8?B?MlZZZ0ZWSWtkWnUzdW0vbGxYZkJOOFRZR1ZWdE9CVmJpMWlTYXZXaXg3cGE5?=
 =?utf-8?B?T1lHWDBNUmxaQjNDL0t2Zk1TQzhjYXk4V3RteGZxb2loaENRbG02WmVLNVhi?=
 =?utf-8?B?VUNtOVlXaWlyeHVuRXRrL1k1QlNuRi9KVDRVNGtFcFROZnpWbjFucncrM0I1?=
 =?utf-8?B?M2p3ZXRNR3p0OTJQK2V6UHZQR05mRWZTalRLZmRIQ3lueVhVQWpCdDlDc0FU?=
 =?utf-8?B?MXRzWUJKSlgwU3lxS1Fselg2S2hPWURzM1QzQzlkUElGcTdaREtPMmxIeEpw?=
 =?utf-8?B?dkkyeHdMMGh6cTVUOFk2aW0vaWs4ZGhrT2Rra2FrUm5sdkhSOEVNUUtGa0Ru?=
 =?utf-8?B?S3JZSFJNTHZLajd1TTROWE9BZm5RWTBONXB5MzA5blpvS2gzOHFCTUFWYnNV?=
 =?utf-8?B?WjRWUTNEeFB2U3FwMUpzQXhaR3kvSHRYNGtjbWpDWWNjUHNvdG1jQ2xhSU9F?=
 =?utf-8?B?TThBb01wU1NkcDJmdEJWWjZER2txLzB0WXFXdGdsVFVBMDZhTG8rUDF2cHVN?=
 =?utf-8?B?dmJ1TitvcG5YNEpiYkNHNkRTM2d5WnJCWE11ZHE0RjB3WGkwL1VNMEJkZ25U?=
 =?utf-8?B?Mk00NFhKbVBrMkhOSlVmcnB4U3VWWXZKOE1Qb2xTMmVPdEhxaDV4cmxvQWZJ?=
 =?utf-8?B?aWN3dFQrNjNSamxSNW5xK0x5eXZEdEU5emRMbkYrdFJhNDgwcVdTTkpEeExn?=
 =?utf-8?B?NDAxK0ZMSStIWSswVFlXWnBRa2lEc0puQS92OURrbUJaTmJQdmVabUg3MVkw?=
 =?utf-8?B?NnNzaXdlMmF0VmlWbzRCRXVzWVIwYm5Ic05HTXNCaVBjT3JvMmhMMWNSOVIr?=
 =?utf-8?B?MmlUcUNCTENpNnR0S0haejdrQWRXSGRHQzN6M3Q2MnlZRFp2c1lGeVUrNS9p?=
 =?utf-8?B?UTB5UnRzVGtBYjRpZEpxTEcyaFJLdFQ3VlJIODV2TDc3MzJhTHZndnNwM0tk?=
 =?utf-8?B?Y1hiUENzZWlqOGIzaG5MQndwR3p1dTRxTUNZU29yenFkcFIwQjF4b0RtOExV?=
 =?utf-8?B?VHREeS9icXNPVjZmbUpLQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2E0dzZrNm9LRUVITDgzK0xmRGNHdW11Ykc0TlVlK1VZdDBTNDZ1WG16eWpR?=
 =?utf-8?B?MEp4SmZ2aFhKa2c4dFZQS3Nrd2psUFpuMExhVkU5ellVZDRwU0dNbzk4endh?=
 =?utf-8?B?M3VKRXZBbHhNcUhzUkR6WEZISVFWRC85ZmhKOWtpZXhtQ3pWVnNUbS9BRHov?=
 =?utf-8?B?MjBhOHhvUTI4MTZjSzVSdno3Wkhia3JmVDJSSHUyNDE1ZnlYR09iMnNZTmV1?=
 =?utf-8?B?VFppb2NieEtycjExR0NLN042U2kzQml3NnNQY2FwV0pjMTM1dlcxellLeFIr?=
 =?utf-8?B?bTJZUzVzT2s4bWh4M0ZQY3dqNUdKTS9lbXVyaW9ESXBPcVhaWkpRdmdHRUE3?=
 =?utf-8?B?RUhpZzJkYkZ6SEVkRCtnTm9leUhoaUlnSGJiY2pKd2REVE5XMktZWUp4M1dT?=
 =?utf-8?B?M2hYWTNGR2ZIeWZ0Y3VqSzJNM0VYNjdmWE5Qdmc4L1FGbjhkOXY2M2pDTWl1?=
 =?utf-8?B?TU1PTXJRbHFneWp3RjJEaDVwekVYeEZFZ1E1Uk5OWUVsSjVZeWVUU3FBMDF0?=
 =?utf-8?B?SUgzMjVNUlQ3cDdrWk9KU0FpWnBvVkpuYXluYysyeE5vYjZSbG82bkgrc3Zq?=
 =?utf-8?B?d0hpY0xNRFpKUmg3bWd5VWc5TThaV3pZRzZHWmhyR3ZlNUZROWU1eTF4V2xU?=
 =?utf-8?B?R1hSbTRTelN2QXNoYjNQK2FxVmFpMFNrUUtyekdkemdIRHZsN08vMiticTFI?=
 =?utf-8?B?VkJOdzJuczVHdGY5eVFoNm9RdmlaU1lkakRoVFpoTkRSb202ejQ4eHFQNzRL?=
 =?utf-8?B?amJtRW1RR3BWSXJyek92UktHMEZiTkh6MHBkZnVXQVBlUzZtdStXTDlGbm1x?=
 =?utf-8?B?MGtnNzgyL0NhWXY2ckRXTWFWczB1V2pwRWtWRXFzdzdiMERQYVEzanN2cStO?=
 =?utf-8?B?RWUyZnYyTk90VVhBazRkZXFIbFJHcTA4bDkxb3hjQmV1QzN3d2pzLzR0b3ZN?=
 =?utf-8?B?MDMzcnFUWmQvaW45VTZaR1cwd3ZGMHV0STB4TnRoclBoaGFiS0dYZExBUzBt?=
 =?utf-8?B?QzNCRisvdGNnd0tCRnRvakdFZ3pGMUxlYU5tL2I4MDJnWDRJRU5Wck5zMG5R?=
 =?utf-8?B?S3RPY2toa29EVFNrenh0VUpoMEFQcXJwM2xJeGNQR0hpUFAyV1lHOHlmQ2l2?=
 =?utf-8?B?ekRCWUNVZ0RJaFFZR3dYUi9adnpyWGtUQnZ3SmNITkRHWVpFZFpRb1g1dlVH?=
 =?utf-8?B?NUI4MFp4V01jMVF4Z05tRjdrLys5eWd2akRMbW4wN3ZIT2huR2lhYUVCMXZI?=
 =?utf-8?B?WmJick1MNDF4YmZhMnhQTWcyOFM3MVRBa0JkT1EwUURqOU1xTzdwV3ZCODVH?=
 =?utf-8?B?R1c1TnhDZVIvTCt2cnB6TDIxUHZhdkhiNlpXU0xqSnhGTlFOditYVzFhOW9o?=
 =?utf-8?B?K1JPbjc1RVc0QnlyMmJvSDR2ZGNxVWdSSHhlWWxCdE8rVDFsdTlFdUJrV2tq?=
 =?utf-8?B?TjhxQzg3bHhYeW9YY0NYYmMzRm45MkQxWk9jUFZNdHpHMjRNajVUdDR2dU1M?=
 =?utf-8?B?V1ZNMHJoSElwaldKb283a2NDQnJOV0RWeWdFTWxkVGs0K1ZJcnVlQW5rd0dH?=
 =?utf-8?B?dFJVSncyTERRY3VPVU45Y0JwS09QOWYranVrYXYza25jTkhEelJzcWVEV0RM?=
 =?utf-8?B?R0dBZ2txay91UHBIeGlsTHFYcGN5dThGVEJ5SUc0aU5OcG5aWHlDaWVySDZE?=
 =?utf-8?B?WGMzZThNT0JUMFBpbXBpQ01nTzdybmRHZlp2V1lKQzBGU1QrV0sxTEwwSVA3?=
 =?utf-8?B?N1EwTmJRbVMxZXRzSTd0U3RoUDJUUmhyK1FaNnJLUGRPV2FNNTl2K3pNV0R5?=
 =?utf-8?B?NjRUNFQ3TGgwTjRGVTE4M1dsSGI0TEloQk4rdTROcTVvRUtQbm9CbjhJdmF6?=
 =?utf-8?B?Y1FVWVBWTlVFUkQ1TXVTTG9ib2pkQlJtNXFkR3FKOFVrdVowd1NiNjc0bVh6?=
 =?utf-8?B?dml2eFdYS3d0VXdSSnlLRW4zMDZ5RHRTK3lqbTQxZDhHdG9sN1Ntbi8xdzJE?=
 =?utf-8?B?YzRxd2M5UzJPbFI1dWRwaHFIcVBYWmVNNjBMSk5CbHhUeHBDUDR0NUlqNTBT?=
 =?utf-8?B?RmpLMmoxWVgwN3czMytCMmRsR0VoN3NIMkx3UGNqanVDcm5BSS9pZGdFSlBl?=
 =?utf-8?B?QmtHa29KR2hnSFFsMjZtVHovOFE4N1lSOWd0V21TZ3FrZFB4SFduTVhxRkhj?=
 =?utf-8?Q?/KrpNnEhSveZjldravTKQ5I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CF8rtVrOmiD60VUNtTf1OchZthlOljjEEAAm5mxwEQM5KPwp3xjHE1kk0Ym7ww9Wbbz5LlWOejFATR0ClfJHyJoEUy1puGzkR7nsPeW7UqO7D6mh62bXj/k7y1FrYrGbMx1eG9dkxkAEEfj3aNuccZmuOhBskjoS4FdSJk0fqsLD3snCC3TksNCXa3iNi7IRBHo69/wmq6gMdbJL/2yqN6QvC/uXezv/Qp1T2fP59C/mSQaHzgLV/IctOli0nFFLRDRWpbiBb1GF34D4lh1H3atB6SCpFTsZyEbNsILrIOO4Onu/sdy6Ay7PS0trFUwIIqXfXTHhmSIENCk9lg+rAVNullyfKVA/ofugInKMMxqV6jC5YVWOJsfj9mPcCWIZOgqfcHBk3sugvDHhGo8XQqUJitn52fto891sDDtcj5ATquuza975nlaUBFSUEMMDDg/3q7eloIKXZVSdNBjqqCKeIBiUHHpyzZ+Oc3YfxYAq++VZ009FNMNxGjUhiqabfooeule5gzMIAM5we2jvYNS0VH2y21FZzy5BxQQXvInlG+/L20/gOw2ldloAuuYJ13ESdh8TBBuXPaNSJrDGT8ZN/cokT4P6xuLcDuuPBjw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c8022e-554a-4a86-27fd-08dd12de74a6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 14:34:40.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m90F8vwCEItfB3mLCrg8hFXJcFJ3yPtq1xJlDVxKh8zzRhRaDSpLBKG4ZyZ9hm3zxmMlB9G13RHrzkCwFo1GSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6415
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_10,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020125
X-Proofpoint-GUID: ke7jP7YvB4-J66PZxbpA6hFGkJdzBS9g
X-Proofpoint-ORIG-GUID: ke7jP7YvB4-J66PZxbpA6hFGkJdzBS9g

On 29/11/2024 09:07, Eduard Zingerman wrote:
> On Thu, 2024-11-28 at 01:23 +0000, Ihor Solodrai wrote:
>> From: Alan Maguire <alan.maguire@oracle.com>
>>
>> This will help us do more accurate DWARF/ELF matching.
> 
> It would be good to have a more detailed explanation here.
> E.g. number of generated functions differs with this patch:
> 
> # without this patch
> $ bpftool btf dump file /home/eddy/work/tmp/old.btf | grep "\] FUNC '" | wc -l
> 48056
> # with this patch
> $ bpftool btf dump file /home/eddy/work/tmp/new.btf | grep "\] FUNC '" | wc -l
> 48189
> 
> It would be helpful to peek one of newly added functions and explain
> why it was previously excluded.
>

I've also found the opposite situation; that some functions are not
present after this patch that were before. In your case - where more
were matched - I suspect the extra address hint allowed us to do a
better job of matching ELF and DWARF such that we matched .isra.0
functions that represent actual function boundaries rather than .cold
subfunctions that had different signatures. I'm working on a respin of
the initial patches that ensures we get the same (or more) number of
functions, but it shouldn't change substantially anything that follows
that Ihor has done.

>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
>> ---
>>  btf_encoder.c | 37 +++++++++++++++++++++++++++++++------
>>  1 file changed, 31 insertions(+), 6 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 98e4d7d..01d7094 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -88,6 +88,7 @@ struct btf_encoder_func_state {
>>  struct elf_function {
>>  	const char	*name;
>>  	char		*alias;
>> +	uint32_t	addr;
>>  	size_t		prefixlen;
>>  	struct btf_encoder_func_state state;
>>  };
>> @@ -131,6 +132,7 @@ struct btf_encoder {
>>  		int		    allocated;
>>  		int		    cnt;
>>  		int		    suffix_cnt; /* number of .isra, .part etc */
>> +		uint64_t	    base_addr;
> 
> This field is set, but never read.
> 
>>  	} functions;
>>  };
>>  
> 
> [...]
> 


