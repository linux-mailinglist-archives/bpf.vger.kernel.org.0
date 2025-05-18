Return-Path: <bpf+bounces-58466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 272B9ABB1A0
	for <lists+bpf@lfdr.de>; Sun, 18 May 2025 23:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17CE7A8591
	for <lists+bpf@lfdr.de>; Sun, 18 May 2025 21:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437CA1FF601;
	Sun, 18 May 2025 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DdwUn9Gh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PvvFADGJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C64B1E5C;
	Sun, 18 May 2025 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747602686; cv=fail; b=dGxskTrJcJc1hFhOpdCqiQRpChJIaD6C5lm3XSWzih1wFRPGExDZ29m2w9AhdBfSNZJsooQ0lgS3PdP5/rQB7e5PFD7zNdJhhGvDBPaym9bTCrZtY+EfZcT4yN8wIka1Hs50atQ6MHC3553gN8bGbxwy6N3as9HpdV4RAipRi0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747602686; c=relaxed/simple;
	bh=nFjCc6/ORpvYiKp3BXWPgCYd6zpopToHry3hTNB3t0k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eOW4O/XqiE9jrd7Hu551JqOjey7ttJwbAZmSf7tjFClDSArTYqnGDiq4B280Ey72p4/xAJ6ZdEWb1yWaceG3KEHoRIawb///GJeKtJOXD3EOcKi1dXpD/9wYSgcG4Z5dQOaEFRvbXOqe83QBROomvzvEP5xAmiOuDaE1PufxVFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DdwUn9Gh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PvvFADGJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54IKjGgc030107;
	Sun, 18 May 2025 21:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xbOqQQqUw8s14nxlfrfoM2OV1UpaQYaDkByWstBf4Ws=; b=
	DdwUn9GhiN2ywgCMyJPgmYShmFm5fF3cXD5bSVrSvuqV1+joIe736awpLThvRuCR
	IhrBK1JpZqGxdVFqVluImdAPfnSZ463hD2h/MyHHdJ4NRrp5V+r/+rIz6g3p5xnm
	MF2tKBwWmazMalcAF5+ztNb3hOcvQjGvpbHIGwKFuDvyOEp7v5JOexkIHrmKcsnM
	FusP6W0HnhmXblKEJEV8wK2uO2ImrAsvjBpV6P0zz7OxgJjwI5RNvmbVGgTgoiVp
	lBkuPeMM2K/o6958fXrpv6Vt3UZq1TH5NWIvV70rUvz7Pa+jcgrJV66aggQVVWtm
	9hVI4D0MS+VLmzLDqVyE8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pk0vsq8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 May 2025 21:10:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54IIiYO9010805;
	Sun, 18 May 2025 21:10:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw615gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 May 2025 21:10:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKNpxIJ5NHHeWxn8foAPyvc47trv5AGZ/tGl6q5YUifzGB/0Zz/hJTjuMttIqvoeFbRgiSL8BfMDzIdlaHZLn97dYxLImCUY61ZAENoif5WnvV3G+/hRVRA30hdJBEHa9hON/fUWViNU5vekc3wiECVa3GYQRLY3elsk2/3iEBszb1H3cHJ3Fx5I5/emnUOs097LqW6rqFGzesx9D9XsO5PrW8osExDGh1IMMEKj1mGggjgMb9il+dbaUo54wqUfa77sWhFx+pYvy6CcHu3CCm+7fQl4Zz0zXWShHkpdJlNroMxwQEoKFLWVBgLtr6ksB138DcNefbUSj2A+Ptf6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbOqQQqUw8s14nxlfrfoM2OV1UpaQYaDkByWstBf4Ws=;
 b=JTQ31ttGWzH2fdXMx7RnFYVwngcusQTXBnpaPjRfwzmZqBrUhb0sJKgcTCpGw9EOwK/eDXLDQCQ8g51FL19JK+gF6OBX19+ltnucq2lvPW7Q0VT2bWlgL36OE/DoBix45POOJga8TDdeLZij7xrf9ZlUgBt6nJOa2ZRXEB7YvGWBz3pdHBt7vH61kQ06MrLv4MZOvtR38lJlbFutk7KVIKLK9njbn29IQeefIoeFnNDr4HI/453AJaWYTjLg1i4QUyOVDcWyZTUCKstDJ6P4ucVI18g+Hsh+k2qMhI9tfeSVowHPkuPiNB9TizZCWhIXWCLI2nI6WkgqeZJKphElqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbOqQQqUw8s14nxlfrfoM2OV1UpaQYaDkByWstBf4Ws=;
 b=PvvFADGJhe6US84meeBoT+VWMs11xtMo/ZXsBi+kkPsFviWdrCxozzYS5xyPobH4EZpJ8IQhxqjDrk4I0r/YQ2tP7lHAWRANgHYiDsPaIHZSXQr8QMbyjFpchGI/vLQb/CgOugwBZxd+ls1lHdAopF5Br2rLxhOfB65nYOwOiG8=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA1PR10MB7831.namprd10.prod.outlook.com (2603:10b6:806:3b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Sun, 18 May
 2025 21:10:35 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Sun, 18 May 2025
 21:10:35 +0000
Message-ID: <7549d1fa-dc76-477a-95b4-edfc09085fd2@oracle.com>
Date: Mon, 19 May 2025 02:40:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] hv_netvsc: fix potential deadlock in
 netvsc_vf_setxdp()
