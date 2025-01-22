Return-Path: <bpf+bounces-49466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09DA1902A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 11:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F53B7A2E81
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A952116E6;
	Wed, 22 Jan 2025 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HS1VL6uy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cxUdd1sO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60541F893C
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737543424; cv=fail; b=RCjJONhmIpa5/VvIA51M+1RtsUjHdyok+OHC30MXcR0fMa9uuJroPM5YsIvM23kmXwKph0x4DYL6HH7EKESEYUcsW9Dal2rB0JNsO6CNLoymermuAcI/zYDY9BMOgxL38z94mmITHSN2LbRBToV5H68K/2HDmpX4B5oqJrrvwV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737543424; c=relaxed/simple;
	bh=ySApaiTghmnOlhKmoRaYYplPbw//GRNvQSqKQ25/AyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZWx1nQkaWQegFhxcDm5Ku2WEsSwsceeyUFCbD7oVkduFHqNSAgmjHQYy5gba8qyIOYHhNo5rYxQofLsQHw4rmCNuNtW6QKfOCTw0UnQOLCvEEskgiCD9w/YHOdopejf+cfhvzsoNgoq0CiDGXUCuCwBzcXu1r7ecxJeE3Rifdrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HS1VL6uy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cxUdd1sO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M1MtmJ013549;
	Wed, 22 Jan 2025 10:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mreHLIhYRwCHelK99dE51rXg0/IesRl0HkhHTfhk3EU=; b=
	HS1VL6uyXWRw7OYVRM795xh2MTlKZluguHfTx5EFZm08c7SQl09jMttS01LSamYA
	KrAff0Ad4IuIe+voY2kBZbdwUMjjMuWnZyi3QX0K4q37hgVncjbTJy5OKRbUEVTp
	W2swXEEKx0Fnw9BijO9XerBGSDvbYwoKB8b3kru9FBqeFoovHz02pTEM3ImZNn2H
	UDA5tiA7UZjv7cdfx+8LVH9SAWZS4j+EjOVu3bnkSQgwL7gjXN7sfhM+fxm8y0cP
	fENLbN3TF3VGbRUxYvXo9KxKITtYazpWMuNGCn6A7VsCWmjdKB75i/XheMDm9Ld6
	/RnyxawFz2hPx+RTsCaQhQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsfbc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 10:56:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50M9bExD005553;
	Wed, 22 Jan 2025 10:56:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 449195fu1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 10:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFZ4TXW9Zk/2h4tpcLJIN9N/mXLTQRFPQK8piIcxAnKPbAz0ucECfvZAMOmNpUVTNDpgVrmq8LDcnX0MfWYd6r1Ab2S3UJpQuXx67DRHArq4O4ssSYnbDV9rSSs4PRIuj07OedrEGOcF7iBteJoXGwk0WJx2Vb84OnJnDGj/Gnmxd4bBWvHbgEPauS01OSaddaEbFRJtLQspgG+KjxPcT5CdIjAaeJgM8fbMhDshm7Uxw9PMCWF+AoqfEc4KvyBK5uYJX9sFWu4nJH/kbqAFmqy29ZRba6PzGYYgiBU4uiFcgRLpLOkQRE7A9Ui/n/VSFWFnWBMU65KGmEOOERxz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mreHLIhYRwCHelK99dE51rXg0/IesRl0HkhHTfhk3EU=;
 b=RZ6luVdfAUE/4k4dlEfgHMbOZptzmeUF3khfPPx65pU3BdbIe+WvzOeYAPkQZ834syXHRlmTGfRCacKdLr1N/LrhPggTBuGh3R/3MVDPJI2UAekPKErcIwZEWtImsg559EtTwvrL5+UK8wSFnFAJnViv0e5bUMRoHcRrceb0FHe8SdOz+VcVBDVvxxYNZXtdDQE8vQXfrnRC2xiIJ6M7hyzmYA626ovGVtbbwzdSkuzYCTp2tshUHURMagO2bxDMl8mmv2SUg+E88L7dy7s08ViRhPcoEFWtAx55B7UVYCAcN11G+/fRgEx5nvpEflF3iEWcKI+Qh6/yEI0WSrpBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mreHLIhYRwCHelK99dE51rXg0/IesRl0HkhHTfhk3EU=;
 b=cxUdd1sOrH5kEmMs0+jJAt6jM5g7+N8Q4OjPkasV1hC1xjDGTAe0LyqWkBTI48K0eq1tICbmxZRq0lmXDWTxc7kwCCGlgevISQ1odtixdKVsxSXhwzYIMTpmxnRa8NgqhFIf8IA17uwj0lj10Kj28sjNWCQQA7L4yIYHNBGWVFM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO1PR10MB4593.namprd10.prod.outlook.com (2603:10b6:303:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 10:56:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 10:56:37 +0000
Message-ID: <3e7404bb-b96e-4dc5-877b-d6a49273973b@oracle.com>
Date: Wed, 22 Jan 2025 10:56:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/5] libbpf: introduce kflag for type_tags and
 decl_tags in BTF
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        mykolal@fb.com, jose.marchesi@oracle.com
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
 <20250122025308.2717553-2-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250122025308.2717553-2-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO1PR10MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f50edc-a0b8-4a5f-ab58-08dd3ad37131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnM4dEZzOXczTG9lT09GRzZsTUtzeUZxNHdpVHhxbkV6RnFSdGNndEhXdm0z?=
 =?utf-8?B?VU9GbHlwSS9OblY2VDRHN3phUmszQVVGa1FSNmxUOVdUVTNqWTJEcG4xdzhV?=
 =?utf-8?B?bFNwT1k5ekp1RDlkZitpN25PUkptVnVvc2JEbXhlNVIwcnIrQkFIVFdhU2VZ?=
 =?utf-8?B?TmRjaU5nclNPaFJMb1RzazdBeEE3Z1RtbGlvVmtHRjVnT1FLa1pMenJoSEhX?=
 =?utf-8?B?NmVNRnRWL1gvcVkzZDg4ZlA0dDVVeFRibjlBZ2Nuc2hqMnpTZkZjNkdVclUw?=
 =?utf-8?B?LzNNSzRITHMyeVpPVlY3NjZsQ2VVUWhvZTZaVkZxYlZzUmJsOVlhUG5mQ2hV?=
 =?utf-8?B?bnNtUVpVc3h6SEVPaCtCZXUvZ0MwYjk0djMwWEFsMTNCMVJKS0w2T2ViOGli?=
 =?utf-8?B?TDlXakFzUDRyZDZOOVo5S2tTb2RXR0tEYXR3S1V0aFhxa0RBY2JWUmc5RUdo?=
 =?utf-8?B?a2JWZmtSWGV0cHdDYmp2SkxQeisxMmp0eXgxY1FwQVN0c2RnaXVOTGxtS0N3?=
 =?utf-8?B?aE5GbEFBNVR6YkgxTlRzMlVMVDRRR0tzbXh2RnhmRnBUeWV4UmxzczNWVDJE?=
 =?utf-8?B?cDBOV2JqZGFvRnRid0h5SW1INEs0TkYrallrV2RiNU1sbDg2MVo3YlR6QSta?=
 =?utf-8?B?VUZnTW15aXM1WTNlRmpiQ2ppZjZabVcrejJMdzc4eEVFYUtwek9DdHdnY0xC?=
 =?utf-8?B?bWc3L2JCdFhqQklxcS9xejBxL1MyaWNjaTdEYjFJNTNleHFzbWtkWW4wbE44?=
 =?utf-8?B?cWZZTkN4V1l5THpuRXRMRTZhK0l0L2ZFNXg2Y0oraXNwYXd5ZWxJbkc1akNw?=
 =?utf-8?B?ZTkzNWJEK09rbFowa1FXaC9EWmR5aGU1WHVQajdSUXRwUEJKcERRQkQwYVFM?=
 =?utf-8?B?UzZtWEhRcFhRYktmRHlhWCtUY3FCaFF1UTBYeWpkYkNUdkFDYnJFMzl3R3Fo?=
 =?utf-8?B?L3FHLzFDeHFDMXJ1d2lqVnNaUjd6SlRIT3pWZ0FLRHoxWWN3RXNTL1BVaWE5?=
 =?utf-8?B?c3hzRkpnaTFoVkh3VGx3c01YVHBVYkkyWkpwKys5bG5jclVTMTZXTkdleHJh?=
 =?utf-8?B?eUU1MVdFNHN4U2xiTzZmMlRtTFQwOUhvT1gxWUV3ZkxZdjlNK01BbnA2N2FG?=
 =?utf-8?B?T0dXSGdmT0hZejBrRncxL3hHa0VWU1hEanVoYjg5eVM3QXJmbW81cFBXdTNu?=
 =?utf-8?B?R0s1ZmdnSkUzbWYvbTBvaTFCZHpGeXZPaEdNRUFEdjJoK0lYd3NZQUFISmZW?=
 =?utf-8?B?Vk1wSlZZTE94ZGFSZ2tpNkk4ZTlKNFJNL2thRjBOV1kzYTN3MHIzRUJZTUg5?=
 =?utf-8?B?WGRFeWJ3N0taR3htUmZEOUwwZ2RLQjVSVnRZcWtibFY2cDlMWUYvNEtyR1pD?=
 =?utf-8?B?RUl5dXZXSzhWeTJSZ0YrMzdJZFdWSFZ1VURudC8ydndLck9peHNXLzNGTFYr?=
 =?utf-8?B?OTRBNWE4NGs2cU11WEh6ZVNyV0VaYVlsWTg0YndyMHpCMkZHZndkdVN0cVds?=
 =?utf-8?B?UkJQNjdCK0ptTTQrckt5dlJ5SkVDcTdyaDdvc0F2WVlCSDJnY1o1bmZoS1Nw?=
 =?utf-8?B?WFhPYXlvSnhXb0FTYTUveSs5c0VQQVdjWStocEx2eTBFcVdNdjM0b0pDcGww?=
 =?utf-8?B?allYWWM2NUtuM0hGMGd2RVFKcDE2K0pRZU50eGpYR09IUEF0ckZZVVM3ZjJm?=
 =?utf-8?B?dkNIaDRBWW0wQi9BVm9HSTk5d3JFUXFvbUp6cGZnS2Z1Y3pDTjg1WENFWUJ0?=
 =?utf-8?B?OU9kTGNSZVloOEcwR2tuRjNXMkZadDFRMFlxaHpuc1NhOHpHQUNJU1RUdDNt?=
 =?utf-8?B?bUdpTkNIc2VGaUZXUnNNbEhIVlRBZnhSZjl0V3N4UThiMitYaS9VUWRyMllQ?=
 =?utf-8?Q?7gqMWjYfdAzjp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTU0Zmk5UGVLTWZNdW1pdEVzTkF4VlMvWFBIYWVsZlJwbkFldUg0NHFwcHlM?=
 =?utf-8?B?QXVVc0cvUldwNGt6ZUpWT0FDUStKeUc3YzkrUUlzSEJIbkNHWHpUSDBpYWRI?=
 =?utf-8?B?YWlMTVA3QXdYMXA4aTRrV1k2cFF3ZSttOVRQeXV6ZDRGeTB5Slo1NnJBZ1FM?=
 =?utf-8?B?aDBadTZVY1hYaG1wRjVCZlM0anVJWHREclFCb0NzOThick04ajd3cmk3MVdi?=
 =?utf-8?B?N0gxTnA3bUI3T1VwOUZNNzFGOTVMRENlS3I2M2NBWFZYREp6SDdxNVlmbks4?=
 =?utf-8?B?bVNHWXdaZUhnaHp6ZnR5cHFSc21JcStiSU9odUs2UVI3K1dsYXpwMXFzVGlT?=
 =?utf-8?B?c2VxeTNkeG9ORHFMSFg3RTdVcE5CMkRaWWIwTFNxMEM4S29vYWdWRk9KRXRw?=
 =?utf-8?B?T1cwN0hpU2h2YjE3SWxJa1F4UC9TVVFjenRnK2hXd3AvbkM1QmF5T1Y3aXRL?=
 =?utf-8?B?cHBSSVdFV2NTSUZWZzNxNGNvQnFRL2lGTVZNUVV0VGpqaHdBVE5oSXBTbDVz?=
 =?utf-8?B?bWFvaUNHU0I5UDBMZzFNelg3NDlNOW00aWttQWZXbVptaFhjY0I5VVJ4K0Nt?=
 =?utf-8?B?alJOd1RYTDNOY2I0cGlMdHhBSk5PbXk5Q25mcU5Pdm1BL0VnRklKeGphVkcz?=
 =?utf-8?B?ZDBKWDVxaG1HY1RINXAvR0RNK01qTXpvc0cvZ3g2dXp6SEh4ZWV3QnNFWW8y?=
 =?utf-8?B?eHVITzlKNVdmZ1Y5OGhmS2dYWWpMTXhYS0ZTSytlN3lzdlZsa25KOVBaRXFw?=
 =?utf-8?B?cnBrYkdqNlk5aHF2Y3RveGNMQlozY1dFMDJUekhiS1FjOFUxdHdHOHpQZ2lZ?=
 =?utf-8?B?SGhaRXBsOEhpQmk0VFgxZitaQVpkS1hNTXBWZ2lNa2dVVjA3NnphK2JDSjli?=
 =?utf-8?B?MmtyMTFvU3JLS28xM09CclI2QTRRYXpuQjN5UUFvMjd2eTRJRmVhbXpWeXFF?=
 =?utf-8?B?c0lLMzhQME03Q0luNjJTWWJvWVlVb3h2TDE3Z3RWbnBFV0YzbEtsQnVDanZ4?=
 =?utf-8?B?NUtjVUVvN0J6SHZBSUlhRDhhOWFLZFdSTFNOeFdUSGJqUkwwWTl4ZHNFakpq?=
 =?utf-8?B?QnNvTjlTd05NbHJxWlNtd0dIaEdudS9oT3ljN3RTd1VrM2hIUCttM3BGSGls?=
 =?utf-8?B?MGVEMkczUjM0bnc4Z01BdFZHdk1JV1NZRnBkREwrbitKb3ZjSDNEdklrNjRi?=
 =?utf-8?B?aXhnT2pDbjFLekpwcU84WjR5bWtkeitXd2wzZjd6d3JlOG9sZW5tQjcxaFps?=
 =?utf-8?B?UFRFaTkrYjhuRmtlVzFLaU5wQmhzZ3pzM1VoOVlpOGR0YzJsVlUzZWVsc3hT?=
 =?utf-8?B?SjIreVJHRm1uNEVDbUVlTGZMdS9IVDdIUFVvZzhraUplekNLSlN4MzZoSklT?=
 =?utf-8?B?SFlUU3VKTE1TUVFtekdEUHRsU0pROVNtZm9JdCtYdE1JZUxyejViMnVaL2h4?=
 =?utf-8?B?eGJyblFoSnR1L1IvNVFSZ0NZOE52UE90MW5nWHlIdmo0ZnYxbTdORnFxOFBW?=
 =?utf-8?B?L2NId3lJOHE1dU9pQzNLU0dZcDRueHpsZXBJM01YWE9DTWhXbVFYKy9aZ3hG?=
 =?utf-8?B?YW15T0Zlam43dEpZNll0M2RlQVZxQUluelNRTUh4UTlkTmYySExpSEZIdUVl?=
 =?utf-8?B?bnBQT2l3bE5INm8rYm9nY0E1VjEwYm9JSjdCa2VwS3R4cXJSeWhwcGxxZ0x5?=
 =?utf-8?B?QVlPK2VQenQ0bmh3L2I3bGJtUU5FaU9oSThXV2hYTWplRTg5aXBkRkxWYkNp?=
 =?utf-8?B?bUFNMFg3Y2ZVSzFDWE5kYlFoelN5VkVsaHRyZmMrQlRBTnJRTXZYTlpjZlJk?=
 =?utf-8?B?aGdOQVZqNUZ6clFzWUNkMTYzYWo2d3YycGFEQUxHOStUbmJEb0JGRWNGcUJp?=
 =?utf-8?B?dEJUUkIwWTRqVTQ0UU1icmloODJKejc5b0lkTEpWUHRTMFJIYWJBQlgrRjND?=
 =?utf-8?B?OXJoZEp3RmtmT3Y3VkFYWGxmNm5NWUxYTUdGeW5IQ1gvYjRTR2twTi9mNFNs?=
 =?utf-8?B?ZFA5RGRVczVGd0NCaGY3cEJ4a2o3Q1lvdFRKaFAxQ2RoR1NEa1ZUc3BIeWtt?=
 =?utf-8?B?dTEzc3lPMUNNWHBMWGVGN2sxZS9QMDdsaWhnaE9vakVwcVVnOUN2WlV5bGxW?=
 =?utf-8?B?Tks1b3p2b3MzUk1lbEMvVlNwdXVLWVFydWhVNTVoYUF5bHVoNUJFQjBOb0I0?=
 =?utf-8?Q?R9F3ZWREyFF7vjbSgxoeLFM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YKTOhuzxADFzTcw0Hl95P+3T/bqUgYrLu2He6Zptg/H1I4yIokMYd4/y4XZN//+N5aXtR7GcjiHovMOVXIwEysGH5C5hB310hDDSbEscNvAB0YeUCEEsrX7fFbZPJKVth2B/tS3MK9J9SiNrDt4bmUOOCsDklalUYeIMLbLMZr9zudlvdgKRwL0u6v69tYU5vNQyIYySJP/MiQBX5BdjI6oR37VTVlDsxuPFfcv8O4DhHrJgaySTn3Ky4DSvUxCL8vF+b1Oc3ZXw7G9eUK3//OFScXxRYwHalJmVAyhuKveUk/yYF5kTauVpO5/ZiiKnEH5ZtwL/Lrz7wESdIDiBOr8M3tgx60wN1CD9+v4LwT9P3IVX30fdkRUcxNg3uUpe0Bki1+sdzOj3Z0WPhJvjmv7V7LRTll8nPjGyDqKv8jldsqqH7G1NQnuFuk2jIN+Yi206L17248ZdyQbNJ1JYnzRl7nATAE0Qfoe1/w2EtzQjW8wiwdlyquQWgni13yrAHSl4ME8hsd8MWKktRRVQda/LZZ9JogMR0Ijj6wWW9O/5+WNB9ccWxUOnNhiDMIUkBJs+uexFDOEDaRaRfJ9R0AkgUxV2OaeyqbXamf51+Sc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f50edc-a0b8-4a5f-ab58-08dd3ad37131
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 10:56:37.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aM1l3f9uUVXdezwvuMOo/JVXeLTc96KpE8881w16GoLJECULyT7CDm9h2/UcwpdXmnXPmAfZCQZY9Gz4eY2Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220080
X-Proofpoint-GUID: OGHGa3f8xtmYKGW3oghhtiNmemYfNfQx
X-Proofpoint-ORIG-GUID: OGHGa3f8xtmYKGW3oghhtiNmemYfNfQx

