Return-Path: <bpf+bounces-43172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B139B0982
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 18:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC515284218
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B25188736;
	Fri, 25 Oct 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bnbpp31P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kziae/iX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A115D5A1
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872913; cv=fail; b=uNhEzliLuWElgW/Wfo0l6TgHlUN1mLfxk/VZXk+h0i3gqaWBuVD+qJu/wAhRFeGLtBJBDHbO/wuzXF7o4ElXggL1mjwjoApfRPHg0s/3MuFcQ269J7rrzksaba8bXt1uu/LHZX37J0jvzwdIfpH16GyRlFUJ/ss/GDnXvjA5nuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872913; c=relaxed/simple;
	bh=NSuqvjBJb02UWJpZLaj3GAq2O0j+ko/2bTBfmFCziTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+s/BfH8dd4QSnQxAbmovy9grmmiJnnsHfJecxTCJRzH0VDfN17DrUnYSPcSQsSolBVGXrKTtDPmc0BwmOc2b7ZP0g+mjTJV2+ESdVpwvO8vMZqT9GA9jony0OOqRLTyAPdJLfd7IqEItQaPqHOuY6aOEet1bS5rGCo2wr591fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bnbpp31P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kziae/iX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG0WKi028167;
	Fri, 25 Oct 2024 16:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2qjIR6XUG9LybYbFtNnpMT4WPR7mYNss1u4UsdFxNKY=; b=
	Bnbpp31PeOqjpPc4KHj0zDOw3GXuo4uotqMpu5h7U0+LCxyt5ETkxxM6Y3Oz3tLE
	3IYGG62kkLBjqj34uYOLA2e19Hd1Qsn402lCOGzGD0/3ls6lKRNrSF9SlGPy965m
	eZaPColI2y1jvy4jOMho/ccJGhQUBo94/Tkfrv7jz/gluddmZlwKiZ1WHxjTwmwY
	JsKfnFPHPvfAmDZYG1vhFEFE2eLvxMfmIDI95PPEDNE7FBwJCwJvPxXzzYMc1Jnj
	Gt3dU4g1nocaPPGIsax1GMTu8PJRb9dY0mchqIEs01WkSFKgwF6SCXMNfgRW1dy5
	h5XTEjkIgF59ATizEmYvwQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr4jgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 16:15:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFjvT1016480;
	Fri, 25 Oct 2024 16:15:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhe279a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 16:15:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDrp+ucNmL+Ow2nQ103pCPBZ5o16EajBwf+cmjW4yX/mVMJu/+iXrkJ+AdyoizHCdu2bHJncSe1wYv1a+bZlYwaqhOxrRqGiXMWdAgZVlEKKeeY/60JLBwOGQ0mPdnmKT+ZDHYyIvjQXtVRqjzIK3vcA21jQG8ph5/aRbwcv0DyOcGSyhaX/qfzXRxSPfHq7OWnMv0BkNPSYl0auh/LZeQPyFfbvVCSi4y1W2Nn5fb3i5ZxqF2DiFl3GuNFFBAS+j/jepc2sAwxI6egswb23FNLa6dZ8ouTW3Ky6OaejZqkVGoxZvkEBJ3vbnrLtqIP+UMxoEgYBBVowHL0VWItSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qjIR6XUG9LybYbFtNnpMT4WPR7mYNss1u4UsdFxNKY=;
 b=y076oLBM7qaaqQecFCQoSxc9Ffz2QD18H8JSPK91VWT9j1Df1yTNr7PdykRYn5lHpT6Lv2OOR9g6iNSds4bllwXzhxRl7QKY2mVqgMjoqJbQ0h+waSt4vVJjFE78eklmwHtXHh9XPV50YkpdZirr29zFh2kY5EbOS8t/SPD0TLpW7Vwyv8c6hghxi1uoht7OKcvkHXoc1BiCe3jqapaLS6owdjZ4XAJdk7KBzonwYOvtbsy7dg7qMbaDPTUB/OhlSXsKEhiaK1mcX3wgw+SSdV81teTQsXenm0dpBmiEKnI/uiqg6oc5KSUD/iOF8AIDr0U4W43j6yHfnNI2EWbkuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qjIR6XUG9LybYbFtNnpMT4WPR7mYNss1u4UsdFxNKY=;
 b=kziae/iXb5RELgCQWkJOEmEzmwn0laisoZ898QycQ9h4B36PG02nzO4I8nquDOVmfr7q0fazLh9fvyFiE4m39zrf2Yumf4iF5egqHg5emmzTnSJTH6oSejGN8J1upiDfDu7mxxh6XhAPRQQgluco4061255Nq+wlZIQWu/y2atI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6911.namprd10.prod.outlook.com (2603:10b6:8:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 16:15:06 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 16:15:06 +0000
Message-ID: <f07ae723-2773-4dae-88c9-2d26903182fc@oracle.com>
Date: Fri, 25 Oct 2024 17:15:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Questions about the state of some BTF features
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
References: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
 <b58c8ae4-3a5c-44b3-bc85-2dd7dcea397b@oracle.com>
 <CAEf4Bzbv4SrQd=Yt7Z2PNQLT+1VkLKMaERFwfE8d=8s7QQ-_bQ@mail.gmail.com>
 <16877742-7f15-4fd9-95b4-228538decda0@oracle.com>
 <CAEf4Bza6pL1-2AmX-zfuv5-mEk=b6yhhGRtb7DrkUTsArvEO6Q@mail.gmail.com>
 <CAADnVQL2CNSMi1NoNTVePw_VaqHYZJ4pLLX25wJjD1R66ezYXw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQL2CNSMi1NoNTVePw_VaqHYZJ4pLLX25wJjD1R66ezYXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 9208a165-4ea6-4cd7-d3ce-08dcf51030b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXVEbXl2dURtRmpCa1NXdTE1eVlhVjV0T0I0WG1ZdUVDSGxVcnMxWFJQV2Jj?=
 =?utf-8?B?ZzlLRW90NER2QWpjZUxPS3VodVZ5TEcwWXRMOUVzMWZEME42ZVRkeEhiVFhK?=
 =?utf-8?B?RVkreTROZytoYXlXR3NiQ2c4ZTRjTVo0VXkzVnZTNzhlb1A5c1pFQ1o0Q1ZU?=
 =?utf-8?B?dWc3TzlVWGYzdjdTWUNoKy9WRkoyMTlTbk9lTWhqVk52b0g0Sy9TaVNSS0ZH?=
 =?utf-8?B?cHAzckJ3YmVwTWRQTzlSKzF5NmJFd05nQjBTMUhWUjNhYWVGWW9PZDNVS2Zj?=
 =?utf-8?B?ZURwS2JlQWN0VUJ1UUY3RC9QQUZZZUt3Y3YwYzd0Z1hydmNudUlycUF5TEZK?=
 =?utf-8?B?cEhJQjJwNXBoZnJaVjVROFVPTVdOakhEWXkyQ0RyTHRwL0xoYmJLU2h6clFx?=
 =?utf-8?B?aUI2cTFXRHVqTURoT1FzUmRraXRXSEVudjhpeVlncFV0NGE5czBQSE5hdURH?=
 =?utf-8?B?NjNwdlZ1RitmOXhOSUNlNjg5VmtQUitMdThZQVNnNmF2SC9MSHRhM1NjTE1t?=
 =?utf-8?B?d3pXei81Q05oREFtL1VIUnlLNEFuWWRKeWw0T2NwU2MrRUFQbXlGUUNxSmV6?=
 =?utf-8?B?bE94ak9EK25VV0RRS2NvMndjb092UkVuZW9mYnUzMWdEV0dkNWJPMnhoZWNW?=
 =?utf-8?B?NWF6U1FjRzFwRjUrb2V6SHltZ1BBdEVOQUd5UGRiQnZTelNtUmozUTRnTFFi?=
 =?utf-8?B?V1VTeHpKOHhMRVRXcitUTlhnb2s1Mjc0c1hlVFA3UHdISnpSamVoekdXL2oz?=
 =?utf-8?B?ZnEwNndZL0UwRjF3M2FuY3Bta0l6MENmbmFScUNCRlRwK3I5Y2FpZFZLNEQw?=
 =?utf-8?B?TkJlVWRPTzQ0c1VuY3hkYlJPZElwZ3dTVkF2cTlpR3VhcDZPSk82MjRzS1hL?=
 =?utf-8?B?aGdTVml4eUw2eStRalBNS05tbmVveUJPUXFOUmlGbDVvbjhEMXY1cVNTQmdW?=
 =?utf-8?B?ZElPNUQ1a2o3VG1kcEZSblBtSm9ZbXJ5TXpPejFTMjRxZUFiVStkS2lTZlla?=
 =?utf-8?B?RUlQOWZ3VUVzbTNXeEF4T3J5WmlKUGZQR2NlMDdsekZIRGgwNzNUbHQwdG5o?=
 =?utf-8?B?RkFkeHpHZVYxODZra09FSGt5NHlBYzJQbEl4elZ0UlFKbU9kdXhBcC8wekNT?=
 =?utf-8?B?QkJOdGthT0ZBTW5VZFRXUmRhb1ZnMjFQeUQ1aTlXYUFvTER2TWxsM2grWHJu?=
 =?utf-8?B?c2svUnpzVVBpMnhPWG12RFdWREJJSzZnZ0Y3ZXhNT2VXM210REJ6d0RsZHdM?=
 =?utf-8?B?bjcvb1dGNFRPT0pHeGtPUlk1c2ExK1hTSUNIUy90c0x0NmFnQXBIK3VBWXFP?=
 =?utf-8?B?Vjl5L05ENERBZDVKSDg1emsrOTBxQkVxSFdvWWZhd01wQ3VvNmZhcTRFaytT?=
 =?utf-8?B?bEIxYk1jbEdmaUtKcCtaTWdIRUNNQ2tVT3ZiR2M4RWplWUU2VSs1MHhNT2Vl?=
 =?utf-8?B?eDFuRzF6WU5rV2lDbU9wZjMyaEJNRTh3bW5qMXplZVZIN1JTM09kNzBWWE1y?=
 =?utf-8?B?dm8vbitDTDJWMHRlZ2NYODZDWGIzbW9wblNHWXh6Qng2RGFzMTRlek5Hc0lS?=
 =?utf-8?B?a1U1MFpPb3dnOEZ4b0RxcUYvTmxwREpvRmVjUVR2QTRzdmlPZWNXSHRra0ZR?=
 =?utf-8?B?Zy9wSmFjM0hUeCtxY1BhZ24vd1g0dWFIL3ZsR2x5UjJ3eklYZ3Q5TS80WVg4?=
 =?utf-8?B?eU8vckdwWEZUSXRYeEZPNnRyNDJQS1FtSDZTSmJoazBBaDJ3cjVoSzBacnFV?=
 =?utf-8?Q?79zWRduTW4s4H65pXY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnhBYXlMR0lHN1YrdXphelYwaE1QM2N1bUhicnU5dnZGTzdVcHZxdDhkZDhJ?=
 =?utf-8?B?RFJ4QnJqc0pCYTNjQXRrck5ONE5xSFZDRDVEcU1PRGVmY2FtMHRqMWZlNzI2?=
 =?utf-8?B?NTE3MFFLZU04M29YWHdCYTRaSncyQlpqNEo2eFR1UVFKbUFnM3JHOTU5V2Nx?=
 =?utf-8?B?anpXTVJWbytOdzRhc256empET21ucjU4M3pZVUxqQUtzd0E5bEw2NGM0RTZU?=
 =?utf-8?B?cmpyd2xrZlJmUS9ieWpGZitTL2VTMFNGN3dxZEh3d3J6M3lRZWd2QkFqZU55?=
 =?utf-8?B?KzRhcUVJa2RSd1I1T0NtbzJ5SS8yTzBkN0svYVBVTzd0NXpJTXJjTUtWZFpz?=
 =?utf-8?B?MnZrdXRIK1N6bnhWWlJiM0s4a00ybTlNTFdVVlYzMG5vZDBBKzdmTHdLNktp?=
 =?utf-8?B?NCsyNmN0bnZiVWhvejJVb012ZHJ6L1BhcHMyTkFFcTg4ZVh1VDc5TEJKNGpx?=
 =?utf-8?B?SGJHbjcwcElmK2FKcWJPSEJFYWhRQWszTEN4TFdVR1h6MWJiWllxMThlMTFo?=
 =?utf-8?B?VWhyY1BEVHlWdVBobW1IZ1V3bW5HUWlVVHRQNXJycGxPRms1MXZrc2RUcVE4?=
 =?utf-8?B?RjVxOWtoMHI2V3EvQ2Jxb01iOXRZTWNyWVFDaGNnOWRtZXcrWTJkZGdvWkI1?=
 =?utf-8?B?d1RNbmxYNGFUcy9XZTgvZzNRcE1sc2YvQVllaWZFVHY5bVFqclN0TVQ0OWJm?=
 =?utf-8?B?Z0VEZXZaZC9pZVFQSGx0d3B6UnR1VG5PZ1p0aTBjeXRtb3lLY25TK0FLVHBF?=
 =?utf-8?B?K1R6RUQ3a0wyQnVMekhzRGRKRGt2eER1ajhvNDlaN0RZM2FyNnpaWnhVL00x?=
 =?utf-8?B?R3hxS2M1SDdnOC9Kb0JVMWozdU03WXlYcDJrREloL0Q3YXVlQUdGcHZJdUR2?=
 =?utf-8?B?ODFmQ1d4S0oyUE1qSVpFWDYyb1BJMHRyck5BanFhR1NSWUpoRy84c1NqQTRK?=
 =?utf-8?B?N2cvR2R2b3NVWERlNlh1cVZTQklRRGN6Y0VvbGNEWW5Nc2NVNm4vWlRubWpx?=
 =?utf-8?B?SUI4STU3cmsvUXNvYkRiMTA0VWkyZE5ySUJqMzlxWm5hV0FPd1YwbTUvTE1q?=
 =?utf-8?B?UG4zQ1cyZlB2eHcyRkZ5RDNkSzlBMEt2V3lnODlBcEtUWjcvaWVnYnBCNXNt?=
 =?utf-8?B?TmhQWmkwb1ZDUGZBUU5ObUdFQThKZlNWUkVoYXYrbjY5NkZLUEhDKzJ3Z0oz?=
 =?utf-8?B?eFVJVDJnaWtic1dMREhMYWtDM0NrNkpUeWxVVUtUcWtZOTRNb1pQUmFYVzdS?=
 =?utf-8?B?NEtENG1VQXd6QlI5RzNMWmRBRFRtMEU5REo1UXVicEtEaTM5SHE1OFBGS3c3?=
 =?utf-8?B?dGd6dGhzTjdQZEh6cjUyM1pWZVNDS25VT2o0QTJQa3VGU0h2aGdNMkwrUnRO?=
 =?utf-8?B?cWdKNkxkaDdVcHM0bkdIREVndTIzL1ZiTCtRejNic3JYdFRrT1pERnh0cEgv?=
 =?utf-8?B?L2h2MDA4ekRRNGNKbmN6bzVzODlOdEpFME5JWVRmQWticURWMWZxeEQ5UlNW?=
 =?utf-8?B?UW5KRG5qQnhnOUkvZjBUVkhhZ2ZMQXgzdWtjNitnRjlMb3A5VzV2V1R3ZEhx?=
 =?utf-8?B?WXIwQ21sUnBPZHEyV0I1RUZldnczM3AvbkVTMHp4NjI5a2UrS0YzUkxVSjEx?=
 =?utf-8?B?aFlxMHpESWN4MERnbmIxUTMrKzlOb2YyOEl5d1NnQ2lNdVRDc0dwUnJiUktv?=
 =?utf-8?B?NGVxd3pKaFFqdGwzV0FZWi9wL08zS2FCU0hlOFpaeEVzdnNmdW5qZW9QVExY?=
 =?utf-8?B?MHl2Q2pLQ0VkVHM3NHM2bzRwSEQ4cUZIVVpBQUtNN1kvTFd2YThnVXBaYkdH?=
 =?utf-8?B?aXpoZU1GVWRkSitPakZWRUR3UnBDVDJCTElabUJjZDN3dGhOOXhOSnh0YjNC?=
 =?utf-8?B?b21uRmt6NjQ3M3VZME8zbUk5TkpQaVkrVHo2SnVqQmFBeDlDR1NBbTdIbUsv?=
 =?utf-8?B?eEJPWUxPbTBtN1l3OFFGNG1vZ2RHNFV1TzY5UVk3SGZNMUo2LzNmejZhMlFD?=
 =?utf-8?B?ZVNGTXU3TXdhK2MxQ0dlZENreDVWQWdlb0NLYUtDMllySjc1aVdkMEJhZGNT?=
 =?utf-8?B?cmxsVXVySTNhc0NuNWRxQlI5ZHNUZjlCS3NNMTViSUc5djEwU1RnVWh6VDlW?=
 =?utf-8?B?YmtFanU0UUxwTzVXeHlVZlBUYk53Y0Q0MFlQTFNlMDF1YTUzQnpGQ2xzNzZP?=
 =?utf-8?B?VmI2aldGT1pjVEphdG9MR2N4QzN4NG9mUDZ2NGVmdi9XSHArZjF0L1VFdCt3?=
 =?utf-8?B?S0pCS0E4MzdmQloyWWFSYVdzd1BRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HTCpt66AZrA9bkC2lxzuUgeV6LaYNUbPfrm358iITedw4CgCrS10oKAPcT3j7tSji+tFu7cBkgsihFtN/4SX1s2tTUDXU3InHPG6xh/IY3pVfxbdksPaQ2Jry42OuYX33ryGgEiUQIc1bGTD+6ZTbu1Ctu0OQEPuiTeHV1HsCYHauNh2XxP+NLfHaiwBNGYuSZa81YnfLVEKcLowwX7JaSZctugZswSvJCJ8IKqHrlZW4ontn5Z57016F+OHUyGUnoF43Xt6Ot7iuebPWmknkIDg+GimcQymcYOxL3lfPqIsQxSl2mTBSuQF3Yz7MZ0vrlZVo4CyKbgt734DExL1cbUkbnu8xDwkfaltQ4TvVZUIV0GEPe7iMKUB7TegnLUShcvMlCkREz9LmkF1jj1uZf8dkzki2dSNX5UfLRjubkvju+wIAi1yPgOwCriBTInGogcZ3cFXIAaXEqUHbVqlCqHB6jMIlkSG4fx4Uh6YUHm8i8ckyg/T5iNlBXvEy6SSSpntHRaN1siqqtfojMcdQ2py8DYbgMBT4WIsdITJTtQzvbAKBMGRzzBkFOXUXXLQm3fstvDW2fI1F7Zh72LNXIOghLNp+fHuqncleYmG5Wg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9208a165-4ea6-4cd7-d3ce-08dcf51030b9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:15:06.7750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxu5xT7rcHyWQeyGfPmpgEcs8cw7z16kjZLucUfFy1yV/vwvAacdiyDeASCFNRPMHtP1WuYnGEuXdrlqF6FHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250125
X-Proofpoint-GUID: AZ_wUXOeae8UgoaItIjhlIS_yl1vps6m
X-Proofpoint-ORIG-GUID: AZ_wUXOeae8UgoaItIjhlIS_yl1vps6m

On 25/10/2024 17:09, Alexei Starovoitov wrote:
> On Thu, Oct 24, 2024 at 4:26 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>>>
>>> The good news is that already happens, provided you have the updated
>>> pahole to handle distilled base generation. After building selftests I see
>>>
>>> $ objdump -h bpf_testmod.ko |grep BTF
>>>   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00002c50
>>>  2**0
>>>  50 .BTF          000036f4  0000000000000000  0000000000000000  0006e048
>>>  2**0
>>>  51 .BTF.base     000004cc  0000000000000000  0000000000000000  0007173c
>>>  2**0
>>>
>>
>> Indeed, after updating to the latest pahole master now I get
>> .BTF.base, very nice.
> 
> I pulled the latest pahole, rebuilt everything,
> but still cannot get it to generate BTF.base.
> 
> Any special trick needed?

Hmm, should just work for bpf_testmod.ko as long as "pahole
--supported_btf_features" reports "distilled_base" among the set of
features. scripts/Makefile.btf should add that feature if KBUILD_EXTMOD
is set, as it should be in the case of building bpf_testmod.ko. I'll
double-check at my end with latest bpf-next, but it was working
yesterday for me.

Alan

