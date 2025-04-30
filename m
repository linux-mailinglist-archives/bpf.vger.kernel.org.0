Return-Path: <bpf+bounces-57056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DEEAA502E
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 17:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B844E1D5B
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CAF25A323;
	Wed, 30 Apr 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VnvdY7ZU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eKh0Kn5a"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08B17CA17;
	Wed, 30 Apr 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026744; cv=fail; b=dyXFaXIf0fyVflJdWuxpzKIWoo7dwgEtmHZdzulDlwe2dSwo/16njTm+SDzXh5vX0IMAzCV8J6U2ctbaJiKzHU49vexvaWOF9T+4o7BANPesvhDARYYzJHc/PRVC8EHPavGqsL7vbnzKK3/h6ALi6rOhfuC7SlVfFvE/PMSAxok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026744; c=relaxed/simple;
	bh=BSyOwvsEyzzeJYifwO5HecKi7bWagrxaoL1fI3opxr8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S3P3My3wvfiU/A0l52b9G9/uyvd13/9VGZ2JRM4Sq5rEUcJZlSe7837nCNvsF5NGQwN3I2r6gZPudyp0dOuxanFNrLixsI+H3Q1yKYseMd+T9IJEGAKM1GqMdTXCYZqAYoYImuDhRWXAG90kCYwjUkSEKdt+aaaAeevY1BUXfJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VnvdY7ZU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eKh0Kn5a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UFNLkr001664;
	Wed, 30 Apr 2025 15:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Kb7r81enH/1TkUUwmU0eDFe48c+ZOI1f6fPDXxCDH9g=; b=
	VnvdY7ZUAaoLPYwFU4QBluo2JQAcnDniq3CTm02JTTp36iK6FK6fICphr6PPIfJa
	Ez9MMmvFnKwlFSSeMkqrU2RhfdzRN0quj5v20Ahqsur/8H1nA1Bf/pUSTGT2VJCv
	7sk685dIETKPerEw0u0dbIZFtoHiOOdIlZ2BhjCK2gMOyMZ5BcntFjNTnbS/dDms
	5I0+JDn7wR8OecVi6W3raSBaAuXKW7N9nmOF0zb8FRWnSBI/jQiBimmObCTcKyTr
	BIDCfURwsZN2isrpxcSi82/5UXZcFxzhvdvpKOInbvDeDV8guybYTycEpIJ1sw6E
	Smt5Su6dL1CxBST4GrV9WA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ut9f49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 15:25:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UEqcqU023906;
	Wed, 30 Apr 2025 15:25:28 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013063.outbound.protection.outlook.com [40.93.20.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxhq9dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 15:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RroehAdPQ8DRibskTT8ygyg0YSTjvvY7tEasmWCK71nHv0QuRpa2T7Wpi1t/NjOpQpBfkX5mEEYH0n+lch2BwInl73exEnQEvYQ9lKfNCnk8ho9JSeTlknz+sTWD87OPfrsgkrIGC6mplM68LpAzMxwch2FHn/GG3Xm02B/pm1JyR+GYJyCinPVMwC4mPY/7XsmW/6l5zhCuqiNCLJ7AFdtsNYNWgu9WQOopnW5uwIclWmA+CupPCu64mpVf+0j40q1amRkEiAAq0NsGmtYETRINVKMlAevGrTDIeFefQAnz02QIopcr+uXZ/hLsZ1MAqntimlurhkl2152gQ9tuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb7r81enH/1TkUUwmU0eDFe48c+ZOI1f6fPDXxCDH9g=;
 b=tN1VKynGrlbnwZ4Z5Lav4DYdImnsR9M07ogk4yZTjhQeYd4SHR02bCj5VrOlGudC5GLcUqvNYEtRAikRtDgcyz2QjhBH+9Trfi8goQ6FTuVkNCM4cqRICYMrhGf/P0lifAO3Z7ZHHbNHTUGSOOTPktvAx23pbPJzKFgqkUH5WCKc5UKBeYmWYuV7o78M2GLrEhjY9MEigr18h5G5Iv1XNpubQH3P3trPbBGuy3ideOGHBq/NhTiQu4BgTOQnpN7pwvUMsIHtzNmlg7CDY9h+gTXfdjFvYqRQtnVksoyvRt0Uf+LJbHPXIPo4Vpmkryw70BMWvHjq3xWmAl8OFaveqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb7r81enH/1TkUUwmU0eDFe48c+ZOI1f6fPDXxCDH9g=;
 b=eKh0Kn5aJrz1Yv3HGR1n0DrM+mgpJ6I3wJ3heGGkHwk87AA79De9ERZGP1b4TbiZvyNa7W4EDJbqBZLaKHwTx7WEKE0DxqNZiZCiwFtv6YwkYWEKrxRVlEh4u5ptuOt2m1RRQaob0fONNLdhzbrGdkwHnEag6kQ45Nnh+ZdVeHY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO6PR10MB5540.namprd10.prod.outlook.com (2603:10b6:303:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 15:25:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 15:25:25 +0000
Message-ID: <ab9d66e1-bf54-4aa9-9f11-a3a1835acd8a@oracle.com>
Date: Wed, 30 Apr 2025 16:25:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
To: ttreyer@meta.com, dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, yhs@meta.com, andrii@kernel.org,
        ihor.solodrai@linux.dev, songliubraving@meta.com, mykolal@meta.com
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0034.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO6PR10MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e6e248-6127-4ee9-be81-08dd87fb3aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmtQSFY2MWdtRmpnZnluYlM4YTJpUU1FSm9rNkNWQUlpTWw4NFlUeUJKcWZW?=
 =?utf-8?B?R0Vodm5jMHdnSVlaZlc0Y2tRWDNaS1JOQXNmYnFLRHBUTW1ReHZyWk5UUGE1?=
 =?utf-8?B?dnJhRUQrUUpuK21FWkdMeTNPQmFxSTRVWHRhbDhmZlZrWDZseW5lNTVtcjJy?=
 =?utf-8?B?cFhNMGVmc013L2J1cDVlV1Z1Wk1IRnFPRXY2TklxZm5PTU5LRlVLY2VnT2Yx?=
 =?utf-8?B?MDB6WCttK3NvZGpTQmpwTDNFMUV6c2tIQ1l1TnYzZGw1WGV4TCt1SitMTmdH?=
 =?utf-8?B?MGpUdDlhaWF3OGF6bWZPSU9FL3ZiWnJGNlJiR3NoN2FIY1VzeGg5SjFlOEJa?=
 =?utf-8?B?ZmZieGpoc1BaTnorejExOGlobGw0VXlSTG1lUlN3dk5lcFhJUDNrdVMzSUhP?=
 =?utf-8?B?MC9LMjVpL2hpKzJOeXRGL1JoV083SFlHYkU0d1l3cHlZSnlQb204cEJUNDdu?=
 =?utf-8?B?RDNFdkNiMXgwSHRUeU5ja1hKbXpDRXN4b2RSTmFMV1ZRSHNsTEgyampOMFJh?=
 =?utf-8?B?ckkrbGZna0tucWhBUExYeU1GbFI3UE9WUW4xb256cHFlMGR3cnBGNzNQeWhr?=
 =?utf-8?B?OXlkSGNTZHlFNFZ3TkxoOVdtSElvRGRZK2lmbGZveUpjYVhsWThhVWRDYzlH?=
 =?utf-8?B?RzhrSVA5YkZ5SWF1MTVxL1FWbTlpRXRuWGJMa2FTRStUaUFqMVVsZnpoZWh4?=
 =?utf-8?B?enBudmZiSXFra2tUZEZDZXVwaDdUOElEWE1DeWhQRENTZlUxdjdaeFM5cFcy?=
 =?utf-8?B?UWRyS0dXbXI2WmN2dVg0cURzZ1NBelBQOHIzemhrOUo2YldNMS80dytINHIw?=
 =?utf-8?B?NFBuZGpOVnk2UHZ3UUgvaEl3WUxmMU5OLzdENUNsWVh2Nll3Z2o0dmhpcUc4?=
 =?utf-8?B?T3phckNRVTBaaWFhZHdsN21zd1FkTUdiZ1RiS2dObEMxMUFmVHpWSVdNZGFl?=
 =?utf-8?B?enpRdGkrZTE0bFBmNVdvS0RBR1pweVpiYkhtSXdGU0xRYkkzK3NkMHhZRldk?=
 =?utf-8?B?czNPakVSYXg2OG00d0NEUDVaZWxQSjBPUTUxdncxOXU0WUVzN3MvaVZHY25D?=
 =?utf-8?B?MkVFMDNDKysxbHo4VjVoTGpwMmpEbGNGZGo0aWc4bmF2V21MOVFtOXE1UFFW?=
 =?utf-8?B?NGVkTDNhbVJhbnY3cVNydFZqYldjSm9Rc3gzVk9KUTFXVDhpUi9ZNXplcDZk?=
 =?utf-8?B?bm1wcGlXSzMrMTZIN1IrNjdXUmViSk4wOW51dFN5dEhUeTBPM2NMVWhnYW9n?=
 =?utf-8?B?cVNGbnhNUFlUS1RRbk9mcGhsc256cmZNZ2N0NW5maDlwdkRXWG5xU0NsK3hk?=
 =?utf-8?B?UUd1QTF3ZWxOWjk4eDU5cUVEUmNwYjFJSkd2Q1FHRStEYTQ0MkUxckpjSkky?=
 =?utf-8?B?bmxpNWJMQnRhZzU5eGFDZTIvZllCaFBpZ2drVytUeVpiK2ZweTZPSjdJN05W?=
 =?utf-8?B?Rk1VVFdJeitlaDNyVm9DWWhCcWVyN1k2QlVtTWswalJuYWU3cW1aMlQ2WE9I?=
 =?utf-8?B?V09tS3NzUUJrT1BxaEVybVo0YTU1S2JlNVorc0pxSDVyd1h3MjdQdlZjcGdW?=
 =?utf-8?B?ZWFFR1FtdUkxc2FaRnd2Z3M0MmhNUmtxdkxIQjhZTCtrOG5nUXZLRzFWZEJD?=
 =?utf-8?B?UjZicW5Ud2pRTzFtcGpLYXRIZS9CTnNPTCtDbGt5U24wYm1uVHNIelJnZk1j?=
 =?utf-8?B?VkM3WVNQcXIyRk9NY1grdWl1OURkd29Ta2RrbnhZZ0tEOXRyMUUrTlBVbS8z?=
 =?utf-8?B?eVpHQ2xhRU9tS2tnRzl0K1dCR0Z3VFovSlU0eGpmbmdORnk5bHptTkpVRGJ5?=
 =?utf-8?B?dExsWGQ0ekZnZGI3bGYvL0lDenJRaEVQaklXbmRsS0YzaTgxSUlWMjUvSEhu?=
 =?utf-8?B?Mno4UVBmNlM2NGNxdXR2S1lKNGNQUENKS0lFdjFCd0MyaThRN29nazAraHBX?=
 =?utf-8?Q?IrxiuIApAJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3l4eUZhbWlvNjhXMVNtcUMwR1FWWVhYT1VWQ2RFWVQxam5OdjBOYWMwdVdL?=
 =?utf-8?B?MHRQeHdFRXYwdzZnZXdYcVVFVVc2bVRrUko2ZUYzNTRUR1NBZ09DSHpORnZh?=
 =?utf-8?B?R2hQNVJwMWpHY2NhekFMbE1sSU5nRDhwVnJSOVc4S05lajN0dksxWjQvbnox?=
 =?utf-8?B?VHdQZ3FEQjFaOWJVdFFuWSs0Z1dGV1VqSGZOemtsUW00bGJYUGNYMEJHWTR0?=
 =?utf-8?B?MXRmQjF6OHQ4eWNVRU1lY0UyYUVIVnJrQkFnOTZ1d0FHdCt0THRrZ3UwVU53?=
 =?utf-8?B?OWxuaGVmNC9zWnZBejJNaXZqWXlXOW1GYVc2S0UyZnlRVXNQeFE3VWFVQklz?=
 =?utf-8?B?UXpRbmgyeXdhSVhCRjRjUUpadmhWN0tJNVkvTEV4M0FhL2xuc1pSQXpkK1RY?=
 =?utf-8?B?c3BjL2dtaWxGcTY5MnMxckNGbnAwSHRGZ1NrUHB0ZEhoNlZyTy9JMmc2OTJm?=
 =?utf-8?B?Q3cvdXE2MCtkSkl4bUhwenlGWkFYcnIwcEx2RnVocmxZQXdzOHVjSWhUaEJ1?=
 =?utf-8?B?Z3hBZS9EY215WlJuTUpUeWlJaWxidGcwMnVBaWFPRGJORG1ibnZxcCtQR3Bt?=
 =?utf-8?B?UDFaV2UzbWV6Q1FQdXB4K0h5a242MEdaWFBaYnRUZ2diYk12elVlQ2JHVERP?=
 =?utf-8?B?U3FJRXpkN3dId1F1WDF0K2tjNHRKSEtWVitUS0JPUDhQWXZlMENDVEpHUWZn?=
 =?utf-8?B?Y1VyQkNHZGVFcXhJaDgvQi9YUTNUdG5rMWJZb3FETk4va1kva3RHUG83VnNs?=
 =?utf-8?B?OVREcERnTzlOdm9FZGtzWklFVXlET3JuKytRN29ZbUFiKytZMHkzTFhYWU1F?=
 =?utf-8?B?cCsrTGkzQVhqL2NlL0s0MnlKcDljT215QTlRQnl6YjNrN1I4V3EyMFlRTzd6?=
 =?utf-8?B?L3FrVWkyMm4vQUt5Z3pmKzVXWjBHS2JacVA2RnROVjJsVkV2dE44MjR4TEJo?=
 =?utf-8?B?R2NrcFd1VXo3SmxidE15eEFzSkpFa3I4ZGxEdWdoSnFKelRsR3hpYkZmQVBa?=
 =?utf-8?B?NjhrcHdGUTRLbmd6VjF3N0tKSk11cTJkUnM5bm1xTUNyTXRxU2tyOFVhRTNu?=
 =?utf-8?B?SzM0elh5ekhBeGRlU2tvVjRRUlhZOEE3U3lTM0xwc1VCNllTclFxbTNRd1dr?=
 =?utf-8?B?YXQ0dTVvejM1ZUg2RzVlSncxbG9KTG43cmkxYmk5ejdFeGRSTEo3ekJuVzdu?=
 =?utf-8?B?NFZ2YVpTTXBCVkdMZy9nQ0NBWWQ4UmhNTEZsdkZ1NDFrNlJ5RkRpZGxFRzh0?=
 =?utf-8?B?UGlmUTZwOWtlM2FxVXhSV3Vyd01PS29WeWZSbFhyNm95b0RRRmgwekttclRu?=
 =?utf-8?B?NjB6WWNpTUdNQ0lzU3F5QmZvYXhzR1FpcEg1N1NkNnV1dUh3ZWdFWmk3blVK?=
 =?utf-8?B?VFdBN3crYkZOZ2dyR1BBN2hGckJaVjJ5cldoNFd0QmhMVzYwSU13dndJWXhP?=
 =?utf-8?B?K3lsRWZHeWJYMTNVa3VuQXJmQXRObXFOMjVnTVVOQk93NVlqODVkWWllZ1Fo?=
 =?utf-8?B?UlJ5TllFWEtvMHN1VW05dDliSkdsbHJtMHhwaEdvN0J4a3Nqa29BeFZ3N3pP?=
 =?utf-8?B?MVUvam9teGhTQzBNcEtuU3dXSlU0TTlpeWw0bDdKS3ZaRnJMeXdueG1IZGFE?=
 =?utf-8?B?TVp3aTg5YUMzWDRSRDA3NTZ1QnEzbDlmem85TEN2UkZERDJldWhHQ1NRSkVB?=
 =?utf-8?B?Mm5IZGYvTk9qK09jT25lbU5sYTlRbVNvNDlkek5xL2p0dFdrZytGR2QxVUdw?=
 =?utf-8?B?cjdNQkE2VGp5SlVyTW1pU0ZNajNNWmFUaFZNWGFrbVllYURtd3VMSWUwWUtm?=
 =?utf-8?B?NjJFbVRPVW9PRVAxSUVOaGQ0SUxPYmQ3VW40NkN3bUd0K0pRY0dGR2xGVG5M?=
 =?utf-8?B?TGo0MGZBZDBYYnhMS0RJNFZvMlYvbVlFOEpRRXhTYlZqNHZvTEllaVB6RUpU?=
 =?utf-8?B?NkhJR1pjUThISGNFWjBNeWlMMzFuY1VKQmJBeUZGeEN0c3VlRjFzWFVzWno1?=
 =?utf-8?B?UHM3REhXNzhpdWU5azVJak1wQmhpVDFSYUVWbTlURzByL01QRG92aXVPY04v?=
 =?utf-8?B?ZDlqL2dCM2ltaDVpdGw1U2M2L3lLKy9XUWZMbDVqdkFHUVpZMldIdVVsRDhw?=
 =?utf-8?B?OXBveStFV3FiTnRRUzE0UFNodnBGUEtlQ1ZndGo5OCtiTFFoUEZjeXZOYVlw?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5VmHu0It7/s4uzfcMv2gMyegw+2ITXAEJ9LuCckMs6ueEZ9j1NRMAbWDYUuowK3wkUG27Kkb8/xuJ+qL1kN1dxUL3nc1b6UMj6hdOHZdhWBROqHmBzkkNh6Q00sQf56J8BWm+9soDXh7S1/s740nC8i6Fu5Br0sz1cNf9bDm/20SPnXlOHBaTfjVQoPdGrHWogRQrK1dKO5Vi7vjwxSou3LVTm0qWtXw3GMpWCQ8St5o6OPLK7k52yfuSvA+IcqoJrwKnte8ZpnQ9bL318r3L0E/WjSZE/B8wx0r7q+NqjbKNuGjNDBL7OjkblHBJPbe+W6AwJ15rj3BQ2UC3e6PmChLwYhKxEmwpCKF/4vUnvW10jRRt2HTH42yLI5C1AE3cQDLi63QxbSQHL4ZHRj184Gkng6oS+zOtgP5T/orNvwKeNQJKVQx4EIfRqJvTjcggieUgFYn544M2lDimUbqCSOQQ1BB1JOUyld2B0RNZR2z8cpMPDMFNP/MTSDKS2Bk3JsE7AvoMxZgh6zri8T1avv/ygbmvxp+Tv+Vv6DYPuS4+oDMZ4RO1LSi+CPgxTgpjLG5pLusEEIPpRxwyyk+YI4/i56SdpLjGeJspozkqZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e6e248-6127-4ee9-be81-08dd87fb3aa6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:25:24.9264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyWKKJvfDMwDVm8c+rXZLFtfT+Cc/+qBiebceAuwWacPrHjUn4kxSl9XdF9PlKfX38iCv1AaTKx99VTuZL7YIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300110
X-Proofpoint-GUID: JAzAQEFdCo9SMxzRY0rN-n1823zXz_YI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEwOSBTYWx0ZWRfX4VKF3na4XaRD b2hjrGfsqYs00XBu4Ee4iATFnGpsuiZpQAflMKI1NXjY895SOzFIE6thIE7RsQooH+nlJjUZ7+P aEDvsn9Reb091DB5/OvcV+QCCxic/RQE2kRN5lQcp67wQeB9CKYFAXoTtTP+1L1+KMoQRXEfA+S
 am648cG9POPLRw3cZYFaLgO5wbQGLhcwdUcczKlYp6tBO7V4gHmavn/qGa1+KFdZenrHOzAc0jx xqT7lW7Tj/YQg8sSRW/0i5I+KZ3c3bQnDx0els3PXAyQLaxBNXHOsAJDzaTCZCZxuPvwPOCfAOg 7YrCDigFDUs2Djsuu7xfCCY2lViq6kq1n14CuwbUurulbBo0E6oo9Pq9HrhW5qEFjlhdKtVAJjk
 4SMwBkpUca5Q8BPs1BMymOAfaV2uvCvAe0PsM1Tr+frLXZnn7ai2s9lYhc1BaC57yrZYgtJ1
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=681240e9 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=VabnemYjAAAA:8 a=NVz-8XU8SRdLVcNw8_0A:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: JAzAQEFdCo9SMxzRY0rN-n1823zXz_YI

On 16/04/2025 20:20, Thierry Treyer via B4 Relay wrote:
> This proposal extends BTF to list the locations of inlined functions and
> their arguments in a new '.BTF.inline` section.
> 
> == Background ==
> 
> Inline functions are often a blind spot for profiling and tracing tools:
> * They cannot probe fully inlined functions.
>   The BTF contains no data about them.
> * They miss calls to partially inlined functions,
>   where a function has a symbol, but is also inlined in some callers.
> * They cannot account for time spent in inlined calls.
>   Instead, they report the time to the caller.
> * They don't provide a way to access the arguments of an inlined call.
> 
> The issue is exacerbated by Link-Time Optimization, which enables more
> inlining across Object files. One workaround is to disable inlining for
> the profiled functions, but that requires a whole kernel compilation and
> doesn't allow for iterative exploration.
> 
> The information required to solve the above problems is not easily
> accessible. It requires parsing most of the DWARF's '.debug_info` section,
> which is time consuming and not trivial.
> Instead, this proposal leverages and extends the existing information
> contained in '.BTF` (for typing) and '.BTF.ext` (for caller location),
> with information from a new section called '.BTF.inline`,
> listing inlined instances.
> 
> == .BTF.inline Section ==
> 
> The new '.BTF.inline` section has a layout similar to '.BTF`.
> 
>  off |0-bit      |16-bits  |24-bits  |32-bits                           |
> -----+-----------+---------+---------+----------------------------------+
> 0x00 |   magic   | version |  flags  |          header length           |
> 0x08 |      inline info offset       |        inline info length        |
> 0x10 |        location offset        |          location length         |
> -----+------------------------------------------------------------------+
>      ~                        inline info section                       ~
> -----+------------------------------------------------------------------+
>      ~                          location section                        ~
> -----+------------------------------------------------------------------+
> 
> It starts with a header (see 'struct btf_inline_header`),
> followed by two subsections:
> 1. The 'Inline Info' section contains an entry for each inlined function.
>    Each entry describes the instance's location in its caller and is
>    followed by the offsets in the 'Location' section of the parameters
>    location expressions. See 'struct btf_inline_instance`.
> 2. The 'Location' section contains location expressions describing how
>    to retrieve the value of a parameter. The expressions are NULL-
>    terminated and are adressed similarly to '.BTF`'s string table.
> 
> struct btf_inline_header {
>   uint16_t magic;
>   uint8_t version, flags;
>   uint32_t header_length;
>   uint32_t inline_info_offset, inline_info_length;
>   uint32_t location_offset, location_length;
> };
> 
> struct btf_inline_instance {
>   type_id_t callee_id;     // BTF id of the inlined function
>   type_id_t caller_id;     // BTF id of the caller
>   uint32_t caller_offset;  // offset of the callee within the caller
>   uint16_t nr_parms;       // number of parameters
> //uint32_t parm_location[nr_parms];  // offset of the location expression
> };                                   // in 'Location' for each parameter
> 
> == Location Expressions ==
> 
> We looked at the DWARF location expressions for the arguments of inlined
> instances having <= 100 instances, on a production kernel v6.9.0. This
> yielded 176,800 instances with 269,327 arguments. We learned that most
> expressions are simple register access, perhaps with an offset. We would
> get access to 87% of the arguments by implementing literal and register.
> 
> Op. Category      Expr. Count    Expr. %
> ----------------------------------------
> literal                 10714      3.98%
> register+above         234698     87.14%
> arithmetic+above       239444     88.90%
> composite+above        240394     89.26%
> stack+above            242075     89.88%
> empty                   27252     10.12%
> 
> We propose to re-encode DWARF location expressions into a custom BTF
> location expression format. It operates on a stack of values, similar to
> DWARF's location expressions, but is stripped of unused operators,
> while allowing future expansions.
> 
> A location expression is composed of a series of operations, terminated
> by a NULL-byte/LOC_END_OF_EXPR operator. The very first expression in the
> 'Location' subsection must be an empty expression constisting only of
> LOC_END_OF_EXPR.
> 
> An operator is a tagged union: the tag describes the operation to carry
> out and the union contains the operands.
>  
>  ID | Operator Name        | Operands[...]
> ----+----------------------+-------------------------------------------
>   0 | LOC_END_OF_EXPR      | _none_
>   1 | LOC_SIGNED_CONST_1   |  s8: constant's value
>   2 | LOC_SIGNED_CONST_2   | s16: constant's value
>   3 | LOC_SIGNED_CONST_4   | s32: constant's value
>   4 | LOC_SIGNED_CONST_8   | s64: constant's value
>   5 | LOC_UNSIGNED_CONST_1 |  u8: constant's value
>   6 | LOC_UNSIGNED_CONST_2 | u16: constant's value
>   7 | LOC_UNSIGNED_CONST_4 | u32: constant's value
>   8 | LOC_UNSIGNED_CONST_8 | u64: constant's value
>   9 | LOC_REGISTER         |  u8: DWARF register number from the ABI
>  10 | LOC_REGISTER_OFFSET  |  u8: DWARF register number from the ABI
>                            | s64: offset added to the register's value
>  11 | LOC_DEREF            |  u8: size of the deref'd type
> 
> This list should be further expanded to include arithmetic operations.
> 
> Example: accessing a field at offset 12B from a struct whose adresse is
>          in the '%rdi` register, on amd64, has the following encoding:
> 
> [0x0a 0x05 0x000000000000000c] [0x0b 0x04] [0x00]
>  |    |    ` Offset Added       |    |      ` LOC_END_OF_EXPR
>  |    ` Register Number         |    ` Size of Deref.
>  ` LOC_REGISTER_OFFSET          ` LOC_DEREF
> 
> == Summary ==
> 
> Combining the new information from '.BTF.inline` with the existing data
> from '.BTF` and '.BTF.ext`, tools will be able to locate inline functions
> and their arguments. Symbolizer can also use the data to display the
> functions inlined at a given address.
> 
> Fully inlined functions are not part of the BTF and thus are not covered
> by this proposal. Adding them to the BTF would enable their coverage and
> should be considered.
> 
> Signed-off-by: Thierry Treyer <ttreyer@meta.com>


This is fantastic work; a huge step forward having a practical
implementation of inline handling! So while I have some suggestions
about how we might be able to somewhat rework things to tackle some
associated problems and integrate more completely with existing BTF
representations I want to make sure they do not detract from the huge
progress you've made here.

There are some existing problems we have in tracing functions that could
benefit from an approach like this.  In the goal to maximize the
traceable surface of the system by representing functions in BTF, we
currently have to make some compromises. These are:

1. multiple functions with the same name and different function
signatures. Since we have no mechanism currently to associate function
and site we simply refuse to encode them in BTF today
2. functions with inconsistent representations. If a function does not
use the expected registers for its function signature due to
optimizations we leave it out of BTF representation; and of course
3. inline functions are not currently represented at all.

I think we can do a better job with 1 and 2 while solving 3 as well.
Here's my suggestion.

First, we separate functions which have complicated relationships with
their parameters (cases 1, 2 and 3) into a separate .BTF.func_aux
section or similar. That can be delivered in vmlinux or via a
special-purpose module; for modules it would be just a separate ELF
section as it would likely be small. We can control access to ensure
unprivileged users cannot get address information, hence the separation
from vmlinux BTF. But it is just (split) BTF, so no new format required.

The advantage of this is that tracers today can do the straightforward
tracing of functions from /sys/kernel/btf/vmlinux, and if a function is
not there and the tracer supports handling more complex cases, it can
know to look in /sys/kernel/btf/vmlinux.func_aux.

In that section we have a split BTF representation in which function
signatures for cases 1, 2, and 3 are represented in the usual way (FUNC
pointing at FUNC_PROTO). However since we know that the relationship
between function and its site(s) is complex, we need some extra info.
I'd propose we add a DATASEC containing functions and their addresses. A
FUNC datasec it could be laid out as follows

struct btf_func_secinfo {
	__u32 type;
	__u32 offset;
	__u32 loc;
};

In the case of 1 (multiple signatures for a function name) the DATASEC
will have entries for each site which tie it to its associated FUNC.
This allows us to clarify which function is associated with which
address. So the type is the BTF_KIND_FUNC, the offset the address and
the loc is 0 since we don't need it for this case since the functions
have parameters in expected locations.

In the case of 2 (functions with inconsistent representations) we use
the type to point at the FUNC, the offset the address of the function
and the loc to represent location info for that site. By leaving out
caller/callee info from location data we could potentially exploit the
fact that a lot of locations have similar layouts in terms of where
parameters are available, making dedup of location info possible.
Caller/callee relationship can still be inferred via the site address.

Finally in case 3 we have inlines which would be represented similarly
to case 2; i.e. we marry a representation of the function (the type) to
the associated inline site via location data in the loc field.

Does this approach sound workable? I think from your side it gives you
what you need:

- signals to tracers that functions have a standard form (FUNC is
present in vmlinux BTF)
- signals that functions have a more complex, site-specific form (FUNC
is present in vmlinux.func_aux)
- privileged-only access to address info by controlling access to the
/sys/kernel/btf representation of the func aux info
- a way to trace an inlined function via secinfo mapping function
signature to location at a specific address

If so, the question becomes what are we missing today? As far as I can
see we need

- support for new kinds BTF_KIND_FUNC_DATASEC, or simply use the kind
flag for existing BTF datasec to indicate function info
- support for new location kind
- pahole support to generate address-based datasec and location separately
- for modules, we would eventually need multi-split BTF that would allow
the func aux section to be split BTF on top of existing module BTF, i.e.
a 3-level split BTF

As I think some of the challenges you ran into implementing this
indicate, the current approach of matching ELF and DWARF info via name
only is creaking at the seams, and needs to be reworked (in fact it is
the source of a bug Alexei ran into around missing kfuncs). So I'm
hoping to get a patch out this week that uses address info to aid the
matching between ELF/DWARF, and from there it's a short jump to using it
in DATASEC representations.

Anyway let me know what you think. If it sounds workable we could
perhaps try prototyping the pieces and see if we can get them working
with location info.

Thanks!

Alan


> ---
> Thierry Treyer (3):
>       dwarf_loader: Add parameters list to inlined expansion
>       dwarf_loader: Add name to inline expansion
>       inline_encoder: Introduce inline encoder to emit BTF.inline
> 
>  CMakeLists.txt   |   3 +-
>  btf_encoder.c    |   5 +
>  btf_encoder.h    |   2 +
>  btf_inline.pk    |  55 ++++++
>  dwarf_loader.c   | 176 ++++++++++++--------
>  dwarves.c        |  26 +++
>  dwarves.h        |   7 +
>  inline_encoder.c | 496 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  inline_encoder.h |  25 +++
>  pahole.c         |  40 ++++-
>  10 files changed, 765 insertions(+), 70 deletions(-)
> ---
> base-commit: 4ef47f84324e925051a55de10f9a4f44ef1da844
> change-id: 20250416-btf_inline-e5047eea9b6f
> 
> Best regards,


