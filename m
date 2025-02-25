Return-Path: <bpf+bounces-52496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC4DA439DD
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 10:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5DD3BACA0
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23799261398;
	Tue, 25 Feb 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="orXItYsh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m3in/Q6e"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB667262D04;
	Tue, 25 Feb 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476187; cv=fail; b=amitJUTK3D2Z+DAO/Euxg6ia7XZLwWrpSKAXNUMoiE1/OFdwh9izel8SVijd9jWx/qCLojkiuY4nF04RVoGEiRFakTY0mDJ93XqQw4i5Dxybv/13/45mu1I8TqXeobwK/knQivhgnd6k5DcX/Wr3URZPC8bgyvrmKzhisdFbtyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476187; c=relaxed/simple;
	bh=pXqFNKcyRDQLBn1cBPfTU+B55RXfE7vV0C/S5E8EwG4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ts8dNFGUWbYCpP5+iBwkP8e0pCUPhF/odSD8d7vjHtUNwGyuAW++iMHKNbtZqHU9pYyxIuLaHN7RSLYc9TlOv2SIa4y0hYBf4UfkGitzoVcJedBBcV3lkHzFnVFTJ1S+ZI+hMbFjH5ktqZaPHMpq3dYXbN6Qg0xEP/4De4TuM4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=orXItYsh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m3in/Q6e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P1BewD001574;
	Tue, 25 Feb 2025 09:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oD4xQD+w7F0pygpNDRyrOlWh2j0ClWU6TIWYH2joVEs=; b=
	orXItYshd2BgPO8M7geZ+7jq/zH4kGngiaeL/2RpsAxhMFVHc3AcKFimfTbSKA7z
	hR0pTIRCWg8djb9wkh4PYEhcVVItq6KkqhsJ8PYQ14ozp3XyLFVHauSHWmazmUFp
	rMEijUOZbvGUYdJRK58L2acbyKOXhFVyY7Ixyb3dj/Wbyf9CMywwmXcrXCo/5fid
	dDXcxUGAPREPswT31t7Kc9yWXd/u1gPnNWwCY7EZUsaAIeHTz3COKfN2mNDG0d2Y
	50eI3mG7YRxSAm/ucwjQ+Hs044MkIxtA4INbBh631qSIUheEFJ3omsopnjsDoazV
	md00WLUopKv5KZsoIavkZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5604mm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 09:36:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7saWw025584;
	Tue, 25 Feb 2025 09:36:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51fec9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 09:36:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GicGgNDhRcM8pe5TOT03d5Iwsu6iBLrNfxKCLv+1GY1Xj15SvXyYOV2GdAuqqicB8mA7+dqdFUC2Qm1BUAskrTuPZCtyIv/bYox46mbqk1KlsMckSLuIZv/Y4F9JVnA1j7ydqULINJHSlSHcdfML935J5hRweCyLi/rBAH13MlIJkuqPJtj8dlgw8xwYZKht5vIYGK4cAHljyS6J+6sYmlGitAway1eKS/xRv3aycVTVvQQrDAeimDxhIxsPZfltq40yQL/hU1d9jdEbU70m7Lnu8kGKN3GGSiedPlmWQ2UMZiAOypt8xC8+ZpZwsP51FQ3J3mbsxlMD2o7h3UhYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD4xQD+w7F0pygpNDRyrOlWh2j0ClWU6TIWYH2joVEs=;
 b=jM7fvcqipGGvWoNohC+plTqUhECKPcFDIbedQQTCWlX36A5cnpn3xwj4Dk6WG7fTg47tcm69l5PKHxpUawCoLlo/HxY3jHmFIWz6MuGMOS1T/75hTaTrGu5J9iHF52a+Qr9WtQq+5p3UeF1GJ6ItR0Dnb0g/U3p4Jq0Y8/FJg7ic0IzVSQBY6IIeHeRjE7F3Im1PeTMsA4Mc1I083yaRpGfLZCx6QyPOfN6RQ+9tQ8O4TLvL/ZwVxVKXH4icUMJWKIwiZ54hsOIs5t7zkuLnvgoO+1a5OK3Vrlyex44iREnH/acjsI2ospFj5m3IGNdMSndGoZvlfRM4i7olqakjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD4xQD+w7F0pygpNDRyrOlWh2j0ClWU6TIWYH2joVEs=;
 b=m3in/Q6enjkXmZktzpt5sPF6DF0+03G7Wn1yX/oNwYx/16s3fQ5JjbZ55TlWrEXb6XMuq1ow4mWjtFeThdno1mOJmMtP7cRdJ2z1RpABdVg73e0hITaIMokKJu/OHXgVK0/eOBYTKoS12ZUqnXslco6IqB3Zl+hlW9znSJgNSYc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6029.namprd10.prod.outlook.com (2603:10b6:8:cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 09:36:12 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 09:36:12 +0000
Message-ID: <deff78f8-1f99-4c79-a302-cff8dce4d803@oracle.com>
Date: Tue, 25 Feb 2025 09:36:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/4] btf_encoder: emit type tags for bpf_arena
 pointers
