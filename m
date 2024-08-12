Return-Path: <bpf+bounces-36894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51CA94EF04
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 15:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216CAB24891
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 13:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1218B17C219;
	Mon, 12 Aug 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OJNtrrCR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xaOcv1S+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E178549647;
	Mon, 12 Aug 2024 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471033; cv=fail; b=PaIOVcuHQzUS6Sug9mPaWa5F2lMkN/R0XV1Xa2u0X0yNCrm3rBPhxaGMXz2AR7riy3+HcFegTSi+dnBSTll8Z+dpXznT6wTid0bsQ0KN7t8JWQdLh7dCuC8/xJCVtngtGlJ8tTHwDJYFKDj0eHmmIb9tLanvoqHCy/mlqVBGv2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471033; c=relaxed/simple;
	bh=dN7hocZVOW0tUVIpELFOP1iujjL/9fPLZJSE0bwQGfg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eYAIOhplbi3gPrVRKlBmN23KjKlpLvCYs1HEra30XZTWOdVXJ4qPnz4vfgYTEvPlr0cVIW5Pn5xlwiPGznP6yEAMbQng2XXwRYNiuVbAYj/aXeWPdWRmZi1lLXLe08cOm3Ugpv+OC0PzI+7bG47IbYbYyhp6fOc8F7HvQbwlQuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OJNtrrCR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xaOcv1S+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C8wkoS032350;
	Mon, 12 Aug 2024 13:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=neoPRDOVT6JThUzKBQAPxd3gtMAvp5KG1Xrhl8vmbM0=; b=
	OJNtrrCRcDIZJPTlmlPv9ZLAjn5RVsKJvXCGUgwZyVKW9glsFEuaKXrp+RxGi9AD
	XsZ89z/W2j2LciXyJQCUKubbA0x/zZYptdcAjzSzgT/Zlc81MDlAkwFewat3VJjo
	xCcC+AtN/9t9uxHa5RUxQITVJGBJWzTFIEM1fmlN9McKQQtKhftBw3NQgOSxp+tr
	mVOFvlpf2MJzmHYNIqHe4Z4rfXGcaqJMvU0aRCpz/2ya4LzfRPlg3iCfQ8W9HTJO
	qtC2VMdZ3woU/z6TAkgb4GG/NuanbkZHOHh9vkl8GCZmyL8DDfY1q09f2dBIYZrl
	ErSCIXki+71rS1FgbZXQ1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt0tpd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 13:56:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CDJ6vi010740;
	Mon, 12 Aug 2024 13:56:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn75sjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 13:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ety6wnHupScglfxTJlVjv3UDCwWEScILV1ZcxGMYOSvJ2otCZDxTKozVVclvY7KTvgxhyr0OV8PiHTRwIEnKt20TLV+u023yY4dNbncDVuJ4CT2N3Hq77ldTE5EChQnIyvw9kx1Sai9D2F64iRasJy6N/IBe9sn3dPxknQLkaH0KRa2QAatwwDUh4ui74zwmhOIxOMiD5LOdkJ2NyOxkGcPY0ZRspjQzUC0DGJCRSjlJ/BqV1hIl71bKpnb+NFbfCVUWvitDQAmPvaSYsG53luOq5lqPSdH3DiaGKWUvojWnylvfJW8uJSu7dczQDPSPgBn8HyQtwAvcFngmhcEoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neoPRDOVT6JThUzKBQAPxd3gtMAvp5KG1Xrhl8vmbM0=;
 b=uraZbJbb1MXo6pz+BDe86TRNiIylGJWcLGsFlHlVGw8ELMWxRrUHmn8Uk6F+Fk2COhAZfEJQoWs/DVTTQRP/g4POCtZk1TQFgWUugQ0A00/f1vh1YS7V/alaIJyXVzRFJWiQYRVRtZWPG6Y3pass2UYFAnbds8YWlcdPm3E7kWS438ml+nOt6XOLCrvRW2NyhKCIYCkhgVS2kBzWjmqFfbCNjOFVyle6/0JtyYVB/NmCFFpNjVgbX5wdoVA4FVCh7sDsON3Ej51FXC45kpcWl8nwtyXAd49PxqAKTITKg34CnG22kwK5gYfLZxvY5+TC7OEBizsRBdVZ+1n4pkUN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neoPRDOVT6JThUzKBQAPxd3gtMAvp5KG1Xrhl8vmbM0=;
 b=xaOcv1S+admU2+VNtFduSNQvyWbJHwe/D46j6EivTTZsfeBG9LjLQpEiS9miSIFOiutcHVeyfJeNVz8vXO/LDAQ4SaeX+Ah8h9faEMIEb0I721t68lff/liu/4qDPIMhr8K0PUcQ7Kg2ELM4YfKAAFOqtfl2pZPRLHpqvNBoQsc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB4329.namprd10.prod.outlook.com (2603:10b6:5:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Mon, 12 Aug
 2024 13:56:38 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7849.013; Mon, 12 Aug 2024
 13:56:38 +0000
Message-ID: <61cf5568-7a01-4231-8189-006bde4ec0ad@oracle.com>
Date: Mon, 12 Aug 2024 14:56:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] libbpf: workaround -Wmaybe-uninitialized false
 positive
