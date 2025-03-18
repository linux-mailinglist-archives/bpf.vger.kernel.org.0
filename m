Return-Path: <bpf+bounces-54341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F630A67D23
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 20:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606CC3BC264
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 19:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486981DDC16;
	Tue, 18 Mar 2025 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WkqS98LH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NUQbJaP5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158531A23B7
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742326241; cv=fail; b=pil1uu5XmuXIaaNE+ZgiQAnV9Iqx85s06iUMnlCpQY4/JAmzlt0/0MkrNoGPGclse5Q9ggO/uf9w8ByqbE0kHXTEda+yEeHcwWe0Lf6qzu+3hkdzX6bA0W76ohiS4V15o4JPDMnXpbE2vHOm2fW79XBbmZROLDx+dkeE1b+Vprs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742326241; c=relaxed/simple;
	bh=+/2quc1x7PaSpnGAHwxRINiAnutMI0UrqpQBY+YGPO0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=imgJJxejX2uALrpsXayEeZO7U7wwVb7YUa8+31GJHkpnJj9QiK4KOEURA6euzhVrVCiWWN17emP5ZutRtJh7aYVURrF8QgTUBFfmoUcTmEqKglhgEPp7euONZG96e4qRS04SUESK0QZ78HK9/trhFcMZnZwHYckWTcgiQas6MYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WkqS98LH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NUQbJaP5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IJMmLK021626;
	Tue, 18 Mar 2025 19:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=g3fRVeWeTvG2A9lvxPA+VzSuYBgj2KxAdkJVcpfXptc=; b=
	WkqS98LHomqWQGn8zJ2U8iqwdp4dRlFyN9WhA3nQpqVBfoTT4Vncp8ywjUBu8Okv
	36RZnG4a+NKb7Q3+w+dxzJ3HAsyTpM+KJqnx2b4QZppW4fhslU28OIVLqrvkKSgZ
	l7Za6I9YSCTZ7eWPYy2HMSNi+YHlYzVJQE118eKZBhWJbHJ/WIWOIYdpXhINcMVN
	WCUT73jvEkJr/nzcI08EWa8GhlHbOEFXK1V5SD0U+nFiVFPBZ2TLODJkoi6rBIEE
	mPZTw4qvt7HrFYGhzFk4X6BjdVkfpBP248rvyDbovE19S5y68LQcDLZ4PmQQAkww
	6WSZBxAKqlslYUARDUCwow==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8dvvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 19:30:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52IIIlux022429;
	Tue, 18 Mar 2025 19:30:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxeftxmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 19:30:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym/wlwgplmz8oWNrmgs1LQkENDUWEYBaVRCstRr7g3sHMBw8yjU5nv8fio1YoPvoLeyEwamLfcy32VdK4rknya50FehcA0SSbx1aw0mVuXPH5mMWQxgeocJ6M2JEgS6o5qB8IaL3l5kmGHq2596/rTQDhAHXM3BDsNH4Di6Q9VjL9v63rM4KIpu9svRwJYIed6m4s6wP5kO7qNMxhPIjo8tUPvmQzUV2BV8bxWO35QDSVvqj1xD5NLgI/LqSJntszUyDMtedY9uVthOrMjG+iWSu4jdoUcJ5c/AEZjsJcL0Dt5t3ou7a5rzyKR3myQaz+tzoHOP2c46+zK3Qw9VOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3fRVeWeTvG2A9lvxPA+VzSuYBgj2KxAdkJVcpfXptc=;
 b=pEe2Z/AYwmRwpzX9LE740/tmfEQ4/5ghsmJ/PBzBT9cgum73/ix/BMKtJUkYqIdARRaSWLEYCsuJfE2mAWVd9lmEYlzzPkNVoYKX9+bOK10l8Az7poCcZn8wwcf6JXmPnKOmMBgTIxdT20dJTWO8JOqyRzSmJ4w9/ueEWw9p9C1vtK2r0RkqvUE3RuWchPVDH45y58YNH5+29a2QenEFdbNUqDQpWXzBb5y8cCzd/LwcK1Ii8nT4RPudubCW7ovL22UnYqva/Ly7pQ61IiCAn+uPX2lSFNYhqqryPklzV+I/SzeFxaE/XpLw3kgLmaw7wyjUx2+u1exB7A8pdE+oKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3fRVeWeTvG2A9lvxPA+VzSuYBgj2KxAdkJVcpfXptc=;
 b=NUQbJaP5iXCDViI+xyCCbU3yualxU8lYruN67JpRqKhseu/axpaUl8rj9GpynuruOpIjgs20wg2QVIrWU+mt92ZP6y6OVwBT/JBmYSKL+VGVMr9Ah1/p0Z5GZR2UDrpkNxvBrj4QnJJF8r2zEzXRkCovpU77sOM4AVNx1wzlyds=
