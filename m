Return-Path: <bpf+bounces-38706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EEC968A85
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 17:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D4FB221CE
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D71CB520;
	Mon,  2 Sep 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zxi1AlC/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YjXrIpKO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4B1CB516;
	Mon,  2 Sep 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289196; cv=fail; b=QTU60lbGe4VnnNUSVZF3ARzL8Pysj6rF3DUjTXC8YNm05th0/gz1nnS13Zl6KM6I1CD9cZVf7I4tuNSsSmJ1uBteM6+pg+cifzS3LZIgdgpdMTbPWTkgp5m4Uu0vT2SmeAppFEv//NorYbftaMFQH+nWpmfgMq5Fs6/WikhTro0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289196; c=relaxed/simple;
	bh=F+MeOf6+qLCg1wN5g3qfGI4S/uxSht1kYkKjCs4L2JI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MIjLyKLpvpVy1h5wfyBJgJIVdEcZ26tr3Pex5Xc/tjeFeh1Jb3Cpa0jyMVYK5jQKh9omT9nr52WM86UXW6db7ifBwedZedCrZKFTXeBHHtdjavmB6KhgjWn9M1Ek9dnpflVWGioGs7C2OKGv1uGGDMD9EIEQ/zfZP+6seVL9DpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zxi1AlC/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YjXrIpKO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482D9n4G011970;
	Mon, 2 Sep 2024 14:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Oc7/iZrQWJNzYWYehQSrIM5n5TCmZtqOWB0eVZvZNjI=; b=
	Zxi1AlC/MKfXp9Zbcu87EvUb8hlFeuDY7I+FXRJ2ZqylproLMX0jkLvqQZ58wCgz
	lzmsn7W+qLvZAJ+OQl4W0WqFrpN+Sfm+6mBBw9o7M88guTWaKHDle3YvPwF7pKzm
	RzbZWU5himtIgo0X99gnLv6LmUyZ0pwUdxkuhnaWOWVsH8kkzQ7n/M+G3Mu7Uqn5
	TC51kD1yJGB4hmS9X55dEmcMChfiaVUxwV7UEXMmdAisH0triAofheioGnmZT0O0
	ZnjVy3nVs4fLDAg+0/gIXnURFYsHmoQVJ9lDL7Q1jXjYbLhHnqAP0HHwMVX+lBLE
	OHT4wVeuq2haaGxpJfkQ3Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dcth8b5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 14:59:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 482ELWAT023697;
	Mon, 2 Sep 2024 14:59:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm78qf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 14:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZB4gd4YZ7a9LFmGtlv3jyEv4igfSNWQD9q3fmwaS6goYpwpf6ttMSmd18AOLQE+Siqo7ZazChGZu7P25dCyXwmLYK1W+REZdGPMsIqJ8PGi/MpcGyctrulV3wV6eTvgiCTeBzeua1M4dG1eugWQLjJLuI331v3DGtPqLlWCpF5z3sh0Q0t7p08SlNA4U2VjyOAe/WolaKzh6IS4F1wV1PvEp/uQ+fsPlkGcOq1kC8cB/wgPA4QcNqRjvf2eY79Fzn0CsSM8fZ6y3C4yi+bJZBgDl3TDXK60VddROrE5GiDf9W0NjUz1Is2c8zO/lBIqB22VHLi5rld9OnrmPsR0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oc7/iZrQWJNzYWYehQSrIM5n5TCmZtqOWB0eVZvZNjI=;
 b=a2lQe47vIugrZQVNIQh7Oj2UK5P6a6RO62XSeTOUFpbfco0xmQQLxNq5nt7/M5YO3BlYGe+HDDd+7u5810CX78uHwytTBjZeTafKPypQV0ykuVOUM/6h1AqRlGEvTEiYw/jg9LD0/EzpFKFJMam7pWec1aru2QvYEBmzC+xQGs3SqnuliONokqPKQaQusslHZ/QMCXKG0pJKg7RPni0eumqZL6nqpDiiIN7qPUVOBnXAuMfYPeqx6n70YNII+vTOXVA/oDHVID4vl8QRtajutAaLbTe7ZgBmIkpFx3Gyu2qBRf8vIcsn20qIAK7MB8qIIVe3Qp67RFyhURxXq5Cqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oc7/iZrQWJNzYWYehQSrIM5n5TCmZtqOWB0eVZvZNjI=;
 b=YjXrIpKOiDVPHiuGfdmoLjB8asSw/t5ymPfbzx8j6m15x4rndOKSOpDbLtPtDHJreuDcmYZ3sVraj8Jm3bBRJalbTBIbsRZdeBlZ9lDpwkAEJ+J9sHCoHQ/LlXbLuKh9tVfpqcae5kBrBauP6WH3fBUufj5LSd/K5Bl7j0SbXuU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BY5PR10MB4385.namprd10.prod.outlook.com (2603:10b6:a03:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 14:59:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 14:59:41 +0000
Message-ID: <ab553623-0e0a-496d-a2d8-6fd23de458b0@oracle.com>
Date: Mon, 2 Sep 2024 15:59:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Song Liu <songliubraving@meta.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
 <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com> <ZtHG9YwwG5kwiRFt@x1>
 <CAEf4Bza9OJckdJ4=nask2m+bJsiDszvoLoaf+GhVFu8CNarb=g@mail.gmail.com>
 <ZtIwXdl_WyYmdLFx@x1>
 <CAEf4BzY5kx9HayBCViuXf0i7DyvFgcRObvnA1u3bqot2WjfyGg@mail.gmail.com>
 <2bd94dc7-172f-49c0-87c8-e3c51c840082@oracle.com> <ZtXG8TTMXTzXUkRg@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZtXG8TTMXTzXUkRg@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0034.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::21) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BY5PR10MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd48b18-f540-450c-0430-08dccb5fdfd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tkx5QjNZNS8zbU1nZUxjWmFxMlRiekR1cGlZYkYrcklKbTVwSWE4WVdaUksw?=
 =?utf-8?B?MHpqV2srV1pPNHYxQ3pQS0NuQzVUVFU3Qy9YVmgySXBWMWJPMktPcTdyNEJD?=
 =?utf-8?B?M25JTTh4a1NtVVNwTUt3SjlSaFJ4Q2ZNOUZEVjQvcVBoRmdQN0hleDluM1I2?=
 =?utf-8?B?YVFYVmVzNDVKODI1cjNaeEkrbWRCOUd6NjFNVllVeklLcVBabTdRVlBrK2dt?=
 =?utf-8?B?YnJvTTdFd2c5dUhPemh0ODIwRWNlanMrUlkvZEpTTUpPWGUrcTNmK2Z3WXM3?=
 =?utf-8?B?OU0xTWk5eWxxSW5ZL3pZSWx6NFJWTHdkQU4zV2gvRktzbDdhNUYyL0JKVE9L?=
 =?utf-8?B?bmg5RnFrSk9ZL0VnY3pITlBOVjA0eTljaWd4Nmx2K1lDVmRUMk1yNmtSeDRa?=
 =?utf-8?B?bkZQdzR1K0xvZjF6M0l4dmZ4cjNjZm94NmRhcUFRalZFamdtZ21iN1g0QjRu?=
 =?utf-8?B?OWJXM09UQUZNdENmSjA0LzgxQkZ4Qy93OW5MOEFCNERYc2RIYjJ4YzJpa09l?=
 =?utf-8?B?dFNVbWJhYnF5NVJHQXhSY0pXZ3lCRmZNTGgvbGdaNUJkVXRFNmhXRDVkVXJU?=
 =?utf-8?B?WU9RemxUNHlLRzVzVjhYVWFsUGtFNjBWR1l0MGt6cHpxQVQyMWUrUDVLZlUv?=
 =?utf-8?B?S0w3eEZuaVgvc243UjlLemhhV0hhOW9BOHlFcVVLSG0zOXNGTVc3VmhWNDRu?=
 =?utf-8?B?YTdCc3NaN1NaZzVZSFhNTURpekwzOWtiNmJZdmhHWjNHUmNBMmloZHN3VUg2?=
 =?utf-8?B?L0tYZjJhMmc1STlOWFB1aExoNmxXa0l4NGpqODRnTWxtdE5aQjlvYjJubjdG?=
 =?utf-8?B?WFNzM2lnemVEWnhvRi9hNGUyT0F0VCt2T09qbzBVLzJZd2VuTFpLbllBb3I1?=
 =?utf-8?B?MnJKdGR0UGFrc3psaTBxcUVla0lRVU5DWGVkY01OS3E0T0lMTmZuNjJ6OXZB?=
 =?utf-8?B?cnhjRXplcUVQand1MEM2VnpPVDBXaGd0WDAwNS9BRklSQTB6eHMxbnRUVmNX?=
 =?utf-8?B?Y1dLUXgxSytudHdZak4zN3BmNHBJaWRiS09jNmV1eEVIWHRRSWIvTkZuOVVu?=
 =?utf-8?B?RThROTMwaXdFTDdjL1lvbzJaRG9ocVpEajh0bldWNzM2a29QMWtMTkZjOU81?=
 =?utf-8?B?TDByQURHczJJcWlScFJEWU16RTJKRERiWjlMWEtzY0NmSGlLc2txbDJEYzE3?=
 =?utf-8?B?cFdYS3dRRXpkTXlWclpZWXZoTG1HQnNGZnRUeGc0NHg1SC9mTXJrYzZGdWE1?=
 =?utf-8?B?RHN0bnA5bGpNTU1aQWY5YTRyRW53bUU3dTdtekRyUXdDTWhvNUpjbTl6Tkk3?=
 =?utf-8?B?M0NvUzNwMzc5cE5QZ2pGdnZCc3FaTVdFVGlJb3kwK2JJa2ZFU2pKbWZUTjBG?=
 =?utf-8?B?VUU3ZWJLb253NEpLWDhDSGI5NDMxdFlLbk9YZE9SUm5oaUE1eTdlZ0tibysr?=
 =?utf-8?B?V2diK1hwU2w5alVUS3JPek4zdkJmdnd6UWI4bjhmSENjTDZYMFJUZVN3Z1cz?=
 =?utf-8?B?RHMwK3NXMUMwWG9tMFdIeHptTjlWbjJ0TzFiaFhkSU5sREFTK2dCdG5ITCsr?=
 =?utf-8?B?bmJYSHUvTnFLYkVWeHcvTHlLSWtsU1BucWJyU1VMNmJBY0E3Mk4yQlVWdUFI?=
 =?utf-8?B?QmtnMTlsN2tzVzFUbXkwanFOVTF4aWMvQ0M1T3pJc2k1clY0cHFGeDFYeVdP?=
 =?utf-8?B?eFBDR1pVbVoxekQwMXdaZzZkcGI0cnY2QklxWHEvaWM0L3I4RDhod3VrZEE2?=
 =?utf-8?B?aENFWjN6V21rcnN5NU9FZnhSbUdKdERVUlk4Nm1YWWdZcjZPUFdNdFVQNngx?=
 =?utf-8?Q?1MiBb1D9RU+wkjSKcuE8Mku+F0Kht7mTGkVIk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDhWQmIzT2tncEYrTlNhTkczcDhydjZNU0tkWDNWZkgwekN4MVp4TU5zVVpO?=
 =?utf-8?B?cURYOHRFL1QxUWNGK1ZnRm8zZGVJdTdqVk1tOXBDVFhwdkkrMFkrZEVZLytW?=
 =?utf-8?B?U2VBcy81OWlaaXNFWEVOTDg1STdTWDRhdDQ1T25kaVZJMFFIaEF4VmZ5NWY2?=
 =?utf-8?B?dC9XNjE1eEY5TEZhRldkOUR5ZUh6aGtYdEpDU3dtTnh1a1BEdzllVWhCZDhl?=
 =?utf-8?B?cjNxeTRvWmgxa3VTeVpqUXhoZWw3NFZRRTNtS0xXVWNWTU5jbTdRT2Q4ajhq?=
 =?utf-8?B?c0lhZjZ1c3lDdGMrYlJYMXpRbFozRE5vUUNzN2pudGxScGlGTWxBM2o4ckFD?=
 =?utf-8?B?azlmYnVnYndDQXh2K1NndzhMZDBzTzY2Y1JZbEpWMEkwUmNqb2J4bDNGSXBt?=
 =?utf-8?B?TFg0UjY4aFoyQ2kydDJwQ0pkZjlWZzZEQVN3TWxHMVV1dUg5SHBteXdiaXho?=
 =?utf-8?B?VXFmVlEvTkNFUnVTL2oxTWU3cWlhUmdLT1c2NU8xTWJNWVN0Q01ibWJESTBm?=
 =?utf-8?B?Y0VCSUdUOHB0SlZseHJnVDZlc3U1WTJGTzFwdnR2QU9GdTRkQ1VaMVUyRzk1?=
 =?utf-8?B?SVcxdStXWUtDT0F5b0JueGt5Z0NTM0NsTEs0ZmU2VXgrMmRxZGV2dHplYzEy?=
 =?utf-8?B?R1ZYTWprakt5NW9XVkNHdFRnSHpWeS9hSlpySXVTTjE0S2VGS2VJU1lyOHF0?=
 =?utf-8?B?ZWRYb2dQN3JxblloMVVGbDROdit3aFphSHI2U1Z6alpzanJGMUNHcUJHTzZW?=
 =?utf-8?B?NEI0MmZkamxPQWpmSmg5SmNvV085Yy8yZFVockVOcWRrbjdodzhXTEhYNXND?=
 =?utf-8?B?Z2pkYjV6VzJYallPeEFUU0phaDBpZVVaajlOU1dBRWF1alhUaWdhM3NsQXVQ?=
 =?utf-8?B?dHB3a2JwUG8weFViSUtKKzVjNExMY2RaeEpXNFNDb3FsYmErR3dhZnRXYjdQ?=
 =?utf-8?B?dHVXRk54aVhqbWVIMlpJWk0wMWtSNEw5SE84V01DWjZJOWtiM2FsWTlzT0JM?=
 =?utf-8?B?L0NIWElNRGVkMXlwSlI4WnQ2MXVySEt1aU92cTNyL0FDSUdyYlJFWUxmRjhp?=
 =?utf-8?B?Tkpmc3grWUwxQTU1VU95TEhILzdFak1CdVI2YzhPT21ubDB0cWg1VUJhZ2E3?=
 =?utf-8?B?ZUJSRGtlNEkwMUF0MFgwZU96aCt2dmtGWDdQVXFuNDRmdzhMdk5ZTUU4RHdj?=
 =?utf-8?B?dEdXMUdPYmNSK2svcm15blZZNVQ4dU4wUWRVOTZ3eWk4L09IMC9wYlluYU5I?=
 =?utf-8?B?RloxN1BiMkUrNnFGYnNKdkRCVGYyS21LWURldnR2QWpqTFV6ZDlLR0VFd2kw?=
 =?utf-8?B?MHBKNkFsUnJ4UStWeHZaOWpPQlpXNHJGRHVzVEswRnFqd0lqRTlRaFRNRU5B?=
 =?utf-8?B?dm8rbWJ2QzFydlpDbXdzdmZjVDR4dERzYXFHbDdkeHRnMGhoWmY1VDNBUlVX?=
 =?utf-8?B?RG5rWEwyN2Q2Mm9jcWgyL1ErQko1THJwOTM1T1RDV3lTa0ZyWGM1dWxFcEhl?=
 =?utf-8?B?TWZjbURvNjhmZHFJMVE2ZmFYc2dvVjNFcTVUS2l2am1RWXVkRVpRRGp4czNq?=
 =?utf-8?B?TmJaZTVzMnBWcmZ6WjcxNXpNS1orcUhZd1N5cU81N0ZtUmJJd2lXZmtqWDhR?=
 =?utf-8?B?ZEZxbjgwQXRrdXh5WnFHWWxHYU8rMTcrRk9qOU9XTkFxanFZbTNjanJuZW5h?=
 =?utf-8?B?a21ScytOc09DRUp1a2YvVm5hc00rUjJlU1J5RWt4aWNiVTJYTW15V0VJYS9F?=
 =?utf-8?B?VW44ejlUbGZRSWJ4Y1A3bUNoNGFGaG5xUVh0S1ZBbmlqRHBVaUFMeHlDRXl6?=
 =?utf-8?B?ZVZZY1RNQXJEVHF2QnFHS1JVcDJHeUg3QU50NWN1Q1hsVDNjS2o5eWtXUlJ5?=
 =?utf-8?B?T0FRK3hIa0lVSzh1YjBuY0haTHFLMHJhU3FOQ1E3bVpDUElwVGJVVzl2U2E0?=
 =?utf-8?B?bUlvbnVrSEdNdnRXem5PQlBZR3NYVC8vZzZkeHFlc1l3dzRtRDBuSjR4akto?=
 =?utf-8?B?RU1CNVQxZjNVYzJnOUovWlJUYnVQMGtCTXZSeVRlMm1qZngxak5NNnF3M2la?=
 =?utf-8?B?MWhraFFYcnc4d2liZTREQ01ISzhQY1BBVEhEV1J0MUFWVWpuZ1pGV2Zpa2RB?=
 =?utf-8?B?WGtYZmZTaFVLakRocklPeThZZ1NWNG5FNCtncWpQU2RhdWlJU0NCSnIrWndM?=
 =?utf-8?Q?OaJmcEld93aBufylhqxrTLs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X9/7zVoBzJjWQVX2/i9IPsZFZg/vZGSCdhLugUeBb/q4IMCh1TdXeWhctAHHbDm0xZ9Ix9u4Ljt/dkwyuR2dqMsMC8NL8jepnT4keI8ATuRn1xWz6tGRBFm8nrvq7k5qwuZQm9IuARmpy3Cf4Uj6DT6nFN5DGgaZ3b+YO3Yu/+QqLer4GYH1uBFDFvdUB6DBNbqaH3Yti+daEMnK65yd2yZnsSm8BD7PVtNbHuJMsyf3otpZoNZIR00ZOimj+7cpW90mLdKfNNtpTu13IiJdZehlEELm7Ec8HbNTdpyGLaE0KW5Jf7Md/phwoSngybLieIlcBWNfMW1uKx4NsHsvPfN+ccK0eycomiHCUqJlVf+rhWVqBM7uuYt5WXCj+U/GUjYKioQ93bBfrLMd0slqmCmt45+7JVPuzUWvbuuOwb9L2/IPgoy94rUuNYWfypJkG3w2ut+ThYB/YePgg01ufyYFZOcWYPRjnac3dMWyRYSW3IEX6S0QC6GPabvjsBdl8xcKyDWiJl03hEnLdqR1vYoybxdbbyVUtArcPnnZAluAOKrIPADUA8sEXwrf5TltzA0G6tJtG047kdMLnIuhmlQIW9ft88i7XGFQ5195uDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd48b18-f540-450c-0430-08dccb5fdfd6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 14:59:41.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZfUMvvMfaeowhJr6j5I5vbRF7MevFtGwbOoM1sM/R8zsSnVczyabJ6yqhWg8GZDHH6icuPOALk0PjUajnAmVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_04,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409020119