To: Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        sdf@fomichev.me, kuniyu@amazon.com, ahmed.zaki@intel.com,
        aleksander.lobakin@intel.com, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc: ssengar@microsoft.com, stable@vger.kernel.org
References: <1747540070-11086-1-git-send-email-ssengar@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <1747540070-11086-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA1PR10MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 3745d211-7184-4082-805d-08dd96506e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkpIbUt4TjN4eUVZZ3o0dW5WZ1BhUFNzM1hSNk1MeUxJdlUzSmMvckcrK0N6?=
 =?utf-8?B?L0tDTFhBQklZTnY5Q3ZzSkFhNVJpMkdvUHVEMGUxK1ExTytmMjFYS0tlNDc0?=
 =?utf-8?B?eTgzTENBZWdNUjM3MDFaYkxadXdBYUJWNWJwVE05Zk56cnZVY0VwWXBEVVZz?=
 =?utf-8?B?VzhPVVJPVXl5L25OK2kzY291K1I4WE5WaE9lRUN4K3BsWnFUYmFjR3V2dk16?=
 =?utf-8?B?b25yNTllQ1JQYmlsSHd6SDFWeU1MaHQ3aVZDZEFTQXl6ejBHd0xPODZXZDVW?=
 =?utf-8?B?YWpHNGhRNGVEZ1F2aWE5R3BPTnl2S2Z5ZnNrTXhnWk1iWDR4TWEwZjZXakwy?=
 =?utf-8?B?K2pzTWk1LzlyUXp1REFSQ3FiZEFGL2E0N3NNSWg2cGZQaS8wYmdwc2FBd2ZG?=
 =?utf-8?B?MGJDZER4RStxUWpybTVyNGtVU0FXMU1sdC9mZkdvUXVpRWVoMlVXMXZJSE9Z?=
 =?utf-8?B?MDFpRUNzU1ZJcFhySzBwbUJYT1N5aWJvQng1NzFoaUNab2VMSzN5YnBYekxs?=
 =?utf-8?B?a29QYXZMUVEyRkNRSGRBSTRQYTV1L050aXpiQTRVNVR0V1ZFenJ0WjJzUUxj?=
 =?utf-8?B?bHZMaHRaQlRIUTA0azlUeDd2eTU2ZVdUbzlFRlh4cW1LOE8rM0JHU1hENWph?=
 =?utf-8?B?emlhcW5vaTJvSFkrMTRrdG9JQzJiK0VuaGVOcEV0WjdVU3Znd21hTjc2N0Vs?=
 =?utf-8?B?bEFSQlBQcUdHbWxhOVEvTGVrS3pLUDJyb2xDR0w2MVF5dDBWOEMwYm5URFpG?=
 =?utf-8?B?Y0krU0pEbFpWTHNlVFFwbGswaE0vK0VyME0zNmJYNmRha3BwZnAxd0cvOWNk?=
 =?utf-8?B?bVIxSm5KaGNIdEpJYVVMejBkUnJ2TW9lZXF3RXVFQXNyK3hWcHRXRDFNaldr?=
 =?utf-8?B?REVjbUw1b0R6bXB6NFUvalduUzhBc0t4K2FRVVB3dTZUT25TN3pMRmpwZnhI?=
 =?utf-8?B?ODB4NUdTd3hwblNCT2NJRGRuZVJTNmIyR3pVUzBPczc1T3VoUzF3UnJLWmJU?=
 =?utf-8?B?QW1pVE9FWTRXYWt3NlNrcE9IT0lqaFE0OW9URW1GWlpkSkhRZWZib0tjTVFq?=
 =?utf-8?B?UUxCbjl2TGJoNGxyajdqNE5vMmVPc2V5ZmtqaWdVeEpuUHNZN2JlcGxZTG1I?=
 =?utf-8?B?Z1lOMFBmY05XZDloRDNWYnZ6SXMzS0VRK3p0OXhqRU40bWtqL1BIcU5NUDhW?=
 =?utf-8?B?Qmo1cXZlMTR0cW0xNTllcGx1djg0K2xMVWJtcDJUdC9BZWkzd2ZBcjBFbTZi?=
 =?utf-8?B?bFRvM0c3RXpqZlcxTjJkNlFjMXFPQnl1NmVFUVBTRkI0ajI3bTYvV3ZPdHpY?=
 =?utf-8?B?U3pTeVJHU0d0eEZ0aUJtNitnZGswc3Yrb3RXTDh3dVN4MTYvWGRwcmE0MUxr?=
 =?utf-8?B?RHc5SWJMOWhiMFJGem9qZ09UOXFMSkVaUHdsNEJBR1N3WW1nZFY0WWFyeWZI?=
 =?utf-8?B?OFRIeXZrMzhzOHNBM3dIOFlhUGhEdjA5ellZZjNRT1FJNzhnSkVaU0NEcGQ5?=
 =?utf-8?B?TlVrWmhXRzRyL0JvOHV2Uk9XdEVLNEV6VzFpTXRTVTg2akNjVUZPUnJINWc3?=
 =?utf-8?B?Y2JHWmh4akpTbUpvS0ZKTmwyMXB0N1dCTUtlTUNYVDdLZlpwUE1HSGRpK1Bq?=
 =?utf-8?B?bWtnZVo0Qld1MVhGY3JVVmU5NTVtWHR4L1FCVTJVVWlBMkg3VnVsVVR2ZndM?=
 =?utf-8?B?UDJqY3lZTzAxSHNPaGVlbHBxeDVJZ0VxYlM1UjFzT2w4RDZJRkY4ZG9QWkFG?=
 =?utf-8?B?dG9wL2Z3OGpTeW9KUjJsS0NtQjA0STJDZXRUQnQyWlNnemVBclVFWGR6Qnc2?=
 =?utf-8?B?TEJ1QmhYcTNVTm9hOE5ER2pycnIrRzJ4UHRTT2RUQ1c4YXdhd2djN1MzRFVZ?=
 =?utf-8?B?Mkk2MkVHcHZnUUg3a0xRYVhOeE8yc0IzVU9Xc2tsaitGVVpxR0lDZUdaL05w?=
 =?utf-8?B?T2Q5QjNRUHBqejhjM1RxUFRJNEIzVHVodFF4NUpiekFUZFRtQXFENmxyWTZE?=
 =?utf-8?B?YkxuME1yd2dRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGJkblhkSTJ6UHFITko3OTZDWEg3VjRLUVp0TTVZdmYzdEdQb2twaWhTcm01?=
 =?utf-8?B?dy85OEg4eGU0VXJrbURSazg0SHllVUNGdm1IenZwenMxK1B1bC9KdktsVjZR?=
 =?utf-8?B?Q3NpQkdUR2JiK1dTaVRvZS9NdDVFWThoY0trZTVuUnloQnYvcFJpc2tVLzky?=
 =?utf-8?B?KzJTdTQreVpXWkdBUnJoMStyNk44eWs2SW9MRVFsVWgvcTAvcDcwbTBTN0xa?=
 =?utf-8?B?ZE0vajFRYjN6TUcxQWpRYzhRNEZkcytkZzZQaEQ3dkVyenBzK2lXVVRwZ0xu?=
 =?utf-8?B?a2U4U3pDa1k4THFYU3IzdWtUcmcySlBoY3B1eVNXQjZCTnI1Vlh6N05oZ2c3?=
 =?utf-8?B?M0NWUWF0bkl2QjZsWUJMZkhCZkczTXA2VlR1b0JWUUhaZGliekdvSVI2WmlS?=
 =?utf-8?B?bUNDaEVNWU9VZFhyRGVoTGlUeU5mdjBMbkhEbWFFTnFvdXR4THFjd2N0Qmh0?=
 =?utf-8?B?NGtPc1UzdU5iZmdHM0tzaWhpb2s1TXRKK0JvTFRBckM1SXV4V1h1SXJ4SGhw?=
 =?utf-8?B?YnRIem1Bc0ZFTTU2cStBNjF4NS9YOW9jU29kVlNUbGJZT1VETE8wYXBVT1BP?=
 =?utf-8?B?bmlYT0g0VTcrOExhL2tyOFF0Rk8waExua05TbUxKTUZjSkdHenBqbE4xQWNW?=
 =?utf-8?B?YVE3T09PTVhnN21YY1N2TTdXZkFVOEZ0RjNCdU8vdG52OHNvdjF5TkRuMzdR?=
 =?utf-8?B?SkRpWmZIdnJJUnk2ZW5JSHlJckUvME01MS81M0RjdzBkQVZCQmpQamRBWlE3?=
 =?utf-8?B?VEFYYXFxWTM0UGpJT0kwWjg4eDhuc2ozU3VsTXdFRzBaenBOSHpGdGlhaWEv?=
 =?utf-8?B?elJoTHRucENTMldPaUxiZ1pVN1AwOUJYTi9rYkxvdHRXMmtIYVZPRkVsdXRw?=
 =?utf-8?B?MEpMRVpKckxTRDlmSGszNXJKTUpaa21QdDBnWlJVbnVxdi8yMmhYby9KUS9m?=
 =?utf-8?B?WU1pN3ltbTRPREdMV05XUzR0RnRjOEF2TjlRQjA1LzhmVkREcGRUWDJjS3Va?=
 =?utf-8?B?cnR1V0xNTGFFSmp6cmY3eFAralI4L3NTNkY5Q1pUZTdHTkNwOUliV1o5U2ZO?=
 =?utf-8?B?R3FWcWNLbWVUenlWSkxzaGpKSVg3SytNNHZoak44dStpSitHUzdpaHB6RUJ5?=
 =?utf-8?B?eExySjFvNHlONHlSRTRuRkpnQzQ2d2lnOFcrM3dZamZiWFAyM2ExdTdVNCtT?=
 =?utf-8?B?MVd1emdlazlHMnNFMEV5MHJBZU5xbDcwOUs2aU1idzdoVUwrMGZnbWcwY0R4?=
 =?utf-8?B?R0pJK0RFalBvWm5oeENkM2RIMVVGYmFIU3hHdjZITWxLK2R2OUR2RWgzc284?=
 =?utf-8?B?SGpHcjIyVDNHb2xUckkvNWJaeVAyQXBOUE83dm1IKzR2T1hPeUVjcjhjVGN6?=
 =?utf-8?B?WlQ1TmNEMHdXeDNlNzN4cHdRcWt3M2lHblpkUWdMK0UxTmVCRldQT1Nxem85?=
 =?utf-8?B?ZGh2Yi9JK3UvTVlPb2tCWjNXRzRNTk5qZ2VTcmdYQXN0cXAzd2I5dTFjWCtm?=
 =?utf-8?B?MFduYUNBanp5MlJwRGtXMTFGOTJBajd6bS81dCtQL0lwQ2hISWZsb3RYVDFC?=
 =?utf-8?B?SytzdHQ5OWZKVDZJbkxhUjlOZ2lDMGlLdHVpait6Y0s2VmZ3cUx6V2NPT25N?=
 =?utf-8?B?MnFPSGVGNU13UkVIUzkyNnVFcVN0aWFkR045cWhSQ21reHhvQlRYbFRiaDE1?=
 =?utf-8?B?b0dEcE10eW5xVFdHV1JmWDd6U3VLQkJKa2NBM0s1aHJjMjFIdjFKZStWTTRN?=
 =?utf-8?B?SHZsbExmNkpqNTZZb1JBNkdVbUt1NWpTRTVkWktUVExQakxQUW5ySU91OFhS?=
 =?utf-8?B?ZklMSFpIK203eCtTSTB0M29hSys5YjV0b2Z1bk9jbzUycnJCc0hON2JwTXFT?=
 =?utf-8?B?SWNpOC9zd3krQnRnUWFaYkpyMjhYcllTbHVuSXhDVkVtTXFSMWs3TFY3OFRM?=
 =?utf-8?B?UENNc29wMlpzeFh4NjM1YjlDYlVFeS9iVFRGYWsvVzVFb05idzZTNDQwdjJn?=
 =?utf-8?B?c0JveWsvdDByV3U5bXdHMjdLMnA0enNld1h5djB3SldOTmFJVnB3azRXY1dx?=
 =?utf-8?B?RnJ5MWJKWkk5cTVIR2M5eTRzU2U4U3YzQnZWTDRYeXorWHBTa0g1NHVwcFdo?=
 =?utf-8?B?b2MraHFiU2JPZnFWWllOa2I3VGlUUFpmRXVTYzB4bklDeWVhek41L0tiRDJP?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g6SUtXfVXQ5GIkqyAnTGagqPW5L4i+vdxy9B3krMQrveW95ob1zCNg9hYUyB403DIpy8XQnafsQZZmkT8Up5SDQ9hzs1LxHM+nalGGb9EP6/+iYe7Bakra6hfByQzXAHwa0hXJlHbMzg3jQLmNf/9lTrpoywCwJx9q6dUg8B+3Fq40vGC0/MGgzGIoOBtc/UYjMfni0u9Vd9dLxj3kR9SHClzvPmoCXGoZH4dGqnMAsgtgUy0fm3hthB24SzWQWFfx81wdJwE5yrN/ItzxcovLij6a9NDXL/SGgw0sp/LLRlcL+IA5Hq0fGXoXtQlxv+Ea3tCqKYAyZUotCQhX7/Ov2oyh/1/h7JQKEifvY/bkYw7l+V2q5iaR1BSAYf1fcx/b2Mgoji3Q4kasbKxTMv18WyOUHvreAL3ePUG55jUF1s96KbpYYhkewVdxzB3o6nIy0klrk9VNvDjlQl/EhfEtNqpZKH1XmYsN1dEH7RuCkXZiyNq1NubZYsYdZVrIDnPsSsfARnYpwNSU7g12oyrenjKgiEeGMT8vu98aZRnPcJWhIUZO44vAB7x8qB/GQuudeWtGlRRqEm8Vf9F3rkfCN9tikBUN1RMeteeKHVSEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3745d211-7184-4082-805d-08dd96506e35
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 21:10:35.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayt0v4McvVnJQaGpc0kglTyKT9yhgRBY1/4hxjksJ04rgL6srz6nT+WUWR3ReXfkMgG1GdKE2qrAKpGsLVbHhDAC0haq7IQCyRGvWgwfji0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_10,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505180209
X-Proofpoint-ORIG-GUID: elakneDeaMeI4RS3stBvvvT5KQp-snPp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDIwOSBTYWx0ZWRfXwmD8PUkG5iam wy0plUeD3NMJFEezTXiDaFe+pVSdwmzqICUws8wya8+oQxmL+tzA9peI2Dfoank9eFCWmGn9ud2 gHnctcnyQZhNJFYJiaJheN318341jOg7MZMLTogsFB3RQaxQVbcIRJMRFUVJ+wSblyW4Tzixzm9
 39Lz8cHHwdxyCRF1K+NCCGQe5PPsO6Yejrfty1DeYVjiaQRNmKtL5PGhAgw8Z6LgdO1acEajRuw hodva+/NjAUaLq2fjIbXgDaK8xSxhwycdjPVJ0rKaTuxVSR4f0dqCvLH+IzchmcvZ9Bd2H6W6yR 6Iv0WvEJzJTqdZECpcNPJaleimCk06PBhrVQDUYNsD87nlsHXa8fwH0wECMuy+zlSaB83ilCxay
 +/cbn/u8a28kn888k6jHsK0NYx8Xw5XjrYd89aUDqsU4Nu4bWgbedMLiD9NnkdFUuIx/8r8E
