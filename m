Return-Path: <bpf+bounces-49541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF34DA19B0E
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 23:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3501E161832
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 22:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A001C878A;
	Wed, 22 Jan 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fhjgTnZn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="He44pFF3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7A1CBE96
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585912; cv=fail; b=QAL2T4O7XeK/ZcO0iDSjdiO+wpP/PrwgQ6c3bMXkBEr2WxjjsDEjNX3+NRVVtQ/OX07sl99I3JO6N1Fsr33K7AlFI4DzELyBOIBub0sFLWR2dt3cuaoCcOGIinXtHdEzxYXZibBLCC4t31iDaKEg2C3pq0bUdLaxpISJQ6t7tqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585912; c=relaxed/simple;
	bh=r83+7hm0GRDNLBzrlm7QQcP9QppEmTK7geC4CgZUxTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=c+jhsx7TFWxJSmNq9wlxQKw55xPZzBqK3GUV++liw/HcA/VBj0kauP/+G+T1TR0+70mYlMiJx4AKYE8wiV+8lVoRw7IeEK/N/kCWR1wEgIfV+nRsB15xgw839y/TOVh7HzS3hhHQp20YOpbHPnijoHCNCFiH9mJAFs7ojR6X/I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fhjgTnZn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=He44pFF3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MLffQa018576;
	Wed, 22 Jan 2025 22:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=toJOV7CLvW5Wmd77/AYnsUeNy/Pg5RcWmPb7rHR0WFY=; b=
	fhjgTnZnLgX9CkKgkZDsWfQ+2d6H0qqqOjt2UkUEHapRoFeqwMk6S3C675VkTQoQ
	2nF/c5C+syskFfpdVANDU/qWQ1wmIxVTfgs2pknu1fHFnoTR6u+xeQ6QmPs1ikhi
	uYadkL5pmb8aO68NWJR1GSFSNIeZeKq3jrLHWPfU76vNDXWPhhci+CmApjuWIpSH
	d5bZ9tyz0TWOPe0kTrcCHFQAesIcFVPbdJvYSUyUOkGnWjj2B9IzUjC/MSK+vbtv
	3+nu6uZE57db4ut/KXYF24A5lD5txw2KhmkiAC4WKQh86FfzoP/DedF3QbP2+yPg
	AT7kkoNH+iwoiWZvE19ARQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh1h6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 22:44:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MKsKSR030304;
	Wed, 22 Jan 2025 22:44:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491fkscgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 22:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXVkpuy9bAdkVr62saFI513uuVD6e5VrYoqw9aU4r/dTkzkTg6jT5zvnD/NvnYEYGu3DpztALGngx9XvnycOKGehyI22WL+tI8aJlu0BchJVGBdRS2GtQc4tTGOhxijvOpxOsYaT7JfEM9wpFJhpLJQhvpeiWvUvoJt/iw8FVPebD9vPMYNuziqKpsKiY7/BFZsCgiEhMa7mxyoizZLCUzR832M59LY0/4mSlJ9d0PfTbjYHvIBF4ZcJ564RrBCsu4p4cZDM3OKxvgEsahr6WS2K3bg9dlle0Q+DRmfaYGOog45OsfFmc94DTDvEMCs6GtWa841ILHy3i7CqStBSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toJOV7CLvW5Wmd77/AYnsUeNy/Pg5RcWmPb7rHR0WFY=;
 b=hl+A/y+kf0PTPn5jhm5aKXNEDc9OpmThLhSfB+RCESv9Md36yW8WS8ImUVELww9dT62RdIQaEXnjRQxagjLTzjTic3cMOqvTL4FKwO8jU5OhKs6Zyk+0egEd21auGG48Vg2rUJxODDF9q1Nrrijya2kMpJt8CB7uaib9jWGEZXoLg/wHR87Y+tRfYspox5QE3e3sxe6+1YrLT5qzXjFJh8qdOjfGumBmfizgeHNlfvipbV8WOHbCDCmLLOwVebB8N7quHM21OUwLWP7kD74ZnoCGxQIS1Gn00fsirOQHeDyn1QpG8iuU55cs39oeC1LKShOzakCjd9tuBGYG+taX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toJOV7CLvW5Wmd77/AYnsUeNy/Pg5RcWmPb7rHR0WFY=;
 b=He44pFF3wte/U+7qwv1mIaaH4o/P4UDgH9w3nBa9WhLn+88QP1WfhuCsRUXHVFnJrRGjEVfzAuOO7qJOgkLBVdPJlbnX+W7SvjrIFCu9JSiNQuwA/u9OC5tq3EkO4IWyYntgv33hNGH8ixDmZRRQaALjo1YjRicPO2WTNSRxrE8=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by CH0PR10MB4873.namprd10.prod.outlook.com (2603:10b6:610:c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 22:44:45 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 22:44:45 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org,
        andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, mykolal@fb.com
Subject: Re: [PATCH bpf-next 0/5] BTF: arbitrary __attribute__ encoding
In-Reply-To: <CAEf4BzbVxbtpRnAo2PqrF0n7-B28p59KPvozXuEuPpTZYA9=7g@mail.gmail.com>
	(Andrii Nakryiko's message of "Wed, 22 Jan 2025 13:52:45 -0800")
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
	<87msfjhy3v.fsf@oracle.com>
	<CAEf4BzbVxbtpRnAo2PqrF0n7-B28p59KPvozXuEuPpTZYA9=7g@mail.gmail.com>
Date: Wed, 22 Jan 2025 23:44:42 +0100
Message-ID: <871pwumpt1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::27) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|CH0PR10MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 93380bda-23d3-49c5-d040-08dd3b365e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmFRM2JNV3dVY2s2Ykd3L21pbmQrS2NuVndILzlVT2dqMmJLV1JBYS9Ram1a?=
 =?utf-8?B?cEtubndCdzAvQ2VWaGp1UklHU3pFa3lvU2lNOVkzbFIxdktKTVFJWnErZjV4?=
 =?utf-8?B?VmVWOWlaODdSbzgxaWZpOTlTWmd5Z3YyMVpFNytRNjhYSC9KU0o5QUdnblA3?=
 =?utf-8?B?N2VXMEUrWWI5TU1KSVg1TWxCeGZKWUtNTUxSaHJJSHp5VUVQU1dmRmNlc1Rx?=
 =?utf-8?B?UVBleUV2LzdYOWEzcWNkUTgva1VHMys3RkhjbnB0L3N4Z3g2U1BDUFM5VWh2?=
 =?utf-8?B?OUYybzI0RG1VaW5IZmhTK2F2bkY0ZTRhMlRvVHo4SlREM3o1cFJpeVJPSmNa?=
 =?utf-8?B?eGJRcmNmUjZnaWo1UWJWaWJ3bFlXVG9tbVl3cmdUZWhFZE1oRjdMb1E4VHlG?=
 =?utf-8?B?YWR4OFJ3ajBBYVUvbFBITWRnaHYvQTRleHAwV0l5UHVET2RHMXpiZk43QUR1?=
 =?utf-8?B?ZTVzK24rNmJnMTkrTExwQkdlTGZ5R1l2T0RmSWp5OFJOalpYMmhjcm4zS1pi?=
 =?utf-8?B?MGRjRnBOSVBBYUVmclNQNzJ1RmZKQ0gzZlpKUGJFbFV2c0ZBZlprTjJ6cXNO?=
 =?utf-8?B?ODIyN05HTGlOSGZPK0dxTGZMUzgxdnliN2J4MEdudmxNd1hsYzdNamxDQmxR?=
 =?utf-8?B?clVjSVg0aXlURWNNbk5wMmNWeGRNUFN0V2hib2pJTDFCUTYwZytrVjJ1QUV3?=
 =?utf-8?B?R0FVQTNUMERWZFpYMUdybUN2NERBdGFzc3lGMTJERitOTWJWV1ZmbVpTejFm?=
 =?utf-8?B?U1pNcXpYclNyZ2sxY2pzcFNDdFkxMERUazJ2bFdoMDVENGJPTjhWbndWVlNP?=
 =?utf-8?B?enlzb1VWbFdPSW51TFJwWThTY2lHakRSK2lBY3k5WExYNGY5M1o1TDNhc3dk?=
 =?utf-8?B?VVA2dFBHRzgwcXgwNmpzS1VXMVJ0QnBFenB2emRPQ0hTSXNac01qdlovMXFL?=
 =?utf-8?B?bE5JNzJ0YVd5SitNODFIbzFIb0IrbGpjcjZuWDBZVS9GNzhDSktxc2o0Y2Jq?=
 =?utf-8?B?NkVpMHRwcERET3Q1MTJHdEpkY3NrcGMwQU9NTWV2YUNuVFAxT3VwQlpkcDZK?=
 =?utf-8?B?TmJBNHE4Wkc5dll3ZkFkVmlya05lODFFRUdEM2dsQkgzb0ZUVUdYa2lqZjJK?=
 =?utf-8?B?d0c2NUFjbnZTNjg0VUdJQVlzZ3VPTElNV0Y1QjZGZ3l3aVRPZEVCbEhPM1gv?=
 =?utf-8?B?cHhVSU1OMkVuQ1JBc0RDUW85SDgzbmFEUUFBYXE4bUd1SmwyREFQdklCbUdC?=
 =?utf-8?B?V2syb20wWXVZa0JyTHJITHNyVFVhQ0pmOUJDMDd0eml4eGlnRk1zRTBYYkE1?=
 =?utf-8?B?QU04S00ycmVLL1kvRkJ3cmdkUXJtNVllb1JtL2VzaXlFS0lORU1nNEMwcldz?=
 =?utf-8?B?ZHJQUmk0WVVSWjRhclRJMHN3SFNGOU14cEVVY2p2OEhES0RxYUtGYXNoTjVJ?=
 =?utf-8?B?L05qZkVVeWhxdUpROHVuZXdCemxLS3ZrQ0ZMT1FrNzhEY1JOWktkR3FZVWdE?=
 =?utf-8?B?dFUzZkhiMU56TmtMendLenExSDVueitBZlJROWdLVVlMZ2Qxdm9ESWFEVEgy?=
 =?utf-8?B?SS9UVTE3U0JUSEcvQ2Jja1NUTmtYQWRPOCtETldhdGtUWVAveVpUbnlReEUx?=
 =?utf-8?B?d1dXUGxYYVhKV29tWWdwT0dxQ1h0MmtnMHZnblNuTlVvOFg3M0QvVFdoL1NQ?=
 =?utf-8?B?cXB4SWt4TjhJNmo0a0dsOEQ2UHJySkcxdndVcDV6a0VNWEhPbXBBVW5lakFm?=
 =?utf-8?B?eXBwVzBEcDNvV3o3cFdkQlcrM2dMSnJXTGVDNUtiWnBhMlNpaGlPWWtGcjZJ?=
 =?utf-8?B?YmFiOHdRcVRlM0JMRmw0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzF4YitkRDFaaUppOFo4Tk11RW1JWUJ4NW9LaFpsZkhhdEVzenlyNDBqRjFU?=
 =?utf-8?B?S0tTMkJlTUhhMmJXd2I1alZVZ25OQXhLNVpMa2FPcnVuM3Z2QzNKUTNlTUht?=
 =?utf-8?B?dGY0NnZ2WTd0VFcrNUFBb21SVndmLy9yMGtkandNU0Z6NDZRMFduWHU2NGFT?=
 =?utf-8?B?UzFwZnRZQXVQR0cvYmdhemUwbTg5QloxRCtEc2pHcExKdGNLY2dlRG1qODJo?=
 =?utf-8?B?NXI0Ui9HRjFCWFc2c1gwNEtHSHpETTBrYk43eUJjYWJmZ25Oc2dXeFk4ajZn?=
 =?utf-8?B?dzBFYmRJQjBmVGtmQXBEbTdOQXpWcDVvc292QXBjOGxTR1BxVVgySFVuUUR1?=
 =?utf-8?B?L1poa2ZmdjNRQXJFQ2hnMTZVSlljYzJhWGJnOC9rcWZ2SFJ1NXI5ZENwNk5X?=
 =?utf-8?B?czJEQUxyNHNLMy9QWFVTeVpua0lkRFo0aW5ReTFMMWZXSTZOZ0loV2pWRkFE?=
 =?utf-8?B?VEM0b2dwMkhOTmRxenpJYkJWSDVmK2taOU5sQjdPM0tFRHNIZzNJaG1Jd2p4?=
 =?utf-8?B?N2I1YWhLdThaeDBvenY5QzQxN2E3ZUVkY3dNMWtzcWJna2o0N1ZyR21CUVN2?=
 =?utf-8?B?bTNyNTVwSnpSUFkzSXdvdmxRVGYxcnlVZDNCRlRBV3FodUlPVjhmQlljTzV2?=
 =?utf-8?B?eEp3SFZ1VW16N3BvWVRnbmtITEt3ckl5NHFrNGpWSFgxR2lKem9qQkw2dWZF?=
 =?utf-8?B?bnZrS1VTbzl2SFJER2dmZ0U4Kzlrbm94Sm4wKzR0cWdwRk11OVdMT3ZYd3Zo?=
 =?utf-8?B?WVVEY1lWRmVLTHNzQXM2V0FNM0RScFRrUGt3NFc1NzlFdkp0ZmZML3RZVUFm?=
 =?utf-8?B?dG1xb2toM0F0MmtNVUw2TDJpZ1BNc0NWWEQvVytwV2hLNVZSNlU1TGZ0Z0Zv?=
 =?utf-8?B?TGdoSFphczlzOGlzWDZPTFA2bE94Y2VOVjBaZmdVY1pLWGpmaTBxcmtTMTAy?=
 =?utf-8?B?ZVV5dTNWeHV5RmxWZm82eVd3a3VFT3NwRHhEUVlHN1RVVTF1NncwajNnQjQr?=
 =?utf-8?B?cWhkYnJlSFZGN2s0OExTQjBCOWpHVWllT0hBa2pKZ1Bib3dyNzdXRVVpNXZP?=
 =?utf-8?B?QWsyTCtibGtVRkVadjdzWjNsTjFSbm1NUlpTU0FaSHpGS0twSHNkYUw4SDZ2?=
 =?utf-8?B?ZGVIQlpMZWl2cnRDVHQ4d1A1QnhWT2x3T3N6QStTMFpzMW90YUN1T1d0NkJV?=
 =?utf-8?B?ZFhKZDlJZ0tVbW1qd0M1ZzlITWsvcjYxVXo1c0tlOFN1YUg2WXF5WW95WlJo?=
 =?utf-8?B?MDZlcWxMbXRvTjJjN0c3NlBUWEYyQ1VXZmVKOEpBNVQ2d3ZiRENVZzFEemg3?=
 =?utf-8?B?aUFDUjFjcWRYaUowWmxHRU1KWVl1cGt6SlNHd1RaVW5nV2F6ZldhU1hIb1hL?=
 =?utf-8?B?RUJzUTdid2tWRUVUYmVnZkpscFZXU3ZCQ0FrdUppUXFDSVRxeWRGaHRMT1lB?=
 =?utf-8?B?TDMrdWVaWVhEbi85aEU0MGcybUNDMEh4dlhNTDA2Tzczdmd6RUJxSlhMeGht?=
 =?utf-8?B?bW5zUjJKdG1RNSs5RGkvUDdLMWJPWkVHTkFPWEZoZE1JUjZPd2dQQStrYS9B?=
 =?utf-8?B?TGdmZDJRRVppcHNqVnU0azJiaHBBUmg5QXNMcHFYTzltL0VWZTJVMWoxc3J5?=
 =?utf-8?B?TDNCcDMxQllLcG9Od1NHZ0FNWUNqbkdmZkxYbU4yT1JNYmtkL0drQmlPcGZm?=
 =?utf-8?B?cWNjYlRZQnFZaXFZUVY4RGVGVFU1MFAyMi9kdWlicjc3NHhjTnNNU3lLelVa?=
 =?utf-8?B?b1AyeGdkM0JsUFR4U3RyTUZZNitGVjRIK0QyMFNXekk2N2JNSm9sTW1vVEpX?=
 =?utf-8?B?LzZnb2tvQW1MZG1MU0tzamtVclE5eWNWZzZXOGRudmxhWWMvWjBwWDVGUlJY?=
 =?utf-8?B?Y2htdElWenJqTHpMb0N1RGxEME1qT0tldVNIZlRkWlRFc1RGb2tsUTZlZTU4?=
 =?utf-8?B?dlJNNHFha1hGc3NMaVZJb2Zad2xtU2VCMlVBczZ3cHkwYWpOekpQS2hMaDJR?=
 =?utf-8?B?NmZ5SGZWamZSUCthVTRmUXhuUjE5UmlXeUVWLzNub2wrSTJNM1hsYWdhanpC?=
 =?utf-8?B?SXk1ZlRHM2JMSzVtcFVDK0gvNGt6b0VYNVkwUmtGalAwSUZ1aWhiVXRGNU9D?=
 =?utf-8?B?WXhJVGpJT0pHS0pIN1VQeEFkU0xBQTdYZzlqVDMxdjlPejlsNnpOVFVTclAy?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aUGfyxI04aVJJTY+kGBv2USOJRgCks6wbPkSlCnwF0t0G0+YAALIuiRyFAUz1hHxbd/nJZ8duHEXByuYvSJj0CrKiBUsQ6Cr0BWhfovi4sYG5DXUjdAj3+0uSJ0wm9imZW5AfVM5pbyqz5/LoklErek5dSO8JDktTR1wB757iFLQ3vs/osBUPz9Yh5UJrFIoRZ/Sa4PFZGRY1cnXiDm/i+nL6p1OJvKBBOmHiihxUb8oyILDnpBYIV3YpSPSLjyXcHojSnCxfQ5MWEZbs6OGbfN2HCaq1UDbyiN7DvCe9c7+EBZN26CKZUNVX1xRUcCadD/cdwpk2u4kkVg/DxI6Br7eqL9SBu1vQCGp6EsFDhLciA/w3egiTIDrIlteB3nk+Xd/KBFTRg5tsVnpYO/mmmJDB9Y//uE+KkKCmS+SS+kJQX5dB2waTF0KA7JZe6JGrH9ndanjTbb/wHYd6iQfSXCJk/mIBTmwkgjbOAFfvpUjEStue1nC5tZAw5bn3KRDPSb+Y1vGZx7cErNiRif5q9omqpXziaq46zT9gIVIM2hMF8Rp62h+uT+FYd4judaZk2oeVkjVp37s757c5SWlh6+xKl/O5gW9ZfOtFCEWi6o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93380bda-23d3-49c5-d040-08dd3b365e01
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 22:44:45.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Wde6zmcFZEbys+TDfgaWCNFWIusl4pnBADO2lOIfYzpLgfjHOiQRzRC8ip7/W6M9XLMaGE7RZPRi7jCNsOubs5BK4suBzLJ2EMJ4EQ6md0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_10,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501220165
X-Proofpoint-ORIG-GUID: DHkCW600y9AEqHX_CKiWW7ILRDZ9Cfr0
X-Proofpoint-GUID: DHkCW600y9AEqHX_CKiWW7ILRDZ9Cfr0


> On Wed, Jan 22, 2025 at 3:44=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > This patch series extends BPF Type Format (BTF) to support arbitrary
>> > __attribute__ encoding.
>> >
>> > Setting the kind_flag to 1 in BTF type tags and decl tags now changes
>> > the meaning for the encoded tag, in particular with respect to
>> > btf_dump in libbpf.
>> >
>> > If the kflag is set, then the string encoded by the tag represents the
>> > full attribute-list of an attribute specifier [1].
>>
>> Why is extending BTF necessary for this?  Type and declaration tags
>> contain arbitrary strings, and AFAIK you can have more than one type tag
>
> Because currently TYPE_TAG(some_string) is
> __attribute__((btf_type_tag("some_string"))).
>
> That btf_type_tag() attribute name is hard-coded in the semantics of
> current TYPE_TAG (and DECL_TAG as well). So here Ihor is generalizing
> this to be __attribute__((some_string)).
>
>> associated with a single type or declaration.  Why coupling the
>> interpretation of the contents of the string with the transport format?
>>
>> Something like "cattribute:always_inline".
>
> I think that ship has sailed. We didn't define any extra semantics for
> any sort of "prefix:" part of TYPE_TAG's string, and I'm not sure we
> want to retroactively define anything like that at this point.
>
> What is exactly the problem with using kflag=3D1? Keep in mind, at least
> initially, this is meant for tools like pahole and bpftool, not
> GCC/Clang itself, to augment BTF with extra annotations (like
> preserve_access_index attribute that is added when generating
> vmlinux.h).

Ah ok, I misunderstood how this is intended to be used.

I thought it would be the BPF compiler that would be creating these
entries.  But it is these tools that will emit the attributes in the
headers, and then augment the BTF entries for these particular
attributes when loading the programs that include the headers?

>
>>
>> > This feature will allow extending tools such as pahole and bpftool to
>> > capture and use more granular type information, and make it easier to
>> > manage compatibility between clang and gcc BPF compilers.
>> >
>> > [1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Attribute-Syntax.htm=
l
>> >
>> > Ihor Solodrai (5):
>> >   libbpf: introduce kflag for type_tags and decl_tags in BTF
>> >   libbpf: check the kflag of type tags in btf_dump
>> >   selftests/bpf: add a btf_dump test for type_tags
>> >   bpf: allow kind_flag for BTF type and decl tags
>> >   selftests/bpf: add a BTF verification test for kflagged type_tag
>> >
>> >  Documentation/bpf/btf.rst                     |  27 +++-
>> >  kernel/bpf/btf.c                              |   7 +-
>> >  tools/include/uapi/linux/btf.h                |   3 +-
>> >  tools/lib/bpf/btf.c                           |  87 +++++++---
>> >  tools/lib/bpf/btf.h                           |   3 +
>> >  tools/lib/bpf/btf_dump.c                      |   5 +-
>> >  tools/lib/bpf/libbpf.map                      |   2 +
>> >  tools/testing/selftests/bpf/prog_tests/btf.c  |  23 ++-
>> >  .../selftests/bpf/prog_tests/btf_dump.c       | 148 +++++++++++++----=
-
>> >  tools/testing/selftests/bpf/test_btf.h        |   6 +
>> >  10 files changed, 234 insertions(+), 77 deletions(-)