On 22/01/2025 02:53, Ihor Solodrai wrote:
> Add the following functions to libbpf API:
> * btf__add_type_attr()
> * btf__add_decl_attr()
> 
> These functions allow to add to BTF the type tags and decl tags with
> info->kflag set to 1. The kflag indicates that the tag directly
> encodes an __attribute__ and not a normal tag.
> 
> See Documentation/bpf/btf.rst changes for details on the semantics.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

need to sync include/uapi/linux/btf.h with
tools/include/uapi/linux/btf.h, but other than that

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  Documentation/bpf/btf.rst      | 27 +++++++++--
>  tools/include/uapi/linux/btf.h |  3 +-

same change needed to include/uapi/linux/btf.h too, right?

>  tools/lib/bpf/btf.c            | 87 +++++++++++++++++++++++++---------
>  tools/lib/bpf/btf.h            |  3 ++
>  tools/lib/bpf/libbpf.map       |  2 +
>  5 files changed, 93 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 2478cef758f8..615ded7b2442 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -102,8 +102,9 @@ Each type contains the following common data::
>           * bits 24-28: kind (e.g. int, ptr, array...etc)
>           * bits 29-30: unused
>           * bit     31: kind_flag, currently used by
> -         *             struct, union, fwd, enum and enum64.
> -         */
> +	 *             struct, union, enum, fwd, enum64,
> +	 *             DECL_TAG and TYPE_TAG
> +	 */
>          __u32 info;
>          /* "size" is used by INT, ENUM, STRUCT, UNION and ENUM64.
>           * "size" tells the size of the type it is describing.
> @@ -478,7 +479,7 @@ No additional type data follow ``btf_type``.
>  
>  ``struct btf_type`` encoding requirement:
>   * ``name_off``: offset to a non-empty string
> - * ``info.kind_flag``: 0
> + * ``info.kind_flag``: 0 or 1
>   * ``info.kind``: BTF_KIND_DECL_TAG
>   * ``info.vlen``: 0
>   * ``type``: ``struct``, ``union``, ``func``, ``var`` or ``typedef``
> @@ -489,7 +490,6 @@ No additional type data follow ``btf_type``.
>          __u32   component_idx;
>      };
>  
> -The ``name_off`` encodes btf_decl_tag attribute string.
>  The ``type`` should be ``struct``, ``union``, ``func``, ``var`` or ``typedef``.
>  For ``var`` or ``typedef`` type, ``btf_decl_tag.component_idx`` must be ``-1``.
>  For the other three types, if the btf_decl_tag attribute is
> @@ -499,12 +499,21 @@ the attribute is applied to a ``struct``/``union`` member or
>  a ``func`` argument, and ``btf_decl_tag.component_idx`` should be a
>  valid index (starting from 0) pointing to a member or an argument.
>  
> +If ``info.kind_flag`` is 0, then this is a normal decl tag, and the
> +``name_off`` encodes btf_decl_tag attribute string.
> +
> +If ``info.kind_flag`` is 1, then the decl tag represents an arbitrary
> +__attribute__. In this case, ``name_off`` encodes a string
> +representing the attribute-list of the attribute specifier. For
> +example, for an ``__attribute__((aligned(4)))`` the string's contents
> +is ``aligned(4)``.
> +
>  2.2.18 BTF_KIND_TYPE_TAG
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  ``struct btf_type`` encoding requirement:
>   * ``name_off``: offset to a non-empty string
> - * ``info.kind_flag``: 0
> + * ``info.kind_flag``: 0 or 1
>   * ``info.kind``: BTF_KIND_TYPE_TAG
>   * ``info.vlen``: 0
>   * ``type``: the type with ``btf_type_tag`` attribute
> @@ -522,6 +531,14 @@ type_tag, then zero or more const/volatile/restrict/typedef
>  and finally the base type. The base type is one of
>  int, ptr, array, struct, union, enum, func_proto and float types.
>  
> +Similarly to decl tags, if the ``info.kind_flag`` is 0, then this is a
> +normal type tag, and the ``name_off`` encodes btf_type_tag attribute
> +string.
> +
> +If ``info.kind_flag`` is 1, then the type tag represents an arbitrary
> +__attribute__, and the ``name_off`` encodes a string representing the
> +attribute-list of the attribute specifier.
> +
>  2.2.19 BTF_KIND_ENUM64
>  ~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index ec1798b6d3ff..d602c26a0c2a 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h
> @@ -36,7 +36,8 @@ struct btf_type {
>  	 * bits 24-28: kind (e.g. int, ptr, array...etc)
>  	 * bits 29-30: unused
>  	 * bit     31: kind_flag, currently used by
> -	 *             struct, union, enum, fwd and enum64
> +	 *             struct, union, enum, fwd, enum64,
> +	 *             DECL_TAG and TYPE_TAG
>  	 */
>  	__u32 info;
>  	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 48c66f3a9200..df2808cee009 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2090,7 +2090,7 @@ static int validate_type_id(int id)
>  }
>  
>  /* generic append function for PTR, TYPEDEF, CONST/VOLATILE/RESTRICT */
> -static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, int ref_type_id)
> +static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, int ref_type_id, int kflag)
>  {
>  	struct btf_type *t;
>  	int sz, name_off = 0;
> @@ -2113,7 +2113,7 @@ static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, int ref
>  	}
>  
>  	t->name_off = name_off;
> -	t->info = btf_type_info(kind, 0, 0);
> +	t->info = btf_type_info(kind, 0, kflag);
>  	t->type = ref_type_id;
>  
>  	return btf_commit_type(btf, sz);
> @@ -2128,7 +2128,7 @@ static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, int ref
>   */
>  int btf__add_ptr(struct btf *btf, int ref_type_id)
>  {
> -	return btf_add_ref_kind(btf, BTF_KIND_PTR, NULL, ref_type_id);
> +	return btf_add_ref_kind(btf, BTF_KIND_PTR, NULL, ref_type_id, 0);
>  }
>  
>  /*
> @@ -2506,7 +2506,7 @@ int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind)
>  		struct btf_type *t;
>  		int id;
>  
> -		id = btf_add_ref_kind(btf, BTF_KIND_FWD, name, 0);
> +		id = btf_add_ref_kind(btf, BTF_KIND_FWD, name, 0, 0);
>  		if (id <= 0)
>  			return id;
>  		t = btf_type_by_id(btf, id);
> @@ -2536,7 +2536,7 @@ int btf__add_typedef(struct btf *btf, const char *name, int ref_type_id)
>  	if (!name || !name[0])
>  		return libbpf_err(-EINVAL);
>  
> -	return btf_add_ref_kind(btf, BTF_KIND_TYPEDEF, name, ref_type_id);
> +	return btf_add_ref_kind(btf, BTF_KIND_TYPEDEF, name, ref_type_id, 0);
>  }
>  
>  /*
> @@ -2548,7 +2548,7 @@ int btf__add_typedef(struct btf *btf, const char *name, int ref_type_id)
>   */
>  int btf__add_volatile(struct btf *btf, int ref_type_id)
>  {
> -	return btf_add_ref_kind(btf, BTF_KIND_VOLATILE, NULL, ref_type_id);
> +	return btf_add_ref_kind(btf, BTF_KIND_VOLATILE, NULL, ref_type_id, 0);
>  }
>  
>  /*
> @@ -2560,7 +2560,7 @@ int btf__add_volatile(struct btf *btf, int ref_type_id)
>   */
>  int btf__add_const(struct btf *btf, int ref_type_id)
>  {
> -	return btf_add_ref_kind(btf, BTF_KIND_CONST, NULL, ref_type_id);
> +	return btf_add_ref_kind(btf, BTF_KIND_CONST, NULL, ref_type_id, 0);
>  }
>  
>  /*
> @@ -2572,7 +2572,7 @@ int btf__add_const(struct btf *btf, int ref_type_id)
>   */
>  int btf__add_restrict(struct btf *btf, int ref_type_id)
>  {
> -	return btf_add_ref_kind(btf, BTF_KIND_RESTRICT, NULL, ref_type_id);
> +	return btf_add_ref_kind(btf, BTF_KIND_RESTRICT, NULL, ref_type_id, 0);
>  }
>  
>  /*
> @@ -2588,7 +2588,24 @@ int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
>  	if (!value || !value[0])
>  		return libbpf_err(-EINVAL);
>  
> -	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id);
> +	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id, 0);
> +}
> +
> +/*
> + * Append new BTF_KIND_TYPE_TAG type with:
> + *   - *value*, non-empty/non-NULL tag value;
> + *   - *ref_type_id* - referenced type ID, it might not exist yet;
> + * Set info->kflag to 1, indicating this tag is an __attribute__
> + * Returns:
> + *   - >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id)
> +{
> +	if (!value || !value[0])
> +		return libbpf_err(-EINVAL);
> +
> +	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id, 1);
>  }
>  
>  /*
> @@ -2610,7 +2627,7 @@ int btf__add_func(struct btf *btf, const char *name,
>  	    linkage != BTF_FUNC_EXTERN)
>  		return libbpf_err(-EINVAL);
>  
> -	id = btf_add_ref_kind(btf, BTF_KIND_FUNC, name, proto_type_id);
> +	id = btf_add_ref_kind(btf, BTF_KIND_FUNC, name, proto_type_id, 0);
>  	if (id > 0) {
>  		struct btf_type *t = btf_type_by_id(btf, id);
>  
> @@ -2845,18 +2862,9 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
>  	return 0;
>  }
>  
> -/*
> - * Append new BTF_KIND_DECL_TAG type with:
> - *   - *value* - non-empty/non-NULL string;
> - *   - *ref_type_id* - referenced type ID, it might not exist yet;
> - *   - *component_idx* - -1 for tagging reference type, otherwise struct/union
> - *     member or function argument index;
> - * Returns:
> - *   - >0, type ID of newly added BTF type;
> - *   - <0, on error.
> - */
> -int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
> -		 int component_idx)
> +
> +static int __btf__add_decl_tag(struct btf *btf, const char *value,
> +		 int ref_type_id, int component_idx, int kflag)
>  {
>  	struct btf_type *t;
>  	int sz, value_off;
> @@ -2880,13 +2888,46 @@ int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
>  		return value_off;
>  
>  	t->name_off = value_off;
> -	t->info = btf_type_info(BTF_KIND_DECL_TAG, 0, false);
> +	t->info = btf_type_info(BTF_KIND_DECL_TAG, 0, kflag);
>  	t->type = ref_type_id;
>  	btf_decl_tag(t)->component_idx = component_idx;
>  
>  	return btf_commit_type(btf, sz);
>  }
>  
> +/*
> + * Append new BTF_KIND_DECL_TAG type with:
> + *   - *value* - non-empty/non-NULL string;
> + *   - *ref_type_id* - referenced type ID, it might not exist yet;
> + *   - *component_idx* - -1 for tagging reference type, otherwise struct/union
> + *     member or function argument index;
> + * Returns:
> + *   - >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
> +		 int component_idx)
> +{
> +	return __btf__add_decl_tag(btf, value, ref_type_id, component_idx, 0);
> +}
> +
> +/*
> + * Append new BTF_KIND_DECL_TAG type with:
> + *   - *value* - non-empty/non-NULL string;
> + *   - *ref_type_id* - referenced type ID, it might not exist yet;
> + *   - *component_idx* - -1 for tagging reference type, otherwise struct/union
> + *     member or function argument index;
> + * Set info->kflag to 1, indicating this tag is an __attribute__
> + * Returns:
> + *   - >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id,
> +		 int component_idx)
> +{
> +	return __btf__add_decl_tag(btf, value, ref_type_id, component_idx, 1);
> +}
> +
>  struct btf_ext_sec_info_param {
>  	__u32 off;
>  	__u32 len;
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 47ee8f6ac489..1c969a530a3e 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -227,6 +227,7 @@ LIBBPF_API int btf__add_volatile(struct btf *btf, int ref_type_id);
>  LIBBPF_API int btf__add_const(struct btf *btf, int ref_type_id);
>  LIBBPF_API int btf__add_restrict(struct btf *btf, int ref_type_id);
>  LIBBPF_API int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id);
> +LIBBPF_API int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id);
>  
>  /* func and func_proto construction APIs */
>  LIBBPF_API int btf__add_func(struct btf *btf, const char *name,
> @@ -243,6 +244,8 @@ LIBBPF_API int btf__add_datasec_var_info(struct btf *btf, int var_type_id,
>  /* tag construction API */
>  LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
>  			    int component_idx);
> +LIBBPF_API int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id,
> +			    int component_idx);
>  
>  struct btf_dedup_opts {
>  	size_t sz;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index a8b2936a1646..8616e10b3c1b 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -436,4 +436,6 @@ LIBBPF_1.6.0 {
>  		bpf_linker__add_buf;
>  		bpf_linker__add_fd;
>  		bpf_linker__new_fd;
> +                btf__add_decl_attr;
> +                btf__add_type_attr;
>  } LIBBPF_1.5.0;


