Return-Path: <bpf+bounces-64108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B9DB0E53D
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 23:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58DA1C277B1
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 21:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49592868B0;
	Tue, 22 Jul 2025 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qdQU+o2m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JtJKQQeE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3BE285CBF;
	Tue, 22 Jul 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218349; cv=fail; b=VzbC+u1rqKbbnNbVoc2MgQN0LrJGDzsMdI3KVKIZR12sLGpmlX21uzRTnDJVhpQzkGssLe5YUPTBFhM8ibjoIMi3+gmNa2AOccUELi3msxtSTox8+ej8hHerXmvm4HzDYYCue/lVb31bmLpHuO3BiyUXxfUnaRDVxeAIO2OvYpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218349; c=relaxed/simple;
	bh=+KuYjpgpq33S6xzBgky8h0m43Vqtk5Id3B4lSB6Bgcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XeC9IrgN/djqjEKF81hID+Hj8UwBfA6IsU/iyBKIVAddS/LbidemNvQifMiWjm8tlyImShn7Ygn5CPME9PVwJhEf5oWK9QO3UyYqEHhPP5H3CE0mzSCZgAH/3FZPYJaEwTW3jJDJGBC4DokPQvZsXznRY8ToHoTCtf59G3/D3XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qdQU+o2m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JtJKQQeE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MJtmXK030347;
	Tue, 22 Jul 2025 21:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oSuQhPUnqmz9SDa9CD1BxfjJiO7ALLapk9g9vyAZz+w=; b=
	qdQU+o2msX0Gp8/7Py/Cd1W1Sn25/MAILIH/c02b/e+xHf2/+G4fOjx4hk6Y7zsX
	dPZYJwePbQeFEGF1ybAkte3pNOgeORSknQqlZywHXZxy7+lYZAusY9lqbZfS6eGm
	2QTrbtsbBiFfxCFAeAxEYncbEr8j9dUbEQYz2KI6F8vdxBLmiZSZ3oMFrJe9TeGs
	x2WQ1Fmd7+MmPODPV4soPaIrkZBMtXpbIqnROord7KkWa1/KiKs+HLRxzg6GBo09
	vViSNt6blfh3gRs+ZNBz8DH/7V6ZPzq7IRaXPG8Ft+tp1sgxNxBaROjJqCWwNSw+
	/Y7zZbOQUfLksW+8eGfA6w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2e741-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 21:05:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MKiZm3011482;
	Tue, 22 Jul 2025 21:04:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t9syph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 21:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7SnEiAQIu0MXA++IS5tCT8eiR51Aijv6Kxd3p4U/Un/KB4z6WLZ6xiWnuKsixbvcMw8afhH45k3WXSGz8hKC+5VpQbVpwcmJauXKOsaaEE81sdV7sY5mPMSDiIJJgcRGwcQx+1OFdyCFVeC4wTm5sLNqQ9cS9/6ejfSgYGqfSZbNW2EZAqeHdeT5IDZs5SHqTc2jib9TybDSn/Dvpja+yl6EJirPoq4VYQxf/aXeVRv6qjPakkDMxsRg7BR+nPkGmU0TDRt2eo7EwxP/PlRbBmEusoDMdxuFcA+cjeqidGOMCNZP8lMaShdWe/jBJG6FB7wqxBTrzvCHbjN7uZXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSuQhPUnqmz9SDa9CD1BxfjJiO7ALLapk9g9vyAZz+w=;
 b=g8J+fHM6Xo+VhSg5e7lllUzsMHpiqW5L1689CyjnEw70udf+LJl/ViQeX//e+Hlhjoic3gPowiyeR/hSSeYeXy6jABlEQbRToIaLCSe8TnGmH3W2j3IQtcuc7ocHDms4qVKYD7Gf3xCsQ0kUdunNoGJTyJmLlzQeJ2evWOCyoviwuIkyXqGvwX06zkUDyFnZeBJhle+B6DWJThKRl80bbpGPVjIel8dRI+3S1NevRV/7BbZYlT1R6XMBLnlwNI3nGHC5mW5WpiHCwdjowhValTCcwKMj+RoS6GiY1GuiMv13p75JmbBjHNQch0c+hLpragu4KIOZfZkJE/oiKrMmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSuQhPUnqmz9SDa9CD1BxfjJiO7ALLapk9g9vyAZz+w=;
 b=JtJKQQeE7uSRGlpxyxBZJP/6i+EaNBCSxlE7D2LNhypAMXpFayBfw3+BWNgbu+3WhKQ4+mU/T6+OMcMBBufA68AOwJAjnGK6Fq6cb9GDLdaTj6cIkbgNfG68b68ILZDhbaEDIkTWZLMbefJN/4stn80aOMUh8r+nnCmAHArRd5Q=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by PH7PR10MB7086.namprd10.prod.outlook.com (2603:10b6:510:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 21:04:46 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 21:04:46 +0000
Message-ID: <ce687d36-8f71-4cca-8d4c-5deb0ec908ad@oracle.com>
Date: Tue, 22 Jul 2025 14:04:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New codectl(2) system call for sframe registration
To: Steven Rostedt <rostedt@goodmis.org>, "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Jens Remus
 <jremus@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>, Brian Robbins <brianrob@microsoft.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
 <20250721145343.5d9b0f80@gandalf.local.home>
 <e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
 <20250721171559.53ea892f@gandalf.local.home>
 <1c00790c-66c4-4bce-bd5f-7c67a3a121be@efficios.com>
 <20250722122538.6ce25ca2@batman.local.home> <87jz40hx5c.fsf@gnu.org>
 <20250722151759.616bd551@batman.local.home>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <20250722151759.616bd551@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0140.namprd04.prod.outlook.com
 (2603:10b6:303:84::25) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|PH7PR10MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a12cbc7-d2d7-4e2c-2ae1-08ddc9636376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTlETlVTQWxGV3BuR0pRSTBhNm1qcmFwT3hUYlR3ME9NdlI2Tk51Z2dHWmlm?=
 =?utf-8?B?M01GL0VsNkZwWW8wME92ZDN1RjVqM0llbWNQL3JMZFlvdHhvVFFid01KcjNE?=
 =?utf-8?B?aVhQT3dFZlozM0R2Rm1zZGlRMkZ4d2hQZ09mZDZtOERXeWFScUwvcEcvVG9Z?=
 =?utf-8?B?cWFpZk9Wd2N6K05wWDhsOU5RcjluYU5WL09kTytYODU1YXEvUU5nR1pISlZH?=
 =?utf-8?B?OWwwL2Z1RGhnVTgrbTMxYnFOZ3NoK05ESGlyd1JqREJoK05VV0VBODFYaUlG?=
 =?utf-8?B?eCtsRGJvaEttQ01tdW5YY0ZwV1BpNllZN1A4Y0ZwN3JxVnJqell0YnpWTGJy?=
 =?utf-8?B?Y1FRcnp1V05oZ2FHTXh0T1hmTmxTUE4wbmhycEV0WE5SUlg1eU4reUZVK0ZS?=
 =?utf-8?B?cUVDNXk2a0lDUEVWT2JYV20xWGJvNjNWcWFvUmxtb1F1VThNVURURnBVa3Fl?=
 =?utf-8?B?cjhkUS9QN3dteDhoYUpRdjBmcmUyYlRSSm95SGNlUHNTblBiK0ZWNXRMcjc4?=
 =?utf-8?B?dmJ2cGk3a2M3YmE4SmxmOTNVaHNOMUdwSVpMQm1xS0k3K21ob3VmV2xxaVBU?=
 =?utf-8?B?SnBPNi9pc1E3a0NpVTRPckwxa2Vvc0ZJTU0wL2lQVzJUdStScnc5V1VBL0dP?=
 =?utf-8?B?ZllGeDlqbjdoRDFIanh1MHJiYW5ZdytUWTRLQjFQNzM4b2pTckFmdHNKcXdP?=
 =?utf-8?B?MjVtS2ZGQ3dhdFdrQnA3MnJ1UkVUV0pYNUxNQ0RBM3lUZFN3M0lrZ0huUkd1?=
 =?utf-8?B?WHlJNC84MnFxSnN0WTQ0TzJQdHlHY2kvbnhiMC9Hc1NNc2E3amFoeE5lRk1B?=
 =?utf-8?B?ak9qdUUxYjgvMWNwbHNBVW5iOTBlVGdaaW1DR1duZFBiQkZtVmg4SjZaSnFr?=
 =?utf-8?B?S215T0ZCTjdXcFVpQmdSVmRsMjMyaVBxcGNrN0ExWVYvTDZ1ZWNkbEpyeGhi?=
 =?utf-8?B?SVI5T0kwK2puNWVnQVpXVHdDLzNEQlpEengxTVBiNDM2V3MvSFNnTnpEcTFn?=
 =?utf-8?B?dzN2QWJxclJzVThRN250TFNYNHlzNkVqZS9UNm4wbWhNL1lDUGQwUHl1eWZS?=
 =?utf-8?B?VXZjY2ZsMFJxTVFXSC9VSEZCcEdhTVhWU0tyTERMQVQ0MVhSN3ZwdUVFcXox?=
 =?utf-8?B?dXhBQlk0UkxpSHZCbnVFeHhWaTkxWUQ2bktXcXJEajJOeTlZRFI1eXhDYnI5?=
 =?utf-8?B?dzJ6MXU5bXE0SkpRdndUbzFSR0lpK1N2cVlSOGl4RHBONHplb0thbURReXlT?=
 =?utf-8?B?Zm1yWWxiZVBFdGtSNUJZWlJMSFdUeEtqUkp6amk2emNKZkxpWmJrZ1pJbjVt?=
 =?utf-8?B?bEthQjRpd1RPZENUR3RFeldWTXZFZGh3dzNibmljbncxZ0pFSm82QVZjSVN5?=
 =?utf-8?B?UmY3S1RDbm52WURydThnUzJiS0dnTzBuQTNQRk9YMWxBaHdmNmNMZGV5YTN4?=
 =?utf-8?B?VG9USWNvWmcwY0hERjI5ck9JWTF5TWthaHY2QWVIOHZjY3RXQ2ZEUkdnOCtu?=
 =?utf-8?B?ZFR4OXN2ZlhMN0ZaZVhzY2M2dm1YbldkaVZCYXNJTktSUklxMHN0ZVhzMExL?=
 =?utf-8?B?NzJhYSs3YVppQjU2MXQ3dTUzdnFuanBVT0pHS1VGaUI5NGJaWTl2L09iRWF0?=
 =?utf-8?B?dlVmb1JybVljTDJLZnVCU3VHT2xCUC8wY2w5U29yNG5tL3dRTE5makhuc3Fx?=
 =?utf-8?B?MFlFa3VPaXpyU3dVS0NteFlXVTIrcVVMOTJGVm9oK1JaSHhySGhiRWExVWR1?=
 =?utf-8?B?STN1UVNOODB1RlZYY0Q3Z25iRW9hK0pZaG5veW5sV0E1SEQxbnhib2E0Mm5a?=
 =?utf-8?B?a2NNK3FJZC94amhtUFJVamsraWlYZ3E4SjI2UU1OYkxYbmp3UHdhNFdiRmdU?=
 =?utf-8?B?WjJkSmRHczY4SFk3WUdCdWNJZTltYkIxQWNKWkdoc1lYWU5aVVI4OWYyNldM?=
 =?utf-8?Q?8UKDvpOvQvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3pWS256UkxXaFpuQ2lPWFluc04rNjFlSi91ZzJDc1N1YWlseWFTamZsSWhD?=
 =?utf-8?B?RVJuSkZzTER5VDNrOVo4eG4yUVZqRVJsUkJJU2xvaEF4UUxlUWlwS25DQzlk?=
 =?utf-8?B?T29LRWwrMDBUMmlRa0RESUp2SFJ1ajR3ZTZ6WmVUMjRFcGJPNlpYU2NHUEY0?=
 =?utf-8?B?aVoxZGZnWHRtdE9qTzFtUXNkSzBjOHlkR2hNaVRMK0E1ZXFDbHZoUkNDT2Jv?=
 =?utf-8?B?ejFvKzM5Yzk4bUNCb1A4bkg0Q3JMSkcrVFh6amZvUVlqZzdmM01QZEhRdE4x?=
 =?utf-8?B?ZFhTQlM4RlhMV0cyeVBheUxGTjVjc0IxaXFydGtrMk92R0YzdTh0bi9vS2VH?=
 =?utf-8?B?OUg0Y0tqRVowVjJQS1dzZnR6c3dlWmtOQWhqdzFlbXpKQU1PVkpDZEVqWWR3?=
 =?utf-8?B?MEN6ZE1qc08rMHJlT0Q5YnZlTHJnN1FMeFlSUEZBNSsvSHpjNktsTnNDWWh4?=
 =?utf-8?B?cm5tZVQyL3pXeE1ESFdpUUJzYVFTYU5ENmpNTlIxQnJScCs1ZnQ0WThsQy9U?=
 =?utf-8?B?Unc5enV5ancwbHdhalNieHJwL1NnN0xSdk5DTitkRjVyejl2Qk8zaCtaWEJY?=
 =?utf-8?B?NHFUTy8vOEc2cG9tdkZPc21HaDVGN2ZQRHc2UitPdXhLdjRhSFhZdHQ0Z2ZY?=
 =?utf-8?B?bUQzM0pFcEJES2lpVmlrd3dsU3ZRcnVHUEd4cGJaZ0dvSGlwWjFvYitUYmlY?=
 =?utf-8?B?S1JBcTA3MTIwNkxBWVdydmdBZkNDNGNJNS80OXhHOW4zMkowTlNycXFpMm12?=
 =?utf-8?B?R0E5TlRYNHBmTWRHckUyZjZFWXptRFdoamxIRHJSN2VlTDV2YWsydzdvV2sy?=
 =?utf-8?B?cDdmVlZBS2pGcHdmVnVwdVpxQjF4V2QrcjZubGF5YytUMG01bWM0dDRZcU4x?=
 =?utf-8?B?azBBNUJyVWJyNnk2T0tZTjRFd1c1STBGQUU5cDNYb2hPb2M0UEJFei9NMGRV?=
 =?utf-8?B?VDhKc0VqMTFXNjFTU0ZrajU5Y0lGK0pkMTMvV3N6Tjd5a1d2QWN3OVhJSmVY?=
 =?utf-8?B?Ny96cFB2Tm5OS3NYUU40NHhLSVhaMW8xakFDNUtHbWEwZWl0Nlk5UmtPZ001?=
 =?utf-8?B?TG4vbjZYdkYzeUVsYkJmYzNwZkx4d2xiekVHQlVoVWhlRXk0YU1QQWFadFJW?=
 =?utf-8?B?MUhndUFtakNZMzM1V0VxK3oya05XQWFiVDJyVElqU0V2NVRXczJKNCtyWm55?=
 =?utf-8?B?VjZtUCtmS2RMdkxUVUtDNTRlS2FOcGVSaENDQVJzNkRRTE5RNGtvdytnK2RQ?=
 =?utf-8?B?WjlzbXQzbWtMaHBoQ253SVprMXRySmRIQUFwWlF1Uk9MNUpyNEdZK3ZkTFQx?=
 =?utf-8?B?M3RlRzlVb1RoT0hMWXRCUE4xUm05V3dHQUFJQWJhcmVoWmFpU2tLMS9kNGlp?=
 =?utf-8?B?YmVad2dFdzJ0NDdxWU1nQXVMa1F3TGNyMzBzdEt1b1Q4Q0RDbW9ad2hVTlJL?=
 =?utf-8?B?K3lDQVkzWlhvdFRYcHNOVUpONnpOWlg3VEtNQUVWc3d5R2ZTVVo2RUdldkJM?=
 =?utf-8?B?M3Fubi90L0RWSDlRTVE1UlRObFl1TlMzWjNLNlUyUm1UelF3TTFRUGVLWlB2?=
 =?utf-8?B?THNGT0s5R0NXR21meGJ6TjZqdDR1R1JUdmVmLzNERmlQL3R6SG5EMlMrcVhR?=
 =?utf-8?B?dnlRMnVXbVUxL1VuYTdBZHlnbVp4NnhnWnlqcE96WGFpTXpNcW92OWxHcXFF?=
 =?utf-8?B?SzNna3RKb3hIK2VieTlvUlNheDEvYzRqTXBrTEtsb3BCcmZUUG1iMkhOZDla?=
 =?utf-8?B?aGJtMnl2d1ZTdUxFeTJFb2NiaXZyd01xU1dsa25CS2hHMkxpSmo3bWxha2Z3?=
 =?utf-8?B?ZFBrSUhyY0FISnlJRFNvZmFSeXZDaU5rUHpSOFlMZFR0SGk2VU9mKytpa3po?=
 =?utf-8?B?RGRXV0pHY0RvZUFlYXM3aHp1SitaUWplZGFYR296M2JabWF4UWMxSE95b1Rk?=
 =?utf-8?B?RjIrb3NMOXJSaTVQSDZJOHU0dmdKc1dOQkhkN0sxWmNIYlMrbERXS2FDZWt6?=
 =?utf-8?B?bnNieG5VYzR1T0hHWU1qYTM5OWR2cmllTXdVWWpNV2N1eWIxR0NyL0UyZFZP?=
 =?utf-8?B?c2oycGloenZlYWluSWVieGFuTHZJb2kyRmdwZEV5ZDFtVmxncFJKSzhGVUN3?=
 =?utf-8?B?WHhPbkdJM1lkRCtuQ0RyZytTODNwMFIrakN4MHBxYzhjRW5vK3JSZEJlMDFW?=
 =?utf-8?Q?jl/obmQrjWYo+oIPl5z+FdE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ngVHqjHQ+3wjIPZbYhgmMfTHNeGkYc6X3m6Jj+r1tCRnSv2cbuqwP4BfLHFl9v3mot6Hegs858+0vOZsMsX0Hshfvl1JeGVs9vA6mP5tx03llSuvhJwwLv7T3g3vtouSi1A2bpqk7gD9hImbN49y+0Hqyz5FOP9VV5zIW5R3QWciYQ2WxkwOZI3vMwm48aqGarTHf7eXnISLZ82Gf1+sV7Xixb2YAIpepjHxj+NXrJyDLeOmV9GBSg9IO+MTmLFcpeWMhw3WSJJkESmOnS9AznqLfwvVJvCcYRR1JLw64hbkJ5DTf10Nd/J1xHBNtMApcKRmYJbj4HXkCoYBD/3beD4cKfbZGME8K4joQ4eqiueK/nojPdbQnzFN8HwILyqoRJ2+7g/EolQO4wncvABstEPOITSvr5YjRZ5UR5HdOTI66wSKygEridb28FDzlr/Ja8NR9uaaO5gR76h1eqi7azLPM3itjgTX6LR1t7QPji/gmbZM8KHTQ65oCKcpzB4bzautr918RtihtsCYkPpNSRjGu5+ssRILtA1e9tokf++Ci5efcj4+jlYh12Uy3Rc3b57tWRVcieDnXTN/XI9pmL1r6hQAU9r7k1cruonPwJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a12cbc7-d2d7-4e2c-2ae1-08ddc9636376
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:04:46.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1npzkb7gCputl/5JCMiBaz4nX3Bk+PtU1R8+2v7zLH3fdaq/QYT9G03FX45iOnwnruCM47gnR9Zt4ABfg/nwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_03,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220182
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687ffd03 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=mDV3o1hIAAAA:8 a=kCBvFmEcsSGx-0BR9jcA:9 a=QEXdDO2ut3YA:10
 a=R4_5y_ni2xZCgTONw0JS:22
X-Proofpoint-GUID: 7tWQTrHMvq6NmMtUiXjY7m_P8g9fjt_W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE4MiBTYWx0ZWRfX3a7PmLtuOjue
 xfNK/2Dy26B6xZvkJbhuuXkCVJ4t2jyFvtBNprPcrRXD2LGfiArnMajimZoxxeKCbIOrC80oeMU
 ufnqwyc4eC3TQY5YswK5EJTq+Hfj8jl+DXbh6HdbatuXdfXBEZ4NQave2kRYbrYw+b5jkZQhfaw
 wVeFyauk8upUjUQExbRAproaxWjfa5vgd4Bt8h/rV0VXZaCJOEPpYDGRpL9lGheFIq8QN4DDzD9
 FOZ5SkvFzyoirwVZwDvMGGlcVHKv90poGzQqI2WOR8u6kHqE0e8e9JnsZX5UVma4PM/Z3nMBgiU
 Apsmvr0JcbEdThYvzLiRELdT7xZZhfthsSEoAC1qTpTRP6/RERuFHSK4dvysrYNPfpnNCczNx6K
 fD1Vd9DCiEW2klF0RlLqldqOqNn//jYhgxcgYR6JGNYkhtLdc5EUTvA3wEMzImfl1RQzPqxb
X-Proofpoint-ORIG-GUID: 7tWQTrHMvq6NmMtUiXjY7m_P8g9fjt_W

On 7/22/25 12:17 PM, Steven Rostedt wrote:
> On Tue, 22 Jul 2025 20:56:47 +0200
> "Jose E. Marchesi" <jemarch@gnu.org> wrote:
> 
>> I think glibc could "register" loaded SFrame data by just pointing the
>> kernel to the VM address where it got loaded, "you got some SFrame
>> there".  Starting from that address it is then possible to find the
>> referred code locations just by applying the offsets, without needing
>> any additional information nor ELF foobar...
>>
>> Or thats how I understand it.  Indu will undoubtly correct me if I am
>> wrong 8-)
> 
> Maybe I'm wrong, but if you know where the text is loaded (the final
> location it is in memory), it is possible to figure out the relocations
> in the sframe section.
> 

