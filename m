Return-Path: <bpf+bounces-26989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEEB8A7007
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52FCB232B8
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8913119F;
	Tue, 16 Apr 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EOM3eA9d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lUKTe33I"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F489127B7E;
	Tue, 16 Apr 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282096; cv=fail; b=QO8HZ7BrnMDU4lQRgeIf/w+uxMGj5Mp1X/jNiUBs1BiUuIcK7UQx3gBijyR+lQX9OW8Til1DftIE4QSuJ+AssOu40asoqw1yQ2qWEEHZWdW0IjaYzg2HK69LzMO2lDahoVMlmIDcTVUM6a9XHnkuWB6QijXvo3s+sdoT8+9OrVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282096; c=relaxed/simple;
	bh=edKLZtRxu/cms+CPKYDaC289p2/4ORlT6VGJoBzknRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D4IU3b/C4gi5vanOcLIYw1rnj6M6IddyjL7aLVNpjTBWarwBsxo/qSIi8VIYzcxrrT/RNlPrK3a3LYzceOAj/0f0fQAMnZvH+IBgY8hRTo9xq1BHXPpvG++oARstIKFG4uqATFXFZ6nRVTz8scstDq76h7LSlUtG2gqnNoz+eio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EOM3eA9d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lUKTe33I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GEPE74008837;
	Tue, 16 Apr 2024 15:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HUzPr/44xSG+cDp36tnKkkcso0EACoLItlA6wOQ5Sos=;
 b=EOM3eA9dWc9vdWYsZpNJMeVVrng87g+2RVkjUG3VqJW9h2fXTyGeof/pukJU6kfx/bXI
 zEEp3qiI3y3HCkU+uxz2B2WzdrhnnrSDP8LKltozpnDZeNRXwEr++NYOHcblLCshr6fh
 3ucMHBHv40xw6Nnpx5da8kRmcaLbCF4k7M2ynD2CKikehGLVNl6izWsBnqGNON9f4jjf
 WJ4kFx/4uNbXnLcjleSxHNg9cJ7U2G1NrL+6ptekSvD0EhcqZxNaArlvqTA60pl7rEjM
 5ZNqUDezuoK8R9QQi38ljvpPAInHOU3wLrIu1xgKrSqB0FSKSs2c40TX5iOUSXOpY9yN nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgycnm8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 15:41:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GFdvS2012492;
	Tue, 16 Apr 2024 15:41:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwfcrfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 15:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3qivSYoXLgo2FUtmAlBFlwHDy0/aBlkJt4PhoL3ONkWx1FGBdIGg/jZebPjH9bzsHnQs27taSTEVXUOyy+JNcqN8K+S6wfCb/iMwZ9Qox+DqPZ2YP1EkCFA9EiUw6Vo6B6xjlVZQfafUOto4Kx3pXV6sTiZCrvUcUoWWYfhaDVQNp3jRW4+vOINCiqiS00+2vj9Lcf70tg8E5F6fRXYIvCz1wDLGW6UsYEnp0hTuL6L5W8Ful6sfRKyP+RoqjZ6p8Yc6ZLj79hvenBBel1PBZHA0UICocXUGXPkvwvDQVsIYMO43uo8sfjWNRboae4MWK54ZrBBHlHEAKjfjtR+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUzPr/44xSG+cDp36tnKkkcso0EACoLItlA6wOQ5Sos=;
 b=UAmcxWq4y95on8rQmfLBHYdzJRUW5w55tPSxE8/dqWsqR77VpGg+I0TKJkDuHrH9ucS0b+05r4xF7T4y+cTKsWCq3t1GtwCerKu9xALf96T+YlcqsuTIikntJaPDJqoplMCNsY8+6B5YV8ekxvHpOLtnsw/RfuwCK6d9HCE5tkYC5sUGxqHPOmh2QRfZjzV2rGp7Kz4+fUHihvFlMh2QAb4cCl3y1rYCCgOtAEUSMj7prvYxibHjjtfoF0FMlFJJKoSpC8vyxiUm5tc9A8LMb02nEd9PyGBM0neDQdHyN52zxpFSF4bV0t/qrgtUEt5WRzWBaKQlJKiMcIq8OT+9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUzPr/44xSG+cDp36tnKkkcso0EACoLItlA6wOQ5Sos=;
 b=lUKTe33IvFJID9AL/rwUM7ll17WU+WdDUzqfTlbE5p0UJcPraM+QU+ZZlt/XC9QF9XqSHa8G6AEz6Yui2ph4/zca3+hTvioeE/hG1eu25chGLMOZnqDoUvTFXvviecwirljWohY/zekYzLxdzhn+RQ3hJqHsVPZ8CvZe+jWwDRQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:41:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:41:25 +0000
