Return-Path: <bpf+bounces-36448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF78E94887C
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 06:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F30A1C21F54
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 04:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13245D477;
	Tue,  6 Aug 2024 04:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PDP3/3zn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Enphg+mZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59CCA35
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919762; cv=fail; b=awAr9XpfIUUY01wbSPB2ESVjJ/CMB0+0Q1fheTj1n0ddfmxHk5gvwpV5lTrQ7YUuXDg20KcFz8W+6u7j1TwaM6Neh1LlPRvWcXg+g4eeOR2VpLamDYgd2LJkNZpwBCnCea+nIWUe6Gb+Iwr6hVs9wDmjSfnVzR/Gvt75l4pLQRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919762; c=relaxed/simple;
	bh=/v92JxwYCbRsX8p7Om3rQY4/I2KJbvZ7+q7aszqqiSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Yrol3v2LTZsNzZoZArkeDP5dlx+0eXpR5e+seR2+EAURMV/sPoB+sy1qLAMFSNAjqULh14qTOuKxW+ZmNcxO2lIqqGDAi01zxVP4PtUs66DPugqIhJ8QQZd2Tm2IuQTsxo+sL6EIMcCuQKJzwU2sK8EvTmvWuAp/gR6VSTCpDVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PDP3/3zn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Enphg+mZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47620TYd029891;
	Tue, 6 Aug 2024 04:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=N3vOpQt4IJHAlAy7N21P4YZ4gUECKFGkDoWew745vSc=; b=
	PDP3/3zn3mJp9W5EDxRKl3KIkn0YOVdRW3uPHywztKFoDBykb6iBkbvlAZfabXug
	3HUgzsREvZhp/iEQ333MO6/00kAYCYJ/bUkHvFU8ja7RSHsEKhG82XCUYrfBQuTO
	Zvl5dwrm7gTKEW2ZZhYa61Y8iFB9fS6wIh1gY4hbfoSVbtO1ZglYh6eTKlDLLj0B
	myLXXeNtAM8Dz1SZPNjr0wZ87TMtBLey2mLtlMhkUeMPcQ93exhhLVp5v4k96jlC
	XP2MtiikMX34rmxscGiBrDWGBXfg1xCPFDO8EwBhZkdKGgxxXP064sDNBU+V2M3o
	iKJ+qqSq0XZ488bxihdBrA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sc5tcdk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 04:48:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4762t6LL004678;
	Tue, 6 Aug 2024 04:48:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0e6ksf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 04:48:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADqcUVHwvfjx7GdkbmJP2VPPUB+M3CErzGVZkU3XtJEQyoC7GpIpeXDlBneXuPdT7fMJUm33W4vd34tTJ9cyD1e0Ae2Z7X/C2BL9hgEavobfqJQ+ZsOYo8TONISw1NGaL2ApLd0TBqXO17Tzs9tazftqH4/PAMi8CLgUZdbgYpDUSp/euYLqxP8CU4+W3BO34i0vvEqewiYo3OVokiwPUmV96s5NiNDXn2i8MVtAhABiKvBrUk03LGxYMpanBcWc3THFmb7/5edLhlBbbfHLFRgGXJpJo41hpLmzVDVKthVRKQ9q3lIZOWRZoGAuIcCjpIDEOlD4krgKnRmKORdcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3vOpQt4IJHAlAy7N21P4YZ4gUECKFGkDoWew745vSc=;
 b=rKANyrSkEeQdeOaDyOePlp62dhNhirBumkGTL60eK2voRFKcgg9SQenzSJ2lonbo9AxHEvIEUm/CXTxvbq/Va0rJVps/5Y8Zts8M4iTy8R9eNABt6qIRKqhe3yl0QoHzHH81LV7qot8TRef2lasrmRUuQLdDst8+wJcW6BAFqKMl2IgndzYJe3skI560B5QnWP5dCSV7VW/oTG7C4sVVj/8GBSE34GIQMbeq2RA530V7wOUp4MnedS2B1kd4iJmQSQn6K8WGauMSHEQV4LW6wa34PcAWwj5hgWeSfu+TBoxYlvrUzrjy4KOYTY4uQdAL1WF2dERh0tUSp/I8kUUQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3vOpQt4IJHAlAy7N21P4YZ4gUECKFGkDoWew745vSc=;
 b=Enphg+mZLyMLj5j+MPUJ2IJ5IYT4EaA7l9lgqNxw03bEznoaAnEPJmbZCKHryNdVTvLK08Z3Wwu2TjMRPVziWqZOyd/0YE8Zn8oQS4WB5e9wdWMutiFafAuWME102esZ8WDRNYX7GwZxzuoA8s/n7SECv3dqM3uudlti4yCvx5k=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by BLAPR10MB4883.namprd10.prod.outlook.com (2603:10b6:208:334::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 04:48:53 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 04:48:53 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf
 <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau
 <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix arena_atomics selftest
 failure due to llvm change
In-Reply-To: <e42a26b6-1520-40b9-850a-28d660bd9149@linux.dev> (Yonghong Song's
	message of "Mon, 5 Aug 2024 15:36:17 -0700")
References: <20240803025928.4184433-1-yonghong.song@linux.dev>
	<CAADnVQKt8FQjuZKFTGbyf5uKGZ8gfjzSvC36CbZ7ENbkuCmopA@mail.gmail.com>
	<e42a26b6-1520-40b9-850a-28d660bd9149@linux.dev>
Date: Tue, 06 Aug 2024 06:48:49 +0200
Message-ID: <87cymmqmry.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::21) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|BLAPR10MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e3f965-2353-4dd1-d44a-08dcb5d3124a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmNXc1FERlZQaXlRdEwvTXFmdklHbEMyNWdRb3A5M3QvaStabDBBQzI1dlFZ?=
 =?utf-8?B?WTBwZzhRbmhjc3NORmNXbDZKVGhFMGVaRE9pWjd0RGJSUCtEWjhyd2k4Y2Jw?=
 =?utf-8?B?KzlHUEZEM0lJMnpRYU5aQk54VDNmL0l3WkYrK1pFeUgyWktYQWlzNmUzdW8z?=
 =?utf-8?B?RU5rVm9CUUkrWDhGYXMydE8zbHR4dHE5Y0pKWGs4MWpTZWpnTEd6WS9VY0U5?=
 =?utf-8?B?dWg4WXlIRjhhT1FWT2ZZSTRQaUpPZXYwczFEY3NIeHZhOXh4MWlzd1BVQWt5?=
 =?utf-8?B?NU1ORjFKcE9tVmlOMGpzKzQxK0dlUlB0ZnY2OUY2ZGxXbTQxaXFOMkU0a21U?=
 =?utf-8?B?a3ZWSFZ1bnJuWDlOT3RycG85MU9XOVdCZ3hTNk4xeUZVWDFhb09SYW4yYUEz?=
 =?utf-8?B?L1hydGhPSThHaW5MbjFHcVFKaFVjZEQ0cDlPSU9Ya0ZPUGVsaWMzZ3E5Q2xQ?=
 =?utf-8?B?MW9PZnBoQjFNR2hYakFzM2NVMVV1bllabTVkRS9VOHZHRmRqdVZ4L05PQXln?=
 =?utf-8?B?aDdSN2pSa1I5ckRiMlpDWjhCa2pVRzRRZ29BOS9MTmtld3MxZll2T2w4Q0FZ?=
 =?utf-8?B?L0lCc1ZjVFRvQ3ZkM0kyMStqNjllSGRLT2lzVGt5dE80V09jMzMvckNKV0Yy?=
 =?utf-8?B?cHI5U0RFOFQ0TlBiaUZzUDQ3YnVMTUUzb3hRNzVGUGJMLzMwVDg4T2VxcXJ6?=
 =?utf-8?B?MHV5dk9WM1o1bVkxZkpuNFd1WVNLeWh4Q3ZWai81RmU5VkNhd0NnSTVXdGVH?=
 =?utf-8?B?a3VoMnVsTjFvbzh2d1JjWGhjYWhTMTM1YWlaL3Bza2RoL0hQMkxPdkhGSW00?=
 =?utf-8?B?SERXL0NZS2NXMUQrc3NhN0lWbUN6dDk5c3hXOEpqUXpDR3ZONXMzdTJXcURB?=
 =?utf-8?B?Z2NjdWpVd1lGOVF0OHBjeVgvczE5a2VHc3dnaVN0MWhOcFpmaFNpNE1zbWxi?=
 =?utf-8?B?RVFwVkhzUmk1a00wQWpBSkhmKzE0MFg2a3BnZXJOMzl0cmkxYU94MXRObllJ?=
 =?utf-8?B?U2c5T2tITGp2dGpPaHZLbGt4cS90c05kZEZhZzUvZ0Y3MXg2b0JlTkhzcWNK?=
 =?utf-8?B?WThjZGZseEk2Y0Z1ZENjVTZWSDhHWjF4akZrcUkrUHBiMVAvZTdVdkpBSzNu?=
 =?utf-8?B?WmJ1Y2t4LzhXS1IxRDB4LzhVMTRMUzBzM0tNZWYzeDh5dnFlRVkzakcwS0Vz?=
 =?utf-8?B?Y3FjRlpwNnBtZWFXaEUrUVExSk5WMEVDM25MYm1XK05qRnkvc1VvUCtXNG96?=
 =?utf-8?B?RXQvS3dpRkhMWnVBQW40YjhhNTJybUtKMzhSM0R1WnRGcHlyL1BXbzBKS3lv?=
 =?utf-8?B?NUltTWhsT2JtaXNzVzEwdEF2SE5hSW5KRDdhS1FsZ2tiQTgyenVDY0Znak9K?=
 =?utf-8?B?WE5TUllCblNQb0dnY29Fcy9vRzV6UXAzaWh4c2xJTGVPbWZZNXJ1dGl0RG9G?=
 =?utf-8?B?T295eElHZkFQUDRTV1lDUFUwWHZLek9vZVNyOEhpZTFJbG8xK21qQTN1aDdl?=
 =?utf-8?B?YUgzSy9pQm9ZYS92cmFtcW9KT3JpWWJnTHJiTzZVcFNFc1BLall5eUdqbzV4?=
 =?utf-8?B?Tk1zYlVMdlJlSmV2NXI2N0x2N3VxdUk4N2s5M2pEcmI4NW1yTmRpcHFscys4?=
 =?utf-8?B?a0twTkI4bTJ5ckFlc1pKbld3MmFGcFYvQStyTzNyb0o0NFZ1cU1lMElubVQ1?=
 =?utf-8?B?bm5STWx0OXQ5QmZPZlM4Nkh1N3BGekZSYzRpVzV6ZkxMUE90bWhraVBaMTZZ?=
 =?utf-8?Q?2SW23iQaUDkZple6KM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFZuL3hTekNoZnZzbStac0l3QzhlWXp1MVpXYkZKTzZFQ2ZJQnpUNVdUTG5V?=
 =?utf-8?B?ZW9ZN2h2azRST3E5aW9xM0ZxNG9FZHg2RmVORUx4NUJBV24vbG9tS2NlZ2k2?=
 =?utf-8?B?R2VKTmFkVlNVM05YOEdNTGlXMmJjYmxlOUFnUnNMSXI3bC90blU1WlA5ODlW?=
 =?utf-8?B?S0JOSjhXblB3V0lEZ2FJVGI2bnMxYm1OY21valVrcU1rSE5NbHN0Z3FpZ3N3?=
 =?utf-8?B?Z2tvellPSTdtd2VrTUlBK2RzblpWbVVGb1EwcUgrU2RsSjJWQ2NLaWJhVVVM?=
 =?utf-8?B?ZEY0cjhWZzA0ajM3NGxWazhKNG1LU0k5QzZXYjMxNWhEcit0bTV6bHErN1pB?=
 =?utf-8?B?bk9vd2N4cVJVUHdHY0hwVisrV3ZUenBaMk5EckUvY2V0YTlUbkdiMDcyK2li?=
 =?utf-8?B?R0ZaZUVOaG5RWXg3OThUamR0aU5Zbi9IaGFqRmFmVDFDR3hJSDRzc01aZ3Y3?=
 =?utf-8?B?dmh4aW4xV1c1OTU2TUNHSFl4N3U3eVNJaUMyY0oyY1FLUS8rNmJZTzVwRDNZ?=
 =?utf-8?B?Zllic0o1QVl4Zy8veDlldWV4OS92dlhGMWlXSnMxWVY1RHp6ZDd0MXQ2TDVP?=
 =?utf-8?B?NXZMY2FvOHd6TzRWdUJvcllSd3JtUHAwZFNKcE9sWWRNU1JjUldoeEF3K1Iz?=
 =?utf-8?B?eldjUWQ3OEdBQ3FDNFVicGJEN0R3TmttaDZMZmJCc0J6a0N1aUYxdU5XSGlq?=
 =?utf-8?B?dE9vWXVTSkNQVTZ2cG80akROWWlHdFJqZks4NTdBdTVDNi9tTHpYTDhoalpV?=
 =?utf-8?B?QjZmZDNGMmxoam9tRm5tWVVidkl2dUFSU2NGVE1PakdCQmFtemJOVXNpYmNv?=
 =?utf-8?B?WlVOT053UU5JY29KS1JUanVpZ1lJeXRtdjZWei9KSjJXcTZrRjIveTgyVTZs?=
 =?utf-8?B?Q3l5RXRkK3MySU9QbU03SXVwUW5iR0JpVVhsRHlmeHcrcUZ2RElyeDU1Zytj?=
 =?utf-8?B?K1E3MFFRWmY4UllrNEwxbUdJVzdBblFKZzhzWXRIelBuSGxvU2lrcG54V0RB?=
 =?utf-8?B?WnVBYzRsVlByUnR6aEt5MGtSVFRCM2pPa1JRNjFjWTZQY3JRNkZUYUc4eVRl?=
 =?utf-8?B?aVlwNXRvWHNtVHl4eDc4dTd4VEE4bGcvK1FaSVJDZ0RRMm91Y2pNanlkaWZ0?=
 =?utf-8?B?azNENHZMMGJLMzZlWlFSTXNkdEdIY3VNSzJYUk1SVm9FN21ycUxOQjNMZGdm?=
 =?utf-8?B?a0tJaWVoS2YrZ0doaGY1d1c5Tm5JcUIrUU9aT1dJOW9ZSGxzNWd6YkUyMGpL?=
 =?utf-8?B?VXNwSDRiUDYzNFozNVVlRC9NUGJTZTZOY0lYMS9aZUh1YktmU1lZbFJISEJI?=
 =?utf-8?B?SWpnZnZHQnJVdkxyU2FCTnR3YVZKUzBzaW5uUHZxL1FkaTVsd3VSaFZ6bmxI?=
 =?utf-8?B?bGwxeWhmUG5zVWZ0STV6R0FubWpQS3lBVmhqb0QranBYbGlqZllrb3pOV3lh?=
 =?utf-8?B?M1ZPejhqZTAvSGY0YTIzaTRKekZRWHNTUmJXQndvYWdVUUhQeUk3NFcvUDMx?=
 =?utf-8?B?VGJoZUZ2UStybFYySHFYL1dxRGdCbTBMbFNLYXRNeVlneXlmRFl5SVBiY0VW?=
 =?utf-8?B?b3FDa0FxdVk0cndHK2dKV0pDMncreUt6WmNTK1JOblYvVmRZbHBYc2FVSGZT?=
 =?utf-8?B?ZnpmRXNSWFdMMGlaSHlUSEo0bEhUUmpYS0dsa1NBaTBmbXdWUnZkd2dHdVVp?=
 =?utf-8?B?SllWb0hSZVEzbWdZNFpzZHU4OVExaW5sdzMrTVZidVBsNnpGOGZpRjZSVzdX?=
 =?utf-8?B?WWV4Zk9oZVNEWGpOUzV4bTRWcCtDY2JxUjVHNU8zQ253NnlXcmh4NThwMjBy?=
 =?utf-8?B?UTF5aVNOajdLNnlpaUpGUDVXQy9kcWNtWnhxSmUwY1RSTTFqREhLdFBwUmV2?=
 =?utf-8?B?MGUwZ1o3WXAya1ZPKzN6MWxyM2VzdU9OSk5tbW9VbVhKU1ZpZzVOUGxIZ2d6?=
 =?utf-8?B?MXJoVUhDcmd2eGMwZjVGVEkxY2NFRmcrRFdCYXJ2UDYzeEVjcHA5Qi93Y2tn?=
 =?utf-8?B?RkEvRVcvTHA0NmlnSGJBdUJYdjhhTlZoS2huR1pJTUozeDZaNm5wRlZpMG9L?=
 =?utf-8?B?OGRKc0FxU0l2WkUyY2VuZXhPOHR1MmhxdjJVLzRWYVUyNVlZcXI5WnVLeFM3?=
 =?utf-8?B?NjF3V2FhaDVMZ2lacHhmR3BpcWc4RnhRNmgyRHJuSDFaSVVZcmVIa3k1U2Vt?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DuH3eCaLvEY6X6E8U9B88Awx3Kxqev6flR4pza0hrSFnb4JRwMnLPVPKpIgmODNjkDe8qryul7hykR9WKxr4HV2TorfMcsUGz8MPKuqOIxVrgWZ7o1eieYbm2jLYH67arzgeh8KPhl/BBNa3W7BiujAGhEkJsgZT0vATc3pgJm/vIdXyM+DFO6OBYtPyaIILPssROpLznyWmjJGwYNxkSRM3v3W0YpYrpGB1tKEvpKfmk79PeQIrTiGHfqnayeyWfh7a5tAShYqlklBDlFRxiu01nuAUYmJbzBItUNEAZoATXZd1WuK1uGJHYV5as18UiOotfek09om0WCwd3kawOBusYcx8hoPeL84NeqOxi9CsN0ZqcJY2eZfqOi0xXor6nEG9Ox3nLScaUbDus1nj2SWtbLyg0xCkP1jDFN1AX5XbBZiiHckegf5iThd6jy/65RegsL4/dxT8ioAkg26ruv1H7zdwY2YYvCkjPTTPPXZ2INxLPxKZWIUYOej0rDExxOphZx1hwpXkPoKaVFQegrXAIQ6Kosi3i05NiUpnr7zZ8ugOiFvSWCJO5sLsR7UkdLb1TIJ0fwadDemIEOrVI72VIGKrPQzdPEhcls5+y7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e3f965-2353-4dd1-d44a-08dcb5d3124a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 04:48:53.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emkVrR8Dw858aiOaxInqX8X3TpP4AEoSlDeY+B1iTrCfSnX+blQWRhUqYjBCj+Kf27YpEoaMT9BakevDSAUYstd4HeJvcbTTrjyOeV1LdX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_03,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408060033
