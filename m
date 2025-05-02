Return-Path: <bpf+bounces-57194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F31E5AA6C6F
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 10:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBF51BA5A00
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 08:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A322331B;
	Fri,  2 May 2025 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o9V2Ija/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MEpjDGbl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEA1F426C;
	Fri,  2 May 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746173948; cv=fail; b=BM6Wm3dzJ0s6lRReKAFJT7ygXo0I4+2y3kkN8qf7z9zbd0689l/NMeg/MF6MhuP/VivzwwvOjZgfCi43TdPRgONwZMRk+NiTeseFVfLX37MZaUqhL9SfNcjx8twegbgBeQqAj/pqApuvrJ235ranqodJz8iNFcu3jdns0aNnttQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746173948; c=relaxed/simple;
	bh=7934b5GoN5+WlgSCYb2gcF/VPZwhSjT7p5ykNMv+6n8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cUEif3sP1zoxG2A0BNvhwPbEmPKdgSIeyoG2hRNxB4hhcG8i4tN077oY7SHe3jqkNztUklFC6N4xMYHymGD6/rsoKtncC7exFXcGOmCEBKChJF9sdxa0/tTxtb8KTTtvvaj3H88zD/skQwcgPQ5QEHq5BRn0r0LkE/czNQICB5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o9V2Ija/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MEpjDGbl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WCPK015439;
	Fri, 2 May 2025 08:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tHilg9fAnCQGz0qzZoPF8axI4+OykdyOGLFb17gSv1I=; b=
	o9V2Ija/r1plvX1w9+LXhxeAOs0M7B9gfUsYlg1vSHJlB+3YyZGX3stqTMkE9U1Z
	7oMjskUPJlEucJuUh1IV3tUr2HSEdVDYqHk7feUb9HTaue0Xi7YURpFfHry7XSbf
	8zvDAwbuwzAUE2M5ZUFLA2gVhIF29frxNtuWIYSpDp0uQNDQWy/A73H8rf8D44wC
	qak4HXE6X2opBj7DY5x2mX3nGdNCrUxDobDEzMBOzFLcilmHLZ8o+gjqFigX7cK4
	gNUY3B7hxrdJAGfJCRvPo8KueVhdGTjxAWQYbblcy44t2sHS58MFLP6bc/x9osFE
	OnDypcfpU8X2w/U1lsQUdg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukmvaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:19:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5427CpwP013794;
	Fri, 2 May 2025 08:19:03 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010002.outbound.protection.outlook.com [40.93.11.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdhumq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:19:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUKqa8h0UbJfi/81BusasbFOYgBo87aSqnVoodZMxouWiPHurMSeR4wtgSkIrNpaMkwzFE3vHGHiWKBns91Ri1m+3bAVcuUtmLwxmiGfIbmqV0Rou+egMmN/EsimOgXN1p2GmQc50HZYcEAAXSkPWCVm1PvWZq2A0pqA/ZQOpj5S1lh148/U2YPUNNEZN1doM0pxmXHKfe9XnM49RDr1CBZNJYrDwNjuNhAPrYfXCpJJaSslH9Z54XDmLaVBz2Ci1oTxvOyYwnL55oI7LKEiEb47jFqez1E/iDtNLXb4SfVmNoltgZdjP8J0sUBoQ996bB7Mvy8WYoaWs079arq0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHilg9fAnCQGz0qzZoPF8axI4+OykdyOGLFb17gSv1I=;
 b=AsuT4CUddsjJ8RYxi2KseMkVHUbJ1bj1tb1cOp8M3GUAo1QcIBBWdPbDbbkxFOT/yxTEilwSaspoItfURJdOnTL3vWFzoPtsEXcASGmoWYoNql559e3Dkx8WlJ2Hx4avR7HrQn1YgkLbrL9pw784qk5X4qrenGKqoxwPT7NS07lsmOOIxu9+6Fd/Xznm0YYKvUOtvoEPo2nB/ravrl5KjcEuMz59taHJq9gReh5Cy8ibuy/595U+d5D302mrgL9BpUIcDxHKMyfnBcvoL9pV+TqJ21r5BJbiCpqErQif69jJ4GWw5GbrXFqrv/sZdwOdsUgnS01uAX/7oAO5GJLJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHilg9fAnCQGz0qzZoPF8axI4+OykdyOGLFb17gSv1I=;
 b=MEpjDGbld+h15mQp9bD3KbdXChugyFVtBcPyYIH/uAtGLKHQj3uXqhuiknRF0YVLJYMtCLGv53BbWU9PN9Y8g7ikUqd5lywHCaqyJA5JrPRVPJuJRHaBwcua9HwBgV11h9f/uvoVczAXoULdyYIOJw1AxngLuC2gET9qYkvgrPk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7230.namprd10.prod.outlook.com (2603:10b6:208:403::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 08:19:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 08:19:00 +0000
Message-ID: <3b19f6a5-a5f5-4872-b38d-018165b5edd7@oracle.com>
Date: Fri, 2 May 2025 09:18:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: BUG in pahole?: strange error in tests/flexible_arrays.sh
To: Tony Ambardar <tony.ambardar@gmail.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
References: <aBQwRduNwBFciGkq@kodidev-ubuntu>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aBQwRduNwBFciGkq@kodidev-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0010.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: cb034397-4f5d-4e32-f13a-08dd8951fda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alhydVNWeHlEWFFBOU8wOUIwdTBDbVNIV3locjBXenhnYktKbk11OHdWOG9s?=
 =?utf-8?B?bzZqTmx0TThyd3pTNVNjeHY2N25EOTJFT3hlNHVQS3RPbkthdm5vMkJhalky?=
 =?utf-8?B?NEVlNmc2MVV2MkpiV3gxeWFyMHcxdlBReTE0U0VaUDBrZURZQklIbFdLbE5Z?=
 =?utf-8?B?dWJMaTloNTM0YlpOUlk5ZW9nTjNuTFpkZ1d0L295ZUJLcWtPcGJManlrM3lJ?=
 =?utf-8?B?bHF2Ums0TExGN0g4VmI0WkdHREkxdzR0bm44TTVqNVpxTmRmclFvdE94SnZj?=
 =?utf-8?B?QWVPRFpNOXpoSmJmTHEzRHQwbVRJMDhnQXFESFNEUW93bktLOUVzd2pqSStj?=
 =?utf-8?B?NTFWSVpiMlJ2NStvL2x1Z2kraHNubldYZlM4TlB6MENNQitINC9GektlT2pU?=
 =?utf-8?B?MWhVQ1lqa2prOGVUZEgvOXI0eGtJZWNtbnRRNHNKWm5VWTNpWVdFb0RsQ0JY?=
 =?utf-8?B?bmkvWUkzUmJ1Qm9lb3NjUFRCWDUvVGpLdnk3TGlUc3VoazFHZS9LbUVGdHlM?=
 =?utf-8?B?MWtOTy9ialNvV1ZrN2R1UkZ1OG9zeVJsOTlVMVRmOXQ2WXFQcFJFU0hXOWpk?=
 =?utf-8?B?RHJubjh6M01UMGI1VmxYZG04eWRabWV5OE9ENEpOM3djWkRjUnVoRW9aQVZT?=
 =?utf-8?B?cUhDTFplRnIwa3RPam9IQkpnME5mOEZESnNmYXNweDEwT2dmRWpWL3FzdVRX?=
 =?utf-8?B?WGNqZ0xtaVcrRjZzQWpNam1kcm9LakE2WlM3dEJCZGFrR3hkWmJqZitBaE1l?=
 =?utf-8?B?dEp3ZlVoTk9ybFlwekNWaXEzUjdiNmlwRk1lSFpRYVNiWU85QkZZUjZEQlNH?=
 =?utf-8?B?eVdmOWwxd1RYdlcyMnpWcGdFVG1qcGFTQjliRzIwZHlmbW9LQ1pVdmw4NmNL?=
 =?utf-8?B?UlFUMkpGTWlCN0FoM2JuNHJDWjRhaVc0QmNQeHQ5Ny83RDJ4SWRyU3pZWFNB?=
 =?utf-8?B?VTJTM2pMSUpOUFpRNU9CWkxxcEhlcytkK09mZDRQSUZuNzYyTm1FUmNsbE1x?=
 =?utf-8?B?NzJscHpzOHJVYlFBdFhZTHNRVWpVV1E5NHpaak5uY0hZOFkxdTZCQk9SN0Jh?=
 =?utf-8?B?cXc2a1RURmtlYVdXSXdmMWlLZ1ZocTJLamJ1THl1TjRVWkdMejhqTGpWWk5y?=
 =?utf-8?B?RUFmR1NBSWg2QVoxdmlwaS9ZZXp3NDRpWkMwTHBuUWZtdmxHUStVdXpPZVBm?=
 =?utf-8?B?VG5vYWZnNGx1VTRWK1ZzL2dSZ0xleUNRUXpLOUlzUHVybklZOW55UnMrZzIx?=
 =?utf-8?B?MkJHS3AxNFBpQy9OYWY0TzNYeFBLaHgvb3hTczJ3bzhWNDB6dThGNzQ2U29s?=
 =?utf-8?B?b3dGVHY3UVVuR0JCMVhsMDc1QlMxdncvdnpCWWx0ZkpxeWlmb2w5YVhRTkh5?=
 =?utf-8?B?TFp1K1J4SHNobTM5ZWYzcmgrYjlaeUJSVEg4eWZxZUpQRW5mV2ovckdiQ2lO?=
 =?utf-8?B?NVd4cElHR0p1bDdyTlNzSVgvajhjN3NBNk9EeUhoRkpEKzBOK3pKSVVJYTd6?=
 =?utf-8?B?VjBGbTExMWRsVG1PTDJNdmlpVUZlbk5NNTEwTlZJT29zV1lmUkcxeUZZbTMv?=
 =?utf-8?B?TVg3cjhvU3RMazNpLzc2ZVFUTmthWFowT3ZOMzVYMnI2c1RxWjZ4d3ptRmJ6?=
 =?utf-8?B?dkExYk56ZUxHK1NsNThNeEpTdkRWUEJPRlNQR2pXVWswYlBPYk1XZzhJVmVh?=
 =?utf-8?B?eExDMDRYTjEzbnJFa25zMGo4cGpkYTlkQ1lYajdVejJLYTV1NCtuVGxYU0ZJ?=
 =?utf-8?B?Wjlob1d5bGt1bGt6QU9QY1dmS0RPalA0VzRQdlN0a0R0WXdGYlRlQnltS0ND?=
 =?utf-8?B?NDZkNWllYVNpclJ3SWMwR2FaR2ZrVW00K1ZQTFZQZ3Z4WFY5RjlYTm9JQWJI?=
 =?utf-8?B?cC9ueS9JM3AxMGxQMlpBTFYza0tNQWQ1U2QvemxrcHZheFFGRGd3U3UwL1ZD?=
 =?utf-8?Q?w6RHQT65cgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TldoYnBwV05QN1ZmTXFlZVdmZ091dlFsMGtuMC9hLzdEVVJuUTNrZzBmZzg5?=
 =?utf-8?B?RjNPbVlxcmlIZTJxSGtJNWVMRXN1aVRPN2hjVGd5Mi83SC9YZjJQdFNqYTd4?=
 =?utf-8?B?cEFwYXR4OWZISnR5OEJmK1ZKUFlPWVFvbGpGdE9XUVlKTVlveitKSldHVWtq?=
 =?utf-8?B?OHpkaDAzRDdiSjFRNFVZSy9YYWFmSHhwUUpQTDFQZ3M1TExldGhwbGUxQXVU?=
 =?utf-8?B?YmxjMkpjU09nb1dBcHlEeU84RWpOUk5CMUN3QnhucTQ1UkVMdDRKQnd4V3NW?=
 =?utf-8?B?VytkUmFjVDdtUEErOE1leDRFOXZOQUJuYzZVSzRySnhKa2FnT0dqbnplN3NG?=
 =?utf-8?B?c25WMFNnTkR3UVVSaHFMYUdTUmxET1YxZVVIcW8vNm53NnlSbU1VN0FmUm1N?=
 =?utf-8?B?SGhYZm50aWMrL0J3MlRJRXlDQjFMdUxjdUJXa2V3SVM1U3hvb2FFaW84OU5C?=
 =?utf-8?B?a2hlRVR6aVMvWjRwd05KbSt4ZC9TUjd3SzAxb3o5VlF6Y1F6OTRKZktLWjA2?=
 =?utf-8?B?bXJQRWRaQXFHcTNwR3hyQlorTFV3VGZQWk1YVmNiaytINll4VlZWYjhRNVE4?=
 =?utf-8?B?QjZHbE5QYVVQeWxKR1FGWXN6V0lpSGRBU200N0NVOE94VEFJdzRXSktoNXZR?=
 =?utf-8?B?SVBBTDlPUUQ1YmJVVzhmbjdkbUNCUEtVbWU5L3NGSFQzVlR3emU5RUJzZU03?=
 =?utf-8?B?RnRQTGFaUlIwQmgzUjV0N2xHcS9pRU8rbHZ1OGtJN2ZhOHlmOUVqc3NZR2th?=
 =?utf-8?B?OW9jSXJBbjVjL29lQzhadnlkQlVDSEU3QytpZXZtR0UzRWV4NjJ2cDVBRFRh?=
 =?utf-8?B?UUEvekhJL1pkSkRhRmRNY25tVFJRamZGTEt6VmVpRjhDQS9UUDRUK2g4d2l6?=
 =?utf-8?B?aDFRalBJdFRITkpMTVFVbURqWGRPUXF6MXc5MXBRMzN3cWxvVkdBVE5qcUZR?=
 =?utf-8?B?M2g3aEczb29rSTVnalp6S0hmcW05UnhjbDM1anp1K1E5K2dMY1R1UW1BaDlk?=
 =?utf-8?B?QVJpZ3l0dUFJUXBra0RxSzdCQXduTXFQWTNlRVQ1WE0xWDNlU3hWc1daOWNr?=
 =?utf-8?B?dDVIZDlsNzVidEZVbU5XYmk2Y3pSNlRHM1pxb1pjQ2dvekR3K1EzNG9UYjFE?=
 =?utf-8?B?amQ5RkVuQ3RRempWYm9IRWFNWWJQOGlPN0JidHFSVUZyZmhtOTZFWFNNTU1j?=
 =?utf-8?B?dFl1TmJLcXUydmZNWTBnN0pjT2pXTnh0U2tlbXNNYkxPOXBISUVHcTlsRUZF?=
 =?utf-8?B?SGZPOXpibUNCdGdGdGt1bkZ1VnRJSEttT2xRbEFSMnJZZzVjT2dOMTQ1MUFs?=
 =?utf-8?B?dFRzdUJvcG1CRHlBQUxxaGpBY0xNRkJUQlJFNDZNRm1QR0EwbXBOSmQrS2Jz?=
 =?utf-8?B?Um5JWDdUaCt3eW5BdjdCZnl1OVkzQ2ZveUc1VmZnR3YwcEdDdUtJS3J5S2pp?=
 =?utf-8?B?MnhCYWFHeWVwZjFDVFZCcksyL2JPMG84aHdRVkVBV2RLY3ZEOUkrOUFDMHlx?=
 =?utf-8?B?MEE5NTdONU9OUkszbUp2Tk40bkVMbndURHY4NE15QyswZWt5ZEU3ejZQcHZt?=
 =?utf-8?B?aXNrUFhlUmpCOUhxUDhpL3ZiOThLUkNScEo3QTJUOWQwWlhlWnE3TGk0eEs0?=
 =?utf-8?B?R045S0RDeVowbis4d2RQb2pmREFPZHlNMHZEWDduZTBFT0hRamphNjFyL1di?=
 =?utf-8?B?S1dmckRHNnZIc2MySi90M0Zjb2hlUjdOUGEwNzlIZnhsL3VxNnJNRXpZUVFP?=
 =?utf-8?B?NXRhdmxJdWJybGRwL003bHZMajFJS1pzZy8xZnc1K0lhQ3RBNEkybE0yUkNC?=
 =?utf-8?B?WmxrVmp0NWx5NWEwcU5BeUNLS293eGtvMHpLbXJiKzIwaVIvYW9VWlBNa29U?=
 =?utf-8?B?N2RORklEUy9LbFo2aHROMytIRk1COFRSb0YwTUFpaEhjRWFjTEhYTk9vRmJS?=
 =?utf-8?B?RGhFN2ZsYkEzYW1ZRm9FMkxxUVQ0WW1uRzJibjQ2Wk1HUXZmSU9KZ2lvWTlS?=
 =?utf-8?B?d00wRTQvUWZvVUpRYkJWVGxmbmxERUhDZkRvUXNDRS9WcHQ4NG1lRlpxSEto?=
 =?utf-8?B?YW52akI2V0hwcGVoYWVaV0QvR1lUNEVwMXhKT1pMM242WFNIRkdZRFd2WTd0?=
 =?utf-8?B?TkRuUnRNMUFLb2JzTmVXa1d4SGlGNEY4aERndjdzV0ZEalllZ0YvKzIvYXRH?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qkwqgn82PLjjv0ne0gZGwIpu642PUz8naLL/HK7IP3FtUrONjs+tzRMGhSAtyJOA4bMaRX3F+o8QqEWh6JyKuEIgFuN499qgykkzrrdOpI4qKrvWnl1kFkrmVwxnpTUkFdZitfGM5QF+U+mJja9f42xp2CZn40sV0dKqRW68RIx6fw83IB6xFoSRu/P2MTyX7GNOc0Ec4bRlae4gGA9vtbKv92i2bbW+cajsj7/ZIDAYroM8d0YzCYYUdbM175TxvwBS+OCe1xdjFax48TTIBE4gnJgF76NqoRcxdRlXirqC+IwZv0Eyt0YED8/GoQG9hg83Fw+ozrStODMhcNRWJP3LIE66UPyKPkp/dijRBeOTijhA31ik7QQwyhzqBzh9IRkPyZn9e4tBNFJhpeI28tz8kZGg6Dl0n/pb2LkVYQXi5/IDy/bhMPn4IO69y+Z8CsbBM1pbT73Lx43OhdQM6sSIZcvXfN72Pn+kmJwH1Jb0Y6W7hjZBuGuq/jdHCKtTKyIvHT9Gwe3EHjanknKqEwZc9lxErZtW08+O8LuLWUHQLW3h/a8uwrnUzc7eCfekNpS4Hu/u3RD+6ShbftchXomYCiVdbGrOZazL998RFWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb034397-4f5d-4e32-f13a-08dd8951fda7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:19:00.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zav81CRl5XVtX2CAyu1Bdm1am82+xs/ROWfuP7+SpqtjpKH9sFmBzvQl//g6bdtuwPS3xMAhCwkIsQn8SUC5pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505020064
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=68147ff8 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=rYKvOK0H9t3e5z19t88A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xiZVY4BAJAnA4ae3l-iSMHRFNNZh7WX4
X-Proofpoint-ORIG-GUID: xiZVY4BAJAnA4ae3l-iSMHRFNNZh7WX4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2NCBTYWx0ZWRfXyRs0Atq5De3/ zl6ZF4pa5aMVrwwxMwyzhJXb5T6KGxDCWZtuairXWmJgoJwItDA/EO+5oEYJhkK9CGZ92usJHuy P18XRvXtWoappvIsi/RqL0AHk0OqOOlIbxbaYiEApro1ldHBjJdhnAI5lAxlfiaXE5fdc+iNec5
 i5Au/53QMgnFtiNp/aFYStKpXw+4KRsIA0fvkJi2lvfzAChEVWuxGSxYhbcSERJtJL4ELhckr2i VTFJcNWz5h/K4OMQXNyuJeKZmcsyOS2DL3IwwchV6MpbGUGtd0kpmomsEKN27Xja083BxgqHz0c uUdDjtbeKELAK46HrnkiWOU7MelOfpJQjF5W0BWtHPxDgakWZHL5lluCqz9zMkY45Z/vBPITwJ3
 5Gjd9m/KNGfQAAmsN7g3N1xiegyTjiuZ4m364nt+/BHm1/sniiRIOHq35UMw5xDoSHyDS6AE

On 02/05/2025 03:39, Tony Ambardar wrote:
> Hello all,
> 
> I ran into the following running the latest pahole tests:
> 
>   $ vmlinux=~/linux/vmlinux ./tests/tests
>     1: Validation of BTF encoding of functions; this may take some time: Ok
>     2: Default BTF on a system without BTF: Ok
>     3: Flexible arrays accounting: pahole: type 'bpf_empty_prog_array' not found
>   pahole: type 'kstatmount' not found
>   pahole: type 'crypto_lskcipher' not found
>   pahole: type 'crypto_sig' not found
>   pahole: type 'hash_ctx' not found
>   pahole: type 'scsi_stream_status_header' not found
>   pahole: type 'virtnet_info' not found
>   pahole: type 'geneve_dev' not found
>   pahole: type 'geneve_config' not found
>   pahole: type 'lirc_fh' not found
>   pahole: type 'scmi_registered_events_desc' not found
>   pahole: type 'events_queue' not found
>   pahole: type 'hid_debug_list' not found
>   pahole: type 'flow_offload_action' not found
>   pahole: type 'nft_rule_dp_last' not found
>   pahole: type 'nft_rhash_elem' not found
>   pahole: type 'nft_hash_elem' not found
>   pahole: type 'nft_bitmap_elem' not found
>   pahole: type 'nft_rbtree_elem' not found
>   pahole: type 'nft_pipapo_elem' not found
>   pahole: type 'xt_standard_target' not found
>   pahole: type 'xt_error_target' not found
>   pahole: type 'ipt_standard' not found
>   pahole: type 'ipt_error' not found
>   pahole: type 'ip6t_standard' not found
>   pahole: type 'ip6t_error' not found
> 
> This is simple to reproduce (e.g. code in flexible_arrays.sh):
> 
>   $ pahole kstatmount ~/linux/vmlinux
>   pahole: type 'kstatmount' not found
> 
> But despite the above:
> 
>   $ bpftool btf dump file ~/linux/vmlinux format raw|grep kstatmount
>   [13145] STRUCT 'kstatmount' size=624 vlen=8
> 
> And:
>   
>   $ pahole -C kstatmount ~/linux/vmlinux
>   struct kstatmount {
>           struct statmount *         buf;                  /*     0     4 */
>   ...
>   };
> 
> Has this been seen before? Am I missing something? Any insight folks have
> would be appreciated.
> 
> The same behaviour is also seen with '.tmp_vmlinux1.btf.o', which I attach.
> 
> Many thanks,
> Tony Ambardar

hi Tony, I've seen this too (with a slightly different cast of
characters); I keep meaning to look into it but haven't had a chance yet
so thanks for doing some investigation! Seems like it is a bug in type
display rather than in BTF generation at least..

Alan

