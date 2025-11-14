Return-Path: <bpf+bounces-74524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E18C5E0DF
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 17:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931914A2F16
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAFE33375E;
	Fri, 14 Nov 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lDBsWuEp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EDMe0+/q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14B332907;
	Fri, 14 Nov 2025 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134918; cv=fail; b=TmwcSbQR6rTLpC4v/yHCF4L0RWJt/uW/rqokG8EHf88b0nfTeSa9Lx3T0W7tv6KRlX2vhZODSRzXN6Rz+3Pz46dVr2gtytfnChXVAUj7j5jGAGry0+n1r3JkBDkPle8jAOB2usqHWEqFfFqnRugWl/kCJinZB3+IigpRE5x0uLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134918; c=relaxed/simple;
	bh=x3F1GJxy34HwYaKAWQF665z6fRc2vxrT+SZ2UhxC/68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ALpB4Ec46BNecg13CtMJoNptCPkEQR75MdjFpYclXEUwK68w3AEEZ6GfuEkqJiLZYOes/Kijo5wB97qCaK/oEpHMD8OJvWIB5XawuYR5umHnPzktLZA2+eKGnt9VOQEvYUu9ihjt+2GYAXfbdfz1ZNZC+xJttFNunYZYhRgLjyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lDBsWuEp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EDMe0+/q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECuWOS005364;
	Fri, 14 Nov 2025 15:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qsl+sr55B7rP1fj5jHigrbADUPHFT236nafvmdFABq8=; b=
	lDBsWuEpkdKQPk8wdZ0TksPum74J9qlhAxgay+PQ7WGDnDTPr7STZinULu34J4pK
	6kjfEvD42VQ1quZeed+j2nj6+s/mXBr5Yr7uhw6CZOLQYfl+yGttYQHTsvK56p47
	dwC1yBYfcDpFXnoM8tG5dXN4ba5L002+Y0f15VmygPB3C09JzUznzLqPAU3+FcQf
	f0Fji5QMAfaFz4AMIn7wjjDMxKY15XEEKjQR+4MjNpmCuq9CDvVbuwNFU+oolBJz
	gQJ1bpZlzfuoeuLRU98tFtVx+AJciQ8hoTjGq1KlN8HaTKJyQzb/U1Iu56OvJOO7
	1YigJxgfzVHm/cG+T2bt+w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8vhcxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 15:40:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEE3Hgw010985;
	Fri, 14 Nov 2025 15:40:45 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaqf1nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 15:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mw6CLAlYQ5VTfn5lBtIIJv5HTLqPDPN7P9bEGAejBV50frWiS3NPGBsyt76g9nHFtawK8rxfSoWcpIX7G+O1oZPruhJ04FTe7hhAemYCYIwijSEjzGM3XBh2dEUtaAqijmd4gitOtRdbdyobnI6t7gucywCnQDtyYfkSQnGLFJJ5SSBpD4nHeRQ8bqmvzh7hRN7WMuBcKKKPB4xMVDj/BmYImQOxBJiv+J8WqCimgPzLC8KRJinbpPAUsQoVkDCaVgU67kb4v62hEf3Jbs7bzWb1w4dn2RTWbXS2T82TUQ5QAi7UNX9wuMXZolyEwyt1otLWRiWH4UZXsGoqrkfghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsl+sr55B7rP1fj5jHigrbADUPHFT236nafvmdFABq8=;
 b=hqnThbA52EvOcMii2mLwfeD5J3GfMwkHiY5nHhTORiDQrDx+liuVXzSHReIDMzpH5pw0OwNyAH3sor1Y1AfI5avXjLRX1JixilxwBhLPeBgaFAvaPceQ9masCxvt39Ww8Z+sF22YQ3wVE/SxJqxIvRAHhMYodsXSaF0njo0TGOzuupfDTBXncsuILqB9F5XEOlBgW3SunaVu8Tybdmo2dwzs2NoKdranSqSURJgLiKNLZruEJQwSXL/1kynYDeXv/8OeJyRVT0BpY7tthdw1fmFJ7MQSyiGUref9GyCkLuEI2Hu69ev1S07QDAgPONqbABADvo7eZRvmF2t6SCXmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsl+sr55B7rP1fj5jHigrbADUPHFT236nafvmdFABq8=;
 b=EDMe0+/qObB2n7Co6VG/5aruB5DB+u0LWN87IGuPGYaOZTW8mzWssYueI7FEVYQmprgfRge6LlAz0Andqg3rtqImOS1f3DSf1kgDlGWOmn3Qi5xzpmSl+iQc2qewgzOwXPxDSLIAWtCGX6xdVnfxBVjXLYAe1w2fcY0Z9JrBI6g=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 15:40:42 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%2]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 15:40:42 +0000
