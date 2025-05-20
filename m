Return-Path: <bpf+bounces-58563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C814ABDD9D
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7C450098A
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F15024A061;
	Tue, 20 May 2025 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PdI4UEOU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wn6bln3j"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D82E248F63
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750979; cv=fail; b=S9A/4goWYHkJHkoK62Q1KgGS4rPiOJhpSCgxMMF0m3PRL7PFT2lXgfmJRJbSoRO/zKnD2cgjWSjodacJoIq2YwpIZz0xp354ih78Eg2pRzxqSrbKRebkMQEixX0F1QElgGhkgT08ll+33RoBszk2AUaWlhNtFM1U2SOOUJKcA90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750979; c=relaxed/simple;
	bh=wCHAFUXoqUvHwVSBayQFUF4i55Z0LycTy20tWOsDgkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rYF0SmVQ5YSXs6bgYJg0+cTMeEnzrGKQm/JqQFIUZvDJPfO/vd8mMtiZ0YYTMDNvWiMuffuJEjeE5dUqIOfk9OfRvuJDIRIDNWkPpUt3Fy7UtUdMOxbJWBDqlAeNJ+UuEM0xjgA8wXqtXcjkmRVpqHd2tt0ST7UC6KHySexCNOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PdI4UEOU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wn6bln3j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KE7B5t024586;
	Tue, 20 May 2025 14:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wCHAFUXoqUvHwVSBayQFUF4i55Z0LycTy20tWOsDgkw=; b=
	PdI4UEOUuT87eN4ZJcAhs1/G5VUl9dDA/R5EGulom9pGsjVXpdf0aHwleXDP76mr
	5Iiv6pHl0uyutjq1mjZ3liB+NTHdbE1m9Ohqm91Jsl7+/VRnR5im5eb1PEEZvoYq
	O1WvYYMtBkQiec1NCbYT3oILzIwbfp+eojpc00mMRJPtb+XcbII3wbLvvSGFZ5eB
	ixZG8IDpJ7drMD0XwAYOKKeftIQovS2ISCEKj5GttBj2MjaKQkufAvoZkMw1Ifjk
	gUE2udotoZmFXYBQ5Q0JmP7HMX6cpn8g/dYza5FbbQ2r51ZIGn6Ba1xr6ItaysOQ
	tuADiiwieZoJOTRmICdy+w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ru7dr1nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 14:22:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KEB7Ug002494;
	Tue, 20 May 2025 14:22:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7u6fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 14:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3QNOuLcYZ4urc0+p7Cw/8SP/EBSz+1lY8xvKchaB+RGNATHa2y01uL+8/Qb20vqyXftJSV99rtgk6L8Y440ZY5YDJDsvHPvN0UbhtqJ4YGvkiQAzS28JqsAoA6EXcFG34BS3tWF3cgkNUh6SPTrQze9yB4LQcjz/MptxV1Vj8DJqF6PB6llpnCv7O+XphF/d0Q5hhD+wubUq1sdMSKk/AbVQD897tj7EmUl6Jh80R7Hql3qGldReUrWG96+REX01VQguyWJJMjrflNIcT8iU77AHKlWqxDM8S3KdIjrFxtTq/BvQ2HoZ3yxyhrr0+a/2de8rPYtlwBzGirzAmU7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCHAFUXoqUvHwVSBayQFUF4i55Z0LycTy20tWOsDgkw=;
 b=CsbK3DJqoy5jm5A7pDJ4vMTaL9Q7CDGd4AWhbhN6w+lwahlmhD8CdhVo3oCDCsF0+JQbMzSycuyfjCV0IPB3581v43IWP29We2f2JsDEoVvU4JBfLDXAI2mL7RI4BohtNCG3cNM08LyQl8ALeG3VpdPKyGZNpUtARV8//GnkMlcEeIUQF34zWKwshfVFFWyEudIv466nidmuBfKrJg5HPIEY0DobQTImbh5PfIy4A90pgJbpg+mU22RRoNPQpM+1CSs9ZQxxdlRT0mOvyqziwHBNnbOz4qz9oaSJ7BI69Roy7JTcHHl/s73Q/oAbdJfX4mHAwfIuJMiY/lr9mHezEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCHAFUXoqUvHwVSBayQFUF4i55Z0LycTy20tWOsDgkw=;
 b=wn6bln3jjjtBbLHulWbOt4ylISWWYUaxL3teJ+tKWlB1ednlPPYreLvWYMGmjRxSOBKofDV+VOwSTTm5OS+8uIIzX0U645yP9FOmDoB5FrdX7NlwUIzUdrS2b5fBMNNewadcidcRVPzdphMsug0FXYvDkaeJuUNENAz62OKrLXk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6340.namprd10.prod.outlook.com (2603:10b6:510:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 14:22:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 14:22:16 +0000
Date: Tue, 20 May 2025 15:22:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Nico Pache <npache@redhat.com>,
        akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
        usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
Message-ID: <2345b8b9-b084-4661-8b55-61fd7fc7de57@lucifer.local>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
 <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com>
 <aCx_Ngyjl3oOwJKG@casper.infradead.org>
 <CALOAHbDUmad6nHnW755P8VYf+Pk=DogW0gMH4G73TwvKodW54A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDUmad6nHnW755P8VYf+Pk=DogW0gMH4G73TwvKodW54A@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0198.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 0016b947-ae70-404a-d72c-08dd97a9b8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW93d2R2ZVhlSC83L0V0Rzc2OThQSW9IVjJWNXYxQlVIb3pLZm5ERnlXclUy?=
 =?utf-8?B?cDJxdE9pako5K1ZjMU1MZkZmaDF6Rk9nU05MbE0zYzZRUmhpMnRLTkZhTW1G?=
 =?utf-8?B?b1dxdmtlQmV6UWVVcWxtRG5vSkt0UHhQNVBoS2pBZXNsWXZMZlgwUTMweVdY?=
 =?utf-8?B?UVhTaEJpeGtEL0JJNHhnbXVGTXlUaHg0S2FzcGgrcEY5cW9kdjd6NndQWmRS?=
 =?utf-8?B?Q2pqN1BubGVBTWdXdFlFVmtYSXZxM1E0VHEyeFVMMVlPUGFZaEhmdGdFU2Nt?=
 =?utf-8?B?VTFNNlBaMVJEVW1HejJramMzS0JGeWpjd2FyRGZSRkNEQW1yZW5iSEFERUdR?=
 =?utf-8?B?UHMxaHo0amZwUDg5MytvR0xhTlZzbUZOQ3RJcmpVb3dFNHdsLzlZMWQ3RHRC?=
 =?utf-8?B?N1UzTG5jcnJHWjNEUDE0eDlOVjFaZk5OWDZNOXlDTEt4Ymd0N1lXMHIyL25U?=
 =?utf-8?B?Zi9pMGtXVENLTkxILytkbXRBalhmUmtsYTZHL2I2aERTYU45dTZONjh3eEcr?=
 =?utf-8?B?RnVtNTh6RmNHUlNpdkxkeDVRRjdUTWNwS0FrYmw0WWxJVXlQVWVVbDZFQUo0?=
 =?utf-8?B?YUREdFZOYk13ZXdjKzRSNS8zTDdDeEN3ZVYyM05iM1Nyc3JKbzZJQXpjaU5N?=
 =?utf-8?B?dU1WRnRWQmNDck5hcXRMenRQRkxNMERqYjNyenQray9WWjZQWlRhQ1lQRndI?=
 =?utf-8?B?ZWxlSW1RcDJ2NWZXR1gwQm9wSGttZEJMV2FENW8ydmFGeEVmbzR2cGcyNFN1?=
 =?utf-8?B?WktoUUZDNGlnMVd2dy8yU05vOVowR1NhR1IvOTZEZ1YrZE16ZGJUSUtBMkFh?=
 =?utf-8?B?ZVIrYzQ5Z1dESkhxV2dLVG1QUUs1T2pSM0V5c1FHUXB0QXFQYW5hc2VlR3ND?=
 =?utf-8?B?M051anptbGtzejFhdFA0WTNmRVBXZHhEV3dvT292bEpYSC9CU2cvazlMK3pK?=
 =?utf-8?B?Zitlb1NzYVlNb1VjeW56dnBGTGU1WG4xMS9vbXdiZnY3MHdTdVlLRjRPUEVU?=
 =?utf-8?B?ekRYV21LdTg0ZFFsSHFCd08zVXVrZlZTSmd2b2hJVXZkQjhlZmhCQVc5UVAz?=
 =?utf-8?B?M3Rsb1hobkg5TlNuamVZYlI0SGdZMTJVRU93RXVRMGRKSm02bmdKWHU2aEdw?=
 =?utf-8?B?Y01DV1h0VnVOUE1WN0tVd1FRMExBMml0NXpaRkhjZHgzUG83OHpXWkRjMEVw?=
 =?utf-8?B?ZFhWMEFISlFOd3JRcW53b2dqTXZ1VGN0cXpqYmZlQkFOSzR6L1VBaG9SdHlw?=
 =?utf-8?B?M0JxZncvcnh4ekc4TEtCV3o2dXNBeVNMa0xrcStFYnlzUVFoOE56NjdCS2wy?=
 =?utf-8?B?UkVzMlV2WmxVRmN2V3pCNjFGWXBubks0bzhmQTMyMEpteDlwYWpJNzFsY2da?=
 =?utf-8?B?RVQ1R3lJVzhUMzdXNDdscVVrUU8wYm5TdHZvTDJQUUp1NXpQczlZMXRiVTVm?=
 =?utf-8?B?b2E0WWl1cDRrVHlZYkp2SnZRTlhydEw5RExTWmlLdm9MaXA5MUhmOEFIZE8w?=
 =?utf-8?B?OFV0RE9lVW9TTThlTVh1R0xRaHluRnBHMWgyeHZQdE82RHBYeDlROG1nSmlI?=
 =?utf-8?B?Z21sbS9nZ2FuU0ZxVHVDRmNoRG5MaUhCR0hIUWEwSWpzUmpORUljbERvbkZy?=
 =?utf-8?B?RlFSNFJUbkVreHNCMHl6U3ZLODNEWVIwc0g1bTMzZy8vT0h3NWFsUUF3R3Zs?=
 =?utf-8?B?ODVVZURjeFNka0F0VUNOcVFXUkFtbUY4NkNuYjNUNkdKa21RRTJJT1lHeWoz?=
 =?utf-8?B?V0hQRGFobW40d1YvenJZNWg2d2Faa1RhL2pBY3JvUm1PNDZOSjB2MGlHREoy?=
 =?utf-8?B?ZGRUWEFkS2hOSUR0bW1FSzVJNW5GYktGOWNzdTFHYTRwQjZjc1J3TjA2clFh?=
 =?utf-8?B?SWhVMEt0NlZRMnpXNTZnMzRDK1puT1p5MzJaNWZxdVpBQkg2WnEvR0hYZE9C?=
 =?utf-8?Q?BFLSFLxIH8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dC8rcVFLaks0RGc3VGlreTlSbEh3VVJRL1JTcDZFTnFtY0xtKzVmOVpNZzNO?=
 =?utf-8?B?T2wwbzE4QjNJcElhQWlPU0lNUlc3cVgrQjRqd0MxMVc2MVZZdTUwRVl1cVlJ?=
 =?utf-8?B?ZkV4cW5KekE4WThJY1FQUWUzcDUwN3RTSlRyVWFTOU5lOU53ZzJxZ0NTdVha?=
 =?utf-8?B?eVdXQXRqZFZhZHZ0aEJrMldiWVpDL1BEdmgxSm9jb1FzT2dubXpxTTRIaTlR?=
 =?utf-8?B?cUxlbUVpMFRHZ2dkMVlib3d4NHAxUVBvQjVXK3lUb1ZDQVl4RTVleG5BNlhR?=
 =?utf-8?B?SVE5VzB3RENTa3crQk1EUmtjWDlXcGxFUTJ1cytRelFhRjdJS1AvQTdmZnl1?=
 =?utf-8?B?WW9uMUpaQk15Q2hWRjZFbDZ2RG9wbTdXK1JFR1Q0WUt1WXJvR3I1TVRGcFBi?=
 =?utf-8?B?Q3RlaFBUVm05R2NVWktUZk1NczF2MkVkZklyYmVyTWVMcFgwYW1uTXlhQm0v?=
 =?utf-8?B?aFcwWk1CczcyYjRUK2hlNVozcDhZb2FsRU5wMzVscVEwY0lYY280Zm1Ed1kx?=
 =?utf-8?B?Y1F2eUU3WFZZaUlUVUlzZWllQXVKTTZ1b0hsRTlvWDljK1ZYTWRPLzZRSVRZ?=
 =?utf-8?B?T2RQaEFkeDF1aldvL2ZLd3g3OVFabXBtMjEvVTJ2Nk1xb2k2RWVuR1pYRUNU?=
 =?utf-8?B?U0VaU0U0ZVhvZjJzZUF5OXRIajVFZnQ4MW1DckZMT1JsTEpJbkxIRE5OQS9W?=
 =?utf-8?B?OUZNWTNKZWVpMFVkUXNCaXBJZUJvbllwZ2t4SnBLWk1PdlBOVkFYTXV0N0xx?=
 =?utf-8?B?Ui9oLzhKOU9jMWhNMlRqNGFQUGIzVmllVDdxb0xJSEFRTmtJQWhic1RGeUph?=
 =?utf-8?B?T29oaVNDWjh5QUhtMmVGMExQSUt4NitFOUZuNzhOb3hFUkN2QVp1cXdkUTQx?=
 =?utf-8?B?WjZzNnp2c2pSb2ZjQmJoamNtQnhoM28ySFhRSUZ0djFETUF0cEcvcDhaTkZN?=
 =?utf-8?B?WGRDZjd6UDFVRTVURmRsc1IvSmRXTHE1TG9heENOTy8wTjdpN2daenRxSUw3?=
 =?utf-8?B?RytKWEtYOW1IS0lSM1oyMVJTRnZQSmFER2dCbHc0dWJzZm5jRHpNTFk2UU5o?=
 =?utf-8?B?MmFHRXI3OGo3VWl1S0Z4Z2E5eTZxN1hxUDRBMUkvb0d6QThySXRXM09RaGMy?=
 =?utf-8?B?cTJwSE9WOGxFUXA4YVZEb2pvZ0NFZlVTZlFNeTB5am82cW1lZDVtbWYvWk9i?=
 =?utf-8?B?QVRSeXBWWFd2MkY1ZjRVbE5RSEdOM2t5Z1pvWmYzN044UStmTEJxcUkxdWhK?=
 =?utf-8?B?d2xhK3EvRE8rWU5Tekg1Tk9uSUlGNEtHNkxvQkFIL2ExN3hocG9Vd2pXS1di?=
 =?utf-8?B?TGdiM1N6K2xta0JaNlZRY3lNSGpjTnVzTDJnQVlTMmU2d0tPWGNNcjZJV2wx?=
 =?utf-8?B?TXJvZlErU0FrMzJIZm9vRlJ5alp3QWNVOXQ5eklWc0o3Vmt0WEJsZCtPbG8v?=
 =?utf-8?B?WXR0eU1kOURJc2N0cWFsQzh6a214KzVqVUFXdm1FYnlhUWxGTGo5VEFWa2ZE?=
 =?utf-8?B?QnNpY0w2RmtDMnNQT2dadmJDcmlQWis0d3Y1Rno2OTRIaG5GTUdMYkRkVW9C?=
 =?utf-8?B?NjQwVWV5OXN5bDZxSFdvS3FjTW1FQTBCemVlUUJSNUdPd2hlZW11VU1LZ3Bq?=
 =?utf-8?B?NXhOMVZaeldkWkV6NlpuWjBpaGpySE42L0JQemVyekd3Z1daWGJ2Zk05VEU0?=
 =?utf-8?B?c2tmYkZTZUFOWk1lcVFBRmRXcVBvanZpZU04TW5wcHV2YXo1Q2xtWXA4MVgy?=
 =?utf-8?B?d3ZOWGRrWFl3Rk1XZXY2aHpEcUpTWml4RFZnKzM3S0IyN3J4OElpZzdCZ0NC?=
 =?utf-8?B?ekdrSU5iN201UFRtVFFUcGlBSGxqamFyc21Cako4a0Rzb21VOGpCYUErV083?=
 =?utf-8?B?UGJWdTUwUjdNSHhIZys3SFNYRUc1NXVXalNOdHhlNllDWmNya2ZvUUJBVUdM?=
 =?utf-8?B?V1lXaDVHN1dNVlE0TDl6UGdha2hIZ3pKTm1HNzVXdUF5Q2pzdmd2Uk9BbFZF?=
 =?utf-8?B?U01SYloreGFUOXVEbmFLYWRlOUNuNzZsemZnWldoZmhlRXRVSkdXc0pjak9a?=
 =?utf-8?B?KzF4L1FKNXBhNjRiRDVndUFDRFJONkFRdEozR3hzclczOTZ4S0xzcXZZaGJi?=
 =?utf-8?B?NWY2UjFWSXlLSmxidFMrcnhCNStSc3ZGb0ZnUG56Z0owQ2lpaEdWbXhPdGgr?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E1W2mYv/M9BCmUWkt6CcFdPAN78JrzB2stWvC89ZTGlWJyn6xLAgIPsUySRG65cnBYc5ZIt6hBjgSpc60l//76bNuaxQknuz2i7kKWLEKnx4vvC0CqbJBIorRY0U7uwXvKRmatF8Xam2OA6vY9W1crK9SC1PsXmf9cvYdu5uNYrOsdHpeZcEIhb9+3vbtxrVO1p/tJxmsTcn72qJqXsh/pLRusZ17lx5MWdtzrgqynqR6UBHLdNUzUDKhZcEIGPsL2mYIRX04MxSg2Vy6CK58oc/OwPdS4a6ljW/l3d6pD+S517/l32KU5rQkh0fae5cJxyil8pBDMlQb4ovHYJ28aZflQOy2j8ZzmPxx97qWQTGOLM0DeyfiBUryCNBIheWjmLpJDUCkVxJIizLP9KcStsXwPop0HaO+MYV+YZu+WuNCtH0s0N4vTw1Ehu3y26duCMz5JmBJiQEKEObqiZNSdjzZF7tI2Pj4kQWnQ/kVL1SdD+hXt/QNmOIBEb1/vtVm8Fi7Dlq87Z2ZWSAP8LIgLwpq5JJnN1aSzuBwkn+T4na0BWgtI9YLpZtqfWrvrYNGtvJPS5GjAbJPmz/OVys3Tr9z3Fllpy2vEwNOgUMERE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0016b947-ae70-404a-d72c-08dd97a9b8ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 14:22:16.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/ZXhfaVCEdHkfB5+1yK0pqGKGNgXIv8HV3nSJQgL9RoC3fN+R5mF3VkdTHj82O2JBW64NjfL1orbEQCWP14q0BLtQrijl4gCyyovbpAKeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=728 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200115
X-Proofpoint-GUID: IwXamPjhsnEAnJW_aFgIzHEDR3UeGPCj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDExNSBTYWx0ZWRfX0UOLjIN8QAfT 3vXBZSHiAdzaIP7IZ1Ui288wgMiDUCnkblwSzMrvChG3VE+4I/qr5flDH1/0RLpc06Rv8NOmn5C 7L+AaWRSBkPRLZiLBvnuIjhHXF30q1rXe0tLNmIH2Ti0xQKjMN88g17rHBoKqdEHCLVzZWqPXT8
 ruFVXKb55TWJ/SSQYbmW9/G4wbnuj7A8dmNCLbcMR1dxSeCRZFgtGsKnAKnRWhcDwKHTuOjLoRo IeEWI6QHWghxhEUY5LOImrXLVUR2/mUHhtgx2qKriMyAseHu466APulRT29RY+lCncS6bbfa6h8 qLJtjogSRJ4f90HFD1IPei6J1kddULg6wckWG/ZlRDXgf0188fI5crvDVaW6oTgRxelbYC7osuX
 4Plrj3VGIXIx6hkF2/w/sOSaI79grCAENoruvKwyErBAY/dnQozobuTji0t5zY6C3wej0n3S
X-Authority-Analysis: v=2.4 cv=bo1MBFai c=1 sm=1 tr=0 ts=682c901c cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=ufHFDILaAAAA:8 a=JfrnYn6hAAAA:8 a=Y1f8oQfs_cOiFzle2vkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZmIg1sZ3JBWsdXgziEIF:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: IwXamPjhsnEAnJW_aFgIzHEDR3UeGPCj

On Tue, May 20, 2025 at 10:08:03PM +0800, Yafang Shao wrote:
> On Tue, May 20, 2025 at 9:10 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, May 20, 2025 at 03:25:07PM +0800, Yafang Shao wrote:
> > > The challenge we face is that our system administration team doesn't
> > > permit enabling THP globally in production by setting it to "madvise"
> > > or "always". As a result, we can only experiment with your feature on
> > > our test servers at this stage.
> >
> > That's a you problem.
>
> perhaps.
>
> > You need to figure out how to influence your
> > sysadmin team to change their mind; whether it's by talking to their
> > superiors or persuading them directly.
>
> I believe that "practicing" matters more than "talking" or "persuading".
> I’m surprised your suggestion relies on "talking" ;-)
> If I understand correctly, we all agree that "talk is cheap", right?
>
> > It's not a justification for why
> > upstream should take this patch.
>
> I believe Johannes has clearly explained the challenges the community
> is currently facing [0].
>
> [0]. https://lore.kernel.org/linux-mm/20250430174521.GC2020@cmpxchg.org/

(Sorry to interject on your conversation, but :)

I don't think anybody denies we have issues in configuring this stuff
sensibly. A global-only control isn't going to cut it in the real world it
seems.

To me as you say yourself, definining the ABI/API here is what really matters,
and we're right now inundated with several series all at once (you wait for one
bus then 3 come at once... :).

So this I think, should be the question.

I like the idea of just exposing something like madvise(), which is something
we're going to maintain indefinitely.

Though any such exposure would in my view would need to be opt-in i.e. have a
list of MADV_... options that are accepted, as we'd need to very cautiously
determine which are safe from this context.

Of course then this leads to the whole thing (and I really know very little
about BPF internals - obviously happy to understand more) of whether we can just
use the madvise() code direct or what locking we can do or how all that works.

At any rate, a custom thing that is specific as 'switch mode for mTHP pages of
size X to Y' is just something I'd rather us not tie ourselves to.

>
>
> --
> Regards
>
> Yafang

What do you think re: bpf vs. something like my proposed process_madvise()
extensions or Usama's proposed prctl()?

Simpler, but really just using madvise functionality and having a means of
defaulting across fork/exec (notwithstanding Jann's concerns in this area).