Received: from IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19)
 by DM4PR10MB6256.namprd10.prod.outlook.com (2603:10b6:8:b5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 19:30:14 +0000
Received: from IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::2a07:dfe3:d6e0:abdb]) by IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::2a07:dfe3:d6e0:abdb%6]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 19:30:14 +0000
Message-ID: <efdf240d-9480-4bd7-b24f-9f9e709d41e3@oracle.com>
Date: Tue, 18 Mar 2025 12:30:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 04/14] bpf: add support for an extended JA
 instruction
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
 <20250318143318.656785-5-aspsk@isovalent.com>
 <f25a61cc-e2aa-42f0-9173-d4ab3b5a91b5@oracle.com>
 <Z9nIfsNWg++0B9zf@mail.gmail.com>
Content-Language: en-US
From: David Faust <david.faust@oracle.com>
In-Reply-To: <Z9nIfsNWg++0B9zf@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To IA0PR10MB7622.namprd10.prod.outlook.com
 (2603:10b6:208:483::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7622:EE_|DM4PR10MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc39501-df8f-4d36-6bb6-08dd66534e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUNVdFBXRmpwZW1IbXdnTkg2a1RuQ3pwc2crMHJMSExJcUg5RFZEWVF4QnRT?=
 =?utf-8?B?aHdtVGhESDB2Z0RhSG1nN3NRTFB0OUV5bTMzeS8zTHhueHRwbURka2tBbC9P?=
 =?utf-8?B?VnVrK2NtRUZ2bXMvMzZEblZXSnd3VzB1bmdFd1hjQWN1SElzdjZRc3puRXJw?=
 =?utf-8?B?eDF2U3grTS9UY1d0N05XZ2FMRVgvdWNGK0xlZ25COExadmRaQzFsZGo2dVVE?=
 =?utf-8?B?dGs0eFVROG53TWRVMlNtY3kvVUROUm0rKzZab2tmMktnUEdLcnRra3lnazdh?=
 =?utf-8?B?ZWROb1luWHlsNjJvTFFHVHRFZWhyMlJvM2VwN2M5VDR4cVdxcnlyQU92S1p2?=
 =?utf-8?B?ZFhhdFc5QlZYR3RqVTg3VFJ3b29mMzBuaUJ4MFNiSjlNSEkzTi9OT3pVWmN4?=
 =?utf-8?B?QWQ2YmlyU0p0NnVjZEw0UUlBMVdlbnRDRUpTcDBKblFlTFFwOEdGcHdhNzQ4?=
 =?utf-8?B?dVM4K04weWRQeWNlQ0x5OGV6Tis2SkRLVVNsUW1ZNWQzd3dkUlZPTXZYeUF1?=
 =?utf-8?B?WlROeG5pQTdzSUxFNnVjODZiRWxFN0xOVzA4c2tCL2IwYWkwL1dzTkcyS3dp?=
 =?utf-8?B?UklDK0RxWStlajd4R0orVk5BRHpteWlFbmVDaWlrTVZnQ3UxZnlSQ0NrempL?=
 =?utf-8?B?UUR6cXdyN083U3A2Z1NlYjFBSGtiNkpZYlpxV1hqcVRQdURDVHIzTnlVL0pi?=
 =?utf-8?B?d1p6Z1VkaHR5NjBvWWNJUmFDbnBXeVhzOGdEK1BIeEw3U1JjSFFmNDExUEk4?=
 =?utf-8?B?QW8rVWRWekpSeXYzVkwxZEtXaUlMQ1dlNnFNa0lzQUpTejBsLzBTRm1yR1lL?=
 =?utf-8?B?QytueWxmOUErRXE1MEpkY3E2bkozT01OWWNTNkY5YjJZUi9kTHBvdnhLK3V0?=
 =?utf-8?B?YzRYb09XT2tteXNEREdRVDVsd280d1puUDZKTm10blRQamhudEg3NnNHSHJW?=
 =?utf-8?B?RklTTVJFL0NMVHlpemtqeGpoMFZCRk9IMHVLM2hvTXVBZ2luOXliMU9Za3Vy?=
 =?utf-8?B?aXB6R2gwNkk2NzRMQTJaN0NKN0lRSFQ4M3pSMEVidVJ4c3hqbkR0ZVByUEs0?=
 =?utf-8?B?ZzNUcGcxM3ZyRkxmbFZ1VzVQWm5Hb0x1QnE0akY2L1RyWG1IQnB1aFY5Z3pw?=
 =?utf-8?B?aGpKWWxUeVpTK1c2U0ZRYmdLT2xlTUVvUS9pUk9YRDAwSXJmbHVpaGJ3OVFl?=
 =?utf-8?B?UzArNHVjQVhGbzhtZzIrc1ZYcUg5cklmUEZqNHVTVVI3aFo2VFRjN3BYUi9P?=
 =?utf-8?B?WHUvQi9ZaW5TZG9LU1p2bzhQekZNMHZSODVJcHU3VitDMG84VVlCVC90YkNO?=
 =?utf-8?B?UDkxUGNWTEY0N0dYVGhRU1R0MDQzWW1xa256aldwbmRUeHVNdmxMZGdMM0ln?=
 =?utf-8?B?ckRzYUlqQUNzV1ZXSi8yNzZHTnBUZk1RR1AwS2xneldLMkIyUzIvRG0rOUxG?=
 =?utf-8?B?WUtOeUYwMWZYNEFLeUQvL0ZPcTVoMVpxdkNucVJOWjgyUHRLV1lxM21NeE9I?=
 =?utf-8?B?Tko4aTIxMk50VDhLYldheVRpZFFwSzEyTTVDVXdlcmZ6SXNlK2JjQ01IbkxZ?=
 =?utf-8?B?bUZKaHlFOFludUJvbFRjTFcxVmh2VkkrYzFYM3VTRkExSG56aUxXdHBQVzEv?=
 =?utf-8?B?WGhJa3BuMFFURkp1SDBIRmtSdWpQMUhXcXNBVHUxNmZCRmdVa250YnIvWURL?=
 =?utf-8?B?cFdNTk5VMjBjK2VIMmVDL0duaVBac3dnYVBXSG43TEV2MjZLMjlRK3JnOXRL?=
 =?utf-8?B?RDNVaVN5OWZoM2MwWnlIdHNUWVhsaVJqeGdjcXpjckx2anRsWUwyb1R2TVRO?=
 =?utf-8?B?eDBwUVpwdk1sN2Q2ME5nRmJDTXR4ZnA0N053bjQxb25PdG5zNEpDcnVLL0Vu?=
 =?utf-8?Q?836G4GJsHw5V6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzhYNzhrQk5UZG4yVTR4LzZ4NUs5aXZGcDVwWjVnTjNkRTB1Q0pDcVVZN1JZ?=
 =?utf-8?B?MG55emx6blY5SmVjVC9RMmtzaDRjNGtjY3hkOTN2RUVMSlBiM1ZSR0tObjBh?=
 =?utf-8?B?WE9DZ3A5RUtHcXFmMUp3RWExcVU1b3JxN3J3NFdDN3NqaDJsRkYzQjYvZHB5?=
 =?utf-8?B?R1JHUS96SXdaOG0weVd2YWc5UElHa0xQUWFZaEtMeTBrTC9FUFlKZWJMZ1FD?=
 =?utf-8?B?Sml4MkhZVjg3am1aNGFuYUdoSExIVnFHc2hwelV4Y0ZVUzF1NTFKanQ5T3dH?=
 =?utf-8?B?dWNPZnQrbHduelh1bUozSmZOQXJVRnY1TEpOUitTa25OQTBvMExNRWFNazNG?=
 =?utf-8?B?TzVPVUE0bkd3ck5KcnNGUC8reUtxT1NOVnl2WUJNVHd5SEtFc2xnWkI1blg5?=
 =?utf-8?B?Wm96VnZMRmJyY3JTSEx4b0t5MnZoVGl4cWlIbDBrWWVDOERSelJ4SkZFWU9Q?=
 =?utf-8?B?MUlFOGhZNUVzcTY2TlkzcGs1Q1E5NkVkK1pzSE1xQ3ZoM01TdHYzaThjbmFZ?=
 =?utf-8?B?dnJXcVZHWTJKTkhPKzRudjJPY2tJV1dac3hmMnA0QlgrQjRJQWRIK3QrbXcy?=
 =?utf-8?B?dm5FUFJZVmxPVkxDbHRLeVl5a0NQME5xbE1PbU5sYnAxemxac2tQZjZEQ1dh?=
 =?utf-8?B?VnBqS0wxR0c4aGo3MktnbGFvT29HRTZVbDlVcjQwRDJBRkxyNDJ5TW8wZENy?=
 =?utf-8?B?aVFFeGJQQ0dGbTVuVjdOY3MzQ3FRWGhqNCt3MkVscG1vYnI5WEdxODhmT0tY?=
 =?utf-8?B?WTdBNm9oMnFlMkQ3T3U5V0ZWeU5wdnNxNUlZa0hHT3FaK1BYWFpncHdGNzdB?=
 =?utf-8?B?b1dUOTBJeldoMEZNMG8zR21FNEhRUFBLeDJUc1ZwTGJrcHMxUjRUUE1RR2hh?=
 =?utf-8?B?czFBVytVbzRQZzNPZzJMSW1Ta1pvRStwREdRNzE4LzgreGg0T3dqOFBIUDY3?=
 =?utf-8?B?R2NBNGt5Z0pkWllINnBpdldud3R3UjB3UXUvTWZucFhkWkpwcmZVZWR2blgz?=
 =?utf-8?B?bS9vait1WVRRVXcrYlFBd2RXV01LQ0pYMjJMUnZiNzhnZU82aURxRUltRnR0?=
 =?utf-8?B?VXBFLzNjb25ncE5MajZSVkRadG8rVlBuTldaRGRESFdJMVlWV0VjSldFMU5h?=
 =?utf-8?B?akxwODREdnBrb3pqcUxnbFJVRXJvUHV2RkdvMENpY3BOZGJqK0dKOWovOVRK?=
 =?utf-8?B?c1E1VE51eU1yKzdETTBhNHVqTG9jZkNPRHBjL3ZKbjJSZ1dHaEhWbkxmcXNi?=
 =?utf-8?B?eE5ub3ZUdlM5NUdtZGlEMFAvbTJmVzVvS3ZoU293eUJiV0lmTHpJZC9ObUVG?=
 =?utf-8?B?VDY1R3dWNGdBb05ZdkNRVXFvbk1CRXpoY1d4YU80MnAvQzRPVnNBVWhINElX?=
 =?utf-8?B?N2s5OTF3ckVPOVUyZmFMNms3MFBQMnZ0dEN2NlBqc29PNzlheDlOUFQvV0dP?=
 =?utf-8?B?VENJZHplck5vRmtFQllIL3lFNHpJdFVQaWNReGVER2NNRXo4ci9ZWEhKS0JE?=
 =?utf-8?B?WmoxZU9LQW5kR3Blc1Y3ci9Ed2luOVNZclRzYnNjQ3Nqd01YL2FYbFhrOUlv?=
 =?utf-8?B?dFBFcnpJNDRJYmlaVStIQk9SMlJLRG8wTlYwZ01zQmdFVS9RaDg5UHhmY0FY?=
 =?utf-8?B?OC9iWFZGWllYRFhoVEp2b3VTNzkvd0IwQnRRY25RdnpkenhMaTkvbUxKdVRn?=
 =?utf-8?B?cUo2ejYvME8xQWJnT1lodU90MDJBN3JNRDFKbytiKzFEM1hsb3dBQ1pZVDBZ?=
 =?utf-8?B?eTBPTHBOVkVqblRacFQ5clVwYmVmbzB3YnN0UmdoWHR0K0cyZ3NUT2NwR3BY?=
 =?utf-8?B?N1JVbGF3YTlEcFRHaXVmUnJqUythblNBNlpzdjNHa0s4elVUeGsyTTRxSWdl?=
 =?utf-8?B?SmwwM2RUcVB4ZEZOSE5kTzVkOFFqcHBMQnhxOGg2bTJOMkdYUjRmSWZsbDd1?=
 =?utf-8?B?ck55UFZiUzVjU092SXI0ZlcwQks2TmRxd29NdzRqc3VYS25weHhaK2p2RkdU?=
 =?utf-8?B?Y1dKckN3UUZIMXpGekdlaXRpd3J0aTdUVDl5VzNxR0dSM2s3UVdCYVU3bzFx?=
 =?utf-8?B?Z3hjNVF3ZDB1RFpHRDU2bXlESEphQjlxT2tFRGRoNmI1N3IxNGFWS1NKRFlR?=
 =?utf-8?Q?1/6CGbnOOthHMajHDLMBG22Kc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+HPszcJu5//yq7ZFj7n6ryiwOG46OSKrBrHvIaA3nNBbfZuEsrC+rIePcButpcSfIHkLIreHQk4Xs0CfyvrvSlbNjXqNYC3GxcurnI58gqr37J/jOVYn4IzA62Cr86OdgPqcGnwnb9yS8ll+rk4m4SavQhTzy3PGZ9SCwNA0BF0pyJXAHUhF1bHQEYmk8k4S1slTleYzqxtxqLIfslL8UWBemnA/bNAzhY9IApV2BmOLxZgoWXSFrMkjkhyBnrnCE3EYeKFhmsSkAGjr/6kHYKKhGWzBM8g1Oab19nlfq4+/MEduB0TA5jwTQqU01Yekw1wfrH83lwN6GpPldFD+OpJjFxm8sP56X0cFflNmcwGFCfWA45C+n2prilvr6uM0lgsbqhlv1hr5ehye3l42E8WCISO3ObQhvId1+Y8mLaa7va3VYRkEFZnAWqwuCbuUV58dSC7n0k39EMW48dzDZmtz08uRKWQPFhR/dXnlt08QR4X5J3fr1TZejCLv1hrRW4CbwuI1F2+jfCTTs8BNhGVKnbEXcRtmv1vVrkK61TM+PIu4QZDzoRyUXVWYJ20wk4jJsA7qNK0FQ6co4HdBKMvOcu2c1QHgrRMAZE1SpHI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc39501-df8f-4d36-6bb6-08dd66534e81
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 19:30:14.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HX5TB8sEu9LIVfBJ3Ph95Md7qiP9P7/dyneDpEZykvN1rrJtGriEYesCeT2s4qiX/Dmca/bsHfwJQxW5wFmBtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180140
X-Proofpoint-ORIG-GUID: kVZa99GPp2JNtNLlOajjOhiJ78j7XKuR
X-Proofpoint-GUID: kVZa99GPp2JNtNLlOajjOhiJ78j7XKuR



On 3/18/25 12:24, Anton Protopopov wrote:
> On 25/03/18 12:00PM, David Faust wrote:
>>
>>
>> On 3/18/25 07:33, Anton Protopopov wrote:
>>> Add support for a new version of JA instruction, a static branch JA. Such
>>> instructions may either jump to the specified offset or act as nops. To
>>> distinguish such instructions from normal JA the BPF_STATIC_BRANCH_JA flag
>>> should be set for the SRC register.
>>>
>>> By default on program load such instructions are jitted as a normal JA.
>>> However, if the BPF_STATIC_BRANCH_NOP flag is set in the SRC register,
>>> then the instruction is jitted to a NOP.
>>
>> [adding context from the cover letter:]
>>> 3) Patch 4 adds support for a new BPF instruction. It looks
>>> reasonable to use an extended BPF_JMP|BPF_JA instruction, and not
>>> may_goto. Reasons: a follow up will add support for
>>> BPF_JMP|BPF_JA|BPF_X (indirect jumps), which also utilizes INSN_SET maps (see [2]).
>>> Then another follow up will add support CALL|BPF_X, for which there's
>>> no corresponding magic instruction (to be discussed at the following
>>> LSF/MM/BPF).
>>
>> I don't understand the reasoning to extend JA rather than JCOND.
>>
>> Couldn't the followup for indirect jumps also use JCOND, with BPF_SRC_X
>> set to distinguish from the absolute jumps here?
>>
>> If the problem is that the indirect version will need both reigster
>> fields and JCOND is using SRC to encode the operation (0 for may_goto),
>> aren't you going to have exactly the same problem with BPF_JA|BPF_X and
>> the BPF_STATIC_BRANCH flag?  Or is the plan to stick the flag in another
>> different field of BPF_JA|BPF_X instruction...?
>>
>> It seems like the general problem here that there is a growing class of
>> statically-decided-post-compiler conditional jumps, but no more free
>> insn class bits to use.  I suggest we try hard to encapsulate them as
>> much as possible under JCOND rather than (ab)using different fields of
>> different JMP insns to encode the 'maybe' versions on a case-by-case
>> basis.
>>
>> To put it another way, why not make BPF_JMP|BPF_JCOND its own "class"
>> of insn and encode all of these conditional pseudo-jumps under it?
> 
> I agree that the "magic jump" (BPF_STATIC_BRANCH) is, maybe, better to go with
> BPF_JMP|BPF_JCOND, as it emphasizes that the instruction is a special one.
> 
> However, for indirect jumps the BPF_JMP|BPF_JA|BPF_X looks more natural.

