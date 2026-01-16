Return-Path: <bpf+bounces-79237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CA8D30291
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 12:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C73053032CFD
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 11:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6B36998A;
	Fri, 16 Jan 2026 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KfO3D/5q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M9oj/8x+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55236C0CB;
	Fri, 16 Jan 2026 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561950; cv=fail; b=FEGFV1grZJT2pAF4A4FZpY4clBFYCLMLqS6qz9K9bUr8ENeWhLBTBtPmIcvxDq47VaLR7vZu105LlvsBg9o+Iep7B7AqnNsWLoYPTL0McbGphqMOot1F4Ur6hZx9t+ia16Yx7Roj3biyMHHQ1lQLYeEenuCJwe2E8//8hFXIt60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561950; c=relaxed/simple;
	bh=79WY8c4lnmHBlHMx6Rt5W1OQXk8yiU3WcB9vlmtQVHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HZPffM/nbJTr6Gu8BUDBmhYYHPO7mA0wBNnQym2rP1hD/PGu1Xcze0d6Lwbn4rSGyb2nLg0H4DsGLUi/FrFOzkRoKdH2KYuXXjKcTZjvMA8JfSTd3nyuGmZwyzDMr/MDY3fGn7qCOc5bkRLbEhFDX4+JT+TqPb45SGu87ODpf8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KfO3D/5q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M9oj/8x+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNNXMh1430609;
	Fri, 16 Jan 2026 11:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MFcOciIgGF80sOxycb7yd5Z0krS3zAFB2LnSgFM2E7I=; b=
	KfO3D/5qYiJAOKEbnvOLJZg/D51RVvNXEkiL+pbGkiwGO6xnlvM0SWgIuYQxuchc
	9lF+Fe+i/LkhFHvhcYR0RVv2mMUIo5Jr5gYJFyPC5hXSbzNk0OpQmTOlvqK1RoSY
	I92zzVOhdLFVWNNOsmWH5TTbd6hb3mA9qYjQF2egDX6afBmnUpqiv/OAHGOosyi3
	LlA3JHVdGEuJPU1gO3jFmHptN23c+YB4nvkOgWK48TcDJkSF8CV77Y50Z5VKRye6
	ecIpnDvIqsq3F0C6hLbrGbQlnbWuQIpzQ5os0DoHQBbmnzLphO0cTB3SKQFL7SA5
	DrAhqknjqCiVoeQrgDK4Jw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre41tta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 11:10:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GAheqw001924;
	Fri, 16 Jan 2026 11:10:35 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7crxkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 11:10:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJoAVTFSiBH+3oBssbwUjSyw68vqQmQDkEQpyldppsugcNNu96n/yXm3wyOZqpW3vISiVsJg5C7nluVYYhfqQipeLoJj9fThs1UAMEqtHcylX7D3v9A4TbpmvMXCwoHkNQZqvAN2d/Roe8/ovPdgyq3Mb4jIX5Iuf2kekNqvQwcDuHnmpWt8Tz8Ja6zYPL01sXrhdfFTaHVNpyvSTl17eDW2PxWgL79Ybsf8EzYDE69CArj3dhl4D5zGQxFtcDQKWB9E4lxgWIruNK7fKff/NQoDbnOyl5RX0UwSSEWlH3NpO6WQL+hTDDZbdR60wI8TTO01sjFdlJJvJPSsKJ7m7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFcOciIgGF80sOxycb7yd5Z0krS3zAFB2LnSgFM2E7I=;
 b=qfYy5me0ISTYLPq5/zuJQJHFgnJWnUpqHNSSthli6ewXrOXMpevjAl3gBR+VEt63MLxF/a5s0HeVmTdJzOoXNb+2HvHswQAmgxJWxa8hQQSQX0JfXP/L6GsxgXkxgYvDWWxwkG4RASngz+lOySOZiC0e/hjBN07GW8iqrmq8gOnokho9fogxHmBCjej7P8aT5LnDOTJhetFbxJct1EJQrH7ZncV/nS5Vc2FpFFs0tgxFjHUP/KfejwOxAsKa//vSbYbRoPf8PIqTOjIVYkfrZwwZlifYRQhz/FXsWLzvW4x0fkLYH3XZYy44O1akk+91f/dDCx6g6fYOoS5LyQ2UKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFcOciIgGF80sOxycb7yd5Z0krS3zAFB2LnSgFM2E7I=;
 b=M9oj/8x+qDJAM83dQ+V/thvSevlKVbQt84orFZMBy7zxcL0dxI0MPDSRwgKowfZVrc3skoZK5UTAR8ZDua4pud70z9H8Enkhf7AqlUaTh99axesXgqH/fNPUwKtCemjS+lsujLiO5u43xJ7f/OQZ8YY06ZDT7iJEle2uSMsuD/Y=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN7PR10MB6524.namprd10.prod.outlook.com (2603:10b6:806:2a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Fri, 16 Jan
 2026 11:10:32 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 11:10:32 +0000
Date: Fri, 16 Jan 2026 20:10:24 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, Petr Tesarik <ptesarik@suse.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH RFC v2 03/20] mm/slab: make caches with sheaves mergeable
Message-ID: <aWocoGf9kxVCgXmw@hyeyoo>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-3-98225cfb50cf@suse.cz>
 <CAJuCfpHowLbqn7ex1COBTZBchhWFy=C3sgD0Uo=J-nKX+NYBvA@mail.gmail.com>
 <4e73da60-b58d-40bd-86ed-a0243967017b@suse.cz>
 <aWn67WZlfnqcWX46@hyeyoo>
 <bcfe8618-b547-49fb-97e8-e57c2fb4b7dd@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcfe8618-b547-49fb-97e8-e57c2fb4b7dd@suse.cz>
