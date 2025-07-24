Return-Path: <bpf+bounces-64295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08041B11089
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 19:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C379586147
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCE32EBDD5;
	Thu, 24 Jul 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jB/mqhfI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VPtC/7D+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C032EBB9D;
	Thu, 24 Jul 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379728; cv=fail; b=t3c9xA3PBoDEga17RR5tVeKbA5AADrTD73S6XeKyqoE91GKW+PCbXbu2dUmp53e8QFzIV17EYm/uzTCO4eJXx29MDHaaK7WPfrkofEgk2pcqdqjOozE7o8Ghphl1jbHBgg3OKIZ2erzFEjKVX/ToK8idLhMwjkpfbgHrOUiDjOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379728; c=relaxed/simple;
	bh=q0r+oHWCHvKfqvikRHG7wN8ZbvqerLFJtMFNUQroIuE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zh8g/QoOtMwsDHC7mwFD8+uUv3SKWBqaVHJYsE7QuL6pknr54d5QUwlt2vXUUe/Ob713+SAoYfuSEU+pcgtirDnXV6oJttl3WqoQjeE2zO7Sofprnwf4eXKAODqhJ+70xaj0bGPbGcJp5QNtOxi+0J1RjYQJvl7LJyw+4RFp/vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jB/mqhfI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VPtC/7D+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OGis5W003773;
	Thu, 24 Jul 2025 17:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n9TSYyPY8lKZc+AZ3R2cYUwXN7Jk+IK9DuLqyqP0zYQ=; b=
	jB/mqhfInsSd984SmUwPqqa5H0awkggb4n3muJcmivOW/RcYXc9b+w4zykf9K3pE
	GD7QX/BLNqxPC5Z7edKRacUDInp8FQuPCIfw6Q6Zuief3Jyl7fe2QqSshQEfZHe3
	zrSCYNLfjulpjtAvIb5M6Ye4ahLblvPM3gtC7Fz3yjxCabrMCpYXhKzhhNCRZphU
	HO39Q+o8hR+kILxaVGTnbRhhqZIDXDLxquQRo26nqo0KMQUlnl8qMqgEOoKTDSjj
	os3QgjNTthD3ocV8pWJbAbHY/1gd0G4FAPtK8nBm/E+LFl0cGQHbrby+aM6kWbfw
	BWpYJ9AymRHqr6zmSzRCgQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056ej1g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 17:55:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OHPFbB014581;
	Thu, 24 Jul 2025 17:55:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjfxxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 17:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYh4clUgwv6m1MK+xQdJ19r1kgeeCGRFxiCt4X9cu6poz6oYbNxSPknqA1kgt4W0f2KaQFQAGnrH+Y1h9sMbQ1jRc1yr7a1UzJIfo6i5YCRkBllgHpTHmbUlWs41mrwizy0l0Efns5bijqgqKyCGDMmBx+RjkfKeqnszQVwaVOgGlNCvKbyZp6rdAdWdNJNHrPzJHPy424LPhZmTjjFcw+bx7zFU3oTwdbI1YmjM+5T8oNBGjQP+Nnm9a+WeArhOhUlFUMpU9Ico/No0mO4TFXF6e42AiktclnJudvU7ivxov2op846P/C6afKMvICp3iIdxbONhVYMvGQD+mR8kDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9TSYyPY8lKZc+AZ3R2cYUwXN7Jk+IK9DuLqyqP0zYQ=;
 b=X3joqTyuSc6ydowY5VdLLrsp8ifB7zh0LTnSjFXQvfNaF/068oavXyvpV+bOr77OUgTUdSUtFkkh+nhap1BeNdUYYJwYuOFL/Q6+JwMRrouWRBEYr7sRmiNXBa/KaD4Y8hzIPEgjaNc4rOqbpefiJNn7EV6Xcs2FSeBTu+9B9wknQ//Emt7J+1iTdF6VErvtjvx6VXn1UECs5o2yDy+0jiCUBJcQUFwbf+MBkEdFnYYcHnqvoIeveLCxKFbu0Kig2jigk5/29nPRqeGw4u+DVicMFxotqqbTA4Nf4q+gWrvnlQvRXBlJhZBmS8BhlrfSD98ijAECIrWMOGywULJLGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9TSYyPY8lKZc+AZ3R2cYUwXN7Jk+IK9DuLqyqP0zYQ=;
 b=VPtC/7D+zlcVga/tEHZeuLsL410DhXmpNvLB5QdONr4Me4pCyG4Hax24GC/OehOiEjQpL6Oto8P7BryHv1KV44sKIjuqdJZuiOCFEm4h2Kg90UQsHWZZ1pfyw58rQ4gyhnZB3aXvnAzKrFZR+gA4eZOcXuyWNNCLENPT8WsmNeQ=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB5643.namprd10.prod.outlook.com (2603:10b6:510:fa::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.22; Thu, 24 Jul 2025 17:55:00 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 17:55:00 +0000
Message-ID: <f44af47f-e05e-4fa4-95ca-bf95f04e4c27@oracle.com>
Date: Thu, 24 Jul 2025 18:54:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC dwarves] btf_encoder: Remove duplicates from functions
 entries
