Return-Path: <bpf+bounces-76711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F41CC3252
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 14:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA3B5302F20E
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25667339840;
	Tue, 16 Dec 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eUV9xrR6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YJxEpHHb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387533A9F5
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765890555; cv=fail; b=YPbwWyH4uRh5E7mv+N6lx5veskfXUyot1Fdb4oHZu6M+1oJDi+GyIivbcBgx2ebpUvVdYockm/9UE9gRoMHJ/UlJ4BeLeFic23vOKA1Nvqia9l9q3jjz2/KBT+0z0fGEmea18UAlor49EiYIM0NbbqsURu1oSWbplilauVSSl6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765890555; c=relaxed/simple;
	bh=sMC319nVU+33tDgHdUWXsiPJym7UVzlVXcA6OG+P1E8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mh8HY91QSFGqYFw9yxxryjyml1GcdBHUipj/rwpwWg5wyRRGGsvTj7ENOjHLVOYWpiRBAK26uU3idaQLSZOT/d/PsEdruiSpOWOv7b5g71sTs0uNiu9XazujJOu+AaPzLLMaEg1Hp9QJfOuOKQSRYVJrO/LmpMPpbs5rSpCBaEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eUV9xrR6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YJxEpHHb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGArvXI241220;
	Tue, 16 Dec 2025 13:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HEWJ70ctgQGwH8+YtiQEDwpCp8V4h1zW+dauqgNgXuc=; b=
	eUV9xrR6xrQbNgOJZymPbV5lfWxcHFn+SJbkBsytw9PiZZJNcMCf6Qx0YEqLwn79
	SykT5O7KSeZD65ryPw0ONnjACYXhE/iWdTpYkSqCl61DJS82XX8yltwDEH6Wymz2
	HAvjjRv7Q62pUKmABGRqqnAxf88opBWRakoqF5jm//N3ixFyji7NUbEUz/0wYvtn
	x3du4qOJeHCdqZgjvRMJtZrk95DwP7hx2bFSlxoUvCDosT0Hr5jBtalnazLp8WSI
	6WeWn3RX7f/u0Crgl5eW+sSxE9FSsKCNjQXIaNkTV/Eqet+va70SzhNCDe4y5F75
	LJQjSukRvQWwQdVRcjscWw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015uw9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 13:08:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGBrOPm005996;
	Tue, 16 Dec 2025 13:08:51 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkd7k3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 13:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8dQ7rV6VyXrDvQgpu5vO/SKqpvmOE8Cq0yZBg5uv5BFoTPk76alz+uWaA6jXoO9vWlDEzxRchuRU6s9ItS7sGKIItCUAp6L5tK5MszIsHLrHaaAnOXZNwhY/Ifwlj7rY9Qkn39RbKiuM4cCHFqgMlHIZyRVXVM6QxiwuVuQZy1ZtHajX5c4I63WFvpwxNblSy4FDZDDwDebNphd63cxDnh9h/nA5jdZWqRfPXHxeThJvTzUoA+ow/q2tHA2RZ1y9SjspRRU4bKFfwgMJ49RnAGurGENCswTu4FMzFp/8nPQd6cOKNLHzwqPtlLD3Hs/NuRne/xYFsn0wuynB4xBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEWJ70ctgQGwH8+YtiQEDwpCp8V4h1zW+dauqgNgXuc=;
 b=YaMGOdIzpjDmWaii6GvGgl0hYY6K1Sw2pkedTYLFnGq13UkXgnAhhS9MculaT2dl0xmkeOy0YeqPHU3WlT0yqgQUb4a8XsJAvtbD6bcOq9iuku5W3+1tQt4TdB2sN7YsJGSpsq41Q2HkVQx16UU4O153f6Nd2SDCaWv8p4jhF774RRmHEtKydvujzmJPju0O3/CpjwITViNYNjPXsnhZohdvuabzjjN1mY75oLSZHgnBLiFcIm/kNv0kgWGn4WH1AF1GyT1muhmmslutPA8Jmfj+GVD0kPrFaVw0/4BBl+6InZ1Em7xoBd56pJ4KsLa8nvqVzrlgn/Y11XpXl8ppVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEWJ70ctgQGwH8+YtiQEDwpCp8V4h1zW+dauqgNgXuc=;
 b=YJxEpHHb7OH5lbpbazAdC/fBnxVYnrS7D50c1552C+UwvF/kvF0WpF9OtpHcvQBKidX/gohbkh6XTaHY9L9A/qrDeWUcmkg/xq7KeDiwdRetMeuuoWXNIvwsiogvLCFlSh9FE1bAjDq1v+0ClngwOuo277CmozImmG/+8l5yG4I=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH3PR10MB7332.namprd10.prod.outlook.com (2603:10b6:610:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 13:08:21 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 13:08:21 +0000
Message-ID: <af630740-eada-4a2b-8846-3d1a17f198f4@oracle.com>
Date: Tue, 16 Dec 2025 13:08:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: fms-extensions and bpf
To: Song Liu <song@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
        bpf <bpf@vger.kernel.org>
References: <CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com>
 <CAPhsuW4MDzY6jjw+gaqtnoQ_p+ZqE5cLMZAAs=HbrfprswQk-Q@mail.gmail.com>
 <CAADnVQKHEOusNnirYLuMjeKnJyJmCawEeOXsTf2JYi4RUTo5Tw@mail.gmail.com>
 <CAPhsuW5WohBuOKbHs-GoT3vsaj0RqhY=MD8=+NKqGbPizu1ihw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAPhsuW5WohBuOKbHs-GoT3vsaj0RqhY=MD8=+NKqGbPizu1ihw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0399.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::8) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH3PR10MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: b08aa196-d00f-472f-46e9-08de3ca4302a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U01sdWhrU3Z3RkxGZ0ROU3F4WmpvMnJiZTJuOHZTeURVSi85RUZ1ZWk2cWVW?=
 =?utf-8?B?cU82Sktwdnp3NlliUHBDeHZlTlVFMFhiZmFCK3F3c0NJR3VRRlVVSE1JeFlt?=
 =?utf-8?B?NEU4T1ovOFdYSXBoUmFIS3lNS3p3TEtLeUJaQWhxUkdpWGRmc3U3bklVSXBG?=
 =?utf-8?B?TDh2WlVuS3U3V0J0UnN5RktTUWh4TjNyUmZWRGt2S2VrdlVEbHd0cGtGRmVE?=
 =?utf-8?B?Vi92VFhxNVc3YjF5Mnc2THR6aTZ1VmNGSDBnN2dEK2hsUWZweUxDUHlrSGdL?=
 =?utf-8?B?OXEwNGdVL3ROcEtvSDVxUjhSY3gyZy9BZFFjSTNMS0dTMnE0ZlFVcGZHbHBC?=
 =?utf-8?B?NHRFQUsxd1JFbXJacUZuYVNJekhjekhndmJFL0ZVdzNMRWkwdjZnWCtvaHJX?=
 =?utf-8?B?alpPMzRLMjN1RHdlSDV4Zy9FcG16M3hyWjg4M2lENHkxNnFLNW10VzhwNXVV?=
 =?utf-8?B?NDljOStQS0phK3diVEcvS3NiaEZRdUJ4emZ6YlhKL1BYeFpPZlRHV25pZFJ5?=
 =?utf-8?B?NFMzekJLTXJMTEVWQ1FkRFljVzNLUnhDdHQ5Rm42eWh3U1FXQWg2b0xXcmM2?=
 =?utf-8?B?T1FRQkhzTzUxQ0NkWThINmZ2ZDV5Yk1BUXQ2WTBFZjVLUXJlcnBsSG5IRk1S?=
 =?utf-8?B?ZWFtN3BwdjNHVmYrQkpQMXZFL2gxazYvRHNOeHFqaWNOU3BCcERlR1J1SVZS?=
 =?utf-8?B?OERTVTdzaFQwbUJvM2ladnlxSy9MZnh3dDEzVTZFRlNzMDZHNzU2L2Q0TExn?=
 =?utf-8?B?THFJb3ZiVDFmdkZiL1BEcXNmWTgyRzdTL2x5eGcvUkt5eVNVSnAwM1pnSnlw?=
 =?utf-8?B?K3dpLzQzTU1jVEphdkg1eERFWWJ1Mk1QcVZjVi9jdDlTeElad0FSaW5ybXE3?=
 =?utf-8?B?MUc2RXJXMmFIWlhOSVRScXdaTXRiUjBud1QzUjBndGlSS2VIU1FENWlUNGE2?=
 =?utf-8?B?UDBnNTEvUTZFWjRkU2VRY0lhQU9GdlVVYUc1YTBCVEx0SUFhYW5vVzhSRjBF?=
 =?utf-8?B?YVRNTlNSQjUwNGQ4M3E2SnBLenZXY1phVFppTHB0UDl0aEo3QTlZdDdpbmRU?=
 =?utf-8?B?TG15NEYxa29Db2gyMGxUVnJxbkdvZTNpZlk2NGFvemw0bVhUenFRSVBYR0VO?=
 =?utf-8?B?UDVseUVxTFlIeThUanFmU3dCTlpaK0V4c244MlpMc1EvWkxaUHZDS1lRZ0Nk?=
 =?utf-8?B?QmtZNGkyYmszbzN1T21tSHlZNDJ2MjErZ1ZzVUNENFlvb1oxY0tZRkN0VnB5?=
 =?utf-8?B?Rk91NzVTNC9NQUNXWGYyUERUTitTb2FDc2pZbWNDNDNuL3dOVnFmZUo0TXVh?=
 =?utf-8?B?eGNFUFJ0dTJVblVtTENERHorWmpqWWNJS0xJeDZNR3VEYzRjYTBRd2UzcGNn?=
 =?utf-8?B?ODErcjZidEJ1c1hwa1lDVTZDem1sSDlwZ3ErTmVCTy9vV3U5cnJuTnB0SDhj?=
 =?utf-8?B?MG5zYktkWUlCK3hmUEFOM1NkVXFhK2g2dVJaQ2hlT2xna084Q20rbTFxMFls?=
 =?utf-8?B?SU1maVN0U1NBR1FTTVJ3d1gvYWhsYWpmYmh0NE1MczNHV0dOQ1dtQThMQlov?=
 =?utf-8?B?elJ1eWRDbm5aaEVsSXcwSUFjZ0dzSlBzSVY5YnpBYnFjKytoa1BGL1ZHMzc5?=
 =?utf-8?B?OFpGR2lpZmxKR3hyLytMbzhFa0hHaW1OcnA3blo0S2JoTTBTQnNWbkNrVEEx?=
 =?utf-8?B?V2lCQkN1dExjdHJudTRFaU4wREgzTldYWTA5TTc4OTJ6R1Z0L0tHeGo5Ylht?=
 =?utf-8?B?dklzWldNRXNqK3NPd0pCRWRaN25HSDh5SnhaWDF2Nk9zMmpPdEcrQzNvV1RG?=
 =?utf-8?B?cmFTb2JId2dKZERMb1czSDZqYWRMUmFiTVd3NkZJS0tJTnVjVk5WamZPcS9r?=
 =?utf-8?B?SXZuSDgwTjBmUVYxVE1zb3EvbzFqMXRTcmFsUUZHWS9jaDA3NGo0SVdVUnlp?=
 =?utf-8?B?UW1HbFBNYngxN2RjT1VQQTdaRThIbGFMVGszbkk5TElYMCtJMmwvb2ptY0Zx?=
 =?utf-8?B?NjVsRGVncENBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFE1RGEvWXNkaXc0UkNPUTRJTi9NVW05b3VwbmpOS1prb0g2Ymd1UzlnNVp1?=
 =?utf-8?B?aVNhNW9UUTdRNnNhQVhzWkwyellLUGtPdDdBVFRJTXJhMVlRbzY5ZXhyTUR6?=
 =?utf-8?B?SGpRWHdhak9SY1Z6NVZhL0JSd0Y3ZW1JeC9BTWZ1MHdiR0szMklmcm1XVjJH?=
 =?utf-8?B?elpxbHdmckh1Tk9XUVdxTzFsYXVaTC9TK0t2UTVHYStoZE5zeVRqVXhXZ2pH?=
 =?utf-8?B?bGFwSTM0aE93M2VPS2Q1ZHFTVFNkWTByZndSQXJkbnFvUlpzRjFpcGV4WnVR?=
 =?utf-8?B?UXB2OElxYWt0OVZLNk15YnJ6RkN4MVBTOCtVeHVmMExPc1FTSThLVkZaT2gw?=
 =?utf-8?B?U0crKzRFSDVReFJIalNNWnVlNDhwS2RDOEtqN0hjNDRXM0lOSGxRd0tEUUZx?=
 =?utf-8?B?VFRYMC8rd0lZOHBtZlJZTzdrMk9kY0FVeElzKzdJNGQ3cTJFREx0Sk5PY29M?=
 =?utf-8?B?cXZSY3NYbzZSY2FpZ1B1S0lEVndIaVcyRWliTjFzbFA4ZUlrT2IvdmZkSFJ6?=
 =?utf-8?B?UVpMbVdoR2ZoV09NK3F1K3h0R3RUTDIvWGJCOUQ2eUpwdHJDRnpUeWgrUjhi?=
 =?utf-8?B?aUp0SVhHSjQ4bzFLZ0NVOUNBQnlFeXJUcms1NWJmT2RQWmo4SFpWSXNiSSs0?=
 =?utf-8?B?L0h4NGhPYnlZMjRUYm9jWUtOd3lqcVFja0FtVjhSc3d1R3lhOFkweXZBdDVN?=
 =?utf-8?B?dDJaQzU5ekpSRTdieDJNNXRoUU4vaUVJcVA5a2UyZWtWS2o1eVRXSk1oZkhR?=
 =?utf-8?B?YmtrOGtRdFhPZXRmQzdPeGsrWWM5MkF6bnBwcEFBdUcyUkxGNGUrUkxJb3V4?=
 =?utf-8?B?akpIMThSQVhiVkFRUlVLNWRvZXBnaDE3VFdoa09EK0ZQQ2RvWXl4UzU0ZGdO?=
 =?utf-8?B?YktVbzN3MjJxOEkzeEpWSjczNWluZnd6aWtTU3BlSUlUUVoxMlRhR3ROS084?=
 =?utf-8?B?cTcyc3BLZnBhU2FRZkVGTmY3Uzl6WXVxUk5ZTVdVVXdhWlp6eXFiYmVBY1dW?=
 =?utf-8?B?MlZicTdCWUdsTEh4cGRyS3hGUHg5SG9hRmJCZFVZajgvNjJtMWMwK1dSQlJx?=
 =?utf-8?B?c0FHZXRwYWtBeStFUjJMRUJ4WkcyMXpBenJWVjVsS3BJcDdZc0FhWXJYYS9H?=
 =?utf-8?B?MmJJVmNVckx3WStDdTJPZ3NvRWp5ZGtnZE4yT0VtZTNQQUZzZ0lTZlUwS2kx?=
 =?utf-8?B?RWhoQ3lXcWovRStpVzhaSExaZUNDcFVsL0Z6UDdRRk93c2NXM1RsQW5lUHZE?=
 =?utf-8?B?bWpBVWVnb0R6RlExTXp0QVdhdUJMckxQMVBoTDNKby81L2VjcUlNVlc4a2FU?=
 =?utf-8?B?ZWs3TUdZZWNlMFhWeG56UkhsWHBXbE5MNkh1Vy82d2pHaXF1V25GekI1a3JZ?=
 =?utf-8?B?dzYvUWpIZzhWKzEyRGthYU96Q1dMaTJ4Wmc1ekVHeHVnSE04a01BeWFEaW04?=
 =?utf-8?B?WDV1SCs1Q2FBZ2dGV3dRTFVmWnNwMUFERGhKK2d0U2huZDNMdXFiUHg5bHRj?=
 =?utf-8?B?cjFmeUtIRzFMTitUNnlsTE1NaGJvRFBSb2lFNEdPczJ0VnhjcEtsY1ZadTh4?=
 =?utf-8?B?cEpLOXRhdFN4dDlXajNKSlR3Sis2c0pMb0o4cjNRc1Z5Tm4xbUFmaTNVMTRY?=
 =?utf-8?B?WWpLVUhRWGhxOGtPckFoMU9JVXlqbXF1aE83NUp4MjBiMG1tWS9HaktmQTJn?=
 =?utf-8?B?cG1yYkVkNUFvai85RlVPelFaZGU0VDQrWjBMazhMcVNoR2RiS0NEVXBmNGc1?=
 =?utf-8?B?T2xNbkZhT3JSaDUyNEJJeXdrT3RHcVJLbURyRlIxMWIrRnM3Rlp5WFBkMGJB?=
 =?utf-8?B?dU1pODFLL2NuOU15RnRTQ05QZWFyNlZNcUp3Y201N1dGL09Yd3g2cmdmbzhF?=
 =?utf-8?B?dVVPZmU3Y25oSVFNbW52U3o4elVjRFpBNFlqdURXcWNiSzJTSmxMSmhuVDlt?=
 =?utf-8?B?NVZhTUxvdWxYc1k5L1J2NGJyMDhGdFVTdkxUUkNLSzhqQjA1SmlMNHd1QWYw?=
 =?utf-8?B?aE5DTUZqR2ZjSlVyNGsrWjlubmY3eWlJTnNMeHVpZ3NmMHJQbUg0azV3ZHpB?=
 =?utf-8?B?OWQrQzdrSExHYTdLSDlibllVTmthQUMvUWZVLzk4SzVkdlV2YjVkakQ5VjdV?=
 =?utf-8?B?QnRoWWE5UkRRUGFwTXV5Z1pPQWxKVyt3YkFyUXhYYS9jSmNwRlQxb0Q0VjZs?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OOXsiPsmZdEpP+MqfrWgS/jryABQJL8R/gyGzs8JFAYU+bLZqC2ODEXX7B3CBPwjNZTcB8gAmdzKOkJMgd30hHZMYPbK3/4LtEWn1Z2FeWzRkrBZ0b3K3sagH65jnR7UiIjoF74yggMmR2BOBu90BBEWLUKWWpol+yQ15qeQFPHJnnrHons0W1fSYvrrwsWgFnDmLl2LoDAq++x0HGpHNdhDeiM/40yC0zT+FPnxA2UIAE0M41EJrRsh3ohvFnFhN4UNirnp51x+echVXsLZUxl/tOTvu6Azys6m5EJ4T74tApVHGo/RYNkoE+L7xNhh/o1hg0Zz3W8z1UF/bxXWkAQK695SIEYH3mBNuPBEG6KDNGcfHE+zpAMgaa5vZrXKmBTrawMzxc4Gsh8TpvXRlnbyPZZ+FFfc+iYQ+wGbFTibqMrCH9SURs1Iz5ZouHWgkkgq7tND4Wg5vAtUz4eN/c3CAfJNVjIw2bvVLrdjDfaG5BC5zAXOnM9oEJfdA11W6aiudMBLcVnmCgqXLmK1EtAIiBFTonAuilW67EFMDlWU6rYMo+hT1QGNvBx1/+RgqcHzFTo8iDAg11SXAoxZa9hQGCAjEZqk4PF1TMtlByE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08aa196-d00f-472f-46e9-08de3ca4302a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 13:08:21.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZCsT8cImkq9wEYtRQm8tGVrQ/qyfzqNKmwxRqjGavbaxH0PaOK+4NvgypRMNf9Owz/JhHZu+T7y9Ya1lrmUhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160112