To: Sam James <sam@gentoo.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Andrew Pinski <quic_apinski@quicinc.com>,
        =?UTF-8?B?S2FjcGVyIFPFgm9tacWEc2tp?= <kacper.slominski72@gmail.com>,
        =?UTF-8?Q?Arsen_Arsenovi=C4=87?= <arsen@gentoo.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <12cec1262be71de5f1d9eae121b637041a5ae247.1723459079.git.sam@gentoo.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <12cec1262be71de5f1d9eae121b637041a5ae247.1723459079.git.sam@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM6PR10MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: ba96f2b6-58bf-400e-0d9e-08dcbad6963b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUJNWkF0OXVVVmtSUHBTSTRBVEV3b3M2WXFhaFNCbkpkdXJEcVlFQnFuWE1R?=
 =?utf-8?B?ZmlFQzRwMlMxY1N0WENPTUU5enYvcWl6VDhCVWo0VmNpVU9FM2FyZTRVSExZ?=
 =?utf-8?B?RnlPU1dXQmtJbW13ZDN5K2dyNE1odkFVU05RL1RlbmJiUERmZC84R2hIczJa?=
 =?utf-8?B?dURHWUhyNElQUms1OU0vdVF4dTdhT2NUVC93Tm81YVY2UUNkRnR6ZlhyYkhM?=
 =?utf-8?B?N0pzUUd4akxTeENaUUpENFhWTkU2NDZzMEg5bGFIQTV3aWsxempheTVzWStK?=
 =?utf-8?B?VnI0TnBnLzdyZjZGemdKc3FBT3dRWVl3aEpDVnlRcjh2OTAyOFk5NHVXaEwr?=
 =?utf-8?B?UWc2ck9BL215MWhFT2pDTlA2NGpiWWp0OERzS3hEd2pnYnZ1WlRsdi9pQ3pV?=
 =?utf-8?B?aTJsa2c5ZGtjYXFVb3EwTS9nMXJtd2hkM1Z1TTNFQTNRVysxbGJIYWgvbVlX?=
 =?utf-8?B?b3pVQ3NuYk8zVlpLTW9ha0Vwdjk2QUtOWjNJVk8xTHZZT3ZDYWFoMlNxMmdz?=
 =?utf-8?B?Ty9SV2Y0TXNrSm9TTFlMMUYzMDZDOHZtQ0VVd2tZeGgwaUZwbU92WFFqdW16?=
 =?utf-8?B?dlYxaVVLRzZzdmVjdjNwY1YybUpmNTByOXRFaC9IS0llblF6SEZiWEplZzFl?=
 =?utf-8?B?SjJyTkZiNWM0b1ArWThMbDdIREdCVHkwOE1kYnFTRmVxbWxSS1FCM05EK0V1?=
 =?utf-8?B?aDBXK2g3MWdLeURJYUhldkFJYWlvRFVRQVZxdVVuU1dHVnZoaVVVZXBjREp3?=
 =?utf-8?B?M2hnbzF0OWduYnl0RWVDNXF1R0xpbGZ5VUdFRHZKbExnMDVNbUg5byttdFBH?=
 =?utf-8?B?ci9OUUJIek1wbzMwS2lZeXNQOEU0WStYSmRuWkJLU09VQ3dxWjh3b3hocGZU?=
 =?utf-8?B?L0FSWmZyMGJuakJEa1Z6bFVWMXl4WGRWYXA1SUtmSFVXdG8wTUsvM0U0akxL?=
 =?utf-8?B?a2p1aHM4MjVBSU9DNWJzdHlqQ1BKZ0Z6M0NMUTVhS3kyVE14Zk1INDJvbzRm?=
 =?utf-8?B?a3BhVjZDWUFoRlVsTEZTdithNkQrWGFST1lCVURmN1RQOE1Ma3M2cnNEUU1U?=
 =?utf-8?B?dno2VVBJemI5THFjenhFdUMwOGF2NzJUcVVnQkhSaWsxUmlqR0xuNjYvZFNo?=
 =?utf-8?B?RlBrNFJMVWxWc3RqWXg0elpsR0NUTFRLME1VQ25SWmNQQWtYeGo5cUs5Yno0?=
 =?utf-8?B?UXVObUp5M1M5NmcxSmVZS1lydUpGZEFidkVyYk1LdWU2cW93ZGd0SVNoMkFZ?=
 =?utf-8?B?bFdHT3d4RG5KYTMwRWpvVHIxS3VFWTZOU0hLN3k5N1hId2pBMlQvRVl6MWFk?=
 =?utf-8?B?Q2kwVTNGbm9jMVpWNng0QmRJcWpvaEtIa2F1S2VsdVJSN3J2Mlg2Sks2MjRO?=
 =?utf-8?B?dUNFOWNQQ2Z2cWRIZTY5cTJkbXYvSm5pWTNid1YzZENaSkNWby8yVTNNUklM?=
 =?utf-8?B?bTdEcS9iT1JvcUgyeVJ6dzRkbkFZOVpzT292dFc0WnZHVk83aFJTZE83RlI0?=
 =?utf-8?B?VldkZWFmU1NXQ3BBTDFaRWlnTDVkVjVucHFsY0MwVWlrVXcrTXRBSUJZNmt3?=
 =?utf-8?B?NGFHNjNtRUE4d1dMb3BqQmF6V0JZWTNSSzFVNTZxejlKQ25YNHdDL2NaTExO?=
 =?utf-8?B?empEOWJNbCtLd2dNTk1wdkE5czU4WUFwZ3RQb0VCS0VPRmJSYnI1K3hVOWRW?=
 =?utf-8?B?VzRUVU5pdVQ2UlFBRVZYTUhubWNRN21HeWhCNFdjZ1htbk9vR3poTllCZ2VH?=
 =?utf-8?B?OGFic3Z2NEJKSmlhM0cxWTB3ZVV4UXpFWVk2SHE1TUw0Q2VDenpMMW9vZGFM?=
 =?utf-8?B?bkZ2UUF1QXdmY05VbUhoUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1BXVVFGUWx3YzRGRUVHNDYyME1wQVNIKzlzSzY3QXdoUmFVY2p4N3JoNjBD?=
 =?utf-8?B?bDk2dEwzTXlpMVB3MjR1L2pLTUt0UzY5Tms3M1kzdUVFVElBbU1lWTdWcWpC?=
 =?utf-8?B?M3YvVU43L2xUWlBCUUFvbFlVNFRaT0NWc0ZCeVFKMHNpRUx4Q283TVNrUnlu?=
 =?utf-8?B?cHlTR0dtT0NrRkpWY1I4WjR3cDNMUmJaVlNiRjAwclFSdnJQNnFzeXUyeW9B?=
 =?utf-8?B?aUlQNkUyMDhMRjB3UlR6QVZkNExvTGRNcXEwMU8wTjJDSWNGSzRKN1JGaGFX?=
 =?utf-8?B?Vm5IRit0LzBUTnByT2xpTndLNmhmM1IvQ09TSWVqT0dURmRuNVkvNFVCaTVj?=
 =?utf-8?B?UzI5RVUyRTVhcEZ5ODhFaWp3WURRNlhrRTJtQW4rakhuNWFYZi9LbXlCRDlF?=
 =?utf-8?B?Ym5maC9udXBXOXNIWXRQc1dIc2dxNm9zdlFia2ZPeDMwSnBPdUhZSEZVYk9U?=
 =?utf-8?B?b0JYVGtnR0VPczgzaHRTYWl5bmgrQVN0bm1Ceks2bTNGc3JzNzNEM1lXdkJT?=
 =?utf-8?B?TnNOaVgyd2Zubm95RVdwVXV6ejdmWDFjclNPUzFBNFVUaWswcUxjalU4UHJC?=
 =?utf-8?B?QjVoZlhQVFAyakk5OUUzVWtaYVdEc3FTaHJyUVRwUmxsaGUzU0tXYjdXVERW?=
 =?utf-8?B?bkNYQUM4YzFLdjlSY0pZMXAxRVMyOWhrbjFxWmp5TUVxVFRxaEUwZDVoYzhK?=
 =?utf-8?B?YURYYW9nYzFzeW11cmdBU0VNcExmYndnc1I1UVVYTSt1b3NaSXhLYndYVzRI?=
 =?utf-8?B?RmREN3hjMUh6TjluZk9BQjhsVHNmcE5aQThLSkM1S1ZDTURwWkMvT1dmNG9o?=
 =?utf-8?B?c2hWY25OQ3JNd1BUVzJLSGZiMEhpTlF1bi9aNFZ6blo5TFRTSWVvMTAxVlJp?=
 =?utf-8?B?T0wwNVdCajlrVjZDSzRlNWFYZUdKTmozN3NscjRWQ0lEcGNQZDRSUDcxLzVs?=
 =?utf-8?B?eVdGRDdkZUZ5dXdSQTR4bUZyVSs4dnpQZHpIRjBJMEtJc0pXQXZqOFpRZHRV?=
 =?utf-8?B?SHY0ZEt3QmdTcmZPVnBCZWxpaFA2STFjSUZ2OGkwTXFJekdMZXRxSjJUK1VN?=
 =?utf-8?B?ZEtIVU5icG1uM3V5aU4vTzdKKy80TjQ3Yzh1V0VoVnRWeWNoK2tnWnpOOXRM?=
 =?utf-8?B?bFpmVnlIZTBReWZLdCtpcHFwR3owZXNMTjRlTS9sNGpMZjRBa25KMkFSZWl4?=
 =?utf-8?B?WXltUzJvWGtiVWtJNis0c1ZEUzlIWmpzc1JGWnFhczhXaUNoamQ5US80MS9Y?=
 =?utf-8?B?Wk1nb0xUem1POHFjSkdHZmVmSmh3bkYrRGdweWRXV0phQ3A3WU5GNjBNeVFM?=
 =?utf-8?B?RFg5MUJjTXJmTXk0cUhSQVFnMVlRcmlrS2Nwa1R5OHVEOU5ILzJWaXlVR0Uw?=
 =?utf-8?B?Um43a3dVUlFLNzg5bTc3NloyWmtXV09xK0RnQVJkR0Nod1BXbDFZSE1NTGZR?=
 =?utf-8?B?MlYvRzV5YndSSjBJaXAyNXBVUk1iVzEwNXQvMW8wZTVoaHVPdHBxbkc5eCtG?=
 =?utf-8?B?NGJyOGVuc3BKYVVjWmlwdEtGYjRqZEdSamJ4eW5uNElrUVFBSkdTOWpVUTNo?=
 =?utf-8?B?bnhrK2Z0QWNoTkVpbmFvbVhrbXNKOUN6Y3phdXBrZkRtTGRLU05zOGh2OTlW?=
 =?utf-8?B?N3FsUDlhcG9xdkhoNXU1TVdka1ZZU3UydnhESklzZENxM1BKL3NyTm9Hbmtz?=
 =?utf-8?B?SWw4OUhxMzNEWlR5dUIxclFuSFBNazZreTBvZFQ4UWxHK0VqYk1sc2s0VUtq?=
 =?utf-8?B?czFoczRFUGVKQXdFRVlrQnozc3A4cFlJdUNmakg4Wm9DL2tiU2JsSmtqVXIz?=
 =?utf-8?B?MHNpbktLUGtxVDAycjY3UHRXMmh4V00yNVhZUjVFc2ZKcnlGMTRhR0UrODJG?=
 =?utf-8?B?ekYrQW5UeXdBMEpYSHpqSU1RTENqaWs1UjVWMHhTc2R5S0hST1I0aUg3cTNv?=
 =?utf-8?B?K2FubE1TS0J0dWl0K3BlU0toazQzSTJEMHVQVXNUdlhoV0VsM2JTVTZLRVg3?=
 =?utf-8?B?cUpzRmVyOTlTdFZVVVMvdEdCSFNHNFhlbHY3MGgrY2phMmZZR1dwWXRSTGxt?=
 =?utf-8?B?c3BQb2ZCS0w1K1lpdVp3eS9lNVNBcDhqZUNzU2g4bXlCMVdxeUU1R0lMbmhJ?=
 =?utf-8?B?bTluKzBBMHJRczlEaWhWYis0c2VYRUpFeG9MbVNrNjRZRy9VN2E5alZxdTBH?=
 =?utf-8?Q?exXhl1gFYcCkHekAWoQK/uI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iBczBZYWuriZIZaXI2syYDiZORVCbAhtiSocnXzUiUqnC7GRl5k6ZEtscBcscqBNDT1DPcWwVuSY+Y7uZw++XjiHPbYLtHeIoUMh9ZWJXIT+0nejOBkUvkIpvGEsTpnW24X1QkvEao0jpN0R7xmm7FA8+Ca2jbP8FvAkdkG0eKF4MYxYrp6qJlTPQw17PPVSZVBI28fDVMq6NvGE7Nc5j+Ud1hvLmdnsn1r/bxHIZ62lPTIYXdBM0qoX9CnJyVOQEkr1c0PfhHjhy61QOTYvtx/VxUOWtnBDwSu3VtK86w1H24VA/1iW5S3SZj9NGOkuWTYNXV03Kbw7zx6fWKq7KX7ZNq5V5ECBnUhn2bDnLFhw2QBtB8MFYBP/N29O3sd+wxnQlQ+3r7crYC+vF8sq6eZtrCRzX0fUOcufUQ3Hkt0fJrXIJzmXgTJuHvilyx7x7181b25CEMJz5V8B0EGwvPDb00OqTekeO6z8CwiO80RGHWI4NTKORXhW2AQOW08kZDgX4fepx7NXrnaTdt21lLw4gbliiKnu0l0bH2AWwZenh/uTcxPWewO2168RuStkl5W+/du9c5AuoJUlnjaCk1gjD8av73QD9SkoDDfKcTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba96f2b6-58bf-400e-0d9e-08dcbad6963b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 13:56:38.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61I6T2lHR8pcFyj/8sNgLXGqNGGwkJ6nRvo46xSoTMseq5dxhm2jo4BzpBSUa7JhXMTGVF+u/iVNRdE/ea2IWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_04,2024-08-12_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408120103
