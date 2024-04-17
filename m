Return-Path: <bpf+bounces-27032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F288A7FB4
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 11:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921AF283C74
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E5812F59A;
	Wed, 17 Apr 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ihzaa4Ij";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d8Oz+rcq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDADE6E613
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346363; cv=fail; b=CM3l3n7JhdfWNKEQWkvispJUhkuK0JahTbIQ6v819gahJt0MgdxV//TGf6swLlBU6Q24kS9VKOowWWO+ONMVHZGd7wGzkaFyUlB/Fif5CBi4gTR0I3xdW7UKrffAJJQjNwusDVCd6mTtSRXLCAdtQpaGGYxVYQE+cJ4DgJmJggs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346363; c=relaxed/simple;
	bh=a2ACFj9S+L7RT97ZC+rBA7tgFZVUbh4pLZmBf4cekMs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bJLRZsxCDITqMq9UGtLbVMZoRhdtaUbxDUJsE1SyhifvMN+auI59Ujx6Jtvh7YZm8YdjRcK7tvRUAYbJS04ufkcTE67A5/uXxNaB5UsES7nVI3DjTQWkRoR+amOmJGEILTTl4SS4BHJpqC+hwLYwHT8NEzlOEETs6Oy6mhYGtKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ihzaa4Ij; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d8Oz+rcq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H8xVCS003950;
	Wed, 17 Apr 2024 09:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=apdchhrAZX7PakdzSJo9EHJUY8M7Re7aF54mkAq4mqo=;
 b=Ihzaa4IjXxHXtQVxSSP3IwJHQ39q3JKHQ/cVN5UGZd32ok3caB/Cw1qZqCxfFdFiz9lG
 XvquszmDJPaVQLJ+pqQRsJWqcC69F8DrvbJxx7Ck9eARIoEJW+0EdOMn1J37gwWCag7V
 RKKDuGuArbcfCCFGLCdxh7upzGhYVVgDBS/VPp11OS55oBUOK9HPEQ/XNFa8g74tsjAL
 DHRgRE2o/ZIQx9/66ZdcGR4e0eMH8S4tHXD0MR2Jn/1S06cp9yiKYPOYbeFdArRi2JtH
 o9/ZrYJ7/hZwLNPjTxubzMOio9Yie9Futou0XRs4HEnwkfBIyYInE4Vh5IcNHECcU1jo Nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhnufem5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 09:32:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43H80ZZm012561;
	Wed, 17 Apr 2024 09:32:16 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwghxut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 09:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdPbJAi5bgFTgkKy0KHfhOde8G5ykzCsmcB+ZoBTPwAT8k11EWVsoVPjgupiMJAVKgw18wl6kNXcZCsg+2ch5LPpGX9uxXRLBCpjuzjt6pZjRqbfpsJxhGy0tNlb/loFJJQLElLiqoqjwUaYe+YWX1NBT2NRR5uJSx57Ah8G7Gt5lH1k6dw5BIVq9jO+t5RKJse6NA6wVbcrYx4ins/E70vUh1vE0+3eykJfbPIrvSJmRtM9tq0r3MMEi1FDm2ncHmyhijOnUUinpKA7ZwtZSEVrVe7CMPl/NxhQwD4/lOyR7Y19aeSqXwX0gNZTRyKFEmivJvaXjKLbMFPoz17Kqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apdchhrAZX7PakdzSJo9EHJUY8M7Re7aF54mkAq4mqo=;
 b=cMdAsi3RNPLZNERKtAj1WIx8K9tjWePqYWzchUVn4wtAQlWvUy7B69cUewTG50GBvL/tylyYfo7BoRzT/T9hpGpWSwPWJbH4mXJBZ4+tcf7KFXL+rMyZ+oIuQpG2snjZ3pHWpDdjUECwLQPC4CYqtfGAKDh2YFNI06n1Poe39ha+YxVYJATSjUxoaVonIJyJt4QFEf4kT4mS8G6BRvcko9XoVJVVDxiofF0HeWciQyrb/QY+xH2SG+fgJDxc4Cwt3A/Zc3XgU9bV23AUOwTi7G1CQW5D9Eqx5O9S38zw7dNx5cP+lCQ+dVK3hrR6B0ly47HOjFcVQqgUsj0xRT+e9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apdchhrAZX7PakdzSJo9EHJUY8M7Re7aF54mkAq4mqo=;
 b=d8Oz+rcqq/ME/Mxxt5XK7e6YHcJ1MDTrWEwoC69UZaYlGR4sVc3TbLf/vp4GvbkxdeQOCLZvil1/Lw4d1GssJpzRpo+Dk1h859vGTQVmOpBH29bUOfJvdA+mABFieIHa2iM/zE1Ez0NdguTntAOnyKDH+0frMu0KCYRtZIU8OSo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ1PR10MB6001.namprd10.prod.outlook.com (2603:10b6:a03:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 09:32:11 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 09:32:10 +0000
Message-ID: <0d1a444a-75bd-42f8-adb6-ced9d102b54b@oracle.com>
Date: Wed, 17 Apr 2024 10:32:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v6 3/3] pahole: Inject kfunc decl tags into BTF
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org,
        quentin@isovalent.com, eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org
