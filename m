Return-Path: <bpf+bounces-70880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AECBD819B
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 10:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1185188FD85
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 08:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D930EF65;
	Tue, 14 Oct 2025 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XoHCECJ6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hp7SR/uU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7EA212572;
	Tue, 14 Oct 2025 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429171; cv=fail; b=RUaL+VffDvpoFxQOasktWvAefZ40mHGTE3BDa/0MkgNA9b/nCwD1LEHf3fE6+XGZB/l3oTB8sjsFbWzJPmFcj16hi3DeV4k+VXSuKNs5wuWkEt4Z9/TFKpK5uWoUR81gYZIBn6rZRzWixuQjkJ+NL8PXDbxHEAonLG8+AEBDFyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429171; c=relaxed/simple;
	bh=o8HUU1TWFQX6HuKrIhxzxB+XxuQubrC3+a/bXhE0v6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=md6CCEi6trSnTUQrBQbMwfKhcafuAjN7RuKaJALP2tPug08u1RVGDe6hUmDKe0nBsjsWgS0KgXF9sc3hFnfA/kkFiyrQp2tt13SVmPAkvvFC3s97M59vD8i9tEwP/fX0Hu+1Z60RifL4LPs/XMcGYPw0wrCy6ewx9bR0iuvFgSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XoHCECJ6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hp7SR/uU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E6CIMG029094;
	Tue, 14 Oct 2025 08:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6gP0cufRsJ8XqnsHmpY0aScu4GMgfeoo6UnV7Xje3mQ=; b=
	XoHCECJ6A350ocZtiBqe6qoCxtM0JMWgqvPB5J2BaBY5GGPD9DN7P/UQbRDBVBY+
	2fph9UBeoRDk+j43kNXZiBWZVjZka9H/iLfTn9c5lPyEz/pVBTO5INwMlqYvDzr2
	kJdcAN6gEwDty7BBFumWwuezdT6UUpC0W1spUUin8mlYz9wFUhnkdQ4QJJuB4XSv
	fU0kNlJ2qgssxJTePWF15yk2/0b15DEltHe1LciPCycKRakKHHIdBWdPJ192vuVE
	AL4VxWD3X/Zh8gRRQw/Kg8yaARuLJF/8O5hj0pShYDmmJoZ4KtqZI9o7eHH3tKWh
	PufwDmaQNw6O3zU0s6rp/A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfsruq7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 08:06:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59E7Ipqm017202;
	Tue, 14 Oct 2025 08:05:59 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8k67r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 08:05:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgUGOJB6Vr6zbye6a+oEMgPVvSrjlPgldCKDTldXy1na6vsAT0oKTCywljkEn8yNRc9fLMT8ow21RFUPkVPnHEa0C8UpeD6fvybeDCGNop7KGE2CY7JXH7bwyf3RViEnIxFxX0rrSxRdjQyxOlE3m1DkQ9+NQRxtgFyE+gqRly0Yvv8lnyFQW5P0ay3HYv2JnplfFwUBHcKWsphNzbBO1QwH7eLMLJQTh/WoSoAhkTJemieM8MRySdI1Pf2Una0YaKDYDNNPqDJetUzpoNx4QYhv+dtrbPsE6z5QLh6P1i35bGHlw2TvxcwdeIsVUqQRBwnCMwURFm0Q1tfaaUZIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gP0cufRsJ8XqnsHmpY0aScu4GMgfeoo6UnV7Xje3mQ=;
 b=KELefXxI09RjyjUyto8EIPTHR9JPyMIWWL3lDu83Dy05VbYnbnGoGSj1fh8AgFQVeblv/CN2IpFJdSRQgN8xlx2JqySrWKIC9zrDz8qDAqyqiEVM5QkcoXRVZcXrvABw9MZE15ut4Pa23Kn5dOlpRoD/97kKg2WfLLDgkvdAP839X4pf7bIoM8vzj1IvP0IUarDPLo38r+CNVSY4Jxw/DeI1E3uh3E4zD0S63Urhv/1i29KSr2HhHTlhl/K4dIG1a7QZs6+tVjyOBcLLwy96knFWayrg9HRk0T++X8VCkPrNpr85z58nYr6g7W5E0R6QPiciFg/uH8uoVHuQjYjnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gP0cufRsJ8XqnsHmpY0aScu4GMgfeoo6UnV7Xje3mQ=;
 b=hp7SR/uU7dG4hPKQ0NbcCnD3v0Q+ellGne3Lrpm3sgZGD4LOBjD1yk271sDzRQ0wFWtOAZzA4e1rbT4A8WwSyUAIy+2NYb8TLj2mfOxWLK8Dnqkp3tTH9GIA9RPaeLBzUE17X3PhQgfceR3fRJpEfW+ts+D8NBH9Jqe6kjTOS+s=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Tue, 14 Oct 2025 08:05:57 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 08:05:56 +0000