Ah, maybe I misunderstood the context; will these BPF_JMP|BPF_JA|BPF_X indirect
jumps exclusively be "real" or was the intent that they also have the "maybe"
variant (could be jitted to no-op)? I was thinking the latter.

For the always-real version I agree BPF_JA|BPF_X makes total sense.
If there is a "maybe" variant that could be jitted to no-op then that should
fall under JCOND.

> 
>> As far as I am aware (I may be out of date), the only JCOND insn
>> currently is may_goto (src_reg == 0), and may_goto only uses the 16-bit
>> offset. That seems to leave a lot of room (and bits) to design a whole
>> sub-class of JMP|JCOND instructions in a backwards compatible way...
>>
>>>
>>> In order to generate BPF_STATIC_BRANCH_JA instructions using llvm two new
>>> instructions will be added:
>>>
>>> 	asm volatile goto ("nop_or_gotol %l[label]" :::: label);
>>>
>>> will generate the BPF_STATIC_BRANCH_JA|BPF_STATIC_BRANCH_NOP instuction and
>>>
>>> 	asm volatile goto ("gotol_or_nop %l[label]" :::: label);
>>>
>>> will generate a BPF_STATIC_BRANCH_JA instruction, without an extra bit set.
>>> The reason for adding two instructions is that both are required to implement
>>> static keys functionality for BPF, namely, to distinguish between likely and
>>> unlikely branches.
>>>
>>> The verifier logic is extended to check both possible paths: jump and nop.
>>>
>>> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
>>> ---
>>>  arch/x86/net/bpf_jit_comp.c    | 19 +++++++++++++--
>>>  include/uapi/linux/bpf.h       | 10 ++++++++
>>>  kernel/bpf/verifier.c          | 43 +++++++++++++++++++++++++++-------
>>>  tools/include/uapi/linux/bpf.h | 10 ++++++++
>>>  4 files changed, 71 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>> index d3491cc0898b..5856ac1aab80 100644
>>> --- a/arch/x86/net/bpf_jit_comp.c
>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>> @@ -1482,6 +1482,15 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
>>>  	*pprog = prog;
>>>  }
>>>  
>>> +static bool is_static_ja_nop(const struct bpf_insn *insn)
>>> +{
>>> +	u8 code = insn->code;
>>> +
>>> +	return (code == (BPF_JMP | BPF_JA) || code == (BPF_JMP32 | BPF_JA)) &&
>>> +	       (insn->src_reg & BPF_STATIC_BRANCH_JA) &&
>>> +	       (insn->src_reg & BPF_STATIC_BRANCH_NOP);
>>> +}
>>> +
>>>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>>>  
>>>  #define __LOAD_TCC_PTR(off)			\
>>> @@ -2519,9 +2528,15 @@ st:			if (is_imm8(insn->off))
>>>  					}
>>>  					emit_nops(&prog, INSN_SZ_DIFF - 2);
>>>  				}
>>> -				EMIT2(0xEB, jmp_offset);
>>> +				if (is_static_ja_nop(insn))
>>> +					emit_nops(&prog, 2);
>>> +				else
>>> +					EMIT2(0xEB, jmp_offset);
>>>  			} else if (is_simm32(jmp_offset)) {
>>> -				EMIT1_off32(0xE9, jmp_offset);
>>> +				if (is_static_ja_nop(insn))
>>> +					emit_nops(&prog, 5);
>>> +				else
>>> +					EMIT1_off32(0xE9, jmp_offset);
>>>  			} else {
>>>  				pr_err("jmp gen bug %llx\n", jmp_offset);
>>>  				return -EFAULT;
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index b8e588ed6406..57e0fd636a27 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -1462,6 +1462,16 @@ struct bpf_stack_build_id {
>>>  	};
>>>  };
>>>  
>>> +/* Flags for JA insn, passed in SRC_REG */
>>> +enum {
>>> +	BPF_STATIC_BRANCH_JA  = 1 << 0,
>>> +	BPF_STATIC_BRANCH_NOP = 1 << 1,
>>> +};
>>> +
>>> +#define BPF_STATIC_BRANCH_MASK (BPF_STATIC_BRANCH_JA | \
>>> +				BPF_STATIC_BRANCH_NOP)
>>> +
>>> +
>>>  #define BPF_OBJ_NAME_LEN 16U
>>>  
>>>  union bpf_attr {
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 6554f7aea0d8..0860ef57d5af 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -17374,14 +17374,24 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
>>>  		else
>>>  			off = insn->imm;
>>>  
>>> -		/* unconditional jump with single edge */
>>> -		ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
>>> -		if (ret)
>>> -			return ret;
>>> +		if (insn->src_reg & BPF_STATIC_BRANCH_JA) {
>>> +			/* static branch - jump with two edges */
>>> +			mark_prune_point(env, t);
>>>  
>>> -		mark_prune_point(env, t + off + 1);
>>> -		mark_jmp_point(env, t + off + 1);
>>> +			ret = push_insn(t, t + 1, FALLTHROUGH, env);
>>> +			if (ret)
>>> +				return ret;
>>> +
>>> +			ret = push_insn(t, t + off + 1, BRANCH, env);
>>> +		} else {
>>> +			/* unconditional jump with single edge */
>>> +			ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
>>> +			if (ret)
>>> +				return ret;
>>>  
>>> +			mark_prune_point(env, t + off + 1);
>>> +			mark_jmp_point(env, t + off + 1);
>>> +		}
>>>  		return ret;
>>>  
>>>  	default:
>>> @@ -19414,8 +19424,11 @@ static int do_check(struct bpf_verifier_env *env)
>>>  
>>>  				mark_reg_scratched(env, BPF_REG_0);
>>>  			} else if (opcode == BPF_JA) {
>>> +				struct bpf_verifier_state *other_branch;
>>> +				u32 jmp_offset;
>>> +
>>>  				if (BPF_SRC(insn->code) != BPF_K ||
>>> -				    insn->src_reg != BPF_REG_0 ||
>>> +				    (insn->src_reg & ~BPF_STATIC_BRANCH_MASK) ||
>>>  				    insn->dst_reg != BPF_REG_0 ||
>>>  				    (class == BPF_JMP && insn->imm != 0) ||
>>>  				    (class == BPF_JMP32 && insn->off != 0)) {
>>> @@ -19424,9 +19437,21 @@ static int do_check(struct bpf_verifier_env *env)
>>>  				}
>>>  
>>>  				if (class == BPF_JMP)
>>> -					env->insn_idx += insn->off + 1;
>>> +					jmp_offset = insn->off + 1;
>>>  				else
>>> -					env->insn_idx += insn->imm + 1;
>>> +					jmp_offset = insn->imm + 1;
>>> +
>>> +				/* Staic branch can either jump to +off or +0 */
>>> +				if (insn->src_reg & BPF_STATIC_BRANCH_JA) {
>>> +					other_branch = push_stack(env, env->insn_idx + jmp_offset,
>>> +							env->insn_idx, false);
>>> +					if (!other_branch)
>>> +						return -EFAULT;
>>> +
>>> +					jmp_offset = 1;
>>> +				}
>>> +
>>> +				env->insn_idx += jmp_offset;
>>>  				continue;
>>>  
>>>  			} else if (opcode == BPF_EXIT) {
>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>>> index b8e588ed6406..57e0fd636a27 100644
>>> --- a/tools/include/uapi/linux/bpf.h
>>> +++ b/tools/include/uapi/linux/bpf.h
>>> @@ -1462,6 +1462,16 @@ struct bpf_stack_build_id {
>>>  	};
>>>  };
>>>  
>>> +/* Flags for JA insn, passed in SRC_REG */
>>> +enum {
>>> +	BPF_STATIC_BRANCH_JA  = 1 << 0,
>>> +	BPF_STATIC_BRANCH_NOP = 1 << 1,
>>> +};
>>> +
>>> +#define BPF_STATIC_BRANCH_MASK (BPF_STATIC_BRANCH_JA | \
>>> +				BPF_STATIC_BRANCH_NOP)
>>> +
>>> +
>>>  #define BPF_OBJ_NAME_LEN 16U
>>>  
>>>  union bpf_attr {
>>


