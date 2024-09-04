Return-Path: <bpf+bounces-38869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AFA96B3C5
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 10:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4439BB26E57
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6AF16F8E7;
	Wed,  4 Sep 2024 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="agubaa51";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SIYL1h/Y"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B11474A2
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436866; cv=fail; b=KZyW+PrLD3P9D9NxwU0ZGcwuKnfocSRPunBY2utpWHKY7kk0I3YbOo1SyzlcztRLCwkKTlfzAOkuUReTkNcM6QEqub3rQc93BSQWw5eYxcWb6tC+p/YEJ5Tw0FxWoXqFHpz+kLodO5hTUL15clo8rXgQKpgIHxn0h8HaatW5DoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436866; c=relaxed/simple;
	bh=KXQeGzeU8zAriKtbbMaVZ2Ah95CRd9oG0MZPtLlPgdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=aGvMsCFXl3ZknFx4ne+YO0BDYieCP1AfTeThMOrHXK6ubpnTrtbWvQcTWSUS/LLwEmvnK/5iuw7wDpBW2yZhloPjR3EpTV+2IfM91S6mssHGPlx6rTvKqSgfUpnAeEM3TdHKhGTWMSMfLtnZIFDK/fWS1SvrLxmVVFb00tp15mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=agubaa51; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SIYL1h/Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4841Mvim023804;
	Wed, 4 Sep 2024 08:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=KXQeGzeU8zAriKtbbMaVZ2Ah95CRd9oG0MZPtLlPgdY=; b=
	agubaa51Qmf6MHVexYQe65OhjyYbfHVeGmCBUpS17mP3qw2mC3xXY0S3DwJX1C/X
	VekXzokinLLRZnICPNCVmxKUhGykjo8cjE/T16twORc1MYvTNOkdnIW8UKaGsYDz
	vE70NsWXYeL6IJ7Vo29D17gBsc23U05azk/wHD14AXQXs0RXrcGVYOBx+SaTi93U
	4DeEW1+DLU5/88oQC8kvOb8lyJOuxJzWMWsdDQWAFryTHWebpwIKlw012X5RuUoM
	B0Qa2cXti+eS5QDJQ86mAn3I00tiIRpMIleYzA4a3poI9EoUK/NJOAxBbVGPJm7f
	i29Hpo2ZzKv8SRs9n5N4dA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvsaas4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 08:00:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4846Ellq032683;
	Wed, 4 Sep 2024 08:00:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsma0dvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 08:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTGp7nHspND1XyEO/LM5mJcwOkGSFR23ywbbuk6QCEi3oiJHuwUKqA1yf0pPmIgr6L7dhjRL0nu7n5vXk/1wNVw2mPrfJBinBTjnf0ky6LIE3JBmRaQzZb2LCIEnw93DxthWCrqp+V3h1lEV2RJwVhic1WkrsEJy+rc5UlCu5RnLTrH+NhRjOICuq/G5omqV5P5IEAzOHuvdseYYXKyzMy5ouSGJYyVQZmiVr3IG4aPGnBXvZlbgUBn1kftRQ6hSSL22QQNextyNoKSH28m8DUoG90jw1OuQDl9f5V2qEe20VkVZKPMSp9xEmIMhPEAnz3zFKxdhafj1vNqhFcfAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXQeGzeU8zAriKtbbMaVZ2Ah95CRd9oG0MZPtLlPgdY=;
 b=WUHA79emrubFK3dBS0vDUePd1PaOAdvrKL1FcVVynupP40priES2PYhe+cOlTlfBnlCl/7csAUsYKoKjRPvyjpSGefJhbdOzd/pZHeW3a5W/uPMUHCmU5RGFe7aeyxjugn9GYTupx69f7zzatx/ZAyVv49QPvZl2D4axSx2Ij3PXQYBgSY/9kdPz0uC0Z0o0HQFwqangHHMA8+pczohX1rANEOAoO0V1vEStg8gMzOcTKE0KHfs2DIJxHxsdsCVpxNYGwRbraeWeUaM9S1149HQWaRJWrS1grUWOI9baXeX1OSPf6IrkO0YUeSvsTcTn69b9acbxETgqeHEG0NxnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXQeGzeU8zAriKtbbMaVZ2Ah95CRd9oG0MZPtLlPgdY=;
 b=SIYL1h/YB0mV35g/Oqs9Z1P89n1EjEIRnAbqx7oDKngGm7QaFbUSdDeoyxBl4DnqaJ76NpA31UELe6qIIIuQPL3QQolyIWifxSi6U6ivJD8foHb7iDANlxzon0NtqT8xjWbT/67DEzrIcLkrURIARt2LeUTko1daFxLU+aQKrsU=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by CY5PR10MB5913.namprd10.prod.outlook.com (2603:10b6:930:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 08:00:30 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:00:30 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: Change default cpu version from v1 to v3 in llvm20
In-Reply-To: <504ced9b-b938-4cca-b108-28775404faa4@linux.dev> (Yonghong Song's
	message of "Tue, 3 Sep 2024 16:06:12 -0700")
References: <ac144cc8-db10-47ea-b364-c9ebf2fe69d3@linux.dev>
	<fc2f30b5-c51b-3e2d-4282-2b22fb998285@iogearbox.net>
	<c39622e0-a88c-4bb5-8ae4-83e138b3e2a2@linux.dev>
	<90a00496-bcf9-358c-3b9e-e7a861728733@iogearbox.net>
	<504ced9b-b938-4cca-b108-28775404faa4@linux.dev>
Date: Wed, 04 Sep 2024 10:00:27 +0200
Message-ID: <875xrb97c4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|CY5PR10MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bcf1da-4711-405b-f2cd-08dcccb7a4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEozSmNybFRGeGg1dmZMNXlUNjlaOUFVMzBTSHhrbFErK2tYU1VSTDZZSW1a?=
 =?utf-8?B?by9MZ3BMY1lRRytOelJsSENpbm5tZlZFb1ZveGp3NUZpeTk2Y3FaYThVK1p4?=
 =?utf-8?B?MmtCMTZLMUNBckNHekg3c0c0MWNBeWVjaG9kWW9uczUzSHVnZ2dzYXJlb0dV?=
 =?utf-8?B?VHdZZjF0c0hlZm0yTi9JekYvRXBrdkc3WW83RithaWdUQmIwQkVzU3BONmF3?=
 =?utf-8?B?WWh5YW9ib1UxU0liVHlCZXMydHB6cWFIWDhNVmtmUWhoU0Q5OFk4LzIwM2pV?=
 =?utf-8?B?Nk85S0Jlbm13RWlEOURRTlhEOXoyMlVNejVlQk03ZmRRVDdFK2NZbXdhUXQv?=
 =?utf-8?B?dGk1WE0wam5iaFJLNzNkQ0M5QzZseC9pNzZvOXlKL3Q4ajVQMTBPTEF2eUUv?=
 =?utf-8?B?RVFVejJ6Ujc0cExhMUhJSGRxK1dxamxDV3F6Q2thWnRrcEFydG5JZ1ZEMUlP?=
 =?utf-8?B?dkJkSnM5bXlHM2Z5SjhvRS9pb25hYjE5U1VEOU1lQURDU0w3NGYxNnBvZUlV?=
 =?utf-8?B?bmZoODJYUThVMmRUc3ZMOTFwMVhpZ0t3enN4bStObVdDWUhuWk9qd28rUDZY?=
 =?utf-8?B?Q0IvblIrZFNlVnM3eWJ5R1huc2llVEpDZE5lbENpb3lPeTQrQzlXZnVUUWNp?=
 =?utf-8?B?RHlMNlZYdE1rMXRCYTFzdDRRd055L1Rac25yaTczVWNVUzk1NHVQZTFLZ25Z?=
 =?utf-8?B?aWR3Sy9GTVN2SCtIUzh3dDNrUmoxa3d0MTBsTEZpWkZ1U29HdXVlWDE1SHNj?=
 =?utf-8?B?d2hsazJwSk44QkM3blluaVJKVC9vNyt2bnZ0YzZnZndQWXNYbndmd28xV3VK?=
 =?utf-8?B?VU1KZXBOOUFZc3VnODliQUFkRnF2OG5JVGtJeTZFY2lSNHZ0U2syZUFXVzNM?=
 =?utf-8?B?OHVkV0p1QldXZUIxQWZiZGczZlZzci9CeUR3RmRJU1ZqM1RrS081bVR0WHJT?=
 =?utf-8?B?RERYY0tKU2RGaDRUNVIrMkhld3BvK1RyKzU4akxrR1A5V0wzcXVjS3J6Uzhn?=
 =?utf-8?B?SG1XWGxkeXdWVzdxeHpTMHV5djFCd2VyQVd5OUtpeHNIelN1dUdYN3I3d0xy?=
 =?utf-8?B?NDA0MEZiUlJwNUVKOEJEZ1htN2lEa3l4VkhYSEQwTEgveXhRL2tldHlyOTFi?=
 =?utf-8?B?SXFQemtCRFFtelErZERNRlMraVIyeEEwcUpZL2hyRjVtVUJQTStmMFBRYzFn?=
 =?utf-8?B?c0djdHUvMy9DOUN4dDQzUkVqYytKZjU0eHdHbVpUcFV0MWdrMUlleDIzZkIw?=
 =?utf-8?B?YlpUYStZU1kwak81djhwMGo0dnp5cS92RHZHT0paeGlkVEJUUmduaEJ2TXF0?=
 =?utf-8?B?WGFmaXp6K2IzcGlqd3o3T1dSSXVadFRuaTYxTEhFNi8wcWlMZHRQZXluR2lT?=
 =?utf-8?B?TlhqZnBwRjZDTi9Md0ZsdWpleXRrcUwwc2tyVWdjRTZHRTZDZDB2eVRuTjRV?=
 =?utf-8?B?U3lackpXUUxHdmhwNGZUV3NlQ2Nwa1Zoek1YNmpyVUtoNkROZEhad0kzRnc1?=
 =?utf-8?B?OXY1TkdiWU9hSVNrM3hxd0QyTXl6MFM3d0kraUlxVlkyTlBBZUdoOWsrMVJ6?=
 =?utf-8?B?S2tCZmRjekh4ZzF2QmpIVmVMcERiWklCYlE3YVV4Z3RUU3ZsRFNaRHlzb2VK?=
 =?utf-8?B?U09pSXlkRDFOTnB6Ukp1dlRJRDhJN0prRy91ZFRDeDdoY1J1MFFWTUZQc2dB?=
 =?utf-8?B?WUFBSzVXQmpBNVdob0ZzU3FoWGhFVllZeDZlZDNxbENMWnFoeUlTR1lzOHJ5?=
 =?utf-8?Q?hZibhJthpJsW9F3+8o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXFjZzBBcVNFY0lHTU1xTzVMTWVjb0pkYitVL2dHZG00cDNSMlR5cU1UVXZt?=
 =?utf-8?B?Uk8wQitmbE12T0xGa3V5bUhiU0JSNDVuanBsc0RBeW5jQ1hxbldnMDBGelRU?=
 =?utf-8?B?WjJRRithRlBMcHpVZ002RzF0ZDBDMWl3VkZmTThkb1NmRVE3RnEvZUN1VGFt?=
 =?utf-8?B?USs2cS9QdEtvUVo1LzVJQzBIenBLUWhDaDl1ZGw2MHB3UXY2clVIS0xXemt4?=
 =?utf-8?B?aHJKK1k5alNxWmpENlJiNzBKUHhXcmcralhhcmdYRldaVGlpVzV1U2FPSUVE?=
 =?utf-8?B?ZG5qdDFHeDlpWEZOSmVsRjVNU1BMVVhNa1o2dEhCRkdXTWlhTkxoMnZHNHNu?=
 =?utf-8?B?YnAzWmpEMERZa090SnJPeENTMXBEYTl2czNzRUdDUzNqZDQxTGk0ZnJhOTlh?=
 =?utf-8?B?em82bHEyU1Z0a3gxdTV6b21vNDdIZnJMVGJrdkY5NUV5c3E2OWxBR0ZFNFQ5?=
 =?utf-8?B?dWNOaUs5RlpZTEhUTk83ZDVxNElGMGwvTkZpcjd0YmhiTkM4ejVheW1pcS9B?=
 =?utf-8?B?N1pXODQvRTd6NVpHZ0hSN2FIWFVGMWgxd3ZLVE9UVmYxRkwvSWNST3R1MmpT?=
 =?utf-8?B?aTM2OEkzejhXT3krZnk0OFdPRWt6U0dBMnhHeWFXR1FtMm1xUS9tSlR6SUdE?=
 =?utf-8?B?a3hpWU5lQUdhQURhUllFM3h2QnRBM0FNSHZPTzEzVXRCWFpsMU14TVdrWWpm?=
 =?utf-8?B?R2hBSjhLTytML0d0N3ZrZWhIWDdQUnEyOEtXeWdETUdPck1WN2d1bXh5Sko3?=
 =?utf-8?B?L3JEOUg1K2lpcG5tRDNJekZpQ09QWmVpcm8wY1ZISGVlL2xvUjR6ZnZuWEhT?=
 =?utf-8?B?V0xNTTN3ajJrZ1VNcmUxVjR1NzEvZ25uNzNMbmtSU3JDUTZrb1J5YmxHQjcw?=
 =?utf-8?B?bEJUUDNOT1prYmM0VEVNejBrck8va0ZYd1pJSzNhSDk0WTBqZTduV0dvcytG?=
 =?utf-8?B?a08vWC92czJwUWpPQ1hjUWdJZVlYSFhKNnBYVC93d21wS3lVN2RmYmpIM3FC?=
 =?utf-8?B?ajVYcTlPUXdpcWNzb0txdUF2UjJlWFNTMFlmNmI0Wit1aE4wTkhXV3pwQ2sr?=
 =?utf-8?B?YXZDRTR5YWFIbm8rWU5nQmsrSEFRdWQvT3o0YU9rWHJINDltdlFWTzh3N28x?=
 =?utf-8?B?QVBrdUFiZVZTa0YxU2xUSnhNdVZMQ3BESVo2VnRucVpJUUhhR0NydElyUWwr?=
 =?utf-8?B?SnpwT0pCcExXKzM2Vi9Dc0hYcHU5YUNEY3J4c2VOQVlsRndIQmhiWThpOG1K?=
 =?utf-8?B?VHNnRlpTdW11QmphR2FOaU5DVlAyZ3pPNDMvdlRBY3Z4dGlPeEloNldGTzJM?=
 =?utf-8?B?TUNkand0R2RaY0syVnpDUlNPTitrUytRYXZaSXBMenFxTzFXUEpZbEpzUEhi?=
 =?utf-8?B?bWd5SmRqOHlGQ1JHbThMUnBocmZHdFBwODZvdTVSbm16dFcvNEhOUTVqOUlu?=
 =?utf-8?B?NVFZYW5jUlc4bVBLTjcrVmVWdkZTQWdkNEFvbXB0T0svY1cxK09IeTNYN1lK?=
 =?utf-8?B?QytyU0xob2FYQUYvT2V5eG9zdzFmdFZZN1I5ZFE3Q3BYdVhkS3ljbjRsZXNZ?=
 =?utf-8?B?UmRnUGpFOWg0SXlBRFliajZEalYrVnRnbFpBNzhIWTNPSHNCdU9nU3BjU1Zm?=
 =?utf-8?B?U2NUL0MydmN6aTc5MVpSR0o1WERzVkNLd0xUQUlHYm5BR25rQzU3NFlSOEh4?=
 =?utf-8?B?QkJtckxhQjdXenN4NUk0RkowZ3grU3c3YmUvZFRKbEVrWFRzb3pDZ042dWc3?=
 =?utf-8?B?eGsya2owYWYyUFIvR2pjRTNXWFgxNGw3dmY4QjhEMTBYNmdIZnZJQnlnVzIz?=
 =?utf-8?B?S0VabWQ3amVkSENBV2RnOGhCSWcxUUFUTDM4SldRc1Y0RVNpdXMrbzZnaXRa?=
 =?utf-8?B?N0QxcVp6S29DeE5heFpmVHNacVRjK29kQ2RtYTM3VDVGVW9odUVqR241M3Zq?=
 =?utf-8?B?U1lQY2dtaXpVVkIzS2c1clRQN2cxZTJzSExiZTFkOWpqMFZMMUVYeHIrOHBw?=
 =?utf-8?B?akgwdldZTjgzaUlZcTZ6VnVLRXVCSzFrdFhENmdMQk03bkVncUF0aCtHUVpj?=
 =?utf-8?B?L0Y4S3pOSVZEckVkVkFXUDFaQk1XT0VqbGNPendMM2g0NlhpU3pYOXBNMUJW?=
 =?utf-8?B?U1VwN0xRb1FUNEZUcElMZytZWVh2S1hsbm1YcUUwaHRaM1VTU3JVZ3lMZGFp?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5ZiduMsXLqYVSn/d1crDX4Sz6r6iGl+2GHcO2uepq+Q37jZmENy3jeE8UzpRwNnfZtNS/omHaWh4XCoQovLMKO0pIcBGt+f3odAHEAInDPstz+F3aqULLhnC37k5woUZgqpNLUXzHCCfgj74czlKK2B/VPfGL7Ik8tEd3fwK1KN/pwqwuOWb297zqsBpqz0ZY3/TVcjd/rddSw1gxPUosvPZOwUZFVc7gPh0Y5YYu0s2pxpSydk6/muc+8H808TxAHg6Q/eqrYcamFlOxDZPYOXCpCfHFDdSRN55Dm7103E8yc4xbWi3BNxEib0RK72S77l7hlGfL41ZUWsDfvkMuXgAIzogpJVFEHAQgSR5Ve0P94fAadJxTWUEFf1meRPPzFreVZ0N7GkgEz7EL+GkjJ1yEWoNZhIAJIwPR24g8DiEnYE4/+gXMXi4U8cZ6ZkvmE29SQfIvblRaueA8MmHvPEM8CFUCDYVIWAjzmNmOe55r6i1K/uD9Vkp1QSw2VOTjSXXAxbQHq4cYZxjWqji8FAZ9ALYsBk7wW9eJIM+aoHkbahGIP8jA9wivmtmGlKdpWpLd6E05pxdzFkVrfXEWd9Jg2faqHLe0FeDRszyL4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bcf1da-4711-405b-f2cd-08dcccb7a4f8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 08:00:30.0422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJHgnmAuYE2v4nEGyOXEp1lmvHx9ZPYs3LDgi4+0zh4/szGwmGsz541UH1sXMKXyQQYNtCnHYrLUd9LcXLpkGEdyY3ablDLASjg5s5l0a+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409040060
X-Proofpoint-ORIG-GUID: UecMyWwMQBbNko4JRp01x6TXc1I1CBPP
X-Proofpoint-GUID: UecMyWwMQBbNko4JRp01x6TXc1I1CBPP


> On 9/3/24 11:35 AM, Daniel Borkmann wrote:
>> On 9/3/24 4:50 PM, Yonghong Song wrote:
>>> On 9/2/24 11:52 PM, Daniel Borkmann wrote:
>>>> On 9/3/24 6:10 AM, Yonghong Song wrote:
>>>>> Hi,
>>>>>
>>>>> Suggested by Alexei, I put a llvm20 diff to make cpu=3Dv3 as the defa=
ult
>>>>> cpu version:
>>>>> =C2=A0=C2=A0=C2=A0 https://github.com/llvm/llvm-project/pull/107008
>>>>>
>>>>> cpu=3Dv3 has been introduced in llvm9 (2019 H2) and the kernel cpu=3D=
v3
>>>>> support should be available around the same time although I
>>>>> cannot remember the exact kernel version.
>>>>>
>>>>> There are two motivation to move cpu version default from v1 to v3.
>>>>>
>>>>> First, to resolve correct usage of code like
>>>>> =C2=A0=C2=A0=C2=A0 (void)__sync_fetch_and_add(&ptr, value);
>>>>> In cpu v1/v2, the above insn generates locked add insn, and
>>>>> for cpu >=3D v3, the above insn generates atomic_fetch_add insn.
>>>>> The atomic_fetch_add insn is the correct way for the eventual
>>>>> insn for arm64. Otherwise, with locked add insn in arm64,
>>>>> proper barrier will be missing and incorrect results may
>>>>> be generated.
>>>>>
>>>>> Second, cpu=3Dv3 should have better performance than cpu=3Dv1
>>>>> in most cases. In Meta, several years ago, we have conducted
>>>>> performance evaluation to compare v1 and v3 for major bpf
>>>>> programs running in our platform and we concluded v3 is
>>>>> better than v1 in most cases and in other rare cases v1 and v3
>>>>> have the same performance. So moving to v3 can help
>>>>> performance too.
>>>>>
>>>>> If in rare cases, e.g. really old kernels, v1/v2 is the only
>>>>> option, then users can set -mcpu=3Dv1 explicitly.
>>>>>
>>>>> Please let us know if you still have some concerns in your
>>>>> setup w.r.t. cpu v1->v3 transition.
>>>>
>>>> Sounds good to me! Is there a place somewhere in LLVM where this
>>>> can be documented for the BPF backend (along with the various
>>>> extensions), so that developers can find sth in the official LLVM
>>>> docs if they search the web? I see that riscv and some other archs
>>>> have documentation under [0] which seems to get deployed under [1].
>>>
>>> Thanks Daniel.
>>>
>>> Trying to have llvm doc for BPF backend has been discussed
>>> before. IIRC, Fangrui Song suggested this when we tried to
>>> add BPF reloc documents in Documentation/bpf/llvm_reloc.rst.
>>> Eventually we added llvm_reloc.rst to kernel since this doc
>>> is mostly interesting for kernel/bpf folks. We should add
>>> an entry in bpf_devel_QA.rst to mention that default cpu
>>> version change from v1 to v3.
>>>
>>> Not sure whether we should have the same doc in
>>> llvm.org/docs/. Let me discuss with other folks on this.
>>
>> I was mostly thinking that not everyone might be looking into
>> kernel docs (say, eBPF for Windows folks using LLVM), and at
>> least on gcc docs/wiki you'll find information & quirks about
>> gcc-bpf backend [2].
>>
>> =C2=A0 [2] https://gcc.gnu.org/wiki/BPFBackEnd
>
> Thanks, Daniel. Eduard and I will look into this.

Note that in GCC we document the BPF extensions (additional compiler
options with their defaults, backend-specific built-ins, etc) in the
compiler's manual, https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/.

The wiki page is mainly for documenting the development and status.

>
> Yonghong
>
>>
>>>> =C2=A0 [0] https://github.com/llvm/llvm-project/tree/main/llvm/docs
>>>> =C2=A0 [1] https://llvm.org/docs/RISCV/RISCVVectorExtension.html
>>>>
>>>> Thanks,
>>>> Daniel
>>