X-Proofpoint-ORIG-GUID: 4aRtvSppeVu13KARmeQMMPAxUVw-Sh67
X-Proofpoint-GUID: 4aRtvSppeVu13KARmeQMMPAxUVw-Sh67


> On 8/5/24 10:53 AM, Alexei Starovoitov wrote:
>> On Fri, Aug 2, 2024 at 7:59=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
>>> Peilen Ye reported an issue ([1]) where for __sync_fetch_and_add(...) w=
ithout
>>> return value like
>>>    __sync_fetch_and_add(&foo, 1);
>>> llvm BPF backend generates locked insn e.g.
>>>    lock *(u32 *)(r1 + 0) +=3D r2
>>>
>>> If __sync_fetch_and_add(...) returns a value like
>>>    res =3D __sync_fetch_and_add(&foo, 1);
>>> llvm BPF backend generates like
>>>    r2 =3D atomic_fetch_add((u32 *)(r1 + 0), r2)
>>>
>>> But 'lock *(u32 *)(r1 + 0) +=3D r2' caused a problem in jit
>>> since proper barrier is not inserted based on __sync_fetch_and_add() se=
mantics.
>>>
>>> The above discrepancy is due to commit [2] where it tries to maintain b=
ackward
>>> compatability since before commit [2], __sync_fetch_and_add(...) genera=
tes
>>> lock insn in BPF backend.
>>>
>>> Based on discussion in [1], now it is time to fix the above discrepancy=
 so we can
