Return-Path: <bpf+bounces-44247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F11D9C0A50
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E189EB21763
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487C2214437;
	Thu,  7 Nov 2024 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I1KG31Wd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RfYgzRaZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12B79D0;
	Thu,  7 Nov 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994361; cv=fail; b=TMYn9HkIbVguoA0gUErEcS34nq0mpNq+AEqrlsp9xr8nrx6gRURrqei9mqkRaGo11BvVU/KqS38SFFSyJnt+iOzwY0cHRFWvd020iO0fEXlgg9DcK+aiMuiuTWdZwPdAaTQSwmIwqXMKkFTYlrMiuMojqNVMqXQ5J+jY/pOUSTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994361; c=relaxed/simple;
	bh=3qK3BgFmHsCitED4I58X5ERI82K42KbFLy9HllQWVek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kw8/kBFjaGkq6HvM0og1JnTzUlPQPrTpue6WoNnblofQNmiH+9ykfpjzY9sxnibt167tlJLDfleP0+r0yret7tbjeaBnUYUgxoXkO7q9y/vLcsGJuMVguyFt2KSDoL2c2CDWuPROQbs3iHZjFv9NcD9yjtAy3Od8EZkHczlmVVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I1KG31Wd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RfYgzRaZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DHV5D025081;
	Thu, 7 Nov 2024 15:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gLaCPNnDNAyW3cLIymQYLJbtkv9Glo53+cO5px6oV2U=; b=
	I1KG31WdroGvoRGzaVQ9WdhaeYU3TwgRCbVnJ21sD9/ju/AblrnkZCU1gza1bHof
	HccRdflXgFA5gUewge3PcrJ7ZlQF8HnWVtTUAktlyZ2wqQAzUTiyZwDI9gD172vX
	AWpmh7bPjFb713Xqr7pwHRsOdF+aU44KV9KAabs4Diss8yr3ol8uxWBVrIPGoSj2
	NaANhv7S4rLJg3zNK65196xk0pZm+LZCkVR1ocRZptblSkKRQTHkBBJuiYS4nw2R
	yVIL2E6tr1kUsor4by4xejYVnHwqvllEjM5JE55YY/af3xG0KnUD15P6SHcTa920
	Xpc1tn4/LmKdBaowDlY5kA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap02vdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 15:45:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7EVfWS008425;
	Thu, 7 Nov 2024 15:45:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42naha5s35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 15:45:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbEt1odYk5VD7eYEHRxVTHhzWd3Ze2dQ0cY3iAlKkDEEKNgKSGR9iiDuc5pqPwGgVLXsfeXqTMIV0B1FeMg+nS32bsmTNA6c2bSL1TJzA8YoQ375uCbVZ/MNkcDsXcDRkA9gostHgGsVIZfP6GyhTNm9nviA8rNQC0z62sA0078YttTFINDkP8djrW7S/UOh0bidYuB9kEqEazRBaZgq0/CYriifbSGoNhuHv0qzUDOta9BL087KLigmFU0Quw4FqgBsn7GuGX+I0Ki9BCdyI3RukOVYe5jfnzloMy/6jOmryew1S6yzMDXbRpnB9GzDOvEPVOXNWxF1aXQF2z8Llg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLaCPNnDNAyW3cLIymQYLJbtkv9Glo53+cO5px6oV2U=;
 b=FgbXeAbnks+zrNEdxq8S+XnTjRen8mCMenQdwTGy+fSQRBm+m9TTqIxIOTNbIXJwNWW/AV+tYOD9vIIoirqC0Sazwt6ZPIvX+le9awuqaw+hWgSEsnS6bEv7GJJVsTWjkpyXs7psFcrR0lm3ICtD27x0pPy5K572H7rqJJ/M46V7ZUD7MaCMfjRNzxMFNCXHEIEi/vqKkkkbD4fiJuiYGpot+8wu/pO4JvZ+6+cbCjtIX2lSO8aIf3S90ebeBENnP34YhAL/lzAn11QkHuk56UxNnilbkEmyiL3By/wzil4cR16FKn4ZV6kfYvvXmAQKhLhXpuhACZrlMaHIGRU/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLaCPNnDNAyW3cLIymQYLJbtkv9Glo53+cO5px6oV2U=;
 b=RfYgzRaZ/KJHjR/nrf8Ftep9oKJBxLIizCg6+8zDQiqvlMtWH6ptkLmob50yCuPeSSBBvYq0SBIVCPVTANp/n5FwDfTY8tNEHbmqExOlPaIB01n6hl5W9QkrcREFwaO2GTkIz9qzd2OW0m1M3ZMRWhUvFC6/EIePLCRIH2Cuvec=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB7932.namprd10.prod.outlook.com (2603:10b6:610:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 15:45:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 15:45:37 +0000
Message-ID: <76fdeb12-6025-40c0-85d7-b701bdd026ba@oracle.com>
Date: Thu, 7 Nov 2024 15:45:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 dwarves 4/5] btf_encoder: store a list of elf_function
 per function name