Message-ID: <cf503462-6616-4cdc-ae63-b126b28ae66a@oracle.com>
Date: Fri, 14 Nov 2025 15:40:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 0/3] btf_encoder: refactor emission of BTF
 funcs
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
        dwarves
 <dwarves@vger.kernel.org>, Eduard <eddyz87@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@meta.com>
References: <20251106012835.260373-1-ihor.solodrai@linux.dev>
 <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com>
 <CAADnVQJj6EcntgiAm6Kv8FJvP3tQcG=EzWt-uFuzszHtcw4gmg@mail.gmail.com>
 <aRaPnq2QJN1iFF_3@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aRaPnq2QJN1iFF_3@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c69be78-af3c-4231-f048-08de23942b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2tOS29iQk5BM3d6b05sSFg1RGNYajhhTks0NG56TVVQVTNVTk9uZWN5blNH?=
 =?utf-8?B?MWpnNnB2RUk4aEVBVGpoQ0lMZCt4NjZIdHRPWXJGUm9raFJlNThrRXBPWUFn?=
 =?utf-8?B?UVI1SHM4cCswdGV3ZFdVVUxOeWhwVUN5bGxORXlQb3hPNU5HZ1Q4SDBZdStt?=
 =?utf-8?B?T0dBb0JhV3ZReERaekZKZ3pVZU9NVXhORG5UNHVGSm9ZUklEWnNiZkp5VDJF?=
 =?utf-8?B?NXlvYW9FbE9LalB0Z3lSaVBKR0grM0JmT0FtbzdUUTR1cTVvMGRnekFwajR4?=
 =?utf-8?B?U0gwcGR6eExlTTZNaGVtSFB0dFVKSE1yTGRqbWtZWHNoWmk4ZXFzWXJyV2Zn?=
 =?utf-8?B?Sk8xWUY1eUI1ZXZSbWI4cFBKbkhuOWE1dXV4SkFlN0RWV3hpOE9EaitGQ2th?=
 =?utf-8?B?QS95dGVoT2Fnak9WUFhvQkpOWEZmb2tuMFNzN1hsQzV0UjRlSEhZNUhLQUhY?=
 =?utf-8?B?QUZPNEJZSk9XM1dIMmhWN1RDWEp6bjJEaVNHQ0dyQkg5bEpsWE5KVWNYSFNY?=
 =?utf-8?B?RGp1L0ZKRGlaUXRDMUt5bG1vdE5oNE05ZWwxUUR1SWsvSzl5Ui96bmNmNm5C?=
 =?utf-8?B?MHltT0E2LzBUVTFvaS9oT0RXT0E1TENvQWdpVGVwK0FEYzMxNS9RakRya0NU?=
 =?utf-8?B?WDZ2a2R2Kzk4Zk1LR2EwYzdzRU5XSXh4NGFkUUZZWmEwSG5zbFpaWjZPU29a?=
 =?utf-8?B?K3BER0lpaGdEaExXRHZvd1g2K2xoOTJEaFE4Zjh4SUZVZmx1QU8zNFFvR1Bs?=
 =?utf-8?B?SEsremN5ZUZtMUdoaXFkeXhrZXhyaEllQ0JxRkwwaXlHb0J5aEFJc1JCd1VV?=
 =?utf-8?B?aXJQNUJHWnpXU1Y1Um5QaG5qUjNobGM1Uis2YUdORU41c1ZzR25ZNmN4clRJ?=
 =?utf-8?B?N0hZLzZldnhaWGVvWnNOYjVNY0JUU2gzUUlmVHhsaFc0VDI1TVdGK0J0WUFz?=
 =?utf-8?B?M2sxTytjN2lXTU5mOGtwTXcrb1lRTDNocWhCV0k1eTRBdmQ1eGNJTm1kbEtN?=
 =?utf-8?B?WW9vc3NyZWpYRTNHNUpYUTI4UEpoNTFnMFd5WHdJZ2l5NnI3U3ZzMThWRjhU?=
 =?utf-8?B?cFE0VUY1ZytVUS9yaC9EYmpFVFBDbGpneFBabnlXdDNhUFlScmZWZ2UxcjRi?=
 =?utf-8?B?RklJdjNxUnRtbitQQ0x2WisyUkh3R0hHbHpha2FJSWFnSnB3QWtHbEJWYjcr?=
 =?utf-8?B?WFBwYlcxekthd0pZdTdMM0dJOEtRak5mZFZYekY2eTVLMWd5TmRaUXNqdFRY?=
 =?utf-8?B?am9oaEJ0cFVZVit5NlpRdExNOWZXMCtPdXc1ZTEvNGd5clV1SnJzQWN6ZFd3?=
 =?utf-8?B?Qkh2SEdGVEppQVFVaVp0dDhhSG9BeWJZTDBuUVlDSVppQkdoUU5Ba1QrK0Vs?=
 =?utf-8?B?UUM2dWZIRm80ZnJ5T2RKWmF1ajlNTlp6cCt6UDh0K3lhQnh3TUNmL1V2NmlW?=
 =?utf-8?B?Sk1SUWxpUzBBQjdnT0IrTFYrUGlTSDVzNU03MWcxVjlZOVlEQzlvcTIvUUZV?=
 =?utf-8?B?NG1BK25YemFRS0dyK3JkNG8vRnhDeUNqTmVJZGwvazlwWlM2VlFvMHlsT2Y3?=
 =?utf-8?B?T0RaRytkOGJKK0FmSTFoZDBGL2pxVmtkeTFiMFR0dmM5cEFMOWFJNDdZZk9m?=
 =?utf-8?B?cmdodk96QTZMS1A1QVBWdVcxSiszU0UvV0JSMmZRdmdwRXZiRjd6cmtldDN0?=
 =?utf-8?B?a0M4MHNTMllHakRTM25lRnJDaDBSaXhSUUpJMXp6cDlYbFV1VlJ6NEEyTm5z?=
 =?utf-8?B?MjV6UWdaUVVoY3VZZFBKTFN2bUNVRU1wblRNK0ZaSTVVcDZYTDF4c1RUeHlL?=
 =?utf-8?B?T2dGTXVVYmY1R3ZjZ0xYSzYxSDR6WUwxcTRiQkJKNnIrdTI3azY4bXNIVmZl?=
 =?utf-8?B?YjZpWGN5Y05KWEJTdXM5OUpQWGYzb01yRGFUeVIySTg0RGFEU0dpNk1GZ2lM?=
 =?utf-8?B?YlRsYnVYcnFPWmRNdVNmL01wTHJzaFJMVWRjbGdIZTNtTElodXljUXozd0ZI?=
 =?utf-8?B?YkRHZXVkVUhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3p5MFJmVVdtcXBRdXVjZWFjNmJIN3JCeXFBNkFBOHkybUZ4am1jbGh4ZGdR?=
 =?utf-8?B?SE43YjJOY0N0dVI1VFFSN2F5UlJlbVlMNXp6NVZhTXdqVTFlNDl0S01BYU1o?=
 =?utf-8?B?Q1Y3L3drK21Va3VQeHRzYjl2SHdsZEJkMzZVcEJMbHlVZ1FMRzR5L3cxb2dH?=
 =?utf-8?B?OExBVno3Z3k5WHd6VzRxREhSUG1mVlc2Z0g3cldQR29mQ3JZem9XZW15LzVj?=
 =?utf-8?B?NGlhbUNNa2VqVWhtSGgydk1nYUtEbUhRbk1CMWZmcGpDMkdqcUpJRW5iRnBm?=
 =?utf-8?B?U1h3dllLRXpYamtUaG4ySEdIVXgyS3VPOFRSMFR0dVdqYUdTeUMzdDFlV3l0?=
 =?utf-8?B?djVkN2VmL1pvWGYxSHJmZ25SRnZaWEdiYlZZZ3ZuTkhhS1ZOVTlKOHBaZk5r?=
 =?utf-8?B?eitqYXRIdTFBSTdNZlZvdzhUbHczNUFCRzlLT0gzUzJ6bHNjSE1GWkhlbnRo?=
 =?utf-8?B?T2hLSzk5KzJnU1B4dFFxcndTUmY3RHc3bkhNRTJrOERRN0o1VjBvSFUzZUxN?=
 =?utf-8?B?UU8rMEU2WWN4SU4zMmxjSVJybzF6UVRBVlNmWkRtekFwMHVmbkYxMklPd1Uz?=
 =?utf-8?B?MHpRMkQrSGs0dWpkazUybDRMS21LYmlzY1lpRlAwOWdBS3FvLzUvOTFTVjk3?=
 =?utf-8?B?Q2VZR3Q4RCttNVF6QmdSb3lsVDdUd3ZwWlVNT2hBenN6bEM4Vmlac2NRY1lt?=
 =?utf-8?B?cHBXT0FPZlMrWS92bFpLSDZzZlhDVk5NODQyaDBXWnE5T0E3UmZoYXZORmM4?=
 =?utf-8?B?TUtRY3h1U3czQzRjeTdRdEZ4cy9acHM5S1NDUHFncTZXMzFmVWNpcFVrMGlE?=
 =?utf-8?B?VEZDUDJ5NHU1Z1h4TFQ4bXRxMmpHZndwL3lSREp2WkVsbUF0dEtud1FMM0NB?=
 =?utf-8?B?YXRWb25ibEN2OERyamZIRjZpWEVsMG1NbXNjZGd3Z1gyVTJMeVUxa205L0V1?=
 =?utf-8?B?U1VJUDhrcWZzeVdDdEdSQ3ZqTXp6cTd1REduRUh4KzBxelFpUHpqdkUyUzNL?=
 =?utf-8?B?L05WelhaTFVLRjVaU1I5UzZDL2VMSEJOZ2Yvcm95TXRncjdLVUpCTUptdmNE?=
 =?utf-8?B?TElpa1N5b01DS09BaXU2TXpCMGpGWlZqQVBUc3RDWTRVZ3FtYTM5NnpsNkRC?=
 =?utf-8?B?V2ZtNkg4WXhDOGpOMVgxcm1weVUyVkdqQlNJUXNpUFpva1dXd1ROWXFORXFn?=
 =?utf-8?B?dnd2YmhCSzQraXVDWlRxOFk4dExJc2xnZ3o1ZlUrcCs2WXgvb0tHU0VMaE52?=
 =?utf-8?B?eldTMVArZ0Q0dmpIVE9OYlhhLzI3YU1ZWjA3TFBEdXR0YVpxNU5QTXRCQXlV?=
 =?utf-8?B?b0lFeDJyenJ4NHdmdVJ3amVMRU5rN1gvZVhubVNVMDE3NUp3cVRPQ3M4eHpE?=
 =?utf-8?B?YlEycnRmSHlydHlLSW5ETGxpSHNBU1M3djJ3bVdNSFI3NThqbXZvSUUremZ6?=
 =?utf-8?B?ZEpWc0hDTkwzS3Zyckw5NmpWWU1ueHRPbklMTzdEYTJhN0UvRTBQS0ltU3BJ?=
 =?utf-8?B?cFNlZ0U5TUFxNEphb1BETEpBUzJmek9MVWJ5NzRNSVpSTTQyQ1YzTUtRaFBI?=
 =?utf-8?B?L0NueXIyWU1YWW45ejVkTGRmSEptZ2N4S2Fnc3FaZ2hZQ0luWVpPbHA3N3U3?=
 =?utf-8?B?dHV4dnNvbUJwNlVzVzRWN2Q3b0ZEQ2NSOC9xNFFUZUIwYnBtSXRxMTF5U1dK?=
 =?utf-8?B?MUlwWHY2TUlKallXMDRCOWM1LzZ0cFg4cG15aFg2VEtUZGt0emxhZ0xjNkZG?=
 =?utf-8?B?SWh6Y2U3K293VzJ0bndXOXplbjV3Z2NNaDlnZjlPWFhWSTg1dUhjRHh0Ynli?=
 =?utf-8?B?RWtDZFc5OGpJK2Z2TzVCVnRxNGhkOGpZaGlmZTUvS0pnSHluUUxyU3JLNHBl?=
 =?utf-8?B?L3ZDbkVVKzVqb0k4NzdQQTRtVU1ha1VSaVZabGc5am93bVBaZExEWFM3SUU2?=
 =?utf-8?B?S05PcXQzSklCeEVrQU1xaDZtQm1wS2F1NjcrQW5zQWpHWHN4ejgwT0JKalJT?=
 =?utf-8?B?R0JVeXFZR2JmYmtUa05yYU1xVmIvRndEQ2psQWgvZEM1MnRMcXN2RzZrbHV2?=
 =?utf-8?B?NExMYmQ4a3lLK2phZ2FnQVJlcjFZYnNmU3AvS2ozTnBqRHg0RnVSeHU0V0ky?=
 =?utf-8?B?eDN3MlZFeXVVUm8yb3p1a1pla1NSVFdETlFvYVcwMXZuTWQ5ajNxeERGR3Zl?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eI2Ox/W/AbDuLYbYRptZPOY4KWbs+ykPmKNHM/XFVE1apPEpY4alfwYSWWl2B6uLRxchKw0TXj3pH3L9UCuS2PWzm5Xcq7ABH+LN0C4qPb54S4V9A3MRhH3ULOsSGD6ee+0bMrCfTTOrXFZOtTGMbl40rx/cDHYgHVJ3fepTe+/F5ZSsH0lao+xghiLXmej4fkYMUqKxFnKLkQORu9FZVZ1LC5i7tAaZosDt2jOlT1M4NmgAnyn4VO9M+gbAwmuDEerEsTVCB3Svp2BwtEbrHEUh+gynHNIDRBopveVCebSGF5NvZvt0NXDwjybmcDNMQhJIC1P4okle8CICJNOQcEdAgNFa0L2IoiXmicS/GxtDl8Yq4WnYo7wZSK/Nf6gDB6KMG8DrLMCywz0uzdhyQfd0z74yNMA8K6SH/YTPLoRcXcvfnwZ0akHzmXH8bTdVU5G/Vd+43URLS9BNp3Gf1G6vlTFYkM1RkYhgoHrj1W1+4kqw+Iv5iuY/V+DeIdu8vEpgYBAfh1J6xVxBA04pdZe0/TnVGyIiTHHzYFYcO4wQGxVx3Cys7TP7eZlNk3vevFQHqYRP50AkAmtbSziw24uoAOou07xANr52TMC+A0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c69be78-af3c-4231-f048-08de23942b68
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 15:40:42.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iShhpIAGSVqgvrWdIaFXb45m3toHRxtpxjETbNlQytO62buu+LL57iPHs9fYmrgvBt+VW3EJnFvroXpC/Gcnuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511140124
X-Proofpoint-GUID: 9Kz7v7H3cLIZ3K9xvD35q7dHVUE2alSx
X-Authority-Analysis: v=2.4 cv=EPoLElZC c=1 sm=1 tr=0 ts=69174d7e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=NEAV23lmAAAA:8 a=m5UjgC2HFb5dN4b6QigA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: 9Kz7v7H3cLIZ3K9xvD35q7dHVUE2alSx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfXxfK0v4hA6wDe
 SafnlJQB6YZwypdAu9L4pmUXbUmkK/ljfseHqKzaMSXqawFrzaCnkL61jWGzhN/KMRcUolggo3h
 4RC+c1K1qDWRGU7UN+Bh+QpTPTktdPhLg4990MLd8gkNsRDGLGc6Srs9f9jbbt6QgyFryNdoJjW
 9H7iwgtkjg3M2Atj00cQfajdP598d3FiFLBNv/LaR8ZMGzby+vunJcK9i04fC9SvRn7RpQfNrlv
 3RBV1pxw+sXdq0QQeHeYGTqi9JBw3fPqz4bjaKzM+BCjD6n5qmjZb2GGSrs30mINj8G3XfuBBtn
 uS3O1rdy9pwBKQ9KurOKQ2MpzducH/S1sScR+C/nFBFR2tfsUoR8KFeAeQxwbze2LwM6M/PsmJM
 uDCXSFP+Ma1rfbXHADlu14PFmwFjZZ564cdYLdWnPpaiOILX1b8=