Message-ID: <a820dddb-54a0-47e0-9a6e-e12c6341babb@oracle.com>
Date: Tue, 16 Apr 2024 16:41:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 2/3] pahole: add reproducible_build to
 --btf_features
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, williams@redhat.com,
        kcarcia@redhat.com, bpf@vger.kernel.org, kuifeng@fb.com,
        linux@weissschuh.net
References: <20240416143718.2857981-1-alan.maguire@oracle.com>
 <20240416143718.2857981-3-alan.maguire@oracle.com> <Zh6YNhBRbhVchv5S@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zh6YNhBRbhVchv5S@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0145.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4962f0-2de4-482c-59ad-08dc5e2bac1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UQa6jGoTjNU9axJGC3+MgUiI5li2RDCQzDkML1/8Uh/pokoe9ikYjxHzH1sjqgLF/NkDFS/yPUA9txuX4AluNPeuJTCFsGjJgGwj9ftUBckCYZjRAbWpPWggLciXZSVg9Koe1rSgMs+aXv5X+tKAzTfIfTfFSnXXPLnyJWIBN8YUiFw/mM78LkKTozuB7RVB8RaaL5pj6NkNeyVGKivbSIoIyG2uzPdpmIN0KcsSqi3v49dBLt5/gC7BN40XaFmcdip7CzRjyt+02/e14OrP3NtJNxjIfYS+MDbB/4cwqeyIVNn6AKeFu3YlvZi4BZas/kIwhdZ0HJnJ0jDsyy/K2/YH9cShB8xD/JDzP3NdYRrtaIdfYMB1IOPzcQSYvPk77Lo5FJhJTLGjF6FT5/iUAsmIJ+iLP2IAk+ysYDURJ9esCFapah2zyPa/XS/6ytTcIGObuGzdPgI36kK64Ar6UfS4oHYJSW1RyfQRP07Rw5Ku+MiyaH4G7TtJRjDEFw7NcW2SpbI05j5nQuKnH6Ar0QmhaxX3GzT/35iw01aMV2JP03C3Yv2Yd2CrVfpEiqM0EhWmbr7yrMrLwnRvTJPmhHXo3Hsz7R5PLwdkaX/wkoPKRaGbLOLvpBovRs79b4/N08NxrEhrG5oz+/DDBMUM7FgiuXX7iNWdJQtxLd1xxPY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RzdJU0hnTDRQR3pOVytoWTNUSTFHTGQyWGxkNWwyUlhNY1NSS0VkUUJDT2wv?=
 =?utf-8?B?VXFWdjVrR3V6QmFEVGpQbXVoQU9Vajl0SzZsNmNZL0xnNG0vVSsvN3c4QWNh?=
 =?utf-8?B?RlBremUzaGRSWnVVbHhqS1N5UXVOVHVGTXNRNDN2QzVmS1FsT044ZUJRUUd6?=
 =?utf-8?B?VU5uQWxBK2ROUkNjaUxvK1JWWWpTeldncGFmbmEvNXNzcGRsdzFMT0ZjWlcx?=
 =?utf-8?B?T0plMEdKMXJCS1BkS0VMV1hPdkUzS1NmMGlSK2l4ODlaNDhNdXNzN3FkQUxM?=
 =?utf-8?B?NEY0RXpJVXF5UGtEeXdIcGU3SnZTbkJWZEpvQ0tDUmNBTlE5VjhMQ2lKakhh?=
 =?utf-8?B?blh2SWhlSStaVVpMV2l4K1JxbFRCcmFLYkF0K0xFengrbXNNMkRJSW5tTlVu?=
 =?utf-8?B?SnI0UDdnMlgrcUFMRXR6Qno5UkU5OEZwd3RtZ3F1anJ6Q1FTYXY2T2h5VEVp?=
 =?utf-8?B?c3Btckk1WU9aTWhnTnV3WEdJdVIzWTl5alB0cUJkTkM0MFlwRjc3aVJyQlBn?=
 =?utf-8?B?dHhrSGRpT1hDeDNuVkswTFhWTlVFL3hLSll4MmVURXNEWmlNV0o2ODJuV21Z?=
 =?utf-8?B?eTFNQmZ6eTlGdXdHL1d2RVVJZ09QVjN3NnlTWUFRZHdrTUhObk5XUWlhcC9s?=
 =?utf-8?B?SHB6M2c0YzVGSHdZNWNqcWtoZWhPNHRmK2lISjh5YzROYmJRdVQrTld4T0pu?=
 =?utf-8?B?bTFLUE8yMXRaem9GOTRpZk91aitTSVRwWWZuQXhRNXV3UmF3YktrQmUxc1dH?=
 =?utf-8?B?OG40VkppeWVwRDl4NXdjakNIRzZsaEtCSlk0VEFjbnhJUDh6SFJkRmRFZnRB?=
 =?utf-8?B?Zy9RdGphWHV0bHc1cnJha0pJTTA0L2JRQ05yb0tTZDBab1VobFgyaFNvZjZM?=
 =?utf-8?B?eWVTUmFrUVlVNFlRVHJwUEdjbXNOcFdobXZ4bnRxSThvbFNXYTAvbFcwdzdp?=
 =?utf-8?B?T1l1Nk5RNVhaOEJoZjBwelQrMTAxeXB5TFBoUEZlS1h1cGxybXNJeS9CcjBU?=
 =?utf-8?B?Rmo0VVJ0SFdjZ1BlTmNMY0J5SWd0TjY1c2NUbks2WlF1alZCcmdJVEZBRi9R?=
 =?utf-8?B?akQ2NEZvb1c0VnNCSVBvTnlKUTFIUTF6WWpjdnNyL0hHYklnMnIwdWJxaW0x?=
 =?utf-8?B?aDBRenFqQXRMbGIxS0N0QVl0bmRCdWdMckFQYlNVTVZGMWp1TUh3dWdkTkdx?=
 =?utf-8?B?cGs2L2JuQk52alRlU2NlVXNRVUhPUTBCVzd0dldDb0NITVpkalczUzFiUFNI?=
 =?utf-8?B?SW9OSWx2YUdzY090cTVnRU1hWHIyQU1qTkpJVENSd0g2bUNmTmx5N2hrM3hG?=
 =?utf-8?B?SXg0Ymo3dktvak9iNTREclRyamdHM25hZzl5UnBEWkJOcHRLTzBWTWJKc3Zu?=
 =?utf-8?B?b0V2SER5OXdncytMaDVQS0ZNTGhUeVhaejVhUTdKNllNMHFPR0FhZVcyczNM?=
 =?utf-8?B?Y1dIa1RHYVk0ZitZaVZNMXRwNWMvSmFGZzRzOE1sY2Q0M21qblJjMEhNbzBm?=
 =?utf-8?B?MUpMd002SXhyUjhYUEY4OXI5VjZjdlE5eHQvV2VRNjlhekptTDFQYnoyUGpN?=
 =?utf-8?B?UE1GMS82dGMwdlNCdllZb0dIZ2FiR1pBUmE2azVhRWJIV1BoQ0xlN2Y3Y1pI?=
 =?utf-8?B?TlVIWkhJMjZvVE5DY01OOFJZQmROWGpnaDhKMVF2TVVKVU5XSjBIK2k0VzRG?=
 =?utf-8?B?ZFl4ZGhWZytjRVpZZEY5em4rcWl4Vi9RTEtONzlkMG1TUGZuUklIbmc5RXl3?=
 =?utf-8?B?bkN3eFd5MVhISmJuenM2YnVoVkQxblNYZDg5bExvWTJIZVpxS1dLSUJQM1Zs?=
 =?utf-8?B?N0tmWGd2cEJsY2RoaGtrdGNvZks0MldkRFNOcUkzbDRNOVRJRzhORXhsRXdm?=
 =?utf-8?B?NVhhZit2R0hKMlBVSGd2bHJ0Ymk5d2xVcXFYMmFSSTU0c1JFRW14cnIzN0h2?=
 =?utf-8?B?dnNZbkVSOFBZRkZrZHEyQnBlWktVYVNwSFZMTzVyMHNVdnR1ZnRMM1F5cmtZ?=
 =?utf-8?B?RVB6cjlDMGtTZ2tobzk1OTN4NGkzWm9EYzd6dnZXNDlLVy9jZnA5dG5XdnE2?=
 =?utf-8?B?a2VpeEwrdGVIMHdTR2M2SWZFMU8wYkYyRWorMFk2L1FnRXVEYkl4dUFMVnhh?=
 =?utf-8?B?anRzTUdCelRxUzdBUFlVR01kb3E3NG9DQktjeW44T25KRkc5dERqVUoxTjRP?=
 =?utf-8?Q?Lv4/FmL2rcS3dDfI42FtRt8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VK0T8qzGSDv2kzgXaKyAZ6odx+oM5xfEDijCq9LpXdRZ7hGnH2GxZAPRQexO1kY/fjJ6bxV2YFXaxzzQGw4uQ5yxDQrUJBITRxgr+EqoQQDUZDKT5DuXSXwJii0+BwYO0HNSM5PnVt/JqykIt2aToOZwD8H0IamTVo9uVDbbCB7yxbT9JpAFZ4dqm6/AAIdAVmJWLcAlOohnE9z2+pGPsfg2njJ/lDsm5TN/pweqkb4xOye3IDLcszq8eKof9uFnKIkokJZ/imS+KApPeXwZ3T4PZ9xHCb/kSmZZA3mZVtGMvGmmphyAcrMRdh2G6BZq6Mn4deGs1enra/m00AqRwpRgrJqTd+CBaA5SYHW4KynXKNYPNwwrFsFkp6moa92oHWQ/zP5Dh2TZSeCXJZiTHZpY+uhvbsF0MxbBrhlizX7tuUDcE8/BGYoOS7JFwYIJ1uHrh3kD+A6gyCA0Jj83RVuTowTvBUwr9yfuTyMniON7lP7DKpdJlwUvO9qIrpxDSD/QeLckYpgyKunEYbtyb67mHfEiEQTLzJhDO3rhP6V7sTlXVXqWRppyZuvK7fwXSkNJIuhFVSEp298fGaU9oI1wgoDdTGtYGA1I71WQYzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4962f0-2de4-482c-59ad-08dc5e2bac1f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:41:24.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGJYdzbDsyodznPzK5PK8tnXGlbHcYtfOumW75THK91vAcNRidFSc5DpzPrs4R/aAoVUNl2o3qKn3ZBC5bHg+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_13,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160096
