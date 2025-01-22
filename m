Return-Path: <bpf+bounces-49467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553B5A1902B
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 11:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB7E1889538
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 10:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C211720FABA;
	Wed, 22 Jan 2025 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LEu2kyhq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pLgiOmr+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD682136A
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737543466; cv=fail; b=gd3Z9lUo02PdBttfiUdXMlXW44iNjxnxNmC6otD58rwWkMfd4Qx5qhSyM57e03OHiMb0+0hEpIo0QhZlzwiUyxrdYTTCY8yr7Kd3n9yUJG2zXwcwxWDovrxMSxlYdpaqCfp0BKuKHFxvgTwfqgLmTZMD0ZzfC4KRTNPJCn2hLJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737543466; c=relaxed/simple;
	bh=8n5ZxqKPqe2CBcgsHUWffMpTYSwdt9VNrM/hcEYFm20=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XniULIviegREW3wo8G9XpL0AIO+COFcyV8xorbt26EcoISFjOOwAmoL7g6PGSHtYG563EmlylHkVosdfpJmB3svSpMEOgTgdM7SBZWpaUHOgApElTYFbBfoVvdompxaG1P82v+5eXZ5dOPBxunErcfJ2p4kv1cQZNYbOAB/Q80A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LEu2kyhq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pLgiOmr+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M9DE0E001839;
	Wed, 22 Jan 2025 10:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=52z1V/Z93F9/Jcpp8imrqJ2oCYstNwkPrvFvlMYwovo=; b=
	LEu2kyhqRhTEo/BAzud1NXL17XU4YXG8u2owAH7pCLceNLfZh9q02UtXSBpFRHNL
	2nkK+Xrx2cAlxN7xZd+jMzQytHFL1Klbw7WBX+XR406oNYgywjtON1vqO+J2TguZ
	rzz3IGp3GcNwhFryg7Xc7cjNedoKo+aiv9FUT8a4IfDWQw3ETTvw9WAx63nbFN2S
	8ZEaAejaC+WaNkbk+VvW8G6zze95q3l41rnif9CEwIpA4hAWfGVZWOzr/X2o95Hs
	44eswYdvw+a7YEom4l8ZEXHjRGpZwagvccmF7+QKBF9oLAsAi0tE2jusP0R2BRor
	z26+G5WYMtGcrcd1pGWYTw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awufr643-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 10:57:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MA5pIq005537;
	Wed, 22 Jan 2025 10:57:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 449195fuk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 10:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WD41zxHw/HffAT9v2cPHnUAI77g6gJ2/hNOYnIbew/iCaRxYmWFmXxhBDldQfTXNlYhKl0SQMbN5d79cN4ZionDIPcY+qSFoPQ5SroywwmyICuYBXPGAUAGx2ilxY3nIwzAsT4pUYcH6nWuXR7HPk8Hyxws/EzDA4lPpXRQTqs9iP5FinMIqyNvcOEwMHrtm0Eve44NaqzY8jmRYCocPPeq1ufnwQBEEaO3mkMlrEU2NVUZWscFDRnQi35hfx+kEwTpVfIUlPWis2e7QrmjJj6673OVtv2BxtSwCMuk/8jIA8J5uqEUlLXumTDKOL3o4COiZDavz7xSh4Qf+0+AIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52z1V/Z93F9/Jcpp8imrqJ2oCYstNwkPrvFvlMYwovo=;
 b=MUvokmgpQt1bfkN0CD0Y2DUJcBm4m10jB0mDhVd9FzsOTDS3ntKlG1k2c97pdvwqfprilpWIYQsZXNtqNj6UxGn+/fWyVJSwtpwwqM6k9yfC6AW49Qr2NLkbh/nisO3MO0+vHVk3icbduV4cmcSQJWgAaHsvtegY/ub88T2H/Guprp6kCKIQiDj/Ytt77NtPn3MzlmIEFtDV2YZD21lQsagpsVSG0pTHZ9D48mDE7zbJ2cmjoDU1t0UQ6nwwikO1xkAwQTiiSAuHUhEWdXZs7MhtqcHQ52Qg31M8CPiDoFAvaE93/nMZng8lN3kyMqcxP5Bg/fchmM7hKCNHW1M1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52z1V/Z93F9/Jcpp8imrqJ2oCYstNwkPrvFvlMYwovo=;
 b=pLgiOmr+mWx/VrzBwbAzZF6dtou9r6OO8yFkeBlIT1YQx7+Pk1XX+F6aHMjb2CLP3lqBZL1x2Ac6u+nmVwnYkJp092mmUKQBiAfbsbH8xeSdQY/DHNMzCeOu0zSXjKlUUNNtAzjx2ySnKJrizaGfN6PDSPCWaAsRCdD88u+DuoU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO1PR10MB4593.namprd10.prod.outlook.com (2603:10b6:303:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 10:57:21 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 10:57:20 +0000
Message-ID: <6aa763ab-35fa-49a5-970a-0bd28a167daa@oracle.com>
Date: Wed, 22 Jan 2025 10:57:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/5] libbpf: check the kflag of type tags in
 btf_dump
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        mykolal@fb.com, jose.marchesi@oracle.com
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
 <20250122025308.2717553-3-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250122025308.2717553-3-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO1PR10MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9edfb0-1c5d-449f-5159-08dd3ad38b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmE5ZXVjNDAxUjlxQzBTK20rd1ZOZFBrNDExcDAySmV1M0tNdjRMSXNCdCta?=
 =?utf-8?B?d2VlRDJKUjJXTXVQVlkrbFptRW81MHlSa2I3K0hVNkhTYStxRldPMVV2T0Qy?=
 =?utf-8?B?bVpQdDJTOVhkZzA0V2tGQkcxenVzMkdFOGZ2OXJNcnFLM08ybmZGYlV0SFRv?=
 =?utf-8?B?TUFTaHZabkYvOGZVYVl1S1NTb0pTdERtQ3JmaDB2cW5DcG55OFlQNllXcVpk?=
 =?utf-8?B?VWQxVGU0bUFaZzZoYVdCdmhPYjk2K3FiaUxFWWhkREFPazhqOVVSaHc4bHE3?=
 =?utf-8?B?bmFTKzNRTCtBaWF2UTlTVVo2eDhZelJoMDZJKzJ6Y3NJQ3NhTFFZaTBHUjl6?=
 =?utf-8?B?T0h5NGpoNmJyNFVFZVJTU3RDaGMzM0FQTU1aWU1QQUh3ZWlKZmhiSEtYOXNm?=
 =?utf-8?B?cThTV2p5ZUxLQkRVOUNPaXdid2lHY0FKdDYrNC9nL1l2OXdrZ2w5N25Panpw?=
 =?utf-8?B?UmkzMldNelA3MitEcER4MVRZcWVZQ0J1N3pkbW9NZHprbTAxcHRPTFh3Nlpz?=
 =?utf-8?B?a21EaHhKdFRkWmNuR3R5ZDJZYmh1akEzRUdOVEUvQVIyNjZTODg5YmJHam12?=
 =?utf-8?B?dzgzelJDb1V1RDQzTWs3TzdZUVBsbEMyQXB3M2t0VzN5S2hhb3R5TmtiS0hQ?=
 =?utf-8?B?VldzYUZqRTJQU2FEd0U4UnBoazJRbk9KRXNGa2pabzhmeFRMeU9mcDFsVFRx?=
 =?utf-8?B?RlRTV1cxdTJrTUhTdlp5OHE0dG9NSUZsYW5lZkVBckZRbjJLY01sU0gyeFEr?=
 =?utf-8?B?elFTRUlvTzJrNi82eXpwOHM1cXdVMXlKV0JlWmxielB6aytJNlZuaVc0amJ3?=
 =?utf-8?B?a054emhUWisxcFk3T0FoYW1rQm5pSnIzMVc0UHJWSDd5TDA1cDBZdFNSOGtz?=
 =?utf-8?B?WW9lOXlkV1Y4ZHhKM3o2WlhpMkx0R09WSjhnVlFTek52SElqWDdHeFpWYmRn?=
 =?utf-8?B?TjFYVzZoUjV6WHFRSFpSUEdNKzRSMmdPaW8xWnBWRnV4cmVmQ3Z1MXo2L3JN?=
 =?utf-8?B?WVhVWldMLy9kb0k2VTFPMk0rWXNiTDZjYmx3bDhyc29GMXpvVUFDWVMwNXlT?=
 =?utf-8?B?QzVmUEFkbTB1OUpnK2FXaGNWeUp3MWs4TUh6MFFQUlR2WFhYZDJncjhFRmQ4?=
 =?utf-8?B?Z3kxQ2VNR1Mxam1XMTl3RVlXcCtocWlFL2hXTldZN2ZoSXloalVpbDJnRWxa?=
 =?utf-8?B?WXV5WXlvRlNhUU16V3QwSDNMb3A5TG9nTzlUNXVwWVhKS3NqOGtnV1MrZVIy?=
 =?utf-8?B?U3h1d1dnbnMrc3pRNUpvWWNOVXFZQUcyU1BPTWVWbjFVaDlTOTdvcjh2N2xt?=
 =?utf-8?B?dExrY2x0QjZiNXBnUVVxMGhhUG5DbDRaOVg3b0w0bG1HUys5RTF0c2ZvYmZq?=
 =?utf-8?B?NXR5WmprNFpXS0lGNUZ6RHpnUjM1cEtkVjMxUzY5QTdiYkFFSGpydFh5L253?=
 =?utf-8?B?UUpKZk8vQ2lIbmo1eVl0R0xlUkF6N2xyVm1OTXN2NVpxU2xiNHJDdmJTeURF?=
 =?utf-8?B?NVcrdS9Xam9HeFZYUkZMZXdOUzlxQmhCbkFGMEtSQVUvdFFmYjdYazY2Z0Fi?=
 =?utf-8?B?UHk4clZqRDg4Y1lNS3hQUmhORWM0c0NSc2ZjR1VPVzc0Nk5IMjIwaU5hQmpN?=
 =?utf-8?B?ZHpWK1AvK21BWlZHUzZtM2hGWG9PbjN0alQ1WGt2anpVVlNFa3NYMmdta1Ax?=
 =?utf-8?B?amczSThtdlg3SExrekpTMFZMZzJkanNwSDBYbXZwRFZzRzJVK3pDRGZuVjh5?=
 =?utf-8?B?RlpmOXRJRG5qaWU0dk91M0VqSzN4cHkyWCtaTHYxU3dMbWRSYkdKeUE4b05h?=
 =?utf-8?B?Z1dZa3dwaXRNN3NKTkRDM09SdTc5T2Z1eDFxTC9aN3ltUGY2Y0pxeXIybzRW?=
 =?utf-8?Q?kuoj/soEWm5X9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzRlVE44UWNxVnBtY0JpTHZoQnNDd09ZdlJBR3ppZ2NwbE9GMWFZSkhncC9p?=
 =?utf-8?B?K2FlTVN0L1pZMmpXYVVyeEk4em5hTU9OYnQ3bHRMTkxNN2YxcEN2NTVLeWlX?=
 =?utf-8?B?VHhzQzZGMTBPY3lLYVFtZ2VKQ2ZGWkxmZjlkNjhZSEJ0c2ZTN3BjTjRENEpE?=
 =?utf-8?B?WWJpUUpZbXE0cnJFZTZIamg5VjViWEFrcXVWRkZMZXNZTStBVVdRcHJURXY1?=
 =?utf-8?B?MDZ6TWRDcFNZSGpaUkJZUkY2THBRcDdYbUJGbERSd0pUVDFxekpBUCtxR2pC?=
 =?utf-8?B?bkE3YkxZVTNzN3NQdWdNOFNzay94RnFROENCb2hHaTdOajBqTzlPSFJHOUZX?=
 =?utf-8?B?Qm9NQWY4c0RSakZyejdJR3h4ZVJBSkxnSE1zRGVrbmRDanJkNFY2eWlBaE9I?=
 =?utf-8?B?d2tTTE1rMXRYNGFlOXR4cFdId1hmbm94eXdWMVhTVHZpaTV3QisvWWJuRTBo?=
 =?utf-8?B?UXJGYmRjdGxjUFU3N2NBSVRJZ05qRDVxaFBnVFJBSU9BakxvazY0LzFoTzFP?=
 =?utf-8?B?MSs3Z2hIOE56T2phZWxwcUNORllCUW9HdkFhendOS1RheE14U2xTUlFEL1BK?=
 =?utf-8?B?aStEUkcvaUp0Zzh6S1pPV1NtUXd6QlJaRllBSkpKVWlPZVFaOHZRbE5iVXky?=
 =?utf-8?B?SWdZbDZiRFV4MXBqUk1HUzc0NXdYOGdmR1pnVzVXUVVuVnlwM05TdFBxbDB5?=
 =?utf-8?B?UzFiSzRpRE5mTmxCRWoyT2ZLbE42L2lDS3BWVEt3NHlvS2ZSK1c4d3JPeTlO?=
 =?utf-8?B?VWhtQTQ1MVcrQkN3UEN5bFpZUStUZVRXaHc3V0NCSlEwYjY4TGtsZUVWWWJu?=
 =?utf-8?B?QTg3dVdDVHYwUWFpMVZrL045YlFGNzMydU1uN3NXN3VZdjRNQkpRNWc5akRB?=
 =?utf-8?B?S0RycTJUZGRseXk0ZkRJVEZydW9XRVhDSUZ1TkNoV2Nhdjk3cXM3RzhsOTdG?=
 =?utf-8?B?RVBsUFZXSG1MbG5oN1ZDSDJEcGlRVDlUWkR5cllwU1N2RktvaVJxNFlVNk5r?=
 =?utf-8?B?MURWekpwQmhjNkVWY2VndnQyTWsxeTVUYWM4M2JQWWZJVElwV040QmZIWitr?=
 =?utf-8?B?WHN4QjRQZm1TMWlIVjRzazhTc2tBOU9Oem5ZcHh0cWZRV0lvL0Rmb242YnN3?=
 =?utf-8?B?bStmTlRwREhzZFZNcG5FQkttc25ZaUJPbW0rRUViRG1DbnRVNlJLZTFmZmRu?=
 =?utf-8?B?VG1DMXpSL0d3c09aMWthWXpwSEpNbk1SNWNMR2cyZUtBMXhWZVM4SDZsb2hz?=
 =?utf-8?B?RVRHdCtrZTdyWWorbElvaHhnTFRkdjR3Ukl0LzhWT2RINFc4OGJzNExuSXkx?=
 =?utf-8?B?YjNSa1NINHlNN090bDFBcXBQWEdpY0U2dEJRbmE3N2xVZ29aNGhOaE90VklX?=
 =?utf-8?B?c3A1SUhrTXZMT0tpa0hLcGZ5RkEvelNZM3NWenNabjcxOGNPVXZoSzEzU293?=
 =?utf-8?B?ZGZBeVB1NkFkU1N0S1ZHbnNvQ25JTm1xeEo2Si9jUmpkSWJQQkhSWEd3MkVl?=
 =?utf-8?B?dWc1Z3RRR2JleSsvZTIrRXV0WHI2V1htRmJkeCs1Wm53TVJqbC9YMSs5ZXZL?=
 =?utf-8?B?UGpSZkVGM25yV3NmekpNb0VIZFdIVkE3NW5rb3ROSXpUbmhHOW9qUkxoejVr?=
 =?utf-8?B?dzZ5aFVQbFp5REVGbFQrclVFZVZBRis0Zm1BaXV1Nml3TFMvdTRHWS8rUDJX?=
 =?utf-8?B?enVHS09YdlZxT2NBWEx4cmhibElxTnoyTVlQbEhmaWEreGZsczBQUUVvNklm?=
 =?utf-8?B?WkFORHFYcDJCRHhBQ3NPK1ZMT21ydkY2aXlFU1ZnbWtPR25qZGZUdllQWE94?=
 =?utf-8?B?ZzQyNjEzUUl6MFRXTkM3TnhzUmthMTQyejJjZlNkUlluZFp5TlY5RG5oOG13?=
 =?utf-8?B?T3R2YUhyL1JmRW5abEVLeXpVSmpqZ09vWnNjS21rV0lWL3lrRHV1SVJsN3dZ?=
 =?utf-8?B?aFRkSlIvRFBEb3QzRUovOTJXQS9SNmZ0enR6ZnNkSDdEbTc2S2JjcmJ5SEJN?=
 =?utf-8?B?Qk9INjdHS3BEY0dZZHBDYVR1azlDM0tuTGJ0YUliWXJnTW5nRmkyRFdKa2lu?=
 =?utf-8?B?U2dYWFUreURDUG80dVBHYUVOSXk5WnhFVkRUZllIWmdTS0hYdm85QWdiQXU0?=
 =?utf-8?B?MWtIbFoxcU04M0phTWp5UVM2RlhoeTFWNkZYNlZ4bkZGUzhQR296dnE1dk9u?=
 =?utf-8?Q?rv39nK+7qUEaV3K/rzmg1jw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VAD72mPk8OHccGyzpHaQrWZ9N16mZLAi7HMpXf2w45stTLarOoa49MZAx/vRd8SZdjoq5V5ymduJ4soh78hZpbTHu1kK9UmP5jJOdUqAfys+9xZNEmkRyqQlcjn0+DrcN5VW61u+x3mpQ3sST9VZr9T/GslXHORCrpx8bi4ztCjOwLzr8qoXxvfPdT2BC7v/AJtLDM5U5BwpJ6PAXNYbTSOok2TzeMFe4LG9GRURQYytR0SFeU5L0gYzHVkUqMTMICkTU3IflMAF3d3itlXq0VMfv2JgqpFHpJxVv+hD7kWgKAh7YPHBYy7erAs8l5yFQ1dRH+AmiFOrdxE3j3yaMYmr08yHtB4ZqDEeCY2LnzjwVdF8wbdANoPzSlalBBrTsQWZ1Km3+VD2TSVuckaQGpxJKK5BAEmobWaNMVCZFoLfHzwZWlaywAP7WFqXEovLu+hBSheYq6oLM1/RxhubVnj1upTl04Yc3OtDcZGmmzbRkh7RdbhIvj1pkjEzXS2/SVoHHJ/WE3qFNgZhWjXz9tZUAluXLnbfNEoXApl6kTXPVyb5l4H6IJ64PWMsDMUmTyG5ZsH0LH32fmDHi8WJEGTh5gB8+fK/RVo1NNjXZMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9edfb0-1c5d-449f-5159-08dd3ad38b5a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 10:57:20.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qD+b69FwSJOIKnl4f4FRJbskcBey0oYuy8DzK0uzsUsRaDokWK5xcu53lYdI0djT2705hEyXy9689XH97MwJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220080
X-Proofpoint-ORIG-GUID: p7jK3TQZwP0bP_QfbEgWNr6ioirjflUs
X-Proofpoint-GUID: p7jK3TQZwP0bP_QfbEgWNr6ioirjflUs

On 22/01/2025 02:53, Ihor Solodrai wrote:
> If the kflag is set for a BTF type tag, then the tag represents an
> arbitrary __attribute__. Change btf_dump accordingly.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/btf_dump.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index a3fc6908f6c9..460c3e57fadb 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1494,7 +1494,10 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
>  		case BTF_KIND_TYPE_TAG:
>  			btf_dump_emit_mods(d, decls);
>  			name = btf_name_of(d, t->name_off);
> -			btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", name);
> +			if (btf_kflag(t))
> +				btf_dump_printf(d, " __attribute__((%s))", name);
> +			else
> +				btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", name);
>  			break;
>  		case BTF_KIND_ARRAY: {
>  			const struct btf_array *a = btf_array(t);


