Return-Path: <bpf+bounces-74527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1140AC5E477
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 17:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D8565070C4
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538B330B32;
	Fri, 14 Nov 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T1rLepw4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U6ZkWTi7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B42192F2;
	Fri, 14 Nov 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135855; cv=fail; b=MuYqq5YjufIGq9pc/i5dRiQy5H/EpmpAORE8eZj1ZHkQtJ1Mz0wG4PXLqNN8P2i0+YbRD9G70e3033258Uspry9ajBHvxJ5sKeBIIFraRaLrLbedOx3jO7ZEJ+ocjfz+P3POtX9AXCA22cGXvaCY7vDt2KMP0zn9Xfy744w0frE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135855; c=relaxed/simple;
	bh=+dFhxFqYU1jRvdAvYjHw3EzmyFrvkkwjfEaQ9T5tAEY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iMv4vesxOH8kBbk61NeLkIGrJ/hqqiUAGEKqsaikxROQ67dJk2uNR+wHvKFP9lUcfr+RrhV6O72xf/DGoUF7U+B980cvo/PvEmKNcNQ0tM2e3ntaARX6IUa2I9hDSBEYwCGhTupfe5FznB3H5Q6gIFUAbWUuVKfGI8u2hIdAUNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T1rLepw4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U6ZkWTi7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECuPtF018172;
	Fri, 14 Nov 2025 15:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vxCLJLTebtdzPqRNdD81h4+HXxC7MM7fjEo6NkV8UfE=; b=
	T1rLepw4lc+oguAfl+PfEWMqofkbWHh+zkJrUlnFLL8GBD3GCXnDE06t+PwLdrNU
	4po9/EftbuK/idvsjIVikOismz/DHCKa0x2u/ypE4rAzj6lFIdrGo6REDeZMM91J
	to+REuf933coDFaErzmbAnyTz/8S5ir6GSG8dWoHSIrJmd35PHv4OUFVNyISqkHA
	2oRUH0SX97021pbHN6/FG/Rhh7inL2eJhmkXQtF4Azd+4WyTJNCwjJmyv/EsoxQR
	nLJ7vvvKUiJ3TSVymVVq8ziDn/rAvp7dhibGEtFmgt1qF/+MIUnqqorVRny5xSRO
	0Pu0FkK/11oenvfKJxXlKw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8sserw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 15:57:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEFtI6a010877;
	Fri, 14 Nov 2025 15:57:19 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaqfjwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 15:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhEi/PbPafqKfJ1n7OWDRfZpiOCfb6B2JzDV7ON5rC2S2NSqcgGoURmpLsGQxW5Os5fgBeFokxoL/KEBJK+5ypYBLRcvf0i5uxtY6Qtkoc8wQeBBX7rDV/SIwM8Ziu43XycjtluAg6eEzr9iS9vyxCNN7a24mqHhF7M2KSbgAR3oZaZ+qq4e2Fedlb/tRo36MzbA4Hi0ScT0frrJsYxXas6wohwCiosZwaZpToOUMbIL6QWdi/DTiYzVPOc/cm794o9Cj+uN8wrwjcm37iMcM8H3lR0CaJkghOuJVY2o03boAXO5Ux6dJ5ALKAwjzZ98AdgoTZR9gt+L1zTzLMguRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxCLJLTebtdzPqRNdD81h4+HXxC7MM7fjEo6NkV8UfE=;
 b=sYb/ypN/UAMqUlpQwm0VTZBVcDt/jqDDMFBk2oS87Plzw05o7U/jlP7ynzcbyYmAwxZ2PO0TA5JsTl2i06HGkbW+x2XuPBGBmVtWcVnAPUBOQvzvoKU1Km5/XSueDBm2gOUZrPMDo+llpTsEe5wRImgAOw7Fp9eqxbaPmd1lg0LGtS6ABNKkxD6VxVTA1ltx3DmEtuPaJXC1gxkMVOe7nA/9fFH899US+OYIdLcJS4uLGs8z+rKOUP/RoevU7pXmVHEpSFQwR3XlWI542liDFfvAmVrpeC3ePwsNlRxfdxohuPbkz3C9rdd5wHLAzTwN5qeHEvQbBBcY7BCkHwdJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxCLJLTebtdzPqRNdD81h4+HXxC7MM7fjEo6NkV8UfE=;
 b=U6ZkWTi722HwrxJxZeTiPWwtpkV+dsP0DAVY9n8/utB6vhYCMDxn6+aVWYXvsp5IcQAtun8pJfs0HnIOJr2Va/0eSL1jXhVYvlrsDa+TBuS8nl6AnD1FXe0QhbpetiSA+NZJcw6tsbSdGhCmThtk7csmpADx3DxlQ9loCr9H9bU=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by CH3PR10MB6836.namprd10.prod.outlook.com (2603:10b6:610:14f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 15:57:15 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%2]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 15:57:15 +0000
