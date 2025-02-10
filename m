Return-Path: <bpf+bounces-51047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C979A2F9C3
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 21:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7969A1887D70
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 20:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4826B24E4C4;
	Mon, 10 Feb 2025 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z6iVCFYd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q5H+1RBc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86DE24E4BC
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739218385; cv=fail; b=ibxlRiwFfzovYFFJVdY1nEA/h10VZuGlC9fH+Re7+OEdq+4XNU+sCW8PPA1jh0V8GdBxUPJz8bPRG7Xfoh41sOWCOFuyVaayQqjynjGuoCIbDRuvwiF2ajghmrWTwXtW6PXB6FoKJd+SIx6/ve+PRlS7TbtEndKVeBMfCpOVYfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739218385; c=relaxed/simple;
	bh=rjvLlvla8Bi3tJ2Pi7pfgup7CwkEsvp354rLixPbkzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WaFzFyvMw9/Wutxh7Jnu83T5YBoAV8G8nCSnKNka6cuflMlxbZOgVWyh/hGmrYPU97ysRaLfUvxdht5/40QcKlDW6D9PP0GaiQjd/A7Tot38unqsnJc9ILCXSa6pgmOqcuhcvl6AUZFHqE+l6sH3puZgkqG9X1/RJFfdwo8Bpt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z6iVCFYd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q5H+1RBc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AJtXbV011063;
	Mon, 10 Feb 2025 20:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ehZ2n2AkkBhwqk5pKL0PXTw450wkkFylhzA4mZW5kCc=; b=
	Z6iVCFYdGctCWSXJaSGyF4wfU87kspJM7A1L86MO9FlbBZzb8LUWXSnVpNA07Gav
	vc8t2OrYAAjZE8AS2LzzDejme88wJVOFm23PahH5dvVsM4fQu2WxjkKy+jnaYli0
	iR8BHrib38oDmiMaC7Li+MO0kHjXhDKzzlPKezTvKkECFPnFCoGhEjKtTLD7nH6+
	iF4hDFyPZpKP88fvMr4syP6l1Y/Lz4vhXwPSBQn6wIFwQOOxonByfne+hKCMb5St
	EG4iDbZdZRqorBZRswuhTwxX3kZuKshMD1Xm3xJcP9nOFIjErgQZVVh7P/ubWVZo
	a1L9viOZ6xI9uSYOC6kpVg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qabups-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 20:12:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51AImCIs027138;
	Mon, 10 Feb 2025 20:12:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq7vknf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 20:12:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvB3zzGMKTMMZt5gz+KG+mHA/OubYK5RHFSkEsHd/Fd/Splbp7PG/F9QHoqcG4QOphyXHMnXjmm8pzcVz3vxWYnfQqwqymqkYoNfbmFhE/sqmBnKHwaG0Q4WIsKyZch/5IYeL9LweIwB8410c9OkZpSVR1z0G4KweX3slfU9Y0rp+ZMg6dhfkyUJygKpLPyd9LFDKThUj2RXiwOAYTbBU8i+LdTvfvec0FREvt+YdEXXKVqCy6J21AhYFAtVI2Lc82oDydwqgpkuQKUShzY8CcQEDScRZwg06gILEg6jn0HgaHI0pPKKDXmyJ52VtpHyZSCLBChpptZi82IUYbfwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehZ2n2AkkBhwqk5pKL0PXTw450wkkFylhzA4mZW5kCc=;
 b=kfdX3oVPEWVpeuVWBZLMxnEOCyDzPysWL/sLbsjVqJzz5HX2uPnfgsS049NrfShIaPAKE1GpyLzK3vkPxqjWPkktqR050h4+xdBzPvI919pxMjWhqC3y+qnmTh2xnHkrrf88oKNAujy2vKGRqleMx5J1ydOIa4FitbmChVTqCcDIQbmfbhonhJSXIvjQoTDI2kE12szeQaiRgt9La8lTlJ91b+F/oq4/8j8b8RLrvQLbN4SLXpreH12Pg2TygnUOJh2EfCtuO4rWT2R0OD6u4GbbdEykCRSRnYAPBbhdOA0UzjuPH/EyJVm3qRwxwW5tcTM1apG58p/HmnrWDFF7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehZ2n2AkkBhwqk5pKL0PXTw450wkkFylhzA4mZW5kCc=;
 b=q5H+1RBc9dsx7HevmB+74E8eW8Z6fXNihPUeNW5NB3jBLW7NEZZwYlOVd2i1WiMPP0QGoGQ3z6Rv7yJPMFLndX/Up3JryRzMAQ35hXQONjM9EPBkQAUKaUSXFeyso8a3D7AhgOuX90ZlCqlMoto0nb5F4home1eDm2BMYBu5/5Q=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 20:12:42 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 20:12:42 +0000