X-Proofpoint-ORIG-GUID: FULBNBTvP-jfe6pPEQhaeGDDfgajvsiZ
X-Proofpoint-GUID: FULBNBTvP-jfe6pPEQhaeGDDfgajvsiZ

On 16/04/2024 16:24, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 16, 2024 at 03:37:17PM +0100, Alan Maguire wrote:
>> ...as a non-standard feature, so it will not be enabled for
>> "--btf_features=all"
> 
> How did you test this?
> 
> ⬢[acme@toolbox pahole]$ pahole --btf_features_strict=bgasd
> Feature 'bgasd' in 'bgasd' is not supported.  Supported BTF features are:
> encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,reproducible_build
> ⬢[acme@toolbox pahole]$ pahole -j --btf_features=all,reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build-via-btf_features vmlinux
> ⬢[acme@toolbox pahole]$ bpftool btf dump file vmlinux.btf.parallel.reproducible_build-via-btf_features > output.vmlinux.btf.parallel.reproducible_build-via-btf_features
> ⬢[acme@toolbox pahole]$ diff -u output.vmlinux.btf.serial output.vmlinux.btf.parallel.reproducible
> ⬢[acme@toolbox pahole]$ diff -u output.vmlinux.btf.parallel.reproducible_build output.vmlinux.btf.parallel.reproducible_build-via-btf_features | head
> --- output.vmlinux.btf.parallel.reproducible_build	2024-04-16 12:20:28.513462223 -0300
> +++ output.vmlinux.btf.parallel.reproducible_build-via-btf_features	2024-04-16 12:23:37.792962930 -0300
> @@ -265,7 +265,7 @@
>  	'target' type_id=33 bits_offset=32
>  	'key' type_id=43 bits_offset=64
>  [164] PTR '(anon)' type_id=163
> -[165] PTR '(anon)' type_id=35751
> +[165] PTR '(anon)' type_id=14983
>  [166] STRUCT 'static_key' size=16 vlen=2
>  	'enabled' type_id=88 bits_offset=0
> ⬢[acme@toolbox pahole]$
> 
> I'm double checking things now...
>

