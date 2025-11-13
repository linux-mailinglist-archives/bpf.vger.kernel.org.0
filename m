Return-Path: <bpf+bounces-74423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD5FC590F0
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 18:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCAF4A7021
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094152F83CC;
	Thu, 13 Nov 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LceiGnYg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wf5odmCE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FA921D3F3;
	Thu, 13 Nov 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052351; cv=fail; b=S4n6tZGhhI7bDLNnGPV3e/Foj038ayjgAoklDORcn2b81ynT70zjgPuQX3BC/0vE5h3LS1r2LFeppJwL9NJuferGQNd9azwX7tbijTmUsIH5CR45HwtNtyvIOjK4j21vWjQuSLLIJmVSe48JSUeAGEkE37PKMGHZ+WqKKvp1EpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052351; c=relaxed/simple;
	bh=PymhaH4ueqWgMG3BxhkDQTK/ACPD6OPwLfouZ5uV8zc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uVsLMGtlo8QR/Ro0SpA35TT7PwtXobFWxd0+8y7vDImcVRCmEfQMnksvSIA6+MUO6yoUi9+OVlXwl6s6LPITdbotlBSY4TI4lwl+bpc3dW8eFxhbNAwfJDsRMoW63Vuzol9FQwZYs8g2IVkaFwPmjsiHBZFiIJCYeDCbU55YLAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LceiGnYg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wf5odmCE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9tWc027949;
	Thu, 13 Nov 2025 16:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GTEd60JtHvbQEGO0gh92X08tOZIQRonFsDCgDxNfjas=; b=
	LceiGnYguvygthJ/Hb7JkWdF7CR0w7KNsnROFS21v7K1UsEODkO0TjrDSzsncHLX
	dqafbEKRRSq3oORuLRPq14NRlVwNK6uD8TfheYiyOQIasWFcG/nYNuDXSPHpgOk8
	VBtg/mfkkIZdYa+3zcpDG5bVU6gw1dpzhtWxiWRoM8+qSY8Jo6H7apcWxrQJqpPf
	p6KNdA3umJjuwdnnvX2j68bVODIqyRc8cR1Sly39V4ahCXHYt9mkIJ14k5aw53rj
	TNz8rQhrHRxifr2SecKlG/UzH43mIbHrILjNfUyPsCrQW+CJlWFWvR1XxCB/BcX/
	yoWcjRl22f0AqK9DcGYiuQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjsa7b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:45:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADG4uCq003129;
	Thu, 13 Nov 2025 16:45:35 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacwc65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:45:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goSrI0F8xIt7EftYcM/IzWiN/4eMKkl8mN1fvr3LBTnu929cslL8GRFkOUjFCk/NtReTZP8aH3ajGIVpBRpHF0vwRITnB82bZrEXCs/mRKFWEzDfX2ZPqrH+n8XkbZlHg2hlmu5aMzTCDEsEH6t4yGmYiDfKs7MDz8jM9znIv/QfUcGfzz9eI0LyHmjyn5IYjsotu4xxcA0miuM3AsHajbeBGwEA4mTQlSoea8pPjLt+n+uyw2h4YPwRVx1l4BWa+S4cVrxpwwUpYl1o9Rj0of+QIAXNb7WEUpwOSfqaH+StARPDidXCDCnu6iVSaSjMryYRa3Ym5KS44Cs0G9NrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTEd60JtHvbQEGO0gh92X08tOZIQRonFsDCgDxNfjas=;
 b=R/U3KtP4H5xlGTrgC8XX8QmmbC7qvQEbLEca1092RdTpfU1NLRThEkZ8hNz3O36LZ2S65zBK3SzA9PzC3A+7vLpXP8w3nVRG+S/5hxFVJDgajQwjakcT9/u+Kyg8mFgvl1BOgZqHuoePaA7JUCSgL8cyt7KWP5S4INCqyupmaSqiBwD1GzZBwfabplWcM80EcWW5hObkKS5DRVvJ0AF/JdzNES3nJLQzZMrn3Wq+ydNenmJ5jJ5o/U20qFVytT9Tq9MGbTdhxdyEhgyzH6/Lu5deGrl0cQiV6HoL9JvcLv8SWgSh747D1nuKZuJhT5KNbFCrC6/Eo5oyKjiQCq/BkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTEd60JtHvbQEGO0gh92X08tOZIQRonFsDCgDxNfjas=;
 b=Wf5odmCEaczwpVWFLthW60NGSIjfNwr09Z3QcAW2hfYsBQlQXm1h+M4gF+GOqHAEW9IaklvnKrmXDRJqjdzIoVyiMEE7JYKE9ItLX/87ibKEbqR80UDjNO6s6EvYfUhNQ8faxnEiQ6k2oUBHOW8V55xRUNc7QwaPgb71RVJD93A=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DM6PR10MB4169.namprd10.prod.outlook.com (2603:10b6:5:21b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Thu, 13 Nov 2025 16:45:31 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:45:31 +0000
Message-ID: <a9ebf236-78c8-439a-b427-cb817efe23ae@oracle.com>
Date: Thu, 13 Nov 2025 16:45:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 0/3] pahole: Replace or add functions with true
 signatures in btf
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, David Faust <david.faust@oracle.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com
References: <20251111170424.286892-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20251111170424.286892-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DM6PR10MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2126ca-1f50-41b6-6b80-08de22d40e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejR0c2JxcUFKOGRjYjVuLzNRaEowQ056L0VNWDJJWnRsRTgvN1ZraFVISzVS?=
 =?utf-8?B?cTg4ZEJqeFQ4UTV2clpTa0NKZkpSZTRLTWVBNlJ5eUhBMFB2U0F1Yk1tTk01?=
 =?utf-8?B?dGJKOFR0K2ZZYlpHamkybHAxTTVEbEU4UUhZeFk3T2Y1SnZlRno2cmZBRS9T?=
 =?utf-8?B?OE5zWUN0NndBM0lCZSs4M29yTjMyWHE1SlI1c1JhN05aQWlDZFYva2kxbXln?=
 =?utf-8?B?cUJwK05BQkxWZjA2ZzdxSnpvdVNZdjhHbVNJSXlsUTNsamlCeWUrYktNcExz?=
 =?utf-8?B?eGpXM1NIVVFRdGgyNHZzbzJKYmlmVFRRLytKZnNnZkFQTlRMTkJtUTBoQjNR?=
 =?utf-8?B?N0hrVkRSWFVjQWUyaDA2UXNiekpBLzQvOHpycGJLMGhmZnRhS0NMWG91R1dR?=
 =?utf-8?B?Y1JpYkdqb0JaQ1VPQUczUTNFTUpkYUh2SVMvN0c2djJyRlJuSXVoSTNvTk51?=
 =?utf-8?B?ZjYxenNWaFJhT094Sm9Jbk9HZktYZDlsSEtOUmdhKzFhVTA2aERwTTdvQUR1?=
 =?utf-8?B?bnRqbXBxUVp6dTBsZXk1ZmptaW9nUkNqWk4vc05EN3FvQS9CTStuWkdHOVhZ?=
 =?utf-8?B?b09XVEg4RHJxYjliT20zdCtLa3o1aTlQZmV0WVJPWlhQekV1eVMxYnkzLysv?=
 =?utf-8?B?eW1HZ1ZZaThSaERRYmJKdVVZM2FFUjZhSlI5MmNzZFFqeEtCdjRKZjA2L3pt?=
 =?utf-8?B?NkxSbjZjL0c2MmdCV1BRUXVmbnN4cko2YkN4RDIyNWJBbHpsa3lPdnYvTTR6?=
 =?utf-8?B?ZjZpdlZZQmZ6MXJId0lEVHY1d3FWZnA5N1ZEQURza0RVMTFCOHlvUXRMNU1z?=
 =?utf-8?B?U1dWdEJqSGJtL3lGMlEvV1FqaWpTZktrMjVrajBvVjM0WEwxMGpJdU9UdE80?=
 =?utf-8?B?WHJha1JJNWJBRDgxa1VFbUM1bDJuTW5DL2NCK1hlZnZkaHBQTGJRempUWFdU?=
 =?utf-8?B?Ryt3alJ5bytZdnl3MlJ3TVVRVFhIVWhJY0NwcTkrUmQzd1BMWlhRd1E5TUpm?=
 =?utf-8?B?Q25tVVhlZ2NoQ2xpUzFtbHJ2M1hEL1BST0JWMDBRVFkwUTV4MWhSaklxbEFs?=
 =?utf-8?B?cXQ3RzUyM05ZbngyZTZ2TGlxdERBS3E0WXpSak5LMzlKTnc0dG05bG44Z0xt?=
 =?utf-8?B?YnJKR2dLR1BEb05SWGNUSzQ4OVprdU42Z1QzVjk1bkVCN0hYV243SDBlS1dl?=
 =?utf-8?B?SzB0V0VFa1drYmVyYlBJM1cxdE93YXZ1QkJFVEh4T2lJQ2JPQW5rTHFBSWpQ?=
 =?utf-8?B?eUtBdEkyQ0dCTE0rTnRIcXdIOUZSa1M3V3M4WDVzWGV4UVV4cFpkcWY5RUlB?=
 =?utf-8?B?bnNDTkQ2U1kvOERvNnE4eDhGQ0RIeTZUMEpTVWVBdXQzWC9zK2VHREk1WXpR?=
 =?utf-8?B?M3lJRjF4QjlhQVNaYThZVXNnRTQ0eVhFUzc0M2xmS1kzTzFHNVNFN2p6Z3NS?=
 =?utf-8?B?L1hCWW00WTJVK2RPeDMwbGhxUXAxUHRsZ1VhZ3pYcnhaNHRJZ2ViRGV6Vm12?=
 =?utf-8?B?KzZ6NnRTV3A4MDNXT0hpT1JSeU0wUlpON04vTFhWRk0yOUxQRUhBYXRYTFoz?=
 =?utf-8?B?cDVXamJUb2xadlFWR0RIcEl0TkpoNU1UWFJORjJkWUdKTHhkYTIwZG9raGI5?=
 =?utf-8?B?RFJFWVpQNzAwNmtxV2VDL2kzaWNvVko1aXhnQkJ4Z3ppRlVKL05zYzBtSDRa?=
 =?utf-8?B?eDdJbVlZdlp5L0tCUXBzOVRNd09WMXVWRlNuUzhka3VsdnpZVGQ5VnFjbk1k?=
 =?utf-8?B?U0tNbGpJYnRvSHhMYTZVUnNiMVJkS25zeENVcjg1ZW9SUUl0K1cxY2J2anhM?=
 =?utf-8?B?UmhZUTB5K0EyVEZzdk1OMlpBUGZnbzdLc3dYOHZUa2hvb1cyMHZtUWpHR0VR?=
 =?utf-8?B?NnNTOU1wa3lNK2Ewazl5ckg3Z3d5QnlmZUFueWh4WnVJSzgvU1lWQWVZUWQx?=
 =?utf-8?B?OEI0SlpaN0hhTGg5Z3lmTWFXaXYzOE1yU1oydTNFL0RmQVNTQzYwcHdvZUJX?=
 =?utf-8?B?WTlIdHgydDlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzlXV2hKR0pFNXVLdXhXUXByMXE1blFwT0U0M0taWDVpS2s2YWRFbERUa292?=
 =?utf-8?B?VDJpaGZ3UEVTelk1MENkYmhmRFR4czVDYVlPZUpHdWtTaHVlZjFJNGdSSzJz?=
 =?utf-8?B?KzZFeTJ4NVNTUXVGWnpXTFk1MUZjU1g5eGtaaVRITFp5ajlocGlNSXNkT3J5?=
 =?utf-8?B?SGVKSWZ3VVc2b28xMWNmbjZNUWY1cTd3NWx3NCtaTXdOWWViaEFhb2RzVzV3?=
 =?utf-8?B?NGlEUE9oN0ZIYSs5RzBBdzJOTStKNDV6a25XaEFBQ1V3T3ZPQzBtanNrV29m?=
 =?utf-8?B?a2RSdldBQlpEWTk0anhSVklHQVd6U2JNRFdVM2FPSmU0aGdVQmhieGRXeGxB?=
 =?utf-8?B?MTF0WE1rblF0VkcwNG9CSXBMTG1ROTF2OEJySE1YV0VOWklDcmVzUm1QR1dt?=
 =?utf-8?B?Nys5Z3dMQjl4OXZSaTUvai9LZ2JxOFgxdC9mTmFRWmVXZXFUZTVJSVJVMXpJ?=
 =?utf-8?B?WlZFOTI0eVpLZzJvVHVZMlBLbE40bWVteForWVBBWjFIcDgreURyZUlGSnJm?=
 =?utf-8?B?RjNqMlFJTXZtdGxDQTFZS2FHamFHMWtIVWc0cUpCaWxNRjMzVVpXTnpyOFZy?=
 =?utf-8?B?VDJCenFwbWF0Q1Q4bFQ5TVpzM0l2TnFIK0Y5d3lvaW9oeFAxNUcrRHlnWkxq?=
 =?utf-8?B?QmtCNGZQRmREL0VOUXp6UnhRSHdrUVE5WXR4Z2NBbWd3MUlCVEp3Ym1kdkRJ?=
 =?utf-8?B?VEh4VUF2RTZNVUt5SUxMd0twQkp6WnR1RjJYRVZZZDNxZXE3WXhnaTgrZTU5?=
 =?utf-8?B?dnVVQjYwNUVNby9NUUJDNHVMUFFLcHR1ZkdYSEJGVEZXV1BxTm5qempUSUN3?=
 =?utf-8?B?T1U3Y0dLa0hXYkxDYmtPd2tVUWdXdzJqeGMzSTdwOXJqb1E5Tk8zcWpldXN3?=
 =?utf-8?B?TGtCenVCZ3FpQldxTWdWcFBuMm1ubSttTUd4R3l5aUdGdjVxNjYyUmxpTHc4?=
 =?utf-8?B?ZjJIR2UvQWNqbjdzQjB3VEtDai9acnlkUlc1SUk5cE05dUZlb3hsQmp2ODNO?=
 =?utf-8?B?Q25pbnJ5QktQK0QvbG5VRWdaM3ZvMGhlSzFUSTIzb1p1UmxjVG9wekJtT1RE?=
 =?utf-8?B?azR0RGpCRStTZWt2ZjFDQTZGT1BuQ0h3OXhLam5IRlZhUXVwOHd2SFN4Z3B1?=
 =?utf-8?B?cTVLWVB6QVprZnpmelM2WW9WRVRxTitiSlUxaFNHZWwyWHFqK0pGcEJ0V2Mx?=
 =?utf-8?B?bDJPUkdhS2hXTC9lbFpjWG9iQnl4aGVUT25LMlFGQm5MZFpvKzQrRFNGNHgv?=
 =?utf-8?B?ZU85L2pGTi95dEw3amtidU1TMUVqeFZnRVR3MXhUSmZXTFYxWGlhZllxMFFG?=
 =?utf-8?B?T1EyY0d3UVNyeW81WXpKWFNNamI1djlnckhSVVRWb29JbmE4L3NENWg1MHow?=
 =?utf-8?B?Q3N3V2JSejNiRXRjZlVhZTZlS3A2YW5FT3hrbGFncDdnVGNldmpmNTBLQVlY?=
 =?utf-8?B?RHpUcGJpWFpNWlNVMHVmWTBMUC84K0dzelpGeTQ0Z01aSDRDS1p4WE9TSUtu?=
 =?utf-8?B?SytLWUtNKytieXVEU0NlMFltejdmUmsva2hGMU1yNEpYbE1ONitmc2tsK011?=
 =?utf-8?B?UlRzQTZwT0JHZlA0cFVVeVExZ2dTQ1hwaUxhQ2NKOFRFVGJhR25hai9FSkE3?=
 =?utf-8?B?UEF0d3UzVUxpMkRmQmRPWlRIaVVSdUdwb3BaTlJpeVEzMlJOdm5TQWcwVjk3?=
 =?utf-8?B?Qno2d014ZW5FZkRMcFBNUHQxaVVnNEJtcE9EUzFTK1FzTzc5UHFzbHN5SnNm?=
 =?utf-8?B?MVJIcUU5U3UwbnBOc3ZON1hnd0Rkbno5bi9TdnRCZ2hUcGF3L2FoY2w1Zng2?=
 =?utf-8?B?dW0za3JYTHhXWTJrMGloY0FYTUN6RzZXN2c2ODgrekV1cnhZS1dTdTJpbGdi?=
 =?utf-8?B?MWVuWjFtVjlwbjhnTzVFSHFOeTBkaTdia052dEgxd2RmTzg0cjBSY2x2UU1s?=
 =?utf-8?B?bThFZjZYY0NsTGI2dEt0TUJreWo4MVh2MlprSlJINERRSUQ3dTM2aVAvSWo4?=
 =?utf-8?B?WkF1aSsvOVMvakRXT3FwRTVTY283elF3V2hxZFFlakRDNW5YUnovT21YbHl1?=
 =?utf-8?B?RC9RbXZ5VnV2MVBPS3A5Z0lxVUlpVk5vOFV5TXJ1eU9LSFB1S2dSakhoRHBI?=
 =?utf-8?B?RXNrUktaL3g0Y0gxcGVwZDdwcXk2dmZpUG5RbDdROGxFUEh4aENVNnR0QmhP?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4XnD97D+aDxQLDfWVgCcrL2yb479j1mDD2kYPNnodWa0GXZSdxzxWALJAGgmXR2oxzru7kVu92r1DZHr1SjBfSyfr3v9W1BmMF1anphCAQrr3O/14YhFvDxrB4oL5aDix/BoDCzaGij1s3QcEanryTh7sBWsdxjD5t+mgHQqIJgMfygPzBqDvVs/yEhTnSwC1Tp8Vi9TEsQrQY1eti1v4aNOV1jywGU4Pu/oyQz2er38TruWNsx87qMgVhz+s1zbvSqZk6WjQ92zk2d3XaewYy/8cfVJMallLY15QMibuVHMLLepsKbYSbtu3l89VVlrpu/Ev8slKygoPj6hak9Q0r+K0nVbczvSebmEX5onNR5aqG27p8S2OwBeR4qj4ezTecg1ac6v9BnNZhrExtXb5WfuPMYMAf2oNgdsWk16E61f5vFPDRjEJqs6AjF0QKVNfmU+C5zsLagSoeQxVEiGwM+eHLN6f+ecsaqa3hYdd71XcsAvMf7seHqa3T5DimevFyP62+FTtLmsYBMQupuElMgXeyaa4sz7nst2cPIxLDmie53KWGszHMwkDBWXrAwPVMD8U3G6/w/FsPXNRfSjaqWr0i8frA2UyHz30fgfhlk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2126ca-1f50-41b6-6b80-08de22d40e79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:45:30.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbF7rtRU8ZAM/mNTk3E+VKkqLxXA82ahRwW+l5zYfrn8KRvOjCgRmjMsw6mopiXY+rV6mrmAA+ithbiq/G1QMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130130
