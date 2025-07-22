Return-Path: <bpf+bounces-64113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F952B0E5D2
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 23:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB06A3B6526
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 21:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADF828640C;
	Tue, 22 Jul 2025 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Il9v9YWD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q7MODhcH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9111607A4;
	Tue, 22 Jul 2025 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221481; cv=fail; b=VK69cA9JqMSem25fmyzDFRj8jTGuF++4MoGGAKD22yYiLD8Cv3tIGUmOxRRbpE6tjjqqzx40Kg8bpmP+GOzGH3nCd2CBkW9JJfXPWJK0nz+80m3xjSidSITXTuVbnD5quOr8TZsUMsLMX6Nkqi/NV1/E0KAoYhPh38FwBUM0zcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221481; c=relaxed/simple;
	bh=GQ6Qwv1YQXZi8KwCvsQrkiasnzd9vDmHPPNvuvPmJDs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iaAPq5YeBwK4uSI85egLY424PH9coiyBgMWGw+GUli9ZFcvWKiz4wgHonaX8pdXEv34lBlVLLFqr7iUiKqRu4/kz3UNhVYiE94ad8NFrswqQ/PAbz1ARCGESgL1y13kpacYbfe+l4i3MqWT0nLKvVCe1CfKx5OfH7GXHZRxOgXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Il9v9YWD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q7MODhcH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MLDYw9017134;
	Tue, 22 Jul 2025 21:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=a9PScDac2fgkVGEvT7sikZXJHlZOqni8g9GOTAYt9PQ=; b=
	Il9v9YWD4aUs1f67pWefbWl4YhhtD6tO85w1ykO5VrxRqsxvPrhNUTT1k6iUWJYP
	l6ASvU/ah3pzNBCIm0vXGZr+w34P4sEzT61xbxGIO+7SITKz853HKjQ0N5M636ZI
	uvNp/WsI0lc2rV2azpuU/jkxjd4nHTnaHqean+bQYVgVKU6kNzzDNDu0y7nfgodl
	OV0NNBZEP6V99HZTgWdzG2XcGD331bDZIVh7hCaXZU2r+RwrKaYVFkJlpxRCr4SQ
	ywj3nPwYXsLI8Zyuf+48C/zwE6MKYWRDYJcZhVkTp2Z4a2hRqmJN0oRPEJmKzG/b
	MxGwglD7AXnJjnT1SEPxLA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hpec0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 21:57:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MJmVQ9031482;
	Tue, 22 Jul 2025 21:57:32 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tg5nsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 21:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPGKcm1uxSPEM3rLAUyWNEYNykwb+g9/pEMCA2cZl+BSNr5Z7t+g+Kg8g9Wipdmndawz6fgizxnz3Hf0vrePzbsKXXXYFyz4scfp/Rln0NQN4kAc4/C75bQC1bUzflX8I6xAZMdUqs8VrZ43YkF2D/JOXyTonq5j1F3Yds0g0d01ZlGwXguamq5KXG1x6oSmRtRXtGLcwHxlYYLhvCiWoMUwOZuO6L/XX0R4jU5Mssc3erCZtMQuBDWcGDYOa/gJfFZUnwu5ES3sRmAEUXuy68Be8BYgffgLMiPxCfSaFrq61ZXMvqw1AXdc4FOK4PZC+lBEvz0B5WgXU98qgNlRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9PScDac2fgkVGEvT7sikZXJHlZOqni8g9GOTAYt9PQ=;
 b=KYjsbjtORe6+xzzvcwsqA7tU8kMVZpAUofpT3YqsBPkJ1A+3mYdQEp6C8HoWxgTAkQujIfMjFsx4OiXoLKUE86isaDC1xCAduCJOurUNCnRF8DnMVE9BKiyHSlwxaTxyDrl7xetwZeQCCbf7Aue3274HqdOYy5oRd2H/ijeHZlwEtGnfdVDZIkynrc0ra0Ki78dR25tpHhKrFa92LSLUr3PpGpK+1xP8Ez6C9DyEl4KXOGlrAmBsEGYWex/gEWz7ZWwCHZMovnkPS/1crUzgX9zZG9TRpmumEQTLsyV2nte6eLWgqqxbGQE6Q6dA7GzttLi5sOSZvIr7zvYI1DaEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9PScDac2fgkVGEvT7sikZXJHlZOqni8g9GOTAYt9PQ=;
 b=Q7MODhcHRCOIBj3DhTwmW2AmZWOwL170Bj/fnpgY551YMqyHBGOZhAvWXXTU70GZrHByDSJB6Xz3odDYRnS4/Ttj3mr/kC5nFoilPwhoueuSaBfcjN39Eoey2IAefBgtge2HCY8x3+LCRYPdkMAAZulWkKd7uz+7xXQVmdFcNPs=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by DM4PR10MB6085.namprd10.prod.outlook.com (2603:10b6:8:bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 21:57:30 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 21:57:29 +0000
Message-ID: <afdce562-d434-4137-8682-bf92e9e373b3@oracle.com>
Date: Tue, 22 Jul 2025 14:57:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New codectl(2) system call for sframe registration
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
 <ce687d36-8f71-4cca-8d4c-5deb0ec908ad@oracle.com>
 <20250722171310.0793614c@gandalf.local.home>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <20250722171310.0793614c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0124.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::27) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|DM4PR10MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 939313ac-2b93-423d-74dd-08ddc96ac0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXQ0cFlqWU5haVRXY3NRei95aWZobGxQQkE1TFpacEp2UHBpd28wQ1NBM1Zz?=
 =?utf-8?B?R1RIeStReW5NWCtWQjhvUnh5czh5K0FpRFczL0xsdkR4bXZZYnZnbGJDZm80?=
 =?utf-8?B?VXZidWxSZHNRUDF1RFFPVlQrL3BjcXJOVnk5SzZ3bjlISHVCSjdCVFNHQ1Av?=
 =?utf-8?B?bmJCSnludXdCQUI1cHl4MUNSWENaZEpjbUxrSVUzd2VYc01KbkE4RmJFZlo3?=
 =?utf-8?B?aXB1VEdOTHkxcm55T3Y1d2xRa3FGVHQwM2tHam1aM3ZnQ2R2Y1BiM3RqT2tT?=
 =?utf-8?B?THcyZC9VSFpuNW1XbkJCWlhpRm02dzY4MjNlajdtSERCNmlxOFRTR1hUa3VE?=
 =?utf-8?B?Q085MER6Vjc4elBSMUpqM1RaTS82amxQeW9OaGg0cVl5NUZmK1l2allyRDBp?=
 =?utf-8?B?RnFYRUlXWFVUckljYXVwZGlEYjJ0WXFlczJtQm9VVk5iQXhvdDJzZW5heSt5?=
 =?utf-8?B?TkVHUENUdHVaMXFkaXA2a09PcWk5UllWTllVWGkzYXUwWXZkWktiWmx0aEZI?=
 =?utf-8?B?SFlyaDI1NnF3NHhJNXZVVlZJY0ovUUg3c1Rrak5RKzJLcS9tR1JmQ2hBc3pq?=
 =?utf-8?B?WVR0R3dpYTRBVUg4d3dSbDJhV1pKRlZ4Y1IxaTA1MnVveE1JN0FkdmQwUHNE?=
 =?utf-8?B?b3JyLytlMGo1SnBZWjQyNnV1UW80ZmZUaTQ1V25aSzl4S1Vta09jL1k1b3Vi?=
 =?utf-8?B?T1BmWUhBdEw2OCthaC9ZUzdtTXRuNGxKUXl5QXpTSlhvSmF3YTROUTRBQXVp?=
 =?utf-8?B?RUZHYlAvb1BnMUFESmYvVjhlcWpFazhOOUpROTB1dk1tVkorVEVuVjlhajN0?=
 =?utf-8?B?bWZ3dEFhbWhLT0gvS3Zub054VUtQczdhb0JGcVAxRWp0VWN6dXhyM3QwRFRk?=
 =?utf-8?B?WXoyNmNvSTdYc2ZmM3VKdmttMU5uVkl6bnp1M2hXUUxnMXFzUEZZcXVGTGl2?=
 =?utf-8?B?bGsvNmFzYmZURDE4QzRrbHI0cEJzK2pydHF1ZUlLMzNLc1p6dm96M1V1MW1y?=
 =?utf-8?B?SXczdHVWYjdWaHJITklYUTM2bWRMK3FLUUh0NDN3V1lqWFE1RXVxVFBKVENO?=
 =?utf-8?B?N3BQSklZUy9iWlZ0eG02WmUxZWp6UjZwOTllS0J0RWxib0Z4Q0FvNit4LytV?=
 =?utf-8?B?QVlGaFdIZ3VFR1J4MEluNFhNY3ZuV1R6QVU3ejRPR0VHUFUybzltTW9rWGY5?=
 =?utf-8?B?dUMzeWhLUUN2K0lrUFhMeDlQWk9xVjE4WmhmR3YyOEVjVTlQZExUalI5b05C?=
 =?utf-8?B?T1NEbHd4S0Myb2tvRHRwZVNCS1pLOTlxZVhmbDZtYzZlSlBvaGk0ajZyYzAr?=
 =?utf-8?B?S2gxcysvbEVjbDBWZTJYS2tPUTYwZ3llSUZQYUFOTkhlWGtaSDE1OE1TT2JZ?=
 =?utf-8?B?M3dsd2IxRDMxMVZoMUY4LzdOVHdqNXNqWDJEZytyam52QzQ3L0dSL2hEZ1J2?=
 =?utf-8?B?TTU0ZWlpSkdLNmFWamNXdE9namE2MG1VSkpxU0cxOE5FQnhuOVQ5R3p2NVEy?=
 =?utf-8?B?ZThnTnN0Y3FpeFQ0OVpGZTZYdzZJcEpta2REcUZjQWJDbHJTNnh0RmhVRVlG?=
 =?utf-8?B?NTU5bG9VWGRHRGZPZmROUTZobVNYVzU5MEs2RDM2UWcrMjRXbUg3cWJKY3dH?=
 =?utf-8?B?eWRDMkF6c1ZYYVA1eUN6UnQ5SjFzQnhDdXAxQi9VT0xWTEFLOHlRalloY3Bk?=
 =?utf-8?B?M3d6S0VrcjFTMzg1d29kRzR6ZFd4a2o1TWkwVkRFZ2pzUldieUN5UDNPQ3pQ?=
 =?utf-8?B?ZnNkamVmL2J1VmdLQTF5K3c4T0J0ZytLRy9aWXlRbmJzZ1RYeldwVGRiNWk5?=
 =?utf-8?Q?WDV28OExUN6+toq9x24y1SulNc1kgQ2xnUil4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDRvMHhoNjBqbUsvMnNmZm5DbXV3WHhSeDdYSUp0NkFSVWdyL0Y1MnZ5WDZh?=
 =?utf-8?B?Qm1vVjVqL2JINkdXaGFjMHB5MUVNeDI2bnJ0dnpGbjZDUFBQcW9sUXFPUmVD?=
 =?utf-8?B?OFRjYTJ1UGVWblc5dWtpZHpZVUxLSzZGMXJXSGVSMFVQWDlHckgwM3BVNzJ0?=
 =?utf-8?B?SHFLK0I0aE9LWjc5N0dGWjBsZXZIL1lOSnBEWFdmSy9md2Vhek41SllhUzc2?=
 =?utf-8?B?bVY2Y3RCZ3ArMTJndW9DRWRHOExXQ3NSdXBpVnp5bHZvY0tSdGl1bm5aVFhU?=
 =?utf-8?B?ZEtGRWtzK3RjZmdISERJSTd0ZHpzS3c4a1ExWEs4UWE2WDlkWVpQd0FVbUxa?=
 =?utf-8?B?cXBnMDVzci9Id3JoQ0NWdDJmRHpSWFNSOG56Mi9lczBHdERNZzRnT2J6T0JE?=
 =?utf-8?B?SHpZdVFnVmpNOFJ3a3g3RE05a3M0S2xXS1YrN2FxZDVvR084Mk1RN0hMVXho?=
 =?utf-8?B?bGltalpwUnp6TVpHdGJTVjdRU241ajA2WTg1RHdFV1djQ1pSYk1sTTZ1S3g5?=
 =?utf-8?B?ZWRoSFBmKytya01kVzRtWDYvTlFaaVRORWM1YU9DSCs4a1hzUEx6YlRLYXJK?=
 =?utf-8?B?L3lWR0xDdzJwd1JXMDZoK0FML0RocTFEZzVIYnBoSDZOdHVuZnd6cHBqQytZ?=
 =?utf-8?B?R1FCeTUxTUhkbWxJb1plWTQvOUd3bFJ6b0hmSC91LzR4QzVMakNMckh6aWpG?=
 =?utf-8?B?K1NBWWhXZC9MMXJxcHFDa1IyV1NjYk1Uc3hmN0hsRTN5KzBKOTF2bEJCakdM?=
 =?utf-8?B?aE5LM3ZDMStSaVlIVWpEVnVVdHR3c095OFlkV1hjc1ZvV2pjeURvR3RRUnJR?=
 =?utf-8?B?RnpSd0s5NXh5M1JnL1g3NE80ekJNZGRxaWZmKzl5OXowajZINFVsWENweDAr?=
 =?utf-8?B?c0crWnpxZ1IxN1RxZWVqZG41NW1HR0xVK2ZqNE1uMmFwL1lZNnZxQTM4cVZY?=
 =?utf-8?B?M2NPejUrOWJpUkpCQXZDclk2b2oxbkVBSmVZRG94a0dkTTNNaVlEWVU1VDBH?=
 =?utf-8?B?QnVCNy9vNkpwZXRBMXdFd3FKbFZPdUpKcmlhamRkSklRZHovdGtHZURtYVFa?=
 =?utf-8?B?Qnl2dEZjVVRaekJGSEhIMXkxWUhHWlVzYVFvWjE5OGtqaGp1K3JrVTdiYUlo?=
 =?utf-8?B?UVRkcVp5YTNLeUdUTk5oVm8wRVE2WUwrU1dzdWRkbExyNmlzZDZNalZ5OTl5?=
 =?utf-8?B?bGlybUQ1SmMvUm8zSGxGUzNqY2lSdzgwb0hGalBGcDdzQVYyaHZSNXRSWmFV?=
 =?utf-8?B?Mm5LQmlwTVBSVEhBbjA5ZHJZVWd6MmZwNmZNRlRIVmFtQ01lckIvWU9tYVN3?=
 =?utf-8?B?OUROZEd0VWRTbktxdHBROEZQWlRhc1YrUXI5Q1ZmRDFkYm90WWZoWDN5bys2?=
 =?utf-8?B?Y3ZqRkhKSXR1QUo3RTdBdktySFQydHVsc1ZOV201SWFmUzQ2RlY5VWVNejFn?=
 =?utf-8?B?aGEzSnJtZldaS0FnQWpaTEZBOWJ5UTllTDZsTHNnQUZHN2duNUs0RENpb1N0?=
 =?utf-8?B?bm9iUEhadFJOa2J4NWdyUEhVSUludk9tVUMxSTVCZW5SOTF0bzFiYVJ2Yzlw?=
 =?utf-8?B?ckRRZWIxa0FkcGVNQVNtakppU3pjbk1IQW5YK2JOcTZLYjJja2ZJL0w2ZUdB?=
 =?utf-8?B?RWF0bHg1dndVR1A5aTRUaWtyN08wRlRIVi9vNzVEWlR6TVA2RzRUQTFqc01a?=
 =?utf-8?B?UFFzOWdTSzEwK1pDYU9ncVNEeWlMZkJOcWZ2dEhzam0wOVRDOG1sall3SUNU?=
 =?utf-8?B?TjJYU2tLMjRIUG85dmZ3d1VDaFh4M1JkK0JwVFRray9VZjlsczQ3MEp3OU81?=
 =?utf-8?B?L2NaWjBqenFKTnNZRm16bkxGNXNTSFR4ZUlnalVlYlhOZVVuNVlNUzdSSWhZ?=
 =?utf-8?B?dWFpRi9kY3pnTnMzSUdPM2xKUGJTaG85cDQ1U2d0T0xwVVh1ZlVnUGZZQVJG?=
 =?utf-8?B?SUp5WlpEL3pCNDB1N0cxaEtxZWg5eHRWWmNhUVdleEgyWFd3cUR4dXh2TnNJ?=
 =?utf-8?B?YUtVeEJid09JSThoRVlnM0x0MEpkWEk3cHNJTVRFN001RDJ6eDBYaVJQeVg4?=
 =?utf-8?B?MHdTRXQ0WExmbjI3SGZ1VTd1YWh4QURyTzVyd1g3eXZ4RDNqS3BSL2dWMVFP?=
 =?utf-8?B?VitvRXhrU2VXam5lR3dsd21aVElMWkhaOWNTSFJiL3grT1FuNmd3OStNUllj?=
 =?utf-8?Q?xZYvxAU5dE5/zReoKmrCaN0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5rjdaANMrVCrd01aCH+P8M/MJNMj56jizLrOn0FyH6oZRONRIosRa4WfWEmyyKq3q0BJRF+XX8+WnMcclcV6ZJA97p1luVhzZoXuYYIxCo9PZT2NoO/ew+e+K1LeyBNBafbh7hGf6jlDCpPULRQ5VlG/NSWtUa81OXnNc33gTYVQNyu840x/EZX6kvCiW+udOSRFefp5bF+rUBzcgpEOX1BwSGHY+jC4WRSQjEymZwKW2DDz/IZ8vn92PBRj/8AaNXVyb9sUDbDEpCUP12MMdcd2onEzuzuKsKsDLzqDilXo/Dj5JMNbPW0XuMVVaas/cEJzsHtpqZ6ymynQtcCTOGUdwoSfGwk4kZKoQlINC1VPRhwg6fGdclDhL+x+IY5rr7Qau60I7Y9fR3iFPg+dAO6tsvtMlqhCSSD8VKCL9/k9wlSEhB8hmfZFkTepmZof1nh71X3/yvJQJNAAM/Ech7RfcR4WVhx/aBbbUd0+F0aQH7xKp0vVcu/I/jjLzyqLXxWxhY2WCBDA1SFMAYXUkxZbJ1APnQpOhSt4q1g6G5OWZGg+AE2uQf328SazNm/pzAdHuqBZSptm8lKE0Ms/866XMl1K3MYXDepK0HHNRE8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939313ac-2b93-423d-74dd-08ddc96ac0d2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:57:29.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWSe67AEVFqe0RHofIhr1dvId+nNxLoenXiB39bBcQM1XBNeC2MN8Tu715bLcksIzOtqeuLHYFNnaZzktfmmDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_03,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220190
