Return-Path: <bpf+bounces-76890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F73ECC9170
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4194B3039386
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95EB274652;
	Wed, 17 Dec 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5H/K81k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ivg6lE5F"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB8340DA1
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765992845; cv=fail; b=Gg9pSE8dWmMQyJMMhCo/7ZfifcuDMCfhk2aPE3gdUopKljsvRpyjWtcFe2z/bhvQU2bbKMFE17Cny5JslP7WMg14B37Chy0q7YF5vsWX4eI+Da9t3v3Sab4dt9TAP/1puFGSNCsULjgBwGMZxEpAqOcCaY9kWEKuf/kndNdvvHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765992845; c=relaxed/simple;
	bh=DvcTknsxS0766t85Rc007aZ1Sm5FLT3ti4CrJ/vnfR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tb/3V3X7+GQrVgk6qE73/rGt199brtBndPrKbj9J4mzoGtmLjG08BCPsstwMnUsKaEFz58iFs/YdbAP32jZuFtouSulhZmNCxh6q44r3aqIqdNYo+EU6MLQdAVBD48682h5/LIM028CBIOwKUuuwA+UxzSmMl/csihLoUGORfJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=fail smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5H/K81k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ivg6lE5F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHH1ajD3248770;
	Wed, 17 Dec 2025 17:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=La4uHtOuz1bLlaLvinXNoR44uBwgPYlzqLWD3EyXovE=; b=
	m5H/K81k4UOsTP2XJz2ErirMY602sjeK29rKbnR5qfhyhgAGTIr5HH9r1dtLltvx
	AXige9TUGein3pOqcC/GYxXBHIGtqO6Zu9yzQKENDUvxk0XQJMWiyFyFzC8ARt/y
	elZtDa+FA09gm5t6N8hU95w5wVYoEdrvFiHiwsHsly3eUc3vdNkTMdo4JyBQX8yT
	P8fHheHqfDyNwZDqeVbcrteOwxKnN6YKUsau07RzTktMz8NmtxsYlkHu9ReQXcui
	wwVHE83zxvTMqKce13E4HlioujTD4oCllk4jSQZQ5/PBJIHJe3oELN8Gomura9Gl
	xaAfwdQbyMR4aL96vyj3Lw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015x9jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 17:33:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHH6SxJ016421;
	Wed, 17 Dec 2025 17:33:27 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xknbwa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 17:33:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHfxoSG44Fg8nVESQr/4ZG/rnw28jLklQx5HSMbn/nz5DbXszFPYtCV2nx+ERuU6nk/iz9fMQOtXZLM2hmdrlsUNrrOCv7e0lHA8hFrYaTuR2cKgN0UHfAqGp/hjBP9enfbqXAWBI+c072pmDxWvycIGzRdaDujzSUHG7+mPY9YRyUtSRAgUSY5Ec2R9sZqNqFMeMyI48gTmTMVPGStbQwnL2Q2BdA+nukR+vCj9MtyppkwsHEEioD53j5hzo836dIfAL4jMu7PrL37RXea6Pbpk7II8aeGRMk79dfPF2lj+NSg7zPIV9E5o5IWQDCdALKRjh3WIR6pQkbCtKhUG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La4uHtOuz1bLlaLvinXNoR44uBwgPYlzqLWD3EyXovE=;
 b=bRmHBpsRbD/CCGadIoy8FTiUMd47kllfJCjov1MxIUMI0lX0ODk2pTDildYcgcVxG8Qp+7ciIubS0CT3SDNIYURif6tZbJVzUcEifi5iZRgyI1GYj0MIpX+YNbpYV+Hpz92hxK+kBJgcL3zturKAil8wQ7piqYC/8u2C5OrMZvlisdycmOkF/hG0/jMzZrZe+Ii9Hm2wFkzkIlrUy9hm21y9HVSnrZdwxSgxDM1sYn4a7uR+VmeEzsIdMpfBwlfG/q/WP454F/jqCQpISXQMjUNL0MORUuaBaqt+D+7JX9R806iIMQiL7h4vPoUUdZe3WbF7Rgkgw1gxFQULlnaDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La4uHtOuz1bLlaLvinXNoR44uBwgPYlzqLWD3EyXovE=;
 b=Ivg6lE5F1U8+9Rmw6/s8ccTYdx7l4vnw5SBRVwK+F3W1uTLUFchIfVwmQvcoUXjUFtJaWqYlXcm1NUk55zYSSKb1yoWgt/vAqLySlBnrx5tfvcuVM0ONc3ZcfpYftktkDz7V+inamiirSKwybBe/id0Ish0Z4l25iT4eFzgF8Yg=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH5PR10MB997741.namprd10.prod.outlook.com (2603:10b6:610:2ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 17:33:25 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 17:33:25 +0000
Message-ID: <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com>
Date: Wed, 17 Dec 2025 17:33:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
 <20251216171854.2291424-2-alan.maguire@oracle.com>
 <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
 <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::32) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH5PR10MB997741:EE_