X-Proofpoint-GUID: R5P8fOoGRM7p--6byAzMXVZHzVLs3av2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX4QasecaMaW9X
 RGHSgX4YmVrjDou5jmpJoZ2gT8sm/BQULqcYzbZu36QUTaEnB7mvfnnKQWJkwZkdXvwlrJ0JpwN
 w6kkTgjK/1Xw2Am728ExFr5FKIVpawcRuQTTYA5lBpetMZ4tJ1+OyvZlBEXzINX8rXxBQZtVmoT
 2TWDd9JU7ajGfelmGcHbKPVwt+xacuEEakvTI3fHgecZxSsPHjYe0KqFlVKDZDKE+D9+8Au6AXp
 haXMzcvnPExqGj+zUWKrz3uM+ZpnRRY/F6MfpzissDZCcOYBroqFmLD97qSXvU5bEm6ON6UGjHr
 +2Zn2wDpR0YzFyNrKVJXK1+bpqi45N1XtTNh5JvZheNApL1WZqq6t3a2M1S2DTqtjTu4Zd8k4Ct
 CzMY33EIJdK23bjvd8Q74Ao+rL3tjA==
X-Proofpoint-ORIG-GUID: R5P8fOoGRM7p--6byAzMXVZHzVLs3av2
X-Authority-Analysis: v=2.4 cv=HLzO14tv c=1 sm=1 tr=0 ts=69160b30 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=NEAV23lmAAAA:8 a=API3mv59V5S-Ttozm8UA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22

