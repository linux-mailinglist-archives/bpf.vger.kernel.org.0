Return-Path: <bpf+bounces-29708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECB8C59B9
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3240B1F23657
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB6417F377;
	Tue, 14 May 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E0x0fyCQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vVmXM8wj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A917F39C;
	Tue, 14 May 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704192; cv=fail; b=lGlsUAIpzIWVjJNPyICN4iIXQd3/Gpyf8IjaRXk9JoKiNx4aneJYYAyN3+b9G5uQBi2Gxzd6M0Lxq551UP6uNMdAJzKmqc8jMyA08ObwiHbMg2zS9+sheqetZz4Kge6bAerlMuy+YeFQ4iECyeF48GF/rCOVJ7TudE6mq4b8aa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704192; c=relaxed/simple;
	bh=15VojRLfP61wKoN++vhcjjoCtitAr27LMPmxppsKEy4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WIxZUYNZB7OiUXg9Bq4lDSENsryeU1b++UVg0xCQcFqJX7ZJnwt/wV/qF15fkWTypuL5ZdX0nBCFbS2rnbK2GR4s5W1cjqaqqXY5Usv2r42nHx+czdGE5l7ohPtk2QasTg0IlN+Rz57tb74VhqEchlRjhlC3wOEU7tvaKaCaS2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E0x0fyCQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vVmXM8wj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44ECg2pv015085;
	Tue, 14 May 2024 16:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NQEN7JLzP+mZmZQq/vjTco+QVtrcsGx12335ITnBrGU=;
 b=E0x0fyCQZ0YkIy0MG7XGp0DomtAIuk1RCj9v57zeZieD1Hq8vR8z/uASn55d41VaB6k+
 PoPyOWxvOs4/LB0aenB+nsOHufzv7ZHO7MjW3ZajTBWyHgJLyL75deSUUcVkmAKaFac+
 6nCqy+i7RziAzThgyM0J+dqkPf6+MRNnBdmnkjgeF4Y4YiRHl/57YIKKTjPh8hx+sCSx
 6U04z5cQncqUeimIa6oL/IjPTZuciAoWUhS8mwGPqGDo6Uns1yqDERB6KyJya1MZGX5v
 oj5psyf8ajD/q4hkJorKZIHXbRQXpMtxtXc+j4DWLTT2VbK8s5+QtXwlVEoaj8dXp9gA sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7a8d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 16:29:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44EFi1DS017279;
	Tue, 14 May 2024 16:29:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y47ffwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 16:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wny+8+IDMcUl5VUoPr+WG6Xcb0uuyH3NTRdoQJUWj1M7dFoqeK6uM88k85831SYz/BP1vhtOjPYKLoadBdjLRlxjVSaVpACf6Pt8hT69VY/fsZ+wdnLgIZszfIhFdVfrbqBwv9cmtcm0WD8Nkxt3nvbMgkuBNPyO91ydHkbndAFMf2Cv9c7OW7UR6vraIGbT6RzU2anEDxZ/4B3xvNDHTZXxeoMUnELB93hrFImJCc04GsLs99eLYrUU9sSSA+Z5y8yy111DJzij87uSKrzYbc6/Kt4b23WOjFF94GDwJn4R08C/J/Pi4qcOdiXOyue/df4bWdcSpeAJ5UggCU1kMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQEN7JLzP+mZmZQq/vjTco+QVtrcsGx12335ITnBrGU=;
 b=a4V/kTjCyk/4C9WU8P7hingMvyGHv1yscRgfu4DtOFWISE8SRJSsjvLIKsJoiWAySCeUkpLeIyVKkcLdIAisf3nt3tB80/zt32TfDINvCqkDK7MDqScUAxc88crYoYQBkWWEnFCgUoWr/leVVvRUoU7QHD7wNTrjaeDjsTpRxoshHzcDMVQv+seO36fhxXHKl+2H2EPBqcuJZYmF3mqhjMOwdSqZ7jsZtJMFVSPMcOLcMH+mQK3QGcla+lcX35PoOAoGRK3FhQ2ZfxR8ygaosDV7uJalv8dQ5LjJVU536NNXxFhqjcx3g8ZJ01DzNffVEpKZ9l9ILnYJX1uwNGd46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQEN7JLzP+mZmZQq/vjTco+QVtrcsGx12335ITnBrGU=;
 b=vVmXM8wjquvuMxHdwp9l289l7a7gt/dKfcdLNStyMudc0loz419jka1hXFgYVBrTXxlIUKRhO2KWSaxUEl339eIwdQ7TbuIg3W0EzrMlu9m/7/afPn+1rDF2XKuqWEwK6YDUr+zsskz2I3DezVJDEjZ5GxzaJv/D5aK9BIw4ifY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4784.namprd10.prod.outlook.com (2603:10b6:a03:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Tue, 14 May
 2024 16:29:26 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 16:29:26 +0000
Message-ID: <9a279f45-86ce-4ce0-9828-ba9cdd39c0ee@oracle.com>
Date: Tue, 14 May 2024 17:29:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next] kbuild,bpf: switch to using --btf_features
 for pahole v1.26 and later
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, eddyz87@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20240507135514.490467-1-alan.maguire@oracle.com>
 <CAEf4BzbWANm+Bf63hcFAB3Tn51tOeBLhyabV3NNz8tjaMnThjg@mail.gmail.com>
 <339b9430-145f-402a-a93c-8440797c98a4@oracle.com>
 <CAEf4BzY_xwD+7b31VtS4SPh-p+ES4BUDV2um+QGcdD878Onn=Q@mail.gmail.com>
 <CAK7LNATyMpKGK=7SMawHeZFg7MBJa0i5xsvyc+=dOxw9g0RWGA@mail.gmail.com>
 <CAEf4BzZrAf9GberDcC+Q3iR375Y2gzpnvGBvihftmK2WWUS3qA@mail.gmail.com>
 <CAK7LNAT1Apq4bNRstNgH8nQ4SMdFGqwGnQgWaSiBke0KPUyksQ@mail.gmail.com>
 <CAEf4BzZrak8+F+b-OXJOppws=88RNi_mpiSP=Z0dD=QJZKPF4A@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZrak8+F+b-OXJOppws=88RNi_mpiSP=Z0dD=QJZKPF4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4784:EE_