Message-ID: <3313c853-9ed7-4498-b78d-96713ff7b50d@oracle.com>
Date: Mon, 10 Feb 2025 20:12:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add test for LDX/STX/ST
 relocations over array field
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Emil Tsalapatis <emil@etsalapatis.com>
References: <20250207014809.1573841-1-andrii@kernel.org>
 <20250207014809.1573841-2-andrii@kernel.org>
Content-Language: en-US
From: Cupertino Miranda <cupertino.miranda@oracle.com>
In-Reply-To: <20250207014809.1573841-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3PR09CA0014.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::19) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe06175-908a-4cd4-64fb-08dd4a0f4635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTF5dFJhTHN0MTNmeW9HWUtlS0Jpd3VobUxrMXVEdkFLakFsVXN0bmJzZGQv?=
 =?utf-8?B?TEU2ajJvd3lGdVpIV0tkR1FBR3BZR1Z4d0MvTXZqK1crcy9rRldFS3pWVXB5?=
 =?utf-8?B?ZjlnYWlRb01NWXY2akVMVTNiK2VsTnd4eURTRHJtWjZmdThXcys1VjlQTEgx?=
 =?utf-8?B?STJvT2M5bC9lZmVlM0cxS3RvMHRLanBhZGpmTklmR2pMeXpJcDcwTWM5bEln?=
 =?utf-8?B?b3hwZnlBQklWY1RkcENVZ3RzYnZjaWZJaEVYY21hY2w3SkRENWFjUEEzOVVL?=
 =?utf-8?B?MEliRzhGR2hOd1NhWGkxclhUa2VBSm0vUE83OEFQZkVTSk1pRUdTbGJGakRO?=
 =?utf-8?B?ZU00R2M1M3pGSnpPSXBYc05BTHl3NkR6MHcxcHlCTW1iczd3QWtjUU56WSsy?=
 =?utf-8?B?SkU0aFI1VnV0aFNhczYzWER1Rnk0bDRkcDNhdHdwYlk5MkYrRHVwM2xpMFdQ?=
 =?utf-8?B?aDRoQ2xsbit5TjlSakFZbld0VFljbzRUand6clVtYXNNUS9ZbDRaRkhacmN0?=
 =?utf-8?B?QWgzdEdERllscm41NmJyOFdWZVBBTExTV0c2dUpKeVEvQjVlUEo2ZU9ySkxL?=
 =?utf-8?B?Z2czdENHeVVtMXUyeUZ2SGJFM0xMQjlXTmFkaXJCSXF1elJYN1A4RHJYUTZK?=
 =?utf-8?B?eVo0dnJTSUV6QVRXeHc2MTJYMFZKWEw3Z3RiMnl1c0F0eVIzeTdZU0dBeG9D?=
 =?utf-8?B?OUwzY2JhVG5lei9nSXZXTVE3Q0xwbFhYZ1ZZMHM1cTZuOXhLTkxrYklJa1NV?=
 =?utf-8?B?NDQvNDlDaG1kUFc4NkNlRkFPZGs2UWJUQ25DQXpNZ1BSc0hvVk4vcnU1MHJh?=
 =?utf-8?B?ZS9jbTczS0J5YlRqWUltTWZxNkl0ZVhIM1BXQVJLaFhCeWFFOVVTTE8vc245?=
 =?utf-8?B?WllUQWVjT1gxZ0JxcEFRODNqbCsrRHJFQkE4c0JiK2ViK3VBME8xa3V2d2t1?=
 =?utf-8?B?aTlUWXV5cmZpU3RXK01XclZoSVhpZFRBMDhwclVwbzVSSEl2d0M4b3diaGF4?=
 =?utf-8?B?TlBkdEtKSTNHVVlNMXEzU0NsRDc1VzNDbjB3TTV1SDk0UmtWT1VhTUpsMjV5?=
 =?utf-8?B?U3ZSTXlIcTJqbDRhWXlUOVdWWDdTd3l0MzlYVVJ0U2lwWTlad1E5bnc5V3kz?=
 =?utf-8?B?UlJBTk5tdG9iM2ZHOWlEcHI2MlphUklOcFNXdWRjNTBDTUVUdE1PaGpnRTZC?=
 =?utf-8?B?QzZDSXZHWjRCRncxV21JOFNsVDk3SnpjQnZ6UTYxNnFRU0w0WGVBVHRzYU85?=
 =?utf-8?B?RGpuN2VCV2Vpb0RNc1VJQVpEVVFnUlhWcUFrN1pPNVU4RXBFY3N2ellTT3pS?=
 =?utf-8?B?TUozM2pVR3pJUkRSRGNFMHZzeFd3SCsrdml6b0pOUjNoOUFPekpuZEUwS2tu?=
 =?utf-8?B?ZkxUR2R5K0RSc1pQa3llQko1VVdrVkVmOEhwOXU0RWo0NkgyUE5aK3o1NE1Y?=
 =?utf-8?B?ZlZseWtBSmFHM2dUL2JZNHByZmVkUHdWcG1CSCtyRTJnMmNURkxaNG4weEli?=
 =?utf-8?B?eitMQnNyaWl4cUtFb3dLSGZSWFdva2pNV2NCNlVXRnYrVThYVGZIK0FlTVFI?=
 =?utf-8?B?bDlwTjIvSlJsL20xL3pRYXZCcEphZGNpMk1Pb0EzZkdsSm1LM241ZWNFS0JH?=
 =?utf-8?B?V3RKNjVCYWlId3ArRytXOVNmMWZJamNlTG1tS2ZPdUNIanFuOHRFVU9aeWpN?=
 =?utf-8?B?MzJlbStjVlhrL1E5a1BIYnU4eVNneHhLQm5OeFBzMHJjbmJhNGtMeW9XZnBI?=
 =?utf-8?B?ZC82N25Cd2JLYU5DM1A0MTFrVnVyYllIYUI4QVlsQ1gxVFBjYTRlUmhBWXJx?=
 =?utf-8?B?aC9XZTd2U1ltM1hJVGphWms2Z0FpVmFDNERGZEtJTXhEQlBjTTNIVSthWmgz?=
 =?utf-8?Q?Ydh1GKegb7C5I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vy8ycW1VZk9HbVo5ZmkvYXZaM053MnNQeHRtNTd3T2NMSUQ1TVJhSXNPQWly?=
 =?utf-8?B?Sk9mdEMwNWRsRXhhRVNKRFVuQTZUZitaZFgwUVNjRGZWbFVTTE9FMlFZb2V0?=
 =?utf-8?B?RVlqOVVtOHRyMGE3MEhXdjlzdDIzRHhkREVEMnBUbkZyVll4T3VqaEtyOTd4?=
 =?utf-8?B?blhjTFozc1A3RWdkUTlrMkE5RzM4bnh0UVNsQ3M3VXFySWI5UzkxRCtzQkc0?=
 =?utf-8?B?R3hORWloU3NuOWRmNXFaMm82TkhGZVBDOU1CV29oNGtTMjlLZGhNNTI5dnA2?=
 =?utf-8?B?dVovNi9MYklQbm91T3BZelk1c3ZONzJjMzVseU81bWU5REs5NlBXZzlRZHgr?=
 =?utf-8?B?R0FPdTNyWEZHaHBwY3pSK2V1UzFqcXRQMUtFeVAyd25xZjJZbU4vWmd3bmJ5?=
 =?utf-8?B?eUtyb3VBejJITHcvRzhlemZ5WTRLYklYUE14b2pTMXJpalZXTW1xMXliUThl?=
 =?utf-8?B?T1J1Q1lTSVFURnBXM042TStqZHFVb2JWL3RDVzhTbUFWREVUdFdMM244OUVs?=
 =?utf-8?B?c2U0UHRDVS9naFFzVXR5UDA3cUFkMlMzQzdGTGtJd2Evb3ZBNi91RnppMXlm?=
 =?utf-8?B?Ty9NR09NUjJjVUJ0aTVPaVBSaWtWUHVDYVRRZEUrdStSNEl4SW9MZi9kTDZ2?=
 =?utf-8?B?TUZwUzY5cnlTYjQ5Q2hVOVN2S3Z0Y2lRcmk5S3FlVDNTTWtGSmJoZGROdFJO?=
 =?utf-8?B?MjhiVC9nQVFBSzJSQ3BiQ085UUhHQ2RBdTI3SGFYWWFpVnFCbkhXWVkyUWxR?=
 =?utf-8?B?UzdyMTcreGx1a2tIekprQVJrdlBSOGl6OFRxVXlDUEVhU2ZGOFRQbGsvNXJr?=
 =?utf-8?B?c3JhSmx4cDA4NzZNL1pTWlYydlVablhaZmVLQzZ1Tjc1NDJjQ2YybklrQ2Vi?=
 =?utf-8?B?TklmRnlxVm9GdHFGbGJ5Wk5COFk3UUZ6Q0Z2clpad2RyYWEyMGdPOFQwbTZC?=
 =?utf-8?B?TTIzWWE4NWxaQStNVVdGSVR6aHdWWng1eHMwbXJCU3F1RDdCbGR3eWhDWEZr?=
 =?utf-8?B?THh2MzBaUDhJcS85OUFIOUhNZVB0VjNwMTVMc3J0K3lCR3crNGFsRTRYdDl6?=
 =?utf-8?B?L2xkNTdMc0o5eHJYZjFMbVlzWkg0L0c5M0ZFQ1dDUDBQWkgwWmNFeGNZcWs0?=
 =?utf-8?B?V2NpVGp6UmY1Q1grMFJTanZ0NHhCYVQyWmVYL29Jc3dSalUxY2JiZ0NFN0xi?=
 =?utf-8?B?Z3dZSHBHVUZldlY1YXVzc1lyZDBjcVlRbUZIdmNvaU9tU0c2UTVvNHJtd2Ir?=
 =?utf-8?B?L0Z1VFhvTFNNSHpXQUNoRzdDVkxpN0xsWDI5dGg5NnpCNnFhR1dUN3IrRE50?=
 =?utf-8?B?Qjc1ZVAwd1VSM3JkMEpoemwzWUh2MjdXWXpBKzdxSUdxbER3ZnlTZ0RheU9J?=
 =?utf-8?B?YWlxVFlPdkxKQUpJVklSUWtDNjNEQ3dSbzNhS2RuNms1K3RYTGZ5ZGFTTHFN?=
 =?utf-8?B?L1RRUkNoYnN3TGpSTEZYaERJdkRDSmVZcWVCeGlyanNrYk95VElyYWNuREt1?=
 =?utf-8?B?VWFSQnlHNk9yb2dQTzdGdEpSbUtHVW9mT2ZDU3dtamJpM0NQRkVJdmJhTW9m?=
 =?utf-8?B?QVVIRTNIZWU3ZkcwWGI5VVFaY3JJQTZwaXNES25iMzBpejRWblAvOGRMZ2U0?=
 =?utf-8?B?T3hnTXZkOWtaUWE3dlgwTFdHeXBvbUtJQVVJdkxLY05mQXRjM2dvSmtaNVlz?=
 =?utf-8?B?SlN6NGxlL2haSU1VMFpyRGVTZVdDazN2dWVuZDJleTd6SkkwczRGSS93OXhI?=
 =?utf-8?B?OUl4SnQySjNXdTVjLzZoUWFZSUZyYzRkbCttZUhYRU9UUjN5UHQ4NkFBNUMr?=
 =?utf-8?B?dXdkZVRaT053d3ZyUU0vbldoaFpsMzBTRWp0dVZUdGpCMDE2ak10QnVvZFRZ?=
 =?utf-8?B?cXBxUG1MNlUyUGJRN3kxSVF3K3hQdi9IWDQvRHk1SUF2RC9xaHNhMXk1NHly?=
 =?utf-8?B?UXJ5bDhGN3dDaUd4bTVKalptditUTWN6YnRBckdSM2piQW0vd2FKUWMzbWpY?=
 =?utf-8?B?NTJxRnh5c3RTK1VDMUFrMmEzcEtlR2RwQit5cFIzcnY3ZzFMNkpScTQrZ04z?=
 =?utf-8?B?a00zZ25sMEZVMzkzVmtHanB0TDkyMUlvTTE4VnJNclNZMExHcHlqY3JWUmhV?=
 =?utf-8?B?SHl6WkNNN0VmWEFpVGdOM2xzSXhrSHBSVnlxUGUvYlAxUDdJWW1PVTRyb1hQ?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pKfP4fuxbV5akKsD3Vierdkl0+nrZw9LzRhOVzJ76kw2n/oPZcYoY8uCLAZRHWaJXQhax/dkDuZtN3PVGAeIm+b9y/NACrRwivj8zqqrGC5jFJbIKWIstyupaYlYZxj1Nyddbci0dNNhQL2giSYVbLyzDWm3JfMixGCZ9cHTs8a79I1xPO6d0JAEnEuTdiikqpHGYayZpCdsGxdYEB1lEORGImYYfiacU0mcxvQcDx8KeVU0e675M6JaQOnS1A2F0si9cgEz5cVlZDWfXrai/9axiJT/YmBLm1jdLqgUFJWtoEZzzxjIyEg1yctKq/5SIzsepXcp7rvMd1i7MCOMVkHJHBnryIZp2Ao458xQXlNbI/HnLsjJvKbI5iDMKSsf/BfkILVJ1H/7KyWGaTiQUVU1yjtH/Ey5V3bVK/psFEis+07edgN0zc1PQqr1fbfUPAfMUr9R8yikDlC2KHSsk2hhdRU01mOBqIcI3EZwcRc62JFs1D901A2r6ObV++ZISlG8S6UQYz+a05PuWwfLoEldR7czTMgQ4FT9YFFFhczYuBhwXTr4009YUckwFv98u2h6z7V1vhmF8dWrh6tMDtOaY/FkxJ5YKZd7zcm+7+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe06175-908a-4cd4-64fb-08dd4a0f4635
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 20:12:42.2521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vXNMBtq8/9mREvx1aKLzB7svnXa0KG6HN4lvuZhezciB/3MIPJfoVO3MdH6lcKZ9Ud1CaHtIoFkiunFmhpQsxBTn7v4VRfVKn5V/ZBOkbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502100161
X-Proofpoint-GUID: yECgEogbiK1LKhPLhSkwlGXbC-AkXBfE
X-Proofpoint-ORIG-GUID: yECgEogbiK1LKhPLhSkwlGXbC-AkXBfE

