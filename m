Return-Path: <bpf+bounces-33147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A87917DAD
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 12:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7831F227A2
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB51176FD8;
	Wed, 26 Jun 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BpQDOLvG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c8WYsinn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3716078B
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397196; cv=fail; b=MpQIaxQrajAfaiR+bvbwPHr13sTu6IzqZonL8TMOaZhLRbiwEjMpRI3n/5oJvyBJjdzRXm6EMahsykAZOuC5KzmHb4wb+ZNIbYyIe7L/ANPnFZFrBismBdJcQT4iM6Hcpuir3+ooIcs2R9fh/khPj51DnBCS0yJoXlfXphGap2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397196; c=relaxed/simple;
	bh=L+AYphB8DmZiWvUeKVJNTsuSb0iySb6v40SFzZZw+BE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mSZzFJyIj07nAOU7R4GMcmQZBWMGGVOGLDS7VJ8ZfzJ3W6mKb1WGIVtXtqsie4Rjxn8BFL7GpH8VW/MzeI+IfJfURQkrQIy4Vu60x4SJgQqWg1Wl+6QMBo3KyEVHZl1jdlMCDnlnr8yVCk0N0pT+H0Lu7eVGgXHTwGmkJ8+7lYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BpQDOLvG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c8WYsinn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q9sr9B025717;
	Wed, 26 Jun 2024 10:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Vv+QoL3IChcFb9+izlKN2F3vHmbdmEbts5b81G7unvY=; b=
	BpQDOLvGsJw79tZTJk9l9dYrEOHcAo1/SbQS6tk0dwXyUqmCe5lTSd+sPOUyP5At
	SK2CWH64JNcWtbaIDKg09ovwSqeC23085CV65ord/6VG5x5tYdlKAwYUrszs4/Rs
	FpKrZUdwWjyhMf+Q4bShO6A+7wiP/kW0xQDWQ5LoqnFsmAqSSH7vH8TVVHpBBtaO
	rS4EN4DUwAoBmjvM04fLTv8+mP2qxzxqvgUZtpeCTQcQKpHMHnHHFvw1xjd5cSal
	9WjFZ97c2YmdMQJ2tTPhSECIGuplntU0RLTrAbvjZtgGjE9j5RcuzSE7379BuuFH
	BV6AUzm7i6YrWF5r60u19Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd2jyvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 10:19:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45Q9mtMG017832;
	Wed, 26 Jun 2024 10:19:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn28sxnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 10:19:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOcQiapCe3itWXHD1CpMdj2RXPgYfIO16N0Kfi0MdPwRSks38aK046vf7Uh5DGITZrZXjok/Juvh8AOFMzQhJyoozxqP8xXjNunGCF/p3U4czBK2N7Mi4i9gdIL/1vJk+b06w6eQS0hNLMM7EaF2cU8CTUknxHlAClVfFJnJiBlE7iSStJcc5dnt7eZgbM5Uk39dgAGhxluDwrnRHUfGZpG+CrKaHUK59pyVCc8kdPLL5+nQjylkHCC25xwwLkwuyzeHkDxQ+nTUcNpvi0EUyv1ZOQL94tV8kQAg9+ZHrMJUlUtZDIaoUHXq6Bml+ScIyhL0lWRwfbgwi1WX6R/sgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv+QoL3IChcFb9+izlKN2F3vHmbdmEbts5b81G7unvY=;
 b=oGbxPckuZFUUaEzmnrnV4g1xUmR2ThWQGkbk6L8djJmnKhsJdQcNb8RIEeh8sw8wjKLczxc0D6b2bBBDTRZwxEwfSB8yehyDU5EvmQQ9y04do1at97GCLjJv1rh6ej3YZtdzvGR61X5pkU08whvZEeQvqmXYljLR3jJMfPQHkN2LVRzT9QJrtZuobPnFHvt6CVW6xvoipKMl96sk3ssXSc9yGOdidYBoQjvE8Vnh9cOj7VIDH3swDGE6tEfkBWcUVJAKbSNRdST7rXKlLf6/v1Wh2Y42bikrjOWz3M1xaMEkCXCrPj2NhjZn1BTKewJUTCuXsRcReBRYtqlO/dKNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv+QoL3IChcFb9+izlKN2F3vHmbdmEbts5b81G7unvY=;
 b=c8WYsinnWmnUKM4pR2mkTFq0clQQ4tWvImS8Rt/wPnnkvM9eaBj8acU8hTh5GTO8ThCmK/0WRCFywBF5diqoRkL/VU9upniFPs+2wmjQyJU9Qn2sqLV/E6lh9P7lzZVKLbUAyTb+kVWM4BOBPLy39q5hztzvBj73lf8P5dqDDzM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB6027.namprd10.prod.outlook.com (2603:10b6:208:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:19:35 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 10:19:32 +0000
Message-ID: <4f2abaab-bc61-4698-8497-f6597ac21e22@oracle.com>
Date: Wed, 26 Jun 2024 11:19:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: A question about BTF naming convention
To: Totoro W <tw19881113@gmail.com>, bpf@vger.kernel.org
References: <CAFrM9zur6bHTXJha-=Jyq-qYiZGodD-8hf2vMFfjKrnF+ir-Wg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAFrM9zur6bHTXJha-=Jyq-qYiZGodD-8hf2vMFfjKrnF+ir-Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::30) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a15252a-77cc-455f-64c5-08dc95c978a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?STVFYXFUYUN6QzAwWE16SlVzOENRdUNpa2ZIbWYrcHlIYmZ4YWFXdnZRbjFx?=
 =?utf-8?B?N3d6d3B6bEt2RjlCc0NXN2JqUlcwTUlJUzhML2luanVpdm5paWlYYVNYandS?=
 =?utf-8?B?eTdxLzNaMzFEMUp5RUZSeGt1N2lQSkRGOUVZUkF4ekE5UWFESFRtNnZnb2dW?=
 =?utf-8?B?ZStwUmZ5a2t3ZXBqcGswQVA4eGFiQ1h1RTk2NHU2eGNYKzZ4NjB5N3VyejY4?=
 =?utf-8?B?bUhKM3J2bnpERXpmRTI3ajJqN0RvVWQ5dm5qY0M4ZHZzZU1GTG5YcisraU4y?=
 =?utf-8?B?T0NpcDgwYVNKMStNb1F0TXFnVUwvRDkyc3V0Ujd2aXVvYVU5NHM2MjhMWVJN?=
 =?utf-8?B?Mi9BNU5iek9qeUN3Zktmei9Rd01EY2FPNmNkdnFxNnBFYXZKZnAwRUw3UkZr?=
 =?utf-8?B?cmd4WUdUZ2wwNm4zUmN4ZEVoOGJPWGFqL0NadmcwT3VhNTJXdWVSRFJKL01a?=
 =?utf-8?B?SGhjMml2ZS9KTG4waTNFRXIzUXkyeFdFaktpWWVjNEZPaVZCbEN1Zko4dFFr?=
 =?utf-8?B?VTdNS1pwWjdsVlh5Y3ZtQkJmbW85V1NsSHV1aEJJUEdnRlVQczVpaWt1eEZZ?=
 =?utf-8?B?cXB4ZmZYeUcrZENHT1NSY3Q0NnV4aGhRbjJkQU9RMnlNaHc0UWVnMkxCMjJP?=
 =?utf-8?B?ckZOV1h1WGlZb2tIcElSZW5qWFdNbm5HQVZvR1ZQWVpUdzdyOVVYZ0VmQ05t?=
 =?utf-8?B?eENONWhUT3lSa2QvVE5DUmszVXFILzJmN3Qyc2ZwdGpQTkZ5U05kNitSYktN?=
 =?utf-8?B?L2Rxams4WEFzZVZwQVkyLzhGYjFkUG5HUXM0bUxZbUZZbHVlaVRlUmdWN0lm?=
 =?utf-8?B?S0N1WlBCMzBUVmNLalNOT1QrZ3YrSjVxdXhUTWdJd1ZHY2FBUDBaeUQwem9F?=
 =?utf-8?B?bTdLTVJBaWRZdXl1OGc0QjVGajdPUHFlblpPMVJuaDFGTjU5Q0wxSFBRc3Na?=
 =?utf-8?B?eU9SeFU5dDhGUG5FMXF3V2d2NTJ1cE00eW9oSWFHM09id1RYRGZobks2cGZr?=
 =?utf-8?B?TGhMcjA2N3paWlF3NjJkYkt0bkh3SXZOZFRQcDlyZG9zcjZhMndyL3R1Skx5?=
 =?utf-8?B?SlUvOUx2SmMrQ0doenhPV3R4VzdSMnBVSmQxTkJqZ1BWeGQwMTd4R1JoM24z?=
 =?utf-8?B?RmVNMERZK04yelJLMThMM1F3T2hJRVViZzdkTkxJZklrODZUc3Rpd3RiZmIv?=
 =?utf-8?B?NWh0TFNzdDBPQTdWUi9Zb0lNMzR3ekdCbzVNVlZmZG5CazV5M3ZLVDFVTHlL?=
 =?utf-8?B?Zkc0dGhHcEhQK21ueVFhdHhrdDBuNVQzOEFBcFNqbHU5YlJ4VE1YdnZ3NDVI?=
 =?utf-8?B?Zkw1Y1cvcmlHVmVQWHZoUzBmdWlLcXRJZjZxemVRVHVVT25pSGhQV3hNcWF5?=
 =?utf-8?B?UTJpZStnUXdSZTZ4SFpqbW5pbno0V3g1cVlMOVp2Q1d0RGZPeGJpM2RST25W?=
 =?utf-8?B?MUNFQ2czZWxYUXJpY24rNE0wVmMzaWViK09FRUtpejlKSmFFNWhCMjl3L3d6?=
 =?utf-8?B?Vi9SbU9DbEo0WHlwclZvY2Q4QjZKUnErekora3daeHB1V0Y1enludFUvdTBM?=
 =?utf-8?B?cU9ienFiUTI3WlM0c1NmTVk4cVlzZVJiQmhDSldiTHNwY0NQa2hlSVdzQnRz?=
 =?utf-8?B?Zkpqb3NzbTFwZkc1MnVvUk94aktlQm1neEswVnc3MEJzNXdNRXFYUitkSlpR?=
 =?utf-8?Q?9/3N3xYmdpmDZT0bwuwn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGZKZHNxb1kvSHVQU0daVVErc3p4VEFZSFoxS2FWUGlORHRDRW9mRXVrelBO?=
 =?utf-8?B?b1haY2h1T1ZQQnJsVWtmZUZTZ1o3NXBzLzA0dXRQc3ZpaS9PUE5YNjNJOEJT?=
 =?utf-8?B?eFZzZSt1SW9BMkFXQis4U215WUNXdXBZMmNIOWxKaDljNkwzVjdVSmtPV3NL?=
 =?utf-8?B?aXkvcy8zMmI0dU9BcktEUUlkVnZIQjhBUGxQb3Y4dWFnVWQ2T01KOEN1Z2xM?=
 =?utf-8?B?TFdvUnNhWGxWWkpBL0x0ZlFzaVFzTEduZnZUUjVnK1VIZlFmUE01RnR3RDVp?=
 =?utf-8?B?R3hIK2pua3YyWDdVVkhIcW55bE5sWTBhOTIrVCtiQ1p1MWVQOEJzWjFCRGNY?=
 =?utf-8?B?SDV0RFhXWm4raHNqdURsc0hnVGo4aDhPS3ZrRTRDOVJMTUs2aHRia1hYTWNt?=
 =?utf-8?B?c1Vxd0JuS1JEYndTVklJZE5jUUFtZDVSZDd3bk80MUdBcVVXMVN1MzloTG0x?=
 =?utf-8?B?Qk04K0xoNWFqMzhKcGJxS0JXR1NHZGQ4TGlDaksyZHc2KzlNVTRPNnN2Y3Ft?=
 =?utf-8?B?SU1PYUd0cFU4QVJJN2FPbWIvNTVKekVxd2NyNFRwV1hETFBJeFRSVys2VCtI?=
 =?utf-8?B?d0lSL1ZlKzZPYlhmQTRiV0dzQ1VXUmlWWlhoRk9ydGNSbHlZVkxsY3lHVDVi?=
 =?utf-8?B?alBJMVp5TVZwQ0txYUFNQ1BzM0laSjdvQTR2WFFFQUtpdkI2L1NmTTIwMUta?=
 =?utf-8?B?WGJoaXp1TmNBOUthVFAyc1lzVktGWkFPNkNMcjNmZERsWGdwZm9FZWNacTNx?=
 =?utf-8?B?RzRDU1hONVAxK0MyVE5VQllmRjFaN2Z5c3RUUHZOdlp6MmpENnBWVGRTZFd5?=
 =?utf-8?B?a2NpSUsyMFQrR1VUU3h6dlZWcENGaThzRnF5cVMwcVltV21YUlA1U2pRUnds?=
 =?utf-8?B?Y2NaQ2N4eW1QWUg4VDRSWHNxM0d0WllNakU2WTVqSFI0SEdLeU0yUThIOGh5?=
 =?utf-8?B?bjVXenhGNGptYnFNTTYxVTFzbUZHaUxoR29kalN0MUlyeXRmajhRVjRQdXZt?=
 =?utf-8?B?RXE4VG16Tm93TUxlTDhLM1p2TFZjVDIrK0s0aTJLODZxdlB1REFBYVorQmZi?=
 =?utf-8?B?dmZidFRlVC82Z3lJakZxclRsQk9PWWl3Y0RjY1RNTDVoTkJBMitRbGVkNGQz?=
 =?utf-8?B?ZFE4MTcwWCs5Mmd1RkRmZGRuSldFRXJnYkxuU0NXZmFIUTBmQUFibWt2SHht?=
 =?utf-8?B?b3NYSk9WcDhlNHFxaXhRY25EdEtzVVo3dHMzL0tLU0RkU2hydXhGRE1FZkZU?=
 =?utf-8?B?bVp3NkkwV0xLdFN3S0MwQzgyVWdNMElLMWlGVGRVU0RyRlY5cDdBaVZhZkxG?=
 =?utf-8?B?VUZRNlcvajFJSGx1Z2wwNTVFQytNOFk5QXVBZGljTWJxblBuV3k2VzR4WXox?=
 =?utf-8?B?MXB6d2tHR0xNNFZERkk0dDhxUjRLYlF0bFpzZkZ5WDJya2FxMEFrSmhma1Jy?=
 =?utf-8?B?UUppM3pScmludmFodENuL0FqQXVvRFZYbCtOM0hJTEV1cCtZTGxDVy9UK1pE?=
 =?utf-8?B?d2lmanBvYXhKU0I1S1h2ajY3TlJuNnVMSDExMlFBeEVWdEs5eWFSQU1Vc0ND?=
 =?utf-8?B?Z0w2VWdBUUk4TGM0ZjBrYlZ3eHVFSmcyVHpwK29QNzJFSDFiRXMzb1dvZ3BM?=
 =?utf-8?B?THRselJNbmVnUXpRRnJZd0UrdDNWaURVNTRBQkpNUWJuZkJYd0FUQ3V6NTNv?=
 =?utf-8?B?b1FhNndPcjlnVXkwSGpCNW9JN3NLUTR1a212NTEzMHdnT0p2QVhEVW5XTkRS?=
 =?utf-8?B?Q21zMVFoOW5NOVhENnlQSm9WUWdTRm1JVllDdWNRZk1KdThrN2NWYVZ4ZEh5?=
 =?utf-8?B?K1lVTlY4S2hqN1RLbElmdVJIT0pld2VuN3ZKSjhvN0pFamVHd2lnTngzc0cv?=
 =?utf-8?B?MzVuTGVkYXo2dHdKY3NwWGk2ZWlCY0xGMDhzTzdqd3pjNThWT2dLSXVOa3I4?=
 =?utf-8?B?ekFETFR6amFYc2x2OGR2M2FOaUhuUzI4bHNIVzU5U29rL0cyUm9uWGNLemlE?=
 =?utf-8?B?TnFqTnlPOEdrQmdodi81b0RuZVhUVDBUK2RzbFU4bVlHcklDd1dhNXAzSzdz?=
 =?utf-8?B?eWkrM3ppbXBvVllFMkZyM01VUjUwN2UwMzc4c3NWOHdNMlY0UkFZczAvb1NP?=
 =?utf-8?B?QTFlWE91WWZVbnpWbGZ6TU9hQ0c5WEpWZWdyTWZsL21kRExPcHVnMVRDbURx?=
 =?utf-8?Q?1MBj4f05Q0N2ykGH+0m3qwk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Fc3bBf7TPyBonrXmmw2iOBoaZA4GMks50nuclJQW6Sz4eyQDzAOfgIVE2Ec/A2pDccB9AHDpgV7+sJHXcs8PfyPTuoDPHtARd2tvh2KGeBXJz9xkg6/O8XsHMXrkCMZcz/p0dR8cJCo1xNDcXhIiB32qhC/NfkDNXCSNuUcGHh/phXQGwivVjWWCVFjSzimshl54kD6Tkn5a9HfmEd9imlds32SMbLbH1Ku8iUCcQXnT9escfKUgs1JK4qG/fUNfcS0wAJbyCV5qwn9E8XUwowswd85STDTLOUwZNHYZJCoyScHggxXyLbbuW56L4ysNiLSvEfpLKQj2TDZ1lZHtxVrIsD90Na6k7jcTdQfeYDV/FsHjpw7Eeg7jXLNp6njYlTpd4S/B8/OshGUZveFzzuI14P+K5v2HAKiohrs5ymZC9ZDBh7cGosfGMCyTlUOluHMhSLEWEOiRuM9NZoJbNkN/9pdhl7crN2Z6zCwfXjQVgpmQYEyiPtDoufrpbqjW3BwVMUFbH6N//AnppQoWn/qlFZCcWNG/xckaApRKHJ+UeR3gvazEjZg51JUrDVvOqqaY8mI0i/CWeclFbTkIcZGRkeplAe1zd5KLigTHIlo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a15252a-77cc-455f-64c5-08dc95c978a0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:19:32.6180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkTkXGafbDBdVkMN/1aIDaNPJ9/oVK0EYGnirnoGmSzHwtkoVaGzpiuEs+0kH7gn9sEaLuvxlm54P+ydNCKvPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_04,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260078