To: Jiri Olsa <olsajiri@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Menglong Dong <menglong8.dong@gmail.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>, Eduard Zingerman <eddyz87@gmail.com>
References: <20250717152512.488022-1-jolsa@kernel.org>
 <e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com> <aH5OW0rtSuMn1st1@krava>
 <6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev>
 <e88caa24-6bfa-457c-8e88-d00ed775ebd1@oracle.com>
 <98f41eaf6dd364745013650d58c5f254a592221c@linux.dev> <aIDFh26qdAURVL0u@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aIDFh26qdAURVL0u@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0029.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::42) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f1aa51-61fc-4d50-d859-08ddcadb353b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDdVenREQTUxT05aenJibG5kY2FYY0dpUkJTQUJybDZSRzUzK2hiT1NXdXAw?=
 =?utf-8?B?WXp2K1FhYjlYRUdZL21ad1FMZEJFTzhtbnE3N3Q2bjhBcS8rR0JTNFoyaC9K?=
 =?utf-8?B?UFBaOFJCdzkxZTBGZWxQVkk0RjlJbzJqZnNiQVBDRGR1Q2sxT1VEamExaG9n?=
 =?utf-8?B?V2ErMk9SWTRlaUJvNGtlV00zYnR6QmxoVW5KTGJKb0dOMjdrbkJuUjlPbzh6?=
 =?utf-8?B?YXI1NDJyVm4vWTEvSHh3RVhDQzBmOUZZZE9zQzlTWVB0Q1YyZzBQNnI4eElE?=
 =?utf-8?B?VklDV1k5eFF2dU1JMSt6YVhOSlFraFVWZExvRW5VZk5DY205YkJOYXNLeDMz?=
 =?utf-8?B?dVp5aHFFQjg2bk54Mmx2N1dUM3hLT2tvY1U3TDdWUkJZdkpUQnZNMUthOHJY?=
 =?utf-8?B?M3BzeS8yZnl1WUZWODUwcEREMm9McjRqbC9RdmVsM29JT2NvdHY4aFVRTjlN?=
 =?utf-8?B?K2ZBOVRKL0txTjZSeHQ2SjRFaVc1SzV0TVpjNldhNXZDc0RPL0c0Z0JUc3d6?=
 =?utf-8?B?d3lWaDBZSDJoQWhwZFdhNGx4YVh4a0NPWHZITVBNcU9PNlVBK05NOEsxOHFa?=
 =?utf-8?B?V0NzWWVOcEpncDBERVpGbXA3SXNKK1JOY1lBdHIzSXk0SGppekZXVllUbDlF?=
 =?utf-8?B?M0JNVUpwYjNsNjRFMDNnM0UxQTdSKytXQlZiSitJS0FZK1FYOUduaXAzdlVv?=
 =?utf-8?B?S0dJOUZoRGRzdWZZenNXV0VHWWJ2Y0dqNGtGUTNvZXhlTWRpV1ZVa0RrTDYw?=
 =?utf-8?B?MmsyLzcvdmdFRlN6ckRpUmM5VlNqUXBjbkxaK0FaL0RkL1Nzb2hGd0RlNGpS?=
 =?utf-8?B?NnFhNkZTSzVXdUxKSC9jWXJscDZxb0NrU2dnUjFHYlViTCtCSWR1dWlwbHNJ?=
 =?utf-8?B?N3BoS2h1NTB4ZnNVN0xrdjIyWmV0ZjFtMTV6eWhNbFMzWFVPTEtqM3cwZ0xq?=
 =?utf-8?B?RXF3VTVWcWJvckxHcXRTRTJWNURRWExvVFZybHZmU3RmUEt2ZzlNbzYxREh6?=
 =?utf-8?B?UUhVSUtNQ1Fxd2huODZsbTA0ekdmSHJkUzdSelVVR3pad2MraDN1SDNhbi80?=
 =?utf-8?B?dVQwamlHWWc0dGwxNUczOGVDSWcxdElvWDY2SEVrWkZvQjZFMUNFVjZMMXAw?=
 =?utf-8?B?anRpbGErVDhMZVFaWDFPY28vMS9lT3ZydEVXVkNjQzJ1Uk5hRWJSMWZHQmpn?=
 =?utf-8?B?SGtUbDN4aC94ckNDNEYwRllpZ3hvTEc3dm4yWVBRR2FKOE9qbjNhOHVNTmph?=
 =?utf-8?B?bGlBQ3p6ODlPeXJpMlFFT29BUForeW5HbGE0S3FLZkdpeHRWZmNmVFdFcnRx?=
 =?utf-8?B?a2lKY29idmRiS0x0VldmeEZGYldTcmVMdlR4Vi8zUldIalhUVHlyamwzUWVz?=
 =?utf-8?B?U0JXN0ZRRUd3R3gwcFd6YjI5NENMaVhnWlhYa3F2cGpOQ09vL1VDdHM5NG1O?=
 =?utf-8?B?V2tHMVJMRUU1V1JBRC9mRzVwOHMxaTlEdnN5ZUE0bkpoY01kalE1ZUozUnk2?=
 =?utf-8?B?N1g4U01PRnhzNy9QSUkvMERJM2tUMENqUHdIS0hNY2QxZDlEaHZRdUl4dEl4?=
 =?utf-8?B?RXBjVytmNWErUU9RNFVyemFOQVp4ckpxVzhVVDFwWkEvOXNxQ1lGSncvM3dQ?=
 =?utf-8?B?bXh1T1BRV1J4MzFMODJsaXVsQUNhc3VPc1FiTEljRFp2eU91SnpuN1VGR2FQ?=
 =?utf-8?B?TVBWRVU1dmp4TGs4QXZEL3ZnRU5SUWowcDJjL0s3azVIYWdEdlQyTVU4SHNH?=
 =?utf-8?B?VFYzTS8yY0ZRNHJ5blpEVUd3R0JEMlFkcXNZV1hyU3BiQkpsdXpJcGd5TWM2?=
 =?utf-8?B?dWE2RWFOZnZ6OVhWVFM3K25DYmU2b3VQRnhaU3ExRzlCeHpMdDdMMU1naEpy?=
 =?utf-8?B?Ri96endNT044VlhrK2tpOHpkRzBLQW1XekxpREROTEFJdDBzWUFGYU5QbHh1?=
 =?utf-8?Q?EsG6/yIGZcs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkNUUkN0VWpFYnNSek5rV2wwNFFXc1RGd3lnRmZzVThka2JWaytzMkJ4SGhR?=
 =?utf-8?B?dEZ5emNjRi9xS3cvZVV4aEt2MUg0SG9ZaytKM3N4YnRwSm1ZRGpOeWZDU2ds?=
 =?utf-8?B?c3M5NS8yazd4VXIwVjYySWhkYll0cFR3S0VVdTh1WEc1d3JNNTNDVDQrNmtN?=
 =?utf-8?B?MXNlSHlsQnFrR0Jyd0d5Z0xDMlpzY25YU1RndDhWQkZ0cnhqMUpDRU5pQS9C?=
 =?utf-8?B?Qk5YMmR2MWhaQUkxN2JTQ1IrQjhobkF4QWRkdTJad2xCekpQcEI5T0hzdEVn?=
 =?utf-8?B?NXVtS2VjZnhnVHZsSSt5NUVEYmo0VEpLN3I5OHJsMlR1dHJyeE93VEYvT1pV?=
 =?utf-8?B?SzhEYTByTlJpcjRHNU01dUxMV1p2Z0pqQU5rM2tTSlNkNUpOZEtyUEt0TTNn?=
 =?utf-8?B?Nm1hTFdMd2lFcjRzMjhyOC9rZW5xeGttSmtPdWlMNXFBUlZ5Rk1TMTZsTklo?=
 =?utf-8?B?V3pBM3BCY3lIM2RYaTA0UlZhZi9BbzJuQTFaRXFLc0luNHk5OHJxQ2Qzemhr?=
 =?utf-8?B?cjZYL2REYWtweFFyWi9pNXNvOEFFb3AxQm9rRGhvRlpxT0hKUDRXNUk1Zzc4?=
 =?utf-8?B?Ti96a2pYSkRpeFpsK1V1S0hDTW9RVDhIcEVGeG5aQnlOYjFLajl5dEwvbGc4?=
 =?utf-8?B?NWFOU0ZHOGxBTkFDOEtFSHVqbFVyKzZKY0hJQjdyaHdxR2JOL080V2U1Yml3?=
 =?utf-8?B?eEZUZEZrbHZRQU1obllETVBUMk1XQkgrNUppaTAxczMzK2grMGJQWlpiLzlU?=
 =?utf-8?B?NGJVUDZURHBHbnVtTjQwNVVUSnNZU0ZodEliRU4ydmtaY2dZVDJGWHJsTHJr?=
 =?utf-8?B?MWoxdUpIYVZKR1FJdGxqQnNQOE9INm8vczl4ZzN3RTRLR0R2QzVpVlAzMUpa?=
 =?utf-8?B?ZWNSQ3UvbXpQMDVoR0NQZEs2cGdUSkJ1SEwxUXpaWjhhdXRYZG5XYmtDaS9x?=
 =?utf-8?B?VVU5d1FldUpETFRwQThDOW9CcjJUZmJMWVJ5N2tOTlhFOW1oa0xCZWNpTEF0?=
 =?utf-8?B?bmZOd1lOQXJoTkhDMnN3MkpWbHRDZnlySU5DV2RPbVRQWkxMVFA3Yi9pTi9S?=
 =?utf-8?B?SWYvU1hLYnc1QVhJbGwxM3l0VmMrY1d4dmJBYSthclhSRm8xam5yVmZtc2hx?=
 =?utf-8?B?QXQ5MmNtYUttWFNJVVZ2eFdkQ3ZFTUJRTlFUNlV6ZnJpTzZwMklZTnBCVCth?=
 =?utf-8?B?WWd6NmJGdjlpWk85eDB6UFhkbTZyNDVGb3FjQmVpVDMzMWNsWE5wY1hnN21y?=
 =?utf-8?B?dndKUDBtVmpaQ1lRbkM5ZWdBNTRBY1RDY3dmc205bTAzVEsxQTVzL3lKVTlk?=
 =?utf-8?B?d25wZFF1QnladDNwNEFKMmZnYmhnL2pYbVg4L1p0YXZNMEhlM09WYmIyakU5?=
 =?utf-8?B?bjVYRWZnaWNmcm9FYUgzQ0tUaTdvVWtVK3gxbW1jSTgrcURkdXM2TEhoU2hT?=
 =?utf-8?B?anpDMUU2Y1UwYktkVEVjR0NxYzJKZERWYnZsV292NERrMDBRbDlFT3A1Lzl2?=
 =?utf-8?B?ai9BcVhQWGNITFFRZkJTdVJ1NVhlZXM2NzdEYXRKUEZzYzVwMVdSVHp5dHBq?=
 =?utf-8?B?REdXcnV6QVVCQUE2a3kxdVY3YnJVcHdKRGE1Sm5WeVpacWRrbGtLV3JLR1Qz?=
 =?utf-8?B?WUpvc0YxQ3B1R0FRODZoc1dSemJpQ0U0b1pneWpyS0FaZEN3R1pZSU5Hbm5n?=
 =?utf-8?B?Z0J4Z1ZNckRBVHFLdXBqOTNRajE2czcwV3JsRll3SmJ4cm82NmtVNVM5RU16?=
 =?utf-8?B?NjhhSDBpeVVleVdGNjdleHplV2xXUE9sRGVmQVRHK25XdzZ4MmhoS2ZwNTBD?=
 =?utf-8?B?SHQ1d0Z3bXovZlRLdEF0ZCtCN2ttWmdsek5pMStqc3gwdDVRaGM5UFJKemwv?=
 =?utf-8?B?dUcvV0Q2UW5qaUI3Smg5Wit5cGlNTXRoeWZUbXhzM0JzNXNOb3ZPbmNmVk9x?=
 =?utf-8?B?RFVVdndnWG5RdWJGZSt4SWJJSytKa2s1RHplUjhqVVNzYzlReWNmdzYzYWZn?=
 =?utf-8?B?MVNrUGs4S1NXSVVrcmJFR1U0SWhzSjI5bWxoSzQvam9hRHh6Umg4bGxPRytC?=
 =?utf-8?B?Z2s3M1JzOFB2YWpoUmEydnFSZzF5S3p1NFVQR1NTZkN3SGlwYXM3aGFUdm8r?=
 =?utf-8?B?cXdsL1U5YUxxOElOc01hbnVxWWhSZTc4SzdWNGFVZ3VzNk9WU1dJc09zVUQ4?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PUL5A401XPSrXl3VehN/cM35PzaK2PHgUbK9l9vE4o8Eer0t8i4Y3h0t0HPUxinxNT+RuWx1eUPwVXnkmbFt2sva3kjgLzYq7hQOXAXhub4jFKxVLbfCJJRZFm6OhXDiFYHLZ1lBBCKIUTgnROn+K4fC41YcO5a7hOYah+UjbMmtYvdkfFrdebvOWZurChNanPJXnvGO7ueFvTyOjyMYpsYKMa8BXQlYr7xxVMbGYqeiF667t9I7SIu2TqAUGTvyk7YfNDw7RuFFPZ8c5xzA/ecV/nArgBpSKY5ZpLgtmeI3CjKgUVWc1wLC4ckrVInUC77LR60Dpjnv82bmhzr75Jq57MtqCU3j3eX8naxlz3nY7RDof/OKOOIiEY1ctBF4GG1UoDcORqj4PAREVKOgiJHbUsveK+dP3yVwfFqthbnLAfMqK2cd8IKbYmbkD6IRv4KQV28/nAtX8d5BNi4ORKFb/h6FgRFn+BMclxbgR7EZCSyj2+A31nxj/HlwNxeliXkX4LSU+wPiiGEWZy9engxCYikPKhQVXLmjg1cCjkq2is9DNr1/0mgH4FWirfeZJBQ+oeKQ6PdvKBbTM2JpK7y/Lk3Ys53p9OLbbIGidNw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f1aa51-61fc-4d50-d859-08ddcadb353b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 17:54:59.8892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUQ4SBWs3xNvDmis7sgsaHxTgVSmFV3zyFRvgsYrXN5iQrPjgqnIppmLxj9rKf8H3TCDuqmg6L2C7FZx3rKD6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240137
