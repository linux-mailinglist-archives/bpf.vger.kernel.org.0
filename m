Return-Path: <bpf+bounces-54439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55CFA6A306
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 10:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A285019C04C1
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467A2202984;
	Thu, 20 Mar 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c+CC+hn4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xg4x8H7X"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6779C4;
	Thu, 20 Mar 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742464510; cv=fail; b=ODhpHPKlBCps3cLsHjYwo00+V0DUwMplkai36E7KR+SFvQ3OsEURx/dh0DbyZRwd23JH9IRu81kG6vztgJuueLqwIAWxQtbs4GtOtxAh6F8LvAILCEp2jRObTEgt/w2dN6ylspvug6FC41NIu0t464iXrex/YknPo3jg7GTbPKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742464510; c=relaxed/simple;
	bh=PvE1giQ0xcN1y/bnHSmYfWydrTQ8z1VzZyazR5yabmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EKz7BC56+9pOvmB6jN0IZQnZV6iTCzn1ZX42olQ8q+F9IQJb2BmUadLY5ZetRzaQeoWFhkhcdRac0yx4RiJf5Cn2gnY1AlnCintjcI7MiXr6Gp95mpfBXwTgCOXUES+J5ZmKWTRSFy0dDqxmtAW0SsDs8mkvR5CBir7J0rp1CQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c+CC+hn4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xg4x8H7X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8C5MY004897;
	Thu, 20 Mar 2025 09:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=++EQEY2M2sZsr8IQxOBDAqMS6UaFO/4cORs3x3INN7g=; b=
	c+CC+hn4ikQSfG6Oh5pbus2GBFbhtOBXRZ8Tnf/HWaxTuBnuBM2J0+BvRlxuS2VW
	EB6QyOeAuljHP6Yfp/L2SyKrSzLAozVI6lOTfmNlMlxBlvyf1lS1gB47O3zjl99c
	l6Xm6D7XVbu2i36lkzf9TfJLwooN+i388zW3Vz0wmXUqk7IhnDDdx5pcY3oFcP6v
	umdSpn1RT18cNVTKs74YxIacyawPRfXTInMX0fxvlk8HYTmLt+S8jeIx15r2Amez
	zV6BAsP/dC+I/a1cNvT4A5LBf+fw7bHz5W/t5m06YI21b7K1bMfoDCdvqK+moA0S
	quIZhvVIX2MRdTRJOCR+ag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1ka5s3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 09:54:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52K97K1E022435;
	Thu, 20 Mar 2025 09:54:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxej3by6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 09:54:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F81KFP4nyEf0NpEdg3b/+yEhRU2vg88HDJV2Iq6s9rcCGX3HYUbZHXq1C+X5tZcoLtazcIP1N++Rz1z14VxzE5NtKiersmDqd924RHLxvYsp9ZYCVqJpf9k8hgUqB3DoVYaEFnQ+ULoJs8MWdFIAEZTimCcHgEVVVCBQlG/eILQKkqzJn3b2FRYHTNZui6hI53WQxEDeFoW+CzjdcyGNWgrCdu9PQoVl7e6emWZMmID/yt/o4tJPEedW78CYSJ9TyI5e0avvBL9U35W0hH8MYZcvyt7MQrPoyRNDhIMiQf7Zf+rFD+jlmFCulCzR4YoZtYwQINQWGhVSfEOLqzj1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++EQEY2M2sZsr8IQxOBDAqMS6UaFO/4cORs3x3INN7g=;
 b=jeGsTN7CWF+cz19fvj57beqaqxYfdTyi0YXZtc+BLUz+Yf26UgtQ3ZLiCDf6Jfo7QvuoSlo4CPxGobd6aE3cNa1JWyExJHAdCN49wAvoufApN3PyAoX4qMEUHQ1MsXiFuYGnUgBRxZvAwMKJDAR+0z6X48M78RKtMH5hANavKNd38CwThirJj4ZXdPYnSjDnTl5TCX9yyvdZla2FGLKDZ+u1Fb7ASwgHT+zabeRVU6oVfl68jo/RnNuSllTodD4BQjT1E1Kugu820i6maV21iUehPfFlRlw/7uKFUOQD4yTImIrfZsoJF5Gglu8aCvxkAix3aSV50ARhDkRdHnAEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++EQEY2M2sZsr8IQxOBDAqMS6UaFO/4cORs3x3INN7g=;
 b=xg4x8H7Xg+rjcyMjUCbWDoCwu4u3jH/Ti8s7Evm9kY4NMjQxXX+5O3HuSBZ6rWb2UklpCga3SralTvFzMNNjm2MiiCh/yquvWFX8KcBSccUW2ar9bfQZhMoE0lip9EGNhSdFR07z6L7s4EyT/N3KVkvghyVU4C+nB765EIGRxMI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN6PR10MB7544.namprd10.prod.outlook.com (2603:10b6:208:46c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 09:54:44 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 09:54:38 +0000
Message-ID: <45881882-46d2-43ca-b833-439363926c87@oracle.com>
Date: Thu, 20 Mar 2025 09:54:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: Filter out __gendwarfksyms_ptr_
To: Sami Tolvanen <samitolvanen@google.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: dwarves@vger.kernel.org, acme@kernel.org, yonghong.song@linux.dev,
        ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, song@kernel.org, eddyz87@gmail.com,
        stephen.s.brennan@oracle.com, laura.nao@collabora.com,
        ubizjak@gmail.com, xiyou.wangcong@gmail.com
References: <20250317222424.3837495-1-samitolvanen@google.com>
 <Z9lCVHIyjLjQ4BOs@krava>
 <CABCJKud4e_bBvOrXSrOmkiw+XX8DJzKBC=nxmNP7e=GusGEkOw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CABCJKud4e_bBvOrXSrOmkiw+XX8DJzKBC=nxmNP7e=GusGEkOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN6PR10MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 167e540d-e139-4763-808d-08dd67953a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXE0c3ZrNjhvUnNOVHNYNm5BZlZYUnJFdytPaGJjTjY1OHcwdUJIRDNFUGdi?=
 =?utf-8?B?UGtaekIvLzZVVUV2TzNqQVNrZ3lWOXRkSmkxbkJaYzUzSENaZWFSZnVtWjNE?=
 =?utf-8?B?ZXF6amNUYmdpU0RKZmJVWm14cjc5TmdLeUNyQVllSDVOQyt1WEF0SlE2T2RH?=
 =?utf-8?B?dDNjT3pDWDBzQ1JnN2ltZTdVZlRxMFlFZ05ibHdRamN0bldISklNbkN0RDNj?=
 =?utf-8?B?SjBsbmJKYTNoWkJPUFFnOU1DRUhnQVlCak5aeGczVjhya0FMOXc1NWZFbWpS?=
 =?utf-8?B?QXA2b2NxSlZhTDlmWG9aWHpwQU16WDVQY0NISU15Z0pNdDJTN2twdXJHNDNk?=
 =?utf-8?B?bE9QUUV4d2g1VWgxS09zQUltZzlyUDdNRzBoNVRNd3ZrZm1Jc3IwbEUxQnE3?=
 =?utf-8?B?cjhHNDFCMnVyR2hId3JxREJoRWl1elkxTlpBTFRPQXg4S2NvdmpjL2VSa3pj?=
 =?utf-8?B?Z3lLVk1kNUtocnFCemRwV3JMU05LQW13NjBmWXA4ZGNNT09RY2JEQmFsMldq?=
 =?utf-8?B?RlhSQlg2KzFwVnErSksvWWh5UzViOUN2Q0t2OUF1RVZ4OWJwR3pvV2w2OVQr?=
 =?utf-8?B?L0VlN3NtOXZoK2M5QVU0ZU1QbVFpOEpzNGtkTlFvVHo0eFVja2R5clV3RElm?=
 =?utf-8?B?dWJDQ1YxUDM2NEdNa3FwRzBkZWRXNHEvaG5PK0FaTktadFlzWXVoR2dJR2tI?=
 =?utf-8?B?QzV0cDFGQ1J4bU1WSEpVNE03ai90ZElRczhTd1doQ0FhYm94eGcxWTBwWks3?=
 =?utf-8?B?ZEtoTFpoTnA3cm1Ma3p2dG1WRkJ4c1hCOHdzV3FxVE9WVGk2aVkyd25qdmNS?=
 =?utf-8?B?N0VBVkN5cGZIVUNxaytPUjUxRWhDSWxZUnhlVTdSVE9uZzVaZTVEZW5Iekla?=
 =?utf-8?B?QVd4SWYxV0ExN2hFcE1hNUoyM05YQzdkMjI2RDNiaHc4VkVOc2NVZFhONWQw?=
 =?utf-8?B?YzlWOHpRQWRmTk5SS2tSS1U1WGlFNjc5Y0loUFZpRXd3L1BBeXhOWGpPSU51?=
 =?utf-8?B?dVNhUUxqaTgxSEI1eGtpL1MvTFpUbFdIWitvUjBVaVYvZ1RjR3I3QjM5S2J6?=
 =?utf-8?B?WVgxckZuOGdLem1SNjNsYkVuRURpTkdkNnBxYklmMkVoa2M3dFRGRnJEdjRX?=
 =?utf-8?B?a0VKY0U1bjRIUkg3RllRUkFJa01ERnpvMVBwSjZMbm05K0N5eW1uQlN6Z3Vk?=
 =?utf-8?B?MVMxQXFyQkVQTkhhSWxhcXRIWmRXZ0ZhS2J3ajcyL2JyRU14T2FPSkFSaUpa?=
 =?utf-8?B?UFIxUXJPL0NOWVM2UUQ0aUFFcE10cHl2ZjVnNXp4U1hVb3JpaDVIZWZmL2Nx?=
 =?utf-8?B?VGxQMUV6MTIxTGNhQnovbElaa0U3ck9QVGhpSjlkUEpKcTZxQXRVOEE2cnhU?=
 =?utf-8?B?eHdUenRNSkVsbytUb1JPS3FLdG53MVBhdlBvQUdQb3p5MFE1MkhwbER0cWM3?=
 =?utf-8?B?SysyUDhzYzJwcm05WG1VcHJ3bkk3dy9GRDRoVnp4cUZNci9TeDVCMGFHd3dz?=
 =?utf-8?B?NTc5TWxtZmhXSXVKNTBpT1hSNm95TEs0cDhKdWtOKzR0OHpLT0dYL3UzY3ZL?=
 =?utf-8?B?Ti91MzVVdEEzUnRzKzhBWUt0eFA2VWdiQmh1WXJ2Njk2bXRIbHFWQlFtNFcx?=
 =?utf-8?B?NFpXSlBZb3JiMkFrVXBhc3FQeUxVUlg0ZmcxcEd6eEtyTUZ2VmJXNnBNT3lZ?=
 =?utf-8?B?c3FEVndTRzk2bWRJTHpSbWZBblMycTlCUmtBWWFjemZrRURSK1Bla01ycGJM?=
 =?utf-8?B?TzNoam1ldHlhRDFiTm5PZ1lhMEF1cG8rMTlna095SmVmakdNMGRBWDNHcTZi?=
 =?utf-8?B?ZXAySThSZEEvOHZXMWlWZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3lTMWhjWm9kQTdKaDZ2TjZBZnVIaFJlN2RHZFNpdVZWeE1tQVBOWjJnaEFO?=
 =?utf-8?B?MFNCbFZrSnp0TWVPZVlGUFpjS1RYMUVKTWFaeXFlSHkvclNtcjVDeDEyQ3hu?=
 =?utf-8?B?WUVPY2ROaEoxQ3h5cjYxcGJpVzFpaXRYWFRTbURFTlJIWFd1ZHg2RUhiWEor?=
 =?utf-8?B?YzZUTFl3czhRdlZNdkJ3aEwvWG9sbHlBeDJuU3gwdVdPcU1PbkJGd0s1V1VF?=
 =?utf-8?B?Wjl6TkxlOHFyanhISnVEdmdEK04wR0RVUDY0T29ORFkzSnJQbmh3cEMwRXMx?=
 =?utf-8?B?azN6NFNraHBRUmE2dXY2ODBlcytETHpYdm8xNW5ja0RDNVB4OHMyMTlMN0Rh?=
 =?utf-8?B?MW9lNVV3MC9jRjNFM1haVWpqWHZTQU1FTUdaNDdjdHg2QlNpQS9CSW1WVUhq?=
 =?utf-8?B?TTVrNUd2TGE5VGRmV2xPODJLbGRGbHVpcHRjWFFlUE1OdUJnWGxCV1lpMWF1?=
 =?utf-8?B?M1hsTTY3VWF2RDh6RUsvUU5HT3pScFpmakpnNUhUcjFGZzUySENzNUpEbWQr?=
 =?utf-8?B?NkppNm9YS1daeUoxaTRJdkdnVDdoQzFwQmd4OGxhb3N0YlFyRVVMZitLT2pz?=
 =?utf-8?B?b2piaXZJQTJEQjd5WXBhN05YZDZBQ1kyWnlFcEkwZXk5YldDd1h4QmxYeTh3?=
 =?utf-8?B?MWVjQmVibllWbGs5MjF1YXJ2QVBmaGIwWlNvQVViTUtqY29VZWxJNmFSRHZL?=
 =?utf-8?B?aWNwTnpybmQ4djgraVhYdEM2UldHSUwxSjdQbVB6MVdjOXRWN1pjVndlS1Fl?=
 =?utf-8?B?eDVMbHJJK1ZwR0QycHZTN2JHV3YwTDM0UHE1VDN0bUlvdXVBT0tQK0tMVU5E?=
 =?utf-8?B?cXZ4citHOW9MeEFnQ1ZJZ2tST2pSVWdJMXlub0pSNGpYVUpFekw3Z3pXcGk0?=
 =?utf-8?B?dVRBdmZGeUtYMWZOQzF5Z0xwZmhlai9xejh3RGJHUjNMUmxyQlhweHhFTUdO?=
 =?utf-8?B?bndURlN6elhud1RGTzF3TVAyL2JuUzRKa29qN2t6RlRxMm9aRUpKNURGS1Yw?=
 =?utf-8?B?STFkZHRQNU9UZ0dweWh6a2E5ZUM5R25DYzlRMFQ2Z002eVJ5S1BIRExFM1ZR?=
 =?utf-8?B?WUlKTW1PTWlBSzhzWlFNOUY1NWUvSFljbjFESjh3ZHBnTVllalNyQXJ5M1Aw?=
 =?utf-8?B?R3pMeS9URVk3ZGtzS3dZTkh0WEdtQW1aTTJGYVhyVFVCQXJwYjMyeHVwOW91?=
 =?utf-8?B?VmN2MDNJMXZuK3pzaWY1QXVqZ2Zwb255Y2dVaHRqZmNOdTlNRy9mNUx6ZmMz?=
 =?utf-8?B?M3dwa0dIanFIQVFnQm0ybkhkbVBSOWFON0NHdjlMYTNUN1NVSWRUeDNlRmQz?=
 =?utf-8?B?QzRxa2JHSjJsampKOWNYYlR4VnUyUDVzSm1KY3hjdFJsK25zUGxvWk5xdXNG?=
 =?utf-8?B?a0hZOGFVdUc1SUoyMkNiOVowcXk1Lzh4MkF2SE5ReEpZbDdEOEMyOWcybTRV?=
 =?utf-8?B?bnlkeElLSlo4emtlWUZkekdnSk9pVm9KMHhINzQvRmpEbXdLc1dqY0N6M3Q2?=
 =?utf-8?B?V3FTZGxoamhKTFhmUC9VR3dxYUtrdlFiL0dyM3hnbkFDUmhuTEx5ZW9KcjNm?=
 =?utf-8?B?L0x3amlmcENSdGozZmJLbXkvRzdxNWM1NnJha2pGb21RUEo3RkNKUTJKZHVN?=
 =?utf-8?B?VE50YnN3K3IxNUpNZXNCYkpQQTdqSzNUbER1bUhwRnNTRjVCWElxbURielgx?=
 =?utf-8?B?U005dS9iMVBHbWFsYklIVkY5eWd6VWZnWWNyYlo2TkF4dmViclpvdCtzSGRp?=
 =?utf-8?B?eUZ1V3REVTVQa1lFZ3d2aVZRTTVNV3Fhc0ROOUpDTk1NbDhtR05CbE9HYjU0?=
 =?utf-8?B?UFRoWUhDMHhxTDh0anNtYUZaZTZQTnhoelYwNXFtOGpuYWE0ZDA1WHZjV1h3?=
 =?utf-8?B?U1ZFUEprdEhjakxod2hvdExsamkrT0w2dVRiYnRMRUlnQWFCNmY2L0pLSWFw?=
 =?utf-8?B?K202alFtRkRqRE5ESXVZNXN6VmxHd1h2Vkt1N2RhZGw1bjNNMjlzTG1zbC84?=
 =?utf-8?B?NTVMeStCeE9wL3FTVGJ6bnlnNkJ2ZTljR3oxK2dqbGVFQmZmdXg0cXFabG43?=
 =?utf-8?B?QWJoamlLNCtKU0ROSThRWGFSUkNSZGNqdzlZMDZ5Y2t5eTlvNGg2NjM4OFhM?=
 =?utf-8?B?enZRVWE0MWp6Tktac2NheWw5bXBoRjN1TGFTWjdWY25sU1Z1SXFrVndwRmFM?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eakRxd0phEmXNfJ8FbJ5Tadjjq6tP/T1XYSbWGpk4YN/9KTeLLPulBhg/G6bUiNUIsx04hFpIGugRYEDKDVlNfeFQ8D/EcjuD2Q9bB4CctmXuX7bBRPxo6EwCQ/RIH9fyl2I425YAWwdbN+nR1qL6K7LrIh2hz//E43hl0RiuVxBDkRmz1TjtiFR6vGWkHBt26mai2Jgl+V6nEWOrfumnRfHpVPlWRfF8TRU4MhSNPPN/VOTdkH0qriLZq1+B0bqRnWmVFVdG2CDXMtBGAkwBZATuC6rb5yrO2wxOQ30ViJ4AK7a0V4naFjn5oYxxfAJLre2JjK0Fr2c31ZTgIkRW+MKU9+19DWC+sMlG/TUZCv1SSrHmQBoI5jj5rpe4oPNmRqarC5CkTgIuiLeiyYBSo78r1VTOG/Wl4mm67USJQj3yA4UiwXiKnJSQa3iBEppSmi7aAfSQbH3VG5jas/Zj03uL4i4l/Nbw9SF9U6l1yJZN2DG1LDYOF/KJc1GbcCptx8pXCGnwVYUf2iksYUcF2rqT/LrqXj+UE+eCzLVVdk7JwtgfVaanxnDNR4kB38ZMQDihosM5GzGf34rVohnMveq3TAwT4Y6BMkzyrv1uqk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167e540d-e139-4763-808d-08dd67953a2b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 09:54:38.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ix9xpQuxWNJ4JKyxvLAaBzMzrJzslC7S4dsd9Bvg8FP6RShFsHM5mmtcdMd09H+78R5u8LMEigCuPxW5TwTh/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200060
X-Proofpoint-GUID: -KetNE4DBerhHw_HlA1Glv7xMup1UgQK
X-Proofpoint-ORIG-GUID: -KetNE4DBerhHw_HlA1Glv7xMup1UgQK

On 18/03/2025 16:14, Sami Tolvanen wrote:
> Hi Jiri,
> 
> On Tue, Mar 18, 2025 at 9:52 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>
>> On Mon, Mar 17, 2025 at 10:24:24PM +0000, Sami Tolvanen wrote:
>>> With CONFIG_GENDWARFKSYMS, __gendwarfksyms_ptr_<symbol>
>>> variables are added to the kernel in EXPORT_SYMBOL() to ensure
>>> DWARF type information is available for exported symbols in the
>>> TUs where they're actually exported. These symbols are dropped
>>> when linking vmlinux, but dangling references to them remain
>>> in DWARF, which results in thousands of 0 address variables
>>> that pahole needs to validate (since commit 9810758003ce
>>> ("btf_encoder: Verify 0 address DWARF variables are in ELF
>>> section")).
>>>
>>> Filter out symbols with the __gendwarfksyms_ptr_ name prefix in
>>> filter_variable_name() instead of calling variable_in_sec()
>>> for all of them. This reduces the time it takes to process
>>> .tmp_vmlinux1 by ~77% on my test system:
>>>
>>> Before: 35.775 +- 0.121  seconds time elapsed  ( +-  0.34% )
>>>  After: 8.3516 +- 0.0407 seconds time elapsed  ( +-  0.49% )
>>
>> makes sense to me, I just can't reproduce the speedup
>> could you please share your .config?
> 
> Sure, here's the config I used to repro this:
> 
> https://gist.github.com/samitolvanen/dca66a1a779861be27579f88c9b6ba5d
> 
> This is essentially x86_64 defconfig with GENDWARFKSYMS and
> DEBUG_INFO_BTF both enabled. When building this config with gcc, we
> end up with 0 address __gendwarfksyms_ptr variables in DWARF:
> 
> ...
> 0x0001b5c6:   DW_TAG_variable
>                 DW_AT_name      ("__gendwarfksyms_ptr_system_state")
>                 DW_AT_decl_file ("../init/main.c")
>                 DW_AT_decl_line (129)
>                 DW_AT_decl_column       (1)
>                 DW_AT_type      (0x0001b5dc "system_states *")
>                 DW_AT_location  (DW_OP_addr 0x0)
> ...
> 
> Note that this doesn't seem to happen when building with Clang.
> 
> Before commit 9810758003ce this resulted in pahole thinking all these
> variables are in the .data..percpu section, which resulted in
> btf_datasec_check_meta() failing with "Invalid offset" during boot.
> pahole/next doesn't have this issue, but validating the 0 address
> variables is unfortunately a bit slow when we have a lot of them.
>

Thanks for the fix Sami! I've tested it at my end and can reproduce the
longer time for BTF encoding on x86_64 prior to the fix and its
resolution. Let's wait a bit longer before landing it to see if anyone
else gets a chance to test/ack it, but I think we should probably also add a

Fixes: 9810758003ce9f ("btf_encoder: Verify 0 address DWARF variables
are in ELF section")

(no need to resend for this; I can add it when committing it)

I'm thinking we should also try and incorporate some performance tests
for vmlinux BTF encoding into the tests subdirectory to better catch
issues like this; perhaps the CI can baseline encoding performance on
the next branch versus the branch that has the changes..

Thanks again!

Alan
> Sami