X-Proofpoint-ORIG-GUID: mMyY71gC_88Y-uB5IrWp6ZGzCu-oXc7I
X-Proofpoint-GUID: mMyY71gC_88Y-uB5IrWp6ZGzCu-oXc7I

On 26/06/2024 08:29, Totoro W wrote:
> Hi folks,
> 
> This is my first time to ask questions in this mailing list. I'm the
> author of https://github.com/tw4452852/zbpf which is a framework to
> write BPF programs with Zig toolchain.
> During the development, as the BTF is totally generated by the Zig
> toolchain, some naming conventions will make the BTF verifier refuse
> to load.
> Right now I have to patch the libbpf to do some fixup before loading
> into the kernel
> (https://github.com/tw4452852/libbpf_zig/blob/main/0001-temporary-WA-for-invalid-BTF-info-generated-by-Zig.patch).
> Even though this just work-around the issue, I'm still curious about
> the current naming sanitation, I want to know some background about
> it.
> If possible, could we relax this to accept more languages (like Zig)
> to write BPF programs? Thanks in advance.
> 
> For reference, here the BTF generated by Zig for this program
> (https://github.com/tw4452852/zbpf/blob/main/samples/perf_event.zig)
> 
> [1] PTR '*[4]u8' type_id=3

The problem here as Eduard mentioned is that the zig compiler appears to
be generating unneeded names for pointers, and then you're working
around this in zbpf, is that right? It's not clear to me what that
pointer name adds - I suspect it's saying it's a pointer to an array of
4 u8s, but we get that from the fact it's a PTR to type_id 3 - an ARRAY
with element type 'u8' (type id 2) and nr_elems=4, no name is needed. So
the name doesn't add any information it seems; or at least the info the
name provides can be reconstructed from the BTF without having the name.

So the root problem here appears to be the zig compiler's BTF
generation. If there are some language constraints that require some
sort of name annotation for pointers, couldn't that be done via BTF type
tags or via some other compatible mechanism?

So I think we need to understand whether the BTF incompatibilities arise
due to genuine language features or if they are the result of
incorrectly-generated BTF during zig compilation. I dug around a bit in
the zig github repo but could only find BTF parsing code, not code for
BTF generation. Finding where the BTF is generated in the zig toolchain
and understanding why it is generating names for pointers is the first
step here I think.

Alan


> [2] INT 'u8' size=1 bits_offset=0 nr_bits=8 encoding=(none)
> [3] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=4
> [4] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [5] PTR '*u32' type_id=6
> [6] INT 'u32' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [7] STRUCT 'map.Map.Def' size=24 vlen=3
>         'type' type_id=1 bits_offset=0
>         'key' type_id=5 bits_offset=64
>         'value' type_id=5 bits_offset=128
> [8] VAR 'events' type_id=7, linkage=global
> [9] PTR '*[2]u8' type_id=10
> [10] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=2
> [11] PTR '*[1]u8' type_id=12
> [12] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1
> [13] STRUCT 'map.Map.Def' size=32 vlen=4
>         'type' type_id=9 bits_offset=0
>         'key' type_id=5 bits_offset=64
>         'value' type_id=5 bits_offset=128
>         'max_entries' type_id=11 bits_offset=192
> [14] VAR 'my_pid' type_id=13, linkage=global
> [15] FUNC_PROTO '(anon)' ret_type_id=16 vlen=1
>         '(anon)' type_id=17
> [16] INT 'c_int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [17] PTR '*perf_event.test_perf_event_array__opaque_478' type_id=18
> [18] STRUCT 'perf_event.test_perf_event_array__opaque_478' size=0 vlen=0
> [19] FUNC 'test_perf_event_array' type_id=15 linkage=global
> [20] FUNC_PROTO '(anon)' ret_type_id=21 vlen=1
>         '(anon)' type_id=21
> [21] INT 'usize' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> [22] FUNC 'getauxvalImpl' type_id=20 linkage=global
> [23] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=3
> [24] VAR '_license' type_id=23, linkage=global
> [25] DATASEC '.maps' size=0 vlen=2
>         type_id=8 offset=0 size=24 (VAR 'events')
>         type_id=14 offset=0 size=32 (VAR 'my_pid')
> [26] DATASEC 'license' size=0 vlen=1
>         type_id=24 offset=0 size=4 (VAR '_license')
> 
> 
> Regards.
> 

