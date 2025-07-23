Return-Path: <bpf+bounces-64153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A16B0ECF4
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 10:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2381545633
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 08:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A6D2798F0;
	Wed, 23 Jul 2025 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GMTb8pCq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OAp/CCPR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21442475F7;
	Wed, 23 Jul 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258664; cv=fail; b=t/VwX45U/Rs6wSGtC1Xn2UITcTq4CHdY8jXYXQizMGiPR8rS29hMcSO2d/OZ0dAj/J2IZugcqqf+zEWJIkPpRjM21Wr4xbOrviZCfRXv6VmQak7u7uynmrIBFs7IonRNUB7mBS2cGNNRbQg53gAkw3ozj/7KDSXw3wOBXFrKucU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258664; c=relaxed/simple;
	bh=qABjvLrJIYulVYunUG096Qr8FfRgo5iFP5hhf8V1Yls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oi0FwmRFGnUGLV2XD2pZCStwCsuVeV8yFWeqrSSzldwQ4LlWDq6tX6H4+TnvNa8IE26xuFpRlUihRrFn+S1fsrOQg01dKReroK5Av1CcaA28nJU5RrH73VN8RgZsfhIEV03O8ID0lSMBmdoGg5JQRuGG8q2w7RXMVZQP5/+BD6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GMTb8pCq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OAp/CCPR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMQmNK023221;
	Wed, 23 Jul 2025 08:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MDBI9jFu57FrlMoLayT15pStSDGE9xb1LHfLiTvirfs=; b=
	GMTb8pCqdksiE/8/ELU3+kLlEV2wpBGI+6Q1upUHGONa8ByXjg7fakAHCuecYrC2
	0OTIfmioQc64ScKSpnYTOpsnWHYcRkuc9SYNBRaMWE6IvwFYyiniO4XYHUBxZL3n
	k64zUecWGxo3NU/qskgaw3TZr6Jd1yNtgnlxlk8SJquiFLsPYqC2MrJBXxCXOslF
	ooG1onq/zG5E0I3qt49MHgW8aqtQobHypOQ3dtFpEqwtvn9ttSlwylHBbDg/CZ9x
	5oOFfUY8kIM7CjJehrgB8RJWevxQYdOU66iPp93D4hF2TLA7+dAWIAxsA0cs+b5T
	EXn8my0515UBjSjIg5oAQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9q29g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 08:17:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56N6Ecf0037696;
	Wed, 23 Jul 2025 08:16:59 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tab34f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 08:16:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MG/6BwfC5iDu0iREBTuWoNgaP9oF16w0ua2OCy0b5lXk3lFG1k+Zdq7wdMKs/78xbPXqba/L68D3/M6OEqmip7tWGvze7iS1HSr2sAvLuH9fnz95vF0DKQQKlEvqpayo+b0NrpxPA0Ux8H0p/HmK/m9zMKi+BfiGrVmTrkf2x2OV+b5KkdviIGVvWnLFLfDziw778vll8fxJTj1jP62UIicueLJD1jn3kYfwhlrQTs0786gL+DwxqjuSIhnE3+oZtiCcMWm+J/qu1kLDpm1tQNM/0vCMHYc3JqI/IPKLPD/KcKsN7hB8un+lzPpNJnFHo+IAhJcpNyeb51BbQo8TOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDBI9jFu57FrlMoLayT15pStSDGE9xb1LHfLiTvirfs=;
 b=pwmoUQIcgEc7pk90RZIK8uiSjM+7FiOkbAHMLNXJj14Qs3PK8otyQ4elOlHpYbblmHvtQIcOL+o3WI2LqYhLrf7CGVCnlh5CMxeGmcxWwVCP08P25aUa3PTzFiKRkS01jSPZ8ms6vgBmpFdjSmjqCQb9STkj8CZX/Ovjpcc+gnTkaVd26Pa17hBQgQ9cAnVcvZNWyBdJiKuB08TnDHgag+WdllQJCGLlBPdfqZD+1f4sk8hAEYG43I7Qj4P2KS9jSeMhsf6F/qOmbweHRzlBXQv3+rFQ9qEAdxFsnk3ujc9u0EHywIepXAbu3HZ9mQymR+obMeKtsEqmRxBZSItQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDBI9jFu57FrlMoLayT15pStSDGE9xb1LHfLiTvirfs=;
 b=OAp/CCPRRp/hG+IRLNDVu2ninSfNXSt4PwZrU2qQTBw5mbCfbSFOTv3N6gsEfhKrZjV4RKGsw4pyqwQqsHzCMNR6lOw251zljpc2xwviYe5oueKDC8GVS3sa8DTLi7EPpUMpbN7Wo8V+lAl62Na/xETKIj1v6kVPy7+uJh9Z28Q=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by CY8PR10MB6442.namprd10.prod.outlook.com (2603:10b6:930:52::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 23 Jul
 2025 08:16:56 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 08:16:56 +0000
Message-ID: <cf26c916-74a0-4945-981f-0c3c9d9bfd40@oracle.com>
Date: Wed, 23 Jul 2025 01:16:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New codectl(2) system call for sframe registration
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Jens Remus
 <jremus@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>, Brian Robbins <brianrob@microsoft.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
 <69d09381-2315-4c95-ba5a-28d148ffd19d@oracle.com>
 <79b59f16-3f77-4e94-ab85-dc454b1df18e@efficios.com>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <79b59f16-3f77-4e94-ab85-dc454b1df18e@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0383.namprd04.prod.outlook.com
 (2603:10b6:303:81::28) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|CY8PR10MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 13196561-f6a3-4830-f764-08ddc9c149cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnFBWnVxdG9pZTlpRlJ3QmZ6K1JETFFFdytEdjY4d0w5bXVuZUE1clI4ZW5o?=
 =?utf-8?B?dGJpTDF6Q1d1UWpUc1JuU1FaTFp1Z05mcjZhOHlpdlppcmptRS9PbHM3ekZn?=
 =?utf-8?B?eHN1M2V6UXlZZkJXNmxpN3R5bWh0emFoQVhmY1dnOGoxczhxbFd5cmxiem90?=
 =?utf-8?B?Y0s4RWIwbEMxZU5ybDI2azJDaExBNmpYbTNEWlBqOWIxR1UrOWR5ZFFSTTUy?=
 =?utf-8?B?RmJ2REZEeUQvelpVNnlNTFliUExpSWFmcUdxd05EOFdmNk85cVFqcmhrN2ZR?=
 =?utf-8?B?RnhicDNsWUgzNktxazV4b2FzZkFzdmoyWVhuVTZhYUdScjZ5anJHdmIraG5U?=
 =?utf-8?B?NWxCeGIxQXBseEFLUUljTlpFSkRjL0VtSk4xTFc0b0ZMTjI4RG5Bb2pzUG1n?=
 =?utf-8?B?bVhJb3RTSm5IYkNacGViMHJ4NldwS1gxQkxkMmtXS1dLNHpJaklmWDNXWWR5?=
 =?utf-8?B?MTQ2cU9BTWp3SnpyZGRMS0RkaGZvK0VNL2VvQ2E2WnJTaXhaV2h1ZDRycklU?=
 =?utf-8?B?UGZFdTE3RjNjTHExTEVHZWpZaWJucllKckVIR1cyZVVSTzEzdTNkSTNnMkt2?=
 =?utf-8?B?TllXZHNPUXRyNHhsWUxiaXRNMXgyb2FVNDRkY2xZODBNRUlmak5MTXhEZUpD?=
 =?utf-8?B?bFhYYVpOZFVhODMvSnppTG9Jdk5JL3UvNjZhVHZhSk1DaHFlcG8xSnVrL2Nr?=
 =?utf-8?B?Vllod0tKU29BWlV0T21pNjJycXNKVmJqSm1HMDVIb0hNYlNPL1pLSStGWVVM?=
 =?utf-8?B?SmFnRkEvcFYwZ0lCU3NDWXRvb1g4c1JMTVhoeW1EMTVDeHBIaU1JT3dCMUVi?=
 =?utf-8?B?S2F1VERpSGtjY3VHaUpCZzBCdjNHeW9uM3VEL3FLbW5mRkVXbWVLQzlUc2hN?=
 =?utf-8?B?eGcvNDUzSjRSTWRPUC9vcWxqa2RtNE1pNlpnWTVlWU1QT1FmT3ZQR1h2MmhB?=
 =?utf-8?B?a0JJRXpYNzdWMUgrRGxyQW1wZmIwRFVScStKUDhOazg5RHdGQi9oR2xTL0s3?=
 =?utf-8?B?cExrb2pGZ2ZMUzNYQ3VLNFA1UVQ3VWhlT1kraDUwQUVaazVaOC9XL3lCWmUv?=
 =?utf-8?B?WTkrZjlhdEpZK0dlbCt3OTJlZ01SQm9Fem5MdXgwWmVzRHU5VE5CYWg2K291?=
 =?utf-8?B?MDdtVnBRbld4M1E1OEozbWhUWExJa2s0c1R5YXN6SURwZnczSEpHZFo2Snpm?=
 =?utf-8?B?MER3VHZXUUgzZzBlUDlldGw4NVR3UHlwTjQ2eDNrNVFYalBvZW1WVmhCUm9S?=
 =?utf-8?B?ZksraldDNTdtUnJKNjV4ckROZ1I5MWd0VFNtSkJ0UlRlRWMrNTNNVlVIK1R4?=
 =?utf-8?B?eWJ4Y3JUYnJyUWF0UmtZMzNCMGV2ZHNWc3o2djYrZkZnNGZGd0hONE4wV09x?=
 =?utf-8?B?TnA4Z255dTZWeWFMZEFPcXFDekd4RTZaSkYvZDRTT1R5TEJ2T3J4bm9wek81?=
 =?utf-8?B?ekVpdGp0M2JPRjBlS2I4eU9wTzU4Q3pPbFliRklzUENESCtqUHRzZXpZeTZ6?=
 =?utf-8?B?citTNXg0eVVWRHhkeFFlekNFQWdieDZoelFXM1d6aittZy9SbUQzR0M4UUhy?=
 =?utf-8?B?dmlaL3d2akZwR29qVnJ6aDZPaHVQa2R3SGFiM3hJaTluUkwyMXA2Zk9Ma3hp?=
 =?utf-8?B?Rm1HZEtrZVpoTWVyVjBXSjZsWURTVWpIdWloNFpFZzRTTENYVmFtcmhrSEdq?=
 =?utf-8?B?bmhpYnU0bi9scWxtaVR6cUcvTmtnRnBjRy9pTmFZTlg4bWYyRkFjYlRqYWxQ?=
 =?utf-8?B?TFlQcTBPWWhCNjAzTFRuc25WNXRkaDZmRFg5Q29NbnFxdlhjL1ZGSzc4M3pH?=
 =?utf-8?Q?+CMCnP13ZwNpQFpXFc3hwFlRWSgVUtB3Ogulo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2x3UlZWOHMzaWlEL0Y4SUZ5K2d3V1BjSWtCVDVnVWJEQlpBektGNzF1MGdQ?=
 =?utf-8?B?Tlh1OElrbGVNcktXTTZIQWhnWmtJM2RjdkNDUm9ySTdQZGI0aXA4R3V0Vjd4?=
 =?utf-8?B?TmxKWGx6Mlk3S0RpTXFLOFJ1eEZsbTh4RFJIcTVpZGhUS0dTVDJpVkZkRHlL?=
 =?utf-8?B?QVdCalRiQ2FaWkxjR1JHUmNyNlBlc3VpUEhzc3J5eGdxaUw0QnJCNXJXMHZo?=
 =?utf-8?B?MnhRRjU5dzJWZGE2QlBlL2FGSHRiM3ZjRzRTLzk5TlUwb01DZ0llNVZCa1Zm?=
 =?utf-8?B?bGl5bERLVFlzclc3NXc3V2FMYVNibEVsc01YMDVEci83MXlnS0gyUSswSU91?=
 =?utf-8?B?YWdHa3czWGUvRWp4SlJoNEp6cjJuYVdqdXFtSFVsNE9maWx2Qy82YTlwTTRK?=
 =?utf-8?B?d2hWa05ob3M2dXhpRU55Q3ZKMTNiUm9ydjNzbVQweWZGdzlmbjVtcEE1ZHhU?=
 =?utf-8?B?MUNCRVRGU0lwdHhkZWFCdUtDS1g4SEYvYXY4KzdxaXF0VmdodUZNUldMTlp2?=
 =?utf-8?B?b3EycEZzQ2NlTlZsRHFabkVDbjBXSUNIV0UzN2JISFBwaDRtSVdlaFJGT29y?=
 =?utf-8?B?V1RkbzdFS1hLYnNZVDNncHJXaFk2ZU50czcyVGlCNmpVS2N3eHhZMSswWUVF?=
 =?utf-8?B?Zm1DTXJ1eVFONFV5VHc2WWpDYkRqdUtHc0o4MWtJYW1sQzdSclRhdy94N0Nh?=
 =?utf-8?B?Tml1MEQ5T0VJck9RK1NXYURiY3NpRmFiOEFUbVRjazU2K0VBWDA0RytOZjNk?=
 =?utf-8?B?K0hIVzlZeUtIMVpzbStpVGVRaDZHU1lDYk1CUkpZbzUrWHBJNDVaMXpQanFo?=
 =?utf-8?B?VmxrZHdXZDRhRVZtMTJHcy9yUHJzSUJ1a3Nwblg5QzBtSUM5VXJWcWZ6RDBQ?=
 =?utf-8?B?NGNuZEZNemRhV3paVUJleGwvUjd1d0RVNkxzRmRseTRVcXJEQkpBQ2FDdytk?=
 =?utf-8?B?aXM5REluU0wrZ1NpZlJvblR3L0EzSWc2TENZQ1RpN0VYTk9DbDhkZUNHYTd4?=
 =?utf-8?B?K0ZwVW1CekljODJFSXhBdlE3SWVZK2YrMjNWN2diZjdvZ2pQOEdxLy9Pcjkv?=
 =?utf-8?B?S0VybjdhS3JMR3lDamwrQmtwNEtRWDJIY3pHKzlWWThES1B3VUt1ZTI3Tlc5?=
 =?utf-8?B?bEMrSFpLcjh4VVFTTmdrZTQyVmd6cFFsb28xdExMZHJ4bi9qekQwalR4Y0p0?=
 =?utf-8?B?UWR3ck11OXdVYmVKMHJnbGFsT2hpN2UzNUhyZWMwbFZ1OWRMOHpLWHUwM2t3?=
 =?utf-8?B?Zm5RWXlUQ2lPQkt3ZHgzVjNTRVpMYWtPVzVnUktBbHpzdEdWY3Fhb1JtVVcy?=
 =?utf-8?B?MjkyVDlZanNSb0RxN0xLLzJ6elNsRlZyMzlQdnlSSnVtU0tCK2Q1NUZxRnls?=
 =?utf-8?B?SENjb2xIWXZpYTZJNmRCN2dEdTVtU3djSmFNWDVkV21nVkE2NlRKNzgyNkwx?=
 =?utf-8?B?N0FWQ3NMTitxRzlFQk41aEtvQnpEc1dOL2FHdFNpb0tTM3JjcnRNY3l4bnM2?=
 =?utf-8?B?dVBVdjIyL1h5SERzWkNqaGU4YnkwSDI0UEdzRmtlRStRUFU5UEV3QkVyTXZ0?=
 =?utf-8?B?amVQTnlMeWdxQVBGNHBZTy91QWZkYU1MeFhKRHhHemZiSmMxUjFTb3l6ZFdk?=
 =?utf-8?B?aEZGMU1XOElVWlV5U01xL1JqQjl5ZFJRbkxLbVZJcHoxblFkTTB1dXBDSStX?=
 =?utf-8?B?THI3ZHYzZVYwRGdGYlZQaEtUQVZkS0lnWUEvU3FGbVEwK1ErY0ZqY3M5dVZC?=
 =?utf-8?B?S1haQ3JxNUlqbnpPdUNRQ0ZhdXNUdmx6MWpXdnloUEduUmhZSW1FbnlPV2NZ?=
 =?utf-8?B?YzhXM1NLK2JyUElhMmpQUTN5REZOMENCNjE4UHN4UjNvQjM1aEQxdVRzS0lM?=
 =?utf-8?B?RzVsSHpXeDZHVXlhUTRORmdaeFQrM3NDNmZCdGU4RTYvZ2ZKeXN5OGdNd1hp?=
 =?utf-8?B?TVExd0JZbGhFT3F0SWxNZ3pwS3BseWtyTktaWmZpd2hLTk44VjUxZkNURFYw?=
 =?utf-8?B?V1RFUmMxbUI1WVVHazR2R1RhQmlla2hsN0pUZ2ZoQmVlUzF2NE9ZeVNGM1Q5?=
 =?utf-8?B?S290eDFTZGYzM0tET3BxOEdCY3BOdWFGWWRpTzZwMXNuTUdlTXdZN3ZyRnpE?=
 =?utf-8?B?VzZOUmgzWi9GNXZaV1BXeXRnVEV5Y1RtWjIxZTlBRC9vK2VDZUFZSG9DNm0z?=
 =?utf-8?Q?ixAWVe30ukS4pTbQbDbY6Go=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Eob1numsWYoBFkTmsv4DsXWKMS5gaeSHKoc/BVmD1o3VeNKhLt4Lj1+5fAT/gItkVGowgkPoP9N5ZaE9QleSuItZ1n+6J/R7xid8bROjY7pNZqDfneRgn83Js4TX9QfWcemq6CsxSZeQ9yr69hG/Qb+RYnNEbziZcwQ3BcwNGGNy9ICuDBVHlJsruKWbBmtE8OSau1VZYDEUkURrfT47nturokugR5olxkaPWyRXDLZvtIKGsJyiwGjJ53AScUCJiu87mV23ecsIHTRmaExUm1AMDDQBPzA4GMJxMTRacFokyH5g4Pi4EJEQkkrKXSirumTW1WS3qHB1h2dRhHuqmiV7iyTIC7u/s7RiDwvS29XqRspTsYXjp/3Cj7ow6UhTq7KbvoRvp40gQgewke2ZYHGxHJ4ymXwtiUDGWPbj7YPJJAS2PdKRlg1zad1SDGcvG3OPjzMD6QGjjZh51FFR/KzQyLjzDjAHLgbHYBpddLBWAtQS3nmVDhCn33nn7FGlPG1CbRDyZLQxMB23V0zYr3jxzwaS4GQUsVAVbaLqllJpq/S7ZtVvgL7mL6KiDuR6Bbs68bJ5Mg2ydN5lAs8xV6S4fqBoVEAnT6qzcJHzbFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13196561-f6a3-4830-f764-08ddc9c149cc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:16:56.1884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5bfc7veIeBlbRc4Tkbb7uDC5SNCaMOX9i81RsXWjWu9Fbe2FaneOdjOybsWZV2OmxsEnu/nW6/3tZB1eEnYEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230068
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=68809a7c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=U40Yx87jAAAA:8 a=cSPbtdnysSowHKgjDYAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=yv_D6YSC6K1Ih23S2Yuy:22 cc=ntf awl=host:12062
X-Proofpoint-GUID: DRcy6mcuNCgINS-o2dQDYkIODbWZhYnB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA2OSBTYWx0ZWRfXwsVcaQ2WbAy1
 xmdcIsH7yHxZRg1RkbbUKaERPfhfCIxaa40w1WZZDOXzO6sCcIFXzZ10mKhkvljMVRII+tsmldT
 xiuM3hx7Jzj+XAfGNj8C1WbF4JQlHagmGRZTdXMToDYuYbw/9p0cwrOVrQlTXa+hdt/7of35RZc
 GHSJbbrZ8fDQnPaRfZjF7mAhqk84iOUDcEfAlz7LnbG2Bkip+VO4o8v9i6vgVrQFyEkmWoYi/r7
 OXGjt7MWYxXKucBwo64YuMIku30RtdNhEt2vJD5JilbXlwRKf/jB7KS3+DvlsGT9FSbLEj5fzZB
 KX5yQ7HdzK38MFghtlTG59Tbcx958OcH9hNyv9NpHx09MTNXmuo3/lFrZ16PDQrPJGdOF7DGNd5
 leFvb9MaE5HIJfArCC+7jFo7+OaXZHJO1+3CRFxA9afwBrhCgklS7agezuNOzZPV7BhxWA51
X-Proofpoint-ORIG-GUID: DRcy6mcuNCgINS-o2dQDYkIODbWZhYnB

On 7/22/25 11:49 AM, Mathieu Desnoyers wrote:
> On 2025-07-22 14:21, Indu Bhagat wrote:
>> On 7/21/25 8:20 AM, Mathieu Desnoyers wrote:
>>> Hi!
>>>
>>> I've written up an RFC for a new system call to handle sframe 
>>> registration
>>> for shared libraries. There has been interest to cover both sframe in
>>> the short term, but also JIT use-cases in the long term, so I'm
>>> covering both here in this RFC to provide the full context. 
>>> Implementation
>>> wise we could start by only covering the sframe use-case.
>>>
>>> I've called it "codectl(2)" for now, but I'm of course open to feedback.
>>>
>>> For ELF, I'm including the optional pathname, build id, and debug link
>>> information which are really useful to translate from instruction 
>>> pointers
>>> to executable/library name, symbol, offset, source file, line number.
>>> This is what we are using in LTTng-UST and Babeltrace debug-info filter
>>> plugin [1], and I think this would be relevant for kernel tracers as 
>>> well
>>> so they can make the resulting stack traces meaningful to users.
>>>
>>> sys_codectl(2)
>>> =================
>>>
>>> * arg0: unsigned int @option:
>>>
>>> /* Additional labels can be added to enum code_opt, for 
>>> extensibility. */
>>>
>>> enum code_opt {
>>>      CODE_REGISTER_ELF,
>>>      CODE_REGISTER_JIT,
>>>      CODE_UNREGISTER,
>>> };
>>>
>>> * arg1: void * @info
>>>
>>> /* if (@option == CODE_REGISTER_ELF) */
>>>
>>> /*
>>>   * text_start, text_end, sframe_start, sframe_end allow unwinding of 
>>> the
>>>   * call stack.
>>>   *
>>>   * elf_start, elf_end, pathname, and either build_id or debug_link 
>>> allows
>>>   * mapping instruction pointers to file, symbol, offset, and source 
>>> file
>>>   * location.
>>>   */
>>> struct code_elf_info {
>>> :   __u64 elf_start;
>>>      __u64 elf_end;
>>
>> What are the elf_start , elf_end intended for ?
> 
> The intent is to know at which address the first loadable segment of
> the shared object is mapped (elf_start), and the size of the shared
> object mapping, which is the sum of the size of its PT_LOAD segments.
> 
> This allows tooling to easily lookup which addresses belong to that
> shared object, for any loaded segment, whether it's code or data.
> 
>>
>>>      __u64 text_start;
>>>      __u64 text_end;
>>>      __u64 sframe_start;
>>>      __u64 sframe_end;
>>>      __u64 pathname;              /* char *, NULL if unavailable. */
>>>
>>>      __u64 build_id;              /* char *, NULL if unavailable. */
>>>      __u64 debug_link_pathname;   /* char *, NULL if unavailable. */
>>>      __u32 build_id_len;
>>>      __u32 debug_link_crc;
>>> };
>>>
>>>
>>> /* if (@option == CODE_REGISTER_JIT) */
>>>
>>> /*
>>>   * Registration of sorted JIT unwind table: The reserved memory area is
>>>   * of size reserved_len. Userspace increases used_len as new code is
>>>   * populated between text_start and text_end. This area is populated in
>>>   * increasing address order, and its ABI requires to have no 
>>> overlapping
>>>   * fre. This fits the common use-case where JITs populate code into
>>>   * a given memory area by increasing address order. The sorted unwind
>>>   * tables can be chained with a singly-linked list as they become full.
>>>   * Consecutive chained tables are also in sorted text address order.
>>>   *
>>>   * Note: if there is an eventual use-case for unsorted jit unwind 
>>> table,
>>>   * this would be introduced as a new "code option".
>>>   */
>>>
>>> struct code_jit_info {
>>>      __u64 text_start;      /* text_start >= addr */
>>>      __u64 text_end;        /* addr < text_end */
>>>      __u64 unwind_head;     /* struct code_jit_unwind_table * */
>>> };
>>>
>>
>> I see the discussion has evolved here with the general sentiment that 
>> the JIT part needs to be kept in mind for a rough sketch but cannot be 
>> designed at this time. But two comments (if we keep JIT part in the 
>> discussion):
>>    - I think we need to keep __u64 unwind_head not a pointer to a 
>> defined structure (struct code_jit_unwind_table * above), but some 
>> opaque type like we have for SFrame case.
> 
> What is the reason for making this an opaque type for sframe ?
> 

So that the system call only does the work of registering the memory of 
specific size as stack trace data for addr range (text_start, text_end). 
  IIUC, in the current proposal, the format of the stack trace 
information is exposed in the arg. So when the format evolves, this will 
mean additional management via some flags?

> 
>>    - The reserved_len should ideally be a part of code_jit_info, so 
>> the length can be known without parsing the contents.
> 
> I've placed reserved_len within the unwind table because I planned to
> have the jit information for a given range of text be a linked list of
> tables. Therefore, if one table fills up, then another table can be
> chained at the tail. Having the reserved_len part of each table makes
> things easier to combine into a linked list.
> 
> Thanks for your feedback !
> 
> Mathieu
> 
>>
>>> struct code_jit_unwind_fre {
>>>      /*
>>>       * Contains info similar to sframe, allowing unwind for a given
>>>       * code address range.
>>>       */
>>>      __u32 size;
>>>      __u32 ip_off;  /* offset from text_start */
>>>      __s32 cfa_off;
>>>      __s32 ra_off;
>>>      __s32 fp_off;
>>>      __u8 info;
>>> };
>>>
>>> struct code_jit_unwind_table {
>>>      __u64 reserved_len;
>>>      __u64 used_len; /*
>>>                       * Incremented by userspace (store-release), 
>>> read by
>>>                       * the kernel (load-acquire).
>>>                       */
>>>      __u64 next;     /* Chain with next struct code_jit_unwind_table. */
>>>      struct code_jit_unwind_fre fre[];
>>> };
>>>
>>> /* if (@option == CODE_UNREGISTER) */
>>>
>>> void *info
>>>
>>> * arg2: size_t info_size
>>>
>>> /*
>>>   * Size of @info structure, allowing extensibility. See
>>>   * copy_struct_from_user().
>>>   */
>>>
>>> * arg3: unsigned int flags (0)
>>>
>>> /* Flags for extensibility. */
>>>
>>> Your feedback is welcome,
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>> [1] https://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng- 
>>> utils.debug-info.7/
>>>
>>
> 
> 