X-Proofpoint-ORIG-GUID: 4-CeD3ZOA2GM48TNY7WXEu0hwWe8yeb2
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=6880094d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=ibuxb2XGrpJyloXGDjEA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13600
X-Proofpoint-GUID: 4-CeD3ZOA2GM48TNY7WXEu0hwWe8yeb2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE5MCBTYWx0ZWRfX479GmGEgjOwf
 WctnzEZ9dZXINdM3y2cM+ayGO3E67mjPDT+WjreCwUT/WZdHm7otWSz67GrMGGGwqK1EVNyWq4O
 iriwpHdOoTrRX0H/hPcQJl28qd/3q2GNkS0VudxC5XAP5lNy1wLB8LII2XTKt8KEdVhO+Iv0w1g
 cUE4hZcVKrePjrmNIVU08WoOAM2SZxbr2s6Hl/Yi/1/SKu4b91zxFs1zOF8M7l4AM+P0VFYy8st
 wW28U6HAUUPLaIjB2PJTXvNuALI7yVbYXG8N4+p+yo3HibQ9R6o9MiNSgNURJEcQ3XJBQ7E1a/y
 clwZ6ZoFkV3Zmf4Tqr3YwWbqhLWQjxYaQJ7Z30dzcq1hTC1sdXkQwzjj77F710vzv56moAhhY9N
 GzjhysfbrAcGQsMydWTSgaWhXsFeKjL4IC4feeXEDpBYWsNQ/IlN7ofsTpsFhs0GuzR2Ld60

