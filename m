Return-Path: <bpf+bounces-28505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991928BAB80
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 13:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C681C21C63
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C0D1509AF;
	Fri,  3 May 2024 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MQ/8YrQH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NeUH40Fl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1A14F9FF
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714735137; cv=fail; b=eqW+FLWGt+/9AWX1ZHK59zDLySIjsqHLlajw81VvyaQkVZUfWgCsqSKfVOshEfEJ1Wlrq1j84GWevVHPIMF+QCpWx8YcsI7boIZR8D3pEp6/ZQxwthB97lt4BB1EaQxw4geszdTrVpMDdOksLFgV5BsvrjNx5U5TfRqy9zUk4hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714735137; c=relaxed/simple;
	bh=Upjjcr1SsEmxzDyISU8T/wbgUzfAy8+DYuh94N9dK6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TC5Hjw37RNOYqByPBXd47F0opNTzO2X+prR6+I6CPXZPJZCMVX7FB2QDmIY3JRk2S9g+Q+pVuCAD7dEnPcFaJ/PhlzETLFO65eVXxReSH4W5pUqAT/LPAcAAnePezCxJ15T8wKdxE3WwmUeadCVqiTZCy0aNFg0L4cAQeOEYFJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MQ/8YrQH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NeUH40Fl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4436kaQ1024563;
	Fri, 3 May 2024 11:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=gHomBXvwvaJEkF2qLe5o7fAs9nxwChrNTn5yAjs5Kgw=;
 b=MQ/8YrQH6gbOem999aoIQHSAVzgv4/BxjMIT96jLQ3Q39euPYW91EyVGkvXjVEr99/hY
 ST8jSL3Hp6Gc4SuU4S5R4IasFtIF6dtg4bg+L6KYeCIoJIhYKPbIWs560iVxhQX+FRI3
 ZwCEZ2G0p68srzCHMrcWXQXnvYuXoFeK5fQEjmWqdAkWeqVqokNbu5stlqkdvZaeMIiw
 KR+d39EXZ2zBhY9z1wd4WgZfwxJP7jGCsrMaARAzI77WSN+h9ZAAuPYn+RYkDpFTQJSZ
 6IN04keEHvlj+IV3vUC0wyYQu/kQuZ3fHkSwm9YYyy44Az8GfkrBxzRj2EA1VURT5mKj Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsww01xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 11:18:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4439XP1h039889;
	Fri, 3 May 2024 11:18:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcd3r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 11:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW6xzo10H6tyEdlxYAVYgd+mFWuw8MDVRaEkZtxanGZt5f48R0Wsz16sx9XQwb23Q+fQZRy5mSGOaOwKtRweS8THX+KS/D6jMcP4GYpc86rdo6vjdExbUPpdvz5jR4Fha1A+JauLLIDHP4k/VCnLhYEmxxxirJLzXBoJcHWecu6C9xsqd1eQRaV1zGmLAp0Vm7O0C/i7PH5pa4Qv4y+MaitGu7djXyfNN9v9GjCx8jYx9ZqJSs0F+/fSvZsBKUFc2fUOWzA7we2JniPtx/gMezKLoHTK6BEyN4ej+bVoxpv7Cm30JD0D8K+Mq9o+FaaEqOQywwM1/u0/17kVc7Hseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHomBXvwvaJEkF2qLe5o7fAs9nxwChrNTn5yAjs5Kgw=;
 b=ZaIJQvFlp3Mr/CDXwOoqaiOjvtjeeFkbe1M4lABnduNV10fpeA5CkasFfse1QnHBchyIpOtEDfLTQhPO568Y2igCqAl+/akEwrvCBk8C8oDzNW/SPNG5uEhZH/P3SeziX8PHOrT6R+ryECo4yw/g/gKTQgcKCm1jaDW1JRtp/NOKVZRVo4MhNfmho+lwO1B5GW3+wHFfS+68mGvGieCeYn8Nx6SF8B3Z5T0Q+E1nfAus/nM4TJWuWW8k3WOcVPBdmdBibT7/QtbUea59hwQThX/rzKJ4KhsvJaWYkMB+jwYWEeHPNT2LmD+ILwk9Hd3RVm/FCicTWLf6ethWVi4cZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHomBXvwvaJEkF2qLe5o7fAs9nxwChrNTn5yAjs5Kgw=;
 b=NeUH40FlRMY2OTuLvTM54B/dq7NuJc8kCVFjRMPvMPoYiuZwr2E+2mynzozSpNHeT0+4niTNClnJiZlbskjKlonzEahd+jS0khloseSnKKYqCqd8U/CDehS7NKOpTZOUjSG/CRAZcxAjfapguHPoxpt1uRhm8O9IQnCWTK603mA=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by IA0PR10MB7205.namprd10.prod.outlook.com (2603:10b6:208:406::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 11:18:48 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 11:18:42 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com
Subject: [RFC bpf-next] bpf: avoid clang-specific push/pop attribute pragmas in bpftool
Date: Fri,  3 May 2024 13:18:36 +0200
Message-Id: <20240503111836.25275-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0217.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::13) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|IA0PR10MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 37803a45-5b52-48d5-b9bf-08dc6b62ca3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HntzqL7E1uJkVBzFQhm+ORJ1mM/6bJqPS8bBEAwCFHtGLWgHJFZJSZCWC8P/?=
 =?us-ascii?Q?O+lJuvIH3R+c5O4HowyX/aKpU3j1c7q6muJSL4rjptnabSaQhZ6i0i0GEML6?=
 =?us-ascii?Q?nt1v7NNSpxlkz/pZaaCoOH5VMcsM+NbFmcz0Tp4UqrE6Z6+ykyrGVAKPMBHq?=
 =?us-ascii?Q?RCG7bTnBbK6q7W1ZT47aR0VPNH7H0FgFW6cWcU7CGMtnMXtHwktOPg5/l1x6?=
 =?us-ascii?Q?KHRyyVPdnBVeRi1H95yjTR/mM2QeTS+XC/gL/bGdPNopoLpd9ytYa3QD2qCZ?=
 =?us-ascii?Q?HqV4ECRPkIpZxDWl4CVmXFYD4ug0tGOhHSdX61A3aZYQmsT1L6DTRRRFKhZp?=
 =?us-ascii?Q?uanYGKWEQB3kykIUg2AV3fmW8FGLpJhcv65ACwgOoYBIa8QGFCWxXLXVUKTv?=
 =?us-ascii?Q?QvHOS8iddZB3zJy51EGkvJ0Xd+iK2ZGI1MO3GIjwlS+kKlj2pQeV8heyghy3?=
 =?us-ascii?Q?8Dr8wFuPR4vD5dnT5kIW9/NzwQmLvRRAFe3TxefkhROXqfS3svmU34DOkKBg?=
 =?us-ascii?Q?P6eOE+caVLu8pKRqIvYQOtRIVQTlDejyBhnkwMXBQAEfhZok8N8XgQHCb8PV?=
 =?us-ascii?Q?EaKyHrlFZoYbpYbOP2tq4gumPkgFEwDuHLFhcPGAJ4VMHJU+h5slYRzVIwjd?=
 =?us-ascii?Q?rcY+NC5Isvv+o+fqmkhtbmcV8GLtXVGf31WGo29Nzj4iRn2KJku4dAGeEXXT?=
 =?us-ascii?Q?0slgXYAcxCXoqSscl85ENOXKEm8aAOpT4gHmQad9QbJBQfD3zsmruWbIrcm7?=
 =?us-ascii?Q?ewV1Px9oABnECu+phtOAKapE2qVIKL8v2Qt93fOthLDSSlPOAoIYUWwAPUxy?=
 =?us-ascii?Q?qQyb856ASVJ7gUdUGzGuUK+dE6lHr0ggJzimrS+L8RPrf9hoYb2jjuUlON+G?=
 =?us-ascii?Q?y4oFwbtkY/5dRWO9YS0kpA+4tEPjslSn7VM+A3hZBtye2o+t9NL0j6Em2cr1?=
 =?us-ascii?Q?SNc7SF5wpdB3Izrss+9T/Sei/cY3LZR9HoLAOwt5xkOvVChnNMUtNiJDwVmD?=
 =?us-ascii?Q?ZRuhI1DtRvJEoeic62Q2Ji53QqAmzZGsfC66z8t1bhTUmA5ZRhaq8dq7/co0?=
 =?us-ascii?Q?bioXTD3g8vAIRADj+pE7RSvqqOLklPhwoGHXAEM9n/2O0gw95KxPYljkWK5G?=
 =?us-ascii?Q?Yv9m9Y4USdm18fh6UL1khmE5fizYhy8JiczUM/cPROnHYTkhpnPqM5ZY5h4P?=
 =?us-ascii?Q?aDOUkHW3/BRLX5QSPCk3S777+XOVQo985m3hfadNN/b8fQwEehQIBLhfu64d?=
 =?us-ascii?Q?AjnkeuSgztuhjtKuwt92RWD6tNyJWKzoPbOtzHwPbQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SQOasa/lrxRxZpwRJgQsowMWF1lVJzs8kPP3WBNLgxGAipaGPq4v8suFr0zq?=
 =?us-ascii?Q?Fo+jLvzzyedkpLSNQqoHAHmdLY6tM8zp/k53neSZB6MOx3acDxips7jJuSFL?=
 =?us-ascii?Q?LT/511mOchCyDwjK9QApKl8VDf2WPLJYZhOM+qfUnFvmwSKmVKAsS3LE86XU?=
 =?us-ascii?Q?MRE3wAVMitkRx+Ou5q1HPpgmHKbtCjVXH13Iuyl19YJdDfkJ7ZMvOb/oJS0S?=
 =?us-ascii?Q?06wZmnpt/jvdeZyYg6ELUJZQq3ZXzgzNq9GXOGHKQobh1pyeasXLcgU1fI6C?=
 =?us-ascii?Q?UxCeOsk26l199ygQZiYNh2Jlqk3d+M4F+b6oh0v+/oQaCY67aZWldBLdINCh?=
 =?us-ascii?Q?YKzDSZbceXwGptoC2C8RKkPM56wg/jT2mMwKZroHVYCgIkeLacnFJRBA0us2?=
 =?us-ascii?Q?35+giKjjFD/JUVV4kvL2QKFXP3cMsPV+eZfNVyW5gZ/pDdl3tAPIr0kKPTTK?=
 =?us-ascii?Q?yUjmLgtiz23c+WQsiL2mAKDjm8kTD9I75ZHGHv4ilpO91c0Obo6jqubvAl4E?=
 =?us-ascii?Q?qU5NsHFeiTBFP8qBbOxfr7+HPJdn/ZBlc7a4Q0jwz/UBOPqNNE8wHAbCvL6F?=
 =?us-ascii?Q?qMOqiETKeAYeWyuevuQxp/orHVC6tTK7WAVW/AFUvahXSDkd0uttr+gVWQa0?=
 =?us-ascii?Q?IZQP/ZmfSPXHhlZVbaBEA6VE6u8wA5078xEgP6e1dg0zr+/hA00TAL4yAAd4?=
 =?us-ascii?Q?+2pMz3xgBpOnyrmVhug7hw7/ofkHvxTVms5oRBoWQ5GXmprdovDP0EcSbybr?=
 =?us-ascii?Q?hx4cIIzg/IbR75YLfcuGU5xHZrY8fwe6OB3W00emSKRO3Yi7riX7yukD5dDv?=
 =?us-ascii?Q?VKviH7I9cLyk0vpVaq6XUTWUUFAS0TP7koH8vXwwbGIJ+Xu1cZTlyEBlBGPK?=
 =?us-ascii?Q?LGxmxZLv2yw5Qp783Y6Q9R0xaEDIrCbC6maWCWx6PgSb0gHrHc3a1PQIi0Bh?=
 =?us-ascii?Q?i/zZgmgoQfIqk4HhS0rjlj94PA3JDTpTpYvwCa9gR9oLv/KWP0VOZtYiidYE?=
 =?us-ascii?Q?gy8dcBmDLX2Og+XTT0lqiQDCIFRCA1Mo/pHrY/rWEg7EFCLExjW8k6L5n7x8?=
 =?us-ascii?Q?nHotbNSViVZ1Qfdu6xsCcNOpg/FqshjKNe6EL1/JatEKAR4rHDRAfE7VxoHy?=
 =?us-ascii?Q?yKlX/EbB/0H2XymieBgp7Q2dp1DZ7IH1RuuhjV4RjOuHk0L1WRXZqrhN5IHA?=
 =?us-ascii?Q?PJZEh3Cszp2l3xRpuQVboxOAyVCfV3sZcsg0klWqzOqlVsIRcQ+wIsFen0j7?=
 =?us-ascii?Q?q4DJQqRcqfDeruPRhZTCY617rE0Ggvlh6KmmQu/4l8HzbE1o+NJO+eiU7Lws?=
 =?us-ascii?Q?DjKZLM6yZ2nuQioGXykJDup99SkI91KXXrmJ93qBG9yIZKUaOVC8QpwjY8ja?=
 =?us-ascii?Q?fLUyxvEGaPH5+uT4NGA5S/OGXkauGXb1Nb0aR+BG9JqptMKFfgr0jp0yAx6W?=
 =?us-ascii?Q?we1REztSYfa09prxHnQgXGyk4qlWWJvHOFWylCVEosY7OJ2VpafecVoSDPha?=
 =?us-ascii?Q?QW1+gz8s7NthErX3JH3f3mIgB6soFRtXQ+OsHtplHQueLj9TSyDUNI8WiF7t?=
 =?us-ascii?Q?fLWyoBVJMVwhL0H+O0Y5UcdnQBlhVjY2jrQuQ3GGT0oj1BRU/y/YpWcVNhUn?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RvnZizF87EYWhqDa/rrwFqLVowDKql4RLWcZrUCbkcdVPdsPeTTkLzmB1z85jWRFTl8pwD8KmlusIRjOzGKLPPSCSexJOs0hKv2bgNIFzjnb6hF5mDLa3hqSYYpWLTg1I/jF9NAJj2sdjdXowyUNNzQ8uY6kAJx7xb3YPDc/bhQ76VwVf+VOWRksUwsVJIF2o1w+C5ip2VTwPId41O49UXR3ao33Os5XVI5XoP4g/IlLlo6yjlHYk9oLIhvqRA9me/VZsXvEFYBpFOeCDOPkIyoVs9IL6G2VqJ1cZPTuev7z+LmgLF58PY9xOKla3BGPGdRpIQoW1P/uAykchLQU2JJpYbLKx3o+sXGn4Rvz2kiSGFBxNPIeAZtnSrof/J9hTKlcPe+2UOJqHUQqmWdGakPDoZxmVjYEe519v1CtJ3mdHOZEdc3i1L5XWA1TLM0Phdq/L+4929lUwKgscOfsdYFDUPCakHbYjqKdGAPJ8IlkBxwosnap6Y+h07T0j8hmzU+9o1tUie7+6xomFnYlilbAeZDTK0JJnrGp4fPHi2LpjTDADn5SxZ09mjxg4MOo9L5M4LYjcIYNIp1627NlGQDDr/60whpCEuOUALTjhlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37803a45-5b52-48d5-b9bf-08dc6b62ca3a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 11:18:42.7239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iUYNHbd18KQ2b3RdWvu3Fy5tSOFbiutHw+HeP9SwonIjcMPHJv58Hx6o31SBUAzAwQBVaG9XBxREwMOLR4ndLBNI+uG0tVPQG/5qvPWcq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_07,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030081
