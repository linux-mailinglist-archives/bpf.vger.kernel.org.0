Return-Path: <bpf+bounces-61301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35760AE4B01
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 18:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017B1163F0F
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD227511B;
	Mon, 23 Jun 2025 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AExnTfyF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b2lNRkP7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF0266EE7;
	Mon, 23 Jun 2025 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696337; cv=fail; b=sazUodB1DeNF6ivRSn03/rKdlDY6HcMM04GuWfU4xy22dpTeYNymGYKDJfOP9Bt9ZPMtneFE79MwSZ1om4hM+ZJw1j9aeZTm6RXtftR09vIxUZDOYUnxZQ0U5z58m8QPPqM75vdczBOmkNUzRVnijFZc8xBKcviEn53kgNUwPdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696337; c=relaxed/simple;
	bh=YZACiECLDVPhohJRL2fnfqDKn7z7coD9/qYgj66BEn0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gr79OK7HoIZVbtgBeYOW4KlQKd1HkrncO1pw/a57svk1uQhLOgp6U2JhllVT9aa4W0/Q7wPoasqzgIAbi595GR1rAnU7ykLbt0RmaLRldmFv0clZd9or6wVXizl481zZd24jZw908ZS5+99L6fGSMtKWzckarGUh6Z6nnTY9f58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AExnTfyF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b2lNRkP7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NGUJ2d028323;
	Mon, 23 Jun 2025 16:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nvNnYMm8THhNRZRBgYS8ZDcxnla+J9gNmQm6ECSB+Mw=; b=
	AExnTfyF73gabaCbqGQxxHadFUHf1lCqVyYNfMU2v3B+xnSW+h5yyGFWMuIIXhj7
	jO/iEX/ZzkptSsSVQerH/EaY7tTIz074slvxBJbZGfN1L/Xuew/criL9UjP/YUlb
	DlqrDiaT1EE2Toa+BfRtbbndt9lxB1nXCWpv1BI3HchfQQV02AVDZjYF93hs5Nlw
	7he9RLhlpJDd1hCw6W5y1ZXK/pzm+l0poLweervtNjrkDJh53JABnbtBV+xPGsIV
	DAHjWsxYslTzKqFbip5/qDKiWCRJPaFZexsoUeoffmz6VnFqC02CagoUKitYRrwH
	CdgPl6DLuXqmPkluDrj3fQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egumj1x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 16:31:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NFAqAd002087;
	Mon, 23 Jun 2025 16:31:23 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpc2c92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 16:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kR0a111NX+vlteYO0CzCS+q36xD3u2LRW/wvDP708oGaToPkfsH7C2JhUTOq9PlDV4TZJwER+MJ6/1dg8paMlaWFlOaSkt/J1fopJP116iX82GTE7bVDSVwXS4VNiRMUbpIXBMV8zfdE4ZsIHtQZGcARMnEhgdmWtXXCUdw+o7CRGWaatCS5GDOrzWO53cXAaudVkzVMUGeYff8sNifofYeAjNtDZ5blYgZRL3O2vJLCA0/BNhk2K8BewqMBROzEvLmeL28eW5dJ8ANzN0f+fYx1tT6PKyIw39Qwz/y6k/6BI2S6mOWwvdyKNaX4G+5PD4+NBb6xBSpRxnBKb/BAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvNnYMm8THhNRZRBgYS8ZDcxnla+J9gNmQm6ECSB+Mw=;
 b=mPsBl0TM6u7z1+btmnXQgNalU0gLdeX/lo3pdhZD+b863WQ05nND8BGpi1fpodQxYbhc3JsBIgHqvqK/uI4a5eaCdLpPp/7qVzkgl4UBpCp3vBhXGJZHcNcHcU/QwjY4w6WnarxkYwc6yFGdyHx6wwpgINNNLFoKhzvF9NrVdRAoZu2jT7gOVXqMKdsSbdciBbnSqPpqBv4vCAp2f6SPkRunXeDfbwLUVUw2bpTX08vL4GWuQSyc8FrMajZ1eqQEICTbk3PQxh3p+zKi0TNnDmbSI1Tom/rt1vXTtcH5hRqPJrAZ7QQew0qDpO9h0Jbd7qREu2ihQ7Wm9sKuoBm5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvNnYMm8THhNRZRBgYS8ZDcxnla+J9gNmQm6ECSB+Mw=;
 b=b2lNRkP7H0+SAi/5rGWrm5FLPqPNaxfuc0ukzANxEhhKWhrXDsOhBooThDsHxuGhL2JqsIlXDkvs1zE+iL+HnvUtO63mf0DmwX9zzQHndfCyf8YS5vtnzM+rtA4/KLeGpTPZ7K8vbttAgJbxRIk1VX+OeweEgsw2tff3MNDswE8=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Mon, 23 Jun 2025 16:31:20 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 16:31:20 +0000