Message-ID: <3f95f01b-9cc4-499b-a18d-5c4975f0b0e5@oracle.com>
Date: Fri, 14 Nov 2025 15:57:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 0/3] pahole: Replace or add functions with true
 signatures in btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Faust <david.faust@oracle.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
References: <20251111170424.286892-1-yonghong.song@linux.dev>
 <a9ebf236-78c8-439a-b427-cb817efe23ae@oracle.com>
 <CAADnVQKr+9gneG4ZZHBKWjTo-AiqPCf_Mxv_sCi9acqEKkKShw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQKr+9gneG4ZZHBKWjTo-AiqPCf_Mxv_sCi9acqEKkKShw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::9) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|CH3PR10MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e61d823-c28f-4686-b2a2-08de23967b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGwrNjRETmpJTldIb1FBaThzUy82am5QaHBqM0NEMGVTa242NjhSaUFKZHo0?=
 =?utf-8?B?Yk5LeU15K3c3VDNQbXhpVDIrWWNZNWxVZ1lORU1sYk1PNi9PNXhET3c2djRW?=
 =?utf-8?B?Q3U0RHlqSnI5TjZ6VnVEVG5kQW9DRFBtSHVZd24ybEltVDhRcTBiZzZ3Zi9E?=
 =?utf-8?B?SEoyQTNUOXJrNGdWbWh0Z1E0c1QydEEreGpHanBEZDIzTGlEOVdXY1JYUjNJ?=
 =?utf-8?B?VnlQNFRlbGV5Sm5NYVhnVjZxY21iQ2RXMjZQd0Jtc1BXaFdiS1M0dzFQVFE4?=
 =?utf-8?B?SG5BUmp0MFZKeDhWbE1mSEIvYWQ1RDhrZ2FIZHdobWR3WmErN0txQUhTK1B1?=
 =?utf-8?B?MUZZcWIvTDNkd0F2YzZJdWR0UW5FR3V2UGVXYzdHSFVJYUl5cmd5YnN6cHJp?=
 =?utf-8?B?UFVVZ2lrT01RMTBzcW9UL2FzQjkrc29HRmlrWHJmRlRIalRYc2cyQXJ4cy94?=
 =?utf-8?B?ZGt6NGQ1cy9nQXZhL2FyY1hiSUo0a2xnb2lsRy9Pc1h0RnR0QzFqdTJ2N0Fu?=
 =?utf-8?B?TzgzenB6dXRUVlFMdEw0UWNqcVhUUjRxNjN1eUcwUGdFeTBMZXYwQ2V0Snp0?=
 =?utf-8?B?UE9BWEZVdElQYzlERVJvUmNIdUhHUEpaemVIWFR4UTNxK01yaG12VWJ4bSs3?=
 =?utf-8?B?WTNZNktXSFF4VkxnQ3dwVXUvY3hCM0U2QnhLT1gyQzNuclRpWUlLWU95OFB1?=
 =?utf-8?B?N0s4ZXVTZkFlRklKTXl1ZUl1TUxIekJESFBISVRZKzJ6NlhCd3FleC9ZdTBI?=
 =?utf-8?B?R1pnY0ZDclZ2OG9hK0pSVk1MT2srVHBBL3l0M1JvcUpIdS9RemJqU01Ib0RE?=
 =?utf-8?B?dVhnR2FCRkx1MVJwN0RZcDhIbWVxUDA2NExzVkFCQlVUN2xzeDBrdVFJRlpL?=
 =?utf-8?B?Y2duYlFmdkRRSnlTTWs2SG5ZUXpGK1U3QTFtTzZvcTZ2TW1FNjJNTm4xc0hX?=
 =?utf-8?B?UktTcEw3N0pucGNuZndZUGlGMXRNbjd3V1QzODBkckFmRWFvTytjcHRpQ2pI?=
 =?utf-8?B?dzRwcUVBN1g2RmdXQkgydEtOb1VKNS80OUZPbzg3dVZtTk1mYmR2MWRROEpz?=
 =?utf-8?B?Q3hDQkZHQU5FZThONEZBdG1mVGRGdnVkWlloY1gwbVZNVXBaaW13Lzh1U0Vs?=
 =?utf-8?B?eWJFbGJSNCtOWlhySWNzdHhlQVZ1NFNxTHd6eUZEK0oxWUkwVVBRZE5BbUc5?=
 =?utf-8?B?UnZlVWVJcERvYXQ2SVp2ZjIyZnRkblp5NG4xYzRnc09SdXFtajBnZ0VESW5v?=
 =?utf-8?B?RjZVcktQSm85b3NKdm9VeDFSZE9zZldXbDNVL3dKd3hJc2hBdHZFUFpVb1RQ?=
 =?utf-8?B?MXZOZXBqaUVUbmkyNzN4MnowYWNEdmhsSzRpZTVxOUVTcHhnSEg0a0ZCZXVz?=
 =?utf-8?B?MjNUMkJhOUYrWkVxbmxVQlh5N243NHgya2tlLzlQM3VGN3E3aXJsRzE4QU9R?=
 =?utf-8?B?Y2x1bG92RTFLRG5xaWVQL0pOTmNpcmhKZEthdmkwamdCYVhOMGg2VGZ4NGs4?=
 =?utf-8?B?WkRtMXdxMk0vRkJqcnRkYlhWS0VET2NiNnJKbERSRVFjYmdlUVNOMVh0Wnlm?=
 =?utf-8?B?WW9DZE1mOVIrcmY4THdmYjZjMzY0bmVieFZsYWpzWkZpTnE0OHZVTVN0TFdq?=
 =?utf-8?B?M0svYnFPMklZc3JFNXY2N1Q3b1dQRlpvS2dteURNRTNPUEo0QjRmc2tPV0I0?=
 =?utf-8?B?ZTdDZmg1b0NPNXljTHBETlVnWmpGeVhNMFQxejYyYmJDVGxzWStQcmhIc1ZR?=
 =?utf-8?B?WmV0Y3Z3Z1ljMklBWm5UMm4xTzBkWnVjMzlrajlFSTExNzExT3QwNnJ2WTIy?=
 =?utf-8?B?OEZTZEptL0hFZmVab1pNT3BVQlo4WnF4KzZ6enMzSm1JR0R5MmNqVUR1alhQ?=
 =?utf-8?B?eUxBU3RvREVIeGdlVUN0TDFmM3RPbTc0U0xCOU03anNFdCswa3RCT0w2ODdS?=
 =?utf-8?Q?V+jDKVp2cuiq+rn/I+xpBK4tzvAbQJcS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEdFbHdIZ3FqdFlXUEhaek9UdEVCRW9YS2ZYTUhYTXBiVmxFZE03ejN6SXg0?=
 =?utf-8?B?MndQMk1wejlPVzdHSGJTSnNXQ0hzeENJR2ZSU3gzT0JJdjlUQUVYQ2wvN0t0?=
 =?utf-8?B?YXFlUEhPdW5sVVRYRjhLR1cydmkwQUI2K2lHRU1VVkpLRkpNdDZTZEhPRWJN?=
 =?utf-8?B?OU5paTZ1WWtCTXQyUWF4MEw5dUZVTXhCay9SOXMvc3k1enViNlB0UTFyQVBa?=
 =?utf-8?B?M0paN0x5NnBBMU94dTRGVnd6cXdlRjVvYkVKVjFOSk1aNEd5eXBOdG5zVjJT?=
 =?utf-8?B?SmMzelliQWYzVlEwcWUrQXZRTTZqRkhjMzJnK2lwNDZPOUE3eGlwZFNZTXpw?=
 =?utf-8?B?VDN2aWhYN0hkMklyZ21wc2UvcjFCVGNHQWtkVWpvNkszRkpraDluYzRHbS9S?=
 =?utf-8?B?aTJDcXFTUFhraENVUkJzSktubEUrbHhPdUd0N3c3S3NmT0dSTDNTMU41aDQ3?=
 =?utf-8?B?ekw0M2U5Lyswc29oQ2RxNVhzNXlKNlh2MDA2eWt3bnhRRk9mWnZyYmliRmtN?=
 =?utf-8?B?MGs5bkZkKzZDbUpCSStsNUxiT3B5dkxvTFNTRmxQSisrLzV0d3V4STVJMks2?=
 =?utf-8?B?WjQ5b2lrT1drM0g3YlZLa2hrZ0pnbFg3ems2eG1NekJuVGJTRmJWWGllTXVx?=
 =?utf-8?B?MXdITFZSODhVejFWVVEyOGFGRnpiN0V3NVZyNk1NakxqV0JQWTV3NDE3STlk?=
 =?utf-8?B?MS9nMDNoZXcyMms2M3dTRHdvSWsxZUxwTzgwdmMwMnNTeFRMNlZtSXNMNmZv?=
 =?utf-8?B?Y3BWWU1HRHREdFJzMmMvTlZOSVJsN0YweHdnNmtOdXR4akRVY21GZ29YYXRC?=
 =?utf-8?B?N1pBK0ZyMW56NStpV0hSTTI5MmczSGcrQjVUaGZlZWhXdW5pODRvbDhCem9H?=
 =?utf-8?B?ai9kVDEyd0x3Tmc2QUtacW9EckZNcXFqMkZ3SHpGcUNpZE9jVlhGR2I2N1d2?=
 =?utf-8?B?WDM1RzJNYWEzNFJSVWZ1MmZkVnZLV0lxV1dBV2ZFd3FPWlhERU01MzBaNEpI?=
 =?utf-8?B?anV1a2E0ckVUd1FKRlE5L0d4bEpaZkszY0ZiaE1lR0lqa1g4cHA1Rm1UZGFs?=
 =?utf-8?B?ZU5xd2lyTkNRc09PQUVCclZ4WmdPZUpIMjVrbWhSWWVQZ2hyTDJ6aFFUZFps?=
 =?utf-8?B?WXZuYXlyUldFMGl4ZmV2LzMvaEZETUR6RkI5U3BQWjZJK3E5L2U3TUlEeWY2?=
 =?utf-8?B?eENuT0YyanFiNUhMRXJRSEsrcVVkdFhSbUFjQWJYRUFieE93YnFtdHd6b2t6?=
 =?utf-8?B?MFArUXFadWVEbkF3TFFuYVMyK3pzYUJCYTRiZmZRUDNzenJoSWNLVUhWcTUx?=
 =?utf-8?B?U1lPTmpwWjMvK3dWVkdhbGxuZEhZa2QrY3JERUtOeEpuRS9TcmIrTCsvTVVY?=
 =?utf-8?B?bUJ4aXJ1bGhmVnRTU1BxRjEzUlpRYVdGL1hqclJtU3FCb3VvckZFOU8vdGta?=
 =?utf-8?B?VDV0bldhM243N3dUaEQ0d3N4THcxeGRvcytoVlZCZXVxaVVrMm9yUEZyUVVy?=
 =?utf-8?B?YjZoYzI2a041OW9PUEpNb1JvUG1BVVA3RmFPZ1U0YTN5TkxBditqRlJNcDlV?=
 =?utf-8?B?ckFnSGF0eUtKM1dCb3dNeWxmSEJLVXhXUFU1S0w2aUplRm9meVV6S0hpcHdv?=
 =?utf-8?B?cXp2ZTUvZWNSRmV2SHhzWXFkc3ZJMStzbUsxMGVFV3FpejMxTGlyNjRVMDhX?=
 =?utf-8?B?bndrcGtMSFdOZFZtT0F5eGpwUnF6MXlNejg4UVpyZnphcTE4SHVqUlcyM3Zk?=
 =?utf-8?B?aEdYVzg4VEZET0t1Rm9sVzdXZDNmWHIyRCtmckxDclVIYWs0c3lNUUo5S0pt?=
 =?utf-8?B?aDFzQ3dOaTZaODgvZmhRT0xEOE8rZVRyT05KZUR4QXpZaXk1MUpQZDNtQUN6?=
 =?utf-8?B?UEFsVmRYaVhEM1VkS0hqYUNMZXJOZzVTRXlNZXZUVFZ4MmtzaWF4SGJDdURS?=
 =?utf-8?B?Q2gvK2x2V1cvVzlCVlhKekdBTEZ2YnZaRkpyRXdRdFVVMklYQTJ5WXIxbWg4?=
 =?utf-8?B?OXZsVzh3L1EwbFZTN0NLZkdqbFUwTzgxbFNGamF6WnZaSTVrcENJNkQyMlln?=
 =?utf-8?B?aW9VcGd4aFA1TTZPR3pHYkV2R2t2Q1VaS3JWQVErZVY2bWFWa3YwUnhCa0NP?=
 =?utf-8?B?NGNoNzBmM0sweXJwdzkwTnpIMHhERUtqdEVpZisvbTRmYzltVnJVSDBqRE93?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nNt4z5to3z2GTCmH6bEHUbj8Hmnc0KdgoVwUZO732UyZMTBdynBWz0otSypl+FNNWisTc3t2LeR8BHX6VJgzxkScW4vHtqzFkGQBbbfg7tzrzVBCO8IvrwMULhthcuTpECJ7naX4MbSyyEoheiES7/nSqOwrPiEYAONd0/EpyVq2iRVW0agC2ojsfwMsN9MZmYXHtxsUaY0FLMEEvlfrWOLlaledlkBQqN4tK9QuKCZSxd0l1Grg3yMSzrTrxhdoP3dpnj42l0TfSwtcyT5rRZP4yJ8rr/3pCpRjDpxPQ+dYwaDwmFU5HSMIv4DMO8NUSev1GKxnJQyfU6D6XE8yetiOAxJzbQx83d+m9x3G/8Q1R6lrxh7wb3t+hkt6wBQOwWQPvXU3zkgEohjw1zWt6EqtYQjPXYDIQF+d4HphB8U6lsCKPF5WMKElmbSoN5iODYp/3pSC/lCxi01YtiC82WILJcL0X/j31rygZWPdy2AMfUHRdlNC1SVfdhvL7571GqOyoRcySqsT+MWp7c/D+2nSGW67335I2xTGmu20DLfZQrEQbWGszomdQT82DY3dUKwaL3b0CjBKxWk0K61wkSjKzqyMHTwM8bjcrU6Pzes=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e61d823-c28f-4686-b2a2-08de23967b08
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 15:57:15.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCzzxffWDgXdPqgeMatfy3LD0F7OJrANvAShaOb7Mfyr8xfy8bNT+kyHBSnMooxX+DklyatAfz6ziK89DhWwVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511140128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfXznWBW6H/HTlS
 URRj0JHQFiL7BmG0cZpWg2q0EXvI/66CJWGQGePvFbtBLUnjxVfEHJeYe6yotmPs4MVT/rScj8C
 4hMNTRkpbYJS3IQNS2adOQRhnVimrzkW1abQ9TI5xyl10DV0r2aLZPK6cJ33hp+3eaxDQQGEkJ6
 CZc+Tw1Ymxhri1bn11CFG3/GOBgnKhwPH+1jvnCwVnQHQYtVPASFLw8mj2sKXYoS9htzesl54dR
 zwmeqpKE0cczA4jJEnv2reQMLtS/O/3ZSokhj8t7nQB2+XPSr6Mq6KOoQLRSaqdUWeUF/ICzFFs
 eV0bg6a7puGvA9U1gxSZP7fGnGFD2aMIDk1A/7sD1Lc4Ir6sjv7V+73o1890+t/IA/jYxSOeUcA
 +JPQc9zQ/OcJpYlIHDS/JM28EnsxRdCZwjAXdCe37+wB/FIcn+E=
