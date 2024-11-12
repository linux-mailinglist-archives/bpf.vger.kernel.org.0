Return-Path: <bpf+bounces-44655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F7E9C5F65
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 18:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F82BB2CAE5
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 17:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30C21731D;
	Tue, 12 Nov 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GT5kXBSN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gGhARFHU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7AC208239;
	Tue, 12 Nov 2024 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430619; cv=fail; b=nqiDUMLEFWAHyoA0jOeyT61j5vtwvnSq6KPMoqD6GEAiwqIawjVcdEZUk7DmhQqIAB3ZsTSYypN2TR77XH8ftZLWpsAV2tE3N/xtDqiLSlTifv9SSSyUGGHDs0t1MyiZQmyjKEYbMKECj6m4jb9YtmNwk6kOBKoaUmUPy/+l/+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430619; c=relaxed/simple;
	bh=G5f6c0glOkRMdB2QRIJ80ejwkWGNQIxOrufqFHd/2tg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FNjAx0UcnZb40IxIXHFJSj09xbljacZVBbVG2JzlxJUOdrbU1iQiauCsKNkw5uPqX8TJDzu83z3JGgl34Vlwa3OQ07EMYRoGX4hCKqOJda9HSPOo3zG/RC71KKuLUdtVaYl0pWEgvwjFVKBQhuG6Cul8sP9UMEPbLPKc77gQ13g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GT5kXBSN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gGhARFHU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFNcWb015072;
	Tue, 12 Nov 2024 16:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AB6MQw50oW4oOd66FLmzJzOkKLDQQEnS58fox26KF0M=; b=
	GT5kXBSN6PvZgYIpfpJKwiWuCgmRc+kX26CAIgJrMsj2wGMzk0njQA6duyfv4GNY
	03WPr1FKFtBXkJlUyIyQr0/qdv+hvQWyd/k9mwoP7HeICz/qCDsGLB9ZNGJBSc6Z
	5sFPko4bCmpwewtVBO5dp5TUGDVLdUXKfvCD7qT8LZ9xpSdfOVoxrEJ8C348qxDZ
	yk/95DZa/3Hq/2g9aPQ688XhYhAuKkdClnYMhEBVWRc+pJSK+LHY8KcQJlXwntZw
	zRhLZ5ORuSnVVjo99g3IE7ylXbROqD/FGszex3j4ZnQFIs5JBG8yQ+suK/1bfyRP
	elzoc1vhhYeOyiFtaihBYA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kbvxd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 16:56:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFUv6c001273;
	Tue, 12 Nov 2024 16:56:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68e932-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 16:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+jRTGIpZzT0csAwmnIGoFXdvJin5cKIW7dufylhGtjxN2+r7RVfkp6d5/HKWQlrwlOTmTcO+jWg3zUhaLAuDmSVN7vFDwzXrQv5jbfvlbXYUdKQntXsyT7+4qru8ZOomkhPcB6JhKzf8KA3fMOrTjfHJxxUMJTlskgVgKOtG3tcX/Ia5PdfzVF02K1UWIRaEo4iT1rZAfVHlRUSsKANLG/E+mUky8EbnIUzeQBH5V+uhQIVpbhLZ1Yd5DmG0ph7Ec0Gfkqlqih9WXkY4q9RCvintjla+jq0u1l3wznBJNHg0CcNSeQm3xY3DUDV/FU2prbYIG+xdEmMrZM+JSGGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB6MQw50oW4oOd66FLmzJzOkKLDQQEnS58fox26KF0M=;
 b=zAHilPUoIcEuatlbwJEBR8bx/lEc4HiHidxLLH9teU4DALFVQruuI8D8dmRxQwsO0GTNLSasWJWgWRjAH1HFkS3wKxT9HZl73OC7z86UbgjR3TLuJWuVu+o22tJoDknPRIunWheGM8qzqjYBkDbWcfzV5yM80deKUZp8cWw54sDJmXs+5RObMA4O28khIJO0XtRMzTtk+DxncftXnFLBqhRQYxQnWU5u8hEc+CK4w+138vmBnMM+GyMDHzYZ6fvH89ARKCaZ5pJ7DkOM/yAPYZVfQG9f/MoT46W1ajAmPpt5yh1qbLcYvVJs1bmapWSfkNfFKYzI60e/CyTBIcqRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB6MQw50oW4oOd66FLmzJzOkKLDQQEnS58fox26KF0M=;
 b=gGhARFHUamMWeKlkUinomwa68PvIcNShZZiTaFZZu+XGBBXyY+PaQxktDmhf6PHL2eJ1jhA8snFFOJdSIukW74p1LBnN1TXRPGVYYI0b/hSbSRxM2ZjAn6xdO0IkKa56wVOFcqemBQHd560HL7X5csUuH347cXAgOGq/QtrVw4A=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB6468.namprd10.prod.outlook.com (2603:10b6:930:60::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 16:56:22 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 16:56:22 +0000
Message-ID: <e311899e-5502-4d46-b9ee-edc0ee9dd023@oracle.com>
Date: Tue, 12 Nov 2024 16:56:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@fb.com, Song Liu <song@kernel.org>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev>
 <b32b2892-31b1-4dc0-8398-d8fadfaafcc6@oracle.com>
 <5be88704-1bb0-4332-8626-26e7c908184c@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <5be88704-1bb0-4332-8626-26e7c908184c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0185.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 80529187-2004-4280-cb2f-08dd033aefcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2FKUmY3TklOUjFVNUVXOFZoVFRDQzZUYlpkelhHNERwMlVKRzVoczFpMm9p?=
 =?utf-8?B?OXE2UzR5TlRTOUVFb2hpbTZ0c2lvNGtQcGdzTUlZbW1qRSt1KzUvMThwT0RC?=
 =?utf-8?B?UXlBRllxNE45ZTFpZE5QSTBJSE9SZkFKTFMvbklmejN1cnM5cEVEK3dlL1V4?=
 =?utf-8?B?UzhFeHN1RC8yenorRkxXeXJoa3NEYlFsWXlTamgzd1JYaE5vSk1ZcytDTFdJ?=
 =?utf-8?B?UUxqVWZsVDMrSG9lSjVmRFBXa3h6bjRLNitMa1FtcWppcVhDejROMldiWXQ5?=
 =?utf-8?B?dmxMMzFqamxDd0RQc3FLbGtsL3ora2tlck9aTjg3Rk9vajVXd2kzL1RzWkdM?=
 =?utf-8?B?dXVqWGd1K2tnbzJTUDdaTnV0eG14b2JtU1NHN0JxazhaaE5nYTV4b09CQmpY?=
 =?utf-8?B?N1lWbFNybnhwc3FLYytyOUtrYzlzeUNGcDEvaGNYRC95M1JHVi9Bb1pwTDJr?=
 =?utf-8?B?OWx2SW1hcXlEazM4UHBPTVhrVURReW9NeWVqZTVzeVFqVWJIaFF4ZFpRdkRL?=
 =?utf-8?B?NzYwSlozbFY0YmF0TGN5VHlTa3NheVNoaGcrNm1WNjVVaHdOSTJyR2luQkFT?=
 =?utf-8?B?UHh4WWh3SjFuMWk1OCsrZGhEaFg3aVB3Uk9YcjBibGhNZlFrSnBLUXRqK0hw?=
 =?utf-8?B?NVpGc292cUFJeE5ySHorTlhDRVVpWEYwc3dJN1ZhZ0tHRTZ2RzU4TlZHM25s?=
 =?utf-8?B?NS92UWFUYUNWZmNTajZlbW53dXFTWEdvZ2NHM0RSZkRtUVRuK1RXNnhLZTZv?=
 =?utf-8?B?Ui9Db1ZNT2pyeTJBZDhJU2xwZHo4ZS9DclJwMUJXL3V3VEZnUDRPa0JXbUZM?=
 =?utf-8?B?cm5VWnNQajdYQ0FXcnRHRFV5SS9ZVUxSYVlpZ2JadUUvVmFFQ0M1SVhMYkZV?=
 =?utf-8?B?Nm0wSkRSWjNHcmxnZmpzajZ1L1ZVdlIvczhMSlQ1ZmlOMUl5V1IzZkJZQUkv?=
 =?utf-8?B?U0xxcmRSVkZvT2ZROGxId2p2enlRUjFqdmVOSzBINXc2SHozMkNDOTRXNG02?=
 =?utf-8?B?UlUxd1ROVG9NbDd6clMrZkhZcnVTUDdlUk0rL1BScUNzS0hnL1hhSS9MR0hC?=
 =?utf-8?B?QXZxWWVOUnVqV2VLU3h6SWhQSjlwYlVTWUtlOVhqbngxNWFTK1R3ZTdJVWdX?=
 =?utf-8?B?U1laRmMraVNZeGZoQ2NNUThOK21uRW9XT1ZjZWlEcmxKK0NyWitCZVFNU1No?=
 =?utf-8?B?REVPNVVya1pqT2RnWlZPcGI5bUxkSy83cnhJYWdqaTAzSGhaQlY4dTRZREdE?=
 =?utf-8?B?WDUrbXY2UUUzQ2l5QkJpYW8zMWF4MUEybW1BYzZvNG5qQ2RFazQraytiem5E?=
 =?utf-8?B?MDBNelFDbktpNHZHSXA4ZlZPVGdKMy96SHFaM1NReTlZcUVNUmdhSXc0MkNx?=
 =?utf-8?B?dXlEYVE5SStEZlBITG8wMWhVMmJKSVdNMDdwL0pmU1hVMVdCemc2aS9UbGxh?=
 =?utf-8?B?My9UaWRVUUQ2T2hzeldKNDlDZ0s1eklTbVpOOWh0NjJNclBzRWpQbU9TcWJH?=
 =?utf-8?B?aWY1dzk4eU13OTJkS0p4V0RZREQ1Vzk4blZSeGdnUVEvUnRCcW5tVnJQMWRV?=
 =?utf-8?B?aXZTSzZaRitwRHp3empCMG9tTVIyd0luRVp4N0VidWhMbFBQd3pNbEVSUjZx?=
 =?utf-8?B?TUVKaTZQV2ZzdG9FUnE0OFpZcURySlZ3eUV4bnp6WVpoU29iMks0TjcrbmVZ?=
 =?utf-8?B?RTlrZ0tqZ2U4bFlxVGQzOHh6bTNYNnhCQnk4YnVYdmZFNUpuS0xLb0FFNHJS?=
 =?utf-8?Q?LQqLe8+uyEXfPnN81fhHloyEDHywx8sviRNxaoY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STRWd3J6a3BzdE82OUtpaktQdzlBajdESGtjZllLaUJwWnhleVJpbWt4eWRh?=
 =?utf-8?B?Y01XU2ZsNERyMjZGQld6TGhUZGl1aUVaQ2M2d1pqbTVKVVowZTVrTysxWkxS?=
 =?utf-8?B?YXNFYTBkNmU3MkxZYkQrU3hsT1c5VzFVTHcyUDRjQ2Z0T1hmNWRPQnZrM2RH?=
 =?utf-8?B?cXRaMUpkVEovQi82cjd4V2tyRFdjV24zTk43b3ZENHBDY3Rtd0VhVGFZK0Y3?=
 =?utf-8?B?d25Gb0I5ejJUenRuMHdIMko3bm9XcnlBNnlQSUw4ZXg1Y2ppMGFWeTQwTXE2?=
 =?utf-8?B?c09TQ3Z3ekdCNFkwaXdvanJTZTBNUER4TXF6RmgxbUd6UkNyWlFxMUhyaE5L?=
 =?utf-8?B?VXNxRHJ3NnlsZ2owemd4ZWNIVG1WM1dodFdPNytZM3J3M2ZQUFZ4L01PRlhO?=
 =?utf-8?B?dUM2WVB2TzNMNG9hbEJnblNYazhVNW5YOHNmV0crRVBTVDY1dkNiWU8vb2Iw?=
 =?utf-8?B?UzhCWHZTcDd2R3BYUmFWa3VNdmtJSk05WVJRUEIvK3NLUDVrWFd2dER1bWdN?=
 =?utf-8?B?NXlRRVJCU0RzcWZIcTlDUjM4bmFuYW0wSUI4RFJLcXMySSt4YUswYWpCOHZy?=
 =?utf-8?B?MFgzM2N0UFl5alVmZ3ZxQXNaVGY2Q2RWbU1QNWlueGxmRmQ5SWlZakM0MERx?=
 =?utf-8?B?Z2d4WEFFNDBtc1VRUGdmUlBKNVNEUm8rV3RCbmlmUnFjQmtCRHJuMW5ibzM0?=
 =?utf-8?B?eHNNUFdFUUI2M1k0TmI3aWxMbVd4S0dNNkpxVkMxRm90bitmY2hwY3FNanZs?=
 =?utf-8?B?RXFjYXU4QW5oTHF6V1lWT0Mwdyt0cnFkMmt3aEtMbGVDUS8xa0VyeTlmVzlq?=
 =?utf-8?B?dHBZejErUmFpQUlSTnpqU1JBZERMNHhVU1NpTzhCSFU4NmFYWjJicUhwVlVV?=
 =?utf-8?B?V2VjQzlDY2RXYWFNUFV5S1A1aW1tOFhxQVhaZEZUOE12V2hteFJSa2hKbDlR?=
 =?utf-8?B?N3lYbTZFeCtmMUtXZUZqNytwQ0JKbXhNU0MzVEtkL3RCRFRmVk1RZ3B4Y0dt?=
 =?utf-8?B?Vlo5YmFiUTNNd0pNUUJCQmwrbUl1YUFwSFNzaDFDZktBckNwSTArOWVDOEM2?=
 =?utf-8?B?L2JMOXlQQitKaHF4WUVuM3p5cHl4V3pUbWhha1ROYXdYL3lVL3JrVjBwdmU4?=
 =?utf-8?B?ZHUxbHR5RjVha1dSTG9rOGVROC9yQ1JFME96cXJzM29kb3YxZTdYdWdkTE5j?=
 =?utf-8?B?S1BuS1NROXNDRkpRUHpZRGhqVk1SNEFEbzE4bFNna3ovSGRrelpYZ3hrL0Jz?=
 =?utf-8?B?QURmbXBoTmIvZ2RWWjZYd0FjTDV4YUFmbzRtQ3JoelZxOHRhQnZtL3lqbWsr?=
 =?utf-8?B?TmdEVlMrUWZSZmZjanlGYk9NZEFPQVc5cFlrNzMvZzNJd3NyNnlXTCtDbWZM?=
 =?utf-8?B?QjJBYXdZQ3ZPYjJLRnRBZ0lVSXdZQW1WYXM3RU1yd2p0OFJycHpKeDNod0lQ?=
 =?utf-8?B?QjhhNGlYcnNKaHFuUUhXUUdIM0ZKVEJwVXI0WlRUeVBFNU9rYjZkTkEzQnhp?=
 =?utf-8?B?WjRLdHVsYzNXeVM1djBRVFlQU2I2K3hZdXZ1L21DRzJ6WG50TGtEN2RFVkZV?=
 =?utf-8?B?MnNXb3p1ZTNMMUNsVjR4SWJsT0RqemxUaUM1TElKWjhpVFA1WVgrSHg5N1lZ?=
 =?utf-8?B?RjVSK3J2Nnl4Ykh6dGFlRnNrT2NCK0NjalkwR1R1R0NQaThRaldieVJFRzRW?=
 =?utf-8?B?TS8wdGkzblVVL2ovMDNOdVB3YTBwMWpwV1BnVnhNZ2pVMTNYaUFjSzRzbkJw?=
 =?utf-8?B?UnR5YjVoUkc5WHYwTGxHZkluRDVhcS9rMkRta1B0b29GS0owcHpSMHJxQklo?=
 =?utf-8?B?QWRaemdpZGZmcFVzOHVPR0lIMFVqaW5zQVhsSUl6QXRraHdWUHBOaU4wSDBa?=
 =?utf-8?B?NXYvcS9GTFVRbVp0ZXlRZFExNGc5SEs5OUc4cG9MVUp5V0E1Zkg4dU81TnVW?=
 =?utf-8?B?RVN0ZkVVMFE0aEZWRG9EVkpJa1hEdWxEY0JOOGhUOFJaaFNZcVl0dEdUTlB2?=
 =?utf-8?B?SVN2VThpZ0p4ZHMxcDA2bU1DL0RzMEVaaXMwaW14eGV6cnVHUVV5NCtYYUZB?=
 =?utf-8?B?Z3RydmQ5SnJrbU9LS21RRlhXMVNONkh5NlZOZE11UWo5Y0R0WHR1dFBMclRi?=
 =?utf-8?B?L0NhVWR4Tk9KM1NzbmNHMWtJQ20ydzVyVmlEa0pFYm1tbkF2NnN6OVJZUkt4?=
 =?utf-8?Q?g/o1jXqU48rVBdi8xcQdDSE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t0cKx8uvJSHS3h/ENg/rradxyLEb+3Va6yHP9a3moYXH0Y6nmhVvfCe24WQ0fk13uf/sSUZk11YS+JWDf5ZnDCt4FqxGFUyxz6OLKatDw8WmUn04s7VWRc+Z+jHuVNHq9kWZ345Gi1Q0M6lVYtqT2TMK2xgww4uqGG44qhPIgHlCWD/cNuzgJbmVvslIBB3Mh/GZm5jc/eHxIwumTU28Mf8b6874BrvwO5xZw1I0qiFBs6D4G/f48/jYgnHpyzfbyc/qFMy21qpr6UredDrTvZLFvIJly9ye7wQBF8KEAGvvFOabOIW1LD7KqMCJlikkIU9J2tkEpVWivNu9meR5OR2yb0Mv1NQTBVPqNYwo2l6OG4yg968rfoTxne9yNo2E+5mp6Kk1QZ8/bx+MBsCf6R4h9loM3paBXa8xs3hBuO2zRNwPSowRXZKRPGSt+YH8uLhC15DK2VdQQoGCSEe4YljrCMcG/vl5HQvRlczU1dJhxTDauLRtSbzx6xf7PCB6OjlBpvkvAMPqia/IrcYiI3y8eMW8BYHym627I9qCYUNAb8MfENoF2Q9sUfRups8mdkYX7kBmINPQHEiDlGwygUkX52hG0Iy4drL87PCj9I8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80529187-2004-4280-cb2f-08dd033aefcd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 16:56:22.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImU6PHDD08IQyEUpc/jTVwdAPMRsgCOz5JPmCsSKim+U99j0iPTe2s6aMaPKlyyHO/aQJHuwDG+oW8sT2jvkAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_07,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120135
X-Proofpoint-GUID: A_YUPDEPn5zfe4oTHKZakmyLBLZEkX9D
X-Proofpoint-ORIG-GUID: A_YUPDEPn5zfe4oTHKZakmyLBLZEkX9D

On 12/11/2024 01:51, Yonghong Song wrote:
> 
> 
> 
> On 11/11/24 7:39 AM, Alan Maguire wrote:
>> On 08/11/2024 18:05, Yonghong Song wrote:
>>> Song Liu reported that a kernel func (perf_event_read()) cannot be
>>> traced
>>> in certain situations since the func is not in vmlinux bTF. This happens
>>> in kernels 6.4, 6.9 and 6.11 and the kernel is built with pahole 1.27.
>>>
>>> The perf_event_read() signature in kernel (kernel/events/core.c):
>>>     static int perf_event_read(struct perf_event *event, bool group)
>>>
>>> Adding '-V' to pahole command line, and the following error msg can
>>> be found:
>>>     skipping addition of 'perf_event_read'(perf_event_read) due to
>>> unexpected register used for parameter
>>>
>>> Eventually the error message is attributed to the setting
>>> (parm->unexpected_reg = 1) in parameter__new() function.
>>>
>>> The following is the dwarf representation for perf_event_read():
>>>      0x0334c034:   DW_TAG_subprogram
>>>                  DW_AT_low_pc    (0xffffffff812c6110)
>>>                  DW_AT_high_pc   (0xffffffff812c640a)
>>>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>>>                  DW_AT_GNU_all_call_sites        (true)
>>>                  DW_AT_name      ("perf_event_read")
>>>                  DW_AT_decl_file ("/rw/compile/kernel/events/core.c")
>>>                  DW_AT_decl_line (4641)
>>>                  DW_AT_prototyped        (true)
>>>                  DW_AT_type      (0x03324f6a "int")
>>>      0x0334c04e:     DW_TAG_formal_parameter
>>>                    DW_AT_location        (0x007de9fd:
>>>                       [0xffffffff812c6115, 0xffffffff812c6141):
>>> DW_OP_reg5 RDI
>>>                       [0xffffffff812c6141, 0xffffffff812c6323):
>>> DW_OP_reg14 R14
>>>                       [0xffffffff812c6323, 0xffffffff812c63fe):
>>> DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>                       [0xffffffff812c63fe, 0xffffffff812c6405):
>>> DW_OP_reg14 R14
>>>                       [0xffffffff812c6405, 0xffffffff812c640a):
>>> DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>>                    DW_AT_name    ("event")
>>>                    DW_AT_decl_file       ("/rw/compile/kernel/events/
>>> core.c")
>>>                    DW_AT_decl_line       (4641)
>>>                    DW_AT_type    (0x0333aac2 "perf_event *")
>>>      0x0334c05e:     DW_TAG_formal_parameter
>>>                    DW_AT_location        (0x007dea82:
>>>                       [0xffffffff812c6137, 0xffffffff812c63f2):
>>> DW_OP_reg12 R12
>>>                       [0xffffffff812c63f2, 0xffffffff812c63fe):
>>> DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>                       [0xffffffff812c63fe, 0xffffffff812c640a):
>>> DW_OP_reg12 R12)
>>>                    DW_AT_name    ("group")
>>>                    DW_AT_decl_file       ("/rw/compile/kernel/events/
>>> core.c")
>>>                    DW_AT_decl_line       (4641)
>>>                    DW_AT_type    (0x03327059 "bool")
>>>
>>> By inspecting the binary, the second argument ("bool group") is used
>>> in the function. The following are the disasm code:
>>>      ffffffff812c6110 <perf_event_read>:
>>>      ffffffff812c6110: 0f 1f 44 00 00        nopl    (%rax,%rax)
>>>      ffffffff812c6115: 55                    pushq   %rbp
>>>      ffffffff812c6116: 41 57                 pushq   %r15
>>>      ffffffff812c6118: 41 56                 pushq   %r14
>>>      ffffffff812c611a: 41 55                 pushq   %r13
>>>      ffffffff812c611c: 41 54                 pushq   %r12
>>>      ffffffff812c611e: 53                    pushq   %rbx
>>>      ffffffff812c611f: 48 83 ec 18           subq    $24, %rsp
>>>      ffffffff812c6123: 41 89 f4              movl    %esi, %r12d
>>>      <=========== NOTE that here '%esi' is used and moved to '%r12d'.
>>>      ffffffff812c6126: 49 89 fe              movq    %rdi, %r14
>>>      ffffffff812c6129: 65 48 8b 04 25 28 00 00 00    movq    %gs:40,
>>> %rax
>>>      ffffffff812c6132: 48 89 44 24 10        movq    %rax, 16(%rsp)
>>>      ffffffff812c6137: 8b af a8 00 00 00     movl    168(%rdi), %ebp
>>>      ffffffff812c613d: 85 ed                 testl   %ebp, %ebp
>>>      ffffffff812c613f: 75 3f                 jne    
>>> 0xffffffff812c6180 <perf_event_read+0x70>
>>>      ffffffff812c6141: 66 2e 0f 1f 84 00 00 00 00 00 nopw    %cs:
>>> (%rax,%rax)
>>>      ffffffff812c614b: 0f 1f 44 00 00        nopl    (%rax,%rax)
>>>      ffffffff812c6150: 49 8b 9e 28 02 00 00  movq    552(%r14), %rbx
>>>      ffffffff812c6157: 48 89 df              movq    %rbx, %rdi
>>>      ffffffff812c615a: e8 c1 a0 d7 00        callq  
>>> 0xffffffff82040220 <_raw_spin_lock_irqsave>
>>>      ffffffff812c615f: 49 89 c7              movq    %rax, %r15
>>>      ffffffff812c6162: 41 8b ae a8 00 00 00  movl    168(%r14), %ebp
>>>      ffffffff812c6169: 85 ed                 testl   %ebp, %ebp
>>>      ffffffff812c616b: 0f 84 9a 00 00 00     je     
>>> 0xffffffff812c620b <perf_event_read+0xfb>
>>>      ffffffff812c6171: 48 89 df              movq    %rbx, %rdi
>>>      ffffffff812c6174: 4c 89 fe              movq    %r15, %rsi
>>>      <=========== NOTE: %rsi is overwritten
>>>      ......
>>>      ffffffff812c63f0: 41 5c                 popq    %r12
>>>      <============ POP r12
>>>      ffffffff812c63f2: 41 5d                 popq    %r13
>>>      ffffffff812c63f4: 41 5e                 popq    %r14
>>>      ffffffff812c63f6: 41 5f                 popq    %r15
>>>      ffffffff812c63f8: 5d                    popq    %rbp
>>>      ffffffff812c63f9: e9 e2 a8 d7 00        jmp    
>>> 0xffffffff82040ce0 <__x86_return_thunk>
>>>      ffffffff812c63fe: 31 c0                 xorl    %eax, %eax
>>>      ffffffff812c6400: e9 be fe ff ff        jmp    
>>> 0xffffffff812c62c3 <perf_event_read+0x1b3>
>>>
>>> It is not clear why dwarf didn't encode %rsi in locations. But
>>> DW_OP_GNU_entry_value(DW_OP_reg4 RSI) tells us that RSI is live at
>>> the entry of perf_event_read(). So this patch tries to search
>>> DW_OP_GNU_entry_value/DW_OP_entry_value location/expression so if
>>> the expected parameter register matchs the register in
>>> DW_OP_GNU_entry_value/DW_OP_entry_value, then the original parameter
>>> is not optimized.
>>>
>>> For one of internal 6.11 kernel, there are 62498 functions in BTF and
>>> perf_event_read() is not there. With this patch, there are 61552
>>> functions
>>> in BTF and perf_event_read() is included.
>>>
>> hi Yonghong,
>>
>> I'm confused by these numbers. I would have thought your changes would
>> have led to a net increase of functions encoded in vmlinux BTF since we
>> are now likely catching more cases where registers are expected.  When I
>> ran your patches against an LLVM-built kernel, that's what I saw; 70
>> additional functions were recognized as having expected parameters, and
>> thus were encoded in BTF. In your case it looks like we lost nearly 1000
>> functions. Any idea what's going on there? If you can share your config,
>> LLVM version I can dig into this from my side too. Thanks!
> 
> Attached is my config (based on one of meta internal configs). I tried
> with master branch with head:
> 
> 7b6e5bfa2541380b478ea1532880210ea3e39e11 (HEAD -> master, origin/master,
> origin/HEAD) Merge branch 'refactor-lock-management'
> ae6e3a273f590a2b64f14a9fab3546c3a8f44ed4 bpf: Drop special callback
> reference handling
> f6b9a69a9e56b2083aca8a925fc1a28eb698e3ed bpf: Refactor active lock
> management
> 
> I am using pahole v1.27.
> 
> I am using an llvm built from upstream. The following is llvm-project head:
> beb12f92c71981670e07e47275efc6b5647011c1 (HEAD -> main) [RISCV] Add
> +optimized-nfN-segment-load-store (#114414)
> 6bad4514c938b3b48c0c719b8dd98b3906f2c290 [AArch64] Extend vector mull
> test coverage. NFC
> 915b910d800d7fab6a692294ff1d7075d8cba824 [libc] Fix typos in proxy type
> headers (#114717)
> 98ea1a81a28a6dd36941456c8ab4ce46f665f57a [IPO] Remove unused includes
> (NFC) (#114716)
> 
> With the above setup, when to do
> 
> pahole -JV --
> btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs vmlinux >& log.pahole
> 
> You will find the below info in the log:
>   skipping addition of 'perf_event_read'(perf_event_read) due to
> unexpected register used for paramet
> 
> In the dwarf:
> 
> 0x02122746:   DW_TAG_subprogram
>                 DW_AT_low_pc    (0xffffffff81299740)
>                 DW_AT_high_pc   (0xffffffff812999f7)
>                 DW_AT_frame_base        (DW_OP_reg7 RSP)
>                 DW_AT_GNU_all_call_sites        (true)
>                 DW_AT_name      ("perf_event_read")
>                 DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/events/
> core.c")
>                 DW_AT_decl_line (4746)
>                 DW_AT_prototyped        (true)
>                 DW_AT_type      (0x020f95f5 "int")
> 
> 0x02122760:     DW_TAG_formal_parameter
>                   DW_AT_location        (0x00769b72:
>                      [0xffffffff81299745, 0xffffffff81299764):
> DW_OP_reg5 RDI
>                      [0xffffffff81299764, 0xffffffff81299937):
> DW_OP_reg3 RBX
>                      [0xffffffff81299937, 0xffffffff812999f0):
> DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                      [0xffffffff812999f0, 0xffffffff812999f7):
> DW_OP_reg3 RBX)
>                   DW_AT_name    ("event")
>                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/
> kernel/events/core.c")
>                   DW_AT_decl_line       (4746)
>                   DW_AT_type    (0x0210f654 "perf_event *")
>                     0x02122770:     DW_TAG_formal_parameter
>                   DW_AT_location        (0x00769c61:
>                      [0xffffffff81299758, 0xffffffff81299926):
> DW_OP_reg6 RBP
>                      [0xffffffff81299926, 0xffffffff812999f0):
> DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                      [0xffffffff812999f0, 0xffffffff812999f7):
> DW_OP_reg6 RBP)
>                   DW_AT_name    ("group")
>                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/
> kernel/events/core.c")
> 
> The above is slightly different from our production kernel where Song
> reported. But essence is the same.
> The second parameter needs to check DW_OP_GNU_entry_value(DW_OP_reg4
> RSI) to ensure the second
> argument is available.
> 
> My patch is supposed to only make improvement. I am curiously why you
> get less functions encoded in BTF.
> 

Thanks for the config etc! When I build bpf-next using master branch
llvm and this config, I see

with baseline (master branch pahole): 62371 functions, no perf_event_read
your series on top of master branch pahole: 62433 functions,
perf_event_read present

So that's consistent with what I've seen with other configs; more
functions are present in vmlinux BTF since we are now seeing more cases
where parameters are in fact consistent.  The part that confuses me
though is the numbers you initially reported above

"for one of internal 6.11 kernel, there are 62498 functions in BTF and
perf_event_read() is not there. With this patch, there are 61552
functions in BTF and perf_event_read() is included."

These numbers suggest you lost nearly 1000 functions when building
vmlinux BTF with pahole using this series. That's the part I don't
understand - we should just see a gain in numbers of functions in
vmlinux BTF, right? Did you mean 62552 functions rather than 61552 perhaps?

Alan

>>
>> Alan
>>
>>> Reported-by: Song Liu <song@kernel.org>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   dwarf_loader.c | 81 +++++++++++++++++++++++++++++++++++---------------
>>>   1 file changed, 57 insertions(+), 24 deletions(-)
>>>
> [...]