On 14/11/2025 02:10, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 13, 2025 at 09:20:44AM -0800, Alexei Starovoitov wrote:
>> On Thu, Nov 13, 2025 at 8:37 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> On 06/11/2025 01:28, Ihor Solodrai wrote:
>>>> This series refactors a few functions that handle how BTF functions
>>>> are emitted.
>>>>
>>>> v3->v4: Error handling nit from Eduard
>>>> v2->v3: Add patch removing encoder from btf_encoder_func_state
>>>>
>>>> v3: https://lore.kernel.org/dwarves/20251105185926.296539-1-ihor.solodrai@linux.dev/
>>>> v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodrai@linux.dev/
>>>> v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodrai@linux.dev/
>>>>
>>>
>>> series applied to the next branch of
>>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
>>
>> Same rant as before...
>> Can we please keep it normal with all changes going to master ?
>> This 'next' branch confused people in the past.
> 
> I think the problem before was that it sat there for far too long.
> 
> I see value in it staying there for a short period for some eventual
> rebase and for some CI thing, to avoid polluting, think of it as some
> topic branch on the way to master.
>

Yeah, I think if we can augment CI to cover more we can narrow this
window, aiming for zero as the test coverage improves. The other thing
we should think about maybe is syncing github.com/acmel/dwarves with
pahole.git as many people are pulling from github. Should we discourage
using the github repo, or just find a way to mirror pahole.git
automatically? Thanks!

Alan

> - Arnaldo
> 
>> I see no value in this 'next' thing.
>> All development should happen in master and every developer
>> should base their changes on top of it.
>> Eventually the release happens out of master too when it's deemed stable.
> 