X-Authority-Analysis: v=2.4 cv=WuYm8Nfv c=1 sm=1 tr=0 ts=69175160 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=qjZvip1IlP7GuCz0IFMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12099
X-Proofpoint-GUID: wRkXZUUZgwob6lMgNnqc0KsxWEGBkZ7F
X-Proofpoint-ORIG-GUID: wRkXZUUZgwob6lMgNnqc0KsxWEGBkZ7F

On 13/11/2025 17:36, Alexei Starovoitov wrote:
> On Thu, Nov 13, 2025 at 8:45 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 11/11/2025 17:04, Yonghong Song wrote:
>>> Current vmlinux BTF encoding is based on the source level signatures.
>>> But the compiler may do some optimization and changed the signature.
>>> If the user tried with source level signature, their initial implementation
>>> may have wrong results and then the user need to check what is the
>>> problem and work around it, e.g. through kprobe since kprobe does not
>>> need vmlinux BTF.
>>>
>>> The following is a concrete example for [1].
>>> The original source signature:
>>>   typedef struct {
>>>         union {
>>>                 void            *kernel;
>>>                 void __user     *user;
>>>         };
>>>         bool            is_kernel : 1;
>>>   } sockptr_t;
>>>   typedef sockptr_t bpfptr_t;
>>>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
>>> After compiler optimization, the signature becomes:
>>>   static int map_create(union bpf_attr *attr, bool uattr__coerce1) { ... }
>>>
>>> In the above, uattr__coerce1 corresponds to 'is_kernel' field in sockptr_t.
>>> Here, the suffix '__coerce1' refers to the second 64bit value in
>>> sockptr_t. The first 64bit value will be '__coerce0' if that value
>>> is used instead.
>>>
>>> To do proper tracing, it would be good for the users to know the
>>> changed signature. With the actual signature, both kprobe and fentry
>>> should work as usual. This can avoid user surprise and improve
>>> developer productivity.
>>>
>>> The llvm compiler patch [1] collects true signature and encoded those
>>> functions in dwarf. pahole will process these functions and
>>> replace old signtures with true signatures. Additionally,
>>> new functions (e.g., foo.llvm.<hash>) can be encoded in
>>> vmlinux BTF as well.
>>>
>>> Patches 1/2 are refactor patches. Patch 3 has the detailed explanation
>>> in commit message and implements the logic to encode replaced or new
>>> signatures to vmlinux BTF. Please see Patch 3 for details.
>>>
>>
>>
>> Thanks for sending the series Yonghong! I think the thing we need to
>> discuss at a high level is this; what is the proposed relationship
>> between source code and BTF function encoding? The approach we have
>> taken thus far is to use source level as the basis for encoding, and as
>> part of that we attempt to identify cases where the source-level
>> expectations are violated by the compiled (optimized) code. We currently
>> do not encode those cases as in the case of optimized-out parameters,
>> source-level expectations of parameter position could lead to bad
>> behaviour. There are probably cases we miss in this, but that is the
>> intent at least.
>>
>> There are however cases where .isra-suffixed functions retain the
>> expected parameter representations; in such cases we encode with the
>> prefix name ("foo" not "foo.isra.0") as DWARF does.
>>
>> So in moving away from that, I think we need to make a clear decision
>> and have handling in place. My practical worry is that users trying to
>> write BPF progs cannot easily predict if a parameter is optimized out
>> and so on, so it's hard to write stable BPF programs for such
>> signatures. Less of a problem if using a high-level tracer I suppose.
>>
>> The approach I had been thinking about was to utilize BTF location
>> information for such cases, but the RFC [1] didn't get around to
>> implementing the support. So the idea would be have location info with
>> parameter types and locations, but because we don't encode a function
>> fentry can't be used (but kprobes still could as for inline sites). So
>> under that scheme the foo.llvm.hash functions could still be called
>> "foo" since we have address information for the sites we can match foo
>> to foo.llvm.hash.
>>
>> Anyway I'd appreciate other perspectives here. We have implicitly tied
>> BTF function encoding thus for to source-level representation for
>> reasons of fentry safety, but we could potentially move away from that.
>> Doing so though would I think at a minimum require machinery for fentry
>> safety to preserved, but we could find other ways to flag this in the
>> BTF function representation potentially. Thanks!
> 
> Looks like we have a big disconnect here.
> To me BTF was never about the source, but about vmlinux final binary.
> Compile flags, configs change both types and functions significantly.
> For types it's easy to see in the vmlinux BTF how they got transformed
> from the original types in the source. Some source types disappear
> altogether. Similar situation with functions. They mutate.
> Partial inling, function renames are all part of the same category.
> BTF has to describe the final result, so that tracers/users can
> actually debug/introspect the kernel they have and not an abstract
> kernel source. pahole was conservative and removed functions that
> don't match BTF. loc* set is going to bring back these functions
> into BTF with their arguments. True signature support is complementary
> and mandatory part to loc* set. We need both. Compiler has to
> store the true signature in dwarf and pahole has to pass it to BTF
> along with location of arguments and actual name of function symbol table.
>

