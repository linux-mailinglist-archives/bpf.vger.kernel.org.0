Return-Path: <bpf+bounces-29164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDBA8C0C79
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 10:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947292812E1
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 08:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E590149DFD;
	Thu,  9 May 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OgHQS8jr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PsWdltUl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD912D76E;
	Thu,  9 May 2024 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242879; cv=fail; b=q62RfxcCKIz9bRdVHwz+nERDNFyE6rqxbWVpgAjZlOTYwhKTD2uFJeTvsTjNXyKGI+S1yuhoBErpsdOtgB53no6vdXynt9UEFLGLhGyi0wSxlGZP4eTfK2edhNZCTz/uMbzY53JZtnPO7c+MImTZlLRzYbXOZHrRpEVyxvHaD3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242879; c=relaxed/simple;
	bh=/xK2Aknbd30KzMMrpFRCtWjNd0y8wPs7JsDBJprhqAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cMoPTFEvHAA3RR63gwl276YYPOygBs9h+PiQ0hwC/gM8I2x6iEx/v/Y+LP6GK8a3y//RuatMJdYtbdOK4WA5V8Er2H5crGROVW/5u8Iy9ytRPTdlVU60Jsl4uHeZUM2l6FWUScQeTmkxf+DH61ScqQcu+OjFag00GaMxwD2LBw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OgHQS8jr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PsWdltUl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4496o6ab015303;
	Thu, 9 May 2024 08:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4+Bwqr19apQEM6yWncn6Vvg8h42jJMwQnYkdc4So90E=;
 b=OgHQS8jrVRppq7F533P9KmjqKP6D/0cK7deCtlVgfW9NvOddujRmdkTqJFwXFXdHwoU3
 Bb05G3x4zxxN3yash+e7O9jSdKekY1jSleO7+4t//UhgOvOFAMHrMYXUPyiwhIpB7Jtm
 pY7Qi35IPe2faKfVaIPa8ZJB9Q24Tywe3P7yHaJtoM/EdItY/hQYJoi7ct93v54mr/Ql
 TkVN3SW7YyhIFcRmKMxxUoayehSbXUuEuQUDumYcox/f2u54bj3L1GwyFt5ettNZpPTH
 7Rnc+/b/C2IfYDgljluVvoDLQ15juZV5cwkaOAhIqRIf/Gx0Nk3Adw7yJyKrZ3HeC3eZ sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y0r248aya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 08:18:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4497gLra023582;
	Thu, 9 May 2024 08:18:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpewv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 08:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdabBSX9IPpLTm4Ko7sYxTKUeaik/8bVLpgB/tUCGRi/r7vT50Ba5GrYsIU44FBkwVVZkJ7IBDhv9bfEfhVZ8GWKCM4Akaby7Cz+da3GguSsh4wa3nh89fgpArFxE2KddXjR/80hRe2gZOCZHOwQBEyKf78AfdOXShht7WeFtcBiG6dDz+LjuTbZuguBA7lGO7ajJeGe98pGDGaTLwa+t9O21IP6XUKB/12EfBtmKj2mRangPYy5jkWgi6gGUAPq9VNCIuzMjLwtKBOSzrDXvmH/GMVXIDPpp8e0cGbU5Xze2kqXGEuDS09KEOIRnzBpiK5thQGK+c2YU2HBMhD4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+Bwqr19apQEM6yWncn6Vvg8h42jJMwQnYkdc4So90E=;
 b=etn/7F5B9SE5j5YKxbw3r5bu3ph+Zo29f7xBHgIUlJ6+3swTRy25xCMV2wG2M8aON6y80GdPiVflMAVwqWp8rBgF6rO49sjer2oUggu1d+DyTXW/7WPKzYHBdYUgoE4RtA8bQpV9jEnz61DhY9Lr3ey/KA/qp5pZDePcJQXJby4fIabzOJ4sL05OjuNRx5t3xWqcwpducoaMfKzSsEI4oUFPAxqLsRdRcxLR89Wq/UjySM7oQL4Eq1/DrpuXHv4q4W0VyDFTp+W0mirLCYXp57EXyxY7shYW2ND1iUJFMifCvBg0N2a0QUKLyRkvSXGS7rXTREJ66o3HcvoL8WCP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+Bwqr19apQEM6yWncn6Vvg8h42jJMwQnYkdc4So90E=;
 b=PsWdltUlOX0uwOMsbUlXMPpPSMJGwRxVBVXjLcgRvkXVHtNAkheY4/+pIKrQhHVRa4KR2BI5STpR6WkGmG+9gtUS/YngtZYFZad38XINJMwKyRHrcuklBQmPXgMe1hf3rlfq3DfWS57xGyBe9Q8by9WoaFrXSlhs43yw553mn+g=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 08:18:50 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::e3d6:7cc9:9c51:b011]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::e3d6:7cc9:9c51:b011%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 08:18:50 +0000
