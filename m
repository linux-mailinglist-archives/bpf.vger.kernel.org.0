Return-Path: <bpf+bounces-79119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA210D27E07
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862DA3104104
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8163C0092;
	Thu, 15 Jan 2026 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cEyFLQ7Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eBuHApNW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70FB22E3E7
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502209; cv=fail; b=nwaSIbYCGDdzIaaNPnSyaEEERknKEnGeycsP07Wr4isR8IfpX6NGeazgpiReukcFuWOhV4WG1WQJoz4Xi1Yu9hTYDaPu6M6tLIJgEyJi199M5uh+0XmRwmzZRHRLvmlZxKUywbqUJmrLZ8K2QXHtLkW8RTFZqg410SapDpcGDh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502209; c=relaxed/simple;
	bh=7oPGAncSYpUrfjlkqk/+E5qx76SXychNY4+le7oj3q4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TXxz4x69e3q+uWAyDLG8bLen9K3dUtXICaETWmdq7DgpnSaR3lsVrbRHyhQuYsLHhApOl8ezDL8a2iHFdGACcmC6uZEIOTO8kUzX3hHrl+lmYJ8HklNW2dYxLI5kUFQfbvcCvs7SbhcxEksHN/qab7dvASv43I8pgdMI4/o7nOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cEyFLQ7Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eBuHApNW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FEAZMm1940271;
	Thu, 15 Jan 2026 18:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Y/BEH2SqLEVDyk5W/JkL8pTlQLAquLc7DdMp4yL6Q5A=; b=
	cEyFLQ7ZRFf56vlHebd7xzzi++dklWEBOVPJUl8zUVHwYQLCdLDh9ffCQxEoVyA+
	/tnwPOriuccw8Re9+BKK8I9fETldLRA7apT029IEqwc89n9SVv8FOGdDBHAPa/wK
	Jd6Hqji9ylkM6ymxfHUSQbn0QMWPOjo5sExvSuEgcT9EuKenpVFsKAdFZN6YlkdI
	YHWAw/IzQD5Z7RMspr+/FVXPpcTB4DOwnPW1Aa9AWSsp0xcRyN2a32yQw2TmoaP/
	Co/Dt7rwTjGwkwbry79uuzdybYYbZjOlAzm+fC1W9B5KGkDg8zkd0czpIrKHvjFb
	q72Ym/vAU4Ujh7n4mRRk6Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5p3bsr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 18:36:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60FIZQuJ029177;
	Thu, 15 Jan 2026 18:36:10 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7neac3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 18:36:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueskZCgQ4JvoIWDHZzO1QTsxYX0RlAIyEncIHJriJRbybeFB6lWCxuy0m5Qm4fhi7bb/ljGwQ/uTOC/8NC9/bbXomNP7rdWpC+O2T4hwsp+hciOfXN22f7dZix1VdOJa1B8ne9dQAS9WZezbiAkEeryQqh/tOu60Qt2dbXITy7dqsiW2o0ccUDqdlZwHtboTawrWAbG6X6ZrX5Fyhr8KhhcctflZvyXToFD+05tivdPssMqj+JdbLln2kOK/YM8+HQb73OR8NdoNwvlHjPtzJXsUzW4w+OHFDsRmhVzto0RCeBlcmp92zMBIsFq8WlwiLoSBJXMc1hbnK+n5hcKRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/BEH2SqLEVDyk5W/JkL8pTlQLAquLc7DdMp4yL6Q5A=;
 b=huIhvoC7l5errKIsfCTnShSWLtkLpNZQin7XuJNQiVm6AKSmQeG0m8B0GhwX7p0b+rMpprt5EOTQzU/Jn1TH7tRPP6yK2DUjttIMF3xZ4MpniKER+Dj62Ln9/60AP2nWjC0pc++gr9Pr/41aAddsj6iR7F5O2lxtLqboOPbSYkGmx1UctzRxSPebUyyFrbUWcijnxRM9Zyitk9DEh5cOzgrKfaBpgHrX4BPV57dKMBPeQ5EszHXFUjFdDZblU38BmoDydypbNvfS2c2jYOtMHQrNo4QC4P05fB8AXxTcsdhRmDjHAahD/XD+mde4yLMWOq0pE3KhpFnbP7IaqjVsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/BEH2SqLEVDyk5W/JkL8pTlQLAquLc7DdMp4yL6Q5A=;
 b=eBuHApNW0royo2cGJkWTfIeArVSYKfEVXVI1o0u9zqaB24TZNJo0h+802jM0AmLkvgkyklYZMuJLY6CLeklYVnpHRa5aDn1NvXTzF9iOvyteuGmt0BNDnh9zzuOJICdUy+fcjV1c2xe3mNbeUdWU7xW3E8ba0U3/HV7LqT708nE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ5PPFD6523AA75.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 18:36:07 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Thu, 15 Jan 2026
 18:36:07 +0000
