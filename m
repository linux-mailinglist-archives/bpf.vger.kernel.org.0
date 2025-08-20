Return-Path: <bpf+bounces-66076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B716B2DA7F
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 13:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC73E560C26
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 11:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D309A2E337E;
	Wed, 20 Aug 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eG0ByJaw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yjN9lKbm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5F2E2F15;
	Wed, 20 Aug 2025 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687889; cv=fail; b=MZcgf1JsHTIzO+TY70k1LeHi2YfBVGCsT7ZwudE4V+aKJbxjre9mPR+tJysysayFvVSEWRsJ1/W6+O0aYz2vhcTVxSIWAZMH2s5VYDXhYfbtUCuap6ub0PUTIjP/2W9ION6wj/+56RnQbEeOX+T2tYRYH0FZwb4cOc9PuQHlqPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687889; c=relaxed/simple;
	bh=VL2Hgv9zro08Quwjvgn7VL+rLyi03Ayo/Gm0xSyulMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lNoeBYc0hOa0Lkt9waeLYRUY9kzu75AY6K9DK3LnQXf/fMOUq8lg408UIyA2rofPt0ZNky3G1C/JCg+2DXEtEJscDEs8vrSYeo231tq1wKN5PqC4Mu9rfvF+OE1g5ALH/SxQcj5ttFx6bOnfc7eagtMjtcef4MeYJBB3mlmWDvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eG0ByJaw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yjN9lKbm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KA3PBO002823;
	Wed, 20 Aug 2025 11:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kT3a3ZdwdE1ub9b2a8r/zLd7G2goniBe59mCoiVU0Q8=; b=
	eG0ByJaw+I6Ci+OeZDHzRo3UTBW1yQNQs9bVeCBdrLle1CNxeFgPNcnkzjhHsEhf
	FSWiGFH1CZDx8EK/sHOMlzwMvNvuZzz8rJOZNmspiIdnsmAOp6OJvAcw5zeE25hp
	OhWK4pm0F/Lr+OT4N34hBzWr4+jIBgrLnstfXC8DRVC+Yu5fr0hzpiZMaUSaNwed
	jsqNC69Az5CqyAjjn4hreSZ1PVLePbf4AOjUCkZuknhOeC+qD+8NAYOA4ZTK9+Al
	3OScahAGQKbpxFLbNxhYomtGGp9kRNF4J2Y9fQqqBydnsXTy88dmoIQ0Y7TYbJ8v
	4LDKQQvhEJ93Vvn0LdGusg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0trs17y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 11:04:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57KAk4lt030238;
	Wed, 20 Aug 2025 11:04:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3tvevk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 11:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaRkdP4ppqpHTEAaNYTniieTtH8QMripoS/0rfu83UhaIGunP0oMEkU0Ue0u1jbOnIzarmPHi9JYO2uqJLDMyK+Ibf0otqWpHcwnfNYUxyncyz01OvflT6ui99pw4wY78xKn5y9uGFuVWCP8CICVITGTgaU9eo4cjaMQu09ox5qVM4pVvBv6KuuHwGLkZfF+pTeW7usB4AIn1KbPObNbPHLYeAb9ZO+tlrIrs2ssxVM/WXG2ANUaf2HmufkGEJrUGQthxoDVUrvFSD0SEBzaOdnGWNl2wu4nDiwsW1NVv/iA5w1lTl7XXwmrnjcvjHuItcw9lT4e5OR/CyRESco8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT3a3ZdwdE1ub9b2a8r/zLd7G2goniBe59mCoiVU0Q8=;
 b=UPjT/k63vVkNNXpXdFlhFbi1sOGP14Sf+7bOEIJP0Lq+aS8GKhM7+vwtlqEbehLYvjg9UQnlTGEIABmTbwZ5zAeGjruKUO+ltyjfEEWCL7UIrfGWDYG+FPXrKGGWCaqlxAPPTl3CN2I5Sk3ueqq+jQhzPK248BvXRM0Tg5YDIK8lhD8BU4deN7QZaoS32vn5iQ+Leiqocs+2WN2fEEIbiMhY12U1F1Sdx1DWnb6mRvfwux26d2qQXsm2ghcx8WODXaCyBqnagAtChC9B83GUj5NYzbf2T9aQJ6ko23M5InSjugTHxB3YkZVTOTWki7LxteNgbMhiMUDkjH5xGs9jdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT3a3ZdwdE1ub9b2a8r/zLd7G2goniBe59mCoiVU0Q8=;
 b=yjN9lKbm3REAosLUckghtCKJJDp/a7u3o4+3N7zbHv1iMARpGSoqGL6f1/csIt3hoLUc7hZw3RZlbGOAQJLL5smNLq99O18RGrxJGppBAiHGVukBM4+gc57K2KO5MNE+mpGifMqNzqajGV0xsK1ir2xTVAP9Tgz1qzwmKZmWiAU=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH3PPF272D9E96C.namprd10.prod.outlook.com (2603:10b6:518:1::790) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 11:04:22 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 11:04:22 +0000
