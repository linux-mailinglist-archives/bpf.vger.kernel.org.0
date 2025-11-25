Return-Path: <bpf+bounces-75433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C0EC84272
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 10:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C5C3AF55A
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 09:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807472DC769;
	Tue, 25 Nov 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I2lu2a8V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wJpWYKoj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2FC2BE047
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061744; cv=fail; b=cpqjEAH90O08dvh2g20UYnsiRv6pmHS+Wx6WgClCiBe+B48KsSf6Tl7rNf8E+ewWpnlN68P3qcWrudy80p+GSHfYJH9UsBWGbp+XoqPUusJMTAzzXGQ7m14khj1LhNd8h6XXd0AQebhY7iFFcU2iHiN9eaUaHvtBYNha7c51qS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061744; c=relaxed/simple;
	bh=XzMLmP2o3wRKzEGV6OMlGC12I3s5FNrWf92qWVQwsJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YLk8l4oQdJlQh9lo23wp/Tddsf3/aRxwyi9BU+L2yFWMzq4OByCw0B4jA3PWzHgCLPJ9xcooXUdPyKqAMqS1OKKAmaiXKcKghFDBV77TFKchGsbe+JFZeRrleKQQmSAIB4tj1ls4bd/V2zI1pAfn24Ras2w+lx4Nyt9xSd6gCjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I2lu2a8V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wJpWYKoj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1Cu7H2389010;
	Tue, 25 Nov 2025 09:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5C5VXRfeUWfVywS6uf82L/btUPQdURJIxnrUCvq2CJo=; b=
	I2lu2a8VD5YZXWa6EqioGirpJt1gKB4WKMWJIR1xeh7UO0dsbOFdkvXLNymvSFCW
	scvregFkTu1hrooU44iKfi48U8tLRWUUNiL4ajEzHMtXuwH7IBHzqgQgvXywq5J6
	4rRGxZfMRe5huuJf6hEpdY4gnNvr6BPMyfIso+85De8377ySk9RDzKAI+EYvun13
	tubvRKcSsuOsr7nUnGrlZtKL8ZA0fCfUIcR84VGpL/bLhZDeOi6LYA+Zo2i6cuUG
	DAAwfSWXnSRVvWWy2l6dfYNDvkhYR3X8wIPTQMYk3iVLBNeILOPVmyBLQ+lNnm+R
	y2Yr7sVk1M96AwEYmPXkWg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7yhm2a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 09:08:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP8P1Ys032712;
	Tue, 25 Nov 2025 09:08:59 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m96fbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 09:08:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdv4tAdxSdbpC8rmfQEdSMCn/MA2Q3SqvpwEZt7gltHGjeSdzTKUwk8zzUBLmuo/OwT8ZAXoW3iyTPVqC0VN2OoTPVBxJRbLAsCapODWuFRZsg2y7iGVVuxLuaZif/4mVqMxw2MAM+q6U2/ypMTRkmo8Kk0+/efKe7xawgNwt1zeyFPH4OKQ3GGHiC89P6oeauonU7rEQQW7lmWYX3JxHm+dINUp56MlD5+7EUfL0/YMLZfyjw3xPnMAVPC5PN6Jv7MiOW4Ga+bRogiirjc89Z+9JKPYRBeeQOmlGMdJmPLNoXtyL6myLUkgm4qCCl7p/doFRvkrHPnAJKH2w8QSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C5VXRfeUWfVywS6uf82L/btUPQdURJIxnrUCvq2CJo=;
 b=A76jG7AX0KQ3wNBFMlqkqRip9czqhVCVtiY1uKgnE0UEd12MDu4tRidFPJWYxT96j1p/NFKvGZIu5fyWEpnYgiRtPJlySfHxklUr6ctD2qYCYTV3TkuxqgaI/VwF+a/fl1ti4Vuh1CWX4X5ZJDHlGQN1msk9mLKunuqCgmZ5jdP7+AJhs/SFOr/L6XnI9vcAkVjhOCuAgnKK/QOSW3D3X8YQ0APmvYjxFqPLNrUCH0wd/GHzgwsKIy4JBVpY0b9an0/nQs1dwy+5KTM5XDPc6EGBiC9xin9pwnDCww12urcMDMSUqMQbfYhE+y9ZqFCgO+iaf9hDqiqYEXL0FdH7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5C5VXRfeUWfVywS6uf82L/btUPQdURJIxnrUCvq2CJo=;
 b=wJpWYKoj2ALoP2LfzHm/QrX7GYSY3ql3/OwwzcJ67pjIeLDmuFBkApT52tYBAPpLGOKR2LbEpRh//k/vd1PHAxBgRRajqsUegZ6I7BoROeVL0/o5KC4lHVjhqu9CommsvwEcOdz3lJenbVEO/2hvJH1bqkK3vPli06hM2g45YR0=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SA1PR10MB7555.namprd10.prod.outlook.com (2603:10b6:806:378::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 09:08:56 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%5]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 09:08:56 +0000
