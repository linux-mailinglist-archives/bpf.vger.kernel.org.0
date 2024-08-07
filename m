Return-Path: <bpf+bounces-36587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B294AE76
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 18:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA69B2348A
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 16:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160413AD1D;
	Wed,  7 Aug 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T/Zq6Nzi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BgqwW2/l"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710184D02;
	Wed,  7 Aug 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049656; cv=fail; b=Z40QVfLPskkGs26p9Lof0/cbZL4elpPH+7p+3AvJyaej75XHuofTEy2cB7sicfSWzu1Gtrn78oU5/CFiYy6AfpEUfN1+Ke0apy5+bEJJfT+zgzgClOvv1XHIErTL+mC7/SY0wJItVD3Nt5ZBpznVkPqcnfh6X/Oj+o8mGhbwcNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049656; c=relaxed/simple;
	bh=s9iGgrT3U9yrDWH1XJKt1EmMjRmyoOnNioPvngeGv1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V3/zRdUvNe0Gbc3CZR5ZEUwmzss9HrpWpjZ4hfSTUOb412Vg062d6LbUhoFVvRhLNOoc6pQRouEQJYcaM8oIZxBvcGJIFKG/tXA/SjRoN/Smqu0DobK2yQJa3uuf8vOlMQ6qRMYP/ZlKWkdZsKgR4ZSP+qUwVyQ+oEDG5GMte+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T/Zq6Nzi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BgqwW2/l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477EBYLY026050;
	Wed, 7 Aug 2024 16:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=fhJAh8o07wRAqpw18CxE+H96TFAeaWUMozRYZalVYEc=; b=
	T/Zq6NziX9e+9vJbUpMFNO+dM1sFrXqs0nEiPH5FvaLTiNEit1lUgb2jN3lc4q+l
	r0ykXxuh3u/7bpW3EHHtvZHG19rYBC9NB3RxNgoWPQDuetN6uKpGvwsfVd0dB8xi
	ctlwWvGgwfMYPJkzU3/iVperVrRiEKIDJ/KJ95G60x789wZU8wINJsIvN+CTYHy+
	Ic9uhgx3vd/5ZPMZyzuAVobiZhfjKzvheWD9ysbxSUIEuzHyfBzYe6DfrZfXLL4H
	z9vSID1eqlxueAdPF+OkvR8Suufqy5MM8Azh+6qAB0y/nWrn490gypUd2dlWWSW0
	1g4w1ogDFy/HvR2DO9BECg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40saye80jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 16:53:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477G69U2035130;
	Wed, 7 Aug 2024 16:53:42 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0aj2u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 16:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foVi3UohWNKiaZPFGvlVZH24K5G62AcinZbeL8RKWcQBz9Lk6kaVgnMEQ2xki/7v5DbV4KiIITpOFZKp4OFoeBUxPdRQLiDGuV/7RJE5JZ/lUQR7Zkd4fwYCZvkr/Yj9JN8ASnBH86KksGF+vzxYFASokDHYJ20TOjwFhpt0UOAT218lUdaWXTxGcXMxKaO793YnrBOgiY+C4WMS/sEpAd7m/nczVwuhAeIus/u63m3/9B5+8MZA2Q4/j7UZ6vLKE6GBqZWkLiclkLiFyVDLxVJBobWSG3bVNLY5ad0enmERSoE80WvZKt9iz6wgak5XljZEL/xZMqdqnVX69LPXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhJAh8o07wRAqpw18CxE+H96TFAeaWUMozRYZalVYEc=;
 b=aYw+Wp23ThbD7VhnozxSCKxWyPJgC6RSgOuQ1C9YyDmKDLBmEkACMXe45BpVNOUXZ6JzRzDgT9Dk0B1T++gqo3m/VaMeNH1lMF1+X+I8P40gtPE5YOric9gCMGsuSGVCN9smgvs/3BP86W969sPkPiphIZM8r1UzcDBwuLl+tmm5zfPlH2B33ROwD6tWMY0/QZ5LZBcIuzGbKOcK/dmsbEZ7uTgiyslHpfMxzgsHXUw3fgQCvtEMGfQRChhM56TgJyADqO5kzDzMwuw+4EyXg/jPvLiza/LAj8fxwmKoOIKfetIsQRD72MEdLQ/zJMzpqaVp0xWjPA7n006Odmt/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhJAh8o07wRAqpw18CxE+H96TFAeaWUMozRYZalVYEc=;
 b=BgqwW2/lTU8VQlsOYNHCGteVNXfmdfnga2mk93v3Ha8phWldxnrR5oBQZOadoUhyEOjyFCJ4haI7zf2kAvC7UabRrvOBXsSek6JK25jCJhu07zrBecog3dzZAdApJu9IYcHq4Qf5Vsxyrr8WNiCt7pI5J0WNXIy4SFuhSO5yczw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 16:53:19 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7849.013; Wed, 7 Aug 2024
 16:53:19 +0000