X-Proofpoint-GUID: YlZTOkffBuQUBV5-9gr_zmiJe14WMcWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDExMiBTYWx0ZWRfX70B2xcdII19u
 sEJ5ZBDHZWaepb7Dk3xPP+xplu0stPFtllNjWurdCiR5PB/smYwvm/HNp9WnmNtJfcnwVvZsmhW
 awn2YHN+tHRYBHuLT1SAXVTVcu8I7NpOYWZUtlPQW8NSobfhbJJemS61tM2rEqevei6cymO2MpL
 i6d2Bu6Zmvns9L/IebqTUD/a89meTFMjKIrj8igOOVh04/kOCKTzZmR5yLOPRPka1b3pw7Hr614
 BvEgsfTgAs4aOJa3qBUa6xCCQOiOI6TJEn80g/7dXDmoxRSnPqi/3ZGSR/Jk4TwowkloTmMl4Gy
 sWc8gnOKAoFysCw+5Qd0rngdI/i0CYm4zMpmo8UZt/lqo8g2Zu9KJz8aHFaNu+o3Ad1CbayCvJQ
 /Izkk7X4OiQwlB7EElZnDFZRcZVjIyt9lGZMbUeMTccyKrdTZZs=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=694159e4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=WL8gzeQmoxAcXLf3_pwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: YlZTOkffBuQUBV5-9gr_zmiJe14WMcWa

