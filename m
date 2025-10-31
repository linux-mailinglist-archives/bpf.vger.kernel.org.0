Return-Path: <bpf+bounces-73151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F419C24630
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 11:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F7A4631B9
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D7F337119;
	Fri, 31 Oct 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qIbCIJVO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WtfEcvVh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C730CD81;
	Fri, 31 Oct 2025 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905586; cv=fail; b=Gbg3oU6iB087V7b24XyVxwhrsJLp39uJeTIgX7CymmImzFN4wKCesBUPeWy3XY7MMdligwohZDaBU1UzWmi+0x8Gk2z1CNF5f/Q+F6cl9jNCUtS9bxdJ52kKLywQPRidkgfKr7PJ02KFq+TDJoyCEDFd59Fht/Xer7aTrYYXegI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905586; c=relaxed/simple;
	bh=Lpm1kmrF+S59g6SXWV1AulToSnmyvPNQPxevA+kVc4Y=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fch9AwnTsWfiteF3WUcjr+KkHXthRpgC9pfCNDG8W40YdWRP0DhzjnG0WmeTyVT3/+wRcGJljXZ85KNNIApSJ+y5SKP75G4uJNYKCgUXrq5JXbhFXV+oK2roFabENBFHDDanM8WRcwgtr1okry5cSBZjGekMSijJB861sbM6y3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qIbCIJVO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WtfEcvVh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59V9xhdu013255;
	Fri, 31 Oct 2025 10:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uJNMQ0h5/vf/vfAr+gbnLrQJ8uGtWTYdtrnMWgljSlo=; b=
	qIbCIJVOKJKgh5Gpeyzg+IMEzZtT0HGtj0g3TdFFI4qSRdTRZHxvVMOPEtaAQwmg
	wE8RVua4D3OQX0xBrycigdKYQgvffCaCn2ekDAxS9m/WP4KjeQvh1s8g7/ZydeH8
	11APeWDVITm63R1uXU4UJ2DXYPTeuOTSNUhYjgh6MtGqT6QkE42kaIOzUDjWKvZu
	ddQsNBjSm9gYE9djGmFr9dKxL5XO1OzYJGgxxm8uCNR7emoWIrE4UEC1ulytHsVN
	LwwWp0j0W7HEt/Y9g2D+M17nnlPsPzWNmvmWiSlrMQGx3JeaK84XPzPIGBnk8IkC
	yCQouotHac9B/60JBJK3xA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4tybr184-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 10:12:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59V8AQ4t004325;
	Fri, 31 Oct 2025 10:12:01 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wntuvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 10:12:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+D7Sb0Z/bQAK8mtlj3k5QWUrPLs5XJc/jM7kEHgpiN62euOK57gpzgobAJnWVejoKw1U5lHPYpohg15FTXrN0MmLvQEM64isR/Qu8vuMbvesk+YhH/SDByFqkc9GaspgZQpsjPYT/22tAbgyYfAzr9i6FtwVJ4Qhv/1/n/yZeZuNQmK5rwDnAUryKedLqBevgI9VZEP6iEiVdEs4ZiRRIYKIIHraqfIhDxUz5BJI2NOBc6d8gttfbFuFFiK/XG4Fd6EsLbTk7ucoQhpMrLnu2OoczpVhSlZVXn9hzPLNsA3/91qZrFn/nbygpQBlMUQ1o647d0vX2hafoX56XRQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJNMQ0h5/vf/vfAr+gbnLrQJ8uGtWTYdtrnMWgljSlo=;
 b=En+2nIV11zz2cabJrgwO4s9Syn2MfCMon8jJeS6M0x3deUS/eiRjRMaWiBjjZdtgWnNTH5nrJS742c6q6cXMM4+hhvW7rN4yVaaAHemy+bBIBPxcDkMQ1Pghc+FuAoXGhdqQH/YAA+blciNRI9lLbgaSHwSearF1BrM9bsODdgzhxB03LRXPmoYilahgc3HVSPtynC0gD0xmzLX3r+OGf1rLhL8ynL/y+pQzsae7yz9fiYS3m3Yll+Av8eCMHvp1kbZN4UcSJjPD43gCEfjAD+T/pBbBt6FJSrviK3XlkpfdHtnx3hcDbrEHeRwIxRvB1f7VK2S9hVCd47YZYv8bJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJNMQ0h5/vf/vfAr+gbnLrQJ8uGtWTYdtrnMWgljSlo=;
 b=WtfEcvVhOYSLKKghWtSYdbtkFiP1ygCzDee4PQ+Hg7KjuykMy0HxrGgR3g7PLXEY1Kne+ULd/KMreY1tL3EReHCbIHBeym+0gtAf0ZzijpLSDk/A6gHhz1/JGycGa1t/Zc2tjUv9CgQz3B6f0SQmhtFv1lH1R2ciQUzYY2e+M3Q=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MN2PR10MB4224.namprd10.prod.outlook.com (2603:10b6:208:1d1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 31 Oct 2025 10:11:58 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 10:11:58 +0000
Message-ID: <c0350a10-b924-4a16-94fe-c7bc21af26a0@oracle.com>
Date: Fri, 31 Oct 2025 10:11:39 +0000
User-Agent: Mozilla Thunderbird
From: Alan Maguire <alan.maguire@oracle.com>
Subject: bpftool BPF signing supported using openssl v1? (Was Re: [RFC
 bpf-next 2/2] bpftool: Use libcrypto feature test to optionally support
 signing)
To: Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, terrelln@fb.com,
        dsterba@suse.com, acme@redhat.com, irogers@google.com, leo.yan@arm.com,
        namhyung@kernel.org, tglozar@redhat.com, blakejones@google.com,
        charlie@rivosinc.com, ebiggers@kernel.org, bpf@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20251029094631.1387011-1-alan.maguire@oracle.com>
 <20251029094631.1387011-3-alan.maguire@oracle.com>
 <fb2fd1cd-239d-4783-8b24-66af0e754a47@kernel.org>
 <4ad07c65-1d4e-40ad-97e1-a7594a4d0d2c@oracle.com>
 <fc3a12bf-8b79-4ba9-8129-a4ad11c4852e@kernel.org>
Content-Language: en-GB
In-Reply-To: <fc3a12bf-8b79-4ba9-8129-a4ad11c4852e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0377.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::22) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MN2PR10MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9a18c3-2a0d-4dd7-75ad-08de1865ecff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEFxV2RGMlNMT3g3WmNxSHRMTmQyS2JITU9MVE5CMnlqczFya0RHVHd2M05E?=
 =?utf-8?B?bG5vTXcxSlhITC9ZUWdRZDBWeWZ5clRORHhwRDFobWpYNzRaWFJMVENDS1RJ?=
 =?utf-8?B?NXE1KytwbDEycm00RVZzUlRPaHhKSHBvcEROVDYrYzJCZnpvdld1czUwSlFI?=
 =?utf-8?B?L1o3RU5ZUy9DVG51TG5JUGlsNDdCZFhBby9idHI0U0owcTRJMGJGdnhOR3NO?=
 =?utf-8?B?aGZNekhWbHJvdkUwR2hpdXVDRGpzVXcrVVgxSEwzaDBVMUxIT3FRNEZKQnNl?=
 =?utf-8?B?ZkxnRCtCRk93dEU0NXA5bEZaNFRpdHZnaWxOSjBXWi9xMUJEQzBzTStXdjg0?=
 =?utf-8?B?cHlZdTdFQUh6RzJrQjZ6MkczeVZVV3pWclMyMjR6T3d5Q2dWS2VSRzZvdUtI?=
 =?utf-8?B?S1cyR0tvWHIxeXIrdG54VmRwak9UVEh5MW1PQ3N6TUQzNSt3MGJZRDBvaWdn?=
 =?utf-8?B?ek51dGNzR0dhTUJqSVdvcnNnSW5MWUtEdUF3ODVMMVBTVnVITldJVzd1SjdL?=
 =?utf-8?B?MU5pVGJuVXhSN3RNM1BUUkhqcVZpOHJheTBjeHc5WG85bjZIUjhyaVdnbW1F?=
 =?utf-8?B?VmZVK2NYbW4rVjFZcXkzazJWK3BsVHRKOVBwOXNhaksvRzF0TXhzRllpV0xa?=
 =?utf-8?B?aGZkMUxXcnU4OUNOSFJncVZLMUFldEV4RXJ5UWNWN2FCL2tzWmxuRkIwY3dG?=
 =?utf-8?B?UXRYR0dZaStnSWJDZlBrRitYOW1OUXpablh0ZHVZS2F3TXI3NWxJZHE2QlEy?=
 =?utf-8?B?RkRPbDBabXlJUUhyaTZBTUI0c0FVcnczK3M5UzRheFdHNllRTGlzNjlsWW5Z?=
 =?utf-8?B?WTI1Ni9JYkJES3l6a0JOaGZaRUxrd1J6R2lxTDZMQm5HdzRIb3dia3dQaFZY?=
 =?utf-8?B?QmVQRWc1amdCYjNIVUNDVHVmQlI4cFFyOWVqSjBId3Q5WGZuOGJXZjJVNkZ3?=
 =?utf-8?B?b2VueHJvZHk0TDBqK3ZPK2JYMjA0OE9PNmdIT0RZTXRnTXFtaGlWOWg4djdE?=
 =?utf-8?B?Mm04QkVydjJZUTNSK2ZWT09RVmROaitJbVZ0Z1kybDB6VHZ5MTRRQkQ2cTZQ?=
 =?utf-8?B?MGxIT0loczZrVWhEMG5uR1VyTmZZcDNleUQ1NTB0T1N3MnJaWXlWc0JXMDlT?=
 =?utf-8?B?bERQUUxZMXpwZnRhN3VtZEZlZ1dLNll0djRNdU1WYlFpa0NiZEJHeURUNkc5?=
 =?utf-8?B?V0pOTXdTOWRVMGpleDBjVW0vMk5NWFRNelpaOGNZYWZKbFM4MW1JZmxEV1Qr?=
 =?utf-8?B?WU5LRmpRMndnNzdiTzBkTG1uc0Q0Ym0wdk9EcFNqOTVVOGRrejh5cSt0T2dr?=
 =?utf-8?B?UEdzeXQvZFU1cWxZZWpYVkdsaXMwQ2pPaCtpQkFzajEyWjJlWk5Lc3FUY0FO?=
 =?utf-8?B?c2EranMwR1piVmxZcEtVZjNHTTM5eGsxTFNFc0x2YlNwb2kwTzNSVjdmQlJh?=
 =?utf-8?B?MExSczB1aUNSekxxWkJEaTI1S0lQMHdmK0hCK0dTejlrMVIvcENZalllcU9U?=
 =?utf-8?B?UkNodFlzbmQ4MVRqRmhWOTFtNmV0cnV4NFJmUXhnaTR0ajRwWm9YNHZkSFEw?=
 =?utf-8?B?a3BvKzhwUTRuZTNRck1uVzc1cU1tQ1lCdkFnenlFeldieDg5R3ZoVmhvbTQ3?=
 =?utf-8?B?dWxKT1VBZzRQbk1xMlNPL1hiT054YmdoM29NbUJaWC9mYkxSOHFlRmV0L1BT?=
 =?utf-8?B?bnZqSWZ1T3drdnViRDNWemFLTXNLU0k0djlKWk9qN1p0Y292NHlhcDQ0eHZq?=
 =?utf-8?B?YnptRlVnU1NKbGJWcmpWQ0lrY1k4RGg1bnM5dzQ0aVFNaXhiZVl3aW9wYXpC?=
 =?utf-8?B?QXpPUTZuTUloRTVDeTlqQnFJamZwMVBKTUhMTmlUTjFqOWxMMFNGZVQrVUYz?=
 =?utf-8?B?Q1FKRTVvUmRPK01halRrTUx2UEN3K3VlanIrY3RCL3ZFaWF1bVRQbDNwUjJW?=
 =?utf-8?Q?RZDnxRav0HY0+IrvEan6O+Lhv4/BiKg1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDJUdlFaTlpMY0RsMDFkUVdrbWRONEYweTRPNWt2UWM0b2s2MXh5Vml6bDls?=
 =?utf-8?B?OWRWM0k5VEdHTVpEalk3UWMwM1F1UENaWk4vZWxvbUZ2Ykxnb2JQME1JQnMz?=
 =?utf-8?B?eXVKaktGMmt2d3dHeHpsMEdhOVpMa1huRFBYSjZDWVgvYVp2aDB1b1g2czlP?=
 =?utf-8?B?RDNhQ2doa2cyN04xUUVIcnRBUkZWUWZOY3lTUStKMDN6cTdxT3dlckF1U3g0?=
 =?utf-8?B?dE00SHcvOGRJMkJESWtYM2ZEMmVpM3B5NitCTC9nb084Z2V1TjBnNGd2VVJN?=
 =?utf-8?B?S2xyeWdaWFhDZklmUlZMNzlVM1ZSeGpXNm5ISlRLcjNYL1MwSnBEVmYwYkU4?=
 =?utf-8?B?TlBHeWh2QTJkTUVxQkVuU2pVbUJrVzlkcDEzU2o4NXQrLzQzeDMxN29PU0p1?=
 =?utf-8?B?THRxVVVjRE9YdFpWTXd4b0x6Y0VvMHI2OXRWOHNVSnBXZm9lYkhJbDUwdm5C?=
 =?utf-8?B?aHViMVpOQ1BlMklMZDY4ZTYrMXpJbTk0SGlWQkkvbk95QXJrTUtLT0FqdkVw?=
 =?utf-8?B?NE5aTGszcWRxSlB2Y3k0ZGNsT1dRS3RIQ0gwMnNZc1JWc2hLUnkwaW1EbHN6?=
 =?utf-8?B?b1BiTkFsT1krUWg5bEsvTGNNSnNMckptWXJoQk85djZWL1pRdnVuaFQ1VVVr?=
 =?utf-8?B?dkQxcUQ2cW1FY3B2aEFESDhhSnUrdEhHMmI4SnBDZVNvbE5aTDE3VnpOWGxP?=
 =?utf-8?B?TURvUExDdlVyMm1ydXFWNTBCbmJMcU9wTDJpS0pZQ1EwRXFKZEhzMzRocFBk?=
 =?utf-8?B?QjU1NjZUK0V2VG5ybllqREI1Y1p5OU5UL1QyUWh2WkpNR1QwRWxpOUUvSnRU?=
 =?utf-8?B?WDhHTGQwUFpNQkgyaHEzdUFTaS9zZEkrcXJjbklUZ05qYXdOUXhBZHl2bGRn?=
 =?utf-8?B?dVdRSzFHSXd2NDJTTytiYnpFK3JGeHhYQXlCZjdVN0U1WmxVOEpNcklHdEtD?=
 =?utf-8?B?U2NUbGp6Q2VJcVhCY2FQL2JWREw5QUE2Ri9PdUlKbU4vT3lZbkl2Zi9yc1Fx?=
 =?utf-8?B?djZlUHV4M3ZlT0tiRDUrTWlxZjhzK3g1WjFPdmk0RFV6UysyQkpmT3d5L2Nl?=
 =?utf-8?B?Y2szaGJVZHpEQUNkOVdjWG0vY2ZKcmtUYlNqTnF6bEdPZXBiNjFKSGZ0ZmJP?=
 =?utf-8?B?SW1OVEdnU0d3ODNwUEF0L0p4NWdZbU9LTXUyemZaeGFyWUFOQ1ZoczdXNEY3?=
 =?utf-8?B?eXVxbHVEVWJ5aHlrdVpOZGpVVXJISE9UNElDWHcvVGFIbmd3M3pVVEluNVQ1?=
 =?utf-8?B?aFk0blE0NktlaFFrc2ovUWZPRlV6dGRXSklLQUhpL1hGZzd5bklVNTR2V2tx?=
 =?utf-8?B?WEQ0TTVhNm5NaXJSYzZMZ3JPZkZEemJEZEgvbkQ0OGtuVXkzYWhnejZySDha?=
 =?utf-8?B?NkJnaURYZjBuTEpiM09BWTl6SmVFSm1WRGJXZVZrSUZTalo4WVJNL1hHaFpj?=
 =?utf-8?B?NFNRYW9DQkd4YzREVm12U2FGSVZqa09XQ0xXL1crRFFwcnhMM2lHdU1DQUVo?=
 =?utf-8?B?UmJhOTU0SkY5Zzc0aFNqZHpYaU1lOG1MUGdSN05jMUVSQW1YZ09scDMwd25W?=
 =?utf-8?B?emZKdWlwb2s5cmlqU0VPTUtLOVdNa0NOOVVEM1V1RmxHUG1QY05yYVhMMkYr?=
 =?utf-8?B?ZHZvbDFCNHNHaXlRMGxpY1ZIS0ZvVmtENGdzU0JJa0Q0L05uNndkWmo2YXZi?=
 =?utf-8?B?N21vT09MbE1UaHh4MG1TWG9RNFY0UEJNUHdtSXJRVTJQMEVCNTg5RUdtNWhL?=
 =?utf-8?B?aGZCRkY0emFVZXpvUkY2Y09qUHVIU01Uc3VYMVdrQkJVa0kvUzczOUMyaFFC?=
 =?utf-8?B?SHpvdDF2NVNZTHpGbkMvRTIzNlNmZ0xhWm5uUkt1UDc0Wld6dWp4MTIvUG85?=
 =?utf-8?B?UHNYcVRsK05zSjRvSkJpWFNSbUY0MkxvYWFpSi9GdVhOUm50WXJlTUlPTm83?=
 =?utf-8?B?bGdvd2c5Mm9teEd5TVg1aEhmdWtwYnB3eG9wVGlIVXlNNEJtenpQblorSDlF?=
 =?utf-8?B?aWY0UUxtZlhKVDVhVnF5a3dYaEljOHAxSFlMaFVFRUhtTlNwLzdjNUNuMCtt?=
 =?utf-8?B?Tk11Q3JGczZpYXZvb1oyS3NPU3RpMVFRbnRNc0VIYnEzT254dUsyVnVLRmR1?=
 =?utf-8?B?b08xbS81Sjh1YTNLVTJxeWtMY1lFcVFzWkU1OXlqcEt6dUNuUURjSjdtYVJR?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5odVMEUraJPLZ8qzvcbGHqW/tNxMc+0R4hmWFE8XUi8oV/hC3CTN/HgrB3//i4zIhSYMkB433aWNpUEARvwj5GWLAskHQSmNmnKGEnljJxVIzPQSH5Jjy/IjWsGKoyLRX+1ND0HgU0Qvtz62w3FfSyZItkMemMe5/Y99V7Mw2SWDTMdgcwIkGS452XS8lmWn0pGDvBX6HnGyfnnD30+zYB3myzpZmF5V9EhogdQLkXdgEGFbw0pb7/KaWQjV8Vaymbbpi5qfsH0cMwSXWN2vFG9ysAfwAwrZZBAIufwjylKycAJmpNHgcsSN6UZdEw4NU6bbSkvfmYVa4ynaE4rF7ujcBfeHwKbCnlfb2lKaWnfZE41y57RKRilwybSrXKFT1ps6jTp/Str3mj/EcE60blr2FLAOe+zH5yoEzgouOG4YWY2lqPrt9+9XXW94ym4l6ASLjwtYu34MtLJsiT9PzLl3Im6VR2HIQ9hy3uU/nvEBWSerHpoABPzcdwzjwIqiORdYcELoHLguA9CQV2A5L75PEx8OOuVxi9knd48N1BrpQF/tvyStOuyW5SDuyl635GKzNmRk9/aqAuiY6UcHgxZtxJHkGecSW//O/onru9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9a18c3-2a0d-4dd7-75ad-08de1865ecff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:11:58.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wo8Rgh2LZMJXDbtyIagGFkeImz6nFuZKYS8K9sQMEAetLlOOKQ7p5EDKc0G6ZfUkdBXMkZJgakSP8PufpyEcEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510310092