Hi Andrii,

On 07-02-2025 01:48, Andrii Nakryiko wrote:
> Add a simple repro for the issue of miscalculating LDX/STX/ST CO-RE
> relocation size adjustment when the CO-RE relocation target type is an
> ARRAY.
> 
> We need to make sure that compiler generates LDX/STX/ST instruction with
> CO-RE relocation against entire ARRAY type, not ARRAY's element. With
> the code pattern in selftest, we get this:
> 
>        59:       61 71 00 00 00 00 00 00 w1 = *(u32 *)(r7 + 0x0)
>                  00000000000001d8:  CO-RE <byte_off> [5] struct core_reloc_arrays::a (0:0)
> 
> Where offset of `int a[5]` is embedded (through CO-RE relocation) into memory
> load instruction itself.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/testing/selftests/bpf/prog_tests/core_reloc.c    |  6 ++++--
>   ...f__core_reloc_arrays___err_bad_signed_arr_elem_sz.c |  3 +++
>   tools/testing/selftests/bpf/progs/core_reloc_types.h   | 10 ++++++++++
>   .../selftests/bpf/progs/test_core_reloc_arrays.c       |  5 +++++
>   4 files changed, 22 insertions(+), 2 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> index e10ea92c3fe2..08963c82f30b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> @@ -85,11 +85,11 @@ static int duration = 0;
>   #define NESTING_ERR_CASE(name) {					\
>   	NESTING_CASE_COMMON(name),					\
>   	.fails = true,							\
> -	.run_btfgen_fails = true,							\
> +	.run_btfgen_fails = true,					\
>   }
>   
>   #define ARRAYS_DATA(struct_name) STRUCT_TO_CHAR_PTR(struct_name) {	\
> -	.a = { [2] = 1 },						\
> +	.a = { [2] = 1, [3] = 11 },					\
>   	.b = { [1] = { [2] = { [3] = 2 } } },				\
>   	.c = { [1] = { .c =  3 } },					\
>   	.d = { [0] = { [0] = { .d = 4 } } },				\
> @@ -108,6 +108,7 @@ static int duration = 0;
>   	.input_len = sizeof(struct core_reloc_##name),			\
>   	.output = STRUCT_TO_CHAR_PTR(core_reloc_arrays_output) {	\
>   		.a2   = 1,						\
> +		.a3   = 12,						\
>   		.b123 = 2,						\
>   		.c1c  = 3,						\
>   		.d00d = 4,						\
> @@ -602,6 +603,7 @@ static const struct core_reloc_test_case test_cases[] = {
>   	ARRAYS_ERR_CASE(arrays___err_non_array),
>   	ARRAYS_ERR_CASE(arrays___err_wrong_val_type),
>   	ARRAYS_ERR_CASE(arrays___err_bad_zero_sz_arr),
> +	ARRAYS_ERR_CASE(arrays___err_bad_signed_arr_elem_sz),
>   
>   	/* enum/ptr/int handling scenarios */
>   	PRIMITIVES_CASE(primitives),
> diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c
> new file mode 100644
> index 000000000000..21a560427b10
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c
> @@ -0,0 +1,3 @@
> +#include "core_reloc_types.h"
> +
> +void f(struct core_reloc_arrays___err_bad_signed_arr_elem_sz x) {}
> diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
> index fd8e1b4c6762..5760ae015e09 100644
> --- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
> +++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
> @@ -347,6 +347,7 @@ struct core_reloc_nesting___err_too_deep {
>    */
>   struct core_reloc_arrays_output {
>   	int a2;
> +	int a3;
>   	char b123;
>   	int c1c;
>   	int d00d;
> @@ -455,6 +456,15 @@ struct core_reloc_arrays___err_bad_zero_sz_arr {
>   	struct core_reloc_arrays_substruct d[1][2];
>   };
>   
> +struct core_reloc_arrays___err_bad_signed_arr_elem_sz {
> +	/* int -> short (signed!): not supported case */
> +	short a[5];
> +	char b[2][3][4];
> +	struct core_reloc_arrays_substruct c[3];
> +	struct core_reloc_arrays_substruct d[1][2];
> +	struct core_reloc_arrays_substruct f[][2];
> +};
> +
>   /*
>    * PRIMITIVES
>    */
> diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
> index 51b3f79df523..448403634eea 100644
> --- a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
> +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
> @@ -15,6 +15,7 @@ struct {
>   
>   struct core_reloc_arrays_output {
>   	int a2;
> +	int a3;
>   	char b123;
>   	int c1c;
>   	int d00d;
> @@ -41,6 +42,7 @@ int test_core_arrays(void *ctx)
>   {
>   	struct core_reloc_arrays *in = (void *)&data.in;
>   	struct core_reloc_arrays_output *out = (void *)&data.out;
> +	int *a;
>   
>   	if (CORE_READ(&out->a2, &in->a[2]))
>   		return 1;
> @@ -53,6 +55,9 @@ int test_core_arrays(void *ctx)
>   	if (CORE_READ(&out->f01c, &in->f[0][1].c))
>   		return 1;
>   
> +	a = __builtin_preserve_access_index(({ in->a; }));
> +	out->a3 = a[0] + a[1] + a[2] + a[3];
Just to try to understand what seems to be the expectation from the 
compiler and CO-RE in this case.
Do you expect that all those a[n] accesses would be generating CO-RE 
relocations assuming the size for the elements in in->a ?

> +
>   	return 0;
>   }
>   