To: Ihor Solodrai <ihor.solodrai@pm.me>, acme@kernel.org
Cc: dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>, andrii@kernel.org,
        eddyz87@gmail.com
References: <20241016001025.857970-1-ihor.solodrai@pm.me>
 <20241016001025.857970-5-ihor.solodrai@pm.me>
 <8678ce40-3ce2-4ece-985b-a40427386d57@oracle.com>
 <qZHen28Acr_pzq0oImrTEVB6xsUgeVkqBmQ43dpfluDRfqWYRfCQp9jTj1KCLtXqwXSQmSFObW4HNqKkWaPCsz2HeUKzzkfMtZ8MQJUkfgo=@pm.me>
 <L5Bv7su_qwLNpU42pyqsvF4rfjyR8BjHgb0u2aVPUdf4Cy1lkVpWzHyLvqdca1E4d6TLot2HQK6n-YLaE5utKSjap2aQB6LkWtNhgAFZtPs=@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <L5Bv7su_qwLNpU42pyqsvF4rfjyR8BjHgb0u2aVPUdf4Cy1lkVpWzHyLvqdca1E4d6TLot2HQK6n-YLaE5utKSjap2aQB6LkWtNhgAFZtPs=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eefba92-2d1d-42ad-37c0-08dcff433940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEpuSHh3NmRiNUYxZEFGTHJlUVMvamdMT2ZXbWx3YTIvWndmbzEvWE1oZEdZ?=
 =?utf-8?B?OThJdWYvWUxzOXdMaFh5ZkZhUmZlcXJybWtzRGdMZFhIR3J5QS8rWWJRQUFp?=
 =?utf-8?B?blF6eW5kQmpjWFBWQmVGUzV0dEVMQjhaMk1sMUFhMUZoaDFXNEpVKzN2TzB5?=
 =?utf-8?B?cVhnZlQ3cEt3Q2o3ZmRiQ2g5MG9FV3FBd3Mva3RLVTRmZis0STFpd09tQysr?=
 =?utf-8?B?d25LeUlaRVJiR1R0UUcwT0VLN0hpSzBLMzU1a1ZMM0cvaThrU3o0M3BHdW1F?=
 =?utf-8?B?UTJub2dNakg4clBFYnBuUzF6bDhHY0ljVWdoejVhUkZNeVB6YW50Q1pEamVP?=
 =?utf-8?B?Yko2RndtcUxrVGo5b0hZVU8xMnBPaTRQZnpRUEh5dkFFNkRkbENycXNtMmQw?=
 =?utf-8?B?bGlVK1lrRzFGY0FDL2RRZFplbTk5UHlVVDcvNmVuYlQ3amJ3UVVPeUxMbzVy?=
 =?utf-8?B?UXNwRkhkcEJScmp4L2VLSG8wMGRBRHVCZnpicUozNHJ2Ujg5SHd6ejZ6cHRN?=
 =?utf-8?B?UXdhYVhQUkZ0dzBFQXZSL3JtRFFDTjAvVllCLy8rTFo1QTFURlR3WXVNMmI0?=
 =?utf-8?B?a0FCeU5uVEdvM1dxemJGY285YTlyK3U1ZmsvVk9OTEM2MFBSTEtGZENUTlVF?=
 =?utf-8?B?OW9xYkQ5U1FiRDloblRadHhlQVJBdlNmd08zN0JoejZRY3RLUENMZGxOOC9V?=
 =?utf-8?B?SkRsazFBL2xBWi9oSHQ1MVNTUjNESGdpRFhpRUNwVEU0RnI5czBHRC92ZFdO?=
 =?utf-8?B?VGkxK25sWFBJcTZ0Z0V1bFJqeGR3L2NDSVc5SmxnUEhLVy94REpTUTFyTkFy?=
 =?utf-8?B?bHk4SzdDZmlsNHNxaHBOYVlleVJ3bnZCZUs1WXYyc3M0RkNRa1REcUR5ckVo?=
 =?utf-8?B?T2phbjFySHEwdGh4MUp3UGlVblEySXlhUlJTRHc0aW56Y2lJak5xSUhUZVBa?=
 =?utf-8?B?bE8zb3VLeVNjV3lYUkVsOWlqazFsRkFjcGxwSVFaNjJmQk53Y2NjWms1L3ZJ?=
 =?utf-8?B?dXZFbHFDK2tRWDlXbkxOeEhHeThGNW1MWStOenBaRDA1MGJ0S01DTnV2OTBC?=
 =?utf-8?B?VjBwNXkyQStET1VDSG1vQVVlV3FhdlJZTHo5V1dPV2xSYzVGMjhkc1Radmpa?=
 =?utf-8?B?d01BeW4wQUMxeVc5OHdmbktaL3lTU1A3SlhKMnA1MS9VeWxnckpPeldwbXRV?=
 =?utf-8?B?VXdRcWhaTjF1djdxSjc0d1RiRzQ0Z2RBZHRjVWt4b1VxcTR5MG5PV2tCWStV?=
 =?utf-8?B?bUJ0NzRxc2k1Z0dON3kvc3M0bFJ3dzVERlJwMmlRRE9tZEp1QXBCdlR3SkY3?=
 =?utf-8?B?USt3d0tvNmZ5dngxMVBmWEpPa0xyT0VDR2IvKzNSdW8zNHYvT3hNZ3RXYlly?=
 =?utf-8?B?SnNOeTFQL0xsVWxVM2cvZGFuOHA1UVR5cW1aUDFWMmViRVNZaWluSGVjS3l0?=
 =?utf-8?B?cFNiRWxXaHMvNTZhZXk1a1hqWFVuRVRCblovblF6UkxxZFFXdXRodnY5Vk9P?=
 =?utf-8?B?eGZNNmU0dm5CcitWOUsxby8rcGdsWmRnUjRmUk16ZGdmQ2hEOEd2UVJaZkFx?=
 =?utf-8?B?VnhpRS8wR0VOU0tSS1ZiSElodmtvbm4rcktuV3dNb1FRUE5zc1dSa1NZZGRa?=
 =?utf-8?B?VFlSWlloUlA3dWJRQ2pzQ1c4N1BONGtnWWxWQlFEODVJcXg3Vzlad25QQzh5?=
 =?utf-8?B?QjErN2FUL29ob2tYaHBEVUxDZzJHR29zdlpONFo5RjJ3bWNGZFBjVFp1SG84?=
 =?utf-8?Q?wRIKK/B7IBKH/GnsrZsrZN8joPXen1pdxdMN+e4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUgyNG4zLzcwa0g4ZlhaZVM2SUF0dUlZS0lFUnZuSDdWTlB0K0ozUUtFeGVj?=
 =?utf-8?B?NmlieW1BbEhQL3FXNzB1N0NGeDVlaHZGNFVrY3BZY2dBbEVwZHFMaURzMXBj?=
 =?utf-8?B?Z25KVWZUSE5XUnRQc0txYm9PS1NUVUcxS2cxYTZIbnREVjBSM2JlbGg0QjEy?=
 =?utf-8?B?QUJTdmNHZDQyazJ6WVNTYTE1VHhTUUczWmlWUjFhK2lFa0pJWXBHanlPTW1F?=
 =?utf-8?B?aUdGOHNwTFEvdnBNSkxiV25mYitCb0hIVDdBSXExek00SExtMTFIMXM1ajRM?=
 =?utf-8?B?LzhaREZMNG5EaFJNZEFOMC85bmt1RTgyZXdDdktncEFWZlBoSXB2ZkJ5ZVlM?=
 =?utf-8?B?Y2x5NDVObWdKUzlVSlBVNVIyTjZOUnRBSEJtMGZFUjFmTHlJamFvWEc4ZFll?=
 =?utf-8?B?QWh1bTNBMjk3bVZuQVdRdXd6TFNJUlAwaTRiZFZCRTByODdUNmhmRWFZYTM5?=
 =?utf-8?B?S2JBTUd1aXk3ZUd4L2hmUmNoQTNvNW14cERpNjZOMHBiblFmU3NFem1qUVFw?=
 =?utf-8?B?MU5zRFhwQUYvdDQ3aUlXWVdUZ3BkaHN2NnhXdmVvQzlidzhYOFpGZDBxY0RH?=
 =?utf-8?B?TDlSNURiQ011N3UxcXlXWktxcStXOVFPdTBxelBhMGxpMWVKZWswTVh4aE5X?=
 =?utf-8?B?Um9NeWZkWmxqUU81L3JwMzNDdnl0dVZtaTJQWXVxQXpndVkxOTFtL21WOE04?=
 =?utf-8?B?RTdpQzM0STBOWWJQOU00SzU3aFFzckhXdXhLTFNDTFExOWtpMnpGQ3Z6TU8r?=
 =?utf-8?B?cVdUVWhYcUdWTkZBVUI4TXhnOTI1aWtGb0tFaWh2U2VkbC8rSWtyQW90ZDN0?=
 =?utf-8?B?NERYTkJuL3JxL3Ixb1IreTFxd2pSUktudUxxUDM1NHlOTFhPVW5PSXlqNlgv?=
 =?utf-8?B?SjczU0tsMGdSVGpkVXllelVNNVV1eEV5NDIyMnZWYm56K0ExRGJ0SVdvLzhR?=
 =?utf-8?B?RjhtZ2xwTkJ1b3g5VTY3NERkUHFKVXRvMHAyRHllTy9sK0pKQUxxY1FHY0hG?=
 =?utf-8?B?T2VPRU9meWRrdjR6MjdNZmIzTnhLUDN4MkpRNGpyWkcrY2Q5T2FONTJheUMz?=
 =?utf-8?B?a1gzSzVQL1hjdTRtaUR2ejcxeHhCcVBoeDNSTkphc2F5SWJBQURQRnJ4dXI5?=
 =?utf-8?B?UEQrYzVILzRuc0hZMnZDUXh6QnRMRXM3c2RSR2FOazFPdVdwMTZNL1dDaWlv?=
 =?utf-8?B?V1gxWUN5VkxOMjdCVWpIa3RhMTdKdEhzNHNIQURZeFplVVhuMndsU3NrcEdV?=
 =?utf-8?B?WnNoeS9tVC9PRU5ycC9lQXhOenRJb1krQmpXY0hZV0N5SzZYMjBtazFrSjRJ?=
 =?utf-8?B?eHppdWtIc2J2dER6Nll2LzRXNkJMT1h3aFJ5bTh1ZzlNak5YWGZxM1VVT2dm?=
 =?utf-8?B?Y1NhZksvaVhVK29KOGlxblZreVQwWm4zbXFQVjRCNkZ3bjJtUWVDV01yUEFK?=
 =?utf-8?B?cm1nNnU1Z1ZKMnptdzhrc3hTWWNtMmtYcmNZcUZxdnZPL2N5K0VwSTRwM25B?=
 =?utf-8?B?L25aZmtITzlvMGVzRTRtOGZEdkZnMkoreXJiemFsSnBKQ0dBRGNHOUJxWmFV?=
 =?utf-8?B?V0JUM2xpZkxXaFMxTUhlVDNwMG1VV2JHMTM0cVRkZFZ4U3lySzVJUW96YzZJ?=
 =?utf-8?B?WC9BTWczR09OaDV0NzNkblp1eG9uVEhZcFQzVG5CT0hiV2FNSWc3Wm85Zzd2?=
 =?utf-8?B?V1Q4cEZMNUl5NDFGVkNMNDdzcldSTXdPRXpmOHdJTmlaTysyanlBbDkxWlhw?=
 =?utf-8?B?UmFQSExJYXRJYkFRY0ZsWG16Um9FWmZpaVR3TzNtOVp5YlFEMWFDSzZFTnE5?=
 =?utf-8?B?cE0vdEozSW9iL3M1bGJoTXNoYnpSVkNzRlA3QS8vNk84RFdmVGt3MER6Qjk1?=
 =?utf-8?B?N1VQUHdmOVExUHhOZDFTWTJKN0RXSXg5eXRoUm9zSmppM0tBWGNSUjEwRlVT?=
 =?utf-8?B?a0Q3UWJGMEZrUTc1WE5jUFVzbG9GMkYxd09MU3ZzSnNrVDVJS2VJS2x6V3FQ?=
 =?utf-8?B?Nkh3dDhTSTdJdC9hekE5Z2FxK2M2eFhKcjNaZFV4Rk42cXlLL3lpdk1qeVdW?=
 =?utf-8?B?QjM1enA0YU1mSU1QSVFyQnEvOVlqNXozUDRub05pZEFVOWhRS0Vyb2xjTDBt?=
 =?utf-8?B?WmtKRGhIMVRXOGRKM0psNFlJMHBmMWtRMnJwM2VSby9mbDRob3ZqQ0daNDJM?=
 =?utf-8?Q?pkK3MzprTrl6702rnNNpD6k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SeD/wf+Q/f+g5eZrjiaNInt7RSB1Ilr+gP6vODWjbMwOu9zTMQTbPBsTGtNRw/jM475/PylfLKsRm/jvI4mbJYEuD3ySX+5dxeV2aniEUsxcc4Lgrz+pgeNaO7IjpElSwYtsyrWZsjDPyi7GPCOkr7dFy4jY562o0k7P6kLMpgFMIih8TGoDVJg6Acld2h0RZAIgLhkKRWhqDVQy+iSrl+r+m/2faOVUXpQeb4a7lvHTHtkWuTnt6TEiELe3le4f3UtZNQmwjTEd1QH8qdfZCRTH7+elawPne8qWQG5pH4SHE4v2xz903eQ/+ku8VvEAyZjqzf/xapoAU+4PDDljhDTs+w56t/9/Eq2TnuPeZ+2yEo7PHHJvkiYbpvG0i13De/dRDeplfVKI0DY0OsvvGzEeFtfK2A3TjN95xfZpMmg6HO1jNfZ3XIzVTKl/kJ9E5KdMYZ5SHVe974FA9Yh39XFphT8VHnxmb6DQhE5AJFkmbhZ3ct37aTCXbtWycLdnBp3YdmCeUpduFoM0K4aE8Vfj7ozm9go3U0rDYVVK/ZEet2eDFF/yMgIVDrKpXXm2tjzNSQihpGMim2qgUgAyHVXjlq9AD7IGZTeM2FCAHSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eefba92-2d1d-42ad-37c0-08dcff433940
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 15:45:37.2259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0u/XHG/dgJiRWmKHY1Ew27/296wEI/agiIbyptC2d58WzP9Bl9zrpsCQWfmcr/y8AiLB4goQ4Sl93SKD3ts6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_06,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070123
X-Proofpoint-ORIG-GUID: penrkRrZIODactYw8ck4Yu-_bcnLN7tn
X-Proofpoint-GUID: penrkRrZIODactYw8ck4Yu-_bcnLN7tn

On 06/11/2024 23:28, Ihor Solodrai wrote:
> On Wednesday, October 30th, 2024 at 5:14 PM, Ihor Solodrai <ihor.solodrai@pm.me> wrote:
> 
>>
>> Hi Alan.
>>
>> Finally got time to try your changes. Apologies for delay, was busy
>> with other things.
>>
>> TL;DR Here is my patchset rebased on top of your commits:
>> * https://github.com/theihor/dwarves/pull/7
>>
>> Please take a look, and let's sync on how do we plan to merge it
>> in. Your commits seem to have debug code in them, so maybe you'd want
>> to submit a clean version first.
> 
> Alan, Arnaldo,
> 
> Did you get a chance to review the changes rebased on Alan's work?
> 
> I think the state of commits in the branch is good enough as is, so
> I am inclined to send them as v4 of the patchset, assuming Alan
> doesn't mind me including his patches.
>

I need to clean up my patches and verify they generate identical BTF
from the same vmlinux, so there's a bit of work to do there first. I
should have something ready early next week. Hopefully won't look much
different, just with debug stuff removed.

Thanks

Alan

