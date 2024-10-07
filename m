Return-Path: <bpf+bounces-41148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB179934D6
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 19:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A691C23C5D
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCA61DD548;
	Mon,  7 Oct 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j4BbHiTp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kUrMmHcW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2D18BBB2;
	Mon,  7 Oct 2024 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321856; cv=fail; b=EjFhSPvCvg7yRUA1hbDoMeuEcbUQrfRoCI2r5MNvSc1/cpXm+pPyltLyVjvPVMDSygFt3YGwBXtp9UrB2QjRFwy/EMmBCkF1RrRItCY8qNEtVpDjoEHNPfpw97uBreCd5QXaemFJN1pFvJogoZi01O/dcjfrL+Ffj5b4NQ96y2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321856; c=relaxed/simple;
	bh=+HTP1mUrA+gDLWeD9nr0ltsDnbaE1HJuvaFl6Sp06pY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=JOJkwNbtBlgjM/Bq5rwRB2wOg1ENDm6lJrKlxfGElkTRd5YlbtQhk+QZzglbHvrk1MIFwKNaUwxQ2kCawIQBM3tJNXEKS0B2JxKm8aN/QLe4G64vcrif4HWbWhRTO7u1ImQ8iYQ8wSenUv/Xfh1e4d5sL+p7wH9UgJ0ngqc8wFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j4BbHiTp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kUrMmHcW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMeOf030896;
	Mon, 7 Oct 2024 17:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5jYlsizjqtRbeDwn+aiT7iSX+76jctzOkBttSmQ4Hhs=; b=
	j4BbHiTp7SHSMI2LeDz/j+hh4R1OUg2gGljNThYRXDERtRaAV/IdUGH3nz/CLAWL
	0VNV3bfdHOvFbd+ivSAR3jCQXd98z5zhAEz8mWa5sC4DpfypUkirX3z+N4U6nHPX
	VlYusLyyyJMHrUlovKFS+hBwDKulDpLIQa/LRK6kfnVZOmFXqqtqvGsEEmnS9AKz
	WgCszxa9KVR+Mhf0YiB+ppGt5DkXBNdkKUgzgIR20nxU1cLrULBvkcFf/yc5Z7EV
	wvWo5QxNALiIwoMvURjq+/ewZA5MRxORYr1KLoRzPAoVQVZIZWuK5y65fXn8ATnk
	GbegakhvhgOemNBygtlYiA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063kxs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:24:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497G0YcO012467;
	Mon, 7 Oct 2024 17:24:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw63c0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:24:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVyUOFpj5vwwlssxvIrTIZZPot85TaL8+qi48vGl7L+Mf/3sce40m4C+i+60fYj25XtcgO+8JKWM0U4XQsihuXcF+dtPiuEjozfY1KKiSJNXmGTy79GdGW98egY3vWI59XyN6hXdjOd6jaiZxeZepmqomjjBgMr/r/MH6r35GZ+50PIeAY3nBv7wCpuKAtQs/le3UBDlX+/AYwRXEkWe/D1P08iB8h+tLElJ43UK5k8cu/SwWHuBeYj+UfeAJVtcF3TjudgelYUyT0+IsmNDKh3daICu8S796NBzADlGkger5rdZsHmZKzvyjUO/+wjye6x/BCXrRqnbI5s6i0Moug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jYlsizjqtRbeDwn+aiT7iSX+76jctzOkBttSmQ4Hhs=;
 b=JUKsMZA8Yz15kpq8utikyHBmzraqi68sWAliD+X6KRTWKf/44jRU9qev+sUNwXm0FPJXKt7QOOYJQQkZcueF2YHLDrCOElvcIay1ReUgCGme5/FsEkD2ufVQn3Uo9EzPT+Oq+KpDxHvGPP4R9uo6tWUnRZ+7QS5fnEbFn77qqAgSfEAgw7sxkv/IpBkC/EXyQacEgTqGNQ56dt+qK1TpY1BQ02dN+WoBt0+TSRmcgKScZeu/ELM2l8RrtxPykrs0YdpNqhxLCdTrLagNzBXjhKeflDk9AsqJpDJNy3EhzybjZxkqAAdvwR5hCPQWSt42z4kQ5lxNIaDdTUTmvq7QOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jYlsizjqtRbeDwn+aiT7iSX+76jctzOkBttSmQ4Hhs=;
 b=kUrMmHcWQaVr8/yPYrQxuFadA0Nbp+KyNPgYL+x49tTEXQygsSYHYi8YkCRNnOLPWoCIGJMLMzy0TFQLvZ4ElfVE50wuN9PStGvf6A976dzHU+j0zir2+PO1kkQ3VzpCSfBzZrMyPVtYo240oXBQh0X7RXs5PRsBX4A8oWz61OA=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 17:24:04 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 17:24:04 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves v4 0/4] Emit global variables in BTF