Message-ID: <659e71b8-e714-4141-901f-3b494a49a9e9@oracle.com>
Date: Wed, 7 Aug 2024 17:53:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: remove __btf_name_valid() and change to
 btf_name_valid_identifier()
To: Jeongjun Park <aha310510@gmail.com>, martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240807143110.181497-1-aha310510@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240807143110.181497-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 546065b5-de48-4f6f-af53-08dcb7017055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVpRZ2FWMDRXTDdna0RDczV0QzBDMlVnYnoyUHVqeWppYzczdU5Vdy84UW53?=
 =?utf-8?B?dWxPUm1hTGVGenNrcTBIT2IyNEg2d0dxSzQyeFdQMU1lSFlKRUhMSkU1MWtq?=
 =?utf-8?B?REMwM0ViNm40UE1YNUN0ZWRpMDI4TUV2S3VOak9ucE5MOHNKaXJnWlR5eDFK?=
 =?utf-8?B?TU1sZHhwWmI5TVUvaU9Yb1R0VUFLZ0JWT1lxL3F3cm56UHJ1M25HVitlMEhp?=
 =?utf-8?B?bk8wdGRxcE9jWWRuQnFwZ2FBaHZnakROR1B2bWxWcVdFbnVZYVI5bDdPYzZx?=
 =?utf-8?B?T3g4MnJuVXVpUm1pVld6cEFMc0FTVWJDVC9uaWl5SlFIWjcrSSs2YmozbGQ3?=
 =?utf-8?B?WmlzNDYyZEFTbnY1c25kMDlqMGhQdFpjOUdnTkdVdFAvb2pqRlhpZEQ2NlUx?=
 =?utf-8?B?Y1grUmJqZ2NwYk5vc1cySDBLcFhtL2hsMnlTaVBudDVsK0JkRmlwekxGUTFQ?=
 =?utf-8?B?d0NBS3g3Y0NFY2J2Y1pqalRTaDNEZXZFVjg0QWFYSENCS0w5UWxCRFJ2OW9w?=
 =?utf-8?B?TWt2dldjdURSZmFNazRUQlorVTQ1MTFPUnZKVnJvbkZiV1JQTWxmUlA3bUtL?=
 =?utf-8?B?akNHaVlBZDg3VVZMQmVRWjFONldkVFlJM3ZlNXo1ZDlVYVlSNVNzUVJheVRQ?=
 =?utf-8?B?cnlUbWhEVDI0N2tNcDljUU9MZnNHQnFCWjdWSThkVGIzZjBUU3lFYjk0ZEF0?=
 =?utf-8?B?eXBVQUpYT0Z6MEh4d2YwaTMvT1BoZDZqZmdnLy8xY0g5ZFhzVXVSckw1RjFx?=
 =?utf-8?B?WjB3bmJ6M1g0TjkxNEhsZlQvcGxJamZKL0xQVWxxWlplSVozVnV2bXZHeW1U?=
 =?utf-8?B?UzBDOEpJRWQ2MDlXQ1EzQ3ZSZEdObU9SLzlHYVRqYXJhZVFJMEJRS0N6RUdr?=
 =?utf-8?B?S1l6RkEzc0hhWElSbUQvZzBhWlZPUy9VYmVBNWZHUjVUK0NlU09kL1YzV29T?=
 =?utf-8?B?Y2g1M1VNdTJMMHNFMU5rZXBtT1NXNTh3Tk9wNnMyMHRuNmZYM2l6V0NpTFJY?=
 =?utf-8?B?TTA5Y1JtK0dYcGQ0MHVTckdvZzI4UWVYbGVEcFNSa1pjSkJpZjRyNDkvSTVh?=
 =?utf-8?B?UG4ra3FmMXF3dnlwRnpINWpCZW9tUUErbXFOdkg3SGhMZzZOTERwZ3NnVmlX?=
 =?utf-8?B?ZGlVUzRHbTZuRG5pekRxOGhFVml5MVRydy9BS0UyZVJGOTY5eG1aazBCdkw1?=
 =?utf-8?B?V3FBZ2Q3Ylh4MDdSekNFcGVMQzN0YnZGK1lQcWVxNzdjQkExMm9XNE02VTh5?=
 =?utf-8?B?Z2Jrb0E3RDVsT1pzZW5wcEcvZVo2U2VaUTFDbmxRWlZ1RWNhL2FnL2NNcW9D?=
 =?utf-8?B?aXVmczF4WS9jNTZGYmRjY2lpZ2VqRjhmL3RyV0wvOWhibnhVZnJnejZUM1RI?=
 =?utf-8?B?dHMvM25LUnloMXZUejhlNFFGNmgyS0Q1SDdxcWFrb2pheDR4SWEvOGViY3Nn?=
 =?utf-8?B?aExDMytkY1VlaWRMeDFYelY2K0JCcngzK2h4M1lqTlpNanNEVW4zbFc2RHZW?=
 =?utf-8?B?VlJPQkxSZUdHZFJzeTVNYXNhbUswaTJvMGtNZlFGdFFJUXgycFFwWVFjdlpz?=
 =?utf-8?B?RjJJZlEyZjhBSlllakdwWUJQWnhHOEU4aSs2eU5QUzFGaVNLb3dKYmFpOEZx?=
 =?utf-8?B?QnA0NEtUbTJxTnBycklZQk5USDIxcHVRbUZ3WFVYRSs2K2VsMXFaZFppTTlZ?=
 =?utf-8?B?dXhQOG5yM3hvUEJNc1JkY3Vrc016aTVteTA0T0ZtYXNUaEZvdkdYa3B4d1k0?=
 =?utf-8?B?N2k5Ym9TY3Z4bVZ2WjRha0ExNGYvUDV2WDhhanhlblNpR1UzYjBEa3EyR2Fi?=
 =?utf-8?B?V0xocXc0U2FrTTEva1RCdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNKRkcyaWxqMGxNUTJ1Y2Z0Z2JwOU43K2ZvME1OSTBHcjJONkFuSzBzUys1?=
 =?utf-8?B?RXdWUndMT0xDZmE3am5aVGlSSmlXaU80MHF2MEVudjUzanI4bTdxOWtvbzdV?=
 =?utf-8?B?dzEyZXpxWXJucDJNc0hxV3lyaHY2WUcvWTZESkIzTXJTbEw5bDd0TGxuT3p2?=
 =?utf-8?B?blJwMmQ3Lzd1OU9ac0RTWndVbm0yVHQxMU5TTklXU281NFk5VjBFd1Q1QmhY?=
 =?utf-8?B?ZmVlRDhMK0RpQlBPSW9ZZ3ROekZTRVNNSE5xRnBnLzRscTBic3pqOFVIWVR4?=
 =?utf-8?B?WXVvL2pCRnVyUWFwTUZRalhGY3Y5Tlo5dC80eEZxRXVBVHBKYVpTWm9CVXUy?=
 =?utf-8?B?T3FBdXpFRkorWk5YaVdUU01hZitMQ0RWNnBGbmx5WFZFSlJjM2dLTjMrQ3FM?=
 =?utf-8?B?UzJWaXMzeG4vRFpOQkJyTUttaFpUaWg3dzIzcS94NUVpS0dSWnUyMWwzOXR1?=
 =?utf-8?B?eEJENlkrSTdkYmRzNTJuZTVMSC83emxYVlpxenZOd1VtamVmenBCeUk5SkU5?=
 =?utf-8?B?Z2ZvdzFZUUZ3aE10ZWlUMnhSaFNpUTJSWk1yUDd3elFCZDlFQVBPdFAvUy81?=
 =?utf-8?B?aEFrZkx2YWpmdy9rMVBKR3FXVVUyTDdtN0tDRVVYSTlWS1dwTjZBZVI0ZE1s?=
 =?utf-8?B?SHVGRkJSVTJwejIwbmZDcDlseWpyV0NyRmMxZTNDYVBFN0hScnNKTlJsRkwv?=
 =?utf-8?B?RkNCTlUxbVF1UjB6WXJReCtWY3UvQUx3c2U4TXpLMGdZZnBuQmErU2RVNE9o?=
 =?utf-8?B?dXNsWSthckIxQU01NFh3YVB3ak5oR3dKaGgvZ1FBVzlPalRwTGQ5OHpwNWpk?=
 =?utf-8?B?end0OXBlWGI1ZDgxSHYrQXFuK200NmF5VWZkYjNrbmV5UjZVRWk5a1ZLNll1?=
 =?utf-8?B?TitBbVB0ekpqWE91UElVdGZ2RGVZak0zRTJBejlvdnpLQ2JFRUs4dkx0SDFD?=
 =?utf-8?B?SGJ2ZitlTkZhWjR1Z25rNDV1N040bGE0MEdnWnVEalVjUFZCZ1F5R1ZYVUdh?=
 =?utf-8?B?ZnNHcHJ6VU8xa2hYZ2VxZUUzTk96ZTBXdC9IRkJpQzQ2NVFvdG5USXhoMTN0?=
 =?utf-8?B?Z0czZUVEUHhRUjZHdkNUaTVCVndTbG9QT1VQMmdnVzk5WW1CcG1NMkN5MmlF?=
 =?utf-8?B?SVdiN3ZaM1ppV08xZXdDMlJyTDVZakJIUW1ibStHZ1JZM1lqZ1hzQWFrbUhI?=
 =?utf-8?B?V0tSeDFOUmVrb1VDbTJkUThoY2ZXTjQzRWhMbXBONUtQVnllUzVxRmcwVEtT?=
 =?utf-8?B?Zk5NOHV5a3JhbWx6aWs2VFB2aC8yMGZDdjFQa1N3N1YwUXJ5UUxjcFNaSnpn?=
 =?utf-8?B?RGVpaUZuaDlyS2JTRjhVNFZacDBqSnFMSjZpMUlYOFB5alJIeUhQRzFaa3Ry?=
 =?utf-8?B?MTdXQngvMDNLOFYySytjeG5HSFNQWUl3VnlHYXNPc3BhSEZrMnZSYnY3eWts?=
 =?utf-8?B?ejdLSnNtRm4vUllYalc4VFhQdVpPR0t5ejRyRGhOQzJ6QU5laGowZzNFWHo3?=
 =?utf-8?B?YktjNFJEbmZ1UGVXQTRjTGMwVElHcnRkY3QyT0xHWVlPWGVHNCtLRUMySTdN?=
 =?utf-8?B?bU5nRCtMczk1U29EalZJcDMwK3F6UVR2VXQxSnptZlAvdE12TFh2YmN6LzBS?=
 =?utf-8?B?N0hjNkhMckVPblZkaXdObWhnS21wK2wyQUM1ZUhEZzNzTnJ6NVB5aCs3THNn?=
 =?utf-8?B?dHFENWZleFpYVFIxSU8wUTArV1dDZ05hVVVuOGxKdU9UZ1RzYm9yK0dzbnVI?=
 =?utf-8?B?enN0eHZGMGptYVlFQjNOTjg2QUVZME1Ra2l1ajc4RitTRXlobThNcmVib2tv?=
 =?utf-8?B?N0grMkJTbkw5enlaSzNscC9nK2xIME9Rcm1IOE5ySHBQOHhCa2xib2l0Y050?=
 =?utf-8?B?dExrMVJTZEVDWU4yYkRHcEp3aEYxeW9raXFQSlBvK0lLWS95ZWNoWEhENDdF?=
 =?utf-8?B?SUJTRlc1bmlGSjEvbm1hUHd4aXV3R0diNVNwYlp0NDd3ZjJGb00yVUhiLzVl?=
 =?utf-8?B?cVgwdndvZlZObC9sU3ZBOUYvTGVyd1ZtYmVLYmdIODNKd2gvTE1jckVUODI2?=
 =?utf-8?B?Z1BJNDlIanpXUnA5U2IyUEUva3Uyd0ZzbkV6RXd5TkJrbERvMmZjd1FZdUN1?=
 =?utf-8?B?WWJVKzc0MFlDQXdKMWltL3dGNVNnR05WV1BaSHdlY2lBZ1JlNXRKTWtXUE9o?=
 =?utf-8?Q?WhTGVa2P6fTpBEn0kzIYiuA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4IkZajLWuSKoDCWjP1V58K6ssS4UOj6VZu3AwPB5TCQufpLi8BMAO6lMNepVhhM//BPoevQtNg+EJCvXS99n/1n/yGoIlVIu7TcxtH6GlxxoDFiMSpgsT70zXLjI2VGjOtXu5wMv4YyZvM1vfGGG40ULEjM+4OZVkpQ/Q/Xz8hAJWo3JxfXE9Xo9pp0fG4KI/dO7U5I0Eg7nX/hhOQ0aKa091NluEatAbD828s+dAqM3Ab7k+1QG6kzR0PhLQOQg9GZVBYabnlWIQxgPE+xphNgukV/x7l2o+AdPRNlzeGe05PE7gXu+dbgaO4G+AnArP/ZGXSXLnaYpku2pVfgQ99M1mLaYh1oTFPFwfulDnMhs0vnE+p4PIhhE5Ln5TFxilxyEYjqFc/jR30nDIoIAV04iweTEnYeYk7TCPO1kBYgRw92qwOCIo1jaWAYFK+hZAmo9x5aAvYZmVYz6+TgXyhwLkTNtQcKoxHgaZJKxTclZx/2HPXWSUwVAHsJsZRhytORYAsTPp+/eXXGTNgxWNXgeYJq44r1Q6OqAUHTLEXsrgERhKTn06chjcqEdwRF/iqsxmsW/miu4RtYMt5IDi/RYHMbYbQR8ZY27bjuBwFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546065b5-de48-4f6f-af53-08dcb7017055
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 16:53:19.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkD+RgZ8OtlM6U2bs3iClAXwkLOWWxXZNiNKfm5uytV7ybIC7Qdx/j5wSjdAMsFnDPifC2qXECbYLlYf71ZysA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408070118
X-Proofpoint-ORIG-GUID: GPGVDAGOz1yIM9JpIHkAJoJIfPiB7ujR
X-Proofpoint-GUID: GPGVDAGOz1yIM9JpIHkAJoJIfPiB7ujR

On 07/08/2024 15:31, Jeongjun Park wrote:
> __btf_name_valid() can be completely replaced with 
> btf_name_valid_identifier, and since most of the time you already call 
> btf_name_valid_identifier instead of __btf_name_valid , it would be 
> appropriate to rename the __btf_name_valid function to 
> btf_name_valid_identifier and remove __btf_name_valid.
> 
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Looks good to me

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  kernel/bpf/btf.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 