On 11/11/2025 17:04, Yonghong Song wrote:
> Current vmlinux BTF encoding is based on the source level signatures.
> But the compiler may do some optimization and changed the signature.
> If the user tried with source level signature, their initial implementation
> may have wrong results and then the user need to check what is the
> problem and work around it, e.g. through kprobe since kprobe does not
> need vmlinux BTF. 
> 
> The following is a concrete example for [1].
> The original source signature:
>   typedef struct {
>         union {
>                 void            *kernel;
>                 void __user     *user;
>         };
>         bool            is_kernel : 1;
>   } sockptr_t;
>   typedef sockptr_t bpfptr_t;
>   static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
> After compiler optimization, the signature becomes:
>   static int map_create(union bpf_attr *attr, bool uattr__coerce1) { ... }
>   
> In the above, uattr__coerce1 corresponds to 'is_kernel' field in sockptr_t.
> Here, the suffix '__coerce1' refers to the second 64bit value in
> sockptr_t. The first 64bit value will be '__coerce0' if that value
> is used instead.
> 
> To do proper tracing, it would be good for the users to know the
> changed signature. With the actual signature, both kprobe and fentry
> should work as usual. This can avoid user surprise and improve
> developer productivity.
> 
> The llvm compiler patch [1] collects true signature and encoded those
> functions in dwarf. pahole will process these functions and
> replace old signtures with true signatures. Additionally,
> new functions (e.g., foo.llvm.<hash>) can be encoded in
> vmlinux BTF as well.
> 
> Patches 1/2 are refactor patches. Patch 3 has the detailed explanation
> in commit message and implements the logic to encode replaced or new
> signatures to vmlinux BTF. Please see Patch 3 for details.
>


