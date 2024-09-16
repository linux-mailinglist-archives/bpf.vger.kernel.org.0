Return-Path: <bpf+bounces-39999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA0B979F1E
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 12:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9251A281594
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148214EC5B;
	Mon, 16 Sep 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CU1p8HhR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EBeYPv9R"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A53C482;
	Mon, 16 Sep 2024 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481821; cv=fail; b=ENqhHUfX4kc7hdHTRDMtHGgWvhsTl5mwzQcSSbeZutwj3rxi6P6ykYoeFJplPuFjzHTXhKoeT3wAq/zlMQSYm4Csmq37Rk9KFvjYfEKwhWOLGoeCPtk9nCndRUPUa3FEywwubKsd9GPLZgsOFzA8pgTTjklUiBxUUhFrLfTp5MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481821; c=relaxed/simple;
	bh=S3N2V+nJTeG8jFhKmd75hzsAI7r5i+Sljleai9abZgU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G2OFWtTpiK9r193pUX84IMXy+FZ4i0/fFh3Ip1DZqEacFSIs0XF4dVZYRBJkTEUTrq5foG6XBvJLEn8nbQkMlxQvHvDU7UaV/UA4Tt3o/jbuMuAK+4VzMH0VQP29UnFgISqtYBIvPWepvZPhNhTiT6CC+LAPp7Qe8SjZ9O5C5Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CU1p8HhR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EBeYPv9R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48G7tdjm026585;
	Mon, 16 Sep 2024 10:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=bMNHc0BpSK1j3Irs2uob/YPZHQNFLRmHg0++/7IGBzM=; b=
	CU1p8HhRtDt82XsYwHMsbSC7UJUpDzIeFwQUXYA0BXTC0SF+haOTtX6MErhUBihX
	O8vn6F/Mm4yMD+yQfZs0/fuNRYtf9Zk0ty0Dko0mUBOIs2t1HB9oOsrdZq5lufr9
	V6uLNsCHx7etBXhzohjDE+XXRhMYvjTMEfZdAVEJyf+B5CrBmbOP2g2TG9zV8jM4
	RgTyJvzVpJ5/4adFv8f5CUH81ElnSo+dBvMkxRXuog1SdQHm4vcHrA55HU3QB0F+
	s3Y0Jy3iUe8n+FVyvxsNbnvnsRibd+vY7fmPpKr5Zll667ym1LMcLu6rs90yDwyb
	UVPUXbYRFsiEwX1figH9gQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3n3awt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 10:16:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48G91iVZ014996;
	Mon, 16 Sep 2024 10:16:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyg1nu5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 10:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHGLChgW/5WELtrk6/M9c2kVHdYl4nHF56qxFPaThKGo+g5RaL8UHLHy1iFzXaEy/i7bPdyKR/M7lnpLQ4a0jv003zjSqxCsvGgG1pPw00JKFHO4iZ+ztUjwLMhtTG6flo3qyTnY4vK8zKts+rsDaR4QL/XFFgEK9xcrlfZnK1OH5in9sle5Tm+ajfMmaTQJZwTNEOSYusW94uQhuhUAJE4YIftXkWYLicqZCQPT2rE2YltTbkCt9haJfJkPiH+oys1ltWLtLrCc6/EtEJot92arxSvzOVwiozX2jbhEGahVaUEeS8ubr8lPp0kjV8j5gOutk8t4vDbRfNJvjEqwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMNHc0BpSK1j3Irs2uob/YPZHQNFLRmHg0++/7IGBzM=;
 b=FPxrHnHyPqO1Ee3RxpYy+o40Lt1qyMqZmSvR3YGpzRABDy3DpPuxubrzVLhIxst+k713DuW1iK02ZSgugc5oJDoPtaUAKtmkQFB+ITsFp7KX6B4/eu8ZqwCeOebVTEDRBUZ3IfW/N/J9WUQV1/qSGz71enVoRdSCzz4/bjVSkm9/Otb+36RAbUe9HXEoqlIrfzjMB3xgR3J/cNHbS4AYLvhgkaB8/W3xMcVVjwjntHAfzFK4XXLKqBCj7mwIAJiDMj9+Locap2QPriHRKlq/HLsoEpl3ON81IAr52T8K7cuNKGJiv+wD5cyYdolJW90qCOXEFIjSBuZpZ/NhS7EG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMNHc0BpSK1j3Irs2uob/YPZHQNFLRmHg0++/7IGBzM=;
 b=EBeYPv9RtFfyQupDvClaBh5kFVLncYWti9LbzNSOxnCghanyH53Ju1bUqhvdKUAsiK+d8NlIW4vWFfHCHyYPFjTeqKOrZce9WLmQsDrWULC17EfcP8QOt/yUE2Ni1TORqbWquvlRvQwcYFXElcu+WR3UuJceBnJ2iemhXj3iibQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB6854.namprd10.prod.outlook.com (2603:10b6:208:425::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.11; Mon, 16 Sep
 2024 10:16:33 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.7982.012; Mon, 16 Sep 2024
 10:16:33 +0000
Message-ID: <dcaf46c8-68d2-455f-955b-311785cf2827@oracle.com>
Date: Mon, 16 Sep 2024 11:16:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v1] pahole: generate "bpf_fastcall" decl tags for
 eligible kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
        arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yonghong.song@linux.dev,
        martin.lau@linux.dev
