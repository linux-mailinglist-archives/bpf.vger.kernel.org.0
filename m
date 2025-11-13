Return-Path: <bpf+bounces-74422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62992C58ED1
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379B33B5958
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A03C366570;
	Thu, 13 Nov 2025 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eguudjPh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JzLPXyqT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119CB361DDE;
	Thu, 13 Nov 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051888; cv=fail; b=DgoVQA0TDSUIML6YjKaqZmsWQRyeXseLtAypulju8sTnssGhxVCnNCeYhbnxpbF7dCadj26oOfxhWl6sO0ufBIF2rmRjptDo0Qpzzuho2a/8dqc6TJfZZ1EJWfSH8yjPrJ3Y6X03p0gGBD8TgWSkZKGtBEXPXLbttqqWVdcLCNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051888; c=relaxed/simple;
	bh=bToI1tHWj52pIULTbS5688hBWl1PC/WcOPC54FTGyj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BMrXCETPa3QRLhF74dkkAgUZOlw1AfuXZS2/Fb4ft3bRkwypq2T768EiS3f4Vz70it/xpAyW7pXRpSln8a32UCCc7nZGnxHpOYmHL5bQdZliiDLj1nK7UulahWzPx9mGN7m4F/kCi9nYFmkXZMjrOYOL7HMNYrIuDvHDKJE8VpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eguudjPh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JzLPXyqT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9rcm012173;
	Thu, 13 Nov 2025 16:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qoalB/7kzIWMA7qzFmu9js8QDBzXnpzaOxwEaHIFmHw=; b=
	eguudjPhChrXg/W/1SEXyO2dDHmS7E0sDkoDJlo5WptvYpTT56hyNfuydyKUDmix
	W4suR0tereshF92pZlkl0pWbnRrkA0IdqNJUml+9pWm7N0tVARGHQtjzSX7PGj+F
	HX4cCUAEYYnWuX03RZDHdvXK2YLfhWNFOOqY2oTPdzV+ZHsK5W3OZ9MOvkKucTky
	Qx+ead3GvA8c0UBJaLWazdb+9BZKBfJzmIfan1GvurODjn4aJdNet+ZoC37eqvqt
	U0Tu0czf6hb4NHOnJxGFVD90wiUUGUCzFi2NdsLaWvew/ynvaxJ/LVOvG+/QmQuM
	BkTwp4F//lapXg20o/nnhA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acybqt7j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:37:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADFtAux000447;
	Thu, 13 Nov 2025 16:37:00 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vafwhyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:37:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUFWSDeKB82PMy9EDZ4siAb/9H1mljs4Je0xppczwd8blYoafRAbYzUjQv+MfJiJywRh7ivlKBgJXbU8VOm1bftLe0n9YLOAntUk1JogKkxVihG+IzH3TVn4Dpk3SFzAEjpc3tEB4QndRFkWGoVSUfpoiXcmrBWOER+vxnCsIreiM2I2WzTgF7/hDTcM4Fc7tlrhisvIWIOdeAMmhqhaGL5ejumGIOxqRIqM0/Iird6EV35MbTJtkuwTQBS9aOU+rqp1aPNyz10wW7wGvIEcthbH85/R4SXTapVyWrHdRzX7rkTGTQ2BPNzD3S2LVIfTyLDRwleqpZE/bE/yVdtyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoalB/7kzIWMA7qzFmu9js8QDBzXnpzaOxwEaHIFmHw=;
 b=Uk5s4vGW7oVsqkqWUxkTpnd373DHjZ7L58tgNq9DzpScWeZ7CzqD7ihRS1JDADHnGBXeYS8vbuE8vfvGf9OgEqrcvFRl+BolG6m/z8J7iCJ4pkL/tccgLUzdrBRLtkLAl2pVGwMN9VdOzBM1B+xXawsGQnQhBPyPaDLFpC8kUdpH1GtejDsWXQtd6W/2VCYhFmeanP/9x8LiYp3DSw5bC0mBI7qSipERqdzGY3bdaBZXGT27/mnwyvXz9l3xtFCkCadakXugx8U6H6I+HdVW7i7h54+dzNp+2OjSDAIvi6EtPy4NZOT6sRublYowjx+FOXGdDmCBlYfKe0ZFB0h5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoalB/7kzIWMA7qzFmu9js8QDBzXnpzaOxwEaHIFmHw=;
 b=JzLPXyqTQoS4AyaJ6D4vYgJh3I11+Q9pHLCUaxSFZr2YNHwVc7U8gFNjbu9sES8LbVYWB70/d4uwlREOSklCLijGHhSceKjTWH5ZkecMcLWBPrgw6gfvfE8ADE9GqB90Vk1RHO4ff0tjZAIK0ul5p1vIH3blYsNlKdyU71QBU7E=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB6433.namprd10.prod.outlook.com (2603:10b6:510:21c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 16:36:57 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:36:57 +0000
Message-ID: <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com>
Date: Thu, 13 Nov 2025 16:36:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 0/3] btf_encoder: refactor emission of BTF
 funcs
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        acme@kernel.org, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        kernel-team@meta.com
References: <20251106012835.260373-1-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20251106012835.260373-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc85e18-2d75-4b78-0d2f-08de22d2dc3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUJtRzF1RDNrVjNaUTEvdkRGbGFaUW9hdW1XclZEYkFMNW84U2tuSVBRR0dG?=
 =?utf-8?B?RVVOY1pOcG9JdTJ1WjRGSCtpd3g3UEEyaXJlTmZNcnlaaSs0czF3bElpaDhy?=
 =?utf-8?B?S3BzSHVsYmJRV05HQ2RGR3ZkeGk2SENVTld6RnV5Z3B2azlxUFpHZXFWOENk?=
 =?utf-8?B?SHpXaVVjeFFNUGFxbjBMTzF1U3c4QkFMb3VmU2lIdjlLd2F1TWtTelJaZnR0?=
 =?utf-8?B?enlad3ZoVncwK2ZKaXBXdEwzcWVsbThZQkJoZmkxd01ORU01anZnRGdKak1Q?=
 =?utf-8?B?ZDVZRFNmdGJQTlBWTnJkOFZ6UFNGVUhTQWI0WCsxd3pYZ2Jpd3QwMFpReGxZ?=
 =?utf-8?B?SzUvdDhHSkFJdFR1RlBRYnRMaHRZN2F1cVBzMnBrcVNrL05tSTV3NnlaZFJB?=
 =?utf-8?B?NVhUMzlvUUNIVU0zWlBGOHE3TVR6MXZTelg5a0hlUEdIMFVSYXRBMHhEeDR0?=
 =?utf-8?B?US8wYkJBWVEwRzBwdU9Oa3NudU9RdnNndlJCSTVQL0dDWXFrRVJ6U1piZW5Y?=
 =?utf-8?B?VDNQUkt0SE9sSTczaTQ5RHBsaEN4QU5NNkVyOTFnQm1HYXlVTEpzR25iWlNU?=
 =?utf-8?B?TEZERmQ2alNrSVVhSnFRU3VBOTZwbkpxbWVEdk0xUFlTbXBJYjJadmRrTis4?=
 =?utf-8?B?UHJaVUJQcmx3U3FFS3c3a1ZPN1dnMXZQNmdaWTNXanQwZkR2cjZqZ2lKVUhh?=
 =?utf-8?B?Y2dZTzRYbkJwYzdkL0hvVENORmg2UnM4dU5SZVQ0azRoLzZsbkRrenNKRGw1?=
 =?utf-8?B?ZkdRenJtZWdZQTJQbVdXaG5CcklsMkFDODFaelM4eHNFT2tuKytWd3piOW1N?=
 =?utf-8?B?cjdkT2R0L0FraHB4T2pjVXc0ZHEvS20zUDV0T2h6ZWsrWG94dnBLRnFrQVov?=
 =?utf-8?B?UldrUVZpRVUwRkd6dTRydzV6NmhsYmVjNTliMHQyTVg0bFVVaGR5aDMrMkkv?=
 =?utf-8?B?cU9nWEkreHNFYlB1WGw5aXBhT3IwekJWa0ZFSkxHMGFGVmx1SUVZYmhKemtF?=
 =?utf-8?B?eXhnUStsV2Vua0dLWWtRM21ROHlScnY4ajIzSkI1bGUvcnlsM2VSalcvZUlF?=
 =?utf-8?B?Sm5BRlpvSEU4ZTVvN2YrY1JWaXZZNXFtaW5vYTNiajFrK1Yrd3ZzcWt2UUY2?=
 =?utf-8?B?SDh3TmsyMGN2Ulc2R3RwbG1XMmtTRXNmaHJxdC8yVURTWEVlUzNDS2ZoTXZa?=
 =?utf-8?B?bFRlSEFmUXJldEFSeHdmem02MUI2MElxQmd1dVd1dTNRNXY1ZzFHUmVWK094?=
 =?utf-8?B?d2pkTUZmWitnaTQ3azdsVEo5elpLMTVralM3MEdCdGwwaEFmVWI5MmxsMkFs?=
 =?utf-8?B?RjJZeDJCRU9SWUVURW15N0U4NTZOK1p3OWpwWG1JOFlkUVJqbFdHRFVjR05V?=
 =?utf-8?B?YzQrSno1RU1HUmhPOU0zS2V6L0RzR3VlR3FzRWwxQnRsbzZBQ1RBOWJyNzRJ?=
 =?utf-8?B?ZXhma1ZmL2RJRzI3L0dUR2VqWmR6anZZdCthZUptdUZIMDdSQldqbFV4WlVB?=
 =?utf-8?B?MXlYZVIxRXRmWWR0S3pDdjcxdU5OTFRFdWtnNU9xelh3TGw4ZndTa3l0ZXpM?=
 =?utf-8?B?ckpQNlM5aFpCOTc4dVNjUGljMEJ3dnpOUTY1Wk1RNVlEbTEzTGxRRmJPN2I5?=
 =?utf-8?B?NWV1bjl0SVRSV0ZUR1BTSGpoZ1l0NUtyellya0lOS1U1MnBsdExrRGFDNS9C?=
 =?utf-8?B?amJLenM3YUMrZFZBV3dXVUJNNXhDdVF6eis5dnJpZWVLRXZkMTg0eXN4YlVC?=
 =?utf-8?B?RU04a05YNlVyeEhvUVd6MkUxbEo2Q0x3NHo1YWJjam1ESWhkTjhrZUNtN3BW?=
 =?utf-8?B?MHdVa1NQZXJhdE00dzBoaVZLeEgzRGxvVi9DbEdpSHRBNmk1NEViSEtlNkNG?=
 =?utf-8?B?bWFHVEZHa0hSenlad28valRPMFo5Qmk5QnlUWnVSbUFZYkVqMEIzRUJyYUxM?=
 =?utf-8?B?YlFrVmVyZHVDSUpFQnRzUHJmcmVsWU9WRUtWalN3blY5aE0vWGNIeFVzeGxp?=
 =?utf-8?B?ZUxZeFlobTNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnRubjBLQnplTEE0eit5Q1Y2NTJHUlVLNDZNWnU0N0VKOERsSU9lUmZwRWVn?=
 =?utf-8?B?a3g2RVpNSkcydWRMZ0krcllBbkluc2xtQi9rN0g2NS9QNU4yMm4xWjNZWStv?=
 =?utf-8?B?Rm91czlpaXB0dTZEckRQL1NKS0tBM1FaVWFiS3dBdTZhOFd3WEJUNDY2SGxP?=
 =?utf-8?B?VktMV2wyazJUOWt2MUNxZ3BlQno3djAzVnhUVlFCbklTWWJ4OE1sQVMzWlp6?=
 =?utf-8?B?ZXNPZldsL3FaQ2gxdVVMdjloUy9BeVUwQVUzV3FJVC9qRmovVncwU0NpSTlT?=
 =?utf-8?B?MXA0SzhxVEhxL3BmNC8xeUl2eW1ra1JnNEYxUEhaVmU5Tk1nR2RHZFdWWkE4?=
 =?utf-8?B?K1lzSFI0NjE0L3hrV2hLdUIxQ1Y3QmVLU1RZb3NNK2VTZDcvaHVHOWxLU0Fr?=
 =?utf-8?B?V3plalhrOEpKQ2h1QWxKUllUWCtSOUVGV1ZEcWNPT0VLVTRpR0ZpeGlWSVBa?=
 =?utf-8?B?bENjN3dsSWw5Z0dkZGFwSmpidTZYV1JvK1hyUHNIaEYrSFpIRVI3K0pqVTFw?=
 =?utf-8?B?ZnVUamtCNHlqR0tWOGx5WGEvZ1ZyM1RzbkU5bUVuNTVPQlVaVmVXNkxTRGtM?=
 =?utf-8?B?V0hlNmJtVGo3NXNrUE5DSGowRm40WWwyMHhWcW5jRy9Sa2c4Z3RhaFhKUERU?=
 =?utf-8?B?TEVzc2x0TnFDbnFUQUc3QzM4Q2xXR2dSUmNEbmZyQVNWSFhCTGIwaGdhR0Rx?=
 =?utf-8?B?TFRnQmtCK2VUZzBBbE8zenlQZ2RIYUpqZnFnVWNxalRnY1F3blZGclowR1A5?=
 =?utf-8?B?SytKZ0xpYXlyUTR0SmM3UkNpaVZQK2ExQzZTY21RT1lWSnpzR0tPdGJiSWw3?=
 =?utf-8?B?ZWFORVgyam5FeDk1OC83MTBDU0MvMStBQkJHMlVOY0xXaVJzaGNZSVJHZW91?=
 =?utf-8?B?dVAwMEJ3blVkWTEwWG1DVkJhdHhKVVp0QmUrUnRUMUtPdWlZSjA0UWlWbTc0?=
 =?utf-8?B?VEpVUHFTSzZ1WThTTnhVdDRrVXRXSXh4QitEL3hsbS9CeTEyKzR2ekkvOHVo?=
 =?utf-8?B?Z2hCTmlvYUZpa0NYV0w5bE4vNHZTdDFpSmZFazlUT05nME1IcFlNQVQzWUdM?=
 =?utf-8?B?NHhtOHgyZjBoK0Yrdk1RSURjZEg5N0FvaTZ2NFU2VXh5V1hZVzBjY2NCZThW?=
 =?utf-8?B?YStCRitMVjZUSlBmcW5pODFSb1QydDNpelhmUlgzaDlhelZYL0R1ZkNHYzBm?=
 =?utf-8?B?U1gvRHZ5Sm5VRjIwN0paSy9ITGZiU24zVGdhSUxncG9rRlhhTm5lTUFlcjdX?=
 =?utf-8?B?R3VUK3FDYVpmM0ZUdUtMRVdZdlVSSHRDMG9lazJLQU5UWGd1WVB6Yld4RUN1?=
 =?utf-8?B?QWxnTHJlQ1o1RFhMaXFuL2s5NlgwbDFsWnVLWk5idmNQb2srdUc2c2hJNVZy?=
 =?utf-8?B?bklJOTJtWXJubncrVERYalBWZkJkM3k5WkhkOFRId2crVkhHU0thcCtrT1hF?=
 =?utf-8?B?SHdPb1JaMGVUSHkxWk9wV2FuY3NkTE9tV3B1VFVNRlJ1bWc3VWxGT3FkNGdY?=
 =?utf-8?B?N3pDVW9NYlhGY0JGODBHek5CaHFLN0tiZXBpRSswMG1aeVFXcythRnhJWSt5?=
 =?utf-8?B?elpzRHZLWnZlUmNSbGREaG5RcW5sU0QxdFJHOVdTYk5oaFNnaDNia0FuQ3F6?=
 =?utf-8?B?TGtETlExVkZidFF1bTkwS3ErWG1hOStOLzFaQm4yZ0Jnb1BsYmE1NVJLd1FE?=
 =?utf-8?B?c1hQbTh2NW1zcUFGTUM5b0VSNVV0Q1Vmd01BRTd6b0dDMSszU1JzZGhJeVc1?=
 =?utf-8?B?QnArMW5LS3Y4TzBDZ2sxZzl4N2VFQUd1bnUrZ245akZGZlpYWVVjVGd3SVB0?=
 =?utf-8?B?aVcxWnY3Vmk0SDBCS1FUZlZBaSs3MjVma2RLTFlGelZzaHQweFdLZHFCTy9y?=
 =?utf-8?B?SitNdTRDUEhnYmYzZFlDRVM5YSt6QjMyQ2NudFM4RllDNDlGUTErckpsM3Zn?=
 =?utf-8?B?Q2VoSVFFMS9vQVZBUkw4Z0pIdEFRK0pTU3N1RkRrVVEySEppQ3RQbERMNW5w?=
 =?utf-8?B?c3J6dHRRU25SSTB3N2JnN3dkNGNvdEp1Wk9kZ2ZPWTVwaEovbjlhdWM4Z2F0?=
 =?utf-8?B?Ly82dlJFQmJ1b3BsV0l5dCtDU1JVQWVSMjNwWTFqZzZHSHJIeXg1RVdodHBQ?=
 =?utf-8?B?S1YwbXI1SWs1T0JiS0hZbndmUTIyTUFZVHhHQ01PY05ENjJhZTkwZk1mdEVR?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Su8niVZBQWj4whjKyzG4CJmOELaE+DD15gXAZY86QANQlwSKRmFrX41yhWjKBcIO6gzbRT2UEPOyw5zGyFdDx3YXBwbSR13+mxDK+85PEXHC3/M4t/cm0L5G0ls7sNqXd9t4c2bNHAIw8Qvl/X2YWLvtOeKz4xSHp1wPWnKYVZS4+/z1IwOR7b+fa6TZwMWCVByH3G1kgBBY/drUt3K3aR2QMyjF+YtAxqvx61S8iQM3AH0Sj71eSnrsTjrnltEDmXl/hXFpsrrNMinj/JmyMdEBSey0O/42yehk33tWmyapymCbL3v/4KkfP/04Y68qmub3nVLOlOjFldkm4Y8aLTR66331XUkebkogMPCsYNA+NuK5PCK9KQJNKEDr/7u+USpxbQEVLNXHq9LdLwJRXXmL+njfWx2kya5SLzTG2+S7Id6FRLZlZSi0mflY0b5Z3RTEmLfNuq4zrg4YarVmwuoHRga5MPTWhMKsmWdenSFsBHrjwrbFdI2EzUYdsLwWFyl3Nxq86lidydUD4zUUZPfW2GluClXN2a51dbg5Zo5286PYml/yuUX/lS2w8rWI3Hrs3hC5Xd1jO9/tKq+Go5PtSjTtH1wjC6YTRKvK+qo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc85e18-2d75-4b78-0d2f-08de22d2dc3b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:36:57.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPtyMxRZntlHlo2loTjR67EBOR3m8IbPKDTdCTg665K2+cZlcAGzB+3lFFqQpb9tzAYjn/TexnmXEd+zbBH2Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=840 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130128