X-Proofpoint-ORIG-GUID: Fyu-Cfae0qM-6w5jjMoHW9vJ_hSql4ns
X-Proofpoint-GUID: Fyu-Cfae0qM-6w5jjMoHW9vJ_hSql4ns
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEzOCBTYWx0ZWRfX1KIG8H3Et1PG
 lEnPYqb+BznohiFyCLwDQtA3TxZIQzZzBe6cbBQbpyEtzY6uY5OFItrtq+mI8rYbeIhhsPqttPq
 Y6v+IMTLdsyoqnMUFEAMmQUba5wzyB5wUP54ij6QF4Op5v5duTTNpduB/HG+mfOwTG8SdHOusUT
 OiYPtzx6pATwOQBUwiBOp1FNezxNQgWP4Erx1Fer3puh1cZGBDU2ENuLyX6MHMB1Nnh/TpvSZZE
 2obg0Pze4ZDgPUL0yfSU+kzub9cTcQ218aQDIdPf7jQR5jsWwy29nG72uTmn0BMFtaLnKDJU8Y3
 AZ3JDAHTnEUkH8C5XOOh/h6tK3FOZvHnTP3twnazuIrPfoC5VdUntLAqtqSFUmKI+0fG6yytPKt
 nDqbJEkHChs6pl0YyGENkyJBAGDuJhnILqlBR+Cu8gZz1d6+ngrnpXlfNe4nS9+3BN5l1DEZ
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=68827381 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=NEAV23lmAAAA:8 a=9QIc2h267sXWfqG9GG4A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12061