X-MS-Office365-Filtering-Correlation-Id: ed88fb1f-a139-4c40-5441-08dc7433058d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWlxRlZzaS92M0EyVWJMeGppMUZjSkZVZ1JONUZ4ZUlnQWowdmY3bHdWTURN?=
 =?utf-8?B?Ulo5Q0cxQW1VTEhBNHliZzdET29xMC9YRGJDa1ErTDgrSk1XUEx3SHVlWkVK?=
 =?utf-8?B?WE9hdmg5SnJoSlprOWxXekZQeDhUTjJFTFU5aEZLSmF3RG4wWExCODVsMzFI?=
 =?utf-8?B?WlBJNjcvMjJPckNMd0dyb3diMklxM3JSbENDVnhESUhRVkNDUVN0S0IyOFRP?=
 =?utf-8?B?VU9vdHY5VU5lc2VXOEpONktsVlgwZUovS1A5WTB1U0NtUjQ2MkZnUFNocjBT?=
 =?utf-8?B?cUlUWG9mQXFiZGZEMXA2ZkZVWmpBRXp6WFE1aGtVT0J5ZU9CampXbXlZY05z?=
 =?utf-8?B?N0FpYitoeHdVcnBMR29xYk5wODNGamxUT3daQjZ2UnNOTmt0UFNGRTc5OHcw?=
 =?utf-8?B?bEJDUjBDTVIrdHZGVGNHWEszbTNkZXZxMXRlbmpLMXZGRzB5VzlhMlJQb0Ri?=
 =?utf-8?B?dmIvY3djRk4vS0ZPMVlJZVExOG1xN0VnRElZZ0xRektVZm1ya2tOV1ZNUjV5?=
 =?utf-8?B?UHFrRkZXZ0xDWUZvVyt2ditXaTdZVWErek1qdHdlVEgwVTV0VGgxS3lrVHdJ?=
 =?utf-8?B?VWptT1NnZzhUSnU0VGN2dnN1K0FIR2NSZXVqZXJaYUltTmpoMVNHMnROVm9h?=
 =?utf-8?B?UEhBMjRwQ1ZlR2hQd3dvUkJwSzJIZ2dIanVrUndxWFZrM1VmWGhVNCtseUgy?=
 =?utf-8?B?TUhvb2tyN2FSanN4Q2dPY1FNMy9hK0hRTFhnc3dFNExsTzBpdG1hWGYyTklM?=
 =?utf-8?B?WjlaRHp1a0M0THpiVVBKaEV1bVVXRXRPQTBXbjlqTDF1aFIzdnFXNW1pdUtZ?=
 =?utf-8?B?bGkyODQ3enVZR1B5c1V4bSs1UWlGdkoyOTlJSW5XWlRsa1VUTEE5c1JpakFu?=
 =?utf-8?B?L1E0SWthVGs2QTJsY1ZLNjJnTVRKcDNveHNhY01XTndPMW9HRzVZNUpvVmdD?=
 =?utf-8?B?RlFrTEhaQ3Y3T0VYYXBnNm9tU2pkSUQwOXIrT3IxTERLU2QzKzFBcXh5dDFo?=
 =?utf-8?B?THRCNzJlWVIwZTlaVWxPRVA5WUw0cEdZT0FTaDg1UHc0bWxYOUFGelhaeWpK?=
 =?utf-8?B?UzJBMzFPdXdtZGxZalY3SG03M1ZtZFl4bGR0ZXVacjRmWUtzWlVHZWFaMU5k?=
 =?utf-8?B?eDFTTDdFQ3l4MzQ2eHRnZ1dmZSt1ZkNIOUdOVXFaVEYveWVtZmFmT1BvOUtN?=
 =?utf-8?B?UWt1YkYvUXE1QVZBbTNpNWF1eElJeW1vWWVJOUNuVC9sRFVjVkZIWmdPUVJX?=
 =?utf-8?B?RFNPV29NMW5GOWRPaU95TXJ5d2k4L0JneE5pV2FSckFMcEhxVHNMdmtlNEpy?=
 =?utf-8?B?QXM1ZnVjcVJYNkpxbmNiRklIV3FiZTVVNHQ1cGpNTjV1Wkx0VVg2Y3M5RHpa?=
 =?utf-8?B?Yys4blROSEpPdHd4bFF3T3VQWVQzTE9ZY3FBTnM2N29mb3V2UG9CcEpwQ0Ey?=
 =?utf-8?B?cHY1VlZ1dERpM1hSdkR6SU5kcjNNVHJQMjJ3S2V3SXlVMnRhVjh5Y2w1Mngz?=
 =?utf-8?B?dm13eU5Leittemltb3RYZ3FRNlJMZlZ3djBCTlY5ZnhtYVlYT25kcjZhNlVL?=
 =?utf-8?B?dURzSE5IbHEwWkRsbXRZYnVva1RyR25Pa3FWWFZyQW1XTCtrM1p6WWNxbnRO?=
 =?utf-8?Q?TeLAw1F8aWuLxCimAB6QnSheVJB7VxDYwBSMvu1yGRuI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dlgySk5ua3dJMXEzaVk1RXpQZjlVZDczbmFlbjliVGg5Z0RTdHFySkxLZUVP?=
 =?utf-8?B?ZENnZjZUTHgrVEZOUFltZjd1R3krdlQxaC9NV0VjRFZYRXM1c09HUXBLUCtp?=
 =?utf-8?B?TStETEtpSWhsQTR4eEFJVVkwODl5bkxQTWxrNUgwZnBJdjlYZGNOMVhCTDg2?=
 =?utf-8?B?a0JKMmVTbWFEcUlFa2pTaGJKRHpXU1FmZ3RhTjV3Vi9FS0hJbFE3ZWNmRWdw?=
 =?utf-8?B?ZE9SY3FMSzB6d2dPZjArWDlFVkovVHdyUXpUTWxmazE1WTB6WlQrTHFWSjVY?=
 =?utf-8?B?RHJkSkcweTdVTEh6YXdqVGJKQ0Q4MDBOYlVpUnprOHBaQ2hEbnJDYktob2Vq?=
 =?utf-8?B?SndhdjBmZTB0S2dEdWpKNnFVZDBCK3Z4Rnp3S21UbC9YTUs3WjlqRGp4aDhP?=
 =?utf-8?B?dXpYcXRPYUJQSXpIWDMwQ2UrYVp3NHhRTE1zbjVCTjZReEt0Q1hobk5hMHBp?=
 =?utf-8?B?ZnhuYUwvRExxakdtODFwMFBaZnJMMlRHcHZtTHlFc2s1aERCd3BCTklxRDNI?=
 =?utf-8?B?dy9aajBiVk1MVi9rRC9wNFdzQlE2WUxYS2o5U1VKcGJ6NkxOSk1WY0RqR1k0?=
 =?utf-8?B?eG9UNDVzcUlOdFZJQ2F1bE1aekdjRGMyWTVWaW1teGtUQmVDbkluaFQweGpK?=
 =?utf-8?B?M1V2MlZ2RjFVRTN1d3JBR2luZWl5UExmN1p3MEh2S0dEWEJtbndYR1dFaGM2?=
 =?utf-8?B?UzhVeEc5YTRrUFd6N29ZRk5zakdNN0RpK2ZKY21ScURWa3VrRWxXNHEzTExS?=
 =?utf-8?B?L2dNMVVQODVhOGovdG82bDQ2amVDM1lndldHUSthZTdQSXRvTitoRzBFanY2?=
 =?utf-8?B?QkN4djVjMWNQeCtyamVGSm5JaldpZ2dlUC9jRDZNTWlqbDhiakVVVUFHRjFa?=
 =?utf-8?B?TEhwS2xVMUlDMWVoeEpxNm9zbXJCSnJ4YW5wV1k2a2VuQnhteGg5RXQ4a3Iv?=
 =?utf-8?B?dkdCOWZBaHpnZzNpS1F1MGN1c3dxRnVxb2YrSGFoY3ZkOEVKYklaZVFnUW5B?=
 =?utf-8?B?bUFCQS84TGNXa0hKZm1wZTJIRlNJaDlnZFVoMzVhcHkxcnAxd085VHlEOW9m?=
 =?utf-8?B?dXBYS1k5LzlmV1pDdVBMOGFlZndvTmpWV2xUU3hHSGJqa2k1azhyWFlMZGR2?=
 =?utf-8?B?RkdVZ1RzMURmbUlzODlwOFhrMnd5bmFLR0ZtUXd4TWh3SHZNRWhJTDN1WHkx?=
 =?utf-8?B?L2ZhNGVPbHl2aEVmMFBKTGJFMU5KdmFjaFRLYk9TdmlLUk1ZdmpQbTJJaXpY?=
 =?utf-8?B?T1dYaUx6cEF1c0xQeFVqelNWT1VXUlBRa2E4T3RNU3FwUmdQMGJoelhIMkFz?=
 =?utf-8?B?QTZqVjh0OEVTYjlaNDVsMHI1MHpZeERuK29sVWQwa244QWVRblpQZzZFNi9x?=
 =?utf-8?B?UEI5V1FXQjB2dDZPejhmWk01N1VOZCs3TmxGWlZUaS9JVmIxYkVTT0ZLK0tS?=
 =?utf-8?B?RlVXWGNpakZ1YlZQMUVBak0ySGRjTEdEYlBLeXMyRkpQS01VbVNxdHFSb1kr?=
 =?utf-8?B?UDJGUDZaTGRwUndlMWZxQ3JCNXRpSE01K1oxZ3l3MGpiaGpSSUdhM2lRaUQy?=
 =?utf-8?B?L2Q3TjZEWWVteTlIYVNPQm55N2I5ZG0wT0VTVzduQWY0SHNnekM3QXpUMXhn?=
 =?utf-8?B?R1JoWmp5LzRsUWxMaHhMTkUrZWNvNlNkZ3IyV2FWY1B0cXBJZmlCOWxNREZS?=
 =?utf-8?B?aGlQVVNYSnRuaTY3WksyQkxmUmU4QW51MlVrWVZkdWpQYWIxSXZGTWkxYkpr?=
 =?utf-8?B?NTZmR1J6T0V5bEVMeVJ0UnRHYlpDei8rMFlWc2F4UW9FYkFPMkJvbFpoY09r?=
 =?utf-8?B?cC9ROUhtUFFlNHIzaCtmbEVwYU96cDJzejRIRGtzSzRDbzg5VXJZZmlhcXYv?=
 =?utf-8?B?aFNUSXVtN3ZWS0ZUSDE2cEllQTNiaEpkUzdTMHFvZGtCYWpseGx4ekFkRm5O?=
 =?utf-8?B?NVBlRlJGVExZKzQrQzNQWUk3a3kwTFVjNDQvdHhUYS9OME1ndDg3ZnBwK2NC?=
 =?utf-8?B?VXlqdDFLY0tiN01MVnRjQm52ejdDcVl2SjZ3di92aXZYRXE2VEg5MzlrNFhy?=
 =?utf-8?B?LzR6MG9Wb0tWcCsvVGNoZGZtTGVuTGtrWlhxWjl3SDR1RzdDNXdBUTM0UHVJ?=
 =?utf-8?B?dnQwaUF1dFA2SERIMUN6VHFDZTQ5N0psRFU3c0svN2tZTmR6d1d5c1BhRk51?=
 =?utf-8?Q?ImBA8hWyEhkoLDItaZp+aHo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h67zmYB/cgWKurKdWTx88L6m3EROHxcdgZ5Q2IVy1cCAI1/hRe+M2IlLVzsbmqnXs6mIPONpLg9ba1Y5vnoW8NXeH3y4omaNcLGxifcZ4Ho9+nlKXwzASIdrrzgh+UUea3FZT3wpwvwwDtI2nLGHS/laWmX6Hp2afN6QE8n8xiobqTBFcuMhiorVsY7DdsIEIKDP9YqsSoQIiv6syyDWI2jJDuC5MavmIkvhOb/47BB5jqZE7uqiJ4aC2d6im+Ha3i9BcYDYdcWGT3JYBCVLasdXah0qp52/h8t+b95TXC7njtKl0pV/HJKEB3RIG2mGpnYrM1jjnUfnhEcrfIW8cCWISBOjpMPiZLf6AlLOpAOqugIR/dRPeXHKRXeJPelBc7CHdc6GPElKFxzsCnUYZoq297079cn8E3W23ik/cpVqmi5mVHti/tjGP5T1pManQWlPZ6d19xjoqAA1DmJRfYIOOp7Lr+N9E5yFbKwF0l/Wh/vW/v7GngaFozYslgLnSd2q12zbuROhBKex5gDrJAnXdOuG7Hv8VoAub+7bHLGLkcA1D+M1G70n0EKwRY/Brd8U/6GPLr01Y7stReuqY9tLpZFZWX4mfZx2f2RgGsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed88fb1f-a139-4c40-5441-08dc7433058d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 16:29:26.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3X129DE/hP8b85zC7ob7VueXGqfehErGVAawNStvr3qXFubt21VdMh4JBUjUCs7SBFqlH81PukLl/UJvYzKbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_09,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140115
