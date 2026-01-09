Return-Path: <bpf+bounces-78327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5254D0A6B1
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8FEB30A1F1A
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7699E35C180;
	Fri,  9 Jan 2026 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rb+E46Wd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wpBgxw6S"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5735B132;
	Fri,  9 Jan 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964884; cv=fail; b=NdCruTkl8BkmLU0R8xgU6oVKHKyypWJnjYufqXi2bM5bBtk+fJ7U3qsqseMZA2/hprc0zxluz/mH5OaYovvVm8Pg9ilBT0jmRecmUDK04W+H4nbHFN6tqEcn0yLQfHm+CNagNuS8tdGTBrtG7JExBdCRGJrYwx64rTtDVM2fP5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964884; c=relaxed/simple;
	bh=XPPTmEnZJAgqSjPp9E7siKKjOb+HluXJ/pkdCTqAe3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lQa2tUf+9B9qsuXrp3i+XEpVhk0ugtA34G6Dtkbgi755dN9G/BxJev4dmnGoprgDgo0nRrNUD+EqPnCoDAzQRvn52CnL5uttrp3nX+gs4OSTvwS1XRQmtn35C/ySnv1kXbAwiqL+kr2V5emtCdfPzpyqk2CTuhxVoktp3qbtVns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rb+E46Wd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wpBgxw6S; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609B6FGh2912700;
	Fri, 9 Jan 2026 13:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6cS3laOXSyOo9wEI0cj8TxrdBNmfTiv289gUrR4aUGM=; b=
	Rb+E46WdO+lv7X1YlabXeJROHr70xkuQ8EuyBZ01R5cXyf4qmuFTx4uEU3qRZl8M
	9/tzysdm//0Uu3PJeqvlvDklTdEXl4zGnPiZUDt+iWdksaRUDuJe27C+ngyx2sYE
	KDxzGKlwC82t8FZOqFWbT6JCJidbISL8IQsmtZSnNlkm03X/09gGzLTETUfGx2vf
	Viakv6O641zNfs+xOZKYkAcPON5G2H8idXNZXMnZdd9NJSj6sL830LM6Vashozpa
	M2rIOs878lpcbjeSo0wBYHWfwSiXgOhAyyXOqThh7ITlgJ1yv+DvmzjWMTBHWUGT
	M+/LDNCoUqF2cktARQJZRA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bk0gm04um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 13:21:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 609DF9xX026334;
	Fri, 9 Jan 2026 13:21:00 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjpmhb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 13:21:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFnB5iVIHStGQa869mOg7FShDSw+AlCJvOgMKn2d/eIeQDVhXqA7KACxBAlDJKOChH8EX+Yo3nhiJ5qAQqMf/Gf0OQHJmuhvAbZerPVZQccgLCUh4mMC9JbQyzqX/RaknFsQOPvOrax8qH1krLASxngEZ9YtlrUlv56TrhMDLLXnnlhDPw4fj0MgyF5ErImmpAkdimxvml5j76WMB4C8SJsu2d0ToxbQDzb2/EV7oenxqiP0D0kcN9xpahjgwqfyBxcwrLg77ksvTjzruV+fYIgOJ179ntcjqNWjazEpJIkdi0kPQWQjP5Yrin547foRWipht0lFBn/IsiIm8Fkptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cS3laOXSyOo9wEI0cj8TxrdBNmfTiv289gUrR4aUGM=;
 b=nv1WYsY0UvseFJg5rJYhe8E4uf0rmVz0XPDRzDpZHIIua+HAIg+wNvb2cnSbxO4gi9rd5qRP1CFO+P2JrliMr8KQcaQM6Uai6BkOh57xkSmvAFHDN01fJaGUKuq0nfQBjomdfmeCrLbasmuNiUr3mwuzvoOygUVmIgFn1hIllRfdO0czpGRGrokSQanpBe7GUwiz711UL1q+K+5V9l7mjC7rQBmnnfaa1ipZCXEiq3xssljTkvtJxzIPhQrrBPGyWM8PR5Ic0JQ1vUMqTq+UWySyF50+JoZlUuJKv0mjlDwwuqKHlBWYD/OUvFgl47L8D5OYRhpf0aYb8zq9MklN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cS3laOXSyOo9wEI0cj8TxrdBNmfTiv289gUrR4aUGM=;
 b=wpBgxw6Sn8i0dQ4pWwQorWWRg3UEXWLwLZY4cAY4/lHiufuZOWGMZCOkSUQeQ2wQS/NQr7250dk8Ndzp9MtFozzdX+f82+cU9NeYO257Qes/94ZYjmpd+l49JYV4iLETd6nw1k+ReJ1+fneVP9rw98TCl0rO8efuUSQbEdwWBh4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA2PR10MB4540.namprd10.prod.outlook.com (2603:10b6:806:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 13:20:57 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Fri, 9 Jan 2026
 13:20:57 +0000
Message-ID: <da5823ad-bc47-4fb3-a308-645e9857947b@oracle.com>
Date: Fri, 9 Jan 2026 13:20:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Thierry Treyer <ttreyer@meta.com>,
        Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com>
 <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com>
 <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
 <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com>
 <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com>
 <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
 <19a4596d-06dc-42ae-b149-cc2b52fffae9@oracle.com>
 <CAEf4BzbCxGaFu5E_oYdMxzkqhtVxSnwHawcUv5jM5Sodut5cdA@mail.gmail.com>
 <CAADnVQKYTMPyWLNn-5HHnA23Ay3qNdGUJ9TNVcy62zPEf013Xg@mail.gmail.com>
 <CAEf4Bzb5askzzBL4BnR1tcjio+jW3zdVs_pPPgSq7vd+N5zuXA@mail.gmail.com>
 <64de60b6-4912-4ec8-9c85-342b314c3c5c@oracle.com>
 <CAEf4BzZYS5QN0B-B7HfPrmiag26-XYqiGNEv+n0gAMhg5uYjrA@mail.gmail.com>
 <CAADnVQLFCPDoRQt4nWxsHVt3AG=HnyE=PepaniWv1yeigozaoA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQLFCPDoRQt4nWxsHVt3AG=HnyE=PepaniWv1yeigozaoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0329.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::12) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA2PR10MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b28df8-1da3-47a1-6dcd-08de4f81eccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXVxOVJyUnRTY2Z2MVJYNVdKenEvSGRIbHdyWTFFQXY1cndkbGU4ei93WUhz?=
 =?utf-8?B?T2pwQXZWandDQjIxcUZBZ3JFclE5cnZqZ1NOOTQ5b29YUUpBeHhKaitEOVNj?=
 =?utf-8?B?eG1KQW5wdFFad0ViUXVsVm9xYVdJSGhzR2piZU11OEEvQnd2SURJYWUzb2hi?=
 =?utf-8?B?Ym43VHpocm4vRzZsTjM0dU1UUXcyOUtxMmZPRkNGV3NWblhMMnFWTlVVRXAr?=
 =?utf-8?B?SFdDbkZpeXBtRXNmbmkvWUF1aTZiTlZCbW41TDdVY3oxMEVYMzY5U3NGRVNy?=
 =?utf-8?B?TzhKNG1WTytJdXFLQmZ0Nk5UazNYK2VFKzFSdFJoWW1ZbWYyeXpEekV6SnFz?=
 =?utf-8?B?SGhyUWhpQ1BNTEF6Mm01K3ozOVlJMVl6T3ZveWpvUXZwRWFWOWVDdW9EY1d4?=
 =?utf-8?B?OU96N2RCVkdsRHYrNVJ0ZUpzSUNaZ2RScGczTmFCL0NMY2Qzc3graXNqTDJQ?=
 =?utf-8?B?MnRXaEl0VTgvU0o4TlVRS3BUQnpaYXJVd3JCcllidE5pZThXNmNoa3JKZjRZ?=
 =?utf-8?B?ZlRnTlY5NmFiZmRtZWZsVXdJbTBlRWpJS3pyUnloWktxNzVJSFUvdGtwSjVz?=
 =?utf-8?B?NXM2UXBzeEVxaGRuRmFTN2c4ak9vUnhPenp4cnZzN2hCZG84WnJkakxlMzdV?=
 =?utf-8?B?WHEvWW5CeWJ3dndwWG5IdE9scDNhZ1BtcUtIeVJhSmcyVERweWZQRi9jM2pR?=
 =?utf-8?B?OTlLRE50VWg4K0F6R1BQNlFBd3pQcDE3U2xDWHVQT253Wnc2em82ajBGT3gr?=
 =?utf-8?B?bTltZWVXSURNRFRudkJzNVkyVkR6VkIwa2ZWaVo4N2daTDRxcTB0RlBMWlZK?=
 =?utf-8?B?SUw0UXI4dys0KzZFNi9vNG9hbkpvenNpbEs4RUZsOGRoYmszbTMwTitIamVI?=
 =?utf-8?B?TXh5aXVmZ1ZDYitnQmdYMTdITzllamtZYzR3bTdIb0t0NXVHd0haamlzeEpP?=
 =?utf-8?B?V01uZGxpNlBCeXhUem5nUFZxdGh2blJKSGt6TXBNOFI2WXhyNm83bEJZSjJS?=
 =?utf-8?B?Q3NZUXNFRWZoYkpoUmpxR3M4OTFwcHdLZUJadndjZmF3Y01HV2hETEhRbTVn?=
 =?utf-8?B?ZldNcjR5ZGIvcmNKUlptbEMwUFB1aDJyUG1wdlZSWjZKZG5qcFpUbWxJZ255?=
 =?utf-8?B?TzNmSUd6VmxrMWNBZDVSWUxxSUV1N0FTVWh2NnpIOG5FZkNneGxEcXFjTmJC?=
 =?utf-8?B?VTlWUURDWVZzRGF2c2hsUlNMZFVrSWQ2UUVuNGg2c0VEaTZXTnhjbzVmTkw3?=
 =?utf-8?B?RlAyeEdtWk5BRFk0WVRDVlRKTEVtSDgzTmZJY09SR2FGWHUrME1GcytSVnRy?=
 =?utf-8?B?MmxueWFNOEZ1VFUveFlJclFkcEhobTltWEN1bEhDdHFCMzVpUExGeE5GQWUx?=
 =?utf-8?B?TDEyNi9VUTAzODBDYWJKSVc5cGlzQ1dwUXpmbW9pS2RaRDNBODc2YzRFalo2?=
 =?utf-8?B?Wk1XaUZyMkdUYUlheVZTK1VSaUR2MEVuSkRrTXhZbWJsZnVXYjhySU01b0pX?=
 =?utf-8?B?Tm9rQ2lMRklmWlNGdDVwUGtKbnEvTitZNlVyQ2ZNOXJWUXRLT201eFRLWG0y?=
 =?utf-8?B?ekpuRE5aeXB1RXRzWXUzMHAxQVc3M1B5ZTloUEhMbUUrK2ZDNEVhU1FQeFJH?=
 =?utf-8?B?NE1ORzlXZUlNNTlINkRGOGVKaTJUVDQyeE5mb0E1S01DMGhOZ0E3UjRKSFZm?=
 =?utf-8?B?cDY5Q0xvMklrM1JhV1o3Sm1xQ3ZDNGVROS9FRi9HMDIwY3BMMm92L1BvKzd6?=
 =?utf-8?B?YjhQN2ZXaDVna1M4ZnJ1YzkvcUJjZ1hLQUxudEtjTExna1o5Mi9UQ0x1VS9o?=
 =?utf-8?B?MG5FUVhvS3JXblBCN3MybjZiVldNRytuYlBmOFdtRFVNaUpsWGdBYlNlZ0Q3?=
 =?utf-8?B?M0JCd0ZuUUppYlRQTU1DQ1UzK1dLd1JleHowVmtFQUw4d3pWaDZla3lGK3R0?=
 =?utf-8?Q?qI+NaPFuQDo0yCNmOdXsVE6qj9Fjv9ux?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YllEc1hIcUlJYXdFM0lacnlabXl6YUFLYUVaV1JYUnB2aU9aTHBsSG1tV1F6?=
 =?utf-8?B?QVJ0K2xaNlRHM3RlV3kyTzFEdTEvc2RWQ3BJZ1dSckczOWVOY0FTckxTcURr?=
 =?utf-8?B?UnJrRXQzTXZVWitFNHlqVEhZUkRka3ZGZTN5cyt1WVdRQU95eEJod3FmSmlI?=
 =?utf-8?B?L1BrVGhNMzJ0ZGxFaHpvQTdNdFR2WG9CM2orbkl5VUFVUDlNajJRRHN4Y1hV?=
 =?utf-8?B?VjF3OUZpaVcxR3dkcE9zNUtMamZnUGFOYjJ2UDVRQ1lGOUhMY0ZHN0hHY0Zi?=
 =?utf-8?B?MzdIUk5HbDZOS2dDeEI5NGZsb3NmMmpCNVZsczZ6YmJJNW1haUNvM2NoNHRP?=
 =?utf-8?B?L085WXFyVE5OZFZWRkNuTDBlSk1nUExvSHI5WTRLZE1qRnNNVmhDMkZyUUJB?=
 =?utf-8?B?dmtNS3FIUWFwS3QyZUdNdExIWW9WTS82WFFpSHhqbFRHdGlUUFE1VjNsa01F?=
 =?utf-8?B?Rk5mVXRNSjlndVJMd1dPcDF0WUl5VkFZalFvZjVvZG5GZ3Rvcm9QOTYySDhO?=
 =?utf-8?B?TWNod3ByTWdkZG9RcUNjTHJObURUdWd4N1R2dGFWaFlVYTBtNWRLU2tRMXU2?=
 =?utf-8?B?R203TDJKT0Mxa0lxUmhRVklwOXh3S3lUTm50R29hYVBlNHlURU1JL0hUcERQ?=
 =?utf-8?B?bXJseGpuU0JQVzN0Y3ZKSEpxak5TbUV0MU1ZSUVWYThIZldBcHdyWjNsUGhr?=
 =?utf-8?B?Zzd1MStBN3dFT29yVHJoSFNjdVZocmVzTGMzVUc4U2d6ZGdid2lmSm5zQ3Z4?=
 =?utf-8?B?QStPRXJpcWRhWndPenoxMUo1TmYzWVc0QUlXOTg5cU9rK0pXSWVTUG5EZkVW?=
 =?utf-8?B?VkcyY2llVnR0TER0aXVRVlVodzRsODVZSjFOVWkwQzBPZUlWc01Bc3ljaEZn?=
 =?utf-8?B?STB4dnd2bjJnd3dRVnhhQnJCS0dyU3lMdE5yVEpnbjNzRGRmTktzakVPRnRB?=
 =?utf-8?B?K1BGL2FJUEZIK3BxRzlZeUZoM3JxVjNXY0lpRmMwSFZHYUxtMWFQTG9VYWRa?=
 =?utf-8?B?dHRFRnJBWGtHQnlRTWhVNEF2YkJuKzVDR1dyYmhxSHJZWnNQL2h2c2ZBUlhP?=
 =?utf-8?B?RjV1eDh4VUpLdmhXUjlVdisrelN5M2laN0VBb0RJSDFMWmw5U1Z6ajB1bnpI?=
 =?utf-8?B?aTg1RGFaN204S3g3eVNCQVZ1Vkx4cDJ5WlhpVGFwcUdWQ0RpZzRqTE1aYmNM?=
 =?utf-8?B?WDhhbnpxaFVjU2xmSG5pcEp6UlJScngzSTNodkViZUJidXRZTC9GM3UvTjFV?=
 =?utf-8?B?MkFoY3QzTGErdS9uWWhQMWxQT0FRdHpENCsrbEpNKzFSZnJUU3dyQ2FlTmQ4?=
 =?utf-8?B?ZjArdy9kMFBTbXhPZFhkejNLeE93UHQ0T05RdzNIcWpWL0Jzdk9oWHRIYnF3?=
 =?utf-8?B?T0RkOVpMQ0lVNTNBV1FNM3VjNjBaL2JJZnVCMkJNZjJaWEkwMXNzUXhweWpH?=
 =?utf-8?B?L05kdndvbTNKZjh0YlZVOUYyc3RPM0xxaVhaWTdnOHJCekVxZXQ1UkUrcGJm?=
 =?utf-8?B?UkxERXlLNzhKcEdHdEpNcXMwSlA3ckFKTlVXTFZDaDg0R1Z3NGNuV2VCSGRY?=
 =?utf-8?B?c3pwZmcweG1WbG50bzlQUmtST3FlZE9mWlhIT2xvTjlzT3NJMldScHRnVk5J?=
 =?utf-8?B?NThMNUZzQ29Da3FYWmFVZUdnd1lKN080U3p2N0h6M1BPOHRjL2Q3djkwcjVM?=
 =?utf-8?B?SkpjVDl0cmd1dlBNcEdGenZKdTRQSGJxTGJVVlZsWHd2bHMyU0M2YUlITjlY?=
 =?utf-8?B?eXh6ZjV5ejhUcnU3UklOZ0ZmbUZNNFpwNWNSUVIrTzMwMU9CVmtZbHF6QWZs?=
 =?utf-8?B?eTNPMlBSRmU0MytRbklmOS9ndlYwcW9Gd0NGbHdFRXE5cStSeFpJQWRyMjkr?=
 =?utf-8?B?MldWalEvVUtCeVpRRVY3eVp0bXAwNmFyZFFWYWk2dDFtUWxtZlhOL2Vqa2po?=
 =?utf-8?B?Kzg3K0ZVdGRxSFEwK1E2Zy9VWU5ZeHhRTzl2OXFqNERycDlGNm5VYkxrNGUz?=
 =?utf-8?B?SWwxRTJpcGFDVnNzY2JkQjBJcCtTU0ZnNk9hemVGL3IyL0lySzhmbkxXL1VI?=
 =?utf-8?B?WiswSE5rTk4rWjlaajlRMFVQM3BSOHZKL0N5Um5ad0Q3TE5wK0I5L2RsWm9C?=
 =?utf-8?B?T01OSUlHWTdVNS8xd3JnbWNiaFpYOHhEK0RjQ0wwZ3hDQmdpSlYvc2IyS1VS?=
 =?utf-8?B?NW9QYUpURngyYlVRL1cyeWJJT2wyd0VDYXpJOEpibkxnM0k0Z3pCZzdNVFNK?=
 =?utf-8?B?aEZremtyRmw5cnYyOGliMk1IMXV1RmlzSmdsZ1hBcnl3ZEQwL1NPQ2grUHZ4?=
 =?utf-8?B?OWJXdENtd3FJd0t3UUl5WlA4ZzdObjVlenYzRDdXODJ2dUZ2RzIyQWtGdlRV?=
 =?utf-8?Q?jRcmftzTBb4q3bUY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S0NAdysGYMLJ6HRPpNIDt8PKem6oN/tSkpI3bukrM7Q4vdO3m19ntvRKi/3VxLm20reUGNEbqig/VAHKpdjkWCCL8ffdkDQLGcvbMcS4zjxgmq7UT7CoLRgUJ0+o6OCSU7MCdsCQJp5096g9mnuSd56F88TAthk+rdLAQqLwciJJPiOfHZutyETYAo3ExLdmaiE/djK2BEyE2/kGvySbu7Ge6NmaXPhApV3j1UKWAhPKyv1as22ef0KfSP6MA0LJ/5BSozIMx0kyvV+VWFXirCTTQvE+hMMrzNImy07LJ3kDJuInaZEI56NQPGNRNrLClNW5Lr4kMY2ryr/NKU0dtH1Ew9NcIyLPwacLu8XREioNVJ7yfVpAA/+uscCjQ5AOGYavdO4i8FnVHic4bmKsBau8pF8hVu3ghBRvq8iuu3vN+h+0HzGmiNREsrH9tPsVl30TscWchgpJJLL83IpqYnJOupyGTXRApRUDRrQ6yPJ9o8gomw1R3YtKFMkqyklWuHM1njBFC4Sa+32edmErLWFiwmDszCwbx2Nk71kAyC7AmDK9e2ME2jbwDgpCmI7D9haeo3Roa1Yx9yzcEUKYYrWEUCHwlHRm19YGJwiptP0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b28df8-1da3-47a1-6dcd-08de4f81eccf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 13:20:57.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIQBKeAE8O47UgABbtNzEfnf5SRyw+n+MumgjoJ6+YArobnTOsVTHSueCGycaTh9iTR/flZiqHeX5f3TXjKSrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601090099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5OSBTYWx0ZWRfX8q1iL8Y9+OkD
 OjP81tWh/X0e8uz0M46vNX8G25ULkAQgD4VPaTHHlcW21z0tsPXBNkQlJt1AEhhhINfcUk+7QAl
 n3lt0gRRWZa1XZoluf3AHJQGEoLmiCIMGGXoA4Yq69zUo0yvjCuUD/9JlfbjFO63ZPg1NLyb2sl
 9UeM0Upf/ZztNuBVpJtF+mK8kTD2dPnOZDzNDV7kpe7uSAiW9MUOtv/ikSMcdAt4X1YdXZHR5Rs
 3XQoy7YLERUerKdNlih3J8CXdYjIqsIFqaCcDVyHrKYpTzeph7FCND3iZ8+u2Et5uI/PVpzB9kM
 de+nYkYOz89JpCUbKVqv5oOpCg/mPpVVUB1cGmHe40NThcNItbBD0Up2xjg39J6wmCy6jvwOIRZ
 7hupYzN+03b4tZ/DbTigKBV6bI5lOWfNMKO1PMuuf+lj9pv97UxZI4yFZfnv1gTDSaVWWpvxgU4
 QjhY5qCi3HkTervrmcycSw7UsS4a7h8FmbEvc1gU=
