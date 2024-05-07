Return-Path: <bpf+bounces-28835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5FC8BE4FD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD52A1F22016
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024A15ECDD;
	Tue,  7 May 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T+vhsr+X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yvQcClvz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF715E803
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090315; cv=fail; b=h9AAb0onQCXICUqHWggZeUFVaiAPIMA6yMjfS9vVSKTXrDLT4Q+QVCqouN4RxtHkz3Jwm2KBtEWqkSOQdbQa2KlJGsX9NfhVUj13QuSNsNMA4caawU+p5uFIwJRiRFmkXjeRNbA85B6wAy6udz8YnjFRbpOhCdSGFkx7NQMig8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090315; c=relaxed/simple;
	bh=DJh8Ya1E7+309k+DQLP7Oe4+ow6CHKheHGctdwJylsQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r8TyFJLxWQ6qDkwi8wMG6zpCOH6DY5E4rEe/4bzzL7AcTjr3e+wJiJDLM0kB2fSgCeuJCQ5CdsFETaS6QWFvqZ3jC3FPbcUMdsrJOQW/+eS9qVP6oRPQld+9rM0bWr+hUlEo9YNpBVaFm3ySdRWdAFJkkaLBwZqFdMrhHJu1oUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T+vhsr+X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yvQcClvz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44793xlJ020830;
	Tue, 7 May 2024 13:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=B5wGWngvrxlZgZnTIwYrYFOYoM6gDjulQAkKMxQ6Zx0=;
 b=T+vhsr+XuvEZMlsQWlQ0TOPyTUZGtqJ8z1N0bE+GQqbQuEIHTrnGnDc0IDOCZXOA9gjP
 pkkEzTKdf12l4KMZ0Qdsi9E9s1imV/blpP1gTduvOZs+i0lyj78lYM6XY5mO76OfEzzU
 T7TC7KUI7rFqteCdkUlzEgZvgUSfCcxZL3Ga1czbVBv86Mlj1P7rOy7FQcbyWmw1mIwu
 AC+ghK8yoTm9weBieFfzcKHmfBCDlRc/C9/V4jPZVqztE+L9Ae8AwdhccjCySrZilb7z
 XppdWhb80lQzqfRI6C5TH/69KQ2nbepS/38ZsDQdBLKTcqICEiqCjhwo+tS3YzfXGnQz JQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcmvd1ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 13:58:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447DCVar039378;
	Tue, 7 May 2024 13:58:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf71sr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 13:58:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKCnDh2c6OgM97ZJ79xvjSWjBXUR48a4DgLXiEbN5KUggQmEJA7bBYFchHK2YHyDca0VNRgo9y2/62nt1WT+HVER/rffWDrE3NEFjfBa+wzMiCul8bOhxOXJa/VD5Aqw9Fw4C+qDd94gTm4q3SinwUr1XRXGbVjh+7dYuB8rvefr2LyDSL8rtc/YWOZzgJK1AwEjiXnH5DcRBBNHu2dd21y+1Oc3sRSK01lW7/l7tyTU7tEwOtsoK0Wd25wGB9YRfL61JNaSx4vm7dh99RV/xTYcD6F/vRthYJoXOXIbzm1tsAo5GsNWRwzk6B0GoYQN/wrEjiTn1D76ABrut9M06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5wGWngvrxlZgZnTIwYrYFOYoM6gDjulQAkKMxQ6Zx0=;
 b=DSIvRiD9NtHkHZHny2Hkd94zTTMTTpBfotty0BhBQBoX7qsy2VQB60BsQRen7ghSrmnNfGei1XvIyk/YPbBofGtjj2RKtFCbrg73D4tZ6jxTkbSx9iR/EcLUUVhLiJ8zLGJnGUeT49W0qfifgwShO6l1jSIcPqQvSwOk8CEp3jLNmVR7SdbiB0D+veOIp2LFVKuI2252CtPqOcagvHFujXkgC+K3FYyXfOMr6QP7sO3k4us6hrMogbH1S/VyvrTiO/77GkYybcarvRIHcAtTvAF1SAwwf8y0jW2wW3Mueuu4zk7htophrw1HMUhH79P256X2aJExMJjnEAneji1TYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5wGWngvrxlZgZnTIwYrYFOYoM6gDjulQAkKMxQ6Zx0=;
 b=yvQcClvzp9qysh/Zd8yAu3VEFH68yHh2pIWllhChJ1L0DGJb7BW8A9cnpogNaBImZ+ofo+vq7uVkRlhag3g5tAIjJJqOB1aRPiRvb8mia2Wuv1s4bYc2V4OA+nXGllxmxsjEYJYV87nL4rgELcNaJVQ8BLBoOkWkHyNx9RI1vH8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BL3PR10MB6163.namprd10.prod.outlook.com (2603:10b6:208:3be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 13:57:58 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 13:57:58 +0000
Message-ID: <d3006cde-ef08-41e9-982f-d1e9690c5ec6@oracle.com>
Date: Tue, 7 May 2024 14:57:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] kbuild,bpf: switch to using --btf_features for
 pahole v1.26 and later
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, eddyz87@gmail.com,
        mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org