X-Authority-Analysis: v=2.4 cv=CMIqXQrD c=1 sm=1 tr=0 ts=682a4cce b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=UaDLk3Jgrf0VfbM3KK0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-GUID: elakneDeaMeI4RS3stBvvvT5KQp-snPp



On 18-05-2025 09:17, Saurabh Sengar wrote:
> The MANA driver's probe registers netdevice via the following call chain:
> 
> mana_probe()
>    register_netdev()
>      register_netdevice()
> 
> register_netdevice() calls notifier callback for netvsc driver,
> holding the netdev mutex via netdev_lock_ops().
> 
> Further this netvsc notifier callback end up attempting to acquire the
> same lock again in dev_xdp_propagate() leading to deadlock.
> 
> netvsc_netdev_event()
>    netvsc_vf_setxdp()
>      dev_xdp_propagate()
> 
> This deadlock was not observed so far because net_shaper_ops was never
> set and this lock in noop in this case. Fix this by using
> netif_xdp_propagate instead of dev_xdp_propagate to avoid recursive
> locking in this path.
> 
> This issue has not observed so far because net_shaper_ops was unset,
> making the lock path effectively a no-op. To prevent recursive locking
> and avoid this deadlock, replace dev_xdp_propagate() with
> netif_xdp_propagate(), which does not acquire the lock again.

avoid noop and repetition (because the paragraph about net_shaper_ops is 
repeated):

"This deadlock was not observed so far because net_shaper_ops was never 
set, and thus the lock was effectively a no-op in this case. Fix this by 
using netif_xdp_propagate() instead of dev_xdp_propagate() to avoid 
recursive locking in this path.

Also, clean up the unregistration path by removing the unnecessary call 
to netvsc_vf_setxdp(), since unregister_netdevice_many_notify() already 
performs this cleanup via dev_xdp_uninstall()."

> 
> Also, clean up the unregistration path by removing unnecessary call to
> netvsc_vf_setxdp(), since unregister_netdevice_many_notify() already
> performs this cleanup via dev_xdp_uninstall.
> 
> Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>   drivers/net/hyperv/netvsc_bpf.c | 2 +-
>   drivers/net/hyperv/netvsc_drv.c | 2 --
>   net/core/dev.c                  | 1 +
>   3 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
> index e01c5997a551..1dd3755d9e6d 100644
> --- a/drivers/net/hyperv/netvsc_bpf.c
> +++ b/drivers/net/hyperv/netvsc_bpf.c
> @@ -183,7 +183,7 @@ int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)


Thanks,
Alok