I don't object to having a representation tied to the final binary;
however I will say there is huge value in _knowing_ things changed from
source to final representation. Now if we encode function names with '.'
suffixes that is one way of knowing, and it may be enough, but I think
we should think about mechanisms to ease overall developer experience in
that new world.

When I write a BPF program for fentry(), it seems to me to be deeply
inconsistent that I can make it work across multiple kernel versions
from a data structure perspective via CO-RE while also having to worry
about the risk of compiler optimizations transforming or eliminating
function parameters. It is a step forward in some ways that we can trace
such functions at all, but I still think we will need a better story
there. For example it is often the case that a BPF program only uses one
parameter from a function signature; if we don't access transformed or
eliminated parameters, can the verifier accept the fentry() even if the
signature doesn't exactly match? We don't need to add these things
today, but I think it would be good to discuss some of the consequences
and how we would possibly handle them.


> Re: whether to strip .llvm or not, I think it's better to keep BTF
> matching symbol table which is kallsyms. If it has .llvm suffix in kallsyms
> it should have the same name in BTF. Tracing tools can attach
> with "func_name.*" pattern. libbpf already supports it.
> And thanks to BTF the fentry prog should match what is true
> kernel function signature. What was the source signature is secondary.
> The users cannot write their progs based on source, since such
> source code doesn't exist in the binary, so nothing to trace.
> While true signature with actual parameters is traceable.

Yeah I think if we are passing through the changed function signatures
we definitely need a way to know such changes happened; the "." suffix
will tell us that.

Alan