On 23/07/2025 12:22, Jiri Olsa wrote:
> On Tue, Jul 22, 2025 at 10:58:52PM +0000, Ihor Solodrai wrote:
> 
> SNIP
> 
>> @@ -1338,48 +1381,39 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>>  	return 0;
>>  }
>>  
>> -static int functions_cmp(const void *_a, const void *_b)
>> +static int elf_function__name_cmp(const void *_a, const void *_b)
>>  {
>>  	const struct elf_function *a = _a;
>>  	const struct elf_function *b = _b;
>>  
>> -	/* if search key allows prefix match, verify target has matching
>> -	 * prefix len and prefix matches.
>> -	 */
>> -	if (a->prefixlen && a->prefixlen == b->prefixlen)
>> -		return strncmp(a->name, b->name, b->prefixlen);
> 
> nice to see this one removed ;-)
> 
>>  	return strcmp(a->name, b->name);
>>  }
>>  
>> -#ifndef max
>> -#define max(x, y) ((x) < (y) ? (y) : (x))
>> -#endif
>> -
>>  static int saved_functions_cmp(const void *_a, const void *_b)
>>  {
>>  	const struct btf_encoder_func_state *a = _a;
>>  	const struct btf_encoder_func_state *b = _b;
>>  
>> -	return functions_cmp(a->elf, b->elf);
>> +	return elf_function__name_cmp(a->elf, b->elf);
>>  }
>>  
>>  static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
>>  {
>> -	uint8_t optimized, unexpected, inconsistent;
>> -	int ret;
>> +	uint8_t optimized, unexpected, inconsistent, ambiguous_addr;
>> +
>> +	if (a->elf != b->elf)
>> +		return 1;
>>  
>> -	ret = strncmp(a->elf->name, b->elf->name,
>> -		      max(a->elf->prefixlen, b->elf->prefixlen));
>> -	if (ret != 0)
>> -		return ret;
>>  	optimized = a->optimized_parms | b->optimized_parms;
>>  	unexpected = a->unexpected_reg | b->unexpected_reg;
>>  	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
>> -	if (!unexpected && !inconsistent && !funcs__match(a, b))
>> +	ambiguous_addr = a->ambiguous_addr | b->ambiguous_addr;
>> +	if (!unexpected && !inconsistent && !ambiguous_addr && !funcs__match(a, b))
>>  		inconsistent = 1;
>>  	a->optimized_parms = b->optimized_parms = optimized;
>>  	a->unexpected_reg = b->unexpected_reg = unexpected;
>>  	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
>> +	a->ambiguous_addr = b->ambiguous_addr = ambiguous_addr;
> 
> 
> I had to add change below to get the functions with multiple addresses out
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index fcc30aa9d97f..7b9679794790 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1466,7 +1466,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>  		 * just do not _use_ them.  Only exclude functions with
>  		 * unexpected register use or multiple inconsistent prototypes.
>  		 */
> -		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
> +		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->ambiguous_addr;
>  
>  		if (add_to_btf) {
>  			err = btf_encoder__add_func(state->encoder, state);
> 
> 
> other than that I like the approach
>

Thanks for the patch! I ran it through CI [1] with the above change plus
an added whitespace after the function name in the printf() in
btf_encoder__log_func_skip(). The btf_functions.sh test expects
whitespace after function names when examining skipped functions, so
either the test should be updated to handle no whitespace or we should
ensure the space is there after the function name like this:

        printf("%s : skipping BTF encoding of function due to ",
func->name);

Otherwise we get a CI failure that is nothing to do with the changes.

With this in place we do however lose a lot of functions it seems, some
I suspect unnecessarily. For example:


Looking at

 < void __tcp_send_ack(struct sock * sk, u32 rcv_nxt, u16 flags);

ffffffff83c83170 t __tcp_send_ack.part.0
ffffffff83c83310 T __tcp_send_ack

So __tcp_send_ack is partially inlined, but partial inlines should not
count as ambiguous addresses I think. We should probably ensure we skip
.part suffixes as well as .cold in calculating ambiguous addresses.

I modified the patch somewhat and we wind up losing ~400 functions
instead of over 700, see [2].

Modified patch is at [3]. If the mods look okay to you Ihor would you
mind sending it officially? Would be great to get wider testing to
ensure it doesn't break anything or leave any functions out unexpectedly.

> SNIP
> 
>> @@ -2153,18 +2191,75 @@ static int elf_functions__collect(struct elf_functions *functions)
>>  		goto out_free;
>>  	}
>>  
>> +	/* First, collect an elf_function for each GElf_Sym
>> +	 * Where func->name is without a suffix
>> +	 */
>>  	functions->cnt = 0;
>>  	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_sec_idx) {
>> -		elf_functions__collect_function(functions, &sym);
>> +
>> +		if (elf_sym__type(&sym) != STT_FUNC)
>> +			continue;
>> +
>> +		sym_name = elf_sym__name(&sym, functions->symtab);
>> +		if (!sym_name)
>> +			continue;
>> +
>> +		func = &functions->entries[functions->cnt];
>> +
>> +		const char *suffix = strchr(sym_name, '.');
>> +		if (suffix) {
>> +			functions->suffix_cnt++;
> 
> do we need suffix_cnt now?
> 

think it's been unused for a while now, so can be removed I think.

Thanks again for working on this!

Alan

[1] https://github.com/alan-maguire/dwarves/actions/runs/16500065295
[2]
https://github.com/alan-maguire/dwarves/actions/runs/16501897430/job/46662503155
[3]
https://github.com/acmel/dwarves/commit/30dffd7fc34e7753b3d21b4b3f1a5e17814c224f

> thanks,
> jirka
> 
> 
>> +			func->name = strndup(sym_name, suffix - sym_name);
>> +		} else {
>> +			func->name = strdup(sym_name);
>> +		}
>> +		if (!func->name) {
>> +			err = -ENOMEM;
>> +			goto out_free;
>> +		}
>> +
>> +		func_sym.name = sym_name;
>> +		func_sym.addr = sym.st_value;
>> +
>> +		err = elf_function__push_sym(func, &func_sym);
>> +		if (err)
>> +			goto out_free;
>> +
>> +		functions->cnt++;
>>  	}
> 
> SNIP


