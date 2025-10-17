Return-Path: <bpf+bounces-71200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F252BE8FC4
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 15:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E43394E8D38
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADCF2BE02B;
	Fri, 17 Oct 2025 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CI+6KYAO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YZ5N0LL1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CCAC120
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708869; cv=fail; b=nGDb7ohjrIKhDzGaxOrhosd5Ss+tuUdi7cHrBKQt8Vc24USzRGMMDZ41e7dC0PReMLLrgY1mAyw6PXlJtsWs0c5lh8f+KHq5NT6PP0mbRP4UWGMELixyENdq6ZqCAPj+O0htWC705ly/4KxbE4YZIfGiTrIoWIicbFyj4cWWfJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708869; c=relaxed/simple;
	bh=7V7QoLVp7zC3FmXSajZg/0XTP6bWdqpGcjk9cM1er2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mlroAkPnLMsLt3IMKIpjpFfm7hpGyQG/pYKMUq9Yo7+l+DE2w3K+PeFpe3cePh5bF2w/vXgNdx7+jgbAT79jQrUF374br/PQzK8h9RJWtQYPybACGukaxrz4ZAWoaeQY3LIJ7kl5AEztQ4HWxJusmposi2Z4nr2ite5O6eV9zuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CI+6KYAO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YZ5N0LL1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCddeI018894;
	Fri, 17 Oct 2025 13:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oADSImoxMIjTxqcZRivuCBqCy1jgFMzecolqRaIF+M0=; b=
	CI+6KYAOyVEJ7L0LDTOt/FQ96OaFoj/divqCvnCydeGvwdmsxa9vCeAQZL6B6mp2
	zXjRspEmNbiGFs70n9fboq8LLoKOrImrhLMNcnfWlSJKGsPLKOPMst1Jok9oxjiw
	pPeWYEC7K/egN7ax7vJuLZch7IOw3TeQFEOxozfo+xxs41g+YUF06UM2uxgtvXNy
	iaM5p/9uT7KUpRiNkW848UEhmbX4fyXnxL3nY1YFp16i6r7d6Wo78UYoHRRJl1C7
	hv+no6ZrCeNRTbnzxBudypIcuFnSbqJQ63Yz6qp9kXkR68TCU7jCxTEPzqh/Jaak
	Udjim6OJZcHkWZb28YvO+A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfss2wsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 13:47:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCinMn017942;
	Fri, 17 Oct 2025 13:47:22 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcv3ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 13:47:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTkM8rfl1rpYNb6q2WA4Cs+Zfr6N79uGWMJTI88AiEHGcOUkbIUYhsbwtm1LrHisyXz1TPVhF2GFaXFGji63zMpsGW/Vgzu39fELShoQ2HhQsFpzcTm4LGMvyjMBywbY1dS6fC8tL1Ea5dpnknBxbbbDTuVUoa8XUH36Fx8107eer7tW0cAJ50BJe/zlEFL2n+0C3vgCKSd8dx//jz3NcYrouDzECyGPsCOk8m+c2NPjqB3aHX/vXpc4daj0Q2ocr+ftvPKSY5iMYLACSV5Egk0MBTmWPhiF8l7+37nOZ0xlGe3/Az3iUlVyUmrfBFNowwQ2pyo+rACabNHyTZsh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oADSImoxMIjTxqcZRivuCBqCy1jgFMzecolqRaIF+M0=;
 b=Sc9PVHl1nK7YXNgCbklvSMTGV4sgDpivCXq//M0kOmLOWxpG3+IUPPgqGnutsPTvcaa+/qgppU6zoja+qqurmkt920eHiqIIQwmP3CjdXgp6+5N7KmR79gomHDFP+jPzYvGLZiJfvwWznddJaqMkl0xL3MUocxyVnCoK3Ouli3w+KcQJK2/UsVVlTe6qeNCE8poq1IswpGVRXehAlIs7bou57Cb9X3LjClck2L3HxjaFLkC3htTs+HEQw4Pj3ztVVBtumq4kakYN3LFaEcP8cpwhBg3Ti50GMfGhcmgTzl4DjTdMku1ocUr3Iv7GIHhEUXfXPaQ9Y+FpUvg1QAt66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oADSImoxMIjTxqcZRivuCBqCy1jgFMzecolqRaIF+M0=;
 b=YZ5N0LL1E5R6fDxX0qyfERL0p3PlyjJtKrhqWeJ94TRBcj5KXE2HPPF+IGYeUZegibWAoi2uxJ7ocUk+C71KlT417S2jmvo7M98XcYQgbx85srgGC4EQiKMoZE4JgsssZT1WfnADBzIXmnz1tCG+GgU9vc1IwwfcBG/dUI8XOhk=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CY8PR10MB7171.namprd10.prod.outlook.com (2603:10b6:930:75::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Fri, 17 Oct 2025 13:47:18 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 13:47:18 +0000
Message-ID: <06efdbc3-da08-4181-a469-93d0f200c9e6@oracle.com>
Date: Fri, 17 Oct 2025 14:47:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 04/15] libbpf: Fix parsing of multi-split BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-5-alan.maguire@oracle.com>
 <CAEf4Bzb=B=iZgC00HY8otd2M-q_899u=ag_2WCnJ0pQjEYDZhw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzb=B=iZgC00HY8otd2M-q_899u=ag_2WCnJ0pQjEYDZhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CY8PR10MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 3909eede-34fc-4b54-69e1-08de0d83b001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUJ2aVl2cVBRVHh1aGtaZnR6YlZzUWdFV1VGM0lhd0lzbnFhU0txdFFKVTdv?=
 =?utf-8?B?V0ZzdExSU2pRV01adHUwMEhmaXBtZFJQQVpPNlU5K3E2aCtCVHMxNDMyVDNX?=
 =?utf-8?B?Z0JGTGJrZ1Q1YUM2NXlISVNJSEFLTTlNWWI5R3FsVEt6bktkeHJ1a0lwaEQ2?=
 =?utf-8?B?RWZyd0JDSlUwVVlZOXFjbkhud3k4bE5uazFvUEMzYk1mWVhjSjlyWkREcXBI?=
 =?utf-8?B?K2Z6UDdGUmcwaGY2OU83ZEtBOHhsMkJpZ2VzMG5oOVlsWENjbTRHWVdXRGpl?=
 =?utf-8?B?MU9YSzhtOGFWUXBNUFRkV0ZGNzhXZ1BOWXdhUHkyMFl4VmN6SXYxWm5hOG9o?=
 =?utf-8?B?aWdrcUVDSzl5SG9WNzBEM3ptYXRJR1lNQXg1a1U2TFJsQWdRYnViSG8vMll3?=
 =?utf-8?B?QU9FZHdSbDB6ZlFsSjVGU0ExZGZIVnFNNVpsZXQyNDJxaStoZ3pUMGtNY2FI?=
 =?utf-8?B?Yno3eWV4RXJ3SjFPckx4YmxDNnZJU0RLOGd2akQ2TXZWTGNScDcxTy9kcHhp?=
 =?utf-8?B?S0c1dWEvTE9mM05yUXBzUlZPcDZ2WDlDYVNrWWRUcTBDemRkdTlDQ0R3WmpY?=
 =?utf-8?B?L01nMFFUSVQzS1M5KytMTkZhdFZJaUJaTGViSklKYkVEU3Z1cWZvNHAzL09u?=
 =?utf-8?B?ODJCQkNFTWhxbENGOGJ5QUpMT3VhV3FaamJmbG5uWFBSTXhndjd5cmZscFRI?=
 =?utf-8?B?TUF6aHd5WWtqZndZakRXcGhXVTVjYTU2VVphZFlhRmUrY0tQUXZpbjRmS2NQ?=
 =?utf-8?B?ajhTaHhmMzBaRGxKTXBwYitQa0FKSGxLVndzaHZFTXg0QnFuV1BRRzRmdkVL?=
 =?utf-8?B?QlNoNEN4ODFtYzdxTU1tWlRhcVFObG9qYzlwYzJUTFdQbmkrSW9XdVBWc0Y4?=
 =?utf-8?B?MTVNSG5jTW9Eem81Mm5OU3ZIOGNhbTVHbkpwWUREY0dNblpZYytFSktkbUR4?=
 =?utf-8?B?M0taTnVvUXZBOEZJWWpCY1BUendITVg4U3ZpWnF2Y2dGZWpEUjVmWXpMUG9x?=
 =?utf-8?B?bGx5cWp0dzNtR25YZHZlbklmTVhWZnNOdDZ3Rmc0U1o5a0t4M044L21oMHlu?=
 =?utf-8?B?S3ZHb2VkR2NPYjBwai9rMmFyNEw5a3psbm9XVjNlNG56M0pTRHo5Mk5DdUxO?=
 =?utf-8?B?SzVDaDNoWHNjUkRyZHltdTI5MU1uajJMZFA3bVlZK1NHTkp3b24rSThWemc0?=
 =?utf-8?B?VWFXaDI4NUdWcXhOWEFpYWNBc1MwK0VuNEZjOE5QVlBjbFd0TnczK2Rka2kv?=
 =?utf-8?B?WVBEYWlVWXRSZEllbU5aNzdJQlZ3NzlSdEJpMWQ5UXRTT0Mwa3hqaytKNUE5?=
 =?utf-8?B?RHZ5eVpoOTQ0bHRHNnB1emE4Z0xZeVF1enE3aXZSM0wrZEdma0t5U1RRUDRO?=
 =?utf-8?B?Q3ExVnJzcGhkZTNsY0ZqcHlUN2ZMK202dzRWS1dLRU80UDZaMlhZb2RhdWh1?=
 =?utf-8?B?NlpqVHJpMk5YdE9RZXJ6aHZFaGhIaWZUMHBaby9EL3kreUhuNUxYcTN3ZENT?=
 =?utf-8?B?eEhnc215UE9KSndtSHZQQ2dXdUNaMGRvR2JWNzdvQTZuTUhNTUxrSFJhRW4z?=
 =?utf-8?B?ZzZ4VXQ3WXVCT0c1MFlRanRHOWtId1UwWms1T0cwUjVQMlluTzFybEdyZllz?=
 =?utf-8?B?a3FSZURndWI2NVdlem1CUzNtelFNTWZJNWhTTHlydEQ4eCs2M1RWVS9pZGl2?=
 =?utf-8?B?ZWZyWlN3b3V1TWVuMWJXeTBGc3ZKL09NK1hhZVZudmxTQS9OTkdnbTlUMlAx?=
 =?utf-8?B?QnhnNmk2WXNJNXBrZ0JDY0c3c1NmaVBxOEhPUnp0TnlHK0ZuNStaQTNSZ0ZQ?=
 =?utf-8?B?MTh2TDY4azdVTWNoR1hXS3dXdkhJTDBQa3cveWludDBVS1Vyb0ZJTDNsUGwr?=
 =?utf-8?B?TlJPOXJHbjVqS3JHS1Y3b1ByMm1DWjhsTDI5Y1BTbGZKb1IxcHBEc0dSYjFM?=
 =?utf-8?Q?k8pxWqY/qI/4bJEgA6al9oM97QqpVg/v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkN0WTI1WGlpTnNnb0owS3A1YU9xUmM0T0RyY3dqQVJuV1IxbjNhNWN2YjRm?=
 =?utf-8?B?dVBBa0t1aUpPNnN1S2NRK0FhMW5BVWZ3ZWR4VEdlMTVHNngrU1VoaG81OXZv?=
 =?utf-8?B?WjZzSmpRcUFVRXdJSk5WMlBkWW03ZXVPZWhBRVpGdVYzbmUyeElLQ0x0R3hZ?=
 =?utf-8?B?NTVpYmFacnhmWGVkelN4djRTR1phRzRxZDlQRkdGekxleVd0Qy9wOHoyVCtp?=
 =?utf-8?B?a0hPQUFPaEdxVk1DQVZMQ3Y3by8xcStDRHREN2ZXTzAzK3hiN3IxdEl0U3k4?=
 =?utf-8?B?N09HT1A1YnpDb01KNktUYTJpSUZPd2RBOW9nN1R1K0xsV3d4V1c4N3Q2cjUx?=
 =?utf-8?B?Mlg2TzczMmJLVy9weERTYVJJK3pxODJtVThGZHkzdWdJYlN5QjhRc2tyR3dB?=
 =?utf-8?B?MXo2Z2N2dG01ZUYza09wQTIxK1pYZWFneGpDd2J3Rll0UHM1ZkFWUHNoeG5X?=
 =?utf-8?B?amZvR1FBKzNkc2k4bHdRU0kvU3JCODNXZGEwRXh5RDAyVGJIaG1lTCtEOWVz?=
 =?utf-8?B?bXNFR2hJSHBGc0dhTlJnNERwcExrRDlqSXU3cXZIdWQrWk15M2pYUDlKekNi?=
 =?utf-8?B?SE85L1NMSHN4RExTK242aGJmZU93eXBzMXpGd0hCalp5ZVYzK1RKMzlUNC9o?=
 =?utf-8?B?MzdONGk4Nmtmb1R4N0pSTEhndEh4U3JVeUpISWJqWEJQc1NKY3hWRlNXYVhR?=
 =?utf-8?B?UStIMUEzZ2ZQQnE1RW55cEQyQkZsVmNNb2d6Z1d0empkbGYyUFA4QzQrd1hU?=
 =?utf-8?B?bllPZFhHVS9QQ0hsUmVrWlBOS0VoT1d0eC84cm5mWUtGN1hlc09uRGpDNDN1?=
 =?utf-8?B?dXAxRVZlcmFzaDhnUzVZWE5vOTRFd01aUkxONVNhVDZOT1ZWNXpTYnVDeGU0?=
 =?utf-8?B?YzErYUxoTi84Vm1xMGZMamJJVHVKNjFzRHhEcWR5Q2xQalBVSW4wd1VEUSt5?=
 =?utf-8?B?WHpJQUgvdkxhckd5R0Z1cnl5andrOGFseC9pbnRnYXRhVDQvbHhzbU4yRmJB?=
 =?utf-8?B?alFaY2VOT2dnSFE4cFVUOGhxRGJLTVpEQ1daSGhIelJMckpOWlQvY0dhWFBO?=
 =?utf-8?B?UWwwbERVS2dhOG9PRmxReEd6SHNtMmdGQzFTSDN1WThCY2Z3WE5kbGUxcGdS?=
 =?utf-8?B?UTVoUmwyVjhNaGdwaFh1aWZBeEJhSzBNS2JpclArbzRDMjl1U1lRM0FOT01z?=
 =?utf-8?B?RTZCNk82UTFkS2doYklwa3NCK2JrMmdsODlKbkNOU2FydytVd044czV6MU5F?=
 =?utf-8?B?SFJ6c3U1UjNGNUZBcG5KUlMrN1ByNEh6SzNYaGVtNDJ4b2RBd1NsUTREcVhY?=
 =?utf-8?B?eTdHN2c3bk4rUXFUTWczcDF5UFhvM1JHTmE0SlZiU1F4ZDRucGlubzJyUWxn?=
 =?utf-8?B?cG96Y2RlUWpaRXFLdlVxblpJem1paFhHTXNCMjZSWlU3ZjVWSnNKVWJjRFk3?=
 =?utf-8?B?MFlQVjVPVnlzL3NLSkJiY2xrakdtVFhvMnZVUSszVWZ0Z3R6T3pxUWxOTGhn?=
 =?utf-8?B?Yk14cExFeUZGeFpGWFhjVTc1bXJBeGM3ZzQ3MXRDRnZzVHR2RWNhYTVoTnBv?=
 =?utf-8?B?SUtudlVsZGQ1ZjdXdmdtSUZBM1l5c2VFL3pZNGtUbnVmYVdndlc3ZE1za3BV?=
 =?utf-8?B?TEEvT1pnSHlkaVhENG5vOVlXaTBla0RKR25TeHhGeExkRk9aRVJnNGp0OWk0?=
 =?utf-8?B?RG9kRUh5UTRhcmczSjlQN1RBOHBiZUZEK0pwRnNaSS9pVUhaOXRta2U1TFFh?=
 =?utf-8?B?MEFzSVRNVE5ZemY0b3hDZ1ZydS9JbkMwYlRULzROWE5Ec3kzRUpoNC8yK3Rt?=
 =?utf-8?B?QXkxTExPWHZXcXdScytuenpxcktUalRxaGo5b1ZyTkdILzE1OTZ2ODhrSzRF?=
 =?utf-8?B?cFBycC9Pb29qYXIreVBJK0JUeXdJSlkzbVJ4ZTBVcTNxaUx4SUlsY2dIZVhv?=
 =?utf-8?B?QUg3RG81VzI2b0NkeVo0b1NyeDZ3VDRXdlBFc0ErNGlPak5NdHgvMS9aeHYr?=
 =?utf-8?B?djBDajhZTTZzM1I2UEt4YURwWmtCS1p2YlJiUjdPMVlMVUk1VTdmallkbkQr?=
 =?utf-8?B?dUtIc2Nxb1lJWmpZdFRZbVJkeGlNeldLeTVCS2IvS1hDTkZrT3pweWxTalRL?=
 =?utf-8?B?Y1RsTXRsQWNpdGk4SENCc3pENkZxNWRNZXdENEFFTi9tdjR0M3REV0ttbURz?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D0X1T1BTUC4Td67ar1xWsL5VPXLkk5adE9vyfA6CzZP1PAKZbR9UYrOHRoVTYLGsRHxbGwdaGd7zsNOKvDaUfeUGnwngLt9h25su7nB0Gi7MqeFSyFipz91AQiesb1/3wg7Nkzi11h/RhXwTbeg/dfzL2qI9JcLAWk6nwgo9l991qXEs+Y5aTsgYNCDCcIbygj2GPzv99OKtw8Yn/CMveoQ2ABuxYC8aGmF1dCbv82eDH0iIsvyA8V4u0mRix+KvZlReN+OsegW8rg2DsjUCDfAoZyDoU8umo3khItWo4WsMjGACeAiZzlR5+GYrONhT4t8DOQVSDVfPRASQ9XJbNO0O5cEB38kovB9NDmut38ssEYMlQl17vWmgliHAz9iq1bJbgnGfK5xqGEY8+LSLDWIgO7ejp/ZJaYEwKDJv2G/89cc5sWs1ivTYhWIXbYfUust06Ek4pvf++OVAW8jlnZgcTYlmNaXXvhBMpf8GdWbQpjFV30PJdyYuI5SfCJCG3qbq688rKRiQ5QsXmEMdAwOGNvcb8JcNYzlUGNmOBcUYCTyj0gGP9RbU7R3jWhwiHNPn6L7jjtQDGPfG8G3etJoP5FFfl8l0mktiPrM9Nr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3909eede-34fc-4b54-69e1-08de0d83b001
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:47:18.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKeMjysWx7ysEBcAnPYPm+2WiFbVI+0jAAkG+KFX7Ylotij/ib40H2xPYhtP81MaxMY9yFK+MHD1QfMKUUYaHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170101
X-Proofpoint-GUID: xR_whNIxntd9Xmk9SvVA7OccZNUpBjN6
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68f248eb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=MamOVrjnB-55ztxO3rcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX6Brgq7MCIiac
 XAWxF0AneUd7W9kp898ouxn6yqDwdKaJFyFTfLuANwDGknJtiCGzTbizquD4hG8umkf46hzsV+T
 /wsAN3kY5L2vBNRXHzPj5rXT8xStNWf4SMJuyiaE9nA9hiUGd51I4g/0FAVeXZYYkdFek2FN+X7
 AMuyuHzphdAgR74xIvXGcGffYkPXMwPpBZ0Umn4aQ4moSkY8EGx8XlKtoAAOSsUy9fyDHkOAMW8
 BPRQ/4SLQg7EYXSOQI04qAZw7b+STrZNnsMCLYz6BaadLrcpmY5JCvrYagYqW69vQV0+gJKX3yM
 sA9d8NszFbCCtwPyZkKRV18KnnI5MwpxdAV5wMjjDZfaHpdOYFMmGob/qcaZgYBF/YNpJCYZ3Ka
 F+EPQeRccSKFb0bmL5NpIiAcuVQLyg==
X-Proofpoint-ORIG-GUID: xR_whNIxntd9Xmk9SvVA7OccZNUpBjN6

On 16/10/2025 19:36, Andrii Nakryiko wrote:
> On Wed, Oct 8, 2025 at 10:35 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> When creating multi-split BTF we correctly set the start string offset
>> to be the size of the base string section plus the base BTF start
>> string offset; the latter is needed for multi-split BTF since the
>> offset is non-zero there.
>>
>> Unfortunately the BTF parsing case needed that logic and it was
>> missed.
>>
>> Fixes: 4e29128a9ace ("libbpf/btf: Fix string handling to support
>> multi-split BTF")
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> please send the fix separately
>

sure, will do. Thanks!

> 
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 6b06fb60d39a..62d80e8e81bf 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -1122,7 +1122,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
>>         if (base_btf) {
>>                 btf->base_btf = base_btf;
>>                 btf->start_id = btf__type_cnt(base_btf);
>> -               btf->start_str_off = base_btf->hdr->str_len;
>> +               btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
>>         }
>>
>>         if (is_mmap) {
>> --
>> 2.39.3
>>


