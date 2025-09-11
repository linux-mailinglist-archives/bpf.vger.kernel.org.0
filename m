Return-Path: <bpf+bounces-68152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFE4B53798
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D94C1C23AF9
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89EF34F497;
	Thu, 11 Sep 2025 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AkXOw8Ll";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ho46T+PE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6C31E11F
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604052; cv=fail; b=QJuXZjecTh67Yh6lQ0fw2TEkMX6wMDjGELfjMHACNGOriCw3bVwwhmtp8HEL9oZPPjQ+1JXshGLhXVSCF/LRsOdlBOEsfZCv+pvRGnh0crg63ZvBjftm5T6d2T8KmPcs9HE/BmxQ/kL84gbtfMbQy+myEGgmB24YxBqoC6YJbNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604052; c=relaxed/simple;
	bh=Ler550RhbRw4ObCusQM1b3hM1Cg/jMCaw+P/GBQsFZE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KCCU+K273g2lj9dkW+H/5jrU66RInMmINVhB5v9nniDxdGl+EG4wXj28CCi0QWG2cYV66TitnexPmZKFtU+YkOBWYOQAth4DA/ubKE6kSJijrlFPp6yCAQRln9lZisEZ9zaXiQQMGUQixnOh3ayJxhL6gq7VDwkF4sBjYvbT9zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AkXOw8Ll; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ho46T+PE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDtjiZ011866;
	Thu, 11 Sep 2025 15:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hiaQvoZxEf6fN7Td+T7JUS0suWzeWHdBINOhUPJj6sw=; b=
	AkXOw8LlYbj5iOCwGF2HfvFC1gQ5SG7ETgNTeaX1Nhju8T8IC1MAaxcaeqeEOYZk
	RE5o4zY6C3tuyI60S0q243kRcdDDNfX3BwjV8029w27z8cuqyXUl5orE3ycLG7wg
	q7GbS+SR1tmf9BwfEn6/xxKMEBdSL27q33Py0RCE9ucRz2u0dbiIjafNM2bYbz6y
	gO+eY/eWKqa+TDbHnhXcfsER9u7TviciVgBO/o4S8zD9vqMGGLhUF/vY483QzS3a
	nuJEGo3iioS8ubkAbYs/ITxA+qTQg4aiL/4VsFxhH+qwDRRiZGsemhiCqd56xbf2
	H2gEkkHK1SxCpuX81DlXXQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226sxh0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 15:20:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFFKtR002971;
	Thu, 11 Sep 2025 15:20:21 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdk48rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 15:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ua+EoPBNdCnd50dS6drLtlF19fpKBY69/WqzfWgUfCIHAjivV5/Glg12r7ykqdQvexDRhOQHXn7e+bQXcW94RayizIDNbX5+UUcBpRfaqVk3a7el1Ts/JmPsqX/rQuvUFyKSKiyJqS0lSUQotN3WndVy+6a5DbryOudn2UJEM0gf6STAtUeMfqO+n0sg5FlFwgdNdKC26YWZ86BJnHXdBEriZw2JNGKdLT+0AfjxsqglqCMlzY8Mh2BSQm0ZPqRWJT4Q7F9jxlYO4gKamweWbp9j/dN/+xVa/ZMN8ZnzAGVSkszehrDr5kCWIci6clqDRREYNUdbhMuKOrflCXyNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiaQvoZxEf6fN7Td+T7JUS0suWzeWHdBINOhUPJj6sw=;
 b=EJtJGzrL/mNiMrfkVlot7FnsP8zjKrg5vijWTiGnj3X9TMMQfHlekHQSQhcuxM/H8iwS+JWsCNWnH8C5IIMo/zKBsc0WBcrkdRsGhRwBfDcKR5jvlN6dm1U7ADqjKNDTnue6YeR2YxAt9kikb2Wev5MnO/AhHpQJX43L5qIydPz77ugYSBEiabKrGXfFVjC74k0npd5BI12yXBYscFM6hnw6s+ZP8U/rs4onozkXBHIz3kcjzOI3Nu2JT5ZXxbXRqZLfGppJW1PGJVS5nkqx1nh5hYgcCo+mznjXkqkfseoa7n3yRrzFC8hWtKCMf83bwmsf0pd8bVQnhbv9AIAB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiaQvoZxEf6fN7Td+T7JUS0suWzeWHdBINOhUPJj6sw=;
 b=Ho46T+PEQaA0jf8CV/4qSR5y71MDqx+u631aVcb/oAWxxa3gZ3XV0Hg2Y5uMeErMbca4kZu1GtTXf1gDIVj77NkaT4bo0vUsnMwwyLRnwPSxXL5TLR6F3aaQV5IE7FkgIemHgzmMB8O/bHfo0BKpWSd8ibZ2qloY5AJl1/lHEXM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH0PR10MB5162.namprd10.prod.outlook.com (2603:10b6:610:de::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 15:20:18 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:20:17 +0000
Message-ID: <7d6aca1e-3997-4fa6-bbf4-d5afd058b7e1@oracle.com>
Date: Thu, 11 Sep 2025 16:20:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: more open-coded gettid syscall
 cleanup
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        brauner@kernel.org, bboscaccy@linux.microsoft.com, ameryhung@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org
References: <20250911073300.463685-1-alan.maguire@oracle.com>
 <CAEf4BzZ6+BgDQANDjU2BEwOj6oGf+GuvCN+3UmD7BYRh96K31A@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZ6+BgDQANDjU2BEwOj6oGf+GuvCN+3UmD7BYRh96K31A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0565.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::19) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH0PR10MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c96b16-ddee-44cf-9f87-08ddf146b6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWJ3RjZOaFUyQmlvRjFXdEVNTEt5MDYreE9ON3RDMm5WVFdQOTJyQnd4aE1u?=
 =?utf-8?B?dmhweUc5VE82aU9JVFFCTGZlS1UxbmFpMDBtM2tkNXM3cjU1Y09GbFF0Q1I4?=
 =?utf-8?B?ZWV3SzJoNm5WOFVTZ29ManRSSksvK0dnK2FvbHRYRGdWTW0ySHNlcjZ6VWRB?=
 =?utf-8?B?cC9NQVYvaHBxalI4bVlwYVQ5MVJoWkQzUmEwdFFqQTRTa2dKVFNsZDdubFhR?=
 =?utf-8?B?QWRvL0p3UDcrVU5vWUttMnNXV3BJZUpjVGdOL3F2a2NiRlpTY2JOT2s4L1NU?=
 =?utf-8?B?M2lJQk1vSW9wTnRLdklWYm9Tc3l1YXM3R0FDM3VaMExIaFBUQVplTFdaWkl6?=
 =?utf-8?B?WmpOSXdNRlVISW5KWTdMdFlvYytGV1A2S2gxdHZlMGRsU1dmYnRqTTdXajUz?=
 =?utf-8?B?d2Q5eFdJY2ZVRnR4WTh2MGVnWVpseU81aGRmM2dNRnZZaHdaNFZaZjJlcHlW?=
 =?utf-8?B?RlByWWVZSjRWdk10WC9PY3hnMFJVSWNUak9IeFgzbUFPS0U3WGxpM3psNkxr?=
 =?utf-8?B?WVBYYWN5dTk3VzlmekxTY1hPOFlhL2ZBMGY5eWxSbkFjUWtEdjFUTis3OXlK?=
 =?utf-8?B?RG9FVkZ0dHl5SHJGdjRYWlRhcDZ1MHhoWjc5WHd0UDkwekVkUTl0a1lDaGFT?=
 =?utf-8?B?SjVHdE94ZlorQ0RjYitUenRzZmROdXNBRnBRcVRxNU9icXBPMUtNODgvVGVp?=
 =?utf-8?B?T09zam16NERuQ0R6ZFVpSGprYUxkM2hoQVRNQzhGMlVnc0ZLd2ZlOFNVRENQ?=
 =?utf-8?B?SlhFSWk2dW9vd0Q2SzRLbkszTDUwaUR2R1Jmdi9oSm9nSEU4SUIvNEpwWUFI?=
 =?utf-8?B?ZWJwaDdqSFlDR3VDOXpZMFUvdU41aDAyeDBYbnBxTzQrSFVaajVnOXNJdFMr?=
 =?utf-8?B?Qjc0NTB2cVZrWnRzZ1FIbWZ3eUJWMUFyZDhWcFJHcVFpV0l1NXo4UDk5aU0x?=
 =?utf-8?B?ZHVwRUVXNXpLcFJ3TVRtT0hGRFIzZ3FnS215UXNrZkI2N3ZYV0xUcXE2VldN?=
 =?utf-8?B?K2RZeFJCTGtUcFdsb0lKZmw1SXlCdlhKaUVIWTdyMkxPN3dqdmdhYXpBZXF4?=
 =?utf-8?B?UXkrNUQyVG9YaE1HN2tXOEJZTVBwR09yUmVPbE9kbHQzVGpnSlRWVXgybi9N?=
 =?utf-8?B?Rk5zNGd0dVBNK1ZYeFdtWlpsT3d3bHVtcUI3NjFnQnVuY2VybDM4dVVIdVkr?=
 =?utf-8?B?Y2E4YjZBZWdHRDJncWJLWG9XY0lDWXlqQ1Q1eWd0aTZidkFzbTd2K0ZCa0xN?=
 =?utf-8?B?ZnJDZXZNRytPY0o0WnpPcm52RXVTcXREdDNYUmt2cGFlSnQydGNDY2p1VHVV?=
 =?utf-8?B?R2tLQUJ3QXB5Z2U5Vk1jOXJvcTZSSm9QdzRwcnc1UmZQVHh1RjFmMXVkSjJp?=
 =?utf-8?B?ZkY4WndhREVtWjBkNUdjTDNETUdUNEtHNnNJVXRDaVIycEp5c0thRzlDRXQ2?=
 =?utf-8?B?RnJIdGF5K3ZKdW9YRUQzVnQ1ZDRvWG1FNGM2Sy91Y25Kdi9QbTY2TWFRMkEr?=
 =?utf-8?B?R3JjckpTbGVUZW5adGhES2p0TlEyOW42Y21CS0JubTk0R0hweVhXMmVMVlhV?=
 =?utf-8?B?S2w2RE1jbkhKcjZjMlF4OXpWOWhHckZhSDNkNHc4ckNwdURyc2V0T2w0NEJw?=
 =?utf-8?B?VldtMU5GSDlMNnYrVVRtK0MrdEtNM1Npbk85SUlwWEh5K3h0N2M2eVdQaEN0?=
 =?utf-8?B?WHJWbVVUWDErd0lNeEF6WU41ZzFyNTJMQ0JmMmVFWFRVZVUzbnU1Smw4MlJB?=
 =?utf-8?B?UndUTUJ4NU5YK1VPdWZlcWRJbXhLY0ZSTTB0UFFGWEtyMEE0cUhxUzVTVWtj?=
 =?utf-8?B?dkZ6SW4wdnM3bjBGT29relZkZFdORWo2TlQ0bEFPN2RaMHJETEduQm12TzhW?=
 =?utf-8?B?N09NRzRsZUMwTlN2VU5CYnIzcmVYcmh6UVIxMjRKWHQ4WU9tWXI4OWExSWpi?=
 =?utf-8?Q?NQb82RPP3L4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDU5UU10cFlWUUtRTjh1WG5kalRBdlpEV0libTljZVVaU1c0THVLbWFXRExm?=
 =?utf-8?B?eWdxQnlYSDZmV3dpK3UxN2tUL0FUYUpYeHZ1K1RYMnIxS3M1RGFLS1IyVEMr?=
 =?utf-8?B?RElzWHJoTkhnWlYvOSsyTm1SdFk5STdKR1NQaW1tcDB6dmhGL2dwSlFUZFIx?=
 =?utf-8?B?WGhneTRodGRxSGhqbWY5dTAyUFNMdWwzVSt5ZEMrUzBSamxqdGxZRGc2M2JY?=
 =?utf-8?B?NkR3a1prc3JWazNWRG9PQXVHalRYbnZSQnVKb1pTY1oxNDNuU2doWllaTnBH?=
 =?utf-8?B?ZHg3RjBXSFhxOUtUSkNXU0hhTzgyelNabVlYQTVoSTg3dktiemNNV0hoNHRF?=
 =?utf-8?B?bWh3R1ZxZm95d3U1VjlmRENZVVEwWi9WT2RvdDRtaEZpWHFTbm9pbnRTQVZC?=
 =?utf-8?B?VlhQNWMzeWh4MitMZHBWOGNReFJLdURWM09CdjVNZ2JyUXVydDN4OTlWMlF4?=
 =?utf-8?B?MDRmaFlCZG1Ka1pOU2liK1h1WmQxSHpVQ3BVcUJZWlF5eWZ6dG5ydVRCVXhn?=
 =?utf-8?B?aXkxcnY5cHlWaUgraFJ3VFRQWFZrQnYwWXJBaWZWSFBXdGRlc0JCWFpxM0hh?=
 =?utf-8?B?d2pjdzBnVHBVWUh4ckZ1ZzRSZnk1M1JLR3QrTXYxcFc1QUl6ejl0V3lEdjkx?=
 =?utf-8?B?Z0Nlek9vdTI5dWgweFcyMDY4Qk1nbVhkUytyTzZpbS9PZGkrOTF0bitmNU4y?=
 =?utf-8?B?cmsxdG9Ic3ordE9GbzFWWGE1QXZGRFRySWJmNTBKNWw1RzJpUytuTG82a0JS?=
 =?utf-8?B?WHVCdERtd2Fia0ZxaVVKaUVnc1FRTGRDSnlkRDE5ekpBNko0VEl4SnZzNEty?=
 =?utf-8?B?ZWx3cmp6TDh3Ym82azVNSXlLdUZ1ZDd6QTcxdW5Gb2RvdEhsNlNRcmpRcENU?=
 =?utf-8?B?REMwS3o0TC9HVCtQeVJYYWZJSTZ1Uk1jK25ZQTFWY2kzNGk4L1E2SE9EMEV6?=
 =?utf-8?B?ZUJZT2tLYmdMNGY3bCtlcnQ1MUxwYlZMN056NWVRVGxZZWl1OGZ2WVZrWkky?=
 =?utf-8?B?Q2lTT1U5YVpJRnE3UWRFYyt1S2JRbEJMZTVkOFFMZ2kvQ2UzM1EvSVQ5b3Zh?=
 =?utf-8?B?SnErUDQyVjM1NkNEcExBVStVMkhQc205dXhvblVsck15K3ZJbGVFdVRCUnd0?=
 =?utf-8?B?TEdPNFNqYXBrbjVoZjVCaTVhUFZTNXl1akx2L25mMGsrM2pwYS93YkFrTGJy?=
 =?utf-8?B?SCtvTlk1cFNBN0RVTUZGRUZ5TXA3ZWoxKytqTWxNTll3bU5IOUlNVDFDRUpv?=
 =?utf-8?B?TGNES3QvSUpqN1Y1TlFhR3lZZ204WTQ5VFp1VDhWQjRMb0hPTzlIZTNrRFJN?=
 =?utf-8?B?Z0UwSlpiR09vZUdQclBEMmIxOXJUVHBtemtiZTU4d2tMSWdBWG1JUkxxZG51?=
 =?utf-8?B?YjF6VXBOejVrSkduSXNPTkNZR1VJZGEzOURkQk9UMGpXeVkzTGlSK1NPdmVQ?=
 =?utf-8?B?MmhNNktzdlVNZWdPNnBhOStQcHI0ZHhqYW5TK2IwUHF4cXh1QkhvV1hBbmFn?=
 =?utf-8?B?bjZnVlN3M1ZnMWVadDVOVmJNWC9EU2Y0d3UwdzNoaFA2c1BpNkI1QUhxYlVt?=
 =?utf-8?B?TktrNXRudnVocXJKeGdxeDRMaXdYcWR6dnFZVE03VEkzK09GdmhaK3FWSEpu?=
 =?utf-8?B?dkRSMzU0ZU1JQ2dUYlh5enlDZzNXWTBBL2VRN2Zja1MvOUk2T3NZVjd6WFFG?=
 =?utf-8?B?cjZBSm81MkpMK2QvejVwMC8zSEFSbG1WclpxdE4rQ2VqcVlPWXUxZzlZSEhh?=
 =?utf-8?B?SFNzWjhNZlRjdXVzQ3FwZ1pmenp5THE2ZHNOZlJqTkJWUWIrZmRiV1B3eUgx?=
 =?utf-8?B?a0M1VVhpSlMzNU1qOG8wdjNldDBwUnpWRHVZMVE0R09ZTHpGdWdKeUpDZTBt?=
 =?utf-8?B?VjFQR0ZhcDFhRzR1SkU5a3RoTFB1WDQvTEY2NG94anZNMUhMMFF1azlndGQ0?=
 =?utf-8?B?RTRTTTdXMWFUL2VTVk03Njg1Nm9HVUVQNmFzL3ZTNDI2cFpuc3BLSEJXSjZn?=
 =?utf-8?B?SDcwUXF0WHRVV3AxMVNOb1JiOXE5eUZCRVNiL1V3QkhFRWpSSENIM284eFl4?=
 =?utf-8?B?SDZTU1d1Q3dGUmRKaGRDdXZucmg2MUNYVWdnVERNdXBrTG00ZnlnV3BtQjIw?=
 =?utf-8?B?bVFoTWNXbGU2aTUxSUNDS0xwMTFYRk1jZEpaaEM3Z1Z1N1NTS0lCNEdjaEFo?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TReUfcCsKsf8Bc8BEMcDF11KFBTw7OkCfrFUwZGpvNzVhzkpk4Tmw6tRFEvCuakA5Qc9YCaBE5AlqzEIedy/rn6nMEcyQt0K7iS7OxCKQxW1EIog4xrlnGYuCpsEvuD6YQZnM7Wr0IZ74C5K0CYgpZBq0bueDysAuGqFsfPUwp8JJ+SXP8eWVf7dYyVhS0++pTb9owFHzvFSABAtK1MEDUrwFvjl6SPBsNpXb9wSKPZlGP5uHQJ9MeUKF9DkPE0zIGe8yvwUdi8jcHFv4V/s6B2pElYXItf8uLUk2blMtZaHvn2b11jWxV+k+zIipeiTJo6+D4elH3y1ZcDVzLVu+PjxRa3DZIy8Rr5bBTljXCBhWCqfrh4uUzcrwrhJyKQ+gCyIBJEsiypRzrxh3mKbBVwuVO6ZhPul0QagvRzonTAPR1e/dXzIRiKeu6QUpLvh5kpz2svJiJTwRIPFNVbulsKSW0pp09zMReqQHIhl/vRQrqNdkbDFpzgsYWybSlE18dUcJ3O5kCAaWAPzSBoOT5PacLhUV9SzMBbvS/xGD6dwuXcO+NKDauZCEr+We2WiJ33NFNSh4KtPX1novW/eOxH+Ad8UYvgzWjPCugnZJ58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c96b16-ddee-44cf-9f87-08ddf146b6c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:20:17.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQ39PArYhgfmBqyJSsRz6Ekxmpw9LjFcLyoDGbSRfFisjBhHhN7eJpT9tY8z66NRLBKOQ7vXXfv/jBheXHB5IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110135
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c2e8b5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=K3mvL8FMU6vVkPnNSp8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12084
X-Proofpoint-ORIG-GUID: 96zlZT4dIr9zLB6svV9uuORjARzJcMc4
X-Proofpoint-GUID: 96zlZT4dIr9zLB6svV9uuORjARzJcMc4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX7PGxZpyHszFz
 Ot18g3jVMLFJdu4CmPC4ZnvDUeh/An4EqxyPK+Yr0bFs7kITPlnWbfKjtmiC/9o8W5PXjbykIC9
 zvJvsMDFioiFiC/+x4pyCGZYH2KMt7zXNGQXLHo3ZIHD/kmUqrn6lnGoBdJpuUf3jH8u6kpm63m
 z4l1uZw4Uvt9V9gBoXYhl/ND/9oVCGiirtTfA5xfymjHxTQAhLdGMn/qpPkWVfSNY56hde5tcAb
 altKHotfzlGZPA8MGVzTpxaxrhBJiBqteF364I93RimQHguxTpSxZj2/5yLMr8fXY1TBjB6q4DR
 dA2+HzVMcrD+8XOVszQuFQfUa6WMOYXTz2un33FYsGg0DAl2K3PR9B68fSTGwe3NjVJYrEak8Jc
 sPJ58t9pTlD9rqrXMbzZrcyBs4NsHg==

On 11/09/2025 15:12, Andrii Nakryiko wrote:
> On Thu, Sep 11, 2025 at 3:33 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> commit 0e2fb011a0ba ("selftests/bpf: Clean up open-coded gettid syscall invocations")
>>
>> addressed the issue that older libc may not have a gettid()
>> function call wrapper for the associated syscall.  A few more
>> instances have crept into tests, use sys_gettid() instead.
> 
> we can poison gettid() to avoid this in the future?
>

good idea; I'll send a v2 doing this. Thanks!

Alan