References: <20240501175035.2476830-1-alan.maguire@oracle.com>
 <CAEf4BzZPSer7EhZ1uJjQQEhPPo7U+dJJbQuBN+1bnJN64LyPRQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZPSer7EhZ1uJjQQEhPPo7U+dJJbQuBN+1bnJN64LyPRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BL3PR10MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 0492a47a-2eee-4567-c975-08dc6e9db390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WUVtTGk1YWVMNmtOazlJWXFLaG5YYjloeUtQblg1UXZYaVdtTzZvNDVpVFVR?=
 =?utf-8?B?dWVYbVhQSS84Y3JXV0cwUGs3NTE3eERTcFVnakZxZDFpUXZNSGR4N3hvSVNG?=
 =?utf-8?B?clVRMmZpNGdXR2VtWkVIK2dMeGJBYVhVL0R2ejBzSGluRVF2ZFFEMkZ3cUpu?=
 =?utf-8?B?RU50VjlzVnlRS1pFaEIyeS82cWc1T1pJZllqSWc3eFFONnY3ZllPUStqbU9p?=
 =?utf-8?B?dStJMjVvRU1nOC81VUo2dUdGejd5WnFjb2E1aHFzdFJzTHhnZ2V6NW16a3Rz?=
 =?utf-8?B?WERPMitndnJ2c0kvR1p3N2FsWlh6MEI5Q1dSaUdRZW1GYzE1RTkzRE0rc2Ez?=
 =?utf-8?B?MW9TdkFNbUoyL1djQ1V1M2lDdllEdCsvKzM2NnNjYUFiRi9HQ0I1WHg2cmhM?=
 =?utf-8?B?c1dVTktwd0wwNndjOGRlbHE2QkxYa0xlTkFxSWFGZThMczBYZ05ETnJ0Zk92?=
 =?utf-8?B?NzA1TDUzM2QxMWVsVGowWWI1eWtZMWRjcStqSTVOK1RNY2VqMnRzZCtDVURX?=
 =?utf-8?B?bFZSckdyVDliRFVkQWRrcnlnSHFTMnlzSmRrd3lKUnVkKzNZMHQ1L3Z3d0xp?=
 =?utf-8?B?VHhsbEFFd2FGU0dYaDc0dmQ1a1BlazV1TjM0a0IyNEVVQ0FFbnJMOFdYR1Q2?=
 =?utf-8?B?anV1ZTdVd1o4ZFlwU3Mvc0lMOXRaeTJ3S3U5OFhNTlZmRTNXQldEQStsejF3?=
 =?utf-8?B?SEZvMld5TG5XbWxhVzQrMjdBUG15dnFZVDZVWkUyODZGVmlGa1crb1BDMjgr?=
 =?utf-8?B?RjNmMDY0YUxtTnB5M21XVHdGdEd2MDNBOU1PMW0wZHdzSXc3eklIeWdjanN3?=
 =?utf-8?B?ajhnTU1wSVZrN2tadll0bnBaRklEUkpzTGxSN2pJWTJDU01aNjVvSWVuQjZi?=
 =?utf-8?B?d3pDeGJBUERPdDhCWWUyNUZBZHVaMnBDTHM1NGxPcnppVUtML2NtM05xdE9D?=
 =?utf-8?B?WTY2Y083MVhOSm5xcks0bjlIVGxOdUJyYldVeXlTbkw5bllqT083K2tRaUIw?=
 =?utf-8?B?amtRU3hITkxOZTdQMVpYeGlaUG1uVGlOUGFDbFh1NHZIRVgwVXBYK29DUWtx?=
 =?utf-8?B?VGJGMlpUNG9XWHd0YVptVlZ0S3p5MjdMVWxsL1dEclRrV0NTOUc4VUM5L0Q4?=
 =?utf-8?B?ZEk2a1htU0szM0pzOXE3S1AveFp5QnFNNWNxSFN5ZzdZYWVWM2FBTVErVnJO?=
 =?utf-8?B?cWl6djRtNUUvNmJNME81WnpBdkpWSFNUc2ZhQWhFN2FiSUlQNU8vNVU2aDJJ?=
 =?utf-8?B?MFdWeGx2Vlg1UzRpaUNIRXNJU2NPOFBUMDAra1F6U1NiY3AwbGFsSE42cjJ5?=
 =?utf-8?B?amNUZ0xBMzlDTUEraEVyWFI0VnRraVJpMS9MZHJRTnh1a2hncWFWbHJhSXJR?=
 =?utf-8?B?VS92Yk5XK2ZoY3hTdjZUdlQ5TCtVbEpFUSt2UkxYRzdGQndVVEFRZkpITGtK?=
 =?utf-8?B?SFZOSCtackE5Q3hIQVYzczhJdGVDQzdvTm5NdkZNU2pNdnVlZ1I1cnFHMDJz?=
 =?utf-8?B?YjNQTjVyVUlIL2p1NDFxNTAyQkR1T1VLbkJpY1dSbzhnZWpvN1VRNmhtbUl2?=
 =?utf-8?B?OHB2akZTaDc4RGxmeGhTbmh3YlJnV2tLQXlua0ZieHREb3lFajRJTGlSU08r?=
 =?utf-8?Q?tF9pNziJe1jCOotC6jVXQ5L+/zfHw2vcTlzFDZmVr+mk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VG1obHR2UEFiZVVHMGJTQUdCVWU2WmdBZEZxV1pTN1NqQ2RnRncxWnZVeTFZ?=
 =?utf-8?B?bVJSbWhRTVoxaVV6WTA1cExnRCtzZzNhS2Q5NjJrTFJhbnBOM1NFdXpzTXZC?=
 =?utf-8?B?MERhSUhZQUo1T0lTNVpBbFhJaWtJbEdSNG9sdGl1VCtaM2VmaGtWcUVZZm5C?=
 =?utf-8?B?U2IxcFNGY2NoOFVaS0Q1MXZ1WXArcUt4YUVQdmVucjVXVUJYNzllYmgrTUdo?=
 =?utf-8?B?bmVQR00ySFEwZ3IvSjFPMmJFOXlLZU5ZenVQemV1NzdhQjZWbzZFM2tweXdR?=
 =?utf-8?B?NUNVZ1pqejlQL0c5YmFCMTNZa3VOaUdYUGs2NGxhbnpEMUtuWUhNZUFoSUJy?=
 =?utf-8?B?b2VXVWlBaTNCSkphZ0JwSjB1NWUrSWhJMko2SU1lVW1UR1NDQlNybEVYVnVo?=
 =?utf-8?B?Yi9zNkE4MmRsMUt5dTJpNnY0MzdpcVZ0aHBxYWVrazdsdVRoWTgvRDVIQlNy?=
 =?utf-8?B?akIwMVpsSjl0VnBIRTU0TjFhcjRIVGtTSXNGNFlTMkZ3NCtZUjBrL0o3Y012?=
 =?utf-8?B?OG81eGpvdEhZLysxNDF3dmEyeGhWc0FPdFJpZ0xISm4wZ0lXTS9aVWwya0xX?=
 =?utf-8?B?RXpKL0JDOGJOV3Uyc3YyelU0WTVkb1lkQVhNZGhvQTVJYVIybkpiVWVTTmt1?=
 =?utf-8?B?ZWpXK0xGSzhEM0JPeTBtbXEzcU9iREw2bG9rbGR5WEJXRCt0bnViQndVSW9j?=
 =?utf-8?B?NnVvZHhXdUNwczk1LzFwZ0pEV01xOFd2UW5TNnJ1THpsVmhVR1IwY2U4b3FE?=
 =?utf-8?B?M0NIeWxRbVJGSGVzNXdveDhPMEZ0cndQQytwTlZwZFhqOEkwdmpna2tuVXdD?=
 =?utf-8?B?bkJPNW8zWjNQT3FucWtMWEREeVhFNWgveVlZNjl3ME15aW1WdWVJeUtCYXlM?=
 =?utf-8?B?Vi9lZW5UcHJyb2JtcWc5ck0vVjhLMHNKZWVyZzEwb0txc09hWjYwMkFaYjZG?=
 =?utf-8?B?S2ZuSExxMXJPeWJ1TWVTYUNobUl5V1cwK2NkL1VpWXc4RkdtN3lDK0ZGTEoy?=
 =?utf-8?B?cW82T3Y4eFlxUGd6SDJSdmdLT1NFdC9hZGVIMVg5WVdIQkNuVkJHbTRvV2E1?=
 =?utf-8?B?UHVoTThmcTdSV0JZZ1Rkek5EVldCWkpJdGhXdEVhY0E5MDZlbGxhU3BzQlRD?=
 =?utf-8?B?M3ZEdmZBRG44ZUdBM3luNU5NVTAzZklUNldoVTFVd05TaHlmU3Y0dVh2VDFO?=
 =?utf-8?B?dEpmNG1QNVFnVkdpVDlXdTV0NXo1MHgwL0tiVExZVFdjN3hZOFVLWjhleDQ1?=
 =?utf-8?B?OHUvWDNYMDlzdExTbStBb00vMkprcEdFbllkYlNiczU4a0VSVkpWWjNKaXB5?=
 =?utf-8?B?SjZjcE5nSlJab1ZIUHEwK09rWW9nTEUwUndBeHFRQ1dUNHJtN2l3TUtubWk2?=
 =?utf-8?B?R2lxTk9lbzBORGZqR3JEWklHVEVpUTdZU1VwRXk1MGpjY0lsNmE2Z3N0MDNK?=
 =?utf-8?B?dGcrWEFQTnBlVEc3Q3hnVmtmcndrY0p2R2dkeG0vdlF0enBOT2RONGc3RGdv?=
 =?utf-8?B?RU5TN2VBTmZWVWc5eUNIQ2RzYmFIbmExRHBZeXpxalNQczdyK1NhS1lkUDRx?=
 =?utf-8?B?eXVxcmZrWkZ3NEgzU3V3L2RxVWR0QU1hNGFJeThJaEFpdVRxTy9wRDZ4NUJq?=
 =?utf-8?B?U0ZIbHpRYXdzNHFHU3l6Z0FNT2UwOVpmajRHVW9kU1paMll3SEdGSm4yTlFP?=
 =?utf-8?B?WHd0YUo2SWZjK2dYRWphS2Jnc0F0NkFYb3FMWkVQNHNTL1J0YnIyODZJUmty?=
 =?utf-8?B?QStzQ1gxSjFSeTFEN0VGLzhneFRuNmt2enFZZlFGVXYyZzE0bnRhMUEwY2Vo?=
 =?utf-8?B?QlQxaDR2c3dqWDBHTDJHQjdCbTZjeHpEK0w4ci9GVzVSOHBFUUgrVGZRa0xJ?=
 =?utf-8?B?Z3JwRllWNHhCSExsL3d2aVZTSzA5UEwxZEd0ZEh6eUhaVkVBVnRvY3k1UW5Q?=
 =?utf-8?B?WWZReVZxNHpNZ0o5MW1WS0JpZ1VrV2dhSVE2ME1sSW1lMXNKd1dabnVBUEVG?=
 =?utf-8?B?TkxDZk43NFVXd1loZkw4cE1qeUgxcG8rSzFBVUdoa3B6Z3pHQkdmT3FTRFlM?=
 =?utf-8?B?alNZMFY0b0FKSVZ6clY3aHFXVTdOYUUvR1ZKMktlTWlYaVh4U0Fud0xsWFB4?=
 =?utf-8?B?RUEvRjRkMVZ0Rk9XdXNnUmp3aUdtSUg3RTBDUG5Gb1ZPUDVadDlXOVArZDRh?=
 =?utf-8?Q?5BC60EGFvLFef0680qeg6K8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	px2F1ykLo6hZICyB/88ZvlCsQMlpK2Eel1gLFFm5QDS0/O8btQ3TElsPu7gEfmeUtcNqO+qH9RrgShy7DiTI4UGlrtR5/Cn6tl2HfDHkXFIb/6a8NCRnNrxI55UbbGqtnMDqiGBJgMuM03b0yf0Fr9vBXBIwTxQ0m9CkuEQi9nXcmXnHkxeF/Lm39gveaN6NQ7X104G3ph4XeHH44dOvjxRxUrILp8gb/JY9ueY6r+g0evLK8hYVXEaxhgLd09VdpzFbyi2+uLSYBnQ8wDnPdex0YyZBPK/dS7dFOoJzhyg40A+IKfH1/YUZELm3UlO53MbN7AtTMakB9pO4Dmb4XzkcSAsM5S6fdZEFkKk3F+PIiH0IrUh2DGx3Ujub1ZsB1zjgP8fhZ1rfBXmDb4rybqGWl+ZVUqTRd7xgU9Jhl1CQbtiEX+eKU89Km/wtjx8xXe5d5enPxMNToBvmuoDLZJTIQ6wm0KY1J8u/ud0nIeQ4tPAuPhxTaC+OYRJVy2f0vh4MatvY44vPTzKOFTof+DxUv8pSUMnqaWXkDtCgO51F67K47ea0a2RLKhWqhE1BMz6Crj5UDgFOtJ7tb2ZKv5LRqEUVn2O2a7fj5h/+9Ws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0492a47a-2eee-4567-c975-08dc6e9db390
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 13:57:58.3287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OnCghPL23/+Y8z+51n/LHSYHmTWmXGgfMbt3TcbTBARYfBjqNsHPwC5i5shjrCBMpxfKhXla6d4Xqckfbl6lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_07,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070096
X-Proofpoint-GUID: PqK8GT3HKzo5IedjLPIBnD0GFI2ZGP-u
X-Proofpoint-ORIG-GUID: PqK8GT3HKzo5IedjLPIBnD0GFI2ZGP-u

