Return-Path: <bpf+bounces-68236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E0B54C08
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 14:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25339B61528
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 11:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD08313E2B;
	Fri, 12 Sep 2025 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Th6DYjz0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BouB1e3+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B46D3128A2;
	Fri, 12 Sep 2025 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678075; cv=fail; b=IcROPzkIbAaCgdJb7PJeyz82p0Lr5TCIISmm4AIr+5GZfUDF3L0luWJ3MqEHZShR7/4m3+OlFw/iA3p16sXl+SrmVZ9+CnskWVQTA5TaOrYVP1Sck9DzcPRrS6yKi+nWggbeAq670s7liDxTK2qR0riKrU/ufaRdTEce0EmKSF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678075; c=relaxed/simple;
	bh=32R8QIrChLDFA0Qfk4e2UeoM+0J7E4r4OrWoHRduPdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q3OY031FaTbdIwdGa21aWzfzih4fMqOqH/Cc/3mi+svmV064xq0hBR40dW62KUlfsqRsK2WHymouyr/Ja9CZnna81vM1k3vtYyOL7S8LGVE+puDVq89LTz1UtWLaHV/25+ZmRdgDTrmVcf5o9DfWKFiofu2VeHXFYeQv6Kf2VlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Th6DYjz0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BouB1e3+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1ugsw022007;
	Fri, 12 Sep 2025 11:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Y4uinevHknpxdKe4dMlLLAEACm+hCZDT3H4Q6Uk/Uzo=; b=
	Th6DYjz0F5GJrxdfcE8mtcOWqaxioqXck4+G2MaCf6yAh6EjWRlJjlRPj8WIhQek
	XLKhuJ1F0F7f0/S4lAHaEDO8CqYeTdg6Tsb86VYqAQ5kGWlJNmEMP8wQY+/8GqZ7
	+eFt9yHDGYdJt7grcLYfMy+OaqOsrujWvEck2530oMpkjEQXjp+FTcL1KWr3XV98
	CzxOqrC2mdwv/DvQLwTJbEvKHn9aDW+Ty9ck4TrotUtWt1lhi2bXHp8tZio2pjPs
	qbfWeDOZIt6el49zxqsPc2bL15tqrxL5c4AIHkhhYfQ5WvUr4Urdze7dIhHMLL6Q
	810j/LEr+VC65rxeFvkVKw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jh04ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 11:53:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CA2rMB030831;
	Fri, 12 Sep 2025 11:53:37 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddqemb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 11:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzWY0U6AsaONROd/B/jDY4m8FU0zaD2HwqzyAhp8tPGJW1qwccoJ7DY/lbbeWbfggQKb3gKB80eMmDNtKTzFyA2xPS61pPdJuPfgR+wgcPW0MPd7L8yoc4JWAjGWfqx4omzDuPRzhrFCBk3XMINRMSUV8yPcXjsLmGaMge+fTuvRSf0fCKBkRumvxK5udq+GLVP/9nVYNirtHMhY6633Ot7g4Bo6g1hhRNnKlik0KZ7IyH8dcbU86ie0bljUZ9wgoklc1S+d3KdWw6V2Y3sjBrJ0XTKInb8VrJCtyBmLaCj4TerQpSCLQBcgp5xdqOByFIzK/xEBtsprMb/ckarUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4uinevHknpxdKe4dMlLLAEACm+hCZDT3H4Q6Uk/Uzo=;
 b=bH6J3ikX4bHYSboDs5XUyfSQ08to22nn36enu2+PqIVMVYg+2L/CRZ7EdxDKr5L+b2n73+OC8g7/Aa4x7r/ytOnFNGAnhos2KhztGgcwUWMjxQMnBAEhRhBc0UaWtf0TdZZi9EaGLKEeMJPQJuQxSFNxFddd8oGzA0y9GgyqeDJkpaZmXvG/cJpgrdS5dY/AAJKIaahJwLCOip5ig24hk+yvQ0oIEI35nRWtyCjQVMOncQtZ2AENg3lXDe3l5SMog29+W45FlZ+0jTJdc5V9aWUCPQF8WVtnGgVcJwHzqNZZORiNhJj6cC/SqmJqU+k3AMrOyCTLGaMCgbpFpDcxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4uinevHknpxdKe4dMlLLAEACm+hCZDT3H4Q6Uk/Uzo=;
 b=BouB1e3+pw/3ziS2S4eYRhzVve4eeECCr7IRnzTD6vxHKuK1oIx8sCwFN3RlBZVqJl/1/kpcn5SStFCyGwnpVdS1avm7cnEiiYjV/q7/P3PDsTKNfeEAKZNzVKoJZPsDdQaoLFhnF/qsaT3plq8y0jT613WDP4rCun0eQI27f9A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7286.namprd10.prod.outlook.com (2603:10b6:208:3ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:53:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 11:53:18 +0000
Date: Fri, 12 Sep 2025 12:53:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <59432a1d-9b70-4257-aafe-0adb68db4c9f@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-3-laoar.shao@gmail.com>
 <4d676324-adc6-4c4c-9d2b-a5e9725bcd6c@lucifer.local>
 <CALOAHbB_jrsgEMH=HNozW+rASRLwiy9+QtspmSgM7jtZJMthXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbB_jrsgEMH=HNozW+rASRLwiy9+QtspmSgM7jtZJMthXg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7cbfd1-3f0f-4445-a558-08ddf1f2f70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzBiS2FaQm0xd0J2ODBmLzJ5UzVjbUEzcWhLZDBpRmZBUTAvZGxqRUh0STNs?=
 =?utf-8?B?dnhPT1ErZ1lIWnNQNm8zY2JubktYL2Q0Q3BPcHFDRHdSNnRoWWFEb0VOck52?=
 =?utf-8?B?NzlMNGMrRjRjcEgyTGpUUkVqeUkyTExsRzE4bGozWkd4eXltdjlnQklxTnZX?=
 =?utf-8?B?Mk04ZE5LTHRWQlUzbzhsZGdZMkdCU3gvUzVZMVZNdWNrNXplc0d3T1VIejQy?=
 =?utf-8?B?OE04LzJkZ1NPNi9lWElqN2pLcTluV3ZtNTV0M2JHemNyUjY2K05QUTRhNkNE?=
 =?utf-8?B?akdoQ2xxZTI4MjZ6MTRGb2hrb1JOZmEzYVpEcE9zcWtYV2wwdC9tb3VZMmhK?=
 =?utf-8?B?T05tZklFVmgyZFJvbFU2VXdqdHh4Z1BaK0R0SmlBenZoeHFxV2JKaUVsZWt0?=
 =?utf-8?B?QWViSUFFN2FNU09ra1VNczgzb3BDQUpaUkxQQkV1Zkw0anBsM2wvOVcwNk1G?=
 =?utf-8?B?dlVDTWVZRFgvZGRVSGs4MTR4dUlmdEhBS1lDQWYrN2hSaFlmdVRGVmR2U2Uv?=
 =?utf-8?B?ejZlVnMycGE4dG1aNzZtd0xIWFNGOTIyMDJlMjRTZThSNTJHS0FZOTJJUDlz?=
 =?utf-8?B?R1lUMHFYQjV3VzZPM0RtU0FqRE1oaHJHbnVRYzFJanNrQld2VUpKZ1Y5MDha?=
 =?utf-8?B?Q0o4TSs0bXVrZXBndW9ma0xGUTlqRCt0eHlTdmIwQVBtekhTVklwZGE2elVT?=
 =?utf-8?B?ODhaQUlERE9rK1pHSVBPYmxsS0xjc01IZHVVQnVJQzN4d2ZMNEJMbFF0L1ZP?=
 =?utf-8?B?d3RtaHphNlludHlod2JqRSs2K3ZwOWZtd1JWUUZ0TE5jVVRVcUw1UFJDL0Zv?=
 =?utf-8?B?eHpzdEUvM1UzRFFaWGtVVU1Qb0dHSmFiUWR3Nnd1cEh0QXFGcUtnYzkvcWJC?=
 =?utf-8?B?Nm1YaWZ3YW9EUXNQSFhuSlR1cWpkdm9yMVhmRkFxaERtQmpGb2JqSEx1YWtM?=
 =?utf-8?B?RDlLM0RTTDlCT2I3Ty9FTXRFcHVEUCtXdHFpSE1UVU1lUWRva2wwOVBlSHVy?=
 =?utf-8?B?UzRVTVJRWjZ2QnNQWVNVL3NXRjF2VW44OWR6TVBUM1phNTM0UXJMVjdsa3Z4?=
 =?utf-8?B?WHhWdDU1N0s0MS91RDJNamVYS01hMGJmTlBrempvT1Q3VmZ5RkxHNEVlWUR5?=
 =?utf-8?B?S0ZJcmtqQm95NzI1RGN2c2Z2dHBpWDRRaEt3Rk5iUmxPRGxJYmt3TEUyWUZ3?=
 =?utf-8?B?b3ZJbzBuWU0rRnhCOHpUZlRjbC9pWW9VZEpDbDZ2Qkp3ZzBwRVVrWEl5MHJK?=
 =?utf-8?B?Wlh1QnptVFJuOEk5K3pXemhlNWZBMkludmduZ0dVcExQYkJrenV5U1hTVUx3?=
 =?utf-8?B?SUNPZWZMZFBvdGczVUNmZng3RlMrWGFRYXdpQ0luTXdhWTRjS1Z2UkplelNX?=
 =?utf-8?B?eEFqN2dEU2tyWkVkZ2ZyMVhmazBPdVVNbzNkcXVKK3REbDBNTFhqNGlxaDJs?=
 =?utf-8?B?ZU5DZksvSmxSWTk2YW95UW9DbFR4T0MvQURsY0NjRFhxeXNXL3RJOWZSRjgz?=
 =?utf-8?B?UzFodEo2c3VadlRuenBUU1V1RDJBRXZSQXpSZHFCT0g5L2VWZmFOVGIzV1RK?=
 =?utf-8?B?N215elUwcDBUZHlFV1hxdFRYM1ZtcW9DSFNZWk1CWVVHazRBcEw0NytXSy8w?=
 =?utf-8?B?K0o1aVRLTC90ZUs0c2wvdkZGWEpMUEVKWVBRS05lK3NsNWlobmhxVFQxNXE3?=
 =?utf-8?B?M3ZvQTgxbVRNNkRVS2M5Z3AyNXg0Q0JhSzhOdC9yU0xpZDdHRzU4eFJ5cllh?=
 =?utf-8?B?WXpxUEMyUHJmU1phVnN3L3VZYURMVHUxKzNFMW1kSDdqUHNpT0s0ZHZ1UHg2?=
 =?utf-8?B?YzN2Qk4rRHA5a3RXSEpmSzVoU0s3eG5UNXdSMldZRWdVK0IwTlhQREtWeFZZ?=
 =?utf-8?B?R3ZyY3EvNlBqd2Rod2l6cGVXT1pjOEkwSmx1TEUzWHA1M01Ra2p3YjVqY0xt?=
 =?utf-8?Q?Q8eGx8K4s0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tll4T2d5L3hNNVZLNmQrNUpMQUhnMktVdlNFWWExYmZJK2RQcWUwWGNZOVhR?=
 =?utf-8?B?S3ByWWRUVUFMeWZxNUVCTk1xYzZjME1SV0V3ZWNFMmN0MkR4QncwMjZwV01G?=
 =?utf-8?B?L2lJdnNHV2tNb2wraWxzbk11RG1jM1hUOHNXVHNxWThnUTZIVHZoNWZyWWtO?=
 =?utf-8?B?amZvclg2NmZzYko4RFNjUE50c0cwMjlQbnB2MnNOOEordkMrZ2puWVJYTzZ1?=
 =?utf-8?B?dnl6UHN3VDEzMStaazRtUXFSL3F1dnB4TVF4bHg5YTJQNHNzM0tPZDQxeEJO?=
 =?utf-8?B?MTN0endXZ1QzRGtpcHo2UXRLcHJCNHZ0WmtlWEpXMDZ5aGZIMVRnQktSQit2?=
 =?utf-8?B?NXdGOEx4blg2OWlvQTh0QkNXeXN3bzlxQ1JwbW5oK0ZKMEJJL1ZRbm9PZWV1?=
 =?utf-8?B?RUQ3KzBTQkQxZEFoOXNDclV3cHV6L1VWZVdmK0toVTJ6MVhyOEdQWGdnQmRO?=
 =?utf-8?B?Znordll6bnRudTByZFYzRnB0R0tCS3VZZzFuL2tBVFBnWHhKbnA4OFVtUkJq?=
 =?utf-8?B?S3p6YXBHdytsQWhhUUorS2wwdWk2SzhlMk5hY0RRMWRDc3hZVXk4a1BqOUV2?=
 =?utf-8?B?VG50QU5HUXY4UlhLL0ZIdkg0amVBbmVXTFAvUlJFNG55MzdJUlZYRjd6KzJj?=
 =?utf-8?B?MmlMM05vTmxYaEpIZnNoeWk0VlBQWkV6bm9WMGhUSDJteWc4NEZua3lhN1VP?=
 =?utf-8?B?YWxSY0hxYjY1NHp6dTBXVEh3RFhZTTJpak5vYVZuNlhuemNhTUNQWG1vb3dw?=
 =?utf-8?B?RTRjcEIrWk83Z21UZCszOXY2dC80NkdDb0VoMzduMmdwY093ejVGQkRDNFVi?=
 =?utf-8?B?TitqMVp6WmM5Y3R6RDI3dmpHbys4S1Yzd2paQ2NnNTI2Zis4WnhKdVFQaVJG?=
 =?utf-8?B?ZCtta2hkd2NWVFFlekUrdm92cnc0YWgwR3JWcHdVTDlOZGVWQ2dNSVNvbllG?=
 =?utf-8?B?cGtOL295N0VtaUdhT0FwNmtoYmwweENJcVA3allFZThSSmNoTHJPREhLL0V2?=
 =?utf-8?B?bDJZakFXRWNtVUtGRnZqQ2tMV2pkcCs1VlZ2eHBkZGp5SS9vYjZEMCt2UUpm?=
 =?utf-8?B?a0dqYmtjQytDKzEyMWdwRmpVczhvOGZvTmlIWWtHVTlteGE5aldkeFVyaXlS?=
 =?utf-8?B?NEtxKy8vMVhOWExBZm9CaFVrb096Zk5ObXBxUzVmeFFhdURWRVMwZzV2cm9t?=
 =?utf-8?B?RGpkV3VpTnRqRFVneEJ2ZWd6dWtJUXVqMEV5ZmgyZEw4WW15NVgyL3UySFdr?=
 =?utf-8?B?K0hlYVJtc0lKMmltQVRrSVpYdW5DUnRsUFZtSDFlV09RWFc1WUxBWnR0NXlX?=
 =?utf-8?B?Yll2eStJREc0MGJZV21lRVQwRmtuajFpc2NSUkJoTTdjZk9lbUdHMFhKS29k?=
 =?utf-8?B?WVcvZ0tOVWtHelh5WnJnaXZuNndKSlh5MWJ0clNCVWViTXozVnJLbnNyNnJS?=
 =?utf-8?B?QzZuVGlteExqejBWRDY2UXV3b29VYTJjVDNiNDBXNWExUGdzV25lMzRydTNY?=
 =?utf-8?B?Vm1OSXlHYUlaN2xBc0NvbGJZc0ZRbUZWYVF0SGxZZkNVRTR6dUlOS1EwV05v?=
 =?utf-8?B?VFAwR3U4WGRnNDU5VWl0NlBJMHNkM1l4NGJUQmFSeHFySEpMV0VyNDhoRWgr?=
 =?utf-8?B?bStnVUJvTElrdWQ4NWdseFdxd3A5YURZS1kxTVdrWGtiazFibEdWc0ZOZ0hD?=
 =?utf-8?B?cW5ZN1FIYWt2djRuYzNYaStEWnZXalZNdDAyaVlDTEN3cEI5bUlneFBIVVpY?=
 =?utf-8?B?dFhJcCtCeGNxSDB0T0xJM0g0MDU1V1RnNkp4QU5wSTBOVWJLcC9qR09BeEhD?=
 =?utf-8?B?L05pUU5jUGRaVGJ6elNicTJXM25ubTlNTjhFR2VJVEV3WFgwZU9nRGd6dkNm?=
 =?utf-8?B?anJaSWVWWnd2eFVKZ2lORGJGRjI0eXo5RGlXQ29pQ0haakRud2pmVU1xNFRn?=
 =?utf-8?B?RitUQ2Z3SjF4ZXM1MEVrb3o3NGlqVEdiYzNNek9TRzRzaHdZejI5N29qUzBD?=
 =?utf-8?B?SFFnUU9kblNUby9ZYVBPWnBYZE1hL0VGYVlKMGEvUERpWjBucW1lRnNUNWRz?=
 =?utf-8?B?UGpNeG03MmoxZFRNWElOOGJHNzlBck40WUhWWiswa0cvUGNtUEloYVM2VDZE?=
 =?utf-8?B?cWFvbk5NUkJJbVlHVW1BTngzRjE5U3ZrVzg2V0dXSStTWVNPUlRiZ051OW42?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j3UPaMKXKsOvlZxJ34x/66V/8WRiL3RbECIXKTPYtmBZe7zpUdn3rRTHfWUew+bvXi5ZwDBuimJETICwg237jvW9QSBRvriw5wpCquf9lE4eWIqhoVgvFxeK4WEJH7dJp0G65sfIF76c/oTDuIYZ4JdEQUytbnLY3VCHwN+zbnId0Rt7Vdyzo5JKi1M453ytflBp41mm/0NKwLBIKlXyO05HKdOFr2eRocMJl+Ba3VsFCdRqqIXxrTUoUxAn8wu8whc2QBsW0tljE/Omzbivqk7K7aVj3NZJXueD0zaYYkBdWt0w/qhL7CtwKaMBywb8V74i57TiW+Xdn+xFHiaZQLrSv2RX/PAgOdCh/9hS+o9HVTjnoYcZdBfv6NN/k+vvYTrYpU+ELaNxIx6uVue+i/4/TQ6rGvrIZUaXJ9FmwJcMJuiL/Wo7ytzeuJEHtVZMeBGoM1MypQs9Su52XJMHpQAT5g9kj8kSABdiKMqEA7dTbS22EKZIfNSShjipTtyWFeN+lslld+bsuwy7rDhctz88YiZj51l3bSyiJgFuNl03lBUK464UPh43y7X3ZbB1A7aB6sRikCA9oB3jFoOIUyK3/Chef5SwhMB+V8bd998=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7cbfd1-3f0f-4445-a558-08ddf1f2f70f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:53:18.7551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoSMuS3Ujz+W80Vt8/Q+s4VsNVbfOZuzSNQlJ78ROkXCmhY6PjIYUDVACnZ8U/vE7tuK8z/Kwvb6HLC667M9Pcw0Fnuox4n4QtRSkVlqXpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509120113
X-Proofpoint-ORIG-GUID: FVkqXwzYa9vNZrCYR86IY6aAh7w0NDW0
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c409c2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=pGLkceISAAAA:8 a=7jsIJN_k1NIrg7aAyJkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FVkqXwzYa9vNZrCYR86IY6aAh7w0NDW0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX5wWkv8bkB3q0
 zG6qHel4dJdhZncUvktcg5tBmsWHKdsDF3yqJHBr213Qn+286O5taAEek7TV/4jYj1OSTxE5GQu
 wYBJ2cCqjfM23TctcxDlL4FPMDFIR2q+YNvLgf6Jn0o6G4XvTnDD80OYrllr5W82JWVm7MhVwA6
 1YoCT/JKnTW/wOI8qTpktvYAMd/rqRv5TSOLoQB++kLMXwP4f5pj/b47J9ERUhb55Ghj94OvFgA
 V6+eovqz3Ak2d4rCcOuAuFfvUynz4UL/PGqnPL3jjR+MGZbEpyECxtbfepBKEXScW6c3owzm4/e
 g2Sftx/NrQRpoxQPH0BSj7/VNxOXapbnekPF4I+bgKl24FePrqWcz15nPOkvQjTXnmIV6lYrZZw
 uDkXWiKZ

On Fri, Sep 12, 2025 at 04:28:46PM +0800, Yafang Shao wrote:
> On Thu, Sep 11, 2025 at 10:34 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Sep 10, 2025 at 10:44:39AM +0800, Yafang Shao wrote:
> > > This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
> > > THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
> > > programs to influence THP order selection based on factors such as:
> > > - Workload identity
> > >   For example, workloads running in specific containers or cgroups.
> > > - Allocation context
> > >   Whether the allocation occurs during a page fault, khugepaged, swap or
> > >   other paths.
> > > - VMA's memory advice settings
> > >   MADV_HUGEPAGE or MADV_NOHUGEPAGE
> > > - Memory pressure
> > >   PSI system data or associated cgroup PSI metrics
> > >
> > > The kernel API of this new BPF hook is as follows,
> > >
> > > /**
> > >  * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
> > >  * @vma: vm_area_struct associated with the THP allocation
> > >  * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
> > >  *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
> > >  *            neither is set.
> > >  * @tva_type: TVA type for current @vma
> > >  * @orders: Bitmask of requested THP orders for this allocation
> > >  *          - PMD-mapped allocation if PMD_ORDER is set
> > >  *          - mTHP allocation otherwise
> > >  *
> > >  * Return: The suggested THP order from the BPF program for allocation. It will
> > >  *         not exceed the highest requested order in @orders. Return -1 to
> > >  *         indicate that the original requested @orders should remain unchanged.
> > >  */
> > > typedef int thp_order_fn_t(struct vm_area_struct *vma,
> > >                          enum bpf_thp_vma_type vma_type,
> > >                          enum tva_type tva_type,
> > >                          unsigned long orders);
> > >
> > > Only a single BPF program can be attached at any given time, though it can
> > > be dynamically updated to adjust the policy. The implementation supports
> > > anonymous THP, shmem THP, and mTHP, with future extensions planned for
> > > file-backed THP.
> > >
> > > This functionality is only active when system-wide THP is configured to
> > > madvise or always mode. It remains disabled in never mode. Additionally,
> > > if THP is explicitly disabled for a specific task via prctl(), this BPF
> > > functionality will also be unavailable for that task.
> > >
> > > This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to be
> > > enabled. Note that this capability is currently unstable and may undergo
> > > significant changes—including potential removal—in future kernel versions.
> >
> > Thanks for highlighting.
> >
> > >
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  MAINTAINERS             |   1 +
> > >  include/linux/huge_mm.h |  26 ++++-
> > >  mm/Kconfig              |  12 ++
> > >  mm/Makefile             |   1 +
> > >  mm/huge_memory_bpf.c    | 243 ++++++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 280 insertions(+), 3 deletions(-)
> > >  create mode 100644 mm/huge_memory_bpf.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 8fef05bc2224..d055a3c95300 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -16252,6 +16252,7 @@ F:    include/linux/huge_mm.h
> > >  F:   include/linux/khugepaged.h
> > >  F:   include/trace/events/huge_memory.h
> > >  F:   mm/huge_memory.c
> > > +F:   mm/huge_memory_bpf.c
> >
> > THanks!
> >
> > >  F:   mm/khugepaged.c
> > >  F:   mm/mm_slot.h
> > >  F:   tools/testing/selftests/mm/khugepaged.c
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index 23f124493c47..f72a5fd04e4f 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -56,6 +56,7 @@ enum transparent_hugepage_flag {
> > >       TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
> > >       TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
> > >       TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> > > +     TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached */
> > >  };
> > >
> > >  struct kobject;
> > > @@ -270,6 +271,19 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> > >                                        enum tva_type type,
> > >                                        unsigned long orders);
> > >
> > > +#ifdef CONFIG_BPF_GET_THP_ORDER
> > > +unsigned long
> > > +bpf_hook_thp_get_orders(struct vm_area_struct *vma, vm_flags_t vma_flags,
> > > +                     enum tva_type type, unsigned long orders);
> >
> > Thanks for renaming!
> >
> > > +#else
> > > +static inline unsigned long
> > > +bpf_hook_thp_get_orders(struct vm_area_struct *vma, vm_flags_t vma_flags,
> > > +                     enum tva_type tva_flags, unsigned long orders)
> > > +{
> > > +     return orders;
> > > +}
> > > +#endif
> > > +
> > >  /**
> > >   * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
> > >   * @vma:  the vm area to check
> > > @@ -291,6 +305,12 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
> > >                                      enum tva_type type,
> > >                                      unsigned long orders)
> > >  {
> > > +     unsigned long bpf_orders;
> > > +
> > > +     bpf_orders = bpf_hook_thp_get_orders(vma, vm_flags, type, orders);
> > > +     if (!bpf_orders)
> > > +             return 0;
> >
> > I think it'd be easier to just do:
> >
> >         /* The BPF-specified order overrides which order is selected. */
> >         orders &= bpf_hook_thp_get_orders(vma, vm_flags, type, orders);
> >         if (!orders)
> >                 return 0;
>
> good suggestion!