Message-ID: <9da9d7f2-e586-40a4-8080-2903920d32a3@oracle.com>
Date: Wed, 20 Aug 2025 12:04:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2] btf_encoder: group all function ELF syms by
 function name
To: Ihor Solodrai <ihor.solodrai@linux.dev>, olsajiri@gmail.com,
        dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        eddyz87@gmail.com, menglong8.dong@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, kernel-team@meta.com
References: <20250729020308.103139-1-isolodrai@meta.com>
 <79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com>
 <647eb60a-c8f2-4ad3-ad98-b49b6e713402@oracle.com>
 <3dcf7a0d-4a65-43d9-8fe8-34c7e0e20d62@linux.dev>
 <5a926464-62bf-40b2-8ca4-a7669298a8ea@oracle.com>
 <d845b2ae-a231-4bd0-a3f2-b70f14b395ad@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <d845b2ae-a231-4bd0-a3f2-b70f14b395ad@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH3PPF272D9E96C:EE_
X-MS-Office365-Filtering-Correlation-Id: 365d51df-319c-4b1c-e59f-08dddfd95144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWZVNnFsc0sxcDV1RklCYWdOWlNhR1FiTlIzN2dHbEJOclR3YWQ3U3RiQ1JS?=
 =?utf-8?B?MGdYcmpNdzUwTVRRUnBVaWQ3ZTFMZmxQK2dLVEY4TU1rd1ZmcmVxclVUaWdV?=
 =?utf-8?B?YURPOHhFeUFIaDUvY3loSGtCY052cGI2STVFQm1ITVAzSlNXUEQ1eTdvT01a?=
 =?utf-8?B?U3VLMWxVcUxxeUZWOEd3cVBwL3JlS1ZITExhNHV2Rk1Hc0NEYXQ1SVBHZ1gz?=
 =?utf-8?B?N2dXeWVQY0Y4aC84eFl6ME4zdzltYlo1WUZkZlhyQ2tZWTlWQ05MdGh6OHNI?=
 =?utf-8?B?bU4yMVJ4TVozeEJ4eVlMbE1BZmVxRzk3ZWVYTEVFaU5qRElGcWo4WDFKMXJC?=
 =?utf-8?B?THBwUC9hT08zYW5HMU11U0xReVcyemQyMk9sTlk5QWw3a01LN2RiS0dCcS85?=
 =?utf-8?B?Z3ZjQVVRTjRMSDJkcHlacU1pSEQxMmpkOW9TS1FOeWVsUlcxcjBtWml1QU41?=
 =?utf-8?B?cUg5cENDOXU4VmRrcDFhbktwOTVoc1NSa1FCamZjbkc3RnhicmlVVjUzZElH?=
 =?utf-8?B?bnhZdGVEeEh5R3FqRkdCcGhFTGZjV2RuZVhsRnlrWWE3RFNZekZTeDIxVGpO?=
 =?utf-8?B?VW9DSk45bFVRVEZuQkVBQ0pMSGcvNmtPeVlDSjhJVXg2ckxleU1KTU0wRFc2?=
 =?utf-8?B?dGIrZzJFaFRaSkRSNnJOMHJBbkRKMmdRSnJMZ0c2N05DU0tyRU5Qc0xxK0My?=
 =?utf-8?B?dUpJZ0FOUU9EMG9OSURsOXcxdnV5ZWNYZFlGY1FNOGpHaUR6dUdZWXRNQWVX?=
 =?utf-8?B?RmFSL3Z3Q0RDcFhtREo0YmR0OXNWcmcwbEhlMXpDdytJY0t2WklMbGNSV20w?=
 =?utf-8?B?SXlGekNZeGtVM0dPeXd0WGRGK3JrTnNqMTRDKzJHbkRHQUZ2UDJBMUtRdE43?=
 =?utf-8?B?TWIyVDdqUWd3emY4bGJFVlBIcm5lSzFLbDVEeTduR2FXVDdsWG1xdXVQSnZ2?=
 =?utf-8?B?cnlML2FTbll3Z0VxNUk5OG1Ec3JENzdpUkRqN2dSZnh6RCtDd2JmZXc0ejh0?=
 =?utf-8?B?eit2d2lMRkY4UGpuZXFjelNrNmxDb1ljNkUwcTRackY0cWFLeTZTUXNIakxK?=
 =?utf-8?B?UFlZWnZFMDZiU0wrbGkyNDBxeFliSmlFSTFsQ0xDbUJLeDZzanlmT21hNXJj?=
 =?utf-8?B?VjBNeVQ1VGZqTkh0cDBjQ1ZQOVY2NDhRSVhGRlJuYWRlT2RuZ29wQmxzem0y?=
 =?utf-8?B?bDlNR3FIeEdtTmNaSUdDaHY0ZUs2TjRjZGVXS0JLYTRLa0NUeVVuSjJoRWJS?=
 =?utf-8?B?ODkxSVpSVnNmdFZMY0lFVkVvbEFiUkJzRmhiRFo2M055dm9OWGtrWVdkVW5D?=
 =?utf-8?B?WndPeXVHNXNiZzRVUlJ6VVl4RFZZR05xenU0Q1FZNElzV0d5cEpnTzRmeDVI?=
 =?utf-8?B?T1hjYWZDWHlZN1JGaDhIVkQwUDhSdGpxNWFxOFFucGRSM0dDYWRYTE9PenRz?=
 =?utf-8?B?NjBwYWV2dXpIOWpoNmpDR2d0Zm9HNkQyNUpmVFA3eVBYN2NJS1Fjck05a2Nz?=
 =?utf-8?B?b0ZLWTZNUTlWZGcxSGh4MjgycjQ4OVRSTHREK1JEWXRUbkZvYk4wZlF2akFU?=
 =?utf-8?B?aTUyM2I1R3AyS0FUUXptb3hOZnB0dWhaZTBJemQ4bzFNcCt3R2VwdWg3blB5?=
 =?utf-8?B?REZ3ZmxZVXoxMzFqbEpuYkE4eUo3NjROWi8rNWlzRXA2OTZYRXRVYm9ZYkpW?=
 =?utf-8?B?dm05T1ZJbndld2pvbHhSazVNT09xTjU4d3l1aU40Q2J1MWdGS1pwRTZzWDk0?=
 =?utf-8?B?MUpyelBMZzR4T25Mby8wMHp0Tm5uMy82czBSaTJFc1g5MWlIWGdyWDZBMGVM?=
 =?utf-8?B?K1Z1SWlFMTRwSXpBVFRrdUhoMzhxWVIyRWh3emdPbUhISnNHLysyT1psUVkw?=
 =?utf-8?Q?xJRpgRwYuiirl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWZ0WDRqU3U5QTJlMEt5Znk5YzM0SWRUVXRuOExSTkkzQVoySUtpYlIwcGtZ?=
 =?utf-8?B?SlJPN2FEbmxLTDRRV0Q2cG1xdDd1ZWFHYlc1VHRSYzdUTmdMd3ZDaWhYYUtB?=
 =?utf-8?B?L2NEbEg2L1pCTGk1bU5YTmRleWtDZU1GMGRWd3RwWml2Um5KaG9xMHk4bnlI?=
 =?utf-8?B?OGlYelluMjVXcDhrM1BPNGRGL2QyUU53cVEyVkN0SHhhWGFaamNCOUN5ek5a?=
 =?utf-8?B?UEZLakVzWUdOYmcxQ2h2bktFSmRMVEh4dThYUXVUTUt5ZnBPbytESjZzZmRv?=
 =?utf-8?B?N3BxcXIzT0NlSSsrUWFqQU1oVnhrZFJkUmNhTXZOcnM1dHoySkhEQnVJZHcx?=
 =?utf-8?B?NUloT0dTc1dxTmIvQnM4TE8xcmZvVWc1OXVodXQ1OTkwOE82RnRVY3R2bDBi?=
 =?utf-8?B?SFRoOEh0anlUNm92bHZMVVlJMjQxejlGYzlOMVJ3Zy9DM1lTcktCMHdPWHFr?=
 =?utf-8?B?M3ZZTzg2bDAyWUtiM1VaWXZmMXMrUWlna3ROYWxOcFVyY1JlUDdFbS82eUZN?=
 =?utf-8?B?RlZzNFA2UnhHc3NHR2ZGZGphbUVSOHRXa09yVDQwOCtORFFxbTgzTmdFR0Mr?=
 =?utf-8?B?djkzQlg4ZGZTdyt5dTFnVXlRQmtjQTFyOTFZaXZrYTQ2ZWtydGFSd0Y0TTRa?=
 =?utf-8?B?eTZLNXdEYW5mTklOTm9qU2JVZWZmVnJ1NExwVUVmeGZ4Q054amg2NWVYYVVF?=
 =?utf-8?B?UmczdlpTNzhXam5TTWk0KzlLcWhvTnliaUVkdVg0RVd4aDFucDFOOHF0LzRq?=
 =?utf-8?B?SjU5eVRvblY1aVFpdDF1SklOdVNDT1dwa1UxWkEyeXM0NGx1WU1STXZtS3N4?=
 =?utf-8?B?ckxSbmhtU3B6ZFd6ZzA3RnlVbjNkZkw2TXc0YVZ6QzRYTkNBY0JlemtSNFN3?=
 =?utf-8?B?NlRKY3R6VG1raG5PdmJCMEZISlU4WTdFNUtXb3JhZ3RRTE5xWks0K2IrNC9x?=
 =?utf-8?B?REhXTmJvY3VmbjZ4WW1ab2psbnkzRlFIWVJTaEtkdUVSWXJsalBqT0Z1YjFL?=
 =?utf-8?B?WFhxSnhaeENKSTZmaXR6Z2pjSUJsazZKY2VreGs2cGFPOGh6MGhHNVFtU3Jj?=
 =?utf-8?B?VFlJVTFyYmxDK0psQXpaem05bWs1N054Zlp0M2NmRmxXTHJYVkpvbmI3Mktl?=
 =?utf-8?B?ampvTzl2eXk5SkVrUUE1N2xpYlRrZVphaWEwRUJaSWlTRmpldXlLMERFNS9z?=
 =?utf-8?B?ZERnYWZQL0JoMU9wYlZ5bkJQaDJKdmYzVnJ0RW1TQmVqV0V5dlZWc3JmdS80?=
 =?utf-8?B?Q1dPbW9uQVhKcndTbDZiV2FlTFllZG5LbFJuM0U4OUJQcVRFbUh5OUdSU09j?=
 =?utf-8?B?cXZzVTFJK2V5MEJZREx3QUwyallXNkU4NkVVNVpYVnZjN3ZGVGlodUhITWZv?=
 =?utf-8?B?ZG5rSFllNFRWZDNnQlFqdzVoRzRkTUFpa2JzcnJ6c1FEN1pDRlBtMmFWdUo2?=
 =?utf-8?B?a3RvRjRVZmU2RUhvN1NMc2xOUlVRVDhLc1Y4ek5QMkcyWWI3aTlmNGRjNFFv?=
 =?utf-8?B?WDNnK3JsTnhIV2RFM0tUMU5ZV0RLekxEYUZGZE42Q3VSK1VYWStjaDZqRVJa?=
 =?utf-8?B?TGpBTFFaeVVjeHhMaDN6QUJUaytneVIxREI4cHpod3M5bFllUEZZa0hvY1Rq?=
 =?utf-8?B?V2xVUkllMHR2Qm9BaGhKbGt2Z2FkN2dRSjJzTGlwcU0wZUQ3eE54ZHU0bEVo?=
 =?utf-8?B?cDhVZDMzSll6TnEvTVlJbXd3MDYxcktxcmVvMXcyVlhzUTdVcVQwbzVtTzBz?=
 =?utf-8?B?aXRKOEVoTHU0elh1ejdsL3BBQXFWL2VySU5hSHozaHNBdjZDTXBoeEdISWR3?=
 =?utf-8?B?Q095RU13UndnWHkrR29Oc21CZVlCNXUvVUdMNk1iUDhlVFZ1c2ZWMWtDOHVG?=
 =?utf-8?B?cVVNVGx4eVZjS1pHcUdyem5CNGhidGFaQis5OFB2NkhWRVFSQWNaTUF6cjZW?=
 =?utf-8?B?SEh2TDF3dzBuQzlac08vUnI4R2VueXczZXZEaFREY0k1U1gwNytDRkR6UW5u?=
 =?utf-8?B?NUZLUmR5VHpBU3BTdnc3N1o4NE54bWpUVTd6NmJJeTd0VFVJNjNxdC9kMlNT?=
 =?utf-8?B?WFl0SEM2QmNvZHdtdXQvdnVZditPUVkrTXYwR2I1cDZhY2FDMklCSDlLS1lD?=
 =?utf-8?B?c2YwN0JsM29RKzVhazlZTHZUSmlXUENrcDZkT1N5QVdVdVhhZFByNXduYVJh?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2zDLaXgJtRDlE2DVy5PX28a7AeEzk81cN7wqbc8Gi3ILnuEvtJl/fIsscKgCZcREjYWmR/N9vFZ+77qIxKIRcHzooCtuXneWArSnjZ5Emd/tMrDv6kachU+8INcwYi4rU9bCX20zkK7GnApgnA+4TxGdizpcfu1Pc2tW58WxIFhLj9Vx9TpAe1B8MKhwKIpWZhhCVoj3b0B+TI7ai94NUkFS37VpIfsKJwuAwN4z6/1B8ekWW4xJerjQUiiMdwvOuYyEvGDFwrAmcj2TcaagELe9ypi3OltmuqMGZQTvaUSnHP0+S+szyQivnZyz/MP6lpzVqgIb0e9lM6mLhKfN6NIDUSmCf8W4WT2rngXSKQIXPCvA1FmBlGaaIBW8hcnHgN9aTWJ9swbGru5VZ3JeG1cMNJ92oHuw/J5MBM9u/0NdjL/wz1RFI8bn3EWWOCPvDcr4LMJYAk3tTFXWccyxSC1k5cfSx2WbKSHoWOFI5rV6e4zNO+NNEP2jegLp9F7XXfFEB0I7a+d+cBHP2gMO1g0MNl85+HJ1ncYAJZVuFXwIZPuek31REmKSUmeRm5iiAQ024RXQWpzM/E2KxHbtr0k5lLTgT8WipwsPe3FgFHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365d51df-319c-4b1c-e59f-08dddfd95144
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:04:22.2185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQens0OmKi8ioOB5dH77ZDbwz6J+5qsGyjSMe9YFPS3zsR9F8HcCTD0DpPsLsTpnxY9F3nLn9PjVoizC+jhaXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF272D9E96C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508200097
X-Proofpoint-ORIG-GUID: Dmo5A6JX0-A25t2AMSPDhuOKAr-NVJAy
X-Proofpoint-GUID: Dmo5A6JX0-A25t2AMSPDhuOKAr-NVJAy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX9QS51yTzD/gx
 C3aTDkPV+e2FjDJo0lEcKsjz2QwwoqUr4QT8b1KIvlAxHOvwdV3ONvZ0EjJKHDkMIopmmpTSGMC
 xYHLJ+PHPWaPgiY85AfRZZcPC+gG+XNLXUiLp/ziQjSU56d/tlFLMpRNIQioXZwiOOp5rmLZutf
 BwJRvgiCiqT7jlcaIqJmIYdtu1Ewn7Oe0qju8CPaGHk5Se9DUN7O0BWxTdafBudF8j/8duaOtcN
 KFpEvq0wgQA+Gc9oBmf4rsnJL1naqxtstMac8fMW0E/GYHpM0+irZizeS7rhtiRbUt9rnwwbR0u
 uEx9xnHfbc3iUIpbI86GYXkYrzzGC9hu9lo/gcHi7nJWy1JP/A7/hEB9CzWnmPdc3XgVAFX0II8
 2H3BJOoHDFQfH9P8gTODStAlOcPTizKqHJLv6TjI5MaFt0UxV6I=