Message-ID: <339b9430-145f-402a-a93c-8440797c98a4@oracle.com>
Date: Thu, 9 May 2024 09:18:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next] kbuild,bpf: switch to using --btf_features
 for pahole v1.26 and later
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, eddyz87@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20240507135514.490467-1-alan.maguire@oracle.com>
 <CAEf4BzbWANm+Bf63hcFAB3Tn51tOeBLhyabV3NNz8tjaMnThjg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzbWANm+Bf63hcFAB3Tn51tOeBLhyabV3NNz8tjaMnThjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:208:256::32) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c1b7d6-720e-4f1b-b4f5-08dc7000a818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YU40UGo3T3BnMU1qY1hocml2OVRrUDVWZXpueUxET3hSY3M0cWR3RHdVMXpl?=
 =?utf-8?B?YVRwY3hEdnZYekt4R3k4VWFVN2d0TGRMWnZoTUhoOTJTV0lCcU1COEp2Rjlw?=
 =?utf-8?B?dzhGcHkvSk1kM1RIdHJseDBKVG9iK0gxV0hDekJ3ZjQzdzJPUVZOSFM0SVpx?=
 =?utf-8?B?enVhZWtma1h4d240dGF2TU5CSEtxanJsM1lzbGpnVVRKM2xybFZMb012VTY3?=
 =?utf-8?B?aVVOVTVmaWlaeDdRR1htWmRtSm8vZFpMbkNNTjd4a2lqcElFMVNKTUQ5Zy9t?=
 =?utf-8?B?U0pCK3p3eHdDOWFuUUp0a2k1ei9mSEQxZ2hpM0F0WlU5aDAreFZhYUFrQ2tp?=
 =?utf-8?B?ZUVuTHp6ZktIOXFYYXlqTWptd01oMGpwVHBjSUN5anVjMHM0bU1jaEVZckhV?=
 =?utf-8?B?NHFCL2FON2lXZHB1SHQrNFJ6VU9ybGN3aXVmbzdzUkh1NVRveUI5elJlN0ZP?=
 =?utf-8?B?VExaVzJHUTJSOFZycHFUamdDUmJoMHNQTG9HUjg4S21CTlpJeFdsVXFCQ2Fy?=
 =?utf-8?B?Y1gwelJBd0RRNVd3cHhJSjVOOEg4anpoaytnSWxDaHBuVHBPMHZISmJTaHBW?=
 =?utf-8?B?WnlLSVI2d3E3bWtyUmExUTB4MEc5TkFoZXZNb0lKOWhkZ2tKN2NQSHEybFEz?=
 =?utf-8?B?QWo3YXJtTTJmdEVOTG9GNWgwdG4xaXM1NDdyb1I3SXNZeEFrZ29zRnRWZFJq?=
 =?utf-8?B?UGNDSEQrdmlHeTNOSXEyRHVFcENpSlNaTGlleU5ESmwxRXRDdDdOK1JTNTRr?=
 =?utf-8?B?SGlxOTVQSVBudFFybXhEL2lHa3FicjFISjIzSXFuNWQxU2t1dE5SbUVuando?=
 =?utf-8?B?cCtHWjFXM2pvY05mTE1TclVTV0pkRnZ1aTZyVlhWVmZORVpwbkl3ZUppcGFm?=
 =?utf-8?B?NnBVMUdXLzFoT2ZqYXJWdkFMNG93YS96Tk5zaWJPcnVRZHhzWi9HV0NQa1Zn?=
 =?utf-8?B?SitkRVFsSnl6emczQ3pmZ3hWTTBGbk95VVFWbGdkY01rZ1BVUkIrRGEzNW1j?=
 =?utf-8?B?djRGNmdxRlJsV0tRSkF5RVludlh3bDVEVytoRUl6cWZlU0pvenQyUHNNTWhV?=
 =?utf-8?B?UkducVNvRTJOMlZTQ0RpSG81akJuNmYxYTNJMGVvQzhyQlREK0NiOVBndWhh?=
 =?utf-8?B?TW9wNEk0UjN1L1FSaHdZOVRJVVJnMVFrcURHamE3elFSaEJ6cllSVGRTVFEw?=
 =?utf-8?B?VjNXUHVTbmEzZW1Gd3BVamVyR3o1RWFxaWdEN05QdmxTMWpObTdRV0FMUEhQ?=
 =?utf-8?B?WmtCK20wMk1MQmt3cGhvNmpPZFI5bWoxY01ueFFvNFpMR0VmQnhoVWUyamlQ?=
 =?utf-8?B?aEdGK3hRU1JmTk9DNE9UbVc1YUxkRFYwcUJwL0JJSWRmVE1VV3ZwR3JMZDFu?=
 =?utf-8?B?MDJUcnRtd3BOSmVPOEJJZENWb2t2SUMwbm14bFF3YWM5ZXB4OEZMeW9ma0ov?=
 =?utf-8?B?c2pTR1hnQlpNRDJaWmNmQjlYcndnL0V2M0oxNThlRnFqeC9ZTHljSWtaVkN5?=
 =?utf-8?B?VzNuMzlYdXJ6WnJOV2k5M3dkeWFzVUtIbi91dEFqSHExc0c1VjE1Y0lYUUF5?=
 =?utf-8?B?anRINVkycXRqdmlBcDBQUTF0R2tsdFNFK3JILzMrL04xUkw4T1RCbzhBSUdR?=
 =?utf-8?B?UGV0amhXSzNoekxsdmVmT0NUU1gxbXNwV2tpT1hOdHR6VlBpbUNxUmlkZjIr?=
 =?utf-8?B?anBtdUcva2lHWjRUVmtFbHh1WjJtYml1dDFCMHZIVk1pak9zK1RRVXdnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDV3WTFZTG1BbC9mQnFCd3NoeTFxMFY4MXFxanBFSXk2WU1peVkyQnRYdlFn?=
 =?utf-8?B?QS9pUU5GWGZSMytUMTYrdUZIZEIrREdiTStVbEFYZ2NRZ3hlYll4cHZpMk9m?=
 =?utf-8?B?T2JNSzc5S01vMVpZTVZZYWhaMXZTL0FaUDdPNVRoaWRYT0YzNGpnZzl3SGxQ?=
 =?utf-8?B?TEVmTzErYVhpUUZqbWk5TWRlZnNsanVmblBsOFBwcThPTHhja3hEMEJHMlVF?=
 =?utf-8?B?YlNlelpMOEdBZTdKS1g4eWphUm1wRWtEakNpSEVsRGdtWmFnM3d6SnNaMXBD?=
 =?utf-8?B?OGFlb1RwUm5Kd1ErdzJ0R2xOZHpVMFpxdzk4NysyaXYwNm5GREdkR2V6UnU0?=
 =?utf-8?B?eXZISEtwRUdVcFlvN2RpZ0lUYlp0bnk4T1F4ZkJreElKMlRWV0x6NGk4SThI?=
 =?utf-8?B?dnYwVEhYYjhHRitIKzVlVytyd2RrcnZMOHUrT25zMC9CQ0w5S3dtbHhYM0ts?=
 =?utf-8?B?SW5hRXRUeXdSZTROcmR0dHdDQkdRSk4vV2VITkJlSU5oMjBTVHphZlFENFlW?=
 =?utf-8?B?aFlNN2pHWHY1YmVEUnR5QXE1SzBJcDMvVVVJZ3hsL3VhK1p6VzlhU2UwYVpx?=
 =?utf-8?B?ZVk4SmNWaTg1UktJMlR4TkFoZzcvK3cyNTlrTVF2OFhRS3RWMmlqVElKVW1J?=
 =?utf-8?B?MDlHTGVrWVkrYjNGN0xmOXd2b2RRcjNtRys0TDg3VHRvamM1cWVTVkZOZ0N3?=
 =?utf-8?B?SC82RjlwUFJzVlJVQTVRNmlmOHlXdHR1a0l4amFqK1NUMnUwRDFRdlp1aTZt?=
 =?utf-8?B?ZE5CWG9hSDF2amcyaVp0M2RFVFdSWUJRWkRqUThXRjQ0azl3dGtvdmpQQ0t3?=
 =?utf-8?B?QmE0NXhoREFBR2FOYUY4MHFxSmVRZU1RSk1HTmRSY0xFamVIeFZxZjZJZHc5?=
 =?utf-8?B?MXFvdkpWOGdlSWV3RFI2YmczMHpTazdkbE5wRkVpTEtrUVI1WVRPRGdFOFFO?=
 =?utf-8?B?TzBhU0I2R05VLyt0QyszTU82a3l1VlJweEpSM3VMaXZaQjFXdTZ4S0MyVXI0?=
 =?utf-8?B?TkF0VmIyOXA2S1g4M0s1aW9xdmw2b0hLTVFVZ3FTaTl6VERhL3BKa1FWUE4w?=
 =?utf-8?B?dUJJbUthNzl6V0cydThmaDJWb3lDTU9TaWFoN3E0R0x6RzU3cVVDcTFXdzIr?=
 =?utf-8?B?NEorcDF4Rm5jcTlreElEOFdDVFNEWjdZYU1FeE11VUpFMENzaEladlJjUkdT?=
 =?utf-8?B?UTNjTk5YZEd6YzFUOVg5OWZzekFDYTRiejZQTWdUVEppVUNTbDJtL1FJMkNt?=
 =?utf-8?B?RzRPRE52U2FUVzN0dEpGV2tDU3pCMVhvUlFnSFpmOG5kL3pFajBLUmtrRGIx?=
 =?utf-8?B?YVdvMElWamZVazVITEtRZDVMMHZmZVM5ZHhjUC8vUzlyQUFaUWUxU09CMWRY?=
 =?utf-8?B?c1U5TkpNNjRURmx1SnlwbURCK1FUbkZ4Y3N4RmlySjdVM3ZnUTRsK1BvSnpR?=
 =?utf-8?B?TVZTTTlRZDQ3OEZPTU85U1RWaTBzZUt6OExqalFpQzQ0cEhCcWN4diszYWRI?=
 =?utf-8?B?RG1ySEJqSDc5YnkycDcvdWdwVjVFRFRUNzYxdTUwdG1jNFJEandodThPWWhs?=
 =?utf-8?B?U2tKa0w1WElXNHRCaHlMSVBzNzd4aHhmZXZ2Z1lFUTR3Nk1tMEt1TThiQm1F?=
 =?utf-8?B?dUEySDg3N0trV0NoU2xBL05NSDZtYy9LbVJPZGJ2dFgxUFBydGJsZGhLdnhU?=
 =?utf-8?B?cGQvTm5LN1dIQ0xNajRDWGUyaGY0R1ZwZldFZ3R5T040WDZJTnZlN24yenBU?=
 =?utf-8?B?eElrZXZweUEyaXZHN3NIY3RaRmVQbllrUzVRWkpnMXlxSTdUdnB5bjA1bGZL?=
 =?utf-8?B?MUtVVUpyWi9KTURMN0dHWXNud1hVRUdSRHdmZG1JdGRhcXVFdlVDVXRVV1NI?=
 =?utf-8?B?Q3EzNXpHV2ZUbVhBelFVUzgveVppRGdrZWI3dnVub2UwNmV3ekpSaXFkQU1n?=
 =?utf-8?B?RnFTWWp3VFdtNUFKeU9yVXBIRDRPd1YrTDU1OFhud0hnWUV6VDFqM1hWOW94?=
 =?utf-8?B?SGxZV0Z3eENuVFlMV0w3TDMwNngxZnB6dDFwcGdQM2JJMlM0cHZ2QStheVZH?=
 =?utf-8?B?S0dXUFdJUm1QK0l0elpzeldtSkJ2eXc2eTU0Mk5HMHk3SHpkYTljTHYyQnZL?=
 =?utf-8?B?QUw0VklnSW84RUdRenhseUtxbnVIYm1DdXpwMzc2dXpzdWVxcHQrTS8xMHRi?=
 =?utf-8?Q?hgkSjrUCDWCAn9h4LDFNZgY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6ZdjsM0+jO5y00xyjWmMhWBbR3L61ilfMpMOPu+a/19wlh8NeX9xUoXLAuPknZJ7lcFJCYIOrhfT9yXkDBhr6GRyozYus+VP7VdQDQJqFyep0DFTeSEjkdzzNoKBxxFTWnCYd+dwwo98XoH/ud61yNGwFn9ed3m5WVvUfcGPSgj4vaCsCCj2wX3We0d8/Wm2nQIKZIvg5fwNyoVD1Bq3j909ilQcIUKo160Kkd0NZYLbyDV86h97LpHrfjeVUmxRaUBSRm2ncwkxJ7tLAUS6GA2vJIfKX86ehsrnXL/QNJ+sEqyGiKvku6gYiml/yNIvsRHeUhulSvm5zg+pUQNnkeYVOSS7Tf3DcvAGy1pLUH/OJHOaftt0jm4hA/Z3oRKqOoC9fYMRFTuizLYgbKRDeJfc3uYA41pKhCJtV6xmb9pOsRO89QWXAYek4ikzedPiAIHXqW74FxvZeQEfdvwCkIQU8Gd9sYWekvL9F6KhluObpijSvnFO/E7hUQusIcG6mGSSj1mzYxVAPoqUM2IsHjuMDp87NzPeq0nGY6Noyi15oQ3q7ZlCNokRmSsybk76Fr0er7ipzua+YBiihp8ZcSOAYxxWsfSemKPAra/u/zI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c1b7d6-720e-4f1b-b4f5-08dc7000a818
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 08:18:50.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6zuOHhojCOpOfJW7PUkoYgKOvD90jSC76+E1PBJDA65MGeAhSuMg6QRe8lJgsDqXzWvxLrmicjIlOs64ShlZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_04,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405090054
X-Proofpoint-GUID: 24DhZTBLiVkWpv2VO7G4QsWoFFeOhtpw
X-Proofpoint-ORIG-GUID: 24DhZTBLiVkWpv2VO7G4QsWoFFeOhtpw