To: Ihor Solodrai <ihor.solodrai@linux.dev>, andrii@kernel.org
Cc: acme@kernel.org, ast@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
        kernel-team@meta.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
References: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
 <221ce8b6-fab9-4f63-813b-6bd83dddf1a6@oracle.com>
 <f3b456f90256379d583f58e0d6fe2492d46eb866@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <f3b456f90256379d583f58e0d6fe2492d46eb866@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::35) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e5676e-3d5d-431d-d414-08dd557fd7ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3BVbGZITVZqRjdJeXJOeFdRR0xiRzdjSk5rQ3E5ejh5WUI3WU1zWkJXMXpO?=
 =?utf-8?B?MG5BQjVsRzF0VmJlU3gvaWNIQWZaWUdEQS9VbFIySXNTODhyK05pZU5LMGpj?=
 =?utf-8?B?ODcyY2VSeUtkdkVLRmxzNkd4MDA2dk5TdTFQcjFYY0NoVGF6eUNBc2FvNDZy?=
 =?utf-8?B?b01FMXNPU1NqZmlLVTBsc21Wbzk0Z3VOcEZPeTZnQUo5WkxDdEZQMGhPNWhN?=
 =?utf-8?B?TjhaRG9POVJadXBXSHM3d3BYTzRRVllzYk9JRmNweFpPNmtnTG5VWVdtTHE3?=
 =?utf-8?B?LzRkbDg1QURidnFCMHNpOHl6OXRrK0gwdnpzQi9nOHpycHo4WU1vc09Tc2Mr?=
 =?utf-8?B?L1JHTDh5S2hwcTN5SE5yWTJaNEZEdFFGYjI5N1ZtWmNvcWx4a29TNWlHNFNh?=
 =?utf-8?B?cUVTV1l3a0hCRVd0ZXozdVVZVXlDeURacmdCWHdUdEVWOGpVU25xSkMzSnV6?=
 =?utf-8?B?dG41UHREQmdOaWMvS0VENnVGYlNQNTZvZXhlTGV4SWtkNDE2TzR5R09GaWxx?=
 =?utf-8?B?MktsckVjdWtFWDZudFBybFdXVWo5d1FrejUzSzVIOVBWMi9Ob1V0aHUzd1Bk?=
 =?utf-8?B?WE5FS3JtR2l2ak1xcGVKcHg4ajMzZXh5OE00K09vWGVIcUE2T1l3V0NjWThu?=
 =?utf-8?B?TmRydnhOcVVmVHhKUkRXMEk1VjdPYW1HV0ZFc3QzQk4xeG5lUFBVQ1JnbUNv?=
 =?utf-8?B?dGNLUXBYRFBTb1JSbjRJZVZpUHRWMGZQa21QQXBya0g5ckt0Y3lxNG5lVXBs?=
 =?utf-8?B?dFVzTmY1WUlxNjZnYS8xYVUzQ1E1NVdNcmNjTDJwR09JUXZGamRsUXVBMmZY?=
 =?utf-8?B?OGE1SWRyUitZVWZQSHdVa0JwMmp6ZUUyZTd3SitxSWdsSmhjNzgvem54NjEv?=
 =?utf-8?B?TWJsTXZONklKaDgvaW1LaGlidlFoS25ONFVxby9UTzBpb3pYU0t6RzV3T3dq?=
 =?utf-8?B?Y0NPaytEWFBGM25CQk0zR3RXVlk2dU52ZktXN1RSMkZ1VjR5eFhmNmltVGJQ?=
 =?utf-8?B?U1FXZlFpUmpDRnNzYUFZaE14bmRSM3dFUS9PQmhyVUJlTkQ3Mm9GS3ZSRmg1?=
 =?utf-8?B?VVRUaXRXVU1tKy8zNVVJOXhveVJqT1FPaUllOGZxczdBMVdUcUR1M2hJS21z?=
 =?utf-8?B?dlU4M3dKVDJaTGwwSUEzcno1dXBiL3plcWR1R2FPcml2VnhyUVJEdjY3R2JY?=
 =?utf-8?B?OENYYndXYlpBTnIyZXIyN1pDVHArWkxpNE1JeUtCK3RFeWN6N2lpaEFWWDJU?=
 =?utf-8?B?bE0yZ3k2VjIvWWlXei9WMXNrMDlSaTE2SmtleDY2aUFlcm9UQ25HazRDSFFu?=
 =?utf-8?B?UEwwZG5HdXVXenZaWGNEVHJkUlVoMEN5RHgzZUNIbG9WS3VuQ0xvZk1WWVgw?=
 =?utf-8?B?MXhMN3ErU3N5YUdwOFZWQ21aaVVieG9wWUFLV0VsTldsZ0tvaGNLRXIvZTAw?=
 =?utf-8?B?YWFVc0VkWDVSZGhuWmY1cXZja0NOam5iUzhReWUrMlFZaVlHMjFTVFRabGpz?=
 =?utf-8?B?cWpUa2drRm5Na0g0ZWRUSjQ4K0EyMkJrUXRLVUZFQVlNUlZzNmgwd0R2c1RR?=
 =?utf-8?B?WGZCWHorbm15UEMyYnFJOW1FRlBhNUovNXdLY0x1eTlmODVRQ212VHQ5MVgr?=
 =?utf-8?B?d2tBaXJGTUdBZmVUbUY1Q3huNE9lcDN1dnNZb1dlN3VkMGI3dkFER05DN0Va?=
 =?utf-8?B?QU1BTXVnbmRRRGNsdmp5aTdoYlY1WTB3NnNrbkhFQk5MQ1htTDdabkk2SC8w?=
 =?utf-8?B?QmJ0Mmc5L3RaWmg5ZXh0ZjdJMkQ3bXkxc3JwYnFlb05pUXB0K3dPSUgwOEpC?=
 =?utf-8?B?ZlY2L1dBdU43UXduU1hHU0FRWkFxSGZCZjU4Si9oUXcxMzBtK2NGWCtlWW5q?=
 =?utf-8?B?b2xsUHRJci9ZckZtL016VFdtRG1USjZUcFl3aHhna3JQNEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjdkcDlPazdrT0lYdnk4anpFRFFjN0FvNFNPYnpSTFNJNXhHK0JET0RuUjBZ?=
 =?utf-8?B?RFVLVG1UQnp6MS9BT3V3VmFnK2FJMnREVzNXYk9RS1J2dEZnMUVUNjN0Y1Jp?=
 =?utf-8?B?K3JBK3ROT2xqWXIrcW9FNXNISlEwMlFON2tkUjRXb2RPb3g2QXBwbnZoUDJy?=
 =?utf-8?B?alQ0akZsS1piOG5ZLy9UbFJXcmZ6eFpMQzFLRDVlSTRoUUVNdzh1dCt1Q3g5?=
 =?utf-8?B?MVlwcCtJNHVxbGo4cWoybHVsSnJNbUZZVU5oeW50a2NYbXRVbTdmNUJ5QnJ6?=
 =?utf-8?B?QitsTGF0VzYyOWpUNWhQZUJqOVRwRlF2WEQrWWx4Vjk0TzFDMDJiNm5vNSt5?=
 =?utf-8?B?Uk5za0lYU25QTk52YkZYU3ZxZW5iYzFvbWczSWJMb29VRmd1dmt5cHFmLzRH?=
 =?utf-8?B?TDdyMm9TWUlOMUt6TzdzSEJxTUFTMkp6TkcrenBUaWNqTzdoSmlZTFVYQUF5?=
 =?utf-8?B?UDFoYnQ3V0Z1UnYrTkJaWVFyUHYzbjhKNFRPVkdIR3cvU1h4d3kvRFQvdjBr?=
 =?utf-8?B?RDhvMUhqNEM1QkpGOWRHZnRxakpVRXBLRStPVkYwTmNpUEFEQzRGSExTbEl0?=
 =?utf-8?B?NE9XYitZQmFlMWpxRU1WNys2SkJraGs4SG40T0hkTkFVOGtpNUJxelQ3QnVT?=
 =?utf-8?B?dGRNK1dCVHJUS1hqd25HL3A5S0d2WnA2MWVteGJDd29JNjRrb00vWDdoZnEy?=
 =?utf-8?B?alM0bHEvNitJdm1BbUpQL09qZ0JFRTJMZ2pXbWFsZktyL3NPOEhyTlBnUVRu?=
 =?utf-8?B?V2t2bkpocHJleUQrZDVORXI1NlF0bDFVV2RmSVJPd2JpY1ZyY1lqR3J0U2Fy?=
 =?utf-8?B?bGQ3RzRsc1NqYlNnVXZGdDRxUUY0M1pzVFB5SkZ6L3BMZEtzdjVzRFZpMEIr?=
 =?utf-8?B?Y0VpMHNoLzYvMXdkWC9TVjdjTWxpb1B1STZzNzlxZ0ZpMlhpNjh5OGhpQUF6?=
 =?utf-8?B?aW1jaW9ZQjkxUjA0bFhoMFhrTjF3cWhSZVZoSVd1WlpKYzRLRjU2OXQzYXli?=
 =?utf-8?B?VkZyNHQ3YjlUNnc0UHVJaEttc3hmdVNibEMxZEFOemowcTl4cXl4VTdUTWtC?=
 =?utf-8?B?UFNrL3I4WDY0MURqNmtNdVJTeWRDT3o3VjhUSnpYanNiKzBhTTZwa25RQ1k0?=
 =?utf-8?B?SFdkUDR3V3o5dm9NYTMydjdpMEtOa3AvbEsrYjRiUzRyWHFaY3YycTkrdU5j?=
 =?utf-8?B?N015MUc2Q3FUaW5RN3RLakdxaUgzWmxXc0FjMDk5REVUaEo5Y1pFWDZFUFl0?=
 =?utf-8?B?Skg2bjdLbFBaaHdmRHNFdGhxb1Nlb2JmVU1CaXI0a25GUUFMbXhDNk93czVu?=
 =?utf-8?B?bUtlMWJJZytwV3Z2SXVWcWVka0oyd2ZNa0ZoQWRNbzV6UWREZ0JDelV4d05y?=
 =?utf-8?B?dVNQOTJhckxiVTM1ODJzYXVnMkhFNlY3ZmVkb0FocHhRYUk5dm1vL1pteEJ4?=
 =?utf-8?B?WXJPYmtCMlZvckRoeHYvM2d3LzVzaHdhYkU1ZTg1U0FGbmVrb0pzRGVMRW0r?=
 =?utf-8?B?dXA0b1VhdmZvZXRSeVB6enN0elVnd05rY3NpSm9aWWdDdjJ5VWpqdzVna2l5?=
 =?utf-8?B?WVRTZVdneE5uL0JSTWpXV2d0L0FPK3VscktxMjMvWnE4ejZMNXUyMXBqb3pI?=
 =?utf-8?B?eVZKR0J5UnZqVlJZZHgxMlE4MndEMEllVC9SQjBrVWs2ZldBdGhHalh3TGQw?=
 =?utf-8?B?blhyQitna05GOVJ2R1d2d2dyRXA0NGZpa0laNVBTWS8ycEpkbmRTRDhvQ2FX?=
 =?utf-8?B?Rk5VSFNOZlpUQXFmVWI0aHJkd3JURTdRUVZZZFdVRTB3MkFGQ2dNOHRRejlT?=
 =?utf-8?B?VEFZbzZvaC9NMUFNR1VWZjJKT1lwUlF3TEFqUVY3UDJ4UXJVemFYZXlqcm9x?=
 =?utf-8?B?T3ovMUZNTU5rT1YvRFNpZG1HSzZ1UlRoV3ZOZEZCZk0xcXJvbzVFcmxFOER1?=
 =?utf-8?B?dllGNkhSWDd3OGZ5SzFQakZRUGZmYU5nRnFNWFdBc3ZDM1Q5dzlqZS84Nzdu?=
 =?utf-8?B?YlhzK3kxSmNIcG0rTTRDWXgrb0RQeTkzNDVHdHhWODZaS1hYb1VSZjYrb2pt?=
 =?utf-8?B?VWh3ZGtsOUl0SFljZU1LKzhhR0tJOUJEa0JyekJXT2VsQmpiL3BoTnMza284?=
 =?utf-8?B?bDBJVzhUNGwyaW1leFdkejh6YzROcm5tTVZFSEVKSjRnWkF5VDNlUTNJcXA0?=
 =?utf-8?B?QTZWSmF6V2JNdWo4ZTk2dkhvYURPWlBjdTBKdnl2ZzRKOVFsNm45Q0F2endz?=
 =?utf-8?B?ZVZrcWEwVXJSWEl1dm0xQjFSaVpnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P1UTskMcTo/4I0rEnrHkZnbbeOO4ag0a33J4ToY6A7JGLGa7isQhRlahXwToI7fYBJLM9ZYW6FGclLxIskwi3uTsPJj0+5S+lFlvv+fr0+0A5Oo9Ij1cRXdAoUsDBe5lGiBypxx8LljuCcSAL00/CHBxjP3V2BpAxsA7o8pMecSXAaw23x+dw8suU4XiTdjmmezPksIinukquanC1VtFo9jP/GPyf4hDkef+qBFEAPSwyVi89m45DJLEc2PgX1sB9ctv3fNQC/pkDsk5s4kKvMDchw+pE3IxMQ7EDT7pBLfwRJUPAsFStBjTv0gHVFP4BiF1XdXe5ajEJVN6sYqnc4nAJDikfQkjJ9zL7g46cNupJ5ZZPuBkvq0UyMboMODWDaOG0JTM7WjQf2bxYg+1bDQDUMpqfT7zwdNR1mqDoFqEDj4P2DtmDDJr8pe1g3Z+F/RLdCtlVOC9na+Pm1PaCMkXGrIqzvjhB3V6rFiKEG7W3RSHd3/zVPw50TvrzelN5NIdVtr+AhCSk1HAqRqYR2EKgJrAi01XV6RxY+NZAkgeFm+V2L4C3/kCkRZEa4uFYMnTZdHGlVpkOADFvNo537Bk8fT2IoEG3MAteAEHgIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e5676e-3d5d-431d-d414-08dd557fd7ca
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:36:12.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oppLtzhjOvghd2Gl7+ZYatzHJf/laq8AuH5073DjEfdhdFcIP+y3pHQXzml9VRwbYUqTjQn14+iUEOXaR00m3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250066
X-Proofpoint-GUID: F7vY3V8Bhe74KaCVOLmmUpeigsVKUJbj
X-Proofpoint-ORIG-GUID: F7vY3V8Bhe74KaCVOLmmUpeigsVKUJbj