Message-ID: <f124a2c3-980b-4c41-8a63-c5031836b120@oracle.com>
Date: Tue, 25 Nov 2025 09:08:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/bpf: add verifier sign extension bound
 computation tests.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrew Pinski
 <andrew.pinski@oss.qualcomm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
References: <20251124180013.61625-1-cupertino.miranda@oracle.com>
 <20251124180013.61625-3-cupertino.miranda@oracle.com>
 <CAADnVQ+tzCrbJ2G2nuqejVQF_xzxM818HOut6va=UBAmMavJ5Q@mail.gmail.com>
Content-Language: en-US
From: Cupertino Miranda <cupertino.miranda@oracle.com>
In-Reply-To: <CAADnVQ+tzCrbJ2G2nuqejVQF_xzxM818HOut6va=UBAmMavJ5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0290.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::8) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SA1PR10MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7f24ce-8f7a-4ac6-f37d-08de2c02430f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnB4Q3BwWWFHRldUVlNnZ1VVTDdhWllqZVNubWcvU2tyakRpTlBmNitTcU52?=
 =?utf-8?B?eTk1QXA4bWNIUlVXSG91STBHMnlZd213M3V5VjJNUkpsWmV6dXFlWGFLaGxh?=
 =?utf-8?B?ZTZEMDZLNEMrdFRCZ2ovbGp2WExYMkNQV3pTNmlTTXVaWjhiL25lK2xRR3k5?=
 =?utf-8?B?U0tDMXYzV1NLb2wxMG5Cd0pPWllqT3RRTTVzRVNoZGhDZDlXOHNTbEVLSmxq?=
 =?utf-8?B?ZngyMi84VDhpeCttakorNXhpVDZCelFUSWR2MjhGemhnZHlCSUdNZ2RCVk9r?=
 =?utf-8?B?QUM1Y2t2bUJRSGFLTlZlM2hTaHZhL3ZJSUZHL3ZUai9SY2R1OHQ4RDUrZlV2?=
 =?utf-8?B?c0M5WXNVb1FJSVAwdy8zSnpWbS9mZ0U4ZjdxR0FEVlJOSldYNzBCWVNENjQr?=
 =?utf-8?B?OE9MbVpHaTVyUXJzTXhvMXRaWjZsOFdrTVh4YXdYSGhwQjRCK210R3JyRDhi?=
 =?utf-8?B?NDRsYW5BaEJNRk14ekVPZ2t6RXA4ZGhDblVNdnFaWTBpcEI5QldrTjB0MTlX?=
 =?utf-8?B?QzUyZHl0WHVSdGJOaCtsOE8wdXNyQllwd1hHUEJDdnVOWDArTU5ZYWdLL1JR?=
 =?utf-8?B?dlNqOVBMSnFza1VLSWhrRDBhWStDbDF6eHgzWHU3OWlvbjZJcXdqdkZnTVYv?=
 =?utf-8?B?WElrdStxcUFDUWdJeG52ekFrTzhOWi8wOEpiYzBrcGwrenRpRjcxSkxDV1lS?=
 =?utf-8?B?Y21MbmMvRmhnaXpaSXRQKzBhMWl3MGR5UHpaNkp2ZkszTWNlZ0pRK25mT1Y4?=
 =?utf-8?B?VTJDVjQ5VUROWXNpeG9TRVh5ZjF2VDBGOHMyVWVDVkduVzE0blNaMUY1c1A3?=
 =?utf-8?B?bUo2dlNZZ1RiZmFrbkM3UW9ibDVQOGFuRXpQVTFCMEovV0tUU1ZVVVU2SUZa?=
 =?utf-8?B?Sk5HZUlCNFgwaktiOVpsclBmTW9oMXVienpqUG1JdkV6QVJyQnRxZ1ZVckFP?=
 =?utf-8?B?SEhPUklmMGkrNHBXdFZ1ZkdEbUplUU1ocTlLbldjbm1EV3BobVNKUk85MHN3?=
 =?utf-8?B?NGZjZUl5TnJjaUd0Sy8rQWdLRGxjNXNidEUyZDR6N3Y4bnZTenBacVlQcFFO?=
 =?utf-8?B?M05DM3NaQmZjOEE2MjNwYXJlYXRHbENqZE9KOGswdXphSFBLdU93ZFBxaHVh?=
 =?utf-8?B?ZFRKWjVZd2t6NjU1bVgwb3M0cUo4M0NwK2VsU1M1NXBlREVic3kyaVNkczZR?=
 =?utf-8?B?OWxFZktMbkZ4WlhyUFllN2ZsemdVU1E1Ukx4RzBqUWtWVE9qN0pCaXlOWEVi?=
 =?utf-8?B?OWZDaGw2d1JHT0xXNUs1WmhzTWV3NG4xeklUMHVNcStRSSswYzAwK2hDaTl3?=
 =?utf-8?B?c29iblczdjluK3UxTDJGWWJMeE1yczdiV0xQeDFjaldWOWhmZjRlbVo1S0t3?=
 =?utf-8?B?WGVHTUdPd1dLbGZDc2FsVzFGSUJERm9RK2prR21NOWdBV2dSWTBnem9vdGlx?=
 =?utf-8?B?emxtRTdIK21UbEZqN0tuY0dwN253c051QkZQKy9aQWNCbGFVcWkrU0RrL2VH?=
 =?utf-8?B?Qm1GUXNxWXVxS3lMM2lqTGUwUkNjbnVDdkZIaHNXS0J5WVltUFRLYVFHU1R4?=
 =?utf-8?B?Q0pvRG5wUEM0bjRYcmxZYUFoMnZRNmFiSmFjamJmMXpjTlZ4RGozQlVGeGVu?=
 =?utf-8?B?QnMxamFXZHFSdlY1L3VqREdyd3JTazNmdjFtZlNwb1VmWW1QUmVWWTdjWS9m?=
 =?utf-8?B?RmZJQmhWUmU0a0Y2Q01aVzFsckJKMmlBdzE3cDF0YW1DenU3VEJMMk9OVzAr?=
 =?utf-8?B?WjY1SjVTZ09JTFBldFNOVWdHZGNBR1hzOVRKWmJGeG1rM0JFZzNVS3VyaEln?=
 =?utf-8?B?U1kzVTlybktUTUNvckUxUS9tb1p6aVh0TXNvYy8zMXhlZm5LbDgzTmFSNWZS?=
 =?utf-8?B?aWpGUlhoMVQ0bmMwS3gwQVc2d3ZXSytpeXJ5Q2VaSy9KNVJ4ZUFHL1FvVmsw?=
 =?utf-8?Q?n+HRp4XZGvyMZXhEWyh5PZiExU43dPUv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d254V0VpNEVIelFaV2VhajlNZG9nc3dkVElxYkxiK2JES0tGRk0xbER4b05E?=
 =?utf-8?B?V01zMHdWYlVPWjNTZ1YvWU1DS0YyV3FnUzZEcGxqZ2NsWDUzQlhzdW85MmZ6?=
 =?utf-8?B?SVFsRTh0QjJXTU9QaWU1dFBGcUxiOWxXTEJISExMNUNEai9rTDlOMXUzL3B1?=
 =?utf-8?B?RXpHMWQ1NE9lL0RjSDlDMWRBc21YUitpRmw3M0loQjdZenhLRk11ZU0xV0R0?=
 =?utf-8?B?bFYxWmE1NzNHaUg5QnVob3dCL1c1NGN6UFdNRkZRNDZ2T0J4YklaWk4xdDJv?=
 =?utf-8?B?c3BVdHludHNrTldMYTBkV3FCNGVqYzlzVDcvZTVWcHB4MDhKR0xOQWNxb2l3?=
 =?utf-8?B?M09Ed1RXYkVDMks2aHQveWg5QkZVampEZkowWVArNU5DWnVUYXpHNHRxNE10?=
 =?utf-8?B?b3plQk9aWjlyTlRDWkZOMDR6aDJUazN0U0lrM01kMjBhMTRmV1NvbTRTbjNz?=
 =?utf-8?B?eWZuYTRWTHdaR2xnQ0lLSk9xaVV1akkyeWRwOEduZlIzdTZ3aHIvSjBMNlI4?=
 =?utf-8?B?aEhmOVJJSjUxTmRiRWRmWUJ6c3VoODgzT1hpZm9VMkVNYytNR1pseE1mV0FU?=
 =?utf-8?B?MUlBWEkrbkpXYTFkcml0OVM2SzJrdTRiTXk2TVRmOXI5dXM1SHk1NlM0RkVE?=
 =?utf-8?B?M2xrUFFPOGJiSXEvYnFhNGtxcnZEWDhVQzV0d2NNaEJXaWIxcTVZQWNZNm1k?=
 =?utf-8?B?QlJUTEZWajFhbFpkT1pFM3g1VWI5eGZGYWhxbXA4VDJLRkhuTDJRUEh4QTcr?=
 =?utf-8?B?c1hna2doSHlPelloYllzSFY3RzU0c3NWSHV1VTRxUkdLOTNmb20xYTNhNFlo?=
 =?utf-8?B?OUFLdm5KdzNtTUdla3FGakdOalRXVmd4L3BYZkhNZ3YxK3JsWGpuN01MS0Y2?=
 =?utf-8?B?dUYvcldobzdWSGtLY3pDZHhnMlpXVkVHMHh1YXFkTEdlN0hDVlVySjVVSzhD?=
 =?utf-8?B?TnNkYU1maWpDcjdzUzFkeXBhMW1GUmtMQ01JRU82MElTdWJXcVVWU0YwMVV1?=
 =?utf-8?B?QTdjQ29XaG1HQkRWRW50OXVVa3pNUGZRcWcrWnlHRlFOdGNOUS8wSU9XbUgr?=
 =?utf-8?B?ZEJMZnp0NUtvZmo0ZTJoS2poSzJGbkk0eXlEeUJ1bjVkTTdTOE5BRnhWajhM?=
 =?utf-8?B?ZndFQ3dod0lOdUhmMVBpbjNoaHlTck9UZFdwTEo5dFJBbmNLS1hUV3hwcjMr?=
 =?utf-8?B?eXZSMlVWTVBEMzZpd1VBZk5TYmxwM05JZVd4RzFVdmdxZHB1RHk5ZWlLVXBS?=
 =?utf-8?B?RUhDaTh4OFRKa29tYnJCY1FoOXpWQ2tMaVZvRDlFY3ovK3hlTkwxbXljYktK?=
 =?utf-8?B?dE1XMVhTYy9CMkVZTnFqWHZ3SnpCajVlVm0wUGVPOEVtbDloUEMyUTVVdUR2?=
 =?utf-8?B?V25zT3dZRHl3U3JWblJGN0hYMW5nSXpjSkNoRmp2UDZ4MzlNK0xrOEJBWnlE?=
 =?utf-8?B?NXQ1YUhMeTl0ekQrVHJVSFk3K2FwMjYzMFdGUEIya05BWXJBdHV1U3lrSHNW?=
 =?utf-8?B?TU5rVVpWV1hYeWprbGYyVUtGMWJVdzFZTnQyRXNTOHk2Um1LZnBmODdoVmdw?=
 =?utf-8?B?azFwTFJyMy9zd01mcmxaVzVkQ2theitFMEFMaitQY3RMWEEyL2xkOEY3cERB?=
 =?utf-8?B?MW5zWXZabTR1TldPdi9UUU4vcDVNWmtZODl2UGd2Y1FrZjU2WEwrcnd5UGtn?=
 =?utf-8?B?cTVscFRXUzdvVUxGOHdDN1ZmSitiOStHQVUydTFJYk5NOFkwWTMwaUJtT0pz?=
 =?utf-8?B?Wk1GbkxEUXlqLzQwSFZHS2hiSTdyYnNuK2VsY2pUaHE2K1ZPaFRzSTEzanFG?=
 =?utf-8?B?b1dEL2M4VHZ4NHNQRUhtM3F4ZEdSQUtOOEtEQVVOVEQ3d0FxekYxcnh4NXRm?=
 =?utf-8?B?K2pzUVZibllPZnNWZXBaR1Z6TDBldmxuWDMyZGZlK3JnVFhibW5kcmFBOXJm?=
 =?utf-8?B?TmRSRGlWQXFETlVKQ1dSVnFiZVU3emZiU0QwUkNNWCtNamk1TkIyYlFMMkN2?=
 =?utf-8?B?ZnRGdlhNS0Zha1hrY1BvdEFnMFpGVXphS0I5TEVOZzR5Z3FkbnMrTjNZNUZN?=
 =?utf-8?B?OEJiRWU2c0tFQmFpQmN4TDRyOEZjNG1rRndueEVueTFhVHNyVmpuOVowek1u?=
 =?utf-8?B?Wm9UcjdLNStTNWVUaWl3Q2xTKzFIRVlhQnNNc2ZKU05wbS9LdHBCRmx6VjZX?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jVrQsQjJcidzS3IdAuU4JG56hqNlSBQ+zJRMwfYeDMuNBLBI8Ky5z2o/5lEuqp+CC4BlrjGspbddb43voszjjfqh2LzJaPbhjWgFNoXe9+gSaPl7rne+53BZsjPMSn5TnVX0sJPPeUfjXXEMAs5gDKPLs6K0ULtBgDA5dNrY8QuRnmCJglEThriWLdEIDzpw5p3gKU0tGrXcNGVJB8L9Ty9DBy6sU26nHKfr53sLlB3KGZs9/eR22gbTWiCe8wiu+5AIQuW4f/85Q5Vi1qq7bU1VhEl2b/2vjfXNE1J56Aqsp0rnvaGMX2fP+bQ5K6TA63F3I8WB8BKzXoXYpnDqQhRzMO5o9jCPgnlhQOp7niGKTCJSe0BeMrZYDuz8ambH6cAzpiM9s9MWw44YfhaGOn91PBH7DLzvRgSJLp0Bux/Ma2gL0SR9wzdcwWiqxSTdx3paSMTgRn8Lk9RNPtSDrWB2nYE5dSR1ail7sRVaDdkrYeDBt0rZvwrTxw7Bxt8TwaJHVa7XJRFL/S9PQB4DGiK6wo4oMSmRTjdZbFHhTRBRXQVixm8RSskOI060ktEjhB1CkiO7e5AKce4wkbijKgGR139fRtl5OWgf4yT5hnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7f24ce-8f7a-4ac6-f37d-08de2c02430f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 09:08:56.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXK/u12rwzzDgFW2L7V/+mMNHdH+aenUqcCK/KWO5lg5THfQ0Q6pYL7SDslrOVrDCE+yjA8kSLYuyEoj+cdPj5CyuFk8zuhRz0N7oXnlvhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250073