X-Proofpoint-ORIG-GUID: yVjehODG7ZjcDI41eIqpzYfYCS7jvxLN
X-Proofpoint-GUID: yVjehODG7ZjcDI41eIqpzYfYCS7jvxLN

On 02/09/2024 15:08, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 30, 2024 at 11:34:40PM +0100, Alan Maguire wrote:
>> On 30/08/2024 23:20, Andrii Nakryiko wrote:
>>> On Fri, Aug 30, 2024 at 1:49 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>> On Fri, Aug 30, 2024 at 08:56:08AM -0700, Andrii Nakryiko wrote:
>>>> +++ b/lib/bpf
>>>> @@ -1 +1 @@
>>>> -Subproject commit 6597330c45d185381900037f0130712cd326ae59
>>>> +Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
>>>> ⬢[acme@toolbox pahole]$
> 
>>>> Right?
> 
>>> Yes, and I'm doing another Github sync today.
> 
> So, I just commited this locally:
> 
> ⬢[acme@toolbox pahole]$ git show
> commit 5fd558301891d1c0456fcae79798a789b499c1f9 (HEAD -> master)
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Mon Sep 2 11:05:06 2024 -0300
> 
>     libbpf: Sync with master, i.e. what will become 1.5.0
>     
>     To pick this distilled BPF fix:
>     
>       fe28fae57a9463fbf ("libbpf: Ensure new BTF objects inherit input endianness")
>     
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/lib/bpf b/lib/bpf
> index 686f600bca59e107..caa17bdcbfc58e68 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
> +Subproject commit caa17bdcbfc58e68eaf4d017c058e6577606bf56
> ⬢[acme@toolbox pahole]$
> 
> Ack?
>

Acked-by: Alan Maguire <alan.maguire@oracle.com>

My patch for the same change crossed with your email [1], just ignore
it. Thanks!

Alan

[1]
https://lore.kernel.org/dwarves/20240902141043.177815-1-alan.maguire@oracle.com/T/#u

>>> Separate question, I think pahole supports the shared library version
>>> of libbpf, as an option, is that right? How do you guys handle missing
>>> APIs for distilled BTF in such a case?
>  
>> Good question - at present the distill-related code is conditionally
>> compiled if LIBBPF_MAJOR_VERSION >=1 and LIBBF_MINOR_VERSION >= 5; so if
>> an older shared library libbpf+headers is used, the btf_feature is
>> simply ignored as if we didn't know about it. See [1] for the relevant
>> code in btf_encoder.c. This problem doesn't arise if we're using the
>> synced libbpf.
>  
>> There might be a better way to handle this, but I think that's enough to
>> ensure we avoid compilation failures at least.
> 
> I guess this is good enough,
> 
> - Arnaldo
>  
>> [1]
>> https://github.com/acmel/dwarves/blob/fd14dc67cb6aaead553074afb4a1ddad10209892/btf_encoder.c#L1766

