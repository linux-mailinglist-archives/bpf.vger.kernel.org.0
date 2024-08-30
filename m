Return-Path: <bpf+bounces-38608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190D6966B14
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 23:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE271C21A88
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 21:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D071BF332;
	Fri, 30 Aug 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XlAOk2DW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IQyeislt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137E13D60E
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051858; cv=fail; b=kpBOZkJXNgpu3ExOf7t44bm9vR9W8EqMfs5glxCHwp3QhA8KCIdZGj0S67f47OoAFC1LNjHEc8fsvJArOSFeGCgtlSlbpD7qmubM142XUyuI5x03pFnrvYZg6XLg2hM/x+P3MgMAwfypWjmvqSLhV8Dk8HAHaQ/i/pi12kKbCrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051858; c=relaxed/simple;
	bh=b6a48qkvFzTWsZfnYYfl/k9Ccbdw8Sm1+p1iZbKoiow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GOLg2emalL4VOKBBh38nLnfAdCnGB2d0XiRw91H1M1MckMTA7OqCutXqa1tfVWYAqv9A7Dbsq7autUsqRyydKmzKNE1JqSAF8CSmzz3OQt1GBpVEkvinKQI6XFvKqzRfyV+3i7+4Al5aOG1tDgQyUThELTNVA1luHTFrKgQhZ4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XlAOk2DW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IQyeislt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UK1BPB022686;
	Fri, 30 Aug 2024 21:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=d1cW+lroX12nGOVcmr+YqjktkR8RBPdT7nrHmlYLpd8=; b=
	XlAOk2DWwnYd0aIrkx/MINZCzLzLqY9gEN2jQx8bxOq+nFd1iwz3MyGUuFo24QWc
	vvhfYOnHxgh4auz8mUpu1lba988bhTCXduBLihbs1BctPPMgpzoqUZ/6/R+Xd3l8
	rUdhIq4lk2MqCgPDA3+Me4o4aLL6bYhvtpX1a5FXZ8eFNJFPcDFgEAn6pFT3NKZS
	vlrjX3hncx8I8Ee44ImuxjDlWgKpuqKrr7loNT2eG0O8kYIkKbqYkAKuIvF/4s9M
	9F+K48FkiIwp/4Rzf7hNocqa5VYKP/ZpSOYVWSW4p0n0R3GJ+qQiUQziFavdH/jr
	ZG2Zkud578ZfZyAmY6jbUg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bfgj8uf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 21:03:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UKKZ2e036544;
	Fri, 30 Aug 2024 21:03:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jq1xpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 21:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCTUc/lkJe0GrgMEoftbLUs4ZHSpmk2lJxoPdjUeX1jrb7e2hEnyU36bz9UHnDRNbNJ9hL5EckVQB3g2aEg33TzpKAiOixsNSjvZH6zgUUZxiPXppHXy6H1Sis5wE9PNUCWRsWBQdjAcxVlreU56RUBqmpRmDbPChoid/x8BKCII95OlQeg+VA3ZJ0VGT7zfC+RVWa+I1RaUjvJwNItm/i07fID75mFSW49napIxfDXXQz3oFYGv5LwwcGGkg30sgV244Xxn+iBp0MTUr4hA4CwShhrD40KoasJVJ404FRK+PRDGajj4WQRyEKwwZpXoTWd1f4/NxF28XesUn6FmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1cW+lroX12nGOVcmr+YqjktkR8RBPdT7nrHmlYLpd8=;
 b=BShmsihmAv42XE7Lf5AeO4AicVc04GlbzbrQS8APZJKb/vOu+plokYfvC5XWruE6tP67M4NicGqLr8i0E7vuxDLr34SbayfyAVcHAjt330e/lpfJsle6XEa6PvVDd+dQ1t72zNx7z3UbVEwpfnd+i83TuFrUaq410dWx8NQffgGhhfLWH5aPH6KltR3hLyHOklzFq1SyBDplOQVQTufKt5UJbdrtq0TiSYzURBWugy8ZMn2Czs3amnUQhSUAHgMN1aL7R13SG6+xKC+WpOaL6ziLVeZjGtt76Xp852fSBUpoKznePrsxMB9CUNOllj/XC1vykxAMp/uNagOc+RtVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1cW+lroX12nGOVcmr+YqjktkR8RBPdT7nrHmlYLpd8=;
 b=IQyeisltjiUQMHJr/q4qnUNU6OTuo+rnaS0Fl7La9fZn6iXRcxggc2LBt7fZ/O7gG55iXabBkUOdZdLpS0ekcXmvqBM6qEoEPYe/eDKqqVIXBG7foUo1ukoXhVhhP8URJ9xXsSu/bJ/kov/07ATf5hC5+r2NTc16WOCfVLAJJu0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5631.namprd10.prod.outlook.com (2603:10b6:a03:3e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 21:03:46 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 21:03:46 +0000
Message-ID: <68c211f8-48a3-415c-a7d1-5b3ee2074f45@oracle.com>
Date: Fri, 30 Aug 2024 22:03:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: do not update vmlinux.h
 unnecessarily
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Mykyta Yatsenko <yatsenko@meta.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org,
        andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        mykolal@fb.com, acme@kernel.org
References: <20240828174608.377204-1-ihor.solodrai@pm.me>
 <20240828174608.377204-2-ihor.solodrai@pm.me>
 <b48f348c76dd5b724384aef7c7c067877b28ee5b.camel@gmail.com>
 <CAEf4BzaBMhb4a2Y-2_mcLmYjJ2UWQuwNF-2sPVJXo39+0ziqzw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzaBMhb4a2Y-2_mcLmYjJ2UWQuwNF-2sPVJXo39+0ziqzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0100.eurprd02.prod.outlook.com
 (2603:10a6:208:154::41) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 115f9c54-03bb-4ab4-99b4-08dcc9373d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MExwMjZpUDJVTXlQekI0TlR1cFFSZWc2aXFEYVlGZjNPdjdXdWtFa2JLYXgz?=
 =?utf-8?B?Y05xOWs3bWh1UVJDeEFXNlJUUUpvSFdxUjkwMFB0S3NnZE9YN2pNdjNqRnA4?=
 =?utf-8?B?aUtZdFMza3hpenp6TW14MVhQcENSNkMrb1UwaXgwaHBTNnJ4U2ZvVFdJQzhy?=
 =?utf-8?B?R2lrdDAvR3hqb1lyTzlYTndMWi85UUdybGJXSDhSVXlmMmhVMEE5d0UwZEda?=
 =?utf-8?B?V3NkaUJjUWdmNUhoOVRxZEdVNkNiT1JCa0VSL0tIazZsc1lHNHBCNVdqY0d1?=
 =?utf-8?B?YUxsbllXa0ZuN3hDb1ZUSG1oV3lsb0NLS21qY3hITXp4VWF1QkcweGkxVUM5?=
 =?utf-8?B?R2h4cjhXYnZzT080OUxjYURwQ0t1YzBDazl6OWV1VkUyU0NLVUdORjZaZHlH?=
 =?utf-8?B?RWZSd2pTcUQ2R0MxK3BpcU5MMHRyTTlCNVl1Z3RyUjQ4SnEyS2xmNUQvTlEy?=
 =?utf-8?B?Um92c3NmRStxMDRoU2ZCanlDNlZFbDBnYTJYL1Y2MitXZHJDbEpjOVVqMVZB?=
 =?utf-8?B?S3JweE1zWFUwL3dYZHpEMUxrRjhpdmRvaDRKZUFRYzRGT0lIS2dneEgrTzd6?=
 =?utf-8?B?aW5wTTFibW41WDlTTFVhR1M4cXhGa3FBeXNpdytUdnd1ZCsxeGpDdExCM2hu?=
 =?utf-8?B?RTRiME5rcWRhVm9uNVlpaHNlTjJPbzlueUlWc0YyaTlubWRkSGp5aC85a1hv?=
 =?utf-8?B?YWQwb3VSY1BROXJKZFliSUx0aEN4TzFrdStTUEdMbStETUxVY3I1THlYMnVB?=
 =?utf-8?B?QlpwYU8wTytFdjNjdW5xWjI1OEViWVhLYTdkSTkyYVIvYW45THBmcWpSNTRk?=
 =?utf-8?B?Z255REdTQlBBeDZuanhGdk1yQ28wa2lIL1dIQWFVMGhCL2ozRmlWMGlNRWxs?=
 =?utf-8?B?cHh1bEV4V05USzVOV0hWNzM1Q3VhUTRpdUY3dEczRGN4OVVzTmw5S0tncTll?=
 =?utf-8?B?MXE2WjJqbnJaaE9FK1Z2cXF0d282QnNoVVRXdmx1bWFBaW9QZER3azJRRS9S?=
 =?utf-8?B?YmVaMlpnbm1vWW1EdUdNZDhKcXhZN1lWVzJhOVZyd0kyc1FmcnNnVHpOcGtN?=
 =?utf-8?B?N0ZRY2JJMnd1R0IzZFVFemZBOUtOV1JGVUExQ1BBSDRVT0c3WCszNmdIVGRE?=
 =?utf-8?B?SzhNMXNtMW42SXdKYUt5L2QyekREK3N2MWkyZmtxV1VFYUFmYnE3bDV4R1hV?=
 =?utf-8?B?YmFDRkxFejNOc2Z1SVZSc2tyTnhBSVBSZmRwWUFneU0vazdTd0NXSDJ3MHRY?=
 =?utf-8?B?OTZDaFBWcFpkcFVXOUFTQXo2NjdidEZpYUFEaU5oTkRLTDJEVWF0Y2NHbWsw?=
 =?utf-8?B?K1IyZkFPeFFWTnlyYTNiMFlRLzB0S3NCbXJxVnBmSTFzWmRRN3RLYlBBc0FO?=
 =?utf-8?B?ejBKbCtpUUM1Wm40VmZXcXpONTlFRUh5cGNRRjJJMEVCdkVYNVRwMTRub05R?=
 =?utf-8?B?YXFBWi9tUGxVNTlFUmJzTTNUVzhWTExJeUtWWU13djRLZHRjL0FBWUtRQnd6?=
 =?utf-8?B?eGRCOVFqbFQzZ0NBOXRaVmRvVXhFWmZCZk43TGFuWDRWaFBXMkYwcGlLcHp2?=
 =?utf-8?B?dGFKazl1UWR6ZjYzRDJqcmFNRXBBVkpyaWNwbkk1WmxUZndPRnRkV2Z5Rjk5?=
 =?utf-8?B?Z3YyZlk0Q0N0ZWsrdXlFeXJyejgyUzY3SkJxRkkvNG1RYVZiNUhwOHJ3ZGpC?=
 =?utf-8?B?a0lvQjVjM3RhSklxQ2JJanBPM3B2TEhIRExob0FjdStVWGR0TVhkbWpTNy9T?=
 =?utf-8?B?cUY5eTBJV2FkWWRhN1VaVk14YXlEREc5Mjc4bkFhalMxbFlWZG9PQUR3WnRX?=
 =?utf-8?Q?D1ksDKubVtg+CFV2VZQz2hgJHeSQmLekTDV2Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2ZFK3BQdkRka20wNHl0L2ZIV2RUMjZQWnF1RXhPdTh1aDlURDE5Z2lqbDM2?=
 =?utf-8?B?c1poLytJWmxlZEt1WE9BK2RVd2RUb1IzcENWRFlFL0hKdS9zemZZdFBlQmF2?=
 =?utf-8?B?RW1xTGJaYWQzK2NZZ0JNUnRZQUJxbDlIei9VSVErT2dXL1haNDZENU9rQ3dC?=
 =?utf-8?B?VlVrUEhDdGdUL2Q0NXhYdFM1bWlseURSNWRxekZzblgvWjdwd2d4V2JEK09s?=
 =?utf-8?B?NzNGTkJEcitzRy9PWW9ZcmRqZEZqVUc0NUV1Q0VXSGF3Y0lHNjB5NmkyQjU3?=
 =?utf-8?B?cGptUzZjUGxTWVZIeVRTQVF6dmd6NFdLTTFiZzJHTGJRQ3Z0S3JkckNvMlRw?=
 =?utf-8?B?WndQY0JMZ2hVT2s5S2lpVnhMRVhzcUtXcXVpU0hLd2YrTzNtcnBNM3ROWExD?=
 =?utf-8?B?NkJRSWR3SitaNHJQZmhPdHpJa3FXQ085TE1YMHNseUEvOTFQOTJRRjA5QkhV?=
 =?utf-8?B?L1AxaTIva3o5SEg1SHZrVG1SdHMzWFpZLytzeWYyNWJ3cUZteXRmQkxTSU41?=
 =?utf-8?B?dWNtYzNuOUlSeW1xTTF5QmErZWsvQi9wMGpZU2c1bzZpV2JtTVA3MmN1Tm9L?=
 =?utf-8?B?YVVUQWJ1RWFDNDkweTEwQ0huSWlPTjZGOElsSGFTN1FDMllweGorZWZKa1h4?=
 =?utf-8?B?bm1vRHZ3cDVtRnJvOGY4ZlZNTW80ZUsybWcrUzFybjZibUo5dkZFT3ZvQ0Qv?=
 =?utf-8?B?eEJNYWZGejVMaklHTldmck5ocUYwRHhVQ1ZST2tTTGxUSTlueGg2eHpLNnNq?=
 =?utf-8?B?N0lMRW5lRHVzTWMvZ2xPOHNEdHhNODFXMTg3OHk0SVhPSjVEMjdUb0FsUml2?=
 =?utf-8?B?ZmxkaGVzM2k4cnJpeWoySVFUbWxReTZkRGpINm5uNjY5MUhvU0U3azBJdGdC?=
 =?utf-8?B?a0hqRkk2cHd4cGFzM3hlQ1VLdE1FVUNBNnpleXNzY1BpNDhqVHlZVTdKcm9E?=
 =?utf-8?B?SVNtMGlaN0lCMTVEQktYUFNUdkx6YUlycG9MMGFhMEZnSzFWNW5DbnVCYStW?=
 =?utf-8?B?VmljUTFYSkk1TmdyUXRmQk9PTGpzcHRUcURJdThSMWRsbnNCZjlFNERsM3JD?=
 =?utf-8?B?ZXhsblZCWFVnUlh5YnJDd1F3aGV1R3JsUVdpczJ5RG1UN0RkbnZrSVh3cFhx?=
 =?utf-8?B?cnQ4TVB0dVBuZzhLbHozWjZaQ1N4U2tzamtuNmZJRGlob3o5ek9uUXcwK3Qw?=
 =?utf-8?B?OWdwY0tZaHlxSXFHMS8xc051YjUxZHJlMWpuTkxZTDAwUEphWWEvRlpKbHpi?=
 =?utf-8?B?Z3k1M3pybUVpNTNvU2NCbnBRRVdKdUk0SVZxdnpXc2J3czVOUmVYQ3VqTzRT?=
 =?utf-8?B?aVdWdThWYnJrMTlrRTNhdkZhOWRjZUR5aEg4UzhUVDdRNmtjWGw5VUJDRGtP?=
 =?utf-8?B?Mlhvb1lBWmQ3ZGNEK0dLcTNlcWdPcER5ZTI5SnBVcitzZzZYSHVaNDUrY2Nk?=
 =?utf-8?B?YUJNYVl2UHdNUmZiMzRaK25NSTVJSGJYb2wvWDZaVS9rdDdCTkdNelRrWGpD?=
 =?utf-8?B?WGNyQnVhVW9lYXpDKzIxSC9yQVRYeGF2V3BHMzhub0t2U3ZWYkFRbnhRZmNK?=
 =?utf-8?B?VE9CNXRNbDhBMmU5a2VpV2tLSXpGc2c3bnhGVGlZbEVqVjgvT2VGaE1kV3B4?=
 =?utf-8?B?SmExa2Q1OVlGNEdOYkJZRXZpZTNlc0NPSXBFOWxuRjhGRjRPUDU3TCtjVGpp?=
 =?utf-8?B?ZE9laEY2ampjbjlNRlNsbTlhUit2OUlTMkpKNVZzclFRMmNLOUg3VmxsZ0Jk?=
 =?utf-8?B?MTY3OTFTZFFNWUF5THRWZjY2YUlrVGQxb2RWdTgzWnBIK296UE9IaHBrOHJB?=
 =?utf-8?B?bjlRVU5XRXhoeU9wdjVUMmd6SEp4S2lYb3lZM1ByQUJXUDhQTTlabXpBV3dz?=
 =?utf-8?B?cmM1Y0RVUmpsZ0Zyamp5bExiam9ZZ0hJVWZFdnRBKyt6NWptaEZ3Nk0xOVJa?=
 =?utf-8?B?MWthNi9rQ0U0c2E0NmlHWHlCWTdPak1SOFgzQmNjR2dhZks3VkczNTNHZHNm?=
 =?utf-8?B?Tm5haXhHa1FZbytzVWYyN1JjV0NaZGpURDBuM0RhcFlkTEc5Z2RHTkJXdFVu?=
 =?utf-8?B?N3VWc0dwbkhHN05IT25LRWZndWQyd3BjTHJvLzBHZjd2Mk81Q2hKOWptbWEv?=
 =?utf-8?B?eDlnNVFyblpwRTVFVUVXOTlmN0NVNHg5ODR3aVEzUFlhUzd1ZUhCYU52bTUz?=
 =?utf-8?Q?btBjmE5Xcxve2+Rm9tdXbYI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GddrBYUR+yTdcjdJjr1CuGVQVTS32qZoZCweiGJ36MaZ/+sZuJa+GAZiwAPXKFP8jZNhOaD94+cD+ImO4co/MPWziNxcmBG3S6d1HG70431b9CpOg25qZZPyqFlpK7qcox2Kk4RR/ZobCRvHxeZPWz/ITRH/lVvRWHqkT09JnD4Gd36YasR1yP4SzN7AfUCMNkO3DPqhD6YAxZ8lzOPfMu56rHtnTNoQexpluSE4dBGlI55E0E6waTyVl4OiQ+xP0vBKFZMEnbxKdm/XjhNL9vPV7dzZNL7MvqwtJZGimYdAW7qsYIkJs3WSJp9srnp+QvUMWnbld0Tt41GH+Cyf3DJv3/UISbIJWQfS4G0ZZSqhCU/ZnkyGisufVKkqMsG2S/oCJWRlbkFi2Df8t8UFX4MTKZGusx3hGL3l29t/XU/ymGngqcoaSICZu82eUz16M6azzisIBmEdfr5WRO0jd4HG06vMKnQg9hpFI45yVHga5sVB6RLywz++ybfmZpD32UOsOjMBdWwkqcmjVmN9oU9Lj0luo4wfUY6HrnzJS3oJTrgmURpe1GufYx2/umuhsAQ0WHSIFqcxhhG5pBdh35PFa1v9bkoizvLcmm5ILAc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115f9c54-03bb-4ab4-99b4-08dcc9373d0f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 21:03:46.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaVnSKBiTGt2A2m3zUsewai4taHd2DnJ/ufSZENBdyjpx1HGw8NkQRikRo87q+GdwSCNLmIM8iZEBKlOBTLYZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300163
X-Proofpoint-ORIG-GUID: 5JslSMefMipNcZRiCm4F5wGyx4TGqb8u
X-Proofpoint-GUID: 5JslSMefMipNcZRiCm4F5wGyx4TGqb8u

On 30/08/2024 21:34, Andrii Nakryiko wrote:
> On Wed, Aug 28, 2024 at 3:02 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Wed, 2024-08-28 at 17:46 +0000, Ihor Solodrai wrote:
>>> %.bpf.o objects depend on vmlinux.h, which makes them transitively
>>> dependent on unnecessary libbpf headers. However vmlinux.h doesn't
>>> actually change as often.
>>>
>>> When generating vmlinux.h, compare it to a previous version and update
>>> it only if there are changes.
>>>
>>> Example of build time improvement (after first clean build):
>>>   $ touch ../../../lib/bpf/bpf.h
>>>   $ time make -j8
>>> Before: real  1m37.592s
>>> After:  real  0m27.310s
>>>
>>> Notice that %.bpf.o gen step is skipped if vmlinux.h hasn't changed.
>>>
>>> Link: https://lore.kernel.org/bpf/CAEf4BzY1z5cC7BKye8=A8aTVxpsCzD=p1jdTfKC7i0XVuYoHUQ@mail.gmail.com
>>>
>>> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
>>> ---
>>
>> Unfortunately, I think that this is a half-measure.
>> E.g. the following command forces tests rebuild for me:
>>
>>   touch ../../../../kernel/bpf/verifier.c; \
>>   make -j22 -C ../../../../; \
>>   time make test_progs
>>
>> To workaround this we need to enable reproducible_build option:
>>
>>     diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>>     index b75f09f3f424..8cd648f3e32b 100644
>>     --- a/scripts/Makefile.btf
>>     +++ b/scripts/Makefile.btf
>>     @@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)      += --skip_encoding_btf_inconsis
>>      else
>>
>>      # Switch to using --btf_features for v1.26 and later.
>>     -pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
>>     +pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs,reproducible_build
>>
>>      ifneq ($(KBUILD_EXTMOD),)
>>      module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
>>
>> Question to the mailing list: do we want this?
> 
> Alan, can you please give us a summary of what are the consequences of
> the reproducible_build pahole option? In terms of performance and
> otherwise.
>