On 24/02/2025 20:32, Ihor Solodrai wrote:
> On 2/21/25 6:47 AM, Alan Maguire wrote:
>> On 19/02/2025 21:05, Ihor Solodrai wrote:
>>> This patch series implements emitting appropriate BTF type tags for
>>> argument and return types of kfuncs marked with KF_ARENA_* flags.
>>>
>>> For additional context see the description of BPF patch
>>> "bpf: define KF_ARENA_* flags for bpf_arena kfuncs" [1].
>>>
>>> The feature depends on recent changes in libbpf [2].
>>>
>>> [1] https://lore.kernel.org/bpf/20250206003148.2308659-1-ihor.solodrai@linux.dev/
>>> [2] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
>>>
>>
>> hi Ihor, just realized that given that this change depends on recent
>> libbpf changes, we should look at updating the series to include a patch
>> updating our libbpf subproject checkpoint commit for libbpf to get those
>> changes for the case where the libbpf submodule is built (the default
>> these days). We should probably have a patch (pahole: sync with
>> libbpf-1.6) to cover this. An example of a subproject commit patch can
>> be found at
>>
>> https://lore.kernel.org/dwarves/20240729111317.140816-2-alan.maguire@oracle.com/
>>
>> However I don't think those bpf-next libbpf changes have been synced
>> with the github libbpf repo yet. If the next libbf sync won't be for a
>> while, I don't think this has to block this work - we could just note
>> that it needs to explicitly be built with latest v1.6 via shared library
>> for testing purposes in the interim - but if there's a sync planned soon
>> it'd be great to roll that in too.
> 
> Hi Alan. I've just submitted a PR to sync libbpf with upstream.
> https://github.com/libbpf/libbpf/pull/886
> 
> Will add a subproject commit patch.
>

