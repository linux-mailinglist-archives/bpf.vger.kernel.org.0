Return-Path: <bpf+bounces-43179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D6A9B0A83
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 19:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB159281A09
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374D2064EF;
	Fri, 25 Oct 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VPG1Pv+m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KA66uWPs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7652036E4
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875973; cv=fail; b=uqbzJopjfKTkuvQf0ONeh125D0MTNpE7AUFXu/OstLkIFLYZ+yv9eSdxggsHFRo5kfsgRZFlxl6bG3V3DnnAQ0P/DR1OAw276yXt5Y7b4Y1VuxVPw1Qp1/yvV+jnaiNU2nyzenM7CbSzTCh1zHUc7vmB389gRVYs9z/3JEUjmqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875973; c=relaxed/simple;
	bh=f/M6QF3+HaQUWGFzBn/LhZLj9M8JHLfoLviSxB2DcF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jUhiNJWFBsJPe2V1rj8H1jO+CWd73XYFIJUF81kmFCsUPMGeH6bboI7s5e07JnAy6s3imxhph1YJdK9p/ea6eyjJJT4vqW3Rp2uCnxlHagOQ8ULlxfuKd6vc3JOQRnrfRHCWbBDLPqkL/iE3gPAJQ6NE/XdEv04M0fOFEraaHw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VPG1Pv+m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KA66uWPs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG0YKK017097;
	Fri, 25 Oct 2024 17:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ot7kM/Xz4iI/gUsnvNLYpYea2U0P7NPdqG3k5YExqz8=; b=
	VPG1Pv+mfozU40SQb8IdoWIwxTaHtFAUXKRuQoYqSbCSK3CWtaXTJ7TFRrDMzmbH
	eG39xQhUvpvmqlUtBmg9VbBw7ObSW2NGE1H3Y2db3k2ekFXjR5HU7s8nvGH/mR2o
	amV3+oiFNDV5g6x7xAsm+DeW1lXGhEfK3k9OZOB+XWZjyA6roKfXupiw8seA4PWv
	hYUzPjtoNOxQP8pusYs/qsSeQs9RIly//Rd4kC2K/Nm7k/PBzbaOgl14Qy0mGfk8
	ssTIUNLEjGPiMgLMV3TpR4j86HfZCgxzx6VtYRWM7sMiH4fr0V1Mcz+uBuW/hRAX
	p1oRfiNMnH9V4fMHzeeyQw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55enaas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 17:06:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFdWCv020925;
	Fri, 25 Oct 2024 17:06:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhnmfw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 17:06:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ta4DCjWWKawem4YeBzS3lbVw48XwWkVsk/52Hmgq2JkJBRah5DAL3rvE55kkEWapYnNsiyG8+C9OpZtR416QcftX4kcbBTLA2j0Nu/ZDfX8PxuE5xKNuxFpT4rAR79xxIYmKgwcgjjgKkYJllAmKLPrYeWotu86kFuXFavX+afs+Tecp+JW0MI0N2ECZxiH+Lb+Vb9jaQ0zbyQadsscMHVd0Q0I9qOVH49veU89GMpO4oBrLpabmXvsPzkNi9up8f83Cpgevav2TNzYAOCBEgs2Nj1+ejz+f7WlNJKpQMbMy+03Xvw4gmFd6+RbC7reMD+daPY9Sk/Y6e6popeGPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot7kM/Xz4iI/gUsnvNLYpYea2U0P7NPdqG3k5YExqz8=;
 b=OKTI+D8MzxhNpxrZEwVtW6RlQTlYV+fQDXME8ZA71ZyRI1ECo4+8g7A1Oy0ltN5EiDTnaA2KTyQvh9JQ0OMC2GhLOVESumuy43mkxEqYBDEwMa3oRor63Nhx2U7AMpmughBnu+BbRUULC7KhZOafDT7aTpT5CG3zz20uNGuxlIcbaQSt9IMFUvVZepUXCSJT4GzArHuUnwjWFD6PkQJ136zIusrlnRorUWpi7Trg5xGYSeF3yvG7bz5zR0fTpr/91dxQt1OWqQMAYWaN6qTjyiO7qdXOY7s5hDgLtfM0qAb1UmCDuP7bMHw25lPmnn/jc/kcnqpVO9N/LPKu+wMcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot7kM/Xz4iI/gUsnvNLYpYea2U0P7NPdqG3k5YExqz8=;
 b=KA66uWPsNOUyd+lp6Piwd9e/d/al0oNeB7K0hkB6JOHB+UjRZvjwUGaXh/7dcwcLNzG8NOFsLTqHj4CfR8R7vVYdGM+mFnFMQOeB+Pu3v1BGZqbgMZa10d0cXmEZIeTB5HwSYmM1RlmxQSEP6baTQYgE6JMMf/tKq42Hw/foASY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV3PR10MB7983.namprd10.prod.outlook.com (2603:10b6:408:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 17:05:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 17:05:59 +0000
Message-ID: <9e14fbf9-4a38-432c-ad87-8eebe289a9f8@oracle.com>
Date: Fri, 25 Oct 2024 18:05:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Questions about the state of some BTF features
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>,
        acme@kernel.org
References: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
 <b58c8ae4-3a5c-44b3-bc85-2dd7dcea397b@oracle.com>
 <CAEf4Bzbv4SrQd=Yt7Z2PNQLT+1VkLKMaERFwfE8d=8s7QQ-_bQ@mail.gmail.com>
 <16877742-7f15-4fd9-95b4-228538decda0@oracle.com>
 <CAEf4Bza6pL1-2AmX-zfuv5-mEk=b6yhhGRtb7DrkUTsArvEO6Q@mail.gmail.com>
 <CAADnVQL2CNSMi1NoNTVePw_VaqHYZJ4pLLX25wJjD1R66ezYXw@mail.gmail.com>
 <f07ae723-2773-4dae-88c9-2d26903182fc@oracle.com>
 <CAADnVQLmSKATXzi+++hGpk0i-UiOKk8qt9N2CGBkznCRVr=qcQ@mail.gmail.com>
 <4ce7da07-20f7-4684-b60b-4704405fa703@oracle.com>
 <CAADnVQKFjK8BnZ-rYzXKv-Zdw=HBJRoJ7jo5PN+0P6+qpJOxNg@mail.gmail.com>
 <CAADnVQKS-j2O7nCqmmiXF1-gJnZHb5-TY70kHZqHGxFUO7FSog@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQKS-j2O7nCqmmiXF1-gJnZHb5-TY70kHZqHGxFUO7FSog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0258.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV3PR10MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: cade4131-0522-47d1-f4db-08dcf5174c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXA2UFFUNzd4dVJKMDUrZElCSmYrdlIrWjErNWc4Q0c3cW16TGh2SVZaZzBq?=
 =?utf-8?B?N29HblFDblViSUlESHo0ZlZaSUxNelh2NW04Rmo5UEw4VVJGS0pobW94eUxa?=
 =?utf-8?B?SjFZZWFFTzZuOHB4U1JhUGhoYWtzZmhMVlJ0Rk9xTlgySWJSRVpmOUZMa2ZN?=
 =?utf-8?B?cTQvR1A3Qjl5c0F6WnlYN2RXcHE4K2pqVWFFWUhFN3dxU00vYlFEMDE3MUIr?=
 =?utf-8?B?THN3WjdwdE5IV0NLUkZkTlV0MUg2TC8rVzNnb01KblNqdjRVaFNDOVJPM05l?=
 =?utf-8?B?MlYvODBkR2QrT0lIVnoyOUwzNmh4Q1dKRUdaemNQRm1ON1pYK25kczRhc2ZB?=
 =?utf-8?B?YVk5UXVWcVRaOEZLMkpkUXFieGlXMEMzZmJTZEdzc3A0eXU1QjRzV0l1MFRM?=
 =?utf-8?B?RWxnUUhScVpkY213Z1Q2b3d4eDJCc2dzQ3B1dHpBTWFwTE5QMHpUd1cxTWdD?=
 =?utf-8?B?Q1M1azdxMU1uZis3eDVjWnRhUmxDdEJBeWc1bzVlR2xHdVhwLzdJMzlSSkd5?=
 =?utf-8?B?eG1WcWgwNlRIdFVqcHYwbDBxbVhvZXdPKytXUnh0Yk5PL0l2SmJoUHpzMzJO?=
 =?utf-8?B?WkhlbThMdGs2M0Fsclp6OEJLZjFwZGJrVWU5Z3JpeCt1VHZNWjVBMmRlZzQv?=
 =?utf-8?B?c1NJMDQ4VUJaeTJGWW85MmNka0NOcUo3U2paN0luRjR3bE9HTFJHeDdzMi92?=
 =?utf-8?B?VHBEZE12ejNPUTVIUHFaYm9CUllaUDg4NUExYmRGQUpQZ3huVFNtT1pzTG1y?=
 =?utf-8?B?MHZEdWxid0s1dU42NkhKdG02b0pFYnRlczdjZ3AzN3pEWHpoZDRKekRzVXdk?=
 =?utf-8?B?RGFaS1N1QWtqR2NlbHlTd3VaY3VGcGYvWkdnOHk2dGsxR2xrWkMvUGVWdjhJ?=
 =?utf-8?B?OFpaYTBiV3RBMTBVSlRIRlo0NFJ0ZnZBQmJZNzFzaUdGT1RPc2xmQlpsVlB5?=
 =?utf-8?B?K1prdkJpNnRrQjV0TDZNMzZPOFVSYUQ1MUV1ZkJKTzI2OWZDYmRpTDlNYSt3?=
 =?utf-8?B?K2Y5cWhMNHdvejlGbkVUZ3o5QzFpNWMyTDhPREtudkFSd3dIRFR3dXhlb1hw?=
 =?utf-8?B?TVRZTFFPd1BRamt5Y3pFSDh1VVZnZkJZMEJXOXJ3WjEvTEJiR3k4Q1pIS3lU?=
 =?utf-8?B?WW5wWnRWczFlelc4anZ1NzFsUXB4UjBldE1kdGlFUjk0QUl5SkNEWE5UanZn?=
 =?utf-8?B?QXpXMmlaUGRUMmwvZXNUZ21DcUcyOVFJSWdTeVNZd2ZUN3dVWWc4eXUxSHM1?=
 =?utf-8?B?OEZ0SFd3WkZ6NnNqQXkycVdhUjRvWTRYRTRoeGFYRGxPME43eEx5OC8yQVJx?=
 =?utf-8?B?NWR3RC83U1Y0YW1wYk8zeVEvV0c1NGs2MUdaem9MSTk4Rm5WdklpWlhkNk84?=
 =?utf-8?B?WUJvSXZiOE0vT0UyUVJNNXRWZGF2U2JKdzNVTHl6ZVB6MytoVmxOTnVESTRj?=
 =?utf-8?B?RzVUdExCUVRkN3ZvNisrbGVkdCtPbW81c3E4RUdYWUExWDlSSmNqVHUwMlFQ?=
 =?utf-8?B?MlpPWjhhM2pqN3B5S2Eza3JwSWlPMW9LTmM2MDVhalYrczV2WTRPaU1JTjZG?=
 =?utf-8?B?cU0yZ1E3ZlZyUHI2dmgzMVFiRk1PRkJEQzZWMkY2RFdJQ213blpiOUN5czNz?=
 =?utf-8?B?THFwK3J4b1dOTUFpLzJrM0tESFNrRDgwb2V4UGl1OW1DdDhZZGZKYkRlL04y?=
 =?utf-8?B?OXVjSVhNTm5QWVJlaVA1SFhQcFpPUGdPQlU3aXM5Q1JRQk1oYTRSbkthQ3N2?=
 =?utf-8?Q?LSrSqYAIKdVyGweSC85oiHvbAJowD676Jo/GEpZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlExNDlhdytVbnRBb3BlU1hlUnArL3QxNWMrQ2VtdkQ1RVZ2cEdZRjhYWmx5?=
 =?utf-8?B?cTFWelcrd0tKRFRpb1dCclVZc2FXNXBTQnVoOEI0Q29OM0x4V1lGc2R6K1VW?=
 =?utf-8?B?QU8rUGxhRTUreFNlTHViU2tmQTBzaGdyWFlUL3NYanpZZzV1L2ZGcUhNbktT?=
 =?utf-8?B?TTFibXRNQWt2YkFlZkxKL1BDL0ZHZHFlQ2lwOVNDNGhnUkVkQ1dvUVdIckRz?=
 =?utf-8?B?WEVzYXB3cFBnQXd1dTNScFdqbnNwR0swbys0VE5TV3l1M2dHQWZIS29TOXpG?=
 =?utf-8?B?ZWxVeVh6UStFNE9OZEVnSTlqUmVNNGMxcnU5K0RZWXY0Z3h4MGZOZ21xc1U4?=
 =?utf-8?B?WTBzVWVhM0h1QXEzczZaQTBZdlovUDlEam11T3daYjg2bHpZUEtpTXJhL0h4?=
 =?utf-8?B?WjRjaG5MOUNwUFMyUEl3ak14UEpoRk1jY05LV2R4ZmcwMHc4d3NMbWd3bXJ4?=
 =?utf-8?B?UXNucUY3V3lnOXcyRGlVQ1RVNU52cFh1L3hlT1Q2QTdLT2RJQTlHcmhLTENM?=
 =?utf-8?B?Nkl5VFIrSXpvQm1OYTY2YkVnaUFMcjZXeCtOc1NvcTZ1RSt4UXRCdXJkd0R0?=
 =?utf-8?B?SjZpRzBpTzZCNzRSQ2pVa1FjUWFDSm5NLzFOREMrVStwRzgzd0hoUUtocVpk?=
 =?utf-8?B?eVBadGFRVkFyRFk0VHpxMWt4V0w1aHRaUkFRTXJyQ2FYS1prUmx2KzVLc3cy?=
 =?utf-8?B?b2paQnI2QnZDamVGY0REbGlydkt3Mmk0cTBZQUV2b2dLM3BNT0JTNkJHTmFH?=
 =?utf-8?B?OHJ3eEJpZ2JEUG41dzVqU2tDMzBSMFJaWWRGM1BvN1F3V3ZjMFMyekE1NHdL?=
 =?utf-8?B?U0pwY29UcVEyeDgweU0raFphVkdGVVhXY20zeHBpcUkzYTd3c25vM1NLRVdB?=
 =?utf-8?B?czBhTFB2bUJSMERwaVlhNW1nTnFYc25vQThiM25RUGJNK0xCVnN5ZWZ4bUF1?=
 =?utf-8?B?eDl4K0RleWszQTRQeVNSTWNNeDFHcDlkMlBNY2RnWmlXMmVrZWV0MkVONTZE?=
 =?utf-8?B?LzNWbVErY0ZjS2hJZ0JIRFR1NEtUbXRWenhCYjJLNk1qVGlQR2xsUm5wWVEv?=
 =?utf-8?B?Q0xTK3FVZTNRY3ZzOWJPcFhqQTRKNktQUkREWHZob3QvdzVBV2g1M1NxbHRG?=
 =?utf-8?B?SGoySjR5NjlhRDJ0cjR6SHZwZUx2TmRTTENmMTBCZjRieGtVUUc0M0tJZko4?=
 =?utf-8?B?OGVjMjRTb250R3FWWGlFVlZ6RnR5ajZEWkZNRCtoWVkwZ0U3VnBRVVNOckdZ?=
 =?utf-8?B?WnVobXplUm5lalRPRktVdDdhaUxudEkxSmVQaSt3ZVJoUTJ3SzhFdWlWN1Uv?=
 =?utf-8?B?dlJFVEpUT1g4SXAyUkhRSmhOaWFTRHp2K0xpeEk4dUpJeEVtZ0VscTU2NmZj?=
 =?utf-8?B?ZmgxVkxHMWdycGVRdHpJV2VZMkVSUDB4MEdiSTVMcWJFZTZpeVgzN1BkcGpi?=
 =?utf-8?B?dVFJcm5xU3JxYms0MG1mVlh4eE56Tmx5UUJRNXh3b2dCZ3RYWEwyS1ZUMUxR?=
 =?utf-8?B?eUNZVHFZMnpQQlY1K01RTzFuYlkybWZTSUo0b3l0aUFTRUJVdGhRWVlkR1Jz?=
 =?utf-8?B?eGMrVzkxN0VzWkM5VVg4VHE2MldwNC9OV2tjelJnM0lCVlpOWlhDOTFNL2Vj?=
 =?utf-8?B?ellhUlcyS0RkeXNMMi9Db3M2eHA4ODVRNmV1bUR5NTBFVHhlMG9hMHp5ZjZK?=
 =?utf-8?B?YUk1R3JPQjJ2U1B2R1luVDZDQ3JVaHdTMDRsRndEVzRFMndMbGYzc3MyNy9Z?=
 =?utf-8?B?NStxQTltS0ZmRjlJdWJwK1dUVWZwaWZmNmQ3QzJiMTRpWFJpZmw3aDE0YmlM?=
 =?utf-8?B?M0tjNXVTNnpReFl0cWVQcVlLaVVJM3FsMWZyTmJRTU9CQWJlQVNMa21jVEVp?=
 =?utf-8?B?dnFzTkVSdWEwQ1NtbWVzdUlFd0JuZ0RtVEk2SFplVXJxeHowT2QyRDVtTzJK?=
 =?utf-8?B?cm1zMHZRaXVqMlNYUmYyUXhoYzBnTWIvWDhlZW5vK29kZXJ0UnN2UDk5b1lC?=
 =?utf-8?B?cHluYVFIZmE2R1VpSGVCaWF1eUw3eUZES05TaUJCdUVPM0tQaXo1Rm94OHNO?=
 =?utf-8?B?VzY1U21RNi9kc3JIZHhOczlwWnBHTWtoYkNhS2FDS05lTm10b01sNXc2OXEz?=
 =?utf-8?B?UG11cUlMSnY4UU5pNFcxSGRacUZwaGYxZUZBTG1SVTBzdjVYWHhON3dlMGMr?=
 =?utf-8?Q?EsSoEcZ7Uiy8/XZj+oyR4IM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7iosEZJr1Sh2QwtRPzGkkl7qTVY7/lv39DUxNHOoda5pGc63ChNhwJlmH/ToKN3jWcAYghcgRcxQxMVdTSHSntmyn3pLaWq1LiHSVlUTMZyt4eo59A2GzaFb5Ir8oK16ccJTZpQI+quW6AH1d3KE+xds6RAWy+43/L2RSmg/MVR7NyOU8Vz+EEma6JsCST5As3wvW+/rtbVVpvf4U8jL/CyVlQw5PxfVMIWSacCKDTUctRzke2WiSp5t7O22PaRcI8NmSg64tmhb5EilLvVaWLgiSaPDd9B5ecCjEZpe5U9SIME4lke24m7IkXFeg9EdLTHz1gdVEMce/plzJ1wefOSdpjV3RNlKT8fN/rnrIvWGbqG9gTu9t+tZYlMoaQc6h1uYi0vWkoWZHxpRhkynOO2/yAqKRE+IKZ2X817VWgwHcHPw60yXYwWe/4oRsdwUvhZMJMTN7yUgcCA5Ja23swiDG5HX9lMthrfgDCl5cgrYWYT3ReUiSY6E1qmEsDYp4Y23JUEq2NElE/4UGA0tS3ok3BS75jR4fPn+zrxHOuGPLdN/aothNbni4LrA97S+QOr8eS2SWd9RTGQ68tLE2UPoNbJ/wlaQHadXVFXWYzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cade4131-0522-47d1-f4db-08dcf5174c5c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:05:59.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyvfY2ziAdY/ICtazG6akiI6ru38QGwmhE9d7Qc9RDIh4IYK/PxyeymPNQ8VHm+8wGuEn9nE2XhlXvTIVJlHpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250131
X-Proofpoint-ORIG-GUID: z6zWPFGcp55lNIKTCUJX-8SVhNYgnN6r
X-Proofpoint-GUID: z6zWPFGcp55lNIKTCUJX-8SVhNYgnN6r



On 25/10/2024 17:51, Alexei Starovoitov wrote:
> On Fri, Oct 25, 2024 at 9:49 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Fri, Oct 25, 2024 at 9:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> On 25/10/2024 17:19, Alexei Starovoitov wrote:
>>>> On Fri, Oct 25, 2024 at 9:15 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>> On 25/10/2024 17:09, Alexei Starovoitov wrote:
>>>>>> On Thu, Oct 24, 2024 at 4:26 PM Andrii Nakryiko
>>>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>>>
>>>>>>>>
>>>>>>>> The good news is that already happens, provided you have the updated
>>>>>>>> pahole to handle distilled base generation. After building selftests I see
>>>>>>>>
>>>>>>>> $ objdump -h bpf_testmod.ko |grep BTF
>>>>>>>>   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00002c50
>>>>>>>>  2**0
>>>>>>>>  50 .BTF          000036f4  0000000000000000  0000000000000000  0006e048
>>>>>>>>  2**0
>>>>>>>>  51 .BTF.base     000004cc  0000000000000000  0000000000000000  0007173c
>>>>>>>>  2**0
>>>>>>>>
>>>>>>>
>>>>>>> Indeed, after updating to the latest pahole master now I get
>>>>>>> .BTF.base, very nice.
>>>>>>
>>>>>> I pulled the latest pahole, rebuilt everything,
>>>>>> but still cannot get it to generate BTF.base.
>>>>>>
>>>>>> Any special trick needed?
>>>>>
>>>>> Hmm, should just work for bpf_testmod.ko as long as "pahole
>>>>> --supported_btf_features" reports "distilled_base" among the set of
>>>>> features. scripts/Makefile.btf should add that feature if KBUILD_EXTMOD
>>>>> is set, as it should be in the case of building bpf_testmod.ko. I'll
>>>>> double-check at my end with latest bpf-next, but it was working
>>>>> yesterday for me.
>>>>
>>>> There must be something else necessary:
>>>>
>>>> pahole -J -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
>>>> --lang_exclude=rust --btf_features=distilled_base --btf_base vmlinux
>>>> .../bpf/bpf_testmod/bpf_testmod.ko; .../resolve_btfids -b vmlinux
>>>> .../selftests/bpf/bpf_testmod/bpf_testmod.ko;
>>>>
>>>> objdump -h .../testing/selftests/bpf/bpf_testmod/bpf_testmod.ko|grep BTF
>>>>   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00001d94  2**0
>>>>  50 .BTF          00002ea7  0000000000000000  0000000000000000  00062e30  2**0
>>>>
>>>
>>> Not sure what's going on for you here to be honest. I just tried pulling
>>> latest bpf-next and dwarves master branch, rebuilding pahole and
>>> selftests. I see .BTF.base sections for each .ko in selftests/bpf.
>>> Can you provide the output of
>>>
>>> pahole --supported_btf_features
>>>
>>> ? If it contains distilled_base things _should_ be working. The only
>>> other reason I can think of that you might not get .BTF.base sections is
>>> if dwarves was built against a local libbpf (rather than the git
>>> submodule)
>>
>> That was it.
>> I did 'git pull' in pahole instead of 'git pull --recurse-submodules'.
>>
>> Thanks for the tips. Now I see .BTF.base section.
> 
> Forgot to add that even in this broken configuration:
> before:
> $ pahole --supported_btf_features
> encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,decl_tag_kfuncs,reproducible_build,distilled_base,global_var
> after:
> $ pahole --supported_btf_features
> encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,decl_tag_kfuncs,reproducible_build,distilled_base,global_var
> 
> No difference :(
> Both claim that distilled_base is working, but it didn't.
> Before had older libbpf submodule.
> Maybe it should print libbpf version or something ?

Good point, this should be clearer. I'll send a patch for pahole which
will ensure the feature isn't reported if libbpf is too old to support
it; at least that way it would have been more obvious for you that
distilled_base wasn't present when using an older libbpf to build pahole.

An extended version description including the libbpf version might be
helpful too, though we shouldn't mess with the format of the basic
pahole version string since it is used so extensively.

Thanks for catching this!

Alan