Message-ID: <5886e8c8-7646-4686-91b7-185cc953be20@oracle.com>
Date: Thu, 15 Jan 2026 18:36:00 +0000
User-Agent: Mozilla Thunderbird
Subject: KCSCAN and duplicate types in BTF [was Re: [PATCH bpf v2 1/2] libbpf:
 BTF dedup should ignore modifiers in type equivalence checks)]
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, yonghong.song@linux.dev, nilay@linux.ibm.com,
        ast@kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, bvanassche@acm.org, bpf@vger.kernel.org,
        elver@google.com
References: <20260114183808.2946395-1-alan.maguire@oracle.com>
 <20260114183808.2946395-2-alan.maguire@oracle.com>
 <CAEf4BzZruKmtcwK+V_qT8RcaXpp3=GXaZaiQtK4OchSR8Ye4Yg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZruKmtcwK+V_qT8RcaXpp3=GXaZaiQtK4OchSR8Ye4Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ5PPFD6523AA75:EE_
X-MS-Office365-Filtering-Correlation-Id: 6489fe90-6f8a-41ed-8e63-08de5464f274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2wwelVuNGI1bkluMEVSeHdUdlVXNWlPamVDeStFdURTekp2cFVRWm0xMUZW?=
 =?utf-8?B?d08walcvdUpuWXdTNWdpOC9yTk05NldBT05zUVFlUVRQNHlTT0pEbkdkallX?=
 =?utf-8?B?dzVTQXhSVXFqRktxK04yU1VoelRKcEtTQ2tyV1VJQVF0VW5jR3VkbEpDaTlq?=
 =?utf-8?B?YnJRMUFocTdvczhyZEh3dTBPaitWWG1aZWo2SW9rTUVseWNJRG4xdWxINGZB?=
 =?utf-8?B?SW5RN0I4bTY3dEs5Y2tHRDA4dG84NzkrYS80dU1mZVdPMkh4Wk9icTV0WEVT?=
 =?utf-8?B?b29ESVZESXFQdmJoZ1o0NVBXMGFTa2VLWTNZcTZkbUkwTzZFTndqYWF4L1Ra?=
 =?utf-8?B?ZHV6Y3RoWHYya09wdkNMSkJrcVVmSTFsSnNHUzRKU2tsSURMYXpnNXlPVlZ3?=
 =?utf-8?B?d3d5aVU4RTM2S0xBQ0I1YzNWU3FsQTBONDV2M2t1djBCUlB2TUREUDQ3Zzdt?=
 =?utf-8?B?bkxUWUQ0SUZHT3VlMSszTncyeDU3c1B3Nm5jVVEwY1kxRmhxb1dnSWVMaW1y?=
 =?utf-8?B?d3lBdnJ4eGhKalZiK1Zhd0hYZy9kMWZudEV1a1JYaHBVbHJoT1pJaVFKNy9s?=
 =?utf-8?B?SlZreDJrWk9WeVNTekhJK2pFODY1RExQeFc1Vnk4NnV5ZE9XajlOQm9kVGdW?=
 =?utf-8?B?SlcrNlZlaWUxM0E5aHNhVDFOYzdWdFRianVYNWFJZ2hySW5VL0FEeC9aMzFn?=
 =?utf-8?B?M1dWS0tzbGhPUGZkWGJ0MU1jRGVhakNocFJSS2h3Z3NIK1VQZU9rV09JdnVD?=
 =?utf-8?B?c01TSldkZDFiNHN3MWFhTEdSbU5DRE5hR2lTaTdOUkp3eWlSd08xaHlTV1A0?=
 =?utf-8?B?L2JoUlkrRzY2dGg1T3JjWlRLaFI4ZHJDRGRiM1BQL3k3aHFDWUhWSldQVUt3?=
 =?utf-8?B?K3h4aktGOTJsTFhiY3YvcnpFQTIxMGpVblptaGJGOFpTZU11NW9qOXlzd1d6?=
 =?utf-8?B?WWozWXd4NVdVZGlPeUZnNHpQQ1pBK2FBaGpXLzlwNlFSdlZjS3VMZXNBM250?=
 =?utf-8?B?T1FtcFQ4MEQrem44L0UyTmRzVityems2MTJMZ1FQb2NHV3NDbzM2SXFqUURF?=
 =?utf-8?B?dndvUVRGM29nYUN6di8yVFJwZ2xhSWZxQXZnbCtlb1FGZTNFM2s1dWtGM1Yx?=
 =?utf-8?B?TFVWZThiWlVCaHVPUzRUNTZnNzhYREFMbDVPTWkrRmxvRE1BVlJGdnlvSVdI?=
 =?utf-8?B?VTBQOHByd2k1eitOTENzR3Z0QWRIb25kalFvRmxCcEQybm1lbkI2Q3piT2wv?=
 =?utf-8?B?Nklpeno2eXd6MnVGVFBoYVdpZkt4N0RnSGN3Rm96M0xIWnBMMVBJcGtLVGph?=
 =?utf-8?B?dG5VWHM2bEhNakhVM2U2cTRVY3RFb0ZRTVRwM0xwUEhQdUpKS3RTQ054TlpR?=
 =?utf-8?B?MUFRU05Mckw0WHFsVlkvWTZHaVIrSkd2c2ZlZGdkL3dSTEFGcHlQc1VBWXdj?=
 =?utf-8?B?NGs5T3dQZnJjUlA5Nm50eDlpNDZUV2cxUklmN0RtaHlMdXNrYy9tVUZ2NWVI?=
 =?utf-8?B?cEd0V1FPclJJQ1k4ejZnUFVjZE9NT29qK09nK1hkcXUrZnNYK2x4UE5xSUF4?=
 =?utf-8?B?Ync3ZnhQTWdLRnVYek1Gb2xqUUVteWRPTEhRbUg3K0tSWjFzNWRhRWtkdlJJ?=
 =?utf-8?B?YXNnV1VIbW5xb09ZcStJNTZHaFE5U25LM3p4bFlQWHRmakozbHJuOFR3ZGpX?=
 =?utf-8?B?eTFOa0kxTHEvemliWTlNNTdneVdiWHZaNkZGK2pPelY5TDZMSWNpVTNaclNr?=
 =?utf-8?B?cGo1OXNDUUNidTZQUmhreHIwN3ppTzFwWSs4bWI5d0tZSFl2azV2SVNibGps?=
 =?utf-8?B?bmpLZ0JnN1M2N3BHOG01dU1CVzBPNlRIZkVabnVzUFlxM0NYMFFBa2huNG5C?=
 =?utf-8?B?eGJRU1hMOFpCNUU5UnoxMWM4ME9GTk9nWnd6UGhvK29MbmdkQzdDMTlQNnJ3?=
 =?utf-8?B?R1h1c29ibHNXTTZXN3N0K09pYUw5M1ZzeDdFamxnSm5HZXJST083TXRZMFlI?=
 =?utf-8?B?cUF1allOQzdSaUNibWdKUjhicU9oM2F5QXFvV0N0VVdxQ2tzdzBTRXZsckdu?=
 =?utf-8?B?bWJQSjNoUDRTYTNSdE93RnpTd1NBb2M5MVFhSzJSbW80aWcwMFZrT0VsSmdv?=
 =?utf-8?Q?EZlY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkJOZnRMSTJoZkE1SXkyNlJZd2FnWFZWY0JEQ3dPSmZzeFFla2JrNHQzQWhD?=
 =?utf-8?B?TUh5UkU0N0s0T0g5TDArRTloaXJodVlWNS95OG9jcFRncjFKRnRWQkxiZDVh?=
 =?utf-8?B?VXVjazlMUjR5N3RIcEtMM3RwOVZNYndUMjlvYkdZZUhDeVdCY2FZblNzb3RH?=
 =?utf-8?B?bXJra052cTA5a21IbnNnd3NmTHB6SGk0RzJKMjdoOW9laDZoR3ZxMnFvMFBn?=
 =?utf-8?B?Z25FdFAzNHBUYVc2dUg2QVBjMk1yQmRqOE5nZ2hLVHVVMnhNd0h3bGxmMWt1?=
 =?utf-8?B?dlZPcEd6SHZkNnhZaFJ2eXQxMWN0QjR0dlR4UjBhZVpKTCtJTGxYTmU2eEtR?=
 =?utf-8?B?akovMlFkTEhPTTM3WjZIOHEyYVVtU0Q4Z0dla283aTVvNk9qL0Fac0Q4S256?=
 =?utf-8?B?eCtyamo5dXV4MjFtbHVXc3d0S1RxVTdvT1FaejUvMFM4ejc4YndmOTBxVm5S?=
 =?utf-8?B?M3krS0Zrb2doNTBrUG5GRzBVbWRQRkM2S1p2bmUxVktiN01DVzltZGNhR1hO?=
 =?utf-8?B?TWx3eTFzb29XYTlCbWcrU3lOSm5hWk1GWDE0V3RnQ3ZpcVpMVU1ORXlTSURK?=
 =?utf-8?B?NHJUcmgrbW1tcnU0ZUFISlplQjNPejJiQ1YvRkxnZEtwL2RyYitVSjlEZmlP?=
 =?utf-8?B?azhmV1B5SG1VUDRDR2hCakhqVTBrVzZHYU8wSVpCbVpvL21ONXpGRFU1Z0k3?=
 =?utf-8?B?Z0Y2Njh1emFBTkJDS1lIUHE1UmlGaDl5b2ErUS96WG1td2J3amN6WFBKbERR?=
 =?utf-8?B?RmkrSXIvdG5mY29TUk1NbXNUOTl5SHpKbXNwQkFINGllTW9GTVFLWHlESnh3?=
 =?utf-8?B?N2dKYjltamZaekpIQSsrdnkxL0JXMUh6SUNLT0dSbklTbTliRmh4NFdRakhV?=
 =?utf-8?B?L0NQbjFoSEtYQ3NicENqOHRWUTdvdncra2lSUkdOL21MVnBibTNZTm5WL2tY?=
 =?utf-8?B?dVRpZ3dEN3E1Q3VPaE14Tk9hMXJhYUQrOG5BQ1pIODI0OXEvWHB4UHQ1Smtt?=
 =?utf-8?B?aHNKZHJiL1hNRFJac0J1S1loZVljVStFOGpvdWhuOU13UW5rTVN6UENPMjY3?=
 =?utf-8?B?UEt3ZWhpZmR3N2dvSExLSFdaQWQrY0ptck5VMHJpaS9adnBzUEtQSUhZbUdz?=
 =?utf-8?B?aWMzUUNEM3hhNE9MZ05HQW5pZThaOGI2TWtnZTdyc0VZWEJNWnRVekltelZD?=
 =?utf-8?B?ZkFiWUVHSjIwU3B1M21Ea0hMUGgwV21UQjFqNEdmL09lTEZPQzBlOEt0R0M4?=
 =?utf-8?B?YXNjazZtQW02MkwyZkk3OFpUK254Zzl1cmxvS2RIajluN1h2b3NhR2ZneXRu?=
 =?utf-8?B?U25Od3ZQWWFUdDROQmpNd1hUL2tweC9nSDJaU3Z3SWxuclFGOEM0OVhVSVFK?=
 =?utf-8?B?NXQvb1NNdHdjZFFvVXVPajF4Sm16U2JxZnQ3ekpKOGtPN1d1R0dKSXgvdGlh?=
 =?utf-8?B?ZC9xak12UUdVNUIrUUdVYWRiM1dVNU1XeWc4ZmJPb3JCVnZUTEpOZXBqa1ND?=
 =?utf-8?B?ZHUyeEhEdVo0R3laa1FxVEI1TDN6ZTZLNmlDd0dNYmhjVzQxaFR1dlpIRE8w?=
 =?utf-8?B?Q1gyWFRmL1JwZ1VwNE9BQzJlbjVLOS8rc3VYSUlVTUw4UzBXQkZiMkNtL3Q1?=
 =?utf-8?B?WmF4UjdZRTh3YkUzRkp3TFlIOFZOT3prTFRLVjdjU0xLMXdacmx4ZGRrc2hj?=
 =?utf-8?B?Z1k0Y055UXNteGVmZTFGWkROTXNJeHhLd2I0bTlraldxWGRCeFQ0K05BU09h?=
 =?utf-8?B?QUw1SzNTZ1JvL3B0OVZmL0JNWlNJMWhldlVNcTd1RGttVTJZNXNvSXRWZGRa?=
 =?utf-8?B?RFZaTHIzUlhNYWI1WVgrQStndTRQRUtkakhKZnJ3Yk91a3VQOEhvdVBnRGho?=
 =?utf-8?B?cVBXRDVpbHlpNXFVYmxuNFlleGVrTTN6aUpsZklZcktBUXNwZThBVjdLRUVM?=
 =?utf-8?B?bk1XSExEVVJVa3o2Qjg3ZzJtTXJ2alN5SzgvcmlnT3BOY0tDTFA5RWFyNUMy?=
 =?utf-8?B?bWcrMEtpa3dRNDhtcy9YNmd3S0gwSzV1YUJ6RXdFMEsyM0YwR2xZL2krTEZZ?=
 =?utf-8?B?U2R0S1ZoRHRCL0w5YnkxaHZTeW1KaFcrVURvVzJRL3NQdCs5NWN4SkdoaVVB?=
 =?utf-8?B?dnhyMkdBK3E4RkJsOEk4N2pzMjNpUysxM2xzSytHQWFYcEJ4U3h1Q3pVeDJP?=
 =?utf-8?B?Zyt3eU84ZjB2eWVjK3FlVEw3OHhhTEVpWjBTaTZoY2VMRmZsajNpbHZ3ZUg3?=
 =?utf-8?B?elZXZUwxY1o5eVArUEV4Vm1xZlFqN2o0c0Ezb1BzM091K0Z3dEMvSmN6bXdv?=
 =?utf-8?B?SjlZajJYMjVQM2xEaS91WFlYRFk5N241WGhqTmFJQmxKK25QampjUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hsQDVH3WHmj0y5eyMaXjv0auqQ3turcG4RXFkbAyWyycqbWJn30t3gheYf3EN5Px59mcEw0c4eJEsZ0v/cFXqzdKvNed0F04ucnZMeOkiv0VLRcDTNLLkqvrMTEkj1WsVVFdC8+6M0SZNGLW8Am7nmDL91r+imhuwALl2GyCmQu7YUNw4I5c0h4LAnO3kAmSeT7ZEW1pspHkbpp8igcVGqhYTtWllnYXy6gR+JPt4TjH5biy68aPENmIzO/t8Sp6qIRpwrBOAxOCzxKUlqAwyvIicVJ/vKkPcWd4Ep6MPAMT5hTjaDJSSIZ1A6+6j8XxWRjB4EqUHcTSJ1xHph7bF6OBhLWp+bybnm/vYKMS5mjUMyblR+Kjh2j1jFkSTlPzRXakaNUPUA3EHbo7prFs4cy8phYm54s5nIiqaNRzYrYpcN1abEyNOpxqjYRAQs8iGvD+Ah7vf75DisAfShO2vXJsxihQwB0k875sxBAU73UcyijPtBcLfhbeqGlg5D2LP2oasGybVDj6BDYMstsP3YtdEWTJaPBpGgrCmHp28hnFFhSeOuPAdDy8Zz77Tb6oneNK3Lx2Y1Bdi+VnQY4oyK9nntfbiAB//jTJ/dG9o7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6489fe90-6f8a-41ed-8e63-08de5464f274
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 18:36:07.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We45pe6rRkN0+4Nt6YVQXZnDRnkAoxpvR7ZPfgdeEmYY20T6clSqaWsVrnVI/JycYA96d6+QJQ4mHCeFVVI7HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD6523AA75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601150143
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=6969339b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=kmlzkPCy2PKM1FkJE5cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: cn9vvyEGE4lXZ59asKbNWD6Cv-s4FTvT
X-Proofpoint-GUID: cn9vvyEGE4lXZ59asKbNWD6Cv-s4FTvT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE0NCBTYWx0ZWRfXypN5O/hFTkDe
 iMqTQNjtDqIth2DSqo+ldBXUquvkT9oZx3dEXm5GpYfve0+eCbidXzbmAhNRMLm0mAVdjD9bvmR
 CcLqLqopTB+tlX24keoXnPsKhBpGVInTo4+fEceNSVAtDnKq4b6p2Z3uvaj6iAIFDiQ4Cnap9LE
 uUsty/pVbO1o1Hbigtncdn6cpKJdVyYXnLxcqlDakh4nLqgC5PC8U/8UQooN5FIpV0sUrOnS6qH
 jxSsKhu1LYhJa/P52AJQzeQR9pYaOgsdG6l7fZsojeUMCqVL6LzvYePlYuAnClspctbSuG04hBm
 K14vCs/fQyWnyrxnUi4bRCcQNy2NDaNNT56GePbhGlvnbavrYjlgKtes2nIXqhxosKziezjIxD+
 JP/QfZFvry7LDQ2fhGWIAaQcJ1JIJfH5oSGPEUs/q6zExOM1F23taQWDSlzDoOfuKQGA4Dh8XdU
 hkeUIPpSzzQ6Ot0xgAP3k/bCNcRvSlqFr6G6DWc8=