X-Proofpoint-GUID: ymOjrZeUvUAGPYFIRmcmvSLWMGdjhneB
X-Proofpoint-ORIG-GUID: ymOjrZeUvUAGPYFIRmcmvSLWMGdjhneB

On 12/08/2024 11:37, Sam James wrote:
> In `elf_close`, we get this with GCC 15 -O3 (at least):
> ```
> In function ‘elf_close’,
>     inlined from ‘elf_close’ at elf.c:53:6,
>     inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
> elf.c:57:9: warning: ‘elf_fd.elf’ may be used uninitialized [-Wmaybe-uninitialized]
>    57 |         elf_end(elf_fd->elf);
>       |         ^~~~~~~~~~~~~~~~~~~~
> elf.c: In function ‘elf_find_func_offset_from_file’:
> elf.c:377:23: note: ‘elf_fd.elf’ was declared here
>   377 |         struct elf_fd elf_fd;
>       |                       ^~~~~~
> In function ‘elf_close’,
>     inlined from ‘elf_close’ at elf.c:53:6,
>     inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
> elf.c:58:9: warning: ‘elf_fd.fd’ may be used uninitialized [-Wmaybe-uninitialized]
>    58 |         close(elf_fd->fd);
>       |         ^~~~~~~~~~~~~~~~~
> elf.c: In function ‘elf_find_func_offset_from_file’:
> elf.c:377:23: note: ‘elf_fd.fd’ was declared here
>   377 |         struct elf_fd elf_fd;
>       |                       ^~~~~~
> ```
> 
> In reality, our use is fine, it's just that GCC doesn't model errno
> here (see linked GCC bug). Suppress -Wmaybe-uninitialized accordingly
> by initializing elf_fd.elf to -1.
> 
> I've done this in two other functions as well given it could easily
> occur there too (same access/use pattern).
>

