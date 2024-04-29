Return-Path: <bpf+bounces-28069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E28B564F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 13:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AC0283B01
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6D33FB9B;
	Mon, 29 Apr 2024 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Os6cw6TU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OwecAYbU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ABB3EA9C;
	Mon, 29 Apr 2024 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389416; cv=fail; b=dWGNlqA4dUsdL/sGBDEhtgyf7pKG2JkX+AbEXw4QEMxkPaE/xseadtI1CjHvSLC45nK46g55qRzjUq6YZ2tiXWz9vR729pTYYWXnpxY741N2Gkv3SniSKwmf8jC3pdf9vcdv25St1aNBqgmafZhJjBFy+okpTqT/UZLXUq+TDDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389416; c=relaxed/simple;
	bh=hM94mytK1IiciIseZ5zFReI4WcdN2xfg9EISPBC47mw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HRQ2FgaLXlQ/Rm4exUDcAPiZIOlXokyfc78Wlv1WYNuu6bA5GxDO6+n+d0KzLTv8CWcwsj/KnUXWmJ/wodT8UoZI3it2Ktc83B4LFvVypTPJlTsKijoYYJz6hSBuoYIGaAII4lnWjY/1M99Crb78gYa5t9Gd6UtA1u+Ul5yt2qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Os6cw6TU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OwecAYbU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43T7jFRu019157;
	Mon, 29 Apr 2024 11:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VgdA+Q5bW0QW6/BEuxcg/yC/Y5T2eo3ed7unmOrBP/I=;
 b=Os6cw6TUK87qnwRRO/Ii8IZfMyOkm95pBzvnMH+H4Q+LAOczCGjSFVKaMJOYtnEOQlMB
 OGLHntge1keZMCYpOmRCPxS1mzgV99lkR0F/VW2AQFYTTv5SoCBBn9l71z0pqbJaeHJe
 YF9jy/59LEMJY9+a1nPaYwKCWtV+TQmD519C4PZZaVZEYXAh75svFHnuSvgRRZl6OTqj
 xXQFddbhB/EF/z6pUJKtiq0culNPKy+KstMe3vMK+A/DnaQn/lhHxHavWLI2rWwlTwx2
 z+9yHgH4NuKL8N1/Vhl33XvGv3ytwi64Nu94J06hgf1HFuAWGHA9i1eLaF3BXrg8GcTQ qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvjagv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 11:16:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43T9EX3K004317;
	Mon, 29 Apr 2024 11:16:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbp6f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 11:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlkAKMPkWgvtwp4eG6LKUMfHRG90oW6YB+Tq359MyjxXHo8J25OAhfwmD+8XrGvnTyx4hHP2r+GLVvaOL9Z9Tb9fMIQMnIKU4A2GzoxuN/QV3LUIO6qvdzlkT3ZFsGEVQeas3qXvqby3wDbU7j3hh2oP3YFNVfS3vW8uYWHgGP9wUTwQ+j9kL3nLCPCsyVckJOJQujTAUdGpK6ED7usLHYgrUDZToEOKMPl1gdIYpcyej4GmZDVZnKGdSGxguSzz5Y4wKnbtTgL/iEeLxHKP9qj5KkgL0nYSFI09Nvrb7GCAhGul6pC26xVbwsWmd8mZejYcQMGAjSLUTNvOb3bdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgdA+Q5bW0QW6/BEuxcg/yC/Y5T2eo3ed7unmOrBP/I=;
 b=lOOICUv/fLSx/qTnwsL03twpmAlU4LyfkeL0Gou6C83IV4aHNcGGVFSneWPRqhE+pGHDViOcTVR6JokBdA3K++sFJIn+fWGhxFTlAvqVN4Nyo6drqmac4tWjLAifV9pbj/jBfxiTBJD/GUKG86BQm26YfVGnOQPeoctehVK9ohllOTYFOklWGKW542776tKO6r6c+3IsE18rw+tD4m6eoZRUzbzFqv9xK9ViZxHpGezHSZadvWaPosp0afAK5UO5j5infAsvzgkZVkvXdFRERdyiFgo+8Lm5DWru09sxnekHLdLiSR1nC1MSKbPqz118l0yFuhHdNi1NYxsSP2numQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgdA+Q5bW0QW6/BEuxcg/yC/Y5T2eo3ed7unmOrBP/I=;
 b=OwecAYbUk3VB/zxwtP69ZCsUdla1zwdaLHtpUT9aIuoDywqyg+SsZNzlYZ468EurtxX31e8lnCP4FQ3hRTIoSFq8aqnxqv/jdaP794o9rNYR2INHVPgYQ6p5ifDxbjYhuj7O55OxbnL4IY/rgS9LQS8KPzbQVqWSyMUwmzZtI08=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB4893.namprd10.prod.outlook.com (2603:10b6:5:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Mon, 29 Apr
 2024 11:16:35 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 11:16:35 +0000
Message-ID: <d9e3a7ab-9799-42b0-9c6f-1809a0527867@oracle.com>
Date: Mon, 29 Apr 2024 12:16:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pahole: Allow asking for extra features using the '+'
 prefix in --btf_features
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>,
        bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Daniel Xu <dxu@dxuuu.xyz>, Eduard Zingerman <eddyz87@gmail.com>
References: <20240419205747.1102933-1-acme@kernel.org>
 <20240419205747.1102933-3-acme@kernel.org>
 <CAEf4Bzb0pyc_0AuP3O6wekpR3YcfEkk5bPGOOmS6_yJ3G5bKwQ@mail.gmail.com>
 <ZiwS0_O_CTesvjLC@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZiwS0_O_CTesvjLC@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: c142b657-1509-4d64-1751-08dc683dd4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SmlWVWJGN2FEcHFLQU9zVXZPSW9UUjBJWjR0VVNHbWt5aTl4TWVRaWdTMURh?=
 =?utf-8?B?WXhBc2JjNVB2dDdmOVVMb3ArTE1ocllvN0NjVUhRaUdkT0FTaWk2LzI4Q3dU?=
 =?utf-8?B?cWV4eU9GRWdTZ3ZYRHdmWjJqRmQ3TG9pZk9QdlRaWVNmQUpiQ1BoM0hPOGdt?=
 =?utf-8?B?Z2Jrc2lRNUtBMFJ3MWsxYWgyWmdIRDd3T2FxT2ZkUENjWml1N3BkUzZwK0dt?=
 =?utf-8?B?d2JNOE5IMnA0S1d4MkovZ1VONVExRlBoZXVxOFlZakthdUlQQWp3dllNUk5N?=
 =?utf-8?B?RUNCamVMVTRTVFdtaFNPbTVRWlpPOEc1a3dSaGZ3U0VHcHc2ZE8xZjNUeFY2?=
 =?utf-8?B?SnEwSkdTRmpheXVqNEd5VXhFVkYrVzduczZNdGM2NktNeUxQRXRBbzRvUE1E?=
 =?utf-8?B?UVBGNEdmNEtabk51NHprTW5tNmdYZmZNSDJ2MVp4eXZFSFVnbXJEK0s4VUZ2?=
 =?utf-8?B?MGUzUnhBaWNPbFNoUmd5Y3EwMXVsdHZCVG1hbUN2dUZRaWM2K2JTcmpZUmxR?=
 =?utf-8?B?ZGhacktOVzB5UHNjYk1aVy9UQTZSWmJjTnY5ODRaKy9iWkFKVCtoT2xiQVdO?=
 =?utf-8?B?T1RpVUYvd3hwMllXelJ5RUdZdlNtMk84Rzk0WUpyZFpTVTBUbW16L0pweUQw?=
 =?utf-8?B?NGdyQVZadWYySXYyRmFtMUVlQnYzTnJ4U21IOG9udDl5WjBiNlEwSGFzditH?=
 =?utf-8?B?RUdNbUhzSzAwMVZQeUxrM1FHekdkeGpSRm80WGhLV242ZHVyS0IvSDJhdjhy?=
 =?utf-8?B?VzliakhseXlPWU5kMU83cmtHVnZyZjNvVGNKcGMvdzJKMWFDcUJZaTREUjhI?=
 =?utf-8?B?a25BTHptajVBcWlxNnRZZXZvc3crOWdGM3lwSGJUT0pDNDNQNTBMVXlSWCti?=
 =?utf-8?B?NTh2RXMyQlhuaUYzUU5LU1ZCc0dRaUUxOFZUb2pVOUk3WHRNaDdnV2xLeVMw?=
 =?utf-8?B?elNGb2VoaENtajBEUW41c25PUXBLajlHVFFrOWFIQUx1UWF5Z21SV2I3R2F5?=
 =?utf-8?B?ZlBDUDRVRVdsUFJJbGZkV1lrNTVWWWp0bmpsTkNveXh1UnRQQlQ5YUh5WGF5?=
 =?utf-8?B?SW94dGk4bEhVcHV2V3VndkIvSzdoMVFLMHJUcFZLMnpPQnJTTnFaYk5tdUdo?=
 =?utf-8?B?c1REeGMyajhzMVpYMnA4Qzd3K1BJSzRVRTFNclNDWlpNdjloMGR6SEczVzVi?=
 =?utf-8?B?OFhnVS9NbGs5M1JBMXNrU0ExeWc5QSswWE8yU09WRVRDSFVlSThYQnIyc1lX?=
 =?utf-8?B?bFNBYmc0MmhPbGkrbjQ1K21lNHNGVXpyeE1iRjQ5c0RCVEJOSVJCekhlUjUz?=
 =?utf-8?B?L0pqYXZrdEpoVWdXYVV0Rm5xdFgzWC92UG1pdjd1c0VLc0h3RjAraThJZjB6?=
 =?utf-8?B?SUF5ZWhFTStXUFJBdUtVYjdpWUpQSmxxS0N5RlZmM0Z5TUxSeVJ4dnNSbFBt?=
 =?utf-8?B?WTRTLzNrWnRURHp1NnZmT25YZDJKNTJIWmM0MndPQjlXOWNpcVpuc0NXQ1I1?=
 =?utf-8?B?QUtVdDdMYVJQVSt5bDVCcnVZUVZTYkl6THZ4cmtiK2hBYW9tYS9UU0NDV3JX?=
 =?utf-8?B?aUxyWllKdkVBMG9xbWxpN1Nva1VYditvQ3pQb0hMYkNwUlhYaE5KQ00wQjJX?=
 =?utf-8?Q?ghBN4QPxdMkFKtF9UpYjWyHtVyhxg/SYxobOgx+1GLp4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2VJMExYa01jSVFsUXJDRDR0T2swVXRSNUM3Ly9ocytwWS9Mam9sR1c4V3lv?=
 =?utf-8?B?LzNjK2l0cmtCU1FhTU1IK0JsOXBEUDFQclIyaFZaVDFHemZac1I2d0ovckRa?=
 =?utf-8?B?L1pBcmhyTTcvTyswM3NVU01FWjA4UDM3S1RtbW5wNmR3TldLNHRhZXMyT0Jo?=
 =?utf-8?B?ZFZjajFuUzNRT3JEYlJvd2Y3c1BJZkNKQmxORXlRZUZMenA5dS9nSDhVK0JV?=
 =?utf-8?B?N1pST2tXKzFIR05rV1NKUG5jR0pjMW13cENCSnF2a0l2OGg5d0xRZVN2bkRo?=
 =?utf-8?B?Q29xTERTSFBEMjNybkpxM1o1Q3hwdnRFUlNKcTJZNDlqMnJPbTJ3MUdNcWlO?=
 =?utf-8?B?elBPSzFLZWVUaWo2M0Y0T2Z2L0lzaldOcTZmUWhVZWZ1U3JwM3dvaUs3MWtH?=
 =?utf-8?B?NEV6SDl0RVhzUlBYemI1STE4amhocjF5emhpN0x0QTdqZDNhVnFOZjRqdW1l?=
 =?utf-8?B?amtoeTcxZG1TS1JjV2N6ajR6Z1pGREdEejI1NHBJS0ZuOXlvOTB3OFhoRUVF?=
 =?utf-8?B?d0VnaHhuRFpqdHJiN0JIdy85OERZMjBteHRsYTlZNFFzeFJ4L2V3WFc5QW44?=
 =?utf-8?B?ZWExVHI3RHpaUXVwRk1Uc0xJdVRpcW1XMERGbzQ1VmNLTFd0TTVTZHlFc2J5?=
 =?utf-8?B?b3pybUxTckdqZFYzSGZYa1pyWDV6akxIMDBQc3RjT1c0M1FsUWloTUFCN2xo?=
 =?utf-8?B?VkhXbkpGNUtiSHpCbEtmRi82NFRQVXZRbWxLdXN2WXg4QzNMUDk3c0VtTGUr?=
 =?utf-8?B?WkJxVXhCZXpQczdKYTdXWk9IQk9Dbk05YkwwT3hrNXlORUJ2VWVQTVVVN0Rm?=
 =?utf-8?B?VkdNUHArSGtrdTUxZmtNcWV2Umdrc2JQQ0x5NjgzQlQ2UW16ZW9nQVVxWW4v?=
 =?utf-8?B?RDlNcS9OTzdmMXk1YitQQk4zOGpHWWRaTTdZMy9ORExyN2tWMkpQWHRVb2hN?=
 =?utf-8?B?Um1ZOXJGU08xZWw0ME91ZHdCbjFiSHdraXFpUEJQa3JkQ1gwSldZaU5id05Y?=
 =?utf-8?B?RjhlVDF5RHpvVDBQSUdBem5jdU13b3kyc0tmMUtXaWhkR3lDWUdtZzZMODFZ?=
 =?utf-8?B?R0QyVG45RzhFOUZrR1plZVVLY0tac2d4U01kQkx1bEI5QTRKeHdXUXhmTWNH?=
 =?utf-8?B?TWc5bXZFakVYRDViMDAvYWVGcWdabjJrc0ZmNzUrb1hYZ2Erd0pQRjhBUVg4?=
 =?utf-8?B?TzlQakhVa1A4Mlo1bkM5K2M2UG43TDBaaW1QdDJKL0NkN2h6OTR6Y3dqSkZD?=
 =?utf-8?B?RSt1Njc3OGNiOVVBWWNqdDZyc04zcHJnV0pIbTdjL0IzT04rK0t0OGx2SHRu?=
 =?utf-8?B?SVBVWUhCN29DVVd1eDVoL0NCWWl3MFMyeHZ3U0FFRjBKK3E0YTVYeDkyZHdZ?=
 =?utf-8?B?UDVHaDM0blJPSWxsYWZKbUljQjh6cWp5enkwSlVVVEtDSk9pRUQ2R3lOcFFJ?=
 =?utf-8?B?TjZsM1o3SFIwZWUwdUgwNjEvTzRmU2VkYmRFYTQwdndhdFREaFpDS0VtdzhN?=
 =?utf-8?B?U2gzZGpBNG9kWEJpZlg4dmtSVzFhVkFKWEhFRlozTUZJVUlkSmcyZmg4Rmk4?=
 =?utf-8?B?NlJTVThYTkpsdGd0bEpXcStLZVhHQW9naGIxSGJVVDFPWVJ6ZTFSeVJDTnpO?=
 =?utf-8?B?NlhsVkhlUDFpVTBaR0lTTUdLbFJYNDAycVprQmRQU2lkNHgxc3hQR1pYdjQ0?=
 =?utf-8?B?SFk1QkZIRmFXOXJWYkhaWXVMVjluZWhnWXRFaE44NmhGa2Y0QWtNaTlHQXlw?=
 =?utf-8?B?M1hzL2o2cG54N2NvczViR0N3MnprUTU5OGljK0tSWGtxTXNRczVET1QvZ09P?=
 =?utf-8?B?Y1V3N3Q5NmxSNHlSa2crRGo5QmdkUlRGOVJwSUJTVmJaT2lvYWxrdnB5WDd1?=
 =?utf-8?B?OG5ZbGtNcjRlK2J6OEhNdlByeTlkVFdrRW9Hc3hWK3lNb0VaelBBanl5QXl5?=
 =?utf-8?B?TGlNV0ttanRKVlhvb2xhVitUdFhPUVJIeklGSnlaaHRZT2tOa2kzZ3REMHkw?=
 =?utf-8?B?c3ZPWThET1dsS3FTMXBXdGZMckE5cElISUVWdmcwR2ZGLzk0NkVQQlJtdEE2?=
 =?utf-8?B?amsxY3ZuOUorTkRsUmVQTnkrMHhqNXI5b2lqaEk0SFRneXdTa2VKNE1WUWxX?=
 =?utf-8?B?RnVoZHZsMlZWZGRlc2p0c1JNRzROQW1lRi96L0krWElOdWhxRzczWG5CWmcy?=
 =?utf-8?Q?OKMVHw8gfbcNRC2MvtKvu0o=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bG2B8HREFWkBEUkY7pkdD6uPe/y/1deG1anrYnMLMhcwrvtGcfVbbP9D3m5+S+PMcPnr0oHRxjSDkX3YcCubJs3Xh47qMREvilPK09PVxoKbhXFndL+G+W5fb1ehe8V3p3s+tFH5QS/Mj7/vzu/MHRWmGx8ecL/68vB+dL3goUsVqZXxO1WC+tLg5yyRavu3STKZduuZyPV2syMk0iilM0MmthwXUBZZGrqH1fQCA3/o2e3nAyFF6MEFrQNviw5g8HBxgEzKWqmWgGaxahv1j8n+CifsWNBUBW8TCpmj2GGW0IK/5/qUxM5J7aJVUwWmn5rqiV+rqBW0QwkPTkgA1vLoQb9kF4DeY3v+OTRDutuDkpMGBZbfoIWVOgB1YQO252wz0lWLsdCiTOXHKwxKldZrf6PhqJJaBpw1MVfigrN7DdPzBQiaoe24Eb73NEoSfPyCDHgtM+5zj5ZPzTiVQwBk1dGseIQiH3P4VQvYA3TKX1JAMBaeqizp9HuiC9AbRo8sx3hyAYNUaNDiXJesjUgo1TkHbqEFmbWuJHga+7nZqsUJAPhaDorkR5YrSHAC4cg8tHhDkq+dCZdQUMm+iVO9o1TGOfXFcwWq7bVXTX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c142b657-1509-4d64-1751-08dc683dd4ac
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 11:16:35.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sj15jjVtHlQMKIlJ5J2yeQutVYxrVUCrXowAWOkph0T/HCvJZeQRXHIespk8HfkFFqrwIEJ0NEpVZjHcnv1mTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_08,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290071
X-Proofpoint-GUID: 2k7fj0lDflwzfUpe7H3d6inEmzT0NKqt
X-Proofpoint-ORIG-GUID: 2k7fj0lDflwzfUpe7H3d6inEmzT0NKqt

On 26/04/2024 21:47, Arnaldo Carvalho de Melo wrote:
> On Fri, Apr 26, 2024 at 01:26:40PM -0700, Andrii Nakryiko wrote:
>> On Fri, Apr 19, 2024 at 1:58 PM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>>>
>>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>
>>> Instead of the somewhat confusing:
>>>
>>>   --btf_features=all,reproducible_build
>>>
>>> That means "'all' the standard BTF features plus the 'reproducible_build'
>>> extra BTF feature", use + directly, making it more compact:
>>>
>>>   --btf_features=+reproducible_build
>>>
>>
>> for older paholes that don't yet know about + syntax, but support
>> --btf_features, will this effectively disable all features or how will
>> it work?
>>
>> I'm thinking from the perspective of using +reproducible_build
>> unconditionally in kernel's build scripts, will it regress something
>> for current pahole versions?
> 
> Well, I think it will end up being discarded just like "all" or
> "default", no? I.e. those were keywords not grokked by older pahole
> versions, so ignored as we're not using --btf_features_strict, right?
> 
> Alan?
> 

Yep, it would just be ignored, so wouldn't have the desired behaviour
of enabling defaults + reproducible build option.

> But then we're not yet using --btf_features in scripts/Makefile.btf,
> right?
> 
> But as Daniel pointed out and Alan (I think) agreed, for things like
> scripts we probably end up using the most verbose thing as:
> 
> 	--btf_features=default,reproducible_build
> 
> to mean a set (the default set of BTF options) + an optional/extra
> feature (reproducibe_build), that for people not used to the + syntax
> may be more descriptive (I really think that both are confusing for
> beginners knowing nothing about BTF and its evolution, etc).
> 
> Alan, also we released 1.26 with "all" meaning what we now call
> "default", so we need to keep both meaning the same thing, right?
>

I might be missing something here, but I think we should always call out
explicitly the set of features we want in the kernel Makefile.btf
(something like [1]). The reason for this is that the concept of what is
"default" may evolve over time; for example it's going to include
Daniel's kfunc definitions for soon. That's a good thing, but it could
conceivably cause problems down the line. Consider a newer pahole - with
a newer set of defaults - running on an older kernel. In that case, we
could end up encoding BTF features we don't want.  By contrast, if we
always call out the full set of BTF features we want via
--btf_features=feature1,feature2 etc we'll always get the expected set.
Plus for folks consulting the code, it's much clearer which BTF features
are in use when they look at the Makefiles for a particular kernel.
So my sense of the value of "default" is as a shortcut for testing the
latest and greatest set of BTF feature encoding, but not for use in the
kernel tree Makefiles. Thanks!

Alan

[1]
https://lore.kernel.org/bpf/20240424154806.3417662-7-alan.maguire@oracle.com/

> - Arnaldo
>  
>>> In the future we may want the '-' counterpart as a way to _remove_ some
>>> of the standard set of BTF features.
>>>
>>> Cc: Alan Maguire <alan.maguire@oracle.com>
>>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>> Cc: Daniel Xu <dxu@dxuuu.xyz>
>>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> ---
>>>  man-pages/pahole.1          | 6 ++++++
>>>  pahole.c                    | 6 ++++++
>>>  tests/reproducible_build.sh | 2 +-
>>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>
>> [...]