X-Authority-Analysis: v=2.4 cv=L6AQguT8 c=1 sm=1 tr=0 ts=6925722b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=rvRYQTRTcCNyGi73wQEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA3MyBTYWx0ZWRfX0Pdzn8VqEzBq
 okj1/RAXMFTi04tDfUO1a/svaN648/3mDIuL3BraKgalUN+whPZsrtDS0M1ARP+Tkc+7KvTqkLe
 peWQ2/RiByJotw85ybXwk0WNhaKt/aUh7caGXZSKkuJu5ecPpDle8tNuYOuHHCQZjCRkrSNkUWX
 ogONABVZYJW/PR/bjGOwdVQdOmrNmHH1VlS0fH2u571+lGLvx+VP3un4r4V/XyvqvhhD+jefgOM
 BrNqro8wWDaUrMFV6GBmh2hoduW8D4TprovgS4AIO2gVzNe08QOITAzGf0OV/g7QWpHczQiA1zW
 AObem0em5IMxglW0k/O81kZ4jahXZb4sclprcyrkAX7oYYz79FXD1VWbGgqvN95TQ5+SL5o9sch
 c+MSqeuaTMLGABai4nP6fPuh1ixxpg==
X-Proofpoint-ORIG-GUID: cDPRCL28tL125XwJ7GVc_TQpqyaWy1aH
X-Proofpoint-GUID: cDPRCL28tL125XwJ7GVc_TQpqyaWy1aH