References: <20240916091921.2929615-1-eddyz87@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240916091921.2929615-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0258.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd62210-c0cb-4724-6091-08dcd638a3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXk4MkgzMnJ5SWloMGJOM20zakJvUXFOSzg3eHFYWHhiVnM0M1RxMWlhOHRT?=
 =?utf-8?B?d2Jvc0tlK1MxbjNIZUM0Vk95cng3R3NrUksxaElFN1RrcnZuVmlvckVRdzly?=
 =?utf-8?B?TTlUSFNkVzlmUVA5MXhoQ3hsaDRSU1I3WURpc1NtdGtrMTV0dlpSVVYwRWd2?=
 =?utf-8?B?K1IzRG9rTXFkZVpSTG5nSTlYcTlqamRNL3ZYdGtqUEhhVXNLQysxVTNzZ3I0?=
 =?utf-8?B?V3VQS1h0cWg0a2JHcXZRTk5XU1ptZW9KVzRSbkdQODE1MWV0VWU5cjN1eDFp?=
 =?utf-8?B?SkhiNjRCd00zSFA3bEZkSkVHS0xlRmlvYnVzbWMyQis1cTFxVTlMSi9iZ1BU?=
 =?utf-8?B?bU5yWW94anZEcU5OTmVVc2N0NVVmWktsVzgxWDFvZ0IxKzB5M1lDUThHUmR0?=
 =?utf-8?B?Ti8vb01EOThac0crOG5QallYelMyRHBGYUVIVGIwam04bzV3Y1BIczNqZ1Bs?=
 =?utf-8?B?aDFxcytHK0o1NjMzYmRXWnAxQnZLMFBQVkJsMmFUWjZKK1RkUWRsRXpBa0VD?=
 =?utf-8?B?eE1EeU5VMkt4Nm9tWEFtT0R5RCs2NCtGdFFqbVBZQnJNbnlseEhZR1hLUExW?=
 =?utf-8?B?b0pDUVJEd09lODlSZ0k5MjJmdnJYOHlvMHRVa3FVQ0VUYkxtdVhWL0UzQ2tY?=
 =?utf-8?B?MjU4aU91MW5iWnVqdGlNa3ByTnM2N3Vvc3ZTV3Y2ZTh4S21iOExuWkl2YVpS?=
 =?utf-8?B?dWZMNWxzZWxURjl0dTNmTmJNYk9KQXVjTGtudncydVdTSXlCbnp5cUpEU3JJ?=
 =?utf-8?B?ZEF5RTdFdXIxZ1FucjdCT1ZIcktJMXdhZUxjdndSYnlFODJRUmQ5R0ZPRmI1?=
 =?utf-8?B?YkRyYTZkeFBTRFlKa3FDVmlXck8wakxzR1V1K1JaUElUWnl3K0ltcER5azl2?=
 =?utf-8?B?VGNCRC9xSjJ5TjFxSE4zTnduY1FTcVFxYmwxcWVIUnd5dW1UOWxhemYySVVh?=
 =?utf-8?B?TkgySk9xQ2xaSzZveDA1L3BiTGNPZVFrNUNYWDg1SGg4MlVrSFR0OUYrL1Fa?=
 =?utf-8?B?RkZDOGF6TnpWWDlZQURvK1RWYWpKMUhPL0JwaEhSTlRMRFRkeVcrcFF3bEZV?=
 =?utf-8?B?WlRQeGNlM3BVSnhDdUt5ZXlWWlFvL0h1b1BVbU95VVhiZStiQ1FpN1VUSXdu?=
 =?utf-8?B?M0hKSnNHblZiQTl4c2QrSy9ZSHMrQnBsWVBKRHZiNGtFaFZXZFVlWEtyeW10?=
 =?utf-8?B?VWtkUUk2Tm9EYk9vS2lCZGJCUlY5RTE0dGVxYUFNWjcxV0JFSEVsYXBEb0Np?=
 =?utf-8?B?WGRGWTgySU52ak5MRm81QzNJQnA3NE1DT3djMkcvaEtKZFBjNU1JSkFDTHRa?=
 =?utf-8?B?L0Y0c2o0NkVBTFA4djl5M2lhZmdUOGdXTmVMSUcrSHNSMGpuRDc1TFdGNzdR?=
 =?utf-8?B?c1hMaURLZnlNZ2ZOdk9aRnJWVjl6ZnVWcCtzNEp3RnhIZUcreWdMOUo1SklJ?=
 =?utf-8?B?c2xWOExFVS8vMDR2TGtIbGhsS2pWNlR1WVBPbDFvc1ZmMlN2Z0JoQ1kwWGhm?=
 =?utf-8?B?WmlkbzlzQ2c4cnVXWFVZOW9SL1lDckNOdFZkQVI0WWdVRDRiS2F5ME03MXZB?=
 =?utf-8?B?SXRWckhTYkYvR0tVekFzY0tESE1nUExVd21PNlhJU3d1N3lKOThoOElxYUI4?=
 =?utf-8?B?VzBPTDNLc0lKcVNGMmtIbTVYYXk4UzJPM3ovRE1maTRRcDhRNUxWOWtVL2R1?=
 =?utf-8?B?NXVHd3llNHhWcnYxQWRSaTRKd3dwcmFCRTdJR25HWFFsK2xWbVExN2ZEWC9l?=
 =?utf-8?B?cE5Ca2h0SzdFMmM3UXVVT3pMT1VxTEM4Kzlkbks3VVgxeVhXeC9zeCtzSjBy?=
 =?utf-8?B?UEs1ZDVJb0w3U1ViSnBZUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW1nTVVPVXJPdVlCREQyS2F6WnhBR0FNb2Rid29ROVVkWmtkdVdXY0lpUHF0?=
 =?utf-8?B?Zmg3WFRwd3FEMTh1NlMwUUJSaUw4ZFY1eWRwS1hhT2xSNkNoMmkwUDRTZkRs?=
 =?utf-8?B?QmxJbXdPcCtRYnN1NmErVE5weXpHTEJqajI3S2o3N1prUlF0ZjYwbGtUK1Zz?=
 =?utf-8?B?M3k4TzRLd3RPdTlIWENCcS9uamJkYlRCVWpMOVBuZ1J0Mk1BQUZrVXZzQ2Vu?=
 =?utf-8?B?Sjd1TmZhNXBnbjhFS3NFdEpiUmw0ZGVhRWp0NmtSdTg3NkM4eDVVWjVJNXJD?=
 =?utf-8?B?cTg1YkgrSDMycnowSG9qdlB5ampBbUVXbEI2TUtkdmFQVWVta3BCQnZFWCs4?=
 =?utf-8?B?MlI0Qm9zZExxZlYvZ1ErN3VKMno3ZzVQZlo3TmxnUmkybEMxV0tJWjRDbHBv?=
 =?utf-8?B?dGM5eTg3VHpvTEFRYkRCdkhuMjh2RFBGL1puU3dOUGxzQlpRdm9wUFcvUUxI?=
 =?utf-8?B?ZTA0OUlTeVJ1bkdaSXFRVjQzZG1DdmRmTFBaaXBpK0hhSFRVNjdRdS9JV0xR?=
 =?utf-8?B?L08vaVptT1FxV0FiVk5YVnVRMFdYV2RLQzdzdEttVjZ0bUxPWm4rM2hpcEFL?=
 =?utf-8?B?RHlLK3Q2VkZBTkozRHdtbncyc0JYaytFNEV1eHdCcHpkbzNmS3ZmRm9HSVlY?=
 =?utf-8?B?OThzdGFyOERQbHp0aEZlSjRuZ0FISk5kVTE1MFAyQVVjQ1NDVTJZRmorMkpE?=
 =?utf-8?B?bUVlTUpoejR6S2lWRXl2dDd3VlN0M0Y2RjBYR0xJNTMvd1FXVjVhS1hZOTNM?=
 =?utf-8?B?VFgzenZUVW5icExyT1BPUGhBQW5oMXlnNWZ6blRVTEM5dEVFUVppV3MyNXls?=
 =?utf-8?B?TXNCL3dQWVhUMi96ZFlWa1RKOWNybVVFQkNJeEdqUkRJYURkdm51MHlnVWlw?=
 =?utf-8?B?Q2t5SG1tbTFDd2FXTi9mSWFkNHJuNVdBQlVyMWdOV2h3TExvV0M3Sk50d0Vi?=
 =?utf-8?B?SDlFUkpLRVRhVSs1cnJTMmJ0R0ZjbHFjNmF4VHpHR2dBQ0JTNktCZktHZld4?=
 =?utf-8?B?ZWlrZWhrYVpQejc4Ykt3aEJoamplbVBIdTFJY2xWYzNUUUlzb0ZoSHBKVmVT?=
 =?utf-8?B?aDdJdWJmTHEzNWorYzJZOG5HNnJ6YWk5TXYrTEhsK0ZNOENRRHJaTnN4dVA4?=
 =?utf-8?B?eUx5c094TWxVdnRaYWJUWEpLRC9DM010WnUrdUlKT0FxWCtTY2NvejBFSzBR?=
 =?utf-8?B?WENDNHFDTWNhQVgxc0NmRkJUbkhWeDVOaHlveE16QnQwaStHMTRDVjhJRVo2?=
 =?utf-8?B?bGV5V3B6NG5OcytqWG1uTnJIcFYvUkdhalRoZjV4WVhVMDNrUWFzbG5SZWxN?=
 =?utf-8?B?aVhIWFcyODlVRS9VWXZPWTQ3TXN5R2VtSTdmaFhGc25UU3lDbG1xcmtSaldh?=
 =?utf-8?B?VDhncVpiMy9GU2c2MUthUUpmbUgvT0NBVHQxY0FmUUdlR3o3M1Y0MVYxbU05?=
 =?utf-8?B?QXcrL3FnMWsreUU0eGt3Qzdla3AzdDB6OXZsM2RiemMxZGFSd09aSVAveWxq?=
 =?utf-8?B?czFQWWNZUVM2aDN6RVo3cUtaVnZBdDZBU2ZIblQ0blpBaUtrbUNxVm1ITWhG?=
 =?utf-8?B?V3d1anpMTUV4ZS9OQTB1WENXTzl5cWw2TFNvckVvV2x6ME01UmNhODNSRndt?=
 =?utf-8?B?MG0xR0VYVmJaeTlQYTBLOWZKSHB3R2s2R3B0Y1pNTDFFSjJlUUZ2elhjc21H?=
 =?utf-8?B?aGlpSUNyQTNOMUpPMHo4RFZydjlFRnJEV0ZkaytycnhicUJIVXB1OU0vQ1VM?=
 =?utf-8?B?a0JrT3JDaGpLcDN0clk0bTBBT2dZd2RNV2FzR1NsOElpcUY5WnlzcGUzVUUv?=
 =?utf-8?B?UHpXVG11czduTTl5L3dNVDJHdWR2NFhSWWIzQ0RHNTRROWozV3ZjOUVtYWdH?=
 =?utf-8?B?dGpCNkVxekkyN3NJMGxWdDdIeHR5dnA2bWpFWGp1VVJUSUZCT05oam1FQkxn?=
 =?utf-8?B?S3BFQ2JhejhEVml0d2lsTUE0aVA3OUgwREJLamw2c0pvR0ZzWUxiWGd3aURk?=
 =?utf-8?B?WGpOc21BNmNZa3N0VE5Icjh1bmRJYlljM2k3L2JPUVFYeHRnNnZmdU1OM2ti?=
 =?utf-8?B?eGRaT0hRZmRMNVlWQmFCYWJkd2MvTEJDRVltcjVyWjBMNS83c1JvRE01SlUv?=
 =?utf-8?B?QWM3T2FrOW1WVFpXQ1MrNmZ0UXZ2OHpPYmFsd2pIc1YyamN4bExuNWtDa045?=
 =?utf-8?Q?BGR4hJ4gVswSRzF5tXwQdfE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TiJZ5TcQUByqXtzrGV5/T3XfxFZvZxb0HPltTPMJJxLcyVYj7ucC3il3cz3N/KBrXwrU56kv5ewqiIzbM9F05awUJt0G4xys3PPw7zkDtTmyNsB2yC8rcpBkk4HtzROREnPE4E9Js5iEgqNa/NtcVT6kmWhOjGXORVTXl9auPSgNdiUbjhr8V0/ZPduZSy9RqLlS0R3f4G//JL21BkxdQ0SXF7IHttfmJ1VPVupy2FO4liFosk2zv8Top83We8BGmBhUDpjPP5aG+jtK9RnDZdNoOCRjgAhcTg/iFbcAWboExLd92tHPjoseaoJSQzb1eM4Rqo8x8+3RuN5q9ieKWDnXePaxoMZb7+sBPE5ZRzHtvh3M1a+Gof1eMmvrlh5/6oiJFAWb+1THN9zJ8Qw5CkVx8eAaSJCos+JRokt35yljW3/feUhBH9JJGD0+ijne+W4rBKiNmZLe4nJWm0doh/7iKu71uB4qj//L0QOiw2Xl7U7hriStq443z/uFqqoUL6bCcK8YQ9JAUfT8IRbfzl5gaFaaDeDeGxABdPdEmukS6LZYxORrUA9jejbgV/s6XYkL5M4Lm2UnYSA4+hRK9SvjkXC5j9AkAI2GMaTlRik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd62210-c0cb-4724-6091-08dcd638a3a1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 10:16:33.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0wIFiHOERsT3UK5rmLb2icdkIWqf4OKARPkp9NhEz0Ae/fMlVtd38IF3yhaVHT53nO7OW0w797hCQRhHQ2TTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_06,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409160065