Thanks for sending the series Yonghong! I think the thing we need to
discuss at a high level is this; what is the proposed relationship
between source code and BTF function encoding? The approach we have
taken thus far is to use source level as the basis for encoding, and as
part of that we attempt to identify cases where the source-level
expectations are violated by the compiled (optimized) code. We currently
do not encode those cases as in the case of optimized-out parameters,
source-level expectations of parameter position could lead to bad
behaviour. There are probably cases we miss in this, but that is the
intent at least.

There are however cases where .isra-suffixed functions retain the
expected parameter representations; in such cases we encode with the
prefix name ("foo" not "foo.isra.0") as DWARF does.

So in moving away from that, I think we need to make a clear decision
and have handling in place. My practical worry is that users trying to
write BPF progs cannot easily predict if a parameter is optimized out
and so on, so it's hard to write stable BPF programs for such
signatures. Less of a problem if using a high-level tracer I suppose.

The approach I had been thinking about was to utilize BTF location
information for such cases, but the RFC [1] didn't get around to
implementing the support. So the idea would be have location info with
parameter types and locations, but because we don't encode a function
fentry can't be used (but kprobes still could as for inline sites). So
under that scheme the foo.llvm.hash functions could still be called
"foo" since we have address information for the sites we can match foo
to foo.llvm.hash.

Anyway I'd appreciate other perspectives here. We have implicitly tied
BTF function encoding thus for to source-level representation for
reasons of fentry safety, but we could potentially move away from that.
Doing so though would I think at a minimum require machinery for fentry
safety to preserved, but we could find other ways to flag this in the
BTF function representation potentially. Thanks!

Alan


[1]
https://lore.kernel.org/bpf/20251024073328.370457-1-alan.maguire@oracle.com/

>   [1] https://github.com/llvm/llvm-project/pull/165310
> 
> Yonghong Song (3):
>   btf_encoder: Refactor elf_functions__new() with struct btf_encoder as
>     argument
>   bpf_encoder: Refactor a helper elf_function__check_and_push_sym()
>   pahole: Replace or add functions with true signatures in btf
> 
>  btf_encoder.c  | 79 +++++++++++++++++++++++++++++++++++---------
>  dwarf_loader.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  dwarves.h      |  4 +++
>  pahole.c       |  9 +++++
>  4 files changed, 165 insertions(+), 16 deletions(-)
> 