Sure. The original context was that the folks trying to do reproducible
builds were being impacted by the fact that BTF generation was
non-deterministic when done in parallel; i.e. same kernel would give
different BTF ids when rebuilding vmlinux BTF; the reason was largely as
I understand it that when pahole partitioned CUs between multiple
threads, that partitioning could vary. If it varied, when BTF was merged
across threads we could end up with differing id assignments. Since BTF
then was baked into the vmlinux binary, unstable BTF ids meant
non-identical vmlinux.

The first approach to solve this was to remove parallel BTF generation
to support reproducibility. Arnaldo however added support that retained
parallelism while supporting determinism through using the DWARF CU
order. He did some great analysis on the overheads for vmlinux
generation too [1]; summary is that the overhead in runtime is approx
33% versus parallel non-reproducible encoding. Those numbers might not
100% translate to the vmlinux build during kernel since it was a
detached pahole generation and the options might differ slightly, but
they give a sense of things. I don't _think_ there should be additional
memory overheads during pahole generation (we really can't afford any
more memory usage), since it's really more about making order of CU
processing consistent.

Would be good to get Arnaldo's perspective too if we're considering
switching this on by default, as he knows this stuff much better than I do.

[1]
https://lore.kernel.org/dwarves/20240412211604.789632-12-acme@kernel.org/