On 7/22/25 2:13 PM, Steven Rostedt wrote:
> On Tue, 22 Jul 2025 14:04:37 -0700
> Indu Bhagat <indu.bhagat@oracle.com> wrote:
> 
>> Yes and No.  The offset at which the text is loaded is _one_ part of the
>> information to "fill in the blanks".  The other part is what to do with
>> that information (text_vma) or how to relocate the SFrame section itself
>> a.k.a. the relocation entries.  To know the relocations, one will need
>> to get access to the respective relocation section, and hence access to
>> the ELF section headers.
> 
> You mean to find where in the sframe section itself that needs to be update?
> 

Correct.  Each relocation entry carries pieces of information like :what 
is the location to update, how many bytes to update and what is the 
calculation to use i.e., the relocation type.

> OK, that makes sense. So sframes does need to still be in an ELF file for
> its own relocations and such.
> 
> It will be interesting on how to do compression and on-demand page loading.
> 

Right, its an open item.

Compression (SHF_COMPRESSED) for non SHF_ALLOC sections  is doable.  In 
fact, debug sections use it already.

The tricky part is SHF_ALLOC and SHF_COMPRESSED, which is what SFrame 
may need.  This is currently not allowed in ELF.  Some previous 
discussion here https://groups.google.com/g/generic-abi/c/HUVhliUrTG0. 
Not sure if things have evolved since.

> There would need to be a table as well that will denote where in the
> decompressed pages that relocations need to be performed.
> 
> -- Steve