X-Authority-Analysis: v=2.4 cv=S6jUAYsP c=1 sm=1 tr=0 ts=69048b72 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=lEI4WXXE7Z0PsA-3sEkA:9 a=QEXdDO2ut3YA:10
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: 989kxfJK5cHrNhZEcDzEMgCtIqXvZ06S
X-Proofpoint-GUID: 989kxfJK5cHrNhZEcDzEMgCtIqXvZ06S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4OSBTYWx0ZWRfX/ESvxfn4OYdS
 XaIVNVszLq8CYa5vCzufayn7bZyspVcgaZGLrPOo7l/pFJg0+GCjVc1y43BQXwz5ChLv5/iz+pd
 lBWUgbmTSJpteIlHqKCyqTDEt279G/dwi/bP/wE9hb/GkCMLttU3R669Ma2h+MQc1E6xDafvcUr
 PG3hcJ0q7JfJj3GomYgrz+Rdqnq3I9APqJXXAuu9KpIB8l7eoeASpfh1Tb3S+olfUdoyOQzcZj2
 aK3pHqon9KkKgdhii4jdZAdd9bfi2PCXa8Rsl4zxg/VPtzyFGNck1wDKALSCJrK3g5olztkspg7
 wW5FZn+ov2gvk9wE1Jv3aakQXQ+pQBh2R2pd0WWUmG+ENVBSKHUfxUQPY9w+s1cVMjm3bv2Ro4U
 YLQ4YM4AQiHlSdN2EX/plEAq+xESpA==