X-MS-Office365-Filtering-Correlation-Id: 72bc22d8-a5c6-4afb-87c9-08de3d9261d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDlpNjJYRldyVElkS25Dd2JZUVQxczZQbTl0WTB5L1RiSFpVcWlad1AybWkx?=
 =?utf-8?B?SEZYaUhLR3JmV01mUXk0SmJqTDVVM1gzVnpqNEdNVE1iYS9CS21mQXVRclhk?=
 =?utf-8?B?WTFyMWYxWW51V2tMcTdYNHRPaE1oc1hrUzVpWXhVcHgxVUJhRDJSeEJkWEZI?=
 =?utf-8?B?NGRPc2ZwR2x4UVNFVnNoZWZFU2xlcXlBeWRrM0F3N3g2OExkVnJsR2NJNURy?=
 =?utf-8?B?eFRodGpqSXJrQjNTVWJOM2IyNmd0bkJTbFkzNkVWOFdFbE1scDNzMlVzZ0ZY?=
 =?utf-8?B?Sk04OFJvTXhXbGpjZlJSNm1ySG8rWjc4U29scU5uL3JoZU82S3dTUU11Q2px?=
 =?utf-8?B?aTJIWVJmV004a3krN0JCZTNOa3MrZTYvSEh4RzlqeDdwaTRaVjQreXNxbVB1?=
 =?utf-8?B?ODd0Y2NJY21leWtrSXVjekRLVHQwQldiNzl6QU5vV2c3NlVjUTNXcTFrTml4?=
 =?utf-8?B?V0tZdkdqYmQyV3ZMUWdxcDRBZ2NVSzYxZWc5dGFRWEdNWHc1SlVUZE52cXZY?=
 =?utf-8?B?Y01JT1kwYVU4dVdpazFrZzFEdy93OXN3M0k0NzJVbjJKRUs4ZEVtL3o2ejNY?=
 =?utf-8?B?SGpyL3Biak9BekRJYWNSN05vUnJZa2ZtejhUVmg2TDI2T0VxODB5SEF2cEE0?=
 =?utf-8?B?Y0FNOS9DeHNuaEFSMWk2NnRqcmtvNjV1QUg4cjZGMHRLUEFWTkxKY1BQLzMr?=
 =?utf-8?B?L1JYYW9EQnNTK09pSjMvMEYxMGFOQ3B0RFFwZHJVQjhLbUFvQ0taaEI3dkd4?=
 =?utf-8?B?NUdmRTR1MzViRHU0M1pCakZSL09BcEFJOU8rTS90SXU5VEtub2RwLzdtZHQw?=
 =?utf-8?B?cEpwQ1VGQmMxYS9OQWhlMlpqTDhWQlpudjRaZlhIaDA5bmVKalVxc0wwME9r?=
 =?utf-8?B?M05Cd21MVk9CZldVRjFlditGUjFINVpzOGxDOWFQMDdjVmRFMmN2Rjk3Z0Vj?=
 =?utf-8?B?SDNxajlwQVpqS212eUEwb01IVXVVdGZJR0VKSTdOTDVFNW9IOHJleXd5Skph?=
 =?utf-8?B?cTFrZjlEN3ZNTklVWTA4YmVLZlllWEk1WEc3TU9xVDBhTEZweU5Lemk5ZVM1?=
 =?utf-8?B?eHpJMlVIRm5lR2k3SkJaOFliUFY2VkhzUTBmMWJkV1FTcXA5OGdKN0Eybmpv?=
 =?utf-8?B?bGdLUWNFU1JlTWd5MGVGM3dIWk9vRkRzbUVEZ0xrWEpQbEN0cUJhU2NOQzhD?=
 =?utf-8?B?M2dMZWlsVTRjT0dRcXdMYWdlUW9ZbHFMZjFQUUkrdkdzQWRTd2ltT3ZVRlpF?=
 =?utf-8?B?NFpSaTZzSnNXRTd4MEJqWDFZMFAwdXcyUmN0V21mMmlvZ2YrUE9EMUxGUGlr?=
 =?utf-8?B?R0xyWC9UYlU4TXdkcW1WejB5ZmF3dmhvZXlXSTdoRHRMZVRicCsrOFhpL0NJ?=
 =?utf-8?B?TWxpd2d0Q1Rsc3Nzd0pKeTR1ODZ2VEJ4eGphaTA0dC9yLzVkRzNwcTltWWh2?=
 =?utf-8?B?amRVWFJuTlkwMjlyQmRZRmkxQmRWRk5QYnVRTzZWK3A0S0FqazA2WTdVTFNM?=
 =?utf-8?B?VXRBdFEyNWh0U1ovcFY4M2lGQW1ENHR2YmxwdVZETXM1SmxveWtnSGlSTWUz?=
 =?utf-8?B?Z3hKdXhxaHJHcElQdzZ4bkNWTHB6bmttSGZBRGZXazY3dmZMT3p4TnlkbEV5?=
 =?utf-8?B?OWRma1k4MWxhbmNkUjBEQ3dYWUtGM2tHRXh0ZUt4RzBzRVRwOUpIOUNBb2pQ?=
 =?utf-8?B?VlkrTW5CNjRGRGZoQ2ZkNHVqdWlYR2kzZEVIRHlhdDJlUHJyNllNUDgrTk5B?=
 =?utf-8?B?akd1VnBpa2FQcFVMUEQzZTdxejhkcHBmWE9XMUorb1hGMnpId3IrRWYwN01P?=
 =?utf-8?B?Q0FpZWJxUlpTdmVPLzFhQ0wrYU5zZmJxeGV5VmhzRSs4cEhxdVJkYm9TRG81?=
 =?utf-8?B?K3RQMmFMVmxVbEc4eWdRNWNpUU5jcnB4eWUvWXZ5aWFOQTE1VXcyNnplKzVn?=
 =?utf-8?Q?iQ+Hly2x6of5VCPCXofyl5CEZbhK44A1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2syMjIrdTFvWE5TZkw0TzBGaGZpdE5XcVVPbWhUUXJIVk42cCtlSG14eldF?=
 =?utf-8?B?UjBybmpMczFEa1FianIvZ1pPSE5XeTJFdHdVYk5rVDZsMUE4U3A3RW1rSXlS?=
 =?utf-8?B?dlY0Umc3S1d6REVpZENBV1F6VlJ3RG82UU1SVDFuRkhPK1V0TmxOUHdVaVND?=
 =?utf-8?B?REE0bXpOeDE0Vit2dFg1Y3ZvR2swQ2RlSkk1OXZOVzVvSmpvKys2ekhrM0ZZ?=
 =?utf-8?B?ZjV5ZUNHK3drblZzdEpXd1lYb05oeWtIYUdYNlVGS09ZbVBrcTNTWGRPVEpk?=
 =?utf-8?B?cnFZRXdmZ1drajhoN3cyZ01sbWYzTmxxR0xCM0FzWHNOUWgyZU9wVG1YNkI5?=
 =?utf-8?B?WDBQMi9RZzNxN3MzUURnVHc5ZERXUGxyWlgvTXIzTlo3U09OeXdJei9kMThM?=
 =?utf-8?B?aEppd0FzdlVGVFB1S3lVdkVmOCtQQVJLOE5kOFNBZjFxV1lPWjUwTEJ0VCsw?=
 =?utf-8?B?YVNIQmQzbWJrcGZkREwyam5qZVR1R1BHOGdnL1M3YUxSTm9CdFUwYVU5TnB4?=
 =?utf-8?B?VlYyRFFRWVRCN04zK1V6Z1R0ZkgvOXZCby93ZHB4U1haR2s0MzJBR3loVXMr?=
 =?utf-8?B?c0NPSjZaNjVXa0p3aDAxRVJaVWljaWpqT3AzV3dMUzlza1ZFWFdoWktIM3Bj?=
 =?utf-8?B?a1E2TTRMWDU2NnJ4WTR4cXA1UTJRby9Zemc5SUtYRDNBSi9rbllYNCsxRmZR?=
 =?utf-8?B?d3JTYlp2cGNMTjBhNERBS3lxQUFCTzB1NVR0VUl4R3FDYmZUdyszbXdDbFht?=
 =?utf-8?B?RTZrTlROQUZ6c2ZYWDdRSGhWKzJVVlpOcUUvS2hBTXRuSWplZGY2aEppanF1?=
 =?utf-8?B?eExNbStxSG5rQ1VxLzVCekxPdEFDNlFac042Y2NkeDFRd0lCOEJ3QTU3UW8z?=
 =?utf-8?B?Y3g3eWVjNjFoeTU5a2xTTTZEd0czaVIrYS92UElFelQ2Q1dwUlBKVjlwckRz?=
 =?utf-8?B?L3NtaVFpN0p6emQ0TEcwU0RtQlp2VlpBSDhjZkdrRWFXTE9RdVJTSjMydEZB?=
 =?utf-8?B?aW5BNU55cysvSENjeGtvUWt6djFNVVhDajFFd2pjbVlscE1VcDZpZ2MzZzh1?=
 =?utf-8?B?R2pjS0tWS2FIQUoxaThPTGpVT3hvaDZiVzRpaXVIZFFwMUNHTnU0RWkvbzk5?=
 =?utf-8?B?cm9DcWp0M2l3NndoLzVtbFZMRjZiQUVRRE5pWTMxcTVmUWxxVUwwK2txeUkz?=
 =?utf-8?B?ZDAyQkQ1UjR4YldlU28xc2pOVkJKaVcwV0cxN2Z2dVBkUEM1TFZ6dUQwSWsw?=
 =?utf-8?B?NUFJbUpTbEd4b3pNVUxLb2VZTm0yUGVlVkYvUW4vU3NxTVpSN1BxZ1hoSkNI?=
 =?utf-8?B?N2QzcmtnbW91VXBqckhwN2FYZGtPK1A3S3FwTm9IaXFFcktiS2g0WmljZnRj?=
 =?utf-8?B?NkJMMmt2bEhta0NpNGxpMG00MVRYbURuTlhqMUM2ZGcvTk1TRlFSN2tOOWdE?=
 =?utf-8?B?cnFSZ0VsZk0zWXN4S29HYUlTYmJybWtBQTdlb0R1Uk1nNHBES0F6RjF1RE1v?=
 =?utf-8?B?VWNPNDZLekJWdmgyTUdZWFZaTWxiTkVLRGxOdk1LZmhpNWxFN1kxWVpiczBN?=
 =?utf-8?B?elFRdnFOL2ZaWHNxK0ZiWnJBc3l0Qy9oZitQRzVNS1FTNlllb1FJSDdkSW10?=
 =?utf-8?B?SGxKaWtaYnZ5dnRGTXJPQ3NFNFFOWVlrb2dWK1pDc1NVY2RkTEhwUTVUZWNr?=
 =?utf-8?B?ekR4S0NEMUsrZXJGMG1sQlozMzdaU1N6M2ZZYmZ2RzVjNXhlRGc5SlUvMCtC?=
 =?utf-8?B?UnFTbnVsRHhYU3Ruc3k2Z0RXTkl0NThBelJ4YTF6ZWhlamZnNlFiMjBSNzYz?=
 =?utf-8?B?ejIrNE5VQ2VSZzNFY1FMMTllR3dXTTNrb2QwOWtqS1Q0UFphc2d6UTdWc0I2?=
 =?utf-8?B?RzBqeHdIL3F4VTlVdzRGTGg4RW1CUSt0WW5yMHlXYXN1TWN5OE81S0J6U1pV?=
 =?utf-8?B?ZnZIc2E4Rit3dDVjYVJnMEh4Ym0yanRUQXBDWG00eUQ5TXdoWmlLOUVheVpa?=
 =?utf-8?B?dUpienprODJLS3hMaXJvVVl4WTZqaks4Y0JuSjg0aEZYcE5jemZpZGV3VGpz?=
 =?utf-8?B?dWw3aGdVUHBHeG5ORlpZNXUwZFJRTmkvdS9HUTNGZU1OaGV3eHRwRVRjYkEr?=
 =?utf-8?B?b2NLbXU3SjBBZnRVeWRLZzU3TloyTXJMNmljckdRNzdpYVYvaGs2L0RTQ25Y?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DvHn3xslDlOy1ecOO2Rf15QfYFuYfOvnmwB/uQAvXtu4YXsoSw9h/b2BLj+p8ThZniNfyOFdrs68uT3TDtKc9KpGT2xzCpVE8v4nnmWeG+cEHcFoHdjViewWnCiyurLp5btGg3KzWiD1SR4CIvn2QsdfVM9hy0CkPUYe6rtqeGKLeiMDfvRlEqrzwzE8n++7kSnWYwIDJErdIB+lMby6wE1ctZQxjVkjqvD/1x5uO5FxusaatMjSgjnp997RC4R3Y+cncN35K5QO5iv8w9StKPVufm5o/gPJfnc0phY7a8P0JMJJyksWHBr3F4kzZwT9UfJYNJW257qVKD7oGSHb8IQFjTKg7jC6WuX5RHeDDEfQQBJt0nzBfL/+tctCxpLCzNvyZ4CR3/ZuG0NZuh0ZXHUQWKeBxfnqYrqR+EopzZUzZeopgE5tQBY2LS18ZYMY+QawtqaaP+SUARgbTzNaHUrnuAzWuLbFnXavsxCnkyzISPrDfEtW5pGk1u37r1lfUtJZXRYHwfIcqsPY+gJE+ZDECdLhTZzeKabp2Ol3+Y86XqWM/HqijIWddzAD3z0Q12a7cX9dOKdrMlz+22oShG70QrRG3egBtN2DbRZtGFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bc22d8-a5c6-4afb-87c9-08de3d9261d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 17:33:25.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/eFKMpddxnqgE11EI+xC3lIZhb2CN6jVPKbK/WbrTLvftlmBjE5S3WXK1/5rXyf9WTu05Ur4Rf/QYcF+qC1pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170139