Thanks, though this does come back to 'are we masking on orders' or not.

Obviously this is predicated on that being the case.

> > >  struct thpsize {
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index d1ed839ca710..4d89d2158f10 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -896,6 +896,18 @@ config NO_PAGE_MAPCOUNT
> > >
> > >         EXPERIMENTAL because the impact of some changes is still unclear.
> > >
> > > +config BPF_GET_THP_ORDER
> >
> > Yeah, I think we maybe need to sledgehammer this as already Lance was confused
> > as to the permenancy of this, and I feel that users might be too, even with the
> > '(EXPERIMENTAL)' bit.
> >
> > So maybe
> >
> > config BPF_GET_THP_ORDER_EXPERIMENTAL
> >
> > Just to hammer it home?
>
> ack

Thanks!

>
> >
> > > +     bool "BPF-based THP order selection (EXPERIMENTAL)"
> > > +     depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> > > +
> > > +     help
> > > +       Enable dynamic THP order selection using BPF programs. This
> > > +       experimental feature allows custom BPF logic to determine optimal
> > > +       transparent hugepage allocation sizes at runtime.
> > > +
> > > +       WARNING: This feature is unstable and may change in future kernel
> > > +       versions.
> > > +
> > >  endif # TRANSPARENT_HUGEPAGE
> > >
> > >  # simple helper to make the code a bit easier to read
> > > diff --git a/mm/Makefile b/mm/Makefile
> > > index 21abb3353550..f180332f2ad0 100644
> > > --- a/mm/Makefile
> > > +++ b/mm/Makefile
> > > @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
> > >  obj-$(CONFIG_NUMA) += memory-tiers.o
> > >  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
> > >  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> > > +obj-$(CONFIG_BPF_GET_THP_ORDER) += huge_memory_bpf.o
> > >  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
> > >  obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
> > >  obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
> > > diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> > > new file mode 100644
> > > index 000000000000..525ee22ab598
> > > --- /dev/null
> > > +++ b/mm/huge_memory_bpf.c
> > > @@ -0,0 +1,243 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * BPF-based THP policy management
> > > + *
> > > + * Author: Yafang Shao <laoar.shao@gmail.com>
> > > + */
> > > +
> > > +#include <linux/bpf.h>
> > > +#include <linux/btf.h>
> > > +#include <linux/huge_mm.h>
> > > +#include <linux/khugepaged.h>
> > > +
> > > +enum bpf_thp_vma_type {
> > > +     BPF_THP_VM_NONE = 0,
> > > +     BPF_THP_VM_HUGEPAGE,    /* VM_HUGEPAGE */
> > > +     BPF_THP_VM_NOHUGEPAGE,  /* VM_NOHUGEPAGE */
> > > +};
> >
> > I'm really not so sure how useful this is - can't a user just ascertain this
> > from the VMA flags themselves?
>
> I assume you are referring to checking flags from vma->vm_flags.
> There is an exception where we cannot use vma->vm_flags: in
> hugepage_madvise(), which calls khugepaged_enter_vma(vma, *vm_flags).
>
> At this point, the VM_HUGEPAGE flag has not been set in vma->vm_flags
> yet. Therefore, we must pass the separate *vm_flags variable.
> Perhaps we can simplify the logic with the following change?

Ugh god.

I guess this is the workaround for the vm_flags thing right.

>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 35ed4ab0d7c5..5755de80a4d7 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1425,6 +1425,8 @@ static int madvise_vma_behavior(struct
> madvise_behavior *madv_behavior)
>         VM_WARN_ON_ONCE(madv_behavior->lock_mode != MADVISE_MMAP_WRITE_LOCK);
>
>         error = madvise_update_vma(new_flags, madv_behavior);
> +       if (new_flags & VM_HUGEPAGE)
> +               khugepaged_enter_vma(vma);

Hm ok, that's not such a bad idea, though ofc this should be something like:

	if (!error && (new_flags & VM_HUGEPAGE))
		khugepaged_enter_vma(vma);

And obviously dropping this khugepaged_enter_vma() from hugepage_madvise().

>  out:
>         /*
>          * madvise() returns EAGAIN if kernel resources, such as
>
> >
> > Let's keep the interface as minimal as possible.
> >
> > > +
> > > +/**
> > > + * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
> >
> > orders -> order?
>
> ack

Thanks!

>
> >
> > > + * @vma: vm_area_struct associated with the THP allocation
> > > + * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
> > > + *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
> > > + *            neither is set.
> >
> > Obv as above let's drop this probably :)
> >
> > > + * @tva_type: TVA type for current @vma
> > > + * @orders: Bitmask of requested THP orders for this allocation
> >
> > Shouldn't requested = available?
>
> ack

Thanks!

>
> >
> > > + *          - PMD-mapped allocation if PMD_ORDER is set
> > > + *          - mTHP allocation otherwise
> >
> > Not sure these 2 points are super useful.
>
> will remove it.

Thanks!

>
> >
> > > + *
> > > + * Return: The suggested THP order from the BPF program for allocation. It will
> > > + *         not exceed the highest requested order in @orders. Return -1 to
> > > + *         indicate that the original requested @orders should remain unchanged.
> > > + */
> > > +typedef int thp_order_fn_t(struct vm_area_struct *vma,
> > > +                        enum bpf_thp_vma_type vma_type,
> > > +                        enum tva_type tva_type,
> > > +                        unsigned long orders);
> > > +
> > > +struct bpf_thp_ops {
> > > +     thp_order_fn_t __rcu *thp_get_order;
> > > +};
> > > +
> > > +static struct bpf_thp_ops bpf_thp;
> > > +static DEFINE_SPINLOCK(thp_ops_lock);
> > > +
> > > +/*
> > > + * Returns the original @orders if no BPF program is attached or if the
> > > + * suggested order is invalid.
> > > + */
> > > +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> > > +                                   vm_flags_t vma_flags,
> > > +                                   enum tva_type tva_type,
> > > +                                   unsigned long orders)
> > > +{
> > > +     thp_order_fn_t *bpf_hook_thp_get_order;
> > > +     unsigned long thp_orders = orders;
> > > +     enum bpf_thp_vma_type vma_type;
> > > +     int thp_order;
> > > +
> > > +     /* No BPF program is attached */
> > > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > > +                   &transparent_hugepage_flags))
> > > +             return orders;
> > > +
> > > +     if (vma_flags & VM_HUGEPAGE)
> > > +             vma_type = BPF_THP_VM_HUGEPAGE;
> > > +     else if (vma_flags & VM_NOHUGEPAGE)
> > > +             vma_type = BPF_THP_VM_NOHUGEPAGE;
> > > +     else
> > > +             vma_type = BPF_THP_VM_NONE;
> >
> > As per above, not sure this is all that useful.
> >
> > > +
> > > +     rcu_read_lock();
> > > +     bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
> > > +     if (!bpf_hook_thp_get_order)
> > > +             goto out;
> > > +
> > > +     thp_order = bpf_hook_thp_get_order(vma, vma_type, tva_type, orders);
> > > +     if (thp_order < 0)
> > > +             goto out;
> > > +     /*
> > > +      * The maximum requested order is determined by the callsite. E.g.:
> > > +      * - PMD-mapped THP uses PMD_ORDER
> > > +      * - mTHP uses (PMD_ORDER - 1)
> >
> > I don't think this is quite right, highest_order() figures out the highest set
> > bit, so mTHP can be PMD_ORDER - 1 or less (in theory ofc).
> >
> > I think we can just replace this with something simpler like - 'depending on
> > where the BPF hook is invoked, we check for either PMD order or mTHP orders
> > (less than PMD order)' or something.
>
> ack

Thanks!

>
> >
> > > +      *
> > > +      * We must respect this upper bound to avoid undefined behavior. So the
> > > +      * highest suggested order can't exceed the highest requested order.
> > > +      */
> >
> > I think this sentence is also unnecessary.
>
> will remove it.

Thanks!

>
> --
> Regards
> Yafang

Cheers, Lorenzo

