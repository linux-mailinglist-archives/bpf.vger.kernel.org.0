Return-Path: <bpf+bounces-78955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9451ED20DE2
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9346A300C378
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5216C3396E4;
	Wed, 14 Jan 2026 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NuCDRaMc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="shaoZTOG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819532D0C9A
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416156; cv=fail; b=Gl25cQG7ILA1NS+CufNHuMS98gYnArg5WkCPuadX72fTj4KLcvwp4o02pS5PY7R+lGCrWps3dGAt4NcYSjEBQ3QqfISV7veh2iw+gdsl+aKnebO0g6iUBh6xxdePoghMBpJILWiRSp+010h8mkpeY4ak6y0NSj3WimPpL7R5g2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416156; c=relaxed/simple;
	bh=LOaT9FsS1pkZZ/kO/jEUQiYxxj30HEihhCCNJXp3AcY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k7z971MAlmG5euJIkNC7REO5f0dXSUt/X56AG3FURZFFASBbbU+TYjDvDS31cpqQjECKzIPcEjdt63j+9hxAw7b2qPGKu2MVsTdgZGrTCSgHDdgU6NwqYxB7GBKY2kMg2hs9nbY2d8UkhWHZ2plH5HPKdpRoTO8nY5CHaWMAbas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NuCDRaMc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=shaoZTOG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EIJfc51360843;
	Wed, 14 Jan 2026 18:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gxKZ4R/Aiyq5SGDptzvzaKyXZr/zUJd+tnH+g3pRYZg=; b=
	NuCDRaMc6Z480h/TT3S9QQXSb9RRxqAOvqPKqq0xzMbeotytNf+GGB7ehbHrZmlA
	L+Q1xqeUOtUoO/cl9fmdxnPfZSE8fvWEJEvj6w1WHz/pWNvLRNDDA82IH8dmhmS1
	3jJVXogimkOQAqbFuoRlD+winT3BpcUlAkrVGjRFinXpqwDn1CzRBlIk8o0kp3Pn
	JZ4PVMMHI28lYUpV+JI4yghNcSZXaXS0ldMPAHtbmaMoNVHunsEaz9LhDL5mfIld
	mHxAsdvj10Cu2jkBRI7tKP9tNogEreO0YVPATaLjG5LPkhst59T0RGKBbd5zwld3
	oR06+Z4cuS8yXVMlG6MnGA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5vp10vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:42:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60EHUE43004083;
	Wed, 14 Jan 2026 18:42:08 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7m6kmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk020lDxtAPO5OX0TFuAnwhn37m2YGT9AijylL6Z6X/3O/jzWhhZM/zEF1T/+vmzHtEWYcdamiLEDU22jsLO02bgjpSHWJhWADb80jyjIxGbkAdLN6DMCZY+BjTefO/0D96EXEIIIaDK5fec5LwBL65Rc4xkAYRuDhYs/ptrnA3TKQalVtlgt5J/ieZsvjA75S3Qbq/aJNlg8Oo9ZAb2+sA19J2GJbTjP6BVzTAqp+HK9Gh7viPCwA7u1gVm5USssO2Yhu6LZmhnSyHmyoQpWRx37QuRywU5D3gVzSL8lFb5sDie9lXLRmL3IMMSpIU7I153V4G89hpx839oWRUKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxKZ4R/Aiyq5SGDptzvzaKyXZr/zUJd+tnH+g3pRYZg=;
 b=QOxbweiuPdCIlakOYLOORE22tzusmDAGKcedih1YuFCTHrXxkDpuoRZQvu2iW7A0WW8eU7O6s3sWkH+kLEbVuy8/RfA392MMBuz8rAFgLApItrQPfuzcMPU4tEcj24AEmm9UFxRXzUWHSXhPb9dfSEk0xLxt6ZK2YSJgc5aPiEjGDwFpyC3InoPvrTveFJUcMeSwPkaYQtweElFnzgGvogEWs6Sre3bAwcVq0UCH1XTat3KaaaiRW/33ja7iGtmEOHoApZvzSt2X+SwvKUHy8cZWyDeSY8XlewHrioDU1RRMvgU/639eTRmcTyAZbjwQrepgpJst/Hz+2xhgOlUEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxKZ4R/Aiyq5SGDptzvzaKyXZr/zUJd+tnH+g3pRYZg=;
 b=shaoZTOGkNie9LWvVe+QTeE6/wzzC/9r9U+7k+kdycQ3mbUTbwn1d3Pq7imIQ92Ub/PaFjtu0iUeDAbZmQDHufi3ceCtLMZa8lox02N8BL749uBBi7Lxc7fx483Uy25YKGl5y5sY0dXyiW+95EFhIDcJ6NAqVqU2Ud6cUjdCchw=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CYYPR10MB7625.namprd10.prod.outlook.com (2603:10b6:930:c0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Wed, 14 Jan 2026 18:42:00 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 18:42:00 +0000
Message-ID: <5f4992c8-2426-4505-bc09-98cc673c2577@oracle.com>
Date: Wed, 14 Jan 2026 18:41:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: BTF dedup should ignore modifiers in type
 equivalence checks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, yonghong.song@linux.dev,
        jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        nilay@linux.ibm.com, bvanassche@acm.org, bpf@vger.kernel.org
References: <20260109101325.47721-1-alan.maguire@oracle.com>
 <CAEf4Bzaysi-ji0Q2m=6Fc0YTPnrKVOPDNoQW9Y6rB03R4Pe3aw@mail.gmail.com>
 <9594c48f-1651-4448-b8e1-5a8a07f64108@oracle.com>
 <CAEf4BzZzPRwEYqDotyHPTY9Djnk+PC1aBXeKKH2gtRqnp6e=VQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZzPRwEYqDotyHPTY9Djnk+PC1aBXeKKH2gtRqnp6e=VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0111.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CYYPR10MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b110af-6079-4890-4010-08de539c9a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnR2MXdqUnJ5R1hPT0xIbElUeG91a2piUlVjcGo2VVB1d2xtQmNoZjVpdm1r?=
 =?utf-8?B?MG8yMlM5ZGlNQjRiSnZHY2tkQy9nZFcxRjRuL05BUFl0b3lXbWt4dDRDZ2l6?=
 =?utf-8?B?U0dLUU1oOXZGdHNrZmFlek5nS05ZbGZTM25udjQvSHFoNVBsNHZFV2VTNjE2?=
 =?utf-8?B?eWU0bDZDWWdML2YzczNjeGkyeVZVaFhON1BFV3FoQ2ZHOVNTTEF0T3hPTTE5?=
 =?utf-8?B?L3RacGVEMXhlVGticnBkSU51dkR6ekJWY2xMMnE5Ukt0TGhmY0ZMbHR0NlZ0?=
 =?utf-8?B?b1V5QjMyWjcvK0gwNDBscWF2MDRyVllPNzAzdDdueWN1NlBWU0JHTDAzWlds?=
 =?utf-8?B?YkcxckYycEFGL0w4WG9XR21PM2lRRHczcm1yajZNdzZxdzVJNWk3MFdyWHJn?=
 =?utf-8?B?bWRncTh0d3Q4Z0R5RlJXYVhkaWthVFp0T2FLbG50d2V4ZkczTGRYejlvR285?=
 =?utf-8?B?V1QvUEI4SSsrVGo1L3BZV1JOa2pKQURqN3RhQ3RFZUZCNGVtcnhoMzNZdTdx?=
 =?utf-8?B?eTZNUDlPQUdmeXdYQ0NhWFhRTHVOR2VjU1JjWmhQeHFlcFJWMytjZzlleTk3?=
 =?utf-8?B?MnBCQWtaNHdoWVR5eTNPOXRJMkpYemUzWllQTGhiMFJmak1YeXVtNnlyYUYv?=
 =?utf-8?B?SDNnUXFkMlYzSFBxbXZGaTJhdmR1SnhaUVVrYnkzdWo2NlRhOG9RYUovOXY4?=
 =?utf-8?B?ZWNUVnk3V3V1ZEV6alFpTy84SFJSTHJrdjdpc3RLTmhUZ1FyVVhhVCtsL04x?=
 =?utf-8?B?UFVsQWxnSGF4ZExaVTJEcWNnbHRwWnYzYzJpY2kwUGhuVVRHWUFCVHFIbVpv?=
 =?utf-8?B?dUd5MU55YzJMOWZoUGpvakZQZm5UejRud2ZnVmRLU2RlaEdDM2ljWm45STdO?=
 =?utf-8?B?a3VFUDkvQ0lYOC9NMUlHRVJQSXlCMUJpbFZIeXBSSUh4eFEwL0lyN3NSTWpa?=
 =?utf-8?B?aVUrN0o5SzdKVDJRR3Q1VncyZi9HbnRCWnF6NGNUc1RTNEdwT1JyY3NKc0lU?=
 =?utf-8?B?VlhScVN1YUxVdDB3Smh1ZlA3MjB0K29ZeGYvaXhmczdtTlVqUG85RUUxenov?=
 =?utf-8?B?a0g3LzdEVDVtNTJhSWE1Y3hYZ3VQUldQZkp0QlJna2FncWlHM2U5VFNabU5x?=
 =?utf-8?B?NCtJT3pmZ3k1WU9wRXJlZVlXMGY0SkY0Q0gzbUtZeDNwQm0zTGFLRk1ZK2lh?=
 =?utf-8?B?NDREc1JrOU9lYU04eFQ2UzJxY2hKQkY3V1VHcjZCK2k1bXgzN1JEdXY5a2hO?=
 =?utf-8?B?V3hTcm9BSlEweVhZeVlYeWx1ZTZxaHVLZTdNQ1BQQnRmay9HWHdhSlB3TStp?=
 =?utf-8?B?NVJIT01SeUMvWUUxME1KdEdrMzhpa0J4MEFMUHlrS0VmeGdoMGF2LzJSaUhP?=
 =?utf-8?B?MklHa0MxUFVtMytFTEtkbGE4aGxVakZEM2dtZ0RMSE16RTAxUGRZbUNMdys3?=
 =?utf-8?B?b3VJMGF4NEpmeE9qRGdNK1Q5OFdBUy9ST0IzeG9zK0h0TElBd21ad1dkUFVK?=
 =?utf-8?B?VUlDMWhnQUpON0NVbCs5VFhTSmJtajlwMitVMTdiU2NQQldpVzBTNm1neEZE?=
 =?utf-8?B?dkI3V1NnbmRrMTFYY3Y0WVFxWS8wZzZGanBrTTRVYm42VFFTVFE0cXNERjIr?=
 =?utf-8?B?eFppc2N6NWpvdmF1ZjlWWWFaNng5QVkxcSttUGpPSy9wWnllWVQ3eURqZWRF?=
 =?utf-8?B?V1NlOUJuOFRWZVVaM2pmY0ZiajFHbWdtWXY2Qk52dWhMb2t4b3pPazR1OXNz?=
 =?utf-8?B?WEFXUXVjNEkxVUJKakwvSW5xNnE4NW1nMzZ0TU9FeGtsZkFhaEQ5MVQxNTdq?=
 =?utf-8?B?WTRZMTN0NStiSUFPcFFQZGhQZ3IzTFdQWWYwZE1QaFlRSTFKWkpVaXd6TnVF?=
 =?utf-8?B?VEVFNnpQRXk1T1VLRGxxNEUxUm5XeFQ5WEtWUnpCblpEV25UbHovMFFNYlhT?=
 =?utf-8?B?MTQwZ1daSm9Jd1h5a1B4S3FZYmtPUXVaNkFhMVorNVdPZTZKYmw1RlU5MDdt?=
 =?utf-8?B?SFR3bExvZkNOZjVRUDlZT25adkxObWpuN0RmaDJaTWJqYUVwZjRtRWRqSFpJ?=
 =?utf-8?B?SXdDeEhvVXNCYTFHdDJnRllSUGx3bis1alQ2cVkrRGx3djNPcHcvWUF3ekp2?=
 =?utf-8?Q?MVQmtshfryUdFTNWEvj2fnXN4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2EyQklKcm9FOFhKckNuUjgzRHp1b1NaNzlGRlpEWWJkL01Qek54VWVsa2xN?=
 =?utf-8?B?OEV0cDhTUVVlTUpVRjVJWmRzaUVYNHhvT2RrZjhGcU1MTURaV255NUlwODYv?=
 =?utf-8?B?RjBkVmU3MTgyQ3drQjlyR3JaYTZPa2xNRU9PNGJ0U29ZNkcxK3VlZTR5ajQr?=
 =?utf-8?B?MVkva2VNd3dyblFkY093QXppNW95Z0Q0WFdXb05LK1VvUFgvanJvZWhjYXRj?=
 =?utf-8?B?NkRITTJMc3VqSDVmMm1aSU81T0IvVmJ3WG9EWXF1UEt4Qmt6bmR0YWhGaW9H?=
 =?utf-8?B?Mjc0OGsyV0cvaXZJLytNU3BjbDY4Um8yUVlsM1JCVU1QSmhVTXQ1RVVEUXJK?=
 =?utf-8?B?N3BEc2xDTXlSNDA2NGdyS3FsSjc2RExvMGRYTUdzQW5OeVRkN01TV2w1VmUr?=
 =?utf-8?B?YzhPaHVTS2hEb3Y5TXA0Qkk3enBqc2xQRUF0MXE3bk9GY1MyUTJKT3FsWksy?=
 =?utf-8?B?U0tDbkVSVi9pV2d4bWdaNk5YNnd5eUJwUzBCWTFiR1ZYcmRiN1hSOVdKd1FD?=
 =?utf-8?B?OVBsZ3Z2N3FWNXgyZUt6bnVQd0IvNDZUbG5YZFZYOHNUQnBuT2lVbDZqL0Iy?=
 =?utf-8?B?RmVUaXZxUlkwSm1wejJrdk83UVhDM3g1UHpFZmljNitzVUUzcy9oTE5nWU1D?=
 =?utf-8?B?TjE2bXBsTFVQR0sxT3lxSXBJQmJoU21FbGNOOEhnZFVWV1pNUHNFOUdPSTQz?=
 =?utf-8?B?ZEJObjU5bTlPQUFrRnFFWmd0UUkrY3VmTUEvdTV3RUg5Y2RpT0lnbnltQTlo?=
 =?utf-8?B?bUlPSXJLWjh2SkozUGJZcWVVUWNtb2pLSjFwZ2JGTjRUM1hFWGV1UEdtMWRh?=
 =?utf-8?B?QjN5OVhKeTljM2EvZlBTRHFpaU5CVWdPenZHZUZ5SDBWZmNYYURIajF0ekhy?=
 =?utf-8?B?SE9SdDhMVFZNb2FhaUgweGhRUmlDK0hlWmpqelVxZ3p3K3VPeGhYMkQwNHdG?=
 =?utf-8?B?d1cySU9iQXhFVDRyNTdJR2llT0kvemhkOXdxTStFaGdTcUV3WjRsVzh0ZUlH?=
 =?utf-8?B?RTQwVitsQVJOZWVLNTFUMXo3eUo1NkNycEZKdW0zbVlpcFh4YlVSWkNEeDZF?=
 =?utf-8?B?dk8rTGtQSFZPWjV1TTVWSTRnKzJEYUgvTlI2WWR4c2ZEb3pzMGJrN2hsSkxS?=
 =?utf-8?B?dytVbjh2ZXlZMzE2OFRLQityTGJ4UHJZWmZybkdvZVlyKzRTazNNeEp4aFJV?=
 =?utf-8?B?dFpacVJRREQxVDIxUFBnOHJQR1I5ejk0SWJEOGVua3Nrb2RoUEJkeENWdDhT?=
 =?utf-8?B?V2c2SjZGMUhJNE9VNEtMOGlVZTc4eFhSMllMOUdpRTYyZWkwMEt5bjArRzh4?=
 =?utf-8?B?MXJOeGZFYUh5WUJzQlduUE02dVF0NmlGMlhLQmFpd2FRVVNYTjE5K3VZU3Vm?=
 =?utf-8?B?TWRvZlI0NW1pd1BjOWh5cGY1aU4zWlRBaGl1cE02OHEreXNCWFJ4SFJkczdz?=
 =?utf-8?B?eDMxdUs2QkpwVE10OGJvU1JBYUJPUHlESkcyR0ovWUh4R25zeGlhVllVTG0r?=
 =?utf-8?B?VG4rUmUrUXNKYTZGdmJ6UU1lVXF0UXM0MjlXL3ZXODVOTCtQcmU0bSs1WkFS?=
 =?utf-8?B?ZGhnY1hQYVNTUVdUejBRRUtxaDA2RHdLNG1tZTAyK1lmTHVVT3VzekFvdGJ2?=
 =?utf-8?B?d2ZVdG5DRHFkL2NsUSs3Zi9rTkllYWpRTVZtcTBJYlk5N0JSdzQ5cWV2ZHpj?=
 =?utf-8?B?bG1ZazhFSTRkUXp0ZzRVL1o4YndxSHpwV3NwVVFjWnpzM2QvYzE5YjZkT2hx?=
 =?utf-8?B?WFFVanRLZUFHR0dKdzJ5QW4vc3RpZisvazl3YUYwZisyL252Tm5FRDVSbE50?=
 =?utf-8?B?Mkt6amZPdEc1YzdwYnZ5cGxXbitsNGMzdWROY1pKMHpwK1oydm1xNVFxampQ?=
 =?utf-8?B?NzRmcTRFNm1PUmNyS1NIWk1mSW9EWG4yb21UQ09DMEw3OWpYSXJmVm5xeFJk?=
 =?utf-8?B?aFkzZFhBNlI1ZGhjZitLZzNCb0VxQXdUWkJrZmRFVXU1WjVWM1VXNDBsWjJy?=
 =?utf-8?B?ZW1XM3FDUCtkOUdJTVhxYyt3aWJJdTlWY0hZU1Y1eDVKT2hZRFZONUVxWmVo?=
 =?utf-8?B?MHZwdVRlUjQwNGt0c3VpaldDSEpaenVDYXV5NXNVWnFYbXpFZWF0QTlxQ3Mw?=
 =?utf-8?B?Sm1JQy8xN240VlJEK3dNNXRmaE12N1UyT1F6aHZhRysybyt6ZXZYVXFJZXQz?=
 =?utf-8?B?eTYxSEt4UzlBQXNjR2VDVGdEdGx3TTJ2dmdYa0ZGV1NEV3JwRHQ5WG1TaWxJ?=
 =?utf-8?B?bk52RGRhT0thZzZiU3c5aTZHeEFzbEtoWVN4REF2dXV5TytoekFFbEQ1Vlls?=
 =?utf-8?B?UWo2eSttbHFMMnl3TjlRMjVFNUx6aG1lOENhTVVTdWdIV0dwZXlWNWw2ZDhj?=
 =?utf-8?Q?gBDm/qjJXrOs0tGU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+2Bv3+H0V8iBbQDVjVafeJKj6sODdxWIiq6BHcIhkSI0Ut8lkBg2kytLtBCYrA2ljbEKyQqO8ufEzQx0UK0MYIv159XRK+9ix5ajKfr71lP76zULpsXSN2GVB0tjEtRw4oceI+xPqi4qZC5kzMftnhiAyHCUE4W7uQ4cTwE56+vOPshh7mQRB05+msvPIGQGU76D+fYrnIJteep6hdcSqI8gL7EBTCRrdSV5SW5z8CMIaNWSkOMT0u/60zy5VT1sE/N0R8MicL8ZweIWN7hzIsIGI/xY2RbCoUpPd/3fb3ZKzTtIFIOY5UwWVvkbsZjAWpjY2tCkPom/qzbmYWET80BZuUHLF+ShBbp7bQvv8r5HnzagTobNa8jgP4w8ery7tlueHRP2vV7EPhFHlNyPG8aevQ+W1hSLgbO0e5gQzIkdqCPhm27aaRXKf1/scF0bJVWqQPXYo0eRhnXp6PvLB4EYe27jBv5XWQRk/Rrdb6VMaBFd0hCkY52BhXgBrxY+kW6YUVp3wTzHptYHgKOwunYxv77sdhe5/zPimsVY0Ht3hLjWrnq/FE5iFi7167rOCrLjY0b2fyB28X9WgmaO27VCEI4pKHrM2jeBl6YjpeI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b110af-6079-4890-4010-08de539c9a6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:42:00.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkFO0T8rAq78S6CzjLJctKuhO0CersApEH6PYa8Og1EP/5F523bkNXcsiZ/Oza1mJpKjFtZ3uI8BMbUYufjvNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601140155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1NSBTYWx0ZWRfXyltcI3NAokB6
 rD1ie1zoaFtXmoKNtrmNw3ZNLoZjHs+CW+O7uvUQsAEwolwymJAPOeHBqQ8fXY2Z5SjCaXxGgl2
 dtdG+O3ZLpPv4vqgSNrCMQ30HiJAw1S0KlJWEVL5Nk6J8pd2E7Jjk3eee4pOAPVq7ldl7eSOnFw
 453OcFgsAQrLGWXQQf2Zyetp8/A1KDR+KW8ayBeqvXrKxGz6VBpkiGymxxIN7Q50Nvl8SoG392+
 gUeXZCGDGOmWNXjOeiWliN+zmahxBRvVp69M4s3DYQbWjRiMhGFav2EVxLGgR6GAm/XBYg6oLOD
 op4RE0laqSr5PBNxmawzACn04veD7ykii0XUC5BFZj0fUtAE51Su4yJDv/jVeo5xbRQ+2o5GkL/
 UYYfvaeqcIQDhchq3v+Nw2XFH+s60US7n+ksiT8aB6uF8dl22WNV3SMn2UMh/EwGtWnkZrzk1G9
 KBsQUJAMwPxjzCqhI3cIULiUK04Y516AbU8GeojA=
X-Proofpoint-GUID: ZAJdNMBvw7wYFoQVEBrYb-WQgTNiZAyR
X-Authority-Analysis: v=2.4 cv=aZtsXBot c=1 sm=1 tr=0 ts=6967e380 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Si-32d1KinXpA-sObKUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: ZAJdNMBvw7wYFoQVEBrYb-WQgTNiZAyR

On 13/01/2026 21:48, Andrii Nakryiko wrote:
> On Sat, Jan 10, 2026 at 6:05 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 09/01/2026 17:28, Andrii Nakryiko wrote:
>>> On Fri, Jan 9, 2026 at 2:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> We see identical type problems in [1] as a result of an occasionally
>>>> applied volatile modifier to kernel data structures. Such things can
>>>> result from different header include patterns, explicit Makefile
>>>> rules etc.  As a result consider types with modifiers const, volatile
>>>> and restrict as equivalent for dedup equivalence testing purposes.
>>>>
>>>> Type tag is excluded from modifier equivalence as it would be possible
>>>> we would end up with the type without the type tag annotations in the
>>>> final BTF, which could potentially lead to information loss.
>>>
>>> Hold on... I'm not a fan of just randomly ignoring modifiers in BTF
>>> dedup. If we think volatile is not important, let pahole just drop it.
>>
>> It's important to stress that the final BTF representation doesn't ignore
>> the volatile modifier; in fact it is included in the final BTF for the two
>> cases where __data_racy is used in a structure (in structs backing_dev_info
>> and request_queue). See my response to the AI bot for the reason we weight
>> towards choosing the more complete type as canonical.
> 
> I'm probably very slow, but I don't see how we actually consciously
> pick a fuller type definition as canonical. You have symmetrical
> single-level modifier stripping for both canon and cand types. So I
> don't see what prevents us from saying that `int` is the canonical
> type for `volatile int` and never really have `volatile int` in a type
> chain anymore.
> 
> Symmetry that you mentioned doesn't help here either, because we will
> declare success on the first lucky match, regardless of which side is
> volatile on (candidate or canonical).
> 
> So if we at all do this, we need to only strip modifiers on the
> canonical side, so that cand=`volatile int` never matches canon=`int`,
> but eventually they flip order and cand=`int` does match to `volatile
> int`.

I belatedly realized we need to handle the module case too; so we really
need two-way matching. Check out the test in [1]; it demonstrates the problem
and it failed with my original patch. By not populating the hypot match
we have proper two-way matching which we need for edge cases like module/base
BTF dedup and cases where one type has a modifier and non-modifier field while
another has another set of field modifiers; in such a case neither is more
complete than the other. The only answer is to match in both directions to 
handle such cases.

> 
> But even that gives me pause, because hypot_map on successful type
> graph match will stop being "hypothetical" and will be real
> (btf_dedup_merge_hypot_map), and so all `int`'s within that
> compilation unit will suddenly become "volatile int".
> 
> It's just a mess. If volatile is not important, I'd rather have pahole
> strip it out completely for the kernel (as an extra option). *That* I
> can at least reason about in terms of consequences. While with your
> patch I can't convince myself we are not introducing subtle problems.
> 

I've tried adding a test exercising complicated edge cases; let me know if
there's additional cases you can think of that might help convice the
approach is safe. Thanks!

Alan

[1] https://lore.kernel.org/bpf/20260114183808.2946395-1-alan.maguire@oracle.com/


>>
>>> I think BTF dedup itself shouldn't be randomly ignoring information
>>> like this.
>>>
>>> Better yet, of course, is to fix kernel headers to not have mismatched
>>> type definitions, no?
>>>
>>
>> Of course, but these are not mutually exclusive activities. Some issues
>> like [1] admit to such a fix fairly easily.
>>
>> In this specific case however the __data_racy annotation definition depends
>> on __SANITIZE_THREAD__ which is set via compiler flag, and there are cases
>> where KCSAN is deliberately disabled; from scripts/Makefile.lib:
>>
>> #
>> # Enable KCSAN flags except some files or directories we don't want to check
>> # (depends on variables KCSAN_SANITIZE_obj.o, KCSAN_SANITIZE)
>> #
>> ifeq ($(CONFIG_KCSAN),y)
>> _c_flags += $(if $(patsubst n%,, \
>>         $(KCSAN_SANITIZE_$(target-stem).o)$(KCSAN_SANITIZE)$(is-kernel-object)), \
>>         $(CFLAGS_KCSAN))
>> # Some uninstrumented files provide implied barriers required to avoid false
>> # positives: set KCSAN_INSTRUMENT_BARRIERS for barrier instrumentation only.
>> _c_flags += $(if $(patsubst n%,, \
>>         $(KCSAN_INSTRUMENT_BARRIERS_$(target-stem).o)$(KCSAN_INSTRUMENT_BARRIERS)n), \
>>         -D__KCSAN_INSTRUMENT_BARRIERS__)
>> endif
>>
>> So there's nothing to fix for such cases; for some objects, disabling KCSAN is
>> intentional. Since some core .o like mm slab/slub files disable KCSAN, the
>> non-volatile fields proliferate widely.
>>
>> [1] https://lore.kernel.org/netdev/20251121181231.64337-1-alan.maguire@oracle.com/