On 15/01/2026 17:50, Andrii Nakryiko wrote:
> On Wed, Jan 14, 2026 at 10:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> We see identical type problems in [1] as a result of an occasionally
>> applied volatile modifier to kernel data structures. Such things can
>> result from different header include patterns, explicit Makefile
>> rules, and in the KCSAN case compiler flags.  As a result consider
>> types with modifiers const, volatile and restrict as equivalent
>> for dedup equivalence testing purposes.
>>
>> Type tag is excluded from modifier equivalence as it would be possible
>> we would end up with the type without the type tag annotations in the
>> final BTF, which could potentially lead to information loss.
>>
>> Importantly we do not update the hypothetical map for matching types;
>> this allows us to match in both directions where the canonical has
>> the modifier _and_ when it does not.  This bidirectional matching is
>> important because in some cases we need to favour the modifier,
>> and in other cases not.  Consider split BTF; if the base BTF has
>> a struct containing a type without modifier and the split has the
>> modifier, we want to deduplicate and have base type as canonical.
>> Also if a type has a mix of modifier and non-modifier qualified
>> types we want it to deduplicate against a possibly different mix.
>> See the following selftest for examples of these cases.
>>
>> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/
>>
>> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++---------
>>  1 file changed, 26 insertions(+), 9 deletions(-)
>>
> 
> Alan,
> 
> I do not like this approach and I do not want to teach BTF dedup to
> ignore random volatiles. Let's either work with KCSAN folks to fix
> __data_racy discrepancy or add some option to pahole to strip
> volatiles (but not by default, only if KCSAN is enabled in Kconfig)
> before dedup (and thus we can't do that in resolve_btfids,
> unfortunately; it has to go into pahole).
>