On 25-11-2025 00:09, Alexei Starovoitov wrote:
> On Mon, Nov 24, 2025 at 10:01 AM Cupertino Miranda
> <cupertino.miranda@oracle.com> wrote:
>>
>> This commit adds 3 tests to verify a common compiler generated
>> pattern for sign extension (r1 <<= 32; r1 s>>= 32).
>> The tests make sure the register bounds are correctly computed both for
>> positive and negative register values.
>>
>> Signed-off-by: Cupertino Miranda  <cupertino.miranda@oracle.com>
>> Signed-off-by: Andrew Pinski  <andrew.pinski@oss.qualcomm.com>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>> Cc: David Faust  <david.faust@oracle.com>
>> Cc: Jose Marchesi  <jose.marchesi@oracle.com>
>> Cc: Elena Zannoni  <elena.zannoni@oracle.com>
>> ---
>>   .../selftests/bpf/progs/verifier_subreg.c     | 70 +++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
>> index 8613ea160dcd..55e56697dbc4 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
>> @@ -531,6 +531,76 @@ __naked void arsh32_imm_zero_extend_check(void)
>>          : __clobber_all);
>>   }
>>
>> +SEC("socket")
>> +__description("arsh32 imm sign positive extend check")
>> +__success __retval(0)
>> +__naked void arsh32_imm_sign_extend_positive_check(void)
>> +__log_level(2)
>> +__msg("2: (57) r6 &= 4095                    ; R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=4095,var_off=(0x0; 0xfff))")
>> +__msg("3: (67) r6 <<= 32                     ; R6=scalar(smin=smin32=0,smax=umax=0xfff00000000,smax32=umax32=0,var_off=(0x0; 0xfff00000000))")
>> +__msg("4: (c7) r6 s>>= 32                    ; R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=4095,var_off=(0x0; 0xfff))")
>> +
> 
> nit: unnecessary empty line.
> 
>> +{
> 
> lgtm, but gcc-bpf doesn't like the above :)
And rightly so. I would not expect clang to miss that rookie mistake. :( 
I paid the price of my own laziness. ;)
> See CI failure:
> bpf/tools/include/bpf/bpf_helpers.h:41:19: error: attributes should be
> specified before the declarator in a function definition
> 41 | #define SEC(name) __attribute__((section(name), used))
> | ^~~~~~~~~~~~~
> progs/verifier_subreg.c:534:1: note: in expansion of macro ‘SEC’
> 534 | SEC("socket")
> | ^~~
> 
> clang is fine with that order. fwiw.
> 
> pw-bot: cr


