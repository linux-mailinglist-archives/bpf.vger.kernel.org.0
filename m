Return-Path: <bpf+bounces-27796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC18B1CB1
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 10:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA61285A06
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1C93EA86;
	Thu, 25 Apr 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q4BZYWFp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jusbQR6b"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B82D60A;
	Thu, 25 Apr 2024 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033087; cv=fail; b=QwuzQ2Xu1Pa2sAOTIYwJW0jz1zXl7mEMefQtkc6gZo40iGLR+9+KOEqqcHljHdsPf9yUOzZloKr2BATBOSwyH1Xc3PWp9igzXi2OWAdcDeJEGG1nRW6FF0TUCiwBn6bVbLlNXQ8/QMVI3gWmKkegSJDljanDCuE5IUc6E/S/sww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033087; c=relaxed/simple;
	bh=8zVRL+wcE+VKdvNU+y1SJ7eWz4BmUVtj5hGSfCxaRIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HoZAeurKK+SMxQ5CI6g9/IbErvMej6/scPRKGR5Ony6vVqkoxAKILZ8eQZZo1bwUG4srI7FD8KmX0fo4ybCSOcF95M4p49omPb0e/t5ayntADgkSDq5vNfvc3IRfkMYFi+COvMiKQc0V/DFU0efYxtcpD968YljHMMHaZXr1A2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q4BZYWFp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jusbQR6b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0hpog011500;
	Thu, 25 Apr 2024 08:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GVBUlrOobK15t7aJ0WSRSM5i3mr8W7Dx2zrQD1lYtF0=;
 b=Q4BZYWFpIynKQS9MkMuGJ5js8toVHkFhi+qcp1ydDnvJzfcowxdQtlaJjW5vK4TJYrxX
 XsSqu6Y5RMMKRMkE+yUIU9+N7Df4eySv5oqOEVsrMniXClvA1cW3SBUzazemKZaLbQWG
 2VCglv1jKjeLkXNO7b+xScZZlqgvKe+wSoaGuIcVSd3kS6uFmeFQIL4xgSbBknC8Pew8
 boLGswNk09fEconlzauYX4rdg6f7E+ltVlOqinreJf92ub0K3n7GTyp5SYGeDlEis4Jp
 SsIn3pfHHDynaq+gGQ4Z1S34k6s5pAR13nRiaOcje7IpM61noeimOXTEJkGeFXRy+3hp yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5auswjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 08:17:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P6mw01035571;
	Thu, 25 Apr 2024 08:17:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45a1fpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 08:17:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6XLJWDXVQFn3sqGHIIvrwgMHp2x88Lav9f2O+iGgDuxuUKvYIxw2AG2U61DJOSt5TiqnM9apaULsMiQRXNSjiQPRIEMo65tDVvj5I9imYZv5Wk+dyvT8JfVHODi1ibUHKz82Ygb1q90c3U17Y80i5/Cqc3UIQ5C5WYAnJu7SINPuRmfeqeVMMkpBvEvzhHYMSuLQIdI/Pe3ZSclT2utDZmaGGq4MUe6m709PCaFoH1uqYIILiSQGCSAazNUtV8nbIwGspFmTmRX5t24R2QPBXCdRcN7NJohHAEPesQhOOE/AXg0eTy6MV+s7ibvKsOZz1+QqGrsAnYSyEvN3tFHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVBUlrOobK15t7aJ0WSRSM5i3mr8W7Dx2zrQD1lYtF0=;
 b=TiRAafOYhYjnknY2TJtlyR6qQeJcHcDTNL0jyMohsdvvjBPYQLuwjopXKQb+4HGfyELN6JHorTMV/XZ4mG+k5dGMxXl2dNFt1vULXuSOwUofw19BP2cDi9sRiN/M8qZbJO1VHb1gcYf2Hq6GPPPxvVmygTD2tY1+oM8IqX4pc+cCOXx/dAAWS1cKhKN27JvgiN/65tMI5hFxpMgNsOPfATBmbIJekSG5cc1VbnBdrd/A59KsdmZN1AjWG42C//sgWtde39TmdsWFjI5HNkNmUvVTS0Bgri0050vIRnhSf3S+36ly8mhaJ9eKgtb+dJ8Hq9aeRbQUN67OOsIS0sysmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVBUlrOobK15t7aJ0WSRSM5i3mr8W7Dx2zrQD1lYtF0=;
 b=jusbQR6bbmt5u+b+/WC83i9+LxRnCUdd+wW6ZnPk0pOYQXi2DKeGhr+/3qw55fn+xBG6T8AdhRRwd3ZZDWBARJh0y/bV/7Blk0eTZ3LLTUv8uOPeMbQYOFEw4KfunCQDPd+pApOYS4i5O0hWaFPmT8AT+C4yGn7VorVVQPPu8jM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB5969.namprd10.prod.outlook.com (2603:10b6:208:3ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 08:17:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 08:17:37 +0000
Message-ID: <686d2f65-0d6d-43e6-83fe-a9eb2eb6149e@oracle.com>
Date: Thu, 25 Apr 2024 09:17:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: Fix dwarf int type with
 greater-than-16 byte issue
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>,
        Xin Liu <liuxin350@huawei.com>
References: <20240424223538.2682496-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240424223538.2682496-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0012.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ab8ffb-9e0c-469f-a7a1-08dc65002aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MWl0MUlMSkVCT2ZTYWdFa1JCdjZtZlBoZUtlQ0tUT0NkQVJhRGZSNklGSUNC?=
 =?utf-8?B?NjhYWG5ZWFl2dVEyb3FuZzAvNjRINXRDRk5GYmVSMnlXdGcxc1pvQTVsWEhD?=
 =?utf-8?B?SWhDSENWdGJJRGl0NzFsV1JoZnJVMVMvTE9OWDJKSXBPZXF4ZzFhbFN4VHIr?=
 =?utf-8?B?bldOVkFwM093a0FsWitQMWlhUjVjL2pmTnBYcFl6bTJ6YkxwbVA2T0NYVHhz?=
 =?utf-8?B?VURaQnd5aU1NTGZKbmcvVnpFc1NFMEMyZFVXcjNDSEZlTkQ1Y2U1a3N5eUt5?=
 =?utf-8?B?TU82OTlHNGNzK2h2SkxZbjYrWThmekpCc0MyZmx0bXRrdFdzdUM5cGFtUFdl?=
 =?utf-8?B?anB1aHMwMW91QlBqSFh2Y1lxdFpjQVJLZ003SStZcnk4ZXhRNndPSXlhbUw4?=
 =?utf-8?B?amgycDlQRjJXNnF5YklXeTFic1p1QktOTUtENTVEUXpkMnIwc2VUdDZxTGxK?=
 =?utf-8?B?bVA2K3RCRjYyTXVncmoxakRXcTRWektaNWFXbmJuSGtVMnpzTDkzclJtRGVr?=
 =?utf-8?B?TjkyYXRubTJlYVAzYzdQQm1OTHRySnJoaU94NnFVQm45dlZKRlkvMU1RRStO?=
 =?utf-8?B?ZUg2RkxKOFBaTXpWNzc2dk8wbnozM0l5WUgvM1psYWI5SUNRNmxIaHBjWmJk?=
 =?utf-8?B?RjZwd2RZUi9zYTBIcVFTUnJ2emE0bSsrT0h5OE9wZ2RqM05kZklaYnllMEdY?=
 =?utf-8?B?NkhjSkxsallQSnhSd1B0R3dxZXZqWlN4enAzbHJ1NXdoeUNpeUlTeWVpZVNP?=
 =?utf-8?B?VDZFZENlTVpDM0kveDdZNEdmbjRzNFF0R1U3ZllkNm83K1VxT0xpRHNuVndU?=
 =?utf-8?B?SzdocDF6WGx0U29RMldMQ0kzSkkxbnFwczJHNGMvNzM2TlRyZGIwRWh4RE52?=
 =?utf-8?B?T3g0RWgrRkFHKzhPWEszb1ZMYkdhZVZ3dit1UWVEaG9ZN2xsVUs0UnlQRjVR?=
 =?utf-8?B?cERVWlEyT3ZKaFpLeVRsN2U3TXR6bW5uZEhvQ21aRUpVdVpmbGJ0T2h0UzZN?=
 =?utf-8?B?MEVUQllIMk9QNCtvMjJ6a2lqLzdwcitWaEp1b3AvVDhkYzBuUDZRYXJGV2t5?=
 =?utf-8?B?RWdyeDJJT1JpM3BoQUVRSXVVQmJTdWNMNzREWlpST1VLZGsydU1CL09rNFo4?=
 =?utf-8?B?N1hLbUpKNDhXR216djNRZU5ST1lqQlpQT2dTVWN4VWNhc0NzdnlzYnJGTmlk?=
 =?utf-8?B?QmxJblBVOWI0aWZKMDkrSHFNdmRjenlwSTZUeklGZitDWkxVRHloTk8wb3Zj?=
 =?utf-8?B?anNNRnJWeWtCdGJxUzF4UzVzeGw4NTdHUGdmL3haRE5qRUxja3BoR0Rxdk5w?=
 =?utf-8?B?UmtQcG5WTjFWdVhDWGxsNHE5d2hla3JOaCtGZTh5MWFsWnZxdGlkU0k0dzZE?=
 =?utf-8?B?aXIzWXd5WVNySytMV3VCZXg0Uk9BWVBpYkUvaytseXB5RUYyOXphVjV5MkNP?=
 =?utf-8?B?Si9yU1V4MXhmUlFjSHlGNUMyT2RleDhYQnd5K1FvK0QzUTVvZTJ2Nnlnc1Js?=
 =?utf-8?B?RGxET3NOME5Kd3ducmk5VjdSRGc3WUpXQlJ5cnNEb0JUZ005NGxleW9zOU53?=
 =?utf-8?B?R2FZK0poWC9nNmd4b25vbVVhMXJsdkVKeUxJVlVIZDJEa2FFMENkS0c5cGNw?=
 =?utf-8?Q?DwmbHNSR2Xo1l5gEnkC6/j99wJGuCHLrpWRg9XNcVzAY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXpRNVdLeEZEKzFkWTQ4eklYNi9HSlFSeVl3eWxSRFZoU1FQM2dkYmdVN0Zx?=
 =?utf-8?B?dUQzR2haUitJcUJHZk1hai9HaWo2WkxkbW5RVGNJd0M0MU9BamJTbXdpUWNL?=
 =?utf-8?B?My8wbnZRenhKc0plWlBBS3FweHZteFZNVTBsVHZHTXRxSERkWkFtT3dpSi9S?=
 =?utf-8?B?bmcyTXZWN0lYVGlaVHVWclhkR0dtTkc3NnFaZGFGdzViL0xnT3V5eWt2MVFL?=
 =?utf-8?B?elFheG82bWRndWo4V05ETG1hT0tJNVNCeVRWQWR3aXVYZmpjM0JqSlpEdE8v?=
 =?utf-8?B?bmhHSGQxcnBIcW43YUE1dVRmQVZ0eTZqR1pTNEtMZjYxT0Zlamc0UnhJcVM3?=
 =?utf-8?B?enBPSmZpUEpjR3Q4QmszNnk3TmJPNlZ5M09lTi9keDRTc1ZnZitIYWZsOTlS?=
 =?utf-8?B?cE5oTjVHMU03RzYxcy9hU0tiR21YYmZaU0lmR3F4QUsrZVRHQkdma2dMb2FJ?=
 =?utf-8?B?TVBiVUZiSUJFaTNpckMva3J2Z3p4cnRONzBoZWRLdDZjZzlCc3ErTnVxajls?=
 =?utf-8?B?bUgyZ3F6UlNDeDZLamtFRkNnY3BiOWRleU9zZFpFTFIyajQvQVhmN0t3WTI2?=
 =?utf-8?B?TzY0aEVYbU9QT2RHK0c3bGh6cS9pbTV2UE8vU2h4U1VEb1VBOFAzMUZHWER5?=
 =?utf-8?B?S2RuQkRjS3ByanJMNHVpRk10VXRraXlEcUNRNVZnRGJyMzZiMjlaZXpBNDFT?=
 =?utf-8?B?YUtpYVNRRS9meFdYYUZEQndmd3YrWU1zSlhibllrMmVCVmZabUwxNzFPZG9I?=
 =?utf-8?B?MEhOejFLdlZZZU5kYWE2RmNYS1hydmVZU254bkJBbEdkeXpyVWlIK1ZUWWRl?=
 =?utf-8?B?eHQ3NURCQmRHcFFSTE5sMUUrTWJ0K1kwNTZIL1A1RFc5Sk5TUkQ2MFpBcWNX?=
 =?utf-8?B?S0FTWlFIM09jS2Q2RjFDVkpLSC9OYnBwRzZ0aDZEb2tFdDFPV0dCS25wRFBy?=
 =?utf-8?B?dmFmVWdYbHJoNk9UWUhEZmlKZmlENVZjSCt2TGlCMS92UmttdzRhYkdldjhp?=
 =?utf-8?B?d2lpdVF0bFRVUGtRempZbGduMWozK21HNkV3bFFPWW1nd0NJbi9ObjNvMW5Y?=
 =?utf-8?B?QlgwYXFqNFNPRWpEVVdidXFOKzhWdCtkQ2djaHgzVUEyNDFSU0RCaXJDMnh5?=
 =?utf-8?B?eG80UitiOU5ocm1tSnJ6eEYxRWZYQWVIL3c1cS9wRVFPM21WTE10bER0SVdC?=
 =?utf-8?B?VmlTOVY4R1ZxRWZvakpJS3BWa2plMWhhQyt0ZXBNNERxUFhONStVbEkvdWV0?=
 =?utf-8?B?dmkvMC9ieGVlYTg1eStxUTZrMjU2eVY4V0drakNub0NPNGcvQTRERUtIc0tm?=
 =?utf-8?B?am1qdVhDbXZKbWlpZzR5K1NQSk1JQnJhdFdwNGR2dTJHaTc5aFpFK2VpeDha?=
 =?utf-8?B?VGh2M1dVeHB6dnJaUVVaMHJNdVNkbitCamlEUjcyTzhSYU9FbE5zbXAvN3FL?=
 =?utf-8?B?MU9aRFdKNmxrKzhnYTdqNEZyZkNXZ3RZVTFRVEdzY0RVNU1vNEFqOW16SXZv?=
 =?utf-8?B?SGFOMnZVNW91MlpUamovN29JM1hRT25iYXJsV3BXdHBtUElVVzlEUENIWk0w?=
 =?utf-8?B?b3Z0Z0graE03SjlRdTZBSWlzWklYTmxhYjIxMTFZS0NDTzQ2WmhmMml4VVJy?=
 =?utf-8?B?RFdWUUNPSkRRZ2RSTGZLcklrYUJONG1wSVZWN0pHU2xLMm40d1M1U0ZVY2hR?=
 =?utf-8?B?MlFSWkVtS1BzR1FIYzg2QzZMSDI5T0FJYllBcWpKYW1TT3V3UXJMOUtVQnIx?=
 =?utf-8?B?aUZybG5mdlEvU1oxWlhsQ0NqRjd1ZWdYN1dSYlNpcFdzODZVOEVEVGxONkFw?=
 =?utf-8?B?MDFpbEo4Y2RWSTRUNkp1N3hGTXFFeUFJR3VFMUdwUXFMMURIWE43UW9MZm9V?=
 =?utf-8?B?TDBMaThQMFkybGNRZ1g5RlJXU0R1VmNXMnB5RHV0WEo5VlJJR3hPYkFFMWor?=
 =?utf-8?B?aU1zeVFqampXMnplNksvL3Q2OWVXNUY0RU1ORTIrOXlZVEpEOGxOVHhoSFZQ?=
 =?utf-8?B?MkVCUVRNbGlRbGZTcjBjTTRaTjhvYSs4R0M4cVM3K08yMGF1bUxhV1I5MG5h?=
 =?utf-8?B?eWp2aGFoRXZnRmxJNFk1UVIvZjM2R2luNlJKcmQ3SlFQbWZiMTJQY1dRMmly?=
 =?utf-8?B?SS8xYkYrUEFhRUd1Zms0Q2NCdTFTczI3b2pIZGYzOEhScUxqMlA1bExNV1Bz?=
 =?utf-8?Q?0ppINobdKMhE3vhSIa1UWkk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EVpE2o01kpzhya9KIQEcRB5eCLMCr0hzVJ8skvCnipcbQpq8fCM+c8v2Lk1sDm76WJKwrfzFV9bOu+7bB9kV/MWHqQmuNpJ48y38g7zkk890VfTfsk0Q7ZcX4BzLTo2l5i/8ah4+TOslzgwiBPhZtTAFh0pQ7ibDpKifkIYaOIcnJz+SdCSxXaxY18nkpOmv4Y7Q5Bc83WU86WFtlTz7SM7Rz8vUDuVNkjFiUEFGD/6uWBREHsTLrr3nHy8qDvTFIQM24w7druj9KcfJs3OvBh/qosU/WEkJrwndqKQmBpDmT6mON+JORmhqdj5Tg5pnQrMNvyrxx4tTDzgGGl2TNm0uk+UZZjAIh6zVUBVlIzFy+5PNmtgtmFNE8Qrm1FDQFQLtR7+6WN5x8QgL3kRmSfmLllq+AgV9OjrsrlGm5BuiZAvDkCLw3P9LZOTAp4lzYSD+tCzgEwQj+HB+QcRnoRrmstYQfSiCFG6JLBQSlaEra5dYs5SnWA9M6vl0oZGyM1iEyW7m5lrOOukg0UlEwraPnFBBkJSVjdP78o3a+eBs77VhJs+LfKsfK60yqq/bqJKQdTT62bK/ZSKr+0smjB69jySGxkMhJ/PXjAQqHHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ab8ffb-9e0c-469f-a7a1-08dc65002aa4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:17:37.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRNXy8n7hzz1QoRGupkZkbR3O2lonDMzBR4rJtmV34iRLpYHwVPAfTp6GIsANtZX+t13qm5/+Gnz+kHRLLzb6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_07,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250058
X-Proofpoint-ORIG-GUID: KaHZz2_r9ac9q3ez73Ud5cOXg5saVnKl
X-Proofpoint-GUID: KaHZz2_r9ac9q3ez73Ud5cOXg5saVnKl

On 24/04/2024 23:35, Yonghong Song wrote:
> Nick Desaulniers and Xin Liu separately reported that int type might
> have greater-than-16 byte size ([1] and [2]). More specifically, the
> reported int type sizes are 1024 and 64 bytes.
> 
> The libbpf and bpf program does not really support any int type greater
> than 16 bytes. Therefore, with current pahole, btf encoding will fail
> with greater-than-16 byte int types.
> 
> Since for now bpf does not support '> 16' bytes int type, the simplest
> way is to sanitize such types, similar to existing conditions like
> '!byte_sz' and 'byte_sz & (byte_sz - 1)'. This way, pahole won't
> call libbpf with an unsupported int type size. The patch [3] was
> proposed before. Now I resubmitted this patch as there are another
> failure due to the same issue.
> 
>   [1] https://github.com/libbpf/libbpf/pull/680
>   [2] https://lore.kernel.org/bpf/20240422144538.351722-1-liuxin350@huawei.com/
>   [3] https://lore.kernel.org/bpf/20230426055030.3743074-1-yhs@fb.com/
> 
> Cc: Xin Liu <liuxin350@huawei.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index e1e3529..19e9d90 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -393,7 +393,7 @@ static int32_t btf_encoder__add_base_type(struct btf_encoder *encoder, const str
>  	 * these non-regular int types to avoid libbpf/kernel complaints.
>  	 */
>  	byte_sz = BITS_ROUNDUP_BYTES(bt->bit_size);
> -	if (!byte_sz || (byte_sz & (byte_sz - 1))) {
> +	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16) {
>  		name = "__SANITIZED_FAKE_INT__";
>  		byte_sz = 4;
>  	}