Message-ID: <7f770a27-6ca6-463f-9145-5c795e0b3f40@oracle.com>
Date: Tue, 14 Oct 2025 09:05:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Donglin Peng <dolinux.peng@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        pengdonglin <pengdonglin@xiaomi.com>
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
 <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
 <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
 <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com>
 <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0500.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::7) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA2PR10MB4665:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be669fd-ef6a-43ef-2ca0-08de0af8810f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVpxSzdWOGZwa1FNRDBzNENYVHpvTFgyNVpldUhsSkNRbm8vU3RMVkIyN2dY?=
 =?utf-8?B?UldQTXRQTlB0YjBuZkZxVnVsSXpSQkIybkh6T1BTblJMemhIZFlUZ2xtWVgz?=
 =?utf-8?B?RXpjWXhlNCtyMFcvY25YclJqNWw0WUNWeFI1a2xhbzVQUzRXakFidjQwTWRp?=
 =?utf-8?B?dGwrVlovbW9LZi9nb3JkVXBDbU9XeFVvNm5oQlIyb1FWMUlkekpuT1NaWll1?=
 =?utf-8?B?Q0lUZEp0bnhnTnZDSC9sUzk4MUx1QXlLUmdjSW5JRkc2Q3FTYi8rTmQvMnNo?=
 =?utf-8?B?NXlPQmJTZHRRVXA1d1lYQmtHaVU2UDh4ZXd1WjZzTkdWR2JYTVRoK2EvMjhG?=
 =?utf-8?B?V2pGajBZeEExNmp5a0l1L1k2L2lDbllnUitBS2d5T01BMjlBczgxUkV4cjBW?=
 =?utf-8?B?U2NtNHVGcVFMTEpuTW1mcmhuNmNRdTM5dUZ2VVJiUDd3RllzU2owTTZzTFBK?=
 =?utf-8?B?aDR1eVR3RU8rNUsySGJxNDJKcHV5ZDZDcFdpK0t0MU9xVDltSUhyTkNBTURG?=
 =?utf-8?B?enJYS2huY1JHSHlqQ3Z6VEVNNzZZcnJ6ZWVkVTVENXVWV3ljY2tDWXczb1Bi?=
 =?utf-8?B?eHhLN3F2blBubGdkS0Z6L25jRDhvQ2dJMVZZS2ZIZm1MUHNCU2pibE9Fb3Fs?=
 =?utf-8?B?TTRScGlVeWsvbzJGTS9yVlFZOEZ3WENHSWhkdHJKaTZFL0QvcXViZ0ZzMlpS?=
 =?utf-8?B?QVpySWxrZHYydjB4bk5aUVh1MmVkUmtpWFEwQ2NuMTJWOFNZVFdNTFlaRW1X?=
 =?utf-8?B?NVgwVU1scVlDejFMcWp0bm9Kb3Jwd1hlbXNmTGRGUzJ1dnE0MUQ3Q0o3QVJT?=
 =?utf-8?B?UzdtMWw4WjVPYUxDcXM2NEsvV25QRkEwMFdWNEhQb3VQTUNVMndGTVJvT3Yv?=
 =?utf-8?B?WUpXdWNqdXZPMjFNK21LUCsvYS9QNjlVd3BzaVJFaG5OUHcvRzV2a0I3Wk9x?=
 =?utf-8?B?VFJBd0p1VFNXVzdlc2FuNWJTMnNXWVhRT05CQUNVU2trTXc5QXRPcngxaEky?=
 =?utf-8?B?cldDZm92UnBsOEpSRVhVQTk3NkdQRVB1c2doSGhvRHFheUJ1NVovNVJZNk1I?=
 =?utf-8?B?NFFTbCt1Q0MyV1QwTWVZbUd2L25HYnhIczQ0WGtEUzdZZlE2aU1mM2c0UVJz?=
 =?utf-8?B?RmJYMWN4N3MvbkFVZEd3TTBFR0hqVHIxZUxGU3FvTmZqV21VbllPSEh4eGs0?=
 =?utf-8?B?YjVOblJiNWJnTEVPNGxLV0gra2JGQ3h3eUZTTTErUGsvQW9jRnYyWElEN3dj?=
 =?utf-8?B?Q01zdUR3aTBQQzZvVS9UQ3p0bTVPbHFFZVk5VlozR0VvSy9qa2REWkc4MmdX?=
 =?utf-8?B?RFBmeHRiTWE3WjA1MTRyU0V1bklDNzlybXpSL0dmYlJHeEI0OGdkaytHSndM?=
 =?utf-8?B?VTNENEpXRjZYK3RGcjJ3M1IxYWNMOFc5eEZtRk53MWxNdzlJT24wUHpYQU5G?=
 =?utf-8?B?dXRYb1RldTQ2a0hneERhYUt1cnpZRzM1YTkySjBLbStrdE50RDNXUE9qS3Ns?=
 =?utf-8?B?ZlNQdFhLQ2lzVjNkQ3cvNjV4ZHVTaGxlSUVFWW41QTVEeUU1VjRLTTB0K2R3?=
 =?utf-8?B?aTRsQlNlSmI2eVp2dFJRODIwanJDTGpEd05QSUQ3bHFTS0IwbVF5SEpkQVdS?=
 =?utf-8?B?eFBVUzY5UmV2a2w5MENBN0c4QVBSVTZQSU8rdWZMMmhXZWZpNDhwZllxTklT?=
 =?utf-8?B?UHg2ZEJVakNZTmo4UWMzTCtXZUR5bTllRk5QSkx1K0hzV1p1Z2hsc1Yrc3hJ?=
 =?utf-8?B?QTdrVjlTZHQ3WHZZWGlIT1JtcjFSK0c4OFM5KzhDZTVCSXVPY1d0ZlZTWXly?=
 =?utf-8?B?THJaYmJCbTllMEkwQmxIck13YUVxRWNyUEM4SHpoZHduT3FqRGo5azJHcHY3?=
 =?utf-8?B?NHMvUmtnUlV6Z0xIV2xLdVdMNXFNK0MvZHZPeHkrS0JJQ3QyQ1BOb2p5UDUv?=
 =?utf-8?Q?Ijk46iMzWlE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3RCYzVHaDAwMHVvWnczenBSb25qQlNQTWlGc1Q5ZE8yMWlYQTBPNG9MWjlr?=
 =?utf-8?B?di85Y1JLRkRmY0ZselRZMHNmUlJ6eTdqSHBzYkZ0MjZKTWZFb2Y0eFBtTTdj?=
 =?utf-8?B?ZWs0c2FybEUxWGRuWG1TWEgwQVN5SUh4ejlGbHl5Y2dpSjZDMUkzZkJNWmV3?=
 =?utf-8?B?VG1xclRCOTBualBYdU5BaG5uS0NNZkFSY2I0cTg3eGJqQ2E4bzZOWFRRTEl2?=
 =?utf-8?B?SFRINGh0UGRJVld4RHhhMVFTNzRuazNIN2hlWTZ2b3dPZlVGTnRrM3UwUGEw?=
 =?utf-8?B?N0RTbkxtakgrK0QzWklnUkR1SUh6RE9FaWlwWlhQR2xyaCt5VU5wSTlybWZl?=
 =?utf-8?B?TWUyQXRSYzNDbVFSbk1VNm5QblNoTVlPZ002TmtmU1ltdEVaczBSc3IrRm5T?=
 =?utf-8?B?ZG80TkI1ZTVadlNCT2FDSi9taUxWNWFER1ZhMS92ZzlCWDkrYVRwakNZMW9a?=
 =?utf-8?B?MS9LM3laMEZhSmk1UHlmbmhnR3U5eVVCK05WZEs3WnF5OEZYZlhKaW9KSlRX?=
 =?utf-8?B?NXU1RTRTamVBTk13d1NlWm0vZlVFTW9yRWREWXdHZGdmcm5LRTd3dEVTbXFz?=
 =?utf-8?B?QlhSOFdKTDVoSFlYZUx3MmVOUld3WlYxblNwQ0J1bmRlSWU0YlhPcS9sdHE3?=
 =?utf-8?B?UUY2VlpGUFdRRU41VnFlVjJzREszL0hkaHpjYmJkT2hMeGNUNWFWM0M1Sjd2?=
 =?utf-8?B?REFqbVd6Y3RZNmRsQS9Ib0Y2VlhhM1ZNMWYyM0RuUFVUSFJrc2pQUFBaYkl2?=
 =?utf-8?B?OFVPY3NyOUhLUlBQV0psK2MyaU5XNDBLSEUrVU9SdG0vV3prU3FwbDNRMytr?=
 =?utf-8?B?aGJyNGJIcTlFZkZBaTN0dVNwUEFNZ0NXYktzTTByWDk0UlY5dE5pRXhKaXhO?=
 =?utf-8?B?MmFocDNocFdkbVdnNHR3WXp5UmppRWpxQXlObExTVjA3RFQ3UlU2amVybnVa?=
 =?utf-8?B?eVFOTG55YlZ6UGpaUkhGWktXOUthYWhQZ2czRFQ5ZXlYa1U5N3FYZ0hZeXls?=
 =?utf-8?B?aTRPTmtBc1lqYSt4S0FDbE1mRXJpdU15cWxZYnlYR3V6cVczbDFXKzc1Sy8r?=
 =?utf-8?B?bHNBSlh2SjRoSGJJUDdjOUNxc0JLNWpWVzVsQkk5Vk5Nem5hVHZsKzFVV2Vl?=
 =?utf-8?B?d2s0dWxVbDNJVlZlOGhiNHNhRU5oR0ttNjRvcTNMUWI2Y1lQS2JWYmJwZFYx?=
 =?utf-8?B?bUEvMlFDRkc4QUpybjZmUkZpSE5ZNWxSV0hDRjU2V2hqY2J2dUxjZFVVQWpj?=
 =?utf-8?B?M1JDZ3VXdXVGMGZJV2dGS25pVjV3U2ZGZXN1TjlxU3dPY2pEd1V3MFdyY3N4?=
 =?utf-8?B?dHYzVVArUzFBRXM0enJOUTRhdGdDUWlDd3hWQkhWMHJid3FoMW9NWFlPTGtI?=
 =?utf-8?B?NlJvVWhpRDZMRjlOYTFISFRzT0k0UVNpaFN2dDY3UUx1bmVIWFpiMHVPd2cr?=
 =?utf-8?B?VG1WajFFNG9QbXBCVVdReXZpRHJWQ2JUS09NcERxWFcrRzFSZ0pMcFB0VjIr?=
 =?utf-8?B?OUxJQVhNYUp3b1FwK2JBdzhUUlZYVVFZa3pqZGdvRDBhWDVOVkZuaXZGa2xs?=
 =?utf-8?B?OXNZT3pJVFByL0Jkc1JtaitqN1NlcWpocnhUaXRPdEtaZURJUnhrZGdxMzBC?=
 =?utf-8?B?dE00Mm5rcklncGMwS2JiT20vVU1PSTQrK0lFRlo0WVVLS1k0bFNTQlVSV2xu?=
 =?utf-8?B?THZreUh1MHRQTnJ4a1JqV0doVVJOdHZpYXRTSzNqNWlYSGFyc0kzMGVWUFlj?=
 =?utf-8?B?VHNXOVBqMDhLdStXVXVKSzVyam0wNU5CNm0rOWt5UU9Oa1ZTcVNTMFRSUDZK?=
 =?utf-8?B?SG5zM2tTUFFYMzlSV3lIdFlWL1BEclVGd2k4ZW9MUHI3cjhVaTFBcHh6Wm5B?=
 =?utf-8?B?SVNCTXFXZTdhZUZ4Yk5XbjArUnUxcDcvOUxhaDMvMWtlSmZMQy95ZWQwNm43?=
 =?utf-8?B?L3hQYU80T2lEM2ZIeUNUVnB2N2V1VW1EMFBzSWFYQzBpdnFLcTNiQWErMS9B?=
 =?utf-8?B?QmM3anZicGZtZ3cvVXNsenowa1FUN1UwM3ZITXlPY2F2VjVpKzE3NDY0c0dn?=
 =?utf-8?B?dU1GMlRIeHFHN2M5eTdiRXRWWGVpd2V1dVlyNUNzVVFkME01cnEzN2FiVjF4?=
 =?utf-8?B?R2t0OEhVTFlWaTA0K2dLTjdJSWpVUkx2amp3aW9DaWd3cDNmMkYwaDFTMDRx?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dQIWDujz/MTVM2s+nFryfLNdZJOjarlu4LdMN3SP33ITdU5wM68jXHQGfeWF2AqKVrQsoMWpz3V67iCqQcULek6E/FL0c0pb/E8rQGALFTmdndpc56edJYmZ2emzf3rcFn78KpmowDeHCK7ZcYdfxiWCIluwrf5hMj8vsYaXnZtoMqVNkwmf1JIx9G47Is4I8J5lNV5163e2Hfj3oSjT0svhmrcZU10KpEUEG+gwoii8+qqBsQBbsmfzpoSyWTKcM+KrjPLMw5pmRmAa7Yo15tpHsqDnaWc5wA2RfLN4dVQNvCRGase/qPu01slNgA+jR8ruxU9l71n1AZ288Lps/z4UUSkCw0eZJhmrA+jEKkDnYIy9KsNbGcWA/tIi/+uSa67Dv+v8SS+SBw5Po5deVZKQ2DLzHUNXjcMOHOaYDwVqnniC8aGa00nlc3ZX8SLx7DU3b9fnypR5V/Zd/0GSOsu/NiopaBMXmJXav3RIlUVlmmnMpC3jt5gxSfaIMolaAndmuN1D7TqsrZ217jxufo0TqulH65zdbbKyQGF313VnwJYEj3OXXqNL250I7ZaF69ELhT9oFihAW26985LHr3azAAFy/gxZSw0jEAvy6UE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be669fd-ef6a-43ef-2ca0-08de0af8810f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 08:05:56.9132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBqJhB6FLEDDveAnTRtsTMwun4bL635CORU/lfoCpu7PJvYoX3K3tAZ1zl6MXjOmU8rZ956RiRtLoHHc2jWZCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140063
