Return-Path: <bpf+bounces-27845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74BA8B289D
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4781F2216B
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEA1152166;
	Thu, 25 Apr 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a/+BoLHT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yv9IoNOJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B81514D8
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071519; cv=fail; b=PujyZkUw+l5VSIt/Y9ICVjN3qXkelMVsECX+ZqgnE2Pz/ISwc0MRgBnpmtLdTq7DfkCx/mhectz6kCNyHa5N1jbLP07yOwtaqt8Hmqlv3LrS6ZnKaTDULKw9fK5YDfeWwx0/viLSEiuqtlLk6SjlTeOoMZKF04Gt383nenyFpYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071519; c=relaxed/simple;
	bh=UgSfELzyzKeXyInhhgs6VFVKZM5UdDKHD1A1lgc4sg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=OQ13kA/ERtIJ9nc7oZpm7zVswo+eWPkM31dCZefNB0/GnORBM2mxF1JZ7zE4IJCLfsOeaj2OoYGGm2A5fxYENbEpYdN9oKiGO8RWPuiNSENb+Dt19v06mWxMIoWJeawuXcG3/6FQabNcRMqipY/UbYh8IK1oQ4mrVRzTQrEJV9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a/+BoLHT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yv9IoNOJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PHOXkE032456;
	Thu, 25 Apr 2024 18:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TACO1X5BfXIuRWqvWswRP4t+CGke3RB0OzSFrLg5RWI=;
 b=a/+BoLHTxOkz2d24pmBPCOrruxxlCM6OMdKeCWPlCaA9Qc5TG0UwePyO6c+uBpsvB9On
 jUMmTecULYlOyMTHchd2X12862H6PBDQXnSbFe8KGObNdn2S4JIgsBDFUUhzF3EHkNBW
 UYU+VSLxWxEc2llMDqT8uQA0k7ADvmJo4RHlLoyLM+wJsXgUeoRwZMbb8SzyU12hVJYR
 cCbRP2XToEz+NAyF8JbzaUKPnvEGjlu727PS4GeTkW67s1obPqE8R5cAVqtgfK3PSL3H
 v9yyTG+2OhuAl9vvG2b7Bu4rLRFZQgcTFfx6mrJgAV24o1HpGuRIbTXQUX/XO2ke16j5 vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbvfp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:58:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PIHk4J006651;
	Thu, 25 Apr 2024 18:58:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45auykq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:58:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLo1iVE4DwY8eW/5/49bDh/WHuw8DpgZQiCPRn8kVkA8GzOZ8Qt8Buy7QMAMO/XjJIT6p1ntSzTcndhFJ+JdHtESGSvXbh4+No4RqQc28NoWGo8F5T8trARKiZpeU3AbHyBJo6+EayA9X9ck2LnYmOlZAP08eTwvVAEotOHHAA8xGOrvuXi9NAqbf23cRgTt57UD3yv8YFZ8H8vvRrfX3VjvuuNM2d2ofWEc1f5PmPHYGxW8+0P4hQhBy32tnC/eqEoygwlV3JyG1UOS5JchdE/zj1pHvehI/I0ntZA6gb+gZYRXUStNyFsiVugx66zW4F3YoryyJFluem3bYfz1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TACO1X5BfXIuRWqvWswRP4t+CGke3RB0OzSFrLg5RWI=;
 b=nY1Iw2cqj2toHeQqRhI+uRrvuBBZNcnqQAu8agSiGFqgVU8qLQbC/qqdjSEJhrgMMOo9ekmeB/RLn12CZm8gicZzhjCjSFTJvBVWZDySbbGCTk/8D0NbpS3k8Cr/4/oSXj9gamKqBjmgSCi98X+gZyJw5T4rYfRHPQWOE3uYZr6f0lr1C0yIslQCRqJvgyM6KVzcCEJ+hrCcDU8UpiisexZB1R1D4FkI2hwrJJZWp2fTKQbD9vcO0fSWtxD7+Vu4JNzA86mCxuRzJbGXhQToSXh1mkftdszJN3fYPD2LtU6g+GxWTvgvtMn5TnV8CHsV1hyLV0fDhJ+u1pbRypJAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TACO1X5BfXIuRWqvWswRP4t+CGke3RB0OzSFrLg5RWI=;
 b=yv9IoNOJw1d4mQ16l1m5k3r4Pm5V6IDqF76W4bwxGvqDbSwk5Td1QzNDoTizB+UxL41b6PLUNIrNjZL+3qmErNuz4I3rogwtYKNUWQIFfDoZnG710SedHKlmPDgyvMTDnud9Uu7pDxnTZWSXfJfSRO3GL2GvOb9SeJkoQpQ10A0=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by IA0PR10MB7182.namprd10.prod.outlook.com (2603:10b6:208:403::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 18:58:30 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 18:58:27 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: BPF_PROG, BPF_KPROBE, BPF_KSYSCALL and enum conversions
In-Reply-To: <CAEf4BzYfkb+ZCT+qjQZ5OA=Wy_q2ojk5RGLqf+otZGKC+c1nvQ@mail.gmail.com>
	(Andrii Nakryiko's message of "Thu, 25 Apr 2024 11:40:37 -0700")
References: <87edat1j7f.fsf@oracle.com>
	<CAEf4BzYfkb+ZCT+qjQZ5OA=Wy_q2ojk5RGLqf+otZGKC+c1nvQ@mail.gmail.com>
Date: Thu, 25 Apr 2024 20:58:22 +0200
Message-ID: <87zfth5kxd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0424.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::28) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|IA0PR10MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 292d47d7-1e37-4c27-8b3c-08dc6559b0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b2tYZUt4WDBxUTgxNnhEazU3Q0YwTVhmWjVHM01Qbk1pK3JpOXZkUFhWKzQw?=
 =?utf-8?B?MVB4UWlZK2FWVFpObGpveElnU1M1ejRIQ1M1aldIdXJtN1VaODJqN21NREkx?=
 =?utf-8?B?Ulg1NE1LT0MxYURRR3NMMTRNTHBDcTN4REdFZFZnM3gwY0RCUUw4ZlJURmxj?=
 =?utf-8?B?d0VNU0hDeWQ5Q0h0RTF3bFVtZEkwdkxhR0prNXpZV2Rkb3prTXU0QStnWUt4?=
 =?utf-8?B?L0MrZXdFRnRsaGxOTU1wT0JwY2RDUDZvVE5WR0U5TEd6RU5SZXpIWTI3N3hK?=
 =?utf-8?B?aDB0T0llZGJ2Tzh0Z2hlcWVRZ2pXUzk1bWM0R1FIRlQzOHRaYU91ZlgwRUVq?=
 =?utf-8?B?TERRU3ZoUUszajRPcnp5aEdCT0UwaEdnWXFzdG0zYzJDd1liQURoUmpMMGxS?=
 =?utf-8?B?QnhZZDZrbk5LYXhjbmlBKzhRaEw2NGltczF3WFhRZFgrRkJhR3NMdURWbnNJ?=
 =?utf-8?B?YjhCeEFITmw2SzhhdlRBOWpMS1I4Y2dqbjJWbUxxekNrbEhpWi9lK0JTS0pi?=
 =?utf-8?B?ZDB1QzhETmNZbjdYcjgzdElxMTJ1YVNkQmgyRjhBcy9lRXdOYzJsSWFLcU9F?=
 =?utf-8?B?N2xkNTZZUTRDK2xTUk1uMEh3TDNDSHF5aVl2SFpmdThxam5FWjVlenAwZkI4?=
 =?utf-8?B?cm96UjhNVlhlRUpMVUFva0ZNdnR5enNnOTZaVm1vQlNxeXRybkd5SXQ5SzJy?=
 =?utf-8?B?bzJFcmdnczJWM0FaekhHUWNjVFoyNUV0MDFrcTNzcWxuL1F4N3E3L3pLdXBY?=
 =?utf-8?B?U0hlL3hmWndPbmRiaXNxancxZitTM3hTSkdBa3BjQ3JmWFdKQ2NieDVkYVFI?=
 =?utf-8?B?bVdldHJaUVJpOU9tRElzbVRBZ3FYRTJEem9nZVBjZ0IxbWc2VnRnRE9Kbmhl?=
 =?utf-8?B?S3lSVk82Z0tKRFVRRi9iQXpIQzhqaFZ4bHdhcWlNQTVvNjZ6RlAvRzUyWDh1?=
 =?utf-8?B?cVU3cFNLK3l2SVFvRldxMnllRStzODlTYWRLOFNPMUZXMlZpcitteXVpMnJr?=
 =?utf-8?B?ZXpRRmdXaktNdlNwQVNYMllwdWtsUHlyeTZZYU1vSUsvd1p0eXJtKzJyQ1U0?=
 =?utf-8?B?YXdZVUVaTmJ2SWNDZ0VPQkF5NnEyRmNCRXlLRmdsSjg3Y2s2UHIwWVpTVVRO?=
 =?utf-8?B?ZElabFJ6c1NlNEc2Qm9Bd24zOXp0cU8xZXMvSWRyTnRlQWxEeG5EM2hGSElF?=
 =?utf-8?B?K25HWEV0OHEyQ0N0Tzk1TytWeE95dTdIaC9haFZpQjRtdEw4K1dDNDY2S1c4?=
 =?utf-8?B?eXlwU2RHT080V1pNckE3Z0xOd2p6YlRoakJab1V3em0zVEFVVGxJdGN2Q0FF?=
 =?utf-8?B?dTBYVzZCK2w0S0VqaVJ4WXNVTm1ZN1Nzc0NhOEZmbm10amU3b0haU05zT3lk?=
 =?utf-8?B?Z1M1aEFnZlMxQ3Z6b0IyNlZCVVZ3RTlNcVpMSVg2bHZEdm9pN3FoWVpLeGcx?=
 =?utf-8?B?MTVaOFR5ZUl2bGp2bXNiYmo1YkFTbFdGRm9zSXhsMkRsM2hKa0RaaCs5OUMr?=
 =?utf-8?B?cEo5emlzTVJvMnRteWFUWXRzNFBWTXlqVDdVOTlwc2tuOUZ5QS9zT3EzRjBk?=
 =?utf-8?B?U0MwRTkvR3luRzBDZkhTd3BaMTVvUVlISk9JYzI5c2hpT1BrdVlhNkNRVkdM?=
 =?utf-8?B?WHdFZ2hITUpWa1lJSDNjNWxKVFVZd3dNdnpkR3grK2oyNytGUVp0b1Z5TGNV?=
 =?utf-8?B?dDA2K3hDMnJnSEJhWVEvV3k5bzlISHYrTzROcHFiUS85bWJ1RHFEaEx3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TVZKK3Z0b1NDVUErMXV4d3JXeTIrZXJQQ1ZCUXNyV2lPVzN3VHVHak1ya1ox?=
 =?utf-8?B?RXhVMGpQWHU2YUNaU2doUC9RUUprWGIrVEJMcEtOV0lJZ3hDcytlNTV1SlRD?=
 =?utf-8?B?L3pXbWlEN25xYzRHNlBub1ZRY0lpMWhxSU9tdzhjaG9JNll5eEJIcG02Z2Z1?=
 =?utf-8?B?TVBDY0xsNXhMTGROdXhueHBoanRLcmtVVFp1elBZN3F2LzdYMGZndWlZekJ1?=
 =?utf-8?B?bXgrMFJwNU85cWVmNHhRSU5iYkI4RDNtWFdGdXNlcDJTcFV3d01WNzVoQVpF?=
 =?utf-8?B?WS9IVUk1R0tZTnpkdjZKbkFSb1JyRWVUWUVYVCtRK0c2c0xLWVc4L3I2MGVY?=
 =?utf-8?B?MGFqdHRvR2Q1NUdlYmpVMm8zTzdoNTU4V1hMOTdEanV3N0xMaG1UbGEvR2l2?=
 =?utf-8?B?am5IVk9MS3pEOTdraGdJa05UQzdFOXVkOFA5NlFGUTAvUm1XN0YzQ09FbUpn?=
 =?utf-8?B?MFo5ZDcrdW9CVUVVOE13MkJ2aWpjNEpLUGxUaHl4N056Q3hITk1WeFdrcTZ2?=
 =?utf-8?B?dGZGUG1MUDFQK0tremJvVVliZitYRDFKYWJFbExQQUdHSVJIVnJGK2lJWEdT?=
 =?utf-8?B?SnRneVhkQUZZQ1djS09kbDZwZ21QS2NqbURSbHJrQ3ZLSDBBcjZVL1l5eTl1?=
 =?utf-8?B?dzJXNTNEZW9CM1RZOExtcldJMk05UjRLd2pLQytEQS9SUENFdWZtL0t4bWpj?=
 =?utf-8?B?bmRIUDFobUlXSDMzRDN3TkNqRHJRNENKd3RhcXJWMzJJd2QrZzQrR2lmR1Mw?=
 =?utf-8?B?NGFoRHM2Z1ZEOWJDNWhHbVdvZ25JYk1xNWVyVnh0MmFvd29UWUpWMGY0eEgy?=
 =?utf-8?B?NjJyOER4QkxMZmJ2S2hjZGtIVWhiK0xRYzFjSGkwQ2ltNS9qaGFhU1cxMkFp?=
 =?utf-8?B?ZXkyTFNMQkNISVdLS1RFRkZpTlU2TWJKRTh4cWRJWVVvSXFNSEsweGc1TFJ5?=
 =?utf-8?B?cEJLWFRFMitnbW5MaDloVWZPSzEveVpRNllJRXduWFNkUC9xa0xIMGxxSmo0?=
 =?utf-8?B?NXczZGhZOG1XYkorUC9wWSs3TzNWYU14elZZMHFxeTBibXllb3dMVXVZSERZ?=
 =?utf-8?B?dGErWkZ2Nm1xaUpLZ2ZlNUZ1SmlJanFadWtGN3JINlNLS0xIa3cxbFg2dCt2?=
 =?utf-8?B?a0JoUFJBeUR3eXZ1NlJwZU5UcFZySkpkTzh0K005ZmhFeXdrV2xpODVNZjB3?=
 =?utf-8?B?aTEwNVVyaFJRUlNUejVjckNsQURGQTRDY1llVjAzWHQrWEJFcDNjZmp1YytP?=
 =?utf-8?B?djhjNUlXT1NuYTlsUjY1TkZLWTkyRVFEMnh6ZTdwT2Ria2FCSFdMdVRwU20r?=
 =?utf-8?B?LzREL0Q5Y2NKZEFTR3plU0FGNlJ4azB5STZJNU1yN05rNC9KMXF0eTQwbm5w?=
 =?utf-8?B?RmU5eW1TWGx5Q2l4R05FQW0yWEpkK0ZvQklpUW9iaXlzT3VBME5pb1JxMWlW?=
 =?utf-8?B?N1Bwc1o0ZmxtbGJLcnJFRUdPV0ZpY1VaU1pYalhwZ0crR2U2L090cFpqVFhG?=
 =?utf-8?B?ZHlHVElvY1hmTU5XQVhDcnVMc0EyOHFuWW1wMm9NWC9RaWE2ckZvZTloU0RI?=
 =?utf-8?B?Rm1LY01KaEI2OExvL2prdVA5VWtYMmRCNHdlbndmUUdIaGxOYkdWd3Z5NU9P?=
 =?utf-8?B?Y0hhektyTHZvU0FEUVRlT2tuSXI4RVlnc1VxQ1N2V3B5clVWVzJ3d3JBUW5z?=
 =?utf-8?B?S2IvdTBaZUVuTVduaGdIdzFUN3h2MW1GcWN3L1VhK3RlL2xZdXVwUDF0S2FW?=
 =?utf-8?B?Sk1BeWtaZ3d2eVpqdEI1U0xxV090RDgrekVsQUZscFlNNEwxVUVIUUFYcytR?=
 =?utf-8?B?TWdJNWZPYW9xTitoTnFNTEtrdmJIOW5FSXZLV0Q3UlRrOU1VbldRRzR4TnFG?=
 =?utf-8?B?RzRUR3VzM0UzMmNMU0hPRWNhWHZwd292UGJnN0QxaUdKSmFUMEtNNHpSUGtR?=
 =?utf-8?B?YUQ1ZlIzeUxrRjBJTzhPZ1Y1RkVMZW15b1BONEEvYngyZDNMWDNXQ3JvLy9S?=
 =?utf-8?B?cE9oREpGNzNrLzZKaHRRc1pqWURNcmM0TFBEeEJKQUhqMk5qZ2F3WUV0VDVP?=
 =?utf-8?B?QnFJQ3JMNnJmZzdLSSszWmM4UEw1ZE5FVWoxdVRpQ05ZRlRXWmhZUktvV2d3?=
 =?utf-8?B?TVFmRFovcCsySGIvTE83Z3FpZ0g2Sk5qSjcrS01QbURzTW9aRVp4bkFMWVMx?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iRKH15k34i5QtbNp78y0mnq+QRTDiPV+HKSi4TneTVMJquEHY4aDoybfYuAdPUWZQ6U9Gmkc2WPFZu6f3lHxoEGkzbddG+3btejXa17tI2LwWVrcbvQYPis2ovNi0TffFS++g7bJHmVfgDv5iQQ1byaCM4uXbsagYmksL4MhUKNKWtS3B2NsMUse0bfXZj8FXtmq8gawFRBvXK0143Qw7jCPNfjqDtxlWniHE2XL6WcUxdTynNAu2Zf8qEo06qq8C7SsPg4PvHn5skRcjgxE1zBPuSvO9kGgxqQHW/auN5e+tHTzM8mfMqNI/4t5Ckef78zlgR04ILRCH778rSck7HVCntFq4HnQnPMlv904LR7Wqp7j9xE1D7RzfsQv4jh6n5N1ok7MA86nVfT/QuvJIRrVMd/bv224v/aMFfjam7jX23ioGkswfFFXV9YyRPsxBlDkrqhq10ttrFx1tr14EePer5HK4IPhBj993c4bwAdCn+AvXT+nJlaVK1Lh0UnzIpI/GjU57ZRGGiwTxqtkpRA93YSYEqOY/ButkGTWeoyma9uJ5CODIrfjCSI3VRbj1mvUAq9DRrObHdqp3bmWRRWK6t0HbVO0ul2HcobfCkc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292d47d7-1e37-4c27-8b3c-08dc6559b0a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 18:58:27.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhO8M//zXeZPmcSWygwfRcp2tcuopikF6devu5SFq/sPyoeqNQ84Tgo/HhZ3VZYAchGKnWfpAkM7nq/NUuwAgcftdLrvjfX0558aM+Hlq8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_19,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250136
X-Proofpoint-GUID: RBQR3ZnyJmZ4H-t5Od_NOFP6bBoaasQ6
X-Proofpoint-ORIG-GUID: RBQR3ZnyJmZ4H-t5Od_NOFP6bBoaasQ6


> On Thu, Apr 25, 2024 at 9:49=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> The BPF_PROG macro defined in tools/lib/bpf/bpf_tracing.h uses a clever
>> hack in order to provide a convenient way to define entry points for BPF
>> programs, that get their argument as elements in a single "context"
>> array argument.
>>
>> It allows to write something like:
>>
>>   SEC("struct_ops/cwnd_event")
>>   void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
>>   {
>>         bbr_cwnd_event(sk, event);
>>         dctcp_cwnd_event(sk, event);
>>         cubictcp_cwnd_event(sk, event);
>>   }
>>
>> That expands into a pair of functions:
>>
>>   void ____cwnd_event (unsigned long long *ctx, struct sock *sk, enum tc=
p_ca_event event)
>>   {
>>         bbr_cwnd_event(sk, event);
>>         dctcp_cwnd_event(sk, event);
>>         cubictcp_cwnd_event(sk, event);
>>   }
>>
>>   void cwnd_event (unsigned long long *ctx)
>>   {
>>         _Pragma("GCC diagnostic push")
>>         _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")
>>         return ____cwnd_event(ctx, (void*)ctx[0], (void*)ctx[1]);
>>         _Pragma("GCC diagnostic pop")
>>   }
>>
>> Note how the 64-bit unsigned integers in the incoming CTX get casted to
>> a void pointer, and then implicitly casted to whatever type of the
>> actual argument in the wrapped function.  In this case:
>>
>>   Arg1: unsigned long long -> void * -> struct sock *
>>   Arg2: unsigned long long -> void * -> enum tcp_ca_event
>>
>> The behavior of GCC and clang when facing such conversions differ:
>>
>>   pointer -> pointer
>>
>>     Allowed by the C standard.
>>     GCC: no warning nor error.
>>     clang: no warning nor error.
>>
>>   pointer -> integer type
>>
>>     [C standard says the result of this conversion is implementation
>>      defined, and it may lead to unaligned pointer etc.]
>>
>>     GCC: error: integer from pointer without a cast [-Wint-conversion]
>>     clang: error: incompatible pointer to integer conversion [-Wint-conv=
ersion]
>>
>>   pointer -> enumerated type
>>
>>     GCC: error: incompatible types in assigment (*)
>>     clang: error: incompatible pointer to integer conversion [-Wint-conv=
ersion]
>>
>> BPF_PROG works because the pointer to integer conversion leads to the
>> same value in 64-bit mode, much like when casting a pointer to
>> uintptr_t.  It also silences compiler errors by mean of the compiler
>> pragma that installs -Wno-int-conversion temporarily.
>>
>> However, the GCC error marked with (*) above when assigning a pointer to
>> an enumerated value is not associated with the -Wint-conversion warning,
>> and it is not possible to turn it off.
>>
>> This is preventing building the BPF kernel selftests with GCC.
>>
>> The magic in the BPF_PROG macro leads down to these macros:
>>
>>   #define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[=
0]
>>   #define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)=
ctx[1]
>>   #define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)=
ctx[2]
>>   etc
>>
>> An option would be to change all the usages of BPF_PROG that use
>> enumerated arguments in order to use integers instead.  But this is not
>> very nice for obvious reasons.
>>
>> Another option would be to omit the casts to (void *) from the
>> definitions above.  This would lead to conversions from 'unsigned long
>> long' to typed pointers, integer types and enumerated types.  As far as
>> I can tell this should imply no difference in the generated code in
>> 64-bit mode (is there any particular reason for this cast?).  Since the
>> pointer->enum conversion would not happen, errors in both compilers
>> would be successfully silenced with the -Wno-int-conversion pragma.
>>
>> This option would lead to:
>>
>>   #define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), ctx[0]
>>   #define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), ctx[1]
>>   #define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), ctx[2]
>>   #define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), ctx[3]
>>   etc
>>
>> Then there is BPF_KPROBE, which is very much like BPF_PROG but the
>> context is an array of pointers to ptregs instead of an array of
>> unsigned long longs.
>>
>> The BPF_KPROBE arguments and handled by:
>>
>>   #define ___bpf_kprobe_args0()           ctx
>>   #define ___bpf_kprobe_args1(x)          ___bpf_kprobe_args0(), (void *=
)PT_REGS_PARM1(ctx)
>>   #define ___bpf_kprobe_args2(x, args...) ___bpf_kprobe_args1(args), (vo=
id *)PT_REGS_PARM2(ctx)
>>   #define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args), (vo=
id *)PT_REGS_PARM3(ctx)
>>   etc
>>
>> There is currently only one BPF_KPROBE usage that uses an enumerated
>> value (handle__kprobe in progs/test_vmlinux.c) but a similar solution to
>> the above could be used, by casting the ptregs pointers to unsigned long
>> long:
>>
>>   #define ___bpf_kprobe_args0()           ctx
>>   #define ___bpf_kprobe_args1(x)          ___bpf_kprobe_args0(),(unsigne=
d long long )PT_REGS_PARM1(ctx)
>>   #define ___bpf_kprobe_args2(x, args...) ___bpf_kprobe_args1(args),(uns=
igned long long)PT_REGS_PARM2(ctx)
>>   #define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args),(uns=
igned long long)PT_REGS_PARM3(ctx)
>>   etc
>>
>> Similar situation with BPF_KSYSCALL:
>>
>>   #define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(), (void=
 *)PT_REGS_PARM1_CORE_SYSCALL(regs)
>>   #define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args), (=
void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
>>   etc
>>
>> There is currently no usage of BPF_KSYSCALL with enumerated types, but
>> the same change would lead to:
>>
>>   #define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(),(unsig=
ned long long)PT_REGS_PARM1_CORE_SYSCALL(regs)
>>   #define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args),(u=
nsigned long long )PT_REGS_PARM2_CORE_SYSCALL(regs)
>>   etc
>>
>> Opinions?
>>
>
> I don't remember why I did (void *), but I think I was just banging my
> head against the compiler until I made it work, and once it worked, I
> didn't try to improve it further :) If casting to (unsigned long long)
> works just as well as (void *) and helps in GCC case, let's convert.

Ok, I will test a patch on that direction.

> Just please don't miss ___bpf_syscall_args* and ___bpf_kretprobe_args1
> as well.

k