Message-ID: <6f1c21e9-ba0f-4262-8f56-962e0a7d6877@oracle.com>
Date: Mon, 23 Jun 2025 09:31:17 -0700
User-Agent: Mozilla Thunderbird
From: Indu Bhagat <indu.bhagat@oracle.com>
Subject: Re: [PATCH v10 02/14] unwind_user: Add frame pointer support
To: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Jens Remus
 <jremus@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.092934995@goodmis.org>
 <20250618135201.GM1613376@noisy.programming.kicks-ass.net>
 <20250618110915.754e604f@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20250618110915.754e604f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|DM4PR10MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 640a0700-c0c7-484e-c98e-08ddb27362b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnJ1VTc4TXF3V1Fxa05zVU1kOHYzWGVLOHRrNmhkTnNiT1Jqak45Z3VNUVBa?=
 =?utf-8?B?ODFKN0xQQStBMkVibXFyRTI3SGM4TmpuNSs0OVZ5ejllUW92dHdDcjZaTmUw?=
 =?utf-8?B?QnlEWjhndXdXNFVoK21YVExsNkdXaFFWU1NOZmN4eExXZXQrYm4vOTFiVGV1?=
 =?utf-8?B?UUxvRnhQSFVoeGhKdUF5WVpZcHV3anExWW0rV3d6d3ZnZHlmY0dnM0hFRWNN?=
 =?utf-8?B?RDZuWnl1a1BvMTlpbm52NlJZbGJZYnRnaGNBZnlNbjYvMzN5SWZNbnI4YTR4?=
 =?utf-8?B?WDJVSWhrc2x3RTQrVmRkUEFsdmJicHpOT0RVb0tWUEhFTkNiUkpkTnJjNWNy?=
 =?utf-8?B?V3ZCcWczcVpMR0NLZ0JNSmpUWEZWTy96UVc3SHNjQW9kWXM5Z3ZaZ3VjYldW?=
 =?utf-8?B?T0lzNjFRQzBBTkhnVDVNajVLMTFMeEdFSk40ZHN1TkFQWlFOVGREYWp4Y0o4?=
 =?utf-8?B?N0Z0Q1ZxVVZleWVzV0E4aEFaOHM5NnZmcVdLeWVlZ3c4WmUwcVBOcG9GdVZo?=
 =?utf-8?B?eEpTd1hzNmV5dmU4KzRBdW5aN1VlZDgvTVpMaDNtS1BUM0RzME1YdWUrTU14?=
 =?utf-8?B?NjNyOGd3Yk5IcXRvUGhDdFNsSUs3MngvRm9SUUF2Tld5N2xsd1pBQjF6OFBh?=
 =?utf-8?B?ODlhcDN0OW1XV1FHdjhaS0lhdGdhYk1oWUNXU3pQdjN3K3lWd1JzWEh6akVj?=
 =?utf-8?B?MnFxN3NwSSt6TC84Y015UVBwR2Q3R2ZWVWRhajdlb1V6ZmZTQVY5M0pkaTY0?=
 =?utf-8?B?MmxNMHRvWUFlMVFaTllnYjhQUFZ2OUJ0aGtZL0dpaDZFQi9MMXpqVU43WXRH?=
 =?utf-8?B?ZEI2ZC9uTVNwZVI2ZFFWQk9zUzh3NHFzRWlZN1lwT3UyOFVXWXBXMlptMjFJ?=
 =?utf-8?B?VHhVcjBySHdBUkUrc1FydGN5MUlMWkpleDlJam9qS0RVOFRHLy9SN3dxdmdG?=
 =?utf-8?B?NmE4Y1Bmd3JRQVB3UWZrdnZVKzdMeTd1cGdDd1NBVjMvQ3pMa0JFdkFpNUps?=
 =?utf-8?B?VFZjUDBCWTFLcjMwUVJjTmEyNXRtbm5ScnRkSUtiOXRvLzgxa04xb3g4ZC8r?=
 =?utf-8?B?SmVQYmtBb0JhTjQwSXBJaGU5N2JIUW1JY1d3TkNWNVVUdE5BalczVjFJVGw3?=
 =?utf-8?B?NVJkdHpGdkV3T0N4RWdYU0RMYlFkUFJkblBzRWZQa0NYc1V0RFN1YVZTWmJT?=
 =?utf-8?B?dTU2VlRBa2hkaHRQWE9oZHBvbE05anJ2S1poYjA3NStjS3QvRzlUYkplcjRP?=
 =?utf-8?B?bEt6U0dkYmZ3bjZ6c0NrTEJwWkN2VzMwRXJ4VGsveTlpeCtBSnd6TkNxZk1z?=
 =?utf-8?B?UVhFL0lETHZzSVZvV0pLaDZ2UzZRbVM0amQ4eS9paTVVRGNpV0VlQ1MrTnFa?=
 =?utf-8?B?YkVSemZ4RlBUeUF5ZFIra2pWWlczck85YWJHdGxnb3lxZE5kMkdqb3E1SWRm?=
 =?utf-8?B?TjRZY1NCVFlkUzYrbDl3T1ZYSldweG1GdkIxYm9jWDc2VGxyR2lwTkZCMEVE?=
 =?utf-8?B?MGYvV2RCNGpwTDBNanhQcG84bmNGS0ZFOVRtZlFtZkRUY045WkRUcGpDUUV4?=
 =?utf-8?B?ZktxenJHZ3U0dWp0UHBGZ1NKTElrRGlXMmhCbUtrUTdNbXdOUUZNNDkrVkh1?=
 =?utf-8?B?QTRNTjlRSDhCMjVIb05tNU14RWMzYjRLV0lFM3Z3SHNIWHpXQUJPWllsQ1Rp?=
 =?utf-8?B?b0RleW5mcVJHbk5Da3lvaUpueXI5cEhrQzUyUDhvK1liYVhiUE1taEFWQUhU?=
 =?utf-8?B?MHErVEFhRFErM25Ob2pOc1VpZkJGUnVzbXBFMCtsSXgzaG9nVEg2M1NheTFq?=
 =?utf-8?B?dXhwMHhwT3JLaVRzUDI4OVdiWXJ0RFFBaXVSMGZWTTd5V09ZbFJyd3FJSHJv?=
 =?utf-8?B?RVp2NUQ3NHl2VlZUdjJDSHFOdFJQODhDTDYvR21aUXdBcm5FdGUyb1NyZVFM?=
 =?utf-8?Q?yQEYf2UcrmY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cC9ScWFGZTRLZHk4bHR4Rno0eVE1dlNoemJWOUZVWHJiYTEyMzJ5NGFSamdl?=
 =?utf-8?B?eUNGMFlOeGsxdGN2aFoyTTRTeHQyYU93SDBvcHhkWjJ2eGxwcW1zSDJXQnEv?=
 =?utf-8?B?K2ZtckRlcEJEeGw1YWR5MUVRc1hJN3dzaVJuRFRNMmh0TXcxZnZnNzJFOVZM?=
 =?utf-8?B?aENyZmNCeXhHVTVlcmVFZmFUYlkzeVNtay9OR0hwS2paOFh6bDFvamV1MUxD?=
 =?utf-8?B?U3F3R2pTM1VVb01kYkl6UzJqUTBtUmNhOUYzVXJYejV1aDVqQVBFN0pwMW5r?=
 =?utf-8?B?dnQybjQzUjdSSGR3a0NIMDhkdlhFVUFjKzQ2bHNZdWFRS2x2OWpaanlRM29S?=
 =?utf-8?B?Z2QvemZsNzBXU2dDODJDMTZPamZUV2F0OVJBeTJ0SlhGVHhVZGIvL2laY1lY?=
 =?utf-8?B?ZWhYcmhldVl1RnRjb3ZIZXRibnVvalFHVEs1c0R2MW9wcVpqV21ad0F2NFZu?=
 =?utf-8?B?QUc5azV1VUpCU3hlTGFKUEZWL0xhUEgycUhOVW9nck80KzN5QWJZWXk3bzhN?=
 =?utf-8?B?VEdGZHdLOFd6YWZtZFc1dnpwRHhCYmNtWTU1TkxJY2U2MHQ3NlpEZHFsTS93?=
 =?utf-8?B?eWQxMU9LQ0RtcFdaZDcxb3Y4eGpPV09VQ0x5Ti9ad283R2lRMi9PRTZxMlMx?=
 =?utf-8?B?M3NlSkZ3Y1FKY281R1dPdVRNZVdOVUpnNjB1NWg4dkgxTnpvald2QS9sZEha?=
 =?utf-8?B?akNrQkFvRUhQQThrQTAvelc1aHZlL0hQeFJlcUlNcVRPRnphSHArcWxNWkhp?=
 =?utf-8?B?SU1hbjZCQjRiMUg1L3VscmZBbGJERThiQk5KdW9YZ1dvdU94TWR3bEwva3dP?=
 =?utf-8?B?NUZsaloyMEhYOFYyUnFWZXFCQ08rWUU5NE5Mem44YjdRRVZkamhFSDJLeDFH?=
 =?utf-8?B?ZnZaVEZaR1l1MzRteHo4ZEt3VWF6WFVHSndlUjdTbTB3d2QzcHlybDhvbjhx?=
 =?utf-8?B?YkduQUZQTUV4Z25JUUhHR3Vjdm9QRURrVmRDOWpvd0pnVkt4dFo0ejNCN01T?=
 =?utf-8?B?MzlQMTU2dTlHTURRcjJrVVVNU0svVWJ5dGs3NmdkYldqS3BUNUIwbnpTdmhG?=
 =?utf-8?B?ZG9lN205UVhlRkhxNHJGK0hpOS96UkQ0YmtxWENrbXkrMFdjM2t6Yy9SOGhw?=
 =?utf-8?B?YzZFSkF6SE1KV3drRXVNcEZERFB1eFB5aFg0Z1dpdjBIbTVuV29kNEpYdEsz?=
 =?utf-8?B?MUh5L1dJeFJWZWlWdDY0MXRSWGpKZVFoNDRVelR4eHlpOGpYeHZ2L1RoemZL?=
 =?utf-8?B?bm4xcnlKUG5EMVI3UVR2V2dOZDBBK3pVVDhHSHZUTHFKTG1RclFDRGRlYWVS?=
 =?utf-8?B?NDhKa2JHb1piU3prUngzc2ZYbjloRnQyWG95VW11cnIvOVNnQ1lWRXNNa2Rv?=
 =?utf-8?B?ZGswV1NZMUpKU1Uyd3VZd3dxcDFoZUIrTUxiV3g3VDhyKzMyZXpHSnd1bGp2?=
 =?utf-8?B?azlOc0ZsODU1aW41bUF0eUd6QU1lVEgwRVpzQ0dsaVN4S0dnNXBJTnhWeVZF?=
 =?utf-8?B?VGs5eW9xUEVTYnQycEw1ZHhSOGJGeXYzZXJXdFNCRDF3T0lQSUxsYW1LQ3Nk?=
 =?utf-8?B?QmtLSERwc1hZVmdZYXBhKzVLenVoSXJiQllEekszaDRpcmdqYy9WRit2VlUz?=
 =?utf-8?B?eGlDdlVHM1Y3aFhPQmwvZmx2eDcydlpPN0xDTm0rMDlNMmc5REpRWGN1OTBE?=
 =?utf-8?B?NHlkTlFSSDF6T0xQek9NbG5IUDBnTStwTkRsQmVvSWU3L3poVGNrcHFQM3Ji?=
 =?utf-8?B?LytSNkRNTXZ3Wm0wemdCTUFVczNxVUwxRGROZTdBaHRITFovMWI1UWRYTnRV?=
 =?utf-8?B?VjZQMVVlVzRRL2p0Tkx3ZmdsWVB2UUZVMEt3ZisyNDBuOUtpMzYwdUlDZkJB?=
 =?utf-8?B?ejRxdVN3aEsrZTM3em5HNFJTUW16MGpva0QwclI4OG0wZWgyZU9JaEtPYUp1?=
 =?utf-8?B?enBpNHpIaGR5NGRtT0E3SDR6cHBZVk4vdjJNOFdTbVZOdG5WVk1ySEZPY2JQ?=
 =?utf-8?B?ZUIvaHFRNTFIRVMrMm9qSDBBemw2OW5meE9kMXJYWDRPeG5ZeXpxZnpWSzVo?=
 =?utf-8?B?ZDJEaWNJSWNlRUQvYUFlTHd1dGxiMUxGd1MzaEEyYzZZKzVLWURFLzA4dGVS?=
 =?utf-8?B?MU9ISDZ4YXBvc2NqSGQ1YXc3TGtVYWdwU3llSzRnUXNqei8rSHRjTDA4UjhQ?=
 =?utf-8?Q?nwvEC/pGH0k9om2+bwSl6do=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HYZN2graYHNhwqEq4q6zZpO4hqRCe/0U0/w70PM7KUTOikloNY9WdtSS+lMmur794Op2CUjJHhwsGg7FXWE0LgDnhrV+SzBa3BFCM2IwKYCCGtRvW9SR219ChvPOnf/qF7Z9WMwTOd6W/wFBlZOYdY6l85Ke8G3Qbv+KV9cY4xpk4P+vnpWmsjZVsfOPEhzGOPLOe91X0WmDGoST7XCF1NkhriqxuRzF4l0GGSTydyiAPwVD62ctJ1qjNPRC94nrLKrmtoZ0RTGzO9v8cRiYn1CToELMKKTszIUyBpHyjE7Q8ROidSGlCwHduZ7HWRvtb1is7rgR28uLomnVvwF36OzQOrOyFmKo779jD9Lz7/KWyt32OKw/fe7063mYctYnuLOJsakmH4aHijpwkhfLgoc85gdetoV8TJFxlINgXydSd+hd+7XTMp8KsZxbar5NW7VYDpIev665960xob2/Id1FtbYGnd+6uok5LiTqUsq4hkzZ/VCoX14X16qa2Ra1ZQE+pzOWfiK/vjLifEHuaK3xim2Qyhn23LdZuVHzhyGMW1nabMdo//VufXtAbndunodKd+QycxUbSysJUIpAJtOYEFTXYhkmUNY3a3qDIgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640a0700-c0c7-484e-c98e-08ddb27362b1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:31:20.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1FYfKdsxT0eAhBut9n7Dp83p9vSMCBPfuIMiQ3RTO500GJ55vUhJbvV+pyyTdkyhe/qRD/qsWp9ZJsXnDiZSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506230099