On 30/10/2025 13:58, Quentin Monnet wrote:
> 2025-10-29 11:22 UTC+0000 ~ Alan Maguire <alan.maguire@oracle.com>
>> On 29/10/2025 10:40, Quentin Monnet wrote:
>>> 2025-10-29 09:46 UTC+0000 ~ Alan Maguire <alan.maguire@oracle.com>
>>>> New libcrypto test verifies presence of openssl3 needed for BPF
>>>> signing; use that feature to conditionally compile signing-related
>>>> code so bpftool build will not break in the absence of libcrypto v3.
>>>
>>>
>>> Hi Alan, thanks for this work!
>>>
>>>
>>>>
>>>> Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
>>>> Suggested-by: Quentin Monnet <qmo@kernel.org>
>>>
>>>
>>> This is not exactly what I suggested, I mentioned adding such a feature
>>> check and printing a more user-friendly error message at build time if
>>> the dependency is missing, not leaving out the program signing feature.
>>>
>>> I've got reservations about the current approach: my concern is that
>>> people packaging bpftool may prefer to compile and ship it without
>>> program signing, if their build environment does not include the OpenSSL
>>> dependency. But it seems to me that it will be an important feature
>>> going forward, and that bpftool should ship with it.
>>>
>>> Regarding the OpenSSL v3 vs. older version concern (from the build
>>> failure report thread):
>>>
>>>> One issue here is that some distros package openssl v3 such that the
>>>> #include files are in /usr/include/openssl3 and libraries in
>>>> /usr/lib64/openssl3 so that older versions can co-exist. Maybe we could
>>>> figure out a feature test that handles that too?
>>>
>>> In that case, we should have a feature probe that gives us the right
>>> build parameters to ensure that v3, and not some older version, is
>>> picked when building bpftool? (We could imagine falling back to an older
>>> version, but I see v3.0 is now the oldest OpenSSL supported version so
>>> it's probably not worth it?)
>>>
>>
>> Actually there may be a simpler solution here; compilation at least
>> succeeds for openssl < 3 with the following change
>>
>> diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
>> index b34f74d210e9..f9b742f4bb10 100644
>> --- a/tools/bpf/bpftool/sign.c
>> +++ b/tools/bpf/bpftool/sign.c
>> @@ -28,6 +28,12 @@
>>
>>  #define OPEN_SSL_ERR_BUF_LEN 256
>>
>> +/* Use deprecated in 3.0 ERR_get_error_line_data for openssl < 3 */
>> +#if !defined(OPENSSL_VERSION_MAJOR) || (OPENSSL_VERSION_MAJOR < 3)
>> +#define ERR_get_error_all(file, line, func, data, flags) \
>> +       ERR_get_error_line_data(file, line, data, flags)
>> +#endif
>> +
>>  static void display_openssl_errors(int l)
>>  {
>>         char buf[OPEN_SSL_ERR_BUF_LEN];
>>
>>
>> Given that openssl is already a build requirement for the kernel, that
>> may well be enough to resolve this issue without feature tests etc.
>> However I can't speak to whether there are other issues with using
>> openssl v1 aside from compile-time problem this solves.
> 
> 
> I'm equally unfamiliar with the risks associated with older OpenSSL
> versions. Other than that, it sounds like a good solution to me. As
> Namhyung pointed out, bpftool's build affects other things like perf, or
> kernel build itself (for preloaded BPF iterators), so aligning
> requirements with the ones from the kernel would make sense. From
> Documentation/process/changes.rst I see that the minimal requirement for
> OpenSSL is v1.0.0, so your suggestion is probably acceptable?
>

Sounds good to me! Would be good to get clarification from KP if
opensslv1 is acceptable as I couldn't find any openssl versioning
specific discussion in the threads; changed the subject line
accordingly. KP is openssl v1 ok? FWIW the BPF fentry_fexit tests that
use signed lskels do pass when run using bpftool+openssl v1 for me:

$ sudo ./test_progs -vvv -t fentry_fexit
bpf_testmod.ko is already unloaded.
Loading bpf_testmod.ko...
Successfully loaded bpf_testmod.ko.
test_fentry_fexit:PASS:fentry_skel_load 0 nsec
test_fentry_fexit:PASS:fentry_skel_load 0 nsec
test_fentry_fexit:PASS:fexit_skel_load 0 nsec
test_fentry_fexit:PASS:fexit_skel_load 0 nsec
test_fentry_fexit:PASS:fentry_attach 0 nsec
test_fentry_fexit:PASS:fexit_attach 0 nsec
test_fentry_fexit:PASS:ipv6 test_run 0 nsec
test_fentry_fexit:PASS:ipv6 test retval 0 nsec
test_fentry_fexit:PASS:fentry result 0 nsec
test_fentry_fexit:PASS:fexit result 0 nsec
test_fentry_fexit:PASS:fentry result 0 nsec
test_fentry_fexit:PASS:fexit result 0 nsec
test_fentry_fexit:PASS:fentry result 0 nsec
test_fentry_fexit:PASS:fexit result 0 nsec
test_fentry_fexit:PASS:fentry result 0 nsec
test_fentry_fexit:PASS:fexit result 0 nsec
test_fentry_fexit:PASS:fentry result 0 nsec
test_fentry_fexit:PASS:fexit result 0 nsec
test_fentry_fexit:PASS:fentry result 0 nsec
test_fentry_fexit:PASS:fexit result 0 nsec
test_fentry_fexit:PASS:fentry result 0 nsec
test_fentry_fexit:PASS:fexit result 0 nsec
test_fentry_fexit:PASS:fentry result 0 nsec
test_fentry_fexit:PASS:fexit result 0 nsec
#108     fentry_fexit:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

$ ldd tools/sbin/bpftool
	linux-vdso.so.1 (0x00007f5497efc000)
	libelf.so.1 => /usr/lib64/libelf.so.1 (0x00007f5497800000)
	libz.so.1 => /usr/lib64/libz.so.1 (0x00007f5497400000)
	libcrypto.so.1.1 => /usr/lib64/libcrypto.so.1.1 (0x00007f5496e00000)
	^^^^^^^^^^^^^^
	openssl v1