hmm, looking at this again - given that there are multiple consumers -
I suppose another option would perhaps be to

- have elf_open() to init int fd = -1, Elf *elf = NULL.
- have error paths in elf_open() "goto out"; at out: we set elf_fd->fd,
elf_fd->elf to fd, elf
- have elf_close() exit it elf_fd < 0 (since 0 is a valid fd), as it
will for the error cases

Might all be bit excessive, and might not even fix the false positive
issue here, so

> Link: https://gcc.gnu.org/PR114952
> Signed-off-by: Sam James <sam@gentoo.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
> v3: Initialize to -1 instead of using a pragma.
> 
> Range-diff against v2:
> 1:  8f5c3b173e4cb < -:  ------------- libbpf: workaround -Wmaybe-uninitialized false positive
> -:  ------------- > 1:  12cec1262be71 libbpf: workaround -Wmaybe-uninitialized false positive
> 
>  tools/lib/bpf/elf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index c92e02394159e..00ea3f867bbc8 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -374,7 +374,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
>   */
>  long elf_find_func_offset_from_file(const char *binary_path, const char *name)
>  {
> -	struct elf_fd elf_fd;
> +	struct elf_fd elf_fd = { .fd = -1 };
>  	long ret = -ENOENT;
>  
>  	ret = elf_open(binary_path, &elf_fd);
> @@ -412,7 +412,7 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
>  	int err = 0, i, cnt_done = 0;
>  	unsigned long *offsets;
>  	struct symbol *symbols;
> -	struct elf_fd elf_fd;
> +	struct elf_fd elf_fd = { .fd = -1 };
>  
>  	err = elf_open(binary_path, &elf_fd);
>  	if (err)
> @@ -507,7 +507,7 @@ int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
>  	int sh_types[2] = { SHT_SYMTAB, SHT_DYNSYM };
>  	unsigned long *offsets = NULL;
>  	size_t cap = 0, cnt = 0;
> -	struct elf_fd elf_fd;
> +	struct elf_fd elf_fd = { .fd = -1 };
>  	int err = 0, i;
>  
>  	err = elf_open(binary_path, &elf_fd);