References: <cover.1711389163.git.dxu@dxuuu.xyz>
 <82ae2ddd83a8d85ae071e650cf80005c36bb1343.1711389163.git.dxu@dxuuu.xyz>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <82ae2ddd83a8d85ae071e650cf80005c36bb1343.1711389163.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ1PR10MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 59cebff2-4230-4507-cea8-08dc5ec141ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RUxidXF2c0xTRW5uS1JGMHM1MDAvMmFFT1JSTmJLaE1kOXVQQTlBVWFBbmpt?=
 =?utf-8?B?TDNWU3ozSnA0T3NqbnMzekFMMFoxTkxjcllXdlFraHFJMXNXdnJQU281TERW?=
 =?utf-8?B?a0RRVW9UcjhIODdtSDZ4b0pycDNoV0poOWFZZU5oUFNLeEtrMHZEQi9iWFVD?=
 =?utf-8?B?bWlXUWRkRDlBcHZZdk1ncmpnNklrRWhmbDY1eHBjWjc0UVU5UlhFTjlUMnUz?=
 =?utf-8?B?aGFhOTA3T3lVZUd0TFZBS0lSUGd5d2hPWWFFYzVQNUJoeVR0d2VRazIvalBR?=
 =?utf-8?B?TllaOHJ4aWkxK2xKOG5TeXlHSGFHLzViS2I2cmNPNys1dExTaFFWdS9hUk9k?=
 =?utf-8?B?Y2FqellpdmxLVDh6R05PbFdqN2h6SmNHancrZlI2RjFFZHlGNnhVckFxVXJF?=
 =?utf-8?B?SDZpcEQ0STRXU1BHVjlrakJjN3o5Y0tEVGZXMkd2dFBXR0pRdXo4NE1RR1hH?=
 =?utf-8?B?MWhHK2xuelFabE00UkJsZlRVbWlUNVhMMWR5aFpjMmdRN2lsTExud1dDVUR4?=
 =?utf-8?B?YllsRGZBdzMwbkxNeVhtNGFWMHlFUkswUUJqeklHMDQwUG1aNHVPL1BWS1JY?=
 =?utf-8?B?c2VhckhkeUZTLzQ5cTE3UGRlZlc4UnUrVkpqTi9EZlFxZzVTSnlRTTI4L1hV?=
 =?utf-8?B?bEJ0K2pza3N2NjRCT1hvM3htdFU2ZndzM1BWa2VDVkxyYVlzQU1QaHk3N0tw?=
 =?utf-8?B?L0NWWlJMb0ZHSFc5dWF1c3hzR28zVVBVZW9nTmlkM0t1RmlGSDFLSk9GSkV0?=
 =?utf-8?B?Y2pIQ0hJYTBuVk5pbUtjaTBuMkJuS2pnR2JaZkg3RTAzSi9BRkx4MklVcjcr?=
 =?utf-8?B?Q2Rra0xrY0wyOXVUc0o5R2RGaUoxanpyMzg3MkdwMHlMMGdLU25lYWJ0OGZH?=
 =?utf-8?B?WWhXWXVXQzAyN0xqWlpybWRNSnhkRGhVb0RxdUZmdjFjZHRjdnF3L2ZXTDN1?=
 =?utf-8?B?L1JMM040a216YkU2L1RQUEZwcVhMZS9WdUp0UEtKL21ac05sdTl6T3JxZGNE?=
 =?utf-8?B?dDZCaVNFQWd4b2ZZeDRyb0FOenZqNXVzV01VeU52d0RtR1FhZEpwMWpXWnIy?=
 =?utf-8?B?eEkwRjNkT3o0SURtajB0Uk9mSE1FMVlCZGhOd2h1cCt6NGJsWHZTQjI4N2Vm?=
 =?utf-8?B?RFVtRklmM1AzTFI3YmtldWx0SFhVL2dUT0MrZlNVMDlaM3hPU21sQkJEUHdJ?=
 =?utf-8?B?VU9DQVdyTU5WWDZGSTUzeWV0b1piaGUwSHBaOHFkL3BiVEhCZ2U3anRQa0dt?=
 =?utf-8?B?VnhMdks5MlFjWDZwTWZXckFRcytNVk9tYmN5V1JDMDA3WjRMcVNXeC9Ub29t?=
 =?utf-8?B?WkVLQng0d0pYb05uZCt0Vmh6VWtjdDFDSk1ma3N6RVAwZDZFeHVlK2NQT2w3?=
 =?utf-8?B?NEx0cFl6QUtPQi95eHF3Nm5jZ0xZSkExcElDZHdPNG9VQ2t3L1RTRlgwMkl0?=
 =?utf-8?B?VlZXM2JLZ3FFeVUxWHFBbmJwbSt0UHJBVjRCMjlxTWV6MEQvcnJ5bVJSelBr?=
 =?utf-8?B?dEI1bWYzYnRxS3VTbk42bUV6aVlHUW5iQ2ZBRU10MzdpVVI3S3NmUHljSmY2?=
 =?utf-8?B?blczWTJYMlpSeGxuUTZpN2dQZXorSkREaS9CRnJSNHlkaytzM3E3L2hLRXlN?=
 =?utf-8?B?WmZMa1VPVGRBY0dQK1ZoMDFZaVBwZWNDcmJuQTN6WjNnS1N0Z3FtOC9ITjYz?=
 =?utf-8?B?YVJCZ2ROa2Flc1BOQUxvMjRlV0hoeS9FK1lzWndWUmxtNE9DRkt5TkhnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?KzlYQzZwM3NleVd2dWN2KzllTFJKMnpPdlZySklOUWNlc2tKc3JtanlaUzlD?=
 =?utf-8?B?MXkvUEJHWmVUS0VUQ1F3eW0rS3RwbFZkL0ZZU0g2SjBHUStGL0RFTGtodjJn?=
 =?utf-8?B?UitrTDhNVmxiSmxSdEVtM3VWZUxJK00yUUVCQ1A4Q1pOZGhuVFhEWmszVUtF?=
 =?utf-8?B?dTluSEUxdmlHR3JPV1JncCtUYjRPeFRiTjBvdnRHSFRROENlZzhtZzVrdHpY?=
 =?utf-8?B?ektWK21mV1ppM0t3aVBmMGtOUkJRY1ZIbFBjZ2FKdzVGWGFUMnlIVDdUZGtr?=
 =?utf-8?B?Uzg1dFJLOC81U3ZhOFdMRkNrOStHT2VodmNxeHNQTlZaMkVmRFZaajJBZHFl?=
 =?utf-8?B?bjFVWXJDM0w2TnlabldVMWFLVGwySURzSXNxMzg4LzNDWHRFdGxjcjhNSzlB?=
 =?utf-8?B?djBHbWo5aUdiUXFkQkVlbU8yU0FUcGd1TGNJY3A0QWkwNi9ycmxEaEdzc2tG?=
 =?utf-8?B?RlkyWTd5bHVjZGkyb2tCRWd4NUxjZkkvRTVUWDFrTzdIdmlqM2tNSDVnTXQr?=
 =?utf-8?B?LzBrSmlaallWTzQ5Mmc3clRNWk5xT1R5V1hwYWdqbWhNcGRoQ3NSUGF1UFNE?=
 =?utf-8?B?allHMExvTkNVQnoxUGlsVkRvdnJNNUlxM3ZlTzVMNU9OanY0NjVuMjliTmgy?=
 =?utf-8?B?RGlGRFljenhvbUJMQ0FuOUMyelFIM0tXbWp3bDQ1SjZXZHVoVy9KN2NTQlVi?=
 =?utf-8?B?VTBidU11dTQ4dVFYVEV2Nm1pWTNIdGFYcnk5RktLN2FnOG5qSEYzYk8wbFZn?=
 =?utf-8?B?eGxqeUo5UTBsUXFEWEs5WmVnOFpVK0V3OVpGZGtMNUg3V0dvK0dGUmhrdkpW?=
 =?utf-8?B?WDExNWdtTDJFaVlLZzZ4dncxZTN3WkFTRjR2VFJPNWRqWEpWVlhrcjZNYWc1?=
 =?utf-8?B?dnFJSTRvcVBLbGMzU09pdWJ2Z0dESFAwbWJoVG53NnlTVGxia1BjTy83SHRa?=
 =?utf-8?B?TlFUcmZrZWJORHREbngrR0pSSVJQUFdjQllQalM1eFJiYUtlbXRYVi9hNWda?=
 =?utf-8?B?dUFxbWszMEc3Y1lhYXNVb2tIbVNoNVBCOUIxYmVKc1RpZlE1dXliNzJ0VnQz?=
 =?utf-8?B?QmxyNHlSaGFxam9lQWNUTzdDbWg5dTJvNmVjanBnVFBlYnY4ZjVZR0xiM0g3?=
 =?utf-8?B?VUhrN0xQUkw5MUthR3ljTDhoa2E1SGsvVjQxR0dZV3l3bEIvQ2MxM09MWDBF?=
 =?utf-8?B?T0M1YTF4OTNLdzU0di9ITGd3N28zS0h4cXVubS9IQmE4WGIrK2N4SUxwWHNI?=
 =?utf-8?B?MWdVMTZTUHRFbk52ZERNZmxlMHVSOVRqckEwKy9oSmdRUE1EQkNSSnUydkV4?=
 =?utf-8?B?bU4zcjBwYUxxZkVPQ2trZG1IbzlMTUd1MkIrcUROSVJUOHdCSGFOZWxnQUc2?=
 =?utf-8?B?dEdKNmMrWWFQbEZ2OGlKWE50b2RHS2UveVk2akVITDdLYnp6TEllVXAvWFVw?=
 =?utf-8?B?bmtrL01ZRW12VysrSndEaVhqa1JrSnV0MnlIZk1sdFpaWTgyWUhlSDNuME5W?=
 =?utf-8?B?UFhZUzlWWmYrdUpNblZYbEhhSUJ3cHpLdGVVeXlLdjNIU0N0cjZ4dndFZzRU?=
 =?utf-8?B?OW1ZU0g5V1k0b1Y5S2xsa29UOGE1Ti9hL0xUcTBuNjlEWjZjTUdpc1hRY0cx?=
 =?utf-8?B?VStDaGtsVGZOU2lscE5YQ1RpQlBycmszdndReFR0N3FGSlliUnNsenpzdHdI?=
 =?utf-8?B?cEx2V0pUVjNWNThMMFBFVlVrSnNRTG9rTGhHNGlvTlYyanJRNUpMRm9nOG1j?=
 =?utf-8?B?MlJYMloyYngwWTVvMk5FcE1KMDFUSnVFWWNPQzYycXExa29YdDhrMXN1Y1lm?=
 =?utf-8?B?M2pVNjd1OHE2UGJxWDJsLzlFbktXSTYvelJIMjZneFIrRGhjckdBVXBmMFdu?=
 =?utf-8?B?eXZMYXhJcmFFZXk1d1pqRThaeUpCR09EcUl2LzBYaGhaQWRkZ092cDZyT0xQ?=
 =?utf-8?B?OHBPbktIMDhtMFJHbTIxSndQOXVDQWVlODNPdTNRYTh5VE1hcWh4VUlGb2tG?=
 =?utf-8?B?OXE0TUhXRHlJWGd0VkorTnd4d2wwblFOM2x1cFJSaVJjdVdLU2x1YlJyK2Ux?=
 =?utf-8?B?YnpsOHdacjV4L20wYXAvU0lEQUI0QWYxSjZWMUVRSGphM1hzbUM4QlphUDJF?=
 =?utf-8?B?RFVDQ2JDOTFTNzkxTUJubzNqcGx2MlJSbVlXdHU2anZTSGsyaFEvN3cvWXp4?=
 =?utf-8?Q?BAYWZ+GPTwrky8Yd51HiSok=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Til1jfbmAoy65EMYrmaVlw9kXZuzA8bVB3YD6EnUYq2k8uIeztobXt5/x3GO7RnkRFaZo6+bZ0/JJt0fQ2hBGaS0Vx8Lmi5l+zQLpSgbVtIQaxQUrb9b2+rXGYEyevUCy4Ss01UfGLTYjfV13zfwE3BffOK3p29Sdwd9hJ6HVvfYjmAz/q27fZya3vpN4GyWJneam6tgxvRKrs2Tg+0OtfKTX4wKUtrfAu2dSN//iBOb5Wj0JivfhXtWkU/p9CdsONKWGrfbAfMHuvwOSbAWO8oxFjisD2fW8s1uOjgha9VpFJwBFVhjN1YyV9wDL+kHb+8HITZfEZjnLcTBmgk5vsD4T5JVjOPSzICp6SpLnMYQde6OWKhWkUyZMG7WZrKGAWVFAXiSq79YAzxGZkzZlW5PboG1aKNsyW2nY0ohKUzPyksVnIzXh/2aBYHb1TpVKqu7HuwNOxCGdN8YYYAcScmm0wn/RX+5CjshxHhldfQ0GoyOeCODYC6MUGN2HyN3ek3+PtmfOxPS1yMtixG6Uj2MLyhuNAJM5j/n50H5hH6gkxrNWyXmMYZXTUsRpGYlKdcoZgCJsKhK/0Z4T2qjJQoyWa8loSLFjOfbl190vg8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cebff2-4230-4507-cea8-08dc5ec141ec
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 09:32:10.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7Meg9daXLJsqnUP1u/197/7mELybCkI/4e/6mt1fOSKU64yA8nJqMwRbVynahhY9dqDzFalWPsiTwwZRDnfSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404170065
X-Proofpoint-GUID: pWH87NQQB5_B4GO7NqIzOO-tA-rh-CXz
X-Proofpoint-ORIG-GUID: pWH87NQQB5_B4GO7NqIzOO-tA-rh-CXz