X-Proofpoint-GUID: 3C45LHBKWWBkLxjAmAmwayiNFW-_wOMi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEzOSBTYWx0ZWRfX+95EimMF9vmV
 i8OeXIXJc0R2vRM7jwY2Ciz94Z0Qw9u8PJupcAIoGd2FgWq3jMbtMbW8zGwGprl//lUhQjkp2BX
 dFn/fdBeJ1Q+7pBKGU5en201xmjUlwbyw8j2D3JvrT7raPjkrEWY7eM01M1ER8FtWwqGjaJ8Dhd
 3KA4WOpImujmS8H6H4btmBjaURmPRVa13UFGraezD9KhiUDCdt2BOgoTWEXLLfcvdA6tUI5EHwS
 mDQIbl6KKbP9AQNVqcXtQkaf+bkgR/Yte3ZpJJ3yWF2Wscs4SaqOd17vtFCVlvAfe6S2YmN2JMn
 cHyqQjvtbACAENB7PRknT2eJC20lqMsP9I3Cq1UEM10PAU3qAXg1ejNytRBsuaiEqb2szFMjqNs
 VpCMvvhJrbx4QLb9Z2Y6g5+VnLzvI0UJSYWF5/+J24Lkyer3QYs=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=6942e969 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mDV3o1hIAAAA:8 a=Twlkf-z8AAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=sKAXMMDeWj2wB9OwhO0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-74SuR6ZdpOK_LpdRCUo:22 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: 3C45LHBKWWBkLxjAmAmwayiNFW-_wOMi