X-ClientProxiedBy: SL2P216CA0090.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::23) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN7PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a842fd0-b892-4ab2-2a07-08de54efdd39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2hsd3FUWnI2YUdmNGpRdmhzOGdkSE1Pc2Q2c0VRTnB1TXhyRXJtZDJSRmxy?=
 =?utf-8?B?NXNoaGMybHo5SzRVTDRPRFJZSGpIbzdSUWtrYW9oUExEWGFjVHlLVXRJVXpl?=
 =?utf-8?B?dzJiN054RWtMYUx5Mm4yZlpSZzFCajgxbG9JS3dzWVJSeE5SZmFSbEtTeVo3?=
 =?utf-8?B?K1JwbkZiMFpLamFZM2VUUERVcTluYWpZdW1pWFV1ZWkyQlE2Wkd0cmJ3bVcx?=
 =?utf-8?B?N0FyUGZHMUluUkZYc0s0cmg1WnZHNkNmQUJYSkxqSG1vdmVibW1GZGhiamE3?=
 =?utf-8?B?R0o5TkRyRHYzUkR2T1R4blhsZ1o1d3lCZGpxUzcvVC81RHg5UHFaQU1kMk1h?=
 =?utf-8?B?aU45RWlBSUUxT2kwM0tldDhaVTBsdXcwbDlvMHRGZHhJbkVyTFlnbitSS0FK?=
 =?utf-8?B?T3VTb0huWnpoaC9HKzdwSXZqZHVaQUxCcy9raWk5Uk5QcG4xZVA0eTFYTWNr?=
 =?utf-8?B?WEMwcEJmNlhnUnB6dk1DQjVhdXpDOW5HekhwaEJpRDlRMHhFYTVxdWxHSUc3?=
 =?utf-8?B?NkMrQ2VZZHpkNGMzMU1CY21Na2svU1E4cnBJSVRwaDRNbnk4eHJJV0tISGJP?=
 =?utf-8?B?bXZVYmxaQnNHY3EvUlN4WlNpRXRkT2pkWFhqU1ZuWHM0QnI0UU9RaG44ajU5?=
 =?utf-8?B?NlNqd3YvMk5aUkovcEFLc0tLeStrZlRPMWQrNEFyczROL0FreHVtNkxJOEN5?=
 =?utf-8?B?R09haXptMVR2Umk5MHhieUwrRlVkV01NaWFVckpYNTVlUnUyN2RpUnd3dzFD?=
 =?utf-8?B?Vml3dEx3QkJ0bkIyYThiUjdDNFZ1TlgzR1JhQmFNVklqSjlncTRLVWhWeWQy?=
 =?utf-8?B?TDVtQzZhZWpxdEo5ZCtIRmJURTFDUGV4TUZneWpCMnFSOEtteHFRNXBtSUYv?=
 =?utf-8?B?Uys5OVF5SXl6Mktqamp1dFptUlc0MVRwMEtZUEhmclROYXBxai9UTXR4Vm5J?=
 =?utf-8?B?bW9Gcy9BRTZxRHpPbGhvT2lLQ200OGJ5d2ptdkpPSzVPVDVGRjFKVDZtUlBI?=
 =?utf-8?B?YXZuaWhyeEpoRjB3L1loRnhJQ25XbnVJU1FWWEdrY1YwcjI4c01raVhlTUpi?=
 =?utf-8?B?K1VXdlo3S0FEdGUvMHJoeFBraS94TU0zSzRNWVlxRUdHVW45T09hQ0ZWWFZv?=
 =?utf-8?B?ZVU4Yklyb2JJbHJRMm5yS05oaGlpVGhWYU5PYk12V09iUXVoQWpoSm9JSFpR?=
 =?utf-8?B?N1ZmSkl4S21KSlNKUTVZY0RSazd1SjVDUzJSWVkzZFBrem5WdnU2REpNZTdz?=
 =?utf-8?B?djNvdHlrL3hiMFlrc0xnck5yR3c3dDV1NnRSa3Zsczk4UGtFbkR6dGFDVC9V?=
 =?utf-8?B?RkJsOGl3dUxEZXpmNENrZzNpZDVETkZacis5WElzUm54dEUwUUpIR0xtNDA0?=
 =?utf-8?B?cGJqMnNvcVk2aE5Jc1BnbEduVFE2LzU1TytaYldvNU5SQzJpdXRCWFNza2JU?=
 =?utf-8?B?bmpUcWRreVBRQ2w0eTM4cGdQbU91aXRNM093NUJJZ0dJbHYyTWs5b0JtVGpL?=
 =?utf-8?B?Sm10TVk0VXBQSUd5NEt2Mm54RHpLOVl6VnFlRkZ3NFVWWkYwRVFEa2N2RVJZ?=
 =?utf-8?B?a0FjUnNxZWVaMHBrbVVOc2dGNTdYVlNrTGN2MVVadGlITlA3blpPd2dSdHNB?=
 =?utf-8?B?L2ppZkptN21GYWpqWjQ5eG5SL2FOZmtSV1VhT2FNWnFYVmZkemFQdEZtdHdm?=
 =?utf-8?B?RzNQaGFHQ2JnMCtLQ3RvNldPaTBGRkRWOXhEQUN6R0VhKzA4Qis2VCtLTXdy?=
 =?utf-8?B?MDAvK1JSdkdsYXp4VTlGQUhJN2xFc3ROZ0ZOUmNuTzQrNFdseTVoNW05YllS?=
 =?utf-8?B?YmlhRkQ0SlpzYnNISWJEbi9XVGJRdUZldXBzakNGelhDazhpRDRjYjNJMDl0?=
 =?utf-8?B?MERHRUwzYi9EVjMxVUEvaVZ5ME5LWEl2czBsZlV1REdjZHJBcDA3WHQrOVhL?=
 =?utf-8?B?Z3dJQ0tlV2xQMmVqdW5wRUlmd1lqNXlpVmdhS3E2R3UvNDdkWkdwVmVrenl3?=
 =?utf-8?B?SXlSeGhQbmswSHVXQUpOUXR3Wk5zTXA3L0ZVcHIybzhFdnlKTkREWkhWQ2NH?=
 =?utf-8?B?aDVMSEdvVnZhYkJzNDNROHdXVEVnOTJja0RORmNTN3QvNzFsamVZMVdKWWtF?=
 =?utf-8?Q?R6CU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0ZJc2xtOSt1TmxqUEh3aXR1ZzZCTG9pcEY1WmpRSndrYkJkVXFvNm1WNmRW?=
 =?utf-8?B?TURGTzlZejk5TDBFSm52d0Z6Qk1zM3RuZjUvNFhUS2NzM09QdExETUoxR3JG?=
 =?utf-8?B?bGxXNEVXUjFmOVlKTjR6Vm9ZVXNhSlVYdHRnYVpEd1FJOE1MV1dQN0J0TGNZ?=
 =?utf-8?B?WnJ0M2F3aHlvWTJCdTVpdlJBUkpwWXNINFluRDR1L1F3a1lqQ1N2R2ZCbnRL?=
 =?utf-8?B?M3FGTkUzamo5WkVySDh0UU0rbXJmY2hnWHdyWm5heHF0Z3d4aHFQbkxkSUJy?=
 =?utf-8?B?UDdyZlZKbnd5V0xRWVc4b1B6T1pFM1QyM0tzajcvV0VxajVmY1BtaVppb2VR?=
 =?utf-8?B?Ym9JbFlZV3NqYzNBTk1md3dOSmNTb0FmYVB1WGVBM3d2RDFsc2drWkFncDJK?=
 =?utf-8?B?S3lHN3JJYTZvZTZFQ2hwZ2dZVk9yQ3BFZ2MwV2NLVHhHSVFqUFBxNDZTTTBi?=
 =?utf-8?B?YzZlNGpuZHJ6azZtMnByMFpSYk9TOHhPamlqWWJXSmxETVE3bHM5QklEUFF3?=
 =?utf-8?B?UkpDNUVTU1YvVVlQaG5OZ053SG5MWkFEazVZazJXUVltdUlQdXRaRTJnbFZa?=
 =?utf-8?B?Nm1wZTlSQWtpM0ljQU5odzBhNzVZUVZiOGg2YkV6cDRmMDUwbE1FZ3VIU0lO?=
 =?utf-8?B?RktWMEdacVkzUzdVRUgraVRtbmZBV0Z1UXBsTUZZN292RWRVK211U1YwYXBR?=
 =?utf-8?B?d2thSXBGMHdXVjROeG9ESjJXQzZHekIrVE9Reng1OUZpUUtmT21MYTkreXBv?=
 =?utf-8?B?ZmhSdDBDWkNmUFlxOVcvQzZRY01TbDlMMnRvSDRVVTdMT2dXMVZVMmpHRXdj?=
 =?utf-8?B?TVYyU1lGdURVY3RyZitSelZhbTBoZ09YVjZrR0lvd0V4OXl4bVZlOUFtcnNM?=
 =?utf-8?B?TjU0Vy91a2dPcFRrTDRqbUhoRXZhV1JReGpFRkR3RTEvckk3bzVCdDIwTWJF?=
 =?utf-8?B?SEk0WE9pMjVvTm9WTzJnT25HK085TXFheENvdWN2REZvNUg5YW5EamtydnpW?=
 =?utf-8?B?VGZRYkdRWDRvbUgwc2pOUzVwbDZoNzIrbDlJZnFXVU9JalZ4SE9ka2JCQjRF?=
 =?utf-8?B?R0RiTlJYRHlEOHM3ZEVSWS9mZDNHaGVWeWRXTCtBWkttWVJ5eldHQ3p1M0pT?=
 =?utf-8?B?eGdyRnl5d0hPQ0hPZEtPazlZTU5kYzFBS2pmdnJFYUFGRE1XWnY1OGdpOURY?=
 =?utf-8?B?NjkwVUZqbnlCSHlBZFVNVmdmd2NkWjFicDBTZTJuNVd4aEZLaWNzRzZLaDlG?=
 =?utf-8?B?RTJmM2FodW9iTkRjUGwxQjNuenFUR2JoVXZQb3VacTRiK1NaTXN4UDRWL2pN?=
 =?utf-8?B?UlJUNmRFZ2o2cjE4RnF2TjY3YzV5RlluMzVSQUUybC9WRDErOCtuZmJjRzYw?=
 =?utf-8?B?MC9YQzdJQ1dtUGhpcFpHM3Y0QXhOQWhNZkFVVFladzRJUkJaamc1ZXhtczkr?=
 =?utf-8?B?SVlzSnVHdlZQMHdaczIxQkxkaTY0UE1CaHY1Nk85bUdtTGIvVU04Qm10MFNj?=
 =?utf-8?B?UjcyZk9KS29tcy8wSUFDUkNGc1V0WFpRSE5pZlNNNzgwWXgySThrMkgweFlR?=
 =?utf-8?B?dlpGVlNGZFIrOHZVdXppcFlicGVEMkxpVVRRUyt3dFlnWEhXT1cvbVg2YnpG?=
 =?utf-8?B?SWgzUnQxcDkweGFpTGxBVDFXZkM4Qm9zRDNiWGFQWE1NVitETnZHbzhQNTUr?=
 =?utf-8?B?UTk4T3JuazNGL3U1SWQwSDVMWjlUNVdTZnB3Y3dPSkNwWkVZMjFmRjMzdWFo?=
 =?utf-8?B?Z0pLNmdzUENpbDRaYkg0eGd0eGtNTVZjTyt1Ry9ZUHhqQ3lvU1RtM1prMWVE?=
 =?utf-8?B?aDhSN3paanYwUGo3SGdqZFg2b3FUYWJ3VkEyMDd2cnNiVmhxSkVOcG9vV0FG?=
 =?utf-8?B?bGx2TU54N0NSSkp5NGROUXB3Z3pXZDdLT3Y0ZGw3aTNDT1BDNkxUVGxDNWtW?=
 =?utf-8?B?djk0TThLc1hrN1FudmlSYkNqQkVkbEJhTFlMOXAwYy8zbXIvTk9ycG9sdFZy?=
 =?utf-8?B?T2xPbWdyVlFicHorazFMaHc5cHBHemx6TnF3Y1cxZkk3NXZsbUJ4cmtSOUhW?=
 =?utf-8?B?Qk1HVnVYVHdwL2JHb3ZuMmtqNVU0VjJOZy9saTRzSkRtRkZhOFNEeDdwbm5T?=
 =?utf-8?B?dE16SXNGbTV6ZW4wZUsrRlM4ZDZISDVJN0ZiWFdDV1RtR1RSNUVWc1RyVkdO?=
 =?utf-8?B?YWYwaVJrN3NXajhxbklQOWZpVzM1TXp4U05FVVFGb0NFSWppQnlXSWdhclF5?=
 =?utf-8?B?N3NBTjh6NGdyRi9RQnlyUlI0TDdIQTBkYTVSQ3pxYUgvREV4eDFkNzFsQ3A5?=
 =?utf-8?B?dk5ScURVanRxYUtxUS95RlpnRmlKVWNnYUlKelpNcFNsZUNqSDVEdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z01Heo7xgMHoH6Kg8A4WTu02sAZQ1B+OkxOOskz5OK+wmZGJtkRK9aVp1KpgRrcVlrpep5H9RTBv5whnVecON37q22Sx3qsIF4xqZOmAJ0laTLDRFMJ5cv9FNthlk4CEN6Uf5Q+EGP2n4lTe/JcB13k36DogKnPIMf7K+F7hiK9PGoSlqEQcqwLJt/gnAh8EnMrLGEumqsLrA9MYdzbfEV48SE8o36gaKpgYkn0/1Ihw854VtqJJ5c0xYC+GQbsq4HPWQYDE/RLD978+n/AidqU3XtuTayBAbC/HHQ55Z5IqJziv0lKHwGzRzf8ndJcNOj9Sb2Rk2/dFMw4wHhg+HnVguCTVQGT2gHZnfDGTCDjJBaPzxWxpO42GiIBg9lPax45d1iiWdGbTHQVXAln2uQ+Tvx9k/D2HA/ZM680tRaz6PjyJi8Yibkt2vqcJzSb6U5T1WZCoj6CgdjKAU11OLCXPeqzc7wABmNAy7YqKTWikWjhYJd5qPtm6sThGAsVZ544067137xkrdTuFusnZ2dc01Ps2n2bsCkgwERPy+T18aPhoPEh4M53hwm4OSBzoiWLDsONlZ6ZIxj+XpEIXMVzfKdo0+tBeOarkpzkaWis=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a842fd0-b892-4ab2-2a07-08de54efdd39
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 11:10:31.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRxCiphmWCLjszFJhLN/m5C2KuKXKB5H7onHxo5a/9kkiVV8g+YyQqffVRWVy2M/8NQYOHcZTk0VNviCZxUyHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=817 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601160081
X-Proofpoint-ORIG-GUID: eYaJvETGNgFNCj1wH7YjEknSGsyjgPZT
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=696a1cac cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=upZhuagyiOtmtqMZmxMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA4MSBTYWx0ZWRfX7pD6x5ds6pL7
 pYzaPEZwBXZThATyajwxzmA9SueBhcIklCLG2xfbDvauV6uE7+pczRQ5UARNo8l1s8QUkg2aWob
 UAUY8ZIm3+IYJ1QQY6qJR7/50xH0PJaG2fwi8XkFREt1yNVSEtfp21H2WB7XhpMcp5Tzr4dv00+
 UUsUVyj/LKYO8bjVuPnuc0tOwfXT03SxDq9Cy1VkBST6RnwDroipdqw2jHhKys4JIX8ZydswuJL
 o/zQESMPv6Idg3JWkWR+SxRbexS1TVz4e+pWoDFvsUeysxXehdQbf4pF1dCWIeFmmHKKxdx+tDD
 Z7tSXbcMBsP56DBeJInNQ5mKH1hXX29pUyxwlKRGAg4jDIDzU4uqnuIO2pmeAVXlBbR+GmUB8Sb
 +8zXtX7MEhL9XWq58W6B01jlWLpQJKwLRlE4D+sssYPE1rkO9C0l0c0GBi7+v+WGyDVhq76QSEr
 aaoAMHMUKcnHSvngz/Q==