Okay, I think the former would be the better path if possible; cc'ed Marco
who introduced __data_racy with commit 

31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifier")


...and Bart is already on the cc list. Feel free to include anyone
else who might be able to help here.

The background here is that in generating BPF Type Format (BTF)
info for kernels we are hitting a problem since a few structures
use __data_racy annotations for fields and these structures are compiled 
into both KCSAN and non-KCSAN objects. The result is some have a volatile
modifier and some do not, and we wind up with a bunch of duplicated
core kernel data structures as a result of the differences, and this
creates problems for BTF generation.

Perhaps one way out of this would be to have an unconditional __data_racy
definition specific for struct fields

#define __data_racy_field	volatile

...and use it for the two cases below?

By having that defined regardless of whether KCSAN was enabled or not,
and using it for struct fields (while leaving variables intact) we
can sidestep the problem from the BTF side. Would that work from the
KCSAN side and for the fields in question in general?

> Furthermore, it seems like __data_racy is meant to be used with
> *variables*, not as part of *field* declaration ([0]), so perhaps it
> was a mistake to add those to fields. Note, there are just *TWO*
> fields with __data_racy:
> 
> include/linux/blkdev.h
> 498:    unsigned int __data_racy rq_timeout;
> 
> include/linux/backing-dev-defs.h
> 174:    unsigned long __data_racy ra_pages;
> 

Not sure, the original commit above gives a struct field annotation
as an example. Anyway hopefully we can find a workable solution.

Alan