X-Proofpoint-GUID: 6I9tgBn4HVUC6vBd7hEflFNjg_-VrkAm
X-Proofpoint-ORIG-GUID: 6I9tgBn4HVUC6vBd7hEflFNjg_-VrkAm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0NyBTYWx0ZWRfX7uObG9UN2GMb
 BnHU7YnH+kzWcukZgLowZOfPMrXhnGSZPytytU8k44e7Rr5uu97tSnnlPgJ1WbOHPhMKYcF9AwS
 d+kPe4SAxOBUy2vkcixM/TV6MGHMFvSxo4qpvewn4uGt/B5xaqV26X3BcSCHrLXavUx7dZOE5li
 Qde6vZAi/z952oLEfc+osy1a9tsiI51g2x/Izwxy5X1RBGLV5RA3sR7NaUYdwvYwQOz2YkjowTb
 r1sg18tioC61TYVN5RbPqUvpVOqP0vFIIY0oyRkBoa9LUQB1gl+sc17rWWS2ZrSWFviiv7xr6ln
 FmU8EGhsSRFCqcydLLz+K++srh1nCPDJ/668lyjW0C3cMqirMqJMiuQdfgTaa7qUS0CKus9Rj2x
 E6kCXvb452yXRTLhPqygASPXCX6Kc/Iv0R7NoLoGiTuVPOb5Zjs=
X-Authority-Analysis: v=2.4 cv=X7hf6WTe c=1 sm=1 tr=0 ts=6916092d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=YbacuVO6NpnqvNI4pVAA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12098

On 06/11/2025 01:28, Ihor Solodrai wrote:
> This series refactors a few functions that handle how BTF functions
> are emitted.
> 
> v3->v4: Error handling nit from Eduard
> v2->v3: Add patch removing encoder from btf_encoder_func_state
> 
> v3: https://lore.kernel.org/dwarves/20251105185926.296539-1-ihor.solodrai@linux.dev/
> v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodrai@linux.dev/
> v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodrai@linux.dev/
>

series applied to the next branch of
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Thank you!

> Ihor Solodrai (3):
>   btf_encoder: Remove encoder pointer from btf_encoder_func_state
>   btf_encoder: Refactor btf_encoder__add_func_proto
>   btf_encoder: Factor out BPF kfunc emission
> 
>  btf_encoder.c | 206 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 119 insertions(+), 87 deletions(-)
> 