X-Proofpoint-GUID: eYaJvETGNgFNCj1wH7YjEknSGsyjgPZT

On Fri, Jan 16, 2026 at 12:01:23PM +0100, Vlastimil Babka wrote:
> On 1/16/26 09:46, Harry Yoo wrote:
> > On Fri, Jan 16, 2026 at 08:24:02AM +0100, Vlastimil Babka wrote:
> >> On 1/16/26 01:22, Suren Baghdasaryan wrote:
> >> > On Mon, Jan 12, 2026 at 3:17 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >> >> @@ -337,6 +331,13 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
> >> >>         flags &= ~SLAB_DEBUG_FLAGS;
> >> >>  #endif
> >> >>
> >> >> +       /*
> >> >> +        * Caches with specific capacity are special enough. It's simpler to
> >> >> +        * make them unmergeable.
> >> >> +        */
> >> >> +       if (args->sheaf_capacity)
> >> >> +               flags |= SLAB_NO_MERGE;
> >> > 
> >> > So, this is very subtle and maybe not that important but the comment
> >> > for kmem_cache_args.sheaf_capacity claims "When slub_debug is enabled
> >> > for the cache, the sheaf_capacity argument is ignored.". With this
> >> > change this argument is not completely ignored anymore... It sets
> >> > SLAB_NO_MERGE even if slub_debug is enabled, doesn't it?
> >> 
> >> True, but the various debug flags set by slub_debug also prevent merging so
> >> it doesn't change the outcome.
> > 
> > nit: except for slub_debug=F (SLAB_CONSISTENCY_CHECKS), since it doesn't
> > prevent merging (it's in SLAB_DEBUG_FLAGS but not in SLAB_NEVER_MERGE).
> 
> Hm right. But I think that's wrong then and it should be there.
> SLAB_CONSISTENCY_CHECKS is enough to stop using the fastpaths (both
> before/after sheaves) so it should be a reason not to merge.

Agreed!

-- 
Cheers,
Harry / Hyeonggon