On 07/05/2024 00:15, Andrii Nakryiko wrote:
> On Wed, May 1, 2024 at 10:51 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> The btf_features list can be used for pahole v1.26 and later -
>> it is useful because if a feature is not yet implemented it will
>> not exit with a failure message.  This will allow us to add feature
>> requests to the pahole options without having to check pahole versions
>> in future; if the version of pahole supports the feature it will be
>> added.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  scripts/Makefile.btf | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index 82377e470aed..8e6a9d4b492e 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -12,8 +12,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)     += --btf_gen_floats
>>
>>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       += -j
>>
>> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         += --lang_exclude=rust
>> -
>>  pahole-flags-$(call test-ge, $(pahole-ver), 125)       += --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
> 
> given starting from 1.26 we use --btf-features, this should be `==
> 1.25` condition, not `>= 1.25`, right? It doesn't hurt right now, but
> it's best to be explicitly that below `-j --btf_features=...` is all
> that's necessary.
>

Good point; I've tried to make this a bit clearer in v2 [1].

Thanks!

Alan

[1]
https://lore.kernel.org/bpf/20240507135514.490467-1-alan.maguire@oracle.com/

> pw-bot: cr
> 
> 
>>
>> +# Switch to using --btf_features for v1.26 and later.
>> +pahole-flags-$(call test-ge, $(pahole-ver), 126)       = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
>> +
>> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         += --lang_exclude=rust
>> +
>>  export PAHOLE_FLAGS := $(pahole-flags-y)
>> --
>> 2.39.3
>>