X-Proofpoint-GUID: ZDvCHqRwwzgDH5y6gFXHKNl7hIomFQOD
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68ee0468 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=JPYJ8HJh9TnQ-GcwOMIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX/vAE5/t9qrpN
 PhrOBqe5Py7HWmHOEEO3kDHSRtrNprYDHeDUeyQ4uTvXyCWNizxrVnB7SSQhkJbCeK5kMpaSSrj
 +OXAdFYcUuWQZ8rUsp4vZsSxF4/5dIKNPXd5j/jP7FsMQcu98eO8rvytXspD3ZzfqkXTvuR/k09
 Bj3FetvUyL1ECLYe5r0jxTsab/G++Znecwbo4LveumFR1CPtJ9nEaRzDvgiwckcNxxC3bi5uWND
 yC52cCk7WsMXuBUCnTbsh3ZDTpHTh5zDbM/mb1wSqleRGOqRv2MT2jHU4XyS8XJeTSVk7iExOoL
 RZjnGMwUcUYI6OeaqiE5d2pPhErAFzSE0R+dfTCIk3DcqpMdPIAsGbfgOpbUzWT1bLBjpXCz+hv
 MDNmMwtOXiNtP9tul8ux9OwZkWuV4A==
X-Proofpoint-ORIG-GUID: ZDvCHqRwwzgDH5y6gFXHKNl7hIomFQOD