On 16/12/2025 07:50, Song Liu wrote:
> On Mon, Dec 15, 2025 at 5:24 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Mon, Dec 15, 2025 at 3:46 PM Song Liu <song@kernel.org> wrote:
>>>
>>> On Wed, Dec 3, 2025 at 8:30 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> The kernel is now built with -fms-extensions and it is
>>>> using them in various places.
>>>> To stop-the-bleed and let selftests/bpf pass
>>>> I applied the short term fix:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=835a50753579aa8368a08fca307e638723207768
>>>>
>>>> Long term I think we can try to teach bpftool
>>>> to emit __diag_push("-fms-extensions"..)
>>>> at the top of vmlinux.h.
>>>> Not sure whether it's working though.
>>>
>>> Something like the following works for me. But I am not sure
>>> whether it is the best solution.
>>
>> Great. Pls submit an official patch targeting bpf tree,
>> since without the fix the vmlinux_6_19.h won't be usable in older setups.
>>
>>> Thanks,
>>> Song
>>>
>>> diff --git i/tools/bpf/bpftool/btf.c w/tools/bpf/bpftool/btf.c
>>> index 946612029dee..606886b79805 100644
>>> --- i/tools/bpf/bpftool/btf.c
>>> +++ w/tools/bpf/bpftool/btf.c
>>> @@ -798,6 +798,9 @@ static int dump_btf_c(const struct btf *btf,
>>>         printf("#define __bpf_fastcall\n");
>>>         printf("#endif\n");
>>>         printf("#endif\n\n");
>>> +       printf("#pragma clang diagnostic push\n");
>>> +       printf("#pragma clang diagnostic ignored \"-Wmissing-declarations\"\n");
>>
>> what about pragma GCC ? gcc-bpf is gaining traction...
>> will pragma clang or pragma GCC work for both?
> 
> Turns out "#pragma GCC diagnostic" works for both.
> 
> However, I think we cannot use this in the long term, because it
> effectively removes the anonymous member from the enclosing
> struct. For example, if I add
> 
> struct __test_ms_extensions {
>        int ms_extensions_id;
> };
> 
> struct task_struct {
>         /* ... */
>         struct __test_ms_extensions;
> };
> 
> We cannot access ms_extensions_id from BPF program:
> 
>         task = bpf_get_current_task_btf();
>         /* the following doesn't work */
>         ms_extensions_id = task->ms_extensions_id;
> 
> I think there are two options moving forward:
> 
> 1. Ask the users to add "-fms-extensions  -Wno-microsoft-anon-tag"
>     to the makefile.
> 2. Teach bpftool to unfold the anonymous member struct/union. For
>     example, the above code will be like the following in vmlinux.h:
> 
>         struct task_struct {
>                 /* ... */
>                 int ms_extensions_id;
>         };
>

One approach we could take here is add an option to btf_dump__new()
such as

bool force_anon_struct_members;

...and for the moment have bpftool use it by default. Then when libbpf's
dump function encounters such named nested structures with no member name
it anonymizes them. With this approach we end up with definitions like:

struct ns_tree {
        u64 ns_id;
        atomic_t __ns_ref_active;
        struct ns_tree_node ns_unified_node;
        struct ns_tree_node ns_tree_node;
        struct ns_tree_node ns_owner_node;
        struct ns_tree_root ns_owner_root;
};

struct proc_ns_operations;

struct ns_common {
        u32 ns_type;
        struct dentry *stashed;
        const struct proc_ns_operations *ops;
        unsigned int inum;
        refcount_t __ns_ref;
        union {
                struct  {
                        u64 ns_id;
                        atomic_t __ns_ref_active;
                        struct ns_tree_node ns_unified_node;
                        struct ns_tree_node ns_tree_node;
                        struct ns_tree_node ns_owner_node;
                        struct ns_tree_root ns_owner_root;
                };
                struct callback_head ns_rcu;
        };
};

i.e. the embedded struct ns_tree is anonymized.
 
So we end up preserving type access, size etc; the only thing missing is
the name for the nested "struct ns_tree". We could add an option to bpftool
to relax this restriction if needed for users specifying -fms-extension.

Not sure though if this might create any issues for CO-RE accesses to the
fields? i.e. does the fact that the vmlinux.h representation diverges from
the actual BTF have any subtle implications? I don't think so but just in case..

I have a working patch for the above which I can send out if it sounds like the
right approach. Thanks!

Alan
 
> Thanks,
> Song
> 