>>> have proper barrier support in jit. llvm patch [3] made sure that __syn=
c_fetch_and_add(...)
>>> always generates atomic_fetch_add(...) insns. Now 'lock *(u32 *)(r1 + 0=
) +=3D r2' can only
>>> be generated by inline asm. The same for __sync_fetch_and_and(), __sync=
_fetch_and_or()
>>> and __sync_fetch_and_xor().
>>>
>>> But the change in [3] caused arena_atomics selftest failure.
>>>
>>>    test_arena_atomics:PASS:arena atomics skeleton open 0 nsec
>>>    libbpf: prog 'and': BPF program load failed: Permission denied
>>>    libbpf: prog 'and': -- BEGIN PROG LOAD LOG --
>>>    arg#0 reference type('UNKNOWN ') size cannot be determined: -22
>>>    0: R1=3Dctx() R10=3Dfp0
>>>    ; if (pid !=3D (bpf_get_current_pid_tgid() >> 32)) @ arena_atomics.c=
:87
>>>    0: (18) r1 =3D 0xffffc90000064000       ; R1_w=3Dmap_value(map=3Dare=
na_at.bss,ks=3D4,vs=3D4)
>>>    2: (61) r6 =3D *(u32 *)(r1 +0)          ; R1_w=3Dmap_value(map=3Dare=
na_at.bss,ks=3D4,vs=3D4) R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,va=
r_off=3D(0x0; 0xffffffff))
>>>    3: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
>>>    4: (77) r0 >>=3D 32                     ; R0_w=3Dscalar(smin=3D0,sma=
x=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
>>>    5: (5d) if r0 !=3D r6 goto pc+11        ; R0_w=3Dscalar(smin=3D0,sma=
x=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R6_w=3Dscalar(smin=3D0,s=
max=3Dumax=3D0xffffffff,var_off=3D(0x0; 0x)
>>>    ; __sync_fetch_and_and(&and64_value, 0x011ull << 32); @ arena_atomic=
s.c:91
>>>    6: (18) r1 =3D 0x100000000060           ; R1_w=3Dscalar()
>>>    8: (bf) r1 =3D addr_space_cast(r1, 0, 1)        ; R1_w=3Darena
>>>    9: (18) r2 =3D 0x1100000000             ; R2_w=3D0x1100000000
>>>    11: (db) r2 =3D atomic64_fetch_and((u64 *)(r1 +0), r2)
>>>    BPF_ATOMIC stores into R1 arena is not allowed
>>>    processed 9 insns (limit 1000000) max_states_per_insn 0 total_states=
 0 peak_states 0 mark_read 0
>>>    -- END PROG LOAD LOG --
>>>    libbpf: prog 'and': failed to load: -13
>>>    libbpf: failed to load object 'arena_atomics'
>>>    libbpf: failed to load BPF skeleton 'arena_atomics': -13
>>>    test_arena_atomics:FAIL:arena atomics skeleton load unexpected error=
: -13 (errno 13)
>>>    #3       arena_atomics:FAIL
>>>
>>> The reason of the failure is due to [4] where atomic{64,}_fetch_{and,or=
,xor}() are not
>>> allowed by arena addresses. Without llvm patch [3], the compiler will g=
enerate 'lock ...'
>>> insn and everything will work fine.
>>>
>>> This patch fixed the problem by using inline asms. Instead of __sync_fe=
tch_and_{and,or,xor}() functions,
>>> the inline asm with 'lock' insn is used and it will work with or withou=
t [3].
>>> Note that three bpf programs ('and', 'or' and 'xor') are guarded with _=
_BPF_FEATURE_ADDR_SPACE_CAST
>>> as well to ensure compilation failure for llvm <=3D 18 version. Note th=
at for llvm <=3D 18 where
>>> addr_space_cast is not supported, all arena_atomics subtests are skippe=
d with below message:
>>>    test_arena_atomics:SKIP:no ENABLE_ATOMICS_TESTS or no addr_space_cas=
t support in clang
>>>    #3 arena_atomics:SKIP
>>>
>>>    [1] https://lore.kernel.org/bpf/ZqqiQQWRnz7H93Hc@google.com/T/#mb68d=
67bc8f39e35a0c3db52468b9de59b79f021f
>>>    [2] https://github.com/llvm/llvm-project/commit/286daafd65129228e08a=
1d07aa4ca74488615744
>>>    [3] https://github.com/llvm/llvm-project/pull/101428
>>>    [4] d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena=
 to x86 JIT")
>>>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   .../selftests/bpf/progs/arena_atomics.c       | 63 ++++++++++++++++--=
-
>>>   1 file changed, 54 insertions(+), 9 deletions(-)
>>>
>>> Changelog:
>>>    v1 -> v2:
>>>      - Add __BPF_FEATURE_ADDR_SPACE_CAST to guard newly added asm codes=
 for llvm >=3D 19
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/=
testing/selftests/bpf/progs/arena_atomics.c
>>> index bb0acd79d28a..dea54557fc00 100644
>>> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
>>> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
>>> @@ -5,6 +5,7 @@
>>>   #include <bpf/bpf_tracing.h>
>>>   #include <stdbool.h>
>>>   #include "bpf_arena_common.h"
>>> +#include "bpf_misc.h"
>>>
>>>   struct {
>>>          __uint(type, BPF_MAP_TYPE_ARENA);
>>> @@ -85,10 +86,24 @@ int and(const void *ctx)
>>>   {
>>>          if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
>>>                  return 0;
>>> -#ifdef ENABLE_ATOMICS_TESTS
>>> +#if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_=
CAST)
>>>
>>> -       __sync_fetch_and_and(&and64_value, 0x011ull << 32);
>>> -       __sync_fetch_and_and(&and32_value, 0x011);
>>> +       asm volatile(
>>> +               "r1 =3D addr_space_cast(%[and64_value], 0, 1);"
>>> +               "lock *(u64 *)(r1 + 0) &=3D %[val]"
>>> +               :
>>> +               : __imm_ptr(and64_value),
>>> +                 [val]"r"(0x011ull << 32)
>>> +               : "r1"
>>> +       );
>>> +       asm volatile(
>>> +               "r1 =3D addr_space_cast(%[and32_value], 0, 1);"
>>> +               "lock *(u32 *)(r1 + 0) &=3D %[val]"
>>> +               :
>>> +               : __imm_ptr(and32_value),
>>> +                 [val]"w"(0x011)
>>> +               : "r1"
>>> +       );
>> Instead of inline asm there is a better way to do the same in C.
>> https://godbolt.org/z/71PYx1oqE
>>
>> void foo(int a, _Atomic int *b)
>> {
>>   *b +=3D a;
>> }
>>
>> generates:
>> lock *(u32 *)(r2 + 0) +=3D r1
>
> If you use latest llvm-project with
> https://github.com/llvm/llvm-project/pull/101428
> included, the above code will generate like
>
> $ clang --target=3Dbpf -O2 -c t.c && llvm-objdump -d t.o
> t.o:    file format elf64-bpf
> Disassembly of section .text:
> 0000000000000000 <foo>:
>        0:       c3 12 00 00 01 00 00 00 r1 =3D atomic_fetch_add((u32 *)(r=
2 + 0x0), r1)
>        1:       95 00 00 00 00 00 00 00 exit
>
>
> With -mcpu=3Dv3 the same code can be generated.

Same for current GCC.

>>
>> but
>> *b &=3D a;
>>
>> crashes llvm :( with
>>
>> <source>:3:5: error: unsupported atomic operation, please use 64 bit ver=
sion
>>      3 |  *b &=3D a;
>
> It failed with the following llvm error message:
> t.c:1:6: error: unsupported atomic operation, please use 64 bit version
>     1 | void foo(int a, _Atomic int *b)
>       |      ^
> fatal error: error in backend: Cannot select: t8: i64,ch =3D AtomicLoadAn=
d<(load store seq_cst (s32) on %ir.b)> t0, t4, t2
>   t4: i64,ch =3D CopyFromReg t0, Register:i64 %1
>     t3: i64 =3D Register %1
>   t2: i64,ch =3D CopyFromReg t0, Register:i64 %0
>     t1: i64 =3D Register %0
> In function: foo
>
>>
>> but works with -mcpu=3Dv3
>
> Yes. it does work with -mcpu=3Dv3:

In GCC if you specify -mcpu=3Dv2 and use atomic built-ins you get
workaround code in the form of libcalls (like calls to
__atomic_fetch_and_4) which are of course of no use in BPF atm.

> $ clang --target=3Dbpf -O2 -mcpu=3Dv3 -c t.c && llvm-objdump -d --mcpu=3D=
v3 t.o
>
> t.o:=C2=A0=C2=A0=C2=A0 file format elf64-bpf
> Disassembly of section .text:
> 0000000000000000 <foo>:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 c3 12 00 00 51 00 00 00 w1 =3D atomic_fetch_and((u32 *)(r2 + 0x0), w1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 95 00 00 00 00 00 00 00 exit
>
> NOTE: I need -mcpu=3Dv3 for llvm-objdump to print asm code 'atomic_fetch_=
and' properly.
> Will double check this.

The GNU binutils objdump will try to recognize instructions in the
latest supported cpu version, unless an explicit option is passed to
specify a particular ISA version:

$ bpf-unknown-none-objdump -M pseudoc -d foo.o

foo.o:     file format elf64-bpfle


Disassembly of section .text:

0000000000000000 <foo>:
   0:	bf 11 20 00 00 00 00 00 	r1 =3D (s32) r1
   8:	c3 12 00 00 51 00 00 00 	w1=3Datomic_fetch_and((u32*)(r2+0),w1)
  10:	95 00 00 00 00 00 00 00 	exit

$ bpf-unknown-none-objdump -M v2,pseudoc -d foo.o

foo.o:     file format elf64-bpfle


Disassembly of section .text:

0000000000000000 <foo>:
   0:	bf 11 20 00 00 00 00 00 	r1=3Dr1
   8:	c3 12 00 00 51 00 00 00 	<unknown>
  10:	95 00 00 00 00 00 00 00 	exit

> For code:
> void foo(int a, _Atomic int *b)
> {
>  *b &=3D a;
> }
>
> The initial IR generated by clang frontend is:
>
> define dso_local void @foo(i32 noundef %a, ptr noundef %b) #0 {
> entry:
>   %a.addr =3D alloca i32, align 4
>   %b.addr =3D alloca ptr, align 8
>   store i32 %a, ptr %a.addr, align 4, !tbaa !3
>   store ptr %b, ptr %b.addr, align 8, !tbaa !7
>   %0 =3D load i32, ptr %a.addr, align 4, !tbaa !3
>   %1 =3D load ptr, ptr %b.addr, align 8, !tbaa !7
>   %2 =3D atomicrmw and ptr %1, i32 %0 seq_cst, align 4
>   %3 =3D and i32 %2, %0
>   ret void
> }
>
> Note that atomicrmw in the above. Eventually it optimized to
>
> define dso_local void @foo(i32 noundef %a, ptr noundef %b) #0 {
> entry:
>   %0 =3D atomicrmw and ptr %b, i32 %a seq_cst, align 4
>   ret void
> }
>
> The 'atomicrmw' is the same IR as generated by
> __sync_fetch_and_*() and eventually will generate atomic_fetch_*() bpf
> insn.
> Discussed with Andrii, and
> another option is to specify relaxed consistency, so llvm
> internal could translate it into locked insn. For example,
>
> $ cat t1.c
> #include <stdatomic.h>
>
> void f(_Atomic int *i) {
>   __c11_atomic_fetch_and(i, 1, memory_order_relaxed);
> }

I think this makes sense.  Currently we removed the GCC insns
atomic_{add,or,xor,and} all together so the compiler is forced to
implement them in terms of atomic_fetch_and_{add,or,xor,and} regardless
of the memory ordering policy specified to the __sync_fetch_and_OP.  So
even if you specify relaxed memory ordered, the resulting ordering is
whatever implied by the fetching operation.

> # to have gnu/stubs-32.h in the current directory to make it compile
> [yhs@devvm1513.prn0 ~/tmp6]$ ls gnu
> stubs-32.h
> [yhs@devvm1513.prn0 ~/tmp6]$ clang --target=3Dbpf -O2 -I. -c -mcpu=3Dv3 t=
1.c
>
> The initial IR:
> define dso_local void @f(ptr noundef %i) #0 {
> entry:
>   %i.addr =3D alloca ptr, align 8
>   %.atomictmp =3D alloca i32, align 4
>   %atomic-temp =3D alloca i32, align 4
>   store ptr %i, ptr %i.addr, align 8, !tbaa !3
>   %0 =3D load ptr, ptr %i.addr, align 8, !tbaa !3
>   store i32 1, ptr %.atomictmp, align 4, !tbaa !7
>   %1 =3D load i32, ptr %.atomictmp, align 4
>   %2 =3D atomicrmw and ptr %0, i32 %1 monotonic, align 4
>   store i32 %2, ptr %atomic-temp, align 4
>   %3 =3D load i32, ptr %atomic-temp, align 4, !tbaa !7
>   ret void
> }
>
> The IR right before machine code generation:
>
> define dso_local void @f(ptr nocapture noundef %i) local_unnamed_addr #0 =
{
> entry:
>   %0 =3D atomicrmw and ptr %i, i32 1 monotonic, align 4
>   ret void
> }
>
> Maybe we could special process the above to generate
> a locked insn if
>   - atomicrmw operator
>   - monotonic (related) consistency
>   - return value is not used
>
> So this will not violate original program semantics.
> Does this sound a reasonable apporach?

Whether monotonic consistency is desired (ordered writes) can be
probably deduced from the memory_order_* flag of the built-ins, but I
don't know what atomiccrmw is...  what is it in non-llvm terms?

>>
>> So let's make this test mcpu=3Dv3 only and use normal C ?
>>
>> pw-bot: cr