X-Authority-Analysis: v=2.4 cv=Qp4HHVyd c=1 sm=1 tr=0 ts=68a5abbb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=H8y2kb9tlf0s6nfDJKEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:13600

On 19/08/2025 20:34, Ihor Solodrai wrote:
> On 8/5/25 4:24 AM, Alan Maguire wrote:
>> On 01/08/2025 21:51, Ihor Solodrai wrote:
>>> On 7/31/25 11:57 AM, Alan Maguire wrote:
>>>> On 31/07/2025 15:16, Alan Maguire wrote:
>>>>> On 29/07/2025 03:03, Ihor Solodrai wrote:
>>>>>> btf_encoder collects function ELF symbols into a table, which is
>>>>>> later
>>>>>> used for processing DWARF data and determining whether a function can
>>>>>> be added to BTF.
>>>>>>
>>>>>> So far the ELF symbol name was used as a key for search in this
>>>>>> table,
>>>>>> and a search by prefix match was attempted in cases when ELF symbol
>>>>>> name has a compiler-generated suffix.
>>>>>>
>>>>>> This implementation has bugs [1][2], causing some functions to be
>>>>>> inappropriately excluded from (or included into) BTF.
>>>>>>
>>>>>> Rework the implementation of the ELF functions table. Use a name of a
>>>>>> function without any suffix - symbol name before the first occurrence
>>>>>> of '.' - as a key. This way btf_encoder__find_function() always
>>>>>> returns a valid elf_function object (or NULL).
>>>>>>
>>>>>> Collect an array of symbol name + address pairs from GElf_Sym for
>>>>>> each
>>>>>> elf_function when building the elf_functions table.
>>>>>>
>>>>>> Introduce ambiguous_addr flag to the btf_encoder_func_state. It is
>>>>>> set
>>>>>> when the function is saved by examining the array of ELF symbols in
>>>>>> elf_function__has_ambiguous_address(). It tests whether there is only
>>>>>> one unique address for this function name, taking into account that
>>>>>> some addresses associated with it are not relevant:
>>>>>>     * ".cold" suffix indicates a piece of hot/cold split
>>>>>>     * ".part" suffix indicates a piece of partial inline
>>>>>>
>>>>>> When inspecting symbol name we have to search for any occurrence of
>>>>>> the target suffix, as opposed to testing the entire suffix, or the
>>>>>> end
>>>>>> of a string. This is because suffixes may be combined by the
>>>>>> compiler,
>>>>>> for example producing ".isra0.cold", and the conclusion will be
>>>>>> incorrect.
>>>>>>
>>>>>> In saved_functions_combine() check ambiguous_addr when deciding
>>>>>> whether a function should be included in BTF.
>>>>>>
>>>>>> Successful CI run: https://github.com/acmel/dwarves/pull/68/checks
>>>>>>
>>>>>> I manually spot checked some of the ~200 functions from vmlinux (BPF
>>>>>> CI-like kconfig) that are now excluded: all of those that I checked
>>>>>> had multiple addresses, and some where static functions from
>>>>>> different
>>>>>> files with the same name.
>>>>>>
>>>>>> [1] https://lore.kernel.org/bpf/2f8c792e-9675-4385-
>>>>>> b1cb-10266c72bd45@linux.dev/
>>>>>> [2] https://lore.kernel.org/
>>>>>> dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/
>>>>>>
>>>>>> v1: https://lore.kernel.org/
>>>>>> dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/
>>>>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>>>>
>>>>> Thanks for doing this Ihor! Apologies for just thinking of this
>>>>> now, but
>>>>> why don't we filter out the .cold and .part functions earlier, not
>>>>> even
>>>>> adding them to the ELF functions list? Something like this on top of
>>>>> your patch:
>>>>>
>>>>> $ git diff
>>>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>>>> index 0aa94ae..f61db0f 100644
>>>>> --- a/btf_encoder.c
>>>>> +++ b/btf_encoder.c
>>>>> @@ -1188,27 +1188,6 @@ static struct btf_encoder_func_state
>>>>> *btf_encoder__alloc_func_state(struct btf_e
>>>>>           return state;
>>>>>    }
>>>>>
>>>>> -/* some "." suffixes do not correspond to real functions;
>>>>> - * - .part for partial inline
>>>>> - * - .cold for rarely-used codepath extracted for better code
>>>>> locality
>>>>> - */
>>>>> -static bool str_contains_non_fn_suffix(const char *str) {
>>>>> -       static const char *skip[] = {
>>>>> -               ".cold",
>>>>> -               ".part"
>>>>> -       };
>>>>> -       char *suffix = strchr(str, '.');
>>>>> -       int i;
>>>>> -
>>>>> -       if (!suffix)
>>>>> -               return false;
>>>>> -       for (i = 0; i < ARRAY_SIZE(skip); i++) {
>>>>> -               if (strstr(suffix, skip[i]))
>>>>> -                       return true;
>>>>> -       }
>>>>> -       return false;
>>>>> -}
>>>>> -
>>>>>    static bool elf_function__has_ambiguous_address(struct elf_function
>>>>> *func) {
>>>>>           struct elf_function_sym *sym;
>>>>>           uint64_t addr;
>>>>> @@ -1219,12 +1198,10 @@ static bool
>>>>> elf_function__has_ambiguous_address(struct elf_function *func) {
>>>>>           addr = 0;
>>>>>           for (int i = 0; i < func->sym_cnt; i++) {
>>>>>                   sym = &func->syms[i];
>>>>> -               if (!str_contains_non_fn_suffix(sym->name)) {
>>>>> -                       if (addr && addr != sym->addr)
>>>>> -                               return true;
>>>>> -                       else
>>>>> +               if (addr && addr != sym->addr)
>>>>> +                       return true;
>>>>> +               else
>>>>>                                   addr = sym->addr;
>>>>> -               }
>>>>>           }
>>>>>
>>>>>
>>>>>           return false;
>>>>> @@ -2208,9 +2185,12 @@ static int elf_functions__collect(struct
>>>>> elf_functions *functions)
>>>>>                   func = &functions->entries[functions->cnt];
>>>>>
>>>>>                   suffix = strchr(sym_name, '.');
>>>>> -               if (suffix)
>>>>> +               if (suffix) {
>>>>> +                       if (strstr(suffix, ".part") ||
>>>>> +                           strstr(suffix, ".cold"))
>>>>> +                               continue;
>>>>>                           func->name = strndup(sym_name, suffix -
>>>>> sym_name);
>>>>> -               else
>>>>> +               } else
>>>>>                           func->name = strdup(sym_name);
>>>>>
>>>>>                   if (!func->name) {
>>>>>
>>>>> I think that would work and saves later string comparisons, what do
>>>>> you
>>>>> think?
>>>>>
>>>>
>>>> Apologies, this isn't sufficient. Considering cases like
>>>> objpool_free(),
>>>> the problem is it has two entries in ELF for objpool_free and
>>>> objpool_free.part.0. So let's say we exclude objpool_free.part.0 from
>>>> the ELF representation, then we could potentially end up excluding
>>>> objpool_free as inconsistent if the DWARF for objpool_free.part.0
>>>> doesn't match that of objpool_free. It would appear to be inconsistent
>>>> but isn't really.
>>>
>>> Alan, as far as I can tell, in your example the function would be
>>> considered inconsistent independent of whether .part is included in
>>> elf_function->syms or not. We determine argument inconsistency based
>>> on DWARF data (struct function) passed into btf_encoder__save_func().
>>>
>>> So if there is a difference in arguments between objpool_free.part.0
>>> and objpool_free, it will be detected anyways.
>>>
>>
>> I think I've solved that in the following proof-of-concept series [1] -
>> by retaining the .part functions in the ELF list _and_ matching the
>> DWARF and ELF via address we can distinguish between foo and foo.part.0
>> debug information and discard the latter such that it is not included in
>> the determination of inconsistency.
>>
>>> A significant difference between v2 and v3 (just sent [1]) is in that
>>> if there is *only* "foo.part.0" symbol but no "foo", then it will not
>>> be included in v3 (because it's not in the elf_functions table), but
>>> would be in v2 (because there is only one address). And the correct
>>> behavior from the BTF encoding point of view is v3.
>>>
>>
>> Yep, that part sounds good; I _think_ the approach I'm proposing solves
>> that too, along with not incorrectly marking foo/foo.part.0 as
>> inconsistent.
>>
>> The series is the top 3 commits in [1]; the first commit [2] is yours
>> modulo the small tweak of marking non-functions during ELF function
>> creation. The second [3] uses address ranges to try harder to get
>> address info from DWARF, while the final one [4] skips creating function
>> state for functions that we address-match as the .part/.cold functions
>> in debug info. This all allows us to better identify debug information
>> that is tied to the non-function .part/.cold optimizations.
> 
> Hi Alan. Bumping this thread.
> 
> I haven't reviewed/tested your github changes thoroughly, but the
> approach makes sense to me overall.
> 
> What do you think about applying the group-by-name patch [1] first,
> maybe including your tweak? It would fix a couple of bugs right away.
> 
> And later you can send a more refined draft of patches to use
> addresses for matching.
> 

Yep, sounds good. Better to separate these changes; to support that I'll
add the tweak to your patch where we record but flag .part/.cold
functions as non-functions in [1]

If no-one objects, I'll land that in pahole next later. Thanks!

Alan

[1]
https://github.com/acmel/dwarves/commit/e256ffaf13cce96c4e782192b2814e1a2664fe99