In-Reply-To: <CAEf4Bza3cnyef1VAcGkmP02dBMU_fp=52aS9LknOWhN855-PPQ@mail.gmail.com>
References: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
 <ZwBXA6VCcyF-0aPb@x1>
 <CAEf4Bza3cnyef1VAcGkmP02dBMU_fp=52aS9LknOWhN855-PPQ@mail.gmail.com>
Date: Mon, 07 Oct 2024 10:24:01 -0700
Message-ID: <87o73vltce.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0263.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::28) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|BN0PR10MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: b55669e0-c415-4ebb-d338-08dce6f4d74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUs2R20yM0pEeEZjbHdPNDVjZlJmUWkrQWIyazh0NjVFSWQ2cXF4Q1pITUY3?=
 =?utf-8?B?TDhPMVpaaEpnR2dsaHAzMUErRHpnbGNLNnhRTXMrV1ErZTZSQVlRaUhRRG5M?=
 =?utf-8?B?NHlaYXBhUVIzQmJFWk5mQ2RYT2g2TjF2QkxqdjJQL0lBcGxpYjhKdEFNRlZt?=
 =?utf-8?B?ZTYwSFlhVFpkYkhjcmRpQTZSQ2V4dUh6dUd0d043NjViRmxnVGJwOGROeERF?=
 =?utf-8?B?Y2UrQlB6aE9XTTVLM3crSlp2dzIrNFRYMy82YUN2NVIycno3eGhjNXpZNmpV?=
 =?utf-8?B?YVNVQ0JrbmdDTmVlaGNidDhUYVZmRjRSdXV3K3gxMTFud3pUZmdMK2tqZ01N?=
 =?utf-8?B?VnJSWVJFRjV1UFQvYXZ4K1J2WlpwaGxoZXlWVnJMelcyQU91MnRVb2ovNHNk?=
 =?utf-8?B?TDVvUXVuSStvZG54MjcralpuT3ljZTQ0dmRqUTZHZDZnM25NbWNjejQ2UU0x?=
 =?utf-8?B?R1o1NjJRVXpKQmJOK0hUTGltWERGelhMRCs1cWh4c1VoK3IvRUM3YXpQUVVu?=
 =?utf-8?B?UGJYYjNFYmJmbllhSm9rZ2ZWOUxGRzY3RFp5S3lsT2huQmpMZjd3SE5lVmpZ?=
 =?utf-8?B?a3BvemhGdEd5bjY3NDNuTW96STBPcVNuWTlReDVzMno1dEpYejhNWUUxM3p5?=
 =?utf-8?B?M0JYL05CM2kyR3VCS2JBZ244bnkrcWVCNnVvTks0S24xOFRBOXNSekJ3TUVv?=
 =?utf-8?B?cTdjNzhBNWFSRUU3Y0lpQWdKV3dZMlU2VDZEdkljaVBNZm4vczVoNTROdjBj?=
 =?utf-8?B?VzFoQ1BOOTQ5TzNBMklib3hFRm1QdWhPbkNTSnJVM2tFV1Y5L1hDM0xyYTdW?=
 =?utf-8?B?ZytpUG1FcDV4VWN1c05MR21OSFpPL2NYNjI2MkorQ1NZM0FYcWV3aE9HTEhj?=
 =?utf-8?B?Y2JLZUt6QlNnMGlHN0txOHljcHpGUFRQbHh6UWJic2Z0a3JiZytqU09QVG10?=
 =?utf-8?B?SE91L3FzOS9KbEFCVG5rMUNZUUFZQzlnRmlxUStacTdXUHdlMzNDUzBacWxM?=
 =?utf-8?B?U1lQNXN4bmNBaGxNeTVVaVBRY2p3aUJyM1BHUWd0QlltNnZtcFQ1YnVzY09s?=
 =?utf-8?B?N1ROMUhnZnVpTmV0M1BlUTFLT3FtbXZWSU0zSisxb3lMRUlSNk1QK3F5NlZU?=
 =?utf-8?B?WFFJMXQ3bmNhREZvMy93eVVMSzFCbVJDRzlsNTk2eFVCWkw3YVRNUXMvTXoz?=
 =?utf-8?B?ZlErQVVCUmROd2pFaEhqZGg5TUN1YmdLUmNTcFRPT2hwQTRYRGZBTTRvcEZy?=
 =?utf-8?B?bjh3TlVpclNVMXJqYjA5SGpHdXN3L0MzOU1GYmRFUUhZVi9jMUR1bGRiNHgv?=
 =?utf-8?B?WU9kTVRBUU1nSlhHNXl1NnpLQzBlQUJuRitrcDVwMGxFSURyRUJRM0xwSi9E?=
 =?utf-8?B?cWwwTnkyeFdJK3QrSjZhbDlBdGZOd1p1NFhacGFOUnM2dW0xNUd1SnhpdkRj?=
 =?utf-8?B?bnNtc1BQaldkbU8vbFc5cnpScGt5TEpYa2lheVVJZjVJQ3ptYW94WXhncW1p?=
 =?utf-8?B?aFc1THVRdE4xa0k0QWlBZWdKckhUYUVnK09aUWs1WjRwLzF1R0VsbjZ5d01G?=
 =?utf-8?B?WHZhZzV6ZWhhcXZSeFB4UUI0d1UzOTF5YjhQTmZGSjNQV0YxZ0c3WVE5eWx1?=
 =?utf-8?Q?O2i7jolkxmQzlCT5qb/E4E++jGBh8yoxdhVOnrs2Go2s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWFIVnI0Wmx1dXR1anFIcE1UUHQ3cUt5bGxsOFV0cXhoTEduMVp6UlU4Q3Mz?=
 =?utf-8?B?VGNFYXBoYVlBZTI3RHVXQXFZR281d3MweVVQVHVzaVRwSS95WDBiUWZsTm9F?=
 =?utf-8?B?T0hxdWgwMkU3a1ZUQStPRXoxWDNlL05WbEs5Mk1qbDVnL1RNVjQ1MzVBS1pW?=
 =?utf-8?B?SzBsYkQ5Wk5IN1l0c1locW9LY3huWEU0QzJqQTY2bGI4cGJIL3lNbVJwYW1B?=
 =?utf-8?B?TjFncUFqd3JaOTlWVFZJMTBwSG04ZVJQNk1nMlhCeDUrUWZCcWMzYnFsdWhs?=
 =?utf-8?B?Si9MdmVHT1RKa0ZxbWpoNExWMndsYUV6TXhXcFdnSy9ZR0lHS3dMdG9zdXhI?=
 =?utf-8?B?ZzZJa2pHcldPdjdNRkRMRXE1bWZoK1B2SHFSdlJZU1Mwb1pZZ2YycHNRVXpU?=
 =?utf-8?B?Y3k5ck9RMnJoN2ZRY0FMMnhYTXBYSDJid05PS2xONEsxY2swbFpQb3lwMUlZ?=
 =?utf-8?B?SnJ0WnVkOXpDalpoQ3lOd3hVNXdNL2lZU29EM2pLK3BHSjJWTWgrVEFpS1c1?=
 =?utf-8?B?V20rbmJyZkV1TmdxWEhtSm1QQ28zK0tVMjRicTY5REMzZGxraCtZM09JUXFL?=
 =?utf-8?B?ei9SWjZkV24vZDlZb09Tb1NzN1NPZWlkUTkvS0FyYngrRlhRVlkzUGhkSWNo?=
 =?utf-8?B?eFdiYXNwOG10U0lEQ2NWZEdtTWsrZTJjbnNSd1RHM3BSZFNOcWk3MnVSMHM1?=
 =?utf-8?B?YjI2UVQwSXBZQnhxSU5JTm5qdmgxZG0zL2oxK2RlNXdEWTZzRjJWVjBDWGZi?=
 =?utf-8?B?d1lHUWNZdVFsZGw0cEVqWVZPVk16TlordXJUM2RtajhwTnliay9uQjBpa1Z5?=
 =?utf-8?B?MXRxMFc3T0liZ0lSYzByZjhWWVRuLzY0SFVidk84Q0tEcFZYZkJEWmV0R0lT?=
 =?utf-8?B?NzhBR0IyTjRDNVFxUkFnK1JYREp0V2ZpZ2NnNW1ZTWNmbE5sbTZkL3g1bTN3?=
 =?utf-8?B?SkNOYy9lT3M5VjhiVHd3Y3pWaHpyd2hSdk1qTVhndDByUGg3RjhSekpzaWk2?=
 =?utf-8?B?Wng1a0V6eDJOTHdGci9QaVA5TXZqTlZuZysvVzJIb2xHMjFjOGRDMHpFU3l3?=
 =?utf-8?B?SnBEVjY2TVJieUlKSUx6TG91MnAyVGk5SytKbWFsc0R1K1A4bGN3YkpmMHcr?=
 =?utf-8?B?TXdTazBXOUVhMUNDL0luQytXZnBhc0xzYnBpSEc1Z29mQnlWY25jM2hOMUF3?=
 =?utf-8?B?NHR5dWlLUk42Zis4N0wwMUpWbmdNejdURll3dWErVzQ4NkxoV0dqdzc3aGtk?=
 =?utf-8?B?VStnMzNJbzQxMEFRbjltak95NmFyK0JSSzZudGE0UUVrblpYdGxRamJWTEpM?=
 =?utf-8?B?a0NVcC9ySWJXOU9DTnRra2UxQ0JYaEltL01TNFo2YWluYi8xOWgvZnBUbkw4?=
 =?utf-8?B?cXVGVmxkc2oyQmhuTUY1V2xNKzNBTGZyVnNpRndHNmNBVFZUU2E4RC9EN2Zh?=
 =?utf-8?B?RU5uMlZXejdWcFFJNEtuaUNoU1JRb2tjZkh4VEhhSEVPYlVlYjlTT1pKMmNQ?=
 =?utf-8?B?VHBlUlZtNG4wUFRSeWtQM1M2cUFUdnNzWGpSbkl5aDdVUEQwZVpvdUEzV3ll?=
 =?utf-8?B?aEFoUFlLajhPRm5PRXgxMW9JcmZNMFNkYUludktQQ3R5MzdFVGNZY1pOT0dN?=
 =?utf-8?B?aW9DVzlKR2ViSjhSQWJMZ2ZrUGpJWGU4L2tTazU3dkxxVHhQWW9qaHBWSXhi?=
 =?utf-8?B?WUJjaVF4OVlkMXZPQmI0d25lL2NmbjlMd1B0YXdHdVZSYzBSNE53aEY1RHM5?=
 =?utf-8?B?bVV6SWZiRC9ld3BpcGFGSm0rNzhwcE8xUXVBZmNKUFFtWTdJQXM5VmlxRGdv?=
 =?utf-8?B?bitGL3ZTWkQ4V08rNHBmZUk2VUVVdmJEQVNYZEZ5VUE3OXl6QXZKNzc2eHhM?=
 =?utf-8?B?Z1Jid0xWaG5xOU8xZVFUaWlMcVZLTUNBU2NjUVRMei8xdEVKbCtaRzZKcEor?=
 =?utf-8?B?N0FzYzJYMEZIUkh5ZStBMFpGMDNxQlJFSGptTDNkUFRUNm9Xc0YvMFZ0VERt?=
 =?utf-8?B?dG02ZURTOFhGRk9aSHdSSjgwTkVyVmJKUWF4bm4ya0dHSENab1JZK3FNYTFx?=
 =?utf-8?B?TmM1cE1GUUFlMUE2dks1cTd0UTNpUVE2dzY3ejdGZlBCTC9LUkR5UHBKbXFU?=
 =?utf-8?B?OG1MUDFzS3d3c2ltdTdrMWhGclcvQUcrZnhBNjhRSitGOTJjdGdyZFFpZU41?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1NCiJ2zVIzUvSY+elwZ6TXqJ92aJKOB89K4KFQ8Nc13fMZ9dZzF9uWl8A46Dkw7Q1yWxbVACd2aN5mXcpcLSjWJSUEtxjc4fHtewl/3aaUwkO3MILxpa+FFv7sac6F377ounMdY+QttNfI4xh4zoWT3fHSes8emwYWeJCMWzi69oAr98EWUrJipGCNyJkBl9SK09OAA/0hOZRB/jiLV110QIYfJW17TwvoqacXkKXU97tPVgUbNun/p92tFy839NTtCsakbCG7fd/fpNOV7KWJzOK17D9LNvnhci3Ix0CX+HkzK+OIKZvrBDw0umuG1BQ4kE9J3T9v+6VqaGG/I71fOoFoddF1PDnNCNTqmrXIivOpxYQxy1ofSN6nnCTo3CTC39wd6ed+foZcJ+6uRJvU6Ox8gqiwGmcfKbQG10YNFvmTCW66c7OwbCu7wxv3g3Z3GDS6AE477LQYw32m6neT4NN4s9a+8Tkgd9F0oiasmbXBZoB91qya4cuigxuT6xLDCRe3CkIau2S1XuSRmrzEuPMW8OSDeipCs6rhgESDWqfB8fhUgaKPL33c2TFzWx7OgV8ihLWu8ba3WoiB6Waxavr0TV7f9RNAnl7ULw5QA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55669e0-c415-4ebb-d338-08dce6f4d74d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 17:24:04.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLNFSrO92jFNVQdHu2Ur+6Z9nARYRkffkcIx1K7mtymlP2MXbHihuX7agSpB7zgFEzxTTy6OqMfypHW0VG/RXXdMYU8DiCUfSVnYGCjJ3Qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_10,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070121