On 25/03/2024 17:53, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> 
> Example of encoding:
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
>         121
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
>         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> 
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
> 
> This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Tested-by: Jiri Olsa <jolsa@kernel.org>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>

I re-tested for both vmlinux and a module with a kfunc (nf_nat); both
generated decl_tags pointing at the kfunc functions so all working
great. Nice work!

> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  btf_encoder.c | 372 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 372 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 850e36f..d326404 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -34,6 +34,21 @@
>  #include <pthread.h>
>  
>  #define BTF_ENCODER_MAX_PROTO	512
> +#define BTF_IDS_SECTION		".BTF_ids"
> +#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> +#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
> +#define BTF_SET8_KFUNCS		(1 << 0)
> +#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
> +
> +/* Adapted from include/linux/btf_ids.h */
> +struct btf_id_set8 {
> +        uint32_t cnt;
> +        uint32_t flags;
> +        struct {
> +                uint32_t id;
> +                uint32_t flags;
> +        } pairs[];
> +};
>  
>  /* state used to do later encoding of saved functions */
>  struct btf_encoder_state {
> @@ -75,6 +90,7 @@ struct btf_encoder {
>  			  verbose,
>  			  force,
>  			  gen_floats,
> +			  skip_encoding_decl_tag,
>  			  tag_kfuncs,
>  			  is_rel;
>  	uint32_t	  array_index_id;
> @@ -94,6 +110,17 @@ struct btf_encoder {
>  	} functions;
>  };
>  
> +struct btf_func {
> +	const char *name;
> +	int	    type_id;
> +};
> +
> +/* Half open interval representing range of addresses containing kfuncs */
> +struct btf_kfunc_set_range {
> +	uint64_t start;
> +	uint64_t end;
> +};
> +
>  static LIST_HEAD(encoders);
>  static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
>  
> @@ -1363,8 +1390,343 @@ out:
>  	return err;
>  }
>  
> +/* Returns if `sym` points to a kfunc set */
> +static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
> +{
> +	void *ptr = idlist->d_buf;
> +	struct btf_id_set8 *set;
> +	int off;
> +
> +	/* kfuncs are only found in BTF_SET8's */
> +	if (!strstarts(name, BTF_ID_SET8_PFX))
> +		return false;
> +
> +	off = sym->st_value - idlist_addr;
> +	if (off >= idlist->d_size) {
> +		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
> +		return false;
> +	}
> +
> +	/* Check the set8 flags to see if it was marked as kfunc */
> +	set = ptr + off;
> +	return set->flags & BTF_SET8_KFUNCS;
> +}
> +
> +/*
> + * Parse BTF_ID symbol and return the func name.
> + *
> + * Returns:
> + *	Caller-owned string containing func name if successful.
> + *	NULL if !func or on error.
> + */
> +static char *get_func_name(const char *sym)
> +{
> +	char *func, *end;
> +
> +	/* Example input: __BTF_ID__func__vfs_close__1
> +	 *
> +	 * The goal is to strip the prefix and suffix such that we only
> +	 * return vfs_close.
> +	 */
> +
> +	if (!strstarts(sym, BTF_ID_FUNC_PFX))
> +		return NULL;
> +
> +	/* Strip prefix and handle malformed input such as  __BTF_ID__func___ */
> +	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> +	if (strlen(func) < 2) {
> +                free(func);
> +                return NULL;
> +        }
> +
> +	/* Strip suffix */
> +	end = strrchr(func, '_');
> +	if (!end || *(end - 1) != '_') {
> +		free(func);
> +		return NULL;
> +	}
> +	*(end - 1) = '\0';
> +
> +	return func;
> +}
> +
> +static int btf_func_cmp(const void *_a, const void *_b)
> +{
> +	const struct btf_func *a = _a;
> +	const struct btf_func *b = _b;
> +
> +	return strcmp(a->name, b->name);
> +}
> +
> +/*
> + * Collects all functions described in BTF.
> + * Returns non-zero on error.
> + */
> +static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder, struct gobuffer *funcs)
> +{
> +	struct btf *btf = encoder->btf;
> +	int nr_types, type_id;
> +	int err = -1;
> +
> +	/* First collect all the func entries into an array */
> +	nr_types = btf__type_cnt(btf);
> +	for (type_id = 1; type_id < nr_types; type_id++) {
> +		const struct btf_type *type;
> +		struct btf_func func = {};
> +		const char *name;
> +
> +		type = btf__type_by_id(btf, type_id);
> +		if (!type) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
> +				__func__, type_id);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (!btf_is_func(type))
> +			continue;
> +
> +		name = btf__name_by_offset(btf, type->name_off);
> +		if (!name) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
> +				__func__, type_id);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		func.name = name;
> +		func.type_id = type_id;
> +		err = gobuffer__add(funcs, &func, sizeof(func));
> +		if (err < 0)
> +			goto out;
> +	}
> +
> +	/* Now that we've collected funcs, sort them by name */
> +	gobuffer__sort(funcs, sizeof(struct btf_func), btf_func_cmp);
> +
> +	err = 0;
> +out:
> +	return err;
> +}
> +
> +static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc)
> +{
> +	struct btf_func key = { .name = kfunc };
> +	struct btf *btf = encoder->btf;
> +	struct btf_func *target;
> +	const void *base;
> +	unsigned int cnt;
> +	int err = -1;
> +
> +	base = gobuffer__entries(funcs);
> +	cnt = gobuffer__nr_entries(funcs);
> +	target = bsearch(&key, base, cnt, sizeof(key), btf_func_cmp);
> +	if (!target) {
> +		fprintf(stderr, "%s: failed to find kfunc '%s' in BTF\n", __func__, kfunc);
> +		goto out;
> +	}
> +
> +	/* Note we are unconditionally adding the btf_decl_tag even
> +	 * though vmlinux may already contain btf_decl_tags for kfuncs.
> +	 * We are ok to do this b/c we will later btf__dedup() to remove
> +	 * any duplicates.
> +	 */
> +	err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, -1);
> +	if (err < 0) {
> +		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
> +			__func__, kfunc, err);
> +		goto out;
> +	}
> +
> +	err = 0;
> +out:
> +	return err;
> +}
> +
> +static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> +{
> +	const char *filename = encoder->filename;
> +	struct gobuffer btf_kfunc_ranges = {};
> +	struct gobuffer btf_funcs = {};
> +	Elf_Data *symbols = NULL;
> +	Elf_Data *idlist = NULL;
> +	Elf_Scn *symscn = NULL;
> +	int symbols_shndx = -1;
> +	size_t idlist_addr = 0;
> +	int fd = -1, err = -1;
> +	int idlist_shndx = -1;
> +	size_t strtabidx = 0;
> +	Elf_Scn *scn = NULL;
> +	Elf *elf = NULL;
> +	GElf_Shdr shdr;
> +	size_t strndx;
> +	char *secname;
> +	int nr_syms;
> +	int i = 0;
> +
> +	fd = open(filename, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "Cannot open %s\n", filename);
> +		goto out;
> +	}
> +
> +	if (elf_version(EV_CURRENT) == EV_NONE) {
> +		elf_error("Cannot set libelf version");
> +		goto out;
> +	}
> +
> +	elf = elf_begin(fd, ELF_C_READ, NULL);
> +	if (elf == NULL) {
> +		elf_error("Cannot update ELF file");
> +		goto out;
> +	}
> +
> +	/* Locate symbol table and .BTF_ids sections */
> +	if (elf_getshdrstrndx(elf, &strndx) < 0)
> +		goto out;
> +
> +	while ((scn = elf_nextscn(elf, scn)) != NULL) {
> +		Elf_Data *data;
> +
> +		i++;
> +		if (!gelf_getshdr(scn, &shdr)) {
> +			elf_error("Failed to get ELF section(%d) hdr", i);
> +			goto out;
> +		}
> +
> +		secname = elf_strptr(elf, strndx, shdr.sh_name);
> +		if (!secname) {
> +			elf_error("Failed to get ELF section(%d) hdr name", i);
> +			goto out;
> +		}
> +
> +		data = elf_getdata(scn, 0);
> +		if (!data) {
> +			elf_error("Failed to get ELF section(%d) data", i);
> +			goto out;
> +		}
> +
> +		if (shdr.sh_type == SHT_SYMTAB) {
> +			symbols_shndx = i;
> +			symscn = scn;
> +			symbols = data;
> +			strtabidx = shdr.sh_link;
> +		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
> +			idlist_shndx = i;
> +			idlist_addr = shdr.sh_addr;
> +			idlist = data;
> +		}
> +	}
> +
> +	/* Cannot resolve symbol or .BTF_ids sections. Nothing to do. */
> +	if (symbols_shndx == -1 || idlist_shndx == -1) {
> +		err = 0;
> +		goto out;
> +	}
> +
> +	if (!gelf_getshdr(symscn, &shdr)) {
> +		elf_error("Failed to get ELF symbol table header");
> +		goto out;
> +	}
> +	nr_syms = shdr.sh_size / shdr.sh_entsize;
> +
> +	err = btf_encoder__collect_btf_funcs(encoder, &btf_funcs);
> +	if (err) {
> +		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
> +		goto out;
> +	}
> +
> +	/* First collect all kfunc set ranges.
> +	 *
> +	 * Note we choose not to sort these ranges and accept a linear
> +	 * search when doing lookups. Reasoning is that the number of
> +	 * sets is ~O(100) and not worth the additional code to optimize.
> +	 */
> +	for (i = 0; i < nr_syms; i++) {
> +		struct btf_kfunc_set_range range = {};
> +		const char *name;
> +		GElf_Sym sym;
> +
> +		if (!gelf_getsym(symbols, i, &sym)) {
> +			elf_error("Failed to get ELF symbol(%d)", i);
> +			goto out;
> +		}
> +
> +		if (sym.st_shndx != idlist_shndx)
> +			continue;
> +
> +		name = elf_strptr(elf, strtabidx, sym.st_name);
> +		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
> +			continue;
> +
> +		range.start = sym.st_value;
> +		range.end = sym.st_value + sym.st_size;
> +		gobuffer__add(&btf_kfunc_ranges, &range, sizeof(range));
> +	}
> +
> +	/* Now inject BTF with kfunc decl tag for detected kfuncs */
> +	for (i = 0; i < nr_syms; i++) {
> +		const struct btf_kfunc_set_range *ranges;
> +		unsigned int ranges_cnt;
> +		char *func, *name;
> +		GElf_Sym sym;
> +		bool found;
> +		int err;
> +		int j;
> +
> +		if (!gelf_getsym(symbols, i, &sym)) {
> +			elf_error("Failed to get ELF symbol(%d)", i);
> +			goto out;
> +		}
> +
> +		if (sym.st_shndx != idlist_shndx)
> +			continue;
> +
> +		name = elf_strptr(elf, strtabidx, sym.st_name);
> +		func = get_func_name(name);
> +		if (!func)
> +			continue;
> +
> +		/* Check if function belongs to a kfunc set */
> +		ranges = gobuffer__entries(&btf_kfunc_ranges);
> +		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
> +		found = false;
> +		for (j = 0; j < ranges_cnt; j++) {
> +			size_t addr = sym.st_value;
> +
> +			if (ranges[j].start <= addr && addr < ranges[j].end) {
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			free(func);
> +			continue;
> +		}
> +
> +		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
> +		if (err) {
> +			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
> +			free(func);
> +			goto out;
> +		}
> +		free(func);
> +	}
> +
> +	err = 0;
> +out:
> +	__gobuffer__delete(&btf_funcs);
> +	__gobuffer__delete(&btf_kfunc_ranges);
> +	if (elf)
> +		elf_end(elf);
> +	if (fd != -1)
> +		close(fd);
> +	return err;
> +}
> +
>  int btf_encoder__encode(struct btf_encoder *encoder)
>  {
> +	bool should_tag_kfuncs;
>  	int err;
>  
>  	/* for single-threaded case, saved funcs are added here */
> @@ -1377,6 +1739,15 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	if (btf__type_cnt(encoder->btf) == 1)
>  		return 0;
>  
> +	/* Note vmlinux may already contain btf_decl_tag's for kfuncs. So
> +	 * take care to call this before btf_dedup().
> +	 */
> +	should_tag_kfuncs = encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag;
> +	if (should_tag_kfuncs && btf_encoder__tag_kfuncs(encoder)) {
> +		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
> +		return -1;
> +	}
> +
>  	if (btf__dedup(encoder->btf, NULL)) {
>  		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
>  		return -1;
> @@ -1660,6 +2031,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->force		 = conf_load->btf_encode_force;
>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
>  		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
> +		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->verbose	 = verbose;
>  		encoder->has_index_type  = false;

