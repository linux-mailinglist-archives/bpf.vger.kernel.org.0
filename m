Return-Path: <bpf+bounces-43175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE939B0A18
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 18:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A6B1F2446C
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21175188CA1;
	Fri, 25 Oct 2024 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g/q8jHZ7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fuu60adW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8517DFE4
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874302; cv=fail; b=S5b9Jg+pRtX3YuKEbDNfrQHrQ/CoewFrhGme7aFE0WTl8/DHAOSkxMUhRtf2y3dvvKKUP1PQItE4gtif+jP30SSm5Wg2YfIEr61HEnWQ3kfrhTgUd3O6MUV2R3b5CVKQORidkM+POtn7+JwfXt3dLw3boe5BPeQhuvMwpCssrB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874302; c=relaxed/simple;
	bh=pDRDd9T5wC7HHlHaOYfeUfgcQo2VO3G8e92wwCiTAhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KCxNrqqEK2ZFDiR2x6VWk2wV3AADcucBhSxHx1damJOW9g9ubfQdMcxkLEPOYHg5G82Eun415UH5pANljc4lSFDXobqWcWJTDwr59Y1AmDkLsOX9pn/nH79/K8vxMVEG2q/ymomNykHnH6CnFd0sXJHQAsjyHUrn3twGioW3ArI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g/q8jHZ7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fuu60adW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG0Xsh028168;
	Fri, 25 Oct 2024 16:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hg0iwJ1/WspaHjAFlPhOQiQkW1gWOCjAOmeAzxemVuY=; b=
	g/q8jHZ7QLw3uwlVFoEAEnd11jcme/aolBXixtm8FtXRaA5K/HYSlSNPI4Yw1usU
	4VEaGc8PHrjdvv0wuIpxYvagW4ZeqX9bx7L2wMtmmyhdbAodNhGJ/9I/VMQYTXCG
	VjZlP2Nv/3SSfm8e5gYSr1Wvptg1KujHR1ilULs1eewiJWM7Ef++IHxt3eBrbwJh
	ffZxVc5ghmiTXaWU1wJ9DCBt/tmbIRG8nWYN+z9+MNQIhtfPpLGSUrHDkaxU3k5E
	aGE2WyYx6R3cZNGsITJayBwTk4IzZuc09xZxzyZtn7MfuDhugtxxw1BfpF7VHUHz
	SctUHbPDC7IayiimAv6l8Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr4kva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 16:38:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFjPCF020975;
	Fri, 25 Oct 2024 16:38:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhnkfry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 16:38:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VL2m9l07R+XkcKaxpVo8RUOIPe9Gx7F5oDvHZa02HiJpRsyn5eriom+kirOeZKuLyQ6NzlypjbdXI9x2LuJX7Efz2yizAGp0gKANFQyMN4tlrDMSpApgiwhJzVWtrmAdjFf0SMJ8Elw+XAH6cEKkDLEBbpJi1rOAaWbzn5J/24akzl1ozfpwDdQnF7NGAbHySXPzV1YBq6vq4vGUCrzv0JbfG7aru8xweISe9JtSOII3fLDD7muRE/hn92J++CimjxYuJ8wD/c+Qa1Q7ntw9fLucrks8aJR2yWJKFojYvcabC/FIMSJVtg+7S0BoBKIIgG7R+QblHHKlC9Pp4pnqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hg0iwJ1/WspaHjAFlPhOQiQkW1gWOCjAOmeAzxemVuY=;
 b=ugbHALjtRNPUR5++D4oYJo9bHODZEgqIhUJtknWNqxyHfzneHMn1R1qiTWrQzlXMtXLg7kBOMu6DkhL5Yc48vCxRfCDD5eqUxMMjeWqSrvs2mVCmgfCJygT0oVZ/cKCQsLDpPXhJ8HaPWV4TPxmiIVjwbzK8wE1H3C6oc3NSchtjczWugnO0ZMRo1VfS87jkm7sA4NpEhS/DNnT6uND5/4jUhB04AJ8db21+WmpgF2Jl6Mm3Cn8bU7irEnrxZyaQHdRQiOW3Se5uOOFZ/huVHECUr/jZHnUvuarXHH2R+Y9HTse1skjbsLPRUQTj1SKP2j+g8jgeSivTy8033ZN3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg0iwJ1/WspaHjAFlPhOQiQkW1gWOCjAOmeAzxemVuY=;
 b=Fuu60adWH5wScjN3ItgRel+6qPierzFZ+Yr4rL38y+9Nu51XqE5RZrc4OBfjXLhwxtgJ70j9AHtQlROTZMNmx3DM2/75cYvo00Xcnh/WQ8y454CxJ9wBr907tLk6PczPuDRd4pOZ33hae8OaLKJ07FZBpZME4tAmAUK/DFtHEjQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV8PR10MB7989.namprd10.prod.outlook.com (2603:10b6:408:203::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 16:38:14 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 16:38:14 +0000
Message-ID: <4ce7da07-20f7-4684-b60b-4704405fa703@oracle.com>
Date: Fri, 25 Oct 2024 17:38:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Questions about the state of some BTF features
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
 <b58c8ae4-3a5c-44b3-bc85-2dd7dcea397b@oracle.com>
 <CAEf4Bzbv4SrQd=Yt7Z2PNQLT+1VkLKMaERFwfE8d=8s7QQ-_bQ@mail.gmail.com>
 <16877742-7f15-4fd9-95b4-228538decda0@oracle.com>
 <CAEf4Bza6pL1-2AmX-zfuv5-mEk=b6yhhGRtb7DrkUTsArvEO6Q@mail.gmail.com>
 <CAADnVQL2CNSMi1NoNTVePw_VaqHYZJ4pLLX25wJjD1R66ezYXw@mail.gmail.com>
 <f07ae723-2773-4dae-88c9-2d26903182fc@oracle.com>
 <CAADnVQLmSKATXzi+++hGpk0i-UiOKk8qt9N2CGBkznCRVr=qcQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQLmSKATXzi+++hGpk0i-UiOKk8qt9N2CGBkznCRVr=qcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV8PR10MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdd13d2-8c41-4d3f-21e8-08dcf5136bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T01taEQ1NGlEa0szUTdRbjlFSjlYbnMzYjJlVnhyMG9QVzRUdlBGR0o5S2lj?=
 =?utf-8?B?MlhxdEErVDNKTlhVNXBvczFoZ3ZyeWJVYlMxMTQ5SU1zREpRVkI2ejF2S0Zn?=
 =?utf-8?B?aFVVMC9GU0tZU1JvdEx6YUNLYTRDZW9POC9ucG0xSWNNR0VBdGs1RC9KUnlU?=
 =?utf-8?B?Zzl4bWJza0YwU00wbGJ5Q1p2c2tQZi9vTUczUW1zWFhvUVhpa2dnL2RhMXlv?=
 =?utf-8?B?NW1JOWZLZy8rTUo0cXJpZGs3SlNyOHlDYmJEdmxGZ2lhbTBaelBLQjBHVzZS?=
 =?utf-8?B?OEMrS2NjeE1pRmtHalk2eFdKazY4SGNDTVZ1R1BlRzAxTjdvQ0hvczg2QVUz?=
 =?utf-8?B?RUpXK0dxZDJsV2VMYVg2MmdRbXZTeGxDdzBDUEh1Z1dnYmRqWTRvMjFGN3Fv?=
 =?utf-8?B?NmlMa2JNc3pJWXZEa1dpOXg3a0VSWENaczQ0b2d6RkNZODkvR2tDMEludU03?=
 =?utf-8?B?UTlJaGZwNjl0bzM2cEs0TzE5RUIrTjJucTNIczhKS3RDblBlNUpPNGxsdUNm?=
 =?utf-8?B?ZFIwMVBYNk9YTnc0NlNnMzlGQ2FpR0RtejRyZWhCNDRrWFRlbCtDTlZzOHI1?=
 =?utf-8?B?MHVYT29HL3oyaGpyVTFkV09uNjk5VE9Kd0tSMGI3UHhNdDNXaTkreEFOL1Az?=
 =?utf-8?B?ZXhEaUhwNGxJRHBuT1doMlpLeFVrb3cxQnVPZ3EwZnZHWnN1ZVErT1oxNjV4?=
 =?utf-8?B?NlZ3ZHlrNFBqbzZrODBFSlJacGNESnZZeEdKLzBpS2JmKytHdVBzNVB3N1Ez?=
 =?utf-8?B?bTgyNldONGQvWGRGTW5GVitvaVpyZEZpemkvY09tRGZqWnFLR0JJLzV0SCtm?=
 =?utf-8?B?SEw2UzVJcHdzSncxTnJiRCs5MHY2YmFxbGhzNW5HM2p6V3gvd3k2NUk0L0dQ?=
 =?utf-8?B?TkJ1S2JGMEwxM1FlbUpNRjVDR2pMTG5ITHRuU0NaY21UZHJDVExpU0pnTnpy?=
 =?utf-8?B?cjMvWTFMcjdzdmdacUpoeGJob0t3djQ4V1cwVHdhUXJ4M3haajVzRWRNWHJD?=
 =?utf-8?B?eGxCbWZDb04xdDd5YjZEMWtreEhjQjVxN045Q0ZsYVVXbXBEcFo3MDZFdzhx?=
 =?utf-8?B?RnFJNjdobjB4dllINTNxSk5TNGV1SENTSmE3M3BoZk15Slh1dGh4MlpYR2N4?=
 =?utf-8?B?OUZzYklNLzJMY2dSaVplZGxqSnFOOFBVTXJLRGdiVGw5OGNWOTFBU0dWZDBK?=
 =?utf-8?B?VUcrWTB6TS9Qa2V4dmFROFpTQlZjZHhDN3d5bEVXRTVhMDRjN2lnZWU0QUlK?=
 =?utf-8?B?ek1tUCs3Z0lNSFZjRzZad2l0bkNHUUx2enM5a1RZRDNlay9Tem5WQzJ3TUto?=
 =?utf-8?B?ZXN1UTlFMk1uU092Sy84a2xsSnNqT2pVVmRxVFFUVXk2czlNVXVKczJBWUR6?=
 =?utf-8?B?em14M0tmNWE1R0owMHUwVnpyUjV0aWhDd3hoajhIWUloRk12ZDIrVDd0ajFz?=
 =?utf-8?B?YXQrQkl3Tlg0dUEyT1ZGY1ZvaElRdlZuZXZ3dnAyek5Pd0t2OHlnRkxmMmF0?=
 =?utf-8?B?N1BPNVJjYVRSaHZmSnphc0M0L2FjdkRvcXRRSENxa2tJQ3paTGJDd1NnZVFY?=
 =?utf-8?B?SnNQaE5IQmJ0Yk9vWFJZVDhoQUF4MG15S1Fyd1lvMmt0VitBNUpaSVdRNFpn?=
 =?utf-8?B?em5Bbm44TGlvQzFGT1BPUFRtNG40U1I4RUlrL242L25za3NpL3BoL0d3Y3Ey?=
 =?utf-8?B?NnJqaWFhWER1NnlJQ0pHbXlKVnJONlYwTjVGUGxaSllFVis4UStidjZUSDg4?=
 =?utf-8?Q?dBN+iR6guXFJfIrpG5rtYj1+dR4MtB4K5YVelW9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am9IZC9ncmxUSzJENUlWQUo3ZjdyVW1vbFJQZE1Tem4xanl2RnZKMWRqczg0?=
 =?utf-8?B?eVlYNE43a2Uzc2NwcGdweW05VTRCRHV4Uy9pbEs3b3RCSzdpcEkxMkRXazBK?=
 =?utf-8?B?eXRZNElybTVkemVEWXFnNElTeWZocjNTMlc0OTY4TU5IS0JCL0VOd2x6QzZa?=
 =?utf-8?B?VVplazNNRWtYamtmcmdwQlVmVStpcnVNS0JPcHg4RWVSckVZaDJCQ2crNk5R?=
 =?utf-8?B?NHNWUVNZRWdPSGhoc3JmWkRzZDY2ZDFpMGxOMms1dkJ1cjc5ZnR3azFVZkEw?=
 =?utf-8?B?R3VpUHYzdTJNZ0t5U0dvN3VRUDdjcnFXdHR6MnJBWlVsUHhUYW9uUU5RUm5W?=
 =?utf-8?B?dHRDY3lzdG5ScFZSNFJWMWxWbXdyZldjMXhGZnNxcFBRMTlHekhwK3FLVGFJ?=
 =?utf-8?B?Q0lmNUN5UCszODgzZlJQbVlSbFowVi9RWW4yclVUa2RwQmhsd2xsc2dnbkJx?=
 =?utf-8?B?SzBoMWZFSGtvNlE2V3IwVWtxbm1DZExxd1BOSXBjNVpFMVZYaEgzZTN2b2Nj?=
 =?utf-8?B?amZlbk5SWGFnK0Y2YTlqUUNtZ2M1WXMzYXdvVlg2Y050bDRwSldYMHRxSzZQ?=
 =?utf-8?B?U3RtZXU5eUl2K0VkWkx3Z0kvYnoyS0RFVmVrN2taaWRwRUU4eXJrR1lJS2gy?=
 =?utf-8?B?L0VnWVdRNDJ1Q0JXVWFLSHdqTmIyVFdsSEFYN2V6MlZuOFhxR3h3dXVXYURo?=
 =?utf-8?B?WmZwalZUTmM5a3VVa0dYelc2MXFMcmpTQlVxTU9ydGl1T1hhTVJiei9vL2ZU?=
 =?utf-8?B?UEZGTWVkOEtOSkxFZmM2aExpUXdVanF6Ym9ISFR4RUlJeGtPRE9vOW1mMUhp?=
 =?utf-8?B?RjBybUpnczgwMlBBR2ZCaGNDVEpwcDBrME8yYThmRTBGRnBzRVdNNFFqRUFq?=
 =?utf-8?B?U01yQW1SajRHeEludFFRUTdCSmNSUkdNZnU0ZDBycEF2bkYxT2FMY1hXRUVM?=
 =?utf-8?B?bTc3eDIwdmZ0akpTUW4wN2xMTG5oZVdxa3hsbDc3VTFzemdSR2xUbTlGbFFP?=
 =?utf-8?B?OElrOSsyMTBwK3gxQ2x1MC9tRXltR1NYakRkWFA1WW8vM01DR2J5ODE5RlBL?=
 =?utf-8?B?a2lFNGMxVFJkejJablljT1J1QVVFSDBjK2JNN2JkSkNRaFcrZDl5dmlUK09W?=
 =?utf-8?B?aGYxdUxrRlVkdEpzMmdNT0liQzRqeU5OR0JDcmlYRHBRcEpQSnpac0ViODU4?=
 =?utf-8?B?SExRYllDMDRIU1hPb0NaM3JIOGdEeHY0dGV3VlZKdHF3VjIrR2NjYlFIZjRF?=
 =?utf-8?B?Y1RmVWFZc1ByZTRCYk9NVUdpU2tsVmY0N1p2M2FMa2ZUU3dTeDFnUEE2UHRo?=
 =?utf-8?B?ZWlQRU1Oc0RMMUduTVZrSU1VVklKV09CNm9NdHpWU1lCMktwUEtpLy96QVFY?=
 =?utf-8?B?WUNBMzFBTXhBSDlXYTZDbzd4SlNVN0VFcmVWNEx0VFpUZ0RUamZaRXhwUlpD?=
 =?utf-8?B?TXhvMGNpcXRPc3A0ZnRGWDI2enJUdCs2d3RQeVNEZU9iK2RnZkd0QlFrdXl5?=
 =?utf-8?B?TWVvRHZHVUV4aDNyUTU2TmsrZHR4RDJNWmxTYkpJaFJDQTRRWU53V1ZDYitW?=
 =?utf-8?B?NzZ6WmxEUmZ6dFpCbXQrYm8yRjRhRWYzTHBCUkZNKzhhUFpYRVNNY2xsL0s0?=
 =?utf-8?B?NDJoejJacjUrOXVxRnd5QklCc2FJcThvdTFrUy9SNGFRM0RvU1BWRWllVW9k?=
 =?utf-8?B?UXhJckgxQWtaNlBRNXJMcjJ6b1RienFNcE5KVFNzUWh4L1B5UjZ1R0Zvb1NK?=
 =?utf-8?B?SWtLMDB2ckJMZ2JUaFVNMjRvejYvcTFGbkM5dXk0bW1wVkRPQzV2YWNpSk1o?=
 =?utf-8?B?Y3RHK1k5eTNVc1B6bzZBYjdzV3VxQmZObzhqQ01Pay9SSjBja2hmWTRCZjQx?=
 =?utf-8?B?NXJSRFdZUWozK3pzNnBaMC91bFhXM2VSVWx4bThpMTE5SWdsenIveVdKT1V0?=
 =?utf-8?B?ODVkaElzKysvcU91bWxRU1AzdHc0K0RkeFBweE11RFRjOFpnV2NOcEtPOGd0?=
 =?utf-8?B?RGxBMmVKZFNkb3ZIS09FWUtIMTRsMWQ1N3RCN0hZOEFrbkYwUTg2Ti9FNS94?=
 =?utf-8?B?RTgreWoyQUovY2l2dmw3cnBmNkdZMlV1NllRSiszM2xNTW5kbTNjdjRZYXhq?=
 =?utf-8?B?Z0VKc2VrWVE2YjhJdThDSlFNd2VCZ3ZVcmNYdjNoRlB4UHU1Z3F5K1ROMUZM?=
 =?utf-8?Q?IcYb+cgBuEuSbxwR9R8dDAY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bH4YNSldZ1VgR/2985DGOvz5aAUGJtSdD5wA7vadof3NICDs0sZ2HE9MrcqsEBkmfTppRm+bnUAsI3fpAw/HBL4/zw8VLYdA4PbZlQflHRfRM9HG7PsdNch7ak9KpWUVfVL3t+PCgzB6EnFtfTnikGUlWAljkgtyGscC476VxdPKgBomdmrj9sgCILP13rK4LK442UXC9k/jiW25um2cRxXeZymzaDPOz0fHdIoGsqvnW1j1Ol6690r1SYu4uT/95JJNXhhBoZAWTyZBcgwMfc0KFqa0PSWQHGC38vhQ7wLjAdwad19WKRPFcK3pvKbQL+ftogn1G1/gUuZ7/GHRZEgEpIS61e21CMOAdomoETt70PJx1yDkuBpmprsRBA/No6IkpVR6QjNeKK2EacVp6ElCN7A+4C17TRDGZ9vP/9iOfwtQhUlLvzj8uQEw2r1ZAwjEktITKi/FZ8l71TuOs2Uob0yn1kgf56PkkkKcbxnGgqh4qaXiVLFgw0UL/OgV23IGdD53WJwi+5Te9ohXvNd7WgvZm9dJTtqx2QkfRpexWFwlr39srxEQU6bAMcDcnCqvqQvCbjU9+JAwDT0thyWiIhL4WQXWb4S5fV58DP0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdd13d2-8c41-4d3f-21e8-08dcf5136bdd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:38:14.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKa4k6UP4GtIpNYxTXuYkCVbcvrJJ/xPnf46AcVQEwnJrw148bw+80qWQWiBqou2QXOIrz8hWhgy+FgknFce+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250128
X-Proofpoint-GUID: 2edB5okO3g1N7fqe_fIivev1vXEdCKRg
X-Proofpoint-ORIG-GUID: 2edB5okO3g1N7fqe_fIivev1vXEdCKRg

On 25/10/2024 17:19, Alexei Starovoitov wrote:
> On Fri, Oct 25, 2024 at 9:15 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 25/10/2024 17:09, Alexei Starovoitov wrote:
>>> On Thu, Oct 24, 2024 at 4:26 PM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>>
>>>>>
>>>>> The good news is that already happens, provided you have the updated
>>>>> pahole to handle distilled base generation. After building selftests I see
>>>>>
>>>>> $ objdump -h bpf_testmod.ko |grep BTF
>>>>>   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00002c50
>>>>>  2**0
>>>>>  50 .BTF          000036f4  0000000000000000  0000000000000000  0006e048
>>>>>  2**0
>>>>>  51 .BTF.base     000004cc  0000000000000000  0000000000000000  0007173c
>>>>>  2**0
>>>>>
>>>>
>>>> Indeed, after updating to the latest pahole master now I get
>>>> .BTF.base, very nice.
>>>
>>> I pulled the latest pahole, rebuilt everything,
>>> but still cannot get it to generate BTF.base.
>>>
>>> Any special trick needed?
>>
>> Hmm, should just work for bpf_testmod.ko as long as "pahole
>> --supported_btf_features" reports "distilled_base" among the set of
>> features. scripts/Makefile.btf should add that feature if KBUILD_EXTMOD
>> is set, as it should be in the case of building bpf_testmod.ko. I'll
>> double-check at my end with latest bpf-next, but it was working
>> yesterday for me.
> 
> There must be something else necessary:
> 
> pahole -J -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> --lang_exclude=rust --btf_features=distilled_base --btf_base vmlinux
> .../bpf/bpf_testmod/bpf_testmod.ko; .../resolve_btfids -b vmlinux
> .../selftests/bpf/bpf_testmod/bpf_testmod.ko;
> 
> objdump -h .../testing/selftests/bpf/bpf_testmod/bpf_testmod.ko|grep BTF
>   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00001d94  2**0
>  50 .BTF          00002ea7  0000000000000000  0000000000000000  00062e30  2**0
> 

Not sure what's going on for you here to be honest. I just tried pulling
latest bpf-next and dwarves master branch, rebuilding pahole and
selftests. I see .BTF.base sections for each .ko in selftests/bpf.
Can you provide the output of

pahole --supported_btf_features

? If it contains distilled_base things _should_ be working. The only
other reason I can think of that you might not get .BTF.base sections is
if dwarves was built against a local libbpf (rather than the git
submodule) or local libbpf headers _and_ that libbpf did not include
distilled base BTF support; in that case we skip .BTF.base generation
since the APIs are not available.