The test worked for me on x86_64/aarch64. Did you test with patch 3
applied? Because the test in its original state prior to patch 3 sets
--reproducible_build before setting --btf_features=all, you won't get a
reproducible build since the command line is saying "enable reproducible
builds but also enable standard features only"; the second action undoes
the first. switching to using --btf_features=all,reproducible_build
fixes things for me.
> - Arnaldo
>  
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  man-pages/pahole.1 | 8 ++++++++
>>  pahole.c           | 1 +
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>> index 2c08e97..64de343 100644
>> --- a/man-pages/pahole.1
>> +++ b/man-pages/pahole.1
>> @@ -310,6 +310,14 @@ Encode BTF using the specified feature list, or specify 'all' for all standard f
>>  	                   in different CUs.
>>  .fi
>>  
>> +Supported non-standard features (not enabled for 'all')
>> +
>> +.nf
>> +	reproducible_build Ensure generated BTF is consistent every time;
>> +	                   without this parallel BTF encoding can result in
>> +	                   inconsistent BTF ids.
>> +.fi
>> +
>>  So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
>>  
>>  .TP
>> diff --git a/pahole.c b/pahole.c
>> index 890ef81..38cc636 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1286,6 +1286,7 @@ struct btf_feature {
>>  	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true, true),
>>  	BTF_FEATURE(optimized_func, btf_gen_optimized, false, true),
>>  	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false, true),
>> +	BTF_FEATURE(reproducible_build, reproducible_build, false, false),
>>  };
>>  
>>  #define BTF_MAX_FEATURE_STR	1024
> 
> 
> 