X-Proofpoint-GUID: oxdu4otWj7bPRwa5M5JWZ6K3jUio3X7c
X-Proofpoint-ORIG-GUID: oxdu4otWj7bPRwa5M5JWZ6K3jUio3X7c

On 16/09/2024 10:19, Eduard Zingerman wrote:
> For kfuncs marked with KF_FASTCALL flag generate the following pair of
> decl tags:
> 
>     $ bpftool btf dump file vmlinux
>     ...
>     [A] FUNC 'bpf_rdonly_cast' type_id=...
>     ...
>     [B] DECL_TAG 'bpf_kfunc' type_id=A component_idx=-1
>     [C] DECL_TAG 'bpf_fastcall' type_id=A component_idx=-1
> 
> So that bpftool could find 'bpf_fastcall' decl tag and generate
> appropriate C declarations for such kfuncs, e.g.:
> 
>     #ifndef __VMLINUX_H__
>     #define __VMLINUX_H__
>     ...
>     #define __bpf_fastcall __attribute__((bpf_fastcall))
>     ...
>     __bpf_fastcall extern void *bpf_rdonly_cast(...) ...;
> 
> For additional information about 'bpf_fastcall' attribute,
> see the following commit in the LLVM source tree:
> 
> 64e464349bfc ("[BPF] introduce __attribute__((bpf_fastcall))")
> 
> And the following Linux kernel commit:
> 
> 52839f31cece ("Merge branch 'no_caller_saved_registers-attribute-for-helper-calls'")
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