On 17/12/2025 17:06, Andrii Nakryiko wrote:
> On Wed, Dec 17, 2025 at 8:13 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Wed, Dec 17, 2025 at 8:06 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> struct foo {
>>>         struct foo *ptr;
>>> };
>>>
>>> struct bar {
>>>
>>> #ifdef __MS_EXTENSIONS__
>>>         struct foo;
>>> #else
>>>         struct {
>>>                 struct foo *ptr;
>>>         };
>>> #endif
>>
>> Did you test it ? I suspect AI invented it.
>> I see nothing like this in gcc or llvm sources.
> 
> Grepping a bit I suspect we need to check for _MSC_EXTENSIONS, worst
> case - _MSC_VER. But Alan, please double check in practice.

Thanks; I tried these too, no luck with either gcc or clang. Looks like the
requests to merge them haven't landed yet, latest I could find on this was [1]/[2].

I guess the other approach would be to have the user explicitly #define a
macro prior to vmlinux.h inclusion if they want to use the extensions, similar 
to how we handle BPF_NO_PRESERVE_ACCESS_INDEX; maybe call it BPF_USE_MS_EXTENSIONS 
or similar? It could default to true if _MSC_EXTENSIONS is set to future-proof it.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110977
[2] https://reviews.llvm.org/D157334