Fantastic, thank you!

> Andrii suggested pahole could use __weak declarations of libbpf API
> and detect if they are linked at runtime. This way it's not necessary
> to check for libbpf version. There are just a few places where we
> currently do that.
> 
> What do you think if I add patches for that too?
> 

That would be great! The current approach of static build-time version
checking isn't ideal, especially for folks using a dynamically linked
libbpf.

Alan

> Thanks.
> 
>>
>> Thanks!
>>
>> Alan
>>
>>  > v2->v3:
>>>   * Nits in patch #1
>>>
>>> v1->v2:
>>>   * Rewrite patch #1 refactoring btf_encoder__tag_kfuncs(): now the
>>>     post-processing step is removed entirely, and kfuncs are tagged in
>>>     btf_encoder__add_func().
>>>   * Nits and renames in patch #2
>>>   * Add patch #4 editing man pages
>>>
>>> v2: https://lore.kernel.org/dwarves/20250212201552.1431219-1-ihor.solodrai@linux.dev/
>>> v1: https://lore.kernel.org/dwarves/20250207021442.155703-1-ihor.solodrai@linux.dev/
>>>
>>> Ihor Solodrai (4):
>>>   btf_encoder: refactor btf_encoder__tag_kfuncs()
>>>   btf_encoder: emit type tags for bpf_arena pointers
>>>   pahole: introduce --btf_feature=attributes
>>>   man-pages: describe attributes and remove reproducible_build
>>>
>>>  btf_encoder.c      | 279 +++++++++++++++++++++++----------------------
>>>  dwarves.h          |   1 +
>>>  man-pages/pahole.1 |   7 +-
>>>  pahole.c           |  11 ++
>>>  4 files changed, 158 insertions(+), 140 deletions(-)
>>>
>>