On 07/05/2024 17:48, Andrii Nakryiko wrote:
> On Tue, May 7, 2024 at 6:55 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> The btf_features list can be used for pahole v1.26 and later -
>> it is useful because if a feature is not yet implemented it will
>> not exit with a failure message.  This will allow us to add feature
>> requests to the pahole options without having to check pahole versions
>> in future; if the version of pahole supports the feature it will be
>> added.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
>> ---
>>  scripts/Makefile.btf | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index 82377e470aed..2d6e5ed9081e 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -3,6 +3,8 @@
>>  pahole-ver := $(CONFIG_PAHOLE_VERSION)
>>  pahole-flags-y :=
>>
>> +ifeq ($(call test-le, $(pahole-ver), 125),y)
>> +
>>  # pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
>>  ifeq ($(call test-le, $(pahole-ver), 121),y)
>>  pahole-flags-$(call test-ge, $(pahole-ver), 118)       += --skip_encoding_btf_vars
>> @@ -12,8 +14,17 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)     += --btf_gen_floats
>>
>>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       += -j
>>
>> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         += --lang_exclude=rust
>> +ifeq ($(pahole-ver), 125)
> 
> it's a bit of a scope creep, but isn't it strange that we don't have
> test-eq and have to work-around that with more verbose constructs?

Looking at the history, I _think_ the concern that motivated the numeric
comparison constructs was the shell process fork required for numeric
comparisons. In the equality case, ifeq would work for both strings and
numeric values. Adding a test-eq (in a similar form to test-ge) would
require a fallback to shell expansion for older Make without intcmp, and
that would be slower than using ifeq, if less verbose.

> Let's do a good service to the community and add test-eq (and maybe
> test-ne while at it, don't know, up to Masahiro)?
>

Sure, I'm happy to do this if kbuild folks agree. I've cc'ed them; I
neglected to do this in the original patch, apologies about that.

Thanks!

Alan

> Overall the change looks OK to me, so if people are opposed to adding
> test-eq, I'm fine with it as well:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>> +pahole-flags-y += --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
>> +endif
>> +
>> +else
>>
>> -pahole-flags-$(call test-ge, $(pahole-ver), 125)       += --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
>> +# Switch to using --btf_features for v1.26 and later.
>> +pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
>> +
>> +endif
>> +
>> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         += --lang_exclude=rust
>>
>>  export PAHOLE_FLAGS := $(pahole-flags-y)
>> --
>> 2.39.3
>>