On 14/10/2025 05:53, Donglin Peng wrote:
> On Tue, Oct 14, 2025 at 10:48 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Mon, Oct 13, 2025 at 6:54 PM Donglin Peng <dolinux.peng@gmail.com> wrote:
>>>
>>> On Tue, Oct 14, 2025 at 8:22 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Mon, Oct 13, 2025 at 5:15 PM Andrii Nakryiko
>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>
>>>>> On Mon, Oct 13, 2025 at 4:53 PM Alexei Starovoitov
>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>
>>>>>> On Mon, Oct 13, 2025 at 4:40 PM Andrii Nakryiko
>>>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>>>
>>>>>>> Just a few observations (if we decide to do the sorting of BTF by name
>>>>>>> in the kernel):
>>>>>>
>>>>>> iirc we discussed it in the past and decided to do sorting in pahole
>>>>>> and let the kernel verify whether it's sorted or not.
>>>>>> Then no extra memory is needed.
>>>>>> Or was that idea discarded for some reason?
>>>>>
>>>>> Don't really remember at this point, tbh. Pre-sorting should work
>>>>> (though I'd argue that then we should only sort by name to make this
>>>>> sorting universally useful, doing linear search over kinds is fast,
>>>>> IMO). Pre-sorting won't work for program BTFs, don't know how
>>>>> important that is. This indexing on demand approach would be
>>>>> universal. ¯\_(ツ)_/¯
>>>>>
>>>>> Overall, paying 300KB for sorted index for vmlinux BTF for cases where
>>>>> we repeatedly need this seems ok to me, tbh.
>>>>
>>>> If pahole sorting works I don't see why consuming even 300k is ok.
>>>> kallsyms are sorted during the build too.
>>>
>>> Thanks. We did discuss pre-sorting in pahole in the threads:
>>>
>>> https://lore.kernel.org/all/CAADnVQLMHUNE95eBXdy6=+gHoFHRsihmQ75GZvGy-hSuHoaT5A@mail.gmail.com/
>>> https://lore.kernel.org/all/CAEf4BzaXHrjoEWmEcvK62bqKuT3de__+juvGctR3=e8avRWpMQ@mail.gmail.com/
>>>
>>> However, since that approach depends on newer pahole features and
>>> btf_find_by_name_kind is already being called quite frequently, I suggest
>>> we first implement sorting within the kernel, and subsequently add pre-sorting
>>> support in pahole.
>>
>> and then what? Remove it from the kernel when pahole is newer?
>> I'd rather not do this churn in the first place.
> 
> Apologies for the formatting issues in my previous email—sending this again
>  for clarity.
> 
> Thank you for your feedback. Your concerns are completely valid.
> 
> I’d like to suggest a dual-mechanism approach:
> 1. If BTF is generated by a newer pahole (with pre-sorting support), the
>     kernel would use the pre-sorted data directly.
> 2. For BTF from older pahole versions, the kernel would handle sorting
>     at load time or later.
> 
> This would provide performance benefits immediately while preserving
>  backward compatibility. The kernel-side sorting would remain intact
> moving forward, avoiding future churn.
>

If you're taking the approach of doing both - which is best I think -
I'd suggest it might be helpful to look at the bpf_relocate.c code; it's
shared between libbpf and kernel, so you could potentially add shared
code to do sorting in libbpf (which pahole would use) and the kernel
would use too; this would help ensure the behaviour is identical.

Maybe for pahole/libbpf sorting could be done via a new BTF dedup()
option, since dedup is the time we finalize the BTF representation?

Alan