X-Proofpoint-ORIG-GUID: qeqA8kaj2pvN4w5BnmqBZcYBcrOHftvp
X-Proofpoint-GUID: qeqA8kaj2pvN4w5BnmqBZcYBcrOHftvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEwMCBTYWx0ZWRfX2ymNWOf16YKm cXcB+NC+G/cPp/kJaT35rp3pVrltwOffhD+IuT45Jaq5VC8tD/uWlpN8XjPk4t91x6z6EAnwYc7 fq6N7GP/mgZ9wFdFUS6ft378EE3CQyXn4iMPXwN6iHqZ6oJjEVvJAvf/MoGjtDgzITX83BojitD
 YNx7jOAVnx24qRocLXLPhfCB14HC7jVL8GMJKRva01CsDdnk/dgkzCzTTY3Ku5R/C/oYvm8jWMN zUAKPZCEuwjNrEqM/kqBtdlFNto66j1EYMZooAh+C4n9Pftr7T8G0dS3XdaRnZT0pDgKoE7NMjD tKsRL2IgbOnrnEM6EFfTZ3RllIF/7v3i0n6IEL1iYaWTyAaXNh9Ljyq44QbrluND7q7Ghscfboq
 YiVN5b6Wfq6oIz/68uin5OpyQIe/LGRYi9WweC+rnJSmwHESlgKfKZyFlK93HIw/j42G6qMm
X-Authority-Analysis: v=2.4 cv=S5rZwJsP c=1 sm=1 tr=0 ts=6859815c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=PRmOxI5cjhNb3JepMv0A:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22

On 6/18/25 8:09 AM, Steven Rostedt wrote:
> On Wed, 18 Jun 2025 15:52:01 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>>> +the_end:
>>> +	state->done = true;
>>>   	return -EINVAL;
>>>   }
>>
>> I'm thinking 'the_end' might be better named 'done' ?
> 
> I thought it was cute ;-) (BTW, I didn't name it).
> 
> But sure, I can update it to be something more common.
> 
>>
>> Also, CFA here is Call-Frame-Address and RA Return-Address ?
> 
> I believe so. Do you want me to add a comment?
> 

If a comment is added, Canonical Frame Address will be more appropriate.