X-Proofpoint-GUID: c65tX7MkZ-i7gQf9NbVU7y58kAk_Jo41
X-Proofpoint-ORIG-GUID: c65tX7MkZ-i7gQf9NbVU7y58kAk_Jo41
X-Authority-Analysis: v=2.4 cv=Mb1hep/f c=1 sm=1 tr=0 ts=696100bc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=G6jdneMbjDRy-zqmkcIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12110

On 09/01/2026 01:40, Alexei Starovoitov wrote:
> On Thu, Jan 8, 2026 at 5:24 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Thu, Jan 8, 2026 at 10:55 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> On 06/01/2026 01:19, Andrii Nakryiko wrote:
>>>> On Mon, Jan 5, 2026 at 4:51 PM Alexei Starovoitov
>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>
>>>>> On Mon, Jan 5, 2026 at 4:11 PM Andrii Nakryiko
>>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Dec 23, 2025 at 3:09 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>
>>>>>>> On 22/12/2025 19:03, Alexei Starovoitov wrote:
>>>>>>>> On Sun, Dec 21, 2025 at 10:58 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hold on. I'm missing how libbpf will sanitize things for older kernels?
>>>>>>>>>
>>>>>>>>> The sanitization we can get from layout info is for handling a kernel built with
>>>>>>>>> newer kernel/module BTF. The userspace tooling (libbpf and others) does not fully
>>>>>>>>> understand it due to the presence of new kinds. In such a case layout data gives us
>>>>>>>>> info to parse it by providing info on kind layout, and libbpf can sanitize it
>>>>>>>>> to be usable for some cases (where the type graph is not fatally compromised
>>>>>>>>> by the lack of a kind). This will always be somewhat limited, but it
>>>>>>>>> does provide more usability than we have today.
>>>>>>>>
>>>>>>>> I'm even more confused now. libbpf will sanitize BTF for the sake of
>>>>>>>> user space? That's not something it ever did. libbpf sanitizes BTF
>>>>>>>> only to
>>>>>>>
>>>>>>> Right; it's an extension of the sanitization concept from what it does today.
>>>>>>> Today we sanitize newer _program_ BTF to ensure it is acceptable to a kernel which
>>>>>>> lacks specific aspects of that BTF; the goal here is to support some simple sanitization
>>>>>>> of the newer _kernel_ BTF by libbpf to help tools (that know about kind layout but may lack
>>>>>>> latest kind info kernel has) to make that kernel BTF usable.
>>>>>>
>>>>>> Wait, is that really a goal? I get why Alexei is confused now :)
>>>>>>
>>>>>> I think we should stick to libbpf sanitizing only BPF program's BTFs
>>>>>> for the sake of loading it into the kernel. If some user space tool is
>>>>>> trying to work with kernel BTF that has BTF features that tool doesn't
>>>>>> support, then we only have two reasonable options: a) tool just fails
>>>>>> to process that BTF altogether or b) the tool is smart enough to
>>>>>> utilize BTF layout information to know which BTF types it can safely
>>>>>> skip (that's where those flags I argue for would be useful). In both
>>>>>> cases libbpf's btf__parse() will succeed because libbpf can utilize
>>>>>> layout info to construct a lookup table for btf__type_by_id(). And
>>>>>> libbpf doesn't need to do anything beyond that, IMO.
>>>>>>
>>>>>> We'll teach bpftool to dump as much of BTF as possible (I mean
>>>>>> `bpftool btf dump file`), so it's possible to get an idea of what part
>>>>>> of BTF is not supported and show those that we know about. We could
>>>>>> teach btf_dump to ignore those types that are "safe modifier-like
>>>>>> reference kind" (as marked with that flag I proposed earlier), so that
>>>>>> `format c` works as well (though I wouldn't recommend using such
>>>>>> output as a proper vmlinux.h, users should update bpftool ASAP for
>>>>>> such use cases).
>>>>>>
>>>>>> As far as the kernel is concerned, BTF layout is not used and should
>>>>>> not be used or trusted (it can be "spoofed" by the user). It can
>>>>>> validate it for sanity, but that's pretty much it. Other than that, if
>>>>>> the kernel doesn't *completely* understand every single piece of BTF,
>>>>>> it should reject it (and that's also why libbpf should sanitize BPF
>>>>>> object's BTF, of course).
>>>>>
>>>>> +1 to all of the above, except ok-to-skip flag, since I feel
>>>>> it will cause more bike sheding and arguing whether a particular
>>>>> new addition to BTF is skippable or not. Like upcoming location info.
>>>>
>>>> I was thinking about something like TYPE_TAG, where it's in the chain
>>>> of types and is unavoidable when processing STRUCT and its field.
>>>> Having a flag specifying that it's ref-like (so btf_type::type field
>>>> points to a valid type ID) would allow it to still make sense of the
>>>> entire struct and its fields, though you might be missing some
>>>> (presumably) optional and highly-specialized extra annotation.
>>>>
>>>> But it's fine not to add it, just some type graphs will be completely
>>>> unprocessable using old tools. Perhaps not such a big deal.
>>>>
>>>> I suspect all the newly added BTF kinds will be of "ok-to-skip" kind,
>>>> whether they are more like DECL_TAG (roots pointing to other types) or
>>>> TYPE_TAG (in the middle of type chain, being pointed to from STRUCT
>>>> fields, PROTO args, etc).
>>>>
>>>>> Is it skippable? kinda. Or, say, we decide to add vector types to BTF.
>>>>> Skippable? One might argue that they are while they are mandatory
>>>>> for some other use case.
>>>>> Looking at it differently, if the kernel is old and cannot understand that
>>>>> BTF feature the libbpf has to sanitize it no matter skippable or not.
>>>>> While from btf__parse() pov it also doesn't matter.
>>>>> btf_new()->btf_parse_hdr() will remember kind layout,
>>>>> and btf_parse_type_sec() can construct the index for the whole thing
>>>>> with layout info,
>>>>> while btf_validate_type() has to warn about unknown kind regardless
>>>>> of skippable flag. The tool (bpftool or else) needs to yell when
>>>>> final vmlinux.h is incomplete. Skipping printing modifier-like decl_tag
>>>>> is pretty bad for vmlinux.h. It's really not skippable (in my opinion)
>>>>> though one might argue that they are.
>>>>
>>>> Yeah, I agree about vmlinux.h. One way to enforce this would be to
>>>> have btf_dump emit something uncompilable as
>>>> "HERE_BE_DRAGONS_SKIPPED_SOMETHING"  as if it was const/volatile
>>>> modified.
>>>>
>>>> But yeah, we don't want bikeshedding. It's fine.
>>>>
>>>
>>> Ok so is it best to leave out flags entirely then? If so where we
>>> are now is to have each kind layout entry have a string name offset,
>>> a singular element size and a vlen-specified object size. To be
>>> conservative it might make sense to allow 16 bits for each size field,
>>> leaving us with 64 bits per kind, 160 bytes in total for the 20 kinds.
>>> We could cut down further by leaving out kind name strings if needed.
>>
>> Are we sure we will *never* need flags? I'd probably stick to
>> single-byte sizes and have 2 bytes reserved for flags or whatever we
>> might need in the future?
> 
> Just to clarify what I was saying.
> I think it's a good thing to have flags space and reserve it.
> I just struggle to see the value of 'ok-to-skip' flag.
> 
> So 2 bytes of reserved space for flags makes sense to me.

Ok sounds good; I think there is still value in having the single flag
that tells us that the type/size field in struct btf_type refers
to a type though, right?