(FWIW, What Jose wrote is correct.)

Some details which may help clear up some confusion here.  The SFrame 
sections are of type SHT_GNU_SFRAME and currently have 
SEC_ALLOC|SEC_LOAD flags set.  This means that they are allocated memory 
and loaded at application start up time.  These sections appear in a 
PT_LOAD segment in the linked binaries.

Then there is a PT_GNU_SFRAME, which is a new program header type for 
SFrame.  PT_GNU_SFRAME by itself does not trigger the loading of SFrame 
sections.  But the .sframe sections being present in the PT_LOAD segment 
does.

>>
>>> In the future, if we wants to compress the sframe section, it will not
>>> even be a loadable ELF section. But the system call can tell the
>>> kernel: "there's a sframe compressed section at this offset/size in
>>> this file" for this text address range and then the kernel will do the
>>> rest.
>>
>> I think supporting compressed SFrame will probably require to do some
>> sort of relocation of the offsets in the uncompressed data, depending on
>> where the uncompressed data will get eventually loaded.
> 
> Assuming that all the text is at a given offset, would that be enough
> to fill in the blanks?
> 

Yes and No.  The offset at which the text is loaded is _one_ part of the 
information to "fill in the blanks".  The other part is what to do with 
that information (text_vma) or how to relocate the SFrame section itself 
a.k.a. the relocation entries.  To know the relocations, one will need 
to get access to the respective relocation section, and hence access to 
the ELF section headers.

> As the text would have already been linked into memory before the
> system call is made. If this is not the case, then we definitely need
> the linker to load the sframe into memory before it does the system
> call, and just give the kernel that address.
> 