hi Eduard,

you've added support for multiple declaration tags as part of this, but
I wonder if we could go slightly further to simplify any additional
future KF_* flags -> decl tag needs?

Specifically if we had an array of <set8 flags, tag name> mappings such
that we can add support for new declaration tags by simply adding a new
flag and declaration tag string. When checking flags value in
btf_encoder__tag_kfunc(), we'd just walk the array entries, and for each
matching flag add the associated decl tag. Would that work?

> ---
>  btf_encoder.c | 59 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 8a2d92e..ae059e0 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -39,15 +39,19 @@
>  #define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
>  #define BTF_SET8_KFUNCS		(1 << 0)
>  #define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
> +#define BTF_FASTCALL_TAG	"bpf_fastcall"
> +#define KF_FASTCALL		(1 << 12)
> +

probably need an #ifndef KF_FASTCALL/#endif here once this makes it into
uapi.


> +struct btf_id_and_flag {
> +        uint32_t id;
> +        uint32_t flags;
> +};
>  
>  /* Adapted from include/linux/btf_ids.h */
>  struct btf_id_set8 {
>          uint32_t cnt;
>          uint32_t flags;
> -        struct {
> -                uint32_t id;
> -                uint32_t flags;
> -        } pairs[];
> +	struct btf_id_and_flag pairs[];
>  };
>  
>  /* state used to do later encoding of saved functions */
> @@ -1517,21 +1521,34 @@ out:
>  	return err;
>  }
>  
> -static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc)
> +static int add_kfunc_decl_tag(struct btf *btf, const char *tag, __u32 id, const char *kfunc)
> +{
> +	int err;
> +
> +	err = btf__add_decl_tag(btf, tag, id, -1);
> +	if (err < 0) {
> +		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
> +			__func__, kfunc, err);
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc, __u32 flags)
>  {
>  	struct btf_func key = { .name = kfunc };
>  	struct btf *btf = encoder->btf;
>  	struct btf_func *target;
>  	const void *base;
>  	unsigned int cnt;
> -	int err = -1;
> +	int err;
>  
>  	base = gobuffer__entries(funcs);
>  	cnt = gobuffer__nr_entries(funcs);
>  	target = bsearch(&key, base, cnt, sizeof(key), btf_func_cmp);
>  	if (!target) {
>  		fprintf(stderr, "%s: failed to find kfunc '%s' in BTF\n", __func__, kfunc);
> -		goto out;
> +		return -1;
>  	}
>  
>  	/* Note we are unconditionally adding the btf_decl_tag even
> @@ -1539,16 +1556,16 @@ static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *
>  	 * We are ok to do this b/c we will later btf__dedup() to remove
>  	 * any duplicates.
>  	 */
> -	err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, -1);
> -	if (err < 0) {
> -		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
> -			__func__, kfunc, err);
> -		goto out;
> +	err = add_kfunc_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, kfunc);
> +	if (err < 0)
> +		return err;
> +	if (flags & KF_FASTCALL) {
> +		err = add_kfunc_decl_tag(btf, BTF_FASTCALL_TAG, target->type_id, kfunc);
> +		if (err < 0)
> +			return err;
>  	}
>  
> -	err = 0;
> -out:
> -	return err;
> +	return 0;
>  }
>  
>  static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> @@ -1675,8 +1692,10 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  	/* Now inject BTF with kfunc decl tag for detected kfuncs */
>  	for (i = 0; i < nr_syms; i++) {
>  		const struct btf_kfunc_set_range *ranges;
> +		const struct btf_id_and_flag *pair;
>  		unsigned int ranges_cnt;
>  		char *func, *name;
> +		ptrdiff_t off;
>  		GElf_Sym sym;
>  		bool found;
>  		int err;
> @@ -1704,6 +1723,14 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  
>  			if (ranges[j].start <= addr && addr < ranges[j].end) {
>  				found = true;
> +				off = addr - idlist_addr;
> +				if (off < 0 || off + sizeof(*pair) > idlist->d_size) {
> +					fprintf(stderr, "%s: kfunc '%s' offset outside section '%s'\n",
> +						__func__, func, BTF_IDS_SECTION);
> +					free(func);
> +					goto out;
> +				}
> +				pair = idlist->d_buf + off;
>  				break;
>  			}
>  		}
> @@ -1712,7 +1739,7 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  			continue;
>  		}
>  
> -		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
> +		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func, pair->flags);
>  		if (err) {
>  			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
>  			free(func);