X-Proofpoint-GUID: qtCWyPqQZi2346MzMC24HwzKd7QpanWH
X-Proofpoint-ORIG-GUID: qtCWyPqQZi2346MzMC24HwzKd7QpanWH

The vmlinux.h file generated by bpftool makes use of compiler pragmas
in order to install the CO-RE preserve_access_index in all the struct
types derived from the BTF info:

  #ifndef __VMLINUX_H__
  #define __VMLINUX_H__

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #pragma clang attribute push (__attribute__((preserve_access_index)), apply_t = record
  #endif

  [... type definitions generated from kernel BTF ... ]

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #pragma clang attribute pop
  #endif

The `clang attribute push/pop' pragmas are specific to clang/llvm and
are not supported by GCC.

This patch modifies bpftool in order to, instead of using the pragmas,
define ATTR_PRESERVE_ACCESS_INDEX to conditionally expand to the CO-RE
attribute:

  #ifndef __VMLINUX_H__
  #define __VMLINUX_H__

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #define ATTR_PRESERVE_ACCESS_INDEX __attribute__((preserve_access_index))
  #else
  #define ATTR_PRESERVE_ACCESS_INDEX
  #endif

  [... type definitions generated from kernel BTF ... ]

  #undef ATTR_PRESERVE_ACCESS_INDEX

and then the new btf_dump__dump_type_with_opts is used with options
specifying that we wish to have struct type attributes:

  DECLARE_LIBBPF_OPTS(btf_dump_type_opts, opts);
  [...]
  opts.record_attrs_str = "ATTR_PRESERVE_ACCESS_INDEX";
  [...]
  err = btf_dump__dump_type_with_opts(d, root_type_ids[i], &opts);

This is a RFC because introducing a new libbpf public function
btf_dump__dump_type_with_opts may not be desirable.

An alternative could be to, instead of passing the record_attrs_str
option in a btf_dump_type_opts, pass it in the global dumper's option
btf_dump_opts:

  DECLARE_LIBBPF_OPTS(btf_dump_opts, opts);
  [...]
  opts.record_attrs_str = "ATTR_PRESERVE_ACCESS_INDEX";
  [...]
  d = btf_dump__new(btf, btf_dump_printf, NULL, &opts);
  [...]
  err = btf_dump__dump_type(d, root_type_ids[i]);

This would be less disruptive regarding library API, and an overall
simpler change.  But it would prevent to use the same btf dumper to
dump types with and without attribute definitions.  Not sure if that
matters much in practice.

Thoughts?

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/bpf/bpftool/btf.c  | 16 ++++++++++------
 tools/lib/bpf/btf.h      | 11 +++++++++++
 tools/lib/bpf/btf_dump.c | 21 +++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 4 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..e563b60fedd0 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -463,6 +463,7 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
 static int dump_btf_c(const struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt)
 {
+	DECLARE_LIBBPF_OPTS(btf_dump_type_opts, opts);
 	struct btf_dump *d;
 	int err = 0, i;
 
@@ -474,12 +475,17 @@ static int dump_btf_c(const struct btf *btf,
 	printf("#define __VMLINUX_H__\n");
 	printf("\n");
 	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-	printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
+	printf("#define ATTR_PRESERVE_ACCESS_INDEX __attribute__((preserve_access_index))\n");
+	printf("#else\n");
+	printf("#define ATTR_PRESERVE_ACCESS_INDEX\n");
 	printf("#endif\n\n");
+	printf("\n");
+
+	opts.record_attrs_str = "ATTR_PRESERVE_ACCESS_INDEX";
 
 	if (root_type_cnt) {
 		for (i = 0; i < root_type_cnt; i++) {
-			err = btf_dump__dump_type(d, root_type_ids[i]);
+			err = btf_dump__dump_type_with_opts(d, root_type_ids[i], &opts);
 			if (err)
 				goto done;
 		}
@@ -487,15 +493,13 @@ static int dump_btf_c(const struct btf *btf,
 		int cnt = btf__type_cnt(btf);
 
 		for (i = 1; i < cnt; i++) {
-			err = btf_dump__dump_type(d, i);
+			err = btf_dump__dump_type_with_opts(d, i, &opts);
 			if (err)
 				goto done;
 		}
 	}
 
-	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-	printf("#pragma clang attribute pop\n");
-	printf("#endif\n");
+	printf("#undef ATTR_PRESERVE_ACCESS_INDEX\n");
 	printf("\n");
 	printf("#endif /* __VMLINUX_H__ */\n");
 
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..802ec856f824 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -249,6 +249,17 @@ LIBBPF_API void btf_dump__free(struct btf_dump *d);
 
 LIBBPF_API int btf_dump__dump_type(struct btf_dump *d, __u32 id);
 
+struct btf_dump_type_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	const char *record_attrs_str;
+	size_t :0;
+};
+#define btf_dump_type_opts__last_field record_attrs_str
+
+LIBBPF_API int btf_dump__dump_type_with_opts(struct btf_dump *d, __u32 id,
+					     const struct btf_dump_type_opts *opts);
+
 struct btf_dump_emit_type_decl_opts {
 	/* size of this struct, for forward/backward compatiblity */
 	size_t sz;
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 5dbca76b953f..f4ef42d0b392 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -116,6 +116,11 @@ struct btf_dump {
 	 * data for typed display; allocated if needed.
 	 */
 	struct btf_dump_data *typed_dump;
+	/*
+	 * string with C attributes to be used in record
+	 * types.
+         */
+	const char *record_attrs_str;
 };
 
 static size_t str_hash_fn(long key, void *ctx)
@@ -296,6 +301,20 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
 	return 0;
 }
 
+/* This is like btf_dump__dump_type but it gets a set of options.  */
+int btf_dump__dump_type_with_opts(struct btf_dump *d, __u32 id,
+				  const struct btf_dump_type_opts *opts)
+{
+	int ret;
+
+	if (!OPTS_VALID(opts, btf_dump_type_opts))
+		return libbpf_err(-EINVAL);
+	d->record_attrs_str = OPTS_GET(opts, record_attrs_str, 0);
+	ret = btf_dump__dump_type(d, id);
+	d->record_attrs_str = NULL;
+	return ret;
+}
+
 /*
  * Mark all types that are referenced from any other type. This is used to
  * determine top-level anonymous enums that need to be emitted as an
@@ -1024,6 +1043,8 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 	}
 	if (packed)
 		btf_dump_printf(d, " __attribute__((packed))");
+	if (d->record_attrs_str)
+		btf_dump_printf(d, " %s", d->record_attrs_str);
 }
 
 static const char *missing_base_types[][2] = {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c1ce8aa3520b..9e56de31c5be 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -422,4 +422,5 @@ LIBBPF_1.5.0 {
 		bpf_program__attach_sockmap;
 		ring__consume_n;
 		ring_buffer__consume_n;
+		btf_dump__dump_type_with_opts;
 } LIBBPF_1.4.0;
-- 
2.30.2