X-Proofpoint-ORIG-GUID: 4_1M9GH0RUWmAnzvX3ziVjFTVrDPZMGB
X-Proofpoint-GUID: 4_1M9GH0RUWmAnzvX3ziVjFTVrDPZMGB

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> On Fri, Oct 4, 2024 at 2:21=E2=80=AFPM Arnaldo Carvalho de Melo <acme@ker=
nel.org> wrote:
>>
>> On Fri, Oct 04, 2024 at 10:26:24AM -0700, Stephen Brennan wrote:
>> > Hi all,
>> >
>> > This is v4 of the series which adds global variables to pahole's gener=
ated BTF.
>> >
>> > Since v3:
>> >
>> > 1. Gathered Alan's Reviewed-by + Tested-by, and Jiri's Acked-by.
>> > 2. Consistently start shndx loops at 1, and use size_t.
>> > 3. Since patch 1 of v3 was already applied, I dropped it out of this s=
eries.
>> >
>> > v3: https://lore.kernel.org/dwarves/20241002235253.487251-1-stephen.s.=
brennan@oracle.com/
>> > v2: https://lore.kernel.org/dwarves/20240920081903.13473-1-stephen.s.b=
rennan@oracle.com/
>> > v1: https://lore.kernel.org/dwarves/20240912190827.230176-1-stephen.s.=
brennan@oracle.com/
>> >
>> > Thanks everyone for your review, tests, and consideration!
>>
>> Looks ok, I run the existing regression tests:
>>
>> acme@x1:~/git/pahole$ tests/tests
>>   1: Validation of BTF encoding of functions; this may take some time: O=
k
>>   2: Pretty printing of files using DWARF type information: Ok
>>   3: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
>> /home/acme/git/pahole
>> acme@x1:~/git/pahole$
>>
>> And now I'm building a kernel with clang + Thin LTO + Rust enabled in
>> the kernel to test other fixes I have merged and doing that with your
>> patch series.
>>
>> Its all in the next branch and will move to master later today or
>> tomorrow when I finish the clang+LTO+Rust tests.
>
> pahole-staging testing in libbpf CI started failing recently, can you
> please double-check and see if this was caused by these changes? They
> seem to be related to encoding BTF for per-CPU global variables, so
> might be relevant ([0] for full run logs)
>
>   #33      btf_dump:FAIL
>   libbpf: extern (var ksym) 'bpf_prog_active': not found in kernel BTF
>   libbpf: failed to load object 'kfunc_call_test_subprog'
>   libbpf: failed to load BPF skeleton 'kfunc_call_test_subprog': -22
>   test_subprog:FAIL:skel unexpected error: -22
>   #126/17  kfunc_call/subprog:FAIL
>   test_subprog_lskel:FAIL:skel unexpected error: -2
>   #126/18  kfunc_call/subprog_lskel:FAIL
>   #126     kfunc_call:FAIL
>   test_ksyms_module_lskel:FAIL:test_ksyms_module_lskel__open_and_load
> unexpected error: -2
>   #135/1   ksyms_module/lskel:FAIL
>   libbpf: extern (var ksym) 'bpf_testmod_ksym_percpu': not found in kerne=
l BTF
>   libbpf: failed to load object 'test_ksyms_module'
>   libbpf: failed to load BPF skeleton 'test_ksyms_module': -22
>   test_ksyms_module_libbpf:FAIL:test_ksyms_module__open unexpected error:=
 -22
>   #135/2   ksyms_module/libbpf:FAIL
>
>
>   [0] https://github.com/libbpf/libbpf/actions/runs/11204199648/job/31142=
297399#step:4:12480

Hi Andrii,

Thanks for the report.

The error: "'bpf_prog_active' not found in kernel BTF" sounds like it's
related to a bug that was present in v4 of this patch series:

https://lore.kernel.org/dwarves/ZwPob57HKYbfNpOH@x1/T/#t

Basically due to poor testing of a small refactor on my part, pahole
failed to emit almost all of the variables for BTF, so it would very
likely cause this error. And I think this broken commit may have been
hanging around in the git repository for the weekend, maybe Arnaldo can
confirm whether or not it was fixed up.

I cannot see the git SHA for the pahole branch which was used in this CI
run, so I can't say for sure. But I do see that the "tmp.master" branch
is now fixed up, so a re-run would verify whether this is the root
cause.

Thanks,
Stephen