X-Proofpoint-ORIG-GUID: zbazTkFnywZEzXuGJphcYWgwSieFybVJ
X-Proofpoint-GUID: zbazTkFnywZEzXuGJphcYWgwSieFybVJ

On 14/05/2024 16:53, Andrii Nakryiko wrote:
> On Sat, May 11, 2024 at 3:01 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> On Sat, May 11, 2024 at 6:45 AM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>>
>>> On Thu, May 9, 2024 at 11:30 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>>
>>>> On Fri, May 10, 2024 at 7:01 AM Andrii Nakryiko
>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>
>>>>> On Thu, May 9, 2024 at 1:20 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>
>>>>>> On 07/05/2024 17:48, Andrii Nakryiko wrote:
>>>>>>> On Tue, May 7, 2024 at 6:55 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>>
>>>>>>>> The btf_features list can be used for pahole v1.26 and later -
>>>>>>>> it is useful because if a feature is not yet implemented it will
>>>>>>>> not exit with a failure message.  This will allow us to add feature
>>>>>>>> requests to the pahole options without having to check pahole versions
>>>>>>>> in future; if the version of pahole supports the feature it will be
>>>>>>>> added.
>>>>>>>>
>>>>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>>>>> Tested-by: Eduard Zingerman <eddyz87@gmail.com>
>>>>>>>> ---
>>>>>>>>  scripts/Makefile.btf | 15 +++++++++++++--
>>>>>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>>>>>>>> index 82377e470aed..2d6e5ed9081e 100644
>>>>>>>> --- a/scripts/Makefile.btf
>>>>>>>> +++ b/scripts/Makefile.btf
>>>>>>>> @@ -3,6 +3,8 @@
>>>>>>>>  pahole-ver := $(CONFIG_PAHOLE_VERSION)
>>>>>>>>  pahole-flags-y :=
>>>>>>>>
>>>>>>>> +ifeq ($(call test-le, $(pahole-ver), 125),y)
>>>>>>>> +
>>>>>>>>  # pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
>>>>>>>>  ifeq ($(call test-le, $(pahole-ver), 121),y)
>>>>>>>>  pahole-flags-$(call test-ge, $(pahole-ver), 118)       += --skip_encoding_btf_vars
>>>>>>>> @@ -12,8 +14,17 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)     += --btf_gen_floats
>>>>>>>>
>>>>>>>>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       += -j
>>>>>>>>
>>>>>>>> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         += --lang_exclude=rust
>>>>>>>> +ifeq ($(pahole-ver), 125)
>>>>>>>
>>>>>>> it's a bit of a scope creep, but isn't it strange that we don't have
>>>>>>> test-eq and have to work-around that with more verbose constructs?
>>>>>>
>>>>>> Looking at the history, I _think_ the concern that motivated the numeric
>>>>>> comparison constructs was the shell process fork required for numeric
>>>>>> comparisons. In the equality case, ifeq would work for both strings and
>>>>>> numeric values. Adding a test-eq (in a similar form to test-ge) would
>>>>>> require a fallback to shell expansion for older Make without intcmp, and
>>>>>> that would be slower than using ifeq, if less verbose.
>>>>>>
>>>>>>> Let's do a good service to the community and add test-eq (and maybe
>>>>>>> test-ne while at it, don't know, up to Masahiro)?
>>>>>>>
>>>>>>
>>>>>> Sure, I'm happy to do this if kbuild folks agree. I've cc'ed them; I
>>>>>> neglected to do this in the original patch, apologies about that.
>>>>>>
>>>>>
>>>>> Ok, let's see if Masahiro would like this improvement or not. For now
>>>>> this patch gets us into a nicer place where there are legacy parts and
>>>>> a better --btf_features setup completely separate, so I applied the
>>>>> patch as is to bpf-next. If we decide to do test-eq, we can improve
>>>>> this further separately. Thanks!
>>>>
>>>>
>>>> That is a noise change.
>>>> You did not need to modify the line in the first place.
>>>>
>>>
>>> Not sure which specific line you are referring to. But the idea here
>>> is that starting from pahole 1.26 we want to stop to set those
>>> "legacy" arguments (like --skip_encoding_btf_vars, --btf_gen_floats)
>>> and *only* use more usable and forward-compatible --btf_features.
>>>
>>>>
>>>> The previous
>>>>
>>>>   pahole-flags-$(call test-ge, $(pahole-ver), 125)
>>>>
>>>> works as-is.
>>
>>
>> You did not not need to change
>>
>>   pahole-flags-$(call test-ge, $(pahole-ver), 125) += ...
>>
>>
>> to
>>
>>
>>   ifeq ($(pahole-ver), 125)
>>   pahole-flags-y += ...
>>   endif
>>
>>
>>
>> Please note it exists in
>>
>>   ifeq ($(call test-le, $(pahole-ver), 125),y)
>>      ...
>>   else
>>
>>
>>
>>
>>
>> if (pahole_ver <= 125) {
>>       do_something();
>>       if (pahole_ver >= 125)
>>              do_other();
>> }
>>
>>
>>   and
>>
>>
>> if (pahole_ver <= 125) {
>>       do_something();
>>       if (pahole_ver == 125)
>>             do_other();
>> }
>>
>>
>> are equivalent, don't they?
>>
>>
>>
>> The former is more intuitive because pahole 1.25+ supports
>> --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
> 
> The point here is to not specify these "legacy" arguments starting
> from pahole v1.26, and the patch makes it more obvious, IMO.
> 
> But I don't mind adding (test-ge,125) check back, Alan, please send a
> follow up patch.
>

Done, see [1]. Thanks!

Alan

[1]
https://lore.kernel.org/bpf/20240514162716.2448265-1-alan.maguire@oracle.com/

>>
>>
>>
>> I attached a simpler and more correct patch.
> 
> It's not more correct, because this patch didn't break anything. It's
> just as correct.
> 
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> --
>> Best Regards
>> Masahiro Yamada
> 

